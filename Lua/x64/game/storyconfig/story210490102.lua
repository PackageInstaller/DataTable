return {
	Play1104902001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 1104902001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play1104902002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "ST06"

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
				local var_4_5 = arg_1_1.bgs_.ST06

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
					if iter_4_0 ~= "ST06" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = 1.999999999999

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
			local var_4_25 = 0.4

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

			local var_4_30 = 1
			local var_4_31 = 1

			if var_4_30 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 then
				local var_4_32 = "play"
				local var_4_33 = "music"

				arg_1_1:AudioAction(var_4_32, var_4_33, "bgm_side_daily02", "bgm_side_daily02", "bgm_side_daily02.awb")

				local var_4_34 = ""
				local var_4_35 = manager.audio:GetAudioName("bgm_side_daily02", "bgm_side_daily02")

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
			local var_4_37 = 0.9

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

				local var_4_39 = arg_1_1:GetWordFromCfg(1104902001)
				local var_4_40 = arg_1_1:FormatText(var_4_39.content)

				arg_1_1.text_.text = var_4_40

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_41 = 36
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
	Play1104902002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 1104902002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play1104902003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0
			local var_12_1 = 1.075

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

				local var_12_2 = arg_9_1:GetWordFromCfg(1104902002)
				local var_12_3 = arg_9_1:FormatText(var_12_2.content)

				arg_9_1.text_.text = var_12_3

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_4 = 43
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
	Play1104902003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 1104902003
		arg_13_1.duration_ = 2.27

		local var_13_0 = {
			zh = 1.933,
			ja = 2.266
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
				arg_13_0:Play1104902004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0
			local var_16_1 = 0.1

			if var_16_0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_2 = arg_13_1:FormatText(StoryNameCfg[1008].name)

				arg_13_1.leftNameTxt_.text = var_16_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, true)
				arg_13_1.iconController_:SetSelectedState("hero")

				arg_13_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10119")

				arg_13_1.callingController_:SetSelectedState("normal")

				arg_13_1.keyicon_.color = Color.New(1, 1, 1)
				arg_13_1.icon_.color = Color.New(1, 1, 1)

				local var_16_3 = arg_13_1:GetWordFromCfg(1104902003)
				local var_16_4 = arg_13_1:FormatText(var_16_3.content)

				arg_13_1.text_.text = var_16_4

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_5 = 4
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

				if manager.audio:GetVoiceLength("story_v_side_new_1104902", "1104902003", "story_v_side_new_1104902.awb") ~= 0 then
					local var_16_8 = manager.audio:GetVoiceLength("story_v_side_new_1104902", "1104902003", "story_v_side_new_1104902.awb") / 1000

					if var_16_8 + var_16_0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_8 + var_16_0
					end

					if var_16_3.prefab_name ~= "" and arg_13_1.actors_[var_16_3.prefab_name] ~= nil then
						local var_16_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_3.prefab_name].transform, "story_v_side_new_1104902", "1104902003", "story_v_side_new_1104902.awb")

						arg_13_1:RecordAudio("1104902003", var_16_9)
						arg_13_1:RecordAudio("1104902003", var_16_9)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_side_new_1104902", "1104902003", "story_v_side_new_1104902.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_side_new_1104902", "1104902003", "story_v_side_new_1104902.awb")
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
	Play1104902004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 1104902004
		arg_17_1.duration_ = 3.4

		local var_17_0 = {
			zh = 3.4,
			ja = 3.3
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
				arg_17_0:Play1104902005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0
			local var_20_1 = 0.2

			if var_20_0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_0 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_2 = arg_17_1:FormatText(StoryNameCfg[551].name)

				arg_17_1.leftNameTxt_.text = var_20_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, true)
				arg_17_1.iconController_:SetSelectedState("hero")

				arg_17_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1049")

				arg_17_1.callingController_:SetSelectedState("normal")

				arg_17_1.keyicon_.color = Color.New(1, 1, 1)
				arg_17_1.icon_.color = Color.New(1, 1, 1)

				local var_20_3 = arg_17_1:GetWordFromCfg(1104902004)
				local var_20_4 = arg_17_1:FormatText(var_20_3.content)

				arg_17_1.text_.text = var_20_4

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_5 = 8
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

				if manager.audio:GetVoiceLength("story_v_side_new_1104902", "1104902004", "story_v_side_new_1104902.awb") ~= 0 then
					local var_20_8 = manager.audio:GetVoiceLength("story_v_side_new_1104902", "1104902004", "story_v_side_new_1104902.awb") / 1000

					if var_20_8 + var_20_0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_8 + var_20_0
					end

					if var_20_3.prefab_name ~= "" and arg_17_1.actors_[var_20_3.prefab_name] ~= nil then
						local var_20_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_3.prefab_name].transform, "story_v_side_new_1104902", "1104902004", "story_v_side_new_1104902.awb")

						arg_17_1:RecordAudio("1104902004", var_20_9)
						arg_17_1:RecordAudio("1104902004", var_20_9)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_side_new_1104902", "1104902004", "story_v_side_new_1104902.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_side_new_1104902", "1104902004", "story_v_side_new_1104902.awb")
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
	Play1104902005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 1104902005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play1104902006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 0
			local var_24_1 = 1.05

			if var_24_0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_0 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, false)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_2 = arg_21_1:GetWordFromCfg(1104902005)
				local var_24_3 = arg_21_1:FormatText(var_24_2.content)

				arg_21_1.text_.text = var_24_3

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_4 = 44
				local var_24_5 = utf8.len(var_24_3)
				local var_24_6 = var_24_4 <= 0 and var_24_1 or var_24_1 * (var_24_5 / var_24_4)

				if var_24_6 > 0 and var_24_1 < var_24_6 then
					arg_21_1.talkMaxDuration = var_24_6

					if var_24_6 + var_24_0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_6 + var_24_0
					end
				end

				arg_21_1.text_.text = var_24_3
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)
				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_7 = math.max(var_24_1, arg_21_1.talkMaxDuration)

			if var_24_0 <= arg_21_1.time_ and arg_21_1.time_ < var_24_0 + var_24_7 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_0) / var_24_7

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_0 + var_24_7 and arg_21_1.time_ < var_24_0 + var_24_7 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play1104902006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 1104902006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play1104902007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 0
			local var_28_1 = 1.025

			if var_28_0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_0 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, false)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_2 = arg_25_1:GetWordFromCfg(1104902006)
				local var_28_3 = arg_25_1:FormatText(var_28_2.content)

				arg_25_1.text_.text = var_28_3

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_4 = 41
				local var_28_5 = utf8.len(var_28_3)
				local var_28_6 = var_28_4 <= 0 and var_28_1 or var_28_1 * (var_28_5 / var_28_4)

				if var_28_6 > 0 and var_28_1 < var_28_6 then
					arg_25_1.talkMaxDuration = var_28_6

					if var_28_6 + var_28_0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_6 + var_28_0
					end
				end

				arg_25_1.text_.text = var_28_3
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_7 = math.max(var_28_1, arg_25_1.talkMaxDuration)

			if var_28_0 <= arg_25_1.time_ and arg_25_1.time_ < var_28_0 + var_28_7 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_0) / var_28_7

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_0 + var_28_7 and arg_25_1.time_ < var_28_0 + var_28_7 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play1104902007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 1104902007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play1104902008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 0
			local var_32_1 = 0.275

			if var_32_0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_0 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_2 = arg_29_1:FormatText(StoryNameCfg[7].name)

				arg_29_1.leftNameTxt_.text = var_32_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, true)
				arg_29_1.iconController_:SetSelectedState("hero")

				arg_29_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_29_1.callingController_:SetSelectedState("normal")

				arg_29_1.keyicon_.color = Color.New(1, 1, 1)
				arg_29_1.icon_.color = Color.New(1, 1, 1)

				local var_32_3 = arg_29_1:GetWordFromCfg(1104902007)
				local var_32_4 = arg_29_1:FormatText(var_32_3.content)

				arg_29_1.text_.text = var_32_4

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_5 = 11
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
				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_8 = math.max(var_32_1, arg_29_1.talkMaxDuration)

			if var_32_0 <= arg_29_1.time_ and arg_29_1.time_ < var_32_0 + var_32_8 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_0) / var_32_8

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_0 + var_32_8 and arg_29_1.time_ < var_32_0 + var_32_8 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play1104902008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 1104902008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play1104902009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = 0
			local var_36_1 = 0.55

			if var_36_0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_0 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, false)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_2 = arg_33_1:GetWordFromCfg(1104902008)
				local var_36_3 = arg_33_1:FormatText(var_36_2.content)

				arg_33_1.text_.text = var_36_3

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_4 = 22
				local var_36_5 = utf8.len(var_36_3)
				local var_36_6 = var_36_4 <= 0 and var_36_1 or var_36_1 * (var_36_5 / var_36_4)

				if var_36_6 > 0 and var_36_1 < var_36_6 then
					arg_33_1.talkMaxDuration = var_36_6

					if var_36_6 + var_36_0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_6 + var_36_0
					end
				end

				arg_33_1.text_.text = var_36_3
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_7 = math.max(var_36_1, arg_33_1.talkMaxDuration)

			if var_36_0 <= arg_33_1.time_ and arg_33_1.time_ < var_36_0 + var_36_7 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_0) / var_36_7

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_0 + var_36_7 and arg_33_1.time_ < var_36_0 + var_36_7 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play1104902009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 1104902009
		arg_37_1.duration_ = 3.23

		local var_37_0 = {
			zh = 3.233,
			ja = 2.666
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
				arg_37_0:Play1104902010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = "1049ui_story"

			if arg_37_1.actors_[var_40_0] == nil then
				local var_40_1 = Asset.Load("Char/" .. "1049ui_story")

				if not isNil(var_40_1) then
					local var_40_2 = Object.Instantiate(Asset.Load("Char/" .. "1049ui_story"), arg_37_1.stage_.transform)

					var_40_2.name = var_40_0
					var_40_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_37_1.actors_[var_40_0] = var_40_2

					local var_40_3 = var_40_2:GetComponentInChildren(typeof(CharacterEffect))

					var_40_3.enabled = true

					local var_40_4 = GameObjectTools.GetOrAddComponent(var_40_2, typeof(DynamicBoneHelper))

					if var_40_4 then
						var_40_4:EnableDynamicBone(false)
					end

					arg_37_1:ShowWeapon(var_40_3.transform, false)

					arg_37_1.var_[var_40_0 .. "Animator"] = var_40_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_37_1.var_[var_40_0 .. "Animator"].applyRootMotion = true
					arg_37_1.var_[var_40_0 .. "LipSync"] = var_40_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_40_5 = arg_37_1.actors_["1049ui_story"].transform
			local var_40_6 = 0

			if var_40_6 < arg_37_1.time_ and arg_37_1.time_ <= var_40_6 + arg_40_0 then
				arg_37_1.var_.moveOldPos1049ui_story = var_40_5.localPosition
			end

			local var_40_7 = 0.001

			if var_40_6 <= arg_37_1.time_ and arg_37_1.time_ < var_40_6 + var_40_7 then
				local var_40_8 = (arg_37_1.time_ - var_40_6) / var_40_7
				local var_40_9 = Vector3.New(0, -1.2, -6)

				var_40_5.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos1049ui_story, var_40_9, var_40_8)

				local var_40_10 = manager.ui.mainCamera.transform.position - var_40_5.position

				var_40_5.forward = Vector3.New(var_40_10.x, var_40_10.y, var_40_10.z)

				local var_40_11 = var_40_5.localEulerAngles

				var_40_11.z = 0
				var_40_11.x = 0
				var_40_5.localEulerAngles = var_40_11
			end

			if arg_37_1.time_ >= var_40_6 + var_40_7 and arg_37_1.time_ < var_40_6 + var_40_7 + arg_40_0 then
				var_40_5.localPosition = Vector3.New(0, -1.2, -6)

				local var_40_12 = manager.ui.mainCamera.transform.position - var_40_5.position

				var_40_5.forward = Vector3.New(var_40_12.x, var_40_12.y, var_40_12.z)

				local var_40_13 = var_40_5.localEulerAngles

				var_40_13.z = 0
				var_40_13.x = 0
				var_40_5.localEulerAngles = var_40_13
			end

			local var_40_14 = arg_37_1.actors_["1049ui_story"]
			local var_40_15 = 0

			if var_40_15 < arg_37_1.time_ and arg_37_1.time_ <= var_40_15 + arg_40_0 and not isNil(var_40_14) and arg_37_1.var_.characterEffect1049ui_story == nil then
				arg_37_1.var_.characterEffect1049ui_story = var_40_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_16 = 0.200000002980232

			if var_40_15 <= arg_37_1.time_ and arg_37_1.time_ < var_40_15 + var_40_16 and not isNil(var_40_14) then
				local var_40_17 = (arg_37_1.time_ - var_40_15) / var_40_16

				if arg_37_1.var_.characterEffect1049ui_story and not isNil(var_40_14) then
					arg_37_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_37_1.time_ >= var_40_15 + var_40_16 and arg_37_1.time_ < var_40_15 + var_40_16 + arg_40_0 and not isNil(var_40_14) and arg_37_1.var_.characterEffect1049ui_story then
				arg_37_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_40_18 = 0

			if var_40_18 < arg_37_1.time_ and arg_37_1.time_ <= var_40_18 + arg_40_0 then
				arg_37_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action1_1")
			end

			local var_40_19 = 0

			if var_40_19 < arg_37_1.time_ and arg_37_1.time_ <= var_40_19 + arg_40_0 then
				arg_37_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_40_20 = 0
			local var_40_21 = 0.35

			if var_40_20 < arg_37_1.time_ and arg_37_1.time_ <= var_40_20 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_22 = arg_37_1:FormatText(StoryNameCfg[551].name)

				arg_37_1.leftNameTxt_.text = var_40_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_23 = arg_37_1:GetWordFromCfg(1104902009)
				local var_40_24 = arg_37_1:FormatText(var_40_23.content)

				arg_37_1.text_.text = var_40_24

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_25 = 14
				local var_40_26 = utf8.len(var_40_24)
				local var_40_27 = var_40_25 <= 0 and var_40_21 or var_40_21 * (var_40_26 / var_40_25)

				if var_40_27 > 0 and var_40_21 < var_40_27 then
					arg_37_1.talkMaxDuration = var_40_27

					if var_40_27 + var_40_20 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_27 + var_40_20
					end
				end

				arg_37_1.text_.text = var_40_24
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104902", "1104902009", "story_v_side_new_1104902.awb") ~= 0 then
					local var_40_28 = manager.audio:GetVoiceLength("story_v_side_new_1104902", "1104902009", "story_v_side_new_1104902.awb") / 1000

					if var_40_28 + var_40_20 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_28 + var_40_20
					end

					if var_40_23.prefab_name ~= "" and arg_37_1.actors_[var_40_23.prefab_name] ~= nil then
						local var_40_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_23.prefab_name].transform, "story_v_side_new_1104902", "1104902009", "story_v_side_new_1104902.awb")

						arg_37_1:RecordAudio("1104902009", var_40_29)
						arg_37_1:RecordAudio("1104902009", var_40_29)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_side_new_1104902", "1104902009", "story_v_side_new_1104902.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_side_new_1104902", "1104902009", "story_v_side_new_1104902.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_30 = math.max(var_40_21, arg_37_1.talkMaxDuration)

			if var_40_20 <= arg_37_1.time_ and arg_37_1.time_ < var_40_20 + var_40_30 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_20) / var_40_30

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_20 + var_40_30 and arg_37_1.time_ < var_40_20 + var_40_30 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_37_1:InitPlayNodeList()
	end,
	Play1104902010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 1104902010
		arg_41_1.duration_ = 1

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"

			SetActive(arg_41_1.choicesGo_, true)

			for iter_42_0, iter_42_1 in ipairs(arg_41_1.choices_) do
				local var_42_0 = iter_42_0 <= 2

				SetActive(iter_42_1.go, var_42_0)
			end

			arg_41_1.choices_[1].txt.text = arg_41_1:FormatText(StoryChoiceCfg[872].name)
			arg_41_1.choices_[2].txt.text = arg_41_1:FormatText(StoryChoiceCfg[873].name)
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play1104902011(arg_41_1)
			end

			if arg_43_0 == 2 then
				arg_41_0:Play1104902011(arg_41_1)
			end

			arg_41_1:RecordChoiceLog(1104902010, 872, 873)
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = arg_41_1.actors_["1049ui_story"]
			local var_44_1 = 0

			if var_44_1 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.characterEffect1049ui_story == nil then
				arg_41_1.var_.characterEffect1049ui_story = var_44_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_2 = 0.200000002980232

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_2 and not isNil(var_44_0) then
				local var_44_3 = (arg_41_1.time_ - var_44_1) / var_44_2

				if arg_41_1.var_.characterEffect1049ui_story and not isNil(var_44_0) then
					local var_44_4 = Mathf.Lerp(0, 0.5, var_44_3)

					arg_41_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_41_1.var_.characterEffect1049ui_story.fillRatio = var_44_4
				end
			end

			if arg_41_1.time_ >= var_44_1 + var_44_2 and arg_41_1.time_ < var_44_1 + var_44_2 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.characterEffect1049ui_story then
				local var_44_5 = 0.5

				arg_41_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_41_1.var_.characterEffect1049ui_story.fillRatio = var_44_5
			end

			local var_44_6 = 0

			if var_44_6 < arg_41_1.time_ and arg_41_1.time_ <= var_44_6 + arg_44_0 then
				arg_41_1.allBtn_.enabled = false
			end

			local var_44_7 = 0.6

			if arg_41_1.time_ >= var_44_6 + var_44_7 and arg_41_1.time_ < var_44_6 + var_44_7 + arg_44_0 then
				arg_41_1.allBtn_.enabled = true
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play1104902011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 1104902011
		arg_45_1.duration_ = 5

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play1104902012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = arg_45_1.actors_["1049ui_story"].transform
			local var_48_1 = 0

			if var_48_1 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 then
				arg_45_1.var_.moveOldPos1049ui_story = var_48_0.localPosition
			end

			local var_48_2 = 0.001

			if var_48_1 <= arg_45_1.time_ and arg_45_1.time_ < var_48_1 + var_48_2 then
				local var_48_3 = (arg_45_1.time_ - var_48_1) / var_48_2
				local var_48_4 = Vector3.New(0, 100, 0)

				var_48_0.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos1049ui_story, var_48_4, var_48_3)

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

			local var_48_9 = arg_45_1.actors_["1049ui_story"]
			local var_48_10 = 0

			if var_48_10 < arg_45_1.time_ and arg_45_1.time_ <= var_48_10 + arg_48_0 and not isNil(var_48_9) and arg_45_1.var_.characterEffect1049ui_story == nil then
				arg_45_1.var_.characterEffect1049ui_story = var_48_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_11 = 0.200000002980232

			if var_48_10 <= arg_45_1.time_ and arg_45_1.time_ < var_48_10 + var_48_11 and not isNil(var_48_9) then
				local var_48_12 = (arg_45_1.time_ - var_48_10) / var_48_11

				if arg_45_1.var_.characterEffect1049ui_story and not isNil(var_48_9) then
					local var_48_13 = Mathf.Lerp(0, 0.5, var_48_12)

					arg_45_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_45_1.var_.characterEffect1049ui_story.fillRatio = var_48_13
				end
			end

			if arg_45_1.time_ >= var_48_10 + var_48_11 and arg_45_1.time_ < var_48_10 + var_48_11 + arg_48_0 and not isNil(var_48_9) and arg_45_1.var_.characterEffect1049ui_story then
				local var_48_14 = 0.5

				arg_45_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_45_1.var_.characterEffect1049ui_story.fillRatio = var_48_14
			end

			local var_48_15 = 0
			local var_48_16 = 0.85

			if var_48_15 < arg_45_1.time_ and arg_45_1.time_ <= var_48_15 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, false)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_17 = arg_45_1:GetWordFromCfg(1104902011)
				local var_48_18 = arg_45_1:FormatText(var_48_17.content)

				arg_45_1.text_.text = var_48_18

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_19 = 34
				local var_48_20 = utf8.len(var_48_18)
				local var_48_21 = var_48_19 <= 0 and var_48_16 or var_48_16 * (var_48_20 / var_48_19)

				if var_48_21 > 0 and var_48_16 < var_48_21 then
					arg_45_1.talkMaxDuration = var_48_21

					if var_48_21 + var_48_15 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_21 + var_48_15
					end
				end

				arg_45_1.text_.text = var_48_18
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)
				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_22 = math.max(var_48_16, arg_45_1.talkMaxDuration)

			if var_48_15 <= arg_45_1.time_ and arg_45_1.time_ < var_48_15 + var_48_22 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_15) / var_48_22

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_15 + var_48_22 and arg_45_1.time_ < var_48_15 + var_48_22 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_45_1:InitPlayNodeList()
	end,
	Play1104902012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 1104902012
		arg_49_1.duration_ = 6.3

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play1104902013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = "STblack"

			if arg_49_1.bgs_[var_52_0] == nil then
				local var_52_1 = Object.Instantiate(arg_49_1.paintGo_)

				var_52_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_52_0)
				var_52_1.name = var_52_0
				var_52_1.transform.parent = arg_49_1.stage_.transform
				var_52_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_49_1.bgs_[var_52_0] = var_52_1
			end

			local var_52_2 = 0.3

			if var_52_2 < arg_49_1.time_ and arg_49_1.time_ <= var_52_2 + arg_52_0 then
				local var_52_3 = manager.ui.mainCamera.transform.localPosition
				local var_52_4 = Vector3.New(0, 0, 10) + Vector3.New(var_52_3.x, var_52_3.y, 0)
				local var_52_5 = arg_49_1.bgs_.STblack

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
					if iter_52_0 ~= "STblack" then
						iter_52_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_52_16 = 1.3

			if var_52_16 < arg_49_1.time_ and arg_49_1.time_ <= var_52_16 + arg_52_0 then
				arg_49_1.allBtn_.enabled = false
			end

			local var_52_17 = 0.3

			if arg_49_1.time_ >= var_52_16 + var_52_17 and arg_49_1.time_ < var_52_16 + var_52_17 + arg_52_0 then
				arg_49_1.allBtn_.enabled = true
			end

			local var_52_18 = 0.3

			if var_52_18 < arg_49_1.time_ and arg_49_1.time_ <= var_52_18 + arg_52_0 then
				arg_49_1.mask_.enabled = true
				arg_49_1.mask_.raycastTarget = true

				arg_49_1:SetGaussion(false)
			end

			local var_52_19 = 1

			if var_52_18 <= arg_49_1.time_ and arg_49_1.time_ < var_52_18 + var_52_19 then
				local var_52_20 = (arg_49_1.time_ - var_52_18) / var_52_19
				local var_52_21 = Color.New(1, 1, 1)

				var_52_21.a = Mathf.Lerp(1, 0, var_52_20)
				arg_49_1.mask_.color = var_52_21
			end

			if arg_49_1.time_ >= var_52_18 + var_52_19 and arg_49_1.time_ < var_52_18 + var_52_19 + arg_52_0 then
				local var_52_22 = Color.New(1, 1, 1)
				local var_52_23 = 0

				arg_49_1.mask_.enabled = false
				var_52_22.a = var_52_23
				arg_49_1.mask_.color = var_52_22
			end

			local var_52_24 = manager.ui.mainCamera.transform
			local var_52_25 = 0

			if var_52_25 < arg_49_1.time_ and arg_49_1.time_ <= var_52_25 + arg_52_0 then
				arg_49_1.var_.shakeOldPos = var_52_24.localPosition
			end

			local var_52_26 = 0.6

			if var_52_25 <= arg_49_1.time_ and arg_49_1.time_ < var_52_25 + var_52_26 then
				local var_52_27 = (arg_49_1.time_ - var_52_25) / 0.066
				local var_52_28, var_52_29 = math.modf(var_52_27)

				var_52_24.localPosition = Vector3.New(var_52_29 * 0.13, var_52_29 * 0.13, var_52_29 * 0.13) + arg_49_1.var_.shakeOldPos
			end

			if arg_49_1.time_ >= var_52_25 + var_52_26 and arg_49_1.time_ < var_52_25 + var_52_26 + arg_52_0 then
				var_52_24.localPosition = arg_49_1.var_.shakeOldPos
			end

			local var_52_30 = 0

			if var_52_30 < arg_49_1.time_ and arg_49_1.time_ <= var_52_30 + arg_52_0 then
				arg_49_1.allBtn_.enabled = false
			end

			local var_52_31 = 0.6

			if arg_49_1.time_ >= var_52_30 + var_52_31 and arg_49_1.time_ < var_52_30 + var_52_31 + arg_52_0 then
				arg_49_1.allBtn_.enabled = true
			end

			local var_52_32 = 0
			local var_52_33 = 1

			if var_52_32 < arg_49_1.time_ and arg_49_1.time_ <= var_52_32 + arg_52_0 then
				local var_52_34 = "play"
				local var_52_35 = "effect"

				arg_49_1:AudioAction(var_52_34, var_52_35, "se_story_side_1049", "se_story_side_1049_hug", "")
			end

			if arg_49_1.frameCnt_ <= 1 then
				arg_49_1.dialog_:SetActive(false)
			end

			local var_52_36 = 1.3
			local var_52_37 = 0.075

			if var_52_36 < arg_49_1.time_ and arg_49_1.time_ <= var_52_36 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0

				arg_49_1.dialog_:SetActive(true)

				arg_49_1.dialogCg_.alpha = 0

				local var_52_38 = LeanTween.value(arg_49_1.dialog_, 0, 1, 0.3)

				var_52_38:setOnUpdate(LuaHelper.FloatAction(function(arg_53_0)
					arg_49_1.dialogCg_.alpha = arg_53_0
				end))
				var_52_38:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_49_1.dialog_)
					var_52_38:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_49_1.duration_ = arg_49_1.duration_ + 0.3

				SetActive(arg_49_1.leftNameGo_, false)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_39 = arg_49_1:GetWordFromCfg(1104902012)
				local var_52_40 = arg_49_1:FormatText(var_52_39.content)

				arg_49_1.text_.text = var_52_40

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_41 = 3
				local var_52_42 = utf8.len(var_52_40)
				local var_52_43 = var_52_41 <= 0 and var_52_37 or var_52_37 * (var_52_42 / var_52_41)

				if var_52_43 > 0 and var_52_37 < var_52_43 then
					arg_49_1.talkMaxDuration = var_52_43
					var_52_36 = var_52_36 + 0.3

					if var_52_43 + var_52_36 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_43 + var_52_36
					end
				end

				arg_49_1.text_.text = var_52_40
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)
				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_44 = var_52_36 + 0.3
			local var_52_45 = math.max(var_52_37, arg_49_1.talkMaxDuration)

			if var_52_44 <= arg_49_1.time_ and arg_49_1.time_ < var_52_44 + var_52_45 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_44) / var_52_45

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_44 + var_52_45 and arg_49_1.time_ < var_52_44 + var_52_45 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play1104902013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 1104902013
		arg_55_1.duration_ = 5

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play1104902014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			local var_58_0 = 0
			local var_58_1 = 0.7

			if var_58_0 < arg_55_1.time_ and arg_55_1.time_ <= var_58_0 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, false)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_2 = arg_55_1:GetWordFromCfg(1104902013)
				local var_58_3 = arg_55_1:FormatText(var_58_2.content)

				arg_55_1.text_.text = var_58_3

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_4 = 28
				local var_58_5 = utf8.len(var_58_3)
				local var_58_6 = var_58_4 <= 0 and var_58_1 or var_58_1 * (var_58_5 / var_58_4)

				if var_58_6 > 0 and var_58_1 < var_58_6 then
					arg_55_1.talkMaxDuration = var_58_6

					if var_58_6 + var_58_0 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_6 + var_58_0
					end
				end

				arg_55_1.text_.text = var_58_3
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)
				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_7 = math.max(var_58_1, arg_55_1.talkMaxDuration)

			if var_58_0 <= arg_55_1.time_ and arg_55_1.time_ < var_58_0 + var_58_7 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_0) / var_58_7

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_0 + var_58_7 and arg_55_1.time_ < var_58_0 + var_58_7 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {}

		arg_55_1:InitPlayNodeList()
	end,
	Play1104902014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 1104902014
		arg_59_1.duration_ = 2.7

		local var_59_0 = {
			zh = 2.466,
			ja = 2.7
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
				arg_59_0:Play1104902015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			local var_62_0 = 0
			local var_62_1 = 0.05

			if var_62_0 < arg_59_1.time_ and arg_59_1.time_ <= var_62_0 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				local var_62_2 = arg_59_1:FormatText(StoryNameCfg[1008].name)

				arg_59_1.leftNameTxt_.text = var_62_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, true)
				arg_59_1.iconController_:SetSelectedState("hero")

				arg_59_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10119")

				arg_59_1.callingController_:SetSelectedState("normal")

				arg_59_1.keyicon_.color = Color.New(1, 1, 1)
				arg_59_1.icon_.color = Color.New(1, 1, 1)

				local var_62_3 = arg_59_1:GetWordFromCfg(1104902014)
				local var_62_4 = arg_59_1:FormatText(var_62_3.content)

				arg_59_1.text_.text = var_62_4

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_5 = 2
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

				if manager.audio:GetVoiceLength("story_v_side_new_1104902", "1104902014", "story_v_side_new_1104902.awb") ~= 0 then
					local var_62_8 = manager.audio:GetVoiceLength("story_v_side_new_1104902", "1104902014", "story_v_side_new_1104902.awb") / 1000

					if var_62_8 + var_62_0 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_8 + var_62_0
					end

					if var_62_3.prefab_name ~= "" and arg_59_1.actors_[var_62_3.prefab_name] ~= nil then
						local var_62_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_59_1.actors_[var_62_3.prefab_name].transform, "story_v_side_new_1104902", "1104902014", "story_v_side_new_1104902.awb")

						arg_59_1:RecordAudio("1104902014", var_62_9)
						arg_59_1:RecordAudio("1104902014", var_62_9)
					else
						arg_59_1:AudioAction("play", "voice", "story_v_side_new_1104902", "1104902014", "story_v_side_new_1104902.awb")
					end

					arg_59_1:RecordHistoryTalkVoice("story_v_side_new_1104902", "1104902014", "story_v_side_new_1104902.awb")
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
	Play1104902015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 1104902015
		arg_63_1.duration_ = 5

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play1104902016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			local var_66_0 = 0
			local var_66_1 = 1.275

			if var_66_0 < arg_63_1.time_ and arg_63_1.time_ <= var_66_0 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, false)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_2 = arg_63_1:GetWordFromCfg(1104902015)
				local var_66_3 = arg_63_1:FormatText(var_66_2.content)

				arg_63_1.text_.text = var_66_3

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_4 = 51
				local var_66_5 = utf8.len(var_66_3)
				local var_66_6 = var_66_4 <= 0 and var_66_1 or var_66_1 * (var_66_5 / var_66_4)

				if var_66_6 > 0 and var_66_1 < var_66_6 then
					arg_63_1.talkMaxDuration = var_66_6

					if var_66_6 + var_66_0 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_6 + var_66_0
					end
				end

				arg_63_1.text_.text = var_66_3
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)
				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_7 = math.max(var_66_1, arg_63_1.talkMaxDuration)

			if var_66_0 <= arg_63_1.time_ and arg_63_1.time_ < var_66_0 + var_66_7 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_0) / var_66_7

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_0 + var_66_7 and arg_63_1.time_ < var_66_0 + var_66_7 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {}

		arg_63_1:InitPlayNodeList()
	end,
	Play1104902016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 1104902016
		arg_67_1.duration_ = 7

		SetActive(arg_67_1.tipsGo_, false)

		function arg_67_1.onSingleLineFinish_()
			arg_67_1.onSingleLineUpdate_ = nil
			arg_67_1.onSingleLineFinish_ = nil
			arg_67_1.state_ = "waiting"
		end

		function arg_67_1.playNext_(arg_69_0)
			if arg_69_0 == 1 then
				arg_67_0:Play1104902017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = 0

			if var_70_0 < arg_67_1.time_ and arg_67_1.time_ <= var_70_0 + arg_70_0 then
				local var_70_1 = manager.ui.mainCamera.transform.localPosition
				local var_70_2 = Vector3.New(0, 0, 10) + Vector3.New(var_70_1.x, var_70_1.y, 0)
				local var_70_3 = arg_67_1.bgs_.ST06

				var_70_3.transform.localPosition = var_70_2
				var_70_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_70_4 = var_70_3:GetComponent("SpriteRenderer")

				if var_70_4 and var_70_4.sprite then
					local var_70_5 = (var_70_3.transform.localPosition - var_70_1).z
					local var_70_6 = manager.ui.mainCameraCom_
					local var_70_7 = 2 * var_70_5 * Mathf.Tan(var_70_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_70_8 = var_70_7 * var_70_6.aspect
					local var_70_9 = var_70_4.sprite.bounds.size.x
					local var_70_10 = var_70_4.sprite.bounds.size.y
					local var_70_11 = var_70_8 / var_70_9
					local var_70_12 = var_70_7 / var_70_10
					local var_70_13 = var_70_12 < var_70_11 and var_70_11 or var_70_12

					var_70_3.transform.localScale = Vector3.New(var_70_13, var_70_13, 0)
				end

				for iter_70_0, iter_70_1 in pairs(arg_67_1.bgs_) do
					if iter_70_0 ~= "ST06" then
						iter_70_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_70_14 = 2

			if var_70_14 < arg_67_1.time_ and arg_67_1.time_ <= var_70_14 + arg_70_0 then
				arg_67_1.allBtn_.enabled = false
			end

			local var_70_15 = 0.3

			if arg_67_1.time_ >= var_70_14 + var_70_15 and arg_67_1.time_ < var_70_14 + var_70_15 + arg_70_0 then
				arg_67_1.allBtn_.enabled = true
			end

			local var_70_16 = 0

			if var_70_16 < arg_67_1.time_ and arg_67_1.time_ <= var_70_16 + arg_70_0 then
				arg_67_1.mask_.enabled = true
				arg_67_1.mask_.raycastTarget = true

				arg_67_1:SetGaussion(false)
			end

			local var_70_17 = 2

			if var_70_16 <= arg_67_1.time_ and arg_67_1.time_ < var_70_16 + var_70_17 then
				local var_70_18 = (arg_67_1.time_ - var_70_16) / var_70_17
				local var_70_19 = Color.New(0, 0, 0)

				var_70_19.a = Mathf.Lerp(1, 0, var_70_18)
				arg_67_1.mask_.color = var_70_19
			end

			if arg_67_1.time_ >= var_70_16 + var_70_17 and arg_67_1.time_ < var_70_16 + var_70_17 + arg_70_0 then
				local var_70_20 = Color.New(0, 0, 0)
				local var_70_21 = 0

				arg_67_1.mask_.enabled = false
				var_70_20.a = var_70_21
				arg_67_1.mask_.color = var_70_20
			end

			if arg_67_1.frameCnt_ <= 1 then
				arg_67_1.dialog_:SetActive(false)
			end

			local var_70_22 = 2
			local var_70_23 = 0.15

			if var_70_22 < arg_67_1.time_ and arg_67_1.time_ <= var_70_22 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0

				arg_67_1.dialog_:SetActive(true)

				arg_67_1.dialogCg_.alpha = 0

				local var_70_24 = LeanTween.value(arg_67_1.dialog_, 0, 1, 0.3)

				var_70_24:setOnUpdate(LuaHelper.FloatAction(function(arg_71_0)
					arg_67_1.dialogCg_.alpha = arg_71_0
				end))
				var_70_24:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_67_1.dialog_)
					var_70_24:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_67_1.duration_ = arg_67_1.duration_ + 0.3

				SetActive(arg_67_1.leftNameGo_, false)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_25 = arg_67_1:GetWordFromCfg(1104902016)
				local var_70_26 = arg_67_1:FormatText(var_70_25.content)

				arg_67_1.text_.text = var_70_26

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_27 = 6
				local var_70_28 = utf8.len(var_70_26)
				local var_70_29 = var_70_27 <= 0 and var_70_23 or var_70_23 * (var_70_28 / var_70_27)

				if var_70_29 > 0 and var_70_23 < var_70_29 then
					arg_67_1.talkMaxDuration = var_70_29
					var_70_22 = var_70_22 + 0.3

					if var_70_29 + var_70_22 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_29 + var_70_22
					end
				end

				arg_67_1.text_.text = var_70_26
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)
				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_30 = var_70_22 + 0.3
			local var_70_31 = math.max(var_70_23, arg_67_1.talkMaxDuration)

			if var_70_30 <= arg_67_1.time_ and arg_67_1.time_ < var_70_30 + var_70_31 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_30) / var_70_31

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_30 + var_70_31 and arg_67_1.time_ < var_70_30 + var_70_31 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {}

		arg_67_1:InitPlayNodeList()
	end,
	Play1104902017 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 1104902017
		arg_73_1.duration_ = 5

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play1104902018(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = 0
			local var_76_1 = 0.725

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

				local var_76_2 = arg_73_1:GetWordFromCfg(1104902017)
				local var_76_3 = arg_73_1:FormatText(var_76_2.content)

				arg_73_1.text_.text = var_76_3

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_4 = 29
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
	Play1104902018 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 1104902018
		arg_77_1.duration_ = 5

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play1104902019(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = 0
			local var_80_1 = 0.85

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

				local var_80_2 = arg_77_1:GetWordFromCfg(1104902018)
				local var_80_3 = arg_77_1:FormatText(var_80_2.content)

				arg_77_1.text_.text = var_80_3

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_4 = 34
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
	Play1104902019 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 1104902019
		arg_81_1.duration_ = 5

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play1104902020(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = 0
			local var_84_1 = 0.825

			if var_84_0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_0 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, false)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_2 = arg_81_1:GetWordFromCfg(1104902019)
				local var_84_3 = arg_81_1:FormatText(var_84_2.content)

				arg_81_1.text_.text = var_84_3

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_4 = 33
				local var_84_5 = utf8.len(var_84_3)
				local var_84_6 = var_84_4 <= 0 and var_84_1 or var_84_1 * (var_84_5 / var_84_4)

				if var_84_6 > 0 and var_84_1 < var_84_6 then
					arg_81_1.talkMaxDuration = var_84_6

					if var_84_6 + var_84_0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_6 + var_84_0
					end
				end

				arg_81_1.text_.text = var_84_3
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)
				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_7 = math.max(var_84_1, arg_81_1.talkMaxDuration)

			if var_84_0 <= arg_81_1.time_ and arg_81_1.time_ < var_84_0 + var_84_7 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_0) / var_84_7

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_0 + var_84_7 and arg_81_1.time_ < var_84_0 + var_84_7 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play1104902020 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 1104902020
		arg_85_1.duration_ = 1.53

		local var_85_0 = {
			zh = 1.4,
			ja = 1.533
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
				arg_85_0:Play1104902021(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = 0
			local var_88_1 = 0.075

			if var_88_0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_0 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				local var_88_2 = arg_85_1:FormatText(StoryNameCfg[1008].name)

				arg_85_1.leftNameTxt_.text = var_88_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, true)
				arg_85_1.iconController_:SetSelectedState("hero")

				arg_85_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10119")

				arg_85_1.callingController_:SetSelectedState("normal")

				arg_85_1.keyicon_.color = Color.New(1, 1, 1)
				arg_85_1.icon_.color = Color.New(1, 1, 1)

				local var_88_3 = arg_85_1:GetWordFromCfg(1104902020)
				local var_88_4 = arg_85_1:FormatText(var_88_3.content)

				arg_85_1.text_.text = var_88_4

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_5 = 3
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

				if manager.audio:GetVoiceLength("story_v_side_new_1104902", "1104902020", "story_v_side_new_1104902.awb") ~= 0 then
					local var_88_8 = manager.audio:GetVoiceLength("story_v_side_new_1104902", "1104902020", "story_v_side_new_1104902.awb") / 1000

					if var_88_8 + var_88_0 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_8 + var_88_0
					end

					if var_88_3.prefab_name ~= "" and arg_85_1.actors_[var_88_3.prefab_name] ~= nil then
						local var_88_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_3.prefab_name].transform, "story_v_side_new_1104902", "1104902020", "story_v_side_new_1104902.awb")

						arg_85_1:RecordAudio("1104902020", var_88_9)
						arg_85_1:RecordAudio("1104902020", var_88_9)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_side_new_1104902", "1104902020", "story_v_side_new_1104902.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_side_new_1104902", "1104902020", "story_v_side_new_1104902.awb")
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
	Play1104902021 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 1104902021
		arg_89_1.duration_ = 5

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play1104902022(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = 0
			local var_92_1 = 0.325

			if var_92_0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_0 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				local var_92_2 = arg_89_1:FormatText(StoryNameCfg[7].name)

				arg_89_1.leftNameTxt_.text = var_92_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, true)
				arg_89_1.iconController_:SetSelectedState("hero")

				arg_89_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_89_1.callingController_:SetSelectedState("normal")

				arg_89_1.keyicon_.color = Color.New(1, 1, 1)
				arg_89_1.icon_.color = Color.New(1, 1, 1)

				local var_92_3 = arg_89_1:GetWordFromCfg(1104902021)
				local var_92_4 = arg_89_1:FormatText(var_92_3.content)

				arg_89_1.text_.text = var_92_4

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_5 = 13
				local var_92_6 = utf8.len(var_92_4)
				local var_92_7 = var_92_5 <= 0 and var_92_1 or var_92_1 * (var_92_6 / var_92_5)

				if var_92_7 > 0 and var_92_1 < var_92_7 then
					arg_89_1.talkMaxDuration = var_92_7

					if var_92_7 + var_92_0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_7 + var_92_0
					end
				end

				arg_89_1.text_.text = var_92_4
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)
				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_8 = math.max(var_92_1, arg_89_1.talkMaxDuration)

			if var_92_0 <= arg_89_1.time_ and arg_89_1.time_ < var_92_0 + var_92_8 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_0) / var_92_8

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_0 + var_92_8 and arg_89_1.time_ < var_92_0 + var_92_8 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play1104902022 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 1104902022
		arg_93_1.duration_ = 4.3

		local var_93_0 = {
			zh = 2.4,
			ja = 4.3
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
				arg_93_0:Play1104902023(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = arg_93_1.actors_["1049ui_story"].transform
			local var_96_1 = 0

			if var_96_1 < arg_93_1.time_ and arg_93_1.time_ <= var_96_1 + arg_96_0 then
				arg_93_1.var_.moveOldPos1049ui_story = var_96_0.localPosition
			end

			local var_96_2 = 0.001

			if var_96_1 <= arg_93_1.time_ and arg_93_1.time_ < var_96_1 + var_96_2 then
				local var_96_3 = (arg_93_1.time_ - var_96_1) / var_96_2
				local var_96_4 = Vector3.New(0, -1.2, -6)

				var_96_0.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos1049ui_story, var_96_4, var_96_3)

				local var_96_5 = manager.ui.mainCamera.transform.position - var_96_0.position

				var_96_0.forward = Vector3.New(var_96_5.x, var_96_5.y, var_96_5.z)

				local var_96_6 = var_96_0.localEulerAngles

				var_96_6.z = 0
				var_96_6.x = 0
				var_96_0.localEulerAngles = var_96_6
			end

			if arg_93_1.time_ >= var_96_1 + var_96_2 and arg_93_1.time_ < var_96_1 + var_96_2 + arg_96_0 then
				var_96_0.localPosition = Vector3.New(0, -1.2, -6)

				local var_96_7 = manager.ui.mainCamera.transform.position - var_96_0.position

				var_96_0.forward = Vector3.New(var_96_7.x, var_96_7.y, var_96_7.z)

				local var_96_8 = var_96_0.localEulerAngles

				var_96_8.z = 0
				var_96_8.x = 0
				var_96_0.localEulerAngles = var_96_8
			end

			local var_96_9 = arg_93_1.actors_["1049ui_story"]
			local var_96_10 = 0

			if var_96_10 < arg_93_1.time_ and arg_93_1.time_ <= var_96_10 + arg_96_0 and not isNil(var_96_9) and arg_93_1.var_.characterEffect1049ui_story == nil then
				arg_93_1.var_.characterEffect1049ui_story = var_96_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_11 = 0.200000002980232

			if var_96_10 <= arg_93_1.time_ and arg_93_1.time_ < var_96_10 + var_96_11 and not isNil(var_96_9) then
				local var_96_12 = (arg_93_1.time_ - var_96_10) / var_96_11

				if arg_93_1.var_.characterEffect1049ui_story and not isNil(var_96_9) then
					arg_93_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_93_1.time_ >= var_96_10 + var_96_11 and arg_93_1.time_ < var_96_10 + var_96_11 + arg_96_0 and not isNil(var_96_9) and arg_93_1.var_.characterEffect1049ui_story then
				arg_93_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_96_13 = 0

			if var_96_13 < arg_93_1.time_ and arg_93_1.time_ <= var_96_13 + arg_96_0 then
				arg_93_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action2_1")
			end

			local var_96_14 = 0

			if var_96_14 < arg_93_1.time_ and arg_93_1.time_ <= var_96_14 + arg_96_0 then
				arg_93_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_96_15 = 0
			local var_96_16 = 0.275

			if var_96_15 < arg_93_1.time_ and arg_93_1.time_ <= var_96_15 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				local var_96_17 = arg_93_1:FormatText(StoryNameCfg[551].name)

				arg_93_1.leftNameTxt_.text = var_96_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_18 = arg_93_1:GetWordFromCfg(1104902022)
				local var_96_19 = arg_93_1:FormatText(var_96_18.content)

				arg_93_1.text_.text = var_96_19

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_20 = 11
				local var_96_21 = utf8.len(var_96_19)
				local var_96_22 = var_96_20 <= 0 and var_96_16 or var_96_16 * (var_96_21 / var_96_20)

				if var_96_22 > 0 and var_96_16 < var_96_22 then
					arg_93_1.talkMaxDuration = var_96_22

					if var_96_22 + var_96_15 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_22 + var_96_15
					end
				end

				arg_93_1.text_.text = var_96_19
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104902", "1104902022", "story_v_side_new_1104902.awb") ~= 0 then
					local var_96_23 = manager.audio:GetVoiceLength("story_v_side_new_1104902", "1104902022", "story_v_side_new_1104902.awb") / 1000

					if var_96_23 + var_96_15 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_23 + var_96_15
					end

					if var_96_18.prefab_name ~= "" and arg_93_1.actors_[var_96_18.prefab_name] ~= nil then
						local var_96_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_18.prefab_name].transform, "story_v_side_new_1104902", "1104902022", "story_v_side_new_1104902.awb")

						arg_93_1:RecordAudio("1104902022", var_96_24)
						arg_93_1:RecordAudio("1104902022", var_96_24)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_side_new_1104902", "1104902022", "story_v_side_new_1104902.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_side_new_1104902", "1104902022", "story_v_side_new_1104902.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_25 = math.max(var_96_16, arg_93_1.talkMaxDuration)

			if var_96_15 <= arg_93_1.time_ and arg_93_1.time_ < var_96_15 + var_96_25 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_15) / var_96_25

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_15 + var_96_25 and arg_93_1.time_ < var_96_15 + var_96_25 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_93_1:InitPlayNodeList()
	end,
	Play1104902023 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 1104902023
		arg_97_1.duration_ = 5

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play1104902024(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = arg_97_1.actors_["1049ui_story"]
			local var_100_1 = 0

			if var_100_1 < arg_97_1.time_ and arg_97_1.time_ <= var_100_1 + arg_100_0 and not isNil(var_100_0) and arg_97_1.var_.characterEffect1049ui_story == nil then
				arg_97_1.var_.characterEffect1049ui_story = var_100_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_2 = 0.200000002980232

			if var_100_1 <= arg_97_1.time_ and arg_97_1.time_ < var_100_1 + var_100_2 and not isNil(var_100_0) then
				local var_100_3 = (arg_97_1.time_ - var_100_1) / var_100_2

				if arg_97_1.var_.characterEffect1049ui_story and not isNil(var_100_0) then
					local var_100_4 = Mathf.Lerp(0, 0.5, var_100_3)

					arg_97_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_97_1.var_.characterEffect1049ui_story.fillRatio = var_100_4
				end
			end

			if arg_97_1.time_ >= var_100_1 + var_100_2 and arg_97_1.time_ < var_100_1 + var_100_2 + arg_100_0 and not isNil(var_100_0) and arg_97_1.var_.characterEffect1049ui_story then
				local var_100_5 = 0.5

				arg_97_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_97_1.var_.characterEffect1049ui_story.fillRatio = var_100_5
			end

			local var_100_6 = 0
			local var_100_7 = 0.125

			if var_100_6 < arg_97_1.time_ and arg_97_1.time_ <= var_100_6 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				local var_100_8 = arg_97_1:FormatText(StoryNameCfg[7].name)

				arg_97_1.leftNameTxt_.text = var_100_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, true)
				arg_97_1.iconController_:SetSelectedState("hero")

				arg_97_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_97_1.callingController_:SetSelectedState("normal")

				arg_97_1.keyicon_.color = Color.New(1, 1, 1)
				arg_97_1.icon_.color = Color.New(1, 1, 1)

				local var_100_9 = arg_97_1:GetWordFromCfg(1104902023)
				local var_100_10 = arg_97_1:FormatText(var_100_9.content)

				arg_97_1.text_.text = var_100_10

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_11 = 5
				local var_100_12 = utf8.len(var_100_10)
				local var_100_13 = var_100_11 <= 0 and var_100_7 or var_100_7 * (var_100_12 / var_100_11)

				if var_100_13 > 0 and var_100_7 < var_100_13 then
					arg_97_1.talkMaxDuration = var_100_13

					if var_100_13 + var_100_6 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_13 + var_100_6
					end
				end

				arg_97_1.text_.text = var_100_10
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)
				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_14 = math.max(var_100_7, arg_97_1.talkMaxDuration)

			if var_100_6 <= arg_97_1.time_ and arg_97_1.time_ < var_100_6 + var_100_14 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_6) / var_100_14

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_6 + var_100_14 and arg_97_1.time_ < var_100_6 + var_100_14 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play1104902024 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 1104902024
		arg_101_1.duration_ = 4.53

		local var_101_0 = {
			zh = 3.766,
			ja = 4.533
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
				arg_101_0:Play1104902025(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = arg_101_1.actors_["1049ui_story"].transform
			local var_104_1 = 0

			if var_104_1 < arg_101_1.time_ and arg_101_1.time_ <= var_104_1 + arg_104_0 then
				arg_101_1.var_.moveOldPos1049ui_story = var_104_0.localPosition
			end

			local var_104_2 = 0.001

			if var_104_1 <= arg_101_1.time_ and arg_101_1.time_ < var_104_1 + var_104_2 then
				local var_104_3 = (arg_101_1.time_ - var_104_1) / var_104_2
				local var_104_4 = Vector3.New(0, -1.2, -6)

				var_104_0.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos1049ui_story, var_104_4, var_104_3)

				local var_104_5 = manager.ui.mainCamera.transform.position - var_104_0.position

				var_104_0.forward = Vector3.New(var_104_5.x, var_104_5.y, var_104_5.z)

				local var_104_6 = var_104_0.localEulerAngles

				var_104_6.z = 0
				var_104_6.x = 0
				var_104_0.localEulerAngles = var_104_6
			end

			if arg_101_1.time_ >= var_104_1 + var_104_2 and arg_101_1.time_ < var_104_1 + var_104_2 + arg_104_0 then
				var_104_0.localPosition = Vector3.New(0, -1.2, -6)

				local var_104_7 = manager.ui.mainCamera.transform.position - var_104_0.position

				var_104_0.forward = Vector3.New(var_104_7.x, var_104_7.y, var_104_7.z)

				local var_104_8 = var_104_0.localEulerAngles

				var_104_8.z = 0
				var_104_8.x = 0
				var_104_0.localEulerAngles = var_104_8
			end

			local var_104_9 = arg_101_1.actors_["1049ui_story"]
			local var_104_10 = 0

			if var_104_10 < arg_101_1.time_ and arg_101_1.time_ <= var_104_10 + arg_104_0 and not isNil(var_104_9) and arg_101_1.var_.characterEffect1049ui_story == nil then
				arg_101_1.var_.characterEffect1049ui_story = var_104_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_11 = 0.200000002980232

			if var_104_10 <= arg_101_1.time_ and arg_101_1.time_ < var_104_10 + var_104_11 and not isNil(var_104_9) then
				local var_104_12 = (arg_101_1.time_ - var_104_10) / var_104_11

				if arg_101_1.var_.characterEffect1049ui_story and not isNil(var_104_9) then
					arg_101_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_101_1.time_ >= var_104_10 + var_104_11 and arg_101_1.time_ < var_104_10 + var_104_11 + arg_104_0 and not isNil(var_104_9) and arg_101_1.var_.characterEffect1049ui_story then
				arg_101_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_104_13 = 0

			if var_104_13 < arg_101_1.time_ and arg_101_1.time_ <= var_104_13 + arg_104_0 then
				arg_101_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action2_2")
			end

			local var_104_14 = 0

			if var_104_14 < arg_101_1.time_ and arg_101_1.time_ <= var_104_14 + arg_104_0 then
				arg_101_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_104_15 = 0
			local var_104_16 = 0.375

			if var_104_15 < arg_101_1.time_ and arg_101_1.time_ <= var_104_15 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				local var_104_17 = arg_101_1:FormatText(StoryNameCfg[551].name)

				arg_101_1.leftNameTxt_.text = var_104_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_18 = arg_101_1:GetWordFromCfg(1104902024)
				local var_104_19 = arg_101_1:FormatText(var_104_18.content)

				arg_101_1.text_.text = var_104_19

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_20 = 15
				local var_104_21 = utf8.len(var_104_19)
				local var_104_22 = var_104_20 <= 0 and var_104_16 or var_104_16 * (var_104_21 / var_104_20)

				if var_104_22 > 0 and var_104_16 < var_104_22 then
					arg_101_1.talkMaxDuration = var_104_22

					if var_104_22 + var_104_15 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_22 + var_104_15
					end
				end

				arg_101_1.text_.text = var_104_19
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104902", "1104902024", "story_v_side_new_1104902.awb") ~= 0 then
					local var_104_23 = manager.audio:GetVoiceLength("story_v_side_new_1104902", "1104902024", "story_v_side_new_1104902.awb") / 1000

					if var_104_23 + var_104_15 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_23 + var_104_15
					end

					if var_104_18.prefab_name ~= "" and arg_101_1.actors_[var_104_18.prefab_name] ~= nil then
						local var_104_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_18.prefab_name].transform, "story_v_side_new_1104902", "1104902024", "story_v_side_new_1104902.awb")

						arg_101_1:RecordAudio("1104902024", var_104_24)
						arg_101_1:RecordAudio("1104902024", var_104_24)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_side_new_1104902", "1104902024", "story_v_side_new_1104902.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_side_new_1104902", "1104902024", "story_v_side_new_1104902.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_25 = math.max(var_104_16, arg_101_1.talkMaxDuration)

			if var_104_15 <= arg_101_1.time_ and arg_101_1.time_ < var_104_15 + var_104_25 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_15) / var_104_25

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_15 + var_104_25 and arg_101_1.time_ < var_104_15 + var_104_25 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_101_1:InitPlayNodeList()
	end,
	Play1104902025 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 1104902025
		arg_105_1.duration_ = 1.97

		local var_105_0 = {
			zh = 1.966,
			ja = 1.1
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
				arg_105_0:Play1104902026(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = arg_105_1.actors_["1049ui_story"]
			local var_108_1 = 0

			if var_108_1 < arg_105_1.time_ and arg_105_1.time_ <= var_108_1 + arg_108_0 and not isNil(var_108_0) and arg_105_1.var_.characterEffect1049ui_story == nil then
				arg_105_1.var_.characterEffect1049ui_story = var_108_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_2 = 0.200000002980232

			if var_108_1 <= arg_105_1.time_ and arg_105_1.time_ < var_108_1 + var_108_2 and not isNil(var_108_0) then
				local var_108_3 = (arg_105_1.time_ - var_108_1) / var_108_2

				if arg_105_1.var_.characterEffect1049ui_story and not isNil(var_108_0) then
					local var_108_4 = Mathf.Lerp(0, 0.5, var_108_3)

					arg_105_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_105_1.var_.characterEffect1049ui_story.fillRatio = var_108_4
				end
			end

			if arg_105_1.time_ >= var_108_1 + var_108_2 and arg_105_1.time_ < var_108_1 + var_108_2 + arg_108_0 and not isNil(var_108_0) and arg_105_1.var_.characterEffect1049ui_story then
				local var_108_5 = 0.5

				arg_105_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_105_1.var_.characterEffect1049ui_story.fillRatio = var_108_5
			end

			local var_108_6 = 0
			local var_108_7 = 0.15

			if var_108_6 < arg_105_1.time_ and arg_105_1.time_ <= var_108_6 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				local var_108_8 = arg_105_1:FormatText(StoryNameCfg[1008].name)

				arg_105_1.leftNameTxt_.text = var_108_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, true)
				arg_105_1.iconController_:SetSelectedState("hero")

				arg_105_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10119")

				arg_105_1.callingController_:SetSelectedState("normal")

				arg_105_1.keyicon_.color = Color.New(1, 1, 1)
				arg_105_1.icon_.color = Color.New(1, 1, 1)

				local var_108_9 = arg_105_1:GetWordFromCfg(1104902025)
				local var_108_10 = arg_105_1:FormatText(var_108_9.content)

				arg_105_1.text_.text = var_108_10

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_11 = 6
				local var_108_12 = utf8.len(var_108_10)
				local var_108_13 = var_108_11 <= 0 and var_108_7 or var_108_7 * (var_108_12 / var_108_11)

				if var_108_13 > 0 and var_108_7 < var_108_13 then
					arg_105_1.talkMaxDuration = var_108_13

					if var_108_13 + var_108_6 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_13 + var_108_6
					end
				end

				arg_105_1.text_.text = var_108_10
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104902", "1104902025", "story_v_side_new_1104902.awb") ~= 0 then
					local var_108_14 = manager.audio:GetVoiceLength("story_v_side_new_1104902", "1104902025", "story_v_side_new_1104902.awb") / 1000

					if var_108_14 + var_108_6 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_14 + var_108_6
					end

					if var_108_9.prefab_name ~= "" and arg_105_1.actors_[var_108_9.prefab_name] ~= nil then
						local var_108_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_9.prefab_name].transform, "story_v_side_new_1104902", "1104902025", "story_v_side_new_1104902.awb")

						arg_105_1:RecordAudio("1104902025", var_108_15)
						arg_105_1:RecordAudio("1104902025", var_108_15)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_side_new_1104902", "1104902025", "story_v_side_new_1104902.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_side_new_1104902", "1104902025", "story_v_side_new_1104902.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_16 = math.max(var_108_7, arg_105_1.talkMaxDuration)

			if var_108_6 <= arg_105_1.time_ and arg_105_1.time_ < var_108_6 + var_108_16 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_6) / var_108_16

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_6 + var_108_16 and arg_105_1.time_ < var_108_6 + var_108_16 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play1104902026 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 1104902026
		arg_109_1.duration_ = 8.5

		local var_109_0 = {
			zh = 6.1,
			ja = 8.5
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
				arg_109_0:Play1104902027(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = arg_109_1.actors_["1049ui_story"].transform
			local var_112_1 = 0

			if var_112_1 < arg_109_1.time_ and arg_109_1.time_ <= var_112_1 + arg_112_0 then
				arg_109_1.var_.moveOldPos1049ui_story = var_112_0.localPosition
			end

			local var_112_2 = 0.001

			if var_112_1 <= arg_109_1.time_ and arg_109_1.time_ < var_112_1 + var_112_2 then
				local var_112_3 = (arg_109_1.time_ - var_112_1) / var_112_2
				local var_112_4 = Vector3.New(0, -1.2, -6)

				var_112_0.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos1049ui_story, var_112_4, var_112_3)

				local var_112_5 = manager.ui.mainCamera.transform.position - var_112_0.position

				var_112_0.forward = Vector3.New(var_112_5.x, var_112_5.y, var_112_5.z)

				local var_112_6 = var_112_0.localEulerAngles

				var_112_6.z = 0
				var_112_6.x = 0
				var_112_0.localEulerAngles = var_112_6
			end

			if arg_109_1.time_ >= var_112_1 + var_112_2 and arg_109_1.time_ < var_112_1 + var_112_2 + arg_112_0 then
				var_112_0.localPosition = Vector3.New(0, -1.2, -6)

				local var_112_7 = manager.ui.mainCamera.transform.position - var_112_0.position

				var_112_0.forward = Vector3.New(var_112_7.x, var_112_7.y, var_112_7.z)

				local var_112_8 = var_112_0.localEulerAngles

				var_112_8.z = 0
				var_112_8.x = 0
				var_112_0.localEulerAngles = var_112_8
			end

			local var_112_9 = arg_109_1.actors_["1049ui_story"]
			local var_112_10 = 0

			if var_112_10 < arg_109_1.time_ and arg_109_1.time_ <= var_112_10 + arg_112_0 and not isNil(var_112_9) and arg_109_1.var_.characterEffect1049ui_story == nil then
				arg_109_1.var_.characterEffect1049ui_story = var_112_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_11 = 0.200000002980232

			if var_112_10 <= arg_109_1.time_ and arg_109_1.time_ < var_112_10 + var_112_11 and not isNil(var_112_9) then
				local var_112_12 = (arg_109_1.time_ - var_112_10) / var_112_11

				if arg_109_1.var_.characterEffect1049ui_story and not isNil(var_112_9) then
					arg_109_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_109_1.time_ >= var_112_10 + var_112_11 and arg_109_1.time_ < var_112_10 + var_112_11 + arg_112_0 and not isNil(var_112_9) and arg_109_1.var_.characterEffect1049ui_story then
				arg_109_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_112_13 = 0

			if var_112_13 < arg_109_1.time_ and arg_109_1.time_ <= var_112_13 + arg_112_0 then
				arg_109_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action5_1")
			end

			local var_112_14 = 0

			if var_112_14 < arg_109_1.time_ and arg_109_1.time_ <= var_112_14 + arg_112_0 then
				arg_109_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_112_15 = 0
			local var_112_16 = 0.625

			if var_112_15 < arg_109_1.time_ and arg_109_1.time_ <= var_112_15 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				local var_112_17 = arg_109_1:FormatText(StoryNameCfg[551].name)

				arg_109_1.leftNameTxt_.text = var_112_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_18 = arg_109_1:GetWordFromCfg(1104902026)
				local var_112_19 = arg_109_1:FormatText(var_112_18.content)

				arg_109_1.text_.text = var_112_19

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_20 = 26
				local var_112_21 = utf8.len(var_112_19)
				local var_112_22 = var_112_20 <= 0 and var_112_16 or var_112_16 * (var_112_21 / var_112_20)

				if var_112_22 > 0 and var_112_16 < var_112_22 then
					arg_109_1.talkMaxDuration = var_112_22

					if var_112_22 + var_112_15 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_22 + var_112_15
					end
				end

				arg_109_1.text_.text = var_112_19
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104902", "1104902026", "story_v_side_new_1104902.awb") ~= 0 then
					local var_112_23 = manager.audio:GetVoiceLength("story_v_side_new_1104902", "1104902026", "story_v_side_new_1104902.awb") / 1000

					if var_112_23 + var_112_15 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_23 + var_112_15
					end

					if var_112_18.prefab_name ~= "" and arg_109_1.actors_[var_112_18.prefab_name] ~= nil then
						local var_112_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_18.prefab_name].transform, "story_v_side_new_1104902", "1104902026", "story_v_side_new_1104902.awb")

						arg_109_1:RecordAudio("1104902026", var_112_24)
						arg_109_1:RecordAudio("1104902026", var_112_24)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_side_new_1104902", "1104902026", "story_v_side_new_1104902.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_side_new_1104902", "1104902026", "story_v_side_new_1104902.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_25 = math.max(var_112_16, arg_109_1.talkMaxDuration)

			if var_112_15 <= arg_109_1.time_ and arg_109_1.time_ < var_112_15 + var_112_25 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_15) / var_112_25

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_15 + var_112_25 and arg_109_1.time_ < var_112_15 + var_112_25 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_109_1:InitPlayNodeList()
	end,
	Play1104902027 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 1104902027
		arg_113_1.duration_ = 3.73

		local var_113_0 = {
			zh = 1.833,
			ja = 3.733
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
				arg_113_0:Play1104902028(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = arg_113_1.actors_["1049ui_story"]
			local var_116_1 = 0

			if var_116_1 < arg_113_1.time_ and arg_113_1.time_ <= var_116_1 + arg_116_0 and not isNil(var_116_0) and arg_113_1.var_.characterEffect1049ui_story == nil then
				arg_113_1.var_.characterEffect1049ui_story = var_116_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_2 = 0.200000002980232

			if var_116_1 <= arg_113_1.time_ and arg_113_1.time_ < var_116_1 + var_116_2 and not isNil(var_116_0) then
				local var_116_3 = (arg_113_1.time_ - var_116_1) / var_116_2

				if arg_113_1.var_.characterEffect1049ui_story and not isNil(var_116_0) then
					local var_116_4 = Mathf.Lerp(0, 0.5, var_116_3)

					arg_113_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_113_1.var_.characterEffect1049ui_story.fillRatio = var_116_4
				end
			end

			if arg_113_1.time_ >= var_116_1 + var_116_2 and arg_113_1.time_ < var_116_1 + var_116_2 + arg_116_0 and not isNil(var_116_0) and arg_113_1.var_.characterEffect1049ui_story then
				local var_116_5 = 0.5

				arg_113_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_113_1.var_.characterEffect1049ui_story.fillRatio = var_116_5
			end

			local var_116_6 = 0
			local var_116_7 = 0.175

			if var_116_6 < arg_113_1.time_ and arg_113_1.time_ <= var_116_6 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				local var_116_8 = arg_113_1:FormatText(StoryNameCfg[1008].name)

				arg_113_1.leftNameTxt_.text = var_116_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, true)
				arg_113_1.iconController_:SetSelectedState("hero")

				arg_113_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10119")

				arg_113_1.callingController_:SetSelectedState("normal")

				arg_113_1.keyicon_.color = Color.New(1, 1, 1)
				arg_113_1.icon_.color = Color.New(1, 1, 1)

				local var_116_9 = arg_113_1:GetWordFromCfg(1104902027)
				local var_116_10 = arg_113_1:FormatText(var_116_9.content)

				arg_113_1.text_.text = var_116_10

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_11 = 7
				local var_116_12 = utf8.len(var_116_10)
				local var_116_13 = var_116_11 <= 0 and var_116_7 or var_116_7 * (var_116_12 / var_116_11)

				if var_116_13 > 0 and var_116_7 < var_116_13 then
					arg_113_1.talkMaxDuration = var_116_13

					if var_116_13 + var_116_6 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_13 + var_116_6
					end
				end

				arg_113_1.text_.text = var_116_10
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104902", "1104902027", "story_v_side_new_1104902.awb") ~= 0 then
					local var_116_14 = manager.audio:GetVoiceLength("story_v_side_new_1104902", "1104902027", "story_v_side_new_1104902.awb") / 1000

					if var_116_14 + var_116_6 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_14 + var_116_6
					end

					if var_116_9.prefab_name ~= "" and arg_113_1.actors_[var_116_9.prefab_name] ~= nil then
						local var_116_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_9.prefab_name].transform, "story_v_side_new_1104902", "1104902027", "story_v_side_new_1104902.awb")

						arg_113_1:RecordAudio("1104902027", var_116_15)
						arg_113_1:RecordAudio("1104902027", var_116_15)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_side_new_1104902", "1104902027", "story_v_side_new_1104902.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_side_new_1104902", "1104902027", "story_v_side_new_1104902.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_16 = math.max(var_116_7, arg_113_1.talkMaxDuration)

			if var_116_6 <= arg_113_1.time_ and arg_113_1.time_ < var_116_6 + var_116_16 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_6) / var_116_16

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_6 + var_116_16 and arg_113_1.time_ < var_116_6 + var_116_16 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play1104902028 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 1104902028
		arg_117_1.duration_ = 2

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play1104902029(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = arg_117_1.actors_["1049ui_story"].transform
			local var_120_1 = 0

			if var_120_1 < arg_117_1.time_ and arg_117_1.time_ <= var_120_1 + arg_120_0 then
				arg_117_1.var_.moveOldPos1049ui_story = var_120_0.localPosition
			end

			local var_120_2 = 0.001

			if var_120_1 <= arg_117_1.time_ and arg_117_1.time_ < var_120_1 + var_120_2 then
				local var_120_3 = (arg_117_1.time_ - var_120_1) / var_120_2
				local var_120_4 = Vector3.New(0, -1.2, -6)

				var_120_0.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos1049ui_story, var_120_4, var_120_3)

				local var_120_5 = manager.ui.mainCamera.transform.position - var_120_0.position

				var_120_0.forward = Vector3.New(var_120_5.x, var_120_5.y, var_120_5.z)

				local var_120_6 = var_120_0.localEulerAngles

				var_120_6.z = 0
				var_120_6.x = 0
				var_120_0.localEulerAngles = var_120_6
			end

			if arg_117_1.time_ >= var_120_1 + var_120_2 and arg_117_1.time_ < var_120_1 + var_120_2 + arg_120_0 then
				var_120_0.localPosition = Vector3.New(0, -1.2, -6)

				local var_120_7 = manager.ui.mainCamera.transform.position - var_120_0.position

				var_120_0.forward = Vector3.New(var_120_7.x, var_120_7.y, var_120_7.z)

				local var_120_8 = var_120_0.localEulerAngles

				var_120_8.z = 0
				var_120_8.x = 0
				var_120_0.localEulerAngles = var_120_8
			end

			local var_120_9 = arg_117_1.actors_["1049ui_story"]
			local var_120_10 = 0

			if var_120_10 < arg_117_1.time_ and arg_117_1.time_ <= var_120_10 + arg_120_0 and not isNil(var_120_9) and arg_117_1.var_.characterEffect1049ui_story == nil then
				arg_117_1.var_.characterEffect1049ui_story = var_120_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_11 = 0.200000002980232

			if var_120_10 <= arg_117_1.time_ and arg_117_1.time_ < var_120_10 + var_120_11 and not isNil(var_120_9) then
				local var_120_12 = (arg_117_1.time_ - var_120_10) / var_120_11

				if arg_117_1.var_.characterEffect1049ui_story and not isNil(var_120_9) then
					arg_117_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_117_1.time_ >= var_120_10 + var_120_11 and arg_117_1.time_ < var_120_10 + var_120_11 + arg_120_0 and not isNil(var_120_9) and arg_117_1.var_.characterEffect1049ui_story then
				arg_117_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_120_13 = 0

			if var_120_13 < arg_117_1.time_ and arg_117_1.time_ <= var_120_13 + arg_120_0 then
				arg_117_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action5_2")
			end

			local var_120_14 = 0

			if var_120_14 < arg_117_1.time_ and arg_117_1.time_ <= var_120_14 + arg_120_0 then
				arg_117_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_120_15 = 0
			local var_120_16 = 0.2

			if var_120_15 < arg_117_1.time_ and arg_117_1.time_ <= var_120_15 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				local var_120_17 = arg_117_1:FormatText(StoryNameCfg[551].name)

				arg_117_1.leftNameTxt_.text = var_120_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_18 = arg_117_1:GetWordFromCfg(1104902028)
				local var_120_19 = arg_117_1:FormatText(var_120_18.content)

				arg_117_1.text_.text = var_120_19

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_20 = 8
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

				if manager.audio:GetVoiceLength("story_v_side_new_1104902", "1104902028", "story_v_side_new_1104902.awb") ~= 0 then
					local var_120_23 = manager.audio:GetVoiceLength("story_v_side_new_1104902", "1104902028", "story_v_side_new_1104902.awb") / 1000

					if var_120_23 + var_120_15 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_23 + var_120_15
					end

					if var_120_18.prefab_name ~= "" and arg_117_1.actors_[var_120_18.prefab_name] ~= nil then
						local var_120_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_18.prefab_name].transform, "story_v_side_new_1104902", "1104902028", "story_v_side_new_1104902.awb")

						arg_117_1:RecordAudio("1104902028", var_120_24)
						arg_117_1:RecordAudio("1104902028", var_120_24)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_side_new_1104902", "1104902028", "story_v_side_new_1104902.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_side_new_1104902", "1104902028", "story_v_side_new_1104902.awb")
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
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_117_1:InitPlayNodeList()
	end,
	Play1104902029 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 1104902029
		arg_121_1.duration_ = 5

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play1104902030(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = arg_121_1.actors_["1049ui_story"].transform
			local var_124_1 = 0

			if var_124_1 < arg_121_1.time_ and arg_121_1.time_ <= var_124_1 + arg_124_0 then
				arg_121_1.var_.moveOldPos1049ui_story = var_124_0.localPosition
			end

			local var_124_2 = 0.001

			if var_124_1 <= arg_121_1.time_ and arg_121_1.time_ < var_124_1 + var_124_2 then
				local var_124_3 = (arg_121_1.time_ - var_124_1) / var_124_2
				local var_124_4 = Vector3.New(0, 100, 0)

				var_124_0.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos1049ui_story, var_124_4, var_124_3)

				local var_124_5 = manager.ui.mainCamera.transform.position - var_124_0.position

				var_124_0.forward = Vector3.New(var_124_5.x, var_124_5.y, var_124_5.z)

				local var_124_6 = var_124_0.localEulerAngles

				var_124_6.z = 0
				var_124_6.x = 0
				var_124_0.localEulerAngles = var_124_6
			end

			if arg_121_1.time_ >= var_124_1 + var_124_2 and arg_121_1.time_ < var_124_1 + var_124_2 + arg_124_0 then
				var_124_0.localPosition = Vector3.New(0, 100, 0)

				local var_124_7 = manager.ui.mainCamera.transform.position - var_124_0.position

				var_124_0.forward = Vector3.New(var_124_7.x, var_124_7.y, var_124_7.z)

				local var_124_8 = var_124_0.localEulerAngles

				var_124_8.z = 0
				var_124_8.x = 0
				var_124_0.localEulerAngles = var_124_8
			end

			local var_124_9 = arg_121_1.actors_["1049ui_story"]
			local var_124_10 = 0

			if var_124_10 < arg_121_1.time_ and arg_121_1.time_ <= var_124_10 + arg_124_0 and not isNil(var_124_9) and arg_121_1.var_.characterEffect1049ui_story == nil then
				arg_121_1.var_.characterEffect1049ui_story = var_124_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_11 = 0.200000002980232

			if var_124_10 <= arg_121_1.time_ and arg_121_1.time_ < var_124_10 + var_124_11 and not isNil(var_124_9) then
				local var_124_12 = (arg_121_1.time_ - var_124_10) / var_124_11

				if arg_121_1.var_.characterEffect1049ui_story and not isNil(var_124_9) then
					local var_124_13 = Mathf.Lerp(0, 0.5, var_124_12)

					arg_121_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_121_1.var_.characterEffect1049ui_story.fillRatio = var_124_13
				end
			end

			if arg_121_1.time_ >= var_124_10 + var_124_11 and arg_121_1.time_ < var_124_10 + var_124_11 + arg_124_0 and not isNil(var_124_9) and arg_121_1.var_.characterEffect1049ui_story then
				local var_124_14 = 0.5

				arg_121_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_121_1.var_.characterEffect1049ui_story.fillRatio = var_124_14
			end

			local var_124_15 = 0
			local var_124_16 = 0.6

			if var_124_15 < arg_121_1.time_ and arg_121_1.time_ <= var_124_15 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, false)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_17 = arg_121_1:GetWordFromCfg(1104902029)
				local var_124_18 = arg_121_1:FormatText(var_124_17.content)

				arg_121_1.text_.text = var_124_18

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_19 = 24
				local var_124_20 = utf8.len(var_124_18)
				local var_124_21 = var_124_19 <= 0 and var_124_16 or var_124_16 * (var_124_20 / var_124_19)

				if var_124_21 > 0 and var_124_16 < var_124_21 then
					arg_121_1.talkMaxDuration = var_124_21

					if var_124_21 + var_124_15 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_21 + var_124_15
					end
				end

				arg_121_1.text_.text = var_124_18
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)
				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_22 = math.max(var_124_16, arg_121_1.talkMaxDuration)

			if var_124_15 <= arg_121_1.time_ and arg_121_1.time_ < var_124_15 + var_124_22 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_15) / var_124_22

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_15 + var_124_22 and arg_121_1.time_ < var_124_15 + var_124_22 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_121_1:InitPlayNodeList()
	end,
	Play1104902030 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 1104902030
		arg_125_1.duration_ = 5

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play1104902031(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = 0
			local var_128_1 = 0.825

			if var_128_0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_0 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, false)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_2 = arg_125_1:GetWordFromCfg(1104902030)
				local var_128_3 = arg_125_1:FormatText(var_128_2.content)

				arg_125_1.text_.text = var_128_3

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_4 = 35
				local var_128_5 = utf8.len(var_128_3)
				local var_128_6 = var_128_4 <= 0 and var_128_1 or var_128_1 * (var_128_5 / var_128_4)

				if var_128_6 > 0 and var_128_1 < var_128_6 then
					arg_125_1.talkMaxDuration = var_128_6

					if var_128_6 + var_128_0 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_6 + var_128_0
					end
				end

				arg_125_1.text_.text = var_128_3
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)
				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_7 = math.max(var_128_1, arg_125_1.talkMaxDuration)

			if var_128_0 <= arg_125_1.time_ and arg_125_1.time_ < var_128_0 + var_128_7 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_0) / var_128_7

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_0 + var_128_7 and arg_125_1.time_ < var_128_0 + var_128_7 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play1104902031 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 1104902031
		arg_129_1.duration_ = 1.63

		local var_129_0 = {
			zh = 1.1,
			ja = 1.633
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
				arg_129_0:Play1104902032(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = arg_129_1.actors_["1049ui_story"].transform
			local var_132_1 = 0

			if var_132_1 < arg_129_1.time_ and arg_129_1.time_ <= var_132_1 + arg_132_0 then
				arg_129_1.var_.moveOldPos1049ui_story = var_132_0.localPosition
			end

			local var_132_2 = 0.001

			if var_132_1 <= arg_129_1.time_ and arg_129_1.time_ < var_132_1 + var_132_2 then
				local var_132_3 = (arg_129_1.time_ - var_132_1) / var_132_2
				local var_132_4 = Vector3.New(0, -1.2, -6)

				var_132_0.localPosition = Vector3.Lerp(arg_129_1.var_.moveOldPos1049ui_story, var_132_4, var_132_3)

				local var_132_5 = manager.ui.mainCamera.transform.position - var_132_0.position

				var_132_0.forward = Vector3.New(var_132_5.x, var_132_5.y, var_132_5.z)

				local var_132_6 = var_132_0.localEulerAngles

				var_132_6.z = 0
				var_132_6.x = 0
				var_132_0.localEulerAngles = var_132_6
			end

			if arg_129_1.time_ >= var_132_1 + var_132_2 and arg_129_1.time_ < var_132_1 + var_132_2 + arg_132_0 then
				var_132_0.localPosition = Vector3.New(0, -1.2, -6)

				local var_132_7 = manager.ui.mainCamera.transform.position - var_132_0.position

				var_132_0.forward = Vector3.New(var_132_7.x, var_132_7.y, var_132_7.z)

				local var_132_8 = var_132_0.localEulerAngles

				var_132_8.z = 0
				var_132_8.x = 0
				var_132_0.localEulerAngles = var_132_8
			end

			local var_132_9 = arg_129_1.actors_["1049ui_story"]
			local var_132_10 = 0

			if var_132_10 < arg_129_1.time_ and arg_129_1.time_ <= var_132_10 + arg_132_0 and not isNil(var_132_9) and arg_129_1.var_.characterEffect1049ui_story == nil then
				arg_129_1.var_.characterEffect1049ui_story = var_132_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_11 = 0.200000002980232

			if var_132_10 <= arg_129_1.time_ and arg_129_1.time_ < var_132_10 + var_132_11 and not isNil(var_132_9) then
				local var_132_12 = (arg_129_1.time_ - var_132_10) / var_132_11

				if arg_129_1.var_.characterEffect1049ui_story and not isNil(var_132_9) then
					arg_129_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_129_1.time_ >= var_132_10 + var_132_11 and arg_129_1.time_ < var_132_10 + var_132_11 + arg_132_0 and not isNil(var_132_9) and arg_129_1.var_.characterEffect1049ui_story then
				arg_129_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_132_13 = 0

			if var_132_13 < arg_129_1.time_ and arg_129_1.time_ <= var_132_13 + arg_132_0 then
				arg_129_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action1_1")
			end

			local var_132_14 = 0

			if var_132_14 < arg_129_1.time_ and arg_129_1.time_ <= var_132_14 + arg_132_0 then
				arg_129_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_132_15 = 0
			local var_132_16 = 0.1

			if var_132_15 < arg_129_1.time_ and arg_129_1.time_ <= var_132_15 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				local var_132_17 = arg_129_1:FormatText(StoryNameCfg[551].name)

				arg_129_1.leftNameTxt_.text = var_132_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_18 = arg_129_1:GetWordFromCfg(1104902031)
				local var_132_19 = arg_129_1:FormatText(var_132_18.content)

				arg_129_1.text_.text = var_132_19

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_20 = 4
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

				if manager.audio:GetVoiceLength("story_v_side_new_1104902", "1104902031", "story_v_side_new_1104902.awb") ~= 0 then
					local var_132_23 = manager.audio:GetVoiceLength("story_v_side_new_1104902", "1104902031", "story_v_side_new_1104902.awb") / 1000

					if var_132_23 + var_132_15 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_23 + var_132_15
					end

					if var_132_18.prefab_name ~= "" and arg_129_1.actors_[var_132_18.prefab_name] ~= nil then
						local var_132_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_18.prefab_name].transform, "story_v_side_new_1104902", "1104902031", "story_v_side_new_1104902.awb")

						arg_129_1:RecordAudio("1104902031", var_132_24)
						arg_129_1:RecordAudio("1104902031", var_132_24)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_side_new_1104902", "1104902031", "story_v_side_new_1104902.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_side_new_1104902", "1104902031", "story_v_side_new_1104902.awb")
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
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_129_1:InitPlayNodeList()
	end,
	Play1104902032 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 1104902032
		arg_133_1.duration_ = 1.73

		local var_133_0 = {
			zh = 1.733,
			ja = 1.4
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
				arg_133_0:Play1104902033(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = arg_133_1.actors_["1049ui_story"]
			local var_136_1 = 0

			if var_136_1 < arg_133_1.time_ and arg_133_1.time_ <= var_136_1 + arg_136_0 and not isNil(var_136_0) and arg_133_1.var_.characterEffect1049ui_story == nil then
				arg_133_1.var_.characterEffect1049ui_story = var_136_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_2 = 0.200000002980232

			if var_136_1 <= arg_133_1.time_ and arg_133_1.time_ < var_136_1 + var_136_2 and not isNil(var_136_0) then
				local var_136_3 = (arg_133_1.time_ - var_136_1) / var_136_2

				if arg_133_1.var_.characterEffect1049ui_story and not isNil(var_136_0) then
					local var_136_4 = Mathf.Lerp(0, 0.5, var_136_3)

					arg_133_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_133_1.var_.characterEffect1049ui_story.fillRatio = var_136_4
				end
			end

			if arg_133_1.time_ >= var_136_1 + var_136_2 and arg_133_1.time_ < var_136_1 + var_136_2 + arg_136_0 and not isNil(var_136_0) and arg_133_1.var_.characterEffect1049ui_story then
				local var_136_5 = 0.5

				arg_133_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_133_1.var_.characterEffect1049ui_story.fillRatio = var_136_5
			end

			local var_136_6 = 0
			local var_136_7 = 0.075

			if var_136_6 < arg_133_1.time_ and arg_133_1.time_ <= var_136_6 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				local var_136_8 = arg_133_1:FormatText(StoryNameCfg[1008].name)

				arg_133_1.leftNameTxt_.text = var_136_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, true)
				arg_133_1.iconController_:SetSelectedState("hero")

				arg_133_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10119")

				arg_133_1.callingController_:SetSelectedState("normal")

				arg_133_1.keyicon_.color = Color.New(1, 1, 1)
				arg_133_1.icon_.color = Color.New(1, 1, 1)

				local var_136_9 = arg_133_1:GetWordFromCfg(1104902032)
				local var_136_10 = arg_133_1:FormatText(var_136_9.content)

				arg_133_1.text_.text = var_136_10

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_11 = 3
				local var_136_12 = utf8.len(var_136_10)
				local var_136_13 = var_136_11 <= 0 and var_136_7 or var_136_7 * (var_136_12 / var_136_11)

				if var_136_13 > 0 and var_136_7 < var_136_13 then
					arg_133_1.talkMaxDuration = var_136_13

					if var_136_13 + var_136_6 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_13 + var_136_6
					end
				end

				arg_133_1.text_.text = var_136_10
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104902", "1104902032", "story_v_side_new_1104902.awb") ~= 0 then
					local var_136_14 = manager.audio:GetVoiceLength("story_v_side_new_1104902", "1104902032", "story_v_side_new_1104902.awb") / 1000

					if var_136_14 + var_136_6 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_14 + var_136_6
					end

					if var_136_9.prefab_name ~= "" and arg_133_1.actors_[var_136_9.prefab_name] ~= nil then
						local var_136_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_9.prefab_name].transform, "story_v_side_new_1104902", "1104902032", "story_v_side_new_1104902.awb")

						arg_133_1:RecordAudio("1104902032", var_136_15)
						arg_133_1:RecordAudio("1104902032", var_136_15)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_side_new_1104902", "1104902032", "story_v_side_new_1104902.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_side_new_1104902", "1104902032", "story_v_side_new_1104902.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_16 = math.max(var_136_7, arg_133_1.talkMaxDuration)

			if var_136_6 <= arg_133_1.time_ and arg_133_1.time_ < var_136_6 + var_136_16 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_6) / var_136_16

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_6 + var_136_16 and arg_133_1.time_ < var_136_6 + var_136_16 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play1104902033 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 1104902033
		arg_137_1.duration_ = 5

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play1104902034(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = arg_137_1.actors_["1049ui_story"].transform
			local var_140_1 = 0

			if var_140_1 < arg_137_1.time_ and arg_137_1.time_ <= var_140_1 + arg_140_0 then
				arg_137_1.var_.moveOldPos1049ui_story = var_140_0.localPosition
			end

			local var_140_2 = 0.001

			if var_140_1 <= arg_137_1.time_ and arg_137_1.time_ < var_140_1 + var_140_2 then
				local var_140_3 = (arg_137_1.time_ - var_140_1) / var_140_2
				local var_140_4 = Vector3.New(0, 100, 0)

				var_140_0.localPosition = Vector3.Lerp(arg_137_1.var_.moveOldPos1049ui_story, var_140_4, var_140_3)

				local var_140_5 = manager.ui.mainCamera.transform.position - var_140_0.position

				var_140_0.forward = Vector3.New(var_140_5.x, var_140_5.y, var_140_5.z)

				local var_140_6 = var_140_0.localEulerAngles

				var_140_6.z = 0
				var_140_6.x = 0
				var_140_0.localEulerAngles = var_140_6
			end

			if arg_137_1.time_ >= var_140_1 + var_140_2 and arg_137_1.time_ < var_140_1 + var_140_2 + arg_140_0 then
				var_140_0.localPosition = Vector3.New(0, 100, 0)

				local var_140_7 = manager.ui.mainCamera.transform.position - var_140_0.position

				var_140_0.forward = Vector3.New(var_140_7.x, var_140_7.y, var_140_7.z)

				local var_140_8 = var_140_0.localEulerAngles

				var_140_8.z = 0
				var_140_8.x = 0
				var_140_0.localEulerAngles = var_140_8
			end

			local var_140_9 = arg_137_1.actors_["1049ui_story"]
			local var_140_10 = 0

			if var_140_10 < arg_137_1.time_ and arg_137_1.time_ <= var_140_10 + arg_140_0 and not isNil(var_140_9) and arg_137_1.var_.characterEffect1049ui_story == nil then
				arg_137_1.var_.characterEffect1049ui_story = var_140_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_11 = 0.200000002980232

			if var_140_10 <= arg_137_1.time_ and arg_137_1.time_ < var_140_10 + var_140_11 and not isNil(var_140_9) then
				local var_140_12 = (arg_137_1.time_ - var_140_10) / var_140_11

				if arg_137_1.var_.characterEffect1049ui_story and not isNil(var_140_9) then
					local var_140_13 = Mathf.Lerp(0, 0.5, var_140_12)

					arg_137_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_137_1.var_.characterEffect1049ui_story.fillRatio = var_140_13
				end
			end

			if arg_137_1.time_ >= var_140_10 + var_140_11 and arg_137_1.time_ < var_140_10 + var_140_11 + arg_140_0 and not isNil(var_140_9) and arg_137_1.var_.characterEffect1049ui_story then
				local var_140_14 = 0.5

				arg_137_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_137_1.var_.characterEffect1049ui_story.fillRatio = var_140_14
			end

			local var_140_15 = 0
			local var_140_16 = 0.275

			if var_140_15 < arg_137_1.time_ and arg_137_1.time_ <= var_140_15 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, false)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_17 = arg_137_1:GetWordFromCfg(1104902033)
				local var_140_18 = arg_137_1:FormatText(var_140_17.content)

				arg_137_1.text_.text = var_140_18

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_19 = 11
				local var_140_20 = utf8.len(var_140_18)
				local var_140_21 = var_140_19 <= 0 and var_140_16 or var_140_16 * (var_140_20 / var_140_19)

				if var_140_21 > 0 and var_140_16 < var_140_21 then
					arg_137_1.talkMaxDuration = var_140_21

					if var_140_21 + var_140_15 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_21 + var_140_15
					end
				end

				arg_137_1.text_.text = var_140_18
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)
				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_22 = math.max(var_140_16, arg_137_1.talkMaxDuration)

			if var_140_15 <= arg_137_1.time_ and arg_137_1.time_ < var_140_15 + var_140_22 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_15) / var_140_22

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_15 + var_140_22 and arg_137_1.time_ < var_140_15 + var_140_22 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
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
	Play1104902034 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 1104902034
		arg_141_1.duration_ = 5

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play1104902035(arg_141_1)
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

				local var_144_2 = arg_141_1:FormatText(StoryNameCfg[7].name)

				arg_141_1.leftNameTxt_.text = var_144_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, true)
				arg_141_1.iconController_:SetSelectedState("hero")

				arg_141_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_141_1.callingController_:SetSelectedState("normal")

				arg_141_1.keyicon_.color = Color.New(1, 1, 1)
				arg_141_1.icon_.color = Color.New(1, 1, 1)

				local var_144_3 = arg_141_1:GetWordFromCfg(1104902034)
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
				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_8 = math.max(var_144_1, arg_141_1.talkMaxDuration)

			if var_144_0 <= arg_141_1.time_ and arg_141_1.time_ < var_144_0 + var_144_8 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_0) / var_144_8

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_0 + var_144_8 and arg_141_1.time_ < var_144_0 + var_144_8 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play1104902035 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 1104902035
		arg_145_1.duration_ = 5

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play1104902036(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = 0
			local var_148_1 = 0.675

			if var_148_0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_0 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, false)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_2 = arg_145_1:GetWordFromCfg(1104902035)
				local var_148_3 = arg_145_1:FormatText(var_148_2.content)

				arg_145_1.text_.text = var_148_3

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_4 = 27
				local var_148_5 = utf8.len(var_148_3)
				local var_148_6 = var_148_4 <= 0 and var_148_1 or var_148_1 * (var_148_5 / var_148_4)

				if var_148_6 > 0 and var_148_1 < var_148_6 then
					arg_145_1.talkMaxDuration = var_148_6

					if var_148_6 + var_148_0 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_6 + var_148_0
					end
				end

				arg_145_1.text_.text = var_148_3
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)
				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_7 = math.max(var_148_1, arg_145_1.talkMaxDuration)

			if var_148_0 <= arg_145_1.time_ and arg_145_1.time_ < var_148_0 + var_148_7 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_0) / var_148_7

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_0 + var_148_7 and arg_145_1.time_ < var_148_0 + var_148_7 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {}

		arg_145_1:InitPlayNodeList()
	end,
	Play1104902036 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 1104902036
		arg_149_1.duration_ = 5

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play1104902037(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = 0
			local var_152_1 = 0.25

			if var_152_0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_0 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				local var_152_2 = arg_149_1:FormatText(StoryNameCfg[7].name)

				arg_149_1.leftNameTxt_.text = var_152_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, true)
				arg_149_1.iconController_:SetSelectedState("hero")

				arg_149_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_149_1.callingController_:SetSelectedState("normal")

				arg_149_1.keyicon_.color = Color.New(1, 1, 1)
				arg_149_1.icon_.color = Color.New(1, 1, 1)

				local var_152_3 = arg_149_1:GetWordFromCfg(1104902036)
				local var_152_4 = arg_149_1:FormatText(var_152_3.content)

				arg_149_1.text_.text = var_152_4

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_5 = 10
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
				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_8 = math.max(var_152_1, arg_149_1.talkMaxDuration)

			if var_152_0 <= arg_149_1.time_ and arg_149_1.time_ < var_152_0 + var_152_8 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_0) / var_152_8

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_0 + var_152_8 and arg_149_1.time_ < var_152_0 + var_152_8 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play1104902037 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 1104902037
		arg_153_1.duration_ = 8.37

		local var_153_0 = {
			zh = 8.366,
			ja = 6.233
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
				arg_153_0:Play1104902038(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = arg_153_1.actors_["1049ui_story"].transform
			local var_156_1 = 0

			if var_156_1 < arg_153_1.time_ and arg_153_1.time_ <= var_156_1 + arg_156_0 then
				arg_153_1.var_.moveOldPos1049ui_story = var_156_0.localPosition
			end

			local var_156_2 = 0.001

			if var_156_1 <= arg_153_1.time_ and arg_153_1.time_ < var_156_1 + var_156_2 then
				local var_156_3 = (arg_153_1.time_ - var_156_1) / var_156_2
				local var_156_4 = Vector3.New(0, -1.2, -6)

				var_156_0.localPosition = Vector3.Lerp(arg_153_1.var_.moveOldPos1049ui_story, var_156_4, var_156_3)

				local var_156_5 = manager.ui.mainCamera.transform.position - var_156_0.position

				var_156_0.forward = Vector3.New(var_156_5.x, var_156_5.y, var_156_5.z)

				local var_156_6 = var_156_0.localEulerAngles

				var_156_6.z = 0
				var_156_6.x = 0
				var_156_0.localEulerAngles = var_156_6
			end

			if arg_153_1.time_ >= var_156_1 + var_156_2 and arg_153_1.time_ < var_156_1 + var_156_2 + arg_156_0 then
				var_156_0.localPosition = Vector3.New(0, -1.2, -6)

				local var_156_7 = manager.ui.mainCamera.transform.position - var_156_0.position

				var_156_0.forward = Vector3.New(var_156_7.x, var_156_7.y, var_156_7.z)

				local var_156_8 = var_156_0.localEulerAngles

				var_156_8.z = 0
				var_156_8.x = 0
				var_156_0.localEulerAngles = var_156_8
			end

			local var_156_9 = arg_153_1.actors_["1049ui_story"]
			local var_156_10 = 0

			if var_156_10 < arg_153_1.time_ and arg_153_1.time_ <= var_156_10 + arg_156_0 and not isNil(var_156_9) and arg_153_1.var_.characterEffect1049ui_story == nil then
				arg_153_1.var_.characterEffect1049ui_story = var_156_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_11 = 0.200000002980232

			if var_156_10 <= arg_153_1.time_ and arg_153_1.time_ < var_156_10 + var_156_11 and not isNil(var_156_9) then
				local var_156_12 = (arg_153_1.time_ - var_156_10) / var_156_11

				if arg_153_1.var_.characterEffect1049ui_story and not isNil(var_156_9) then
					arg_153_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_153_1.time_ >= var_156_10 + var_156_11 and arg_153_1.time_ < var_156_10 + var_156_11 + arg_156_0 and not isNil(var_156_9) and arg_153_1.var_.characterEffect1049ui_story then
				arg_153_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_156_13 = 0

			if var_156_13 < arg_153_1.time_ and arg_153_1.time_ <= var_156_13 + arg_156_0 then
				arg_153_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action6_1")
			end

			local var_156_14 = 0

			if var_156_14 < arg_153_1.time_ and arg_153_1.time_ <= var_156_14 + arg_156_0 then
				arg_153_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_156_15 = 0
			local var_156_16 = 0.9

			if var_156_15 < arg_153_1.time_ and arg_153_1.time_ <= var_156_15 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				local var_156_17 = arg_153_1:FormatText(StoryNameCfg[551].name)

				arg_153_1.leftNameTxt_.text = var_156_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_18 = arg_153_1:GetWordFromCfg(1104902037)
				local var_156_19 = arg_153_1:FormatText(var_156_18.content)

				arg_153_1.text_.text = var_156_19

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_20 = 36
				local var_156_21 = utf8.len(var_156_19)
				local var_156_22 = var_156_20 <= 0 and var_156_16 or var_156_16 * (var_156_21 / var_156_20)

				if var_156_22 > 0 and var_156_16 < var_156_22 then
					arg_153_1.talkMaxDuration = var_156_22

					if var_156_22 + var_156_15 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_22 + var_156_15
					end
				end

				arg_153_1.text_.text = var_156_19
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104902", "1104902037", "story_v_side_new_1104902.awb") ~= 0 then
					local var_156_23 = manager.audio:GetVoiceLength("story_v_side_new_1104902", "1104902037", "story_v_side_new_1104902.awb") / 1000

					if var_156_23 + var_156_15 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_23 + var_156_15
					end

					if var_156_18.prefab_name ~= "" and arg_153_1.actors_[var_156_18.prefab_name] ~= nil then
						local var_156_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_18.prefab_name].transform, "story_v_side_new_1104902", "1104902037", "story_v_side_new_1104902.awb")

						arg_153_1:RecordAudio("1104902037", var_156_24)
						arg_153_1:RecordAudio("1104902037", var_156_24)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_side_new_1104902", "1104902037", "story_v_side_new_1104902.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_side_new_1104902", "1104902037", "story_v_side_new_1104902.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_25 = math.max(var_156_16, arg_153_1.talkMaxDuration)

			if var_156_15 <= arg_153_1.time_ and arg_153_1.time_ < var_156_15 + var_156_25 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_15) / var_156_25

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_15 + var_156_25 and arg_153_1.time_ < var_156_15 + var_156_25 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_153_1:InitPlayNodeList()
	end,
	Play1104902038 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 1104902038
		arg_157_1.duration_ = 5

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play1104902039(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = arg_157_1.actors_["1049ui_story"]
			local var_160_1 = 0

			if var_160_1 < arg_157_1.time_ and arg_157_1.time_ <= var_160_1 + arg_160_0 and not isNil(var_160_0) and arg_157_1.var_.characterEffect1049ui_story == nil then
				arg_157_1.var_.characterEffect1049ui_story = var_160_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_2 = 0.200000002980232

			if var_160_1 <= arg_157_1.time_ and arg_157_1.time_ < var_160_1 + var_160_2 and not isNil(var_160_0) then
				local var_160_3 = (arg_157_1.time_ - var_160_1) / var_160_2

				if arg_157_1.var_.characterEffect1049ui_story and not isNil(var_160_0) then
					local var_160_4 = Mathf.Lerp(0, 0.5, var_160_3)

					arg_157_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_157_1.var_.characterEffect1049ui_story.fillRatio = var_160_4
				end
			end

			if arg_157_1.time_ >= var_160_1 + var_160_2 and arg_157_1.time_ < var_160_1 + var_160_2 + arg_160_0 and not isNil(var_160_0) and arg_157_1.var_.characterEffect1049ui_story then
				local var_160_5 = 0.5

				arg_157_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_157_1.var_.characterEffect1049ui_story.fillRatio = var_160_5
			end

			local var_160_6 = 0
			local var_160_7 = 0.575

			if var_160_6 < arg_157_1.time_ and arg_157_1.time_ <= var_160_6 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, false)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_8 = arg_157_1:GetWordFromCfg(1104902038)
				local var_160_9 = arg_157_1:FormatText(var_160_8.content)

				arg_157_1.text_.text = var_160_9

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_10 = 23
				local var_160_11 = utf8.len(var_160_9)
				local var_160_12 = var_160_10 <= 0 and var_160_7 or var_160_7 * (var_160_11 / var_160_10)

				if var_160_12 > 0 and var_160_7 < var_160_12 then
					arg_157_1.talkMaxDuration = var_160_12

					if var_160_12 + var_160_6 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_12 + var_160_6
					end
				end

				arg_157_1.text_.text = var_160_9
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)
				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_13 = math.max(var_160_7, arg_157_1.talkMaxDuration)

			if var_160_6 <= arg_157_1.time_ and arg_157_1.time_ < var_160_6 + var_160_13 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_6) / var_160_13

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_6 + var_160_13 and arg_157_1.time_ < var_160_6 + var_160_13 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play1104902039 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 1104902039
		arg_161_1.duration_ = 7.97

		local var_161_0 = {
			zh = 7.966,
			ja = 4.133
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
				arg_161_0:Play1104902040(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = arg_161_1.actors_["1049ui_story"].transform
			local var_164_1 = 0

			if var_164_1 < arg_161_1.time_ and arg_161_1.time_ <= var_164_1 + arg_164_0 then
				arg_161_1.var_.moveOldPos1049ui_story = var_164_0.localPosition
			end

			local var_164_2 = 0.001

			if var_164_1 <= arg_161_1.time_ and arg_161_1.time_ < var_164_1 + var_164_2 then
				local var_164_3 = (arg_161_1.time_ - var_164_1) / var_164_2
				local var_164_4 = Vector3.New(0, -1.2, -6)

				var_164_0.localPosition = Vector3.Lerp(arg_161_1.var_.moveOldPos1049ui_story, var_164_4, var_164_3)

				local var_164_5 = manager.ui.mainCamera.transform.position - var_164_0.position

				var_164_0.forward = Vector3.New(var_164_5.x, var_164_5.y, var_164_5.z)

				local var_164_6 = var_164_0.localEulerAngles

				var_164_6.z = 0
				var_164_6.x = 0
				var_164_0.localEulerAngles = var_164_6
			end

			if arg_161_1.time_ >= var_164_1 + var_164_2 and arg_161_1.time_ < var_164_1 + var_164_2 + arg_164_0 then
				var_164_0.localPosition = Vector3.New(0, -1.2, -6)

				local var_164_7 = manager.ui.mainCamera.transform.position - var_164_0.position

				var_164_0.forward = Vector3.New(var_164_7.x, var_164_7.y, var_164_7.z)

				local var_164_8 = var_164_0.localEulerAngles

				var_164_8.z = 0
				var_164_8.x = 0
				var_164_0.localEulerAngles = var_164_8
			end

			local var_164_9 = arg_161_1.actors_["1049ui_story"]
			local var_164_10 = 0

			if var_164_10 < arg_161_1.time_ and arg_161_1.time_ <= var_164_10 + arg_164_0 and not isNil(var_164_9) and arg_161_1.var_.characterEffect1049ui_story == nil then
				arg_161_1.var_.characterEffect1049ui_story = var_164_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_11 = 0.200000002980232

			if var_164_10 <= arg_161_1.time_ and arg_161_1.time_ < var_164_10 + var_164_11 and not isNil(var_164_9) then
				local var_164_12 = (arg_161_1.time_ - var_164_10) / var_164_11

				if arg_161_1.var_.characterEffect1049ui_story and not isNil(var_164_9) then
					arg_161_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_161_1.time_ >= var_164_10 + var_164_11 and arg_161_1.time_ < var_164_10 + var_164_11 + arg_164_0 and not isNil(var_164_9) and arg_161_1.var_.characterEffect1049ui_story then
				arg_161_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_164_13 = 0

			if var_164_13 < arg_161_1.time_ and arg_161_1.time_ <= var_164_13 + arg_164_0 then
				arg_161_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action6_2")
			end

			local var_164_14 = 0

			if var_164_14 < arg_161_1.time_ and arg_161_1.time_ <= var_164_14 + arg_164_0 then
				arg_161_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_164_15 = 0
			local var_164_16 = 0.55

			if var_164_15 < arg_161_1.time_ and arg_161_1.time_ <= var_164_15 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				local var_164_17 = arg_161_1:FormatText(StoryNameCfg[551].name)

				arg_161_1.leftNameTxt_.text = var_164_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_18 = arg_161_1:GetWordFromCfg(1104902039)
				local var_164_19 = arg_161_1:FormatText(var_164_18.content)

				arg_161_1.text_.text = var_164_19

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_20 = 22
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

				if manager.audio:GetVoiceLength("story_v_side_new_1104902", "1104902039", "story_v_side_new_1104902.awb") ~= 0 then
					local var_164_23 = manager.audio:GetVoiceLength("story_v_side_new_1104902", "1104902039", "story_v_side_new_1104902.awb") / 1000

					if var_164_23 + var_164_15 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_23 + var_164_15
					end

					if var_164_18.prefab_name ~= "" and arg_161_1.actors_[var_164_18.prefab_name] ~= nil then
						local var_164_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_18.prefab_name].transform, "story_v_side_new_1104902", "1104902039", "story_v_side_new_1104902.awb")

						arg_161_1:RecordAudio("1104902039", var_164_24)
						arg_161_1:RecordAudio("1104902039", var_164_24)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_side_new_1104902", "1104902039", "story_v_side_new_1104902.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_side_new_1104902", "1104902039", "story_v_side_new_1104902.awb")
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
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_161_1:InitPlayNodeList()
	end,
	Play1104902040 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 1104902040
		arg_165_1.duration_ = 6.6

		local var_165_0 = {
			zh = 6.6,
			ja = 4.166
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
				arg_165_0:Play1104902041(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = arg_165_1.actors_["1049ui_story"].transform
			local var_168_1 = 0

			if var_168_1 < arg_165_1.time_ and arg_165_1.time_ <= var_168_1 + arg_168_0 then
				arg_165_1.var_.moveOldPos1049ui_story = var_168_0.localPosition
			end

			local var_168_2 = 0.001

			if var_168_1 <= arg_165_1.time_ and arg_165_1.time_ < var_168_1 + var_168_2 then
				local var_168_3 = (arg_165_1.time_ - var_168_1) / var_168_2
				local var_168_4 = Vector3.New(0, -1.2, -6)

				var_168_0.localPosition = Vector3.Lerp(arg_165_1.var_.moveOldPos1049ui_story, var_168_4, var_168_3)

				local var_168_5 = manager.ui.mainCamera.transform.position - var_168_0.position

				var_168_0.forward = Vector3.New(var_168_5.x, var_168_5.y, var_168_5.z)

				local var_168_6 = var_168_0.localEulerAngles

				var_168_6.z = 0
				var_168_6.x = 0
				var_168_0.localEulerAngles = var_168_6
			end

			if arg_165_1.time_ >= var_168_1 + var_168_2 and arg_165_1.time_ < var_168_1 + var_168_2 + arg_168_0 then
				var_168_0.localPosition = Vector3.New(0, -1.2, -6)

				local var_168_7 = manager.ui.mainCamera.transform.position - var_168_0.position

				var_168_0.forward = Vector3.New(var_168_7.x, var_168_7.y, var_168_7.z)

				local var_168_8 = var_168_0.localEulerAngles

				var_168_8.z = 0
				var_168_8.x = 0
				var_168_0.localEulerAngles = var_168_8
			end

			local var_168_9 = arg_165_1.actors_["1049ui_story"]
			local var_168_10 = 0

			if var_168_10 < arg_165_1.time_ and arg_165_1.time_ <= var_168_10 + arg_168_0 and not isNil(var_168_9) and arg_165_1.var_.characterEffect1049ui_story == nil then
				arg_165_1.var_.characterEffect1049ui_story = var_168_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_11 = 0.200000002980232

			if var_168_10 <= arg_165_1.time_ and arg_165_1.time_ < var_168_10 + var_168_11 and not isNil(var_168_9) then
				local var_168_12 = (arg_165_1.time_ - var_168_10) / var_168_11

				if arg_165_1.var_.characterEffect1049ui_story and not isNil(var_168_9) then
					arg_165_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_165_1.time_ >= var_168_10 + var_168_11 and arg_165_1.time_ < var_168_10 + var_168_11 + arg_168_0 and not isNil(var_168_9) and arg_165_1.var_.characterEffect1049ui_story then
				arg_165_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_168_13 = 0

			if var_168_13 < arg_165_1.time_ and arg_165_1.time_ <= var_168_13 + arg_168_0 then
				arg_165_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action5_1")
			end

			local var_168_14 = 0

			if var_168_14 < arg_165_1.time_ and arg_165_1.time_ <= var_168_14 + arg_168_0 then
				arg_165_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_168_15 = 0
			local var_168_16 = 0.375

			if var_168_15 < arg_165_1.time_ and arg_165_1.time_ <= var_168_15 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				local var_168_17 = arg_165_1:FormatText(StoryNameCfg[551].name)

				arg_165_1.leftNameTxt_.text = var_168_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_18 = arg_165_1:GetWordFromCfg(1104902040)
				local var_168_19 = arg_165_1:FormatText(var_168_18.content)

				arg_165_1.text_.text = var_168_19

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_20 = 15
				local var_168_21 = utf8.len(var_168_19)
				local var_168_22 = var_168_20 <= 0 and var_168_16 or var_168_16 * (var_168_21 / var_168_20)

				if var_168_22 > 0 and var_168_16 < var_168_22 then
					arg_165_1.talkMaxDuration = var_168_22

					if var_168_22 + var_168_15 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_22 + var_168_15
					end
				end

				arg_165_1.text_.text = var_168_19
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104902", "1104902040", "story_v_side_new_1104902.awb") ~= 0 then
					local var_168_23 = manager.audio:GetVoiceLength("story_v_side_new_1104902", "1104902040", "story_v_side_new_1104902.awb") / 1000

					if var_168_23 + var_168_15 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_23 + var_168_15
					end

					if var_168_18.prefab_name ~= "" and arg_165_1.actors_[var_168_18.prefab_name] ~= nil then
						local var_168_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_18.prefab_name].transform, "story_v_side_new_1104902", "1104902040", "story_v_side_new_1104902.awb")

						arg_165_1:RecordAudio("1104902040", var_168_24)
						arg_165_1:RecordAudio("1104902040", var_168_24)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_side_new_1104902", "1104902040", "story_v_side_new_1104902.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_side_new_1104902", "1104902040", "story_v_side_new_1104902.awb")
				end

				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_25 = math.max(var_168_16, arg_165_1.talkMaxDuration)

			if var_168_15 <= arg_165_1.time_ and arg_165_1.time_ < var_168_15 + var_168_25 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_15) / var_168_25

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_15 + var_168_25 and arg_165_1.time_ < var_168_15 + var_168_25 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_165_1:InitPlayNodeList()
	end,
	Play1104902041 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 1104902041
		arg_169_1.duration_ = 9

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play1104902042(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = 2

			if var_172_0 < arg_169_1.time_ and arg_169_1.time_ <= var_172_0 + arg_172_0 then
				local var_172_1 = manager.ui.mainCamera.transform.localPosition
				local var_172_2 = Vector3.New(0, 0, 10) + Vector3.New(var_172_1.x, var_172_1.y, 0)
				local var_172_3 = arg_169_1.bgs_.STblack

				var_172_3.transform.localPosition = var_172_2
				var_172_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_172_4 = var_172_3:GetComponent("SpriteRenderer")

				if var_172_4 and var_172_4.sprite then
					local var_172_5 = (var_172_3.transform.localPosition - var_172_1).z
					local var_172_6 = manager.ui.mainCameraCom_
					local var_172_7 = 2 * var_172_5 * Mathf.Tan(var_172_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_172_8 = var_172_7 * var_172_6.aspect
					local var_172_9 = var_172_4.sprite.bounds.size.x
					local var_172_10 = var_172_4.sprite.bounds.size.y
					local var_172_11 = var_172_8 / var_172_9
					local var_172_12 = var_172_7 / var_172_10
					local var_172_13 = var_172_12 < var_172_11 and var_172_11 or var_172_12

					var_172_3.transform.localScale = Vector3.New(var_172_13, var_172_13, 0)
				end

				for iter_172_0, iter_172_1 in pairs(arg_169_1.bgs_) do
					if iter_172_0 ~= "STblack" then
						iter_172_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_172_14 = 3.999999999999

			if var_172_14 < arg_169_1.time_ and arg_169_1.time_ <= var_172_14 + arg_172_0 then
				arg_169_1.allBtn_.enabled = false
			end

			local var_172_15 = 0.3

			if arg_169_1.time_ >= var_172_14 + var_172_15 and arg_169_1.time_ < var_172_14 + var_172_15 + arg_172_0 then
				arg_169_1.allBtn_.enabled = true
			end

			local var_172_16 = 0

			if var_172_16 < arg_169_1.time_ and arg_169_1.time_ <= var_172_16 + arg_172_0 then
				arg_169_1.mask_.enabled = true
				arg_169_1.mask_.raycastTarget = true

				arg_169_1:SetGaussion(false)
			end

			local var_172_17 = 2

			if var_172_16 <= arg_169_1.time_ and arg_169_1.time_ < var_172_16 + var_172_17 then
				local var_172_18 = (arg_169_1.time_ - var_172_16) / var_172_17
				local var_172_19 = Color.New(0, 0, 0)

				var_172_19.a = Mathf.Lerp(0, 1, var_172_18)
				arg_169_1.mask_.color = var_172_19
			end

			if arg_169_1.time_ >= var_172_16 + var_172_17 and arg_169_1.time_ < var_172_16 + var_172_17 + arg_172_0 then
				local var_172_20 = Color.New(0, 0, 0)

				var_172_20.a = 1
				arg_169_1.mask_.color = var_172_20
			end

			local var_172_21 = 2

			if var_172_21 < arg_169_1.time_ and arg_169_1.time_ <= var_172_21 + arg_172_0 then
				arg_169_1.mask_.enabled = true
				arg_169_1.mask_.raycastTarget = true

				arg_169_1:SetGaussion(false)
			end

			local var_172_22 = 2

			if var_172_21 <= arg_169_1.time_ and arg_169_1.time_ < var_172_21 + var_172_22 then
				local var_172_23 = (arg_169_1.time_ - var_172_21) / var_172_22
				local var_172_24 = Color.New(0, 0, 0)

				var_172_24.a = Mathf.Lerp(1, 0, var_172_23)
				arg_169_1.mask_.color = var_172_24
			end

			if arg_169_1.time_ >= var_172_21 + var_172_22 and arg_169_1.time_ < var_172_21 + var_172_22 + arg_172_0 then
				local var_172_25 = Color.New(0, 0, 0)
				local var_172_26 = 0

				arg_169_1.mask_.enabled = false
				var_172_25.a = var_172_26
				arg_169_1.mask_.color = var_172_25
			end

			local var_172_27 = arg_169_1.actors_["1049ui_story"].transform
			local var_172_28 = 1.96599999815226

			if var_172_28 < arg_169_1.time_ and arg_169_1.time_ <= var_172_28 + arg_172_0 then
				arg_169_1.var_.moveOldPos1049ui_story = var_172_27.localPosition
			end

			local var_172_29 = 0.001

			if var_172_28 <= arg_169_1.time_ and arg_169_1.time_ < var_172_28 + var_172_29 then
				local var_172_30 = (arg_169_1.time_ - var_172_28) / var_172_29
				local var_172_31 = Vector3.New(0, 100, 0)

				var_172_27.localPosition = Vector3.Lerp(arg_169_1.var_.moveOldPos1049ui_story, var_172_31, var_172_30)

				local var_172_32 = manager.ui.mainCamera.transform.position - var_172_27.position

				var_172_27.forward = Vector3.New(var_172_32.x, var_172_32.y, var_172_32.z)

				local var_172_33 = var_172_27.localEulerAngles

				var_172_33.z = 0
				var_172_33.x = 0
				var_172_27.localEulerAngles = var_172_33
			end

			if arg_169_1.time_ >= var_172_28 + var_172_29 and arg_169_1.time_ < var_172_28 + var_172_29 + arg_172_0 then
				var_172_27.localPosition = Vector3.New(0, 100, 0)

				local var_172_34 = manager.ui.mainCamera.transform.position - var_172_27.position

				var_172_27.forward = Vector3.New(var_172_34.x, var_172_34.y, var_172_34.z)

				local var_172_35 = var_172_27.localEulerAngles

				var_172_35.z = 0
				var_172_35.x = 0
				var_172_27.localEulerAngles = var_172_35
			end

			local var_172_36 = arg_169_1.actors_["1049ui_story"]
			local var_172_37 = 1.96599999815226

			if var_172_37 < arg_169_1.time_ and arg_169_1.time_ <= var_172_37 + arg_172_0 and not isNil(var_172_36) and arg_169_1.var_.characterEffect1049ui_story == nil then
				arg_169_1.var_.characterEffect1049ui_story = var_172_36:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_172_38 = 0.034000001847744

			if var_172_37 <= arg_169_1.time_ and arg_169_1.time_ < var_172_37 + var_172_38 and not isNil(var_172_36) then
				local var_172_39 = (arg_169_1.time_ - var_172_37) / var_172_38

				if arg_169_1.var_.characterEffect1049ui_story and not isNil(var_172_36) then
					local var_172_40 = Mathf.Lerp(0, 0.5, var_172_39)

					arg_169_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_169_1.var_.characterEffect1049ui_story.fillRatio = var_172_40
				end
			end

			if arg_169_1.time_ >= var_172_37 + var_172_38 and arg_169_1.time_ < var_172_37 + var_172_38 + arg_172_0 and not isNil(var_172_36) and arg_169_1.var_.characterEffect1049ui_story then
				local var_172_41 = 0.5

				arg_169_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_169_1.var_.characterEffect1049ui_story.fillRatio = var_172_41
			end

			local var_172_42 = 2.2
			local var_172_43 = 1

			if var_172_42 < arg_169_1.time_ and arg_169_1.time_ <= var_172_42 + arg_172_0 then
				local var_172_44 = "play"
				local var_172_45 = "effect"

				arg_169_1:AudioAction(var_172_44, var_172_45, "se_story_side_1049", "se_story_side_1049_curtain", "")
			end

			if arg_169_1.frameCnt_ <= 1 then
				arg_169_1.dialog_:SetActive(false)
			end

			local var_172_46 = 4
			local var_172_47 = 0.725

			if var_172_46 < arg_169_1.time_ and arg_169_1.time_ <= var_172_46 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0

				arg_169_1.dialog_:SetActive(true)

				arg_169_1.dialogCg_.alpha = 0

				local var_172_48 = LeanTween.value(arg_169_1.dialog_, 0, 1, 0.3)

				var_172_48:setOnUpdate(LuaHelper.FloatAction(function(arg_173_0)
					arg_169_1.dialogCg_.alpha = arg_173_0
				end))
				var_172_48:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_169_1.dialog_)
					var_172_48:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_169_1.duration_ = arg_169_1.duration_ + 0.3

				SetActive(arg_169_1.leftNameGo_, false)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_49 = arg_169_1:GetWordFromCfg(1104902041)
				local var_172_50 = arg_169_1:FormatText(var_172_49.content)

				arg_169_1.text_.text = var_172_50

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_51 = 29
				local var_172_52 = utf8.len(var_172_50)
				local var_172_53 = var_172_51 <= 0 and var_172_47 or var_172_47 * (var_172_52 / var_172_51)

				if var_172_53 > 0 and var_172_47 < var_172_53 then
					arg_169_1.talkMaxDuration = var_172_53
					var_172_46 = var_172_46 + 0.3

					if var_172_53 + var_172_46 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_53 + var_172_46
					end
				end

				arg_169_1.text_.text = var_172_50
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)
				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_54 = var_172_46 + 0.3
			local var_172_55 = math.max(var_172_47, arg_169_1.talkMaxDuration)

			if var_172_54 <= arg_169_1.time_ and arg_169_1.time_ < var_172_54 + var_172_55 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_54) / var_172_55

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_54 + var_172_55 and arg_169_1.time_ < var_172_54 + var_172_55 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_169_1:InitPlayNodeList()
	end,
	Play1104902042 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 1104902042
		arg_175_1.duration_ = 5.77

		local var_175_0 = {
			zh = 4.966,
			ja = 5.766
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
				arg_175_0:Play1104902043(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = "ST11"

			if arg_175_1.bgs_[var_178_0] == nil then
				local var_178_1 = Object.Instantiate(arg_175_1.paintGo_)

				var_178_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_178_0)
				var_178_1.name = var_178_0
				var_178_1.transform.parent = arg_175_1.stage_.transform
				var_178_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_175_1.bgs_[var_178_0] = var_178_1
			end

			local var_178_2 = 0

			if var_178_2 < arg_175_1.time_ and arg_175_1.time_ <= var_178_2 + arg_178_0 then
				local var_178_3 = manager.ui.mainCamera.transform.localPosition
				local var_178_4 = Vector3.New(0, 0, 10) + Vector3.New(var_178_3.x, var_178_3.y, 0)
				local var_178_5 = arg_175_1.bgs_.ST11

				var_178_5.transform.localPosition = var_178_4
				var_178_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_178_6 = var_178_5:GetComponent("SpriteRenderer")

				if var_178_6 and var_178_6.sprite then
					local var_178_7 = (var_178_5.transform.localPosition - var_178_3).z
					local var_178_8 = manager.ui.mainCameraCom_
					local var_178_9 = 2 * var_178_7 * Mathf.Tan(var_178_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_178_10 = var_178_9 * var_178_8.aspect
					local var_178_11 = var_178_6.sprite.bounds.size.x
					local var_178_12 = var_178_6.sprite.bounds.size.y
					local var_178_13 = var_178_10 / var_178_11
					local var_178_14 = var_178_9 / var_178_12
					local var_178_15 = var_178_14 < var_178_13 and var_178_13 or var_178_14

					var_178_5.transform.localScale = Vector3.New(var_178_15, var_178_15, 0)
				end

				for iter_178_0, iter_178_1 in pairs(arg_175_1.bgs_) do
					if iter_178_0 ~= "ST11" then
						iter_178_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_178_16 = 2

			if var_178_16 < arg_175_1.time_ and arg_175_1.time_ <= var_178_16 + arg_178_0 then
				arg_175_1.allBtn_.enabled = false
			end

			local var_178_17 = 0.3

			if arg_175_1.time_ >= var_178_16 + var_178_17 and arg_175_1.time_ < var_178_16 + var_178_17 + arg_178_0 then
				arg_175_1.allBtn_.enabled = true
			end

			local var_178_18 = 0

			if var_178_18 < arg_175_1.time_ and arg_175_1.time_ <= var_178_18 + arg_178_0 then
				arg_175_1.mask_.enabled = true
				arg_175_1.mask_.raycastTarget = true

				arg_175_1:SetGaussion(false)
			end

			local var_178_19 = 2

			if var_178_18 <= arg_175_1.time_ and arg_175_1.time_ < var_178_18 + var_178_19 then
				local var_178_20 = (arg_175_1.time_ - var_178_18) / var_178_19
				local var_178_21 = Color.New(0, 0, 0)

				var_178_21.a = Mathf.Lerp(1, 0, var_178_20)
				arg_175_1.mask_.color = var_178_21
			end

			if arg_175_1.time_ >= var_178_18 + var_178_19 and arg_175_1.time_ < var_178_18 + var_178_19 + arg_178_0 then
				local var_178_22 = Color.New(0, 0, 0)
				local var_178_23 = 0

				arg_175_1.mask_.enabled = false
				var_178_22.a = var_178_23
				arg_175_1.mask_.color = var_178_22
			end

			local var_178_24 = arg_175_1.actors_["1049ui_story"].transform
			local var_178_25 = 2

			if var_178_25 < arg_175_1.time_ and arg_175_1.time_ <= var_178_25 + arg_178_0 then
				arg_175_1.var_.moveOldPos1049ui_story = var_178_24.localPosition
			end

			local var_178_26 = 0.001

			if var_178_25 <= arg_175_1.time_ and arg_175_1.time_ < var_178_25 + var_178_26 then
				local var_178_27 = (arg_175_1.time_ - var_178_25) / var_178_26
				local var_178_28 = Vector3.New(0, -1.2, -6)

				var_178_24.localPosition = Vector3.Lerp(arg_175_1.var_.moveOldPos1049ui_story, var_178_28, var_178_27)

				local var_178_29 = manager.ui.mainCamera.transform.position - var_178_24.position

				var_178_24.forward = Vector3.New(var_178_29.x, var_178_29.y, var_178_29.z)

				local var_178_30 = var_178_24.localEulerAngles

				var_178_30.z = 0
				var_178_30.x = 0
				var_178_24.localEulerAngles = var_178_30
			end

			if arg_175_1.time_ >= var_178_25 + var_178_26 and arg_175_1.time_ < var_178_25 + var_178_26 + arg_178_0 then
				var_178_24.localPosition = Vector3.New(0, -1.2, -6)

				local var_178_31 = manager.ui.mainCamera.transform.position - var_178_24.position

				var_178_24.forward = Vector3.New(var_178_31.x, var_178_31.y, var_178_31.z)

				local var_178_32 = var_178_24.localEulerAngles

				var_178_32.z = 0
				var_178_32.x = 0
				var_178_24.localEulerAngles = var_178_32
			end

			local var_178_33 = arg_175_1.actors_["1049ui_story"]
			local var_178_34 = 2

			if var_178_34 < arg_175_1.time_ and arg_175_1.time_ <= var_178_34 + arg_178_0 and not isNil(var_178_33) and arg_175_1.var_.characterEffect1049ui_story == nil then
				arg_175_1.var_.characterEffect1049ui_story = var_178_33:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_178_35 = 0.200000002980232

			if var_178_34 <= arg_175_1.time_ and arg_175_1.time_ < var_178_34 + var_178_35 and not isNil(var_178_33) then
				local var_178_36 = (arg_175_1.time_ - var_178_34) / var_178_35

				if arg_175_1.var_.characterEffect1049ui_story and not isNil(var_178_33) then
					arg_175_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_175_1.time_ >= var_178_34 + var_178_35 and arg_175_1.time_ < var_178_34 + var_178_35 + arg_178_0 and not isNil(var_178_33) and arg_175_1.var_.characterEffect1049ui_story then
				arg_175_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_178_37 = 2

			if var_178_37 < arg_175_1.time_ and arg_175_1.time_ <= var_178_37 + arg_178_0 then
				arg_175_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action1_1")
			end

			local var_178_38 = 2

			if var_178_38 < arg_175_1.time_ and arg_175_1.time_ <= var_178_38 + arg_178_0 then
				arg_175_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			if arg_175_1.frameCnt_ <= 1 then
				arg_175_1.dialog_:SetActive(false)
			end

			local var_178_39 = 2
			local var_178_40 = 0.25

			if var_178_39 < arg_175_1.time_ and arg_175_1.time_ <= var_178_39 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0

				arg_175_1.dialog_:SetActive(true)

				arg_175_1.dialogCg_.alpha = 0

				local var_178_41 = LeanTween.value(arg_175_1.dialog_, 0, 1, 0.3)

				var_178_41:setOnUpdate(LuaHelper.FloatAction(function(arg_179_0)
					arg_175_1.dialogCg_.alpha = arg_179_0
				end))
				var_178_41:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_175_1.dialog_)
					var_178_41:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_175_1.duration_ = arg_175_1.duration_ + 0.3

				SetActive(arg_175_1.leftNameGo_, true)

				local var_178_42 = arg_175_1:FormatText(StoryNameCfg[551].name)

				arg_175_1.leftNameTxt_.text = var_178_42

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_43 = arg_175_1:GetWordFromCfg(1104902042)
				local var_178_44 = arg_175_1:FormatText(var_178_43.content)

				arg_175_1.text_.text = var_178_44

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_45 = 10
				local var_178_46 = utf8.len(var_178_44)
				local var_178_47 = var_178_45 <= 0 and var_178_40 or var_178_40 * (var_178_46 / var_178_45)

				if var_178_47 > 0 and var_178_40 < var_178_47 then
					arg_175_1.talkMaxDuration = var_178_47
					var_178_39 = var_178_39 + 0.3

					if var_178_47 + var_178_39 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_47 + var_178_39
					end
				end

				arg_175_1.text_.text = var_178_44
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104902", "1104902042", "story_v_side_new_1104902.awb") ~= 0 then
					local var_178_48 = manager.audio:GetVoiceLength("story_v_side_new_1104902", "1104902042", "story_v_side_new_1104902.awb") / 1000

					if var_178_48 + var_178_39 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_48 + var_178_39
					end

					if var_178_43.prefab_name ~= "" and arg_175_1.actors_[var_178_43.prefab_name] ~= nil then
						local var_178_49 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_43.prefab_name].transform, "story_v_side_new_1104902", "1104902042", "story_v_side_new_1104902.awb")

						arg_175_1:RecordAudio("1104902042", var_178_49)
						arg_175_1:RecordAudio("1104902042", var_178_49)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_side_new_1104902", "1104902042", "story_v_side_new_1104902.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_side_new_1104902", "1104902042", "story_v_side_new_1104902.awb")
				end

				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_50 = var_178_39 + 0.3
			local var_178_51 = math.max(var_178_40, arg_175_1.talkMaxDuration)

			if var_178_50 <= arg_175_1.time_ and arg_175_1.time_ < var_178_50 + var_178_51 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_50) / var_178_51

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_50 + var_178_51 and arg_175_1.time_ < var_178_50 + var_178_51 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_175_1:InitPlayNodeList()
	end,
	Play1104902043 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 1104902043
		arg_181_1.duration_ = 7

		local var_181_0 = {
			zh = 7,
			ja = 4.533
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
				arg_181_0:Play1104902044(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = 0

			if var_184_0 < arg_181_1.time_ and arg_181_1.time_ <= var_184_0 + arg_184_0 then
				arg_181_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action7_1")
			end

			local var_184_1 = 0
			local var_184_2 = 0.8

			if var_184_1 < arg_181_1.time_ and arg_181_1.time_ <= var_184_1 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				local var_184_3 = arg_181_1:FormatText(StoryNameCfg[551].name)

				arg_181_1.leftNameTxt_.text = var_184_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_4 = arg_181_1:GetWordFromCfg(1104902043)
				local var_184_5 = arg_181_1:FormatText(var_184_4.content)

				arg_181_1.text_.text = var_184_5

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_6 = 32
				local var_184_7 = utf8.len(var_184_5)
				local var_184_8 = var_184_6 <= 0 and var_184_2 or var_184_2 * (var_184_7 / var_184_6)

				if var_184_8 > 0 and var_184_2 < var_184_8 then
					arg_181_1.talkMaxDuration = var_184_8

					if var_184_8 + var_184_1 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_8 + var_184_1
					end
				end

				arg_181_1.text_.text = var_184_5
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104902", "1104902043", "story_v_side_new_1104902.awb") ~= 0 then
					local var_184_9 = manager.audio:GetVoiceLength("story_v_side_new_1104902", "1104902043", "story_v_side_new_1104902.awb") / 1000

					if var_184_9 + var_184_1 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_9 + var_184_1
					end

					if var_184_4.prefab_name ~= "" and arg_181_1.actors_[var_184_4.prefab_name] ~= nil then
						local var_184_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_4.prefab_name].transform, "story_v_side_new_1104902", "1104902043", "story_v_side_new_1104902.awb")

						arg_181_1:RecordAudio("1104902043", var_184_10)
						arg_181_1:RecordAudio("1104902043", var_184_10)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_side_new_1104902", "1104902043", "story_v_side_new_1104902.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_side_new_1104902", "1104902043", "story_v_side_new_1104902.awb")
				end

				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_11 = math.max(var_184_2, arg_181_1.talkMaxDuration)

			if var_184_1 <= arg_181_1.time_ and arg_181_1.time_ < var_184_1 + var_184_11 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_1) / var_184_11

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_1 + var_184_11 and arg_181_1.time_ < var_184_1 + var_184_11 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {}

		arg_181_1:InitPlayNodeList()
	end,
	Play1104902044 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 1104902044
		arg_185_1.duration_ = 5

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play1104902045(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = arg_185_1.actors_["1049ui_story"]
			local var_188_1 = 0

			if var_188_1 < arg_185_1.time_ and arg_185_1.time_ <= var_188_1 + arg_188_0 and not isNil(var_188_0) and arg_185_1.var_.characterEffect1049ui_story == nil then
				arg_185_1.var_.characterEffect1049ui_story = var_188_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_188_2 = 0.200000002980232

			if var_188_1 <= arg_185_1.time_ and arg_185_1.time_ < var_188_1 + var_188_2 and not isNil(var_188_0) then
				local var_188_3 = (arg_185_1.time_ - var_188_1) / var_188_2

				if arg_185_1.var_.characterEffect1049ui_story and not isNil(var_188_0) then
					local var_188_4 = Mathf.Lerp(0, 0.5, var_188_3)

					arg_185_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_185_1.var_.characterEffect1049ui_story.fillRatio = var_188_4
				end
			end

			if arg_185_1.time_ >= var_188_1 + var_188_2 and arg_185_1.time_ < var_188_1 + var_188_2 + arg_188_0 and not isNil(var_188_0) and arg_185_1.var_.characterEffect1049ui_story then
				local var_188_5 = 0.5

				arg_185_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_185_1.var_.characterEffect1049ui_story.fillRatio = var_188_5
			end

			local var_188_6 = 0
			local var_188_7 = 1.075

			if var_188_6 < arg_185_1.time_ and arg_185_1.time_ <= var_188_6 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				local var_188_8 = arg_185_1:FormatText(StoryNameCfg[7].name)

				arg_185_1.leftNameTxt_.text = var_188_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, true)
				arg_185_1.iconController_:SetSelectedState("hero")

				arg_185_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_185_1.callingController_:SetSelectedState("normal")

				arg_185_1.keyicon_.color = Color.New(1, 1, 1)
				arg_185_1.icon_.color = Color.New(1, 1, 1)

				local var_188_9 = arg_185_1:GetWordFromCfg(1104902044)
				local var_188_10 = arg_185_1:FormatText(var_188_9.content)

				arg_185_1.text_.text = var_188_10

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_11 = 43
				local var_188_12 = utf8.len(var_188_10)
				local var_188_13 = var_188_11 <= 0 and var_188_7 or var_188_7 * (var_188_12 / var_188_11)

				if var_188_13 > 0 and var_188_7 < var_188_13 then
					arg_185_1.talkMaxDuration = var_188_13

					if var_188_13 + var_188_6 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_13 + var_188_6
					end
				end

				arg_185_1.text_.text = var_188_10
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)
				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_14 = math.max(var_188_7, arg_185_1.talkMaxDuration)

			if var_188_6 <= arg_185_1.time_ and arg_185_1.time_ < var_188_6 + var_188_14 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_6) / var_188_14

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_6 + var_188_14 and arg_185_1.time_ < var_188_6 + var_188_14 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {}

		arg_185_1:InitPlayNodeList()
	end,
	Play1104902045 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 1104902045
		arg_189_1.duration_ = 7.83

		local var_189_0 = {
			zh = 7.833,
			ja = 7.566
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
				arg_189_0:Play1104902046(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = arg_189_1.actors_["1049ui_story"]
			local var_192_1 = 0

			if var_192_1 < arg_189_1.time_ and arg_189_1.time_ <= var_192_1 + arg_192_0 and not isNil(var_192_0) and arg_189_1.var_.characterEffect1049ui_story == nil then
				arg_189_1.var_.characterEffect1049ui_story = var_192_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_192_2 = 0.200000002980232

			if var_192_1 <= arg_189_1.time_ and arg_189_1.time_ < var_192_1 + var_192_2 and not isNil(var_192_0) then
				local var_192_3 = (arg_189_1.time_ - var_192_1) / var_192_2

				if arg_189_1.var_.characterEffect1049ui_story and not isNil(var_192_0) then
					arg_189_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_189_1.time_ >= var_192_1 + var_192_2 and arg_189_1.time_ < var_192_1 + var_192_2 + arg_192_0 and not isNil(var_192_0) and arg_189_1.var_.characterEffect1049ui_story then
				arg_189_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_192_4 = 0

			if var_192_4 < arg_189_1.time_ and arg_189_1.time_ <= var_192_4 + arg_192_0 then
				arg_189_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action7_2")
			end

			local var_192_5 = 0

			if var_192_5 < arg_189_1.time_ and arg_189_1.time_ <= var_192_5 + arg_192_0 then
				arg_189_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_192_6 = 0
			local var_192_7 = 0.825

			if var_192_6 < arg_189_1.time_ and arg_189_1.time_ <= var_192_6 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				local var_192_8 = arg_189_1:FormatText(StoryNameCfg[551].name)

				arg_189_1.leftNameTxt_.text = var_192_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_9 = arg_189_1:GetWordFromCfg(1104902045)
				local var_192_10 = arg_189_1:FormatText(var_192_9.content)

				arg_189_1.text_.text = var_192_10

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_11 = 33
				local var_192_12 = utf8.len(var_192_10)
				local var_192_13 = var_192_11 <= 0 and var_192_7 or var_192_7 * (var_192_12 / var_192_11)

				if var_192_13 > 0 and var_192_7 < var_192_13 then
					arg_189_1.talkMaxDuration = var_192_13

					if var_192_13 + var_192_6 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_13 + var_192_6
					end
				end

				arg_189_1.text_.text = var_192_10
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104902", "1104902045", "story_v_side_new_1104902.awb") ~= 0 then
					local var_192_14 = manager.audio:GetVoiceLength("story_v_side_new_1104902", "1104902045", "story_v_side_new_1104902.awb") / 1000

					if var_192_14 + var_192_6 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_14 + var_192_6
					end

					if var_192_9.prefab_name ~= "" and arg_189_1.actors_[var_192_9.prefab_name] ~= nil then
						local var_192_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_9.prefab_name].transform, "story_v_side_new_1104902", "1104902045", "story_v_side_new_1104902.awb")

						arg_189_1:RecordAudio("1104902045", var_192_15)
						arg_189_1:RecordAudio("1104902045", var_192_15)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_side_new_1104902", "1104902045", "story_v_side_new_1104902.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_side_new_1104902", "1104902045", "story_v_side_new_1104902.awb")
				end

				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_16 = math.max(var_192_7, arg_189_1.talkMaxDuration)

			if var_192_6 <= arg_189_1.time_ and arg_189_1.time_ < var_192_6 + var_192_16 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_6) / var_192_16

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_6 + var_192_16 and arg_189_1.time_ < var_192_6 + var_192_16 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {}

		arg_189_1:InitPlayNodeList()
	end,
	Play1104902046 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 1104902046
		arg_193_1.duration_ = 5

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play1104902047(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = arg_193_1.actors_["1049ui_story"]
			local var_196_1 = 0

			if var_196_1 < arg_193_1.time_ and arg_193_1.time_ <= var_196_1 + arg_196_0 and not isNil(var_196_0) and arg_193_1.var_.characterEffect1049ui_story == nil then
				arg_193_1.var_.characterEffect1049ui_story = var_196_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_196_2 = 0.200000002980232

			if var_196_1 <= arg_193_1.time_ and arg_193_1.time_ < var_196_1 + var_196_2 and not isNil(var_196_0) then
				local var_196_3 = (arg_193_1.time_ - var_196_1) / var_196_2

				if arg_193_1.var_.characterEffect1049ui_story and not isNil(var_196_0) then
					local var_196_4 = Mathf.Lerp(0, 0.5, var_196_3)

					arg_193_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_193_1.var_.characterEffect1049ui_story.fillRatio = var_196_4
				end
			end

			if arg_193_1.time_ >= var_196_1 + var_196_2 and arg_193_1.time_ < var_196_1 + var_196_2 + arg_196_0 and not isNil(var_196_0) and arg_193_1.var_.characterEffect1049ui_story then
				local var_196_5 = 0.5

				arg_193_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_193_1.var_.characterEffect1049ui_story.fillRatio = var_196_5
			end

			local var_196_6 = 0
			local var_196_7 = 1.025

			if var_196_6 < arg_193_1.time_ and arg_193_1.time_ <= var_196_6 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				local var_196_8 = arg_193_1:FormatText(StoryNameCfg[7].name)

				arg_193_1.leftNameTxt_.text = var_196_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, true)
				arg_193_1.iconController_:SetSelectedState("hero")

				arg_193_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_193_1.callingController_:SetSelectedState("normal")

				arg_193_1.keyicon_.color = Color.New(1, 1, 1)
				arg_193_1.icon_.color = Color.New(1, 1, 1)

				local var_196_9 = arg_193_1:GetWordFromCfg(1104902046)
				local var_196_10 = arg_193_1:FormatText(var_196_9.content)

				arg_193_1.text_.text = var_196_10

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_11 = 41
				local var_196_12 = utf8.len(var_196_10)
				local var_196_13 = var_196_11 <= 0 and var_196_7 or var_196_7 * (var_196_12 / var_196_11)

				if var_196_13 > 0 and var_196_7 < var_196_13 then
					arg_193_1.talkMaxDuration = var_196_13

					if var_196_13 + var_196_6 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_13 + var_196_6
					end
				end

				arg_193_1.text_.text = var_196_10
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)
				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_14 = math.max(var_196_7, arg_193_1.talkMaxDuration)

			if var_196_6 <= arg_193_1.time_ and arg_193_1.time_ < var_196_6 + var_196_14 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_6) / var_196_14

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_6 + var_196_14 and arg_193_1.time_ < var_196_6 + var_196_14 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {}

		arg_193_1:InitPlayNodeList()
	end,
	Play1104902047 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 1104902047
		arg_197_1.duration_ = 11.5

		local var_197_0 = {
			zh = 4.5,
			ja = 11.5
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
				arg_197_0:Play1104902048(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = arg_197_1.actors_["1049ui_story"].transform
			local var_200_1 = 0

			if var_200_1 < arg_197_1.time_ and arg_197_1.time_ <= var_200_1 + arg_200_0 then
				arg_197_1.var_.moveOldPos1049ui_story = var_200_0.localPosition
			end

			local var_200_2 = 0.001

			if var_200_1 <= arg_197_1.time_ and arg_197_1.time_ < var_200_1 + var_200_2 then
				local var_200_3 = (arg_197_1.time_ - var_200_1) / var_200_2
				local var_200_4 = Vector3.New(0, -1.2, -6)

				var_200_0.localPosition = Vector3.Lerp(arg_197_1.var_.moveOldPos1049ui_story, var_200_4, var_200_3)

				local var_200_5 = manager.ui.mainCamera.transform.position - var_200_0.position

				var_200_0.forward = Vector3.New(var_200_5.x, var_200_5.y, var_200_5.z)

				local var_200_6 = var_200_0.localEulerAngles

				var_200_6.z = 0
				var_200_6.x = 0
				var_200_0.localEulerAngles = var_200_6
			end

			if arg_197_1.time_ >= var_200_1 + var_200_2 and arg_197_1.time_ < var_200_1 + var_200_2 + arg_200_0 then
				var_200_0.localPosition = Vector3.New(0, -1.2, -6)

				local var_200_7 = manager.ui.mainCamera.transform.position - var_200_0.position

				var_200_0.forward = Vector3.New(var_200_7.x, var_200_7.y, var_200_7.z)

				local var_200_8 = var_200_0.localEulerAngles

				var_200_8.z = 0
				var_200_8.x = 0
				var_200_0.localEulerAngles = var_200_8
			end

			local var_200_9 = arg_197_1.actors_["1049ui_story"]
			local var_200_10 = 0

			if var_200_10 < arg_197_1.time_ and arg_197_1.time_ <= var_200_10 + arg_200_0 and not isNil(var_200_9) and arg_197_1.var_.characterEffect1049ui_story == nil then
				arg_197_1.var_.characterEffect1049ui_story = var_200_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_200_11 = 0.200000002980232

			if var_200_10 <= arg_197_1.time_ and arg_197_1.time_ < var_200_10 + var_200_11 and not isNil(var_200_9) then
				local var_200_12 = (arg_197_1.time_ - var_200_10) / var_200_11

				if arg_197_1.var_.characterEffect1049ui_story and not isNil(var_200_9) then
					arg_197_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_197_1.time_ >= var_200_10 + var_200_11 and arg_197_1.time_ < var_200_10 + var_200_11 + arg_200_0 and not isNil(var_200_9) and arg_197_1.var_.characterEffect1049ui_story then
				arg_197_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_200_13 = 0

			if var_200_13 < arg_197_1.time_ and arg_197_1.time_ <= var_200_13 + arg_200_0 then
				arg_197_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action8_1")
			end

			local var_200_14 = 0

			if var_200_14 < arg_197_1.time_ and arg_197_1.time_ <= var_200_14 + arg_200_0 then
				arg_197_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_200_15 = 0
			local var_200_16 = 0.525

			if var_200_15 < arg_197_1.time_ and arg_197_1.time_ <= var_200_15 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				local var_200_17 = arg_197_1:FormatText(StoryNameCfg[551].name)

				arg_197_1.leftNameTxt_.text = var_200_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_18 = arg_197_1:GetWordFromCfg(1104902047)
				local var_200_19 = arg_197_1:FormatText(var_200_18.content)

				arg_197_1.text_.text = var_200_19

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_20 = 21
				local var_200_21 = utf8.len(var_200_19)
				local var_200_22 = var_200_20 <= 0 and var_200_16 or var_200_16 * (var_200_21 / var_200_20)

				if var_200_22 > 0 and var_200_16 < var_200_22 then
					arg_197_1.talkMaxDuration = var_200_22

					if var_200_22 + var_200_15 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_22 + var_200_15
					end
				end

				arg_197_1.text_.text = var_200_19
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104902", "1104902047", "story_v_side_new_1104902.awb") ~= 0 then
					local var_200_23 = manager.audio:GetVoiceLength("story_v_side_new_1104902", "1104902047", "story_v_side_new_1104902.awb") / 1000

					if var_200_23 + var_200_15 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_23 + var_200_15
					end

					if var_200_18.prefab_name ~= "" and arg_197_1.actors_[var_200_18.prefab_name] ~= nil then
						local var_200_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_18.prefab_name].transform, "story_v_side_new_1104902", "1104902047", "story_v_side_new_1104902.awb")

						arg_197_1:RecordAudio("1104902047", var_200_24)
						arg_197_1:RecordAudio("1104902047", var_200_24)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_side_new_1104902", "1104902047", "story_v_side_new_1104902.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_side_new_1104902", "1104902047", "story_v_side_new_1104902.awb")
				end

				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_25 = math.max(var_200_16, arg_197_1.talkMaxDuration)

			if var_200_15 <= arg_197_1.time_ and arg_197_1.time_ < var_200_15 + var_200_25 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_15) / var_200_25

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_15 + var_200_25 and arg_197_1.time_ < var_200_15 + var_200_25 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_197_1:InitPlayNodeList()
	end,
	Play1104902048 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 1104902048
		arg_201_1.duration_ = 5

		SetActive(arg_201_1.tipsGo_, false)

		function arg_201_1.onSingleLineFinish_()
			arg_201_1.onSingleLineUpdate_ = nil
			arg_201_1.onSingleLineFinish_ = nil
			arg_201_1.state_ = "waiting"
		end

		function arg_201_1.playNext_(arg_203_0)
			if arg_203_0 == 1 then
				arg_201_0:Play1104902049(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = arg_201_1.actors_["1049ui_story"]
			local var_204_1 = 0

			if var_204_1 < arg_201_1.time_ and arg_201_1.time_ <= var_204_1 + arg_204_0 and not isNil(var_204_0) and arg_201_1.var_.characterEffect1049ui_story == nil then
				arg_201_1.var_.characterEffect1049ui_story = var_204_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_204_2 = 0.200000002980232

			if var_204_1 <= arg_201_1.time_ and arg_201_1.time_ < var_204_1 + var_204_2 and not isNil(var_204_0) then
				local var_204_3 = (arg_201_1.time_ - var_204_1) / var_204_2

				if arg_201_1.var_.characterEffect1049ui_story and not isNil(var_204_0) then
					local var_204_4 = Mathf.Lerp(0, 0.5, var_204_3)

					arg_201_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_201_1.var_.characterEffect1049ui_story.fillRatio = var_204_4
				end
			end

			if arg_201_1.time_ >= var_204_1 + var_204_2 and arg_201_1.time_ < var_204_1 + var_204_2 + arg_204_0 and not isNil(var_204_0) and arg_201_1.var_.characterEffect1049ui_story then
				local var_204_5 = 0.5

				arg_201_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_201_1.var_.characterEffect1049ui_story.fillRatio = var_204_5
			end

			local var_204_6 = 0
			local var_204_7 = 0.25

			if var_204_6 < arg_201_1.time_ and arg_201_1.time_ <= var_204_6 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				local var_204_8 = arg_201_1:FormatText(StoryNameCfg[7].name)

				arg_201_1.leftNameTxt_.text = var_204_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, true)
				arg_201_1.iconController_:SetSelectedState("hero")

				arg_201_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_201_1.callingController_:SetSelectedState("normal")

				arg_201_1.keyicon_.color = Color.New(1, 1, 1)
				arg_201_1.icon_.color = Color.New(1, 1, 1)

				local var_204_9 = arg_201_1:GetWordFromCfg(1104902048)
				local var_204_10 = arg_201_1:FormatText(var_204_9.content)

				arg_201_1.text_.text = var_204_10

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_11 = 10
				local var_204_12 = utf8.len(var_204_10)
				local var_204_13 = var_204_11 <= 0 and var_204_7 or var_204_7 * (var_204_12 / var_204_11)

				if var_204_13 > 0 and var_204_7 < var_204_13 then
					arg_201_1.talkMaxDuration = var_204_13

					if var_204_13 + var_204_6 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_13 + var_204_6
					end
				end

				arg_201_1.text_.text = var_204_10
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)
				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_14 = math.max(var_204_7, arg_201_1.talkMaxDuration)

			if var_204_6 <= arg_201_1.time_ and arg_201_1.time_ < var_204_6 + var_204_14 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_6) / var_204_14

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_6 + var_204_14 and arg_201_1.time_ < var_204_6 + var_204_14 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {}

		arg_201_1:InitPlayNodeList()
	end,
	Play1104902049 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 1104902049
		arg_205_1.duration_ = 5

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play1104902050(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = arg_205_1.actors_["1049ui_story"].transform
			local var_208_1 = 0

			if var_208_1 < arg_205_1.time_ and arg_205_1.time_ <= var_208_1 + arg_208_0 then
				arg_205_1.var_.moveOldPos1049ui_story = var_208_0.localPosition
			end

			local var_208_2 = 0.001

			if var_208_1 <= arg_205_1.time_ and arg_205_1.time_ < var_208_1 + var_208_2 then
				local var_208_3 = (arg_205_1.time_ - var_208_1) / var_208_2
				local var_208_4 = Vector3.New(0, 100, 0)

				var_208_0.localPosition = Vector3.Lerp(arg_205_1.var_.moveOldPos1049ui_story, var_208_4, var_208_3)

				local var_208_5 = manager.ui.mainCamera.transform.position - var_208_0.position

				var_208_0.forward = Vector3.New(var_208_5.x, var_208_5.y, var_208_5.z)

				local var_208_6 = var_208_0.localEulerAngles

				var_208_6.z = 0
				var_208_6.x = 0
				var_208_0.localEulerAngles = var_208_6
			end

			if arg_205_1.time_ >= var_208_1 + var_208_2 and arg_205_1.time_ < var_208_1 + var_208_2 + arg_208_0 then
				var_208_0.localPosition = Vector3.New(0, 100, 0)

				local var_208_7 = manager.ui.mainCamera.transform.position - var_208_0.position

				var_208_0.forward = Vector3.New(var_208_7.x, var_208_7.y, var_208_7.z)

				local var_208_8 = var_208_0.localEulerAngles

				var_208_8.z = 0
				var_208_8.x = 0
				var_208_0.localEulerAngles = var_208_8
			end

			local var_208_9 = arg_205_1.actors_["1049ui_story"]
			local var_208_10 = 0

			if var_208_10 < arg_205_1.time_ and arg_205_1.time_ <= var_208_10 + arg_208_0 and not isNil(var_208_9) and arg_205_1.var_.characterEffect1049ui_story == nil then
				arg_205_1.var_.characterEffect1049ui_story = var_208_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_208_11 = 0.200000002980232

			if var_208_10 <= arg_205_1.time_ and arg_205_1.time_ < var_208_10 + var_208_11 and not isNil(var_208_9) then
				local var_208_12 = (arg_205_1.time_ - var_208_10) / var_208_11

				if arg_205_1.var_.characterEffect1049ui_story and not isNil(var_208_9) then
					local var_208_13 = Mathf.Lerp(0, 0.5, var_208_12)

					arg_205_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_205_1.var_.characterEffect1049ui_story.fillRatio = var_208_13
				end
			end

			if arg_205_1.time_ >= var_208_10 + var_208_11 and arg_205_1.time_ < var_208_10 + var_208_11 + arg_208_0 and not isNil(var_208_9) and arg_205_1.var_.characterEffect1049ui_story then
				local var_208_14 = 0.5

				arg_205_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_205_1.var_.characterEffect1049ui_story.fillRatio = var_208_14
			end

			local var_208_15 = 0
			local var_208_16 = 0.625

			if var_208_15 < arg_205_1.time_ and arg_205_1.time_ <= var_208_15 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, false)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_17 = arg_205_1:GetWordFromCfg(1104902049)
				local var_208_18 = arg_205_1:FormatText(var_208_17.content)

				arg_205_1.text_.text = var_208_18

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_19 = 25
				local var_208_20 = utf8.len(var_208_18)
				local var_208_21 = var_208_19 <= 0 and var_208_16 or var_208_16 * (var_208_20 / var_208_19)

				if var_208_21 > 0 and var_208_16 < var_208_21 then
					arg_205_1.talkMaxDuration = var_208_21

					if var_208_21 + var_208_15 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_21 + var_208_15
					end
				end

				arg_205_1.text_.text = var_208_18
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)
				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_22 = math.max(var_208_16, arg_205_1.talkMaxDuration)

			if var_208_15 <= arg_205_1.time_ and arg_205_1.time_ < var_208_15 + var_208_22 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_15) / var_208_22

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_15 + var_208_22 and arg_205_1.time_ < var_208_15 + var_208_22 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_205_1:InitPlayNodeList()
	end,
	Play1104902050 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 1104902050
		arg_209_1.duration_ = 6.27

		local var_209_0 = {
			zh = 3.466,
			ja = 6.266
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
				arg_209_0:Play1104902051(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			local var_212_0 = arg_209_1.actors_["1049ui_story"].transform
			local var_212_1 = 0

			if var_212_1 < arg_209_1.time_ and arg_209_1.time_ <= var_212_1 + arg_212_0 then
				arg_209_1.var_.moveOldPos1049ui_story = var_212_0.localPosition
			end

			local var_212_2 = 0.001

			if var_212_1 <= arg_209_1.time_ and arg_209_1.time_ < var_212_1 + var_212_2 then
				local var_212_3 = (arg_209_1.time_ - var_212_1) / var_212_2
				local var_212_4 = Vector3.New(0, -1.2, -6)

				var_212_0.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPos1049ui_story, var_212_4, var_212_3)

				local var_212_5 = manager.ui.mainCamera.transform.position - var_212_0.position

				var_212_0.forward = Vector3.New(var_212_5.x, var_212_5.y, var_212_5.z)

				local var_212_6 = var_212_0.localEulerAngles

				var_212_6.z = 0
				var_212_6.x = 0
				var_212_0.localEulerAngles = var_212_6
			end

			if arg_209_1.time_ >= var_212_1 + var_212_2 and arg_209_1.time_ < var_212_1 + var_212_2 + arg_212_0 then
				var_212_0.localPosition = Vector3.New(0, -1.2, -6)

				local var_212_7 = manager.ui.mainCamera.transform.position - var_212_0.position

				var_212_0.forward = Vector3.New(var_212_7.x, var_212_7.y, var_212_7.z)

				local var_212_8 = var_212_0.localEulerAngles

				var_212_8.z = 0
				var_212_8.x = 0
				var_212_0.localEulerAngles = var_212_8
			end

			local var_212_9 = arg_209_1.actors_["1049ui_story"]
			local var_212_10 = 0

			if var_212_10 < arg_209_1.time_ and arg_209_1.time_ <= var_212_10 + arg_212_0 and not isNil(var_212_9) and arg_209_1.var_.characterEffect1049ui_story == nil then
				arg_209_1.var_.characterEffect1049ui_story = var_212_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_212_11 = 0.200000002980232

			if var_212_10 <= arg_209_1.time_ and arg_209_1.time_ < var_212_10 + var_212_11 and not isNil(var_212_9) then
				local var_212_12 = (arg_209_1.time_ - var_212_10) / var_212_11

				if arg_209_1.var_.characterEffect1049ui_story and not isNil(var_212_9) then
					arg_209_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_209_1.time_ >= var_212_10 + var_212_11 and arg_209_1.time_ < var_212_10 + var_212_11 + arg_212_0 and not isNil(var_212_9) and arg_209_1.var_.characterEffect1049ui_story then
				arg_209_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_212_13 = 0

			if var_212_13 < arg_209_1.time_ and arg_209_1.time_ <= var_212_13 + arg_212_0 then
				arg_209_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action8_2")
			end

			local var_212_14 = 0

			if var_212_14 < arg_209_1.time_ and arg_209_1.time_ <= var_212_14 + arg_212_0 then
				arg_209_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_212_15 = 0
			local var_212_16 = 0.35

			if var_212_15 < arg_209_1.time_ and arg_209_1.time_ <= var_212_15 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				local var_212_17 = arg_209_1:FormatText(StoryNameCfg[551].name)

				arg_209_1.leftNameTxt_.text = var_212_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_18 = arg_209_1:GetWordFromCfg(1104902050)
				local var_212_19 = arg_209_1:FormatText(var_212_18.content)

				arg_209_1.text_.text = var_212_19

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_20 = 14
				local var_212_21 = utf8.len(var_212_19)
				local var_212_22 = var_212_20 <= 0 and var_212_16 or var_212_16 * (var_212_21 / var_212_20)

				if var_212_22 > 0 and var_212_16 < var_212_22 then
					arg_209_1.talkMaxDuration = var_212_22

					if var_212_22 + var_212_15 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_22 + var_212_15
					end
				end

				arg_209_1.text_.text = var_212_19
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104902", "1104902050", "story_v_side_new_1104902.awb") ~= 0 then
					local var_212_23 = manager.audio:GetVoiceLength("story_v_side_new_1104902", "1104902050", "story_v_side_new_1104902.awb") / 1000

					if var_212_23 + var_212_15 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_23 + var_212_15
					end

					if var_212_18.prefab_name ~= "" and arg_209_1.actors_[var_212_18.prefab_name] ~= nil then
						local var_212_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_209_1.actors_[var_212_18.prefab_name].transform, "story_v_side_new_1104902", "1104902050", "story_v_side_new_1104902.awb")

						arg_209_1:RecordAudio("1104902050", var_212_24)
						arg_209_1:RecordAudio("1104902050", var_212_24)
					else
						arg_209_1:AudioAction("play", "voice", "story_v_side_new_1104902", "1104902050", "story_v_side_new_1104902.awb")
					end

					arg_209_1:RecordHistoryTalkVoice("story_v_side_new_1104902", "1104902050", "story_v_side_new_1104902.awb")
				end

				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_25 = math.max(var_212_16, arg_209_1.talkMaxDuration)

			if var_212_15 <= arg_209_1.time_ and arg_209_1.time_ < var_212_15 + var_212_25 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_15) / var_212_25

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_15 + var_212_25 and arg_209_1.time_ < var_212_15 + var_212_25 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_209_1:InitPlayNodeList()
	end,
	Play1104902051 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 1104902051
		arg_213_1.duration_ = 5

		SetActive(arg_213_1.tipsGo_, false)

		function arg_213_1.onSingleLineFinish_()
			arg_213_1.onSingleLineUpdate_ = nil
			arg_213_1.onSingleLineFinish_ = nil
			arg_213_1.state_ = "waiting"
		end

		function arg_213_1.playNext_(arg_215_0)
			if arg_215_0 == 1 then
				arg_213_0:Play1104902052(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			local var_216_0 = arg_213_1.actors_["1049ui_story"]
			local var_216_1 = 0

			if var_216_1 < arg_213_1.time_ and arg_213_1.time_ <= var_216_1 + arg_216_0 and not isNil(var_216_0) and arg_213_1.var_.characterEffect1049ui_story == nil then
				arg_213_1.var_.characterEffect1049ui_story = var_216_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_216_2 = 0.200000002980232

			if var_216_1 <= arg_213_1.time_ and arg_213_1.time_ < var_216_1 + var_216_2 and not isNil(var_216_0) then
				local var_216_3 = (arg_213_1.time_ - var_216_1) / var_216_2

				if arg_213_1.var_.characterEffect1049ui_story and not isNil(var_216_0) then
					local var_216_4 = Mathf.Lerp(0, 0.5, var_216_3)

					arg_213_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_213_1.var_.characterEffect1049ui_story.fillRatio = var_216_4
				end
			end

			if arg_213_1.time_ >= var_216_1 + var_216_2 and arg_213_1.time_ < var_216_1 + var_216_2 + arg_216_0 and not isNil(var_216_0) and arg_213_1.var_.characterEffect1049ui_story then
				local var_216_5 = 0.5

				arg_213_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_213_1.var_.characterEffect1049ui_story.fillRatio = var_216_5
			end

			local var_216_6 = 0
			local var_216_7 = 0.4

			if var_216_6 < arg_213_1.time_ and arg_213_1.time_ <= var_216_6 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				local var_216_8 = arg_213_1:FormatText(StoryNameCfg[7].name)

				arg_213_1.leftNameTxt_.text = var_216_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, true)
				arg_213_1.iconController_:SetSelectedState("hero")

				arg_213_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_213_1.callingController_:SetSelectedState("normal")

				arg_213_1.keyicon_.color = Color.New(1, 1, 1)
				arg_213_1.icon_.color = Color.New(1, 1, 1)

				local var_216_9 = arg_213_1:GetWordFromCfg(1104902051)
				local var_216_10 = arg_213_1:FormatText(var_216_9.content)

				arg_213_1.text_.text = var_216_10

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_11 = 16
				local var_216_12 = utf8.len(var_216_10)
				local var_216_13 = var_216_11 <= 0 and var_216_7 or var_216_7 * (var_216_12 / var_216_11)

				if var_216_13 > 0 and var_216_7 < var_216_13 then
					arg_213_1.talkMaxDuration = var_216_13

					if var_216_13 + var_216_6 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_13 + var_216_6
					end
				end

				arg_213_1.text_.text = var_216_10
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)
				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_14 = math.max(var_216_7, arg_213_1.talkMaxDuration)

			if var_216_6 <= arg_213_1.time_ and arg_213_1.time_ < var_216_6 + var_216_14 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_6) / var_216_14

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_6 + var_216_14 and arg_213_1.time_ < var_216_6 + var_216_14 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {}

		arg_213_1:InitPlayNodeList()
	end,
	Play1104902052 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 1104902052
		arg_217_1.duration_ = 7.4

		local var_217_0 = {
			zh = 6.1,
			ja = 7.4
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
				arg_217_0:Play1104902053(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			local var_220_0 = arg_217_1.actors_["1049ui_story"].transform
			local var_220_1 = 0

			if var_220_1 < arg_217_1.time_ and arg_217_1.time_ <= var_220_1 + arg_220_0 then
				arg_217_1.var_.moveOldPos1049ui_story = var_220_0.localPosition
			end

			local var_220_2 = 0.001

			if var_220_1 <= arg_217_1.time_ and arg_217_1.time_ < var_220_1 + var_220_2 then
				local var_220_3 = (arg_217_1.time_ - var_220_1) / var_220_2
				local var_220_4 = Vector3.New(0, -1.2, -6)

				var_220_0.localPosition = Vector3.Lerp(arg_217_1.var_.moveOldPos1049ui_story, var_220_4, var_220_3)

				local var_220_5 = manager.ui.mainCamera.transform.position - var_220_0.position

				var_220_0.forward = Vector3.New(var_220_5.x, var_220_5.y, var_220_5.z)

				local var_220_6 = var_220_0.localEulerAngles

				var_220_6.z = 0
				var_220_6.x = 0
				var_220_0.localEulerAngles = var_220_6
			end

			if arg_217_1.time_ >= var_220_1 + var_220_2 and arg_217_1.time_ < var_220_1 + var_220_2 + arg_220_0 then
				var_220_0.localPosition = Vector3.New(0, -1.2, -6)

				local var_220_7 = manager.ui.mainCamera.transform.position - var_220_0.position

				var_220_0.forward = Vector3.New(var_220_7.x, var_220_7.y, var_220_7.z)

				local var_220_8 = var_220_0.localEulerAngles

				var_220_8.z = 0
				var_220_8.x = 0
				var_220_0.localEulerAngles = var_220_8
			end

			local var_220_9 = arg_217_1.actors_["1049ui_story"]
			local var_220_10 = 0

			if var_220_10 < arg_217_1.time_ and arg_217_1.time_ <= var_220_10 + arg_220_0 and not isNil(var_220_9) and arg_217_1.var_.characterEffect1049ui_story == nil then
				arg_217_1.var_.characterEffect1049ui_story = var_220_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_220_11 = 0.200000002980232

			if var_220_10 <= arg_217_1.time_ and arg_217_1.time_ < var_220_10 + var_220_11 and not isNil(var_220_9) then
				local var_220_12 = (arg_217_1.time_ - var_220_10) / var_220_11

				if arg_217_1.var_.characterEffect1049ui_story and not isNil(var_220_9) then
					arg_217_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_217_1.time_ >= var_220_10 + var_220_11 and arg_217_1.time_ < var_220_10 + var_220_11 + arg_220_0 and not isNil(var_220_9) and arg_217_1.var_.characterEffect1049ui_story then
				arg_217_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_220_13 = 0

			if var_220_13 < arg_217_1.time_ and arg_217_1.time_ <= var_220_13 + arg_220_0 then
				arg_217_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action1_1")
			end

			local var_220_14 = 0

			if var_220_14 < arg_217_1.time_ and arg_217_1.time_ <= var_220_14 + arg_220_0 then
				arg_217_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_220_15 = 0
			local var_220_16 = 0.45

			if var_220_15 < arg_217_1.time_ and arg_217_1.time_ <= var_220_15 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				local var_220_17 = arg_217_1:FormatText(StoryNameCfg[551].name)

				arg_217_1.leftNameTxt_.text = var_220_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, false)
				arg_217_1.callingController_:SetSelectedState("normal")

				local var_220_18 = arg_217_1:GetWordFromCfg(1104902052)
				local var_220_19 = arg_217_1:FormatText(var_220_18.content)

				arg_217_1.text_.text = var_220_19

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_20 = 18
				local var_220_21 = utf8.len(var_220_19)
				local var_220_22 = var_220_20 <= 0 and var_220_16 or var_220_16 * (var_220_21 / var_220_20)

				if var_220_22 > 0 and var_220_16 < var_220_22 then
					arg_217_1.talkMaxDuration = var_220_22

					if var_220_22 + var_220_15 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_22 + var_220_15
					end
				end

				arg_217_1.text_.text = var_220_19
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104902", "1104902052", "story_v_side_new_1104902.awb") ~= 0 then
					local var_220_23 = manager.audio:GetVoiceLength("story_v_side_new_1104902", "1104902052", "story_v_side_new_1104902.awb") / 1000

					if var_220_23 + var_220_15 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_23 + var_220_15
					end

					if var_220_18.prefab_name ~= "" and arg_217_1.actors_[var_220_18.prefab_name] ~= nil then
						local var_220_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_217_1.actors_[var_220_18.prefab_name].transform, "story_v_side_new_1104902", "1104902052", "story_v_side_new_1104902.awb")

						arg_217_1:RecordAudio("1104902052", var_220_24)
						arg_217_1:RecordAudio("1104902052", var_220_24)
					else
						arg_217_1:AudioAction("play", "voice", "story_v_side_new_1104902", "1104902052", "story_v_side_new_1104902.awb")
					end

					arg_217_1:RecordHistoryTalkVoice("story_v_side_new_1104902", "1104902052", "story_v_side_new_1104902.awb")
				end

				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_25 = math.max(var_220_16, arg_217_1.talkMaxDuration)

			if var_220_15 <= arg_217_1.time_ and arg_217_1.time_ < var_220_15 + var_220_25 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_15) / var_220_25

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_15 + var_220_25 and arg_217_1.time_ < var_220_15 + var_220_25 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_217_1:InitPlayNodeList()
	end,
	Play1104902053 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 1104902053
		arg_221_1.duration_ = 5

		SetActive(arg_221_1.tipsGo_, false)

		function arg_221_1.onSingleLineFinish_()
			arg_221_1.onSingleLineUpdate_ = nil
			arg_221_1.onSingleLineFinish_ = nil
			arg_221_1.state_ = "waiting"
		end

		function arg_221_1.playNext_(arg_223_0)
			if arg_223_0 == 1 then
				arg_221_0:Play1104902054(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			local var_224_0 = arg_221_1.actors_["1049ui_story"]
			local var_224_1 = 0

			if var_224_1 < arg_221_1.time_ and arg_221_1.time_ <= var_224_1 + arg_224_0 and not isNil(var_224_0) and arg_221_1.var_.characterEffect1049ui_story == nil then
				arg_221_1.var_.characterEffect1049ui_story = var_224_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_224_2 = 0.200000002980232

			if var_224_1 <= arg_221_1.time_ and arg_221_1.time_ < var_224_1 + var_224_2 and not isNil(var_224_0) then
				local var_224_3 = (arg_221_1.time_ - var_224_1) / var_224_2

				if arg_221_1.var_.characterEffect1049ui_story and not isNil(var_224_0) then
					local var_224_4 = Mathf.Lerp(0, 0.5, var_224_3)

					arg_221_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_221_1.var_.characterEffect1049ui_story.fillRatio = var_224_4
				end
			end

			if arg_221_1.time_ >= var_224_1 + var_224_2 and arg_221_1.time_ < var_224_1 + var_224_2 + arg_224_0 and not isNil(var_224_0) and arg_221_1.var_.characterEffect1049ui_story then
				local var_224_5 = 0.5

				arg_221_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_221_1.var_.characterEffect1049ui_story.fillRatio = var_224_5
			end

			local var_224_6 = 0
			local var_224_7 = 0.3

			if var_224_6 < arg_221_1.time_ and arg_221_1.time_ <= var_224_6 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				local var_224_8 = arg_221_1:FormatText(StoryNameCfg[7].name)

				arg_221_1.leftNameTxt_.text = var_224_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, true)
				arg_221_1.iconController_:SetSelectedState("hero")

				arg_221_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_221_1.callingController_:SetSelectedState("normal")

				arg_221_1.keyicon_.color = Color.New(1, 1, 1)
				arg_221_1.icon_.color = Color.New(1, 1, 1)

				local var_224_9 = arg_221_1:GetWordFromCfg(1104902053)
				local var_224_10 = arg_221_1:FormatText(var_224_9.content)

				arg_221_1.text_.text = var_224_10

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_11 = 12
				local var_224_12 = utf8.len(var_224_10)
				local var_224_13 = var_224_11 <= 0 and var_224_7 or var_224_7 * (var_224_12 / var_224_11)

				if var_224_13 > 0 and var_224_7 < var_224_13 then
					arg_221_1.talkMaxDuration = var_224_13

					if var_224_13 + var_224_6 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_13 + var_224_6
					end
				end

				arg_221_1.text_.text = var_224_10
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)
				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_14 = math.max(var_224_7, arg_221_1.talkMaxDuration)

			if var_224_6 <= arg_221_1.time_ and arg_221_1.time_ < var_224_6 + var_224_14 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_6) / var_224_14

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_6 + var_224_14 and arg_221_1.time_ < var_224_6 + var_224_14 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {}

		arg_221_1:InitPlayNodeList()
	end,
	Play1104902054 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 1104902054
		arg_225_1.duration_ = 5.73

		local var_225_0 = {
			zh = 5.7,
			ja = 5.733
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
				arg_225_0:Play1104902055(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			local var_228_0 = arg_225_1.actors_["1049ui_story"].transform
			local var_228_1 = 0

			if var_228_1 < arg_225_1.time_ and arg_225_1.time_ <= var_228_1 + arg_228_0 then
				arg_225_1.var_.moveOldPos1049ui_story = var_228_0.localPosition
			end

			local var_228_2 = 0.001

			if var_228_1 <= arg_225_1.time_ and arg_225_1.time_ < var_228_1 + var_228_2 then
				local var_228_3 = (arg_225_1.time_ - var_228_1) / var_228_2
				local var_228_4 = Vector3.New(0, -1.2, -6)

				var_228_0.localPosition = Vector3.Lerp(arg_225_1.var_.moveOldPos1049ui_story, var_228_4, var_228_3)

				local var_228_5 = manager.ui.mainCamera.transform.position - var_228_0.position

				var_228_0.forward = Vector3.New(var_228_5.x, var_228_5.y, var_228_5.z)

				local var_228_6 = var_228_0.localEulerAngles

				var_228_6.z = 0
				var_228_6.x = 0
				var_228_0.localEulerAngles = var_228_6
			end

			if arg_225_1.time_ >= var_228_1 + var_228_2 and arg_225_1.time_ < var_228_1 + var_228_2 + arg_228_0 then
				var_228_0.localPosition = Vector3.New(0, -1.2, -6)

				local var_228_7 = manager.ui.mainCamera.transform.position - var_228_0.position

				var_228_0.forward = Vector3.New(var_228_7.x, var_228_7.y, var_228_7.z)

				local var_228_8 = var_228_0.localEulerAngles

				var_228_8.z = 0
				var_228_8.x = 0
				var_228_0.localEulerAngles = var_228_8
			end

			local var_228_9 = arg_225_1.actors_["1049ui_story"]
			local var_228_10 = 0

			if var_228_10 < arg_225_1.time_ and arg_225_1.time_ <= var_228_10 + arg_228_0 and not isNil(var_228_9) and arg_225_1.var_.characterEffect1049ui_story == nil then
				arg_225_1.var_.characterEffect1049ui_story = var_228_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_228_11 = 0.200000002980232

			if var_228_10 <= arg_225_1.time_ and arg_225_1.time_ < var_228_10 + var_228_11 and not isNil(var_228_9) then
				local var_228_12 = (arg_225_1.time_ - var_228_10) / var_228_11

				if arg_225_1.var_.characterEffect1049ui_story and not isNil(var_228_9) then
					arg_225_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_225_1.time_ >= var_228_10 + var_228_11 and arg_225_1.time_ < var_228_10 + var_228_11 + arg_228_0 and not isNil(var_228_9) and arg_225_1.var_.characterEffect1049ui_story then
				arg_225_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_228_13 = 0

			if var_228_13 < arg_225_1.time_ and arg_225_1.time_ <= var_228_13 + arg_228_0 then
				arg_225_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action6_1")
			end

			local var_228_14 = 0

			if var_228_14 < arg_225_1.time_ and arg_225_1.time_ <= var_228_14 + arg_228_0 then
				arg_225_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_228_15 = 0
			local var_228_16 = 0.425

			if var_228_15 < arg_225_1.time_ and arg_225_1.time_ <= var_228_15 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				local var_228_17 = arg_225_1:FormatText(StoryNameCfg[551].name)

				arg_225_1.leftNameTxt_.text = var_228_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_18 = arg_225_1:GetWordFromCfg(1104902054)
				local var_228_19 = arg_225_1:FormatText(var_228_18.content)

				arg_225_1.text_.text = var_228_19

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_20 = 17
				local var_228_21 = utf8.len(var_228_19)
				local var_228_22 = var_228_20 <= 0 and var_228_16 or var_228_16 * (var_228_21 / var_228_20)

				if var_228_22 > 0 and var_228_16 < var_228_22 then
					arg_225_1.talkMaxDuration = var_228_22

					if var_228_22 + var_228_15 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_22 + var_228_15
					end
				end

				arg_225_1.text_.text = var_228_19
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104902", "1104902054", "story_v_side_new_1104902.awb") ~= 0 then
					local var_228_23 = manager.audio:GetVoiceLength("story_v_side_new_1104902", "1104902054", "story_v_side_new_1104902.awb") / 1000

					if var_228_23 + var_228_15 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_23 + var_228_15
					end

					if var_228_18.prefab_name ~= "" and arg_225_1.actors_[var_228_18.prefab_name] ~= nil then
						local var_228_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_225_1.actors_[var_228_18.prefab_name].transform, "story_v_side_new_1104902", "1104902054", "story_v_side_new_1104902.awb")

						arg_225_1:RecordAudio("1104902054", var_228_24)
						arg_225_1:RecordAudio("1104902054", var_228_24)
					else
						arg_225_1:AudioAction("play", "voice", "story_v_side_new_1104902", "1104902054", "story_v_side_new_1104902.awb")
					end

					arg_225_1:RecordHistoryTalkVoice("story_v_side_new_1104902", "1104902054", "story_v_side_new_1104902.awb")
				end

				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_25 = math.max(var_228_16, arg_225_1.talkMaxDuration)

			if var_228_15 <= arg_225_1.time_ and arg_225_1.time_ < var_228_15 + var_228_25 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_15) / var_228_25

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_15 + var_228_25 and arg_225_1.time_ < var_228_15 + var_228_25 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_225_1:InitPlayNodeList()
	end,
	Play1104902055 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 1104902055
		arg_229_1.duration_ = 1

		SetActive(arg_229_1.tipsGo_, false)

		function arg_229_1.onSingleLineFinish_()
			arg_229_1.onSingleLineUpdate_ = nil
			arg_229_1.onSingleLineFinish_ = nil
			arg_229_1.state_ = "waiting"

			SetActive(arg_229_1.choicesGo_, true)

			for iter_230_0, iter_230_1 in ipairs(arg_229_1.choices_) do
				local var_230_0 = iter_230_0 <= 1

				SetActive(iter_230_1.go, var_230_0)
			end

			arg_229_1.choices_[1].txt.text = arg_229_1:FormatText(StoryChoiceCfg[874].name)
		end

		function arg_229_1.playNext_(arg_231_0)
			if arg_231_0 == 1 then
				arg_229_0:Play1104902056(arg_229_1)
			end

			arg_229_1:RecordChoiceLog(1104902055, 874)
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			local var_232_0 = arg_229_1.actors_["1049ui_story"]
			local var_232_1 = 0

			if var_232_1 < arg_229_1.time_ and arg_229_1.time_ <= var_232_1 + arg_232_0 and not isNil(var_232_0) and arg_229_1.var_.characterEffect1049ui_story == nil then
				arg_229_1.var_.characterEffect1049ui_story = var_232_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_232_2 = 0.200000002980232

			if var_232_1 <= arg_229_1.time_ and arg_229_1.time_ < var_232_1 + var_232_2 and not isNil(var_232_0) then
				local var_232_3 = (arg_229_1.time_ - var_232_1) / var_232_2

				if arg_229_1.var_.characterEffect1049ui_story and not isNil(var_232_0) then
					local var_232_4 = Mathf.Lerp(0, 0.5, var_232_3)

					arg_229_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_229_1.var_.characterEffect1049ui_story.fillRatio = var_232_4
				end
			end

			if arg_229_1.time_ >= var_232_1 + var_232_2 and arg_229_1.time_ < var_232_1 + var_232_2 + arg_232_0 and not isNil(var_232_0) and arg_229_1.var_.characterEffect1049ui_story then
				local var_232_5 = 0.5

				arg_229_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_229_1.var_.characterEffect1049ui_story.fillRatio = var_232_5
			end

			local var_232_6 = 0

			if var_232_6 < arg_229_1.time_ and arg_229_1.time_ <= var_232_6 + arg_232_0 then
				arg_229_1.allBtn_.enabled = false
			end

			local var_232_7 = 0.6

			if arg_229_1.time_ >= var_232_6 + var_232_7 and arg_229_1.time_ < var_232_6 + var_232_7 + arg_232_0 then
				arg_229_1.allBtn_.enabled = true
			end
		end

		arg_229_1.nodeConfigList_ = {}

		arg_229_1:InitPlayNodeList()
	end,
	Play1104902056 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 1104902056
		arg_233_1.duration_ = 11.27

		local var_233_0 = {
			zh = 8.6,
			ja = 11.266
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
				arg_233_0:Play1104902057(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			local var_236_0 = arg_233_1.actors_["1049ui_story"]
			local var_236_1 = 0

			if var_236_1 < arg_233_1.time_ and arg_233_1.time_ <= var_236_1 + arg_236_0 and not isNil(var_236_0) and arg_233_1.var_.characterEffect1049ui_story == nil then
				arg_233_1.var_.characterEffect1049ui_story = var_236_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_236_2 = 0.200000002980232

			if var_236_1 <= arg_233_1.time_ and arg_233_1.time_ < var_236_1 + var_236_2 and not isNil(var_236_0) then
				local var_236_3 = (arg_233_1.time_ - var_236_1) / var_236_2

				if arg_233_1.var_.characterEffect1049ui_story and not isNil(var_236_0) then
					arg_233_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_233_1.time_ >= var_236_1 + var_236_2 and arg_233_1.time_ < var_236_1 + var_236_2 + arg_236_0 and not isNil(var_236_0) and arg_233_1.var_.characterEffect1049ui_story then
				arg_233_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_236_4 = 0

			if var_236_4 < arg_233_1.time_ and arg_233_1.time_ <= var_236_4 + arg_236_0 then
				arg_233_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_236_5 = 0
			local var_236_6 = 0.6

			if var_236_5 < arg_233_1.time_ and arg_233_1.time_ <= var_236_5 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, true)

				local var_236_7 = arg_233_1:FormatText(StoryNameCfg[551].name)

				arg_233_1.leftNameTxt_.text = var_236_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_233_1.leftNameTxt_.transform)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1.leftNameTxt_.text)
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_8 = arg_233_1:GetWordFromCfg(1104902056)
				local var_236_9 = arg_233_1:FormatText(var_236_8.content)

				arg_233_1.text_.text = var_236_9

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_10 = 24
				local var_236_11 = utf8.len(var_236_9)
				local var_236_12 = var_236_10 <= 0 and var_236_6 or var_236_6 * (var_236_11 / var_236_10)

				if var_236_12 > 0 and var_236_6 < var_236_12 then
					arg_233_1.talkMaxDuration = var_236_12

					if var_236_12 + var_236_5 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_12 + var_236_5
					end
				end

				arg_233_1.text_.text = var_236_9
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104902", "1104902056", "story_v_side_new_1104902.awb") ~= 0 then
					local var_236_13 = manager.audio:GetVoiceLength("story_v_side_new_1104902", "1104902056", "story_v_side_new_1104902.awb") / 1000

					if var_236_13 + var_236_5 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_13 + var_236_5
					end

					if var_236_8.prefab_name ~= "" and arg_233_1.actors_[var_236_8.prefab_name] ~= nil then
						local var_236_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_233_1.actors_[var_236_8.prefab_name].transform, "story_v_side_new_1104902", "1104902056", "story_v_side_new_1104902.awb")

						arg_233_1:RecordAudio("1104902056", var_236_14)
						arg_233_1:RecordAudio("1104902056", var_236_14)
					else
						arg_233_1:AudioAction("play", "voice", "story_v_side_new_1104902", "1104902056", "story_v_side_new_1104902.awb")
					end

					arg_233_1:RecordHistoryTalkVoice("story_v_side_new_1104902", "1104902056", "story_v_side_new_1104902.awb")
				end

				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_15 = math.max(var_236_6, arg_233_1.talkMaxDuration)

			if var_236_5 <= arg_233_1.time_ and arg_233_1.time_ < var_236_5 + var_236_15 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_5) / var_236_15

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_5 + var_236_15 and arg_233_1.time_ < var_236_5 + var_236_15 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {}

		arg_233_1:InitPlayNodeList()
	end,
	Play1104902057 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 1104902057
		arg_237_1.duration_ = 5

		SetActive(arg_237_1.tipsGo_, false)

		function arg_237_1.onSingleLineFinish_()
			arg_237_1.onSingleLineUpdate_ = nil
			arg_237_1.onSingleLineFinish_ = nil
			arg_237_1.state_ = "waiting"
		end

		function arg_237_1.playNext_(arg_239_0)
			if arg_239_0 == 1 then
				arg_237_0:Play1104902058(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			local var_240_0 = arg_237_1.actors_["1049ui_story"]
			local var_240_1 = 0

			if var_240_1 < arg_237_1.time_ and arg_237_1.time_ <= var_240_1 + arg_240_0 and not isNil(var_240_0) and arg_237_1.var_.characterEffect1049ui_story == nil then
				arg_237_1.var_.characterEffect1049ui_story = var_240_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_240_2 = 0.200000002980232

			if var_240_1 <= arg_237_1.time_ and arg_237_1.time_ < var_240_1 + var_240_2 and not isNil(var_240_0) then
				local var_240_3 = (arg_237_1.time_ - var_240_1) / var_240_2

				if arg_237_1.var_.characterEffect1049ui_story and not isNil(var_240_0) then
					local var_240_4 = Mathf.Lerp(0, 0.5, var_240_3)

					arg_237_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_237_1.var_.characterEffect1049ui_story.fillRatio = var_240_4
				end
			end

			if arg_237_1.time_ >= var_240_1 + var_240_2 and arg_237_1.time_ < var_240_1 + var_240_2 + arg_240_0 and not isNil(var_240_0) and arg_237_1.var_.characterEffect1049ui_story then
				local var_240_5 = 0.5

				arg_237_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_237_1.var_.characterEffect1049ui_story.fillRatio = var_240_5
			end

			local var_240_6 = 0
			local var_240_7 = 0.575

			if var_240_6 < arg_237_1.time_ and arg_237_1.time_ <= var_240_6 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, true)

				local var_240_8 = arg_237_1:FormatText(StoryNameCfg[7].name)

				arg_237_1.leftNameTxt_.text = var_240_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_237_1.leftNameTxt_.transform)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1.leftNameTxt_.text)
				SetActive(arg_237_1.iconTrs_.gameObject, true)
				arg_237_1.iconController_:SetSelectedState("hero")

				arg_237_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_237_1.callingController_:SetSelectedState("normal")

				arg_237_1.keyicon_.color = Color.New(1, 1, 1)
				arg_237_1.icon_.color = Color.New(1, 1, 1)

				local var_240_9 = arg_237_1:GetWordFromCfg(1104902057)
				local var_240_10 = arg_237_1:FormatText(var_240_9.content)

				arg_237_1.text_.text = var_240_10

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_11 = 23
				local var_240_12 = utf8.len(var_240_10)
				local var_240_13 = var_240_11 <= 0 and var_240_7 or var_240_7 * (var_240_12 / var_240_11)

				if var_240_13 > 0 and var_240_7 < var_240_13 then
					arg_237_1.talkMaxDuration = var_240_13

					if var_240_13 + var_240_6 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_13 + var_240_6
					end
				end

				arg_237_1.text_.text = var_240_10
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)
				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_14 = math.max(var_240_7, arg_237_1.talkMaxDuration)

			if var_240_6 <= arg_237_1.time_ and arg_237_1.time_ < var_240_6 + var_240_14 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_6) / var_240_14

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_6 + var_240_14 and arg_237_1.time_ < var_240_6 + var_240_14 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {}

		arg_237_1:InitPlayNodeList()
	end,
	Play1104902058 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 1104902058
		arg_241_1.duration_ = 2

		SetActive(arg_241_1.tipsGo_, false)

		function arg_241_1.onSingleLineFinish_()
			arg_241_1.onSingleLineUpdate_ = nil
			arg_241_1.onSingleLineFinish_ = nil
			arg_241_1.state_ = "waiting"
		end

		function arg_241_1.playNext_(arg_243_0)
			if arg_243_0 == 1 then
				arg_241_0:Play1104902059(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			local var_244_0 = arg_241_1.actors_["1049ui_story"].transform
			local var_244_1 = 0

			if var_244_1 < arg_241_1.time_ and arg_241_1.time_ <= var_244_1 + arg_244_0 then
				arg_241_1.var_.moveOldPos1049ui_story = var_244_0.localPosition
			end

			local var_244_2 = 0.001

			if var_244_1 <= arg_241_1.time_ and arg_241_1.time_ < var_244_1 + var_244_2 then
				local var_244_3 = (arg_241_1.time_ - var_244_1) / var_244_2
				local var_244_4 = Vector3.New(0, -1.2, -6)

				var_244_0.localPosition = Vector3.Lerp(arg_241_1.var_.moveOldPos1049ui_story, var_244_4, var_244_3)

				local var_244_5 = manager.ui.mainCamera.transform.position - var_244_0.position

				var_244_0.forward = Vector3.New(var_244_5.x, var_244_5.y, var_244_5.z)

				local var_244_6 = var_244_0.localEulerAngles

				var_244_6.z = 0
				var_244_6.x = 0
				var_244_0.localEulerAngles = var_244_6
			end

			if arg_241_1.time_ >= var_244_1 + var_244_2 and arg_241_1.time_ < var_244_1 + var_244_2 + arg_244_0 then
				var_244_0.localPosition = Vector3.New(0, -1.2, -6)

				local var_244_7 = manager.ui.mainCamera.transform.position - var_244_0.position

				var_244_0.forward = Vector3.New(var_244_7.x, var_244_7.y, var_244_7.z)

				local var_244_8 = var_244_0.localEulerAngles

				var_244_8.z = 0
				var_244_8.x = 0
				var_244_0.localEulerAngles = var_244_8
			end

			local var_244_9 = arg_241_1.actors_["1049ui_story"]
			local var_244_10 = 0

			if var_244_10 < arg_241_1.time_ and arg_241_1.time_ <= var_244_10 + arg_244_0 and not isNil(var_244_9) and arg_241_1.var_.characterEffect1049ui_story == nil then
				arg_241_1.var_.characterEffect1049ui_story = var_244_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_244_11 = 0.200000002980232

			if var_244_10 <= arg_241_1.time_ and arg_241_1.time_ < var_244_10 + var_244_11 and not isNil(var_244_9) then
				local var_244_12 = (arg_241_1.time_ - var_244_10) / var_244_11

				if arg_241_1.var_.characterEffect1049ui_story and not isNil(var_244_9) then
					arg_241_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_241_1.time_ >= var_244_10 + var_244_11 and arg_241_1.time_ < var_244_10 + var_244_11 + arg_244_0 and not isNil(var_244_9) and arg_241_1.var_.characterEffect1049ui_story then
				arg_241_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_244_13 = 0

			if var_244_13 < arg_241_1.time_ and arg_241_1.time_ <= var_244_13 + arg_244_0 then
				arg_241_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action6_2")
			end

			local var_244_14 = 0

			if var_244_14 < arg_241_1.time_ and arg_241_1.time_ <= var_244_14 + arg_244_0 then
				arg_241_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_244_15 = 0
			local var_244_16 = 0.05

			if var_244_15 < arg_241_1.time_ and arg_241_1.time_ <= var_244_15 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, true)

				local var_244_17 = arg_241_1:FormatText(StoryNameCfg[551].name)

				arg_241_1.leftNameTxt_.text = var_244_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_18 = arg_241_1:GetWordFromCfg(1104902058)
				local var_244_19 = arg_241_1:FormatText(var_244_18.content)

				arg_241_1.text_.text = var_244_19

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_20 = 2
				local var_244_21 = utf8.len(var_244_19)
				local var_244_22 = var_244_20 <= 0 and var_244_16 or var_244_16 * (var_244_21 / var_244_20)

				if var_244_22 > 0 and var_244_16 < var_244_22 then
					arg_241_1.talkMaxDuration = var_244_22

					if var_244_22 + var_244_15 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_22 + var_244_15
					end
				end

				arg_241_1.text_.text = var_244_19
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104902", "1104902058", "story_v_side_new_1104902.awb") ~= 0 then
					local var_244_23 = manager.audio:GetVoiceLength("story_v_side_new_1104902", "1104902058", "story_v_side_new_1104902.awb") / 1000

					if var_244_23 + var_244_15 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_23 + var_244_15
					end

					if var_244_18.prefab_name ~= "" and arg_241_1.actors_[var_244_18.prefab_name] ~= nil then
						local var_244_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_241_1.actors_[var_244_18.prefab_name].transform, "story_v_side_new_1104902", "1104902058", "story_v_side_new_1104902.awb")

						arg_241_1:RecordAudio("1104902058", var_244_24)
						arg_241_1:RecordAudio("1104902058", var_244_24)
					else
						arg_241_1:AudioAction("play", "voice", "story_v_side_new_1104902", "1104902058", "story_v_side_new_1104902.awb")
					end

					arg_241_1:RecordHistoryTalkVoice("story_v_side_new_1104902", "1104902058", "story_v_side_new_1104902.awb")
				end

				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_25 = math.max(var_244_16, arg_241_1.talkMaxDuration)

			if var_244_15 <= arg_241_1.time_ and arg_241_1.time_ < var_244_15 + var_244_25 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_15) / var_244_25

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_15 + var_244_25 and arg_241_1.time_ < var_244_15 + var_244_25 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_241_1:InitPlayNodeList()
	end,
	Play1104902059 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 1104902059
		arg_245_1.duration_ = 5

		SetActive(arg_245_1.tipsGo_, false)

		function arg_245_1.onSingleLineFinish_()
			arg_245_1.onSingleLineUpdate_ = nil
			arg_245_1.onSingleLineFinish_ = nil
			arg_245_1.state_ = "waiting"
		end

		function arg_245_1.playNext_(arg_247_0)
			if arg_247_0 == 1 then
				arg_245_0:Play1104902060(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			local var_248_0 = arg_245_1.actors_["1049ui_story"]
			local var_248_1 = 0

			if var_248_1 < arg_245_1.time_ and arg_245_1.time_ <= var_248_1 + arg_248_0 and not isNil(var_248_0) and arg_245_1.var_.characterEffect1049ui_story == nil then
				arg_245_1.var_.characterEffect1049ui_story = var_248_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_248_2 = 0.200000002980232

			if var_248_1 <= arg_245_1.time_ and arg_245_1.time_ < var_248_1 + var_248_2 and not isNil(var_248_0) then
				local var_248_3 = (arg_245_1.time_ - var_248_1) / var_248_2

				if arg_245_1.var_.characterEffect1049ui_story and not isNil(var_248_0) then
					local var_248_4 = Mathf.Lerp(0, 0.5, var_248_3)

					arg_245_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_245_1.var_.characterEffect1049ui_story.fillRatio = var_248_4
				end
			end

			if arg_245_1.time_ >= var_248_1 + var_248_2 and arg_245_1.time_ < var_248_1 + var_248_2 + arg_248_0 and not isNil(var_248_0) and arg_245_1.var_.characterEffect1049ui_story then
				local var_248_5 = 0.5

				arg_245_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_245_1.var_.characterEffect1049ui_story.fillRatio = var_248_5
			end

			local var_248_6 = 0
			local var_248_7 = 0.425

			if var_248_6 < arg_245_1.time_ and arg_245_1.time_ <= var_248_6 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, true)

				local var_248_8 = arg_245_1:FormatText(StoryNameCfg[7].name)

				arg_245_1.leftNameTxt_.text = var_248_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_245_1.leftNameTxt_.transform)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1.leftNameTxt_.text)
				SetActive(arg_245_1.iconTrs_.gameObject, true)
				arg_245_1.iconController_:SetSelectedState("hero")

				arg_245_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_245_1.callingController_:SetSelectedState("normal")

				arg_245_1.keyicon_.color = Color.New(1, 1, 1)
				arg_245_1.icon_.color = Color.New(1, 1, 1)

				local var_248_9 = arg_245_1:GetWordFromCfg(1104902059)
				local var_248_10 = arg_245_1:FormatText(var_248_9.content)

				arg_245_1.text_.text = var_248_10

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_11 = 17
				local var_248_12 = utf8.len(var_248_10)
				local var_248_13 = var_248_11 <= 0 and var_248_7 or var_248_7 * (var_248_12 / var_248_11)

				if var_248_13 > 0 and var_248_7 < var_248_13 then
					arg_245_1.talkMaxDuration = var_248_13

					if var_248_13 + var_248_6 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_13 + var_248_6
					end
				end

				arg_245_1.text_.text = var_248_10
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)
				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_14 = math.max(var_248_7, arg_245_1.talkMaxDuration)

			if var_248_6 <= arg_245_1.time_ and arg_245_1.time_ < var_248_6 + var_248_14 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - var_248_6) / var_248_14

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= var_248_6 + var_248_14 and arg_245_1.time_ < var_248_6 + var_248_14 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {}

		arg_245_1:InitPlayNodeList()
	end,
	Play1104902060 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 1104902060
		arg_249_1.duration_ = 3.8

		local var_249_0 = {
			zh = 3.3,
			ja = 3.8
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
				arg_249_0:Play1104902061(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			local var_252_0 = arg_249_1.actors_["1049ui_story"]
			local var_252_1 = 0

			if var_252_1 < arg_249_1.time_ and arg_249_1.time_ <= var_252_1 + arg_252_0 and not isNil(var_252_0) and arg_249_1.var_.characterEffect1049ui_story == nil then
				arg_249_1.var_.characterEffect1049ui_story = var_252_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_252_2 = 0.200000002980232

			if var_252_1 <= arg_249_1.time_ and arg_249_1.time_ < var_252_1 + var_252_2 and not isNil(var_252_0) then
				local var_252_3 = (arg_249_1.time_ - var_252_1) / var_252_2

				if arg_249_1.var_.characterEffect1049ui_story and not isNil(var_252_0) then
					arg_249_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_249_1.time_ >= var_252_1 + var_252_2 and arg_249_1.time_ < var_252_1 + var_252_2 + arg_252_0 and not isNil(var_252_0) and arg_249_1.var_.characterEffect1049ui_story then
				arg_249_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_252_4 = 0

			if var_252_4 < arg_249_1.time_ and arg_249_1.time_ <= var_252_4 + arg_252_0 then
				arg_249_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action1_1")
			end

			local var_252_5 = 0

			if var_252_5 < arg_249_1.time_ and arg_249_1.time_ <= var_252_5 + arg_252_0 then
				arg_249_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_252_6 = 0
			local var_252_7 = 0.225

			if var_252_6 < arg_249_1.time_ and arg_249_1.time_ <= var_252_6 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				local var_252_8 = arg_249_1:FormatText(StoryNameCfg[551].name)

				arg_249_1.leftNameTxt_.text = var_252_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_9 = arg_249_1:GetWordFromCfg(1104902060)
				local var_252_10 = arg_249_1:FormatText(var_252_9.content)

				arg_249_1.text_.text = var_252_10

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_11 = 9
				local var_252_12 = utf8.len(var_252_10)
				local var_252_13 = var_252_11 <= 0 and var_252_7 or var_252_7 * (var_252_12 / var_252_11)

				if var_252_13 > 0 and var_252_7 < var_252_13 then
					arg_249_1.talkMaxDuration = var_252_13

					if var_252_13 + var_252_6 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_13 + var_252_6
					end
				end

				arg_249_1.text_.text = var_252_10
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104902", "1104902060", "story_v_side_new_1104902.awb") ~= 0 then
					local var_252_14 = manager.audio:GetVoiceLength("story_v_side_new_1104902", "1104902060", "story_v_side_new_1104902.awb") / 1000

					if var_252_14 + var_252_6 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_14 + var_252_6
					end

					if var_252_9.prefab_name ~= "" and arg_249_1.actors_[var_252_9.prefab_name] ~= nil then
						local var_252_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_249_1.actors_[var_252_9.prefab_name].transform, "story_v_side_new_1104902", "1104902060", "story_v_side_new_1104902.awb")

						arg_249_1:RecordAudio("1104902060", var_252_15)
						arg_249_1:RecordAudio("1104902060", var_252_15)
					else
						arg_249_1:AudioAction("play", "voice", "story_v_side_new_1104902", "1104902060", "story_v_side_new_1104902.awb")
					end

					arg_249_1:RecordHistoryTalkVoice("story_v_side_new_1104902", "1104902060", "story_v_side_new_1104902.awb")
				end

				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_16 = math.max(var_252_7, arg_249_1.talkMaxDuration)

			if var_252_6 <= arg_249_1.time_ and arg_249_1.time_ < var_252_6 + var_252_16 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - var_252_6) / var_252_16

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= var_252_6 + var_252_16 and arg_249_1.time_ < var_252_6 + var_252_16 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {}

		arg_249_1:InitPlayNodeList()
	end,
	Play1104902061 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 1104902061
		arg_253_1.duration_ = 5

		SetActive(arg_253_1.tipsGo_, false)

		function arg_253_1.onSingleLineFinish_()
			arg_253_1.onSingleLineUpdate_ = nil
			arg_253_1.onSingleLineFinish_ = nil
			arg_253_1.state_ = "waiting"
		end

		function arg_253_1.playNext_(arg_255_0)
			if arg_255_0 == 1 then
				arg_253_0:Play1104902062(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			local var_256_0 = arg_253_1.actors_["1049ui_story"]
			local var_256_1 = 0

			if var_256_1 < arg_253_1.time_ and arg_253_1.time_ <= var_256_1 + arg_256_0 and not isNil(var_256_0) and arg_253_1.var_.characterEffect1049ui_story == nil then
				arg_253_1.var_.characterEffect1049ui_story = var_256_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_256_2 = 0.200000002980232

			if var_256_1 <= arg_253_1.time_ and arg_253_1.time_ < var_256_1 + var_256_2 and not isNil(var_256_0) then
				local var_256_3 = (arg_253_1.time_ - var_256_1) / var_256_2

				if arg_253_1.var_.characterEffect1049ui_story and not isNil(var_256_0) then
					local var_256_4 = Mathf.Lerp(0, 0.5, var_256_3)

					arg_253_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_253_1.var_.characterEffect1049ui_story.fillRatio = var_256_4
				end
			end

			if arg_253_1.time_ >= var_256_1 + var_256_2 and arg_253_1.time_ < var_256_1 + var_256_2 + arg_256_0 and not isNil(var_256_0) and arg_253_1.var_.characterEffect1049ui_story then
				local var_256_5 = 0.5

				arg_253_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_253_1.var_.characterEffect1049ui_story.fillRatio = var_256_5
			end

			local var_256_6 = 0
			local var_256_7 = 0.325

			if var_256_6 < arg_253_1.time_ and arg_253_1.time_ <= var_256_6 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, true)

				local var_256_8 = arg_253_1:FormatText(StoryNameCfg[7].name)

				arg_253_1.leftNameTxt_.text = var_256_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, true)
				arg_253_1.iconController_:SetSelectedState("hero")

				arg_253_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_253_1.callingController_:SetSelectedState("normal")

				arg_253_1.keyicon_.color = Color.New(1, 1, 1)
				arg_253_1.icon_.color = Color.New(1, 1, 1)

				local var_256_9 = arg_253_1:GetWordFromCfg(1104902061)
				local var_256_10 = arg_253_1:FormatText(var_256_9.content)

				arg_253_1.text_.text = var_256_10

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_11 = 13
				local var_256_12 = utf8.len(var_256_10)
				local var_256_13 = var_256_11 <= 0 and var_256_7 or var_256_7 * (var_256_12 / var_256_11)

				if var_256_13 > 0 and var_256_7 < var_256_13 then
					arg_253_1.talkMaxDuration = var_256_13

					if var_256_13 + var_256_6 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_13 + var_256_6
					end
				end

				arg_253_1.text_.text = var_256_10
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)
				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_14 = math.max(var_256_7, arg_253_1.talkMaxDuration)

			if var_256_6 <= arg_253_1.time_ and arg_253_1.time_ < var_256_6 + var_256_14 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_6) / var_256_14

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_6 + var_256_14 and arg_253_1.time_ < var_256_6 + var_256_14 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {}

		arg_253_1:InitPlayNodeList()
	end,
	Play1104902062 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 1104902062
		arg_257_1.duration_ = 3.67

		local var_257_0 = {
			zh = 1.999999999999,
			ja = 3.666
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
				arg_257_0:Play1104902063(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			local var_260_0 = arg_257_1.actors_["1049ui_story"].transform
			local var_260_1 = 0

			if var_260_1 < arg_257_1.time_ and arg_257_1.time_ <= var_260_1 + arg_260_0 then
				arg_257_1.var_.moveOldPos1049ui_story = var_260_0.localPosition
			end

			local var_260_2 = 0.001

			if var_260_1 <= arg_257_1.time_ and arg_257_1.time_ < var_260_1 + var_260_2 then
				local var_260_3 = (arg_257_1.time_ - var_260_1) / var_260_2
				local var_260_4 = Vector3.New(0, -1.2, -6)

				var_260_0.localPosition = Vector3.Lerp(arg_257_1.var_.moveOldPos1049ui_story, var_260_4, var_260_3)

				local var_260_5 = manager.ui.mainCamera.transform.position - var_260_0.position

				var_260_0.forward = Vector3.New(var_260_5.x, var_260_5.y, var_260_5.z)

				local var_260_6 = var_260_0.localEulerAngles

				var_260_6.z = 0
				var_260_6.x = 0
				var_260_0.localEulerAngles = var_260_6
			end

			if arg_257_1.time_ >= var_260_1 + var_260_2 and arg_257_1.time_ < var_260_1 + var_260_2 + arg_260_0 then
				var_260_0.localPosition = Vector3.New(0, -1.2, -6)

				local var_260_7 = manager.ui.mainCamera.transform.position - var_260_0.position

				var_260_0.forward = Vector3.New(var_260_7.x, var_260_7.y, var_260_7.z)

				local var_260_8 = var_260_0.localEulerAngles

				var_260_8.z = 0
				var_260_8.x = 0
				var_260_0.localEulerAngles = var_260_8
			end

			local var_260_9 = arg_257_1.actors_["1049ui_story"]
			local var_260_10 = 0

			if var_260_10 < arg_257_1.time_ and arg_257_1.time_ <= var_260_10 + arg_260_0 and not isNil(var_260_9) and arg_257_1.var_.characterEffect1049ui_story == nil then
				arg_257_1.var_.characterEffect1049ui_story = var_260_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_260_11 = 0.200000002980232

			if var_260_10 <= arg_257_1.time_ and arg_257_1.time_ < var_260_10 + var_260_11 and not isNil(var_260_9) then
				local var_260_12 = (arg_257_1.time_ - var_260_10) / var_260_11

				if arg_257_1.var_.characterEffect1049ui_story and not isNil(var_260_9) then
					arg_257_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_257_1.time_ >= var_260_10 + var_260_11 and arg_257_1.time_ < var_260_10 + var_260_11 + arg_260_0 and not isNil(var_260_9) and arg_257_1.var_.characterEffect1049ui_story then
				arg_257_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_260_13 = 0

			if var_260_13 < arg_257_1.time_ and arg_257_1.time_ <= var_260_13 + arg_260_0 then
				arg_257_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action5_1")
			end

			local var_260_14 = 0

			if var_260_14 < arg_257_1.time_ and arg_257_1.time_ <= var_260_14 + arg_260_0 then
				arg_257_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_260_15 = 0
			local var_260_16 = 0.125

			if var_260_15 < arg_257_1.time_ and arg_257_1.time_ <= var_260_15 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				local var_260_17 = arg_257_1:FormatText(StoryNameCfg[551].name)

				arg_257_1.leftNameTxt_.text = var_260_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_18 = arg_257_1:GetWordFromCfg(1104902062)
				local var_260_19 = arg_257_1:FormatText(var_260_18.content)

				arg_257_1.text_.text = var_260_19

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_20 = 5
				local var_260_21 = utf8.len(var_260_19)
				local var_260_22 = var_260_20 <= 0 and var_260_16 or var_260_16 * (var_260_21 / var_260_20)

				if var_260_22 > 0 and var_260_16 < var_260_22 then
					arg_257_1.talkMaxDuration = var_260_22

					if var_260_22 + var_260_15 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_22 + var_260_15
					end
				end

				arg_257_1.text_.text = var_260_19
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104902", "1104902062", "story_v_side_new_1104902.awb") ~= 0 then
					local var_260_23 = manager.audio:GetVoiceLength("story_v_side_new_1104902", "1104902062", "story_v_side_new_1104902.awb") / 1000

					if var_260_23 + var_260_15 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_23 + var_260_15
					end

					if var_260_18.prefab_name ~= "" and arg_257_1.actors_[var_260_18.prefab_name] ~= nil then
						local var_260_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_257_1.actors_[var_260_18.prefab_name].transform, "story_v_side_new_1104902", "1104902062", "story_v_side_new_1104902.awb")

						arg_257_1:RecordAudio("1104902062", var_260_24)
						arg_257_1:RecordAudio("1104902062", var_260_24)
					else
						arg_257_1:AudioAction("play", "voice", "story_v_side_new_1104902", "1104902062", "story_v_side_new_1104902.awb")
					end

					arg_257_1:RecordHistoryTalkVoice("story_v_side_new_1104902", "1104902062", "story_v_side_new_1104902.awb")
				end

				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_25 = math.max(var_260_16, arg_257_1.talkMaxDuration)

			if var_260_15 <= arg_257_1.time_ and arg_257_1.time_ < var_260_15 + var_260_25 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_15) / var_260_25

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_15 + var_260_25 and arg_257_1.time_ < var_260_15 + var_260_25 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_257_1:InitPlayNodeList()
	end,
	Play1104902063 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 1104902063
		arg_261_1.duration_ = 5

		SetActive(arg_261_1.tipsGo_, false)

		function arg_261_1.onSingleLineFinish_()
			arg_261_1.onSingleLineUpdate_ = nil
			arg_261_1.onSingleLineFinish_ = nil
			arg_261_1.state_ = "waiting"
		end

		function arg_261_1.playNext_(arg_263_0)
			if arg_263_0 == 1 then
				arg_261_0:Play1104902064(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			local var_264_0 = arg_261_1.actors_["1049ui_story"].transform
			local var_264_1 = 0

			if var_264_1 < arg_261_1.time_ and arg_261_1.time_ <= var_264_1 + arg_264_0 then
				arg_261_1.var_.moveOldPos1049ui_story = var_264_0.localPosition
			end

			local var_264_2 = 0.001

			if var_264_1 <= arg_261_1.time_ and arg_261_1.time_ < var_264_1 + var_264_2 then
				local var_264_3 = (arg_261_1.time_ - var_264_1) / var_264_2
				local var_264_4 = Vector3.New(0, 100, 0)

				var_264_0.localPosition = Vector3.Lerp(arg_261_1.var_.moveOldPos1049ui_story, var_264_4, var_264_3)

				local var_264_5 = manager.ui.mainCamera.transform.position - var_264_0.position

				var_264_0.forward = Vector3.New(var_264_5.x, var_264_5.y, var_264_5.z)

				local var_264_6 = var_264_0.localEulerAngles

				var_264_6.z = 0
				var_264_6.x = 0
				var_264_0.localEulerAngles = var_264_6
			end

			if arg_261_1.time_ >= var_264_1 + var_264_2 and arg_261_1.time_ < var_264_1 + var_264_2 + arg_264_0 then
				var_264_0.localPosition = Vector3.New(0, 100, 0)

				local var_264_7 = manager.ui.mainCamera.transform.position - var_264_0.position

				var_264_0.forward = Vector3.New(var_264_7.x, var_264_7.y, var_264_7.z)

				local var_264_8 = var_264_0.localEulerAngles

				var_264_8.z = 0
				var_264_8.x = 0
				var_264_0.localEulerAngles = var_264_8
			end

			local var_264_9 = arg_261_1.actors_["1049ui_story"]
			local var_264_10 = 0

			if var_264_10 < arg_261_1.time_ and arg_261_1.time_ <= var_264_10 + arg_264_0 and not isNil(var_264_9) and arg_261_1.var_.characterEffect1049ui_story == nil then
				arg_261_1.var_.characterEffect1049ui_story = var_264_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_264_11 = 0.200000002980232

			if var_264_10 <= arg_261_1.time_ and arg_261_1.time_ < var_264_10 + var_264_11 and not isNil(var_264_9) then
				local var_264_12 = (arg_261_1.time_ - var_264_10) / var_264_11

				if arg_261_1.var_.characterEffect1049ui_story and not isNil(var_264_9) then
					local var_264_13 = Mathf.Lerp(0, 0.5, var_264_12)

					arg_261_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_261_1.var_.characterEffect1049ui_story.fillRatio = var_264_13
				end
			end

			if arg_261_1.time_ >= var_264_10 + var_264_11 and arg_261_1.time_ < var_264_10 + var_264_11 + arg_264_0 and not isNil(var_264_9) and arg_261_1.var_.characterEffect1049ui_story then
				local var_264_14 = 0.5

				arg_261_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_261_1.var_.characterEffect1049ui_story.fillRatio = var_264_14
			end

			local var_264_15 = 0
			local var_264_16 = 0.625

			if var_264_15 < arg_261_1.time_ and arg_261_1.time_ <= var_264_15 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, false)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_17 = arg_261_1:GetWordFromCfg(1104902063)
				local var_264_18 = arg_261_1:FormatText(var_264_17.content)

				arg_261_1.text_.text = var_264_18

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_19 = 25
				local var_264_20 = utf8.len(var_264_18)
				local var_264_21 = var_264_19 <= 0 and var_264_16 or var_264_16 * (var_264_20 / var_264_19)

				if var_264_21 > 0 and var_264_16 < var_264_21 then
					arg_261_1.talkMaxDuration = var_264_21

					if var_264_21 + var_264_15 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_21 + var_264_15
					end
				end

				arg_261_1.text_.text = var_264_18
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)
				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_22 = math.max(var_264_16, arg_261_1.talkMaxDuration)

			if var_264_15 <= arg_261_1.time_ and arg_261_1.time_ < var_264_15 + var_264_22 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_15) / var_264_22

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_15 + var_264_22 and arg_261_1.time_ < var_264_15 + var_264_22 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_261_1:InitPlayNodeList()
	end,
	Play1104902064 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 1104902064
		arg_265_1.duration_ = 5

		SetActive(arg_265_1.tipsGo_, false)

		function arg_265_1.onSingleLineFinish_()
			arg_265_1.onSingleLineUpdate_ = nil
			arg_265_1.onSingleLineFinish_ = nil
			arg_265_1.state_ = "waiting"
		end

		function arg_265_1.playNext_(arg_267_0)
			if arg_267_0 == 1 then
				arg_265_0:Play1104902065(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			local var_268_0 = 0
			local var_268_1 = 0.85

			if var_268_0 < arg_265_1.time_ and arg_265_1.time_ <= var_268_0 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, true)

				local var_268_2 = arg_265_1:FormatText(StoryNameCfg[7].name)

				arg_265_1.leftNameTxt_.text = var_268_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_265_1.leftNameTxt_.transform)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1.leftNameTxt_.text)
				SetActive(arg_265_1.iconTrs_.gameObject, true)
				arg_265_1.iconController_:SetSelectedState("hero")

				arg_265_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_265_1.callingController_:SetSelectedState("normal")

				arg_265_1.keyicon_.color = Color.New(1, 1, 1)
				arg_265_1.icon_.color = Color.New(1, 1, 1)

				local var_268_3 = arg_265_1:GetWordFromCfg(1104902064)
				local var_268_4 = arg_265_1:FormatText(var_268_3.content)

				arg_265_1.text_.text = var_268_4

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_5 = 34
				local var_268_6 = utf8.len(var_268_4)
				local var_268_7 = var_268_5 <= 0 and var_268_1 or var_268_1 * (var_268_6 / var_268_5)

				if var_268_7 > 0 and var_268_1 < var_268_7 then
					arg_265_1.talkMaxDuration = var_268_7

					if var_268_7 + var_268_0 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_7 + var_268_0
					end
				end

				arg_265_1.text_.text = var_268_4
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)
				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_8 = math.max(var_268_1, arg_265_1.talkMaxDuration)

			if var_268_0 <= arg_265_1.time_ and arg_265_1.time_ < var_268_0 + var_268_8 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_0) / var_268_8

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_0 + var_268_8 and arg_265_1.time_ < var_268_0 + var_268_8 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {}

		arg_265_1:InitPlayNodeList()
	end,
	Play1104902065 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 1104902065
		arg_269_1.duration_ = 5.4

		local var_269_0 = {
			zh = 2.7,
			ja = 5.4
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
				arg_269_0:Play1104902066(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			local var_272_0 = arg_269_1.actors_["1049ui_story"].transform
			local var_272_1 = 0

			if var_272_1 < arg_269_1.time_ and arg_269_1.time_ <= var_272_1 + arg_272_0 then
				arg_269_1.var_.moveOldPos1049ui_story = var_272_0.localPosition
			end

			local var_272_2 = 0.001

			if var_272_1 <= arg_269_1.time_ and arg_269_1.time_ < var_272_1 + var_272_2 then
				local var_272_3 = (arg_269_1.time_ - var_272_1) / var_272_2
				local var_272_4 = Vector3.New(0, -1.2, -6)

				var_272_0.localPosition = Vector3.Lerp(arg_269_1.var_.moveOldPos1049ui_story, var_272_4, var_272_3)

				local var_272_5 = manager.ui.mainCamera.transform.position - var_272_0.position

				var_272_0.forward = Vector3.New(var_272_5.x, var_272_5.y, var_272_5.z)

				local var_272_6 = var_272_0.localEulerAngles

				var_272_6.z = 0
				var_272_6.x = 0
				var_272_0.localEulerAngles = var_272_6
			end

			if arg_269_1.time_ >= var_272_1 + var_272_2 and arg_269_1.time_ < var_272_1 + var_272_2 + arg_272_0 then
				var_272_0.localPosition = Vector3.New(0, -1.2, -6)

				local var_272_7 = manager.ui.mainCamera.transform.position - var_272_0.position

				var_272_0.forward = Vector3.New(var_272_7.x, var_272_7.y, var_272_7.z)

				local var_272_8 = var_272_0.localEulerAngles

				var_272_8.z = 0
				var_272_8.x = 0
				var_272_0.localEulerAngles = var_272_8
			end

			local var_272_9 = arg_269_1.actors_["1049ui_story"]
			local var_272_10 = 0

			if var_272_10 < arg_269_1.time_ and arg_269_1.time_ <= var_272_10 + arg_272_0 and not isNil(var_272_9) and arg_269_1.var_.characterEffect1049ui_story == nil then
				arg_269_1.var_.characterEffect1049ui_story = var_272_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_272_11 = 0.200000002980232

			if var_272_10 <= arg_269_1.time_ and arg_269_1.time_ < var_272_10 + var_272_11 and not isNil(var_272_9) then
				local var_272_12 = (arg_269_1.time_ - var_272_10) / var_272_11

				if arg_269_1.var_.characterEffect1049ui_story and not isNil(var_272_9) then
					arg_269_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_269_1.time_ >= var_272_10 + var_272_11 and arg_269_1.time_ < var_272_10 + var_272_11 + arg_272_0 and not isNil(var_272_9) and arg_269_1.var_.characterEffect1049ui_story then
				arg_269_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_272_13 = 0

			if var_272_13 < arg_269_1.time_ and arg_269_1.time_ <= var_272_13 + arg_272_0 then
				arg_269_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action6_1")
			end

			local var_272_14 = 0

			if var_272_14 < arg_269_1.time_ and arg_269_1.time_ <= var_272_14 + arg_272_0 then
				arg_269_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_272_15 = 0
			local var_272_16 = 0.175

			if var_272_15 < arg_269_1.time_ and arg_269_1.time_ <= var_272_15 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, true)

				local var_272_17 = arg_269_1:FormatText(StoryNameCfg[551].name)

				arg_269_1.leftNameTxt_.text = var_272_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_269_1.leftNameTxt_.transform)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1.leftNameTxt_.text)
				SetActive(arg_269_1.iconTrs_.gameObject, false)
				arg_269_1.callingController_:SetSelectedState("normal")

				local var_272_18 = arg_269_1:GetWordFromCfg(1104902065)
				local var_272_19 = arg_269_1:FormatText(var_272_18.content)

				arg_269_1.text_.text = var_272_19

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_20 = 7
				local var_272_21 = utf8.len(var_272_19)
				local var_272_22 = var_272_20 <= 0 and var_272_16 or var_272_16 * (var_272_21 / var_272_20)

				if var_272_22 > 0 and var_272_16 < var_272_22 then
					arg_269_1.talkMaxDuration = var_272_22

					if var_272_22 + var_272_15 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_22 + var_272_15
					end
				end

				arg_269_1.text_.text = var_272_19
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104902", "1104902065", "story_v_side_new_1104902.awb") ~= 0 then
					local var_272_23 = manager.audio:GetVoiceLength("story_v_side_new_1104902", "1104902065", "story_v_side_new_1104902.awb") / 1000

					if var_272_23 + var_272_15 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_23 + var_272_15
					end

					if var_272_18.prefab_name ~= "" and arg_269_1.actors_[var_272_18.prefab_name] ~= nil then
						local var_272_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_269_1.actors_[var_272_18.prefab_name].transform, "story_v_side_new_1104902", "1104902065", "story_v_side_new_1104902.awb")

						arg_269_1:RecordAudio("1104902065", var_272_24)
						arg_269_1:RecordAudio("1104902065", var_272_24)
					else
						arg_269_1:AudioAction("play", "voice", "story_v_side_new_1104902", "1104902065", "story_v_side_new_1104902.awb")
					end

					arg_269_1:RecordHistoryTalkVoice("story_v_side_new_1104902", "1104902065", "story_v_side_new_1104902.awb")
				end

				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_25 = math.max(var_272_16, arg_269_1.talkMaxDuration)

			if var_272_15 <= arg_269_1.time_ and arg_269_1.time_ < var_272_15 + var_272_25 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - var_272_15) / var_272_25

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= var_272_15 + var_272_25 and arg_269_1.time_ < var_272_15 + var_272_25 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_269_1:InitPlayNodeList()
	end,
	Play1104902066 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 1104902066
		arg_273_1.duration_ = 5

		SetActive(arg_273_1.tipsGo_, false)

		function arg_273_1.onSingleLineFinish_()
			arg_273_1.onSingleLineUpdate_ = nil
			arg_273_1.onSingleLineFinish_ = nil
			arg_273_1.state_ = "waiting"
		end

		function arg_273_1.playNext_(arg_275_0)
			if arg_275_0 == 1 then
				arg_273_0:Play1104902067(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			local var_276_0 = arg_273_1.actors_["1049ui_story"].transform
			local var_276_1 = 0

			if var_276_1 < arg_273_1.time_ and arg_273_1.time_ <= var_276_1 + arg_276_0 then
				arg_273_1.var_.moveOldPos1049ui_story = var_276_0.localPosition
			end

			local var_276_2 = 0.001

			if var_276_1 <= arg_273_1.time_ and arg_273_1.time_ < var_276_1 + var_276_2 then
				local var_276_3 = (arg_273_1.time_ - var_276_1) / var_276_2
				local var_276_4 = Vector3.New(0, 100, 0)

				var_276_0.localPosition = Vector3.Lerp(arg_273_1.var_.moveOldPos1049ui_story, var_276_4, var_276_3)

				local var_276_5 = manager.ui.mainCamera.transform.position - var_276_0.position

				var_276_0.forward = Vector3.New(var_276_5.x, var_276_5.y, var_276_5.z)

				local var_276_6 = var_276_0.localEulerAngles

				var_276_6.z = 0
				var_276_6.x = 0
				var_276_0.localEulerAngles = var_276_6
			end

			if arg_273_1.time_ >= var_276_1 + var_276_2 and arg_273_1.time_ < var_276_1 + var_276_2 + arg_276_0 then
				var_276_0.localPosition = Vector3.New(0, 100, 0)

				local var_276_7 = manager.ui.mainCamera.transform.position - var_276_0.position

				var_276_0.forward = Vector3.New(var_276_7.x, var_276_7.y, var_276_7.z)

				local var_276_8 = var_276_0.localEulerAngles

				var_276_8.z = 0
				var_276_8.x = 0
				var_276_0.localEulerAngles = var_276_8
			end

			local var_276_9 = arg_273_1.actors_["1049ui_story"]
			local var_276_10 = 0

			if var_276_10 < arg_273_1.time_ and arg_273_1.time_ <= var_276_10 + arg_276_0 and not isNil(var_276_9) and arg_273_1.var_.characterEffect1049ui_story == nil then
				arg_273_1.var_.characterEffect1049ui_story = var_276_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_276_11 = 0.200000002980232

			if var_276_10 <= arg_273_1.time_ and arg_273_1.time_ < var_276_10 + var_276_11 and not isNil(var_276_9) then
				local var_276_12 = (arg_273_1.time_ - var_276_10) / var_276_11

				if arg_273_1.var_.characterEffect1049ui_story and not isNil(var_276_9) then
					local var_276_13 = Mathf.Lerp(0, 0.5, var_276_12)

					arg_273_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_273_1.var_.characterEffect1049ui_story.fillRatio = var_276_13
				end
			end

			if arg_273_1.time_ >= var_276_10 + var_276_11 and arg_273_1.time_ < var_276_10 + var_276_11 + arg_276_0 and not isNil(var_276_9) and arg_273_1.var_.characterEffect1049ui_story then
				local var_276_14 = 0.5

				arg_273_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_273_1.var_.characterEffect1049ui_story.fillRatio = var_276_14
			end

			local var_276_15 = 0
			local var_276_16 = 1.275

			if var_276_15 < arg_273_1.time_ and arg_273_1.time_ <= var_276_15 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, false)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_273_1.iconTrs_.gameObject, false)
				arg_273_1.callingController_:SetSelectedState("normal")

				local var_276_17 = arg_273_1:GetWordFromCfg(1104902066)
				local var_276_18 = arg_273_1:FormatText(var_276_17.content)

				arg_273_1.text_.text = var_276_18

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_19 = 51
				local var_276_20 = utf8.len(var_276_18)
				local var_276_21 = var_276_19 <= 0 and var_276_16 or var_276_16 * (var_276_20 / var_276_19)

				if var_276_21 > 0 and var_276_16 < var_276_21 then
					arg_273_1.talkMaxDuration = var_276_21

					if var_276_21 + var_276_15 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_21 + var_276_15
					end
				end

				arg_273_1.text_.text = var_276_18
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)
				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_22 = math.max(var_276_16, arg_273_1.talkMaxDuration)

			if var_276_15 <= arg_273_1.time_ and arg_273_1.time_ < var_276_15 + var_276_22 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - var_276_15) / var_276_22

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= var_276_15 + var_276_22 and arg_273_1.time_ < var_276_15 + var_276_22 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_273_1:InitPlayNodeList()
	end,
	Play1104902067 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 1104902067
		arg_277_1.duration_ = 5

		SetActive(arg_277_1.tipsGo_, false)

		function arg_277_1.onSingleLineFinish_()
			arg_277_1.onSingleLineUpdate_ = nil
			arg_277_1.onSingleLineFinish_ = nil
			arg_277_1.state_ = "waiting"
		end

		function arg_277_1.playNext_(arg_279_0)
			if arg_279_0 == 1 then
				arg_277_0:Play1104902068(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			local var_280_0 = 0
			local var_280_1 = 1.375

			if var_280_0 < arg_277_1.time_ and arg_277_1.time_ <= var_280_0 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, true)

				local var_280_2 = arg_277_1:FormatText(StoryNameCfg[7].name)

				arg_277_1.leftNameTxt_.text = var_280_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, true)
				arg_277_1.iconController_:SetSelectedState("hero")

				arg_277_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_277_1.callingController_:SetSelectedState("normal")

				arg_277_1.keyicon_.color = Color.New(1, 1, 1)
				arg_277_1.icon_.color = Color.New(1, 1, 1)

				local var_280_3 = arg_277_1:GetWordFromCfg(1104902067)
				local var_280_4 = arg_277_1:FormatText(var_280_3.content)

				arg_277_1.text_.text = var_280_4

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_5 = 55
				local var_280_6 = utf8.len(var_280_4)
				local var_280_7 = var_280_5 <= 0 and var_280_1 or var_280_1 * (var_280_6 / var_280_5)

				if var_280_7 > 0 and var_280_1 < var_280_7 then
					arg_277_1.talkMaxDuration = var_280_7

					if var_280_7 + var_280_0 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_7 + var_280_0
					end
				end

				arg_277_1.text_.text = var_280_4
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)
				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_8 = math.max(var_280_1, arg_277_1.talkMaxDuration)

			if var_280_0 <= arg_277_1.time_ and arg_277_1.time_ < var_280_0 + var_280_8 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - var_280_0) / var_280_8

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= var_280_0 + var_280_8 and arg_277_1.time_ < var_280_0 + var_280_8 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {}

		arg_277_1:InitPlayNodeList()
	end,
	Play1104902068 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 1104902068
		arg_281_1.duration_ = 9

		SetActive(arg_281_1.tipsGo_, false)

		function arg_281_1.onSingleLineFinish_()
			arg_281_1.onSingleLineUpdate_ = nil
			arg_281_1.onSingleLineFinish_ = nil
			arg_281_1.state_ = "waiting"
		end

		function arg_281_1.playNext_(arg_283_0)
			if arg_283_0 == 1 then
				arg_281_0:Play1104902069(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			local var_284_0 = 2

			if var_284_0 < arg_281_1.time_ and arg_281_1.time_ <= var_284_0 + arg_284_0 then
				local var_284_1 = manager.ui.mainCamera.transform.localPosition
				local var_284_2 = Vector3.New(0, 0, 10) + Vector3.New(var_284_1.x, var_284_1.y, 0)
				local var_284_3 = arg_281_1.bgs_.ST11

				var_284_3.transform.localPosition = var_284_2
				var_284_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_284_4 = var_284_3:GetComponent("SpriteRenderer")

				if var_284_4 and var_284_4.sprite then
					local var_284_5 = (var_284_3.transform.localPosition - var_284_1).z
					local var_284_6 = manager.ui.mainCameraCom_
					local var_284_7 = 2 * var_284_5 * Mathf.Tan(var_284_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_284_8 = var_284_7 * var_284_6.aspect
					local var_284_9 = var_284_4.sprite.bounds.size.x
					local var_284_10 = var_284_4.sprite.bounds.size.y
					local var_284_11 = var_284_8 / var_284_9
					local var_284_12 = var_284_7 / var_284_10
					local var_284_13 = var_284_12 < var_284_11 and var_284_11 or var_284_12

					var_284_3.transform.localScale = Vector3.New(var_284_13, var_284_13, 0)
				end

				for iter_284_0, iter_284_1 in pairs(arg_281_1.bgs_) do
					if iter_284_0 ~= "ST11" then
						iter_284_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_284_14 = 3.999999999999

			if var_284_14 < arg_281_1.time_ and arg_281_1.time_ <= var_284_14 + arg_284_0 then
				arg_281_1.allBtn_.enabled = false
			end

			local var_284_15 = 0.3

			if arg_281_1.time_ >= var_284_14 + var_284_15 and arg_281_1.time_ < var_284_14 + var_284_15 + arg_284_0 then
				arg_281_1.allBtn_.enabled = true
			end

			local var_284_16 = 0

			if var_284_16 < arg_281_1.time_ and arg_281_1.time_ <= var_284_16 + arg_284_0 then
				arg_281_1.mask_.enabled = true
				arg_281_1.mask_.raycastTarget = true

				arg_281_1:SetGaussion(false)
			end

			local var_284_17 = 2

			if var_284_16 <= arg_281_1.time_ and arg_281_1.time_ < var_284_16 + var_284_17 then
				local var_284_18 = (arg_281_1.time_ - var_284_16) / var_284_17
				local var_284_19 = Color.New(0, 0, 0)

				var_284_19.a = Mathf.Lerp(0, 1, var_284_18)
				arg_281_1.mask_.color = var_284_19
			end

			if arg_281_1.time_ >= var_284_16 + var_284_17 and arg_281_1.time_ < var_284_16 + var_284_17 + arg_284_0 then
				local var_284_20 = Color.New(0, 0, 0)

				var_284_20.a = 1
				arg_281_1.mask_.color = var_284_20
			end

			local var_284_21 = 2

			if var_284_21 < arg_281_1.time_ and arg_281_1.time_ <= var_284_21 + arg_284_0 then
				arg_281_1.mask_.enabled = true
				arg_281_1.mask_.raycastTarget = true

				arg_281_1:SetGaussion(false)
			end

			local var_284_22 = 2

			if var_284_21 <= arg_281_1.time_ and arg_281_1.time_ < var_284_21 + var_284_22 then
				local var_284_23 = (arg_281_1.time_ - var_284_21) / var_284_22
				local var_284_24 = Color.New(0, 0, 0)

				var_284_24.a = Mathf.Lerp(1, 0, var_284_23)
				arg_281_1.mask_.color = var_284_24
			end

			if arg_281_1.time_ >= var_284_21 + var_284_22 and arg_281_1.time_ < var_284_21 + var_284_22 + arg_284_0 then
				local var_284_25 = Color.New(0, 0, 0)
				local var_284_26 = 0

				arg_281_1.mask_.enabled = false
				var_284_25.a = var_284_26
				arg_281_1.mask_.color = var_284_25
			end

			if arg_281_1.frameCnt_ <= 1 then
				arg_281_1.dialog_:SetActive(false)
			end

			local var_284_27 = 3.999999999999
			local var_284_28 = 0.85

			if var_284_27 < arg_281_1.time_ and arg_281_1.time_ <= var_284_27 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0

				arg_281_1.dialog_:SetActive(true)

				arg_281_1.dialogCg_.alpha = 0

				local var_284_29 = LeanTween.value(arg_281_1.dialog_, 0, 1, 0.3)

				var_284_29:setOnUpdate(LuaHelper.FloatAction(function(arg_285_0)
					arg_281_1.dialogCg_.alpha = arg_285_0
				end))
				var_284_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_281_1.dialog_)
					var_284_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_281_1.duration_ = arg_281_1.duration_ + 0.3

				SetActive(arg_281_1.leftNameGo_, false)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_30 = arg_281_1:GetWordFromCfg(1104902068)
				local var_284_31 = arg_281_1:FormatText(var_284_30.content)

				arg_281_1.text_.text = var_284_31

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_32 = 34
				local var_284_33 = utf8.len(var_284_31)
				local var_284_34 = var_284_32 <= 0 and var_284_28 or var_284_28 * (var_284_33 / var_284_32)

				if var_284_34 > 0 and var_284_28 < var_284_34 then
					arg_281_1.talkMaxDuration = var_284_34
					var_284_27 = var_284_27 + 0.3

					if var_284_34 + var_284_27 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_34 + var_284_27
					end
				end

				arg_281_1.text_.text = var_284_31
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)
				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_35 = var_284_27 + 0.3
			local var_284_36 = math.max(var_284_28, arg_281_1.talkMaxDuration)

			if var_284_35 <= arg_281_1.time_ and arg_281_1.time_ < var_284_35 + var_284_36 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - var_284_35) / var_284_36

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= var_284_35 + var_284_36 and arg_281_1.time_ < var_284_35 + var_284_36 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {}

		arg_281_1:InitPlayNodeList()
	end,
	Play1104902069 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 1104902069
		arg_287_1.duration_ = 5

		SetActive(arg_287_1.tipsGo_, false)

		function arg_287_1.onSingleLineFinish_()
			arg_287_1.onSingleLineUpdate_ = nil
			arg_287_1.onSingleLineFinish_ = nil
			arg_287_1.state_ = "waiting"
		end

		function arg_287_1.playNext_(arg_289_0)
			if arg_289_0 == 1 then
				arg_287_0:Play1104902070(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			local var_290_0 = 0
			local var_290_1 = 0.525

			if var_290_0 < arg_287_1.time_ and arg_287_1.time_ <= var_290_0 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0
				arg_287_1.dialogCg_.alpha = 1

				arg_287_1.dialog_:SetActive(true)
				SetActive(arg_287_1.leftNameGo_, true)

				local var_290_2 = arg_287_1:FormatText(StoryNameCfg[7].name)

				arg_287_1.leftNameTxt_.text = var_290_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_287_1.leftNameTxt_.transform)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1.leftNameTxt_.text)
				SetActive(arg_287_1.iconTrs_.gameObject, true)
				arg_287_1.iconController_:SetSelectedState("hero")

				arg_287_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_287_1.callingController_:SetSelectedState("normal")

				arg_287_1.keyicon_.color = Color.New(1, 1, 1)
				arg_287_1.icon_.color = Color.New(1, 1, 1)

				local var_290_3 = arg_287_1:GetWordFromCfg(1104902069)
				local var_290_4 = arg_287_1:FormatText(var_290_3.content)

				arg_287_1.text_.text = var_290_4

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_5 = 21
				local var_290_6 = utf8.len(var_290_4)
				local var_290_7 = var_290_5 <= 0 and var_290_1 or var_290_1 * (var_290_6 / var_290_5)

				if var_290_7 > 0 and var_290_1 < var_290_7 then
					arg_287_1.talkMaxDuration = var_290_7

					if var_290_7 + var_290_0 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_7 + var_290_0
					end
				end

				arg_287_1.text_.text = var_290_4
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)
				arg_287_1:RecordContent(arg_287_1.text_.text)
			end

			local var_290_8 = math.max(var_290_1, arg_287_1.talkMaxDuration)

			if var_290_0 <= arg_287_1.time_ and arg_287_1.time_ < var_290_0 + var_290_8 then
				arg_287_1.typewritter.percent = (arg_287_1.time_ - var_290_0) / var_290_8

				arg_287_1.typewritter:SetDirty()
			end

			if arg_287_1.time_ >= var_290_0 + var_290_8 and arg_287_1.time_ < var_290_0 + var_290_8 + arg_290_0 then
				arg_287_1.typewritter.percent = 1

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(true)
			end
		end

		arg_287_1.nodeConfigList_ = {}

		arg_287_1:InitPlayNodeList()
	end,
	Play1104902070 = function(arg_291_0, arg_291_1)
		arg_291_1.time_ = 0
		arg_291_1.frameCnt_ = 0
		arg_291_1.state_ = "playing"
		arg_291_1.curTalkId_ = 1104902070
		arg_291_1.duration_ = 5

		SetActive(arg_291_1.tipsGo_, false)

		function arg_291_1.onSingleLineFinish_()
			arg_291_1.onSingleLineUpdate_ = nil
			arg_291_1.onSingleLineFinish_ = nil
			arg_291_1.state_ = "waiting"
		end

		function arg_291_1.playNext_(arg_293_0)
			if arg_293_0 == 1 then
				arg_291_0:Play1104902071(arg_291_1)
			end
		end

		function arg_291_1.onSingleLineUpdate_(arg_294_0)
			local var_294_0 = 0
			local var_294_1 = 0.975

			if var_294_0 < arg_291_1.time_ and arg_291_1.time_ <= var_294_0 + arg_294_0 then
				arg_291_1.talkMaxDuration = 0
				arg_291_1.dialogCg_.alpha = 1

				arg_291_1.dialog_:SetActive(true)
				SetActive(arg_291_1.leftNameGo_, false)

				arg_291_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_291_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_291_1:RecordName(arg_291_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_291_1.iconTrs_.gameObject, false)
				arg_291_1.callingController_:SetSelectedState("normal")

				local var_294_2 = arg_291_1:GetWordFromCfg(1104902070)
				local var_294_3 = arg_291_1:FormatText(var_294_2.content)

				arg_291_1.text_.text = var_294_3

				LuaForUtil.ClearLinePrefixSymbol(arg_291_1.text_)

				local var_294_4 = 39
				local var_294_5 = utf8.len(var_294_3)
				local var_294_6 = var_294_4 <= 0 and var_294_1 or var_294_1 * (var_294_5 / var_294_4)

				if var_294_6 > 0 and var_294_1 < var_294_6 then
					arg_291_1.talkMaxDuration = var_294_6

					if var_294_6 + var_294_0 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_6 + var_294_0
					end
				end

				arg_291_1.text_.text = var_294_3
				arg_291_1.typewritter.percent = 0

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(false)
				arg_291_1:RecordContent(arg_291_1.text_.text)
			end

			local var_294_7 = math.max(var_294_1, arg_291_1.talkMaxDuration)

			if var_294_0 <= arg_291_1.time_ and arg_291_1.time_ < var_294_0 + var_294_7 then
				arg_291_1.typewritter.percent = (arg_291_1.time_ - var_294_0) / var_294_7

				arg_291_1.typewritter:SetDirty()
			end

			if arg_291_1.time_ >= var_294_0 + var_294_7 and arg_291_1.time_ < var_294_0 + var_294_7 + arg_294_0 then
				arg_291_1.typewritter.percent = 1

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(true)
			end
		end

		arg_291_1.nodeConfigList_ = {}

		arg_291_1:InitPlayNodeList()
	end,
	Play1104902071 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 1104902071
		arg_295_1.duration_ = 5

		SetActive(arg_295_1.tipsGo_, false)

		function arg_295_1.onSingleLineFinish_()
			arg_295_1.onSingleLineUpdate_ = nil
			arg_295_1.onSingleLineFinish_ = nil
			arg_295_1.state_ = "waiting"
		end

		function arg_295_1.playNext_(arg_297_0)
			if arg_297_0 == 1 then
				arg_295_0:Play1104902072(arg_295_1)
			end
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			local var_298_0 = 0
			local var_298_1 = 0.25

			if var_298_0 < arg_295_1.time_ and arg_295_1.time_ <= var_298_0 + arg_298_0 then
				arg_295_1.talkMaxDuration = 0
				arg_295_1.dialogCg_.alpha = 1

				arg_295_1.dialog_:SetActive(true)
				SetActive(arg_295_1.leftNameGo_, true)

				local var_298_2 = arg_295_1:FormatText(StoryNameCfg[7].name)

				arg_295_1.leftNameTxt_.text = var_298_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_295_1.leftNameTxt_.transform)

				arg_295_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_295_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_295_1:RecordName(arg_295_1.leftNameTxt_.text)
				SetActive(arg_295_1.iconTrs_.gameObject, true)
				arg_295_1.iconController_:SetSelectedState("hero")

				arg_295_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_295_1.callingController_:SetSelectedState("normal")

				arg_295_1.keyicon_.color = Color.New(1, 1, 1)
				arg_295_1.icon_.color = Color.New(1, 1, 1)

				local var_298_3 = arg_295_1:GetWordFromCfg(1104902071)
				local var_298_4 = arg_295_1:FormatText(var_298_3.content)

				arg_295_1.text_.text = var_298_4

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_5 = 10
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
				arg_295_1:RecordContent(arg_295_1.text_.text)
			end

			local var_298_8 = math.max(var_298_1, arg_295_1.talkMaxDuration)

			if var_298_0 <= arg_295_1.time_ and arg_295_1.time_ < var_298_0 + var_298_8 then
				arg_295_1.typewritter.percent = (arg_295_1.time_ - var_298_0) / var_298_8

				arg_295_1.typewritter:SetDirty()
			end

			if arg_295_1.time_ >= var_298_0 + var_298_8 and arg_295_1.time_ < var_298_0 + var_298_8 + arg_298_0 then
				arg_295_1.typewritter.percent = 1

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(true)
			end
		end

		arg_295_1.nodeConfigList_ = {}

		arg_295_1:InitPlayNodeList()
	end,
	Play1104902072 = function(arg_299_0, arg_299_1)
		arg_299_1.time_ = 0
		arg_299_1.frameCnt_ = 0
		arg_299_1.state_ = "playing"
		arg_299_1.curTalkId_ = 1104902072
		arg_299_1.duration_ = 5

		SetActive(arg_299_1.tipsGo_, false)

		function arg_299_1.onSingleLineFinish_()
			arg_299_1.onSingleLineUpdate_ = nil
			arg_299_1.onSingleLineFinish_ = nil
			arg_299_1.state_ = "waiting"
		end

		function arg_299_1.playNext_(arg_301_0)
			if arg_301_0 == 1 then
				arg_299_0:Play1104902073(arg_299_1)
			end
		end

		function arg_299_1.onSingleLineUpdate_(arg_302_0)
			local var_302_0 = 0
			local var_302_1 = 0.975

			if var_302_0 < arg_299_1.time_ and arg_299_1.time_ <= var_302_0 + arg_302_0 then
				arg_299_1.talkMaxDuration = 0
				arg_299_1.dialogCg_.alpha = 1

				arg_299_1.dialog_:SetActive(true)
				SetActive(arg_299_1.leftNameGo_, false)

				arg_299_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_299_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_299_1:RecordName(arg_299_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_299_1.iconTrs_.gameObject, false)
				arg_299_1.callingController_:SetSelectedState("normal")

				local var_302_2 = arg_299_1:GetWordFromCfg(1104902072)
				local var_302_3 = arg_299_1:FormatText(var_302_2.content)

				arg_299_1.text_.text = var_302_3

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.text_)

				local var_302_4 = 39
				local var_302_5 = utf8.len(var_302_3)
				local var_302_6 = var_302_4 <= 0 and var_302_1 or var_302_1 * (var_302_5 / var_302_4)

				if var_302_6 > 0 and var_302_1 < var_302_6 then
					arg_299_1.talkMaxDuration = var_302_6

					if var_302_6 + var_302_0 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_6 + var_302_0
					end
				end

				arg_299_1.text_.text = var_302_3
				arg_299_1.typewritter.percent = 0

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(false)
				arg_299_1:RecordContent(arg_299_1.text_.text)
			end

			local var_302_7 = math.max(var_302_1, arg_299_1.talkMaxDuration)

			if var_302_0 <= arg_299_1.time_ and arg_299_1.time_ < var_302_0 + var_302_7 then
				arg_299_1.typewritter.percent = (arg_299_1.time_ - var_302_0) / var_302_7

				arg_299_1.typewritter:SetDirty()
			end

			if arg_299_1.time_ >= var_302_0 + var_302_7 and arg_299_1.time_ < var_302_0 + var_302_7 + arg_302_0 then
				arg_299_1.typewritter.percent = 1

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(true)
			end
		end

		arg_299_1.nodeConfigList_ = {}

		arg_299_1:InitPlayNodeList()
	end,
	Play1104902073 = function(arg_303_0, arg_303_1)
		arg_303_1.time_ = 0
		arg_303_1.frameCnt_ = 0
		arg_303_1.state_ = "playing"
		arg_303_1.curTalkId_ = 1104902073
		arg_303_1.duration_ = 2.67

		local var_303_0 = {
			zh = 2.666,
			ja = 1.999999999999
		}
		local var_303_1 = manager.audio:GetLocalizationFlag()

		if var_303_0[var_303_1] ~= nil then
			arg_303_1.duration_ = var_303_0[var_303_1]
		end

		SetActive(arg_303_1.tipsGo_, false)

		function arg_303_1.onSingleLineFinish_()
			arg_303_1.onSingleLineUpdate_ = nil
			arg_303_1.onSingleLineFinish_ = nil
			arg_303_1.state_ = "waiting"
		end

		function arg_303_1.playNext_(arg_305_0)
			if arg_305_0 == 1 then
				arg_303_0:Play1104902074(arg_303_1)
			end
		end

		function arg_303_1.onSingleLineUpdate_(arg_306_0)
			local var_306_0 = arg_303_1.actors_["1049ui_story"].transform
			local var_306_1 = 0

			if var_306_1 < arg_303_1.time_ and arg_303_1.time_ <= var_306_1 + arg_306_0 then
				arg_303_1.var_.moveOldPos1049ui_story = var_306_0.localPosition
			end

			local var_306_2 = 0.001

			if var_306_1 <= arg_303_1.time_ and arg_303_1.time_ < var_306_1 + var_306_2 then
				local var_306_3 = (arg_303_1.time_ - var_306_1) / var_306_2
				local var_306_4 = Vector3.New(0, -1.2, -6)

				var_306_0.localPosition = Vector3.Lerp(arg_303_1.var_.moveOldPos1049ui_story, var_306_4, var_306_3)

				local var_306_5 = manager.ui.mainCamera.transform.position - var_306_0.position

				var_306_0.forward = Vector3.New(var_306_5.x, var_306_5.y, var_306_5.z)

				local var_306_6 = var_306_0.localEulerAngles

				var_306_6.z = 0
				var_306_6.x = 0
				var_306_0.localEulerAngles = var_306_6
			end

			if arg_303_1.time_ >= var_306_1 + var_306_2 and arg_303_1.time_ < var_306_1 + var_306_2 + arg_306_0 then
				var_306_0.localPosition = Vector3.New(0, -1.2, -6)

				local var_306_7 = manager.ui.mainCamera.transform.position - var_306_0.position

				var_306_0.forward = Vector3.New(var_306_7.x, var_306_7.y, var_306_7.z)

				local var_306_8 = var_306_0.localEulerAngles

				var_306_8.z = 0
				var_306_8.x = 0
				var_306_0.localEulerAngles = var_306_8
			end

			local var_306_9 = arg_303_1.actors_["1049ui_story"]
			local var_306_10 = 0

			if var_306_10 < arg_303_1.time_ and arg_303_1.time_ <= var_306_10 + arg_306_0 and not isNil(var_306_9) and arg_303_1.var_.characterEffect1049ui_story == nil then
				arg_303_1.var_.characterEffect1049ui_story = var_306_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_306_11 = 0.200000002980232

			if var_306_10 <= arg_303_1.time_ and arg_303_1.time_ < var_306_10 + var_306_11 and not isNil(var_306_9) then
				local var_306_12 = (arg_303_1.time_ - var_306_10) / var_306_11

				if arg_303_1.var_.characterEffect1049ui_story and not isNil(var_306_9) then
					arg_303_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_303_1.time_ >= var_306_10 + var_306_11 and arg_303_1.time_ < var_306_10 + var_306_11 + arg_306_0 and not isNil(var_306_9) and arg_303_1.var_.characterEffect1049ui_story then
				arg_303_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_306_13 = 0

			if var_306_13 < arg_303_1.time_ and arg_303_1.time_ <= var_306_13 + arg_306_0 then
				arg_303_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action1_1")
			end

			local var_306_14 = 0

			if var_306_14 < arg_303_1.time_ and arg_303_1.time_ <= var_306_14 + arg_306_0 then
				arg_303_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_306_15 = 0
			local var_306_16 = 0.175

			if var_306_15 < arg_303_1.time_ and arg_303_1.time_ <= var_306_15 + arg_306_0 then
				arg_303_1.talkMaxDuration = 0
				arg_303_1.dialogCg_.alpha = 1

				arg_303_1.dialog_:SetActive(true)
				SetActive(arg_303_1.leftNameGo_, true)

				local var_306_17 = arg_303_1:FormatText(StoryNameCfg[551].name)

				arg_303_1.leftNameTxt_.text = var_306_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_303_1.leftNameTxt_.transform)

				arg_303_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_303_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_303_1:RecordName(arg_303_1.leftNameTxt_.text)
				SetActive(arg_303_1.iconTrs_.gameObject, false)
				arg_303_1.callingController_:SetSelectedState("normal")

				local var_306_18 = arg_303_1:GetWordFromCfg(1104902073)
				local var_306_19 = arg_303_1:FormatText(var_306_18.content)

				arg_303_1.text_.text = var_306_19

				LuaForUtil.ClearLinePrefixSymbol(arg_303_1.text_)

				local var_306_20 = 7
				local var_306_21 = utf8.len(var_306_19)
				local var_306_22 = var_306_20 <= 0 and var_306_16 or var_306_16 * (var_306_21 / var_306_20)

				if var_306_22 > 0 and var_306_16 < var_306_22 then
					arg_303_1.talkMaxDuration = var_306_22

					if var_306_22 + var_306_15 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_22 + var_306_15
					end
				end

				arg_303_1.text_.text = var_306_19
				arg_303_1.typewritter.percent = 0

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104902", "1104902073", "story_v_side_new_1104902.awb") ~= 0 then
					local var_306_23 = manager.audio:GetVoiceLength("story_v_side_new_1104902", "1104902073", "story_v_side_new_1104902.awb") / 1000

					if var_306_23 + var_306_15 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_23 + var_306_15
					end

					if var_306_18.prefab_name ~= "" and arg_303_1.actors_[var_306_18.prefab_name] ~= nil then
						local var_306_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_303_1.actors_[var_306_18.prefab_name].transform, "story_v_side_new_1104902", "1104902073", "story_v_side_new_1104902.awb")

						arg_303_1:RecordAudio("1104902073", var_306_24)
						arg_303_1:RecordAudio("1104902073", var_306_24)
					else
						arg_303_1:AudioAction("play", "voice", "story_v_side_new_1104902", "1104902073", "story_v_side_new_1104902.awb")
					end

					arg_303_1:RecordHistoryTalkVoice("story_v_side_new_1104902", "1104902073", "story_v_side_new_1104902.awb")
				end

				arg_303_1:RecordContent(arg_303_1.text_.text)
			end

			local var_306_25 = math.max(var_306_16, arg_303_1.talkMaxDuration)

			if var_306_15 <= arg_303_1.time_ and arg_303_1.time_ < var_306_15 + var_306_25 then
				arg_303_1.typewritter.percent = (arg_303_1.time_ - var_306_15) / var_306_25

				arg_303_1.typewritter:SetDirty()
			end

			if arg_303_1.time_ >= var_306_15 + var_306_25 and arg_303_1.time_ < var_306_15 + var_306_25 + arg_306_0 then
				arg_303_1.typewritter.percent = 1

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(true)
			end
		end

		arg_303_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_303_1:InitPlayNodeList()
	end,
	Play1104902074 = function(arg_307_0, arg_307_1)
		arg_307_1.time_ = 0
		arg_307_1.frameCnt_ = 0
		arg_307_1.state_ = "playing"
		arg_307_1.curTalkId_ = 1104902074
		arg_307_1.duration_ = 5

		SetActive(arg_307_1.tipsGo_, false)

		function arg_307_1.onSingleLineFinish_()
			arg_307_1.onSingleLineUpdate_ = nil
			arg_307_1.onSingleLineFinish_ = nil
			arg_307_1.state_ = "waiting"
		end

		function arg_307_1.playNext_(arg_309_0)
			if arg_309_0 == 1 then
				arg_307_0:Play1104902075(arg_307_1)
			end
		end

		function arg_307_1.onSingleLineUpdate_(arg_310_0)
			local var_310_0 = arg_307_1.actors_["1049ui_story"].transform
			local var_310_1 = 0

			if var_310_1 < arg_307_1.time_ and arg_307_1.time_ <= var_310_1 + arg_310_0 then
				arg_307_1.var_.moveOldPos1049ui_story = var_310_0.localPosition
			end

			local var_310_2 = 0.001

			if var_310_1 <= arg_307_1.time_ and arg_307_1.time_ < var_310_1 + var_310_2 then
				local var_310_3 = (arg_307_1.time_ - var_310_1) / var_310_2
				local var_310_4 = Vector3.New(0, 100, 0)

				var_310_0.localPosition = Vector3.Lerp(arg_307_1.var_.moveOldPos1049ui_story, var_310_4, var_310_3)

				local var_310_5 = manager.ui.mainCamera.transform.position - var_310_0.position

				var_310_0.forward = Vector3.New(var_310_5.x, var_310_5.y, var_310_5.z)

				local var_310_6 = var_310_0.localEulerAngles

				var_310_6.z = 0
				var_310_6.x = 0
				var_310_0.localEulerAngles = var_310_6
			end

			if arg_307_1.time_ >= var_310_1 + var_310_2 and arg_307_1.time_ < var_310_1 + var_310_2 + arg_310_0 then
				var_310_0.localPosition = Vector3.New(0, 100, 0)

				local var_310_7 = manager.ui.mainCamera.transform.position - var_310_0.position

				var_310_0.forward = Vector3.New(var_310_7.x, var_310_7.y, var_310_7.z)

				local var_310_8 = var_310_0.localEulerAngles

				var_310_8.z = 0
				var_310_8.x = 0
				var_310_0.localEulerAngles = var_310_8
			end

			local var_310_9 = arg_307_1.actors_["1049ui_story"]
			local var_310_10 = 0

			if var_310_10 < arg_307_1.time_ and arg_307_1.time_ <= var_310_10 + arg_310_0 and not isNil(var_310_9) and arg_307_1.var_.characterEffect1049ui_story == nil then
				arg_307_1.var_.characterEffect1049ui_story = var_310_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_310_11 = 0.200000002980232

			if var_310_10 <= arg_307_1.time_ and arg_307_1.time_ < var_310_10 + var_310_11 and not isNil(var_310_9) then
				local var_310_12 = (arg_307_1.time_ - var_310_10) / var_310_11

				if arg_307_1.var_.characterEffect1049ui_story and not isNil(var_310_9) then
					local var_310_13 = Mathf.Lerp(0, 0.5, var_310_12)

					arg_307_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_307_1.var_.characterEffect1049ui_story.fillRatio = var_310_13
				end
			end

			if arg_307_1.time_ >= var_310_10 + var_310_11 and arg_307_1.time_ < var_310_10 + var_310_11 + arg_310_0 and not isNil(var_310_9) and arg_307_1.var_.characterEffect1049ui_story then
				local var_310_14 = 0.5

				arg_307_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_307_1.var_.characterEffect1049ui_story.fillRatio = var_310_14
			end

			local var_310_15 = manager.ui.mainCamera.transform
			local var_310_16 = 0.3

			if var_310_16 < arg_307_1.time_ and arg_307_1.time_ <= var_310_16 + arg_310_0 then
				arg_307_1.var_.shakeOldPos = var_310_15.localPosition
			end

			local var_310_17 = 0.6

			if var_310_16 <= arg_307_1.time_ and arg_307_1.time_ < var_310_16 + var_310_17 then
				local var_310_18 = (arg_307_1.time_ - var_310_16) / 0.066
				local var_310_19, var_310_20 = math.modf(var_310_18)

				var_310_15.localPosition = Vector3.New(var_310_20 * 0.13, var_310_20 * 0.13, var_310_20 * 0.13) + arg_307_1.var_.shakeOldPos
			end

			if arg_307_1.time_ >= var_310_16 + var_310_17 and arg_307_1.time_ < var_310_16 + var_310_17 + arg_310_0 then
				var_310_15.localPosition = arg_307_1.var_.shakeOldPos
			end

			local var_310_21 = 0

			if var_310_21 < arg_307_1.time_ and arg_307_1.time_ <= var_310_21 + arg_310_0 then
				arg_307_1.allBtn_.enabled = false
			end

			local var_310_22 = 0.9

			if arg_307_1.time_ >= var_310_21 + var_310_22 and arg_307_1.time_ < var_310_21 + var_310_22 + arg_310_0 then
				arg_307_1.allBtn_.enabled = true
			end

			local var_310_23 = 0
			local var_310_24 = 1

			if var_310_23 < arg_307_1.time_ and arg_307_1.time_ <= var_310_23 + arg_310_0 then
				local var_310_25 = "play"
				local var_310_26 = "effect"

				arg_307_1:AudioAction(var_310_25, var_310_26, "se_story_side_1049", "se_story_side_1049_bag", "")
			end

			local var_310_27 = 0
			local var_310_28 = 0.675

			if var_310_27 < arg_307_1.time_ and arg_307_1.time_ <= var_310_27 + arg_310_0 then
				arg_307_1.talkMaxDuration = 0
				arg_307_1.dialogCg_.alpha = 1

				arg_307_1.dialog_:SetActive(true)
				SetActive(arg_307_1.leftNameGo_, false)

				arg_307_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_307_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_307_1:RecordName(arg_307_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_307_1.iconTrs_.gameObject, false)
				arg_307_1.callingController_:SetSelectedState("normal")

				local var_310_29 = arg_307_1:GetWordFromCfg(1104902074)
				local var_310_30 = arg_307_1:FormatText(var_310_29.content)

				arg_307_1.text_.text = var_310_30

				LuaForUtil.ClearLinePrefixSymbol(arg_307_1.text_)

				local var_310_31 = 27
				local var_310_32 = utf8.len(var_310_30)
				local var_310_33 = var_310_31 <= 0 and var_310_28 or var_310_28 * (var_310_32 / var_310_31)

				if var_310_33 > 0 and var_310_28 < var_310_33 then
					arg_307_1.talkMaxDuration = var_310_33

					if var_310_33 + var_310_27 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_33 + var_310_27
					end
				end

				arg_307_1.text_.text = var_310_30
				arg_307_1.typewritter.percent = 0

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(false)
				arg_307_1:RecordContent(arg_307_1.text_.text)
			end

			local var_310_34 = math.max(var_310_28, arg_307_1.talkMaxDuration)

			if var_310_27 <= arg_307_1.time_ and arg_307_1.time_ < var_310_27 + var_310_34 then
				arg_307_1.typewritter.percent = (arg_307_1.time_ - var_310_27) / var_310_34

				arg_307_1.typewritter:SetDirty()
			end

			if arg_307_1.time_ >= var_310_27 + var_310_34 and arg_307_1.time_ < var_310_27 + var_310_34 + arg_310_0 then
				arg_307_1.typewritter.percent = 1

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(true)
			end
		end

		arg_307_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_307_1:InitPlayNodeList()
	end,
	Play1104902075 = function(arg_311_0, arg_311_1)
		arg_311_1.time_ = 0
		arg_311_1.frameCnt_ = 0
		arg_311_1.state_ = "playing"
		arg_311_1.curTalkId_ = 1104902075
		arg_311_1.duration_ = 5

		SetActive(arg_311_1.tipsGo_, false)

		function arg_311_1.onSingleLineFinish_()
			arg_311_1.onSingleLineUpdate_ = nil
			arg_311_1.onSingleLineFinish_ = nil
			arg_311_1.state_ = "waiting"
		end

		function arg_311_1.playNext_(arg_313_0)
			if arg_313_0 == 1 then
				arg_311_0:Play1104902076(arg_311_1)
			end
		end

		function arg_311_1.onSingleLineUpdate_(arg_314_0)
			local var_314_0 = 0
			local var_314_1 = 0.075

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

				local var_314_3 = arg_311_1:GetWordFromCfg(1104902075)
				local var_314_4 = arg_311_1:FormatText(var_314_3.content)

				arg_311_1.text_.text = var_314_4

				LuaForUtil.ClearLinePrefixSymbol(arg_311_1.text_)

				local var_314_5 = 3
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
	Play1104902076 = function(arg_315_0, arg_315_1)
		arg_315_1.time_ = 0
		arg_315_1.frameCnt_ = 0
		arg_315_1.state_ = "playing"
		arg_315_1.curTalkId_ = 1104902076
		arg_315_1.duration_ = 5

		SetActive(arg_315_1.tipsGo_, false)

		function arg_315_1.onSingleLineFinish_()
			arg_315_1.onSingleLineUpdate_ = nil
			arg_315_1.onSingleLineFinish_ = nil
			arg_315_1.state_ = "waiting"
		end

		function arg_315_1.playNext_(arg_317_0)
			if arg_317_0 == 1 then
				arg_315_0:Play1104902077(arg_315_1)
			end
		end

		function arg_315_1.onSingleLineUpdate_(arg_318_0)
			local var_318_0 = 0
			local var_318_1 = 0.5

			if var_318_0 < arg_315_1.time_ and arg_315_1.time_ <= var_318_0 + arg_318_0 then
				arg_315_1.talkMaxDuration = 0
				arg_315_1.dialogCg_.alpha = 1

				arg_315_1.dialog_:SetActive(true)
				SetActive(arg_315_1.leftNameGo_, false)

				arg_315_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_315_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_315_1:RecordName(arg_315_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_315_1.iconTrs_.gameObject, false)
				arg_315_1.callingController_:SetSelectedState("normal")

				local var_318_2 = arg_315_1:GetWordFromCfg(1104902076)
				local var_318_3 = arg_315_1:FormatText(var_318_2.content)

				arg_315_1.text_.text = var_318_3

				LuaForUtil.ClearLinePrefixSymbol(arg_315_1.text_)

				local var_318_4 = 20
				local var_318_5 = utf8.len(var_318_3)
				local var_318_6 = var_318_4 <= 0 and var_318_1 or var_318_1 * (var_318_5 / var_318_4)

				if var_318_6 > 0 and var_318_1 < var_318_6 then
					arg_315_1.talkMaxDuration = var_318_6

					if var_318_6 + var_318_0 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_6 + var_318_0
					end
				end

				arg_315_1.text_.text = var_318_3
				arg_315_1.typewritter.percent = 0

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(false)
				arg_315_1:RecordContent(arg_315_1.text_.text)
			end

			local var_318_7 = math.max(var_318_1, arg_315_1.talkMaxDuration)

			if var_318_0 <= arg_315_1.time_ and arg_315_1.time_ < var_318_0 + var_318_7 then
				arg_315_1.typewritter.percent = (arg_315_1.time_ - var_318_0) / var_318_7

				arg_315_1.typewritter:SetDirty()
			end

			if arg_315_1.time_ >= var_318_0 + var_318_7 and arg_315_1.time_ < var_318_0 + var_318_7 + arg_318_0 then
				arg_315_1.typewritter.percent = 1

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(true)
			end
		end

		arg_315_1.nodeConfigList_ = {}

		arg_315_1:InitPlayNodeList()
	end,
	Play1104902077 = function(arg_319_0, arg_319_1)
		arg_319_1.time_ = 0
		arg_319_1.frameCnt_ = 0
		arg_319_1.state_ = "playing"
		arg_319_1.curTalkId_ = 1104902077
		arg_319_1.duration_ = 5

		SetActive(arg_319_1.tipsGo_, false)

		function arg_319_1.onSingleLineFinish_()
			arg_319_1.onSingleLineUpdate_ = nil
			arg_319_1.onSingleLineFinish_ = nil
			arg_319_1.state_ = "waiting"
		end

		function arg_319_1.playNext_(arg_321_0)
			if arg_321_0 == 1 then
				arg_319_0:Play1104902078(arg_319_1)
			end
		end

		function arg_319_1.onSingleLineUpdate_(arg_322_0)
			local var_322_0 = 0
			local var_322_1 = 0.4

			if var_322_0 < arg_319_1.time_ and arg_319_1.time_ <= var_322_0 + arg_322_0 then
				arg_319_1.talkMaxDuration = 0
				arg_319_1.dialogCg_.alpha = 1

				arg_319_1.dialog_:SetActive(true)
				SetActive(arg_319_1.leftNameGo_, true)

				local var_322_2 = arg_319_1:FormatText(StoryNameCfg[7].name)

				arg_319_1.leftNameTxt_.text = var_322_2

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

				local var_322_3 = arg_319_1:GetWordFromCfg(1104902077)
				local var_322_4 = arg_319_1:FormatText(var_322_3.content)

				arg_319_1.text_.text = var_322_4

				LuaForUtil.ClearLinePrefixSymbol(arg_319_1.text_)

				local var_322_5 = 16
				local var_322_6 = utf8.len(var_322_4)
				local var_322_7 = var_322_5 <= 0 and var_322_1 or var_322_1 * (var_322_6 / var_322_5)

				if var_322_7 > 0 and var_322_1 < var_322_7 then
					arg_319_1.talkMaxDuration = var_322_7

					if var_322_7 + var_322_0 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_7 + var_322_0
					end
				end

				arg_319_1.text_.text = var_322_4
				arg_319_1.typewritter.percent = 0

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(false)
				arg_319_1:RecordContent(arg_319_1.text_.text)
			end

			local var_322_8 = math.max(var_322_1, arg_319_1.talkMaxDuration)

			if var_322_0 <= arg_319_1.time_ and arg_319_1.time_ < var_322_0 + var_322_8 then
				arg_319_1.typewritter.percent = (arg_319_1.time_ - var_322_0) / var_322_8

				arg_319_1.typewritter:SetDirty()
			end

			if arg_319_1.time_ >= var_322_0 + var_322_8 and arg_319_1.time_ < var_322_0 + var_322_8 + arg_322_0 then
				arg_319_1.typewritter.percent = 1

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(true)
			end
		end

		arg_319_1.nodeConfigList_ = {}

		arg_319_1:InitPlayNodeList()
	end,
	Play1104902078 = function(arg_323_0, arg_323_1)
		arg_323_1.time_ = 0
		arg_323_1.frameCnt_ = 0
		arg_323_1.state_ = "playing"
		arg_323_1.curTalkId_ = 1104902078
		arg_323_1.duration_ = 3.8

		local var_323_0 = {
			zh = 3.8,
			ja = 2.8
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
				arg_323_0:Play1104902079(arg_323_1)
			end
		end

		function arg_323_1.onSingleLineUpdate_(arg_326_0)
			local var_326_0 = arg_323_1.actors_["1049ui_story"].transform
			local var_326_1 = 0

			if var_326_1 < arg_323_1.time_ and arg_323_1.time_ <= var_326_1 + arg_326_0 then
				arg_323_1.var_.moveOldPos1049ui_story = var_326_0.localPosition
			end

			local var_326_2 = 0.001

			if var_326_1 <= arg_323_1.time_ and arg_323_1.time_ < var_326_1 + var_326_2 then
				local var_326_3 = (arg_323_1.time_ - var_326_1) / var_326_2
				local var_326_4 = Vector3.New(0, -1.2, -6)

				var_326_0.localPosition = Vector3.Lerp(arg_323_1.var_.moveOldPos1049ui_story, var_326_4, var_326_3)

				local var_326_5 = manager.ui.mainCamera.transform.position - var_326_0.position

				var_326_0.forward = Vector3.New(var_326_5.x, var_326_5.y, var_326_5.z)

				local var_326_6 = var_326_0.localEulerAngles

				var_326_6.z = 0
				var_326_6.x = 0
				var_326_0.localEulerAngles = var_326_6
			end

			if arg_323_1.time_ >= var_326_1 + var_326_2 and arg_323_1.time_ < var_326_1 + var_326_2 + arg_326_0 then
				var_326_0.localPosition = Vector3.New(0, -1.2, -6)

				local var_326_7 = manager.ui.mainCamera.transform.position - var_326_0.position

				var_326_0.forward = Vector3.New(var_326_7.x, var_326_7.y, var_326_7.z)

				local var_326_8 = var_326_0.localEulerAngles

				var_326_8.z = 0
				var_326_8.x = 0
				var_326_0.localEulerAngles = var_326_8
			end

			local var_326_9 = arg_323_1.actors_["1049ui_story"]
			local var_326_10 = 0

			if var_326_10 < arg_323_1.time_ and arg_323_1.time_ <= var_326_10 + arg_326_0 and not isNil(var_326_9) and arg_323_1.var_.characterEffect1049ui_story == nil then
				arg_323_1.var_.characterEffect1049ui_story = var_326_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_326_11 = 0.200000002980232

			if var_326_10 <= arg_323_1.time_ and arg_323_1.time_ < var_326_10 + var_326_11 and not isNil(var_326_9) then
				local var_326_12 = (arg_323_1.time_ - var_326_10) / var_326_11

				if arg_323_1.var_.characterEffect1049ui_story and not isNil(var_326_9) then
					arg_323_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_323_1.time_ >= var_326_10 + var_326_11 and arg_323_1.time_ < var_326_10 + var_326_11 + arg_326_0 and not isNil(var_326_9) and arg_323_1.var_.characterEffect1049ui_story then
				arg_323_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_326_13 = 0

			if var_326_13 < arg_323_1.time_ and arg_323_1.time_ <= var_326_13 + arg_326_0 then
				arg_323_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action1_1")
			end

			local var_326_14 = 0

			if var_326_14 < arg_323_1.time_ and arg_323_1.time_ <= var_326_14 + arg_326_0 then
				arg_323_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_326_15 = 0
			local var_326_16 = 0.45

			if var_326_15 < arg_323_1.time_ and arg_323_1.time_ <= var_326_15 + arg_326_0 then
				arg_323_1.talkMaxDuration = 0
				arg_323_1.dialogCg_.alpha = 1

				arg_323_1.dialog_:SetActive(true)
				SetActive(arg_323_1.leftNameGo_, true)

				local var_326_17 = arg_323_1:FormatText(StoryNameCfg[551].name)

				arg_323_1.leftNameTxt_.text = var_326_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_323_1.leftNameTxt_.transform)

				arg_323_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_323_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_323_1:RecordName(arg_323_1.leftNameTxt_.text)
				SetActive(arg_323_1.iconTrs_.gameObject, false)
				arg_323_1.callingController_:SetSelectedState("normal")

				local var_326_18 = arg_323_1:GetWordFromCfg(1104902078)
				local var_326_19 = arg_323_1:FormatText(var_326_18.content)

				arg_323_1.text_.text = var_326_19

				LuaForUtil.ClearLinePrefixSymbol(arg_323_1.text_)

				local var_326_20 = 18
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

				if manager.audio:GetVoiceLength("story_v_side_new_1104902", "1104902078", "story_v_side_new_1104902.awb") ~= 0 then
					local var_326_23 = manager.audio:GetVoiceLength("story_v_side_new_1104902", "1104902078", "story_v_side_new_1104902.awb") / 1000

					if var_326_23 + var_326_15 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_23 + var_326_15
					end

					if var_326_18.prefab_name ~= "" and arg_323_1.actors_[var_326_18.prefab_name] ~= nil then
						local var_326_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_323_1.actors_[var_326_18.prefab_name].transform, "story_v_side_new_1104902", "1104902078", "story_v_side_new_1104902.awb")

						arg_323_1:RecordAudio("1104902078", var_326_24)
						arg_323_1:RecordAudio("1104902078", var_326_24)
					else
						arg_323_1:AudioAction("play", "voice", "story_v_side_new_1104902", "1104902078", "story_v_side_new_1104902.awb")
					end

					arg_323_1:RecordHistoryTalkVoice("story_v_side_new_1104902", "1104902078", "story_v_side_new_1104902.awb")
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
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_323_1:InitPlayNodeList()
	end,
	Play1104902079 = function(arg_327_0, arg_327_1)
		arg_327_1.time_ = 0
		arg_327_1.frameCnt_ = 0
		arg_327_1.state_ = "playing"
		arg_327_1.curTalkId_ = 1104902079
		arg_327_1.duration_ = 2.67

		local var_327_0 = {
			zh = 1.3,
			ja = 2.666
		}
		local var_327_1 = manager.audio:GetLocalizationFlag()

		if var_327_0[var_327_1] ~= nil then
			arg_327_1.duration_ = var_327_0[var_327_1]
		end

		SetActive(arg_327_1.tipsGo_, false)

		function arg_327_1.onSingleLineFinish_()
			arg_327_1.onSingleLineUpdate_ = nil
			arg_327_1.onSingleLineFinish_ = nil
			arg_327_1.state_ = "waiting"
		end

		function arg_327_1.playNext_(arg_329_0)
			if arg_329_0 == 1 then
				arg_327_0:Play1104902080(arg_327_1)
			end
		end

		function arg_327_1.onSingleLineUpdate_(arg_330_0)
			local var_330_0 = arg_327_1.actors_["1049ui_story"].transform
			local var_330_1 = 0

			if var_330_1 < arg_327_1.time_ and arg_327_1.time_ <= var_330_1 + arg_330_0 then
				arg_327_1.var_.moveOldPos1049ui_story = var_330_0.localPosition
			end

			local var_330_2 = 0.001

			if var_330_1 <= arg_327_1.time_ and arg_327_1.time_ < var_330_1 + var_330_2 then
				local var_330_3 = (arg_327_1.time_ - var_330_1) / var_330_2
				local var_330_4 = Vector3.New(0, 100, 0)

				var_330_0.localPosition = Vector3.Lerp(arg_327_1.var_.moveOldPos1049ui_story, var_330_4, var_330_3)

				local var_330_5 = manager.ui.mainCamera.transform.position - var_330_0.position

				var_330_0.forward = Vector3.New(var_330_5.x, var_330_5.y, var_330_5.z)

				local var_330_6 = var_330_0.localEulerAngles

				var_330_6.z = 0
				var_330_6.x = 0
				var_330_0.localEulerAngles = var_330_6
			end

			if arg_327_1.time_ >= var_330_1 + var_330_2 and arg_327_1.time_ < var_330_1 + var_330_2 + arg_330_0 then
				var_330_0.localPosition = Vector3.New(0, 100, 0)

				local var_330_7 = manager.ui.mainCamera.transform.position - var_330_0.position

				var_330_0.forward = Vector3.New(var_330_7.x, var_330_7.y, var_330_7.z)

				local var_330_8 = var_330_0.localEulerAngles

				var_330_8.z = 0
				var_330_8.x = 0
				var_330_0.localEulerAngles = var_330_8
			end

			local var_330_9 = arg_327_1.actors_["1049ui_story"]
			local var_330_10 = 0

			if var_330_10 < arg_327_1.time_ and arg_327_1.time_ <= var_330_10 + arg_330_0 and not isNil(var_330_9) and arg_327_1.var_.characterEffect1049ui_story == nil then
				arg_327_1.var_.characterEffect1049ui_story = var_330_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_330_11 = 0.200000002980232

			if var_330_10 <= arg_327_1.time_ and arg_327_1.time_ < var_330_10 + var_330_11 and not isNil(var_330_9) then
				local var_330_12 = (arg_327_1.time_ - var_330_10) / var_330_11

				if arg_327_1.var_.characterEffect1049ui_story and not isNil(var_330_9) then
					local var_330_13 = Mathf.Lerp(0, 0.5, var_330_12)

					arg_327_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_327_1.var_.characterEffect1049ui_story.fillRatio = var_330_13
				end
			end

			if arg_327_1.time_ >= var_330_10 + var_330_11 and arg_327_1.time_ < var_330_10 + var_330_11 + arg_330_0 and not isNil(var_330_9) and arg_327_1.var_.characterEffect1049ui_story then
				local var_330_14 = 0.5

				arg_327_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_327_1.var_.characterEffect1049ui_story.fillRatio = var_330_14
			end

			local var_330_15 = 0
			local var_330_16 = 0.075

			if var_330_15 < arg_327_1.time_ and arg_327_1.time_ <= var_330_15 + arg_330_0 then
				arg_327_1.talkMaxDuration = 0
				arg_327_1.dialogCg_.alpha = 1

				arg_327_1.dialog_:SetActive(true)
				SetActive(arg_327_1.leftNameGo_, true)

				local var_330_17 = arg_327_1:FormatText(StoryNameCfg[36].name)

				arg_327_1.leftNameTxt_.text = var_330_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_327_1.leftNameTxt_.transform)

				arg_327_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_327_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_327_1:RecordName(arg_327_1.leftNameTxt_.text)
				SetActive(arg_327_1.iconTrs_.gameObject, true)
				arg_327_1.iconController_:SetSelectedState("hero")

				arg_327_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10056_c")

				arg_327_1.callingController_:SetSelectedState("normal")

				arg_327_1.keyicon_.color = Color.New(1, 1, 1)
				arg_327_1.icon_.color = Color.New(1, 1, 1)

				local var_330_18 = arg_327_1:GetWordFromCfg(1104902079)
				local var_330_19 = arg_327_1:FormatText(var_330_18.content)

				arg_327_1.text_.text = var_330_19

				LuaForUtil.ClearLinePrefixSymbol(arg_327_1.text_)

				local var_330_20 = 3
				local var_330_21 = utf8.len(var_330_19)
				local var_330_22 = var_330_20 <= 0 and var_330_16 or var_330_16 * (var_330_21 / var_330_20)

				if var_330_22 > 0 and var_330_16 < var_330_22 then
					arg_327_1.talkMaxDuration = var_330_22

					if var_330_22 + var_330_15 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_22 + var_330_15
					end
				end

				arg_327_1.text_.text = var_330_19
				arg_327_1.typewritter.percent = 0

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104902", "1104902079", "story_v_side_new_1104902.awb") ~= 0 then
					local var_330_23 = manager.audio:GetVoiceLength("story_v_side_new_1104902", "1104902079", "story_v_side_new_1104902.awb") / 1000

					if var_330_23 + var_330_15 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_23 + var_330_15
					end

					if var_330_18.prefab_name ~= "" and arg_327_1.actors_[var_330_18.prefab_name] ~= nil then
						local var_330_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_327_1.actors_[var_330_18.prefab_name].transform, "story_v_side_new_1104902", "1104902079", "story_v_side_new_1104902.awb")

						arg_327_1:RecordAudio("1104902079", var_330_24)
						arg_327_1:RecordAudio("1104902079", var_330_24)
					else
						arg_327_1:AudioAction("play", "voice", "story_v_side_new_1104902", "1104902079", "story_v_side_new_1104902.awb")
					end

					arg_327_1:RecordHistoryTalkVoice("story_v_side_new_1104902", "1104902079", "story_v_side_new_1104902.awb")
				end

				arg_327_1:RecordContent(arg_327_1.text_.text)
			end

			local var_330_25 = math.max(var_330_16, arg_327_1.talkMaxDuration)

			if var_330_15 <= arg_327_1.time_ and arg_327_1.time_ < var_330_15 + var_330_25 then
				arg_327_1.typewritter.percent = (arg_327_1.time_ - var_330_15) / var_330_25

				arg_327_1.typewritter:SetDirty()
			end

			if arg_327_1.time_ >= var_330_15 + var_330_25 and arg_327_1.time_ < var_330_15 + var_330_25 + arg_330_0 then
				arg_327_1.typewritter.percent = 1

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(true)
			end
		end

		arg_327_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_327_1:InitPlayNodeList()
	end,
	Play1104902080 = function(arg_331_0, arg_331_1)
		arg_331_1.time_ = 0
		arg_331_1.frameCnt_ = 0
		arg_331_1.state_ = "playing"
		arg_331_1.curTalkId_ = 1104902080
		arg_331_1.duration_ = 5

		SetActive(arg_331_1.tipsGo_, false)

		function arg_331_1.onSingleLineFinish_()
			arg_331_1.onSingleLineUpdate_ = nil
			arg_331_1.onSingleLineFinish_ = nil
			arg_331_1.state_ = "waiting"
		end

		function arg_331_1.playNext_(arg_333_0)
			if arg_333_0 == 1 then
				arg_331_0:Play1104902081(arg_331_1)
			end
		end

		function arg_331_1.onSingleLineUpdate_(arg_334_0)
			local var_334_0 = 0
			local var_334_1 = 1

			if var_334_0 < arg_331_1.time_ and arg_331_1.time_ <= var_334_0 + arg_334_0 then
				arg_331_1.talkMaxDuration = 0
				arg_331_1.dialogCg_.alpha = 1

				arg_331_1.dialog_:SetActive(true)
				SetActive(arg_331_1.leftNameGo_, false)

				arg_331_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_331_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_331_1:RecordName(arg_331_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_331_1.iconTrs_.gameObject, false)
				arg_331_1.callingController_:SetSelectedState("normal")

				local var_334_2 = arg_331_1:GetWordFromCfg(1104902080)
				local var_334_3 = arg_331_1:FormatText(var_334_2.content)

				arg_331_1.text_.text = var_334_3

				LuaForUtil.ClearLinePrefixSymbol(arg_331_1.text_)

				local var_334_4 = 40
				local var_334_5 = utf8.len(var_334_3)
				local var_334_6 = var_334_4 <= 0 and var_334_1 or var_334_1 * (var_334_5 / var_334_4)

				if var_334_6 > 0 and var_334_1 < var_334_6 then
					arg_331_1.talkMaxDuration = var_334_6

					if var_334_6 + var_334_0 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_6 + var_334_0
					end
				end

				arg_331_1.text_.text = var_334_3
				arg_331_1.typewritter.percent = 0

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(false)
				arg_331_1:RecordContent(arg_331_1.text_.text)
			end

			local var_334_7 = math.max(var_334_1, arg_331_1.talkMaxDuration)

			if var_334_0 <= arg_331_1.time_ and arg_331_1.time_ < var_334_0 + var_334_7 then
				arg_331_1.typewritter.percent = (arg_331_1.time_ - var_334_0) / var_334_7

				arg_331_1.typewritter:SetDirty()
			end

			if arg_331_1.time_ >= var_334_0 + var_334_7 and arg_331_1.time_ < var_334_0 + var_334_7 + arg_334_0 then
				arg_331_1.typewritter.percent = 1

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(true)
			end
		end

		arg_331_1.nodeConfigList_ = {}

		arg_331_1:InitPlayNodeList()
	end,
	Play1104902081 = function(arg_335_0, arg_335_1)
		arg_335_1.time_ = 0
		arg_335_1.frameCnt_ = 0
		arg_335_1.state_ = "playing"
		arg_335_1.curTalkId_ = 1104902081
		arg_335_1.duration_ = 8.23

		local var_335_0 = {
			zh = 8.233,
			ja = 6.7
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
				arg_335_0:Play1104902082(arg_335_1)
			end
		end

		function arg_335_1.onSingleLineUpdate_(arg_338_0)
			local var_338_0 = 0
			local var_338_1 = 0.775

			if var_338_0 < arg_335_1.time_ and arg_335_1.time_ <= var_338_0 + arg_338_0 then
				arg_335_1.talkMaxDuration = 0
				arg_335_1.dialogCg_.alpha = 1

				arg_335_1.dialog_:SetActive(true)
				SetActive(arg_335_1.leftNameGo_, true)

				local var_338_2 = arg_335_1:FormatText(StoryNameCfg[1009].name)

				arg_335_1.leftNameTxt_.text = var_338_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_335_1.leftNameTxt_.transform)

				arg_335_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_335_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_335_1:RecordName(arg_335_1.leftNameTxt_.text)
				SetActive(arg_335_1.iconTrs_.gameObject, true)
				arg_335_1.iconController_:SetSelectedState("hero")

				arg_335_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10056_c")

				arg_335_1.callingController_:SetSelectedState("normal")

				arg_335_1.keyicon_.color = Color.New(1, 1, 1)
				arg_335_1.icon_.color = Color.New(1, 1, 1)

				local var_338_3 = arg_335_1:GetWordFromCfg(1104902081)
				local var_338_4 = arg_335_1:FormatText(var_338_3.content)

				arg_335_1.text_.text = var_338_4

				LuaForUtil.ClearLinePrefixSymbol(arg_335_1.text_)

				local var_338_5 = 31
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

				if manager.audio:GetVoiceLength("story_v_side_new_1104902", "1104902081", "story_v_side_new_1104902.awb") ~= 0 then
					local var_338_8 = manager.audio:GetVoiceLength("story_v_side_new_1104902", "1104902081", "story_v_side_new_1104902.awb") / 1000

					if var_338_8 + var_338_0 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_8 + var_338_0
					end

					if var_338_3.prefab_name ~= "" and arg_335_1.actors_[var_338_3.prefab_name] ~= nil then
						local var_338_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_335_1.actors_[var_338_3.prefab_name].transform, "story_v_side_new_1104902", "1104902081", "story_v_side_new_1104902.awb")

						arg_335_1:RecordAudio("1104902081", var_338_9)
						arg_335_1:RecordAudio("1104902081", var_338_9)
					else
						arg_335_1:AudioAction("play", "voice", "story_v_side_new_1104902", "1104902081", "story_v_side_new_1104902.awb")
					end

					arg_335_1:RecordHistoryTalkVoice("story_v_side_new_1104902", "1104902081", "story_v_side_new_1104902.awb")
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
	Play1104902082 = function(arg_339_0, arg_339_1)
		arg_339_1.time_ = 0
		arg_339_1.frameCnt_ = 0
		arg_339_1.state_ = "playing"
		arg_339_1.curTalkId_ = 1104902082
		arg_339_1.duration_ = 5

		SetActive(arg_339_1.tipsGo_, false)

		function arg_339_1.onSingleLineFinish_()
			arg_339_1.onSingleLineUpdate_ = nil
			arg_339_1.onSingleLineFinish_ = nil
			arg_339_1.state_ = "waiting"
		end

		function arg_339_1.playNext_(arg_341_0)
			if arg_341_0 == 1 then
				arg_339_0:Play1104902083(arg_339_1)
			end
		end

		function arg_339_1.onSingleLineUpdate_(arg_342_0)
			local var_342_0 = 0
			local var_342_1 = 0.4

			if var_342_0 < arg_339_1.time_ and arg_339_1.time_ <= var_342_0 + arg_342_0 then
				arg_339_1.talkMaxDuration = 0
				arg_339_1.dialogCg_.alpha = 1

				arg_339_1.dialog_:SetActive(true)
				SetActive(arg_339_1.leftNameGo_, true)

				local var_342_2 = arg_339_1:FormatText(StoryNameCfg[7].name)

				arg_339_1.leftNameTxt_.text = var_342_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_339_1.leftNameTxt_.transform)

				arg_339_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_339_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_339_1:RecordName(arg_339_1.leftNameTxt_.text)
				SetActive(arg_339_1.iconTrs_.gameObject, true)
				arg_339_1.iconController_:SetSelectedState("hero")

				arg_339_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_339_1.callingController_:SetSelectedState("normal")

				arg_339_1.keyicon_.color = Color.New(1, 1, 1)
				arg_339_1.icon_.color = Color.New(1, 1, 1)

				local var_342_3 = arg_339_1:GetWordFromCfg(1104902082)
				local var_342_4 = arg_339_1:FormatText(var_342_3.content)

				arg_339_1.text_.text = var_342_4

				LuaForUtil.ClearLinePrefixSymbol(arg_339_1.text_)

				local var_342_5 = 16
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
				arg_339_1:RecordContent(arg_339_1.text_.text)
			end

			local var_342_8 = math.max(var_342_1, arg_339_1.talkMaxDuration)

			if var_342_0 <= arg_339_1.time_ and arg_339_1.time_ < var_342_0 + var_342_8 then
				arg_339_1.typewritter.percent = (arg_339_1.time_ - var_342_0) / var_342_8

				arg_339_1.typewritter:SetDirty()
			end

			if arg_339_1.time_ >= var_342_0 + var_342_8 and arg_339_1.time_ < var_342_0 + var_342_8 + arg_342_0 then
				arg_339_1.typewritter.percent = 1

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(true)
			end
		end

		arg_339_1.nodeConfigList_ = {}

		arg_339_1:InitPlayNodeList()
	end,
	Play1104902083 = function(arg_343_0, arg_343_1)
		arg_343_1.time_ = 0
		arg_343_1.frameCnt_ = 0
		arg_343_1.state_ = "playing"
		arg_343_1.curTalkId_ = 1104902083
		arg_343_1.duration_ = 8.3

		local var_343_0 = {
			zh = 7.8,
			ja = 8.3
		}
		local var_343_1 = manager.audio:GetLocalizationFlag()

		if var_343_0[var_343_1] ~= nil then
			arg_343_1.duration_ = var_343_0[var_343_1]
		end

		SetActive(arg_343_1.tipsGo_, false)

		function arg_343_1.onSingleLineFinish_()
			arg_343_1.onSingleLineUpdate_ = nil
			arg_343_1.onSingleLineFinish_ = nil
			arg_343_1.state_ = "waiting"
		end

		function arg_343_1.playNext_(arg_345_0)
			if arg_345_0 == 1 then
				arg_343_0:Play1104902084(arg_343_1)
			end
		end

		function arg_343_1.onSingleLineUpdate_(arg_346_0)
			local var_346_0 = 0
			local var_346_1 = 1

			if var_346_0 < arg_343_1.time_ and arg_343_1.time_ <= var_346_0 + arg_346_0 then
				arg_343_1.talkMaxDuration = 0
				arg_343_1.dialogCg_.alpha = 1

				arg_343_1.dialog_:SetActive(true)
				SetActive(arg_343_1.leftNameGo_, true)

				local var_346_2 = arg_343_1:FormatText(StoryNameCfg[1009].name)

				arg_343_1.leftNameTxt_.text = var_346_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_343_1.leftNameTxt_.transform)

				arg_343_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_343_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_343_1:RecordName(arg_343_1.leftNameTxt_.text)
				SetActive(arg_343_1.iconTrs_.gameObject, true)
				arg_343_1.iconController_:SetSelectedState("hero")

				arg_343_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10056_c")

				arg_343_1.callingController_:SetSelectedState("normal")

				arg_343_1.keyicon_.color = Color.New(1, 1, 1)
				arg_343_1.icon_.color = Color.New(1, 1, 1)

				local var_346_3 = arg_343_1:GetWordFromCfg(1104902083)
				local var_346_4 = arg_343_1:FormatText(var_346_3.content)

				arg_343_1.text_.text = var_346_4

				LuaForUtil.ClearLinePrefixSymbol(arg_343_1.text_)

				local var_346_5 = 40
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

				if manager.audio:GetVoiceLength("story_v_side_new_1104902", "1104902083", "story_v_side_new_1104902.awb") ~= 0 then
					local var_346_8 = manager.audio:GetVoiceLength("story_v_side_new_1104902", "1104902083", "story_v_side_new_1104902.awb") / 1000

					if var_346_8 + var_346_0 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_8 + var_346_0
					end

					if var_346_3.prefab_name ~= "" and arg_343_1.actors_[var_346_3.prefab_name] ~= nil then
						local var_346_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_343_1.actors_[var_346_3.prefab_name].transform, "story_v_side_new_1104902", "1104902083", "story_v_side_new_1104902.awb")

						arg_343_1:RecordAudio("1104902083", var_346_9)
						arg_343_1:RecordAudio("1104902083", var_346_9)
					else
						arg_343_1:AudioAction("play", "voice", "story_v_side_new_1104902", "1104902083", "story_v_side_new_1104902.awb")
					end

					arg_343_1:RecordHistoryTalkVoice("story_v_side_new_1104902", "1104902083", "story_v_side_new_1104902.awb")
				end

				arg_343_1:RecordContent(arg_343_1.text_.text)
			end

			local var_346_10 = math.max(var_346_1, arg_343_1.talkMaxDuration)

			if var_346_0 <= arg_343_1.time_ and arg_343_1.time_ < var_346_0 + var_346_10 then
				arg_343_1.typewritter.percent = (arg_343_1.time_ - var_346_0) / var_346_10

				arg_343_1.typewritter:SetDirty()
			end

			if arg_343_1.time_ >= var_346_0 + var_346_10 and arg_343_1.time_ < var_346_0 + var_346_10 + arg_346_0 then
				arg_343_1.typewritter.percent = 1

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(true)
			end
		end

		arg_343_1.nodeConfigList_ = {}

		arg_343_1:InitPlayNodeList()
	end,
	Play1104902084 = function(arg_347_0, arg_347_1)
		arg_347_1.time_ = 0
		arg_347_1.frameCnt_ = 0
		arg_347_1.state_ = "playing"
		arg_347_1.curTalkId_ = 1104902084
		arg_347_1.duration_ = 6.7

		local var_347_0 = {
			zh = 6.7,
			ja = 4.3
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
				arg_347_0:Play1104902085(arg_347_1)
			end
		end

		function arg_347_1.onSingleLineUpdate_(arg_350_0)
			local var_350_0 = 0
			local var_350_1 = 0.8

			if var_350_0 < arg_347_1.time_ and arg_347_1.time_ <= var_350_0 + arg_350_0 then
				arg_347_1.talkMaxDuration = 0
				arg_347_1.dialogCg_.alpha = 1

				arg_347_1.dialog_:SetActive(true)
				SetActive(arg_347_1.leftNameGo_, true)

				local var_350_2 = arg_347_1:FormatText(StoryNameCfg[1009].name)

				arg_347_1.leftNameTxt_.text = var_350_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_347_1.leftNameTxt_.transform)

				arg_347_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_347_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_347_1:RecordName(arg_347_1.leftNameTxt_.text)
				SetActive(arg_347_1.iconTrs_.gameObject, true)
				arg_347_1.iconController_:SetSelectedState("hero")

				arg_347_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10056_c")

				arg_347_1.callingController_:SetSelectedState("normal")

				arg_347_1.keyicon_.color = Color.New(1, 1, 1)
				arg_347_1.icon_.color = Color.New(1, 1, 1)

				local var_350_3 = arg_347_1:GetWordFromCfg(1104902084)
				local var_350_4 = arg_347_1:FormatText(var_350_3.content)

				arg_347_1.text_.text = var_350_4

				LuaForUtil.ClearLinePrefixSymbol(arg_347_1.text_)

				local var_350_5 = 32
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

				if manager.audio:GetVoiceLength("story_v_side_new_1104902", "1104902084", "story_v_side_new_1104902.awb") ~= 0 then
					local var_350_8 = manager.audio:GetVoiceLength("story_v_side_new_1104902", "1104902084", "story_v_side_new_1104902.awb") / 1000

					if var_350_8 + var_350_0 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_8 + var_350_0
					end

					if var_350_3.prefab_name ~= "" and arg_347_1.actors_[var_350_3.prefab_name] ~= nil then
						local var_350_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_347_1.actors_[var_350_3.prefab_name].transform, "story_v_side_new_1104902", "1104902084", "story_v_side_new_1104902.awb")

						arg_347_1:RecordAudio("1104902084", var_350_9)
						arg_347_1:RecordAudio("1104902084", var_350_9)
					else
						arg_347_1:AudioAction("play", "voice", "story_v_side_new_1104902", "1104902084", "story_v_side_new_1104902.awb")
					end

					arg_347_1:RecordHistoryTalkVoice("story_v_side_new_1104902", "1104902084", "story_v_side_new_1104902.awb")
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
	Play1104902085 = function(arg_351_0, arg_351_1)
		arg_351_1.time_ = 0
		arg_351_1.frameCnt_ = 0
		arg_351_1.state_ = "playing"
		arg_351_1.curTalkId_ = 1104902085
		arg_351_1.duration_ = 5

		SetActive(arg_351_1.tipsGo_, false)

		function arg_351_1.onSingleLineFinish_()
			arg_351_1.onSingleLineUpdate_ = nil
			arg_351_1.onSingleLineFinish_ = nil
			arg_351_1.state_ = "waiting"
		end

		function arg_351_1.playNext_(arg_353_0)
			if arg_353_0 == 1 then
				arg_351_0:Play1104902086(arg_351_1)
			end
		end

		function arg_351_1.onSingleLineUpdate_(arg_354_0)
			local var_354_0 = 0
			local var_354_1 = 0.275

			if var_354_0 < arg_351_1.time_ and arg_351_1.time_ <= var_354_0 + arg_354_0 then
				arg_351_1.talkMaxDuration = 0
				arg_351_1.dialogCg_.alpha = 1

				arg_351_1.dialog_:SetActive(true)
				SetActive(arg_351_1.leftNameGo_, false)

				arg_351_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_351_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_351_1:RecordName(arg_351_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_351_1.iconTrs_.gameObject, false)
				arg_351_1.callingController_:SetSelectedState("normal")

				local var_354_2 = arg_351_1:GetWordFromCfg(1104902085)
				local var_354_3 = arg_351_1:FormatText(var_354_2.content)

				arg_351_1.text_.text = var_354_3

				LuaForUtil.ClearLinePrefixSymbol(arg_351_1.text_)

				local var_354_4 = 11
				local var_354_5 = utf8.len(var_354_3)
				local var_354_6 = var_354_4 <= 0 and var_354_1 or var_354_1 * (var_354_5 / var_354_4)

				if var_354_6 > 0 and var_354_1 < var_354_6 then
					arg_351_1.talkMaxDuration = var_354_6

					if var_354_6 + var_354_0 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_6 + var_354_0
					end
				end

				arg_351_1.text_.text = var_354_3
				arg_351_1.typewritter.percent = 0

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(false)
				arg_351_1:RecordContent(arg_351_1.text_.text)
			end

			local var_354_7 = math.max(var_354_1, arg_351_1.talkMaxDuration)

			if var_354_0 <= arg_351_1.time_ and arg_351_1.time_ < var_354_0 + var_354_7 then
				arg_351_1.typewritter.percent = (arg_351_1.time_ - var_354_0) / var_354_7

				arg_351_1.typewritter:SetDirty()
			end

			if arg_351_1.time_ >= var_354_0 + var_354_7 and arg_351_1.time_ < var_354_0 + var_354_7 + arg_354_0 then
				arg_351_1.typewritter.percent = 1

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(true)
			end
		end

		arg_351_1.nodeConfigList_ = {}

		arg_351_1:InitPlayNodeList()
	end,
	Play1104902086 = function(arg_355_0, arg_355_1)
		arg_355_1.time_ = 0
		arg_355_1.frameCnt_ = 0
		arg_355_1.state_ = "playing"
		arg_355_1.curTalkId_ = 1104902086
		arg_355_1.duration_ = 5.03

		local var_355_0 = {
			zh = 2.466,
			ja = 5.033
		}
		local var_355_1 = manager.audio:GetLocalizationFlag()

		if var_355_0[var_355_1] ~= nil then
			arg_355_1.duration_ = var_355_0[var_355_1]
		end

		SetActive(arg_355_1.tipsGo_, false)

		function arg_355_1.onSingleLineFinish_()
			arg_355_1.onSingleLineUpdate_ = nil
			arg_355_1.onSingleLineFinish_ = nil
			arg_355_1.state_ = "waiting"
		end

		function arg_355_1.playNext_(arg_357_0)
			if arg_357_0 == 1 then
				arg_355_0:Play1104902087(arg_355_1)
			end
		end

		function arg_355_1.onSingleLineUpdate_(arg_358_0)
			local var_358_0 = 0

			if var_358_0 < arg_355_1.time_ and arg_355_1.time_ <= var_358_0 + arg_358_0 then
				arg_355_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action8_1")
			end

			local var_358_1 = 0
			local var_358_2 = 0.3

			if var_358_1 < arg_355_1.time_ and arg_355_1.time_ <= var_358_1 + arg_358_0 then
				arg_355_1.talkMaxDuration = 0
				arg_355_1.dialogCg_.alpha = 1

				arg_355_1.dialog_:SetActive(true)
				SetActive(arg_355_1.leftNameGo_, true)

				local var_358_3 = arg_355_1:FormatText(StoryNameCfg[1009].name)

				arg_355_1.leftNameTxt_.text = var_358_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_355_1.leftNameTxt_.transform)

				arg_355_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_355_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_355_1:RecordName(arg_355_1.leftNameTxt_.text)
				SetActive(arg_355_1.iconTrs_.gameObject, true)
				arg_355_1.iconController_:SetSelectedState("hero")

				arg_355_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10056_c")

				arg_355_1.callingController_:SetSelectedState("normal")

				arg_355_1.keyicon_.color = Color.New(1, 1, 1)
				arg_355_1.icon_.color = Color.New(1, 1, 1)

				local var_358_4 = arg_355_1:GetWordFromCfg(1104902086)
				local var_358_5 = arg_355_1:FormatText(var_358_4.content)

				arg_355_1.text_.text = var_358_5

				LuaForUtil.ClearLinePrefixSymbol(arg_355_1.text_)

				local var_358_6 = 12
				local var_358_7 = utf8.len(var_358_5)
				local var_358_8 = var_358_6 <= 0 and var_358_2 or var_358_2 * (var_358_7 / var_358_6)

				if var_358_8 > 0 and var_358_2 < var_358_8 then
					arg_355_1.talkMaxDuration = var_358_8

					if var_358_8 + var_358_1 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_8 + var_358_1
					end
				end

				arg_355_1.text_.text = var_358_5
				arg_355_1.typewritter.percent = 0

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104902", "1104902086", "story_v_side_new_1104902.awb") ~= 0 then
					local var_358_9 = manager.audio:GetVoiceLength("story_v_side_new_1104902", "1104902086", "story_v_side_new_1104902.awb") / 1000

					if var_358_9 + var_358_1 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_9 + var_358_1
					end

					if var_358_4.prefab_name ~= "" and arg_355_1.actors_[var_358_4.prefab_name] ~= nil then
						local var_358_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_355_1.actors_[var_358_4.prefab_name].transform, "story_v_side_new_1104902", "1104902086", "story_v_side_new_1104902.awb")

						arg_355_1:RecordAudio("1104902086", var_358_10)
						arg_355_1:RecordAudio("1104902086", var_358_10)
					else
						arg_355_1:AudioAction("play", "voice", "story_v_side_new_1104902", "1104902086", "story_v_side_new_1104902.awb")
					end

					arg_355_1:RecordHistoryTalkVoice("story_v_side_new_1104902", "1104902086", "story_v_side_new_1104902.awb")
				end

				arg_355_1:RecordContent(arg_355_1.text_.text)
			end

			local var_358_11 = math.max(var_358_2, arg_355_1.talkMaxDuration)

			if var_358_1 <= arg_355_1.time_ and arg_355_1.time_ < var_358_1 + var_358_11 then
				arg_355_1.typewritter.percent = (arg_355_1.time_ - var_358_1) / var_358_11

				arg_355_1.typewritter:SetDirty()
			end

			if arg_355_1.time_ >= var_358_1 + var_358_11 and arg_355_1.time_ < var_358_1 + var_358_11 + arg_358_0 then
				arg_355_1.typewritter.percent = 1

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(true)
			end
		end

		arg_355_1.nodeConfigList_ = {}

		arg_355_1:InitPlayNodeList()
	end,
	Play1104902087 = function(arg_359_0, arg_359_1)
		arg_359_1.time_ = 0
		arg_359_1.frameCnt_ = 0
		arg_359_1.state_ = "playing"
		arg_359_1.curTalkId_ = 1104902087
		arg_359_1.duration_ = 5

		SetActive(arg_359_1.tipsGo_, false)

		function arg_359_1.onSingleLineFinish_()
			arg_359_1.onSingleLineUpdate_ = nil
			arg_359_1.onSingleLineFinish_ = nil
			arg_359_1.state_ = "waiting"
		end

		function arg_359_1.playNext_(arg_361_0)
			if arg_361_0 == 1 then
				arg_359_0:Play1104902088(arg_359_1)
			end
		end

		function arg_359_1.onSingleLineUpdate_(arg_362_0)
			local var_362_0 = arg_359_1.actors_["1049ui_story"].transform
			local var_362_1 = 0

			if var_362_1 < arg_359_1.time_ and arg_359_1.time_ <= var_362_1 + arg_362_0 then
				arg_359_1.var_.moveOldPos1049ui_story = var_362_0.localPosition
			end

			local var_362_2 = 0.001

			if var_362_1 <= arg_359_1.time_ and arg_359_1.time_ < var_362_1 + var_362_2 then
				local var_362_3 = (arg_359_1.time_ - var_362_1) / var_362_2
				local var_362_4 = Vector3.New(0, -1.2, -6)

				var_362_0.localPosition = Vector3.Lerp(arg_359_1.var_.moveOldPos1049ui_story, var_362_4, var_362_3)

				local var_362_5 = manager.ui.mainCamera.transform.position - var_362_0.position

				var_362_0.forward = Vector3.New(var_362_5.x, var_362_5.y, var_362_5.z)

				local var_362_6 = var_362_0.localEulerAngles

				var_362_6.z = 0
				var_362_6.x = 0
				var_362_0.localEulerAngles = var_362_6
			end

			if arg_359_1.time_ >= var_362_1 + var_362_2 and arg_359_1.time_ < var_362_1 + var_362_2 + arg_362_0 then
				var_362_0.localPosition = Vector3.New(0, -1.2, -6)

				local var_362_7 = manager.ui.mainCamera.transform.position - var_362_0.position

				var_362_0.forward = Vector3.New(var_362_7.x, var_362_7.y, var_362_7.z)

				local var_362_8 = var_362_0.localEulerAngles

				var_362_8.z = 0
				var_362_8.x = 0
				var_362_0.localEulerAngles = var_362_8
			end

			local var_362_9 = 0

			if var_362_9 < arg_359_1.time_ and arg_359_1.time_ <= var_362_9 + arg_362_0 then
				arg_359_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_362_10 = 0
			local var_362_11 = 0.125

			if var_362_10 < arg_359_1.time_ and arg_359_1.time_ <= var_362_10 + arg_362_0 then
				arg_359_1.talkMaxDuration = 0
				arg_359_1.dialogCg_.alpha = 1

				arg_359_1.dialog_:SetActive(true)
				SetActive(arg_359_1.leftNameGo_, true)

				local var_362_12 = arg_359_1:FormatText(StoryNameCfg[7].name)

				arg_359_1.leftNameTxt_.text = var_362_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_359_1.leftNameTxt_.transform)

				arg_359_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_359_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_359_1:RecordName(arg_359_1.leftNameTxt_.text)
				SetActive(arg_359_1.iconTrs_.gameObject, true)
				arg_359_1.iconController_:SetSelectedState("hero")

				arg_359_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_359_1.callingController_:SetSelectedState("normal")

				arg_359_1.keyicon_.color = Color.New(1, 1, 1)
				arg_359_1.icon_.color = Color.New(1, 1, 1)

				local var_362_13 = arg_359_1:GetWordFromCfg(1104902087)
				local var_362_14 = arg_359_1:FormatText(var_362_13.content)

				arg_359_1.text_.text = var_362_14

				LuaForUtil.ClearLinePrefixSymbol(arg_359_1.text_)

				local var_362_15 = 5
				local var_362_16 = utf8.len(var_362_14)
				local var_362_17 = var_362_15 <= 0 and var_362_11 or var_362_11 * (var_362_16 / var_362_15)

				if var_362_17 > 0 and var_362_11 < var_362_17 then
					arg_359_1.talkMaxDuration = var_362_17

					if var_362_17 + var_362_10 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_17 + var_362_10
					end
				end

				arg_359_1.text_.text = var_362_14
				arg_359_1.typewritter.percent = 0

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(false)
				arg_359_1:RecordContent(arg_359_1.text_.text)
			end

			local var_362_18 = math.max(var_362_11, arg_359_1.talkMaxDuration)

			if var_362_10 <= arg_359_1.time_ and arg_359_1.time_ < var_362_10 + var_362_18 then
				arg_359_1.typewritter.percent = (arg_359_1.time_ - var_362_10) / var_362_18

				arg_359_1.typewritter:SetDirty()
			end

			if arg_359_1.time_ >= var_362_10 + var_362_18 and arg_359_1.time_ < var_362_10 + var_362_18 + arg_362_0 then
				arg_359_1.typewritter.percent = 1

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(true)
			end
		end

		arg_359_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_359_1:InitPlayNodeList()
	end,
	Play1104902088 = function(arg_363_0, arg_363_1)
		arg_363_1.time_ = 0
		arg_363_1.frameCnt_ = 0
		arg_363_1.state_ = "playing"
		arg_363_1.curTalkId_ = 1104902088
		arg_363_1.duration_ = 5

		SetActive(arg_363_1.tipsGo_, false)

		function arg_363_1.onSingleLineFinish_()
			arg_363_1.onSingleLineUpdate_ = nil
			arg_363_1.onSingleLineFinish_ = nil
			arg_363_1.state_ = "waiting"
		end

		function arg_363_1.playNext_(arg_365_0)
			if arg_365_0 == 1 then
				arg_363_0:Play1104902089(arg_363_1)
			end
		end

		function arg_363_1.onSingleLineUpdate_(arg_366_0)
			local var_366_0 = 0
			local var_366_1 = 1.05

			if var_366_0 < arg_363_1.time_ and arg_363_1.time_ <= var_366_0 + arg_366_0 then
				arg_363_1.talkMaxDuration = 0
				arg_363_1.dialogCg_.alpha = 1

				arg_363_1.dialog_:SetActive(true)
				SetActive(arg_363_1.leftNameGo_, true)

				local var_366_2 = arg_363_1:FormatText(StoryNameCfg[7].name)

				arg_363_1.leftNameTxt_.text = var_366_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_363_1.leftNameTxt_.transform)

				arg_363_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_363_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_363_1:RecordName(arg_363_1.leftNameTxt_.text)
				SetActive(arg_363_1.iconTrs_.gameObject, true)
				arg_363_1.iconController_:SetSelectedState("hero")

				arg_363_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_363_1.callingController_:SetSelectedState("normal")

				arg_363_1.keyicon_.color = Color.New(1, 1, 1)
				arg_363_1.icon_.color = Color.New(1, 1, 1)

				local var_366_3 = arg_363_1:GetWordFromCfg(1104902088)
				local var_366_4 = arg_363_1:FormatText(var_366_3.content)

				arg_363_1.text_.text = var_366_4

				LuaForUtil.ClearLinePrefixSymbol(arg_363_1.text_)

				local var_366_5 = 42
				local var_366_6 = utf8.len(var_366_4)
				local var_366_7 = var_366_5 <= 0 and var_366_1 or var_366_1 * (var_366_6 / var_366_5)

				if var_366_7 > 0 and var_366_1 < var_366_7 then
					arg_363_1.talkMaxDuration = var_366_7

					if var_366_7 + var_366_0 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_7 + var_366_0
					end
				end

				arg_363_1.text_.text = var_366_4
				arg_363_1.typewritter.percent = 0

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(false)
				arg_363_1:RecordContent(arg_363_1.text_.text)
			end

			local var_366_8 = math.max(var_366_1, arg_363_1.talkMaxDuration)

			if var_366_0 <= arg_363_1.time_ and arg_363_1.time_ < var_366_0 + var_366_8 then
				arg_363_1.typewritter.percent = (arg_363_1.time_ - var_366_0) / var_366_8

				arg_363_1.typewritter:SetDirty()
			end

			if arg_363_1.time_ >= var_366_0 + var_366_8 and arg_363_1.time_ < var_366_0 + var_366_8 + arg_366_0 then
				arg_363_1.typewritter.percent = 1

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(true)
			end
		end

		arg_363_1.nodeConfigList_ = {}

		arg_363_1:InitPlayNodeList()
	end,
	Play1104902089 = function(arg_367_0, arg_367_1)
		arg_367_1.time_ = 0
		arg_367_1.frameCnt_ = 0
		arg_367_1.state_ = "playing"
		arg_367_1.curTalkId_ = 1104902089
		arg_367_1.duration_ = 2.57

		local var_367_0 = {
			zh = 1.633,
			ja = 2.566
		}
		local var_367_1 = manager.audio:GetLocalizationFlag()

		if var_367_0[var_367_1] ~= nil then
			arg_367_1.duration_ = var_367_0[var_367_1]
		end

		SetActive(arg_367_1.tipsGo_, false)

		function arg_367_1.onSingleLineFinish_()
			arg_367_1.onSingleLineUpdate_ = nil
			arg_367_1.onSingleLineFinish_ = nil
			arg_367_1.state_ = "waiting"
		end

		function arg_367_1.playNext_(arg_369_0)
			if arg_369_0 == 1 then
				arg_367_0:Play1104902090(arg_367_1)
			end
		end

		function arg_367_1.onSingleLineUpdate_(arg_370_0)
			local var_370_0 = arg_367_1.actors_["1049ui_story"]
			local var_370_1 = 0

			if var_370_1 < arg_367_1.time_ and arg_367_1.time_ <= var_370_1 + arg_370_0 and not isNil(var_370_0) and arg_367_1.var_.characterEffect1049ui_story == nil then
				arg_367_1.var_.characterEffect1049ui_story = var_370_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_370_2 = 0.200000002980232

			if var_370_1 <= arg_367_1.time_ and arg_367_1.time_ < var_370_1 + var_370_2 and not isNil(var_370_0) then
				local var_370_3 = (arg_367_1.time_ - var_370_1) / var_370_2

				if arg_367_1.var_.characterEffect1049ui_story and not isNil(var_370_0) then
					arg_367_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_367_1.time_ >= var_370_1 + var_370_2 and arg_367_1.time_ < var_370_1 + var_370_2 + arg_370_0 and not isNil(var_370_0) and arg_367_1.var_.characterEffect1049ui_story then
				arg_367_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_370_4 = 0
			local var_370_5 = 0.05

			if var_370_4 < arg_367_1.time_ and arg_367_1.time_ <= var_370_4 + arg_370_0 then
				arg_367_1.talkMaxDuration = 0
				arg_367_1.dialogCg_.alpha = 1

				arg_367_1.dialog_:SetActive(true)
				SetActive(arg_367_1.leftNameGo_, true)

				local var_370_6 = arg_367_1:FormatText(StoryNameCfg[551].name)

				arg_367_1.leftNameTxt_.text = var_370_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_367_1.leftNameTxt_.transform)

				arg_367_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_367_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_367_1:RecordName(arg_367_1.leftNameTxt_.text)
				SetActive(arg_367_1.iconTrs_.gameObject, false)
				arg_367_1.callingController_:SetSelectedState("normal")

				local var_370_7 = arg_367_1:GetWordFromCfg(1104902089)
				local var_370_8 = arg_367_1:FormatText(var_370_7.content)

				arg_367_1.text_.text = var_370_8

				LuaForUtil.ClearLinePrefixSymbol(arg_367_1.text_)

				local var_370_9 = 2
				local var_370_10 = utf8.len(var_370_8)
				local var_370_11 = var_370_9 <= 0 and var_370_5 or var_370_5 * (var_370_10 / var_370_9)

				if var_370_11 > 0 and var_370_5 < var_370_11 then
					arg_367_1.talkMaxDuration = var_370_11

					if var_370_11 + var_370_4 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_11 + var_370_4
					end
				end

				arg_367_1.text_.text = var_370_8
				arg_367_1.typewritter.percent = 0

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104902", "1104902089", "story_v_side_new_1104902.awb") ~= 0 then
					local var_370_12 = manager.audio:GetVoiceLength("story_v_side_new_1104902", "1104902089", "story_v_side_new_1104902.awb") / 1000

					if var_370_12 + var_370_4 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_12 + var_370_4
					end

					if var_370_7.prefab_name ~= "" and arg_367_1.actors_[var_370_7.prefab_name] ~= nil then
						local var_370_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_367_1.actors_[var_370_7.prefab_name].transform, "story_v_side_new_1104902", "1104902089", "story_v_side_new_1104902.awb")

						arg_367_1:RecordAudio("1104902089", var_370_13)
						arg_367_1:RecordAudio("1104902089", var_370_13)
					else
						arg_367_1:AudioAction("play", "voice", "story_v_side_new_1104902", "1104902089", "story_v_side_new_1104902.awb")
					end

					arg_367_1:RecordHistoryTalkVoice("story_v_side_new_1104902", "1104902089", "story_v_side_new_1104902.awb")
				end

				arg_367_1:RecordContent(arg_367_1.text_.text)
			end

			local var_370_14 = math.max(var_370_5, arg_367_1.talkMaxDuration)

			if var_370_4 <= arg_367_1.time_ and arg_367_1.time_ < var_370_4 + var_370_14 then
				arg_367_1.typewritter.percent = (arg_367_1.time_ - var_370_4) / var_370_14

				arg_367_1.typewritter:SetDirty()
			end

			if arg_367_1.time_ >= var_370_4 + var_370_14 and arg_367_1.time_ < var_370_4 + var_370_14 + arg_370_0 then
				arg_367_1.typewritter.percent = 1

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(true)
			end
		end

		arg_367_1.nodeConfigList_ = {}

		arg_367_1:InitPlayNodeList()
	end,
	Play1104902090 = function(arg_371_0, arg_371_1)
		arg_371_1.time_ = 0
		arg_371_1.frameCnt_ = 0
		arg_371_1.state_ = "playing"
		arg_371_1.curTalkId_ = 1104902090
		arg_371_1.duration_ = 5

		SetActive(arg_371_1.tipsGo_, false)

		function arg_371_1.onSingleLineFinish_()
			arg_371_1.onSingleLineUpdate_ = nil
			arg_371_1.onSingleLineFinish_ = nil
			arg_371_1.state_ = "waiting"
		end

		function arg_371_1.playNext_(arg_373_0)
			if arg_373_0 == 1 then
				arg_371_0:Play1104902091(arg_371_1)
			end
		end

		function arg_371_1.onSingleLineUpdate_(arg_374_0)
			local var_374_0 = arg_371_1.actors_["1049ui_story"]
			local var_374_1 = 0

			if var_374_1 < arg_371_1.time_ and arg_371_1.time_ <= var_374_1 + arg_374_0 and not isNil(var_374_0) and arg_371_1.var_.characterEffect1049ui_story == nil then
				arg_371_1.var_.characterEffect1049ui_story = var_374_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_374_2 = 0.200000002980232

			if var_374_1 <= arg_371_1.time_ and arg_371_1.time_ < var_374_1 + var_374_2 and not isNil(var_374_0) then
				local var_374_3 = (arg_371_1.time_ - var_374_1) / var_374_2

				if arg_371_1.var_.characterEffect1049ui_story and not isNil(var_374_0) then
					local var_374_4 = Mathf.Lerp(0, 0.5, var_374_3)

					arg_371_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_371_1.var_.characterEffect1049ui_story.fillRatio = var_374_4
				end
			end

			if arg_371_1.time_ >= var_374_1 + var_374_2 and arg_371_1.time_ < var_374_1 + var_374_2 + arg_374_0 and not isNil(var_374_0) and arg_371_1.var_.characterEffect1049ui_story then
				local var_374_5 = 0.5

				arg_371_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_371_1.var_.characterEffect1049ui_story.fillRatio = var_374_5
			end

			local var_374_6 = 0
			local var_374_7 = 0.425

			if var_374_6 < arg_371_1.time_ and arg_371_1.time_ <= var_374_6 + arg_374_0 then
				arg_371_1.talkMaxDuration = 0
				arg_371_1.dialogCg_.alpha = 1

				arg_371_1.dialog_:SetActive(true)
				SetActive(arg_371_1.leftNameGo_, true)

				local var_374_8 = arg_371_1:FormatText(StoryNameCfg[7].name)

				arg_371_1.leftNameTxt_.text = var_374_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_371_1.leftNameTxt_.transform)

				arg_371_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_371_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_371_1:RecordName(arg_371_1.leftNameTxt_.text)
				SetActive(arg_371_1.iconTrs_.gameObject, true)
				arg_371_1.iconController_:SetSelectedState("hero")

				arg_371_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_371_1.callingController_:SetSelectedState("normal")

				arg_371_1.keyicon_.color = Color.New(1, 1, 1)
				arg_371_1.icon_.color = Color.New(1, 1, 1)

				local var_374_9 = arg_371_1:GetWordFromCfg(1104902090)
				local var_374_10 = arg_371_1:FormatText(var_374_9.content)

				arg_371_1.text_.text = var_374_10

				LuaForUtil.ClearLinePrefixSymbol(arg_371_1.text_)

				local var_374_11 = 17
				local var_374_12 = utf8.len(var_374_10)
				local var_374_13 = var_374_11 <= 0 and var_374_7 or var_374_7 * (var_374_12 / var_374_11)

				if var_374_13 > 0 and var_374_7 < var_374_13 then
					arg_371_1.talkMaxDuration = var_374_13

					if var_374_13 + var_374_6 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_13 + var_374_6
					end
				end

				arg_371_1.text_.text = var_374_10
				arg_371_1.typewritter.percent = 0

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(false)
				arg_371_1:RecordContent(arg_371_1.text_.text)
			end

			local var_374_14 = math.max(var_374_7, arg_371_1.talkMaxDuration)

			if var_374_6 <= arg_371_1.time_ and arg_371_1.time_ < var_374_6 + var_374_14 then
				arg_371_1.typewritter.percent = (arg_371_1.time_ - var_374_6) / var_374_14

				arg_371_1.typewritter:SetDirty()
			end

			if arg_371_1.time_ >= var_374_6 + var_374_14 and arg_371_1.time_ < var_374_6 + var_374_14 + arg_374_0 then
				arg_371_1.typewritter.percent = 1

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(true)
			end
		end

		arg_371_1.nodeConfigList_ = {}

		arg_371_1:InitPlayNodeList()
	end,
	Play1104902091 = function(arg_375_0, arg_375_1)
		arg_375_1.time_ = 0
		arg_375_1.frameCnt_ = 0
		arg_375_1.state_ = "playing"
		arg_375_1.curTalkId_ = 1104902091
		arg_375_1.duration_ = 5

		SetActive(arg_375_1.tipsGo_, false)

		function arg_375_1.onSingleLineFinish_()
			arg_375_1.onSingleLineUpdate_ = nil
			arg_375_1.onSingleLineFinish_ = nil
			arg_375_1.state_ = "waiting"
		end

		function arg_375_1.playNext_(arg_377_0)
			if arg_377_0 == 1 then
				arg_375_0:Play1104902092(arg_375_1)
			end
		end

		function arg_375_1.onSingleLineUpdate_(arg_378_0)
			local var_378_0 = arg_375_1.actors_["1049ui_story"].transform
			local var_378_1 = 0

			if var_378_1 < arg_375_1.time_ and arg_375_1.time_ <= var_378_1 + arg_378_0 then
				arg_375_1.var_.moveOldPos1049ui_story = var_378_0.localPosition
			end

			local var_378_2 = 0.001

			if var_378_1 <= arg_375_1.time_ and arg_375_1.time_ < var_378_1 + var_378_2 then
				local var_378_3 = (arg_375_1.time_ - var_378_1) / var_378_2
				local var_378_4 = Vector3.New(0, 100, 0)

				var_378_0.localPosition = Vector3.Lerp(arg_375_1.var_.moveOldPos1049ui_story, var_378_4, var_378_3)

				local var_378_5 = manager.ui.mainCamera.transform.position - var_378_0.position

				var_378_0.forward = Vector3.New(var_378_5.x, var_378_5.y, var_378_5.z)

				local var_378_6 = var_378_0.localEulerAngles

				var_378_6.z = 0
				var_378_6.x = 0
				var_378_0.localEulerAngles = var_378_6
			end

			if arg_375_1.time_ >= var_378_1 + var_378_2 and arg_375_1.time_ < var_378_1 + var_378_2 + arg_378_0 then
				var_378_0.localPosition = Vector3.New(0, 100, 0)

				local var_378_7 = manager.ui.mainCamera.transform.position - var_378_0.position

				var_378_0.forward = Vector3.New(var_378_7.x, var_378_7.y, var_378_7.z)

				local var_378_8 = var_378_0.localEulerAngles

				var_378_8.z = 0
				var_378_8.x = 0
				var_378_0.localEulerAngles = var_378_8
			end

			local var_378_9 = arg_375_1.actors_["1049ui_story"]
			local var_378_10 = 0

			if var_378_10 < arg_375_1.time_ and arg_375_1.time_ <= var_378_10 + arg_378_0 and not isNil(var_378_9) and arg_375_1.var_.characterEffect1049ui_story == nil then
				arg_375_1.var_.characterEffect1049ui_story = var_378_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_378_11 = 0.200000002980232

			if var_378_10 <= arg_375_1.time_ and arg_375_1.time_ < var_378_10 + var_378_11 and not isNil(var_378_9) then
				local var_378_12 = (arg_375_1.time_ - var_378_10) / var_378_11

				if arg_375_1.var_.characterEffect1049ui_story and not isNil(var_378_9) then
					local var_378_13 = Mathf.Lerp(0, 0.5, var_378_12)

					arg_375_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_375_1.var_.characterEffect1049ui_story.fillRatio = var_378_13
				end
			end

			if arg_375_1.time_ >= var_378_10 + var_378_11 and arg_375_1.time_ < var_378_10 + var_378_11 + arg_378_0 and not isNil(var_378_9) and arg_375_1.var_.characterEffect1049ui_story then
				local var_378_14 = 0.5

				arg_375_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_375_1.var_.characterEffect1049ui_story.fillRatio = var_378_14
			end

			local var_378_15 = 0
			local var_378_16 = 0.2

			if var_378_15 < arg_375_1.time_ and arg_375_1.time_ <= var_378_15 + arg_378_0 then
				arg_375_1.talkMaxDuration = 0
				arg_375_1.dialogCg_.alpha = 1

				arg_375_1.dialog_:SetActive(true)
				SetActive(arg_375_1.leftNameGo_, false)

				arg_375_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_375_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_375_1:RecordName(arg_375_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_375_1.iconTrs_.gameObject, false)
				arg_375_1.callingController_:SetSelectedState("normal")

				local var_378_17 = arg_375_1:GetWordFromCfg(1104902091)
				local var_378_18 = arg_375_1:FormatText(var_378_17.content)

				arg_375_1.text_.text = var_378_18

				LuaForUtil.ClearLinePrefixSymbol(arg_375_1.text_)

				local var_378_19 = 8
				local var_378_20 = utf8.len(var_378_18)
				local var_378_21 = var_378_19 <= 0 and var_378_16 or var_378_16 * (var_378_20 / var_378_19)

				if var_378_21 > 0 and var_378_16 < var_378_21 then
					arg_375_1.talkMaxDuration = var_378_21

					if var_378_21 + var_378_15 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_21 + var_378_15
					end
				end

				arg_375_1.text_.text = var_378_18
				arg_375_1.typewritter.percent = 0

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(false)
				arg_375_1:RecordContent(arg_375_1.text_.text)
			end

			local var_378_22 = math.max(var_378_16, arg_375_1.talkMaxDuration)

			if var_378_15 <= arg_375_1.time_ and arg_375_1.time_ < var_378_15 + var_378_22 then
				arg_375_1.typewritter.percent = (arg_375_1.time_ - var_378_15) / var_378_22

				arg_375_1.typewritter:SetDirty()
			end

			if arg_375_1.time_ >= var_378_15 + var_378_22 and arg_375_1.time_ < var_378_15 + var_378_22 + arg_378_0 then
				arg_375_1.typewritter.percent = 1

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(true)
			end
		end

		arg_375_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_375_1:InitPlayNodeList()
	end,
	Play1104902092 = function(arg_379_0, arg_379_1)
		arg_379_1.time_ = 0
		arg_379_1.frameCnt_ = 0
		arg_379_1.state_ = "playing"
		arg_379_1.curTalkId_ = 1104902092
		arg_379_1.duration_ = 5

		SetActive(arg_379_1.tipsGo_, false)

		function arg_379_1.onSingleLineFinish_()
			arg_379_1.onSingleLineUpdate_ = nil
			arg_379_1.onSingleLineFinish_ = nil
			arg_379_1.state_ = "waiting"
		end

		function arg_379_1.playNext_(arg_381_0)
			if arg_381_0 == 1 then
				arg_379_0:Play1104902093(arg_379_1)
			end
		end

		function arg_379_1.onSingleLineUpdate_(arg_382_0)
			local var_382_0 = 0
			local var_382_1 = 0.375

			if var_382_0 < arg_379_1.time_ and arg_379_1.time_ <= var_382_0 + arg_382_0 then
				arg_379_1.talkMaxDuration = 0
				arg_379_1.dialogCg_.alpha = 1

				arg_379_1.dialog_:SetActive(true)
				SetActive(arg_379_1.leftNameGo_, true)

				local var_382_2 = arg_379_1:FormatText(StoryNameCfg[7].name)

				arg_379_1.leftNameTxt_.text = var_382_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_379_1.leftNameTxt_.transform)

				arg_379_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_379_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_379_1:RecordName(arg_379_1.leftNameTxt_.text)
				SetActive(arg_379_1.iconTrs_.gameObject, true)
				arg_379_1.iconController_:SetSelectedState("hero")

				arg_379_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_379_1.callingController_:SetSelectedState("normal")

				arg_379_1.keyicon_.color = Color.New(1, 1, 1)
				arg_379_1.icon_.color = Color.New(1, 1, 1)

				local var_382_3 = arg_379_1:GetWordFromCfg(1104902092)
				local var_382_4 = arg_379_1:FormatText(var_382_3.content)

				arg_379_1.text_.text = var_382_4

				LuaForUtil.ClearLinePrefixSymbol(arg_379_1.text_)

				local var_382_5 = 15
				local var_382_6 = utf8.len(var_382_4)
				local var_382_7 = var_382_5 <= 0 and var_382_1 or var_382_1 * (var_382_6 / var_382_5)

				if var_382_7 > 0 and var_382_1 < var_382_7 then
					arg_379_1.talkMaxDuration = var_382_7

					if var_382_7 + var_382_0 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_7 + var_382_0
					end
				end

				arg_379_1.text_.text = var_382_4
				arg_379_1.typewritter.percent = 0

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(false)
				arg_379_1:RecordContent(arg_379_1.text_.text)
			end

			local var_382_8 = math.max(var_382_1, arg_379_1.talkMaxDuration)

			if var_382_0 <= arg_379_1.time_ and arg_379_1.time_ < var_382_0 + var_382_8 then
				arg_379_1.typewritter.percent = (arg_379_1.time_ - var_382_0) / var_382_8

				arg_379_1.typewritter:SetDirty()
			end

			if arg_379_1.time_ >= var_382_0 + var_382_8 and arg_379_1.time_ < var_382_0 + var_382_8 + arg_382_0 then
				arg_379_1.typewritter.percent = 1

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(true)
			end
		end

		arg_379_1.nodeConfigList_ = {}

		arg_379_1:InitPlayNodeList()
	end,
	Play1104902093 = function(arg_383_0, arg_383_1)
		arg_383_1.time_ = 0
		arg_383_1.frameCnt_ = 0
		arg_383_1.state_ = "playing"
		arg_383_1.curTalkId_ = 1104902093
		arg_383_1.duration_ = 1.93

		local var_383_0 = {
			zh = 1.2,
			ja = 1.933
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
				arg_383_0:Play1104902094(arg_383_1)
			end
		end

		function arg_383_1.onSingleLineUpdate_(arg_386_0)
			local var_386_0 = arg_383_1.actors_["1049ui_story"].transform
			local var_386_1 = 0

			if var_386_1 < arg_383_1.time_ and arg_383_1.time_ <= var_386_1 + arg_386_0 then
				arg_383_1.var_.moveOldPos1049ui_story = var_386_0.localPosition
			end

			local var_386_2 = 0.001

			if var_386_1 <= arg_383_1.time_ and arg_383_1.time_ < var_386_1 + var_386_2 then
				local var_386_3 = (arg_383_1.time_ - var_386_1) / var_386_2
				local var_386_4 = Vector3.New(0, -1.2, -6)

				var_386_0.localPosition = Vector3.Lerp(arg_383_1.var_.moveOldPos1049ui_story, var_386_4, var_386_3)

				local var_386_5 = manager.ui.mainCamera.transform.position - var_386_0.position

				var_386_0.forward = Vector3.New(var_386_5.x, var_386_5.y, var_386_5.z)

				local var_386_6 = var_386_0.localEulerAngles

				var_386_6.z = 0
				var_386_6.x = 0
				var_386_0.localEulerAngles = var_386_6
			end

			if arg_383_1.time_ >= var_386_1 + var_386_2 and arg_383_1.time_ < var_386_1 + var_386_2 + arg_386_0 then
				var_386_0.localPosition = Vector3.New(0, -1.2, -6)

				local var_386_7 = manager.ui.mainCamera.transform.position - var_386_0.position

				var_386_0.forward = Vector3.New(var_386_7.x, var_386_7.y, var_386_7.z)

				local var_386_8 = var_386_0.localEulerAngles

				var_386_8.z = 0
				var_386_8.x = 0
				var_386_0.localEulerAngles = var_386_8
			end

			local var_386_9 = arg_383_1.actors_["1049ui_story"]
			local var_386_10 = 0

			if var_386_10 < arg_383_1.time_ and arg_383_1.time_ <= var_386_10 + arg_386_0 and not isNil(var_386_9) and arg_383_1.var_.characterEffect1049ui_story == nil then
				arg_383_1.var_.characterEffect1049ui_story = var_386_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_386_11 = 0.200000002980232

			if var_386_10 <= arg_383_1.time_ and arg_383_1.time_ < var_386_10 + var_386_11 and not isNil(var_386_9) then
				local var_386_12 = (arg_383_1.time_ - var_386_10) / var_386_11

				if arg_383_1.var_.characterEffect1049ui_story and not isNil(var_386_9) then
					arg_383_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_383_1.time_ >= var_386_10 + var_386_11 and arg_383_1.time_ < var_386_10 + var_386_11 + arg_386_0 and not isNil(var_386_9) and arg_383_1.var_.characterEffect1049ui_story then
				arg_383_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_386_13 = 0

			if var_386_13 < arg_383_1.time_ and arg_383_1.time_ <= var_386_13 + arg_386_0 then
				arg_383_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action1_1")
			end

			local var_386_14 = 0

			if var_386_14 < arg_383_1.time_ and arg_383_1.time_ <= var_386_14 + arg_386_0 then
				arg_383_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_386_15 = 0
			local var_386_16 = 0.05

			if var_386_15 < arg_383_1.time_ and arg_383_1.time_ <= var_386_15 + arg_386_0 then
				arg_383_1.talkMaxDuration = 0
				arg_383_1.dialogCg_.alpha = 1

				arg_383_1.dialog_:SetActive(true)
				SetActive(arg_383_1.leftNameGo_, true)

				local var_386_17 = arg_383_1:FormatText(StoryNameCfg[551].name)

				arg_383_1.leftNameTxt_.text = var_386_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_383_1.leftNameTxt_.transform)

				arg_383_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_383_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_383_1:RecordName(arg_383_1.leftNameTxt_.text)
				SetActive(arg_383_1.iconTrs_.gameObject, false)
				arg_383_1.callingController_:SetSelectedState("normal")

				local var_386_18 = arg_383_1:GetWordFromCfg(1104902093)
				local var_386_19 = arg_383_1:FormatText(var_386_18.content)

				arg_383_1.text_.text = var_386_19

				LuaForUtil.ClearLinePrefixSymbol(arg_383_1.text_)

				local var_386_20 = 2
				local var_386_21 = utf8.len(var_386_19)
				local var_386_22 = var_386_20 <= 0 and var_386_16 or var_386_16 * (var_386_21 / var_386_20)

				if var_386_22 > 0 and var_386_16 < var_386_22 then
					arg_383_1.talkMaxDuration = var_386_22

					if var_386_22 + var_386_15 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_22 + var_386_15
					end
				end

				arg_383_1.text_.text = var_386_19
				arg_383_1.typewritter.percent = 0

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104902", "1104902093", "story_v_side_new_1104902.awb") ~= 0 then
					local var_386_23 = manager.audio:GetVoiceLength("story_v_side_new_1104902", "1104902093", "story_v_side_new_1104902.awb") / 1000

					if var_386_23 + var_386_15 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_23 + var_386_15
					end

					if var_386_18.prefab_name ~= "" and arg_383_1.actors_[var_386_18.prefab_name] ~= nil then
						local var_386_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_383_1.actors_[var_386_18.prefab_name].transform, "story_v_side_new_1104902", "1104902093", "story_v_side_new_1104902.awb")

						arg_383_1:RecordAudio("1104902093", var_386_24)
						arg_383_1:RecordAudio("1104902093", var_386_24)
					else
						arg_383_1:AudioAction("play", "voice", "story_v_side_new_1104902", "1104902093", "story_v_side_new_1104902.awb")
					end

					arg_383_1:RecordHistoryTalkVoice("story_v_side_new_1104902", "1104902093", "story_v_side_new_1104902.awb")
				end

				arg_383_1:RecordContent(arg_383_1.text_.text)
			end

			local var_386_25 = math.max(var_386_16, arg_383_1.talkMaxDuration)

			if var_386_15 <= arg_383_1.time_ and arg_383_1.time_ < var_386_15 + var_386_25 then
				arg_383_1.typewritter.percent = (arg_383_1.time_ - var_386_15) / var_386_25

				arg_383_1.typewritter:SetDirty()
			end

			if arg_383_1.time_ >= var_386_15 + var_386_25 and arg_383_1.time_ < var_386_15 + var_386_25 + arg_386_0 then
				arg_383_1.typewritter.percent = 1

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(true)
			end
		end

		arg_383_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_383_1:InitPlayNodeList()
	end,
	Play1104902094 = function(arg_387_0, arg_387_1)
		arg_387_1.time_ = 0
		arg_387_1.frameCnt_ = 0
		arg_387_1.state_ = "playing"
		arg_387_1.curTalkId_ = 1104902094
		arg_387_1.duration_ = 5

		SetActive(arg_387_1.tipsGo_, false)

		function arg_387_1.onSingleLineFinish_()
			arg_387_1.onSingleLineUpdate_ = nil
			arg_387_1.onSingleLineFinish_ = nil
			arg_387_1.state_ = "waiting"
		end

		function arg_387_1.playNext_(arg_389_0)
			if arg_389_0 == 1 then
				arg_387_0:Play1104902095(arg_387_1)
			end
		end

		function arg_387_1.onSingleLineUpdate_(arg_390_0)
			local var_390_0 = arg_387_1.actors_["1049ui_story"]
			local var_390_1 = 0

			if var_390_1 < arg_387_1.time_ and arg_387_1.time_ <= var_390_1 + arg_390_0 and not isNil(var_390_0) and arg_387_1.var_.characterEffect1049ui_story == nil then
				arg_387_1.var_.characterEffect1049ui_story = var_390_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_390_2 = 0.200000002980232

			if var_390_1 <= arg_387_1.time_ and arg_387_1.time_ < var_390_1 + var_390_2 and not isNil(var_390_0) then
				local var_390_3 = (arg_387_1.time_ - var_390_1) / var_390_2

				if arg_387_1.var_.characterEffect1049ui_story and not isNil(var_390_0) then
					local var_390_4 = Mathf.Lerp(0, 0.5, var_390_3)

					arg_387_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_387_1.var_.characterEffect1049ui_story.fillRatio = var_390_4
				end
			end

			if arg_387_1.time_ >= var_390_1 + var_390_2 and arg_387_1.time_ < var_390_1 + var_390_2 + arg_390_0 and not isNil(var_390_0) and arg_387_1.var_.characterEffect1049ui_story then
				local var_390_5 = 0.5

				arg_387_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_387_1.var_.characterEffect1049ui_story.fillRatio = var_390_5
			end

			local var_390_6 = 0
			local var_390_7 = 0.55

			if var_390_6 < arg_387_1.time_ and arg_387_1.time_ <= var_390_6 + arg_390_0 then
				arg_387_1.talkMaxDuration = 0
				arg_387_1.dialogCg_.alpha = 1

				arg_387_1.dialog_:SetActive(true)
				SetActive(arg_387_1.leftNameGo_, true)

				local var_390_8 = arg_387_1:FormatText(StoryNameCfg[7].name)

				arg_387_1.leftNameTxt_.text = var_390_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_387_1.leftNameTxt_.transform)

				arg_387_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_387_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_387_1:RecordName(arg_387_1.leftNameTxt_.text)
				SetActive(arg_387_1.iconTrs_.gameObject, true)
				arg_387_1.iconController_:SetSelectedState("hero")

				arg_387_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_387_1.callingController_:SetSelectedState("normal")

				arg_387_1.keyicon_.color = Color.New(1, 1, 1)
				arg_387_1.icon_.color = Color.New(1, 1, 1)

				local var_390_9 = arg_387_1:GetWordFromCfg(1104902094)
				local var_390_10 = arg_387_1:FormatText(var_390_9.content)

				arg_387_1.text_.text = var_390_10

				LuaForUtil.ClearLinePrefixSymbol(arg_387_1.text_)

				local var_390_11 = 22
				local var_390_12 = utf8.len(var_390_10)
				local var_390_13 = var_390_11 <= 0 and var_390_7 or var_390_7 * (var_390_12 / var_390_11)

				if var_390_13 > 0 and var_390_7 < var_390_13 then
					arg_387_1.talkMaxDuration = var_390_13

					if var_390_13 + var_390_6 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_13 + var_390_6
					end
				end

				arg_387_1.text_.text = var_390_10
				arg_387_1.typewritter.percent = 0

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(false)
				arg_387_1:RecordContent(arg_387_1.text_.text)
			end

			local var_390_14 = math.max(var_390_7, arg_387_1.talkMaxDuration)

			if var_390_6 <= arg_387_1.time_ and arg_387_1.time_ < var_390_6 + var_390_14 then
				arg_387_1.typewritter.percent = (arg_387_1.time_ - var_390_6) / var_390_14

				arg_387_1.typewritter:SetDirty()
			end

			if arg_387_1.time_ >= var_390_6 + var_390_14 and arg_387_1.time_ < var_390_6 + var_390_14 + arg_390_0 then
				arg_387_1.typewritter.percent = 1

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(true)
			end
		end

		arg_387_1.nodeConfigList_ = {}

		arg_387_1:InitPlayNodeList()
	end,
	Play1104902095 = function(arg_391_0, arg_391_1)
		arg_391_1.time_ = 0
		arg_391_1.frameCnt_ = 0
		arg_391_1.state_ = "playing"
		arg_391_1.curTalkId_ = 1104902095
		arg_391_1.duration_ = 2

		SetActive(arg_391_1.tipsGo_, false)

		function arg_391_1.onSingleLineFinish_()
			arg_391_1.onSingleLineUpdate_ = nil
			arg_391_1.onSingleLineFinish_ = nil
			arg_391_1.state_ = "waiting"
		end

		function arg_391_1.playNext_(arg_393_0)
			if arg_393_0 == 1 then
				arg_391_0:Play1104902096(arg_391_1)
			end
		end

		function arg_391_1.onSingleLineUpdate_(arg_394_0)
			local var_394_0 = arg_391_1.actors_["1049ui_story"].transform
			local var_394_1 = 0

			if var_394_1 < arg_391_1.time_ and arg_391_1.time_ <= var_394_1 + arg_394_0 then
				arg_391_1.var_.moveOldPos1049ui_story = var_394_0.localPosition
			end

			local var_394_2 = 0.001

			if var_394_1 <= arg_391_1.time_ and arg_391_1.time_ < var_394_1 + var_394_2 then
				local var_394_3 = (arg_391_1.time_ - var_394_1) / var_394_2
				local var_394_4 = Vector3.New(0, -1.2, -6)

				var_394_0.localPosition = Vector3.Lerp(arg_391_1.var_.moveOldPos1049ui_story, var_394_4, var_394_3)

				local var_394_5 = manager.ui.mainCamera.transform.position - var_394_0.position

				var_394_0.forward = Vector3.New(var_394_5.x, var_394_5.y, var_394_5.z)

				local var_394_6 = var_394_0.localEulerAngles

				var_394_6.z = 0
				var_394_6.x = 0
				var_394_0.localEulerAngles = var_394_6
			end

			if arg_391_1.time_ >= var_394_1 + var_394_2 and arg_391_1.time_ < var_394_1 + var_394_2 + arg_394_0 then
				var_394_0.localPosition = Vector3.New(0, -1.2, -6)

				local var_394_7 = manager.ui.mainCamera.transform.position - var_394_0.position

				var_394_0.forward = Vector3.New(var_394_7.x, var_394_7.y, var_394_7.z)

				local var_394_8 = var_394_0.localEulerAngles

				var_394_8.z = 0
				var_394_8.x = 0
				var_394_0.localEulerAngles = var_394_8
			end

			local var_394_9 = arg_391_1.actors_["1049ui_story"]
			local var_394_10 = 0

			if var_394_10 < arg_391_1.time_ and arg_391_1.time_ <= var_394_10 + arg_394_0 and not isNil(var_394_9) and arg_391_1.var_.characterEffect1049ui_story == nil then
				arg_391_1.var_.characterEffect1049ui_story = var_394_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_394_11 = 0.200000002980232

			if var_394_10 <= arg_391_1.time_ and arg_391_1.time_ < var_394_10 + var_394_11 and not isNil(var_394_9) then
				local var_394_12 = (arg_391_1.time_ - var_394_10) / var_394_11

				if arg_391_1.var_.characterEffect1049ui_story and not isNil(var_394_9) then
					arg_391_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_391_1.time_ >= var_394_10 + var_394_11 and arg_391_1.time_ < var_394_10 + var_394_11 + arg_394_0 and not isNil(var_394_9) and arg_391_1.var_.characterEffect1049ui_story then
				arg_391_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_394_13 = 0

			if var_394_13 < arg_391_1.time_ and arg_391_1.time_ <= var_394_13 + arg_394_0 then
				arg_391_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action2_1")
			end

			local var_394_14 = 0

			if var_394_14 < arg_391_1.time_ and arg_391_1.time_ <= var_394_14 + arg_394_0 then
				arg_391_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_394_15 = 0
			local var_394_16 = 0.075

			if var_394_15 < arg_391_1.time_ and arg_391_1.time_ <= var_394_15 + arg_394_0 then
				arg_391_1.talkMaxDuration = 0
				arg_391_1.dialogCg_.alpha = 1

				arg_391_1.dialog_:SetActive(true)
				SetActive(arg_391_1.leftNameGo_, true)

				local var_394_17 = arg_391_1:FormatText(StoryNameCfg[551].name)

				arg_391_1.leftNameTxt_.text = var_394_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_391_1.leftNameTxt_.transform)

				arg_391_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_391_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_391_1:RecordName(arg_391_1.leftNameTxt_.text)
				SetActive(arg_391_1.iconTrs_.gameObject, false)
				arg_391_1.callingController_:SetSelectedState("normal")

				local var_394_18 = arg_391_1:GetWordFromCfg(1104902095)
				local var_394_19 = arg_391_1:FormatText(var_394_18.content)

				arg_391_1.text_.text = var_394_19

				LuaForUtil.ClearLinePrefixSymbol(arg_391_1.text_)

				local var_394_20 = 3
				local var_394_21 = utf8.len(var_394_19)
				local var_394_22 = var_394_20 <= 0 and var_394_16 or var_394_16 * (var_394_21 / var_394_20)

				if var_394_22 > 0 and var_394_16 < var_394_22 then
					arg_391_1.talkMaxDuration = var_394_22

					if var_394_22 + var_394_15 > arg_391_1.duration_ then
						arg_391_1.duration_ = var_394_22 + var_394_15
					end
				end

				arg_391_1.text_.text = var_394_19
				arg_391_1.typewritter.percent = 0

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104902", "1104902095", "story_v_side_new_1104902.awb") ~= 0 then
					local var_394_23 = manager.audio:GetVoiceLength("story_v_side_new_1104902", "1104902095", "story_v_side_new_1104902.awb") / 1000

					if var_394_23 + var_394_15 > arg_391_1.duration_ then
						arg_391_1.duration_ = var_394_23 + var_394_15
					end

					if var_394_18.prefab_name ~= "" and arg_391_1.actors_[var_394_18.prefab_name] ~= nil then
						local var_394_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_391_1.actors_[var_394_18.prefab_name].transform, "story_v_side_new_1104902", "1104902095", "story_v_side_new_1104902.awb")

						arg_391_1:RecordAudio("1104902095", var_394_24)
						arg_391_1:RecordAudio("1104902095", var_394_24)
					else
						arg_391_1:AudioAction("play", "voice", "story_v_side_new_1104902", "1104902095", "story_v_side_new_1104902.awb")
					end

					arg_391_1:RecordHistoryTalkVoice("story_v_side_new_1104902", "1104902095", "story_v_side_new_1104902.awb")
				end

				arg_391_1:RecordContent(arg_391_1.text_.text)
			end

			local var_394_25 = math.max(var_394_16, arg_391_1.talkMaxDuration)

			if var_394_15 <= arg_391_1.time_ and arg_391_1.time_ < var_394_15 + var_394_25 then
				arg_391_1.typewritter.percent = (arg_391_1.time_ - var_394_15) / var_394_25

				arg_391_1.typewritter:SetDirty()
			end

			if arg_391_1.time_ >= var_394_15 + var_394_25 and arg_391_1.time_ < var_394_15 + var_394_25 + arg_394_0 then
				arg_391_1.typewritter.percent = 1

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(true)
			end
		end

		arg_391_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_391_1:InitPlayNodeList()
	end,
	Play1104902096 = function(arg_395_0, arg_395_1)
		arg_395_1.time_ = 0
		arg_395_1.frameCnt_ = 0
		arg_395_1.state_ = "playing"
		arg_395_1.curTalkId_ = 1104902096
		arg_395_1.duration_ = 9

		SetActive(arg_395_1.tipsGo_, false)

		function arg_395_1.onSingleLineFinish_()
			arg_395_1.onSingleLineUpdate_ = nil
			arg_395_1.onSingleLineFinish_ = nil
			arg_395_1.state_ = "waiting"
		end

		function arg_395_1.playNext_(arg_397_0)
			if arg_397_0 == 1 then
				arg_395_0:Play1104902097(arg_395_1)
			end
		end

		function arg_395_1.onSingleLineUpdate_(arg_398_0)
			local var_398_0 = 2

			if var_398_0 < arg_395_1.time_ and arg_395_1.time_ <= var_398_0 + arg_398_0 then
				local var_398_1 = manager.ui.mainCamera.transform.localPosition
				local var_398_2 = Vector3.New(0, 0, 10) + Vector3.New(var_398_1.x, var_398_1.y, 0)
				local var_398_3 = arg_395_1.bgs_.ST06

				var_398_3.transform.localPosition = var_398_2
				var_398_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_398_4 = var_398_3:GetComponent("SpriteRenderer")

				if var_398_4 and var_398_4.sprite then
					local var_398_5 = (var_398_3.transform.localPosition - var_398_1).z
					local var_398_6 = manager.ui.mainCameraCom_
					local var_398_7 = 2 * var_398_5 * Mathf.Tan(var_398_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_398_8 = var_398_7 * var_398_6.aspect
					local var_398_9 = var_398_4.sprite.bounds.size.x
					local var_398_10 = var_398_4.sprite.bounds.size.y
					local var_398_11 = var_398_8 / var_398_9
					local var_398_12 = var_398_7 / var_398_10
					local var_398_13 = var_398_12 < var_398_11 and var_398_11 or var_398_12

					var_398_3.transform.localScale = Vector3.New(var_398_13, var_398_13, 0)
				end

				for iter_398_0, iter_398_1 in pairs(arg_395_1.bgs_) do
					if iter_398_0 ~= "ST06" then
						iter_398_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_398_14 = 3.999999999999

			if var_398_14 < arg_395_1.time_ and arg_395_1.time_ <= var_398_14 + arg_398_0 then
				arg_395_1.allBtn_.enabled = false
			end

			local var_398_15 = 0.3

			if arg_395_1.time_ >= var_398_14 + var_398_15 and arg_395_1.time_ < var_398_14 + var_398_15 + arg_398_0 then
				arg_395_1.allBtn_.enabled = true
			end

			local var_398_16 = 0

			if var_398_16 < arg_395_1.time_ and arg_395_1.time_ <= var_398_16 + arg_398_0 then
				arg_395_1.mask_.enabled = true
				arg_395_1.mask_.raycastTarget = true

				arg_395_1:SetGaussion(false)
			end

			local var_398_17 = 2

			if var_398_16 <= arg_395_1.time_ and arg_395_1.time_ < var_398_16 + var_398_17 then
				local var_398_18 = (arg_395_1.time_ - var_398_16) / var_398_17
				local var_398_19 = Color.New(0, 0, 0)

				var_398_19.a = Mathf.Lerp(0, 1, var_398_18)
				arg_395_1.mask_.color = var_398_19
			end

			if arg_395_1.time_ >= var_398_16 + var_398_17 and arg_395_1.time_ < var_398_16 + var_398_17 + arg_398_0 then
				local var_398_20 = Color.New(0, 0, 0)

				var_398_20.a = 1
				arg_395_1.mask_.color = var_398_20
			end

			local var_398_21 = 2

			if var_398_21 < arg_395_1.time_ and arg_395_1.time_ <= var_398_21 + arg_398_0 then
				arg_395_1.mask_.enabled = true
				arg_395_1.mask_.raycastTarget = true

				arg_395_1:SetGaussion(false)
			end

			local var_398_22 = 2

			if var_398_21 <= arg_395_1.time_ and arg_395_1.time_ < var_398_21 + var_398_22 then
				local var_398_23 = (arg_395_1.time_ - var_398_21) / var_398_22
				local var_398_24 = Color.New(0, 0, 0)

				var_398_24.a = Mathf.Lerp(1, 0, var_398_23)
				arg_395_1.mask_.color = var_398_24
			end

			if arg_395_1.time_ >= var_398_21 + var_398_22 and arg_395_1.time_ < var_398_21 + var_398_22 + arg_398_0 then
				local var_398_25 = Color.New(0, 0, 0)
				local var_398_26 = 0

				arg_395_1.mask_.enabled = false
				var_398_25.a = var_398_26
				arg_395_1.mask_.color = var_398_25
			end

			local var_398_27 = arg_395_1.actors_["1049ui_story"].transform
			local var_398_28 = 1.96599999815226

			if var_398_28 < arg_395_1.time_ and arg_395_1.time_ <= var_398_28 + arg_398_0 then
				arg_395_1.var_.moveOldPos1049ui_story = var_398_27.localPosition
			end

			local var_398_29 = 0.001

			if var_398_28 <= arg_395_1.time_ and arg_395_1.time_ < var_398_28 + var_398_29 then
				local var_398_30 = (arg_395_1.time_ - var_398_28) / var_398_29
				local var_398_31 = Vector3.New(0, 100, 0)

				var_398_27.localPosition = Vector3.Lerp(arg_395_1.var_.moveOldPos1049ui_story, var_398_31, var_398_30)

				local var_398_32 = manager.ui.mainCamera.transform.position - var_398_27.position

				var_398_27.forward = Vector3.New(var_398_32.x, var_398_32.y, var_398_32.z)

				local var_398_33 = var_398_27.localEulerAngles

				var_398_33.z = 0
				var_398_33.x = 0
				var_398_27.localEulerAngles = var_398_33
			end

			if arg_395_1.time_ >= var_398_28 + var_398_29 and arg_395_1.time_ < var_398_28 + var_398_29 + arg_398_0 then
				var_398_27.localPosition = Vector3.New(0, 100, 0)

				local var_398_34 = manager.ui.mainCamera.transform.position - var_398_27.position

				var_398_27.forward = Vector3.New(var_398_34.x, var_398_34.y, var_398_34.z)

				local var_398_35 = var_398_27.localEulerAngles

				var_398_35.z = 0
				var_398_35.x = 0
				var_398_27.localEulerAngles = var_398_35
			end

			local var_398_36 = arg_395_1.actors_["1049ui_story"]
			local var_398_37 = 1.96599999815226

			if var_398_37 < arg_395_1.time_ and arg_395_1.time_ <= var_398_37 + arg_398_0 and not isNil(var_398_36) and arg_395_1.var_.characterEffect1049ui_story == nil then
				arg_395_1.var_.characterEffect1049ui_story = var_398_36:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_398_38 = 0.034000001847744

			if var_398_37 <= arg_395_1.time_ and arg_395_1.time_ < var_398_37 + var_398_38 and not isNil(var_398_36) then
				local var_398_39 = (arg_395_1.time_ - var_398_37) / var_398_38

				if arg_395_1.var_.characterEffect1049ui_story and not isNil(var_398_36) then
					local var_398_40 = Mathf.Lerp(0, 0.5, var_398_39)

					arg_395_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_395_1.var_.characterEffect1049ui_story.fillRatio = var_398_40
				end
			end

			if arg_395_1.time_ >= var_398_37 + var_398_38 and arg_395_1.time_ < var_398_37 + var_398_38 + arg_398_0 and not isNil(var_398_36) and arg_395_1.var_.characterEffect1049ui_story then
				local var_398_41 = 0.5

				arg_395_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_395_1.var_.characterEffect1049ui_story.fillRatio = var_398_41
			end

			if arg_395_1.frameCnt_ <= 1 then
				arg_395_1.dialog_:SetActive(false)
			end

			local var_398_42 = 4
			local var_398_43 = 0.85

			if var_398_42 < arg_395_1.time_ and arg_395_1.time_ <= var_398_42 + arg_398_0 then
				arg_395_1.talkMaxDuration = 0

				arg_395_1.dialog_:SetActive(true)

				arg_395_1.dialogCg_.alpha = 0

				local var_398_44 = LeanTween.value(arg_395_1.dialog_, 0, 1, 0.3)

				var_398_44:setOnUpdate(LuaHelper.FloatAction(function(arg_399_0)
					arg_395_1.dialogCg_.alpha = arg_399_0
				end))
				var_398_44:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_395_1.dialog_)
					var_398_44:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_395_1.duration_ = arg_395_1.duration_ + 0.3

				SetActive(arg_395_1.leftNameGo_, false)

				arg_395_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_395_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_395_1:RecordName(arg_395_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_395_1.iconTrs_.gameObject, false)
				arg_395_1.callingController_:SetSelectedState("normal")

				local var_398_45 = arg_395_1:GetWordFromCfg(1104902096)
				local var_398_46 = arg_395_1:FormatText(var_398_45.content)

				arg_395_1.text_.text = var_398_46

				LuaForUtil.ClearLinePrefixSymbol(arg_395_1.text_)

				local var_398_47 = 34
				local var_398_48 = utf8.len(var_398_46)
				local var_398_49 = var_398_47 <= 0 and var_398_43 or var_398_43 * (var_398_48 / var_398_47)

				if var_398_49 > 0 and var_398_43 < var_398_49 then
					arg_395_1.talkMaxDuration = var_398_49
					var_398_42 = var_398_42 + 0.3

					if var_398_49 + var_398_42 > arg_395_1.duration_ then
						arg_395_1.duration_ = var_398_49 + var_398_42
					end
				end

				arg_395_1.text_.text = var_398_46
				arg_395_1.typewritter.percent = 0

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(false)
				arg_395_1:RecordContent(arg_395_1.text_.text)
			end

			local var_398_50 = var_398_42 + 0.3
			local var_398_51 = math.max(var_398_43, arg_395_1.talkMaxDuration)

			if var_398_50 <= arg_395_1.time_ and arg_395_1.time_ < var_398_50 + var_398_51 then
				arg_395_1.typewritter.percent = (arg_395_1.time_ - var_398_50) / var_398_51

				arg_395_1.typewritter:SetDirty()
			end

			if arg_395_1.time_ >= var_398_50 + var_398_51 and arg_395_1.time_ < var_398_50 + var_398_51 + arg_398_0 then
				arg_395_1.typewritter.percent = 1

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(true)
			end
		end

		arg_395_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_395_1:InitPlayNodeList()
	end,
	Play1104902097 = function(arg_401_0, arg_401_1)
		arg_401_1.time_ = 0
		arg_401_1.frameCnt_ = 0
		arg_401_1.state_ = "playing"
		arg_401_1.curTalkId_ = 1104902097
		arg_401_1.duration_ = 5

		SetActive(arg_401_1.tipsGo_, false)

		function arg_401_1.onSingleLineFinish_()
			arg_401_1.onSingleLineUpdate_ = nil
			arg_401_1.onSingleLineFinish_ = nil
			arg_401_1.state_ = "waiting"
		end

		function arg_401_1.playNext_(arg_403_0)
			if arg_403_0 == 1 then
				arg_401_0:Play1104902098(arg_401_1)
			end
		end

		function arg_401_1.onSingleLineUpdate_(arg_404_0)
			local var_404_0 = 0
			local var_404_1 = 0.75

			if var_404_0 < arg_401_1.time_ and arg_401_1.time_ <= var_404_0 + arg_404_0 then
				arg_401_1.talkMaxDuration = 0
				arg_401_1.dialogCg_.alpha = 1

				arg_401_1.dialog_:SetActive(true)
				SetActive(arg_401_1.leftNameGo_, false)

				arg_401_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_401_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_401_1:RecordName(arg_401_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_401_1.iconTrs_.gameObject, false)
				arg_401_1.callingController_:SetSelectedState("normal")

				local var_404_2 = arg_401_1:GetWordFromCfg(1104902097)
				local var_404_3 = arg_401_1:FormatText(var_404_2.content)

				arg_401_1.text_.text = var_404_3

				LuaForUtil.ClearLinePrefixSymbol(arg_401_1.text_)

				local var_404_4 = 30
				local var_404_5 = utf8.len(var_404_3)
				local var_404_6 = var_404_4 <= 0 and var_404_1 or var_404_1 * (var_404_5 / var_404_4)

				if var_404_6 > 0 and var_404_1 < var_404_6 then
					arg_401_1.talkMaxDuration = var_404_6

					if var_404_6 + var_404_0 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_6 + var_404_0
					end
				end

				arg_401_1.text_.text = var_404_3
				arg_401_1.typewritter.percent = 0

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(false)
				arg_401_1:RecordContent(arg_401_1.text_.text)
			end

			local var_404_7 = math.max(var_404_1, arg_401_1.talkMaxDuration)

			if var_404_0 <= arg_401_1.time_ and arg_401_1.time_ < var_404_0 + var_404_7 then
				arg_401_1.typewritter.percent = (arg_401_1.time_ - var_404_0) / var_404_7

				arg_401_1.typewritter:SetDirty()
			end

			if arg_401_1.time_ >= var_404_0 + var_404_7 and arg_401_1.time_ < var_404_0 + var_404_7 + arg_404_0 then
				arg_401_1.typewritter.percent = 1

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(true)
			end
		end

		arg_401_1.nodeConfigList_ = {}

		arg_401_1:InitPlayNodeList()
	end,
	Play1104902098 = function(arg_405_0, arg_405_1)
		arg_405_1.time_ = 0
		arg_405_1.frameCnt_ = 0
		arg_405_1.state_ = "playing"
		arg_405_1.curTalkId_ = 1104902098
		arg_405_1.duration_ = 3

		local var_405_0 = {
			zh = 1.333,
			ja = 3
		}
		local var_405_1 = manager.audio:GetLocalizationFlag()

		if var_405_0[var_405_1] ~= nil then
			arg_405_1.duration_ = var_405_0[var_405_1]
		end

		SetActive(arg_405_1.tipsGo_, false)

		function arg_405_1.onSingleLineFinish_()
			arg_405_1.onSingleLineUpdate_ = nil
			arg_405_1.onSingleLineFinish_ = nil
			arg_405_1.state_ = "waiting"
		end

		function arg_405_1.playNext_(arg_407_0)
			if arg_407_0 == 1 then
				arg_405_0:Play1104902099(arg_405_1)
			end
		end

		function arg_405_1.onSingleLineUpdate_(arg_408_0)
			local var_408_0 = 0
			local var_408_1 = 0.05

			if var_408_0 < arg_405_1.time_ and arg_405_1.time_ <= var_408_0 + arg_408_0 then
				arg_405_1.talkMaxDuration = 0
				arg_405_1.dialogCg_.alpha = 1

				arg_405_1.dialog_:SetActive(true)
				SetActive(arg_405_1.leftNameGo_, true)

				local var_408_2 = arg_405_1:FormatText(StoryNameCfg[1008].name)

				arg_405_1.leftNameTxt_.text = var_408_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_405_1.leftNameTxt_.transform)

				arg_405_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_405_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_405_1:RecordName(arg_405_1.leftNameTxt_.text)
				SetActive(arg_405_1.iconTrs_.gameObject, true)
				arg_405_1.iconController_:SetSelectedState("hero")

				arg_405_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10119")

				arg_405_1.callingController_:SetSelectedState("normal")

				arg_405_1.keyicon_.color = Color.New(1, 1, 1)
				arg_405_1.icon_.color = Color.New(1, 1, 1)

				local var_408_3 = arg_405_1:GetWordFromCfg(1104902098)
				local var_408_4 = arg_405_1:FormatText(var_408_3.content)

				arg_405_1.text_.text = var_408_4

				LuaForUtil.ClearLinePrefixSymbol(arg_405_1.text_)

				local var_408_5 = 2
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

				if manager.audio:GetVoiceLength("story_v_side_new_1104902", "1104902098", "story_v_side_new_1104902.awb") ~= 0 then
					local var_408_8 = manager.audio:GetVoiceLength("story_v_side_new_1104902", "1104902098", "story_v_side_new_1104902.awb") / 1000

					if var_408_8 + var_408_0 > arg_405_1.duration_ then
						arg_405_1.duration_ = var_408_8 + var_408_0
					end

					if var_408_3.prefab_name ~= "" and arg_405_1.actors_[var_408_3.prefab_name] ~= nil then
						local var_408_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_405_1.actors_[var_408_3.prefab_name].transform, "story_v_side_new_1104902", "1104902098", "story_v_side_new_1104902.awb")

						arg_405_1:RecordAudio("1104902098", var_408_9)
						arg_405_1:RecordAudio("1104902098", var_408_9)
					else
						arg_405_1:AudioAction("play", "voice", "story_v_side_new_1104902", "1104902098", "story_v_side_new_1104902.awb")
					end

					arg_405_1:RecordHistoryTalkVoice("story_v_side_new_1104902", "1104902098", "story_v_side_new_1104902.awb")
				end

				arg_405_1:RecordContent(arg_405_1.text_.text)
			end

			local var_408_10 = math.max(var_408_1, arg_405_1.talkMaxDuration)

			if var_408_0 <= arg_405_1.time_ and arg_405_1.time_ < var_408_0 + var_408_10 then
				arg_405_1.typewritter.percent = (arg_405_1.time_ - var_408_0) / var_408_10

				arg_405_1.typewritter:SetDirty()
			end

			if arg_405_1.time_ >= var_408_0 + var_408_10 and arg_405_1.time_ < var_408_0 + var_408_10 + arg_408_0 then
				arg_405_1.typewritter.percent = 1

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(true)
			end
		end

		arg_405_1.nodeConfigList_ = {}

		arg_405_1:InitPlayNodeList()
	end,
	Play1104902099 = function(arg_409_0, arg_409_1)
		arg_409_1.time_ = 0
		arg_409_1.frameCnt_ = 0
		arg_409_1.state_ = "playing"
		arg_409_1.curTalkId_ = 1104902099
		arg_409_1.duration_ = 3.53

		local var_409_0 = {
			zh = 2.566,
			ja = 3.533
		}
		local var_409_1 = manager.audio:GetLocalizationFlag()

		if var_409_0[var_409_1] ~= nil then
			arg_409_1.duration_ = var_409_0[var_409_1]
		end

		SetActive(arg_409_1.tipsGo_, false)

		function arg_409_1.onSingleLineFinish_()
			arg_409_1.onSingleLineUpdate_ = nil
			arg_409_1.onSingleLineFinish_ = nil
			arg_409_1.state_ = "waiting"
		end

		function arg_409_1.playNext_(arg_411_0)
			if arg_411_0 == 1 then
				arg_409_0:Play1104902100(arg_409_1)
			end
		end

		function arg_409_1.onSingleLineUpdate_(arg_412_0)
			local var_412_0 = arg_409_1.actors_["1049ui_story"].transform
			local var_412_1 = 0

			if var_412_1 < arg_409_1.time_ and arg_409_1.time_ <= var_412_1 + arg_412_0 then
				arg_409_1.var_.moveOldPos1049ui_story = var_412_0.localPosition
			end

			local var_412_2 = 0.001

			if var_412_1 <= arg_409_1.time_ and arg_409_1.time_ < var_412_1 + var_412_2 then
				local var_412_3 = (arg_409_1.time_ - var_412_1) / var_412_2
				local var_412_4 = Vector3.New(0, -1.2, -6)

				var_412_0.localPosition = Vector3.Lerp(arg_409_1.var_.moveOldPos1049ui_story, var_412_4, var_412_3)

				local var_412_5 = manager.ui.mainCamera.transform.position - var_412_0.position

				var_412_0.forward = Vector3.New(var_412_5.x, var_412_5.y, var_412_5.z)

				local var_412_6 = var_412_0.localEulerAngles

				var_412_6.z = 0
				var_412_6.x = 0
				var_412_0.localEulerAngles = var_412_6
			end

			if arg_409_1.time_ >= var_412_1 + var_412_2 and arg_409_1.time_ < var_412_1 + var_412_2 + arg_412_0 then
				var_412_0.localPosition = Vector3.New(0, -1.2, -6)

				local var_412_7 = manager.ui.mainCamera.transform.position - var_412_0.position

				var_412_0.forward = Vector3.New(var_412_7.x, var_412_7.y, var_412_7.z)

				local var_412_8 = var_412_0.localEulerAngles

				var_412_8.z = 0
				var_412_8.x = 0
				var_412_0.localEulerAngles = var_412_8
			end

			local var_412_9 = arg_409_1.actors_["1049ui_story"]
			local var_412_10 = 0

			if var_412_10 < arg_409_1.time_ and arg_409_1.time_ <= var_412_10 + arg_412_0 and not isNil(var_412_9) and arg_409_1.var_.characterEffect1049ui_story == nil then
				arg_409_1.var_.characterEffect1049ui_story = var_412_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_412_11 = 0.200000002980232

			if var_412_10 <= arg_409_1.time_ and arg_409_1.time_ < var_412_10 + var_412_11 and not isNil(var_412_9) then
				local var_412_12 = (arg_409_1.time_ - var_412_10) / var_412_11

				if arg_409_1.var_.characterEffect1049ui_story and not isNil(var_412_9) then
					arg_409_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_409_1.time_ >= var_412_10 + var_412_11 and arg_409_1.time_ < var_412_10 + var_412_11 + arg_412_0 and not isNil(var_412_9) and arg_409_1.var_.characterEffect1049ui_story then
				arg_409_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_412_13 = 0

			if var_412_13 < arg_409_1.time_ and arg_409_1.time_ <= var_412_13 + arg_412_0 then
				arg_409_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action1_1")
			end

			local var_412_14 = 0

			if var_412_14 < arg_409_1.time_ and arg_409_1.time_ <= var_412_14 + arg_412_0 then
				arg_409_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_412_15 = 0
			local var_412_16 = 0.3

			if var_412_15 < arg_409_1.time_ and arg_409_1.time_ <= var_412_15 + arg_412_0 then
				arg_409_1.talkMaxDuration = 0
				arg_409_1.dialogCg_.alpha = 1

				arg_409_1.dialog_:SetActive(true)
				SetActive(arg_409_1.leftNameGo_, true)

				local var_412_17 = arg_409_1:FormatText(StoryNameCfg[551].name)

				arg_409_1.leftNameTxt_.text = var_412_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_409_1.leftNameTxt_.transform)

				arg_409_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_409_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_409_1:RecordName(arg_409_1.leftNameTxt_.text)
				SetActive(arg_409_1.iconTrs_.gameObject, false)
				arg_409_1.callingController_:SetSelectedState("normal")

				local var_412_18 = arg_409_1:GetWordFromCfg(1104902099)
				local var_412_19 = arg_409_1:FormatText(var_412_18.content)

				arg_409_1.text_.text = var_412_19

				LuaForUtil.ClearLinePrefixSymbol(arg_409_1.text_)

				local var_412_20 = 12
				local var_412_21 = utf8.len(var_412_19)
				local var_412_22 = var_412_20 <= 0 and var_412_16 or var_412_16 * (var_412_21 / var_412_20)

				if var_412_22 > 0 and var_412_16 < var_412_22 then
					arg_409_1.talkMaxDuration = var_412_22

					if var_412_22 + var_412_15 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_22 + var_412_15
					end
				end

				arg_409_1.text_.text = var_412_19
				arg_409_1.typewritter.percent = 0

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104902", "1104902099", "story_v_side_new_1104902.awb") ~= 0 then
					local var_412_23 = manager.audio:GetVoiceLength("story_v_side_new_1104902", "1104902099", "story_v_side_new_1104902.awb") / 1000

					if var_412_23 + var_412_15 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_23 + var_412_15
					end

					if var_412_18.prefab_name ~= "" and arg_409_1.actors_[var_412_18.prefab_name] ~= nil then
						local var_412_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_409_1.actors_[var_412_18.prefab_name].transform, "story_v_side_new_1104902", "1104902099", "story_v_side_new_1104902.awb")

						arg_409_1:RecordAudio("1104902099", var_412_24)
						arg_409_1:RecordAudio("1104902099", var_412_24)
					else
						arg_409_1:AudioAction("play", "voice", "story_v_side_new_1104902", "1104902099", "story_v_side_new_1104902.awb")
					end

					arg_409_1:RecordHistoryTalkVoice("story_v_side_new_1104902", "1104902099", "story_v_side_new_1104902.awb")
				end

				arg_409_1:RecordContent(arg_409_1.text_.text)
			end

			local var_412_25 = math.max(var_412_16, arg_409_1.talkMaxDuration)

			if var_412_15 <= arg_409_1.time_ and arg_409_1.time_ < var_412_15 + var_412_25 then
				arg_409_1.typewritter.percent = (arg_409_1.time_ - var_412_15) / var_412_25

				arg_409_1.typewritter:SetDirty()
			end

			if arg_409_1.time_ >= var_412_15 + var_412_25 and arg_409_1.time_ < var_412_15 + var_412_25 + arg_412_0 then
				arg_409_1.typewritter.percent = 1

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(true)
			end
		end

		arg_409_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
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
	Play1104902100 = function(arg_413_0, arg_413_1)
		arg_413_1.time_ = 0
		arg_413_1.frameCnt_ = 0
		arg_413_1.state_ = "playing"
		arg_413_1.curTalkId_ = 1104902100
		arg_413_1.duration_ = 5

		SetActive(arg_413_1.tipsGo_, false)

		function arg_413_1.onSingleLineFinish_()
			arg_413_1.onSingleLineUpdate_ = nil
			arg_413_1.onSingleLineFinish_ = nil
			arg_413_1.state_ = "waiting"
		end

		function arg_413_1.playNext_(arg_415_0)
			if arg_415_0 == 1 then
				arg_413_0:Play1104902101(arg_413_1)
			end
		end

		function arg_413_1.onSingleLineUpdate_(arg_416_0)
			local var_416_0 = arg_413_1.actors_["1049ui_story"]
			local var_416_1 = 0

			if var_416_1 < arg_413_1.time_ and arg_413_1.time_ <= var_416_1 + arg_416_0 and not isNil(var_416_0) and arg_413_1.var_.characterEffect1049ui_story == nil then
				arg_413_1.var_.characterEffect1049ui_story = var_416_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_416_2 = 0.200000002980232

			if var_416_1 <= arg_413_1.time_ and arg_413_1.time_ < var_416_1 + var_416_2 and not isNil(var_416_0) then
				local var_416_3 = (arg_413_1.time_ - var_416_1) / var_416_2

				if arg_413_1.var_.characterEffect1049ui_story and not isNil(var_416_0) then
					local var_416_4 = Mathf.Lerp(0, 0.5, var_416_3)

					arg_413_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_413_1.var_.characterEffect1049ui_story.fillRatio = var_416_4
				end
			end

			if arg_413_1.time_ >= var_416_1 + var_416_2 and arg_413_1.time_ < var_416_1 + var_416_2 + arg_416_0 and not isNil(var_416_0) and arg_413_1.var_.characterEffect1049ui_story then
				local var_416_5 = 0.5

				arg_413_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_413_1.var_.characterEffect1049ui_story.fillRatio = var_416_5
			end

			local var_416_6 = 0
			local var_416_7 = 0.675

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

				local var_416_8 = arg_413_1:GetWordFromCfg(1104902100)
				local var_416_9 = arg_413_1:FormatText(var_416_8.content)

				arg_413_1.text_.text = var_416_9

				LuaForUtil.ClearLinePrefixSymbol(arg_413_1.text_)

				local var_416_10 = 27
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
	Play1104902101 = function(arg_417_0, arg_417_1)
		arg_417_1.time_ = 0
		arg_417_1.frameCnt_ = 0
		arg_417_1.state_ = "playing"
		arg_417_1.curTalkId_ = 1104902101
		arg_417_1.duration_ = 4.9

		local var_417_0 = {
			zh = 2.966,
			ja = 4.9
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
		end

		function arg_417_1.playNext_(arg_419_0)
			if arg_419_0 == 1 then
				arg_417_0:Play1104902102(arg_417_1)
			end
		end

		function arg_417_1.onSingleLineUpdate_(arg_420_0)
			local var_420_0 = arg_417_1.actors_["1049ui_story"].transform
			local var_420_1 = 0

			if var_420_1 < arg_417_1.time_ and arg_417_1.time_ <= var_420_1 + arg_420_0 then
				arg_417_1.var_.moveOldPos1049ui_story = var_420_0.localPosition
			end

			local var_420_2 = 0.001

			if var_420_1 <= arg_417_1.time_ and arg_417_1.time_ < var_420_1 + var_420_2 then
				local var_420_3 = (arg_417_1.time_ - var_420_1) / var_420_2
				local var_420_4 = Vector3.New(0, -1.2, -6)

				var_420_0.localPosition = Vector3.Lerp(arg_417_1.var_.moveOldPos1049ui_story, var_420_4, var_420_3)

				local var_420_5 = manager.ui.mainCamera.transform.position - var_420_0.position

				var_420_0.forward = Vector3.New(var_420_5.x, var_420_5.y, var_420_5.z)

				local var_420_6 = var_420_0.localEulerAngles

				var_420_6.z = 0
				var_420_6.x = 0
				var_420_0.localEulerAngles = var_420_6
			end

			if arg_417_1.time_ >= var_420_1 + var_420_2 and arg_417_1.time_ < var_420_1 + var_420_2 + arg_420_0 then
				var_420_0.localPosition = Vector3.New(0, -1.2, -6)

				local var_420_7 = manager.ui.mainCamera.transform.position - var_420_0.position

				var_420_0.forward = Vector3.New(var_420_7.x, var_420_7.y, var_420_7.z)

				local var_420_8 = var_420_0.localEulerAngles

				var_420_8.z = 0
				var_420_8.x = 0
				var_420_0.localEulerAngles = var_420_8
			end

			local var_420_9 = arg_417_1.actors_["1049ui_story"]
			local var_420_10 = 0

			if var_420_10 < arg_417_1.time_ and arg_417_1.time_ <= var_420_10 + arg_420_0 and not isNil(var_420_9) and arg_417_1.var_.characterEffect1049ui_story == nil then
				arg_417_1.var_.characterEffect1049ui_story = var_420_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_420_11 = 0.200000002980232

			if var_420_10 <= arg_417_1.time_ and arg_417_1.time_ < var_420_10 + var_420_11 and not isNil(var_420_9) then
				local var_420_12 = (arg_417_1.time_ - var_420_10) / var_420_11

				if arg_417_1.var_.characterEffect1049ui_story and not isNil(var_420_9) then
					arg_417_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_417_1.time_ >= var_420_10 + var_420_11 and arg_417_1.time_ < var_420_10 + var_420_11 + arg_420_0 and not isNil(var_420_9) and arg_417_1.var_.characterEffect1049ui_story then
				arg_417_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_420_13 = 0

			if var_420_13 < arg_417_1.time_ and arg_417_1.time_ <= var_420_13 + arg_420_0 then
				arg_417_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_420_14 = 0
			local var_420_15 = 0.3

			if var_420_14 < arg_417_1.time_ and arg_417_1.time_ <= var_420_14 + arg_420_0 then
				arg_417_1.talkMaxDuration = 0
				arg_417_1.dialogCg_.alpha = 1

				arg_417_1.dialog_:SetActive(true)
				SetActive(arg_417_1.leftNameGo_, true)

				local var_420_16 = arg_417_1:FormatText(StoryNameCfg[551].name)

				arg_417_1.leftNameTxt_.text = var_420_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_417_1.leftNameTxt_.transform)

				arg_417_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_417_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_417_1:RecordName(arg_417_1.leftNameTxt_.text)
				SetActive(arg_417_1.iconTrs_.gameObject, false)
				arg_417_1.callingController_:SetSelectedState("normal")

				local var_420_17 = arg_417_1:GetWordFromCfg(1104902101)
				local var_420_18 = arg_417_1:FormatText(var_420_17.content)

				arg_417_1.text_.text = var_420_18

				LuaForUtil.ClearLinePrefixSymbol(arg_417_1.text_)

				local var_420_19 = 12
				local var_420_20 = utf8.len(var_420_18)
				local var_420_21 = var_420_19 <= 0 and var_420_15 or var_420_15 * (var_420_20 / var_420_19)

				if var_420_21 > 0 and var_420_15 < var_420_21 then
					arg_417_1.talkMaxDuration = var_420_21

					if var_420_21 + var_420_14 > arg_417_1.duration_ then
						arg_417_1.duration_ = var_420_21 + var_420_14
					end
				end

				arg_417_1.text_.text = var_420_18
				arg_417_1.typewritter.percent = 0

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104902", "1104902101", "story_v_side_new_1104902.awb") ~= 0 then
					local var_420_22 = manager.audio:GetVoiceLength("story_v_side_new_1104902", "1104902101", "story_v_side_new_1104902.awb") / 1000

					if var_420_22 + var_420_14 > arg_417_1.duration_ then
						arg_417_1.duration_ = var_420_22 + var_420_14
					end

					if var_420_17.prefab_name ~= "" and arg_417_1.actors_[var_420_17.prefab_name] ~= nil then
						local var_420_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_417_1.actors_[var_420_17.prefab_name].transform, "story_v_side_new_1104902", "1104902101", "story_v_side_new_1104902.awb")

						arg_417_1:RecordAudio("1104902101", var_420_23)
						arg_417_1:RecordAudio("1104902101", var_420_23)
					else
						arg_417_1:AudioAction("play", "voice", "story_v_side_new_1104902", "1104902101", "story_v_side_new_1104902.awb")
					end

					arg_417_1:RecordHistoryTalkVoice("story_v_side_new_1104902", "1104902101", "story_v_side_new_1104902.awb")
				end

				arg_417_1:RecordContent(arg_417_1.text_.text)
			end

			local var_420_24 = math.max(var_420_15, arg_417_1.talkMaxDuration)

			if var_420_14 <= arg_417_1.time_ and arg_417_1.time_ < var_420_14 + var_420_24 then
				arg_417_1.typewritter.percent = (arg_417_1.time_ - var_420_14) / var_420_24

				arg_417_1.typewritter:SetDirty()
			end

			if arg_417_1.time_ >= var_420_14 + var_420_24 and arg_417_1.time_ < var_420_14 + var_420_24 + arg_420_0 then
				arg_417_1.typewritter.percent = 1

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(true)
			end
		end

		arg_417_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_417_1:InitPlayNodeList()
	end,
	Play1104902102 = function(arg_421_0, arg_421_1)
		arg_421_1.time_ = 0
		arg_421_1.frameCnt_ = 0
		arg_421_1.state_ = "playing"
		arg_421_1.curTalkId_ = 1104902102
		arg_421_1.duration_ = 5

		SetActive(arg_421_1.tipsGo_, false)

		function arg_421_1.onSingleLineFinish_()
			arg_421_1.onSingleLineUpdate_ = nil
			arg_421_1.onSingleLineFinish_ = nil
			arg_421_1.state_ = "waiting"
		end

		function arg_421_1.playNext_(arg_423_0)
			if arg_423_0 == 1 then
				arg_421_0:Play1104902103(arg_421_1)
			end
		end

		function arg_421_1.onSingleLineUpdate_(arg_424_0)
			local var_424_0 = arg_421_1.actors_["1049ui_story"].transform
			local var_424_1 = 0

			if var_424_1 < arg_421_1.time_ and arg_421_1.time_ <= var_424_1 + arg_424_0 then
				arg_421_1.var_.moveOldPos1049ui_story = var_424_0.localPosition
			end

			local var_424_2 = 0.001

			if var_424_1 <= arg_421_1.time_ and arg_421_1.time_ < var_424_1 + var_424_2 then
				local var_424_3 = (arg_421_1.time_ - var_424_1) / var_424_2
				local var_424_4 = Vector3.New(0, 100, 0)

				var_424_0.localPosition = Vector3.Lerp(arg_421_1.var_.moveOldPos1049ui_story, var_424_4, var_424_3)

				local var_424_5 = manager.ui.mainCamera.transform.position - var_424_0.position

				var_424_0.forward = Vector3.New(var_424_5.x, var_424_5.y, var_424_5.z)

				local var_424_6 = var_424_0.localEulerAngles

				var_424_6.z = 0
				var_424_6.x = 0
				var_424_0.localEulerAngles = var_424_6
			end

			if arg_421_1.time_ >= var_424_1 + var_424_2 and arg_421_1.time_ < var_424_1 + var_424_2 + arg_424_0 then
				var_424_0.localPosition = Vector3.New(0, 100, 0)

				local var_424_7 = manager.ui.mainCamera.transform.position - var_424_0.position

				var_424_0.forward = Vector3.New(var_424_7.x, var_424_7.y, var_424_7.z)

				local var_424_8 = var_424_0.localEulerAngles

				var_424_8.z = 0
				var_424_8.x = 0
				var_424_0.localEulerAngles = var_424_8
			end

			local var_424_9 = arg_421_1.actors_["1049ui_story"]
			local var_424_10 = 0

			if var_424_10 < arg_421_1.time_ and arg_421_1.time_ <= var_424_10 + arg_424_0 and not isNil(var_424_9) and arg_421_1.var_.characterEffect1049ui_story == nil then
				arg_421_1.var_.characterEffect1049ui_story = var_424_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_424_11 = 0.200000002980232

			if var_424_10 <= arg_421_1.time_ and arg_421_1.time_ < var_424_10 + var_424_11 and not isNil(var_424_9) then
				local var_424_12 = (arg_421_1.time_ - var_424_10) / var_424_11

				if arg_421_1.var_.characterEffect1049ui_story and not isNil(var_424_9) then
					local var_424_13 = Mathf.Lerp(0, 0.5, var_424_12)

					arg_421_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_421_1.var_.characterEffect1049ui_story.fillRatio = var_424_13
				end
			end

			if arg_421_1.time_ >= var_424_10 + var_424_11 and arg_421_1.time_ < var_424_10 + var_424_11 + arg_424_0 and not isNil(var_424_9) and arg_421_1.var_.characterEffect1049ui_story then
				local var_424_14 = 0.5

				arg_421_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_421_1.var_.characterEffect1049ui_story.fillRatio = var_424_14
			end

			local var_424_15 = 0
			local var_424_16 = 0.875

			if var_424_15 < arg_421_1.time_ and arg_421_1.time_ <= var_424_15 + arg_424_0 then
				arg_421_1.talkMaxDuration = 0
				arg_421_1.dialogCg_.alpha = 1

				arg_421_1.dialog_:SetActive(true)
				SetActive(arg_421_1.leftNameGo_, false)

				arg_421_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_421_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_421_1:RecordName(arg_421_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_421_1.iconTrs_.gameObject, false)
				arg_421_1.callingController_:SetSelectedState("normal")

				local var_424_17 = arg_421_1:GetWordFromCfg(1104902102)
				local var_424_18 = arg_421_1:FormatText(var_424_17.content)

				arg_421_1.text_.text = var_424_18

				LuaForUtil.ClearLinePrefixSymbol(arg_421_1.text_)

				local var_424_19 = 35
				local var_424_20 = utf8.len(var_424_18)
				local var_424_21 = var_424_19 <= 0 and var_424_16 or var_424_16 * (var_424_20 / var_424_19)

				if var_424_21 > 0 and var_424_16 < var_424_21 then
					arg_421_1.talkMaxDuration = var_424_21

					if var_424_21 + var_424_15 > arg_421_1.duration_ then
						arg_421_1.duration_ = var_424_21 + var_424_15
					end
				end

				arg_421_1.text_.text = var_424_18
				arg_421_1.typewritter.percent = 0

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(false)
				arg_421_1:RecordContent(arg_421_1.text_.text)
			end

			local var_424_22 = math.max(var_424_16, arg_421_1.talkMaxDuration)

			if var_424_15 <= arg_421_1.time_ and arg_421_1.time_ < var_424_15 + var_424_22 then
				arg_421_1.typewritter.percent = (arg_421_1.time_ - var_424_15) / var_424_22

				arg_421_1.typewritter:SetDirty()
			end

			if arg_421_1.time_ >= var_424_15 + var_424_22 and arg_421_1.time_ < var_424_15 + var_424_22 + arg_424_0 then
				arg_421_1.typewritter.percent = 1

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(true)
			end
		end

		arg_421_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
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
	Play1104902103 = function(arg_425_0, arg_425_1)
		arg_425_1.time_ = 0
		arg_425_1.frameCnt_ = 0
		arg_425_1.state_ = "playing"
		arg_425_1.curTalkId_ = 1104902103
		arg_425_1.duration_ = 3.43

		local var_425_0 = {
			zh = 3.433,
			ja = 2.8
		}
		local var_425_1 = manager.audio:GetLocalizationFlag()

		if var_425_0[var_425_1] ~= nil then
			arg_425_1.duration_ = var_425_0[var_425_1]
		end

		SetActive(arg_425_1.tipsGo_, false)

		function arg_425_1.onSingleLineFinish_()
			arg_425_1.onSingleLineUpdate_ = nil
			arg_425_1.onSingleLineFinish_ = nil
			arg_425_1.state_ = "waiting"
		end

		function arg_425_1.playNext_(arg_427_0)
			if arg_427_0 == 1 then
				arg_425_0:Play1104902104(arg_425_1)
			end
		end

		function arg_425_1.onSingleLineUpdate_(arg_428_0)
			local var_428_0 = arg_425_1.actors_["1049ui_story"].transform
			local var_428_1 = 0

			if var_428_1 < arg_425_1.time_ and arg_425_1.time_ <= var_428_1 + arg_428_0 then
				arg_425_1.var_.moveOldPos1049ui_story = var_428_0.localPosition
			end

			local var_428_2 = 0.001

			if var_428_1 <= arg_425_1.time_ and arg_425_1.time_ < var_428_1 + var_428_2 then
				local var_428_3 = (arg_425_1.time_ - var_428_1) / var_428_2
				local var_428_4 = Vector3.New(0, -1.2, -6)

				var_428_0.localPosition = Vector3.Lerp(arg_425_1.var_.moveOldPos1049ui_story, var_428_4, var_428_3)

				local var_428_5 = manager.ui.mainCamera.transform.position - var_428_0.position

				var_428_0.forward = Vector3.New(var_428_5.x, var_428_5.y, var_428_5.z)

				local var_428_6 = var_428_0.localEulerAngles

				var_428_6.z = 0
				var_428_6.x = 0
				var_428_0.localEulerAngles = var_428_6
			end

			if arg_425_1.time_ >= var_428_1 + var_428_2 and arg_425_1.time_ < var_428_1 + var_428_2 + arg_428_0 then
				var_428_0.localPosition = Vector3.New(0, -1.2, -6)

				local var_428_7 = manager.ui.mainCamera.transform.position - var_428_0.position

				var_428_0.forward = Vector3.New(var_428_7.x, var_428_7.y, var_428_7.z)

				local var_428_8 = var_428_0.localEulerAngles

				var_428_8.z = 0
				var_428_8.x = 0
				var_428_0.localEulerAngles = var_428_8
			end

			local var_428_9 = arg_425_1.actors_["1049ui_story"]
			local var_428_10 = 0

			if var_428_10 < arg_425_1.time_ and arg_425_1.time_ <= var_428_10 + arg_428_0 and not isNil(var_428_9) and arg_425_1.var_.characterEffect1049ui_story == nil then
				arg_425_1.var_.characterEffect1049ui_story = var_428_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_428_11 = 0.200000002980232

			if var_428_10 <= arg_425_1.time_ and arg_425_1.time_ < var_428_10 + var_428_11 and not isNil(var_428_9) then
				local var_428_12 = (arg_425_1.time_ - var_428_10) / var_428_11

				if arg_425_1.var_.characterEffect1049ui_story and not isNil(var_428_9) then
					arg_425_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_425_1.time_ >= var_428_10 + var_428_11 and arg_425_1.time_ < var_428_10 + var_428_11 + arg_428_0 and not isNil(var_428_9) and arg_425_1.var_.characterEffect1049ui_story then
				arg_425_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_428_13 = 0

			if var_428_13 < arg_425_1.time_ and arg_425_1.time_ <= var_428_13 + arg_428_0 then
				arg_425_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action1_1")
			end

			local var_428_14 = 0

			if var_428_14 < arg_425_1.time_ and arg_425_1.time_ <= var_428_14 + arg_428_0 then
				arg_425_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_428_15 = 0
			local var_428_16 = 0.3

			if var_428_15 < arg_425_1.time_ and arg_425_1.time_ <= var_428_15 + arg_428_0 then
				arg_425_1.talkMaxDuration = 0
				arg_425_1.dialogCg_.alpha = 1

				arg_425_1.dialog_:SetActive(true)
				SetActive(arg_425_1.leftNameGo_, true)

				local var_428_17 = arg_425_1:FormatText(StoryNameCfg[551].name)

				arg_425_1.leftNameTxt_.text = var_428_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_425_1.leftNameTxt_.transform)

				arg_425_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_425_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_425_1:RecordName(arg_425_1.leftNameTxt_.text)
				SetActive(arg_425_1.iconTrs_.gameObject, false)
				arg_425_1.callingController_:SetSelectedState("normal")

				local var_428_18 = arg_425_1:GetWordFromCfg(1104902103)
				local var_428_19 = arg_425_1:FormatText(var_428_18.content)

				arg_425_1.text_.text = var_428_19

				LuaForUtil.ClearLinePrefixSymbol(arg_425_1.text_)

				local var_428_20 = 12
				local var_428_21 = utf8.len(var_428_19)
				local var_428_22 = var_428_20 <= 0 and var_428_16 or var_428_16 * (var_428_21 / var_428_20)

				if var_428_22 > 0 and var_428_16 < var_428_22 then
					arg_425_1.talkMaxDuration = var_428_22

					if var_428_22 + var_428_15 > arg_425_1.duration_ then
						arg_425_1.duration_ = var_428_22 + var_428_15
					end
				end

				arg_425_1.text_.text = var_428_19
				arg_425_1.typewritter.percent = 0

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104902", "1104902103", "story_v_side_new_1104902.awb") ~= 0 then
					local var_428_23 = manager.audio:GetVoiceLength("story_v_side_new_1104902", "1104902103", "story_v_side_new_1104902.awb") / 1000

					if var_428_23 + var_428_15 > arg_425_1.duration_ then
						arg_425_1.duration_ = var_428_23 + var_428_15
					end

					if var_428_18.prefab_name ~= "" and arg_425_1.actors_[var_428_18.prefab_name] ~= nil then
						local var_428_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_425_1.actors_[var_428_18.prefab_name].transform, "story_v_side_new_1104902", "1104902103", "story_v_side_new_1104902.awb")

						arg_425_1:RecordAudio("1104902103", var_428_24)
						arg_425_1:RecordAudio("1104902103", var_428_24)
					else
						arg_425_1:AudioAction("play", "voice", "story_v_side_new_1104902", "1104902103", "story_v_side_new_1104902.awb")
					end

					arg_425_1:RecordHistoryTalkVoice("story_v_side_new_1104902", "1104902103", "story_v_side_new_1104902.awb")
				end

				arg_425_1:RecordContent(arg_425_1.text_.text)
			end

			local var_428_25 = math.max(var_428_16, arg_425_1.talkMaxDuration)

			if var_428_15 <= arg_425_1.time_ and arg_425_1.time_ < var_428_15 + var_428_25 then
				arg_425_1.typewritter.percent = (arg_425_1.time_ - var_428_15) / var_428_25

				arg_425_1.typewritter:SetDirty()
			end

			if arg_425_1.time_ >= var_428_15 + var_428_25 and arg_425_1.time_ < var_428_15 + var_428_25 + arg_428_0 then
				arg_425_1.typewritter.percent = 1

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(true)
			end
		end

		arg_425_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_425_1:InitPlayNodeList()
	end,
	Play1104902104 = function(arg_429_0, arg_429_1)
		arg_429_1.time_ = 0
		arg_429_1.frameCnt_ = 0
		arg_429_1.state_ = "playing"
		arg_429_1.curTalkId_ = 1104902104
		arg_429_1.duration_ = 5

		SetActive(arg_429_1.tipsGo_, false)

		function arg_429_1.onSingleLineFinish_()
			arg_429_1.onSingleLineUpdate_ = nil
			arg_429_1.onSingleLineFinish_ = nil
			arg_429_1.state_ = "waiting"
		end

		function arg_429_1.playNext_(arg_431_0)
			if arg_431_0 == 1 then
				arg_429_0:Play1104902105(arg_429_1)
			end
		end

		function arg_429_1.onSingleLineUpdate_(arg_432_0)
			local var_432_0 = arg_429_1.actors_["1049ui_story"]
			local var_432_1 = 0

			if var_432_1 < arg_429_1.time_ and arg_429_1.time_ <= var_432_1 + arg_432_0 and not isNil(var_432_0) and arg_429_1.var_.characterEffect1049ui_story == nil then
				arg_429_1.var_.characterEffect1049ui_story = var_432_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_432_2 = 0.200000002980232

			if var_432_1 <= arg_429_1.time_ and arg_429_1.time_ < var_432_1 + var_432_2 and not isNil(var_432_0) then
				local var_432_3 = (arg_429_1.time_ - var_432_1) / var_432_2

				if arg_429_1.var_.characterEffect1049ui_story and not isNil(var_432_0) then
					local var_432_4 = Mathf.Lerp(0, 0.5, var_432_3)

					arg_429_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_429_1.var_.characterEffect1049ui_story.fillRatio = var_432_4
				end
			end

			if arg_429_1.time_ >= var_432_1 + var_432_2 and arg_429_1.time_ < var_432_1 + var_432_2 + arg_432_0 and not isNil(var_432_0) and arg_429_1.var_.characterEffect1049ui_story then
				local var_432_5 = 0.5

				arg_429_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_429_1.var_.characterEffect1049ui_story.fillRatio = var_432_5
			end

			local var_432_6 = 0
			local var_432_7 = 0.65

			if var_432_6 < arg_429_1.time_ and arg_429_1.time_ <= var_432_6 + arg_432_0 then
				arg_429_1.talkMaxDuration = 0
				arg_429_1.dialogCg_.alpha = 1

				arg_429_1.dialog_:SetActive(true)
				SetActive(arg_429_1.leftNameGo_, true)

				local var_432_8 = arg_429_1:FormatText(StoryNameCfg[7].name)

				arg_429_1.leftNameTxt_.text = var_432_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_429_1.leftNameTxt_.transform)

				arg_429_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_429_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_429_1:RecordName(arg_429_1.leftNameTxt_.text)
				SetActive(arg_429_1.iconTrs_.gameObject, true)
				arg_429_1.iconController_:SetSelectedState("hero")

				arg_429_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_429_1.callingController_:SetSelectedState("normal")

				arg_429_1.keyicon_.color = Color.New(1, 1, 1)
				arg_429_1.icon_.color = Color.New(1, 1, 1)

				local var_432_9 = arg_429_1:GetWordFromCfg(1104902104)
				local var_432_10 = arg_429_1:FormatText(var_432_9.content)

				arg_429_1.text_.text = var_432_10

				LuaForUtil.ClearLinePrefixSymbol(arg_429_1.text_)

				local var_432_11 = 26
				local var_432_12 = utf8.len(var_432_10)
				local var_432_13 = var_432_11 <= 0 and var_432_7 or var_432_7 * (var_432_12 / var_432_11)

				if var_432_13 > 0 and var_432_7 < var_432_13 then
					arg_429_1.talkMaxDuration = var_432_13

					if var_432_13 + var_432_6 > arg_429_1.duration_ then
						arg_429_1.duration_ = var_432_13 + var_432_6
					end
				end

				arg_429_1.text_.text = var_432_10
				arg_429_1.typewritter.percent = 0

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(false)
				arg_429_1:RecordContent(arg_429_1.text_.text)
			end

			local var_432_14 = math.max(var_432_7, arg_429_1.talkMaxDuration)

			if var_432_6 <= arg_429_1.time_ and arg_429_1.time_ < var_432_6 + var_432_14 then
				arg_429_1.typewritter.percent = (arg_429_1.time_ - var_432_6) / var_432_14

				arg_429_1.typewritter:SetDirty()
			end

			if arg_429_1.time_ >= var_432_6 + var_432_14 and arg_429_1.time_ < var_432_6 + var_432_14 + arg_432_0 then
				arg_429_1.typewritter.percent = 1

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(true)
			end
		end

		arg_429_1.nodeConfigList_ = {}

		arg_429_1:InitPlayNodeList()
	end,
	Play1104902105 = function(arg_433_0, arg_433_1)
		arg_433_1.time_ = 0
		arg_433_1.frameCnt_ = 0
		arg_433_1.state_ = "playing"
		arg_433_1.curTalkId_ = 1104902105
		arg_433_1.duration_ = 11.03

		local var_433_0 = {
			zh = 5.866,
			ja = 11.033
		}
		local var_433_1 = manager.audio:GetLocalizationFlag()

		if var_433_0[var_433_1] ~= nil then
			arg_433_1.duration_ = var_433_0[var_433_1]
		end

		SetActive(arg_433_1.tipsGo_, false)

		function arg_433_1.onSingleLineFinish_()
			arg_433_1.onSingleLineUpdate_ = nil
			arg_433_1.onSingleLineFinish_ = nil
			arg_433_1.state_ = "waiting"
		end

		function arg_433_1.playNext_(arg_435_0)
			if arg_435_0 == 1 then
				arg_433_0:Play1104902106(arg_433_1)
			end
		end

		function arg_433_1.onSingleLineUpdate_(arg_436_0)
			local var_436_0 = arg_433_1.actors_["1049ui_story"]
			local var_436_1 = 0

			if var_436_1 < arg_433_1.time_ and arg_433_1.time_ <= var_436_1 + arg_436_0 and not isNil(var_436_0) and arg_433_1.var_.characterEffect1049ui_story == nil then
				arg_433_1.var_.characterEffect1049ui_story = var_436_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_436_2 = 0.200000002980232

			if var_436_1 <= arg_433_1.time_ and arg_433_1.time_ < var_436_1 + var_436_2 and not isNil(var_436_0) then
				local var_436_3 = (arg_433_1.time_ - var_436_1) / var_436_2

				if arg_433_1.var_.characterEffect1049ui_story and not isNil(var_436_0) then
					arg_433_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_433_1.time_ >= var_436_1 + var_436_2 and arg_433_1.time_ < var_436_1 + var_436_2 + arg_436_0 and not isNil(var_436_0) and arg_433_1.var_.characterEffect1049ui_story then
				arg_433_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_436_4 = 0

			if var_436_4 < arg_433_1.time_ and arg_433_1.time_ <= var_436_4 + arg_436_0 then
				arg_433_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_436_5 = 0
			local var_436_6 = 0.6

			if var_436_5 < arg_433_1.time_ and arg_433_1.time_ <= var_436_5 + arg_436_0 then
				arg_433_1.talkMaxDuration = 0
				arg_433_1.dialogCg_.alpha = 1

				arg_433_1.dialog_:SetActive(true)
				SetActive(arg_433_1.leftNameGo_, true)

				local var_436_7 = arg_433_1:FormatText(StoryNameCfg[551].name)

				arg_433_1.leftNameTxt_.text = var_436_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_433_1.leftNameTxt_.transform)

				arg_433_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_433_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_433_1:RecordName(arg_433_1.leftNameTxt_.text)
				SetActive(arg_433_1.iconTrs_.gameObject, false)
				arg_433_1.callingController_:SetSelectedState("normal")

				local var_436_8 = arg_433_1:GetWordFromCfg(1104902105)
				local var_436_9 = arg_433_1:FormatText(var_436_8.content)

				arg_433_1.text_.text = var_436_9

				LuaForUtil.ClearLinePrefixSymbol(arg_433_1.text_)

				local var_436_10 = 24
				local var_436_11 = utf8.len(var_436_9)
				local var_436_12 = var_436_10 <= 0 and var_436_6 or var_436_6 * (var_436_11 / var_436_10)

				if var_436_12 > 0 and var_436_6 < var_436_12 then
					arg_433_1.talkMaxDuration = var_436_12

					if var_436_12 + var_436_5 > arg_433_1.duration_ then
						arg_433_1.duration_ = var_436_12 + var_436_5
					end
				end

				arg_433_1.text_.text = var_436_9
				arg_433_1.typewritter.percent = 0

				arg_433_1.typewritter:SetDirty()
				arg_433_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104902", "1104902105", "story_v_side_new_1104902.awb") ~= 0 then
					local var_436_13 = manager.audio:GetVoiceLength("story_v_side_new_1104902", "1104902105", "story_v_side_new_1104902.awb") / 1000

					if var_436_13 + var_436_5 > arg_433_1.duration_ then
						arg_433_1.duration_ = var_436_13 + var_436_5
					end

					if var_436_8.prefab_name ~= "" and arg_433_1.actors_[var_436_8.prefab_name] ~= nil then
						local var_436_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_433_1.actors_[var_436_8.prefab_name].transform, "story_v_side_new_1104902", "1104902105", "story_v_side_new_1104902.awb")

						arg_433_1:RecordAudio("1104902105", var_436_14)
						arg_433_1:RecordAudio("1104902105", var_436_14)
					else
						arg_433_1:AudioAction("play", "voice", "story_v_side_new_1104902", "1104902105", "story_v_side_new_1104902.awb")
					end

					arg_433_1:RecordHistoryTalkVoice("story_v_side_new_1104902", "1104902105", "story_v_side_new_1104902.awb")
				end

				arg_433_1:RecordContent(arg_433_1.text_.text)
			end

			local var_436_15 = math.max(var_436_6, arg_433_1.talkMaxDuration)

			if var_436_5 <= arg_433_1.time_ and arg_433_1.time_ < var_436_5 + var_436_15 then
				arg_433_1.typewritter.percent = (arg_433_1.time_ - var_436_5) / var_436_15

				arg_433_1.typewritter:SetDirty()
			end

			if arg_433_1.time_ >= var_436_5 + var_436_15 and arg_433_1.time_ < var_436_5 + var_436_15 + arg_436_0 then
				arg_433_1.typewritter.percent = 1

				arg_433_1.typewritter:SetDirty()
				arg_433_1:ShowNextGo(true)
			end
		end

		arg_433_1.nodeConfigList_ = {}

		arg_433_1:InitPlayNodeList()
	end,
	Play1104902106 = function(arg_437_0, arg_437_1)
		arg_437_1.time_ = 0
		arg_437_1.frameCnt_ = 0
		arg_437_1.state_ = "playing"
		arg_437_1.curTalkId_ = 1104902106
		arg_437_1.duration_ = 5

		SetActive(arg_437_1.tipsGo_, false)

		function arg_437_1.onSingleLineFinish_()
			arg_437_1.onSingleLineUpdate_ = nil
			arg_437_1.onSingleLineFinish_ = nil
			arg_437_1.state_ = "waiting"
		end

		function arg_437_1.playNext_(arg_439_0)
			if arg_439_0 == 1 then
				arg_437_0:Play1104902107(arg_437_1)
			end
		end

		function arg_437_1.onSingleLineUpdate_(arg_440_0)
			local var_440_0 = arg_437_1.actors_["1049ui_story"]
			local var_440_1 = 0

			if var_440_1 < arg_437_1.time_ and arg_437_1.time_ <= var_440_1 + arg_440_0 and not isNil(var_440_0) and arg_437_1.var_.characterEffect1049ui_story == nil then
				arg_437_1.var_.characterEffect1049ui_story = var_440_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_440_2 = 0.200000002980232

			if var_440_1 <= arg_437_1.time_ and arg_437_1.time_ < var_440_1 + var_440_2 and not isNil(var_440_0) then
				local var_440_3 = (arg_437_1.time_ - var_440_1) / var_440_2

				if arg_437_1.var_.characterEffect1049ui_story and not isNil(var_440_0) then
					local var_440_4 = Mathf.Lerp(0, 0.5, var_440_3)

					arg_437_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_437_1.var_.characterEffect1049ui_story.fillRatio = var_440_4
				end
			end

			if arg_437_1.time_ >= var_440_1 + var_440_2 and arg_437_1.time_ < var_440_1 + var_440_2 + arg_440_0 and not isNil(var_440_0) and arg_437_1.var_.characterEffect1049ui_story then
				local var_440_5 = 0.5

				arg_437_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_437_1.var_.characterEffect1049ui_story.fillRatio = var_440_5
			end

			local var_440_6 = 0
			local var_440_7 = 0.8

			if var_440_6 < arg_437_1.time_ and arg_437_1.time_ <= var_440_6 + arg_440_0 then
				arg_437_1.talkMaxDuration = 0
				arg_437_1.dialogCg_.alpha = 1

				arg_437_1.dialog_:SetActive(true)
				SetActive(arg_437_1.leftNameGo_, true)

				local var_440_8 = arg_437_1:FormatText(StoryNameCfg[7].name)

				arg_437_1.leftNameTxt_.text = var_440_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_437_1.leftNameTxt_.transform)

				arg_437_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_437_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_437_1:RecordName(arg_437_1.leftNameTxt_.text)
				SetActive(arg_437_1.iconTrs_.gameObject, true)
				arg_437_1.iconController_:SetSelectedState("hero")

				arg_437_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_437_1.callingController_:SetSelectedState("normal")

				arg_437_1.keyicon_.color = Color.New(1, 1, 1)
				arg_437_1.icon_.color = Color.New(1, 1, 1)

				local var_440_9 = arg_437_1:GetWordFromCfg(1104902106)
				local var_440_10 = arg_437_1:FormatText(var_440_9.content)

				arg_437_1.text_.text = var_440_10

				LuaForUtil.ClearLinePrefixSymbol(arg_437_1.text_)

				local var_440_11 = 32
				local var_440_12 = utf8.len(var_440_10)
				local var_440_13 = var_440_11 <= 0 and var_440_7 or var_440_7 * (var_440_12 / var_440_11)

				if var_440_13 > 0 and var_440_7 < var_440_13 then
					arg_437_1.talkMaxDuration = var_440_13

					if var_440_13 + var_440_6 > arg_437_1.duration_ then
						arg_437_1.duration_ = var_440_13 + var_440_6
					end
				end

				arg_437_1.text_.text = var_440_10
				arg_437_1.typewritter.percent = 0

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(false)
				arg_437_1:RecordContent(arg_437_1.text_.text)
			end

			local var_440_14 = math.max(var_440_7, arg_437_1.talkMaxDuration)

			if var_440_6 <= arg_437_1.time_ and arg_437_1.time_ < var_440_6 + var_440_14 then
				arg_437_1.typewritter.percent = (arg_437_1.time_ - var_440_6) / var_440_14

				arg_437_1.typewritter:SetDirty()
			end

			if arg_437_1.time_ >= var_440_6 + var_440_14 and arg_437_1.time_ < var_440_6 + var_440_14 + arg_440_0 then
				arg_437_1.typewritter.percent = 1

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(true)
			end
		end

		arg_437_1.nodeConfigList_ = {}

		arg_437_1:InitPlayNodeList()
	end,
	Play1104902107 = function(arg_441_0, arg_441_1)
		arg_441_1.time_ = 0
		arg_441_1.frameCnt_ = 0
		arg_441_1.state_ = "playing"
		arg_441_1.curTalkId_ = 1104902107
		arg_441_1.duration_ = 9.1

		local var_441_0 = {
			zh = 5.333,
			ja = 9.1
		}
		local var_441_1 = manager.audio:GetLocalizationFlag()

		if var_441_0[var_441_1] ~= nil then
			arg_441_1.duration_ = var_441_0[var_441_1]
		end

		SetActive(arg_441_1.tipsGo_, false)

		function arg_441_1.onSingleLineFinish_()
			arg_441_1.onSingleLineUpdate_ = nil
			arg_441_1.onSingleLineFinish_ = nil
			arg_441_1.state_ = "waiting"
		end

		function arg_441_1.playNext_(arg_443_0)
			if arg_443_0 == 1 then
				arg_441_0:Play1104902108(arg_441_1)
			end
		end

		function arg_441_1.onSingleLineUpdate_(arg_444_0)
			local var_444_0 = arg_441_1.actors_["1049ui_story"].transform
			local var_444_1 = 0

			if var_444_1 < arg_441_1.time_ and arg_441_1.time_ <= var_444_1 + arg_444_0 then
				arg_441_1.var_.moveOldPos1049ui_story = var_444_0.localPosition
			end

			local var_444_2 = 0.001

			if var_444_1 <= arg_441_1.time_ and arg_441_1.time_ < var_444_1 + var_444_2 then
				local var_444_3 = (arg_441_1.time_ - var_444_1) / var_444_2
				local var_444_4 = Vector3.New(0, -1.2, -6)

				var_444_0.localPosition = Vector3.Lerp(arg_441_1.var_.moveOldPos1049ui_story, var_444_4, var_444_3)

				local var_444_5 = manager.ui.mainCamera.transform.position - var_444_0.position

				var_444_0.forward = Vector3.New(var_444_5.x, var_444_5.y, var_444_5.z)

				local var_444_6 = var_444_0.localEulerAngles

				var_444_6.z = 0
				var_444_6.x = 0
				var_444_0.localEulerAngles = var_444_6
			end

			if arg_441_1.time_ >= var_444_1 + var_444_2 and arg_441_1.time_ < var_444_1 + var_444_2 + arg_444_0 then
				var_444_0.localPosition = Vector3.New(0, -1.2, -6)

				local var_444_7 = manager.ui.mainCamera.transform.position - var_444_0.position

				var_444_0.forward = Vector3.New(var_444_7.x, var_444_7.y, var_444_7.z)

				local var_444_8 = var_444_0.localEulerAngles

				var_444_8.z = 0
				var_444_8.x = 0
				var_444_0.localEulerAngles = var_444_8
			end

			local var_444_9 = arg_441_1.actors_["1049ui_story"]
			local var_444_10 = 0

			if var_444_10 < arg_441_1.time_ and arg_441_1.time_ <= var_444_10 + arg_444_0 and not isNil(var_444_9) and arg_441_1.var_.characterEffect1049ui_story == nil then
				arg_441_1.var_.characterEffect1049ui_story = var_444_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_444_11 = 0.200000002980232

			if var_444_10 <= arg_441_1.time_ and arg_441_1.time_ < var_444_10 + var_444_11 and not isNil(var_444_9) then
				local var_444_12 = (arg_441_1.time_ - var_444_10) / var_444_11

				if arg_441_1.var_.characterEffect1049ui_story and not isNil(var_444_9) then
					arg_441_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_441_1.time_ >= var_444_10 + var_444_11 and arg_441_1.time_ < var_444_10 + var_444_11 + arg_444_0 and not isNil(var_444_9) and arg_441_1.var_.characterEffect1049ui_story then
				arg_441_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_444_13 = 0

			if var_444_13 < arg_441_1.time_ and arg_441_1.time_ <= var_444_13 + arg_444_0 then
				arg_441_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action1_1")
			end

			local var_444_14 = 0

			if var_444_14 < arg_441_1.time_ and arg_441_1.time_ <= var_444_14 + arg_444_0 then
				arg_441_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_444_15 = 0
			local var_444_16 = 0.35

			if var_444_15 < arg_441_1.time_ and arg_441_1.time_ <= var_444_15 + arg_444_0 then
				arg_441_1.talkMaxDuration = 0
				arg_441_1.dialogCg_.alpha = 1

				arg_441_1.dialog_:SetActive(true)
				SetActive(arg_441_1.leftNameGo_, true)

				local var_444_17 = arg_441_1:FormatText(StoryNameCfg[551].name)

				arg_441_1.leftNameTxt_.text = var_444_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_441_1.leftNameTxt_.transform)

				arg_441_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_441_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_441_1:RecordName(arg_441_1.leftNameTxt_.text)
				SetActive(arg_441_1.iconTrs_.gameObject, false)
				arg_441_1.callingController_:SetSelectedState("normal")

				local var_444_18 = arg_441_1:GetWordFromCfg(1104902107)
				local var_444_19 = arg_441_1:FormatText(var_444_18.content)

				arg_441_1.text_.text = var_444_19

				LuaForUtil.ClearLinePrefixSymbol(arg_441_1.text_)

				local var_444_20 = 14
				local var_444_21 = utf8.len(var_444_19)
				local var_444_22 = var_444_20 <= 0 and var_444_16 or var_444_16 * (var_444_21 / var_444_20)

				if var_444_22 > 0 and var_444_16 < var_444_22 then
					arg_441_1.talkMaxDuration = var_444_22

					if var_444_22 + var_444_15 > arg_441_1.duration_ then
						arg_441_1.duration_ = var_444_22 + var_444_15
					end
				end

				arg_441_1.text_.text = var_444_19
				arg_441_1.typewritter.percent = 0

				arg_441_1.typewritter:SetDirty()
				arg_441_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104902", "1104902107", "story_v_side_new_1104902.awb") ~= 0 then
					local var_444_23 = manager.audio:GetVoiceLength("story_v_side_new_1104902", "1104902107", "story_v_side_new_1104902.awb") / 1000

					if var_444_23 + var_444_15 > arg_441_1.duration_ then
						arg_441_1.duration_ = var_444_23 + var_444_15
					end

					if var_444_18.prefab_name ~= "" and arg_441_1.actors_[var_444_18.prefab_name] ~= nil then
						local var_444_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_441_1.actors_[var_444_18.prefab_name].transform, "story_v_side_new_1104902", "1104902107", "story_v_side_new_1104902.awb")

						arg_441_1:RecordAudio("1104902107", var_444_24)
						arg_441_1:RecordAudio("1104902107", var_444_24)
					else
						arg_441_1:AudioAction("play", "voice", "story_v_side_new_1104902", "1104902107", "story_v_side_new_1104902.awb")
					end

					arg_441_1:RecordHistoryTalkVoice("story_v_side_new_1104902", "1104902107", "story_v_side_new_1104902.awb")
				end

				arg_441_1:RecordContent(arg_441_1.text_.text)
			end

			local var_444_25 = math.max(var_444_16, arg_441_1.talkMaxDuration)

			if var_444_15 <= arg_441_1.time_ and arg_441_1.time_ < var_444_15 + var_444_25 then
				arg_441_1.typewritter.percent = (arg_441_1.time_ - var_444_15) / var_444_25

				arg_441_1.typewritter:SetDirty()
			end

			if arg_441_1.time_ >= var_444_15 + var_444_25 and arg_441_1.time_ < var_444_15 + var_444_25 + arg_444_0 then
				arg_441_1.typewritter.percent = 1

				arg_441_1.typewritter:SetDirty()
				arg_441_1:ShowNextGo(true)
			end
		end

		arg_441_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_441_1:InitPlayNodeList()
	end,
	Play1104902108 = function(arg_445_0, arg_445_1)
		arg_445_1.time_ = 0
		arg_445_1.frameCnt_ = 0
		arg_445_1.state_ = "playing"
		arg_445_1.curTalkId_ = 1104902108
		arg_445_1.duration_ = 5

		SetActive(arg_445_1.tipsGo_, false)

		function arg_445_1.onSingleLineFinish_()
			arg_445_1.onSingleLineUpdate_ = nil
			arg_445_1.onSingleLineFinish_ = nil
			arg_445_1.state_ = "waiting"
		end

		function arg_445_1.playNext_(arg_447_0)
			if arg_447_0 == 1 then
				arg_445_0:Play1104902109(arg_445_1)
			end
		end

		function arg_445_1.onSingleLineUpdate_(arg_448_0)
			local var_448_0 = arg_445_1.actors_["1049ui_story"].transform
			local var_448_1 = 0

			if var_448_1 < arg_445_1.time_ and arg_445_1.time_ <= var_448_1 + arg_448_0 then
				arg_445_1.var_.moveOldPos1049ui_story = var_448_0.localPosition
			end

			local var_448_2 = 0.001

			if var_448_1 <= arg_445_1.time_ and arg_445_1.time_ < var_448_1 + var_448_2 then
				local var_448_3 = (arg_445_1.time_ - var_448_1) / var_448_2
				local var_448_4 = Vector3.New(0, 100, 0)

				var_448_0.localPosition = Vector3.Lerp(arg_445_1.var_.moveOldPos1049ui_story, var_448_4, var_448_3)

				local var_448_5 = manager.ui.mainCamera.transform.position - var_448_0.position

				var_448_0.forward = Vector3.New(var_448_5.x, var_448_5.y, var_448_5.z)

				local var_448_6 = var_448_0.localEulerAngles

				var_448_6.z = 0
				var_448_6.x = 0
				var_448_0.localEulerAngles = var_448_6
			end

			if arg_445_1.time_ >= var_448_1 + var_448_2 and arg_445_1.time_ < var_448_1 + var_448_2 + arg_448_0 then
				var_448_0.localPosition = Vector3.New(0, 100, 0)

				local var_448_7 = manager.ui.mainCamera.transform.position - var_448_0.position

				var_448_0.forward = Vector3.New(var_448_7.x, var_448_7.y, var_448_7.z)

				local var_448_8 = var_448_0.localEulerAngles

				var_448_8.z = 0
				var_448_8.x = 0
				var_448_0.localEulerAngles = var_448_8
			end

			local var_448_9 = arg_445_1.actors_["1049ui_story"]
			local var_448_10 = 0

			if var_448_10 < arg_445_1.time_ and arg_445_1.time_ <= var_448_10 + arg_448_0 and not isNil(var_448_9) and arg_445_1.var_.characterEffect1049ui_story == nil then
				arg_445_1.var_.characterEffect1049ui_story = var_448_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_448_11 = 0.200000002980232

			if var_448_10 <= arg_445_1.time_ and arg_445_1.time_ < var_448_10 + var_448_11 and not isNil(var_448_9) then
				local var_448_12 = (arg_445_1.time_ - var_448_10) / var_448_11

				if arg_445_1.var_.characterEffect1049ui_story and not isNil(var_448_9) then
					local var_448_13 = Mathf.Lerp(0, 0.5, var_448_12)

					arg_445_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_445_1.var_.characterEffect1049ui_story.fillRatio = var_448_13
				end
			end

			if arg_445_1.time_ >= var_448_10 + var_448_11 and arg_445_1.time_ < var_448_10 + var_448_11 + arg_448_0 and not isNil(var_448_9) and arg_445_1.var_.characterEffect1049ui_story then
				local var_448_14 = 0.5

				arg_445_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_445_1.var_.characterEffect1049ui_story.fillRatio = var_448_14
			end

			local var_448_15 = 0
			local var_448_16 = 0.45

			if var_448_15 < arg_445_1.time_ and arg_445_1.time_ <= var_448_15 + arg_448_0 then
				arg_445_1.talkMaxDuration = 0
				arg_445_1.dialogCg_.alpha = 1

				arg_445_1.dialog_:SetActive(true)
				SetActive(arg_445_1.leftNameGo_, false)

				arg_445_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_445_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_445_1:RecordName(arg_445_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_445_1.iconTrs_.gameObject, false)
				arg_445_1.callingController_:SetSelectedState("normal")

				local var_448_17 = arg_445_1:GetWordFromCfg(1104902108)
				local var_448_18 = arg_445_1:FormatText(var_448_17.content)

				arg_445_1.text_.text = var_448_18

				LuaForUtil.ClearLinePrefixSymbol(arg_445_1.text_)

				local var_448_19 = 18
				local var_448_20 = utf8.len(var_448_18)
				local var_448_21 = var_448_19 <= 0 and var_448_16 or var_448_16 * (var_448_20 / var_448_19)

				if var_448_21 > 0 and var_448_16 < var_448_21 then
					arg_445_1.talkMaxDuration = var_448_21

					if var_448_21 + var_448_15 > arg_445_1.duration_ then
						arg_445_1.duration_ = var_448_21 + var_448_15
					end
				end

				arg_445_1.text_.text = var_448_18
				arg_445_1.typewritter.percent = 0

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(false)
				arg_445_1:RecordContent(arg_445_1.text_.text)
			end

			local var_448_22 = math.max(var_448_16, arg_445_1.talkMaxDuration)

			if var_448_15 <= arg_445_1.time_ and arg_445_1.time_ < var_448_15 + var_448_22 then
				arg_445_1.typewritter.percent = (arg_445_1.time_ - var_448_15) / var_448_22

				arg_445_1.typewritter:SetDirty()
			end

			if arg_445_1.time_ >= var_448_15 + var_448_22 and arg_445_1.time_ < var_448_15 + var_448_22 + arg_448_0 then
				arg_445_1.typewritter.percent = 1

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(true)
			end
		end

		arg_445_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_445_1:InitPlayNodeList()
	end,
	Play1104902109 = function(arg_449_0, arg_449_1)
		arg_449_1.time_ = 0
		arg_449_1.frameCnt_ = 0
		arg_449_1.state_ = "playing"
		arg_449_1.curTalkId_ = 1104902109
		arg_449_1.duration_ = 5

		SetActive(arg_449_1.tipsGo_, false)

		function arg_449_1.onSingleLineFinish_()
			arg_449_1.onSingleLineUpdate_ = nil
			arg_449_1.onSingleLineFinish_ = nil
			arg_449_1.state_ = "waiting"
		end

		function arg_449_1.playNext_(arg_451_0)
			if arg_451_0 == 1 then
				arg_449_0:Play1104902110(arg_449_1)
			end
		end

		function arg_449_1.onSingleLineUpdate_(arg_452_0)
			local var_452_0 = 0
			local var_452_1 = 0.925

			if var_452_0 < arg_449_1.time_ and arg_449_1.time_ <= var_452_0 + arg_452_0 then
				arg_449_1.talkMaxDuration = 0
				arg_449_1.dialogCg_.alpha = 1

				arg_449_1.dialog_:SetActive(true)
				SetActive(arg_449_1.leftNameGo_, false)

				arg_449_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_449_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_449_1:RecordName(arg_449_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_449_1.iconTrs_.gameObject, false)
				arg_449_1.callingController_:SetSelectedState("normal")

				local var_452_2 = arg_449_1:GetWordFromCfg(1104902109)
				local var_452_3 = arg_449_1:FormatText(var_452_2.content)

				arg_449_1.text_.text = var_452_3

				LuaForUtil.ClearLinePrefixSymbol(arg_449_1.text_)

				local var_452_4 = 37
				local var_452_5 = utf8.len(var_452_3)
				local var_452_6 = var_452_4 <= 0 and var_452_1 or var_452_1 * (var_452_5 / var_452_4)

				if var_452_6 > 0 and var_452_1 < var_452_6 then
					arg_449_1.talkMaxDuration = var_452_6

					if var_452_6 + var_452_0 > arg_449_1.duration_ then
						arg_449_1.duration_ = var_452_6 + var_452_0
					end
				end

				arg_449_1.text_.text = var_452_3
				arg_449_1.typewritter.percent = 0

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(false)
				arg_449_1:RecordContent(arg_449_1.text_.text)
			end

			local var_452_7 = math.max(var_452_1, arg_449_1.talkMaxDuration)

			if var_452_0 <= arg_449_1.time_ and arg_449_1.time_ < var_452_0 + var_452_7 then
				arg_449_1.typewritter.percent = (arg_449_1.time_ - var_452_0) / var_452_7

				arg_449_1.typewritter:SetDirty()
			end

			if arg_449_1.time_ >= var_452_0 + var_452_7 and arg_449_1.time_ < var_452_0 + var_452_7 + arg_452_0 then
				arg_449_1.typewritter.percent = 1

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(true)
			end
		end

		arg_449_1.nodeConfigList_ = {}

		arg_449_1:InitPlayNodeList()
	end,
	Play1104902110 = function(arg_453_0, arg_453_1)
		arg_453_1.time_ = 0
		arg_453_1.frameCnt_ = 0
		arg_453_1.state_ = "playing"
		arg_453_1.curTalkId_ = 1104902110
		arg_453_1.duration_ = 3

		local var_453_0 = {
			zh = 0.999999999999,
			ja = 3
		}
		local var_453_1 = manager.audio:GetLocalizationFlag()

		if var_453_0[var_453_1] ~= nil then
			arg_453_1.duration_ = var_453_0[var_453_1]
		end

		SetActive(arg_453_1.tipsGo_, false)

		function arg_453_1.onSingleLineFinish_()
			arg_453_1.onSingleLineUpdate_ = nil
			arg_453_1.onSingleLineFinish_ = nil
			arg_453_1.state_ = "waiting"
		end

		function arg_453_1.playNext_(arg_455_0)
			if arg_455_0 == 1 then
				arg_453_0:Play1104902111(arg_453_1)
			end
		end

		function arg_453_1.onSingleLineUpdate_(arg_456_0)
			local var_456_0 = 0
			local var_456_1 = 0.05

			if var_456_0 < arg_453_1.time_ and arg_453_1.time_ <= var_456_0 + arg_456_0 then
				arg_453_1.talkMaxDuration = 0
				arg_453_1.dialogCg_.alpha = 1

				arg_453_1.dialog_:SetActive(true)
				SetActive(arg_453_1.leftNameGo_, true)

				local var_456_2 = arg_453_1:FormatText(StoryNameCfg[1008].name)

				arg_453_1.leftNameTxt_.text = var_456_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_453_1.leftNameTxt_.transform)

				arg_453_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_453_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_453_1:RecordName(arg_453_1.leftNameTxt_.text)
				SetActive(arg_453_1.iconTrs_.gameObject, true)
				arg_453_1.iconController_:SetSelectedState("hero")

				arg_453_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10119")

				arg_453_1.callingController_:SetSelectedState("normal")

				arg_453_1.keyicon_.color = Color.New(1, 1, 1)
				arg_453_1.icon_.color = Color.New(1, 1, 1)

				local var_456_3 = arg_453_1:GetWordFromCfg(1104902110)
				local var_456_4 = arg_453_1:FormatText(var_456_3.content)

				arg_453_1.text_.text = var_456_4

				LuaForUtil.ClearLinePrefixSymbol(arg_453_1.text_)

				local var_456_5 = 2
				local var_456_6 = utf8.len(var_456_4)
				local var_456_7 = var_456_5 <= 0 and var_456_1 or var_456_1 * (var_456_6 / var_456_5)

				if var_456_7 > 0 and var_456_1 < var_456_7 then
					arg_453_1.talkMaxDuration = var_456_7

					if var_456_7 + var_456_0 > arg_453_1.duration_ then
						arg_453_1.duration_ = var_456_7 + var_456_0
					end
				end

				arg_453_1.text_.text = var_456_4
				arg_453_1.typewritter.percent = 0

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104902", "1104902110", "story_v_side_new_1104902.awb") ~= 0 then
					local var_456_8 = manager.audio:GetVoiceLength("story_v_side_new_1104902", "1104902110", "story_v_side_new_1104902.awb") / 1000

					if var_456_8 + var_456_0 > arg_453_1.duration_ then
						arg_453_1.duration_ = var_456_8 + var_456_0
					end

					if var_456_3.prefab_name ~= "" and arg_453_1.actors_[var_456_3.prefab_name] ~= nil then
						local var_456_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_453_1.actors_[var_456_3.prefab_name].transform, "story_v_side_new_1104902", "1104902110", "story_v_side_new_1104902.awb")

						arg_453_1:RecordAudio("1104902110", var_456_9)
						arg_453_1:RecordAudio("1104902110", var_456_9)
					else
						arg_453_1:AudioAction("play", "voice", "story_v_side_new_1104902", "1104902110", "story_v_side_new_1104902.awb")
					end

					arg_453_1:RecordHistoryTalkVoice("story_v_side_new_1104902", "1104902110", "story_v_side_new_1104902.awb")
				end

				arg_453_1:RecordContent(arg_453_1.text_.text)
			end

			local var_456_10 = math.max(var_456_1, arg_453_1.talkMaxDuration)

			if var_456_0 <= arg_453_1.time_ and arg_453_1.time_ < var_456_0 + var_456_10 then
				arg_453_1.typewritter.percent = (arg_453_1.time_ - var_456_0) / var_456_10

				arg_453_1.typewritter:SetDirty()
			end

			if arg_453_1.time_ >= var_456_0 + var_456_10 and arg_453_1.time_ < var_456_0 + var_456_10 + arg_456_0 then
				arg_453_1.typewritter.percent = 1

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(true)
			end
		end

		arg_453_1.nodeConfigList_ = {}

		arg_453_1:InitPlayNodeList()
	end,
	Play1104902111 = function(arg_457_0, arg_457_1)
		arg_457_1.time_ = 0
		arg_457_1.frameCnt_ = 0
		arg_457_1.state_ = "playing"
		arg_457_1.curTalkId_ = 1104902111
		arg_457_1.duration_ = 5

		SetActive(arg_457_1.tipsGo_, false)

		function arg_457_1.onSingleLineFinish_()
			arg_457_1.onSingleLineUpdate_ = nil
			arg_457_1.onSingleLineFinish_ = nil
			arg_457_1.state_ = "waiting"
		end

		function arg_457_1.playNext_(arg_459_0)
			if arg_459_0 == 1 then
				arg_457_0:Play1104902112(arg_457_1)
			end
		end

		function arg_457_1.onSingleLineUpdate_(arg_460_0)
			local var_460_0 = 0
			local var_460_1 = 0.8

			if var_460_0 < arg_457_1.time_ and arg_457_1.time_ <= var_460_0 + arg_460_0 then
				arg_457_1.talkMaxDuration = 0
				arg_457_1.dialogCg_.alpha = 1

				arg_457_1.dialog_:SetActive(true)
				SetActive(arg_457_1.leftNameGo_, false)

				arg_457_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_457_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_457_1:RecordName(arg_457_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_457_1.iconTrs_.gameObject, false)
				arg_457_1.callingController_:SetSelectedState("normal")

				local var_460_2 = arg_457_1:GetWordFromCfg(1104902111)
				local var_460_3 = arg_457_1:FormatText(var_460_2.content)

				arg_457_1.text_.text = var_460_3

				LuaForUtil.ClearLinePrefixSymbol(arg_457_1.text_)

				local var_460_4 = 32
				local var_460_5 = utf8.len(var_460_3)
				local var_460_6 = var_460_4 <= 0 and var_460_1 or var_460_1 * (var_460_5 / var_460_4)

				if var_460_6 > 0 and var_460_1 < var_460_6 then
					arg_457_1.talkMaxDuration = var_460_6

					if var_460_6 + var_460_0 > arg_457_1.duration_ then
						arg_457_1.duration_ = var_460_6 + var_460_0
					end
				end

				arg_457_1.text_.text = var_460_3
				arg_457_1.typewritter.percent = 0

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(false)
				arg_457_1:RecordContent(arg_457_1.text_.text)
			end

			local var_460_7 = math.max(var_460_1, arg_457_1.talkMaxDuration)

			if var_460_0 <= arg_457_1.time_ and arg_457_1.time_ < var_460_0 + var_460_7 then
				arg_457_1.typewritter.percent = (arg_457_1.time_ - var_460_0) / var_460_7

				arg_457_1.typewritter:SetDirty()
			end

			if arg_457_1.time_ >= var_460_0 + var_460_7 and arg_457_1.time_ < var_460_0 + var_460_7 + arg_460_0 then
				arg_457_1.typewritter.percent = 1

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(true)
			end
		end

		arg_457_1.nodeConfigList_ = {}

		arg_457_1:InitPlayNodeList()
	end,
	Play1104902112 = function(arg_461_0, arg_461_1)
		arg_461_1.time_ = 0
		arg_461_1.frameCnt_ = 0
		arg_461_1.state_ = "playing"
		arg_461_1.curTalkId_ = 1104902112
		arg_461_1.duration_ = 5

		SetActive(arg_461_1.tipsGo_, false)

		function arg_461_1.onSingleLineFinish_()
			arg_461_1.onSingleLineUpdate_ = nil
			arg_461_1.onSingleLineFinish_ = nil
			arg_461_1.state_ = "waiting"
		end

		function arg_461_1.playNext_(arg_463_0)
			if arg_463_0 == 1 then
				arg_461_0:Play1104902113(arg_461_1)
			end
		end

		function arg_461_1.onSingleLineUpdate_(arg_464_0)
			local var_464_0 = 0
			local var_464_1 = 1.225

			if var_464_0 < arg_461_1.time_ and arg_461_1.time_ <= var_464_0 + arg_464_0 then
				arg_461_1.talkMaxDuration = 0
				arg_461_1.dialogCg_.alpha = 1

				arg_461_1.dialog_:SetActive(true)
				SetActive(arg_461_1.leftNameGo_, false)

				arg_461_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_461_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_461_1:RecordName(arg_461_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_461_1.iconTrs_.gameObject, false)
				arg_461_1.callingController_:SetSelectedState("normal")

				local var_464_2 = arg_461_1:GetWordFromCfg(1104902112)
				local var_464_3 = arg_461_1:FormatText(var_464_2.content)

				arg_461_1.text_.text = var_464_3

				LuaForUtil.ClearLinePrefixSymbol(arg_461_1.text_)

				local var_464_4 = 49
				local var_464_5 = utf8.len(var_464_3)
				local var_464_6 = var_464_4 <= 0 and var_464_1 or var_464_1 * (var_464_5 / var_464_4)

				if var_464_6 > 0 and var_464_1 < var_464_6 then
					arg_461_1.talkMaxDuration = var_464_6

					if var_464_6 + var_464_0 > arg_461_1.duration_ then
						arg_461_1.duration_ = var_464_6 + var_464_0
					end
				end

				arg_461_1.text_.text = var_464_3
				arg_461_1.typewritter.percent = 0

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(false)
				arg_461_1:RecordContent(arg_461_1.text_.text)
			end

			local var_464_7 = math.max(var_464_1, arg_461_1.talkMaxDuration)

			if var_464_0 <= arg_461_1.time_ and arg_461_1.time_ < var_464_0 + var_464_7 then
				arg_461_1.typewritter.percent = (arg_461_1.time_ - var_464_0) / var_464_7

				arg_461_1.typewritter:SetDirty()
			end

			if arg_461_1.time_ >= var_464_0 + var_464_7 and arg_461_1.time_ < var_464_0 + var_464_7 + arg_464_0 then
				arg_461_1.typewritter.percent = 1

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(true)
			end
		end

		arg_461_1.nodeConfigList_ = {}

		arg_461_1:InitPlayNodeList()
	end,
	Play1104902113 = function(arg_465_0, arg_465_1)
		arg_465_1.time_ = 0
		arg_465_1.frameCnt_ = 0
		arg_465_1.state_ = "playing"
		arg_465_1.curTalkId_ = 1104902113
		arg_465_1.duration_ = 5

		SetActive(arg_465_1.tipsGo_, false)

		function arg_465_1.onSingleLineFinish_()
			arg_465_1.onSingleLineUpdate_ = nil
			arg_465_1.onSingleLineFinish_ = nil
			arg_465_1.state_ = "waiting"
		end

		function arg_465_1.playNext_(arg_467_0)
			if arg_467_0 == 1 then
				arg_465_0:Play1104902114(arg_465_1)
			end
		end

		function arg_465_1.onSingleLineUpdate_(arg_468_0)
			local var_468_0 = 0
			local var_468_1 = 0.625

			if var_468_0 < arg_465_1.time_ and arg_465_1.time_ <= var_468_0 + arg_468_0 then
				arg_465_1.talkMaxDuration = 0
				arg_465_1.dialogCg_.alpha = 1

				arg_465_1.dialog_:SetActive(true)
				SetActive(arg_465_1.leftNameGo_, true)

				local var_468_2 = arg_465_1:FormatText(StoryNameCfg[7].name)

				arg_465_1.leftNameTxt_.text = var_468_2

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

				local var_468_3 = arg_465_1:GetWordFromCfg(1104902113)
				local var_468_4 = arg_465_1:FormatText(var_468_3.content)

				arg_465_1.text_.text = var_468_4

				LuaForUtil.ClearLinePrefixSymbol(arg_465_1.text_)

				local var_468_5 = 25
				local var_468_6 = utf8.len(var_468_4)
				local var_468_7 = var_468_5 <= 0 and var_468_1 or var_468_1 * (var_468_6 / var_468_5)

				if var_468_7 > 0 and var_468_1 < var_468_7 then
					arg_465_1.talkMaxDuration = var_468_7

					if var_468_7 + var_468_0 > arg_465_1.duration_ then
						arg_465_1.duration_ = var_468_7 + var_468_0
					end
				end

				arg_465_1.text_.text = var_468_4
				arg_465_1.typewritter.percent = 0

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(false)
				arg_465_1:RecordContent(arg_465_1.text_.text)
			end

			local var_468_8 = math.max(var_468_1, arg_465_1.talkMaxDuration)

			if var_468_0 <= arg_465_1.time_ and arg_465_1.time_ < var_468_0 + var_468_8 then
				arg_465_1.typewritter.percent = (arg_465_1.time_ - var_468_0) / var_468_8

				arg_465_1.typewritter:SetDirty()
			end

			if arg_465_1.time_ >= var_468_0 + var_468_8 and arg_465_1.time_ < var_468_0 + var_468_8 + arg_468_0 then
				arg_465_1.typewritter.percent = 1

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(true)
			end
		end

		arg_465_1.nodeConfigList_ = {}

		arg_465_1:InitPlayNodeList()
	end,
	Play1104902114 = function(arg_469_0, arg_469_1)
		arg_469_1.time_ = 0
		arg_469_1.frameCnt_ = 0
		arg_469_1.state_ = "playing"
		arg_469_1.curTalkId_ = 1104902114
		arg_469_1.duration_ = 3.57

		local var_469_0 = {
			zh = 3.266,
			ja = 3.566
		}
		local var_469_1 = manager.audio:GetLocalizationFlag()

		if var_469_0[var_469_1] ~= nil then
			arg_469_1.duration_ = var_469_0[var_469_1]
		end

		SetActive(arg_469_1.tipsGo_, false)

		function arg_469_1.onSingleLineFinish_()
			arg_469_1.onSingleLineUpdate_ = nil
			arg_469_1.onSingleLineFinish_ = nil
			arg_469_1.state_ = "waiting"
		end

		function arg_469_1.playNext_(arg_471_0)
			if arg_471_0 == 1 then
				arg_469_0:Play1104902115(arg_469_1)
			end
		end

		function arg_469_1.onSingleLineUpdate_(arg_472_0)
			local var_472_0 = arg_469_1.actors_["1049ui_story"].transform
			local var_472_1 = 0

			if var_472_1 < arg_469_1.time_ and arg_469_1.time_ <= var_472_1 + arg_472_0 then
				arg_469_1.var_.moveOldPos1049ui_story = var_472_0.localPosition
			end

			local var_472_2 = 0.001

			if var_472_1 <= arg_469_1.time_ and arg_469_1.time_ < var_472_1 + var_472_2 then
				local var_472_3 = (arg_469_1.time_ - var_472_1) / var_472_2
				local var_472_4 = Vector3.New(0, -1.2, -6)

				var_472_0.localPosition = Vector3.Lerp(arg_469_1.var_.moveOldPos1049ui_story, var_472_4, var_472_3)

				local var_472_5 = manager.ui.mainCamera.transform.position - var_472_0.position

				var_472_0.forward = Vector3.New(var_472_5.x, var_472_5.y, var_472_5.z)

				local var_472_6 = var_472_0.localEulerAngles

				var_472_6.z = 0
				var_472_6.x = 0
				var_472_0.localEulerAngles = var_472_6
			end

			if arg_469_1.time_ >= var_472_1 + var_472_2 and arg_469_1.time_ < var_472_1 + var_472_2 + arg_472_0 then
				var_472_0.localPosition = Vector3.New(0, -1.2, -6)

				local var_472_7 = manager.ui.mainCamera.transform.position - var_472_0.position

				var_472_0.forward = Vector3.New(var_472_7.x, var_472_7.y, var_472_7.z)

				local var_472_8 = var_472_0.localEulerAngles

				var_472_8.z = 0
				var_472_8.x = 0
				var_472_0.localEulerAngles = var_472_8
			end

			local var_472_9 = arg_469_1.actors_["1049ui_story"]
			local var_472_10 = 0

			if var_472_10 < arg_469_1.time_ and arg_469_1.time_ <= var_472_10 + arg_472_0 and not isNil(var_472_9) and arg_469_1.var_.characterEffect1049ui_story == nil then
				arg_469_1.var_.characterEffect1049ui_story = var_472_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_472_11 = 0.200000002980232

			if var_472_10 <= arg_469_1.time_ and arg_469_1.time_ < var_472_10 + var_472_11 and not isNil(var_472_9) then
				local var_472_12 = (arg_469_1.time_ - var_472_10) / var_472_11

				if arg_469_1.var_.characterEffect1049ui_story and not isNil(var_472_9) then
					arg_469_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_469_1.time_ >= var_472_10 + var_472_11 and arg_469_1.time_ < var_472_10 + var_472_11 + arg_472_0 and not isNil(var_472_9) and arg_469_1.var_.characterEffect1049ui_story then
				arg_469_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_472_13 = 0

			if var_472_13 < arg_469_1.time_ and arg_469_1.time_ <= var_472_13 + arg_472_0 then
				arg_469_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action4_1")
			end

			local var_472_14 = 0

			if var_472_14 < arg_469_1.time_ and arg_469_1.time_ <= var_472_14 + arg_472_0 then
				arg_469_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_472_15 = 0
			local var_472_16 = 0.4

			if var_472_15 < arg_469_1.time_ and arg_469_1.time_ <= var_472_15 + arg_472_0 then
				arg_469_1.talkMaxDuration = 0
				arg_469_1.dialogCg_.alpha = 1

				arg_469_1.dialog_:SetActive(true)
				SetActive(arg_469_1.leftNameGo_, true)

				local var_472_17 = arg_469_1:FormatText(StoryNameCfg[551].name)

				arg_469_1.leftNameTxt_.text = var_472_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_469_1.leftNameTxt_.transform)

				arg_469_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_469_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_469_1:RecordName(arg_469_1.leftNameTxt_.text)
				SetActive(arg_469_1.iconTrs_.gameObject, false)
				arg_469_1.callingController_:SetSelectedState("normal")

				local var_472_18 = arg_469_1:GetWordFromCfg(1104902114)
				local var_472_19 = arg_469_1:FormatText(var_472_18.content)

				arg_469_1.text_.text = var_472_19

				LuaForUtil.ClearLinePrefixSymbol(arg_469_1.text_)

				local var_472_20 = 16
				local var_472_21 = utf8.len(var_472_19)
				local var_472_22 = var_472_20 <= 0 and var_472_16 or var_472_16 * (var_472_21 / var_472_20)

				if var_472_22 > 0 and var_472_16 < var_472_22 then
					arg_469_1.talkMaxDuration = var_472_22

					if var_472_22 + var_472_15 > arg_469_1.duration_ then
						arg_469_1.duration_ = var_472_22 + var_472_15
					end
				end

				arg_469_1.text_.text = var_472_19
				arg_469_1.typewritter.percent = 0

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104902", "1104902114", "story_v_side_new_1104902.awb") ~= 0 then
					local var_472_23 = manager.audio:GetVoiceLength("story_v_side_new_1104902", "1104902114", "story_v_side_new_1104902.awb") / 1000

					if var_472_23 + var_472_15 > arg_469_1.duration_ then
						arg_469_1.duration_ = var_472_23 + var_472_15
					end

					if var_472_18.prefab_name ~= "" and arg_469_1.actors_[var_472_18.prefab_name] ~= nil then
						local var_472_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_469_1.actors_[var_472_18.prefab_name].transform, "story_v_side_new_1104902", "1104902114", "story_v_side_new_1104902.awb")

						arg_469_1:RecordAudio("1104902114", var_472_24)
						arg_469_1:RecordAudio("1104902114", var_472_24)
					else
						arg_469_1:AudioAction("play", "voice", "story_v_side_new_1104902", "1104902114", "story_v_side_new_1104902.awb")
					end

					arg_469_1:RecordHistoryTalkVoice("story_v_side_new_1104902", "1104902114", "story_v_side_new_1104902.awb")
				end

				arg_469_1:RecordContent(arg_469_1.text_.text)
			end

			local var_472_25 = math.max(var_472_16, arg_469_1.talkMaxDuration)

			if var_472_15 <= arg_469_1.time_ and arg_469_1.time_ < var_472_15 + var_472_25 then
				arg_469_1.typewritter.percent = (arg_469_1.time_ - var_472_15) / var_472_25

				arg_469_1.typewritter:SetDirty()
			end

			if arg_469_1.time_ >= var_472_15 + var_472_25 and arg_469_1.time_ < var_472_15 + var_472_25 + arg_472_0 then
				arg_469_1.typewritter.percent = 1

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(true)
			end
		end

		arg_469_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_469_1:InitPlayNodeList()
	end,
	Play1104902115 = function(arg_473_0, arg_473_1)
		arg_473_1.time_ = 0
		arg_473_1.frameCnt_ = 0
		arg_473_1.state_ = "playing"
		arg_473_1.curTalkId_ = 1104902115
		arg_473_1.duration_ = 5

		SetActive(arg_473_1.tipsGo_, false)

		function arg_473_1.onSingleLineFinish_()
			arg_473_1.onSingleLineUpdate_ = nil
			arg_473_1.onSingleLineFinish_ = nil
			arg_473_1.state_ = "waiting"
		end

		function arg_473_1.playNext_(arg_475_0)
			if arg_475_0 == 1 then
				arg_473_0:Play1104902116(arg_473_1)
			end
		end

		function arg_473_1.onSingleLineUpdate_(arg_476_0)
			local var_476_0 = arg_473_1.actors_["1049ui_story"]
			local var_476_1 = 0

			if var_476_1 < arg_473_1.time_ and arg_473_1.time_ <= var_476_1 + arg_476_0 and not isNil(var_476_0) and arg_473_1.var_.characterEffect1049ui_story == nil then
				arg_473_1.var_.characterEffect1049ui_story = var_476_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_476_2 = 0.200000002980232

			if var_476_1 <= arg_473_1.time_ and arg_473_1.time_ < var_476_1 + var_476_2 and not isNil(var_476_0) then
				local var_476_3 = (arg_473_1.time_ - var_476_1) / var_476_2

				if arg_473_1.var_.characterEffect1049ui_story and not isNil(var_476_0) then
					local var_476_4 = Mathf.Lerp(0, 0.5, var_476_3)

					arg_473_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_473_1.var_.characterEffect1049ui_story.fillRatio = var_476_4
				end
			end

			if arg_473_1.time_ >= var_476_1 + var_476_2 and arg_473_1.time_ < var_476_1 + var_476_2 + arg_476_0 and not isNil(var_476_0) and arg_473_1.var_.characterEffect1049ui_story then
				local var_476_5 = 0.5

				arg_473_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_473_1.var_.characterEffect1049ui_story.fillRatio = var_476_5
			end

			local var_476_6 = 0
			local var_476_7 = 0.55

			if var_476_6 < arg_473_1.time_ and arg_473_1.time_ <= var_476_6 + arg_476_0 then
				arg_473_1.talkMaxDuration = 0
				arg_473_1.dialogCg_.alpha = 1

				arg_473_1.dialog_:SetActive(true)
				SetActive(arg_473_1.leftNameGo_, false)

				arg_473_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_473_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_473_1:RecordName(arg_473_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_473_1.iconTrs_.gameObject, false)
				arg_473_1.callingController_:SetSelectedState("normal")

				local var_476_8 = arg_473_1:GetWordFromCfg(1104902115)
				local var_476_9 = arg_473_1:FormatText(var_476_8.content)

				arg_473_1.text_.text = var_476_9

				LuaForUtil.ClearLinePrefixSymbol(arg_473_1.text_)

				local var_476_10 = 22
				local var_476_11 = utf8.len(var_476_9)
				local var_476_12 = var_476_10 <= 0 and var_476_7 or var_476_7 * (var_476_11 / var_476_10)

				if var_476_12 > 0 and var_476_7 < var_476_12 then
					arg_473_1.talkMaxDuration = var_476_12

					if var_476_12 + var_476_6 > arg_473_1.duration_ then
						arg_473_1.duration_ = var_476_12 + var_476_6
					end
				end

				arg_473_1.text_.text = var_476_9
				arg_473_1.typewritter.percent = 0

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(false)
				arg_473_1:RecordContent(arg_473_1.text_.text)
			end

			local var_476_13 = math.max(var_476_7, arg_473_1.talkMaxDuration)

			if var_476_6 <= arg_473_1.time_ and arg_473_1.time_ < var_476_6 + var_476_13 then
				arg_473_1.typewritter.percent = (arg_473_1.time_ - var_476_6) / var_476_13

				arg_473_1.typewritter:SetDirty()
			end

			if arg_473_1.time_ >= var_476_6 + var_476_13 and arg_473_1.time_ < var_476_6 + var_476_13 + arg_476_0 then
				arg_473_1.typewritter.percent = 1

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(true)
			end
		end

		arg_473_1.nodeConfigList_ = {}

		arg_473_1:InitPlayNodeList()
	end,
	Play1104902116 = function(arg_477_0, arg_477_1)
		arg_477_1.time_ = 0
		arg_477_1.frameCnt_ = 0
		arg_477_1.state_ = "playing"
		arg_477_1.curTalkId_ = 1104902116
		arg_477_1.duration_ = 6.53

		local var_477_0 = {
			zh = 6.533,
			ja = 5.266
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
				arg_477_0:Play1104902117(arg_477_1)
			end
		end

		function arg_477_1.onSingleLineUpdate_(arg_480_0)
			local var_480_0 = arg_477_1.actors_["1049ui_story"].transform
			local var_480_1 = 0

			if var_480_1 < arg_477_1.time_ and arg_477_1.time_ <= var_480_1 + arg_480_0 then
				arg_477_1.var_.moveOldPos1049ui_story = var_480_0.localPosition
			end

			local var_480_2 = 0.001

			if var_480_1 <= arg_477_1.time_ and arg_477_1.time_ < var_480_1 + var_480_2 then
				local var_480_3 = (arg_477_1.time_ - var_480_1) / var_480_2
				local var_480_4 = Vector3.New(0, -1.2, -6)

				var_480_0.localPosition = Vector3.Lerp(arg_477_1.var_.moveOldPos1049ui_story, var_480_4, var_480_3)

				local var_480_5 = manager.ui.mainCamera.transform.position - var_480_0.position

				var_480_0.forward = Vector3.New(var_480_5.x, var_480_5.y, var_480_5.z)

				local var_480_6 = var_480_0.localEulerAngles

				var_480_6.z = 0
				var_480_6.x = 0
				var_480_0.localEulerAngles = var_480_6
			end

			if arg_477_1.time_ >= var_480_1 + var_480_2 and arg_477_1.time_ < var_480_1 + var_480_2 + arg_480_0 then
				var_480_0.localPosition = Vector3.New(0, -1.2, -6)

				local var_480_7 = manager.ui.mainCamera.transform.position - var_480_0.position

				var_480_0.forward = Vector3.New(var_480_7.x, var_480_7.y, var_480_7.z)

				local var_480_8 = var_480_0.localEulerAngles

				var_480_8.z = 0
				var_480_8.x = 0
				var_480_0.localEulerAngles = var_480_8
			end

			local var_480_9 = arg_477_1.actors_["1049ui_story"]
			local var_480_10 = 0

			if var_480_10 < arg_477_1.time_ and arg_477_1.time_ <= var_480_10 + arg_480_0 and not isNil(var_480_9) and arg_477_1.var_.characterEffect1049ui_story == nil then
				arg_477_1.var_.characterEffect1049ui_story = var_480_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_480_11 = 0.200000002980232

			if var_480_10 <= arg_477_1.time_ and arg_477_1.time_ < var_480_10 + var_480_11 and not isNil(var_480_9) then
				local var_480_12 = (arg_477_1.time_ - var_480_10) / var_480_11

				if arg_477_1.var_.characterEffect1049ui_story and not isNil(var_480_9) then
					arg_477_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_477_1.time_ >= var_480_10 + var_480_11 and arg_477_1.time_ < var_480_10 + var_480_11 + arg_480_0 and not isNil(var_480_9) and arg_477_1.var_.characterEffect1049ui_story then
				arg_477_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_480_13 = 0

			if var_480_13 < arg_477_1.time_ and arg_477_1.time_ <= var_480_13 + arg_480_0 then
				arg_477_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action4_2")
			end

			local var_480_14 = 0

			if var_480_14 < arg_477_1.time_ and arg_477_1.time_ <= var_480_14 + arg_480_0 then
				arg_477_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_480_15 = 0
			local var_480_16 = 0.475

			if var_480_15 < arg_477_1.time_ and arg_477_1.time_ <= var_480_15 + arg_480_0 then
				arg_477_1.talkMaxDuration = 0
				arg_477_1.dialogCg_.alpha = 1

				arg_477_1.dialog_:SetActive(true)
				SetActive(arg_477_1.leftNameGo_, true)

				local var_480_17 = arg_477_1:FormatText(StoryNameCfg[551].name)

				arg_477_1.leftNameTxt_.text = var_480_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_477_1.leftNameTxt_.transform)

				arg_477_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_477_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_477_1:RecordName(arg_477_1.leftNameTxt_.text)
				SetActive(arg_477_1.iconTrs_.gameObject, false)
				arg_477_1.callingController_:SetSelectedState("normal")

				local var_480_18 = arg_477_1:GetWordFromCfg(1104902116)
				local var_480_19 = arg_477_1:FormatText(var_480_18.content)

				arg_477_1.text_.text = var_480_19

				LuaForUtil.ClearLinePrefixSymbol(arg_477_1.text_)

				local var_480_20 = 19
				local var_480_21 = utf8.len(var_480_19)
				local var_480_22 = var_480_20 <= 0 and var_480_16 or var_480_16 * (var_480_21 / var_480_20)

				if var_480_22 > 0 and var_480_16 < var_480_22 then
					arg_477_1.talkMaxDuration = var_480_22

					if var_480_22 + var_480_15 > arg_477_1.duration_ then
						arg_477_1.duration_ = var_480_22 + var_480_15
					end
				end

				arg_477_1.text_.text = var_480_19
				arg_477_1.typewritter.percent = 0

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104902", "1104902116", "story_v_side_new_1104902.awb") ~= 0 then
					local var_480_23 = manager.audio:GetVoiceLength("story_v_side_new_1104902", "1104902116", "story_v_side_new_1104902.awb") / 1000

					if var_480_23 + var_480_15 > arg_477_1.duration_ then
						arg_477_1.duration_ = var_480_23 + var_480_15
					end

					if var_480_18.prefab_name ~= "" and arg_477_1.actors_[var_480_18.prefab_name] ~= nil then
						local var_480_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_477_1.actors_[var_480_18.prefab_name].transform, "story_v_side_new_1104902", "1104902116", "story_v_side_new_1104902.awb")

						arg_477_1:RecordAudio("1104902116", var_480_24)
						arg_477_1:RecordAudio("1104902116", var_480_24)
					else
						arg_477_1:AudioAction("play", "voice", "story_v_side_new_1104902", "1104902116", "story_v_side_new_1104902.awb")
					end

					arg_477_1:RecordHistoryTalkVoice("story_v_side_new_1104902", "1104902116", "story_v_side_new_1104902.awb")
				end

				arg_477_1:RecordContent(arg_477_1.text_.text)
			end

			local var_480_25 = math.max(var_480_16, arg_477_1.talkMaxDuration)

			if var_480_15 <= arg_477_1.time_ and arg_477_1.time_ < var_480_15 + var_480_25 then
				arg_477_1.typewritter.percent = (arg_477_1.time_ - var_480_15) / var_480_25

				arg_477_1.typewritter:SetDirty()
			end

			if arg_477_1.time_ >= var_480_15 + var_480_25 and arg_477_1.time_ < var_480_15 + var_480_25 + arg_480_0 then
				arg_477_1.typewritter.percent = 1

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(true)
			end
		end

		arg_477_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
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
	Play1104902117 = function(arg_481_0, arg_481_1)
		arg_481_1.time_ = 0
		arg_481_1.frameCnt_ = 0
		arg_481_1.state_ = "playing"
		arg_481_1.curTalkId_ = 1104902117
		arg_481_1.duration_ = 1.7

		local var_481_0 = {
			zh = 1.166,
			ja = 1.7
		}
		local var_481_1 = manager.audio:GetLocalizationFlag()

		if var_481_0[var_481_1] ~= nil then
			arg_481_1.duration_ = var_481_0[var_481_1]
		end

		SetActive(arg_481_1.tipsGo_, false)

		function arg_481_1.onSingleLineFinish_()
			arg_481_1.onSingleLineUpdate_ = nil
			arg_481_1.onSingleLineFinish_ = nil
			arg_481_1.state_ = "waiting"
		end

		function arg_481_1.playNext_(arg_483_0)
			if arg_483_0 == 1 then
				arg_481_0:Play1104902118(arg_481_1)
			end
		end

		function arg_481_1.onSingleLineUpdate_(arg_484_0)
			local var_484_0 = arg_481_1.actors_["1049ui_story"]
			local var_484_1 = 0

			if var_484_1 < arg_481_1.time_ and arg_481_1.time_ <= var_484_1 + arg_484_0 and not isNil(var_484_0) and arg_481_1.var_.characterEffect1049ui_story == nil then
				arg_481_1.var_.characterEffect1049ui_story = var_484_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_484_2 = 0.200000002980232

			if var_484_1 <= arg_481_1.time_ and arg_481_1.time_ < var_484_1 + var_484_2 and not isNil(var_484_0) then
				local var_484_3 = (arg_481_1.time_ - var_484_1) / var_484_2

				if arg_481_1.var_.characterEffect1049ui_story and not isNil(var_484_0) then
					local var_484_4 = Mathf.Lerp(0, 0.5, var_484_3)

					arg_481_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_481_1.var_.characterEffect1049ui_story.fillRatio = var_484_4
				end
			end

			if arg_481_1.time_ >= var_484_1 + var_484_2 and arg_481_1.time_ < var_484_1 + var_484_2 + arg_484_0 and not isNil(var_484_0) and arg_481_1.var_.characterEffect1049ui_story then
				local var_484_5 = 0.5

				arg_481_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_481_1.var_.characterEffect1049ui_story.fillRatio = var_484_5
			end

			local var_484_6 = 0
			local var_484_7 = 0.05

			if var_484_6 < arg_481_1.time_ and arg_481_1.time_ <= var_484_6 + arg_484_0 then
				arg_481_1.talkMaxDuration = 0
				arg_481_1.dialogCg_.alpha = 1

				arg_481_1.dialog_:SetActive(true)
				SetActive(arg_481_1.leftNameGo_, true)

				local var_484_8 = arg_481_1:FormatText(StoryNameCfg[1008].name)

				arg_481_1.leftNameTxt_.text = var_484_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_481_1.leftNameTxt_.transform)

				arg_481_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_481_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_481_1:RecordName(arg_481_1.leftNameTxt_.text)
				SetActive(arg_481_1.iconTrs_.gameObject, true)
				arg_481_1.iconController_:SetSelectedState("hero")

				arg_481_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10119")

				arg_481_1.callingController_:SetSelectedState("normal")

				arg_481_1.keyicon_.color = Color.New(1, 1, 1)
				arg_481_1.icon_.color = Color.New(1, 1, 1)

				local var_484_9 = arg_481_1:GetWordFromCfg(1104902117)
				local var_484_10 = arg_481_1:FormatText(var_484_9.content)

				arg_481_1.text_.text = var_484_10

				LuaForUtil.ClearLinePrefixSymbol(arg_481_1.text_)

				local var_484_11 = 2
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

				if manager.audio:GetVoiceLength("story_v_side_new_1104902", "1104902117", "story_v_side_new_1104902.awb") ~= 0 then
					local var_484_14 = manager.audio:GetVoiceLength("story_v_side_new_1104902", "1104902117", "story_v_side_new_1104902.awb") / 1000

					if var_484_14 + var_484_6 > arg_481_1.duration_ then
						arg_481_1.duration_ = var_484_14 + var_484_6
					end

					if var_484_9.prefab_name ~= "" and arg_481_1.actors_[var_484_9.prefab_name] ~= nil then
						local var_484_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_481_1.actors_[var_484_9.prefab_name].transform, "story_v_side_new_1104902", "1104902117", "story_v_side_new_1104902.awb")

						arg_481_1:RecordAudio("1104902117", var_484_15)
						arg_481_1:RecordAudio("1104902117", var_484_15)
					else
						arg_481_1:AudioAction("play", "voice", "story_v_side_new_1104902", "1104902117", "story_v_side_new_1104902.awb")
					end

					arg_481_1:RecordHistoryTalkVoice("story_v_side_new_1104902", "1104902117", "story_v_side_new_1104902.awb")
				end

				arg_481_1:RecordContent(arg_481_1.text_.text)
			end

			local var_484_16 = math.max(var_484_7, arg_481_1.talkMaxDuration)

			if var_484_6 <= arg_481_1.time_ and arg_481_1.time_ < var_484_6 + var_484_16 then
				arg_481_1.typewritter.percent = (arg_481_1.time_ - var_484_6) / var_484_16

				arg_481_1.typewritter:SetDirty()
			end

			if arg_481_1.time_ >= var_484_6 + var_484_16 and arg_481_1.time_ < var_484_6 + var_484_16 + arg_484_0 then
				arg_481_1.typewritter.percent = 1

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(true)
			end
		end

		arg_481_1.nodeConfigList_ = {}

		arg_481_1:InitPlayNodeList()
	end,
	Play1104902118 = function(arg_485_0, arg_485_1)
		arg_485_1.time_ = 0
		arg_485_1.frameCnt_ = 0
		arg_485_1.state_ = "playing"
		arg_485_1.curTalkId_ = 1104902118
		arg_485_1.duration_ = 5

		SetActive(arg_485_1.tipsGo_, false)

		function arg_485_1.onSingleLineFinish_()
			arg_485_1.onSingleLineUpdate_ = nil
			arg_485_1.onSingleLineFinish_ = nil
			arg_485_1.state_ = "waiting"
		end

		function arg_485_1.playNext_(arg_487_0)
			if arg_487_0 == 1 then
				arg_485_0:Play1104902119(arg_485_1)
			end
		end

		function arg_485_1.onSingleLineUpdate_(arg_488_0)
			local var_488_0 = arg_485_1.actors_["1049ui_story"].transform
			local var_488_1 = 0

			if var_488_1 < arg_485_1.time_ and arg_485_1.time_ <= var_488_1 + arg_488_0 then
				arg_485_1.var_.moveOldPos1049ui_story = var_488_0.localPosition
			end

			local var_488_2 = 0.001

			if var_488_1 <= arg_485_1.time_ and arg_485_1.time_ < var_488_1 + var_488_2 then
				local var_488_3 = (arg_485_1.time_ - var_488_1) / var_488_2
				local var_488_4 = Vector3.New(0, 100, 0)

				var_488_0.localPosition = Vector3.Lerp(arg_485_1.var_.moveOldPos1049ui_story, var_488_4, var_488_3)

				local var_488_5 = manager.ui.mainCamera.transform.position - var_488_0.position

				var_488_0.forward = Vector3.New(var_488_5.x, var_488_5.y, var_488_5.z)

				local var_488_6 = var_488_0.localEulerAngles

				var_488_6.z = 0
				var_488_6.x = 0
				var_488_0.localEulerAngles = var_488_6
			end

			if arg_485_1.time_ >= var_488_1 + var_488_2 and arg_485_1.time_ < var_488_1 + var_488_2 + arg_488_0 then
				var_488_0.localPosition = Vector3.New(0, 100, 0)

				local var_488_7 = manager.ui.mainCamera.transform.position - var_488_0.position

				var_488_0.forward = Vector3.New(var_488_7.x, var_488_7.y, var_488_7.z)

				local var_488_8 = var_488_0.localEulerAngles

				var_488_8.z = 0
				var_488_8.x = 0
				var_488_0.localEulerAngles = var_488_8
			end

			local var_488_9 = arg_485_1.actors_["1049ui_story"]
			local var_488_10 = 0

			if var_488_10 < arg_485_1.time_ and arg_485_1.time_ <= var_488_10 + arg_488_0 and not isNil(var_488_9) and arg_485_1.var_.characterEffect1049ui_story == nil then
				arg_485_1.var_.characterEffect1049ui_story = var_488_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_488_11 = 0.200000002980232

			if var_488_10 <= arg_485_1.time_ and arg_485_1.time_ < var_488_10 + var_488_11 and not isNil(var_488_9) then
				local var_488_12 = (arg_485_1.time_ - var_488_10) / var_488_11

				if arg_485_1.var_.characterEffect1049ui_story and not isNil(var_488_9) then
					local var_488_13 = Mathf.Lerp(0, 0.5, var_488_12)

					arg_485_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_485_1.var_.characterEffect1049ui_story.fillRatio = var_488_13
				end
			end

			if arg_485_1.time_ >= var_488_10 + var_488_11 and arg_485_1.time_ < var_488_10 + var_488_11 + arg_488_0 and not isNil(var_488_9) and arg_485_1.var_.characterEffect1049ui_story then
				local var_488_14 = 0.5

				arg_485_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_485_1.var_.characterEffect1049ui_story.fillRatio = var_488_14
			end

			local var_488_15 = 0
			local var_488_16 = 0.8

			if var_488_15 < arg_485_1.time_ and arg_485_1.time_ <= var_488_15 + arg_488_0 then
				arg_485_1.talkMaxDuration = 0
				arg_485_1.dialogCg_.alpha = 1

				arg_485_1.dialog_:SetActive(true)
				SetActive(arg_485_1.leftNameGo_, false)

				arg_485_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_485_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_485_1:RecordName(arg_485_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_485_1.iconTrs_.gameObject, false)
				arg_485_1.callingController_:SetSelectedState("normal")

				local var_488_17 = arg_485_1:GetWordFromCfg(1104902118)
				local var_488_18 = arg_485_1:FormatText(var_488_17.content)

				arg_485_1.text_.text = var_488_18

				LuaForUtil.ClearLinePrefixSymbol(arg_485_1.text_)

				local var_488_19 = 32
				local var_488_20 = utf8.len(var_488_18)
				local var_488_21 = var_488_19 <= 0 and var_488_16 or var_488_16 * (var_488_20 / var_488_19)

				if var_488_21 > 0 and var_488_16 < var_488_21 then
					arg_485_1.talkMaxDuration = var_488_21

					if var_488_21 + var_488_15 > arg_485_1.duration_ then
						arg_485_1.duration_ = var_488_21 + var_488_15
					end
				end

				arg_485_1.text_.text = var_488_18
				arg_485_1.typewritter.percent = 0

				arg_485_1.typewritter:SetDirty()
				arg_485_1:ShowNextGo(false)
				arg_485_1:RecordContent(arg_485_1.text_.text)
			end

			local var_488_22 = math.max(var_488_16, arg_485_1.talkMaxDuration)

			if var_488_15 <= arg_485_1.time_ and arg_485_1.time_ < var_488_15 + var_488_22 then
				arg_485_1.typewritter.percent = (arg_485_1.time_ - var_488_15) / var_488_22

				arg_485_1.typewritter:SetDirty()
			end

			if arg_485_1.time_ >= var_488_15 + var_488_22 and arg_485_1.time_ < var_488_15 + var_488_22 + arg_488_0 then
				arg_485_1.typewritter.percent = 1

				arg_485_1.typewritter:SetDirty()
				arg_485_1:ShowNextGo(true)
			end
		end

		arg_485_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_485_1:InitPlayNodeList()
	end,
	Play1104902119 = function(arg_489_0, arg_489_1)
		arg_489_1.time_ = 0
		arg_489_1.frameCnt_ = 0
		arg_489_1.state_ = "playing"
		arg_489_1.curTalkId_ = 1104902119
		arg_489_1.duration_ = 5

		SetActive(arg_489_1.tipsGo_, false)

		function arg_489_1.onSingleLineFinish_()
			arg_489_1.onSingleLineUpdate_ = nil
			arg_489_1.onSingleLineFinish_ = nil
			arg_489_1.state_ = "waiting"
		end

		function arg_489_1.playNext_(arg_491_0)
			if arg_491_0 == 1 then
				arg_489_0:Play1104902120(arg_489_1)
			end
		end

		function arg_489_1.onSingleLineUpdate_(arg_492_0)
			local var_492_0 = 0
			local var_492_1 = 0.85

			if var_492_0 < arg_489_1.time_ and arg_489_1.time_ <= var_492_0 + arg_492_0 then
				arg_489_1.talkMaxDuration = 0
				arg_489_1.dialogCg_.alpha = 1

				arg_489_1.dialog_:SetActive(true)
				SetActive(arg_489_1.leftNameGo_, false)

				arg_489_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_489_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_489_1:RecordName(arg_489_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_489_1.iconTrs_.gameObject, false)
				arg_489_1.callingController_:SetSelectedState("normal")

				local var_492_2 = arg_489_1:GetWordFromCfg(1104902119)
				local var_492_3 = arg_489_1:FormatText(var_492_2.content)

				arg_489_1.text_.text = var_492_3

				LuaForUtil.ClearLinePrefixSymbol(arg_489_1.text_)

				local var_492_4 = 34
				local var_492_5 = utf8.len(var_492_3)
				local var_492_6 = var_492_4 <= 0 and var_492_1 or var_492_1 * (var_492_5 / var_492_4)

				if var_492_6 > 0 and var_492_1 < var_492_6 then
					arg_489_1.talkMaxDuration = var_492_6

					if var_492_6 + var_492_0 > arg_489_1.duration_ then
						arg_489_1.duration_ = var_492_6 + var_492_0
					end
				end

				arg_489_1.text_.text = var_492_3
				arg_489_1.typewritter.percent = 0

				arg_489_1.typewritter:SetDirty()
				arg_489_1:ShowNextGo(false)
				arg_489_1:RecordContent(arg_489_1.text_.text)
			end

			local var_492_7 = math.max(var_492_1, arg_489_1.talkMaxDuration)

			if var_492_0 <= arg_489_1.time_ and arg_489_1.time_ < var_492_0 + var_492_7 then
				arg_489_1.typewritter.percent = (arg_489_1.time_ - var_492_0) / var_492_7

				arg_489_1.typewritter:SetDirty()
			end

			if arg_489_1.time_ >= var_492_0 + var_492_7 and arg_489_1.time_ < var_492_0 + var_492_7 + arg_492_0 then
				arg_489_1.typewritter.percent = 1

				arg_489_1.typewritter:SetDirty()
				arg_489_1:ShowNextGo(true)
			end
		end

		arg_489_1.nodeConfigList_ = {}

		arg_489_1:InitPlayNodeList()
	end,
	Play1104902120 = function(arg_493_0, arg_493_1)
		arg_493_1.time_ = 0
		arg_493_1.frameCnt_ = 0
		arg_493_1.state_ = "playing"
		arg_493_1.curTalkId_ = 1104902120
		arg_493_1.duration_ = 7.1

		local var_493_0 = {
			zh = 7.1,
			ja = 6.7
		}
		local var_493_1 = manager.audio:GetLocalizationFlag()

		if var_493_0[var_493_1] ~= nil then
			arg_493_1.duration_ = var_493_0[var_493_1]
		end

		SetActive(arg_493_1.tipsGo_, false)

		function arg_493_1.onSingleLineFinish_()
			arg_493_1.onSingleLineUpdate_ = nil
			arg_493_1.onSingleLineFinish_ = nil
			arg_493_1.state_ = "waiting"
		end

		function arg_493_1.playNext_(arg_495_0)
			if arg_495_0 == 1 then
				arg_493_0:Play1104902121(arg_493_1)
			end
		end

		function arg_493_1.onSingleLineUpdate_(arg_496_0)
			local var_496_0 = arg_493_1.actors_["1049ui_story"].transform
			local var_496_1 = 0

			if var_496_1 < arg_493_1.time_ and arg_493_1.time_ <= var_496_1 + arg_496_0 then
				arg_493_1.var_.moveOldPos1049ui_story = var_496_0.localPosition
			end

			local var_496_2 = 0.001

			if var_496_1 <= arg_493_1.time_ and arg_493_1.time_ < var_496_1 + var_496_2 then
				local var_496_3 = (arg_493_1.time_ - var_496_1) / var_496_2
				local var_496_4 = Vector3.New(0, -1.2, -6)

				var_496_0.localPosition = Vector3.Lerp(arg_493_1.var_.moveOldPos1049ui_story, var_496_4, var_496_3)

				local var_496_5 = manager.ui.mainCamera.transform.position - var_496_0.position

				var_496_0.forward = Vector3.New(var_496_5.x, var_496_5.y, var_496_5.z)

				local var_496_6 = var_496_0.localEulerAngles

				var_496_6.z = 0
				var_496_6.x = 0
				var_496_0.localEulerAngles = var_496_6
			end

			if arg_493_1.time_ >= var_496_1 + var_496_2 and arg_493_1.time_ < var_496_1 + var_496_2 + arg_496_0 then
				var_496_0.localPosition = Vector3.New(0, -1.2, -6)

				local var_496_7 = manager.ui.mainCamera.transform.position - var_496_0.position

				var_496_0.forward = Vector3.New(var_496_7.x, var_496_7.y, var_496_7.z)

				local var_496_8 = var_496_0.localEulerAngles

				var_496_8.z = 0
				var_496_8.x = 0
				var_496_0.localEulerAngles = var_496_8
			end

			local var_496_9 = arg_493_1.actors_["1049ui_story"]
			local var_496_10 = 0

			if var_496_10 < arg_493_1.time_ and arg_493_1.time_ <= var_496_10 + arg_496_0 and not isNil(var_496_9) and arg_493_1.var_.characterEffect1049ui_story == nil then
				arg_493_1.var_.characterEffect1049ui_story = var_496_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_496_11 = 0.200000002980232

			if var_496_10 <= arg_493_1.time_ and arg_493_1.time_ < var_496_10 + var_496_11 and not isNil(var_496_9) then
				local var_496_12 = (arg_493_1.time_ - var_496_10) / var_496_11

				if arg_493_1.var_.characterEffect1049ui_story and not isNil(var_496_9) then
					arg_493_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_493_1.time_ >= var_496_10 + var_496_11 and arg_493_1.time_ < var_496_10 + var_496_11 + arg_496_0 and not isNil(var_496_9) and arg_493_1.var_.characterEffect1049ui_story then
				arg_493_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_496_13 = 0

			if var_496_13 < arg_493_1.time_ and arg_493_1.time_ <= var_496_13 + arg_496_0 then
				arg_493_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action1_1")
			end

			local var_496_14 = 0

			if var_496_14 < arg_493_1.time_ and arg_493_1.time_ <= var_496_14 + arg_496_0 then
				arg_493_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_496_15 = 0
			local var_496_16 = 0.725

			if var_496_15 < arg_493_1.time_ and arg_493_1.time_ <= var_496_15 + arg_496_0 then
				arg_493_1.talkMaxDuration = 0
				arg_493_1.dialogCg_.alpha = 1

				arg_493_1.dialog_:SetActive(true)
				SetActive(arg_493_1.leftNameGo_, true)

				local var_496_17 = arg_493_1:FormatText(StoryNameCfg[551].name)

				arg_493_1.leftNameTxt_.text = var_496_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_493_1.leftNameTxt_.transform)

				arg_493_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_493_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_493_1:RecordName(arg_493_1.leftNameTxt_.text)
				SetActive(arg_493_1.iconTrs_.gameObject, false)
				arg_493_1.callingController_:SetSelectedState("normal")

				local var_496_18 = arg_493_1:GetWordFromCfg(1104902120)
				local var_496_19 = arg_493_1:FormatText(var_496_18.content)

				arg_493_1.text_.text = var_496_19

				LuaForUtil.ClearLinePrefixSymbol(arg_493_1.text_)

				local var_496_20 = 29
				local var_496_21 = utf8.len(var_496_19)
				local var_496_22 = var_496_20 <= 0 and var_496_16 or var_496_16 * (var_496_21 / var_496_20)

				if var_496_22 > 0 and var_496_16 < var_496_22 then
					arg_493_1.talkMaxDuration = var_496_22

					if var_496_22 + var_496_15 > arg_493_1.duration_ then
						arg_493_1.duration_ = var_496_22 + var_496_15
					end
				end

				arg_493_1.text_.text = var_496_19
				arg_493_1.typewritter.percent = 0

				arg_493_1.typewritter:SetDirty()
				arg_493_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104902", "1104902120", "story_v_side_new_1104902.awb") ~= 0 then
					local var_496_23 = manager.audio:GetVoiceLength("story_v_side_new_1104902", "1104902120", "story_v_side_new_1104902.awb") / 1000

					if var_496_23 + var_496_15 > arg_493_1.duration_ then
						arg_493_1.duration_ = var_496_23 + var_496_15
					end

					if var_496_18.prefab_name ~= "" and arg_493_1.actors_[var_496_18.prefab_name] ~= nil then
						local var_496_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_493_1.actors_[var_496_18.prefab_name].transform, "story_v_side_new_1104902", "1104902120", "story_v_side_new_1104902.awb")

						arg_493_1:RecordAudio("1104902120", var_496_24)
						arg_493_1:RecordAudio("1104902120", var_496_24)
					else
						arg_493_1:AudioAction("play", "voice", "story_v_side_new_1104902", "1104902120", "story_v_side_new_1104902.awb")
					end

					arg_493_1:RecordHistoryTalkVoice("story_v_side_new_1104902", "1104902120", "story_v_side_new_1104902.awb")
				end

				arg_493_1:RecordContent(arg_493_1.text_.text)
			end

			local var_496_25 = math.max(var_496_16, arg_493_1.talkMaxDuration)

			if var_496_15 <= arg_493_1.time_ and arg_493_1.time_ < var_496_15 + var_496_25 then
				arg_493_1.typewritter.percent = (arg_493_1.time_ - var_496_15) / var_496_25

				arg_493_1.typewritter:SetDirty()
			end

			if arg_493_1.time_ >= var_496_15 + var_496_25 and arg_493_1.time_ < var_496_15 + var_496_25 + arg_496_0 then
				arg_493_1.typewritter.percent = 1

				arg_493_1.typewritter:SetDirty()
				arg_493_1:ShowNextGo(true)
			end
		end

		arg_493_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_493_1:InitPlayNodeList()
	end,
	Play1104902121 = function(arg_497_0, arg_497_1)
		arg_497_1.time_ = 0
		arg_497_1.frameCnt_ = 0
		arg_497_1.state_ = "playing"
		arg_497_1.curTalkId_ = 1104902121
		arg_497_1.duration_ = 7.73

		local var_497_0 = {
			zh = 5.7,
			ja = 7.733
		}
		local var_497_1 = manager.audio:GetLocalizationFlag()

		if var_497_0[var_497_1] ~= nil then
			arg_497_1.duration_ = var_497_0[var_497_1]
		end

		SetActive(arg_497_1.tipsGo_, false)

		function arg_497_1.onSingleLineFinish_()
			arg_497_1.onSingleLineUpdate_ = nil
			arg_497_1.onSingleLineFinish_ = nil
			arg_497_1.state_ = "waiting"
		end

		function arg_497_1.playNext_(arg_499_0)
			if arg_499_0 == 1 then
				arg_497_0:Play1104902122(arg_497_1)
			end
		end

		function arg_497_1.onSingleLineUpdate_(arg_500_0)
			local var_500_0 = 0
			local var_500_1 = 0.5

			if var_500_0 < arg_497_1.time_ and arg_497_1.time_ <= var_500_0 + arg_500_0 then
				arg_497_1.talkMaxDuration = 0
				arg_497_1.dialogCg_.alpha = 1

				arg_497_1.dialog_:SetActive(true)
				SetActive(arg_497_1.leftNameGo_, true)

				local var_500_2 = arg_497_1:FormatText(StoryNameCfg[551].name)

				arg_497_1.leftNameTxt_.text = var_500_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_497_1.leftNameTxt_.transform)

				arg_497_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_497_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_497_1:RecordName(arg_497_1.leftNameTxt_.text)
				SetActive(arg_497_1.iconTrs_.gameObject, false)
				arg_497_1.callingController_:SetSelectedState("normal")

				local var_500_3 = arg_497_1:GetWordFromCfg(1104902121)
				local var_500_4 = arg_497_1:FormatText(var_500_3.content)

				arg_497_1.text_.text = var_500_4

				LuaForUtil.ClearLinePrefixSymbol(arg_497_1.text_)

				local var_500_5 = 20
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

				if manager.audio:GetVoiceLength("story_v_side_new_1104902", "1104902121", "story_v_side_new_1104902.awb") ~= 0 then
					local var_500_8 = manager.audio:GetVoiceLength("story_v_side_new_1104902", "1104902121", "story_v_side_new_1104902.awb") / 1000

					if var_500_8 + var_500_0 > arg_497_1.duration_ then
						arg_497_1.duration_ = var_500_8 + var_500_0
					end

					if var_500_3.prefab_name ~= "" and arg_497_1.actors_[var_500_3.prefab_name] ~= nil then
						local var_500_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_497_1.actors_[var_500_3.prefab_name].transform, "story_v_side_new_1104902", "1104902121", "story_v_side_new_1104902.awb")

						arg_497_1:RecordAudio("1104902121", var_500_9)
						arg_497_1:RecordAudio("1104902121", var_500_9)
					else
						arg_497_1:AudioAction("play", "voice", "story_v_side_new_1104902", "1104902121", "story_v_side_new_1104902.awb")
					end

					arg_497_1:RecordHistoryTalkVoice("story_v_side_new_1104902", "1104902121", "story_v_side_new_1104902.awb")
				end

				arg_497_1:RecordContent(arg_497_1.text_.text)
			end

			local var_500_10 = math.max(var_500_1, arg_497_1.talkMaxDuration)

			if var_500_0 <= arg_497_1.time_ and arg_497_1.time_ < var_500_0 + var_500_10 then
				arg_497_1.typewritter.percent = (arg_497_1.time_ - var_500_0) / var_500_10

				arg_497_1.typewritter:SetDirty()
			end

			if arg_497_1.time_ >= var_500_0 + var_500_10 and arg_497_1.time_ < var_500_0 + var_500_10 + arg_500_0 then
				arg_497_1.typewritter.percent = 1

				arg_497_1.typewritter:SetDirty()
				arg_497_1:ShowNextGo(true)
			end
		end

		arg_497_1.nodeConfigList_ = {}

		arg_497_1:InitPlayNodeList()
	end,
	Play1104902122 = function(arg_501_0, arg_501_1)
		arg_501_1.time_ = 0
		arg_501_1.frameCnt_ = 0
		arg_501_1.state_ = "playing"
		arg_501_1.curTalkId_ = 1104902122
		arg_501_1.duration_ = 10.53

		local var_501_0 = {
			zh = 10.533,
			ja = 8.2
		}
		local var_501_1 = manager.audio:GetLocalizationFlag()

		if var_501_0[var_501_1] ~= nil then
			arg_501_1.duration_ = var_501_0[var_501_1]
		end

		SetActive(arg_501_1.tipsGo_, false)

		function arg_501_1.onSingleLineFinish_()
			arg_501_1.onSingleLineUpdate_ = nil
			arg_501_1.onSingleLineFinish_ = nil
			arg_501_1.state_ = "waiting"
		end

		function arg_501_1.playNext_(arg_503_0)
			if arg_503_0 == 1 then
				arg_501_0:Play1104902123(arg_501_1)
			end
		end

		function arg_501_1.onSingleLineUpdate_(arg_504_0)
			local var_504_0 = 0

			if var_504_0 < arg_501_1.time_ and arg_501_1.time_ <= var_504_0 + arg_504_0 then
				arg_501_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story104901/story1049action/1049action2_1")
			end

			local var_504_1 = 0

			if var_504_1 < arg_501_1.time_ and arg_501_1.time_ <= var_504_1 + arg_504_0 then
				arg_501_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_504_2 = 0
			local var_504_3 = 1.275

			if var_504_2 < arg_501_1.time_ and arg_501_1.time_ <= var_504_2 + arg_504_0 then
				arg_501_1.talkMaxDuration = 0
				arg_501_1.dialogCg_.alpha = 1

				arg_501_1.dialog_:SetActive(true)
				SetActive(arg_501_1.leftNameGo_, true)

				local var_504_4 = arg_501_1:FormatText(StoryNameCfg[551].name)

				arg_501_1.leftNameTxt_.text = var_504_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_501_1.leftNameTxt_.transform)

				arg_501_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_501_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_501_1:RecordName(arg_501_1.leftNameTxt_.text)
				SetActive(arg_501_1.iconTrs_.gameObject, false)
				arg_501_1.callingController_:SetSelectedState("normal")

				local var_504_5 = arg_501_1:GetWordFromCfg(1104902122)
				local var_504_6 = arg_501_1:FormatText(var_504_5.content)

				arg_501_1.text_.text = var_504_6

				LuaForUtil.ClearLinePrefixSymbol(arg_501_1.text_)

				local var_504_7 = 51
				local var_504_8 = utf8.len(var_504_6)
				local var_504_9 = var_504_7 <= 0 and var_504_3 or var_504_3 * (var_504_8 / var_504_7)

				if var_504_9 > 0 and var_504_3 < var_504_9 then
					arg_501_1.talkMaxDuration = var_504_9

					if var_504_9 + var_504_2 > arg_501_1.duration_ then
						arg_501_1.duration_ = var_504_9 + var_504_2
					end
				end

				arg_501_1.text_.text = var_504_6
				arg_501_1.typewritter.percent = 0

				arg_501_1.typewritter:SetDirty()
				arg_501_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104902", "1104902122", "story_v_side_new_1104902.awb") ~= 0 then
					local var_504_10 = manager.audio:GetVoiceLength("story_v_side_new_1104902", "1104902122", "story_v_side_new_1104902.awb") / 1000

					if var_504_10 + var_504_2 > arg_501_1.duration_ then
						arg_501_1.duration_ = var_504_10 + var_504_2
					end

					if var_504_5.prefab_name ~= "" and arg_501_1.actors_[var_504_5.prefab_name] ~= nil then
						local var_504_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_501_1.actors_[var_504_5.prefab_name].transform, "story_v_side_new_1104902", "1104902122", "story_v_side_new_1104902.awb")

						arg_501_1:RecordAudio("1104902122", var_504_11)
						arg_501_1:RecordAudio("1104902122", var_504_11)
					else
						arg_501_1:AudioAction("play", "voice", "story_v_side_new_1104902", "1104902122", "story_v_side_new_1104902.awb")
					end

					arg_501_1:RecordHistoryTalkVoice("story_v_side_new_1104902", "1104902122", "story_v_side_new_1104902.awb")
				end

				arg_501_1:RecordContent(arg_501_1.text_.text)
			end

			local var_504_12 = math.max(var_504_3, arg_501_1.talkMaxDuration)

			if var_504_2 <= arg_501_1.time_ and arg_501_1.time_ < var_504_2 + var_504_12 then
				arg_501_1.typewritter.percent = (arg_501_1.time_ - var_504_2) / var_504_12

				arg_501_1.typewritter:SetDirty()
			end

			if arg_501_1.time_ >= var_504_2 + var_504_12 and arg_501_1.time_ < var_504_2 + var_504_12 + arg_504_0 then
				arg_501_1.typewritter.percent = 1

				arg_501_1.typewritter:SetDirty()
				arg_501_1:ShowNextGo(true)
			end
		end

		arg_501_1.nodeConfigList_ = {}

		arg_501_1:InitPlayNodeList()
	end,
	Play1104902123 = function(arg_505_0, arg_505_1)
		arg_505_1.time_ = 0
		arg_505_1.frameCnt_ = 0
		arg_505_1.state_ = "playing"
		arg_505_1.curTalkId_ = 1104902123
		arg_505_1.duration_ = 5

		SetActive(arg_505_1.tipsGo_, false)

		function arg_505_1.onSingleLineFinish_()
			arg_505_1.onSingleLineUpdate_ = nil
			arg_505_1.onSingleLineFinish_ = nil
			arg_505_1.state_ = "waiting"
		end

		function arg_505_1.playNext_(arg_507_0)
			if arg_507_0 == 1 then
				arg_505_0:Play1104902124(arg_505_1)
			end
		end

		function arg_505_1.onSingleLineUpdate_(arg_508_0)
			local var_508_0 = arg_505_1.actors_["1049ui_story"]
			local var_508_1 = 0

			if var_508_1 < arg_505_1.time_ and arg_505_1.time_ <= var_508_1 + arg_508_0 and not isNil(var_508_0) and arg_505_1.var_.characterEffect1049ui_story == nil then
				arg_505_1.var_.characterEffect1049ui_story = var_508_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_508_2 = 0.200000002980232

			if var_508_1 <= arg_505_1.time_ and arg_505_1.time_ < var_508_1 + var_508_2 and not isNil(var_508_0) then
				local var_508_3 = (arg_505_1.time_ - var_508_1) / var_508_2

				if arg_505_1.var_.characterEffect1049ui_story and not isNil(var_508_0) then
					local var_508_4 = Mathf.Lerp(0, 0.5, var_508_3)

					arg_505_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_505_1.var_.characterEffect1049ui_story.fillRatio = var_508_4
				end
			end

			if arg_505_1.time_ >= var_508_1 + var_508_2 and arg_505_1.time_ < var_508_1 + var_508_2 + arg_508_0 and not isNil(var_508_0) and arg_505_1.var_.characterEffect1049ui_story then
				local var_508_5 = 0.5

				arg_505_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_505_1.var_.characterEffect1049ui_story.fillRatio = var_508_5
			end

			local var_508_6 = 0
			local var_508_7 = 0.05

			if var_508_6 < arg_505_1.time_ and arg_505_1.time_ <= var_508_6 + arg_508_0 then
				arg_505_1.talkMaxDuration = 0
				arg_505_1.dialogCg_.alpha = 1

				arg_505_1.dialog_:SetActive(true)
				SetActive(arg_505_1.leftNameGo_, true)

				local var_508_8 = arg_505_1:FormatText(StoryNameCfg[7].name)

				arg_505_1.leftNameTxt_.text = var_508_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_505_1.leftNameTxt_.transform)

				arg_505_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_505_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_505_1:RecordName(arg_505_1.leftNameTxt_.text)
				SetActive(arg_505_1.iconTrs_.gameObject, true)
				arg_505_1.iconController_:SetSelectedState("hero")

				arg_505_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_505_1.callingController_:SetSelectedState("normal")

				arg_505_1.keyicon_.color = Color.New(1, 1, 1)
				arg_505_1.icon_.color = Color.New(1, 1, 1)

				local var_508_9 = arg_505_1:GetWordFromCfg(1104902123)
				local var_508_10 = arg_505_1:FormatText(var_508_9.content)

				arg_505_1.text_.text = var_508_10

				LuaForUtil.ClearLinePrefixSymbol(arg_505_1.text_)

				local var_508_11 = 2
				local var_508_12 = utf8.len(var_508_10)
				local var_508_13 = var_508_11 <= 0 and var_508_7 or var_508_7 * (var_508_12 / var_508_11)

				if var_508_13 > 0 and var_508_7 < var_508_13 then
					arg_505_1.talkMaxDuration = var_508_13

					if var_508_13 + var_508_6 > arg_505_1.duration_ then
						arg_505_1.duration_ = var_508_13 + var_508_6
					end
				end

				arg_505_1.text_.text = var_508_10
				arg_505_1.typewritter.percent = 0

				arg_505_1.typewritter:SetDirty()
				arg_505_1:ShowNextGo(false)
				arg_505_1:RecordContent(arg_505_1.text_.text)
			end

			local var_508_14 = math.max(var_508_7, arg_505_1.talkMaxDuration)

			if var_508_6 <= arg_505_1.time_ and arg_505_1.time_ < var_508_6 + var_508_14 then
				arg_505_1.typewritter.percent = (arg_505_1.time_ - var_508_6) / var_508_14

				arg_505_1.typewritter:SetDirty()
			end

			if arg_505_1.time_ >= var_508_6 + var_508_14 and arg_505_1.time_ < var_508_6 + var_508_14 + arg_508_0 then
				arg_505_1.typewritter.percent = 1

				arg_505_1.typewritter:SetDirty()
				arg_505_1:ShowNextGo(true)
			end
		end

		arg_505_1.nodeConfigList_ = {}

		arg_505_1:InitPlayNodeList()
	end,
	Play1104902124 = function(arg_509_0, arg_509_1)
		arg_509_1.time_ = 0
		arg_509_1.frameCnt_ = 0
		arg_509_1.state_ = "playing"
		arg_509_1.curTalkId_ = 1104902124
		arg_509_1.duration_ = 1.2

		local var_509_0 = {
			zh = 1.1,
			ja = 1.2
		}
		local var_509_1 = manager.audio:GetLocalizationFlag()

		if var_509_0[var_509_1] ~= nil then
			arg_509_1.duration_ = var_509_0[var_509_1]
		end

		SetActive(arg_509_1.tipsGo_, false)

		function arg_509_1.onSingleLineFinish_()
			arg_509_1.onSingleLineUpdate_ = nil
			arg_509_1.onSingleLineFinish_ = nil
			arg_509_1.state_ = "waiting"
		end

		function arg_509_1.playNext_(arg_511_0)
			if arg_511_0 == 1 then
				arg_509_0:Play1104902125(arg_509_1)
			end
		end

		function arg_509_1.onSingleLineUpdate_(arg_512_0)
			local var_512_0 = 0
			local var_512_1 = 0.05

			if var_512_0 < arg_509_1.time_ and arg_509_1.time_ <= var_512_0 + arg_512_0 then
				arg_509_1.talkMaxDuration = 0
				arg_509_1.dialogCg_.alpha = 1

				arg_509_1.dialog_:SetActive(true)
				SetActive(arg_509_1.leftNameGo_, true)

				local var_512_2 = arg_509_1:FormatText(StoryNameCfg[1008].name)

				arg_509_1.leftNameTxt_.text = var_512_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_509_1.leftNameTxt_.transform)

				arg_509_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_509_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_509_1:RecordName(arg_509_1.leftNameTxt_.text)
				SetActive(arg_509_1.iconTrs_.gameObject, true)
				arg_509_1.iconController_:SetSelectedState("hero")

				arg_509_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10119")

				arg_509_1.callingController_:SetSelectedState("normal")

				arg_509_1.keyicon_.color = Color.New(1, 1, 1)
				arg_509_1.icon_.color = Color.New(1, 1, 1)

				local var_512_3 = arg_509_1:GetWordFromCfg(1104902124)
				local var_512_4 = arg_509_1:FormatText(var_512_3.content)

				arg_509_1.text_.text = var_512_4

				LuaForUtil.ClearLinePrefixSymbol(arg_509_1.text_)

				local var_512_5 = 2
				local var_512_6 = utf8.len(var_512_4)
				local var_512_7 = var_512_5 <= 0 and var_512_1 or var_512_1 * (var_512_6 / var_512_5)

				if var_512_7 > 0 and var_512_1 < var_512_7 then
					arg_509_1.talkMaxDuration = var_512_7

					if var_512_7 + var_512_0 > arg_509_1.duration_ then
						arg_509_1.duration_ = var_512_7 + var_512_0
					end
				end

				arg_509_1.text_.text = var_512_4
				arg_509_1.typewritter.percent = 0

				arg_509_1.typewritter:SetDirty()
				arg_509_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104902", "1104902124", "story_v_side_new_1104902.awb") ~= 0 then
					local var_512_8 = manager.audio:GetVoiceLength("story_v_side_new_1104902", "1104902124", "story_v_side_new_1104902.awb") / 1000

					if var_512_8 + var_512_0 > arg_509_1.duration_ then
						arg_509_1.duration_ = var_512_8 + var_512_0
					end

					if var_512_3.prefab_name ~= "" and arg_509_1.actors_[var_512_3.prefab_name] ~= nil then
						local var_512_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_509_1.actors_[var_512_3.prefab_name].transform, "story_v_side_new_1104902", "1104902124", "story_v_side_new_1104902.awb")

						arg_509_1:RecordAudio("1104902124", var_512_9)
						arg_509_1:RecordAudio("1104902124", var_512_9)
					else
						arg_509_1:AudioAction("play", "voice", "story_v_side_new_1104902", "1104902124", "story_v_side_new_1104902.awb")
					end

					arg_509_1:RecordHistoryTalkVoice("story_v_side_new_1104902", "1104902124", "story_v_side_new_1104902.awb")
				end

				arg_509_1:RecordContent(arg_509_1.text_.text)
			end

			local var_512_10 = math.max(var_512_1, arg_509_1.talkMaxDuration)

			if var_512_0 <= arg_509_1.time_ and arg_509_1.time_ < var_512_0 + var_512_10 then
				arg_509_1.typewritter.percent = (arg_509_1.time_ - var_512_0) / var_512_10

				arg_509_1.typewritter:SetDirty()
			end

			if arg_509_1.time_ >= var_512_0 + var_512_10 and arg_509_1.time_ < var_512_0 + var_512_10 + arg_512_0 then
				arg_509_1.typewritter.percent = 1

				arg_509_1.typewritter:SetDirty()
				arg_509_1:ShowNextGo(true)
			end
		end

		arg_509_1.nodeConfigList_ = {}

		arg_509_1:InitPlayNodeList()
	end,
	Play1104902125 = function(arg_513_0, arg_513_1)
		arg_513_1.time_ = 0
		arg_513_1.frameCnt_ = 0
		arg_513_1.state_ = "playing"
		arg_513_1.curTalkId_ = 1104902125
		arg_513_1.duration_ = 8.23

		local var_513_0 = {
			zh = 2.633,
			ja = 8.233
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
				arg_513_0:Play1104902126(arg_513_1)
			end
		end

		function arg_513_1.onSingleLineUpdate_(arg_516_0)
			local var_516_0 = arg_513_1.actors_["1049ui_story"].transform
			local var_516_1 = 0

			if var_516_1 < arg_513_1.time_ and arg_513_1.time_ <= var_516_1 + arg_516_0 then
				arg_513_1.var_.moveOldPos1049ui_story = var_516_0.localPosition
			end

			local var_516_2 = 0.001

			if var_516_1 <= arg_513_1.time_ and arg_513_1.time_ < var_516_1 + var_516_2 then
				local var_516_3 = (arg_513_1.time_ - var_516_1) / var_516_2
				local var_516_4 = Vector3.New(0, -1.2, -6)

				var_516_0.localPosition = Vector3.Lerp(arg_513_1.var_.moveOldPos1049ui_story, var_516_4, var_516_3)

				local var_516_5 = manager.ui.mainCamera.transform.position - var_516_0.position

				var_516_0.forward = Vector3.New(var_516_5.x, var_516_5.y, var_516_5.z)

				local var_516_6 = var_516_0.localEulerAngles

				var_516_6.z = 0
				var_516_6.x = 0
				var_516_0.localEulerAngles = var_516_6
			end

			if arg_513_1.time_ >= var_516_1 + var_516_2 and arg_513_1.time_ < var_516_1 + var_516_2 + arg_516_0 then
				var_516_0.localPosition = Vector3.New(0, -1.2, -6)

				local var_516_7 = manager.ui.mainCamera.transform.position - var_516_0.position

				var_516_0.forward = Vector3.New(var_516_7.x, var_516_7.y, var_516_7.z)

				local var_516_8 = var_516_0.localEulerAngles

				var_516_8.z = 0
				var_516_8.x = 0
				var_516_0.localEulerAngles = var_516_8
			end

			local var_516_9 = arg_513_1.actors_["1049ui_story"]
			local var_516_10 = 0

			if var_516_10 < arg_513_1.time_ and arg_513_1.time_ <= var_516_10 + arg_516_0 and not isNil(var_516_9) and arg_513_1.var_.characterEffect1049ui_story == nil then
				arg_513_1.var_.characterEffect1049ui_story = var_516_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_516_11 = 0.200000002980232

			if var_516_10 <= arg_513_1.time_ and arg_513_1.time_ < var_516_10 + var_516_11 and not isNil(var_516_9) then
				local var_516_12 = (arg_513_1.time_ - var_516_10) / var_516_11

				if arg_513_1.var_.characterEffect1049ui_story and not isNil(var_516_9) then
					arg_513_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_513_1.time_ >= var_516_10 + var_516_11 and arg_513_1.time_ < var_516_10 + var_516_11 + arg_516_0 and not isNil(var_516_9) and arg_513_1.var_.characterEffect1049ui_story then
				arg_513_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_516_13 = 0

			if var_516_13 < arg_513_1.time_ and arg_513_1.time_ <= var_516_13 + arg_516_0 then
				arg_513_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action2_2")
			end

			local var_516_14 = 0

			if var_516_14 < arg_513_1.time_ and arg_513_1.time_ <= var_516_14 + arg_516_0 then
				arg_513_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_516_15 = 0
			local var_516_16 = 0.225

			if var_516_15 < arg_513_1.time_ and arg_513_1.time_ <= var_516_15 + arg_516_0 then
				arg_513_1.talkMaxDuration = 0
				arg_513_1.dialogCg_.alpha = 1

				arg_513_1.dialog_:SetActive(true)
				SetActive(arg_513_1.leftNameGo_, true)

				local var_516_17 = arg_513_1:FormatText(StoryNameCfg[551].name)

				arg_513_1.leftNameTxt_.text = var_516_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_513_1.leftNameTxt_.transform)

				arg_513_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_513_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_513_1:RecordName(arg_513_1.leftNameTxt_.text)
				SetActive(arg_513_1.iconTrs_.gameObject, false)
				arg_513_1.callingController_:SetSelectedState("normal")

				local var_516_18 = arg_513_1:GetWordFromCfg(1104902125)
				local var_516_19 = arg_513_1:FormatText(var_516_18.content)

				arg_513_1.text_.text = var_516_19

				LuaForUtil.ClearLinePrefixSymbol(arg_513_1.text_)

				local var_516_20 = 9
				local var_516_21 = utf8.len(var_516_19)
				local var_516_22 = var_516_20 <= 0 and var_516_16 or var_516_16 * (var_516_21 / var_516_20)

				if var_516_22 > 0 and var_516_16 < var_516_22 then
					arg_513_1.talkMaxDuration = var_516_22

					if var_516_22 + var_516_15 > arg_513_1.duration_ then
						arg_513_1.duration_ = var_516_22 + var_516_15
					end
				end

				arg_513_1.text_.text = var_516_19
				arg_513_1.typewritter.percent = 0

				arg_513_1.typewritter:SetDirty()
				arg_513_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104902", "1104902125", "story_v_side_new_1104902.awb") ~= 0 then
					local var_516_23 = manager.audio:GetVoiceLength("story_v_side_new_1104902", "1104902125", "story_v_side_new_1104902.awb") / 1000

					if var_516_23 + var_516_15 > arg_513_1.duration_ then
						arg_513_1.duration_ = var_516_23 + var_516_15
					end

					if var_516_18.prefab_name ~= "" and arg_513_1.actors_[var_516_18.prefab_name] ~= nil then
						local var_516_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_513_1.actors_[var_516_18.prefab_name].transform, "story_v_side_new_1104902", "1104902125", "story_v_side_new_1104902.awb")

						arg_513_1:RecordAudio("1104902125", var_516_24)
						arg_513_1:RecordAudio("1104902125", var_516_24)
					else
						arg_513_1:AudioAction("play", "voice", "story_v_side_new_1104902", "1104902125", "story_v_side_new_1104902.awb")
					end

					arg_513_1:RecordHistoryTalkVoice("story_v_side_new_1104902", "1104902125", "story_v_side_new_1104902.awb")
				end

				arg_513_1:RecordContent(arg_513_1.text_.text)
			end

			local var_516_25 = math.max(var_516_16, arg_513_1.talkMaxDuration)

			if var_516_15 <= arg_513_1.time_ and arg_513_1.time_ < var_516_15 + var_516_25 then
				arg_513_1.typewritter.percent = (arg_513_1.time_ - var_516_15) / var_516_25

				arg_513_1.typewritter:SetDirty()
			end

			if arg_513_1.time_ >= var_516_15 + var_516_25 and arg_513_1.time_ < var_516_15 + var_516_25 + arg_516_0 then
				arg_513_1.typewritter.percent = 1

				arg_513_1.typewritter:SetDirty()
				arg_513_1:ShowNextGo(true)
			end
		end

		arg_513_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
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
	Play1104902126 = function(arg_517_0, arg_517_1)
		arg_517_1.time_ = 0
		arg_517_1.frameCnt_ = 0
		arg_517_1.state_ = "playing"
		arg_517_1.curTalkId_ = 1104902126
		arg_517_1.duration_ = 5

		SetActive(arg_517_1.tipsGo_, false)

		function arg_517_1.onSingleLineFinish_()
			arg_517_1.onSingleLineUpdate_ = nil
			arg_517_1.onSingleLineFinish_ = nil
			arg_517_1.state_ = "waiting"
		end

		function arg_517_1.playNext_(arg_519_0)
			if arg_519_0 == 1 then
				arg_517_0:Play1104902127(arg_517_1)
			end
		end

		function arg_517_1.onSingleLineUpdate_(arg_520_0)
			local var_520_0 = arg_517_1.actors_["1049ui_story"]
			local var_520_1 = 0

			if var_520_1 < arg_517_1.time_ and arg_517_1.time_ <= var_520_1 + arg_520_0 and not isNil(var_520_0) and arg_517_1.var_.characterEffect1049ui_story == nil then
				arg_517_1.var_.characterEffect1049ui_story = var_520_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_520_2 = 0.200000002980232

			if var_520_1 <= arg_517_1.time_ and arg_517_1.time_ < var_520_1 + var_520_2 and not isNil(var_520_0) then
				local var_520_3 = (arg_517_1.time_ - var_520_1) / var_520_2

				if arg_517_1.var_.characterEffect1049ui_story and not isNil(var_520_0) then
					local var_520_4 = Mathf.Lerp(0, 0.5, var_520_3)

					arg_517_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_517_1.var_.characterEffect1049ui_story.fillRatio = var_520_4
				end
			end

			if arg_517_1.time_ >= var_520_1 + var_520_2 and arg_517_1.time_ < var_520_1 + var_520_2 + arg_520_0 and not isNil(var_520_0) and arg_517_1.var_.characterEffect1049ui_story then
				local var_520_5 = 0.5

				arg_517_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_517_1.var_.characterEffect1049ui_story.fillRatio = var_520_5
			end

			local var_520_6 = 0
			local var_520_7 = 1.325

			if var_520_6 < arg_517_1.time_ and arg_517_1.time_ <= var_520_6 + arg_520_0 then
				arg_517_1.talkMaxDuration = 0
				arg_517_1.dialogCg_.alpha = 1

				arg_517_1.dialog_:SetActive(true)
				SetActive(arg_517_1.leftNameGo_, true)

				local var_520_8 = arg_517_1:FormatText(StoryNameCfg[7].name)

				arg_517_1.leftNameTxt_.text = var_520_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_517_1.leftNameTxt_.transform)

				arg_517_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_517_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_517_1:RecordName(arg_517_1.leftNameTxt_.text)
				SetActive(arg_517_1.iconTrs_.gameObject, true)
				arg_517_1.iconController_:SetSelectedState("hero")

				arg_517_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_517_1.callingController_:SetSelectedState("normal")

				arg_517_1.keyicon_.color = Color.New(1, 1, 1)
				arg_517_1.icon_.color = Color.New(1, 1, 1)

				local var_520_9 = arg_517_1:GetWordFromCfg(1104902126)
				local var_520_10 = arg_517_1:FormatText(var_520_9.content)

				arg_517_1.text_.text = var_520_10

				LuaForUtil.ClearLinePrefixSymbol(arg_517_1.text_)

				local var_520_11 = 53
				local var_520_12 = utf8.len(var_520_10)
				local var_520_13 = var_520_11 <= 0 and var_520_7 or var_520_7 * (var_520_12 / var_520_11)

				if var_520_13 > 0 and var_520_7 < var_520_13 then
					arg_517_1.talkMaxDuration = var_520_13

					if var_520_13 + var_520_6 > arg_517_1.duration_ then
						arg_517_1.duration_ = var_520_13 + var_520_6
					end
				end

				arg_517_1.text_.text = var_520_10
				arg_517_1.typewritter.percent = 0

				arg_517_1.typewritter:SetDirty()
				arg_517_1:ShowNextGo(false)
				arg_517_1:RecordContent(arg_517_1.text_.text)
			end

			local var_520_14 = math.max(var_520_7, arg_517_1.talkMaxDuration)

			if var_520_6 <= arg_517_1.time_ and arg_517_1.time_ < var_520_6 + var_520_14 then
				arg_517_1.typewritter.percent = (arg_517_1.time_ - var_520_6) / var_520_14

				arg_517_1.typewritter:SetDirty()
			end

			if arg_517_1.time_ >= var_520_6 + var_520_14 and arg_517_1.time_ < var_520_6 + var_520_14 + arg_520_0 then
				arg_517_1.typewritter.percent = 1

				arg_517_1.typewritter:SetDirty()
				arg_517_1:ShowNextGo(true)
			end
		end

		arg_517_1.nodeConfigList_ = {}

		arg_517_1:InitPlayNodeList()
	end,
	Play1104902127 = function(arg_521_0, arg_521_1)
		arg_521_1.time_ = 0
		arg_521_1.frameCnt_ = 0
		arg_521_1.state_ = "playing"
		arg_521_1.curTalkId_ = 1104902127
		arg_521_1.duration_ = 2.43

		local var_521_0 = {
			zh = 1.999999999999,
			ja = 2.433
		}
		local var_521_1 = manager.audio:GetLocalizationFlag()

		if var_521_0[var_521_1] ~= nil then
			arg_521_1.duration_ = var_521_0[var_521_1]
		end

		SetActive(arg_521_1.tipsGo_, false)

		function arg_521_1.onSingleLineFinish_()
			arg_521_1.onSingleLineUpdate_ = nil
			arg_521_1.onSingleLineFinish_ = nil
			arg_521_1.state_ = "waiting"
			arg_521_1.auto_ = false
		end

		function arg_521_1.playNext_(arg_523_0)
			arg_521_1.onStoryFinished_()
		end

		function arg_521_1.onSingleLineUpdate_(arg_524_0)
			local var_524_0 = arg_521_1.actors_["1049ui_story"].transform
			local var_524_1 = 0

			if var_524_1 < arg_521_1.time_ and arg_521_1.time_ <= var_524_1 + arg_524_0 then
				arg_521_1.var_.moveOldPos1049ui_story = var_524_0.localPosition
			end

			local var_524_2 = 0.001

			if var_524_1 <= arg_521_1.time_ and arg_521_1.time_ < var_524_1 + var_524_2 then
				local var_524_3 = (arg_521_1.time_ - var_524_1) / var_524_2
				local var_524_4 = Vector3.New(0, -1.2, -6)

				var_524_0.localPosition = Vector3.Lerp(arg_521_1.var_.moveOldPos1049ui_story, var_524_4, var_524_3)

				local var_524_5 = manager.ui.mainCamera.transform.position - var_524_0.position

				var_524_0.forward = Vector3.New(var_524_5.x, var_524_5.y, var_524_5.z)

				local var_524_6 = var_524_0.localEulerAngles

				var_524_6.z = 0
				var_524_6.x = 0
				var_524_0.localEulerAngles = var_524_6
			end

			if arg_521_1.time_ >= var_524_1 + var_524_2 and arg_521_1.time_ < var_524_1 + var_524_2 + arg_524_0 then
				var_524_0.localPosition = Vector3.New(0, -1.2, -6)

				local var_524_7 = manager.ui.mainCamera.transform.position - var_524_0.position

				var_524_0.forward = Vector3.New(var_524_7.x, var_524_7.y, var_524_7.z)

				local var_524_8 = var_524_0.localEulerAngles

				var_524_8.z = 0
				var_524_8.x = 0
				var_524_0.localEulerAngles = var_524_8
			end

			local var_524_9 = arg_521_1.actors_["1049ui_story"]
			local var_524_10 = 0

			if var_524_10 < arg_521_1.time_ and arg_521_1.time_ <= var_524_10 + arg_524_0 and not isNil(var_524_9) and arg_521_1.var_.characterEffect1049ui_story == nil then
				arg_521_1.var_.characterEffect1049ui_story = var_524_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_524_11 = 0.200000002980232

			if var_524_10 <= arg_521_1.time_ and arg_521_1.time_ < var_524_10 + var_524_11 and not isNil(var_524_9) then
				local var_524_12 = (arg_521_1.time_ - var_524_10) / var_524_11

				if arg_521_1.var_.characterEffect1049ui_story and not isNil(var_524_9) then
					arg_521_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_521_1.time_ >= var_524_10 + var_524_11 and arg_521_1.time_ < var_524_10 + var_524_11 + arg_524_0 and not isNil(var_524_9) and arg_521_1.var_.characterEffect1049ui_story then
				arg_521_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_524_13 = 0

			if var_524_13 < arg_521_1.time_ and arg_521_1.time_ <= var_524_13 + arg_524_0 then
				arg_521_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action2_1")
			end

			local var_524_14 = 0

			if var_524_14 < arg_521_1.time_ and arg_521_1.time_ <= var_524_14 + arg_524_0 then
				arg_521_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_524_15 = 0
			local var_524_16 = 0.05

			if var_524_15 < arg_521_1.time_ and arg_521_1.time_ <= var_524_15 + arg_524_0 then
				arg_521_1.talkMaxDuration = 0
				arg_521_1.dialogCg_.alpha = 1

				arg_521_1.dialog_:SetActive(true)
				SetActive(arg_521_1.leftNameGo_, true)

				local var_524_17 = arg_521_1:FormatText(StoryNameCfg[551].name)

				arg_521_1.leftNameTxt_.text = var_524_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_521_1.leftNameTxt_.transform)

				arg_521_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_521_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_521_1:RecordName(arg_521_1.leftNameTxt_.text)
				SetActive(arg_521_1.iconTrs_.gameObject, false)
				arg_521_1.callingController_:SetSelectedState("normal")

				local var_524_18 = arg_521_1:GetWordFromCfg(1104902127)
				local var_524_19 = arg_521_1:FormatText(var_524_18.content)

				arg_521_1.text_.text = var_524_19

				LuaForUtil.ClearLinePrefixSymbol(arg_521_1.text_)

				local var_524_20 = 2
				local var_524_21 = utf8.len(var_524_19)
				local var_524_22 = var_524_20 <= 0 and var_524_16 or var_524_16 * (var_524_21 / var_524_20)

				if var_524_22 > 0 and var_524_16 < var_524_22 then
					arg_521_1.talkMaxDuration = var_524_22

					if var_524_22 + var_524_15 > arg_521_1.duration_ then
						arg_521_1.duration_ = var_524_22 + var_524_15
					end
				end

				arg_521_1.text_.text = var_524_19
				arg_521_1.typewritter.percent = 0

				arg_521_1.typewritter:SetDirty()
				arg_521_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104902", "1104902127", "story_v_side_new_1104902.awb") ~= 0 then
					local var_524_23 = manager.audio:GetVoiceLength("story_v_side_new_1104902", "1104902127", "story_v_side_new_1104902.awb") / 1000

					if var_524_23 + var_524_15 > arg_521_1.duration_ then
						arg_521_1.duration_ = var_524_23 + var_524_15
					end

					if var_524_18.prefab_name ~= "" and arg_521_1.actors_[var_524_18.prefab_name] ~= nil then
						local var_524_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_521_1.actors_[var_524_18.prefab_name].transform, "story_v_side_new_1104902", "1104902127", "story_v_side_new_1104902.awb")

						arg_521_1:RecordAudio("1104902127", var_524_24)
						arg_521_1:RecordAudio("1104902127", var_524_24)
					else
						arg_521_1:AudioAction("play", "voice", "story_v_side_new_1104902", "1104902127", "story_v_side_new_1104902.awb")
					end

					arg_521_1:RecordHistoryTalkVoice("story_v_side_new_1104902", "1104902127", "story_v_side_new_1104902.awb")
				end

				arg_521_1:RecordContent(arg_521_1.text_.text)
			end

			local var_524_25 = math.max(var_524_16, arg_521_1.talkMaxDuration)

			if var_524_15 <= arg_521_1.time_ and arg_521_1.time_ < var_524_15 + var_524_25 then
				arg_521_1.typewritter.percent = (arg_521_1.time_ - var_524_15) / var_524_25

				arg_521_1.typewritter:SetDirty()
			end

			if arg_521_1.time_ >= var_524_15 + var_524_25 and arg_521_1.time_ < var_524_15 + var_524_25 + arg_524_0 then
				arg_521_1.typewritter.percent = 1

				arg_521_1.typewritter:SetDirty()
				arg_521_1:ShowNextGo(true)
			end
		end

		arg_521_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_521_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST06",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/ST11"
	},
	voices = {
		"story_v_side_new_1104902.awb"
	}
}
