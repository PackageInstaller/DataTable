return {
	Play121561001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 121561001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play121561002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "XH0310"

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
				local var_4_5 = arg_1_1.bgs_.XH0310

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
					if iter_4_0 ~= "XH0310" then
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
			local var_4_23 = 0.0666666666666667

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

			local var_4_28 = 0.133333333333333
			local var_4_29 = 1

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				local var_4_30 = "play"
				local var_4_31 = "music"

				arg_1_1:AudioAction(var_4_30, var_4_31, "bgm_activity_2_1_story_afterbattle", "bgm_activity_2_1_story_afterbattle", "bgm_activity_2_1_story_afterbattle.awb")

				local var_4_32 = ""
				local var_4_33 = manager.audio:GetAudioName("bgm_activity_2_1_story_afterbattle", "bgm_activity_2_1_story_afterbattle")

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
			local var_4_35 = 0.633333333333333

			if var_4_34 < arg_1_1.time_ and arg_1_1.time_ <= var_4_34 + arg_4_0 then
				local var_4_36 = "play"
				local var_4_37 = "effect"

				arg_1_1:AudioAction(var_4_36, var_4_37, "se_story_121_04", "se_story_121_04_final_loop", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_38 = 1.999999999999
			local var_4_39 = 0.525

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

				local var_4_41 = arg_1_1:GetWordFromCfg(121561001)
				local var_4_42 = arg_1_1:FormatText(var_4_41.content)

				arg_1_1.text_.text = var_4_42

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_43 = 21
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
	Play121561002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 121561002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play121561003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0
			local var_12_1 = 1.275

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

				local var_12_2 = arg_9_1:GetWordFromCfg(121561002)
				local var_12_3 = arg_9_1:FormatText(var_12_2.content)

				arg_9_1.text_.text = var_12_3

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_4 = 51
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
	Play121561003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 121561003
		arg_13_1.duration_ = 9.1

		local var_13_0 = {
			ja = 5.433,
			ko = 9.1,
			zh = 9.1
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
				arg_13_0:Play121561004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0
			local var_16_1 = 0.775

			if var_16_0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_2 = arg_13_1:FormatText(StoryNameCfg[319].name)

				arg_13_1.leftNameTxt_.text = var_16_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_3 = arg_13_1:GetWordFromCfg(121561003)
				local var_16_4 = arg_13_1:FormatText(var_16_3.content)

				arg_13_1.text_.text = var_16_4

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_5 = 31
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

				if manager.audio:GetVoiceLength("story_v_out_121561", "121561003", "story_v_out_121561.awb") ~= 0 then
					local var_16_8 = manager.audio:GetVoiceLength("story_v_out_121561", "121561003", "story_v_out_121561.awb") / 1000

					if var_16_8 + var_16_0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_8 + var_16_0
					end

					if var_16_3.prefab_name ~= "" and arg_13_1.actors_[var_16_3.prefab_name] ~= nil then
						local var_16_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_3.prefab_name].transform, "story_v_out_121561", "121561003", "story_v_out_121561.awb")

						arg_13_1:RecordAudio("121561003", var_16_9)
						arg_13_1:RecordAudio("121561003", var_16_9)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_121561", "121561003", "story_v_out_121561.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_121561", "121561003", "story_v_out_121561.awb")
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
	Play121561004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 121561004
		arg_17_1.duration_ = 6.07

		local var_17_0 = {
			ja = 6.066,
			ko = 4.833,
			zh = 4.833
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
				arg_17_0:Play121561005(arg_17_1)
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

				local var_20_2 = arg_17_1:FormatText(StoryNameCfg[389].name)

				arg_17_1.leftNameTxt_.text = var_20_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_3 = arg_17_1:GetWordFromCfg(121561004)
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

				if manager.audio:GetVoiceLength("story_v_out_121561", "121561004", "story_v_out_121561.awb") ~= 0 then
					local var_20_8 = manager.audio:GetVoiceLength("story_v_out_121561", "121561004", "story_v_out_121561.awb") / 1000

					if var_20_8 + var_20_0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_8 + var_20_0
					end

					if var_20_3.prefab_name ~= "" and arg_17_1.actors_[var_20_3.prefab_name] ~= nil then
						local var_20_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_3.prefab_name].transform, "story_v_out_121561", "121561004", "story_v_out_121561.awb")

						arg_17_1:RecordAudio("121561004", var_20_9)
						arg_17_1:RecordAudio("121561004", var_20_9)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_121561", "121561004", "story_v_out_121561.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_121561", "121561004", "story_v_out_121561.awb")
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
	Play121561005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 121561005
		arg_21_1.duration_ = 6.4

		local var_21_0 = {
			ja = 6.4,
			ko = 4.733,
			zh = 4.733
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
				arg_21_0:Play121561006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 0
			local var_24_1 = 0.55

			if var_24_0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_0 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_2 = arg_21_1:FormatText(StoryNameCfg[319].name)

				arg_21_1.leftNameTxt_.text = var_24_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_3 = arg_21_1:GetWordFromCfg(121561005)
				local var_24_4 = arg_21_1:FormatText(var_24_3.content)

				arg_21_1.text_.text = var_24_4

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_5 = 22
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

				if manager.audio:GetVoiceLength("story_v_out_121561", "121561005", "story_v_out_121561.awb") ~= 0 then
					local var_24_8 = manager.audio:GetVoiceLength("story_v_out_121561", "121561005", "story_v_out_121561.awb") / 1000

					if var_24_8 + var_24_0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_8 + var_24_0
					end

					if var_24_3.prefab_name ~= "" and arg_21_1.actors_[var_24_3.prefab_name] ~= nil then
						local var_24_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_3.prefab_name].transform, "story_v_out_121561", "121561005", "story_v_out_121561.awb")

						arg_21_1:RecordAudio("121561005", var_24_9)
						arg_21_1:RecordAudio("121561005", var_24_9)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_121561", "121561005", "story_v_out_121561.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_121561", "121561005", "story_v_out_121561.awb")
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
	Play121561006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 121561006
		arg_25_1.duration_ = 5.7

		local var_25_0 = {
			ja = 5.7,
			ko = 4.266,
			zh = 4.266
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
				arg_25_0:Play121561007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 0
			local var_28_1 = 0.5

			if var_28_0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_0 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_2 = arg_25_1:FormatText(StoryNameCfg[389].name)

				arg_25_1.leftNameTxt_.text = var_28_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_3 = arg_25_1:GetWordFromCfg(121561006)
				local var_28_4 = arg_25_1:FormatText(var_28_3.content)

				arg_25_1.text_.text = var_28_4

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_5 = 20
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

				if manager.audio:GetVoiceLength("story_v_out_121561", "121561006", "story_v_out_121561.awb") ~= 0 then
					local var_28_8 = manager.audio:GetVoiceLength("story_v_out_121561", "121561006", "story_v_out_121561.awb") / 1000

					if var_28_8 + var_28_0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_8 + var_28_0
					end

					if var_28_3.prefab_name ~= "" and arg_25_1.actors_[var_28_3.prefab_name] ~= nil then
						local var_28_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_3.prefab_name].transform, "story_v_out_121561", "121561006", "story_v_out_121561.awb")

						arg_25_1:RecordAudio("121561006", var_28_9)
						arg_25_1:RecordAudio("121561006", var_28_9)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_121561", "121561006", "story_v_out_121561.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_121561", "121561006", "story_v_out_121561.awb")
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
	Play121561007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 121561007
		arg_29_1.duration_ = 9.97

		local var_29_0 = {
			ja = 7.533,
			ko = 9.966,
			zh = 9.966
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
				arg_29_0:Play121561008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 0
			local var_32_1 = 1.3

			if var_32_0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_0 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_2 = arg_29_1:FormatText(StoryNameCfg[319].name)

				arg_29_1.leftNameTxt_.text = var_32_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_3 = arg_29_1:GetWordFromCfg(121561007)
				local var_32_4 = arg_29_1:FormatText(var_32_3.content)

				arg_29_1.text_.text = var_32_4

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_5 = 52
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

				if manager.audio:GetVoiceLength("story_v_out_121561", "121561007", "story_v_out_121561.awb") ~= 0 then
					local var_32_8 = manager.audio:GetVoiceLength("story_v_out_121561", "121561007", "story_v_out_121561.awb") / 1000

					if var_32_8 + var_32_0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_8 + var_32_0
					end

					if var_32_3.prefab_name ~= "" and arg_29_1.actors_[var_32_3.prefab_name] ~= nil then
						local var_32_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_3.prefab_name].transform, "story_v_out_121561", "121561007", "story_v_out_121561.awb")

						arg_29_1:RecordAudio("121561007", var_32_9)
						arg_29_1:RecordAudio("121561007", var_32_9)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_121561", "121561007", "story_v_out_121561.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_121561", "121561007", "story_v_out_121561.awb")
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
	Play121561008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 121561008
		arg_33_1.duration_ = 10.5

		local var_33_0 = {
			ja = 10.2,
			ko = 10.5,
			zh = 10.5
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
				arg_33_0:Play121561009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = 0
			local var_36_1 = 1.15

			if var_36_0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_0 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_2 = arg_33_1:FormatText(StoryNameCfg[319].name)

				arg_33_1.leftNameTxt_.text = var_36_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_3 = arg_33_1:GetWordFromCfg(121561008)
				local var_36_4 = arg_33_1:FormatText(var_36_3.content)

				arg_33_1.text_.text = var_36_4

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_5 = 46
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

				if manager.audio:GetVoiceLength("story_v_out_121561", "121561008", "story_v_out_121561.awb") ~= 0 then
					local var_36_8 = manager.audio:GetVoiceLength("story_v_out_121561", "121561008", "story_v_out_121561.awb") / 1000

					if var_36_8 + var_36_0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_8 + var_36_0
					end

					if var_36_3.prefab_name ~= "" and arg_33_1.actors_[var_36_3.prefab_name] ~= nil then
						local var_36_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_3.prefab_name].transform, "story_v_out_121561", "121561008", "story_v_out_121561.awb")

						arg_33_1:RecordAudio("121561008", var_36_9)
						arg_33_1:RecordAudio("121561008", var_36_9)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_121561", "121561008", "story_v_out_121561.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_121561", "121561008", "story_v_out_121561.awb")
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
	Play121561009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 121561009
		arg_37_1.duration_ = 9.2

		local var_37_0 = {
			ja = 9.2,
			ko = 4.2,
			zh = 4.2
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
				arg_37_0:Play121561010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = 0
			local var_40_1 = 0.4

			if var_40_0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_0 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_2 = arg_37_1:FormatText(StoryNameCfg[319].name)

				arg_37_1.leftNameTxt_.text = var_40_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_3 = arg_37_1:GetWordFromCfg(121561009)
				local var_40_4 = arg_37_1:FormatText(var_40_3.content)

				arg_37_1.text_.text = var_40_4

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_5 = 16
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

				if manager.audio:GetVoiceLength("story_v_out_121561", "121561009", "story_v_out_121561.awb") ~= 0 then
					local var_40_8 = manager.audio:GetVoiceLength("story_v_out_121561", "121561009", "story_v_out_121561.awb") / 1000

					if var_40_8 + var_40_0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_8 + var_40_0
					end

					if var_40_3.prefab_name ~= "" and arg_37_1.actors_[var_40_3.prefab_name] ~= nil then
						local var_40_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_3.prefab_name].transform, "story_v_out_121561", "121561009", "story_v_out_121561.awb")

						arg_37_1:RecordAudio("121561009", var_40_9)
						arg_37_1:RecordAudio("121561009", var_40_9)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_121561", "121561009", "story_v_out_121561.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_121561", "121561009", "story_v_out_121561.awb")
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
	Play121561010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 121561010
		arg_41_1.duration_ = 3.77

		local var_41_0 = {
			ja = 3.766,
			ko = 2.7,
			zh = 2.7
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
				arg_41_0:Play121561011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = 0
			local var_44_1 = 0.125

			if var_44_0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_0 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_2 = arg_41_1:FormatText(StoryNameCfg[389].name)

				arg_41_1.leftNameTxt_.text = var_44_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_3 = arg_41_1:GetWordFromCfg(121561010)
				local var_44_4 = arg_41_1:FormatText(var_44_3.content)

				arg_41_1.text_.text = var_44_4

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_5 = 5
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

				if manager.audio:GetVoiceLength("story_v_out_121561", "121561010", "story_v_out_121561.awb") ~= 0 then
					local var_44_8 = manager.audio:GetVoiceLength("story_v_out_121561", "121561010", "story_v_out_121561.awb") / 1000

					if var_44_8 + var_44_0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_8 + var_44_0
					end

					if var_44_3.prefab_name ~= "" and arg_41_1.actors_[var_44_3.prefab_name] ~= nil then
						local var_44_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_3.prefab_name].transform, "story_v_out_121561", "121561010", "story_v_out_121561.awb")

						arg_41_1:RecordAudio("121561010", var_44_9)
						arg_41_1:RecordAudio("121561010", var_44_9)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_121561", "121561010", "story_v_out_121561.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_121561", "121561010", "story_v_out_121561.awb")
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
	Play121561011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 121561011
		arg_45_1.duration_ = 12.9

		local var_45_0 = {
			ja = 7.466,
			ko = 12.9,
			zh = 12.9
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
				arg_45_0:Play121561012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = 0
			local var_48_1 = 1.425

			if var_48_0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_0 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_2 = arg_45_1:FormatText(StoryNameCfg[319].name)

				arg_45_1.leftNameTxt_.text = var_48_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_3 = arg_45_1:GetWordFromCfg(121561011)
				local var_48_4 = arg_45_1:FormatText(var_48_3.content)

				arg_45_1.text_.text = var_48_4

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_5 = 57
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

				if manager.audio:GetVoiceLength("story_v_out_121561", "121561011", "story_v_out_121561.awb") ~= 0 then
					local var_48_8 = manager.audio:GetVoiceLength("story_v_out_121561", "121561011", "story_v_out_121561.awb") / 1000

					if var_48_8 + var_48_0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_8 + var_48_0
					end

					if var_48_3.prefab_name ~= "" and arg_45_1.actors_[var_48_3.prefab_name] ~= nil then
						local var_48_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_3.prefab_name].transform, "story_v_out_121561", "121561011", "story_v_out_121561.awb")

						arg_45_1:RecordAudio("121561011", var_48_9)
						arg_45_1:RecordAudio("121561011", var_48_9)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_121561", "121561011", "story_v_out_121561.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_121561", "121561011", "story_v_out_121561.awb")
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
	Play121561012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 121561012
		arg_49_1.duration_ = 9.97

		local var_49_0 = {
			ja = 9.966,
			ko = 8.433,
			zh = 8.433
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
				arg_49_0:Play121561013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = 0
			local var_52_1 = 0.75

			if var_52_0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_0 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_2 = arg_49_1:FormatText(StoryNameCfg[319].name)

				arg_49_1.leftNameTxt_.text = var_52_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_3 = arg_49_1:GetWordFromCfg(121561012)
				local var_52_4 = arg_49_1:FormatText(var_52_3.content)

				arg_49_1.text_.text = var_52_4

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_5 = 30
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

				if manager.audio:GetVoiceLength("story_v_out_121561", "121561012", "story_v_out_121561.awb") ~= 0 then
					local var_52_8 = manager.audio:GetVoiceLength("story_v_out_121561", "121561012", "story_v_out_121561.awb") / 1000

					if var_52_8 + var_52_0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_8 + var_52_0
					end

					if var_52_3.prefab_name ~= "" and arg_49_1.actors_[var_52_3.prefab_name] ~= nil then
						local var_52_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_3.prefab_name].transform, "story_v_out_121561", "121561012", "story_v_out_121561.awb")

						arg_49_1:RecordAudio("121561012", var_52_9)
						arg_49_1:RecordAudio("121561012", var_52_9)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_121561", "121561012", "story_v_out_121561.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_121561", "121561012", "story_v_out_121561.awb")
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
	Play121561013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 121561013
		arg_53_1.duration_ = 9.03

		local var_53_0 = {
			ja = 9.033,
			ko = 4,
			zh = 4
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
				arg_53_0:Play121561014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 0
			local var_56_1 = 0.525

			if var_56_0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_0 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_2 = arg_53_1:FormatText(StoryNameCfg[389].name)

				arg_53_1.leftNameTxt_.text = var_56_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_3 = arg_53_1:GetWordFromCfg(121561013)
				local var_56_4 = arg_53_1:FormatText(var_56_3.content)

				arg_53_1.text_.text = var_56_4

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_5 = 21
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

				if manager.audio:GetVoiceLength("story_v_out_121561", "121561013", "story_v_out_121561.awb") ~= 0 then
					local var_56_8 = manager.audio:GetVoiceLength("story_v_out_121561", "121561013", "story_v_out_121561.awb") / 1000

					if var_56_8 + var_56_0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_8 + var_56_0
					end

					if var_56_3.prefab_name ~= "" and arg_53_1.actors_[var_56_3.prefab_name] ~= nil then
						local var_56_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_3.prefab_name].transform, "story_v_out_121561", "121561013", "story_v_out_121561.awb")

						arg_53_1:RecordAudio("121561013", var_56_9)
						arg_53_1:RecordAudio("121561013", var_56_9)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_121561", "121561013", "story_v_out_121561.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_121561", "121561013", "story_v_out_121561.awb")
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
	Play121561014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 121561014
		arg_57_1.duration_ = 5.8

		local var_57_0 = {
			ja = 3.766,
			ko = 5.8,
			zh = 5.8
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
				arg_57_0:Play121561015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = 0
			local var_60_1 = 0.4

			if var_60_0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_0 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_2 = arg_57_1:FormatText(StoryNameCfg[319].name)

				arg_57_1.leftNameTxt_.text = var_60_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_3 = arg_57_1:GetWordFromCfg(121561014)
				local var_60_4 = arg_57_1:FormatText(var_60_3.content)

				arg_57_1.text_.text = var_60_4

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_5 = 16
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

				if manager.audio:GetVoiceLength("story_v_out_121561", "121561014", "story_v_out_121561.awb") ~= 0 then
					local var_60_8 = manager.audio:GetVoiceLength("story_v_out_121561", "121561014", "story_v_out_121561.awb") / 1000

					if var_60_8 + var_60_0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_8 + var_60_0
					end

					if var_60_3.prefab_name ~= "" and arg_57_1.actors_[var_60_3.prefab_name] ~= nil then
						local var_60_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_3.prefab_name].transform, "story_v_out_121561", "121561014", "story_v_out_121561.awb")

						arg_57_1:RecordAudio("121561014", var_60_9)
						arg_57_1:RecordAudio("121561014", var_60_9)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_121561", "121561014", "story_v_out_121561.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_121561", "121561014", "story_v_out_121561.awb")
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
	Play121561015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 121561015
		arg_61_1.duration_ = 11.33

		local var_61_0 = {
			ja = 4.633,
			ko = 11.333,
			zh = 11.333
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
				arg_61_0:Play121561016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = 0
			local var_64_1 = 1.125

			if var_64_0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_0 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_2 = arg_61_1:FormatText(StoryNameCfg[319].name)

				arg_61_1.leftNameTxt_.text = var_64_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_3 = arg_61_1:GetWordFromCfg(121561015)
				local var_64_4 = arg_61_1:FormatText(var_64_3.content)

				arg_61_1.text_.text = var_64_4

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_5 = 45
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

				if manager.audio:GetVoiceLength("story_v_out_121561", "121561015", "story_v_out_121561.awb") ~= 0 then
					local var_64_8 = manager.audio:GetVoiceLength("story_v_out_121561", "121561015", "story_v_out_121561.awb") / 1000

					if var_64_8 + var_64_0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_8 + var_64_0
					end

					if var_64_3.prefab_name ~= "" and arg_61_1.actors_[var_64_3.prefab_name] ~= nil then
						local var_64_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_3.prefab_name].transform, "story_v_out_121561", "121561015", "story_v_out_121561.awb")

						arg_61_1:RecordAudio("121561015", var_64_9)
						arg_61_1:RecordAudio("121561015", var_64_9)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_121561", "121561015", "story_v_out_121561.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_121561", "121561015", "story_v_out_121561.awb")
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
	Play121561016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 121561016
		arg_65_1.duration_ = 5.5

		local var_65_0 = {
			ja = 5.5,
			ko = 4.633,
			zh = 4.633
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
				arg_65_0:Play121561017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = 0
			local var_68_1 = 0.575

			if var_68_0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_0 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				local var_68_2 = arg_65_1:FormatText(StoryNameCfg[319].name)

				arg_65_1.leftNameTxt_.text = var_68_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_3 = arg_65_1:GetWordFromCfg(121561016)
				local var_68_4 = arg_65_1:FormatText(var_68_3.content)

				arg_65_1.text_.text = var_68_4

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_5 = 23
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

				if manager.audio:GetVoiceLength("story_v_out_121561", "121561016", "story_v_out_121561.awb") ~= 0 then
					local var_68_8 = manager.audio:GetVoiceLength("story_v_out_121561", "121561016", "story_v_out_121561.awb") / 1000

					if var_68_8 + var_68_0 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_8 + var_68_0
					end

					if var_68_3.prefab_name ~= "" and arg_65_1.actors_[var_68_3.prefab_name] ~= nil then
						local var_68_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_3.prefab_name].transform, "story_v_out_121561", "121561016", "story_v_out_121561.awb")

						arg_65_1:RecordAudio("121561016", var_68_9)
						arg_65_1:RecordAudio("121561016", var_68_9)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_121561", "121561016", "story_v_out_121561.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_121561", "121561016", "story_v_out_121561.awb")
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
	Play121561017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 121561017
		arg_69_1.duration_ = 8.47

		local var_69_0 = {
			ja = 8.466,
			ko = 6.366,
			zh = 6.366
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
				arg_69_0:Play121561018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = 0
			local var_72_1 = 0.725

			if var_72_0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_0 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				local var_72_2 = arg_69_1:FormatText(StoryNameCfg[389].name)

				arg_69_1.leftNameTxt_.text = var_72_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_3 = arg_69_1:GetWordFromCfg(121561017)
				local var_72_4 = arg_69_1:FormatText(var_72_3.content)

				arg_69_1.text_.text = var_72_4

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_5 = 29
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

				if manager.audio:GetVoiceLength("story_v_out_121561", "121561017", "story_v_out_121561.awb") ~= 0 then
					local var_72_8 = manager.audio:GetVoiceLength("story_v_out_121561", "121561017", "story_v_out_121561.awb") / 1000

					if var_72_8 + var_72_0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_8 + var_72_0
					end

					if var_72_3.prefab_name ~= "" and arg_69_1.actors_[var_72_3.prefab_name] ~= nil then
						local var_72_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_3.prefab_name].transform, "story_v_out_121561", "121561017", "story_v_out_121561.awb")

						arg_69_1:RecordAudio("121561017", var_72_9)
						arg_69_1:RecordAudio("121561017", var_72_9)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_121561", "121561017", "story_v_out_121561.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_121561", "121561017", "story_v_out_121561.awb")
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
	Play121561018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 121561018
		arg_73_1.duration_ = 7.5

		local var_73_0 = {
			ja = 4.8,
			ko = 7.5,
			zh = 7.5
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
				arg_73_0:Play121561019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = 0
			local var_76_1 = 0.675

			if var_76_0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_0 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				local var_76_2 = arg_73_1:FormatText(StoryNameCfg[319].name)

				arg_73_1.leftNameTxt_.text = var_76_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_3 = arg_73_1:GetWordFromCfg(121561018)
				local var_76_4 = arg_73_1:FormatText(var_76_3.content)

				arg_73_1.text_.text = var_76_4

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_5 = 27
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

				if manager.audio:GetVoiceLength("story_v_out_121561", "121561018", "story_v_out_121561.awb") ~= 0 then
					local var_76_8 = manager.audio:GetVoiceLength("story_v_out_121561", "121561018", "story_v_out_121561.awb") / 1000

					if var_76_8 + var_76_0 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_8 + var_76_0
					end

					if var_76_3.prefab_name ~= "" and arg_73_1.actors_[var_76_3.prefab_name] ~= nil then
						local var_76_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_3.prefab_name].transform, "story_v_out_121561", "121561018", "story_v_out_121561.awb")

						arg_73_1:RecordAudio("121561018", var_76_9)
						arg_73_1:RecordAudio("121561018", var_76_9)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_121561", "121561018", "story_v_out_121561.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_121561", "121561018", "story_v_out_121561.awb")
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
	Play121561019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 121561019
		arg_77_1.duration_ = 8.7

		local var_77_0 = {
			ja = 8.7,
			ko = 7.5,
			zh = 7.5
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
				arg_77_0:Play121561020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = 0
			local var_80_1 = 0.75

			if var_80_0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_0 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				local var_80_2 = arg_77_1:FormatText(StoryNameCfg[319].name)

				arg_77_1.leftNameTxt_.text = var_80_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_3 = arg_77_1:GetWordFromCfg(121561019)
				local var_80_4 = arg_77_1:FormatText(var_80_3.content)

				arg_77_1.text_.text = var_80_4

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_5 = 30
				local var_80_6 = utf8.len(var_80_4)
				local var_80_7 = var_80_5 <= 0 and var_80_1 or var_80_1 * (var_80_6 / var_80_5)

				if var_80_7 > 0 and var_80_1 < var_80_7 then
					arg_77_1.talkMaxDuration = var_80_7

					if var_80_7 + var_80_0 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_7 + var_80_0
					end
				end

				arg_77_1.text_.text = var_80_4
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121561", "121561019", "story_v_out_121561.awb") ~= 0 then
					local var_80_8 = manager.audio:GetVoiceLength("story_v_out_121561", "121561019", "story_v_out_121561.awb") / 1000

					if var_80_8 + var_80_0 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_8 + var_80_0
					end

					if var_80_3.prefab_name ~= "" and arg_77_1.actors_[var_80_3.prefab_name] ~= nil then
						local var_80_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_3.prefab_name].transform, "story_v_out_121561", "121561019", "story_v_out_121561.awb")

						arg_77_1:RecordAudio("121561019", var_80_9)
						arg_77_1:RecordAudio("121561019", var_80_9)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_121561", "121561019", "story_v_out_121561.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_121561", "121561019", "story_v_out_121561.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_10 = math.max(var_80_1, arg_77_1.talkMaxDuration)

			if var_80_0 <= arg_77_1.time_ and arg_77_1.time_ < var_80_0 + var_80_10 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_0) / var_80_10

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_0 + var_80_10 and arg_77_1.time_ < var_80_0 + var_80_10 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play121561020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 121561020
		arg_81_1.duration_ = 8.03

		local var_81_0 = {
			ja = 7.1,
			ko = 8.033,
			zh = 8.033
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
				arg_81_0:Play121561021(arg_81_1)
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

				local var_84_2 = arg_81_1:FormatText(StoryNameCfg[319].name)

				arg_81_1.leftNameTxt_.text = var_84_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_3 = arg_81_1:GetWordFromCfg(121561020)
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

				if manager.audio:GetVoiceLength("story_v_out_121561", "121561020", "story_v_out_121561.awb") ~= 0 then
					local var_84_8 = manager.audio:GetVoiceLength("story_v_out_121561", "121561020", "story_v_out_121561.awb") / 1000

					if var_84_8 + var_84_0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_8 + var_84_0
					end

					if var_84_3.prefab_name ~= "" and arg_81_1.actors_[var_84_3.prefab_name] ~= nil then
						local var_84_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_3.prefab_name].transform, "story_v_out_121561", "121561020", "story_v_out_121561.awb")

						arg_81_1:RecordAudio("121561020", var_84_9)
						arg_81_1:RecordAudio("121561020", var_84_9)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_121561", "121561020", "story_v_out_121561.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_121561", "121561020", "story_v_out_121561.awb")
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
	Play121561021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 121561021
		arg_85_1.duration_ = 6.13

		local var_85_0 = {
			ja = 6.133,
			ko = 4.1,
			zh = 4.1
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
				arg_85_0:Play121561022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = 0
			local var_88_1 = 0.425

			if var_88_0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_0 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				local var_88_2 = arg_85_1:FormatText(StoryNameCfg[389].name)

				arg_85_1.leftNameTxt_.text = var_88_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_3 = arg_85_1:GetWordFromCfg(121561021)
				local var_88_4 = arg_85_1:FormatText(var_88_3.content)

				arg_85_1.text_.text = var_88_4

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_5 = 17
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

				if manager.audio:GetVoiceLength("story_v_out_121561", "121561021", "story_v_out_121561.awb") ~= 0 then
					local var_88_8 = manager.audio:GetVoiceLength("story_v_out_121561", "121561021", "story_v_out_121561.awb") / 1000

					if var_88_8 + var_88_0 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_8 + var_88_0
					end

					if var_88_3.prefab_name ~= "" and arg_85_1.actors_[var_88_3.prefab_name] ~= nil then
						local var_88_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_3.prefab_name].transform, "story_v_out_121561", "121561021", "story_v_out_121561.awb")

						arg_85_1:RecordAudio("121561021", var_88_9)
						arg_85_1:RecordAudio("121561021", var_88_9)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_121561", "121561021", "story_v_out_121561.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_121561", "121561021", "story_v_out_121561.awb")
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
	Play121561022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 121561022
		arg_89_1.duration_ = 5

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play121561023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = 0
			local var_92_1 = 1.125

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

				local var_92_2 = arg_89_1:GetWordFromCfg(121561022)
				local var_92_3 = arg_89_1:FormatText(var_92_2.content)

				arg_89_1.text_.text = var_92_3

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_4 = 45
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
	Play121561023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 121561023
		arg_93_1.duration_ = 6.73

		local var_93_0 = {
			ja = 6.733,
			ko = 2.266,
			zh = 2.266
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
				arg_93_0:Play121561024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = 0
			local var_96_1 = 0.375

			if var_96_0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_0 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				local var_96_2 = arg_93_1:FormatText(StoryNameCfg[319].name)

				arg_93_1.leftNameTxt_.text = var_96_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_3 = arg_93_1:GetWordFromCfg(121561023)
				local var_96_4 = arg_93_1:FormatText(var_96_3.content)

				arg_93_1.text_.text = var_96_4

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_5 = 15
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

				if manager.audio:GetVoiceLength("story_v_out_121561", "121561023", "story_v_out_121561.awb") ~= 0 then
					local var_96_8 = manager.audio:GetVoiceLength("story_v_out_121561", "121561023", "story_v_out_121561.awb") / 1000

					if var_96_8 + var_96_0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_8 + var_96_0
					end

					if var_96_3.prefab_name ~= "" and arg_93_1.actors_[var_96_3.prefab_name] ~= nil then
						local var_96_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_3.prefab_name].transform, "story_v_out_121561", "121561023", "story_v_out_121561.awb")

						arg_93_1:RecordAudio("121561023", var_96_9)
						arg_93_1:RecordAudio("121561023", var_96_9)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_121561", "121561023", "story_v_out_121561.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_121561", "121561023", "story_v_out_121561.awb")
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
	Play121561024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 121561024
		arg_97_1.duration_ = 11.2

		local var_97_0 = {
			ja = 11.2,
			ko = 5.433,
			zh = 5.433
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
				arg_97_0:Play121561025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = 0
			local var_100_1 = 0.725

			if var_100_0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_0 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				local var_100_2 = arg_97_1:FormatText(StoryNameCfg[319].name)

				arg_97_1.leftNameTxt_.text = var_100_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_3 = arg_97_1:GetWordFromCfg(121561024)
				local var_100_4 = arg_97_1:FormatText(var_100_3.content)

				arg_97_1.text_.text = var_100_4

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_5 = 29
				local var_100_6 = utf8.len(var_100_4)
				local var_100_7 = var_100_5 <= 0 and var_100_1 or var_100_1 * (var_100_6 / var_100_5)

				if var_100_7 > 0 and var_100_1 < var_100_7 then
					arg_97_1.talkMaxDuration = var_100_7

					if var_100_7 + var_100_0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_7 + var_100_0
					end
				end

				arg_97_1.text_.text = var_100_4
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121561", "121561024", "story_v_out_121561.awb") ~= 0 then
					local var_100_8 = manager.audio:GetVoiceLength("story_v_out_121561", "121561024", "story_v_out_121561.awb") / 1000

					if var_100_8 + var_100_0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_8 + var_100_0
					end

					if var_100_3.prefab_name ~= "" and arg_97_1.actors_[var_100_3.prefab_name] ~= nil then
						local var_100_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_3.prefab_name].transform, "story_v_out_121561", "121561024", "story_v_out_121561.awb")

						arg_97_1:RecordAudio("121561024", var_100_9)
						arg_97_1:RecordAudio("121561024", var_100_9)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_121561", "121561024", "story_v_out_121561.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_121561", "121561024", "story_v_out_121561.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_10 = math.max(var_100_1, arg_97_1.talkMaxDuration)

			if var_100_0 <= arg_97_1.time_ and arg_97_1.time_ < var_100_0 + var_100_10 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_0) / var_100_10

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_0 + var_100_10 and arg_97_1.time_ < var_100_0 + var_100_10 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play121561025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 121561025
		arg_101_1.duration_ = 6.6

		local var_101_0 = {
			ja = 6.6,
			ko = 5.666,
			zh = 5.666
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
				arg_101_0:Play121561026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = 0
			local var_104_1 = 0.525

			if var_104_0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_0 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				local var_104_2 = arg_101_1:FormatText(StoryNameCfg[389].name)

				arg_101_1.leftNameTxt_.text = var_104_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_3 = arg_101_1:GetWordFromCfg(121561025)
				local var_104_4 = arg_101_1:FormatText(var_104_3.content)

				arg_101_1.text_.text = var_104_4

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_5 = 21
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

				if manager.audio:GetVoiceLength("story_v_out_121561", "121561025", "story_v_out_121561.awb") ~= 0 then
					local var_104_8 = manager.audio:GetVoiceLength("story_v_out_121561", "121561025", "story_v_out_121561.awb") / 1000

					if var_104_8 + var_104_0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_8 + var_104_0
					end

					if var_104_3.prefab_name ~= "" and arg_101_1.actors_[var_104_3.prefab_name] ~= nil then
						local var_104_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_3.prefab_name].transform, "story_v_out_121561", "121561025", "story_v_out_121561.awb")

						arg_101_1:RecordAudio("121561025", var_104_9)
						arg_101_1:RecordAudio("121561025", var_104_9)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_121561", "121561025", "story_v_out_121561.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_121561", "121561025", "story_v_out_121561.awb")
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
	Play121561026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 121561026
		arg_105_1.duration_ = 5.67

		local var_105_0 = {
			ja = 1.2,
			ko = 5.666,
			zh = 5.666
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
				arg_105_0:Play121561027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = 0
			local var_108_1 = 0.525

			if var_108_0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_0 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				local var_108_2 = arg_105_1:FormatText(StoryNameCfg[319].name)

				arg_105_1.leftNameTxt_.text = var_108_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_3 = arg_105_1:GetWordFromCfg(121561026)
				local var_108_4 = arg_105_1:FormatText(var_108_3.content)

				arg_105_1.text_.text = var_108_4

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_5 = 21
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

				if manager.audio:GetVoiceLength("story_v_out_121561", "121561026", "story_v_out_121561.awb") ~= 0 then
					local var_108_8 = manager.audio:GetVoiceLength("story_v_out_121561", "121561026", "story_v_out_121561.awb") / 1000

					if var_108_8 + var_108_0 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_8 + var_108_0
					end

					if var_108_3.prefab_name ~= "" and arg_105_1.actors_[var_108_3.prefab_name] ~= nil then
						local var_108_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_3.prefab_name].transform, "story_v_out_121561", "121561026", "story_v_out_121561.awb")

						arg_105_1:RecordAudio("121561026", var_108_9)
						arg_105_1:RecordAudio("121561026", var_108_9)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_121561", "121561026", "story_v_out_121561.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_121561", "121561026", "story_v_out_121561.awb")
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
	Play121561027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 121561027
		arg_109_1.duration_ = 12.6

		local var_109_0 = {
			ja = 12.6,
			ko = 7.266,
			zh = 7.266
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
				arg_109_0:Play121561028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = 0
			local var_112_1 = 0.8

			if var_112_0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_0 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				local var_112_2 = arg_109_1:FormatText(StoryNameCfg[389].name)

				arg_109_1.leftNameTxt_.text = var_112_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_3 = arg_109_1:GetWordFromCfg(121561027)
				local var_112_4 = arg_109_1:FormatText(var_112_3.content)

				arg_109_1.text_.text = var_112_4

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_5 = 32
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

				if manager.audio:GetVoiceLength("story_v_out_121561", "121561027", "story_v_out_121561.awb") ~= 0 then
					local var_112_8 = manager.audio:GetVoiceLength("story_v_out_121561", "121561027", "story_v_out_121561.awb") / 1000

					if var_112_8 + var_112_0 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_8 + var_112_0
					end

					if var_112_3.prefab_name ~= "" and arg_109_1.actors_[var_112_3.prefab_name] ~= nil then
						local var_112_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_3.prefab_name].transform, "story_v_out_121561", "121561027", "story_v_out_121561.awb")

						arg_109_1:RecordAudio("121561027", var_112_9)
						arg_109_1:RecordAudio("121561027", var_112_9)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_121561", "121561027", "story_v_out_121561.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_121561", "121561027", "story_v_out_121561.awb")
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
	Play121561028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 121561028
		arg_113_1.duration_ = 4.3

		local var_113_0 = {
			ja = 4.3,
			ko = 1.6,
			zh = 1.6
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
				arg_113_0:Play121561029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = 0
			local var_116_1 = 0.125

			if var_116_0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_0 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				local var_116_2 = arg_113_1:FormatText(StoryNameCfg[319].name)

				arg_113_1.leftNameTxt_.text = var_116_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_3 = arg_113_1:GetWordFromCfg(121561028)
				local var_116_4 = arg_113_1:FormatText(var_116_3.content)

				arg_113_1.text_.text = var_116_4

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_5 = 5
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

				if manager.audio:GetVoiceLength("story_v_out_121561", "121561028", "story_v_out_121561.awb") ~= 0 then
					local var_116_8 = manager.audio:GetVoiceLength("story_v_out_121561", "121561028", "story_v_out_121561.awb") / 1000

					if var_116_8 + var_116_0 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_8 + var_116_0
					end

					if var_116_3.prefab_name ~= "" and arg_113_1.actors_[var_116_3.prefab_name] ~= nil then
						local var_116_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_3.prefab_name].transform, "story_v_out_121561", "121561028", "story_v_out_121561.awb")

						arg_113_1:RecordAudio("121561028", var_116_9)
						arg_113_1:RecordAudio("121561028", var_116_9)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_121561", "121561028", "story_v_out_121561.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_121561", "121561028", "story_v_out_121561.awb")
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
	Play121561029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 121561029
		arg_117_1.duration_ = 4.8

		local var_117_0 = {
			ja = 4.8,
			ko = 4,
			zh = 4
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
				arg_117_0:Play121561030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = 0
			local var_120_1 = 0.4

			if var_120_0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_0 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				local var_120_2 = arg_117_1:FormatText(StoryNameCfg[389].name)

				arg_117_1.leftNameTxt_.text = var_120_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_3 = arg_117_1:GetWordFromCfg(121561029)
				local var_120_4 = arg_117_1:FormatText(var_120_3.content)

				arg_117_1.text_.text = var_120_4

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_5 = 16
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

				if manager.audio:GetVoiceLength("story_v_out_121561", "121561029", "story_v_out_121561.awb") ~= 0 then
					local var_120_8 = manager.audio:GetVoiceLength("story_v_out_121561", "121561029", "story_v_out_121561.awb") / 1000

					if var_120_8 + var_120_0 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_8 + var_120_0
					end

					if var_120_3.prefab_name ~= "" and arg_117_1.actors_[var_120_3.prefab_name] ~= nil then
						local var_120_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_3.prefab_name].transform, "story_v_out_121561", "121561029", "story_v_out_121561.awb")

						arg_117_1:RecordAudio("121561029", var_120_9)
						arg_117_1:RecordAudio("121561029", var_120_9)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_121561", "121561029", "story_v_out_121561.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_121561", "121561029", "story_v_out_121561.awb")
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
	Play121561030 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 121561030
		arg_121_1.duration_ = 5.2

		local var_121_0 = {
			ja = 5.2,
			ko = 4.133,
			zh = 4.133
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
				arg_121_0:Play121561031(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = 0
			local var_124_1 = 0.3

			if var_124_0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_0 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				local var_124_2 = arg_121_1:FormatText(StoryNameCfg[319].name)

				arg_121_1.leftNameTxt_.text = var_124_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_3 = arg_121_1:GetWordFromCfg(121561030)
				local var_124_4 = arg_121_1:FormatText(var_124_3.content)

				arg_121_1.text_.text = var_124_4

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_5 = 12
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

				if manager.audio:GetVoiceLength("story_v_out_121561", "121561030", "story_v_out_121561.awb") ~= 0 then
					local var_124_8 = manager.audio:GetVoiceLength("story_v_out_121561", "121561030", "story_v_out_121561.awb") / 1000

					if var_124_8 + var_124_0 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_8 + var_124_0
					end

					if var_124_3.prefab_name ~= "" and arg_121_1.actors_[var_124_3.prefab_name] ~= nil then
						local var_124_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_3.prefab_name].transform, "story_v_out_121561", "121561030", "story_v_out_121561.awb")

						arg_121_1:RecordAudio("121561030", var_124_9)
						arg_121_1:RecordAudio("121561030", var_124_9)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_121561", "121561030", "story_v_out_121561.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_121561", "121561030", "story_v_out_121561.awb")
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
	Play121561031 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 121561031
		arg_125_1.duration_ = 8.1

		local var_125_0 = {
			ja = 8.1,
			ko = 4.566,
			zh = 4.566
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
				arg_125_0:Play121561032(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = 0
			local var_128_1 = 0.45

			if var_128_0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_0 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				local var_128_2 = arg_125_1:FormatText(StoryNameCfg[319].name)

				arg_125_1.leftNameTxt_.text = var_128_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_3 = arg_125_1:GetWordFromCfg(121561031)
				local var_128_4 = arg_125_1:FormatText(var_128_3.content)

				arg_125_1.text_.text = var_128_4

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_5 = 18
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

				if manager.audio:GetVoiceLength("story_v_out_121561", "121561031", "story_v_out_121561.awb") ~= 0 then
					local var_128_8 = manager.audio:GetVoiceLength("story_v_out_121561", "121561031", "story_v_out_121561.awb") / 1000

					if var_128_8 + var_128_0 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_8 + var_128_0
					end

					if var_128_3.prefab_name ~= "" and arg_125_1.actors_[var_128_3.prefab_name] ~= nil then
						local var_128_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_3.prefab_name].transform, "story_v_out_121561", "121561031", "story_v_out_121561.awb")

						arg_125_1:RecordAudio("121561031", var_128_9)
						arg_125_1:RecordAudio("121561031", var_128_9)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_121561", "121561031", "story_v_out_121561.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_121561", "121561031", "story_v_out_121561.awb")
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
	Play121561032 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 121561032
		arg_129_1.duration_ = 2.1

		local var_129_0 = {
			ja = 2.1,
			ko = 1.233,
			zh = 1.233
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
				arg_129_0:Play121561033(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = 0
			local var_132_1 = 0.15

			if var_132_0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_0 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				local var_132_2 = arg_129_1:FormatText(StoryNameCfg[389].name)

				arg_129_1.leftNameTxt_.text = var_132_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_3 = arg_129_1:GetWordFromCfg(121561032)
				local var_132_4 = arg_129_1:FormatText(var_132_3.content)

				arg_129_1.text_.text = var_132_4

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_5 = 6
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

				if manager.audio:GetVoiceLength("story_v_out_121561", "121561032", "story_v_out_121561.awb") ~= 0 then
					local var_132_8 = manager.audio:GetVoiceLength("story_v_out_121561", "121561032", "story_v_out_121561.awb") / 1000

					if var_132_8 + var_132_0 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_8 + var_132_0
					end

					if var_132_3.prefab_name ~= "" and arg_129_1.actors_[var_132_3.prefab_name] ~= nil then
						local var_132_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_3.prefab_name].transform, "story_v_out_121561", "121561032", "story_v_out_121561.awb")

						arg_129_1:RecordAudio("121561032", var_132_9)
						arg_129_1:RecordAudio("121561032", var_132_9)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_121561", "121561032", "story_v_out_121561.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_121561", "121561032", "story_v_out_121561.awb")
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
	Play121561033 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 121561033
		arg_133_1.duration_ = 6.8

		local var_133_0 = {
			ja = 5.566,
			ko = 6.8,
			zh = 6.8
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
				arg_133_0:Play121561034(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = 0
			local var_136_1 = 0.35

			if var_136_0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_0 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				local var_136_2 = arg_133_1:FormatText(StoryNameCfg[319].name)

				arg_133_1.leftNameTxt_.text = var_136_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_3 = arg_133_1:GetWordFromCfg(121561033)
				local var_136_4 = arg_133_1:FormatText(var_136_3.content)

				arg_133_1.text_.text = var_136_4

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_5 = 14
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

				if manager.audio:GetVoiceLength("story_v_out_121561", "121561033", "story_v_out_121561.awb") ~= 0 then
					local var_136_8 = manager.audio:GetVoiceLength("story_v_out_121561", "121561033", "story_v_out_121561.awb") / 1000

					if var_136_8 + var_136_0 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_8 + var_136_0
					end

					if var_136_3.prefab_name ~= "" and arg_133_1.actors_[var_136_3.prefab_name] ~= nil then
						local var_136_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_3.prefab_name].transform, "story_v_out_121561", "121561033", "story_v_out_121561.awb")

						arg_133_1:RecordAudio("121561033", var_136_9)
						arg_133_1:RecordAudio("121561033", var_136_9)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_121561", "121561033", "story_v_out_121561.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_121561", "121561033", "story_v_out_121561.awb")
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
	Play121561034 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 121561034
		arg_137_1.duration_ = 3.6

		local var_137_0 = {
			ja = 3.6,
			ko = 3.366,
			zh = 3.366
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
				arg_137_0:Play121561035(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = 0
			local var_140_1 = 0.375

			if var_140_0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_0 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				local var_140_2 = arg_137_1:FormatText(StoryNameCfg[319].name)

				arg_137_1.leftNameTxt_.text = var_140_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_3 = arg_137_1:GetWordFromCfg(121561034)
				local var_140_4 = arg_137_1:FormatText(var_140_3.content)

				arg_137_1.text_.text = var_140_4

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_5 = 15
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

				if manager.audio:GetVoiceLength("story_v_out_121561", "121561034", "story_v_out_121561.awb") ~= 0 then
					local var_140_8 = manager.audio:GetVoiceLength("story_v_out_121561", "121561034", "story_v_out_121561.awb") / 1000

					if var_140_8 + var_140_0 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_8 + var_140_0
					end

					if var_140_3.prefab_name ~= "" and arg_137_1.actors_[var_140_3.prefab_name] ~= nil then
						local var_140_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_3.prefab_name].transform, "story_v_out_121561", "121561034", "story_v_out_121561.awb")

						arg_137_1:RecordAudio("121561034", var_140_9)
						arg_137_1:RecordAudio("121561034", var_140_9)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_121561", "121561034", "story_v_out_121561.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_121561", "121561034", "story_v_out_121561.awb")
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
	Play121561035 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 121561035
		arg_141_1.duration_ = 4.73

		local var_141_0 = {
			ja = 4.733,
			ko = 2.8,
			zh = 2.8
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
				arg_141_0:Play121561036(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = 0
			local var_144_1 = 0.3

			if var_144_0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_0 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				local var_144_2 = arg_141_1:FormatText(StoryNameCfg[389].name)

				arg_141_1.leftNameTxt_.text = var_144_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_3 = arg_141_1:GetWordFromCfg(121561035)
				local var_144_4 = arg_141_1:FormatText(var_144_3.content)

				arg_141_1.text_.text = var_144_4

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_5 = 12
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

				if manager.audio:GetVoiceLength("story_v_out_121561", "121561035", "story_v_out_121561.awb") ~= 0 then
					local var_144_8 = manager.audio:GetVoiceLength("story_v_out_121561", "121561035", "story_v_out_121561.awb") / 1000

					if var_144_8 + var_144_0 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_8 + var_144_0
					end

					if var_144_3.prefab_name ~= "" and arg_141_1.actors_[var_144_3.prefab_name] ~= nil then
						local var_144_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_3.prefab_name].transform, "story_v_out_121561", "121561035", "story_v_out_121561.awb")

						arg_141_1:RecordAudio("121561035", var_144_9)
						arg_141_1:RecordAudio("121561035", var_144_9)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_121561", "121561035", "story_v_out_121561.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_121561", "121561035", "story_v_out_121561.awb")
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
	Play121561036 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 121561036
		arg_145_1.duration_ = 7.97

		local var_145_0 = {
			ja = 7.666,
			ko = 7.966,
			zh = 7.966
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
				arg_145_0:Play121561037(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = "J12g"

			if arg_145_1.bgs_[var_148_0] == nil then
				local var_148_1 = Object.Instantiate(arg_145_1.paintGo_)

				var_148_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_148_0)
				var_148_1.name = var_148_0
				var_148_1.transform.parent = arg_145_1.stage_.transform
				var_148_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_145_1.bgs_[var_148_0] = var_148_1
			end

			local var_148_2 = 2

			if var_148_2 < arg_145_1.time_ and arg_145_1.time_ <= var_148_2 + arg_148_0 then
				local var_148_3 = manager.ui.mainCamera.transform.localPosition
				local var_148_4 = Vector3.New(0, 0, 10) + Vector3.New(var_148_3.x, var_148_3.y, 0)
				local var_148_5 = arg_145_1.bgs_.J12g

				var_148_5.transform.localPosition = var_148_4
				var_148_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_148_6 = var_148_5:GetComponent("SpriteRenderer")

				if var_148_6 and var_148_6.sprite then
					local var_148_7 = (var_148_5.transform.localPosition - var_148_3).z
					local var_148_8 = manager.ui.mainCameraCom_
					local var_148_9 = 2 * var_148_7 * Mathf.Tan(var_148_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_148_10 = var_148_9 * var_148_8.aspect
					local var_148_11 = var_148_6.sprite.bounds.size.x
					local var_148_12 = var_148_6.sprite.bounds.size.y
					local var_148_13 = var_148_10 / var_148_11
					local var_148_14 = var_148_9 / var_148_12
					local var_148_15 = var_148_14 < var_148_13 and var_148_13 or var_148_14

					var_148_5.transform.localScale = Vector3.New(var_148_15, var_148_15, 0)
				end

				for iter_148_0, iter_148_1 in pairs(arg_145_1.bgs_) do
					if iter_148_0 ~= "J12g" then
						iter_148_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_148_16 = 0

			if var_148_16 < arg_145_1.time_ and arg_145_1.time_ <= var_148_16 + arg_148_0 then
				arg_145_1.mask_.enabled = true
				arg_145_1.mask_.raycastTarget = true

				arg_145_1:SetGaussion(false)
			end

			local var_148_17 = 2

			if var_148_16 <= arg_145_1.time_ and arg_145_1.time_ < var_148_16 + var_148_17 then
				local var_148_18 = (arg_145_1.time_ - var_148_16) / var_148_17
				local var_148_19 = Color.New(0, 0, 0)

				var_148_19.a = Mathf.Lerp(0, 1, var_148_18)
				arg_145_1.mask_.color = var_148_19
			end

			if arg_145_1.time_ >= var_148_16 + var_148_17 and arg_145_1.time_ < var_148_16 + var_148_17 + arg_148_0 then
				local var_148_20 = Color.New(0, 0, 0)

				var_148_20.a = 1
				arg_145_1.mask_.color = var_148_20
			end

			local var_148_21 = 2

			if var_148_21 < arg_145_1.time_ and arg_145_1.time_ <= var_148_21 + arg_148_0 then
				arg_145_1.mask_.enabled = true
				arg_145_1.mask_.raycastTarget = true

				arg_145_1:SetGaussion(false)
			end

			local var_148_22 = 2

			if var_148_21 <= arg_145_1.time_ and arg_145_1.time_ < var_148_21 + var_148_22 then
				local var_148_23 = (arg_145_1.time_ - var_148_21) / var_148_22
				local var_148_24 = Color.New(0, 0, 0)

				var_148_24.a = Mathf.Lerp(1, 0, var_148_23)
				arg_145_1.mask_.color = var_148_24
			end

			if arg_145_1.time_ >= var_148_21 + var_148_22 and arg_145_1.time_ < var_148_21 + var_148_22 + arg_148_0 then
				local var_148_25 = Color.New(0, 0, 0)
				local var_148_26 = 0

				arg_145_1.mask_.enabled = false
				var_148_25.a = var_148_26
				arg_145_1.mask_.color = var_148_25
			end

			local var_148_27 = "1076ui_story"

			if arg_145_1.actors_[var_148_27] == nil then
				local var_148_28 = Asset.Load("Char/" .. "1076ui_story")

				if not isNil(var_148_28) then
					local var_148_29 = Object.Instantiate(Asset.Load("Char/" .. "1076ui_story"), arg_145_1.stage_.transform)

					var_148_29.name = var_148_27
					var_148_29.transform.localPosition = Vector3.New(0, 100, 0)
					arg_145_1.actors_[var_148_27] = var_148_29

					local var_148_30 = var_148_29:GetComponentInChildren(typeof(CharacterEffect))

					var_148_30.enabled = true

					local var_148_31 = GameObjectTools.GetOrAddComponent(var_148_29, typeof(DynamicBoneHelper))

					if var_148_31 then
						var_148_31:EnableDynamicBone(false)
					end

					arg_145_1:ShowWeapon(var_148_30.transform, false)

					arg_145_1.var_[var_148_27 .. "Animator"] = var_148_30.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_145_1.var_[var_148_27 .. "Animator"].applyRootMotion = true
					arg_145_1.var_[var_148_27 .. "LipSync"] = var_148_30.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_148_32 = arg_145_1.actors_["1076ui_story"].transform
			local var_148_33 = 3.96666666666667

			if var_148_33 < arg_145_1.time_ and arg_145_1.time_ <= var_148_33 + arg_148_0 then
				arg_145_1.var_.moveOldPos1076ui_story = var_148_32.localPosition
			end

			local var_148_34 = 0.001

			if var_148_33 <= arg_145_1.time_ and arg_145_1.time_ < var_148_33 + var_148_34 then
				local var_148_35 = (arg_145_1.time_ - var_148_33) / var_148_34
				local var_148_36 = Vector3.New(-0.7, -1.06, -6.2)

				var_148_32.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos1076ui_story, var_148_36, var_148_35)

				local var_148_37 = manager.ui.mainCamera.transform.position - var_148_32.position

				var_148_32.forward = Vector3.New(var_148_37.x, var_148_37.y, var_148_37.z)

				local var_148_38 = var_148_32.localEulerAngles

				var_148_38.z = 0
				var_148_38.x = 0
				var_148_32.localEulerAngles = var_148_38
			end

			if arg_145_1.time_ >= var_148_33 + var_148_34 and arg_145_1.time_ < var_148_33 + var_148_34 + arg_148_0 then
				var_148_32.localPosition = Vector3.New(-0.7, -1.06, -6.2)

				local var_148_39 = manager.ui.mainCamera.transform.position - var_148_32.position

				var_148_32.forward = Vector3.New(var_148_39.x, var_148_39.y, var_148_39.z)

				local var_148_40 = var_148_32.localEulerAngles

				var_148_40.z = 0
				var_148_40.x = 0
				var_148_32.localEulerAngles = var_148_40
			end

			local var_148_41 = "1029ui_story"

			if arg_145_1.actors_[var_148_41] == nil then
				local var_148_42 = Asset.Load("Char/" .. "1029ui_story")

				if not isNil(var_148_42) then
					local var_148_43 = Object.Instantiate(Asset.Load("Char/" .. "1029ui_story"), arg_145_1.stage_.transform)

					var_148_43.name = var_148_41
					var_148_43.transform.localPosition = Vector3.New(0, 100, 0)
					arg_145_1.actors_[var_148_41] = var_148_43

					local var_148_44 = var_148_43:GetComponentInChildren(typeof(CharacterEffect))

					var_148_44.enabled = true

					local var_148_45 = GameObjectTools.GetOrAddComponent(var_148_43, typeof(DynamicBoneHelper))

					if var_148_45 then
						var_148_45:EnableDynamicBone(false)
					end

					arg_145_1:ShowWeapon(var_148_44.transform, false)

					arg_145_1.var_[var_148_41 .. "Animator"] = var_148_44.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_145_1.var_[var_148_41 .. "Animator"].applyRootMotion = true
					arg_145_1.var_[var_148_41 .. "LipSync"] = var_148_44.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_148_46 = arg_145_1.actors_["1029ui_story"].transform
			local var_148_47 = 3.96666666666667

			if var_148_47 < arg_145_1.time_ and arg_145_1.time_ <= var_148_47 + arg_148_0 then
				arg_145_1.var_.moveOldPos1029ui_story = var_148_46.localPosition
			end

			local var_148_48 = 0.001

			if var_148_47 <= arg_145_1.time_ and arg_145_1.time_ < var_148_47 + var_148_48 then
				local var_148_49 = (arg_145_1.time_ - var_148_47) / var_148_48
				local var_148_50 = Vector3.New(0.7, -1.09, -6.2)

				var_148_46.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos1029ui_story, var_148_50, var_148_49)

				local var_148_51 = manager.ui.mainCamera.transform.position - var_148_46.position

				var_148_46.forward = Vector3.New(var_148_51.x, var_148_51.y, var_148_51.z)

				local var_148_52 = var_148_46.localEulerAngles

				var_148_52.z = 0
				var_148_52.x = 0
				var_148_46.localEulerAngles = var_148_52
			end

			if arg_145_1.time_ >= var_148_47 + var_148_48 and arg_145_1.time_ < var_148_47 + var_148_48 + arg_148_0 then
				var_148_46.localPosition = Vector3.New(0.7, -1.09, -6.2)

				local var_148_53 = manager.ui.mainCamera.transform.position - var_148_46.position

				var_148_46.forward = Vector3.New(var_148_53.x, var_148_53.y, var_148_53.z)

				local var_148_54 = var_148_46.localEulerAngles

				var_148_54.z = 0
				var_148_54.x = 0
				var_148_46.localEulerAngles = var_148_54
			end

			local var_148_55 = 3.96666666666667

			if var_148_55 < arg_145_1.time_ and arg_145_1.time_ <= var_148_55 + arg_148_0 then
				arg_145_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action1_1")
			end

			local var_148_56 = 3.96666666666667

			if var_148_56 < arg_145_1.time_ and arg_145_1.time_ <= var_148_56 + arg_148_0 then
				arg_145_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_148_57 = 3.96666666666667

			if var_148_57 < arg_145_1.time_ and arg_145_1.time_ <= var_148_57 + arg_148_0 then
				arg_145_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action1_1")
			end

			local var_148_58 = arg_145_1.actors_["1076ui_story"]
			local var_148_59 = 3.96666666666667

			if var_148_59 < arg_145_1.time_ and arg_145_1.time_ <= var_148_59 + arg_148_0 and not isNil(var_148_58) and arg_145_1.var_.characterEffect1076ui_story == nil then
				arg_145_1.var_.characterEffect1076ui_story = var_148_58:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_60 = 0.2

			if var_148_59 <= arg_145_1.time_ and arg_145_1.time_ < var_148_59 + var_148_60 and not isNil(var_148_58) then
				local var_148_61 = (arg_145_1.time_ - var_148_59) / var_148_60

				if arg_145_1.var_.characterEffect1076ui_story and not isNil(var_148_58) then
					arg_145_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_145_1.time_ >= var_148_59 + var_148_60 and arg_145_1.time_ < var_148_59 + var_148_60 + arg_148_0 and not isNil(var_148_58) and arg_145_1.var_.characterEffect1076ui_story then
				arg_145_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			local var_148_62 = arg_145_1.actors_["1029ui_story"]
			local var_148_63 = 3.96666666666667

			if var_148_63 < arg_145_1.time_ and arg_145_1.time_ <= var_148_63 + arg_148_0 and not isNil(var_148_62) and arg_145_1.var_.characterEffect1029ui_story == nil then
				arg_145_1.var_.characterEffect1029ui_story = var_148_62:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_64 = 0.0339999999999998

			if var_148_63 <= arg_145_1.time_ and arg_145_1.time_ < var_148_63 + var_148_64 and not isNil(var_148_62) then
				local var_148_65 = (arg_145_1.time_ - var_148_63) / var_148_64

				if arg_145_1.var_.characterEffect1029ui_story and not isNil(var_148_62) then
					local var_148_66 = Mathf.Lerp(0, 0.5, var_148_65)

					arg_145_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_145_1.var_.characterEffect1029ui_story.fillRatio = var_148_66
				end
			end

			if arg_145_1.time_ >= var_148_63 + var_148_64 and arg_145_1.time_ < var_148_63 + var_148_64 + arg_148_0 and not isNil(var_148_62) and arg_145_1.var_.characterEffect1029ui_story then
				local var_148_67 = 0.5

				arg_145_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_145_1.var_.characterEffect1029ui_story.fillRatio = var_148_67
			end

			if arg_145_1.frameCnt_ <= 1 then
				arg_145_1.dialog_:SetActive(false)
			end

			local var_148_68 = 4
			local var_148_69 = 0.275

			if var_148_68 < arg_145_1.time_ and arg_145_1.time_ <= var_148_68 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0

				arg_145_1.dialog_:SetActive(true)

				arg_145_1.dialogCg_.alpha = 0

				local var_148_70 = LeanTween.value(arg_145_1.dialog_, 0, 1, 0.3)

				var_148_70:setOnUpdate(LuaHelper.FloatAction(function(arg_149_0)
					arg_145_1.dialogCg_.alpha = arg_149_0
				end))
				var_148_70:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_145_1.dialog_)
					var_148_70:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_145_1.duration_ = arg_145_1.duration_ + 0.3

				SetActive(arg_145_1.leftNameGo_, true)

				local var_148_71 = arg_145_1:FormatText(StoryNameCfg[389].name)

				arg_145_1.leftNameTxt_.text = var_148_71

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_72 = arg_145_1:GetWordFromCfg(121561036)
				local var_148_73 = arg_145_1:FormatText(var_148_72.content)

				arg_145_1.text_.text = var_148_73

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_74 = 11
				local var_148_75 = utf8.len(var_148_73)
				local var_148_76 = var_148_74 <= 0 and var_148_69 or var_148_69 * (var_148_75 / var_148_74)

				if var_148_76 > 0 and var_148_69 < var_148_76 then
					arg_145_1.talkMaxDuration = var_148_76
					var_148_68 = var_148_68 + 0.3

					if var_148_76 + var_148_68 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_76 + var_148_68
					end
				end

				arg_145_1.text_.text = var_148_73
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121561", "121561036", "story_v_out_121561.awb") ~= 0 then
					local var_148_77 = manager.audio:GetVoiceLength("story_v_out_121561", "121561036", "story_v_out_121561.awb") / 1000

					if var_148_77 + var_148_68 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_77 + var_148_68
					end

					if var_148_72.prefab_name ~= "" and arg_145_1.actors_[var_148_72.prefab_name] ~= nil then
						local var_148_78 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_72.prefab_name].transform, "story_v_out_121561", "121561036", "story_v_out_121561.awb")

						arg_145_1:RecordAudio("121561036", var_148_78)
						arg_145_1:RecordAudio("121561036", var_148_78)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_121561", "121561036", "story_v_out_121561.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_121561", "121561036", "story_v_out_121561.awb")
				end

				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_79 = var_148_68 + 0.3
			local var_148_80 = math.max(var_148_69, arg_145_1.talkMaxDuration)

			if var_148_79 <= arg_145_1.time_ and arg_145_1.time_ < var_148_79 + var_148_80 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_79) / var_148_80

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_79 + var_148_80 and arg_145_1.time_ < var_148_79 + var_148_80 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.96666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1029ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.96666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_145_1:InitPlayNodeList()
	end,
	Play121561037 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 121561037
		arg_151_1.duration_ = 5

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play121561038(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = arg_151_1.actors_["1076ui_story"]
			local var_154_1 = 0

			if var_154_1 < arg_151_1.time_ and arg_151_1.time_ <= var_154_1 + arg_154_0 and not isNil(var_154_0) and arg_151_1.var_.characterEffect1076ui_story == nil then
				arg_151_1.var_.characterEffect1076ui_story = var_154_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_2 = 0.2

			if var_154_1 <= arg_151_1.time_ and arg_151_1.time_ < var_154_1 + var_154_2 and not isNil(var_154_0) then
				local var_154_3 = (arg_151_1.time_ - var_154_1) / var_154_2

				if arg_151_1.var_.characterEffect1076ui_story and not isNil(var_154_0) then
					local var_154_4 = Mathf.Lerp(0, 0.5, var_154_3)

					arg_151_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_151_1.var_.characterEffect1076ui_story.fillRatio = var_154_4
				end
			end

			if arg_151_1.time_ >= var_154_1 + var_154_2 and arg_151_1.time_ < var_154_1 + var_154_2 + arg_154_0 and not isNil(var_154_0) and arg_151_1.var_.characterEffect1076ui_story then
				local var_154_5 = 0.5

				arg_151_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_151_1.var_.characterEffect1076ui_story.fillRatio = var_154_5
			end

			local var_154_6 = 0
			local var_154_7 = 1.125

			if var_154_6 < arg_151_1.time_ and arg_151_1.time_ <= var_154_6 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, false)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_8 = arg_151_1:GetWordFromCfg(121561037)
				local var_154_9 = arg_151_1:FormatText(var_154_8.content)

				arg_151_1.text_.text = var_154_9

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_10 = 45
				local var_154_11 = utf8.len(var_154_9)
				local var_154_12 = var_154_10 <= 0 and var_154_7 or var_154_7 * (var_154_11 / var_154_10)

				if var_154_12 > 0 and var_154_7 < var_154_12 then
					arg_151_1.talkMaxDuration = var_154_12

					if var_154_12 + var_154_6 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_12 + var_154_6
					end
				end

				arg_151_1.text_.text = var_154_9
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)
				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_13 = math.max(var_154_7, arg_151_1.talkMaxDuration)

			if var_154_6 <= arg_151_1.time_ and arg_151_1.time_ < var_154_6 + var_154_13 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_6) / var_154_13

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_6 + var_154_13 and arg_151_1.time_ < var_154_6 + var_154_13 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {}

		arg_151_1:InitPlayNodeList()
	end,
	Play121561038 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 121561038
		arg_155_1.duration_ = 4.17

		local var_155_0 = {
			ja = 4.166,
			ko = 3.1,
			zh = 3.1
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
				arg_155_0:Play121561039(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = arg_155_1.actors_["1029ui_story"]
			local var_158_1 = 0

			if var_158_1 < arg_155_1.time_ and arg_155_1.time_ <= var_158_1 + arg_158_0 and not isNil(var_158_0) and arg_155_1.var_.characterEffect1029ui_story == nil then
				arg_155_1.var_.characterEffect1029ui_story = var_158_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_158_2 = 0.2

			if var_158_1 <= arg_155_1.time_ and arg_155_1.time_ < var_158_1 + var_158_2 and not isNil(var_158_0) then
				local var_158_3 = (arg_155_1.time_ - var_158_1) / var_158_2

				if arg_155_1.var_.characterEffect1029ui_story and not isNil(var_158_0) then
					arg_155_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_155_1.time_ >= var_158_1 + var_158_2 and arg_155_1.time_ < var_158_1 + var_158_2 + arg_158_0 and not isNil(var_158_0) and arg_155_1.var_.characterEffect1029ui_story then
				arg_155_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_158_4 = 0
			local var_158_5 = 0.325

			if var_158_4 < arg_155_1.time_ and arg_155_1.time_ <= var_158_4 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				local var_158_6 = arg_155_1:FormatText(StoryNameCfg[319].name)

				arg_155_1.leftNameTxt_.text = var_158_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_7 = arg_155_1:GetWordFromCfg(121561038)
				local var_158_8 = arg_155_1:FormatText(var_158_7.content)

				arg_155_1.text_.text = var_158_8

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_9 = 13
				local var_158_10 = utf8.len(var_158_8)
				local var_158_11 = var_158_9 <= 0 and var_158_5 or var_158_5 * (var_158_10 / var_158_9)

				if var_158_11 > 0 and var_158_5 < var_158_11 then
					arg_155_1.talkMaxDuration = var_158_11

					if var_158_11 + var_158_4 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_11 + var_158_4
					end
				end

				arg_155_1.text_.text = var_158_8
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121561", "121561038", "story_v_out_121561.awb") ~= 0 then
					local var_158_12 = manager.audio:GetVoiceLength("story_v_out_121561", "121561038", "story_v_out_121561.awb") / 1000

					if var_158_12 + var_158_4 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_12 + var_158_4
					end

					if var_158_7.prefab_name ~= "" and arg_155_1.actors_[var_158_7.prefab_name] ~= nil then
						local var_158_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_7.prefab_name].transform, "story_v_out_121561", "121561038", "story_v_out_121561.awb")

						arg_155_1:RecordAudio("121561038", var_158_13)
						arg_155_1:RecordAudio("121561038", var_158_13)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_121561", "121561038", "story_v_out_121561.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_121561", "121561038", "story_v_out_121561.awb")
				end

				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_14 = math.max(var_158_5, arg_155_1.talkMaxDuration)

			if var_158_4 <= arg_155_1.time_ and arg_155_1.time_ < var_158_4 + var_158_14 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_4) / var_158_14

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_4 + var_158_14 and arg_155_1.time_ < var_158_4 + var_158_14 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {}

		arg_155_1:InitPlayNodeList()
	end,
	Play121561039 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 121561039
		arg_159_1.duration_ = 17.7

		local var_159_0 = {
			ja = 17.7,
			ko = 8.6,
			zh = 8.6
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
				arg_159_0:Play121561040(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_0 = arg_159_1.actors_["1076ui_story"]
			local var_162_1 = 0

			if var_162_1 < arg_159_1.time_ and arg_159_1.time_ <= var_162_1 + arg_162_0 and not isNil(var_162_0) and arg_159_1.var_.characterEffect1076ui_story == nil then
				arg_159_1.var_.characterEffect1076ui_story = var_162_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_162_2 = 0.2

			if var_162_1 <= arg_159_1.time_ and arg_159_1.time_ < var_162_1 + var_162_2 and not isNil(var_162_0) then
				local var_162_3 = (arg_159_1.time_ - var_162_1) / var_162_2

				if arg_159_1.var_.characterEffect1076ui_story and not isNil(var_162_0) then
					arg_159_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_159_1.time_ >= var_162_1 + var_162_2 and arg_159_1.time_ < var_162_1 + var_162_2 + arg_162_0 and not isNil(var_162_0) and arg_159_1.var_.characterEffect1076ui_story then
				arg_159_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			local var_162_4 = arg_159_1.actors_["1029ui_story"]
			local var_162_5 = 0

			if var_162_5 < arg_159_1.time_ and arg_159_1.time_ <= var_162_5 + arg_162_0 and not isNil(var_162_4) and arg_159_1.var_.characterEffect1029ui_story == nil then
				arg_159_1.var_.characterEffect1029ui_story = var_162_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_162_6 = 0.2

			if var_162_5 <= arg_159_1.time_ and arg_159_1.time_ < var_162_5 + var_162_6 and not isNil(var_162_4) then
				local var_162_7 = (arg_159_1.time_ - var_162_5) / var_162_6

				if arg_159_1.var_.characterEffect1029ui_story and not isNil(var_162_4) then
					local var_162_8 = Mathf.Lerp(0, 0.5, var_162_7)

					arg_159_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_159_1.var_.characterEffect1029ui_story.fillRatio = var_162_8
				end
			end

			if arg_159_1.time_ >= var_162_5 + var_162_6 and arg_159_1.time_ < var_162_5 + var_162_6 + arg_162_0 and not isNil(var_162_4) and arg_159_1.var_.characterEffect1029ui_story then
				local var_162_9 = 0.5

				arg_159_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_159_1.var_.characterEffect1029ui_story.fillRatio = var_162_9
			end

			local var_162_10 = 0
			local var_162_11 = 0.75

			if var_162_10 < arg_159_1.time_ and arg_159_1.time_ <= var_162_10 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				local var_162_12 = arg_159_1:FormatText(StoryNameCfg[389].name)

				arg_159_1.leftNameTxt_.text = var_162_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_13 = arg_159_1:GetWordFromCfg(121561039)
				local var_162_14 = arg_159_1:FormatText(var_162_13.content)

				arg_159_1.text_.text = var_162_14

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_15 = 30
				local var_162_16 = utf8.len(var_162_14)
				local var_162_17 = var_162_15 <= 0 and var_162_11 or var_162_11 * (var_162_16 / var_162_15)

				if var_162_17 > 0 and var_162_11 < var_162_17 then
					arg_159_1.talkMaxDuration = var_162_17

					if var_162_17 + var_162_10 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_17 + var_162_10
					end
				end

				arg_159_1.text_.text = var_162_14
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121561", "121561039", "story_v_out_121561.awb") ~= 0 then
					local var_162_18 = manager.audio:GetVoiceLength("story_v_out_121561", "121561039", "story_v_out_121561.awb") / 1000

					if var_162_18 + var_162_10 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_18 + var_162_10
					end

					if var_162_13.prefab_name ~= "" and arg_159_1.actors_[var_162_13.prefab_name] ~= nil then
						local var_162_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_13.prefab_name].transform, "story_v_out_121561", "121561039", "story_v_out_121561.awb")

						arg_159_1:RecordAudio("121561039", var_162_19)
						arg_159_1:RecordAudio("121561039", var_162_19)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_out_121561", "121561039", "story_v_out_121561.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_out_121561", "121561039", "story_v_out_121561.awb")
				end

				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_20 = math.max(var_162_11, arg_159_1.talkMaxDuration)

			if var_162_10 <= arg_159_1.time_ and arg_159_1.time_ < var_162_10 + var_162_20 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_10) / var_162_20

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_10 + var_162_20 and arg_159_1.time_ < var_162_10 + var_162_20 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {}

		arg_159_1:InitPlayNodeList()
	end,
	Play121561040 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 121561040
		arg_163_1.duration_ = 5

		SetActive(arg_163_1.tipsGo_, false)

		function arg_163_1.onSingleLineFinish_()
			arg_163_1.onSingleLineUpdate_ = nil
			arg_163_1.onSingleLineFinish_ = nil
			arg_163_1.state_ = "waiting"
		end

		function arg_163_1.playNext_(arg_165_0)
			if arg_165_0 == 1 then
				arg_163_0:Play121561041(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			local var_166_0 = arg_163_1.actors_["1076ui_story"]
			local var_166_1 = 0

			if var_166_1 < arg_163_1.time_ and arg_163_1.time_ <= var_166_1 + arg_166_0 and not isNil(var_166_0) and arg_163_1.var_.characterEffect1076ui_story == nil then
				arg_163_1.var_.characterEffect1076ui_story = var_166_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_166_2 = 0.2

			if var_166_1 <= arg_163_1.time_ and arg_163_1.time_ < var_166_1 + var_166_2 and not isNil(var_166_0) then
				local var_166_3 = (arg_163_1.time_ - var_166_1) / var_166_2

				if arg_163_1.var_.characterEffect1076ui_story and not isNil(var_166_0) then
					local var_166_4 = Mathf.Lerp(0, 0.5, var_166_3)

					arg_163_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_163_1.var_.characterEffect1076ui_story.fillRatio = var_166_4
				end
			end

			if arg_163_1.time_ >= var_166_1 + var_166_2 and arg_163_1.time_ < var_166_1 + var_166_2 + arg_166_0 and not isNil(var_166_0) and arg_163_1.var_.characterEffect1076ui_story then
				local var_166_5 = 0.5

				arg_163_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_163_1.var_.characterEffect1076ui_story.fillRatio = var_166_5
			end

			local var_166_6 = 0
			local var_166_7 = 0.725

			if var_166_6 < arg_163_1.time_ and arg_163_1.time_ <= var_166_6 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, false)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_8 = arg_163_1:GetWordFromCfg(121561040)
				local var_166_9 = arg_163_1:FormatText(var_166_8.content)

				arg_163_1.text_.text = var_166_9

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_10 = 29
				local var_166_11 = utf8.len(var_166_9)
				local var_166_12 = var_166_10 <= 0 and var_166_7 or var_166_7 * (var_166_11 / var_166_10)

				if var_166_12 > 0 and var_166_7 < var_166_12 then
					arg_163_1.talkMaxDuration = var_166_12

					if var_166_12 + var_166_6 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_12 + var_166_6
					end
				end

				arg_163_1.text_.text = var_166_9
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)
				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_13 = math.max(var_166_7, arg_163_1.talkMaxDuration)

			if var_166_6 <= arg_163_1.time_ and arg_163_1.time_ < var_166_6 + var_166_13 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_6) / var_166_13

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_6 + var_166_13 and arg_163_1.time_ < var_166_6 + var_166_13 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {}

		arg_163_1:InitPlayNodeList()
	end,
	Play121561041 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 121561041
		arg_167_1.duration_ = 3

		local var_167_0 = {
			ja = 3,
			ko = 0.999999999999,
			zh = 0.999999999999
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
				arg_167_0:Play121561042(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = arg_167_1.actors_["1076ui_story"]
			local var_170_1 = 0

			if var_170_1 < arg_167_1.time_ and arg_167_1.time_ <= var_170_1 + arg_170_0 and not isNil(var_170_0) and arg_167_1.var_.characterEffect1076ui_story == nil then
				arg_167_1.var_.characterEffect1076ui_story = var_170_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_170_2 = 0.2

			if var_170_1 <= arg_167_1.time_ and arg_167_1.time_ < var_170_1 + var_170_2 and not isNil(var_170_0) then
				local var_170_3 = (arg_167_1.time_ - var_170_1) / var_170_2

				if arg_167_1.var_.characterEffect1076ui_story and not isNil(var_170_0) then
					arg_167_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_167_1.time_ >= var_170_1 + var_170_2 and arg_167_1.time_ < var_170_1 + var_170_2 + arg_170_0 and not isNil(var_170_0) and arg_167_1.var_.characterEffect1076ui_story then
				arg_167_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			local var_170_4 = 0
			local var_170_5 = 0.125

			if var_170_4 < arg_167_1.time_ and arg_167_1.time_ <= var_170_4 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				local var_170_6 = arg_167_1:FormatText(StoryNameCfg[389].name)

				arg_167_1.leftNameTxt_.text = var_170_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_7 = arg_167_1:GetWordFromCfg(121561041)
				local var_170_8 = arg_167_1:FormatText(var_170_7.content)

				arg_167_1.text_.text = var_170_8

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_9 = 5
				local var_170_10 = utf8.len(var_170_8)
				local var_170_11 = var_170_9 <= 0 and var_170_5 or var_170_5 * (var_170_10 / var_170_9)

				if var_170_11 > 0 and var_170_5 < var_170_11 then
					arg_167_1.talkMaxDuration = var_170_11

					if var_170_11 + var_170_4 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_11 + var_170_4
					end
				end

				arg_167_1.text_.text = var_170_8
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121561", "121561041", "story_v_out_121561.awb") ~= 0 then
					local var_170_12 = manager.audio:GetVoiceLength("story_v_out_121561", "121561041", "story_v_out_121561.awb") / 1000

					if var_170_12 + var_170_4 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_12 + var_170_4
					end

					if var_170_7.prefab_name ~= "" and arg_167_1.actors_[var_170_7.prefab_name] ~= nil then
						local var_170_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_7.prefab_name].transform, "story_v_out_121561", "121561041", "story_v_out_121561.awb")

						arg_167_1:RecordAudio("121561041", var_170_13)
						arg_167_1:RecordAudio("121561041", var_170_13)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_out_121561", "121561041", "story_v_out_121561.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_out_121561", "121561041", "story_v_out_121561.awb")
				end

				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_14 = math.max(var_170_5, arg_167_1.talkMaxDuration)

			if var_170_4 <= arg_167_1.time_ and arg_167_1.time_ < var_170_4 + var_170_14 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_4) / var_170_14

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_4 + var_170_14 and arg_167_1.time_ < var_170_4 + var_170_14 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {}

		arg_167_1:InitPlayNodeList()
	end,
	Play121561042 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 121561042
		arg_171_1.duration_ = 5

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play121561043(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = arg_171_1.actors_["1029ui_story"].transform
			local var_174_1 = 0

			if var_174_1 < arg_171_1.time_ and arg_171_1.time_ <= var_174_1 + arg_174_0 then
				arg_171_1.var_.moveOldPos1029ui_story = var_174_0.localPosition
			end

			local var_174_2 = 0.001

			if var_174_1 <= arg_171_1.time_ and arg_171_1.time_ < var_174_1 + var_174_2 then
				local var_174_3 = (arg_171_1.time_ - var_174_1) / var_174_2
				local var_174_4 = Vector3.New(0, 100, 0)

				var_174_0.localPosition = Vector3.Lerp(arg_171_1.var_.moveOldPos1029ui_story, var_174_4, var_174_3)

				local var_174_5 = manager.ui.mainCamera.transform.position - var_174_0.position

				var_174_0.forward = Vector3.New(var_174_5.x, var_174_5.y, var_174_5.z)

				local var_174_6 = var_174_0.localEulerAngles

				var_174_6.z = 0
				var_174_6.x = 0
				var_174_0.localEulerAngles = var_174_6
			end

			if arg_171_1.time_ >= var_174_1 + var_174_2 and arg_171_1.time_ < var_174_1 + var_174_2 + arg_174_0 then
				var_174_0.localPosition = Vector3.New(0, 100, 0)

				local var_174_7 = manager.ui.mainCamera.transform.position - var_174_0.position

				var_174_0.forward = Vector3.New(var_174_7.x, var_174_7.y, var_174_7.z)

				local var_174_8 = var_174_0.localEulerAngles

				var_174_8.z = 0
				var_174_8.x = 0
				var_174_0.localEulerAngles = var_174_8
			end

			local var_174_9 = arg_171_1.actors_["1076ui_story"].transform
			local var_174_10 = 0

			if var_174_10 < arg_171_1.time_ and arg_171_1.time_ <= var_174_10 + arg_174_0 then
				arg_171_1.var_.moveOldPos1076ui_story = var_174_9.localPosition
			end

			local var_174_11 = 0.001

			if var_174_10 <= arg_171_1.time_ and arg_171_1.time_ < var_174_10 + var_174_11 then
				local var_174_12 = (arg_171_1.time_ - var_174_10) / var_174_11
				local var_174_13 = Vector3.New(0, 100, 0)

				var_174_9.localPosition = Vector3.Lerp(arg_171_1.var_.moveOldPos1076ui_story, var_174_13, var_174_12)

				local var_174_14 = manager.ui.mainCamera.transform.position - var_174_9.position

				var_174_9.forward = Vector3.New(var_174_14.x, var_174_14.y, var_174_14.z)

				local var_174_15 = var_174_9.localEulerAngles

				var_174_15.z = 0
				var_174_15.x = 0
				var_174_9.localEulerAngles = var_174_15
			end

			if arg_171_1.time_ >= var_174_10 + var_174_11 and arg_171_1.time_ < var_174_10 + var_174_11 + arg_174_0 then
				var_174_9.localPosition = Vector3.New(0, 100, 0)

				local var_174_16 = manager.ui.mainCamera.transform.position - var_174_9.position

				var_174_9.forward = Vector3.New(var_174_16.x, var_174_16.y, var_174_16.z)

				local var_174_17 = var_174_9.localEulerAngles

				var_174_17.z = 0
				var_174_17.x = 0
				var_174_9.localEulerAngles = var_174_17
			end

			local var_174_18 = 0
			local var_174_19 = 1.425

			if var_174_18 < arg_171_1.time_ and arg_171_1.time_ <= var_174_18 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, false)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_20 = arg_171_1:GetWordFromCfg(121561042)
				local var_174_21 = arg_171_1:FormatText(var_174_20.content)

				arg_171_1.text_.text = var_174_21

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_22 = 57
				local var_174_23 = utf8.len(var_174_21)
				local var_174_24 = var_174_22 <= 0 and var_174_19 or var_174_19 * (var_174_23 / var_174_22)

				if var_174_24 > 0 and var_174_19 < var_174_24 then
					arg_171_1.talkMaxDuration = var_174_24

					if var_174_24 + var_174_18 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_24 + var_174_18
					end
				end

				arg_171_1.text_.text = var_174_21
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)
				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_25 = math.max(var_174_19, arg_171_1.talkMaxDuration)

			if var_174_18 <= arg_171_1.time_ and arg_171_1.time_ < var_174_18 + var_174_25 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_18) / var_174_25

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_18 + var_174_25 and arg_171_1.time_ < var_174_18 + var_174_25 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {
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
				actorName = "1076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_171_1:InitPlayNodeList()
	end,
	Play121561043 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 121561043
		arg_175_1.duration_ = 5

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play121561044(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = 0
			local var_178_1 = 0.975

			if var_178_0 < arg_175_1.time_ and arg_175_1.time_ <= var_178_0 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, false)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_2 = arg_175_1:GetWordFromCfg(121561043)
				local var_178_3 = arg_175_1:FormatText(var_178_2.content)

				arg_175_1.text_.text = var_178_3

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_4 = 39
				local var_178_5 = utf8.len(var_178_3)
				local var_178_6 = var_178_4 <= 0 and var_178_1 or var_178_1 * (var_178_5 / var_178_4)

				if var_178_6 > 0 and var_178_1 < var_178_6 then
					arg_175_1.talkMaxDuration = var_178_6

					if var_178_6 + var_178_0 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_6 + var_178_0
					end
				end

				arg_175_1.text_.text = var_178_3
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)
				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_7 = math.max(var_178_1, arg_175_1.talkMaxDuration)

			if var_178_0 <= arg_175_1.time_ and arg_175_1.time_ < var_178_0 + var_178_7 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_0) / var_178_7

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_0 + var_178_7 and arg_175_1.time_ < var_178_0 + var_178_7 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {}

		arg_175_1:InitPlayNodeList()
	end,
	Play121561044 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 121561044
		arg_179_1.duration_ = 4.23

		local var_179_0 = {
			ja = 3.1,
			ko = 4.233,
			zh = 4.233
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
				arg_179_0:Play121561045(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = arg_179_1.actors_["1029ui_story"].transform
			local var_182_1 = 0

			if var_182_1 < arg_179_1.time_ and arg_179_1.time_ <= var_182_1 + arg_182_0 then
				arg_179_1.var_.moveOldPos1029ui_story = var_182_0.localPosition
			end

			local var_182_2 = 0.001

			if var_182_1 <= arg_179_1.time_ and arg_179_1.time_ < var_182_1 + var_182_2 then
				local var_182_3 = (arg_179_1.time_ - var_182_1) / var_182_2
				local var_182_4 = Vector3.New(0, -1.09, -6.2)

				var_182_0.localPosition = Vector3.Lerp(arg_179_1.var_.moveOldPos1029ui_story, var_182_4, var_182_3)

				local var_182_5 = manager.ui.mainCamera.transform.position - var_182_0.position

				var_182_0.forward = Vector3.New(var_182_5.x, var_182_5.y, var_182_5.z)

				local var_182_6 = var_182_0.localEulerAngles

				var_182_6.z = 0
				var_182_6.x = 0
				var_182_0.localEulerAngles = var_182_6
			end

			if arg_179_1.time_ >= var_182_1 + var_182_2 and arg_179_1.time_ < var_182_1 + var_182_2 + arg_182_0 then
				var_182_0.localPosition = Vector3.New(0, -1.09, -6.2)

				local var_182_7 = manager.ui.mainCamera.transform.position - var_182_0.position

				var_182_0.forward = Vector3.New(var_182_7.x, var_182_7.y, var_182_7.z)

				local var_182_8 = var_182_0.localEulerAngles

				var_182_8.z = 0
				var_182_8.x = 0
				var_182_0.localEulerAngles = var_182_8
			end

			local var_182_9 = arg_179_1.actors_["1029ui_story"]
			local var_182_10 = 0

			if var_182_10 < arg_179_1.time_ and arg_179_1.time_ <= var_182_10 + arg_182_0 and not isNil(var_182_9) and arg_179_1.var_.characterEffect1029ui_story == nil then
				arg_179_1.var_.characterEffect1029ui_story = var_182_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_182_11 = 0.200000002980232

			if var_182_10 <= arg_179_1.time_ and arg_179_1.time_ < var_182_10 + var_182_11 and not isNil(var_182_9) then
				local var_182_12 = (arg_179_1.time_ - var_182_10) / var_182_11

				if arg_179_1.var_.characterEffect1029ui_story and not isNil(var_182_9) then
					arg_179_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_179_1.time_ >= var_182_10 + var_182_11 and arg_179_1.time_ < var_182_10 + var_182_11 + arg_182_0 and not isNil(var_182_9) and arg_179_1.var_.characterEffect1029ui_story then
				arg_179_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_182_13 = 0

			if var_182_13 < arg_179_1.time_ and arg_179_1.time_ <= var_182_13 + arg_182_0 then
				arg_179_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action1_1")
			end

			local var_182_14 = 0

			if var_182_14 < arg_179_1.time_ and arg_179_1.time_ <= var_182_14 + arg_182_0 then
				arg_179_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_182_15 = 0
			local var_182_16 = 0.125

			if var_182_15 < arg_179_1.time_ and arg_179_1.time_ <= var_182_15 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				local var_182_17 = arg_179_1:FormatText(StoryNameCfg[319].name)

				arg_179_1.leftNameTxt_.text = var_182_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_18 = arg_179_1:GetWordFromCfg(121561044)
				local var_182_19 = arg_179_1:FormatText(var_182_18.content)

				arg_179_1.text_.text = var_182_19

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_20 = 5
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

				if manager.audio:GetVoiceLength("story_v_out_121561", "121561044", "story_v_out_121561.awb") ~= 0 then
					local var_182_23 = manager.audio:GetVoiceLength("story_v_out_121561", "121561044", "story_v_out_121561.awb") / 1000

					if var_182_23 + var_182_15 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_23 + var_182_15
					end

					if var_182_18.prefab_name ~= "" and arg_179_1.actors_[var_182_18.prefab_name] ~= nil then
						local var_182_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_179_1.actors_[var_182_18.prefab_name].transform, "story_v_out_121561", "121561044", "story_v_out_121561.awb")

						arg_179_1:RecordAudio("121561044", var_182_24)
						arg_179_1:RecordAudio("121561044", var_182_24)
					else
						arg_179_1:AudioAction("play", "voice", "story_v_out_121561", "121561044", "story_v_out_121561.awb")
					end

					arg_179_1:RecordHistoryTalkVoice("story_v_out_121561", "121561044", "story_v_out_121561.awb")
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
				actorName = "1029ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_179_1:InitPlayNodeList()
	end,
	Play121561045 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 121561045
		arg_183_1.duration_ = 5

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play121561046(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_0 = arg_183_1.actors_["1029ui_story"].transform
			local var_186_1 = 0

			if var_186_1 < arg_183_1.time_ and arg_183_1.time_ <= var_186_1 + arg_186_0 then
				arg_183_1.var_.moveOldPos1029ui_story = var_186_0.localPosition
			end

			local var_186_2 = 0.001

			if var_186_1 <= arg_183_1.time_ and arg_183_1.time_ < var_186_1 + var_186_2 then
				local var_186_3 = (arg_183_1.time_ - var_186_1) / var_186_2
				local var_186_4 = Vector3.New(0, 100, 0)

				var_186_0.localPosition = Vector3.Lerp(arg_183_1.var_.moveOldPos1029ui_story, var_186_4, var_186_3)

				local var_186_5 = manager.ui.mainCamera.transform.position - var_186_0.position

				var_186_0.forward = Vector3.New(var_186_5.x, var_186_5.y, var_186_5.z)

				local var_186_6 = var_186_0.localEulerAngles

				var_186_6.z = 0
				var_186_6.x = 0
				var_186_0.localEulerAngles = var_186_6
			end

			if arg_183_1.time_ >= var_186_1 + var_186_2 and arg_183_1.time_ < var_186_1 + var_186_2 + arg_186_0 then
				var_186_0.localPosition = Vector3.New(0, 100, 0)

				local var_186_7 = manager.ui.mainCamera.transform.position - var_186_0.position

				var_186_0.forward = Vector3.New(var_186_7.x, var_186_7.y, var_186_7.z)

				local var_186_8 = var_186_0.localEulerAngles

				var_186_8.z = 0
				var_186_8.x = 0
				var_186_0.localEulerAngles = var_186_8
			end

			local var_186_9 = arg_183_1.actors_["1029ui_story"]
			local var_186_10 = 0

			if var_186_10 < arg_183_1.time_ and arg_183_1.time_ <= var_186_10 + arg_186_0 and not isNil(var_186_9) and arg_183_1.var_.characterEffect1029ui_story == nil then
				arg_183_1.var_.characterEffect1029ui_story = var_186_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_186_11 = 0.200000002980232

			if var_186_10 <= arg_183_1.time_ and arg_183_1.time_ < var_186_10 + var_186_11 and not isNil(var_186_9) then
				local var_186_12 = (arg_183_1.time_ - var_186_10) / var_186_11

				if arg_183_1.var_.characterEffect1029ui_story and not isNil(var_186_9) then
					local var_186_13 = Mathf.Lerp(0, 0.5, var_186_12)

					arg_183_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_183_1.var_.characterEffect1029ui_story.fillRatio = var_186_13
				end
			end

			if arg_183_1.time_ >= var_186_10 + var_186_11 and arg_183_1.time_ < var_186_10 + var_186_11 + arg_186_0 and not isNil(var_186_9) and arg_183_1.var_.characterEffect1029ui_story then
				local var_186_14 = 0.5

				arg_183_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_183_1.var_.characterEffect1029ui_story.fillRatio = var_186_14
			end

			local var_186_15 = 0
			local var_186_16 = 1.575

			if var_186_15 < arg_183_1.time_ and arg_183_1.time_ <= var_186_15 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, false)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_17 = arg_183_1:GetWordFromCfg(121561045)
				local var_186_18 = arg_183_1:FormatText(var_186_17.content)

				arg_183_1.text_.text = var_186_18

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_19 = 63
				local var_186_20 = utf8.len(var_186_18)
				local var_186_21 = var_186_19 <= 0 and var_186_16 or var_186_16 * (var_186_20 / var_186_19)

				if var_186_21 > 0 and var_186_16 < var_186_21 then
					arg_183_1.talkMaxDuration = var_186_21

					if var_186_21 + var_186_15 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_21 + var_186_15
					end
				end

				arg_183_1.text_.text = var_186_18
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)
				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_22 = math.max(var_186_16, arg_183_1.talkMaxDuration)

			if var_186_15 <= arg_183_1.time_ and arg_183_1.time_ < var_186_15 + var_186_22 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_15) / var_186_22

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_15 + var_186_22 and arg_183_1.time_ < var_186_15 + var_186_22 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1029ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_183_1:InitPlayNodeList()
	end,
	Play121561046 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 121561046
		arg_187_1.duration_ = 5

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play121561047(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			local var_190_0 = 0
			local var_190_1 = 1.3

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

				local var_190_2 = arg_187_1:GetWordFromCfg(121561046)
				local var_190_3 = arg_187_1:FormatText(var_190_2.content)

				arg_187_1.text_.text = var_190_3

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_4 = 52
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
	Play121561047 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 121561047
		arg_191_1.duration_ = 4.7

		local var_191_0 = {
			ja = 4.7,
			ko = 4.2,
			zh = 4.2
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
				arg_191_0:Play121561048(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			local var_194_0 = arg_191_1.actors_["1029ui_story"].transform
			local var_194_1 = 0

			if var_194_1 < arg_191_1.time_ and arg_191_1.time_ <= var_194_1 + arg_194_0 then
				arg_191_1.var_.moveOldPos1029ui_story = var_194_0.localPosition
			end

			local var_194_2 = 0.001

			if var_194_1 <= arg_191_1.time_ and arg_191_1.time_ < var_194_1 + var_194_2 then
				local var_194_3 = (arg_191_1.time_ - var_194_1) / var_194_2
				local var_194_4 = Vector3.New(0, -1.09, -6.2)

				var_194_0.localPosition = Vector3.Lerp(arg_191_1.var_.moveOldPos1029ui_story, var_194_4, var_194_3)

				local var_194_5 = manager.ui.mainCamera.transform.position - var_194_0.position

				var_194_0.forward = Vector3.New(var_194_5.x, var_194_5.y, var_194_5.z)

				local var_194_6 = var_194_0.localEulerAngles

				var_194_6.z = 0
				var_194_6.x = 0
				var_194_0.localEulerAngles = var_194_6
			end

			if arg_191_1.time_ >= var_194_1 + var_194_2 and arg_191_1.time_ < var_194_1 + var_194_2 + arg_194_0 then
				var_194_0.localPosition = Vector3.New(0, -1.09, -6.2)

				local var_194_7 = manager.ui.mainCamera.transform.position - var_194_0.position

				var_194_0.forward = Vector3.New(var_194_7.x, var_194_7.y, var_194_7.z)

				local var_194_8 = var_194_0.localEulerAngles

				var_194_8.z = 0
				var_194_8.x = 0
				var_194_0.localEulerAngles = var_194_8
			end

			local var_194_9 = arg_191_1.actors_["1029ui_story"]
			local var_194_10 = 0

			if var_194_10 < arg_191_1.time_ and arg_191_1.time_ <= var_194_10 + arg_194_0 and not isNil(var_194_9) and arg_191_1.var_.characterEffect1029ui_story == nil then
				arg_191_1.var_.characterEffect1029ui_story = var_194_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_194_11 = 0.200000002980232

			if var_194_10 <= arg_191_1.time_ and arg_191_1.time_ < var_194_10 + var_194_11 and not isNil(var_194_9) then
				local var_194_12 = (arg_191_1.time_ - var_194_10) / var_194_11

				if arg_191_1.var_.characterEffect1029ui_story and not isNil(var_194_9) then
					arg_191_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_191_1.time_ >= var_194_10 + var_194_11 and arg_191_1.time_ < var_194_10 + var_194_11 + arg_194_0 and not isNil(var_194_9) and arg_191_1.var_.characterEffect1029ui_story then
				arg_191_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_194_13 = 0

			if var_194_13 < arg_191_1.time_ and arg_191_1.time_ <= var_194_13 + arg_194_0 then
				arg_191_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action5_1")
			end

			local var_194_14 = 0

			if var_194_14 < arg_191_1.time_ and arg_191_1.time_ <= var_194_14 + arg_194_0 then
				arg_191_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0203cva")
			end

			local var_194_15 = 0
			local var_194_16 = 0.35

			if var_194_15 < arg_191_1.time_ and arg_191_1.time_ <= var_194_15 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				local var_194_17 = arg_191_1:FormatText(StoryNameCfg[319].name)

				arg_191_1.leftNameTxt_.text = var_194_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_18 = arg_191_1:GetWordFromCfg(121561047)
				local var_194_19 = arg_191_1:FormatText(var_194_18.content)

				arg_191_1.text_.text = var_194_19

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_20 = 14
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

				if manager.audio:GetVoiceLength("story_v_out_121561", "121561047", "story_v_out_121561.awb") ~= 0 then
					local var_194_23 = manager.audio:GetVoiceLength("story_v_out_121561", "121561047", "story_v_out_121561.awb") / 1000

					if var_194_23 + var_194_15 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_23 + var_194_15
					end

					if var_194_18.prefab_name ~= "" and arg_191_1.actors_[var_194_18.prefab_name] ~= nil then
						local var_194_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_191_1.actors_[var_194_18.prefab_name].transform, "story_v_out_121561", "121561047", "story_v_out_121561.awb")

						arg_191_1:RecordAudio("121561047", var_194_24)
						arg_191_1:RecordAudio("121561047", var_194_24)
					else
						arg_191_1:AudioAction("play", "voice", "story_v_out_121561", "121561047", "story_v_out_121561.awb")
					end

					arg_191_1:RecordHistoryTalkVoice("story_v_out_121561", "121561047", "story_v_out_121561.awb")
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
				actorName = "1029ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_191_1:InitPlayNodeList()
	end,
	Play121561048 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 121561048
		arg_195_1.duration_ = 5.1

		local var_195_0 = {
			ja = 4.133,
			ko = 5.1,
			zh = 5.1
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
				arg_195_0:Play121561049(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			local var_198_0 = 0

			if var_198_0 < arg_195_1.time_ and arg_195_1.time_ <= var_198_0 + arg_198_0 then
				arg_195_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_198_1 = 0
			local var_198_2 = 0.3

			if var_198_1 < arg_195_1.time_ and arg_195_1.time_ <= var_198_1 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				local var_198_3 = arg_195_1:FormatText(StoryNameCfg[319].name)

				arg_195_1.leftNameTxt_.text = var_198_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_4 = arg_195_1:GetWordFromCfg(121561048)
				local var_198_5 = arg_195_1:FormatText(var_198_4.content)

				arg_195_1.text_.text = var_198_5

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_6 = 12
				local var_198_7 = utf8.len(var_198_5)
				local var_198_8 = var_198_6 <= 0 and var_198_2 or var_198_2 * (var_198_7 / var_198_6)

				if var_198_8 > 0 and var_198_2 < var_198_8 then
					arg_195_1.talkMaxDuration = var_198_8

					if var_198_8 + var_198_1 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_8 + var_198_1
					end
				end

				arg_195_1.text_.text = var_198_5
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121561", "121561048", "story_v_out_121561.awb") ~= 0 then
					local var_198_9 = manager.audio:GetVoiceLength("story_v_out_121561", "121561048", "story_v_out_121561.awb") / 1000

					if var_198_9 + var_198_1 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_9 + var_198_1
					end

					if var_198_4.prefab_name ~= "" and arg_195_1.actors_[var_198_4.prefab_name] ~= nil then
						local var_198_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_195_1.actors_[var_198_4.prefab_name].transform, "story_v_out_121561", "121561048", "story_v_out_121561.awb")

						arg_195_1:RecordAudio("121561048", var_198_10)
						arg_195_1:RecordAudio("121561048", var_198_10)
					else
						arg_195_1:AudioAction("play", "voice", "story_v_out_121561", "121561048", "story_v_out_121561.awb")
					end

					arg_195_1:RecordHistoryTalkVoice("story_v_out_121561", "121561048", "story_v_out_121561.awb")
				end

				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_11 = math.max(var_198_2, arg_195_1.talkMaxDuration)

			if var_198_1 <= arg_195_1.time_ and arg_195_1.time_ < var_198_1 + var_198_11 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_1) / var_198_11

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_1 + var_198_11 and arg_195_1.time_ < var_198_1 + var_198_11 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {}

		arg_195_1:InitPlayNodeList()
	end,
	Play121561049 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 121561049
		arg_199_1.duration_ = 5

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play121561050(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			local var_202_0 = arg_199_1.actors_["1029ui_story"]
			local var_202_1 = 0

			if var_202_1 < arg_199_1.time_ and arg_199_1.time_ <= var_202_1 + arg_202_0 and not isNil(var_202_0) and arg_199_1.var_.characterEffect1029ui_story == nil then
				arg_199_1.var_.characterEffect1029ui_story = var_202_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_202_2 = 0.200000002980232

			if var_202_1 <= arg_199_1.time_ and arg_199_1.time_ < var_202_1 + var_202_2 and not isNil(var_202_0) then
				local var_202_3 = (arg_199_1.time_ - var_202_1) / var_202_2

				if arg_199_1.var_.characterEffect1029ui_story and not isNil(var_202_0) then
					local var_202_4 = Mathf.Lerp(0, 0.5, var_202_3)

					arg_199_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_199_1.var_.characterEffect1029ui_story.fillRatio = var_202_4
				end
			end

			if arg_199_1.time_ >= var_202_1 + var_202_2 and arg_199_1.time_ < var_202_1 + var_202_2 + arg_202_0 and not isNil(var_202_0) and arg_199_1.var_.characterEffect1029ui_story then
				local var_202_5 = 0.5

				arg_199_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_199_1.var_.characterEffect1029ui_story.fillRatio = var_202_5
			end

			local var_202_6 = 0
			local var_202_7 = 0.95

			if var_202_6 < arg_199_1.time_ and arg_199_1.time_ <= var_202_6 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, false)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_8 = arg_199_1:GetWordFromCfg(121561049)
				local var_202_9 = arg_199_1:FormatText(var_202_8.content)

				arg_199_1.text_.text = var_202_9

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_10 = 38
				local var_202_11 = utf8.len(var_202_9)
				local var_202_12 = var_202_10 <= 0 and var_202_7 or var_202_7 * (var_202_11 / var_202_10)

				if var_202_12 > 0 and var_202_7 < var_202_12 then
					arg_199_1.talkMaxDuration = var_202_12

					if var_202_12 + var_202_6 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_12 + var_202_6
					end
				end

				arg_199_1.text_.text = var_202_9
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)
				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_13 = math.max(var_202_7, arg_199_1.talkMaxDuration)

			if var_202_6 <= arg_199_1.time_ and arg_199_1.time_ < var_202_6 + var_202_13 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_6) / var_202_13

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_6 + var_202_13 and arg_199_1.time_ < var_202_6 + var_202_13 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {}

		arg_199_1:InitPlayNodeList()
	end,
	Play121561050 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 121561050
		arg_203_1.duration_ = 7.33

		local var_203_0 = {
			ja = 7.333,
			ko = 6.966,
			zh = 6.966
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
				arg_203_0:Play121561051(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			local var_206_0 = arg_203_1.actors_["1029ui_story"]
			local var_206_1 = 0

			if var_206_1 < arg_203_1.time_ and arg_203_1.time_ <= var_206_1 + arg_206_0 and not isNil(var_206_0) and arg_203_1.var_.characterEffect1029ui_story == nil then
				arg_203_1.var_.characterEffect1029ui_story = var_206_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_206_2 = 0.200000002980232

			if var_206_1 <= arg_203_1.time_ and arg_203_1.time_ < var_206_1 + var_206_2 and not isNil(var_206_0) then
				local var_206_3 = (arg_203_1.time_ - var_206_1) / var_206_2

				if arg_203_1.var_.characterEffect1029ui_story and not isNil(var_206_0) then
					arg_203_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_203_1.time_ >= var_206_1 + var_206_2 and arg_203_1.time_ < var_206_1 + var_206_2 + arg_206_0 and not isNil(var_206_0) and arg_203_1.var_.characterEffect1029ui_story then
				arg_203_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_206_4 = 0

			if var_206_4 < arg_203_1.time_ and arg_203_1.time_ <= var_206_4 + arg_206_0 then
				arg_203_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action5_2")
			end

			local var_206_5 = 0

			if var_206_5 < arg_203_1.time_ and arg_203_1.time_ <= var_206_5 + arg_206_0 then
				arg_203_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_206_6 = 0
			local var_206_7 = 0.6

			if var_206_6 < arg_203_1.time_ and arg_203_1.time_ <= var_206_6 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				local var_206_8 = arg_203_1:FormatText(StoryNameCfg[319].name)

				arg_203_1.leftNameTxt_.text = var_206_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_9 = arg_203_1:GetWordFromCfg(121561050)
				local var_206_10 = arg_203_1:FormatText(var_206_9.content)

				arg_203_1.text_.text = var_206_10

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_11 = 24
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

				if manager.audio:GetVoiceLength("story_v_out_121561", "121561050", "story_v_out_121561.awb") ~= 0 then
					local var_206_14 = manager.audio:GetVoiceLength("story_v_out_121561", "121561050", "story_v_out_121561.awb") / 1000

					if var_206_14 + var_206_6 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_14 + var_206_6
					end

					if var_206_9.prefab_name ~= "" and arg_203_1.actors_[var_206_9.prefab_name] ~= nil then
						local var_206_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_9.prefab_name].transform, "story_v_out_121561", "121561050", "story_v_out_121561.awb")

						arg_203_1:RecordAudio("121561050", var_206_15)
						arg_203_1:RecordAudio("121561050", var_206_15)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_out_121561", "121561050", "story_v_out_121561.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_out_121561", "121561050", "story_v_out_121561.awb")
				end

				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_16 = math.max(var_206_7, arg_203_1.talkMaxDuration)

			if var_206_6 <= arg_203_1.time_ and arg_203_1.time_ < var_206_6 + var_206_16 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_6) / var_206_16

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_6 + var_206_16 and arg_203_1.time_ < var_206_6 + var_206_16 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {}

		arg_203_1:InitPlayNodeList()
	end,
	Play121561051 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 121561051
		arg_207_1.duration_ = 5

		SetActive(arg_207_1.tipsGo_, false)

		function arg_207_1.onSingleLineFinish_()
			arg_207_1.onSingleLineUpdate_ = nil
			arg_207_1.onSingleLineFinish_ = nil
			arg_207_1.state_ = "waiting"
		end

		function arg_207_1.playNext_(arg_209_0)
			if arg_209_0 == 1 then
				arg_207_0:Play121561052(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			local var_210_0 = arg_207_1.actors_["1029ui_story"].transform
			local var_210_1 = 0

			if var_210_1 < arg_207_1.time_ and arg_207_1.time_ <= var_210_1 + arg_210_0 then
				arg_207_1.var_.moveOldPos1029ui_story = var_210_0.localPosition
			end

			local var_210_2 = 0.001

			if var_210_1 <= arg_207_1.time_ and arg_207_1.time_ < var_210_1 + var_210_2 then
				local var_210_3 = (arg_207_1.time_ - var_210_1) / var_210_2
				local var_210_4 = Vector3.New(0, 100, 0)

				var_210_0.localPosition = Vector3.Lerp(arg_207_1.var_.moveOldPos1029ui_story, var_210_4, var_210_3)

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

			local var_210_9 = arg_207_1.actors_["1029ui_story"]
			local var_210_10 = 0

			if var_210_10 < arg_207_1.time_ and arg_207_1.time_ <= var_210_10 + arg_210_0 and not isNil(var_210_9) and arg_207_1.var_.characterEffect1029ui_story == nil then
				arg_207_1.var_.characterEffect1029ui_story = var_210_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_210_11 = 0.200000002980232

			if var_210_10 <= arg_207_1.time_ and arg_207_1.time_ < var_210_10 + var_210_11 and not isNil(var_210_9) then
				local var_210_12 = (arg_207_1.time_ - var_210_10) / var_210_11

				if arg_207_1.var_.characterEffect1029ui_story and not isNil(var_210_9) then
					local var_210_13 = Mathf.Lerp(0, 0.5, var_210_12)

					arg_207_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_207_1.var_.characterEffect1029ui_story.fillRatio = var_210_13
				end
			end

			if arg_207_1.time_ >= var_210_10 + var_210_11 and arg_207_1.time_ < var_210_10 + var_210_11 + arg_210_0 and not isNil(var_210_9) and arg_207_1.var_.characterEffect1029ui_story then
				local var_210_14 = 0.5

				arg_207_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_207_1.var_.characterEffect1029ui_story.fillRatio = var_210_14
			end

			local var_210_15 = 0
			local var_210_16 = 0.633333333333333

			if var_210_15 < arg_207_1.time_ and arg_207_1.time_ <= var_210_15 + arg_210_0 then
				local var_210_17 = "play"
				local var_210_18 = "effect"

				arg_207_1:AudioAction(var_210_17, var_210_18, "se_story_121_04", "se_story_121_04_spacein", "")
			end

			local var_210_19 = 0
			local var_210_20 = 0.0666666666666667

			if var_210_19 < arg_207_1.time_ and arg_207_1.time_ <= var_210_19 + arg_210_0 then
				local var_210_21 = "play"
				local var_210_22 = "music"

				arg_207_1:AudioAction(var_210_21, var_210_22, "ui_battle", "ui_battle_stopbgm", "")

				local var_210_23 = ""
				local var_210_24 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_210_24 ~= "" then
					if arg_207_1.bgmTxt_.text ~= var_210_24 and arg_207_1.bgmTxt_.text ~= "" then
						if arg_207_1.bgmTxt2_.text ~= "" then
							arg_207_1.bgmTxt_.text = arg_207_1.bgmTxt2_.text
						end

						arg_207_1.bgmTxt2_.text = var_210_24

						arg_207_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_207_1.bgmTxt_.text = var_210_24
						arg_207_1.bgmTxt2_.text = var_210_24
					end

					if arg_207_1.bgmTimer then
						arg_207_1.bgmTimer:Stop()

						arg_207_1.bgmTimer = nil
					end

					if arg_207_1.settingData.show_music_name == 1 then
						arg_207_1.musicController:SetSelectedState("show")
						arg_207_1.musicAnimator_:Play("open", 0, 0)

						if arg_207_1.settingData.music_time ~= 0 then
							arg_207_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_207_1.settingData.music_time), function()
								if arg_207_1 == nil or isNil(arg_207_1.bgmTxt_) then
									return
								end

								arg_207_1.musicController:SetSelectedState("hide")
								arg_207_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_210_25 = 0
			local var_210_26 = 0.633333333333333

			if var_210_25 < arg_207_1.time_ and arg_207_1.time_ <= var_210_25 + arg_210_0 then
				local var_210_27 = "stop"
				local var_210_28 = "effect"

				arg_207_1:AudioAction(var_210_27, var_210_28, "se_story_121_04", "se_story_121_04_final_loop", "")
			end

			local var_210_29 = 0
			local var_210_30 = 1.475

			if var_210_29 < arg_207_1.time_ and arg_207_1.time_ <= var_210_29 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, false)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_31 = arg_207_1:GetWordFromCfg(121561051)
				local var_210_32 = arg_207_1:FormatText(var_210_31.content)

				arg_207_1.text_.text = var_210_32

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_33 = 59
				local var_210_34 = utf8.len(var_210_32)
				local var_210_35 = var_210_33 <= 0 and var_210_30 or var_210_30 * (var_210_34 / var_210_33)

				if var_210_35 > 0 and var_210_30 < var_210_35 then
					arg_207_1.talkMaxDuration = var_210_35

					if var_210_35 + var_210_29 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_35 + var_210_29
					end
				end

				arg_207_1.text_.text = var_210_32
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)
				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_36 = math.max(var_210_30, arg_207_1.talkMaxDuration)

			if var_210_29 <= arg_207_1.time_ and arg_207_1.time_ < var_210_29 + var_210_36 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_29) / var_210_36

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_29 + var_210_36 and arg_207_1.time_ < var_210_29 + var_210_36 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1029ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_207_1:InitPlayNodeList()
	end,
	Play121561052 = function(arg_212_0, arg_212_1)
		arg_212_1.time_ = 0
		arg_212_1.frameCnt_ = 0
		arg_212_1.state_ = "playing"
		arg_212_1.curTalkId_ = 121561052
		arg_212_1.duration_ = 9

		SetActive(arg_212_1.tipsGo_, false)

		function arg_212_1.onSingleLineFinish_()
			arg_212_1.onSingleLineUpdate_ = nil
			arg_212_1.onSingleLineFinish_ = nil
			arg_212_1.state_ = "waiting"
		end

		function arg_212_1.playNext_(arg_214_0)
			if arg_214_0 == 1 then
				arg_212_0:Play121561053(arg_212_1)
			end
		end

		function arg_212_1.onSingleLineUpdate_(arg_215_0)
			local var_215_0 = "J10i"

			if arg_212_1.bgs_[var_215_0] == nil then
				local var_215_1 = Object.Instantiate(arg_212_1.paintGo_)

				var_215_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_215_0)
				var_215_1.name = var_215_0
				var_215_1.transform.parent = arg_212_1.stage_.transform
				var_215_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_212_1.bgs_[var_215_0] = var_215_1
			end

			local var_215_2 = 2

			if var_215_2 < arg_212_1.time_ and arg_212_1.time_ <= var_215_2 + arg_215_0 then
				local var_215_3 = manager.ui.mainCamera.transform.localPosition
				local var_215_4 = Vector3.New(0, 0, 10) + Vector3.New(var_215_3.x, var_215_3.y, 0)
				local var_215_5 = arg_212_1.bgs_.J10i

				var_215_5.transform.localPosition = var_215_4
				var_215_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_215_6 = var_215_5:GetComponent("SpriteRenderer")

				if var_215_6 and var_215_6.sprite then
					local var_215_7 = (var_215_5.transform.localPosition - var_215_3).z
					local var_215_8 = manager.ui.mainCameraCom_
					local var_215_9 = 2 * var_215_7 * Mathf.Tan(var_215_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_215_10 = var_215_9 * var_215_8.aspect
					local var_215_11 = var_215_6.sprite.bounds.size.x
					local var_215_12 = var_215_6.sprite.bounds.size.y
					local var_215_13 = var_215_10 / var_215_11
					local var_215_14 = var_215_9 / var_215_12
					local var_215_15 = var_215_14 < var_215_13 and var_215_13 or var_215_14

					var_215_5.transform.localScale = Vector3.New(var_215_15, var_215_15, 0)
				end

				for iter_215_0, iter_215_1 in pairs(arg_212_1.bgs_) do
					if iter_215_0 ~= "J10i" then
						iter_215_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_215_16 = 0

			if var_215_16 < arg_212_1.time_ and arg_212_1.time_ <= var_215_16 + arg_215_0 then
				arg_212_1.mask_.enabled = true
				arg_212_1.mask_.raycastTarget = true

				arg_212_1:SetGaussion(false)
			end

			local var_215_17 = 2

			if var_215_16 <= arg_212_1.time_ and arg_212_1.time_ < var_215_16 + var_215_17 then
				local var_215_18 = (arg_212_1.time_ - var_215_16) / var_215_17
				local var_215_19 = Color.New(0, 0, 0)

				var_215_19.a = Mathf.Lerp(0, 1, var_215_18)
				arg_212_1.mask_.color = var_215_19
			end

			if arg_212_1.time_ >= var_215_16 + var_215_17 and arg_212_1.time_ < var_215_16 + var_215_17 + arg_215_0 then
				local var_215_20 = Color.New(0, 0, 0)

				var_215_20.a = 1
				arg_212_1.mask_.color = var_215_20
			end

			local var_215_21 = 2

			if var_215_21 < arg_212_1.time_ and arg_212_1.time_ <= var_215_21 + arg_215_0 then
				arg_212_1.mask_.enabled = true
				arg_212_1.mask_.raycastTarget = true

				arg_212_1:SetGaussion(false)
			end

			local var_215_22 = 2

			if var_215_21 <= arg_212_1.time_ and arg_212_1.time_ < var_215_21 + var_215_22 then
				local var_215_23 = (arg_212_1.time_ - var_215_21) / var_215_22
				local var_215_24 = Color.New(0, 0, 0)

				var_215_24.a = Mathf.Lerp(1, 0, var_215_23)
				arg_212_1.mask_.color = var_215_24
			end

			if arg_212_1.time_ >= var_215_21 + var_215_22 and arg_212_1.time_ < var_215_21 + var_215_22 + arg_215_0 then
				local var_215_25 = Color.New(0, 0, 0)
				local var_215_26 = 0

				arg_212_1.mask_.enabled = false
				var_215_25.a = var_215_26
				arg_212_1.mask_.color = var_215_25
			end

			local var_215_27 = 2
			local var_215_28 = 0.633333333333333

			if var_215_27 < arg_212_1.time_ and arg_212_1.time_ <= var_215_27 + arg_215_0 then
				local var_215_29 = "stop"
				local var_215_30 = "effect"

				arg_212_1:AudioAction(var_215_29, var_215_30, "se_story_121_04", "se_story_121_04_harbor_loop", "")
			end

			if arg_212_1.frameCnt_ <= 1 then
				arg_212_1.dialog_:SetActive(false)
			end

			local var_215_31 = 4
			local var_215_32 = 0.25

			if var_215_31 < arg_212_1.time_ and arg_212_1.time_ <= var_215_31 + arg_215_0 then
				arg_212_1.talkMaxDuration = 0

				arg_212_1.dialog_:SetActive(true)

				arg_212_1.dialogCg_.alpha = 0

				local var_215_33 = LeanTween.value(arg_212_1.dialog_, 0, 1, 0.3)

				var_215_33:setOnUpdate(LuaHelper.FloatAction(function(arg_216_0)
					arg_212_1.dialogCg_.alpha = arg_216_0
				end))
				var_215_33:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_212_1.dialog_)
					var_215_33:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_212_1.duration_ = arg_212_1.duration_ + 0.3

				SetActive(arg_212_1.leftNameGo_, true)

				local var_215_34 = arg_212_1:FormatText(StoryNameCfg[7].name)

				arg_212_1.leftNameTxt_.text = var_215_34

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_212_1.leftNameTxt_.transform)

				arg_212_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_212_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_212_1:RecordName(arg_212_1.leftNameTxt_.text)
				SetActive(arg_212_1.iconTrs_.gameObject, true)
				arg_212_1.iconController_:SetSelectedState("hero")

				arg_212_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_212_1.callingController_:SetSelectedState("normal")

				arg_212_1.keyicon_.color = Color.New(1, 1, 1)
				arg_212_1.icon_.color = Color.New(1, 1, 1)

				local var_215_35 = arg_212_1:GetWordFromCfg(121561052)
				local var_215_36 = arg_212_1:FormatText(var_215_35.content)

				arg_212_1.text_.text = var_215_36

				LuaForUtil.ClearLinePrefixSymbol(arg_212_1.text_)

				local var_215_37 = 10
				local var_215_38 = utf8.len(var_215_36)
				local var_215_39 = var_215_37 <= 0 and var_215_32 or var_215_32 * (var_215_38 / var_215_37)

				if var_215_39 > 0 and var_215_32 < var_215_39 then
					arg_212_1.talkMaxDuration = var_215_39
					var_215_31 = var_215_31 + 0.3

					if var_215_39 + var_215_31 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_39 + var_215_31
					end
				end

				arg_212_1.text_.text = var_215_36
				arg_212_1.typewritter.percent = 0

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(false)
				arg_212_1:RecordContent(arg_212_1.text_.text)
			end

			local var_215_40 = var_215_31 + 0.3
			local var_215_41 = math.max(var_215_32, arg_212_1.talkMaxDuration)

			if var_215_40 <= arg_212_1.time_ and arg_212_1.time_ < var_215_40 + var_215_41 then
				arg_212_1.typewritter.percent = (arg_212_1.time_ - var_215_40) / var_215_41

				arg_212_1.typewritter:SetDirty()
			end

			if arg_212_1.time_ >= var_215_40 + var_215_41 and arg_212_1.time_ < var_215_40 + var_215_41 + arg_215_0 then
				arg_212_1.typewritter.percent = 1

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(true)
			end
		end

		arg_212_1.nodeConfigList_ = {}

		arg_212_1:InitPlayNodeList()
	end,
	Play121561053 = function(arg_218_0, arg_218_1)
		arg_218_1.time_ = 0
		arg_218_1.frameCnt_ = 0
		arg_218_1.state_ = "playing"
		arg_218_1.curTalkId_ = 121561053
		arg_218_1.duration_ = 3.83

		local var_218_0 = {
			ja = 3.833,
			ko = 2.566,
			zh = 2.566
		}
		local var_218_1 = manager.audio:GetLocalizationFlag()

		if var_218_0[var_218_1] ~= nil then
			arg_218_1.duration_ = var_218_0[var_218_1]
		end

		SetActive(arg_218_1.tipsGo_, false)

		function arg_218_1.onSingleLineFinish_()
			arg_218_1.onSingleLineUpdate_ = nil
			arg_218_1.onSingleLineFinish_ = nil
			arg_218_1.state_ = "waiting"
		end

		function arg_218_1.playNext_(arg_220_0)
			if arg_220_0 == 1 then
				arg_218_0:Play121561054(arg_218_1)
			end
		end

		function arg_218_1.onSingleLineUpdate_(arg_221_0)
			local var_221_0 = "1184ui_story"

			if arg_218_1.actors_[var_221_0] == nil then
				local var_221_1 = Asset.Load("Char/" .. "1184ui_story")

				if not isNil(var_221_1) then
					local var_221_2 = Object.Instantiate(Asset.Load("Char/" .. "1184ui_story"), arg_218_1.stage_.transform)

					var_221_2.name = var_221_0
					var_221_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_218_1.actors_[var_221_0] = var_221_2

					local var_221_3 = var_221_2:GetComponentInChildren(typeof(CharacterEffect))

					var_221_3.enabled = true

					local var_221_4 = GameObjectTools.GetOrAddComponent(var_221_2, typeof(DynamicBoneHelper))

					if var_221_4 then
						var_221_4:EnableDynamicBone(false)
					end

					arg_218_1:ShowWeapon(var_221_3.transform, false)

					arg_218_1.var_[var_221_0 .. "Animator"] = var_221_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_218_1.var_[var_221_0 .. "Animator"].applyRootMotion = true
					arg_218_1.var_[var_221_0 .. "LipSync"] = var_221_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_221_5 = arg_218_1.actors_["1184ui_story"].transform
			local var_221_6 = 0

			if var_221_6 < arg_218_1.time_ and arg_218_1.time_ <= var_221_6 + arg_221_0 then
				arg_218_1.var_.moveOldPos1184ui_story = var_221_5.localPosition
			end

			local var_221_7 = 0.001

			if var_221_6 <= arg_218_1.time_ and arg_218_1.time_ < var_221_6 + var_221_7 then
				local var_221_8 = (arg_218_1.time_ - var_221_6) / var_221_7
				local var_221_9 = Vector3.New(0, -0.97, -6)

				var_221_5.localPosition = Vector3.Lerp(arg_218_1.var_.moveOldPos1184ui_story, var_221_9, var_221_8)

				local var_221_10 = manager.ui.mainCamera.transform.position - var_221_5.position

				var_221_5.forward = Vector3.New(var_221_10.x, var_221_10.y, var_221_10.z)

				local var_221_11 = var_221_5.localEulerAngles

				var_221_11.z = 0
				var_221_11.x = 0
				var_221_5.localEulerAngles = var_221_11
			end

			if arg_218_1.time_ >= var_221_6 + var_221_7 and arg_218_1.time_ < var_221_6 + var_221_7 + arg_221_0 then
				var_221_5.localPosition = Vector3.New(0, -0.97, -6)

				local var_221_12 = manager.ui.mainCamera.transform.position - var_221_5.position

				var_221_5.forward = Vector3.New(var_221_12.x, var_221_12.y, var_221_12.z)

				local var_221_13 = var_221_5.localEulerAngles

				var_221_13.z = 0
				var_221_13.x = 0
				var_221_5.localEulerAngles = var_221_13
			end

			local var_221_14 = arg_218_1.actors_["1184ui_story"]
			local var_221_15 = 0

			if var_221_15 < arg_218_1.time_ and arg_218_1.time_ <= var_221_15 + arg_221_0 and not isNil(var_221_14) and arg_218_1.var_.characterEffect1184ui_story == nil then
				arg_218_1.var_.characterEffect1184ui_story = var_221_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_221_16 = 0.200000002980232

			if var_221_15 <= arg_218_1.time_ and arg_218_1.time_ < var_221_15 + var_221_16 and not isNil(var_221_14) then
				local var_221_17 = (arg_218_1.time_ - var_221_15) / var_221_16

				if arg_218_1.var_.characterEffect1184ui_story and not isNil(var_221_14) then
					arg_218_1.var_.characterEffect1184ui_story.fillFlat = false
				end
			end

			if arg_218_1.time_ >= var_221_15 + var_221_16 and arg_218_1.time_ < var_221_15 + var_221_16 + arg_221_0 and not isNil(var_221_14) and arg_218_1.var_.characterEffect1184ui_story then
				arg_218_1.var_.characterEffect1184ui_story.fillFlat = false
			end

			local var_221_18 = 0

			if var_221_18 < arg_218_1.time_ and arg_218_1.time_ <= var_221_18 + arg_221_0 then
				arg_218_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_221_19 = 0

			if var_221_19 < arg_218_1.time_ and arg_218_1.time_ <= var_221_19 + arg_221_0 then
				arg_218_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_221_20 = 0
			local var_221_21 = 1

			if var_221_20 < arg_218_1.time_ and arg_218_1.time_ <= var_221_20 + arg_221_0 then
				local var_221_22 = "play"
				local var_221_23 = "music"

				arg_218_1:AudioAction(var_221_22, var_221_23, "bgm_activity_2_1_story_city", "bgm_activity_2_1_story_city", "bgm_activity_2_1_story_city.awb")

				local var_221_24 = ""
				local var_221_25 = manager.audio:GetAudioName("bgm_activity_2_1_story_city", "bgm_activity_2_1_story_city")

				if var_221_25 ~= "" then
					if arg_218_1.bgmTxt_.text ~= var_221_25 and arg_218_1.bgmTxt_.text ~= "" then
						if arg_218_1.bgmTxt2_.text ~= "" then
							arg_218_1.bgmTxt_.text = arg_218_1.bgmTxt2_.text
						end

						arg_218_1.bgmTxt2_.text = var_221_25

						arg_218_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_218_1.bgmTxt_.text = var_221_25
						arg_218_1.bgmTxt2_.text = var_221_25
					end

					if arg_218_1.bgmTimer then
						arg_218_1.bgmTimer:Stop()

						arg_218_1.bgmTimer = nil
					end

					if arg_218_1.settingData.show_music_name == 1 then
						arg_218_1.musicController:SetSelectedState("show")
						arg_218_1.musicAnimator_:Play("open", 0, 0)

						if arg_218_1.settingData.music_time ~= 0 then
							arg_218_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_218_1.settingData.music_time), function()
								if arg_218_1 == nil or isNil(arg_218_1.bgmTxt_) then
									return
								end

								arg_218_1.musicController:SetSelectedState("hide")
								arg_218_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_221_26 = 0
			local var_221_27 = 0.325

			if var_221_26 < arg_218_1.time_ and arg_218_1.time_ <= var_221_26 + arg_221_0 then
				arg_218_1.talkMaxDuration = 0
				arg_218_1.dialogCg_.alpha = 1

				arg_218_1.dialog_:SetActive(true)
				SetActive(arg_218_1.leftNameGo_, true)

				local var_221_28 = arg_218_1:FormatText(StoryNameCfg[6].name)

				arg_218_1.leftNameTxt_.text = var_221_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_218_1.leftNameTxt_.transform)

				arg_218_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_218_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_218_1:RecordName(arg_218_1.leftNameTxt_.text)
				SetActive(arg_218_1.iconTrs_.gameObject, false)
				arg_218_1.callingController_:SetSelectedState("normal")

				local var_221_29 = arg_218_1:GetWordFromCfg(121561053)
				local var_221_30 = arg_218_1:FormatText(var_221_29.content)

				arg_218_1.text_.text = var_221_30

				LuaForUtil.ClearLinePrefixSymbol(arg_218_1.text_)

				local var_221_31 = 13
				local var_221_32 = utf8.len(var_221_30)
				local var_221_33 = var_221_31 <= 0 and var_221_27 or var_221_27 * (var_221_32 / var_221_31)

				if var_221_33 > 0 and var_221_27 < var_221_33 then
					arg_218_1.talkMaxDuration = var_221_33

					if var_221_33 + var_221_26 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_33 + var_221_26
					end
				end

				arg_218_1.text_.text = var_221_30
				arg_218_1.typewritter.percent = 0

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121561", "121561053", "story_v_out_121561.awb") ~= 0 then
					local var_221_34 = manager.audio:GetVoiceLength("story_v_out_121561", "121561053", "story_v_out_121561.awb") / 1000

					if var_221_34 + var_221_26 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_34 + var_221_26
					end

					if var_221_29.prefab_name ~= "" and arg_218_1.actors_[var_221_29.prefab_name] ~= nil then
						local var_221_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_218_1.actors_[var_221_29.prefab_name].transform, "story_v_out_121561", "121561053", "story_v_out_121561.awb")

						arg_218_1:RecordAudio("121561053", var_221_35)
						arg_218_1:RecordAudio("121561053", var_221_35)
					else
						arg_218_1:AudioAction("play", "voice", "story_v_out_121561", "121561053", "story_v_out_121561.awb")
					end

					arg_218_1:RecordHistoryTalkVoice("story_v_out_121561", "121561053", "story_v_out_121561.awb")
				end

				arg_218_1:RecordContent(arg_218_1.text_.text)
			end

			local var_221_36 = math.max(var_221_27, arg_218_1.talkMaxDuration)

			if var_221_26 <= arg_218_1.time_ and arg_218_1.time_ < var_221_26 + var_221_36 then
				arg_218_1.typewritter.percent = (arg_218_1.time_ - var_221_26) / var_221_36

				arg_218_1.typewritter:SetDirty()
			end

			if arg_218_1.time_ >= var_221_26 + var_221_36 and arg_218_1.time_ < var_221_26 + var_221_36 + arg_221_0 then
				arg_218_1.typewritter.percent = 1

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(true)
			end
		end

		arg_218_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1184ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_218_1:InitPlayNodeList()
	end,
	Play121561054 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 121561054
		arg_223_1.duration_ = 5

		SetActive(arg_223_1.tipsGo_, false)

		function arg_223_1.onSingleLineFinish_()
			arg_223_1.onSingleLineUpdate_ = nil
			arg_223_1.onSingleLineFinish_ = nil
			arg_223_1.state_ = "waiting"
		end

		function arg_223_1.playNext_(arg_225_0)
			if arg_225_0 == 1 then
				arg_223_0:Play121561055(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			local var_226_0 = arg_223_1.actors_["1184ui_story"]
			local var_226_1 = 0

			if var_226_1 < arg_223_1.time_ and arg_223_1.time_ <= var_226_1 + arg_226_0 and not isNil(var_226_0) and arg_223_1.var_.characterEffect1184ui_story == nil then
				arg_223_1.var_.characterEffect1184ui_story = var_226_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_226_2 = 0.200000002980232

			if var_226_1 <= arg_223_1.time_ and arg_223_1.time_ < var_226_1 + var_226_2 and not isNil(var_226_0) then
				local var_226_3 = (arg_223_1.time_ - var_226_1) / var_226_2

				if arg_223_1.var_.characterEffect1184ui_story and not isNil(var_226_0) then
					local var_226_4 = Mathf.Lerp(0, 0.5, var_226_3)

					arg_223_1.var_.characterEffect1184ui_story.fillFlat = true
					arg_223_1.var_.characterEffect1184ui_story.fillRatio = var_226_4
				end
			end

			if arg_223_1.time_ >= var_226_1 + var_226_2 and arg_223_1.time_ < var_226_1 + var_226_2 + arg_226_0 and not isNil(var_226_0) and arg_223_1.var_.characterEffect1184ui_story then
				local var_226_5 = 0.5

				arg_223_1.var_.characterEffect1184ui_story.fillFlat = true
				arg_223_1.var_.characterEffect1184ui_story.fillRatio = var_226_5
			end

			local var_226_6 = 0
			local var_226_7 = 0.375

			if var_226_6 < arg_223_1.time_ and arg_223_1.time_ <= var_226_6 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, true)

				local var_226_8 = arg_223_1:FormatText(StoryNameCfg[7].name)

				arg_223_1.leftNameTxt_.text = var_226_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_223_1.leftNameTxt_.transform)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1.leftNameTxt_.text)
				SetActive(arg_223_1.iconTrs_.gameObject, true)
				arg_223_1.iconController_:SetSelectedState("hero")

				arg_223_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_223_1.callingController_:SetSelectedState("normal")

				arg_223_1.keyicon_.color = Color.New(1, 1, 1)
				arg_223_1.icon_.color = Color.New(1, 1, 1)

				local var_226_9 = arg_223_1:GetWordFromCfg(121561054)
				local var_226_10 = arg_223_1:FormatText(var_226_9.content)

				arg_223_1.text_.text = var_226_10

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_11 = 15
				local var_226_12 = utf8.len(var_226_10)
				local var_226_13 = var_226_11 <= 0 and var_226_7 or var_226_7 * (var_226_12 / var_226_11)

				if var_226_13 > 0 and var_226_7 < var_226_13 then
					arg_223_1.talkMaxDuration = var_226_13

					if var_226_13 + var_226_6 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_13 + var_226_6
					end
				end

				arg_223_1.text_.text = var_226_10
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)
				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_14 = math.max(var_226_7, arg_223_1.talkMaxDuration)

			if var_226_6 <= arg_223_1.time_ and arg_223_1.time_ < var_226_6 + var_226_14 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_6) / var_226_14

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_6 + var_226_14 and arg_223_1.time_ < var_226_6 + var_226_14 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {}

		arg_223_1:InitPlayNodeList()
	end,
	Play121561055 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 121561055
		arg_227_1.duration_ = 5

		SetActive(arg_227_1.tipsGo_, false)

		function arg_227_1.onSingleLineFinish_()
			arg_227_1.onSingleLineUpdate_ = nil
			arg_227_1.onSingleLineFinish_ = nil
			arg_227_1.state_ = "waiting"
		end

		function arg_227_1.playNext_(arg_229_0)
			if arg_229_0 == 1 then
				arg_227_0:Play121561056(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			local var_230_0 = arg_227_1.actors_["1184ui_story"].transform
			local var_230_1 = 0

			if var_230_1 < arg_227_1.time_ and arg_227_1.time_ <= var_230_1 + arg_230_0 then
				arg_227_1.var_.moveOldPos1184ui_story = var_230_0.localPosition
			end

			local var_230_2 = 0.001

			if var_230_1 <= arg_227_1.time_ and arg_227_1.time_ < var_230_1 + var_230_2 then
				local var_230_3 = (arg_227_1.time_ - var_230_1) / var_230_2
				local var_230_4 = Vector3.New(0, 100, 0)

				var_230_0.localPosition = Vector3.Lerp(arg_227_1.var_.moveOldPos1184ui_story, var_230_4, var_230_3)

				local var_230_5 = manager.ui.mainCamera.transform.position - var_230_0.position

				var_230_0.forward = Vector3.New(var_230_5.x, var_230_5.y, var_230_5.z)

				local var_230_6 = var_230_0.localEulerAngles

				var_230_6.z = 0
				var_230_6.x = 0
				var_230_0.localEulerAngles = var_230_6
			end

			if arg_227_1.time_ >= var_230_1 + var_230_2 and arg_227_1.time_ < var_230_1 + var_230_2 + arg_230_0 then
				var_230_0.localPosition = Vector3.New(0, 100, 0)

				local var_230_7 = manager.ui.mainCamera.transform.position - var_230_0.position

				var_230_0.forward = Vector3.New(var_230_7.x, var_230_7.y, var_230_7.z)

				local var_230_8 = var_230_0.localEulerAngles

				var_230_8.z = 0
				var_230_8.x = 0
				var_230_0.localEulerAngles = var_230_8
			end

			local var_230_9 = arg_227_1.actors_["1184ui_story"]
			local var_230_10 = 0

			if var_230_10 < arg_227_1.time_ and arg_227_1.time_ <= var_230_10 + arg_230_0 and not isNil(var_230_9) and arg_227_1.var_.characterEffect1184ui_story == nil then
				arg_227_1.var_.characterEffect1184ui_story = var_230_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_230_11 = 0.200000002980232

			if var_230_10 <= arg_227_1.time_ and arg_227_1.time_ < var_230_10 + var_230_11 and not isNil(var_230_9) then
				local var_230_12 = (arg_227_1.time_ - var_230_10) / var_230_11

				if arg_227_1.var_.characterEffect1184ui_story and not isNil(var_230_9) then
					local var_230_13 = Mathf.Lerp(0, 0.5, var_230_12)

					arg_227_1.var_.characterEffect1184ui_story.fillFlat = true
					arg_227_1.var_.characterEffect1184ui_story.fillRatio = var_230_13
				end
			end

			if arg_227_1.time_ >= var_230_10 + var_230_11 and arg_227_1.time_ < var_230_10 + var_230_11 + arg_230_0 and not isNil(var_230_9) and arg_227_1.var_.characterEffect1184ui_story then
				local var_230_14 = 0.5

				arg_227_1.var_.characterEffect1184ui_story.fillFlat = true
				arg_227_1.var_.characterEffect1184ui_story.fillRatio = var_230_14
			end

			local var_230_15 = 0
			local var_230_16 = 0.625

			if var_230_15 < arg_227_1.time_ and arg_227_1.time_ <= var_230_15 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, false)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_227_1.iconTrs_.gameObject, false)
				arg_227_1.callingController_:SetSelectedState("normal")

				local var_230_17 = arg_227_1:GetWordFromCfg(121561055)
				local var_230_18 = arg_227_1:FormatText(var_230_17.content)

				arg_227_1.text_.text = var_230_18

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_19 = 25
				local var_230_20 = utf8.len(var_230_18)
				local var_230_21 = var_230_19 <= 0 and var_230_16 or var_230_16 * (var_230_20 / var_230_19)

				if var_230_21 > 0 and var_230_16 < var_230_21 then
					arg_227_1.talkMaxDuration = var_230_21

					if var_230_21 + var_230_15 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_21 + var_230_15
					end
				end

				arg_227_1.text_.text = var_230_18
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)
				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_22 = math.max(var_230_16, arg_227_1.talkMaxDuration)

			if var_230_15 <= arg_227_1.time_ and arg_227_1.time_ < var_230_15 + var_230_22 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_15) / var_230_22

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_15 + var_230_22 and arg_227_1.time_ < var_230_15 + var_230_22 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1184ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_227_1:InitPlayNodeList()
	end,
	Play121561056 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 121561056
		arg_231_1.duration_ = 5

		SetActive(arg_231_1.tipsGo_, false)

		function arg_231_1.onSingleLineFinish_()
			arg_231_1.onSingleLineUpdate_ = nil
			arg_231_1.onSingleLineFinish_ = nil
			arg_231_1.state_ = "waiting"
		end

		function arg_231_1.playNext_(arg_233_0)
			if arg_233_0 == 1 then
				arg_231_0:Play121561057(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			local var_234_0 = 0
			local var_234_1 = 1.75

			if var_234_0 < arg_231_1.time_ and arg_231_1.time_ <= var_234_0 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, false)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_231_1.iconTrs_.gameObject, false)
				arg_231_1.callingController_:SetSelectedState("normal")

				local var_234_2 = arg_231_1:GetWordFromCfg(121561056)
				local var_234_3 = arg_231_1:FormatText(var_234_2.content)

				arg_231_1.text_.text = var_234_3

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_4 = 70
				local var_234_5 = utf8.len(var_234_3)
				local var_234_6 = var_234_4 <= 0 and var_234_1 or var_234_1 * (var_234_5 / var_234_4)

				if var_234_6 > 0 and var_234_1 < var_234_6 then
					arg_231_1.talkMaxDuration = var_234_6

					if var_234_6 + var_234_0 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_6 + var_234_0
					end
				end

				arg_231_1.text_.text = var_234_3
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)
				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_7 = math.max(var_234_1, arg_231_1.talkMaxDuration)

			if var_234_0 <= arg_231_1.time_ and arg_231_1.time_ < var_234_0 + var_234_7 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_0) / var_234_7

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_0 + var_234_7 and arg_231_1.time_ < var_234_0 + var_234_7 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {}

		arg_231_1:InitPlayNodeList()
	end,
	Play121561057 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 121561057
		arg_235_1.duration_ = 5

		SetActive(arg_235_1.tipsGo_, false)

		function arg_235_1.onSingleLineFinish_()
			arg_235_1.onSingleLineUpdate_ = nil
			arg_235_1.onSingleLineFinish_ = nil
			arg_235_1.state_ = "waiting"
		end

		function arg_235_1.playNext_(arg_237_0)
			if arg_237_0 == 1 then
				arg_235_0:Play121561058(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			local var_238_0 = 0
			local var_238_1 = 1.075

			if var_238_0 < arg_235_1.time_ and arg_235_1.time_ <= var_238_0 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, false)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_235_1.iconTrs_.gameObject, false)
				arg_235_1.callingController_:SetSelectedState("normal")

				local var_238_2 = arg_235_1:GetWordFromCfg(121561057)
				local var_238_3 = arg_235_1:FormatText(var_238_2.content)

				arg_235_1.text_.text = var_238_3

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_4 = 43
				local var_238_5 = utf8.len(var_238_3)
				local var_238_6 = var_238_4 <= 0 and var_238_1 or var_238_1 * (var_238_5 / var_238_4)

				if var_238_6 > 0 and var_238_1 < var_238_6 then
					arg_235_1.talkMaxDuration = var_238_6

					if var_238_6 + var_238_0 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_6 + var_238_0
					end
				end

				arg_235_1.text_.text = var_238_3
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)
				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_7 = math.max(var_238_1, arg_235_1.talkMaxDuration)

			if var_238_0 <= arg_235_1.time_ and arg_235_1.time_ < var_238_0 + var_238_7 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_0) / var_238_7

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_0 + var_238_7 and arg_235_1.time_ < var_238_0 + var_238_7 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {}

		arg_235_1:InitPlayNodeList()
	end,
	Play121561058 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 121561058
		arg_239_1.duration_ = 5.03

		local var_239_0 = {
			ja = 5.033,
			ko = 5,
			zh = 5
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
				arg_239_0:Play121561059(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			local var_242_0 = arg_239_1.actors_["1184ui_story"].transform
			local var_242_1 = 0

			if var_242_1 < arg_239_1.time_ and arg_239_1.time_ <= var_242_1 + arg_242_0 then
				arg_239_1.var_.moveOldPos1184ui_story = var_242_0.localPosition
			end

			local var_242_2 = 0.001

			if var_242_1 <= arg_239_1.time_ and arg_239_1.time_ < var_242_1 + var_242_2 then
				local var_242_3 = (arg_239_1.time_ - var_242_1) / var_242_2
				local var_242_4 = Vector3.New(0, -0.97, -6)

				var_242_0.localPosition = Vector3.Lerp(arg_239_1.var_.moveOldPos1184ui_story, var_242_4, var_242_3)

				local var_242_5 = manager.ui.mainCamera.transform.position - var_242_0.position

				var_242_0.forward = Vector3.New(var_242_5.x, var_242_5.y, var_242_5.z)

				local var_242_6 = var_242_0.localEulerAngles

				var_242_6.z = 0
				var_242_6.x = 0
				var_242_0.localEulerAngles = var_242_6
			end

			if arg_239_1.time_ >= var_242_1 + var_242_2 and arg_239_1.time_ < var_242_1 + var_242_2 + arg_242_0 then
				var_242_0.localPosition = Vector3.New(0, -0.97, -6)

				local var_242_7 = manager.ui.mainCamera.transform.position - var_242_0.position

				var_242_0.forward = Vector3.New(var_242_7.x, var_242_7.y, var_242_7.z)

				local var_242_8 = var_242_0.localEulerAngles

				var_242_8.z = 0
				var_242_8.x = 0
				var_242_0.localEulerAngles = var_242_8
			end

			local var_242_9 = arg_239_1.actors_["1184ui_story"]
			local var_242_10 = 0

			if var_242_10 < arg_239_1.time_ and arg_239_1.time_ <= var_242_10 + arg_242_0 and not isNil(var_242_9) and arg_239_1.var_.characterEffect1184ui_story == nil then
				arg_239_1.var_.characterEffect1184ui_story = var_242_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_242_11 = 0.200000002980232

			if var_242_10 <= arg_239_1.time_ and arg_239_1.time_ < var_242_10 + var_242_11 and not isNil(var_242_9) then
				local var_242_12 = (arg_239_1.time_ - var_242_10) / var_242_11

				if arg_239_1.var_.characterEffect1184ui_story and not isNil(var_242_9) then
					arg_239_1.var_.characterEffect1184ui_story.fillFlat = false
				end
			end

			if arg_239_1.time_ >= var_242_10 + var_242_11 and arg_239_1.time_ < var_242_10 + var_242_11 + arg_242_0 and not isNil(var_242_9) and arg_239_1.var_.characterEffect1184ui_story then
				arg_239_1.var_.characterEffect1184ui_story.fillFlat = false
			end

			local var_242_13 = 0

			if var_242_13 < arg_239_1.time_ and arg_239_1.time_ <= var_242_13 + arg_242_0 then
				arg_239_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action4_1")
			end

			local var_242_14 = 0

			if var_242_14 < arg_239_1.time_ and arg_239_1.time_ <= var_242_14 + arg_242_0 then
				arg_239_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_242_15 = 0
			local var_242_16 = 0.4

			if var_242_15 < arg_239_1.time_ and arg_239_1.time_ <= var_242_15 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, true)

				local var_242_17 = arg_239_1:FormatText(StoryNameCfg[6].name)

				arg_239_1.leftNameTxt_.text = var_242_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_239_1.leftNameTxt_.transform)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1.leftNameTxt_.text)
				SetActive(arg_239_1.iconTrs_.gameObject, false)
				arg_239_1.callingController_:SetSelectedState("normal")

				local var_242_18 = arg_239_1:GetWordFromCfg(121561058)
				local var_242_19 = arg_239_1:FormatText(var_242_18.content)

				arg_239_1.text_.text = var_242_19

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_20 = 16
				local var_242_21 = utf8.len(var_242_19)
				local var_242_22 = var_242_20 <= 0 and var_242_16 or var_242_16 * (var_242_21 / var_242_20)

				if var_242_22 > 0 and var_242_16 < var_242_22 then
					arg_239_1.talkMaxDuration = var_242_22

					if var_242_22 + var_242_15 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_22 + var_242_15
					end
				end

				arg_239_1.text_.text = var_242_19
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121561", "121561058", "story_v_out_121561.awb") ~= 0 then
					local var_242_23 = manager.audio:GetVoiceLength("story_v_out_121561", "121561058", "story_v_out_121561.awb") / 1000

					if var_242_23 + var_242_15 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_23 + var_242_15
					end

					if var_242_18.prefab_name ~= "" and arg_239_1.actors_[var_242_18.prefab_name] ~= nil then
						local var_242_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_239_1.actors_[var_242_18.prefab_name].transform, "story_v_out_121561", "121561058", "story_v_out_121561.awb")

						arg_239_1:RecordAudio("121561058", var_242_24)
						arg_239_1:RecordAudio("121561058", var_242_24)
					else
						arg_239_1:AudioAction("play", "voice", "story_v_out_121561", "121561058", "story_v_out_121561.awb")
					end

					arg_239_1:RecordHistoryTalkVoice("story_v_out_121561", "121561058", "story_v_out_121561.awb")
				end

				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_25 = math.max(var_242_16, arg_239_1.talkMaxDuration)

			if var_242_15 <= arg_239_1.time_ and arg_239_1.time_ < var_242_15 + var_242_25 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_15) / var_242_25

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_15 + var_242_25 and arg_239_1.time_ < var_242_15 + var_242_25 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1184ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_239_1:InitPlayNodeList()
	end,
	Play121561059 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 121561059
		arg_243_1.duration_ = 4.43

		local var_243_0 = {
			ja = 4.433,
			ko = 2.8,
			zh = 2.8
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
				arg_243_0:Play121561060(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			local var_246_0 = 0

			if var_246_0 < arg_243_1.time_ and arg_243_1.time_ <= var_246_0 + arg_246_0 then
				arg_243_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action4_2")
			end

			local var_246_1 = 0

			if var_246_1 < arg_243_1.time_ and arg_243_1.time_ <= var_246_1 + arg_246_0 then
				arg_243_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_246_2 = 0
			local var_246_3 = 0.375

			if var_246_2 < arg_243_1.time_ and arg_243_1.time_ <= var_246_2 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, true)

				local var_246_4 = arg_243_1:FormatText(StoryNameCfg[6].name)

				arg_243_1.leftNameTxt_.text = var_246_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, false)
				arg_243_1.callingController_:SetSelectedState("normal")

				local var_246_5 = arg_243_1:GetWordFromCfg(121561059)
				local var_246_6 = arg_243_1:FormatText(var_246_5.content)

				arg_243_1.text_.text = var_246_6

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_7 = 15
				local var_246_8 = utf8.len(var_246_6)
				local var_246_9 = var_246_7 <= 0 and var_246_3 or var_246_3 * (var_246_8 / var_246_7)

				if var_246_9 > 0 and var_246_3 < var_246_9 then
					arg_243_1.talkMaxDuration = var_246_9

					if var_246_9 + var_246_2 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_9 + var_246_2
					end
				end

				arg_243_1.text_.text = var_246_6
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121561", "121561059", "story_v_out_121561.awb") ~= 0 then
					local var_246_10 = manager.audio:GetVoiceLength("story_v_out_121561", "121561059", "story_v_out_121561.awb") / 1000

					if var_246_10 + var_246_2 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_10 + var_246_2
					end

					if var_246_5.prefab_name ~= "" and arg_243_1.actors_[var_246_5.prefab_name] ~= nil then
						local var_246_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_243_1.actors_[var_246_5.prefab_name].transform, "story_v_out_121561", "121561059", "story_v_out_121561.awb")

						arg_243_1:RecordAudio("121561059", var_246_11)
						arg_243_1:RecordAudio("121561059", var_246_11)
					else
						arg_243_1:AudioAction("play", "voice", "story_v_out_121561", "121561059", "story_v_out_121561.awb")
					end

					arg_243_1:RecordHistoryTalkVoice("story_v_out_121561", "121561059", "story_v_out_121561.awb")
				end

				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_12 = math.max(var_246_3, arg_243_1.talkMaxDuration)

			if var_246_2 <= arg_243_1.time_ and arg_243_1.time_ < var_246_2 + var_246_12 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_2) / var_246_12

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_2 + var_246_12 and arg_243_1.time_ < var_246_2 + var_246_12 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {}

		arg_243_1:InitPlayNodeList()
	end,
	Play121561060 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 121561060
		arg_247_1.duration_ = 5

		SetActive(arg_247_1.tipsGo_, false)

		function arg_247_1.onSingleLineFinish_()
			arg_247_1.onSingleLineUpdate_ = nil
			arg_247_1.onSingleLineFinish_ = nil
			arg_247_1.state_ = "waiting"
		end

		function arg_247_1.playNext_(arg_249_0)
			if arg_249_0 == 1 then
				arg_247_0:Play121561061(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			local var_250_0 = arg_247_1.actors_["1184ui_story"]
			local var_250_1 = 0

			if var_250_1 < arg_247_1.time_ and arg_247_1.time_ <= var_250_1 + arg_250_0 and not isNil(var_250_0) and arg_247_1.var_.characterEffect1184ui_story == nil then
				arg_247_1.var_.characterEffect1184ui_story = var_250_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_250_2 = 0.200000002980232

			if var_250_1 <= arg_247_1.time_ and arg_247_1.time_ < var_250_1 + var_250_2 and not isNil(var_250_0) then
				local var_250_3 = (arg_247_1.time_ - var_250_1) / var_250_2

				if arg_247_1.var_.characterEffect1184ui_story and not isNil(var_250_0) then
					local var_250_4 = Mathf.Lerp(0, 0.5, var_250_3)

					arg_247_1.var_.characterEffect1184ui_story.fillFlat = true
					arg_247_1.var_.characterEffect1184ui_story.fillRatio = var_250_4
				end
			end

			if arg_247_1.time_ >= var_250_1 + var_250_2 and arg_247_1.time_ < var_250_1 + var_250_2 + arg_250_0 and not isNil(var_250_0) and arg_247_1.var_.characterEffect1184ui_story then
				local var_250_5 = 0.5

				arg_247_1.var_.characterEffect1184ui_story.fillFlat = true
				arg_247_1.var_.characterEffect1184ui_story.fillRatio = var_250_5
			end

			local var_250_6 = 0
			local var_250_7 = 0.975

			if var_250_6 < arg_247_1.time_ and arg_247_1.time_ <= var_250_6 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				local var_250_8 = arg_247_1:FormatText(StoryNameCfg[7].name)

				arg_247_1.leftNameTxt_.text = var_250_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, true)
				arg_247_1.iconController_:SetSelectedState("hero")

				arg_247_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_247_1.callingController_:SetSelectedState("normal")

				arg_247_1.keyicon_.color = Color.New(1, 1, 1)
				arg_247_1.icon_.color = Color.New(1, 1, 1)

				local var_250_9 = arg_247_1:GetWordFromCfg(121561060)
				local var_250_10 = arg_247_1:FormatText(var_250_9.content)

				arg_247_1.text_.text = var_250_10

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_11 = 39
				local var_250_12 = utf8.len(var_250_10)
				local var_250_13 = var_250_11 <= 0 and var_250_7 or var_250_7 * (var_250_12 / var_250_11)

				if var_250_13 > 0 and var_250_7 < var_250_13 then
					arg_247_1.talkMaxDuration = var_250_13

					if var_250_13 + var_250_6 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_13 + var_250_6
					end
				end

				arg_247_1.text_.text = var_250_10
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)
				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_14 = math.max(var_250_7, arg_247_1.talkMaxDuration)

			if var_250_6 <= arg_247_1.time_ and arg_247_1.time_ < var_250_6 + var_250_14 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_6) / var_250_14

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_6 + var_250_14 and arg_247_1.time_ < var_250_6 + var_250_14 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {}

		arg_247_1:InitPlayNodeList()
	end,
	Play121561061 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 121561061
		arg_251_1.duration_ = 5

		SetActive(arg_251_1.tipsGo_, false)

		function arg_251_1.onSingleLineFinish_()
			arg_251_1.onSingleLineUpdate_ = nil
			arg_251_1.onSingleLineFinish_ = nil
			arg_251_1.state_ = "waiting"
		end

		function arg_251_1.playNext_(arg_253_0)
			if arg_253_0 == 1 then
				arg_251_0:Play121561062(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			local var_254_0 = 0
			local var_254_1 = 1.125

			if var_254_0 < arg_251_1.time_ and arg_251_1.time_ <= var_254_0 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, true)

				local var_254_2 = arg_251_1:FormatText(StoryNameCfg[7].name)

				arg_251_1.leftNameTxt_.text = var_254_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_251_1.leftNameTxt_.transform)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1.leftNameTxt_.text)
				SetActive(arg_251_1.iconTrs_.gameObject, true)
				arg_251_1.iconController_:SetSelectedState("hero")

				arg_251_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_251_1.callingController_:SetSelectedState("normal")

				arg_251_1.keyicon_.color = Color.New(1, 1, 1)
				arg_251_1.icon_.color = Color.New(1, 1, 1)

				local var_254_3 = arg_251_1:GetWordFromCfg(121561061)
				local var_254_4 = arg_251_1:FormatText(var_254_3.content)

				arg_251_1.text_.text = var_254_4

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_5 = 45
				local var_254_6 = utf8.len(var_254_4)
				local var_254_7 = var_254_5 <= 0 and var_254_1 or var_254_1 * (var_254_6 / var_254_5)

				if var_254_7 > 0 and var_254_1 < var_254_7 then
					arg_251_1.talkMaxDuration = var_254_7

					if var_254_7 + var_254_0 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_7 + var_254_0
					end
				end

				arg_251_1.text_.text = var_254_4
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)
				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_8 = math.max(var_254_1, arg_251_1.talkMaxDuration)

			if var_254_0 <= arg_251_1.time_ and arg_251_1.time_ < var_254_0 + var_254_8 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - var_254_0) / var_254_8

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= var_254_0 + var_254_8 and arg_251_1.time_ < var_254_0 + var_254_8 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {}

		arg_251_1:InitPlayNodeList()
	end,
	Play121561062 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 121561062
		arg_255_1.duration_ = 3.63

		local var_255_0 = {
			ja = 2.166,
			ko = 3.633,
			zh = 3.633
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
				arg_255_0:Play121561063(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			local var_258_0 = 0
			local var_258_1 = 0.375

			if var_258_0 < arg_255_1.time_ and arg_255_1.time_ <= var_258_0 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, true)

				local var_258_2 = arg_255_1:FormatText(StoryNameCfg[36].name)

				arg_255_1.leftNameTxt_.text = var_258_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_255_1.leftNameTxt_.transform)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1.leftNameTxt_.text)
				SetActive(arg_255_1.iconTrs_.gameObject, false)
				arg_255_1.callingController_:SetSelectedState("normal")

				local var_258_3 = arg_255_1:GetWordFromCfg(121561062)
				local var_258_4 = arg_255_1:FormatText(var_258_3.content)

				arg_255_1.text_.text = var_258_4

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_5 = 15
				local var_258_6 = utf8.len(var_258_4)
				local var_258_7 = var_258_5 <= 0 and var_258_1 or var_258_1 * (var_258_6 / var_258_5)

				if var_258_7 > 0 and var_258_1 < var_258_7 then
					arg_255_1.talkMaxDuration = var_258_7

					if var_258_7 + var_258_0 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_7 + var_258_0
					end
				end

				arg_255_1.text_.text = var_258_4
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121561", "121561062", "story_v_out_121561.awb") ~= 0 then
					local var_258_8 = manager.audio:GetVoiceLength("story_v_out_121561", "121561062", "story_v_out_121561.awb") / 1000

					if var_258_8 + var_258_0 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_8 + var_258_0
					end

					if var_258_3.prefab_name ~= "" and arg_255_1.actors_[var_258_3.prefab_name] ~= nil then
						local var_258_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_255_1.actors_[var_258_3.prefab_name].transform, "story_v_out_121561", "121561062", "story_v_out_121561.awb")

						arg_255_1:RecordAudio("121561062", var_258_9)
						arg_255_1:RecordAudio("121561062", var_258_9)
					else
						arg_255_1:AudioAction("play", "voice", "story_v_out_121561", "121561062", "story_v_out_121561.awb")
					end

					arg_255_1:RecordHistoryTalkVoice("story_v_out_121561", "121561062", "story_v_out_121561.awb")
				end

				arg_255_1:RecordContent(arg_255_1.text_.text)
			end

			local var_258_10 = math.max(var_258_1, arg_255_1.talkMaxDuration)

			if var_258_0 <= arg_255_1.time_ and arg_255_1.time_ < var_258_0 + var_258_10 then
				arg_255_1.typewritter.percent = (arg_255_1.time_ - var_258_0) / var_258_10

				arg_255_1.typewritter:SetDirty()
			end

			if arg_255_1.time_ >= var_258_0 + var_258_10 and arg_255_1.time_ < var_258_0 + var_258_10 + arg_258_0 then
				arg_255_1.typewritter.percent = 1

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(true)
			end
		end

		arg_255_1.nodeConfigList_ = {}

		arg_255_1:InitPlayNodeList()
	end,
	Play121561063 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 121561063
		arg_259_1.duration_ = 5

		SetActive(arg_259_1.tipsGo_, false)

		function arg_259_1.onSingleLineFinish_()
			arg_259_1.onSingleLineUpdate_ = nil
			arg_259_1.onSingleLineFinish_ = nil
			arg_259_1.state_ = "waiting"
		end

		function arg_259_1.playNext_(arg_261_0)
			if arg_261_0 == 1 then
				arg_259_0:Play121561064(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			local var_262_0 = arg_259_1.actors_["1184ui_story"].transform
			local var_262_1 = 0

			if var_262_1 < arg_259_1.time_ and arg_259_1.time_ <= var_262_1 + arg_262_0 then
				arg_259_1.var_.moveOldPos1184ui_story = var_262_0.localPosition
			end

			local var_262_2 = 0.001

			if var_262_1 <= arg_259_1.time_ and arg_259_1.time_ < var_262_1 + var_262_2 then
				local var_262_3 = (arg_259_1.time_ - var_262_1) / var_262_2
				local var_262_4 = Vector3.New(0, 100, 0)

				var_262_0.localPosition = Vector3.Lerp(arg_259_1.var_.moveOldPos1184ui_story, var_262_4, var_262_3)

				local var_262_5 = manager.ui.mainCamera.transform.position - var_262_0.position

				var_262_0.forward = Vector3.New(var_262_5.x, var_262_5.y, var_262_5.z)

				local var_262_6 = var_262_0.localEulerAngles

				var_262_6.z = 0
				var_262_6.x = 0
				var_262_0.localEulerAngles = var_262_6
			end

			if arg_259_1.time_ >= var_262_1 + var_262_2 and arg_259_1.time_ < var_262_1 + var_262_2 + arg_262_0 then
				var_262_0.localPosition = Vector3.New(0, 100, 0)

				local var_262_7 = manager.ui.mainCamera.transform.position - var_262_0.position

				var_262_0.forward = Vector3.New(var_262_7.x, var_262_7.y, var_262_7.z)

				local var_262_8 = var_262_0.localEulerAngles

				var_262_8.z = 0
				var_262_8.x = 0
				var_262_0.localEulerAngles = var_262_8
			end

			local var_262_9 = arg_259_1.actors_["1184ui_story"]
			local var_262_10 = 0

			if var_262_10 < arg_259_1.time_ and arg_259_1.time_ <= var_262_10 + arg_262_0 and not isNil(var_262_9) and arg_259_1.var_.characterEffect1184ui_story == nil then
				arg_259_1.var_.characterEffect1184ui_story = var_262_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_262_11 = 0.200000002980232

			if var_262_10 <= arg_259_1.time_ and arg_259_1.time_ < var_262_10 + var_262_11 and not isNil(var_262_9) then
				local var_262_12 = (arg_259_1.time_ - var_262_10) / var_262_11

				if arg_259_1.var_.characterEffect1184ui_story and not isNil(var_262_9) then
					local var_262_13 = Mathf.Lerp(0, 0.5, var_262_12)

					arg_259_1.var_.characterEffect1184ui_story.fillFlat = true
					arg_259_1.var_.characterEffect1184ui_story.fillRatio = var_262_13
				end
			end

			if arg_259_1.time_ >= var_262_10 + var_262_11 and arg_259_1.time_ < var_262_10 + var_262_11 + arg_262_0 and not isNil(var_262_9) and arg_259_1.var_.characterEffect1184ui_story then
				local var_262_14 = 0.5

				arg_259_1.var_.characterEffect1184ui_story.fillFlat = true
				arg_259_1.var_.characterEffect1184ui_story.fillRatio = var_262_14
			end

			local var_262_15 = "1071ui_story"

			if arg_259_1.actors_[var_262_15] == nil then
				local var_262_16 = Asset.Load("Char/" .. "1071ui_story")

				if not isNil(var_262_16) then
					local var_262_17 = Object.Instantiate(Asset.Load("Char/" .. "1071ui_story"), arg_259_1.stage_.transform)

					var_262_17.name = var_262_15
					var_262_17.transform.localPosition = Vector3.New(0, 100, 0)
					arg_259_1.actors_[var_262_15] = var_262_17

					local var_262_18 = var_262_17:GetComponentInChildren(typeof(CharacterEffect))

					var_262_18.enabled = true

					local var_262_19 = GameObjectTools.GetOrAddComponent(var_262_17, typeof(DynamicBoneHelper))

					if var_262_19 then
						var_262_19:EnableDynamicBone(false)
					end

					arg_259_1:ShowWeapon(var_262_18.transform, false)

					arg_259_1.var_[var_262_15 .. "Animator"] = var_262_18.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_259_1.var_[var_262_15 .. "Animator"].applyRootMotion = true
					arg_259_1.var_[var_262_15 .. "LipSync"] = var_262_18.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_262_20 = 0

			if var_262_20 < arg_259_1.time_ and arg_259_1.time_ <= var_262_20 + arg_262_0 then
				arg_259_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_262_21 = 0
			local var_262_22 = 1.1

			if var_262_21 < arg_259_1.time_ and arg_259_1.time_ <= var_262_21 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0
				arg_259_1.dialogCg_.alpha = 1

				arg_259_1.dialog_:SetActive(true)
				SetActive(arg_259_1.leftNameGo_, false)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_259_1.iconTrs_.gameObject, false)
				arg_259_1.callingController_:SetSelectedState("normal")

				local var_262_23 = arg_259_1:GetWordFromCfg(121561063)
				local var_262_24 = arg_259_1:FormatText(var_262_23.content)

				arg_259_1.text_.text = var_262_24

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_25 = 44
				local var_262_26 = utf8.len(var_262_24)
				local var_262_27 = var_262_25 <= 0 and var_262_22 or var_262_22 * (var_262_26 / var_262_25)

				if var_262_27 > 0 and var_262_22 < var_262_27 then
					arg_259_1.talkMaxDuration = var_262_27

					if var_262_27 + var_262_21 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_27 + var_262_21
					end
				end

				arg_259_1.text_.text = var_262_24
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)
				arg_259_1:RecordContent(arg_259_1.text_.text)
			end

			local var_262_28 = math.max(var_262_22, arg_259_1.talkMaxDuration)

			if var_262_21 <= arg_259_1.time_ and arg_259_1.time_ < var_262_21 + var_262_28 then
				arg_259_1.typewritter.percent = (arg_259_1.time_ - var_262_21) / var_262_28

				arg_259_1.typewritter:SetDirty()
			end

			if arg_259_1.time_ >= var_262_21 + var_262_28 and arg_259_1.time_ < var_262_21 + var_262_28 + arg_262_0 then
				arg_259_1.typewritter.percent = 1

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(true)
			end
		end

		arg_259_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1184ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_259_1:InitPlayNodeList()
	end,
	Play121561064 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 121561064
		arg_263_1.duration_ = 5

		SetActive(arg_263_1.tipsGo_, false)

		function arg_263_1.onSingleLineFinish_()
			arg_263_1.onSingleLineUpdate_ = nil
			arg_263_1.onSingleLineFinish_ = nil
			arg_263_1.state_ = "waiting"
		end

		function arg_263_1.playNext_(arg_265_0)
			if arg_265_0 == 1 then
				arg_263_0:Play121561065(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			local var_266_0 = arg_263_1.actors_["1071ui_story"].transform
			local var_266_1 = 0

			if var_266_1 < arg_263_1.time_ and arg_263_1.time_ <= var_266_1 + arg_266_0 then
				arg_263_1.var_.moveOldPos1071ui_story = var_266_0.localPosition
			end

			local var_266_2 = 0.001

			if var_266_1 <= arg_263_1.time_ and arg_263_1.time_ < var_266_1 + var_266_2 then
				local var_266_3 = (arg_263_1.time_ - var_266_1) / var_266_2
				local var_266_4 = Vector3.New(0, -1.05, -6.2)

				var_266_0.localPosition = Vector3.Lerp(arg_263_1.var_.moveOldPos1071ui_story, var_266_4, var_266_3)

				local var_266_5 = manager.ui.mainCamera.transform.position - var_266_0.position

				var_266_0.forward = Vector3.New(var_266_5.x, var_266_5.y, var_266_5.z)

				local var_266_6 = var_266_0.localEulerAngles

				var_266_6.z = 0
				var_266_6.x = 0
				var_266_0.localEulerAngles = var_266_6
			end

			if arg_263_1.time_ >= var_266_1 + var_266_2 and arg_263_1.time_ < var_266_1 + var_266_2 + arg_266_0 then
				var_266_0.localPosition = Vector3.New(0, -1.05, -6.2)

				local var_266_7 = manager.ui.mainCamera.transform.position - var_266_0.position

				var_266_0.forward = Vector3.New(var_266_7.x, var_266_7.y, var_266_7.z)

				local var_266_8 = var_266_0.localEulerAngles

				var_266_8.z = 0
				var_266_8.x = 0
				var_266_0.localEulerAngles = var_266_8
			end

			local var_266_9 = arg_263_1.actors_["1071ui_story"]
			local var_266_10 = 0

			if var_266_10 < arg_263_1.time_ and arg_263_1.time_ <= var_266_10 + arg_266_0 and not isNil(var_266_9) and arg_263_1.var_.characterEffect1071ui_story == nil then
				arg_263_1.var_.characterEffect1071ui_story = var_266_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_266_11 = 0.200000002980232

			if var_266_10 <= arg_263_1.time_ and arg_263_1.time_ < var_266_10 + var_266_11 and not isNil(var_266_9) then
				local var_266_12 = (arg_263_1.time_ - var_266_10) / var_266_11

				if arg_263_1.var_.characterEffect1071ui_story and not isNil(var_266_9) then
					local var_266_13 = Mathf.Lerp(0, 0.5, var_266_12)

					arg_263_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_263_1.var_.characterEffect1071ui_story.fillRatio = var_266_13
				end
			end

			if arg_263_1.time_ >= var_266_10 + var_266_11 and arg_263_1.time_ < var_266_10 + var_266_11 + arg_266_0 and not isNil(var_266_9) and arg_263_1.var_.characterEffect1071ui_story then
				local var_266_14 = 0.5

				arg_263_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_263_1.var_.characterEffect1071ui_story.fillRatio = var_266_14
			end

			local var_266_15 = 0

			if var_266_15 < arg_263_1.time_ and arg_263_1.time_ <= var_266_15 + arg_266_0 then
				arg_263_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action1_1")
			end

			local var_266_16 = 0
			local var_266_17 = 0.875

			if var_266_16 < arg_263_1.time_ and arg_263_1.time_ <= var_266_16 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0
				arg_263_1.dialogCg_.alpha = 1

				arg_263_1.dialog_:SetActive(true)
				SetActive(arg_263_1.leftNameGo_, true)

				local var_266_18 = arg_263_1:FormatText(StoryNameCfg[7].name)

				arg_263_1.leftNameTxt_.text = var_266_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_263_1.leftNameTxt_.transform)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1.leftNameTxt_.text)
				SetActive(arg_263_1.iconTrs_.gameObject, true)
				arg_263_1.iconController_:SetSelectedState("hero")

				arg_263_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_263_1.callingController_:SetSelectedState("normal")

				arg_263_1.keyicon_.color = Color.New(1, 1, 1)
				arg_263_1.icon_.color = Color.New(1, 1, 1)

				local var_266_19 = arg_263_1:GetWordFromCfg(121561064)
				local var_266_20 = arg_263_1:FormatText(var_266_19.content)

				arg_263_1.text_.text = var_266_20

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_21 = 35
				local var_266_22 = utf8.len(var_266_20)
				local var_266_23 = var_266_21 <= 0 and var_266_17 or var_266_17 * (var_266_22 / var_266_21)

				if var_266_23 > 0 and var_266_17 < var_266_23 then
					arg_263_1.talkMaxDuration = var_266_23

					if var_266_23 + var_266_16 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_23 + var_266_16
					end
				end

				arg_263_1.text_.text = var_266_20
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)
				arg_263_1:RecordContent(arg_263_1.text_.text)
			end

			local var_266_24 = math.max(var_266_17, arg_263_1.talkMaxDuration)

			if var_266_16 <= arg_263_1.time_ and arg_263_1.time_ < var_266_16 + var_266_24 then
				arg_263_1.typewritter.percent = (arg_263_1.time_ - var_266_16) / var_266_24

				arg_263_1.typewritter:SetDirty()
			end

			if arg_263_1.time_ >= var_266_16 + var_266_24 and arg_263_1.time_ < var_266_16 + var_266_24 + arg_266_0 then
				arg_263_1.typewritter.percent = 1

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(true)
			end
		end

		arg_263_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_263_1:InitPlayNodeList()
	end,
	Play121561065 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 121561065
		arg_267_1.duration_ = 12.97

		local var_267_0 = {
			ja = 12.966,
			ko = 9.933,
			zh = 9.933
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
				arg_267_0:Play121561066(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			local var_270_0 = arg_267_1.actors_["1071ui_story"]
			local var_270_1 = 0

			if var_270_1 < arg_267_1.time_ and arg_267_1.time_ <= var_270_1 + arg_270_0 and not isNil(var_270_0) and arg_267_1.var_.characterEffect1071ui_story == nil then
				arg_267_1.var_.characterEffect1071ui_story = var_270_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_270_2 = 0.200000002980232

			if var_270_1 <= arg_267_1.time_ and arg_267_1.time_ < var_270_1 + var_270_2 and not isNil(var_270_0) then
				local var_270_3 = (arg_267_1.time_ - var_270_1) / var_270_2

				if arg_267_1.var_.characterEffect1071ui_story and not isNil(var_270_0) then
					arg_267_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_267_1.time_ >= var_270_1 + var_270_2 and arg_267_1.time_ < var_270_1 + var_270_2 + arg_270_0 and not isNil(var_270_0) and arg_267_1.var_.characterEffect1071ui_story then
				arg_267_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_270_4 = 0

			if var_270_4 < arg_267_1.time_ and arg_267_1.time_ <= var_270_4 + arg_270_0 then
				arg_267_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action1_1")
			end

			local var_270_5 = 0
			local var_270_6 = 1.3

			if var_270_5 < arg_267_1.time_ and arg_267_1.time_ <= var_270_5 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0
				arg_267_1.dialogCg_.alpha = 1

				arg_267_1.dialog_:SetActive(true)
				SetActive(arg_267_1.leftNameGo_, true)

				local var_270_7 = arg_267_1:FormatText(StoryNameCfg[384].name)

				arg_267_1.leftNameTxt_.text = var_270_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_267_1.leftNameTxt_.transform)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1.leftNameTxt_.text)
				SetActive(arg_267_1.iconTrs_.gameObject, false)
				arg_267_1.callingController_:SetSelectedState("normal")

				local var_270_8 = arg_267_1:GetWordFromCfg(121561065)
				local var_270_9 = arg_267_1:FormatText(var_270_8.content)

				arg_267_1.text_.text = var_270_9

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_10 = 52
				local var_270_11 = utf8.len(var_270_9)
				local var_270_12 = var_270_10 <= 0 and var_270_6 or var_270_6 * (var_270_11 / var_270_10)

				if var_270_12 > 0 and var_270_6 < var_270_12 then
					arg_267_1.talkMaxDuration = var_270_12

					if var_270_12 + var_270_5 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_12 + var_270_5
					end
				end

				arg_267_1.text_.text = var_270_9
				arg_267_1.typewritter.percent = 0

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121561", "121561065", "story_v_out_121561.awb") ~= 0 then
					local var_270_13 = manager.audio:GetVoiceLength("story_v_out_121561", "121561065", "story_v_out_121561.awb") / 1000

					if var_270_13 + var_270_5 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_13 + var_270_5
					end

					if var_270_8.prefab_name ~= "" and arg_267_1.actors_[var_270_8.prefab_name] ~= nil then
						local var_270_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_267_1.actors_[var_270_8.prefab_name].transform, "story_v_out_121561", "121561065", "story_v_out_121561.awb")

						arg_267_1:RecordAudio("121561065", var_270_14)
						arg_267_1:RecordAudio("121561065", var_270_14)
					else
						arg_267_1:AudioAction("play", "voice", "story_v_out_121561", "121561065", "story_v_out_121561.awb")
					end

					arg_267_1:RecordHistoryTalkVoice("story_v_out_121561", "121561065", "story_v_out_121561.awb")
				end

				arg_267_1:RecordContent(arg_267_1.text_.text)
			end

			local var_270_15 = math.max(var_270_6, arg_267_1.talkMaxDuration)

			if var_270_5 <= arg_267_1.time_ and arg_267_1.time_ < var_270_5 + var_270_15 then
				arg_267_1.typewritter.percent = (arg_267_1.time_ - var_270_5) / var_270_15

				arg_267_1.typewritter:SetDirty()
			end

			if arg_267_1.time_ >= var_270_5 + var_270_15 and arg_267_1.time_ < var_270_5 + var_270_15 + arg_270_0 then
				arg_267_1.typewritter.percent = 1

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(true)
			end
		end

		arg_267_1.nodeConfigList_ = {}

		arg_267_1:InitPlayNodeList()
	end,
	Play121561066 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 121561066
		arg_271_1.duration_ = 5

		SetActive(arg_271_1.tipsGo_, false)

		function arg_271_1.onSingleLineFinish_()
			arg_271_1.onSingleLineUpdate_ = nil
			arg_271_1.onSingleLineFinish_ = nil
			arg_271_1.state_ = "waiting"
		end

		function arg_271_1.playNext_(arg_273_0)
			if arg_273_0 == 1 then
				arg_271_0:Play121561067(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			local var_274_0 = arg_271_1.actors_["1071ui_story"]
			local var_274_1 = 0

			if var_274_1 < arg_271_1.time_ and arg_271_1.time_ <= var_274_1 + arg_274_0 and not isNil(var_274_0) and arg_271_1.var_.characterEffect1071ui_story == nil then
				arg_271_1.var_.characterEffect1071ui_story = var_274_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_274_2 = 0.200000002980232

			if var_274_1 <= arg_271_1.time_ and arg_271_1.time_ < var_274_1 + var_274_2 and not isNil(var_274_0) then
				local var_274_3 = (arg_271_1.time_ - var_274_1) / var_274_2

				if arg_271_1.var_.characterEffect1071ui_story and not isNil(var_274_0) then
					local var_274_4 = Mathf.Lerp(0, 0.5, var_274_3)

					arg_271_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_271_1.var_.characterEffect1071ui_story.fillRatio = var_274_4
				end
			end

			if arg_271_1.time_ >= var_274_1 + var_274_2 and arg_271_1.time_ < var_274_1 + var_274_2 + arg_274_0 and not isNil(var_274_0) and arg_271_1.var_.characterEffect1071ui_story then
				local var_274_5 = 0.5

				arg_271_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_271_1.var_.characterEffect1071ui_story.fillRatio = var_274_5
			end

			local var_274_6 = 0
			local var_274_7 = 0.225

			if var_274_6 < arg_271_1.time_ and arg_271_1.time_ <= var_274_6 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, true)

				local var_274_8 = arg_271_1:FormatText(StoryNameCfg[7].name)

				arg_271_1.leftNameTxt_.text = var_274_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_271_1.leftNameTxt_.transform)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1.leftNameTxt_.text)
				SetActive(arg_271_1.iconTrs_.gameObject, true)
				arg_271_1.iconController_:SetSelectedState("hero")

				arg_271_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_271_1.callingController_:SetSelectedState("normal")

				arg_271_1.keyicon_.color = Color.New(1, 1, 1)
				arg_271_1.icon_.color = Color.New(1, 1, 1)

				local var_274_9 = arg_271_1:GetWordFromCfg(121561066)
				local var_274_10 = arg_271_1:FormatText(var_274_9.content)

				arg_271_1.text_.text = var_274_10

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_11 = 9
				local var_274_12 = utf8.len(var_274_10)
				local var_274_13 = var_274_11 <= 0 and var_274_7 or var_274_7 * (var_274_12 / var_274_11)

				if var_274_13 > 0 and var_274_7 < var_274_13 then
					arg_271_1.talkMaxDuration = var_274_13

					if var_274_13 + var_274_6 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_13 + var_274_6
					end
				end

				arg_271_1.text_.text = var_274_10
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)
				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_14 = math.max(var_274_7, arg_271_1.talkMaxDuration)

			if var_274_6 <= arg_271_1.time_ and arg_271_1.time_ < var_274_6 + var_274_14 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - var_274_6) / var_274_14

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= var_274_6 + var_274_14 and arg_271_1.time_ < var_274_6 + var_274_14 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {}

		arg_271_1:InitPlayNodeList()
	end,
	Play121561067 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 121561067
		arg_275_1.duration_ = 10.73

		local var_275_0 = {
			ja = 10.733,
			ko = 7.6,
			zh = 7.6
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
				arg_275_0:Play121561068(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			local var_278_0 = arg_275_1.actors_["1071ui_story"]
			local var_278_1 = 0

			if var_278_1 < arg_275_1.time_ and arg_275_1.time_ <= var_278_1 + arg_278_0 and not isNil(var_278_0) and arg_275_1.var_.characterEffect1071ui_story == nil then
				arg_275_1.var_.characterEffect1071ui_story = var_278_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_278_2 = 0.200000002980232

			if var_278_1 <= arg_275_1.time_ and arg_275_1.time_ < var_278_1 + var_278_2 and not isNil(var_278_0) then
				local var_278_3 = (arg_275_1.time_ - var_278_1) / var_278_2

				if arg_275_1.var_.characterEffect1071ui_story and not isNil(var_278_0) then
					arg_275_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_275_1.time_ >= var_278_1 + var_278_2 and arg_275_1.time_ < var_278_1 + var_278_2 + arg_278_0 and not isNil(var_278_0) and arg_275_1.var_.characterEffect1071ui_story then
				arg_275_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_278_4 = 0

			if var_278_4 < arg_275_1.time_ and arg_275_1.time_ <= var_278_4 + arg_278_0 then
				arg_275_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action5_1")
			end

			local var_278_5 = 0
			local var_278_6 = 0.925

			if var_278_5 < arg_275_1.time_ and arg_275_1.time_ <= var_278_5 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0
				arg_275_1.dialogCg_.alpha = 1

				arg_275_1.dialog_:SetActive(true)
				SetActive(arg_275_1.leftNameGo_, true)

				local var_278_7 = arg_275_1:FormatText(StoryNameCfg[384].name)

				arg_275_1.leftNameTxt_.text = var_278_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_275_1.leftNameTxt_.transform)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1.leftNameTxt_.text)
				SetActive(arg_275_1.iconTrs_.gameObject, false)
				arg_275_1.callingController_:SetSelectedState("normal")

				local var_278_8 = arg_275_1:GetWordFromCfg(121561067)
				local var_278_9 = arg_275_1:FormatText(var_278_8.content)

				arg_275_1.text_.text = var_278_9

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_10 = 37
				local var_278_11 = utf8.len(var_278_9)
				local var_278_12 = var_278_10 <= 0 and var_278_6 or var_278_6 * (var_278_11 / var_278_10)

				if var_278_12 > 0 and var_278_6 < var_278_12 then
					arg_275_1.talkMaxDuration = var_278_12

					if var_278_12 + var_278_5 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_12 + var_278_5
					end
				end

				arg_275_1.text_.text = var_278_9
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121561", "121561067", "story_v_out_121561.awb") ~= 0 then
					local var_278_13 = manager.audio:GetVoiceLength("story_v_out_121561", "121561067", "story_v_out_121561.awb") / 1000

					if var_278_13 + var_278_5 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_13 + var_278_5
					end

					if var_278_8.prefab_name ~= "" and arg_275_1.actors_[var_278_8.prefab_name] ~= nil then
						local var_278_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_275_1.actors_[var_278_8.prefab_name].transform, "story_v_out_121561", "121561067", "story_v_out_121561.awb")

						arg_275_1:RecordAudio("121561067", var_278_14)
						arg_275_1:RecordAudio("121561067", var_278_14)
					else
						arg_275_1:AudioAction("play", "voice", "story_v_out_121561", "121561067", "story_v_out_121561.awb")
					end

					arg_275_1:RecordHistoryTalkVoice("story_v_out_121561", "121561067", "story_v_out_121561.awb")
				end

				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_15 = math.max(var_278_6, arg_275_1.talkMaxDuration)

			if var_278_5 <= arg_275_1.time_ and arg_275_1.time_ < var_278_5 + var_278_15 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - var_278_5) / var_278_15

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= var_278_5 + var_278_15 and arg_275_1.time_ < var_278_5 + var_278_15 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {}

		arg_275_1:InitPlayNodeList()
	end,
	Play121561068 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 121561068
		arg_279_1.duration_ = 6.23

		local var_279_0 = {
			ja = 6.233,
			ko = 5.1,
			zh = 5.1
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
				arg_279_0:Play121561069(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			local var_282_0 = 0

			if var_282_0 < arg_279_1.time_ and arg_279_1.time_ <= var_282_0 + arg_282_0 then
				arg_279_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action5_2")
			end

			local var_282_1 = 0
			local var_282_2 = 0.65

			if var_282_1 < arg_279_1.time_ and arg_279_1.time_ <= var_282_1 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0
				arg_279_1.dialogCg_.alpha = 1

				arg_279_1.dialog_:SetActive(true)
				SetActive(arg_279_1.leftNameGo_, true)

				local var_282_3 = arg_279_1:FormatText(StoryNameCfg[384].name)

				arg_279_1.leftNameTxt_.text = var_282_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_279_1.leftNameTxt_.transform)

				arg_279_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_279_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_279_1:RecordName(arg_279_1.leftNameTxt_.text)
				SetActive(arg_279_1.iconTrs_.gameObject, false)
				arg_279_1.callingController_:SetSelectedState("normal")

				local var_282_4 = arg_279_1:GetWordFromCfg(121561068)
				local var_282_5 = arg_279_1:FormatText(var_282_4.content)

				arg_279_1.text_.text = var_282_5

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_6 = 26
				local var_282_7 = utf8.len(var_282_5)
				local var_282_8 = var_282_6 <= 0 and var_282_2 or var_282_2 * (var_282_7 / var_282_6)

				if var_282_8 > 0 and var_282_2 < var_282_8 then
					arg_279_1.talkMaxDuration = var_282_8

					if var_282_8 + var_282_1 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_8 + var_282_1
					end
				end

				arg_279_1.text_.text = var_282_5
				arg_279_1.typewritter.percent = 0

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121561", "121561068", "story_v_out_121561.awb") ~= 0 then
					local var_282_9 = manager.audio:GetVoiceLength("story_v_out_121561", "121561068", "story_v_out_121561.awb") / 1000

					if var_282_9 + var_282_1 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_9 + var_282_1
					end

					if var_282_4.prefab_name ~= "" and arg_279_1.actors_[var_282_4.prefab_name] ~= nil then
						local var_282_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_279_1.actors_[var_282_4.prefab_name].transform, "story_v_out_121561", "121561068", "story_v_out_121561.awb")

						arg_279_1:RecordAudio("121561068", var_282_10)
						arg_279_1:RecordAudio("121561068", var_282_10)
					else
						arg_279_1:AudioAction("play", "voice", "story_v_out_121561", "121561068", "story_v_out_121561.awb")
					end

					arg_279_1:RecordHistoryTalkVoice("story_v_out_121561", "121561068", "story_v_out_121561.awb")
				end

				arg_279_1:RecordContent(arg_279_1.text_.text)
			end

			local var_282_11 = math.max(var_282_2, arg_279_1.talkMaxDuration)

			if var_282_1 <= arg_279_1.time_ and arg_279_1.time_ < var_282_1 + var_282_11 then
				arg_279_1.typewritter.percent = (arg_279_1.time_ - var_282_1) / var_282_11

				arg_279_1.typewritter:SetDirty()
			end

			if arg_279_1.time_ >= var_282_1 + var_282_11 and arg_279_1.time_ < var_282_1 + var_282_11 + arg_282_0 then
				arg_279_1.typewritter.percent = 1

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(true)
			end
		end

		arg_279_1.nodeConfigList_ = {}

		arg_279_1:InitPlayNodeList()
	end,
	Play121561069 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 121561069
		arg_283_1.duration_ = 9.67

		local var_283_0 = {
			ja = 9.666,
			ko = 6.166,
			zh = 6.166
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
				arg_283_0:Play121561070(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			local var_286_0 = arg_283_1.actors_["1071ui_story"].transform
			local var_286_1 = 0

			if var_286_1 < arg_283_1.time_ and arg_283_1.time_ <= var_286_1 + arg_286_0 then
				arg_283_1.var_.moveOldPos1071ui_story = var_286_0.localPosition
			end

			local var_286_2 = 0.001

			if var_286_1 <= arg_283_1.time_ and arg_283_1.time_ < var_286_1 + var_286_2 then
				local var_286_3 = (arg_283_1.time_ - var_286_1) / var_286_2
				local var_286_4 = Vector3.New(-0.7, -1.05, -6.2)

				var_286_0.localPosition = Vector3.Lerp(arg_283_1.var_.moveOldPos1071ui_story, var_286_4, var_286_3)

				local var_286_5 = manager.ui.mainCamera.transform.position - var_286_0.position

				var_286_0.forward = Vector3.New(var_286_5.x, var_286_5.y, var_286_5.z)

				local var_286_6 = var_286_0.localEulerAngles

				var_286_6.z = 0
				var_286_6.x = 0
				var_286_0.localEulerAngles = var_286_6
			end

			if arg_283_1.time_ >= var_286_1 + var_286_2 and arg_283_1.time_ < var_286_1 + var_286_2 + arg_286_0 then
				var_286_0.localPosition = Vector3.New(-0.7, -1.05, -6.2)

				local var_286_7 = manager.ui.mainCamera.transform.position - var_286_0.position

				var_286_0.forward = Vector3.New(var_286_7.x, var_286_7.y, var_286_7.z)

				local var_286_8 = var_286_0.localEulerAngles

				var_286_8.z = 0
				var_286_8.x = 0
				var_286_0.localEulerAngles = var_286_8
			end

			local var_286_9 = arg_283_1.actors_["1071ui_story"]
			local var_286_10 = 0

			if var_286_10 < arg_283_1.time_ and arg_283_1.time_ <= var_286_10 + arg_286_0 and not isNil(var_286_9) and arg_283_1.var_.characterEffect1071ui_story == nil then
				arg_283_1.var_.characterEffect1071ui_story = var_286_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_286_11 = 0.200000002980232

			if var_286_10 <= arg_283_1.time_ and arg_283_1.time_ < var_286_10 + var_286_11 and not isNil(var_286_9) then
				local var_286_12 = (arg_283_1.time_ - var_286_10) / var_286_11

				if arg_283_1.var_.characterEffect1071ui_story and not isNil(var_286_9) then
					local var_286_13 = Mathf.Lerp(0, 0.5, var_286_12)

					arg_283_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_283_1.var_.characterEffect1071ui_story.fillRatio = var_286_13
				end
			end

			if arg_283_1.time_ >= var_286_10 + var_286_11 and arg_283_1.time_ < var_286_10 + var_286_11 + arg_286_0 and not isNil(var_286_9) and arg_283_1.var_.characterEffect1071ui_story then
				local var_286_14 = 0.5

				arg_283_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_283_1.var_.characterEffect1071ui_story.fillRatio = var_286_14
			end

			local var_286_15 = arg_283_1.actors_["1184ui_story"].transform
			local var_286_16 = 0

			if var_286_16 < arg_283_1.time_ and arg_283_1.time_ <= var_286_16 + arg_286_0 then
				arg_283_1.var_.moveOldPos1184ui_story = var_286_15.localPosition
			end

			local var_286_17 = 0.001

			if var_286_16 <= arg_283_1.time_ and arg_283_1.time_ < var_286_16 + var_286_17 then
				local var_286_18 = (arg_283_1.time_ - var_286_16) / var_286_17
				local var_286_19 = Vector3.New(0.7, -0.97, -6)

				var_286_15.localPosition = Vector3.Lerp(arg_283_1.var_.moveOldPos1184ui_story, var_286_19, var_286_18)

				local var_286_20 = manager.ui.mainCamera.transform.position - var_286_15.position

				var_286_15.forward = Vector3.New(var_286_20.x, var_286_20.y, var_286_20.z)

				local var_286_21 = var_286_15.localEulerAngles

				var_286_21.z = 0
				var_286_21.x = 0
				var_286_15.localEulerAngles = var_286_21
			end

			if arg_283_1.time_ >= var_286_16 + var_286_17 and arg_283_1.time_ < var_286_16 + var_286_17 + arg_286_0 then
				var_286_15.localPosition = Vector3.New(0.7, -0.97, -6)

				local var_286_22 = manager.ui.mainCamera.transform.position - var_286_15.position

				var_286_15.forward = Vector3.New(var_286_22.x, var_286_22.y, var_286_22.z)

				local var_286_23 = var_286_15.localEulerAngles

				var_286_23.z = 0
				var_286_23.x = 0
				var_286_15.localEulerAngles = var_286_23
			end

			local var_286_24 = arg_283_1.actors_["1184ui_story"]
			local var_286_25 = 0

			if var_286_25 < arg_283_1.time_ and arg_283_1.time_ <= var_286_25 + arg_286_0 and not isNil(var_286_24) and arg_283_1.var_.characterEffect1184ui_story == nil then
				arg_283_1.var_.characterEffect1184ui_story = var_286_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_286_26 = 0.200000002980232

			if var_286_25 <= arg_283_1.time_ and arg_283_1.time_ < var_286_25 + var_286_26 and not isNil(var_286_24) then
				local var_286_27 = (arg_283_1.time_ - var_286_25) / var_286_26

				if arg_283_1.var_.characterEffect1184ui_story and not isNil(var_286_24) then
					arg_283_1.var_.characterEffect1184ui_story.fillFlat = false
				end
			end

			if arg_283_1.time_ >= var_286_25 + var_286_26 and arg_283_1.time_ < var_286_25 + var_286_26 + arg_286_0 and not isNil(var_286_24) and arg_283_1.var_.characterEffect1184ui_story then
				arg_283_1.var_.characterEffect1184ui_story.fillFlat = false
			end

			local var_286_28 = 0

			if var_286_28 < arg_283_1.time_ and arg_283_1.time_ <= var_286_28 + arg_286_0 then
				arg_283_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			local var_286_29 = 0

			if var_286_29 < arg_283_1.time_ and arg_283_1.time_ <= var_286_29 + arg_286_0 then
				arg_283_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_286_30 = 0
			local var_286_31 = 0.95

			if var_286_30 < arg_283_1.time_ and arg_283_1.time_ <= var_286_30 + arg_286_0 then
				arg_283_1.talkMaxDuration = 0
				arg_283_1.dialogCg_.alpha = 1

				arg_283_1.dialog_:SetActive(true)
				SetActive(arg_283_1.leftNameGo_, true)

				local var_286_32 = arg_283_1:FormatText(StoryNameCfg[6].name)

				arg_283_1.leftNameTxt_.text = var_286_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_283_1.leftNameTxt_.transform)

				arg_283_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_283_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_283_1:RecordName(arg_283_1.leftNameTxt_.text)
				SetActive(arg_283_1.iconTrs_.gameObject, false)
				arg_283_1.callingController_:SetSelectedState("normal")

				local var_286_33 = arg_283_1:GetWordFromCfg(121561069)
				local var_286_34 = arg_283_1:FormatText(var_286_33.content)

				arg_283_1.text_.text = var_286_34

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_35 = 38
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

				if manager.audio:GetVoiceLength("story_v_out_121561", "121561069", "story_v_out_121561.awb") ~= 0 then
					local var_286_38 = manager.audio:GetVoiceLength("story_v_out_121561", "121561069", "story_v_out_121561.awb") / 1000

					if var_286_38 + var_286_30 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_38 + var_286_30
					end

					if var_286_33.prefab_name ~= "" and arg_283_1.actors_[var_286_33.prefab_name] ~= nil then
						local var_286_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_283_1.actors_[var_286_33.prefab_name].transform, "story_v_out_121561", "121561069", "story_v_out_121561.awb")

						arg_283_1:RecordAudio("121561069", var_286_39)
						arg_283_1:RecordAudio("121561069", var_286_39)
					else
						arg_283_1:AudioAction("play", "voice", "story_v_out_121561", "121561069", "story_v_out_121561.awb")
					end

					arg_283_1:RecordHistoryTalkVoice("story_v_out_121561", "121561069", "story_v_out_121561.awb")
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
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1184ui_story",
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
	Play121561070 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 121561070
		arg_287_1.duration_ = 7.3

		local var_287_0 = {
			ja = 6.066,
			ko = 7.3,
			zh = 7.3
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
				arg_287_0:Play121561071(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			local var_290_0 = arg_287_1.actors_["1071ui_story"]
			local var_290_1 = 0

			if var_290_1 < arg_287_1.time_ and arg_287_1.time_ <= var_290_1 + arg_290_0 and not isNil(var_290_0) and arg_287_1.var_.characterEffect1071ui_story == nil then
				arg_287_1.var_.characterEffect1071ui_story = var_290_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_290_2 = 0.200000002980232

			if var_290_1 <= arg_287_1.time_ and arg_287_1.time_ < var_290_1 + var_290_2 and not isNil(var_290_0) then
				local var_290_3 = (arg_287_1.time_ - var_290_1) / var_290_2

				if arg_287_1.var_.characterEffect1071ui_story and not isNil(var_290_0) then
					arg_287_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_287_1.time_ >= var_290_1 + var_290_2 and arg_287_1.time_ < var_290_1 + var_290_2 + arg_290_0 and not isNil(var_290_0) and arg_287_1.var_.characterEffect1071ui_story then
				arg_287_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_290_4 = 0

			if var_290_4 < arg_287_1.time_ and arg_287_1.time_ <= var_290_4 + arg_290_0 then
				arg_287_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action1_1")
			end

			local var_290_5 = arg_287_1.actors_["1184ui_story"]
			local var_290_6 = 0

			if var_290_6 < arg_287_1.time_ and arg_287_1.time_ <= var_290_6 + arg_290_0 and not isNil(var_290_5) and arg_287_1.var_.characterEffect1184ui_story == nil then
				arg_287_1.var_.characterEffect1184ui_story = var_290_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_290_7 = 0.200000002980232

			if var_290_6 <= arg_287_1.time_ and arg_287_1.time_ < var_290_6 + var_290_7 and not isNil(var_290_5) then
				local var_290_8 = (arg_287_1.time_ - var_290_6) / var_290_7

				if arg_287_1.var_.characterEffect1184ui_story and not isNil(var_290_5) then
					local var_290_9 = Mathf.Lerp(0, 0.5, var_290_8)

					arg_287_1.var_.characterEffect1184ui_story.fillFlat = true
					arg_287_1.var_.characterEffect1184ui_story.fillRatio = var_290_9
				end
			end

			if arg_287_1.time_ >= var_290_6 + var_290_7 and arg_287_1.time_ < var_290_6 + var_290_7 + arg_290_0 and not isNil(var_290_5) and arg_287_1.var_.characterEffect1184ui_story then
				local var_290_10 = 0.5

				arg_287_1.var_.characterEffect1184ui_story.fillFlat = true
				arg_287_1.var_.characterEffect1184ui_story.fillRatio = var_290_10
			end

			local var_290_11 = 0
			local var_290_12 = 0.475

			if var_290_11 < arg_287_1.time_ and arg_287_1.time_ <= var_290_11 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0
				arg_287_1.dialogCg_.alpha = 1

				arg_287_1.dialog_:SetActive(true)
				SetActive(arg_287_1.leftNameGo_, true)

				local var_290_13 = arg_287_1:FormatText(StoryNameCfg[384].name)

				arg_287_1.leftNameTxt_.text = var_290_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_287_1.leftNameTxt_.transform)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1.leftNameTxt_.text)
				SetActive(arg_287_1.iconTrs_.gameObject, false)
				arg_287_1.callingController_:SetSelectedState("normal")

				local var_290_14 = arg_287_1:GetWordFromCfg(121561070)
				local var_290_15 = arg_287_1:FormatText(var_290_14.content)

				arg_287_1.text_.text = var_290_15

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_16 = 19
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

				if manager.audio:GetVoiceLength("story_v_out_121561", "121561070", "story_v_out_121561.awb") ~= 0 then
					local var_290_19 = manager.audio:GetVoiceLength("story_v_out_121561", "121561070", "story_v_out_121561.awb") / 1000

					if var_290_19 + var_290_11 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_19 + var_290_11
					end

					if var_290_14.prefab_name ~= "" and arg_287_1.actors_[var_290_14.prefab_name] ~= nil then
						local var_290_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_287_1.actors_[var_290_14.prefab_name].transform, "story_v_out_121561", "121561070", "story_v_out_121561.awb")

						arg_287_1:RecordAudio("121561070", var_290_20)
						arg_287_1:RecordAudio("121561070", var_290_20)
					else
						arg_287_1:AudioAction("play", "voice", "story_v_out_121561", "121561070", "story_v_out_121561.awb")
					end

					arg_287_1:RecordHistoryTalkVoice("story_v_out_121561", "121561070", "story_v_out_121561.awb")
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
	Play121561071 = function(arg_291_0, arg_291_1)
		arg_291_1.time_ = 0
		arg_291_1.frameCnt_ = 0
		arg_291_1.state_ = "playing"
		arg_291_1.curTalkId_ = 121561071
		arg_291_1.duration_ = 5

		SetActive(arg_291_1.tipsGo_, false)

		function arg_291_1.onSingleLineFinish_()
			arg_291_1.onSingleLineUpdate_ = nil
			arg_291_1.onSingleLineFinish_ = nil
			arg_291_1.state_ = "waiting"
		end

		function arg_291_1.playNext_(arg_293_0)
			if arg_293_0 == 1 then
				arg_291_0:Play121561072(arg_291_1)
			end
		end

		function arg_291_1.onSingleLineUpdate_(arg_294_0)
			local var_294_0 = arg_291_1.actors_["1071ui_story"].transform
			local var_294_1 = 0

			if var_294_1 < arg_291_1.time_ and arg_291_1.time_ <= var_294_1 + arg_294_0 then
				arg_291_1.var_.moveOldPos1071ui_story = var_294_0.localPosition
			end

			local var_294_2 = 0.001

			if var_294_1 <= arg_291_1.time_ and arg_291_1.time_ < var_294_1 + var_294_2 then
				local var_294_3 = (arg_291_1.time_ - var_294_1) / var_294_2
				local var_294_4 = Vector3.New(0, 100, 0)

				var_294_0.localPosition = Vector3.Lerp(arg_291_1.var_.moveOldPos1071ui_story, var_294_4, var_294_3)

				local var_294_5 = manager.ui.mainCamera.transform.position - var_294_0.position

				var_294_0.forward = Vector3.New(var_294_5.x, var_294_5.y, var_294_5.z)

				local var_294_6 = var_294_0.localEulerAngles

				var_294_6.z = 0
				var_294_6.x = 0
				var_294_0.localEulerAngles = var_294_6
			end

			if arg_291_1.time_ >= var_294_1 + var_294_2 and arg_291_1.time_ < var_294_1 + var_294_2 + arg_294_0 then
				var_294_0.localPosition = Vector3.New(0, 100, 0)

				local var_294_7 = manager.ui.mainCamera.transform.position - var_294_0.position

				var_294_0.forward = Vector3.New(var_294_7.x, var_294_7.y, var_294_7.z)

				local var_294_8 = var_294_0.localEulerAngles

				var_294_8.z = 0
				var_294_8.x = 0
				var_294_0.localEulerAngles = var_294_8
			end

			local var_294_9 = arg_291_1.actors_["1184ui_story"].transform
			local var_294_10 = 0

			if var_294_10 < arg_291_1.time_ and arg_291_1.time_ <= var_294_10 + arg_294_0 then
				arg_291_1.var_.moveOldPos1184ui_story = var_294_9.localPosition
			end

			local var_294_11 = 0.001

			if var_294_10 <= arg_291_1.time_ and arg_291_1.time_ < var_294_10 + var_294_11 then
				local var_294_12 = (arg_291_1.time_ - var_294_10) / var_294_11
				local var_294_13 = Vector3.New(0, 100, 0)

				var_294_9.localPosition = Vector3.Lerp(arg_291_1.var_.moveOldPos1184ui_story, var_294_13, var_294_12)

				local var_294_14 = manager.ui.mainCamera.transform.position - var_294_9.position

				var_294_9.forward = Vector3.New(var_294_14.x, var_294_14.y, var_294_14.z)

				local var_294_15 = var_294_9.localEulerAngles

				var_294_15.z = 0
				var_294_15.x = 0
				var_294_9.localEulerAngles = var_294_15
			end

			if arg_291_1.time_ >= var_294_10 + var_294_11 and arg_291_1.time_ < var_294_10 + var_294_11 + arg_294_0 then
				var_294_9.localPosition = Vector3.New(0, 100, 0)

				local var_294_16 = manager.ui.mainCamera.transform.position - var_294_9.position

				var_294_9.forward = Vector3.New(var_294_16.x, var_294_16.y, var_294_16.z)

				local var_294_17 = var_294_9.localEulerAngles

				var_294_17.z = 0
				var_294_17.x = 0
				var_294_9.localEulerAngles = var_294_17
			end

			local var_294_18 = 0
			local var_294_19 = 0.975

			if var_294_18 < arg_291_1.time_ and arg_291_1.time_ <= var_294_18 + arg_294_0 then
				arg_291_1.talkMaxDuration = 0
				arg_291_1.dialogCg_.alpha = 1

				arg_291_1.dialog_:SetActive(true)
				SetActive(arg_291_1.leftNameGo_, false)

				arg_291_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_291_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_291_1:RecordName(arg_291_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_291_1.iconTrs_.gameObject, false)
				arg_291_1.callingController_:SetSelectedState("normal")

				local var_294_20 = arg_291_1:GetWordFromCfg(121561071)
				local var_294_21 = arg_291_1:FormatText(var_294_20.content)

				arg_291_1.text_.text = var_294_21

				LuaForUtil.ClearLinePrefixSymbol(arg_291_1.text_)

				local var_294_22 = 39
				local var_294_23 = utf8.len(var_294_21)
				local var_294_24 = var_294_22 <= 0 and var_294_19 or var_294_19 * (var_294_23 / var_294_22)

				if var_294_24 > 0 and var_294_19 < var_294_24 then
					arg_291_1.talkMaxDuration = var_294_24

					if var_294_24 + var_294_18 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_24 + var_294_18
					end
				end

				arg_291_1.text_.text = var_294_21
				arg_291_1.typewritter.percent = 0

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(false)
				arg_291_1:RecordContent(arg_291_1.text_.text)
			end

			local var_294_25 = math.max(var_294_19, arg_291_1.talkMaxDuration)

			if var_294_18 <= arg_291_1.time_ and arg_291_1.time_ < var_294_18 + var_294_25 then
				arg_291_1.typewritter.percent = (arg_291_1.time_ - var_294_18) / var_294_25

				arg_291_1.typewritter:SetDirty()
			end

			if arg_291_1.time_ >= var_294_18 + var_294_25 and arg_291_1.time_ < var_294_18 + var_294_25 + arg_294_0 then
				arg_291_1.typewritter.percent = 1

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(true)
			end
		end

		arg_291_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1184ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_291_1:InitPlayNodeList()
	end,
	Play121561072 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 121561072
		arg_295_1.duration_ = 3.63

		local var_295_0 = {
			ja = 3.633,
			ko = 1.999999999999,
			zh = 1.999999999999
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
				arg_295_0:Play121561073(arg_295_1)
			end
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			local var_298_0 = arg_295_1.actors_["1184ui_story"].transform
			local var_298_1 = 0

			if var_298_1 < arg_295_1.time_ and arg_295_1.time_ <= var_298_1 + arg_298_0 then
				arg_295_1.var_.moveOldPos1184ui_story = var_298_0.localPosition
			end

			local var_298_2 = 0.001

			if var_298_1 <= arg_295_1.time_ and arg_295_1.time_ < var_298_1 + var_298_2 then
				local var_298_3 = (arg_295_1.time_ - var_298_1) / var_298_2
				local var_298_4 = Vector3.New(0.7, -0.97, -6)

				var_298_0.localPosition = Vector3.Lerp(arg_295_1.var_.moveOldPos1184ui_story, var_298_4, var_298_3)

				local var_298_5 = manager.ui.mainCamera.transform.position - var_298_0.position

				var_298_0.forward = Vector3.New(var_298_5.x, var_298_5.y, var_298_5.z)

				local var_298_6 = var_298_0.localEulerAngles

				var_298_6.z = 0
				var_298_6.x = 0
				var_298_0.localEulerAngles = var_298_6
			end

			if arg_295_1.time_ >= var_298_1 + var_298_2 and arg_295_1.time_ < var_298_1 + var_298_2 + arg_298_0 then
				var_298_0.localPosition = Vector3.New(0.7, -0.97, -6)

				local var_298_7 = manager.ui.mainCamera.transform.position - var_298_0.position

				var_298_0.forward = Vector3.New(var_298_7.x, var_298_7.y, var_298_7.z)

				local var_298_8 = var_298_0.localEulerAngles

				var_298_8.z = 0
				var_298_8.x = 0
				var_298_0.localEulerAngles = var_298_8
			end

			local var_298_9 = arg_295_1.actors_["1184ui_story"]
			local var_298_10 = 0

			if var_298_10 < arg_295_1.time_ and arg_295_1.time_ <= var_298_10 + arg_298_0 and not isNil(var_298_9) and arg_295_1.var_.characterEffect1184ui_story == nil then
				arg_295_1.var_.characterEffect1184ui_story = var_298_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_298_11 = 0.200000002980232

			if var_298_10 <= arg_295_1.time_ and arg_295_1.time_ < var_298_10 + var_298_11 and not isNil(var_298_9) then
				local var_298_12 = (arg_295_1.time_ - var_298_10) / var_298_11

				if arg_295_1.var_.characterEffect1184ui_story and not isNil(var_298_9) then
					arg_295_1.var_.characterEffect1184ui_story.fillFlat = false
				end
			end

			if arg_295_1.time_ >= var_298_10 + var_298_11 and arg_295_1.time_ < var_298_10 + var_298_11 + arg_298_0 and not isNil(var_298_9) and arg_295_1.var_.characterEffect1184ui_story then
				arg_295_1.var_.characterEffect1184ui_story.fillFlat = false
			end

			local var_298_13 = 0

			if var_298_13 < arg_295_1.time_ and arg_295_1.time_ <= var_298_13 + arg_298_0 then
				arg_295_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			local var_298_14 = 0

			if var_298_14 < arg_295_1.time_ and arg_295_1.time_ <= var_298_14 + arg_298_0 then
				arg_295_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_298_15 = 0
			local var_298_16 = 0.225

			if var_298_15 < arg_295_1.time_ and arg_295_1.time_ <= var_298_15 + arg_298_0 then
				arg_295_1.talkMaxDuration = 0
				arg_295_1.dialogCg_.alpha = 1

				arg_295_1.dialog_:SetActive(true)
				SetActive(arg_295_1.leftNameGo_, true)

				local var_298_17 = arg_295_1:FormatText(StoryNameCfg[6].name)

				arg_295_1.leftNameTxt_.text = var_298_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_295_1.leftNameTxt_.transform)

				arg_295_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_295_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_295_1:RecordName(arg_295_1.leftNameTxt_.text)
				SetActive(arg_295_1.iconTrs_.gameObject, false)
				arg_295_1.callingController_:SetSelectedState("normal")

				local var_298_18 = arg_295_1:GetWordFromCfg(121561072)
				local var_298_19 = arg_295_1:FormatText(var_298_18.content)

				arg_295_1.text_.text = var_298_19

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_20 = 9
				local var_298_21 = utf8.len(var_298_19)
				local var_298_22 = var_298_20 <= 0 and var_298_16 or var_298_16 * (var_298_21 / var_298_20)

				if var_298_22 > 0 and var_298_16 < var_298_22 then
					arg_295_1.talkMaxDuration = var_298_22

					if var_298_22 + var_298_15 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_22 + var_298_15
					end
				end

				arg_295_1.text_.text = var_298_19
				arg_295_1.typewritter.percent = 0

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121561", "121561072", "story_v_out_121561.awb") ~= 0 then
					local var_298_23 = manager.audio:GetVoiceLength("story_v_out_121561", "121561072", "story_v_out_121561.awb") / 1000

					if var_298_23 + var_298_15 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_23 + var_298_15
					end

					if var_298_18.prefab_name ~= "" and arg_295_1.actors_[var_298_18.prefab_name] ~= nil then
						local var_298_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_295_1.actors_[var_298_18.prefab_name].transform, "story_v_out_121561", "121561072", "story_v_out_121561.awb")

						arg_295_1:RecordAudio("121561072", var_298_24)
						arg_295_1:RecordAudio("121561072", var_298_24)
					else
						arg_295_1:AudioAction("play", "voice", "story_v_out_121561", "121561072", "story_v_out_121561.awb")
					end

					arg_295_1:RecordHistoryTalkVoice("story_v_out_121561", "121561072", "story_v_out_121561.awb")
				end

				arg_295_1:RecordContent(arg_295_1.text_.text)
			end

			local var_298_25 = math.max(var_298_16, arg_295_1.talkMaxDuration)

			if var_298_15 <= arg_295_1.time_ and arg_295_1.time_ < var_298_15 + var_298_25 then
				arg_295_1.typewritter.percent = (arg_295_1.time_ - var_298_15) / var_298_25

				arg_295_1.typewritter:SetDirty()
			end

			if arg_295_1.time_ >= var_298_15 + var_298_25 and arg_295_1.time_ < var_298_15 + var_298_25 + arg_298_0 then
				arg_295_1.typewritter.percent = 1

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(true)
			end
		end

		arg_295_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1184ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_295_1:InitPlayNodeList()
	end,
	Play121561073 = function(arg_299_0, arg_299_1)
		arg_299_1.time_ = 0
		arg_299_1.frameCnt_ = 0
		arg_299_1.state_ = "playing"
		arg_299_1.curTalkId_ = 121561073
		arg_299_1.duration_ = 10.1

		local var_299_0 = {
			ja = 7.333,
			ko = 10.1,
			zh = 10.1
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
				arg_299_0:Play121561074(arg_299_1)
			end
		end

		function arg_299_1.onSingleLineUpdate_(arg_302_0)
			local var_302_0 = arg_299_1.actors_["1071ui_story"].transform
			local var_302_1 = 0

			if var_302_1 < arg_299_1.time_ and arg_299_1.time_ <= var_302_1 + arg_302_0 then
				arg_299_1.var_.moveOldPos1071ui_story = var_302_0.localPosition
			end

			local var_302_2 = 0.001

			if var_302_1 <= arg_299_1.time_ and arg_299_1.time_ < var_302_1 + var_302_2 then
				local var_302_3 = (arg_299_1.time_ - var_302_1) / var_302_2
				local var_302_4 = Vector3.New(-0.7, -1.05, -6.2)

				var_302_0.localPosition = Vector3.Lerp(arg_299_1.var_.moveOldPos1071ui_story, var_302_4, var_302_3)

				local var_302_5 = manager.ui.mainCamera.transform.position - var_302_0.position

				var_302_0.forward = Vector3.New(var_302_5.x, var_302_5.y, var_302_5.z)

				local var_302_6 = var_302_0.localEulerAngles

				var_302_6.z = 0
				var_302_6.x = 0
				var_302_0.localEulerAngles = var_302_6
			end

			if arg_299_1.time_ >= var_302_1 + var_302_2 and arg_299_1.time_ < var_302_1 + var_302_2 + arg_302_0 then
				var_302_0.localPosition = Vector3.New(-0.7, -1.05, -6.2)

				local var_302_7 = manager.ui.mainCamera.transform.position - var_302_0.position

				var_302_0.forward = Vector3.New(var_302_7.x, var_302_7.y, var_302_7.z)

				local var_302_8 = var_302_0.localEulerAngles

				var_302_8.z = 0
				var_302_8.x = 0
				var_302_0.localEulerAngles = var_302_8
			end

			local var_302_9 = arg_299_1.actors_["1071ui_story"]
			local var_302_10 = 0

			if var_302_10 < arg_299_1.time_ and arg_299_1.time_ <= var_302_10 + arg_302_0 and not isNil(var_302_9) and arg_299_1.var_.characterEffect1071ui_story == nil then
				arg_299_1.var_.characterEffect1071ui_story = var_302_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_302_11 = 0.200000002980232

			if var_302_10 <= arg_299_1.time_ and arg_299_1.time_ < var_302_10 + var_302_11 and not isNil(var_302_9) then
				local var_302_12 = (arg_299_1.time_ - var_302_10) / var_302_11

				if arg_299_1.var_.characterEffect1071ui_story and not isNil(var_302_9) then
					arg_299_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_299_1.time_ >= var_302_10 + var_302_11 and arg_299_1.time_ < var_302_10 + var_302_11 + arg_302_0 and not isNil(var_302_9) and arg_299_1.var_.characterEffect1071ui_story then
				arg_299_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_302_13 = 0

			if var_302_13 < arg_299_1.time_ and arg_299_1.time_ <= var_302_13 + arg_302_0 then
				arg_299_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action1_1")
			end

			local var_302_14 = 0

			if var_302_14 < arg_299_1.time_ and arg_299_1.time_ <= var_302_14 + arg_302_0 then
				arg_299_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_302_15 = arg_299_1.actors_["1184ui_story"]
			local var_302_16 = 0

			if var_302_16 < arg_299_1.time_ and arg_299_1.time_ <= var_302_16 + arg_302_0 and not isNil(var_302_15) and arg_299_1.var_.characterEffect1184ui_story == nil then
				arg_299_1.var_.characterEffect1184ui_story = var_302_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_302_17 = 0.200000002980232

			if var_302_16 <= arg_299_1.time_ and arg_299_1.time_ < var_302_16 + var_302_17 and not isNil(var_302_15) then
				local var_302_18 = (arg_299_1.time_ - var_302_16) / var_302_17

				if arg_299_1.var_.characterEffect1184ui_story and not isNil(var_302_15) then
					local var_302_19 = Mathf.Lerp(0, 0.5, var_302_18)

					arg_299_1.var_.characterEffect1184ui_story.fillFlat = true
					arg_299_1.var_.characterEffect1184ui_story.fillRatio = var_302_19
				end
			end

			if arg_299_1.time_ >= var_302_16 + var_302_17 and arg_299_1.time_ < var_302_16 + var_302_17 + arg_302_0 and not isNil(var_302_15) and arg_299_1.var_.characterEffect1184ui_story then
				local var_302_20 = 0.5

				arg_299_1.var_.characterEffect1184ui_story.fillFlat = true
				arg_299_1.var_.characterEffect1184ui_story.fillRatio = var_302_20
			end

			local var_302_21 = 0
			local var_302_22 = 1.15

			if var_302_21 < arg_299_1.time_ and arg_299_1.time_ <= var_302_21 + arg_302_0 then
				arg_299_1.talkMaxDuration = 0
				arg_299_1.dialogCg_.alpha = 1

				arg_299_1.dialog_:SetActive(true)
				SetActive(arg_299_1.leftNameGo_, true)

				local var_302_23 = arg_299_1:FormatText(StoryNameCfg[384].name)

				arg_299_1.leftNameTxt_.text = var_302_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_299_1.leftNameTxt_.transform)

				arg_299_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_299_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_299_1:RecordName(arg_299_1.leftNameTxt_.text)
				SetActive(arg_299_1.iconTrs_.gameObject, false)
				arg_299_1.callingController_:SetSelectedState("normal")

				local var_302_24 = arg_299_1:GetWordFromCfg(121561073)
				local var_302_25 = arg_299_1:FormatText(var_302_24.content)

				arg_299_1.text_.text = var_302_25

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.text_)

				local var_302_26 = 46
				local var_302_27 = utf8.len(var_302_25)
				local var_302_28 = var_302_26 <= 0 and var_302_22 or var_302_22 * (var_302_27 / var_302_26)

				if var_302_28 > 0 and var_302_22 < var_302_28 then
					arg_299_1.talkMaxDuration = var_302_28

					if var_302_28 + var_302_21 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_28 + var_302_21
					end
				end

				arg_299_1.text_.text = var_302_25
				arg_299_1.typewritter.percent = 0

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121561", "121561073", "story_v_out_121561.awb") ~= 0 then
					local var_302_29 = manager.audio:GetVoiceLength("story_v_out_121561", "121561073", "story_v_out_121561.awb") / 1000

					if var_302_29 + var_302_21 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_29 + var_302_21
					end

					if var_302_24.prefab_name ~= "" and arg_299_1.actors_[var_302_24.prefab_name] ~= nil then
						local var_302_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_299_1.actors_[var_302_24.prefab_name].transform, "story_v_out_121561", "121561073", "story_v_out_121561.awb")

						arg_299_1:RecordAudio("121561073", var_302_30)
						arg_299_1:RecordAudio("121561073", var_302_30)
					else
						arg_299_1:AudioAction("play", "voice", "story_v_out_121561", "121561073", "story_v_out_121561.awb")
					end

					arg_299_1:RecordHistoryTalkVoice("story_v_out_121561", "121561073", "story_v_out_121561.awb")
				end

				arg_299_1:RecordContent(arg_299_1.text_.text)
			end

			local var_302_31 = math.max(var_302_22, arg_299_1.talkMaxDuration)

			if var_302_21 <= arg_299_1.time_ and arg_299_1.time_ < var_302_21 + var_302_31 then
				arg_299_1.typewritter.percent = (arg_299_1.time_ - var_302_21) / var_302_31

				arg_299_1.typewritter:SetDirty()
			end

			if arg_299_1.time_ >= var_302_21 + var_302_31 and arg_299_1.time_ < var_302_21 + var_302_31 + arg_302_0 then
				arg_299_1.typewritter.percent = 1

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(true)
			end
		end

		arg_299_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_299_1:InitPlayNodeList()
	end,
	Play121561074 = function(arg_303_0, arg_303_1)
		arg_303_1.time_ = 0
		arg_303_1.frameCnt_ = 0
		arg_303_1.state_ = "playing"
		arg_303_1.curTalkId_ = 121561074
		arg_303_1.duration_ = 9.33

		local var_303_0 = {
			ja = 9.333,
			ko = 8.5,
			zh = 8.5
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
				arg_303_0:Play121561075(arg_303_1)
			end
		end

		function arg_303_1.onSingleLineUpdate_(arg_306_0)
			local var_306_0 = 0
			local var_306_1 = 1.125

			if var_306_0 < arg_303_1.time_ and arg_303_1.time_ <= var_306_0 + arg_306_0 then
				arg_303_1.talkMaxDuration = 0
				arg_303_1.dialogCg_.alpha = 1

				arg_303_1.dialog_:SetActive(true)
				SetActive(arg_303_1.leftNameGo_, true)

				local var_306_2 = arg_303_1:FormatText(StoryNameCfg[384].name)

				arg_303_1.leftNameTxt_.text = var_306_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_303_1.leftNameTxt_.transform)

				arg_303_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_303_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_303_1:RecordName(arg_303_1.leftNameTxt_.text)
				SetActive(arg_303_1.iconTrs_.gameObject, false)
				arg_303_1.callingController_:SetSelectedState("normal")

				local var_306_3 = arg_303_1:GetWordFromCfg(121561074)
				local var_306_4 = arg_303_1:FormatText(var_306_3.content)

				arg_303_1.text_.text = var_306_4

				LuaForUtil.ClearLinePrefixSymbol(arg_303_1.text_)

				local var_306_5 = 45
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

				if manager.audio:GetVoiceLength("story_v_out_121561", "121561074", "story_v_out_121561.awb") ~= 0 then
					local var_306_8 = manager.audio:GetVoiceLength("story_v_out_121561", "121561074", "story_v_out_121561.awb") / 1000

					if var_306_8 + var_306_0 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_8 + var_306_0
					end

					if var_306_3.prefab_name ~= "" and arg_303_1.actors_[var_306_3.prefab_name] ~= nil then
						local var_306_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_303_1.actors_[var_306_3.prefab_name].transform, "story_v_out_121561", "121561074", "story_v_out_121561.awb")

						arg_303_1:RecordAudio("121561074", var_306_9)
						arg_303_1:RecordAudio("121561074", var_306_9)
					else
						arg_303_1:AudioAction("play", "voice", "story_v_out_121561", "121561074", "story_v_out_121561.awb")
					end

					arg_303_1:RecordHistoryTalkVoice("story_v_out_121561", "121561074", "story_v_out_121561.awb")
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
	Play121561075 = function(arg_307_0, arg_307_1)
		arg_307_1.time_ = 0
		arg_307_1.frameCnt_ = 0
		arg_307_1.state_ = "playing"
		arg_307_1.curTalkId_ = 121561075
		arg_307_1.duration_ = 5

		SetActive(arg_307_1.tipsGo_, false)

		function arg_307_1.onSingleLineFinish_()
			arg_307_1.onSingleLineUpdate_ = nil
			arg_307_1.onSingleLineFinish_ = nil
			arg_307_1.state_ = "waiting"
		end

		function arg_307_1.playNext_(arg_309_0)
			if arg_309_0 == 1 then
				arg_307_0:Play121561076(arg_307_1)
			end
		end

		function arg_307_1.onSingleLineUpdate_(arg_310_0)
			local var_310_0 = arg_307_1.actors_["1071ui_story"]
			local var_310_1 = 0

			if var_310_1 < arg_307_1.time_ and arg_307_1.time_ <= var_310_1 + arg_310_0 and not isNil(var_310_0) and arg_307_1.var_.characterEffect1071ui_story == nil then
				arg_307_1.var_.characterEffect1071ui_story = var_310_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_310_2 = 0.200000002980232

			if var_310_1 <= arg_307_1.time_ and arg_307_1.time_ < var_310_1 + var_310_2 and not isNil(var_310_0) then
				local var_310_3 = (arg_307_1.time_ - var_310_1) / var_310_2

				if arg_307_1.var_.characterEffect1071ui_story and not isNil(var_310_0) then
					local var_310_4 = Mathf.Lerp(0, 0.5, var_310_3)

					arg_307_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_307_1.var_.characterEffect1071ui_story.fillRatio = var_310_4
				end
			end

			if arg_307_1.time_ >= var_310_1 + var_310_2 and arg_307_1.time_ < var_310_1 + var_310_2 + arg_310_0 and not isNil(var_310_0) and arg_307_1.var_.characterEffect1071ui_story then
				local var_310_5 = 0.5

				arg_307_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_307_1.var_.characterEffect1071ui_story.fillRatio = var_310_5
			end

			local var_310_6 = 0
			local var_310_7 = 0.5

			if var_310_6 < arg_307_1.time_ and arg_307_1.time_ <= var_310_6 + arg_310_0 then
				arg_307_1.talkMaxDuration = 0
				arg_307_1.dialogCg_.alpha = 1

				arg_307_1.dialog_:SetActive(true)
				SetActive(arg_307_1.leftNameGo_, false)

				arg_307_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_307_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_307_1:RecordName(arg_307_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_307_1.iconTrs_.gameObject, false)
				arg_307_1.callingController_:SetSelectedState("normal")

				local var_310_8 = arg_307_1:GetWordFromCfg(121561075)
				local var_310_9 = arg_307_1:FormatText(var_310_8.content)

				arg_307_1.text_.text = var_310_9

				LuaForUtil.ClearLinePrefixSymbol(arg_307_1.text_)

				local var_310_10 = 20
				local var_310_11 = utf8.len(var_310_9)
				local var_310_12 = var_310_10 <= 0 and var_310_7 or var_310_7 * (var_310_11 / var_310_10)

				if var_310_12 > 0 and var_310_7 < var_310_12 then
					arg_307_1.talkMaxDuration = var_310_12

					if var_310_12 + var_310_6 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_12 + var_310_6
					end
				end

				arg_307_1.text_.text = var_310_9
				arg_307_1.typewritter.percent = 0

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(false)
				arg_307_1:RecordContent(arg_307_1.text_.text)
			end

			local var_310_13 = math.max(var_310_7, arg_307_1.talkMaxDuration)

			if var_310_6 <= arg_307_1.time_ and arg_307_1.time_ < var_310_6 + var_310_13 then
				arg_307_1.typewritter.percent = (arg_307_1.time_ - var_310_6) / var_310_13

				arg_307_1.typewritter:SetDirty()
			end

			if arg_307_1.time_ >= var_310_6 + var_310_13 and arg_307_1.time_ < var_310_6 + var_310_13 + arg_310_0 then
				arg_307_1.typewritter.percent = 1

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(true)
			end
		end

		arg_307_1.nodeConfigList_ = {}

		arg_307_1:InitPlayNodeList()
	end,
	Play121561076 = function(arg_311_0, arg_311_1)
		arg_311_1.time_ = 0
		arg_311_1.frameCnt_ = 0
		arg_311_1.state_ = "playing"
		arg_311_1.curTalkId_ = 121561076
		arg_311_1.duration_ = 11.5

		local var_311_0 = {
			ja = 11.5,
			ko = 8.833,
			zh = 8.833
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
				arg_311_0:Play121561077(arg_311_1)
			end
		end

		function arg_311_1.onSingleLineUpdate_(arg_314_0)
			local var_314_0 = arg_311_1.actors_["1071ui_story"]
			local var_314_1 = 0

			if var_314_1 < arg_311_1.time_ and arg_311_1.time_ <= var_314_1 + arg_314_0 and not isNil(var_314_0) and arg_311_1.var_.characterEffect1071ui_story == nil then
				arg_311_1.var_.characterEffect1071ui_story = var_314_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_314_2 = 0.200000002980232

			if var_314_1 <= arg_311_1.time_ and arg_311_1.time_ < var_314_1 + var_314_2 and not isNil(var_314_0) then
				local var_314_3 = (arg_311_1.time_ - var_314_1) / var_314_2

				if arg_311_1.var_.characterEffect1071ui_story and not isNil(var_314_0) then
					arg_311_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_311_1.time_ >= var_314_1 + var_314_2 and arg_311_1.time_ < var_314_1 + var_314_2 + arg_314_0 and not isNil(var_314_0) and arg_311_1.var_.characterEffect1071ui_story then
				arg_311_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_314_4 = 0

			if var_314_4 < arg_311_1.time_ and arg_311_1.time_ <= var_314_4 + arg_314_0 then
				arg_311_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action1_1")
			end

			local var_314_5 = 0

			if var_314_5 < arg_311_1.time_ and arg_311_1.time_ <= var_314_5 + arg_314_0 then
				arg_311_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_314_6 = 0
			local var_314_7 = 1.125

			if var_314_6 < arg_311_1.time_ and arg_311_1.time_ <= var_314_6 + arg_314_0 then
				arg_311_1.talkMaxDuration = 0
				arg_311_1.dialogCg_.alpha = 1

				arg_311_1.dialog_:SetActive(true)
				SetActive(arg_311_1.leftNameGo_, true)

				local var_314_8 = arg_311_1:FormatText(StoryNameCfg[384].name)

				arg_311_1.leftNameTxt_.text = var_314_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_311_1.leftNameTxt_.transform)

				arg_311_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_311_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_311_1:RecordName(arg_311_1.leftNameTxt_.text)
				SetActive(arg_311_1.iconTrs_.gameObject, false)
				arg_311_1.callingController_:SetSelectedState("normal")

				local var_314_9 = arg_311_1:GetWordFromCfg(121561076)
				local var_314_10 = arg_311_1:FormatText(var_314_9.content)

				arg_311_1.text_.text = var_314_10

				LuaForUtil.ClearLinePrefixSymbol(arg_311_1.text_)

				local var_314_11 = 45
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

				if manager.audio:GetVoiceLength("story_v_out_121561", "121561076", "story_v_out_121561.awb") ~= 0 then
					local var_314_14 = manager.audio:GetVoiceLength("story_v_out_121561", "121561076", "story_v_out_121561.awb") / 1000

					if var_314_14 + var_314_6 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_14 + var_314_6
					end

					if var_314_9.prefab_name ~= "" and arg_311_1.actors_[var_314_9.prefab_name] ~= nil then
						local var_314_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_311_1.actors_[var_314_9.prefab_name].transform, "story_v_out_121561", "121561076", "story_v_out_121561.awb")

						arg_311_1:RecordAudio("121561076", var_314_15)
						arg_311_1:RecordAudio("121561076", var_314_15)
					else
						arg_311_1:AudioAction("play", "voice", "story_v_out_121561", "121561076", "story_v_out_121561.awb")
					end

					arg_311_1:RecordHistoryTalkVoice("story_v_out_121561", "121561076", "story_v_out_121561.awb")
				end

				arg_311_1:RecordContent(arg_311_1.text_.text)
			end

			local var_314_16 = math.max(var_314_7, arg_311_1.talkMaxDuration)

			if var_314_6 <= arg_311_1.time_ and arg_311_1.time_ < var_314_6 + var_314_16 then
				arg_311_1.typewritter.percent = (arg_311_1.time_ - var_314_6) / var_314_16

				arg_311_1.typewritter:SetDirty()
			end

			if arg_311_1.time_ >= var_314_6 + var_314_16 and arg_311_1.time_ < var_314_6 + var_314_16 + arg_314_0 then
				arg_311_1.typewritter.percent = 1

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(true)
			end
		end

		arg_311_1.nodeConfigList_ = {}

		arg_311_1:InitPlayNodeList()
	end,
	Play121561077 = function(arg_315_0, arg_315_1)
		arg_315_1.time_ = 0
		arg_315_1.frameCnt_ = 0
		arg_315_1.state_ = "playing"
		arg_315_1.curTalkId_ = 121561077
		arg_315_1.duration_ = 5

		SetActive(arg_315_1.tipsGo_, false)

		function arg_315_1.onSingleLineFinish_()
			arg_315_1.onSingleLineUpdate_ = nil
			arg_315_1.onSingleLineFinish_ = nil
			arg_315_1.state_ = "waiting"
		end

		function arg_315_1.playNext_(arg_317_0)
			if arg_317_0 == 1 then
				arg_315_0:Play121561078(arg_315_1)
			end
		end

		function arg_315_1.onSingleLineUpdate_(arg_318_0)
			local var_318_0 = arg_315_1.actors_["1071ui_story"].transform
			local var_318_1 = 0

			if var_318_1 < arg_315_1.time_ and arg_315_1.time_ <= var_318_1 + arg_318_0 then
				arg_315_1.var_.moveOldPos1071ui_story = var_318_0.localPosition
			end

			local var_318_2 = 0.001

			if var_318_1 <= arg_315_1.time_ and arg_315_1.time_ < var_318_1 + var_318_2 then
				local var_318_3 = (arg_315_1.time_ - var_318_1) / var_318_2
				local var_318_4 = Vector3.New(0, 100, 0)

				var_318_0.localPosition = Vector3.Lerp(arg_315_1.var_.moveOldPos1071ui_story, var_318_4, var_318_3)

				local var_318_5 = manager.ui.mainCamera.transform.position - var_318_0.position

				var_318_0.forward = Vector3.New(var_318_5.x, var_318_5.y, var_318_5.z)

				local var_318_6 = var_318_0.localEulerAngles

				var_318_6.z = 0
				var_318_6.x = 0
				var_318_0.localEulerAngles = var_318_6
			end

			if arg_315_1.time_ >= var_318_1 + var_318_2 and arg_315_1.time_ < var_318_1 + var_318_2 + arg_318_0 then
				var_318_0.localPosition = Vector3.New(0, 100, 0)

				local var_318_7 = manager.ui.mainCamera.transform.position - var_318_0.position

				var_318_0.forward = Vector3.New(var_318_7.x, var_318_7.y, var_318_7.z)

				local var_318_8 = var_318_0.localEulerAngles

				var_318_8.z = 0
				var_318_8.x = 0
				var_318_0.localEulerAngles = var_318_8
			end

			local var_318_9 = arg_315_1.actors_["1071ui_story"]
			local var_318_10 = 0

			if var_318_10 < arg_315_1.time_ and arg_315_1.time_ <= var_318_10 + arg_318_0 and not isNil(var_318_9) and arg_315_1.var_.characterEffect1071ui_story == nil then
				arg_315_1.var_.characterEffect1071ui_story = var_318_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_318_11 = 0.200000002980232

			if var_318_10 <= arg_315_1.time_ and arg_315_1.time_ < var_318_10 + var_318_11 and not isNil(var_318_9) then
				local var_318_12 = (arg_315_1.time_ - var_318_10) / var_318_11

				if arg_315_1.var_.characterEffect1071ui_story and not isNil(var_318_9) then
					local var_318_13 = Mathf.Lerp(0, 0.5, var_318_12)

					arg_315_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_315_1.var_.characterEffect1071ui_story.fillRatio = var_318_13
				end
			end

			if arg_315_1.time_ >= var_318_10 + var_318_11 and arg_315_1.time_ < var_318_10 + var_318_11 + arg_318_0 and not isNil(var_318_9) and arg_315_1.var_.characterEffect1071ui_story then
				local var_318_14 = 0.5

				arg_315_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_315_1.var_.characterEffect1071ui_story.fillRatio = var_318_14
			end

			local var_318_15 = arg_315_1.actors_["1184ui_story"].transform
			local var_318_16 = 0

			if var_318_16 < arg_315_1.time_ and arg_315_1.time_ <= var_318_16 + arg_318_0 then
				arg_315_1.var_.moveOldPos1184ui_story = var_318_15.localPosition
			end

			local var_318_17 = 0.001

			if var_318_16 <= arg_315_1.time_ and arg_315_1.time_ < var_318_16 + var_318_17 then
				local var_318_18 = (arg_315_1.time_ - var_318_16) / var_318_17
				local var_318_19 = Vector3.New(0, 100, 0)

				var_318_15.localPosition = Vector3.Lerp(arg_315_1.var_.moveOldPos1184ui_story, var_318_19, var_318_18)

				local var_318_20 = manager.ui.mainCamera.transform.position - var_318_15.position

				var_318_15.forward = Vector3.New(var_318_20.x, var_318_20.y, var_318_20.z)

				local var_318_21 = var_318_15.localEulerAngles

				var_318_21.z = 0
				var_318_21.x = 0
				var_318_15.localEulerAngles = var_318_21
			end

			if arg_315_1.time_ >= var_318_16 + var_318_17 and arg_315_1.time_ < var_318_16 + var_318_17 + arg_318_0 then
				var_318_15.localPosition = Vector3.New(0, 100, 0)

				local var_318_22 = manager.ui.mainCamera.transform.position - var_318_15.position

				var_318_15.forward = Vector3.New(var_318_22.x, var_318_22.y, var_318_22.z)

				local var_318_23 = var_318_15.localEulerAngles

				var_318_23.z = 0
				var_318_23.x = 0
				var_318_15.localEulerAngles = var_318_23
			end

			local var_318_24 = arg_315_1.actors_["1184ui_story"]
			local var_318_25 = 0

			if var_318_25 < arg_315_1.time_ and arg_315_1.time_ <= var_318_25 + arg_318_0 and not isNil(var_318_24) and arg_315_1.var_.characterEffect1184ui_story == nil then
				arg_315_1.var_.characterEffect1184ui_story = var_318_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_318_26 = 0.200000002980232

			if var_318_25 <= arg_315_1.time_ and arg_315_1.time_ < var_318_25 + var_318_26 and not isNil(var_318_24) then
				local var_318_27 = (arg_315_1.time_ - var_318_25) / var_318_26

				if arg_315_1.var_.characterEffect1184ui_story and not isNil(var_318_24) then
					local var_318_28 = Mathf.Lerp(0, 0.5, var_318_27)

					arg_315_1.var_.characterEffect1184ui_story.fillFlat = true
					arg_315_1.var_.characterEffect1184ui_story.fillRatio = var_318_28
				end
			end

			if arg_315_1.time_ >= var_318_25 + var_318_26 and arg_315_1.time_ < var_318_25 + var_318_26 + arg_318_0 and not isNil(var_318_24) and arg_315_1.var_.characterEffect1184ui_story then
				local var_318_29 = 0.5

				arg_315_1.var_.characterEffect1184ui_story.fillFlat = true
				arg_315_1.var_.characterEffect1184ui_story.fillRatio = var_318_29
			end

			local var_318_30 = 0
			local var_318_31 = 0.575

			if var_318_30 < arg_315_1.time_ and arg_315_1.time_ <= var_318_30 + arg_318_0 then
				arg_315_1.talkMaxDuration = 0
				arg_315_1.dialogCg_.alpha = 1

				arg_315_1.dialog_:SetActive(true)
				SetActive(arg_315_1.leftNameGo_, false)

				arg_315_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_315_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_315_1:RecordName(arg_315_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_315_1.iconTrs_.gameObject, false)
				arg_315_1.callingController_:SetSelectedState("normal")

				local var_318_32 = arg_315_1:GetWordFromCfg(121561077)
				local var_318_33 = arg_315_1:FormatText(var_318_32.content)

				arg_315_1.text_.text = var_318_33

				LuaForUtil.ClearLinePrefixSymbol(arg_315_1.text_)

				local var_318_34 = 23
				local var_318_35 = utf8.len(var_318_33)
				local var_318_36 = var_318_34 <= 0 and var_318_31 or var_318_31 * (var_318_35 / var_318_34)

				if var_318_36 > 0 and var_318_31 < var_318_36 then
					arg_315_1.talkMaxDuration = var_318_36

					if var_318_36 + var_318_30 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_36 + var_318_30
					end
				end

				arg_315_1.text_.text = var_318_33
				arg_315_1.typewritter.percent = 0

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(false)
				arg_315_1:RecordContent(arg_315_1.text_.text)
			end

			local var_318_37 = math.max(var_318_31, arg_315_1.talkMaxDuration)

			if var_318_30 <= arg_315_1.time_ and arg_315_1.time_ < var_318_30 + var_318_37 then
				arg_315_1.typewritter.percent = (arg_315_1.time_ - var_318_30) / var_318_37

				arg_315_1.typewritter:SetDirty()
			end

			if arg_315_1.time_ >= var_318_30 + var_318_37 and arg_315_1.time_ < var_318_30 + var_318_37 + arg_318_0 then
				arg_315_1.typewritter.percent = 1

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(true)
			end
		end

		arg_315_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1184ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_315_1:InitPlayNodeList()
	end,
	Play121561078 = function(arg_319_0, arg_319_1)
		arg_319_1.time_ = 0
		arg_319_1.frameCnt_ = 0
		arg_319_1.state_ = "playing"
		arg_319_1.curTalkId_ = 121561078
		arg_319_1.duration_ = 11.3

		local var_319_0 = {
			ja = 11.3,
			ko = 7.333,
			zh = 7.333
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
				arg_319_0:Play121561079(arg_319_1)
			end
		end

		function arg_319_1.onSingleLineUpdate_(arg_322_0)
			local var_322_0 = arg_319_1.actors_["1071ui_story"].transform
			local var_322_1 = 0

			if var_322_1 < arg_319_1.time_ and arg_319_1.time_ <= var_322_1 + arg_322_0 then
				arg_319_1.var_.moveOldPos1071ui_story = var_322_0.localPosition
			end

			local var_322_2 = 0.001

			if var_322_1 <= arg_319_1.time_ and arg_319_1.time_ < var_322_1 + var_322_2 then
				local var_322_3 = (arg_319_1.time_ - var_322_1) / var_322_2
				local var_322_4 = Vector3.New(-0.7, -1.05, -6.2)

				var_322_0.localPosition = Vector3.Lerp(arg_319_1.var_.moveOldPos1071ui_story, var_322_4, var_322_3)

				local var_322_5 = manager.ui.mainCamera.transform.position - var_322_0.position

				var_322_0.forward = Vector3.New(var_322_5.x, var_322_5.y, var_322_5.z)

				local var_322_6 = var_322_0.localEulerAngles

				var_322_6.z = 0
				var_322_6.x = 0
				var_322_0.localEulerAngles = var_322_6
			end

			if arg_319_1.time_ >= var_322_1 + var_322_2 and arg_319_1.time_ < var_322_1 + var_322_2 + arg_322_0 then
				var_322_0.localPosition = Vector3.New(-0.7, -1.05, -6.2)

				local var_322_7 = manager.ui.mainCamera.transform.position - var_322_0.position

				var_322_0.forward = Vector3.New(var_322_7.x, var_322_7.y, var_322_7.z)

				local var_322_8 = var_322_0.localEulerAngles

				var_322_8.z = 0
				var_322_8.x = 0
				var_322_0.localEulerAngles = var_322_8
			end

			local var_322_9 = arg_319_1.actors_["1071ui_story"]
			local var_322_10 = 0

			if var_322_10 < arg_319_1.time_ and arg_319_1.time_ <= var_322_10 + arg_322_0 and not isNil(var_322_9) and arg_319_1.var_.characterEffect1071ui_story == nil then
				arg_319_1.var_.characterEffect1071ui_story = var_322_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_322_11 = 0.200000002980232

			if var_322_10 <= arg_319_1.time_ and arg_319_1.time_ < var_322_10 + var_322_11 and not isNil(var_322_9) then
				local var_322_12 = (arg_319_1.time_ - var_322_10) / var_322_11

				if arg_319_1.var_.characterEffect1071ui_story and not isNil(var_322_9) then
					arg_319_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_319_1.time_ >= var_322_10 + var_322_11 and arg_319_1.time_ < var_322_10 + var_322_11 + arg_322_0 and not isNil(var_322_9) and arg_319_1.var_.characterEffect1071ui_story then
				arg_319_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_322_13 = 0

			if var_322_13 < arg_319_1.time_ and arg_319_1.time_ <= var_322_13 + arg_322_0 then
				arg_319_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action1_1")
			end

			local var_322_14 = 0

			if var_322_14 < arg_319_1.time_ and arg_319_1.time_ <= var_322_14 + arg_322_0 then
				arg_319_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_322_15 = arg_319_1.actors_["1184ui_story"].transform
			local var_322_16 = 0

			if var_322_16 < arg_319_1.time_ and arg_319_1.time_ <= var_322_16 + arg_322_0 then
				arg_319_1.var_.moveOldPos1184ui_story = var_322_15.localPosition
			end

			local var_322_17 = 0.001

			if var_322_16 <= arg_319_1.time_ and arg_319_1.time_ < var_322_16 + var_322_17 then
				local var_322_18 = (arg_319_1.time_ - var_322_16) / var_322_17
				local var_322_19 = Vector3.New(0.7, -0.97, -6)

				var_322_15.localPosition = Vector3.Lerp(arg_319_1.var_.moveOldPos1184ui_story, var_322_19, var_322_18)

				local var_322_20 = manager.ui.mainCamera.transform.position - var_322_15.position

				var_322_15.forward = Vector3.New(var_322_20.x, var_322_20.y, var_322_20.z)

				local var_322_21 = var_322_15.localEulerAngles

				var_322_21.z = 0
				var_322_21.x = 0
				var_322_15.localEulerAngles = var_322_21
			end

			if arg_319_1.time_ >= var_322_16 + var_322_17 and arg_319_1.time_ < var_322_16 + var_322_17 + arg_322_0 then
				var_322_15.localPosition = Vector3.New(0.7, -0.97, -6)

				local var_322_22 = manager.ui.mainCamera.transform.position - var_322_15.position

				var_322_15.forward = Vector3.New(var_322_22.x, var_322_22.y, var_322_22.z)

				local var_322_23 = var_322_15.localEulerAngles

				var_322_23.z = 0
				var_322_23.x = 0
				var_322_15.localEulerAngles = var_322_23
			end

			local var_322_24 = arg_319_1.actors_["1184ui_story"]
			local var_322_25 = 0

			if var_322_25 < arg_319_1.time_ and arg_319_1.time_ <= var_322_25 + arg_322_0 and not isNil(var_322_24) and arg_319_1.var_.characterEffect1184ui_story == nil then
				arg_319_1.var_.characterEffect1184ui_story = var_322_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_322_26 = 0.200000002980232

			if var_322_25 <= arg_319_1.time_ and arg_319_1.time_ < var_322_25 + var_322_26 and not isNil(var_322_24) then
				local var_322_27 = (arg_319_1.time_ - var_322_25) / var_322_26

				if arg_319_1.var_.characterEffect1184ui_story and not isNil(var_322_24) then
					local var_322_28 = Mathf.Lerp(0, 0.5, var_322_27)

					arg_319_1.var_.characterEffect1184ui_story.fillFlat = true
					arg_319_1.var_.characterEffect1184ui_story.fillRatio = var_322_28
				end
			end

			if arg_319_1.time_ >= var_322_25 + var_322_26 and arg_319_1.time_ < var_322_25 + var_322_26 + arg_322_0 and not isNil(var_322_24) and arg_319_1.var_.characterEffect1184ui_story then
				local var_322_29 = 0.5

				arg_319_1.var_.characterEffect1184ui_story.fillFlat = true
				arg_319_1.var_.characterEffect1184ui_story.fillRatio = var_322_29
			end

			local var_322_30 = 0
			local var_322_31 = 0.925

			if var_322_30 < arg_319_1.time_ and arg_319_1.time_ <= var_322_30 + arg_322_0 then
				arg_319_1.talkMaxDuration = 0
				arg_319_1.dialogCg_.alpha = 1

				arg_319_1.dialog_:SetActive(true)
				SetActive(arg_319_1.leftNameGo_, true)

				local var_322_32 = arg_319_1:FormatText(StoryNameCfg[384].name)

				arg_319_1.leftNameTxt_.text = var_322_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_319_1.leftNameTxt_.transform)

				arg_319_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_319_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_319_1:RecordName(arg_319_1.leftNameTxt_.text)
				SetActive(arg_319_1.iconTrs_.gameObject, false)
				arg_319_1.callingController_:SetSelectedState("normal")

				local var_322_33 = arg_319_1:GetWordFromCfg(121561078)
				local var_322_34 = arg_319_1:FormatText(var_322_33.content)

				arg_319_1.text_.text = var_322_34

				LuaForUtil.ClearLinePrefixSymbol(arg_319_1.text_)

				local var_322_35 = 37
				local var_322_36 = utf8.len(var_322_34)
				local var_322_37 = var_322_35 <= 0 and var_322_31 or var_322_31 * (var_322_36 / var_322_35)

				if var_322_37 > 0 and var_322_31 < var_322_37 then
					arg_319_1.talkMaxDuration = var_322_37

					if var_322_37 + var_322_30 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_37 + var_322_30
					end
				end

				arg_319_1.text_.text = var_322_34
				arg_319_1.typewritter.percent = 0

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121561", "121561078", "story_v_out_121561.awb") ~= 0 then
					local var_322_38 = manager.audio:GetVoiceLength("story_v_out_121561", "121561078", "story_v_out_121561.awb") / 1000

					if var_322_38 + var_322_30 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_38 + var_322_30
					end

					if var_322_33.prefab_name ~= "" and arg_319_1.actors_[var_322_33.prefab_name] ~= nil then
						local var_322_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_319_1.actors_[var_322_33.prefab_name].transform, "story_v_out_121561", "121561078", "story_v_out_121561.awb")

						arg_319_1:RecordAudio("121561078", var_322_39)
						arg_319_1:RecordAudio("121561078", var_322_39)
					else
						arg_319_1:AudioAction("play", "voice", "story_v_out_121561", "121561078", "story_v_out_121561.awb")
					end

					arg_319_1:RecordHistoryTalkVoice("story_v_out_121561", "121561078", "story_v_out_121561.awb")
				end

				arg_319_1:RecordContent(arg_319_1.text_.text)
			end

			local var_322_40 = math.max(var_322_31, arg_319_1.talkMaxDuration)

			if var_322_30 <= arg_319_1.time_ and arg_319_1.time_ < var_322_30 + var_322_40 then
				arg_319_1.typewritter.percent = (arg_319_1.time_ - var_322_30) / var_322_40

				arg_319_1.typewritter:SetDirty()
			end

			if arg_319_1.time_ >= var_322_30 + var_322_40 and arg_319_1.time_ < var_322_30 + var_322_40 + arg_322_0 then
				arg_319_1.typewritter.percent = 1

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(true)
			end
		end

		arg_319_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1184ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_319_1:InitPlayNodeList()
	end,
	Play121561079 = function(arg_323_0, arg_323_1)
		arg_323_1.time_ = 0
		arg_323_1.frameCnt_ = 0
		arg_323_1.state_ = "playing"
		arg_323_1.curTalkId_ = 121561079
		arg_323_1.duration_ = 4.63

		SetActive(arg_323_1.tipsGo_, false)

		function arg_323_1.onSingleLineFinish_()
			arg_323_1.onSingleLineUpdate_ = nil
			arg_323_1.onSingleLineFinish_ = nil
			arg_323_1.state_ = "waiting"
		end

		function arg_323_1.playNext_(arg_325_0)
			if arg_325_0 == 1 then
				arg_323_0:Play121561080(arg_323_1)
			end
		end

		function arg_323_1.onSingleLineUpdate_(arg_326_0)
			local var_326_0 = arg_323_1.actors_["1184ui_story"]
			local var_326_1 = 0

			if var_326_1 < arg_323_1.time_ and arg_323_1.time_ <= var_326_1 + arg_326_0 and not isNil(var_326_0) and arg_323_1.var_.characterEffect1184ui_story == nil then
				arg_323_1.var_.characterEffect1184ui_story = var_326_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_326_2 = 0.200000002980232

			if var_326_1 <= arg_323_1.time_ and arg_323_1.time_ < var_326_1 + var_326_2 and not isNil(var_326_0) then
				local var_326_3 = (arg_323_1.time_ - var_326_1) / var_326_2

				if arg_323_1.var_.characterEffect1184ui_story and not isNil(var_326_0) then
					arg_323_1.var_.characterEffect1184ui_story.fillFlat = false
				end
			end

			if arg_323_1.time_ >= var_326_1 + var_326_2 and arg_323_1.time_ < var_326_1 + var_326_2 + arg_326_0 and not isNil(var_326_0) and arg_323_1.var_.characterEffect1184ui_story then
				arg_323_1.var_.characterEffect1184ui_story.fillFlat = false
			end

			local var_326_4 = 0

			if var_326_4 < arg_323_1.time_ and arg_323_1.time_ <= var_326_4 + arg_326_0 then
				arg_323_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_2")
			end

			local var_326_5 = 0

			if var_326_5 < arg_323_1.time_ and arg_323_1.time_ <= var_326_5 + arg_326_0 then
				arg_323_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_326_6 = arg_323_1.actors_["1071ui_story"]
			local var_326_7 = 0

			if var_326_7 < arg_323_1.time_ and arg_323_1.time_ <= var_326_7 + arg_326_0 and not isNil(var_326_6) and arg_323_1.var_.characterEffect1071ui_story == nil then
				arg_323_1.var_.characterEffect1071ui_story = var_326_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_326_8 = 0.200000002980232

			if var_326_7 <= arg_323_1.time_ and arg_323_1.time_ < var_326_7 + var_326_8 and not isNil(var_326_6) then
				local var_326_9 = (arg_323_1.time_ - var_326_7) / var_326_8

				if arg_323_1.var_.characterEffect1071ui_story and not isNil(var_326_6) then
					local var_326_10 = Mathf.Lerp(0, 0.5, var_326_9)

					arg_323_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_323_1.var_.characterEffect1071ui_story.fillRatio = var_326_10
				end
			end

			if arg_323_1.time_ >= var_326_7 + var_326_8 and arg_323_1.time_ < var_326_7 + var_326_8 + arg_326_0 and not isNil(var_326_6) and arg_323_1.var_.characterEffect1071ui_story then
				local var_326_11 = 0.5

				arg_323_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_323_1.var_.characterEffect1071ui_story.fillRatio = var_326_11
			end

			local var_326_12 = 0
			local var_326_13 = 0.5

			if var_326_12 < arg_323_1.time_ and arg_323_1.time_ <= var_326_12 + arg_326_0 then
				arg_323_1.talkMaxDuration = 0
				arg_323_1.dialogCg_.alpha = 1

				arg_323_1.dialog_:SetActive(true)
				SetActive(arg_323_1.leftNameGo_, true)

				local var_326_14 = arg_323_1:FormatText(StoryNameCfg[6].name)

				arg_323_1.leftNameTxt_.text = var_326_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_323_1.leftNameTxt_.transform)

				arg_323_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_323_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_323_1:RecordName(arg_323_1.leftNameTxt_.text)
				SetActive(arg_323_1.iconTrs_.gameObject, false)
				arg_323_1.callingController_:SetSelectedState("normal")

				local var_326_15 = arg_323_1:GetWordFromCfg(121561079)
				local var_326_16 = arg_323_1:FormatText(var_326_15.content)

				arg_323_1.text_.text = var_326_16

				LuaForUtil.ClearLinePrefixSymbol(arg_323_1.text_)

				local var_326_17 = 20
				local var_326_18 = utf8.len(var_326_16)
				local var_326_19 = var_326_17 <= 0 and var_326_13 or var_326_13 * (var_326_18 / var_326_17)

				if var_326_19 > 0 and var_326_13 < var_326_19 then
					arg_323_1.talkMaxDuration = var_326_19

					if var_326_19 + var_326_12 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_19 + var_326_12
					end
				end

				arg_323_1.text_.text = var_326_16
				arg_323_1.typewritter.percent = 0

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121561", "121561079", "story_v_out_121561.awb") ~= 0 then
					local var_326_20 = manager.audio:GetVoiceLength("story_v_out_121561", "121561079", "story_v_out_121561.awb") / 1000

					if var_326_20 + var_326_12 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_20 + var_326_12
					end

					if var_326_15.prefab_name ~= "" and arg_323_1.actors_[var_326_15.prefab_name] ~= nil then
						local var_326_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_323_1.actors_[var_326_15.prefab_name].transform, "story_v_out_121561", "121561079", "story_v_out_121561.awb")

						arg_323_1:RecordAudio("121561079", var_326_21)
						arg_323_1:RecordAudio("121561079", var_326_21)
					else
						arg_323_1:AudioAction("play", "voice", "story_v_out_121561", "121561079", "story_v_out_121561.awb")
					end

					arg_323_1:RecordHistoryTalkVoice("story_v_out_121561", "121561079", "story_v_out_121561.awb")
				end

				arg_323_1:RecordContent(arg_323_1.text_.text)
			end

			local var_326_22 = math.max(var_326_13, arg_323_1.talkMaxDuration)

			if var_326_12 <= arg_323_1.time_ and arg_323_1.time_ < var_326_12 + var_326_22 then
				arg_323_1.typewritter.percent = (arg_323_1.time_ - var_326_12) / var_326_22

				arg_323_1.typewritter:SetDirty()
			end

			if arg_323_1.time_ >= var_326_12 + var_326_22 and arg_323_1.time_ < var_326_12 + var_326_22 + arg_326_0 then
				arg_323_1.typewritter.percent = 1

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(true)
			end
		end

		arg_323_1.nodeConfigList_ = {}

		arg_323_1:InitPlayNodeList()
	end,
	Play121561080 = function(arg_327_0, arg_327_1)
		arg_327_1.time_ = 0
		arg_327_1.frameCnt_ = 0
		arg_327_1.state_ = "playing"
		arg_327_1.curTalkId_ = 121561080
		arg_327_1.duration_ = 7.03

		local var_327_0 = {
			ja = 7.033,
			ko = 4.533,
			zh = 4.533
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
				arg_327_0:Play121561081(arg_327_1)
			end
		end

		function arg_327_1.onSingleLineUpdate_(arg_330_0)
			local var_330_0 = arg_327_1.actors_["1071ui_story"]
			local var_330_1 = 0

			if var_330_1 < arg_327_1.time_ and arg_327_1.time_ <= var_330_1 + arg_330_0 and not isNil(var_330_0) and arg_327_1.var_.characterEffect1071ui_story == nil then
				arg_327_1.var_.characterEffect1071ui_story = var_330_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_330_2 = 0.200000002980232

			if var_330_1 <= arg_327_1.time_ and arg_327_1.time_ < var_330_1 + var_330_2 and not isNil(var_330_0) then
				local var_330_3 = (arg_327_1.time_ - var_330_1) / var_330_2

				if arg_327_1.var_.characterEffect1071ui_story and not isNil(var_330_0) then
					arg_327_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_327_1.time_ >= var_330_1 + var_330_2 and arg_327_1.time_ < var_330_1 + var_330_2 + arg_330_0 and not isNil(var_330_0) and arg_327_1.var_.characterEffect1071ui_story then
				arg_327_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_330_4 = 0

			if var_330_4 < arg_327_1.time_ and arg_327_1.time_ <= var_330_4 + arg_330_0 then
				arg_327_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action2_1")
			end

			local var_330_5 = arg_327_1.actors_["1184ui_story"]
			local var_330_6 = 0

			if var_330_6 < arg_327_1.time_ and arg_327_1.time_ <= var_330_6 + arg_330_0 and not isNil(var_330_5) and arg_327_1.var_.characterEffect1184ui_story == nil then
				arg_327_1.var_.characterEffect1184ui_story = var_330_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_330_7 = 0.200000002980232

			if var_330_6 <= arg_327_1.time_ and arg_327_1.time_ < var_330_6 + var_330_7 and not isNil(var_330_5) then
				local var_330_8 = (arg_327_1.time_ - var_330_6) / var_330_7

				if arg_327_1.var_.characterEffect1184ui_story and not isNil(var_330_5) then
					local var_330_9 = Mathf.Lerp(0, 0.5, var_330_8)

					arg_327_1.var_.characterEffect1184ui_story.fillFlat = true
					arg_327_1.var_.characterEffect1184ui_story.fillRatio = var_330_9
				end
			end

			if arg_327_1.time_ >= var_330_6 + var_330_7 and arg_327_1.time_ < var_330_6 + var_330_7 + arg_330_0 and not isNil(var_330_5) and arg_327_1.var_.characterEffect1184ui_story then
				local var_330_10 = 0.5

				arg_327_1.var_.characterEffect1184ui_story.fillFlat = true
				arg_327_1.var_.characterEffect1184ui_story.fillRatio = var_330_10
			end

			local var_330_11 = 0
			local var_330_12 = 0.35

			if var_330_11 < arg_327_1.time_ and arg_327_1.time_ <= var_330_11 + arg_330_0 then
				arg_327_1.talkMaxDuration = 0
				arg_327_1.dialogCg_.alpha = 1

				arg_327_1.dialog_:SetActive(true)
				SetActive(arg_327_1.leftNameGo_, true)

				local var_330_13 = arg_327_1:FormatText(StoryNameCfg[384].name)

				arg_327_1.leftNameTxt_.text = var_330_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_327_1.leftNameTxt_.transform)

				arg_327_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_327_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_327_1:RecordName(arg_327_1.leftNameTxt_.text)
				SetActive(arg_327_1.iconTrs_.gameObject, false)
				arg_327_1.callingController_:SetSelectedState("normal")

				local var_330_14 = arg_327_1:GetWordFromCfg(121561080)
				local var_330_15 = arg_327_1:FormatText(var_330_14.content)

				arg_327_1.text_.text = var_330_15

				LuaForUtil.ClearLinePrefixSymbol(arg_327_1.text_)

				local var_330_16 = 14
				local var_330_17 = utf8.len(var_330_15)
				local var_330_18 = var_330_16 <= 0 and var_330_12 or var_330_12 * (var_330_17 / var_330_16)

				if var_330_18 > 0 and var_330_12 < var_330_18 then
					arg_327_1.talkMaxDuration = var_330_18

					if var_330_18 + var_330_11 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_18 + var_330_11
					end
				end

				arg_327_1.text_.text = var_330_15
				arg_327_1.typewritter.percent = 0

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121561", "121561080", "story_v_out_121561.awb") ~= 0 then
					local var_330_19 = manager.audio:GetVoiceLength("story_v_out_121561", "121561080", "story_v_out_121561.awb") / 1000

					if var_330_19 + var_330_11 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_19 + var_330_11
					end

					if var_330_14.prefab_name ~= "" and arg_327_1.actors_[var_330_14.prefab_name] ~= nil then
						local var_330_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_327_1.actors_[var_330_14.prefab_name].transform, "story_v_out_121561", "121561080", "story_v_out_121561.awb")

						arg_327_1:RecordAudio("121561080", var_330_20)
						arg_327_1:RecordAudio("121561080", var_330_20)
					else
						arg_327_1:AudioAction("play", "voice", "story_v_out_121561", "121561080", "story_v_out_121561.awb")
					end

					arg_327_1:RecordHistoryTalkVoice("story_v_out_121561", "121561080", "story_v_out_121561.awb")
				end

				arg_327_1:RecordContent(arg_327_1.text_.text)
			end

			local var_330_21 = math.max(var_330_12, arg_327_1.talkMaxDuration)

			if var_330_11 <= arg_327_1.time_ and arg_327_1.time_ < var_330_11 + var_330_21 then
				arg_327_1.typewritter.percent = (arg_327_1.time_ - var_330_11) / var_330_21

				arg_327_1.typewritter:SetDirty()
			end

			if arg_327_1.time_ >= var_330_11 + var_330_21 and arg_327_1.time_ < var_330_11 + var_330_21 + arg_330_0 then
				arg_327_1.typewritter.percent = 1

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(true)
			end
		end

		arg_327_1.nodeConfigList_ = {}

		arg_327_1:InitPlayNodeList()
	end,
	Play121561081 = function(arg_331_0, arg_331_1)
		arg_331_1.time_ = 0
		arg_331_1.frameCnt_ = 0
		arg_331_1.state_ = "playing"
		arg_331_1.curTalkId_ = 121561081
		arg_331_1.duration_ = 4

		local var_331_0 = {
			ja = 3.433,
			ko = 4,
			zh = 4
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
				arg_331_0:Play121561082(arg_331_1)
			end
		end

		function arg_331_1.onSingleLineUpdate_(arg_334_0)
			local var_334_0 = arg_331_1.actors_["1071ui_story"].transform
			local var_334_1 = 0

			if var_334_1 < arg_331_1.time_ and arg_331_1.time_ <= var_334_1 + arg_334_0 then
				arg_331_1.var_.moveOldPos1071ui_story = var_334_0.localPosition
			end

			local var_334_2 = 0.001

			if var_334_1 <= arg_331_1.time_ and arg_331_1.time_ < var_334_1 + var_334_2 then
				local var_334_3 = (arg_331_1.time_ - var_334_1) / var_334_2
				local var_334_4 = Vector3.New(-0.7, -1.05, -6.2)

				var_334_0.localPosition = Vector3.Lerp(arg_331_1.var_.moveOldPos1071ui_story, var_334_4, var_334_3)

				local var_334_5 = manager.ui.mainCamera.transform.position - var_334_0.position

				var_334_0.forward = Vector3.New(var_334_5.x, var_334_5.y, var_334_5.z)

				local var_334_6 = var_334_0.localEulerAngles

				var_334_6.z = 0
				var_334_6.x = 0
				var_334_0.localEulerAngles = var_334_6
			end

			if arg_331_1.time_ >= var_334_1 + var_334_2 and arg_331_1.time_ < var_334_1 + var_334_2 + arg_334_0 then
				var_334_0.localPosition = Vector3.New(-0.7, -1.05, -6.2)

				local var_334_7 = manager.ui.mainCamera.transform.position - var_334_0.position

				var_334_0.forward = Vector3.New(var_334_7.x, var_334_7.y, var_334_7.z)

				local var_334_8 = var_334_0.localEulerAngles

				var_334_8.z = 0
				var_334_8.x = 0
				var_334_0.localEulerAngles = var_334_8
			end

			local var_334_9 = arg_331_1.actors_["1071ui_story"]
			local var_334_10 = 0

			if var_334_10 < arg_331_1.time_ and arg_331_1.time_ <= var_334_10 + arg_334_0 and not isNil(var_334_9) and arg_331_1.var_.characterEffect1071ui_story == nil then
				arg_331_1.var_.characterEffect1071ui_story = var_334_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_334_11 = 0.200000002980232

			if var_334_10 <= arg_331_1.time_ and arg_331_1.time_ < var_334_10 + var_334_11 and not isNil(var_334_9) then
				local var_334_12 = (arg_331_1.time_ - var_334_10) / var_334_11

				if arg_331_1.var_.characterEffect1071ui_story and not isNil(var_334_9) then
					arg_331_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_331_1.time_ >= var_334_10 + var_334_11 and arg_331_1.time_ < var_334_10 + var_334_11 + arg_334_0 and not isNil(var_334_9) and arg_331_1.var_.characterEffect1071ui_story then
				arg_331_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_334_13 = 0

			if var_334_13 < arg_331_1.time_ and arg_331_1.time_ <= var_334_13 + arg_334_0 then
				arg_331_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action2_2")
			end

			local var_334_14 = 0

			if var_334_14 < arg_331_1.time_ and arg_331_1.time_ <= var_334_14 + arg_334_0 then
				arg_331_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_334_15 = 0
			local var_334_16 = 0.425

			if var_334_15 < arg_331_1.time_ and arg_331_1.time_ <= var_334_15 + arg_334_0 then
				arg_331_1.talkMaxDuration = 0
				arg_331_1.dialogCg_.alpha = 1

				arg_331_1.dialog_:SetActive(true)
				SetActive(arg_331_1.leftNameGo_, true)

				local var_334_17 = arg_331_1:FormatText(StoryNameCfg[384].name)

				arg_331_1.leftNameTxt_.text = var_334_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_331_1.leftNameTxt_.transform)

				arg_331_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_331_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_331_1:RecordName(arg_331_1.leftNameTxt_.text)
				SetActive(arg_331_1.iconTrs_.gameObject, false)
				arg_331_1.callingController_:SetSelectedState("normal")

				local var_334_18 = arg_331_1:GetWordFromCfg(121561081)
				local var_334_19 = arg_331_1:FormatText(var_334_18.content)

				arg_331_1.text_.text = var_334_19

				LuaForUtil.ClearLinePrefixSymbol(arg_331_1.text_)

				local var_334_20 = 17
				local var_334_21 = utf8.len(var_334_19)
				local var_334_22 = var_334_20 <= 0 and var_334_16 or var_334_16 * (var_334_21 / var_334_20)

				if var_334_22 > 0 and var_334_16 < var_334_22 then
					arg_331_1.talkMaxDuration = var_334_22

					if var_334_22 + var_334_15 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_22 + var_334_15
					end
				end

				arg_331_1.text_.text = var_334_19
				arg_331_1.typewritter.percent = 0

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121561", "121561081", "story_v_out_121561.awb") ~= 0 then
					local var_334_23 = manager.audio:GetVoiceLength("story_v_out_121561", "121561081", "story_v_out_121561.awb") / 1000

					if var_334_23 + var_334_15 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_23 + var_334_15
					end

					if var_334_18.prefab_name ~= "" and arg_331_1.actors_[var_334_18.prefab_name] ~= nil then
						local var_334_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_331_1.actors_[var_334_18.prefab_name].transform, "story_v_out_121561", "121561081", "story_v_out_121561.awb")

						arg_331_1:RecordAudio("121561081", var_334_24)
						arg_331_1:RecordAudio("121561081", var_334_24)
					else
						arg_331_1:AudioAction("play", "voice", "story_v_out_121561", "121561081", "story_v_out_121561.awb")
					end

					arg_331_1:RecordHistoryTalkVoice("story_v_out_121561", "121561081", "story_v_out_121561.awb")
				end

				arg_331_1:RecordContent(arg_331_1.text_.text)
			end

			local var_334_25 = math.max(var_334_16, arg_331_1.talkMaxDuration)

			if var_334_15 <= arg_331_1.time_ and arg_331_1.time_ < var_334_15 + var_334_25 then
				arg_331_1.typewritter.percent = (arg_331_1.time_ - var_334_15) / var_334_25

				arg_331_1.typewritter:SetDirty()
			end

			if arg_331_1.time_ >= var_334_15 + var_334_25 and arg_331_1.time_ < var_334_15 + var_334_25 + arg_334_0 then
				arg_331_1.typewritter.percent = 1

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(true)
			end
		end

		arg_331_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_331_1:InitPlayNodeList()
	end,
	Play121561082 = function(arg_335_0, arg_335_1)
		arg_335_1.time_ = 0
		arg_335_1.frameCnt_ = 0
		arg_335_1.state_ = "playing"
		arg_335_1.curTalkId_ = 121561082
		arg_335_1.duration_ = 5

		SetActive(arg_335_1.tipsGo_, false)

		function arg_335_1.onSingleLineFinish_()
			arg_335_1.onSingleLineUpdate_ = nil
			arg_335_1.onSingleLineFinish_ = nil
			arg_335_1.state_ = "waiting"
		end

		function arg_335_1.playNext_(arg_337_0)
			if arg_337_0 == 1 then
				arg_335_0:Play121561083(arg_335_1)
			end
		end

		function arg_335_1.onSingleLineUpdate_(arg_338_0)
			local var_338_0 = arg_335_1.actors_["1071ui_story"].transform
			local var_338_1 = 0

			if var_338_1 < arg_335_1.time_ and arg_335_1.time_ <= var_338_1 + arg_338_0 then
				arg_335_1.var_.moveOldPos1071ui_story = var_338_0.localPosition
			end

			local var_338_2 = 0.001

			if var_338_1 <= arg_335_1.time_ and arg_335_1.time_ < var_338_1 + var_338_2 then
				local var_338_3 = (arg_335_1.time_ - var_338_1) / var_338_2
				local var_338_4 = Vector3.New(0, 100, 0)

				var_338_0.localPosition = Vector3.Lerp(arg_335_1.var_.moveOldPos1071ui_story, var_338_4, var_338_3)

				local var_338_5 = manager.ui.mainCamera.transform.position - var_338_0.position

				var_338_0.forward = Vector3.New(var_338_5.x, var_338_5.y, var_338_5.z)

				local var_338_6 = var_338_0.localEulerAngles

				var_338_6.z = 0
				var_338_6.x = 0
				var_338_0.localEulerAngles = var_338_6
			end

			if arg_335_1.time_ >= var_338_1 + var_338_2 and arg_335_1.time_ < var_338_1 + var_338_2 + arg_338_0 then
				var_338_0.localPosition = Vector3.New(0, 100, 0)

				local var_338_7 = manager.ui.mainCamera.transform.position - var_338_0.position

				var_338_0.forward = Vector3.New(var_338_7.x, var_338_7.y, var_338_7.z)

				local var_338_8 = var_338_0.localEulerAngles

				var_338_8.z = 0
				var_338_8.x = 0
				var_338_0.localEulerAngles = var_338_8
			end

			local var_338_9 = arg_335_1.actors_["1071ui_story"]
			local var_338_10 = 0

			if var_338_10 < arg_335_1.time_ and arg_335_1.time_ <= var_338_10 + arg_338_0 and not isNil(var_338_9) and arg_335_1.var_.characterEffect1071ui_story == nil then
				arg_335_1.var_.characterEffect1071ui_story = var_338_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_338_11 = 0.200000002980232

			if var_338_10 <= arg_335_1.time_ and arg_335_1.time_ < var_338_10 + var_338_11 and not isNil(var_338_9) then
				local var_338_12 = (arg_335_1.time_ - var_338_10) / var_338_11

				if arg_335_1.var_.characterEffect1071ui_story and not isNil(var_338_9) then
					local var_338_13 = Mathf.Lerp(0, 0.5, var_338_12)

					arg_335_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_335_1.var_.characterEffect1071ui_story.fillRatio = var_338_13
				end
			end

			if arg_335_1.time_ >= var_338_10 + var_338_11 and arg_335_1.time_ < var_338_10 + var_338_11 + arg_338_0 and not isNil(var_338_9) and arg_335_1.var_.characterEffect1071ui_story then
				local var_338_14 = 0.5

				arg_335_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_335_1.var_.characterEffect1071ui_story.fillRatio = var_338_14
			end

			local var_338_15 = arg_335_1.actors_["1184ui_story"].transform
			local var_338_16 = 0

			if var_338_16 < arg_335_1.time_ and arg_335_1.time_ <= var_338_16 + arg_338_0 then
				arg_335_1.var_.moveOldPos1184ui_story = var_338_15.localPosition
			end

			local var_338_17 = 0.001

			if var_338_16 <= arg_335_1.time_ and arg_335_1.time_ < var_338_16 + var_338_17 then
				local var_338_18 = (arg_335_1.time_ - var_338_16) / var_338_17
				local var_338_19 = Vector3.New(0, 100, 0)

				var_338_15.localPosition = Vector3.Lerp(arg_335_1.var_.moveOldPos1184ui_story, var_338_19, var_338_18)

				local var_338_20 = manager.ui.mainCamera.transform.position - var_338_15.position

				var_338_15.forward = Vector3.New(var_338_20.x, var_338_20.y, var_338_20.z)

				local var_338_21 = var_338_15.localEulerAngles

				var_338_21.z = 0
				var_338_21.x = 0
				var_338_15.localEulerAngles = var_338_21
			end

			if arg_335_1.time_ >= var_338_16 + var_338_17 and arg_335_1.time_ < var_338_16 + var_338_17 + arg_338_0 then
				var_338_15.localPosition = Vector3.New(0, 100, 0)

				local var_338_22 = manager.ui.mainCamera.transform.position - var_338_15.position

				var_338_15.forward = Vector3.New(var_338_22.x, var_338_22.y, var_338_22.z)

				local var_338_23 = var_338_15.localEulerAngles

				var_338_23.z = 0
				var_338_23.x = 0
				var_338_15.localEulerAngles = var_338_23
			end

			local var_338_24 = arg_335_1.actors_["1184ui_story"]
			local var_338_25 = 0

			if var_338_25 < arg_335_1.time_ and arg_335_1.time_ <= var_338_25 + arg_338_0 and not isNil(var_338_24) and arg_335_1.var_.characterEffect1184ui_story == nil then
				arg_335_1.var_.characterEffect1184ui_story = var_338_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_338_26 = 0.200000002980232

			if var_338_25 <= arg_335_1.time_ and arg_335_1.time_ < var_338_25 + var_338_26 and not isNil(var_338_24) then
				local var_338_27 = (arg_335_1.time_ - var_338_25) / var_338_26

				if arg_335_1.var_.characterEffect1184ui_story and not isNil(var_338_24) then
					local var_338_28 = Mathf.Lerp(0, 0.5, var_338_27)

					arg_335_1.var_.characterEffect1184ui_story.fillFlat = true
					arg_335_1.var_.characterEffect1184ui_story.fillRatio = var_338_28
				end
			end

			if arg_335_1.time_ >= var_338_25 + var_338_26 and arg_335_1.time_ < var_338_25 + var_338_26 + arg_338_0 and not isNil(var_338_24) and arg_335_1.var_.characterEffect1184ui_story then
				local var_338_29 = 0.5

				arg_335_1.var_.characterEffect1184ui_story.fillFlat = true
				arg_335_1.var_.characterEffect1184ui_story.fillRatio = var_338_29
			end

			local var_338_30 = 0
			local var_338_31 = 0.6

			if var_338_30 < arg_335_1.time_ and arg_335_1.time_ <= var_338_30 + arg_338_0 then
				arg_335_1.talkMaxDuration = 0
				arg_335_1.dialogCg_.alpha = 1

				arg_335_1.dialog_:SetActive(true)
				SetActive(arg_335_1.leftNameGo_, false)

				arg_335_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_335_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_335_1:RecordName(arg_335_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_335_1.iconTrs_.gameObject, false)
				arg_335_1.callingController_:SetSelectedState("normal")

				local var_338_32 = arg_335_1:GetWordFromCfg(121561082)
				local var_338_33 = arg_335_1:FormatText(var_338_32.content)

				arg_335_1.text_.text = var_338_33

				LuaForUtil.ClearLinePrefixSymbol(arg_335_1.text_)

				local var_338_34 = 24
				local var_338_35 = utf8.len(var_338_33)
				local var_338_36 = var_338_34 <= 0 and var_338_31 or var_338_31 * (var_338_35 / var_338_34)

				if var_338_36 > 0 and var_338_31 < var_338_36 then
					arg_335_1.talkMaxDuration = var_338_36

					if var_338_36 + var_338_30 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_36 + var_338_30
					end
				end

				arg_335_1.text_.text = var_338_33
				arg_335_1.typewritter.percent = 0

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(false)
				arg_335_1:RecordContent(arg_335_1.text_.text)
			end

			local var_338_37 = math.max(var_338_31, arg_335_1.talkMaxDuration)

			if var_338_30 <= arg_335_1.time_ and arg_335_1.time_ < var_338_30 + var_338_37 then
				arg_335_1.typewritter.percent = (arg_335_1.time_ - var_338_30) / var_338_37

				arg_335_1.typewritter:SetDirty()
			end

			if arg_335_1.time_ >= var_338_30 + var_338_37 and arg_335_1.time_ < var_338_30 + var_338_37 + arg_338_0 then
				arg_335_1.typewritter.percent = 1

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(true)
			end
		end

		arg_335_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1184ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_335_1:InitPlayNodeList()
	end,
	Play121561083 = function(arg_339_0, arg_339_1)
		arg_339_1.time_ = 0
		arg_339_1.frameCnt_ = 0
		arg_339_1.state_ = "playing"
		arg_339_1.curTalkId_ = 121561083
		arg_339_1.duration_ = 7

		SetActive(arg_339_1.tipsGo_, false)

		function arg_339_1.onSingleLineFinish_()
			arg_339_1.onSingleLineUpdate_ = nil
			arg_339_1.onSingleLineFinish_ = nil
			arg_339_1.state_ = "waiting"
		end

		function arg_339_1.playNext_(arg_341_0)
			if arg_341_0 == 1 then
				arg_339_0:Play121561084(arg_339_1)
			end
		end

		function arg_339_1.onSingleLineUpdate_(arg_342_0)
			local var_342_0 = 0
			local var_342_1 = 0.0666666666666667

			if var_342_0 < arg_339_1.time_ and arg_339_1.time_ <= var_342_0 + arg_342_0 then
				local var_342_2 = "play"
				local var_342_3 = "music"

				arg_339_1:AudioAction(var_342_2, var_342_3, "ui_battle", "ui_battle_stopbgm", "")

				local var_342_4 = ""
				local var_342_5 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_342_5 ~= "" then
					if arg_339_1.bgmTxt_.text ~= var_342_5 and arg_339_1.bgmTxt_.text ~= "" then
						if arg_339_1.bgmTxt2_.text ~= "" then
							arg_339_1.bgmTxt_.text = arg_339_1.bgmTxt2_.text
						end

						arg_339_1.bgmTxt2_.text = var_342_5

						arg_339_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_339_1.bgmTxt_.text = var_342_5
						arg_339_1.bgmTxt2_.text = var_342_5
					end

					if arg_339_1.bgmTimer then
						arg_339_1.bgmTimer:Stop()

						arg_339_1.bgmTimer = nil
					end

					if arg_339_1.settingData.show_music_name == 1 then
						arg_339_1.musicController:SetSelectedState("show")
						arg_339_1.musicAnimator_:Play("open", 0, 0)

						if arg_339_1.settingData.music_time ~= 0 then
							arg_339_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_339_1.settingData.music_time), function()
								if arg_339_1 == nil or isNil(arg_339_1.bgmTxt_) then
									return
								end

								arg_339_1.musicController:SetSelectedState("hide")
								arg_339_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_342_6 = 0.133333333333333
			local var_342_7 = 0.5

			if var_342_6 < arg_339_1.time_ and arg_339_1.time_ <= var_342_6 + arg_342_0 then
				local var_342_8 = "play"
				local var_342_9 = "effect"

				arg_339_1:AudioAction(var_342_8, var_342_9, "se_story_121_04", "se_story_121_04_dizzle", "")
			end

			local var_342_10 = 0

			if var_342_10 < arg_339_1.time_ and arg_339_1.time_ <= var_342_10 + arg_342_0 then
				arg_339_1.mask_.enabled = true
				arg_339_1.mask_.raycastTarget = true

				arg_339_1:SetGaussion(false)
			end

			local var_342_11 = 2

			if var_342_10 <= arg_339_1.time_ and arg_339_1.time_ < var_342_10 + var_342_11 then
				local var_342_12 = (arg_339_1.time_ - var_342_10) / var_342_11
				local var_342_13 = Color.New(1, 1, 1)

				var_342_13.a = Mathf.Lerp(1, 0, var_342_12)
				arg_339_1.mask_.color = var_342_13
			end

			if arg_339_1.time_ >= var_342_10 + var_342_11 and arg_339_1.time_ < var_342_10 + var_342_11 + arg_342_0 then
				local var_342_14 = Color.New(1, 1, 1)
				local var_342_15 = 0

				arg_339_1.mask_.enabled = false
				var_342_14.a = var_342_15
				arg_339_1.mask_.color = var_342_14
			end

			local var_342_16 = manager.ui.mainCamera.transform
			local var_342_17 = 0

			if var_342_17 < arg_339_1.time_ and arg_339_1.time_ <= var_342_17 + arg_342_0 then
				arg_339_1.var_.shakeOldPos = var_342_16.localPosition
			end

			local var_342_18 = 2

			if var_342_17 <= arg_339_1.time_ and arg_339_1.time_ < var_342_17 + var_342_18 then
				local var_342_19 = (arg_339_1.time_ - var_342_17) / 0
				local var_342_20, var_342_21 = math.modf(var_342_19)

				var_342_16.localPosition = Vector3.New(var_342_21 * 0, var_342_21 * 0, var_342_21 * 0) + arg_339_1.var_.shakeOldPos
			end

			if arg_339_1.time_ >= var_342_17 + var_342_18 and arg_339_1.time_ < var_342_17 + var_342_18 + arg_342_0 then
				var_342_16.localPosition = arg_339_1.var_.shakeOldPos
			end

			if arg_339_1.frameCnt_ <= 1 then
				arg_339_1.dialog_:SetActive(false)
			end

			local var_342_22 = 2
			local var_342_23 = 1.65

			if var_342_22 < arg_339_1.time_ and arg_339_1.time_ <= var_342_22 + arg_342_0 then
				arg_339_1.talkMaxDuration = 0

				arg_339_1.dialog_:SetActive(true)

				arg_339_1.dialogCg_.alpha = 0

				local var_342_24 = LeanTween.value(arg_339_1.dialog_, 0, 1, 0.3)

				var_342_24:setOnUpdate(LuaHelper.FloatAction(function(arg_344_0)
					arg_339_1.dialogCg_.alpha = arg_344_0
				end))
				var_342_24:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_339_1.dialog_)
					var_342_24:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_339_1.duration_ = arg_339_1.duration_ + 0.3

				SetActive(arg_339_1.leftNameGo_, false)

				arg_339_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_339_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_339_1:RecordName(arg_339_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_339_1.iconTrs_.gameObject, false)
				arg_339_1.callingController_:SetSelectedState("normal")

				local var_342_25 = arg_339_1:GetWordFromCfg(121561083)
				local var_342_26 = arg_339_1:FormatText(var_342_25.content)

				arg_339_1.text_.text = var_342_26

				LuaForUtil.ClearLinePrefixSymbol(arg_339_1.text_)

				local var_342_27 = 66
				local var_342_28 = utf8.len(var_342_26)
				local var_342_29 = var_342_27 <= 0 and var_342_23 or var_342_23 * (var_342_28 / var_342_27)

				if var_342_29 > 0 and var_342_23 < var_342_29 then
					arg_339_1.talkMaxDuration = var_342_29
					var_342_22 = var_342_22 + 0.3

					if var_342_29 + var_342_22 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_29 + var_342_22
					end
				end

				arg_339_1.text_.text = var_342_26
				arg_339_1.typewritter.percent = 0

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(false)
				arg_339_1:RecordContent(arg_339_1.text_.text)
			end

			local var_342_30 = var_342_22 + 0.3
			local var_342_31 = math.max(var_342_23, arg_339_1.talkMaxDuration)

			if var_342_30 <= arg_339_1.time_ and arg_339_1.time_ < var_342_30 + var_342_31 then
				arg_339_1.typewritter.percent = (arg_339_1.time_ - var_342_30) / var_342_31

				arg_339_1.typewritter:SetDirty()
			end

			if arg_339_1.time_ >= var_342_30 + var_342_31 and arg_339_1.time_ < var_342_30 + var_342_31 + arg_342_0 then
				arg_339_1.typewritter.percent = 1

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(true)
			end
		end

		arg_339_1.nodeConfigList_ = {}

		arg_339_1:InitPlayNodeList()
	end,
	Play121561084 = function(arg_346_0, arg_346_1)
		arg_346_1.time_ = 0
		arg_346_1.frameCnt_ = 0
		arg_346_1.state_ = "playing"
		arg_346_1.curTalkId_ = 121561084
		arg_346_1.duration_ = 7

		SetActive(arg_346_1.tipsGo_, false)

		function arg_346_1.onSingleLineFinish_()
			arg_346_1.onSingleLineUpdate_ = nil
			arg_346_1.onSingleLineFinish_ = nil
			arg_346_1.state_ = "waiting"
		end

		function arg_346_1.playNext_(arg_348_0)
			if arg_348_0 == 1 then
				arg_346_0:Play121561085(arg_346_1)
			end
		end

		function arg_346_1.onSingleLineUpdate_(arg_349_0)
			local var_349_0 = 0
			local var_349_1 = 0.166666666666667

			if var_349_0 < arg_346_1.time_ and arg_346_1.time_ <= var_349_0 + arg_349_0 then
				local var_349_2 = "play"
				local var_349_3 = "music"

				arg_346_1:AudioAction(var_349_2, var_349_3, "ui_battle", "ui_battle_stopbgm", "")

				local var_349_4 = ""
				local var_349_5 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_349_5 ~= "" then
					if arg_346_1.bgmTxt_.text ~= var_349_5 and arg_346_1.bgmTxt_.text ~= "" then
						if arg_346_1.bgmTxt2_.text ~= "" then
							arg_346_1.bgmTxt_.text = arg_346_1.bgmTxt2_.text
						end

						arg_346_1.bgmTxt2_.text = var_349_5

						arg_346_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_346_1.bgmTxt_.text = var_349_5
						arg_346_1.bgmTxt2_.text = var_349_5
					end

					if arg_346_1.bgmTimer then
						arg_346_1.bgmTimer:Stop()

						arg_346_1.bgmTimer = nil
					end

					if arg_346_1.settingData.show_music_name == 1 then
						arg_346_1.musicController:SetSelectedState("show")
						arg_346_1.musicAnimator_:Play("open", 0, 0)

						if arg_346_1.settingData.music_time ~= 0 then
							arg_346_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_346_1.settingData.music_time), function()
								if arg_346_1 == nil or isNil(arg_346_1.bgmTxt_) then
									return
								end

								arg_346_1.musicController:SetSelectedState("hide")
								arg_346_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_349_6 = 0.766666666666667
			local var_349_7 = 0.333333333333333

			if var_349_6 < arg_346_1.time_ and arg_346_1.time_ <= var_349_6 + arg_349_0 then
				local var_349_8 = "stop"
				local var_349_9 = "effect"

				arg_346_1:AudioAction(var_349_8, var_349_9, "se_story_121_04", "se_story_121_04_dizzle", "")
			end

			local var_349_10 = "J10i_blur"

			if arg_346_1.bgs_[var_349_10] == nil then
				local var_349_11 = Object.Instantiate(arg_346_1.blurPaintGo_)
				local var_349_12 = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_349_10)

				var_349_11:GetComponent("SpriteRenderer").sprite = var_349_12
				var_349_11.name = var_349_10
				var_349_11.transform.parent = arg_346_1.stage_.transform
				var_349_11.transform.localPosition = Vector3.New(0, 100, 0)
				arg_346_1.bgs_[var_349_10] = var_349_11
			end

			local var_349_13 = 0
			local var_349_14 = arg_346_1.bgs_[var_349_10]

			if var_349_13 < arg_346_1.time_ and arg_346_1.time_ <= var_349_13 + arg_349_0 then
				local var_349_15 = manager.ui.mainCamera.transform.localPosition
				local var_349_16 = Vector3.New(0, 0, 10) + Vector3.New(var_349_15.x, var_349_15.y, 0)

				var_349_14.transform.localPosition = var_349_16
				var_349_14.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_349_17 = var_349_14:GetComponent("SpriteRenderer")

				if var_349_17 and var_349_17.sprite then
					local var_349_18 = (var_349_14.transform.localPosition - var_349_15).z
					local var_349_19 = manager.ui.mainCameraCom_
					local var_349_20 = 2 * var_349_18 * Mathf.Tan(var_349_19.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_349_21 = var_349_20 * var_349_19.aspect
					local var_349_22 = var_349_17.sprite.bounds.size.x
					local var_349_23 = var_349_17.sprite.bounds.size.y
					local var_349_24 = var_349_21 / var_349_22
					local var_349_25 = var_349_20 / var_349_23
					local var_349_26 = var_349_25 < var_349_24 and var_349_24 or var_349_25

					var_349_14.transform.localScale = Vector3.New(var_349_26, var_349_26, 0)
				end
			end

			local var_349_27 = 2

			if var_349_13 <= arg_346_1.time_ and arg_346_1.time_ < var_349_13 + var_349_27 then
				local var_349_28 = (arg_346_1.time_ - var_349_13) / var_349_27
				local var_349_29 = Color.New(1, 1, 1)

				var_349_29.a = Mathf.Lerp(0, 1, var_349_28)

				var_349_14:GetComponent("SpriteRenderer").material:SetColor("_Color", var_349_29)
			end

			if arg_346_1.frameCnt_ <= 1 then
				arg_346_1.dialog_:SetActive(false)
			end

			local var_349_30 = 2
			local var_349_31 = 1.2

			if var_349_30 < arg_346_1.time_ and arg_346_1.time_ <= var_349_30 + arg_349_0 then
				arg_346_1.talkMaxDuration = 0

				arg_346_1.dialog_:SetActive(true)

				arg_346_1.dialogCg_.alpha = 0

				local var_349_32 = LeanTween.value(arg_346_1.dialog_, 0, 1, 0.3)

				var_349_32:setOnUpdate(LuaHelper.FloatAction(function(arg_351_0)
					arg_346_1.dialogCg_.alpha = arg_351_0
				end))
				var_349_32:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_346_1.dialog_)
					var_349_32:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_346_1.duration_ = arg_346_1.duration_ + 0.3

				SetActive(arg_346_1.leftNameGo_, false)

				arg_346_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_346_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_346_1:RecordName(arg_346_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_346_1.iconTrs_.gameObject, false)
				arg_346_1.callingController_:SetSelectedState("normal")

				local var_349_33 = arg_346_1:GetWordFromCfg(121561084)
				local var_349_34 = arg_346_1:FormatText(var_349_33.content)

				arg_346_1.text_.text = var_349_34

				LuaForUtil.ClearLinePrefixSymbol(arg_346_1.text_)

				local var_349_35 = 48
				local var_349_36 = utf8.len(var_349_34)
				local var_349_37 = var_349_35 <= 0 and var_349_31 or var_349_31 * (var_349_36 / var_349_35)

				if var_349_37 > 0 and var_349_31 < var_349_37 then
					arg_346_1.talkMaxDuration = var_349_37
					var_349_30 = var_349_30 + 0.3

					if var_349_37 + var_349_30 > arg_346_1.duration_ then
						arg_346_1.duration_ = var_349_37 + var_349_30
					end
				end

				arg_346_1.text_.text = var_349_34
				arg_346_1.typewritter.percent = 0

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(false)
				arg_346_1:RecordContent(arg_346_1.text_.text)
			end

			local var_349_38 = var_349_30 + 0.3
			local var_349_39 = math.max(var_349_31, arg_346_1.talkMaxDuration)

			if var_349_38 <= arg_346_1.time_ and arg_346_1.time_ < var_349_38 + var_349_39 then
				arg_346_1.typewritter.percent = (arg_346_1.time_ - var_349_38) / var_349_39

				arg_346_1.typewritter:SetDirty()
			end

			if arg_346_1.time_ >= var_349_38 + var_349_39 and arg_346_1.time_ < var_349_38 + var_349_39 + arg_349_0 then
				arg_346_1.typewritter.percent = 1

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(true)
			end
		end

		arg_346_1.nodeConfigList_ = {}

		arg_346_1:InitPlayNodeList()
	end,
	Play121561085 = function(arg_353_0, arg_353_1)
		arg_353_1.time_ = 0
		arg_353_1.frameCnt_ = 0
		arg_353_1.state_ = "playing"
		arg_353_1.curTalkId_ = 121561085
		arg_353_1.duration_ = 7

		SetActive(arg_353_1.tipsGo_, false)

		function arg_353_1.onSingleLineFinish_()
			arg_353_1.onSingleLineUpdate_ = nil
			arg_353_1.onSingleLineFinish_ = nil
			arg_353_1.state_ = "waiting"
			arg_353_1.auto_ = false
		end

		function arg_353_1.playNext_(arg_355_0)
			arg_353_1.onStoryFinished_()
		end

		function arg_353_1.onSingleLineUpdate_(arg_356_0)
			local var_356_0 = "STblack"

			if arg_353_1.bgs_[var_356_0] == nil then
				local var_356_1 = Object.Instantiate(arg_353_1.paintGo_)

				var_356_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_356_0)
				var_356_1.name = var_356_0
				var_356_1.transform.parent = arg_353_1.stage_.transform
				var_356_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_353_1.bgs_[var_356_0] = var_356_1
			end

			local var_356_2 = 2

			if var_356_2 < arg_353_1.time_ and arg_353_1.time_ <= var_356_2 + arg_356_0 then
				local var_356_3 = manager.ui.mainCamera.transform.localPosition
				local var_356_4 = Vector3.New(0, 0, 10) + Vector3.New(var_356_3.x, var_356_3.y, 0)
				local var_356_5 = arg_353_1.bgs_.STblack

				var_356_5.transform.localPosition = var_356_4
				var_356_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_356_6 = var_356_5:GetComponent("SpriteRenderer")

				if var_356_6 and var_356_6.sprite then
					local var_356_7 = (var_356_5.transform.localPosition - var_356_3).z
					local var_356_8 = manager.ui.mainCameraCom_
					local var_356_9 = 2 * var_356_7 * Mathf.Tan(var_356_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_356_10 = var_356_9 * var_356_8.aspect
					local var_356_11 = var_356_6.sprite.bounds.size.x
					local var_356_12 = var_356_6.sprite.bounds.size.y
					local var_356_13 = var_356_10 / var_356_11
					local var_356_14 = var_356_9 / var_356_12
					local var_356_15 = var_356_14 < var_356_13 and var_356_13 or var_356_14

					var_356_5.transform.localScale = Vector3.New(var_356_15, var_356_15, 0)
				end

				for iter_356_0, iter_356_1 in pairs(arg_353_1.bgs_) do
					if iter_356_0 ~= "STblack" then
						iter_356_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_356_16 = 0

			if var_356_16 < arg_353_1.time_ and arg_353_1.time_ <= var_356_16 + arg_356_0 then
				arg_353_1.mask_.enabled = true
				arg_353_1.mask_.raycastTarget = true

				arg_353_1:SetGaussion(false)
			end

			local var_356_17 = 2

			if var_356_16 <= arg_353_1.time_ and arg_353_1.time_ < var_356_16 + var_356_17 then
				local var_356_18 = (arg_353_1.time_ - var_356_16) / var_356_17
				local var_356_19 = Color.New(0, 0, 0)

				var_356_19.a = Mathf.Lerp(0, 1, var_356_18)
				arg_353_1.mask_.color = var_356_19
			end

			if arg_353_1.time_ >= var_356_16 + var_356_17 and arg_353_1.time_ < var_356_16 + var_356_17 + arg_356_0 then
				local var_356_20 = Color.New(0, 0, 0)

				var_356_20.a = 1
				arg_353_1.mask_.color = var_356_20
			end

			local var_356_21 = 2

			if var_356_21 < arg_353_1.time_ and arg_353_1.time_ <= var_356_21 + arg_356_0 then
				arg_353_1.mask_.enabled = true
				arg_353_1.mask_.raycastTarget = true

				arg_353_1:SetGaussion(false)
			end

			local var_356_22 = 0.5

			if var_356_21 <= arg_353_1.time_ and arg_353_1.time_ < var_356_21 + var_356_22 then
				local var_356_23 = (arg_353_1.time_ - var_356_21) / var_356_22
				local var_356_24 = Color.New(0, 0, 0)

				var_356_24.a = Mathf.Lerp(1, 0, var_356_23)
				arg_353_1.mask_.color = var_356_24
			end

			if arg_353_1.time_ >= var_356_21 + var_356_22 and arg_353_1.time_ < var_356_21 + var_356_22 + arg_356_0 then
				local var_356_25 = Color.New(0, 0, 0)
				local var_356_26 = 0

				arg_353_1.mask_.enabled = false
				var_356_25.a = var_356_26
				arg_353_1.mask_.color = var_356_25
			end

			if arg_353_1.frameCnt_ <= 1 then
				arg_353_1.dialog_:SetActive(false)
			end

			local var_356_27 = 2
			local var_356_28 = 0.925

			if var_356_27 < arg_353_1.time_ and arg_353_1.time_ <= var_356_27 + arg_356_0 then
				arg_353_1.talkMaxDuration = 0

				arg_353_1.dialog_:SetActive(true)

				arg_353_1.dialogCg_.alpha = 0

				local var_356_29 = LeanTween.value(arg_353_1.dialog_, 0, 1, 0.3)

				var_356_29:setOnUpdate(LuaHelper.FloatAction(function(arg_357_0)
					arg_353_1.dialogCg_.alpha = arg_357_0
				end))
				var_356_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_353_1.dialog_)
					var_356_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_353_1.duration_ = arg_353_1.duration_ + 0.3

				SetActive(arg_353_1.leftNameGo_, false)

				arg_353_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_353_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_353_1:RecordName(arg_353_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_353_1.iconTrs_.gameObject, false)
				arg_353_1.callingController_:SetSelectedState("normal")

				local var_356_30 = arg_353_1:GetWordFromCfg(121561085)
				local var_356_31 = arg_353_1:FormatText(var_356_30.content)

				arg_353_1.text_.text = var_356_31

				LuaForUtil.ClearLinePrefixSymbol(arg_353_1.text_)

				local var_356_32 = 37
				local var_356_33 = utf8.len(var_356_31)
				local var_356_34 = var_356_32 <= 0 and var_356_28 or var_356_28 * (var_356_33 / var_356_32)

				if var_356_34 > 0 and var_356_28 < var_356_34 then
					arg_353_1.talkMaxDuration = var_356_34
					var_356_27 = var_356_27 + 0.3

					if var_356_34 + var_356_27 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_34 + var_356_27
					end
				end

				arg_353_1.text_.text = var_356_31
				arg_353_1.typewritter.percent = 0

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(false)
				arg_353_1:RecordContent(arg_353_1.text_.text)
			end

			local var_356_35 = var_356_27 + 0.3
			local var_356_36 = math.max(var_356_28, arg_353_1.talkMaxDuration)

			if var_356_35 <= arg_353_1.time_ and arg_353_1.time_ < var_356_35 + var_356_36 then
				arg_353_1.typewritter.percent = (arg_353_1.time_ - var_356_35) / var_356_36

				arg_353_1.typewritter:SetDirty()
			end

			if arg_353_1.time_ >= var_356_35 + var_356_36 and arg_353_1.time_ < var_356_35 + var_356_36 + arg_356_0 then
				arg_353_1.typewritter.percent = 1

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(true)
			end
		end

		arg_353_1.nodeConfigList_ = {}

		arg_353_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/XH0310",
		"TextureConfig/Background/J12g",
		"TextureConfig/Background/J10i",
		"TextureConfig/Background/STblack"
	},
	voices = {
		"story_v_out_121561.awb"
	}
}
