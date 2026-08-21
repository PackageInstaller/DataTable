return {
	Play115311001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 115311001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play115311002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "ST22a"

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
				local var_4_5 = arg_1_1.bgs_.ST22a

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
					if iter_4_0 ~= "ST22a" then
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
				local var_4_25 = "effect"

				arg_1_1:AudioAction(var_4_24, var_4_25, "se_story_activity_1_5_3", "se_story_activity_1_5_3_fireworks_loop", "")
			end

			local var_4_26 = 0
			local var_4_27 = 0.333333333333333

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

			local var_4_32 = 0.466666666666667
			local var_4_33 = 0.533333333333333

			if var_4_32 < arg_1_1.time_ and arg_1_1.time_ <= var_4_32 + arg_4_0 then
				local var_4_34 = "play"
				local var_4_35 = "music"

				arg_1_1:AudioAction(var_4_34, var_4_35, "bgm_side_daily04", "bgm_side_daily04", "bgm_side_daily04.awb")

				local var_4_36 = ""
				local var_4_37 = manager.audio:GetAudioName("bgm_side_daily04", "bgm_side_daily04")

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
			local var_4_39 = 0.125

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

				local var_4_41 = arg_1_1:GetWordFromCfg(115311001)
				local var_4_42 = arg_1_1:FormatText(var_4_41.content)

				arg_1_1.text_.text = var_4_42

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_43 = 5
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
	Play115311002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 115311002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play115311003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0
			local var_12_1 = 1.025

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

				local var_12_2 = arg_9_1:GetWordFromCfg(115311002)
				local var_12_3 = arg_9_1:FormatText(var_12_2.content)

				arg_9_1.text_.text = var_12_3

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_4 = 41
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
	Play115311003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 115311003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play115311004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0
			local var_16_1 = 1.225

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

				local var_16_2 = arg_13_1:GetWordFromCfg(115311003)
				local var_16_3 = arg_13_1:FormatText(var_16_2.content)

				arg_13_1.text_.text = var_16_3

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_4 = 49
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
	Play115311004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 115311004
		arg_17_1.duration_ = 11.37

		local var_17_0 = {
			ja = 9.933,
			ko = 10.533,
			zh = 8.933,
			en = 11.366
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
				arg_17_0:Play115311005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0
			local var_20_1 = 0.625

			if var_20_0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_0 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_2 = arg_17_1:FormatText(StoryNameCfg[224].name)

				arg_17_1.leftNameTxt_.text = var_20_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, true)
				arg_17_1.iconController_:SetSelectedState("hero")

				arg_17_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_clerkb")

				arg_17_1.callingController_:SetSelectedState("normal")

				arg_17_1.keyicon_.color = Color.New(1, 1, 1)
				arg_17_1.icon_.color = Color.New(1, 1, 1)

				local var_20_3 = arg_17_1:GetWordFromCfg(115311004)
				local var_20_4 = arg_17_1:FormatText(var_20_3.content)

				arg_17_1.text_.text = var_20_4

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_5 = 25
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

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311004", "story_v_out_115311.awb") ~= 0 then
					local var_20_8 = manager.audio:GetVoiceLength("story_v_out_115311", "115311004", "story_v_out_115311.awb") / 1000

					if var_20_8 + var_20_0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_8 + var_20_0
					end

					if var_20_3.prefab_name ~= "" and arg_17_1.actors_[var_20_3.prefab_name] ~= nil then
						local var_20_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_3.prefab_name].transform, "story_v_out_115311", "115311004", "story_v_out_115311.awb")

						arg_17_1:RecordAudio("115311004", var_20_9)
						arg_17_1:RecordAudio("115311004", var_20_9)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_115311", "115311004", "story_v_out_115311.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_115311", "115311004", "story_v_out_115311.awb")
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
	Play115311005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 115311005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play115311006(arg_21_1)
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

				local var_24_2 = arg_21_1:GetWordFromCfg(115311005)
				local var_24_3 = arg_21_1:FormatText(var_24_2.content)

				arg_21_1.text_.text = var_24_3

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_4 = 42
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
	Play115311006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 115311006
		arg_25_1.duration_ = 9.2

		local var_25_0 = {
			ja = 7.766,
			ko = 8.2,
			zh = 7.066,
			en = 9.2
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
				arg_25_0:Play115311007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 0
			local var_28_1 = 0.85

			if var_28_0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_0 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_2 = arg_25_1:FormatText(StoryNameCfg[104].name)

				arg_25_1.leftNameTxt_.text = var_28_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, true)
				arg_25_1.iconController_:SetSelectedState("hero")

				arg_25_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_woundedd")

				arg_25_1.callingController_:SetSelectedState("normal")

				arg_25_1.keyicon_.color = Color.New(1, 1, 1)
				arg_25_1.icon_.color = Color.New(1, 1, 1)

				local var_28_3 = arg_25_1:GetWordFromCfg(115311006)
				local var_28_4 = arg_25_1:FormatText(var_28_3.content)

				arg_25_1.text_.text = var_28_4

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_5 = 34
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

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311006", "story_v_out_115311.awb") ~= 0 then
					local var_28_8 = manager.audio:GetVoiceLength("story_v_out_115311", "115311006", "story_v_out_115311.awb") / 1000

					if var_28_8 + var_28_0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_8 + var_28_0
					end

					if var_28_3.prefab_name ~= "" and arg_25_1.actors_[var_28_3.prefab_name] ~= nil then
						local var_28_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_3.prefab_name].transform, "story_v_out_115311", "115311006", "story_v_out_115311.awb")

						arg_25_1:RecordAudio("115311006", var_28_9)
						arg_25_1:RecordAudio("115311006", var_28_9)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_115311", "115311006", "story_v_out_115311.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_115311", "115311006", "story_v_out_115311.awb")
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
	Play115311007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 115311007
		arg_29_1.duration_ = 6.87

		local var_29_0 = {
			ja = 6.6,
			ko = 6.7,
			zh = 5.4,
			en = 6.866
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
				arg_29_0:Play115311008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 0
			local var_32_1 = 0.725

			if var_32_0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_0 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_2 = arg_29_1:FormatText(StoryNameCfg[105].name)

				arg_29_1.leftNameTxt_.text = var_32_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, true)
				arg_29_1.iconController_:SetSelectedState("hero")

				arg_29_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officeladyb")

				arg_29_1.callingController_:SetSelectedState("normal")

				arg_29_1.keyicon_.color = Color.New(1, 1, 1)
				arg_29_1.icon_.color = Color.New(1, 1, 1)

				local var_32_3 = arg_29_1:GetWordFromCfg(115311007)
				local var_32_4 = arg_29_1:FormatText(var_32_3.content)

				arg_29_1.text_.text = var_32_4

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_5 = 29
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

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311007", "story_v_out_115311.awb") ~= 0 then
					local var_32_8 = manager.audio:GetVoiceLength("story_v_out_115311", "115311007", "story_v_out_115311.awb") / 1000

					if var_32_8 + var_32_0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_8 + var_32_0
					end

					if var_32_3.prefab_name ~= "" and arg_29_1.actors_[var_32_3.prefab_name] ~= nil then
						local var_32_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_3.prefab_name].transform, "story_v_out_115311", "115311007", "story_v_out_115311.awb")

						arg_29_1:RecordAudio("115311007", var_32_9)
						arg_29_1:RecordAudio("115311007", var_32_9)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_115311", "115311007", "story_v_out_115311.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_115311", "115311007", "story_v_out_115311.awb")
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
	Play115311008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 115311008
		arg_33_1.duration_ = 9.17

		local var_33_0 = {
			ja = 8.2,
			ko = 7.533,
			zh = 9.166,
			en = 8.3
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
				arg_33_0:Play115311009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = 0
			local var_36_1 = 0.875

			if var_36_0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_0 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_2 = arg_33_1:FormatText(StoryNameCfg[105].name)

				arg_33_1.leftNameTxt_.text = var_36_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, true)
				arg_33_1.iconController_:SetSelectedState("hero")

				arg_33_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officeladyb")

				arg_33_1.callingController_:SetSelectedState("normal")

				arg_33_1.keyicon_.color = Color.New(1, 1, 1)
				arg_33_1.icon_.color = Color.New(1, 1, 1)

				local var_36_3 = arg_33_1:GetWordFromCfg(115311008)
				local var_36_4 = arg_33_1:FormatText(var_36_3.content)

				arg_33_1.text_.text = var_36_4

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_5 = 35
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

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311008", "story_v_out_115311.awb") ~= 0 then
					local var_36_8 = manager.audio:GetVoiceLength("story_v_out_115311", "115311008", "story_v_out_115311.awb") / 1000

					if var_36_8 + var_36_0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_8 + var_36_0
					end

					if var_36_3.prefab_name ~= "" and arg_33_1.actors_[var_36_3.prefab_name] ~= nil then
						local var_36_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_3.prefab_name].transform, "story_v_out_115311", "115311008", "story_v_out_115311.awb")

						arg_33_1:RecordAudio("115311008", var_36_9)
						arg_33_1:RecordAudio("115311008", var_36_9)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_115311", "115311008", "story_v_out_115311.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_115311", "115311008", "story_v_out_115311.awb")
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
	Play115311009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 115311009
		arg_37_1.duration_ = 9.53

		local var_37_0 = {
			ja = 9.3,
			ko = 9.533,
			zh = 9,
			en = 9.533
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
				arg_37_0:Play115311010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = 0
			local var_40_1 = 0.975

			if var_40_0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_0 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_2 = arg_37_1:FormatText(StoryNameCfg[104].name)

				arg_37_1.leftNameTxt_.text = var_40_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, true)
				arg_37_1.iconController_:SetSelectedState("hero")

				arg_37_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_woundedd")

				arg_37_1.callingController_:SetSelectedState("normal")

				arg_37_1.keyicon_.color = Color.New(1, 1, 1)
				arg_37_1.icon_.color = Color.New(1, 1, 1)

				local var_40_3 = arg_37_1:GetWordFromCfg(115311009)
				local var_40_4 = arg_37_1:FormatText(var_40_3.content)

				arg_37_1.text_.text = var_40_4

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_5 = 39
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

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311009", "story_v_out_115311.awb") ~= 0 then
					local var_40_8 = manager.audio:GetVoiceLength("story_v_out_115311", "115311009", "story_v_out_115311.awb") / 1000

					if var_40_8 + var_40_0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_8 + var_40_0
					end

					if var_40_3.prefab_name ~= "" and arg_37_1.actors_[var_40_3.prefab_name] ~= nil then
						local var_40_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_3.prefab_name].transform, "story_v_out_115311", "115311009", "story_v_out_115311.awb")

						arg_37_1:RecordAudio("115311009", var_40_9)
						arg_37_1:RecordAudio("115311009", var_40_9)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_115311", "115311009", "story_v_out_115311.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_115311", "115311009", "story_v_out_115311.awb")
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
	Play115311010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 115311010
		arg_41_1.duration_ = 11.4

		local var_41_0 = {
			ja = 8.7,
			ko = 10.766,
			zh = 8.8,
			en = 11.4
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
				arg_41_0:Play115311011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = 0
			local var_44_1 = 0.975

			if var_44_0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_0 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_2 = arg_41_1:FormatText(StoryNameCfg[104].name)

				arg_41_1.leftNameTxt_.text = var_44_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, true)
				arg_41_1.iconController_:SetSelectedState("hero")

				arg_41_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_woundedd")

				arg_41_1.callingController_:SetSelectedState("normal")

				arg_41_1.keyicon_.color = Color.New(1, 1, 1)
				arg_41_1.icon_.color = Color.New(1, 1, 1)

				local var_44_3 = arg_41_1:GetWordFromCfg(115311010)
				local var_44_4 = arg_41_1:FormatText(var_44_3.content)

				arg_41_1.text_.text = var_44_4

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_5 = 39
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

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311010", "story_v_out_115311.awb") ~= 0 then
					local var_44_8 = manager.audio:GetVoiceLength("story_v_out_115311", "115311010", "story_v_out_115311.awb") / 1000

					if var_44_8 + var_44_0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_8 + var_44_0
					end

					if var_44_3.prefab_name ~= "" and arg_41_1.actors_[var_44_3.prefab_name] ~= nil then
						local var_44_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_3.prefab_name].transform, "story_v_out_115311", "115311010", "story_v_out_115311.awb")

						arg_41_1:RecordAudio("115311010", var_44_9)
						arg_41_1:RecordAudio("115311010", var_44_9)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_115311", "115311010", "story_v_out_115311.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_115311", "115311010", "story_v_out_115311.awb")
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
	Play115311011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 115311011
		arg_45_1.duration_ = 5

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play115311012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = 0
			local var_48_1 = 1.125

			if var_48_0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_0 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, false)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_2 = arg_45_1:GetWordFromCfg(115311011)
				local var_48_3 = arg_45_1:FormatText(var_48_2.content)

				arg_45_1.text_.text = var_48_3

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_4 = 45
				local var_48_5 = utf8.len(var_48_3)
				local var_48_6 = var_48_4 <= 0 and var_48_1 or var_48_1 * (var_48_5 / var_48_4)

				if var_48_6 > 0 and var_48_1 < var_48_6 then
					arg_45_1.talkMaxDuration = var_48_6

					if var_48_6 + var_48_0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_6 + var_48_0
					end
				end

				arg_45_1.text_.text = var_48_3
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)
				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_7 = math.max(var_48_1, arg_45_1.talkMaxDuration)

			if var_48_0 <= arg_45_1.time_ and arg_45_1.time_ < var_48_0 + var_48_7 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_0) / var_48_7

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_0 + var_48_7 and arg_45_1.time_ < var_48_0 + var_48_7 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play115311012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 115311012
		arg_49_1.duration_ = 5

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play115311013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = 0
			local var_52_1 = 0.7

			if var_52_0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_0 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, false)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_2 = arg_49_1:GetWordFromCfg(115311012)
				local var_52_3 = arg_49_1:FormatText(var_52_2.content)

				arg_49_1.text_.text = var_52_3

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_4 = 28
				local var_52_5 = utf8.len(var_52_3)
				local var_52_6 = var_52_4 <= 0 and var_52_1 or var_52_1 * (var_52_5 / var_52_4)

				if var_52_6 > 0 and var_52_1 < var_52_6 then
					arg_49_1.talkMaxDuration = var_52_6

					if var_52_6 + var_52_0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_6 + var_52_0
					end
				end

				arg_49_1.text_.text = var_52_3
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)
				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_7 = math.max(var_52_1, arg_49_1.talkMaxDuration)

			if var_52_0 <= arg_49_1.time_ and arg_49_1.time_ < var_52_0 + var_52_7 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_0) / var_52_7

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_0 + var_52_7 and arg_49_1.time_ < var_52_0 + var_52_7 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play115311013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 115311013
		arg_53_1.duration_ = 4.57

		local var_53_0 = {
			ja = 3.5,
			ko = 4.566,
			zh = 3.7,
			en = 4.333
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
				arg_53_0:Play115311014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = manager.ui.mainCamera.transform
			local var_56_1 = 0

			if var_56_1 < arg_53_1.time_ and arg_53_1.time_ <= var_56_1 + arg_56_0 then
				arg_53_1.var_.shakeOldPos = var_56_0.localPosition
			end

			local var_56_2 = 0.6

			if var_56_1 <= arg_53_1.time_ and arg_53_1.time_ < var_56_1 + var_56_2 then
				local var_56_3 = (arg_53_1.time_ - var_56_1) / 0.066
				local var_56_4, var_56_5 = math.modf(var_56_3)

				var_56_0.localPosition = Vector3.New(var_56_5 * 0.13, var_56_5 * 0.13, var_56_5 * 0.13) + arg_53_1.var_.shakeOldPos
			end

			if arg_53_1.time_ >= var_56_1 + var_56_2 and arg_53_1.time_ < var_56_1 + var_56_2 + arg_56_0 then
				var_56_0.localPosition = arg_53_1.var_.shakeOldPos
			end

			local var_56_6 = 0
			local var_56_7 = 1

			if var_56_6 < arg_53_1.time_ and arg_53_1.time_ <= var_56_6 + arg_56_0 then
				local var_56_8 = "stop"
				local var_56_9 = "effect"

				arg_53_1:AudioAction(var_56_8, var_56_9, "se_story_activity_1_5_3", "se_story_activity_1_5_3_fireworks_loop", "")
			end

			local var_56_10 = 0

			if var_56_10 < arg_53_1.time_ and arg_53_1.time_ <= var_56_10 + arg_56_0 then
				arg_53_1.allBtn_.enabled = false
			end

			local var_56_11 = 0.6

			if arg_53_1.time_ >= var_56_10 + var_56_11 and arg_53_1.time_ < var_56_10 + var_56_11 + arg_56_0 then
				arg_53_1.allBtn_.enabled = true
			end

			local var_56_12 = 0
			local var_56_13 = 0.375

			if var_56_12 < arg_53_1.time_ and arg_53_1.time_ <= var_56_12 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_14 = arg_53_1:FormatText(StoryNameCfg[306].name)

				arg_53_1.leftNameTxt_.text = var_56_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_15 = arg_53_1:GetWordFromCfg(115311013)
				local var_56_16 = arg_53_1:FormatText(var_56_15.content)

				arg_53_1.text_.text = var_56_16

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_17 = 15
				local var_56_18 = utf8.len(var_56_16)
				local var_56_19 = var_56_17 <= 0 and var_56_13 or var_56_13 * (var_56_18 / var_56_17)

				if var_56_19 > 0 and var_56_13 < var_56_19 then
					arg_53_1.talkMaxDuration = var_56_19

					if var_56_19 + var_56_12 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_19 + var_56_12
					end
				end

				arg_53_1.text_.text = var_56_16
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311013", "story_v_out_115311.awb") ~= 0 then
					local var_56_20 = manager.audio:GetVoiceLength("story_v_out_115311", "115311013", "story_v_out_115311.awb") / 1000

					if var_56_20 + var_56_12 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_20 + var_56_12
					end

					if var_56_15.prefab_name ~= "" and arg_53_1.actors_[var_56_15.prefab_name] ~= nil then
						local var_56_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_15.prefab_name].transform, "story_v_out_115311", "115311013", "story_v_out_115311.awb")

						arg_53_1:RecordAudio("115311013", var_56_21)
						arg_53_1:RecordAudio("115311013", var_56_21)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_115311", "115311013", "story_v_out_115311.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_115311", "115311013", "story_v_out_115311.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_22 = math.max(var_56_13, arg_53_1.talkMaxDuration)

			if var_56_12 <= arg_53_1.time_ and arg_53_1.time_ < var_56_12 + var_56_22 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_12) / var_56_22

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_12 + var_56_22 and arg_53_1.time_ < var_56_12 + var_56_22 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play115311014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 115311014
		arg_57_1.duration_ = 4.3

		local var_57_0 = {
			ja = 3.366,
			ko = 4.3,
			zh = 2.733,
			en = 3.8
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
				arg_57_0:Play115311015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = manager.ui.mainCamera.transform
			local var_60_1 = 0

			if var_60_1 < arg_57_1.time_ and arg_57_1.time_ <= var_60_1 + arg_60_0 then
				arg_57_1.var_.shakeOldPos = var_60_0.localPosition
			end

			local var_60_2 = 0.6

			if var_60_1 <= arg_57_1.time_ and arg_57_1.time_ < var_60_1 + var_60_2 then
				local var_60_3 = (arg_57_1.time_ - var_60_1) / 0.066
				local var_60_4, var_60_5 = math.modf(var_60_3)

				var_60_0.localPosition = Vector3.New(var_60_5 * 0.13, var_60_5 * 0.13, var_60_5 * 0.13) + arg_57_1.var_.shakeOldPos
			end

			if arg_57_1.time_ >= var_60_1 + var_60_2 and arg_57_1.time_ < var_60_1 + var_60_2 + arg_60_0 then
				var_60_0.localPosition = arg_57_1.var_.shakeOldPos
			end

			local var_60_6 = 0

			if var_60_6 < arg_57_1.time_ and arg_57_1.time_ <= var_60_6 + arg_60_0 then
				arg_57_1.allBtn_.enabled = false
			end

			local var_60_7 = 0.6

			if arg_57_1.time_ >= var_60_6 + var_60_7 and arg_57_1.time_ < var_60_6 + var_60_7 + arg_60_0 then
				arg_57_1.allBtn_.enabled = true
			end

			local var_60_8 = 0
			local var_60_9 = 0.325

			if var_60_8 < arg_57_1.time_ and arg_57_1.time_ <= var_60_8 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_10 = arg_57_1:FormatText(StoryNameCfg[306].name)

				arg_57_1.leftNameTxt_.text = var_60_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_11 = arg_57_1:GetWordFromCfg(115311014)
				local var_60_12 = arg_57_1:FormatText(var_60_11.content)

				arg_57_1.text_.text = var_60_12

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_13 = 13
				local var_60_14 = utf8.len(var_60_12)
				local var_60_15 = var_60_13 <= 0 and var_60_9 or var_60_9 * (var_60_14 / var_60_13)

				if var_60_15 > 0 and var_60_9 < var_60_15 then
					arg_57_1.talkMaxDuration = var_60_15

					if var_60_15 + var_60_8 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_15 + var_60_8
					end
				end

				arg_57_1.text_.text = var_60_12
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311014", "story_v_out_115311.awb") ~= 0 then
					local var_60_16 = manager.audio:GetVoiceLength("story_v_out_115311", "115311014", "story_v_out_115311.awb") / 1000

					if var_60_16 + var_60_8 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_16 + var_60_8
					end

					if var_60_11.prefab_name ~= "" and arg_57_1.actors_[var_60_11.prefab_name] ~= nil then
						local var_60_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_11.prefab_name].transform, "story_v_out_115311", "115311014", "story_v_out_115311.awb")

						arg_57_1:RecordAudio("115311014", var_60_17)
						arg_57_1:RecordAudio("115311014", var_60_17)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_115311", "115311014", "story_v_out_115311.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_115311", "115311014", "story_v_out_115311.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_18 = math.max(var_60_9, arg_57_1.talkMaxDuration)

			if var_60_8 <= arg_57_1.time_ and arg_57_1.time_ < var_60_8 + var_60_18 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_8) / var_60_18

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_8 + var_60_18 and arg_57_1.time_ < var_60_8 + var_60_18 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play115311015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 115311015
		arg_61_1.duration_ = 5

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play115311016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = 0
			local var_64_1 = 1.575

			if var_64_0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_0 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, false)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_2 = arg_61_1:GetWordFromCfg(115311015)
				local var_64_3 = arg_61_1:FormatText(var_64_2.content)

				arg_61_1.text_.text = var_64_3

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_4 = 63
				local var_64_5 = utf8.len(var_64_3)
				local var_64_6 = var_64_4 <= 0 and var_64_1 or var_64_1 * (var_64_5 / var_64_4)

				if var_64_6 > 0 and var_64_1 < var_64_6 then
					arg_61_1.talkMaxDuration = var_64_6

					if var_64_6 + var_64_0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_6 + var_64_0
					end
				end

				arg_61_1.text_.text = var_64_3
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)
				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_7 = math.max(var_64_1, arg_61_1.talkMaxDuration)

			if var_64_0 <= arg_61_1.time_ and arg_61_1.time_ < var_64_0 + var_64_7 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_0) / var_64_7

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_0 + var_64_7 and arg_61_1.time_ < var_64_0 + var_64_7 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play115311016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 115311016
		arg_65_1.duration_ = 5

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play115311017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = 0
			local var_68_1 = 0.575

			if var_68_0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_0 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, false)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_2 = arg_65_1:GetWordFromCfg(115311016)
				local var_68_3 = arg_65_1:FormatText(var_68_2.content)

				arg_65_1.text_.text = var_68_3

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_4 = 23
				local var_68_5 = utf8.len(var_68_3)
				local var_68_6 = var_68_4 <= 0 and var_68_1 or var_68_1 * (var_68_5 / var_68_4)

				if var_68_6 > 0 and var_68_1 < var_68_6 then
					arg_65_1.talkMaxDuration = var_68_6

					if var_68_6 + var_68_0 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_6 + var_68_0
					end
				end

				arg_65_1.text_.text = var_68_3
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)
				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_7 = math.max(var_68_1, arg_65_1.talkMaxDuration)

			if var_68_0 <= arg_65_1.time_ and arg_65_1.time_ < var_68_0 + var_68_7 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_0) / var_68_7

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_0 + var_68_7 and arg_65_1.time_ < var_68_0 + var_68_7 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play115311017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 115311017
		arg_69_1.duration_ = 5.27

		local var_69_0 = {
			ja = 5.266,
			ko = 4.2,
			zh = 5.1,
			en = 4.4
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
				arg_69_0:Play115311018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = 0
			local var_72_1 = 0.525

			if var_72_0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_0 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				local var_72_2 = arg_69_1:FormatText(StoryNameCfg[104].name)

				arg_69_1.leftNameTxt_.text = var_72_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, true)
				arg_69_1.iconController_:SetSelectedState("hero")

				arg_69_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_woundedd")

				arg_69_1.callingController_:SetSelectedState("normal")

				arg_69_1.keyicon_.color = Color.New(1, 1, 1)
				arg_69_1.icon_.color = Color.New(1, 1, 1)

				local var_72_3 = arg_69_1:GetWordFromCfg(115311017)
				local var_72_4 = arg_69_1:FormatText(var_72_3.content)

				arg_69_1.text_.text = var_72_4

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_5 = 21
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

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311017", "story_v_out_115311.awb") ~= 0 then
					local var_72_8 = manager.audio:GetVoiceLength("story_v_out_115311", "115311017", "story_v_out_115311.awb") / 1000

					if var_72_8 + var_72_0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_8 + var_72_0
					end

					if var_72_3.prefab_name ~= "" and arg_69_1.actors_[var_72_3.prefab_name] ~= nil then
						local var_72_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_3.prefab_name].transform, "story_v_out_115311", "115311017", "story_v_out_115311.awb")

						arg_69_1:RecordAudio("115311017", var_72_9)
						arg_69_1:RecordAudio("115311017", var_72_9)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_115311", "115311017", "story_v_out_115311.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_115311", "115311017", "story_v_out_115311.awb")
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
	Play115311018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 115311018
		arg_73_1.duration_ = 5

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play115311019(arg_73_1)
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

				local var_76_2 = arg_73_1:GetWordFromCfg(115311018)
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
	Play115311019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 115311019
		arg_77_1.duration_ = 3.3

		local var_77_0 = {
			ja = 3.3,
			ko = 2.2,
			zh = 2.166,
			en = 2.2
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
				arg_77_0:Play115311020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = "10030"

			if arg_77_1.actors_[var_80_0] == nil then
				local var_80_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10030")

				if not isNil(var_80_1) then
					local var_80_2 = Object.Instantiate(var_80_1, arg_77_1.canvasGo_.transform)

					var_80_2.transform:SetSiblingIndex(1)

					var_80_2.name = var_80_0
					var_80_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_77_1.actors_[var_80_0] = var_80_2

					local var_80_3 = var_80_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_77_1.isInRecall_ then
						for iter_80_0, iter_80_1 in ipairs(var_80_3) do
							iter_80_1.color = arg_77_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_80_4 = arg_77_1.actors_["10030"].transform
			local var_80_5 = 0

			if var_80_5 < arg_77_1.time_ and arg_77_1.time_ <= var_80_5 + arg_80_0 then
				arg_77_1.var_.moveOldPos10030 = var_80_4.localPosition
				var_80_4.localScale = Vector3.New(1, 1, 1)

				arg_77_1:CheckSpriteTmpPos("10030", 3)

				local var_80_6 = var_80_4.childCount

				for iter_80_2 = 0, var_80_6 - 1 do
					local var_80_7 = var_80_4:GetChild(iter_80_2)

					if var_80_7.name == "split_2" or not string.find(var_80_7.name, "split") then
						var_80_7.gameObject:SetActive(true)
					else
						var_80_7.gameObject:SetActive(false)
					end
				end
			end

			local var_80_8 = 0.001

			if var_80_5 <= arg_77_1.time_ and arg_77_1.time_ < var_80_5 + var_80_8 then
				local var_80_9 = (arg_77_1.time_ - var_80_5) / var_80_8
				local var_80_10 = Vector3.New(0, -390, 150)

				var_80_4.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos10030, var_80_10, var_80_9)
			end

			if arg_77_1.time_ >= var_80_5 + var_80_8 and arg_77_1.time_ < var_80_5 + var_80_8 + arg_80_0 then
				var_80_4.localPosition = Vector3.New(0, -390, 150)
			end

			local var_80_11 = arg_77_1.actors_["10030"]
			local var_80_12 = 0

			if var_80_12 < arg_77_1.time_ and arg_77_1.time_ <= var_80_12 + arg_80_0 then
				local var_80_13 = var_80_11:GetComponentInChildren(typeof(CanvasGroup))

				if var_80_13 then
					arg_77_1.var_.alphaOldValue10030 = var_80_13.alpha
					arg_77_1.var_.characterEffect10030 = var_80_13
				end

				arg_77_1.var_.alphaOldValue10030 = 0
			end

			local var_80_14 = 0.5

			if var_80_12 <= arg_77_1.time_ and arg_77_1.time_ < var_80_12 + var_80_14 then
				local var_80_15 = (arg_77_1.time_ - var_80_12) / var_80_14
				local var_80_16 = Mathf.Lerp(arg_77_1.var_.alphaOldValue10030, 1, var_80_15)

				if arg_77_1.var_.characterEffect10030 then
					arg_77_1.var_.characterEffect10030.alpha = var_80_16
				end
			end

			if arg_77_1.time_ >= var_80_12 + var_80_14 and arg_77_1.time_ < var_80_12 + var_80_14 + arg_80_0 and arg_77_1.var_.characterEffect10030 then
				arg_77_1.var_.characterEffect10030.alpha = 1
			end

			local var_80_17 = arg_77_1.actors_["10030"]
			local var_80_18 = 0

			if var_80_18 < arg_77_1.time_ and arg_77_1.time_ <= var_80_18 + arg_80_0 and not isNil(var_80_17) and arg_77_1.var_.actorSpriteComps10030 == nil then
				arg_77_1.var_.actorSpriteComps10030 = var_80_17:GetComponentsInChildren(typeof(Image), true)
			end

			local var_80_19 = 0.2

			if var_80_18 <= arg_77_1.time_ and arg_77_1.time_ < var_80_18 + var_80_19 and not isNil(var_80_17) then
				local var_80_20 = (arg_77_1.time_ - var_80_18) / var_80_19

				if arg_77_1.var_.actorSpriteComps10030 then
					for iter_80_3, iter_80_4 in pairs(arg_77_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_80_4 then
							if arg_77_1.isInRecall_ then
								local var_80_21 = Mathf.Lerp(iter_80_4.color.r, arg_77_1.hightColor1.r, var_80_20)
								local var_80_22 = Mathf.Lerp(iter_80_4.color.g, arg_77_1.hightColor1.g, var_80_20)
								local var_80_23 = Mathf.Lerp(iter_80_4.color.b, arg_77_1.hightColor1.b, var_80_20)

								iter_80_4.color = Color.New(var_80_21, var_80_22, var_80_23)
							else
								local var_80_24 = Mathf.Lerp(iter_80_4.color.r, 1, var_80_20)

								iter_80_4.color = Color.New(var_80_24, var_80_24, var_80_24)
							end
						end
					end
				end
			end

			if arg_77_1.time_ >= var_80_18 + var_80_19 and arg_77_1.time_ < var_80_18 + var_80_19 + arg_80_0 and not isNil(var_80_17) and arg_77_1.var_.actorSpriteComps10030 then
				for iter_80_5, iter_80_6 in pairs(arg_77_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_80_6 then
						if arg_77_1.isInRecall_ then
							iter_80_6.color = arg_77_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_80_6.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_77_1.var_.actorSpriteComps10030 = nil
			end

			local var_80_25 = 0
			local var_80_26 = 0.175

			if var_80_25 < arg_77_1.time_ and arg_77_1.time_ <= var_80_25 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				local var_80_27 = arg_77_1:FormatText(StoryNameCfg[309].name)

				arg_77_1.leftNameTxt_.text = var_80_27

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_28 = arg_77_1:GetWordFromCfg(115311019)
				local var_80_29 = arg_77_1:FormatText(var_80_28.content)

				arg_77_1.text_.text = var_80_29

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_30 = 7
				local var_80_31 = utf8.len(var_80_29)
				local var_80_32 = var_80_30 <= 0 and var_80_26 or var_80_26 * (var_80_31 / var_80_30)

				if var_80_32 > 0 and var_80_26 < var_80_32 then
					arg_77_1.talkMaxDuration = var_80_32

					if var_80_32 + var_80_25 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_32 + var_80_25
					end
				end

				arg_77_1.text_.text = var_80_29
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311019", "story_v_out_115311.awb") ~= 0 then
					local var_80_33 = manager.audio:GetVoiceLength("story_v_out_115311", "115311019", "story_v_out_115311.awb") / 1000

					if var_80_33 + var_80_25 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_33 + var_80_25
					end

					if var_80_28.prefab_name ~= "" and arg_77_1.actors_[var_80_28.prefab_name] ~= nil then
						local var_80_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_28.prefab_name].transform, "story_v_out_115311", "115311019", "story_v_out_115311.awb")

						arg_77_1:RecordAudio("115311019", var_80_34)
						arg_77_1:RecordAudio("115311019", var_80_34)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_115311", "115311019", "story_v_out_115311.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_115311", "115311019", "story_v_out_115311.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_35 = math.max(var_80_26, arg_77_1.talkMaxDuration)

			if var_80_25 <= arg_77_1.time_ and arg_77_1.time_ < var_80_25 + var_80_35 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_25) / var_80_35

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_25 + var_80_35 and arg_77_1.time_ < var_80_25 + var_80_35 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10030",
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
	Play115311020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 115311020
		arg_81_1.duration_ = 4.97

		local var_81_0 = {
			ja = 4.966,
			ko = 4.966,
			zh = 4.2,
			en = 4.933
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
				arg_81_0:Play115311021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = arg_81_1.actors_["10030"]
			local var_84_1 = 0

			if var_84_1 < arg_81_1.time_ and arg_81_1.time_ <= var_84_1 + arg_84_0 and not isNil(var_84_0) and arg_81_1.var_.actorSpriteComps10030 == nil then
				arg_81_1.var_.actorSpriteComps10030 = var_84_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_84_2 = 0.2

			if var_84_1 <= arg_81_1.time_ and arg_81_1.time_ < var_84_1 + var_84_2 and not isNil(var_84_0) then
				local var_84_3 = (arg_81_1.time_ - var_84_1) / var_84_2

				if arg_81_1.var_.actorSpriteComps10030 then
					for iter_84_0, iter_84_1 in pairs(arg_81_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_84_1 then
							if arg_81_1.isInRecall_ then
								local var_84_4 = Mathf.Lerp(iter_84_1.color.r, arg_81_1.hightColor2.r, var_84_3)
								local var_84_5 = Mathf.Lerp(iter_84_1.color.g, arg_81_1.hightColor2.g, var_84_3)
								local var_84_6 = Mathf.Lerp(iter_84_1.color.b, arg_81_1.hightColor2.b, var_84_3)

								iter_84_1.color = Color.New(var_84_4, var_84_5, var_84_6)
							else
								local var_84_7 = Mathf.Lerp(iter_84_1.color.r, 0.5, var_84_3)

								iter_84_1.color = Color.New(var_84_7, var_84_7, var_84_7)
							end
						end
					end
				end
			end

			if arg_81_1.time_ >= var_84_1 + var_84_2 and arg_81_1.time_ < var_84_1 + var_84_2 + arg_84_0 and not isNil(var_84_0) and arg_81_1.var_.actorSpriteComps10030 then
				for iter_84_2, iter_84_3 in pairs(arg_81_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_84_3 then
						if arg_81_1.isInRecall_ then
							iter_84_3.color = arg_81_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_84_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_81_1.var_.actorSpriteComps10030 = nil
			end

			local var_84_8 = 0
			local var_84_9 = 0.525

			if var_84_8 < arg_81_1.time_ and arg_81_1.time_ <= var_84_8 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				local var_84_10 = arg_81_1:FormatText(StoryNameCfg[104].name)

				arg_81_1.leftNameTxt_.text = var_84_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, true)
				arg_81_1.iconController_:SetSelectedState("hero")

				arg_81_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_woundedd")

				arg_81_1.callingController_:SetSelectedState("normal")

				arg_81_1.keyicon_.color = Color.New(1, 1, 1)
				arg_81_1.icon_.color = Color.New(1, 1, 1)

				local var_84_11 = arg_81_1:GetWordFromCfg(115311020)
				local var_84_12 = arg_81_1:FormatText(var_84_11.content)

				arg_81_1.text_.text = var_84_12

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_13 = 21
				local var_84_14 = utf8.len(var_84_12)
				local var_84_15 = var_84_13 <= 0 and var_84_9 or var_84_9 * (var_84_14 / var_84_13)

				if var_84_15 > 0 and var_84_9 < var_84_15 then
					arg_81_1.talkMaxDuration = var_84_15

					if var_84_15 + var_84_8 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_15 + var_84_8
					end
				end

				arg_81_1.text_.text = var_84_12
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311020", "story_v_out_115311.awb") ~= 0 then
					local var_84_16 = manager.audio:GetVoiceLength("story_v_out_115311", "115311020", "story_v_out_115311.awb") / 1000

					if var_84_16 + var_84_8 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_16 + var_84_8
					end

					if var_84_11.prefab_name ~= "" and arg_81_1.actors_[var_84_11.prefab_name] ~= nil then
						local var_84_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_11.prefab_name].transform, "story_v_out_115311", "115311020", "story_v_out_115311.awb")

						arg_81_1:RecordAudio("115311020", var_84_17)
						arg_81_1:RecordAudio("115311020", var_84_17)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_115311", "115311020", "story_v_out_115311.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_115311", "115311020", "story_v_out_115311.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_18 = math.max(var_84_9, arg_81_1.talkMaxDuration)

			if var_84_8 <= arg_81_1.time_ and arg_81_1.time_ < var_84_8 + var_84_18 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_8) / var_84_18

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_8 + var_84_18 and arg_81_1.time_ < var_84_8 + var_84_18 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play115311021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 115311021
		arg_85_1.duration_ = 2.37

		local var_85_0 = {
			ja = 1.6,
			ko = 1.866,
			zh = 2.366,
			en = 1.9
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
				arg_85_0:Play115311022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = 0
			local var_88_1 = 0.175

			if var_88_0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_0 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				local var_88_2 = arg_85_1:FormatText(StoryNameCfg[105].name)

				arg_85_1.leftNameTxt_.text = var_88_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, true)
				arg_85_1.iconController_:SetSelectedState("hero")

				arg_85_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officeladyb")

				arg_85_1.callingController_:SetSelectedState("normal")

				arg_85_1.keyicon_.color = Color.New(1, 1, 1)
				arg_85_1.icon_.color = Color.New(1, 1, 1)

				local var_88_3 = arg_85_1:GetWordFromCfg(115311021)
				local var_88_4 = arg_85_1:FormatText(var_88_3.content)

				arg_85_1.text_.text = var_88_4

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_5 = 7
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

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311021", "story_v_out_115311.awb") ~= 0 then
					local var_88_8 = manager.audio:GetVoiceLength("story_v_out_115311", "115311021", "story_v_out_115311.awb") / 1000

					if var_88_8 + var_88_0 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_8 + var_88_0
					end

					if var_88_3.prefab_name ~= "" and arg_85_1.actors_[var_88_3.prefab_name] ~= nil then
						local var_88_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_3.prefab_name].transform, "story_v_out_115311", "115311021", "story_v_out_115311.awb")

						arg_85_1:RecordAudio("115311021", var_88_9)
						arg_85_1:RecordAudio("115311021", var_88_9)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_115311", "115311021", "story_v_out_115311.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_115311", "115311021", "story_v_out_115311.awb")
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
	Play115311022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 115311022
		arg_89_1.duration_ = 4.4

		local var_89_0 = {
			ja = 3.866,
			ko = 3.9,
			zh = 4.4,
			en = 4.366
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
				arg_89_0:Play115311023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = arg_89_1.actors_["10030"].transform
			local var_92_1 = 0

			if var_92_1 < arg_89_1.time_ and arg_89_1.time_ <= var_92_1 + arg_92_0 then
				arg_89_1.var_.moveOldPos10030 = var_92_0.localPosition
				var_92_0.localScale = Vector3.New(1, 1, 1)

				arg_89_1:CheckSpriteTmpPos("10030", 3)

				local var_92_2 = var_92_0.childCount

				for iter_92_0 = 0, var_92_2 - 1 do
					local var_92_3 = var_92_0:GetChild(iter_92_0)

					if var_92_3.name == "split_3" or not string.find(var_92_3.name, "split") then
						var_92_3.gameObject:SetActive(true)
					else
						var_92_3.gameObject:SetActive(false)
					end
				end
			end

			local var_92_4 = 0.001

			if var_92_1 <= arg_89_1.time_ and arg_89_1.time_ < var_92_1 + var_92_4 then
				local var_92_5 = (arg_89_1.time_ - var_92_1) / var_92_4
				local var_92_6 = Vector3.New(0, -390, 150)

				var_92_0.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos10030, var_92_6, var_92_5)
			end

			if arg_89_1.time_ >= var_92_1 + var_92_4 and arg_89_1.time_ < var_92_1 + var_92_4 + arg_92_0 then
				var_92_0.localPosition = Vector3.New(0, -390, 150)
			end

			local var_92_7 = arg_89_1.actors_["10030"]
			local var_92_8 = 0

			if var_92_8 < arg_89_1.time_ and arg_89_1.time_ <= var_92_8 + arg_92_0 and not isNil(var_92_7) and arg_89_1.var_.actorSpriteComps10030 == nil then
				arg_89_1.var_.actorSpriteComps10030 = var_92_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_92_9 = 0.2

			if var_92_8 <= arg_89_1.time_ and arg_89_1.time_ < var_92_8 + var_92_9 and not isNil(var_92_7) then
				local var_92_10 = (arg_89_1.time_ - var_92_8) / var_92_9

				if arg_89_1.var_.actorSpriteComps10030 then
					for iter_92_1, iter_92_2 in pairs(arg_89_1.var_.actorSpriteComps10030:ToTable()) do
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

			if arg_89_1.time_ >= var_92_8 + var_92_9 and arg_89_1.time_ < var_92_8 + var_92_9 + arg_92_0 and not isNil(var_92_7) and arg_89_1.var_.actorSpriteComps10030 then
				for iter_92_3, iter_92_4 in pairs(arg_89_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_92_4 then
						if arg_89_1.isInRecall_ then
							iter_92_4.color = arg_89_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_92_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_89_1.var_.actorSpriteComps10030 = nil
			end

			local var_92_15 = 0
			local var_92_16 = 0.3

			if var_92_15 < arg_89_1.time_ and arg_89_1.time_ <= var_92_15 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				local var_92_17 = arg_89_1:FormatText(StoryNameCfg[309].name)

				arg_89_1.leftNameTxt_.text = var_92_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_18 = arg_89_1:GetWordFromCfg(115311022)
				local var_92_19 = arg_89_1:FormatText(var_92_18.content)

				arg_89_1.text_.text = var_92_19

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_20 = 12
				local var_92_21 = utf8.len(var_92_19)
				local var_92_22 = var_92_20 <= 0 and var_92_16 or var_92_16 * (var_92_21 / var_92_20)

				if var_92_22 > 0 and var_92_16 < var_92_22 then
					arg_89_1.talkMaxDuration = var_92_22

					if var_92_22 + var_92_15 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_22 + var_92_15
					end
				end

				arg_89_1.text_.text = var_92_19
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311022", "story_v_out_115311.awb") ~= 0 then
					local var_92_23 = manager.audio:GetVoiceLength("story_v_out_115311", "115311022", "story_v_out_115311.awb") / 1000

					if var_92_23 + var_92_15 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_23 + var_92_15
					end

					if var_92_18.prefab_name ~= "" and arg_89_1.actors_[var_92_18.prefab_name] ~= nil then
						local var_92_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_18.prefab_name].transform, "story_v_out_115311", "115311022", "story_v_out_115311.awb")

						arg_89_1:RecordAudio("115311022", var_92_24)
						arg_89_1:RecordAudio("115311022", var_92_24)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_115311", "115311022", "story_v_out_115311.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_115311", "115311022", "story_v_out_115311.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_25 = math.max(var_92_16, arg_89_1.talkMaxDuration)

			if var_92_15 <= arg_89_1.time_ and arg_89_1.time_ < var_92_15 + var_92_25 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_15) / var_92_25

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_15 + var_92_25 and arg_89_1.time_ < var_92_15 + var_92_25 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10030",
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
	Play115311023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 115311023
		arg_93_1.duration_ = 5

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play115311024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = arg_93_1.actors_["10030"]
			local var_96_1 = 0

			if var_96_1 < arg_93_1.time_ and arg_93_1.time_ <= var_96_1 + arg_96_0 and not isNil(var_96_0) and arg_93_1.var_.actorSpriteComps10030 == nil then
				arg_93_1.var_.actorSpriteComps10030 = var_96_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_96_2 = 0.2

			if var_96_1 <= arg_93_1.time_ and arg_93_1.time_ < var_96_1 + var_96_2 and not isNil(var_96_0) then
				local var_96_3 = (arg_93_1.time_ - var_96_1) / var_96_2

				if arg_93_1.var_.actorSpriteComps10030 then
					for iter_96_0, iter_96_1 in pairs(arg_93_1.var_.actorSpriteComps10030:ToTable()) do
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

			if arg_93_1.time_ >= var_96_1 + var_96_2 and arg_93_1.time_ < var_96_1 + var_96_2 + arg_96_0 and not isNil(var_96_0) and arg_93_1.var_.actorSpriteComps10030 then
				for iter_96_2, iter_96_3 in pairs(arg_93_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_96_3 then
						if arg_93_1.isInRecall_ then
							iter_96_3.color = arg_93_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_96_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_93_1.var_.actorSpriteComps10030 = nil
			end

			local var_96_8 = 0
			local var_96_9 = 0.8

			if var_96_8 < arg_93_1.time_ and arg_93_1.time_ <= var_96_8 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, false)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_10 = arg_93_1:GetWordFromCfg(115311023)
				local var_96_11 = arg_93_1:FormatText(var_96_10.content)

				arg_93_1.text_.text = var_96_11

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_12 = 32
				local var_96_13 = utf8.len(var_96_11)
				local var_96_14 = var_96_12 <= 0 and var_96_9 or var_96_9 * (var_96_13 / var_96_12)

				if var_96_14 > 0 and var_96_9 < var_96_14 then
					arg_93_1.talkMaxDuration = var_96_14

					if var_96_14 + var_96_8 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_14 + var_96_8
					end
				end

				arg_93_1.text_.text = var_96_11
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)
				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_15 = math.max(var_96_9, arg_93_1.talkMaxDuration)

			if var_96_8 <= arg_93_1.time_ and arg_93_1.time_ < var_96_8 + var_96_15 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_8) / var_96_15

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_8 + var_96_15 and arg_93_1.time_ < var_96_8 + var_96_15 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play115311024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 115311024
		arg_97_1.duration_ = 10.73

		local var_97_0 = {
			ja = 10.2,
			ko = 7.7,
			zh = 7.033,
			en = 10.733
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
				arg_97_0:Play115311025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = arg_97_1.actors_["10030"].transform
			local var_100_1 = 0

			if var_100_1 < arg_97_1.time_ and arg_97_1.time_ <= var_100_1 + arg_100_0 then
				arg_97_1.var_.moveOldPos10030 = var_100_0.localPosition
				var_100_0.localScale = Vector3.New(1, 1, 1)

				arg_97_1:CheckSpriteTmpPos("10030", 3)

				local var_100_2 = var_100_0.childCount

				for iter_100_0 = 0, var_100_2 - 1 do
					local var_100_3 = var_100_0:GetChild(iter_100_0)

					if var_100_3.name == "split_2" or not string.find(var_100_3.name, "split") then
						var_100_3.gameObject:SetActive(true)
					else
						var_100_3.gameObject:SetActive(false)
					end
				end
			end

			local var_100_4 = 0.001

			if var_100_1 <= arg_97_1.time_ and arg_97_1.time_ < var_100_1 + var_100_4 then
				local var_100_5 = (arg_97_1.time_ - var_100_1) / var_100_4
				local var_100_6 = Vector3.New(0, -390, 150)

				var_100_0.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos10030, var_100_6, var_100_5)
			end

			if arg_97_1.time_ >= var_100_1 + var_100_4 and arg_97_1.time_ < var_100_1 + var_100_4 + arg_100_0 then
				var_100_0.localPosition = Vector3.New(0, -390, 150)
			end

			local var_100_7 = arg_97_1.actors_["10030"]
			local var_100_8 = 0

			if var_100_8 < arg_97_1.time_ and arg_97_1.time_ <= var_100_8 + arg_100_0 and not isNil(var_100_7) and arg_97_1.var_.actorSpriteComps10030 == nil then
				arg_97_1.var_.actorSpriteComps10030 = var_100_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_100_9 = 0.2

			if var_100_8 <= arg_97_1.time_ and arg_97_1.time_ < var_100_8 + var_100_9 and not isNil(var_100_7) then
				local var_100_10 = (arg_97_1.time_ - var_100_8) / var_100_9

				if arg_97_1.var_.actorSpriteComps10030 then
					for iter_100_1, iter_100_2 in pairs(arg_97_1.var_.actorSpriteComps10030:ToTable()) do
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

			if arg_97_1.time_ >= var_100_8 + var_100_9 and arg_97_1.time_ < var_100_8 + var_100_9 + arg_100_0 and not isNil(var_100_7) and arg_97_1.var_.actorSpriteComps10030 then
				for iter_100_3, iter_100_4 in pairs(arg_97_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_100_4 then
						if arg_97_1.isInRecall_ then
							iter_100_4.color = arg_97_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_100_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_97_1.var_.actorSpriteComps10030 = nil
			end

			local var_100_15 = 0
			local var_100_16 = 0.75

			if var_100_15 < arg_97_1.time_ and arg_97_1.time_ <= var_100_15 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				local var_100_17 = arg_97_1:FormatText(StoryNameCfg[309].name)

				arg_97_1.leftNameTxt_.text = var_100_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_18 = arg_97_1:GetWordFromCfg(115311024)
				local var_100_19 = arg_97_1:FormatText(var_100_18.content)

				arg_97_1.text_.text = var_100_19

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_20 = 29
				local var_100_21 = utf8.len(var_100_19)
				local var_100_22 = var_100_20 <= 0 and var_100_16 or var_100_16 * (var_100_21 / var_100_20)

				if var_100_22 > 0 and var_100_16 < var_100_22 then
					arg_97_1.talkMaxDuration = var_100_22

					if var_100_22 + var_100_15 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_22 + var_100_15
					end
				end

				arg_97_1.text_.text = var_100_19
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311024", "story_v_out_115311.awb") ~= 0 then
					local var_100_23 = manager.audio:GetVoiceLength("story_v_out_115311", "115311024", "story_v_out_115311.awb") / 1000

					if var_100_23 + var_100_15 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_23 + var_100_15
					end

					if var_100_18.prefab_name ~= "" and arg_97_1.actors_[var_100_18.prefab_name] ~= nil then
						local var_100_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_18.prefab_name].transform, "story_v_out_115311", "115311024", "story_v_out_115311.awb")

						arg_97_1:RecordAudio("115311024", var_100_24)
						arg_97_1:RecordAudio("115311024", var_100_24)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_115311", "115311024", "story_v_out_115311.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_115311", "115311024", "story_v_out_115311.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_25 = math.max(var_100_16, arg_97_1.talkMaxDuration)

			if var_100_15 <= arg_97_1.time_ and arg_97_1.time_ < var_100_15 + var_100_25 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_15) / var_100_25

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_15 + var_100_25 and arg_97_1.time_ < var_100_15 + var_100_25 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10030",
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
	Play115311025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 115311025
		arg_101_1.duration_ = 2.47

		local var_101_0 = {
			ja = 1.333,
			ko = 2.466,
			zh = 2.066,
			en = 2.1
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
				arg_101_0:Play115311026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = arg_101_1.actors_["10030"]
			local var_104_1 = 0

			if var_104_1 < arg_101_1.time_ and arg_101_1.time_ <= var_104_1 + arg_104_0 and not isNil(var_104_0) and arg_101_1.var_.actorSpriteComps10030 == nil then
				arg_101_1.var_.actorSpriteComps10030 = var_104_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_104_2 = 0.2

			if var_104_1 <= arg_101_1.time_ and arg_101_1.time_ < var_104_1 + var_104_2 and not isNil(var_104_0) then
				local var_104_3 = (arg_101_1.time_ - var_104_1) / var_104_2

				if arg_101_1.var_.actorSpriteComps10030 then
					for iter_104_0, iter_104_1 in pairs(arg_101_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_104_1 then
							if arg_101_1.isInRecall_ then
								local var_104_4 = Mathf.Lerp(iter_104_1.color.r, arg_101_1.hightColor2.r, var_104_3)
								local var_104_5 = Mathf.Lerp(iter_104_1.color.g, arg_101_1.hightColor2.g, var_104_3)
								local var_104_6 = Mathf.Lerp(iter_104_1.color.b, arg_101_1.hightColor2.b, var_104_3)

								iter_104_1.color = Color.New(var_104_4, var_104_5, var_104_6)
							else
								local var_104_7 = Mathf.Lerp(iter_104_1.color.r, 0.5, var_104_3)

								iter_104_1.color = Color.New(var_104_7, var_104_7, var_104_7)
							end
						end
					end
				end
			end

			if arg_101_1.time_ >= var_104_1 + var_104_2 and arg_101_1.time_ < var_104_1 + var_104_2 + arg_104_0 and not isNil(var_104_0) and arg_101_1.var_.actorSpriteComps10030 then
				for iter_104_2, iter_104_3 in pairs(arg_101_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_104_3 then
						if arg_101_1.isInRecall_ then
							iter_104_3.color = arg_101_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_104_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_101_1.var_.actorSpriteComps10030 = nil
			end

			local var_104_8 = 0
			local var_104_9 = 0.275

			if var_104_8 < arg_101_1.time_ and arg_101_1.time_ <= var_104_8 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				local var_104_10 = arg_101_1:FormatText(StoryNameCfg[105].name)

				arg_101_1.leftNameTxt_.text = var_104_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, true)
				arg_101_1.iconController_:SetSelectedState("hero")

				arg_101_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officeladyb")

				arg_101_1.callingController_:SetSelectedState("normal")

				arg_101_1.keyicon_.color = Color.New(1, 1, 1)
				arg_101_1.icon_.color = Color.New(1, 1, 1)

				local var_104_11 = arg_101_1:GetWordFromCfg(115311025)
				local var_104_12 = arg_101_1:FormatText(var_104_11.content)

				arg_101_1.text_.text = var_104_12

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_13 = 11
				local var_104_14 = utf8.len(var_104_12)
				local var_104_15 = var_104_13 <= 0 and var_104_9 or var_104_9 * (var_104_14 / var_104_13)

				if var_104_15 > 0 and var_104_9 < var_104_15 then
					arg_101_1.talkMaxDuration = var_104_15

					if var_104_15 + var_104_8 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_15 + var_104_8
					end
				end

				arg_101_1.text_.text = var_104_12
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311025", "story_v_out_115311.awb") ~= 0 then
					local var_104_16 = manager.audio:GetVoiceLength("story_v_out_115311", "115311025", "story_v_out_115311.awb") / 1000

					if var_104_16 + var_104_8 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_16 + var_104_8
					end

					if var_104_11.prefab_name ~= "" and arg_101_1.actors_[var_104_11.prefab_name] ~= nil then
						local var_104_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_11.prefab_name].transform, "story_v_out_115311", "115311025", "story_v_out_115311.awb")

						arg_101_1:RecordAudio("115311025", var_104_17)
						arg_101_1:RecordAudio("115311025", var_104_17)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_115311", "115311025", "story_v_out_115311.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_115311", "115311025", "story_v_out_115311.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_18 = math.max(var_104_9, arg_101_1.talkMaxDuration)

			if var_104_8 <= arg_101_1.time_ and arg_101_1.time_ < var_104_8 + var_104_18 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_8) / var_104_18

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_8 + var_104_18 and arg_101_1.time_ < var_104_8 + var_104_18 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play115311026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 115311026
		arg_105_1.duration_ = 10.2

		local var_105_0 = {
			ja = 9.566,
			ko = 10.2,
			zh = 7.8,
			en = 9.866
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
				arg_105_0:Play115311027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = 0
			local var_108_1 = 1.025

			if var_108_0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_0 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				local var_108_2 = arg_105_1:FormatText(StoryNameCfg[105].name)

				arg_105_1.leftNameTxt_.text = var_108_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, true)
				arg_105_1.iconController_:SetSelectedState("hero")

				arg_105_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officeladyb")

				arg_105_1.callingController_:SetSelectedState("normal")

				arg_105_1.keyicon_.color = Color.New(1, 1, 1)
				arg_105_1.icon_.color = Color.New(1, 1, 1)

				local var_108_3 = arg_105_1:GetWordFromCfg(115311026)
				local var_108_4 = arg_105_1:FormatText(var_108_3.content)

				arg_105_1.text_.text = var_108_4

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_5 = 41
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

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311026", "story_v_out_115311.awb") ~= 0 then
					local var_108_8 = manager.audio:GetVoiceLength("story_v_out_115311", "115311026", "story_v_out_115311.awb") / 1000

					if var_108_8 + var_108_0 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_8 + var_108_0
					end

					if var_108_3.prefab_name ~= "" and arg_105_1.actors_[var_108_3.prefab_name] ~= nil then
						local var_108_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_3.prefab_name].transform, "story_v_out_115311", "115311026", "story_v_out_115311.awb")

						arg_105_1:RecordAudio("115311026", var_108_9)
						arg_105_1:RecordAudio("115311026", var_108_9)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_115311", "115311026", "story_v_out_115311.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_115311", "115311026", "story_v_out_115311.awb")
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
	Play115311027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 115311027
		arg_109_1.duration_ = 8.93

		local var_109_0 = {
			ja = 8.933,
			ko = 7.033,
			zh = 5.233,
			en = 8.1
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
				arg_109_0:Play115311028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = arg_109_1.actors_["10030"].transform
			local var_112_1 = 0

			if var_112_1 < arg_109_1.time_ and arg_109_1.time_ <= var_112_1 + arg_112_0 then
				arg_109_1.var_.moveOldPos10030 = var_112_0.localPosition
				var_112_0.localScale = Vector3.New(1, 1, 1)

				arg_109_1:CheckSpriteTmpPos("10030", 3)

				local var_112_2 = var_112_0.childCount

				for iter_112_0 = 0, var_112_2 - 1 do
					local var_112_3 = var_112_0:GetChild(iter_112_0)

					if var_112_3.name == "split_3" or not string.find(var_112_3.name, "split") then
						var_112_3.gameObject:SetActive(true)
					else
						var_112_3.gameObject:SetActive(false)
					end
				end
			end

			local var_112_4 = 0.001

			if var_112_1 <= arg_109_1.time_ and arg_109_1.time_ < var_112_1 + var_112_4 then
				local var_112_5 = (arg_109_1.time_ - var_112_1) / var_112_4
				local var_112_6 = Vector3.New(0, -390, 150)

				var_112_0.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos10030, var_112_6, var_112_5)
			end

			if arg_109_1.time_ >= var_112_1 + var_112_4 and arg_109_1.time_ < var_112_1 + var_112_4 + arg_112_0 then
				var_112_0.localPosition = Vector3.New(0, -390, 150)
			end

			local var_112_7 = arg_109_1.actors_["10030"]
			local var_112_8 = 0

			if var_112_8 < arg_109_1.time_ and arg_109_1.time_ <= var_112_8 + arg_112_0 and not isNil(var_112_7) and arg_109_1.var_.actorSpriteComps10030 == nil then
				arg_109_1.var_.actorSpriteComps10030 = var_112_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_112_9 = 0.2

			if var_112_8 <= arg_109_1.time_ and arg_109_1.time_ < var_112_8 + var_112_9 and not isNil(var_112_7) then
				local var_112_10 = (arg_109_1.time_ - var_112_8) / var_112_9

				if arg_109_1.var_.actorSpriteComps10030 then
					for iter_112_1, iter_112_2 in pairs(arg_109_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_112_2 then
							if arg_109_1.isInRecall_ then
								local var_112_11 = Mathf.Lerp(iter_112_2.color.r, arg_109_1.hightColor1.r, var_112_10)
								local var_112_12 = Mathf.Lerp(iter_112_2.color.g, arg_109_1.hightColor1.g, var_112_10)
								local var_112_13 = Mathf.Lerp(iter_112_2.color.b, arg_109_1.hightColor1.b, var_112_10)

								iter_112_2.color = Color.New(var_112_11, var_112_12, var_112_13)
							else
								local var_112_14 = Mathf.Lerp(iter_112_2.color.r, 1, var_112_10)

								iter_112_2.color = Color.New(var_112_14, var_112_14, var_112_14)
							end
						end
					end
				end
			end

			if arg_109_1.time_ >= var_112_8 + var_112_9 and arg_109_1.time_ < var_112_8 + var_112_9 + arg_112_0 and not isNil(var_112_7) and arg_109_1.var_.actorSpriteComps10030 then
				for iter_112_3, iter_112_4 in pairs(arg_109_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_112_4 then
						if arg_109_1.isInRecall_ then
							iter_112_4.color = arg_109_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_112_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_109_1.var_.actorSpriteComps10030 = nil
			end

			local var_112_15 = 0
			local var_112_16 = 0.5

			if var_112_15 < arg_109_1.time_ and arg_109_1.time_ <= var_112_15 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				local var_112_17 = arg_109_1:FormatText(StoryNameCfg[309].name)

				arg_109_1.leftNameTxt_.text = var_112_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_18 = arg_109_1:GetWordFromCfg(115311027)
				local var_112_19 = arg_109_1:FormatText(var_112_18.content)

				arg_109_1.text_.text = var_112_19

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_20 = 20
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

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311027", "story_v_out_115311.awb") ~= 0 then
					local var_112_23 = manager.audio:GetVoiceLength("story_v_out_115311", "115311027", "story_v_out_115311.awb") / 1000

					if var_112_23 + var_112_15 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_23 + var_112_15
					end

					if var_112_18.prefab_name ~= "" and arg_109_1.actors_[var_112_18.prefab_name] ~= nil then
						local var_112_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_18.prefab_name].transform, "story_v_out_115311", "115311027", "story_v_out_115311.awb")

						arg_109_1:RecordAudio("115311027", var_112_24)
						arg_109_1:RecordAudio("115311027", var_112_24)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_115311", "115311027", "story_v_out_115311.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_115311", "115311027", "story_v_out_115311.awb")
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
				actorName = "10030",
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
	Play115311028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 115311028
		arg_113_1.duration_ = 9.17

		local var_113_0 = {
			ja = 9.166,
			ko = 8.8,
			zh = 6,
			en = 9.033
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
				arg_113_0:Play115311029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = arg_113_1.actors_["10030"]
			local var_116_1 = 0

			if var_116_1 < arg_113_1.time_ and arg_113_1.time_ <= var_116_1 + arg_116_0 and not isNil(var_116_0) and arg_113_1.var_.actorSpriteComps10030 == nil then
				arg_113_1.var_.actorSpriteComps10030 = var_116_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_116_2 = 0.2

			if var_116_1 <= arg_113_1.time_ and arg_113_1.time_ < var_116_1 + var_116_2 and not isNil(var_116_0) then
				local var_116_3 = (arg_113_1.time_ - var_116_1) / var_116_2

				if arg_113_1.var_.actorSpriteComps10030 then
					for iter_116_0, iter_116_1 in pairs(arg_113_1.var_.actorSpriteComps10030:ToTable()) do
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

			if arg_113_1.time_ >= var_116_1 + var_116_2 and arg_113_1.time_ < var_116_1 + var_116_2 + arg_116_0 and not isNil(var_116_0) and arg_113_1.var_.actorSpriteComps10030 then
				for iter_116_2, iter_116_3 in pairs(arg_113_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_116_3 then
						if arg_113_1.isInRecall_ then
							iter_116_3.color = arg_113_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_116_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_113_1.var_.actorSpriteComps10030 = nil
			end

			local var_116_8 = 0
			local var_116_9 = 0.825

			if var_116_8 < arg_113_1.time_ and arg_113_1.time_ <= var_116_8 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				local var_116_10 = arg_113_1:FormatText(StoryNameCfg[104].name)

				arg_113_1.leftNameTxt_.text = var_116_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, true)
				arg_113_1.iconController_:SetSelectedState("hero")

				arg_113_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_woundedd")

				arg_113_1.callingController_:SetSelectedState("normal")

				arg_113_1.keyicon_.color = Color.New(1, 1, 1)
				arg_113_1.icon_.color = Color.New(1, 1, 1)

				local var_116_11 = arg_113_1:GetWordFromCfg(115311028)
				local var_116_12 = arg_113_1:FormatText(var_116_11.content)

				arg_113_1.text_.text = var_116_12

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_13 = 33
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

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311028", "story_v_out_115311.awb") ~= 0 then
					local var_116_16 = manager.audio:GetVoiceLength("story_v_out_115311", "115311028", "story_v_out_115311.awb") / 1000

					if var_116_16 + var_116_8 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_16 + var_116_8
					end

					if var_116_11.prefab_name ~= "" and arg_113_1.actors_[var_116_11.prefab_name] ~= nil then
						local var_116_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_11.prefab_name].transform, "story_v_out_115311", "115311028", "story_v_out_115311.awb")

						arg_113_1:RecordAudio("115311028", var_116_17)
						arg_113_1:RecordAudio("115311028", var_116_17)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_115311", "115311028", "story_v_out_115311.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_115311", "115311028", "story_v_out_115311.awb")
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
	Play115311029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 115311029
		arg_117_1.duration_ = 5

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play115311030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = 0
			local var_120_1 = 0.9

			if var_120_0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_0 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, false)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_2 = arg_117_1:GetWordFromCfg(115311029)
				local var_120_3 = arg_117_1:FormatText(var_120_2.content)

				arg_117_1.text_.text = var_120_3

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_4 = 36
				local var_120_5 = utf8.len(var_120_3)
				local var_120_6 = var_120_4 <= 0 and var_120_1 or var_120_1 * (var_120_5 / var_120_4)

				if var_120_6 > 0 and var_120_1 < var_120_6 then
					arg_117_1.talkMaxDuration = var_120_6

					if var_120_6 + var_120_0 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_6 + var_120_0
					end
				end

				arg_117_1.text_.text = var_120_3
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)
				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_7 = math.max(var_120_1, arg_117_1.talkMaxDuration)

			if var_120_0 <= arg_117_1.time_ and arg_117_1.time_ < var_120_0 + var_120_7 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_0) / var_120_7

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_0 + var_120_7 and arg_117_1.time_ < var_120_0 + var_120_7 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play115311030 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 115311030
		arg_121_1.duration_ = 11.03

		local var_121_0 = {
			ja = 11.033,
			ko = 8,
			zh = 6.9,
			en = 7.433
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
				arg_121_0:Play115311031(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = arg_121_1.actors_["10030"]
			local var_124_1 = 0

			if var_124_1 < arg_121_1.time_ and arg_121_1.time_ <= var_124_1 + arg_124_0 and not isNil(var_124_0) and arg_121_1.var_.actorSpriteComps10030 == nil then
				arg_121_1.var_.actorSpriteComps10030 = var_124_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_124_2 = 0.2

			if var_124_1 <= arg_121_1.time_ and arg_121_1.time_ < var_124_1 + var_124_2 and not isNil(var_124_0) then
				local var_124_3 = (arg_121_1.time_ - var_124_1) / var_124_2

				if arg_121_1.var_.actorSpriteComps10030 then
					for iter_124_0, iter_124_1 in pairs(arg_121_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_124_1 then
							if arg_121_1.isInRecall_ then
								local var_124_4 = Mathf.Lerp(iter_124_1.color.r, arg_121_1.hightColor1.r, var_124_3)
								local var_124_5 = Mathf.Lerp(iter_124_1.color.g, arg_121_1.hightColor1.g, var_124_3)
								local var_124_6 = Mathf.Lerp(iter_124_1.color.b, arg_121_1.hightColor1.b, var_124_3)

								iter_124_1.color = Color.New(var_124_4, var_124_5, var_124_6)
							else
								local var_124_7 = Mathf.Lerp(iter_124_1.color.r, 1, var_124_3)

								iter_124_1.color = Color.New(var_124_7, var_124_7, var_124_7)
							end
						end
					end
				end
			end

			if arg_121_1.time_ >= var_124_1 + var_124_2 and arg_121_1.time_ < var_124_1 + var_124_2 + arg_124_0 and not isNil(var_124_0) and arg_121_1.var_.actorSpriteComps10030 then
				for iter_124_2, iter_124_3 in pairs(arg_121_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_124_3 then
						if arg_121_1.isInRecall_ then
							iter_124_3.color = arg_121_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_124_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_121_1.var_.actorSpriteComps10030 = nil
			end

			local var_124_8 = 0
			local var_124_9 = 0.6

			if var_124_8 < arg_121_1.time_ and arg_121_1.time_ <= var_124_8 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				local var_124_10 = arg_121_1:FormatText(StoryNameCfg[309].name)

				arg_121_1.leftNameTxt_.text = var_124_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_11 = arg_121_1:GetWordFromCfg(115311030)
				local var_124_12 = arg_121_1:FormatText(var_124_11.content)

				arg_121_1.text_.text = var_124_12

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_13 = 24
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

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311030", "story_v_out_115311.awb") ~= 0 then
					local var_124_16 = manager.audio:GetVoiceLength("story_v_out_115311", "115311030", "story_v_out_115311.awb") / 1000

					if var_124_16 + var_124_8 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_16 + var_124_8
					end

					if var_124_11.prefab_name ~= "" and arg_121_1.actors_[var_124_11.prefab_name] ~= nil then
						local var_124_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_11.prefab_name].transform, "story_v_out_115311", "115311030", "story_v_out_115311.awb")

						arg_121_1:RecordAudio("115311030", var_124_17)
						arg_121_1:RecordAudio("115311030", var_124_17)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_115311", "115311030", "story_v_out_115311.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_115311", "115311030", "story_v_out_115311.awb")
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
	Play115311031 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 115311031
		arg_125_1.duration_ = 9.73

		local var_125_0 = {
			ja = 9.733,
			ko = 8.4,
			zh = 8.7,
			en = 9.4
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
				arg_125_0:Play115311032(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = arg_125_1.actors_["10030"]
			local var_128_1 = 0

			if var_128_1 < arg_125_1.time_ and arg_125_1.time_ <= var_128_1 + arg_128_0 and not isNil(var_128_0) and arg_125_1.var_.actorSpriteComps10030 == nil then
				arg_125_1.var_.actorSpriteComps10030 = var_128_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_128_2 = 0.2

			if var_128_1 <= arg_125_1.time_ and arg_125_1.time_ < var_128_1 + var_128_2 and not isNil(var_128_0) then
				local var_128_3 = (arg_125_1.time_ - var_128_1) / var_128_2

				if arg_125_1.var_.actorSpriteComps10030 then
					for iter_128_0, iter_128_1 in pairs(arg_125_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_128_1 then
							if arg_125_1.isInRecall_ then
								local var_128_4 = Mathf.Lerp(iter_128_1.color.r, arg_125_1.hightColor2.r, var_128_3)
								local var_128_5 = Mathf.Lerp(iter_128_1.color.g, arg_125_1.hightColor2.g, var_128_3)
								local var_128_6 = Mathf.Lerp(iter_128_1.color.b, arg_125_1.hightColor2.b, var_128_3)

								iter_128_1.color = Color.New(var_128_4, var_128_5, var_128_6)
							else
								local var_128_7 = Mathf.Lerp(iter_128_1.color.r, 0.5, var_128_3)

								iter_128_1.color = Color.New(var_128_7, var_128_7, var_128_7)
							end
						end
					end
				end
			end

			if arg_125_1.time_ >= var_128_1 + var_128_2 and arg_125_1.time_ < var_128_1 + var_128_2 + arg_128_0 and not isNil(var_128_0) and arg_125_1.var_.actorSpriteComps10030 then
				for iter_128_2, iter_128_3 in pairs(arg_125_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_128_3 then
						if arg_125_1.isInRecall_ then
							iter_128_3.color = arg_125_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_128_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_125_1.var_.actorSpriteComps10030 = nil
			end

			local var_128_8 = 0
			local var_128_9 = 1.175

			if var_128_8 < arg_125_1.time_ and arg_125_1.time_ <= var_128_8 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				local var_128_10 = arg_125_1:FormatText(StoryNameCfg[104].name)

				arg_125_1.leftNameTxt_.text = var_128_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, true)
				arg_125_1.iconController_:SetSelectedState("hero")

				arg_125_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_woundedd")

				arg_125_1.callingController_:SetSelectedState("normal")

				arg_125_1.keyicon_.color = Color.New(1, 1, 1)
				arg_125_1.icon_.color = Color.New(1, 1, 1)

				local var_128_11 = arg_125_1:GetWordFromCfg(115311031)
				local var_128_12 = arg_125_1:FormatText(var_128_11.content)

				arg_125_1.text_.text = var_128_12

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_13 = 47
				local var_128_14 = utf8.len(var_128_12)
				local var_128_15 = var_128_13 <= 0 and var_128_9 or var_128_9 * (var_128_14 / var_128_13)

				if var_128_15 > 0 and var_128_9 < var_128_15 then
					arg_125_1.talkMaxDuration = var_128_15

					if var_128_15 + var_128_8 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_15 + var_128_8
					end
				end

				arg_125_1.text_.text = var_128_12
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311031", "story_v_out_115311.awb") ~= 0 then
					local var_128_16 = manager.audio:GetVoiceLength("story_v_out_115311", "115311031", "story_v_out_115311.awb") / 1000

					if var_128_16 + var_128_8 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_16 + var_128_8
					end

					if var_128_11.prefab_name ~= "" and arg_125_1.actors_[var_128_11.prefab_name] ~= nil then
						local var_128_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_11.prefab_name].transform, "story_v_out_115311", "115311031", "story_v_out_115311.awb")

						arg_125_1:RecordAudio("115311031", var_128_17)
						arg_125_1:RecordAudio("115311031", var_128_17)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_115311", "115311031", "story_v_out_115311.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_115311", "115311031", "story_v_out_115311.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_18 = math.max(var_128_9, arg_125_1.talkMaxDuration)

			if var_128_8 <= arg_125_1.time_ and arg_125_1.time_ < var_128_8 + var_128_18 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_8) / var_128_18

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_8 + var_128_18 and arg_125_1.time_ < var_128_8 + var_128_18 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play115311032 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 115311032
		arg_129_1.duration_ = 6.27

		local var_129_0 = {
			ja = 6.266,
			ko = 3.633,
			zh = 3.666,
			en = 3.866
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
				arg_129_0:Play115311033(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = 0
			local var_132_1 = 0.525

			if var_132_0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_0 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				local var_132_2 = arg_129_1:FormatText(StoryNameCfg[104].name)

				arg_129_1.leftNameTxt_.text = var_132_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, true)
				arg_129_1.iconController_:SetSelectedState("hero")

				arg_129_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_woundedd")

				arg_129_1.callingController_:SetSelectedState("normal")

				arg_129_1.keyicon_.color = Color.New(1, 1, 1)
				arg_129_1.icon_.color = Color.New(1, 1, 1)

				local var_132_3 = arg_129_1:GetWordFromCfg(115311032)
				local var_132_4 = arg_129_1:FormatText(var_132_3.content)

				arg_129_1.text_.text = var_132_4

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_5 = 21
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

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311032", "story_v_out_115311.awb") ~= 0 then
					local var_132_8 = manager.audio:GetVoiceLength("story_v_out_115311", "115311032", "story_v_out_115311.awb") / 1000

					if var_132_8 + var_132_0 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_8 + var_132_0
					end

					if var_132_3.prefab_name ~= "" and arg_129_1.actors_[var_132_3.prefab_name] ~= nil then
						local var_132_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_3.prefab_name].transform, "story_v_out_115311", "115311032", "story_v_out_115311.awb")

						arg_129_1:RecordAudio("115311032", var_132_9)
						arg_129_1:RecordAudio("115311032", var_132_9)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_115311", "115311032", "story_v_out_115311.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_115311", "115311032", "story_v_out_115311.awb")
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
	Play115311033 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 115311033
		arg_133_1.duration_ = 9

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play115311034(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = "ST28a"

			if arg_133_1.bgs_[var_136_0] == nil then
				local var_136_1 = Object.Instantiate(arg_133_1.paintGo_)

				var_136_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_136_0)
				var_136_1.name = var_136_0
				var_136_1.transform.parent = arg_133_1.stage_.transform
				var_136_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_133_1.bgs_[var_136_0] = var_136_1
			end

			local var_136_2 = 2

			if var_136_2 < arg_133_1.time_ and arg_133_1.time_ <= var_136_2 + arg_136_0 then
				local var_136_3 = manager.ui.mainCamera.transform.localPosition
				local var_136_4 = Vector3.New(0, 0, 10) + Vector3.New(var_136_3.x, var_136_3.y, 0)
				local var_136_5 = arg_133_1.bgs_.ST28a

				var_136_5.transform.localPosition = var_136_4
				var_136_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_136_6 = var_136_5:GetComponent("SpriteRenderer")

				if var_136_6 and var_136_6.sprite then
					local var_136_7 = (var_136_5.transform.localPosition - var_136_3).z
					local var_136_8 = manager.ui.mainCameraCom_
					local var_136_9 = 2 * var_136_7 * Mathf.Tan(var_136_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_136_10 = var_136_9 * var_136_8.aspect
					local var_136_11 = var_136_6.sprite.bounds.size.x
					local var_136_12 = var_136_6.sprite.bounds.size.y
					local var_136_13 = var_136_10 / var_136_11
					local var_136_14 = var_136_9 / var_136_12
					local var_136_15 = var_136_14 < var_136_13 and var_136_13 or var_136_14

					var_136_5.transform.localScale = Vector3.New(var_136_15, var_136_15, 0)
				end

				for iter_136_0, iter_136_1 in pairs(arg_133_1.bgs_) do
					if iter_136_0 ~= "ST28a" then
						iter_136_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_136_16 = 0

			if var_136_16 < arg_133_1.time_ and arg_133_1.time_ <= var_136_16 + arg_136_0 then
				arg_133_1.mask_.enabled = true
				arg_133_1.mask_.raycastTarget = true

				arg_133_1:SetGaussion(false)
			end

			local var_136_17 = 2

			if var_136_16 <= arg_133_1.time_ and arg_133_1.time_ < var_136_16 + var_136_17 then
				local var_136_18 = (arg_133_1.time_ - var_136_16) / var_136_17
				local var_136_19 = Color.New(0, 0, 0)

				var_136_19.a = Mathf.Lerp(0, 1, var_136_18)
				arg_133_1.mask_.color = var_136_19
			end

			if arg_133_1.time_ >= var_136_16 + var_136_17 and arg_133_1.time_ < var_136_16 + var_136_17 + arg_136_0 then
				local var_136_20 = Color.New(0, 0, 0)

				var_136_20.a = 1
				arg_133_1.mask_.color = var_136_20
			end

			local var_136_21 = 2

			if var_136_21 < arg_133_1.time_ and arg_133_1.time_ <= var_136_21 + arg_136_0 then
				arg_133_1.mask_.enabled = true
				arg_133_1.mask_.raycastTarget = true

				arg_133_1:SetGaussion(false)
			end

			local var_136_22 = 2

			if var_136_21 <= arg_133_1.time_ and arg_133_1.time_ < var_136_21 + var_136_22 then
				local var_136_23 = (arg_133_1.time_ - var_136_21) / var_136_22
				local var_136_24 = Color.New(0, 0, 0)

				var_136_24.a = Mathf.Lerp(1, 0, var_136_23)
				arg_133_1.mask_.color = var_136_24
			end

			if arg_133_1.time_ >= var_136_21 + var_136_22 and arg_133_1.time_ < var_136_21 + var_136_22 + arg_136_0 then
				local var_136_25 = Color.New(0, 0, 0)
				local var_136_26 = 0

				arg_133_1.mask_.enabled = false
				var_136_25.a = var_136_26
				arg_133_1.mask_.color = var_136_25
			end

			local var_136_27 = arg_133_1.actors_["10030"].transform
			local var_136_28 = 1.966

			if var_136_28 < arg_133_1.time_ and arg_133_1.time_ <= var_136_28 + arg_136_0 then
				arg_133_1.var_.moveOldPos10030 = var_136_27.localPosition
				var_136_27.localScale = Vector3.New(1, 1, 1)

				arg_133_1:CheckSpriteTmpPos("10030", 7)

				local var_136_29 = var_136_27.childCount

				for iter_136_2 = 0, var_136_29 - 1 do
					local var_136_30 = var_136_27:GetChild(iter_136_2)

					if var_136_30.name == "split_3" or not string.find(var_136_30.name, "split") then
						var_136_30.gameObject:SetActive(true)
					else
						var_136_30.gameObject:SetActive(false)
					end
				end
			end

			local var_136_31 = 0.001

			if var_136_28 <= arg_133_1.time_ and arg_133_1.time_ < var_136_28 + var_136_31 then
				local var_136_32 = (arg_133_1.time_ - var_136_28) / var_136_31
				local var_136_33 = Vector3.New(0, -2000, -180)

				var_136_27.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPos10030, var_136_33, var_136_32)
			end

			if arg_133_1.time_ >= var_136_28 + var_136_31 and arg_133_1.time_ < var_136_28 + var_136_31 + arg_136_0 then
				var_136_27.localPosition = Vector3.New(0, -2000, -180)
			end

			if arg_133_1.frameCnt_ <= 1 then
				arg_133_1.dialog_:SetActive(false)
			end

			local var_136_34 = 4
			local var_136_35 = 1.325

			if var_136_34 < arg_133_1.time_ and arg_133_1.time_ <= var_136_34 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0

				arg_133_1.dialog_:SetActive(true)

				arg_133_1.dialogCg_.alpha = 0

				local var_136_36 = LeanTween.value(arg_133_1.dialog_, 0, 1, 0.3)

				var_136_36:setOnUpdate(LuaHelper.FloatAction(function(arg_137_0)
					arg_133_1.dialogCg_.alpha = arg_137_0
				end))
				var_136_36:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_133_1.dialog_)
					var_136_36:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_133_1.duration_ = arg_133_1.duration_ + 0.3

				SetActive(arg_133_1.leftNameGo_, false)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_37 = arg_133_1:GetWordFromCfg(115311033)
				local var_136_38 = arg_133_1:FormatText(var_136_37.content)

				arg_133_1.text_.text = var_136_38

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_39 = 53
				local var_136_40 = utf8.len(var_136_38)
				local var_136_41 = var_136_39 <= 0 and var_136_35 or var_136_35 * (var_136_40 / var_136_39)

				if var_136_41 > 0 and var_136_35 < var_136_41 then
					arg_133_1.talkMaxDuration = var_136_41
					var_136_34 = var_136_34 + 0.3

					if var_136_41 + var_136_34 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_41 + var_136_34
					end
				end

				arg_133_1.text_.text = var_136_38
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)
				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_42 = var_136_34 + 0.3
			local var_136_43 = math.max(var_136_35, arg_133_1.talkMaxDuration)

			if var_136_42 <= arg_133_1.time_ and arg_133_1.time_ < var_136_42 + var_136_43 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_42) / var_136_43

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_42 + var_136_43 and arg_133_1.time_ < var_136_42 + var_136_43 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10030",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_133_1:InitPlayNodeList()
	end,
	Play115311034 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 115311034
		arg_139_1.duration_ = 5

		SetActive(arg_139_1.tipsGo_, false)

		function arg_139_1.onSingleLineFinish_()
			arg_139_1.onSingleLineUpdate_ = nil
			arg_139_1.onSingleLineFinish_ = nil
			arg_139_1.state_ = "waiting"
		end

		function arg_139_1.playNext_(arg_141_0)
			if arg_141_0 == 1 then
				arg_139_0:Play115311035(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			local var_142_0 = 0
			local var_142_1 = 1.2

			if var_142_0 < arg_139_1.time_ and arg_139_1.time_ <= var_142_0 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, false)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_2 = arg_139_1:GetWordFromCfg(115311034)
				local var_142_3 = arg_139_1:FormatText(var_142_2.content)

				arg_139_1.text_.text = var_142_3

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_4 = 48
				local var_142_5 = utf8.len(var_142_3)
				local var_142_6 = var_142_4 <= 0 and var_142_1 or var_142_1 * (var_142_5 / var_142_4)

				if var_142_6 > 0 and var_142_1 < var_142_6 then
					arg_139_1.talkMaxDuration = var_142_6

					if var_142_6 + var_142_0 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_6 + var_142_0
					end
				end

				arg_139_1.text_.text = var_142_3
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)
				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_7 = math.max(var_142_1, arg_139_1.talkMaxDuration)

			if var_142_0 <= arg_139_1.time_ and arg_139_1.time_ < var_142_0 + var_142_7 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_0) / var_142_7

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_0 + var_142_7 and arg_139_1.time_ < var_142_0 + var_142_7 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {}

		arg_139_1:InitPlayNodeList()
	end,
	Play115311035 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 115311035
		arg_143_1.duration_ = 5

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play115311036(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = 0
			local var_146_1 = 1.375

			if var_146_0 < arg_143_1.time_ and arg_143_1.time_ <= var_146_0 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, false)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_2 = arg_143_1:GetWordFromCfg(115311035)
				local var_146_3 = arg_143_1:FormatText(var_146_2.content)

				arg_143_1.text_.text = var_146_3

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_4 = 55
				local var_146_5 = utf8.len(var_146_3)
				local var_146_6 = var_146_4 <= 0 and var_146_1 or var_146_1 * (var_146_5 / var_146_4)

				if var_146_6 > 0 and var_146_1 < var_146_6 then
					arg_143_1.talkMaxDuration = var_146_6

					if var_146_6 + var_146_0 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_6 + var_146_0
					end
				end

				arg_143_1.text_.text = var_146_3
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)
				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_7 = math.max(var_146_1, arg_143_1.talkMaxDuration)

			if var_146_0 <= arg_143_1.time_ and arg_143_1.time_ < var_146_0 + var_146_7 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_0) / var_146_7

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_0 + var_146_7 and arg_143_1.time_ < var_146_0 + var_146_7 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {}

		arg_143_1:InitPlayNodeList()
	end,
	Play115311036 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 115311036
		arg_147_1.duration_ = 11

		local var_147_0 = {
			ja = 7.2,
			ko = 7.3,
			zh = 7.466,
			en = 11
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
				arg_147_0:Play115311037(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_0 = "10029"

			if arg_147_1.actors_[var_150_0] == nil then
				local var_150_1 = Object.Instantiate(arg_147_1.imageGo_, arg_147_1.canvasGo_.transform)

				var_150_1.transform:SetSiblingIndex(1)

				var_150_1.name = var_150_0

				local var_150_2 = var_150_1:GetComponent(typeof(Image))

				var_150_2.sprite = getSpriteWithoutAtlas("TextureConfig/Character/Portrait/" .. "10029")

				var_150_2:SetNativeSize()

				var_150_1.transform.localPosition = Vector3.New(0, 100000, 0)
				arg_147_1.actors_[var_150_0] = var_150_1
			end

			local var_150_3 = arg_147_1.actors_["10029"].transform
			local var_150_4 = 0

			if var_150_4 < arg_147_1.time_ and arg_147_1.time_ <= var_150_4 + arg_150_0 then
				arg_147_1.var_.moveOldPos10029 = var_150_3.localPosition
				var_150_3.localScale = Vector3.New(1, 1, 1)

				arg_147_1:CheckSpriteTmpPos("10029", 2)
			end

			local var_150_5 = 0.001

			if var_150_4 <= arg_147_1.time_ and arg_147_1.time_ < var_150_4 + var_150_5 then
				local var_150_6 = (arg_147_1.time_ - var_150_4) / var_150_5
				local var_150_7 = Vector3.New(-390, -350, -180)

				var_150_3.localPosition = Vector3.Lerp(arg_147_1.var_.moveOldPos10029, var_150_7, var_150_6)
			end

			if arg_147_1.time_ >= var_150_4 + var_150_5 and arg_147_1.time_ < var_150_4 + var_150_5 + arg_150_0 then
				var_150_3.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_150_8 = arg_147_1.actors_["10029"]
			local var_150_9 = 0

			if var_150_9 < arg_147_1.time_ and arg_147_1.time_ <= var_150_9 + arg_150_0 then
				local var_150_10 = var_150_8:GetComponent("Image")

				if var_150_10 then
					arg_147_1.var_.alphaMatValue10029 = var_150_10
					arg_147_1.var_.alphaOldValue10029 = var_150_10.color.a
				end

				arg_147_1.var_.alphaOldValue10029 = 0
			end

			local var_150_11 = 0.5

			if var_150_9 <= arg_147_1.time_ and arg_147_1.time_ < var_150_9 + var_150_11 then
				local var_150_12 = (arg_147_1.time_ - var_150_9) / var_150_11
				local var_150_13 = Mathf.Lerp(arg_147_1.var_.alphaOldValue10029, 1, var_150_12)

				if arg_147_1.var_.alphaMatValue10029 then
					local var_150_14 = arg_147_1.var_.alphaMatValue10029.color

					var_150_14.a = var_150_13
					arg_147_1.var_.alphaMatValue10029.color = var_150_14
				end
			end

			if arg_147_1.time_ >= var_150_9 + var_150_11 and arg_147_1.time_ < var_150_9 + var_150_11 + arg_150_0 and arg_147_1.var_.alphaMatValue10029 then
				local var_150_15 = arg_147_1.var_.alphaMatValue10029
				local var_150_16 = var_150_15.color

				var_150_16.a = 1
				var_150_15.color = var_150_16
			end

			local var_150_17 = arg_147_1.actors_["10029"]
			local var_150_18 = 0

			if var_150_18 < arg_147_1.time_ and arg_147_1.time_ <= var_150_18 + arg_150_0 and not isNil(var_150_17) then
				local var_150_19 = var_150_17:GetComponent("Image")

				if var_150_19 then
					arg_147_1.var_.highlightMatValue10029 = var_150_19
				end
			end

			local var_150_20 = 0.2

			if var_150_18 <= arg_147_1.time_ and arg_147_1.time_ < var_150_18 + var_150_20 and not isNil(var_150_17) then
				local var_150_21 = (arg_147_1.time_ - var_150_18) / var_150_20

				if arg_147_1.var_.highlightMatValue10029 then
					local var_150_22 = Mathf.Lerp(0.5, 1, var_150_21)
					local var_150_23 = arg_147_1.var_.highlightMatValue10029
					local var_150_24 = var_150_23.color

					var_150_24.r = var_150_22
					var_150_24.g = var_150_22
					var_150_24.b = var_150_22
					var_150_23.color = var_150_24
				end
			end

			if arg_147_1.time_ >= var_150_18 + var_150_20 and arg_147_1.time_ < var_150_18 + var_150_20 + arg_150_0 and not isNil(var_150_17) and arg_147_1.var_.highlightMatValue10029 then
				local var_150_25 = 1

				var_150_17.transform:SetSiblingIndex(1)

				local var_150_26 = arg_147_1.var_.highlightMatValue10029
				local var_150_27 = var_150_26.color

				var_150_27.r = var_150_25
				var_150_27.g = var_150_25
				var_150_27.b = var_150_25
				var_150_26.color = var_150_27
			end

			local var_150_28 = 0
			local var_150_29 = 0.775

			if var_150_28 < arg_147_1.time_ and arg_147_1.time_ <= var_150_28 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				local var_150_30 = arg_147_1:FormatText(StoryNameCfg[312].name)

				arg_147_1.leftNameTxt_.text = var_150_30

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_31 = arg_147_1:GetWordFromCfg(115311036)
				local var_150_32 = arg_147_1:FormatText(var_150_31.content)

				arg_147_1.text_.text = var_150_32

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_33 = 31
				local var_150_34 = utf8.len(var_150_32)
				local var_150_35 = var_150_33 <= 0 and var_150_29 or var_150_29 * (var_150_34 / var_150_33)

				if var_150_35 > 0 and var_150_29 < var_150_35 then
					arg_147_1.talkMaxDuration = var_150_35

					if var_150_35 + var_150_28 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_35 + var_150_28
					end
				end

				arg_147_1.text_.text = var_150_32
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311036", "story_v_out_115311.awb") ~= 0 then
					local var_150_36 = manager.audio:GetVoiceLength("story_v_out_115311", "115311036", "story_v_out_115311.awb") / 1000

					if var_150_36 + var_150_28 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_36 + var_150_28
					end

					if var_150_31.prefab_name ~= "" and arg_147_1.actors_[var_150_31.prefab_name] ~= nil then
						local var_150_37 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_31.prefab_name].transform, "story_v_out_115311", "115311036", "story_v_out_115311.awb")

						arg_147_1:RecordAudio("115311036", var_150_37)
						arg_147_1:RecordAudio("115311036", var_150_37)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_115311", "115311036", "story_v_out_115311.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_115311", "115311036", "story_v_out_115311.awb")
				end

				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_38 = math.max(var_150_29, arg_147_1.talkMaxDuration)

			if var_150_28 <= arg_147_1.time_ and arg_147_1.time_ < var_150_28 + var_150_38 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_28) / var_150_38

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_28 + var_150_38 and arg_147_1.time_ < var_150_28 + var_150_38 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10029",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Sprite
			}
		}

		arg_147_1:InitPlayNodeList()
	end,
	Play115311037 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 115311037
		arg_151_1.duration_ = 8.57

		local var_151_0 = {
			ja = 8.566,
			ko = 4.9,
			zh = 4.8,
			en = 6.6
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
				arg_151_0:Play115311038(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = 0
			local var_154_1 = 0.6

			if var_154_0 < arg_151_1.time_ and arg_151_1.time_ <= var_154_0 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				local var_154_2 = arg_151_1:FormatText(StoryNameCfg[312].name)

				arg_151_1.leftNameTxt_.text = var_154_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_3 = arg_151_1:GetWordFromCfg(115311037)
				local var_154_4 = arg_151_1:FormatText(var_154_3.content)

				arg_151_1.text_.text = var_154_4

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_5 = 24
				local var_154_6 = utf8.len(var_154_4)
				local var_154_7 = var_154_5 <= 0 and var_154_1 or var_154_1 * (var_154_6 / var_154_5)

				if var_154_7 > 0 and var_154_1 < var_154_7 then
					arg_151_1.talkMaxDuration = var_154_7

					if var_154_7 + var_154_0 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_7 + var_154_0
					end
				end

				arg_151_1.text_.text = var_154_4
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311037", "story_v_out_115311.awb") ~= 0 then
					local var_154_8 = manager.audio:GetVoiceLength("story_v_out_115311", "115311037", "story_v_out_115311.awb") / 1000

					if var_154_8 + var_154_0 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_8 + var_154_0
					end

					if var_154_3.prefab_name ~= "" and arg_151_1.actors_[var_154_3.prefab_name] ~= nil then
						local var_154_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_3.prefab_name].transform, "story_v_out_115311", "115311037", "story_v_out_115311.awb")

						arg_151_1:RecordAudio("115311037", var_154_9)
						arg_151_1:RecordAudio("115311037", var_154_9)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_out_115311", "115311037", "story_v_out_115311.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_out_115311", "115311037", "story_v_out_115311.awb")
				end

				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_10 = math.max(var_154_1, arg_151_1.talkMaxDuration)

			if var_154_0 <= arg_151_1.time_ and arg_151_1.time_ < var_154_0 + var_154_10 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_0) / var_154_10

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_0 + var_154_10 and arg_151_1.time_ < var_154_0 + var_154_10 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {}

		arg_151_1:InitPlayNodeList()
	end,
	Play115311038 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 115311038
		arg_155_1.duration_ = 17.63

		local var_155_0 = {
			ja = 17.633,
			ko = 10.2,
			zh = 10.2,
			en = 10.5
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
				arg_155_0:Play115311039(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = "113801_1"

			if arg_155_1.actors_[var_158_0] == nil then
				local var_158_1 = Object.Instantiate(arg_155_1.imageGo_, arg_155_1.canvasGo_.transform)

				var_158_1.transform:SetSiblingIndex(1)

				var_158_1.name = var_158_0

				local var_158_2 = var_158_1:GetComponent(typeof(Image))

				var_158_2.sprite = getSpriteWithoutAtlas("TextureConfig/Character/Portrait/" .. "113801_1")

				var_158_2:SetNativeSize()

				var_158_1.transform.localPosition = Vector3.New(0, 100000, 0)
				arg_155_1.actors_[var_158_0] = var_158_1
			end

			local var_158_3 = arg_155_1.actors_["113801_1"]
			local var_158_4 = 0

			if var_158_4 < arg_155_1.time_ and arg_155_1.time_ <= var_158_4 + arg_158_0 then
				local var_158_5 = var_158_3:GetComponent("Image")

				if var_158_5 then
					arg_155_1.var_.alphaMatValue113801_1 = var_158_5
					arg_155_1.var_.alphaOldValue113801_1 = var_158_5.color.a
				end

				arg_155_1.var_.alphaOldValue113801_1 = 0
			end

			local var_158_6 = 0.5

			if var_158_4 <= arg_155_1.time_ and arg_155_1.time_ < var_158_4 + var_158_6 then
				local var_158_7 = (arg_155_1.time_ - var_158_4) / var_158_6
				local var_158_8 = Mathf.Lerp(arg_155_1.var_.alphaOldValue113801_1, 1, var_158_7)

				if arg_155_1.var_.alphaMatValue113801_1 then
					local var_158_9 = arg_155_1.var_.alphaMatValue113801_1.color

					var_158_9.a = var_158_8
					arg_155_1.var_.alphaMatValue113801_1.color = var_158_9
				end
			end

			if arg_155_1.time_ >= var_158_4 + var_158_6 and arg_155_1.time_ < var_158_4 + var_158_6 + arg_158_0 and arg_155_1.var_.alphaMatValue113801_1 then
				local var_158_10 = arg_155_1.var_.alphaMatValue113801_1
				local var_158_11 = var_158_10.color

				var_158_11.a = 1
				var_158_10.color = var_158_11
			end

			local var_158_12 = arg_155_1.actors_["113801_1"]
			local var_158_13 = 0

			if var_158_13 < arg_155_1.time_ and arg_155_1.time_ <= var_158_13 + arg_158_0 and not isNil(var_158_12) then
				local var_158_14 = var_158_12:GetComponent("Image")

				if var_158_14 then
					arg_155_1.var_.highlightMatValue113801_1 = var_158_14
				end
			end

			local var_158_15 = 0.2

			if var_158_13 <= arg_155_1.time_ and arg_155_1.time_ < var_158_13 + var_158_15 and not isNil(var_158_12) then
				local var_158_16 = (arg_155_1.time_ - var_158_13) / var_158_15

				if arg_155_1.var_.highlightMatValue113801_1 then
					local var_158_17 = Mathf.Lerp(0.5, 1, var_158_16)
					local var_158_18 = arg_155_1.var_.highlightMatValue113801_1
					local var_158_19 = var_158_18.color

					var_158_19.r = var_158_17
					var_158_19.g = var_158_17
					var_158_19.b = var_158_17
					var_158_18.color = var_158_19
				end
			end

			if arg_155_1.time_ >= var_158_13 + var_158_15 and arg_155_1.time_ < var_158_13 + var_158_15 + arg_158_0 and not isNil(var_158_12) and arg_155_1.var_.highlightMatValue113801_1 then
				local var_158_20 = 1

				var_158_12.transform:SetSiblingIndex(1)

				local var_158_21 = arg_155_1.var_.highlightMatValue113801_1
				local var_158_22 = var_158_21.color

				var_158_22.r = var_158_20
				var_158_22.g = var_158_20
				var_158_22.b = var_158_20
				var_158_21.color = var_158_22
			end

			local var_158_23 = arg_155_1.actors_["113801_1"].transform
			local var_158_24 = 0

			if var_158_24 < arg_155_1.time_ and arg_155_1.time_ <= var_158_24 + arg_158_0 then
				arg_155_1.var_.moveOldPos113801_1 = var_158_23.localPosition
				var_158_23.localScale = Vector3.New(1, 1, 1)

				arg_155_1:CheckSpriteTmpPos("113801_1", 4)
			end

			local var_158_25 = 0.001

			if var_158_24 <= arg_155_1.time_ and arg_155_1.time_ < var_158_24 + var_158_25 then
				local var_158_26 = (arg_155_1.time_ - var_158_24) / var_158_25
				local var_158_27 = Vector3.New(390, -310, -370)

				var_158_23.localPosition = Vector3.Lerp(arg_155_1.var_.moveOldPos113801_1, var_158_27, var_158_26)
			end

			if arg_155_1.time_ >= var_158_24 + var_158_25 and arg_155_1.time_ < var_158_24 + var_158_25 + arg_158_0 then
				var_158_23.localPosition = Vector3.New(390, -310, -370)
			end

			local var_158_28 = arg_155_1.actors_["10029"]
			local var_158_29 = 0

			if var_158_29 < arg_155_1.time_ and arg_155_1.time_ <= var_158_29 + arg_158_0 and not isNil(var_158_28) then
				local var_158_30 = var_158_28:GetComponent("Image")

				if var_158_30 then
					arg_155_1.var_.highlightMatValue10029 = var_158_30
				end
			end

			local var_158_31 = 0.2

			if var_158_29 <= arg_155_1.time_ and arg_155_1.time_ < var_158_29 + var_158_31 and not isNil(var_158_28) then
				local var_158_32 = (arg_155_1.time_ - var_158_29) / var_158_31

				if arg_155_1.var_.highlightMatValue10029 then
					local var_158_33 = Mathf.Lerp(1, 0.5, var_158_32)
					local var_158_34 = arg_155_1.var_.highlightMatValue10029
					local var_158_35 = var_158_34.color

					var_158_35.r = var_158_33
					var_158_35.g = var_158_33
					var_158_35.b = var_158_33
					var_158_34.color = var_158_35
				end
			end

			if arg_155_1.time_ >= var_158_29 + var_158_31 and arg_155_1.time_ < var_158_29 + var_158_31 + arg_158_0 and not isNil(var_158_28) and arg_155_1.var_.highlightMatValue10029 then
				local var_158_36 = 0.5
				local var_158_37 = arg_155_1.var_.highlightMatValue10029
				local var_158_38 = var_158_37.color

				var_158_38.r = var_158_36
				var_158_38.g = var_158_36
				var_158_38.b = var_158_36
				var_158_37.color = var_158_38
			end

			local var_158_39 = 0
			local var_158_40 = 1

			if var_158_39 < arg_155_1.time_ and arg_155_1.time_ <= var_158_39 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				local var_158_41 = arg_155_1:FormatText(StoryNameCfg[94].name)

				arg_155_1.leftNameTxt_.text = var_158_41

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_42 = arg_155_1:GetWordFromCfg(115311038)
				local var_158_43 = arg_155_1:FormatText(var_158_42.content)

				arg_155_1.text_.text = var_158_43

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_44 = 40
				local var_158_45 = utf8.len(var_158_43)
				local var_158_46 = var_158_44 <= 0 and var_158_40 or var_158_40 * (var_158_45 / var_158_44)

				if var_158_46 > 0 and var_158_40 < var_158_46 then
					arg_155_1.talkMaxDuration = var_158_46

					if var_158_46 + var_158_39 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_46 + var_158_39
					end
				end

				arg_155_1.text_.text = var_158_43
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311038", "story_v_out_115311.awb") ~= 0 then
					local var_158_47 = manager.audio:GetVoiceLength("story_v_out_115311", "115311038", "story_v_out_115311.awb") / 1000

					if var_158_47 + var_158_39 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_47 + var_158_39
					end

					if var_158_42.prefab_name ~= "" and arg_155_1.actors_[var_158_42.prefab_name] ~= nil then
						local var_158_48 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_42.prefab_name].transform, "story_v_out_115311", "115311038", "story_v_out_115311.awb")

						arg_155_1:RecordAudio("115311038", var_158_48)
						arg_155_1:RecordAudio("115311038", var_158_48)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_115311", "115311038", "story_v_out_115311.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_115311", "115311038", "story_v_out_115311.awb")
				end

				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_49 = math.max(var_158_40, arg_155_1.talkMaxDuration)

			if var_158_39 <= arg_155_1.time_ and arg_155_1.time_ < var_158_39 + var_158_49 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_39) / var_158_49

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_39 + var_158_49 and arg_155_1.time_ < var_158_39 + var_158_49 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "113801_1",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Sprite
			}
		}

		arg_155_1:InitPlayNodeList()
	end,
	Play115311039 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 115311039
		arg_159_1.duration_ = 5

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play115311040(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_0 = arg_159_1.actors_["113801_1"]
			local var_162_1 = 0

			if var_162_1 < arg_159_1.time_ and arg_159_1.time_ <= var_162_1 + arg_162_0 and not isNil(var_162_0) then
				local var_162_2 = var_162_0:GetComponent("Image")

				if var_162_2 then
					arg_159_1.var_.highlightMatValue113801_1 = var_162_2
				end
			end

			local var_162_3 = 0.2

			if var_162_1 <= arg_159_1.time_ and arg_159_1.time_ < var_162_1 + var_162_3 and not isNil(var_162_0) then
				local var_162_4 = (arg_159_1.time_ - var_162_1) / var_162_3

				if arg_159_1.var_.highlightMatValue113801_1 then
					local var_162_5 = Mathf.Lerp(1, 0.5, var_162_4)
					local var_162_6 = arg_159_1.var_.highlightMatValue113801_1
					local var_162_7 = var_162_6.color

					var_162_7.r = var_162_5
					var_162_7.g = var_162_5
					var_162_7.b = var_162_5
					var_162_6.color = var_162_7
				end
			end

			if arg_159_1.time_ >= var_162_1 + var_162_3 and arg_159_1.time_ < var_162_1 + var_162_3 + arg_162_0 and not isNil(var_162_0) and arg_159_1.var_.highlightMatValue113801_1 then
				local var_162_8 = 0.5
				local var_162_9 = arg_159_1.var_.highlightMatValue113801_1
				local var_162_10 = var_162_9.color

				var_162_10.r = var_162_8
				var_162_10.g = var_162_8
				var_162_10.b = var_162_8
				var_162_9.color = var_162_10
			end

			local var_162_11 = 0
			local var_162_12 = 1.325

			if var_162_11 < arg_159_1.time_ and arg_159_1.time_ <= var_162_11 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, false)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_13 = arg_159_1:GetWordFromCfg(115311039)
				local var_162_14 = arg_159_1:FormatText(var_162_13.content)

				arg_159_1.text_.text = var_162_14

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_15 = 53
				local var_162_16 = utf8.len(var_162_14)
				local var_162_17 = var_162_15 <= 0 and var_162_12 or var_162_12 * (var_162_16 / var_162_15)

				if var_162_17 > 0 and var_162_12 < var_162_17 then
					arg_159_1.talkMaxDuration = var_162_17

					if var_162_17 + var_162_11 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_17 + var_162_11
					end
				end

				arg_159_1.text_.text = var_162_14
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)
				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_18 = math.max(var_162_12, arg_159_1.talkMaxDuration)

			if var_162_11 <= arg_159_1.time_ and arg_159_1.time_ < var_162_11 + var_162_18 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_11) / var_162_18

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_11 + var_162_18 and arg_159_1.time_ < var_162_11 + var_162_18 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {}

		arg_159_1:InitPlayNodeList()
	end,
	Play115311040 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 115311040
		arg_163_1.duration_ = 5

		SetActive(arg_163_1.tipsGo_, false)

		function arg_163_1.onSingleLineFinish_()
			arg_163_1.onSingleLineUpdate_ = nil
			arg_163_1.onSingleLineFinish_ = nil
			arg_163_1.state_ = "waiting"
		end

		function arg_163_1.playNext_(arg_165_0)
			if arg_165_0 == 1 then
				arg_163_0:Play115311041(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			local var_166_0 = 0
			local var_166_1 = 1.15

			if var_166_0 < arg_163_1.time_ and arg_163_1.time_ <= var_166_0 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, false)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_2 = arg_163_1:GetWordFromCfg(115311040)
				local var_166_3 = arg_163_1:FormatText(var_166_2.content)

				arg_163_1.text_.text = var_166_3

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_4 = 46
				local var_166_5 = utf8.len(var_166_3)
				local var_166_6 = var_166_4 <= 0 and var_166_1 or var_166_1 * (var_166_5 / var_166_4)

				if var_166_6 > 0 and var_166_1 < var_166_6 then
					arg_163_1.talkMaxDuration = var_166_6

					if var_166_6 + var_166_0 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_6 + var_166_0
					end
				end

				arg_163_1.text_.text = var_166_3
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)
				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_7 = math.max(var_166_1, arg_163_1.talkMaxDuration)

			if var_166_0 <= arg_163_1.time_ and arg_163_1.time_ < var_166_0 + var_166_7 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_0) / var_166_7

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_0 + var_166_7 and arg_163_1.time_ < var_166_0 + var_166_7 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {}

		arg_163_1:InitPlayNodeList()
	end,
	Play115311041 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 115311041
		arg_167_1.duration_ = 13.9

		local var_167_0 = {
			ja = 13.9,
			ko = 12.2,
			zh = 12.033,
			en = 13
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
				arg_167_0:Play115311042(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = arg_167_1.actors_["10029"]
			local var_170_1 = 0

			if var_170_1 < arg_167_1.time_ and arg_167_1.time_ <= var_170_1 + arg_170_0 and not isNil(var_170_0) then
				local var_170_2 = var_170_0:GetComponent("Image")

				if var_170_2 then
					arg_167_1.var_.highlightMatValue10029 = var_170_2
				end
			end

			local var_170_3 = 0.2

			if var_170_1 <= arg_167_1.time_ and arg_167_1.time_ < var_170_1 + var_170_3 and not isNil(var_170_0) then
				local var_170_4 = (arg_167_1.time_ - var_170_1) / var_170_3

				if arg_167_1.var_.highlightMatValue10029 then
					local var_170_5 = Mathf.Lerp(0.5, 1, var_170_4)
					local var_170_6 = arg_167_1.var_.highlightMatValue10029
					local var_170_7 = var_170_6.color

					var_170_7.r = var_170_5
					var_170_7.g = var_170_5
					var_170_7.b = var_170_5
					var_170_6.color = var_170_7
				end
			end

			if arg_167_1.time_ >= var_170_1 + var_170_3 and arg_167_1.time_ < var_170_1 + var_170_3 + arg_170_0 and not isNil(var_170_0) and arg_167_1.var_.highlightMatValue10029 then
				local var_170_8 = 1

				var_170_0.transform:SetSiblingIndex(1)

				local var_170_9 = arg_167_1.var_.highlightMatValue10029
				local var_170_10 = var_170_9.color

				var_170_10.r = var_170_8
				var_170_10.g = var_170_8
				var_170_10.b = var_170_8
				var_170_9.color = var_170_10
			end

			local var_170_11 = 0
			local var_170_12 = 1.2

			if var_170_11 < arg_167_1.time_ and arg_167_1.time_ <= var_170_11 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				local var_170_13 = arg_167_1:FormatText(StoryNameCfg[312].name)

				arg_167_1.leftNameTxt_.text = var_170_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_14 = arg_167_1:GetWordFromCfg(115311041)
				local var_170_15 = arg_167_1:FormatText(var_170_14.content)

				arg_167_1.text_.text = var_170_15

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_16 = 48
				local var_170_17 = utf8.len(var_170_15)
				local var_170_18 = var_170_16 <= 0 and var_170_12 or var_170_12 * (var_170_17 / var_170_16)

				if var_170_18 > 0 and var_170_12 < var_170_18 then
					arg_167_1.talkMaxDuration = var_170_18

					if var_170_18 + var_170_11 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_18 + var_170_11
					end
				end

				arg_167_1.text_.text = var_170_15
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311041", "story_v_out_115311.awb") ~= 0 then
					local var_170_19 = manager.audio:GetVoiceLength("story_v_out_115311", "115311041", "story_v_out_115311.awb") / 1000

					if var_170_19 + var_170_11 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_19 + var_170_11
					end

					if var_170_14.prefab_name ~= "" and arg_167_1.actors_[var_170_14.prefab_name] ~= nil then
						local var_170_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_14.prefab_name].transform, "story_v_out_115311", "115311041", "story_v_out_115311.awb")

						arg_167_1:RecordAudio("115311041", var_170_20)
						arg_167_1:RecordAudio("115311041", var_170_20)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_out_115311", "115311041", "story_v_out_115311.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_out_115311", "115311041", "story_v_out_115311.awb")
				end

				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_21 = math.max(var_170_12, arg_167_1.talkMaxDuration)

			if var_170_11 <= arg_167_1.time_ and arg_167_1.time_ < var_170_11 + var_170_21 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_11) / var_170_21

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_11 + var_170_21 and arg_167_1.time_ < var_170_11 + var_170_21 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {}

		arg_167_1:InitPlayNodeList()
	end,
	Play115311042 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 115311042
		arg_171_1.duration_ = 14

		local var_171_0 = {
			ja = 14,
			ko = 12.633,
			zh = 11.466,
			en = 13.8
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
				arg_171_0:Play115311043(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = 0
			local var_174_1 = 1.2

			if var_174_0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_0 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				local var_174_2 = arg_171_1:FormatText(StoryNameCfg[312].name)

				arg_171_1.leftNameTxt_.text = var_174_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_3 = arg_171_1:GetWordFromCfg(115311042)
				local var_174_4 = arg_171_1:FormatText(var_174_3.content)

				arg_171_1.text_.text = var_174_4

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_5 = 48
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

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311042", "story_v_out_115311.awb") ~= 0 then
					local var_174_8 = manager.audio:GetVoiceLength("story_v_out_115311", "115311042", "story_v_out_115311.awb") / 1000

					if var_174_8 + var_174_0 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_8 + var_174_0
					end

					if var_174_3.prefab_name ~= "" and arg_171_1.actors_[var_174_3.prefab_name] ~= nil then
						local var_174_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_3.prefab_name].transform, "story_v_out_115311", "115311042", "story_v_out_115311.awb")

						arg_171_1:RecordAudio("115311042", var_174_9)
						arg_171_1:RecordAudio("115311042", var_174_9)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_out_115311", "115311042", "story_v_out_115311.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_out_115311", "115311042", "story_v_out_115311.awb")
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
	Play115311043 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 115311043
		arg_175_1.duration_ = 5

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play115311044(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = arg_175_1.actors_["10029"]
			local var_178_1 = 0

			if var_178_1 < arg_175_1.time_ and arg_175_1.time_ <= var_178_1 + arg_178_0 and not isNil(var_178_0) then
				local var_178_2 = var_178_0:GetComponent("Image")

				if var_178_2 then
					arg_175_1.var_.highlightMatValue10029 = var_178_2
				end
			end

			local var_178_3 = 0.2

			if var_178_1 <= arg_175_1.time_ and arg_175_1.time_ < var_178_1 + var_178_3 and not isNil(var_178_0) then
				local var_178_4 = (arg_175_1.time_ - var_178_1) / var_178_3

				if arg_175_1.var_.highlightMatValue10029 then
					local var_178_5 = Mathf.Lerp(1, 0.5, var_178_4)
					local var_178_6 = arg_175_1.var_.highlightMatValue10029
					local var_178_7 = var_178_6.color

					var_178_7.r = var_178_5
					var_178_7.g = var_178_5
					var_178_7.b = var_178_5
					var_178_6.color = var_178_7
				end
			end

			if arg_175_1.time_ >= var_178_1 + var_178_3 and arg_175_1.time_ < var_178_1 + var_178_3 + arg_178_0 and not isNil(var_178_0) and arg_175_1.var_.highlightMatValue10029 then
				local var_178_8 = 0.5
				local var_178_9 = arg_175_1.var_.highlightMatValue10029
				local var_178_10 = var_178_9.color

				var_178_10.r = var_178_8
				var_178_10.g = var_178_8
				var_178_10.b = var_178_8
				var_178_9.color = var_178_10
			end

			local var_178_11 = 0
			local var_178_12 = 1.2

			if var_178_11 < arg_175_1.time_ and arg_175_1.time_ <= var_178_11 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, false)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_13 = arg_175_1:GetWordFromCfg(115311043)
				local var_178_14 = arg_175_1:FormatText(var_178_13.content)

				arg_175_1.text_.text = var_178_14

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_15 = 47
				local var_178_16 = utf8.len(var_178_14)
				local var_178_17 = var_178_15 <= 0 and var_178_12 or var_178_12 * (var_178_16 / var_178_15)

				if var_178_17 > 0 and var_178_12 < var_178_17 then
					arg_175_1.talkMaxDuration = var_178_17

					if var_178_17 + var_178_11 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_17 + var_178_11
					end
				end

				arg_175_1.text_.text = var_178_14
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)
				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_18 = math.max(var_178_12, arg_175_1.talkMaxDuration)

			if var_178_11 <= arg_175_1.time_ and arg_175_1.time_ < var_178_11 + var_178_18 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_11) / var_178_18

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_11 + var_178_18 and arg_175_1.time_ < var_178_11 + var_178_18 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {}

		arg_175_1:InitPlayNodeList()
	end,
	Play115311044 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 115311044
		arg_179_1.duration_ = 5

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play115311045(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = 0
			local var_182_1 = 0.8

			if var_182_0 < arg_179_1.time_ and arg_179_1.time_ <= var_182_0 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, false)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_2 = arg_179_1:GetWordFromCfg(115311044)
				local var_182_3 = arg_179_1:FormatText(var_182_2.content)

				arg_179_1.text_.text = var_182_3

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_4 = 32
				local var_182_5 = utf8.len(var_182_3)
				local var_182_6 = var_182_4 <= 0 and var_182_1 or var_182_1 * (var_182_5 / var_182_4)

				if var_182_6 > 0 and var_182_1 < var_182_6 then
					arg_179_1.talkMaxDuration = var_182_6

					if var_182_6 + var_182_0 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_6 + var_182_0
					end
				end

				arg_179_1.text_.text = var_182_3
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)
				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_7 = math.max(var_182_1, arg_179_1.talkMaxDuration)

			if var_182_0 <= arg_179_1.time_ and arg_179_1.time_ < var_182_0 + var_182_7 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_0) / var_182_7

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_0 + var_182_7 and arg_179_1.time_ < var_182_0 + var_182_7 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {}

		arg_179_1:InitPlayNodeList()
	end,
	Play115311045 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 115311045
		arg_183_1.duration_ = 11.87

		local var_183_0 = {
			ja = 11.866,
			ko = 8.066,
			zh = 8.633,
			en = 9.3
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
				arg_183_0:Play115311046(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_0 = arg_183_1.actors_["113801_1"]
			local var_186_1 = 0

			if var_186_1 < arg_183_1.time_ and arg_183_1.time_ <= var_186_1 + arg_186_0 and not isNil(var_186_0) then
				local var_186_2 = var_186_0:GetComponent("Image")

				if var_186_2 then
					arg_183_1.var_.highlightMatValue113801_1 = var_186_2
				end
			end

			local var_186_3 = 0.2

			if var_186_1 <= arg_183_1.time_ and arg_183_1.time_ < var_186_1 + var_186_3 and not isNil(var_186_0) then
				local var_186_4 = (arg_183_1.time_ - var_186_1) / var_186_3

				if arg_183_1.var_.highlightMatValue113801_1 then
					local var_186_5 = Mathf.Lerp(0.5, 1, var_186_4)
					local var_186_6 = arg_183_1.var_.highlightMatValue113801_1
					local var_186_7 = var_186_6.color

					var_186_7.r = var_186_5
					var_186_7.g = var_186_5
					var_186_7.b = var_186_5
					var_186_6.color = var_186_7
				end
			end

			if arg_183_1.time_ >= var_186_1 + var_186_3 and arg_183_1.time_ < var_186_1 + var_186_3 + arg_186_0 and not isNil(var_186_0) and arg_183_1.var_.highlightMatValue113801_1 then
				local var_186_8 = 1

				var_186_0.transform:SetSiblingIndex(1)

				local var_186_9 = arg_183_1.var_.highlightMatValue113801_1
				local var_186_10 = var_186_9.color

				var_186_10.r = var_186_8
				var_186_10.g = var_186_8
				var_186_10.b = var_186_8
				var_186_9.color = var_186_10
			end

			local var_186_11 = 0
			local var_186_12 = 0.7

			if var_186_11 < arg_183_1.time_ and arg_183_1.time_ <= var_186_11 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				local var_186_13 = arg_183_1:FormatText(StoryNameCfg[94].name)

				arg_183_1.leftNameTxt_.text = var_186_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_14 = arg_183_1:GetWordFromCfg(115311045)
				local var_186_15 = arg_183_1:FormatText(var_186_14.content)

				arg_183_1.text_.text = var_186_15

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_16 = 28
				local var_186_17 = utf8.len(var_186_15)
				local var_186_18 = var_186_16 <= 0 and var_186_12 or var_186_12 * (var_186_17 / var_186_16)

				if var_186_18 > 0 and var_186_12 < var_186_18 then
					arg_183_1.talkMaxDuration = var_186_18

					if var_186_18 + var_186_11 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_18 + var_186_11
					end
				end

				arg_183_1.text_.text = var_186_15
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311045", "story_v_out_115311.awb") ~= 0 then
					local var_186_19 = manager.audio:GetVoiceLength("story_v_out_115311", "115311045", "story_v_out_115311.awb") / 1000

					if var_186_19 + var_186_11 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_19 + var_186_11
					end

					if var_186_14.prefab_name ~= "" and arg_183_1.actors_[var_186_14.prefab_name] ~= nil then
						local var_186_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_14.prefab_name].transform, "story_v_out_115311", "115311045", "story_v_out_115311.awb")

						arg_183_1:RecordAudio("115311045", var_186_20)
						arg_183_1:RecordAudio("115311045", var_186_20)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_out_115311", "115311045", "story_v_out_115311.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_out_115311", "115311045", "story_v_out_115311.awb")
				end

				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_21 = math.max(var_186_12, arg_183_1.talkMaxDuration)

			if var_186_11 <= arg_183_1.time_ and arg_183_1.time_ < var_186_11 + var_186_21 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_11) / var_186_21

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_11 + var_186_21 and arg_183_1.time_ < var_186_11 + var_186_21 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {}

		arg_183_1:InitPlayNodeList()
	end,
	Play115311046 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 115311046
		arg_187_1.duration_ = 10.03

		local var_187_0 = {
			ja = 8.9,
			ko = 5.433,
			zh = 6.6,
			en = 10.033
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
				arg_187_0:Play115311047(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			local var_190_0 = arg_187_1.actors_["10029"]
			local var_190_1 = 0

			if var_190_1 < arg_187_1.time_ and arg_187_1.time_ <= var_190_1 + arg_190_0 and not isNil(var_190_0) then
				local var_190_2 = var_190_0:GetComponent("Image")

				if var_190_2 then
					arg_187_1.var_.highlightMatValue10029 = var_190_2
				end
			end

			local var_190_3 = 0.2

			if var_190_1 <= arg_187_1.time_ and arg_187_1.time_ < var_190_1 + var_190_3 and not isNil(var_190_0) then
				local var_190_4 = (arg_187_1.time_ - var_190_1) / var_190_3

				if arg_187_1.var_.highlightMatValue10029 then
					local var_190_5 = Mathf.Lerp(0.5, 1, var_190_4)
					local var_190_6 = arg_187_1.var_.highlightMatValue10029
					local var_190_7 = var_190_6.color

					var_190_7.r = var_190_5
					var_190_7.g = var_190_5
					var_190_7.b = var_190_5
					var_190_6.color = var_190_7
				end
			end

			if arg_187_1.time_ >= var_190_1 + var_190_3 and arg_187_1.time_ < var_190_1 + var_190_3 + arg_190_0 and not isNil(var_190_0) and arg_187_1.var_.highlightMatValue10029 then
				local var_190_8 = 1

				var_190_0.transform:SetSiblingIndex(1)

				local var_190_9 = arg_187_1.var_.highlightMatValue10029
				local var_190_10 = var_190_9.color

				var_190_10.r = var_190_8
				var_190_10.g = var_190_8
				var_190_10.b = var_190_8
				var_190_9.color = var_190_10
			end

			local var_190_11 = arg_187_1.actors_["113801_1"]
			local var_190_12 = 0

			if var_190_12 < arg_187_1.time_ and arg_187_1.time_ <= var_190_12 + arg_190_0 and not isNil(var_190_11) then
				local var_190_13 = var_190_11:GetComponent("Image")

				if var_190_13 then
					arg_187_1.var_.highlightMatValue113801_1 = var_190_13
				end
			end

			local var_190_14 = 0.2

			if var_190_12 <= arg_187_1.time_ and arg_187_1.time_ < var_190_12 + var_190_14 and not isNil(var_190_11) then
				local var_190_15 = (arg_187_1.time_ - var_190_12) / var_190_14

				if arg_187_1.var_.highlightMatValue113801_1 then
					local var_190_16 = Mathf.Lerp(1, 0.5, var_190_15)
					local var_190_17 = arg_187_1.var_.highlightMatValue113801_1
					local var_190_18 = var_190_17.color

					var_190_18.r = var_190_16
					var_190_18.g = var_190_16
					var_190_18.b = var_190_16
					var_190_17.color = var_190_18
				end
			end

			if arg_187_1.time_ >= var_190_12 + var_190_14 and arg_187_1.time_ < var_190_12 + var_190_14 + arg_190_0 and not isNil(var_190_11) and arg_187_1.var_.highlightMatValue113801_1 then
				local var_190_19 = 0.5
				local var_190_20 = arg_187_1.var_.highlightMatValue113801_1
				local var_190_21 = var_190_20.color

				var_190_21.r = var_190_19
				var_190_21.g = var_190_19
				var_190_21.b = var_190_19
				var_190_20.color = var_190_21
			end

			local var_190_22 = 0
			local var_190_23 = 0.625

			if var_190_22 < arg_187_1.time_ and arg_187_1.time_ <= var_190_22 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				local var_190_24 = arg_187_1:FormatText(StoryNameCfg[312].name)

				arg_187_1.leftNameTxt_.text = var_190_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_25 = arg_187_1:GetWordFromCfg(115311046)
				local var_190_26 = arg_187_1:FormatText(var_190_25.content)

				arg_187_1.text_.text = var_190_26

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_27 = 25
				local var_190_28 = utf8.len(var_190_26)
				local var_190_29 = var_190_27 <= 0 and var_190_23 or var_190_23 * (var_190_28 / var_190_27)

				if var_190_29 > 0 and var_190_23 < var_190_29 then
					arg_187_1.talkMaxDuration = var_190_29

					if var_190_29 + var_190_22 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_29 + var_190_22
					end
				end

				arg_187_1.text_.text = var_190_26
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311046", "story_v_out_115311.awb") ~= 0 then
					local var_190_30 = manager.audio:GetVoiceLength("story_v_out_115311", "115311046", "story_v_out_115311.awb") / 1000

					if var_190_30 + var_190_22 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_30 + var_190_22
					end

					if var_190_25.prefab_name ~= "" and arg_187_1.actors_[var_190_25.prefab_name] ~= nil then
						local var_190_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_187_1.actors_[var_190_25.prefab_name].transform, "story_v_out_115311", "115311046", "story_v_out_115311.awb")

						arg_187_1:RecordAudio("115311046", var_190_31)
						arg_187_1:RecordAudio("115311046", var_190_31)
					else
						arg_187_1:AudioAction("play", "voice", "story_v_out_115311", "115311046", "story_v_out_115311.awb")
					end

					arg_187_1:RecordHistoryTalkVoice("story_v_out_115311", "115311046", "story_v_out_115311.awb")
				end

				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_32 = math.max(var_190_23, arg_187_1.talkMaxDuration)

			if var_190_22 <= arg_187_1.time_ and arg_187_1.time_ < var_190_22 + var_190_32 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_22) / var_190_32

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_22 + var_190_32 and arg_187_1.time_ < var_190_22 + var_190_32 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {}

		arg_187_1:InitPlayNodeList()
	end,
	Play115311047 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 115311047
		arg_191_1.duration_ = 5

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play115311048(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			local var_194_0 = arg_191_1.actors_["10029"]
			local var_194_1 = 0

			if var_194_1 < arg_191_1.time_ and arg_191_1.time_ <= var_194_1 + arg_194_0 and not isNil(var_194_0) then
				local var_194_2 = var_194_0:GetComponent("Image")

				if var_194_2 then
					arg_191_1.var_.highlightMatValue10029 = var_194_2
				end
			end

			local var_194_3 = 0.2

			if var_194_1 <= arg_191_1.time_ and arg_191_1.time_ < var_194_1 + var_194_3 and not isNil(var_194_0) then
				local var_194_4 = (arg_191_1.time_ - var_194_1) / var_194_3

				if arg_191_1.var_.highlightMatValue10029 then
					local var_194_5 = Mathf.Lerp(1, 0.5, var_194_4)
					local var_194_6 = arg_191_1.var_.highlightMatValue10029
					local var_194_7 = var_194_6.color

					var_194_7.r = var_194_5
					var_194_7.g = var_194_5
					var_194_7.b = var_194_5
					var_194_6.color = var_194_7
				end
			end

			if arg_191_1.time_ >= var_194_1 + var_194_3 and arg_191_1.time_ < var_194_1 + var_194_3 + arg_194_0 and not isNil(var_194_0) and arg_191_1.var_.highlightMatValue10029 then
				local var_194_8 = 0.5
				local var_194_9 = arg_191_1.var_.highlightMatValue10029
				local var_194_10 = var_194_9.color

				var_194_10.r = var_194_8
				var_194_10.g = var_194_8
				var_194_10.b = var_194_8
				var_194_9.color = var_194_10
			end

			local var_194_11 = 0
			local var_194_12 = 1.525

			if var_194_11 < arg_191_1.time_ and arg_191_1.time_ <= var_194_11 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, false)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_13 = arg_191_1:GetWordFromCfg(115311047)
				local var_194_14 = arg_191_1:FormatText(var_194_13.content)

				arg_191_1.text_.text = var_194_14

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_15 = 61
				local var_194_16 = utf8.len(var_194_14)
				local var_194_17 = var_194_15 <= 0 and var_194_12 or var_194_12 * (var_194_16 / var_194_15)

				if var_194_17 > 0 and var_194_12 < var_194_17 then
					arg_191_1.talkMaxDuration = var_194_17

					if var_194_17 + var_194_11 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_17 + var_194_11
					end
				end

				arg_191_1.text_.text = var_194_14
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)
				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_18 = math.max(var_194_12, arg_191_1.talkMaxDuration)

			if var_194_11 <= arg_191_1.time_ and arg_191_1.time_ < var_194_11 + var_194_18 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_11) / var_194_18

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_11 + var_194_18 and arg_191_1.time_ < var_194_11 + var_194_18 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {}

		arg_191_1:InitPlayNodeList()
	end,
	Play115311048 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 115311048
		arg_195_1.duration_ = 5

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play115311049(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			local var_198_0 = 0
			local var_198_1 = 0.9

			if var_198_0 < arg_195_1.time_ and arg_195_1.time_ <= var_198_0 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, false)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_2 = arg_195_1:GetWordFromCfg(115311048)
				local var_198_3 = arg_195_1:FormatText(var_198_2.content)

				arg_195_1.text_.text = var_198_3

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_4 = 36
				local var_198_5 = utf8.len(var_198_3)
				local var_198_6 = var_198_4 <= 0 and var_198_1 or var_198_1 * (var_198_5 / var_198_4)

				if var_198_6 > 0 and var_198_1 < var_198_6 then
					arg_195_1.talkMaxDuration = var_198_6

					if var_198_6 + var_198_0 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_6 + var_198_0
					end
				end

				arg_195_1.text_.text = var_198_3
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)
				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_7 = math.max(var_198_1, arg_195_1.talkMaxDuration)

			if var_198_0 <= arg_195_1.time_ and arg_195_1.time_ < var_198_0 + var_198_7 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_0) / var_198_7

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_0 + var_198_7 and arg_195_1.time_ < var_198_0 + var_198_7 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {}

		arg_195_1:InitPlayNodeList()
	end,
	Play115311049 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 115311049
		arg_199_1.duration_ = 14.13

		local var_199_0 = {
			ja = 14.133,
			ko = 9.466,
			zh = 9.233,
			en = 10.4
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
				arg_199_0:Play115311050(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			local var_202_0 = arg_199_1.actors_["113801_1"]
			local var_202_1 = 0

			if var_202_1 < arg_199_1.time_ and arg_199_1.time_ <= var_202_1 + arg_202_0 and not isNil(var_202_0) then
				local var_202_2 = var_202_0:GetComponent("Image")

				if var_202_2 then
					arg_199_1.var_.highlightMatValue113801_1 = var_202_2
				end
			end

			local var_202_3 = 0.2

			if var_202_1 <= arg_199_1.time_ and arg_199_1.time_ < var_202_1 + var_202_3 and not isNil(var_202_0) then
				local var_202_4 = (arg_199_1.time_ - var_202_1) / var_202_3

				if arg_199_1.var_.highlightMatValue113801_1 then
					local var_202_5 = Mathf.Lerp(0.5, 1, var_202_4)
					local var_202_6 = arg_199_1.var_.highlightMatValue113801_1
					local var_202_7 = var_202_6.color

					var_202_7.r = var_202_5
					var_202_7.g = var_202_5
					var_202_7.b = var_202_5
					var_202_6.color = var_202_7
				end
			end

			if arg_199_1.time_ >= var_202_1 + var_202_3 and arg_199_1.time_ < var_202_1 + var_202_3 + arg_202_0 and not isNil(var_202_0) and arg_199_1.var_.highlightMatValue113801_1 then
				local var_202_8 = 1

				var_202_0.transform:SetSiblingIndex(1)

				local var_202_9 = arg_199_1.var_.highlightMatValue113801_1
				local var_202_10 = var_202_9.color

				var_202_10.r = var_202_8
				var_202_10.g = var_202_8
				var_202_10.b = var_202_8
				var_202_9.color = var_202_10
			end

			local var_202_11 = 0
			local var_202_12 = 0.9

			if var_202_11 < arg_199_1.time_ and arg_199_1.time_ <= var_202_11 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				local var_202_13 = arg_199_1:FormatText(StoryNameCfg[94].name)

				arg_199_1.leftNameTxt_.text = var_202_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_14 = arg_199_1:GetWordFromCfg(115311049)
				local var_202_15 = arg_199_1:FormatText(var_202_14.content)

				arg_199_1.text_.text = var_202_15

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_16 = 35
				local var_202_17 = utf8.len(var_202_15)
				local var_202_18 = var_202_16 <= 0 and var_202_12 or var_202_12 * (var_202_17 / var_202_16)

				if var_202_18 > 0 and var_202_12 < var_202_18 then
					arg_199_1.talkMaxDuration = var_202_18

					if var_202_18 + var_202_11 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_18 + var_202_11
					end
				end

				arg_199_1.text_.text = var_202_15
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311049", "story_v_out_115311.awb") ~= 0 then
					local var_202_19 = manager.audio:GetVoiceLength("story_v_out_115311", "115311049", "story_v_out_115311.awb") / 1000

					if var_202_19 + var_202_11 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_19 + var_202_11
					end

					if var_202_14.prefab_name ~= "" and arg_199_1.actors_[var_202_14.prefab_name] ~= nil then
						local var_202_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_199_1.actors_[var_202_14.prefab_name].transform, "story_v_out_115311", "115311049", "story_v_out_115311.awb")

						arg_199_1:RecordAudio("115311049", var_202_20)
						arg_199_1:RecordAudio("115311049", var_202_20)
					else
						arg_199_1:AudioAction("play", "voice", "story_v_out_115311", "115311049", "story_v_out_115311.awb")
					end

					arg_199_1:RecordHistoryTalkVoice("story_v_out_115311", "115311049", "story_v_out_115311.awb")
				end

				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_21 = math.max(var_202_12, arg_199_1.talkMaxDuration)

			if var_202_11 <= arg_199_1.time_ and arg_199_1.time_ < var_202_11 + var_202_21 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_11) / var_202_21

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_11 + var_202_21 and arg_199_1.time_ < var_202_11 + var_202_21 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {}

		arg_199_1:InitPlayNodeList()
	end,
	Play115311050 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 115311050
		arg_203_1.duration_ = 3.13

		local var_203_0 = {
			ja = 2.9,
			ko = 2.9,
			zh = 2.766,
			en = 3.133
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
				arg_203_0:Play115311051(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			local var_206_0 = arg_203_1.actors_["10029"]
			local var_206_1 = 0

			if var_206_1 < arg_203_1.time_ and arg_203_1.time_ <= var_206_1 + arg_206_0 and not isNil(var_206_0) then
				local var_206_2 = var_206_0:GetComponent("Image")

				if var_206_2 then
					arg_203_1.var_.highlightMatValue10029 = var_206_2
				end
			end

			local var_206_3 = 0.2

			if var_206_1 <= arg_203_1.time_ and arg_203_1.time_ < var_206_1 + var_206_3 and not isNil(var_206_0) then
				local var_206_4 = (arg_203_1.time_ - var_206_1) / var_206_3

				if arg_203_1.var_.highlightMatValue10029 then
					local var_206_5 = Mathf.Lerp(0.5, 1, var_206_4)
					local var_206_6 = arg_203_1.var_.highlightMatValue10029
					local var_206_7 = var_206_6.color

					var_206_7.r = var_206_5
					var_206_7.g = var_206_5
					var_206_7.b = var_206_5
					var_206_6.color = var_206_7
				end
			end

			if arg_203_1.time_ >= var_206_1 + var_206_3 and arg_203_1.time_ < var_206_1 + var_206_3 + arg_206_0 and not isNil(var_206_0) and arg_203_1.var_.highlightMatValue10029 then
				local var_206_8 = 1

				var_206_0.transform:SetSiblingIndex(1)

				local var_206_9 = arg_203_1.var_.highlightMatValue10029
				local var_206_10 = var_206_9.color

				var_206_10.r = var_206_8
				var_206_10.g = var_206_8
				var_206_10.b = var_206_8
				var_206_9.color = var_206_10
			end

			local var_206_11 = arg_203_1.actors_["113801_1"]
			local var_206_12 = 0

			if var_206_12 < arg_203_1.time_ and arg_203_1.time_ <= var_206_12 + arg_206_0 and not isNil(var_206_11) then
				local var_206_13 = var_206_11:GetComponent("Image")

				if var_206_13 then
					arg_203_1.var_.highlightMatValue113801_1 = var_206_13
				end
			end

			local var_206_14 = 0.2

			if var_206_12 <= arg_203_1.time_ and arg_203_1.time_ < var_206_12 + var_206_14 and not isNil(var_206_11) then
				local var_206_15 = (arg_203_1.time_ - var_206_12) / var_206_14

				if arg_203_1.var_.highlightMatValue113801_1 then
					local var_206_16 = Mathf.Lerp(1, 0.5, var_206_15)
					local var_206_17 = arg_203_1.var_.highlightMatValue113801_1
					local var_206_18 = var_206_17.color

					var_206_18.r = var_206_16
					var_206_18.g = var_206_16
					var_206_18.b = var_206_16
					var_206_17.color = var_206_18
				end
			end

			if arg_203_1.time_ >= var_206_12 + var_206_14 and arg_203_1.time_ < var_206_12 + var_206_14 + arg_206_0 and not isNil(var_206_11) and arg_203_1.var_.highlightMatValue113801_1 then
				local var_206_19 = 0.5
				local var_206_20 = arg_203_1.var_.highlightMatValue113801_1
				local var_206_21 = var_206_20.color

				var_206_21.r = var_206_19
				var_206_21.g = var_206_19
				var_206_21.b = var_206_19
				var_206_20.color = var_206_21
			end

			local var_206_22 = 0
			local var_206_23 = 0.175

			if var_206_22 < arg_203_1.time_ and arg_203_1.time_ <= var_206_22 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				local var_206_24 = arg_203_1:FormatText(StoryNameCfg[312].name)

				arg_203_1.leftNameTxt_.text = var_206_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_25 = arg_203_1:GetWordFromCfg(115311050)
				local var_206_26 = arg_203_1:FormatText(var_206_25.content)

				arg_203_1.text_.text = var_206_26

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_27 = 7
				local var_206_28 = utf8.len(var_206_26)
				local var_206_29 = var_206_27 <= 0 and var_206_23 or var_206_23 * (var_206_28 / var_206_27)

				if var_206_29 > 0 and var_206_23 < var_206_29 then
					arg_203_1.talkMaxDuration = var_206_29

					if var_206_29 + var_206_22 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_29 + var_206_22
					end
				end

				arg_203_1.text_.text = var_206_26
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311050", "story_v_out_115311.awb") ~= 0 then
					local var_206_30 = manager.audio:GetVoiceLength("story_v_out_115311", "115311050", "story_v_out_115311.awb") / 1000

					if var_206_30 + var_206_22 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_30 + var_206_22
					end

					if var_206_25.prefab_name ~= "" and arg_203_1.actors_[var_206_25.prefab_name] ~= nil then
						local var_206_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_25.prefab_name].transform, "story_v_out_115311", "115311050", "story_v_out_115311.awb")

						arg_203_1:RecordAudio("115311050", var_206_31)
						arg_203_1:RecordAudio("115311050", var_206_31)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_out_115311", "115311050", "story_v_out_115311.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_out_115311", "115311050", "story_v_out_115311.awb")
				end

				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_32 = math.max(var_206_23, arg_203_1.talkMaxDuration)

			if var_206_22 <= arg_203_1.time_ and arg_203_1.time_ < var_206_22 + var_206_32 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_22) / var_206_32

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_22 + var_206_32 and arg_203_1.time_ < var_206_22 + var_206_32 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {}

		arg_203_1:InitPlayNodeList()
	end,
	Play115311051 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 115311051
		arg_207_1.duration_ = 5

		SetActive(arg_207_1.tipsGo_, false)

		function arg_207_1.onSingleLineFinish_()
			arg_207_1.onSingleLineUpdate_ = nil
			arg_207_1.onSingleLineFinish_ = nil
			arg_207_1.state_ = "waiting"
		end

		function arg_207_1.playNext_(arg_209_0)
			if arg_209_0 == 1 then
				arg_207_0:Play115311052(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			local var_210_0 = arg_207_1.actors_["10029"]
			local var_210_1 = 0

			if var_210_1 < arg_207_1.time_ and arg_207_1.time_ <= var_210_1 + arg_210_0 then
				local var_210_2 = var_210_0:GetComponent("Image")

				if var_210_2 then
					arg_207_1.var_.alphaMatValue10029 = var_210_2
					arg_207_1.var_.alphaOldValue10029 = var_210_2.color.a
				end

				arg_207_1.var_.alphaOldValue10029 = 1
			end

			local var_210_3 = 0.5

			if var_210_1 <= arg_207_1.time_ and arg_207_1.time_ < var_210_1 + var_210_3 then
				local var_210_4 = (arg_207_1.time_ - var_210_1) / var_210_3
				local var_210_5 = Mathf.Lerp(arg_207_1.var_.alphaOldValue10029, 0, var_210_4)

				if arg_207_1.var_.alphaMatValue10029 then
					local var_210_6 = arg_207_1.var_.alphaMatValue10029.color

					var_210_6.a = var_210_5
					arg_207_1.var_.alphaMatValue10029.color = var_210_6
				end
			end

			if arg_207_1.time_ >= var_210_1 + var_210_3 and arg_207_1.time_ < var_210_1 + var_210_3 + arg_210_0 and arg_207_1.var_.alphaMatValue10029 then
				local var_210_7 = arg_207_1.var_.alphaMatValue10029
				local var_210_8 = var_210_7.color

				var_210_8.a = 0
				var_210_7.color = var_210_8
			end

			local var_210_9 = arg_207_1.actors_["113801_1"]
			local var_210_10 = 0

			if var_210_10 < arg_207_1.time_ and arg_207_1.time_ <= var_210_10 + arg_210_0 then
				local var_210_11 = var_210_9:GetComponent("Image")

				if var_210_11 then
					arg_207_1.var_.alphaMatValue113801_1 = var_210_11
					arg_207_1.var_.alphaOldValue113801_1 = var_210_11.color.a
				end

				arg_207_1.var_.alphaOldValue113801_1 = 1
			end

			local var_210_12 = 0.5

			if var_210_10 <= arg_207_1.time_ and arg_207_1.time_ < var_210_10 + var_210_12 then
				local var_210_13 = (arg_207_1.time_ - var_210_10) / var_210_12
				local var_210_14 = Mathf.Lerp(arg_207_1.var_.alphaOldValue113801_1, 0, var_210_13)

				if arg_207_1.var_.alphaMatValue113801_1 then
					local var_210_15 = arg_207_1.var_.alphaMatValue113801_1.color

					var_210_15.a = var_210_14
					arg_207_1.var_.alphaMatValue113801_1.color = var_210_15
				end
			end

			if arg_207_1.time_ >= var_210_10 + var_210_12 and arg_207_1.time_ < var_210_10 + var_210_12 + arg_210_0 and arg_207_1.var_.alphaMatValue113801_1 then
				local var_210_16 = arg_207_1.var_.alphaMatValue113801_1
				local var_210_17 = var_210_16.color

				var_210_17.a = 0
				var_210_16.color = var_210_17
			end

			local var_210_18 = 0
			local var_210_19 = 0.95

			if var_210_18 < arg_207_1.time_ and arg_207_1.time_ <= var_210_18 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, false)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_20 = arg_207_1:GetWordFromCfg(115311051)
				local var_210_21 = arg_207_1:FormatText(var_210_20.content)

				arg_207_1.text_.text = var_210_21

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_22 = 38
				local var_210_23 = utf8.len(var_210_21)
				local var_210_24 = var_210_22 <= 0 and var_210_19 or var_210_19 * (var_210_23 / var_210_22)

				if var_210_24 > 0 and var_210_19 < var_210_24 then
					arg_207_1.talkMaxDuration = var_210_24

					if var_210_24 + var_210_18 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_24 + var_210_18
					end
				end

				arg_207_1.text_.text = var_210_21
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)
				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_25 = math.max(var_210_19, arg_207_1.talkMaxDuration)

			if var_210_18 <= arg_207_1.time_ and arg_207_1.time_ < var_210_18 + var_210_25 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_18) / var_210_25

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_18 + var_210_25 and arg_207_1.time_ < var_210_18 + var_210_25 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {}

		arg_207_1:InitPlayNodeList()
	end,
	Play115311052 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 115311052
		arg_211_1.duration_ = 5

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play115311053(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			local var_214_0 = 0
			local var_214_1 = 1.35

			if var_214_0 < arg_211_1.time_ and arg_211_1.time_ <= var_214_0 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, false)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_2 = arg_211_1:GetWordFromCfg(115311052)
				local var_214_3 = arg_211_1:FormatText(var_214_2.content)

				arg_211_1.text_.text = var_214_3

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_4 = 54
				local var_214_5 = utf8.len(var_214_3)
				local var_214_6 = var_214_4 <= 0 and var_214_1 or var_214_1 * (var_214_5 / var_214_4)

				if var_214_6 > 0 and var_214_1 < var_214_6 then
					arg_211_1.talkMaxDuration = var_214_6

					if var_214_6 + var_214_0 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_6 + var_214_0
					end
				end

				arg_211_1.text_.text = var_214_3
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)
				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_7 = math.max(var_214_1, arg_211_1.talkMaxDuration)

			if var_214_0 <= arg_211_1.time_ and arg_211_1.time_ < var_214_0 + var_214_7 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_0) / var_214_7

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_0 + var_214_7 and arg_211_1.time_ < var_214_0 + var_214_7 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {}

		arg_211_1:InitPlayNodeList()
	end,
	Play115311053 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 115311053
		arg_215_1.duration_ = 7.03

		local var_215_0 = {
			ja = 7.033,
			ko = 3.9,
			zh = 4.8,
			en = 6.333
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
				arg_215_0:Play115311054(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			local var_218_0 = arg_215_1.actors_["10029"]
			local var_218_1 = 0

			if var_218_1 < arg_215_1.time_ and arg_215_1.time_ <= var_218_1 + arg_218_0 then
				local var_218_2 = var_218_0:GetComponent("Image")

				if var_218_2 then
					arg_215_1.var_.alphaMatValue10029 = var_218_2
					arg_215_1.var_.alphaOldValue10029 = var_218_2.color.a
				end

				arg_215_1.var_.alphaOldValue10029 = 0
			end

			local var_218_3 = 0.5

			if var_218_1 <= arg_215_1.time_ and arg_215_1.time_ < var_218_1 + var_218_3 then
				local var_218_4 = (arg_215_1.time_ - var_218_1) / var_218_3
				local var_218_5 = Mathf.Lerp(arg_215_1.var_.alphaOldValue10029, 1, var_218_4)

				if arg_215_1.var_.alphaMatValue10029 then
					local var_218_6 = arg_215_1.var_.alphaMatValue10029.color

					var_218_6.a = var_218_5
					arg_215_1.var_.alphaMatValue10029.color = var_218_6
				end
			end

			if arg_215_1.time_ >= var_218_1 + var_218_3 and arg_215_1.time_ < var_218_1 + var_218_3 + arg_218_0 and arg_215_1.var_.alphaMatValue10029 then
				local var_218_7 = arg_215_1.var_.alphaMatValue10029
				local var_218_8 = var_218_7.color

				var_218_8.a = 1
				var_218_7.color = var_218_8
			end

			local var_218_9 = arg_215_1.actors_["113801_1"]
			local var_218_10 = 0

			if var_218_10 < arg_215_1.time_ and arg_215_1.time_ <= var_218_10 + arg_218_0 then
				local var_218_11 = var_218_9:GetComponent("Image")

				if var_218_11 then
					arg_215_1.var_.alphaMatValue113801_1 = var_218_11
					arg_215_1.var_.alphaOldValue113801_1 = var_218_11.color.a
				end

				arg_215_1.var_.alphaOldValue113801_1 = 0
			end

			local var_218_12 = 0.5

			if var_218_10 <= arg_215_1.time_ and arg_215_1.time_ < var_218_10 + var_218_12 then
				local var_218_13 = (arg_215_1.time_ - var_218_10) / var_218_12
				local var_218_14 = Mathf.Lerp(arg_215_1.var_.alphaOldValue113801_1, 1, var_218_13)

				if arg_215_1.var_.alphaMatValue113801_1 then
					local var_218_15 = arg_215_1.var_.alphaMatValue113801_1.color

					var_218_15.a = var_218_14
					arg_215_1.var_.alphaMatValue113801_1.color = var_218_15
				end
			end

			if arg_215_1.time_ >= var_218_10 + var_218_12 and arg_215_1.time_ < var_218_10 + var_218_12 + arg_218_0 and arg_215_1.var_.alphaMatValue113801_1 then
				local var_218_16 = arg_215_1.var_.alphaMatValue113801_1
				local var_218_17 = var_218_16.color

				var_218_17.a = 1
				var_218_16.color = var_218_17
			end

			local var_218_18 = arg_215_1.actors_["10029"]
			local var_218_19 = 0

			if var_218_19 < arg_215_1.time_ and arg_215_1.time_ <= var_218_19 + arg_218_0 and not isNil(var_218_18) then
				local var_218_20 = var_218_18:GetComponent("Image")

				if var_218_20 then
					arg_215_1.var_.highlightMatValue10029 = var_218_20
				end
			end

			local var_218_21 = 0.2

			if var_218_19 <= arg_215_1.time_ and arg_215_1.time_ < var_218_19 + var_218_21 and not isNil(var_218_18) then
				local var_218_22 = (arg_215_1.time_ - var_218_19) / var_218_21

				if arg_215_1.var_.highlightMatValue10029 then
					local var_218_23 = Mathf.Lerp(0.5, 1, var_218_22)
					local var_218_24 = arg_215_1.var_.highlightMatValue10029
					local var_218_25 = var_218_24.color

					var_218_25.r = var_218_23
					var_218_25.g = var_218_23
					var_218_25.b = var_218_23
					var_218_24.color = var_218_25
				end
			end

			if arg_215_1.time_ >= var_218_19 + var_218_21 and arg_215_1.time_ < var_218_19 + var_218_21 + arg_218_0 and not isNil(var_218_18) and arg_215_1.var_.highlightMatValue10029 then
				local var_218_26 = 1

				var_218_18.transform:SetSiblingIndex(1)

				local var_218_27 = arg_215_1.var_.highlightMatValue10029
				local var_218_28 = var_218_27.color

				var_218_28.r = var_218_26
				var_218_28.g = var_218_26
				var_218_28.b = var_218_26
				var_218_27.color = var_218_28
			end

			local var_218_29 = 0
			local var_218_30 = 0.425

			if var_218_29 < arg_215_1.time_ and arg_215_1.time_ <= var_218_29 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				local var_218_31 = arg_215_1:FormatText(StoryNameCfg[312].name)

				arg_215_1.leftNameTxt_.text = var_218_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_32 = arg_215_1:GetWordFromCfg(115311053)
				local var_218_33 = arg_215_1:FormatText(var_218_32.content)

				arg_215_1.text_.text = var_218_33

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_34 = 17
				local var_218_35 = utf8.len(var_218_33)
				local var_218_36 = var_218_34 <= 0 and var_218_30 or var_218_30 * (var_218_35 / var_218_34)

				if var_218_36 > 0 and var_218_30 < var_218_36 then
					arg_215_1.talkMaxDuration = var_218_36

					if var_218_36 + var_218_29 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_36 + var_218_29
					end
				end

				arg_215_1.text_.text = var_218_33
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311053", "story_v_out_115311.awb") ~= 0 then
					local var_218_37 = manager.audio:GetVoiceLength("story_v_out_115311", "115311053", "story_v_out_115311.awb") / 1000

					if var_218_37 + var_218_29 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_37 + var_218_29
					end

					if var_218_32.prefab_name ~= "" and arg_215_1.actors_[var_218_32.prefab_name] ~= nil then
						local var_218_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_215_1.actors_[var_218_32.prefab_name].transform, "story_v_out_115311", "115311053", "story_v_out_115311.awb")

						arg_215_1:RecordAudio("115311053", var_218_38)
						arg_215_1:RecordAudio("115311053", var_218_38)
					else
						arg_215_1:AudioAction("play", "voice", "story_v_out_115311", "115311053", "story_v_out_115311.awb")
					end

					arg_215_1:RecordHistoryTalkVoice("story_v_out_115311", "115311053", "story_v_out_115311.awb")
				end

				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_39 = math.max(var_218_30, arg_215_1.talkMaxDuration)

			if var_218_29 <= arg_215_1.time_ and arg_215_1.time_ < var_218_29 + var_218_39 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_29) / var_218_39

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_29 + var_218_39 and arg_215_1.time_ < var_218_29 + var_218_39 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {}

		arg_215_1:InitPlayNodeList()
	end,
	Play115311054 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 115311054
		arg_219_1.duration_ = 10.5

		local var_219_0 = {
			ja = 10.5,
			ko = 8.5,
			zh = 7.133,
			en = 10.166
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
				arg_219_0:Play115311055(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			local var_222_0 = arg_219_1.actors_["10029"]
			local var_222_1 = 0

			if var_222_1 < arg_219_1.time_ and arg_219_1.time_ <= var_222_1 + arg_222_0 and not isNil(var_222_0) then
				local var_222_2 = var_222_0:GetComponent("Image")

				if var_222_2 then
					arg_219_1.var_.highlightMatValue10029 = var_222_2
				end
			end

			local var_222_3 = 0.2

			if var_222_1 <= arg_219_1.time_ and arg_219_1.time_ < var_222_1 + var_222_3 and not isNil(var_222_0) then
				local var_222_4 = (arg_219_1.time_ - var_222_1) / var_222_3

				if arg_219_1.var_.highlightMatValue10029 then
					local var_222_5 = Mathf.Lerp(1, 0.5, var_222_4)
					local var_222_6 = arg_219_1.var_.highlightMatValue10029
					local var_222_7 = var_222_6.color

					var_222_7.r = var_222_5
					var_222_7.g = var_222_5
					var_222_7.b = var_222_5
					var_222_6.color = var_222_7
				end
			end

			if arg_219_1.time_ >= var_222_1 + var_222_3 and arg_219_1.time_ < var_222_1 + var_222_3 + arg_222_0 and not isNil(var_222_0) and arg_219_1.var_.highlightMatValue10029 then
				local var_222_8 = 0.5
				local var_222_9 = arg_219_1.var_.highlightMatValue10029
				local var_222_10 = var_222_9.color

				var_222_10.r = var_222_8
				var_222_10.g = var_222_8
				var_222_10.b = var_222_8
				var_222_9.color = var_222_10
			end

			local var_222_11 = arg_219_1.actors_["113801_1"]
			local var_222_12 = 0

			if var_222_12 < arg_219_1.time_ and arg_219_1.time_ <= var_222_12 + arg_222_0 and not isNil(var_222_11) then
				local var_222_13 = var_222_11:GetComponent("Image")

				if var_222_13 then
					arg_219_1.var_.highlightMatValue113801_1 = var_222_13
				end
			end

			local var_222_14 = 0.2

			if var_222_12 <= arg_219_1.time_ and arg_219_1.time_ < var_222_12 + var_222_14 and not isNil(var_222_11) then
				local var_222_15 = (arg_219_1.time_ - var_222_12) / var_222_14

				if arg_219_1.var_.highlightMatValue113801_1 then
					local var_222_16 = Mathf.Lerp(0.5, 1, var_222_15)
					local var_222_17 = arg_219_1.var_.highlightMatValue113801_1
					local var_222_18 = var_222_17.color

					var_222_18.r = var_222_16
					var_222_18.g = var_222_16
					var_222_18.b = var_222_16
					var_222_17.color = var_222_18
				end
			end

			if arg_219_1.time_ >= var_222_12 + var_222_14 and arg_219_1.time_ < var_222_12 + var_222_14 + arg_222_0 and not isNil(var_222_11) and arg_219_1.var_.highlightMatValue113801_1 then
				local var_222_19 = 1

				var_222_11.transform:SetSiblingIndex(1)

				local var_222_20 = arg_219_1.var_.highlightMatValue113801_1
				local var_222_21 = var_222_20.color

				var_222_21.r = var_222_19
				var_222_21.g = var_222_19
				var_222_21.b = var_222_19
				var_222_20.color = var_222_21
			end

			local var_222_22 = 0
			local var_222_23 = 0.775

			if var_222_22 < arg_219_1.time_ and arg_219_1.time_ <= var_222_22 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, true)

				local var_222_24 = arg_219_1:FormatText(StoryNameCfg[94].name)

				arg_219_1.leftNameTxt_.text = var_222_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_219_1.leftNameTxt_.transform)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1.leftNameTxt_.text)
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_25 = arg_219_1:GetWordFromCfg(115311054)
				local var_222_26 = arg_219_1:FormatText(var_222_25.content)

				arg_219_1.text_.text = var_222_26

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_27 = 31
				local var_222_28 = utf8.len(var_222_26)
				local var_222_29 = var_222_27 <= 0 and var_222_23 or var_222_23 * (var_222_28 / var_222_27)

				if var_222_29 > 0 and var_222_23 < var_222_29 then
					arg_219_1.talkMaxDuration = var_222_29

					if var_222_29 + var_222_22 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_29 + var_222_22
					end
				end

				arg_219_1.text_.text = var_222_26
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311054", "story_v_out_115311.awb") ~= 0 then
					local var_222_30 = manager.audio:GetVoiceLength("story_v_out_115311", "115311054", "story_v_out_115311.awb") / 1000

					if var_222_30 + var_222_22 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_30 + var_222_22
					end

					if var_222_25.prefab_name ~= "" and arg_219_1.actors_[var_222_25.prefab_name] ~= nil then
						local var_222_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_219_1.actors_[var_222_25.prefab_name].transform, "story_v_out_115311", "115311054", "story_v_out_115311.awb")

						arg_219_1:RecordAudio("115311054", var_222_31)
						arg_219_1:RecordAudio("115311054", var_222_31)
					else
						arg_219_1:AudioAction("play", "voice", "story_v_out_115311", "115311054", "story_v_out_115311.awb")
					end

					arg_219_1:RecordHistoryTalkVoice("story_v_out_115311", "115311054", "story_v_out_115311.awb")
				end

				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_32 = math.max(var_222_23, arg_219_1.talkMaxDuration)

			if var_222_22 <= arg_219_1.time_ and arg_219_1.time_ < var_222_22 + var_222_32 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_22) / var_222_32

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_22 + var_222_32 and arg_219_1.time_ < var_222_22 + var_222_32 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {}

		arg_219_1:InitPlayNodeList()
	end,
	Play115311055 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 115311055
		arg_223_1.duration_ = 5

		SetActive(arg_223_1.tipsGo_, false)

		function arg_223_1.onSingleLineFinish_()
			arg_223_1.onSingleLineUpdate_ = nil
			arg_223_1.onSingleLineFinish_ = nil
			arg_223_1.state_ = "waiting"
		end

		function arg_223_1.playNext_(arg_225_0)
			if arg_225_0 == 1 then
				arg_223_0:Play115311056(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			local var_226_0 = arg_223_1.actors_["113801_1"]
			local var_226_1 = 0

			if var_226_1 < arg_223_1.time_ and arg_223_1.time_ <= var_226_1 + arg_226_0 and not isNil(var_226_0) then
				local var_226_2 = var_226_0:GetComponent("Image")

				if var_226_2 then
					arg_223_1.var_.highlightMatValue113801_1 = var_226_2
				end
			end

			local var_226_3 = 0.2

			if var_226_1 <= arg_223_1.time_ and arg_223_1.time_ < var_226_1 + var_226_3 and not isNil(var_226_0) then
				local var_226_4 = (arg_223_1.time_ - var_226_1) / var_226_3

				if arg_223_1.var_.highlightMatValue113801_1 then
					local var_226_5 = Mathf.Lerp(1, 0.5, var_226_4)
					local var_226_6 = arg_223_1.var_.highlightMatValue113801_1
					local var_226_7 = var_226_6.color

					var_226_7.r = var_226_5
					var_226_7.g = var_226_5
					var_226_7.b = var_226_5
					var_226_6.color = var_226_7
				end
			end

			if arg_223_1.time_ >= var_226_1 + var_226_3 and arg_223_1.time_ < var_226_1 + var_226_3 + arg_226_0 and not isNil(var_226_0) and arg_223_1.var_.highlightMatValue113801_1 then
				local var_226_8 = 0.5
				local var_226_9 = arg_223_1.var_.highlightMatValue113801_1
				local var_226_10 = var_226_9.color

				var_226_10.r = var_226_8
				var_226_10.g = var_226_8
				var_226_10.b = var_226_8
				var_226_9.color = var_226_10
			end

			local var_226_11 = 0
			local var_226_12 = 1.05

			if var_226_11 < arg_223_1.time_ and arg_223_1.time_ <= var_226_11 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, false)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_223_1.iconTrs_.gameObject, false)
				arg_223_1.callingController_:SetSelectedState("normal")

				local var_226_13 = arg_223_1:GetWordFromCfg(115311055)
				local var_226_14 = arg_223_1:FormatText(var_226_13.content)

				arg_223_1.text_.text = var_226_14

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_15 = 42
				local var_226_16 = utf8.len(var_226_14)
				local var_226_17 = var_226_15 <= 0 and var_226_12 or var_226_12 * (var_226_16 / var_226_15)

				if var_226_17 > 0 and var_226_12 < var_226_17 then
					arg_223_1.talkMaxDuration = var_226_17

					if var_226_17 + var_226_11 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_17 + var_226_11
					end
				end

				arg_223_1.text_.text = var_226_14
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)
				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_18 = math.max(var_226_12, arg_223_1.talkMaxDuration)

			if var_226_11 <= arg_223_1.time_ and arg_223_1.time_ < var_226_11 + var_226_18 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_11) / var_226_18

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_11 + var_226_18 and arg_223_1.time_ < var_226_11 + var_226_18 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {}

		arg_223_1:InitPlayNodeList()
	end,
	Play115311056 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 115311056
		arg_227_1.duration_ = 5

		SetActive(arg_227_1.tipsGo_, false)

		function arg_227_1.onSingleLineFinish_()
			arg_227_1.onSingleLineUpdate_ = nil
			arg_227_1.onSingleLineFinish_ = nil
			arg_227_1.state_ = "waiting"
		end

		function arg_227_1.playNext_(arg_229_0)
			if arg_229_0 == 1 then
				arg_227_0:Play115311057(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			local var_230_0 = 0
			local var_230_1 = 0.4

			if var_230_0 < arg_227_1.time_ and arg_227_1.time_ <= var_230_0 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, false)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_227_1.iconTrs_.gameObject, false)
				arg_227_1.callingController_:SetSelectedState("normal")

				local var_230_2 = arg_227_1:GetWordFromCfg(115311056)
				local var_230_3 = arg_227_1:FormatText(var_230_2.content)

				arg_227_1.text_.text = var_230_3

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_4 = 16
				local var_230_5 = utf8.len(var_230_3)
				local var_230_6 = var_230_4 <= 0 and var_230_1 or var_230_1 * (var_230_5 / var_230_4)

				if var_230_6 > 0 and var_230_1 < var_230_6 then
					arg_227_1.talkMaxDuration = var_230_6

					if var_230_6 + var_230_0 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_6 + var_230_0
					end
				end

				arg_227_1.text_.text = var_230_3
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)
				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_7 = math.max(var_230_1, arg_227_1.talkMaxDuration)

			if var_230_0 <= arg_227_1.time_ and arg_227_1.time_ < var_230_0 + var_230_7 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_0) / var_230_7

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_0 + var_230_7 and arg_227_1.time_ < var_230_0 + var_230_7 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {}

		arg_227_1:InitPlayNodeList()
	end,
	Play115311057 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 115311057
		arg_231_1.duration_ = 9.9

		local var_231_0 = {
			ja = 9.9,
			ko = 7.1,
			zh = 6.066,
			en = 8.533
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
				arg_231_0:Play115311058(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			local var_234_0 = arg_231_1.actors_["10029"]
			local var_234_1 = 0

			if var_234_1 < arg_231_1.time_ and arg_231_1.time_ <= var_234_1 + arg_234_0 and not isNil(var_234_0) then
				local var_234_2 = var_234_0:GetComponent("Image")

				if var_234_2 then
					arg_231_1.var_.highlightMatValue10029 = var_234_2
				end
			end

			local var_234_3 = 0.2

			if var_234_1 <= arg_231_1.time_ and arg_231_1.time_ < var_234_1 + var_234_3 and not isNil(var_234_0) then
				local var_234_4 = (arg_231_1.time_ - var_234_1) / var_234_3

				if arg_231_1.var_.highlightMatValue10029 then
					local var_234_5 = Mathf.Lerp(0.5, 1, var_234_4)
					local var_234_6 = arg_231_1.var_.highlightMatValue10029
					local var_234_7 = var_234_6.color

					var_234_7.r = var_234_5
					var_234_7.g = var_234_5
					var_234_7.b = var_234_5
					var_234_6.color = var_234_7
				end
			end

			if arg_231_1.time_ >= var_234_1 + var_234_3 and arg_231_1.time_ < var_234_1 + var_234_3 + arg_234_0 and not isNil(var_234_0) and arg_231_1.var_.highlightMatValue10029 then
				local var_234_8 = 1

				var_234_0.transform:SetSiblingIndex(1)

				local var_234_9 = arg_231_1.var_.highlightMatValue10029
				local var_234_10 = var_234_9.color

				var_234_10.r = var_234_8
				var_234_10.g = var_234_8
				var_234_10.b = var_234_8
				var_234_9.color = var_234_10
			end

			local var_234_11 = 0
			local var_234_12 = 0.725

			if var_234_11 < arg_231_1.time_ and arg_231_1.time_ <= var_234_11 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, true)

				local var_234_13 = arg_231_1:FormatText(StoryNameCfg[312].name)

				arg_231_1.leftNameTxt_.text = var_234_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, false)
				arg_231_1.callingController_:SetSelectedState("normal")

				local var_234_14 = arg_231_1:GetWordFromCfg(115311057)
				local var_234_15 = arg_231_1:FormatText(var_234_14.content)

				arg_231_1.text_.text = var_234_15

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_16 = 29
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

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311057", "story_v_out_115311.awb") ~= 0 then
					local var_234_19 = manager.audio:GetVoiceLength("story_v_out_115311", "115311057", "story_v_out_115311.awb") / 1000

					if var_234_19 + var_234_11 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_19 + var_234_11
					end

					if var_234_14.prefab_name ~= "" and arg_231_1.actors_[var_234_14.prefab_name] ~= nil then
						local var_234_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_231_1.actors_[var_234_14.prefab_name].transform, "story_v_out_115311", "115311057", "story_v_out_115311.awb")

						arg_231_1:RecordAudio("115311057", var_234_20)
						arg_231_1:RecordAudio("115311057", var_234_20)
					else
						arg_231_1:AudioAction("play", "voice", "story_v_out_115311", "115311057", "story_v_out_115311.awb")
					end

					arg_231_1:RecordHistoryTalkVoice("story_v_out_115311", "115311057", "story_v_out_115311.awb")
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
	Play115311058 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 115311058
		arg_235_1.duration_ = 10.7

		local var_235_0 = {
			ja = 8.8,
			ko = 7.1,
			zh = 7.433,
			en = 10.7
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
				arg_235_0:Play115311059(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			local var_238_0 = arg_235_1.actors_["10029"]
			local var_238_1 = 0

			if var_238_1 < arg_235_1.time_ and arg_235_1.time_ <= var_238_1 + arg_238_0 and not isNil(var_238_0) then
				local var_238_2 = var_238_0:GetComponent("Image")

				if var_238_2 then
					arg_235_1.var_.highlightMatValue10029 = var_238_2
				end
			end

			local var_238_3 = 0.2

			if var_238_1 <= arg_235_1.time_ and arg_235_1.time_ < var_238_1 + var_238_3 and not isNil(var_238_0) then
				local var_238_4 = (arg_235_1.time_ - var_238_1) / var_238_3

				if arg_235_1.var_.highlightMatValue10029 then
					local var_238_5 = Mathf.Lerp(1, 0.5, var_238_4)
					local var_238_6 = arg_235_1.var_.highlightMatValue10029
					local var_238_7 = var_238_6.color

					var_238_7.r = var_238_5
					var_238_7.g = var_238_5
					var_238_7.b = var_238_5
					var_238_6.color = var_238_7
				end
			end

			if arg_235_1.time_ >= var_238_1 + var_238_3 and arg_235_1.time_ < var_238_1 + var_238_3 + arg_238_0 and not isNil(var_238_0) and arg_235_1.var_.highlightMatValue10029 then
				local var_238_8 = 0.5
				local var_238_9 = arg_235_1.var_.highlightMatValue10029
				local var_238_10 = var_238_9.color

				var_238_10.r = var_238_8
				var_238_10.g = var_238_8
				var_238_10.b = var_238_8
				var_238_9.color = var_238_10
			end

			local var_238_11 = arg_235_1.actors_["113801_1"]
			local var_238_12 = 0

			if var_238_12 < arg_235_1.time_ and arg_235_1.time_ <= var_238_12 + arg_238_0 and not isNil(var_238_11) then
				local var_238_13 = var_238_11:GetComponent("Image")

				if var_238_13 then
					arg_235_1.var_.highlightMatValue113801_1 = var_238_13
				end
			end

			local var_238_14 = 0.2

			if var_238_12 <= arg_235_1.time_ and arg_235_1.time_ < var_238_12 + var_238_14 and not isNil(var_238_11) then
				local var_238_15 = (arg_235_1.time_ - var_238_12) / var_238_14

				if arg_235_1.var_.highlightMatValue113801_1 then
					local var_238_16 = Mathf.Lerp(0.5, 1, var_238_15)
					local var_238_17 = arg_235_1.var_.highlightMatValue113801_1
					local var_238_18 = var_238_17.color

					var_238_18.r = var_238_16
					var_238_18.g = var_238_16
					var_238_18.b = var_238_16
					var_238_17.color = var_238_18
				end
			end

			if arg_235_1.time_ >= var_238_12 + var_238_14 and arg_235_1.time_ < var_238_12 + var_238_14 + arg_238_0 and not isNil(var_238_11) and arg_235_1.var_.highlightMatValue113801_1 then
				local var_238_19 = 1

				var_238_11.transform:SetSiblingIndex(1)

				local var_238_20 = arg_235_1.var_.highlightMatValue113801_1
				local var_238_21 = var_238_20.color

				var_238_21.r = var_238_19
				var_238_21.g = var_238_19
				var_238_21.b = var_238_19
				var_238_20.color = var_238_21
			end

			local var_238_22 = 0
			local var_238_23 = 0.6

			if var_238_22 < arg_235_1.time_ and arg_235_1.time_ <= var_238_22 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, true)

				local var_238_24 = arg_235_1:FormatText(StoryNameCfg[94].name)

				arg_235_1.leftNameTxt_.text = var_238_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, false)
				arg_235_1.callingController_:SetSelectedState("normal")

				local var_238_25 = arg_235_1:GetWordFromCfg(115311058)
				local var_238_26 = arg_235_1:FormatText(var_238_25.content)

				arg_235_1.text_.text = var_238_26

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_27 = 24
				local var_238_28 = utf8.len(var_238_26)
				local var_238_29 = var_238_27 <= 0 and var_238_23 or var_238_23 * (var_238_28 / var_238_27)

				if var_238_29 > 0 and var_238_23 < var_238_29 then
					arg_235_1.talkMaxDuration = var_238_29

					if var_238_29 + var_238_22 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_29 + var_238_22
					end
				end

				arg_235_1.text_.text = var_238_26
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311058", "story_v_out_115311.awb") ~= 0 then
					local var_238_30 = manager.audio:GetVoiceLength("story_v_out_115311", "115311058", "story_v_out_115311.awb") / 1000

					if var_238_30 + var_238_22 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_30 + var_238_22
					end

					if var_238_25.prefab_name ~= "" and arg_235_1.actors_[var_238_25.prefab_name] ~= nil then
						local var_238_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_235_1.actors_[var_238_25.prefab_name].transform, "story_v_out_115311", "115311058", "story_v_out_115311.awb")

						arg_235_1:RecordAudio("115311058", var_238_31)
						arg_235_1:RecordAudio("115311058", var_238_31)
					else
						arg_235_1:AudioAction("play", "voice", "story_v_out_115311", "115311058", "story_v_out_115311.awb")
					end

					arg_235_1:RecordHistoryTalkVoice("story_v_out_115311", "115311058", "story_v_out_115311.awb")
				end

				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_32 = math.max(var_238_23, arg_235_1.talkMaxDuration)

			if var_238_22 <= arg_235_1.time_ and arg_235_1.time_ < var_238_22 + var_238_32 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_22) / var_238_32

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_22 + var_238_32 and arg_235_1.time_ < var_238_22 + var_238_32 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {}

		arg_235_1:InitPlayNodeList()
	end,
	Play115311059 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 115311059
		arg_239_1.duration_ = 19.5

		local var_239_0 = {
			ja = 19.5,
			ko = 6.433,
			zh = 7.366,
			en = 6.033
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
				arg_239_0:Play115311060(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			local var_242_0 = 0
			local var_242_1 = 0.725

			if var_242_0 < arg_239_1.time_ and arg_239_1.time_ <= var_242_0 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, true)

				local var_242_2 = arg_239_1:FormatText(StoryNameCfg[94].name)

				arg_239_1.leftNameTxt_.text = var_242_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_239_1.leftNameTxt_.transform)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1.leftNameTxt_.text)
				SetActive(arg_239_1.iconTrs_.gameObject, false)
				arg_239_1.callingController_:SetSelectedState("normal")

				local var_242_3 = arg_239_1:GetWordFromCfg(115311059)
				local var_242_4 = arg_239_1:FormatText(var_242_3.content)

				arg_239_1.text_.text = var_242_4

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_5 = 29
				local var_242_6 = utf8.len(var_242_4)
				local var_242_7 = var_242_5 <= 0 and var_242_1 or var_242_1 * (var_242_6 / var_242_5)

				if var_242_7 > 0 and var_242_1 < var_242_7 then
					arg_239_1.talkMaxDuration = var_242_7

					if var_242_7 + var_242_0 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_7 + var_242_0
					end
				end

				arg_239_1.text_.text = var_242_4
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311059", "story_v_out_115311.awb") ~= 0 then
					local var_242_8 = manager.audio:GetVoiceLength("story_v_out_115311", "115311059", "story_v_out_115311.awb") / 1000

					if var_242_8 + var_242_0 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_8 + var_242_0
					end

					if var_242_3.prefab_name ~= "" and arg_239_1.actors_[var_242_3.prefab_name] ~= nil then
						local var_242_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_239_1.actors_[var_242_3.prefab_name].transform, "story_v_out_115311", "115311059", "story_v_out_115311.awb")

						arg_239_1:RecordAudio("115311059", var_242_9)
						arg_239_1:RecordAudio("115311059", var_242_9)
					else
						arg_239_1:AudioAction("play", "voice", "story_v_out_115311", "115311059", "story_v_out_115311.awb")
					end

					arg_239_1:RecordHistoryTalkVoice("story_v_out_115311", "115311059", "story_v_out_115311.awb")
				end

				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_10 = math.max(var_242_1, arg_239_1.talkMaxDuration)

			if var_242_0 <= arg_239_1.time_ and arg_239_1.time_ < var_242_0 + var_242_10 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_0) / var_242_10

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_0 + var_242_10 and arg_239_1.time_ < var_242_0 + var_242_10 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {}

		arg_239_1:InitPlayNodeList()
	end,
	Play115311060 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 115311060
		arg_243_1.duration_ = 1.57

		local var_243_0 = {
			ja = 1.133,
			ko = 1.2,
			zh = 1.533,
			en = 1.566
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
				arg_243_0:Play115311061(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			local var_246_0 = arg_243_1.actors_["10029"]
			local var_246_1 = 0

			if var_246_1 < arg_243_1.time_ and arg_243_1.time_ <= var_246_1 + arg_246_0 and not isNil(var_246_0) then
				local var_246_2 = var_246_0:GetComponent("Image")

				if var_246_2 then
					arg_243_1.var_.highlightMatValue10029 = var_246_2
				end
			end

			local var_246_3 = 0.2

			if var_246_1 <= arg_243_1.time_ and arg_243_1.time_ < var_246_1 + var_246_3 and not isNil(var_246_0) then
				local var_246_4 = (arg_243_1.time_ - var_246_1) / var_246_3

				if arg_243_1.var_.highlightMatValue10029 then
					local var_246_5 = Mathf.Lerp(0.5, 1, var_246_4)
					local var_246_6 = arg_243_1.var_.highlightMatValue10029
					local var_246_7 = var_246_6.color

					var_246_7.r = var_246_5
					var_246_7.g = var_246_5
					var_246_7.b = var_246_5
					var_246_6.color = var_246_7
				end
			end

			if arg_243_1.time_ >= var_246_1 + var_246_3 and arg_243_1.time_ < var_246_1 + var_246_3 + arg_246_0 and not isNil(var_246_0) and arg_243_1.var_.highlightMatValue10029 then
				local var_246_8 = 1

				var_246_0.transform:SetSiblingIndex(1)

				local var_246_9 = arg_243_1.var_.highlightMatValue10029
				local var_246_10 = var_246_9.color

				var_246_10.r = var_246_8
				var_246_10.g = var_246_8
				var_246_10.b = var_246_8
				var_246_9.color = var_246_10
			end

			local var_246_11 = arg_243_1.actors_["113801_1"]
			local var_246_12 = 0

			if var_246_12 < arg_243_1.time_ and arg_243_1.time_ <= var_246_12 + arg_246_0 and not isNil(var_246_11) then
				local var_246_13 = var_246_11:GetComponent("Image")

				if var_246_13 then
					arg_243_1.var_.highlightMatValue113801_1 = var_246_13
				end
			end

			local var_246_14 = 0.2

			if var_246_12 <= arg_243_1.time_ and arg_243_1.time_ < var_246_12 + var_246_14 and not isNil(var_246_11) then
				local var_246_15 = (arg_243_1.time_ - var_246_12) / var_246_14

				if arg_243_1.var_.highlightMatValue113801_1 then
					local var_246_16 = Mathf.Lerp(1, 0.5, var_246_15)
					local var_246_17 = arg_243_1.var_.highlightMatValue113801_1
					local var_246_18 = var_246_17.color

					var_246_18.r = var_246_16
					var_246_18.g = var_246_16
					var_246_18.b = var_246_16
					var_246_17.color = var_246_18
				end
			end

			if arg_243_1.time_ >= var_246_12 + var_246_14 and arg_243_1.time_ < var_246_12 + var_246_14 + arg_246_0 and not isNil(var_246_11) and arg_243_1.var_.highlightMatValue113801_1 then
				local var_246_19 = 0.5
				local var_246_20 = arg_243_1.var_.highlightMatValue113801_1
				local var_246_21 = var_246_20.color

				var_246_21.r = var_246_19
				var_246_21.g = var_246_19
				var_246_21.b = var_246_19
				var_246_20.color = var_246_21
			end

			local var_246_22 = 0
			local var_246_23 = 0.075

			if var_246_22 < arg_243_1.time_ and arg_243_1.time_ <= var_246_22 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, true)

				local var_246_24 = arg_243_1:FormatText(StoryNameCfg[312].name)

				arg_243_1.leftNameTxt_.text = var_246_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, false)
				arg_243_1.callingController_:SetSelectedState("normal")

				local var_246_25 = arg_243_1:GetWordFromCfg(115311060)
				local var_246_26 = arg_243_1:FormatText(var_246_25.content)

				arg_243_1.text_.text = var_246_26

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_27 = 3
				local var_246_28 = utf8.len(var_246_26)
				local var_246_29 = var_246_27 <= 0 and var_246_23 or var_246_23 * (var_246_28 / var_246_27)

				if var_246_29 > 0 and var_246_23 < var_246_29 then
					arg_243_1.talkMaxDuration = var_246_29

					if var_246_29 + var_246_22 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_29 + var_246_22
					end
				end

				arg_243_1.text_.text = var_246_26
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311060", "story_v_out_115311.awb") ~= 0 then
					local var_246_30 = manager.audio:GetVoiceLength("story_v_out_115311", "115311060", "story_v_out_115311.awb") / 1000

					if var_246_30 + var_246_22 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_30 + var_246_22
					end

					if var_246_25.prefab_name ~= "" and arg_243_1.actors_[var_246_25.prefab_name] ~= nil then
						local var_246_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_243_1.actors_[var_246_25.prefab_name].transform, "story_v_out_115311", "115311060", "story_v_out_115311.awb")

						arg_243_1:RecordAudio("115311060", var_246_31)
						arg_243_1:RecordAudio("115311060", var_246_31)
					else
						arg_243_1:AudioAction("play", "voice", "story_v_out_115311", "115311060", "story_v_out_115311.awb")
					end

					arg_243_1:RecordHistoryTalkVoice("story_v_out_115311", "115311060", "story_v_out_115311.awb")
				end

				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_32 = math.max(var_246_23, arg_243_1.talkMaxDuration)

			if var_246_22 <= arg_243_1.time_ and arg_243_1.time_ < var_246_22 + var_246_32 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_22) / var_246_32

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_22 + var_246_32 and arg_243_1.time_ < var_246_22 + var_246_32 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {}

		arg_243_1:InitPlayNodeList()
	end,
	Play115311061 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 115311061
		arg_247_1.duration_ = 8.2

		local var_247_0 = {
			ja = 8.2,
			ko = 7.4,
			zh = 7.7,
			en = 8
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
				arg_247_0:Play115311062(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			local var_250_0 = arg_247_1.actors_["10029"]
			local var_250_1 = 0

			if var_250_1 < arg_247_1.time_ and arg_247_1.time_ <= var_250_1 + arg_250_0 and not isNil(var_250_0) then
				local var_250_2 = var_250_0:GetComponent("Image")

				if var_250_2 then
					arg_247_1.var_.highlightMatValue10029 = var_250_2
				end
			end

			local var_250_3 = 0.2

			if var_250_1 <= arg_247_1.time_ and arg_247_1.time_ < var_250_1 + var_250_3 and not isNil(var_250_0) then
				local var_250_4 = (arg_247_1.time_ - var_250_1) / var_250_3

				if arg_247_1.var_.highlightMatValue10029 then
					local var_250_5 = Mathf.Lerp(1, 0.5, var_250_4)
					local var_250_6 = arg_247_1.var_.highlightMatValue10029
					local var_250_7 = var_250_6.color

					var_250_7.r = var_250_5
					var_250_7.g = var_250_5
					var_250_7.b = var_250_5
					var_250_6.color = var_250_7
				end
			end

			if arg_247_1.time_ >= var_250_1 + var_250_3 and arg_247_1.time_ < var_250_1 + var_250_3 + arg_250_0 and not isNil(var_250_0) and arg_247_1.var_.highlightMatValue10029 then
				local var_250_8 = 0.5
				local var_250_9 = arg_247_1.var_.highlightMatValue10029
				local var_250_10 = var_250_9.color

				var_250_10.r = var_250_8
				var_250_10.g = var_250_8
				var_250_10.b = var_250_8
				var_250_9.color = var_250_10
			end

			local var_250_11 = arg_247_1.actors_["113801_1"]
			local var_250_12 = 0

			if var_250_12 < arg_247_1.time_ and arg_247_1.time_ <= var_250_12 + arg_250_0 and not isNil(var_250_11) then
				local var_250_13 = var_250_11:GetComponent("Image")

				if var_250_13 then
					arg_247_1.var_.highlightMatValue113801_1 = var_250_13
				end
			end

			local var_250_14 = 0.2

			if var_250_12 <= arg_247_1.time_ and arg_247_1.time_ < var_250_12 + var_250_14 and not isNil(var_250_11) then
				local var_250_15 = (arg_247_1.time_ - var_250_12) / var_250_14

				if arg_247_1.var_.highlightMatValue113801_1 then
					local var_250_16 = Mathf.Lerp(0.5, 1, var_250_15)
					local var_250_17 = arg_247_1.var_.highlightMatValue113801_1
					local var_250_18 = var_250_17.color

					var_250_18.r = var_250_16
					var_250_18.g = var_250_16
					var_250_18.b = var_250_16
					var_250_17.color = var_250_18
				end
			end

			if arg_247_1.time_ >= var_250_12 + var_250_14 and arg_247_1.time_ < var_250_12 + var_250_14 + arg_250_0 and not isNil(var_250_11) and arg_247_1.var_.highlightMatValue113801_1 then
				local var_250_19 = 1

				var_250_11.transform:SetSiblingIndex(1)

				local var_250_20 = arg_247_1.var_.highlightMatValue113801_1
				local var_250_21 = var_250_20.color

				var_250_21.r = var_250_19
				var_250_21.g = var_250_19
				var_250_21.b = var_250_19
				var_250_20.color = var_250_21
			end

			local var_250_22 = 0
			local var_250_23 = 0.7

			if var_250_22 < arg_247_1.time_ and arg_247_1.time_ <= var_250_22 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				local var_250_24 = arg_247_1:FormatText(StoryNameCfg[94].name)

				arg_247_1.leftNameTxt_.text = var_250_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, false)
				arg_247_1.callingController_:SetSelectedState("normal")

				local var_250_25 = arg_247_1:GetWordFromCfg(115311061)
				local var_250_26 = arg_247_1:FormatText(var_250_25.content)

				arg_247_1.text_.text = var_250_26

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_27 = 28
				local var_250_28 = utf8.len(var_250_26)
				local var_250_29 = var_250_27 <= 0 and var_250_23 or var_250_23 * (var_250_28 / var_250_27)

				if var_250_29 > 0 and var_250_23 < var_250_29 then
					arg_247_1.talkMaxDuration = var_250_29

					if var_250_29 + var_250_22 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_29 + var_250_22
					end
				end

				arg_247_1.text_.text = var_250_26
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311061", "story_v_out_115311.awb") ~= 0 then
					local var_250_30 = manager.audio:GetVoiceLength("story_v_out_115311", "115311061", "story_v_out_115311.awb") / 1000

					if var_250_30 + var_250_22 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_30 + var_250_22
					end

					if var_250_25.prefab_name ~= "" and arg_247_1.actors_[var_250_25.prefab_name] ~= nil then
						local var_250_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_247_1.actors_[var_250_25.prefab_name].transform, "story_v_out_115311", "115311061", "story_v_out_115311.awb")

						arg_247_1:RecordAudio("115311061", var_250_31)
						arg_247_1:RecordAudio("115311061", var_250_31)
					else
						arg_247_1:AudioAction("play", "voice", "story_v_out_115311", "115311061", "story_v_out_115311.awb")
					end

					arg_247_1:RecordHistoryTalkVoice("story_v_out_115311", "115311061", "story_v_out_115311.awb")
				end

				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_32 = math.max(var_250_23, arg_247_1.talkMaxDuration)

			if var_250_22 <= arg_247_1.time_ and arg_247_1.time_ < var_250_22 + var_250_32 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_22) / var_250_32

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_22 + var_250_32 and arg_247_1.time_ < var_250_22 + var_250_32 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {}

		arg_247_1:InitPlayNodeList()
	end,
	Play115311062 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 115311062
		arg_251_1.duration_ = 12.4

		local var_251_0 = {
			ja = 11.6,
			ko = 10.6,
			zh = 10.066,
			en = 12.4
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
				arg_251_0:Play115311063(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			local var_254_0 = arg_251_1.actors_["10029"]
			local var_254_1 = 0

			if var_254_1 < arg_251_1.time_ and arg_251_1.time_ <= var_254_1 + arg_254_0 and not isNil(var_254_0) then
				local var_254_2 = var_254_0:GetComponent("Image")

				if var_254_2 then
					arg_251_1.var_.highlightMatValue10029 = var_254_2
				end
			end

			local var_254_3 = 0.2

			if var_254_1 <= arg_251_1.time_ and arg_251_1.time_ < var_254_1 + var_254_3 and not isNil(var_254_0) then
				local var_254_4 = (arg_251_1.time_ - var_254_1) / var_254_3

				if arg_251_1.var_.highlightMatValue10029 then
					local var_254_5 = Mathf.Lerp(0.5, 1, var_254_4)
					local var_254_6 = arg_251_1.var_.highlightMatValue10029
					local var_254_7 = var_254_6.color

					var_254_7.r = var_254_5
					var_254_7.g = var_254_5
					var_254_7.b = var_254_5
					var_254_6.color = var_254_7
				end
			end

			if arg_251_1.time_ >= var_254_1 + var_254_3 and arg_251_1.time_ < var_254_1 + var_254_3 + arg_254_0 and not isNil(var_254_0) and arg_251_1.var_.highlightMatValue10029 then
				local var_254_8 = 1

				var_254_0.transform:SetSiblingIndex(1)

				local var_254_9 = arg_251_1.var_.highlightMatValue10029
				local var_254_10 = var_254_9.color

				var_254_10.r = var_254_8
				var_254_10.g = var_254_8
				var_254_10.b = var_254_8
				var_254_9.color = var_254_10
			end

			local var_254_11 = arg_251_1.actors_["113801_1"]
			local var_254_12 = 0

			if var_254_12 < arg_251_1.time_ and arg_251_1.time_ <= var_254_12 + arg_254_0 and not isNil(var_254_11) then
				local var_254_13 = var_254_11:GetComponent("Image")

				if var_254_13 then
					arg_251_1.var_.highlightMatValue113801_1 = var_254_13
				end
			end

			local var_254_14 = 0.2

			if var_254_12 <= arg_251_1.time_ and arg_251_1.time_ < var_254_12 + var_254_14 and not isNil(var_254_11) then
				local var_254_15 = (arg_251_1.time_ - var_254_12) / var_254_14

				if arg_251_1.var_.highlightMatValue113801_1 then
					local var_254_16 = Mathf.Lerp(1, 0.5, var_254_15)
					local var_254_17 = arg_251_1.var_.highlightMatValue113801_1
					local var_254_18 = var_254_17.color

					var_254_18.r = var_254_16
					var_254_18.g = var_254_16
					var_254_18.b = var_254_16
					var_254_17.color = var_254_18
				end
			end

			if arg_251_1.time_ >= var_254_12 + var_254_14 and arg_251_1.time_ < var_254_12 + var_254_14 + arg_254_0 and not isNil(var_254_11) and arg_251_1.var_.highlightMatValue113801_1 then
				local var_254_19 = 0.5
				local var_254_20 = arg_251_1.var_.highlightMatValue113801_1
				local var_254_21 = var_254_20.color

				var_254_21.r = var_254_19
				var_254_21.g = var_254_19
				var_254_21.b = var_254_19
				var_254_20.color = var_254_21
			end

			local var_254_22 = 0
			local var_254_23 = 1

			if var_254_22 < arg_251_1.time_ and arg_251_1.time_ <= var_254_22 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, true)

				local var_254_24 = arg_251_1:FormatText(StoryNameCfg[312].name)

				arg_251_1.leftNameTxt_.text = var_254_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_251_1.leftNameTxt_.transform)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1.leftNameTxt_.text)
				SetActive(arg_251_1.iconTrs_.gameObject, false)
				arg_251_1.callingController_:SetSelectedState("normal")

				local var_254_25 = arg_251_1:GetWordFromCfg(115311062)
				local var_254_26 = arg_251_1:FormatText(var_254_25.content)

				arg_251_1.text_.text = var_254_26

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_27 = 40
				local var_254_28 = utf8.len(var_254_26)
				local var_254_29 = var_254_27 <= 0 and var_254_23 or var_254_23 * (var_254_28 / var_254_27)

				if var_254_29 > 0 and var_254_23 < var_254_29 then
					arg_251_1.talkMaxDuration = var_254_29

					if var_254_29 + var_254_22 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_29 + var_254_22
					end
				end

				arg_251_1.text_.text = var_254_26
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311062", "story_v_out_115311.awb") ~= 0 then
					local var_254_30 = manager.audio:GetVoiceLength("story_v_out_115311", "115311062", "story_v_out_115311.awb") / 1000

					if var_254_30 + var_254_22 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_30 + var_254_22
					end

					if var_254_25.prefab_name ~= "" and arg_251_1.actors_[var_254_25.prefab_name] ~= nil then
						local var_254_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_251_1.actors_[var_254_25.prefab_name].transform, "story_v_out_115311", "115311062", "story_v_out_115311.awb")

						arg_251_1:RecordAudio("115311062", var_254_31)
						arg_251_1:RecordAudio("115311062", var_254_31)
					else
						arg_251_1:AudioAction("play", "voice", "story_v_out_115311", "115311062", "story_v_out_115311.awb")
					end

					arg_251_1:RecordHistoryTalkVoice("story_v_out_115311", "115311062", "story_v_out_115311.awb")
				end

				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_32 = math.max(var_254_23, arg_251_1.talkMaxDuration)

			if var_254_22 <= arg_251_1.time_ and arg_251_1.time_ < var_254_22 + var_254_32 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - var_254_22) / var_254_32

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= var_254_22 + var_254_32 and arg_251_1.time_ < var_254_22 + var_254_32 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {}

		arg_251_1:InitPlayNodeList()
	end,
	Play115311063 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 115311063
		arg_255_1.duration_ = 5

		SetActive(arg_255_1.tipsGo_, false)

		function arg_255_1.onSingleLineFinish_()
			arg_255_1.onSingleLineUpdate_ = nil
			arg_255_1.onSingleLineFinish_ = nil
			arg_255_1.state_ = "waiting"
		end

		function arg_255_1.playNext_(arg_257_0)
			if arg_257_0 == 1 then
				arg_255_0:Play115311064(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			local var_258_0 = arg_255_1.actors_["10029"]
			local var_258_1 = 0

			if var_258_1 < arg_255_1.time_ and arg_255_1.time_ <= var_258_1 + arg_258_0 and not isNil(var_258_0) then
				local var_258_2 = var_258_0:GetComponent("Image")

				if var_258_2 then
					arg_255_1.var_.highlightMatValue10029 = var_258_2
				end
			end

			local var_258_3 = 0.2

			if var_258_1 <= arg_255_1.time_ and arg_255_1.time_ < var_258_1 + var_258_3 and not isNil(var_258_0) then
				local var_258_4 = (arg_255_1.time_ - var_258_1) / var_258_3

				if arg_255_1.var_.highlightMatValue10029 then
					local var_258_5 = Mathf.Lerp(1, 0.5, var_258_4)
					local var_258_6 = arg_255_1.var_.highlightMatValue10029
					local var_258_7 = var_258_6.color

					var_258_7.r = var_258_5
					var_258_7.g = var_258_5
					var_258_7.b = var_258_5
					var_258_6.color = var_258_7
				end
			end

			if arg_255_1.time_ >= var_258_1 + var_258_3 and arg_255_1.time_ < var_258_1 + var_258_3 + arg_258_0 and not isNil(var_258_0) and arg_255_1.var_.highlightMatValue10029 then
				local var_258_8 = 0.5
				local var_258_9 = arg_255_1.var_.highlightMatValue10029
				local var_258_10 = var_258_9.color

				var_258_10.r = var_258_8
				var_258_10.g = var_258_8
				var_258_10.b = var_258_8
				var_258_9.color = var_258_10
			end

			local var_258_11 = 0
			local var_258_12 = 1.05

			if var_258_11 < arg_255_1.time_ and arg_255_1.time_ <= var_258_11 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, false)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_255_1.iconTrs_.gameObject, false)
				arg_255_1.callingController_:SetSelectedState("normal")

				local var_258_13 = arg_255_1:GetWordFromCfg(115311063)
				local var_258_14 = arg_255_1:FormatText(var_258_13.content)

				arg_255_1.text_.text = var_258_14

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_15 = 42
				local var_258_16 = utf8.len(var_258_14)
				local var_258_17 = var_258_15 <= 0 and var_258_12 or var_258_12 * (var_258_16 / var_258_15)

				if var_258_17 > 0 and var_258_12 < var_258_17 then
					arg_255_1.talkMaxDuration = var_258_17

					if var_258_17 + var_258_11 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_17 + var_258_11
					end
				end

				arg_255_1.text_.text = var_258_14
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)
				arg_255_1:RecordContent(arg_255_1.text_.text)
			end

			local var_258_18 = math.max(var_258_12, arg_255_1.talkMaxDuration)

			if var_258_11 <= arg_255_1.time_ and arg_255_1.time_ < var_258_11 + var_258_18 then
				arg_255_1.typewritter.percent = (arg_255_1.time_ - var_258_11) / var_258_18

				arg_255_1.typewritter:SetDirty()
			end

			if arg_255_1.time_ >= var_258_11 + var_258_18 and arg_255_1.time_ < var_258_11 + var_258_18 + arg_258_0 then
				arg_255_1.typewritter.percent = 1

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(true)
			end
		end

		arg_255_1.nodeConfigList_ = {}

		arg_255_1:InitPlayNodeList()
	end,
	Play115311064 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 115311064
		arg_259_1.duration_ = 6.37

		local var_259_0 = {
			ja = 6.166,
			ko = 6.366,
			zh = 5.266,
			en = 5.866
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
				arg_259_0:Play115311065(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			local var_262_0 = arg_259_1.actors_["10029"]
			local var_262_1 = 0

			if var_262_1 < arg_259_1.time_ and arg_259_1.time_ <= var_262_1 + arg_262_0 and not isNil(var_262_0) then
				local var_262_2 = var_262_0:GetComponent("Image")

				if var_262_2 then
					arg_259_1.var_.highlightMatValue10029 = var_262_2
				end
			end

			local var_262_3 = 0.2

			if var_262_1 <= arg_259_1.time_ and arg_259_1.time_ < var_262_1 + var_262_3 and not isNil(var_262_0) then
				local var_262_4 = (arg_259_1.time_ - var_262_1) / var_262_3

				if arg_259_1.var_.highlightMatValue10029 then
					local var_262_5 = Mathf.Lerp(0.5, 1, var_262_4)
					local var_262_6 = arg_259_1.var_.highlightMatValue10029
					local var_262_7 = var_262_6.color

					var_262_7.r = var_262_5
					var_262_7.g = var_262_5
					var_262_7.b = var_262_5
					var_262_6.color = var_262_7
				end
			end

			if arg_259_1.time_ >= var_262_1 + var_262_3 and arg_259_1.time_ < var_262_1 + var_262_3 + arg_262_0 and not isNil(var_262_0) and arg_259_1.var_.highlightMatValue10029 then
				local var_262_8 = 1

				var_262_0.transform:SetSiblingIndex(1)

				local var_262_9 = arg_259_1.var_.highlightMatValue10029
				local var_262_10 = var_262_9.color

				var_262_10.r = var_262_8
				var_262_10.g = var_262_8
				var_262_10.b = var_262_8
				var_262_9.color = var_262_10
			end

			local var_262_11 = 0
			local var_262_12 = 0.75

			if var_262_11 < arg_259_1.time_ and arg_259_1.time_ <= var_262_11 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0
				arg_259_1.dialogCg_.alpha = 1

				arg_259_1.dialog_:SetActive(true)
				SetActive(arg_259_1.leftNameGo_, true)

				local var_262_13 = arg_259_1:FormatText(StoryNameCfg[312].name)

				arg_259_1.leftNameTxt_.text = var_262_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_259_1.leftNameTxt_.transform)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1.leftNameTxt_.text)
				SetActive(arg_259_1.iconTrs_.gameObject, false)
				arg_259_1.callingController_:SetSelectedState("normal")

				local var_262_14 = arg_259_1:GetWordFromCfg(115311064)
				local var_262_15 = arg_259_1:FormatText(var_262_14.content)

				arg_259_1.text_.text = var_262_15

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_16 = 30
				local var_262_17 = utf8.len(var_262_15)
				local var_262_18 = var_262_16 <= 0 and var_262_12 or var_262_12 * (var_262_17 / var_262_16)

				if var_262_18 > 0 and var_262_12 < var_262_18 then
					arg_259_1.talkMaxDuration = var_262_18

					if var_262_18 + var_262_11 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_18 + var_262_11
					end
				end

				arg_259_1.text_.text = var_262_15
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311064", "story_v_out_115311.awb") ~= 0 then
					local var_262_19 = manager.audio:GetVoiceLength("story_v_out_115311", "115311064", "story_v_out_115311.awb") / 1000

					if var_262_19 + var_262_11 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_19 + var_262_11
					end

					if var_262_14.prefab_name ~= "" and arg_259_1.actors_[var_262_14.prefab_name] ~= nil then
						local var_262_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_259_1.actors_[var_262_14.prefab_name].transform, "story_v_out_115311", "115311064", "story_v_out_115311.awb")

						arg_259_1:RecordAudio("115311064", var_262_20)
						arg_259_1:RecordAudio("115311064", var_262_20)
					else
						arg_259_1:AudioAction("play", "voice", "story_v_out_115311", "115311064", "story_v_out_115311.awb")
					end

					arg_259_1:RecordHistoryTalkVoice("story_v_out_115311", "115311064", "story_v_out_115311.awb")
				end

				arg_259_1:RecordContent(arg_259_1.text_.text)
			end

			local var_262_21 = math.max(var_262_12, arg_259_1.talkMaxDuration)

			if var_262_11 <= arg_259_1.time_ and arg_259_1.time_ < var_262_11 + var_262_21 then
				arg_259_1.typewritter.percent = (arg_259_1.time_ - var_262_11) / var_262_21

				arg_259_1.typewritter:SetDirty()
			end

			if arg_259_1.time_ >= var_262_11 + var_262_21 and arg_259_1.time_ < var_262_11 + var_262_21 + arg_262_0 then
				arg_259_1.typewritter.percent = 1

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(true)
			end
		end

		arg_259_1.nodeConfigList_ = {}

		arg_259_1:InitPlayNodeList()
	end,
	Play115311065 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 115311065
		arg_263_1.duration_ = 2.37

		local var_263_0 = {
			ja = 1.9,
			ko = 0.999999999999,
			zh = 2.366,
			en = 1.6
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
				arg_263_0:Play115311066(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			local var_266_0 = arg_263_1.actors_["10029"]
			local var_266_1 = 0

			if var_266_1 < arg_263_1.time_ and arg_263_1.time_ <= var_266_1 + arg_266_0 and not isNil(var_266_0) then
				local var_266_2 = var_266_0:GetComponent("Image")

				if var_266_2 then
					arg_263_1.var_.highlightMatValue10029 = var_266_2
				end
			end

			local var_266_3 = 0.2

			if var_266_1 <= arg_263_1.time_ and arg_263_1.time_ < var_266_1 + var_266_3 and not isNil(var_266_0) then
				local var_266_4 = (arg_263_1.time_ - var_266_1) / var_266_3

				if arg_263_1.var_.highlightMatValue10029 then
					local var_266_5 = Mathf.Lerp(1, 0.5, var_266_4)
					local var_266_6 = arg_263_1.var_.highlightMatValue10029
					local var_266_7 = var_266_6.color

					var_266_7.r = var_266_5
					var_266_7.g = var_266_5
					var_266_7.b = var_266_5
					var_266_6.color = var_266_7
				end
			end

			if arg_263_1.time_ >= var_266_1 + var_266_3 and arg_263_1.time_ < var_266_1 + var_266_3 + arg_266_0 and not isNil(var_266_0) and arg_263_1.var_.highlightMatValue10029 then
				local var_266_8 = 0.5
				local var_266_9 = arg_263_1.var_.highlightMatValue10029
				local var_266_10 = var_266_9.color

				var_266_10.r = var_266_8
				var_266_10.g = var_266_8
				var_266_10.b = var_266_8
				var_266_9.color = var_266_10
			end

			local var_266_11 = 0
			local var_266_12 = 0.125

			if var_266_11 < arg_263_1.time_ and arg_263_1.time_ <= var_266_11 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0
				arg_263_1.dialogCg_.alpha = 1

				arg_263_1.dialog_:SetActive(true)
				SetActive(arg_263_1.leftNameGo_, true)

				local var_266_13 = arg_263_1:FormatText(StoryNameCfg[316].name)

				arg_263_1.leftNameTxt_.text = var_266_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_263_1.leftNameTxt_.transform)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1.leftNameTxt_.text)
				SetActive(arg_263_1.iconTrs_.gameObject, true)
				arg_263_1.iconController_:SetSelectedState("hero")

				arg_263_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_263_1.callingController_:SetSelectedState("normal")

				arg_263_1.keyicon_.color = Color.New(1, 1, 1)
				arg_263_1.icon_.color = Color.New(1, 1, 1)

				local var_266_14 = arg_263_1:GetWordFromCfg(115311065)
				local var_266_15 = arg_263_1:FormatText(var_266_14.content)

				arg_263_1.text_.text = var_266_15

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_16 = 5
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

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311065", "story_v_out_115311.awb") ~= 0 then
					local var_266_19 = manager.audio:GetVoiceLength("story_v_out_115311", "115311065", "story_v_out_115311.awb") / 1000

					if var_266_19 + var_266_11 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_19 + var_266_11
					end

					if var_266_14.prefab_name ~= "" and arg_263_1.actors_[var_266_14.prefab_name] ~= nil then
						local var_266_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_263_1.actors_[var_266_14.prefab_name].transform, "story_v_out_115311", "115311065", "story_v_out_115311.awb")

						arg_263_1:RecordAudio("115311065", var_266_20)
						arg_263_1:RecordAudio("115311065", var_266_20)
					else
						arg_263_1:AudioAction("play", "voice", "story_v_out_115311", "115311065", "story_v_out_115311.awb")
					end

					arg_263_1:RecordHistoryTalkVoice("story_v_out_115311", "115311065", "story_v_out_115311.awb")
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
	Play115311066 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 115311066
		arg_267_1.duration_ = 5

		SetActive(arg_267_1.tipsGo_, false)

		function arg_267_1.onSingleLineFinish_()
			arg_267_1.onSingleLineUpdate_ = nil
			arg_267_1.onSingleLineFinish_ = nil
			arg_267_1.state_ = "waiting"
		end

		function arg_267_1.playNext_(arg_269_0)
			if arg_269_0 == 1 then
				arg_267_0:Play115311067(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			local var_270_0 = 0
			local var_270_1 = 1.125

			if var_270_0 < arg_267_1.time_ and arg_267_1.time_ <= var_270_0 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0
				arg_267_1.dialogCg_.alpha = 1

				arg_267_1.dialog_:SetActive(true)
				SetActive(arg_267_1.leftNameGo_, false)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_267_1.iconTrs_.gameObject, false)
				arg_267_1.callingController_:SetSelectedState("normal")

				local var_270_2 = arg_267_1:GetWordFromCfg(115311066)
				local var_270_3 = arg_267_1:FormatText(var_270_2.content)

				arg_267_1.text_.text = var_270_3

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_4 = 45
				local var_270_5 = utf8.len(var_270_3)
				local var_270_6 = var_270_4 <= 0 and var_270_1 or var_270_1 * (var_270_5 / var_270_4)

				if var_270_6 > 0 and var_270_1 < var_270_6 then
					arg_267_1.talkMaxDuration = var_270_6

					if var_270_6 + var_270_0 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_6 + var_270_0
					end
				end

				arg_267_1.text_.text = var_270_3
				arg_267_1.typewritter.percent = 0

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(false)
				arg_267_1:RecordContent(arg_267_1.text_.text)
			end

			local var_270_7 = math.max(var_270_1, arg_267_1.talkMaxDuration)

			if var_270_0 <= arg_267_1.time_ and arg_267_1.time_ < var_270_0 + var_270_7 then
				arg_267_1.typewritter.percent = (arg_267_1.time_ - var_270_0) / var_270_7

				arg_267_1.typewritter:SetDirty()
			end

			if arg_267_1.time_ >= var_270_0 + var_270_7 and arg_267_1.time_ < var_270_0 + var_270_7 + arg_270_0 then
				arg_267_1.typewritter.percent = 1

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(true)
			end
		end

		arg_267_1.nodeConfigList_ = {}

		arg_267_1:InitPlayNodeList()
	end,
	Play115311067 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 115311067
		arg_271_1.duration_ = 4.6

		local var_271_0 = {
			ja = 3.366,
			ko = 4.566,
			zh = 3.166,
			en = 4.6
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
				arg_271_0:Play115311068(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			local var_274_0 = 0
			local var_274_1 = 0.4

			if var_274_0 < arg_271_1.time_ and arg_271_1.time_ <= var_274_0 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, true)

				local var_274_2 = arg_271_1:FormatText(StoryNameCfg[316].name)

				arg_271_1.leftNameTxt_.text = var_274_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_271_1.leftNameTxt_.transform)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1.leftNameTxt_.text)
				SetActive(arg_271_1.iconTrs_.gameObject, true)
				arg_271_1.iconController_:SetSelectedState("hero")

				arg_271_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_271_1.callingController_:SetSelectedState("normal")

				arg_271_1.keyicon_.color = Color.New(1, 1, 1)
				arg_271_1.icon_.color = Color.New(1, 1, 1)

				local var_274_3 = arg_271_1:GetWordFromCfg(115311067)
				local var_274_4 = arg_271_1:FormatText(var_274_3.content)

				arg_271_1.text_.text = var_274_4

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_5 = 16
				local var_274_6 = utf8.len(var_274_4)
				local var_274_7 = var_274_5 <= 0 and var_274_1 or var_274_1 * (var_274_6 / var_274_5)

				if var_274_7 > 0 and var_274_1 < var_274_7 then
					arg_271_1.talkMaxDuration = var_274_7

					if var_274_7 + var_274_0 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_7 + var_274_0
					end
				end

				arg_271_1.text_.text = var_274_4
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311067", "story_v_out_115311.awb") ~= 0 then
					local var_274_8 = manager.audio:GetVoiceLength("story_v_out_115311", "115311067", "story_v_out_115311.awb") / 1000

					if var_274_8 + var_274_0 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_8 + var_274_0
					end

					if var_274_3.prefab_name ~= "" and arg_271_1.actors_[var_274_3.prefab_name] ~= nil then
						local var_274_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_271_1.actors_[var_274_3.prefab_name].transform, "story_v_out_115311", "115311067", "story_v_out_115311.awb")

						arg_271_1:RecordAudio("115311067", var_274_9)
						arg_271_1:RecordAudio("115311067", var_274_9)
					else
						arg_271_1:AudioAction("play", "voice", "story_v_out_115311", "115311067", "story_v_out_115311.awb")
					end

					arg_271_1:RecordHistoryTalkVoice("story_v_out_115311", "115311067", "story_v_out_115311.awb")
				end

				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_10 = math.max(var_274_1, arg_271_1.talkMaxDuration)

			if var_274_0 <= arg_271_1.time_ and arg_271_1.time_ < var_274_0 + var_274_10 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - var_274_0) / var_274_10

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= var_274_0 + var_274_10 and arg_271_1.time_ < var_274_0 + var_274_10 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {}

		arg_271_1:InitPlayNodeList()
	end,
	Play115311068 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 115311068
		arg_275_1.duration_ = 5

		SetActive(arg_275_1.tipsGo_, false)

		function arg_275_1.onSingleLineFinish_()
			arg_275_1.onSingleLineUpdate_ = nil
			arg_275_1.onSingleLineFinish_ = nil
			arg_275_1.state_ = "waiting"
		end

		function arg_275_1.playNext_(arg_277_0)
			if arg_277_0 == 1 then
				arg_275_0:Play115311069(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			local var_278_0 = 0
			local var_278_1 = 1.45

			if var_278_0 < arg_275_1.time_ and arg_275_1.time_ <= var_278_0 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0
				arg_275_1.dialogCg_.alpha = 1

				arg_275_1.dialog_:SetActive(true)
				SetActive(arg_275_1.leftNameGo_, false)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_275_1.iconTrs_.gameObject, false)
				arg_275_1.callingController_:SetSelectedState("normal")

				local var_278_2 = arg_275_1:GetWordFromCfg(115311068)
				local var_278_3 = arg_275_1:FormatText(var_278_2.content)

				arg_275_1.text_.text = var_278_3

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_4 = 58
				local var_278_5 = utf8.len(var_278_3)
				local var_278_6 = var_278_4 <= 0 and var_278_1 or var_278_1 * (var_278_5 / var_278_4)

				if var_278_6 > 0 and var_278_1 < var_278_6 then
					arg_275_1.talkMaxDuration = var_278_6

					if var_278_6 + var_278_0 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_6 + var_278_0
					end
				end

				arg_275_1.text_.text = var_278_3
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)
				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_7 = math.max(var_278_1, arg_275_1.talkMaxDuration)

			if var_278_0 <= arg_275_1.time_ and arg_275_1.time_ < var_278_0 + var_278_7 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - var_278_0) / var_278_7

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= var_278_0 + var_278_7 and arg_275_1.time_ < var_278_0 + var_278_7 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {}

		arg_275_1:InitPlayNodeList()
	end,
	Play115311069 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 115311069
		arg_279_1.duration_ = 5

		SetActive(arg_279_1.tipsGo_, false)

		function arg_279_1.onSingleLineFinish_()
			arg_279_1.onSingleLineUpdate_ = nil
			arg_279_1.onSingleLineFinish_ = nil
			arg_279_1.state_ = "waiting"
		end

		function arg_279_1.playNext_(arg_281_0)
			if arg_281_0 == 1 then
				arg_279_0:Play115311070(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			local var_282_0 = 0
			local var_282_1 = 0.875

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

				local var_282_2 = arg_279_1:GetWordFromCfg(115311069)
				local var_282_3 = arg_279_1:FormatText(var_282_2.content)

				arg_279_1.text_.text = var_282_3

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_4 = 35
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
	Play115311070 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 115311070
		arg_283_1.duration_ = 17.7

		local var_283_0 = {
			ja = 17.333,
			ko = 13,
			zh = 13.4,
			en = 17.7
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
				arg_283_0:Play115311071(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			local var_286_0 = arg_283_1.actors_["113801_1"]
			local var_286_1 = 0

			if var_286_1 < arg_283_1.time_ and arg_283_1.time_ <= var_286_1 + arg_286_0 and not isNil(var_286_0) then
				local var_286_2 = var_286_0:GetComponent("Image")

				if var_286_2 then
					arg_283_1.var_.highlightMatValue113801_1 = var_286_2
				end
			end

			local var_286_3 = 0.2

			if var_286_1 <= arg_283_1.time_ and arg_283_1.time_ < var_286_1 + var_286_3 and not isNil(var_286_0) then
				local var_286_4 = (arg_283_1.time_ - var_286_1) / var_286_3

				if arg_283_1.var_.highlightMatValue113801_1 then
					local var_286_5 = Mathf.Lerp(0.5, 1, var_286_4)
					local var_286_6 = arg_283_1.var_.highlightMatValue113801_1
					local var_286_7 = var_286_6.color

					var_286_7.r = var_286_5
					var_286_7.g = var_286_5
					var_286_7.b = var_286_5
					var_286_6.color = var_286_7
				end
			end

			if arg_283_1.time_ >= var_286_1 + var_286_3 and arg_283_1.time_ < var_286_1 + var_286_3 + arg_286_0 and not isNil(var_286_0) and arg_283_1.var_.highlightMatValue113801_1 then
				local var_286_8 = 1

				var_286_0.transform:SetSiblingIndex(1)

				local var_286_9 = arg_283_1.var_.highlightMatValue113801_1
				local var_286_10 = var_286_9.color

				var_286_10.r = var_286_8
				var_286_10.g = var_286_8
				var_286_10.b = var_286_8
				var_286_9.color = var_286_10
			end

			local var_286_11 = 0
			local var_286_12 = 1.2

			if var_286_11 < arg_283_1.time_ and arg_283_1.time_ <= var_286_11 + arg_286_0 then
				arg_283_1.talkMaxDuration = 0
				arg_283_1.dialogCg_.alpha = 1

				arg_283_1.dialog_:SetActive(true)
				SetActive(arg_283_1.leftNameGo_, true)

				local var_286_13 = arg_283_1:FormatText(StoryNameCfg[94].name)

				arg_283_1.leftNameTxt_.text = var_286_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_283_1.leftNameTxt_.transform)

				arg_283_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_283_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_283_1:RecordName(arg_283_1.leftNameTxt_.text)
				SetActive(arg_283_1.iconTrs_.gameObject, false)
				arg_283_1.callingController_:SetSelectedState("normal")

				local var_286_14 = arg_283_1:GetWordFromCfg(115311070)
				local var_286_15 = arg_283_1:FormatText(var_286_14.content)

				arg_283_1.text_.text = var_286_15

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_16 = 48
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

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311070", "story_v_out_115311.awb") ~= 0 then
					local var_286_19 = manager.audio:GetVoiceLength("story_v_out_115311", "115311070", "story_v_out_115311.awb") / 1000

					if var_286_19 + var_286_11 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_19 + var_286_11
					end

					if var_286_14.prefab_name ~= "" and arg_283_1.actors_[var_286_14.prefab_name] ~= nil then
						local var_286_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_283_1.actors_[var_286_14.prefab_name].transform, "story_v_out_115311", "115311070", "story_v_out_115311.awb")

						arg_283_1:RecordAudio("115311070", var_286_20)
						arg_283_1:RecordAudio("115311070", var_286_20)
					else
						arg_283_1:AudioAction("play", "voice", "story_v_out_115311", "115311070", "story_v_out_115311.awb")
					end

					arg_283_1:RecordHistoryTalkVoice("story_v_out_115311", "115311070", "story_v_out_115311.awb")
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
	Play115311071 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 115311071
		arg_287_1.duration_ = 9.03

		local var_287_0 = {
			ja = 8.733,
			ko = 9.033,
			zh = 8.433,
			en = 9
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
				arg_287_0:Play115311072(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			local var_290_0 = arg_287_1.actors_["113801_1"]
			local var_290_1 = 0

			if var_290_1 < arg_287_1.time_ and arg_287_1.time_ <= var_290_1 + arg_290_0 and not isNil(var_290_0) then
				local var_290_2 = var_290_0:GetComponent("Image")

				if var_290_2 then
					arg_287_1.var_.highlightMatValue113801_1 = var_290_2
				end
			end

			local var_290_3 = 0.2

			if var_290_1 <= arg_287_1.time_ and arg_287_1.time_ < var_290_1 + var_290_3 and not isNil(var_290_0) then
				local var_290_4 = (arg_287_1.time_ - var_290_1) / var_290_3

				if arg_287_1.var_.highlightMatValue113801_1 then
					local var_290_5 = Mathf.Lerp(1, 0.5, var_290_4)
					local var_290_6 = arg_287_1.var_.highlightMatValue113801_1
					local var_290_7 = var_290_6.color

					var_290_7.r = var_290_5
					var_290_7.g = var_290_5
					var_290_7.b = var_290_5
					var_290_6.color = var_290_7
				end
			end

			if arg_287_1.time_ >= var_290_1 + var_290_3 and arg_287_1.time_ < var_290_1 + var_290_3 + arg_290_0 and not isNil(var_290_0) and arg_287_1.var_.highlightMatValue113801_1 then
				local var_290_8 = 0.5
				local var_290_9 = arg_287_1.var_.highlightMatValue113801_1
				local var_290_10 = var_290_9.color

				var_290_10.r = var_290_8
				var_290_10.g = var_290_8
				var_290_10.b = var_290_8
				var_290_9.color = var_290_10
			end

			local var_290_11 = arg_287_1.actors_["10029"]
			local var_290_12 = 0

			if var_290_12 < arg_287_1.time_ and arg_287_1.time_ <= var_290_12 + arg_290_0 and not isNil(var_290_11) then
				local var_290_13 = var_290_11:GetComponent("Image")

				if var_290_13 then
					arg_287_1.var_.highlightMatValue10029 = var_290_13
				end
			end

			local var_290_14 = 0.2

			if var_290_12 <= arg_287_1.time_ and arg_287_1.time_ < var_290_12 + var_290_14 and not isNil(var_290_11) then
				local var_290_15 = (arg_287_1.time_ - var_290_12) / var_290_14

				if arg_287_1.var_.highlightMatValue10029 then
					local var_290_16 = Mathf.Lerp(0.5, 1, var_290_15)
					local var_290_17 = arg_287_1.var_.highlightMatValue10029
					local var_290_18 = var_290_17.color

					var_290_18.r = var_290_16
					var_290_18.g = var_290_16
					var_290_18.b = var_290_16
					var_290_17.color = var_290_18
				end
			end

			if arg_287_1.time_ >= var_290_12 + var_290_14 and arg_287_1.time_ < var_290_12 + var_290_14 + arg_290_0 and not isNil(var_290_11) and arg_287_1.var_.highlightMatValue10029 then
				local var_290_19 = 1

				var_290_11.transform:SetSiblingIndex(1)

				local var_290_20 = arg_287_1.var_.highlightMatValue10029
				local var_290_21 = var_290_20.color

				var_290_21.r = var_290_19
				var_290_21.g = var_290_19
				var_290_21.b = var_290_19
				var_290_20.color = var_290_21
			end

			local var_290_22 = 0
			local var_290_23 = 0.925

			if var_290_22 < arg_287_1.time_ and arg_287_1.time_ <= var_290_22 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0
				arg_287_1.dialogCg_.alpha = 1

				arg_287_1.dialog_:SetActive(true)
				SetActive(arg_287_1.leftNameGo_, true)

				local var_290_24 = arg_287_1:FormatText(StoryNameCfg[312].name)

				arg_287_1.leftNameTxt_.text = var_290_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_287_1.leftNameTxt_.transform)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1.leftNameTxt_.text)
				SetActive(arg_287_1.iconTrs_.gameObject, false)
				arg_287_1.callingController_:SetSelectedState("normal")

				local var_290_25 = arg_287_1:GetWordFromCfg(115311071)
				local var_290_26 = arg_287_1:FormatText(var_290_25.content)

				arg_287_1.text_.text = var_290_26

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_27 = 37
				local var_290_28 = utf8.len(var_290_26)
				local var_290_29 = var_290_27 <= 0 and var_290_23 or var_290_23 * (var_290_28 / var_290_27)

				if var_290_29 > 0 and var_290_23 < var_290_29 then
					arg_287_1.talkMaxDuration = var_290_29

					if var_290_29 + var_290_22 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_29 + var_290_22
					end
				end

				arg_287_1.text_.text = var_290_26
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311071", "story_v_out_115311.awb") ~= 0 then
					local var_290_30 = manager.audio:GetVoiceLength("story_v_out_115311", "115311071", "story_v_out_115311.awb") / 1000

					if var_290_30 + var_290_22 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_30 + var_290_22
					end

					if var_290_25.prefab_name ~= "" and arg_287_1.actors_[var_290_25.prefab_name] ~= nil then
						local var_290_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_287_1.actors_[var_290_25.prefab_name].transform, "story_v_out_115311", "115311071", "story_v_out_115311.awb")

						arg_287_1:RecordAudio("115311071", var_290_31)
						arg_287_1:RecordAudio("115311071", var_290_31)
					else
						arg_287_1:AudioAction("play", "voice", "story_v_out_115311", "115311071", "story_v_out_115311.awb")
					end

					arg_287_1:RecordHistoryTalkVoice("story_v_out_115311", "115311071", "story_v_out_115311.awb")
				end

				arg_287_1:RecordContent(arg_287_1.text_.text)
			end

			local var_290_32 = math.max(var_290_23, arg_287_1.talkMaxDuration)

			if var_290_22 <= arg_287_1.time_ and arg_287_1.time_ < var_290_22 + var_290_32 then
				arg_287_1.typewritter.percent = (arg_287_1.time_ - var_290_22) / var_290_32

				arg_287_1.typewritter:SetDirty()
			end

			if arg_287_1.time_ >= var_290_22 + var_290_32 and arg_287_1.time_ < var_290_22 + var_290_32 + arg_290_0 then
				arg_287_1.typewritter.percent = 1

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(true)
			end
		end

		arg_287_1.nodeConfigList_ = {}

		arg_287_1:InitPlayNodeList()
	end,
	Play115311072 = function(arg_291_0, arg_291_1)
		arg_291_1.time_ = 0
		arg_291_1.frameCnt_ = 0
		arg_291_1.state_ = "playing"
		arg_291_1.curTalkId_ = 115311072
		arg_291_1.duration_ = 5.33

		local var_291_0 = {
			ja = 3,
			ko = 2.866,
			zh = 5.333,
			en = 4.133
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
				arg_291_0:Play115311073(arg_291_1)
			end
		end

		function arg_291_1.onSingleLineUpdate_(arg_294_0)
			local var_294_0 = arg_291_1.actors_["113801_1"]
			local var_294_1 = 0

			if var_294_1 < arg_291_1.time_ and arg_291_1.time_ <= var_294_1 + arg_294_0 and not isNil(var_294_0) then
				local var_294_2 = var_294_0:GetComponent("Image")

				if var_294_2 then
					arg_291_1.var_.highlightMatValue113801_1 = var_294_2
				end
			end

			local var_294_3 = 0.2

			if var_294_1 <= arg_291_1.time_ and arg_291_1.time_ < var_294_1 + var_294_3 and not isNil(var_294_0) then
				local var_294_4 = (arg_291_1.time_ - var_294_1) / var_294_3

				if arg_291_1.var_.highlightMatValue113801_1 then
					local var_294_5 = Mathf.Lerp(0.5, 1, var_294_4)
					local var_294_6 = arg_291_1.var_.highlightMatValue113801_1
					local var_294_7 = var_294_6.color

					var_294_7.r = var_294_5
					var_294_7.g = var_294_5
					var_294_7.b = var_294_5
					var_294_6.color = var_294_7
				end
			end

			if arg_291_1.time_ >= var_294_1 + var_294_3 and arg_291_1.time_ < var_294_1 + var_294_3 + arg_294_0 and not isNil(var_294_0) and arg_291_1.var_.highlightMatValue113801_1 then
				local var_294_8 = 1

				var_294_0.transform:SetSiblingIndex(1)

				local var_294_9 = arg_291_1.var_.highlightMatValue113801_1
				local var_294_10 = var_294_9.color

				var_294_10.r = var_294_8
				var_294_10.g = var_294_8
				var_294_10.b = var_294_8
				var_294_9.color = var_294_10
			end

			local var_294_11 = arg_291_1.actors_["10029"]
			local var_294_12 = 0

			if var_294_12 < arg_291_1.time_ and arg_291_1.time_ <= var_294_12 + arg_294_0 and not isNil(var_294_11) then
				local var_294_13 = var_294_11:GetComponent("Image")

				if var_294_13 then
					arg_291_1.var_.highlightMatValue10029 = var_294_13
				end
			end

			local var_294_14 = 0.2

			if var_294_12 <= arg_291_1.time_ and arg_291_1.time_ < var_294_12 + var_294_14 and not isNil(var_294_11) then
				local var_294_15 = (arg_291_1.time_ - var_294_12) / var_294_14

				if arg_291_1.var_.highlightMatValue10029 then
					local var_294_16 = Mathf.Lerp(1, 0.5, var_294_15)
					local var_294_17 = arg_291_1.var_.highlightMatValue10029
					local var_294_18 = var_294_17.color

					var_294_18.r = var_294_16
					var_294_18.g = var_294_16
					var_294_18.b = var_294_16
					var_294_17.color = var_294_18
				end
			end

			if arg_291_1.time_ >= var_294_12 + var_294_14 and arg_291_1.time_ < var_294_12 + var_294_14 + arg_294_0 and not isNil(var_294_11) and arg_291_1.var_.highlightMatValue10029 then
				local var_294_19 = 0.5
				local var_294_20 = arg_291_1.var_.highlightMatValue10029
				local var_294_21 = var_294_20.color

				var_294_21.r = var_294_19
				var_294_21.g = var_294_19
				var_294_21.b = var_294_19
				var_294_20.color = var_294_21
			end

			local var_294_22 = 0
			local var_294_23 = 0.4

			if var_294_22 < arg_291_1.time_ and arg_291_1.time_ <= var_294_22 + arg_294_0 then
				arg_291_1.talkMaxDuration = 0
				arg_291_1.dialogCg_.alpha = 1

				arg_291_1.dialog_:SetActive(true)
				SetActive(arg_291_1.leftNameGo_, true)

				local var_294_24 = arg_291_1:FormatText(StoryNameCfg[94].name)

				arg_291_1.leftNameTxt_.text = var_294_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_291_1.leftNameTxt_.transform)

				arg_291_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_291_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_291_1:RecordName(arg_291_1.leftNameTxt_.text)
				SetActive(arg_291_1.iconTrs_.gameObject, false)
				arg_291_1.callingController_:SetSelectedState("normal")

				local var_294_25 = arg_291_1:GetWordFromCfg(115311072)
				local var_294_26 = arg_291_1:FormatText(var_294_25.content)

				arg_291_1.text_.text = var_294_26

				LuaForUtil.ClearLinePrefixSymbol(arg_291_1.text_)

				local var_294_27 = 16
				local var_294_28 = utf8.len(var_294_26)
				local var_294_29 = var_294_27 <= 0 and var_294_23 or var_294_23 * (var_294_28 / var_294_27)

				if var_294_29 > 0 and var_294_23 < var_294_29 then
					arg_291_1.talkMaxDuration = var_294_29

					if var_294_29 + var_294_22 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_29 + var_294_22
					end
				end

				arg_291_1.text_.text = var_294_26
				arg_291_1.typewritter.percent = 0

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311072", "story_v_out_115311.awb") ~= 0 then
					local var_294_30 = manager.audio:GetVoiceLength("story_v_out_115311", "115311072", "story_v_out_115311.awb") / 1000

					if var_294_30 + var_294_22 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_30 + var_294_22
					end

					if var_294_25.prefab_name ~= "" and arg_291_1.actors_[var_294_25.prefab_name] ~= nil then
						local var_294_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_291_1.actors_[var_294_25.prefab_name].transform, "story_v_out_115311", "115311072", "story_v_out_115311.awb")

						arg_291_1:RecordAudio("115311072", var_294_31)
						arg_291_1:RecordAudio("115311072", var_294_31)
					else
						arg_291_1:AudioAction("play", "voice", "story_v_out_115311", "115311072", "story_v_out_115311.awb")
					end

					arg_291_1:RecordHistoryTalkVoice("story_v_out_115311", "115311072", "story_v_out_115311.awb")
				end

				arg_291_1:RecordContent(arg_291_1.text_.text)
			end

			local var_294_32 = math.max(var_294_23, arg_291_1.talkMaxDuration)

			if var_294_22 <= arg_291_1.time_ and arg_291_1.time_ < var_294_22 + var_294_32 then
				arg_291_1.typewritter.percent = (arg_291_1.time_ - var_294_22) / var_294_32

				arg_291_1.typewritter:SetDirty()
			end

			if arg_291_1.time_ >= var_294_22 + var_294_32 and arg_291_1.time_ < var_294_22 + var_294_32 + arg_294_0 then
				arg_291_1.typewritter.percent = 1

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(true)
			end
		end

		arg_291_1.nodeConfigList_ = {}

		arg_291_1:InitPlayNodeList()
	end,
	Play115311073 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 115311073
		arg_295_1.duration_ = 5.13

		local var_295_0 = {
			ja = 1.4,
			ko = 3.633,
			zh = 3.8,
			en = 5.133
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
				arg_295_0:Play115311074(arg_295_1)
			end
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			local var_298_0 = arg_295_1.actors_["113801_1"]
			local var_298_1 = 0

			if var_298_1 < arg_295_1.time_ and arg_295_1.time_ <= var_298_1 + arg_298_0 and not isNil(var_298_0) then
				local var_298_2 = var_298_0:GetComponent("Image")

				if var_298_2 then
					arg_295_1.var_.highlightMatValue113801_1 = var_298_2
				end
			end

			local var_298_3 = 0.2

			if var_298_1 <= arg_295_1.time_ and arg_295_1.time_ < var_298_1 + var_298_3 and not isNil(var_298_0) then
				local var_298_4 = (arg_295_1.time_ - var_298_1) / var_298_3

				if arg_295_1.var_.highlightMatValue113801_1 then
					local var_298_5 = Mathf.Lerp(1, 0.5, var_298_4)
					local var_298_6 = arg_295_1.var_.highlightMatValue113801_1
					local var_298_7 = var_298_6.color

					var_298_7.r = var_298_5
					var_298_7.g = var_298_5
					var_298_7.b = var_298_5
					var_298_6.color = var_298_7
				end
			end

			if arg_295_1.time_ >= var_298_1 + var_298_3 and arg_295_1.time_ < var_298_1 + var_298_3 + arg_298_0 and not isNil(var_298_0) and arg_295_1.var_.highlightMatValue113801_1 then
				local var_298_8 = 0.5
				local var_298_9 = arg_295_1.var_.highlightMatValue113801_1
				local var_298_10 = var_298_9.color

				var_298_10.r = var_298_8
				var_298_10.g = var_298_8
				var_298_10.b = var_298_8
				var_298_9.color = var_298_10
			end

			local var_298_11 = arg_295_1.actors_["10029"]
			local var_298_12 = 0

			if var_298_12 < arg_295_1.time_ and arg_295_1.time_ <= var_298_12 + arg_298_0 and not isNil(var_298_11) then
				local var_298_13 = var_298_11:GetComponent("Image")

				if var_298_13 then
					arg_295_1.var_.highlightMatValue10029 = var_298_13
				end
			end

			local var_298_14 = 0.2

			if var_298_12 <= arg_295_1.time_ and arg_295_1.time_ < var_298_12 + var_298_14 and not isNil(var_298_11) then
				local var_298_15 = (arg_295_1.time_ - var_298_12) / var_298_14

				if arg_295_1.var_.highlightMatValue10029 then
					local var_298_16 = Mathf.Lerp(0.5, 1, var_298_15)
					local var_298_17 = arg_295_1.var_.highlightMatValue10029
					local var_298_18 = var_298_17.color

					var_298_18.r = var_298_16
					var_298_18.g = var_298_16
					var_298_18.b = var_298_16
					var_298_17.color = var_298_18
				end
			end

			if arg_295_1.time_ >= var_298_12 + var_298_14 and arg_295_1.time_ < var_298_12 + var_298_14 + arg_298_0 and not isNil(var_298_11) and arg_295_1.var_.highlightMatValue10029 then
				local var_298_19 = 1

				var_298_11.transform:SetSiblingIndex(1)

				local var_298_20 = arg_295_1.var_.highlightMatValue10029
				local var_298_21 = var_298_20.color

				var_298_21.r = var_298_19
				var_298_21.g = var_298_19
				var_298_21.b = var_298_19
				var_298_20.color = var_298_21
			end

			local var_298_22 = 0
			local var_298_23 = 0.35

			if var_298_22 < arg_295_1.time_ and arg_295_1.time_ <= var_298_22 + arg_298_0 then
				arg_295_1.talkMaxDuration = 0
				arg_295_1.dialogCg_.alpha = 1

				arg_295_1.dialog_:SetActive(true)
				SetActive(arg_295_1.leftNameGo_, true)

				local var_298_24 = arg_295_1:FormatText(StoryNameCfg[312].name)

				arg_295_1.leftNameTxt_.text = var_298_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_295_1.leftNameTxt_.transform)

				arg_295_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_295_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_295_1:RecordName(arg_295_1.leftNameTxt_.text)
				SetActive(arg_295_1.iconTrs_.gameObject, false)
				arg_295_1.callingController_:SetSelectedState("normal")

				local var_298_25 = arg_295_1:GetWordFromCfg(115311073)
				local var_298_26 = arg_295_1:FormatText(var_298_25.content)

				arg_295_1.text_.text = var_298_26

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_27 = 14
				local var_298_28 = utf8.len(var_298_26)
				local var_298_29 = var_298_27 <= 0 and var_298_23 or var_298_23 * (var_298_28 / var_298_27)

				if var_298_29 > 0 and var_298_23 < var_298_29 then
					arg_295_1.talkMaxDuration = var_298_29

					if var_298_29 + var_298_22 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_29 + var_298_22
					end
				end

				arg_295_1.text_.text = var_298_26
				arg_295_1.typewritter.percent = 0

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311073", "story_v_out_115311.awb") ~= 0 then
					local var_298_30 = manager.audio:GetVoiceLength("story_v_out_115311", "115311073", "story_v_out_115311.awb") / 1000

					if var_298_30 + var_298_22 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_30 + var_298_22
					end

					if var_298_25.prefab_name ~= "" and arg_295_1.actors_[var_298_25.prefab_name] ~= nil then
						local var_298_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_295_1.actors_[var_298_25.prefab_name].transform, "story_v_out_115311", "115311073", "story_v_out_115311.awb")

						arg_295_1:RecordAudio("115311073", var_298_31)
						arg_295_1:RecordAudio("115311073", var_298_31)
					else
						arg_295_1:AudioAction("play", "voice", "story_v_out_115311", "115311073", "story_v_out_115311.awb")
					end

					arg_295_1:RecordHistoryTalkVoice("story_v_out_115311", "115311073", "story_v_out_115311.awb")
				end

				arg_295_1:RecordContent(arg_295_1.text_.text)
			end

			local var_298_32 = math.max(var_298_23, arg_295_1.talkMaxDuration)

			if var_298_22 <= arg_295_1.time_ and arg_295_1.time_ < var_298_22 + var_298_32 then
				arg_295_1.typewritter.percent = (arg_295_1.time_ - var_298_22) / var_298_32

				arg_295_1.typewritter:SetDirty()
			end

			if arg_295_1.time_ >= var_298_22 + var_298_32 and arg_295_1.time_ < var_298_22 + var_298_32 + arg_298_0 then
				arg_295_1.typewritter.percent = 1

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(true)
			end
		end

		arg_295_1.nodeConfigList_ = {}

		arg_295_1:InitPlayNodeList()
	end,
	Play115311074 = function(arg_299_0, arg_299_1)
		arg_299_1.time_ = 0
		arg_299_1.frameCnt_ = 0
		arg_299_1.state_ = "playing"
		arg_299_1.curTalkId_ = 115311074
		arg_299_1.duration_ = 11.4

		local var_299_0 = {
			ja = 9.233,
			ko = 11.033,
			zh = 11.4,
			en = 10.2
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
				arg_299_0:Play115311075(arg_299_1)
			end
		end

		function arg_299_1.onSingleLineUpdate_(arg_302_0)
			local var_302_0 = arg_299_1.actors_["113801_1"]
			local var_302_1 = 0

			if var_302_1 < arg_299_1.time_ and arg_299_1.time_ <= var_302_1 + arg_302_0 and not isNil(var_302_0) then
				local var_302_2 = var_302_0:GetComponent("Image")

				if var_302_2 then
					arg_299_1.var_.highlightMatValue113801_1 = var_302_2
				end
			end

			local var_302_3 = 0.2

			if var_302_1 <= arg_299_1.time_ and arg_299_1.time_ < var_302_1 + var_302_3 and not isNil(var_302_0) then
				local var_302_4 = (arg_299_1.time_ - var_302_1) / var_302_3

				if arg_299_1.var_.highlightMatValue113801_1 then
					local var_302_5 = Mathf.Lerp(0.5, 1, var_302_4)
					local var_302_6 = arg_299_1.var_.highlightMatValue113801_1
					local var_302_7 = var_302_6.color

					var_302_7.r = var_302_5
					var_302_7.g = var_302_5
					var_302_7.b = var_302_5
					var_302_6.color = var_302_7
				end
			end

			if arg_299_1.time_ >= var_302_1 + var_302_3 and arg_299_1.time_ < var_302_1 + var_302_3 + arg_302_0 and not isNil(var_302_0) and arg_299_1.var_.highlightMatValue113801_1 then
				local var_302_8 = 1

				var_302_0.transform:SetSiblingIndex(1)

				local var_302_9 = arg_299_1.var_.highlightMatValue113801_1
				local var_302_10 = var_302_9.color

				var_302_10.r = var_302_8
				var_302_10.g = var_302_8
				var_302_10.b = var_302_8
				var_302_9.color = var_302_10
			end

			local var_302_11 = arg_299_1.actors_["10029"]
			local var_302_12 = 0

			if var_302_12 < arg_299_1.time_ and arg_299_1.time_ <= var_302_12 + arg_302_0 and not isNil(var_302_11) then
				local var_302_13 = var_302_11:GetComponent("Image")

				if var_302_13 then
					arg_299_1.var_.highlightMatValue10029 = var_302_13
				end
			end

			local var_302_14 = 0.2

			if var_302_12 <= arg_299_1.time_ and arg_299_1.time_ < var_302_12 + var_302_14 and not isNil(var_302_11) then
				local var_302_15 = (arg_299_1.time_ - var_302_12) / var_302_14

				if arg_299_1.var_.highlightMatValue10029 then
					local var_302_16 = Mathf.Lerp(1, 0.5, var_302_15)
					local var_302_17 = arg_299_1.var_.highlightMatValue10029
					local var_302_18 = var_302_17.color

					var_302_18.r = var_302_16
					var_302_18.g = var_302_16
					var_302_18.b = var_302_16
					var_302_17.color = var_302_18
				end
			end

			if arg_299_1.time_ >= var_302_12 + var_302_14 and arg_299_1.time_ < var_302_12 + var_302_14 + arg_302_0 and not isNil(var_302_11) and arg_299_1.var_.highlightMatValue10029 then
				local var_302_19 = 0.5
				local var_302_20 = arg_299_1.var_.highlightMatValue10029
				local var_302_21 = var_302_20.color

				var_302_21.r = var_302_19
				var_302_21.g = var_302_19
				var_302_21.b = var_302_19
				var_302_20.color = var_302_21
			end

			local var_302_22 = 0
			local var_302_23 = 1.1

			if var_302_22 < arg_299_1.time_ and arg_299_1.time_ <= var_302_22 + arg_302_0 then
				arg_299_1.talkMaxDuration = 0
				arg_299_1.dialogCg_.alpha = 1

				arg_299_1.dialog_:SetActive(true)
				SetActive(arg_299_1.leftNameGo_, true)

				local var_302_24 = arg_299_1:FormatText(StoryNameCfg[94].name)

				arg_299_1.leftNameTxt_.text = var_302_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_299_1.leftNameTxt_.transform)

				arg_299_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_299_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_299_1:RecordName(arg_299_1.leftNameTxt_.text)
				SetActive(arg_299_1.iconTrs_.gameObject, false)
				arg_299_1.callingController_:SetSelectedState("normal")

				local var_302_25 = arg_299_1:GetWordFromCfg(115311074)
				local var_302_26 = arg_299_1:FormatText(var_302_25.content)

				arg_299_1.text_.text = var_302_26

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.text_)

				local var_302_27 = 44
				local var_302_28 = utf8.len(var_302_26)
				local var_302_29 = var_302_27 <= 0 and var_302_23 or var_302_23 * (var_302_28 / var_302_27)

				if var_302_29 > 0 and var_302_23 < var_302_29 then
					arg_299_1.talkMaxDuration = var_302_29

					if var_302_29 + var_302_22 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_29 + var_302_22
					end
				end

				arg_299_1.text_.text = var_302_26
				arg_299_1.typewritter.percent = 0

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311074", "story_v_out_115311.awb") ~= 0 then
					local var_302_30 = manager.audio:GetVoiceLength("story_v_out_115311", "115311074", "story_v_out_115311.awb") / 1000

					if var_302_30 + var_302_22 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_30 + var_302_22
					end

					if var_302_25.prefab_name ~= "" and arg_299_1.actors_[var_302_25.prefab_name] ~= nil then
						local var_302_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_299_1.actors_[var_302_25.prefab_name].transform, "story_v_out_115311", "115311074", "story_v_out_115311.awb")

						arg_299_1:RecordAudio("115311074", var_302_31)
						arg_299_1:RecordAudio("115311074", var_302_31)
					else
						arg_299_1:AudioAction("play", "voice", "story_v_out_115311", "115311074", "story_v_out_115311.awb")
					end

					arg_299_1:RecordHistoryTalkVoice("story_v_out_115311", "115311074", "story_v_out_115311.awb")
				end

				arg_299_1:RecordContent(arg_299_1.text_.text)
			end

			local var_302_32 = math.max(var_302_23, arg_299_1.talkMaxDuration)

			if var_302_22 <= arg_299_1.time_ and arg_299_1.time_ < var_302_22 + var_302_32 then
				arg_299_1.typewritter.percent = (arg_299_1.time_ - var_302_22) / var_302_32

				arg_299_1.typewritter:SetDirty()
			end

			if arg_299_1.time_ >= var_302_22 + var_302_32 and arg_299_1.time_ < var_302_22 + var_302_32 + arg_302_0 then
				arg_299_1.typewritter.percent = 1

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(true)
			end
		end

		arg_299_1.nodeConfigList_ = {}

		arg_299_1:InitPlayNodeList()
	end,
	Play115311075 = function(arg_303_0, arg_303_1)
		arg_303_1.time_ = 0
		arg_303_1.frameCnt_ = 0
		arg_303_1.state_ = "playing"
		arg_303_1.curTalkId_ = 115311075
		arg_303_1.duration_ = 11.7

		local var_303_0 = {
			ja = 11.7,
			ko = 7.033,
			zh = 5.6,
			en = 7.2
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
				arg_303_0:Play115311076(arg_303_1)
			end
		end

		function arg_303_1.onSingleLineUpdate_(arg_306_0)
			local var_306_0 = 0
			local var_306_1 = 0.6

			if var_306_0 < arg_303_1.time_ and arg_303_1.time_ <= var_306_0 + arg_306_0 then
				arg_303_1.talkMaxDuration = 0
				arg_303_1.dialogCg_.alpha = 1

				arg_303_1.dialog_:SetActive(true)
				SetActive(arg_303_1.leftNameGo_, true)

				local var_306_2 = arg_303_1:FormatText(StoryNameCfg[94].name)

				arg_303_1.leftNameTxt_.text = var_306_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_303_1.leftNameTxt_.transform)

				arg_303_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_303_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_303_1:RecordName(arg_303_1.leftNameTxt_.text)
				SetActive(arg_303_1.iconTrs_.gameObject, false)
				arg_303_1.callingController_:SetSelectedState("normal")

				local var_306_3 = arg_303_1:GetWordFromCfg(115311075)
				local var_306_4 = arg_303_1:FormatText(var_306_3.content)

				arg_303_1.text_.text = var_306_4

				LuaForUtil.ClearLinePrefixSymbol(arg_303_1.text_)

				local var_306_5 = 24
				local var_306_6 = utf8.len(var_306_4)
				local var_306_7 = var_306_5 <= 0 and var_306_1 or var_306_1 * (var_306_6 / var_306_5)

				if var_306_7 > 0 and var_306_1 < var_306_7 then
					arg_303_1.talkMaxDuration = var_306_7

					if var_306_7 + var_306_0 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_7 + var_306_0
					end
				end

				arg_303_1.text_.text = var_306_4
				arg_303_1.typewritter.percent = 0

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311075", "story_v_out_115311.awb") ~= 0 then
					local var_306_8 = manager.audio:GetVoiceLength("story_v_out_115311", "115311075", "story_v_out_115311.awb") / 1000

					if var_306_8 + var_306_0 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_8 + var_306_0
					end

					if var_306_3.prefab_name ~= "" and arg_303_1.actors_[var_306_3.prefab_name] ~= nil then
						local var_306_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_303_1.actors_[var_306_3.prefab_name].transform, "story_v_out_115311", "115311075", "story_v_out_115311.awb")

						arg_303_1:RecordAudio("115311075", var_306_9)
						arg_303_1:RecordAudio("115311075", var_306_9)
					else
						arg_303_1:AudioAction("play", "voice", "story_v_out_115311", "115311075", "story_v_out_115311.awb")
					end

					arg_303_1:RecordHistoryTalkVoice("story_v_out_115311", "115311075", "story_v_out_115311.awb")
				end

				arg_303_1:RecordContent(arg_303_1.text_.text)
			end

			local var_306_10 = math.max(var_306_1, arg_303_1.talkMaxDuration)

			if var_306_0 <= arg_303_1.time_ and arg_303_1.time_ < var_306_0 + var_306_10 then
				arg_303_1.typewritter.percent = (arg_303_1.time_ - var_306_0) / var_306_10

				arg_303_1.typewritter:SetDirty()
			end

			if arg_303_1.time_ >= var_306_0 + var_306_10 and arg_303_1.time_ < var_306_0 + var_306_10 + arg_306_0 then
				arg_303_1.typewritter.percent = 1

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(true)
			end
		end

		arg_303_1.nodeConfigList_ = {}

		arg_303_1:InitPlayNodeList()
	end,
	Play115311076 = function(arg_307_0, arg_307_1)
		arg_307_1.time_ = 0
		arg_307_1.frameCnt_ = 0
		arg_307_1.state_ = "playing"
		arg_307_1.curTalkId_ = 115311076
		arg_307_1.duration_ = 11.83

		local var_307_0 = {
			ja = 8.9,
			ko = 11.833,
			zh = 9.866,
			en = 11.633
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
				arg_307_0:Play115311077(arg_307_1)
			end
		end

		function arg_307_1.onSingleLineUpdate_(arg_310_0)
			local var_310_0 = arg_307_1.actors_["113801_1"]
			local var_310_1 = 0

			if var_310_1 < arg_307_1.time_ and arg_307_1.time_ <= var_310_1 + arg_310_0 and not isNil(var_310_0) then
				local var_310_2 = var_310_0:GetComponent("Image")

				if var_310_2 then
					arg_307_1.var_.highlightMatValue113801_1 = var_310_2
				end
			end

			local var_310_3 = 0.2

			if var_310_1 <= arg_307_1.time_ and arg_307_1.time_ < var_310_1 + var_310_3 and not isNil(var_310_0) then
				local var_310_4 = (arg_307_1.time_ - var_310_1) / var_310_3

				if arg_307_1.var_.highlightMatValue113801_1 then
					local var_310_5 = Mathf.Lerp(1, 0.5, var_310_4)
					local var_310_6 = arg_307_1.var_.highlightMatValue113801_1
					local var_310_7 = var_310_6.color

					var_310_7.r = var_310_5
					var_310_7.g = var_310_5
					var_310_7.b = var_310_5
					var_310_6.color = var_310_7
				end
			end

			if arg_307_1.time_ >= var_310_1 + var_310_3 and arg_307_1.time_ < var_310_1 + var_310_3 + arg_310_0 and not isNil(var_310_0) and arg_307_1.var_.highlightMatValue113801_1 then
				local var_310_8 = 0.5
				local var_310_9 = arg_307_1.var_.highlightMatValue113801_1
				local var_310_10 = var_310_9.color

				var_310_10.r = var_310_8
				var_310_10.g = var_310_8
				var_310_10.b = var_310_8
				var_310_9.color = var_310_10
			end

			local var_310_11 = arg_307_1.actors_["10029"]
			local var_310_12 = 0

			if var_310_12 < arg_307_1.time_ and arg_307_1.time_ <= var_310_12 + arg_310_0 and not isNil(var_310_11) then
				local var_310_13 = var_310_11:GetComponent("Image")

				if var_310_13 then
					arg_307_1.var_.highlightMatValue10029 = var_310_13
				end
			end

			local var_310_14 = 0.2

			if var_310_12 <= arg_307_1.time_ and arg_307_1.time_ < var_310_12 + var_310_14 and not isNil(var_310_11) then
				local var_310_15 = (arg_307_1.time_ - var_310_12) / var_310_14

				if arg_307_1.var_.highlightMatValue10029 then
					local var_310_16 = Mathf.Lerp(0.5, 1, var_310_15)
					local var_310_17 = arg_307_1.var_.highlightMatValue10029
					local var_310_18 = var_310_17.color

					var_310_18.r = var_310_16
					var_310_18.g = var_310_16
					var_310_18.b = var_310_16
					var_310_17.color = var_310_18
				end
			end

			if arg_307_1.time_ >= var_310_12 + var_310_14 and arg_307_1.time_ < var_310_12 + var_310_14 + arg_310_0 and not isNil(var_310_11) and arg_307_1.var_.highlightMatValue10029 then
				local var_310_19 = 1

				var_310_11.transform:SetSiblingIndex(1)

				local var_310_20 = arg_307_1.var_.highlightMatValue10029
				local var_310_21 = var_310_20.color

				var_310_21.r = var_310_19
				var_310_21.g = var_310_19
				var_310_21.b = var_310_19
				var_310_20.color = var_310_21
			end

			local var_310_22 = 0
			local var_310_23 = 0.925

			if var_310_22 < arg_307_1.time_ and arg_307_1.time_ <= var_310_22 + arg_310_0 then
				arg_307_1.talkMaxDuration = 0
				arg_307_1.dialogCg_.alpha = 1

				arg_307_1.dialog_:SetActive(true)
				SetActive(arg_307_1.leftNameGo_, true)

				local var_310_24 = arg_307_1:FormatText(StoryNameCfg[312].name)

				arg_307_1.leftNameTxt_.text = var_310_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_307_1.leftNameTxt_.transform)

				arg_307_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_307_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_307_1:RecordName(arg_307_1.leftNameTxt_.text)
				SetActive(arg_307_1.iconTrs_.gameObject, false)
				arg_307_1.callingController_:SetSelectedState("normal")

				local var_310_25 = arg_307_1:GetWordFromCfg(115311076)
				local var_310_26 = arg_307_1:FormatText(var_310_25.content)

				arg_307_1.text_.text = var_310_26

				LuaForUtil.ClearLinePrefixSymbol(arg_307_1.text_)

				local var_310_27 = 37
				local var_310_28 = utf8.len(var_310_26)
				local var_310_29 = var_310_27 <= 0 and var_310_23 or var_310_23 * (var_310_28 / var_310_27)

				if var_310_29 > 0 and var_310_23 < var_310_29 then
					arg_307_1.talkMaxDuration = var_310_29

					if var_310_29 + var_310_22 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_29 + var_310_22
					end
				end

				arg_307_1.text_.text = var_310_26
				arg_307_1.typewritter.percent = 0

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311076", "story_v_out_115311.awb") ~= 0 then
					local var_310_30 = manager.audio:GetVoiceLength("story_v_out_115311", "115311076", "story_v_out_115311.awb") / 1000

					if var_310_30 + var_310_22 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_30 + var_310_22
					end

					if var_310_25.prefab_name ~= "" and arg_307_1.actors_[var_310_25.prefab_name] ~= nil then
						local var_310_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_307_1.actors_[var_310_25.prefab_name].transform, "story_v_out_115311", "115311076", "story_v_out_115311.awb")

						arg_307_1:RecordAudio("115311076", var_310_31)
						arg_307_1:RecordAudio("115311076", var_310_31)
					else
						arg_307_1:AudioAction("play", "voice", "story_v_out_115311", "115311076", "story_v_out_115311.awb")
					end

					arg_307_1:RecordHistoryTalkVoice("story_v_out_115311", "115311076", "story_v_out_115311.awb")
				end

				arg_307_1:RecordContent(arg_307_1.text_.text)
			end

			local var_310_32 = math.max(var_310_23, arg_307_1.talkMaxDuration)

			if var_310_22 <= arg_307_1.time_ and arg_307_1.time_ < var_310_22 + var_310_32 then
				arg_307_1.typewritter.percent = (arg_307_1.time_ - var_310_22) / var_310_32

				arg_307_1.typewritter:SetDirty()
			end

			if arg_307_1.time_ >= var_310_22 + var_310_32 and arg_307_1.time_ < var_310_22 + var_310_32 + arg_310_0 then
				arg_307_1.typewritter.percent = 1

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(true)
			end
		end

		arg_307_1.nodeConfigList_ = {}

		arg_307_1:InitPlayNodeList()
	end,
	Play115311077 = function(arg_311_0, arg_311_1)
		arg_311_1.time_ = 0
		arg_311_1.frameCnt_ = 0
		arg_311_1.state_ = "playing"
		arg_311_1.curTalkId_ = 115311077
		arg_311_1.duration_ = 12

		local var_311_0 = {
			ja = 12,
			ko = 7.466,
			zh = 7.266,
			en = 8.9
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
				arg_311_0:Play115311078(arg_311_1)
			end
		end

		function arg_311_1.onSingleLineUpdate_(arg_314_0)
			local var_314_0 = arg_311_1.actors_["113801_1"]
			local var_314_1 = 0

			if var_314_1 < arg_311_1.time_ and arg_311_1.time_ <= var_314_1 + arg_314_0 and not isNil(var_314_0) then
				local var_314_2 = var_314_0:GetComponent("Image")

				if var_314_2 then
					arg_311_1.var_.highlightMatValue113801_1 = var_314_2
				end
			end

			local var_314_3 = 0.2

			if var_314_1 <= arg_311_1.time_ and arg_311_1.time_ < var_314_1 + var_314_3 and not isNil(var_314_0) then
				local var_314_4 = (arg_311_1.time_ - var_314_1) / var_314_3

				if arg_311_1.var_.highlightMatValue113801_1 then
					local var_314_5 = Mathf.Lerp(0.5, 1, var_314_4)
					local var_314_6 = arg_311_1.var_.highlightMatValue113801_1
					local var_314_7 = var_314_6.color

					var_314_7.r = var_314_5
					var_314_7.g = var_314_5
					var_314_7.b = var_314_5
					var_314_6.color = var_314_7
				end
			end

			if arg_311_1.time_ >= var_314_1 + var_314_3 and arg_311_1.time_ < var_314_1 + var_314_3 + arg_314_0 and not isNil(var_314_0) and arg_311_1.var_.highlightMatValue113801_1 then
				local var_314_8 = 1

				var_314_0.transform:SetSiblingIndex(1)

				local var_314_9 = arg_311_1.var_.highlightMatValue113801_1
				local var_314_10 = var_314_9.color

				var_314_10.r = var_314_8
				var_314_10.g = var_314_8
				var_314_10.b = var_314_8
				var_314_9.color = var_314_10
			end

			local var_314_11 = arg_311_1.actors_["10029"]
			local var_314_12 = 0

			if var_314_12 < arg_311_1.time_ and arg_311_1.time_ <= var_314_12 + arg_314_0 and not isNil(var_314_11) then
				local var_314_13 = var_314_11:GetComponent("Image")

				if var_314_13 then
					arg_311_1.var_.highlightMatValue10029 = var_314_13
				end
			end

			local var_314_14 = 0.2

			if var_314_12 <= arg_311_1.time_ and arg_311_1.time_ < var_314_12 + var_314_14 and not isNil(var_314_11) then
				local var_314_15 = (arg_311_1.time_ - var_314_12) / var_314_14

				if arg_311_1.var_.highlightMatValue10029 then
					local var_314_16 = Mathf.Lerp(1, 0.5, var_314_15)
					local var_314_17 = arg_311_1.var_.highlightMatValue10029
					local var_314_18 = var_314_17.color

					var_314_18.r = var_314_16
					var_314_18.g = var_314_16
					var_314_18.b = var_314_16
					var_314_17.color = var_314_18
				end
			end

			if arg_311_1.time_ >= var_314_12 + var_314_14 and arg_311_1.time_ < var_314_12 + var_314_14 + arg_314_0 and not isNil(var_314_11) and arg_311_1.var_.highlightMatValue10029 then
				local var_314_19 = 0.5
				local var_314_20 = arg_311_1.var_.highlightMatValue10029
				local var_314_21 = var_314_20.color

				var_314_21.r = var_314_19
				var_314_21.g = var_314_19
				var_314_21.b = var_314_19
				var_314_20.color = var_314_21
			end

			local var_314_22 = 0
			local var_314_23 = 0.7

			if var_314_22 < arg_311_1.time_ and arg_311_1.time_ <= var_314_22 + arg_314_0 then
				arg_311_1.talkMaxDuration = 0
				arg_311_1.dialogCg_.alpha = 1

				arg_311_1.dialog_:SetActive(true)
				SetActive(arg_311_1.leftNameGo_, true)

				local var_314_24 = arg_311_1:FormatText(StoryNameCfg[94].name)

				arg_311_1.leftNameTxt_.text = var_314_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_311_1.leftNameTxt_.transform)

				arg_311_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_311_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_311_1:RecordName(arg_311_1.leftNameTxt_.text)
				SetActive(arg_311_1.iconTrs_.gameObject, false)
				arg_311_1.callingController_:SetSelectedState("normal")

				local var_314_25 = arg_311_1:GetWordFromCfg(115311077)
				local var_314_26 = arg_311_1:FormatText(var_314_25.content)

				arg_311_1.text_.text = var_314_26

				LuaForUtil.ClearLinePrefixSymbol(arg_311_1.text_)

				local var_314_27 = 28
				local var_314_28 = utf8.len(var_314_26)
				local var_314_29 = var_314_27 <= 0 and var_314_23 or var_314_23 * (var_314_28 / var_314_27)

				if var_314_29 > 0 and var_314_23 < var_314_29 then
					arg_311_1.talkMaxDuration = var_314_29

					if var_314_29 + var_314_22 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_29 + var_314_22
					end
				end

				arg_311_1.text_.text = var_314_26
				arg_311_1.typewritter.percent = 0

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311077", "story_v_out_115311.awb") ~= 0 then
					local var_314_30 = manager.audio:GetVoiceLength("story_v_out_115311", "115311077", "story_v_out_115311.awb") / 1000

					if var_314_30 + var_314_22 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_30 + var_314_22
					end

					if var_314_25.prefab_name ~= "" and arg_311_1.actors_[var_314_25.prefab_name] ~= nil then
						local var_314_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_311_1.actors_[var_314_25.prefab_name].transform, "story_v_out_115311", "115311077", "story_v_out_115311.awb")

						arg_311_1:RecordAudio("115311077", var_314_31)
						arg_311_1:RecordAudio("115311077", var_314_31)
					else
						arg_311_1:AudioAction("play", "voice", "story_v_out_115311", "115311077", "story_v_out_115311.awb")
					end

					arg_311_1:RecordHistoryTalkVoice("story_v_out_115311", "115311077", "story_v_out_115311.awb")
				end

				arg_311_1:RecordContent(arg_311_1.text_.text)
			end

			local var_314_32 = math.max(var_314_23, arg_311_1.talkMaxDuration)

			if var_314_22 <= arg_311_1.time_ and arg_311_1.time_ < var_314_22 + var_314_32 then
				arg_311_1.typewritter.percent = (arg_311_1.time_ - var_314_22) / var_314_32

				arg_311_1.typewritter:SetDirty()
			end

			if arg_311_1.time_ >= var_314_22 + var_314_32 and arg_311_1.time_ < var_314_22 + var_314_32 + arg_314_0 then
				arg_311_1.typewritter.percent = 1

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(true)
			end
		end

		arg_311_1.nodeConfigList_ = {}

		arg_311_1:InitPlayNodeList()
	end,
	Play115311078 = function(arg_315_0, arg_315_1)
		arg_315_1.time_ = 0
		arg_315_1.frameCnt_ = 0
		arg_315_1.state_ = "playing"
		arg_315_1.curTalkId_ = 115311078
		arg_315_1.duration_ = 5

		SetActive(arg_315_1.tipsGo_, false)

		function arg_315_1.onSingleLineFinish_()
			arg_315_1.onSingleLineUpdate_ = nil
			arg_315_1.onSingleLineFinish_ = nil
			arg_315_1.state_ = "waiting"
		end

		function arg_315_1.playNext_(arg_317_0)
			if arg_317_0 == 1 then
				arg_315_0:Play115311079(arg_315_1)
			end
		end

		function arg_315_1.onSingleLineUpdate_(arg_318_0)
			local var_318_0 = arg_315_1.actors_["113801_1"]
			local var_318_1 = 0

			if var_318_1 < arg_315_1.time_ and arg_315_1.time_ <= var_318_1 + arg_318_0 and not isNil(var_318_0) then
				local var_318_2 = var_318_0:GetComponent("Image")

				if var_318_2 then
					arg_315_1.var_.highlightMatValue113801_1 = var_318_2
				end
			end

			local var_318_3 = 0.2

			if var_318_1 <= arg_315_1.time_ and arg_315_1.time_ < var_318_1 + var_318_3 and not isNil(var_318_0) then
				local var_318_4 = (arg_315_1.time_ - var_318_1) / var_318_3

				if arg_315_1.var_.highlightMatValue113801_1 then
					local var_318_5 = Mathf.Lerp(1, 0.5, var_318_4)
					local var_318_6 = arg_315_1.var_.highlightMatValue113801_1
					local var_318_7 = var_318_6.color

					var_318_7.r = var_318_5
					var_318_7.g = var_318_5
					var_318_7.b = var_318_5
					var_318_6.color = var_318_7
				end
			end

			if arg_315_1.time_ >= var_318_1 + var_318_3 and arg_315_1.time_ < var_318_1 + var_318_3 + arg_318_0 and not isNil(var_318_0) and arg_315_1.var_.highlightMatValue113801_1 then
				local var_318_8 = 0.5
				local var_318_9 = arg_315_1.var_.highlightMatValue113801_1
				local var_318_10 = var_318_9.color

				var_318_10.r = var_318_8
				var_318_10.g = var_318_8
				var_318_10.b = var_318_8
				var_318_9.color = var_318_10
			end

			local var_318_11 = 0
			local var_318_12 = 1.4

			if var_318_11 < arg_315_1.time_ and arg_315_1.time_ <= var_318_11 + arg_318_0 then
				arg_315_1.talkMaxDuration = 0
				arg_315_1.dialogCg_.alpha = 1

				arg_315_1.dialog_:SetActive(true)
				SetActive(arg_315_1.leftNameGo_, false)

				arg_315_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_315_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_315_1:RecordName(arg_315_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_315_1.iconTrs_.gameObject, false)
				arg_315_1.callingController_:SetSelectedState("normal")

				local var_318_13 = arg_315_1:GetWordFromCfg(115311078)
				local var_318_14 = arg_315_1:FormatText(var_318_13.content)

				arg_315_1.text_.text = var_318_14

				LuaForUtil.ClearLinePrefixSymbol(arg_315_1.text_)

				local var_318_15 = 56
				local var_318_16 = utf8.len(var_318_14)
				local var_318_17 = var_318_15 <= 0 and var_318_12 or var_318_12 * (var_318_16 / var_318_15)

				if var_318_17 > 0 and var_318_12 < var_318_17 then
					arg_315_1.talkMaxDuration = var_318_17

					if var_318_17 + var_318_11 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_17 + var_318_11
					end
				end

				arg_315_1.text_.text = var_318_14
				arg_315_1.typewritter.percent = 0

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(false)
				arg_315_1:RecordContent(arg_315_1.text_.text)
			end

			local var_318_18 = math.max(var_318_12, arg_315_1.talkMaxDuration)

			if var_318_11 <= arg_315_1.time_ and arg_315_1.time_ < var_318_11 + var_318_18 then
				arg_315_1.typewritter.percent = (arg_315_1.time_ - var_318_11) / var_318_18

				arg_315_1.typewritter:SetDirty()
			end

			if arg_315_1.time_ >= var_318_11 + var_318_18 and arg_315_1.time_ < var_318_11 + var_318_18 + arg_318_0 then
				arg_315_1.typewritter.percent = 1

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(true)
			end
		end

		arg_315_1.nodeConfigList_ = {}

		arg_315_1:InitPlayNodeList()
	end,
	Play115311079 = function(arg_319_0, arg_319_1)
		arg_319_1.time_ = 0
		arg_319_1.frameCnt_ = 0
		arg_319_1.state_ = "playing"
		arg_319_1.curTalkId_ = 115311079
		arg_319_1.duration_ = 7.23

		local var_319_0 = {
			ja = 6.2,
			ko = 7.233,
			zh = 7.2,
			en = 5.8
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
				arg_319_0:Play115311080(arg_319_1)
			end
		end

		function arg_319_1.onSingleLineUpdate_(arg_322_0)
			local var_322_0 = arg_319_1.actors_["113801_1"]
			local var_322_1 = 0

			if var_322_1 < arg_319_1.time_ and arg_319_1.time_ <= var_322_1 + arg_322_0 and not isNil(var_322_0) then
				local var_322_2 = var_322_0:GetComponent("Image")

				if var_322_2 then
					arg_319_1.var_.highlightMatValue113801_1 = var_322_2
				end
			end

			local var_322_3 = 0.2

			if var_322_1 <= arg_319_1.time_ and arg_319_1.time_ < var_322_1 + var_322_3 and not isNil(var_322_0) then
				local var_322_4 = (arg_319_1.time_ - var_322_1) / var_322_3

				if arg_319_1.var_.highlightMatValue113801_1 then
					local var_322_5 = Mathf.Lerp(0.5, 1, var_322_4)
					local var_322_6 = arg_319_1.var_.highlightMatValue113801_1
					local var_322_7 = var_322_6.color

					var_322_7.r = var_322_5
					var_322_7.g = var_322_5
					var_322_7.b = var_322_5
					var_322_6.color = var_322_7
				end
			end

			if arg_319_1.time_ >= var_322_1 + var_322_3 and arg_319_1.time_ < var_322_1 + var_322_3 + arg_322_0 and not isNil(var_322_0) and arg_319_1.var_.highlightMatValue113801_1 then
				local var_322_8 = 1

				var_322_0.transform:SetSiblingIndex(1)

				local var_322_9 = arg_319_1.var_.highlightMatValue113801_1
				local var_322_10 = var_322_9.color

				var_322_10.r = var_322_8
				var_322_10.g = var_322_8
				var_322_10.b = var_322_8
				var_322_9.color = var_322_10
			end

			local var_322_11 = 0
			local var_322_12 = 0.675

			if var_322_11 < arg_319_1.time_ and arg_319_1.time_ <= var_322_11 + arg_322_0 then
				arg_319_1.talkMaxDuration = 0
				arg_319_1.dialogCg_.alpha = 1

				arg_319_1.dialog_:SetActive(true)
				SetActive(arg_319_1.leftNameGo_, true)

				local var_322_13 = arg_319_1:FormatText(StoryNameCfg[94].name)

				arg_319_1.leftNameTxt_.text = var_322_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_319_1.leftNameTxt_.transform)

				arg_319_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_319_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_319_1:RecordName(arg_319_1.leftNameTxt_.text)
				SetActive(arg_319_1.iconTrs_.gameObject, false)
				arg_319_1.callingController_:SetSelectedState("normal")

				local var_322_14 = arg_319_1:GetWordFromCfg(115311079)
				local var_322_15 = arg_319_1:FormatText(var_322_14.content)

				arg_319_1.text_.text = var_322_15

				LuaForUtil.ClearLinePrefixSymbol(arg_319_1.text_)

				local var_322_16 = 27
				local var_322_17 = utf8.len(var_322_15)
				local var_322_18 = var_322_16 <= 0 and var_322_12 or var_322_12 * (var_322_17 / var_322_16)

				if var_322_18 > 0 and var_322_12 < var_322_18 then
					arg_319_1.talkMaxDuration = var_322_18

					if var_322_18 + var_322_11 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_18 + var_322_11
					end
				end

				arg_319_1.text_.text = var_322_15
				arg_319_1.typewritter.percent = 0

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311079", "story_v_out_115311.awb") ~= 0 then
					local var_322_19 = manager.audio:GetVoiceLength("story_v_out_115311", "115311079", "story_v_out_115311.awb") / 1000

					if var_322_19 + var_322_11 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_19 + var_322_11
					end

					if var_322_14.prefab_name ~= "" and arg_319_1.actors_[var_322_14.prefab_name] ~= nil then
						local var_322_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_319_1.actors_[var_322_14.prefab_name].transform, "story_v_out_115311", "115311079", "story_v_out_115311.awb")

						arg_319_1:RecordAudio("115311079", var_322_20)
						arg_319_1:RecordAudio("115311079", var_322_20)
					else
						arg_319_1:AudioAction("play", "voice", "story_v_out_115311", "115311079", "story_v_out_115311.awb")
					end

					arg_319_1:RecordHistoryTalkVoice("story_v_out_115311", "115311079", "story_v_out_115311.awb")
				end

				arg_319_1:RecordContent(arg_319_1.text_.text)
			end

			local var_322_21 = math.max(var_322_12, arg_319_1.talkMaxDuration)

			if var_322_11 <= arg_319_1.time_ and arg_319_1.time_ < var_322_11 + var_322_21 then
				arg_319_1.typewritter.percent = (arg_319_1.time_ - var_322_11) / var_322_21

				arg_319_1.typewritter:SetDirty()
			end

			if arg_319_1.time_ >= var_322_11 + var_322_21 and arg_319_1.time_ < var_322_11 + var_322_21 + arg_322_0 then
				arg_319_1.typewritter.percent = 1

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(true)
			end
		end

		arg_319_1.nodeConfigList_ = {}

		arg_319_1:InitPlayNodeList()
	end,
	Play115311080 = function(arg_323_0, arg_323_1)
		arg_323_1.time_ = 0
		arg_323_1.frameCnt_ = 0
		arg_323_1.state_ = "playing"
		arg_323_1.curTalkId_ = 115311080
		arg_323_1.duration_ = 7.47

		local var_323_0 = {
			ja = 4.066,
			ko = 6.433,
			zh = 5.8,
			en = 7.466
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
				arg_323_0:Play115311081(arg_323_1)
			end
		end

		function arg_323_1.onSingleLineUpdate_(arg_326_0)
			local var_326_0 = arg_323_1.actors_["113801_1"]
			local var_326_1 = 0

			if var_326_1 < arg_323_1.time_ and arg_323_1.time_ <= var_326_1 + arg_326_0 and not isNil(var_326_0) then
				local var_326_2 = var_326_0:GetComponent("Image")

				if var_326_2 then
					arg_323_1.var_.highlightMatValue113801_1 = var_326_2
				end
			end

			local var_326_3 = 0.2

			if var_326_1 <= arg_323_1.time_ and arg_323_1.time_ < var_326_1 + var_326_3 and not isNil(var_326_0) then
				local var_326_4 = (arg_323_1.time_ - var_326_1) / var_326_3

				if arg_323_1.var_.highlightMatValue113801_1 then
					local var_326_5 = Mathf.Lerp(1, 0.5, var_326_4)
					local var_326_6 = arg_323_1.var_.highlightMatValue113801_1
					local var_326_7 = var_326_6.color

					var_326_7.r = var_326_5
					var_326_7.g = var_326_5
					var_326_7.b = var_326_5
					var_326_6.color = var_326_7
				end
			end

			if arg_323_1.time_ >= var_326_1 + var_326_3 and arg_323_1.time_ < var_326_1 + var_326_3 + arg_326_0 and not isNil(var_326_0) and arg_323_1.var_.highlightMatValue113801_1 then
				local var_326_8 = 0.5
				local var_326_9 = arg_323_1.var_.highlightMatValue113801_1
				local var_326_10 = var_326_9.color

				var_326_10.r = var_326_8
				var_326_10.g = var_326_8
				var_326_10.b = var_326_8
				var_326_9.color = var_326_10
			end

			local var_326_11 = arg_323_1.actors_["10029"]
			local var_326_12 = 0

			if var_326_12 < arg_323_1.time_ and arg_323_1.time_ <= var_326_12 + arg_326_0 and not isNil(var_326_11) then
				local var_326_13 = var_326_11:GetComponent("Image")

				if var_326_13 then
					arg_323_1.var_.highlightMatValue10029 = var_326_13
				end
			end

			local var_326_14 = 0.2

			if var_326_12 <= arg_323_1.time_ and arg_323_1.time_ < var_326_12 + var_326_14 and not isNil(var_326_11) then
				local var_326_15 = (arg_323_1.time_ - var_326_12) / var_326_14

				if arg_323_1.var_.highlightMatValue10029 then
					local var_326_16 = Mathf.Lerp(0.5, 1, var_326_15)
					local var_326_17 = arg_323_1.var_.highlightMatValue10029
					local var_326_18 = var_326_17.color

					var_326_18.r = var_326_16
					var_326_18.g = var_326_16
					var_326_18.b = var_326_16
					var_326_17.color = var_326_18
				end
			end

			if arg_323_1.time_ >= var_326_12 + var_326_14 and arg_323_1.time_ < var_326_12 + var_326_14 + arg_326_0 and not isNil(var_326_11) and arg_323_1.var_.highlightMatValue10029 then
				local var_326_19 = 1

				var_326_11.transform:SetSiblingIndex(1)

				local var_326_20 = arg_323_1.var_.highlightMatValue10029
				local var_326_21 = var_326_20.color

				var_326_21.r = var_326_19
				var_326_21.g = var_326_19
				var_326_21.b = var_326_19
				var_326_20.color = var_326_21
			end

			local var_326_22 = 0
			local var_326_23 = 0.5

			if var_326_22 < arg_323_1.time_ and arg_323_1.time_ <= var_326_22 + arg_326_0 then
				arg_323_1.talkMaxDuration = 0
				arg_323_1.dialogCg_.alpha = 1

				arg_323_1.dialog_:SetActive(true)
				SetActive(arg_323_1.leftNameGo_, true)

				local var_326_24 = arg_323_1:FormatText(StoryNameCfg[312].name)

				arg_323_1.leftNameTxt_.text = var_326_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_323_1.leftNameTxt_.transform)

				arg_323_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_323_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_323_1:RecordName(arg_323_1.leftNameTxt_.text)
				SetActive(arg_323_1.iconTrs_.gameObject, false)
				arg_323_1.callingController_:SetSelectedState("normal")

				local var_326_25 = arg_323_1:GetWordFromCfg(115311080)
				local var_326_26 = arg_323_1:FormatText(var_326_25.content)

				arg_323_1.text_.text = var_326_26

				LuaForUtil.ClearLinePrefixSymbol(arg_323_1.text_)

				local var_326_27 = 20
				local var_326_28 = utf8.len(var_326_26)
				local var_326_29 = var_326_27 <= 0 and var_326_23 or var_326_23 * (var_326_28 / var_326_27)

				if var_326_29 > 0 and var_326_23 < var_326_29 then
					arg_323_1.talkMaxDuration = var_326_29

					if var_326_29 + var_326_22 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_29 + var_326_22
					end
				end

				arg_323_1.text_.text = var_326_26
				arg_323_1.typewritter.percent = 0

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311080", "story_v_out_115311.awb") ~= 0 then
					local var_326_30 = manager.audio:GetVoiceLength("story_v_out_115311", "115311080", "story_v_out_115311.awb") / 1000

					if var_326_30 + var_326_22 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_30 + var_326_22
					end

					if var_326_25.prefab_name ~= "" and arg_323_1.actors_[var_326_25.prefab_name] ~= nil then
						local var_326_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_323_1.actors_[var_326_25.prefab_name].transform, "story_v_out_115311", "115311080", "story_v_out_115311.awb")

						arg_323_1:RecordAudio("115311080", var_326_31)
						arg_323_1:RecordAudio("115311080", var_326_31)
					else
						arg_323_1:AudioAction("play", "voice", "story_v_out_115311", "115311080", "story_v_out_115311.awb")
					end

					arg_323_1:RecordHistoryTalkVoice("story_v_out_115311", "115311080", "story_v_out_115311.awb")
				end

				arg_323_1:RecordContent(arg_323_1.text_.text)
			end

			local var_326_32 = math.max(var_326_23, arg_323_1.talkMaxDuration)

			if var_326_22 <= arg_323_1.time_ and arg_323_1.time_ < var_326_22 + var_326_32 then
				arg_323_1.typewritter.percent = (arg_323_1.time_ - var_326_22) / var_326_32

				arg_323_1.typewritter:SetDirty()
			end

			if arg_323_1.time_ >= var_326_22 + var_326_32 and arg_323_1.time_ < var_326_22 + var_326_32 + arg_326_0 then
				arg_323_1.typewritter.percent = 1

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(true)
			end
		end

		arg_323_1.nodeConfigList_ = {}

		arg_323_1:InitPlayNodeList()
	end,
	Play115311081 = function(arg_327_0, arg_327_1)
		arg_327_1.time_ = 0
		arg_327_1.frameCnt_ = 0
		arg_327_1.state_ = "playing"
		arg_327_1.curTalkId_ = 115311081
		arg_327_1.duration_ = 14.33

		local var_327_0 = {
			ja = 12.9,
			ko = 14.333,
			zh = 10.066,
			en = 13
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
				arg_327_0:Play115311082(arg_327_1)
			end
		end

		function arg_327_1.onSingleLineUpdate_(arg_330_0)
			local var_330_0 = 0
			local var_330_1 = 1.15

			if var_330_0 < arg_327_1.time_ and arg_327_1.time_ <= var_330_0 + arg_330_0 then
				arg_327_1.talkMaxDuration = 0
				arg_327_1.dialogCg_.alpha = 1

				arg_327_1.dialog_:SetActive(true)
				SetActive(arg_327_1.leftNameGo_, true)

				local var_330_2 = arg_327_1:FormatText(StoryNameCfg[312].name)

				arg_327_1.leftNameTxt_.text = var_330_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_327_1.leftNameTxt_.transform)

				arg_327_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_327_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_327_1:RecordName(arg_327_1.leftNameTxt_.text)
				SetActive(arg_327_1.iconTrs_.gameObject, false)
				arg_327_1.callingController_:SetSelectedState("normal")

				local var_330_3 = arg_327_1:GetWordFromCfg(115311081)
				local var_330_4 = arg_327_1:FormatText(var_330_3.content)

				arg_327_1.text_.text = var_330_4

				LuaForUtil.ClearLinePrefixSymbol(arg_327_1.text_)

				local var_330_5 = 45
				local var_330_6 = utf8.len(var_330_4)
				local var_330_7 = var_330_5 <= 0 and var_330_1 or var_330_1 * (var_330_6 / var_330_5)

				if var_330_7 > 0 and var_330_1 < var_330_7 then
					arg_327_1.talkMaxDuration = var_330_7

					if var_330_7 + var_330_0 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_7 + var_330_0
					end
				end

				arg_327_1.text_.text = var_330_4
				arg_327_1.typewritter.percent = 0

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311081", "story_v_out_115311.awb") ~= 0 then
					local var_330_8 = manager.audio:GetVoiceLength("story_v_out_115311", "115311081", "story_v_out_115311.awb") / 1000

					if var_330_8 + var_330_0 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_8 + var_330_0
					end

					if var_330_3.prefab_name ~= "" and arg_327_1.actors_[var_330_3.prefab_name] ~= nil then
						local var_330_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_327_1.actors_[var_330_3.prefab_name].transform, "story_v_out_115311", "115311081", "story_v_out_115311.awb")

						arg_327_1:RecordAudio("115311081", var_330_9)
						arg_327_1:RecordAudio("115311081", var_330_9)
					else
						arg_327_1:AudioAction("play", "voice", "story_v_out_115311", "115311081", "story_v_out_115311.awb")
					end

					arg_327_1:RecordHistoryTalkVoice("story_v_out_115311", "115311081", "story_v_out_115311.awb")
				end

				arg_327_1:RecordContent(arg_327_1.text_.text)
			end

			local var_330_10 = math.max(var_330_1, arg_327_1.talkMaxDuration)

			if var_330_0 <= arg_327_1.time_ and arg_327_1.time_ < var_330_0 + var_330_10 then
				arg_327_1.typewritter.percent = (arg_327_1.time_ - var_330_0) / var_330_10

				arg_327_1.typewritter:SetDirty()
			end

			if arg_327_1.time_ >= var_330_0 + var_330_10 and arg_327_1.time_ < var_330_0 + var_330_10 + arg_330_0 then
				arg_327_1.typewritter.percent = 1

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(true)
			end
		end

		arg_327_1.nodeConfigList_ = {}

		arg_327_1:InitPlayNodeList()
	end,
	Play115311082 = function(arg_331_0, arg_331_1)
		arg_331_1.time_ = 0
		arg_331_1.frameCnt_ = 0
		arg_331_1.state_ = "playing"
		arg_331_1.curTalkId_ = 115311082
		arg_331_1.duration_ = 5

		SetActive(arg_331_1.tipsGo_, false)

		function arg_331_1.onSingleLineFinish_()
			arg_331_1.onSingleLineUpdate_ = nil
			arg_331_1.onSingleLineFinish_ = nil
			arg_331_1.state_ = "waiting"
		end

		function arg_331_1.playNext_(arg_333_0)
			if arg_333_0 == 1 then
				arg_331_0:Play115311083(arg_331_1)
			end
		end

		function arg_331_1.onSingleLineUpdate_(arg_334_0)
			local var_334_0 = arg_331_1.actors_["10029"]
			local var_334_1 = 0

			if var_334_1 < arg_331_1.time_ and arg_331_1.time_ <= var_334_1 + arg_334_0 and not isNil(var_334_0) then
				local var_334_2 = var_334_0:GetComponent("Image")

				if var_334_2 then
					arg_331_1.var_.highlightMatValue10029 = var_334_2
				end
			end

			local var_334_3 = 0.2

			if var_334_1 <= arg_331_1.time_ and arg_331_1.time_ < var_334_1 + var_334_3 and not isNil(var_334_0) then
				local var_334_4 = (arg_331_1.time_ - var_334_1) / var_334_3

				if arg_331_1.var_.highlightMatValue10029 then
					local var_334_5 = Mathf.Lerp(1, 0.5, var_334_4)
					local var_334_6 = arg_331_1.var_.highlightMatValue10029
					local var_334_7 = var_334_6.color

					var_334_7.r = var_334_5
					var_334_7.g = var_334_5
					var_334_7.b = var_334_5
					var_334_6.color = var_334_7
				end
			end

			if arg_331_1.time_ >= var_334_1 + var_334_3 and arg_331_1.time_ < var_334_1 + var_334_3 + arg_334_0 and not isNil(var_334_0) and arg_331_1.var_.highlightMatValue10029 then
				local var_334_8 = 0.5
				local var_334_9 = arg_331_1.var_.highlightMatValue10029
				local var_334_10 = var_334_9.color

				var_334_10.r = var_334_8
				var_334_10.g = var_334_8
				var_334_10.b = var_334_8
				var_334_9.color = var_334_10
			end

			local var_334_11 = 0
			local var_334_12 = 1

			if var_334_11 < arg_331_1.time_ and arg_331_1.time_ <= var_334_11 + arg_334_0 then
				arg_331_1.talkMaxDuration = 0
				arg_331_1.dialogCg_.alpha = 1

				arg_331_1.dialog_:SetActive(true)
				SetActive(arg_331_1.leftNameGo_, false)

				arg_331_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_331_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_331_1:RecordName(arg_331_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_331_1.iconTrs_.gameObject, false)
				arg_331_1.callingController_:SetSelectedState("normal")

				local var_334_13 = arg_331_1:GetWordFromCfg(115311082)
				local var_334_14 = arg_331_1:FormatText(var_334_13.content)

				arg_331_1.text_.text = var_334_14

				LuaForUtil.ClearLinePrefixSymbol(arg_331_1.text_)

				local var_334_15 = 40
				local var_334_16 = utf8.len(var_334_14)
				local var_334_17 = var_334_15 <= 0 and var_334_12 or var_334_12 * (var_334_16 / var_334_15)

				if var_334_17 > 0 and var_334_12 < var_334_17 then
					arg_331_1.talkMaxDuration = var_334_17

					if var_334_17 + var_334_11 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_17 + var_334_11
					end
				end

				arg_331_1.text_.text = var_334_14
				arg_331_1.typewritter.percent = 0

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(false)
				arg_331_1:RecordContent(arg_331_1.text_.text)
			end

			local var_334_18 = math.max(var_334_12, arg_331_1.talkMaxDuration)

			if var_334_11 <= arg_331_1.time_ and arg_331_1.time_ < var_334_11 + var_334_18 then
				arg_331_1.typewritter.percent = (arg_331_1.time_ - var_334_11) / var_334_18

				arg_331_1.typewritter:SetDirty()
			end

			if arg_331_1.time_ >= var_334_11 + var_334_18 and arg_331_1.time_ < var_334_11 + var_334_18 + arg_334_0 then
				arg_331_1.typewritter.percent = 1

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(true)
			end
		end

		arg_331_1.nodeConfigList_ = {}

		arg_331_1:InitPlayNodeList()
	end,
	Play115311083 = function(arg_335_0, arg_335_1)
		arg_335_1.time_ = 0
		arg_335_1.frameCnt_ = 0
		arg_335_1.state_ = "playing"
		arg_335_1.curTalkId_ = 115311083
		arg_335_1.duration_ = 2.87

		local var_335_0 = {
			ja = 2.866,
			ko = 2.533,
			zh = 2.566,
			en = 2.3
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
				arg_335_0:Play115311084(arg_335_1)
			end
		end

		function arg_335_1.onSingleLineUpdate_(arg_338_0)
			local var_338_0 = arg_335_1.actors_["10029"]
			local var_338_1 = 0

			if var_338_1 < arg_335_1.time_ and arg_335_1.time_ <= var_338_1 + arg_338_0 then
				local var_338_2 = var_338_0:GetComponent("Image")

				if var_338_2 then
					arg_335_1.var_.alphaMatValue10029 = var_338_2
					arg_335_1.var_.alphaOldValue10029 = var_338_2.color.a
				end

				arg_335_1.var_.alphaOldValue10029 = 1
			end

			local var_338_3 = 0.5

			if var_338_1 <= arg_335_1.time_ and arg_335_1.time_ < var_338_1 + var_338_3 then
				local var_338_4 = (arg_335_1.time_ - var_338_1) / var_338_3
				local var_338_5 = Mathf.Lerp(arg_335_1.var_.alphaOldValue10029, 0, var_338_4)

				if arg_335_1.var_.alphaMatValue10029 then
					local var_338_6 = arg_335_1.var_.alphaMatValue10029.color

					var_338_6.a = var_338_5
					arg_335_1.var_.alphaMatValue10029.color = var_338_6
				end
			end

			if arg_335_1.time_ >= var_338_1 + var_338_3 and arg_335_1.time_ < var_338_1 + var_338_3 + arg_338_0 and arg_335_1.var_.alphaMatValue10029 then
				local var_338_7 = arg_335_1.var_.alphaMatValue10029
				local var_338_8 = var_338_7.color

				var_338_8.a = 0
				var_338_7.color = var_338_8
			end

			local var_338_9 = arg_335_1.actors_["113801_1"]
			local var_338_10 = 0

			if var_338_10 < arg_335_1.time_ and arg_335_1.time_ <= var_338_10 + arg_338_0 then
				local var_338_11 = var_338_9:GetComponent("Image")

				if var_338_11 then
					arg_335_1.var_.alphaMatValue113801_1 = var_338_11
					arg_335_1.var_.alphaOldValue113801_1 = var_338_11.color.a
				end

				arg_335_1.var_.alphaOldValue113801_1 = 1
			end

			local var_338_12 = 0.5

			if var_338_10 <= arg_335_1.time_ and arg_335_1.time_ < var_338_10 + var_338_12 then
				local var_338_13 = (arg_335_1.time_ - var_338_10) / var_338_12
				local var_338_14 = Mathf.Lerp(arg_335_1.var_.alphaOldValue113801_1, 0, var_338_13)

				if arg_335_1.var_.alphaMatValue113801_1 then
					local var_338_15 = arg_335_1.var_.alphaMatValue113801_1.color

					var_338_15.a = var_338_14
					arg_335_1.var_.alphaMatValue113801_1.color = var_338_15
				end
			end

			if arg_335_1.time_ >= var_338_10 + var_338_12 and arg_335_1.time_ < var_338_10 + var_338_12 + arg_338_0 and arg_335_1.var_.alphaMatValue113801_1 then
				local var_338_16 = arg_335_1.var_.alphaMatValue113801_1
				local var_338_17 = var_338_16.color

				var_338_17.a = 0
				var_338_16.color = var_338_17
			end

			local var_338_18 = 0
			local var_338_19 = 0.225

			if var_338_18 < arg_335_1.time_ and arg_335_1.time_ <= var_338_18 + arg_338_0 then
				arg_335_1.talkMaxDuration = 0
				arg_335_1.dialogCg_.alpha = 1

				arg_335_1.dialog_:SetActive(true)
				SetActive(arg_335_1.leftNameGo_, true)

				local var_338_20 = arg_335_1:FormatText(StoryNameCfg[316].name)

				arg_335_1.leftNameTxt_.text = var_338_20

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_335_1.leftNameTxt_.transform)

				arg_335_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_335_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_335_1:RecordName(arg_335_1.leftNameTxt_.text)
				SetActive(arg_335_1.iconTrs_.gameObject, true)
				arg_335_1.iconController_:SetSelectedState("hero")

				arg_335_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_335_1.callingController_:SetSelectedState("normal")

				arg_335_1.keyicon_.color = Color.New(1, 1, 1)
				arg_335_1.icon_.color = Color.New(1, 1, 1)

				local var_338_21 = arg_335_1:GetWordFromCfg(115311083)
				local var_338_22 = arg_335_1:FormatText(var_338_21.content)

				arg_335_1.text_.text = var_338_22

				LuaForUtil.ClearLinePrefixSymbol(arg_335_1.text_)

				local var_338_23 = 9
				local var_338_24 = utf8.len(var_338_22)
				local var_338_25 = var_338_23 <= 0 and var_338_19 or var_338_19 * (var_338_24 / var_338_23)

				if var_338_25 > 0 and var_338_19 < var_338_25 then
					arg_335_1.talkMaxDuration = var_338_25

					if var_338_25 + var_338_18 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_25 + var_338_18
					end
				end

				arg_335_1.text_.text = var_338_22
				arg_335_1.typewritter.percent = 0

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311083", "story_v_out_115311.awb") ~= 0 then
					local var_338_26 = manager.audio:GetVoiceLength("story_v_out_115311", "115311083", "story_v_out_115311.awb") / 1000

					if var_338_26 + var_338_18 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_26 + var_338_18
					end

					if var_338_21.prefab_name ~= "" and arg_335_1.actors_[var_338_21.prefab_name] ~= nil then
						local var_338_27 = LuaForUtil.PlayVoiceWithCriLipsync(arg_335_1.actors_[var_338_21.prefab_name].transform, "story_v_out_115311", "115311083", "story_v_out_115311.awb")

						arg_335_1:RecordAudio("115311083", var_338_27)
						arg_335_1:RecordAudio("115311083", var_338_27)
					else
						arg_335_1:AudioAction("play", "voice", "story_v_out_115311", "115311083", "story_v_out_115311.awb")
					end

					arg_335_1:RecordHistoryTalkVoice("story_v_out_115311", "115311083", "story_v_out_115311.awb")
				end

				arg_335_1:RecordContent(arg_335_1.text_.text)
			end

			local var_338_28 = math.max(var_338_19, arg_335_1.talkMaxDuration)

			if var_338_18 <= arg_335_1.time_ and arg_335_1.time_ < var_338_18 + var_338_28 then
				arg_335_1.typewritter.percent = (arg_335_1.time_ - var_338_18) / var_338_28

				arg_335_1.typewritter:SetDirty()
			end

			if arg_335_1.time_ >= var_338_18 + var_338_28 and arg_335_1.time_ < var_338_18 + var_338_28 + arg_338_0 then
				arg_335_1.typewritter.percent = 1

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(true)
			end
		end

		arg_335_1.nodeConfigList_ = {}

		arg_335_1:InitPlayNodeList()
	end,
	Play115311084 = function(arg_339_0, arg_339_1)
		arg_339_1.time_ = 0
		arg_339_1.frameCnt_ = 0
		arg_339_1.state_ = "playing"
		arg_339_1.curTalkId_ = 115311084
		arg_339_1.duration_ = 6.1

		local var_339_0 = {
			ja = 6.1,
			ko = 5.366,
			zh = 4,
			en = 5.366
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
				arg_339_0:Play115311085(arg_339_1)
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

				local var_342_2 = arg_339_1:FormatText(StoryNameCfg[104].name)

				arg_339_1.leftNameTxt_.text = var_342_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_339_1.leftNameTxt_.transform)

				arg_339_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_339_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_339_1:RecordName(arg_339_1.leftNameTxt_.text)
				SetActive(arg_339_1.iconTrs_.gameObject, true)
				arg_339_1.iconController_:SetSelectedState("hero")

				arg_339_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_woundedd")

				arg_339_1.callingController_:SetSelectedState("normal")

				arg_339_1.keyicon_.color = Color.New(1, 1, 1)
				arg_339_1.icon_.color = Color.New(1, 1, 1)

				local var_342_3 = arg_339_1:GetWordFromCfg(115311084)
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

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311084", "story_v_out_115311.awb") ~= 0 then
					local var_342_8 = manager.audio:GetVoiceLength("story_v_out_115311", "115311084", "story_v_out_115311.awb") / 1000

					if var_342_8 + var_342_0 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_8 + var_342_0
					end

					if var_342_3.prefab_name ~= "" and arg_339_1.actors_[var_342_3.prefab_name] ~= nil then
						local var_342_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_339_1.actors_[var_342_3.prefab_name].transform, "story_v_out_115311", "115311084", "story_v_out_115311.awb")

						arg_339_1:RecordAudio("115311084", var_342_9)
						arg_339_1:RecordAudio("115311084", var_342_9)
					else
						arg_339_1:AudioAction("play", "voice", "story_v_out_115311", "115311084", "story_v_out_115311.awb")
					end

					arg_339_1:RecordHistoryTalkVoice("story_v_out_115311", "115311084", "story_v_out_115311.awb")
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
	Play115311085 = function(arg_343_0, arg_343_1)
		arg_343_1.time_ = 0
		arg_343_1.frameCnt_ = 0
		arg_343_1.state_ = "playing"
		arg_343_1.curTalkId_ = 115311085
		arg_343_1.duration_ = 5

		SetActive(arg_343_1.tipsGo_, false)

		function arg_343_1.onSingleLineFinish_()
			arg_343_1.onSingleLineUpdate_ = nil
			arg_343_1.onSingleLineFinish_ = nil
			arg_343_1.state_ = "waiting"
		end

		function arg_343_1.playNext_(arg_345_0)
			if arg_345_0 == 1 then
				arg_343_0:Play115311086(arg_343_1)
			end
		end

		function arg_343_1.onSingleLineUpdate_(arg_346_0)
			local var_346_0 = 0
			local var_346_1 = 1.5

			if var_346_0 < arg_343_1.time_ and arg_343_1.time_ <= var_346_0 + arg_346_0 then
				arg_343_1.talkMaxDuration = 0
				arg_343_1.dialogCg_.alpha = 1

				arg_343_1.dialog_:SetActive(true)
				SetActive(arg_343_1.leftNameGo_, false)

				arg_343_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_343_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_343_1:RecordName(arg_343_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_343_1.iconTrs_.gameObject, false)
				arg_343_1.callingController_:SetSelectedState("normal")

				local var_346_2 = arg_343_1:GetWordFromCfg(115311085)
				local var_346_3 = arg_343_1:FormatText(var_346_2.content)

				arg_343_1.text_.text = var_346_3

				LuaForUtil.ClearLinePrefixSymbol(arg_343_1.text_)

				local var_346_4 = 60
				local var_346_5 = utf8.len(var_346_3)
				local var_346_6 = var_346_4 <= 0 and var_346_1 or var_346_1 * (var_346_5 / var_346_4)

				if var_346_6 > 0 and var_346_1 < var_346_6 then
					arg_343_1.talkMaxDuration = var_346_6

					if var_346_6 + var_346_0 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_6 + var_346_0
					end
				end

				arg_343_1.text_.text = var_346_3
				arg_343_1.typewritter.percent = 0

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(false)
				arg_343_1:RecordContent(arg_343_1.text_.text)
			end

			local var_346_7 = math.max(var_346_1, arg_343_1.talkMaxDuration)

			if var_346_0 <= arg_343_1.time_ and arg_343_1.time_ < var_346_0 + var_346_7 then
				arg_343_1.typewritter.percent = (arg_343_1.time_ - var_346_0) / var_346_7

				arg_343_1.typewritter:SetDirty()
			end

			if arg_343_1.time_ >= var_346_0 + var_346_7 and arg_343_1.time_ < var_346_0 + var_346_7 + arg_346_0 then
				arg_343_1.typewritter.percent = 1

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(true)
			end
		end

		arg_343_1.nodeConfigList_ = {}

		arg_343_1:InitPlayNodeList()
	end,
	Play115311086 = function(arg_347_0, arg_347_1)
		arg_347_1.time_ = 0
		arg_347_1.frameCnt_ = 0
		arg_347_1.state_ = "playing"
		arg_347_1.curTalkId_ = 115311086
		arg_347_1.duration_ = 5

		SetActive(arg_347_1.tipsGo_, false)

		function arg_347_1.onSingleLineFinish_()
			arg_347_1.onSingleLineUpdate_ = nil
			arg_347_1.onSingleLineFinish_ = nil
			arg_347_1.state_ = "waiting"
		end

		function arg_347_1.playNext_(arg_349_0)
			if arg_349_0 == 1 then
				arg_347_0:Play115311087(arg_347_1)
			end
		end

		function arg_347_1.onSingleLineUpdate_(arg_350_0)
			local var_350_0 = 0
			local var_350_1 = 1.15

			if var_350_0 < arg_347_1.time_ and arg_347_1.time_ <= var_350_0 + arg_350_0 then
				arg_347_1.talkMaxDuration = 0
				arg_347_1.dialogCg_.alpha = 1

				arg_347_1.dialog_:SetActive(true)
				SetActive(arg_347_1.leftNameGo_, false)

				arg_347_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_347_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_347_1:RecordName(arg_347_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_347_1.iconTrs_.gameObject, false)
				arg_347_1.callingController_:SetSelectedState("normal")

				local var_350_2 = arg_347_1:GetWordFromCfg(115311086)
				local var_350_3 = arg_347_1:FormatText(var_350_2.content)

				arg_347_1.text_.text = var_350_3

				LuaForUtil.ClearLinePrefixSymbol(arg_347_1.text_)

				local var_350_4 = 46
				local var_350_5 = utf8.len(var_350_3)
				local var_350_6 = var_350_4 <= 0 and var_350_1 or var_350_1 * (var_350_5 / var_350_4)

				if var_350_6 > 0 and var_350_1 < var_350_6 then
					arg_347_1.talkMaxDuration = var_350_6

					if var_350_6 + var_350_0 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_6 + var_350_0
					end
				end

				arg_347_1.text_.text = var_350_3
				arg_347_1.typewritter.percent = 0

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(false)
				arg_347_1:RecordContent(arg_347_1.text_.text)
			end

			local var_350_7 = math.max(var_350_1, arg_347_1.talkMaxDuration)

			if var_350_0 <= arg_347_1.time_ and arg_347_1.time_ < var_350_0 + var_350_7 then
				arg_347_1.typewritter.percent = (arg_347_1.time_ - var_350_0) / var_350_7

				arg_347_1.typewritter:SetDirty()
			end

			if arg_347_1.time_ >= var_350_0 + var_350_7 and arg_347_1.time_ < var_350_0 + var_350_7 + arg_350_0 then
				arg_347_1.typewritter.percent = 1

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(true)
			end
		end

		arg_347_1.nodeConfigList_ = {}

		arg_347_1:InitPlayNodeList()
	end,
	Play115311087 = function(arg_351_0, arg_351_1)
		arg_351_1.time_ = 0
		arg_351_1.frameCnt_ = 0
		arg_351_1.state_ = "playing"
		arg_351_1.curTalkId_ = 115311087
		arg_351_1.duration_ = 7.77

		local var_351_0 = {
			ja = 6.7,
			ko = 7.766,
			zh = 7.166,
			en = 5.366
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
				arg_351_0:Play115311088(arg_351_1)
			end
		end

		function arg_351_1.onSingleLineUpdate_(arg_354_0)
			local var_354_0 = arg_351_1.actors_["10029"]
			local var_354_1 = 0

			if var_354_1 < arg_351_1.time_ and arg_351_1.time_ <= var_354_1 + arg_354_0 then
				local var_354_2 = var_354_0:GetComponent("Image")

				if var_354_2 then
					arg_351_1.var_.alphaMatValue10029 = var_354_2
					arg_351_1.var_.alphaOldValue10029 = var_354_2.color.a
				end

				arg_351_1.var_.alphaOldValue10029 = 0
			end

			local var_354_3 = 0.5

			if var_354_1 <= arg_351_1.time_ and arg_351_1.time_ < var_354_1 + var_354_3 then
				local var_354_4 = (arg_351_1.time_ - var_354_1) / var_354_3
				local var_354_5 = Mathf.Lerp(arg_351_1.var_.alphaOldValue10029, 1, var_354_4)

				if arg_351_1.var_.alphaMatValue10029 then
					local var_354_6 = arg_351_1.var_.alphaMatValue10029.color

					var_354_6.a = var_354_5
					arg_351_1.var_.alphaMatValue10029.color = var_354_6
				end
			end

			if arg_351_1.time_ >= var_354_1 + var_354_3 and arg_351_1.time_ < var_354_1 + var_354_3 + arg_354_0 and arg_351_1.var_.alphaMatValue10029 then
				local var_354_7 = arg_351_1.var_.alphaMatValue10029
				local var_354_8 = var_354_7.color

				var_354_8.a = 1
				var_354_7.color = var_354_8
			end

			local var_354_9 = arg_351_1.actors_["113801_1"]
			local var_354_10 = 0

			if var_354_10 < arg_351_1.time_ and arg_351_1.time_ <= var_354_10 + arg_354_0 then
				local var_354_11 = var_354_9:GetComponent("Image")

				if var_354_11 then
					arg_351_1.var_.alphaMatValue113801_1 = var_354_11
					arg_351_1.var_.alphaOldValue113801_1 = var_354_11.color.a
				end

				arg_351_1.var_.alphaOldValue113801_1 = 0
			end

			local var_354_12 = 0.5

			if var_354_10 <= arg_351_1.time_ and arg_351_1.time_ < var_354_10 + var_354_12 then
				local var_354_13 = (arg_351_1.time_ - var_354_10) / var_354_12
				local var_354_14 = Mathf.Lerp(arg_351_1.var_.alphaOldValue113801_1, 1, var_354_13)

				if arg_351_1.var_.alphaMatValue113801_1 then
					local var_354_15 = arg_351_1.var_.alphaMatValue113801_1.color

					var_354_15.a = var_354_14
					arg_351_1.var_.alphaMatValue113801_1.color = var_354_15
				end
			end

			if arg_351_1.time_ >= var_354_10 + var_354_12 and arg_351_1.time_ < var_354_10 + var_354_12 + arg_354_0 and arg_351_1.var_.alphaMatValue113801_1 then
				local var_354_16 = arg_351_1.var_.alphaMatValue113801_1
				local var_354_17 = var_354_16.color

				var_354_17.a = 1
				var_354_16.color = var_354_17
			end

			local var_354_18 = arg_351_1.actors_["113801_1"]
			local var_354_19 = 0

			if var_354_19 < arg_351_1.time_ and arg_351_1.time_ <= var_354_19 + arg_354_0 and not isNil(var_354_18) then
				local var_354_20 = var_354_18:GetComponent("Image")

				if var_354_20 then
					arg_351_1.var_.highlightMatValue113801_1 = var_354_20
				end
			end

			local var_354_21 = 0.2

			if var_354_19 <= arg_351_1.time_ and arg_351_1.time_ < var_354_19 + var_354_21 and not isNil(var_354_18) then
				local var_354_22 = (arg_351_1.time_ - var_354_19) / var_354_21

				if arg_351_1.var_.highlightMatValue113801_1 then
					local var_354_23 = Mathf.Lerp(0.5, 1, var_354_22)
					local var_354_24 = arg_351_1.var_.highlightMatValue113801_1
					local var_354_25 = var_354_24.color

					var_354_25.r = var_354_23
					var_354_25.g = var_354_23
					var_354_25.b = var_354_23
					var_354_24.color = var_354_25
				end
			end

			if arg_351_1.time_ >= var_354_19 + var_354_21 and arg_351_1.time_ < var_354_19 + var_354_21 + arg_354_0 and not isNil(var_354_18) and arg_351_1.var_.highlightMatValue113801_1 then
				local var_354_26 = 1

				var_354_18.transform:SetSiblingIndex(1)

				local var_354_27 = arg_351_1.var_.highlightMatValue113801_1
				local var_354_28 = var_354_27.color

				var_354_28.r = var_354_26
				var_354_28.g = var_354_26
				var_354_28.b = var_354_26
				var_354_27.color = var_354_28
			end

			local var_354_29 = 0
			local var_354_30 = 0.575

			if var_354_29 < arg_351_1.time_ and arg_351_1.time_ <= var_354_29 + arg_354_0 then
				arg_351_1.talkMaxDuration = 0
				arg_351_1.dialogCg_.alpha = 1

				arg_351_1.dialog_:SetActive(true)
				SetActive(arg_351_1.leftNameGo_, true)

				local var_354_31 = arg_351_1:FormatText(StoryNameCfg[94].name)

				arg_351_1.leftNameTxt_.text = var_354_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_351_1.leftNameTxt_.transform)

				arg_351_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_351_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_351_1:RecordName(arg_351_1.leftNameTxt_.text)
				SetActive(arg_351_1.iconTrs_.gameObject, false)
				arg_351_1.callingController_:SetSelectedState("normal")

				local var_354_32 = arg_351_1:GetWordFromCfg(115311087)
				local var_354_33 = arg_351_1:FormatText(var_354_32.content)

				arg_351_1.text_.text = var_354_33

				LuaForUtil.ClearLinePrefixSymbol(arg_351_1.text_)

				local var_354_34 = 23
				local var_354_35 = utf8.len(var_354_33)
				local var_354_36 = var_354_34 <= 0 and var_354_30 or var_354_30 * (var_354_35 / var_354_34)

				if var_354_36 > 0 and var_354_30 < var_354_36 then
					arg_351_1.talkMaxDuration = var_354_36

					if var_354_36 + var_354_29 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_36 + var_354_29
					end
				end

				arg_351_1.text_.text = var_354_33
				arg_351_1.typewritter.percent = 0

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311087", "story_v_out_115311.awb") ~= 0 then
					local var_354_37 = manager.audio:GetVoiceLength("story_v_out_115311", "115311087", "story_v_out_115311.awb") / 1000

					if var_354_37 + var_354_29 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_37 + var_354_29
					end

					if var_354_32.prefab_name ~= "" and arg_351_1.actors_[var_354_32.prefab_name] ~= nil then
						local var_354_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_351_1.actors_[var_354_32.prefab_name].transform, "story_v_out_115311", "115311087", "story_v_out_115311.awb")

						arg_351_1:RecordAudio("115311087", var_354_38)
						arg_351_1:RecordAudio("115311087", var_354_38)
					else
						arg_351_1:AudioAction("play", "voice", "story_v_out_115311", "115311087", "story_v_out_115311.awb")
					end

					arg_351_1:RecordHistoryTalkVoice("story_v_out_115311", "115311087", "story_v_out_115311.awb")
				end

				arg_351_1:RecordContent(arg_351_1.text_.text)
			end

			local var_354_39 = math.max(var_354_30, arg_351_1.talkMaxDuration)

			if var_354_29 <= arg_351_1.time_ and arg_351_1.time_ < var_354_29 + var_354_39 then
				arg_351_1.typewritter.percent = (arg_351_1.time_ - var_354_29) / var_354_39

				arg_351_1.typewritter:SetDirty()
			end

			if arg_351_1.time_ >= var_354_29 + var_354_39 and arg_351_1.time_ < var_354_29 + var_354_39 + arg_354_0 then
				arg_351_1.typewritter.percent = 1

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(true)
			end
		end

		arg_351_1.nodeConfigList_ = {}

		arg_351_1:InitPlayNodeList()
	end,
	Play115311088 = function(arg_355_0, arg_355_1)
		arg_355_1.time_ = 0
		arg_355_1.frameCnt_ = 0
		arg_355_1.state_ = "playing"
		arg_355_1.curTalkId_ = 115311088
		arg_355_1.duration_ = 20.53

		local var_355_0 = {
			ja = 20.533,
			ko = 12.133,
			zh = 14.733,
			en = 16.2
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
				arg_355_0:Play115311089(arg_355_1)
			end
		end

		function arg_355_1.onSingleLineUpdate_(arg_358_0)
			local var_358_0 = 0
			local var_358_1 = 1.2

			if var_358_0 < arg_355_1.time_ and arg_355_1.time_ <= var_358_0 + arg_358_0 then
				arg_355_1.talkMaxDuration = 0
				arg_355_1.dialogCg_.alpha = 1

				arg_355_1.dialog_:SetActive(true)
				SetActive(arg_355_1.leftNameGo_, true)

				local var_358_2 = arg_355_1:FormatText(StoryNameCfg[94].name)

				arg_355_1.leftNameTxt_.text = var_358_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_355_1.leftNameTxt_.transform)

				arg_355_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_355_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_355_1:RecordName(arg_355_1.leftNameTxt_.text)
				SetActive(arg_355_1.iconTrs_.gameObject, false)
				arg_355_1.callingController_:SetSelectedState("normal")

				local var_358_3 = arg_355_1:GetWordFromCfg(115311088)
				local var_358_4 = arg_355_1:FormatText(var_358_3.content)

				arg_355_1.text_.text = var_358_4

				LuaForUtil.ClearLinePrefixSymbol(arg_355_1.text_)

				local var_358_5 = 48
				local var_358_6 = utf8.len(var_358_4)
				local var_358_7 = var_358_5 <= 0 and var_358_1 or var_358_1 * (var_358_6 / var_358_5)

				if var_358_7 > 0 and var_358_1 < var_358_7 then
					arg_355_1.talkMaxDuration = var_358_7

					if var_358_7 + var_358_0 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_7 + var_358_0
					end
				end

				arg_355_1.text_.text = var_358_4
				arg_355_1.typewritter.percent = 0

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311088", "story_v_out_115311.awb") ~= 0 then
					local var_358_8 = manager.audio:GetVoiceLength("story_v_out_115311", "115311088", "story_v_out_115311.awb") / 1000

					if var_358_8 + var_358_0 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_8 + var_358_0
					end

					if var_358_3.prefab_name ~= "" and arg_355_1.actors_[var_358_3.prefab_name] ~= nil then
						local var_358_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_355_1.actors_[var_358_3.prefab_name].transform, "story_v_out_115311", "115311088", "story_v_out_115311.awb")

						arg_355_1:RecordAudio("115311088", var_358_9)
						arg_355_1:RecordAudio("115311088", var_358_9)
					else
						arg_355_1:AudioAction("play", "voice", "story_v_out_115311", "115311088", "story_v_out_115311.awb")
					end

					arg_355_1:RecordHistoryTalkVoice("story_v_out_115311", "115311088", "story_v_out_115311.awb")
				end

				arg_355_1:RecordContent(arg_355_1.text_.text)
			end

			local var_358_10 = math.max(var_358_1, arg_355_1.talkMaxDuration)

			if var_358_0 <= arg_355_1.time_ and arg_355_1.time_ < var_358_0 + var_358_10 then
				arg_355_1.typewritter.percent = (arg_355_1.time_ - var_358_0) / var_358_10

				arg_355_1.typewritter:SetDirty()
			end

			if arg_355_1.time_ >= var_358_0 + var_358_10 and arg_355_1.time_ < var_358_0 + var_358_10 + arg_358_0 then
				arg_355_1.typewritter.percent = 1

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(true)
			end
		end

		arg_355_1.nodeConfigList_ = {}

		arg_355_1:InitPlayNodeList()
	end,
	Play115311089 = function(arg_359_0, arg_359_1)
		arg_359_1.time_ = 0
		arg_359_1.frameCnt_ = 0
		arg_359_1.state_ = "playing"
		arg_359_1.curTalkId_ = 115311089
		arg_359_1.duration_ = 5

		SetActive(arg_359_1.tipsGo_, false)

		function arg_359_1.onSingleLineFinish_()
			arg_359_1.onSingleLineUpdate_ = nil
			arg_359_1.onSingleLineFinish_ = nil
			arg_359_1.state_ = "waiting"
		end

		function arg_359_1.playNext_(arg_361_0)
			if arg_361_0 == 1 then
				arg_359_0:Play115311090(arg_359_1)
			end
		end

		function arg_359_1.onSingleLineUpdate_(arg_362_0)
			local var_362_0 = arg_359_1.actors_["113801_1"]
			local var_362_1 = 0

			if var_362_1 < arg_359_1.time_ and arg_359_1.time_ <= var_362_1 + arg_362_0 and not isNil(var_362_0) then
				local var_362_2 = var_362_0:GetComponent("Image")

				if var_362_2 then
					arg_359_1.var_.highlightMatValue113801_1 = var_362_2
				end
			end

			local var_362_3 = 0.2

			if var_362_1 <= arg_359_1.time_ and arg_359_1.time_ < var_362_1 + var_362_3 and not isNil(var_362_0) then
				local var_362_4 = (arg_359_1.time_ - var_362_1) / var_362_3

				if arg_359_1.var_.highlightMatValue113801_1 then
					local var_362_5 = Mathf.Lerp(1, 0.5, var_362_4)
					local var_362_6 = arg_359_1.var_.highlightMatValue113801_1
					local var_362_7 = var_362_6.color

					var_362_7.r = var_362_5
					var_362_7.g = var_362_5
					var_362_7.b = var_362_5
					var_362_6.color = var_362_7
				end
			end

			if arg_359_1.time_ >= var_362_1 + var_362_3 and arg_359_1.time_ < var_362_1 + var_362_3 + arg_362_0 and not isNil(var_362_0) and arg_359_1.var_.highlightMatValue113801_1 then
				local var_362_8 = 0.5
				local var_362_9 = arg_359_1.var_.highlightMatValue113801_1
				local var_362_10 = var_362_9.color

				var_362_10.r = var_362_8
				var_362_10.g = var_362_8
				var_362_10.b = var_362_8
				var_362_9.color = var_362_10
			end

			local var_362_11 = 0
			local var_362_12 = 1.325

			if var_362_11 < arg_359_1.time_ and arg_359_1.time_ <= var_362_11 + arg_362_0 then
				arg_359_1.talkMaxDuration = 0
				arg_359_1.dialogCg_.alpha = 1

				arg_359_1.dialog_:SetActive(true)
				SetActive(arg_359_1.leftNameGo_, false)

				arg_359_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_359_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_359_1:RecordName(arg_359_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_359_1.iconTrs_.gameObject, false)
				arg_359_1.callingController_:SetSelectedState("normal")

				local var_362_13 = arg_359_1:GetWordFromCfg(115311089)
				local var_362_14 = arg_359_1:FormatText(var_362_13.content)

				arg_359_1.text_.text = var_362_14

				LuaForUtil.ClearLinePrefixSymbol(arg_359_1.text_)

				local var_362_15 = 53
				local var_362_16 = utf8.len(var_362_14)
				local var_362_17 = var_362_15 <= 0 and var_362_12 or var_362_12 * (var_362_16 / var_362_15)

				if var_362_17 > 0 and var_362_12 < var_362_17 then
					arg_359_1.talkMaxDuration = var_362_17

					if var_362_17 + var_362_11 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_17 + var_362_11
					end
				end

				arg_359_1.text_.text = var_362_14
				arg_359_1.typewritter.percent = 0

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(false)
				arg_359_1:RecordContent(arg_359_1.text_.text)
			end

			local var_362_18 = math.max(var_362_12, arg_359_1.talkMaxDuration)

			if var_362_11 <= arg_359_1.time_ and arg_359_1.time_ < var_362_11 + var_362_18 then
				arg_359_1.typewritter.percent = (arg_359_1.time_ - var_362_11) / var_362_18

				arg_359_1.typewritter:SetDirty()
			end

			if arg_359_1.time_ >= var_362_11 + var_362_18 and arg_359_1.time_ < var_362_11 + var_362_18 + arg_362_0 then
				arg_359_1.typewritter.percent = 1

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(true)
			end
		end

		arg_359_1.nodeConfigList_ = {}

		arg_359_1:InitPlayNodeList()
	end,
	Play115311090 = function(arg_363_0, arg_363_1)
		arg_363_1.time_ = 0
		arg_363_1.frameCnt_ = 0
		arg_363_1.state_ = "playing"
		arg_363_1.curTalkId_ = 115311090
		arg_363_1.duration_ = 3.1

		local var_363_0 = {
			ja = 1.266,
			ko = 1.666,
			zh = 1.8,
			en = 3.1
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
				arg_363_0:Play115311091(arg_363_1)
			end
		end

		function arg_363_1.onSingleLineUpdate_(arg_366_0)
			local var_366_0 = arg_363_1.actors_["10029"]
			local var_366_1 = 0

			if var_366_1 < arg_363_1.time_ and arg_363_1.time_ <= var_366_1 + arg_366_0 and not isNil(var_366_0) then
				local var_366_2 = var_366_0:GetComponent("Image")

				if var_366_2 then
					arg_363_1.var_.highlightMatValue10029 = var_366_2
				end
			end

			local var_366_3 = 0.2

			if var_366_1 <= arg_363_1.time_ and arg_363_1.time_ < var_366_1 + var_366_3 and not isNil(var_366_0) then
				local var_366_4 = (arg_363_1.time_ - var_366_1) / var_366_3

				if arg_363_1.var_.highlightMatValue10029 then
					local var_366_5 = Mathf.Lerp(0.5, 1, var_366_4)
					local var_366_6 = arg_363_1.var_.highlightMatValue10029
					local var_366_7 = var_366_6.color

					var_366_7.r = var_366_5
					var_366_7.g = var_366_5
					var_366_7.b = var_366_5
					var_366_6.color = var_366_7
				end
			end

			if arg_363_1.time_ >= var_366_1 + var_366_3 and arg_363_1.time_ < var_366_1 + var_366_3 + arg_366_0 and not isNil(var_366_0) and arg_363_1.var_.highlightMatValue10029 then
				local var_366_8 = 1

				var_366_0.transform:SetSiblingIndex(1)

				local var_366_9 = arg_363_1.var_.highlightMatValue10029
				local var_366_10 = var_366_9.color

				var_366_10.r = var_366_8
				var_366_10.g = var_366_8
				var_366_10.b = var_366_8
				var_366_9.color = var_366_10
			end

			local var_366_11 = 0
			local var_366_12 = 0.1

			if var_366_11 < arg_363_1.time_ and arg_363_1.time_ <= var_366_11 + arg_366_0 then
				arg_363_1.talkMaxDuration = 0
				arg_363_1.dialogCg_.alpha = 1

				arg_363_1.dialog_:SetActive(true)
				SetActive(arg_363_1.leftNameGo_, true)

				local var_366_13 = arg_363_1:FormatText(StoryNameCfg[312].name)

				arg_363_1.leftNameTxt_.text = var_366_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_363_1.leftNameTxt_.transform)

				arg_363_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_363_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_363_1:RecordName(arg_363_1.leftNameTxt_.text)
				SetActive(arg_363_1.iconTrs_.gameObject, false)
				arg_363_1.callingController_:SetSelectedState("normal")

				local var_366_14 = arg_363_1:GetWordFromCfg(115311090)
				local var_366_15 = arg_363_1:FormatText(var_366_14.content)

				arg_363_1.text_.text = var_366_15

				LuaForUtil.ClearLinePrefixSymbol(arg_363_1.text_)

				local var_366_16 = 4
				local var_366_17 = utf8.len(var_366_15)
				local var_366_18 = var_366_16 <= 0 and var_366_12 or var_366_12 * (var_366_17 / var_366_16)

				if var_366_18 > 0 and var_366_12 < var_366_18 then
					arg_363_1.talkMaxDuration = var_366_18

					if var_366_18 + var_366_11 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_18 + var_366_11
					end
				end

				arg_363_1.text_.text = var_366_15
				arg_363_1.typewritter.percent = 0

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311090", "story_v_out_115311.awb") ~= 0 then
					local var_366_19 = manager.audio:GetVoiceLength("story_v_out_115311", "115311090", "story_v_out_115311.awb") / 1000

					if var_366_19 + var_366_11 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_19 + var_366_11
					end

					if var_366_14.prefab_name ~= "" and arg_363_1.actors_[var_366_14.prefab_name] ~= nil then
						local var_366_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_363_1.actors_[var_366_14.prefab_name].transform, "story_v_out_115311", "115311090", "story_v_out_115311.awb")

						arg_363_1:RecordAudio("115311090", var_366_20)
						arg_363_1:RecordAudio("115311090", var_366_20)
					else
						arg_363_1:AudioAction("play", "voice", "story_v_out_115311", "115311090", "story_v_out_115311.awb")
					end

					arg_363_1:RecordHistoryTalkVoice("story_v_out_115311", "115311090", "story_v_out_115311.awb")
				end

				arg_363_1:RecordContent(arg_363_1.text_.text)
			end

			local var_366_21 = math.max(var_366_12, arg_363_1.talkMaxDuration)

			if var_366_11 <= arg_363_1.time_ and arg_363_1.time_ < var_366_11 + var_366_21 then
				arg_363_1.typewritter.percent = (arg_363_1.time_ - var_366_11) / var_366_21

				arg_363_1.typewritter:SetDirty()
			end

			if arg_363_1.time_ >= var_366_11 + var_366_21 and arg_363_1.time_ < var_366_11 + var_366_21 + arg_366_0 then
				arg_363_1.typewritter.percent = 1

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(true)
			end
		end

		arg_363_1.nodeConfigList_ = {}

		arg_363_1:InitPlayNodeList()
	end,
	Play115311091 = function(arg_367_0, arg_367_1)
		arg_367_1.time_ = 0
		arg_367_1.frameCnt_ = 0
		arg_367_1.state_ = "playing"
		arg_367_1.curTalkId_ = 115311091
		arg_367_1.duration_ = 5.67

		local var_367_0 = {
			ja = 5,
			ko = 4.733,
			zh = 3.133,
			en = 5.666
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
				arg_367_0:Play115311092(arg_367_1)
			end
		end

		function arg_367_1.onSingleLineUpdate_(arg_370_0)
			local var_370_0 = arg_367_1.actors_["10029"]
			local var_370_1 = 0

			if var_370_1 < arg_367_1.time_ and arg_367_1.time_ <= var_370_1 + arg_370_0 and not isNil(var_370_0) then
				local var_370_2 = var_370_0:GetComponent("Image")

				if var_370_2 then
					arg_367_1.var_.highlightMatValue10029 = var_370_2
				end
			end

			local var_370_3 = 0.2

			if var_370_1 <= arg_367_1.time_ and arg_367_1.time_ < var_370_1 + var_370_3 and not isNil(var_370_0) then
				local var_370_4 = (arg_367_1.time_ - var_370_1) / var_370_3

				if arg_367_1.var_.highlightMatValue10029 then
					local var_370_5 = Mathf.Lerp(1, 0.5, var_370_4)
					local var_370_6 = arg_367_1.var_.highlightMatValue10029
					local var_370_7 = var_370_6.color

					var_370_7.r = var_370_5
					var_370_7.g = var_370_5
					var_370_7.b = var_370_5
					var_370_6.color = var_370_7
				end
			end

			if arg_367_1.time_ >= var_370_1 + var_370_3 and arg_367_1.time_ < var_370_1 + var_370_3 + arg_370_0 and not isNil(var_370_0) and arg_367_1.var_.highlightMatValue10029 then
				local var_370_8 = 0.5
				local var_370_9 = arg_367_1.var_.highlightMatValue10029
				local var_370_10 = var_370_9.color

				var_370_10.r = var_370_8
				var_370_10.g = var_370_8
				var_370_10.b = var_370_8
				var_370_9.color = var_370_10
			end

			local var_370_11 = 0
			local var_370_12 = 0.325

			if var_370_11 < arg_367_1.time_ and arg_367_1.time_ <= var_370_11 + arg_370_0 then
				arg_367_1.talkMaxDuration = 0
				arg_367_1.dialogCg_.alpha = 1

				arg_367_1.dialog_:SetActive(true)
				SetActive(arg_367_1.leftNameGo_, true)

				local var_370_13 = arg_367_1:FormatText(StoryNameCfg[104].name)

				arg_367_1.leftNameTxt_.text = var_370_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_367_1.leftNameTxt_.transform)

				arg_367_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_367_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_367_1:RecordName(arg_367_1.leftNameTxt_.text)
				SetActive(arg_367_1.iconTrs_.gameObject, true)
				arg_367_1.iconController_:SetSelectedState("hero")

				arg_367_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_woundedd")

				arg_367_1.callingController_:SetSelectedState("normal")

				arg_367_1.keyicon_.color = Color.New(1, 1, 1)
				arg_367_1.icon_.color = Color.New(1, 1, 1)

				local var_370_14 = arg_367_1:GetWordFromCfg(115311091)
				local var_370_15 = arg_367_1:FormatText(var_370_14.content)

				arg_367_1.text_.text = var_370_15

				LuaForUtil.ClearLinePrefixSymbol(arg_367_1.text_)

				local var_370_16 = 13
				local var_370_17 = utf8.len(var_370_15)
				local var_370_18 = var_370_16 <= 0 and var_370_12 or var_370_12 * (var_370_17 / var_370_16)

				if var_370_18 > 0 and var_370_12 < var_370_18 then
					arg_367_1.talkMaxDuration = var_370_18

					if var_370_18 + var_370_11 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_18 + var_370_11
					end
				end

				arg_367_1.text_.text = var_370_15
				arg_367_1.typewritter.percent = 0

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311091", "story_v_out_115311.awb") ~= 0 then
					local var_370_19 = manager.audio:GetVoiceLength("story_v_out_115311", "115311091", "story_v_out_115311.awb") / 1000

					if var_370_19 + var_370_11 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_19 + var_370_11
					end

					if var_370_14.prefab_name ~= "" and arg_367_1.actors_[var_370_14.prefab_name] ~= nil then
						local var_370_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_367_1.actors_[var_370_14.prefab_name].transform, "story_v_out_115311", "115311091", "story_v_out_115311.awb")

						arg_367_1:RecordAudio("115311091", var_370_20)
						arg_367_1:RecordAudio("115311091", var_370_20)
					else
						arg_367_1:AudioAction("play", "voice", "story_v_out_115311", "115311091", "story_v_out_115311.awb")
					end

					arg_367_1:RecordHistoryTalkVoice("story_v_out_115311", "115311091", "story_v_out_115311.awb")
				end

				arg_367_1:RecordContent(arg_367_1.text_.text)
			end

			local var_370_21 = math.max(var_370_12, arg_367_1.talkMaxDuration)

			if var_370_11 <= arg_367_1.time_ and arg_367_1.time_ < var_370_11 + var_370_21 then
				arg_367_1.typewritter.percent = (arg_367_1.time_ - var_370_11) / var_370_21

				arg_367_1.typewritter:SetDirty()
			end

			if arg_367_1.time_ >= var_370_11 + var_370_21 and arg_367_1.time_ < var_370_11 + var_370_21 + arg_370_0 then
				arg_367_1.typewritter.percent = 1

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(true)
			end
		end

		arg_367_1.nodeConfigList_ = {}

		arg_367_1:InitPlayNodeList()
	end,
	Play115311092 = function(arg_371_0, arg_371_1)
		arg_371_1.time_ = 0
		arg_371_1.frameCnt_ = 0
		arg_371_1.state_ = "playing"
		arg_371_1.curTalkId_ = 115311092
		arg_371_1.duration_ = 2.33

		local var_371_0 = {
			ja = 1.666,
			ko = 1.766,
			zh = 1.933,
			en = 2.333
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
				arg_371_0:Play115311093(arg_371_1)
			end
		end

		function arg_371_1.onSingleLineUpdate_(arg_374_0)
			local var_374_0 = 0
			local var_374_1 = 0.2

			if var_374_0 < arg_371_1.time_ and arg_371_1.time_ <= var_374_0 + arg_374_0 then
				arg_371_1.talkMaxDuration = 0
				arg_371_1.dialogCg_.alpha = 1

				arg_371_1.dialog_:SetActive(true)
				SetActive(arg_371_1.leftNameGo_, true)

				local var_374_2 = arg_371_1:FormatText(StoryNameCfg[316].name)

				arg_371_1.leftNameTxt_.text = var_374_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_371_1.leftNameTxt_.transform)

				arg_371_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_371_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_371_1:RecordName(arg_371_1.leftNameTxt_.text)
				SetActive(arg_371_1.iconTrs_.gameObject, true)
				arg_371_1.iconController_:SetSelectedState("hero")

				arg_371_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_371_1.callingController_:SetSelectedState("normal")

				arg_371_1.keyicon_.color = Color.New(1, 1, 1)
				arg_371_1.icon_.color = Color.New(1, 1, 1)

				local var_374_3 = arg_371_1:GetWordFromCfg(115311092)
				local var_374_4 = arg_371_1:FormatText(var_374_3.content)

				arg_371_1.text_.text = var_374_4

				LuaForUtil.ClearLinePrefixSymbol(arg_371_1.text_)

				local var_374_5 = 8
				local var_374_6 = utf8.len(var_374_4)
				local var_374_7 = var_374_5 <= 0 and var_374_1 or var_374_1 * (var_374_6 / var_374_5)

				if var_374_7 > 0 and var_374_1 < var_374_7 then
					arg_371_1.talkMaxDuration = var_374_7

					if var_374_7 + var_374_0 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_7 + var_374_0
					end
				end

				arg_371_1.text_.text = var_374_4
				arg_371_1.typewritter.percent = 0

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311092", "story_v_out_115311.awb") ~= 0 then
					local var_374_8 = manager.audio:GetVoiceLength("story_v_out_115311", "115311092", "story_v_out_115311.awb") / 1000

					if var_374_8 + var_374_0 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_8 + var_374_0
					end

					if var_374_3.prefab_name ~= "" and arg_371_1.actors_[var_374_3.prefab_name] ~= nil then
						local var_374_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_371_1.actors_[var_374_3.prefab_name].transform, "story_v_out_115311", "115311092", "story_v_out_115311.awb")

						arg_371_1:RecordAudio("115311092", var_374_9)
						arg_371_1:RecordAudio("115311092", var_374_9)
					else
						arg_371_1:AudioAction("play", "voice", "story_v_out_115311", "115311092", "story_v_out_115311.awb")
					end

					arg_371_1:RecordHistoryTalkVoice("story_v_out_115311", "115311092", "story_v_out_115311.awb")
				end

				arg_371_1:RecordContent(arg_371_1.text_.text)
			end

			local var_374_10 = math.max(var_374_1, arg_371_1.talkMaxDuration)

			if var_374_0 <= arg_371_1.time_ and arg_371_1.time_ < var_374_0 + var_374_10 then
				arg_371_1.typewritter.percent = (arg_371_1.time_ - var_374_0) / var_374_10

				arg_371_1.typewritter:SetDirty()
			end

			if arg_371_1.time_ >= var_374_0 + var_374_10 and arg_371_1.time_ < var_374_0 + var_374_10 + arg_374_0 then
				arg_371_1.typewritter.percent = 1

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(true)
			end
		end

		arg_371_1.nodeConfigList_ = {}

		arg_371_1:InitPlayNodeList()
	end,
	Play115311093 = function(arg_375_0, arg_375_1)
		arg_375_1.time_ = 0
		arg_375_1.frameCnt_ = 0
		arg_375_1.state_ = "playing"
		arg_375_1.curTalkId_ = 115311093
		arg_375_1.duration_ = 5

		SetActive(arg_375_1.tipsGo_, false)

		function arg_375_1.onSingleLineFinish_()
			arg_375_1.onSingleLineUpdate_ = nil
			arg_375_1.onSingleLineFinish_ = nil
			arg_375_1.state_ = "waiting"
		end

		function arg_375_1.playNext_(arg_377_0)
			if arg_377_0 == 1 then
				arg_375_0:Play115311094(arg_375_1)
			end
		end

		function arg_375_1.onSingleLineUpdate_(arg_378_0)
			local var_378_0 = 0
			local var_378_1 = 1.1

			if var_378_0 < arg_375_1.time_ and arg_375_1.time_ <= var_378_0 + arg_378_0 then
				arg_375_1.talkMaxDuration = 0
				arg_375_1.dialogCg_.alpha = 1

				arg_375_1.dialog_:SetActive(true)
				SetActive(arg_375_1.leftNameGo_, false)

				arg_375_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_375_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_375_1:RecordName(arg_375_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_375_1.iconTrs_.gameObject, false)
				arg_375_1.callingController_:SetSelectedState("normal")

				local var_378_2 = arg_375_1:GetWordFromCfg(115311093)
				local var_378_3 = arg_375_1:FormatText(var_378_2.content)

				arg_375_1.text_.text = var_378_3

				LuaForUtil.ClearLinePrefixSymbol(arg_375_1.text_)

				local var_378_4 = 44
				local var_378_5 = utf8.len(var_378_3)
				local var_378_6 = var_378_4 <= 0 and var_378_1 or var_378_1 * (var_378_5 / var_378_4)

				if var_378_6 > 0 and var_378_1 < var_378_6 then
					arg_375_1.talkMaxDuration = var_378_6

					if var_378_6 + var_378_0 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_6 + var_378_0
					end
				end

				arg_375_1.text_.text = var_378_3
				arg_375_1.typewritter.percent = 0

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(false)
				arg_375_1:RecordContent(arg_375_1.text_.text)
			end

			local var_378_7 = math.max(var_378_1, arg_375_1.talkMaxDuration)

			if var_378_0 <= arg_375_1.time_ and arg_375_1.time_ < var_378_0 + var_378_7 then
				arg_375_1.typewritter.percent = (arg_375_1.time_ - var_378_0) / var_378_7

				arg_375_1.typewritter:SetDirty()
			end

			if arg_375_1.time_ >= var_378_0 + var_378_7 and arg_375_1.time_ < var_378_0 + var_378_7 + arg_378_0 then
				arg_375_1.typewritter.percent = 1

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(true)
			end
		end

		arg_375_1.nodeConfigList_ = {}

		arg_375_1:InitPlayNodeList()
	end,
	Play115311094 = function(arg_379_0, arg_379_1)
		arg_379_1.time_ = 0
		arg_379_1.frameCnt_ = 0
		arg_379_1.state_ = "playing"
		arg_379_1.curTalkId_ = 115311094
		arg_379_1.duration_ = 21.9

		local var_379_0 = {
			ja = 17.566,
			ko = 20.1,
			zh = 17,
			en = 21.9
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
				arg_379_0:Play115311095(arg_379_1)
			end
		end

		function arg_379_1.onSingleLineUpdate_(arg_382_0)
			local var_382_0 = arg_379_1.actors_["113801_1"]
			local var_382_1 = 0

			if var_382_1 < arg_379_1.time_ and arg_379_1.time_ <= var_382_1 + arg_382_0 and not isNil(var_382_0) then
				local var_382_2 = var_382_0:GetComponent("Image")

				if var_382_2 then
					arg_379_1.var_.highlightMatValue113801_1 = var_382_2
				end
			end

			local var_382_3 = 0.2

			if var_382_1 <= arg_379_1.time_ and arg_379_1.time_ < var_382_1 + var_382_3 and not isNil(var_382_0) then
				local var_382_4 = (arg_379_1.time_ - var_382_1) / var_382_3

				if arg_379_1.var_.highlightMatValue113801_1 then
					local var_382_5 = Mathf.Lerp(0.5, 1, var_382_4)
					local var_382_6 = arg_379_1.var_.highlightMatValue113801_1
					local var_382_7 = var_382_6.color

					var_382_7.r = var_382_5
					var_382_7.g = var_382_5
					var_382_7.b = var_382_5
					var_382_6.color = var_382_7
				end
			end

			if arg_379_1.time_ >= var_382_1 + var_382_3 and arg_379_1.time_ < var_382_1 + var_382_3 + arg_382_0 and not isNil(var_382_0) and arg_379_1.var_.highlightMatValue113801_1 then
				local var_382_8 = 1

				var_382_0.transform:SetSiblingIndex(1)

				local var_382_9 = arg_379_1.var_.highlightMatValue113801_1
				local var_382_10 = var_382_9.color

				var_382_10.r = var_382_8
				var_382_10.g = var_382_8
				var_382_10.b = var_382_8
				var_382_9.color = var_382_10
			end

			local var_382_11 = 0
			local var_382_12 = 1.725

			if var_382_11 < arg_379_1.time_ and arg_379_1.time_ <= var_382_11 + arg_382_0 then
				arg_379_1.talkMaxDuration = 0
				arg_379_1.dialogCg_.alpha = 1

				arg_379_1.dialog_:SetActive(true)
				SetActive(arg_379_1.leftNameGo_, true)

				local var_382_13 = arg_379_1:FormatText(StoryNameCfg[94].name)

				arg_379_1.leftNameTxt_.text = var_382_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_379_1.leftNameTxt_.transform)

				arg_379_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_379_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_379_1:RecordName(arg_379_1.leftNameTxt_.text)
				SetActive(arg_379_1.iconTrs_.gameObject, false)
				arg_379_1.callingController_:SetSelectedState("normal")

				local var_382_14 = arg_379_1:GetWordFromCfg(115311094)
				local var_382_15 = arg_379_1:FormatText(var_382_14.content)

				arg_379_1.text_.text = var_382_15

				LuaForUtil.ClearLinePrefixSymbol(arg_379_1.text_)

				local var_382_16 = 69
				local var_382_17 = utf8.len(var_382_15)
				local var_382_18 = var_382_16 <= 0 and var_382_12 or var_382_12 * (var_382_17 / var_382_16)

				if var_382_18 > 0 and var_382_12 < var_382_18 then
					arg_379_1.talkMaxDuration = var_382_18

					if var_382_18 + var_382_11 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_18 + var_382_11
					end
				end

				arg_379_1.text_.text = var_382_15
				arg_379_1.typewritter.percent = 0

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311094", "story_v_out_115311.awb") ~= 0 then
					local var_382_19 = manager.audio:GetVoiceLength("story_v_out_115311", "115311094", "story_v_out_115311.awb") / 1000

					if var_382_19 + var_382_11 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_19 + var_382_11
					end

					if var_382_14.prefab_name ~= "" and arg_379_1.actors_[var_382_14.prefab_name] ~= nil then
						local var_382_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_379_1.actors_[var_382_14.prefab_name].transform, "story_v_out_115311", "115311094", "story_v_out_115311.awb")

						arg_379_1:RecordAudio("115311094", var_382_20)
						arg_379_1:RecordAudio("115311094", var_382_20)
					else
						arg_379_1:AudioAction("play", "voice", "story_v_out_115311", "115311094", "story_v_out_115311.awb")
					end

					arg_379_1:RecordHistoryTalkVoice("story_v_out_115311", "115311094", "story_v_out_115311.awb")
				end

				arg_379_1:RecordContent(arg_379_1.text_.text)
			end

			local var_382_21 = math.max(var_382_12, arg_379_1.talkMaxDuration)

			if var_382_11 <= arg_379_1.time_ and arg_379_1.time_ < var_382_11 + var_382_21 then
				arg_379_1.typewritter.percent = (arg_379_1.time_ - var_382_11) / var_382_21

				arg_379_1.typewritter:SetDirty()
			end

			if arg_379_1.time_ >= var_382_11 + var_382_21 and arg_379_1.time_ < var_382_11 + var_382_21 + arg_382_0 then
				arg_379_1.typewritter.percent = 1

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(true)
			end
		end

		arg_379_1.nodeConfigList_ = {}

		arg_379_1:InitPlayNodeList()
	end,
	Play115311095 = function(arg_383_0, arg_383_1)
		arg_383_1.time_ = 0
		arg_383_1.frameCnt_ = 0
		arg_383_1.state_ = "playing"
		arg_383_1.curTalkId_ = 115311095
		arg_383_1.duration_ = 19.23

		local var_383_0 = {
			ja = 11.4,
			ko = 13.866,
			zh = 15.4,
			en = 19.233
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
				arg_383_0:Play115311096(arg_383_1)
			end
		end

		function arg_383_1.onSingleLineUpdate_(arg_386_0)
			local var_386_0 = 0
			local var_386_1 = 1.375

			if var_386_0 < arg_383_1.time_ and arg_383_1.time_ <= var_386_0 + arg_386_0 then
				arg_383_1.talkMaxDuration = 0
				arg_383_1.dialogCg_.alpha = 1

				arg_383_1.dialog_:SetActive(true)
				SetActive(arg_383_1.leftNameGo_, true)

				local var_386_2 = arg_383_1:FormatText(StoryNameCfg[94].name)

				arg_383_1.leftNameTxt_.text = var_386_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_383_1.leftNameTxt_.transform)

				arg_383_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_383_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_383_1:RecordName(arg_383_1.leftNameTxt_.text)
				SetActive(arg_383_1.iconTrs_.gameObject, false)
				arg_383_1.callingController_:SetSelectedState("normal")

				local var_386_3 = arg_383_1:GetWordFromCfg(115311095)
				local var_386_4 = arg_383_1:FormatText(var_386_3.content)

				arg_383_1.text_.text = var_386_4

				LuaForUtil.ClearLinePrefixSymbol(arg_383_1.text_)

				local var_386_5 = 55
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

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311095", "story_v_out_115311.awb") ~= 0 then
					local var_386_8 = manager.audio:GetVoiceLength("story_v_out_115311", "115311095", "story_v_out_115311.awb") / 1000

					if var_386_8 + var_386_0 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_8 + var_386_0
					end

					if var_386_3.prefab_name ~= "" and arg_383_1.actors_[var_386_3.prefab_name] ~= nil then
						local var_386_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_383_1.actors_[var_386_3.prefab_name].transform, "story_v_out_115311", "115311095", "story_v_out_115311.awb")

						arg_383_1:RecordAudio("115311095", var_386_9)
						arg_383_1:RecordAudio("115311095", var_386_9)
					else
						arg_383_1:AudioAction("play", "voice", "story_v_out_115311", "115311095", "story_v_out_115311.awb")
					end

					arg_383_1:RecordHistoryTalkVoice("story_v_out_115311", "115311095", "story_v_out_115311.awb")
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
	Play115311096 = function(arg_387_0, arg_387_1)
		arg_387_1.time_ = 0
		arg_387_1.frameCnt_ = 0
		arg_387_1.state_ = "playing"
		arg_387_1.curTalkId_ = 115311096
		arg_387_1.duration_ = 18.33

		local var_387_0 = {
			ja = 18.333,
			ko = 14.133,
			zh = 14.933,
			en = 17.866
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
				arg_387_0:Play115311097(arg_387_1)
			end
		end

		function arg_387_1.onSingleLineUpdate_(arg_390_0)
			local var_390_0 = 0
			local var_390_1 = 1.35

			if var_390_0 < arg_387_1.time_ and arg_387_1.time_ <= var_390_0 + arg_390_0 then
				arg_387_1.talkMaxDuration = 0
				arg_387_1.dialogCg_.alpha = 1

				arg_387_1.dialog_:SetActive(true)
				SetActive(arg_387_1.leftNameGo_, true)

				local var_390_2 = arg_387_1:FormatText(StoryNameCfg[94].name)

				arg_387_1.leftNameTxt_.text = var_390_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_387_1.leftNameTxt_.transform)

				arg_387_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_387_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_387_1:RecordName(arg_387_1.leftNameTxt_.text)
				SetActive(arg_387_1.iconTrs_.gameObject, false)
				arg_387_1.callingController_:SetSelectedState("normal")

				local var_390_3 = arg_387_1:GetWordFromCfg(115311096)
				local var_390_4 = arg_387_1:FormatText(var_390_3.content)

				arg_387_1.text_.text = var_390_4

				LuaForUtil.ClearLinePrefixSymbol(arg_387_1.text_)

				local var_390_5 = 54
				local var_390_6 = utf8.len(var_390_4)
				local var_390_7 = var_390_5 <= 0 and var_390_1 or var_390_1 * (var_390_6 / var_390_5)

				if var_390_7 > 0 and var_390_1 < var_390_7 then
					arg_387_1.talkMaxDuration = var_390_7

					if var_390_7 + var_390_0 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_7 + var_390_0
					end
				end

				arg_387_1.text_.text = var_390_4
				arg_387_1.typewritter.percent = 0

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311096", "story_v_out_115311.awb") ~= 0 then
					local var_390_8 = manager.audio:GetVoiceLength("story_v_out_115311", "115311096", "story_v_out_115311.awb") / 1000

					if var_390_8 + var_390_0 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_8 + var_390_0
					end

					if var_390_3.prefab_name ~= "" and arg_387_1.actors_[var_390_3.prefab_name] ~= nil then
						local var_390_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_387_1.actors_[var_390_3.prefab_name].transform, "story_v_out_115311", "115311096", "story_v_out_115311.awb")

						arg_387_1:RecordAudio("115311096", var_390_9)
						arg_387_1:RecordAudio("115311096", var_390_9)
					else
						arg_387_1:AudioAction("play", "voice", "story_v_out_115311", "115311096", "story_v_out_115311.awb")
					end

					arg_387_1:RecordHistoryTalkVoice("story_v_out_115311", "115311096", "story_v_out_115311.awb")
				end

				arg_387_1:RecordContent(arg_387_1.text_.text)
			end

			local var_390_10 = math.max(var_390_1, arg_387_1.talkMaxDuration)

			if var_390_0 <= arg_387_1.time_ and arg_387_1.time_ < var_390_0 + var_390_10 then
				arg_387_1.typewritter.percent = (arg_387_1.time_ - var_390_0) / var_390_10

				arg_387_1.typewritter:SetDirty()
			end

			if arg_387_1.time_ >= var_390_0 + var_390_10 and arg_387_1.time_ < var_390_0 + var_390_10 + arg_390_0 then
				arg_387_1.typewritter.percent = 1

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(true)
			end
		end

		arg_387_1.nodeConfigList_ = {}

		arg_387_1:InitPlayNodeList()
	end,
	Play115311097 = function(arg_391_0, arg_391_1)
		arg_391_1.time_ = 0
		arg_391_1.frameCnt_ = 0
		arg_391_1.state_ = "playing"
		arg_391_1.curTalkId_ = 115311097
		arg_391_1.duration_ = 14.97

		local var_391_0 = {
			ja = 11.466,
			ko = 14.966,
			zh = 14.266,
			en = 14.2
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
				arg_391_0:Play115311098(arg_391_1)
			end
		end

		function arg_391_1.onSingleLineUpdate_(arg_394_0)
			local var_394_0 = 0
			local var_394_1 = 1.4

			if var_394_0 < arg_391_1.time_ and arg_391_1.time_ <= var_394_0 + arg_394_0 then
				arg_391_1.talkMaxDuration = 0
				arg_391_1.dialogCg_.alpha = 1

				arg_391_1.dialog_:SetActive(true)
				SetActive(arg_391_1.leftNameGo_, true)

				local var_394_2 = arg_391_1:FormatText(StoryNameCfg[94].name)

				arg_391_1.leftNameTxt_.text = var_394_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_391_1.leftNameTxt_.transform)

				arg_391_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_391_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_391_1:RecordName(arg_391_1.leftNameTxt_.text)
				SetActive(arg_391_1.iconTrs_.gameObject, false)
				arg_391_1.callingController_:SetSelectedState("normal")

				local var_394_3 = arg_391_1:GetWordFromCfg(115311097)
				local var_394_4 = arg_391_1:FormatText(var_394_3.content)

				arg_391_1.text_.text = var_394_4

				LuaForUtil.ClearLinePrefixSymbol(arg_391_1.text_)

				local var_394_5 = 56
				local var_394_6 = utf8.len(var_394_4)
				local var_394_7 = var_394_5 <= 0 and var_394_1 or var_394_1 * (var_394_6 / var_394_5)

				if var_394_7 > 0 and var_394_1 < var_394_7 then
					arg_391_1.talkMaxDuration = var_394_7

					if var_394_7 + var_394_0 > arg_391_1.duration_ then
						arg_391_1.duration_ = var_394_7 + var_394_0
					end
				end

				arg_391_1.text_.text = var_394_4
				arg_391_1.typewritter.percent = 0

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311097", "story_v_out_115311.awb") ~= 0 then
					local var_394_8 = manager.audio:GetVoiceLength("story_v_out_115311", "115311097", "story_v_out_115311.awb") / 1000

					if var_394_8 + var_394_0 > arg_391_1.duration_ then
						arg_391_1.duration_ = var_394_8 + var_394_0
					end

					if var_394_3.prefab_name ~= "" and arg_391_1.actors_[var_394_3.prefab_name] ~= nil then
						local var_394_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_391_1.actors_[var_394_3.prefab_name].transform, "story_v_out_115311", "115311097", "story_v_out_115311.awb")

						arg_391_1:RecordAudio("115311097", var_394_9)
						arg_391_1:RecordAudio("115311097", var_394_9)
					else
						arg_391_1:AudioAction("play", "voice", "story_v_out_115311", "115311097", "story_v_out_115311.awb")
					end

					arg_391_1:RecordHistoryTalkVoice("story_v_out_115311", "115311097", "story_v_out_115311.awb")
				end

				arg_391_1:RecordContent(arg_391_1.text_.text)
			end

			local var_394_10 = math.max(var_394_1, arg_391_1.talkMaxDuration)

			if var_394_0 <= arg_391_1.time_ and arg_391_1.time_ < var_394_0 + var_394_10 then
				arg_391_1.typewritter.percent = (arg_391_1.time_ - var_394_0) / var_394_10

				arg_391_1.typewritter:SetDirty()
			end

			if arg_391_1.time_ >= var_394_0 + var_394_10 and arg_391_1.time_ < var_394_0 + var_394_10 + arg_394_0 then
				arg_391_1.typewritter.percent = 1

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(true)
			end
		end

		arg_391_1.nodeConfigList_ = {}

		arg_391_1:InitPlayNodeList()
	end,
	Play115311098 = function(arg_395_0, arg_395_1)
		arg_395_1.time_ = 0
		arg_395_1.frameCnt_ = 0
		arg_395_1.state_ = "playing"
		arg_395_1.curTalkId_ = 115311098
		arg_395_1.duration_ = 16.6

		local var_395_0 = {
			ja = 13.433,
			ko = 12.733,
			zh = 13.6,
			en = 16.6
		}
		local var_395_1 = manager.audio:GetLocalizationFlag()

		if var_395_0[var_395_1] ~= nil then
			arg_395_1.duration_ = var_395_0[var_395_1]
		end

		SetActive(arg_395_1.tipsGo_, false)

		function arg_395_1.onSingleLineFinish_()
			arg_395_1.onSingleLineUpdate_ = nil
			arg_395_1.onSingleLineFinish_ = nil
			arg_395_1.state_ = "waiting"
		end

		function arg_395_1.playNext_(arg_397_0)
			if arg_397_0 == 1 then
				arg_395_0:Play115311099(arg_395_1)
			end
		end

		function arg_395_1.onSingleLineUpdate_(arg_398_0)
			local var_398_0 = 0
			local var_398_1 = 1.25

			if var_398_0 < arg_395_1.time_ and arg_395_1.time_ <= var_398_0 + arg_398_0 then
				arg_395_1.talkMaxDuration = 0
				arg_395_1.dialogCg_.alpha = 1

				arg_395_1.dialog_:SetActive(true)
				SetActive(arg_395_1.leftNameGo_, true)

				local var_398_2 = arg_395_1:FormatText(StoryNameCfg[94].name)

				arg_395_1.leftNameTxt_.text = var_398_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_395_1.leftNameTxt_.transform)

				arg_395_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_395_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_395_1:RecordName(arg_395_1.leftNameTxt_.text)
				SetActive(arg_395_1.iconTrs_.gameObject, false)
				arg_395_1.callingController_:SetSelectedState("normal")

				local var_398_3 = arg_395_1:GetWordFromCfg(115311098)
				local var_398_4 = arg_395_1:FormatText(var_398_3.content)

				arg_395_1.text_.text = var_398_4

				LuaForUtil.ClearLinePrefixSymbol(arg_395_1.text_)

				local var_398_5 = 50
				local var_398_6 = utf8.len(var_398_4)
				local var_398_7 = var_398_5 <= 0 and var_398_1 or var_398_1 * (var_398_6 / var_398_5)

				if var_398_7 > 0 and var_398_1 < var_398_7 then
					arg_395_1.talkMaxDuration = var_398_7

					if var_398_7 + var_398_0 > arg_395_1.duration_ then
						arg_395_1.duration_ = var_398_7 + var_398_0
					end
				end

				arg_395_1.text_.text = var_398_4
				arg_395_1.typewritter.percent = 0

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311098", "story_v_out_115311.awb") ~= 0 then
					local var_398_8 = manager.audio:GetVoiceLength("story_v_out_115311", "115311098", "story_v_out_115311.awb") / 1000

					if var_398_8 + var_398_0 > arg_395_1.duration_ then
						arg_395_1.duration_ = var_398_8 + var_398_0
					end

					if var_398_3.prefab_name ~= "" and arg_395_1.actors_[var_398_3.prefab_name] ~= nil then
						local var_398_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_395_1.actors_[var_398_3.prefab_name].transform, "story_v_out_115311", "115311098", "story_v_out_115311.awb")

						arg_395_1:RecordAudio("115311098", var_398_9)
						arg_395_1:RecordAudio("115311098", var_398_9)
					else
						arg_395_1:AudioAction("play", "voice", "story_v_out_115311", "115311098", "story_v_out_115311.awb")
					end

					arg_395_1:RecordHistoryTalkVoice("story_v_out_115311", "115311098", "story_v_out_115311.awb")
				end

				arg_395_1:RecordContent(arg_395_1.text_.text)
			end

			local var_398_10 = math.max(var_398_1, arg_395_1.talkMaxDuration)

			if var_398_0 <= arg_395_1.time_ and arg_395_1.time_ < var_398_0 + var_398_10 then
				arg_395_1.typewritter.percent = (arg_395_1.time_ - var_398_0) / var_398_10

				arg_395_1.typewritter:SetDirty()
			end

			if arg_395_1.time_ >= var_398_0 + var_398_10 and arg_395_1.time_ < var_398_0 + var_398_10 + arg_398_0 then
				arg_395_1.typewritter.percent = 1

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(true)
			end
		end

		arg_395_1.nodeConfigList_ = {}

		arg_395_1:InitPlayNodeList()
	end,
	Play115311099 = function(arg_399_0, arg_399_1)
		arg_399_1.time_ = 0
		arg_399_1.frameCnt_ = 0
		arg_399_1.state_ = "playing"
		arg_399_1.curTalkId_ = 115311099
		arg_399_1.duration_ = 2.27

		local var_399_0 = {
			ja = 2.266,
			ko = 1.3,
			zh = 1.333,
			en = 1.733
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
				arg_399_0:Play115311100(arg_399_1)
			end
		end

		function arg_399_1.onSingleLineUpdate_(arg_402_0)
			local var_402_0 = arg_399_1.actors_["113801_1"]
			local var_402_1 = 0

			if var_402_1 < arg_399_1.time_ and arg_399_1.time_ <= var_402_1 + arg_402_0 and not isNil(var_402_0) then
				local var_402_2 = var_402_0:GetComponent("Image")

				if var_402_2 then
					arg_399_1.var_.highlightMatValue113801_1 = var_402_2
				end
			end

			local var_402_3 = 0.2

			if var_402_1 <= arg_399_1.time_ and arg_399_1.time_ < var_402_1 + var_402_3 and not isNil(var_402_0) then
				local var_402_4 = (arg_399_1.time_ - var_402_1) / var_402_3

				if arg_399_1.var_.highlightMatValue113801_1 then
					local var_402_5 = Mathf.Lerp(1, 0.5, var_402_4)
					local var_402_6 = arg_399_1.var_.highlightMatValue113801_1
					local var_402_7 = var_402_6.color

					var_402_7.r = var_402_5
					var_402_7.g = var_402_5
					var_402_7.b = var_402_5
					var_402_6.color = var_402_7
				end
			end

			if arg_399_1.time_ >= var_402_1 + var_402_3 and arg_399_1.time_ < var_402_1 + var_402_3 + arg_402_0 and not isNil(var_402_0) and arg_399_1.var_.highlightMatValue113801_1 then
				local var_402_8 = 0.5
				local var_402_9 = arg_399_1.var_.highlightMatValue113801_1
				local var_402_10 = var_402_9.color

				var_402_10.r = var_402_8
				var_402_10.g = var_402_8
				var_402_10.b = var_402_8
				var_402_9.color = var_402_10
			end

			local var_402_11 = 0
			local var_402_12 = 0.075

			if var_402_11 < arg_399_1.time_ and arg_399_1.time_ <= var_402_11 + arg_402_0 then
				arg_399_1.talkMaxDuration = 0
				arg_399_1.dialogCg_.alpha = 1

				arg_399_1.dialog_:SetActive(true)
				SetActive(arg_399_1.leftNameGo_, true)

				local var_402_13 = arg_399_1:FormatText(StoryNameCfg[104].name)

				arg_399_1.leftNameTxt_.text = var_402_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_399_1.leftNameTxt_.transform)

				arg_399_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_399_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_399_1:RecordName(arg_399_1.leftNameTxt_.text)
				SetActive(arg_399_1.iconTrs_.gameObject, true)
				arg_399_1.iconController_:SetSelectedState("hero")

				arg_399_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_woundedd")

				arg_399_1.callingController_:SetSelectedState("normal")

				arg_399_1.keyicon_.color = Color.New(1, 1, 1)
				arg_399_1.icon_.color = Color.New(1, 1, 1)

				local var_402_14 = arg_399_1:GetWordFromCfg(115311099)
				local var_402_15 = arg_399_1:FormatText(var_402_14.content)

				arg_399_1.text_.text = var_402_15

				LuaForUtil.ClearLinePrefixSymbol(arg_399_1.text_)

				local var_402_16 = 3
				local var_402_17 = utf8.len(var_402_15)
				local var_402_18 = var_402_16 <= 0 and var_402_12 or var_402_12 * (var_402_17 / var_402_16)

				if var_402_18 > 0 and var_402_12 < var_402_18 then
					arg_399_1.talkMaxDuration = var_402_18

					if var_402_18 + var_402_11 > arg_399_1.duration_ then
						arg_399_1.duration_ = var_402_18 + var_402_11
					end
				end

				arg_399_1.text_.text = var_402_15
				arg_399_1.typewritter.percent = 0

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311099", "story_v_out_115311.awb") ~= 0 then
					local var_402_19 = manager.audio:GetVoiceLength("story_v_out_115311", "115311099", "story_v_out_115311.awb") / 1000

					if var_402_19 + var_402_11 > arg_399_1.duration_ then
						arg_399_1.duration_ = var_402_19 + var_402_11
					end

					if var_402_14.prefab_name ~= "" and arg_399_1.actors_[var_402_14.prefab_name] ~= nil then
						local var_402_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_399_1.actors_[var_402_14.prefab_name].transform, "story_v_out_115311", "115311099", "story_v_out_115311.awb")

						arg_399_1:RecordAudio("115311099", var_402_20)
						arg_399_1:RecordAudio("115311099", var_402_20)
					else
						arg_399_1:AudioAction("play", "voice", "story_v_out_115311", "115311099", "story_v_out_115311.awb")
					end

					arg_399_1:RecordHistoryTalkVoice("story_v_out_115311", "115311099", "story_v_out_115311.awb")
				end

				arg_399_1:RecordContent(arg_399_1.text_.text)
			end

			local var_402_21 = math.max(var_402_12, arg_399_1.talkMaxDuration)

			if var_402_11 <= arg_399_1.time_ and arg_399_1.time_ < var_402_11 + var_402_21 then
				arg_399_1.typewritter.percent = (arg_399_1.time_ - var_402_11) / var_402_21

				arg_399_1.typewritter:SetDirty()
			end

			if arg_399_1.time_ >= var_402_11 + var_402_21 and arg_399_1.time_ < var_402_11 + var_402_21 + arg_402_0 then
				arg_399_1.typewritter.percent = 1

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(true)
			end
		end

		arg_399_1.nodeConfigList_ = {}

		arg_399_1:InitPlayNodeList()
	end,
	Play115311100 = function(arg_403_0, arg_403_1)
		arg_403_1.time_ = 0
		arg_403_1.frameCnt_ = 0
		arg_403_1.state_ = "playing"
		arg_403_1.curTalkId_ = 115311100
		arg_403_1.duration_ = 5

		SetActive(arg_403_1.tipsGo_, false)

		function arg_403_1.onSingleLineFinish_()
			arg_403_1.onSingleLineUpdate_ = nil
			arg_403_1.onSingleLineFinish_ = nil
			arg_403_1.state_ = "waiting"
		end

		function arg_403_1.playNext_(arg_405_0)
			if arg_405_0 == 1 then
				arg_403_0:Play115311101(arg_403_1)
			end
		end

		function arg_403_1.onSingleLineUpdate_(arg_406_0)
			local var_406_0 = arg_403_1.actors_["10029"]
			local var_406_1 = 0

			if var_406_1 < arg_403_1.time_ and arg_403_1.time_ <= var_406_1 + arg_406_0 then
				local var_406_2 = var_406_0:GetComponent("Image")

				if var_406_2 then
					arg_403_1.var_.alphaMatValue10029 = var_406_2
					arg_403_1.var_.alphaOldValue10029 = var_406_2.color.a
				end

				arg_403_1.var_.alphaOldValue10029 = 1
			end

			local var_406_3 = 0.5

			if var_406_1 <= arg_403_1.time_ and arg_403_1.time_ < var_406_1 + var_406_3 then
				local var_406_4 = (arg_403_1.time_ - var_406_1) / var_406_3
				local var_406_5 = Mathf.Lerp(arg_403_1.var_.alphaOldValue10029, 0, var_406_4)

				if arg_403_1.var_.alphaMatValue10029 then
					local var_406_6 = arg_403_1.var_.alphaMatValue10029.color

					var_406_6.a = var_406_5
					arg_403_1.var_.alphaMatValue10029.color = var_406_6
				end
			end

			if arg_403_1.time_ >= var_406_1 + var_406_3 and arg_403_1.time_ < var_406_1 + var_406_3 + arg_406_0 and arg_403_1.var_.alphaMatValue10029 then
				local var_406_7 = arg_403_1.var_.alphaMatValue10029
				local var_406_8 = var_406_7.color

				var_406_8.a = 0
				var_406_7.color = var_406_8
			end

			local var_406_9 = arg_403_1.actors_["113801_1"]
			local var_406_10 = 0

			if var_406_10 < arg_403_1.time_ and arg_403_1.time_ <= var_406_10 + arg_406_0 then
				local var_406_11 = var_406_9:GetComponent("Image")

				if var_406_11 then
					arg_403_1.var_.alphaMatValue113801_1 = var_406_11
					arg_403_1.var_.alphaOldValue113801_1 = var_406_11.color.a
				end

				arg_403_1.var_.alphaOldValue113801_1 = 1
			end

			local var_406_12 = 0.5

			if var_406_10 <= arg_403_1.time_ and arg_403_1.time_ < var_406_10 + var_406_12 then
				local var_406_13 = (arg_403_1.time_ - var_406_10) / var_406_12
				local var_406_14 = Mathf.Lerp(arg_403_1.var_.alphaOldValue113801_1, 0, var_406_13)

				if arg_403_1.var_.alphaMatValue113801_1 then
					local var_406_15 = arg_403_1.var_.alphaMatValue113801_1.color

					var_406_15.a = var_406_14
					arg_403_1.var_.alphaMatValue113801_1.color = var_406_15
				end
			end

			if arg_403_1.time_ >= var_406_10 + var_406_12 and arg_403_1.time_ < var_406_10 + var_406_12 + arg_406_0 and arg_403_1.var_.alphaMatValue113801_1 then
				local var_406_16 = arg_403_1.var_.alphaMatValue113801_1
				local var_406_17 = var_406_16.color

				var_406_17.a = 0
				var_406_16.color = var_406_17
			end

			local var_406_18 = 0
			local var_406_19 = 1.025

			if var_406_18 < arg_403_1.time_ and arg_403_1.time_ <= var_406_18 + arg_406_0 then
				arg_403_1.talkMaxDuration = 0
				arg_403_1.dialogCg_.alpha = 1

				arg_403_1.dialog_:SetActive(true)
				SetActive(arg_403_1.leftNameGo_, false)

				arg_403_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_403_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_403_1:RecordName(arg_403_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_403_1.iconTrs_.gameObject, false)
				arg_403_1.callingController_:SetSelectedState("normal")

				local var_406_20 = arg_403_1:GetWordFromCfg(115311100)
				local var_406_21 = arg_403_1:FormatText(var_406_20.content)

				arg_403_1.text_.text = var_406_21

				LuaForUtil.ClearLinePrefixSymbol(arg_403_1.text_)

				local var_406_22 = 41
				local var_406_23 = utf8.len(var_406_21)
				local var_406_24 = var_406_22 <= 0 and var_406_19 or var_406_19 * (var_406_23 / var_406_22)

				if var_406_24 > 0 and var_406_19 < var_406_24 then
					arg_403_1.talkMaxDuration = var_406_24

					if var_406_24 + var_406_18 > arg_403_1.duration_ then
						arg_403_1.duration_ = var_406_24 + var_406_18
					end
				end

				arg_403_1.text_.text = var_406_21
				arg_403_1.typewritter.percent = 0

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(false)
				arg_403_1:RecordContent(arg_403_1.text_.text)
			end

			local var_406_25 = math.max(var_406_19, arg_403_1.talkMaxDuration)

			if var_406_18 <= arg_403_1.time_ and arg_403_1.time_ < var_406_18 + var_406_25 then
				arg_403_1.typewritter.percent = (arg_403_1.time_ - var_406_18) / var_406_25

				arg_403_1.typewritter:SetDirty()
			end

			if arg_403_1.time_ >= var_406_18 + var_406_25 and arg_403_1.time_ < var_406_18 + var_406_25 + arg_406_0 then
				arg_403_1.typewritter.percent = 1

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(true)
			end
		end

		arg_403_1.nodeConfigList_ = {}

		arg_403_1:InitPlayNodeList()
	end,
	Play115311101 = function(arg_407_0, arg_407_1)
		arg_407_1.time_ = 0
		arg_407_1.frameCnt_ = 0
		arg_407_1.state_ = "playing"
		arg_407_1.curTalkId_ = 115311101
		arg_407_1.duration_ = 5

		SetActive(arg_407_1.tipsGo_, false)

		function arg_407_1.onSingleLineFinish_()
			arg_407_1.onSingleLineUpdate_ = nil
			arg_407_1.onSingleLineFinish_ = nil
			arg_407_1.state_ = "waiting"
		end

		function arg_407_1.playNext_(arg_409_0)
			if arg_409_0 == 1 then
				arg_407_0:Play115311102(arg_407_1)
			end
		end

		function arg_407_1.onSingleLineUpdate_(arg_410_0)
			local var_410_0 = 0
			local var_410_1 = 1.35

			if var_410_0 < arg_407_1.time_ and arg_407_1.time_ <= var_410_0 + arg_410_0 then
				arg_407_1.talkMaxDuration = 0
				arg_407_1.dialogCg_.alpha = 1

				arg_407_1.dialog_:SetActive(true)
				SetActive(arg_407_1.leftNameGo_, false)

				arg_407_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_407_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_407_1:RecordName(arg_407_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_407_1.iconTrs_.gameObject, false)
				arg_407_1.callingController_:SetSelectedState("normal")

				local var_410_2 = arg_407_1:GetWordFromCfg(115311101)
				local var_410_3 = arg_407_1:FormatText(var_410_2.content)

				arg_407_1.text_.text = var_410_3

				LuaForUtil.ClearLinePrefixSymbol(arg_407_1.text_)

				local var_410_4 = 54
				local var_410_5 = utf8.len(var_410_3)
				local var_410_6 = var_410_4 <= 0 and var_410_1 or var_410_1 * (var_410_5 / var_410_4)

				if var_410_6 > 0 and var_410_1 < var_410_6 then
					arg_407_1.talkMaxDuration = var_410_6

					if var_410_6 + var_410_0 > arg_407_1.duration_ then
						arg_407_1.duration_ = var_410_6 + var_410_0
					end
				end

				arg_407_1.text_.text = var_410_3
				arg_407_1.typewritter.percent = 0

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(false)
				arg_407_1:RecordContent(arg_407_1.text_.text)
			end

			local var_410_7 = math.max(var_410_1, arg_407_1.talkMaxDuration)

			if var_410_0 <= arg_407_1.time_ and arg_407_1.time_ < var_410_0 + var_410_7 then
				arg_407_1.typewritter.percent = (arg_407_1.time_ - var_410_0) / var_410_7

				arg_407_1.typewritter:SetDirty()
			end

			if arg_407_1.time_ >= var_410_0 + var_410_7 and arg_407_1.time_ < var_410_0 + var_410_7 + arg_410_0 then
				arg_407_1.typewritter.percent = 1

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(true)
			end
		end

		arg_407_1.nodeConfigList_ = {}

		arg_407_1:InitPlayNodeList()
	end,
	Play115311102 = function(arg_411_0, arg_411_1)
		arg_411_1.time_ = 0
		arg_411_1.frameCnt_ = 0
		arg_411_1.state_ = "playing"
		arg_411_1.curTalkId_ = 115311102
		arg_411_1.duration_ = 20.7

		local var_411_0 = {
			ja = 20.7,
			ko = 14.8,
			zh = 14.2,
			en = 17.066
		}
		local var_411_1 = manager.audio:GetLocalizationFlag()

		if var_411_0[var_411_1] ~= nil then
			arg_411_1.duration_ = var_411_0[var_411_1]
		end

		SetActive(arg_411_1.tipsGo_, false)

		function arg_411_1.onSingleLineFinish_()
			arg_411_1.onSingleLineUpdate_ = nil
			arg_411_1.onSingleLineFinish_ = nil
			arg_411_1.state_ = "waiting"
		end

		function arg_411_1.playNext_(arg_413_0)
			if arg_413_0 == 1 then
				arg_411_0:Play115311103(arg_411_1)
			end
		end

		function arg_411_1.onSingleLineUpdate_(arg_414_0)
			local var_414_0 = arg_411_1.actors_["10029"]
			local var_414_1 = 0

			if var_414_1 < arg_411_1.time_ and arg_411_1.time_ <= var_414_1 + arg_414_0 then
				local var_414_2 = var_414_0:GetComponent("Image")

				if var_414_2 then
					arg_411_1.var_.alphaMatValue10029 = var_414_2
					arg_411_1.var_.alphaOldValue10029 = var_414_2.color.a
				end

				arg_411_1.var_.alphaOldValue10029 = 0
			end

			local var_414_3 = 0.5

			if var_414_1 <= arg_411_1.time_ and arg_411_1.time_ < var_414_1 + var_414_3 then
				local var_414_4 = (arg_411_1.time_ - var_414_1) / var_414_3
				local var_414_5 = Mathf.Lerp(arg_411_1.var_.alphaOldValue10029, 1, var_414_4)

				if arg_411_1.var_.alphaMatValue10029 then
					local var_414_6 = arg_411_1.var_.alphaMatValue10029.color

					var_414_6.a = var_414_5
					arg_411_1.var_.alphaMatValue10029.color = var_414_6
				end
			end

			if arg_411_1.time_ >= var_414_1 + var_414_3 and arg_411_1.time_ < var_414_1 + var_414_3 + arg_414_0 and arg_411_1.var_.alphaMatValue10029 then
				local var_414_7 = arg_411_1.var_.alphaMatValue10029
				local var_414_8 = var_414_7.color

				var_414_8.a = 1
				var_414_7.color = var_414_8
			end

			local var_414_9 = arg_411_1.actors_["113801_1"]
			local var_414_10 = 0

			if var_414_10 < arg_411_1.time_ and arg_411_1.time_ <= var_414_10 + arg_414_0 then
				local var_414_11 = var_414_9:GetComponent("Image")

				if var_414_11 then
					arg_411_1.var_.alphaMatValue113801_1 = var_414_11
					arg_411_1.var_.alphaOldValue113801_1 = var_414_11.color.a
				end

				arg_411_1.var_.alphaOldValue113801_1 = 0
			end

			local var_414_12 = 0.5

			if var_414_10 <= arg_411_1.time_ and arg_411_1.time_ < var_414_10 + var_414_12 then
				local var_414_13 = (arg_411_1.time_ - var_414_10) / var_414_12
				local var_414_14 = Mathf.Lerp(arg_411_1.var_.alphaOldValue113801_1, 1, var_414_13)

				if arg_411_1.var_.alphaMatValue113801_1 then
					local var_414_15 = arg_411_1.var_.alphaMatValue113801_1.color

					var_414_15.a = var_414_14
					arg_411_1.var_.alphaMatValue113801_1.color = var_414_15
				end
			end

			if arg_411_1.time_ >= var_414_10 + var_414_12 and arg_411_1.time_ < var_414_10 + var_414_12 + arg_414_0 and arg_411_1.var_.alphaMatValue113801_1 then
				local var_414_16 = arg_411_1.var_.alphaMatValue113801_1
				local var_414_17 = var_414_16.color

				var_414_17.a = 1
				var_414_16.color = var_414_17
			end

			local var_414_18 = arg_411_1.actors_["113801_1"]
			local var_414_19 = 0

			if var_414_19 < arg_411_1.time_ and arg_411_1.time_ <= var_414_19 + arg_414_0 and not isNil(var_414_18) then
				local var_414_20 = var_414_18:GetComponent("Image")

				if var_414_20 then
					arg_411_1.var_.highlightMatValue113801_1 = var_414_20
				end
			end

			local var_414_21 = 0.2

			if var_414_19 <= arg_411_1.time_ and arg_411_1.time_ < var_414_19 + var_414_21 and not isNil(var_414_18) then
				local var_414_22 = (arg_411_1.time_ - var_414_19) / var_414_21

				if arg_411_1.var_.highlightMatValue113801_1 then
					local var_414_23 = Mathf.Lerp(0.5, 1, var_414_22)
					local var_414_24 = arg_411_1.var_.highlightMatValue113801_1
					local var_414_25 = var_414_24.color

					var_414_25.r = var_414_23
					var_414_25.g = var_414_23
					var_414_25.b = var_414_23
					var_414_24.color = var_414_25
				end
			end

			if arg_411_1.time_ >= var_414_19 + var_414_21 and arg_411_1.time_ < var_414_19 + var_414_21 + arg_414_0 and not isNil(var_414_18) and arg_411_1.var_.highlightMatValue113801_1 then
				local var_414_26 = 1

				var_414_18.transform:SetSiblingIndex(1)

				local var_414_27 = arg_411_1.var_.highlightMatValue113801_1
				local var_414_28 = var_414_27.color

				var_414_28.r = var_414_26
				var_414_28.g = var_414_26
				var_414_28.b = var_414_26
				var_414_27.color = var_414_28
			end

			local var_414_29 = 0
			local var_414_30 = 1.5

			if var_414_29 < arg_411_1.time_ and arg_411_1.time_ <= var_414_29 + arg_414_0 then
				arg_411_1.talkMaxDuration = 0
				arg_411_1.dialogCg_.alpha = 1

				arg_411_1.dialog_:SetActive(true)
				SetActive(arg_411_1.leftNameGo_, true)

				local var_414_31 = arg_411_1:FormatText(StoryNameCfg[94].name)

				arg_411_1.leftNameTxt_.text = var_414_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_411_1.leftNameTxt_.transform)

				arg_411_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_411_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_411_1:RecordName(arg_411_1.leftNameTxt_.text)
				SetActive(arg_411_1.iconTrs_.gameObject, false)
				arg_411_1.callingController_:SetSelectedState("normal")

				local var_414_32 = arg_411_1:GetWordFromCfg(115311102)
				local var_414_33 = arg_411_1:FormatText(var_414_32.content)

				arg_411_1.text_.text = var_414_33

				LuaForUtil.ClearLinePrefixSymbol(arg_411_1.text_)

				local var_414_34 = 60
				local var_414_35 = utf8.len(var_414_33)
				local var_414_36 = var_414_34 <= 0 and var_414_30 or var_414_30 * (var_414_35 / var_414_34)

				if var_414_36 > 0 and var_414_30 < var_414_36 then
					arg_411_1.talkMaxDuration = var_414_36

					if var_414_36 + var_414_29 > arg_411_1.duration_ then
						arg_411_1.duration_ = var_414_36 + var_414_29
					end
				end

				arg_411_1.text_.text = var_414_33
				arg_411_1.typewritter.percent = 0

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311102", "story_v_out_115311.awb") ~= 0 then
					local var_414_37 = manager.audio:GetVoiceLength("story_v_out_115311", "115311102", "story_v_out_115311.awb") / 1000

					if var_414_37 + var_414_29 > arg_411_1.duration_ then
						arg_411_1.duration_ = var_414_37 + var_414_29
					end

					if var_414_32.prefab_name ~= "" and arg_411_1.actors_[var_414_32.prefab_name] ~= nil then
						local var_414_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_411_1.actors_[var_414_32.prefab_name].transform, "story_v_out_115311", "115311102", "story_v_out_115311.awb")

						arg_411_1:RecordAudio("115311102", var_414_38)
						arg_411_1:RecordAudio("115311102", var_414_38)
					else
						arg_411_1:AudioAction("play", "voice", "story_v_out_115311", "115311102", "story_v_out_115311.awb")
					end

					arg_411_1:RecordHistoryTalkVoice("story_v_out_115311", "115311102", "story_v_out_115311.awb")
				end

				arg_411_1:RecordContent(arg_411_1.text_.text)
			end

			local var_414_39 = math.max(var_414_30, arg_411_1.talkMaxDuration)

			if var_414_29 <= arg_411_1.time_ and arg_411_1.time_ < var_414_29 + var_414_39 then
				arg_411_1.typewritter.percent = (arg_411_1.time_ - var_414_29) / var_414_39

				arg_411_1.typewritter:SetDirty()
			end

			if arg_411_1.time_ >= var_414_29 + var_414_39 and arg_411_1.time_ < var_414_29 + var_414_39 + arg_414_0 then
				arg_411_1.typewritter.percent = 1

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(true)
			end
		end

		arg_411_1.nodeConfigList_ = {}

		arg_411_1:InitPlayNodeList()
	end,
	Play115311103 = function(arg_415_0, arg_415_1)
		arg_415_1.time_ = 0
		arg_415_1.frameCnt_ = 0
		arg_415_1.state_ = "playing"
		arg_415_1.curTalkId_ = 115311103
		arg_415_1.duration_ = 5

		SetActive(arg_415_1.tipsGo_, false)

		function arg_415_1.onSingleLineFinish_()
			arg_415_1.onSingleLineUpdate_ = nil
			arg_415_1.onSingleLineFinish_ = nil
			arg_415_1.state_ = "waiting"
		end

		function arg_415_1.playNext_(arg_417_0)
			if arg_417_0 == 1 then
				arg_415_0:Play115311104(arg_415_1)
			end
		end

		function arg_415_1.onSingleLineUpdate_(arg_418_0)
			local var_418_0 = arg_415_1.actors_["113801_1"]
			local var_418_1 = 0

			if var_418_1 < arg_415_1.time_ and arg_415_1.time_ <= var_418_1 + arg_418_0 and not isNil(var_418_0) then
				local var_418_2 = var_418_0:GetComponent("Image")

				if var_418_2 then
					arg_415_1.var_.highlightMatValue113801_1 = var_418_2
				end
			end

			local var_418_3 = 0.2

			if var_418_1 <= arg_415_1.time_ and arg_415_1.time_ < var_418_1 + var_418_3 and not isNil(var_418_0) then
				local var_418_4 = (arg_415_1.time_ - var_418_1) / var_418_3

				if arg_415_1.var_.highlightMatValue113801_1 then
					local var_418_5 = Mathf.Lerp(1, 0.5, var_418_4)
					local var_418_6 = arg_415_1.var_.highlightMatValue113801_1
					local var_418_7 = var_418_6.color

					var_418_7.r = var_418_5
					var_418_7.g = var_418_5
					var_418_7.b = var_418_5
					var_418_6.color = var_418_7
				end
			end

			if arg_415_1.time_ >= var_418_1 + var_418_3 and arg_415_1.time_ < var_418_1 + var_418_3 + arg_418_0 and not isNil(var_418_0) and arg_415_1.var_.highlightMatValue113801_1 then
				local var_418_8 = 0.5
				local var_418_9 = arg_415_1.var_.highlightMatValue113801_1
				local var_418_10 = var_418_9.color

				var_418_10.r = var_418_8
				var_418_10.g = var_418_8
				var_418_10.b = var_418_8
				var_418_9.color = var_418_10
			end

			local var_418_11 = 0
			local var_418_12 = 0.725

			if var_418_11 < arg_415_1.time_ and arg_415_1.time_ <= var_418_11 + arg_418_0 then
				arg_415_1.talkMaxDuration = 0
				arg_415_1.dialogCg_.alpha = 1

				arg_415_1.dialog_:SetActive(true)
				SetActive(arg_415_1.leftNameGo_, false)

				arg_415_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_415_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_415_1:RecordName(arg_415_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_415_1.iconTrs_.gameObject, false)
				arg_415_1.callingController_:SetSelectedState("normal")

				local var_418_13 = arg_415_1:GetWordFromCfg(115311103)
				local var_418_14 = arg_415_1:FormatText(var_418_13.content)

				arg_415_1.text_.text = var_418_14

				LuaForUtil.ClearLinePrefixSymbol(arg_415_1.text_)

				local var_418_15 = 29
				local var_418_16 = utf8.len(var_418_14)
				local var_418_17 = var_418_15 <= 0 and var_418_12 or var_418_12 * (var_418_16 / var_418_15)

				if var_418_17 > 0 and var_418_12 < var_418_17 then
					arg_415_1.talkMaxDuration = var_418_17

					if var_418_17 + var_418_11 > arg_415_1.duration_ then
						arg_415_1.duration_ = var_418_17 + var_418_11
					end
				end

				arg_415_1.text_.text = var_418_14
				arg_415_1.typewritter.percent = 0

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(false)
				arg_415_1:RecordContent(arg_415_1.text_.text)
			end

			local var_418_18 = math.max(var_418_12, arg_415_1.talkMaxDuration)

			if var_418_11 <= arg_415_1.time_ and arg_415_1.time_ < var_418_11 + var_418_18 then
				arg_415_1.typewritter.percent = (arg_415_1.time_ - var_418_11) / var_418_18

				arg_415_1.typewritter:SetDirty()
			end

			if arg_415_1.time_ >= var_418_11 + var_418_18 and arg_415_1.time_ < var_418_11 + var_418_18 + arg_418_0 then
				arg_415_1.typewritter.percent = 1

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(true)
			end
		end

		arg_415_1.nodeConfigList_ = {}

		arg_415_1:InitPlayNodeList()
	end,
	Play115311104 = function(arg_419_0, arg_419_1)
		arg_419_1.time_ = 0
		arg_419_1.frameCnt_ = 0
		arg_419_1.state_ = "playing"
		arg_419_1.curTalkId_ = 115311104
		arg_419_1.duration_ = 14.7

		local var_419_0 = {
			ja = 14.7,
			ko = 8.6,
			zh = 8.033,
			en = 7.5
		}
		local var_419_1 = manager.audio:GetLocalizationFlag()

		if var_419_0[var_419_1] ~= nil then
			arg_419_1.duration_ = var_419_0[var_419_1]
		end

		SetActive(arg_419_1.tipsGo_, false)

		function arg_419_1.onSingleLineFinish_()
			arg_419_1.onSingleLineUpdate_ = nil
			arg_419_1.onSingleLineFinish_ = nil
			arg_419_1.state_ = "waiting"
		end

		function arg_419_1.playNext_(arg_421_0)
			if arg_421_0 == 1 then
				arg_419_0:Play115311105(arg_419_1)
			end
		end

		function arg_419_1.onSingleLineUpdate_(arg_422_0)
			local var_422_0 = arg_419_1.actors_["113801_1"]
			local var_422_1 = 0

			if var_422_1 < arg_419_1.time_ and arg_419_1.time_ <= var_422_1 + arg_422_0 and not isNil(var_422_0) then
				local var_422_2 = var_422_0:GetComponent("Image")

				if var_422_2 then
					arg_419_1.var_.highlightMatValue113801_1 = var_422_2
				end
			end

			local var_422_3 = 0.2

			if var_422_1 <= arg_419_1.time_ and arg_419_1.time_ < var_422_1 + var_422_3 and not isNil(var_422_0) then
				local var_422_4 = (arg_419_1.time_ - var_422_1) / var_422_3

				if arg_419_1.var_.highlightMatValue113801_1 then
					local var_422_5 = Mathf.Lerp(0.5, 1, var_422_4)
					local var_422_6 = arg_419_1.var_.highlightMatValue113801_1
					local var_422_7 = var_422_6.color

					var_422_7.r = var_422_5
					var_422_7.g = var_422_5
					var_422_7.b = var_422_5
					var_422_6.color = var_422_7
				end
			end

			if arg_419_1.time_ >= var_422_1 + var_422_3 and arg_419_1.time_ < var_422_1 + var_422_3 + arg_422_0 and not isNil(var_422_0) and arg_419_1.var_.highlightMatValue113801_1 then
				local var_422_8 = 1

				var_422_0.transform:SetSiblingIndex(1)

				local var_422_9 = arg_419_1.var_.highlightMatValue113801_1
				local var_422_10 = var_422_9.color

				var_422_10.r = var_422_8
				var_422_10.g = var_422_8
				var_422_10.b = var_422_8
				var_422_9.color = var_422_10
			end

			local var_422_11 = 0
			local var_422_12 = 0.75

			if var_422_11 < arg_419_1.time_ and arg_419_1.time_ <= var_422_11 + arg_422_0 then
				arg_419_1.talkMaxDuration = 0
				arg_419_1.dialogCg_.alpha = 1

				arg_419_1.dialog_:SetActive(true)
				SetActive(arg_419_1.leftNameGo_, true)

				local var_422_13 = arg_419_1:FormatText(StoryNameCfg[94].name)

				arg_419_1.leftNameTxt_.text = var_422_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_419_1.leftNameTxt_.transform)

				arg_419_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_419_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_419_1:RecordName(arg_419_1.leftNameTxt_.text)
				SetActive(arg_419_1.iconTrs_.gameObject, false)
				arg_419_1.callingController_:SetSelectedState("normal")

				local var_422_14 = arg_419_1:GetWordFromCfg(115311104)
				local var_422_15 = arg_419_1:FormatText(var_422_14.content)

				arg_419_1.text_.text = var_422_15

				LuaForUtil.ClearLinePrefixSymbol(arg_419_1.text_)

				local var_422_16 = 30
				local var_422_17 = utf8.len(var_422_15)
				local var_422_18 = var_422_16 <= 0 and var_422_12 or var_422_12 * (var_422_17 / var_422_16)

				if var_422_18 > 0 and var_422_12 < var_422_18 then
					arg_419_1.talkMaxDuration = var_422_18

					if var_422_18 + var_422_11 > arg_419_1.duration_ then
						arg_419_1.duration_ = var_422_18 + var_422_11
					end
				end

				arg_419_1.text_.text = var_422_15
				arg_419_1.typewritter.percent = 0

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311104", "story_v_out_115311.awb") ~= 0 then
					local var_422_19 = manager.audio:GetVoiceLength("story_v_out_115311", "115311104", "story_v_out_115311.awb") / 1000

					if var_422_19 + var_422_11 > arg_419_1.duration_ then
						arg_419_1.duration_ = var_422_19 + var_422_11
					end

					if var_422_14.prefab_name ~= "" and arg_419_1.actors_[var_422_14.prefab_name] ~= nil then
						local var_422_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_419_1.actors_[var_422_14.prefab_name].transform, "story_v_out_115311", "115311104", "story_v_out_115311.awb")

						arg_419_1:RecordAudio("115311104", var_422_20)
						arg_419_1:RecordAudio("115311104", var_422_20)
					else
						arg_419_1:AudioAction("play", "voice", "story_v_out_115311", "115311104", "story_v_out_115311.awb")
					end

					arg_419_1:RecordHistoryTalkVoice("story_v_out_115311", "115311104", "story_v_out_115311.awb")
				end

				arg_419_1:RecordContent(arg_419_1.text_.text)
			end

			local var_422_21 = math.max(var_422_12, arg_419_1.talkMaxDuration)

			if var_422_11 <= arg_419_1.time_ and arg_419_1.time_ < var_422_11 + var_422_21 then
				arg_419_1.typewritter.percent = (arg_419_1.time_ - var_422_11) / var_422_21

				arg_419_1.typewritter:SetDirty()
			end

			if arg_419_1.time_ >= var_422_11 + var_422_21 and arg_419_1.time_ < var_422_11 + var_422_21 + arg_422_0 then
				arg_419_1.typewritter.percent = 1

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(true)
			end
		end

		arg_419_1.nodeConfigList_ = {}

		arg_419_1:InitPlayNodeList()
	end,
	Play115311105 = function(arg_423_0, arg_423_1)
		arg_423_1.time_ = 0
		arg_423_1.frameCnt_ = 0
		arg_423_1.state_ = "playing"
		arg_423_1.curTalkId_ = 115311105
		arg_423_1.duration_ = 12.07

		local var_423_0 = {
			ja = 8,
			ko = 10.366,
			zh = 12.066,
			en = 7.166
		}
		local var_423_1 = manager.audio:GetLocalizationFlag()

		if var_423_0[var_423_1] ~= nil then
			arg_423_1.duration_ = var_423_0[var_423_1]
		end

		SetActive(arg_423_1.tipsGo_, false)

		function arg_423_1.onSingleLineFinish_()
			arg_423_1.onSingleLineUpdate_ = nil
			arg_423_1.onSingleLineFinish_ = nil
			arg_423_1.state_ = "waiting"
		end

		function arg_423_1.playNext_(arg_425_0)
			if arg_425_0 == 1 then
				arg_423_0:Play115311106(arg_423_1)
			end
		end

		function arg_423_1.onSingleLineUpdate_(arg_426_0)
			local var_426_0 = 0
			local var_426_1 = 1.225

			if var_426_0 < arg_423_1.time_ and arg_423_1.time_ <= var_426_0 + arg_426_0 then
				arg_423_1.talkMaxDuration = 0
				arg_423_1.dialogCg_.alpha = 1

				arg_423_1.dialog_:SetActive(true)
				SetActive(arg_423_1.leftNameGo_, true)

				local var_426_2 = arg_423_1:FormatText(StoryNameCfg[94].name)

				arg_423_1.leftNameTxt_.text = var_426_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_423_1.leftNameTxt_.transform)

				arg_423_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_423_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_423_1:RecordName(arg_423_1.leftNameTxt_.text)
				SetActive(arg_423_1.iconTrs_.gameObject, false)
				arg_423_1.callingController_:SetSelectedState("normal")

				local var_426_3 = arg_423_1:GetWordFromCfg(115311105)
				local var_426_4 = arg_423_1:FormatText(var_426_3.content)

				arg_423_1.text_.text = var_426_4

				LuaForUtil.ClearLinePrefixSymbol(arg_423_1.text_)

				local var_426_5 = 49
				local var_426_6 = utf8.len(var_426_4)
				local var_426_7 = var_426_5 <= 0 and var_426_1 or var_426_1 * (var_426_6 / var_426_5)

				if var_426_7 > 0 and var_426_1 < var_426_7 then
					arg_423_1.talkMaxDuration = var_426_7

					if var_426_7 + var_426_0 > arg_423_1.duration_ then
						arg_423_1.duration_ = var_426_7 + var_426_0
					end
				end

				arg_423_1.text_.text = var_426_4
				arg_423_1.typewritter.percent = 0

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311105", "story_v_out_115311.awb") ~= 0 then
					local var_426_8 = manager.audio:GetVoiceLength("story_v_out_115311", "115311105", "story_v_out_115311.awb") / 1000

					if var_426_8 + var_426_0 > arg_423_1.duration_ then
						arg_423_1.duration_ = var_426_8 + var_426_0
					end

					if var_426_3.prefab_name ~= "" and arg_423_1.actors_[var_426_3.prefab_name] ~= nil then
						local var_426_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_423_1.actors_[var_426_3.prefab_name].transform, "story_v_out_115311", "115311105", "story_v_out_115311.awb")

						arg_423_1:RecordAudio("115311105", var_426_9)
						arg_423_1:RecordAudio("115311105", var_426_9)
					else
						arg_423_1:AudioAction("play", "voice", "story_v_out_115311", "115311105", "story_v_out_115311.awb")
					end

					arg_423_1:RecordHistoryTalkVoice("story_v_out_115311", "115311105", "story_v_out_115311.awb")
				end

				arg_423_1:RecordContent(arg_423_1.text_.text)
			end

			local var_426_10 = math.max(var_426_1, arg_423_1.talkMaxDuration)

			if var_426_0 <= arg_423_1.time_ and arg_423_1.time_ < var_426_0 + var_426_10 then
				arg_423_1.typewritter.percent = (arg_423_1.time_ - var_426_0) / var_426_10

				arg_423_1.typewritter:SetDirty()
			end

			if arg_423_1.time_ >= var_426_0 + var_426_10 and arg_423_1.time_ < var_426_0 + var_426_10 + arg_426_0 then
				arg_423_1.typewritter.percent = 1

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(true)
			end
		end

		arg_423_1.nodeConfigList_ = {}

		arg_423_1:InitPlayNodeList()
	end,
	Play115311106 = function(arg_427_0, arg_427_1)
		arg_427_1.time_ = 0
		arg_427_1.frameCnt_ = 0
		arg_427_1.state_ = "playing"
		arg_427_1.curTalkId_ = 115311106
		arg_427_1.duration_ = 5

		SetActive(arg_427_1.tipsGo_, false)

		function arg_427_1.onSingleLineFinish_()
			arg_427_1.onSingleLineUpdate_ = nil
			arg_427_1.onSingleLineFinish_ = nil
			arg_427_1.state_ = "waiting"
		end

		function arg_427_1.playNext_(arg_429_0)
			if arg_429_0 == 1 then
				arg_427_0:Play115311107(arg_427_1)
			end
		end

		function arg_427_1.onSingleLineUpdate_(arg_430_0)
			local var_430_0 = arg_427_1.actors_["113801_1"]
			local var_430_1 = 0

			if var_430_1 < arg_427_1.time_ and arg_427_1.time_ <= var_430_1 + arg_430_0 and not isNil(var_430_0) then
				local var_430_2 = var_430_0:GetComponent("Image")

				if var_430_2 then
					arg_427_1.var_.highlightMatValue113801_1 = var_430_2
				end
			end

			local var_430_3 = 0.2

			if var_430_1 <= arg_427_1.time_ and arg_427_1.time_ < var_430_1 + var_430_3 and not isNil(var_430_0) then
				local var_430_4 = (arg_427_1.time_ - var_430_1) / var_430_3

				if arg_427_1.var_.highlightMatValue113801_1 then
					local var_430_5 = Mathf.Lerp(1, 0.5, var_430_4)
					local var_430_6 = arg_427_1.var_.highlightMatValue113801_1
					local var_430_7 = var_430_6.color

					var_430_7.r = var_430_5
					var_430_7.g = var_430_5
					var_430_7.b = var_430_5
					var_430_6.color = var_430_7
				end
			end

			if arg_427_1.time_ >= var_430_1 + var_430_3 and arg_427_1.time_ < var_430_1 + var_430_3 + arg_430_0 and not isNil(var_430_0) and arg_427_1.var_.highlightMatValue113801_1 then
				local var_430_8 = 0.5
				local var_430_9 = arg_427_1.var_.highlightMatValue113801_1
				local var_430_10 = var_430_9.color

				var_430_10.r = var_430_8
				var_430_10.g = var_430_8
				var_430_10.b = var_430_8
				var_430_9.color = var_430_10
			end

			local var_430_11 = 0
			local var_430_12 = 1.225

			if var_430_11 < arg_427_1.time_ and arg_427_1.time_ <= var_430_11 + arg_430_0 then
				arg_427_1.talkMaxDuration = 0
				arg_427_1.dialogCg_.alpha = 1

				arg_427_1.dialog_:SetActive(true)
				SetActive(arg_427_1.leftNameGo_, false)

				arg_427_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_427_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_427_1:RecordName(arg_427_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_427_1.iconTrs_.gameObject, false)
				arg_427_1.callingController_:SetSelectedState("normal")

				local var_430_13 = arg_427_1:GetWordFromCfg(115311106)
				local var_430_14 = arg_427_1:FormatText(var_430_13.content)

				arg_427_1.text_.text = var_430_14

				LuaForUtil.ClearLinePrefixSymbol(arg_427_1.text_)

				local var_430_15 = 49
				local var_430_16 = utf8.len(var_430_14)
				local var_430_17 = var_430_15 <= 0 and var_430_12 or var_430_12 * (var_430_16 / var_430_15)

				if var_430_17 > 0 and var_430_12 < var_430_17 then
					arg_427_1.talkMaxDuration = var_430_17

					if var_430_17 + var_430_11 > arg_427_1.duration_ then
						arg_427_1.duration_ = var_430_17 + var_430_11
					end
				end

				arg_427_1.text_.text = var_430_14
				arg_427_1.typewritter.percent = 0

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(false)
				arg_427_1:RecordContent(arg_427_1.text_.text)
			end

			local var_430_18 = math.max(var_430_12, arg_427_1.talkMaxDuration)

			if var_430_11 <= arg_427_1.time_ and arg_427_1.time_ < var_430_11 + var_430_18 then
				arg_427_1.typewritter.percent = (arg_427_1.time_ - var_430_11) / var_430_18

				arg_427_1.typewritter:SetDirty()
			end

			if arg_427_1.time_ >= var_430_11 + var_430_18 and arg_427_1.time_ < var_430_11 + var_430_18 + arg_430_0 then
				arg_427_1.typewritter.percent = 1

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(true)
			end
		end

		arg_427_1.nodeConfigList_ = {}

		arg_427_1:InitPlayNodeList()
	end,
	Play115311107 = function(arg_431_0, arg_431_1)
		arg_431_1.time_ = 0
		arg_431_1.frameCnt_ = 0
		arg_431_1.state_ = "playing"
		arg_431_1.curTalkId_ = 115311107
		arg_431_1.duration_ = 5

		SetActive(arg_431_1.tipsGo_, false)

		function arg_431_1.onSingleLineFinish_()
			arg_431_1.onSingleLineUpdate_ = nil
			arg_431_1.onSingleLineFinish_ = nil
			arg_431_1.state_ = "waiting"
		end

		function arg_431_1.playNext_(arg_433_0)
			if arg_433_0 == 1 then
				arg_431_0:Play115311108(arg_431_1)
			end
		end

		function arg_431_1.onSingleLineUpdate_(arg_434_0)
			local var_434_0 = 0
			local var_434_1 = 1.1

			if var_434_0 < arg_431_1.time_ and arg_431_1.time_ <= var_434_0 + arg_434_0 then
				arg_431_1.talkMaxDuration = 0
				arg_431_1.dialogCg_.alpha = 1

				arg_431_1.dialog_:SetActive(true)
				SetActive(arg_431_1.leftNameGo_, false)

				arg_431_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_431_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_431_1:RecordName(arg_431_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_431_1.iconTrs_.gameObject, false)
				arg_431_1.callingController_:SetSelectedState("normal")

				local var_434_2 = arg_431_1:GetWordFromCfg(115311107)
				local var_434_3 = arg_431_1:FormatText(var_434_2.content)

				arg_431_1.text_.text = var_434_3

				LuaForUtil.ClearLinePrefixSymbol(arg_431_1.text_)

				local var_434_4 = 44
				local var_434_5 = utf8.len(var_434_3)
				local var_434_6 = var_434_4 <= 0 and var_434_1 or var_434_1 * (var_434_5 / var_434_4)

				if var_434_6 > 0 and var_434_1 < var_434_6 then
					arg_431_1.talkMaxDuration = var_434_6

					if var_434_6 + var_434_0 > arg_431_1.duration_ then
						arg_431_1.duration_ = var_434_6 + var_434_0
					end
				end

				arg_431_1.text_.text = var_434_3
				arg_431_1.typewritter.percent = 0

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(false)
				arg_431_1:RecordContent(arg_431_1.text_.text)
			end

			local var_434_7 = math.max(var_434_1, arg_431_1.talkMaxDuration)

			if var_434_0 <= arg_431_1.time_ and arg_431_1.time_ < var_434_0 + var_434_7 then
				arg_431_1.typewritter.percent = (arg_431_1.time_ - var_434_0) / var_434_7

				arg_431_1.typewritter:SetDirty()
			end

			if arg_431_1.time_ >= var_434_0 + var_434_7 and arg_431_1.time_ < var_434_0 + var_434_7 + arg_434_0 then
				arg_431_1.typewritter.percent = 1

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(true)
			end
		end

		arg_431_1.nodeConfigList_ = {}

		arg_431_1:InitPlayNodeList()
	end,
	Play115311108 = function(arg_435_0, arg_435_1)
		arg_435_1.time_ = 0
		arg_435_1.frameCnt_ = 0
		arg_435_1.state_ = "playing"
		arg_435_1.curTalkId_ = 115311108
		arg_435_1.duration_ = 8.87

		local var_435_0 = {
			ja = 8.866,
			ko = 5.366,
			zh = 6.633,
			en = 8.866
		}
		local var_435_1 = manager.audio:GetLocalizationFlag()

		if var_435_0[var_435_1] ~= nil then
			arg_435_1.duration_ = var_435_0[var_435_1]
		end

		SetActive(arg_435_1.tipsGo_, false)

		function arg_435_1.onSingleLineFinish_()
			arg_435_1.onSingleLineUpdate_ = nil
			arg_435_1.onSingleLineFinish_ = nil
			arg_435_1.state_ = "waiting"
		end

		function arg_435_1.playNext_(arg_437_0)
			if arg_437_0 == 1 then
				arg_435_0:Play115311109(arg_435_1)
			end
		end

		function arg_435_1.onSingleLineUpdate_(arg_438_0)
			local var_438_0 = arg_435_1.actors_["113801_1"]
			local var_438_1 = 0

			if var_438_1 < arg_435_1.time_ and arg_435_1.time_ <= var_438_1 + arg_438_0 and not isNil(var_438_0) then
				local var_438_2 = var_438_0:GetComponent("Image")

				if var_438_2 then
					arg_435_1.var_.highlightMatValue113801_1 = var_438_2
				end
			end

			local var_438_3 = 0.2

			if var_438_1 <= arg_435_1.time_ and arg_435_1.time_ < var_438_1 + var_438_3 and not isNil(var_438_0) then
				local var_438_4 = (arg_435_1.time_ - var_438_1) / var_438_3

				if arg_435_1.var_.highlightMatValue113801_1 then
					local var_438_5 = Mathf.Lerp(0.5, 1, var_438_4)
					local var_438_6 = arg_435_1.var_.highlightMatValue113801_1
					local var_438_7 = var_438_6.color

					var_438_7.r = var_438_5
					var_438_7.g = var_438_5
					var_438_7.b = var_438_5
					var_438_6.color = var_438_7
				end
			end

			if arg_435_1.time_ >= var_438_1 + var_438_3 and arg_435_1.time_ < var_438_1 + var_438_3 + arg_438_0 and not isNil(var_438_0) and arg_435_1.var_.highlightMatValue113801_1 then
				local var_438_8 = 1

				var_438_0.transform:SetSiblingIndex(1)

				local var_438_9 = arg_435_1.var_.highlightMatValue113801_1
				local var_438_10 = var_438_9.color

				var_438_10.r = var_438_8
				var_438_10.g = var_438_8
				var_438_10.b = var_438_8
				var_438_9.color = var_438_10
			end

			local var_438_11 = 0
			local var_438_12 = 0.675

			if var_438_11 < arg_435_1.time_ and arg_435_1.time_ <= var_438_11 + arg_438_0 then
				arg_435_1.talkMaxDuration = 0
				arg_435_1.dialogCg_.alpha = 1

				arg_435_1.dialog_:SetActive(true)
				SetActive(arg_435_1.leftNameGo_, true)

				local var_438_13 = arg_435_1:FormatText(StoryNameCfg[94].name)

				arg_435_1.leftNameTxt_.text = var_438_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_435_1.leftNameTxt_.transform)

				arg_435_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_435_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_435_1:RecordName(arg_435_1.leftNameTxt_.text)
				SetActive(arg_435_1.iconTrs_.gameObject, false)
				arg_435_1.callingController_:SetSelectedState("normal")

				local var_438_14 = arg_435_1:GetWordFromCfg(115311108)
				local var_438_15 = arg_435_1:FormatText(var_438_14.content)

				arg_435_1.text_.text = var_438_15

				LuaForUtil.ClearLinePrefixSymbol(arg_435_1.text_)

				local var_438_16 = 25
				local var_438_17 = utf8.len(var_438_15)
				local var_438_18 = var_438_16 <= 0 and var_438_12 or var_438_12 * (var_438_17 / var_438_16)

				if var_438_18 > 0 and var_438_12 < var_438_18 then
					arg_435_1.talkMaxDuration = var_438_18

					if var_438_18 + var_438_11 > arg_435_1.duration_ then
						arg_435_1.duration_ = var_438_18 + var_438_11
					end
				end

				arg_435_1.text_.text = var_438_15
				arg_435_1.typewritter.percent = 0

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311108", "story_v_out_115311.awb") ~= 0 then
					local var_438_19 = manager.audio:GetVoiceLength("story_v_out_115311", "115311108", "story_v_out_115311.awb") / 1000

					if var_438_19 + var_438_11 > arg_435_1.duration_ then
						arg_435_1.duration_ = var_438_19 + var_438_11
					end

					if var_438_14.prefab_name ~= "" and arg_435_1.actors_[var_438_14.prefab_name] ~= nil then
						local var_438_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_435_1.actors_[var_438_14.prefab_name].transform, "story_v_out_115311", "115311108", "story_v_out_115311.awb")

						arg_435_1:RecordAudio("115311108", var_438_20)
						arg_435_1:RecordAudio("115311108", var_438_20)
					else
						arg_435_1:AudioAction("play", "voice", "story_v_out_115311", "115311108", "story_v_out_115311.awb")
					end

					arg_435_1:RecordHistoryTalkVoice("story_v_out_115311", "115311108", "story_v_out_115311.awb")
				end

				arg_435_1:RecordContent(arg_435_1.text_.text)
			end

			local var_438_21 = math.max(var_438_12, arg_435_1.talkMaxDuration)

			if var_438_11 <= arg_435_1.time_ and arg_435_1.time_ < var_438_11 + var_438_21 then
				arg_435_1.typewritter.percent = (arg_435_1.time_ - var_438_11) / var_438_21

				arg_435_1.typewritter:SetDirty()
			end

			if arg_435_1.time_ >= var_438_11 + var_438_21 and arg_435_1.time_ < var_438_11 + var_438_21 + arg_438_0 then
				arg_435_1.typewritter.percent = 1

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(true)
			end
		end

		arg_435_1.nodeConfigList_ = {}

		arg_435_1:InitPlayNodeList()
	end,
	Play115311109 = function(arg_439_0, arg_439_1)
		arg_439_1.time_ = 0
		arg_439_1.frameCnt_ = 0
		arg_439_1.state_ = "playing"
		arg_439_1.curTalkId_ = 115311109
		arg_439_1.duration_ = 15.6

		local var_439_0 = {
			ja = 15.6,
			ko = 9.866,
			zh = 10.566,
			en = 10.666
		}
		local var_439_1 = manager.audio:GetLocalizationFlag()

		if var_439_0[var_439_1] ~= nil then
			arg_439_1.duration_ = var_439_0[var_439_1]
		end

		SetActive(arg_439_1.tipsGo_, false)

		function arg_439_1.onSingleLineFinish_()
			arg_439_1.onSingleLineUpdate_ = nil
			arg_439_1.onSingleLineFinish_ = nil
			arg_439_1.state_ = "waiting"
		end

		function arg_439_1.playNext_(arg_441_0)
			if arg_441_0 == 1 then
				arg_439_0:Play115311110(arg_439_1)
			end
		end

		function arg_439_1.onSingleLineUpdate_(arg_442_0)
			local var_442_0 = 0
			local var_442_1 = 0.9

			if var_442_0 < arg_439_1.time_ and arg_439_1.time_ <= var_442_0 + arg_442_0 then
				arg_439_1.talkMaxDuration = 0
				arg_439_1.dialogCg_.alpha = 1

				arg_439_1.dialog_:SetActive(true)
				SetActive(arg_439_1.leftNameGo_, true)

				local var_442_2 = arg_439_1:FormatText(StoryNameCfg[94].name)

				arg_439_1.leftNameTxt_.text = var_442_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_439_1.leftNameTxt_.transform)

				arg_439_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_439_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_439_1:RecordName(arg_439_1.leftNameTxt_.text)
				SetActive(arg_439_1.iconTrs_.gameObject, false)
				arg_439_1.callingController_:SetSelectedState("normal")

				local var_442_3 = arg_439_1:GetWordFromCfg(115311109)
				local var_442_4 = arg_439_1:FormatText(var_442_3.content)

				arg_439_1.text_.text = var_442_4

				LuaForUtil.ClearLinePrefixSymbol(arg_439_1.text_)

				local var_442_5 = 36
				local var_442_6 = utf8.len(var_442_4)
				local var_442_7 = var_442_5 <= 0 and var_442_1 or var_442_1 * (var_442_6 / var_442_5)

				if var_442_7 > 0 and var_442_1 < var_442_7 then
					arg_439_1.talkMaxDuration = var_442_7

					if var_442_7 + var_442_0 > arg_439_1.duration_ then
						arg_439_1.duration_ = var_442_7 + var_442_0
					end
				end

				arg_439_1.text_.text = var_442_4
				arg_439_1.typewritter.percent = 0

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311109", "story_v_out_115311.awb") ~= 0 then
					local var_442_8 = manager.audio:GetVoiceLength("story_v_out_115311", "115311109", "story_v_out_115311.awb") / 1000

					if var_442_8 + var_442_0 > arg_439_1.duration_ then
						arg_439_1.duration_ = var_442_8 + var_442_0
					end

					if var_442_3.prefab_name ~= "" and arg_439_1.actors_[var_442_3.prefab_name] ~= nil then
						local var_442_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_439_1.actors_[var_442_3.prefab_name].transform, "story_v_out_115311", "115311109", "story_v_out_115311.awb")

						arg_439_1:RecordAudio("115311109", var_442_9)
						arg_439_1:RecordAudio("115311109", var_442_9)
					else
						arg_439_1:AudioAction("play", "voice", "story_v_out_115311", "115311109", "story_v_out_115311.awb")
					end

					arg_439_1:RecordHistoryTalkVoice("story_v_out_115311", "115311109", "story_v_out_115311.awb")
				end

				arg_439_1:RecordContent(arg_439_1.text_.text)
			end

			local var_442_10 = math.max(var_442_1, arg_439_1.talkMaxDuration)

			if var_442_0 <= arg_439_1.time_ and arg_439_1.time_ < var_442_0 + var_442_10 then
				arg_439_1.typewritter.percent = (arg_439_1.time_ - var_442_0) / var_442_10

				arg_439_1.typewritter:SetDirty()
			end

			if arg_439_1.time_ >= var_442_0 + var_442_10 and arg_439_1.time_ < var_442_0 + var_442_10 + arg_442_0 then
				arg_439_1.typewritter.percent = 1

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(true)
			end
		end

		arg_439_1.nodeConfigList_ = {}

		arg_439_1:InitPlayNodeList()
	end,
	Play115311110 = function(arg_443_0, arg_443_1)
		arg_443_1.time_ = 0
		arg_443_1.frameCnt_ = 0
		arg_443_1.state_ = "playing"
		arg_443_1.curTalkId_ = 115311110
		arg_443_1.duration_ = 6.1

		local var_443_0 = {
			ja = 5.3,
			ko = 5.766,
			zh = 6.1,
			en = 5.766
		}
		local var_443_1 = manager.audio:GetLocalizationFlag()

		if var_443_0[var_443_1] ~= nil then
			arg_443_1.duration_ = var_443_0[var_443_1]
		end

		SetActive(arg_443_1.tipsGo_, false)

		function arg_443_1.onSingleLineFinish_()
			arg_443_1.onSingleLineUpdate_ = nil
			arg_443_1.onSingleLineFinish_ = nil
			arg_443_1.state_ = "waiting"
		end

		function arg_443_1.playNext_(arg_445_0)
			if arg_445_0 == 1 then
				arg_443_0:Play115311111(arg_443_1)
			end
		end

		function arg_443_1.onSingleLineUpdate_(arg_446_0)
			local var_446_0 = 2

			if var_446_0 < arg_443_1.time_ and arg_443_1.time_ <= var_446_0 + arg_446_0 then
				local var_446_1 = manager.ui.mainCamera.transform.localPosition
				local var_446_2 = Vector3.New(0, 0, 10) + Vector3.New(var_446_1.x, var_446_1.y, 0)
				local var_446_3 = arg_443_1.bgs_.ST22a

				var_446_3.transform.localPosition = var_446_2
				var_446_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_446_4 = var_446_3:GetComponent("SpriteRenderer")

				if var_446_4 and var_446_4.sprite then
					local var_446_5 = (var_446_3.transform.localPosition - var_446_1).z
					local var_446_6 = manager.ui.mainCameraCom_
					local var_446_7 = 2 * var_446_5 * Mathf.Tan(var_446_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_446_8 = var_446_7 * var_446_6.aspect
					local var_446_9 = var_446_4.sprite.bounds.size.x
					local var_446_10 = var_446_4.sprite.bounds.size.y
					local var_446_11 = var_446_8 / var_446_9
					local var_446_12 = var_446_7 / var_446_10
					local var_446_13 = var_446_12 < var_446_11 and var_446_11 or var_446_12

					var_446_3.transform.localScale = Vector3.New(var_446_13, var_446_13, 0)
				end

				for iter_446_0, iter_446_1 in pairs(arg_443_1.bgs_) do
					if iter_446_0 ~= "ST22a" then
						iter_446_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_446_14 = 0

			if var_446_14 < arg_443_1.time_ and arg_443_1.time_ <= var_446_14 + arg_446_0 then
				arg_443_1.mask_.enabled = true
				arg_443_1.mask_.raycastTarget = true

				arg_443_1:SetGaussion(false)
			end

			local var_446_15 = 2

			if var_446_14 <= arg_443_1.time_ and arg_443_1.time_ < var_446_14 + var_446_15 then
				local var_446_16 = (arg_443_1.time_ - var_446_14) / var_446_15
				local var_446_17 = Color.New(0, 0, 0)

				var_446_17.a = Mathf.Lerp(0, 1, var_446_16)
				arg_443_1.mask_.color = var_446_17
			end

			if arg_443_1.time_ >= var_446_14 + var_446_15 and arg_443_1.time_ < var_446_14 + var_446_15 + arg_446_0 then
				local var_446_18 = Color.New(0, 0, 0)

				var_446_18.a = 1
				arg_443_1.mask_.color = var_446_18
			end

			local var_446_19 = 2

			if var_446_19 < arg_443_1.time_ and arg_443_1.time_ <= var_446_19 + arg_446_0 then
				arg_443_1.mask_.enabled = true
				arg_443_1.mask_.raycastTarget = true

				arg_443_1:SetGaussion(false)
			end

			local var_446_20 = 2

			if var_446_19 <= arg_443_1.time_ and arg_443_1.time_ < var_446_19 + var_446_20 then
				local var_446_21 = (arg_443_1.time_ - var_446_19) / var_446_20
				local var_446_22 = Color.New(0, 0, 0)

				var_446_22.a = Mathf.Lerp(1, 0, var_446_21)
				arg_443_1.mask_.color = var_446_22
			end

			if arg_443_1.time_ >= var_446_19 + var_446_20 and arg_443_1.time_ < var_446_19 + var_446_20 + arg_446_0 then
				local var_446_23 = Color.New(0, 0, 0)
				local var_446_24 = 0

				arg_443_1.mask_.enabled = false
				var_446_23.a = var_446_24
				arg_443_1.mask_.color = var_446_23
			end

			local var_446_25 = arg_443_1.actors_["113801_1"].transform
			local var_446_26 = 1.966

			if var_446_26 < arg_443_1.time_ and arg_443_1.time_ <= var_446_26 + arg_446_0 then
				arg_443_1.var_.moveOldPos113801_1 = var_446_25.localPosition
				var_446_25.localScale = Vector3.New(1, 1, 1)

				arg_443_1:CheckSpriteTmpPos("113801_1", 7)
			end

			local var_446_27 = 0.001

			if var_446_26 <= arg_443_1.time_ and arg_443_1.time_ < var_446_26 + var_446_27 then
				local var_446_28 = (arg_443_1.time_ - var_446_26) / var_446_27
				local var_446_29 = Vector3.New(0, -2000, -370)

				var_446_25.localPosition = Vector3.Lerp(arg_443_1.var_.moveOldPos113801_1, var_446_29, var_446_28)
			end

			if arg_443_1.time_ >= var_446_26 + var_446_27 and arg_443_1.time_ < var_446_26 + var_446_27 + arg_446_0 then
				var_446_25.localPosition = Vector3.New(0, -2000, -370)
			end

			local var_446_30 = arg_443_1.actors_["10029"].transform
			local var_446_31 = 1.966

			if var_446_31 < arg_443_1.time_ and arg_443_1.time_ <= var_446_31 + arg_446_0 then
				arg_443_1.var_.moveOldPos10029 = var_446_30.localPosition
				var_446_30.localScale = Vector3.New(1, 1, 1)

				arg_443_1:CheckSpriteTmpPos("10029", 7)
			end

			local var_446_32 = 0.001

			if var_446_31 <= arg_443_1.time_ and arg_443_1.time_ < var_446_31 + var_446_32 then
				local var_446_33 = (arg_443_1.time_ - var_446_31) / var_446_32
				local var_446_34 = Vector3.New(0, -2000, -180)

				var_446_30.localPosition = Vector3.Lerp(arg_443_1.var_.moveOldPos10029, var_446_34, var_446_33)
			end

			if arg_443_1.time_ >= var_446_31 + var_446_32 and arg_443_1.time_ < var_446_31 + var_446_32 + arg_446_0 then
				var_446_30.localPosition = Vector3.New(0, -2000, -180)
			end

			local var_446_35 = arg_443_1.actors_["10030"].transform
			local var_446_36 = 3.8

			if var_446_36 < arg_443_1.time_ and arg_443_1.time_ <= var_446_36 + arg_446_0 then
				arg_443_1.var_.moveOldPos10030 = var_446_35.localPosition
				var_446_35.localScale = Vector3.New(1, 1, 1)

				arg_443_1:CheckSpriteTmpPos("10030", 3)

				local var_446_37 = var_446_35.childCount

				for iter_446_2 = 0, var_446_37 - 1 do
					local var_446_38 = var_446_35:GetChild(iter_446_2)

					if var_446_38.name == "split_2" or not string.find(var_446_38.name, "split") then
						var_446_38.gameObject:SetActive(true)
					else
						var_446_38.gameObject:SetActive(false)
					end
				end
			end

			local var_446_39 = 0.001

			if var_446_36 <= arg_443_1.time_ and arg_443_1.time_ < var_446_36 + var_446_39 then
				local var_446_40 = (arg_443_1.time_ - var_446_36) / var_446_39
				local var_446_41 = Vector3.New(0, -390, 150)

				var_446_35.localPosition = Vector3.Lerp(arg_443_1.var_.moveOldPos10030, var_446_41, var_446_40)
			end

			if arg_443_1.time_ >= var_446_36 + var_446_39 and arg_443_1.time_ < var_446_36 + var_446_39 + arg_446_0 then
				var_446_35.localPosition = Vector3.New(0, -390, 150)
			end

			local var_446_42 = arg_443_1.actors_["10030"]
			local var_446_43 = 3.8

			if var_446_43 < arg_443_1.time_ and arg_443_1.time_ <= var_446_43 + arg_446_0 then
				local var_446_44 = var_446_42:GetComponentInChildren(typeof(CanvasGroup))

				if var_446_44 then
					arg_443_1.var_.alphaOldValue10030 = var_446_44.alpha
					arg_443_1.var_.characterEffect10030 = var_446_44
				end

				arg_443_1.var_.alphaOldValue10030 = 0
			end

			local var_446_45 = 0.5

			if var_446_43 <= arg_443_1.time_ and arg_443_1.time_ < var_446_43 + var_446_45 then
				local var_446_46 = (arg_443_1.time_ - var_446_43) / var_446_45
				local var_446_47 = Mathf.Lerp(arg_443_1.var_.alphaOldValue10030, 1, var_446_46)

				if arg_443_1.var_.characterEffect10030 then
					arg_443_1.var_.characterEffect10030.alpha = var_446_47
				end
			end

			if arg_443_1.time_ >= var_446_43 + var_446_45 and arg_443_1.time_ < var_446_43 + var_446_45 + arg_446_0 and arg_443_1.var_.characterEffect10030 then
				arg_443_1.var_.characterEffect10030.alpha = 1
			end

			local var_446_48 = arg_443_1.actors_["10030"]
			local var_446_49 = 3.8

			if var_446_49 < arg_443_1.time_ and arg_443_1.time_ <= var_446_49 + arg_446_0 and not isNil(var_446_48) and arg_443_1.var_.actorSpriteComps10030 == nil then
				arg_443_1.var_.actorSpriteComps10030 = var_446_48:GetComponentsInChildren(typeof(Image), true)
			end

			local var_446_50 = 0.2

			if var_446_49 <= arg_443_1.time_ and arg_443_1.time_ < var_446_49 + var_446_50 and not isNil(var_446_48) then
				local var_446_51 = (arg_443_1.time_ - var_446_49) / var_446_50

				if arg_443_1.var_.actorSpriteComps10030 then
					for iter_446_3, iter_446_4 in pairs(arg_443_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_446_4 then
							if arg_443_1.isInRecall_ then
								local var_446_52 = Mathf.Lerp(iter_446_4.color.r, arg_443_1.hightColor1.r, var_446_51)
								local var_446_53 = Mathf.Lerp(iter_446_4.color.g, arg_443_1.hightColor1.g, var_446_51)
								local var_446_54 = Mathf.Lerp(iter_446_4.color.b, arg_443_1.hightColor1.b, var_446_51)

								iter_446_4.color = Color.New(var_446_52, var_446_53, var_446_54)
							else
								local var_446_55 = Mathf.Lerp(iter_446_4.color.r, 1, var_446_51)

								iter_446_4.color = Color.New(var_446_55, var_446_55, var_446_55)
							end
						end
					end
				end
			end

			if arg_443_1.time_ >= var_446_49 + var_446_50 and arg_443_1.time_ < var_446_49 + var_446_50 + arg_446_0 and not isNil(var_446_48) and arg_443_1.var_.actorSpriteComps10030 then
				for iter_446_5, iter_446_6 in pairs(arg_443_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_446_6 then
						if arg_443_1.isInRecall_ then
							iter_446_6.color = arg_443_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_446_6.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_443_1.var_.actorSpriteComps10030 = nil
			end

			if arg_443_1.frameCnt_ <= 1 then
				arg_443_1.dialog_:SetActive(false)
			end

			local var_446_56 = 4
			local var_446_57 = 0.15

			if var_446_56 < arg_443_1.time_ and arg_443_1.time_ <= var_446_56 + arg_446_0 then
				arg_443_1.talkMaxDuration = 0

				arg_443_1.dialog_:SetActive(true)

				arg_443_1.dialogCg_.alpha = 0

				local var_446_58 = LeanTween.value(arg_443_1.dialog_, 0, 1, 0.3)

				var_446_58:setOnUpdate(LuaHelper.FloatAction(function(arg_447_0)
					arg_443_1.dialogCg_.alpha = arg_447_0
				end))
				var_446_58:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_443_1.dialog_)
					var_446_58:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_443_1.duration_ = arg_443_1.duration_ + 0.3

				SetActive(arg_443_1.leftNameGo_, true)

				local var_446_59 = arg_443_1:FormatText(StoryNameCfg[309].name)

				arg_443_1.leftNameTxt_.text = var_446_59

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_443_1.leftNameTxt_.transform)

				arg_443_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_443_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_443_1:RecordName(arg_443_1.leftNameTxt_.text)
				SetActive(arg_443_1.iconTrs_.gameObject, false)
				arg_443_1.callingController_:SetSelectedState("normal")

				local var_446_60 = arg_443_1:GetWordFromCfg(115311110)
				local var_446_61 = arg_443_1:FormatText(var_446_60.content)

				arg_443_1.text_.text = var_446_61

				LuaForUtil.ClearLinePrefixSymbol(arg_443_1.text_)

				local var_446_62 = 6
				local var_446_63 = utf8.len(var_446_61)
				local var_446_64 = var_446_62 <= 0 and var_446_57 or var_446_57 * (var_446_63 / var_446_62)

				if var_446_64 > 0 and var_446_57 < var_446_64 then
					arg_443_1.talkMaxDuration = var_446_64
					var_446_56 = var_446_56 + 0.3

					if var_446_64 + var_446_56 > arg_443_1.duration_ then
						arg_443_1.duration_ = var_446_64 + var_446_56
					end
				end

				arg_443_1.text_.text = var_446_61
				arg_443_1.typewritter.percent = 0

				arg_443_1.typewritter:SetDirty()
				arg_443_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311110", "story_v_out_115311.awb") ~= 0 then
					local var_446_65 = manager.audio:GetVoiceLength("story_v_out_115311", "115311110", "story_v_out_115311.awb") / 1000

					if var_446_65 + var_446_56 > arg_443_1.duration_ then
						arg_443_1.duration_ = var_446_65 + var_446_56
					end

					if var_446_60.prefab_name ~= "" and arg_443_1.actors_[var_446_60.prefab_name] ~= nil then
						local var_446_66 = LuaForUtil.PlayVoiceWithCriLipsync(arg_443_1.actors_[var_446_60.prefab_name].transform, "story_v_out_115311", "115311110", "story_v_out_115311.awb")

						arg_443_1:RecordAudio("115311110", var_446_66)
						arg_443_1:RecordAudio("115311110", var_446_66)
					else
						arg_443_1:AudioAction("play", "voice", "story_v_out_115311", "115311110", "story_v_out_115311.awb")
					end

					arg_443_1:RecordHistoryTalkVoice("story_v_out_115311", "115311110", "story_v_out_115311.awb")
				end

				arg_443_1:RecordContent(arg_443_1.text_.text)
			end

			local var_446_67 = var_446_56 + 0.3
			local var_446_68 = math.max(var_446_57, arg_443_1.talkMaxDuration)

			if var_446_67 <= arg_443_1.time_ and arg_443_1.time_ < var_446_67 + var_446_68 then
				arg_443_1.typewritter.percent = (arg_443_1.time_ - var_446_67) / var_446_68

				arg_443_1.typewritter:SetDirty()
			end

			if arg_443_1.time_ >= var_446_67 + var_446_68 and arg_443_1.time_ < var_446_67 + var_446_68 + arg_446_0 then
				arg_443_1.typewritter.percent = 1

				arg_443_1.typewritter:SetDirty()
				arg_443_1:ShowNextGo(true)
			end
		end

		arg_443_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "113801_1",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Sprite
			},
			{
				assetPath = "",
				actorName = "10029",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Sprite
			},
			{
				assetPath = "",
				actorName = "10030",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_443_1:InitPlayNodeList()
	end,
	Play115311111 = function(arg_449_0, arg_449_1)
		arg_449_1.time_ = 0
		arg_449_1.frameCnt_ = 0
		arg_449_1.state_ = "playing"
		arg_449_1.curTalkId_ = 115311111
		arg_449_1.duration_ = 5

		SetActive(arg_449_1.tipsGo_, false)

		function arg_449_1.onSingleLineFinish_()
			arg_449_1.onSingleLineUpdate_ = nil
			arg_449_1.onSingleLineFinish_ = nil
			arg_449_1.state_ = "waiting"
		end

		function arg_449_1.playNext_(arg_451_0)
			if arg_451_0 == 1 then
				arg_449_0:Play115311112(arg_449_1)
			end
		end

		function arg_449_1.onSingleLineUpdate_(arg_452_0)
			local var_452_0 = arg_449_1.actors_["10030"]
			local var_452_1 = 0

			if var_452_1 < arg_449_1.time_ and arg_449_1.time_ <= var_452_1 + arg_452_0 then
				local var_452_2 = var_452_0:GetComponentInChildren(typeof(CanvasGroup))

				if var_452_2 then
					arg_449_1.var_.alphaOldValue10030 = var_452_2.alpha
					arg_449_1.var_.characterEffect10030 = var_452_2
				end

				arg_449_1.var_.alphaOldValue10030 = 1
			end

			local var_452_3 = 0.5

			if var_452_1 <= arg_449_1.time_ and arg_449_1.time_ < var_452_1 + var_452_3 then
				local var_452_4 = (arg_449_1.time_ - var_452_1) / var_452_3
				local var_452_5 = Mathf.Lerp(arg_449_1.var_.alphaOldValue10030, 0, var_452_4)

				if arg_449_1.var_.characterEffect10030 then
					arg_449_1.var_.characterEffect10030.alpha = var_452_5
				end
			end

			if arg_449_1.time_ >= var_452_1 + var_452_3 and arg_449_1.time_ < var_452_1 + var_452_3 + arg_452_0 and arg_449_1.var_.characterEffect10030 then
				arg_449_1.var_.characterEffect10030.alpha = 0
			end

			local var_452_6 = 0
			local var_452_7 = 1.15

			if var_452_6 < arg_449_1.time_ and arg_449_1.time_ <= var_452_6 + arg_452_0 then
				arg_449_1.talkMaxDuration = 0
				arg_449_1.dialogCg_.alpha = 1

				arg_449_1.dialog_:SetActive(true)
				SetActive(arg_449_1.leftNameGo_, false)

				arg_449_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_449_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_449_1:RecordName(arg_449_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_449_1.iconTrs_.gameObject, false)
				arg_449_1.callingController_:SetSelectedState("normal")

				local var_452_8 = arg_449_1:GetWordFromCfg(115311111)
				local var_452_9 = arg_449_1:FormatText(var_452_8.content)

				arg_449_1.text_.text = var_452_9

				LuaForUtil.ClearLinePrefixSymbol(arg_449_1.text_)

				local var_452_10 = 46
				local var_452_11 = utf8.len(var_452_9)
				local var_452_12 = var_452_10 <= 0 and var_452_7 or var_452_7 * (var_452_11 / var_452_10)

				if var_452_12 > 0 and var_452_7 < var_452_12 then
					arg_449_1.talkMaxDuration = var_452_12

					if var_452_12 + var_452_6 > arg_449_1.duration_ then
						arg_449_1.duration_ = var_452_12 + var_452_6
					end
				end

				arg_449_1.text_.text = var_452_9
				arg_449_1.typewritter.percent = 0

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(false)
				arg_449_1:RecordContent(arg_449_1.text_.text)
			end

			local var_452_13 = math.max(var_452_7, arg_449_1.talkMaxDuration)

			if var_452_6 <= arg_449_1.time_ and arg_449_1.time_ < var_452_6 + var_452_13 then
				arg_449_1.typewritter.percent = (arg_449_1.time_ - var_452_6) / var_452_13

				arg_449_1.typewritter:SetDirty()
			end

			if arg_449_1.time_ >= var_452_6 + var_452_13 and arg_449_1.time_ < var_452_6 + var_452_13 + arg_452_0 then
				arg_449_1.typewritter.percent = 1

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(true)
			end
		end

		arg_449_1.nodeConfigList_ = {}

		arg_449_1:InitPlayNodeList()
	end,
	Play115311112 = function(arg_453_0, arg_453_1)
		arg_453_1.time_ = 0
		arg_453_1.frameCnt_ = 0
		arg_453_1.state_ = "playing"
		arg_453_1.curTalkId_ = 115311112
		arg_453_1.duration_ = 5

		SetActive(arg_453_1.tipsGo_, false)

		function arg_453_1.onSingleLineFinish_()
			arg_453_1.onSingleLineUpdate_ = nil
			arg_453_1.onSingleLineFinish_ = nil
			arg_453_1.state_ = "waiting"
		end

		function arg_453_1.playNext_(arg_455_0)
			if arg_455_0 == 1 then
				arg_453_0:Play115311113(arg_453_1)
			end
		end

		function arg_453_1.onSingleLineUpdate_(arg_456_0)
			local var_456_0 = 0
			local var_456_1 = 1

			if var_456_0 < arg_453_1.time_ and arg_453_1.time_ <= var_456_0 + arg_456_0 then
				arg_453_1.talkMaxDuration = 0
				arg_453_1.dialogCg_.alpha = 1

				arg_453_1.dialog_:SetActive(true)
				SetActive(arg_453_1.leftNameGo_, false)

				arg_453_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_453_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_453_1:RecordName(arg_453_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_453_1.iconTrs_.gameObject, false)
				arg_453_1.callingController_:SetSelectedState("normal")

				local var_456_2 = arg_453_1:GetWordFromCfg(115311112)
				local var_456_3 = arg_453_1:FormatText(var_456_2.content)

				arg_453_1.text_.text = var_456_3

				LuaForUtil.ClearLinePrefixSymbol(arg_453_1.text_)

				local var_456_4 = 40
				local var_456_5 = utf8.len(var_456_3)
				local var_456_6 = var_456_4 <= 0 and var_456_1 or var_456_1 * (var_456_5 / var_456_4)

				if var_456_6 > 0 and var_456_1 < var_456_6 then
					arg_453_1.talkMaxDuration = var_456_6

					if var_456_6 + var_456_0 > arg_453_1.duration_ then
						arg_453_1.duration_ = var_456_6 + var_456_0
					end
				end

				arg_453_1.text_.text = var_456_3
				arg_453_1.typewritter.percent = 0

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(false)
				arg_453_1:RecordContent(arg_453_1.text_.text)
			end

			local var_456_7 = math.max(var_456_1, arg_453_1.talkMaxDuration)

			if var_456_0 <= arg_453_1.time_ and arg_453_1.time_ < var_456_0 + var_456_7 then
				arg_453_1.typewritter.percent = (arg_453_1.time_ - var_456_0) / var_456_7

				arg_453_1.typewritter:SetDirty()
			end

			if arg_453_1.time_ >= var_456_0 + var_456_7 and arg_453_1.time_ < var_456_0 + var_456_7 + arg_456_0 then
				arg_453_1.typewritter.percent = 1

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(true)
			end
		end

		arg_453_1.nodeConfigList_ = {}

		arg_453_1:InitPlayNodeList()
	end,
	Play115311113 = function(arg_457_0, arg_457_1)
		arg_457_1.time_ = 0
		arg_457_1.frameCnt_ = 0
		arg_457_1.state_ = "playing"
		arg_457_1.curTalkId_ = 115311113
		arg_457_1.duration_ = 5

		SetActive(arg_457_1.tipsGo_, false)

		function arg_457_1.onSingleLineFinish_()
			arg_457_1.onSingleLineUpdate_ = nil
			arg_457_1.onSingleLineFinish_ = nil
			arg_457_1.state_ = "waiting"
		end

		function arg_457_1.playNext_(arg_459_0)
			if arg_459_0 == 1 then
				arg_457_0:Play115311114(arg_457_1)
			end
		end

		function arg_457_1.onSingleLineUpdate_(arg_460_0)
			local var_460_0 = 0
			local var_460_1 = 0.65

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

				local var_460_2 = arg_457_1:GetWordFromCfg(115311113)
				local var_460_3 = arg_457_1:FormatText(var_460_2.content)

				arg_457_1.text_.text = var_460_3

				LuaForUtil.ClearLinePrefixSymbol(arg_457_1.text_)

				local var_460_4 = 26
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
	Play115311114 = function(arg_461_0, arg_461_1)
		arg_461_1.time_ = 0
		arg_461_1.frameCnt_ = 0
		arg_461_1.state_ = "playing"
		arg_461_1.curTalkId_ = 115311114
		arg_461_1.duration_ = 5.1

		local var_461_0 = {
			ja = 5,
			ko = 4.033,
			zh = 5.1,
			en = 4.233
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
				arg_461_0:Play115311115(arg_461_1)
			end
		end

		function arg_461_1.onSingleLineUpdate_(arg_464_0)
			local var_464_0 = arg_461_1.actors_["10030"]
			local var_464_1 = 0

			if var_464_1 < arg_461_1.time_ and arg_461_1.time_ <= var_464_1 + arg_464_0 then
				local var_464_2 = var_464_0:GetComponentInChildren(typeof(CanvasGroup))

				if var_464_2 then
					arg_461_1.var_.alphaOldValue10030 = var_464_2.alpha
					arg_461_1.var_.characterEffect10030 = var_464_2
				end

				arg_461_1.var_.alphaOldValue10030 = 0
			end

			local var_464_3 = 0.5

			if var_464_1 <= arg_461_1.time_ and arg_461_1.time_ < var_464_1 + var_464_3 then
				local var_464_4 = (arg_461_1.time_ - var_464_1) / var_464_3
				local var_464_5 = Mathf.Lerp(arg_461_1.var_.alphaOldValue10030, 1, var_464_4)

				if arg_461_1.var_.characterEffect10030 then
					arg_461_1.var_.characterEffect10030.alpha = var_464_5
				end
			end

			if arg_461_1.time_ >= var_464_1 + var_464_3 and arg_461_1.time_ < var_464_1 + var_464_3 + arg_464_0 and arg_461_1.var_.characterEffect10030 then
				arg_461_1.var_.characterEffect10030.alpha = 1
			end

			local var_464_6 = arg_461_1.actors_["10030"]
			local var_464_7 = 0

			if var_464_7 < arg_461_1.time_ and arg_461_1.time_ <= var_464_7 + arg_464_0 and not isNil(var_464_6) and arg_461_1.var_.actorSpriteComps10030 == nil then
				arg_461_1.var_.actorSpriteComps10030 = var_464_6:GetComponentsInChildren(typeof(Image), true)
			end

			local var_464_8 = 0.2

			if var_464_7 <= arg_461_1.time_ and arg_461_1.time_ < var_464_7 + var_464_8 and not isNil(var_464_6) then
				local var_464_9 = (arg_461_1.time_ - var_464_7) / var_464_8

				if arg_461_1.var_.actorSpriteComps10030 then
					for iter_464_0, iter_464_1 in pairs(arg_461_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_464_1 then
							if arg_461_1.isInRecall_ then
								local var_464_10 = Mathf.Lerp(iter_464_1.color.r, arg_461_1.hightColor1.r, var_464_9)
								local var_464_11 = Mathf.Lerp(iter_464_1.color.g, arg_461_1.hightColor1.g, var_464_9)
								local var_464_12 = Mathf.Lerp(iter_464_1.color.b, arg_461_1.hightColor1.b, var_464_9)

								iter_464_1.color = Color.New(var_464_10, var_464_11, var_464_12)
							else
								local var_464_13 = Mathf.Lerp(iter_464_1.color.r, 1, var_464_9)

								iter_464_1.color = Color.New(var_464_13, var_464_13, var_464_13)
							end
						end
					end
				end
			end

			if arg_461_1.time_ >= var_464_7 + var_464_8 and arg_461_1.time_ < var_464_7 + var_464_8 + arg_464_0 and not isNil(var_464_6) and arg_461_1.var_.actorSpriteComps10030 then
				for iter_464_2, iter_464_3 in pairs(arg_461_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_464_3 then
						if arg_461_1.isInRecall_ then
							iter_464_3.color = arg_461_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_464_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_461_1.var_.actorSpriteComps10030 = nil
			end

			local var_464_14 = arg_461_1.actors_["10030"].transform
			local var_464_15 = 0

			if var_464_15 < arg_461_1.time_ and arg_461_1.time_ <= var_464_15 + arg_464_0 then
				arg_461_1.var_.moveOldPos10030 = var_464_14.localPosition
				var_464_14.localScale = Vector3.New(1, 1, 1)

				arg_461_1:CheckSpriteTmpPos("10030", 3)

				local var_464_16 = var_464_14.childCount

				for iter_464_4 = 0, var_464_16 - 1 do
					local var_464_17 = var_464_14:GetChild(iter_464_4)

					if var_464_17.name == "split_1" or not string.find(var_464_17.name, "split") then
						var_464_17.gameObject:SetActive(true)
					else
						var_464_17.gameObject:SetActive(false)
					end
				end
			end

			local var_464_18 = 0.001

			if var_464_15 <= arg_461_1.time_ and arg_461_1.time_ < var_464_15 + var_464_18 then
				local var_464_19 = (arg_461_1.time_ - var_464_15) / var_464_18
				local var_464_20 = Vector3.New(0, -390, 150)

				var_464_14.localPosition = Vector3.Lerp(arg_461_1.var_.moveOldPos10030, var_464_20, var_464_19)
			end

			if arg_461_1.time_ >= var_464_15 + var_464_18 and arg_461_1.time_ < var_464_15 + var_464_18 + arg_464_0 then
				var_464_14.localPosition = Vector3.New(0, -390, 150)
			end

			local var_464_21 = 0
			local var_464_22 = 0.375

			if var_464_21 < arg_461_1.time_ and arg_461_1.time_ <= var_464_21 + arg_464_0 then
				arg_461_1.talkMaxDuration = 0
				arg_461_1.dialogCg_.alpha = 1

				arg_461_1.dialog_:SetActive(true)
				SetActive(arg_461_1.leftNameGo_, true)

				local var_464_23 = arg_461_1:FormatText(StoryNameCfg[309].name)

				arg_461_1.leftNameTxt_.text = var_464_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_461_1.leftNameTxt_.transform)

				arg_461_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_461_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_461_1:RecordName(arg_461_1.leftNameTxt_.text)
				SetActive(arg_461_1.iconTrs_.gameObject, false)
				arg_461_1.callingController_:SetSelectedState("normal")

				local var_464_24 = arg_461_1:GetWordFromCfg(115311114)
				local var_464_25 = arg_461_1:FormatText(var_464_24.content)

				arg_461_1.text_.text = var_464_25

				LuaForUtil.ClearLinePrefixSymbol(arg_461_1.text_)

				local var_464_26 = 15
				local var_464_27 = utf8.len(var_464_25)
				local var_464_28 = var_464_26 <= 0 and var_464_22 or var_464_22 * (var_464_27 / var_464_26)

				if var_464_28 > 0 and var_464_22 < var_464_28 then
					arg_461_1.talkMaxDuration = var_464_28

					if var_464_28 + var_464_21 > arg_461_1.duration_ then
						arg_461_1.duration_ = var_464_28 + var_464_21
					end
				end

				arg_461_1.text_.text = var_464_25
				arg_461_1.typewritter.percent = 0

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311114", "story_v_out_115311.awb") ~= 0 then
					local var_464_29 = manager.audio:GetVoiceLength("story_v_out_115311", "115311114", "story_v_out_115311.awb") / 1000

					if var_464_29 + var_464_21 > arg_461_1.duration_ then
						arg_461_1.duration_ = var_464_29 + var_464_21
					end

					if var_464_24.prefab_name ~= "" and arg_461_1.actors_[var_464_24.prefab_name] ~= nil then
						local var_464_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_461_1.actors_[var_464_24.prefab_name].transform, "story_v_out_115311", "115311114", "story_v_out_115311.awb")

						arg_461_1:RecordAudio("115311114", var_464_30)
						arg_461_1:RecordAudio("115311114", var_464_30)
					else
						arg_461_1:AudioAction("play", "voice", "story_v_out_115311", "115311114", "story_v_out_115311.awb")
					end

					arg_461_1:RecordHistoryTalkVoice("story_v_out_115311", "115311114", "story_v_out_115311.awb")
				end

				arg_461_1:RecordContent(arg_461_1.text_.text)
			end

			local var_464_31 = math.max(var_464_22, arg_461_1.talkMaxDuration)

			if var_464_21 <= arg_461_1.time_ and arg_461_1.time_ < var_464_21 + var_464_31 then
				arg_461_1.typewritter.percent = (arg_461_1.time_ - var_464_21) / var_464_31

				arg_461_1.typewritter:SetDirty()
			end

			if arg_461_1.time_ >= var_464_21 + var_464_31 and arg_461_1.time_ < var_464_21 + var_464_31 + arg_464_0 then
				arg_461_1.typewritter.percent = 1

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(true)
			end
		end

		arg_461_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10030",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_461_1:InitPlayNodeList()
	end,
	Play115311115 = function(arg_465_0, arg_465_1)
		arg_465_1.time_ = 0
		arg_465_1.frameCnt_ = 0
		arg_465_1.state_ = "playing"
		arg_465_1.curTalkId_ = 115311115
		arg_465_1.duration_ = 5

		SetActive(arg_465_1.tipsGo_, false)

		function arg_465_1.onSingleLineFinish_()
			arg_465_1.onSingleLineUpdate_ = nil
			arg_465_1.onSingleLineFinish_ = nil
			arg_465_1.state_ = "waiting"
		end

		function arg_465_1.playNext_(arg_467_0)
			if arg_467_0 == 1 then
				arg_465_0:Play115311116(arg_465_1)
			end
		end

		function arg_465_1.onSingleLineUpdate_(arg_468_0)
			local var_468_0 = arg_465_1.actors_["10030"]
			local var_468_1 = 0

			if var_468_1 < arg_465_1.time_ and arg_465_1.time_ <= var_468_1 + arg_468_0 then
				local var_468_2 = var_468_0:GetComponentInChildren(typeof(CanvasGroup))

				if var_468_2 then
					arg_465_1.var_.alphaOldValue10030 = var_468_2.alpha
					arg_465_1.var_.characterEffect10030 = var_468_2
				end

				arg_465_1.var_.alphaOldValue10030 = 1
			end

			local var_468_3 = 0.5

			if var_468_1 <= arg_465_1.time_ and arg_465_1.time_ < var_468_1 + var_468_3 then
				local var_468_4 = (arg_465_1.time_ - var_468_1) / var_468_3
				local var_468_5 = Mathf.Lerp(arg_465_1.var_.alphaOldValue10030, 0, var_468_4)

				if arg_465_1.var_.characterEffect10030 then
					arg_465_1.var_.characterEffect10030.alpha = var_468_5
				end
			end

			if arg_465_1.time_ >= var_468_1 + var_468_3 and arg_465_1.time_ < var_468_1 + var_468_3 + arg_468_0 and arg_465_1.var_.characterEffect10030 then
				arg_465_1.var_.characterEffect10030.alpha = 0
			end

			local var_468_6 = 0
			local var_468_7 = 0.875

			if var_468_6 < arg_465_1.time_ and arg_465_1.time_ <= var_468_6 + arg_468_0 then
				arg_465_1.talkMaxDuration = 0
				arg_465_1.dialogCg_.alpha = 1

				arg_465_1.dialog_:SetActive(true)
				SetActive(arg_465_1.leftNameGo_, false)

				arg_465_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_465_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_465_1:RecordName(arg_465_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_465_1.iconTrs_.gameObject, false)
				arg_465_1.callingController_:SetSelectedState("normal")

				local var_468_8 = arg_465_1:GetWordFromCfg(115311115)
				local var_468_9 = arg_465_1:FormatText(var_468_8.content)

				arg_465_1.text_.text = var_468_9

				LuaForUtil.ClearLinePrefixSymbol(arg_465_1.text_)

				local var_468_10 = 35
				local var_468_11 = utf8.len(var_468_9)
				local var_468_12 = var_468_10 <= 0 and var_468_7 or var_468_7 * (var_468_11 / var_468_10)

				if var_468_12 > 0 and var_468_7 < var_468_12 then
					arg_465_1.talkMaxDuration = var_468_12

					if var_468_12 + var_468_6 > arg_465_1.duration_ then
						arg_465_1.duration_ = var_468_12 + var_468_6
					end
				end

				arg_465_1.text_.text = var_468_9
				arg_465_1.typewritter.percent = 0

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(false)
				arg_465_1:RecordContent(arg_465_1.text_.text)
			end

			local var_468_13 = math.max(var_468_7, arg_465_1.talkMaxDuration)

			if var_468_6 <= arg_465_1.time_ and arg_465_1.time_ < var_468_6 + var_468_13 then
				arg_465_1.typewritter.percent = (arg_465_1.time_ - var_468_6) / var_468_13

				arg_465_1.typewritter:SetDirty()
			end

			if arg_465_1.time_ >= var_468_6 + var_468_13 and arg_465_1.time_ < var_468_6 + var_468_13 + arg_468_0 then
				arg_465_1.typewritter.percent = 1

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(true)
			end
		end

		arg_465_1.nodeConfigList_ = {}

		arg_465_1:InitPlayNodeList()
	end,
	Play115311116 = function(arg_469_0, arg_469_1)
		arg_469_1.time_ = 0
		arg_469_1.frameCnt_ = 0
		arg_469_1.state_ = "playing"
		arg_469_1.curTalkId_ = 115311116
		arg_469_1.duration_ = 5

		SetActive(arg_469_1.tipsGo_, false)

		function arg_469_1.onSingleLineFinish_()
			arg_469_1.onSingleLineUpdate_ = nil
			arg_469_1.onSingleLineFinish_ = nil
			arg_469_1.state_ = "waiting"
		end

		function arg_469_1.playNext_(arg_471_0)
			if arg_471_0 == 1 then
				arg_469_0:Play115311117(arg_469_1)
			end
		end

		function arg_469_1.onSingleLineUpdate_(arg_472_0)
			local var_472_0 = 0
			local var_472_1 = 0.825

			if var_472_0 < arg_469_1.time_ and arg_469_1.time_ <= var_472_0 + arg_472_0 then
				arg_469_1.talkMaxDuration = 0
				arg_469_1.dialogCg_.alpha = 1

				arg_469_1.dialog_:SetActive(true)
				SetActive(arg_469_1.leftNameGo_, false)

				arg_469_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_469_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_469_1:RecordName(arg_469_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_469_1.iconTrs_.gameObject, false)
				arg_469_1.callingController_:SetSelectedState("normal")

				local var_472_2 = arg_469_1:GetWordFromCfg(115311116)
				local var_472_3 = arg_469_1:FormatText(var_472_2.content)

				arg_469_1.text_.text = var_472_3

				LuaForUtil.ClearLinePrefixSymbol(arg_469_1.text_)

				local var_472_4 = 33
				local var_472_5 = utf8.len(var_472_3)
				local var_472_6 = var_472_4 <= 0 and var_472_1 or var_472_1 * (var_472_5 / var_472_4)

				if var_472_6 > 0 and var_472_1 < var_472_6 then
					arg_469_1.talkMaxDuration = var_472_6

					if var_472_6 + var_472_0 > arg_469_1.duration_ then
						arg_469_1.duration_ = var_472_6 + var_472_0
					end
				end

				arg_469_1.text_.text = var_472_3
				arg_469_1.typewritter.percent = 0

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(false)
				arg_469_1:RecordContent(arg_469_1.text_.text)
			end

			local var_472_7 = math.max(var_472_1, arg_469_1.talkMaxDuration)

			if var_472_0 <= arg_469_1.time_ and arg_469_1.time_ < var_472_0 + var_472_7 then
				arg_469_1.typewritter.percent = (arg_469_1.time_ - var_472_0) / var_472_7

				arg_469_1.typewritter:SetDirty()
			end

			if arg_469_1.time_ >= var_472_0 + var_472_7 and arg_469_1.time_ < var_472_0 + var_472_7 + arg_472_0 then
				arg_469_1.typewritter.percent = 1

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(true)
			end
		end

		arg_469_1.nodeConfigList_ = {}

		arg_469_1:InitPlayNodeList()
	end,
	Play115311117 = function(arg_473_0, arg_473_1)
		arg_473_1.time_ = 0
		arg_473_1.frameCnt_ = 0
		arg_473_1.state_ = "playing"
		arg_473_1.curTalkId_ = 115311117
		arg_473_1.duration_ = 5.53

		SetActive(arg_473_1.tipsGo_, false)

		function arg_473_1.onSingleLineFinish_()
			arg_473_1.onSingleLineUpdate_ = nil
			arg_473_1.onSingleLineFinish_ = nil
			arg_473_1.state_ = "waiting"
		end

		function arg_473_1.playNext_(arg_475_0)
			if arg_475_0 == 1 then
				arg_473_0:Play115311118(arg_473_1)
			end
		end

		function arg_473_1.onSingleLineUpdate_(arg_476_0)
			local var_476_0 = arg_473_1.bgs_.ST22a.transform
			local var_476_1 = 0

			if var_476_1 < arg_473_1.time_ and arg_473_1.time_ <= var_476_1 + arg_476_0 then
				arg_473_1.var_.moveOldPosST22a = var_476_0.localPosition
			end

			local var_476_2 = 4.5

			if var_476_1 <= arg_473_1.time_ and arg_473_1.time_ < var_476_1 + var_476_2 then
				local var_476_3 = (arg_473_1.time_ - var_476_1) / var_476_2
				local var_476_4 = Vector3.New(0, 1, 9.5)

				var_476_0.localPosition = Vector3.Lerp(arg_473_1.var_.moveOldPosST22a, var_476_4, var_476_3)
			end

			if arg_473_1.time_ >= var_476_1 + var_476_2 and arg_473_1.time_ < var_476_1 + var_476_2 + arg_476_0 then
				var_476_0.localPosition = Vector3.New(0, 1, 9.5)
			end

			local var_476_5 = 0

			if var_476_5 < arg_473_1.time_ and arg_473_1.time_ <= var_476_5 + arg_476_0 then
				arg_473_1.allBtn_.enabled = false
			end

			local var_476_6 = 4.5

			if arg_473_1.time_ >= var_476_5 + var_476_6 and arg_473_1.time_ < var_476_5 + var_476_6 + arg_476_0 then
				arg_473_1.allBtn_.enabled = true
			end

			local var_476_7 = 0
			local var_476_8 = 0.45

			if var_476_7 < arg_473_1.time_ and arg_473_1.time_ <= var_476_7 + arg_476_0 then
				arg_473_1.talkMaxDuration = 0
				arg_473_1.dialogCg_.alpha = 1

				arg_473_1.dialog_:SetActive(true)
				SetActive(arg_473_1.leftNameGo_, false)

				arg_473_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_473_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_473_1:RecordName(arg_473_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_473_1.iconTrs_.gameObject, false)
				arg_473_1.callingController_:SetSelectedState("normal")

				local var_476_9 = arg_473_1:GetWordFromCfg(115311117)
				local var_476_10 = arg_473_1:FormatText(var_476_9.content)

				arg_473_1.text_.text = var_476_10

				LuaForUtil.ClearLinePrefixSymbol(arg_473_1.text_)

				local var_476_11 = 18
				local var_476_12 = utf8.len(var_476_10)
				local var_476_13 = var_476_11 <= 0 and var_476_8 or var_476_8 * (var_476_12 / var_476_11)

				if var_476_13 > 0 and var_476_8 < var_476_13 then
					arg_473_1.talkMaxDuration = var_476_13

					if var_476_13 + var_476_7 > arg_473_1.duration_ then
						arg_473_1.duration_ = var_476_13 + var_476_7
					end
				end

				arg_473_1.text_.text = var_476_10
				arg_473_1.typewritter.percent = 0

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(false)
				arg_473_1:RecordContent(arg_473_1.text_.text)
			end

			local var_476_14 = math.max(var_476_8, arg_473_1.talkMaxDuration)

			if var_476_7 <= arg_473_1.time_ and arg_473_1.time_ < var_476_7 + var_476_14 then
				arg_473_1.typewritter.percent = (arg_473_1.time_ - var_476_7) / var_476_14

				arg_473_1.typewritter:SetDirty()
			end

			if arg_473_1.time_ >= var_476_7 + var_476_14 and arg_473_1.time_ < var_476_7 + var_476_14 + arg_476_0 then
				arg_473_1.typewritter.percent = 1

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(true)
			end
		end

		arg_473_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "ST22a",
				changeDisplayLayer = false,
				needEase = false,
				duration = 4.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_473_1:InitPlayNodeList()
	end,
	Play115311118 = function(arg_477_0, arg_477_1)
		arg_477_1.time_ = 0
		arg_477_1.frameCnt_ = 0
		arg_477_1.state_ = "playing"
		arg_477_1.curTalkId_ = 115311118
		arg_477_1.duration_ = 7.87

		local var_477_0 = {
			ja = 6.866,
			ko = 6.766,
			zh = 7.866,
			en = 7.6
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
				arg_477_0:Play115311119(arg_477_1)
			end
		end

		function arg_477_1.onSingleLineUpdate_(arg_480_0)
			local var_480_0 = 2

			if var_480_0 < arg_477_1.time_ and arg_477_1.time_ <= var_480_0 + arg_480_0 then
				local var_480_1 = manager.ui.mainCamera.transform.localPosition
				local var_480_2 = Vector3.New(0, 0, 10) + Vector3.New(var_480_1.x, var_480_1.y, 0)
				local var_480_3 = arg_477_1.bgs_.ST28a

				var_480_3.transform.localPosition = var_480_2
				var_480_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_480_4 = var_480_3:GetComponent("SpriteRenderer")

				if var_480_4 and var_480_4.sprite then
					local var_480_5 = (var_480_3.transform.localPosition - var_480_1).z
					local var_480_6 = manager.ui.mainCameraCom_
					local var_480_7 = 2 * var_480_5 * Mathf.Tan(var_480_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_480_8 = var_480_7 * var_480_6.aspect
					local var_480_9 = var_480_4.sprite.bounds.size.x
					local var_480_10 = var_480_4.sprite.bounds.size.y
					local var_480_11 = var_480_8 / var_480_9
					local var_480_12 = var_480_7 / var_480_10
					local var_480_13 = var_480_12 < var_480_11 and var_480_11 or var_480_12

					var_480_3.transform.localScale = Vector3.New(var_480_13, var_480_13, 0)
				end

				for iter_480_0, iter_480_1 in pairs(arg_477_1.bgs_) do
					if iter_480_0 ~= "ST28a" then
						iter_480_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_480_14 = 0

			if var_480_14 < arg_477_1.time_ and arg_477_1.time_ <= var_480_14 + arg_480_0 then
				arg_477_1.mask_.enabled = true
				arg_477_1.mask_.raycastTarget = true

				arg_477_1:SetGaussion(false)
			end

			local var_480_15 = 2

			if var_480_14 <= arg_477_1.time_ and arg_477_1.time_ < var_480_14 + var_480_15 then
				local var_480_16 = (arg_477_1.time_ - var_480_14) / var_480_15
				local var_480_17 = Color.New(0, 0, 0)

				var_480_17.a = Mathf.Lerp(0, 1, var_480_16)
				arg_477_1.mask_.color = var_480_17
			end

			if arg_477_1.time_ >= var_480_14 + var_480_15 and arg_477_1.time_ < var_480_14 + var_480_15 + arg_480_0 then
				local var_480_18 = Color.New(0, 0, 0)

				var_480_18.a = 1
				arg_477_1.mask_.color = var_480_18
			end

			local var_480_19 = 2

			if var_480_19 < arg_477_1.time_ and arg_477_1.time_ <= var_480_19 + arg_480_0 then
				arg_477_1.mask_.enabled = true
				arg_477_1.mask_.raycastTarget = true

				arg_477_1:SetGaussion(false)
			end

			local var_480_20 = 2

			if var_480_19 <= arg_477_1.time_ and arg_477_1.time_ < var_480_19 + var_480_20 then
				local var_480_21 = (arg_477_1.time_ - var_480_19) / var_480_20
				local var_480_22 = Color.New(0, 0, 0)

				var_480_22.a = Mathf.Lerp(1, 0, var_480_21)
				arg_477_1.mask_.color = var_480_22
			end

			if arg_477_1.time_ >= var_480_19 + var_480_20 and arg_477_1.time_ < var_480_19 + var_480_20 + arg_480_0 then
				local var_480_23 = Color.New(0, 0, 0)
				local var_480_24 = 0

				arg_477_1.mask_.enabled = false
				var_480_23.a = var_480_24
				arg_477_1.mask_.color = var_480_23
			end

			local var_480_25 = 0
			local var_480_26 = 0.3

			if var_480_25 < arg_477_1.time_ and arg_477_1.time_ <= var_480_25 + arg_480_0 then
				local var_480_27 = "play"
				local var_480_28 = "music"

				arg_477_1:AudioAction(var_480_27, var_480_28, "ui_battle", "ui_battle_stopbgm", "")

				local var_480_29 = ""
				local var_480_30 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_480_30 ~= "" then
					if arg_477_1.bgmTxt_.text ~= var_480_30 and arg_477_1.bgmTxt_.text ~= "" then
						if arg_477_1.bgmTxt2_.text ~= "" then
							arg_477_1.bgmTxt_.text = arg_477_1.bgmTxt2_.text
						end

						arg_477_1.bgmTxt2_.text = var_480_30

						arg_477_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_477_1.bgmTxt_.text = var_480_30
						arg_477_1.bgmTxt2_.text = var_480_30
					end

					if arg_477_1.bgmTimer then
						arg_477_1.bgmTimer:Stop()

						arg_477_1.bgmTimer = nil
					end

					if arg_477_1.settingData.show_music_name == 1 then
						arg_477_1.musicController:SetSelectedState("show")
						arg_477_1.musicAnimator_:Play("open", 0, 0)

						if arg_477_1.settingData.music_time ~= 0 then
							arg_477_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_477_1.settingData.music_time), function()
								if arg_477_1 == nil or isNil(arg_477_1.bgmTxt_) then
									return
								end

								arg_477_1.musicController:SetSelectedState("hide")
								arg_477_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_480_31 = 4
			local var_480_32 = 0.533333333333333

			if var_480_31 < arg_477_1.time_ and arg_477_1.time_ <= var_480_31 + arg_480_0 then
				local var_480_33 = "play"
				local var_480_34 = "music"

				arg_477_1:AudioAction(var_480_33, var_480_34, "bgm_activity_1_3_warchess", "bgm_activity_1_3_warchess", "bgm_activity_1_3_warchess.awb")

				local var_480_35 = ""
				local var_480_36 = manager.audio:GetAudioName("bgm_activity_1_3_warchess", "bgm_activity_1_3_warchess")

				if var_480_36 ~= "" then
					if arg_477_1.bgmTxt_.text ~= var_480_36 and arg_477_1.bgmTxt_.text ~= "" then
						if arg_477_1.bgmTxt2_.text ~= "" then
							arg_477_1.bgmTxt_.text = arg_477_1.bgmTxt2_.text
						end

						arg_477_1.bgmTxt2_.text = var_480_36

						arg_477_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_477_1.bgmTxt_.text = var_480_36
						arg_477_1.bgmTxt2_.text = var_480_36
					end

					if arg_477_1.bgmTimer then
						arg_477_1.bgmTimer:Stop()

						arg_477_1.bgmTimer = nil
					end

					if arg_477_1.settingData.show_music_name == 1 then
						arg_477_1.musicController:SetSelectedState("show")
						arg_477_1.musicAnimator_:Play("open", 0, 0)

						if arg_477_1.settingData.music_time ~= 0 then
							arg_477_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_477_1.settingData.music_time), function()
								if arg_477_1 == nil or isNil(arg_477_1.bgmTxt_) then
									return
								end

								arg_477_1.musicController:SetSelectedState("hide")
								arg_477_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_477_1.frameCnt_ <= 1 then
				arg_477_1.dialog_:SetActive(false)
			end

			local var_480_37 = 4
			local var_480_38 = 0.3

			if var_480_37 < arg_477_1.time_ and arg_477_1.time_ <= var_480_37 + arg_480_0 then
				arg_477_1.talkMaxDuration = 0

				arg_477_1.dialog_:SetActive(true)

				arg_477_1.dialogCg_.alpha = 0

				local var_480_39 = LeanTween.value(arg_477_1.dialog_, 0, 1, 0.3)

				var_480_39:setOnUpdate(LuaHelper.FloatAction(function(arg_483_0)
					arg_477_1.dialogCg_.alpha = arg_483_0
				end))
				var_480_39:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_477_1.dialog_)
					var_480_39:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_477_1.duration_ = arg_477_1.duration_ + 0.3

				SetActive(arg_477_1.leftNameGo_, true)

				local var_480_40 = arg_477_1:FormatText(StoryNameCfg[104].name)

				arg_477_1.leftNameTxt_.text = var_480_40

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_477_1.leftNameTxt_.transform)

				arg_477_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_477_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_477_1:RecordName(arg_477_1.leftNameTxt_.text)
				SetActive(arg_477_1.iconTrs_.gameObject, true)
				arg_477_1.iconController_:SetSelectedState("hero")

				arg_477_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_woundedd")

				arg_477_1.callingController_:SetSelectedState("normal")

				arg_477_1.keyicon_.color = Color.New(1, 1, 1)
				arg_477_1.icon_.color = Color.New(1, 1, 1)

				local var_480_41 = arg_477_1:GetWordFromCfg(115311118)
				local var_480_42 = arg_477_1:FormatText(var_480_41.content)

				arg_477_1.text_.text = var_480_42

				LuaForUtil.ClearLinePrefixSymbol(arg_477_1.text_)

				local var_480_43 = 12
				local var_480_44 = utf8.len(var_480_42)
				local var_480_45 = var_480_43 <= 0 and var_480_38 or var_480_38 * (var_480_44 / var_480_43)

				if var_480_45 > 0 and var_480_38 < var_480_45 then
					arg_477_1.talkMaxDuration = var_480_45
					var_480_37 = var_480_37 + 0.3

					if var_480_45 + var_480_37 > arg_477_1.duration_ then
						arg_477_1.duration_ = var_480_45 + var_480_37
					end
				end

				arg_477_1.text_.text = var_480_42
				arg_477_1.typewritter.percent = 0

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311118", "story_v_out_115311.awb") ~= 0 then
					local var_480_46 = manager.audio:GetVoiceLength("story_v_out_115311", "115311118", "story_v_out_115311.awb") / 1000

					if var_480_46 + var_480_37 > arg_477_1.duration_ then
						arg_477_1.duration_ = var_480_46 + var_480_37
					end

					if var_480_41.prefab_name ~= "" and arg_477_1.actors_[var_480_41.prefab_name] ~= nil then
						local var_480_47 = LuaForUtil.PlayVoiceWithCriLipsync(arg_477_1.actors_[var_480_41.prefab_name].transform, "story_v_out_115311", "115311118", "story_v_out_115311.awb")

						arg_477_1:RecordAudio("115311118", var_480_47)
						arg_477_1:RecordAudio("115311118", var_480_47)
					else
						arg_477_1:AudioAction("play", "voice", "story_v_out_115311", "115311118", "story_v_out_115311.awb")
					end

					arg_477_1:RecordHistoryTalkVoice("story_v_out_115311", "115311118", "story_v_out_115311.awb")
				end

				arg_477_1:RecordContent(arg_477_1.text_.text)
			end

			local var_480_48 = var_480_37 + 0.3
			local var_480_49 = math.max(var_480_38, arg_477_1.talkMaxDuration)

			if var_480_48 <= arg_477_1.time_ and arg_477_1.time_ < var_480_48 + var_480_49 then
				arg_477_1.typewritter.percent = (arg_477_1.time_ - var_480_48) / var_480_49

				arg_477_1.typewritter:SetDirty()
			end

			if arg_477_1.time_ >= var_480_48 + var_480_49 and arg_477_1.time_ < var_480_48 + var_480_49 + arg_480_0 then
				arg_477_1.typewritter.percent = 1

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(true)
			end
		end

		arg_477_1.nodeConfigList_ = {}

		arg_477_1:InitPlayNodeList()
	end,
	Play115311119 = function(arg_485_0, arg_485_1)
		arg_485_1.time_ = 0
		arg_485_1.frameCnt_ = 0
		arg_485_1.state_ = "playing"
		arg_485_1.curTalkId_ = 115311119
		arg_485_1.duration_ = 6.6

		local var_485_0 = {
			ja = 5,
			ko = 6.6,
			zh = 5.8,
			en = 6.1
		}
		local var_485_1 = manager.audio:GetLocalizationFlag()

		if var_485_0[var_485_1] ~= nil then
			arg_485_1.duration_ = var_485_0[var_485_1]
		end

		SetActive(arg_485_1.tipsGo_, false)

		function arg_485_1.onSingleLineFinish_()
			arg_485_1.onSingleLineUpdate_ = nil
			arg_485_1.onSingleLineFinish_ = nil
			arg_485_1.state_ = "waiting"
		end

		function arg_485_1.playNext_(arg_487_0)
			if arg_487_0 == 1 then
				arg_485_0:Play115311120(arg_485_1)
			end
		end

		function arg_485_1.onSingleLineUpdate_(arg_488_0)
			local var_488_0 = 0
			local var_488_1 = 0.5

			if var_488_0 < arg_485_1.time_ and arg_485_1.time_ <= var_488_0 + arg_488_0 then
				arg_485_1.talkMaxDuration = 0
				arg_485_1.dialogCg_.alpha = 1

				arg_485_1.dialog_:SetActive(true)
				SetActive(arg_485_1.leftNameGo_, true)

				local var_488_2 = arg_485_1:FormatText(StoryNameCfg[105].name)

				arg_485_1.leftNameTxt_.text = var_488_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_485_1.leftNameTxt_.transform)

				arg_485_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_485_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_485_1:RecordName(arg_485_1.leftNameTxt_.text)
				SetActive(arg_485_1.iconTrs_.gameObject, true)
				arg_485_1.iconController_:SetSelectedState("hero")

				arg_485_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officeladyb")

				arg_485_1.callingController_:SetSelectedState("normal")

				arg_485_1.keyicon_.color = Color.New(1, 1, 1)
				arg_485_1.icon_.color = Color.New(1, 1, 1)

				local var_488_3 = arg_485_1:GetWordFromCfg(115311119)
				local var_488_4 = arg_485_1:FormatText(var_488_3.content)

				arg_485_1.text_.text = var_488_4

				LuaForUtil.ClearLinePrefixSymbol(arg_485_1.text_)

				local var_488_5 = 20
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

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311119", "story_v_out_115311.awb") ~= 0 then
					local var_488_8 = manager.audio:GetVoiceLength("story_v_out_115311", "115311119", "story_v_out_115311.awb") / 1000

					if var_488_8 + var_488_0 > arg_485_1.duration_ then
						arg_485_1.duration_ = var_488_8 + var_488_0
					end

					if var_488_3.prefab_name ~= "" and arg_485_1.actors_[var_488_3.prefab_name] ~= nil then
						local var_488_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_485_1.actors_[var_488_3.prefab_name].transform, "story_v_out_115311", "115311119", "story_v_out_115311.awb")

						arg_485_1:RecordAudio("115311119", var_488_9)
						arg_485_1:RecordAudio("115311119", var_488_9)
					else
						arg_485_1:AudioAction("play", "voice", "story_v_out_115311", "115311119", "story_v_out_115311.awb")
					end

					arg_485_1:RecordHistoryTalkVoice("story_v_out_115311", "115311119", "story_v_out_115311.awb")
				end

				arg_485_1:RecordContent(arg_485_1.text_.text)
			end

			local var_488_10 = math.max(var_488_1, arg_485_1.talkMaxDuration)

			if var_488_0 <= arg_485_1.time_ and arg_485_1.time_ < var_488_0 + var_488_10 then
				arg_485_1.typewritter.percent = (arg_485_1.time_ - var_488_0) / var_488_10

				arg_485_1.typewritter:SetDirty()
			end

			if arg_485_1.time_ >= var_488_0 + var_488_10 and arg_485_1.time_ < var_488_0 + var_488_10 + arg_488_0 then
				arg_485_1.typewritter.percent = 1

				arg_485_1.typewritter:SetDirty()
				arg_485_1:ShowNextGo(true)
			end
		end

		arg_485_1.nodeConfigList_ = {}

		arg_485_1:InitPlayNodeList()
	end,
	Play115311120 = function(arg_489_0, arg_489_1)
		arg_489_1.time_ = 0
		arg_489_1.frameCnt_ = 0
		arg_489_1.state_ = "playing"
		arg_489_1.curTalkId_ = 115311120
		arg_489_1.duration_ = 5

		SetActive(arg_489_1.tipsGo_, false)

		function arg_489_1.onSingleLineFinish_()
			arg_489_1.onSingleLineUpdate_ = nil
			arg_489_1.onSingleLineFinish_ = nil
			arg_489_1.state_ = "waiting"
		end

		function arg_489_1.playNext_(arg_491_0)
			if arg_491_0 == 1 then
				arg_489_0:Play115311121(arg_489_1)
			end
		end

		function arg_489_1.onSingleLineUpdate_(arg_492_0)
			local var_492_0 = 0
			local var_492_1 = 0.725

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

				local var_492_2 = arg_489_1:GetWordFromCfg(115311120)
				local var_492_3 = arg_489_1:FormatText(var_492_2.content)

				arg_489_1.text_.text = var_492_3

				LuaForUtil.ClearLinePrefixSymbol(arg_489_1.text_)

				local var_492_4 = 29
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
	Play115311121 = function(arg_493_0, arg_493_1)
		arg_493_1.time_ = 0
		arg_493_1.frameCnt_ = 0
		arg_493_1.state_ = "playing"
		arg_493_1.curTalkId_ = 115311121
		arg_493_1.duration_ = 5

		SetActive(arg_493_1.tipsGo_, false)

		function arg_493_1.onSingleLineFinish_()
			arg_493_1.onSingleLineUpdate_ = nil
			arg_493_1.onSingleLineFinish_ = nil
			arg_493_1.state_ = "waiting"
		end

		function arg_493_1.playNext_(arg_495_0)
			if arg_495_0 == 1 then
				arg_493_0:Play115311122(arg_493_1)
			end
		end

		function arg_493_1.onSingleLineUpdate_(arg_496_0)
			local var_496_0 = 0
			local var_496_1 = 1.4

			if var_496_0 < arg_493_1.time_ and arg_493_1.time_ <= var_496_0 + arg_496_0 then
				arg_493_1.talkMaxDuration = 0
				arg_493_1.dialogCg_.alpha = 1

				arg_493_1.dialog_:SetActive(true)
				SetActive(arg_493_1.leftNameGo_, false)

				arg_493_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_493_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_493_1:RecordName(arg_493_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_493_1.iconTrs_.gameObject, false)
				arg_493_1.callingController_:SetSelectedState("normal")

				local var_496_2 = arg_493_1:GetWordFromCfg(115311121)
				local var_496_3 = arg_493_1:FormatText(var_496_2.content)

				arg_493_1.text_.text = var_496_3

				LuaForUtil.ClearLinePrefixSymbol(arg_493_1.text_)

				local var_496_4 = 56
				local var_496_5 = utf8.len(var_496_3)
				local var_496_6 = var_496_4 <= 0 and var_496_1 or var_496_1 * (var_496_5 / var_496_4)

				if var_496_6 > 0 and var_496_1 < var_496_6 then
					arg_493_1.talkMaxDuration = var_496_6

					if var_496_6 + var_496_0 > arg_493_1.duration_ then
						arg_493_1.duration_ = var_496_6 + var_496_0
					end
				end

				arg_493_1.text_.text = var_496_3
				arg_493_1.typewritter.percent = 0

				arg_493_1.typewritter:SetDirty()
				arg_493_1:ShowNextGo(false)
				arg_493_1:RecordContent(arg_493_1.text_.text)
			end

			local var_496_7 = math.max(var_496_1, arg_493_1.talkMaxDuration)

			if var_496_0 <= arg_493_1.time_ and arg_493_1.time_ < var_496_0 + var_496_7 then
				arg_493_1.typewritter.percent = (arg_493_1.time_ - var_496_0) / var_496_7

				arg_493_1.typewritter:SetDirty()
			end

			if arg_493_1.time_ >= var_496_0 + var_496_7 and arg_493_1.time_ < var_496_0 + var_496_7 + arg_496_0 then
				arg_493_1.typewritter.percent = 1

				arg_493_1.typewritter:SetDirty()
				arg_493_1:ShowNextGo(true)
			end
		end

		arg_493_1.nodeConfigList_ = {}

		arg_493_1:InitPlayNodeList()
	end,
	Play115311122 = function(arg_497_0, arg_497_1)
		arg_497_1.time_ = 0
		arg_497_1.frameCnt_ = 0
		arg_497_1.state_ = "playing"
		arg_497_1.curTalkId_ = 115311122
		arg_497_1.duration_ = 7

		SetActive(arg_497_1.tipsGo_, false)

		function arg_497_1.onSingleLineFinish_()
			arg_497_1.onSingleLineUpdate_ = nil
			arg_497_1.onSingleLineFinish_ = nil
			arg_497_1.state_ = "waiting"
		end

		function arg_497_1.playNext_(arg_499_0)
			if arg_499_0 == 1 then
				arg_497_0:Play115311123(arg_497_1)
			end
		end

		function arg_497_1.onSingleLineUpdate_(arg_500_0)
			local var_500_0 = 0

			if var_500_0 < arg_497_1.time_ and arg_497_1.time_ <= var_500_0 + arg_500_0 then
				arg_497_1.mask_.enabled = true
				arg_497_1.mask_.raycastTarget = true

				arg_497_1:SetGaussion(false)
			end

			local var_500_1 = 2

			if var_500_0 <= arg_497_1.time_ and arg_497_1.time_ < var_500_0 + var_500_1 then
				local var_500_2 = (arg_497_1.time_ - var_500_0) / var_500_1
				local var_500_3 = Color.New(1, 1, 1)

				var_500_3.a = Mathf.Lerp(1, 0, var_500_2)
				arg_497_1.mask_.color = var_500_3
			end

			if arg_497_1.time_ >= var_500_0 + var_500_1 and arg_497_1.time_ < var_500_0 + var_500_1 + arg_500_0 then
				local var_500_4 = Color.New(1, 1, 1)
				local var_500_5 = 0

				arg_497_1.mask_.enabled = false
				var_500_4.a = var_500_5
				arg_497_1.mask_.color = var_500_4
			end

			if arg_497_1.frameCnt_ <= 1 then
				arg_497_1.dialog_:SetActive(false)
			end

			local var_500_6 = 2
			local var_500_7 = 1.15

			if var_500_6 < arg_497_1.time_ and arg_497_1.time_ <= var_500_6 + arg_500_0 then
				arg_497_1.talkMaxDuration = 0

				arg_497_1.dialog_:SetActive(true)

				arg_497_1.dialogCg_.alpha = 0

				local var_500_8 = LeanTween.value(arg_497_1.dialog_, 0, 1, 0.3)

				var_500_8:setOnUpdate(LuaHelper.FloatAction(function(arg_501_0)
					arg_497_1.dialogCg_.alpha = arg_501_0
				end))
				var_500_8:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_497_1.dialog_)
					var_500_8:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_497_1.duration_ = arg_497_1.duration_ + 0.3

				SetActive(arg_497_1.leftNameGo_, false)

				arg_497_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_497_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_497_1:RecordName(arg_497_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_497_1.iconTrs_.gameObject, false)
				arg_497_1.callingController_:SetSelectedState("normal")

				local var_500_9 = arg_497_1:GetWordFromCfg(115311122)
				local var_500_10 = arg_497_1:FormatText(var_500_9.content)

				arg_497_1.text_.text = var_500_10

				LuaForUtil.ClearLinePrefixSymbol(arg_497_1.text_)

				local var_500_11 = 46
				local var_500_12 = utf8.len(var_500_10)
				local var_500_13 = var_500_11 <= 0 and var_500_7 or var_500_7 * (var_500_12 / var_500_11)

				if var_500_13 > 0 and var_500_7 < var_500_13 then
					arg_497_1.talkMaxDuration = var_500_13
					var_500_6 = var_500_6 + 0.3

					if var_500_13 + var_500_6 > arg_497_1.duration_ then
						arg_497_1.duration_ = var_500_13 + var_500_6
					end
				end

				arg_497_1.text_.text = var_500_10
				arg_497_1.typewritter.percent = 0

				arg_497_1.typewritter:SetDirty()
				arg_497_1:ShowNextGo(false)
				arg_497_1:RecordContent(arg_497_1.text_.text)
			end

			local var_500_14 = var_500_6 + 0.3
			local var_500_15 = math.max(var_500_7, arg_497_1.talkMaxDuration)

			if var_500_14 <= arg_497_1.time_ and arg_497_1.time_ < var_500_14 + var_500_15 then
				arg_497_1.typewritter.percent = (arg_497_1.time_ - var_500_14) / var_500_15

				arg_497_1.typewritter:SetDirty()
			end

			if arg_497_1.time_ >= var_500_14 + var_500_15 and arg_497_1.time_ < var_500_14 + var_500_15 + arg_500_0 then
				arg_497_1.typewritter.percent = 1

				arg_497_1.typewritter:SetDirty()
				arg_497_1:ShowNextGo(true)
			end
		end

		arg_497_1.nodeConfigList_ = {}

		arg_497_1:InitPlayNodeList()
	end,
	Play115311123 = function(arg_503_0, arg_503_1)
		arg_503_1.time_ = 0
		arg_503_1.frameCnt_ = 0
		arg_503_1.state_ = "playing"
		arg_503_1.curTalkId_ = 115311123
		arg_503_1.duration_ = 5

		SetActive(arg_503_1.tipsGo_, false)

		function arg_503_1.onSingleLineFinish_()
			arg_503_1.onSingleLineUpdate_ = nil
			arg_503_1.onSingleLineFinish_ = nil
			arg_503_1.state_ = "waiting"
		end

		function arg_503_1.playNext_(arg_505_0)
			if arg_505_0 == 1 then
				arg_503_0:Play115311124(arg_503_1)
			end
		end

		function arg_503_1.onSingleLineUpdate_(arg_506_0)
			local var_506_0 = 0
			local var_506_1 = 1.725

			if var_506_0 < arg_503_1.time_ and arg_503_1.time_ <= var_506_0 + arg_506_0 then
				arg_503_1.talkMaxDuration = 0
				arg_503_1.dialogCg_.alpha = 1

				arg_503_1.dialog_:SetActive(true)
				SetActive(arg_503_1.leftNameGo_, false)

				arg_503_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_503_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_503_1:RecordName(arg_503_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_503_1.iconTrs_.gameObject, false)
				arg_503_1.callingController_:SetSelectedState("normal")

				local var_506_2 = arg_503_1:GetWordFromCfg(115311123)
				local var_506_3 = arg_503_1:FormatText(var_506_2.content)

				arg_503_1.text_.text = var_506_3

				LuaForUtil.ClearLinePrefixSymbol(arg_503_1.text_)

				local var_506_4 = 69
				local var_506_5 = utf8.len(var_506_3)
				local var_506_6 = var_506_4 <= 0 and var_506_1 or var_506_1 * (var_506_5 / var_506_4)

				if var_506_6 > 0 and var_506_1 < var_506_6 then
					arg_503_1.talkMaxDuration = var_506_6

					if var_506_6 + var_506_0 > arg_503_1.duration_ then
						arg_503_1.duration_ = var_506_6 + var_506_0
					end
				end

				arg_503_1.text_.text = var_506_3
				arg_503_1.typewritter.percent = 0

				arg_503_1.typewritter:SetDirty()
				arg_503_1:ShowNextGo(false)
				arg_503_1:RecordContent(arg_503_1.text_.text)
			end

			local var_506_7 = math.max(var_506_1, arg_503_1.talkMaxDuration)

			if var_506_0 <= arg_503_1.time_ and arg_503_1.time_ < var_506_0 + var_506_7 then
				arg_503_1.typewritter.percent = (arg_503_1.time_ - var_506_0) / var_506_7

				arg_503_1.typewritter:SetDirty()
			end

			if arg_503_1.time_ >= var_506_0 + var_506_7 and arg_503_1.time_ < var_506_0 + var_506_7 + arg_506_0 then
				arg_503_1.typewritter.percent = 1

				arg_503_1.typewritter:SetDirty()
				arg_503_1:ShowNextGo(true)
			end
		end

		arg_503_1.nodeConfigList_ = {}

		arg_503_1:InitPlayNodeList()
	end,
	Play115311124 = function(arg_507_0, arg_507_1)
		arg_507_1.time_ = 0
		arg_507_1.frameCnt_ = 0
		arg_507_1.state_ = "playing"
		arg_507_1.curTalkId_ = 115311124
		arg_507_1.duration_ = 5

		SetActive(arg_507_1.tipsGo_, false)

		function arg_507_1.onSingleLineFinish_()
			arg_507_1.onSingleLineUpdate_ = nil
			arg_507_1.onSingleLineFinish_ = nil
			arg_507_1.state_ = "waiting"
		end

		function arg_507_1.playNext_(arg_509_0)
			if arg_509_0 == 1 then
				arg_507_0:Play115311125(arg_507_1)
			end
		end

		function arg_507_1.onSingleLineUpdate_(arg_510_0)
			local var_510_0 = 0
			local var_510_1 = 1.8

			if var_510_0 < arg_507_1.time_ and arg_507_1.time_ <= var_510_0 + arg_510_0 then
				arg_507_1.talkMaxDuration = 0
				arg_507_1.dialogCg_.alpha = 1

				arg_507_1.dialog_:SetActive(true)
				SetActive(arg_507_1.leftNameGo_, false)

				arg_507_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_507_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_507_1:RecordName(arg_507_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_507_1.iconTrs_.gameObject, false)
				arg_507_1.callingController_:SetSelectedState("normal")

				local var_510_2 = arg_507_1:GetWordFromCfg(115311124)
				local var_510_3 = arg_507_1:FormatText(var_510_2.content)

				arg_507_1.text_.text = var_510_3

				LuaForUtil.ClearLinePrefixSymbol(arg_507_1.text_)

				local var_510_4 = 72
				local var_510_5 = utf8.len(var_510_3)
				local var_510_6 = var_510_4 <= 0 and var_510_1 or var_510_1 * (var_510_5 / var_510_4)

				if var_510_6 > 0 and var_510_1 < var_510_6 then
					arg_507_1.talkMaxDuration = var_510_6

					if var_510_6 + var_510_0 > arg_507_1.duration_ then
						arg_507_1.duration_ = var_510_6 + var_510_0
					end
				end

				arg_507_1.text_.text = var_510_3
				arg_507_1.typewritter.percent = 0

				arg_507_1.typewritter:SetDirty()
				arg_507_1:ShowNextGo(false)
				arg_507_1:RecordContent(arg_507_1.text_.text)
			end

			local var_510_7 = math.max(var_510_1, arg_507_1.talkMaxDuration)

			if var_510_0 <= arg_507_1.time_ and arg_507_1.time_ < var_510_0 + var_510_7 then
				arg_507_1.typewritter.percent = (arg_507_1.time_ - var_510_0) / var_510_7

				arg_507_1.typewritter:SetDirty()
			end

			if arg_507_1.time_ >= var_510_0 + var_510_7 and arg_507_1.time_ < var_510_0 + var_510_7 + arg_510_0 then
				arg_507_1.typewritter.percent = 1

				arg_507_1.typewritter:SetDirty()
				arg_507_1:ShowNextGo(true)
			end
		end

		arg_507_1.nodeConfigList_ = {}

		arg_507_1:InitPlayNodeList()
	end,
	Play115311125 = function(arg_511_0, arg_511_1)
		arg_511_1.time_ = 0
		arg_511_1.frameCnt_ = 0
		arg_511_1.state_ = "playing"
		arg_511_1.curTalkId_ = 115311125
		arg_511_1.duration_ = 5

		SetActive(arg_511_1.tipsGo_, false)

		function arg_511_1.onSingleLineFinish_()
			arg_511_1.onSingleLineUpdate_ = nil
			arg_511_1.onSingleLineFinish_ = nil
			arg_511_1.state_ = "waiting"
		end

		function arg_511_1.playNext_(arg_513_0)
			if arg_513_0 == 1 then
				arg_511_0:Play115311126(arg_511_1)
			end
		end

		function arg_511_1.onSingleLineUpdate_(arg_514_0)
			local var_514_0 = 0
			local var_514_1 = 1.25

			if var_514_0 < arg_511_1.time_ and arg_511_1.time_ <= var_514_0 + arg_514_0 then
				arg_511_1.talkMaxDuration = 0
				arg_511_1.dialogCg_.alpha = 1

				arg_511_1.dialog_:SetActive(true)
				SetActive(arg_511_1.leftNameGo_, false)

				arg_511_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_511_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_511_1:RecordName(arg_511_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_511_1.iconTrs_.gameObject, false)
				arg_511_1.callingController_:SetSelectedState("normal")

				local var_514_2 = arg_511_1:GetWordFromCfg(115311125)
				local var_514_3 = arg_511_1:FormatText(var_514_2.content)

				arg_511_1.text_.text = var_514_3

				LuaForUtil.ClearLinePrefixSymbol(arg_511_1.text_)

				local var_514_4 = 50
				local var_514_5 = utf8.len(var_514_3)
				local var_514_6 = var_514_4 <= 0 and var_514_1 or var_514_1 * (var_514_5 / var_514_4)

				if var_514_6 > 0 and var_514_1 < var_514_6 then
					arg_511_1.talkMaxDuration = var_514_6

					if var_514_6 + var_514_0 > arg_511_1.duration_ then
						arg_511_1.duration_ = var_514_6 + var_514_0
					end
				end

				arg_511_1.text_.text = var_514_3
				arg_511_1.typewritter.percent = 0

				arg_511_1.typewritter:SetDirty()
				arg_511_1:ShowNextGo(false)
				arg_511_1:RecordContent(arg_511_1.text_.text)
			end

			local var_514_7 = math.max(var_514_1, arg_511_1.talkMaxDuration)

			if var_514_0 <= arg_511_1.time_ and arg_511_1.time_ < var_514_0 + var_514_7 then
				arg_511_1.typewritter.percent = (arg_511_1.time_ - var_514_0) / var_514_7

				arg_511_1.typewritter:SetDirty()
			end

			if arg_511_1.time_ >= var_514_0 + var_514_7 and arg_511_1.time_ < var_514_0 + var_514_7 + arg_514_0 then
				arg_511_1.typewritter.percent = 1

				arg_511_1.typewritter:SetDirty()
				arg_511_1:ShowNextGo(true)
			end
		end

		arg_511_1.nodeConfigList_ = {}

		arg_511_1:InitPlayNodeList()
	end,
	Play115311126 = function(arg_515_0, arg_515_1)
		arg_515_1.time_ = 0
		arg_515_1.frameCnt_ = 0
		arg_515_1.state_ = "playing"
		arg_515_1.curTalkId_ = 115311126
		arg_515_1.duration_ = 6.77

		local var_515_0 = {
			ja = 6.766,
			ko = 5.566,
			zh = 5.633,
			en = 5.9
		}
		local var_515_1 = manager.audio:GetLocalizationFlag()

		if var_515_0[var_515_1] ~= nil then
			arg_515_1.duration_ = var_515_0[var_515_1]
		end

		SetActive(arg_515_1.tipsGo_, false)

		function arg_515_1.onSingleLineFinish_()
			arg_515_1.onSingleLineUpdate_ = nil
			arg_515_1.onSingleLineFinish_ = nil
			arg_515_1.state_ = "waiting"
		end

		function arg_515_1.playNext_(arg_517_0)
			if arg_517_0 == 1 then
				arg_515_0:Play115311127(arg_515_1)
			end
		end

		function arg_515_1.onSingleLineUpdate_(arg_518_0)
			local var_518_0 = 0
			local var_518_1 = 0.6

			if var_518_0 < arg_515_1.time_ and arg_515_1.time_ <= var_518_0 + arg_518_0 then
				arg_515_1.talkMaxDuration = 0
				arg_515_1.dialogCg_.alpha = 1

				arg_515_1.dialog_:SetActive(true)
				SetActive(arg_515_1.leftNameGo_, true)

				local var_518_2 = arg_515_1:FormatText(StoryNameCfg[316].name)

				arg_515_1.leftNameTxt_.text = var_518_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_515_1.leftNameTxt_.transform)

				arg_515_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_515_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_515_1:RecordName(arg_515_1.leftNameTxt_.text)
				SetActive(arg_515_1.iconTrs_.gameObject, true)
				arg_515_1.iconController_:SetSelectedState("hero")

				arg_515_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_515_1.callingController_:SetSelectedState("normal")

				arg_515_1.keyicon_.color = Color.New(1, 1, 1)
				arg_515_1.icon_.color = Color.New(1, 1, 1)

				local var_518_3 = arg_515_1:GetWordFromCfg(115311126)
				local var_518_4 = arg_515_1:FormatText(var_518_3.content)

				arg_515_1.text_.text = var_518_4

				LuaForUtil.ClearLinePrefixSymbol(arg_515_1.text_)

				local var_518_5 = 24
				local var_518_6 = utf8.len(var_518_4)
				local var_518_7 = var_518_5 <= 0 and var_518_1 or var_518_1 * (var_518_6 / var_518_5)

				if var_518_7 > 0 and var_518_1 < var_518_7 then
					arg_515_1.talkMaxDuration = var_518_7

					if var_518_7 + var_518_0 > arg_515_1.duration_ then
						arg_515_1.duration_ = var_518_7 + var_518_0
					end
				end

				arg_515_1.text_.text = var_518_4
				arg_515_1.typewritter.percent = 0

				arg_515_1.typewritter:SetDirty()
				arg_515_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311126", "story_v_out_115311.awb") ~= 0 then
					local var_518_8 = manager.audio:GetVoiceLength("story_v_out_115311", "115311126", "story_v_out_115311.awb") / 1000

					if var_518_8 + var_518_0 > arg_515_1.duration_ then
						arg_515_1.duration_ = var_518_8 + var_518_0
					end

					if var_518_3.prefab_name ~= "" and arg_515_1.actors_[var_518_3.prefab_name] ~= nil then
						local var_518_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_515_1.actors_[var_518_3.prefab_name].transform, "story_v_out_115311", "115311126", "story_v_out_115311.awb")

						arg_515_1:RecordAudio("115311126", var_518_9)
						arg_515_1:RecordAudio("115311126", var_518_9)
					else
						arg_515_1:AudioAction("play", "voice", "story_v_out_115311", "115311126", "story_v_out_115311.awb")
					end

					arg_515_1:RecordHistoryTalkVoice("story_v_out_115311", "115311126", "story_v_out_115311.awb")
				end

				arg_515_1:RecordContent(arg_515_1.text_.text)
			end

			local var_518_10 = math.max(var_518_1, arg_515_1.talkMaxDuration)

			if var_518_0 <= arg_515_1.time_ and arg_515_1.time_ < var_518_0 + var_518_10 then
				arg_515_1.typewritter.percent = (arg_515_1.time_ - var_518_0) / var_518_10

				arg_515_1.typewritter:SetDirty()
			end

			if arg_515_1.time_ >= var_518_0 + var_518_10 and arg_515_1.time_ < var_518_0 + var_518_10 + arg_518_0 then
				arg_515_1.typewritter.percent = 1

				arg_515_1.typewritter:SetDirty()
				arg_515_1:ShowNextGo(true)
			end
		end

		arg_515_1.nodeConfigList_ = {}

		arg_515_1:InitPlayNodeList()
	end,
	Play115311127 = function(arg_519_0, arg_519_1)
		arg_519_1.time_ = 0
		arg_519_1.frameCnt_ = 0
		arg_519_1.state_ = "playing"
		arg_519_1.curTalkId_ = 115311127
		arg_519_1.duration_ = 8.1

		local var_519_0 = {
			ja = 8.1,
			ko = 6.566,
			zh = 4.7,
			en = 6.566
		}
		local var_519_1 = manager.audio:GetLocalizationFlag()

		if var_519_0[var_519_1] ~= nil then
			arg_519_1.duration_ = var_519_0[var_519_1]
		end

		SetActive(arg_519_1.tipsGo_, false)

		function arg_519_1.onSingleLineFinish_()
			arg_519_1.onSingleLineUpdate_ = nil
			arg_519_1.onSingleLineFinish_ = nil
			arg_519_1.state_ = "waiting"
		end

		function arg_519_1.playNext_(arg_521_0)
			if arg_521_0 == 1 then
				arg_519_0:Play115311128(arg_519_1)
			end
		end

		function arg_519_1.onSingleLineUpdate_(arg_522_0)
			local var_522_0 = 0
			local var_522_1 = 0.625

			if var_522_0 < arg_519_1.time_ and arg_519_1.time_ <= var_522_0 + arg_522_0 then
				arg_519_1.talkMaxDuration = 0
				arg_519_1.dialogCg_.alpha = 1

				arg_519_1.dialog_:SetActive(true)
				SetActive(arg_519_1.leftNameGo_, true)

				local var_522_2 = arg_519_1:FormatText(StoryNameCfg[104].name)

				arg_519_1.leftNameTxt_.text = var_522_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_519_1.leftNameTxt_.transform)

				arg_519_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_519_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_519_1:RecordName(arg_519_1.leftNameTxt_.text)
				SetActive(arg_519_1.iconTrs_.gameObject, true)
				arg_519_1.iconController_:SetSelectedState("hero")

				arg_519_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_woundedd")

				arg_519_1.callingController_:SetSelectedState("normal")

				arg_519_1.keyicon_.color = Color.New(1, 1, 1)
				arg_519_1.icon_.color = Color.New(1, 1, 1)

				local var_522_3 = arg_519_1:GetWordFromCfg(115311127)
				local var_522_4 = arg_519_1:FormatText(var_522_3.content)

				arg_519_1.text_.text = var_522_4

				LuaForUtil.ClearLinePrefixSymbol(arg_519_1.text_)

				local var_522_5 = 25
				local var_522_6 = utf8.len(var_522_4)
				local var_522_7 = var_522_5 <= 0 and var_522_1 or var_522_1 * (var_522_6 / var_522_5)

				if var_522_7 > 0 and var_522_1 < var_522_7 then
					arg_519_1.talkMaxDuration = var_522_7

					if var_522_7 + var_522_0 > arg_519_1.duration_ then
						arg_519_1.duration_ = var_522_7 + var_522_0
					end
				end

				arg_519_1.text_.text = var_522_4
				arg_519_1.typewritter.percent = 0

				arg_519_1.typewritter:SetDirty()
				arg_519_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311127", "story_v_out_115311.awb") ~= 0 then
					local var_522_8 = manager.audio:GetVoiceLength("story_v_out_115311", "115311127", "story_v_out_115311.awb") / 1000

					if var_522_8 + var_522_0 > arg_519_1.duration_ then
						arg_519_1.duration_ = var_522_8 + var_522_0
					end

					if var_522_3.prefab_name ~= "" and arg_519_1.actors_[var_522_3.prefab_name] ~= nil then
						local var_522_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_519_1.actors_[var_522_3.prefab_name].transform, "story_v_out_115311", "115311127", "story_v_out_115311.awb")

						arg_519_1:RecordAudio("115311127", var_522_9)
						arg_519_1:RecordAudio("115311127", var_522_9)
					else
						arg_519_1:AudioAction("play", "voice", "story_v_out_115311", "115311127", "story_v_out_115311.awb")
					end

					arg_519_1:RecordHistoryTalkVoice("story_v_out_115311", "115311127", "story_v_out_115311.awb")
				end

				arg_519_1:RecordContent(arg_519_1.text_.text)
			end

			local var_522_10 = math.max(var_522_1, arg_519_1.talkMaxDuration)

			if var_522_0 <= arg_519_1.time_ and arg_519_1.time_ < var_522_0 + var_522_10 then
				arg_519_1.typewritter.percent = (arg_519_1.time_ - var_522_0) / var_522_10

				arg_519_1.typewritter:SetDirty()
			end

			if arg_519_1.time_ >= var_522_0 + var_522_10 and arg_519_1.time_ < var_522_0 + var_522_10 + arg_522_0 then
				arg_519_1.typewritter.percent = 1

				arg_519_1.typewritter:SetDirty()
				arg_519_1:ShowNextGo(true)
			end
		end

		arg_519_1.nodeConfigList_ = {}

		arg_519_1:InitPlayNodeList()
	end,
	Play115311128 = function(arg_523_0, arg_523_1)
		arg_523_1.time_ = 0
		arg_523_1.frameCnt_ = 0
		arg_523_1.state_ = "playing"
		arg_523_1.curTalkId_ = 115311128
		arg_523_1.duration_ = 5

		SetActive(arg_523_1.tipsGo_, false)

		function arg_523_1.onSingleLineFinish_()
			arg_523_1.onSingleLineUpdate_ = nil
			arg_523_1.onSingleLineFinish_ = nil
			arg_523_1.state_ = "waiting"
		end

		function arg_523_1.playNext_(arg_525_0)
			if arg_525_0 == 1 then
				arg_523_0:Play115311129(arg_523_1)
			end
		end

		function arg_523_1.onSingleLineUpdate_(arg_526_0)
			local var_526_0 = 0
			local var_526_1 = 1

			if var_526_0 < arg_523_1.time_ and arg_523_1.time_ <= var_526_0 + arg_526_0 then
				arg_523_1.talkMaxDuration = 0
				arg_523_1.dialogCg_.alpha = 1

				arg_523_1.dialog_:SetActive(true)
				SetActive(arg_523_1.leftNameGo_, false)

				arg_523_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_523_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_523_1:RecordName(arg_523_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_523_1.iconTrs_.gameObject, false)
				arg_523_1.callingController_:SetSelectedState("normal")

				local var_526_2 = arg_523_1:GetWordFromCfg(115311128)
				local var_526_3 = arg_523_1:FormatText(var_526_2.content)

				arg_523_1.text_.text = var_526_3

				LuaForUtil.ClearLinePrefixSymbol(arg_523_1.text_)

				local var_526_4 = 40
				local var_526_5 = utf8.len(var_526_3)
				local var_526_6 = var_526_4 <= 0 and var_526_1 or var_526_1 * (var_526_5 / var_526_4)

				if var_526_6 > 0 and var_526_1 < var_526_6 then
					arg_523_1.talkMaxDuration = var_526_6

					if var_526_6 + var_526_0 > arg_523_1.duration_ then
						arg_523_1.duration_ = var_526_6 + var_526_0
					end
				end

				arg_523_1.text_.text = var_526_3
				arg_523_1.typewritter.percent = 0

				arg_523_1.typewritter:SetDirty()
				arg_523_1:ShowNextGo(false)
				arg_523_1:RecordContent(arg_523_1.text_.text)
			end

			local var_526_7 = math.max(var_526_1, arg_523_1.talkMaxDuration)

			if var_526_0 <= arg_523_1.time_ and arg_523_1.time_ < var_526_0 + var_526_7 then
				arg_523_1.typewritter.percent = (arg_523_1.time_ - var_526_0) / var_526_7

				arg_523_1.typewritter:SetDirty()
			end

			if arg_523_1.time_ >= var_526_0 + var_526_7 and arg_523_1.time_ < var_526_0 + var_526_7 + arg_526_0 then
				arg_523_1.typewritter.percent = 1

				arg_523_1.typewritter:SetDirty()
				arg_523_1:ShowNextGo(true)
			end
		end

		arg_523_1.nodeConfigList_ = {}

		arg_523_1:InitPlayNodeList()
	end,
	Play115311129 = function(arg_527_0, arg_527_1)
		arg_527_1.time_ = 0
		arg_527_1.frameCnt_ = 0
		arg_527_1.state_ = "playing"
		arg_527_1.curTalkId_ = 115311129
		arg_527_1.duration_ = 5

		SetActive(arg_527_1.tipsGo_, false)

		function arg_527_1.onSingleLineFinish_()
			arg_527_1.onSingleLineUpdate_ = nil
			arg_527_1.onSingleLineFinish_ = nil
			arg_527_1.state_ = "waiting"
		end

		function arg_527_1.playNext_(arg_529_0)
			if arg_529_0 == 1 then
				arg_527_0:Play115311130(arg_527_1)
			end
		end

		function arg_527_1.onSingleLineUpdate_(arg_530_0)
			local var_530_0 = 0
			local var_530_1 = 1.15

			if var_530_0 < arg_527_1.time_ and arg_527_1.time_ <= var_530_0 + arg_530_0 then
				arg_527_1.talkMaxDuration = 0
				arg_527_1.dialogCg_.alpha = 1

				arg_527_1.dialog_:SetActive(true)
				SetActive(arg_527_1.leftNameGo_, false)

				arg_527_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_527_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_527_1:RecordName(arg_527_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_527_1.iconTrs_.gameObject, false)
				arg_527_1.callingController_:SetSelectedState("normal")

				local var_530_2 = arg_527_1:GetWordFromCfg(115311129)
				local var_530_3 = arg_527_1:FormatText(var_530_2.content)

				arg_527_1.text_.text = var_530_3

				LuaForUtil.ClearLinePrefixSymbol(arg_527_1.text_)

				local var_530_4 = 46
				local var_530_5 = utf8.len(var_530_3)
				local var_530_6 = var_530_4 <= 0 and var_530_1 or var_530_1 * (var_530_5 / var_530_4)

				if var_530_6 > 0 and var_530_1 < var_530_6 then
					arg_527_1.talkMaxDuration = var_530_6

					if var_530_6 + var_530_0 > arg_527_1.duration_ then
						arg_527_1.duration_ = var_530_6 + var_530_0
					end
				end

				arg_527_1.text_.text = var_530_3
				arg_527_1.typewritter.percent = 0

				arg_527_1.typewritter:SetDirty()
				arg_527_1:ShowNextGo(false)
				arg_527_1:RecordContent(arg_527_1.text_.text)
			end

			local var_530_7 = math.max(var_530_1, arg_527_1.talkMaxDuration)

			if var_530_0 <= arg_527_1.time_ and arg_527_1.time_ < var_530_0 + var_530_7 then
				arg_527_1.typewritter.percent = (arg_527_1.time_ - var_530_0) / var_530_7

				arg_527_1.typewritter:SetDirty()
			end

			if arg_527_1.time_ >= var_530_0 + var_530_7 and arg_527_1.time_ < var_530_0 + var_530_7 + arg_530_0 then
				arg_527_1.typewritter.percent = 1

				arg_527_1.typewritter:SetDirty()
				arg_527_1:ShowNextGo(true)
			end
		end

		arg_527_1.nodeConfigList_ = {}

		arg_527_1:InitPlayNodeList()
	end,
	Play115311130 = function(arg_531_0, arg_531_1)
		arg_531_1.time_ = 0
		arg_531_1.frameCnt_ = 0
		arg_531_1.state_ = "playing"
		arg_531_1.curTalkId_ = 115311130
		arg_531_1.duration_ = 4.67

		local var_531_0 = {
			ja = 4.666,
			ko = 2.533,
			zh = 3.5,
			en = 2.566
		}
		local var_531_1 = manager.audio:GetLocalizationFlag()

		if var_531_0[var_531_1] ~= nil then
			arg_531_1.duration_ = var_531_0[var_531_1]
		end

		SetActive(arg_531_1.tipsGo_, false)

		function arg_531_1.onSingleLineFinish_()
			arg_531_1.onSingleLineUpdate_ = nil
			arg_531_1.onSingleLineFinish_ = nil
			arg_531_1.state_ = "waiting"
		end

		function arg_531_1.playNext_(arg_533_0)
			if arg_533_0 == 1 then
				arg_531_0:Play115311131(arg_531_1)
			end
		end

		function arg_531_1.onSingleLineUpdate_(arg_534_0)
			local var_534_0 = arg_531_1.actors_["113801_1"].transform
			local var_534_1 = 0

			if var_534_1 < arg_531_1.time_ and arg_531_1.time_ <= var_534_1 + arg_534_0 then
				arg_531_1.var_.moveOldPos113801_1 = var_534_0.localPosition
				var_534_0.localScale = Vector3.New(1, 1, 1)

				arg_531_1:CheckSpriteTmpPos("113801_1", 3)
			end

			local var_534_2 = 0.001

			if var_534_1 <= arg_531_1.time_ and arg_531_1.time_ < var_534_1 + var_534_2 then
				local var_534_3 = (arg_531_1.time_ - var_534_1) / var_534_2
				local var_534_4 = Vector3.New(0, -310, -370)

				var_534_0.localPosition = Vector3.Lerp(arg_531_1.var_.moveOldPos113801_1, var_534_4, var_534_3)
			end

			if arg_531_1.time_ >= var_534_1 + var_534_2 and arg_531_1.time_ < var_534_1 + var_534_2 + arg_534_0 then
				var_534_0.localPosition = Vector3.New(0, -310, -370)
			end

			local var_534_5 = arg_531_1.actors_["113801_1"]
			local var_534_6 = 0

			if var_534_6 < arg_531_1.time_ and arg_531_1.time_ <= var_534_6 + arg_534_0 then
				local var_534_7 = var_534_5:GetComponent("Image")

				if var_534_7 then
					arg_531_1.var_.alphaMatValue113801_1 = var_534_7
					arg_531_1.var_.alphaOldValue113801_1 = var_534_7.color.a
				end

				arg_531_1.var_.alphaOldValue113801_1 = 0
			end

			local var_534_8 = 0.5

			if var_534_6 <= arg_531_1.time_ and arg_531_1.time_ < var_534_6 + var_534_8 then
				local var_534_9 = (arg_531_1.time_ - var_534_6) / var_534_8
				local var_534_10 = Mathf.Lerp(arg_531_1.var_.alphaOldValue113801_1, 1, var_534_9)

				if arg_531_1.var_.alphaMatValue113801_1 then
					local var_534_11 = arg_531_1.var_.alphaMatValue113801_1.color

					var_534_11.a = var_534_10
					arg_531_1.var_.alphaMatValue113801_1.color = var_534_11
				end
			end

			if arg_531_1.time_ >= var_534_6 + var_534_8 and arg_531_1.time_ < var_534_6 + var_534_8 + arg_534_0 and arg_531_1.var_.alphaMatValue113801_1 then
				local var_534_12 = arg_531_1.var_.alphaMatValue113801_1
				local var_534_13 = var_534_12.color

				var_534_13.a = 1
				var_534_12.color = var_534_13
			end

			local var_534_14 = arg_531_1.actors_["113801_1"]
			local var_534_15 = 0

			if var_534_15 < arg_531_1.time_ and arg_531_1.time_ <= var_534_15 + arg_534_0 and not isNil(var_534_14) then
				local var_534_16 = var_534_14:GetComponent("Image")

				if var_534_16 then
					arg_531_1.var_.highlightMatValue113801_1 = var_534_16
				end
			end

			local var_534_17 = 0.2

			if var_534_15 <= arg_531_1.time_ and arg_531_1.time_ < var_534_15 + var_534_17 and not isNil(var_534_14) then
				local var_534_18 = (arg_531_1.time_ - var_534_15) / var_534_17

				if arg_531_1.var_.highlightMatValue113801_1 then
					local var_534_19 = Mathf.Lerp(0.5, 1, var_534_18)
					local var_534_20 = arg_531_1.var_.highlightMatValue113801_1
					local var_534_21 = var_534_20.color

					var_534_21.r = var_534_19
					var_534_21.g = var_534_19
					var_534_21.b = var_534_19
					var_534_20.color = var_534_21
				end
			end

			if arg_531_1.time_ >= var_534_15 + var_534_17 and arg_531_1.time_ < var_534_15 + var_534_17 + arg_534_0 and not isNil(var_534_14) and arg_531_1.var_.highlightMatValue113801_1 then
				local var_534_22 = 1

				var_534_14.transform:SetSiblingIndex(1)

				local var_534_23 = arg_531_1.var_.highlightMatValue113801_1
				local var_534_24 = var_534_23.color

				var_534_24.r = var_534_22
				var_534_24.g = var_534_22
				var_534_24.b = var_534_22
				var_534_23.color = var_534_24
			end

			local var_534_25 = 0
			local var_534_26 = 0.25

			if var_534_25 < arg_531_1.time_ and arg_531_1.time_ <= var_534_25 + arg_534_0 then
				arg_531_1.talkMaxDuration = 0
				arg_531_1.dialogCg_.alpha = 1

				arg_531_1.dialog_:SetActive(true)
				SetActive(arg_531_1.leftNameGo_, true)

				local var_534_27 = arg_531_1:FormatText(StoryNameCfg[94].name)

				arg_531_1.leftNameTxt_.text = var_534_27

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_531_1.leftNameTxt_.transform)

				arg_531_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_531_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_531_1:RecordName(arg_531_1.leftNameTxt_.text)
				SetActive(arg_531_1.iconTrs_.gameObject, false)
				arg_531_1.callingController_:SetSelectedState("normal")

				local var_534_28 = arg_531_1:GetWordFromCfg(115311130)
				local var_534_29 = arg_531_1:FormatText(var_534_28.content)

				arg_531_1.text_.text = var_534_29

				LuaForUtil.ClearLinePrefixSymbol(arg_531_1.text_)

				local var_534_30 = 10
				local var_534_31 = utf8.len(var_534_29)
				local var_534_32 = var_534_30 <= 0 and var_534_26 or var_534_26 * (var_534_31 / var_534_30)

				if var_534_32 > 0 and var_534_26 < var_534_32 then
					arg_531_1.talkMaxDuration = var_534_32

					if var_534_32 + var_534_25 > arg_531_1.duration_ then
						arg_531_1.duration_ = var_534_32 + var_534_25
					end
				end

				arg_531_1.text_.text = var_534_29
				arg_531_1.typewritter.percent = 0

				arg_531_1.typewritter:SetDirty()
				arg_531_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311130", "story_v_out_115311.awb") ~= 0 then
					local var_534_33 = manager.audio:GetVoiceLength("story_v_out_115311", "115311130", "story_v_out_115311.awb") / 1000

					if var_534_33 + var_534_25 > arg_531_1.duration_ then
						arg_531_1.duration_ = var_534_33 + var_534_25
					end

					if var_534_28.prefab_name ~= "" and arg_531_1.actors_[var_534_28.prefab_name] ~= nil then
						local var_534_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_531_1.actors_[var_534_28.prefab_name].transform, "story_v_out_115311", "115311130", "story_v_out_115311.awb")

						arg_531_1:RecordAudio("115311130", var_534_34)
						arg_531_1:RecordAudio("115311130", var_534_34)
					else
						arg_531_1:AudioAction("play", "voice", "story_v_out_115311", "115311130", "story_v_out_115311.awb")
					end

					arg_531_1:RecordHistoryTalkVoice("story_v_out_115311", "115311130", "story_v_out_115311.awb")
				end

				arg_531_1:RecordContent(arg_531_1.text_.text)
			end

			local var_534_35 = math.max(var_534_26, arg_531_1.talkMaxDuration)

			if var_534_25 <= arg_531_1.time_ and arg_531_1.time_ < var_534_25 + var_534_35 then
				arg_531_1.typewritter.percent = (arg_531_1.time_ - var_534_25) / var_534_35

				arg_531_1.typewritter:SetDirty()
			end

			if arg_531_1.time_ >= var_534_25 + var_534_35 and arg_531_1.time_ < var_534_25 + var_534_35 + arg_534_0 then
				arg_531_1.typewritter.percent = 1

				arg_531_1.typewritter:SetDirty()
				arg_531_1:ShowNextGo(true)
			end
		end

		arg_531_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "113801_1",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Sprite
			}
		}

		arg_531_1:InitPlayNodeList()
	end,
	Play115311131 = function(arg_535_0, arg_535_1)
		arg_535_1.time_ = 0
		arg_535_1.frameCnt_ = 0
		arg_535_1.state_ = "playing"
		arg_535_1.curTalkId_ = 115311131
		arg_535_1.duration_ = 5

		SetActive(arg_535_1.tipsGo_, false)

		function arg_535_1.onSingleLineFinish_()
			arg_535_1.onSingleLineUpdate_ = nil
			arg_535_1.onSingleLineFinish_ = nil
			arg_535_1.state_ = "waiting"
		end

		function arg_535_1.playNext_(arg_537_0)
			if arg_537_0 == 1 then
				arg_535_0:Play115311132(arg_535_1)
			end
		end

		function arg_535_1.onSingleLineUpdate_(arg_538_0)
			local var_538_0 = arg_535_1.actors_["113801_1"]
			local var_538_1 = 0

			if var_538_1 < arg_535_1.time_ and arg_535_1.time_ <= var_538_1 + arg_538_0 and not isNil(var_538_0) then
				local var_538_2 = var_538_0:GetComponent("Image")

				if var_538_2 then
					arg_535_1.var_.highlightMatValue113801_1 = var_538_2
				end
			end

			local var_538_3 = 0.2

			if var_538_1 <= arg_535_1.time_ and arg_535_1.time_ < var_538_1 + var_538_3 and not isNil(var_538_0) then
				local var_538_4 = (arg_535_1.time_ - var_538_1) / var_538_3

				if arg_535_1.var_.highlightMatValue113801_1 then
					local var_538_5 = Mathf.Lerp(1, 0.5, var_538_4)
					local var_538_6 = arg_535_1.var_.highlightMatValue113801_1
					local var_538_7 = var_538_6.color

					var_538_7.r = var_538_5
					var_538_7.g = var_538_5
					var_538_7.b = var_538_5
					var_538_6.color = var_538_7
				end
			end

			if arg_535_1.time_ >= var_538_1 + var_538_3 and arg_535_1.time_ < var_538_1 + var_538_3 + arg_538_0 and not isNil(var_538_0) and arg_535_1.var_.highlightMatValue113801_1 then
				local var_538_8 = 0.5
				local var_538_9 = arg_535_1.var_.highlightMatValue113801_1
				local var_538_10 = var_538_9.color

				var_538_10.r = var_538_8
				var_538_10.g = var_538_8
				var_538_10.b = var_538_8
				var_538_9.color = var_538_10
			end

			local var_538_11 = 0
			local var_538_12 = 1.7

			if var_538_11 < arg_535_1.time_ and arg_535_1.time_ <= var_538_11 + arg_538_0 then
				arg_535_1.talkMaxDuration = 0
				arg_535_1.dialogCg_.alpha = 1

				arg_535_1.dialog_:SetActive(true)
				SetActive(arg_535_1.leftNameGo_, false)

				arg_535_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_535_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_535_1:RecordName(arg_535_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_535_1.iconTrs_.gameObject, false)
				arg_535_1.callingController_:SetSelectedState("normal")

				local var_538_13 = arg_535_1:GetWordFromCfg(115311131)
				local var_538_14 = arg_535_1:FormatText(var_538_13.content)

				arg_535_1.text_.text = var_538_14

				LuaForUtil.ClearLinePrefixSymbol(arg_535_1.text_)

				local var_538_15 = 68
				local var_538_16 = utf8.len(var_538_14)
				local var_538_17 = var_538_15 <= 0 and var_538_12 or var_538_12 * (var_538_16 / var_538_15)

				if var_538_17 > 0 and var_538_12 < var_538_17 then
					arg_535_1.talkMaxDuration = var_538_17

					if var_538_17 + var_538_11 > arg_535_1.duration_ then
						arg_535_1.duration_ = var_538_17 + var_538_11
					end
				end

				arg_535_1.text_.text = var_538_14
				arg_535_1.typewritter.percent = 0

				arg_535_1.typewritter:SetDirty()
				arg_535_1:ShowNextGo(false)
				arg_535_1:RecordContent(arg_535_1.text_.text)
			end

			local var_538_18 = math.max(var_538_12, arg_535_1.talkMaxDuration)

			if var_538_11 <= arg_535_1.time_ and arg_535_1.time_ < var_538_11 + var_538_18 then
				arg_535_1.typewritter.percent = (arg_535_1.time_ - var_538_11) / var_538_18

				arg_535_1.typewritter:SetDirty()
			end

			if arg_535_1.time_ >= var_538_11 + var_538_18 and arg_535_1.time_ < var_538_11 + var_538_18 + arg_538_0 then
				arg_535_1.typewritter.percent = 1

				arg_535_1.typewritter:SetDirty()
				arg_535_1:ShowNextGo(true)
			end
		end

		arg_535_1.nodeConfigList_ = {}

		arg_535_1:InitPlayNodeList()
	end,
	Play115311132 = function(arg_539_0, arg_539_1)
		arg_539_1.time_ = 0
		arg_539_1.frameCnt_ = 0
		arg_539_1.state_ = "playing"
		arg_539_1.curTalkId_ = 115311132
		arg_539_1.duration_ = 4.57

		local var_539_0 = {
			ja = 2.666,
			ko = 3.733,
			zh = 4.566,
			en = 3.8
		}
		local var_539_1 = manager.audio:GetLocalizationFlag()

		if var_539_0[var_539_1] ~= nil then
			arg_539_1.duration_ = var_539_0[var_539_1]
		end

		SetActive(arg_539_1.tipsGo_, false)

		function arg_539_1.onSingleLineFinish_()
			arg_539_1.onSingleLineUpdate_ = nil
			arg_539_1.onSingleLineFinish_ = nil
			arg_539_1.state_ = "waiting"
		end

		function arg_539_1.playNext_(arg_541_0)
			if arg_541_0 == 1 then
				arg_539_0:Play115311133(arg_539_1)
			end
		end

		function arg_539_1.onSingleLineUpdate_(arg_542_0)
			local var_542_0 = arg_539_1.actors_["113801_1"]
			local var_542_1 = 0

			if var_542_1 < arg_539_1.time_ and arg_539_1.time_ <= var_542_1 + arg_542_0 and not isNil(var_542_0) then
				local var_542_2 = var_542_0:GetComponent("Image")

				if var_542_2 then
					arg_539_1.var_.highlightMatValue113801_1 = var_542_2
				end
			end

			local var_542_3 = 0.2

			if var_542_1 <= arg_539_1.time_ and arg_539_1.time_ < var_542_1 + var_542_3 and not isNil(var_542_0) then
				local var_542_4 = (arg_539_1.time_ - var_542_1) / var_542_3

				if arg_539_1.var_.highlightMatValue113801_1 then
					local var_542_5 = Mathf.Lerp(0.5, 1, var_542_4)
					local var_542_6 = arg_539_1.var_.highlightMatValue113801_1
					local var_542_7 = var_542_6.color

					var_542_7.r = var_542_5
					var_542_7.g = var_542_5
					var_542_7.b = var_542_5
					var_542_6.color = var_542_7
				end
			end

			if arg_539_1.time_ >= var_542_1 + var_542_3 and arg_539_1.time_ < var_542_1 + var_542_3 + arg_542_0 and not isNil(var_542_0) and arg_539_1.var_.highlightMatValue113801_1 then
				local var_542_8 = 1

				var_542_0.transform:SetSiblingIndex(1)

				local var_542_9 = arg_539_1.var_.highlightMatValue113801_1
				local var_542_10 = var_542_9.color

				var_542_10.r = var_542_8
				var_542_10.g = var_542_8
				var_542_10.b = var_542_8
				var_542_9.color = var_542_10
			end

			local var_542_11 = 0
			local var_542_12 = 0.275

			if var_542_11 < arg_539_1.time_ and arg_539_1.time_ <= var_542_11 + arg_542_0 then
				arg_539_1.talkMaxDuration = 0
				arg_539_1.dialogCg_.alpha = 1

				arg_539_1.dialog_:SetActive(true)
				SetActive(arg_539_1.leftNameGo_, true)

				local var_542_13 = arg_539_1:FormatText(StoryNameCfg[94].name)

				arg_539_1.leftNameTxt_.text = var_542_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_539_1.leftNameTxt_.transform)

				arg_539_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_539_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_539_1:RecordName(arg_539_1.leftNameTxt_.text)
				SetActive(arg_539_1.iconTrs_.gameObject, false)
				arg_539_1.callingController_:SetSelectedState("normal")

				local var_542_14 = arg_539_1:GetWordFromCfg(115311132)
				local var_542_15 = arg_539_1:FormatText(var_542_14.content)

				arg_539_1.text_.text = var_542_15

				LuaForUtil.ClearLinePrefixSymbol(arg_539_1.text_)

				local var_542_16 = 11
				local var_542_17 = utf8.len(var_542_15)
				local var_542_18 = var_542_16 <= 0 and var_542_12 or var_542_12 * (var_542_17 / var_542_16)

				if var_542_18 > 0 and var_542_12 < var_542_18 then
					arg_539_1.talkMaxDuration = var_542_18

					if var_542_18 + var_542_11 > arg_539_1.duration_ then
						arg_539_1.duration_ = var_542_18 + var_542_11
					end
				end

				arg_539_1.text_.text = var_542_15
				arg_539_1.typewritter.percent = 0

				arg_539_1.typewritter:SetDirty()
				arg_539_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311132", "story_v_out_115311.awb") ~= 0 then
					local var_542_19 = manager.audio:GetVoiceLength("story_v_out_115311", "115311132", "story_v_out_115311.awb") / 1000

					if var_542_19 + var_542_11 > arg_539_1.duration_ then
						arg_539_1.duration_ = var_542_19 + var_542_11
					end

					if var_542_14.prefab_name ~= "" and arg_539_1.actors_[var_542_14.prefab_name] ~= nil then
						local var_542_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_539_1.actors_[var_542_14.prefab_name].transform, "story_v_out_115311", "115311132", "story_v_out_115311.awb")

						arg_539_1:RecordAudio("115311132", var_542_20)
						arg_539_1:RecordAudio("115311132", var_542_20)
					else
						arg_539_1:AudioAction("play", "voice", "story_v_out_115311", "115311132", "story_v_out_115311.awb")
					end

					arg_539_1:RecordHistoryTalkVoice("story_v_out_115311", "115311132", "story_v_out_115311.awb")
				end

				arg_539_1:RecordContent(arg_539_1.text_.text)
			end

			local var_542_21 = math.max(var_542_12, arg_539_1.talkMaxDuration)

			if var_542_11 <= arg_539_1.time_ and arg_539_1.time_ < var_542_11 + var_542_21 then
				arg_539_1.typewritter.percent = (arg_539_1.time_ - var_542_11) / var_542_21

				arg_539_1.typewritter:SetDirty()
			end

			if arg_539_1.time_ >= var_542_11 + var_542_21 and arg_539_1.time_ < var_542_11 + var_542_21 + arg_542_0 then
				arg_539_1.typewritter.percent = 1

				arg_539_1.typewritter:SetDirty()
				arg_539_1:ShowNextGo(true)
			end
		end

		arg_539_1.nodeConfigList_ = {}

		arg_539_1:InitPlayNodeList()
	end,
	Play115311133 = function(arg_543_0, arg_543_1)
		arg_543_1.time_ = 0
		arg_543_1.frameCnt_ = 0
		arg_543_1.state_ = "playing"
		arg_543_1.curTalkId_ = 115311133
		arg_543_1.duration_ = 9

		SetActive(arg_543_1.tipsGo_, false)

		function arg_543_1.onSingleLineFinish_()
			arg_543_1.onSingleLineUpdate_ = nil
			arg_543_1.onSingleLineFinish_ = nil
			arg_543_1.state_ = "waiting"
		end

		function arg_543_1.playNext_(arg_545_0)
			if arg_545_0 == 1 then
				arg_543_0:Play115311134(arg_543_1)
			end
		end

		function arg_543_1.onSingleLineUpdate_(arg_546_0)
			local var_546_0 = 2

			if var_546_0 < arg_543_1.time_ and arg_543_1.time_ <= var_546_0 + arg_546_0 then
				local var_546_1 = manager.ui.mainCamera.transform.localPosition
				local var_546_2 = Vector3.New(0, 0, 10) + Vector3.New(var_546_1.x, var_546_1.y, 0)
				local var_546_3 = arg_543_1.bgs_.ST22a

				var_546_3.transform.localPosition = var_546_2
				var_546_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_546_4 = var_546_3:GetComponent("SpriteRenderer")

				if var_546_4 and var_546_4.sprite then
					local var_546_5 = (var_546_3.transform.localPosition - var_546_1).z
					local var_546_6 = manager.ui.mainCameraCom_
					local var_546_7 = 2 * var_546_5 * Mathf.Tan(var_546_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_546_8 = var_546_7 * var_546_6.aspect
					local var_546_9 = var_546_4.sprite.bounds.size.x
					local var_546_10 = var_546_4.sprite.bounds.size.y
					local var_546_11 = var_546_8 / var_546_9
					local var_546_12 = var_546_7 / var_546_10
					local var_546_13 = var_546_12 < var_546_11 and var_546_11 or var_546_12

					var_546_3.transform.localScale = Vector3.New(var_546_13, var_546_13, 0)
				end

				for iter_546_0, iter_546_1 in pairs(arg_543_1.bgs_) do
					if iter_546_0 ~= "ST22a" then
						iter_546_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_546_14 = 0

			if var_546_14 < arg_543_1.time_ and arg_543_1.time_ <= var_546_14 + arg_546_0 then
				arg_543_1.mask_.enabled = true
				arg_543_1.mask_.raycastTarget = true

				arg_543_1:SetGaussion(false)
			end

			local var_546_15 = 2

			if var_546_14 <= arg_543_1.time_ and arg_543_1.time_ < var_546_14 + var_546_15 then
				local var_546_16 = (arg_543_1.time_ - var_546_14) / var_546_15
				local var_546_17 = Color.New(0, 0, 0)

				var_546_17.a = Mathf.Lerp(0, 1, var_546_16)
				arg_543_1.mask_.color = var_546_17
			end

			if arg_543_1.time_ >= var_546_14 + var_546_15 and arg_543_1.time_ < var_546_14 + var_546_15 + arg_546_0 then
				local var_546_18 = Color.New(0, 0, 0)

				var_546_18.a = 1
				arg_543_1.mask_.color = var_546_18
			end

			local var_546_19 = 2

			if var_546_19 < arg_543_1.time_ and arg_543_1.time_ <= var_546_19 + arg_546_0 then
				arg_543_1.mask_.enabled = true
				arg_543_1.mask_.raycastTarget = true

				arg_543_1:SetGaussion(false)
			end

			local var_546_20 = 2

			if var_546_19 <= arg_543_1.time_ and arg_543_1.time_ < var_546_19 + var_546_20 then
				local var_546_21 = (arg_543_1.time_ - var_546_19) / var_546_20
				local var_546_22 = Color.New(0, 0, 0)

				var_546_22.a = Mathf.Lerp(1, 0, var_546_21)
				arg_543_1.mask_.color = var_546_22
			end

			if arg_543_1.time_ >= var_546_19 + var_546_20 and arg_543_1.time_ < var_546_19 + var_546_20 + arg_546_0 then
				local var_546_23 = Color.New(0, 0, 0)
				local var_546_24 = 0

				arg_543_1.mask_.enabled = false
				var_546_23.a = var_546_24
				arg_543_1.mask_.color = var_546_23
			end

			local var_546_25 = arg_543_1.actors_["113801_1"].transform
			local var_546_26 = 1.966

			if var_546_26 < arg_543_1.time_ and arg_543_1.time_ <= var_546_26 + arg_546_0 then
				arg_543_1.var_.moveOldPos113801_1 = var_546_25.localPosition
				var_546_25.localScale = Vector3.New(1, 1, 1)

				arg_543_1:CheckSpriteTmpPos("113801_1", 7)
			end

			local var_546_27 = 0.001

			if var_546_26 <= arg_543_1.time_ and arg_543_1.time_ < var_546_26 + var_546_27 then
				local var_546_28 = (arg_543_1.time_ - var_546_26) / var_546_27
				local var_546_29 = Vector3.New(0, -2000, -370)

				var_546_25.localPosition = Vector3.Lerp(arg_543_1.var_.moveOldPos113801_1, var_546_29, var_546_28)
			end

			if arg_543_1.time_ >= var_546_26 + var_546_27 and arg_543_1.time_ < var_546_26 + var_546_27 + arg_546_0 then
				var_546_25.localPosition = Vector3.New(0, -2000, -370)
			end

			if arg_543_1.frameCnt_ <= 1 then
				arg_543_1.dialog_:SetActive(false)
			end

			local var_546_30 = 4
			local var_546_31 = 0.575

			if var_546_30 < arg_543_1.time_ and arg_543_1.time_ <= var_546_30 + arg_546_0 then
				arg_543_1.talkMaxDuration = 0

				arg_543_1.dialog_:SetActive(true)

				arg_543_1.dialogCg_.alpha = 0

				local var_546_32 = LeanTween.value(arg_543_1.dialog_, 0, 1, 0.3)

				var_546_32:setOnUpdate(LuaHelper.FloatAction(function(arg_547_0)
					arg_543_1.dialogCg_.alpha = arg_547_0
				end))
				var_546_32:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_543_1.dialog_)
					var_546_32:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_543_1.duration_ = arg_543_1.duration_ + 0.3

				SetActive(arg_543_1.leftNameGo_, false)

				arg_543_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_543_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_543_1:RecordName(arg_543_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_543_1.iconTrs_.gameObject, false)
				arg_543_1.callingController_:SetSelectedState("normal")

				local var_546_33 = arg_543_1:GetWordFromCfg(115311133)
				local var_546_34 = arg_543_1:FormatText(var_546_33.content)

				arg_543_1.text_.text = var_546_34

				LuaForUtil.ClearLinePrefixSymbol(arg_543_1.text_)

				local var_546_35 = 23
				local var_546_36 = utf8.len(var_546_34)
				local var_546_37 = var_546_35 <= 0 and var_546_31 or var_546_31 * (var_546_36 / var_546_35)

				if var_546_37 > 0 and var_546_31 < var_546_37 then
					arg_543_1.talkMaxDuration = var_546_37
					var_546_30 = var_546_30 + 0.3

					if var_546_37 + var_546_30 > arg_543_1.duration_ then
						arg_543_1.duration_ = var_546_37 + var_546_30
					end
				end

				arg_543_1.text_.text = var_546_34
				arg_543_1.typewritter.percent = 0

				arg_543_1.typewritter:SetDirty()
				arg_543_1:ShowNextGo(false)
				arg_543_1:RecordContent(arg_543_1.text_.text)
			end

			local var_546_38 = var_546_30 + 0.3
			local var_546_39 = math.max(var_546_31, arg_543_1.talkMaxDuration)

			if var_546_38 <= arg_543_1.time_ and arg_543_1.time_ < var_546_38 + var_546_39 then
				arg_543_1.typewritter.percent = (arg_543_1.time_ - var_546_38) / var_546_39

				arg_543_1.typewritter:SetDirty()
			end

			if arg_543_1.time_ >= var_546_38 + var_546_39 and arg_543_1.time_ < var_546_38 + var_546_39 + arg_546_0 then
				arg_543_1.typewritter.percent = 1

				arg_543_1.typewritter:SetDirty()
				arg_543_1:ShowNextGo(true)
			end
		end

		arg_543_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "113801_1",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Sprite
			}
		}

		arg_543_1:InitPlayNodeList()
	end,
	Play115311134 = function(arg_549_0, arg_549_1)
		arg_549_1.time_ = 0
		arg_549_1.frameCnt_ = 0
		arg_549_1.state_ = "playing"
		arg_549_1.curTalkId_ = 115311134
		arg_549_1.duration_ = 5

		SetActive(arg_549_1.tipsGo_, false)

		function arg_549_1.onSingleLineFinish_()
			arg_549_1.onSingleLineUpdate_ = nil
			arg_549_1.onSingleLineFinish_ = nil
			arg_549_1.state_ = "waiting"
		end

		function arg_549_1.playNext_(arg_551_0)
			if arg_551_0 == 1 then
				arg_549_0:Play115311135(arg_549_1)
			end
		end

		function arg_549_1.onSingleLineUpdate_(arg_552_0)
			local var_552_0 = 0
			local var_552_1 = 0.75

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

				local var_552_2 = arg_549_1:GetWordFromCfg(115311134)
				local var_552_3 = arg_549_1:FormatText(var_552_2.content)

				arg_549_1.text_.text = var_552_3

				LuaForUtil.ClearLinePrefixSymbol(arg_549_1.text_)

				local var_552_4 = 30
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
	Play115311135 = function(arg_553_0, arg_553_1)
		arg_553_1.time_ = 0
		arg_553_1.frameCnt_ = 0
		arg_553_1.state_ = "playing"
		arg_553_1.curTalkId_ = 115311135
		arg_553_1.duration_ = 12.83

		local var_553_0 = {
			ja = 12.833,
			ko = 5.466,
			zh = 8.133,
			en = 6.966
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
				arg_553_0:Play115311136(arg_553_1)
			end
		end

		function arg_553_1.onSingleLineUpdate_(arg_556_0)
			local var_556_0 = arg_553_1.actors_["10030"]
			local var_556_1 = 0

			if var_556_1 < arg_553_1.time_ and arg_553_1.time_ <= var_556_1 + arg_556_0 then
				local var_556_2 = var_556_0:GetComponentInChildren(typeof(CanvasGroup))

				if var_556_2 then
					arg_553_1.var_.alphaOldValue10030 = var_556_2.alpha
					arg_553_1.var_.characterEffect10030 = var_556_2
				end

				arg_553_1.var_.alphaOldValue10030 = 0
			end

			local var_556_3 = 0.5

			if var_556_1 <= arg_553_1.time_ and arg_553_1.time_ < var_556_1 + var_556_3 then
				local var_556_4 = (arg_553_1.time_ - var_556_1) / var_556_3
				local var_556_5 = Mathf.Lerp(arg_553_1.var_.alphaOldValue10030, 1, var_556_4)

				if arg_553_1.var_.characterEffect10030 then
					arg_553_1.var_.characterEffect10030.alpha = var_556_5
				end
			end

			if arg_553_1.time_ >= var_556_1 + var_556_3 and arg_553_1.time_ < var_556_1 + var_556_3 + arg_556_0 and arg_553_1.var_.characterEffect10030 then
				arg_553_1.var_.characterEffect10030.alpha = 1
			end

			local var_556_6 = arg_553_1.actors_["10030"]
			local var_556_7 = 0

			if var_556_7 < arg_553_1.time_ and arg_553_1.time_ <= var_556_7 + arg_556_0 and not isNil(var_556_6) and arg_553_1.var_.actorSpriteComps10030 == nil then
				arg_553_1.var_.actorSpriteComps10030 = var_556_6:GetComponentsInChildren(typeof(Image), true)
			end

			local var_556_8 = 0.2

			if var_556_7 <= arg_553_1.time_ and arg_553_1.time_ < var_556_7 + var_556_8 and not isNil(var_556_6) then
				local var_556_9 = (arg_553_1.time_ - var_556_7) / var_556_8

				if arg_553_1.var_.actorSpriteComps10030 then
					for iter_556_0, iter_556_1 in pairs(arg_553_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_556_1 then
							if arg_553_1.isInRecall_ then
								local var_556_10 = Mathf.Lerp(iter_556_1.color.r, arg_553_1.hightColor1.r, var_556_9)
								local var_556_11 = Mathf.Lerp(iter_556_1.color.g, arg_553_1.hightColor1.g, var_556_9)
								local var_556_12 = Mathf.Lerp(iter_556_1.color.b, arg_553_1.hightColor1.b, var_556_9)

								iter_556_1.color = Color.New(var_556_10, var_556_11, var_556_12)
							else
								local var_556_13 = Mathf.Lerp(iter_556_1.color.r, 1, var_556_9)

								iter_556_1.color = Color.New(var_556_13, var_556_13, var_556_13)
							end
						end
					end
				end
			end

			if arg_553_1.time_ >= var_556_7 + var_556_8 and arg_553_1.time_ < var_556_7 + var_556_8 + arg_556_0 and not isNil(var_556_6) and arg_553_1.var_.actorSpriteComps10030 then
				for iter_556_2, iter_556_3 in pairs(arg_553_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_556_3 then
						if arg_553_1.isInRecall_ then
							iter_556_3.color = arg_553_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_556_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_553_1.var_.actorSpriteComps10030 = nil
			end

			local var_556_14 = arg_553_1.actors_["10030"].transform
			local var_556_15 = 0

			if var_556_15 < arg_553_1.time_ and arg_553_1.time_ <= var_556_15 + arg_556_0 then
				arg_553_1.var_.moveOldPos10030 = var_556_14.localPosition
				var_556_14.localScale = Vector3.New(1, 1, 1)

				arg_553_1:CheckSpriteTmpPos("10030", 3)

				local var_556_16 = var_556_14.childCount

				for iter_556_4 = 0, var_556_16 - 1 do
					local var_556_17 = var_556_14:GetChild(iter_556_4)

					if var_556_17.name == "split_2" or not string.find(var_556_17.name, "split") then
						var_556_17.gameObject:SetActive(true)
					else
						var_556_17.gameObject:SetActive(false)
					end
				end
			end

			local var_556_18 = 0.001

			if var_556_15 <= arg_553_1.time_ and arg_553_1.time_ < var_556_15 + var_556_18 then
				local var_556_19 = (arg_553_1.time_ - var_556_15) / var_556_18
				local var_556_20 = Vector3.New(0, -390, 150)

				var_556_14.localPosition = Vector3.Lerp(arg_553_1.var_.moveOldPos10030, var_556_20, var_556_19)
			end

			if arg_553_1.time_ >= var_556_15 + var_556_18 and arg_553_1.time_ < var_556_15 + var_556_18 + arg_556_0 then
				var_556_14.localPosition = Vector3.New(0, -390, 150)
			end

			local var_556_21 = 0
			local var_556_22 = 0.525

			if var_556_21 < arg_553_1.time_ and arg_553_1.time_ <= var_556_21 + arg_556_0 then
				arg_553_1.talkMaxDuration = 0
				arg_553_1.dialogCg_.alpha = 1

				arg_553_1.dialog_:SetActive(true)
				SetActive(arg_553_1.leftNameGo_, true)

				local var_556_23 = arg_553_1:FormatText(StoryNameCfg[309].name)

				arg_553_1.leftNameTxt_.text = var_556_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_553_1.leftNameTxt_.transform)

				arg_553_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_553_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_553_1:RecordName(arg_553_1.leftNameTxt_.text)
				SetActive(arg_553_1.iconTrs_.gameObject, false)
				arg_553_1.callingController_:SetSelectedState("normal")

				local var_556_24 = arg_553_1:GetWordFromCfg(115311135)
				local var_556_25 = arg_553_1:FormatText(var_556_24.content)

				arg_553_1.text_.text = var_556_25

				LuaForUtil.ClearLinePrefixSymbol(arg_553_1.text_)

				local var_556_26 = 21
				local var_556_27 = utf8.len(var_556_25)
				local var_556_28 = var_556_26 <= 0 and var_556_22 or var_556_22 * (var_556_27 / var_556_26)

				if var_556_28 > 0 and var_556_22 < var_556_28 then
					arg_553_1.talkMaxDuration = var_556_28

					if var_556_28 + var_556_21 > arg_553_1.duration_ then
						arg_553_1.duration_ = var_556_28 + var_556_21
					end
				end

				arg_553_1.text_.text = var_556_25
				arg_553_1.typewritter.percent = 0

				arg_553_1.typewritter:SetDirty()
				arg_553_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311135", "story_v_out_115311.awb") ~= 0 then
					local var_556_29 = manager.audio:GetVoiceLength("story_v_out_115311", "115311135", "story_v_out_115311.awb") / 1000

					if var_556_29 + var_556_21 > arg_553_1.duration_ then
						arg_553_1.duration_ = var_556_29 + var_556_21
					end

					if var_556_24.prefab_name ~= "" and arg_553_1.actors_[var_556_24.prefab_name] ~= nil then
						local var_556_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_553_1.actors_[var_556_24.prefab_name].transform, "story_v_out_115311", "115311135", "story_v_out_115311.awb")

						arg_553_1:RecordAudio("115311135", var_556_30)
						arg_553_1:RecordAudio("115311135", var_556_30)
					else
						arg_553_1:AudioAction("play", "voice", "story_v_out_115311", "115311135", "story_v_out_115311.awb")
					end

					arg_553_1:RecordHistoryTalkVoice("story_v_out_115311", "115311135", "story_v_out_115311.awb")
				end

				arg_553_1:RecordContent(arg_553_1.text_.text)
			end

			local var_556_31 = math.max(var_556_22, arg_553_1.talkMaxDuration)

			if var_556_21 <= arg_553_1.time_ and arg_553_1.time_ < var_556_21 + var_556_31 then
				arg_553_1.typewritter.percent = (arg_553_1.time_ - var_556_21) / var_556_31

				arg_553_1.typewritter:SetDirty()
			end

			if arg_553_1.time_ >= var_556_21 + var_556_31 and arg_553_1.time_ < var_556_21 + var_556_31 + arg_556_0 then
				arg_553_1.typewritter.percent = 1

				arg_553_1.typewritter:SetDirty()
				arg_553_1:ShowNextGo(true)
			end
		end

		arg_553_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10030",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_553_1:InitPlayNodeList()
	end,
	Play115311136 = function(arg_557_0, arg_557_1)
		arg_557_1.time_ = 0
		arg_557_1.frameCnt_ = 0
		arg_557_1.state_ = "playing"
		arg_557_1.curTalkId_ = 115311136
		arg_557_1.duration_ = 5

		SetActive(arg_557_1.tipsGo_, false)

		function arg_557_1.onSingleLineFinish_()
			arg_557_1.onSingleLineUpdate_ = nil
			arg_557_1.onSingleLineFinish_ = nil
			arg_557_1.state_ = "waiting"
		end

		function arg_557_1.playNext_(arg_559_0)
			if arg_559_0 == 1 then
				arg_557_0:Play115311137(arg_557_1)
			end
		end

		function arg_557_1.onSingleLineUpdate_(arg_560_0)
			local var_560_0 = arg_557_1.actors_["10030"]
			local var_560_1 = 0

			if var_560_1 < arg_557_1.time_ and arg_557_1.time_ <= var_560_1 + arg_560_0 and not isNil(var_560_0) and arg_557_1.var_.actorSpriteComps10030 == nil then
				arg_557_1.var_.actorSpriteComps10030 = var_560_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_560_2 = 0.2

			if var_560_1 <= arg_557_1.time_ and arg_557_1.time_ < var_560_1 + var_560_2 and not isNil(var_560_0) then
				local var_560_3 = (arg_557_1.time_ - var_560_1) / var_560_2

				if arg_557_1.var_.actorSpriteComps10030 then
					for iter_560_0, iter_560_1 in pairs(arg_557_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_560_1 then
							if arg_557_1.isInRecall_ then
								local var_560_4 = Mathf.Lerp(iter_560_1.color.r, arg_557_1.hightColor2.r, var_560_3)
								local var_560_5 = Mathf.Lerp(iter_560_1.color.g, arg_557_1.hightColor2.g, var_560_3)
								local var_560_6 = Mathf.Lerp(iter_560_1.color.b, arg_557_1.hightColor2.b, var_560_3)

								iter_560_1.color = Color.New(var_560_4, var_560_5, var_560_6)
							else
								local var_560_7 = Mathf.Lerp(iter_560_1.color.r, 0.5, var_560_3)

								iter_560_1.color = Color.New(var_560_7, var_560_7, var_560_7)
							end
						end
					end
				end
			end

			if arg_557_1.time_ >= var_560_1 + var_560_2 and arg_557_1.time_ < var_560_1 + var_560_2 + arg_560_0 and not isNil(var_560_0) and arg_557_1.var_.actorSpriteComps10030 then
				for iter_560_2, iter_560_3 in pairs(arg_557_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_560_3 then
						if arg_557_1.isInRecall_ then
							iter_560_3.color = arg_557_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_560_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_557_1.var_.actorSpriteComps10030 = nil
			end

			local var_560_8 = 0
			local var_560_9 = 0.85

			if var_560_8 < arg_557_1.time_ and arg_557_1.time_ <= var_560_8 + arg_560_0 then
				arg_557_1.talkMaxDuration = 0
				arg_557_1.dialogCg_.alpha = 1

				arg_557_1.dialog_:SetActive(true)
				SetActive(arg_557_1.leftNameGo_, false)

				arg_557_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_557_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_557_1:RecordName(arg_557_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_557_1.iconTrs_.gameObject, false)
				arg_557_1.callingController_:SetSelectedState("normal")

				local var_560_10 = arg_557_1:GetWordFromCfg(115311136)
				local var_560_11 = arg_557_1:FormatText(var_560_10.content)

				arg_557_1.text_.text = var_560_11

				LuaForUtil.ClearLinePrefixSymbol(arg_557_1.text_)

				local var_560_12 = 34
				local var_560_13 = utf8.len(var_560_11)
				local var_560_14 = var_560_12 <= 0 and var_560_9 or var_560_9 * (var_560_13 / var_560_12)

				if var_560_14 > 0 and var_560_9 < var_560_14 then
					arg_557_1.talkMaxDuration = var_560_14

					if var_560_14 + var_560_8 > arg_557_1.duration_ then
						arg_557_1.duration_ = var_560_14 + var_560_8
					end
				end

				arg_557_1.text_.text = var_560_11
				arg_557_1.typewritter.percent = 0

				arg_557_1.typewritter:SetDirty()
				arg_557_1:ShowNextGo(false)
				arg_557_1:RecordContent(arg_557_1.text_.text)
			end

			local var_560_15 = math.max(var_560_9, arg_557_1.talkMaxDuration)

			if var_560_8 <= arg_557_1.time_ and arg_557_1.time_ < var_560_8 + var_560_15 then
				arg_557_1.typewritter.percent = (arg_557_1.time_ - var_560_8) / var_560_15

				arg_557_1.typewritter:SetDirty()
			end

			if arg_557_1.time_ >= var_560_8 + var_560_15 and arg_557_1.time_ < var_560_8 + var_560_15 + arg_560_0 then
				arg_557_1.typewritter.percent = 1

				arg_557_1.typewritter:SetDirty()
				arg_557_1:ShowNextGo(true)
			end
		end

		arg_557_1.nodeConfigList_ = {}

		arg_557_1:InitPlayNodeList()
	end,
	Play115311137 = function(arg_561_0, arg_561_1)
		arg_561_1.time_ = 0
		arg_561_1.frameCnt_ = 0
		arg_561_1.state_ = "playing"
		arg_561_1.curTalkId_ = 115311137
		arg_561_1.duration_ = 9.57

		local var_561_0 = {
			ja = 7,
			ko = 8.066,
			zh = 9.566,
			en = 9.533
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
				arg_561_0:Play115311138(arg_561_1)
			end
		end

		function arg_561_1.onSingleLineUpdate_(arg_564_0)
			local var_564_0 = arg_561_1.actors_["10030"]
			local var_564_1 = 0

			if var_564_1 < arg_561_1.time_ and arg_561_1.time_ <= var_564_1 + arg_564_0 and not isNil(var_564_0) and arg_561_1.var_.actorSpriteComps10030 == nil then
				arg_561_1.var_.actorSpriteComps10030 = var_564_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_564_2 = 0.2

			if var_564_1 <= arg_561_1.time_ and arg_561_1.time_ < var_564_1 + var_564_2 and not isNil(var_564_0) then
				local var_564_3 = (arg_561_1.time_ - var_564_1) / var_564_2

				if arg_561_1.var_.actorSpriteComps10030 then
					for iter_564_0, iter_564_1 in pairs(arg_561_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_564_1 then
							if arg_561_1.isInRecall_ then
								local var_564_4 = Mathf.Lerp(iter_564_1.color.r, arg_561_1.hightColor1.r, var_564_3)
								local var_564_5 = Mathf.Lerp(iter_564_1.color.g, arg_561_1.hightColor1.g, var_564_3)
								local var_564_6 = Mathf.Lerp(iter_564_1.color.b, arg_561_1.hightColor1.b, var_564_3)

								iter_564_1.color = Color.New(var_564_4, var_564_5, var_564_6)
							else
								local var_564_7 = Mathf.Lerp(iter_564_1.color.r, 1, var_564_3)

								iter_564_1.color = Color.New(var_564_7, var_564_7, var_564_7)
							end
						end
					end
				end
			end

			if arg_561_1.time_ >= var_564_1 + var_564_2 and arg_561_1.time_ < var_564_1 + var_564_2 + arg_564_0 and not isNil(var_564_0) and arg_561_1.var_.actorSpriteComps10030 then
				for iter_564_2, iter_564_3 in pairs(arg_561_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_564_3 then
						if arg_561_1.isInRecall_ then
							iter_564_3.color = arg_561_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_564_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_561_1.var_.actorSpriteComps10030 = nil
			end

			local var_564_8 = 0
			local var_564_9 = 1.05

			if var_564_8 < arg_561_1.time_ and arg_561_1.time_ <= var_564_8 + arg_564_0 then
				arg_561_1.talkMaxDuration = 0
				arg_561_1.dialogCg_.alpha = 1

				arg_561_1.dialog_:SetActive(true)
				SetActive(arg_561_1.leftNameGo_, true)

				local var_564_10 = arg_561_1:FormatText(StoryNameCfg[309].name)

				arg_561_1.leftNameTxt_.text = var_564_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_561_1.leftNameTxt_.transform)

				arg_561_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_561_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_561_1:RecordName(arg_561_1.leftNameTxt_.text)
				SetActive(arg_561_1.iconTrs_.gameObject, false)
				arg_561_1.callingController_:SetSelectedState("normal")

				local var_564_11 = arg_561_1:GetWordFromCfg(115311137)
				local var_564_12 = arg_561_1:FormatText(var_564_11.content)

				arg_561_1.text_.text = var_564_12

				LuaForUtil.ClearLinePrefixSymbol(arg_561_1.text_)

				local var_564_13 = 42
				local var_564_14 = utf8.len(var_564_12)
				local var_564_15 = var_564_13 <= 0 and var_564_9 or var_564_9 * (var_564_14 / var_564_13)

				if var_564_15 > 0 and var_564_9 < var_564_15 then
					arg_561_1.talkMaxDuration = var_564_15

					if var_564_15 + var_564_8 > arg_561_1.duration_ then
						arg_561_1.duration_ = var_564_15 + var_564_8
					end
				end

				arg_561_1.text_.text = var_564_12
				arg_561_1.typewritter.percent = 0

				arg_561_1.typewritter:SetDirty()
				arg_561_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311137", "story_v_out_115311.awb") ~= 0 then
					local var_564_16 = manager.audio:GetVoiceLength("story_v_out_115311", "115311137", "story_v_out_115311.awb") / 1000

					if var_564_16 + var_564_8 > arg_561_1.duration_ then
						arg_561_1.duration_ = var_564_16 + var_564_8
					end

					if var_564_11.prefab_name ~= "" and arg_561_1.actors_[var_564_11.prefab_name] ~= nil then
						local var_564_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_561_1.actors_[var_564_11.prefab_name].transform, "story_v_out_115311", "115311137", "story_v_out_115311.awb")

						arg_561_1:RecordAudio("115311137", var_564_17)
						arg_561_1:RecordAudio("115311137", var_564_17)
					else
						arg_561_1:AudioAction("play", "voice", "story_v_out_115311", "115311137", "story_v_out_115311.awb")
					end

					arg_561_1:RecordHistoryTalkVoice("story_v_out_115311", "115311137", "story_v_out_115311.awb")
				end

				arg_561_1:RecordContent(arg_561_1.text_.text)
			end

			local var_564_18 = math.max(var_564_9, arg_561_1.talkMaxDuration)

			if var_564_8 <= arg_561_1.time_ and arg_561_1.time_ < var_564_8 + var_564_18 then
				arg_561_1.typewritter.percent = (arg_561_1.time_ - var_564_8) / var_564_18

				arg_561_1.typewritter:SetDirty()
			end

			if arg_561_1.time_ >= var_564_8 + var_564_18 and arg_561_1.time_ < var_564_8 + var_564_18 + arg_564_0 then
				arg_561_1.typewritter.percent = 1

				arg_561_1.typewritter:SetDirty()
				arg_561_1:ShowNextGo(true)
			end
		end

		arg_561_1.nodeConfigList_ = {}

		arg_561_1:InitPlayNodeList()
	end,
	Play115311138 = function(arg_565_0, arg_565_1)
		arg_565_1.time_ = 0
		arg_565_1.frameCnt_ = 0
		arg_565_1.state_ = "playing"
		arg_565_1.curTalkId_ = 115311138
		arg_565_1.duration_ = 7.1

		local var_565_0 = {
			ja = 4.5,
			ko = 3.9,
			zh = 4.2,
			en = 7.1
		}
		local var_565_1 = manager.audio:GetLocalizationFlag()

		if var_565_0[var_565_1] ~= nil then
			arg_565_1.duration_ = var_565_0[var_565_1]
		end

		SetActive(arg_565_1.tipsGo_, false)

		function arg_565_1.onSingleLineFinish_()
			arg_565_1.onSingleLineUpdate_ = nil
			arg_565_1.onSingleLineFinish_ = nil
			arg_565_1.state_ = "waiting"
		end

		function arg_565_1.playNext_(arg_567_0)
			if arg_567_0 == 1 then
				arg_565_0:Play115311139(arg_565_1)
			end
		end

		function arg_565_1.onSingleLineUpdate_(arg_568_0)
			local var_568_0 = 0
			local var_568_1 = 0.525

			if var_568_0 < arg_565_1.time_ and arg_565_1.time_ <= var_568_0 + arg_568_0 then
				arg_565_1.talkMaxDuration = 0
				arg_565_1.dialogCg_.alpha = 1

				arg_565_1.dialog_:SetActive(true)
				SetActive(arg_565_1.leftNameGo_, true)

				local var_568_2 = arg_565_1:FormatText(StoryNameCfg[309].name)

				arg_565_1.leftNameTxt_.text = var_568_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_565_1.leftNameTxt_.transform)

				arg_565_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_565_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_565_1:RecordName(arg_565_1.leftNameTxt_.text)
				SetActive(arg_565_1.iconTrs_.gameObject, false)
				arg_565_1.callingController_:SetSelectedState("normal")

				local var_568_3 = arg_565_1:GetWordFromCfg(115311138)
				local var_568_4 = arg_565_1:FormatText(var_568_3.content)

				arg_565_1.text_.text = var_568_4

				LuaForUtil.ClearLinePrefixSymbol(arg_565_1.text_)

				local var_568_5 = 21
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

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311138", "story_v_out_115311.awb") ~= 0 then
					local var_568_8 = manager.audio:GetVoiceLength("story_v_out_115311", "115311138", "story_v_out_115311.awb") / 1000

					if var_568_8 + var_568_0 > arg_565_1.duration_ then
						arg_565_1.duration_ = var_568_8 + var_568_0
					end

					if var_568_3.prefab_name ~= "" and arg_565_1.actors_[var_568_3.prefab_name] ~= nil then
						local var_568_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_565_1.actors_[var_568_3.prefab_name].transform, "story_v_out_115311", "115311138", "story_v_out_115311.awb")

						arg_565_1:RecordAudio("115311138", var_568_9)
						arg_565_1:RecordAudio("115311138", var_568_9)
					else
						arg_565_1:AudioAction("play", "voice", "story_v_out_115311", "115311138", "story_v_out_115311.awb")
					end

					arg_565_1:RecordHistoryTalkVoice("story_v_out_115311", "115311138", "story_v_out_115311.awb")
				end

				arg_565_1:RecordContent(arg_565_1.text_.text)
			end

			local var_568_10 = math.max(var_568_1, arg_565_1.talkMaxDuration)

			if var_568_0 <= arg_565_1.time_ and arg_565_1.time_ < var_568_0 + var_568_10 then
				arg_565_1.typewritter.percent = (arg_565_1.time_ - var_568_0) / var_568_10

				arg_565_1.typewritter:SetDirty()
			end

			if arg_565_1.time_ >= var_568_0 + var_568_10 and arg_565_1.time_ < var_568_0 + var_568_10 + arg_568_0 then
				arg_565_1.typewritter.percent = 1

				arg_565_1.typewritter:SetDirty()
				arg_565_1:ShowNextGo(true)
			end
		end

		arg_565_1.nodeConfigList_ = {}

		arg_565_1:InitPlayNodeList()
	end,
	Play115311139 = function(arg_569_0, arg_569_1)
		arg_569_1.time_ = 0
		arg_569_1.frameCnt_ = 0
		arg_569_1.state_ = "playing"
		arg_569_1.curTalkId_ = 115311139
		arg_569_1.duration_ = 5

		SetActive(arg_569_1.tipsGo_, false)

		function arg_569_1.onSingleLineFinish_()
			arg_569_1.onSingleLineUpdate_ = nil
			arg_569_1.onSingleLineFinish_ = nil
			arg_569_1.state_ = "waiting"
		end

		function arg_569_1.playNext_(arg_571_0)
			if arg_571_0 == 1 then
				arg_569_0:Play115311140(arg_569_1)
			end
		end

		function arg_569_1.onSingleLineUpdate_(arg_572_0)
			local var_572_0 = arg_569_1.actors_["10030"]
			local var_572_1 = 0

			if var_572_1 < arg_569_1.time_ and arg_569_1.time_ <= var_572_1 + arg_572_0 then
				local var_572_2 = var_572_0:GetComponentInChildren(typeof(CanvasGroup))

				if var_572_2 then
					arg_569_1.var_.alphaOldValue10030 = var_572_2.alpha
					arg_569_1.var_.characterEffect10030 = var_572_2
				end

				arg_569_1.var_.alphaOldValue10030 = 1
			end

			local var_572_3 = 0.5

			if var_572_1 <= arg_569_1.time_ and arg_569_1.time_ < var_572_1 + var_572_3 then
				local var_572_4 = (arg_569_1.time_ - var_572_1) / var_572_3
				local var_572_5 = Mathf.Lerp(arg_569_1.var_.alphaOldValue10030, 0, var_572_4)

				if arg_569_1.var_.characterEffect10030 then
					arg_569_1.var_.characterEffect10030.alpha = var_572_5
				end
			end

			if arg_569_1.time_ >= var_572_1 + var_572_3 and arg_569_1.time_ < var_572_1 + var_572_3 + arg_572_0 and arg_569_1.var_.characterEffect10030 then
				arg_569_1.var_.characterEffect10030.alpha = 0
			end

			local var_572_6 = 0
			local var_572_7 = 1.45

			if var_572_6 < arg_569_1.time_ and arg_569_1.time_ <= var_572_6 + arg_572_0 then
				arg_569_1.talkMaxDuration = 0
				arg_569_1.dialogCg_.alpha = 1

				arg_569_1.dialog_:SetActive(true)
				SetActive(arg_569_1.leftNameGo_, false)

				arg_569_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_569_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_569_1:RecordName(arg_569_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_569_1.iconTrs_.gameObject, false)
				arg_569_1.callingController_:SetSelectedState("normal")

				local var_572_8 = arg_569_1:GetWordFromCfg(115311139)
				local var_572_9 = arg_569_1:FormatText(var_572_8.content)

				arg_569_1.text_.text = var_572_9

				LuaForUtil.ClearLinePrefixSymbol(arg_569_1.text_)

				local var_572_10 = 58
				local var_572_11 = utf8.len(var_572_9)
				local var_572_12 = var_572_10 <= 0 and var_572_7 or var_572_7 * (var_572_11 / var_572_10)

				if var_572_12 > 0 and var_572_7 < var_572_12 then
					arg_569_1.talkMaxDuration = var_572_12

					if var_572_12 + var_572_6 > arg_569_1.duration_ then
						arg_569_1.duration_ = var_572_12 + var_572_6
					end
				end

				arg_569_1.text_.text = var_572_9
				arg_569_1.typewritter.percent = 0

				arg_569_1.typewritter:SetDirty()
				arg_569_1:ShowNextGo(false)
				arg_569_1:RecordContent(arg_569_1.text_.text)
			end

			local var_572_13 = math.max(var_572_7, arg_569_1.talkMaxDuration)

			if var_572_6 <= arg_569_1.time_ and arg_569_1.time_ < var_572_6 + var_572_13 then
				arg_569_1.typewritter.percent = (arg_569_1.time_ - var_572_6) / var_572_13

				arg_569_1.typewritter:SetDirty()
			end

			if arg_569_1.time_ >= var_572_6 + var_572_13 and arg_569_1.time_ < var_572_6 + var_572_13 + arg_572_0 then
				arg_569_1.typewritter.percent = 1

				arg_569_1.typewritter:SetDirty()
				arg_569_1:ShowNextGo(true)
			end
		end

		arg_569_1.nodeConfigList_ = {}

		arg_569_1:InitPlayNodeList()
	end,
	Play115311140 = function(arg_573_0, arg_573_1)
		arg_573_1.time_ = 0
		arg_573_1.frameCnt_ = 0
		arg_573_1.state_ = "playing"
		arg_573_1.curTalkId_ = 115311140
		arg_573_1.duration_ = 5

		SetActive(arg_573_1.tipsGo_, false)

		function arg_573_1.onSingleLineFinish_()
			arg_573_1.onSingleLineUpdate_ = nil
			arg_573_1.onSingleLineFinish_ = nil
			arg_573_1.state_ = "waiting"
		end

		function arg_573_1.playNext_(arg_575_0)
			if arg_575_0 == 1 then
				arg_573_0:Play115311141(arg_573_1)
			end
		end

		function arg_573_1.onSingleLineUpdate_(arg_576_0)
			local var_576_0 = 0
			local var_576_1 = 0.3

			if var_576_0 < arg_573_1.time_ and arg_573_1.time_ <= var_576_0 + arg_576_0 then
				arg_573_1.talkMaxDuration = 0
				arg_573_1.dialogCg_.alpha = 1

				arg_573_1.dialog_:SetActive(true)
				SetActive(arg_573_1.leftNameGo_, false)

				arg_573_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_573_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_573_1:RecordName(arg_573_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_573_1.iconTrs_.gameObject, false)
				arg_573_1.callingController_:SetSelectedState("normal")

				local var_576_2 = arg_573_1:GetWordFromCfg(115311140)
				local var_576_3 = arg_573_1:FormatText(var_576_2.content)

				arg_573_1.text_.text = var_576_3

				LuaForUtil.ClearLinePrefixSymbol(arg_573_1.text_)

				local var_576_4 = 12
				local var_576_5 = utf8.len(var_576_3)
				local var_576_6 = var_576_4 <= 0 and var_576_1 or var_576_1 * (var_576_5 / var_576_4)

				if var_576_6 > 0 and var_576_1 < var_576_6 then
					arg_573_1.talkMaxDuration = var_576_6

					if var_576_6 + var_576_0 > arg_573_1.duration_ then
						arg_573_1.duration_ = var_576_6 + var_576_0
					end
				end

				arg_573_1.text_.text = var_576_3
				arg_573_1.typewritter.percent = 0

				arg_573_1.typewritter:SetDirty()
				arg_573_1:ShowNextGo(false)
				arg_573_1:RecordContent(arg_573_1.text_.text)
			end

			local var_576_7 = math.max(var_576_1, arg_573_1.talkMaxDuration)

			if var_576_0 <= arg_573_1.time_ and arg_573_1.time_ < var_576_0 + var_576_7 then
				arg_573_1.typewritter.percent = (arg_573_1.time_ - var_576_0) / var_576_7

				arg_573_1.typewritter:SetDirty()
			end

			if arg_573_1.time_ >= var_576_0 + var_576_7 and arg_573_1.time_ < var_576_0 + var_576_7 + arg_576_0 then
				arg_573_1.typewritter.percent = 1

				arg_573_1.typewritter:SetDirty()
				arg_573_1:ShowNextGo(true)
			end
		end

		arg_573_1.nodeConfigList_ = {}

		arg_573_1:InitPlayNodeList()
	end,
	Play115311141 = function(arg_577_0, arg_577_1)
		arg_577_1.time_ = 0
		arg_577_1.frameCnt_ = 0
		arg_577_1.state_ = "playing"
		arg_577_1.curTalkId_ = 115311141
		arg_577_1.duration_ = 5.83

		local var_577_0 = {
			ja = 5.833,
			ko = 5.3,
			zh = 5.666,
			en = 5.233
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
				arg_577_0:Play115311142(arg_577_1)
			end
		end

		function arg_577_1.onSingleLineUpdate_(arg_580_0)
			local var_580_0 = manager.ui.mainCamera.transform
			local var_580_1 = 0

			if var_580_1 < arg_577_1.time_ and arg_577_1.time_ <= var_580_1 + arg_580_0 then
				arg_577_1.var_.shakeOldPos = var_580_0.localPosition
			end

			local var_580_2 = 0.6

			if var_580_1 <= arg_577_1.time_ and arg_577_1.time_ < var_580_1 + var_580_2 then
				local var_580_3 = (arg_577_1.time_ - var_580_1) / 0.066
				local var_580_4, var_580_5 = math.modf(var_580_3)

				var_580_0.localPosition = Vector3.New(var_580_5 * 0.13, var_580_5 * 0.13, var_580_5 * 0.13) + arg_577_1.var_.shakeOldPos
			end

			if arg_577_1.time_ >= var_580_1 + var_580_2 and arg_577_1.time_ < var_580_1 + var_580_2 + arg_580_0 then
				var_580_0.localPosition = arg_577_1.var_.shakeOldPos
			end

			local var_580_6 = arg_577_1.actors_["10030"]
			local var_580_7 = 0.8

			if var_580_7 < arg_577_1.time_ and arg_577_1.time_ <= var_580_7 + arg_580_0 then
				local var_580_8 = var_580_6:GetComponentInChildren(typeof(CanvasGroup))

				if var_580_8 then
					arg_577_1.var_.alphaOldValue10030 = var_580_8.alpha
					arg_577_1.var_.characterEffect10030 = var_580_8
				end

				arg_577_1.var_.alphaOldValue10030 = 0
			end

			local var_580_9 = 0.5

			if var_580_7 <= arg_577_1.time_ and arg_577_1.time_ < var_580_7 + var_580_9 then
				local var_580_10 = (arg_577_1.time_ - var_580_7) / var_580_9
				local var_580_11 = Mathf.Lerp(arg_577_1.var_.alphaOldValue10030, 1, var_580_10)

				if arg_577_1.var_.characterEffect10030 then
					arg_577_1.var_.characterEffect10030.alpha = var_580_11
				end
			end

			if arg_577_1.time_ >= var_580_7 + var_580_9 and arg_577_1.time_ < var_580_7 + var_580_9 + arg_580_0 and arg_577_1.var_.characterEffect10030 then
				arg_577_1.var_.characterEffect10030.alpha = 1
			end

			local var_580_12 = arg_577_1.actors_["10030"]
			local var_580_13 = 0.8

			if var_580_13 < arg_577_1.time_ and arg_577_1.time_ <= var_580_13 + arg_580_0 and not isNil(var_580_12) and arg_577_1.var_.actorSpriteComps10030 == nil then
				arg_577_1.var_.actorSpriteComps10030 = var_580_12:GetComponentsInChildren(typeof(Image), true)
			end

			local var_580_14 = 0.2

			if var_580_13 <= arg_577_1.time_ and arg_577_1.time_ < var_580_13 + var_580_14 and not isNil(var_580_12) then
				local var_580_15 = (arg_577_1.time_ - var_580_13) / var_580_14

				if arg_577_1.var_.actorSpriteComps10030 then
					for iter_580_0, iter_580_1 in pairs(arg_577_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_580_1 then
							if arg_577_1.isInRecall_ then
								local var_580_16 = Mathf.Lerp(iter_580_1.color.r, arg_577_1.hightColor1.r, var_580_15)
								local var_580_17 = Mathf.Lerp(iter_580_1.color.g, arg_577_1.hightColor1.g, var_580_15)
								local var_580_18 = Mathf.Lerp(iter_580_1.color.b, arg_577_1.hightColor1.b, var_580_15)

								iter_580_1.color = Color.New(var_580_16, var_580_17, var_580_18)
							else
								local var_580_19 = Mathf.Lerp(iter_580_1.color.r, 1, var_580_15)

								iter_580_1.color = Color.New(var_580_19, var_580_19, var_580_19)
							end
						end
					end
				end
			end

			if arg_577_1.time_ >= var_580_13 + var_580_14 and arg_577_1.time_ < var_580_13 + var_580_14 + arg_580_0 and not isNil(var_580_12) and arg_577_1.var_.actorSpriteComps10030 then
				for iter_580_2, iter_580_3 in pairs(arg_577_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_580_3 then
						if arg_577_1.isInRecall_ then
							iter_580_3.color = arg_577_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_580_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_577_1.var_.actorSpriteComps10030 = nil
			end

			local var_580_20 = arg_577_1.actors_["10030"].transform
			local var_580_21 = 0.8

			if var_580_21 < arg_577_1.time_ and arg_577_1.time_ <= var_580_21 + arg_580_0 then
				arg_577_1.var_.moveOldPos10030 = var_580_20.localPosition
				var_580_20.localScale = Vector3.New(1, 1, 1)

				arg_577_1:CheckSpriteTmpPos("10030", 3)

				local var_580_22 = var_580_20.childCount

				for iter_580_4 = 0, var_580_22 - 1 do
					local var_580_23 = var_580_20:GetChild(iter_580_4)

					if var_580_23.name == "split_1" or not string.find(var_580_23.name, "split") then
						var_580_23.gameObject:SetActive(true)
					else
						var_580_23.gameObject:SetActive(false)
					end
				end
			end

			local var_580_24 = 0.001

			if var_580_21 <= arg_577_1.time_ and arg_577_1.time_ < var_580_21 + var_580_24 then
				local var_580_25 = (arg_577_1.time_ - var_580_21) / var_580_24
				local var_580_26 = Vector3.New(0, -390, 150)

				var_580_20.localPosition = Vector3.Lerp(arg_577_1.var_.moveOldPos10030, var_580_26, var_580_25)
			end

			if arg_577_1.time_ >= var_580_21 + var_580_24 and arg_577_1.time_ < var_580_21 + var_580_24 + arg_580_0 then
				var_580_20.localPosition = Vector3.New(0, -390, 150)
			end

			local var_580_27 = 0

			if var_580_27 < arg_577_1.time_ and arg_577_1.time_ <= var_580_27 + arg_580_0 then
				arg_577_1.allBtn_.enabled = false
			end

			local var_580_28 = 0.8

			if arg_577_1.time_ >= var_580_27 + var_580_28 and arg_577_1.time_ < var_580_27 + var_580_28 + arg_580_0 then
				arg_577_1.allBtn_.enabled = true
			end

			if arg_577_1.frameCnt_ <= 1 then
				arg_577_1.dialog_:SetActive(false)
			end

			local var_580_29 = 0.8
			local var_580_30 = 0.325

			if var_580_29 < arg_577_1.time_ and arg_577_1.time_ <= var_580_29 + arg_580_0 then
				arg_577_1.talkMaxDuration = 0

				arg_577_1.dialog_:SetActive(true)

				arg_577_1.dialogCg_.alpha = 0

				local var_580_31 = LeanTween.value(arg_577_1.dialog_, 0, 1, 0.3)

				var_580_31:setOnUpdate(LuaHelper.FloatAction(function(arg_581_0)
					arg_577_1.dialogCg_.alpha = arg_581_0
				end))
				var_580_31:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_577_1.dialog_)
					var_580_31:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_577_1.duration_ = arg_577_1.duration_ + 0.3

				SetActive(arg_577_1.leftNameGo_, true)

				local var_580_32 = arg_577_1:FormatText(StoryNameCfg[309].name)

				arg_577_1.leftNameTxt_.text = var_580_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_577_1.leftNameTxt_.transform)

				arg_577_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_577_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_577_1:RecordName(arg_577_1.leftNameTxt_.text)
				SetActive(arg_577_1.iconTrs_.gameObject, false)
				arg_577_1.callingController_:SetSelectedState("normal")

				local var_580_33 = arg_577_1:GetWordFromCfg(115311141)
				local var_580_34 = arg_577_1:FormatText(var_580_33.content)

				arg_577_1.text_.text = var_580_34

				LuaForUtil.ClearLinePrefixSymbol(arg_577_1.text_)

				local var_580_35 = 13
				local var_580_36 = utf8.len(var_580_34)
				local var_580_37 = var_580_35 <= 0 and var_580_30 or var_580_30 * (var_580_36 / var_580_35)

				if var_580_37 > 0 and var_580_30 < var_580_37 then
					arg_577_1.talkMaxDuration = var_580_37
					var_580_29 = var_580_29 + 0.3

					if var_580_37 + var_580_29 > arg_577_1.duration_ then
						arg_577_1.duration_ = var_580_37 + var_580_29
					end
				end

				arg_577_1.text_.text = var_580_34
				arg_577_1.typewritter.percent = 0

				arg_577_1.typewritter:SetDirty()
				arg_577_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311141", "story_v_out_115311.awb") ~= 0 then
					local var_580_38 = manager.audio:GetVoiceLength("story_v_out_115311", "115311141", "story_v_out_115311.awb") / 1000

					if var_580_38 + var_580_29 > arg_577_1.duration_ then
						arg_577_1.duration_ = var_580_38 + var_580_29
					end

					if var_580_33.prefab_name ~= "" and arg_577_1.actors_[var_580_33.prefab_name] ~= nil then
						local var_580_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_577_1.actors_[var_580_33.prefab_name].transform, "story_v_out_115311", "115311141", "story_v_out_115311.awb")

						arg_577_1:RecordAudio("115311141", var_580_39)
						arg_577_1:RecordAudio("115311141", var_580_39)
					else
						arg_577_1:AudioAction("play", "voice", "story_v_out_115311", "115311141", "story_v_out_115311.awb")
					end

					arg_577_1:RecordHistoryTalkVoice("story_v_out_115311", "115311141", "story_v_out_115311.awb")
				end

				arg_577_1:RecordContent(arg_577_1.text_.text)
			end

			local var_580_40 = var_580_29 + 0.3
			local var_580_41 = math.max(var_580_30, arg_577_1.talkMaxDuration)

			if var_580_40 <= arg_577_1.time_ and arg_577_1.time_ < var_580_40 + var_580_41 then
				arg_577_1.typewritter.percent = (arg_577_1.time_ - var_580_40) / var_580_41

				arg_577_1.typewritter:SetDirty()
			end

			if arg_577_1.time_ >= var_580_40 + var_580_41 and arg_577_1.time_ < var_580_40 + var_580_41 + arg_580_0 then
				arg_577_1.typewritter.percent = 1

				arg_577_1.typewritter:SetDirty()
				arg_577_1:ShowNextGo(true)
			end
		end

		arg_577_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10030",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_577_1:InitPlayNodeList()
	end,
	Play115311142 = function(arg_583_0, arg_583_1)
		arg_583_1.time_ = 0
		arg_583_1.frameCnt_ = 0
		arg_583_1.state_ = "playing"
		arg_583_1.curTalkId_ = 115311142
		arg_583_1.duration_ = 5

		SetActive(arg_583_1.tipsGo_, false)

		function arg_583_1.onSingleLineFinish_()
			arg_583_1.onSingleLineUpdate_ = nil
			arg_583_1.onSingleLineFinish_ = nil
			arg_583_1.state_ = "waiting"
		end

		function arg_583_1.playNext_(arg_585_0)
			if arg_585_0 == 1 then
				arg_583_0:Play115311143(arg_583_1)
			end
		end

		function arg_583_1.onSingleLineUpdate_(arg_586_0)
			local var_586_0 = arg_583_1.actors_["10030"]
			local var_586_1 = 0

			if var_586_1 < arg_583_1.time_ and arg_583_1.time_ <= var_586_1 + arg_586_0 then
				local var_586_2 = var_586_0:GetComponentInChildren(typeof(CanvasGroup))

				if var_586_2 then
					arg_583_1.var_.alphaOldValue10030 = var_586_2.alpha
					arg_583_1.var_.characterEffect10030 = var_586_2
				end

				arg_583_1.var_.alphaOldValue10030 = 1
			end

			local var_586_3 = 0.5

			if var_586_1 <= arg_583_1.time_ and arg_583_1.time_ < var_586_1 + var_586_3 then
				local var_586_4 = (arg_583_1.time_ - var_586_1) / var_586_3
				local var_586_5 = Mathf.Lerp(arg_583_1.var_.alphaOldValue10030, 0, var_586_4)

				if arg_583_1.var_.characterEffect10030 then
					arg_583_1.var_.characterEffect10030.alpha = var_586_5
				end
			end

			if arg_583_1.time_ >= var_586_1 + var_586_3 and arg_583_1.time_ < var_586_1 + var_586_3 + arg_586_0 and arg_583_1.var_.characterEffect10030 then
				arg_583_1.var_.characterEffect10030.alpha = 0
			end

			local var_586_6 = 0
			local var_586_7 = 1.025

			if var_586_6 < arg_583_1.time_ and arg_583_1.time_ <= var_586_6 + arg_586_0 then
				arg_583_1.talkMaxDuration = 0
				arg_583_1.dialogCg_.alpha = 1

				arg_583_1.dialog_:SetActive(true)
				SetActive(arg_583_1.leftNameGo_, false)

				arg_583_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_583_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_583_1:RecordName(arg_583_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_583_1.iconTrs_.gameObject, false)
				arg_583_1.callingController_:SetSelectedState("normal")

				local var_586_8 = arg_583_1:GetWordFromCfg(115311142)
				local var_586_9 = arg_583_1:FormatText(var_586_8.content)

				arg_583_1.text_.text = var_586_9

				LuaForUtil.ClearLinePrefixSymbol(arg_583_1.text_)

				local var_586_10 = 41
				local var_586_11 = utf8.len(var_586_9)
				local var_586_12 = var_586_10 <= 0 and var_586_7 or var_586_7 * (var_586_11 / var_586_10)

				if var_586_12 > 0 and var_586_7 < var_586_12 then
					arg_583_1.talkMaxDuration = var_586_12

					if var_586_12 + var_586_6 > arg_583_1.duration_ then
						arg_583_1.duration_ = var_586_12 + var_586_6
					end
				end

				arg_583_1.text_.text = var_586_9
				arg_583_1.typewritter.percent = 0

				arg_583_1.typewritter:SetDirty()
				arg_583_1:ShowNextGo(false)
				arg_583_1:RecordContent(arg_583_1.text_.text)
			end

			local var_586_13 = math.max(var_586_7, arg_583_1.talkMaxDuration)

			if var_586_6 <= arg_583_1.time_ and arg_583_1.time_ < var_586_6 + var_586_13 then
				arg_583_1.typewritter.percent = (arg_583_1.time_ - var_586_6) / var_586_13

				arg_583_1.typewritter:SetDirty()
			end

			if arg_583_1.time_ >= var_586_6 + var_586_13 and arg_583_1.time_ < var_586_6 + var_586_13 + arg_586_0 then
				arg_583_1.typewritter.percent = 1

				arg_583_1.typewritter:SetDirty()
				arg_583_1:ShowNextGo(true)
			end
		end

		arg_583_1.nodeConfigList_ = {}

		arg_583_1:InitPlayNodeList()
	end,
	Play115311143 = function(arg_587_0, arg_587_1)
		arg_587_1.time_ = 0
		arg_587_1.frameCnt_ = 0
		arg_587_1.state_ = "playing"
		arg_587_1.curTalkId_ = 115311143
		arg_587_1.duration_ = 4.33

		local var_587_0 = {
			ja = 4.333,
			ko = 3.1,
			zh = 2.633,
			en = 3.066
		}
		local var_587_1 = manager.audio:GetLocalizationFlag()

		if var_587_0[var_587_1] ~= nil then
			arg_587_1.duration_ = var_587_0[var_587_1]
		end

		SetActive(arg_587_1.tipsGo_, false)

		function arg_587_1.onSingleLineFinish_()
			arg_587_1.onSingleLineUpdate_ = nil
			arg_587_1.onSingleLineFinish_ = nil
			arg_587_1.state_ = "waiting"
		end

		function arg_587_1.playNext_(arg_589_0)
			if arg_589_0 == 1 then
				arg_587_0:Play115311144(arg_587_1)
			end
		end

		function arg_587_1.onSingleLineUpdate_(arg_590_0)
			local var_590_0 = "1041_1"

			if arg_587_1.actors_[var_590_0] == nil then
				local var_590_1 = Object.Instantiate(arg_587_1.imageGo_, arg_587_1.canvasGo_.transform)

				var_590_1.transform:SetSiblingIndex(1)

				var_590_1.name = var_590_0

				local var_590_2 = var_590_1:GetComponent(typeof(Image))

				var_590_2.sprite = getSpriteWithoutAtlas("TextureConfig/Character/Portrait/" .. "1041_1")

				var_590_2:SetNativeSize()

				var_590_1.transform.localPosition = Vector3.New(0, 100000, 0)
				arg_587_1.actors_[var_590_0] = var_590_1
			end

			local var_590_3 = arg_587_1.actors_["1041_1"]
			local var_590_4 = 0

			if var_590_4 < arg_587_1.time_ and arg_587_1.time_ <= var_590_4 + arg_590_0 then
				local var_590_5 = var_590_3:GetComponent("Image")

				if var_590_5 then
					arg_587_1.var_.alphaMatValue1041_1 = var_590_5
					arg_587_1.var_.alphaOldValue1041_1 = var_590_5.color.a
				end

				arg_587_1.var_.alphaOldValue1041_1 = 0
			end

			local var_590_6 = 0.5

			if var_590_4 <= arg_587_1.time_ and arg_587_1.time_ < var_590_4 + var_590_6 then
				local var_590_7 = (arg_587_1.time_ - var_590_4) / var_590_6
				local var_590_8 = Mathf.Lerp(arg_587_1.var_.alphaOldValue1041_1, 1, var_590_7)

				if arg_587_1.var_.alphaMatValue1041_1 then
					local var_590_9 = arg_587_1.var_.alphaMatValue1041_1.color

					var_590_9.a = var_590_8
					arg_587_1.var_.alphaMatValue1041_1.color = var_590_9
				end
			end

			if arg_587_1.time_ >= var_590_4 + var_590_6 and arg_587_1.time_ < var_590_4 + var_590_6 + arg_590_0 and arg_587_1.var_.alphaMatValue1041_1 then
				local var_590_10 = arg_587_1.var_.alphaMatValue1041_1
				local var_590_11 = var_590_10.color

				var_590_11.a = 1
				var_590_10.color = var_590_11
			end

			local var_590_12 = arg_587_1.actors_["1041_1"]
			local var_590_13 = 0

			if var_590_13 < arg_587_1.time_ and arg_587_1.time_ <= var_590_13 + arg_590_0 and not isNil(var_590_12) then
				local var_590_14 = var_590_12:GetComponent("Image")

				if var_590_14 then
					arg_587_1.var_.highlightMatValue1041_1 = var_590_14
				end
			end

			local var_590_15 = 0.2

			if var_590_13 <= arg_587_1.time_ and arg_587_1.time_ < var_590_13 + var_590_15 and not isNil(var_590_12) then
				local var_590_16 = (arg_587_1.time_ - var_590_13) / var_590_15

				if arg_587_1.var_.highlightMatValue1041_1 then
					local var_590_17 = Mathf.Lerp(0.5, 1, var_590_16)
					local var_590_18 = arg_587_1.var_.highlightMatValue1041_1
					local var_590_19 = var_590_18.color

					var_590_19.r = var_590_17
					var_590_19.g = var_590_17
					var_590_19.b = var_590_17
					var_590_18.color = var_590_19
				end
			end

			if arg_587_1.time_ >= var_590_13 + var_590_15 and arg_587_1.time_ < var_590_13 + var_590_15 + arg_590_0 and not isNil(var_590_12) and arg_587_1.var_.highlightMatValue1041_1 then
				local var_590_20 = 1

				var_590_12.transform:SetSiblingIndex(1)

				local var_590_21 = arg_587_1.var_.highlightMatValue1041_1
				local var_590_22 = var_590_21.color

				var_590_22.r = var_590_20
				var_590_22.g = var_590_20
				var_590_22.b = var_590_20
				var_590_21.color = var_590_22
			end

			local var_590_23 = arg_587_1.actors_["1041_1"].transform
			local var_590_24 = 0

			if var_590_24 < arg_587_1.time_ and arg_587_1.time_ <= var_590_24 + arg_590_0 then
				arg_587_1.var_.moveOldPos1041_1 = var_590_23.localPosition
				var_590_23.localScale = Vector3.New(1, 1, 1)

				arg_587_1:CheckSpriteTmpPos("1041_1", 4)
			end

			local var_590_25 = 0.001

			if var_590_24 <= arg_587_1.time_ and arg_587_1.time_ < var_590_24 + var_590_25 then
				local var_590_26 = (arg_587_1.time_ - var_590_24) / var_590_25
				local var_590_27 = Vector3.New(440, -310, -370)

				var_590_23.localPosition = Vector3.Lerp(arg_587_1.var_.moveOldPos1041_1, var_590_27, var_590_26)
			end

			if arg_587_1.time_ >= var_590_24 + var_590_25 and arg_587_1.time_ < var_590_24 + var_590_25 + arg_590_0 then
				var_590_23.localPosition = Vector3.New(440, -310, -370)
			end

			local var_590_28 = 0
			local var_590_29 = 0.3

			if var_590_28 < arg_587_1.time_ and arg_587_1.time_ <= var_590_28 + arg_590_0 then
				arg_587_1.talkMaxDuration = 0
				arg_587_1.dialogCg_.alpha = 1

				arg_587_1.dialog_:SetActive(true)
				SetActive(arg_587_1.leftNameGo_, true)

				local var_590_30 = arg_587_1:FormatText(StoryNameCfg[208].name)

				arg_587_1.leftNameTxt_.text = var_590_30

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_587_1.leftNameTxt_.transform)

				arg_587_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_587_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_587_1:RecordName(arg_587_1.leftNameTxt_.text)
				SetActive(arg_587_1.iconTrs_.gameObject, false)
				arg_587_1.callingController_:SetSelectedState("normal")

				local var_590_31 = arg_587_1:GetWordFromCfg(115311143)
				local var_590_32 = arg_587_1:FormatText(var_590_31.content)

				arg_587_1.text_.text = var_590_32

				LuaForUtil.ClearLinePrefixSymbol(arg_587_1.text_)

				local var_590_33 = 12
				local var_590_34 = utf8.len(var_590_32)
				local var_590_35 = var_590_33 <= 0 and var_590_29 or var_590_29 * (var_590_34 / var_590_33)

				if var_590_35 > 0 and var_590_29 < var_590_35 then
					arg_587_1.talkMaxDuration = var_590_35

					if var_590_35 + var_590_28 > arg_587_1.duration_ then
						arg_587_1.duration_ = var_590_35 + var_590_28
					end
				end

				arg_587_1.text_.text = var_590_32
				arg_587_1.typewritter.percent = 0

				arg_587_1.typewritter:SetDirty()
				arg_587_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311143", "story_v_out_115311.awb") ~= 0 then
					local var_590_36 = manager.audio:GetVoiceLength("story_v_out_115311", "115311143", "story_v_out_115311.awb") / 1000

					if var_590_36 + var_590_28 > arg_587_1.duration_ then
						arg_587_1.duration_ = var_590_36 + var_590_28
					end

					if var_590_31.prefab_name ~= "" and arg_587_1.actors_[var_590_31.prefab_name] ~= nil then
						local var_590_37 = LuaForUtil.PlayVoiceWithCriLipsync(arg_587_1.actors_[var_590_31.prefab_name].transform, "story_v_out_115311", "115311143", "story_v_out_115311.awb")

						arg_587_1:RecordAudio("115311143", var_590_37)
						arg_587_1:RecordAudio("115311143", var_590_37)
					else
						arg_587_1:AudioAction("play", "voice", "story_v_out_115311", "115311143", "story_v_out_115311.awb")
					end

					arg_587_1:RecordHistoryTalkVoice("story_v_out_115311", "115311143", "story_v_out_115311.awb")
				end

				arg_587_1:RecordContent(arg_587_1.text_.text)
			end

			local var_590_38 = math.max(var_590_29, arg_587_1.talkMaxDuration)

			if var_590_28 <= arg_587_1.time_ and arg_587_1.time_ < var_590_28 + var_590_38 then
				arg_587_1.typewritter.percent = (arg_587_1.time_ - var_590_28) / var_590_38

				arg_587_1.typewritter:SetDirty()
			end

			if arg_587_1.time_ >= var_590_28 + var_590_38 and arg_587_1.time_ < var_590_28 + var_590_38 + arg_590_0 then
				arg_587_1.typewritter.percent = 1

				arg_587_1.typewritter:SetDirty()
				arg_587_1:ShowNextGo(true)
			end
		end

		arg_587_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041_1",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Sprite
			}
		}

		arg_587_1:InitPlayNodeList()
	end,
	Play115311144 = function(arg_591_0, arg_591_1)
		arg_591_1.time_ = 0
		arg_591_1.frameCnt_ = 0
		arg_591_1.state_ = "playing"
		arg_591_1.curTalkId_ = 115311144
		arg_591_1.duration_ = 13.97

		local var_591_0 = {
			ja = 13.966,
			ko = 7.733,
			zh = 7.333,
			en = 7.1
		}
		local var_591_1 = manager.audio:GetLocalizationFlag()

		if var_591_0[var_591_1] ~= nil then
			arg_591_1.duration_ = var_591_0[var_591_1]
		end

		SetActive(arg_591_1.tipsGo_, false)

		function arg_591_1.onSingleLineFinish_()
			arg_591_1.onSingleLineUpdate_ = nil
			arg_591_1.onSingleLineFinish_ = nil
			arg_591_1.state_ = "waiting"
		end

		function arg_591_1.playNext_(arg_593_0)
			if arg_593_0 == 1 then
				arg_591_0:Play115311145(arg_591_1)
			end
		end

		function arg_591_1.onSingleLineUpdate_(arg_594_0)
			local var_594_0 = arg_591_1.actors_["10030"]
			local var_594_1 = 0

			if var_594_1 < arg_591_1.time_ and arg_591_1.time_ <= var_594_1 + arg_594_0 then
				local var_594_2 = var_594_0:GetComponentInChildren(typeof(CanvasGroup))

				if var_594_2 then
					arg_591_1.var_.alphaOldValue10030 = var_594_2.alpha
					arg_591_1.var_.characterEffect10030 = var_594_2
				end

				arg_591_1.var_.alphaOldValue10030 = 0
			end

			local var_594_3 = 0.5

			if var_594_1 <= arg_591_1.time_ and arg_591_1.time_ < var_594_1 + var_594_3 then
				local var_594_4 = (arg_591_1.time_ - var_594_1) / var_594_3
				local var_594_5 = Mathf.Lerp(arg_591_1.var_.alphaOldValue10030, 1, var_594_4)

				if arg_591_1.var_.characterEffect10030 then
					arg_591_1.var_.characterEffect10030.alpha = var_594_5
				end
			end

			if arg_591_1.time_ >= var_594_1 + var_594_3 and arg_591_1.time_ < var_594_1 + var_594_3 + arg_594_0 and arg_591_1.var_.characterEffect10030 then
				arg_591_1.var_.characterEffect10030.alpha = 1
			end

			local var_594_6 = arg_591_1.actors_["10030"]
			local var_594_7 = 0

			if var_594_7 < arg_591_1.time_ and arg_591_1.time_ <= var_594_7 + arg_594_0 and not isNil(var_594_6) and arg_591_1.var_.actorSpriteComps10030 == nil then
				arg_591_1.var_.actorSpriteComps10030 = var_594_6:GetComponentsInChildren(typeof(Image), true)
			end

			local var_594_8 = 0.2

			if var_594_7 <= arg_591_1.time_ and arg_591_1.time_ < var_594_7 + var_594_8 and not isNil(var_594_6) then
				local var_594_9 = (arg_591_1.time_ - var_594_7) / var_594_8

				if arg_591_1.var_.actorSpriteComps10030 then
					for iter_594_0, iter_594_1 in pairs(arg_591_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_594_1 then
							if arg_591_1.isInRecall_ then
								local var_594_10 = Mathf.Lerp(iter_594_1.color.r, arg_591_1.hightColor1.r, var_594_9)
								local var_594_11 = Mathf.Lerp(iter_594_1.color.g, arg_591_1.hightColor1.g, var_594_9)
								local var_594_12 = Mathf.Lerp(iter_594_1.color.b, arg_591_1.hightColor1.b, var_594_9)

								iter_594_1.color = Color.New(var_594_10, var_594_11, var_594_12)
							else
								local var_594_13 = Mathf.Lerp(iter_594_1.color.r, 1, var_594_9)

								iter_594_1.color = Color.New(var_594_13, var_594_13, var_594_13)
							end
						end
					end
				end
			end

			if arg_591_1.time_ >= var_594_7 + var_594_8 and arg_591_1.time_ < var_594_7 + var_594_8 + arg_594_0 and not isNil(var_594_6) and arg_591_1.var_.actorSpriteComps10030 then
				for iter_594_2, iter_594_3 in pairs(arg_591_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_594_3 then
						if arg_591_1.isInRecall_ then
							iter_594_3.color = arg_591_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_594_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_591_1.var_.actorSpriteComps10030 = nil
			end

			local var_594_14 = arg_591_1.actors_["10030"].transform
			local var_594_15 = 0

			if var_594_15 < arg_591_1.time_ and arg_591_1.time_ <= var_594_15 + arg_594_0 then
				arg_591_1.var_.moveOldPos10030 = var_594_14.localPosition
				var_594_14.localScale = Vector3.New(1, 1, 1)

				arg_591_1:CheckSpriteTmpPos("10030", 2)

				local var_594_16 = var_594_14.childCount

				for iter_594_4 = 0, var_594_16 - 1 do
					local var_594_17 = var_594_14:GetChild(iter_594_4)

					if var_594_17.name == "split_2" or not string.find(var_594_17.name, "split") then
						var_594_17.gameObject:SetActive(true)
					else
						var_594_17.gameObject:SetActive(false)
					end
				end
			end

			local var_594_18 = 0.001

			if var_594_15 <= arg_591_1.time_ and arg_591_1.time_ < var_594_15 + var_594_18 then
				local var_594_19 = (arg_591_1.time_ - var_594_15) / var_594_18
				local var_594_20 = Vector3.New(-390, -390, 150)

				var_594_14.localPosition = Vector3.Lerp(arg_591_1.var_.moveOldPos10030, var_594_20, var_594_19)
			end

			if arg_591_1.time_ >= var_594_15 + var_594_18 and arg_591_1.time_ < var_594_15 + var_594_18 + arg_594_0 then
				var_594_14.localPosition = Vector3.New(-390, -390, 150)
			end

			local var_594_21 = arg_591_1.actors_["1041_1"]
			local var_594_22 = 0

			if var_594_22 < arg_591_1.time_ and arg_591_1.time_ <= var_594_22 + arg_594_0 and not isNil(var_594_21) then
				local var_594_23 = var_594_21:GetComponent("Image")

				if var_594_23 then
					arg_591_1.var_.highlightMatValue1041_1 = var_594_23
				end
			end

			local var_594_24 = 0.2

			if var_594_22 <= arg_591_1.time_ and arg_591_1.time_ < var_594_22 + var_594_24 and not isNil(var_594_21) then
				local var_594_25 = (arg_591_1.time_ - var_594_22) / var_594_24

				if arg_591_1.var_.highlightMatValue1041_1 then
					local var_594_26 = Mathf.Lerp(1, 0.5, var_594_25)
					local var_594_27 = arg_591_1.var_.highlightMatValue1041_1
					local var_594_28 = var_594_27.color

					var_594_28.r = var_594_26
					var_594_28.g = var_594_26
					var_594_28.b = var_594_26
					var_594_27.color = var_594_28
				end
			end

			if arg_591_1.time_ >= var_594_22 + var_594_24 and arg_591_1.time_ < var_594_22 + var_594_24 + arg_594_0 and not isNil(var_594_21) and arg_591_1.var_.highlightMatValue1041_1 then
				local var_594_29 = 0.5
				local var_594_30 = arg_591_1.var_.highlightMatValue1041_1
				local var_594_31 = var_594_30.color

				var_594_31.r = var_594_29
				var_594_31.g = var_594_29
				var_594_31.b = var_594_29
				var_594_30.color = var_594_31
			end

			local var_594_32 = 0
			local var_594_33 = 0.625

			if var_594_32 < arg_591_1.time_ and arg_591_1.time_ <= var_594_32 + arg_594_0 then
				arg_591_1.talkMaxDuration = 0
				arg_591_1.dialogCg_.alpha = 1

				arg_591_1.dialog_:SetActive(true)
				SetActive(arg_591_1.leftNameGo_, true)

				local var_594_34 = arg_591_1:FormatText(StoryNameCfg[309].name)

				arg_591_1.leftNameTxt_.text = var_594_34

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_591_1.leftNameTxt_.transform)

				arg_591_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_591_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_591_1:RecordName(arg_591_1.leftNameTxt_.text)
				SetActive(arg_591_1.iconTrs_.gameObject, false)
				arg_591_1.callingController_:SetSelectedState("normal")

				local var_594_35 = arg_591_1:GetWordFromCfg(115311144)
				local var_594_36 = arg_591_1:FormatText(var_594_35.content)

				arg_591_1.text_.text = var_594_36

				LuaForUtil.ClearLinePrefixSymbol(arg_591_1.text_)

				local var_594_37 = 25
				local var_594_38 = utf8.len(var_594_36)
				local var_594_39 = var_594_37 <= 0 and var_594_33 or var_594_33 * (var_594_38 / var_594_37)

				if var_594_39 > 0 and var_594_33 < var_594_39 then
					arg_591_1.talkMaxDuration = var_594_39

					if var_594_39 + var_594_32 > arg_591_1.duration_ then
						arg_591_1.duration_ = var_594_39 + var_594_32
					end
				end

				arg_591_1.text_.text = var_594_36
				arg_591_1.typewritter.percent = 0

				arg_591_1.typewritter:SetDirty()
				arg_591_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311144", "story_v_out_115311.awb") ~= 0 then
					local var_594_40 = manager.audio:GetVoiceLength("story_v_out_115311", "115311144", "story_v_out_115311.awb") / 1000

					if var_594_40 + var_594_32 > arg_591_1.duration_ then
						arg_591_1.duration_ = var_594_40 + var_594_32
					end

					if var_594_35.prefab_name ~= "" and arg_591_1.actors_[var_594_35.prefab_name] ~= nil then
						local var_594_41 = LuaForUtil.PlayVoiceWithCriLipsync(arg_591_1.actors_[var_594_35.prefab_name].transform, "story_v_out_115311", "115311144", "story_v_out_115311.awb")

						arg_591_1:RecordAudio("115311144", var_594_41)
						arg_591_1:RecordAudio("115311144", var_594_41)
					else
						arg_591_1:AudioAction("play", "voice", "story_v_out_115311", "115311144", "story_v_out_115311.awb")
					end

					arg_591_1:RecordHistoryTalkVoice("story_v_out_115311", "115311144", "story_v_out_115311.awb")
				end

				arg_591_1:RecordContent(arg_591_1.text_.text)
			end

			local var_594_42 = math.max(var_594_33, arg_591_1.talkMaxDuration)

			if var_594_32 <= arg_591_1.time_ and arg_591_1.time_ < var_594_32 + var_594_42 then
				arg_591_1.typewritter.percent = (arg_591_1.time_ - var_594_32) / var_594_42

				arg_591_1.typewritter:SetDirty()
			end

			if arg_591_1.time_ >= var_594_32 + var_594_42 and arg_591_1.time_ < var_594_32 + var_594_42 + arg_594_0 then
				arg_591_1.typewritter.percent = 1

				arg_591_1.typewritter:SetDirty()
				arg_591_1:ShowNextGo(true)
			end
		end

		arg_591_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10030",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_591_1:InitPlayNodeList()
	end,
	Play115311145 = function(arg_595_0, arg_595_1)
		arg_595_1.time_ = 0
		arg_595_1.frameCnt_ = 0
		arg_595_1.state_ = "playing"
		arg_595_1.curTalkId_ = 115311145
		arg_595_1.duration_ = 4.33

		local var_595_0 = {
			ja = 3.633,
			ko = 4.333,
			zh = 2.833,
			en = 3.266
		}
		local var_595_1 = manager.audio:GetLocalizationFlag()

		if var_595_0[var_595_1] ~= nil then
			arg_595_1.duration_ = var_595_0[var_595_1]
		end

		SetActive(arg_595_1.tipsGo_, false)

		function arg_595_1.onSingleLineFinish_()
			arg_595_1.onSingleLineUpdate_ = nil
			arg_595_1.onSingleLineFinish_ = nil
			arg_595_1.state_ = "waiting"
		end

		function arg_595_1.playNext_(arg_597_0)
			if arg_597_0 == 1 then
				arg_595_0:Play115311146(arg_595_1)
			end
		end

		function arg_595_1.onSingleLineUpdate_(arg_598_0)
			local var_598_0 = arg_595_1.actors_["10030"]
			local var_598_1 = 0

			if var_598_1 < arg_595_1.time_ and arg_595_1.time_ <= var_598_1 + arg_598_0 and not isNil(var_598_0) and arg_595_1.var_.actorSpriteComps10030 == nil then
				arg_595_1.var_.actorSpriteComps10030 = var_598_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_598_2 = 0.2

			if var_598_1 <= arg_595_1.time_ and arg_595_1.time_ < var_598_1 + var_598_2 and not isNil(var_598_0) then
				local var_598_3 = (arg_595_1.time_ - var_598_1) / var_598_2

				if arg_595_1.var_.actorSpriteComps10030 then
					for iter_598_0, iter_598_1 in pairs(arg_595_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_598_1 then
							if arg_595_1.isInRecall_ then
								local var_598_4 = Mathf.Lerp(iter_598_1.color.r, arg_595_1.hightColor2.r, var_598_3)
								local var_598_5 = Mathf.Lerp(iter_598_1.color.g, arg_595_1.hightColor2.g, var_598_3)
								local var_598_6 = Mathf.Lerp(iter_598_1.color.b, arg_595_1.hightColor2.b, var_598_3)

								iter_598_1.color = Color.New(var_598_4, var_598_5, var_598_6)
							else
								local var_598_7 = Mathf.Lerp(iter_598_1.color.r, 0.5, var_598_3)

								iter_598_1.color = Color.New(var_598_7, var_598_7, var_598_7)
							end
						end
					end
				end
			end

			if arg_595_1.time_ >= var_598_1 + var_598_2 and arg_595_1.time_ < var_598_1 + var_598_2 + arg_598_0 and not isNil(var_598_0) and arg_595_1.var_.actorSpriteComps10030 then
				for iter_598_2, iter_598_3 in pairs(arg_595_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_598_3 then
						if arg_595_1.isInRecall_ then
							iter_598_3.color = arg_595_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_598_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_595_1.var_.actorSpriteComps10030 = nil
			end

			local var_598_8 = arg_595_1.actors_["1041_1"]
			local var_598_9 = 0

			if var_598_9 < arg_595_1.time_ and arg_595_1.time_ <= var_598_9 + arg_598_0 and not isNil(var_598_8) then
				local var_598_10 = var_598_8:GetComponent("Image")

				if var_598_10 then
					arg_595_1.var_.highlightMatValue1041_1 = var_598_10
				end
			end

			local var_598_11 = 0.2

			if var_598_9 <= arg_595_1.time_ and arg_595_1.time_ < var_598_9 + var_598_11 and not isNil(var_598_8) then
				local var_598_12 = (arg_595_1.time_ - var_598_9) / var_598_11

				if arg_595_1.var_.highlightMatValue1041_1 then
					local var_598_13 = Mathf.Lerp(0.5, 1, var_598_12)
					local var_598_14 = arg_595_1.var_.highlightMatValue1041_1
					local var_598_15 = var_598_14.color

					var_598_15.r = var_598_13
					var_598_15.g = var_598_13
					var_598_15.b = var_598_13
					var_598_14.color = var_598_15
				end
			end

			if arg_595_1.time_ >= var_598_9 + var_598_11 and arg_595_1.time_ < var_598_9 + var_598_11 + arg_598_0 and not isNil(var_598_8) and arg_595_1.var_.highlightMatValue1041_1 then
				local var_598_16 = 1

				var_598_8.transform:SetSiblingIndex(1)

				local var_598_17 = arg_595_1.var_.highlightMatValue1041_1
				local var_598_18 = var_598_17.color

				var_598_18.r = var_598_16
				var_598_18.g = var_598_16
				var_598_18.b = var_598_16
				var_598_17.color = var_598_18
			end

			local var_598_19 = 0
			local var_598_20 = 0.35

			if var_598_19 < arg_595_1.time_ and arg_595_1.time_ <= var_598_19 + arg_598_0 then
				arg_595_1.talkMaxDuration = 0
				arg_595_1.dialogCg_.alpha = 1

				arg_595_1.dialog_:SetActive(true)
				SetActive(arg_595_1.leftNameGo_, true)

				local var_598_21 = arg_595_1:FormatText(StoryNameCfg[208].name)

				arg_595_1.leftNameTxt_.text = var_598_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_595_1.leftNameTxt_.transform)

				arg_595_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_595_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_595_1:RecordName(arg_595_1.leftNameTxt_.text)
				SetActive(arg_595_1.iconTrs_.gameObject, false)
				arg_595_1.callingController_:SetSelectedState("normal")

				local var_598_22 = arg_595_1:GetWordFromCfg(115311145)
				local var_598_23 = arg_595_1:FormatText(var_598_22.content)

				arg_595_1.text_.text = var_598_23

				LuaForUtil.ClearLinePrefixSymbol(arg_595_1.text_)

				local var_598_24 = 14
				local var_598_25 = utf8.len(var_598_23)
				local var_598_26 = var_598_24 <= 0 and var_598_20 or var_598_20 * (var_598_25 / var_598_24)

				if var_598_26 > 0 and var_598_20 < var_598_26 then
					arg_595_1.talkMaxDuration = var_598_26

					if var_598_26 + var_598_19 > arg_595_1.duration_ then
						arg_595_1.duration_ = var_598_26 + var_598_19
					end
				end

				arg_595_1.text_.text = var_598_23
				arg_595_1.typewritter.percent = 0

				arg_595_1.typewritter:SetDirty()
				arg_595_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311145", "story_v_out_115311.awb") ~= 0 then
					local var_598_27 = manager.audio:GetVoiceLength("story_v_out_115311", "115311145", "story_v_out_115311.awb") / 1000

					if var_598_27 + var_598_19 > arg_595_1.duration_ then
						arg_595_1.duration_ = var_598_27 + var_598_19
					end

					if var_598_22.prefab_name ~= "" and arg_595_1.actors_[var_598_22.prefab_name] ~= nil then
						local var_598_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_595_1.actors_[var_598_22.prefab_name].transform, "story_v_out_115311", "115311145", "story_v_out_115311.awb")

						arg_595_1:RecordAudio("115311145", var_598_28)
						arg_595_1:RecordAudio("115311145", var_598_28)
					else
						arg_595_1:AudioAction("play", "voice", "story_v_out_115311", "115311145", "story_v_out_115311.awb")
					end

					arg_595_1:RecordHistoryTalkVoice("story_v_out_115311", "115311145", "story_v_out_115311.awb")
				end

				arg_595_1:RecordContent(arg_595_1.text_.text)
			end

			local var_598_29 = math.max(var_598_20, arg_595_1.talkMaxDuration)

			if var_598_19 <= arg_595_1.time_ and arg_595_1.time_ < var_598_19 + var_598_29 then
				arg_595_1.typewritter.percent = (arg_595_1.time_ - var_598_19) / var_598_29

				arg_595_1.typewritter:SetDirty()
			end

			if arg_595_1.time_ >= var_598_19 + var_598_29 and arg_595_1.time_ < var_598_19 + var_598_29 + arg_598_0 then
				arg_595_1.typewritter.percent = 1

				arg_595_1.typewritter:SetDirty()
				arg_595_1:ShowNextGo(true)
			end
		end

		arg_595_1.nodeConfigList_ = {}

		arg_595_1:InitPlayNodeList()
	end,
	Play115311146 = function(arg_599_0, arg_599_1)
		arg_599_1.time_ = 0
		arg_599_1.frameCnt_ = 0
		arg_599_1.state_ = "playing"
		arg_599_1.curTalkId_ = 115311146
		arg_599_1.duration_ = 5

		SetActive(arg_599_1.tipsGo_, false)

		function arg_599_1.onSingleLineFinish_()
			arg_599_1.onSingleLineUpdate_ = nil
			arg_599_1.onSingleLineFinish_ = nil
			arg_599_1.state_ = "waiting"
		end

		function arg_599_1.playNext_(arg_601_0)
			if arg_601_0 == 1 then
				arg_599_0:Play115311147(arg_599_1)
			end
		end

		function arg_599_1.onSingleLineUpdate_(arg_602_0)
			local var_602_0 = arg_599_1.actors_["10030"].transform
			local var_602_1 = 0

			if var_602_1 < arg_599_1.time_ and arg_599_1.time_ <= var_602_1 + arg_602_0 then
				arg_599_1.var_.moveOldPos10030 = var_602_0.localPosition
				var_602_0.localScale = Vector3.New(1, 1, 1)

				arg_599_1:CheckSpriteTmpPos("10030", 2)

				local var_602_2 = var_602_0.childCount

				for iter_602_0 = 0, var_602_2 - 1 do
					local var_602_3 = var_602_0:GetChild(iter_602_0)

					if var_602_3.name == "split_3" or not string.find(var_602_3.name, "split") then
						var_602_3.gameObject:SetActive(true)
					else
						var_602_3.gameObject:SetActive(false)
					end
				end
			end

			local var_602_4 = 0.001

			if var_602_1 <= arg_599_1.time_ and arg_599_1.time_ < var_602_1 + var_602_4 then
				local var_602_5 = (arg_599_1.time_ - var_602_1) / var_602_4
				local var_602_6 = Vector3.New(-390, -390, 150)

				var_602_0.localPosition = Vector3.Lerp(arg_599_1.var_.moveOldPos10030, var_602_6, var_602_5)
			end

			if arg_599_1.time_ >= var_602_1 + var_602_4 and arg_599_1.time_ < var_602_1 + var_602_4 + arg_602_0 then
				var_602_0.localPosition = Vector3.New(-390, -390, 150)
			end

			local var_602_7 = arg_599_1.actors_["1041_1"]
			local var_602_8 = 0

			if var_602_8 < arg_599_1.time_ and arg_599_1.time_ <= var_602_8 + arg_602_0 and not isNil(var_602_7) then
				local var_602_9 = var_602_7:GetComponent("Image")

				if var_602_9 then
					arg_599_1.var_.highlightMatValue1041_1 = var_602_9
				end
			end

			local var_602_10 = 0.2

			if var_602_8 <= arg_599_1.time_ and arg_599_1.time_ < var_602_8 + var_602_10 and not isNil(var_602_7) then
				local var_602_11 = (arg_599_1.time_ - var_602_8) / var_602_10

				if arg_599_1.var_.highlightMatValue1041_1 then
					local var_602_12 = Mathf.Lerp(1, 0.5, var_602_11)
					local var_602_13 = arg_599_1.var_.highlightMatValue1041_1
					local var_602_14 = var_602_13.color

					var_602_14.r = var_602_12
					var_602_14.g = var_602_12
					var_602_14.b = var_602_12
					var_602_13.color = var_602_14
				end
			end

			if arg_599_1.time_ >= var_602_8 + var_602_10 and arg_599_1.time_ < var_602_8 + var_602_10 + arg_602_0 and not isNil(var_602_7) and arg_599_1.var_.highlightMatValue1041_1 then
				local var_602_15 = 0.5
				local var_602_16 = arg_599_1.var_.highlightMatValue1041_1
				local var_602_17 = var_602_16.color

				var_602_17.r = var_602_15
				var_602_17.g = var_602_15
				var_602_17.b = var_602_15
				var_602_16.color = var_602_17
			end

			local var_602_18 = 0
			local var_602_19 = 0.575

			if var_602_18 < arg_599_1.time_ and arg_599_1.time_ <= var_602_18 + arg_602_0 then
				arg_599_1.talkMaxDuration = 0
				arg_599_1.dialogCg_.alpha = 1

				arg_599_1.dialog_:SetActive(true)
				SetActive(arg_599_1.leftNameGo_, false)

				arg_599_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_599_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_599_1:RecordName(arg_599_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_599_1.iconTrs_.gameObject, false)
				arg_599_1.callingController_:SetSelectedState("normal")

				local var_602_20 = arg_599_1:GetWordFromCfg(115311146)
				local var_602_21 = arg_599_1:FormatText(var_602_20.content)

				arg_599_1.text_.text = var_602_21

				LuaForUtil.ClearLinePrefixSymbol(arg_599_1.text_)

				local var_602_22 = 23
				local var_602_23 = utf8.len(var_602_21)
				local var_602_24 = var_602_22 <= 0 and var_602_19 or var_602_19 * (var_602_23 / var_602_22)

				if var_602_24 > 0 and var_602_19 < var_602_24 then
					arg_599_1.talkMaxDuration = var_602_24

					if var_602_24 + var_602_18 > arg_599_1.duration_ then
						arg_599_1.duration_ = var_602_24 + var_602_18
					end
				end

				arg_599_1.text_.text = var_602_21
				arg_599_1.typewritter.percent = 0

				arg_599_1.typewritter:SetDirty()
				arg_599_1:ShowNextGo(false)
				arg_599_1:RecordContent(arg_599_1.text_.text)
			end

			local var_602_25 = math.max(var_602_19, arg_599_1.talkMaxDuration)

			if var_602_18 <= arg_599_1.time_ and arg_599_1.time_ < var_602_18 + var_602_25 then
				arg_599_1.typewritter.percent = (arg_599_1.time_ - var_602_18) / var_602_25

				arg_599_1.typewritter:SetDirty()
			end

			if arg_599_1.time_ >= var_602_18 + var_602_25 and arg_599_1.time_ < var_602_18 + var_602_25 + arg_602_0 then
				arg_599_1.typewritter.percent = 1

				arg_599_1.typewritter:SetDirty()
				arg_599_1:ShowNextGo(true)
			end
		end

		arg_599_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10030",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_599_1:InitPlayNodeList()
	end,
	Play115311147 = function(arg_603_0, arg_603_1)
		arg_603_1.time_ = 0
		arg_603_1.frameCnt_ = 0
		arg_603_1.state_ = "playing"
		arg_603_1.curTalkId_ = 115311147
		arg_603_1.duration_ = 10.23

		local var_603_0 = {
			ja = 10.233,
			ko = 6.733,
			zh = 5.5,
			en = 6.3
		}
		local var_603_1 = manager.audio:GetLocalizationFlag()

		if var_603_0[var_603_1] ~= nil then
			arg_603_1.duration_ = var_603_0[var_603_1]
		end

		SetActive(arg_603_1.tipsGo_, false)

		function arg_603_1.onSingleLineFinish_()
			arg_603_1.onSingleLineUpdate_ = nil
			arg_603_1.onSingleLineFinish_ = nil
			arg_603_1.state_ = "waiting"
		end

		function arg_603_1.playNext_(arg_605_0)
			if arg_605_0 == 1 then
				arg_603_0:Play115311148(arg_603_1)
			end
		end

		function arg_603_1.onSingleLineUpdate_(arg_606_0)
			local var_606_0 = arg_603_1.actors_["1041_1"]
			local var_606_1 = 0

			if var_606_1 < arg_603_1.time_ and arg_603_1.time_ <= var_606_1 + arg_606_0 and not isNil(var_606_0) then
				local var_606_2 = var_606_0:GetComponent("Image")

				if var_606_2 then
					arg_603_1.var_.highlightMatValue1041_1 = var_606_2
				end
			end

			local var_606_3 = 0.2

			if var_606_1 <= arg_603_1.time_ and arg_603_1.time_ < var_606_1 + var_606_3 and not isNil(var_606_0) then
				local var_606_4 = (arg_603_1.time_ - var_606_1) / var_606_3

				if arg_603_1.var_.highlightMatValue1041_1 then
					local var_606_5 = Mathf.Lerp(0.5, 1, var_606_4)
					local var_606_6 = arg_603_1.var_.highlightMatValue1041_1
					local var_606_7 = var_606_6.color

					var_606_7.r = var_606_5
					var_606_7.g = var_606_5
					var_606_7.b = var_606_5
					var_606_6.color = var_606_7
				end
			end

			if arg_603_1.time_ >= var_606_1 + var_606_3 and arg_603_1.time_ < var_606_1 + var_606_3 + arg_606_0 and not isNil(var_606_0) and arg_603_1.var_.highlightMatValue1041_1 then
				local var_606_8 = 1

				var_606_0.transform:SetSiblingIndex(1)

				local var_606_9 = arg_603_1.var_.highlightMatValue1041_1
				local var_606_10 = var_606_9.color

				var_606_10.r = var_606_8
				var_606_10.g = var_606_8
				var_606_10.b = var_606_8
				var_606_9.color = var_606_10
			end

			local var_606_11 = 0
			local var_606_12 = 0.725

			if var_606_11 < arg_603_1.time_ and arg_603_1.time_ <= var_606_11 + arg_606_0 then
				arg_603_1.talkMaxDuration = 0
				arg_603_1.dialogCg_.alpha = 1

				arg_603_1.dialog_:SetActive(true)
				SetActive(arg_603_1.leftNameGo_, true)

				local var_606_13 = arg_603_1:FormatText(StoryNameCfg[208].name)

				arg_603_1.leftNameTxt_.text = var_606_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_603_1.leftNameTxt_.transform)

				arg_603_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_603_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_603_1:RecordName(arg_603_1.leftNameTxt_.text)
				SetActive(arg_603_1.iconTrs_.gameObject, false)
				arg_603_1.callingController_:SetSelectedState("normal")

				local var_606_14 = arg_603_1:GetWordFromCfg(115311147)
				local var_606_15 = arg_603_1:FormatText(var_606_14.content)

				arg_603_1.text_.text = var_606_15

				LuaForUtil.ClearLinePrefixSymbol(arg_603_1.text_)

				local var_606_16 = 29
				local var_606_17 = utf8.len(var_606_15)
				local var_606_18 = var_606_16 <= 0 and var_606_12 or var_606_12 * (var_606_17 / var_606_16)

				if var_606_18 > 0 and var_606_12 < var_606_18 then
					arg_603_1.talkMaxDuration = var_606_18

					if var_606_18 + var_606_11 > arg_603_1.duration_ then
						arg_603_1.duration_ = var_606_18 + var_606_11
					end
				end

				arg_603_1.text_.text = var_606_15
				arg_603_1.typewritter.percent = 0

				arg_603_1.typewritter:SetDirty()
				arg_603_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311147", "story_v_out_115311.awb") ~= 0 then
					local var_606_19 = manager.audio:GetVoiceLength("story_v_out_115311", "115311147", "story_v_out_115311.awb") / 1000

					if var_606_19 + var_606_11 > arg_603_1.duration_ then
						arg_603_1.duration_ = var_606_19 + var_606_11
					end

					if var_606_14.prefab_name ~= "" and arg_603_1.actors_[var_606_14.prefab_name] ~= nil then
						local var_606_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_603_1.actors_[var_606_14.prefab_name].transform, "story_v_out_115311", "115311147", "story_v_out_115311.awb")

						arg_603_1:RecordAudio("115311147", var_606_20)
						arg_603_1:RecordAudio("115311147", var_606_20)
					else
						arg_603_1:AudioAction("play", "voice", "story_v_out_115311", "115311147", "story_v_out_115311.awb")
					end

					arg_603_1:RecordHistoryTalkVoice("story_v_out_115311", "115311147", "story_v_out_115311.awb")
				end

				arg_603_1:RecordContent(arg_603_1.text_.text)
			end

			local var_606_21 = math.max(var_606_12, arg_603_1.talkMaxDuration)

			if var_606_11 <= arg_603_1.time_ and arg_603_1.time_ < var_606_11 + var_606_21 then
				arg_603_1.typewritter.percent = (arg_603_1.time_ - var_606_11) / var_606_21

				arg_603_1.typewritter:SetDirty()
			end

			if arg_603_1.time_ >= var_606_11 + var_606_21 and arg_603_1.time_ < var_606_11 + var_606_21 + arg_606_0 then
				arg_603_1.typewritter.percent = 1

				arg_603_1.typewritter:SetDirty()
				arg_603_1:ShowNextGo(true)
			end
		end

		arg_603_1.nodeConfigList_ = {}

		arg_603_1:InitPlayNodeList()
	end,
	Play115311148 = function(arg_607_0, arg_607_1)
		arg_607_1.time_ = 0
		arg_607_1.frameCnt_ = 0
		arg_607_1.state_ = "playing"
		arg_607_1.curTalkId_ = 115311148
		arg_607_1.duration_ = 12.87

		local var_607_0 = {
			ja = 12.866,
			ko = 9.666,
			zh = 8.5,
			en = 11.3
		}
		local var_607_1 = manager.audio:GetLocalizationFlag()

		if var_607_0[var_607_1] ~= nil then
			arg_607_1.duration_ = var_607_0[var_607_1]
		end

		SetActive(arg_607_1.tipsGo_, false)

		function arg_607_1.onSingleLineFinish_()
			arg_607_1.onSingleLineUpdate_ = nil
			arg_607_1.onSingleLineFinish_ = nil
			arg_607_1.state_ = "waiting"
		end

		function arg_607_1.playNext_(arg_609_0)
			if arg_609_0 == 1 then
				arg_607_0:Play115311149(arg_607_1)
			end
		end

		function arg_607_1.onSingleLineUpdate_(arg_610_0)
			local var_610_0 = 0
			local var_610_1 = 1

			if var_610_0 < arg_607_1.time_ and arg_607_1.time_ <= var_610_0 + arg_610_0 then
				arg_607_1.talkMaxDuration = 0
				arg_607_1.dialogCg_.alpha = 1

				arg_607_1.dialog_:SetActive(true)
				SetActive(arg_607_1.leftNameGo_, true)

				local var_610_2 = arg_607_1:FormatText(StoryNameCfg[208].name)

				arg_607_1.leftNameTxt_.text = var_610_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_607_1.leftNameTxt_.transform)

				arg_607_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_607_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_607_1:RecordName(arg_607_1.leftNameTxt_.text)
				SetActive(arg_607_1.iconTrs_.gameObject, false)
				arg_607_1.callingController_:SetSelectedState("normal")

				local var_610_3 = arg_607_1:GetWordFromCfg(115311148)
				local var_610_4 = arg_607_1:FormatText(var_610_3.content)

				arg_607_1.text_.text = var_610_4

				LuaForUtil.ClearLinePrefixSymbol(arg_607_1.text_)

				local var_610_5 = 41
				local var_610_6 = utf8.len(var_610_4)
				local var_610_7 = var_610_5 <= 0 and var_610_1 or var_610_1 * (var_610_6 / var_610_5)

				if var_610_7 > 0 and var_610_1 < var_610_7 then
					arg_607_1.talkMaxDuration = var_610_7

					if var_610_7 + var_610_0 > arg_607_1.duration_ then
						arg_607_1.duration_ = var_610_7 + var_610_0
					end
				end

				arg_607_1.text_.text = var_610_4
				arg_607_1.typewritter.percent = 0

				arg_607_1.typewritter:SetDirty()
				arg_607_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311148", "story_v_out_115311.awb") ~= 0 then
					local var_610_8 = manager.audio:GetVoiceLength("story_v_out_115311", "115311148", "story_v_out_115311.awb") / 1000

					if var_610_8 + var_610_0 > arg_607_1.duration_ then
						arg_607_1.duration_ = var_610_8 + var_610_0
					end

					if var_610_3.prefab_name ~= "" and arg_607_1.actors_[var_610_3.prefab_name] ~= nil then
						local var_610_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_607_1.actors_[var_610_3.prefab_name].transform, "story_v_out_115311", "115311148", "story_v_out_115311.awb")

						arg_607_1:RecordAudio("115311148", var_610_9)
						arg_607_1:RecordAudio("115311148", var_610_9)
					else
						arg_607_1:AudioAction("play", "voice", "story_v_out_115311", "115311148", "story_v_out_115311.awb")
					end

					arg_607_1:RecordHistoryTalkVoice("story_v_out_115311", "115311148", "story_v_out_115311.awb")
				end

				arg_607_1:RecordContent(arg_607_1.text_.text)
			end

			local var_610_10 = math.max(var_610_1, arg_607_1.talkMaxDuration)

			if var_610_0 <= arg_607_1.time_ and arg_607_1.time_ < var_610_0 + var_610_10 then
				arg_607_1.typewritter.percent = (arg_607_1.time_ - var_610_0) / var_610_10

				arg_607_1.typewritter:SetDirty()
			end

			if arg_607_1.time_ >= var_610_0 + var_610_10 and arg_607_1.time_ < var_610_0 + var_610_10 + arg_610_0 then
				arg_607_1.typewritter.percent = 1

				arg_607_1.typewritter:SetDirty()
				arg_607_1:ShowNextGo(true)
			end
		end

		arg_607_1.nodeConfigList_ = {}

		arg_607_1:InitPlayNodeList()
	end,
	Play115311149 = function(arg_611_0, arg_611_1)
		arg_611_1.time_ = 0
		arg_611_1.frameCnt_ = 0
		arg_611_1.state_ = "playing"
		arg_611_1.curTalkId_ = 115311149
		arg_611_1.duration_ = 1.6

		local var_611_0 = {
			ja = 0.999999999999,
			ko = 0.999999999999,
			zh = 1.6,
			en = 1.166
		}
		local var_611_1 = manager.audio:GetLocalizationFlag()

		if var_611_0[var_611_1] ~= nil then
			arg_611_1.duration_ = var_611_0[var_611_1]
		end

		SetActive(arg_611_1.tipsGo_, false)

		function arg_611_1.onSingleLineFinish_()
			arg_611_1.onSingleLineUpdate_ = nil
			arg_611_1.onSingleLineFinish_ = nil
			arg_611_1.state_ = "waiting"
		end

		function arg_611_1.playNext_(arg_613_0)
			if arg_613_0 == 1 then
				arg_611_0:Play115311150(arg_611_1)
			end
		end

		function arg_611_1.onSingleLineUpdate_(arg_614_0)
			local var_614_0 = arg_611_1.actors_["1041_1"]
			local var_614_1 = 0

			if var_614_1 < arg_611_1.time_ and arg_611_1.time_ <= var_614_1 + arg_614_0 and not isNil(var_614_0) then
				local var_614_2 = var_614_0:GetComponent("Image")

				if var_614_2 then
					arg_611_1.var_.highlightMatValue1041_1 = var_614_2
				end
			end

			local var_614_3 = 0.2

			if var_614_1 <= arg_611_1.time_ and arg_611_1.time_ < var_614_1 + var_614_3 and not isNil(var_614_0) then
				local var_614_4 = (arg_611_1.time_ - var_614_1) / var_614_3

				if arg_611_1.var_.highlightMatValue1041_1 then
					local var_614_5 = Mathf.Lerp(1, 0.5, var_614_4)
					local var_614_6 = arg_611_1.var_.highlightMatValue1041_1
					local var_614_7 = var_614_6.color

					var_614_7.r = var_614_5
					var_614_7.g = var_614_5
					var_614_7.b = var_614_5
					var_614_6.color = var_614_7
				end
			end

			if arg_611_1.time_ >= var_614_1 + var_614_3 and arg_611_1.time_ < var_614_1 + var_614_3 + arg_614_0 and not isNil(var_614_0) and arg_611_1.var_.highlightMatValue1041_1 then
				local var_614_8 = 0.5
				local var_614_9 = arg_611_1.var_.highlightMatValue1041_1
				local var_614_10 = var_614_9.color

				var_614_10.r = var_614_8
				var_614_10.g = var_614_8
				var_614_10.b = var_614_8
				var_614_9.color = var_614_10
			end

			local var_614_11 = arg_611_1.actors_["10030"]
			local var_614_12 = 0

			if var_614_12 < arg_611_1.time_ and arg_611_1.time_ <= var_614_12 + arg_614_0 and not isNil(var_614_11) and arg_611_1.var_.actorSpriteComps10030 == nil then
				arg_611_1.var_.actorSpriteComps10030 = var_614_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_614_13 = 0.2

			if var_614_12 <= arg_611_1.time_ and arg_611_1.time_ < var_614_12 + var_614_13 and not isNil(var_614_11) then
				local var_614_14 = (arg_611_1.time_ - var_614_12) / var_614_13

				if arg_611_1.var_.actorSpriteComps10030 then
					for iter_614_0, iter_614_1 in pairs(arg_611_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_614_1 then
							if arg_611_1.isInRecall_ then
								local var_614_15 = Mathf.Lerp(iter_614_1.color.r, arg_611_1.hightColor1.r, var_614_14)
								local var_614_16 = Mathf.Lerp(iter_614_1.color.g, arg_611_1.hightColor1.g, var_614_14)
								local var_614_17 = Mathf.Lerp(iter_614_1.color.b, arg_611_1.hightColor1.b, var_614_14)

								iter_614_1.color = Color.New(var_614_15, var_614_16, var_614_17)
							else
								local var_614_18 = Mathf.Lerp(iter_614_1.color.r, 1, var_614_14)

								iter_614_1.color = Color.New(var_614_18, var_614_18, var_614_18)
							end
						end
					end
				end
			end

			if arg_611_1.time_ >= var_614_12 + var_614_13 and arg_611_1.time_ < var_614_12 + var_614_13 + arg_614_0 and not isNil(var_614_11) and arg_611_1.var_.actorSpriteComps10030 then
				for iter_614_2, iter_614_3 in pairs(arg_611_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_614_3 then
						if arg_611_1.isInRecall_ then
							iter_614_3.color = arg_611_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_614_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_611_1.var_.actorSpriteComps10030 = nil
			end

			local var_614_19 = 0
			local var_614_20 = 0.1

			if var_614_19 < arg_611_1.time_ and arg_611_1.time_ <= var_614_19 + arg_614_0 then
				arg_611_1.talkMaxDuration = 0
				arg_611_1.dialogCg_.alpha = 1

				arg_611_1.dialog_:SetActive(true)
				SetActive(arg_611_1.leftNameGo_, true)

				local var_614_21 = arg_611_1:FormatText(StoryNameCfg[309].name)

				arg_611_1.leftNameTxt_.text = var_614_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_611_1.leftNameTxt_.transform)

				arg_611_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_611_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_611_1:RecordName(arg_611_1.leftNameTxt_.text)
				SetActive(arg_611_1.iconTrs_.gameObject, false)
				arg_611_1.callingController_:SetSelectedState("normal")

				local var_614_22 = arg_611_1:GetWordFromCfg(115311149)
				local var_614_23 = arg_611_1:FormatText(var_614_22.content)

				arg_611_1.text_.text = var_614_23

				LuaForUtil.ClearLinePrefixSymbol(arg_611_1.text_)

				local var_614_24 = 4
				local var_614_25 = utf8.len(var_614_23)
				local var_614_26 = var_614_24 <= 0 and var_614_20 or var_614_20 * (var_614_25 / var_614_24)

				if var_614_26 > 0 and var_614_20 < var_614_26 then
					arg_611_1.talkMaxDuration = var_614_26

					if var_614_26 + var_614_19 > arg_611_1.duration_ then
						arg_611_1.duration_ = var_614_26 + var_614_19
					end
				end

				arg_611_1.text_.text = var_614_23
				arg_611_1.typewritter.percent = 0

				arg_611_1.typewritter:SetDirty()
				arg_611_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311149", "story_v_out_115311.awb") ~= 0 then
					local var_614_27 = manager.audio:GetVoiceLength("story_v_out_115311", "115311149", "story_v_out_115311.awb") / 1000

					if var_614_27 + var_614_19 > arg_611_1.duration_ then
						arg_611_1.duration_ = var_614_27 + var_614_19
					end

					if var_614_22.prefab_name ~= "" and arg_611_1.actors_[var_614_22.prefab_name] ~= nil then
						local var_614_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_611_1.actors_[var_614_22.prefab_name].transform, "story_v_out_115311", "115311149", "story_v_out_115311.awb")

						arg_611_1:RecordAudio("115311149", var_614_28)
						arg_611_1:RecordAudio("115311149", var_614_28)
					else
						arg_611_1:AudioAction("play", "voice", "story_v_out_115311", "115311149", "story_v_out_115311.awb")
					end

					arg_611_1:RecordHistoryTalkVoice("story_v_out_115311", "115311149", "story_v_out_115311.awb")
				end

				arg_611_1:RecordContent(arg_611_1.text_.text)
			end

			local var_614_29 = math.max(var_614_20, arg_611_1.talkMaxDuration)

			if var_614_19 <= arg_611_1.time_ and arg_611_1.time_ < var_614_19 + var_614_29 then
				arg_611_1.typewritter.percent = (arg_611_1.time_ - var_614_19) / var_614_29

				arg_611_1.typewritter:SetDirty()
			end

			if arg_611_1.time_ >= var_614_19 + var_614_29 and arg_611_1.time_ < var_614_19 + var_614_29 + arg_614_0 then
				arg_611_1.typewritter.percent = 1

				arg_611_1.typewritter:SetDirty()
				arg_611_1:ShowNextGo(true)
			end
		end

		arg_611_1.nodeConfigList_ = {}

		arg_611_1:InitPlayNodeList()
	end,
	Play115311150 = function(arg_615_0, arg_615_1)
		arg_615_1.time_ = 0
		arg_615_1.frameCnt_ = 0
		arg_615_1.state_ = "playing"
		arg_615_1.curTalkId_ = 115311150
		arg_615_1.duration_ = 9

		SetActive(arg_615_1.tipsGo_, false)

		function arg_615_1.onSingleLineFinish_()
			arg_615_1.onSingleLineUpdate_ = nil
			arg_615_1.onSingleLineFinish_ = nil
			arg_615_1.state_ = "waiting"
		end

		function arg_615_1.playNext_(arg_617_0)
			if arg_617_0 == 1 then
				arg_615_0:Play115311151(arg_615_1)
			end
		end

		function arg_615_1.onSingleLineUpdate_(arg_618_0)
			local var_618_0 = "F01a"

			if arg_615_1.bgs_[var_618_0] == nil then
				local var_618_1 = Object.Instantiate(arg_615_1.paintGo_)

				var_618_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_618_0)
				var_618_1.name = var_618_0
				var_618_1.transform.parent = arg_615_1.stage_.transform
				var_618_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_615_1.bgs_[var_618_0] = var_618_1
			end

			local var_618_2 = 2

			if var_618_2 < arg_615_1.time_ and arg_615_1.time_ <= var_618_2 + arg_618_0 then
				local var_618_3 = manager.ui.mainCamera.transform.localPosition
				local var_618_4 = Vector3.New(0, 0, 10) + Vector3.New(var_618_3.x, var_618_3.y, 0)
				local var_618_5 = arg_615_1.bgs_.F01a

				var_618_5.transform.localPosition = var_618_4
				var_618_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_618_6 = var_618_5:GetComponent("SpriteRenderer")

				if var_618_6 and var_618_6.sprite then
					local var_618_7 = (var_618_5.transform.localPosition - var_618_3).z
					local var_618_8 = manager.ui.mainCameraCom_
					local var_618_9 = 2 * var_618_7 * Mathf.Tan(var_618_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_618_10 = var_618_9 * var_618_8.aspect
					local var_618_11 = var_618_6.sprite.bounds.size.x
					local var_618_12 = var_618_6.sprite.bounds.size.y
					local var_618_13 = var_618_10 / var_618_11
					local var_618_14 = var_618_9 / var_618_12
					local var_618_15 = var_618_14 < var_618_13 and var_618_13 or var_618_14

					var_618_5.transform.localScale = Vector3.New(var_618_15, var_618_15, 0)
				end

				for iter_618_0, iter_618_1 in pairs(arg_615_1.bgs_) do
					if iter_618_0 ~= "F01a" then
						iter_618_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_618_16 = 0

			if var_618_16 < arg_615_1.time_ and arg_615_1.time_ <= var_618_16 + arg_618_0 then
				arg_615_1.mask_.enabled = true
				arg_615_1.mask_.raycastTarget = true

				arg_615_1:SetGaussion(false)
			end

			local var_618_17 = 2

			if var_618_16 <= arg_615_1.time_ and arg_615_1.time_ < var_618_16 + var_618_17 then
				local var_618_18 = (arg_615_1.time_ - var_618_16) / var_618_17
				local var_618_19 = Color.New(0, 0, 0)

				var_618_19.a = Mathf.Lerp(0, 1, var_618_18)
				arg_615_1.mask_.color = var_618_19
			end

			if arg_615_1.time_ >= var_618_16 + var_618_17 and arg_615_1.time_ < var_618_16 + var_618_17 + arg_618_0 then
				local var_618_20 = Color.New(0, 0, 0)

				var_618_20.a = 1
				arg_615_1.mask_.color = var_618_20
			end

			local var_618_21 = 2

			if var_618_21 < arg_615_1.time_ and arg_615_1.time_ <= var_618_21 + arg_618_0 then
				arg_615_1.mask_.enabled = true
				arg_615_1.mask_.raycastTarget = true

				arg_615_1:SetGaussion(false)
			end

			local var_618_22 = 2

			if var_618_21 <= arg_615_1.time_ and arg_615_1.time_ < var_618_21 + var_618_22 then
				local var_618_23 = (arg_615_1.time_ - var_618_21) / var_618_22
				local var_618_24 = Color.New(0, 0, 0)

				var_618_24.a = Mathf.Lerp(1, 0, var_618_23)
				arg_615_1.mask_.color = var_618_24
			end

			if arg_615_1.time_ >= var_618_21 + var_618_22 and arg_615_1.time_ < var_618_21 + var_618_22 + arg_618_0 then
				local var_618_25 = Color.New(0, 0, 0)
				local var_618_26 = 0

				arg_615_1.mask_.enabled = false
				var_618_25.a = var_618_26
				arg_615_1.mask_.color = var_618_25
			end

			local var_618_27 = arg_615_1.actors_["10030"].transform
			local var_618_28 = 1.966

			if var_618_28 < arg_615_1.time_ and arg_615_1.time_ <= var_618_28 + arg_618_0 then
				arg_615_1.var_.moveOldPos10030 = var_618_27.localPosition
				var_618_27.localScale = Vector3.New(1, 1, 1)

				arg_615_1:CheckSpriteTmpPos("10030", 7)

				local var_618_29 = var_618_27.childCount

				for iter_618_2 = 0, var_618_29 - 1 do
					local var_618_30 = var_618_27:GetChild(iter_618_2)

					if var_618_30.name == "split_3" or not string.find(var_618_30.name, "split") then
						var_618_30.gameObject:SetActive(true)
					else
						var_618_30.gameObject:SetActive(false)
					end
				end
			end

			local var_618_31 = 0.001

			if var_618_28 <= arg_615_1.time_ and arg_615_1.time_ < var_618_28 + var_618_31 then
				local var_618_32 = (arg_615_1.time_ - var_618_28) / var_618_31
				local var_618_33 = Vector3.New(0, -2000, 150)

				var_618_27.localPosition = Vector3.Lerp(arg_615_1.var_.moveOldPos10030, var_618_33, var_618_32)
			end

			if arg_615_1.time_ >= var_618_28 + var_618_31 and arg_615_1.time_ < var_618_28 + var_618_31 + arg_618_0 then
				var_618_27.localPosition = Vector3.New(0, -2000, 150)
			end

			local var_618_34 = arg_615_1.actors_["1041_1"].transform
			local var_618_35 = 1.966

			if var_618_35 < arg_615_1.time_ and arg_615_1.time_ <= var_618_35 + arg_618_0 then
				arg_615_1.var_.moveOldPos1041_1 = var_618_34.localPosition
				var_618_34.localScale = Vector3.New(1, 1, 1)

				arg_615_1:CheckSpriteTmpPos("1041_1", 0)
			end

			local var_618_36 = 0.001

			if var_618_35 <= arg_615_1.time_ and arg_615_1.time_ < var_618_35 + var_618_36 then
				local var_618_37 = (arg_615_1.time_ - var_618_35) / var_618_36
				local var_618_38 = Vector3.New(-1500, -310, -370)

				var_618_34.localPosition = Vector3.Lerp(arg_615_1.var_.moveOldPos1041_1, var_618_38, var_618_37)
			end

			if arg_615_1.time_ >= var_618_35 + var_618_36 and arg_615_1.time_ < var_618_35 + var_618_36 + arg_618_0 then
				var_618_34.localPosition = Vector3.New(-1500, -310, -370)
			end

			local var_618_39 = 0
			local var_618_40 = 1

			if var_618_39 < arg_615_1.time_ and arg_615_1.time_ <= var_618_39 + arg_618_0 then
				local var_618_41 = "play"
				local var_618_42 = "music"

				arg_615_1:AudioAction(var_618_41, var_618_42, "ui_battle", "ui_battle_stopbgm", "")

				local var_618_43 = ""
				local var_618_44 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_618_44 ~= "" then
					if arg_615_1.bgmTxt_.text ~= var_618_44 and arg_615_1.bgmTxt_.text ~= "" then
						if arg_615_1.bgmTxt2_.text ~= "" then
							arg_615_1.bgmTxt_.text = arg_615_1.bgmTxt2_.text
						end

						arg_615_1.bgmTxt2_.text = var_618_44

						arg_615_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_615_1.bgmTxt_.text = var_618_44
						arg_615_1.bgmTxt2_.text = var_618_44
					end

					if arg_615_1.bgmTimer then
						arg_615_1.bgmTimer:Stop()

						arg_615_1.bgmTimer = nil
					end

					if arg_615_1.settingData.show_music_name == 1 then
						arg_615_1.musicController:SetSelectedState("show")
						arg_615_1.musicAnimator_:Play("open", 0, 0)

						if arg_615_1.settingData.music_time ~= 0 then
							arg_615_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_615_1.settingData.music_time), function()
								if arg_615_1 == nil or isNil(arg_615_1.bgmTxt_) then
									return
								end

								arg_615_1.musicController:SetSelectedState("hide")
								arg_615_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_615_1.frameCnt_ <= 1 then
				arg_615_1.dialog_:SetActive(false)
			end

			local var_618_45 = 4
			local var_618_46 = 0.95

			if var_618_45 < arg_615_1.time_ and arg_615_1.time_ <= var_618_45 + arg_618_0 then
				arg_615_1.talkMaxDuration = 0

				arg_615_1.dialog_:SetActive(true)

				arg_615_1.dialogCg_.alpha = 0

				local var_618_47 = LeanTween.value(arg_615_1.dialog_, 0, 1, 0.3)

				var_618_47:setOnUpdate(LuaHelper.FloatAction(function(arg_620_0)
					arg_615_1.dialogCg_.alpha = arg_620_0
				end))
				var_618_47:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_615_1.dialog_)
					var_618_47:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_615_1.duration_ = arg_615_1.duration_ + 0.3

				SetActive(arg_615_1.leftNameGo_, false)

				arg_615_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_615_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_615_1:RecordName(arg_615_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_615_1.iconTrs_.gameObject, false)
				arg_615_1.callingController_:SetSelectedState("normal")

				local var_618_48 = arg_615_1:GetWordFromCfg(115311150)
				local var_618_49 = arg_615_1:FormatText(var_618_48.content)

				arg_615_1.text_.text = var_618_49

				LuaForUtil.ClearLinePrefixSymbol(arg_615_1.text_)

				local var_618_50 = 38
				local var_618_51 = utf8.len(var_618_49)
				local var_618_52 = var_618_50 <= 0 and var_618_46 or var_618_46 * (var_618_51 / var_618_50)

				if var_618_52 > 0 and var_618_46 < var_618_52 then
					arg_615_1.talkMaxDuration = var_618_52
					var_618_45 = var_618_45 + 0.3

					if var_618_52 + var_618_45 > arg_615_1.duration_ then
						arg_615_1.duration_ = var_618_52 + var_618_45
					end
				end

				arg_615_1.text_.text = var_618_49
				arg_615_1.typewritter.percent = 0

				arg_615_1.typewritter:SetDirty()
				arg_615_1:ShowNextGo(false)
				arg_615_1:RecordContent(arg_615_1.text_.text)
			end

			local var_618_53 = var_618_45 + 0.3
			local var_618_54 = math.max(var_618_46, arg_615_1.talkMaxDuration)

			if var_618_53 <= arg_615_1.time_ and arg_615_1.time_ < var_618_53 + var_618_54 then
				arg_615_1.typewritter.percent = (arg_615_1.time_ - var_618_53) / var_618_54

				arg_615_1.typewritter:SetDirty()
			end

			if arg_615_1.time_ >= var_618_53 + var_618_54 and arg_615_1.time_ < var_618_53 + var_618_54 + arg_618_0 then
				arg_615_1.typewritter.percent = 1

				arg_615_1.typewritter:SetDirty()
				arg_615_1:ShowNextGo(true)
			end
		end

		arg_615_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10030",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1041_1",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Sprite
			}
		}

		arg_615_1:InitPlayNodeList()
	end,
	Play115311151 = function(arg_622_0, arg_622_1)
		arg_622_1.time_ = 0
		arg_622_1.frameCnt_ = 0
		arg_622_1.state_ = "playing"
		arg_622_1.curTalkId_ = 115311151
		arg_622_1.duration_ = 10.87

		local var_622_0 = {
			ja = 10.866,
			ko = 7,
			zh = 7.2,
			en = 7.166
		}
		local var_622_1 = manager.audio:GetLocalizationFlag()

		if var_622_0[var_622_1] ~= nil then
			arg_622_1.duration_ = var_622_0[var_622_1]
		end

		SetActive(arg_622_1.tipsGo_, false)

		function arg_622_1.onSingleLineFinish_()
			arg_622_1.onSingleLineUpdate_ = nil
			arg_622_1.onSingleLineFinish_ = nil
			arg_622_1.state_ = "waiting"
		end

		function arg_622_1.playNext_(arg_624_0)
			if arg_624_0 == 1 then
				arg_622_0:Play115311152(arg_622_1)
			end
		end

		function arg_622_1.onSingleLineUpdate_(arg_625_0)
			local var_625_0 = arg_622_1.actors_["10030"]
			local var_625_1 = 0

			if var_625_1 < arg_622_1.time_ and arg_622_1.time_ <= var_625_1 + arg_625_0 then
				local var_625_2 = var_625_0:GetComponentInChildren(typeof(CanvasGroup))

				if var_625_2 then
					arg_622_1.var_.alphaOldValue10030 = var_625_2.alpha
					arg_622_1.var_.characterEffect10030 = var_625_2
				end

				arg_622_1.var_.alphaOldValue10030 = 0
			end

			local var_625_3 = 0.5

			if var_625_1 <= arg_622_1.time_ and arg_622_1.time_ < var_625_1 + var_625_3 then
				local var_625_4 = (arg_622_1.time_ - var_625_1) / var_625_3
				local var_625_5 = Mathf.Lerp(arg_622_1.var_.alphaOldValue10030, 1, var_625_4)

				if arg_622_1.var_.characterEffect10030 then
					arg_622_1.var_.characterEffect10030.alpha = var_625_5
				end
			end

			if arg_622_1.time_ >= var_625_1 + var_625_3 and arg_622_1.time_ < var_625_1 + var_625_3 + arg_625_0 and arg_622_1.var_.characterEffect10030 then
				arg_622_1.var_.characterEffect10030.alpha = 1
			end

			local var_625_6 = arg_622_1.actors_["10030"]
			local var_625_7 = 0

			if var_625_7 < arg_622_1.time_ and arg_622_1.time_ <= var_625_7 + arg_625_0 and not isNil(var_625_6) and arg_622_1.var_.actorSpriteComps10030 == nil then
				arg_622_1.var_.actorSpriteComps10030 = var_625_6:GetComponentsInChildren(typeof(Image), true)
			end

			local var_625_8 = 0.2

			if var_625_7 <= arg_622_1.time_ and arg_622_1.time_ < var_625_7 + var_625_8 and not isNil(var_625_6) then
				local var_625_9 = (arg_622_1.time_ - var_625_7) / var_625_8

				if arg_622_1.var_.actorSpriteComps10030 then
					for iter_625_0, iter_625_1 in pairs(arg_622_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_625_1 then
							if arg_622_1.isInRecall_ then
								local var_625_10 = Mathf.Lerp(iter_625_1.color.r, arg_622_1.hightColor1.r, var_625_9)
								local var_625_11 = Mathf.Lerp(iter_625_1.color.g, arg_622_1.hightColor1.g, var_625_9)
								local var_625_12 = Mathf.Lerp(iter_625_1.color.b, arg_622_1.hightColor1.b, var_625_9)

								iter_625_1.color = Color.New(var_625_10, var_625_11, var_625_12)
							else
								local var_625_13 = Mathf.Lerp(iter_625_1.color.r, 1, var_625_9)

								iter_625_1.color = Color.New(var_625_13, var_625_13, var_625_13)
							end
						end
					end
				end
			end

			if arg_622_1.time_ >= var_625_7 + var_625_8 and arg_622_1.time_ < var_625_7 + var_625_8 + arg_625_0 and not isNil(var_625_6) and arg_622_1.var_.actorSpriteComps10030 then
				for iter_625_2, iter_625_3 in pairs(arg_622_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_625_3 then
						if arg_622_1.isInRecall_ then
							iter_625_3.color = arg_622_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_625_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_622_1.var_.actorSpriteComps10030 = nil
			end

			local var_625_14 = arg_622_1.actors_["10030"].transform
			local var_625_15 = 0

			if var_625_15 < arg_622_1.time_ and arg_622_1.time_ <= var_625_15 + arg_625_0 then
				arg_622_1.var_.moveOldPos10030 = var_625_14.localPosition
				var_625_14.localScale = Vector3.New(1, 1, 1)

				arg_622_1:CheckSpriteTmpPos("10030", 4)

				local var_625_16 = var_625_14.childCount

				for iter_625_4 = 0, var_625_16 - 1 do
					local var_625_17 = var_625_14:GetChild(iter_625_4)

					if var_625_17.name == "split_1" or not string.find(var_625_17.name, "split") then
						var_625_17.gameObject:SetActive(true)
					else
						var_625_17.gameObject:SetActive(false)
					end
				end
			end

			local var_625_18 = 0.001

			if var_625_15 <= arg_622_1.time_ and arg_622_1.time_ < var_625_15 + var_625_18 then
				local var_625_19 = (arg_622_1.time_ - var_625_15) / var_625_18
				local var_625_20 = Vector3.New(390, -390, 150)

				var_625_14.localPosition = Vector3.Lerp(arg_622_1.var_.moveOldPos10030, var_625_20, var_625_19)
			end

			if arg_622_1.time_ >= var_625_15 + var_625_18 and arg_622_1.time_ < var_625_15 + var_625_18 + arg_625_0 then
				var_625_14.localPosition = Vector3.New(390, -390, 150)
			end

			local var_625_21 = 0
			local var_625_22 = 1

			if var_625_21 < arg_622_1.time_ and arg_622_1.time_ <= var_625_21 + arg_625_0 then
				local var_625_23 = "play"
				local var_625_24 = "music"

				arg_622_1:AudioAction(var_625_23, var_625_24, "bgm_side_daily03", "bgm_side_daily03", "bgm_side_daily03.awb")

				local var_625_25 = ""
				local var_625_26 = manager.audio:GetAudioName("bgm_side_daily03", "bgm_side_daily03")

				if var_625_26 ~= "" then
					if arg_622_1.bgmTxt_.text ~= var_625_26 and arg_622_1.bgmTxt_.text ~= "" then
						if arg_622_1.bgmTxt2_.text ~= "" then
							arg_622_1.bgmTxt_.text = arg_622_1.bgmTxt2_.text
						end

						arg_622_1.bgmTxt2_.text = var_625_26

						arg_622_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_622_1.bgmTxt_.text = var_625_26
						arg_622_1.bgmTxt2_.text = var_625_26
					end

					if arg_622_1.bgmTimer then
						arg_622_1.bgmTimer:Stop()

						arg_622_1.bgmTimer = nil
					end

					if arg_622_1.settingData.show_music_name == 1 then
						arg_622_1.musicController:SetSelectedState("show")
						arg_622_1.musicAnimator_:Play("open", 0, 0)

						if arg_622_1.settingData.music_time ~= 0 then
							arg_622_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_622_1.settingData.music_time), function()
								if arg_622_1 == nil or isNil(arg_622_1.bgmTxt_) then
									return
								end

								arg_622_1.musicController:SetSelectedState("hide")
								arg_622_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_625_27 = 0
			local var_625_28 = 0.85

			if var_625_27 < arg_622_1.time_ and arg_622_1.time_ <= var_625_27 + arg_625_0 then
				arg_622_1.talkMaxDuration = 0
				arg_622_1.dialogCg_.alpha = 1

				arg_622_1.dialog_:SetActive(true)
				SetActive(arg_622_1.leftNameGo_, true)

				local var_625_29 = arg_622_1:FormatText(StoryNameCfg[309].name)

				arg_622_1.leftNameTxt_.text = var_625_29

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_622_1.leftNameTxt_.transform)

				arg_622_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_622_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_622_1:RecordName(arg_622_1.leftNameTxt_.text)
				SetActive(arg_622_1.iconTrs_.gameObject, false)
				arg_622_1.callingController_:SetSelectedState("normal")

				local var_625_30 = arg_622_1:GetWordFromCfg(115311151)
				local var_625_31 = arg_622_1:FormatText(var_625_30.content)

				arg_622_1.text_.text = var_625_31

				LuaForUtil.ClearLinePrefixSymbol(arg_622_1.text_)

				local var_625_32 = 34
				local var_625_33 = utf8.len(var_625_31)
				local var_625_34 = var_625_32 <= 0 and var_625_28 or var_625_28 * (var_625_33 / var_625_32)

				if var_625_34 > 0 and var_625_28 < var_625_34 then
					arg_622_1.talkMaxDuration = var_625_34

					if var_625_34 + var_625_27 > arg_622_1.duration_ then
						arg_622_1.duration_ = var_625_34 + var_625_27
					end
				end

				arg_622_1.text_.text = var_625_31
				arg_622_1.typewritter.percent = 0

				arg_622_1.typewritter:SetDirty()
				arg_622_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311151", "story_v_out_115311.awb") ~= 0 then
					local var_625_35 = manager.audio:GetVoiceLength("story_v_out_115311", "115311151", "story_v_out_115311.awb") / 1000

					if var_625_35 + var_625_27 > arg_622_1.duration_ then
						arg_622_1.duration_ = var_625_35 + var_625_27
					end

					if var_625_30.prefab_name ~= "" and arg_622_1.actors_[var_625_30.prefab_name] ~= nil then
						local var_625_36 = LuaForUtil.PlayVoiceWithCriLipsync(arg_622_1.actors_[var_625_30.prefab_name].transform, "story_v_out_115311", "115311151", "story_v_out_115311.awb")

						arg_622_1:RecordAudio("115311151", var_625_36)
						arg_622_1:RecordAudio("115311151", var_625_36)
					else
						arg_622_1:AudioAction("play", "voice", "story_v_out_115311", "115311151", "story_v_out_115311.awb")
					end

					arg_622_1:RecordHistoryTalkVoice("story_v_out_115311", "115311151", "story_v_out_115311.awb")
				end

				arg_622_1:RecordContent(arg_622_1.text_.text)
			end

			local var_625_37 = math.max(var_625_28, arg_622_1.talkMaxDuration)

			if var_625_27 <= arg_622_1.time_ and arg_622_1.time_ < var_625_27 + var_625_37 then
				arg_622_1.typewritter.percent = (arg_622_1.time_ - var_625_27) / var_625_37

				arg_622_1.typewritter:SetDirty()
			end

			if arg_622_1.time_ >= var_625_27 + var_625_37 and arg_622_1.time_ < var_625_27 + var_625_37 + arg_625_0 then
				arg_622_1.typewritter.percent = 1

				arg_622_1.typewritter:SetDirty()
				arg_622_1:ShowNextGo(true)
			end
		end

		arg_622_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10030",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_622_1:InitPlayNodeList()
	end,
	Play115311152 = function(arg_627_0, arg_627_1)
		arg_627_1.time_ = 0
		arg_627_1.frameCnt_ = 0
		arg_627_1.state_ = "playing"
		arg_627_1.curTalkId_ = 115311152
		arg_627_1.duration_ = 12.37

		local var_627_0 = {
			ja = 9.8,
			ko = 10.666,
			zh = 11.4,
			en = 12.366
		}
		local var_627_1 = manager.audio:GetLocalizationFlag()

		if var_627_0[var_627_1] ~= nil then
			arg_627_1.duration_ = var_627_0[var_627_1]
		end

		SetActive(arg_627_1.tipsGo_, false)

		function arg_627_1.onSingleLineFinish_()
			arg_627_1.onSingleLineUpdate_ = nil
			arg_627_1.onSingleLineFinish_ = nil
			arg_627_1.state_ = "waiting"
		end

		function arg_627_1.playNext_(arg_629_0)
			if arg_629_0 == 1 then
				arg_627_0:Play115311153(arg_627_1)
			end
		end

		function arg_627_1.onSingleLineUpdate_(arg_630_0)
			local var_630_0 = arg_627_1.actors_["10030"]
			local var_630_1 = 0

			if var_630_1 < arg_627_1.time_ and arg_627_1.time_ <= var_630_1 + arg_630_0 and not isNil(var_630_0) and arg_627_1.var_.actorSpriteComps10030 == nil then
				arg_627_1.var_.actorSpriteComps10030 = var_630_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_630_2 = 0.2

			if var_630_1 <= arg_627_1.time_ and arg_627_1.time_ < var_630_1 + var_630_2 and not isNil(var_630_0) then
				local var_630_3 = (arg_627_1.time_ - var_630_1) / var_630_2

				if arg_627_1.var_.actorSpriteComps10030 then
					for iter_630_0, iter_630_1 in pairs(arg_627_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_630_1 then
							if arg_627_1.isInRecall_ then
								local var_630_4 = Mathf.Lerp(iter_630_1.color.r, arg_627_1.hightColor2.r, var_630_3)
								local var_630_5 = Mathf.Lerp(iter_630_1.color.g, arg_627_1.hightColor2.g, var_630_3)
								local var_630_6 = Mathf.Lerp(iter_630_1.color.b, arg_627_1.hightColor2.b, var_630_3)

								iter_630_1.color = Color.New(var_630_4, var_630_5, var_630_6)
							else
								local var_630_7 = Mathf.Lerp(iter_630_1.color.r, 0.5, var_630_3)

								iter_630_1.color = Color.New(var_630_7, var_630_7, var_630_7)
							end
						end
					end
				end
			end

			if arg_627_1.time_ >= var_630_1 + var_630_2 and arg_627_1.time_ < var_630_1 + var_630_2 + arg_630_0 and not isNil(var_630_0) and arg_627_1.var_.actorSpriteComps10030 then
				for iter_630_2, iter_630_3 in pairs(arg_627_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_630_3 then
						if arg_627_1.isInRecall_ then
							iter_630_3.color = arg_627_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_630_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_627_1.var_.actorSpriteComps10030 = nil
			end

			local var_630_8 = "1038"

			if arg_627_1.actors_[var_630_8] == nil then
				local var_630_9 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1038")

				if not isNil(var_630_9) then
					local var_630_10 = Object.Instantiate(var_630_9, arg_627_1.canvasGo_.transform)

					var_630_10.transform:SetSiblingIndex(1)

					var_630_10.name = var_630_8
					var_630_10.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_627_1.actors_[var_630_8] = var_630_10

					local var_630_11 = var_630_10:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_627_1.isInRecall_ then
						for iter_630_4, iter_630_5 in ipairs(var_630_11) do
							iter_630_5.color = arg_627_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_630_12 = arg_627_1.actors_["1038"].transform
			local var_630_13 = 0

			if var_630_13 < arg_627_1.time_ and arg_627_1.time_ <= var_630_13 + arg_630_0 then
				arg_627_1.var_.moveOldPos1038 = var_630_12.localPosition
				var_630_12.localScale = Vector3.New(1, 1, 1)

				arg_627_1:CheckSpriteTmpPos("1038", 2)

				local var_630_14 = var_630_12.childCount

				for iter_630_6 = 0, var_630_14 - 1 do
					local var_630_15 = var_630_12:GetChild(iter_630_6)

					if var_630_15.name == "split_1" or not string.find(var_630_15.name, "split") then
						var_630_15.gameObject:SetActive(true)
					else
						var_630_15.gameObject:SetActive(false)
					end
				end
			end

			local var_630_16 = 0.001

			if var_630_13 <= arg_627_1.time_ and arg_627_1.time_ < var_630_13 + var_630_16 then
				local var_630_17 = (arg_627_1.time_ - var_630_13) / var_630_16
				local var_630_18 = Vector3.New(-390, -400, 0)

				var_630_12.localPosition = Vector3.Lerp(arg_627_1.var_.moveOldPos1038, var_630_18, var_630_17)
			end

			if arg_627_1.time_ >= var_630_13 + var_630_16 and arg_627_1.time_ < var_630_13 + var_630_16 + arg_630_0 then
				var_630_12.localPosition = Vector3.New(-390, -400, 0)
			end

			local var_630_19 = arg_627_1.actors_["1038"]
			local var_630_20 = 0

			if var_630_20 < arg_627_1.time_ and arg_627_1.time_ <= var_630_20 + arg_630_0 then
				local var_630_21 = var_630_19:GetComponentInChildren(typeof(CanvasGroup))

				if var_630_21 then
					arg_627_1.var_.alphaOldValue1038 = var_630_21.alpha
					arg_627_1.var_.characterEffect1038 = var_630_21
				end

				arg_627_1.var_.alphaOldValue1038 = 0
			end

			local var_630_22 = 0.5

			if var_630_20 <= arg_627_1.time_ and arg_627_1.time_ < var_630_20 + var_630_22 then
				local var_630_23 = (arg_627_1.time_ - var_630_20) / var_630_22
				local var_630_24 = Mathf.Lerp(arg_627_1.var_.alphaOldValue1038, 1, var_630_23)

				if arg_627_1.var_.characterEffect1038 then
					arg_627_1.var_.characterEffect1038.alpha = var_630_24
				end
			end

			if arg_627_1.time_ >= var_630_20 + var_630_22 and arg_627_1.time_ < var_630_20 + var_630_22 + arg_630_0 and arg_627_1.var_.characterEffect1038 then
				arg_627_1.var_.characterEffect1038.alpha = 1
			end

			local var_630_25 = arg_627_1.actors_["1038"]
			local var_630_26 = 0

			if var_630_26 < arg_627_1.time_ and arg_627_1.time_ <= var_630_26 + arg_630_0 and not isNil(var_630_25) and arg_627_1.var_.actorSpriteComps1038 == nil then
				arg_627_1.var_.actorSpriteComps1038 = var_630_25:GetComponentsInChildren(typeof(Image), true)
			end

			local var_630_27 = 0.2

			if var_630_26 <= arg_627_1.time_ and arg_627_1.time_ < var_630_26 + var_630_27 and not isNil(var_630_25) then
				local var_630_28 = (arg_627_1.time_ - var_630_26) / var_630_27

				if arg_627_1.var_.actorSpriteComps1038 then
					for iter_630_7, iter_630_8 in pairs(arg_627_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_630_8 then
							if arg_627_1.isInRecall_ then
								local var_630_29 = Mathf.Lerp(iter_630_8.color.r, arg_627_1.hightColor1.r, var_630_28)
								local var_630_30 = Mathf.Lerp(iter_630_8.color.g, arg_627_1.hightColor1.g, var_630_28)
								local var_630_31 = Mathf.Lerp(iter_630_8.color.b, arg_627_1.hightColor1.b, var_630_28)

								iter_630_8.color = Color.New(var_630_29, var_630_30, var_630_31)
							else
								local var_630_32 = Mathf.Lerp(iter_630_8.color.r, 1, var_630_28)

								iter_630_8.color = Color.New(var_630_32, var_630_32, var_630_32)
							end
						end
					end
				end
			end

			if arg_627_1.time_ >= var_630_26 + var_630_27 and arg_627_1.time_ < var_630_26 + var_630_27 + arg_630_0 and not isNil(var_630_25) and arg_627_1.var_.actorSpriteComps1038 then
				for iter_630_9, iter_630_10 in pairs(arg_627_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_630_10 then
						if arg_627_1.isInRecall_ then
							iter_630_10.color = arg_627_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_630_10.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_627_1.var_.actorSpriteComps1038 = nil
			end

			local var_630_33 = 0
			local var_630_34 = 1.05

			if var_630_33 < arg_627_1.time_ and arg_627_1.time_ <= var_630_33 + arg_630_0 then
				arg_627_1.talkMaxDuration = 0
				arg_627_1.dialogCg_.alpha = 1

				arg_627_1.dialog_:SetActive(true)
				SetActive(arg_627_1.leftNameGo_, true)

				local var_630_35 = arg_627_1:FormatText(StoryNameCfg[94].name)

				arg_627_1.leftNameTxt_.text = var_630_35

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_627_1.leftNameTxt_.transform)

				arg_627_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_627_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_627_1:RecordName(arg_627_1.leftNameTxt_.text)
				SetActive(arg_627_1.iconTrs_.gameObject, false)
				arg_627_1.callingController_:SetSelectedState("normal")

				local var_630_36 = arg_627_1:GetWordFromCfg(115311152)
				local var_630_37 = arg_627_1:FormatText(var_630_36.content)

				arg_627_1.text_.text = var_630_37

				LuaForUtil.ClearLinePrefixSymbol(arg_627_1.text_)

				local var_630_38 = 42
				local var_630_39 = utf8.len(var_630_37)
				local var_630_40 = var_630_38 <= 0 and var_630_34 or var_630_34 * (var_630_39 / var_630_38)

				if var_630_40 > 0 and var_630_34 < var_630_40 then
					arg_627_1.talkMaxDuration = var_630_40

					if var_630_40 + var_630_33 > arg_627_1.duration_ then
						arg_627_1.duration_ = var_630_40 + var_630_33
					end
				end

				arg_627_1.text_.text = var_630_37
				arg_627_1.typewritter.percent = 0

				arg_627_1.typewritter:SetDirty()
				arg_627_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311152", "story_v_out_115311.awb") ~= 0 then
					local var_630_41 = manager.audio:GetVoiceLength("story_v_out_115311", "115311152", "story_v_out_115311.awb") / 1000

					if var_630_41 + var_630_33 > arg_627_1.duration_ then
						arg_627_1.duration_ = var_630_41 + var_630_33
					end

					if var_630_36.prefab_name ~= "" and arg_627_1.actors_[var_630_36.prefab_name] ~= nil then
						local var_630_42 = LuaForUtil.PlayVoiceWithCriLipsync(arg_627_1.actors_[var_630_36.prefab_name].transform, "story_v_out_115311", "115311152", "story_v_out_115311.awb")

						arg_627_1:RecordAudio("115311152", var_630_42)
						arg_627_1:RecordAudio("115311152", var_630_42)
					else
						arg_627_1:AudioAction("play", "voice", "story_v_out_115311", "115311152", "story_v_out_115311.awb")
					end

					arg_627_1:RecordHistoryTalkVoice("story_v_out_115311", "115311152", "story_v_out_115311.awb")
				end

				arg_627_1:RecordContent(arg_627_1.text_.text)
			end

			local var_630_43 = math.max(var_630_34, arg_627_1.talkMaxDuration)

			if var_630_33 <= arg_627_1.time_ and arg_627_1.time_ < var_630_33 + var_630_43 then
				arg_627_1.typewritter.percent = (arg_627_1.time_ - var_630_33) / var_630_43

				arg_627_1.typewritter:SetDirty()
			end

			if arg_627_1.time_ >= var_630_33 + var_630_43 and arg_627_1.time_ < var_630_33 + var_630_43 + arg_630_0 then
				arg_627_1.typewritter.percent = 1

				arg_627_1.typewritter:SetDirty()
				arg_627_1:ShowNextGo(true)
			end
		end

		arg_627_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_627_1:InitPlayNodeList()
	end,
	Play115311153 = function(arg_631_0, arg_631_1)
		arg_631_1.time_ = 0
		arg_631_1.frameCnt_ = 0
		arg_631_1.state_ = "playing"
		arg_631_1.curTalkId_ = 115311153
		arg_631_1.duration_ = 13.17

		local var_631_0 = {
			ja = 12.666,
			ko = 9.633,
			zh = 13.166,
			en = 10.566
		}
		local var_631_1 = manager.audio:GetLocalizationFlag()

		if var_631_0[var_631_1] ~= nil then
			arg_631_1.duration_ = var_631_0[var_631_1]
		end

		SetActive(arg_631_1.tipsGo_, false)

		function arg_631_1.onSingleLineFinish_()
			arg_631_1.onSingleLineUpdate_ = nil
			arg_631_1.onSingleLineFinish_ = nil
			arg_631_1.state_ = "waiting"
		end

		function arg_631_1.playNext_(arg_633_0)
			if arg_633_0 == 1 then
				arg_631_0:Play115311154(arg_631_1)
			end
		end

		function arg_631_1.onSingleLineUpdate_(arg_634_0)
			local var_634_0 = 0
			local var_634_1 = 1.25

			if var_634_0 < arg_631_1.time_ and arg_631_1.time_ <= var_634_0 + arg_634_0 then
				arg_631_1.talkMaxDuration = 0
				arg_631_1.dialogCg_.alpha = 1

				arg_631_1.dialog_:SetActive(true)
				SetActive(arg_631_1.leftNameGo_, true)

				local var_634_2 = arg_631_1:FormatText(StoryNameCfg[94].name)

				arg_631_1.leftNameTxt_.text = var_634_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_631_1.leftNameTxt_.transform)

				arg_631_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_631_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_631_1:RecordName(arg_631_1.leftNameTxt_.text)
				SetActive(arg_631_1.iconTrs_.gameObject, false)
				arg_631_1.callingController_:SetSelectedState("normal")

				local var_634_3 = arg_631_1:GetWordFromCfg(115311153)
				local var_634_4 = arg_631_1:FormatText(var_634_3.content)

				arg_631_1.text_.text = var_634_4

				LuaForUtil.ClearLinePrefixSymbol(arg_631_1.text_)

				local var_634_5 = 50
				local var_634_6 = utf8.len(var_634_4)
				local var_634_7 = var_634_5 <= 0 and var_634_1 or var_634_1 * (var_634_6 / var_634_5)

				if var_634_7 > 0 and var_634_1 < var_634_7 then
					arg_631_1.talkMaxDuration = var_634_7

					if var_634_7 + var_634_0 > arg_631_1.duration_ then
						arg_631_1.duration_ = var_634_7 + var_634_0
					end
				end

				arg_631_1.text_.text = var_634_4
				arg_631_1.typewritter.percent = 0

				arg_631_1.typewritter:SetDirty()
				arg_631_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311153", "story_v_out_115311.awb") ~= 0 then
					local var_634_8 = manager.audio:GetVoiceLength("story_v_out_115311", "115311153", "story_v_out_115311.awb") / 1000

					if var_634_8 + var_634_0 > arg_631_1.duration_ then
						arg_631_1.duration_ = var_634_8 + var_634_0
					end

					if var_634_3.prefab_name ~= "" and arg_631_1.actors_[var_634_3.prefab_name] ~= nil then
						local var_634_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_631_1.actors_[var_634_3.prefab_name].transform, "story_v_out_115311", "115311153", "story_v_out_115311.awb")

						arg_631_1:RecordAudio("115311153", var_634_9)
						arg_631_1:RecordAudio("115311153", var_634_9)
					else
						arg_631_1:AudioAction("play", "voice", "story_v_out_115311", "115311153", "story_v_out_115311.awb")
					end

					arg_631_1:RecordHistoryTalkVoice("story_v_out_115311", "115311153", "story_v_out_115311.awb")
				end

				arg_631_1:RecordContent(arg_631_1.text_.text)
			end

			local var_634_10 = math.max(var_634_1, arg_631_1.talkMaxDuration)

			if var_634_0 <= arg_631_1.time_ and arg_631_1.time_ < var_634_0 + var_634_10 then
				arg_631_1.typewritter.percent = (arg_631_1.time_ - var_634_0) / var_634_10

				arg_631_1.typewritter:SetDirty()
			end

			if arg_631_1.time_ >= var_634_0 + var_634_10 and arg_631_1.time_ < var_634_0 + var_634_10 + arg_634_0 then
				arg_631_1.typewritter.percent = 1

				arg_631_1.typewritter:SetDirty()
				arg_631_1:ShowNextGo(true)
			end
		end

		arg_631_1.nodeConfigList_ = {}

		arg_631_1:InitPlayNodeList()
	end,
	Play115311154 = function(arg_635_0, arg_635_1)
		arg_635_1.time_ = 0
		arg_635_1.frameCnt_ = 0
		arg_635_1.state_ = "playing"
		arg_635_1.curTalkId_ = 115311154
		arg_635_1.duration_ = 5

		SetActive(arg_635_1.tipsGo_, false)

		function arg_635_1.onSingleLineFinish_()
			arg_635_1.onSingleLineUpdate_ = nil
			arg_635_1.onSingleLineFinish_ = nil
			arg_635_1.state_ = "waiting"
		end

		function arg_635_1.playNext_(arg_637_0)
			if arg_637_0 == 1 then
				arg_635_0:Play115311155(arg_635_1)
			end
		end

		function arg_635_1.onSingleLineUpdate_(arg_638_0)
			local var_638_0 = arg_635_1.actors_["10030"]
			local var_638_1 = 0

			if var_638_1 < arg_635_1.time_ and arg_635_1.time_ <= var_638_1 + arg_638_0 then
				local var_638_2 = var_638_0:GetComponentInChildren(typeof(CanvasGroup))

				if var_638_2 then
					arg_635_1.var_.alphaOldValue10030 = var_638_2.alpha
					arg_635_1.var_.characterEffect10030 = var_638_2
				end

				arg_635_1.var_.alphaOldValue10030 = 1
			end

			local var_638_3 = 0.5

			if var_638_1 <= arg_635_1.time_ and arg_635_1.time_ < var_638_1 + var_638_3 then
				local var_638_4 = (arg_635_1.time_ - var_638_1) / var_638_3
				local var_638_5 = Mathf.Lerp(arg_635_1.var_.alphaOldValue10030, 0, var_638_4)

				if arg_635_1.var_.characterEffect10030 then
					arg_635_1.var_.characterEffect10030.alpha = var_638_5
				end
			end

			if arg_635_1.time_ >= var_638_1 + var_638_3 and arg_635_1.time_ < var_638_1 + var_638_3 + arg_638_0 and arg_635_1.var_.characterEffect10030 then
				arg_635_1.var_.characterEffect10030.alpha = 0
			end

			local var_638_6 = arg_635_1.actors_["1038"]
			local var_638_7 = 0

			if var_638_7 < arg_635_1.time_ and arg_635_1.time_ <= var_638_7 + arg_638_0 then
				local var_638_8 = var_638_6:GetComponentInChildren(typeof(CanvasGroup))

				if var_638_8 then
					arg_635_1.var_.alphaOldValue1038 = var_638_8.alpha
					arg_635_1.var_.characterEffect1038 = var_638_8
				end

				arg_635_1.var_.alphaOldValue1038 = 1
			end

			local var_638_9 = 0.5

			if var_638_7 <= arg_635_1.time_ and arg_635_1.time_ < var_638_7 + var_638_9 then
				local var_638_10 = (arg_635_1.time_ - var_638_7) / var_638_9
				local var_638_11 = Mathf.Lerp(arg_635_1.var_.alphaOldValue1038, 0, var_638_10)

				if arg_635_1.var_.characterEffect1038 then
					arg_635_1.var_.characterEffect1038.alpha = var_638_11
				end
			end

			if arg_635_1.time_ >= var_638_7 + var_638_9 and arg_635_1.time_ < var_638_7 + var_638_9 + arg_638_0 and arg_635_1.var_.characterEffect1038 then
				arg_635_1.var_.characterEffect1038.alpha = 0
			end

			local var_638_12 = 0
			local var_638_13 = 1.425

			if var_638_12 < arg_635_1.time_ and arg_635_1.time_ <= var_638_12 + arg_638_0 then
				arg_635_1.talkMaxDuration = 0
				arg_635_1.dialogCg_.alpha = 1

				arg_635_1.dialog_:SetActive(true)
				SetActive(arg_635_1.leftNameGo_, false)

				arg_635_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_635_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_635_1:RecordName(arg_635_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_635_1.iconTrs_.gameObject, false)
				arg_635_1.callingController_:SetSelectedState("normal")

				local var_638_14 = arg_635_1:GetWordFromCfg(115311154)
				local var_638_15 = arg_635_1:FormatText(var_638_14.content)

				arg_635_1.text_.text = var_638_15

				LuaForUtil.ClearLinePrefixSymbol(arg_635_1.text_)

				local var_638_16 = 57
				local var_638_17 = utf8.len(var_638_15)
				local var_638_18 = var_638_16 <= 0 and var_638_13 or var_638_13 * (var_638_17 / var_638_16)

				if var_638_18 > 0 and var_638_13 < var_638_18 then
					arg_635_1.talkMaxDuration = var_638_18

					if var_638_18 + var_638_12 > arg_635_1.duration_ then
						arg_635_1.duration_ = var_638_18 + var_638_12
					end
				end

				arg_635_1.text_.text = var_638_15
				arg_635_1.typewritter.percent = 0

				arg_635_1.typewritter:SetDirty()
				arg_635_1:ShowNextGo(false)
				arg_635_1:RecordContent(arg_635_1.text_.text)
			end

			local var_638_19 = math.max(var_638_13, arg_635_1.talkMaxDuration)

			if var_638_12 <= arg_635_1.time_ and arg_635_1.time_ < var_638_12 + var_638_19 then
				arg_635_1.typewritter.percent = (arg_635_1.time_ - var_638_12) / var_638_19

				arg_635_1.typewritter:SetDirty()
			end

			if arg_635_1.time_ >= var_638_12 + var_638_19 and arg_635_1.time_ < var_638_12 + var_638_19 + arg_638_0 then
				arg_635_1.typewritter.percent = 1

				arg_635_1.typewritter:SetDirty()
				arg_635_1:ShowNextGo(true)
			end
		end

		arg_635_1.nodeConfigList_ = {}

		arg_635_1:InitPlayNodeList()
	end,
	Play115311155 = function(arg_639_0, arg_639_1)
		arg_639_1.time_ = 0
		arg_639_1.frameCnt_ = 0
		arg_639_1.state_ = "playing"
		arg_639_1.curTalkId_ = 115311155
		arg_639_1.duration_ = 5

		SetActive(arg_639_1.tipsGo_, false)

		function arg_639_1.onSingleLineFinish_()
			arg_639_1.onSingleLineUpdate_ = nil
			arg_639_1.onSingleLineFinish_ = nil
			arg_639_1.state_ = "waiting"
		end

		function arg_639_1.playNext_(arg_641_0)
			if arg_641_0 == 1 then
				arg_639_0:Play115311156(arg_639_1)
			end
		end

		function arg_639_1.onSingleLineUpdate_(arg_642_0)
			local var_642_0 = 0
			local var_642_1 = 0.9

			if var_642_0 < arg_639_1.time_ and arg_639_1.time_ <= var_642_0 + arg_642_0 then
				arg_639_1.talkMaxDuration = 0
				arg_639_1.dialogCg_.alpha = 1

				arg_639_1.dialog_:SetActive(true)
				SetActive(arg_639_1.leftNameGo_, false)

				arg_639_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_639_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_639_1:RecordName(arg_639_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_639_1.iconTrs_.gameObject, false)
				arg_639_1.callingController_:SetSelectedState("normal")

				local var_642_2 = arg_639_1:GetWordFromCfg(115311155)
				local var_642_3 = arg_639_1:FormatText(var_642_2.content)

				arg_639_1.text_.text = var_642_3

				LuaForUtil.ClearLinePrefixSymbol(arg_639_1.text_)

				local var_642_4 = 36
				local var_642_5 = utf8.len(var_642_3)
				local var_642_6 = var_642_4 <= 0 and var_642_1 or var_642_1 * (var_642_5 / var_642_4)

				if var_642_6 > 0 and var_642_1 < var_642_6 then
					arg_639_1.talkMaxDuration = var_642_6

					if var_642_6 + var_642_0 > arg_639_1.duration_ then
						arg_639_1.duration_ = var_642_6 + var_642_0
					end
				end

				arg_639_1.text_.text = var_642_3
				arg_639_1.typewritter.percent = 0

				arg_639_1.typewritter:SetDirty()
				arg_639_1:ShowNextGo(false)
				arg_639_1:RecordContent(arg_639_1.text_.text)
			end

			local var_642_7 = math.max(var_642_1, arg_639_1.talkMaxDuration)

			if var_642_0 <= arg_639_1.time_ and arg_639_1.time_ < var_642_0 + var_642_7 then
				arg_639_1.typewritter.percent = (arg_639_1.time_ - var_642_0) / var_642_7

				arg_639_1.typewritter:SetDirty()
			end

			if arg_639_1.time_ >= var_642_0 + var_642_7 and arg_639_1.time_ < var_642_0 + var_642_7 + arg_642_0 then
				arg_639_1.typewritter.percent = 1

				arg_639_1.typewritter:SetDirty()
				arg_639_1:ShowNextGo(true)
			end
		end

		arg_639_1.nodeConfigList_ = {}

		arg_639_1:InitPlayNodeList()
	end,
	Play115311156 = function(arg_643_0, arg_643_1)
		arg_643_1.time_ = 0
		arg_643_1.frameCnt_ = 0
		arg_643_1.state_ = "playing"
		arg_643_1.curTalkId_ = 115311156
		arg_643_1.duration_ = 7.93

		local var_643_0 = {
			ja = 7.933,
			ko = 4,
			zh = 3.3,
			en = 4.066
		}
		local var_643_1 = manager.audio:GetLocalizationFlag()

		if var_643_0[var_643_1] ~= nil then
			arg_643_1.duration_ = var_643_0[var_643_1]
		end

		SetActive(arg_643_1.tipsGo_, false)

		function arg_643_1.onSingleLineFinish_()
			arg_643_1.onSingleLineUpdate_ = nil
			arg_643_1.onSingleLineFinish_ = nil
			arg_643_1.state_ = "waiting"
		end

		function arg_643_1.playNext_(arg_645_0)
			if arg_645_0 == 1 then
				arg_643_0:Play115311157(arg_643_1)
			end
		end

		function arg_643_1.onSingleLineUpdate_(arg_646_0)
			local var_646_0 = arg_643_1.actors_["10030"]
			local var_646_1 = 0

			if var_646_1 < arg_643_1.time_ and arg_643_1.time_ <= var_646_1 + arg_646_0 then
				local var_646_2 = var_646_0:GetComponentInChildren(typeof(CanvasGroup))

				if var_646_2 then
					arg_643_1.var_.alphaOldValue10030 = var_646_2.alpha
					arg_643_1.var_.characterEffect10030 = var_646_2
				end

				arg_643_1.var_.alphaOldValue10030 = 0
			end

			local var_646_3 = 0.5

			if var_646_1 <= arg_643_1.time_ and arg_643_1.time_ < var_646_1 + var_646_3 then
				local var_646_4 = (arg_643_1.time_ - var_646_1) / var_646_3
				local var_646_5 = Mathf.Lerp(arg_643_1.var_.alphaOldValue10030, 1, var_646_4)

				if arg_643_1.var_.characterEffect10030 then
					arg_643_1.var_.characterEffect10030.alpha = var_646_5
				end
			end

			if arg_643_1.time_ >= var_646_1 + var_646_3 and arg_643_1.time_ < var_646_1 + var_646_3 + arg_646_0 and arg_643_1.var_.characterEffect10030 then
				arg_643_1.var_.characterEffect10030.alpha = 1
			end

			local var_646_6 = arg_643_1.actors_["1038"]
			local var_646_7 = 0

			if var_646_7 < arg_643_1.time_ and arg_643_1.time_ <= var_646_7 + arg_646_0 then
				local var_646_8 = var_646_6:GetComponentInChildren(typeof(CanvasGroup))

				if var_646_8 then
					arg_643_1.var_.alphaOldValue1038 = var_646_8.alpha
					arg_643_1.var_.characterEffect1038 = var_646_8
				end

				arg_643_1.var_.alphaOldValue1038 = 0
			end

			local var_646_9 = 0.5

			if var_646_7 <= arg_643_1.time_ and arg_643_1.time_ < var_646_7 + var_646_9 then
				local var_646_10 = (arg_643_1.time_ - var_646_7) / var_646_9
				local var_646_11 = Mathf.Lerp(arg_643_1.var_.alphaOldValue1038, 1, var_646_10)

				if arg_643_1.var_.characterEffect1038 then
					arg_643_1.var_.characterEffect1038.alpha = var_646_11
				end
			end

			if arg_643_1.time_ >= var_646_7 + var_646_9 and arg_643_1.time_ < var_646_7 + var_646_9 + arg_646_0 and arg_643_1.var_.characterEffect1038 then
				arg_643_1.var_.characterEffect1038.alpha = 1
			end

			local var_646_12 = arg_643_1.actors_["10030"].transform
			local var_646_13 = 0

			if var_646_13 < arg_643_1.time_ and arg_643_1.time_ <= var_646_13 + arg_646_0 then
				arg_643_1.var_.moveOldPos10030 = var_646_12.localPosition
				var_646_12.localScale = Vector3.New(1, 1, 1)

				arg_643_1:CheckSpriteTmpPos("10030", 4)

				local var_646_14 = var_646_12.childCount

				for iter_646_0 = 0, var_646_14 - 1 do
					local var_646_15 = var_646_12:GetChild(iter_646_0)

					if var_646_15.name == "split_2" or not string.find(var_646_15.name, "split") then
						var_646_15.gameObject:SetActive(true)
					else
						var_646_15.gameObject:SetActive(false)
					end
				end
			end

			local var_646_16 = 0.001

			if var_646_13 <= arg_643_1.time_ and arg_643_1.time_ < var_646_13 + var_646_16 then
				local var_646_17 = (arg_643_1.time_ - var_646_13) / var_646_16
				local var_646_18 = Vector3.New(390, -390, 150)

				var_646_12.localPosition = Vector3.Lerp(arg_643_1.var_.moveOldPos10030, var_646_18, var_646_17)
			end

			if arg_643_1.time_ >= var_646_13 + var_646_16 and arg_643_1.time_ < var_646_13 + var_646_16 + arg_646_0 then
				var_646_12.localPosition = Vector3.New(390, -390, 150)
			end

			local var_646_19 = arg_643_1.actors_["10030"]
			local var_646_20 = 0

			if var_646_20 < arg_643_1.time_ and arg_643_1.time_ <= var_646_20 + arg_646_0 and not isNil(var_646_19) and arg_643_1.var_.actorSpriteComps10030 == nil then
				arg_643_1.var_.actorSpriteComps10030 = var_646_19:GetComponentsInChildren(typeof(Image), true)
			end

			local var_646_21 = 0.2

			if var_646_20 <= arg_643_1.time_ and arg_643_1.time_ < var_646_20 + var_646_21 and not isNil(var_646_19) then
				local var_646_22 = (arg_643_1.time_ - var_646_20) / var_646_21

				if arg_643_1.var_.actorSpriteComps10030 then
					for iter_646_1, iter_646_2 in pairs(arg_643_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_646_2 then
							if arg_643_1.isInRecall_ then
								local var_646_23 = Mathf.Lerp(iter_646_2.color.r, arg_643_1.hightColor1.r, var_646_22)
								local var_646_24 = Mathf.Lerp(iter_646_2.color.g, arg_643_1.hightColor1.g, var_646_22)
								local var_646_25 = Mathf.Lerp(iter_646_2.color.b, arg_643_1.hightColor1.b, var_646_22)

								iter_646_2.color = Color.New(var_646_23, var_646_24, var_646_25)
							else
								local var_646_26 = Mathf.Lerp(iter_646_2.color.r, 1, var_646_22)

								iter_646_2.color = Color.New(var_646_26, var_646_26, var_646_26)
							end
						end
					end
				end
			end

			if arg_643_1.time_ >= var_646_20 + var_646_21 and arg_643_1.time_ < var_646_20 + var_646_21 + arg_646_0 and not isNil(var_646_19) and arg_643_1.var_.actorSpriteComps10030 then
				for iter_646_3, iter_646_4 in pairs(arg_643_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_646_4 then
						if arg_643_1.isInRecall_ then
							iter_646_4.color = arg_643_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_646_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_643_1.var_.actorSpriteComps10030 = nil
			end

			local var_646_27 = arg_643_1.actors_["1038"]
			local var_646_28 = 0

			if var_646_28 < arg_643_1.time_ and arg_643_1.time_ <= var_646_28 + arg_646_0 and not isNil(var_646_27) and arg_643_1.var_.actorSpriteComps1038 == nil then
				arg_643_1.var_.actorSpriteComps1038 = var_646_27:GetComponentsInChildren(typeof(Image), true)
			end

			local var_646_29 = 0.2

			if var_646_28 <= arg_643_1.time_ and arg_643_1.time_ < var_646_28 + var_646_29 and not isNil(var_646_27) then
				local var_646_30 = (arg_643_1.time_ - var_646_28) / var_646_29

				if arg_643_1.var_.actorSpriteComps1038 then
					for iter_646_5, iter_646_6 in pairs(arg_643_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_646_6 then
							if arg_643_1.isInRecall_ then
								local var_646_31 = Mathf.Lerp(iter_646_6.color.r, arg_643_1.hightColor2.r, var_646_30)
								local var_646_32 = Mathf.Lerp(iter_646_6.color.g, arg_643_1.hightColor2.g, var_646_30)
								local var_646_33 = Mathf.Lerp(iter_646_6.color.b, arg_643_1.hightColor2.b, var_646_30)

								iter_646_6.color = Color.New(var_646_31, var_646_32, var_646_33)
							else
								local var_646_34 = Mathf.Lerp(iter_646_6.color.r, 0.5, var_646_30)

								iter_646_6.color = Color.New(var_646_34, var_646_34, var_646_34)
							end
						end
					end
				end
			end

			if arg_643_1.time_ >= var_646_28 + var_646_29 and arg_643_1.time_ < var_646_28 + var_646_29 + arg_646_0 and not isNil(var_646_27) and arg_643_1.var_.actorSpriteComps1038 then
				for iter_646_7, iter_646_8 in pairs(arg_643_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_646_8 then
						if arg_643_1.isInRecall_ then
							iter_646_8.color = arg_643_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_646_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_643_1.var_.actorSpriteComps1038 = nil
			end

			local var_646_35 = 0
			local var_646_36 = 0.35

			if var_646_35 < arg_643_1.time_ and arg_643_1.time_ <= var_646_35 + arg_646_0 then
				arg_643_1.talkMaxDuration = 0
				arg_643_1.dialogCg_.alpha = 1

				arg_643_1.dialog_:SetActive(true)
				SetActive(arg_643_1.leftNameGo_, true)

				local var_646_37 = arg_643_1:FormatText(StoryNameCfg[309].name)

				arg_643_1.leftNameTxt_.text = var_646_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_643_1.leftNameTxt_.transform)

				arg_643_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_643_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_643_1:RecordName(arg_643_1.leftNameTxt_.text)
				SetActive(arg_643_1.iconTrs_.gameObject, false)
				arg_643_1.callingController_:SetSelectedState("normal")

				local var_646_38 = arg_643_1:GetWordFromCfg(115311156)
				local var_646_39 = arg_643_1:FormatText(var_646_38.content)

				arg_643_1.text_.text = var_646_39

				LuaForUtil.ClearLinePrefixSymbol(arg_643_1.text_)

				local var_646_40 = 14
				local var_646_41 = utf8.len(var_646_39)
				local var_646_42 = var_646_40 <= 0 and var_646_36 or var_646_36 * (var_646_41 / var_646_40)

				if var_646_42 > 0 and var_646_36 < var_646_42 then
					arg_643_1.talkMaxDuration = var_646_42

					if var_646_42 + var_646_35 > arg_643_1.duration_ then
						arg_643_1.duration_ = var_646_42 + var_646_35
					end
				end

				arg_643_1.text_.text = var_646_39
				arg_643_1.typewritter.percent = 0

				arg_643_1.typewritter:SetDirty()
				arg_643_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311156", "story_v_out_115311.awb") ~= 0 then
					local var_646_43 = manager.audio:GetVoiceLength("story_v_out_115311", "115311156", "story_v_out_115311.awb") / 1000

					if var_646_43 + var_646_35 > arg_643_1.duration_ then
						arg_643_1.duration_ = var_646_43 + var_646_35
					end

					if var_646_38.prefab_name ~= "" and arg_643_1.actors_[var_646_38.prefab_name] ~= nil then
						local var_646_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_643_1.actors_[var_646_38.prefab_name].transform, "story_v_out_115311", "115311156", "story_v_out_115311.awb")

						arg_643_1:RecordAudio("115311156", var_646_44)
						arg_643_1:RecordAudio("115311156", var_646_44)
					else
						arg_643_1:AudioAction("play", "voice", "story_v_out_115311", "115311156", "story_v_out_115311.awb")
					end

					arg_643_1:RecordHistoryTalkVoice("story_v_out_115311", "115311156", "story_v_out_115311.awb")
				end

				arg_643_1:RecordContent(arg_643_1.text_.text)
			end

			local var_646_45 = math.max(var_646_36, arg_643_1.talkMaxDuration)

			if var_646_35 <= arg_643_1.time_ and arg_643_1.time_ < var_646_35 + var_646_45 then
				arg_643_1.typewritter.percent = (arg_643_1.time_ - var_646_35) / var_646_45

				arg_643_1.typewritter:SetDirty()
			end

			if arg_643_1.time_ >= var_646_35 + var_646_45 and arg_643_1.time_ < var_646_35 + var_646_45 + arg_646_0 then
				arg_643_1.typewritter.percent = 1

				arg_643_1.typewritter:SetDirty()
				arg_643_1:ShowNextGo(true)
			end
		end

		arg_643_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10030",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_643_1:InitPlayNodeList()
	end,
	Play115311157 = function(arg_647_0, arg_647_1)
		arg_647_1.time_ = 0
		arg_647_1.frameCnt_ = 0
		arg_647_1.state_ = "playing"
		arg_647_1.curTalkId_ = 115311157
		arg_647_1.duration_ = 6.4

		local var_647_0 = {
			ja = 6.4,
			ko = 4.2,
			zh = 5.733,
			en = 5.8
		}
		local var_647_1 = manager.audio:GetLocalizationFlag()

		if var_647_0[var_647_1] ~= nil then
			arg_647_1.duration_ = var_647_0[var_647_1]
		end

		SetActive(arg_647_1.tipsGo_, false)

		function arg_647_1.onSingleLineFinish_()
			arg_647_1.onSingleLineUpdate_ = nil
			arg_647_1.onSingleLineFinish_ = nil
			arg_647_1.state_ = "waiting"
		end

		function arg_647_1.playNext_(arg_649_0)
			if arg_649_0 == 1 then
				arg_647_0:Play115311158(arg_647_1)
			end
		end

		function arg_647_1.onSingleLineUpdate_(arg_650_0)
			local var_650_0 = arg_647_1.actors_["10030"]
			local var_650_1 = 0

			if var_650_1 < arg_647_1.time_ and arg_647_1.time_ <= var_650_1 + arg_650_0 and not isNil(var_650_0) and arg_647_1.var_.actorSpriteComps10030 == nil then
				arg_647_1.var_.actorSpriteComps10030 = var_650_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_650_2 = 0.2

			if var_650_1 <= arg_647_1.time_ and arg_647_1.time_ < var_650_1 + var_650_2 and not isNil(var_650_0) then
				local var_650_3 = (arg_647_1.time_ - var_650_1) / var_650_2

				if arg_647_1.var_.actorSpriteComps10030 then
					for iter_650_0, iter_650_1 in pairs(arg_647_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_650_1 then
							if arg_647_1.isInRecall_ then
								local var_650_4 = Mathf.Lerp(iter_650_1.color.r, arg_647_1.hightColor2.r, var_650_3)
								local var_650_5 = Mathf.Lerp(iter_650_1.color.g, arg_647_1.hightColor2.g, var_650_3)
								local var_650_6 = Mathf.Lerp(iter_650_1.color.b, arg_647_1.hightColor2.b, var_650_3)

								iter_650_1.color = Color.New(var_650_4, var_650_5, var_650_6)
							else
								local var_650_7 = Mathf.Lerp(iter_650_1.color.r, 0.5, var_650_3)

								iter_650_1.color = Color.New(var_650_7, var_650_7, var_650_7)
							end
						end
					end
				end
			end

			if arg_647_1.time_ >= var_650_1 + var_650_2 and arg_647_1.time_ < var_650_1 + var_650_2 + arg_650_0 and not isNil(var_650_0) and arg_647_1.var_.actorSpriteComps10030 then
				for iter_650_2, iter_650_3 in pairs(arg_647_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_650_3 then
						if arg_647_1.isInRecall_ then
							iter_650_3.color = arg_647_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_650_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_647_1.var_.actorSpriteComps10030 = nil
			end

			local var_650_8 = arg_647_1.actors_["1038"]
			local var_650_9 = 0

			if var_650_9 < arg_647_1.time_ and arg_647_1.time_ <= var_650_9 + arg_650_0 and not isNil(var_650_8) and arg_647_1.var_.actorSpriteComps1038 == nil then
				arg_647_1.var_.actorSpriteComps1038 = var_650_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_650_10 = 0.2

			if var_650_9 <= arg_647_1.time_ and arg_647_1.time_ < var_650_9 + var_650_10 and not isNil(var_650_8) then
				local var_650_11 = (arg_647_1.time_ - var_650_9) / var_650_10

				if arg_647_1.var_.actorSpriteComps1038 then
					for iter_650_4, iter_650_5 in pairs(arg_647_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_650_5 then
							if arg_647_1.isInRecall_ then
								local var_650_12 = Mathf.Lerp(iter_650_5.color.r, arg_647_1.hightColor1.r, var_650_11)
								local var_650_13 = Mathf.Lerp(iter_650_5.color.g, arg_647_1.hightColor1.g, var_650_11)
								local var_650_14 = Mathf.Lerp(iter_650_5.color.b, arg_647_1.hightColor1.b, var_650_11)

								iter_650_5.color = Color.New(var_650_12, var_650_13, var_650_14)
							else
								local var_650_15 = Mathf.Lerp(iter_650_5.color.r, 1, var_650_11)

								iter_650_5.color = Color.New(var_650_15, var_650_15, var_650_15)
							end
						end
					end
				end
			end

			if arg_647_1.time_ >= var_650_9 + var_650_10 and arg_647_1.time_ < var_650_9 + var_650_10 + arg_650_0 and not isNil(var_650_8) and arg_647_1.var_.actorSpriteComps1038 then
				for iter_650_6, iter_650_7 in pairs(arg_647_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_650_7 then
						if arg_647_1.isInRecall_ then
							iter_650_7.color = arg_647_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_650_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_647_1.var_.actorSpriteComps1038 = nil
			end

			local var_650_16 = arg_647_1.actors_["1038"].transform
			local var_650_17 = 0

			if var_650_17 < arg_647_1.time_ and arg_647_1.time_ <= var_650_17 + arg_650_0 then
				arg_647_1.var_.moveOldPos1038 = var_650_16.localPosition
				var_650_16.localScale = Vector3.New(1, 1, 1)

				arg_647_1:CheckSpriteTmpPos("1038", 2)

				local var_650_18 = var_650_16.childCount

				for iter_650_8 = 0, var_650_18 - 1 do
					local var_650_19 = var_650_16:GetChild(iter_650_8)

					if var_650_19.name == "split_9" or not string.find(var_650_19.name, "split") then
						var_650_19.gameObject:SetActive(true)
					else
						var_650_19.gameObject:SetActive(false)
					end
				end
			end

			local var_650_20 = 0.001

			if var_650_17 <= arg_647_1.time_ and arg_647_1.time_ < var_650_17 + var_650_20 then
				local var_650_21 = (arg_647_1.time_ - var_650_17) / var_650_20
				local var_650_22 = Vector3.New(-390, -400, 0)

				var_650_16.localPosition = Vector3.Lerp(arg_647_1.var_.moveOldPos1038, var_650_22, var_650_21)
			end

			if arg_647_1.time_ >= var_650_17 + var_650_20 and arg_647_1.time_ < var_650_17 + var_650_20 + arg_650_0 then
				var_650_16.localPosition = Vector3.New(-390, -400, 0)
			end

			local var_650_23 = 0
			local var_650_24 = 0.5

			if var_650_23 < arg_647_1.time_ and arg_647_1.time_ <= var_650_23 + arg_650_0 then
				arg_647_1.talkMaxDuration = 0
				arg_647_1.dialogCg_.alpha = 1

				arg_647_1.dialog_:SetActive(true)
				SetActive(arg_647_1.leftNameGo_, true)

				local var_650_25 = arg_647_1:FormatText(StoryNameCfg[94].name)

				arg_647_1.leftNameTxt_.text = var_650_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_647_1.leftNameTxt_.transform)

				arg_647_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_647_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_647_1:RecordName(arg_647_1.leftNameTxt_.text)
				SetActive(arg_647_1.iconTrs_.gameObject, false)
				arg_647_1.callingController_:SetSelectedState("normal")

				local var_650_26 = arg_647_1:GetWordFromCfg(115311157)
				local var_650_27 = arg_647_1:FormatText(var_650_26.content)

				arg_647_1.text_.text = var_650_27

				LuaForUtil.ClearLinePrefixSymbol(arg_647_1.text_)

				local var_650_28 = 20
				local var_650_29 = utf8.len(var_650_27)
				local var_650_30 = var_650_28 <= 0 and var_650_24 or var_650_24 * (var_650_29 / var_650_28)

				if var_650_30 > 0 and var_650_24 < var_650_30 then
					arg_647_1.talkMaxDuration = var_650_30

					if var_650_30 + var_650_23 > arg_647_1.duration_ then
						arg_647_1.duration_ = var_650_30 + var_650_23
					end
				end

				arg_647_1.text_.text = var_650_27
				arg_647_1.typewritter.percent = 0

				arg_647_1.typewritter:SetDirty()
				arg_647_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311157", "story_v_out_115311.awb") ~= 0 then
					local var_650_31 = manager.audio:GetVoiceLength("story_v_out_115311", "115311157", "story_v_out_115311.awb") / 1000

					if var_650_31 + var_650_23 > arg_647_1.duration_ then
						arg_647_1.duration_ = var_650_31 + var_650_23
					end

					if var_650_26.prefab_name ~= "" and arg_647_1.actors_[var_650_26.prefab_name] ~= nil then
						local var_650_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_647_1.actors_[var_650_26.prefab_name].transform, "story_v_out_115311", "115311157", "story_v_out_115311.awb")

						arg_647_1:RecordAudio("115311157", var_650_32)
						arg_647_1:RecordAudio("115311157", var_650_32)
					else
						arg_647_1:AudioAction("play", "voice", "story_v_out_115311", "115311157", "story_v_out_115311.awb")
					end

					arg_647_1:RecordHistoryTalkVoice("story_v_out_115311", "115311157", "story_v_out_115311.awb")
				end

				arg_647_1:RecordContent(arg_647_1.text_.text)
			end

			local var_650_33 = math.max(var_650_24, arg_647_1.talkMaxDuration)

			if var_650_23 <= arg_647_1.time_ and arg_647_1.time_ < var_650_23 + var_650_33 then
				arg_647_1.typewritter.percent = (arg_647_1.time_ - var_650_23) / var_650_33

				arg_647_1.typewritter:SetDirty()
			end

			if arg_647_1.time_ >= var_650_23 + var_650_33 and arg_647_1.time_ < var_650_23 + var_650_33 + arg_650_0 then
				arg_647_1.typewritter.percent = 1

				arg_647_1.typewritter:SetDirty()
				arg_647_1:ShowNextGo(true)
			end
		end

		arg_647_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_647_1:InitPlayNodeList()
	end,
	Play115311158 = function(arg_651_0, arg_651_1)
		arg_651_1.time_ = 0
		arg_651_1.frameCnt_ = 0
		arg_651_1.state_ = "playing"
		arg_651_1.curTalkId_ = 115311158
		arg_651_1.duration_ = 17.6

		local var_651_0 = {
			ja = 17.466,
			ko = 15.8,
			zh = 13.766,
			en = 17.6
		}
		local var_651_1 = manager.audio:GetLocalizationFlag()

		if var_651_0[var_651_1] ~= nil then
			arg_651_1.duration_ = var_651_0[var_651_1]
		end

		SetActive(arg_651_1.tipsGo_, false)

		function arg_651_1.onSingleLineFinish_()
			arg_651_1.onSingleLineUpdate_ = nil
			arg_651_1.onSingleLineFinish_ = nil
			arg_651_1.state_ = "waiting"
		end

		function arg_651_1.playNext_(arg_653_0)
			if arg_653_0 == 1 then
				arg_651_0:Play115311159(arg_651_1)
			end
		end

		function arg_651_1.onSingleLineUpdate_(arg_654_0)
			local var_654_0 = 0
			local var_654_1 = 1.375

			if var_654_0 < arg_651_1.time_ and arg_651_1.time_ <= var_654_0 + arg_654_0 then
				arg_651_1.talkMaxDuration = 0
				arg_651_1.dialogCg_.alpha = 1

				arg_651_1.dialog_:SetActive(true)
				SetActive(arg_651_1.leftNameGo_, true)

				local var_654_2 = arg_651_1:FormatText(StoryNameCfg[94].name)

				arg_651_1.leftNameTxt_.text = var_654_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_651_1.leftNameTxt_.transform)

				arg_651_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_651_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_651_1:RecordName(arg_651_1.leftNameTxt_.text)
				SetActive(arg_651_1.iconTrs_.gameObject, false)
				arg_651_1.callingController_:SetSelectedState("normal")

				local var_654_3 = arg_651_1:GetWordFromCfg(115311158)
				local var_654_4 = arg_651_1:FormatText(var_654_3.content)

				arg_651_1.text_.text = var_654_4

				LuaForUtil.ClearLinePrefixSymbol(arg_651_1.text_)

				local var_654_5 = 55
				local var_654_6 = utf8.len(var_654_4)
				local var_654_7 = var_654_5 <= 0 and var_654_1 or var_654_1 * (var_654_6 / var_654_5)

				if var_654_7 > 0 and var_654_1 < var_654_7 then
					arg_651_1.talkMaxDuration = var_654_7

					if var_654_7 + var_654_0 > arg_651_1.duration_ then
						arg_651_1.duration_ = var_654_7 + var_654_0
					end
				end

				arg_651_1.text_.text = var_654_4
				arg_651_1.typewritter.percent = 0

				arg_651_1.typewritter:SetDirty()
				arg_651_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311158", "story_v_out_115311.awb") ~= 0 then
					local var_654_8 = manager.audio:GetVoiceLength("story_v_out_115311", "115311158", "story_v_out_115311.awb") / 1000

					if var_654_8 + var_654_0 > arg_651_1.duration_ then
						arg_651_1.duration_ = var_654_8 + var_654_0
					end

					if var_654_3.prefab_name ~= "" and arg_651_1.actors_[var_654_3.prefab_name] ~= nil then
						local var_654_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_651_1.actors_[var_654_3.prefab_name].transform, "story_v_out_115311", "115311158", "story_v_out_115311.awb")

						arg_651_1:RecordAudio("115311158", var_654_9)
						arg_651_1:RecordAudio("115311158", var_654_9)
					else
						arg_651_1:AudioAction("play", "voice", "story_v_out_115311", "115311158", "story_v_out_115311.awb")
					end

					arg_651_1:RecordHistoryTalkVoice("story_v_out_115311", "115311158", "story_v_out_115311.awb")
				end

				arg_651_1:RecordContent(arg_651_1.text_.text)
			end

			local var_654_10 = math.max(var_654_1, arg_651_1.talkMaxDuration)

			if var_654_0 <= arg_651_1.time_ and arg_651_1.time_ < var_654_0 + var_654_10 then
				arg_651_1.typewritter.percent = (arg_651_1.time_ - var_654_0) / var_654_10

				arg_651_1.typewritter:SetDirty()
			end

			if arg_651_1.time_ >= var_654_0 + var_654_10 and arg_651_1.time_ < var_654_0 + var_654_10 + arg_654_0 then
				arg_651_1.typewritter.percent = 1

				arg_651_1.typewritter:SetDirty()
				arg_651_1:ShowNextGo(true)
			end
		end

		arg_651_1.nodeConfigList_ = {}

		arg_651_1:InitPlayNodeList()
	end,
	Play115311159 = function(arg_655_0, arg_655_1)
		arg_655_1.time_ = 0
		arg_655_1.frameCnt_ = 0
		arg_655_1.state_ = "playing"
		arg_655_1.curTalkId_ = 115311159
		arg_655_1.duration_ = 10.17

		local var_655_0 = {
			ja = 10.166,
			ko = 7.666,
			zh = 8.333,
			en = 8.633
		}
		local var_655_1 = manager.audio:GetLocalizationFlag()

		if var_655_0[var_655_1] ~= nil then
			arg_655_1.duration_ = var_655_0[var_655_1]
		end

		SetActive(arg_655_1.tipsGo_, false)

		function arg_655_1.onSingleLineFinish_()
			arg_655_1.onSingleLineUpdate_ = nil
			arg_655_1.onSingleLineFinish_ = nil
			arg_655_1.state_ = "waiting"
		end

		function arg_655_1.playNext_(arg_657_0)
			if arg_657_0 == 1 then
				arg_655_0:Play115311160(arg_655_1)
			end
		end

		function arg_655_1.onSingleLineUpdate_(arg_658_0)
			local var_658_0 = arg_655_1.actors_["10030"].transform
			local var_658_1 = 0

			if var_658_1 < arg_655_1.time_ and arg_655_1.time_ <= var_658_1 + arg_658_0 then
				arg_655_1.var_.moveOldPos10030 = var_658_0.localPosition
				var_658_0.localScale = Vector3.New(1, 1, 1)

				arg_655_1:CheckSpriteTmpPos("10030", 4)

				local var_658_2 = var_658_0.childCount

				for iter_658_0 = 0, var_658_2 - 1 do
					local var_658_3 = var_658_0:GetChild(iter_658_0)

					if var_658_3.name == "split_3" or not string.find(var_658_3.name, "split") then
						var_658_3.gameObject:SetActive(true)
					else
						var_658_3.gameObject:SetActive(false)
					end
				end
			end

			local var_658_4 = 0.001

			if var_658_1 <= arg_655_1.time_ and arg_655_1.time_ < var_658_1 + var_658_4 then
				local var_658_5 = (arg_655_1.time_ - var_658_1) / var_658_4
				local var_658_6 = Vector3.New(390, -390, 150)

				var_658_0.localPosition = Vector3.Lerp(arg_655_1.var_.moveOldPos10030, var_658_6, var_658_5)
			end

			if arg_655_1.time_ >= var_658_1 + var_658_4 and arg_655_1.time_ < var_658_1 + var_658_4 + arg_658_0 then
				var_658_0.localPosition = Vector3.New(390, -390, 150)
			end

			local var_658_7 = arg_655_1.actors_["10030"]
			local var_658_8 = 0

			if var_658_8 < arg_655_1.time_ and arg_655_1.time_ <= var_658_8 + arg_658_0 and not isNil(var_658_7) and arg_655_1.var_.actorSpriteComps10030 == nil then
				arg_655_1.var_.actorSpriteComps10030 = var_658_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_658_9 = 0.2

			if var_658_8 <= arg_655_1.time_ and arg_655_1.time_ < var_658_8 + var_658_9 and not isNil(var_658_7) then
				local var_658_10 = (arg_655_1.time_ - var_658_8) / var_658_9

				if arg_655_1.var_.actorSpriteComps10030 then
					for iter_658_1, iter_658_2 in pairs(arg_655_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_658_2 then
							if arg_655_1.isInRecall_ then
								local var_658_11 = Mathf.Lerp(iter_658_2.color.r, arg_655_1.hightColor1.r, var_658_10)
								local var_658_12 = Mathf.Lerp(iter_658_2.color.g, arg_655_1.hightColor1.g, var_658_10)
								local var_658_13 = Mathf.Lerp(iter_658_2.color.b, arg_655_1.hightColor1.b, var_658_10)

								iter_658_2.color = Color.New(var_658_11, var_658_12, var_658_13)
							else
								local var_658_14 = Mathf.Lerp(iter_658_2.color.r, 1, var_658_10)

								iter_658_2.color = Color.New(var_658_14, var_658_14, var_658_14)
							end
						end
					end
				end
			end

			if arg_655_1.time_ >= var_658_8 + var_658_9 and arg_655_1.time_ < var_658_8 + var_658_9 + arg_658_0 and not isNil(var_658_7) and arg_655_1.var_.actorSpriteComps10030 then
				for iter_658_3, iter_658_4 in pairs(arg_655_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_658_4 then
						if arg_655_1.isInRecall_ then
							iter_658_4.color = arg_655_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_658_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_655_1.var_.actorSpriteComps10030 = nil
			end

			local var_658_15 = arg_655_1.actors_["1038"]
			local var_658_16 = 0

			if var_658_16 < arg_655_1.time_ and arg_655_1.time_ <= var_658_16 + arg_658_0 and not isNil(var_658_15) and arg_655_1.var_.actorSpriteComps1038 == nil then
				arg_655_1.var_.actorSpriteComps1038 = var_658_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_658_17 = 0.2

			if var_658_16 <= arg_655_1.time_ and arg_655_1.time_ < var_658_16 + var_658_17 and not isNil(var_658_15) then
				local var_658_18 = (arg_655_1.time_ - var_658_16) / var_658_17

				if arg_655_1.var_.actorSpriteComps1038 then
					for iter_658_5, iter_658_6 in pairs(arg_655_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_658_6 then
							if arg_655_1.isInRecall_ then
								local var_658_19 = Mathf.Lerp(iter_658_6.color.r, arg_655_1.hightColor2.r, var_658_18)
								local var_658_20 = Mathf.Lerp(iter_658_6.color.g, arg_655_1.hightColor2.g, var_658_18)
								local var_658_21 = Mathf.Lerp(iter_658_6.color.b, arg_655_1.hightColor2.b, var_658_18)

								iter_658_6.color = Color.New(var_658_19, var_658_20, var_658_21)
							else
								local var_658_22 = Mathf.Lerp(iter_658_6.color.r, 0.5, var_658_18)

								iter_658_6.color = Color.New(var_658_22, var_658_22, var_658_22)
							end
						end
					end
				end
			end

			if arg_655_1.time_ >= var_658_16 + var_658_17 and arg_655_1.time_ < var_658_16 + var_658_17 + arg_658_0 and not isNil(var_658_15) and arg_655_1.var_.actorSpriteComps1038 then
				for iter_658_7, iter_658_8 in pairs(arg_655_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_658_8 then
						if arg_655_1.isInRecall_ then
							iter_658_8.color = arg_655_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_658_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_655_1.var_.actorSpriteComps1038 = nil
			end

			local var_658_23 = arg_655_1.actors_["10030"]
			local var_658_24 = 0

			if var_658_24 < arg_655_1.time_ and arg_655_1.time_ <= var_658_24 + arg_658_0 then
				local var_658_25 = var_658_23:GetComponentInChildren(typeof(CanvasGroup))

				if var_658_25 then
					arg_655_1.var_.alphaOldValue10030 = var_658_25.alpha
					arg_655_1.var_.characterEffect10030 = var_658_25
				end

				arg_655_1.var_.alphaOldValue10030 = 0
			end

			local var_658_26 = 0.0166666666666667

			if var_658_24 <= arg_655_1.time_ and arg_655_1.time_ < var_658_24 + var_658_26 then
				local var_658_27 = (arg_655_1.time_ - var_658_24) / var_658_26
				local var_658_28 = Mathf.Lerp(arg_655_1.var_.alphaOldValue10030, 1, var_658_27)

				if arg_655_1.var_.characterEffect10030 then
					arg_655_1.var_.characterEffect10030.alpha = var_658_28
				end
			end

			if arg_655_1.time_ >= var_658_24 + var_658_26 and arg_655_1.time_ < var_658_24 + var_658_26 + arg_658_0 and arg_655_1.var_.characterEffect10030 then
				arg_655_1.var_.characterEffect10030.alpha = 1
			end

			local var_658_29 = 0
			local var_658_30 = 0.875

			if var_658_29 < arg_655_1.time_ and arg_655_1.time_ <= var_658_29 + arg_658_0 then
				arg_655_1.talkMaxDuration = 0
				arg_655_1.dialogCg_.alpha = 1

				arg_655_1.dialog_:SetActive(true)
				SetActive(arg_655_1.leftNameGo_, true)

				local var_658_31 = arg_655_1:FormatText(StoryNameCfg[309].name)

				arg_655_1.leftNameTxt_.text = var_658_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_655_1.leftNameTxt_.transform)

				arg_655_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_655_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_655_1:RecordName(arg_655_1.leftNameTxt_.text)
				SetActive(arg_655_1.iconTrs_.gameObject, false)
				arg_655_1.callingController_:SetSelectedState("normal")

				local var_658_32 = arg_655_1:GetWordFromCfg(115311159)
				local var_658_33 = arg_655_1:FormatText(var_658_32.content)

				arg_655_1.text_.text = var_658_33

				LuaForUtil.ClearLinePrefixSymbol(arg_655_1.text_)

				local var_658_34 = 35
				local var_658_35 = utf8.len(var_658_33)
				local var_658_36 = var_658_34 <= 0 and var_658_30 or var_658_30 * (var_658_35 / var_658_34)

				if var_658_36 > 0 and var_658_30 < var_658_36 then
					arg_655_1.talkMaxDuration = var_658_36

					if var_658_36 + var_658_29 > arg_655_1.duration_ then
						arg_655_1.duration_ = var_658_36 + var_658_29
					end
				end

				arg_655_1.text_.text = var_658_33
				arg_655_1.typewritter.percent = 0

				arg_655_1.typewritter:SetDirty()
				arg_655_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311159", "story_v_out_115311.awb") ~= 0 then
					local var_658_37 = manager.audio:GetVoiceLength("story_v_out_115311", "115311159", "story_v_out_115311.awb") / 1000

					if var_658_37 + var_658_29 > arg_655_1.duration_ then
						arg_655_1.duration_ = var_658_37 + var_658_29
					end

					if var_658_32.prefab_name ~= "" and arg_655_1.actors_[var_658_32.prefab_name] ~= nil then
						local var_658_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_655_1.actors_[var_658_32.prefab_name].transform, "story_v_out_115311", "115311159", "story_v_out_115311.awb")

						arg_655_1:RecordAudio("115311159", var_658_38)
						arg_655_1:RecordAudio("115311159", var_658_38)
					else
						arg_655_1:AudioAction("play", "voice", "story_v_out_115311", "115311159", "story_v_out_115311.awb")
					end

					arg_655_1:RecordHistoryTalkVoice("story_v_out_115311", "115311159", "story_v_out_115311.awb")
				end

				arg_655_1:RecordContent(arg_655_1.text_.text)
			end

			local var_658_39 = math.max(var_658_30, arg_655_1.talkMaxDuration)

			if var_658_29 <= arg_655_1.time_ and arg_655_1.time_ < var_658_29 + var_658_39 then
				arg_655_1.typewritter.percent = (arg_655_1.time_ - var_658_29) / var_658_39

				arg_655_1.typewritter:SetDirty()
			end

			if arg_655_1.time_ >= var_658_29 + var_658_39 and arg_655_1.time_ < var_658_29 + var_658_39 + arg_658_0 then
				arg_655_1.typewritter.percent = 1

				arg_655_1.typewritter:SetDirty()
				arg_655_1:ShowNextGo(true)
			end
		end

		arg_655_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10030",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_655_1:InitPlayNodeList()
	end,
	Play115311160 = function(arg_659_0, arg_659_1)
		arg_659_1.time_ = 0
		arg_659_1.frameCnt_ = 0
		arg_659_1.state_ = "playing"
		arg_659_1.curTalkId_ = 115311160
		arg_659_1.duration_ = 7.2

		local var_659_0 = {
			ja = 7.2,
			ko = 4.9,
			zh = 4.533,
			en = 6.3
		}
		local var_659_1 = manager.audio:GetLocalizationFlag()

		if var_659_0[var_659_1] ~= nil then
			arg_659_1.duration_ = var_659_0[var_659_1]
		end

		SetActive(arg_659_1.tipsGo_, false)

		function arg_659_1.onSingleLineFinish_()
			arg_659_1.onSingleLineUpdate_ = nil
			arg_659_1.onSingleLineFinish_ = nil
			arg_659_1.state_ = "waiting"
		end

		function arg_659_1.playNext_(arg_661_0)
			if arg_661_0 == 1 then
				arg_659_0:Play115311161(arg_659_1)
			end
		end

		function arg_659_1.onSingleLineUpdate_(arg_662_0)
			local var_662_0 = arg_659_1.actors_["10030"]
			local var_662_1 = 0

			if var_662_1 < arg_659_1.time_ and arg_659_1.time_ <= var_662_1 + arg_662_0 and not isNil(var_662_0) and arg_659_1.var_.actorSpriteComps10030 == nil then
				arg_659_1.var_.actorSpriteComps10030 = var_662_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_662_2 = 0.2

			if var_662_1 <= arg_659_1.time_ and arg_659_1.time_ < var_662_1 + var_662_2 and not isNil(var_662_0) then
				local var_662_3 = (arg_659_1.time_ - var_662_1) / var_662_2

				if arg_659_1.var_.actorSpriteComps10030 then
					for iter_662_0, iter_662_1 in pairs(arg_659_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_662_1 then
							if arg_659_1.isInRecall_ then
								local var_662_4 = Mathf.Lerp(iter_662_1.color.r, arg_659_1.hightColor2.r, var_662_3)
								local var_662_5 = Mathf.Lerp(iter_662_1.color.g, arg_659_1.hightColor2.g, var_662_3)
								local var_662_6 = Mathf.Lerp(iter_662_1.color.b, arg_659_1.hightColor2.b, var_662_3)

								iter_662_1.color = Color.New(var_662_4, var_662_5, var_662_6)
							else
								local var_662_7 = Mathf.Lerp(iter_662_1.color.r, 0.5, var_662_3)

								iter_662_1.color = Color.New(var_662_7, var_662_7, var_662_7)
							end
						end
					end
				end
			end

			if arg_659_1.time_ >= var_662_1 + var_662_2 and arg_659_1.time_ < var_662_1 + var_662_2 + arg_662_0 and not isNil(var_662_0) and arg_659_1.var_.actorSpriteComps10030 then
				for iter_662_2, iter_662_3 in pairs(arg_659_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_662_3 then
						if arg_659_1.isInRecall_ then
							iter_662_3.color = arg_659_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_662_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_659_1.var_.actorSpriteComps10030 = nil
			end

			local var_662_8 = arg_659_1.actors_["1038"]
			local var_662_9 = 0

			if var_662_9 < arg_659_1.time_ and arg_659_1.time_ <= var_662_9 + arg_662_0 and not isNil(var_662_8) and arg_659_1.var_.actorSpriteComps1038 == nil then
				arg_659_1.var_.actorSpriteComps1038 = var_662_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_662_10 = 0.2

			if var_662_9 <= arg_659_1.time_ and arg_659_1.time_ < var_662_9 + var_662_10 and not isNil(var_662_8) then
				local var_662_11 = (arg_659_1.time_ - var_662_9) / var_662_10

				if arg_659_1.var_.actorSpriteComps1038 then
					for iter_662_4, iter_662_5 in pairs(arg_659_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_662_5 then
							if arg_659_1.isInRecall_ then
								local var_662_12 = Mathf.Lerp(iter_662_5.color.r, arg_659_1.hightColor1.r, var_662_11)
								local var_662_13 = Mathf.Lerp(iter_662_5.color.g, arg_659_1.hightColor1.g, var_662_11)
								local var_662_14 = Mathf.Lerp(iter_662_5.color.b, arg_659_1.hightColor1.b, var_662_11)

								iter_662_5.color = Color.New(var_662_12, var_662_13, var_662_14)
							else
								local var_662_15 = Mathf.Lerp(iter_662_5.color.r, 1, var_662_11)

								iter_662_5.color = Color.New(var_662_15, var_662_15, var_662_15)
							end
						end
					end
				end
			end

			if arg_659_1.time_ >= var_662_9 + var_662_10 and arg_659_1.time_ < var_662_9 + var_662_10 + arg_662_0 and not isNil(var_662_8) and arg_659_1.var_.actorSpriteComps1038 then
				for iter_662_6, iter_662_7 in pairs(arg_659_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_662_7 then
						if arg_659_1.isInRecall_ then
							iter_662_7.color = arg_659_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_662_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_659_1.var_.actorSpriteComps1038 = nil
			end

			local var_662_16 = 0
			local var_662_17 = 0.4

			if var_662_16 < arg_659_1.time_ and arg_659_1.time_ <= var_662_16 + arg_662_0 then
				arg_659_1.talkMaxDuration = 0
				arg_659_1.dialogCg_.alpha = 1

				arg_659_1.dialog_:SetActive(true)
				SetActive(arg_659_1.leftNameGo_, true)

				local var_662_18 = arg_659_1:FormatText(StoryNameCfg[94].name)

				arg_659_1.leftNameTxt_.text = var_662_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_659_1.leftNameTxt_.transform)

				arg_659_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_659_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_659_1:RecordName(arg_659_1.leftNameTxt_.text)
				SetActive(arg_659_1.iconTrs_.gameObject, false)
				arg_659_1.callingController_:SetSelectedState("normal")

				local var_662_19 = arg_659_1:GetWordFromCfg(115311160)
				local var_662_20 = arg_659_1:FormatText(var_662_19.content)

				arg_659_1.text_.text = var_662_20

				LuaForUtil.ClearLinePrefixSymbol(arg_659_1.text_)

				local var_662_21 = 16
				local var_662_22 = utf8.len(var_662_20)
				local var_662_23 = var_662_21 <= 0 and var_662_17 or var_662_17 * (var_662_22 / var_662_21)

				if var_662_23 > 0 and var_662_17 < var_662_23 then
					arg_659_1.talkMaxDuration = var_662_23

					if var_662_23 + var_662_16 > arg_659_1.duration_ then
						arg_659_1.duration_ = var_662_23 + var_662_16
					end
				end

				arg_659_1.text_.text = var_662_20
				arg_659_1.typewritter.percent = 0

				arg_659_1.typewritter:SetDirty()
				arg_659_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311160", "story_v_out_115311.awb") ~= 0 then
					local var_662_24 = manager.audio:GetVoiceLength("story_v_out_115311", "115311160", "story_v_out_115311.awb") / 1000

					if var_662_24 + var_662_16 > arg_659_1.duration_ then
						arg_659_1.duration_ = var_662_24 + var_662_16
					end

					if var_662_19.prefab_name ~= "" and arg_659_1.actors_[var_662_19.prefab_name] ~= nil then
						local var_662_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_659_1.actors_[var_662_19.prefab_name].transform, "story_v_out_115311", "115311160", "story_v_out_115311.awb")

						arg_659_1:RecordAudio("115311160", var_662_25)
						arg_659_1:RecordAudio("115311160", var_662_25)
					else
						arg_659_1:AudioAction("play", "voice", "story_v_out_115311", "115311160", "story_v_out_115311.awb")
					end

					arg_659_1:RecordHistoryTalkVoice("story_v_out_115311", "115311160", "story_v_out_115311.awb")
				end

				arg_659_1:RecordContent(arg_659_1.text_.text)
			end

			local var_662_26 = math.max(var_662_17, arg_659_1.talkMaxDuration)

			if var_662_16 <= arg_659_1.time_ and arg_659_1.time_ < var_662_16 + var_662_26 then
				arg_659_1.typewritter.percent = (arg_659_1.time_ - var_662_16) / var_662_26

				arg_659_1.typewritter:SetDirty()
			end

			if arg_659_1.time_ >= var_662_16 + var_662_26 and arg_659_1.time_ < var_662_16 + var_662_26 + arg_662_0 then
				arg_659_1.typewritter.percent = 1

				arg_659_1.typewritter:SetDirty()
				arg_659_1:ShowNextGo(true)
			end
		end

		arg_659_1.nodeConfigList_ = {}

		arg_659_1:InitPlayNodeList()
	end,
	Play115311161 = function(arg_663_0, arg_663_1)
		arg_663_1.time_ = 0
		arg_663_1.frameCnt_ = 0
		arg_663_1.state_ = "playing"
		arg_663_1.curTalkId_ = 115311161
		arg_663_1.duration_ = 7.77

		local var_663_0 = {
			ja = 7.766,
			ko = 3.9,
			zh = 4.733,
			en = 4.6
		}
		local var_663_1 = manager.audio:GetLocalizationFlag()

		if var_663_0[var_663_1] ~= nil then
			arg_663_1.duration_ = var_663_0[var_663_1]
		end

		SetActive(arg_663_1.tipsGo_, false)

		function arg_663_1.onSingleLineFinish_()
			arg_663_1.onSingleLineUpdate_ = nil
			arg_663_1.onSingleLineFinish_ = nil
			arg_663_1.state_ = "waiting"
		end

		function arg_663_1.playNext_(arg_665_0)
			if arg_665_0 == 1 then
				arg_663_0:Play115311162(arg_663_1)
			end
		end

		function arg_663_1.onSingleLineUpdate_(arg_666_0)
			local var_666_0 = arg_663_1.actors_["1038"]
			local var_666_1 = 0

			if var_666_1 < arg_663_1.time_ and arg_663_1.time_ <= var_666_1 + arg_666_0 and not isNil(var_666_0) and arg_663_1.var_.actorSpriteComps1038 == nil then
				arg_663_1.var_.actorSpriteComps1038 = var_666_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_666_2 = 0.2

			if var_666_1 <= arg_663_1.time_ and arg_663_1.time_ < var_666_1 + var_666_2 and not isNil(var_666_0) then
				local var_666_3 = (arg_663_1.time_ - var_666_1) / var_666_2

				if arg_663_1.var_.actorSpriteComps1038 then
					for iter_666_0, iter_666_1 in pairs(arg_663_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_666_1 then
							if arg_663_1.isInRecall_ then
								local var_666_4 = Mathf.Lerp(iter_666_1.color.r, arg_663_1.hightColor2.r, var_666_3)
								local var_666_5 = Mathf.Lerp(iter_666_1.color.g, arg_663_1.hightColor2.g, var_666_3)
								local var_666_6 = Mathf.Lerp(iter_666_1.color.b, arg_663_1.hightColor2.b, var_666_3)

								iter_666_1.color = Color.New(var_666_4, var_666_5, var_666_6)
							else
								local var_666_7 = Mathf.Lerp(iter_666_1.color.r, 0.5, var_666_3)

								iter_666_1.color = Color.New(var_666_7, var_666_7, var_666_7)
							end
						end
					end
				end
			end

			if arg_663_1.time_ >= var_666_1 + var_666_2 and arg_663_1.time_ < var_666_1 + var_666_2 + arg_666_0 and not isNil(var_666_0) and arg_663_1.var_.actorSpriteComps1038 then
				for iter_666_2, iter_666_3 in pairs(arg_663_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_666_3 then
						if arg_663_1.isInRecall_ then
							iter_666_3.color = arg_663_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_666_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_663_1.var_.actorSpriteComps1038 = nil
			end

			local var_666_8 = arg_663_1.actors_["10030"]
			local var_666_9 = 0

			if var_666_9 < arg_663_1.time_ and arg_663_1.time_ <= var_666_9 + arg_666_0 and not isNil(var_666_8) and arg_663_1.var_.actorSpriteComps10030 == nil then
				arg_663_1.var_.actorSpriteComps10030 = var_666_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_666_10 = 0.2

			if var_666_9 <= arg_663_1.time_ and arg_663_1.time_ < var_666_9 + var_666_10 and not isNil(var_666_8) then
				local var_666_11 = (arg_663_1.time_ - var_666_9) / var_666_10

				if arg_663_1.var_.actorSpriteComps10030 then
					for iter_666_4, iter_666_5 in pairs(arg_663_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_666_5 then
							if arg_663_1.isInRecall_ then
								local var_666_12 = Mathf.Lerp(iter_666_5.color.r, arg_663_1.hightColor1.r, var_666_11)
								local var_666_13 = Mathf.Lerp(iter_666_5.color.g, arg_663_1.hightColor1.g, var_666_11)
								local var_666_14 = Mathf.Lerp(iter_666_5.color.b, arg_663_1.hightColor1.b, var_666_11)

								iter_666_5.color = Color.New(var_666_12, var_666_13, var_666_14)
							else
								local var_666_15 = Mathf.Lerp(iter_666_5.color.r, 1, var_666_11)

								iter_666_5.color = Color.New(var_666_15, var_666_15, var_666_15)
							end
						end
					end
				end
			end

			if arg_663_1.time_ >= var_666_9 + var_666_10 and arg_663_1.time_ < var_666_9 + var_666_10 + arg_666_0 and not isNil(var_666_8) and arg_663_1.var_.actorSpriteComps10030 then
				for iter_666_6, iter_666_7 in pairs(arg_663_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_666_7 then
						if arg_663_1.isInRecall_ then
							iter_666_7.color = arg_663_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_666_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_663_1.var_.actorSpriteComps10030 = nil
			end

			local var_666_16 = 0
			local var_666_17 = 0.425

			if var_666_16 < arg_663_1.time_ and arg_663_1.time_ <= var_666_16 + arg_666_0 then
				arg_663_1.talkMaxDuration = 0
				arg_663_1.dialogCg_.alpha = 1

				arg_663_1.dialog_:SetActive(true)
				SetActive(arg_663_1.leftNameGo_, true)

				local var_666_18 = arg_663_1:FormatText(StoryNameCfg[309].name)

				arg_663_1.leftNameTxt_.text = var_666_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_663_1.leftNameTxt_.transform)

				arg_663_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_663_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_663_1:RecordName(arg_663_1.leftNameTxt_.text)
				SetActive(arg_663_1.iconTrs_.gameObject, false)
				arg_663_1.callingController_:SetSelectedState("normal")

				local var_666_19 = arg_663_1:GetWordFromCfg(115311161)
				local var_666_20 = arg_663_1:FormatText(var_666_19.content)

				arg_663_1.text_.text = var_666_20

				LuaForUtil.ClearLinePrefixSymbol(arg_663_1.text_)

				local var_666_21 = 17
				local var_666_22 = utf8.len(var_666_20)
				local var_666_23 = var_666_21 <= 0 and var_666_17 or var_666_17 * (var_666_22 / var_666_21)

				if var_666_23 > 0 and var_666_17 < var_666_23 then
					arg_663_1.talkMaxDuration = var_666_23

					if var_666_23 + var_666_16 > arg_663_1.duration_ then
						arg_663_1.duration_ = var_666_23 + var_666_16
					end
				end

				arg_663_1.text_.text = var_666_20
				arg_663_1.typewritter.percent = 0

				arg_663_1.typewritter:SetDirty()
				arg_663_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311161", "story_v_out_115311.awb") ~= 0 then
					local var_666_24 = manager.audio:GetVoiceLength("story_v_out_115311", "115311161", "story_v_out_115311.awb") / 1000

					if var_666_24 + var_666_16 > arg_663_1.duration_ then
						arg_663_1.duration_ = var_666_24 + var_666_16
					end

					if var_666_19.prefab_name ~= "" and arg_663_1.actors_[var_666_19.prefab_name] ~= nil then
						local var_666_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_663_1.actors_[var_666_19.prefab_name].transform, "story_v_out_115311", "115311161", "story_v_out_115311.awb")

						arg_663_1:RecordAudio("115311161", var_666_25)
						arg_663_1:RecordAudio("115311161", var_666_25)
					else
						arg_663_1:AudioAction("play", "voice", "story_v_out_115311", "115311161", "story_v_out_115311.awb")
					end

					arg_663_1:RecordHistoryTalkVoice("story_v_out_115311", "115311161", "story_v_out_115311.awb")
				end

				arg_663_1:RecordContent(arg_663_1.text_.text)
			end

			local var_666_26 = math.max(var_666_17, arg_663_1.talkMaxDuration)

			if var_666_16 <= arg_663_1.time_ and arg_663_1.time_ < var_666_16 + var_666_26 then
				arg_663_1.typewritter.percent = (arg_663_1.time_ - var_666_16) / var_666_26

				arg_663_1.typewritter:SetDirty()
			end

			if arg_663_1.time_ >= var_666_16 + var_666_26 and arg_663_1.time_ < var_666_16 + var_666_26 + arg_666_0 then
				arg_663_1.typewritter.percent = 1

				arg_663_1.typewritter:SetDirty()
				arg_663_1:ShowNextGo(true)
			end
		end

		arg_663_1.nodeConfigList_ = {}

		arg_663_1:InitPlayNodeList()
	end,
	Play115311162 = function(arg_667_0, arg_667_1)
		arg_667_1.time_ = 0
		arg_667_1.frameCnt_ = 0
		arg_667_1.state_ = "playing"
		arg_667_1.curTalkId_ = 115311162
		arg_667_1.duration_ = 9.83

		local var_667_0 = {
			ja = 9.833,
			ko = 5.9,
			zh = 5.1,
			en = 6.666
		}
		local var_667_1 = manager.audio:GetLocalizationFlag()

		if var_667_0[var_667_1] ~= nil then
			arg_667_1.duration_ = var_667_0[var_667_1]
		end

		SetActive(arg_667_1.tipsGo_, false)

		function arg_667_1.onSingleLineFinish_()
			arg_667_1.onSingleLineUpdate_ = nil
			arg_667_1.onSingleLineFinish_ = nil
			arg_667_1.state_ = "waiting"
		end

		function arg_667_1.playNext_(arg_669_0)
			if arg_669_0 == 1 then
				arg_667_0:Play115311163(arg_667_1)
			end
		end

		function arg_667_1.onSingleLineUpdate_(arg_670_0)
			local var_670_0 = 0
			local var_670_1 = 0.65

			if var_670_0 < arg_667_1.time_ and arg_667_1.time_ <= var_670_0 + arg_670_0 then
				arg_667_1.talkMaxDuration = 0
				arg_667_1.dialogCg_.alpha = 1

				arg_667_1.dialog_:SetActive(true)
				SetActive(arg_667_1.leftNameGo_, true)

				local var_670_2 = arg_667_1:FormatText(StoryNameCfg[309].name)

				arg_667_1.leftNameTxt_.text = var_670_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_667_1.leftNameTxt_.transform)

				arg_667_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_667_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_667_1:RecordName(arg_667_1.leftNameTxt_.text)
				SetActive(arg_667_1.iconTrs_.gameObject, false)
				arg_667_1.callingController_:SetSelectedState("normal")

				local var_670_3 = arg_667_1:GetWordFromCfg(115311162)
				local var_670_4 = arg_667_1:FormatText(var_670_3.content)

				arg_667_1.text_.text = var_670_4

				LuaForUtil.ClearLinePrefixSymbol(arg_667_1.text_)

				local var_670_5 = 26
				local var_670_6 = utf8.len(var_670_4)
				local var_670_7 = var_670_5 <= 0 and var_670_1 or var_670_1 * (var_670_6 / var_670_5)

				if var_670_7 > 0 and var_670_1 < var_670_7 then
					arg_667_1.talkMaxDuration = var_670_7

					if var_670_7 + var_670_0 > arg_667_1.duration_ then
						arg_667_1.duration_ = var_670_7 + var_670_0
					end
				end

				arg_667_1.text_.text = var_670_4
				arg_667_1.typewritter.percent = 0

				arg_667_1.typewritter:SetDirty()
				arg_667_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311162", "story_v_out_115311.awb") ~= 0 then
					local var_670_8 = manager.audio:GetVoiceLength("story_v_out_115311", "115311162", "story_v_out_115311.awb") / 1000

					if var_670_8 + var_670_0 > arg_667_1.duration_ then
						arg_667_1.duration_ = var_670_8 + var_670_0
					end

					if var_670_3.prefab_name ~= "" and arg_667_1.actors_[var_670_3.prefab_name] ~= nil then
						local var_670_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_667_1.actors_[var_670_3.prefab_name].transform, "story_v_out_115311", "115311162", "story_v_out_115311.awb")

						arg_667_1:RecordAudio("115311162", var_670_9)
						arg_667_1:RecordAudio("115311162", var_670_9)
					else
						arg_667_1:AudioAction("play", "voice", "story_v_out_115311", "115311162", "story_v_out_115311.awb")
					end

					arg_667_1:RecordHistoryTalkVoice("story_v_out_115311", "115311162", "story_v_out_115311.awb")
				end

				arg_667_1:RecordContent(arg_667_1.text_.text)
			end

			local var_670_10 = math.max(var_670_1, arg_667_1.talkMaxDuration)

			if var_670_0 <= arg_667_1.time_ and arg_667_1.time_ < var_670_0 + var_670_10 then
				arg_667_1.typewritter.percent = (arg_667_1.time_ - var_670_0) / var_670_10

				arg_667_1.typewritter:SetDirty()
			end

			if arg_667_1.time_ >= var_670_0 + var_670_10 and arg_667_1.time_ < var_670_0 + var_670_10 + arg_670_0 then
				arg_667_1.typewritter.percent = 1

				arg_667_1.typewritter:SetDirty()
				arg_667_1:ShowNextGo(true)
			end
		end

		arg_667_1.nodeConfigList_ = {}

		arg_667_1:InitPlayNodeList()
	end,
	Play115311163 = function(arg_671_0, arg_671_1)
		arg_671_1.time_ = 0
		arg_671_1.frameCnt_ = 0
		arg_671_1.state_ = "playing"
		arg_671_1.curTalkId_ = 115311163
		arg_671_1.duration_ = 11.4

		local var_671_0 = {
			ja = 11.4,
			ko = 7.266,
			zh = 7.4,
			en = 7.1
		}
		local var_671_1 = manager.audio:GetLocalizationFlag()

		if var_671_0[var_671_1] ~= nil then
			arg_671_1.duration_ = var_671_0[var_671_1]
		end

		SetActive(arg_671_1.tipsGo_, false)

		function arg_671_1.onSingleLineFinish_()
			arg_671_1.onSingleLineUpdate_ = nil
			arg_671_1.onSingleLineFinish_ = nil
			arg_671_1.state_ = "waiting"
		end

		function arg_671_1.playNext_(arg_673_0)
			if arg_673_0 == 1 then
				arg_671_0:Play115311164(arg_671_1)
			end
		end

		function arg_671_1.onSingleLineUpdate_(arg_674_0)
			local var_674_0 = arg_671_1.actors_["1038"]
			local var_674_1 = 0

			if var_674_1 < arg_671_1.time_ and arg_671_1.time_ <= var_674_1 + arg_674_0 and not isNil(var_674_0) and arg_671_1.var_.actorSpriteComps1038 == nil then
				arg_671_1.var_.actorSpriteComps1038 = var_674_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_674_2 = 0.2

			if var_674_1 <= arg_671_1.time_ and arg_671_1.time_ < var_674_1 + var_674_2 and not isNil(var_674_0) then
				local var_674_3 = (arg_671_1.time_ - var_674_1) / var_674_2

				if arg_671_1.var_.actorSpriteComps1038 then
					for iter_674_0, iter_674_1 in pairs(arg_671_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_674_1 then
							if arg_671_1.isInRecall_ then
								local var_674_4 = Mathf.Lerp(iter_674_1.color.r, arg_671_1.hightColor1.r, var_674_3)
								local var_674_5 = Mathf.Lerp(iter_674_1.color.g, arg_671_1.hightColor1.g, var_674_3)
								local var_674_6 = Mathf.Lerp(iter_674_1.color.b, arg_671_1.hightColor1.b, var_674_3)

								iter_674_1.color = Color.New(var_674_4, var_674_5, var_674_6)
							else
								local var_674_7 = Mathf.Lerp(iter_674_1.color.r, 1, var_674_3)

								iter_674_1.color = Color.New(var_674_7, var_674_7, var_674_7)
							end
						end
					end
				end
			end

			if arg_671_1.time_ >= var_674_1 + var_674_2 and arg_671_1.time_ < var_674_1 + var_674_2 + arg_674_0 and not isNil(var_674_0) and arg_671_1.var_.actorSpriteComps1038 then
				for iter_674_2, iter_674_3 in pairs(arg_671_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_674_3 then
						if arg_671_1.isInRecall_ then
							iter_674_3.color = arg_671_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_674_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_671_1.var_.actorSpriteComps1038 = nil
			end

			local var_674_8 = arg_671_1.actors_["10030"]
			local var_674_9 = 0

			if var_674_9 < arg_671_1.time_ and arg_671_1.time_ <= var_674_9 + arg_674_0 and not isNil(var_674_8) and arg_671_1.var_.actorSpriteComps10030 == nil then
				arg_671_1.var_.actorSpriteComps10030 = var_674_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_674_10 = 0.2

			if var_674_9 <= arg_671_1.time_ and arg_671_1.time_ < var_674_9 + var_674_10 and not isNil(var_674_8) then
				local var_674_11 = (arg_671_1.time_ - var_674_9) / var_674_10

				if arg_671_1.var_.actorSpriteComps10030 then
					for iter_674_4, iter_674_5 in pairs(arg_671_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_674_5 then
							if arg_671_1.isInRecall_ then
								local var_674_12 = Mathf.Lerp(iter_674_5.color.r, arg_671_1.hightColor2.r, var_674_11)
								local var_674_13 = Mathf.Lerp(iter_674_5.color.g, arg_671_1.hightColor2.g, var_674_11)
								local var_674_14 = Mathf.Lerp(iter_674_5.color.b, arg_671_1.hightColor2.b, var_674_11)

								iter_674_5.color = Color.New(var_674_12, var_674_13, var_674_14)
							else
								local var_674_15 = Mathf.Lerp(iter_674_5.color.r, 0.5, var_674_11)

								iter_674_5.color = Color.New(var_674_15, var_674_15, var_674_15)
							end
						end
					end
				end
			end

			if arg_671_1.time_ >= var_674_9 + var_674_10 and arg_671_1.time_ < var_674_9 + var_674_10 + arg_674_0 and not isNil(var_674_8) and arg_671_1.var_.actorSpriteComps10030 then
				for iter_674_6, iter_674_7 in pairs(arg_671_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_674_7 then
						if arg_671_1.isInRecall_ then
							iter_674_7.color = arg_671_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_674_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_671_1.var_.actorSpriteComps10030 = nil
			end

			local var_674_16 = 0
			local var_674_17 = 0.775

			if var_674_16 < arg_671_1.time_ and arg_671_1.time_ <= var_674_16 + arg_674_0 then
				arg_671_1.talkMaxDuration = 0
				arg_671_1.dialogCg_.alpha = 1

				arg_671_1.dialog_:SetActive(true)
				SetActive(arg_671_1.leftNameGo_, true)

				local var_674_18 = arg_671_1:FormatText(StoryNameCfg[94].name)

				arg_671_1.leftNameTxt_.text = var_674_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_671_1.leftNameTxt_.transform)

				arg_671_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_671_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_671_1:RecordName(arg_671_1.leftNameTxt_.text)
				SetActive(arg_671_1.iconTrs_.gameObject, false)
				arg_671_1.callingController_:SetSelectedState("normal")

				local var_674_19 = arg_671_1:GetWordFromCfg(115311163)
				local var_674_20 = arg_671_1:FormatText(var_674_19.content)

				arg_671_1.text_.text = var_674_20

				LuaForUtil.ClearLinePrefixSymbol(arg_671_1.text_)

				local var_674_21 = 31
				local var_674_22 = utf8.len(var_674_20)
				local var_674_23 = var_674_21 <= 0 and var_674_17 or var_674_17 * (var_674_22 / var_674_21)

				if var_674_23 > 0 and var_674_17 < var_674_23 then
					arg_671_1.talkMaxDuration = var_674_23

					if var_674_23 + var_674_16 > arg_671_1.duration_ then
						arg_671_1.duration_ = var_674_23 + var_674_16
					end
				end

				arg_671_1.text_.text = var_674_20
				arg_671_1.typewritter.percent = 0

				arg_671_1.typewritter:SetDirty()
				arg_671_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311163", "story_v_out_115311.awb") ~= 0 then
					local var_674_24 = manager.audio:GetVoiceLength("story_v_out_115311", "115311163", "story_v_out_115311.awb") / 1000

					if var_674_24 + var_674_16 > arg_671_1.duration_ then
						arg_671_1.duration_ = var_674_24 + var_674_16
					end

					if var_674_19.prefab_name ~= "" and arg_671_1.actors_[var_674_19.prefab_name] ~= nil then
						local var_674_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_671_1.actors_[var_674_19.prefab_name].transform, "story_v_out_115311", "115311163", "story_v_out_115311.awb")

						arg_671_1:RecordAudio("115311163", var_674_25)
						arg_671_1:RecordAudio("115311163", var_674_25)
					else
						arg_671_1:AudioAction("play", "voice", "story_v_out_115311", "115311163", "story_v_out_115311.awb")
					end

					arg_671_1:RecordHistoryTalkVoice("story_v_out_115311", "115311163", "story_v_out_115311.awb")
				end

				arg_671_1:RecordContent(arg_671_1.text_.text)
			end

			local var_674_26 = math.max(var_674_17, arg_671_1.talkMaxDuration)

			if var_674_16 <= arg_671_1.time_ and arg_671_1.time_ < var_674_16 + var_674_26 then
				arg_671_1.typewritter.percent = (arg_671_1.time_ - var_674_16) / var_674_26

				arg_671_1.typewritter:SetDirty()
			end

			if arg_671_1.time_ >= var_674_16 + var_674_26 and arg_671_1.time_ < var_674_16 + var_674_26 + arg_674_0 then
				arg_671_1.typewritter.percent = 1

				arg_671_1.typewritter:SetDirty()
				arg_671_1:ShowNextGo(true)
			end
		end

		arg_671_1.nodeConfigList_ = {}

		arg_671_1:InitPlayNodeList()
	end,
	Play115311164 = function(arg_675_0, arg_675_1)
		arg_675_1.time_ = 0
		arg_675_1.frameCnt_ = 0
		arg_675_1.state_ = "playing"
		arg_675_1.curTalkId_ = 115311164
		arg_675_1.duration_ = 17.7

		local var_675_0 = {
			ja = 10.666,
			ko = 16.4,
			zh = 17.3,
			en = 17.7
		}
		local var_675_1 = manager.audio:GetLocalizationFlag()

		if var_675_0[var_675_1] ~= nil then
			arg_675_1.duration_ = var_675_0[var_675_1]
		end

		SetActive(arg_675_1.tipsGo_, false)

		function arg_675_1.onSingleLineFinish_()
			arg_675_1.onSingleLineUpdate_ = nil
			arg_675_1.onSingleLineFinish_ = nil
			arg_675_1.state_ = "waiting"
		end

		function arg_675_1.playNext_(arg_677_0)
			if arg_677_0 == 1 then
				arg_675_0:Play115311165(arg_675_1)
			end
		end

		function arg_675_1.onSingleLineUpdate_(arg_678_0)
			local var_678_0 = 0
			local var_678_1 = 1.475

			if var_678_0 < arg_675_1.time_ and arg_675_1.time_ <= var_678_0 + arg_678_0 then
				arg_675_1.talkMaxDuration = 0
				arg_675_1.dialogCg_.alpha = 1

				arg_675_1.dialog_:SetActive(true)
				SetActive(arg_675_1.leftNameGo_, true)

				local var_678_2 = arg_675_1:FormatText(StoryNameCfg[94].name)

				arg_675_1.leftNameTxt_.text = var_678_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_675_1.leftNameTxt_.transform)

				arg_675_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_675_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_675_1:RecordName(arg_675_1.leftNameTxt_.text)
				SetActive(arg_675_1.iconTrs_.gameObject, false)
				arg_675_1.callingController_:SetSelectedState("normal")

				local var_678_3 = arg_675_1:GetWordFromCfg(115311164)
				local var_678_4 = arg_675_1:FormatText(var_678_3.content)

				arg_675_1.text_.text = var_678_4

				LuaForUtil.ClearLinePrefixSymbol(arg_675_1.text_)

				local var_678_5 = 59
				local var_678_6 = utf8.len(var_678_4)
				local var_678_7 = var_678_5 <= 0 and var_678_1 or var_678_1 * (var_678_6 / var_678_5)

				if var_678_7 > 0 and var_678_1 < var_678_7 then
					arg_675_1.talkMaxDuration = var_678_7

					if var_678_7 + var_678_0 > arg_675_1.duration_ then
						arg_675_1.duration_ = var_678_7 + var_678_0
					end
				end

				arg_675_1.text_.text = var_678_4
				arg_675_1.typewritter.percent = 0

				arg_675_1.typewritter:SetDirty()
				arg_675_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311164", "story_v_out_115311.awb") ~= 0 then
					local var_678_8 = manager.audio:GetVoiceLength("story_v_out_115311", "115311164", "story_v_out_115311.awb") / 1000

					if var_678_8 + var_678_0 > arg_675_1.duration_ then
						arg_675_1.duration_ = var_678_8 + var_678_0
					end

					if var_678_3.prefab_name ~= "" and arg_675_1.actors_[var_678_3.prefab_name] ~= nil then
						local var_678_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_675_1.actors_[var_678_3.prefab_name].transform, "story_v_out_115311", "115311164", "story_v_out_115311.awb")

						arg_675_1:RecordAudio("115311164", var_678_9)
						arg_675_1:RecordAudio("115311164", var_678_9)
					else
						arg_675_1:AudioAction("play", "voice", "story_v_out_115311", "115311164", "story_v_out_115311.awb")
					end

					arg_675_1:RecordHistoryTalkVoice("story_v_out_115311", "115311164", "story_v_out_115311.awb")
				end

				arg_675_1:RecordContent(arg_675_1.text_.text)
			end

			local var_678_10 = math.max(var_678_1, arg_675_1.talkMaxDuration)

			if var_678_0 <= arg_675_1.time_ and arg_675_1.time_ < var_678_0 + var_678_10 then
				arg_675_1.typewritter.percent = (arg_675_1.time_ - var_678_0) / var_678_10

				arg_675_1.typewritter:SetDirty()
			end

			if arg_675_1.time_ >= var_678_0 + var_678_10 and arg_675_1.time_ < var_678_0 + var_678_10 + arg_678_0 then
				arg_675_1.typewritter.percent = 1

				arg_675_1.typewritter:SetDirty()
				arg_675_1:ShowNextGo(true)
			end
		end

		arg_675_1.nodeConfigList_ = {}

		arg_675_1:InitPlayNodeList()
	end,
	Play115311165 = function(arg_679_0, arg_679_1)
		arg_679_1.time_ = 0
		arg_679_1.frameCnt_ = 0
		arg_679_1.state_ = "playing"
		arg_679_1.curTalkId_ = 115311165
		arg_679_1.duration_ = 7.53

		local var_679_0 = {
			ja = 6.6,
			ko = 7.533,
			zh = 5.933,
			en = 7
		}
		local var_679_1 = manager.audio:GetLocalizationFlag()

		if var_679_0[var_679_1] ~= nil then
			arg_679_1.duration_ = var_679_0[var_679_1]
		end

		SetActive(arg_679_1.tipsGo_, false)

		function arg_679_1.onSingleLineFinish_()
			arg_679_1.onSingleLineUpdate_ = nil
			arg_679_1.onSingleLineFinish_ = nil
			arg_679_1.state_ = "waiting"
		end

		function arg_679_1.playNext_(arg_681_0)
			if arg_681_0 == 1 then
				arg_679_0:Play115311166(arg_679_1)
			end
		end

		function arg_679_1.onSingleLineUpdate_(arg_682_0)
			local var_682_0 = arg_679_1.actors_["1038"]
			local var_682_1 = 0

			if var_682_1 < arg_679_1.time_ and arg_679_1.time_ <= var_682_1 + arg_682_0 and not isNil(var_682_0) and arg_679_1.var_.actorSpriteComps1038 == nil then
				arg_679_1.var_.actorSpriteComps1038 = var_682_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_682_2 = 0.2

			if var_682_1 <= arg_679_1.time_ and arg_679_1.time_ < var_682_1 + var_682_2 and not isNil(var_682_0) then
				local var_682_3 = (arg_679_1.time_ - var_682_1) / var_682_2

				if arg_679_1.var_.actorSpriteComps1038 then
					for iter_682_0, iter_682_1 in pairs(arg_679_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_682_1 then
							if arg_679_1.isInRecall_ then
								local var_682_4 = Mathf.Lerp(iter_682_1.color.r, arg_679_1.hightColor2.r, var_682_3)
								local var_682_5 = Mathf.Lerp(iter_682_1.color.g, arg_679_1.hightColor2.g, var_682_3)
								local var_682_6 = Mathf.Lerp(iter_682_1.color.b, arg_679_1.hightColor2.b, var_682_3)

								iter_682_1.color = Color.New(var_682_4, var_682_5, var_682_6)
							else
								local var_682_7 = Mathf.Lerp(iter_682_1.color.r, 0.5, var_682_3)

								iter_682_1.color = Color.New(var_682_7, var_682_7, var_682_7)
							end
						end
					end
				end
			end

			if arg_679_1.time_ >= var_682_1 + var_682_2 and arg_679_1.time_ < var_682_1 + var_682_2 + arg_682_0 and not isNil(var_682_0) and arg_679_1.var_.actorSpriteComps1038 then
				for iter_682_2, iter_682_3 in pairs(arg_679_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_682_3 then
						if arg_679_1.isInRecall_ then
							iter_682_3.color = arg_679_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_682_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_679_1.var_.actorSpriteComps1038 = nil
			end

			local var_682_8 = arg_679_1.actors_["10030"]
			local var_682_9 = 0

			if var_682_9 < arg_679_1.time_ and arg_679_1.time_ <= var_682_9 + arg_682_0 and not isNil(var_682_8) and arg_679_1.var_.actorSpriteComps10030 == nil then
				arg_679_1.var_.actorSpriteComps10030 = var_682_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_682_10 = 0.2

			if var_682_9 <= arg_679_1.time_ and arg_679_1.time_ < var_682_9 + var_682_10 and not isNil(var_682_8) then
				local var_682_11 = (arg_679_1.time_ - var_682_9) / var_682_10

				if arg_679_1.var_.actorSpriteComps10030 then
					for iter_682_4, iter_682_5 in pairs(arg_679_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_682_5 then
							if arg_679_1.isInRecall_ then
								local var_682_12 = Mathf.Lerp(iter_682_5.color.r, arg_679_1.hightColor1.r, var_682_11)
								local var_682_13 = Mathf.Lerp(iter_682_5.color.g, arg_679_1.hightColor1.g, var_682_11)
								local var_682_14 = Mathf.Lerp(iter_682_5.color.b, arg_679_1.hightColor1.b, var_682_11)

								iter_682_5.color = Color.New(var_682_12, var_682_13, var_682_14)
							else
								local var_682_15 = Mathf.Lerp(iter_682_5.color.r, 1, var_682_11)

								iter_682_5.color = Color.New(var_682_15, var_682_15, var_682_15)
							end
						end
					end
				end
			end

			if arg_679_1.time_ >= var_682_9 + var_682_10 and arg_679_1.time_ < var_682_9 + var_682_10 + arg_682_0 and not isNil(var_682_8) and arg_679_1.var_.actorSpriteComps10030 then
				for iter_682_6, iter_682_7 in pairs(arg_679_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_682_7 then
						if arg_679_1.isInRecall_ then
							iter_682_7.color = arg_679_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_682_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_679_1.var_.actorSpriteComps10030 = nil
			end

			local var_682_16 = 0
			local var_682_17 = 0.55

			if var_682_16 < arg_679_1.time_ and arg_679_1.time_ <= var_682_16 + arg_682_0 then
				arg_679_1.talkMaxDuration = 0
				arg_679_1.dialogCg_.alpha = 1

				arg_679_1.dialog_:SetActive(true)
				SetActive(arg_679_1.leftNameGo_, true)

				local var_682_18 = arg_679_1:FormatText(StoryNameCfg[309].name)

				arg_679_1.leftNameTxt_.text = var_682_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_679_1.leftNameTxt_.transform)

				arg_679_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_679_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_679_1:RecordName(arg_679_1.leftNameTxt_.text)
				SetActive(arg_679_1.iconTrs_.gameObject, false)
				arg_679_1.callingController_:SetSelectedState("normal")

				local var_682_19 = arg_679_1:GetWordFromCfg(115311165)
				local var_682_20 = arg_679_1:FormatText(var_682_19.content)

				arg_679_1.text_.text = var_682_20

				LuaForUtil.ClearLinePrefixSymbol(arg_679_1.text_)

				local var_682_21 = 22
				local var_682_22 = utf8.len(var_682_20)
				local var_682_23 = var_682_21 <= 0 and var_682_17 or var_682_17 * (var_682_22 / var_682_21)

				if var_682_23 > 0 and var_682_17 < var_682_23 then
					arg_679_1.talkMaxDuration = var_682_23

					if var_682_23 + var_682_16 > arg_679_1.duration_ then
						arg_679_1.duration_ = var_682_23 + var_682_16
					end
				end

				arg_679_1.text_.text = var_682_20
				arg_679_1.typewritter.percent = 0

				arg_679_1.typewritter:SetDirty()
				arg_679_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311165", "story_v_out_115311.awb") ~= 0 then
					local var_682_24 = manager.audio:GetVoiceLength("story_v_out_115311", "115311165", "story_v_out_115311.awb") / 1000

					if var_682_24 + var_682_16 > arg_679_1.duration_ then
						arg_679_1.duration_ = var_682_24 + var_682_16
					end

					if var_682_19.prefab_name ~= "" and arg_679_1.actors_[var_682_19.prefab_name] ~= nil then
						local var_682_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_679_1.actors_[var_682_19.prefab_name].transform, "story_v_out_115311", "115311165", "story_v_out_115311.awb")

						arg_679_1:RecordAudio("115311165", var_682_25)
						arg_679_1:RecordAudio("115311165", var_682_25)
					else
						arg_679_1:AudioAction("play", "voice", "story_v_out_115311", "115311165", "story_v_out_115311.awb")
					end

					arg_679_1:RecordHistoryTalkVoice("story_v_out_115311", "115311165", "story_v_out_115311.awb")
				end

				arg_679_1:RecordContent(arg_679_1.text_.text)
			end

			local var_682_26 = math.max(var_682_17, arg_679_1.talkMaxDuration)

			if var_682_16 <= arg_679_1.time_ and arg_679_1.time_ < var_682_16 + var_682_26 then
				arg_679_1.typewritter.percent = (arg_679_1.time_ - var_682_16) / var_682_26

				arg_679_1.typewritter:SetDirty()
			end

			if arg_679_1.time_ >= var_682_16 + var_682_26 and arg_679_1.time_ < var_682_16 + var_682_26 + arg_682_0 then
				arg_679_1.typewritter.percent = 1

				arg_679_1.typewritter:SetDirty()
				arg_679_1:ShowNextGo(true)
			end
		end

		arg_679_1.nodeConfigList_ = {}

		arg_679_1:InitPlayNodeList()
	end,
	Play115311166 = function(arg_683_0, arg_683_1)
		arg_683_1.time_ = 0
		arg_683_1.frameCnt_ = 0
		arg_683_1.state_ = "playing"
		arg_683_1.curTalkId_ = 115311166
		arg_683_1.duration_ = 5

		SetActive(arg_683_1.tipsGo_, false)

		function arg_683_1.onSingleLineFinish_()
			arg_683_1.onSingleLineUpdate_ = nil
			arg_683_1.onSingleLineFinish_ = nil
			arg_683_1.state_ = "waiting"
		end

		function arg_683_1.playNext_(arg_685_0)
			if arg_685_0 == 1 then
				arg_683_0:Play115311167(arg_683_1)
			end
		end

		function arg_683_1.onSingleLineUpdate_(arg_686_0)
			local var_686_0 = arg_683_1.actors_["10030"]
			local var_686_1 = 0

			if var_686_1 < arg_683_1.time_ and arg_683_1.time_ <= var_686_1 + arg_686_0 and not isNil(var_686_0) and arg_683_1.var_.actorSpriteComps10030 == nil then
				arg_683_1.var_.actorSpriteComps10030 = var_686_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_686_2 = 0.2

			if var_686_1 <= arg_683_1.time_ and arg_683_1.time_ < var_686_1 + var_686_2 and not isNil(var_686_0) then
				local var_686_3 = (arg_683_1.time_ - var_686_1) / var_686_2

				if arg_683_1.var_.actorSpriteComps10030 then
					for iter_686_0, iter_686_1 in pairs(arg_683_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_686_1 then
							if arg_683_1.isInRecall_ then
								local var_686_4 = Mathf.Lerp(iter_686_1.color.r, arg_683_1.hightColor2.r, var_686_3)
								local var_686_5 = Mathf.Lerp(iter_686_1.color.g, arg_683_1.hightColor2.g, var_686_3)
								local var_686_6 = Mathf.Lerp(iter_686_1.color.b, arg_683_1.hightColor2.b, var_686_3)

								iter_686_1.color = Color.New(var_686_4, var_686_5, var_686_6)
							else
								local var_686_7 = Mathf.Lerp(iter_686_1.color.r, 0.5, var_686_3)

								iter_686_1.color = Color.New(var_686_7, var_686_7, var_686_7)
							end
						end
					end
				end
			end

			if arg_683_1.time_ >= var_686_1 + var_686_2 and arg_683_1.time_ < var_686_1 + var_686_2 + arg_686_0 and not isNil(var_686_0) and arg_683_1.var_.actorSpriteComps10030 then
				for iter_686_2, iter_686_3 in pairs(arg_683_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_686_3 then
						if arg_683_1.isInRecall_ then
							iter_686_3.color = arg_683_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_686_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_683_1.var_.actorSpriteComps10030 = nil
			end

			local var_686_8 = 0
			local var_686_9 = 1

			if var_686_8 < arg_683_1.time_ and arg_683_1.time_ <= var_686_8 + arg_686_0 then
				arg_683_1.talkMaxDuration = 0
				arg_683_1.dialogCg_.alpha = 1

				arg_683_1.dialog_:SetActive(true)
				SetActive(arg_683_1.leftNameGo_, false)

				arg_683_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_683_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_683_1:RecordName(arg_683_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_683_1.iconTrs_.gameObject, false)
				arg_683_1.callingController_:SetSelectedState("normal")

				local var_686_10 = arg_683_1:GetWordFromCfg(115311166)
				local var_686_11 = arg_683_1:FormatText(var_686_10.content)

				arg_683_1.text_.text = var_686_11

				LuaForUtil.ClearLinePrefixSymbol(arg_683_1.text_)

				local var_686_12 = 40
				local var_686_13 = utf8.len(var_686_11)
				local var_686_14 = var_686_12 <= 0 and var_686_9 or var_686_9 * (var_686_13 / var_686_12)

				if var_686_14 > 0 and var_686_9 < var_686_14 then
					arg_683_1.talkMaxDuration = var_686_14

					if var_686_14 + var_686_8 > arg_683_1.duration_ then
						arg_683_1.duration_ = var_686_14 + var_686_8
					end
				end

				arg_683_1.text_.text = var_686_11
				arg_683_1.typewritter.percent = 0

				arg_683_1.typewritter:SetDirty()
				arg_683_1:ShowNextGo(false)
				arg_683_1:RecordContent(arg_683_1.text_.text)
			end

			local var_686_15 = math.max(var_686_9, arg_683_1.talkMaxDuration)

			if var_686_8 <= arg_683_1.time_ and arg_683_1.time_ < var_686_8 + var_686_15 then
				arg_683_1.typewritter.percent = (arg_683_1.time_ - var_686_8) / var_686_15

				arg_683_1.typewritter:SetDirty()
			end

			if arg_683_1.time_ >= var_686_8 + var_686_15 and arg_683_1.time_ < var_686_8 + var_686_15 + arg_686_0 then
				arg_683_1.typewritter.percent = 1

				arg_683_1.typewritter:SetDirty()
				arg_683_1:ShowNextGo(true)
			end
		end

		arg_683_1.nodeConfigList_ = {}

		arg_683_1:InitPlayNodeList()
	end,
	Play115311167 = function(arg_687_0, arg_687_1)
		arg_687_1.time_ = 0
		arg_687_1.frameCnt_ = 0
		arg_687_1.state_ = "playing"
		arg_687_1.curTalkId_ = 115311167
		arg_687_1.duration_ = 4.07

		local var_687_0 = {
			ja = 3.866,
			ko = 3.4,
			zh = 2.666,
			en = 4.066
		}
		local var_687_1 = manager.audio:GetLocalizationFlag()

		if var_687_0[var_687_1] ~= nil then
			arg_687_1.duration_ = var_687_0[var_687_1]
		end

		SetActive(arg_687_1.tipsGo_, false)

		function arg_687_1.onSingleLineFinish_()
			arg_687_1.onSingleLineUpdate_ = nil
			arg_687_1.onSingleLineFinish_ = nil
			arg_687_1.state_ = "waiting"
		end

		function arg_687_1.playNext_(arg_689_0)
			if arg_689_0 == 1 then
				arg_687_0:Play115311168(arg_687_1)
			end
		end

		function arg_687_1.onSingleLineUpdate_(arg_690_0)
			local var_690_0 = arg_687_1.actors_["10030"]
			local var_690_1 = 0

			if var_690_1 < arg_687_1.time_ and arg_687_1.time_ <= var_690_1 + arg_690_0 and not isNil(var_690_0) and arg_687_1.var_.actorSpriteComps10030 == nil then
				arg_687_1.var_.actorSpriteComps10030 = var_690_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_690_2 = 0.2

			if var_690_1 <= arg_687_1.time_ and arg_687_1.time_ < var_690_1 + var_690_2 and not isNil(var_690_0) then
				local var_690_3 = (arg_687_1.time_ - var_690_1) / var_690_2

				if arg_687_1.var_.actorSpriteComps10030 then
					for iter_690_0, iter_690_1 in pairs(arg_687_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_690_1 then
							if arg_687_1.isInRecall_ then
								local var_690_4 = Mathf.Lerp(iter_690_1.color.r, arg_687_1.hightColor1.r, var_690_3)
								local var_690_5 = Mathf.Lerp(iter_690_1.color.g, arg_687_1.hightColor1.g, var_690_3)
								local var_690_6 = Mathf.Lerp(iter_690_1.color.b, arg_687_1.hightColor1.b, var_690_3)

								iter_690_1.color = Color.New(var_690_4, var_690_5, var_690_6)
							else
								local var_690_7 = Mathf.Lerp(iter_690_1.color.r, 1, var_690_3)

								iter_690_1.color = Color.New(var_690_7, var_690_7, var_690_7)
							end
						end
					end
				end
			end

			if arg_687_1.time_ >= var_690_1 + var_690_2 and arg_687_1.time_ < var_690_1 + var_690_2 + arg_690_0 and not isNil(var_690_0) and arg_687_1.var_.actorSpriteComps10030 then
				for iter_690_2, iter_690_3 in pairs(arg_687_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_690_3 then
						if arg_687_1.isInRecall_ then
							iter_690_3.color = arg_687_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_690_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_687_1.var_.actorSpriteComps10030 = nil
			end

			local var_690_8 = arg_687_1.actors_["10030"].transform
			local var_690_9 = 0

			if var_690_9 < arg_687_1.time_ and arg_687_1.time_ <= var_690_9 + arg_690_0 then
				arg_687_1.var_.moveOldPos10030 = var_690_8.localPosition
				var_690_8.localScale = Vector3.New(1, 1, 1)

				arg_687_1:CheckSpriteTmpPos("10030", 4)

				local var_690_10 = var_690_8.childCount

				for iter_690_4 = 0, var_690_10 - 1 do
					local var_690_11 = var_690_8:GetChild(iter_690_4)

					if var_690_11.name == "split_1" or not string.find(var_690_11.name, "split") then
						var_690_11.gameObject:SetActive(true)
					else
						var_690_11.gameObject:SetActive(false)
					end
				end
			end

			local var_690_12 = 0.001

			if var_690_9 <= arg_687_1.time_ and arg_687_1.time_ < var_690_9 + var_690_12 then
				local var_690_13 = (arg_687_1.time_ - var_690_9) / var_690_12
				local var_690_14 = Vector3.New(390, -390, 150)

				var_690_8.localPosition = Vector3.Lerp(arg_687_1.var_.moveOldPos10030, var_690_14, var_690_13)
			end

			if arg_687_1.time_ >= var_690_9 + var_690_12 and arg_687_1.time_ < var_690_9 + var_690_12 + arg_690_0 then
				var_690_8.localPosition = Vector3.New(390, -390, 150)
			end

			local var_690_15 = arg_687_1.actors_["10030"]
			local var_690_16 = 0

			if var_690_16 < arg_687_1.time_ and arg_687_1.time_ <= var_690_16 + arg_690_0 then
				local var_690_17 = var_690_15:GetComponentInChildren(typeof(CanvasGroup))

				if var_690_17 then
					arg_687_1.var_.alphaOldValue10030 = var_690_17.alpha
					arg_687_1.var_.characterEffect10030 = var_690_17
				end

				arg_687_1.var_.alphaOldValue10030 = 0
			end

			local var_690_18 = 0.0166666666666667

			if var_690_16 <= arg_687_1.time_ and arg_687_1.time_ < var_690_16 + var_690_18 then
				local var_690_19 = (arg_687_1.time_ - var_690_16) / var_690_18
				local var_690_20 = Mathf.Lerp(arg_687_1.var_.alphaOldValue10030, 1, var_690_19)

				if arg_687_1.var_.characterEffect10030 then
					arg_687_1.var_.characterEffect10030.alpha = var_690_20
				end
			end

			if arg_687_1.time_ >= var_690_16 + var_690_18 and arg_687_1.time_ < var_690_16 + var_690_18 + arg_690_0 and arg_687_1.var_.characterEffect10030 then
				arg_687_1.var_.characterEffect10030.alpha = 1
			end

			local var_690_21 = 0
			local var_690_22 = 0.35

			if var_690_21 < arg_687_1.time_ and arg_687_1.time_ <= var_690_21 + arg_690_0 then
				arg_687_1.talkMaxDuration = 0
				arg_687_1.dialogCg_.alpha = 1

				arg_687_1.dialog_:SetActive(true)
				SetActive(arg_687_1.leftNameGo_, true)

				local var_690_23 = arg_687_1:FormatText(StoryNameCfg[309].name)

				arg_687_1.leftNameTxt_.text = var_690_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_687_1.leftNameTxt_.transform)

				arg_687_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_687_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_687_1:RecordName(arg_687_1.leftNameTxt_.text)
				SetActive(arg_687_1.iconTrs_.gameObject, false)
				arg_687_1.callingController_:SetSelectedState("normal")

				local var_690_24 = arg_687_1:GetWordFromCfg(115311167)
				local var_690_25 = arg_687_1:FormatText(var_690_24.content)

				arg_687_1.text_.text = var_690_25

				LuaForUtil.ClearLinePrefixSymbol(arg_687_1.text_)

				local var_690_26 = 14
				local var_690_27 = utf8.len(var_690_25)
				local var_690_28 = var_690_26 <= 0 and var_690_22 or var_690_22 * (var_690_27 / var_690_26)

				if var_690_28 > 0 and var_690_22 < var_690_28 then
					arg_687_1.talkMaxDuration = var_690_28

					if var_690_28 + var_690_21 > arg_687_1.duration_ then
						arg_687_1.duration_ = var_690_28 + var_690_21
					end
				end

				arg_687_1.text_.text = var_690_25
				arg_687_1.typewritter.percent = 0

				arg_687_1.typewritter:SetDirty()
				arg_687_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311167", "story_v_out_115311.awb") ~= 0 then
					local var_690_29 = manager.audio:GetVoiceLength("story_v_out_115311", "115311167", "story_v_out_115311.awb") / 1000

					if var_690_29 + var_690_21 > arg_687_1.duration_ then
						arg_687_1.duration_ = var_690_29 + var_690_21
					end

					if var_690_24.prefab_name ~= "" and arg_687_1.actors_[var_690_24.prefab_name] ~= nil then
						local var_690_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_687_1.actors_[var_690_24.prefab_name].transform, "story_v_out_115311", "115311167", "story_v_out_115311.awb")

						arg_687_1:RecordAudio("115311167", var_690_30)
						arg_687_1:RecordAudio("115311167", var_690_30)
					else
						arg_687_1:AudioAction("play", "voice", "story_v_out_115311", "115311167", "story_v_out_115311.awb")
					end

					arg_687_1:RecordHistoryTalkVoice("story_v_out_115311", "115311167", "story_v_out_115311.awb")
				end

				arg_687_1:RecordContent(arg_687_1.text_.text)
			end

			local var_690_31 = math.max(var_690_22, arg_687_1.talkMaxDuration)

			if var_690_21 <= arg_687_1.time_ and arg_687_1.time_ < var_690_21 + var_690_31 then
				arg_687_1.typewritter.percent = (arg_687_1.time_ - var_690_21) / var_690_31

				arg_687_1.typewritter:SetDirty()
			end

			if arg_687_1.time_ >= var_690_21 + var_690_31 and arg_687_1.time_ < var_690_21 + var_690_31 + arg_690_0 then
				arg_687_1.typewritter.percent = 1

				arg_687_1.typewritter:SetDirty()
				arg_687_1:ShowNextGo(true)
			end
		end

		arg_687_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10030",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_687_1:InitPlayNodeList()
	end,
	Play115311168 = function(arg_691_0, arg_691_1)
		arg_691_1.time_ = 0
		arg_691_1.frameCnt_ = 0
		arg_691_1.state_ = "playing"
		arg_691_1.curTalkId_ = 115311168
		arg_691_1.duration_ = 5

		SetActive(arg_691_1.tipsGo_, false)

		function arg_691_1.onSingleLineFinish_()
			arg_691_1.onSingleLineUpdate_ = nil
			arg_691_1.onSingleLineFinish_ = nil
			arg_691_1.state_ = "waiting"
		end

		function arg_691_1.playNext_(arg_693_0)
			if arg_693_0 == 1 then
				arg_691_0:Play115311169(arg_691_1)
			end
		end

		function arg_691_1.onSingleLineUpdate_(arg_694_0)
			local var_694_0 = arg_691_1.actors_["10030"]
			local var_694_1 = 0

			if var_694_1 < arg_691_1.time_ and arg_691_1.time_ <= var_694_1 + arg_694_0 and not isNil(var_694_0) and arg_691_1.var_.actorSpriteComps10030 == nil then
				arg_691_1.var_.actorSpriteComps10030 = var_694_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_694_2 = 0.2

			if var_694_1 <= arg_691_1.time_ and arg_691_1.time_ < var_694_1 + var_694_2 and not isNil(var_694_0) then
				local var_694_3 = (arg_691_1.time_ - var_694_1) / var_694_2

				if arg_691_1.var_.actorSpriteComps10030 then
					for iter_694_0, iter_694_1 in pairs(arg_691_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_694_1 then
							if arg_691_1.isInRecall_ then
								local var_694_4 = Mathf.Lerp(iter_694_1.color.r, arg_691_1.hightColor2.r, var_694_3)
								local var_694_5 = Mathf.Lerp(iter_694_1.color.g, arg_691_1.hightColor2.g, var_694_3)
								local var_694_6 = Mathf.Lerp(iter_694_1.color.b, arg_691_1.hightColor2.b, var_694_3)

								iter_694_1.color = Color.New(var_694_4, var_694_5, var_694_6)
							else
								local var_694_7 = Mathf.Lerp(iter_694_1.color.r, 0.5, var_694_3)

								iter_694_1.color = Color.New(var_694_7, var_694_7, var_694_7)
							end
						end
					end
				end
			end

			if arg_691_1.time_ >= var_694_1 + var_694_2 and arg_691_1.time_ < var_694_1 + var_694_2 + arg_694_0 and not isNil(var_694_0) and arg_691_1.var_.actorSpriteComps10030 then
				for iter_694_2, iter_694_3 in pairs(arg_691_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_694_3 then
						if arg_691_1.isInRecall_ then
							iter_694_3.color = arg_691_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_694_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_691_1.var_.actorSpriteComps10030 = nil
			end

			local var_694_8 = 0
			local var_694_9 = 0.7

			if var_694_8 < arg_691_1.time_ and arg_691_1.time_ <= var_694_8 + arg_694_0 then
				arg_691_1.talkMaxDuration = 0
				arg_691_1.dialogCg_.alpha = 1

				arg_691_1.dialog_:SetActive(true)
				SetActive(arg_691_1.leftNameGo_, false)

				arg_691_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_691_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_691_1:RecordName(arg_691_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_691_1.iconTrs_.gameObject, false)
				arg_691_1.callingController_:SetSelectedState("normal")

				local var_694_10 = arg_691_1:GetWordFromCfg(115311168)
				local var_694_11 = arg_691_1:FormatText(var_694_10.content)

				arg_691_1.text_.text = var_694_11

				LuaForUtil.ClearLinePrefixSymbol(arg_691_1.text_)

				local var_694_12 = 28
				local var_694_13 = utf8.len(var_694_11)
				local var_694_14 = var_694_12 <= 0 and var_694_9 or var_694_9 * (var_694_13 / var_694_12)

				if var_694_14 > 0 and var_694_9 < var_694_14 then
					arg_691_1.talkMaxDuration = var_694_14

					if var_694_14 + var_694_8 > arg_691_1.duration_ then
						arg_691_1.duration_ = var_694_14 + var_694_8
					end
				end

				arg_691_1.text_.text = var_694_11
				arg_691_1.typewritter.percent = 0

				arg_691_1.typewritter:SetDirty()
				arg_691_1:ShowNextGo(false)
				arg_691_1:RecordContent(arg_691_1.text_.text)
			end

			local var_694_15 = math.max(var_694_9, arg_691_1.talkMaxDuration)

			if var_694_8 <= arg_691_1.time_ and arg_691_1.time_ < var_694_8 + var_694_15 then
				arg_691_1.typewritter.percent = (arg_691_1.time_ - var_694_8) / var_694_15

				arg_691_1.typewritter:SetDirty()
			end

			if arg_691_1.time_ >= var_694_8 + var_694_15 and arg_691_1.time_ < var_694_8 + var_694_15 + arg_694_0 then
				arg_691_1.typewritter.percent = 1

				arg_691_1.typewritter:SetDirty()
				arg_691_1:ShowNextGo(true)
			end
		end

		arg_691_1.nodeConfigList_ = {}

		arg_691_1:InitPlayNodeList()
	end,
	Play115311169 = function(arg_695_0, arg_695_1)
		arg_695_1.time_ = 0
		arg_695_1.frameCnt_ = 0
		arg_695_1.state_ = "playing"
		arg_695_1.curTalkId_ = 115311169
		arg_695_1.duration_ = 3

		local var_695_0 = {
			ja = 3,
			ko = 1.666,
			zh = 2.866,
			en = 1.8
		}
		local var_695_1 = manager.audio:GetLocalizationFlag()

		if var_695_0[var_695_1] ~= nil then
			arg_695_1.duration_ = var_695_0[var_695_1]
		end

		SetActive(arg_695_1.tipsGo_, false)

		function arg_695_1.onSingleLineFinish_()
			arg_695_1.onSingleLineUpdate_ = nil
			arg_695_1.onSingleLineFinish_ = nil
			arg_695_1.state_ = "waiting"
		end

		function arg_695_1.playNext_(arg_697_0)
			if arg_697_0 == 1 then
				arg_695_0:Play115311170(arg_695_1)
			end
		end

		function arg_695_1.onSingleLineUpdate_(arg_698_0)
			local var_698_0 = arg_695_1.actors_["1038"]
			local var_698_1 = 0

			if var_698_1 < arg_695_1.time_ and arg_695_1.time_ <= var_698_1 + arg_698_0 and not isNil(var_698_0) and arg_695_1.var_.actorSpriteComps1038 == nil then
				arg_695_1.var_.actorSpriteComps1038 = var_698_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_698_2 = 0.2

			if var_698_1 <= arg_695_1.time_ and arg_695_1.time_ < var_698_1 + var_698_2 and not isNil(var_698_0) then
				local var_698_3 = (arg_695_1.time_ - var_698_1) / var_698_2

				if arg_695_1.var_.actorSpriteComps1038 then
					for iter_698_0, iter_698_1 in pairs(arg_695_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_698_1 then
							if arg_695_1.isInRecall_ then
								local var_698_4 = Mathf.Lerp(iter_698_1.color.r, arg_695_1.hightColor1.r, var_698_3)
								local var_698_5 = Mathf.Lerp(iter_698_1.color.g, arg_695_1.hightColor1.g, var_698_3)
								local var_698_6 = Mathf.Lerp(iter_698_1.color.b, arg_695_1.hightColor1.b, var_698_3)

								iter_698_1.color = Color.New(var_698_4, var_698_5, var_698_6)
							else
								local var_698_7 = Mathf.Lerp(iter_698_1.color.r, 1, var_698_3)

								iter_698_1.color = Color.New(var_698_7, var_698_7, var_698_7)
							end
						end
					end
				end
			end

			if arg_695_1.time_ >= var_698_1 + var_698_2 and arg_695_1.time_ < var_698_1 + var_698_2 + arg_698_0 and not isNil(var_698_0) and arg_695_1.var_.actorSpriteComps1038 then
				for iter_698_2, iter_698_3 in pairs(arg_695_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_698_3 then
						if arg_695_1.isInRecall_ then
							iter_698_3.color = arg_695_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_698_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_695_1.var_.actorSpriteComps1038 = nil
			end

			local var_698_8 = arg_695_1.actors_["1038"].transform
			local var_698_9 = 0

			if var_698_9 < arg_695_1.time_ and arg_695_1.time_ <= var_698_9 + arg_698_0 then
				arg_695_1.var_.moveOldPos1038 = var_698_8.localPosition
				var_698_8.localScale = Vector3.New(1, 1, 1)

				arg_695_1:CheckSpriteTmpPos("1038", 2)

				local var_698_10 = var_698_8.childCount

				for iter_698_4 = 0, var_698_10 - 1 do
					local var_698_11 = var_698_8:GetChild(iter_698_4)

					if var_698_11.name == "split_7" or not string.find(var_698_11.name, "split") then
						var_698_11.gameObject:SetActive(true)
					else
						var_698_11.gameObject:SetActive(false)
					end
				end
			end

			local var_698_12 = 0.001

			if var_698_9 <= arg_695_1.time_ and arg_695_1.time_ < var_698_9 + var_698_12 then
				local var_698_13 = (arg_695_1.time_ - var_698_9) / var_698_12
				local var_698_14 = Vector3.New(-390, -400, 0)

				var_698_8.localPosition = Vector3.Lerp(arg_695_1.var_.moveOldPos1038, var_698_14, var_698_13)
			end

			if arg_695_1.time_ >= var_698_9 + var_698_12 and arg_695_1.time_ < var_698_9 + var_698_12 + arg_698_0 then
				var_698_8.localPosition = Vector3.New(-390, -400, 0)
			end

			local var_698_15 = 0
			local var_698_16 = 0.2

			if var_698_15 < arg_695_1.time_ and arg_695_1.time_ <= var_698_15 + arg_698_0 then
				arg_695_1.talkMaxDuration = 0
				arg_695_1.dialogCg_.alpha = 1

				arg_695_1.dialog_:SetActive(true)
				SetActive(arg_695_1.leftNameGo_, true)

				local var_698_17 = arg_695_1:FormatText(StoryNameCfg[94].name)

				arg_695_1.leftNameTxt_.text = var_698_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_695_1.leftNameTxt_.transform)

				arg_695_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_695_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_695_1:RecordName(arg_695_1.leftNameTxt_.text)
				SetActive(arg_695_1.iconTrs_.gameObject, false)
				arg_695_1.callingController_:SetSelectedState("normal")

				local var_698_18 = arg_695_1:GetWordFromCfg(115311169)
				local var_698_19 = arg_695_1:FormatText(var_698_18.content)

				arg_695_1.text_.text = var_698_19

				LuaForUtil.ClearLinePrefixSymbol(arg_695_1.text_)

				local var_698_20 = 8
				local var_698_21 = utf8.len(var_698_19)
				local var_698_22 = var_698_20 <= 0 and var_698_16 or var_698_16 * (var_698_21 / var_698_20)

				if var_698_22 > 0 and var_698_16 < var_698_22 then
					arg_695_1.talkMaxDuration = var_698_22

					if var_698_22 + var_698_15 > arg_695_1.duration_ then
						arg_695_1.duration_ = var_698_22 + var_698_15
					end
				end

				arg_695_1.text_.text = var_698_19
				arg_695_1.typewritter.percent = 0

				arg_695_1.typewritter:SetDirty()
				arg_695_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311169", "story_v_out_115311.awb") ~= 0 then
					local var_698_23 = manager.audio:GetVoiceLength("story_v_out_115311", "115311169", "story_v_out_115311.awb") / 1000

					if var_698_23 + var_698_15 > arg_695_1.duration_ then
						arg_695_1.duration_ = var_698_23 + var_698_15
					end

					if var_698_18.prefab_name ~= "" and arg_695_1.actors_[var_698_18.prefab_name] ~= nil then
						local var_698_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_695_1.actors_[var_698_18.prefab_name].transform, "story_v_out_115311", "115311169", "story_v_out_115311.awb")

						arg_695_1:RecordAudio("115311169", var_698_24)
						arg_695_1:RecordAudio("115311169", var_698_24)
					else
						arg_695_1:AudioAction("play", "voice", "story_v_out_115311", "115311169", "story_v_out_115311.awb")
					end

					arg_695_1:RecordHistoryTalkVoice("story_v_out_115311", "115311169", "story_v_out_115311.awb")
				end

				arg_695_1:RecordContent(arg_695_1.text_.text)
			end

			local var_698_25 = math.max(var_698_16, arg_695_1.talkMaxDuration)

			if var_698_15 <= arg_695_1.time_ and arg_695_1.time_ < var_698_15 + var_698_25 then
				arg_695_1.typewritter.percent = (arg_695_1.time_ - var_698_15) / var_698_25

				arg_695_1.typewritter:SetDirty()
			end

			if arg_695_1.time_ >= var_698_15 + var_698_25 and arg_695_1.time_ < var_698_15 + var_698_25 + arg_698_0 then
				arg_695_1.typewritter.percent = 1

				arg_695_1.typewritter:SetDirty()
				arg_695_1:ShowNextGo(true)
			end
		end

		arg_695_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_695_1:InitPlayNodeList()
	end,
	Play115311170 = function(arg_699_0, arg_699_1)
		arg_699_1.time_ = 0
		arg_699_1.frameCnt_ = 0
		arg_699_1.state_ = "playing"
		arg_699_1.curTalkId_ = 115311170
		arg_699_1.duration_ = 7.17

		local var_699_0 = {
			ja = 7.1,
			ko = 5.233,
			zh = 6.8,
			en = 7.166
		}
		local var_699_1 = manager.audio:GetLocalizationFlag()

		if var_699_0[var_699_1] ~= nil then
			arg_699_1.duration_ = var_699_0[var_699_1]
		end

		SetActive(arg_699_1.tipsGo_, false)

		function arg_699_1.onSingleLineFinish_()
			arg_699_1.onSingleLineUpdate_ = nil
			arg_699_1.onSingleLineFinish_ = nil
			arg_699_1.state_ = "waiting"
		end

		function arg_699_1.playNext_(arg_701_0)
			if arg_701_0 == 1 then
				arg_699_0:Play115311171(arg_699_1)
			end
		end

		function arg_699_1.onSingleLineUpdate_(arg_702_0)
			local var_702_0 = arg_699_1.actors_["10030"].transform
			local var_702_1 = 0

			if var_702_1 < arg_699_1.time_ and arg_699_1.time_ <= var_702_1 + arg_702_0 then
				arg_699_1.var_.moveOldPos10030 = var_702_0.localPosition
				var_702_0.localScale = Vector3.New(1, 1, 1)

				arg_699_1:CheckSpriteTmpPos("10030", 4)

				local var_702_2 = var_702_0.childCount

				for iter_702_0 = 0, var_702_2 - 1 do
					local var_702_3 = var_702_0:GetChild(iter_702_0)

					if var_702_3.name == "split_3" or not string.find(var_702_3.name, "split") then
						var_702_3.gameObject:SetActive(true)
					else
						var_702_3.gameObject:SetActive(false)
					end
				end
			end

			local var_702_4 = 0.001

			if var_702_1 <= arg_699_1.time_ and arg_699_1.time_ < var_702_1 + var_702_4 then
				local var_702_5 = (arg_699_1.time_ - var_702_1) / var_702_4
				local var_702_6 = Vector3.New(390, -390, 150)

				var_702_0.localPosition = Vector3.Lerp(arg_699_1.var_.moveOldPos10030, var_702_6, var_702_5)
			end

			if arg_699_1.time_ >= var_702_1 + var_702_4 and arg_699_1.time_ < var_702_1 + var_702_4 + arg_702_0 then
				var_702_0.localPosition = Vector3.New(390, -390, 150)
			end

			local var_702_7 = arg_699_1.actors_["10030"]
			local var_702_8 = 0

			if var_702_8 < arg_699_1.time_ and arg_699_1.time_ <= var_702_8 + arg_702_0 and not isNil(var_702_7) and arg_699_1.var_.actorSpriteComps10030 == nil then
				arg_699_1.var_.actorSpriteComps10030 = var_702_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_702_9 = 0.2

			if var_702_8 <= arg_699_1.time_ and arg_699_1.time_ < var_702_8 + var_702_9 and not isNil(var_702_7) then
				local var_702_10 = (arg_699_1.time_ - var_702_8) / var_702_9

				if arg_699_1.var_.actorSpriteComps10030 then
					for iter_702_1, iter_702_2 in pairs(arg_699_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_702_2 then
							if arg_699_1.isInRecall_ then
								local var_702_11 = Mathf.Lerp(iter_702_2.color.r, arg_699_1.hightColor1.r, var_702_10)
								local var_702_12 = Mathf.Lerp(iter_702_2.color.g, arg_699_1.hightColor1.g, var_702_10)
								local var_702_13 = Mathf.Lerp(iter_702_2.color.b, arg_699_1.hightColor1.b, var_702_10)

								iter_702_2.color = Color.New(var_702_11, var_702_12, var_702_13)
							else
								local var_702_14 = Mathf.Lerp(iter_702_2.color.r, 1, var_702_10)

								iter_702_2.color = Color.New(var_702_14, var_702_14, var_702_14)
							end
						end
					end
				end
			end

			if arg_699_1.time_ >= var_702_8 + var_702_9 and arg_699_1.time_ < var_702_8 + var_702_9 + arg_702_0 and not isNil(var_702_7) and arg_699_1.var_.actorSpriteComps10030 then
				for iter_702_3, iter_702_4 in pairs(arg_699_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_702_4 then
						if arg_699_1.isInRecall_ then
							iter_702_4.color = arg_699_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_702_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_699_1.var_.actorSpriteComps10030 = nil
			end

			local var_702_15 = arg_699_1.actors_["1038"]
			local var_702_16 = 0

			if var_702_16 < arg_699_1.time_ and arg_699_1.time_ <= var_702_16 + arg_702_0 and not isNil(var_702_15) and arg_699_1.var_.actorSpriteComps1038 == nil then
				arg_699_1.var_.actorSpriteComps1038 = var_702_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_702_17 = 0.2

			if var_702_16 <= arg_699_1.time_ and arg_699_1.time_ < var_702_16 + var_702_17 and not isNil(var_702_15) then
				local var_702_18 = (arg_699_1.time_ - var_702_16) / var_702_17

				if arg_699_1.var_.actorSpriteComps1038 then
					for iter_702_5, iter_702_6 in pairs(arg_699_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_702_6 then
							if arg_699_1.isInRecall_ then
								local var_702_19 = Mathf.Lerp(iter_702_6.color.r, arg_699_1.hightColor2.r, var_702_18)
								local var_702_20 = Mathf.Lerp(iter_702_6.color.g, arg_699_1.hightColor2.g, var_702_18)
								local var_702_21 = Mathf.Lerp(iter_702_6.color.b, arg_699_1.hightColor2.b, var_702_18)

								iter_702_6.color = Color.New(var_702_19, var_702_20, var_702_21)
							else
								local var_702_22 = Mathf.Lerp(iter_702_6.color.r, 0.5, var_702_18)

								iter_702_6.color = Color.New(var_702_22, var_702_22, var_702_22)
							end
						end
					end
				end
			end

			if arg_699_1.time_ >= var_702_16 + var_702_17 and arg_699_1.time_ < var_702_16 + var_702_17 + arg_702_0 and not isNil(var_702_15) and arg_699_1.var_.actorSpriteComps1038 then
				for iter_702_7, iter_702_8 in pairs(arg_699_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_702_8 then
						if arg_699_1.isInRecall_ then
							iter_702_8.color = arg_699_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_702_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_699_1.var_.actorSpriteComps1038 = nil
			end

			local var_702_23 = 0
			local var_702_24 = 0.725

			if var_702_23 < arg_699_1.time_ and arg_699_1.time_ <= var_702_23 + arg_702_0 then
				arg_699_1.talkMaxDuration = 0
				arg_699_1.dialogCg_.alpha = 1

				arg_699_1.dialog_:SetActive(true)
				SetActive(arg_699_1.leftNameGo_, true)

				local var_702_25 = arg_699_1:FormatText(StoryNameCfg[309].name)

				arg_699_1.leftNameTxt_.text = var_702_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_699_1.leftNameTxt_.transform)

				arg_699_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_699_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_699_1:RecordName(arg_699_1.leftNameTxt_.text)
				SetActive(arg_699_1.iconTrs_.gameObject, false)
				arg_699_1.callingController_:SetSelectedState("normal")

				local var_702_26 = arg_699_1:GetWordFromCfg(115311170)
				local var_702_27 = arg_699_1:FormatText(var_702_26.content)

				arg_699_1.text_.text = var_702_27

				LuaForUtil.ClearLinePrefixSymbol(arg_699_1.text_)

				local var_702_28 = 29
				local var_702_29 = utf8.len(var_702_27)
				local var_702_30 = var_702_28 <= 0 and var_702_24 or var_702_24 * (var_702_29 / var_702_28)

				if var_702_30 > 0 and var_702_24 < var_702_30 then
					arg_699_1.talkMaxDuration = var_702_30

					if var_702_30 + var_702_23 > arg_699_1.duration_ then
						arg_699_1.duration_ = var_702_30 + var_702_23
					end
				end

				arg_699_1.text_.text = var_702_27
				arg_699_1.typewritter.percent = 0

				arg_699_1.typewritter:SetDirty()
				arg_699_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311170", "story_v_out_115311.awb") ~= 0 then
					local var_702_31 = manager.audio:GetVoiceLength("story_v_out_115311", "115311170", "story_v_out_115311.awb") / 1000

					if var_702_31 + var_702_23 > arg_699_1.duration_ then
						arg_699_1.duration_ = var_702_31 + var_702_23
					end

					if var_702_26.prefab_name ~= "" and arg_699_1.actors_[var_702_26.prefab_name] ~= nil then
						local var_702_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_699_1.actors_[var_702_26.prefab_name].transform, "story_v_out_115311", "115311170", "story_v_out_115311.awb")

						arg_699_1:RecordAudio("115311170", var_702_32)
						arg_699_1:RecordAudio("115311170", var_702_32)
					else
						arg_699_1:AudioAction("play", "voice", "story_v_out_115311", "115311170", "story_v_out_115311.awb")
					end

					arg_699_1:RecordHistoryTalkVoice("story_v_out_115311", "115311170", "story_v_out_115311.awb")
				end

				arg_699_1:RecordContent(arg_699_1.text_.text)
			end

			local var_702_33 = math.max(var_702_24, arg_699_1.talkMaxDuration)

			if var_702_23 <= arg_699_1.time_ and arg_699_1.time_ < var_702_23 + var_702_33 then
				arg_699_1.typewritter.percent = (arg_699_1.time_ - var_702_23) / var_702_33

				arg_699_1.typewritter:SetDirty()
			end

			if arg_699_1.time_ >= var_702_23 + var_702_33 and arg_699_1.time_ < var_702_23 + var_702_33 + arg_702_0 then
				arg_699_1.typewritter.percent = 1

				arg_699_1.typewritter:SetDirty()
				arg_699_1:ShowNextGo(true)
			end
		end

		arg_699_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10030",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_699_1:InitPlayNodeList()
	end,
	Play115311171 = function(arg_703_0, arg_703_1)
		arg_703_1.time_ = 0
		arg_703_1.frameCnt_ = 0
		arg_703_1.state_ = "playing"
		arg_703_1.curTalkId_ = 115311171
		arg_703_1.duration_ = 5

		SetActive(arg_703_1.tipsGo_, false)

		function arg_703_1.onSingleLineFinish_()
			arg_703_1.onSingleLineUpdate_ = nil
			arg_703_1.onSingleLineFinish_ = nil
			arg_703_1.state_ = "waiting"
		end

		function arg_703_1.playNext_(arg_705_0)
			if arg_705_0 == 1 then
				arg_703_0:Play115311172(arg_703_1)
			end
		end

		function arg_703_1.onSingleLineUpdate_(arg_706_0)
			local var_706_0 = arg_703_1.actors_["10030"]
			local var_706_1 = 0

			if var_706_1 < arg_703_1.time_ and arg_703_1.time_ <= var_706_1 + arg_706_0 then
				local var_706_2 = var_706_0:GetComponentInChildren(typeof(CanvasGroup))

				if var_706_2 then
					arg_703_1.var_.alphaOldValue10030 = var_706_2.alpha
					arg_703_1.var_.characterEffect10030 = var_706_2
				end

				arg_703_1.var_.alphaOldValue10030 = 1
			end

			local var_706_3 = 0.5

			if var_706_1 <= arg_703_1.time_ and arg_703_1.time_ < var_706_1 + var_706_3 then
				local var_706_4 = (arg_703_1.time_ - var_706_1) / var_706_3
				local var_706_5 = Mathf.Lerp(arg_703_1.var_.alphaOldValue10030, 0, var_706_4)

				if arg_703_1.var_.characterEffect10030 then
					arg_703_1.var_.characterEffect10030.alpha = var_706_5
				end
			end

			if arg_703_1.time_ >= var_706_1 + var_706_3 and arg_703_1.time_ < var_706_1 + var_706_3 + arg_706_0 and arg_703_1.var_.characterEffect10030 then
				arg_703_1.var_.characterEffect10030.alpha = 0
			end

			local var_706_6 = arg_703_1.actors_["1038"]
			local var_706_7 = 0

			if var_706_7 < arg_703_1.time_ and arg_703_1.time_ <= var_706_7 + arg_706_0 then
				local var_706_8 = var_706_6:GetComponentInChildren(typeof(CanvasGroup))

				if var_706_8 then
					arg_703_1.var_.alphaOldValue1038 = var_706_8.alpha
					arg_703_1.var_.characterEffect1038 = var_706_8
				end

				arg_703_1.var_.alphaOldValue1038 = 1
			end

			local var_706_9 = 0.5

			if var_706_7 <= arg_703_1.time_ and arg_703_1.time_ < var_706_7 + var_706_9 then
				local var_706_10 = (arg_703_1.time_ - var_706_7) / var_706_9
				local var_706_11 = Mathf.Lerp(arg_703_1.var_.alphaOldValue1038, 0, var_706_10)

				if arg_703_1.var_.characterEffect1038 then
					arg_703_1.var_.characterEffect1038.alpha = var_706_11
				end
			end

			if arg_703_1.time_ >= var_706_7 + var_706_9 and arg_703_1.time_ < var_706_7 + var_706_9 + arg_706_0 and arg_703_1.var_.characterEffect1038 then
				arg_703_1.var_.characterEffect1038.alpha = 0
			end

			local var_706_12 = 0
			local var_706_13 = 0.525

			if var_706_12 < arg_703_1.time_ and arg_703_1.time_ <= var_706_12 + arg_706_0 then
				arg_703_1.talkMaxDuration = 0
				arg_703_1.dialogCg_.alpha = 1

				arg_703_1.dialog_:SetActive(true)
				SetActive(arg_703_1.leftNameGo_, false)

				arg_703_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_703_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_703_1:RecordName(arg_703_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_703_1.iconTrs_.gameObject, false)
				arg_703_1.callingController_:SetSelectedState("normal")

				local var_706_14 = arg_703_1:GetWordFromCfg(115311171)
				local var_706_15 = arg_703_1:FormatText(var_706_14.content)

				arg_703_1.text_.text = var_706_15

				LuaForUtil.ClearLinePrefixSymbol(arg_703_1.text_)

				local var_706_16 = 21
				local var_706_17 = utf8.len(var_706_15)
				local var_706_18 = var_706_16 <= 0 and var_706_13 or var_706_13 * (var_706_17 / var_706_16)

				if var_706_18 > 0 and var_706_13 < var_706_18 then
					arg_703_1.talkMaxDuration = var_706_18

					if var_706_18 + var_706_12 > arg_703_1.duration_ then
						arg_703_1.duration_ = var_706_18 + var_706_12
					end
				end

				arg_703_1.text_.text = var_706_15
				arg_703_1.typewritter.percent = 0

				arg_703_1.typewritter:SetDirty()
				arg_703_1:ShowNextGo(false)
				arg_703_1:RecordContent(arg_703_1.text_.text)
			end

			local var_706_19 = math.max(var_706_13, arg_703_1.talkMaxDuration)

			if var_706_12 <= arg_703_1.time_ and arg_703_1.time_ < var_706_12 + var_706_19 then
				arg_703_1.typewritter.percent = (arg_703_1.time_ - var_706_12) / var_706_19

				arg_703_1.typewritter:SetDirty()
			end

			if arg_703_1.time_ >= var_706_12 + var_706_19 and arg_703_1.time_ < var_706_12 + var_706_19 + arg_706_0 then
				arg_703_1.typewritter.percent = 1

				arg_703_1.typewritter:SetDirty()
				arg_703_1:ShowNextGo(true)
			end
		end

		arg_703_1.nodeConfigList_ = {}

		arg_703_1:InitPlayNodeList()
	end,
	Play115311172 = function(arg_707_0, arg_707_1)
		arg_707_1.time_ = 0
		arg_707_1.frameCnt_ = 0
		arg_707_1.state_ = "playing"
		arg_707_1.curTalkId_ = 115311172
		arg_707_1.duration_ = 4.17

		local var_707_0 = {
			ja = 4.166,
			ko = 3.033,
			zh = 3.7,
			en = 2.533
		}
		local var_707_1 = manager.audio:GetLocalizationFlag()

		if var_707_0[var_707_1] ~= nil then
			arg_707_1.duration_ = var_707_0[var_707_1]
		end

		SetActive(arg_707_1.tipsGo_, false)

		function arg_707_1.onSingleLineFinish_()
			arg_707_1.onSingleLineUpdate_ = nil
			arg_707_1.onSingleLineFinish_ = nil
			arg_707_1.state_ = "waiting"
		end

		function arg_707_1.playNext_(arg_709_0)
			if arg_709_0 == 1 then
				arg_707_0:Play115311173(arg_707_1)
			end
		end

		function arg_707_1.onSingleLineUpdate_(arg_710_0)
			local var_710_0 = arg_707_1.actors_["10030"].transform
			local var_710_1 = 0

			if var_710_1 < arg_707_1.time_ and arg_707_1.time_ <= var_710_1 + arg_710_0 then
				arg_707_1.var_.moveOldPos10030 = var_710_0.localPosition
				var_710_0.localScale = Vector3.New(1, 1, 1)

				arg_707_1:CheckSpriteTmpPos("10030", 3)

				local var_710_2 = var_710_0.childCount

				for iter_710_0 = 0, var_710_2 - 1 do
					local var_710_3 = var_710_0:GetChild(iter_710_0)

					if var_710_3.name == "split_2" or not string.find(var_710_3.name, "split") then
						var_710_3.gameObject:SetActive(true)
					else
						var_710_3.gameObject:SetActive(false)
					end
				end
			end

			local var_710_4 = 0.001

			if var_710_1 <= arg_707_1.time_ and arg_707_1.time_ < var_710_1 + var_710_4 then
				local var_710_5 = (arg_707_1.time_ - var_710_1) / var_710_4
				local var_710_6 = Vector3.New(0, -390, 150)

				var_710_0.localPosition = Vector3.Lerp(arg_707_1.var_.moveOldPos10030, var_710_6, var_710_5)
			end

			if arg_707_1.time_ >= var_710_1 + var_710_4 and arg_707_1.time_ < var_710_1 + var_710_4 + arg_710_0 then
				var_710_0.localPosition = Vector3.New(0, -390, 150)
			end

			local var_710_7 = arg_707_1.actors_["10030"]
			local var_710_8 = 0

			if var_710_8 < arg_707_1.time_ and arg_707_1.time_ <= var_710_8 + arg_710_0 and not isNil(var_710_7) and arg_707_1.var_.actorSpriteComps10030 == nil then
				arg_707_1.var_.actorSpriteComps10030 = var_710_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_710_9 = 0.2

			if var_710_8 <= arg_707_1.time_ and arg_707_1.time_ < var_710_8 + var_710_9 and not isNil(var_710_7) then
				local var_710_10 = (arg_707_1.time_ - var_710_8) / var_710_9

				if arg_707_1.var_.actorSpriteComps10030 then
					for iter_710_1, iter_710_2 in pairs(arg_707_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_710_2 then
							if arg_707_1.isInRecall_ then
								local var_710_11 = Mathf.Lerp(iter_710_2.color.r, arg_707_1.hightColor1.r, var_710_10)
								local var_710_12 = Mathf.Lerp(iter_710_2.color.g, arg_707_1.hightColor1.g, var_710_10)
								local var_710_13 = Mathf.Lerp(iter_710_2.color.b, arg_707_1.hightColor1.b, var_710_10)

								iter_710_2.color = Color.New(var_710_11, var_710_12, var_710_13)
							else
								local var_710_14 = Mathf.Lerp(iter_710_2.color.r, 1, var_710_10)

								iter_710_2.color = Color.New(var_710_14, var_710_14, var_710_14)
							end
						end
					end
				end
			end

			if arg_707_1.time_ >= var_710_8 + var_710_9 and arg_707_1.time_ < var_710_8 + var_710_9 + arg_710_0 and not isNil(var_710_7) and arg_707_1.var_.actorSpriteComps10030 then
				for iter_710_3, iter_710_4 in pairs(arg_707_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_710_4 then
						if arg_707_1.isInRecall_ then
							iter_710_4.color = arg_707_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_710_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_707_1.var_.actorSpriteComps10030 = nil
			end

			local var_710_15 = arg_707_1.actors_["10030"]
			local var_710_16 = 0

			if var_710_16 < arg_707_1.time_ and arg_707_1.time_ <= var_710_16 + arg_710_0 then
				local var_710_17 = var_710_15:GetComponentInChildren(typeof(CanvasGroup))

				if var_710_17 then
					arg_707_1.var_.alphaOldValue10030 = var_710_17.alpha
					arg_707_1.var_.characterEffect10030 = var_710_17
				end

				arg_707_1.var_.alphaOldValue10030 = 0
			end

			local var_710_18 = 0.5

			if var_710_16 <= arg_707_1.time_ and arg_707_1.time_ < var_710_16 + var_710_18 then
				local var_710_19 = (arg_707_1.time_ - var_710_16) / var_710_18
				local var_710_20 = Mathf.Lerp(arg_707_1.var_.alphaOldValue10030, 1, var_710_19)

				if arg_707_1.var_.characterEffect10030 then
					arg_707_1.var_.characterEffect10030.alpha = var_710_20
				end
			end

			if arg_707_1.time_ >= var_710_16 + var_710_18 and arg_707_1.time_ < var_710_16 + var_710_18 + arg_710_0 and arg_707_1.var_.characterEffect10030 then
				arg_707_1.var_.characterEffect10030.alpha = 1
			end

			local var_710_21 = 0
			local var_710_22 = 0.25

			if var_710_21 < arg_707_1.time_ and arg_707_1.time_ <= var_710_21 + arg_710_0 then
				arg_707_1.talkMaxDuration = 0
				arg_707_1.dialogCg_.alpha = 1

				arg_707_1.dialog_:SetActive(true)
				SetActive(arg_707_1.leftNameGo_, true)

				local var_710_23 = arg_707_1:FormatText(StoryNameCfg[309].name)

				arg_707_1.leftNameTxt_.text = var_710_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_707_1.leftNameTxt_.transform)

				arg_707_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_707_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_707_1:RecordName(arg_707_1.leftNameTxt_.text)
				SetActive(arg_707_1.iconTrs_.gameObject, false)
				arg_707_1.callingController_:SetSelectedState("normal")

				local var_710_24 = arg_707_1:GetWordFromCfg(115311172)
				local var_710_25 = arg_707_1:FormatText(var_710_24.content)

				arg_707_1.text_.text = var_710_25

				LuaForUtil.ClearLinePrefixSymbol(arg_707_1.text_)

				local var_710_26 = 10
				local var_710_27 = utf8.len(var_710_25)
				local var_710_28 = var_710_26 <= 0 and var_710_22 or var_710_22 * (var_710_27 / var_710_26)

				if var_710_28 > 0 and var_710_22 < var_710_28 then
					arg_707_1.talkMaxDuration = var_710_28

					if var_710_28 + var_710_21 > arg_707_1.duration_ then
						arg_707_1.duration_ = var_710_28 + var_710_21
					end
				end

				arg_707_1.text_.text = var_710_25
				arg_707_1.typewritter.percent = 0

				arg_707_1.typewritter:SetDirty()
				arg_707_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311172", "story_v_out_115311.awb") ~= 0 then
					local var_710_29 = manager.audio:GetVoiceLength("story_v_out_115311", "115311172", "story_v_out_115311.awb") / 1000

					if var_710_29 + var_710_21 > arg_707_1.duration_ then
						arg_707_1.duration_ = var_710_29 + var_710_21
					end

					if var_710_24.prefab_name ~= "" and arg_707_1.actors_[var_710_24.prefab_name] ~= nil then
						local var_710_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_707_1.actors_[var_710_24.prefab_name].transform, "story_v_out_115311", "115311172", "story_v_out_115311.awb")

						arg_707_1:RecordAudio("115311172", var_710_30)
						arg_707_1:RecordAudio("115311172", var_710_30)
					else
						arg_707_1:AudioAction("play", "voice", "story_v_out_115311", "115311172", "story_v_out_115311.awb")
					end

					arg_707_1:RecordHistoryTalkVoice("story_v_out_115311", "115311172", "story_v_out_115311.awb")
				end

				arg_707_1:RecordContent(arg_707_1.text_.text)
			end

			local var_710_31 = math.max(var_710_22, arg_707_1.talkMaxDuration)

			if var_710_21 <= arg_707_1.time_ and arg_707_1.time_ < var_710_21 + var_710_31 then
				arg_707_1.typewritter.percent = (arg_707_1.time_ - var_710_21) / var_710_31

				arg_707_1.typewritter:SetDirty()
			end

			if arg_707_1.time_ >= var_710_21 + var_710_31 and arg_707_1.time_ < var_710_21 + var_710_31 + arg_710_0 then
				arg_707_1.typewritter.percent = 1

				arg_707_1.typewritter:SetDirty()
				arg_707_1:ShowNextGo(true)
			end
		end

		arg_707_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10030",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_707_1:InitPlayNodeList()
	end,
	Play115311173 = function(arg_711_0, arg_711_1)
		arg_711_1.time_ = 0
		arg_711_1.frameCnt_ = 0
		arg_711_1.state_ = "playing"
		arg_711_1.curTalkId_ = 115311173
		arg_711_1.duration_ = 4.5

		SetActive(arg_711_1.tipsGo_, false)

		function arg_711_1.onSingleLineFinish_()
			arg_711_1.onSingleLineUpdate_ = nil
			arg_711_1.onSingleLineFinish_ = nil
			arg_711_1.state_ = "waiting"
		end

		function arg_711_1.playNext_(arg_713_0)
			if arg_713_0 == 1 then
				arg_711_0:Play115311174(arg_711_1)
			end
		end

		function arg_711_1.onSingleLineUpdate_(arg_714_0)
			local var_714_0 = arg_711_1.actors_["10030"].transform
			local var_714_1 = 1.966

			if var_714_1 < arg_711_1.time_ and arg_711_1.time_ <= var_714_1 + arg_714_0 then
				arg_711_1.var_.moveOldPos10030 = var_714_0.localPosition
				var_714_0.localScale = Vector3.New(1, 1, 1)

				arg_711_1:CheckSpriteTmpPos("10030", 7)

				local var_714_2 = var_714_0.childCount

				for iter_714_0 = 0, var_714_2 - 1 do
					local var_714_3 = var_714_0:GetChild(iter_714_0)

					if var_714_3.name == "split_2" or not string.find(var_714_3.name, "split") then
						var_714_3.gameObject:SetActive(true)
					else
						var_714_3.gameObject:SetActive(false)
					end
				end
			end

			local var_714_4 = 0.001

			if var_714_1 <= arg_711_1.time_ and arg_711_1.time_ < var_714_1 + var_714_4 then
				local var_714_5 = (arg_711_1.time_ - var_714_1) / var_714_4
				local var_714_6 = Vector3.New(0, -2000, 150)

				var_714_0.localPosition = Vector3.Lerp(arg_711_1.var_.moveOldPos10030, var_714_6, var_714_5)
			end

			if arg_711_1.time_ >= var_714_1 + var_714_4 and arg_711_1.time_ < var_714_1 + var_714_4 + arg_714_0 then
				var_714_0.localPosition = Vector3.New(0, -2000, 150)
			end

			local var_714_7 = 0

			if var_714_7 < arg_711_1.time_ and arg_711_1.time_ <= var_714_7 + arg_714_0 then
				arg_711_1.mask_.enabled = true
				arg_711_1.mask_.raycastTarget = true

				arg_711_1:SetGaussion(false)
			end

			local var_714_8 = 2

			if var_714_7 <= arg_711_1.time_ and arg_711_1.time_ < var_714_7 + var_714_8 then
				local var_714_9 = (arg_711_1.time_ - var_714_7) / var_714_8
				local var_714_10 = Color.New(0, 0, 0)

				var_714_10.a = Mathf.Lerp(0, 1, var_714_9)
				arg_711_1.mask_.color = var_714_10
			end

			if arg_711_1.time_ >= var_714_7 + var_714_8 and arg_711_1.time_ < var_714_7 + var_714_8 + arg_714_0 then
				local var_714_11 = Color.New(0, 0, 0)

				var_714_11.a = 1
				arg_711_1.mask_.color = var_714_11
			end

			local var_714_12 = 2

			if var_714_12 < arg_711_1.time_ and arg_711_1.time_ <= var_714_12 + arg_714_0 then
				arg_711_1.mask_.enabled = true
				arg_711_1.mask_.raycastTarget = true

				arg_711_1:SetGaussion(false)
			end

			local var_714_13 = 2

			if var_714_12 <= arg_711_1.time_ and arg_711_1.time_ < var_714_12 + var_714_13 then
				local var_714_14 = (arg_711_1.time_ - var_714_12) / var_714_13
				local var_714_15 = Color.New(0, 0, 0)

				var_714_15.a = Mathf.Lerp(1, 0, var_714_14)
				arg_711_1.mask_.color = var_714_15
			end

			if arg_711_1.time_ >= var_714_12 + var_714_13 and arg_711_1.time_ < var_714_12 + var_714_13 + arg_714_0 then
				local var_714_16 = Color.New(0, 0, 0)
				local var_714_17 = 0

				arg_711_1.mask_.enabled = false
				var_714_16.a = var_714_17
				arg_711_1.mask_.color = var_714_16
			end

			local var_714_18 = 2

			if var_714_18 < arg_711_1.time_ and arg_711_1.time_ <= var_714_18 + arg_714_0 then
				arg_711_1.fswbg_:SetActive(true)
				arg_711_1.dialog_:SetActive(false)

				arg_711_1.fswtw_.percent = 0

				local var_714_19 = arg_711_1:GetWordFromCfg(115311173)
				local var_714_20 = arg_711_1:FormatText(var_714_19.content)

				arg_711_1.fswt_.text = var_714_20

				LuaForUtil.ClearLinePrefixSymbol(arg_711_1.fswt_)

				arg_711_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_711_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_711_1.fswtw_:SetDirty()

				arg_711_1.typewritterCharCountI18N = 0

				SetActive(arg_711_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_711_1:ShowNextGo(false)
			end

			local var_714_21 = 2.01666666666667

			if var_714_21 < arg_711_1.time_ and arg_711_1.time_ <= var_714_21 + arg_714_0 then
				arg_711_1.var_.oldValueTypewriter = arg_711_1.fswtw_.percent

				SetActive(arg_711_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_711_1:ShowNextGo(false)
			end

			local var_714_22 = 22
			local var_714_23 = 1.46666666666667
			local var_714_24 = arg_711_1:GetWordFromCfg(115311173)
			local var_714_25 = arg_711_1:FormatText(var_714_24.content)
			local var_714_26, var_714_27 = arg_711_1:GetPercentByPara(var_714_25, 1)

			if var_714_21 < arg_711_1.time_ and arg_711_1.time_ <= var_714_21 + arg_714_0 then
				arg_711_1.talkMaxDuration = 0

				local var_714_28 = var_714_22 <= 0 and var_714_23 or var_714_23 * ((var_714_27 - arg_711_1.typewritterCharCountI18N) / var_714_22)

				if var_714_28 > 0 and var_714_23 < var_714_28 then
					arg_711_1.talkMaxDuration = var_714_28

					if var_714_28 + var_714_21 > arg_711_1.duration_ then
						arg_711_1.duration_ = var_714_28 + var_714_21
					end
				end
			end

			local var_714_29 = 1.46666666666667
			local var_714_30 = math.max(var_714_29, arg_711_1.talkMaxDuration)

			if var_714_21 <= arg_711_1.time_ and arg_711_1.time_ < var_714_21 + var_714_30 then
				local var_714_31 = (arg_711_1.time_ - var_714_21) / var_714_30

				arg_711_1.fswtw_.percent = Mathf.Lerp(arg_711_1.var_.oldValueTypewriter, var_714_26, var_714_31)
				arg_711_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_711_1.fswtw_:SetDirty()
			end

			if arg_711_1.time_ >= var_714_21 + var_714_30 and arg_711_1.time_ < var_714_21 + var_714_30 + arg_714_0 then
				arg_711_1.fswtw_.percent = var_714_26

				arg_711_1.fswtw_:SetDirty()
				arg_711_1:ShowNextGo(true)

				arg_711_1.typewritterCharCountI18N = var_714_27
			end

			local var_714_32 = 2

			if var_714_32 < arg_711_1.time_ and arg_711_1.time_ <= var_714_32 + arg_714_0 then
				local var_714_33 = arg_711_1.fswbg_.transform:Find("textbox/adapt/content") or arg_711_1.fswbg_.transform:Find("textbox/content")
				local var_714_34 = arg_711_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_714_35 = var_714_33:GetComponent("Text")
				local var_714_36 = var_714_33:GetComponent("RectTransform")

				var_714_35.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_714_36.offsetMin = Vector2.New(0, 0)
				var_714_36.offsetMax = Vector2.New(0, 0)
			end

			local var_714_37 = 2.01666666666667

			if var_714_37 < arg_711_1.time_ and arg_711_1.time_ <= var_714_37 + arg_714_0 then
				local var_714_38 = manager.ui.mainCamera.transform.localPosition
				local var_714_39 = Vector3.New(0, 0, 10) + Vector3.New(var_714_38.x, var_714_38.y, 0)
				local var_714_40 = arg_711_1.bgs_.ST22a

				var_714_40.transform.localPosition = var_714_39
				var_714_40.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_714_41 = var_714_40:GetComponent("SpriteRenderer")

				if var_714_41 and var_714_41.sprite then
					local var_714_42 = (var_714_40.transform.localPosition - var_714_38).z
					local var_714_43 = manager.ui.mainCameraCom_
					local var_714_44 = 2 * var_714_42 * Mathf.Tan(var_714_43.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_714_45 = var_714_44 * var_714_43.aspect
					local var_714_46 = var_714_41.sprite.bounds.size.x
					local var_714_47 = var_714_41.sprite.bounds.size.y
					local var_714_48 = var_714_45 / var_714_46
					local var_714_49 = var_714_44 / var_714_47
					local var_714_50 = var_714_49 < var_714_48 and var_714_48 or var_714_49

					var_714_40.transform.localScale = Vector3.New(var_714_50, var_714_50, 0)
				end

				for iter_714_1, iter_714_2 in pairs(arg_711_1.bgs_) do
					if iter_714_1 ~= "ST22a" then
						iter_714_2.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end
		end

		arg_711_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10030",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_711_1:InitPlayNodeList()
	end,
	Play115311174 = function(arg_715_0, arg_715_1)
		arg_715_1.time_ = 0
		arg_715_1.frameCnt_ = 0
		arg_715_1.state_ = "playing"
		arg_715_1.curTalkId_ = 115311174
		arg_715_1.duration_ = 1

		SetActive(arg_715_1.tipsGo_, false)

		function arg_715_1.onSingleLineFinish_()
			arg_715_1.onSingleLineUpdate_ = nil
			arg_715_1.onSingleLineFinish_ = nil
			arg_715_1.state_ = "waiting"
		end

		function arg_715_1.playNext_(arg_717_0)
			if arg_717_0 == 1 then
				arg_715_0:Play115311175(arg_715_1)
			end
		end

		function arg_715_1.onSingleLineUpdate_(arg_718_0)
			local var_718_0 = 0

			if var_718_0 < arg_715_1.time_ and arg_715_1.time_ <= var_718_0 + arg_718_0 then
				arg_715_1.var_.oldValueTypewriter = arg_715_1.fswtw_.percent

				SetActive(arg_715_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_715_1:ShowNextGo(false)
			end

			local var_718_1 = 10
			local var_718_2 = 0.666666666666667
			local var_718_3 = arg_715_1:GetWordFromCfg(115311173)
			local var_718_4 = arg_715_1:FormatText(var_718_3.content)
			local var_718_5, var_718_6 = arg_715_1:GetPercentByPara(var_718_4, 2)

			if var_718_0 < arg_715_1.time_ and arg_715_1.time_ <= var_718_0 + arg_718_0 then
				arg_715_1.talkMaxDuration = 0

				local var_718_7 = var_718_1 <= 0 and var_718_2 or var_718_2 * ((var_718_6 - arg_715_1.typewritterCharCountI18N) / var_718_1)

				if var_718_7 > 0 and var_718_2 < var_718_7 then
					arg_715_1.talkMaxDuration = var_718_7

					if var_718_7 + var_718_0 > arg_715_1.duration_ then
						arg_715_1.duration_ = var_718_7 + var_718_0
					end
				end
			end

			local var_718_8 = 0.666666666666667
			local var_718_9 = math.max(var_718_8, arg_715_1.talkMaxDuration)

			if var_718_0 <= arg_715_1.time_ and arg_715_1.time_ < var_718_0 + var_718_9 then
				local var_718_10 = (arg_715_1.time_ - var_718_0) / var_718_9

				arg_715_1.fswtw_.percent = Mathf.Lerp(arg_715_1.var_.oldValueTypewriter, var_718_5, var_718_10)
				arg_715_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_715_1.fswtw_:SetDirty()
			end

			if arg_715_1.time_ >= var_718_0 + var_718_9 and arg_715_1.time_ < var_718_0 + var_718_9 + arg_718_0 then
				arg_715_1.fswtw_.percent = var_718_5

				arg_715_1.fswtw_:SetDirty()
				arg_715_1:ShowNextGo(true)

				arg_715_1.typewritterCharCountI18N = var_718_6
			end
		end

		arg_715_1.nodeConfigList_ = {}

		arg_715_1:InitPlayNodeList()
	end,
	Play115311175 = function(arg_719_0, arg_719_1)
		arg_719_1.time_ = 0
		arg_719_1.frameCnt_ = 0
		arg_719_1.state_ = "playing"
		arg_719_1.curTalkId_ = 115311175
		arg_719_1.duration_ = 2.95

		SetActive(arg_719_1.tipsGo_, false)

		function arg_719_1.onSingleLineFinish_()
			arg_719_1.onSingleLineUpdate_ = nil
			arg_719_1.onSingleLineFinish_ = nil
			arg_719_1.state_ = "waiting"
		end

		function arg_719_1.playNext_(arg_721_0)
			if arg_721_0 == 1 then
				arg_719_0:Play115311176(arg_719_1)
			end
		end

		function arg_719_1.onSingleLineUpdate_(arg_722_0)
			local var_722_0 = 2

			if var_722_0 < arg_719_1.time_ and arg_719_1.time_ <= var_722_0 + arg_722_0 then
				arg_719_1.fswbg_:SetActive(true)
				arg_719_1.dialog_:SetActive(false)

				arg_719_1.fswtw_.percent = 0

				local var_722_1 = arg_719_1:GetWordFromCfg(115311175)
				local var_722_2 = arg_719_1:FormatText(var_722_1.content)

				arg_719_1.fswt_.text = var_722_2

				LuaForUtil.ClearLinePrefixSymbol(arg_719_1.fswt_)

				arg_719_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_719_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_719_1.fswtw_:SetDirty()

				arg_719_1.typewritterCharCountI18N = 0

				SetActive(arg_719_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_719_1:ShowNextGo(false)
			end

			local var_722_3 = 2.01666666666667

			if var_722_3 < arg_719_1.time_ and arg_719_1.time_ <= var_722_3 + arg_722_0 then
				arg_719_1.var_.oldValueTypewriter = arg_719_1.fswtw_.percent

				SetActive(arg_719_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_719_1:ShowNextGo(false)
			end

			local var_722_4 = 14
			local var_722_5 = 0.933333333333333
			local var_722_6 = arg_719_1:GetWordFromCfg(115311175)
			local var_722_7 = arg_719_1:FormatText(var_722_6.content)
			local var_722_8, var_722_9 = arg_719_1:GetPercentByPara(var_722_7, 1)

			if var_722_3 < arg_719_1.time_ and arg_719_1.time_ <= var_722_3 + arg_722_0 then
				arg_719_1.talkMaxDuration = 0

				local var_722_10 = var_722_4 <= 0 and var_722_5 or var_722_5 * ((var_722_9 - arg_719_1.typewritterCharCountI18N) / var_722_4)

				if var_722_10 > 0 and var_722_5 < var_722_10 then
					arg_719_1.talkMaxDuration = var_722_10

					if var_722_10 + var_722_3 > arg_719_1.duration_ then
						arg_719_1.duration_ = var_722_10 + var_722_3
					end
				end
			end

			local var_722_11 = 0.933333333333333
			local var_722_12 = math.max(var_722_11, arg_719_1.talkMaxDuration)

			if var_722_3 <= arg_719_1.time_ and arg_719_1.time_ < var_722_3 + var_722_12 then
				local var_722_13 = (arg_719_1.time_ - var_722_3) / var_722_12

				arg_719_1.fswtw_.percent = Mathf.Lerp(arg_719_1.var_.oldValueTypewriter, var_722_8, var_722_13)
				arg_719_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_719_1.fswtw_:SetDirty()
			end

			if arg_719_1.time_ >= var_722_3 + var_722_12 and arg_719_1.time_ < var_722_3 + var_722_12 + arg_722_0 then
				arg_719_1.fswtw_.percent = var_722_8

				arg_719_1.fswtw_:SetDirty()
				arg_719_1:ShowNextGo(true)

				arg_719_1.typewritterCharCountI18N = var_722_9
			end

			local var_722_14 = arg_719_1.bgs_.ST22a
			local var_722_15 = 0

			if var_722_15 < arg_719_1.time_ and arg_719_1.time_ <= var_722_15 + arg_722_0 then
				local var_722_16 = var_722_14:GetComponent("SpriteRenderer")

				if var_722_16 then
					arg_719_1.var_.alphaOldValueST22a = var_722_16.color.a
					arg_719_1.var_.alphaMatValueST22a = var_722_16
				end

				arg_719_1.var_.alphaOldValueST22a = 1
			end

			local var_722_17 = 2

			if var_722_15 <= arg_719_1.time_ and arg_719_1.time_ < var_722_15 + var_722_17 then
				local var_722_18 = (arg_719_1.time_ - var_722_15) / var_722_17
				local var_722_19 = Mathf.Lerp(arg_719_1.var_.alphaOldValueST22a, 0, var_722_18)

				if arg_719_1.var_.alphaMatValueST22a then
					local var_722_20 = arg_719_1.var_.alphaMatValueST22a.color

					var_722_20.a = var_722_19
					arg_719_1.var_.alphaMatValueST22a.color = var_722_20
				end
			end

			if arg_719_1.time_ >= var_722_15 + var_722_17 and arg_719_1.time_ < var_722_15 + var_722_17 + arg_722_0 and arg_719_1.var_.alphaMatValueST22a then
				local var_722_21 = arg_719_1.var_.alphaMatValueST22a
				local var_722_22 = var_722_21.color

				var_722_22.a = 0
				var_722_21.color = var_722_22
			end
		end

		arg_719_1.nodeConfigList_ = {}

		arg_719_1:InitPlayNodeList()
	end,
	Play115311176 = function(arg_723_0, arg_723_1)
		arg_723_1.time_ = 0
		arg_723_1.frameCnt_ = 0
		arg_723_1.state_ = "playing"
		arg_723_1.curTalkId_ = 115311176
		arg_723_1.duration_ = 1

		SetActive(arg_723_1.tipsGo_, false)

		function arg_723_1.onSingleLineFinish_()
			arg_723_1.onSingleLineUpdate_ = nil
			arg_723_1.onSingleLineFinish_ = nil
			arg_723_1.state_ = "waiting"
		end

		function arg_723_1.playNext_(arg_725_0)
			if arg_725_0 == 1 then
				arg_723_0:Play115311177(arg_723_1)
			end
		end

		function arg_723_1.onSingleLineUpdate_(arg_726_0)
			local var_726_0 = 0

			if var_726_0 < arg_723_1.time_ and arg_723_1.time_ <= var_726_0 + arg_726_0 then
				arg_723_1.var_.oldValueTypewriter = arg_723_1.fswtw_.percent

				SetActive(arg_723_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_723_1:ShowNextGo(false)
			end

			local var_726_1 = 14
			local var_726_2 = 0.933333333333333
			local var_726_3 = arg_723_1:GetWordFromCfg(115311175)
			local var_726_4 = arg_723_1:FormatText(var_726_3.content)
			local var_726_5, var_726_6 = arg_723_1:GetPercentByPara(var_726_4, 2)

			if var_726_0 < arg_723_1.time_ and arg_723_1.time_ <= var_726_0 + arg_726_0 then
				arg_723_1.talkMaxDuration = 0

				local var_726_7 = var_726_1 <= 0 and var_726_2 or var_726_2 * ((var_726_6 - arg_723_1.typewritterCharCountI18N) / var_726_1)

				if var_726_7 > 0 and var_726_2 < var_726_7 then
					arg_723_1.talkMaxDuration = var_726_7

					if var_726_7 + var_726_0 > arg_723_1.duration_ then
						arg_723_1.duration_ = var_726_7 + var_726_0
					end
				end
			end

			local var_726_8 = 0.933333333333333
			local var_726_9 = math.max(var_726_8, arg_723_1.talkMaxDuration)

			if var_726_0 <= arg_723_1.time_ and arg_723_1.time_ < var_726_0 + var_726_9 then
				local var_726_10 = (arg_723_1.time_ - var_726_0) / var_726_9

				arg_723_1.fswtw_.percent = Mathf.Lerp(arg_723_1.var_.oldValueTypewriter, var_726_5, var_726_10)
				arg_723_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_723_1.fswtw_:SetDirty()
			end

			if arg_723_1.time_ >= var_726_0 + var_726_9 and arg_723_1.time_ < var_726_0 + var_726_9 + arg_726_0 then
				arg_723_1.fswtw_.percent = var_726_5

				arg_723_1.fswtw_:SetDirty()
				arg_723_1:ShowNextGo(true)

				arg_723_1.typewritterCharCountI18N = var_726_6
			end
		end

		arg_723_1.nodeConfigList_ = {}

		arg_723_1:InitPlayNodeList()
	end,
	Play115311177 = function(arg_727_0, arg_727_1)
		arg_727_1.time_ = 0
		arg_727_1.frameCnt_ = 0
		arg_727_1.state_ = "playing"
		arg_727_1.curTalkId_ = 115311177
		arg_727_1.duration_ = 1

		SetActive(arg_727_1.tipsGo_, false)

		function arg_727_1.onSingleLineFinish_()
			arg_727_1.onSingleLineUpdate_ = nil
			arg_727_1.onSingleLineFinish_ = nil
			arg_727_1.state_ = "waiting"
		end

		function arg_727_1.playNext_(arg_729_0)
			if arg_729_0 == 1 then
				arg_727_0:Play115311178(arg_727_1)
			end
		end

		function arg_727_1.onSingleLineUpdate_(arg_730_0)
			local var_730_0 = 0

			if var_730_0 < arg_727_1.time_ and arg_727_1.time_ <= var_730_0 + arg_730_0 then
				arg_727_1.var_.oldValueTypewriter = arg_727_1.fswtw_.percent

				SetActive(arg_727_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_727_1:ShowNextGo(false)
			end

			local var_730_1 = 14
			local var_730_2 = 0.933333333333333
			local var_730_3 = arg_727_1:GetWordFromCfg(115311175)
			local var_730_4 = arg_727_1:FormatText(var_730_3.content)
			local var_730_5, var_730_6 = arg_727_1:GetPercentByPara(var_730_4, 3)

			if var_730_0 < arg_727_1.time_ and arg_727_1.time_ <= var_730_0 + arg_730_0 then
				arg_727_1.talkMaxDuration = 0

				local var_730_7 = var_730_1 <= 0 and var_730_2 or var_730_2 * ((var_730_6 - arg_727_1.typewritterCharCountI18N) / var_730_1)

				if var_730_7 > 0 and var_730_2 < var_730_7 then
					arg_727_1.talkMaxDuration = var_730_7

					if var_730_7 + var_730_0 > arg_727_1.duration_ then
						arg_727_1.duration_ = var_730_7 + var_730_0
					end
				end
			end

			local var_730_8 = 0.933333333333333
			local var_730_9 = math.max(var_730_8, arg_727_1.talkMaxDuration)

			if var_730_0 <= arg_727_1.time_ and arg_727_1.time_ < var_730_0 + var_730_9 then
				local var_730_10 = (arg_727_1.time_ - var_730_0) / var_730_9

				arg_727_1.fswtw_.percent = Mathf.Lerp(arg_727_1.var_.oldValueTypewriter, var_730_5, var_730_10)
				arg_727_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_727_1.fswtw_:SetDirty()
			end

			if arg_727_1.time_ >= var_730_0 + var_730_9 and arg_727_1.time_ < var_730_0 + var_730_9 + arg_730_0 then
				arg_727_1.fswtw_.percent = var_730_5

				arg_727_1.fswtw_:SetDirty()
				arg_727_1:ShowNextGo(true)

				arg_727_1.typewritterCharCountI18N = var_730_6
			end
		end

		arg_727_1.nodeConfigList_ = {}

		arg_727_1:InitPlayNodeList()
	end,
	Play115311178 = function(arg_731_0, arg_731_1)
		arg_731_1.time_ = 0
		arg_731_1.frameCnt_ = 0
		arg_731_1.state_ = "playing"
		arg_731_1.curTalkId_ = 115311178
		arg_731_1.duration_ = 1

		SetActive(arg_731_1.tipsGo_, false)

		function arg_731_1.onSingleLineFinish_()
			arg_731_1.onSingleLineUpdate_ = nil
			arg_731_1.onSingleLineFinish_ = nil
			arg_731_1.state_ = "waiting"
		end

		function arg_731_1.playNext_(arg_733_0)
			if arg_733_0 == 1 then
				arg_731_0:Play115311179(arg_731_1)
			end
		end

		function arg_731_1.onSingleLineUpdate_(arg_734_0)
			local var_734_0 = 0

			if var_734_0 < arg_731_1.time_ and arg_731_1.time_ <= var_734_0 + arg_734_0 then
				arg_731_1.var_.oldValueTypewriter = arg_731_1.fswtw_.percent

				SetActive(arg_731_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_731_1:ShowNextGo(false)
			end

			local var_734_1 = 14
			local var_734_2 = 0.933333333333333
			local var_734_3 = arg_731_1:GetWordFromCfg(115311175)
			local var_734_4 = arg_731_1:FormatText(var_734_3.content)
			local var_734_5, var_734_6 = arg_731_1:GetPercentByPara(var_734_4, 4)

			if var_734_0 < arg_731_1.time_ and arg_731_1.time_ <= var_734_0 + arg_734_0 then
				arg_731_1.talkMaxDuration = 0

				local var_734_7 = var_734_1 <= 0 and var_734_2 or var_734_2 * ((var_734_6 - arg_731_1.typewritterCharCountI18N) / var_734_1)

				if var_734_7 > 0 and var_734_2 < var_734_7 then
					arg_731_1.talkMaxDuration = var_734_7

					if var_734_7 + var_734_0 > arg_731_1.duration_ then
						arg_731_1.duration_ = var_734_7 + var_734_0
					end
				end
			end

			local var_734_8 = 0.933333333333333
			local var_734_9 = math.max(var_734_8, arg_731_1.talkMaxDuration)

			if var_734_0 <= arg_731_1.time_ and arg_731_1.time_ < var_734_0 + var_734_9 then
				local var_734_10 = (arg_731_1.time_ - var_734_0) / var_734_9

				arg_731_1.fswtw_.percent = Mathf.Lerp(arg_731_1.var_.oldValueTypewriter, var_734_5, var_734_10)
				arg_731_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_731_1.fswtw_:SetDirty()
			end

			if arg_731_1.time_ >= var_734_0 + var_734_9 and arg_731_1.time_ < var_734_0 + var_734_9 + arg_734_0 then
				arg_731_1.fswtw_.percent = var_734_5

				arg_731_1.fswtw_:SetDirty()
				arg_731_1:ShowNextGo(true)

				arg_731_1.typewritterCharCountI18N = var_734_6
			end
		end

		arg_731_1.nodeConfigList_ = {}

		arg_731_1:InitPlayNodeList()
	end,
	Play115311179 = function(arg_735_0, arg_735_1)
		arg_735_1.time_ = 0
		arg_735_1.frameCnt_ = 0
		arg_735_1.state_ = "playing"
		arg_735_1.curTalkId_ = 115311179
		arg_735_1.duration_ = 1

		SetActive(arg_735_1.tipsGo_, false)

		function arg_735_1.onSingleLineFinish_()
			arg_735_1.onSingleLineUpdate_ = nil
			arg_735_1.onSingleLineFinish_ = nil
			arg_735_1.state_ = "waiting"
			arg_735_1.auto_ = false
		end

		function arg_735_1.playNext_(arg_737_0)
			arg_735_1.onStoryFinished_()
		end

		function arg_735_1.onSingleLineUpdate_(arg_738_0)
			local var_738_0 = 0

			if var_738_0 < arg_735_1.time_ and arg_735_1.time_ <= var_738_0 + arg_738_0 then
				arg_735_1.var_.oldValueTypewriter = arg_735_1.fswtw_.percent

				SetActive(arg_735_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_735_1:ShowNextGo(false)
			end

			local var_738_1 = 14
			local var_738_2 = 0.933333333333333
			local var_738_3 = arg_735_1:GetWordFromCfg(115311175)
			local var_738_4 = arg_735_1:FormatText(var_738_3.content)
			local var_738_5, var_738_6 = arg_735_1:GetPercentByPara(var_738_4, 5)

			if var_738_0 < arg_735_1.time_ and arg_735_1.time_ <= var_738_0 + arg_738_0 then
				arg_735_1.talkMaxDuration = 0

				local var_738_7 = var_738_1 <= 0 and var_738_2 or var_738_2 * ((var_738_6 - arg_735_1.typewritterCharCountI18N) / var_738_1)

				if var_738_7 > 0 and var_738_2 < var_738_7 then
					arg_735_1.talkMaxDuration = var_738_7

					if var_738_7 + var_738_0 > arg_735_1.duration_ then
						arg_735_1.duration_ = var_738_7 + var_738_0
					end
				end
			end

			local var_738_8 = 0.933333333333333
			local var_738_9 = math.max(var_738_8, arg_735_1.talkMaxDuration)

			if var_738_0 <= arg_735_1.time_ and arg_735_1.time_ < var_738_0 + var_738_9 then
				local var_738_10 = (arg_735_1.time_ - var_738_0) / var_738_9

				arg_735_1.fswtw_.percent = Mathf.Lerp(arg_735_1.var_.oldValueTypewriter, var_738_5, var_738_10)
				arg_735_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_735_1.fswtw_:SetDirty()
			end

			if arg_735_1.time_ >= var_738_0 + var_738_9 and arg_735_1.time_ < var_738_0 + var_738_9 + arg_738_0 then
				arg_735_1.fswtw_.percent = var_738_5

				arg_735_1.fswtw_:SetDirty()
				arg_735_1:ShowNextGo(true)

				arg_735_1.typewritterCharCountI18N = var_738_6
			end
		end

		arg_735_1.nodeConfigList_ = {}

		arg_735_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST22a",
		"TextureConfig/Background/ST28a",
		"TextureConfig/Background/F01a"
	},
	voices = {
		"story_v_out_115311.awb"
	}
}
