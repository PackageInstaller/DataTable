return {
	Play116021001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 116021001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play116021002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "I02"

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
				local var_4_5 = arg_1_1.bgs_.I02

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
					if iter_4_0 ~= "I02" then
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

			local var_4_22 = 1.36666666666667
			local var_4_23 = 0.858333333333333

			if var_4_22 < arg_1_1.time_ and arg_1_1.time_ <= var_4_22 + arg_4_0 then
				local var_4_24 = "play"
				local var_4_25 = "effect"

				arg_1_1:AudioAction(var_4_24, var_4_25, "se_story_16", "se_story_16_foot", "")
			end

			local var_4_26 = 0
			local var_4_27 = 1

			if var_4_26 < arg_1_1.time_ and arg_1_1.time_ <= var_4_26 + arg_4_0 then
				local var_4_28 = "play"
				local var_4_29 = "music"

				arg_1_1:AudioAction(var_4_28, var_4_29, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_30 = ""
				local var_4_31 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_4_31 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_31 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_31

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_31
						arg_1_1.bgmTxt2_.text = var_4_31
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

			local var_4_32 = 2
			local var_4_33 = 0.733333333333333

			if var_4_32 < arg_1_1.time_ and arg_1_1.time_ <= var_4_32 + arg_4_0 then
				local var_4_34 = "play"
				local var_4_35 = "music"

				arg_1_1:AudioAction(var_4_34, var_4_35, "bgm_story_office", "bgm_story_office", "bgm_story_office.awb")

				local var_4_36 = ""
				local var_4_37 = manager.audio:GetAudioName("bgm_story_office", "bgm_story_office")

				if var_4_37 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_37 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_37

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_37
						arg_1_1.bgmTxt2_.text = var_4_37
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

			local var_4_38 = 2
			local var_4_39 = 0.225

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

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_41 = arg_1_1:FormatText(StoryNameCfg[326].name)

				arg_1_1.leftNameTxt_.text = var_4_41

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_42 = arg_1_1:GetWordFromCfg(116021001)
				local var_4_43 = arg_1_1:FormatText(var_4_42.content)

				arg_1_1.text_.text = var_4_43

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_44 = 9
				local var_4_45 = utf8.len(var_4_43)
				local var_4_46 = var_4_44 <= 0 and var_4_39 or var_4_39 * (var_4_45 / var_4_44)

				if var_4_46 > 0 and var_4_39 < var_4_46 then
					arg_1_1.talkMaxDuration = var_4_46
					var_4_38 = var_4_38 + 0.3

					if var_4_46 + var_4_38 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_46 + var_4_38
					end
				end

				arg_1_1.text_.text = var_4_43
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_47 = var_4_38 + 0.3
			local var_4_48 = math.max(var_4_39, arg_1_1.talkMaxDuration)

			if var_4_47 <= arg_1_1.time_ and arg_1_1.time_ < var_4_47 + var_4_48 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_47) / var_4_48

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_47 + var_4_48 and arg_1_1.time_ < var_4_47 + var_4_48 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play116021002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 116021002
		arg_9_1.duration_ = 1.6

		local var_9_0 = {
			zh = 1.2,
			ja = 1.6
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
				arg_9_0:Play116021003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0
			local var_12_1 = 0.125

			if var_12_0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				local var_12_2 = arg_9_1:FormatText(StoryNameCfg[13].name)

				arg_9_1.leftNameTxt_.text = var_12_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, true)
				arg_9_1.iconController_:SetSelectedState("hero")

				arg_9_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019_split_6")

				arg_9_1.callingController_:SetSelectedState("normal")

				arg_9_1.keyicon_.color = Color.New(1, 1, 1)
				arg_9_1.icon_.color = Color.New(1, 1, 1)

				local var_12_3 = arg_9_1:GetWordFromCfg(116021002)
				local var_12_4 = arg_9_1:FormatText(var_12_3.content)

				arg_9_1.text_.text = var_12_4

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_5 = 5
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

				if manager.audio:GetVoiceLength("story_v_out_116021", "116021002", "story_v_out_116021.awb") ~= 0 then
					local var_12_8 = manager.audio:GetVoiceLength("story_v_out_116021", "116021002", "story_v_out_116021.awb") / 1000

					if var_12_8 + var_12_0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_8 + var_12_0
					end

					if var_12_3.prefab_name ~= "" and arg_9_1.actors_[var_12_3.prefab_name] ~= nil then
						local var_12_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_3.prefab_name].transform, "story_v_out_116021", "116021002", "story_v_out_116021.awb")

						arg_9_1:RecordAudio("116021002", var_12_9)
						arg_9_1:RecordAudio("116021002", var_12_9)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_116021", "116021002", "story_v_out_116021.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_116021", "116021002", "story_v_out_116021.awb")
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
	Play116021003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 116021003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play116021004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0
			local var_16_1 = 0.775

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

				local var_16_2 = arg_13_1:GetWordFromCfg(116021003)
				local var_16_3 = arg_13_1:FormatText(var_16_2.content)

				arg_13_1.text_.text = var_16_3

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_4 = 31
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
	Play116021004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 116021004
		arg_17_1.duration_ = 10.83

		local var_17_0 = {
			zh = 10.533,
			ja = 10.833
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
				arg_17_0:Play116021005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0
			local var_20_1 = 1.125

			if var_20_0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_0 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_2 = arg_17_1:FormatText(StoryNameCfg[52].name)

				arg_17_1.leftNameTxt_.text = var_20_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, true)
				arg_17_1.iconController_:SetSelectedState("hero")

				arg_17_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6061")

				arg_17_1.callingController_:SetSelectedState("normal")

				arg_17_1.keyicon_.color = Color.New(1, 1, 1)
				arg_17_1.icon_.color = Color.New(1, 1, 1)

				local var_20_3 = arg_17_1:GetWordFromCfg(116021004)
				local var_20_4 = arg_17_1:FormatText(var_20_3.content)

				arg_17_1.text_.text = var_20_4

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_5 = 45
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

				if manager.audio:GetVoiceLength("story_v_out_116021", "116021004", "story_v_out_116021.awb") ~= 0 then
					local var_20_8 = manager.audio:GetVoiceLength("story_v_out_116021", "116021004", "story_v_out_116021.awb") / 1000

					if var_20_8 + var_20_0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_8 + var_20_0
					end

					if var_20_3.prefab_name ~= "" and arg_17_1.actors_[var_20_3.prefab_name] ~= nil then
						local var_20_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_3.prefab_name].transform, "story_v_out_116021", "116021004", "story_v_out_116021.awb")

						arg_17_1:RecordAudio("116021004", var_20_9)
						arg_17_1:RecordAudio("116021004", var_20_9)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_116021", "116021004", "story_v_out_116021.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_116021", "116021004", "story_v_out_116021.awb")
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
	Play116021005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 116021005
		arg_21_1.duration_ = 1.33

		local var_21_0 = {
			zh = 0.999999999999,
			ja = 1.333
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
				arg_21_0:Play116021006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 0
			local var_24_1 = 0.075

			if var_24_0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_0 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_2 = arg_21_1:FormatText(StoryNameCfg[13].name)

				arg_21_1.leftNameTxt_.text = var_24_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, true)
				arg_21_1.iconController_:SetSelectedState("hero")

				arg_21_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019_split_6")

				arg_21_1.callingController_:SetSelectedState("normal")

				arg_21_1.keyicon_.color = Color.New(1, 1, 1)
				arg_21_1.icon_.color = Color.New(1, 1, 1)

				local var_24_3 = arg_21_1:GetWordFromCfg(116021005)
				local var_24_4 = arg_21_1:FormatText(var_24_3.content)

				arg_21_1.text_.text = var_24_4

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_5 = 3
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

				if manager.audio:GetVoiceLength("story_v_out_116021", "116021005", "story_v_out_116021.awb") ~= 0 then
					local var_24_8 = manager.audio:GetVoiceLength("story_v_out_116021", "116021005", "story_v_out_116021.awb") / 1000

					if var_24_8 + var_24_0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_8 + var_24_0
					end

					if var_24_3.prefab_name ~= "" and arg_21_1.actors_[var_24_3.prefab_name] ~= nil then
						local var_24_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_3.prefab_name].transform, "story_v_out_116021", "116021005", "story_v_out_116021.awb")

						arg_21_1:RecordAudio("116021005", var_24_9)
						arg_21_1:RecordAudio("116021005", var_24_9)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_116021", "116021005", "story_v_out_116021.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_116021", "116021005", "story_v_out_116021.awb")
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
	Play116021006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 116021006
		arg_25_1.duration_ = 8

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play116021007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = "ST07b"

			if arg_25_1.bgs_[var_28_0] == nil then
				local var_28_1 = Object.Instantiate(arg_25_1.paintGo_)

				var_28_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_28_0)
				var_28_1.name = var_28_0
				var_28_1.transform.parent = arg_25_1.stage_.transform
				var_28_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_25_1.bgs_[var_28_0] = var_28_1
			end

			local var_28_2 = 2

			if var_28_2 < arg_25_1.time_ and arg_25_1.time_ <= var_28_2 + arg_28_0 then
				if arg_25_0.sceneSettingEffect_ then
					arg_25_1.sceneSettingEffect_.enabled = false
				end

				arg_25_1.sceneSettingGo_:SetActive(true)

				local var_28_3 = manager.ui.mainCamera.transform.localPosition
				local var_28_4 = Vector3.New(0, 0, 10) + Vector3.New(var_28_3.x, var_28_3.y, 0)
				local var_28_5 = arg_25_1.bgs_.ST07b

				var_28_5.transform.localPosition = var_28_4
				var_28_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_28_6 = var_28_5:GetComponent("SpriteRenderer")

				if var_28_6 and var_28_6.sprite then
					local var_28_7 = (var_28_5.transform.localPosition - var_28_3).z
					local var_28_8 = manager.ui.mainCameraCom_
					local var_28_9 = 2 * var_28_7 * Mathf.Tan(var_28_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_28_10 = var_28_9 * var_28_8.aspect
					local var_28_11 = var_28_6.sprite.bounds.size.x
					local var_28_12 = var_28_6.sprite.bounds.size.y
					local var_28_13 = var_28_10 / var_28_11
					local var_28_14 = var_28_9 / var_28_12
					local var_28_15 = var_28_14 < var_28_13 and var_28_13 or var_28_14

					var_28_5.transform.localScale = Vector3.New(var_28_15, var_28_15, 0)
				end

				for iter_28_0, iter_28_1 in pairs(arg_25_1.bgs_) do
					if iter_28_0 ~= "ST07b" then
						iter_28_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_28_16 = 0

			if var_28_16 < arg_25_1.time_ and arg_25_1.time_ <= var_28_16 + arg_28_0 then
				arg_25_1.mask_.enabled = true
				arg_25_1.mask_.raycastTarget = true

				arg_25_1:SetGaussion(false)
			end

			local var_28_17 = 2

			if var_28_16 <= arg_25_1.time_ and arg_25_1.time_ < var_28_16 + var_28_17 then
				local var_28_18 = (arg_25_1.time_ - var_28_16) / var_28_17
				local var_28_19 = Color.New(0, 0, 0)

				var_28_19.a = Mathf.Lerp(0, 1, var_28_18)
				arg_25_1.mask_.color = var_28_19
			end

			if arg_25_1.time_ >= var_28_16 + var_28_17 and arg_25_1.time_ < var_28_16 + var_28_17 + arg_28_0 then
				local var_28_20 = Color.New(0, 0, 0)

				var_28_20.a = 1
				arg_25_1.mask_.color = var_28_20
			end

			local var_28_21 = 2

			if var_28_21 < arg_25_1.time_ and arg_25_1.time_ <= var_28_21 + arg_28_0 then
				arg_25_1.mask_.enabled = true
				arg_25_1.mask_.raycastTarget = true

				arg_25_1:SetGaussion(false)
			end

			local var_28_22 = 2

			if var_28_21 <= arg_25_1.time_ and arg_25_1.time_ < var_28_21 + var_28_22 then
				local var_28_23 = (arg_25_1.time_ - var_28_21) / var_28_22
				local var_28_24 = Color.New(0, 0, 0)

				var_28_24.a = Mathf.Lerp(1, 0, var_28_23)
				arg_25_1.mask_.color = var_28_24
			end

			if arg_25_1.time_ >= var_28_21 + var_28_22 and arg_25_1.time_ < var_28_21 + var_28_22 + arg_28_0 then
				local var_28_25 = Color.New(0, 0, 0)
				local var_28_26 = 0

				arg_25_1.mask_.enabled = false
				var_28_25.a = var_28_26
				arg_25_1.mask_.color = var_28_25
			end

			local var_28_27 = "ST07b_blur"

			if arg_25_1.bgs_[var_28_27] == nil then
				local var_28_28 = Object.Instantiate(arg_25_1.blurPaintGo_)
				local var_28_29 = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_28_27)

				var_28_28:GetComponent("SpriteRenderer").sprite = var_28_29
				var_28_28.name = var_28_27
				var_28_28.transform.parent = arg_25_1.stage_.transform
				var_28_28.transform.localPosition = Vector3.New(0, 100, 0)
				arg_25_1.bgs_[var_28_27] = var_28_28
			end

			local var_28_30 = 2
			local var_28_31 = arg_25_1.bgs_[var_28_27]

			if var_28_30 < arg_25_1.time_ and arg_25_1.time_ <= var_28_30 + arg_28_0 then
				local var_28_32 = manager.ui.mainCamera.transform.localPosition
				local var_28_33 = Vector3.New(0, 0, 10) + Vector3.New(var_28_32.x, var_28_32.y, 0)

				var_28_31.transform.localPosition = var_28_33
				var_28_31.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_28_34 = var_28_31:GetComponent("SpriteRenderer")

				if var_28_34 and var_28_34.sprite then
					local var_28_35 = (var_28_31.transform.localPosition - var_28_32).z
					local var_28_36 = manager.ui.mainCameraCom_
					local var_28_37 = 2 * var_28_35 * Mathf.Tan(var_28_36.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_28_38 = var_28_37 * var_28_36.aspect
					local var_28_39 = var_28_34.sprite.bounds.size.x
					local var_28_40 = var_28_34.sprite.bounds.size.y
					local var_28_41 = var_28_38 / var_28_39
					local var_28_42 = var_28_37 / var_28_40
					local var_28_43 = var_28_42 < var_28_41 and var_28_41 or var_28_42

					var_28_31.transform.localScale = Vector3.New(var_28_43, var_28_43, 0)
				end
			end

			local var_28_44 = 1

			if var_28_30 <= arg_25_1.time_ and arg_25_1.time_ < var_28_30 + var_28_44 then
				local var_28_45 = (arg_25_1.time_ - var_28_30) / var_28_44
				local var_28_46 = Color.New(1, 1, 1)

				var_28_46.a = Mathf.Lerp(0, 0.6, var_28_45)

				var_28_31:GetComponent("SpriteRenderer").material:SetColor("_Color", var_28_46)
			end

			if arg_25_1.frameCnt_ <= 1 then
				arg_25_1.dialog_:SetActive(false)
			end

			local var_28_47 = 3
			local var_28_48 = 0.25

			if var_28_47 < arg_25_1.time_ and arg_25_1.time_ <= var_28_47 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0

				arg_25_1.dialog_:SetActive(true)

				arg_25_1.dialogCg_.alpha = 0

				local var_28_49 = LeanTween.value(arg_25_1.dialog_, 0, 1, 0.3)

				var_28_49:setOnUpdate(LuaHelper.FloatAction(function(arg_29_0)
					arg_25_1.dialogCg_.alpha = arg_29_0
				end))
				var_28_49:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_25_1.dialog_)
					var_28_49:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_25_1.duration_ = arg_25_1.duration_ + 0.3

				SetActive(arg_25_1.leftNameGo_, false)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_50 = arg_25_1:GetWordFromCfg(116021006)
				local var_28_51 = arg_25_1:FormatText(var_28_50.content)

				arg_25_1.text_.text = var_28_51

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_52 = 10
				local var_28_53 = utf8.len(var_28_51)
				local var_28_54 = var_28_52 <= 0 and var_28_48 or var_28_48 * (var_28_53 / var_28_52)

				if var_28_54 > 0 and var_28_48 < var_28_54 then
					arg_25_1.talkMaxDuration = var_28_54
					var_28_47 = var_28_47 + 0.3

					if var_28_54 + var_28_47 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_54 + var_28_47
					end
				end

				arg_25_1.text_.text = var_28_51
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_55 = var_28_47 + 0.3
			local var_28_56 = math.max(var_28_48, arg_25_1.talkMaxDuration)

			if var_28_55 <= arg_25_1.time_ and arg_25_1.time_ < var_28_55 + var_28_56 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_55) / var_28_56

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_55 + var_28_56 and arg_25_1.time_ < var_28_55 + var_28_56 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play116021007 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 116021007
		arg_31_1.duration_ = 5

		SetActive(arg_31_1.tipsGo_, false)

		function arg_31_1.onSingleLineFinish_()
			arg_31_1.onSingleLineUpdate_ = nil
			arg_31_1.onSingleLineFinish_ = nil
			arg_31_1.state_ = "waiting"
		end

		function arg_31_1.playNext_(arg_33_0)
			if arg_33_0 == 1 then
				arg_31_0:Play116021008(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			local var_34_0 = 0
			local var_34_1 = 1.425

			if var_34_0 < arg_31_1.time_ and arg_31_1.time_ <= var_34_0 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, false)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_31_1.iconTrs_.gameObject, false)
				arg_31_1.callingController_:SetSelectedState("normal")

				local var_34_2 = arg_31_1:GetWordFromCfg(116021007)
				local var_34_3 = arg_31_1:FormatText(var_34_2.content)

				arg_31_1.text_.text = var_34_3

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_4 = 57
				local var_34_5 = utf8.len(var_34_3)
				local var_34_6 = var_34_4 <= 0 and var_34_1 or var_34_1 * (var_34_5 / var_34_4)

				if var_34_6 > 0 and var_34_1 < var_34_6 then
					arg_31_1.talkMaxDuration = var_34_6

					if var_34_6 + var_34_0 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_6 + var_34_0
					end
				end

				arg_31_1.text_.text = var_34_3
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)
				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_7 = math.max(var_34_1, arg_31_1.talkMaxDuration)

			if var_34_0 <= arg_31_1.time_ and arg_31_1.time_ < var_34_0 + var_34_7 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - var_34_0) / var_34_7

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= var_34_0 + var_34_7 and arg_31_1.time_ < var_34_0 + var_34_7 + arg_34_0 then
				arg_31_1.typewritter.percent = 1

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(true)
			end
		end

		arg_31_1.nodeConfigList_ = {}

		arg_31_1:InitPlayNodeList()
	end,
	Play116021008 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 116021008
		arg_35_1.duration_ = 2

		SetActive(arg_35_1.tipsGo_, false)

		function arg_35_1.onSingleLineFinish_()
			arg_35_1.onSingleLineUpdate_ = nil
			arg_35_1.onSingleLineFinish_ = nil
			arg_35_1.state_ = "waiting"
		end

		function arg_35_1.playNext_(arg_37_0)
			if arg_37_0 == 1 then
				arg_35_0:Play116021009(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			local var_38_0 = "1019ui_story"

			if arg_35_1.actors_[var_38_0] == nil then
				local var_38_1 = Asset.Load("Char/" .. "1019ui_story")

				if not isNil(var_38_1) then
					local var_38_2 = Object.Instantiate(Asset.Load("Char/" .. "1019ui_story"), arg_35_1.stage_.transform)

					var_38_2.name = var_38_0
					var_38_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_35_1.actors_[var_38_0] = var_38_2

					local var_38_3 = var_38_2:GetComponentInChildren(typeof(CharacterEffect))

					var_38_3.enabled = true

					local var_38_4 = GameObjectTools.GetOrAddComponent(var_38_2, typeof(DynamicBoneHelper))

					if var_38_4 then
						var_38_4:EnableDynamicBone(false)
					end

					arg_35_1:ShowWeapon(var_38_3.transform, false)

					arg_35_1.var_[var_38_0 .. "Animator"] = var_38_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_35_1.var_[var_38_0 .. "Animator"].applyRootMotion = true
					arg_35_1.var_[var_38_0 .. "LipSync"] = var_38_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_38_5 = arg_35_1.actors_["1019ui_story"].transform
			local var_38_6 = 0

			if var_38_6 < arg_35_1.time_ and arg_35_1.time_ <= var_38_6 + arg_38_0 then
				arg_35_1.var_.moveOldPos1019ui_story = var_38_5.localPosition
			end

			local var_38_7 = 0.001

			if var_38_6 <= arg_35_1.time_ and arg_35_1.time_ < var_38_6 + var_38_7 then
				local var_38_8 = (arg_35_1.time_ - var_38_6) / var_38_7
				local var_38_9 = Vector3.New(-0.2, -1.08, -5.9)

				var_38_5.localPosition = Vector3.Lerp(arg_35_1.var_.moveOldPos1019ui_story, var_38_9, var_38_8)

				local var_38_10 = manager.ui.mainCamera.transform.position - var_38_5.position

				var_38_5.forward = Vector3.New(var_38_10.x, var_38_10.y, var_38_10.z)

				local var_38_11 = var_38_5.localEulerAngles

				var_38_11.z = 0
				var_38_11.x = 0
				var_38_5.localEulerAngles = var_38_11
			end

			if arg_35_1.time_ >= var_38_6 + var_38_7 and arg_35_1.time_ < var_38_6 + var_38_7 + arg_38_0 then
				var_38_5.localPosition = Vector3.New(-0.2, -1.08, -5.9)

				local var_38_12 = manager.ui.mainCamera.transform.position - var_38_5.position

				var_38_5.forward = Vector3.New(var_38_12.x, var_38_12.y, var_38_12.z)

				local var_38_13 = var_38_5.localEulerAngles

				var_38_13.z = 0
				var_38_13.x = 0
				var_38_5.localEulerAngles = var_38_13
			end

			local var_38_14 = 0

			if var_38_14 < arg_35_1.time_ and arg_35_1.time_ <= var_38_14 + arg_38_0 then
				arg_35_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action1_1")
			end

			local var_38_15 = 0

			if var_38_15 < arg_35_1.time_ and arg_35_1.time_ <= var_38_15 + arg_38_0 then
				arg_35_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_38_16 = arg_35_1.actors_["1019ui_story"]
			local var_38_17 = 0

			if var_38_17 < arg_35_1.time_ and arg_35_1.time_ <= var_38_17 + arg_38_0 and not isNil(var_38_16) and arg_35_1.var_.characterEffect1019ui_story == nil then
				arg_35_1.var_.characterEffect1019ui_story = var_38_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_38_18 = 0.2

			if var_38_17 <= arg_35_1.time_ and arg_35_1.time_ < var_38_17 + var_38_18 and not isNil(var_38_16) then
				local var_38_19 = (arg_35_1.time_ - var_38_17) / var_38_18

				if arg_35_1.var_.characterEffect1019ui_story and not isNil(var_38_16) then
					arg_35_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_35_1.time_ >= var_38_17 + var_38_18 and arg_35_1.time_ < var_38_17 + var_38_18 + arg_38_0 and not isNil(var_38_16) and arg_35_1.var_.characterEffect1019ui_story then
				arg_35_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_38_20 = 0
			local var_38_21 = 0.125

			if var_38_20 < arg_35_1.time_ and arg_35_1.time_ <= var_38_20 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, true)

				local var_38_22 = arg_35_1:FormatText(StoryNameCfg[13].name)

				arg_35_1.leftNameTxt_.text = var_38_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_35_1.leftNameTxt_.transform)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1.leftNameTxt_.text)
				SetActive(arg_35_1.iconTrs_.gameObject, false)
				arg_35_1.callingController_:SetSelectedState("normal")

				local var_38_23 = arg_35_1:GetWordFromCfg(116021008)
				local var_38_24 = arg_35_1:FormatText(var_38_23.content)

				arg_35_1.text_.text = var_38_24

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_25 = 5
				local var_38_26 = utf8.len(var_38_24)
				local var_38_27 = var_38_25 <= 0 and var_38_21 or var_38_21 * (var_38_26 / var_38_25)

				if var_38_27 > 0 and var_38_21 < var_38_27 then
					arg_35_1.talkMaxDuration = var_38_27

					if var_38_27 + var_38_20 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_27 + var_38_20
					end
				end

				arg_35_1.text_.text = var_38_24
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116021", "116021008", "story_v_out_116021.awb") ~= 0 then
					local var_38_28 = manager.audio:GetVoiceLength("story_v_out_116021", "116021008", "story_v_out_116021.awb") / 1000

					if var_38_28 + var_38_20 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_28 + var_38_20
					end

					if var_38_23.prefab_name ~= "" and arg_35_1.actors_[var_38_23.prefab_name] ~= nil then
						local var_38_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_35_1.actors_[var_38_23.prefab_name].transform, "story_v_out_116021", "116021008", "story_v_out_116021.awb")

						arg_35_1:RecordAudio("116021008", var_38_29)
						arg_35_1:RecordAudio("116021008", var_38_29)
					else
						arg_35_1:AudioAction("play", "voice", "story_v_out_116021", "116021008", "story_v_out_116021.awb")
					end

					arg_35_1:RecordHistoryTalkVoice("story_v_out_116021", "116021008", "story_v_out_116021.awb")
				end

				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_30 = math.max(var_38_21, arg_35_1.talkMaxDuration)

			if var_38_20 <= arg_35_1.time_ and arg_35_1.time_ < var_38_20 + var_38_30 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - var_38_20) / var_38_30

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= var_38_20 + var_38_30 and arg_35_1.time_ < var_38_20 + var_38_30 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {
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

		arg_35_1:InitPlayNodeList()
	end,
	Play116021009 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 116021009
		arg_39_1.duration_ = 5

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play116021010(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			local var_42_0 = arg_39_1.actors_["1019ui_story"]
			local var_42_1 = 0

			if var_42_1 < arg_39_1.time_ and arg_39_1.time_ <= var_42_1 + arg_42_0 and not isNil(var_42_0) and arg_39_1.var_.characterEffect1019ui_story == nil then
				arg_39_1.var_.characterEffect1019ui_story = var_42_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_42_2 = 0.2

			if var_42_1 <= arg_39_1.time_ and arg_39_1.time_ < var_42_1 + var_42_2 and not isNil(var_42_0) then
				local var_42_3 = (arg_39_1.time_ - var_42_1) / var_42_2

				if arg_39_1.var_.characterEffect1019ui_story and not isNil(var_42_0) then
					local var_42_4 = Mathf.Lerp(0, 0.5, var_42_3)

					arg_39_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_39_1.var_.characterEffect1019ui_story.fillRatio = var_42_4
				end
			end

			if arg_39_1.time_ >= var_42_1 + var_42_2 and arg_39_1.time_ < var_42_1 + var_42_2 + arg_42_0 and not isNil(var_42_0) and arg_39_1.var_.characterEffect1019ui_story then
				local var_42_5 = 0.5

				arg_39_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_39_1.var_.characterEffect1019ui_story.fillRatio = var_42_5
			end

			local var_42_6 = 0
			local var_42_7 = 1.075

			if var_42_6 < arg_39_1.time_ and arg_39_1.time_ <= var_42_6 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, false)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_39_1.iconTrs_.gameObject, false)
				arg_39_1.callingController_:SetSelectedState("normal")

				local var_42_8 = arg_39_1:GetWordFromCfg(116021009)
				local var_42_9 = arg_39_1:FormatText(var_42_8.content)

				arg_39_1.text_.text = var_42_9

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_10 = 43
				local var_42_11 = utf8.len(var_42_9)
				local var_42_12 = var_42_10 <= 0 and var_42_7 or var_42_7 * (var_42_11 / var_42_10)

				if var_42_12 > 0 and var_42_7 < var_42_12 then
					arg_39_1.talkMaxDuration = var_42_12

					if var_42_12 + var_42_6 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_12 + var_42_6
					end
				end

				arg_39_1.text_.text = var_42_9
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)
				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_13 = math.max(var_42_7, arg_39_1.talkMaxDuration)

			if var_42_6 <= arg_39_1.time_ and arg_39_1.time_ < var_42_6 + var_42_13 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_6) / var_42_13

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_6 + var_42_13 and arg_39_1.time_ < var_42_6 + var_42_13 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {}

		arg_39_1:InitPlayNodeList()
	end,
	Play116021010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 116021010
		arg_43_1.duration_ = 5.83

		local var_43_0 = {
			zh = 3.133,
			ja = 5.833
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
				arg_43_0:Play116021011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			local var_46_0 = 0
			local var_46_1 = 0.325

			if var_46_0 < arg_43_1.time_ and arg_43_1.time_ <= var_46_0 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, true)

				local var_46_2 = arg_43_1:FormatText(StoryNameCfg[9].name)

				arg_43_1.leftNameTxt_.text = var_46_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, true)
				arg_43_1.iconController_:SetSelectedState("hero")

				arg_43_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1039")

				arg_43_1.callingController_:SetSelectedState("normal")

				arg_43_1.keyicon_.color = Color.New(1, 1, 1)
				arg_43_1.icon_.color = Color.New(1, 1, 1)

				local var_46_3 = arg_43_1:GetWordFromCfg(116021010)
				local var_46_4 = arg_43_1:FormatText(var_46_3.content)

				arg_43_1.text_.text = var_46_4

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_5 = 13
				local var_46_6 = utf8.len(var_46_4)
				local var_46_7 = var_46_5 <= 0 and var_46_1 or var_46_1 * (var_46_6 / var_46_5)

				if var_46_7 > 0 and var_46_1 < var_46_7 then
					arg_43_1.talkMaxDuration = var_46_7

					if var_46_7 + var_46_0 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_7 + var_46_0
					end
				end

				arg_43_1.text_.text = var_46_4
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116021", "116021010", "story_v_out_116021.awb") ~= 0 then
					local var_46_8 = manager.audio:GetVoiceLength("story_v_out_116021", "116021010", "story_v_out_116021.awb") / 1000

					if var_46_8 + var_46_0 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_8 + var_46_0
					end

					if var_46_3.prefab_name ~= "" and arg_43_1.actors_[var_46_3.prefab_name] ~= nil then
						local var_46_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_43_1.actors_[var_46_3.prefab_name].transform, "story_v_out_116021", "116021010", "story_v_out_116021.awb")

						arg_43_1:RecordAudio("116021010", var_46_9)
						arg_43_1:RecordAudio("116021010", var_46_9)
					else
						arg_43_1:AudioAction("play", "voice", "story_v_out_116021", "116021010", "story_v_out_116021.awb")
					end

					arg_43_1:RecordHistoryTalkVoice("story_v_out_116021", "116021010", "story_v_out_116021.awb")
				end

				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_10 = math.max(var_46_1, arg_43_1.talkMaxDuration)

			if var_46_0 <= arg_43_1.time_ and arg_43_1.time_ < var_46_0 + var_46_10 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_0) / var_46_10

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_0 + var_46_10 and arg_43_1.time_ < var_46_0 + var_46_10 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {}

		arg_43_1:InitPlayNodeList()
	end,
	Play116021011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 116021011
		arg_47_1.duration_ = 0.02

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"

			SetActive(arg_47_1.choicesGo_, true)

			for iter_48_0, iter_48_1 in ipairs(arg_47_1.choices_) do
				local var_48_0 = iter_48_0 <= 1

				SetActive(iter_48_1.go, var_48_0)
			end

			arg_47_1.choices_[1].txt.text = arg_47_1:FormatText(StoryChoiceCfg[224].name)
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play116021012(arg_47_1)
			end

			arg_47_1:RecordChoiceLog(116021011, 224)
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			return
		end

		arg_47_1.nodeConfigList_ = {}

		arg_47_1:InitPlayNodeList()
	end,
	Play116021012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 116021012
		arg_51_1.duration_ = 5.9

		local var_51_0 = {
			zh = 5.9,
			ja = 5.866
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
				arg_51_0:Play116021013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			local var_54_0 = 0
			local var_54_1 = 0.525

			if var_54_0 < arg_51_1.time_ and arg_51_1.time_ <= var_54_0 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0

				arg_51_1.dialog_:SetActive(true)

				arg_51_1.dialogCg_.alpha = 0

				local var_54_2 = LeanTween.value(arg_51_1.dialog_, 0, 1, 0.3)

				var_54_2:setOnUpdate(LuaHelper.FloatAction(function(arg_55_0)
					arg_51_1.dialogCg_.alpha = arg_55_0
				end))
				var_54_2:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_51_1.dialog_)
					var_54_2:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_51_1.duration_ = arg_51_1.duration_ + 0.3

				SetActive(arg_51_1.leftNameGo_, true)

				local var_54_3 = arg_51_1:FormatText(StoryNameCfg[9].name)

				arg_51_1.leftNameTxt_.text = var_54_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, true)
				arg_51_1.iconController_:SetSelectedState("hero")

				arg_51_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1039")

				arg_51_1.callingController_:SetSelectedState("normal")

				arg_51_1.keyicon_.color = Color.New(1, 1, 1)
				arg_51_1.icon_.color = Color.New(1, 1, 1)

				local var_54_4 = arg_51_1:GetWordFromCfg(116021012)
				local var_54_5 = arg_51_1:FormatText(var_54_4.content)

				arg_51_1.text_.text = var_54_5

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_6 = 21
				local var_54_7 = utf8.len(var_54_5)
				local var_54_8 = var_54_6 <= 0 and var_54_1 or var_54_1 * (var_54_7 / var_54_6)

				if var_54_8 > 0 and var_54_1 < var_54_8 then
					arg_51_1.talkMaxDuration = var_54_8
					var_54_0 = var_54_0 + 0.3

					if var_54_8 + var_54_0 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_8 + var_54_0
					end
				end

				arg_51_1.text_.text = var_54_5
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116021", "116021012", "story_v_out_116021.awb") ~= 0 then
					local var_54_9 = manager.audio:GetVoiceLength("story_v_out_116021", "116021012", "story_v_out_116021.awb") / 1000

					if var_54_9 + var_54_0 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_9 + var_54_0
					end

					if var_54_4.prefab_name ~= "" and arg_51_1.actors_[var_54_4.prefab_name] ~= nil then
						local var_54_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_51_1.actors_[var_54_4.prefab_name].transform, "story_v_out_116021", "116021012", "story_v_out_116021.awb")

						arg_51_1:RecordAudio("116021012", var_54_10)
						arg_51_1:RecordAudio("116021012", var_54_10)
					else
						arg_51_1:AudioAction("play", "voice", "story_v_out_116021", "116021012", "story_v_out_116021.awb")
					end

					arg_51_1:RecordHistoryTalkVoice("story_v_out_116021", "116021012", "story_v_out_116021.awb")
				end

				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_11 = var_54_0 + 0.3
			local var_54_12 = math.max(var_54_1, arg_51_1.talkMaxDuration)

			if var_54_11 <= arg_51_1.time_ and arg_51_1.time_ < var_54_11 + var_54_12 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_11) / var_54_12

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_11 + var_54_12 and arg_51_1.time_ < var_54_11 + var_54_12 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {}

		arg_51_1:InitPlayNodeList()
	end,
	Play116021013 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 116021013
		arg_57_1.duration_ = 5

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play116021014(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = 0
			local var_60_1 = 1.4

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

				local var_60_2 = arg_57_1:GetWordFromCfg(116021013)
				local var_60_3 = arg_57_1:FormatText(var_60_2.content)

				arg_57_1.text_.text = var_60_3

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_4 = 56
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
	Play116021014 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 116021014
		arg_61_1.duration_ = 4.2

		local var_61_0 = {
			zh = 4.2,
			ja = 3
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
				arg_61_0:Play116021015(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = 0
			local var_64_1 = 0.325

			if var_64_0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_0 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_2 = arg_61_1:FormatText(StoryNameCfg[9].name)

				arg_61_1.leftNameTxt_.text = var_64_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, true)
				arg_61_1.iconController_:SetSelectedState("hero")

				arg_61_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1039")

				arg_61_1.callingController_:SetSelectedState("normal")

				arg_61_1.keyicon_.color = Color.New(1, 1, 1)
				arg_61_1.icon_.color = Color.New(1, 1, 1)

				local var_64_3 = arg_61_1:GetWordFromCfg(116021014)
				local var_64_4 = arg_61_1:FormatText(var_64_3.content)

				arg_61_1.text_.text = var_64_4

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_5 = 13
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

				if manager.audio:GetVoiceLength("story_v_out_116021", "116021014", "story_v_out_116021.awb") ~= 0 then
					local var_64_8 = manager.audio:GetVoiceLength("story_v_out_116021", "116021014", "story_v_out_116021.awb") / 1000

					if var_64_8 + var_64_0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_8 + var_64_0
					end

					if var_64_3.prefab_name ~= "" and arg_61_1.actors_[var_64_3.prefab_name] ~= nil then
						local var_64_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_3.prefab_name].transform, "story_v_out_116021", "116021014", "story_v_out_116021.awb")

						arg_61_1:RecordAudio("116021014", var_64_9)
						arg_61_1:RecordAudio("116021014", var_64_9)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_116021", "116021014", "story_v_out_116021.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_116021", "116021014", "story_v_out_116021.awb")
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
	Play116021015 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 116021015
		arg_65_1.duration_ = 9

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play116021016(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = "SK0104"

			if arg_65_1.bgs_[var_68_0] == nil then
				local var_68_1 = Object.Instantiate(arg_65_1.paintGo_)

				var_68_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_68_0)
				var_68_1.name = var_68_0
				var_68_1.transform.parent = arg_65_1.stage_.transform
				var_68_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_65_1.bgs_[var_68_0] = var_68_1
			end

			local var_68_2 = 2

			if var_68_2 < arg_65_1.time_ and arg_65_1.time_ <= var_68_2 + arg_68_0 then
				local var_68_3 = manager.ui.mainCamera.transform.localPosition
				local var_68_4 = Vector3.New(0, 0, 10) + Vector3.New(var_68_3.x, var_68_3.y, 0)
				local var_68_5 = arg_65_1.bgs_.SK0104

				var_68_5.transform.localPosition = var_68_4
				var_68_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_68_6 = var_68_5:GetComponent("SpriteRenderer")

				if var_68_6 and var_68_6.sprite then
					local var_68_7 = (var_68_5.transform.localPosition - var_68_3).z
					local var_68_8 = manager.ui.mainCameraCom_
					local var_68_9 = 2 * var_68_7 * Mathf.Tan(var_68_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_68_10 = var_68_9 * var_68_8.aspect
					local var_68_11 = var_68_6.sprite.bounds.size.x
					local var_68_12 = var_68_6.sprite.bounds.size.y
					local var_68_13 = var_68_10 / var_68_11
					local var_68_14 = var_68_9 / var_68_12
					local var_68_15 = var_68_14 < var_68_13 and var_68_13 or var_68_14

					var_68_5.transform.localScale = Vector3.New(var_68_15, var_68_15, 0)
				end

				for iter_68_0, iter_68_1 in pairs(arg_65_1.bgs_) do
					if iter_68_0 ~= "SK0104" then
						iter_68_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_68_16 = 0

			if var_68_16 < arg_65_1.time_ and arg_65_1.time_ <= var_68_16 + arg_68_0 then
				arg_65_1.mask_.enabled = true
				arg_65_1.mask_.raycastTarget = true

				arg_65_1:SetGaussion(false)
			end

			local var_68_17 = 2

			if var_68_16 <= arg_65_1.time_ and arg_65_1.time_ < var_68_16 + var_68_17 then
				local var_68_18 = (arg_65_1.time_ - var_68_16) / var_68_17
				local var_68_19 = Color.New(0, 0, 0)

				var_68_19.a = Mathf.Lerp(0, 1, var_68_18)
				arg_65_1.mask_.color = var_68_19
			end

			if arg_65_1.time_ >= var_68_16 + var_68_17 and arg_65_1.time_ < var_68_16 + var_68_17 + arg_68_0 then
				local var_68_20 = Color.New(0, 0, 0)

				var_68_20.a = 1
				arg_65_1.mask_.color = var_68_20
			end

			local var_68_21 = 2

			if var_68_21 < arg_65_1.time_ and arg_65_1.time_ <= var_68_21 + arg_68_0 then
				arg_65_1.mask_.enabled = true
				arg_65_1.mask_.raycastTarget = true

				arg_65_1:SetGaussion(false)
			end

			local var_68_22 = 2

			if var_68_21 <= arg_65_1.time_ and arg_65_1.time_ < var_68_21 + var_68_22 then
				local var_68_23 = (arg_65_1.time_ - var_68_21) / var_68_22
				local var_68_24 = Color.New(0, 0, 0)

				var_68_24.a = Mathf.Lerp(1, 0, var_68_23)
				arg_65_1.mask_.color = var_68_24
			end

			if arg_65_1.time_ >= var_68_21 + var_68_22 and arg_65_1.time_ < var_68_21 + var_68_22 + arg_68_0 then
				local var_68_25 = Color.New(0, 0, 0)
				local var_68_26 = 0

				arg_65_1.mask_.enabled = false
				var_68_25.a = var_68_26
				arg_65_1.mask_.color = var_68_25
			end

			local var_68_27 = arg_65_1.bgs_.SK0104.transform
			local var_68_28 = 2

			if var_68_28 < arg_65_1.time_ and arg_65_1.time_ <= var_68_28 + arg_68_0 then
				arg_65_1.var_.moveOldPosSK0104 = var_68_27.localPosition
			end

			local var_68_29 = 2.5

			if var_68_28 <= arg_65_1.time_ and arg_65_1.time_ < var_68_28 + var_68_29 then
				local var_68_30 = (arg_65_1.time_ - var_68_28) / var_68_29
				local var_68_31 = Vector3.New(0, 1, 9.5)

				var_68_27.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPosSK0104, var_68_31, var_68_30)
			end

			if arg_65_1.time_ >= var_68_28 + var_68_29 and arg_65_1.time_ < var_68_28 + var_68_29 + arg_68_0 then
				var_68_27.localPosition = Vector3.New(0, 1, 9.5)
			end

			local var_68_32 = arg_65_1.actors_["1019ui_story"].transform
			local var_68_33 = 1.966

			if var_68_33 < arg_65_1.time_ and arg_65_1.time_ <= var_68_33 + arg_68_0 then
				arg_65_1.var_.moveOldPos1019ui_story = var_68_32.localPosition
			end

			local var_68_34 = 0.001

			if var_68_33 <= arg_65_1.time_ and arg_65_1.time_ < var_68_33 + var_68_34 then
				local var_68_35 = (arg_65_1.time_ - var_68_33) / var_68_34
				local var_68_36 = Vector3.New(0, 100, 0)

				var_68_32.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos1019ui_story, var_68_36, var_68_35)

				local var_68_37 = manager.ui.mainCamera.transform.position - var_68_32.position

				var_68_32.forward = Vector3.New(var_68_37.x, var_68_37.y, var_68_37.z)

				local var_68_38 = var_68_32.localEulerAngles

				var_68_38.z = 0
				var_68_38.x = 0
				var_68_32.localEulerAngles = var_68_38
			end

			if arg_65_1.time_ >= var_68_33 + var_68_34 and arg_65_1.time_ < var_68_33 + var_68_34 + arg_68_0 then
				var_68_32.localPosition = Vector3.New(0, 100, 0)

				local var_68_39 = manager.ui.mainCamera.transform.position - var_68_32.position

				var_68_32.forward = Vector3.New(var_68_39.x, var_68_39.y, var_68_39.z)

				local var_68_40 = var_68_32.localEulerAngles

				var_68_40.z = 0
				var_68_40.x = 0
				var_68_32.localEulerAngles = var_68_40
			end

			local var_68_41 = 4

			if var_68_41 < arg_65_1.time_ and arg_65_1.time_ <= var_68_41 + arg_68_0 then
				arg_65_1.allBtn_.enabled = false
			end

			local var_68_42 = 0.5

			if arg_65_1.time_ >= var_68_41 + var_68_42 and arg_65_1.time_ < var_68_41 + var_68_42 + arg_68_0 then
				arg_65_1.allBtn_.enabled = true
			end

			if arg_65_1.frameCnt_ <= 1 then
				arg_65_1.dialog_:SetActive(false)
			end

			local var_68_43 = 4
			local var_68_44 = 1.5

			if var_68_43 < arg_65_1.time_ and arg_65_1.time_ <= var_68_43 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0

				arg_65_1.dialog_:SetActive(true)

				arg_65_1.dialogCg_.alpha = 0

				local var_68_45 = LeanTween.value(arg_65_1.dialog_, 0, 1, 0.3)

				var_68_45:setOnUpdate(LuaHelper.FloatAction(function(arg_69_0)
					arg_65_1.dialogCg_.alpha = arg_69_0
				end))
				var_68_45:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_65_1.dialog_)
					var_68_45:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_65_1.duration_ = arg_65_1.duration_ + 0.3

				SetActive(arg_65_1.leftNameGo_, false)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_46 = arg_65_1:GetWordFromCfg(116021015)
				local var_68_47 = arg_65_1:FormatText(var_68_46.content)

				arg_65_1.text_.text = var_68_47

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_48 = 61
				local var_68_49 = utf8.len(var_68_47)
				local var_68_50 = var_68_48 <= 0 and var_68_44 or var_68_44 * (var_68_49 / var_68_48)

				if var_68_50 > 0 and var_68_44 < var_68_50 then
					arg_65_1.talkMaxDuration = var_68_50
					var_68_43 = var_68_43 + 0.3

					if var_68_50 + var_68_43 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_50 + var_68_43
					end
				end

				arg_65_1.text_.text = var_68_47
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)
				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_51 = var_68_43 + 0.3
			local var_68_52 = math.max(var_68_44, arg_65_1.talkMaxDuration)

			if var_68_51 <= arg_65_1.time_ and arg_65_1.time_ < var_68_51 + var_68_52 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_51) / var_68_52

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_51 + var_68_52 and arg_65_1.time_ < var_68_51 + var_68_52 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "SK0104",
				changeDisplayLayer = false,
				needEase = false,
				duration = 2.5,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
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

		arg_65_1:InitPlayNodeList()
	end,
	Play116021016 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 116021016
		arg_71_1.duration_ = 8.17

		local var_71_0 = {
			zh = 7.433,
			ja = 8.166
		}
		local var_71_1 = manager.audio:GetLocalizationFlag()

		if var_71_0[var_71_1] ~= nil then
			arg_71_1.duration_ = var_71_0[var_71_1]
		end

		SetActive(arg_71_1.tipsGo_, false)

		function arg_71_1.onSingleLineFinish_()
			arg_71_1.onSingleLineUpdate_ = nil
			arg_71_1.onSingleLineFinish_ = nil
			arg_71_1.state_ = "waiting"
		end

		function arg_71_1.playNext_(arg_73_0)
			if arg_73_0 == 1 then
				arg_71_0:Play116021017(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			local var_74_0 = 0
			local var_74_1 = 0.55

			if var_74_0 < arg_71_1.time_ and arg_71_1.time_ <= var_74_0 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				local var_74_2 = arg_71_1:FormatText(StoryNameCfg[8].name)

				arg_71_1.leftNameTxt_.text = var_74_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_3 = arg_71_1:GetWordFromCfg(116021016)
				local var_74_4 = arg_71_1:FormatText(var_74_3.content)

				arg_71_1.text_.text = var_74_4

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_5 = 22
				local var_74_6 = utf8.len(var_74_4)
				local var_74_7 = var_74_5 <= 0 and var_74_1 or var_74_1 * (var_74_6 / var_74_5)

				if var_74_7 > 0 and var_74_1 < var_74_7 then
					arg_71_1.talkMaxDuration = var_74_7

					if var_74_7 + var_74_0 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_7 + var_74_0
					end
				end

				arg_71_1.text_.text = var_74_4
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116021", "116021016", "story_v_out_116021.awb") ~= 0 then
					local var_74_8 = manager.audio:GetVoiceLength("story_v_out_116021", "116021016", "story_v_out_116021.awb") / 1000

					if var_74_8 + var_74_0 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_8 + var_74_0
					end

					if var_74_3.prefab_name ~= "" and arg_71_1.actors_[var_74_3.prefab_name] ~= nil then
						local var_74_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_3.prefab_name].transform, "story_v_out_116021", "116021016", "story_v_out_116021.awb")

						arg_71_1:RecordAudio("116021016", var_74_9)
						arg_71_1:RecordAudio("116021016", var_74_9)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_out_116021", "116021016", "story_v_out_116021.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_out_116021", "116021016", "story_v_out_116021.awb")
				end

				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_10 = math.max(var_74_1, arg_71_1.talkMaxDuration)

			if var_74_0 <= arg_71_1.time_ and arg_71_1.time_ < var_74_0 + var_74_10 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_0) / var_74_10

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_0 + var_74_10 and arg_71_1.time_ < var_74_0 + var_74_10 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {}

		arg_71_1:InitPlayNodeList()
	end,
	Play116021017 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 116021017
		arg_75_1.duration_ = 9.8

		local var_75_0 = {
			zh = 5.433,
			ja = 9.8
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
				arg_75_0:Play116021018(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			local var_78_0 = 0
			local var_78_1 = 0.4

			if var_78_0 < arg_75_1.time_ and arg_75_1.time_ <= var_78_0 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				local var_78_2 = arg_75_1:FormatText(StoryNameCfg[8].name)

				arg_75_1.leftNameTxt_.text = var_78_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_3 = arg_75_1:GetWordFromCfg(116021017)
				local var_78_4 = arg_75_1:FormatText(var_78_3.content)

				arg_75_1.text_.text = var_78_4

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_5 = 16
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

				if manager.audio:GetVoiceLength("story_v_out_116021", "116021017", "story_v_out_116021.awb") ~= 0 then
					local var_78_8 = manager.audio:GetVoiceLength("story_v_out_116021", "116021017", "story_v_out_116021.awb") / 1000

					if var_78_8 + var_78_0 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_8 + var_78_0
					end

					if var_78_3.prefab_name ~= "" and arg_75_1.actors_[var_78_3.prefab_name] ~= nil then
						local var_78_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_75_1.actors_[var_78_3.prefab_name].transform, "story_v_out_116021", "116021017", "story_v_out_116021.awb")

						arg_75_1:RecordAudio("116021017", var_78_9)
						arg_75_1:RecordAudio("116021017", var_78_9)
					else
						arg_75_1:AudioAction("play", "voice", "story_v_out_116021", "116021017", "story_v_out_116021.awb")
					end

					arg_75_1:RecordHistoryTalkVoice("story_v_out_116021", "116021017", "story_v_out_116021.awb")
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
	Play116021018 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 116021018
		arg_79_1.duration_ = 7.1

		local var_79_0 = {
			zh = 7.1,
			ja = 5.6
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
				arg_79_0:Play116021019(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			local var_82_0 = 0
			local var_82_1 = 0.7

			if var_82_0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_0 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				local var_82_2 = arg_79_1:FormatText(StoryNameCfg[13].name)

				arg_79_1.leftNameTxt_.text = var_82_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, true)
				arg_79_1.iconController_:SetSelectedState("hero")

				arg_79_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019_split_6")

				arg_79_1.callingController_:SetSelectedState("normal")

				arg_79_1.keyicon_.color = Color.New(1, 1, 1)
				arg_79_1.icon_.color = Color.New(1, 1, 1)

				local var_82_3 = arg_79_1:GetWordFromCfg(116021018)
				local var_82_4 = arg_79_1:FormatText(var_82_3.content)

				arg_79_1.text_.text = var_82_4

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_5 = 29
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

				if manager.audio:GetVoiceLength("story_v_out_116021", "116021018", "story_v_out_116021.awb") ~= 0 then
					local var_82_8 = manager.audio:GetVoiceLength("story_v_out_116021", "116021018", "story_v_out_116021.awb") / 1000

					if var_82_8 + var_82_0 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_8 + var_82_0
					end

					if var_82_3.prefab_name ~= "" and arg_79_1.actors_[var_82_3.prefab_name] ~= nil then
						local var_82_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_79_1.actors_[var_82_3.prefab_name].transform, "story_v_out_116021", "116021018", "story_v_out_116021.awb")

						arg_79_1:RecordAudio("116021018", var_82_9)
						arg_79_1:RecordAudio("116021018", var_82_9)
					else
						arg_79_1:AudioAction("play", "voice", "story_v_out_116021", "116021018", "story_v_out_116021.awb")
					end

					arg_79_1:RecordHistoryTalkVoice("story_v_out_116021", "116021018", "story_v_out_116021.awb")
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
	Play116021019 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 116021019
		arg_83_1.duration_ = 5

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play116021020(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			local var_86_0 = arg_83_1.actors_["1019ui_story"]
			local var_86_1 = 0

			if var_86_1 < arg_83_1.time_ and arg_83_1.time_ <= var_86_1 + arg_86_0 and not isNil(var_86_0) and arg_83_1.var_.characterEffect1019ui_story == nil then
				arg_83_1.var_.characterEffect1019ui_story = var_86_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_86_2 = 0.2

			if var_86_1 <= arg_83_1.time_ and arg_83_1.time_ < var_86_1 + var_86_2 and not isNil(var_86_0) then
				local var_86_3 = (arg_83_1.time_ - var_86_1) / var_86_2

				if arg_83_1.var_.characterEffect1019ui_story and not isNil(var_86_0) then
					local var_86_4 = Mathf.Lerp(0, 0.5, var_86_3)

					arg_83_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_83_1.var_.characterEffect1019ui_story.fillRatio = var_86_4
				end
			end

			if arg_83_1.time_ >= var_86_1 + var_86_2 and arg_83_1.time_ < var_86_1 + var_86_2 + arg_86_0 and not isNil(var_86_0) and arg_83_1.var_.characterEffect1019ui_story then
				local var_86_5 = 0.5

				arg_83_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_83_1.var_.characterEffect1019ui_story.fillRatio = var_86_5
			end

			local var_86_6 = 0

			if var_86_6 < arg_83_1.time_ and arg_83_1.time_ <= var_86_6 + arg_86_0 then
				arg_83_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action5_2")
			end

			local var_86_7 = 0
			local var_86_8 = 0.35

			if var_86_7 < arg_83_1.time_ and arg_83_1.time_ <= var_86_7 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				local var_86_9 = arg_83_1:FormatText(StoryNameCfg[7].name)

				arg_83_1.leftNameTxt_.text = var_86_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, true)
				arg_83_1.iconController_:SetSelectedState("hero")

				arg_83_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_83_1.callingController_:SetSelectedState("normal")

				arg_83_1.keyicon_.color = Color.New(1, 1, 1)
				arg_83_1.icon_.color = Color.New(1, 1, 1)

				local var_86_10 = arg_83_1:GetWordFromCfg(116021019)
				local var_86_11 = arg_83_1:FormatText(var_86_10.content)

				arg_83_1.text_.text = var_86_11

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_12 = 14
				local var_86_13 = utf8.len(var_86_11)
				local var_86_14 = var_86_12 <= 0 and var_86_8 or var_86_8 * (var_86_13 / var_86_12)

				if var_86_14 > 0 and var_86_8 < var_86_14 then
					arg_83_1.talkMaxDuration = var_86_14

					if var_86_14 + var_86_7 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_14 + var_86_7
					end
				end

				arg_83_1.text_.text = var_86_11
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)
				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_15 = math.max(var_86_8, arg_83_1.talkMaxDuration)

			if var_86_7 <= arg_83_1.time_ and arg_83_1.time_ < var_86_7 + var_86_15 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_7) / var_86_15

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_7 + var_86_15 and arg_83_1.time_ < var_86_7 + var_86_15 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {}

		arg_83_1:InitPlayNodeList()
	end,
	Play116021020 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 116021020
		arg_87_1.duration_ = 12.1

		local var_87_0 = {
			zh = 8.9,
			ja = 12.1
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
				arg_87_0:Play116021021(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			local var_90_0 = 0
			local var_90_1 = 1.1

			if var_90_0 < arg_87_1.time_ and arg_87_1.time_ <= var_90_0 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				local var_90_2 = arg_87_1:FormatText(StoryNameCfg[9].name)

				arg_87_1.leftNameTxt_.text = var_90_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, true)
				arg_87_1.iconController_:SetSelectedState("hero")

				arg_87_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1039")

				arg_87_1.callingController_:SetSelectedState("normal")

				arg_87_1.keyicon_.color = Color.New(1, 1, 1)
				arg_87_1.icon_.color = Color.New(1, 1, 1)

				local var_90_3 = arg_87_1:GetWordFromCfg(116021020)
				local var_90_4 = arg_87_1:FormatText(var_90_3.content)

				arg_87_1.text_.text = var_90_4

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_5 = 44
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

				if manager.audio:GetVoiceLength("story_v_out_116021", "116021020", "story_v_out_116021.awb") ~= 0 then
					local var_90_8 = manager.audio:GetVoiceLength("story_v_out_116021", "116021020", "story_v_out_116021.awb") / 1000

					if var_90_8 + var_90_0 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_8 + var_90_0
					end

					if var_90_3.prefab_name ~= "" and arg_87_1.actors_[var_90_3.prefab_name] ~= nil then
						local var_90_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_87_1.actors_[var_90_3.prefab_name].transform, "story_v_out_116021", "116021020", "story_v_out_116021.awb")

						arg_87_1:RecordAudio("116021020", var_90_9)
						arg_87_1:RecordAudio("116021020", var_90_9)
					else
						arg_87_1:AudioAction("play", "voice", "story_v_out_116021", "116021020", "story_v_out_116021.awb")
					end

					arg_87_1:RecordHistoryTalkVoice("story_v_out_116021", "116021020", "story_v_out_116021.awb")
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
	Play116021021 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 116021021
		arg_91_1.duration_ = 3.4

		local var_91_0 = {
			zh = 1.766,
			ja = 3.4
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
				arg_91_0:Play116021022(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			local var_94_0 = 0
			local var_94_1 = 0.25

			if var_94_0 < arg_91_1.time_ and arg_91_1.time_ <= var_94_0 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				local var_94_2 = arg_91_1:FormatText(StoryNameCfg[13].name)

				arg_91_1.leftNameTxt_.text = var_94_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, true)
				arg_91_1.iconController_:SetSelectedState("hero")

				arg_91_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019_split_6")

				arg_91_1.callingController_:SetSelectedState("normal")

				arg_91_1.keyicon_.color = Color.New(1, 1, 1)
				arg_91_1.icon_.color = Color.New(1, 1, 1)

				local var_94_3 = arg_91_1:GetWordFromCfg(116021021)
				local var_94_4 = arg_91_1:FormatText(var_94_3.content)

				arg_91_1.text_.text = var_94_4

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_5 = 10
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

				if manager.audio:GetVoiceLength("story_v_out_116021", "116021021", "story_v_out_116021.awb") ~= 0 then
					local var_94_8 = manager.audio:GetVoiceLength("story_v_out_116021", "116021021", "story_v_out_116021.awb") / 1000

					if var_94_8 + var_94_0 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_8 + var_94_0
					end

					if var_94_3.prefab_name ~= "" and arg_91_1.actors_[var_94_3.prefab_name] ~= nil then
						local var_94_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_91_1.actors_[var_94_3.prefab_name].transform, "story_v_out_116021", "116021021", "story_v_out_116021.awb")

						arg_91_1:RecordAudio("116021021", var_94_9)
						arg_91_1:RecordAudio("116021021", var_94_9)
					else
						arg_91_1:AudioAction("play", "voice", "story_v_out_116021", "116021021", "story_v_out_116021.awb")
					end

					arg_91_1:RecordHistoryTalkVoice("story_v_out_116021", "116021021", "story_v_out_116021.awb")
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
	Play116021022 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 116021022
		arg_95_1.duration_ = 7.37

		local var_95_0 = {
			zh = 7.066,
			ja = 7.366
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
				arg_95_0:Play116021023(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			local var_98_0 = arg_95_1.actors_["1019ui_story"]
			local var_98_1 = 0

			if var_98_1 < arg_95_1.time_ and arg_95_1.time_ <= var_98_1 + arg_98_0 and not isNil(var_98_0) and arg_95_1.var_.characterEffect1019ui_story == nil then
				arg_95_1.var_.characterEffect1019ui_story = var_98_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_98_2 = 0.2

			if var_98_1 <= arg_95_1.time_ and arg_95_1.time_ < var_98_1 + var_98_2 and not isNil(var_98_0) then
				local var_98_3 = (arg_95_1.time_ - var_98_1) / var_98_2

				if arg_95_1.var_.characterEffect1019ui_story and not isNil(var_98_0) then
					local var_98_4 = Mathf.Lerp(0, 0.5, var_98_3)

					arg_95_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_95_1.var_.characterEffect1019ui_story.fillRatio = var_98_4
				end
			end

			if arg_95_1.time_ >= var_98_1 + var_98_2 and arg_95_1.time_ < var_98_1 + var_98_2 + arg_98_0 and not isNil(var_98_0) and arg_95_1.var_.characterEffect1019ui_story then
				local var_98_5 = 0.5

				arg_95_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_95_1.var_.characterEffect1019ui_story.fillRatio = var_98_5
			end

			local var_98_6 = 0
			local var_98_7 = 0.675

			if var_98_6 < arg_95_1.time_ and arg_95_1.time_ <= var_98_6 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				local var_98_8 = arg_95_1:FormatText(StoryNameCfg[9].name)

				arg_95_1.leftNameTxt_.text = var_98_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, true)
				arg_95_1.iconController_:SetSelectedState("hero")

				arg_95_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1039")

				arg_95_1.callingController_:SetSelectedState("normal")

				arg_95_1.keyicon_.color = Color.New(1, 1, 1)
				arg_95_1.icon_.color = Color.New(1, 1, 1)

				local var_98_9 = arg_95_1:GetWordFromCfg(116021022)
				local var_98_10 = arg_95_1:FormatText(var_98_9.content)

				arg_95_1.text_.text = var_98_10

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_11 = 27
				local var_98_12 = utf8.len(var_98_10)
				local var_98_13 = var_98_11 <= 0 and var_98_7 or var_98_7 * (var_98_12 / var_98_11)

				if var_98_13 > 0 and var_98_7 < var_98_13 then
					arg_95_1.talkMaxDuration = var_98_13

					if var_98_13 + var_98_6 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_13 + var_98_6
					end
				end

				arg_95_1.text_.text = var_98_10
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116021", "116021022", "story_v_out_116021.awb") ~= 0 then
					local var_98_14 = manager.audio:GetVoiceLength("story_v_out_116021", "116021022", "story_v_out_116021.awb") / 1000

					if var_98_14 + var_98_6 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_14 + var_98_6
					end

					if var_98_9.prefab_name ~= "" and arg_95_1.actors_[var_98_9.prefab_name] ~= nil then
						local var_98_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_95_1.actors_[var_98_9.prefab_name].transform, "story_v_out_116021", "116021022", "story_v_out_116021.awb")

						arg_95_1:RecordAudio("116021022", var_98_15)
						arg_95_1:RecordAudio("116021022", var_98_15)
					else
						arg_95_1:AudioAction("play", "voice", "story_v_out_116021", "116021022", "story_v_out_116021.awb")
					end

					arg_95_1:RecordHistoryTalkVoice("story_v_out_116021", "116021022", "story_v_out_116021.awb")
				end

				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_16 = math.max(var_98_7, arg_95_1.talkMaxDuration)

			if var_98_6 <= arg_95_1.time_ and arg_95_1.time_ < var_98_6 + var_98_16 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_6) / var_98_16

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_6 + var_98_16 and arg_95_1.time_ < var_98_6 + var_98_16 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {}

		arg_95_1:InitPlayNodeList()
	end,
	Play116021023 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 116021023
		arg_99_1.duration_ = 7.17

		local var_99_0 = {
			zh = 7.166,
			ja = 6.366
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
				arg_99_0:Play116021024(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			local var_102_0 = 0
			local var_102_1 = 0.65

			if var_102_0 < arg_99_1.time_ and arg_99_1.time_ <= var_102_0 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, true)

				local var_102_2 = arg_99_1:FormatText(StoryNameCfg[13].name)

				arg_99_1.leftNameTxt_.text = var_102_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, true)
				arg_99_1.iconController_:SetSelectedState("hero")

				arg_99_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019_split_6")

				arg_99_1.callingController_:SetSelectedState("normal")

				arg_99_1.keyicon_.color = Color.New(1, 1, 1)
				arg_99_1.icon_.color = Color.New(1, 1, 1)

				local var_102_3 = arg_99_1:GetWordFromCfg(116021023)
				local var_102_4 = arg_99_1:FormatText(var_102_3.content)

				arg_99_1.text_.text = var_102_4

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_5 = 26
				local var_102_6 = utf8.len(var_102_4)
				local var_102_7 = var_102_5 <= 0 and var_102_1 or var_102_1 * (var_102_6 / var_102_5)

				if var_102_7 > 0 and var_102_1 < var_102_7 then
					arg_99_1.talkMaxDuration = var_102_7

					if var_102_7 + var_102_0 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_7 + var_102_0
					end
				end

				arg_99_1.text_.text = var_102_4
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116021", "116021023", "story_v_out_116021.awb") ~= 0 then
					local var_102_8 = manager.audio:GetVoiceLength("story_v_out_116021", "116021023", "story_v_out_116021.awb") / 1000

					if var_102_8 + var_102_0 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_8 + var_102_0
					end

					if var_102_3.prefab_name ~= "" and arg_99_1.actors_[var_102_3.prefab_name] ~= nil then
						local var_102_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_99_1.actors_[var_102_3.prefab_name].transform, "story_v_out_116021", "116021023", "story_v_out_116021.awb")

						arg_99_1:RecordAudio("116021023", var_102_9)
						arg_99_1:RecordAudio("116021023", var_102_9)
					else
						arg_99_1:AudioAction("play", "voice", "story_v_out_116021", "116021023", "story_v_out_116021.awb")
					end

					arg_99_1:RecordHistoryTalkVoice("story_v_out_116021", "116021023", "story_v_out_116021.awb")
				end

				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_10 = math.max(var_102_1, arg_99_1.talkMaxDuration)

			if var_102_0 <= arg_99_1.time_ and arg_99_1.time_ < var_102_0 + var_102_10 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_0) / var_102_10

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_0 + var_102_10 and arg_99_1.time_ < var_102_0 + var_102_10 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {}

		arg_99_1:InitPlayNodeList()
	end,
	Play116021024 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 116021024
		arg_103_1.duration_ = 6.4

		local var_103_0 = {
			zh = 6.399999999999,
			ja = 6.266666666666
		}
		local var_103_1 = manager.audio:GetLocalizationFlag()

		if var_103_0[var_103_1] ~= nil then
			arg_103_1.duration_ = var_103_0[var_103_1]
		end

		SetActive(arg_103_1.tipsGo_, false)

		function arg_103_1.onSingleLineFinish_()
			arg_103_1.onSingleLineUpdate_ = nil
			arg_103_1.onSingleLineFinish_ = nil
			arg_103_1.state_ = "waiting"
		end

		function arg_103_1.playNext_(arg_105_0)
			if arg_105_0 == 1 then
				arg_103_0:Play116021025(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			local var_106_0 = 1.999999999999

			if var_106_0 < arg_103_1.time_ and arg_103_1.time_ <= var_106_0 + arg_106_0 then
				local var_106_1 = manager.ui.mainCamera.transform.localPosition
				local var_106_2 = Vector3.New(0, 0, 10) + Vector3.New(var_106_1.x, var_106_1.y, 0)
				local var_106_3 = arg_103_1.bgs_.ST07b

				var_106_3.transform.localPosition = var_106_2
				var_106_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_106_4 = var_106_3:GetComponent("SpriteRenderer")

				if var_106_4 and var_106_4.sprite then
					local var_106_5 = (var_106_3.transform.localPosition - var_106_1).z
					local var_106_6 = manager.ui.mainCameraCom_
					local var_106_7 = 2 * var_106_5 * Mathf.Tan(var_106_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_106_8 = var_106_7 * var_106_6.aspect
					local var_106_9 = var_106_4.sprite.bounds.size.x
					local var_106_10 = var_106_4.sprite.bounds.size.y
					local var_106_11 = var_106_8 / var_106_9
					local var_106_12 = var_106_7 / var_106_10
					local var_106_13 = var_106_12 < var_106_11 and var_106_11 or var_106_12

					var_106_3.transform.localScale = Vector3.New(var_106_13, var_106_13, 0)
				end

				for iter_106_0, iter_106_1 in pairs(arg_103_1.bgs_) do
					if iter_106_0 ~= "ST07b" then
						iter_106_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_106_14 = "1037ui_story"

			if arg_103_1.actors_[var_106_14] == nil then
				local var_106_15 = Asset.Load("Char/" .. "1037ui_story")

				if not isNil(var_106_15) then
					local var_106_16 = Object.Instantiate(Asset.Load("Char/" .. "1037ui_story"), arg_103_1.stage_.transform)

					var_106_16.name = var_106_14
					var_106_16.transform.localPosition = Vector3.New(0, 100, 0)
					arg_103_1.actors_[var_106_14] = var_106_16

					local var_106_17 = var_106_16:GetComponentInChildren(typeof(CharacterEffect))

					var_106_17.enabled = true

					local var_106_18 = GameObjectTools.GetOrAddComponent(var_106_16, typeof(DynamicBoneHelper))

					if var_106_18 then
						var_106_18:EnableDynamicBone(false)
					end

					arg_103_1:ShowWeapon(var_106_17.transform, false)

					arg_103_1.var_[var_106_14 .. "Animator"] = var_106_17.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_103_1.var_[var_106_14 .. "Animator"].applyRootMotion = true
					arg_103_1.var_[var_106_14 .. "LipSync"] = var_106_17.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_106_19 = arg_103_1.actors_["1037ui_story"].transform
			local var_106_20 = 3.8

			if var_106_20 < arg_103_1.time_ and arg_103_1.time_ <= var_106_20 + arg_106_0 then
				arg_103_1.var_.moveOldPos1037ui_story = var_106_19.localPosition
			end

			local var_106_21 = 0.001

			if var_106_20 <= arg_103_1.time_ and arg_103_1.time_ < var_106_20 + var_106_21 then
				local var_106_22 = (arg_103_1.time_ - var_106_20) / var_106_21
				local var_106_23 = Vector3.New(0, -1.09, -5.81)

				var_106_19.localPosition = Vector3.Lerp(arg_103_1.var_.moveOldPos1037ui_story, var_106_23, var_106_22)

				local var_106_24 = manager.ui.mainCamera.transform.position - var_106_19.position

				var_106_19.forward = Vector3.New(var_106_24.x, var_106_24.y, var_106_24.z)

				local var_106_25 = var_106_19.localEulerAngles

				var_106_25.z = 0
				var_106_25.x = 0
				var_106_19.localEulerAngles = var_106_25
			end

			if arg_103_1.time_ >= var_106_20 + var_106_21 and arg_103_1.time_ < var_106_20 + var_106_21 + arg_106_0 then
				var_106_19.localPosition = Vector3.New(0, -1.09, -5.81)

				local var_106_26 = manager.ui.mainCamera.transform.position - var_106_19.position

				var_106_19.forward = Vector3.New(var_106_26.x, var_106_26.y, var_106_26.z)

				local var_106_27 = var_106_19.localEulerAngles

				var_106_27.z = 0
				var_106_27.x = 0
				var_106_19.localEulerAngles = var_106_27
			end

			local var_106_28 = arg_103_1.actors_["1037ui_story"]
			local var_106_29 = 3.8

			if var_106_29 < arg_103_1.time_ and arg_103_1.time_ <= var_106_29 + arg_106_0 and not isNil(var_106_28) and arg_103_1.var_.characterEffect1037ui_story == nil then
				arg_103_1.var_.characterEffect1037ui_story = var_106_28:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_106_30 = 0.2

			if var_106_29 <= arg_103_1.time_ and arg_103_1.time_ < var_106_29 + var_106_30 and not isNil(var_106_28) then
				local var_106_31 = (arg_103_1.time_ - var_106_29) / var_106_30

				if arg_103_1.var_.characterEffect1037ui_story and not isNil(var_106_28) then
					arg_103_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_103_1.time_ >= var_106_29 + var_106_30 and arg_103_1.time_ < var_106_29 + var_106_30 + arg_106_0 and not isNil(var_106_28) and arg_103_1.var_.characterEffect1037ui_story then
				arg_103_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			local var_106_32 = 3.8

			if var_106_32 < arg_103_1.time_ and arg_103_1.time_ <= var_106_32 + arg_106_0 then
				arg_103_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action2_1")
			end

			local var_106_33 = 3.8

			if var_106_33 < arg_103_1.time_ and arg_103_1.time_ <= var_106_33 + arg_106_0 then
				arg_103_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_106_34 = 0

			if var_106_34 < arg_103_1.time_ and arg_103_1.time_ <= var_106_34 + arg_106_0 then
				arg_103_1.mask_.enabled = true
				arg_103_1.mask_.raycastTarget = true

				arg_103_1:SetGaussion(false)
			end

			local var_106_35 = 2

			if var_106_34 <= arg_103_1.time_ and arg_103_1.time_ < var_106_34 + var_106_35 then
				local var_106_36 = (arg_103_1.time_ - var_106_34) / var_106_35
				local var_106_37 = Color.New(0, 0, 0)

				var_106_37.a = Mathf.Lerp(0, 1, var_106_36)
				arg_103_1.mask_.color = var_106_37
			end

			if arg_103_1.time_ >= var_106_34 + var_106_35 and arg_103_1.time_ < var_106_34 + var_106_35 + arg_106_0 then
				local var_106_38 = Color.New(0, 0, 0)

				var_106_38.a = 1
				arg_103_1.mask_.color = var_106_38
			end

			local var_106_39 = 2

			if var_106_39 < arg_103_1.time_ and arg_103_1.time_ <= var_106_39 + arg_106_0 then
				arg_103_1.mask_.enabled = true
				arg_103_1.mask_.raycastTarget = true

				arg_103_1:SetGaussion(false)
			end

			local var_106_40 = 2

			if var_106_39 <= arg_103_1.time_ and arg_103_1.time_ < var_106_39 + var_106_40 then
				local var_106_41 = (arg_103_1.time_ - var_106_39) / var_106_40
				local var_106_42 = Color.New(0, 0, 0)

				var_106_42.a = Mathf.Lerp(1, 0, var_106_41)
				arg_103_1.mask_.color = var_106_42
			end

			if arg_103_1.time_ >= var_106_39 + var_106_40 and arg_103_1.time_ < var_106_39 + var_106_40 + arg_106_0 then
				local var_106_43 = Color.New(0, 0, 0)
				local var_106_44 = 0

				arg_103_1.mask_.enabled = false
				var_106_43.a = var_106_44
				arg_103_1.mask_.color = var_106_43
			end

			if arg_103_1.frameCnt_ <= 1 then
				arg_103_1.dialog_:SetActive(false)
			end

			local var_106_45 = 3.999999999999
			local var_106_46 = 0.25

			if var_106_45 < arg_103_1.time_ and arg_103_1.time_ <= var_106_45 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0

				arg_103_1.dialog_:SetActive(true)

				arg_103_1.dialogCg_.alpha = 0

				local var_106_47 = LeanTween.value(arg_103_1.dialog_, 0, 1, 0.3)

				var_106_47:setOnUpdate(LuaHelper.FloatAction(function(arg_107_0)
					arg_103_1.dialogCg_.alpha = arg_107_0
				end))
				var_106_47:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_103_1.dialog_)
					var_106_47:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_103_1.duration_ = arg_103_1.duration_ + 0.3

				SetActive(arg_103_1.leftNameGo_, true)

				local var_106_48 = arg_103_1:FormatText(StoryNameCfg[15].name)

				arg_103_1.leftNameTxt_.text = var_106_48

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_49 = arg_103_1:GetWordFromCfg(116021024)
				local var_106_50 = arg_103_1:FormatText(var_106_49.content)

				arg_103_1.text_.text = var_106_50

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_51 = 10
				local var_106_52 = utf8.len(var_106_50)
				local var_106_53 = var_106_51 <= 0 and var_106_46 or var_106_46 * (var_106_52 / var_106_51)

				if var_106_53 > 0 and var_106_46 < var_106_53 then
					arg_103_1.talkMaxDuration = var_106_53
					var_106_45 = var_106_45 + 0.3

					if var_106_53 + var_106_45 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_53 + var_106_45
					end
				end

				arg_103_1.text_.text = var_106_50
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116021", "116021024", "story_v_out_116021.awb") ~= 0 then
					local var_106_54 = manager.audio:GetVoiceLength("story_v_out_116021", "116021024", "story_v_out_116021.awb") / 1000

					if var_106_54 + var_106_45 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_54 + var_106_45
					end

					if var_106_49.prefab_name ~= "" and arg_103_1.actors_[var_106_49.prefab_name] ~= nil then
						local var_106_55 = LuaForUtil.PlayVoiceWithCriLipsync(arg_103_1.actors_[var_106_49.prefab_name].transform, "story_v_out_116021", "116021024", "story_v_out_116021.awb")

						arg_103_1:RecordAudio("116021024", var_106_55)
						arg_103_1:RecordAudio("116021024", var_106_55)
					else
						arg_103_1:AudioAction("play", "voice", "story_v_out_116021", "116021024", "story_v_out_116021.awb")
					end

					arg_103_1:RecordHistoryTalkVoice("story_v_out_116021", "116021024", "story_v_out_116021.awb")
				end

				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_56 = var_106_45 + 0.3
			local var_106_57 = math.max(var_106_46, arg_103_1.talkMaxDuration)

			if var_106_56 <= arg_103_1.time_ and arg_103_1.time_ < var_106_56 + var_106_57 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_56) / var_106_57

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_56 + var_106_57 and arg_103_1.time_ < var_106_56 + var_106_57 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_103_1:InitPlayNodeList()
	end,
	Play116021025 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 116021025
		arg_109_1.duration_ = 5.37

		local var_109_0 = {
			zh = 5.366,
			ja = 4.966
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
				arg_109_0:Play116021026(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = 0

			if var_112_0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_0 + arg_112_0 then
				arg_109_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action2_2")
			end

			local var_112_1 = 0

			if var_112_1 < arg_109_1.time_ and arg_109_1.time_ <= var_112_1 + arg_112_0 then
				arg_109_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_112_2 = 0
			local var_112_3 = 0.6

			if var_112_2 < arg_109_1.time_ and arg_109_1.time_ <= var_112_2 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				local var_112_4 = arg_109_1:FormatText(StoryNameCfg[15].name)

				arg_109_1.leftNameTxt_.text = var_112_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_5 = arg_109_1:GetWordFromCfg(116021025)
				local var_112_6 = arg_109_1:FormatText(var_112_5.content)

				arg_109_1.text_.text = var_112_6

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_7 = 24
				local var_112_8 = utf8.len(var_112_6)
				local var_112_9 = var_112_7 <= 0 and var_112_3 or var_112_3 * (var_112_8 / var_112_7)

				if var_112_9 > 0 and var_112_3 < var_112_9 then
					arg_109_1.talkMaxDuration = var_112_9

					if var_112_9 + var_112_2 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_9 + var_112_2
					end
				end

				arg_109_1.text_.text = var_112_6
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116021", "116021025", "story_v_out_116021.awb") ~= 0 then
					local var_112_10 = manager.audio:GetVoiceLength("story_v_out_116021", "116021025", "story_v_out_116021.awb") / 1000

					if var_112_10 + var_112_2 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_10 + var_112_2
					end

					if var_112_5.prefab_name ~= "" and arg_109_1.actors_[var_112_5.prefab_name] ~= nil then
						local var_112_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_5.prefab_name].transform, "story_v_out_116021", "116021025", "story_v_out_116021.awb")

						arg_109_1:RecordAudio("116021025", var_112_11)
						arg_109_1:RecordAudio("116021025", var_112_11)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_116021", "116021025", "story_v_out_116021.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_116021", "116021025", "story_v_out_116021.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_12 = math.max(var_112_3, arg_109_1.talkMaxDuration)

			if var_112_2 <= arg_109_1.time_ and arg_109_1.time_ < var_112_2 + var_112_12 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_2) / var_112_12

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_2 + var_112_12 and arg_109_1.time_ < var_112_2 + var_112_12 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play116021026 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 116021026
		arg_113_1.duration_ = 6.83

		local var_113_0 = {
			zh = 5.9,
			ja = 6.833
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
				arg_113_0:Play116021027(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = arg_113_1.actors_["1037ui_story"]
			local var_116_1 = 0

			if var_116_1 < arg_113_1.time_ and arg_113_1.time_ <= var_116_1 + arg_116_0 and not isNil(var_116_0) and arg_113_1.var_.characterEffect1037ui_story == nil then
				arg_113_1.var_.characterEffect1037ui_story = var_116_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_2 = 0.2

			if var_116_1 <= arg_113_1.time_ and arg_113_1.time_ < var_116_1 + var_116_2 and not isNil(var_116_0) then
				local var_116_3 = (arg_113_1.time_ - var_116_1) / var_116_2

				if arg_113_1.var_.characterEffect1037ui_story and not isNil(var_116_0) then
					local var_116_4 = Mathf.Lerp(0, 0.5, var_116_3)

					arg_113_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_113_1.var_.characterEffect1037ui_story.fillRatio = var_116_4
				end
			end

			if arg_113_1.time_ >= var_116_1 + var_116_2 and arg_113_1.time_ < var_116_1 + var_116_2 + arg_116_0 and not isNil(var_116_0) and arg_113_1.var_.characterEffect1037ui_story then
				local var_116_5 = 0.5

				arg_113_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_113_1.var_.characterEffect1037ui_story.fillRatio = var_116_5
			end

			local var_116_6 = 0
			local var_116_7 = 0.675

			if var_116_6 < arg_113_1.time_ and arg_113_1.time_ <= var_116_6 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				local var_116_8 = arg_113_1:FormatText(StoryNameCfg[9].name)

				arg_113_1.leftNameTxt_.text = var_116_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, true)
				arg_113_1.iconController_:SetSelectedState("hero")

				arg_113_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1039")

				arg_113_1.callingController_:SetSelectedState("normal")

				arg_113_1.keyicon_.color = Color.New(1, 1, 1)
				arg_113_1.icon_.color = Color.New(1, 1, 1)

				local var_116_9 = arg_113_1:GetWordFromCfg(116021026)
				local var_116_10 = arg_113_1:FormatText(var_116_9.content)

				arg_113_1.text_.text = var_116_10

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_11 = 27
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

				if manager.audio:GetVoiceLength("story_v_out_116021", "116021026", "story_v_out_116021.awb") ~= 0 then
					local var_116_14 = manager.audio:GetVoiceLength("story_v_out_116021", "116021026", "story_v_out_116021.awb") / 1000

					if var_116_14 + var_116_6 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_14 + var_116_6
					end

					if var_116_9.prefab_name ~= "" and arg_113_1.actors_[var_116_9.prefab_name] ~= nil then
						local var_116_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_9.prefab_name].transform, "story_v_out_116021", "116021026", "story_v_out_116021.awb")

						arg_113_1:RecordAudio("116021026", var_116_15)
						arg_113_1:RecordAudio("116021026", var_116_15)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_116021", "116021026", "story_v_out_116021.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_116021", "116021026", "story_v_out_116021.awb")
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
	Play116021027 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 116021027
		arg_117_1.duration_ = 0.02

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"

			SetActive(arg_117_1.choicesGo_, true)

			for iter_118_0, iter_118_1 in ipairs(arg_117_1.choices_) do
				local var_118_0 = iter_118_0 <= 2

				SetActive(iter_118_1.go, var_118_0)
			end

			arg_117_1.choices_[1].txt.text = arg_117_1:FormatText(StoryChoiceCfg[225].name)
			arg_117_1.choices_[2].txt.text = arg_117_1:FormatText(StoryChoiceCfg[226].name)
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play116021028(arg_117_1)
			end

			if arg_119_0 == 2 then
				arg_117_0:Play116021028(arg_117_1)
			end

			arg_117_1:RecordChoiceLog(116021027, 225, 226)
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			return
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play116021028 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 116021028
		arg_121_1.duration_ = 3.27

		local var_121_0 = {
			zh = 3.266,
			ja = 2.633
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
				arg_121_0:Play116021029(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = 0
			local var_124_1 = 0.2

			if var_124_0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_0 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0

				arg_121_1.dialog_:SetActive(true)

				arg_121_1.dialogCg_.alpha = 0

				local var_124_2 = LeanTween.value(arg_121_1.dialog_, 0, 1, 0.3)

				var_124_2:setOnUpdate(LuaHelper.FloatAction(function(arg_125_0)
					arg_121_1.dialogCg_.alpha = arg_125_0
				end))
				var_124_2:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_121_1.dialog_)
					var_124_2:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_121_1.duration_ = arg_121_1.duration_ + 0.3

				SetActive(arg_121_1.leftNameGo_, true)

				local var_124_3 = arg_121_1:FormatText(StoryNameCfg[9].name)

				arg_121_1.leftNameTxt_.text = var_124_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, true)
				arg_121_1.iconController_:SetSelectedState("hero")

				arg_121_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1039")

				arg_121_1.callingController_:SetSelectedState("normal")

				arg_121_1.keyicon_.color = Color.New(1, 1, 1)
				arg_121_1.icon_.color = Color.New(1, 1, 1)

				local var_124_4 = arg_121_1:GetWordFromCfg(116021028)
				local var_124_5 = arg_121_1:FormatText(var_124_4.content)

				arg_121_1.text_.text = var_124_5

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_6 = 8
				local var_124_7 = utf8.len(var_124_5)
				local var_124_8 = var_124_6 <= 0 and var_124_1 or var_124_1 * (var_124_7 / var_124_6)

				if var_124_8 > 0 and var_124_1 < var_124_8 then
					arg_121_1.talkMaxDuration = var_124_8
					var_124_0 = var_124_0 + 0.3

					if var_124_8 + var_124_0 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_8 + var_124_0
					end
				end

				arg_121_1.text_.text = var_124_5
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116021", "116021028", "story_v_out_116021.awb") ~= 0 then
					local var_124_9 = manager.audio:GetVoiceLength("story_v_out_116021", "116021028", "story_v_out_116021.awb") / 1000

					if var_124_9 + var_124_0 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_9 + var_124_0
					end

					if var_124_4.prefab_name ~= "" and arg_121_1.actors_[var_124_4.prefab_name] ~= nil then
						local var_124_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_4.prefab_name].transform, "story_v_out_116021", "116021028", "story_v_out_116021.awb")

						arg_121_1:RecordAudio("116021028", var_124_10)
						arg_121_1:RecordAudio("116021028", var_124_10)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_116021", "116021028", "story_v_out_116021.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_116021", "116021028", "story_v_out_116021.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_11 = var_124_0 + 0.3
			local var_124_12 = math.max(var_124_1, arg_121_1.talkMaxDuration)

			if var_124_11 <= arg_121_1.time_ and arg_121_1.time_ < var_124_11 + var_124_12 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_11) / var_124_12

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_11 + var_124_12 and arg_121_1.time_ < var_124_11 + var_124_12 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {}

		arg_121_1:InitPlayNodeList()
	end,
	Play116021029 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 116021029
		arg_127_1.duration_ = 9

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play116021030(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = arg_127_1.actors_["1037ui_story"].transform
			local var_130_1 = 1.966

			if var_130_1 < arg_127_1.time_ and arg_127_1.time_ <= var_130_1 + arg_130_0 then
				arg_127_1.var_.moveOldPos1037ui_story = var_130_0.localPosition
			end

			local var_130_2 = 0.001

			if var_130_1 <= arg_127_1.time_ and arg_127_1.time_ < var_130_1 + var_130_2 then
				local var_130_3 = (arg_127_1.time_ - var_130_1) / var_130_2
				local var_130_4 = Vector3.New(0, 100, 0)

				var_130_0.localPosition = Vector3.Lerp(arg_127_1.var_.moveOldPos1037ui_story, var_130_4, var_130_3)

				local var_130_5 = manager.ui.mainCamera.transform.position - var_130_0.position

				var_130_0.forward = Vector3.New(var_130_5.x, var_130_5.y, var_130_5.z)

				local var_130_6 = var_130_0.localEulerAngles

				var_130_6.z = 0
				var_130_6.x = 0
				var_130_0.localEulerAngles = var_130_6
			end

			if arg_127_1.time_ >= var_130_1 + var_130_2 and arg_127_1.time_ < var_130_1 + var_130_2 + arg_130_0 then
				var_130_0.localPosition = Vector3.New(0, 100, 0)

				local var_130_7 = manager.ui.mainCamera.transform.position - var_130_0.position

				var_130_0.forward = Vector3.New(var_130_7.x, var_130_7.y, var_130_7.z)

				local var_130_8 = var_130_0.localEulerAngles

				var_130_8.z = 0
				var_130_8.x = 0
				var_130_0.localEulerAngles = var_130_8
			end

			local var_130_9 = 0

			if var_130_9 < arg_127_1.time_ and arg_127_1.time_ <= var_130_9 + arg_130_0 then
				arg_127_1.mask_.enabled = true
				arg_127_1.mask_.raycastTarget = true

				arg_127_1:SetGaussion(false)
			end

			local var_130_10 = 2

			if var_130_9 <= arg_127_1.time_ and arg_127_1.time_ < var_130_9 + var_130_10 then
				local var_130_11 = (arg_127_1.time_ - var_130_9) / var_130_10
				local var_130_12 = Color.New(0, 0, 0)

				var_130_12.a = Mathf.Lerp(0, 1, var_130_11)
				arg_127_1.mask_.color = var_130_12
			end

			if arg_127_1.time_ >= var_130_9 + var_130_10 and arg_127_1.time_ < var_130_9 + var_130_10 + arg_130_0 then
				local var_130_13 = Color.New(0, 0, 0)

				var_130_13.a = 1
				arg_127_1.mask_.color = var_130_13
			end

			local var_130_14 = 2

			if var_130_14 < arg_127_1.time_ and arg_127_1.time_ <= var_130_14 + arg_130_0 then
				arg_127_1.mask_.enabled = true
				arg_127_1.mask_.raycastTarget = true

				arg_127_1:SetGaussion(false)
			end

			local var_130_15 = 2

			if var_130_14 <= arg_127_1.time_ and arg_127_1.time_ < var_130_14 + var_130_15 then
				local var_130_16 = (arg_127_1.time_ - var_130_14) / var_130_15
				local var_130_17 = Color.New(0, 0, 0)

				var_130_17.a = Mathf.Lerp(1, 0, var_130_16)
				arg_127_1.mask_.color = var_130_17
			end

			if arg_127_1.time_ >= var_130_14 + var_130_15 and arg_127_1.time_ < var_130_14 + var_130_15 + arg_130_0 then
				local var_130_18 = Color.New(0, 0, 0)
				local var_130_19 = 0

				arg_127_1.mask_.enabled = false
				var_130_18.a = var_130_19
				arg_127_1.mask_.color = var_130_18
			end

			local var_130_20 = "B13"

			if arg_127_1.bgs_[var_130_20] == nil then
				local var_130_21 = Object.Instantiate(arg_127_1.paintGo_)

				var_130_21:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_130_20)
				var_130_21.name = var_130_20
				var_130_21.transform.parent = arg_127_1.stage_.transform
				var_130_21.transform.localPosition = Vector3.New(0, 100, 0)
				arg_127_1.bgs_[var_130_20] = var_130_21
			end

			local var_130_22 = 2

			if var_130_22 < arg_127_1.time_ and arg_127_1.time_ <= var_130_22 + arg_130_0 then
				local var_130_23 = manager.ui.mainCamera.transform.localPosition
				local var_130_24 = Vector3.New(0, 0, 10) + Vector3.New(var_130_23.x, var_130_23.y, 0)
				local var_130_25 = arg_127_1.bgs_.B13

				var_130_25.transform.localPosition = var_130_24
				var_130_25.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_130_26 = var_130_25:GetComponent("SpriteRenderer")

				if var_130_26 and var_130_26.sprite then
					local var_130_27 = (var_130_25.transform.localPosition - var_130_23).z
					local var_130_28 = manager.ui.mainCameraCom_
					local var_130_29 = 2 * var_130_27 * Mathf.Tan(var_130_28.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_130_30 = var_130_29 * var_130_28.aspect
					local var_130_31 = var_130_26.sprite.bounds.size.x
					local var_130_32 = var_130_26.sprite.bounds.size.y
					local var_130_33 = var_130_30 / var_130_31
					local var_130_34 = var_130_29 / var_130_32
					local var_130_35 = var_130_34 < var_130_33 and var_130_33 or var_130_34

					var_130_25.transform.localScale = Vector3.New(var_130_35, var_130_35, 0)
				end

				for iter_130_0, iter_130_1 in pairs(arg_127_1.bgs_) do
					if iter_130_0 ~= "B13" then
						iter_130_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if arg_127_1.frameCnt_ <= 1 then
				arg_127_1.dialog_:SetActive(false)
			end

			local var_130_36 = 4
			local var_130_37 = 0.425

			if var_130_36 < arg_127_1.time_ and arg_127_1.time_ <= var_130_36 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0

				arg_127_1.dialog_:SetActive(true)

				arg_127_1.dialogCg_.alpha = 0

				local var_130_38 = LeanTween.value(arg_127_1.dialog_, 0, 1, 0.3)

				var_130_38:setOnUpdate(LuaHelper.FloatAction(function(arg_131_0)
					arg_127_1.dialogCg_.alpha = arg_131_0
				end))
				var_130_38:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_127_1.dialog_)
					var_130_38:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_127_1.duration_ = arg_127_1.duration_ + 0.3

				SetActive(arg_127_1.leftNameGo_, false)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_39 = arg_127_1:GetWordFromCfg(116021029)
				local var_130_40 = arg_127_1:FormatText(var_130_39.content)

				arg_127_1.text_.text = var_130_40

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_41 = 17
				local var_130_42 = utf8.len(var_130_40)
				local var_130_43 = var_130_41 <= 0 and var_130_37 or var_130_37 * (var_130_42 / var_130_41)

				if var_130_43 > 0 and var_130_37 < var_130_43 then
					arg_127_1.talkMaxDuration = var_130_43
					var_130_36 = var_130_36 + 0.3

					if var_130_43 + var_130_36 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_43 + var_130_36
					end
				end

				arg_127_1.text_.text = var_130_40
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)
				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_44 = var_130_36 + 0.3
			local var_130_45 = math.max(var_130_37, arg_127_1.talkMaxDuration)

			if var_130_44 <= arg_127_1.time_ and arg_127_1.time_ < var_130_44 + var_130_45 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_44) / var_130_45

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_44 + var_130_45 and arg_127_1.time_ < var_130_44 + var_130_45 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_127_1:InitPlayNodeList()
	end,
	Play116021030 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 116021030
		arg_133_1.duration_ = 5

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play116021031(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = 0
			local var_136_1 = 1.475

			if var_136_0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_0 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, false)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_2 = arg_133_1:GetWordFromCfg(116021030)
				local var_136_3 = arg_133_1:FormatText(var_136_2.content)

				arg_133_1.text_.text = var_136_3

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_4 = 59
				local var_136_5 = utf8.len(var_136_3)
				local var_136_6 = var_136_4 <= 0 and var_136_1 or var_136_1 * (var_136_5 / var_136_4)

				if var_136_6 > 0 and var_136_1 < var_136_6 then
					arg_133_1.talkMaxDuration = var_136_6

					if var_136_6 + var_136_0 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_6 + var_136_0
					end
				end

				arg_133_1.text_.text = var_136_3
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)
				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_7 = math.max(var_136_1, arg_133_1.talkMaxDuration)

			if var_136_0 <= arg_133_1.time_ and arg_133_1.time_ < var_136_0 + var_136_7 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_0) / var_136_7

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_0 + var_136_7 and arg_133_1.time_ < var_136_0 + var_136_7 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play116021031 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 116021031
		arg_137_1.duration_ = 9

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play116021032(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = "SK0105"

			if arg_137_1.bgs_[var_140_0] == nil then
				local var_140_1 = Object.Instantiate(arg_137_1.paintGo_)

				var_140_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_140_0)
				var_140_1.name = var_140_0
				var_140_1.transform.parent = arg_137_1.stage_.transform
				var_140_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_137_1.bgs_[var_140_0] = var_140_1
			end

			local var_140_2 = 2

			if var_140_2 < arg_137_1.time_ and arg_137_1.time_ <= var_140_2 + arg_140_0 then
				local var_140_3 = manager.ui.mainCamera.transform.localPosition
				local var_140_4 = Vector3.New(0, 0, 10) + Vector3.New(var_140_3.x, var_140_3.y, 0)
				local var_140_5 = arg_137_1.bgs_.SK0105

				var_140_5.transform.localPosition = var_140_4
				var_140_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_140_6 = var_140_5:GetComponent("SpriteRenderer")

				if var_140_6 and var_140_6.sprite then
					local var_140_7 = (var_140_5.transform.localPosition - var_140_3).z
					local var_140_8 = manager.ui.mainCameraCom_
					local var_140_9 = 2 * var_140_7 * Mathf.Tan(var_140_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_140_10 = var_140_9 * var_140_8.aspect
					local var_140_11 = var_140_6.sprite.bounds.size.x
					local var_140_12 = var_140_6.sprite.bounds.size.y
					local var_140_13 = var_140_10 / var_140_11
					local var_140_14 = var_140_9 / var_140_12
					local var_140_15 = var_140_14 < var_140_13 and var_140_13 or var_140_14

					var_140_5.transform.localScale = Vector3.New(var_140_15, var_140_15, 0)
				end

				for iter_140_0, iter_140_1 in pairs(arg_137_1.bgs_) do
					if iter_140_0 ~= "SK0105" then
						iter_140_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_140_16 = 0

			if var_140_16 < arg_137_1.time_ and arg_137_1.time_ <= var_140_16 + arg_140_0 then
				arg_137_1.mask_.enabled = true
				arg_137_1.mask_.raycastTarget = true

				arg_137_1:SetGaussion(false)
			end

			local var_140_17 = 2

			if var_140_16 <= arg_137_1.time_ and arg_137_1.time_ < var_140_16 + var_140_17 then
				local var_140_18 = (arg_137_1.time_ - var_140_16) / var_140_17
				local var_140_19 = Color.New(0, 0, 0)

				var_140_19.a = Mathf.Lerp(0, 1, var_140_18)
				arg_137_1.mask_.color = var_140_19
			end

			if arg_137_1.time_ >= var_140_16 + var_140_17 and arg_137_1.time_ < var_140_16 + var_140_17 + arg_140_0 then
				local var_140_20 = Color.New(0, 0, 0)

				var_140_20.a = 1
				arg_137_1.mask_.color = var_140_20
			end

			local var_140_21 = 2

			if var_140_21 < arg_137_1.time_ and arg_137_1.time_ <= var_140_21 + arg_140_0 then
				arg_137_1.mask_.enabled = true
				arg_137_1.mask_.raycastTarget = true

				arg_137_1:SetGaussion(false)
			end

			local var_140_22 = 2

			if var_140_21 <= arg_137_1.time_ and arg_137_1.time_ < var_140_21 + var_140_22 then
				local var_140_23 = (arg_137_1.time_ - var_140_21) / var_140_22
				local var_140_24 = Color.New(0, 0, 0)

				var_140_24.a = Mathf.Lerp(1, 0, var_140_23)
				arg_137_1.mask_.color = var_140_24
			end

			if arg_137_1.time_ >= var_140_21 + var_140_22 and arg_137_1.time_ < var_140_21 + var_140_22 + arg_140_0 then
				local var_140_25 = Color.New(0, 0, 0)
				local var_140_26 = 0

				arg_137_1.mask_.enabled = false
				var_140_25.a = var_140_26
				arg_137_1.mask_.color = var_140_25
			end

			local var_140_27 = arg_137_1.bgs_.SK0105.transform
			local var_140_28 = 2

			if var_140_28 < arg_137_1.time_ and arg_137_1.time_ <= var_140_28 + arg_140_0 then
				arg_137_1.var_.moveOldPosSK0105 = var_140_27.localPosition
			end

			local var_140_29 = 0.001

			if var_140_28 <= arg_137_1.time_ and arg_137_1.time_ < var_140_28 + var_140_29 then
				local var_140_30 = (arg_137_1.time_ - var_140_28) / var_140_29
				local var_140_31 = Vector3.New(0.5, 2, 1.5)

				var_140_27.localPosition = Vector3.Lerp(arg_137_1.var_.moveOldPosSK0105, var_140_31, var_140_30)
			end

			if arg_137_1.time_ >= var_140_28 + var_140_29 and arg_137_1.time_ < var_140_28 + var_140_29 + arg_140_0 then
				var_140_27.localPosition = Vector3.New(0.5, 2, 1.5)
			end

			local var_140_32 = arg_137_1.bgs_.SK0105.transform
			local var_140_33 = 2.034

			if var_140_33 < arg_137_1.time_ and arg_137_1.time_ <= var_140_33 + arg_140_0 then
				arg_137_1.var_.moveOldPosSK0105 = var_140_32.localPosition
			end

			local var_140_34 = 6.5

			if var_140_33 <= arg_137_1.time_ and arg_137_1.time_ < var_140_33 + var_140_34 then
				local var_140_35 = (arg_137_1.time_ - var_140_33) / var_140_34
				local var_140_36 = Vector3.New(0.5, 1, 1.5)

				var_140_32.localPosition = Vector3.Lerp(arg_137_1.var_.moveOldPosSK0105, var_140_36, var_140_35)
			end

			if arg_137_1.time_ >= var_140_33 + var_140_34 and arg_137_1.time_ < var_140_33 + var_140_34 + arg_140_0 then
				var_140_32.localPosition = Vector3.New(0.5, 1, 1.5)
			end

			local var_140_37 = 4

			if var_140_37 < arg_137_1.time_ and arg_137_1.time_ <= var_140_37 + arg_140_0 then
				arg_137_1.allBtn_.enabled = false
			end

			local var_140_38 = 4.534

			if arg_137_1.time_ >= var_140_37 + var_140_38 and arg_137_1.time_ < var_140_37 + var_140_38 + arg_140_0 then
				arg_137_1.allBtn_.enabled = true
			end

			if arg_137_1.frameCnt_ <= 1 then
				arg_137_1.dialog_:SetActive(false)
			end

			local var_140_39 = 4
			local var_140_40 = 0.6

			if var_140_39 < arg_137_1.time_ and arg_137_1.time_ <= var_140_39 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0

				arg_137_1.dialog_:SetActive(true)

				arg_137_1.dialogCg_.alpha = 0

				local var_140_41 = LeanTween.value(arg_137_1.dialog_, 0, 1, 0.3)

				var_140_41:setOnUpdate(LuaHelper.FloatAction(function(arg_141_0)
					arg_137_1.dialogCg_.alpha = arg_141_0
				end))
				var_140_41:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_137_1.dialog_)
					var_140_41:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_137_1.duration_ = arg_137_1.duration_ + 0.3

				SetActive(arg_137_1.leftNameGo_, false)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_42 = arg_137_1:GetWordFromCfg(116021031)
				local var_140_43 = arg_137_1:FormatText(var_140_42.content)

				arg_137_1.text_.text = var_140_43

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_44 = 44
				local var_140_45 = utf8.len(var_140_43)
				local var_140_46 = var_140_44 <= 0 and var_140_40 or var_140_40 * (var_140_45 / var_140_44)

				if var_140_46 > 0 and var_140_40 < var_140_46 then
					arg_137_1.talkMaxDuration = var_140_46
					var_140_39 = var_140_39 + 0.3

					if var_140_46 + var_140_39 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_46 + var_140_39
					end
				end

				arg_137_1.text_.text = var_140_43
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)
				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_47 = var_140_39 + 0.3
			local var_140_48 = math.max(var_140_40, arg_137_1.talkMaxDuration)

			if var_140_47 <= arg_137_1.time_ and arg_137_1.time_ < var_140_47 + var_140_48 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_47) / var_140_48

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_47 + var_140_48 and arg_137_1.time_ < var_140_47 + var_140_48 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "SK0105",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "SK0105",
				changeDisplayLayer = false,
				needEase = false,
				duration = 6.5,
				className = "StoryMoveNode",
				startTime = 2.034,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_137_1:InitPlayNodeList()
	end,
	Play116021032 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 116021032
		arg_143_1.duration_ = 1

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play116021033(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = 0
			local var_146_1 = 1

			if var_146_0 < arg_143_1.time_ and arg_143_1.time_ <= var_146_0 + arg_146_0 then
				local var_146_2 = "play"
				local var_146_3 = "effect"

				arg_143_1:AudioAction(var_146_2, var_146_3, "se_story_16", "se_story_16_door06", "")
			end

			local var_146_4 = 0
			local var_146_5 = 0.05

			if var_146_4 < arg_143_1.time_ and arg_143_1.time_ <= var_146_4 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				local var_146_6 = arg_143_1:FormatText(StoryNameCfg[319].name)

				arg_143_1.leftNameTxt_.text = var_146_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, true)
				arg_143_1.iconController_:SetSelectedState("hero")

				arg_143_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1029")

				arg_143_1.callingController_:SetSelectedState("normal")

				arg_143_1.keyicon_.color = Color.New(1, 1, 1)
				arg_143_1.icon_.color = Color.New(1, 1, 1)

				local var_146_7 = arg_143_1:GetWordFromCfg(116021032)
				local var_146_8 = arg_143_1:FormatText(var_146_7.content)

				arg_143_1.text_.text = var_146_8

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_9 = 2
				local var_146_10 = utf8.len(var_146_8)
				local var_146_11 = var_146_9 <= 0 and var_146_5 or var_146_5 * (var_146_10 / var_146_9)

				if var_146_11 > 0 and var_146_5 < var_146_11 then
					arg_143_1.talkMaxDuration = var_146_11

					if var_146_11 + var_146_4 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_11 + var_146_4
					end
				end

				arg_143_1.text_.text = var_146_8
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116021", "116021032", "story_v_out_116021.awb") ~= 0 then
					local var_146_12 = manager.audio:GetVoiceLength("story_v_out_116021", "116021032", "story_v_out_116021.awb") / 1000

					if var_146_12 + var_146_4 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_12 + var_146_4
					end

					if var_146_7.prefab_name ~= "" and arg_143_1.actors_[var_146_7.prefab_name] ~= nil then
						local var_146_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_7.prefab_name].transform, "story_v_out_116021", "116021032", "story_v_out_116021.awb")

						arg_143_1:RecordAudio("116021032", var_146_13)
						arg_143_1:RecordAudio("116021032", var_146_13)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_out_116021", "116021032", "story_v_out_116021.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_out_116021", "116021032", "story_v_out_116021.awb")
				end

				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_14 = math.max(var_146_5, arg_143_1.talkMaxDuration)

			if var_146_4 <= arg_143_1.time_ and arg_143_1.time_ < var_146_4 + var_146_14 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_4) / var_146_14

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_4 + var_146_14 and arg_143_1.time_ < var_146_4 + var_146_14 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {}

		arg_143_1:InitPlayNodeList()
	end,
	Play116021033 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 116021033
		arg_147_1.duration_ = 5

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play116021034(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_0 = 0
			local var_150_1 = 1.675

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

				local var_150_2 = arg_147_1:GetWordFromCfg(116021033)
				local var_150_3 = arg_147_1:FormatText(var_150_2.content)

				arg_147_1.text_.text = var_150_3

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_4 = 67
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
	Play116021034 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 116021034
		arg_151_1.duration_ = 5

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play116021035(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = 0
			local var_154_1 = 1.55

			if var_154_0 < arg_151_1.time_ and arg_151_1.time_ <= var_154_0 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, false)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_2 = arg_151_1:GetWordFromCfg(116021034)
				local var_154_3 = arg_151_1:FormatText(var_154_2.content)

				arg_151_1.text_.text = var_154_3

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_4 = 62
				local var_154_5 = utf8.len(var_154_3)
				local var_154_6 = var_154_4 <= 0 and var_154_1 or var_154_1 * (var_154_5 / var_154_4)

				if var_154_6 > 0 and var_154_1 < var_154_6 then
					arg_151_1.talkMaxDuration = var_154_6

					if var_154_6 + var_154_0 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_6 + var_154_0
					end
				end

				arg_151_1.text_.text = var_154_3
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)
				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_7 = math.max(var_154_1, arg_151_1.talkMaxDuration)

			if var_154_0 <= arg_151_1.time_ and arg_151_1.time_ < var_154_0 + var_154_7 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_0) / var_154_7

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_0 + var_154_7 and arg_151_1.time_ < var_154_0 + var_154_7 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {}

		arg_151_1:InitPlayNodeList()
	end,
	Play116021035 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 116021035
		arg_155_1.duration_ = 5

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play116021036(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = 0
			local var_158_1 = 1.4

			if var_158_0 < arg_155_1.time_ and arg_155_1.time_ <= var_158_0 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, false)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_2 = arg_155_1:GetWordFromCfg(116021035)
				local var_158_3 = arg_155_1:FormatText(var_158_2.content)

				arg_155_1.text_.text = var_158_3

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_4 = 56
				local var_158_5 = utf8.len(var_158_3)
				local var_158_6 = var_158_4 <= 0 and var_158_1 or var_158_1 * (var_158_5 / var_158_4)

				if var_158_6 > 0 and var_158_1 < var_158_6 then
					arg_155_1.talkMaxDuration = var_158_6

					if var_158_6 + var_158_0 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_6 + var_158_0
					end
				end

				arg_155_1.text_.text = var_158_3
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)
				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_7 = math.max(var_158_1, arg_155_1.talkMaxDuration)

			if var_158_0 <= arg_155_1.time_ and arg_155_1.time_ < var_158_0 + var_158_7 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_0) / var_158_7

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_0 + var_158_7 and arg_155_1.time_ < var_158_0 + var_158_7 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {}

		arg_155_1:InitPlayNodeList()
	end,
	Play116021036 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 116021036
		arg_159_1.duration_ = 5.5

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play116021037(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_0 = arg_159_1.bgs_.SK0105.transform
			local var_162_1 = 0

			if var_162_1 < arg_159_1.time_ and arg_159_1.time_ <= var_162_1 + arg_162_0 then
				arg_159_1.var_.moveOldPosSK0105 = var_162_0.localPosition
			end

			local var_162_2 = 5

			if var_162_1 <= arg_159_1.time_ and arg_159_1.time_ < var_162_1 + var_162_2 then
				local var_162_3 = (arg_159_1.time_ - var_162_1) / var_162_2
				local var_162_4 = Vector3.New(0.5, -0.5, 1.5)

				var_162_0.localPosition = Vector3.Lerp(arg_159_1.var_.moveOldPosSK0105, var_162_4, var_162_3)
			end

			if arg_159_1.time_ >= var_162_1 + var_162_2 and arg_159_1.time_ < var_162_1 + var_162_2 + arg_162_0 then
				var_162_0.localPosition = Vector3.New(0.5, -0.5, 1.5)
			end

			local var_162_5 = 0

			if var_162_5 < arg_159_1.time_ and arg_159_1.time_ <= var_162_5 + arg_162_0 then
				arg_159_1.allBtn_.enabled = false
			end

			local var_162_6 = 5

			if arg_159_1.time_ >= var_162_5 + var_162_6 and arg_159_1.time_ < var_162_5 + var_162_6 + arg_162_0 then
				arg_159_1.allBtn_.enabled = true
			end

			local var_162_7 = 0
			local var_162_8 = 1.75

			if var_162_7 < arg_159_1.time_ and arg_159_1.time_ <= var_162_7 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, false)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_9 = arg_159_1:GetWordFromCfg(116021036)
				local var_162_10 = arg_159_1:FormatText(var_162_9.content)

				arg_159_1.text_.text = var_162_10

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_11 = 70
				local var_162_12 = utf8.len(var_162_10)
				local var_162_13 = var_162_11 <= 0 and var_162_8 or var_162_8 * (var_162_12 / var_162_11)

				if var_162_13 > 0 and var_162_8 < var_162_13 then
					arg_159_1.talkMaxDuration = var_162_13

					if var_162_13 + var_162_7 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_13 + var_162_7
					end
				end

				arg_159_1.text_.text = var_162_10
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)
				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_14 = math.max(var_162_8, arg_159_1.talkMaxDuration)

			if var_162_7 <= arg_159_1.time_ and arg_159_1.time_ < var_162_7 + var_162_14 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_7) / var_162_14

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_7 + var_162_14 and arg_159_1.time_ < var_162_7 + var_162_14 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "SK0105",
				changeDisplayLayer = false,
				needEase = false,
				duration = 5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_159_1:InitPlayNodeList()
	end,
	Play116021037 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 116021037
		arg_163_1.duration_ = 7.9

		local var_163_0 = {
			zh = 6.934,
			ja = 7.9
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
				arg_163_0:Play116021038(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			local var_166_0 = arg_163_1.bgs_.SK0105.transform
			local var_166_1 = 1.966

			if var_166_1 < arg_163_1.time_ and arg_163_1.time_ <= var_166_1 + arg_166_0 then
				arg_163_1.var_.moveOldPosSK0105 = var_166_0.localPosition
			end

			local var_166_2 = 0.001

			if var_166_1 <= arg_163_1.time_ and arg_163_1.time_ < var_166_1 + var_166_2 then
				local var_166_3 = (arg_163_1.time_ - var_166_1) / var_166_2
				local var_166_4 = Vector3.New(-3, 0.3, 3.2)

				var_166_0.localPosition = Vector3.Lerp(arg_163_1.var_.moveOldPosSK0105, var_166_4, var_166_3)
			end

			if arg_163_1.time_ >= var_166_1 + var_166_2 and arg_163_1.time_ < var_166_1 + var_166_2 + arg_166_0 then
				var_166_0.localPosition = Vector3.New(-3, 0.3, 3.2)
			end

			local var_166_5 = arg_163_1.bgs_.SK0105.transform
			local var_166_6 = 2

			if var_166_6 < arg_163_1.time_ and arg_163_1.time_ <= var_166_6 + arg_166_0 then
				arg_163_1.var_.moveOldPosSK0105 = var_166_5.localPosition
			end

			local var_166_7 = 4

			if var_166_6 <= arg_163_1.time_ and arg_163_1.time_ < var_166_6 + var_166_7 then
				local var_166_8 = (arg_163_1.time_ - var_166_6) / var_166_7
				local var_166_9 = Vector3.New(-3, 0, 3.2)

				var_166_5.localPosition = Vector3.Lerp(arg_163_1.var_.moveOldPosSK0105, var_166_9, var_166_8)
			end

			if arg_163_1.time_ >= var_166_6 + var_166_7 and arg_163_1.time_ < var_166_6 + var_166_7 + arg_166_0 then
				var_166_5.localPosition = Vector3.New(-3, 0, 3.2)
			end

			local var_166_10 = 0

			if var_166_10 < arg_163_1.time_ and arg_163_1.time_ <= var_166_10 + arg_166_0 then
				arg_163_1.mask_.enabled = true
				arg_163_1.mask_.raycastTarget = true

				arg_163_1:SetGaussion(false)
			end

			local var_166_11 = 2

			if var_166_10 <= arg_163_1.time_ and arg_163_1.time_ < var_166_10 + var_166_11 then
				local var_166_12 = (arg_163_1.time_ - var_166_10) / var_166_11
				local var_166_13 = Color.New(0, 0, 0)

				var_166_13.a = Mathf.Lerp(0, 1, var_166_12)
				arg_163_1.mask_.color = var_166_13
			end

			if arg_163_1.time_ >= var_166_10 + var_166_11 and arg_163_1.time_ < var_166_10 + var_166_11 + arg_166_0 then
				local var_166_14 = Color.New(0, 0, 0)

				var_166_14.a = 1
				arg_163_1.mask_.color = var_166_14
			end

			local var_166_15 = 2

			if var_166_15 < arg_163_1.time_ and arg_163_1.time_ <= var_166_15 + arg_166_0 then
				arg_163_1.mask_.enabled = true
				arg_163_1.mask_.raycastTarget = true

				arg_163_1:SetGaussion(false)
			end

			local var_166_16 = 2

			if var_166_15 <= arg_163_1.time_ and arg_163_1.time_ < var_166_15 + var_166_16 then
				local var_166_17 = (arg_163_1.time_ - var_166_15) / var_166_16
				local var_166_18 = Color.New(0, 0, 0)

				var_166_18.a = Mathf.Lerp(1, 0, var_166_17)
				arg_163_1.mask_.color = var_166_18
			end

			if arg_163_1.time_ >= var_166_15 + var_166_16 and arg_163_1.time_ < var_166_15 + var_166_16 + arg_166_0 then
				local var_166_19 = Color.New(0, 0, 0)
				local var_166_20 = 0

				arg_163_1.mask_.enabled = false
				var_166_19.a = var_166_20
				arg_163_1.mask_.color = var_166_19
			end

			local var_166_21 = 4

			if var_166_21 < arg_163_1.time_ and arg_163_1.time_ <= var_166_21 + arg_166_0 then
				arg_163_1.allBtn_.enabled = false
			end

			local var_166_22 = 2

			if arg_163_1.time_ >= var_166_21 + var_166_22 and arg_163_1.time_ < var_166_21 + var_166_22 + arg_166_0 then
				arg_163_1.allBtn_.enabled = true
			end

			if arg_163_1.frameCnt_ <= 1 then
				arg_163_1.dialog_:SetActive(false)
			end

			local var_166_23 = 2.034
			local var_166_24 = 0.6

			if var_166_23 < arg_163_1.time_ and arg_163_1.time_ <= var_166_23 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0

				arg_163_1.dialog_:SetActive(true)

				arg_163_1.dialogCg_.alpha = 0

				local var_166_25 = LeanTween.value(arg_163_1.dialog_, 0, 1, 0.3)

				var_166_25:setOnUpdate(LuaHelper.FloatAction(function(arg_167_0)
					arg_163_1.dialogCg_.alpha = arg_167_0
				end))
				var_166_25:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_163_1.dialog_)
					var_166_25:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_163_1.duration_ = arg_163_1.duration_ + 0.3

				SetActive(arg_163_1.leftNameGo_, true)

				local var_166_26 = arg_163_1:FormatText(StoryNameCfg[13].name)

				arg_163_1.leftNameTxt_.text = var_166_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, true)
				arg_163_1.iconController_:SetSelectedState("hero")

				arg_163_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019")

				arg_163_1.callingController_:SetSelectedState("normal")

				arg_163_1.keyicon_.color = Color.New(1, 1, 1)
				arg_163_1.icon_.color = Color.New(1, 1, 1)

				local var_166_27 = arg_163_1:GetWordFromCfg(116021037)
				local var_166_28 = arg_163_1:FormatText(var_166_27.content)

				arg_163_1.text_.text = var_166_28

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_29 = 24
				local var_166_30 = utf8.len(var_166_28)
				local var_166_31 = var_166_29 <= 0 and var_166_24 or var_166_24 * (var_166_30 / var_166_29)

				if var_166_31 > 0 and var_166_24 < var_166_31 then
					arg_163_1.talkMaxDuration = var_166_31
					var_166_23 = var_166_23 + 0.3

					if var_166_31 + var_166_23 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_31 + var_166_23
					end
				end

				arg_163_1.text_.text = var_166_28
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116021", "116021037", "story_v_out_116021.awb") ~= 0 then
					local var_166_32 = manager.audio:GetVoiceLength("story_v_out_116021", "116021037", "story_v_out_116021.awb") / 1000

					if var_166_32 + var_166_23 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_32 + var_166_23
					end

					if var_166_27.prefab_name ~= "" and arg_163_1.actors_[var_166_27.prefab_name] ~= nil then
						local var_166_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_27.prefab_name].transform, "story_v_out_116021", "116021037", "story_v_out_116021.awb")

						arg_163_1:RecordAudio("116021037", var_166_33)
						arg_163_1:RecordAudio("116021037", var_166_33)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_out_116021", "116021037", "story_v_out_116021.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_out_116021", "116021037", "story_v_out_116021.awb")
				end

				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_34 = var_166_23 + 0.3
			local var_166_35 = math.max(var_166_24, arg_163_1.talkMaxDuration)

			if var_166_34 <= arg_163_1.time_ and arg_163_1.time_ < var_166_34 + var_166_35 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_34) / var_166_35

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_34 + var_166_35 and arg_163_1.time_ < var_166_34 + var_166_35 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "SK0105",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "SK0105",
				changeDisplayLayer = false,
				needEase = false,
				duration = 4,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_163_1:InitPlayNodeList()
	end,
	Play116021038 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 116021038
		arg_169_1.duration_ = 10.9

		local var_169_0 = {
			zh = 6.9,
			ja = 10.9
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
				arg_169_0:Play116021039(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = arg_169_1.bgs_.SK0105.transform
			local var_172_1 = 2

			if var_172_1 < arg_169_1.time_ and arg_169_1.time_ <= var_172_1 + arg_172_0 then
				arg_169_1.var_.moveOldPosSK0105 = var_172_0.localPosition
			end

			local var_172_2 = 0.001

			if var_172_1 <= arg_169_1.time_ and arg_169_1.time_ < var_172_1 + var_172_2 then
				local var_172_3 = (arg_169_1.time_ - var_172_1) / var_172_2
				local var_172_4 = Vector3.New(3.4, 0, 2.5)

				var_172_0.localPosition = Vector3.Lerp(arg_169_1.var_.moveOldPosSK0105, var_172_4, var_172_3)
			end

			if arg_169_1.time_ >= var_172_1 + var_172_2 and arg_169_1.time_ < var_172_1 + var_172_2 + arg_172_0 then
				var_172_0.localPosition = Vector3.New(3.4, 0, 2.5)
			end

			local var_172_5 = arg_169_1.bgs_.SK0105.transform
			local var_172_6 = 2.034

			if var_172_6 < arg_169_1.time_ and arg_169_1.time_ <= var_172_6 + arg_172_0 then
				arg_169_1.var_.moveOldPosSK0105 = var_172_5.localPosition
			end

			local var_172_7 = 2

			if var_172_6 <= arg_169_1.time_ and arg_169_1.time_ < var_172_6 + var_172_7 then
				local var_172_8 = (arg_169_1.time_ - var_172_6) / var_172_7
				local var_172_9 = Vector3.New(3.4, -0.5, 2.5)

				var_172_5.localPosition = Vector3.Lerp(arg_169_1.var_.moveOldPosSK0105, var_172_9, var_172_8)
			end

			if arg_169_1.time_ >= var_172_6 + var_172_7 and arg_169_1.time_ < var_172_6 + var_172_7 + arg_172_0 then
				var_172_5.localPosition = Vector3.New(3.4, -0.5, 2.5)
			end

			local var_172_10 = 0

			if var_172_10 < arg_169_1.time_ and arg_169_1.time_ <= var_172_10 + arg_172_0 then
				arg_169_1.mask_.enabled = true
				arg_169_1.mask_.raycastTarget = true

				arg_169_1:SetGaussion(false)
			end

			local var_172_11 = 2

			if var_172_10 <= arg_169_1.time_ and arg_169_1.time_ < var_172_10 + var_172_11 then
				local var_172_12 = (arg_169_1.time_ - var_172_10) / var_172_11
				local var_172_13 = Color.New(0, 0, 0)

				var_172_13.a = Mathf.Lerp(0, 1, var_172_12)
				arg_169_1.mask_.color = var_172_13
			end

			if arg_169_1.time_ >= var_172_10 + var_172_11 and arg_169_1.time_ < var_172_10 + var_172_11 + arg_172_0 then
				local var_172_14 = Color.New(0, 0, 0)

				var_172_14.a = 1
				arg_169_1.mask_.color = var_172_14
			end

			local var_172_15 = 2

			if var_172_15 < arg_169_1.time_ and arg_169_1.time_ <= var_172_15 + arg_172_0 then
				arg_169_1.mask_.enabled = true
				arg_169_1.mask_.raycastTarget = true

				arg_169_1:SetGaussion(false)
			end

			local var_172_16 = 2

			if var_172_15 <= arg_169_1.time_ and arg_169_1.time_ < var_172_15 + var_172_16 then
				local var_172_17 = (arg_169_1.time_ - var_172_15) / var_172_16
				local var_172_18 = Color.New(0, 0, 0)

				var_172_18.a = Mathf.Lerp(1, 0, var_172_17)
				arg_169_1.mask_.color = var_172_18
			end

			if arg_169_1.time_ >= var_172_15 + var_172_16 and arg_169_1.time_ < var_172_15 + var_172_16 + arg_172_0 then
				local var_172_19 = Color.New(0, 0, 0)
				local var_172_20 = 0

				arg_169_1.mask_.enabled = false
				var_172_19.a = var_172_20
				arg_169_1.mask_.color = var_172_19
			end

			if arg_169_1.frameCnt_ <= 1 then
				arg_169_1.dialog_:SetActive(false)
			end

			local var_172_21 = 2
			local var_172_22 = 0.65

			if var_172_21 < arg_169_1.time_ and arg_169_1.time_ <= var_172_21 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0

				arg_169_1.dialog_:SetActive(true)

				arg_169_1.dialogCg_.alpha = 0

				local var_172_23 = LeanTween.value(arg_169_1.dialog_, 0, 1, 0.3)

				var_172_23:setOnUpdate(LuaHelper.FloatAction(function(arg_173_0)
					arg_169_1.dialogCg_.alpha = arg_173_0
				end))
				var_172_23:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_169_1.dialog_)
					var_172_23:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_169_1.duration_ = arg_169_1.duration_ + 0.3

				SetActive(arg_169_1.leftNameGo_, true)

				local var_172_24 = arg_169_1:FormatText(StoryNameCfg[13].name)

				arg_169_1.leftNameTxt_.text = var_172_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, true)
				arg_169_1.iconController_:SetSelectedState("hero")

				arg_169_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019")

				arg_169_1.callingController_:SetSelectedState("normal")

				arg_169_1.keyicon_.color = Color.New(1, 1, 1)
				arg_169_1.icon_.color = Color.New(1, 1, 1)

				local var_172_25 = arg_169_1:GetWordFromCfg(116021038)
				local var_172_26 = arg_169_1:FormatText(var_172_25.content)

				arg_169_1.text_.text = var_172_26

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_27 = 26
				local var_172_28 = utf8.len(var_172_26)
				local var_172_29 = var_172_27 <= 0 and var_172_22 or var_172_22 * (var_172_28 / var_172_27)

				if var_172_29 > 0 and var_172_22 < var_172_29 then
					arg_169_1.talkMaxDuration = var_172_29
					var_172_21 = var_172_21 + 0.3

					if var_172_29 + var_172_21 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_29 + var_172_21
					end
				end

				arg_169_1.text_.text = var_172_26
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116021", "116021038", "story_v_out_116021.awb") ~= 0 then
					local var_172_30 = manager.audio:GetVoiceLength("story_v_out_116021", "116021038", "story_v_out_116021.awb") / 1000

					if var_172_30 + var_172_21 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_30 + var_172_21
					end

					if var_172_25.prefab_name ~= "" and arg_169_1.actors_[var_172_25.prefab_name] ~= nil then
						local var_172_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_25.prefab_name].transform, "story_v_out_116021", "116021038", "story_v_out_116021.awb")

						arg_169_1:RecordAudio("116021038", var_172_31)
						arg_169_1:RecordAudio("116021038", var_172_31)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_out_116021", "116021038", "story_v_out_116021.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_out_116021", "116021038", "story_v_out_116021.awb")
				end

				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_32 = var_172_21 + 0.3
			local var_172_33 = math.max(var_172_22, arg_169_1.talkMaxDuration)

			if var_172_32 <= arg_169_1.time_ and arg_169_1.time_ < var_172_32 + var_172_33 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_32) / var_172_33

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_32 + var_172_33 and arg_169_1.time_ < var_172_32 + var_172_33 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "SK0105",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "SK0105",
				changeDisplayLayer = false,
				needEase = false,
				duration = 2,
				className = "StoryMoveNode",
				startTime = 2.034,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_169_1:InitPlayNodeList()
	end,
	Play116021039 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 116021039
		arg_175_1.duration_ = 9

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play116021040(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = arg_175_1.bgs_.SK0105.transform
			local var_178_1 = 2

			if var_178_1 < arg_175_1.time_ and arg_175_1.time_ <= var_178_1 + arg_178_0 then
				arg_175_1.var_.moveOldPosSK0105 = var_178_0.localPosition
			end

			local var_178_2 = 0.001

			if var_178_1 <= arg_175_1.time_ and arg_175_1.time_ < var_178_1 + var_178_2 then
				local var_178_3 = (arg_175_1.time_ - var_178_1) / var_178_2
				local var_178_4 = Vector3.New(0, 1, 10)

				var_178_0.localPosition = Vector3.Lerp(arg_175_1.var_.moveOldPosSK0105, var_178_4, var_178_3)
			end

			if arg_175_1.time_ >= var_178_1 + var_178_2 and arg_175_1.time_ < var_178_1 + var_178_2 + arg_178_0 then
				var_178_0.localPosition = Vector3.New(0, 1, 10)
			end

			local var_178_5 = 0

			if var_178_5 < arg_175_1.time_ and arg_175_1.time_ <= var_178_5 + arg_178_0 then
				arg_175_1.mask_.enabled = true
				arg_175_1.mask_.raycastTarget = true

				arg_175_1:SetGaussion(false)
			end

			local var_178_6 = 2

			if var_178_5 <= arg_175_1.time_ and arg_175_1.time_ < var_178_5 + var_178_6 then
				local var_178_7 = (arg_175_1.time_ - var_178_5) / var_178_6
				local var_178_8 = Color.New(0, 0, 0)

				var_178_8.a = Mathf.Lerp(0, 1, var_178_7)
				arg_175_1.mask_.color = var_178_8
			end

			if arg_175_1.time_ >= var_178_5 + var_178_6 and arg_175_1.time_ < var_178_5 + var_178_6 + arg_178_0 then
				local var_178_9 = Color.New(0, 0, 0)

				var_178_9.a = 1
				arg_175_1.mask_.color = var_178_9
			end

			local var_178_10 = 2

			if var_178_10 < arg_175_1.time_ and arg_175_1.time_ <= var_178_10 + arg_178_0 then
				arg_175_1.mask_.enabled = true
				arg_175_1.mask_.raycastTarget = true

				arg_175_1:SetGaussion(false)
			end

			local var_178_11 = 2

			if var_178_10 <= arg_175_1.time_ and arg_175_1.time_ < var_178_10 + var_178_11 then
				local var_178_12 = (arg_175_1.time_ - var_178_10) / var_178_11
				local var_178_13 = Color.New(0, 0, 0)

				var_178_13.a = Mathf.Lerp(1, 0, var_178_12)
				arg_175_1.mask_.color = var_178_13
			end

			if arg_175_1.time_ >= var_178_10 + var_178_11 and arg_175_1.time_ < var_178_10 + var_178_11 + arg_178_0 then
				local var_178_14 = Color.New(0, 0, 0)
				local var_178_15 = 0

				arg_175_1.mask_.enabled = false
				var_178_14.a = var_178_15
				arg_175_1.mask_.color = var_178_14
			end

			if arg_175_1.frameCnt_ <= 1 then
				arg_175_1.dialog_:SetActive(false)
			end

			local var_178_16 = 4
			local var_178_17 = 0.275

			if var_178_16 < arg_175_1.time_ and arg_175_1.time_ <= var_178_16 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0

				arg_175_1.dialog_:SetActive(true)

				arg_175_1.dialogCg_.alpha = 0

				local var_178_18 = LeanTween.value(arg_175_1.dialog_, 0, 1, 0.3)

				var_178_18:setOnUpdate(LuaHelper.FloatAction(function(arg_179_0)
					arg_175_1.dialogCg_.alpha = arg_179_0
				end))
				var_178_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_175_1.dialog_)
					var_178_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_175_1.duration_ = arg_175_1.duration_ + 0.3

				SetActive(arg_175_1.leftNameGo_, true)

				local var_178_19 = arg_175_1:FormatText(StoryNameCfg[7].name)

				arg_175_1.leftNameTxt_.text = var_178_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, true)
				arg_175_1.iconController_:SetSelectedState("hero")

				arg_175_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_175_1.callingController_:SetSelectedState("normal")

				arg_175_1.keyicon_.color = Color.New(1, 1, 1)
				arg_175_1.icon_.color = Color.New(1, 1, 1)

				local var_178_20 = arg_175_1:GetWordFromCfg(116021039)
				local var_178_21 = arg_175_1:FormatText(var_178_20.content)

				arg_175_1.text_.text = var_178_21

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_22 = 19
				local var_178_23 = utf8.len(var_178_21)
				local var_178_24 = var_178_22 <= 0 and var_178_17 or var_178_17 * (var_178_23 / var_178_22)

				if var_178_24 > 0 and var_178_17 < var_178_24 then
					arg_175_1.talkMaxDuration = var_178_24
					var_178_16 = var_178_16 + 0.3

					if var_178_24 + var_178_16 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_24 + var_178_16
					end
				end

				arg_175_1.text_.text = var_178_21
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)
				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_25 = var_178_16 + 0.3
			local var_178_26 = math.max(var_178_17, arg_175_1.talkMaxDuration)

			if var_178_25 <= arg_175_1.time_ and arg_175_1.time_ < var_178_25 + var_178_26 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_25) / var_178_26

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_25 + var_178_26 and arg_175_1.time_ < var_178_25 + var_178_26 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "SK0105",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_175_1:InitPlayNodeList()
	end,
	Play116021040 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 116021040
		arg_181_1.duration_ = 11.77

		local var_181_0 = {
			zh = 9.833,
			ja = 11.766
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
				arg_181_0:Play116021041(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = 0
			local var_184_1 = 1.05

			if var_184_0 < arg_181_1.time_ and arg_181_1.time_ <= var_184_0 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				local var_184_2 = arg_181_1:FormatText(StoryNameCfg[327].name)

				arg_181_1.leftNameTxt_.text = var_184_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_3 = arg_181_1:GetWordFromCfg(116021040)
				local var_184_4 = arg_181_1:FormatText(var_184_3.content)

				arg_181_1.text_.text = var_184_4

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_5 = 42
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

				if manager.audio:GetVoiceLength("story_v_out_116021", "116021040", "story_v_out_116021.awb") ~= 0 then
					local var_184_8 = manager.audio:GetVoiceLength("story_v_out_116021", "116021040", "story_v_out_116021.awb") / 1000

					if var_184_8 + var_184_0 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_8 + var_184_0
					end

					if var_184_3.prefab_name ~= "" and arg_181_1.actors_[var_184_3.prefab_name] ~= nil then
						local var_184_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_3.prefab_name].transform, "story_v_out_116021", "116021040", "story_v_out_116021.awb")

						arg_181_1:RecordAudio("116021040", var_184_9)
						arg_181_1:RecordAudio("116021040", var_184_9)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_out_116021", "116021040", "story_v_out_116021.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_out_116021", "116021040", "story_v_out_116021.awb")
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
	Play116021041 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 116021041
		arg_185_1.duration_ = 0.02

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"

			SetActive(arg_185_1.choicesGo_, true)

			for iter_186_0, iter_186_1 in ipairs(arg_185_1.choices_) do
				local var_186_0 = iter_186_0 <= 2

				SetActive(iter_186_1.go, var_186_0)
			end

			arg_185_1.choices_[1].txt.text = arg_185_1:FormatText(StoryChoiceCfg[227].name)
			arg_185_1.choices_[2].txt.text = arg_185_1:FormatText(StoryChoiceCfg[228].name)
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play116021042(arg_185_1)
			end

			if arg_187_0 == 2 then
				arg_185_0:Play116021044(arg_185_1)
			end

			arg_185_1:RecordChoiceLog(116021041, 227, 228)
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			return
		end

		arg_185_1.nodeConfigList_ = {}

		arg_185_1:InitPlayNodeList()
	end,
	Play116021042 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 116021042
		arg_189_1.duration_ = 9.03

		local var_189_0 = {
			zh = 8.133,
			ja = 9.033
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
				arg_189_0:Play116021043(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = 0
			local var_192_1 = 0.9

			if var_192_0 < arg_189_1.time_ and arg_189_1.time_ <= var_192_0 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				local var_192_2 = arg_189_1:FormatText(StoryNameCfg[327].name)

				arg_189_1.leftNameTxt_.text = var_192_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_3 = arg_189_1:GetWordFromCfg(116021042)
				local var_192_4 = arg_189_1:FormatText(var_192_3.content)

				arg_189_1.text_.text = var_192_4

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_5 = 36
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

				if manager.audio:GetVoiceLength("story_v_out_116021", "116021042", "story_v_out_116021.awb") ~= 0 then
					local var_192_8 = manager.audio:GetVoiceLength("story_v_out_116021", "116021042", "story_v_out_116021.awb") / 1000

					if var_192_8 + var_192_0 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_8 + var_192_0
					end

					if var_192_3.prefab_name ~= "" and arg_189_1.actors_[var_192_3.prefab_name] ~= nil then
						local var_192_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_3.prefab_name].transform, "story_v_out_116021", "116021042", "story_v_out_116021.awb")

						arg_189_1:RecordAudio("116021042", var_192_9)
						arg_189_1:RecordAudio("116021042", var_192_9)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_116021", "116021042", "story_v_out_116021.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_116021", "116021042", "story_v_out_116021.awb")
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
	Play116021043 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 116021043
		arg_193_1.duration_ = 5

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play116021045(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = 0
			local var_196_1 = 0.15

			if var_196_0 < arg_193_1.time_ and arg_193_1.time_ <= var_196_0 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				local var_196_2 = arg_193_1:FormatText(StoryNameCfg[7].name)

				arg_193_1.leftNameTxt_.text = var_196_2

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

				local var_196_3 = arg_193_1:GetWordFromCfg(116021043)
				local var_196_4 = arg_193_1:FormatText(var_196_3.content)

				arg_193_1.text_.text = var_196_4

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_5 = 6
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
				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_8 = math.max(var_196_1, arg_193_1.talkMaxDuration)

			if var_196_0 <= arg_193_1.time_ and arg_193_1.time_ < var_196_0 + var_196_8 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_0) / var_196_8

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_0 + var_196_8 and arg_193_1.time_ < var_196_0 + var_196_8 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {}

		arg_193_1:InitPlayNodeList()
	end,
	Play116021045 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 116021045
		arg_197_1.duration_ = 12

		local var_197_0 = {
			zh = 12,
			ja = 9.833
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
				arg_197_0:Play116021046(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = "A00"

			if arg_197_1.bgs_[var_200_0] == nil then
				local var_200_1 = Object.Instantiate(arg_197_1.paintGo_)

				var_200_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_200_0)
				var_200_1.name = var_200_0
				var_200_1.transform.parent = arg_197_1.stage_.transform
				var_200_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_197_1.bgs_[var_200_0] = var_200_1
			end

			local var_200_2 = 2

			if var_200_2 < arg_197_1.time_ and arg_197_1.time_ <= var_200_2 + arg_200_0 then
				local var_200_3 = manager.ui.mainCamera.transform.localPosition
				local var_200_4 = Vector3.New(0, 0, 10) + Vector3.New(var_200_3.x, var_200_3.y, 0)
				local var_200_5 = arg_197_1.bgs_.A00

				var_200_5.transform.localPosition = var_200_4
				var_200_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_200_6 = var_200_5:GetComponent("SpriteRenderer")

				if var_200_6 and var_200_6.sprite then
					local var_200_7 = (var_200_5.transform.localPosition - var_200_3).z
					local var_200_8 = manager.ui.mainCameraCom_
					local var_200_9 = 2 * var_200_7 * Mathf.Tan(var_200_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_200_10 = var_200_9 * var_200_8.aspect
					local var_200_11 = var_200_6.sprite.bounds.size.x
					local var_200_12 = var_200_6.sprite.bounds.size.y
					local var_200_13 = var_200_10 / var_200_11
					local var_200_14 = var_200_9 / var_200_12
					local var_200_15 = var_200_14 < var_200_13 and var_200_13 or var_200_14

					var_200_5.transform.localScale = Vector3.New(var_200_15, var_200_15, 0)
				end

				for iter_200_0, iter_200_1 in pairs(arg_197_1.bgs_) do
					if iter_200_0 ~= "A00" then
						iter_200_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_200_16 = "1029ui_story"

			if arg_197_1.actors_[var_200_16] == nil then
				local var_200_17 = Asset.Load("Char/" .. "1029ui_story")

				if not isNil(var_200_17) then
					local var_200_18 = Object.Instantiate(Asset.Load("Char/" .. "1029ui_story"), arg_197_1.stage_.transform)

					var_200_18.name = var_200_16
					var_200_18.transform.localPosition = Vector3.New(0, 100, 0)
					arg_197_1.actors_[var_200_16] = var_200_18

					local var_200_19 = var_200_18:GetComponentInChildren(typeof(CharacterEffect))

					var_200_19.enabled = true

					local var_200_20 = GameObjectTools.GetOrAddComponent(var_200_18, typeof(DynamicBoneHelper))

					if var_200_20 then
						var_200_20:EnableDynamicBone(false)
					end

					arg_197_1:ShowWeapon(var_200_19.transform, false)

					arg_197_1.var_[var_200_16 .. "Animator"] = var_200_19.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_197_1.var_[var_200_16 .. "Animator"].applyRootMotion = true
					arg_197_1.var_[var_200_16 .. "LipSync"] = var_200_19.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_200_21 = arg_197_1.actors_["1029ui_story"].transform
			local var_200_22 = 3.8

			if var_200_22 < arg_197_1.time_ and arg_197_1.time_ <= var_200_22 + arg_200_0 then
				arg_197_1.var_.moveOldPos1029ui_story = var_200_21.localPosition
			end

			local var_200_23 = 0.001

			if var_200_22 <= arg_197_1.time_ and arg_197_1.time_ < var_200_22 + var_200_23 then
				local var_200_24 = (arg_197_1.time_ - var_200_22) / var_200_23
				local var_200_25 = Vector3.New(0, -1.09, -6.2)

				var_200_21.localPosition = Vector3.Lerp(arg_197_1.var_.moveOldPos1029ui_story, var_200_25, var_200_24)

				local var_200_26 = manager.ui.mainCamera.transform.position - var_200_21.position

				var_200_21.forward = Vector3.New(var_200_26.x, var_200_26.y, var_200_26.z)

				local var_200_27 = var_200_21.localEulerAngles

				var_200_27.z = 0
				var_200_27.x = 0
				var_200_21.localEulerAngles = var_200_27
			end

			if arg_197_1.time_ >= var_200_22 + var_200_23 and arg_197_1.time_ < var_200_22 + var_200_23 + arg_200_0 then
				var_200_21.localPosition = Vector3.New(0, -1.09, -6.2)

				local var_200_28 = manager.ui.mainCamera.transform.position - var_200_21.position

				var_200_21.forward = Vector3.New(var_200_28.x, var_200_28.y, var_200_28.z)

				local var_200_29 = var_200_21.localEulerAngles

				var_200_29.z = 0
				var_200_29.x = 0
				var_200_21.localEulerAngles = var_200_29
			end

			local var_200_30 = 3.8

			if var_200_30 < arg_197_1.time_ and arg_197_1.time_ <= var_200_30 + arg_200_0 then
				arg_197_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action1_1")
			end

			local var_200_31 = 3.8

			if var_200_31 < arg_197_1.time_ and arg_197_1.time_ <= var_200_31 + arg_200_0 then
				arg_197_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_200_32 = arg_197_1.actors_["1029ui_story"]
			local var_200_33 = 3.8

			if var_200_33 < arg_197_1.time_ and arg_197_1.time_ <= var_200_33 + arg_200_0 and not isNil(var_200_32) and arg_197_1.var_.characterEffect1029ui_story == nil then
				arg_197_1.var_.characterEffect1029ui_story = var_200_32:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_200_34 = 0.2

			if var_200_33 <= arg_197_1.time_ and arg_197_1.time_ < var_200_33 + var_200_34 and not isNil(var_200_32) then
				local var_200_35 = (arg_197_1.time_ - var_200_33) / var_200_34

				if arg_197_1.var_.characterEffect1029ui_story and not isNil(var_200_32) then
					arg_197_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_197_1.time_ >= var_200_33 + var_200_34 and arg_197_1.time_ < var_200_33 + var_200_34 + arg_200_0 and not isNil(var_200_32) and arg_197_1.var_.characterEffect1029ui_story then
				arg_197_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_200_36 = 0

			if var_200_36 < arg_197_1.time_ and arg_197_1.time_ <= var_200_36 + arg_200_0 then
				arg_197_1.mask_.enabled = true
				arg_197_1.mask_.raycastTarget = true

				arg_197_1:SetGaussion(false)
			end

			local var_200_37 = 2

			if var_200_36 <= arg_197_1.time_ and arg_197_1.time_ < var_200_36 + var_200_37 then
				local var_200_38 = (arg_197_1.time_ - var_200_36) / var_200_37
				local var_200_39 = Color.New(0, 0, 0)

				var_200_39.a = Mathf.Lerp(0, 1, var_200_38)
				arg_197_1.mask_.color = var_200_39
			end

			if arg_197_1.time_ >= var_200_36 + var_200_37 and arg_197_1.time_ < var_200_36 + var_200_37 + arg_200_0 then
				local var_200_40 = Color.New(0, 0, 0)

				var_200_40.a = 1
				arg_197_1.mask_.color = var_200_40
			end

			local var_200_41 = 2

			if var_200_41 < arg_197_1.time_ and arg_197_1.time_ <= var_200_41 + arg_200_0 then
				arg_197_1.mask_.enabled = true
				arg_197_1.mask_.raycastTarget = true

				arg_197_1:SetGaussion(false)
			end

			local var_200_42 = 2

			if var_200_41 <= arg_197_1.time_ and arg_197_1.time_ < var_200_41 + var_200_42 then
				local var_200_43 = (arg_197_1.time_ - var_200_41) / var_200_42
				local var_200_44 = Color.New(0, 0, 0)

				var_200_44.a = Mathf.Lerp(1, 0, var_200_43)
				arg_197_1.mask_.color = var_200_44
			end

			if arg_197_1.time_ >= var_200_41 + var_200_42 and arg_197_1.time_ < var_200_41 + var_200_42 + arg_200_0 then
				local var_200_45 = Color.New(0, 0, 0)
				local var_200_46 = 0

				arg_197_1.mask_.enabled = false
				var_200_45.a = var_200_46
				arg_197_1.mask_.color = var_200_45
			end

			if arg_197_1.frameCnt_ <= 1 then
				arg_197_1.dialog_:SetActive(false)
			end

			local var_200_47 = 4
			local var_200_48 = 0.75

			if var_200_47 < arg_197_1.time_ and arg_197_1.time_ <= var_200_47 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0

				arg_197_1.dialog_:SetActive(true)

				arg_197_1.dialogCg_.alpha = 0

				local var_200_49 = LeanTween.value(arg_197_1.dialog_, 0, 1, 0.3)

				var_200_49:setOnUpdate(LuaHelper.FloatAction(function(arg_201_0)
					arg_197_1.dialogCg_.alpha = arg_201_0
				end))
				var_200_49:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_197_1.dialog_)
					var_200_49:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_197_1.duration_ = arg_197_1.duration_ + 0.3

				SetActive(arg_197_1.leftNameGo_, true)

				local var_200_50 = arg_197_1:FormatText(StoryNameCfg[319].name)

				arg_197_1.leftNameTxt_.text = var_200_50

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_51 = arg_197_1:GetWordFromCfg(116021045)
				local var_200_52 = arg_197_1:FormatText(var_200_51.content)

				arg_197_1.text_.text = var_200_52

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_53 = 38
				local var_200_54 = utf8.len(var_200_52)
				local var_200_55 = var_200_53 <= 0 and var_200_48 or var_200_48 * (var_200_54 / var_200_53)

				if var_200_55 > 0 and var_200_48 < var_200_55 then
					arg_197_1.talkMaxDuration = var_200_55
					var_200_47 = var_200_47 + 0.3

					if var_200_55 + var_200_47 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_55 + var_200_47
					end
				end

				arg_197_1.text_.text = var_200_52
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116021", "116021045", "story_v_out_116021.awb") ~= 0 then
					local var_200_56 = manager.audio:GetVoiceLength("story_v_out_116021", "116021045", "story_v_out_116021.awb") / 1000

					if var_200_56 + var_200_47 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_56 + var_200_47
					end

					if var_200_51.prefab_name ~= "" and arg_197_1.actors_[var_200_51.prefab_name] ~= nil then
						local var_200_57 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_51.prefab_name].transform, "story_v_out_116021", "116021045", "story_v_out_116021.awb")

						arg_197_1:RecordAudio("116021045", var_200_57)
						arg_197_1:RecordAudio("116021045", var_200_57)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_out_116021", "116021045", "story_v_out_116021.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_out_116021", "116021045", "story_v_out_116021.awb")
				end

				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_58 = var_200_47 + 0.3
			local var_200_59 = math.max(var_200_48, arg_197_1.talkMaxDuration)

			if var_200_58 <= arg_197_1.time_ and arg_197_1.time_ < var_200_58 + var_200_59 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_58) / var_200_59

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_58 + var_200_59 and arg_197_1.time_ < var_200_58 + var_200_59 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1029ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_197_1:InitPlayNodeList()
	end,
	Play116021046 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 116021046
		arg_203_1.duration_ = 0.2

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"

			SetActive(arg_203_1.choicesGo_, true)

			for iter_204_0, iter_204_1 in ipairs(arg_203_1.choices_) do
				local var_204_0 = iter_204_0 <= 2

				SetActive(iter_204_1.go, var_204_0)
			end

			arg_203_1.choices_[1].txt.text = arg_203_1:FormatText(StoryChoiceCfg[229].name)
			arg_203_1.choices_[2].txt.text = arg_203_1:FormatText(StoryChoiceCfg[230].name)
		end

		function arg_203_1.playNext_(arg_205_0)
			if arg_205_0 == 1 then
				arg_203_0:Play116021047(arg_203_1)
			end

			if arg_205_0 == 2 then
				arg_203_0:Play116021047(arg_203_1)
			end

			arg_203_1:RecordChoiceLog(116021046, 229, 230)
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			local var_206_0 = arg_203_1.actors_["1029ui_story"]
			local var_206_1 = 0

			if var_206_1 < arg_203_1.time_ and arg_203_1.time_ <= var_206_1 + arg_206_0 and not isNil(var_206_0) and arg_203_1.var_.characterEffect1029ui_story == nil then
				arg_203_1.var_.characterEffect1029ui_story = var_206_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_206_2 = 0.2

			if var_206_1 <= arg_203_1.time_ and arg_203_1.time_ < var_206_1 + var_206_2 and not isNil(var_206_0) then
				local var_206_3 = (arg_203_1.time_ - var_206_1) / var_206_2

				if arg_203_1.var_.characterEffect1029ui_story and not isNil(var_206_0) then
					local var_206_4 = Mathf.Lerp(0, 0.5, var_206_3)

					arg_203_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_203_1.var_.characterEffect1029ui_story.fillRatio = var_206_4
				end
			end

			if arg_203_1.time_ >= var_206_1 + var_206_2 and arg_203_1.time_ < var_206_1 + var_206_2 + arg_206_0 and not isNil(var_206_0) and arg_203_1.var_.characterEffect1029ui_story then
				local var_206_5 = 0.5

				arg_203_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_203_1.var_.characterEffect1029ui_story.fillRatio = var_206_5
			end
		end

		arg_203_1.nodeConfigList_ = {}

		arg_203_1:InitPlayNodeList()
	end,
	Play116021047 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 116021047
		arg_207_1.duration_ = 5.93

		local var_207_0 = {
			zh = 5.933,
			ja = 5.633
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
				arg_207_0:Play116021048(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			local var_210_0 = "1029ui_story"

			if arg_207_1.actors_[var_210_0] == nil then
				local var_210_1 = Asset.Load("Char/" .. "1029ui_story")

				if not isNil(var_210_1) then
					local var_210_2 = Object.Instantiate(Asset.Load("Char/" .. "1029ui_story"), arg_207_1.stage_.transform)

					var_210_2.name = var_210_0
					var_210_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_207_1.actors_[var_210_0] = var_210_2

					local var_210_3 = var_210_2:GetComponentInChildren(typeof(CharacterEffect))

					var_210_3.enabled = true

					local var_210_4 = GameObjectTools.GetOrAddComponent(var_210_2, typeof(DynamicBoneHelper))

					if var_210_4 then
						var_210_4:EnableDynamicBone(false)
					end

					arg_207_1:ShowWeapon(var_210_3.transform, false)

					arg_207_1.var_[var_210_0 .. "Animator"] = var_210_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_207_1.var_[var_210_0 .. "Animator"].applyRootMotion = true
					arg_207_1.var_[var_210_0 .. "LipSync"] = var_210_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_210_5 = 0

			if var_210_5 < arg_207_1.time_ and arg_207_1.time_ <= var_210_5 + arg_210_0 then
				arg_207_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_210_6 = arg_207_1.actors_["1029ui_story"]
			local var_210_7 = 0

			if var_210_7 < arg_207_1.time_ and arg_207_1.time_ <= var_210_7 + arg_210_0 and not isNil(var_210_6) and arg_207_1.var_.characterEffect1029ui_story == nil then
				arg_207_1.var_.characterEffect1029ui_story = var_210_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_210_8 = 0.2

			if var_210_7 <= arg_207_1.time_ and arg_207_1.time_ < var_210_7 + var_210_8 and not isNil(var_210_6) then
				local var_210_9 = (arg_207_1.time_ - var_210_7) / var_210_8

				if arg_207_1.var_.characterEffect1029ui_story and not isNil(var_210_6) then
					arg_207_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_207_1.time_ >= var_210_7 + var_210_8 and arg_207_1.time_ < var_210_7 + var_210_8 + arg_210_0 and not isNil(var_210_6) and arg_207_1.var_.characterEffect1029ui_story then
				arg_207_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_210_10 = 0
			local var_210_11 = 0.525

			if var_210_10 < arg_207_1.time_ and arg_207_1.time_ <= var_210_10 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				local var_210_12 = arg_207_1:FormatText(StoryNameCfg[319].name)

				arg_207_1.leftNameTxt_.text = var_210_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_13 = arg_207_1:GetWordFromCfg(116021047)
				local var_210_14 = arg_207_1:FormatText(var_210_13.content)

				arg_207_1.text_.text = var_210_14

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_15 = 21
				local var_210_16 = utf8.len(var_210_14)
				local var_210_17 = var_210_15 <= 0 and var_210_11 or var_210_11 * (var_210_16 / var_210_15)

				if var_210_17 > 0 and var_210_11 < var_210_17 then
					arg_207_1.talkMaxDuration = var_210_17

					if var_210_17 + var_210_10 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_17 + var_210_10
					end
				end

				arg_207_1.text_.text = var_210_14
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116021", "116021047", "story_v_out_116021.awb") ~= 0 then
					local var_210_18 = manager.audio:GetVoiceLength("story_v_out_116021", "116021047", "story_v_out_116021.awb") / 1000

					if var_210_18 + var_210_10 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_18 + var_210_10
					end

					if var_210_13.prefab_name ~= "" and arg_207_1.actors_[var_210_13.prefab_name] ~= nil then
						local var_210_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_207_1.actors_[var_210_13.prefab_name].transform, "story_v_out_116021", "116021047", "story_v_out_116021.awb")

						arg_207_1:RecordAudio("116021047", var_210_19)
						arg_207_1:RecordAudio("116021047", var_210_19)
					else
						arg_207_1:AudioAction("play", "voice", "story_v_out_116021", "116021047", "story_v_out_116021.awb")
					end

					arg_207_1:RecordHistoryTalkVoice("story_v_out_116021", "116021047", "story_v_out_116021.awb")
				end

				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_20 = math.max(var_210_11, arg_207_1.talkMaxDuration)

			if var_210_10 <= arg_207_1.time_ and arg_207_1.time_ < var_210_10 + var_210_20 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_10) / var_210_20

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_10 + var_210_20 and arg_207_1.time_ < var_210_10 + var_210_20 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {}

		arg_207_1:InitPlayNodeList()
	end,
	Play116021048 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 116021048
		arg_211_1.duration_ = 5

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play116021049(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			local var_214_0 = arg_211_1.actors_["1029ui_story"].transform
			local var_214_1 = 0

			if var_214_1 < arg_211_1.time_ and arg_211_1.time_ <= var_214_1 + arg_214_0 then
				arg_211_1.var_.moveOldPos1029ui_story = var_214_0.localPosition
			end

			local var_214_2 = 0.001

			if var_214_1 <= arg_211_1.time_ and arg_211_1.time_ < var_214_1 + var_214_2 then
				local var_214_3 = (arg_211_1.time_ - var_214_1) / var_214_2
				local var_214_4 = Vector3.New(0, 100, 0)

				var_214_0.localPosition = Vector3.Lerp(arg_211_1.var_.moveOldPos1029ui_story, var_214_4, var_214_3)

				local var_214_5 = manager.ui.mainCamera.transform.position - var_214_0.position

				var_214_0.forward = Vector3.New(var_214_5.x, var_214_5.y, var_214_5.z)

				local var_214_6 = var_214_0.localEulerAngles

				var_214_6.z = 0
				var_214_6.x = 0
				var_214_0.localEulerAngles = var_214_6
			end

			if arg_211_1.time_ >= var_214_1 + var_214_2 and arg_211_1.time_ < var_214_1 + var_214_2 + arg_214_0 then
				var_214_0.localPosition = Vector3.New(0, 100, 0)

				local var_214_7 = manager.ui.mainCamera.transform.position - var_214_0.position

				var_214_0.forward = Vector3.New(var_214_7.x, var_214_7.y, var_214_7.z)

				local var_214_8 = var_214_0.localEulerAngles

				var_214_8.z = 0
				var_214_8.x = 0
				var_214_0.localEulerAngles = var_214_8
			end

			local var_214_9 = 0
			local var_214_10 = 0.9

			if var_214_9 < arg_211_1.time_ and arg_211_1.time_ <= var_214_9 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, false)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_11 = arg_211_1:GetWordFromCfg(116021048)
				local var_214_12 = arg_211_1:FormatText(var_214_11.content)

				arg_211_1.text_.text = var_214_12

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_13 = 36
				local var_214_14 = utf8.len(var_214_12)
				local var_214_15 = var_214_13 <= 0 and var_214_10 or var_214_10 * (var_214_14 / var_214_13)

				if var_214_15 > 0 and var_214_10 < var_214_15 then
					arg_211_1.talkMaxDuration = var_214_15

					if var_214_15 + var_214_9 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_15 + var_214_9
					end
				end

				arg_211_1.text_.text = var_214_12
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)
				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_16 = math.max(var_214_10, arg_211_1.talkMaxDuration)

			if var_214_9 <= arg_211_1.time_ and arg_211_1.time_ < var_214_9 + var_214_16 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_9) / var_214_16

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_9 + var_214_16 and arg_211_1.time_ < var_214_9 + var_214_16 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1029ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_211_1:InitPlayNodeList()
	end,
	Play116021049 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 116021049
		arg_215_1.duration_ = 5

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play116021050(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			local var_218_0 = 0
			local var_218_1 = 1.675

			if var_218_0 < arg_215_1.time_ and arg_215_1.time_ <= var_218_0 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, false)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_2 = arg_215_1:GetWordFromCfg(116021049)
				local var_218_3 = arg_215_1:FormatText(var_218_2.content)

				arg_215_1.text_.text = var_218_3

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_4 = 67
				local var_218_5 = utf8.len(var_218_3)
				local var_218_6 = var_218_4 <= 0 and var_218_1 or var_218_1 * (var_218_5 / var_218_4)

				if var_218_6 > 0 and var_218_1 < var_218_6 then
					arg_215_1.talkMaxDuration = var_218_6

					if var_218_6 + var_218_0 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_6 + var_218_0
					end
				end

				arg_215_1.text_.text = var_218_3
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)
				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_7 = math.max(var_218_1, arg_215_1.talkMaxDuration)

			if var_218_0 <= arg_215_1.time_ and arg_215_1.time_ < var_218_0 + var_218_7 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_0) / var_218_7

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_0 + var_218_7 and arg_215_1.time_ < var_218_0 + var_218_7 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {}

		arg_215_1:InitPlayNodeList()
	end,
	Play116021050 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 116021050
		arg_219_1.duration_ = 5.2

		local var_219_0 = {
			zh = 3.633,
			ja = 5.2
		}
		local var_219_1 = manager.audio:GetLocalizationFlag()

		if var_219_0[var_219_1] ~= nil then
			arg_219_1.duration_ = var_219_0[var_219_1]
		end

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"
		end

		function arg_219_1.playNext_(arg_221_0)
			if arg_221_0 == 1 then
				arg_219_0:Play116021051(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			local var_222_0 = arg_219_1.actors_["1019ui_story"].transform
			local var_222_1 = 0

			if var_222_1 < arg_219_1.time_ and arg_219_1.time_ <= var_222_1 + arg_222_0 then
				arg_219_1.var_.moveOldPos1019ui_story = var_222_0.localPosition
			end

			local var_222_2 = 0.001

			if var_222_1 <= arg_219_1.time_ and arg_219_1.time_ < var_222_1 + var_222_2 then
				local var_222_3 = (arg_219_1.time_ - var_222_1) / var_222_2
				local var_222_4 = Vector3.New(-0.7, -1.08, -5.9)

				var_222_0.localPosition = Vector3.Lerp(arg_219_1.var_.moveOldPos1019ui_story, var_222_4, var_222_3)

				local var_222_5 = manager.ui.mainCamera.transform.position - var_222_0.position

				var_222_0.forward = Vector3.New(var_222_5.x, var_222_5.y, var_222_5.z)

				local var_222_6 = var_222_0.localEulerAngles

				var_222_6.z = 0
				var_222_6.x = 0
				var_222_0.localEulerAngles = var_222_6
			end

			if arg_219_1.time_ >= var_222_1 + var_222_2 and arg_219_1.time_ < var_222_1 + var_222_2 + arg_222_0 then
				var_222_0.localPosition = Vector3.New(-0.7, -1.08, -5.9)

				local var_222_7 = manager.ui.mainCamera.transform.position - var_222_0.position

				var_222_0.forward = Vector3.New(var_222_7.x, var_222_7.y, var_222_7.z)

				local var_222_8 = var_222_0.localEulerAngles

				var_222_8.z = 0
				var_222_8.x = 0
				var_222_0.localEulerAngles = var_222_8
			end

			local var_222_9 = 0

			if var_222_9 < arg_219_1.time_ and arg_219_1.time_ <= var_222_9 + arg_222_0 then
				arg_219_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action5_1")
			end

			local var_222_10 = 0

			if var_222_10 < arg_219_1.time_ and arg_219_1.time_ <= var_222_10 + arg_222_0 then
				arg_219_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_222_11 = arg_219_1.actors_["1019ui_story"]
			local var_222_12 = 0

			if var_222_12 < arg_219_1.time_ and arg_219_1.time_ <= var_222_12 + arg_222_0 and not isNil(var_222_11) and arg_219_1.var_.characterEffect1019ui_story == nil then
				arg_219_1.var_.characterEffect1019ui_story = var_222_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_222_13 = 0.2

			if var_222_12 <= arg_219_1.time_ and arg_219_1.time_ < var_222_12 + var_222_13 and not isNil(var_222_11) then
				local var_222_14 = (arg_219_1.time_ - var_222_12) / var_222_13

				if arg_219_1.var_.characterEffect1019ui_story and not isNil(var_222_11) then
					arg_219_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_219_1.time_ >= var_222_12 + var_222_13 and arg_219_1.time_ < var_222_12 + var_222_13 + arg_222_0 and not isNil(var_222_11) and arg_219_1.var_.characterEffect1019ui_story then
				arg_219_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_222_15 = 0
			local var_222_16 = 0.4

			if var_222_15 < arg_219_1.time_ and arg_219_1.time_ <= var_222_15 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, true)

				local var_222_17 = arg_219_1:FormatText(StoryNameCfg[13].name)

				arg_219_1.leftNameTxt_.text = var_222_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_219_1.leftNameTxt_.transform)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1.leftNameTxt_.text)
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_18 = arg_219_1:GetWordFromCfg(116021050)
				local var_222_19 = arg_219_1:FormatText(var_222_18.content)

				arg_219_1.text_.text = var_222_19

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_20 = 16
				local var_222_21 = utf8.len(var_222_19)
				local var_222_22 = var_222_20 <= 0 and var_222_16 or var_222_16 * (var_222_21 / var_222_20)

				if var_222_22 > 0 and var_222_16 < var_222_22 then
					arg_219_1.talkMaxDuration = var_222_22

					if var_222_22 + var_222_15 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_22 + var_222_15
					end
				end

				arg_219_1.text_.text = var_222_19
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116021", "116021050", "story_v_out_116021.awb") ~= 0 then
					local var_222_23 = manager.audio:GetVoiceLength("story_v_out_116021", "116021050", "story_v_out_116021.awb") / 1000

					if var_222_23 + var_222_15 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_23 + var_222_15
					end

					if var_222_18.prefab_name ~= "" and arg_219_1.actors_[var_222_18.prefab_name] ~= nil then
						local var_222_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_219_1.actors_[var_222_18.prefab_name].transform, "story_v_out_116021", "116021050", "story_v_out_116021.awb")

						arg_219_1:RecordAudio("116021050", var_222_24)
						arg_219_1:RecordAudio("116021050", var_222_24)
					else
						arg_219_1:AudioAction("play", "voice", "story_v_out_116021", "116021050", "story_v_out_116021.awb")
					end

					arg_219_1:RecordHistoryTalkVoice("story_v_out_116021", "116021050", "story_v_out_116021.awb")
				end

				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_25 = math.max(var_222_16, arg_219_1.talkMaxDuration)

			if var_222_15 <= arg_219_1.time_ and arg_219_1.time_ < var_222_15 + var_222_25 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_15) / var_222_25

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_15 + var_222_25 and arg_219_1.time_ < var_222_15 + var_222_25 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {
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

		arg_219_1:InitPlayNodeList()
	end,
	Play116021051 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 116021051
		arg_223_1.duration_ = 9.5

		local var_223_0 = {
			zh = 7.3,
			ja = 9.5
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
				arg_223_0:Play116021052(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			local var_226_0 = arg_223_1.actors_["1029ui_story"].transform
			local var_226_1 = 0

			if var_226_1 < arg_223_1.time_ and arg_223_1.time_ <= var_226_1 + arg_226_0 then
				arg_223_1.var_.moveOldPos1029ui_story = var_226_0.localPosition
			end

			local var_226_2 = 0.001

			if var_226_1 <= arg_223_1.time_ and arg_223_1.time_ < var_226_1 + var_226_2 then
				local var_226_3 = (arg_223_1.time_ - var_226_1) / var_226_2
				local var_226_4 = Vector3.New(0.7, -1.09, -6.2)

				var_226_0.localPosition = Vector3.Lerp(arg_223_1.var_.moveOldPos1029ui_story, var_226_4, var_226_3)

				local var_226_5 = manager.ui.mainCamera.transform.position - var_226_0.position

				var_226_0.forward = Vector3.New(var_226_5.x, var_226_5.y, var_226_5.z)

				local var_226_6 = var_226_0.localEulerAngles

				var_226_6.z = 0
				var_226_6.x = 0
				var_226_0.localEulerAngles = var_226_6
			end

			if arg_223_1.time_ >= var_226_1 + var_226_2 and arg_223_1.time_ < var_226_1 + var_226_2 + arg_226_0 then
				var_226_0.localPosition = Vector3.New(0.7, -1.09, -6.2)

				local var_226_7 = manager.ui.mainCamera.transform.position - var_226_0.position

				var_226_0.forward = Vector3.New(var_226_7.x, var_226_7.y, var_226_7.z)

				local var_226_8 = var_226_0.localEulerAngles

				var_226_8.z = 0
				var_226_8.x = 0
				var_226_0.localEulerAngles = var_226_8
			end

			local var_226_9 = 0

			if var_226_9 < arg_223_1.time_ and arg_223_1.time_ <= var_226_9 + arg_226_0 then
				arg_223_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_226_10 = arg_223_1.actors_["1029ui_story"]
			local var_226_11 = 0

			if var_226_11 < arg_223_1.time_ and arg_223_1.time_ <= var_226_11 + arg_226_0 and not isNil(var_226_10) and arg_223_1.var_.characterEffect1029ui_story == nil then
				arg_223_1.var_.characterEffect1029ui_story = var_226_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_226_12 = 0.2

			if var_226_11 <= arg_223_1.time_ and arg_223_1.time_ < var_226_11 + var_226_12 and not isNil(var_226_10) then
				local var_226_13 = (arg_223_1.time_ - var_226_11) / var_226_12

				if arg_223_1.var_.characterEffect1029ui_story and not isNil(var_226_10) then
					arg_223_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_223_1.time_ >= var_226_11 + var_226_12 and arg_223_1.time_ < var_226_11 + var_226_12 + arg_226_0 and not isNil(var_226_10) and arg_223_1.var_.characterEffect1029ui_story then
				arg_223_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_226_14 = arg_223_1.actors_["1019ui_story"]
			local var_226_15 = 0

			if var_226_15 < arg_223_1.time_ and arg_223_1.time_ <= var_226_15 + arg_226_0 and not isNil(var_226_14) and arg_223_1.var_.characterEffect1019ui_story == nil then
				arg_223_1.var_.characterEffect1019ui_story = var_226_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_226_16 = 0.2

			if var_226_15 <= arg_223_1.time_ and arg_223_1.time_ < var_226_15 + var_226_16 and not isNil(var_226_14) then
				local var_226_17 = (arg_223_1.time_ - var_226_15) / var_226_16

				if arg_223_1.var_.characterEffect1019ui_story and not isNil(var_226_14) then
					local var_226_18 = Mathf.Lerp(0, 0.5, var_226_17)

					arg_223_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_223_1.var_.characterEffect1019ui_story.fillRatio = var_226_18
				end
			end

			if arg_223_1.time_ >= var_226_15 + var_226_16 and arg_223_1.time_ < var_226_15 + var_226_16 + arg_226_0 and not isNil(var_226_14) and arg_223_1.var_.characterEffect1019ui_story then
				local var_226_19 = 0.5

				arg_223_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_223_1.var_.characterEffect1019ui_story.fillRatio = var_226_19
			end

			local var_226_20 = 0

			if var_226_20 < arg_223_1.time_ and arg_223_1.time_ <= var_226_20 + arg_226_0 then
				arg_223_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action2_1")
			end

			local var_226_21 = 0

			if var_226_21 < arg_223_1.time_ and arg_223_1.time_ <= var_226_21 + arg_226_0 then
				arg_223_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			local var_226_22 = 0
			local var_226_23 = 0.65

			if var_226_22 < arg_223_1.time_ and arg_223_1.time_ <= var_226_22 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, true)

				local var_226_24 = arg_223_1:FormatText(StoryNameCfg[319].name)

				arg_223_1.leftNameTxt_.text = var_226_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_223_1.leftNameTxt_.transform)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1.leftNameTxt_.text)
				SetActive(arg_223_1.iconTrs_.gameObject, false)
				arg_223_1.callingController_:SetSelectedState("normal")

				local var_226_25 = arg_223_1:GetWordFromCfg(116021051)
				local var_226_26 = arg_223_1:FormatText(var_226_25.content)

				arg_223_1.text_.text = var_226_26

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_27 = 26
				local var_226_28 = utf8.len(var_226_26)
				local var_226_29 = var_226_27 <= 0 and var_226_23 or var_226_23 * (var_226_28 / var_226_27)

				if var_226_29 > 0 and var_226_23 < var_226_29 then
					arg_223_1.talkMaxDuration = var_226_29

					if var_226_29 + var_226_22 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_29 + var_226_22
					end
				end

				arg_223_1.text_.text = var_226_26
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116021", "116021051", "story_v_out_116021.awb") ~= 0 then
					local var_226_30 = manager.audio:GetVoiceLength("story_v_out_116021", "116021051", "story_v_out_116021.awb") / 1000

					if var_226_30 + var_226_22 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_30 + var_226_22
					end

					if var_226_25.prefab_name ~= "" and arg_223_1.actors_[var_226_25.prefab_name] ~= nil then
						local var_226_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_223_1.actors_[var_226_25.prefab_name].transform, "story_v_out_116021", "116021051", "story_v_out_116021.awb")

						arg_223_1:RecordAudio("116021051", var_226_31)
						arg_223_1:RecordAudio("116021051", var_226_31)
					else
						arg_223_1:AudioAction("play", "voice", "story_v_out_116021", "116021051", "story_v_out_116021.awb")
					end

					arg_223_1:RecordHistoryTalkVoice("story_v_out_116021", "116021051", "story_v_out_116021.awb")
				end

				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_32 = math.max(var_226_23, arg_223_1.talkMaxDuration)

			if var_226_22 <= arg_223_1.time_ and arg_223_1.time_ < var_226_22 + var_226_32 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_22) / var_226_32

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_22 + var_226_32 and arg_223_1.time_ < var_226_22 + var_226_32 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1029ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_223_1:InitPlayNodeList()
	end,
	Play116021052 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 116021052
		arg_227_1.duration_ = 9.7

		local var_227_0 = {
			zh = 6.966,
			ja = 9.7
		}
		local var_227_1 = manager.audio:GetLocalizationFlag()

		if var_227_0[var_227_1] ~= nil then
			arg_227_1.duration_ = var_227_0[var_227_1]
		end

		SetActive(arg_227_1.tipsGo_, false)

		function arg_227_1.onSingleLineFinish_()
			arg_227_1.onSingleLineUpdate_ = nil
			arg_227_1.onSingleLineFinish_ = nil
			arg_227_1.state_ = "waiting"
		end

		function arg_227_1.playNext_(arg_229_0)
			if arg_229_0 == 1 then
				arg_227_0:Play116021053(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			local var_230_0 = arg_227_1.actors_["1019ui_story"].transform
			local var_230_1 = 0

			if var_230_1 < arg_227_1.time_ and arg_227_1.time_ <= var_230_1 + arg_230_0 then
				arg_227_1.var_.moveOldPos1019ui_story = var_230_0.localPosition
			end

			local var_230_2 = 0.001

			if var_230_1 <= arg_227_1.time_ and arg_227_1.time_ < var_230_1 + var_230_2 then
				local var_230_3 = (arg_227_1.time_ - var_230_1) / var_230_2
				local var_230_4 = Vector3.New(-0.7, -1.08, -5.9)

				var_230_0.localPosition = Vector3.Lerp(arg_227_1.var_.moveOldPos1019ui_story, var_230_4, var_230_3)

				local var_230_5 = manager.ui.mainCamera.transform.position - var_230_0.position

				var_230_0.forward = Vector3.New(var_230_5.x, var_230_5.y, var_230_5.z)

				local var_230_6 = var_230_0.localEulerAngles

				var_230_6.z = 0
				var_230_6.x = 0
				var_230_0.localEulerAngles = var_230_6
			end

			if arg_227_1.time_ >= var_230_1 + var_230_2 and arg_227_1.time_ < var_230_1 + var_230_2 + arg_230_0 then
				var_230_0.localPosition = Vector3.New(-0.7, -1.08, -5.9)

				local var_230_7 = manager.ui.mainCamera.transform.position - var_230_0.position

				var_230_0.forward = Vector3.New(var_230_7.x, var_230_7.y, var_230_7.z)

				local var_230_8 = var_230_0.localEulerAngles

				var_230_8.z = 0
				var_230_8.x = 0
				var_230_0.localEulerAngles = var_230_8
			end

			local var_230_9 = 0

			if var_230_9 < arg_227_1.time_ and arg_227_1.time_ <= var_230_9 + arg_230_0 then
				arg_227_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_230_10 = arg_227_1.actors_["1019ui_story"]
			local var_230_11 = 0

			if var_230_11 < arg_227_1.time_ and arg_227_1.time_ <= var_230_11 + arg_230_0 and not isNil(var_230_10) and arg_227_1.var_.characterEffect1019ui_story == nil then
				arg_227_1.var_.characterEffect1019ui_story = var_230_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_230_12 = 0.2

			if var_230_11 <= arg_227_1.time_ and arg_227_1.time_ < var_230_11 + var_230_12 and not isNil(var_230_10) then
				local var_230_13 = (arg_227_1.time_ - var_230_11) / var_230_12

				if arg_227_1.var_.characterEffect1019ui_story and not isNil(var_230_10) then
					arg_227_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_227_1.time_ >= var_230_11 + var_230_12 and arg_227_1.time_ < var_230_11 + var_230_12 + arg_230_0 and not isNil(var_230_10) and arg_227_1.var_.characterEffect1019ui_story then
				arg_227_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_230_14 = arg_227_1.actors_["1029ui_story"]
			local var_230_15 = 0

			if var_230_15 < arg_227_1.time_ and arg_227_1.time_ <= var_230_15 + arg_230_0 and not isNil(var_230_14) and arg_227_1.var_.characterEffect1029ui_story == nil then
				arg_227_1.var_.characterEffect1029ui_story = var_230_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_230_16 = 0.2

			if var_230_15 <= arg_227_1.time_ and arg_227_1.time_ < var_230_15 + var_230_16 and not isNil(var_230_14) then
				local var_230_17 = (arg_227_1.time_ - var_230_15) / var_230_16

				if arg_227_1.var_.characterEffect1029ui_story and not isNil(var_230_14) then
					local var_230_18 = Mathf.Lerp(0, 0.5, var_230_17)

					arg_227_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_227_1.var_.characterEffect1029ui_story.fillRatio = var_230_18
				end
			end

			if arg_227_1.time_ >= var_230_15 + var_230_16 and arg_227_1.time_ < var_230_15 + var_230_16 + arg_230_0 and not isNil(var_230_14) and arg_227_1.var_.characterEffect1029ui_story then
				local var_230_19 = 0.5

				arg_227_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_227_1.var_.characterEffect1029ui_story.fillRatio = var_230_19
			end

			local var_230_20 = 0

			if var_230_20 < arg_227_1.time_ and arg_227_1.time_ <= var_230_20 + arg_230_0 then
				arg_227_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action2_2")
			end

			local var_230_21 = 0

			if var_230_21 < arg_227_1.time_ and arg_227_1.time_ <= var_230_21 + arg_230_0 then
				arg_227_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_230_22 = 0
			local var_230_23 = 0.75

			if var_230_22 < arg_227_1.time_ and arg_227_1.time_ <= var_230_22 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, true)

				local var_230_24 = arg_227_1:FormatText(StoryNameCfg[13].name)

				arg_227_1.leftNameTxt_.text = var_230_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, false)
				arg_227_1.callingController_:SetSelectedState("normal")

				local var_230_25 = arg_227_1:GetWordFromCfg(116021052)
				local var_230_26 = arg_227_1:FormatText(var_230_25.content)

				arg_227_1.text_.text = var_230_26

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_27 = 30
				local var_230_28 = utf8.len(var_230_26)
				local var_230_29 = var_230_27 <= 0 and var_230_23 or var_230_23 * (var_230_28 / var_230_27)

				if var_230_29 > 0 and var_230_23 < var_230_29 then
					arg_227_1.talkMaxDuration = var_230_29

					if var_230_29 + var_230_22 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_29 + var_230_22
					end
				end

				arg_227_1.text_.text = var_230_26
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116021", "116021052", "story_v_out_116021.awb") ~= 0 then
					local var_230_30 = manager.audio:GetVoiceLength("story_v_out_116021", "116021052", "story_v_out_116021.awb") / 1000

					if var_230_30 + var_230_22 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_30 + var_230_22
					end

					if var_230_25.prefab_name ~= "" and arg_227_1.actors_[var_230_25.prefab_name] ~= nil then
						local var_230_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_227_1.actors_[var_230_25.prefab_name].transform, "story_v_out_116021", "116021052", "story_v_out_116021.awb")

						arg_227_1:RecordAudio("116021052", var_230_31)
						arg_227_1:RecordAudio("116021052", var_230_31)
					else
						arg_227_1:AudioAction("play", "voice", "story_v_out_116021", "116021052", "story_v_out_116021.awb")
					end

					arg_227_1:RecordHistoryTalkVoice("story_v_out_116021", "116021052", "story_v_out_116021.awb")
				end

				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_32 = math.max(var_230_23, arg_227_1.talkMaxDuration)

			if var_230_22 <= arg_227_1.time_ and arg_227_1.time_ < var_230_22 + var_230_32 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_22) / var_230_32

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_22 + var_230_32 and arg_227_1.time_ < var_230_22 + var_230_32 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {
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

		arg_227_1:InitPlayNodeList()
	end,
	Play116021053 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 116021053
		arg_231_1.duration_ = 4

		local var_231_0 = {
			zh = 3.7,
			ja = 4
		}
		local var_231_1 = manager.audio:GetLocalizationFlag()

		if var_231_0[var_231_1] ~= nil then
			arg_231_1.duration_ = var_231_0[var_231_1]
		end

		SetActive(arg_231_1.tipsGo_, false)

		function arg_231_1.onSingleLineFinish_()
			arg_231_1.onSingleLineUpdate_ = nil
			arg_231_1.onSingleLineFinish_ = nil
			arg_231_1.state_ = "waiting"
		end

		function arg_231_1.playNext_(arg_233_0)
			if arg_233_0 == 1 then
				arg_231_0:Play116021054(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			local var_234_0 = 0

			if var_234_0 < arg_231_1.time_ and arg_231_1.time_ <= var_234_0 + arg_234_0 then
				arg_231_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_234_1 = arg_231_1.actors_["1029ui_story"]
			local var_234_2 = 0

			if var_234_2 < arg_231_1.time_ and arg_231_1.time_ <= var_234_2 + arg_234_0 and not isNil(var_234_1) and arg_231_1.var_.characterEffect1029ui_story == nil then
				arg_231_1.var_.characterEffect1029ui_story = var_234_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_234_3 = 0.2

			if var_234_2 <= arg_231_1.time_ and arg_231_1.time_ < var_234_2 + var_234_3 and not isNil(var_234_1) then
				local var_234_4 = (arg_231_1.time_ - var_234_2) / var_234_3

				if arg_231_1.var_.characterEffect1029ui_story and not isNil(var_234_1) then
					arg_231_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_231_1.time_ >= var_234_2 + var_234_3 and arg_231_1.time_ < var_234_2 + var_234_3 + arg_234_0 and not isNil(var_234_1) and arg_231_1.var_.characterEffect1029ui_story then
				arg_231_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_234_5 = arg_231_1.actors_["1019ui_story"]
			local var_234_6 = 0

			if var_234_6 < arg_231_1.time_ and arg_231_1.time_ <= var_234_6 + arg_234_0 and not isNil(var_234_5) and arg_231_1.var_.characterEffect1019ui_story == nil then
				arg_231_1.var_.characterEffect1019ui_story = var_234_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_234_7 = 0.2

			if var_234_6 <= arg_231_1.time_ and arg_231_1.time_ < var_234_6 + var_234_7 and not isNil(var_234_5) then
				local var_234_8 = (arg_231_1.time_ - var_234_6) / var_234_7

				if arg_231_1.var_.characterEffect1019ui_story and not isNil(var_234_5) then
					local var_234_9 = Mathf.Lerp(0, 0.5, var_234_8)

					arg_231_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_231_1.var_.characterEffect1019ui_story.fillRatio = var_234_9
				end
			end

			if arg_231_1.time_ >= var_234_6 + var_234_7 and arg_231_1.time_ < var_234_6 + var_234_7 + arg_234_0 and not isNil(var_234_5) and arg_231_1.var_.characterEffect1019ui_story then
				local var_234_10 = 0.5

				arg_231_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_231_1.var_.characterEffect1019ui_story.fillRatio = var_234_10
			end

			local var_234_11 = 0
			local var_234_12 = 0.45

			if var_234_11 < arg_231_1.time_ and arg_231_1.time_ <= var_234_11 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, true)

				local var_234_13 = arg_231_1:FormatText(StoryNameCfg[319].name)

				arg_231_1.leftNameTxt_.text = var_234_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, false)
				arg_231_1.callingController_:SetSelectedState("normal")

				local var_234_14 = arg_231_1:GetWordFromCfg(116021053)
				local var_234_15 = arg_231_1:FormatText(var_234_14.content)

				arg_231_1.text_.text = var_234_15

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_16 = 18
				local var_234_17 = utf8.len(var_234_15)
				local var_234_18 = var_234_16 <= 0 and var_234_12 or var_234_12 * (var_234_17 / var_234_16)

				if var_234_18 > 0 and var_234_12 < var_234_18 then
					arg_231_1.talkMaxDuration = var_234_18

					if var_234_18 + var_234_11 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_18 + var_234_11
					end
				end

				arg_231_1.text_.text = var_234_15
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116021", "116021053", "story_v_out_116021.awb") ~= 0 then
					local var_234_19 = manager.audio:GetVoiceLength("story_v_out_116021", "116021053", "story_v_out_116021.awb") / 1000

					if var_234_19 + var_234_11 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_19 + var_234_11
					end

					if var_234_14.prefab_name ~= "" and arg_231_1.actors_[var_234_14.prefab_name] ~= nil then
						local var_234_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_231_1.actors_[var_234_14.prefab_name].transform, "story_v_out_116021", "116021053", "story_v_out_116021.awb")

						arg_231_1:RecordAudio("116021053", var_234_20)
						arg_231_1:RecordAudio("116021053", var_234_20)
					else
						arg_231_1:AudioAction("play", "voice", "story_v_out_116021", "116021053", "story_v_out_116021.awb")
					end

					arg_231_1:RecordHistoryTalkVoice("story_v_out_116021", "116021053", "story_v_out_116021.awb")
				end

				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_21 = math.max(var_234_12, arg_231_1.talkMaxDuration)

			if var_234_11 <= arg_231_1.time_ and arg_231_1.time_ < var_234_11 + var_234_21 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_11) / var_234_21

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_11 + var_234_21 and arg_231_1.time_ < var_234_11 + var_234_21 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {}

		arg_231_1:InitPlayNodeList()
	end,
	Play116021054 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 116021054
		arg_235_1.duration_ = 14.53

		local var_235_0 = {
			zh = 9.1,
			ja = 14.533
		}
		local var_235_1 = manager.audio:GetLocalizationFlag()

		if var_235_0[var_235_1] ~= nil then
			arg_235_1.duration_ = var_235_0[var_235_1]
		end

		SetActive(arg_235_1.tipsGo_, false)

		function arg_235_1.onSingleLineFinish_()
			arg_235_1.onSingleLineUpdate_ = nil
			arg_235_1.onSingleLineFinish_ = nil
			arg_235_1.state_ = "waiting"
		end

		function arg_235_1.playNext_(arg_237_0)
			if arg_237_0 == 1 then
				arg_235_0:Play116021055(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			local var_238_0 = 0

			if var_238_0 < arg_235_1.time_ and arg_235_1.time_ <= var_238_0 + arg_238_0 then
				arg_235_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_238_1 = arg_235_1.actors_["1019ui_story"]
			local var_238_2 = 0

			if var_238_2 < arg_235_1.time_ and arg_235_1.time_ <= var_238_2 + arg_238_0 and not isNil(var_238_1) and arg_235_1.var_.characterEffect1019ui_story == nil then
				arg_235_1.var_.characterEffect1019ui_story = var_238_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_238_3 = 0.2

			if var_238_2 <= arg_235_1.time_ and arg_235_1.time_ < var_238_2 + var_238_3 and not isNil(var_238_1) then
				local var_238_4 = (arg_235_1.time_ - var_238_2) / var_238_3

				if arg_235_1.var_.characterEffect1019ui_story and not isNil(var_238_1) then
					arg_235_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_235_1.time_ >= var_238_2 + var_238_3 and arg_235_1.time_ < var_238_2 + var_238_3 + arg_238_0 and not isNil(var_238_1) and arg_235_1.var_.characterEffect1019ui_story then
				arg_235_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_238_5 = arg_235_1.actors_["1029ui_story"]
			local var_238_6 = 0

			if var_238_6 < arg_235_1.time_ and arg_235_1.time_ <= var_238_6 + arg_238_0 and not isNil(var_238_5) and arg_235_1.var_.characterEffect1029ui_story == nil then
				arg_235_1.var_.characterEffect1029ui_story = var_238_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_238_7 = 0.2

			if var_238_6 <= arg_235_1.time_ and arg_235_1.time_ < var_238_6 + var_238_7 and not isNil(var_238_5) then
				local var_238_8 = (arg_235_1.time_ - var_238_6) / var_238_7

				if arg_235_1.var_.characterEffect1029ui_story and not isNil(var_238_5) then
					local var_238_9 = Mathf.Lerp(0, 0.5, var_238_8)

					arg_235_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_235_1.var_.characterEffect1029ui_story.fillRatio = var_238_9
				end
			end

			if arg_235_1.time_ >= var_238_6 + var_238_7 and arg_235_1.time_ < var_238_6 + var_238_7 + arg_238_0 and not isNil(var_238_5) and arg_235_1.var_.characterEffect1029ui_story then
				local var_238_10 = 0.5

				arg_235_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_235_1.var_.characterEffect1029ui_story.fillRatio = var_238_10
			end

			local var_238_11 = 0
			local var_238_12 = 1.025

			if var_238_11 < arg_235_1.time_ and arg_235_1.time_ <= var_238_11 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, true)

				local var_238_13 = arg_235_1:FormatText(StoryNameCfg[13].name)

				arg_235_1.leftNameTxt_.text = var_238_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, false)
				arg_235_1.callingController_:SetSelectedState("normal")

				local var_238_14 = arg_235_1:GetWordFromCfg(116021054)
				local var_238_15 = arg_235_1:FormatText(var_238_14.content)

				arg_235_1.text_.text = var_238_15

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_16 = 41
				local var_238_17 = utf8.len(var_238_15)
				local var_238_18 = var_238_16 <= 0 and var_238_12 or var_238_12 * (var_238_17 / var_238_16)

				if var_238_18 > 0 and var_238_12 < var_238_18 then
					arg_235_1.talkMaxDuration = var_238_18

					if var_238_18 + var_238_11 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_18 + var_238_11
					end
				end

				arg_235_1.text_.text = var_238_15
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116021", "116021054", "story_v_out_116021.awb") ~= 0 then
					local var_238_19 = manager.audio:GetVoiceLength("story_v_out_116021", "116021054", "story_v_out_116021.awb") / 1000

					if var_238_19 + var_238_11 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_19 + var_238_11
					end

					if var_238_14.prefab_name ~= "" and arg_235_1.actors_[var_238_14.prefab_name] ~= nil then
						local var_238_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_235_1.actors_[var_238_14.prefab_name].transform, "story_v_out_116021", "116021054", "story_v_out_116021.awb")

						arg_235_1:RecordAudio("116021054", var_238_20)
						arg_235_1:RecordAudio("116021054", var_238_20)
					else
						arg_235_1:AudioAction("play", "voice", "story_v_out_116021", "116021054", "story_v_out_116021.awb")
					end

					arg_235_1:RecordHistoryTalkVoice("story_v_out_116021", "116021054", "story_v_out_116021.awb")
				end

				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_21 = math.max(var_238_12, arg_235_1.talkMaxDuration)

			if var_238_11 <= arg_235_1.time_ and arg_235_1.time_ < var_238_11 + var_238_21 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_11) / var_238_21

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_11 + var_238_21 and arg_235_1.time_ < var_238_11 + var_238_21 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {}

		arg_235_1:InitPlayNodeList()
	end,
	Play116021055 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 116021055
		arg_239_1.duration_ = 8.8

		local var_239_0 = {
			zh = 7.066,
			ja = 8.8
		}
		local var_239_1 = manager.audio:GetLocalizationFlag()

		if var_239_0[var_239_1] ~= nil then
			arg_239_1.duration_ = var_239_0[var_239_1]
		end

		SetActive(arg_239_1.tipsGo_, false)

		function arg_239_1.onSingleLineFinish_()
			arg_239_1.onSingleLineUpdate_ = nil
			arg_239_1.onSingleLineFinish_ = nil
			arg_239_1.state_ = "waiting"
		end

		function arg_239_1.playNext_(arg_241_0)
			if arg_241_0 == 1 then
				arg_239_0:Play116021056(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			local var_242_0 = 0

			if var_242_0 < arg_239_1.time_ and arg_239_1.time_ <= var_242_0 + arg_242_0 then
				arg_239_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_242_1 = 0
			local var_242_2 = 0.975

			if var_242_1 < arg_239_1.time_ and arg_239_1.time_ <= var_242_1 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, true)

				local var_242_3 = arg_239_1:FormatText(StoryNameCfg[13].name)

				arg_239_1.leftNameTxt_.text = var_242_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_239_1.leftNameTxt_.transform)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1.leftNameTxt_.text)
				SetActive(arg_239_1.iconTrs_.gameObject, false)
				arg_239_1.callingController_:SetSelectedState("normal")

				local var_242_4 = arg_239_1:GetWordFromCfg(116021055)
				local var_242_5 = arg_239_1:FormatText(var_242_4.content)

				arg_239_1.text_.text = var_242_5

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_6 = 39
				local var_242_7 = utf8.len(var_242_5)
				local var_242_8 = var_242_6 <= 0 and var_242_2 or var_242_2 * (var_242_7 / var_242_6)

				if var_242_8 > 0 and var_242_2 < var_242_8 then
					arg_239_1.talkMaxDuration = var_242_8

					if var_242_8 + var_242_1 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_8 + var_242_1
					end
				end

				arg_239_1.text_.text = var_242_5
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116021", "116021055", "story_v_out_116021.awb") ~= 0 then
					local var_242_9 = manager.audio:GetVoiceLength("story_v_out_116021", "116021055", "story_v_out_116021.awb") / 1000

					if var_242_9 + var_242_1 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_9 + var_242_1
					end

					if var_242_4.prefab_name ~= "" and arg_239_1.actors_[var_242_4.prefab_name] ~= nil then
						local var_242_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_239_1.actors_[var_242_4.prefab_name].transform, "story_v_out_116021", "116021055", "story_v_out_116021.awb")

						arg_239_1:RecordAudio("116021055", var_242_10)
						arg_239_1:RecordAudio("116021055", var_242_10)
					else
						arg_239_1:AudioAction("play", "voice", "story_v_out_116021", "116021055", "story_v_out_116021.awb")
					end

					arg_239_1:RecordHistoryTalkVoice("story_v_out_116021", "116021055", "story_v_out_116021.awb")
				end

				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_11 = math.max(var_242_2, arg_239_1.talkMaxDuration)

			if var_242_1 <= arg_239_1.time_ and arg_239_1.time_ < var_242_1 + var_242_11 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_1) / var_242_11

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_1 + var_242_11 and arg_239_1.time_ < var_242_1 + var_242_11 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {}

		arg_239_1:InitPlayNodeList()
	end,
	Play116021056 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 116021056
		arg_243_1.duration_ = 5.17

		local var_243_0 = {
			zh = 1.999999999999,
			ja = 5.166
		}
		local var_243_1 = manager.audio:GetLocalizationFlag()

		if var_243_0[var_243_1] ~= nil then
			arg_243_1.duration_ = var_243_0[var_243_1]
		end

		SetActive(arg_243_1.tipsGo_, false)

		function arg_243_1.onSingleLineFinish_()
			arg_243_1.onSingleLineUpdate_ = nil
			arg_243_1.onSingleLineFinish_ = nil
			arg_243_1.state_ = "waiting"
		end

		function arg_243_1.playNext_(arg_245_0)
			if arg_245_0 == 1 then
				arg_243_0:Play116021057(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			local var_246_0 = 0

			if var_246_0 < arg_243_1.time_ and arg_243_1.time_ <= var_246_0 + arg_246_0 then
				arg_243_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_246_1 = arg_243_1.actors_["1019ui_story"]
			local var_246_2 = 0

			if var_246_2 < arg_243_1.time_ and arg_243_1.time_ <= var_246_2 + arg_246_0 and not isNil(var_246_1) and arg_243_1.var_.characterEffect1019ui_story == nil then
				arg_243_1.var_.characterEffect1019ui_story = var_246_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_246_3 = 0.2

			if var_246_2 <= arg_243_1.time_ and arg_243_1.time_ < var_246_2 + var_246_3 and not isNil(var_246_1) then
				local var_246_4 = (arg_243_1.time_ - var_246_2) / var_246_3

				if arg_243_1.var_.characterEffect1019ui_story and not isNil(var_246_1) then
					local var_246_5 = Mathf.Lerp(0, 0.5, var_246_4)

					arg_243_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_243_1.var_.characterEffect1019ui_story.fillRatio = var_246_5
				end
			end

			if arg_243_1.time_ >= var_246_2 + var_246_3 and arg_243_1.time_ < var_246_2 + var_246_3 + arg_246_0 and not isNil(var_246_1) and arg_243_1.var_.characterEffect1019ui_story then
				local var_246_6 = 0.5

				arg_243_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_243_1.var_.characterEffect1019ui_story.fillRatio = var_246_6
			end

			local var_246_7 = arg_243_1.actors_["1029ui_story"]
			local var_246_8 = 0

			if var_246_8 < arg_243_1.time_ and arg_243_1.time_ <= var_246_8 + arg_246_0 and not isNil(var_246_7) and arg_243_1.var_.characterEffect1029ui_story == nil then
				arg_243_1.var_.characterEffect1029ui_story = var_246_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_246_9 = 0.2

			if var_246_8 <= arg_243_1.time_ and arg_243_1.time_ < var_246_8 + var_246_9 and not isNil(var_246_7) then
				local var_246_10 = (arg_243_1.time_ - var_246_8) / var_246_9

				if arg_243_1.var_.characterEffect1029ui_story and not isNil(var_246_7) then
					arg_243_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_243_1.time_ >= var_246_8 + var_246_9 and arg_243_1.time_ < var_246_8 + var_246_9 + arg_246_0 and not isNil(var_246_7) and arg_243_1.var_.characterEffect1029ui_story then
				arg_243_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_246_11 = 0
			local var_246_12 = 0.075

			if var_246_11 < arg_243_1.time_ and arg_243_1.time_ <= var_246_11 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, true)

				local var_246_13 = arg_243_1:FormatText(StoryNameCfg[319].name)

				arg_243_1.leftNameTxt_.text = var_246_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, false)
				arg_243_1.callingController_:SetSelectedState("normal")

				local var_246_14 = arg_243_1:GetWordFromCfg(116021056)
				local var_246_15 = arg_243_1:FormatText(var_246_14.content)

				arg_243_1.text_.text = var_246_15

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_16 = 3
				local var_246_17 = utf8.len(var_246_15)
				local var_246_18 = var_246_16 <= 0 and var_246_12 or var_246_12 * (var_246_17 / var_246_16)

				if var_246_18 > 0 and var_246_12 < var_246_18 then
					arg_243_1.talkMaxDuration = var_246_18

					if var_246_18 + var_246_11 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_18 + var_246_11
					end
				end

				arg_243_1.text_.text = var_246_15
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116021", "116021056", "story_v_out_116021.awb") ~= 0 then
					local var_246_19 = manager.audio:GetVoiceLength("story_v_out_116021", "116021056", "story_v_out_116021.awb") / 1000

					if var_246_19 + var_246_11 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_19 + var_246_11
					end

					if var_246_14.prefab_name ~= "" and arg_243_1.actors_[var_246_14.prefab_name] ~= nil then
						local var_246_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_243_1.actors_[var_246_14.prefab_name].transform, "story_v_out_116021", "116021056", "story_v_out_116021.awb")

						arg_243_1:RecordAudio("116021056", var_246_20)
						arg_243_1:RecordAudio("116021056", var_246_20)
					else
						arg_243_1:AudioAction("play", "voice", "story_v_out_116021", "116021056", "story_v_out_116021.awb")
					end

					arg_243_1:RecordHistoryTalkVoice("story_v_out_116021", "116021056", "story_v_out_116021.awb")
				end

				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_21 = math.max(var_246_12, arg_243_1.talkMaxDuration)

			if var_246_11 <= arg_243_1.time_ and arg_243_1.time_ < var_246_11 + var_246_21 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_11) / var_246_21

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_11 + var_246_21 and arg_243_1.time_ < var_246_11 + var_246_21 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {}

		arg_243_1:InitPlayNodeList()
	end,
	Play116021057 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 116021057
		arg_247_1.duration_ = 6.9

		local var_247_0 = {
			zh = 3.466,
			ja = 6.9
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
				arg_247_0:Play116021058(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			local var_250_0 = 0

			if var_250_0 < arg_247_1.time_ and arg_247_1.time_ <= var_250_0 + arg_250_0 then
				arg_247_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_250_1 = arg_247_1.actors_["1019ui_story"]
			local var_250_2 = 0

			if var_250_2 < arg_247_1.time_ and arg_247_1.time_ <= var_250_2 + arg_250_0 and not isNil(var_250_1) and arg_247_1.var_.characterEffect1019ui_story == nil then
				arg_247_1.var_.characterEffect1019ui_story = var_250_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_250_3 = 0.2

			if var_250_2 <= arg_247_1.time_ and arg_247_1.time_ < var_250_2 + var_250_3 and not isNil(var_250_1) then
				local var_250_4 = (arg_247_1.time_ - var_250_2) / var_250_3

				if arg_247_1.var_.characterEffect1019ui_story and not isNil(var_250_1) then
					arg_247_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_247_1.time_ >= var_250_2 + var_250_3 and arg_247_1.time_ < var_250_2 + var_250_3 + arg_250_0 and not isNil(var_250_1) and arg_247_1.var_.characterEffect1019ui_story then
				arg_247_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_250_5 = arg_247_1.actors_["1029ui_story"]
			local var_250_6 = 0

			if var_250_6 < arg_247_1.time_ and arg_247_1.time_ <= var_250_6 + arg_250_0 and not isNil(var_250_5) and arg_247_1.var_.characterEffect1029ui_story == nil then
				arg_247_1.var_.characterEffect1029ui_story = var_250_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_250_7 = 0.2

			if var_250_6 <= arg_247_1.time_ and arg_247_1.time_ < var_250_6 + var_250_7 and not isNil(var_250_5) then
				local var_250_8 = (arg_247_1.time_ - var_250_6) / var_250_7

				if arg_247_1.var_.characterEffect1029ui_story and not isNil(var_250_5) then
					local var_250_9 = Mathf.Lerp(0, 0.5, var_250_8)

					arg_247_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_247_1.var_.characterEffect1029ui_story.fillRatio = var_250_9
				end
			end

			if arg_247_1.time_ >= var_250_6 + var_250_7 and arg_247_1.time_ < var_250_6 + var_250_7 + arg_250_0 and not isNil(var_250_5) and arg_247_1.var_.characterEffect1029ui_story then
				local var_250_10 = 0.5

				arg_247_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_247_1.var_.characterEffect1029ui_story.fillRatio = var_250_10
			end

			local var_250_11 = 0
			local var_250_12 = 0.45

			if var_250_11 < arg_247_1.time_ and arg_247_1.time_ <= var_250_11 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				local var_250_13 = arg_247_1:FormatText(StoryNameCfg[13].name)

				arg_247_1.leftNameTxt_.text = var_250_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, false)
				arg_247_1.callingController_:SetSelectedState("normal")

				local var_250_14 = arg_247_1:GetWordFromCfg(116021057)
				local var_250_15 = arg_247_1:FormatText(var_250_14.content)

				arg_247_1.text_.text = var_250_15

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_16 = 18
				local var_250_17 = utf8.len(var_250_15)
				local var_250_18 = var_250_16 <= 0 and var_250_12 or var_250_12 * (var_250_17 / var_250_16)

				if var_250_18 > 0 and var_250_12 < var_250_18 then
					arg_247_1.talkMaxDuration = var_250_18

					if var_250_18 + var_250_11 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_18 + var_250_11
					end
				end

				arg_247_1.text_.text = var_250_15
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116021", "116021057", "story_v_out_116021.awb") ~= 0 then
					local var_250_19 = manager.audio:GetVoiceLength("story_v_out_116021", "116021057", "story_v_out_116021.awb") / 1000

					if var_250_19 + var_250_11 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_19 + var_250_11
					end

					if var_250_14.prefab_name ~= "" and arg_247_1.actors_[var_250_14.prefab_name] ~= nil then
						local var_250_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_247_1.actors_[var_250_14.prefab_name].transform, "story_v_out_116021", "116021057", "story_v_out_116021.awb")

						arg_247_1:RecordAudio("116021057", var_250_20)
						arg_247_1:RecordAudio("116021057", var_250_20)
					else
						arg_247_1:AudioAction("play", "voice", "story_v_out_116021", "116021057", "story_v_out_116021.awb")
					end

					arg_247_1:RecordHistoryTalkVoice("story_v_out_116021", "116021057", "story_v_out_116021.awb")
				end

				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_21 = math.max(var_250_12, arg_247_1.talkMaxDuration)

			if var_250_11 <= arg_247_1.time_ and arg_247_1.time_ < var_250_11 + var_250_21 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_11) / var_250_21

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_11 + var_250_21 and arg_247_1.time_ < var_250_11 + var_250_21 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {}

		arg_247_1:InitPlayNodeList()
	end,
	Play116021058 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 116021058
		arg_251_1.duration_ = 5.5

		local var_251_0 = {
			zh = 4.933,
			ja = 5.5
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
				arg_251_0:Play116021059(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			local var_254_0 = 0

			if var_254_0 < arg_251_1.time_ and arg_251_1.time_ <= var_254_0 + arg_254_0 then
				arg_251_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action6_1")
			end

			local var_254_1 = 0

			if var_254_1 < arg_251_1.time_ and arg_251_1.time_ <= var_254_1 + arg_254_0 then
				arg_251_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_254_2 = arg_251_1.actors_["1019ui_story"]
			local var_254_3 = 0

			if var_254_3 < arg_251_1.time_ and arg_251_1.time_ <= var_254_3 + arg_254_0 and not isNil(var_254_2) and arg_251_1.var_.characterEffect1019ui_story == nil then
				arg_251_1.var_.characterEffect1019ui_story = var_254_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_254_4 = 0.2

			if var_254_3 <= arg_251_1.time_ and arg_251_1.time_ < var_254_3 + var_254_4 and not isNil(var_254_2) then
				local var_254_5 = (arg_251_1.time_ - var_254_3) / var_254_4

				if arg_251_1.var_.characterEffect1019ui_story and not isNil(var_254_2) then
					local var_254_6 = Mathf.Lerp(0, 0.5, var_254_5)

					arg_251_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_251_1.var_.characterEffect1019ui_story.fillRatio = var_254_6
				end
			end

			if arg_251_1.time_ >= var_254_3 + var_254_4 and arg_251_1.time_ < var_254_3 + var_254_4 + arg_254_0 and not isNil(var_254_2) and arg_251_1.var_.characterEffect1019ui_story then
				local var_254_7 = 0.5

				arg_251_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_251_1.var_.characterEffect1019ui_story.fillRatio = var_254_7
			end

			local var_254_8 = arg_251_1.actors_["1029ui_story"]
			local var_254_9 = 0

			if var_254_9 < arg_251_1.time_ and arg_251_1.time_ <= var_254_9 + arg_254_0 and not isNil(var_254_8) and arg_251_1.var_.characterEffect1029ui_story == nil then
				arg_251_1.var_.characterEffect1029ui_story = var_254_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_254_10 = 0.2

			if var_254_9 <= arg_251_1.time_ and arg_251_1.time_ < var_254_9 + var_254_10 and not isNil(var_254_8) then
				local var_254_11 = (arg_251_1.time_ - var_254_9) / var_254_10

				if arg_251_1.var_.characterEffect1029ui_story and not isNil(var_254_8) then
					arg_251_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_251_1.time_ >= var_254_9 + var_254_10 and arg_251_1.time_ < var_254_9 + var_254_10 + arg_254_0 and not isNil(var_254_8) and arg_251_1.var_.characterEffect1029ui_story then
				arg_251_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_254_12 = 0
			local var_254_13 = 0.4

			if var_254_12 < arg_251_1.time_ and arg_251_1.time_ <= var_254_12 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, true)

				local var_254_14 = arg_251_1:FormatText(StoryNameCfg[319].name)

				arg_251_1.leftNameTxt_.text = var_254_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_251_1.leftNameTxt_.transform)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1.leftNameTxt_.text)
				SetActive(arg_251_1.iconTrs_.gameObject, false)
				arg_251_1.callingController_:SetSelectedState("normal")

				local var_254_15 = arg_251_1:GetWordFromCfg(116021058)
				local var_254_16 = arg_251_1:FormatText(var_254_15.content)

				arg_251_1.text_.text = var_254_16

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_17 = 16
				local var_254_18 = utf8.len(var_254_16)
				local var_254_19 = var_254_17 <= 0 and var_254_13 or var_254_13 * (var_254_18 / var_254_17)

				if var_254_19 > 0 and var_254_13 < var_254_19 then
					arg_251_1.talkMaxDuration = var_254_19

					if var_254_19 + var_254_12 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_19 + var_254_12
					end
				end

				arg_251_1.text_.text = var_254_16
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116021", "116021058", "story_v_out_116021.awb") ~= 0 then
					local var_254_20 = manager.audio:GetVoiceLength("story_v_out_116021", "116021058", "story_v_out_116021.awb") / 1000

					if var_254_20 + var_254_12 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_20 + var_254_12
					end

					if var_254_15.prefab_name ~= "" and arg_251_1.actors_[var_254_15.prefab_name] ~= nil then
						local var_254_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_251_1.actors_[var_254_15.prefab_name].transform, "story_v_out_116021", "116021058", "story_v_out_116021.awb")

						arg_251_1:RecordAudio("116021058", var_254_21)
						arg_251_1:RecordAudio("116021058", var_254_21)
					else
						arg_251_1:AudioAction("play", "voice", "story_v_out_116021", "116021058", "story_v_out_116021.awb")
					end

					arg_251_1:RecordHistoryTalkVoice("story_v_out_116021", "116021058", "story_v_out_116021.awb")
				end

				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_22 = math.max(var_254_13, arg_251_1.talkMaxDuration)

			if var_254_12 <= arg_251_1.time_ and arg_251_1.time_ < var_254_12 + var_254_22 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - var_254_12) / var_254_22

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= var_254_12 + var_254_22 and arg_251_1.time_ < var_254_12 + var_254_22 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {}

		arg_251_1:InitPlayNodeList()
	end,
	Play116021059 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 116021059
		arg_255_1.duration_ = 6.37

		local var_255_0 = {
			zh = 4.566,
			ja = 6.366
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
				arg_255_0:Play116021060(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			local var_258_0 = 0

			if var_258_0 < arg_255_1.time_ and arg_255_1.time_ <= var_258_0 + arg_258_0 then
				arg_255_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			local var_258_1 = arg_255_1.actors_["1019ui_story"]
			local var_258_2 = 0

			if var_258_2 < arg_255_1.time_ and arg_255_1.time_ <= var_258_2 + arg_258_0 and not isNil(var_258_1) and arg_255_1.var_.characterEffect1019ui_story == nil then
				arg_255_1.var_.characterEffect1019ui_story = var_258_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_258_3 = 0.2

			if var_258_2 <= arg_255_1.time_ and arg_255_1.time_ < var_258_2 + var_258_3 and not isNil(var_258_1) then
				local var_258_4 = (arg_255_1.time_ - var_258_2) / var_258_3

				if arg_255_1.var_.characterEffect1019ui_story and not isNil(var_258_1) then
					arg_255_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_255_1.time_ >= var_258_2 + var_258_3 and arg_255_1.time_ < var_258_2 + var_258_3 + arg_258_0 and not isNil(var_258_1) and arg_255_1.var_.characterEffect1019ui_story then
				arg_255_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_258_5 = arg_255_1.actors_["1029ui_story"]
			local var_258_6 = 0

			if var_258_6 < arg_255_1.time_ and arg_255_1.time_ <= var_258_6 + arg_258_0 and not isNil(var_258_5) and arg_255_1.var_.characterEffect1029ui_story == nil then
				arg_255_1.var_.characterEffect1029ui_story = var_258_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_258_7 = 0.2

			if var_258_6 <= arg_255_1.time_ and arg_255_1.time_ < var_258_6 + var_258_7 and not isNil(var_258_5) then
				local var_258_8 = (arg_255_1.time_ - var_258_6) / var_258_7

				if arg_255_1.var_.characterEffect1029ui_story and not isNil(var_258_5) then
					local var_258_9 = Mathf.Lerp(0, 0.5, var_258_8)

					arg_255_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_255_1.var_.characterEffect1029ui_story.fillRatio = var_258_9
				end
			end

			if arg_255_1.time_ >= var_258_6 + var_258_7 and arg_255_1.time_ < var_258_6 + var_258_7 + arg_258_0 and not isNil(var_258_5) and arg_255_1.var_.characterEffect1029ui_story then
				local var_258_10 = 0.5

				arg_255_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_255_1.var_.characterEffect1029ui_story.fillRatio = var_258_10
			end

			local var_258_11 = 0
			local var_258_12 = 0.475

			if var_258_11 < arg_255_1.time_ and arg_255_1.time_ <= var_258_11 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, true)

				local var_258_13 = arg_255_1:FormatText(StoryNameCfg[13].name)

				arg_255_1.leftNameTxt_.text = var_258_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_255_1.leftNameTxt_.transform)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1.leftNameTxt_.text)
				SetActive(arg_255_1.iconTrs_.gameObject, false)
				arg_255_1.callingController_:SetSelectedState("normal")

				local var_258_14 = arg_255_1:GetWordFromCfg(116021059)
				local var_258_15 = arg_255_1:FormatText(var_258_14.content)

				arg_255_1.text_.text = var_258_15

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_16 = 19
				local var_258_17 = utf8.len(var_258_15)
				local var_258_18 = var_258_16 <= 0 and var_258_12 or var_258_12 * (var_258_17 / var_258_16)

				if var_258_18 > 0 and var_258_12 < var_258_18 then
					arg_255_1.talkMaxDuration = var_258_18

					if var_258_18 + var_258_11 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_18 + var_258_11
					end
				end

				arg_255_1.text_.text = var_258_15
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116021", "116021059", "story_v_out_116021.awb") ~= 0 then
					local var_258_19 = manager.audio:GetVoiceLength("story_v_out_116021", "116021059", "story_v_out_116021.awb") / 1000

					if var_258_19 + var_258_11 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_19 + var_258_11
					end

					if var_258_14.prefab_name ~= "" and arg_255_1.actors_[var_258_14.prefab_name] ~= nil then
						local var_258_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_255_1.actors_[var_258_14.prefab_name].transform, "story_v_out_116021", "116021059", "story_v_out_116021.awb")

						arg_255_1:RecordAudio("116021059", var_258_20)
						arg_255_1:RecordAudio("116021059", var_258_20)
					else
						arg_255_1:AudioAction("play", "voice", "story_v_out_116021", "116021059", "story_v_out_116021.awb")
					end

					arg_255_1:RecordHistoryTalkVoice("story_v_out_116021", "116021059", "story_v_out_116021.awb")
				end

				arg_255_1:RecordContent(arg_255_1.text_.text)
			end

			local var_258_21 = math.max(var_258_12, arg_255_1.talkMaxDuration)

			if var_258_11 <= arg_255_1.time_ and arg_255_1.time_ < var_258_11 + var_258_21 then
				arg_255_1.typewritter.percent = (arg_255_1.time_ - var_258_11) / var_258_21

				arg_255_1.typewritter:SetDirty()
			end

			if arg_255_1.time_ >= var_258_11 + var_258_21 and arg_255_1.time_ < var_258_11 + var_258_21 + arg_258_0 then
				arg_255_1.typewritter.percent = 1

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(true)
			end
		end

		arg_255_1.nodeConfigList_ = {}

		arg_255_1:InitPlayNodeList()
	end,
	Play116021060 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 116021060
		arg_259_1.duration_ = 17.3

		local var_259_0 = {
			zh = 17.3,
			ja = 12.433
		}
		local var_259_1 = manager.audio:GetLocalizationFlag()

		if var_259_0[var_259_1] ~= nil then
			arg_259_1.duration_ = var_259_0[var_259_1]
		end

		SetActive(arg_259_1.tipsGo_, false)

		function arg_259_1.onSingleLineFinish_()
			arg_259_1.onSingleLineUpdate_ = nil
			arg_259_1.onSingleLineFinish_ = nil
			arg_259_1.state_ = "waiting"
		end

		function arg_259_1.playNext_(arg_261_0)
			if arg_261_0 == 1 then
				arg_259_0:Play116021061(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			local var_262_0 = 0

			if var_262_0 < arg_259_1.time_ and arg_259_1.time_ <= var_262_0 + arg_262_0 then
				arg_259_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029actionlink/1029action462")
			end

			local var_262_1 = 0

			if var_262_1 < arg_259_1.time_ and arg_259_1.time_ <= var_262_1 + arg_262_0 then
				arg_259_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_262_2 = arg_259_1.actors_["1019ui_story"]
			local var_262_3 = 0

			if var_262_3 < arg_259_1.time_ and arg_259_1.time_ <= var_262_3 + arg_262_0 and not isNil(var_262_2) and arg_259_1.var_.characterEffect1019ui_story == nil then
				arg_259_1.var_.characterEffect1019ui_story = var_262_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_262_4 = 0.2

			if var_262_3 <= arg_259_1.time_ and arg_259_1.time_ < var_262_3 + var_262_4 and not isNil(var_262_2) then
				local var_262_5 = (arg_259_1.time_ - var_262_3) / var_262_4

				if arg_259_1.var_.characterEffect1019ui_story and not isNil(var_262_2) then
					local var_262_6 = Mathf.Lerp(0, 0.5, var_262_5)

					arg_259_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_259_1.var_.characterEffect1019ui_story.fillRatio = var_262_6
				end
			end

			if arg_259_1.time_ >= var_262_3 + var_262_4 and arg_259_1.time_ < var_262_3 + var_262_4 + arg_262_0 and not isNil(var_262_2) and arg_259_1.var_.characterEffect1019ui_story then
				local var_262_7 = 0.5

				arg_259_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_259_1.var_.characterEffect1019ui_story.fillRatio = var_262_7
			end

			local var_262_8 = arg_259_1.actors_["1029ui_story"]
			local var_262_9 = 0

			if var_262_9 < arg_259_1.time_ and arg_259_1.time_ <= var_262_9 + arg_262_0 and not isNil(var_262_8) and arg_259_1.var_.characterEffect1029ui_story == nil then
				arg_259_1.var_.characterEffect1029ui_story = var_262_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_262_10 = 0.2

			if var_262_9 <= arg_259_1.time_ and arg_259_1.time_ < var_262_9 + var_262_10 and not isNil(var_262_8) then
				local var_262_11 = (arg_259_1.time_ - var_262_9) / var_262_10

				if arg_259_1.var_.characterEffect1029ui_story and not isNil(var_262_8) then
					arg_259_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_259_1.time_ >= var_262_9 + var_262_10 and arg_259_1.time_ < var_262_9 + var_262_10 + arg_262_0 and not isNil(var_262_8) and arg_259_1.var_.characterEffect1029ui_story then
				arg_259_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_262_12 = 0
			local var_262_13 = 2.075

			if var_262_12 < arg_259_1.time_ and arg_259_1.time_ <= var_262_12 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0
				arg_259_1.dialogCg_.alpha = 1

				arg_259_1.dialog_:SetActive(true)
				SetActive(arg_259_1.leftNameGo_, true)

				local var_262_14 = arg_259_1:FormatText(StoryNameCfg[319].name)

				arg_259_1.leftNameTxt_.text = var_262_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_259_1.leftNameTxt_.transform)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1.leftNameTxt_.text)
				SetActive(arg_259_1.iconTrs_.gameObject, false)
				arg_259_1.callingController_:SetSelectedState("normal")

				local var_262_15 = arg_259_1:GetWordFromCfg(116021060)
				local var_262_16 = arg_259_1:FormatText(var_262_15.content)

				arg_259_1.text_.text = var_262_16

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_17 = 83
				local var_262_18 = utf8.len(var_262_16)
				local var_262_19 = var_262_17 <= 0 and var_262_13 or var_262_13 * (var_262_18 / var_262_17)

				if var_262_19 > 0 and var_262_13 < var_262_19 then
					arg_259_1.talkMaxDuration = var_262_19

					if var_262_19 + var_262_12 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_19 + var_262_12
					end
				end

				arg_259_1.text_.text = var_262_16
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116021", "116021060", "story_v_out_116021.awb") ~= 0 then
					local var_262_20 = manager.audio:GetVoiceLength("story_v_out_116021", "116021060", "story_v_out_116021.awb") / 1000

					if var_262_20 + var_262_12 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_20 + var_262_12
					end

					if var_262_15.prefab_name ~= "" and arg_259_1.actors_[var_262_15.prefab_name] ~= nil then
						local var_262_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_259_1.actors_[var_262_15.prefab_name].transform, "story_v_out_116021", "116021060", "story_v_out_116021.awb")

						arg_259_1:RecordAudio("116021060", var_262_21)
						arg_259_1:RecordAudio("116021060", var_262_21)
					else
						arg_259_1:AudioAction("play", "voice", "story_v_out_116021", "116021060", "story_v_out_116021.awb")
					end

					arg_259_1:RecordHistoryTalkVoice("story_v_out_116021", "116021060", "story_v_out_116021.awb")
				end

				arg_259_1:RecordContent(arg_259_1.text_.text)
			end

			local var_262_22 = math.max(var_262_13, arg_259_1.talkMaxDuration)

			if var_262_12 <= arg_259_1.time_ and arg_259_1.time_ < var_262_12 + var_262_22 then
				arg_259_1.typewritter.percent = (arg_259_1.time_ - var_262_12) / var_262_22

				arg_259_1.typewritter:SetDirty()
			end

			if arg_259_1.time_ >= var_262_12 + var_262_22 and arg_259_1.time_ < var_262_12 + var_262_22 + arg_262_0 then
				arg_259_1.typewritter.percent = 1

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(true)
			end
		end

		arg_259_1.nodeConfigList_ = {}

		arg_259_1:InitPlayNodeList()
	end,
	Play116021061 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 116021061
		arg_263_1.duration_ = 2.4

		SetActive(arg_263_1.tipsGo_, false)

		function arg_263_1.onSingleLineFinish_()
			arg_263_1.onSingleLineUpdate_ = nil
			arg_263_1.onSingleLineFinish_ = nil
			arg_263_1.state_ = "waiting"
		end

		function arg_263_1.playNext_(arg_265_0)
			if arg_265_0 == 1 then
				arg_263_0:Play116021062(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			local var_266_0 = 0

			if var_266_0 < arg_263_1.time_ and arg_263_1.time_ <= var_266_0 + arg_266_0 then
				arg_263_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_266_1 = arg_263_1.actors_["1019ui_story"]
			local var_266_2 = 0

			if var_266_2 < arg_263_1.time_ and arg_263_1.time_ <= var_266_2 + arg_266_0 and not isNil(var_266_1) and arg_263_1.var_.characterEffect1019ui_story == nil then
				arg_263_1.var_.characterEffect1019ui_story = var_266_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_266_3 = 0.2

			if var_266_2 <= arg_263_1.time_ and arg_263_1.time_ < var_266_2 + var_266_3 and not isNil(var_266_1) then
				local var_266_4 = (arg_263_1.time_ - var_266_2) / var_266_3

				if arg_263_1.var_.characterEffect1019ui_story and not isNil(var_266_1) then
					arg_263_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_263_1.time_ >= var_266_2 + var_266_3 and arg_263_1.time_ < var_266_2 + var_266_3 + arg_266_0 and not isNil(var_266_1) and arg_263_1.var_.characterEffect1019ui_story then
				arg_263_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_266_5 = arg_263_1.actors_["1029ui_story"]
			local var_266_6 = 0

			if var_266_6 < arg_263_1.time_ and arg_263_1.time_ <= var_266_6 + arg_266_0 and not isNil(var_266_5) and arg_263_1.var_.characterEffect1029ui_story == nil then
				arg_263_1.var_.characterEffect1029ui_story = var_266_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_266_7 = 0.2

			if var_266_6 <= arg_263_1.time_ and arg_263_1.time_ < var_266_6 + var_266_7 and not isNil(var_266_5) then
				local var_266_8 = (arg_263_1.time_ - var_266_6) / var_266_7

				if arg_263_1.var_.characterEffect1029ui_story and not isNil(var_266_5) then
					local var_266_9 = Mathf.Lerp(0, 0.5, var_266_8)

					arg_263_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_263_1.var_.characterEffect1029ui_story.fillRatio = var_266_9
				end
			end

			if arg_263_1.time_ >= var_266_6 + var_266_7 and arg_263_1.time_ < var_266_6 + var_266_7 + arg_266_0 and not isNil(var_266_5) and arg_263_1.var_.characterEffect1029ui_story then
				local var_266_10 = 0.5

				arg_263_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_263_1.var_.characterEffect1029ui_story.fillRatio = var_266_10
			end

			local var_266_11 = 0
			local var_266_12 = 0.05

			if var_266_11 < arg_263_1.time_ and arg_263_1.time_ <= var_266_11 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0
				arg_263_1.dialogCg_.alpha = 1

				arg_263_1.dialog_:SetActive(true)
				SetActive(arg_263_1.leftNameGo_, true)

				local var_266_13 = arg_263_1:FormatText(StoryNameCfg[13].name)

				arg_263_1.leftNameTxt_.text = var_266_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_263_1.leftNameTxt_.transform)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1.leftNameTxt_.text)
				SetActive(arg_263_1.iconTrs_.gameObject, false)
				arg_263_1.callingController_:SetSelectedState("normal")

				local var_266_14 = arg_263_1:GetWordFromCfg(116021061)
				local var_266_15 = arg_263_1:FormatText(var_266_14.content)

				arg_263_1.text_.text = var_266_15

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_16 = 2
				local var_266_17 = utf8.len(var_266_15)
				local var_266_18 = var_266_16 <= 0 and var_266_12 or var_266_12 * (var_266_17 / var_266_16)

				if var_266_18 > 0 and var_266_12 < var_266_18 then
					arg_263_1.talkMaxDuration = var_266_18

					if var_266_18 + var_266_11 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_18 + var_266_11
					end
				end

				arg_263_1.text_.text = var_266_15
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116021", "116021061", "story_v_out_116021.awb") ~= 0 then
					local var_266_19 = manager.audio:GetVoiceLength("story_v_out_116021", "116021061", "story_v_out_116021.awb") / 1000

					if var_266_19 + var_266_11 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_19 + var_266_11
					end

					if var_266_14.prefab_name ~= "" and arg_263_1.actors_[var_266_14.prefab_name] ~= nil then
						local var_266_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_263_1.actors_[var_266_14.prefab_name].transform, "story_v_out_116021", "116021061", "story_v_out_116021.awb")

						arg_263_1:RecordAudio("116021061", var_266_20)
						arg_263_1:RecordAudio("116021061", var_266_20)
					else
						arg_263_1:AudioAction("play", "voice", "story_v_out_116021", "116021061", "story_v_out_116021.awb")
					end

					arg_263_1:RecordHistoryTalkVoice("story_v_out_116021", "116021061", "story_v_out_116021.awb")
				end

				arg_263_1:RecordContent(arg_263_1.text_.text)
			end

			local var_266_21 = math.max(var_266_12, arg_263_1.talkMaxDuration)

			if var_266_11 <= arg_263_1.time_ and arg_263_1.time_ < var_266_11 + var_266_21 then
				arg_263_1.typewritter.percent = (arg_263_1.time_ - var_266_11) / var_266_21

				arg_263_1.typewritter:SetDirty()
			end

			if arg_263_1.time_ >= var_266_11 + var_266_21 and arg_263_1.time_ < var_266_11 + var_266_21 + arg_266_0 then
				arg_263_1.typewritter.percent = 1

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(true)
			end
		end

		arg_263_1.nodeConfigList_ = {}

		arg_263_1:InitPlayNodeList()
	end,
	Play116021062 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 116021062
		arg_267_1.duration_ = 12.63

		local var_267_0 = {
			zh = 9.966,
			ja = 12.633
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
				arg_267_0:Play116021063(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			local var_270_0 = 0

			if var_270_0 < arg_267_1.time_ and arg_267_1.time_ <= var_270_0 + arg_270_0 then
				arg_267_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action2_2")
			end

			local var_270_1 = 0

			if var_270_1 < arg_267_1.time_ and arg_267_1.time_ <= var_270_1 + arg_270_0 then
				arg_267_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_270_2 = arg_267_1.actors_["1019ui_story"]
			local var_270_3 = 0

			if var_270_3 < arg_267_1.time_ and arg_267_1.time_ <= var_270_3 + arg_270_0 and not isNil(var_270_2) and arg_267_1.var_.characterEffect1019ui_story == nil then
				arg_267_1.var_.characterEffect1019ui_story = var_270_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_270_4 = 0.2

			if var_270_3 <= arg_267_1.time_ and arg_267_1.time_ < var_270_3 + var_270_4 and not isNil(var_270_2) then
				local var_270_5 = (arg_267_1.time_ - var_270_3) / var_270_4

				if arg_267_1.var_.characterEffect1019ui_story and not isNil(var_270_2) then
					local var_270_6 = Mathf.Lerp(0, 0.5, var_270_5)

					arg_267_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_267_1.var_.characterEffect1019ui_story.fillRatio = var_270_6
				end
			end

			if arg_267_1.time_ >= var_270_3 + var_270_4 and arg_267_1.time_ < var_270_3 + var_270_4 + arg_270_0 and not isNil(var_270_2) and arg_267_1.var_.characterEffect1019ui_story then
				local var_270_7 = 0.5

				arg_267_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_267_1.var_.characterEffect1019ui_story.fillRatio = var_270_7
			end

			local var_270_8 = arg_267_1.actors_["1029ui_story"]
			local var_270_9 = 0

			if var_270_9 < arg_267_1.time_ and arg_267_1.time_ <= var_270_9 + arg_270_0 and not isNil(var_270_8) and arg_267_1.var_.characterEffect1029ui_story == nil then
				arg_267_1.var_.characterEffect1029ui_story = var_270_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_270_10 = 0.2

			if var_270_9 <= arg_267_1.time_ and arg_267_1.time_ < var_270_9 + var_270_10 and not isNil(var_270_8) then
				local var_270_11 = (arg_267_1.time_ - var_270_9) / var_270_10

				if arg_267_1.var_.characterEffect1029ui_story and not isNil(var_270_8) then
					arg_267_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_267_1.time_ >= var_270_9 + var_270_10 and arg_267_1.time_ < var_270_9 + var_270_10 + arg_270_0 and not isNil(var_270_8) and arg_267_1.var_.characterEffect1029ui_story then
				arg_267_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_270_12 = 0
			local var_270_13 = 1.025

			if var_270_12 < arg_267_1.time_ and arg_267_1.time_ <= var_270_12 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0
				arg_267_1.dialogCg_.alpha = 1

				arg_267_1.dialog_:SetActive(true)
				SetActive(arg_267_1.leftNameGo_, true)

				local var_270_14 = arg_267_1:FormatText(StoryNameCfg[319].name)

				arg_267_1.leftNameTxt_.text = var_270_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_267_1.leftNameTxt_.transform)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1.leftNameTxt_.text)
				SetActive(arg_267_1.iconTrs_.gameObject, false)
				arg_267_1.callingController_:SetSelectedState("normal")

				local var_270_15 = arg_267_1:GetWordFromCfg(116021062)
				local var_270_16 = arg_267_1:FormatText(var_270_15.content)

				arg_267_1.text_.text = var_270_16

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_17 = 42
				local var_270_18 = utf8.len(var_270_16)
				local var_270_19 = var_270_17 <= 0 and var_270_13 or var_270_13 * (var_270_18 / var_270_17)

				if var_270_19 > 0 and var_270_13 < var_270_19 then
					arg_267_1.talkMaxDuration = var_270_19

					if var_270_19 + var_270_12 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_19 + var_270_12
					end
				end

				arg_267_1.text_.text = var_270_16
				arg_267_1.typewritter.percent = 0

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116021", "116021062", "story_v_out_116021.awb") ~= 0 then
					local var_270_20 = manager.audio:GetVoiceLength("story_v_out_116021", "116021062", "story_v_out_116021.awb") / 1000

					if var_270_20 + var_270_12 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_20 + var_270_12
					end

					if var_270_15.prefab_name ~= "" and arg_267_1.actors_[var_270_15.prefab_name] ~= nil then
						local var_270_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_267_1.actors_[var_270_15.prefab_name].transform, "story_v_out_116021", "116021062", "story_v_out_116021.awb")

						arg_267_1:RecordAudio("116021062", var_270_21)
						arg_267_1:RecordAudio("116021062", var_270_21)
					else
						arg_267_1:AudioAction("play", "voice", "story_v_out_116021", "116021062", "story_v_out_116021.awb")
					end

					arg_267_1:RecordHistoryTalkVoice("story_v_out_116021", "116021062", "story_v_out_116021.awb")
				end

				arg_267_1:RecordContent(arg_267_1.text_.text)
			end

			local var_270_22 = math.max(var_270_13, arg_267_1.talkMaxDuration)

			if var_270_12 <= arg_267_1.time_ and arg_267_1.time_ < var_270_12 + var_270_22 then
				arg_267_1.typewritter.percent = (arg_267_1.time_ - var_270_12) / var_270_22

				arg_267_1.typewritter:SetDirty()
			end

			if arg_267_1.time_ >= var_270_12 + var_270_22 and arg_267_1.time_ < var_270_12 + var_270_22 + arg_270_0 then
				arg_267_1.typewritter.percent = 1

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(true)
			end
		end

		arg_267_1.nodeConfigList_ = {}

		arg_267_1:InitPlayNodeList()
	end,
	Play116021063 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 116021063
		arg_271_1.duration_ = 3.97

		local var_271_0 = {
			zh = 3.666,
			ja = 3.966
		}
		local var_271_1 = manager.audio:GetLocalizationFlag()

		if var_271_0[var_271_1] ~= nil then
			arg_271_1.duration_ = var_271_0[var_271_1]
		end

		SetActive(arg_271_1.tipsGo_, false)

		function arg_271_1.onSingleLineFinish_()
			arg_271_1.onSingleLineUpdate_ = nil
			arg_271_1.onSingleLineFinish_ = nil
			arg_271_1.state_ = "waiting"
		end

		function arg_271_1.playNext_(arg_273_0)
			if arg_273_0 == 1 then
				arg_271_0:Play116021064(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			local var_274_0 = 0

			if var_274_0 < arg_271_1.time_ and arg_271_1.time_ <= var_274_0 + arg_274_0 then
				arg_271_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_274_1 = arg_271_1.actors_["1019ui_story"]
			local var_274_2 = 0

			if var_274_2 < arg_271_1.time_ and arg_271_1.time_ <= var_274_2 + arg_274_0 and not isNil(var_274_1) and arg_271_1.var_.characterEffect1019ui_story == nil then
				arg_271_1.var_.characterEffect1019ui_story = var_274_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_274_3 = 0.2

			if var_274_2 <= arg_271_1.time_ and arg_271_1.time_ < var_274_2 + var_274_3 and not isNil(var_274_1) then
				local var_274_4 = (arg_271_1.time_ - var_274_2) / var_274_3

				if arg_271_1.var_.characterEffect1019ui_story and not isNil(var_274_1) then
					arg_271_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_271_1.time_ >= var_274_2 + var_274_3 and arg_271_1.time_ < var_274_2 + var_274_3 + arg_274_0 and not isNil(var_274_1) and arg_271_1.var_.characterEffect1019ui_story then
				arg_271_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_274_5 = arg_271_1.actors_["1029ui_story"]
			local var_274_6 = 0

			if var_274_6 < arg_271_1.time_ and arg_271_1.time_ <= var_274_6 + arg_274_0 and not isNil(var_274_5) and arg_271_1.var_.characterEffect1029ui_story == nil then
				arg_271_1.var_.characterEffect1029ui_story = var_274_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_274_7 = 0.2

			if var_274_6 <= arg_271_1.time_ and arg_271_1.time_ < var_274_6 + var_274_7 and not isNil(var_274_5) then
				local var_274_8 = (arg_271_1.time_ - var_274_6) / var_274_7

				if arg_271_1.var_.characterEffect1029ui_story and not isNil(var_274_5) then
					local var_274_9 = Mathf.Lerp(0, 0.5, var_274_8)

					arg_271_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_271_1.var_.characterEffect1029ui_story.fillRatio = var_274_9
				end
			end

			if arg_271_1.time_ >= var_274_6 + var_274_7 and arg_271_1.time_ < var_274_6 + var_274_7 + arg_274_0 and not isNil(var_274_5) and arg_271_1.var_.characterEffect1029ui_story then
				local var_274_10 = 0.5

				arg_271_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_271_1.var_.characterEffect1029ui_story.fillRatio = var_274_10
			end

			local var_274_11 = 0
			local var_274_12 = 0.25

			if var_274_11 < arg_271_1.time_ and arg_271_1.time_ <= var_274_11 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, true)

				local var_274_13 = arg_271_1:FormatText(StoryNameCfg[13].name)

				arg_271_1.leftNameTxt_.text = var_274_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_271_1.leftNameTxt_.transform)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1.leftNameTxt_.text)
				SetActive(arg_271_1.iconTrs_.gameObject, false)
				arg_271_1.callingController_:SetSelectedState("normal")

				local var_274_14 = arg_271_1:GetWordFromCfg(116021063)
				local var_274_15 = arg_271_1:FormatText(var_274_14.content)

				arg_271_1.text_.text = var_274_15

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_16 = 10
				local var_274_17 = utf8.len(var_274_15)
				local var_274_18 = var_274_16 <= 0 and var_274_12 or var_274_12 * (var_274_17 / var_274_16)

				if var_274_18 > 0 and var_274_12 < var_274_18 then
					arg_271_1.talkMaxDuration = var_274_18

					if var_274_18 + var_274_11 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_18 + var_274_11
					end
				end

				arg_271_1.text_.text = var_274_15
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116021", "116021063", "story_v_out_116021.awb") ~= 0 then
					local var_274_19 = manager.audio:GetVoiceLength("story_v_out_116021", "116021063", "story_v_out_116021.awb") / 1000

					if var_274_19 + var_274_11 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_19 + var_274_11
					end

					if var_274_14.prefab_name ~= "" and arg_271_1.actors_[var_274_14.prefab_name] ~= nil then
						local var_274_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_271_1.actors_[var_274_14.prefab_name].transform, "story_v_out_116021", "116021063", "story_v_out_116021.awb")

						arg_271_1:RecordAudio("116021063", var_274_20)
						arg_271_1:RecordAudio("116021063", var_274_20)
					else
						arg_271_1:AudioAction("play", "voice", "story_v_out_116021", "116021063", "story_v_out_116021.awb")
					end

					arg_271_1:RecordHistoryTalkVoice("story_v_out_116021", "116021063", "story_v_out_116021.awb")
				end

				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_21 = math.max(var_274_12, arg_271_1.talkMaxDuration)

			if var_274_11 <= arg_271_1.time_ and arg_271_1.time_ < var_274_11 + var_274_21 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - var_274_11) / var_274_21

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= var_274_11 + var_274_21 and arg_271_1.time_ < var_274_11 + var_274_21 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {}

		arg_271_1:InitPlayNodeList()
	end,
	Play116021064 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 116021064
		arg_275_1.duration_ = 10

		local var_275_0 = {
			zh = 10,
			ja = 7.533
		}
		local var_275_1 = manager.audio:GetLocalizationFlag()

		if var_275_0[var_275_1] ~= nil then
			arg_275_1.duration_ = var_275_0[var_275_1]
		end

		SetActive(arg_275_1.tipsGo_, false)

		function arg_275_1.onSingleLineFinish_()
			arg_275_1.onSingleLineUpdate_ = nil
			arg_275_1.onSingleLineFinish_ = nil
			arg_275_1.state_ = "waiting"
		end

		function arg_275_1.playNext_(arg_277_0)
			if arg_277_0 == 1 then
				arg_275_0:Play116021065(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			local var_278_0 = 0

			if var_278_0 < arg_275_1.time_ and arg_275_1.time_ <= var_278_0 + arg_278_0 then
				arg_275_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_278_1 = arg_275_1.actors_["1019ui_story"]
			local var_278_2 = 0

			if var_278_2 < arg_275_1.time_ and arg_275_1.time_ <= var_278_2 + arg_278_0 and not isNil(var_278_1) and arg_275_1.var_.characterEffect1019ui_story == nil then
				arg_275_1.var_.characterEffect1019ui_story = var_278_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_278_3 = 0.2

			if var_278_2 <= arg_275_1.time_ and arg_275_1.time_ < var_278_2 + var_278_3 and not isNil(var_278_1) then
				local var_278_4 = (arg_275_1.time_ - var_278_2) / var_278_3

				if arg_275_1.var_.characterEffect1019ui_story and not isNil(var_278_1) then
					local var_278_5 = Mathf.Lerp(0, 0.5, var_278_4)

					arg_275_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_275_1.var_.characterEffect1019ui_story.fillRatio = var_278_5
				end
			end

			if arg_275_1.time_ >= var_278_2 + var_278_3 and arg_275_1.time_ < var_278_2 + var_278_3 + arg_278_0 and not isNil(var_278_1) and arg_275_1.var_.characterEffect1019ui_story then
				local var_278_6 = 0.5

				arg_275_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_275_1.var_.characterEffect1019ui_story.fillRatio = var_278_6
			end

			local var_278_7 = arg_275_1.actors_["1029ui_story"]
			local var_278_8 = 0

			if var_278_8 < arg_275_1.time_ and arg_275_1.time_ <= var_278_8 + arg_278_0 and not isNil(var_278_7) and arg_275_1.var_.characterEffect1029ui_story == nil then
				arg_275_1.var_.characterEffect1029ui_story = var_278_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_278_9 = 0.2

			if var_278_8 <= arg_275_1.time_ and arg_275_1.time_ < var_278_8 + var_278_9 and not isNil(var_278_7) then
				local var_278_10 = (arg_275_1.time_ - var_278_8) / var_278_9

				if arg_275_1.var_.characterEffect1029ui_story and not isNil(var_278_7) then
					arg_275_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_275_1.time_ >= var_278_8 + var_278_9 and arg_275_1.time_ < var_278_8 + var_278_9 + arg_278_0 and not isNil(var_278_7) and arg_275_1.var_.characterEffect1029ui_story then
				arg_275_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_278_11 = 0
			local var_278_12 = 1.125

			if var_278_11 < arg_275_1.time_ and arg_275_1.time_ <= var_278_11 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0
				arg_275_1.dialogCg_.alpha = 1

				arg_275_1.dialog_:SetActive(true)
				SetActive(arg_275_1.leftNameGo_, true)

				local var_278_13 = arg_275_1:FormatText(StoryNameCfg[319].name)

				arg_275_1.leftNameTxt_.text = var_278_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_275_1.leftNameTxt_.transform)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1.leftNameTxt_.text)
				SetActive(arg_275_1.iconTrs_.gameObject, false)
				arg_275_1.callingController_:SetSelectedState("normal")

				local var_278_14 = arg_275_1:GetWordFromCfg(116021064)
				local var_278_15 = arg_275_1:FormatText(var_278_14.content)

				arg_275_1.text_.text = var_278_15

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_16 = 45
				local var_278_17 = utf8.len(var_278_15)
				local var_278_18 = var_278_16 <= 0 and var_278_12 or var_278_12 * (var_278_17 / var_278_16)

				if var_278_18 > 0 and var_278_12 < var_278_18 then
					arg_275_1.talkMaxDuration = var_278_18

					if var_278_18 + var_278_11 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_18 + var_278_11
					end
				end

				arg_275_1.text_.text = var_278_15
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116021", "116021064", "story_v_out_116021.awb") ~= 0 then
					local var_278_19 = manager.audio:GetVoiceLength("story_v_out_116021", "116021064", "story_v_out_116021.awb") / 1000

					if var_278_19 + var_278_11 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_19 + var_278_11
					end

					if var_278_14.prefab_name ~= "" and arg_275_1.actors_[var_278_14.prefab_name] ~= nil then
						local var_278_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_275_1.actors_[var_278_14.prefab_name].transform, "story_v_out_116021", "116021064", "story_v_out_116021.awb")

						arg_275_1:RecordAudio("116021064", var_278_20)
						arg_275_1:RecordAudio("116021064", var_278_20)
					else
						arg_275_1:AudioAction("play", "voice", "story_v_out_116021", "116021064", "story_v_out_116021.awb")
					end

					arg_275_1:RecordHistoryTalkVoice("story_v_out_116021", "116021064", "story_v_out_116021.awb")
				end

				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_21 = math.max(var_278_12, arg_275_1.talkMaxDuration)

			if var_278_11 <= arg_275_1.time_ and arg_275_1.time_ < var_278_11 + var_278_21 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - var_278_11) / var_278_21

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= var_278_11 + var_278_21 and arg_275_1.time_ < var_278_11 + var_278_21 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {}

		arg_275_1:InitPlayNodeList()
	end,
	Play116021065 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 116021065
		arg_279_1.duration_ = 4.73

		local var_279_0 = {
			zh = 4.166,
			ja = 4.733
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
				arg_279_0:Play116021066(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			local var_282_0 = 0

			if var_282_0 < arg_279_1.time_ and arg_279_1.time_ <= var_282_0 + arg_282_0 then
				arg_279_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_282_1 = arg_279_1.actors_["1019ui_story"]
			local var_282_2 = 0

			if var_282_2 < arg_279_1.time_ and arg_279_1.time_ <= var_282_2 + arg_282_0 and not isNil(var_282_1) and arg_279_1.var_.characterEffect1019ui_story == nil then
				arg_279_1.var_.characterEffect1019ui_story = var_282_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_282_3 = 0.2

			if var_282_2 <= arg_279_1.time_ and arg_279_1.time_ < var_282_2 + var_282_3 and not isNil(var_282_1) then
				local var_282_4 = (arg_279_1.time_ - var_282_2) / var_282_3

				if arg_279_1.var_.characterEffect1019ui_story and not isNil(var_282_1) then
					arg_279_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_279_1.time_ >= var_282_2 + var_282_3 and arg_279_1.time_ < var_282_2 + var_282_3 + arg_282_0 and not isNil(var_282_1) and arg_279_1.var_.characterEffect1019ui_story then
				arg_279_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_282_5 = arg_279_1.actors_["1029ui_story"]
			local var_282_6 = 0

			if var_282_6 < arg_279_1.time_ and arg_279_1.time_ <= var_282_6 + arg_282_0 and not isNil(var_282_5) and arg_279_1.var_.characterEffect1029ui_story == nil then
				arg_279_1.var_.characterEffect1029ui_story = var_282_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_282_7 = 0.2

			if var_282_6 <= arg_279_1.time_ and arg_279_1.time_ < var_282_6 + var_282_7 and not isNil(var_282_5) then
				local var_282_8 = (arg_279_1.time_ - var_282_6) / var_282_7

				if arg_279_1.var_.characterEffect1029ui_story and not isNil(var_282_5) then
					local var_282_9 = Mathf.Lerp(0, 0.5, var_282_8)

					arg_279_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_279_1.var_.characterEffect1029ui_story.fillRatio = var_282_9
				end
			end

			if arg_279_1.time_ >= var_282_6 + var_282_7 and arg_279_1.time_ < var_282_6 + var_282_7 + arg_282_0 and not isNil(var_282_5) and arg_279_1.var_.characterEffect1029ui_story then
				local var_282_10 = 0.5

				arg_279_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_279_1.var_.characterEffect1029ui_story.fillRatio = var_282_10
			end

			local var_282_11 = 0
			local var_282_12 = 0.55

			if var_282_11 < arg_279_1.time_ and arg_279_1.time_ <= var_282_11 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0
				arg_279_1.dialogCg_.alpha = 1

				arg_279_1.dialog_:SetActive(true)
				SetActive(arg_279_1.leftNameGo_, true)

				local var_282_13 = arg_279_1:FormatText(StoryNameCfg[13].name)

				arg_279_1.leftNameTxt_.text = var_282_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_279_1.leftNameTxt_.transform)

				arg_279_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_279_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_279_1:RecordName(arg_279_1.leftNameTxt_.text)
				SetActive(arg_279_1.iconTrs_.gameObject, false)
				arg_279_1.callingController_:SetSelectedState("normal")

				local var_282_14 = arg_279_1:GetWordFromCfg(116021065)
				local var_282_15 = arg_279_1:FormatText(var_282_14.content)

				arg_279_1.text_.text = var_282_15

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_16 = 22
				local var_282_17 = utf8.len(var_282_15)
				local var_282_18 = var_282_16 <= 0 and var_282_12 or var_282_12 * (var_282_17 / var_282_16)

				if var_282_18 > 0 and var_282_12 < var_282_18 then
					arg_279_1.talkMaxDuration = var_282_18

					if var_282_18 + var_282_11 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_18 + var_282_11
					end
				end

				arg_279_1.text_.text = var_282_15
				arg_279_1.typewritter.percent = 0

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116021", "116021065", "story_v_out_116021.awb") ~= 0 then
					local var_282_19 = manager.audio:GetVoiceLength("story_v_out_116021", "116021065", "story_v_out_116021.awb") / 1000

					if var_282_19 + var_282_11 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_19 + var_282_11
					end

					if var_282_14.prefab_name ~= "" and arg_279_1.actors_[var_282_14.prefab_name] ~= nil then
						local var_282_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_279_1.actors_[var_282_14.prefab_name].transform, "story_v_out_116021", "116021065", "story_v_out_116021.awb")

						arg_279_1:RecordAudio("116021065", var_282_20)
						arg_279_1:RecordAudio("116021065", var_282_20)
					else
						arg_279_1:AudioAction("play", "voice", "story_v_out_116021", "116021065", "story_v_out_116021.awb")
					end

					arg_279_1:RecordHistoryTalkVoice("story_v_out_116021", "116021065", "story_v_out_116021.awb")
				end

				arg_279_1:RecordContent(arg_279_1.text_.text)
			end

			local var_282_21 = math.max(var_282_12, arg_279_1.talkMaxDuration)

			if var_282_11 <= arg_279_1.time_ and arg_279_1.time_ < var_282_11 + var_282_21 then
				arg_279_1.typewritter.percent = (arg_279_1.time_ - var_282_11) / var_282_21

				arg_279_1.typewritter:SetDirty()
			end

			if arg_279_1.time_ >= var_282_11 + var_282_21 and arg_279_1.time_ < var_282_11 + var_282_21 + arg_282_0 then
				arg_279_1.typewritter.percent = 1

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(true)
			end
		end

		arg_279_1.nodeConfigList_ = {}

		arg_279_1:InitPlayNodeList()
	end,
	Play116021066 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 116021066
		arg_283_1.duration_ = 9.57

		local var_283_0 = {
			zh = 5.8,
			ja = 9.566
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
				arg_283_0:Play116021067(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			local var_286_0 = 0

			if var_286_0 < arg_283_1.time_ and arg_283_1.time_ <= var_286_0 + arg_286_0 then
				arg_283_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_286_1 = arg_283_1.actors_["1019ui_story"]
			local var_286_2 = 0

			if var_286_2 < arg_283_1.time_ and arg_283_1.time_ <= var_286_2 + arg_286_0 and not isNil(var_286_1) and arg_283_1.var_.characterEffect1019ui_story == nil then
				arg_283_1.var_.characterEffect1019ui_story = var_286_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_286_3 = 0.2

			if var_286_2 <= arg_283_1.time_ and arg_283_1.time_ < var_286_2 + var_286_3 and not isNil(var_286_1) then
				local var_286_4 = (arg_283_1.time_ - var_286_2) / var_286_3

				if arg_283_1.var_.characterEffect1019ui_story and not isNil(var_286_1) then
					local var_286_5 = Mathf.Lerp(0, 0.5, var_286_4)

					arg_283_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_283_1.var_.characterEffect1019ui_story.fillRatio = var_286_5
				end
			end

			if arg_283_1.time_ >= var_286_2 + var_286_3 and arg_283_1.time_ < var_286_2 + var_286_3 + arg_286_0 and not isNil(var_286_1) and arg_283_1.var_.characterEffect1019ui_story then
				local var_286_6 = 0.5

				arg_283_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_283_1.var_.characterEffect1019ui_story.fillRatio = var_286_6
			end

			local var_286_7 = arg_283_1.actors_["1029ui_story"]
			local var_286_8 = 0

			if var_286_8 < arg_283_1.time_ and arg_283_1.time_ <= var_286_8 + arg_286_0 and not isNil(var_286_7) and arg_283_1.var_.characterEffect1029ui_story == nil then
				arg_283_1.var_.characterEffect1029ui_story = var_286_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_286_9 = 0.2

			if var_286_8 <= arg_283_1.time_ and arg_283_1.time_ < var_286_8 + var_286_9 and not isNil(var_286_7) then
				local var_286_10 = (arg_283_1.time_ - var_286_8) / var_286_9

				if arg_283_1.var_.characterEffect1029ui_story and not isNil(var_286_7) then
					arg_283_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_283_1.time_ >= var_286_8 + var_286_9 and arg_283_1.time_ < var_286_8 + var_286_9 + arg_286_0 and not isNil(var_286_7) and arg_283_1.var_.characterEffect1029ui_story then
				arg_283_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_286_11 = 0
			local var_286_12 = 0.5

			if var_286_11 < arg_283_1.time_ and arg_283_1.time_ <= var_286_11 + arg_286_0 then
				arg_283_1.talkMaxDuration = 0
				arg_283_1.dialogCg_.alpha = 1

				arg_283_1.dialog_:SetActive(true)
				SetActive(arg_283_1.leftNameGo_, true)

				local var_286_13 = arg_283_1:FormatText(StoryNameCfg[319].name)

				arg_283_1.leftNameTxt_.text = var_286_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_283_1.leftNameTxt_.transform)

				arg_283_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_283_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_283_1:RecordName(arg_283_1.leftNameTxt_.text)
				SetActive(arg_283_1.iconTrs_.gameObject, false)
				arg_283_1.callingController_:SetSelectedState("normal")

				local var_286_14 = arg_283_1:GetWordFromCfg(116021066)
				local var_286_15 = arg_283_1:FormatText(var_286_14.content)

				arg_283_1.text_.text = var_286_15

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_16 = 20
				local var_286_17 = utf8.len(var_286_15)
				local var_286_18 = var_286_16 <= 0 and var_286_12 or var_286_12 * (var_286_17 / var_286_16)

				if var_286_18 > 0 and var_286_12 < var_286_18 then
					arg_283_1.talkMaxDuration = var_286_18

					if var_286_18 + var_286_11 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_18 + var_286_11
					end
				end

				arg_283_1.text_.text = var_286_15
				arg_283_1.typewritter.percent = 0

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116021", "116021066", "story_v_out_116021.awb") ~= 0 then
					local var_286_19 = manager.audio:GetVoiceLength("story_v_out_116021", "116021066", "story_v_out_116021.awb") / 1000

					if var_286_19 + var_286_11 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_19 + var_286_11
					end

					if var_286_14.prefab_name ~= "" and arg_283_1.actors_[var_286_14.prefab_name] ~= nil then
						local var_286_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_283_1.actors_[var_286_14.prefab_name].transform, "story_v_out_116021", "116021066", "story_v_out_116021.awb")

						arg_283_1:RecordAudio("116021066", var_286_20)
						arg_283_1:RecordAudio("116021066", var_286_20)
					else
						arg_283_1:AudioAction("play", "voice", "story_v_out_116021", "116021066", "story_v_out_116021.awb")
					end

					arg_283_1:RecordHistoryTalkVoice("story_v_out_116021", "116021066", "story_v_out_116021.awb")
				end

				arg_283_1:RecordContent(arg_283_1.text_.text)
			end

			local var_286_21 = math.max(var_286_12, arg_283_1.talkMaxDuration)

			if var_286_11 <= arg_283_1.time_ and arg_283_1.time_ < var_286_11 + var_286_21 then
				arg_283_1.typewritter.percent = (arg_283_1.time_ - var_286_11) / var_286_21

				arg_283_1.typewritter:SetDirty()
			end

			if arg_283_1.time_ >= var_286_11 + var_286_21 and arg_283_1.time_ < var_286_11 + var_286_21 + arg_286_0 then
				arg_283_1.typewritter.percent = 1

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(true)
			end
		end

		arg_283_1.nodeConfigList_ = {}

		arg_283_1:InitPlayNodeList()
	end,
	Play116021067 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 116021067
		arg_287_1.duration_ = 15.23

		local var_287_0 = {
			zh = 15.233,
			ja = 12.266
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
				arg_287_0:Play116021068(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			local var_290_0 = 0

			if var_290_0 < arg_287_1.time_ and arg_287_1.time_ <= var_290_0 + arg_290_0 then
				arg_287_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_290_1 = arg_287_1.actors_["1019ui_story"]
			local var_290_2 = 0

			if var_290_2 < arg_287_1.time_ and arg_287_1.time_ <= var_290_2 + arg_290_0 and not isNil(var_290_1) and arg_287_1.var_.characterEffect1019ui_story == nil then
				arg_287_1.var_.characterEffect1019ui_story = var_290_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_290_3 = 0.2

			if var_290_2 <= arg_287_1.time_ and arg_287_1.time_ < var_290_2 + var_290_3 and not isNil(var_290_1) then
				local var_290_4 = (arg_287_1.time_ - var_290_2) / var_290_3

				if arg_287_1.var_.characterEffect1019ui_story and not isNil(var_290_1) then
					arg_287_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_287_1.time_ >= var_290_2 + var_290_3 and arg_287_1.time_ < var_290_2 + var_290_3 + arg_290_0 and not isNil(var_290_1) and arg_287_1.var_.characterEffect1019ui_story then
				arg_287_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_290_5 = arg_287_1.actors_["1029ui_story"]
			local var_290_6 = 0

			if var_290_6 < arg_287_1.time_ and arg_287_1.time_ <= var_290_6 + arg_290_0 and not isNil(var_290_5) and arg_287_1.var_.characterEffect1029ui_story == nil then
				arg_287_1.var_.characterEffect1029ui_story = var_290_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_290_7 = 0.2

			if var_290_6 <= arg_287_1.time_ and arg_287_1.time_ < var_290_6 + var_290_7 and not isNil(var_290_5) then
				local var_290_8 = (arg_287_1.time_ - var_290_6) / var_290_7

				if arg_287_1.var_.characterEffect1029ui_story and not isNil(var_290_5) then
					local var_290_9 = Mathf.Lerp(0, 0.5, var_290_8)

					arg_287_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_287_1.var_.characterEffect1029ui_story.fillRatio = var_290_9
				end
			end

			if arg_287_1.time_ >= var_290_6 + var_290_7 and arg_287_1.time_ < var_290_6 + var_290_7 + arg_290_0 and not isNil(var_290_5) and arg_287_1.var_.characterEffect1029ui_story then
				local var_290_10 = 0.5

				arg_287_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_287_1.var_.characterEffect1029ui_story.fillRatio = var_290_10
			end

			local var_290_11 = 0
			local var_290_12 = 1.375

			if var_290_11 < arg_287_1.time_ and arg_287_1.time_ <= var_290_11 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0
				arg_287_1.dialogCg_.alpha = 1

				arg_287_1.dialog_:SetActive(true)
				SetActive(arg_287_1.leftNameGo_, true)

				local var_290_13 = arg_287_1:FormatText(StoryNameCfg[13].name)

				arg_287_1.leftNameTxt_.text = var_290_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_287_1.leftNameTxt_.transform)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1.leftNameTxt_.text)
				SetActive(arg_287_1.iconTrs_.gameObject, false)
				arg_287_1.callingController_:SetSelectedState("normal")

				local var_290_14 = arg_287_1:GetWordFromCfg(116021067)
				local var_290_15 = arg_287_1:FormatText(var_290_14.content)

				arg_287_1.text_.text = var_290_15

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_16 = 54
				local var_290_17 = utf8.len(var_290_15)
				local var_290_18 = var_290_16 <= 0 and var_290_12 or var_290_12 * (var_290_17 / var_290_16)

				if var_290_18 > 0 and var_290_12 < var_290_18 then
					arg_287_1.talkMaxDuration = var_290_18

					if var_290_18 + var_290_11 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_18 + var_290_11
					end
				end

				arg_287_1.text_.text = var_290_15
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116021", "116021067", "story_v_out_116021.awb") ~= 0 then
					local var_290_19 = manager.audio:GetVoiceLength("story_v_out_116021", "116021067", "story_v_out_116021.awb") / 1000

					if var_290_19 + var_290_11 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_19 + var_290_11
					end

					if var_290_14.prefab_name ~= "" and arg_287_1.actors_[var_290_14.prefab_name] ~= nil then
						local var_290_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_287_1.actors_[var_290_14.prefab_name].transform, "story_v_out_116021", "116021067", "story_v_out_116021.awb")

						arg_287_1:RecordAudio("116021067", var_290_20)
						arg_287_1:RecordAudio("116021067", var_290_20)
					else
						arg_287_1:AudioAction("play", "voice", "story_v_out_116021", "116021067", "story_v_out_116021.awb")
					end

					arg_287_1:RecordHistoryTalkVoice("story_v_out_116021", "116021067", "story_v_out_116021.awb")
				end

				arg_287_1:RecordContent(arg_287_1.text_.text)
			end

			local var_290_21 = math.max(var_290_12, arg_287_1.talkMaxDuration)

			if var_290_11 <= arg_287_1.time_ and arg_287_1.time_ < var_290_11 + var_290_21 then
				arg_287_1.typewritter.percent = (arg_287_1.time_ - var_290_11) / var_290_21

				arg_287_1.typewritter:SetDirty()
			end

			if arg_287_1.time_ >= var_290_11 + var_290_21 and arg_287_1.time_ < var_290_11 + var_290_21 + arg_290_0 then
				arg_287_1.typewritter.percent = 1

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(true)
			end
		end

		arg_287_1.nodeConfigList_ = {}

		arg_287_1:InitPlayNodeList()
	end,
	Play116021068 = function(arg_291_0, arg_291_1)
		arg_291_1.time_ = 0
		arg_291_1.frameCnt_ = 0
		arg_291_1.state_ = "playing"
		arg_291_1.curTalkId_ = 116021068
		arg_291_1.duration_ = 5

		SetActive(arg_291_1.tipsGo_, false)

		function arg_291_1.onSingleLineFinish_()
			arg_291_1.onSingleLineUpdate_ = nil
			arg_291_1.onSingleLineFinish_ = nil
			arg_291_1.state_ = "waiting"
		end

		function arg_291_1.playNext_(arg_293_0)
			if arg_293_0 == 1 then
				arg_291_0:Play116021069(arg_291_1)
			end
		end

		function arg_291_1.onSingleLineUpdate_(arg_294_0)
			local var_294_0 = arg_291_1.actors_["1019ui_story"]
			local var_294_1 = 0

			if var_294_1 < arg_291_1.time_ and arg_291_1.time_ <= var_294_1 + arg_294_0 and not isNil(var_294_0) and arg_291_1.var_.characterEffect1019ui_story == nil then
				arg_291_1.var_.characterEffect1019ui_story = var_294_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_294_2 = 0.2

			if var_294_1 <= arg_291_1.time_ and arg_291_1.time_ < var_294_1 + var_294_2 and not isNil(var_294_0) then
				local var_294_3 = (arg_291_1.time_ - var_294_1) / var_294_2

				if arg_291_1.var_.characterEffect1019ui_story and not isNil(var_294_0) then
					local var_294_4 = Mathf.Lerp(0, 0.5, var_294_3)

					arg_291_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_291_1.var_.characterEffect1019ui_story.fillRatio = var_294_4
				end
			end

			if arg_291_1.time_ >= var_294_1 + var_294_2 and arg_291_1.time_ < var_294_1 + var_294_2 + arg_294_0 and not isNil(var_294_0) and arg_291_1.var_.characterEffect1019ui_story then
				local var_294_5 = 0.5

				arg_291_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_291_1.var_.characterEffect1019ui_story.fillRatio = var_294_5
			end

			local var_294_6 = 0
			local var_294_7 = 0.9

			if var_294_6 < arg_291_1.time_ and arg_291_1.time_ <= var_294_6 + arg_294_0 then
				arg_291_1.talkMaxDuration = 0
				arg_291_1.dialogCg_.alpha = 1

				arg_291_1.dialog_:SetActive(true)
				SetActive(arg_291_1.leftNameGo_, false)

				arg_291_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_291_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_291_1:RecordName(arg_291_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_291_1.iconTrs_.gameObject, false)
				arg_291_1.callingController_:SetSelectedState("normal")

				local var_294_8 = arg_291_1:GetWordFromCfg(116021068)
				local var_294_9 = arg_291_1:FormatText(var_294_8.content)

				arg_291_1.text_.text = var_294_9

				LuaForUtil.ClearLinePrefixSymbol(arg_291_1.text_)

				local var_294_10 = 36
				local var_294_11 = utf8.len(var_294_9)
				local var_294_12 = var_294_10 <= 0 and var_294_7 or var_294_7 * (var_294_11 / var_294_10)

				if var_294_12 > 0 and var_294_7 < var_294_12 then
					arg_291_1.talkMaxDuration = var_294_12

					if var_294_12 + var_294_6 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_12 + var_294_6
					end
				end

				arg_291_1.text_.text = var_294_9
				arg_291_1.typewritter.percent = 0

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(false)
				arg_291_1:RecordContent(arg_291_1.text_.text)
			end

			local var_294_13 = math.max(var_294_7, arg_291_1.talkMaxDuration)

			if var_294_6 <= arg_291_1.time_ and arg_291_1.time_ < var_294_6 + var_294_13 then
				arg_291_1.typewritter.percent = (arg_291_1.time_ - var_294_6) / var_294_13

				arg_291_1.typewritter:SetDirty()
			end

			if arg_291_1.time_ >= var_294_6 + var_294_13 and arg_291_1.time_ < var_294_6 + var_294_13 + arg_294_0 then
				arg_291_1.typewritter.percent = 1

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(true)
			end
		end

		arg_291_1.nodeConfigList_ = {}

		arg_291_1:InitPlayNodeList()
	end,
	Play116021069 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 116021069
		arg_295_1.duration_ = 5

		SetActive(arg_295_1.tipsGo_, false)

		function arg_295_1.onSingleLineFinish_()
			arg_295_1.onSingleLineUpdate_ = nil
			arg_295_1.onSingleLineFinish_ = nil
			arg_295_1.state_ = "waiting"
		end

		function arg_295_1.playNext_(arg_297_0)
			if arg_297_0 == 1 then
				arg_295_0:Play116021070(arg_295_1)
			end
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			local var_298_0 = 0
			local var_298_1 = 0.175

			if var_298_0 < arg_295_1.time_ and arg_295_1.time_ <= var_298_0 + arg_298_0 then
				arg_295_1.talkMaxDuration = 0
				arg_295_1.dialogCg_.alpha = 1

				arg_295_1.dialog_:SetActive(true)
				SetActive(arg_295_1.leftNameGo_, false)

				arg_295_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_295_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_295_1:RecordName(arg_295_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_295_1.iconTrs_.gameObject, false)
				arg_295_1.callingController_:SetSelectedState("normal")

				local var_298_2 = arg_295_1:GetWordFromCfg(116021069)
				local var_298_3 = arg_295_1:FormatText(var_298_2.content)

				arg_295_1.text_.text = var_298_3

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_4 = 7
				local var_298_5 = utf8.len(var_298_3)
				local var_298_6 = var_298_4 <= 0 and var_298_1 or var_298_1 * (var_298_5 / var_298_4)

				if var_298_6 > 0 and var_298_1 < var_298_6 then
					arg_295_1.talkMaxDuration = var_298_6

					if var_298_6 + var_298_0 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_6 + var_298_0
					end
				end

				arg_295_1.text_.text = var_298_3
				arg_295_1.typewritter.percent = 0

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(false)
				arg_295_1:RecordContent(arg_295_1.text_.text)
			end

			local var_298_7 = math.max(var_298_1, arg_295_1.talkMaxDuration)

			if var_298_0 <= arg_295_1.time_ and arg_295_1.time_ < var_298_0 + var_298_7 then
				arg_295_1.typewritter.percent = (arg_295_1.time_ - var_298_0) / var_298_7

				arg_295_1.typewritter:SetDirty()
			end

			if arg_295_1.time_ >= var_298_0 + var_298_7 and arg_295_1.time_ < var_298_0 + var_298_7 + arg_298_0 then
				arg_295_1.typewritter.percent = 1

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(true)
			end
		end

		arg_295_1.nodeConfigList_ = {}

		arg_295_1:InitPlayNodeList()
	end,
	Play116021070 = function(arg_299_0, arg_299_1)
		arg_299_1.time_ = 0
		arg_299_1.frameCnt_ = 0
		arg_299_1.state_ = "playing"
		arg_299_1.curTalkId_ = 116021070
		arg_299_1.duration_ = 3.97

		local var_299_0 = {
			zh = 2.166,
			ja = 3.966
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
				arg_299_0:Play116021071(arg_299_1)
			end
		end

		function arg_299_1.onSingleLineUpdate_(arg_302_0)
			local var_302_0 = 0

			if var_302_0 < arg_299_1.time_ and arg_299_1.time_ <= var_302_0 + arg_302_0 then
				arg_299_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_302_1 = 0

			if var_302_1 < arg_299_1.time_ and arg_299_1.time_ <= var_302_1 + arg_302_0 then
				arg_299_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action5_2")
			end

			local var_302_2 = arg_299_1.actors_["1019ui_story"]
			local var_302_3 = 0

			if var_302_3 < arg_299_1.time_ and arg_299_1.time_ <= var_302_3 + arg_302_0 and not isNil(var_302_2) and arg_299_1.var_.characterEffect1019ui_story == nil then
				arg_299_1.var_.characterEffect1019ui_story = var_302_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_302_4 = 0.2

			if var_302_3 <= arg_299_1.time_ and arg_299_1.time_ < var_302_3 + var_302_4 and not isNil(var_302_2) then
				local var_302_5 = (arg_299_1.time_ - var_302_3) / var_302_4

				if arg_299_1.var_.characterEffect1019ui_story and not isNil(var_302_2) then
					arg_299_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_299_1.time_ >= var_302_3 + var_302_4 and arg_299_1.time_ < var_302_3 + var_302_4 + arg_302_0 and not isNil(var_302_2) and arg_299_1.var_.characterEffect1019ui_story then
				arg_299_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_302_6 = 0
			local var_302_7 = 0.225

			if var_302_6 < arg_299_1.time_ and arg_299_1.time_ <= var_302_6 + arg_302_0 then
				arg_299_1.talkMaxDuration = 0
				arg_299_1.dialogCg_.alpha = 1

				arg_299_1.dialog_:SetActive(true)
				SetActive(arg_299_1.leftNameGo_, true)

				local var_302_8 = arg_299_1:FormatText(StoryNameCfg[13].name)

				arg_299_1.leftNameTxt_.text = var_302_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_299_1.leftNameTxt_.transform)

				arg_299_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_299_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_299_1:RecordName(arg_299_1.leftNameTxt_.text)
				SetActive(arg_299_1.iconTrs_.gameObject, false)
				arg_299_1.callingController_:SetSelectedState("normal")

				local var_302_9 = arg_299_1:GetWordFromCfg(116021070)
				local var_302_10 = arg_299_1:FormatText(var_302_9.content)

				arg_299_1.text_.text = var_302_10

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.text_)

				local var_302_11 = 9
				local var_302_12 = utf8.len(var_302_10)
				local var_302_13 = var_302_11 <= 0 and var_302_7 or var_302_7 * (var_302_12 / var_302_11)

				if var_302_13 > 0 and var_302_7 < var_302_13 then
					arg_299_1.talkMaxDuration = var_302_13

					if var_302_13 + var_302_6 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_13 + var_302_6
					end
				end

				arg_299_1.text_.text = var_302_10
				arg_299_1.typewritter.percent = 0

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116021", "116021070", "story_v_out_116021.awb") ~= 0 then
					local var_302_14 = manager.audio:GetVoiceLength("story_v_out_116021", "116021070", "story_v_out_116021.awb") / 1000

					if var_302_14 + var_302_6 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_14 + var_302_6
					end

					if var_302_9.prefab_name ~= "" and arg_299_1.actors_[var_302_9.prefab_name] ~= nil then
						local var_302_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_299_1.actors_[var_302_9.prefab_name].transform, "story_v_out_116021", "116021070", "story_v_out_116021.awb")

						arg_299_1:RecordAudio("116021070", var_302_15)
						arg_299_1:RecordAudio("116021070", var_302_15)
					else
						arg_299_1:AudioAction("play", "voice", "story_v_out_116021", "116021070", "story_v_out_116021.awb")
					end

					arg_299_1:RecordHistoryTalkVoice("story_v_out_116021", "116021070", "story_v_out_116021.awb")
				end

				arg_299_1:RecordContent(arg_299_1.text_.text)
			end

			local var_302_16 = math.max(var_302_7, arg_299_1.talkMaxDuration)

			if var_302_6 <= arg_299_1.time_ and arg_299_1.time_ < var_302_6 + var_302_16 then
				arg_299_1.typewritter.percent = (arg_299_1.time_ - var_302_6) / var_302_16

				arg_299_1.typewritter:SetDirty()
			end

			if arg_299_1.time_ >= var_302_6 + var_302_16 and arg_299_1.time_ < var_302_6 + var_302_16 + arg_302_0 then
				arg_299_1.typewritter.percent = 1

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(true)
			end
		end

		arg_299_1.nodeConfigList_ = {}

		arg_299_1:InitPlayNodeList()
	end,
	Play116021071 = function(arg_303_0, arg_303_1)
		arg_303_1.time_ = 0
		arg_303_1.frameCnt_ = 0
		arg_303_1.state_ = "playing"
		arg_303_1.curTalkId_ = 116021071
		arg_303_1.duration_ = 5

		SetActive(arg_303_1.tipsGo_, false)

		function arg_303_1.onSingleLineFinish_()
			arg_303_1.onSingleLineUpdate_ = nil
			arg_303_1.onSingleLineFinish_ = nil
			arg_303_1.state_ = "waiting"
		end

		function arg_303_1.playNext_(arg_305_0)
			if arg_305_0 == 1 then
				arg_303_0:Play116021072(arg_303_1)
			end
		end

		function arg_303_1.onSingleLineUpdate_(arg_306_0)
			local var_306_0 = arg_303_1.actors_["1019ui_story"]
			local var_306_1 = 0

			if var_306_1 < arg_303_1.time_ and arg_303_1.time_ <= var_306_1 + arg_306_0 and not isNil(var_306_0) and arg_303_1.var_.characterEffect1019ui_story == nil then
				arg_303_1.var_.characterEffect1019ui_story = var_306_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_306_2 = 0.2

			if var_306_1 <= arg_303_1.time_ and arg_303_1.time_ < var_306_1 + var_306_2 and not isNil(var_306_0) then
				local var_306_3 = (arg_303_1.time_ - var_306_1) / var_306_2

				if arg_303_1.var_.characterEffect1019ui_story and not isNil(var_306_0) then
					local var_306_4 = Mathf.Lerp(0, 0.5, var_306_3)

					arg_303_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_303_1.var_.characterEffect1019ui_story.fillRatio = var_306_4
				end
			end

			if arg_303_1.time_ >= var_306_1 + var_306_2 and arg_303_1.time_ < var_306_1 + var_306_2 + arg_306_0 and not isNil(var_306_0) and arg_303_1.var_.characterEffect1019ui_story then
				local var_306_5 = 0.5

				arg_303_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_303_1.var_.characterEffect1019ui_story.fillRatio = var_306_5
			end

			local var_306_6 = 0
			local var_306_7 = 0.425

			if var_306_6 < arg_303_1.time_ and arg_303_1.time_ <= var_306_6 + arg_306_0 then
				arg_303_1.talkMaxDuration = 0
				arg_303_1.dialogCg_.alpha = 1

				arg_303_1.dialog_:SetActive(true)
				SetActive(arg_303_1.leftNameGo_, false)

				arg_303_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_303_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_303_1:RecordName(arg_303_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_303_1.iconTrs_.gameObject, false)
				arg_303_1.callingController_:SetSelectedState("normal")

				local var_306_8 = arg_303_1:GetWordFromCfg(116021071)
				local var_306_9 = arg_303_1:FormatText(var_306_8.content)

				arg_303_1.text_.text = var_306_9

				LuaForUtil.ClearLinePrefixSymbol(arg_303_1.text_)

				local var_306_10 = 17
				local var_306_11 = utf8.len(var_306_9)
				local var_306_12 = var_306_10 <= 0 and var_306_7 or var_306_7 * (var_306_11 / var_306_10)

				if var_306_12 > 0 and var_306_7 < var_306_12 then
					arg_303_1.talkMaxDuration = var_306_12

					if var_306_12 + var_306_6 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_12 + var_306_6
					end
				end

				arg_303_1.text_.text = var_306_9
				arg_303_1.typewritter.percent = 0

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(false)
				arg_303_1:RecordContent(arg_303_1.text_.text)
			end

			local var_306_13 = math.max(var_306_7, arg_303_1.talkMaxDuration)

			if var_306_6 <= arg_303_1.time_ and arg_303_1.time_ < var_306_6 + var_306_13 then
				arg_303_1.typewritter.percent = (arg_303_1.time_ - var_306_6) / var_306_13

				arg_303_1.typewritter:SetDirty()
			end

			if arg_303_1.time_ >= var_306_6 + var_306_13 and arg_303_1.time_ < var_306_6 + var_306_13 + arg_306_0 then
				arg_303_1.typewritter.percent = 1

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(true)
			end
		end

		arg_303_1.nodeConfigList_ = {}

		arg_303_1:InitPlayNodeList()
	end,
	Play116021072 = function(arg_307_0, arg_307_1)
		arg_307_1.time_ = 0
		arg_307_1.frameCnt_ = 0
		arg_307_1.state_ = "playing"
		arg_307_1.curTalkId_ = 116021072
		arg_307_1.duration_ = 2.73

		local var_307_0 = {
			zh = 2.733,
			ja = 1.999999999999
		}
		local var_307_1 = manager.audio:GetLocalizationFlag()

		if var_307_0[var_307_1] ~= nil then
			arg_307_1.duration_ = var_307_0[var_307_1]
		end

		SetActive(arg_307_1.tipsGo_, false)

		function arg_307_1.onSingleLineFinish_()
			arg_307_1.onSingleLineUpdate_ = nil
			arg_307_1.onSingleLineFinish_ = nil
			arg_307_1.state_ = "waiting"
		end

		function arg_307_1.playNext_(arg_309_0)
			if arg_309_0 == 1 then
				arg_307_0:Play116021073(arg_307_1)
			end
		end

		function arg_307_1.onSingleLineUpdate_(arg_310_0)
			local var_310_0 = 0

			if var_310_0 < arg_307_1.time_ and arg_307_1.time_ <= var_310_0 + arg_310_0 then
				arg_307_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action1_1")
			end

			local var_310_1 = 0

			if var_310_1 < arg_307_1.time_ and arg_307_1.time_ <= var_310_1 + arg_310_0 then
				arg_307_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_310_2 = arg_307_1.actors_["1029ui_story"]
			local var_310_3 = 0

			if var_310_3 < arg_307_1.time_ and arg_307_1.time_ <= var_310_3 + arg_310_0 and not isNil(var_310_2) and arg_307_1.var_.characterEffect1029ui_story == nil then
				arg_307_1.var_.characterEffect1029ui_story = var_310_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_310_4 = 0.2

			if var_310_3 <= arg_307_1.time_ and arg_307_1.time_ < var_310_3 + var_310_4 and not isNil(var_310_2) then
				local var_310_5 = (arg_307_1.time_ - var_310_3) / var_310_4

				if arg_307_1.var_.characterEffect1029ui_story and not isNil(var_310_2) then
					arg_307_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_307_1.time_ >= var_310_3 + var_310_4 and arg_307_1.time_ < var_310_3 + var_310_4 + arg_310_0 and not isNil(var_310_2) and arg_307_1.var_.characterEffect1029ui_story then
				arg_307_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_310_6 = 0
			local var_310_7 = 0.125

			if var_310_6 < arg_307_1.time_ and arg_307_1.time_ <= var_310_6 + arg_310_0 then
				arg_307_1.talkMaxDuration = 0
				arg_307_1.dialogCg_.alpha = 1

				arg_307_1.dialog_:SetActive(true)
				SetActive(arg_307_1.leftNameGo_, true)

				local var_310_8 = arg_307_1:FormatText(StoryNameCfg[319].name)

				arg_307_1.leftNameTxt_.text = var_310_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_307_1.leftNameTxt_.transform)

				arg_307_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_307_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_307_1:RecordName(arg_307_1.leftNameTxt_.text)
				SetActive(arg_307_1.iconTrs_.gameObject, false)
				arg_307_1.callingController_:SetSelectedState("normal")

				local var_310_9 = arg_307_1:GetWordFromCfg(116021072)
				local var_310_10 = arg_307_1:FormatText(var_310_9.content)

				arg_307_1.text_.text = var_310_10

				LuaForUtil.ClearLinePrefixSymbol(arg_307_1.text_)

				local var_310_11 = 5
				local var_310_12 = utf8.len(var_310_10)
				local var_310_13 = var_310_11 <= 0 and var_310_7 or var_310_7 * (var_310_12 / var_310_11)

				if var_310_13 > 0 and var_310_7 < var_310_13 then
					arg_307_1.talkMaxDuration = var_310_13

					if var_310_13 + var_310_6 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_13 + var_310_6
					end
				end

				arg_307_1.text_.text = var_310_10
				arg_307_1.typewritter.percent = 0

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116021", "116021072", "story_v_out_116021.awb") ~= 0 then
					local var_310_14 = manager.audio:GetVoiceLength("story_v_out_116021", "116021072", "story_v_out_116021.awb") / 1000

					if var_310_14 + var_310_6 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_14 + var_310_6
					end

					if var_310_9.prefab_name ~= "" and arg_307_1.actors_[var_310_9.prefab_name] ~= nil then
						local var_310_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_307_1.actors_[var_310_9.prefab_name].transform, "story_v_out_116021", "116021072", "story_v_out_116021.awb")

						arg_307_1:RecordAudio("116021072", var_310_15)
						arg_307_1:RecordAudio("116021072", var_310_15)
					else
						arg_307_1:AudioAction("play", "voice", "story_v_out_116021", "116021072", "story_v_out_116021.awb")
					end

					arg_307_1:RecordHistoryTalkVoice("story_v_out_116021", "116021072", "story_v_out_116021.awb")
				end

				arg_307_1:RecordContent(arg_307_1.text_.text)
			end

			local var_310_16 = math.max(var_310_7, arg_307_1.talkMaxDuration)

			if var_310_6 <= arg_307_1.time_ and arg_307_1.time_ < var_310_6 + var_310_16 then
				arg_307_1.typewritter.percent = (arg_307_1.time_ - var_310_6) / var_310_16

				arg_307_1.typewritter:SetDirty()
			end

			if arg_307_1.time_ >= var_310_6 + var_310_16 and arg_307_1.time_ < var_310_6 + var_310_16 + arg_310_0 then
				arg_307_1.typewritter.percent = 1

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(true)
			end
		end

		arg_307_1.nodeConfigList_ = {}

		arg_307_1:InitPlayNodeList()
	end,
	Play116021073 = function(arg_311_0, arg_311_1)
		arg_311_1.time_ = 0
		arg_311_1.frameCnt_ = 0
		arg_311_1.state_ = "playing"
		arg_311_1.curTalkId_ = 116021073
		arg_311_1.duration_ = 5

		SetActive(arg_311_1.tipsGo_, false)

		function arg_311_1.onSingleLineFinish_()
			arg_311_1.onSingleLineUpdate_ = nil
			arg_311_1.onSingleLineFinish_ = nil
			arg_311_1.state_ = "waiting"
		end

		function arg_311_1.playNext_(arg_313_0)
			if arg_313_0 == 1 then
				arg_311_0:Play116021074(arg_311_1)
			end
		end

		function arg_311_1.onSingleLineUpdate_(arg_314_0)
			local var_314_0 = arg_311_1.actors_["1029ui_story"]
			local var_314_1 = 0

			if var_314_1 < arg_311_1.time_ and arg_311_1.time_ <= var_314_1 + arg_314_0 and not isNil(var_314_0) and arg_311_1.var_.characterEffect1029ui_story == nil then
				arg_311_1.var_.characterEffect1029ui_story = var_314_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_314_2 = 0.2

			if var_314_1 <= arg_311_1.time_ and arg_311_1.time_ < var_314_1 + var_314_2 and not isNil(var_314_0) then
				local var_314_3 = (arg_311_1.time_ - var_314_1) / var_314_2

				if arg_311_1.var_.characterEffect1029ui_story and not isNil(var_314_0) then
					local var_314_4 = Mathf.Lerp(0, 0.5, var_314_3)

					arg_311_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_311_1.var_.characterEffect1029ui_story.fillRatio = var_314_4
				end
			end

			if arg_311_1.time_ >= var_314_1 + var_314_2 and arg_311_1.time_ < var_314_1 + var_314_2 + arg_314_0 and not isNil(var_314_0) and arg_311_1.var_.characterEffect1029ui_story then
				local var_314_5 = 0.5

				arg_311_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_311_1.var_.characterEffect1029ui_story.fillRatio = var_314_5
			end

			local var_314_6 = 0
			local var_314_7 = 0.325

			if var_314_6 < arg_311_1.time_ and arg_311_1.time_ <= var_314_6 + arg_314_0 then
				arg_311_1.talkMaxDuration = 0
				arg_311_1.dialogCg_.alpha = 1

				arg_311_1.dialog_:SetActive(true)
				SetActive(arg_311_1.leftNameGo_, true)

				local var_314_8 = arg_311_1:FormatText(StoryNameCfg[7].name)

				arg_311_1.leftNameTxt_.text = var_314_8

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

				local var_314_9 = arg_311_1:GetWordFromCfg(116021073)
				local var_314_10 = arg_311_1:FormatText(var_314_9.content)

				arg_311_1.text_.text = var_314_10

				LuaForUtil.ClearLinePrefixSymbol(arg_311_1.text_)

				local var_314_11 = 13
				local var_314_12 = utf8.len(var_314_10)
				local var_314_13 = var_314_11 <= 0 and var_314_7 or var_314_7 * (var_314_12 / var_314_11)

				if var_314_13 > 0 and var_314_7 < var_314_13 then
					arg_311_1.talkMaxDuration = var_314_13

					if var_314_13 + var_314_6 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_13 + var_314_6
					end
				end

				arg_311_1.text_.text = var_314_10
				arg_311_1.typewritter.percent = 0

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(false)
				arg_311_1:RecordContent(arg_311_1.text_.text)
			end

			local var_314_14 = math.max(var_314_7, arg_311_1.talkMaxDuration)

			if var_314_6 <= arg_311_1.time_ and arg_311_1.time_ < var_314_6 + var_314_14 then
				arg_311_1.typewritter.percent = (arg_311_1.time_ - var_314_6) / var_314_14

				arg_311_1.typewritter:SetDirty()
			end

			if arg_311_1.time_ >= var_314_6 + var_314_14 and arg_311_1.time_ < var_314_6 + var_314_14 + arg_314_0 then
				arg_311_1.typewritter.percent = 1

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(true)
			end
		end

		arg_311_1.nodeConfigList_ = {}

		arg_311_1:InitPlayNodeList()
	end,
	Play116021074 = function(arg_315_0, arg_315_1)
		arg_315_1.time_ = 0
		arg_315_1.frameCnt_ = 0
		arg_315_1.state_ = "playing"
		arg_315_1.curTalkId_ = 116021074
		arg_315_1.duration_ = 4.2

		local var_315_0 = {
			zh = 3.966,
			ja = 4.2
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
				arg_315_0:Play116021075(arg_315_1)
			end
		end

		function arg_315_1.onSingleLineUpdate_(arg_318_0)
			local var_318_0 = 0

			if var_318_0 < arg_315_1.time_ and arg_315_1.time_ <= var_318_0 + arg_318_0 then
				arg_315_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_318_1 = arg_315_1.actors_["1019ui_story"]
			local var_318_2 = 0

			if var_318_2 < arg_315_1.time_ and arg_315_1.time_ <= var_318_2 + arg_318_0 and not isNil(var_318_1) and arg_315_1.var_.characterEffect1019ui_story == nil then
				arg_315_1.var_.characterEffect1019ui_story = var_318_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_318_3 = 0.2

			if var_318_2 <= arg_315_1.time_ and arg_315_1.time_ < var_318_2 + var_318_3 and not isNil(var_318_1) then
				local var_318_4 = (arg_315_1.time_ - var_318_2) / var_318_3

				if arg_315_1.var_.characterEffect1019ui_story and not isNil(var_318_1) then
					arg_315_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_315_1.time_ >= var_318_2 + var_318_3 and arg_315_1.time_ < var_318_2 + var_318_3 + arg_318_0 and not isNil(var_318_1) and arg_315_1.var_.characterEffect1019ui_story then
				arg_315_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_318_5 = 0
			local var_318_6 = 0.55

			if var_318_5 < arg_315_1.time_ and arg_315_1.time_ <= var_318_5 + arg_318_0 then
				arg_315_1.talkMaxDuration = 0
				arg_315_1.dialogCg_.alpha = 1

				arg_315_1.dialog_:SetActive(true)
				SetActive(arg_315_1.leftNameGo_, true)

				local var_318_7 = arg_315_1:FormatText(StoryNameCfg[13].name)

				arg_315_1.leftNameTxt_.text = var_318_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_315_1.leftNameTxt_.transform)

				arg_315_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_315_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_315_1:RecordName(arg_315_1.leftNameTxt_.text)
				SetActive(arg_315_1.iconTrs_.gameObject, false)
				arg_315_1.callingController_:SetSelectedState("normal")

				local var_318_8 = arg_315_1:GetWordFromCfg(116021074)
				local var_318_9 = arg_315_1:FormatText(var_318_8.content)

				arg_315_1.text_.text = var_318_9

				LuaForUtil.ClearLinePrefixSymbol(arg_315_1.text_)

				local var_318_10 = 30
				local var_318_11 = utf8.len(var_318_9)
				local var_318_12 = var_318_10 <= 0 and var_318_6 or var_318_6 * (var_318_11 / var_318_10)

				if var_318_12 > 0 and var_318_6 < var_318_12 then
					arg_315_1.talkMaxDuration = var_318_12

					if var_318_12 + var_318_5 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_12 + var_318_5
					end
				end

				arg_315_1.text_.text = var_318_9
				arg_315_1.typewritter.percent = 0

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116021", "116021074", "story_v_out_116021.awb") ~= 0 then
					local var_318_13 = manager.audio:GetVoiceLength("story_v_out_116021", "116021074", "story_v_out_116021.awb") / 1000

					if var_318_13 + var_318_5 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_13 + var_318_5
					end

					if var_318_8.prefab_name ~= "" and arg_315_1.actors_[var_318_8.prefab_name] ~= nil then
						local var_318_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_315_1.actors_[var_318_8.prefab_name].transform, "story_v_out_116021", "116021074", "story_v_out_116021.awb")

						arg_315_1:RecordAudio("116021074", var_318_14)
						arg_315_1:RecordAudio("116021074", var_318_14)
					else
						arg_315_1:AudioAction("play", "voice", "story_v_out_116021", "116021074", "story_v_out_116021.awb")
					end

					arg_315_1:RecordHistoryTalkVoice("story_v_out_116021", "116021074", "story_v_out_116021.awb")
				end

				arg_315_1:RecordContent(arg_315_1.text_.text)
			end

			local var_318_15 = math.max(var_318_6, arg_315_1.talkMaxDuration)

			if var_318_5 <= arg_315_1.time_ and arg_315_1.time_ < var_318_5 + var_318_15 then
				arg_315_1.typewritter.percent = (arg_315_1.time_ - var_318_5) / var_318_15

				arg_315_1.typewritter:SetDirty()
			end

			if arg_315_1.time_ >= var_318_5 + var_318_15 and arg_315_1.time_ < var_318_5 + var_318_15 + arg_318_0 then
				arg_315_1.typewritter.percent = 1

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(true)
			end
		end

		arg_315_1.nodeConfigList_ = {}

		arg_315_1:InitPlayNodeList()
	end,
	Play116021075 = function(arg_319_0, arg_319_1)
		arg_319_1.time_ = 0
		arg_319_1.frameCnt_ = 0
		arg_319_1.state_ = "playing"
		arg_319_1.curTalkId_ = 116021075
		arg_319_1.duration_ = 4.3

		local var_319_0 = {
			zh = 4.3,
			ja = 4.266
		}
		local var_319_1 = manager.audio:GetLocalizationFlag()

		if var_319_0[var_319_1] ~= nil then
			arg_319_1.duration_ = var_319_0[var_319_1]
		end

		SetActive(arg_319_1.tipsGo_, false)

		function arg_319_1.onSingleLineFinish_()
			arg_319_1.onSingleLineUpdate_ = nil
			arg_319_1.onSingleLineFinish_ = nil
			arg_319_1.state_ = "waiting"
		end

		function arg_319_1.playNext_(arg_321_0)
			if arg_321_0 == 1 then
				arg_319_0:Play116021076(arg_319_1)
			end
		end

		function arg_319_1.onSingleLineUpdate_(arg_322_0)
			local var_322_0 = 0

			if var_322_0 < arg_319_1.time_ and arg_319_1.time_ <= var_322_0 + arg_322_0 then
				arg_319_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action4_1")
			end

			local var_322_1 = 0

			if var_322_1 < arg_319_1.time_ and arg_319_1.time_ <= var_322_1 + arg_322_0 then
				arg_319_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_322_2 = arg_319_1.actors_["1029ui_story"]
			local var_322_3 = 0

			if var_322_3 < arg_319_1.time_ and arg_319_1.time_ <= var_322_3 + arg_322_0 and not isNil(var_322_2) and arg_319_1.var_.characterEffect1029ui_story == nil then
				arg_319_1.var_.characterEffect1029ui_story = var_322_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_322_4 = 0.2

			if var_322_3 <= arg_319_1.time_ and arg_319_1.time_ < var_322_3 + var_322_4 and not isNil(var_322_2) then
				local var_322_5 = (arg_319_1.time_ - var_322_3) / var_322_4

				if arg_319_1.var_.characterEffect1029ui_story and not isNil(var_322_2) then
					arg_319_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_319_1.time_ >= var_322_3 + var_322_4 and arg_319_1.time_ < var_322_3 + var_322_4 + arg_322_0 and not isNil(var_322_2) and arg_319_1.var_.characterEffect1029ui_story then
				arg_319_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_322_6 = arg_319_1.actors_["1019ui_story"]
			local var_322_7 = 0

			if var_322_7 < arg_319_1.time_ and arg_319_1.time_ <= var_322_7 + arg_322_0 and not isNil(var_322_6) and arg_319_1.var_.characterEffect1019ui_story == nil then
				arg_319_1.var_.characterEffect1019ui_story = var_322_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_322_8 = 0.2

			if var_322_7 <= arg_319_1.time_ and arg_319_1.time_ < var_322_7 + var_322_8 and not isNil(var_322_6) then
				local var_322_9 = (arg_319_1.time_ - var_322_7) / var_322_8

				if arg_319_1.var_.characterEffect1019ui_story and not isNil(var_322_6) then
					local var_322_10 = Mathf.Lerp(0, 0.5, var_322_9)

					arg_319_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_319_1.var_.characterEffect1019ui_story.fillRatio = var_322_10
				end
			end

			if arg_319_1.time_ >= var_322_7 + var_322_8 and arg_319_1.time_ < var_322_7 + var_322_8 + arg_322_0 and not isNil(var_322_6) and arg_319_1.var_.characterEffect1019ui_story then
				local var_322_11 = 0.5

				arg_319_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_319_1.var_.characterEffect1019ui_story.fillRatio = var_322_11
			end

			local var_322_12 = 0
			local var_322_13 = 0.225

			if var_322_12 < arg_319_1.time_ and arg_319_1.time_ <= var_322_12 + arg_322_0 then
				arg_319_1.talkMaxDuration = 0
				arg_319_1.dialogCg_.alpha = 1

				arg_319_1.dialog_:SetActive(true)
				SetActive(arg_319_1.leftNameGo_, true)

				local var_322_14 = arg_319_1:FormatText(StoryNameCfg[319].name)

				arg_319_1.leftNameTxt_.text = var_322_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_319_1.leftNameTxt_.transform)

				arg_319_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_319_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_319_1:RecordName(arg_319_1.leftNameTxt_.text)
				SetActive(arg_319_1.iconTrs_.gameObject, false)
				arg_319_1.callingController_:SetSelectedState("normal")

				local var_322_15 = arg_319_1:GetWordFromCfg(116021075)
				local var_322_16 = arg_319_1:FormatText(var_322_15.content)

				arg_319_1.text_.text = var_322_16

				LuaForUtil.ClearLinePrefixSymbol(arg_319_1.text_)

				local var_322_17 = 9
				local var_322_18 = utf8.len(var_322_16)
				local var_322_19 = var_322_17 <= 0 and var_322_13 or var_322_13 * (var_322_18 / var_322_17)

				if var_322_19 > 0 and var_322_13 < var_322_19 then
					arg_319_1.talkMaxDuration = var_322_19

					if var_322_19 + var_322_12 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_19 + var_322_12
					end
				end

				arg_319_1.text_.text = var_322_16
				arg_319_1.typewritter.percent = 0

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116021", "116021075", "story_v_out_116021.awb") ~= 0 then
					local var_322_20 = manager.audio:GetVoiceLength("story_v_out_116021", "116021075", "story_v_out_116021.awb") / 1000

					if var_322_20 + var_322_12 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_20 + var_322_12
					end

					if var_322_15.prefab_name ~= "" and arg_319_1.actors_[var_322_15.prefab_name] ~= nil then
						local var_322_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_319_1.actors_[var_322_15.prefab_name].transform, "story_v_out_116021", "116021075", "story_v_out_116021.awb")

						arg_319_1:RecordAudio("116021075", var_322_21)
						arg_319_1:RecordAudio("116021075", var_322_21)
					else
						arg_319_1:AudioAction("play", "voice", "story_v_out_116021", "116021075", "story_v_out_116021.awb")
					end

					arg_319_1:RecordHistoryTalkVoice("story_v_out_116021", "116021075", "story_v_out_116021.awb")
				end

				arg_319_1:RecordContent(arg_319_1.text_.text)
			end

			local var_322_22 = math.max(var_322_13, arg_319_1.talkMaxDuration)

			if var_322_12 <= arg_319_1.time_ and arg_319_1.time_ < var_322_12 + var_322_22 then
				arg_319_1.typewritter.percent = (arg_319_1.time_ - var_322_12) / var_322_22

				arg_319_1.typewritter:SetDirty()
			end

			if arg_319_1.time_ >= var_322_12 + var_322_22 and arg_319_1.time_ < var_322_12 + var_322_22 + arg_322_0 then
				arg_319_1.typewritter.percent = 1

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(true)
			end
		end

		arg_319_1.nodeConfigList_ = {}

		arg_319_1:InitPlayNodeList()
	end,
	Play116021076 = function(arg_323_0, arg_323_1)
		arg_323_1.time_ = 0
		arg_323_1.frameCnt_ = 0
		arg_323_1.state_ = "playing"
		arg_323_1.curTalkId_ = 116021076
		arg_323_1.duration_ = 9.13

		local var_323_0 = {
			zh = 9.133,
			ja = 6.166
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
				arg_323_0:Play116021077(arg_323_1)
			end
		end

		function arg_323_1.onSingleLineUpdate_(arg_326_0)
			local var_326_0 = "1028ui_story"

			if arg_323_1.actors_[var_326_0] == nil then
				local var_326_1 = Asset.Load("Char/" .. "1028ui_story")

				if not isNil(var_326_1) then
					local var_326_2 = Object.Instantiate(Asset.Load("Char/" .. "1028ui_story"), arg_323_1.stage_.transform)

					var_326_2.name = var_326_0
					var_326_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_323_1.actors_[var_326_0] = var_326_2

					local var_326_3 = var_326_2:GetComponentInChildren(typeof(CharacterEffect))

					var_326_3.enabled = true

					local var_326_4 = GameObjectTools.GetOrAddComponent(var_326_2, typeof(DynamicBoneHelper))

					if var_326_4 then
						var_326_4:EnableDynamicBone(false)
					end

					arg_323_1:ShowWeapon(var_326_3.transform, false)

					arg_323_1.var_[var_326_0 .. "Animator"] = var_326_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_323_1.var_[var_326_0 .. "Animator"].applyRootMotion = true
					arg_323_1.var_[var_326_0 .. "LipSync"] = var_326_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_326_5 = arg_323_1.actors_["1028ui_story"].transform
			local var_326_6 = 0

			if var_326_6 < arg_323_1.time_ and arg_323_1.time_ <= var_326_6 + arg_326_0 then
				arg_323_1.var_.moveOldPos1028ui_story = var_326_5.localPosition
			end

			local var_326_7 = 0.001

			if var_326_6 <= arg_323_1.time_ and arg_323_1.time_ < var_326_6 + var_326_7 then
				local var_326_8 = (arg_323_1.time_ - var_326_6) / var_326_7
				local var_326_9 = Vector3.New(-0.7, -0.9, -5.9)

				var_326_5.localPosition = Vector3.Lerp(arg_323_1.var_.moveOldPos1028ui_story, var_326_9, var_326_8)

				local var_326_10 = manager.ui.mainCamera.transform.position - var_326_5.position

				var_326_5.forward = Vector3.New(var_326_10.x, var_326_10.y, var_326_10.z)

				local var_326_11 = var_326_5.localEulerAngles

				var_326_11.z = 0
				var_326_11.x = 0
				var_326_5.localEulerAngles = var_326_11
			end

			if arg_323_1.time_ >= var_326_6 + var_326_7 and arg_323_1.time_ < var_326_6 + var_326_7 + arg_326_0 then
				var_326_5.localPosition = Vector3.New(-0.7, -0.9, -5.9)

				local var_326_12 = manager.ui.mainCamera.transform.position - var_326_5.position

				var_326_5.forward = Vector3.New(var_326_12.x, var_326_12.y, var_326_12.z)

				local var_326_13 = var_326_5.localEulerAngles

				var_326_13.z = 0
				var_326_13.x = 0
				var_326_5.localEulerAngles = var_326_13
			end

			local var_326_14 = arg_323_1.actors_["1019ui_story"].transform
			local var_326_15 = 0

			if var_326_15 < arg_323_1.time_ and arg_323_1.time_ <= var_326_15 + arg_326_0 then
				arg_323_1.var_.moveOldPos1019ui_story = var_326_14.localPosition
			end

			local var_326_16 = 0.001

			if var_326_15 <= arg_323_1.time_ and arg_323_1.time_ < var_326_15 + var_326_16 then
				local var_326_17 = (arg_323_1.time_ - var_326_15) / var_326_16
				local var_326_18 = Vector3.New(0, 100, 0)

				var_326_14.localPosition = Vector3.Lerp(arg_323_1.var_.moveOldPos1019ui_story, var_326_18, var_326_17)

				local var_326_19 = manager.ui.mainCamera.transform.position - var_326_14.position

				var_326_14.forward = Vector3.New(var_326_19.x, var_326_19.y, var_326_19.z)

				local var_326_20 = var_326_14.localEulerAngles

				var_326_20.z = 0
				var_326_20.x = 0
				var_326_14.localEulerAngles = var_326_20
			end

			if arg_323_1.time_ >= var_326_15 + var_326_16 and arg_323_1.time_ < var_326_15 + var_326_16 + arg_326_0 then
				var_326_14.localPosition = Vector3.New(0, 100, 0)

				local var_326_21 = manager.ui.mainCamera.transform.position - var_326_14.position

				var_326_14.forward = Vector3.New(var_326_21.x, var_326_21.y, var_326_21.z)

				local var_326_22 = var_326_14.localEulerAngles

				var_326_22.z = 0
				var_326_22.x = 0
				var_326_14.localEulerAngles = var_326_22
			end

			local var_326_23 = 0

			if var_326_23 < arg_323_1.time_ and arg_323_1.time_ <= var_326_23 + arg_326_0 then
				arg_323_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/story1028/story1028action/1028action1_1")
			end

			local var_326_24 = 0

			if var_326_24 < arg_323_1.time_ and arg_323_1.time_ <= var_326_24 + arg_326_0 then
				arg_323_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1303cva")
			end

			local var_326_25 = arg_323_1.actors_["1028ui_story"]
			local var_326_26 = 0

			if var_326_26 < arg_323_1.time_ and arg_323_1.time_ <= var_326_26 + arg_326_0 and not isNil(var_326_25) and arg_323_1.var_.characterEffect1028ui_story == nil then
				arg_323_1.var_.characterEffect1028ui_story = var_326_25:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_326_27 = 0.2

			if var_326_26 <= arg_323_1.time_ and arg_323_1.time_ < var_326_26 + var_326_27 and not isNil(var_326_25) then
				local var_326_28 = (arg_323_1.time_ - var_326_26) / var_326_27

				if arg_323_1.var_.characterEffect1028ui_story and not isNil(var_326_25) then
					arg_323_1.var_.characterEffect1028ui_story.fillFlat = false
				end
			end

			if arg_323_1.time_ >= var_326_26 + var_326_27 and arg_323_1.time_ < var_326_26 + var_326_27 + arg_326_0 and not isNil(var_326_25) and arg_323_1.var_.characterEffect1028ui_story then
				arg_323_1.var_.characterEffect1028ui_story.fillFlat = false
			end

			local var_326_29 = arg_323_1.actors_["1029ui_story"]
			local var_326_30 = 0

			if var_326_30 < arg_323_1.time_ and arg_323_1.time_ <= var_326_30 + arg_326_0 and not isNil(var_326_29) and arg_323_1.var_.characterEffect1029ui_story == nil then
				arg_323_1.var_.characterEffect1029ui_story = var_326_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_326_31 = 0.2

			if var_326_30 <= arg_323_1.time_ and arg_323_1.time_ < var_326_30 + var_326_31 and not isNil(var_326_29) then
				local var_326_32 = (arg_323_1.time_ - var_326_30) / var_326_31

				if arg_323_1.var_.characterEffect1029ui_story and not isNil(var_326_29) then
					local var_326_33 = Mathf.Lerp(0, 0.5, var_326_32)

					arg_323_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_323_1.var_.characterEffect1029ui_story.fillRatio = var_326_33
				end
			end

			if arg_323_1.time_ >= var_326_30 + var_326_31 and arg_323_1.time_ < var_326_30 + var_326_31 + arg_326_0 and not isNil(var_326_29) and arg_323_1.var_.characterEffect1029ui_story then
				local var_326_34 = 0.5

				arg_323_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_323_1.var_.characterEffect1029ui_story.fillRatio = var_326_34
			end

			local var_326_35 = 0
			local var_326_36 = 1.2

			if var_326_35 < arg_323_1.time_ and arg_323_1.time_ <= var_326_35 + arg_326_0 then
				arg_323_1.talkMaxDuration = 0
				arg_323_1.dialogCg_.alpha = 1

				arg_323_1.dialog_:SetActive(true)
				SetActive(arg_323_1.leftNameGo_, true)

				local var_326_37 = arg_323_1:FormatText(StoryNameCfg[327].name)

				arg_323_1.leftNameTxt_.text = var_326_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_323_1.leftNameTxt_.transform)

				arg_323_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_323_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_323_1:RecordName(arg_323_1.leftNameTxt_.text)
				SetActive(arg_323_1.iconTrs_.gameObject, false)
				arg_323_1.callingController_:SetSelectedState("normal")

				local var_326_38 = arg_323_1:GetWordFromCfg(116021076)
				local var_326_39 = arg_323_1:FormatText(var_326_38.content)

				arg_323_1.text_.text = var_326_39

				LuaForUtil.ClearLinePrefixSymbol(arg_323_1.text_)

				local var_326_40 = 48
				local var_326_41 = utf8.len(var_326_39)
				local var_326_42 = var_326_40 <= 0 and var_326_36 or var_326_36 * (var_326_41 / var_326_40)

				if var_326_42 > 0 and var_326_36 < var_326_42 then
					arg_323_1.talkMaxDuration = var_326_42

					if var_326_42 + var_326_35 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_42 + var_326_35
					end
				end

				arg_323_1.text_.text = var_326_39
				arg_323_1.typewritter.percent = 0

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116021", "116021076", "story_v_out_116021.awb") ~= 0 then
					local var_326_43 = manager.audio:GetVoiceLength("story_v_out_116021", "116021076", "story_v_out_116021.awb") / 1000

					if var_326_43 + var_326_35 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_43 + var_326_35
					end

					if var_326_38.prefab_name ~= "" and arg_323_1.actors_[var_326_38.prefab_name] ~= nil then
						local var_326_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_323_1.actors_[var_326_38.prefab_name].transform, "story_v_out_116021", "116021076", "story_v_out_116021.awb")

						arg_323_1:RecordAudio("116021076", var_326_44)
						arg_323_1:RecordAudio("116021076", var_326_44)
					else
						arg_323_1:AudioAction("play", "voice", "story_v_out_116021", "116021076", "story_v_out_116021.awb")
					end

					arg_323_1:RecordHistoryTalkVoice("story_v_out_116021", "116021076", "story_v_out_116021.awb")
				end

				arg_323_1:RecordContent(arg_323_1.text_.text)
			end

			local var_326_45 = math.max(var_326_36, arg_323_1.talkMaxDuration)

			if var_326_35 <= arg_323_1.time_ and arg_323_1.time_ < var_326_35 + var_326_45 then
				arg_323_1.typewritter.percent = (arg_323_1.time_ - var_326_35) / var_326_45

				arg_323_1.typewritter:SetDirty()
			end

			if arg_323_1.time_ >= var_326_35 + var_326_45 and arg_323_1.time_ < var_326_35 + var_326_45 + arg_326_0 then
				arg_323_1.typewritter.percent = 1

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(true)
			end
		end

		arg_323_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_323_1:InitPlayNodeList()
	end,
	Play116021077 = function(arg_327_0, arg_327_1)
		arg_327_1.time_ = 0
		arg_327_1.frameCnt_ = 0
		arg_327_1.state_ = "playing"
		arg_327_1.curTalkId_ = 116021077
		arg_327_1.duration_ = 5.3

		local var_327_0 = {
			zh = 3.466,
			ja = 5.3
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
				arg_327_0:Play116021078(arg_327_1)
			end
		end

		function arg_327_1.onSingleLineUpdate_(arg_330_0)
			local var_330_0 = 0

			if var_330_0 < arg_327_1.time_ and arg_327_1.time_ <= var_330_0 + arg_330_0 then
				arg_327_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action4_2")
			end

			local var_330_1 = 0

			if var_330_1 < arg_327_1.time_ and arg_327_1.time_ <= var_330_1 + arg_330_0 then
				arg_327_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_330_2 = arg_327_1.actors_["1029ui_story"]
			local var_330_3 = 0

			if var_330_3 < arg_327_1.time_ and arg_327_1.time_ <= var_330_3 + arg_330_0 and not isNil(var_330_2) and arg_327_1.var_.characterEffect1029ui_story == nil then
				arg_327_1.var_.characterEffect1029ui_story = var_330_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_330_4 = 0.2

			if var_330_3 <= arg_327_1.time_ and arg_327_1.time_ < var_330_3 + var_330_4 and not isNil(var_330_2) then
				local var_330_5 = (arg_327_1.time_ - var_330_3) / var_330_4

				if arg_327_1.var_.characterEffect1029ui_story and not isNil(var_330_2) then
					arg_327_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_327_1.time_ >= var_330_3 + var_330_4 and arg_327_1.time_ < var_330_3 + var_330_4 + arg_330_0 and not isNil(var_330_2) and arg_327_1.var_.characterEffect1029ui_story then
				arg_327_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_330_6 = arg_327_1.actors_["1028ui_story"]
			local var_330_7 = 0

			if var_330_7 < arg_327_1.time_ and arg_327_1.time_ <= var_330_7 + arg_330_0 and not isNil(var_330_6) and arg_327_1.var_.characterEffect1028ui_story == nil then
				arg_327_1.var_.characterEffect1028ui_story = var_330_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_330_8 = 0.2

			if var_330_7 <= arg_327_1.time_ and arg_327_1.time_ < var_330_7 + var_330_8 and not isNil(var_330_6) then
				local var_330_9 = (arg_327_1.time_ - var_330_7) / var_330_8

				if arg_327_1.var_.characterEffect1028ui_story and not isNil(var_330_6) then
					local var_330_10 = Mathf.Lerp(0, 0.5, var_330_9)

					arg_327_1.var_.characterEffect1028ui_story.fillFlat = true
					arg_327_1.var_.characterEffect1028ui_story.fillRatio = var_330_10
				end
			end

			if arg_327_1.time_ >= var_330_7 + var_330_8 and arg_327_1.time_ < var_330_7 + var_330_8 + arg_330_0 and not isNil(var_330_6) and arg_327_1.var_.characterEffect1028ui_story then
				local var_330_11 = 0.5

				arg_327_1.var_.characterEffect1028ui_story.fillFlat = true
				arg_327_1.var_.characterEffect1028ui_story.fillRatio = var_330_11
			end

			local var_330_12 = 0
			local var_330_13 = 0.3

			if var_330_12 < arg_327_1.time_ and arg_327_1.time_ <= var_330_12 + arg_330_0 then
				arg_327_1.talkMaxDuration = 0
				arg_327_1.dialogCg_.alpha = 1

				arg_327_1.dialog_:SetActive(true)
				SetActive(arg_327_1.leftNameGo_, true)

				local var_330_14 = arg_327_1:FormatText(StoryNameCfg[319].name)

				arg_327_1.leftNameTxt_.text = var_330_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_327_1.leftNameTxt_.transform)

				arg_327_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_327_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_327_1:RecordName(arg_327_1.leftNameTxt_.text)
				SetActive(arg_327_1.iconTrs_.gameObject, false)
				arg_327_1.callingController_:SetSelectedState("normal")

				local var_330_15 = arg_327_1:GetWordFromCfg(116021077)
				local var_330_16 = arg_327_1:FormatText(var_330_15.content)

				arg_327_1.text_.text = var_330_16

				LuaForUtil.ClearLinePrefixSymbol(arg_327_1.text_)

				local var_330_17 = 12
				local var_330_18 = utf8.len(var_330_16)
				local var_330_19 = var_330_17 <= 0 and var_330_13 or var_330_13 * (var_330_18 / var_330_17)

				if var_330_19 > 0 and var_330_13 < var_330_19 then
					arg_327_1.talkMaxDuration = var_330_19

					if var_330_19 + var_330_12 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_19 + var_330_12
					end
				end

				arg_327_1.text_.text = var_330_16
				arg_327_1.typewritter.percent = 0

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116021", "116021077", "story_v_out_116021.awb") ~= 0 then
					local var_330_20 = manager.audio:GetVoiceLength("story_v_out_116021", "116021077", "story_v_out_116021.awb") / 1000

					if var_330_20 + var_330_12 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_20 + var_330_12
					end

					if var_330_15.prefab_name ~= "" and arg_327_1.actors_[var_330_15.prefab_name] ~= nil then
						local var_330_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_327_1.actors_[var_330_15.prefab_name].transform, "story_v_out_116021", "116021077", "story_v_out_116021.awb")

						arg_327_1:RecordAudio("116021077", var_330_21)
						arg_327_1:RecordAudio("116021077", var_330_21)
					else
						arg_327_1:AudioAction("play", "voice", "story_v_out_116021", "116021077", "story_v_out_116021.awb")
					end

					arg_327_1:RecordHistoryTalkVoice("story_v_out_116021", "116021077", "story_v_out_116021.awb")
				end

				arg_327_1:RecordContent(arg_327_1.text_.text)
			end

			local var_330_22 = math.max(var_330_13, arg_327_1.talkMaxDuration)

			if var_330_12 <= arg_327_1.time_ and arg_327_1.time_ < var_330_12 + var_330_22 then
				arg_327_1.typewritter.percent = (arg_327_1.time_ - var_330_12) / var_330_22

				arg_327_1.typewritter:SetDirty()
			end

			if arg_327_1.time_ >= var_330_12 + var_330_22 and arg_327_1.time_ < var_330_12 + var_330_22 + arg_330_0 then
				arg_327_1.typewritter.percent = 1

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(true)
			end
		end

		arg_327_1.nodeConfigList_ = {}

		arg_327_1:InitPlayNodeList()
	end,
	Play116021078 = function(arg_331_0, arg_331_1)
		arg_331_1.time_ = 0
		arg_331_1.frameCnt_ = 0
		arg_331_1.state_ = "playing"
		arg_331_1.curTalkId_ = 116021078
		arg_331_1.duration_ = 5.27

		local var_331_0 = {
			zh = 5.266,
			ja = 3.633
		}
		local var_331_1 = manager.audio:GetLocalizationFlag()

		if var_331_0[var_331_1] ~= nil then
			arg_331_1.duration_ = var_331_0[var_331_1]
		end

		SetActive(arg_331_1.tipsGo_, false)

		function arg_331_1.onSingleLineFinish_()
			arg_331_1.onSingleLineUpdate_ = nil
			arg_331_1.onSingleLineFinish_ = nil
			arg_331_1.state_ = "waiting"
		end

		function arg_331_1.playNext_(arg_333_0)
			if arg_333_0 == 1 then
				arg_331_0:Play116021079(arg_331_1)
			end
		end

		function arg_331_1.onSingleLineUpdate_(arg_334_0)
			local var_334_0 = arg_331_1.actors_["1029ui_story"]
			local var_334_1 = 0

			if var_334_1 < arg_331_1.time_ and arg_331_1.time_ <= var_334_1 + arg_334_0 and not isNil(var_334_0) and arg_331_1.var_.characterEffect1029ui_story == nil then
				arg_331_1.var_.characterEffect1029ui_story = var_334_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_334_2 = 0.2

			if var_334_1 <= arg_331_1.time_ and arg_331_1.time_ < var_334_1 + var_334_2 and not isNil(var_334_0) then
				local var_334_3 = (arg_331_1.time_ - var_334_1) / var_334_2

				if arg_331_1.var_.characterEffect1029ui_story and not isNil(var_334_0) then
					local var_334_4 = Mathf.Lerp(0, 0.5, var_334_3)

					arg_331_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_331_1.var_.characterEffect1029ui_story.fillRatio = var_334_4
				end
			end

			if arg_331_1.time_ >= var_334_1 + var_334_2 and arg_331_1.time_ < var_334_1 + var_334_2 + arg_334_0 and not isNil(var_334_0) and arg_331_1.var_.characterEffect1029ui_story then
				local var_334_5 = 0.5

				arg_331_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_331_1.var_.characterEffect1029ui_story.fillRatio = var_334_5
			end

			local var_334_6 = 0
			local var_334_7 = 0.6

			if var_334_6 < arg_331_1.time_ and arg_331_1.time_ <= var_334_6 + arg_334_0 then
				arg_331_1.talkMaxDuration = 0
				arg_331_1.dialogCg_.alpha = 1

				arg_331_1.dialog_:SetActive(true)
				SetActive(arg_331_1.leftNameGo_, true)

				local var_334_8 = arg_331_1:FormatText(StoryNameCfg[13].name)

				arg_331_1.leftNameTxt_.text = var_334_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_331_1.leftNameTxt_.transform)

				arg_331_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_331_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_331_1:RecordName(arg_331_1.leftNameTxt_.text)
				SetActive(arg_331_1.iconTrs_.gameObject, true)
				arg_331_1.iconController_:SetSelectedState("hero")

				arg_331_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019")

				arg_331_1.callingController_:SetSelectedState("normal")

				arg_331_1.keyicon_.color = Color.New(1, 1, 1)
				arg_331_1.icon_.color = Color.New(1, 1, 1)

				local var_334_9 = arg_331_1:GetWordFromCfg(116021078)
				local var_334_10 = arg_331_1:FormatText(var_334_9.content)

				arg_331_1.text_.text = var_334_10

				LuaForUtil.ClearLinePrefixSymbol(arg_331_1.text_)

				local var_334_11 = 24
				local var_334_12 = utf8.len(var_334_10)
				local var_334_13 = var_334_11 <= 0 and var_334_7 or var_334_7 * (var_334_12 / var_334_11)

				if var_334_13 > 0 and var_334_7 < var_334_13 then
					arg_331_1.talkMaxDuration = var_334_13

					if var_334_13 + var_334_6 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_13 + var_334_6
					end
				end

				arg_331_1.text_.text = var_334_10
				arg_331_1.typewritter.percent = 0

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116021", "116021078", "story_v_out_116021.awb") ~= 0 then
					local var_334_14 = manager.audio:GetVoiceLength("story_v_out_116021", "116021078", "story_v_out_116021.awb") / 1000

					if var_334_14 + var_334_6 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_14 + var_334_6
					end

					if var_334_9.prefab_name ~= "" and arg_331_1.actors_[var_334_9.prefab_name] ~= nil then
						local var_334_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_331_1.actors_[var_334_9.prefab_name].transform, "story_v_out_116021", "116021078", "story_v_out_116021.awb")

						arg_331_1:RecordAudio("116021078", var_334_15)
						arg_331_1:RecordAudio("116021078", var_334_15)
					else
						arg_331_1:AudioAction("play", "voice", "story_v_out_116021", "116021078", "story_v_out_116021.awb")
					end

					arg_331_1:RecordHistoryTalkVoice("story_v_out_116021", "116021078", "story_v_out_116021.awb")
				end

				arg_331_1:RecordContent(arg_331_1.text_.text)
			end

			local var_334_16 = math.max(var_334_7, arg_331_1.talkMaxDuration)

			if var_334_6 <= arg_331_1.time_ and arg_331_1.time_ < var_334_6 + var_334_16 then
				arg_331_1.typewritter.percent = (arg_331_1.time_ - var_334_6) / var_334_16

				arg_331_1.typewritter:SetDirty()
			end

			if arg_331_1.time_ >= var_334_6 + var_334_16 and arg_331_1.time_ < var_334_6 + var_334_16 + arg_334_0 then
				arg_331_1.typewritter.percent = 1

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(true)
			end
		end

		arg_331_1.nodeConfigList_ = {}

		arg_331_1:InitPlayNodeList()
	end,
	Play116021079 = function(arg_335_0, arg_335_1)
		arg_335_1.time_ = 0
		arg_335_1.frameCnt_ = 0
		arg_335_1.state_ = "playing"
		arg_335_1.curTalkId_ = 116021079
		arg_335_1.duration_ = 12

		local var_335_0 = {
			zh = 10,
			ja = 12
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
				arg_335_0:Play116021080(arg_335_1)
			end
		end

		function arg_335_1.onSingleLineUpdate_(arg_338_0)
			local var_338_0 = 0
			local var_338_1 = 1.1

			if var_338_0 < arg_335_1.time_ and arg_335_1.time_ <= var_338_0 + arg_338_0 then
				arg_335_1.talkMaxDuration = 0
				arg_335_1.dialogCg_.alpha = 1

				arg_335_1.dialog_:SetActive(true)
				SetActive(arg_335_1.leftNameGo_, true)

				local var_338_2 = arg_335_1:FormatText(StoryNameCfg[13].name)

				arg_335_1.leftNameTxt_.text = var_338_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_335_1.leftNameTxt_.transform)

				arg_335_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_335_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_335_1:RecordName(arg_335_1.leftNameTxt_.text)
				SetActive(arg_335_1.iconTrs_.gameObject, true)
				arg_335_1.iconController_:SetSelectedState("hero")

				arg_335_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019")

				arg_335_1.callingController_:SetSelectedState("normal")

				arg_335_1.keyicon_.color = Color.New(1, 1, 1)
				arg_335_1.icon_.color = Color.New(1, 1, 1)

				local var_338_3 = arg_335_1:GetWordFromCfg(116021079)
				local var_338_4 = arg_335_1:FormatText(var_338_3.content)

				arg_335_1.text_.text = var_338_4

				LuaForUtil.ClearLinePrefixSymbol(arg_335_1.text_)

				local var_338_5 = 44
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

				if manager.audio:GetVoiceLength("story_v_out_116021", "116021079", "story_v_out_116021.awb") ~= 0 then
					local var_338_8 = manager.audio:GetVoiceLength("story_v_out_116021", "116021079", "story_v_out_116021.awb") / 1000

					if var_338_8 + var_338_0 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_8 + var_338_0
					end

					if var_338_3.prefab_name ~= "" and arg_335_1.actors_[var_338_3.prefab_name] ~= nil then
						local var_338_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_335_1.actors_[var_338_3.prefab_name].transform, "story_v_out_116021", "116021079", "story_v_out_116021.awb")

						arg_335_1:RecordAudio("116021079", var_338_9)
						arg_335_1:RecordAudio("116021079", var_338_9)
					else
						arg_335_1:AudioAction("play", "voice", "story_v_out_116021", "116021079", "story_v_out_116021.awb")
					end

					arg_335_1:RecordHistoryTalkVoice("story_v_out_116021", "116021079", "story_v_out_116021.awb")
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
	Play116021080 = function(arg_339_0, arg_339_1)
		arg_339_1.time_ = 0
		arg_339_1.frameCnt_ = 0
		arg_339_1.state_ = "playing"
		arg_339_1.curTalkId_ = 116021080
		arg_339_1.duration_ = 6.03

		local var_339_0 = {
			zh = 5.133,
			ja = 6.033
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
				arg_339_0:Play116021081(arg_339_1)
			end
		end

		function arg_339_1.onSingleLineUpdate_(arg_342_0)
			local var_342_0 = arg_339_1.actors_["1028ui_story"]
			local var_342_1 = 0

			if var_342_1 < arg_339_1.time_ and arg_339_1.time_ <= var_342_1 + arg_342_0 and not isNil(var_342_0) and arg_339_1.var_.characterEffect1028ui_story == nil then
				arg_339_1.var_.characterEffect1028ui_story = var_342_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_342_2 = 0.2

			if var_342_1 <= arg_339_1.time_ and arg_339_1.time_ < var_342_1 + var_342_2 and not isNil(var_342_0) then
				local var_342_3 = (arg_339_1.time_ - var_342_1) / var_342_2

				if arg_339_1.var_.characterEffect1028ui_story and not isNil(var_342_0) then
					arg_339_1.var_.characterEffect1028ui_story.fillFlat = false
				end
			end

			if arg_339_1.time_ >= var_342_1 + var_342_2 and arg_339_1.time_ < var_342_1 + var_342_2 + arg_342_0 and not isNil(var_342_0) and arg_339_1.var_.characterEffect1028ui_story then
				arg_339_1.var_.characterEffect1028ui_story.fillFlat = false
			end

			local var_342_4 = 0

			if var_342_4 < arg_339_1.time_ and arg_339_1.time_ <= var_342_4 + arg_342_0 then
				arg_339_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_342_5 = 0
			local var_342_6 = 0.6

			if var_342_5 < arg_339_1.time_ and arg_339_1.time_ <= var_342_5 + arg_342_0 then
				arg_339_1.talkMaxDuration = 0
				arg_339_1.dialogCg_.alpha = 1

				arg_339_1.dialog_:SetActive(true)
				SetActive(arg_339_1.leftNameGo_, true)

				local var_342_7 = arg_339_1:FormatText(StoryNameCfg[327].name)

				arg_339_1.leftNameTxt_.text = var_342_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_339_1.leftNameTxt_.transform)

				arg_339_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_339_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_339_1:RecordName(arg_339_1.leftNameTxt_.text)
				SetActive(arg_339_1.iconTrs_.gameObject, false)
				arg_339_1.callingController_:SetSelectedState("normal")

				local var_342_8 = arg_339_1:GetWordFromCfg(116021080)
				local var_342_9 = arg_339_1:FormatText(var_342_8.content)

				arg_339_1.text_.text = var_342_9

				LuaForUtil.ClearLinePrefixSymbol(arg_339_1.text_)

				local var_342_10 = 24
				local var_342_11 = utf8.len(var_342_9)
				local var_342_12 = var_342_10 <= 0 and var_342_6 or var_342_6 * (var_342_11 / var_342_10)

				if var_342_12 > 0 and var_342_6 < var_342_12 then
					arg_339_1.talkMaxDuration = var_342_12

					if var_342_12 + var_342_5 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_12 + var_342_5
					end
				end

				arg_339_1.text_.text = var_342_9
				arg_339_1.typewritter.percent = 0

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116021", "116021080", "story_v_out_116021.awb") ~= 0 then
					local var_342_13 = manager.audio:GetVoiceLength("story_v_out_116021", "116021080", "story_v_out_116021.awb") / 1000

					if var_342_13 + var_342_5 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_13 + var_342_5
					end

					if var_342_8.prefab_name ~= "" and arg_339_1.actors_[var_342_8.prefab_name] ~= nil then
						local var_342_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_339_1.actors_[var_342_8.prefab_name].transform, "story_v_out_116021", "116021080", "story_v_out_116021.awb")

						arg_339_1:RecordAudio("116021080", var_342_14)
						arg_339_1:RecordAudio("116021080", var_342_14)
					else
						arg_339_1:AudioAction("play", "voice", "story_v_out_116021", "116021080", "story_v_out_116021.awb")
					end

					arg_339_1:RecordHistoryTalkVoice("story_v_out_116021", "116021080", "story_v_out_116021.awb")
				end

				arg_339_1:RecordContent(arg_339_1.text_.text)
			end

			local var_342_15 = math.max(var_342_6, arg_339_1.talkMaxDuration)

			if var_342_5 <= arg_339_1.time_ and arg_339_1.time_ < var_342_5 + var_342_15 then
				arg_339_1.typewritter.percent = (arg_339_1.time_ - var_342_5) / var_342_15

				arg_339_1.typewritter:SetDirty()
			end

			if arg_339_1.time_ >= var_342_5 + var_342_15 and arg_339_1.time_ < var_342_5 + var_342_15 + arg_342_0 then
				arg_339_1.typewritter.percent = 1

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(true)
			end
		end

		arg_339_1.nodeConfigList_ = {}

		arg_339_1:InitPlayNodeList()
	end,
	Play116021081 = function(arg_343_0, arg_343_1)
		arg_343_1.time_ = 0
		arg_343_1.frameCnt_ = 0
		arg_343_1.state_ = "playing"
		arg_343_1.curTalkId_ = 116021081
		arg_343_1.duration_ = 4.83

		local var_343_0 = {
			zh = 1.566,
			ja = 4.833
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
				arg_343_0:Play116021082(arg_343_1)
			end
		end

		function arg_343_1.onSingleLineUpdate_(arg_346_0)
			local var_346_0 = arg_343_1.actors_["1028ui_story"]
			local var_346_1 = 0

			if var_346_1 < arg_343_1.time_ and arg_343_1.time_ <= var_346_1 + arg_346_0 and not isNil(var_346_0) and arg_343_1.var_.characterEffect1028ui_story == nil then
				arg_343_1.var_.characterEffect1028ui_story = var_346_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_346_2 = 0.2

			if var_346_1 <= arg_343_1.time_ and arg_343_1.time_ < var_346_1 + var_346_2 and not isNil(var_346_0) then
				local var_346_3 = (arg_343_1.time_ - var_346_1) / var_346_2

				if arg_343_1.var_.characterEffect1028ui_story and not isNil(var_346_0) then
					local var_346_4 = Mathf.Lerp(0, 0.5, var_346_3)

					arg_343_1.var_.characterEffect1028ui_story.fillFlat = true
					arg_343_1.var_.characterEffect1028ui_story.fillRatio = var_346_4
				end
			end

			if arg_343_1.time_ >= var_346_1 + var_346_2 and arg_343_1.time_ < var_346_1 + var_346_2 + arg_346_0 and not isNil(var_346_0) and arg_343_1.var_.characterEffect1028ui_story then
				local var_346_5 = 0.5

				arg_343_1.var_.characterEffect1028ui_story.fillFlat = true
				arg_343_1.var_.characterEffect1028ui_story.fillRatio = var_346_5
			end

			local var_346_6 = 0
			local var_346_7 = 0.15

			if var_346_6 < arg_343_1.time_ and arg_343_1.time_ <= var_346_6 + arg_346_0 then
				arg_343_1.talkMaxDuration = 0
				arg_343_1.dialogCg_.alpha = 1

				arg_343_1.dialog_:SetActive(true)
				SetActive(arg_343_1.leftNameGo_, true)

				local var_346_8 = arg_343_1:FormatText(StoryNameCfg[13].name)

				arg_343_1.leftNameTxt_.text = var_346_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_343_1.leftNameTxt_.transform)

				arg_343_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_343_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_343_1:RecordName(arg_343_1.leftNameTxt_.text)
				SetActive(arg_343_1.iconTrs_.gameObject, true)
				arg_343_1.iconController_:SetSelectedState("hero")

				arg_343_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019_split_6")

				arg_343_1.callingController_:SetSelectedState("normal")

				arg_343_1.keyicon_.color = Color.New(1, 1, 1)
				arg_343_1.icon_.color = Color.New(1, 1, 1)

				local var_346_9 = arg_343_1:GetWordFromCfg(116021081)
				local var_346_10 = arg_343_1:FormatText(var_346_9.content)

				arg_343_1.text_.text = var_346_10

				LuaForUtil.ClearLinePrefixSymbol(arg_343_1.text_)

				local var_346_11 = 6
				local var_346_12 = utf8.len(var_346_10)
				local var_346_13 = var_346_11 <= 0 and var_346_7 or var_346_7 * (var_346_12 / var_346_11)

				if var_346_13 > 0 and var_346_7 < var_346_13 then
					arg_343_1.talkMaxDuration = var_346_13

					if var_346_13 + var_346_6 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_13 + var_346_6
					end
				end

				arg_343_1.text_.text = var_346_10
				arg_343_1.typewritter.percent = 0

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116021", "116021081", "story_v_out_116021.awb") ~= 0 then
					local var_346_14 = manager.audio:GetVoiceLength("story_v_out_116021", "116021081", "story_v_out_116021.awb") / 1000

					if var_346_14 + var_346_6 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_14 + var_346_6
					end

					if var_346_9.prefab_name ~= "" and arg_343_1.actors_[var_346_9.prefab_name] ~= nil then
						local var_346_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_343_1.actors_[var_346_9.prefab_name].transform, "story_v_out_116021", "116021081", "story_v_out_116021.awb")

						arg_343_1:RecordAudio("116021081", var_346_15)
						arg_343_1:RecordAudio("116021081", var_346_15)
					else
						arg_343_1:AudioAction("play", "voice", "story_v_out_116021", "116021081", "story_v_out_116021.awb")
					end

					arg_343_1:RecordHistoryTalkVoice("story_v_out_116021", "116021081", "story_v_out_116021.awb")
				end

				arg_343_1:RecordContent(arg_343_1.text_.text)
			end

			local var_346_16 = math.max(var_346_7, arg_343_1.talkMaxDuration)

			if var_346_6 <= arg_343_1.time_ and arg_343_1.time_ < var_346_6 + var_346_16 then
				arg_343_1.typewritter.percent = (arg_343_1.time_ - var_346_6) / var_346_16

				arg_343_1.typewritter:SetDirty()
			end

			if arg_343_1.time_ >= var_346_6 + var_346_16 and arg_343_1.time_ < var_346_6 + var_346_16 + arg_346_0 then
				arg_343_1.typewritter.percent = 1

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(true)
			end
		end

		arg_343_1.nodeConfigList_ = {}

		arg_343_1:InitPlayNodeList()
	end,
	Play116021082 = function(arg_347_0, arg_347_1)
		arg_347_1.time_ = 0
		arg_347_1.frameCnt_ = 0
		arg_347_1.state_ = "playing"
		arg_347_1.curTalkId_ = 116021082
		arg_347_1.duration_ = 5.23

		local var_347_0 = {
			zh = 4.4,
			ja = 5.233
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
				arg_347_0:Play116021083(arg_347_1)
			end
		end

		function arg_347_1.onSingleLineUpdate_(arg_350_0)
			local var_350_0 = 0

			if var_350_0 < arg_347_1.time_ and arg_347_1.time_ <= var_350_0 + arg_350_0 then
				arg_347_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action7_1")
			end

			local var_350_1 = 0

			if var_350_1 < arg_347_1.time_ and arg_347_1.time_ <= var_350_1 + arg_350_0 then
				arg_347_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_350_2 = arg_347_1.actors_["1029ui_story"]
			local var_350_3 = 0

			if var_350_3 < arg_347_1.time_ and arg_347_1.time_ <= var_350_3 + arg_350_0 and not isNil(var_350_2) and arg_347_1.var_.characterEffect1029ui_story == nil then
				arg_347_1.var_.characterEffect1029ui_story = var_350_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_350_4 = 0.2

			if var_350_3 <= arg_347_1.time_ and arg_347_1.time_ < var_350_3 + var_350_4 and not isNil(var_350_2) then
				local var_350_5 = (arg_347_1.time_ - var_350_3) / var_350_4

				if arg_347_1.var_.characterEffect1029ui_story and not isNil(var_350_2) then
					arg_347_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_347_1.time_ >= var_350_3 + var_350_4 and arg_347_1.time_ < var_350_3 + var_350_4 + arg_350_0 and not isNil(var_350_2) and arg_347_1.var_.characterEffect1029ui_story then
				arg_347_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_350_6 = arg_347_1.actors_["1028ui_story"]
			local var_350_7 = 0

			if var_350_7 < arg_347_1.time_ and arg_347_1.time_ <= var_350_7 + arg_350_0 and not isNil(var_350_6) and arg_347_1.var_.characterEffect1028ui_story == nil then
				arg_347_1.var_.characterEffect1028ui_story = var_350_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_350_8 = 0.2

			if var_350_7 <= arg_347_1.time_ and arg_347_1.time_ < var_350_7 + var_350_8 and not isNil(var_350_6) then
				local var_350_9 = (arg_347_1.time_ - var_350_7) / var_350_8

				if arg_347_1.var_.characterEffect1028ui_story and not isNil(var_350_6) then
					local var_350_10 = Mathf.Lerp(0, 0.5, var_350_9)

					arg_347_1.var_.characterEffect1028ui_story.fillFlat = true
					arg_347_1.var_.characterEffect1028ui_story.fillRatio = var_350_10
				end
			end

			if arg_347_1.time_ >= var_350_7 + var_350_8 and arg_347_1.time_ < var_350_7 + var_350_8 + arg_350_0 and not isNil(var_350_6) and arg_347_1.var_.characterEffect1028ui_story then
				local var_350_11 = 0.5

				arg_347_1.var_.characterEffect1028ui_story.fillFlat = true
				arg_347_1.var_.characterEffect1028ui_story.fillRatio = var_350_11
			end

			local var_350_12 = 0
			local var_350_13 = 0.425

			if var_350_12 < arg_347_1.time_ and arg_347_1.time_ <= var_350_12 + arg_350_0 then
				arg_347_1.talkMaxDuration = 0
				arg_347_1.dialogCg_.alpha = 1

				arg_347_1.dialog_:SetActive(true)
				SetActive(arg_347_1.leftNameGo_, true)

				local var_350_14 = arg_347_1:FormatText(StoryNameCfg[319].name)

				arg_347_1.leftNameTxt_.text = var_350_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_347_1.leftNameTxt_.transform)

				arg_347_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_347_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_347_1:RecordName(arg_347_1.leftNameTxt_.text)
				SetActive(arg_347_1.iconTrs_.gameObject, false)
				arg_347_1.callingController_:SetSelectedState("normal")

				local var_350_15 = arg_347_1:GetWordFromCfg(116021082)
				local var_350_16 = arg_347_1:FormatText(var_350_15.content)

				arg_347_1.text_.text = var_350_16

				LuaForUtil.ClearLinePrefixSymbol(arg_347_1.text_)

				local var_350_17 = 17
				local var_350_18 = utf8.len(var_350_16)
				local var_350_19 = var_350_17 <= 0 and var_350_13 or var_350_13 * (var_350_18 / var_350_17)

				if var_350_19 > 0 and var_350_13 < var_350_19 then
					arg_347_1.talkMaxDuration = var_350_19

					if var_350_19 + var_350_12 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_19 + var_350_12
					end
				end

				arg_347_1.text_.text = var_350_16
				arg_347_1.typewritter.percent = 0

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116021", "116021082", "story_v_out_116021.awb") ~= 0 then
					local var_350_20 = manager.audio:GetVoiceLength("story_v_out_116021", "116021082", "story_v_out_116021.awb") / 1000

					if var_350_20 + var_350_12 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_20 + var_350_12
					end

					if var_350_15.prefab_name ~= "" and arg_347_1.actors_[var_350_15.prefab_name] ~= nil then
						local var_350_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_347_1.actors_[var_350_15.prefab_name].transform, "story_v_out_116021", "116021082", "story_v_out_116021.awb")

						arg_347_1:RecordAudio("116021082", var_350_21)
						arg_347_1:RecordAudio("116021082", var_350_21)
					else
						arg_347_1:AudioAction("play", "voice", "story_v_out_116021", "116021082", "story_v_out_116021.awb")
					end

					arg_347_1:RecordHistoryTalkVoice("story_v_out_116021", "116021082", "story_v_out_116021.awb")
				end

				arg_347_1:RecordContent(arg_347_1.text_.text)
			end

			local var_350_22 = math.max(var_350_13, arg_347_1.talkMaxDuration)

			if var_350_12 <= arg_347_1.time_ and arg_347_1.time_ < var_350_12 + var_350_22 then
				arg_347_1.typewritter.percent = (arg_347_1.time_ - var_350_12) / var_350_22

				arg_347_1.typewritter:SetDirty()
			end

			if arg_347_1.time_ >= var_350_12 + var_350_22 and arg_347_1.time_ < var_350_12 + var_350_22 + arg_350_0 then
				arg_347_1.typewritter.percent = 1

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(true)
			end
		end

		arg_347_1.nodeConfigList_ = {}

		arg_347_1:InitPlayNodeList()
	end,
	Play116021083 = function(arg_351_0, arg_351_1)
		arg_351_1.time_ = 0
		arg_351_1.frameCnt_ = 0
		arg_351_1.state_ = "playing"
		arg_351_1.curTalkId_ = 116021083
		arg_351_1.duration_ = 5

		SetActive(arg_351_1.tipsGo_, false)

		function arg_351_1.onSingleLineFinish_()
			arg_351_1.onSingleLineUpdate_ = nil
			arg_351_1.onSingleLineFinish_ = nil
			arg_351_1.state_ = "waiting"
		end

		function arg_351_1.playNext_(arg_353_0)
			if arg_353_0 == 1 then
				arg_351_0:Play116021084(arg_351_1)
			end
		end

		function arg_351_1.onSingleLineUpdate_(arg_354_0)
			local var_354_0 = arg_351_1.actors_["1029ui_story"]
			local var_354_1 = 0

			if var_354_1 < arg_351_1.time_ and arg_351_1.time_ <= var_354_1 + arg_354_0 and not isNil(var_354_0) and arg_351_1.var_.characterEffect1029ui_story == nil then
				arg_351_1.var_.characterEffect1029ui_story = var_354_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_354_2 = 0.2

			if var_354_1 <= arg_351_1.time_ and arg_351_1.time_ < var_354_1 + var_354_2 and not isNil(var_354_0) then
				local var_354_3 = (arg_351_1.time_ - var_354_1) / var_354_2

				if arg_351_1.var_.characterEffect1029ui_story and not isNil(var_354_0) then
					local var_354_4 = Mathf.Lerp(0, 0.5, var_354_3)

					arg_351_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_351_1.var_.characterEffect1029ui_story.fillRatio = var_354_4
				end
			end

			if arg_351_1.time_ >= var_354_1 + var_354_2 and arg_351_1.time_ < var_354_1 + var_354_2 + arg_354_0 and not isNil(var_354_0) and arg_351_1.var_.characterEffect1029ui_story then
				local var_354_5 = 0.5

				arg_351_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_351_1.var_.characterEffect1029ui_story.fillRatio = var_354_5
			end

			local var_354_6 = arg_351_1.actors_["1029ui_story"].transform
			local var_354_7 = 0

			if var_354_7 < arg_351_1.time_ and arg_351_1.time_ <= var_354_7 + arg_354_0 then
				arg_351_1.var_.moveOldPos1029ui_story = var_354_6.localPosition
			end

			local var_354_8 = 0.001

			if var_354_7 <= arg_351_1.time_ and arg_351_1.time_ < var_354_7 + var_354_8 then
				local var_354_9 = (arg_351_1.time_ - var_354_7) / var_354_8
				local var_354_10 = Vector3.New(0, 100, 0)

				var_354_6.localPosition = Vector3.Lerp(arg_351_1.var_.moveOldPos1029ui_story, var_354_10, var_354_9)

				local var_354_11 = manager.ui.mainCamera.transform.position - var_354_6.position

				var_354_6.forward = Vector3.New(var_354_11.x, var_354_11.y, var_354_11.z)

				local var_354_12 = var_354_6.localEulerAngles

				var_354_12.z = 0
				var_354_12.x = 0
				var_354_6.localEulerAngles = var_354_12
			end

			if arg_351_1.time_ >= var_354_7 + var_354_8 and arg_351_1.time_ < var_354_7 + var_354_8 + arg_354_0 then
				var_354_6.localPosition = Vector3.New(0, 100, 0)

				local var_354_13 = manager.ui.mainCamera.transform.position - var_354_6.position

				var_354_6.forward = Vector3.New(var_354_13.x, var_354_13.y, var_354_13.z)

				local var_354_14 = var_354_6.localEulerAngles

				var_354_14.z = 0
				var_354_14.x = 0
				var_354_6.localEulerAngles = var_354_14
			end

			local var_354_15 = arg_351_1.actors_["1028ui_story"].transform
			local var_354_16 = 0

			if var_354_16 < arg_351_1.time_ and arg_351_1.time_ <= var_354_16 + arg_354_0 then
				arg_351_1.var_.moveOldPos1028ui_story = var_354_15.localPosition
			end

			local var_354_17 = 0.001

			if var_354_16 <= arg_351_1.time_ and arg_351_1.time_ < var_354_16 + var_354_17 then
				local var_354_18 = (arg_351_1.time_ - var_354_16) / var_354_17
				local var_354_19 = Vector3.New(0, 100, 0)

				var_354_15.localPosition = Vector3.Lerp(arg_351_1.var_.moveOldPos1028ui_story, var_354_19, var_354_18)

				local var_354_20 = manager.ui.mainCamera.transform.position - var_354_15.position

				var_354_15.forward = Vector3.New(var_354_20.x, var_354_20.y, var_354_20.z)

				local var_354_21 = var_354_15.localEulerAngles

				var_354_21.z = 0
				var_354_21.x = 0
				var_354_15.localEulerAngles = var_354_21
			end

			if arg_351_1.time_ >= var_354_16 + var_354_17 and arg_351_1.time_ < var_354_16 + var_354_17 + arg_354_0 then
				var_354_15.localPosition = Vector3.New(0, 100, 0)

				local var_354_22 = manager.ui.mainCamera.transform.position - var_354_15.position

				var_354_15.forward = Vector3.New(var_354_22.x, var_354_22.y, var_354_22.z)

				local var_354_23 = var_354_15.localEulerAngles

				var_354_23.z = 0
				var_354_23.x = 0
				var_354_15.localEulerAngles = var_354_23
			end

			local var_354_24 = 0
			local var_354_25 = 1.1

			if var_354_24 < arg_351_1.time_ and arg_351_1.time_ <= var_354_24 + arg_354_0 then
				arg_351_1.talkMaxDuration = 0
				arg_351_1.dialogCg_.alpha = 1

				arg_351_1.dialog_:SetActive(true)
				SetActive(arg_351_1.leftNameGo_, false)

				arg_351_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_351_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_351_1:RecordName(arg_351_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_351_1.iconTrs_.gameObject, false)
				arg_351_1.callingController_:SetSelectedState("normal")

				local var_354_26 = arg_351_1:GetWordFromCfg(116021083)
				local var_354_27 = arg_351_1:FormatText(var_354_26.content)

				arg_351_1.text_.text = var_354_27

				LuaForUtil.ClearLinePrefixSymbol(arg_351_1.text_)

				local var_354_28 = 44
				local var_354_29 = utf8.len(var_354_27)
				local var_354_30 = var_354_28 <= 0 and var_354_25 or var_354_25 * (var_354_29 / var_354_28)

				if var_354_30 > 0 and var_354_25 < var_354_30 then
					arg_351_1.talkMaxDuration = var_354_30

					if var_354_30 + var_354_24 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_30 + var_354_24
					end
				end

				arg_351_1.text_.text = var_354_27
				arg_351_1.typewritter.percent = 0

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(false)
				arg_351_1:RecordContent(arg_351_1.text_.text)
			end

			local var_354_31 = math.max(var_354_25, arg_351_1.talkMaxDuration)

			if var_354_24 <= arg_351_1.time_ and arg_351_1.time_ < var_354_24 + var_354_31 then
				arg_351_1.typewritter.percent = (arg_351_1.time_ - var_354_24) / var_354_31

				arg_351_1.typewritter:SetDirty()
			end

			if arg_351_1.time_ >= var_354_24 + var_354_31 and arg_351_1.time_ < var_354_24 + var_354_31 + arg_354_0 then
				arg_351_1.typewritter.percent = 1

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(true)
			end
		end

		arg_351_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1029ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1028ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_351_1:InitPlayNodeList()
	end,
	Play116021084 = function(arg_355_0, arg_355_1)
		arg_355_1.time_ = 0
		arg_355_1.frameCnt_ = 0
		arg_355_1.state_ = "playing"
		arg_355_1.curTalkId_ = 116021084
		arg_355_1.duration_ = 9.07

		local var_355_0 = {
			zh = 9.066,
			ja = 5.233
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
				arg_355_0:Play116021085(arg_355_1)
			end
		end

		function arg_355_1.onSingleLineUpdate_(arg_358_0)
			local var_358_0 = 0

			if var_358_0 < arg_355_1.time_ and arg_355_1.time_ <= var_358_0 + arg_358_0 then
				arg_355_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action1_1")
			end

			local var_358_1 = 0

			if var_358_1 < arg_355_1.time_ and arg_355_1.time_ <= var_358_1 + arg_358_0 then
				arg_355_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_358_2 = arg_355_1.actors_["1029ui_story"]
			local var_358_3 = 0

			if var_358_3 < arg_355_1.time_ and arg_355_1.time_ <= var_358_3 + arg_358_0 and not isNil(var_358_2) and arg_355_1.var_.characterEffect1029ui_story == nil then
				arg_355_1.var_.characterEffect1029ui_story = var_358_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_358_4 = 0.2

			if var_358_3 <= arg_355_1.time_ and arg_355_1.time_ < var_358_3 + var_358_4 and not isNil(var_358_2) then
				local var_358_5 = (arg_355_1.time_ - var_358_3) / var_358_4

				if arg_355_1.var_.characterEffect1029ui_story and not isNil(var_358_2) then
					arg_355_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_355_1.time_ >= var_358_3 + var_358_4 and arg_355_1.time_ < var_358_3 + var_358_4 + arg_358_0 and not isNil(var_358_2) and arg_355_1.var_.characterEffect1029ui_story then
				arg_355_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_358_6 = arg_355_1.actors_["1029ui_story"].transform
			local var_358_7 = 0

			if var_358_7 < arg_355_1.time_ and arg_355_1.time_ <= var_358_7 + arg_358_0 then
				arg_355_1.var_.moveOldPos1029ui_story = var_358_6.localPosition
			end

			local var_358_8 = 0.001

			if var_358_7 <= arg_355_1.time_ and arg_355_1.time_ < var_358_7 + var_358_8 then
				local var_358_9 = (arg_355_1.time_ - var_358_7) / var_358_8
				local var_358_10 = Vector3.New(0, -1.09, -6.2)

				var_358_6.localPosition = Vector3.Lerp(arg_355_1.var_.moveOldPos1029ui_story, var_358_10, var_358_9)

				local var_358_11 = manager.ui.mainCamera.transform.position - var_358_6.position

				var_358_6.forward = Vector3.New(var_358_11.x, var_358_11.y, var_358_11.z)

				local var_358_12 = var_358_6.localEulerAngles

				var_358_12.z = 0
				var_358_12.x = 0
				var_358_6.localEulerAngles = var_358_12
			end

			if arg_355_1.time_ >= var_358_7 + var_358_8 and arg_355_1.time_ < var_358_7 + var_358_8 + arg_358_0 then
				var_358_6.localPosition = Vector3.New(0, -1.09, -6.2)

				local var_358_13 = manager.ui.mainCamera.transform.position - var_358_6.position

				var_358_6.forward = Vector3.New(var_358_13.x, var_358_13.y, var_358_13.z)

				local var_358_14 = var_358_6.localEulerAngles

				var_358_14.z = 0
				var_358_14.x = 0
				var_358_6.localEulerAngles = var_358_14
			end

			local var_358_15 = 0
			local var_358_16 = 0.775

			if var_358_15 < arg_355_1.time_ and arg_355_1.time_ <= var_358_15 + arg_358_0 then
				arg_355_1.talkMaxDuration = 0
				arg_355_1.dialogCg_.alpha = 1

				arg_355_1.dialog_:SetActive(true)
				SetActive(arg_355_1.leftNameGo_, true)

				local var_358_17 = arg_355_1:FormatText(StoryNameCfg[319].name)

				arg_355_1.leftNameTxt_.text = var_358_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_355_1.leftNameTxt_.transform)

				arg_355_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_355_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_355_1:RecordName(arg_355_1.leftNameTxt_.text)
				SetActive(arg_355_1.iconTrs_.gameObject, false)
				arg_355_1.callingController_:SetSelectedState("normal")

				local var_358_18 = arg_355_1:GetWordFromCfg(116021084)
				local var_358_19 = arg_355_1:FormatText(var_358_18.content)

				arg_355_1.text_.text = var_358_19

				LuaForUtil.ClearLinePrefixSymbol(arg_355_1.text_)

				local var_358_20 = 31
				local var_358_21 = utf8.len(var_358_19)
				local var_358_22 = var_358_20 <= 0 and var_358_16 or var_358_16 * (var_358_21 / var_358_20)

				if var_358_22 > 0 and var_358_16 < var_358_22 then
					arg_355_1.talkMaxDuration = var_358_22

					if var_358_22 + var_358_15 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_22 + var_358_15
					end
				end

				arg_355_1.text_.text = var_358_19
				arg_355_1.typewritter.percent = 0

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116021", "116021084", "story_v_out_116021.awb") ~= 0 then
					local var_358_23 = manager.audio:GetVoiceLength("story_v_out_116021", "116021084", "story_v_out_116021.awb") / 1000

					if var_358_23 + var_358_15 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_23 + var_358_15
					end

					if var_358_18.prefab_name ~= "" and arg_355_1.actors_[var_358_18.prefab_name] ~= nil then
						local var_358_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_355_1.actors_[var_358_18.prefab_name].transform, "story_v_out_116021", "116021084", "story_v_out_116021.awb")

						arg_355_1:RecordAudio("116021084", var_358_24)
						arg_355_1:RecordAudio("116021084", var_358_24)
					else
						arg_355_1:AudioAction("play", "voice", "story_v_out_116021", "116021084", "story_v_out_116021.awb")
					end

					arg_355_1:RecordHistoryTalkVoice("story_v_out_116021", "116021084", "story_v_out_116021.awb")
				end

				arg_355_1:RecordContent(arg_355_1.text_.text)
			end

			local var_358_25 = math.max(var_358_16, arg_355_1.talkMaxDuration)

			if var_358_15 <= arg_355_1.time_ and arg_355_1.time_ < var_358_15 + var_358_25 then
				arg_355_1.typewritter.percent = (arg_355_1.time_ - var_358_15) / var_358_25

				arg_355_1.typewritter:SetDirty()
			end

			if arg_355_1.time_ >= var_358_15 + var_358_25 and arg_355_1.time_ < var_358_15 + var_358_25 + arg_358_0 then
				arg_355_1.typewritter.percent = 1

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(true)
			end
		end

		arg_355_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1029ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_355_1:InitPlayNodeList()
	end,
	Play116021085 = function(arg_359_0, arg_359_1)
		arg_359_1.time_ = 0
		arg_359_1.frameCnt_ = 0
		arg_359_1.state_ = "playing"
		arg_359_1.curTalkId_ = 116021085
		arg_359_1.duration_ = 0.02

		SetActive(arg_359_1.tipsGo_, false)

		function arg_359_1.onSingleLineFinish_()
			arg_359_1.onSingleLineUpdate_ = nil
			arg_359_1.onSingleLineFinish_ = nil
			arg_359_1.state_ = "waiting"

			SetActive(arg_359_1.choicesGo_, true)

			for iter_360_0, iter_360_1 in ipairs(arg_359_1.choices_) do
				local var_360_0 = iter_360_0 <= 2

				SetActive(iter_360_1.go, var_360_0)
			end

			arg_359_1.choices_[1].txt.text = arg_359_1:FormatText(StoryChoiceCfg[231].name)
			arg_359_1.choices_[2].txt.text = arg_359_1:FormatText(StoryChoiceCfg[232].name)
		end

		function arg_359_1.playNext_(arg_361_0)
			if arg_361_0 == 1 then
				arg_359_0:Play116021086(arg_359_1)
			end

			if arg_361_0 == 2 then
				arg_359_0:Play116021086(arg_359_1)
			end

			arg_359_1:RecordChoiceLog(116021085, 231, 232)
		end

		function arg_359_1.onSingleLineUpdate_(arg_362_0)
			return
		end

		arg_359_1.nodeConfigList_ = {}

		arg_359_1:InitPlayNodeList()
	end,
	Play116021086 = function(arg_363_0, arg_363_1)
		arg_363_1.time_ = 0
		arg_363_1.frameCnt_ = 0
		arg_363_1.state_ = "playing"
		arg_363_1.curTalkId_ = 116021086
		arg_363_1.duration_ = 5.93

		local var_363_0 = {
			zh = 5.933,
			ja = 1.999999999999
		}
		local var_363_1 = manager.audio:GetLocalizationFlag()

		if var_363_0[var_363_1] ~= nil then
			arg_363_1.duration_ = var_363_0[var_363_1]
		end

		SetActive(arg_363_1.tipsGo_, false)

		function arg_363_1.onSingleLineFinish_()
			arg_363_1.onSingleLineUpdate_ = nil
			arg_363_1.onSingleLineFinish_ = nil
			arg_363_1.state_ = "waiting"
		end

		function arg_363_1.playNext_(arg_365_0)
			if arg_365_0 == 1 then
				arg_363_0:Play116021087(arg_363_1)
			end
		end

		function arg_363_1.onSingleLineUpdate_(arg_366_0)
			local var_366_0 = "1029ui_story"

			if arg_363_1.actors_[var_366_0] == nil then
				local var_366_1 = Asset.Load("Char/" .. "1029ui_story")

				if not isNil(var_366_1) then
					local var_366_2 = Object.Instantiate(Asset.Load("Char/" .. "1029ui_story"), arg_363_1.stage_.transform)

					var_366_2.name = var_366_0
					var_366_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_363_1.actors_[var_366_0] = var_366_2

					local var_366_3 = var_366_2:GetComponentInChildren(typeof(CharacterEffect))

					var_366_3.enabled = true

					local var_366_4 = GameObjectTools.GetOrAddComponent(var_366_2, typeof(DynamicBoneHelper))

					if var_366_4 then
						var_366_4:EnableDynamicBone(false)
					end

					arg_363_1:ShowWeapon(var_366_3.transform, false)

					arg_363_1.var_[var_366_0 .. "Animator"] = var_366_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_363_1.var_[var_366_0 .. "Animator"].applyRootMotion = true
					arg_363_1.var_[var_366_0 .. "LipSync"] = var_366_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_366_5 = 0

			if var_366_5 < arg_363_1.time_ and arg_363_1.time_ <= var_366_5 + arg_366_0 then
				arg_363_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action2_1")
			end

			local var_366_6 = "1029ui_story"

			if arg_363_1.actors_[var_366_6] == nil then
				local var_366_7 = Asset.Load("Char/" .. "1029ui_story")

				if not isNil(var_366_7) then
					local var_366_8 = Object.Instantiate(Asset.Load("Char/" .. "1029ui_story"), arg_363_1.stage_.transform)

					var_366_8.name = var_366_6
					var_366_8.transform.localPosition = Vector3.New(0, 100, 0)
					arg_363_1.actors_[var_366_6] = var_366_8

					local var_366_9 = var_366_8:GetComponentInChildren(typeof(CharacterEffect))

					var_366_9.enabled = true

					local var_366_10 = GameObjectTools.GetOrAddComponent(var_366_8, typeof(DynamicBoneHelper))

					if var_366_10 then
						var_366_10:EnableDynamicBone(false)
					end

					arg_363_1:ShowWeapon(var_366_9.transform, false)

					arg_363_1.var_[var_366_6 .. "Animator"] = var_366_9.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_363_1.var_[var_366_6 .. "Animator"].applyRootMotion = true
					arg_363_1.var_[var_366_6 .. "LipSync"] = var_366_9.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_366_11 = 0

			if var_366_11 < arg_363_1.time_ and arg_363_1.time_ <= var_366_11 + arg_366_0 then
				arg_363_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_366_12 = 0
			local var_366_13 = 0.475

			if var_366_12 < arg_363_1.time_ and arg_363_1.time_ <= var_366_12 + arg_366_0 then
				arg_363_1.talkMaxDuration = 0
				arg_363_1.dialogCg_.alpha = 1

				arg_363_1.dialog_:SetActive(true)
				SetActive(arg_363_1.leftNameGo_, true)

				local var_366_14 = arg_363_1:FormatText(StoryNameCfg[319].name)

				arg_363_1.leftNameTxt_.text = var_366_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_363_1.leftNameTxt_.transform)

				arg_363_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_363_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_363_1:RecordName(arg_363_1.leftNameTxt_.text)
				SetActive(arg_363_1.iconTrs_.gameObject, false)
				arg_363_1.callingController_:SetSelectedState("normal")

				local var_366_15 = arg_363_1:GetWordFromCfg(116021086)
				local var_366_16 = arg_363_1:FormatText(var_366_15.content)

				arg_363_1.text_.text = var_366_16

				LuaForUtil.ClearLinePrefixSymbol(arg_363_1.text_)

				local var_366_17 = 19
				local var_366_18 = utf8.len(var_366_16)
				local var_366_19 = var_366_17 <= 0 and var_366_13 or var_366_13 * (var_366_18 / var_366_17)

				if var_366_19 > 0 and var_366_13 < var_366_19 then
					arg_363_1.talkMaxDuration = var_366_19

					if var_366_19 + var_366_12 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_19 + var_366_12
					end
				end

				arg_363_1.text_.text = var_366_16
				arg_363_1.typewritter.percent = 0

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116021", "116021086", "story_v_out_116021.awb") ~= 0 then
					local var_366_20 = manager.audio:GetVoiceLength("story_v_out_116021", "116021086", "story_v_out_116021.awb") / 1000

					if var_366_20 + var_366_12 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_20 + var_366_12
					end

					if var_366_15.prefab_name ~= "" and arg_363_1.actors_[var_366_15.prefab_name] ~= nil then
						local var_366_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_363_1.actors_[var_366_15.prefab_name].transform, "story_v_out_116021", "116021086", "story_v_out_116021.awb")

						arg_363_1:RecordAudio("116021086", var_366_21)
						arg_363_1:RecordAudio("116021086", var_366_21)
					else
						arg_363_1:AudioAction("play", "voice", "story_v_out_116021", "116021086", "story_v_out_116021.awb")
					end

					arg_363_1:RecordHistoryTalkVoice("story_v_out_116021", "116021086", "story_v_out_116021.awb")
				end

				arg_363_1:RecordContent(arg_363_1.text_.text)
			end

			local var_366_22 = math.max(var_366_13, arg_363_1.talkMaxDuration)

			if var_366_12 <= arg_363_1.time_ and arg_363_1.time_ < var_366_12 + var_366_22 then
				arg_363_1.typewritter.percent = (arg_363_1.time_ - var_366_12) / var_366_22

				arg_363_1.typewritter:SetDirty()
			end

			if arg_363_1.time_ >= var_366_12 + var_366_22 and arg_363_1.time_ < var_366_12 + var_366_22 + arg_366_0 then
				arg_363_1.typewritter.percent = 1

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(true)
			end
		end

		arg_363_1.nodeConfigList_ = {}

		arg_363_1:InitPlayNodeList()
	end,
	Play116021087 = function(arg_367_0, arg_367_1)
		arg_367_1.time_ = 0
		arg_367_1.frameCnt_ = 0
		arg_367_1.state_ = "playing"
		arg_367_1.curTalkId_ = 116021087
		arg_367_1.duration_ = 3.27

		local var_367_0 = {
			zh = 3.266,
			ja = 2.9
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
				arg_367_0:Play116021088(arg_367_1)
			end
		end

		function arg_367_1.onSingleLineUpdate_(arg_370_0)
			local var_370_0 = arg_367_1.actors_["1029ui_story"]
			local var_370_1 = 0

			if var_370_1 < arg_367_1.time_ and arg_367_1.time_ <= var_370_1 + arg_370_0 and not isNil(var_370_0) and arg_367_1.var_.characterEffect1029ui_story == nil then
				arg_367_1.var_.characterEffect1029ui_story = var_370_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_370_2 = 0.2

			if var_370_1 <= arg_367_1.time_ and arg_367_1.time_ < var_370_1 + var_370_2 and not isNil(var_370_0) then
				local var_370_3 = (arg_367_1.time_ - var_370_1) / var_370_2

				if arg_367_1.var_.characterEffect1029ui_story and not isNil(var_370_0) then
					local var_370_4 = Mathf.Lerp(0, 0.5, var_370_3)

					arg_367_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_367_1.var_.characterEffect1029ui_story.fillRatio = var_370_4
				end
			end

			if arg_367_1.time_ >= var_370_1 + var_370_2 and arg_367_1.time_ < var_370_1 + var_370_2 + arg_370_0 and not isNil(var_370_0) and arg_367_1.var_.characterEffect1029ui_story then
				local var_370_5 = 0.5

				arg_367_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_367_1.var_.characterEffect1029ui_story.fillRatio = var_370_5
			end

			local var_370_6 = 0
			local var_370_7 = 0.375

			if var_370_6 < arg_367_1.time_ and arg_367_1.time_ <= var_370_6 + arg_370_0 then
				arg_367_1.talkMaxDuration = 0
				arg_367_1.dialogCg_.alpha = 1

				arg_367_1.dialog_:SetActive(true)
				SetActive(arg_367_1.leftNameGo_, true)

				local var_370_8 = arg_367_1:FormatText(StoryNameCfg[13].name)

				arg_367_1.leftNameTxt_.text = var_370_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_367_1.leftNameTxt_.transform)

				arg_367_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_367_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_367_1:RecordName(arg_367_1.leftNameTxt_.text)
				SetActive(arg_367_1.iconTrs_.gameObject, true)
				arg_367_1.iconController_:SetSelectedState("hero")

				arg_367_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019")

				arg_367_1.callingController_:SetSelectedState("normal")

				arg_367_1.keyicon_.color = Color.New(1, 1, 1)
				arg_367_1.icon_.color = Color.New(1, 1, 1)

				local var_370_9 = arg_367_1:GetWordFromCfg(116021087)
				local var_370_10 = arg_367_1:FormatText(var_370_9.content)

				arg_367_1.text_.text = var_370_10

				LuaForUtil.ClearLinePrefixSymbol(arg_367_1.text_)

				local var_370_11 = 15
				local var_370_12 = utf8.len(var_370_10)
				local var_370_13 = var_370_11 <= 0 and var_370_7 or var_370_7 * (var_370_12 / var_370_11)

				if var_370_13 > 0 and var_370_7 < var_370_13 then
					arg_367_1.talkMaxDuration = var_370_13

					if var_370_13 + var_370_6 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_13 + var_370_6
					end
				end

				arg_367_1.text_.text = var_370_10
				arg_367_1.typewritter.percent = 0

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116021", "116021087", "story_v_out_116021.awb") ~= 0 then
					local var_370_14 = manager.audio:GetVoiceLength("story_v_out_116021", "116021087", "story_v_out_116021.awb") / 1000

					if var_370_14 + var_370_6 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_14 + var_370_6
					end

					if var_370_9.prefab_name ~= "" and arg_367_1.actors_[var_370_9.prefab_name] ~= nil then
						local var_370_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_367_1.actors_[var_370_9.prefab_name].transform, "story_v_out_116021", "116021087", "story_v_out_116021.awb")

						arg_367_1:RecordAudio("116021087", var_370_15)
						arg_367_1:RecordAudio("116021087", var_370_15)
					else
						arg_367_1:AudioAction("play", "voice", "story_v_out_116021", "116021087", "story_v_out_116021.awb")
					end

					arg_367_1:RecordHistoryTalkVoice("story_v_out_116021", "116021087", "story_v_out_116021.awb")
				end

				arg_367_1:RecordContent(arg_367_1.text_.text)
			end

			local var_370_16 = math.max(var_370_7, arg_367_1.talkMaxDuration)

			if var_370_6 <= arg_367_1.time_ and arg_367_1.time_ < var_370_6 + var_370_16 then
				arg_367_1.typewritter.percent = (arg_367_1.time_ - var_370_6) / var_370_16

				arg_367_1.typewritter:SetDirty()
			end

			if arg_367_1.time_ >= var_370_6 + var_370_16 and arg_367_1.time_ < var_370_6 + var_370_16 + arg_370_0 then
				arg_367_1.typewritter.percent = 1

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(true)
			end
		end

		arg_367_1.nodeConfigList_ = {}

		arg_367_1:InitPlayNodeList()
	end,
	Play116021088 = function(arg_371_0, arg_371_1)
		arg_371_1.time_ = 0
		arg_371_1.frameCnt_ = 0
		arg_371_1.state_ = "playing"
		arg_371_1.curTalkId_ = 116021088
		arg_371_1.duration_ = 10.5

		local var_371_0 = {
			zh = 9.933,
			ja = 10.5
		}
		local var_371_1 = manager.audio:GetLocalizationFlag()

		if var_371_0[var_371_1] ~= nil then
			arg_371_1.duration_ = var_371_0[var_371_1]
		end

		SetActive(arg_371_1.tipsGo_, false)

		function arg_371_1.onSingleLineFinish_()
			arg_371_1.onSingleLineUpdate_ = nil
			arg_371_1.onSingleLineFinish_ = nil
			arg_371_1.state_ = "waiting"
		end

		function arg_371_1.playNext_(arg_373_0)
			if arg_373_0 == 1 then
				arg_371_0:Play116021089(arg_371_1)
			end
		end

		function arg_371_1.onSingleLineUpdate_(arg_374_0)
			local var_374_0 = 0

			if var_374_0 < arg_371_1.time_ and arg_371_1.time_ <= var_374_0 + arg_374_0 then
				arg_371_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action2_2")
			end

			local var_374_1 = 0

			if var_374_1 < arg_371_1.time_ and arg_371_1.time_ <= var_374_1 + arg_374_0 then
				arg_371_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_374_2 = arg_371_1.actors_["1029ui_story"]
			local var_374_3 = 0

			if var_374_3 < arg_371_1.time_ and arg_371_1.time_ <= var_374_3 + arg_374_0 and not isNil(var_374_2) and arg_371_1.var_.characterEffect1029ui_story == nil then
				arg_371_1.var_.characterEffect1029ui_story = var_374_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_374_4 = 0.2

			if var_374_3 <= arg_371_1.time_ and arg_371_1.time_ < var_374_3 + var_374_4 and not isNil(var_374_2) then
				local var_374_5 = (arg_371_1.time_ - var_374_3) / var_374_4

				if arg_371_1.var_.characterEffect1029ui_story and not isNil(var_374_2) then
					arg_371_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_371_1.time_ >= var_374_3 + var_374_4 and arg_371_1.time_ < var_374_3 + var_374_4 + arg_374_0 and not isNil(var_374_2) and arg_371_1.var_.characterEffect1029ui_story then
				arg_371_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_374_6 = 0
			local var_374_7 = 1.1

			if var_374_6 < arg_371_1.time_ and arg_371_1.time_ <= var_374_6 + arg_374_0 then
				arg_371_1.talkMaxDuration = 0
				arg_371_1.dialogCg_.alpha = 1

				arg_371_1.dialog_:SetActive(true)
				SetActive(arg_371_1.leftNameGo_, true)

				local var_374_8 = arg_371_1:FormatText(StoryNameCfg[319].name)

				arg_371_1.leftNameTxt_.text = var_374_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_371_1.leftNameTxt_.transform)

				arg_371_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_371_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_371_1:RecordName(arg_371_1.leftNameTxt_.text)
				SetActive(arg_371_1.iconTrs_.gameObject, false)
				arg_371_1.callingController_:SetSelectedState("normal")

				local var_374_9 = arg_371_1:GetWordFromCfg(116021088)
				local var_374_10 = arg_371_1:FormatText(var_374_9.content)

				arg_371_1.text_.text = var_374_10

				LuaForUtil.ClearLinePrefixSymbol(arg_371_1.text_)

				local var_374_11 = 44
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

				if manager.audio:GetVoiceLength("story_v_out_116021", "116021088", "story_v_out_116021.awb") ~= 0 then
					local var_374_14 = manager.audio:GetVoiceLength("story_v_out_116021", "116021088", "story_v_out_116021.awb") / 1000

					if var_374_14 + var_374_6 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_14 + var_374_6
					end

					if var_374_9.prefab_name ~= "" and arg_371_1.actors_[var_374_9.prefab_name] ~= nil then
						local var_374_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_371_1.actors_[var_374_9.prefab_name].transform, "story_v_out_116021", "116021088", "story_v_out_116021.awb")

						arg_371_1:RecordAudio("116021088", var_374_15)
						arg_371_1:RecordAudio("116021088", var_374_15)
					else
						arg_371_1:AudioAction("play", "voice", "story_v_out_116021", "116021088", "story_v_out_116021.awb")
					end

					arg_371_1:RecordHistoryTalkVoice("story_v_out_116021", "116021088", "story_v_out_116021.awb")
				end

				arg_371_1:RecordContent(arg_371_1.text_.text)
			end

			local var_374_16 = math.max(var_374_7, arg_371_1.talkMaxDuration)

			if var_374_6 <= arg_371_1.time_ and arg_371_1.time_ < var_374_6 + var_374_16 then
				arg_371_1.typewritter.percent = (arg_371_1.time_ - var_374_6) / var_374_16

				arg_371_1.typewritter:SetDirty()
			end

			if arg_371_1.time_ >= var_374_6 + var_374_16 and arg_371_1.time_ < var_374_6 + var_374_16 + arg_374_0 then
				arg_371_1.typewritter.percent = 1

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(true)
			end
		end

		arg_371_1.nodeConfigList_ = {}

		arg_371_1:InitPlayNodeList()
	end,
	Play116021089 = function(arg_375_0, arg_375_1)
		arg_375_1.time_ = 0
		arg_375_1.frameCnt_ = 0
		arg_375_1.state_ = "playing"
		arg_375_1.curTalkId_ = 116021089
		arg_375_1.duration_ = 4.9

		local var_375_0 = {
			zh = 1.999999999999,
			ja = 4.9
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
				arg_375_0:Play116021090(arg_375_1)
			end
		end

		function arg_375_1.onSingleLineUpdate_(arg_378_0)
			local var_378_0 = 0

			if var_378_0 < arg_375_1.time_ and arg_375_1.time_ <= var_378_0 + arg_378_0 then
				arg_375_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action1_1")
			end

			local var_378_1 = 0

			if var_378_1 < arg_375_1.time_ and arg_375_1.time_ <= var_378_1 + arg_378_0 then
				arg_375_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_378_2 = 0
			local var_378_3 = 0.15

			if var_378_2 < arg_375_1.time_ and arg_375_1.time_ <= var_378_2 + arg_378_0 then
				arg_375_1.talkMaxDuration = 0
				arg_375_1.dialogCg_.alpha = 1

				arg_375_1.dialog_:SetActive(true)
				SetActive(arg_375_1.leftNameGo_, true)

				local var_378_4 = arg_375_1:FormatText(StoryNameCfg[319].name)

				arg_375_1.leftNameTxt_.text = var_378_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_375_1.leftNameTxt_.transform)

				arg_375_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_375_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_375_1:RecordName(arg_375_1.leftNameTxt_.text)
				SetActive(arg_375_1.iconTrs_.gameObject, false)
				arg_375_1.callingController_:SetSelectedState("normal")

				local var_378_5 = arg_375_1:GetWordFromCfg(116021089)
				local var_378_6 = arg_375_1:FormatText(var_378_5.content)

				arg_375_1.text_.text = var_378_6

				LuaForUtil.ClearLinePrefixSymbol(arg_375_1.text_)

				local var_378_7 = 6
				local var_378_8 = utf8.len(var_378_6)
				local var_378_9 = var_378_7 <= 0 and var_378_3 or var_378_3 * (var_378_8 / var_378_7)

				if var_378_9 > 0 and var_378_3 < var_378_9 then
					arg_375_1.talkMaxDuration = var_378_9

					if var_378_9 + var_378_2 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_9 + var_378_2
					end
				end

				arg_375_1.text_.text = var_378_6
				arg_375_1.typewritter.percent = 0

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116021", "116021089", "story_v_out_116021.awb") ~= 0 then
					local var_378_10 = manager.audio:GetVoiceLength("story_v_out_116021", "116021089", "story_v_out_116021.awb") / 1000

					if var_378_10 + var_378_2 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_10 + var_378_2
					end

					if var_378_5.prefab_name ~= "" and arg_375_1.actors_[var_378_5.prefab_name] ~= nil then
						local var_378_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_375_1.actors_[var_378_5.prefab_name].transform, "story_v_out_116021", "116021089", "story_v_out_116021.awb")

						arg_375_1:RecordAudio("116021089", var_378_11)
						arg_375_1:RecordAudio("116021089", var_378_11)
					else
						arg_375_1:AudioAction("play", "voice", "story_v_out_116021", "116021089", "story_v_out_116021.awb")
					end

					arg_375_1:RecordHistoryTalkVoice("story_v_out_116021", "116021089", "story_v_out_116021.awb")
				end

				arg_375_1:RecordContent(arg_375_1.text_.text)
			end

			local var_378_12 = math.max(var_378_3, arg_375_1.talkMaxDuration)

			if var_378_2 <= arg_375_1.time_ and arg_375_1.time_ < var_378_2 + var_378_12 then
				arg_375_1.typewritter.percent = (arg_375_1.time_ - var_378_2) / var_378_12

				arg_375_1.typewritter:SetDirty()
			end

			if arg_375_1.time_ >= var_378_2 + var_378_12 and arg_375_1.time_ < var_378_2 + var_378_12 + arg_378_0 then
				arg_375_1.typewritter.percent = 1

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(true)
			end
		end

		arg_375_1.nodeConfigList_ = {}

		arg_375_1:InitPlayNodeList()
	end,
	Play116021090 = function(arg_379_0, arg_379_1)
		arg_379_1.time_ = 0
		arg_379_1.frameCnt_ = 0
		arg_379_1.state_ = "playing"
		arg_379_1.curTalkId_ = 116021090
		arg_379_1.duration_ = 3.9

		local var_379_0 = {
			zh = 3.9,
			ja = 2
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
			arg_379_1.auto_ = false
		end

		function arg_379_1.playNext_(arg_381_0)
			arg_379_1.onStoryFinished_()
		end

		function arg_379_1.onSingleLineUpdate_(arg_382_0)
			local var_382_0 = arg_379_1.actors_["1029ui_story"]
			local var_382_1 = 0

			if var_382_1 < arg_379_1.time_ and arg_379_1.time_ <= var_382_1 + arg_382_0 and not isNil(var_382_0) and arg_379_1.var_.characterEffect1029ui_story == nil then
				arg_379_1.var_.characterEffect1029ui_story = var_382_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_382_2 = 0.2

			if var_382_1 <= arg_379_1.time_ and arg_379_1.time_ < var_382_1 + var_382_2 and not isNil(var_382_0) then
				local var_382_3 = (arg_379_1.time_ - var_382_1) / var_382_2

				if arg_379_1.var_.characterEffect1029ui_story and not isNil(var_382_0) then
					local var_382_4 = Mathf.Lerp(0, 0.5, var_382_3)

					arg_379_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_379_1.var_.characterEffect1029ui_story.fillRatio = var_382_4
				end
			end

			if arg_379_1.time_ >= var_382_1 + var_382_2 and arg_379_1.time_ < var_382_1 + var_382_2 + arg_382_0 and not isNil(var_382_0) and arg_379_1.var_.characterEffect1029ui_story then
				local var_382_5 = 0.5

				arg_379_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_379_1.var_.characterEffect1029ui_story.fillRatio = var_382_5
			end

			local var_382_6 = 0
			local var_382_7 = 0.175

			if var_382_6 < arg_379_1.time_ and arg_379_1.time_ <= var_382_6 + arg_382_0 then
				arg_379_1.talkMaxDuration = 0
				arg_379_1.dialogCg_.alpha = 1

				arg_379_1.dialog_:SetActive(true)
				SetActive(arg_379_1.leftNameGo_, true)

				local var_382_8 = arg_379_1:FormatText(StoryNameCfg[13].name)

				arg_379_1.leftNameTxt_.text = var_382_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_379_1.leftNameTxt_.transform)

				arg_379_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_379_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_379_1:RecordName(arg_379_1.leftNameTxt_.text)
				SetActive(arg_379_1.iconTrs_.gameObject, true)
				arg_379_1.iconController_:SetSelectedState("hero")

				arg_379_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019")

				arg_379_1.callingController_:SetSelectedState("normal")

				arg_379_1.keyicon_.color = Color.New(1, 1, 1)
				arg_379_1.icon_.color = Color.New(1, 1, 1)

				local var_382_9 = arg_379_1:GetWordFromCfg(116021090)
				local var_382_10 = arg_379_1:FormatText(var_382_9.content)

				arg_379_1.text_.text = var_382_10

				LuaForUtil.ClearLinePrefixSymbol(arg_379_1.text_)

				local var_382_11 = 7
				local var_382_12 = utf8.len(var_382_10)
				local var_382_13 = var_382_11 <= 0 and var_382_7 or var_382_7 * (var_382_12 / var_382_11)

				if var_382_13 > 0 and var_382_7 < var_382_13 then
					arg_379_1.talkMaxDuration = var_382_13

					if var_382_13 + var_382_6 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_13 + var_382_6
					end
				end

				arg_379_1.text_.text = var_382_10
				arg_379_1.typewritter.percent = 0

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116021", "116021090", "story_v_out_116021.awb") ~= 0 then
					local var_382_14 = manager.audio:GetVoiceLength("story_v_out_116021", "116021090", "story_v_out_116021.awb") / 1000

					if var_382_14 + var_382_6 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_14 + var_382_6
					end

					if var_382_9.prefab_name ~= "" and arg_379_1.actors_[var_382_9.prefab_name] ~= nil then
						local var_382_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_379_1.actors_[var_382_9.prefab_name].transform, "story_v_out_116021", "116021090", "story_v_out_116021.awb")

						arg_379_1:RecordAudio("116021090", var_382_15)
						arg_379_1:RecordAudio("116021090", var_382_15)
					else
						arg_379_1:AudioAction("play", "voice", "story_v_out_116021", "116021090", "story_v_out_116021.awb")
					end

					arg_379_1:RecordHistoryTalkVoice("story_v_out_116021", "116021090", "story_v_out_116021.awb")
				end

				arg_379_1:RecordContent(arg_379_1.text_.text)
			end

			local var_382_16 = math.max(var_382_7, arg_379_1.talkMaxDuration)

			if var_382_6 <= arg_379_1.time_ and arg_379_1.time_ < var_382_6 + var_382_16 then
				arg_379_1.typewritter.percent = (arg_379_1.time_ - var_382_6) / var_382_16

				arg_379_1.typewritter:SetDirty()
			end

			if arg_379_1.time_ >= var_382_6 + var_382_16 and arg_379_1.time_ < var_382_6 + var_382_16 + arg_382_0 then
				arg_379_1.typewritter.percent = 1

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(true)
			end
		end

		arg_379_1.nodeConfigList_ = {}

		arg_379_1:InitPlayNodeList()
	end,
	Play116021044 = function(arg_383_0, arg_383_1)
		arg_383_1.time_ = 0
		arg_383_1.frameCnt_ = 0
		arg_383_1.state_ = "playing"
		arg_383_1.curTalkId_ = 116021044
		arg_383_1.duration_ = 7.83

		local var_383_0 = {
			zh = 7.5,
			ja = 7.833
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
				arg_383_0:Play116021045(arg_383_1)
			end
		end

		function arg_383_1.onSingleLineUpdate_(arg_386_0)
			local var_386_0 = 0
			local var_386_1 = 0.925

			if var_386_0 < arg_383_1.time_ and arg_383_1.time_ <= var_386_0 + arg_386_0 then
				arg_383_1.talkMaxDuration = 0
				arg_383_1.dialogCg_.alpha = 1

				arg_383_1.dialog_:SetActive(true)
				SetActive(arg_383_1.leftNameGo_, true)

				local var_386_2 = arg_383_1:FormatText(StoryNameCfg[327].name)

				arg_383_1.leftNameTxt_.text = var_386_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_383_1.leftNameTxt_.transform)

				arg_383_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_383_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_383_1:RecordName(arg_383_1.leftNameTxt_.text)
				SetActive(arg_383_1.iconTrs_.gameObject, false)
				arg_383_1.callingController_:SetSelectedState("normal")

				local var_386_3 = arg_383_1:GetWordFromCfg(116021044)
				local var_386_4 = arg_383_1:FormatText(var_386_3.content)

				arg_383_1.text_.text = var_386_4

				LuaForUtil.ClearLinePrefixSymbol(arg_383_1.text_)

				local var_386_5 = 37
				local var_386_6 = utf8.len(var_386_4)
				local var_386_7 = var_386_5 <= 0 and var_386_1 or var_386_1 * (var_386_6 / var_386_5)

				if var_386_7 > 0 and var_386_1 < var_386_7 then
					arg_383_1.talkMaxDuration = var_386_7

					if var_386_7 + var_386_0 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_7 + var_386_0
					end
				end

				arg_383_1.text_.text = var_386_4
				arg_383_1.typewritter.percent = 0

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116021", "116021044", "story_v_out_116021.awb") ~= 0 then
					local var_386_8 = manager.audio:GetVoiceLength("story_v_out_116021", "116021044", "story_v_out_116021.awb") / 1000

					if var_386_8 + var_386_0 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_8 + var_386_0
					end

					if var_386_3.prefab_name ~= "" and arg_383_1.actors_[var_386_3.prefab_name] ~= nil then
						local var_386_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_383_1.actors_[var_386_3.prefab_name].transform, "story_v_out_116021", "116021044", "story_v_out_116021.awb")

						arg_383_1:RecordAudio("116021044", var_386_9)
						arg_383_1:RecordAudio("116021044", var_386_9)
					else
						arg_383_1:AudioAction("play", "voice", "story_v_out_116021", "116021044", "story_v_out_116021.awb")
					end

					arg_383_1:RecordHistoryTalkVoice("story_v_out_116021", "116021044", "story_v_out_116021.awb")
				end

				arg_383_1:RecordContent(arg_383_1.text_.text)
			end

			local var_386_10 = math.max(var_386_1, arg_383_1.talkMaxDuration)

			if var_386_0 <= arg_383_1.time_ and arg_383_1.time_ < var_386_0 + var_386_10 then
				arg_383_1.typewritter.percent = (arg_383_1.time_ - var_386_0) / var_386_10

				arg_383_1.typewritter:SetDirty()
			end

			if arg_383_1.time_ >= var_386_0 + var_386_10 and arg_383_1.time_ < var_386_0 + var_386_10 + arg_386_0 then
				arg_383_1.typewritter.percent = 1

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(true)
			end
		end

		arg_383_1.nodeConfigList_ = {}

		arg_383_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/I02",
		"TextureConfig/Background/ST07b",
		"TextureConfig/Background/SK0104",
		"TextureConfig/Background/B13",
		"TextureConfig/Background/SK0105",
		"TextureConfig/Background/A00"
	},
	voices = {
		"story_v_out_116021.awb"
	}
}
