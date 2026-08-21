return {
	Play120051001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 120051001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play120051002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "J02g"

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
				local var_4_5 = arg_1_1.bgs_.J02g

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
					if iter_4_0 ~= "J02g" then
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

			local var_4_22 = 0.266666666666668
			local var_4_23 = 1

			if var_4_22 < arg_1_1.time_ and arg_1_1.time_ <= var_4_22 + arg_4_0 then
				local var_4_24 = "play"
				local var_4_25 = "effect"

				arg_1_1:AudioAction(var_4_24, var_4_25, "se_story_side_1066", "se_story_1066_ui", "")
			end

			local var_4_26 = 0
			local var_4_27 = 0.266666666666668

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

			local var_4_32 = 0.433333333333333
			local var_4_33 = 1.11666666666667

			if var_4_32 < arg_1_1.time_ and arg_1_1.time_ <= var_4_32 + arg_4_0 then
				local var_4_34 = "play"
				local var_4_35 = "music"

				arg_1_1:AudioAction(var_4_34, var_4_35, "bgm_activity_2_0_story_oldtown", "bgm_activity_2_0_story_oldtown", "bgm_activity_2_0_story_oldtown.awb")

				local var_4_36 = ""
				local var_4_37 = manager.audio:GetAudioName("bgm_activity_2_0_story_oldtown", "bgm_activity_2_0_story_oldtown")

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
			local var_4_39 = 0.55

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

				local var_4_41 = arg_1_1:GetWordFromCfg(120051001)
				local var_4_42 = arg_1_1:FormatText(var_4_41.content)

				arg_1_1.text_.text = var_4_42

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_43 = 22
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
	Play120051002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 120051002
		arg_9_1.duration_ = 3.23

		local var_9_0 = {
			zh = 2.133,
			ja = 3.233
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
				arg_9_0:Play120051003(arg_9_1)
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

				local var_12_2 = arg_9_1:FormatText(StoryNameCfg[10].name)

				arg_9_1.leftNameTxt_.text = var_12_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, true)
				arg_9_1.iconController_:SetSelectedState("hero")

				arg_9_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_9_1.callingController_:SetSelectedState("normal")

				arg_9_1.keyicon_.color = Color.New(1, 1, 1)
				arg_9_1.icon_.color = Color.New(1, 1, 1)

				local var_12_3 = arg_9_1:GetWordFromCfg(120051002)
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

				if manager.audio:GetVoiceLength("story_v_out_120051", "120051002", "story_v_out_120051.awb") ~= 0 then
					local var_12_8 = manager.audio:GetVoiceLength("story_v_out_120051", "120051002", "story_v_out_120051.awb") / 1000

					if var_12_8 + var_12_0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_8 + var_12_0
					end

					if var_12_3.prefab_name ~= "" and arg_9_1.actors_[var_12_3.prefab_name] ~= nil then
						local var_12_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_3.prefab_name].transform, "story_v_out_120051", "120051002", "story_v_out_120051.awb")

						arg_9_1:RecordAudio("120051002", var_12_9)
						arg_9_1:RecordAudio("120051002", var_12_9)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_120051", "120051002", "story_v_out_120051.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_120051", "120051002", "story_v_out_120051.awb")
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
	Play120051003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 120051003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play120051004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0
			local var_16_1 = 0.225

			if var_16_0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_2 = arg_13_1:FormatText(StoryNameCfg[7].name)

				arg_13_1.leftNameTxt_.text = var_16_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, true)
				arg_13_1.iconController_:SetSelectedState("hero")

				arg_13_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_13_1.callingController_:SetSelectedState("normal")

				arg_13_1.keyicon_.color = Color.New(1, 1, 1)
				arg_13_1.icon_.color = Color.New(1, 1, 1)

				local var_16_3 = arg_13_1:GetWordFromCfg(120051003)
				local var_16_4 = arg_13_1:FormatText(var_16_3.content)

				arg_13_1.text_.text = var_16_4

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_5 = 9
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
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_8 = math.max(var_16_1, arg_13_1.talkMaxDuration)

			if var_16_0 <= arg_13_1.time_ and arg_13_1.time_ < var_16_0 + var_16_8 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_0) / var_16_8

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_0 + var_16_8 and arg_13_1.time_ < var_16_0 + var_16_8 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play120051004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 120051004
		arg_17_1.duration_ = 4.3

		local var_17_0 = {
			zh = 3.3,
			ja = 4.3
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
				arg_17_0:Play120051005(arg_17_1)
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

				local var_20_2 = arg_17_1:FormatText(StoryNameCfg[10].name)

				arg_17_1.leftNameTxt_.text = var_20_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, true)
				arg_17_1.iconController_:SetSelectedState("hero")

				arg_17_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_17_1.callingController_:SetSelectedState("normal")

				arg_17_1.keyicon_.color = Color.New(1, 1, 1)
				arg_17_1.icon_.color = Color.New(1, 1, 1)

				local var_20_3 = arg_17_1:GetWordFromCfg(120051004)
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

				if manager.audio:GetVoiceLength("story_v_out_120051", "120051004", "story_v_out_120051.awb") ~= 0 then
					local var_20_8 = manager.audio:GetVoiceLength("story_v_out_120051", "120051004", "story_v_out_120051.awb") / 1000

					if var_20_8 + var_20_0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_8 + var_20_0
					end

					if var_20_3.prefab_name ~= "" and arg_17_1.actors_[var_20_3.prefab_name] ~= nil then
						local var_20_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_3.prefab_name].transform, "story_v_out_120051", "120051004", "story_v_out_120051.awb")

						arg_17_1:RecordAudio("120051004", var_20_9)
						arg_17_1:RecordAudio("120051004", var_20_9)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_120051", "120051004", "story_v_out_120051.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_120051", "120051004", "story_v_out_120051.awb")
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
	Play120051005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 120051005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play120051006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 0
			local var_24_1 = 1

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

				local var_24_2 = arg_21_1:GetWordFromCfg(120051005)
				local var_24_3 = arg_21_1:FormatText(var_24_2.content)

				arg_21_1.text_.text = var_24_3

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_4 = 40
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
	Play120051006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 120051006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play120051007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 0
			local var_28_1 = 0.275

			if var_28_0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_0 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_2 = arg_25_1:FormatText(StoryNameCfg[7].name)

				arg_25_1.leftNameTxt_.text = var_28_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, true)
				arg_25_1.iconController_:SetSelectedState("hero")

				arg_25_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_25_1.callingController_:SetSelectedState("normal")

				arg_25_1.keyicon_.color = Color.New(1, 1, 1)
				arg_25_1.icon_.color = Color.New(1, 1, 1)

				local var_28_3 = arg_25_1:GetWordFromCfg(120051006)
				local var_28_4 = arg_25_1:FormatText(var_28_3.content)

				arg_25_1.text_.text = var_28_4

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_5 = 11
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
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_8 = math.max(var_28_1, arg_25_1.talkMaxDuration)

			if var_28_0 <= arg_25_1.time_ and arg_25_1.time_ < var_28_0 + var_28_8 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_0) / var_28_8

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_0 + var_28_8 and arg_25_1.time_ < var_28_0 + var_28_8 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play120051007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 120051007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play120051008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = "1071ui_story"

			if arg_29_1.actors_[var_32_0] == nil then
				local var_32_1 = Asset.Load("Char/" .. "1071ui_story")

				if not isNil(var_32_1) then
					local var_32_2 = Object.Instantiate(Asset.Load("Char/" .. "1071ui_story"), arg_29_1.stage_.transform)

					var_32_2.name = var_32_0
					var_32_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_29_1.actors_[var_32_0] = var_32_2

					local var_32_3 = var_32_2:GetComponentInChildren(typeof(CharacterEffect))

					var_32_3.enabled = true

					local var_32_4 = GameObjectTools.GetOrAddComponent(var_32_2, typeof(DynamicBoneHelper))

					if var_32_4 then
						var_32_4:EnableDynamicBone(false)
					end

					arg_29_1:ShowWeapon(var_32_3.transform, false)

					arg_29_1.var_[var_32_0 .. "Animator"] = var_32_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_29_1.var_[var_32_0 .. "Animator"].applyRootMotion = true
					arg_29_1.var_[var_32_0 .. "LipSync"] = var_32_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_32_5 = 0

			if var_32_5 < arg_29_1.time_ and arg_29_1.time_ <= var_32_5 + arg_32_0 then
				arg_29_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_32_6 = 0
			local var_32_7 = 1.025

			if var_32_6 < arg_29_1.time_ and arg_29_1.time_ <= var_32_6 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, false)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_8 = arg_29_1:GetWordFromCfg(120051007)
				local var_32_9 = arg_29_1:FormatText(var_32_8.content)

				arg_29_1.text_.text = var_32_9

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_10 = 41
				local var_32_11 = utf8.len(var_32_9)
				local var_32_12 = var_32_10 <= 0 and var_32_7 or var_32_7 * (var_32_11 / var_32_10)

				if var_32_12 > 0 and var_32_7 < var_32_12 then
					arg_29_1.talkMaxDuration = var_32_12

					if var_32_12 + var_32_6 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_12 + var_32_6
					end
				end

				arg_29_1.text_.text = var_32_9
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)
				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_13 = math.max(var_32_7, arg_29_1.talkMaxDuration)

			if var_32_6 <= arg_29_1.time_ and arg_29_1.time_ < var_32_6 + var_32_13 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_6) / var_32_13

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_6 + var_32_13 and arg_29_1.time_ < var_32_6 + var_32_13 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play120051008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 120051008
		arg_33_1.duration_ = 3.97

		local var_33_0 = {
			zh = 3.4,
			ja = 3.966
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
				arg_33_0:Play120051009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = arg_33_1.actors_["1071ui_story"].transform
			local var_36_1 = 0

			if var_36_1 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 then
				arg_33_1.var_.moveOldPos1071ui_story = var_36_0.localPosition
			end

			local var_36_2 = 0.001

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_2 then
				local var_36_3 = (arg_33_1.time_ - var_36_1) / var_36_2
				local var_36_4 = Vector3.New(-0.7, -1.05, -6.2)

				var_36_0.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos1071ui_story, var_36_4, var_36_3)

				local var_36_5 = manager.ui.mainCamera.transform.position - var_36_0.position

				var_36_0.forward = Vector3.New(var_36_5.x, var_36_5.y, var_36_5.z)

				local var_36_6 = var_36_0.localEulerAngles

				var_36_6.z = 0
				var_36_6.x = 0
				var_36_0.localEulerAngles = var_36_6
			end

			if arg_33_1.time_ >= var_36_1 + var_36_2 and arg_33_1.time_ < var_36_1 + var_36_2 + arg_36_0 then
				var_36_0.localPosition = Vector3.New(-0.7, -1.05, -6.2)

				local var_36_7 = manager.ui.mainCamera.transform.position - var_36_0.position

				var_36_0.forward = Vector3.New(var_36_7.x, var_36_7.y, var_36_7.z)

				local var_36_8 = var_36_0.localEulerAngles

				var_36_8.z = 0
				var_36_8.x = 0
				var_36_0.localEulerAngles = var_36_8
			end

			local var_36_9 = arg_33_1.actors_["1071ui_story"]
			local var_36_10 = 0

			if var_36_10 < arg_33_1.time_ and arg_33_1.time_ <= var_36_10 + arg_36_0 and not isNil(var_36_9) and arg_33_1.var_.characterEffect1071ui_story == nil then
				arg_33_1.var_.characterEffect1071ui_story = var_36_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_11 = 0.2

			if var_36_10 <= arg_33_1.time_ and arg_33_1.time_ < var_36_10 + var_36_11 and not isNil(var_36_9) then
				local var_36_12 = (arg_33_1.time_ - var_36_10) / var_36_11

				if arg_33_1.var_.characterEffect1071ui_story and not isNil(var_36_9) then
					arg_33_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_33_1.time_ >= var_36_10 + var_36_11 and arg_33_1.time_ < var_36_10 + var_36_11 + arg_36_0 and not isNil(var_36_9) and arg_33_1.var_.characterEffect1071ui_story then
				arg_33_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_36_13 = "1075ui_story"

			if arg_33_1.actors_[var_36_13] == nil then
				local var_36_14 = Asset.Load("Char/" .. "1075ui_story")

				if not isNil(var_36_14) then
					local var_36_15 = Object.Instantiate(Asset.Load("Char/" .. "1075ui_story"), arg_33_1.stage_.transform)

					var_36_15.name = var_36_13
					var_36_15.transform.localPosition = Vector3.New(0, 100, 0)
					arg_33_1.actors_[var_36_13] = var_36_15

					local var_36_16 = var_36_15:GetComponentInChildren(typeof(CharacterEffect))

					var_36_16.enabled = true

					local var_36_17 = GameObjectTools.GetOrAddComponent(var_36_15, typeof(DynamicBoneHelper))

					if var_36_17 then
						var_36_17:EnableDynamicBone(false)
					end

					arg_33_1:ShowWeapon(var_36_16.transform, false)

					arg_33_1.var_[var_36_13 .. "Animator"] = var_36_16.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_33_1.var_[var_36_13 .. "Animator"].applyRootMotion = true
					arg_33_1.var_[var_36_13 .. "LipSync"] = var_36_16.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_36_18 = arg_33_1.actors_["1075ui_story"].transform
			local var_36_19 = 0

			if var_36_19 < arg_33_1.time_ and arg_33_1.time_ <= var_36_19 + arg_36_0 then
				arg_33_1.var_.moveOldPos1075ui_story = var_36_18.localPosition
			end

			local var_36_20 = 0.001

			if var_36_19 <= arg_33_1.time_ and arg_33_1.time_ < var_36_19 + var_36_20 then
				local var_36_21 = (arg_33_1.time_ - var_36_19) / var_36_20
				local var_36_22 = Vector3.New(0.7, -1.055, -6.16)

				var_36_18.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos1075ui_story, var_36_22, var_36_21)

				local var_36_23 = manager.ui.mainCamera.transform.position - var_36_18.position

				var_36_18.forward = Vector3.New(var_36_23.x, var_36_23.y, var_36_23.z)

				local var_36_24 = var_36_18.localEulerAngles

				var_36_24.z = 0
				var_36_24.x = 0
				var_36_18.localEulerAngles = var_36_24
			end

			if arg_33_1.time_ >= var_36_19 + var_36_20 and arg_33_1.time_ < var_36_19 + var_36_20 + arg_36_0 then
				var_36_18.localPosition = Vector3.New(0.7, -1.055, -6.16)

				local var_36_25 = manager.ui.mainCamera.transform.position - var_36_18.position

				var_36_18.forward = Vector3.New(var_36_25.x, var_36_25.y, var_36_25.z)

				local var_36_26 = var_36_18.localEulerAngles

				var_36_26.z = 0
				var_36_26.x = 0
				var_36_18.localEulerAngles = var_36_26
			end

			local var_36_27 = arg_33_1.actors_["1075ui_story"]
			local var_36_28 = 0

			if var_36_28 < arg_33_1.time_ and arg_33_1.time_ <= var_36_28 + arg_36_0 and not isNil(var_36_27) and arg_33_1.var_.characterEffect1075ui_story == nil then
				arg_33_1.var_.characterEffect1075ui_story = var_36_27:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_29 = 0.034

			if var_36_28 <= arg_33_1.time_ and arg_33_1.time_ < var_36_28 + var_36_29 and not isNil(var_36_27) then
				local var_36_30 = (arg_33_1.time_ - var_36_28) / var_36_29

				if arg_33_1.var_.characterEffect1075ui_story and not isNil(var_36_27) then
					local var_36_31 = Mathf.Lerp(0, 0.5, var_36_30)

					arg_33_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_33_1.var_.characterEffect1075ui_story.fillRatio = var_36_31
				end
			end

			if arg_33_1.time_ >= var_36_28 + var_36_29 and arg_33_1.time_ < var_36_28 + var_36_29 + arg_36_0 and not isNil(var_36_27) and arg_33_1.var_.characterEffect1075ui_story then
				local var_36_32 = 0.5

				arg_33_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_33_1.var_.characterEffect1075ui_story.fillRatio = var_36_32
			end

			local var_36_33 = 0

			if var_36_33 < arg_33_1.time_ and arg_33_1.time_ <= var_36_33 + arg_36_0 then
				arg_33_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action2_1")
			end

			local var_36_34 = 0

			if var_36_34 < arg_33_1.time_ and arg_33_1.time_ <= var_36_34 + arg_36_0 then
				arg_33_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action1_1")
			end

			local var_36_35 = 0
			local var_36_36 = 0.4

			if var_36_35 < arg_33_1.time_ and arg_33_1.time_ <= var_36_35 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_37 = arg_33_1:FormatText(StoryNameCfg[384].name)

				arg_33_1.leftNameTxt_.text = var_36_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_38 = arg_33_1:GetWordFromCfg(120051008)
				local var_36_39 = arg_33_1:FormatText(var_36_38.content)

				arg_33_1.text_.text = var_36_39

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_40 = 16
				local var_36_41 = utf8.len(var_36_39)
				local var_36_42 = var_36_40 <= 0 and var_36_36 or var_36_36 * (var_36_41 / var_36_40)

				if var_36_42 > 0 and var_36_36 < var_36_42 then
					arg_33_1.talkMaxDuration = var_36_42

					if var_36_42 + var_36_35 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_42 + var_36_35
					end
				end

				arg_33_1.text_.text = var_36_39
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120051", "120051008", "story_v_out_120051.awb") ~= 0 then
					local var_36_43 = manager.audio:GetVoiceLength("story_v_out_120051", "120051008", "story_v_out_120051.awb") / 1000

					if var_36_43 + var_36_35 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_43 + var_36_35
					end

					if var_36_38.prefab_name ~= "" and arg_33_1.actors_[var_36_38.prefab_name] ~= nil then
						local var_36_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_38.prefab_name].transform, "story_v_out_120051", "120051008", "story_v_out_120051.awb")

						arg_33_1:RecordAudio("120051008", var_36_44)
						arg_33_1:RecordAudio("120051008", var_36_44)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_120051", "120051008", "story_v_out_120051.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_120051", "120051008", "story_v_out_120051.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_45 = math.max(var_36_36, arg_33_1.talkMaxDuration)

			if var_36_35 <= arg_33_1.time_ and arg_33_1.time_ < var_36_35 + var_36_45 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_35) / var_36_45

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_35 + var_36_45 and arg_33_1.time_ < var_36_35 + var_36_45 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {
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
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_33_1:InitPlayNodeList()
	end,
	Play120051009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 120051009
		arg_37_1.duration_ = 4.17

		local var_37_0 = {
			zh = 4.166,
			ja = 2.7
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
				arg_37_0:Play120051010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = arg_37_1.actors_["1071ui_story"]
			local var_40_1 = 0

			if var_40_1 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.characterEffect1071ui_story == nil then
				arg_37_1.var_.characterEffect1071ui_story = var_40_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_2 = 0.2

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_2 and not isNil(var_40_0) then
				local var_40_3 = (arg_37_1.time_ - var_40_1) / var_40_2

				if arg_37_1.var_.characterEffect1071ui_story and not isNil(var_40_0) then
					local var_40_4 = Mathf.Lerp(0, 0.5, var_40_3)

					arg_37_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_37_1.var_.characterEffect1071ui_story.fillRatio = var_40_4
				end
			end

			if arg_37_1.time_ >= var_40_1 + var_40_2 and arg_37_1.time_ < var_40_1 + var_40_2 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.characterEffect1071ui_story then
				local var_40_5 = 0.5

				arg_37_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_37_1.var_.characterEffect1071ui_story.fillRatio = var_40_5
			end

			local var_40_6 = arg_37_1.actors_["1075ui_story"]
			local var_40_7 = 0

			if var_40_7 < arg_37_1.time_ and arg_37_1.time_ <= var_40_7 + arg_40_0 and not isNil(var_40_6) and arg_37_1.var_.characterEffect1075ui_story == nil then
				arg_37_1.var_.characterEffect1075ui_story = var_40_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_8 = 0.2

			if var_40_7 <= arg_37_1.time_ and arg_37_1.time_ < var_40_7 + var_40_8 and not isNil(var_40_6) then
				local var_40_9 = (arg_37_1.time_ - var_40_7) / var_40_8

				if arg_37_1.var_.characterEffect1075ui_story and not isNil(var_40_6) then
					arg_37_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_37_1.time_ >= var_40_7 + var_40_8 and arg_37_1.time_ < var_40_7 + var_40_8 + arg_40_0 and not isNil(var_40_6) and arg_37_1.var_.characterEffect1075ui_story then
				arg_37_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_40_10 = 0

			if var_40_10 < arg_37_1.time_ and arg_37_1.time_ <= var_40_10 + arg_40_0 then
				arg_37_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action5_1")
			end

			local var_40_11 = 0

			if var_40_11 < arg_37_1.time_ and arg_37_1.time_ <= var_40_11 + arg_40_0 then
				arg_37_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_40_12 = 0
			local var_40_13 = 0.4

			if var_40_12 < arg_37_1.time_ and arg_37_1.time_ <= var_40_12 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_14 = arg_37_1:FormatText(StoryNameCfg[381].name)

				arg_37_1.leftNameTxt_.text = var_40_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_15 = arg_37_1:GetWordFromCfg(120051009)
				local var_40_16 = arg_37_1:FormatText(var_40_15.content)

				arg_37_1.text_.text = var_40_16

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_17 = 16
				local var_40_18 = utf8.len(var_40_16)
				local var_40_19 = var_40_17 <= 0 and var_40_13 or var_40_13 * (var_40_18 / var_40_17)

				if var_40_19 > 0 and var_40_13 < var_40_19 then
					arg_37_1.talkMaxDuration = var_40_19

					if var_40_19 + var_40_12 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_19 + var_40_12
					end
				end

				arg_37_1.text_.text = var_40_16
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120051", "120051009", "story_v_out_120051.awb") ~= 0 then
					local var_40_20 = manager.audio:GetVoiceLength("story_v_out_120051", "120051009", "story_v_out_120051.awb") / 1000

					if var_40_20 + var_40_12 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_20 + var_40_12
					end

					if var_40_15.prefab_name ~= "" and arg_37_1.actors_[var_40_15.prefab_name] ~= nil then
						local var_40_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_15.prefab_name].transform, "story_v_out_120051", "120051009", "story_v_out_120051.awb")

						arg_37_1:RecordAudio("120051009", var_40_21)
						arg_37_1:RecordAudio("120051009", var_40_21)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_120051", "120051009", "story_v_out_120051.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_120051", "120051009", "story_v_out_120051.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_22 = math.max(var_40_13, arg_37_1.talkMaxDuration)

			if var_40_12 <= arg_37_1.time_ and arg_37_1.time_ < var_40_12 + var_40_22 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_12) / var_40_22

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_12 + var_40_22 and arg_37_1.time_ < var_40_12 + var_40_22 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play120051010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 120051010
		arg_41_1.duration_ = 9.07

		local var_41_0 = {
			zh = 6.933,
			ja = 9.066
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
				arg_41_0:Play120051011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = arg_41_1.actors_["1071ui_story"]
			local var_44_1 = 0

			if var_44_1 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.characterEffect1071ui_story == nil then
				arg_41_1.var_.characterEffect1071ui_story = var_44_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_2 = 0.2

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_2 and not isNil(var_44_0) then
				local var_44_3 = (arg_41_1.time_ - var_44_1) / var_44_2

				if arg_41_1.var_.characterEffect1071ui_story and not isNil(var_44_0) then
					arg_41_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_41_1.time_ >= var_44_1 + var_44_2 and arg_41_1.time_ < var_44_1 + var_44_2 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.characterEffect1071ui_story then
				arg_41_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_44_4 = arg_41_1.actors_["1075ui_story"]
			local var_44_5 = 0

			if var_44_5 < arg_41_1.time_ and arg_41_1.time_ <= var_44_5 + arg_44_0 and not isNil(var_44_4) and arg_41_1.var_.characterEffect1075ui_story == nil then
				arg_41_1.var_.characterEffect1075ui_story = var_44_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_6 = 0.2

			if var_44_5 <= arg_41_1.time_ and arg_41_1.time_ < var_44_5 + var_44_6 and not isNil(var_44_4) then
				local var_44_7 = (arg_41_1.time_ - var_44_5) / var_44_6

				if arg_41_1.var_.characterEffect1075ui_story and not isNil(var_44_4) then
					local var_44_8 = Mathf.Lerp(0, 0.5, var_44_7)

					arg_41_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_41_1.var_.characterEffect1075ui_story.fillRatio = var_44_8
				end
			end

			if arg_41_1.time_ >= var_44_5 + var_44_6 and arg_41_1.time_ < var_44_5 + var_44_6 + arg_44_0 and not isNil(var_44_4) and arg_41_1.var_.characterEffect1075ui_story then
				local var_44_9 = 0.5

				arg_41_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_41_1.var_.characterEffect1075ui_story.fillRatio = var_44_9
			end

			local var_44_10 = 0
			local var_44_11 = 0.775

			if var_44_10 < arg_41_1.time_ and arg_41_1.time_ <= var_44_10 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_12 = arg_41_1:FormatText(StoryNameCfg[384].name)

				arg_41_1.leftNameTxt_.text = var_44_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_13 = arg_41_1:GetWordFromCfg(120051010)
				local var_44_14 = arg_41_1:FormatText(var_44_13.content)

				arg_41_1.text_.text = var_44_14

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_15 = 31
				local var_44_16 = utf8.len(var_44_14)
				local var_44_17 = var_44_15 <= 0 and var_44_11 or var_44_11 * (var_44_16 / var_44_15)

				if var_44_17 > 0 and var_44_11 < var_44_17 then
					arg_41_1.talkMaxDuration = var_44_17

					if var_44_17 + var_44_10 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_17 + var_44_10
					end
				end

				arg_41_1.text_.text = var_44_14
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120051", "120051010", "story_v_out_120051.awb") ~= 0 then
					local var_44_18 = manager.audio:GetVoiceLength("story_v_out_120051", "120051010", "story_v_out_120051.awb") / 1000

					if var_44_18 + var_44_10 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_18 + var_44_10
					end

					if var_44_13.prefab_name ~= "" and arg_41_1.actors_[var_44_13.prefab_name] ~= nil then
						local var_44_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_13.prefab_name].transform, "story_v_out_120051", "120051010", "story_v_out_120051.awb")

						arg_41_1:RecordAudio("120051010", var_44_19)
						arg_41_1:RecordAudio("120051010", var_44_19)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_120051", "120051010", "story_v_out_120051.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_120051", "120051010", "story_v_out_120051.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_20 = math.max(var_44_11, arg_41_1.talkMaxDuration)

			if var_44_10 <= arg_41_1.time_ and arg_41_1.time_ < var_44_10 + var_44_20 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_10) / var_44_20

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_10 + var_44_20 and arg_41_1.time_ < var_44_10 + var_44_20 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play120051011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 120051011
		arg_45_1.duration_ = 11.2

		local var_45_0 = {
			zh = 6.966,
			ja = 11.2
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
				arg_45_0:Play120051012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = 0
			local var_48_1 = 0.85

			if var_48_0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_0 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_2 = arg_45_1:FormatText(StoryNameCfg[384].name)

				arg_45_1.leftNameTxt_.text = var_48_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_3 = arg_45_1:GetWordFromCfg(120051011)
				local var_48_4 = arg_45_1:FormatText(var_48_3.content)

				arg_45_1.text_.text = var_48_4

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_5 = 34
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

				if manager.audio:GetVoiceLength("story_v_out_120051", "120051011", "story_v_out_120051.awb") ~= 0 then
					local var_48_8 = manager.audio:GetVoiceLength("story_v_out_120051", "120051011", "story_v_out_120051.awb") / 1000

					if var_48_8 + var_48_0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_8 + var_48_0
					end

					if var_48_3.prefab_name ~= "" and arg_45_1.actors_[var_48_3.prefab_name] ~= nil then
						local var_48_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_3.prefab_name].transform, "story_v_out_120051", "120051011", "story_v_out_120051.awb")

						arg_45_1:RecordAudio("120051011", var_48_9)
						arg_45_1:RecordAudio("120051011", var_48_9)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_120051", "120051011", "story_v_out_120051.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_120051", "120051011", "story_v_out_120051.awb")
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
	Play120051012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 120051012
		arg_49_1.duration_ = 7.57

		local var_49_0 = {
			zh = 3.5,
			ja = 7.566
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
				arg_49_0:Play120051013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = arg_49_1.actors_["1071ui_story"]
			local var_52_1 = 0

			if var_52_1 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.characterEffect1071ui_story == nil then
				arg_49_1.var_.characterEffect1071ui_story = var_52_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_2 = 0.2

			if var_52_1 <= arg_49_1.time_ and arg_49_1.time_ < var_52_1 + var_52_2 and not isNil(var_52_0) then
				local var_52_3 = (arg_49_1.time_ - var_52_1) / var_52_2

				if arg_49_1.var_.characterEffect1071ui_story and not isNil(var_52_0) then
					local var_52_4 = Mathf.Lerp(0, 0.5, var_52_3)

					arg_49_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_49_1.var_.characterEffect1071ui_story.fillRatio = var_52_4
				end
			end

			if arg_49_1.time_ >= var_52_1 + var_52_2 and arg_49_1.time_ < var_52_1 + var_52_2 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.characterEffect1071ui_story then
				local var_52_5 = 0.5

				arg_49_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_49_1.var_.characterEffect1071ui_story.fillRatio = var_52_5
			end

			local var_52_6 = 0
			local var_52_7 = 0.45

			if var_52_6 < arg_49_1.time_ and arg_49_1.time_ <= var_52_6 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_8 = arg_49_1:FormatText(StoryNameCfg[378].name)

				arg_49_1.leftNameTxt_.text = var_52_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, true)
				arg_49_1.iconController_:SetSelectedState("hero")

				arg_49_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1069")

				arg_49_1.callingController_:SetSelectedState("normal")

				arg_49_1.keyicon_.color = Color.New(1, 1, 1)
				arg_49_1.icon_.color = Color.New(1, 1, 1)

				local var_52_9 = arg_49_1:GetWordFromCfg(120051012)
				local var_52_10 = arg_49_1:FormatText(var_52_9.content)

				arg_49_1.text_.text = var_52_10

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_11 = 18
				local var_52_12 = utf8.len(var_52_10)
				local var_52_13 = var_52_11 <= 0 and var_52_7 or var_52_7 * (var_52_12 / var_52_11)

				if var_52_13 > 0 and var_52_7 < var_52_13 then
					arg_49_1.talkMaxDuration = var_52_13

					if var_52_13 + var_52_6 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_13 + var_52_6
					end
				end

				arg_49_1.text_.text = var_52_10
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120051", "120051012", "story_v_out_120051.awb") ~= 0 then
					local var_52_14 = manager.audio:GetVoiceLength("story_v_out_120051", "120051012", "story_v_out_120051.awb") / 1000

					if var_52_14 + var_52_6 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_14 + var_52_6
					end

					if var_52_9.prefab_name ~= "" and arg_49_1.actors_[var_52_9.prefab_name] ~= nil then
						local var_52_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_9.prefab_name].transform, "story_v_out_120051", "120051012", "story_v_out_120051.awb")

						arg_49_1:RecordAudio("120051012", var_52_15)
						arg_49_1:RecordAudio("120051012", var_52_15)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_120051", "120051012", "story_v_out_120051.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_120051", "120051012", "story_v_out_120051.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_16 = math.max(var_52_7, arg_49_1.talkMaxDuration)

			if var_52_6 <= arg_49_1.time_ and arg_49_1.time_ < var_52_6 + var_52_16 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_6) / var_52_16

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_6 + var_52_16 and arg_49_1.time_ < var_52_6 + var_52_16 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play120051013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 120051013
		arg_53_1.duration_ = 11.6

		local var_53_0 = {
			zh = 6.633,
			ja = 11.6
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
				arg_53_0:Play120051014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = arg_53_1.actors_["1071ui_story"]
			local var_56_1 = 0

			if var_56_1 < arg_53_1.time_ and arg_53_1.time_ <= var_56_1 + arg_56_0 and not isNil(var_56_0) and arg_53_1.var_.characterEffect1071ui_story == nil then
				arg_53_1.var_.characterEffect1071ui_story = var_56_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_2 = 0.2

			if var_56_1 <= arg_53_1.time_ and arg_53_1.time_ < var_56_1 + var_56_2 and not isNil(var_56_0) then
				local var_56_3 = (arg_53_1.time_ - var_56_1) / var_56_2

				if arg_53_1.var_.characterEffect1071ui_story and not isNil(var_56_0) then
					arg_53_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_53_1.time_ >= var_56_1 + var_56_2 and arg_53_1.time_ < var_56_1 + var_56_2 + arg_56_0 and not isNil(var_56_0) and arg_53_1.var_.characterEffect1071ui_story then
				arg_53_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_56_4 = 0

			if var_56_4 < arg_53_1.time_ and arg_53_1.time_ <= var_56_4 + arg_56_0 then
				arg_53_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071actionlink/1071action423")
			end

			local var_56_5 = 0
			local var_56_6 = 0.825

			if var_56_5 < arg_53_1.time_ and arg_53_1.time_ <= var_56_5 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_7 = arg_53_1:FormatText(StoryNameCfg[384].name)

				arg_53_1.leftNameTxt_.text = var_56_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_8 = arg_53_1:GetWordFromCfg(120051013)
				local var_56_9 = arg_53_1:FormatText(var_56_8.content)

				arg_53_1.text_.text = var_56_9

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_10 = 33
				local var_56_11 = utf8.len(var_56_9)
				local var_56_12 = var_56_10 <= 0 and var_56_6 or var_56_6 * (var_56_11 / var_56_10)

				if var_56_12 > 0 and var_56_6 < var_56_12 then
					arg_53_1.talkMaxDuration = var_56_12

					if var_56_12 + var_56_5 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_12 + var_56_5
					end
				end

				arg_53_1.text_.text = var_56_9
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120051", "120051013", "story_v_out_120051.awb") ~= 0 then
					local var_56_13 = manager.audio:GetVoiceLength("story_v_out_120051", "120051013", "story_v_out_120051.awb") / 1000

					if var_56_13 + var_56_5 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_13 + var_56_5
					end

					if var_56_8.prefab_name ~= "" and arg_53_1.actors_[var_56_8.prefab_name] ~= nil then
						local var_56_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_8.prefab_name].transform, "story_v_out_120051", "120051013", "story_v_out_120051.awb")

						arg_53_1:RecordAudio("120051013", var_56_14)
						arg_53_1:RecordAudio("120051013", var_56_14)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_120051", "120051013", "story_v_out_120051.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_120051", "120051013", "story_v_out_120051.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_15 = math.max(var_56_6, arg_53_1.talkMaxDuration)

			if var_56_5 <= arg_53_1.time_ and arg_53_1.time_ < var_56_5 + var_56_15 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_5) / var_56_15

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_5 + var_56_15 and arg_53_1.time_ < var_56_5 + var_56_15 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play120051014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 120051014
		arg_57_1.duration_ = 9

		local var_57_0 = {
			zh = 7.566,
			ja = 9
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
				arg_57_0:Play120051015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = 0
			local var_60_1 = 1.15

			if var_60_0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_0 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_2 = arg_57_1:FormatText(StoryNameCfg[378].name)

				arg_57_1.leftNameTxt_.text = var_60_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, true)
				arg_57_1.iconController_:SetSelectedState("hero")

				arg_57_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1069")

				arg_57_1.callingController_:SetSelectedState("normal")

				arg_57_1.keyicon_.color = Color.New(1, 1, 1)
				arg_57_1.icon_.color = Color.New(1, 1, 1)

				local var_60_3 = arg_57_1:GetWordFromCfg(120051014)
				local var_60_4 = arg_57_1:FormatText(var_60_3.content)

				arg_57_1.text_.text = var_60_4

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_5 = 48
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

				if manager.audio:GetVoiceLength("story_v_out_120051", "120051014", "story_v_out_120051.awb") ~= 0 then
					local var_60_8 = manager.audio:GetVoiceLength("story_v_out_120051", "120051014", "story_v_out_120051.awb") / 1000

					if var_60_8 + var_60_0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_8 + var_60_0
					end

					if var_60_3.prefab_name ~= "" and arg_57_1.actors_[var_60_3.prefab_name] ~= nil then
						local var_60_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_3.prefab_name].transform, "story_v_out_120051", "120051014", "story_v_out_120051.awb")

						arg_57_1:RecordAudio("120051014", var_60_9)
						arg_57_1:RecordAudio("120051014", var_60_9)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_120051", "120051014", "story_v_out_120051.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_120051", "120051014", "story_v_out_120051.awb")
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
	Play120051015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 120051015
		arg_61_1.duration_ = 5

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play120051016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = arg_61_1.actors_["1071ui_story"].transform
			local var_64_1 = 0

			if var_64_1 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 then
				arg_61_1.var_.moveOldPos1071ui_story = var_64_0.localPosition
			end

			local var_64_2 = 0.001

			if var_64_1 <= arg_61_1.time_ and arg_61_1.time_ < var_64_1 + var_64_2 then
				local var_64_3 = (arg_61_1.time_ - var_64_1) / var_64_2
				local var_64_4 = Vector3.New(0, 100, 0)

				var_64_0.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos1071ui_story, var_64_4, var_64_3)

				local var_64_5 = manager.ui.mainCamera.transform.position - var_64_0.position

				var_64_0.forward = Vector3.New(var_64_5.x, var_64_5.y, var_64_5.z)

				local var_64_6 = var_64_0.localEulerAngles

				var_64_6.z = 0
				var_64_6.x = 0
				var_64_0.localEulerAngles = var_64_6
			end

			if arg_61_1.time_ >= var_64_1 + var_64_2 and arg_61_1.time_ < var_64_1 + var_64_2 + arg_64_0 then
				var_64_0.localPosition = Vector3.New(0, 100, 0)

				local var_64_7 = manager.ui.mainCamera.transform.position - var_64_0.position

				var_64_0.forward = Vector3.New(var_64_7.x, var_64_7.y, var_64_7.z)

				local var_64_8 = var_64_0.localEulerAngles

				var_64_8.z = 0
				var_64_8.x = 0
				var_64_0.localEulerAngles = var_64_8
			end

			local var_64_9 = arg_61_1.actors_["1075ui_story"].transform
			local var_64_10 = 0

			if var_64_10 < arg_61_1.time_ and arg_61_1.time_ <= var_64_10 + arg_64_0 then
				arg_61_1.var_.moveOldPos1075ui_story = var_64_9.localPosition
			end

			local var_64_11 = 0.001

			if var_64_10 <= arg_61_1.time_ and arg_61_1.time_ < var_64_10 + var_64_11 then
				local var_64_12 = (arg_61_1.time_ - var_64_10) / var_64_11
				local var_64_13 = Vector3.New(0, 100, 0)

				var_64_9.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos1075ui_story, var_64_13, var_64_12)

				local var_64_14 = manager.ui.mainCamera.transform.position - var_64_9.position

				var_64_9.forward = Vector3.New(var_64_14.x, var_64_14.y, var_64_14.z)

				local var_64_15 = var_64_9.localEulerAngles

				var_64_15.z = 0
				var_64_15.x = 0
				var_64_9.localEulerAngles = var_64_15
			end

			if arg_61_1.time_ >= var_64_10 + var_64_11 and arg_61_1.time_ < var_64_10 + var_64_11 + arg_64_0 then
				var_64_9.localPosition = Vector3.New(0, 100, 0)

				local var_64_16 = manager.ui.mainCamera.transform.position - var_64_9.position

				var_64_9.forward = Vector3.New(var_64_16.x, var_64_16.y, var_64_16.z)

				local var_64_17 = var_64_9.localEulerAngles

				var_64_17.z = 0
				var_64_17.x = 0
				var_64_9.localEulerAngles = var_64_17
			end

			local var_64_18 = 0
			local var_64_19 = 0.6

			if var_64_18 < arg_61_1.time_ and arg_61_1.time_ <= var_64_18 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, false)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_20 = arg_61_1:GetWordFromCfg(120051015)
				local var_64_21 = arg_61_1:FormatText(var_64_20.content)

				arg_61_1.text_.text = var_64_21

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_22 = 24
				local var_64_23 = utf8.len(var_64_21)
				local var_64_24 = var_64_22 <= 0 and var_64_19 or var_64_19 * (var_64_23 / var_64_22)

				if var_64_24 > 0 and var_64_19 < var_64_24 then
					arg_61_1.talkMaxDuration = var_64_24

					if var_64_24 + var_64_18 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_24 + var_64_18
					end
				end

				arg_61_1.text_.text = var_64_21
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)
				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_25 = math.max(var_64_19, arg_61_1.talkMaxDuration)

			if var_64_18 <= arg_61_1.time_ and arg_61_1.time_ < var_64_18 + var_64_25 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_18) / var_64_25

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_18 + var_64_25 and arg_61_1.time_ < var_64_18 + var_64_25 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {
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
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_61_1:InitPlayNodeList()
	end,
	Play120051016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 120051016
		arg_65_1.duration_ = 3.63

		local var_65_0 = {
			zh = 3,
			ja = 3.633
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
				arg_65_0:Play120051017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = arg_65_1.actors_["1071ui_story"].transform
			local var_68_1 = 0

			if var_68_1 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 then
				arg_65_1.var_.moveOldPos1071ui_story = var_68_0.localPosition
			end

			local var_68_2 = 0.001

			if var_68_1 <= arg_65_1.time_ and arg_65_1.time_ < var_68_1 + var_68_2 then
				local var_68_3 = (arg_65_1.time_ - var_68_1) / var_68_2
				local var_68_4 = Vector3.New(-0.7, -1.05, -6.2)

				var_68_0.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos1071ui_story, var_68_4, var_68_3)

				local var_68_5 = manager.ui.mainCamera.transform.position - var_68_0.position

				var_68_0.forward = Vector3.New(var_68_5.x, var_68_5.y, var_68_5.z)

				local var_68_6 = var_68_0.localEulerAngles

				var_68_6.z = 0
				var_68_6.x = 0
				var_68_0.localEulerAngles = var_68_6
			end

			if arg_65_1.time_ >= var_68_1 + var_68_2 and arg_65_1.time_ < var_68_1 + var_68_2 + arg_68_0 then
				var_68_0.localPosition = Vector3.New(-0.7, -1.05, -6.2)

				local var_68_7 = manager.ui.mainCamera.transform.position - var_68_0.position

				var_68_0.forward = Vector3.New(var_68_7.x, var_68_7.y, var_68_7.z)

				local var_68_8 = var_68_0.localEulerAngles

				var_68_8.z = 0
				var_68_8.x = 0
				var_68_0.localEulerAngles = var_68_8
			end

			local var_68_9 = "10044ui_story"

			if arg_65_1.actors_[var_68_9] == nil then
				local var_68_10 = Asset.Load("Char/" .. "10044ui_story")

				if not isNil(var_68_10) then
					local var_68_11 = Object.Instantiate(Asset.Load("Char/" .. "10044ui_story"), arg_65_1.stage_.transform)

					var_68_11.name = var_68_9
					var_68_11.transform.localPosition = Vector3.New(0, 100, 0)
					arg_65_1.actors_[var_68_9] = var_68_11

					local var_68_12 = var_68_11:GetComponentInChildren(typeof(CharacterEffect))

					var_68_12.enabled = true

					local var_68_13 = GameObjectTools.GetOrAddComponent(var_68_11, typeof(DynamicBoneHelper))

					if var_68_13 then
						var_68_13:EnableDynamicBone(false)
					end

					arg_65_1:ShowWeapon(var_68_12.transform, false)

					arg_65_1.var_[var_68_9 .. "Animator"] = var_68_12.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_65_1.var_[var_68_9 .. "Animator"].applyRootMotion = true
					arg_65_1.var_[var_68_9 .. "LipSync"] = var_68_12.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_68_14 = arg_65_1.actors_["10044ui_story"].transform
			local var_68_15 = 0

			if var_68_15 < arg_65_1.time_ and arg_65_1.time_ <= var_68_15 + arg_68_0 then
				arg_65_1.var_.moveOldPos10044ui_story = var_68_14.localPosition
			end

			local var_68_16 = 0.001

			if var_68_15 <= arg_65_1.time_ and arg_65_1.time_ < var_68_15 + var_68_16 then
				local var_68_17 = (arg_65_1.time_ - var_68_15) / var_68_16
				local var_68_18 = Vector3.New(0.7, -0.72, -6.3)

				var_68_14.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos10044ui_story, var_68_18, var_68_17)

				local var_68_19 = manager.ui.mainCamera.transform.position - var_68_14.position

				var_68_14.forward = Vector3.New(var_68_19.x, var_68_19.y, var_68_19.z)

				local var_68_20 = var_68_14.localEulerAngles

				var_68_20.z = 0
				var_68_20.x = 0
				var_68_14.localEulerAngles = var_68_20
			end

			if arg_65_1.time_ >= var_68_15 + var_68_16 and arg_65_1.time_ < var_68_15 + var_68_16 + arg_68_0 then
				var_68_14.localPosition = Vector3.New(0.7, -0.72, -6.3)

				local var_68_21 = manager.ui.mainCamera.transform.position - var_68_14.position

				var_68_14.forward = Vector3.New(var_68_21.x, var_68_21.y, var_68_21.z)

				local var_68_22 = var_68_14.localEulerAngles

				var_68_22.z = 0
				var_68_22.x = 0
				var_68_14.localEulerAngles = var_68_22
			end

			local var_68_23 = arg_65_1.actors_["1071ui_story"]
			local var_68_24 = 0

			if var_68_24 < arg_65_1.time_ and arg_65_1.time_ <= var_68_24 + arg_68_0 and not isNil(var_68_23) and arg_65_1.var_.characterEffect1071ui_story == nil then
				arg_65_1.var_.characterEffect1071ui_story = var_68_23:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_25 = 0.2

			if var_68_24 <= arg_65_1.time_ and arg_65_1.time_ < var_68_24 + var_68_25 and not isNil(var_68_23) then
				local var_68_26 = (arg_65_1.time_ - var_68_24) / var_68_25

				if arg_65_1.var_.characterEffect1071ui_story and not isNil(var_68_23) then
					arg_65_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_65_1.time_ >= var_68_24 + var_68_25 and arg_65_1.time_ < var_68_24 + var_68_25 + arg_68_0 and not isNil(var_68_23) and arg_65_1.var_.characterEffect1071ui_story then
				arg_65_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_68_27 = arg_65_1.actors_["10044ui_story"]
			local var_68_28 = 0

			if var_68_28 < arg_65_1.time_ and arg_65_1.time_ <= var_68_28 + arg_68_0 and not isNil(var_68_27) and arg_65_1.var_.characterEffect10044ui_story == nil then
				arg_65_1.var_.characterEffect10044ui_story = var_68_27:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_29 = 0.2

			if var_68_28 <= arg_65_1.time_ and arg_65_1.time_ < var_68_28 + var_68_29 and not isNil(var_68_27) then
				local var_68_30 = (arg_65_1.time_ - var_68_28) / var_68_29

				if arg_65_1.var_.characterEffect10044ui_story and not isNil(var_68_27) then
					local var_68_31 = Mathf.Lerp(0, 0.5, var_68_30)

					arg_65_1.var_.characterEffect10044ui_story.fillFlat = true
					arg_65_1.var_.characterEffect10044ui_story.fillRatio = var_68_31
				end
			end

			if arg_65_1.time_ >= var_68_28 + var_68_29 and arg_65_1.time_ < var_68_28 + var_68_29 + arg_68_0 and not isNil(var_68_27) and arg_65_1.var_.characterEffect10044ui_story then
				local var_68_32 = 0.5

				arg_65_1.var_.characterEffect10044ui_story.fillFlat = true
				arg_65_1.var_.characterEffect10044ui_story.fillRatio = var_68_32
			end

			local var_68_33 = 0

			if var_68_33 < arg_65_1.time_ and arg_65_1.time_ <= var_68_33 + arg_68_0 then
				arg_65_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action1_1")
			end

			local var_68_34 = 0

			if var_68_34 < arg_65_1.time_ and arg_65_1.time_ <= var_68_34 + arg_68_0 then
				arg_65_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044action/10044action1_1")
			end

			local var_68_35 = 0
			local var_68_36 = 0.225

			if var_68_35 < arg_65_1.time_ and arg_65_1.time_ <= var_68_35 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				local var_68_37 = arg_65_1:FormatText(StoryNameCfg[384].name)

				arg_65_1.leftNameTxt_.text = var_68_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_38 = arg_65_1:GetWordFromCfg(120051016)
				local var_68_39 = arg_65_1:FormatText(var_68_38.content)

				arg_65_1.text_.text = var_68_39

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_40 = 9
				local var_68_41 = utf8.len(var_68_39)
				local var_68_42 = var_68_40 <= 0 and var_68_36 or var_68_36 * (var_68_41 / var_68_40)

				if var_68_42 > 0 and var_68_36 < var_68_42 then
					arg_65_1.talkMaxDuration = var_68_42

					if var_68_42 + var_68_35 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_42 + var_68_35
					end
				end

				arg_65_1.text_.text = var_68_39
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120051", "120051016", "story_v_out_120051.awb") ~= 0 then
					local var_68_43 = manager.audio:GetVoiceLength("story_v_out_120051", "120051016", "story_v_out_120051.awb") / 1000

					if var_68_43 + var_68_35 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_43 + var_68_35
					end

					if var_68_38.prefab_name ~= "" and arg_65_1.actors_[var_68_38.prefab_name] ~= nil then
						local var_68_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_38.prefab_name].transform, "story_v_out_120051", "120051016", "story_v_out_120051.awb")

						arg_65_1:RecordAudio("120051016", var_68_44)
						arg_65_1:RecordAudio("120051016", var_68_44)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_120051", "120051016", "story_v_out_120051.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_120051", "120051016", "story_v_out_120051.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_45 = math.max(var_68_36, arg_65_1.talkMaxDuration)

			if var_68_35 <= arg_65_1.time_ and arg_65_1.time_ < var_68_35 + var_68_45 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_35) / var_68_45

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_35 + var_68_45 and arg_65_1.time_ < var_68_35 + var_68_45 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {
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
				actorName = "10044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_65_1:InitPlayNodeList()
	end,
	Play120051017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 120051017
		arg_69_1.duration_ = 6.8

		local var_69_0 = {
			zh = 5.333,
			ja = 6.8
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
				arg_69_0:Play120051018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = arg_69_1.actors_["1071ui_story"]
			local var_72_1 = 0

			if var_72_1 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 and not isNil(var_72_0) and arg_69_1.var_.characterEffect1071ui_story == nil then
				arg_69_1.var_.characterEffect1071ui_story = var_72_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_2 = 0.2

			if var_72_1 <= arg_69_1.time_ and arg_69_1.time_ < var_72_1 + var_72_2 and not isNil(var_72_0) then
				local var_72_3 = (arg_69_1.time_ - var_72_1) / var_72_2

				if arg_69_1.var_.characterEffect1071ui_story and not isNil(var_72_0) then
					local var_72_4 = Mathf.Lerp(0, 0.5, var_72_3)

					arg_69_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_69_1.var_.characterEffect1071ui_story.fillRatio = var_72_4
				end
			end

			if arg_69_1.time_ >= var_72_1 + var_72_2 and arg_69_1.time_ < var_72_1 + var_72_2 + arg_72_0 and not isNil(var_72_0) and arg_69_1.var_.characterEffect1071ui_story then
				local var_72_5 = 0.5

				arg_69_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_69_1.var_.characterEffect1071ui_story.fillRatio = var_72_5
			end

			local var_72_6 = arg_69_1.actors_["10044ui_story"]
			local var_72_7 = 0

			if var_72_7 < arg_69_1.time_ and arg_69_1.time_ <= var_72_7 + arg_72_0 and not isNil(var_72_6) and arg_69_1.var_.characterEffect10044ui_story == nil then
				arg_69_1.var_.characterEffect10044ui_story = var_72_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_8 = 0.2

			if var_72_7 <= arg_69_1.time_ and arg_69_1.time_ < var_72_7 + var_72_8 and not isNil(var_72_6) then
				local var_72_9 = (arg_69_1.time_ - var_72_7) / var_72_8

				if arg_69_1.var_.characterEffect10044ui_story and not isNil(var_72_6) then
					arg_69_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_69_1.time_ >= var_72_7 + var_72_8 and arg_69_1.time_ < var_72_7 + var_72_8 + arg_72_0 and not isNil(var_72_6) and arg_69_1.var_.characterEffect10044ui_story then
				arg_69_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			local var_72_10 = 0

			if var_72_10 < arg_69_1.time_ and arg_69_1.time_ <= var_72_10 + arg_72_0 then
				arg_69_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044action/10044action3_1")
			end

			local var_72_11 = 0

			if var_72_11 < arg_69_1.time_ and arg_69_1.time_ <= var_72_11 + arg_72_0 then
				arg_69_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_72_12 = 0
			local var_72_13 = 0.625

			if var_72_12 < arg_69_1.time_ and arg_69_1.time_ <= var_72_12 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				local var_72_14 = arg_69_1:FormatText(StoryNameCfg[380].name)

				arg_69_1.leftNameTxt_.text = var_72_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_15 = arg_69_1:GetWordFromCfg(120051017)
				local var_72_16 = arg_69_1:FormatText(var_72_15.content)

				arg_69_1.text_.text = var_72_16

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_17 = 25
				local var_72_18 = utf8.len(var_72_16)
				local var_72_19 = var_72_17 <= 0 and var_72_13 or var_72_13 * (var_72_18 / var_72_17)

				if var_72_19 > 0 and var_72_13 < var_72_19 then
					arg_69_1.talkMaxDuration = var_72_19

					if var_72_19 + var_72_12 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_19 + var_72_12
					end
				end

				arg_69_1.text_.text = var_72_16
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120051", "120051017", "story_v_out_120051.awb") ~= 0 then
					local var_72_20 = manager.audio:GetVoiceLength("story_v_out_120051", "120051017", "story_v_out_120051.awb") / 1000

					if var_72_20 + var_72_12 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_20 + var_72_12
					end

					if var_72_15.prefab_name ~= "" and arg_69_1.actors_[var_72_15.prefab_name] ~= nil then
						local var_72_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_15.prefab_name].transform, "story_v_out_120051", "120051017", "story_v_out_120051.awb")

						arg_69_1:RecordAudio("120051017", var_72_21)
						arg_69_1:RecordAudio("120051017", var_72_21)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_120051", "120051017", "story_v_out_120051.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_120051", "120051017", "story_v_out_120051.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_22 = math.max(var_72_13, arg_69_1.talkMaxDuration)

			if var_72_12 <= arg_69_1.time_ and arg_69_1.time_ < var_72_12 + var_72_22 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_12) / var_72_22

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_12 + var_72_22 and arg_69_1.time_ < var_72_12 + var_72_22 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play120051018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 120051018
		arg_73_1.duration_ = 5

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play120051019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = arg_73_1.actors_["10044ui_story"]
			local var_76_1 = 0

			if var_76_1 < arg_73_1.time_ and arg_73_1.time_ <= var_76_1 + arg_76_0 and not isNil(var_76_0) and arg_73_1.var_.characterEffect10044ui_story == nil then
				arg_73_1.var_.characterEffect10044ui_story = var_76_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_2 = 0.2

			if var_76_1 <= arg_73_1.time_ and arg_73_1.time_ < var_76_1 + var_76_2 and not isNil(var_76_0) then
				local var_76_3 = (arg_73_1.time_ - var_76_1) / var_76_2

				if arg_73_1.var_.characterEffect10044ui_story and not isNil(var_76_0) then
					local var_76_4 = Mathf.Lerp(0, 0.5, var_76_3)

					arg_73_1.var_.characterEffect10044ui_story.fillFlat = true
					arg_73_1.var_.characterEffect10044ui_story.fillRatio = var_76_4
				end
			end

			if arg_73_1.time_ >= var_76_1 + var_76_2 and arg_73_1.time_ < var_76_1 + var_76_2 + arg_76_0 and not isNil(var_76_0) and arg_73_1.var_.characterEffect10044ui_story then
				local var_76_5 = 0.5

				arg_73_1.var_.characterEffect10044ui_story.fillFlat = true
				arg_73_1.var_.characterEffect10044ui_story.fillRatio = var_76_5
			end

			local var_76_6 = 0
			local var_76_7 = 0.95

			if var_76_6 < arg_73_1.time_ and arg_73_1.time_ <= var_76_6 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, false)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_8 = arg_73_1:GetWordFromCfg(120051018)
				local var_76_9 = arg_73_1:FormatText(var_76_8.content)

				arg_73_1.text_.text = var_76_9

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_10 = 38
				local var_76_11 = utf8.len(var_76_9)
				local var_76_12 = var_76_10 <= 0 and var_76_7 or var_76_7 * (var_76_11 / var_76_10)

				if var_76_12 > 0 and var_76_7 < var_76_12 then
					arg_73_1.talkMaxDuration = var_76_12

					if var_76_12 + var_76_6 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_12 + var_76_6
					end
				end

				arg_73_1.text_.text = var_76_9
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)
				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_13 = math.max(var_76_7, arg_73_1.talkMaxDuration)

			if var_76_6 <= arg_73_1.time_ and arg_73_1.time_ < var_76_6 + var_76_13 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_6) / var_76_13

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_6 + var_76_13 and arg_73_1.time_ < var_76_6 + var_76_13 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play120051019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 120051019
		arg_77_1.duration_ = 5.37

		local var_77_0 = {
			zh = 3.733,
			ja = 5.366
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
				arg_77_0:Play120051020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = arg_77_1.actors_["1075ui_story"].transform
			local var_80_1 = 0

			if var_80_1 < arg_77_1.time_ and arg_77_1.time_ <= var_80_1 + arg_80_0 then
				arg_77_1.var_.moveOldPos1075ui_story = var_80_0.localPosition
			end

			local var_80_2 = 0.001

			if var_80_1 <= arg_77_1.time_ and arg_77_1.time_ < var_80_1 + var_80_2 then
				local var_80_3 = (arg_77_1.time_ - var_80_1) / var_80_2
				local var_80_4 = Vector3.New(-0.7, -1.055, -6.16)

				var_80_0.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos1075ui_story, var_80_4, var_80_3)

				local var_80_5 = manager.ui.mainCamera.transform.position - var_80_0.position

				var_80_0.forward = Vector3.New(var_80_5.x, var_80_5.y, var_80_5.z)

				local var_80_6 = var_80_0.localEulerAngles

				var_80_6.z = 0
				var_80_6.x = 0
				var_80_0.localEulerAngles = var_80_6
			end

			if arg_77_1.time_ >= var_80_1 + var_80_2 and arg_77_1.time_ < var_80_1 + var_80_2 + arg_80_0 then
				var_80_0.localPosition = Vector3.New(-0.7, -1.055, -6.16)

				local var_80_7 = manager.ui.mainCamera.transform.position - var_80_0.position

				var_80_0.forward = Vector3.New(var_80_7.x, var_80_7.y, var_80_7.z)

				local var_80_8 = var_80_0.localEulerAngles

				var_80_8.z = 0
				var_80_8.x = 0
				var_80_0.localEulerAngles = var_80_8
			end

			local var_80_9 = arg_77_1.actors_["1071ui_story"].transform
			local var_80_10 = 0

			if var_80_10 < arg_77_1.time_ and arg_77_1.time_ <= var_80_10 + arg_80_0 then
				arg_77_1.var_.moveOldPos1071ui_story = var_80_9.localPosition
			end

			local var_80_11 = 0.001

			if var_80_10 <= arg_77_1.time_ and arg_77_1.time_ < var_80_10 + var_80_11 then
				local var_80_12 = (arg_77_1.time_ - var_80_10) / var_80_11
				local var_80_13 = Vector3.New(0, 100, 0)

				var_80_9.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos1071ui_story, var_80_13, var_80_12)

				local var_80_14 = manager.ui.mainCamera.transform.position - var_80_9.position

				var_80_9.forward = Vector3.New(var_80_14.x, var_80_14.y, var_80_14.z)

				local var_80_15 = var_80_9.localEulerAngles

				var_80_15.z = 0
				var_80_15.x = 0
				var_80_9.localEulerAngles = var_80_15
			end

			if arg_77_1.time_ >= var_80_10 + var_80_11 and arg_77_1.time_ < var_80_10 + var_80_11 + arg_80_0 then
				var_80_9.localPosition = Vector3.New(0, 100, 0)

				local var_80_16 = manager.ui.mainCamera.transform.position - var_80_9.position

				var_80_9.forward = Vector3.New(var_80_16.x, var_80_16.y, var_80_16.z)

				local var_80_17 = var_80_9.localEulerAngles

				var_80_17.z = 0
				var_80_17.x = 0
				var_80_9.localEulerAngles = var_80_17
			end

			local var_80_18 = arg_77_1.actors_["1075ui_story"]
			local var_80_19 = 0

			if var_80_19 < arg_77_1.time_ and arg_77_1.time_ <= var_80_19 + arg_80_0 and not isNil(var_80_18) and arg_77_1.var_.characterEffect1075ui_story == nil then
				arg_77_1.var_.characterEffect1075ui_story = var_80_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_20 = 0.2

			if var_80_19 <= arg_77_1.time_ and arg_77_1.time_ < var_80_19 + var_80_20 and not isNil(var_80_18) then
				local var_80_21 = (arg_77_1.time_ - var_80_19) / var_80_20

				if arg_77_1.var_.characterEffect1075ui_story and not isNil(var_80_18) then
					arg_77_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_77_1.time_ >= var_80_19 + var_80_20 and arg_77_1.time_ < var_80_19 + var_80_20 + arg_80_0 and not isNil(var_80_18) and arg_77_1.var_.characterEffect1075ui_story then
				arg_77_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_80_22 = 0

			if var_80_22 < arg_77_1.time_ and arg_77_1.time_ <= var_80_22 + arg_80_0 then
				arg_77_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action4_1")
			end

			local var_80_23 = 0

			if var_80_23 < arg_77_1.time_ and arg_77_1.time_ <= var_80_23 + arg_80_0 then
				arg_77_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_80_24 = 0
			local var_80_25 = 0.425

			if var_80_24 < arg_77_1.time_ and arg_77_1.time_ <= var_80_24 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				local var_80_26 = arg_77_1:FormatText(StoryNameCfg[381].name)

				arg_77_1.leftNameTxt_.text = var_80_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_27 = arg_77_1:GetWordFromCfg(120051019)
				local var_80_28 = arg_77_1:FormatText(var_80_27.content)

				arg_77_1.text_.text = var_80_28

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_29 = 17
				local var_80_30 = utf8.len(var_80_28)
				local var_80_31 = var_80_29 <= 0 and var_80_25 or var_80_25 * (var_80_30 / var_80_29)

				if var_80_31 > 0 and var_80_25 < var_80_31 then
					arg_77_1.talkMaxDuration = var_80_31

					if var_80_31 + var_80_24 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_31 + var_80_24
					end
				end

				arg_77_1.text_.text = var_80_28
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120051", "120051019", "story_v_out_120051.awb") ~= 0 then
					local var_80_32 = manager.audio:GetVoiceLength("story_v_out_120051", "120051019", "story_v_out_120051.awb") / 1000

					if var_80_32 + var_80_24 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_32 + var_80_24
					end

					if var_80_27.prefab_name ~= "" and arg_77_1.actors_[var_80_27.prefab_name] ~= nil then
						local var_80_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_27.prefab_name].transform, "story_v_out_120051", "120051019", "story_v_out_120051.awb")

						arg_77_1:RecordAudio("120051019", var_80_33)
						arg_77_1:RecordAudio("120051019", var_80_33)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_120051", "120051019", "story_v_out_120051.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_120051", "120051019", "story_v_out_120051.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_34 = math.max(var_80_25, arg_77_1.talkMaxDuration)

			if var_80_24 <= arg_77_1.time_ and arg_77_1.time_ < var_80_24 + var_80_34 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_24) / var_80_34

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_24 + var_80_34 and arg_77_1.time_ < var_80_24 + var_80_34 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_77_1:InitPlayNodeList()
	end,
	Play120051020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 120051020
		arg_81_1.duration_ = 6.03

		local var_81_0 = {
			zh = 6.033,
			ja = 3.366
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
				arg_81_0:Play120051021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = arg_81_1.actors_["10044ui_story"]
			local var_84_1 = 0

			if var_84_1 < arg_81_1.time_ and arg_81_1.time_ <= var_84_1 + arg_84_0 and not isNil(var_84_0) and arg_81_1.var_.characterEffect10044ui_story == nil then
				arg_81_1.var_.characterEffect10044ui_story = var_84_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_2 = 0.2

			if var_84_1 <= arg_81_1.time_ and arg_81_1.time_ < var_84_1 + var_84_2 and not isNil(var_84_0) then
				local var_84_3 = (arg_81_1.time_ - var_84_1) / var_84_2

				if arg_81_1.var_.characterEffect10044ui_story and not isNil(var_84_0) then
					arg_81_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_81_1.time_ >= var_84_1 + var_84_2 and arg_81_1.time_ < var_84_1 + var_84_2 + arg_84_0 and not isNil(var_84_0) and arg_81_1.var_.characterEffect10044ui_story then
				arg_81_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			local var_84_4 = arg_81_1.actors_["1075ui_story"]
			local var_84_5 = 0

			if var_84_5 < arg_81_1.time_ and arg_81_1.time_ <= var_84_5 + arg_84_0 and not isNil(var_84_4) and arg_81_1.var_.characterEffect1075ui_story == nil then
				arg_81_1.var_.characterEffect1075ui_story = var_84_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_6 = 0.2

			if var_84_5 <= arg_81_1.time_ and arg_81_1.time_ < var_84_5 + var_84_6 and not isNil(var_84_4) then
				local var_84_7 = (arg_81_1.time_ - var_84_5) / var_84_6

				if arg_81_1.var_.characterEffect1075ui_story and not isNil(var_84_4) then
					local var_84_8 = Mathf.Lerp(0, 0.5, var_84_7)

					arg_81_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_81_1.var_.characterEffect1075ui_story.fillRatio = var_84_8
				end
			end

			if arg_81_1.time_ >= var_84_5 + var_84_6 and arg_81_1.time_ < var_84_5 + var_84_6 + arg_84_0 and not isNil(var_84_4) and arg_81_1.var_.characterEffect1075ui_story then
				local var_84_9 = 0.5

				arg_81_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_81_1.var_.characterEffect1075ui_story.fillRatio = var_84_9
			end

			local var_84_10 = 0

			if var_84_10 < arg_81_1.time_ and arg_81_1.time_ <= var_84_10 + arg_84_0 then
				arg_81_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044actionlink/10044action432")
			end

			local var_84_11 = 0
			local var_84_12 = 0.7

			if var_84_11 < arg_81_1.time_ and arg_81_1.time_ <= var_84_11 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				local var_84_13 = arg_81_1:FormatText(StoryNameCfg[380].name)

				arg_81_1.leftNameTxt_.text = var_84_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_14 = arg_81_1:GetWordFromCfg(120051020)
				local var_84_15 = arg_81_1:FormatText(var_84_14.content)

				arg_81_1.text_.text = var_84_15

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_16 = 28
				local var_84_17 = utf8.len(var_84_15)
				local var_84_18 = var_84_16 <= 0 and var_84_12 or var_84_12 * (var_84_17 / var_84_16)

				if var_84_18 > 0 and var_84_12 < var_84_18 then
					arg_81_1.talkMaxDuration = var_84_18

					if var_84_18 + var_84_11 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_18 + var_84_11
					end
				end

				arg_81_1.text_.text = var_84_15
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120051", "120051020", "story_v_out_120051.awb") ~= 0 then
					local var_84_19 = manager.audio:GetVoiceLength("story_v_out_120051", "120051020", "story_v_out_120051.awb") / 1000

					if var_84_19 + var_84_11 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_19 + var_84_11
					end

					if var_84_14.prefab_name ~= "" and arg_81_1.actors_[var_84_14.prefab_name] ~= nil then
						local var_84_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_14.prefab_name].transform, "story_v_out_120051", "120051020", "story_v_out_120051.awb")

						arg_81_1:RecordAudio("120051020", var_84_20)
						arg_81_1:RecordAudio("120051020", var_84_20)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_120051", "120051020", "story_v_out_120051.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_120051", "120051020", "story_v_out_120051.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_21 = math.max(var_84_12, arg_81_1.talkMaxDuration)

			if var_84_11 <= arg_81_1.time_ and arg_81_1.time_ < var_84_11 + var_84_21 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_11) / var_84_21

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_11 + var_84_21 and arg_81_1.time_ < var_84_11 + var_84_21 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play120051021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 120051021
		arg_85_1.duration_ = 8

		local var_85_0 = {
			zh = 7.3,
			ja = 8
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
				arg_85_0:Play120051022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = arg_85_1.actors_["10044ui_story"]
			local var_88_1 = 0

			if var_88_1 < arg_85_1.time_ and arg_85_1.time_ <= var_88_1 + arg_88_0 and not isNil(var_88_0) and arg_85_1.var_.characterEffect10044ui_story == nil then
				arg_85_1.var_.characterEffect10044ui_story = var_88_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_2 = 0.2

			if var_88_1 <= arg_85_1.time_ and arg_85_1.time_ < var_88_1 + var_88_2 and not isNil(var_88_0) then
				local var_88_3 = (arg_85_1.time_ - var_88_1) / var_88_2

				if arg_85_1.var_.characterEffect10044ui_story and not isNil(var_88_0) then
					local var_88_4 = Mathf.Lerp(0, 0.5, var_88_3)

					arg_85_1.var_.characterEffect10044ui_story.fillFlat = true
					arg_85_1.var_.characterEffect10044ui_story.fillRatio = var_88_4
				end
			end

			if arg_85_1.time_ >= var_88_1 + var_88_2 and arg_85_1.time_ < var_88_1 + var_88_2 + arg_88_0 and not isNil(var_88_0) and arg_85_1.var_.characterEffect10044ui_story then
				local var_88_5 = 0.5

				arg_85_1.var_.characterEffect10044ui_story.fillFlat = true
				arg_85_1.var_.characterEffect10044ui_story.fillRatio = var_88_5
			end

			local var_88_6 = 0
			local var_88_7 = 0.8

			if var_88_6 < arg_85_1.time_ and arg_85_1.time_ <= var_88_6 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				local var_88_8 = arg_85_1:FormatText(StoryNameCfg[384].name)

				arg_85_1.leftNameTxt_.text = var_88_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, true)
				arg_85_1.iconController_:SetSelectedState("hero")

				arg_85_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1071")

				arg_85_1.callingController_:SetSelectedState("normal")

				arg_85_1.keyicon_.color = Color.New(1, 1, 1)
				arg_85_1.icon_.color = Color.New(1, 1, 1)

				local var_88_9 = arg_85_1:GetWordFromCfg(120051021)
				local var_88_10 = arg_85_1:FormatText(var_88_9.content)

				arg_85_1.text_.text = var_88_10

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_11 = 32
				local var_88_12 = utf8.len(var_88_10)
				local var_88_13 = var_88_11 <= 0 and var_88_7 or var_88_7 * (var_88_12 / var_88_11)

				if var_88_13 > 0 and var_88_7 < var_88_13 then
					arg_85_1.talkMaxDuration = var_88_13

					if var_88_13 + var_88_6 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_13 + var_88_6
					end
				end

				arg_85_1.text_.text = var_88_10
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120051", "120051021", "story_v_out_120051.awb") ~= 0 then
					local var_88_14 = manager.audio:GetVoiceLength("story_v_out_120051", "120051021", "story_v_out_120051.awb") / 1000

					if var_88_14 + var_88_6 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_14 + var_88_6
					end

					if var_88_9.prefab_name ~= "" and arg_85_1.actors_[var_88_9.prefab_name] ~= nil then
						local var_88_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_9.prefab_name].transform, "story_v_out_120051", "120051021", "story_v_out_120051.awb")

						arg_85_1:RecordAudio("120051021", var_88_15)
						arg_85_1:RecordAudio("120051021", var_88_15)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_120051", "120051021", "story_v_out_120051.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_120051", "120051021", "story_v_out_120051.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_16 = math.max(var_88_7, arg_85_1.talkMaxDuration)

			if var_88_6 <= arg_85_1.time_ and arg_85_1.time_ < var_88_6 + var_88_16 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_6) / var_88_16

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_6 + var_88_16 and arg_85_1.time_ < var_88_6 + var_88_16 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play120051022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 120051022
		arg_89_1.duration_ = 4.87

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play120051023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = "STblack"

			if arg_89_1.bgs_[var_92_0] == nil then
				local var_92_1 = Object.Instantiate(arg_89_1.paintGo_)

				var_92_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_92_0)
				var_92_1.name = var_92_0
				var_92_1.transform.parent = arg_89_1.stage_.transform
				var_92_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_89_1.bgs_[var_92_0] = var_92_1
			end

			local var_92_2 = 2

			if var_92_2 < arg_89_1.time_ and arg_89_1.time_ <= var_92_2 + arg_92_0 then
				local var_92_3 = manager.ui.mainCamera.transform.localPosition
				local var_92_4 = Vector3.New(0, 0, 10) + Vector3.New(var_92_3.x, var_92_3.y, 0)
				local var_92_5 = arg_89_1.bgs_.STblack

				var_92_5.transform.localPosition = var_92_4
				var_92_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_92_6 = var_92_5:GetComponent("SpriteRenderer")

				if var_92_6 and var_92_6.sprite then
					local var_92_7 = (var_92_5.transform.localPosition - var_92_3).z
					local var_92_8 = manager.ui.mainCameraCom_
					local var_92_9 = 2 * var_92_7 * Mathf.Tan(var_92_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_92_10 = var_92_9 * var_92_8.aspect
					local var_92_11 = var_92_6.sprite.bounds.size.x
					local var_92_12 = var_92_6.sprite.bounds.size.y
					local var_92_13 = var_92_10 / var_92_11
					local var_92_14 = var_92_9 / var_92_12
					local var_92_15 = var_92_14 < var_92_13 and var_92_13 or var_92_14

					var_92_5.transform.localScale = Vector3.New(var_92_15, var_92_15, 0)
				end

				for iter_92_0, iter_92_1 in pairs(arg_89_1.bgs_) do
					if iter_92_0 ~= "STblack" then
						iter_92_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_92_16 = 0

			if var_92_16 < arg_89_1.time_ and arg_89_1.time_ <= var_92_16 + arg_92_0 then
				arg_89_1.mask_.enabled = true
				arg_89_1.mask_.raycastTarget = true

				arg_89_1:SetGaussion(false)
			end

			local var_92_17 = 2

			if var_92_16 <= arg_89_1.time_ and arg_89_1.time_ < var_92_16 + var_92_17 then
				local var_92_18 = (arg_89_1.time_ - var_92_16) / var_92_17
				local var_92_19 = Color.New(0, 0, 0)

				var_92_19.a = Mathf.Lerp(0, 1, var_92_18)
				arg_89_1.mask_.color = var_92_19
			end

			if arg_89_1.time_ >= var_92_16 + var_92_17 and arg_89_1.time_ < var_92_16 + var_92_17 + arg_92_0 then
				local var_92_20 = Color.New(0, 0, 0)

				var_92_20.a = 1
				arg_89_1.mask_.color = var_92_20
			end

			local var_92_21 = 2

			if var_92_21 < arg_89_1.time_ and arg_89_1.time_ <= var_92_21 + arg_92_0 then
				arg_89_1.mask_.enabled = true
				arg_89_1.mask_.raycastTarget = true

				arg_89_1:SetGaussion(false)
			end

			local var_92_22 = 2

			if var_92_21 <= arg_89_1.time_ and arg_89_1.time_ < var_92_21 + var_92_22 then
				local var_92_23 = (arg_89_1.time_ - var_92_21) / var_92_22
				local var_92_24 = Color.New(0, 0, 0)

				var_92_24.a = Mathf.Lerp(1, 0, var_92_23)
				arg_89_1.mask_.color = var_92_24
			end

			if arg_89_1.time_ >= var_92_21 + var_92_22 and arg_89_1.time_ < var_92_21 + var_92_22 + arg_92_0 then
				local var_92_25 = Color.New(0, 0, 0)
				local var_92_26 = 0

				arg_89_1.mask_.enabled = false
				var_92_25.a = var_92_26
				arg_89_1.mask_.color = var_92_25
			end

			local var_92_27 = 2

			if var_92_27 < arg_89_1.time_ and arg_89_1.time_ <= var_92_27 + arg_92_0 then
				arg_89_1.fswbg_:SetActive(true)
				arg_89_1.dialog_:SetActive(false)

				arg_89_1.fswtw_.percent = 0

				local var_92_28 = arg_89_1:GetWordFromCfg(120051022)
				local var_92_29 = arg_89_1:FormatText(var_92_28.content)

				arg_89_1.fswt_.text = var_92_29

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.fswt_)

				arg_89_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_89_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_89_1.fswtw_:SetDirty()

				arg_89_1.typewritterCharCountI18N = 0

				SetActive(arg_89_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_89_1:ShowNextGo(false)
			end

			local var_92_30 = 2.01666666666667

			if var_92_30 < arg_89_1.time_ and arg_89_1.time_ <= var_92_30 + arg_92_0 then
				arg_89_1.var_.oldValueTypewriter = arg_89_1.fswtw_.percent

				SetActive(arg_89_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_89_1:ShowNextGo(false)
			end

			local var_92_31 = 34
			local var_92_32 = 2.26666666666667
			local var_92_33 = arg_89_1:GetWordFromCfg(120051022)
			local var_92_34 = arg_89_1:FormatText(var_92_33.content)
			local var_92_35, var_92_36 = arg_89_1:GetPercentByPara(var_92_34, 1)

			if var_92_30 < arg_89_1.time_ and arg_89_1.time_ <= var_92_30 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0

				local var_92_37 = var_92_31 <= 0 and var_92_32 or var_92_32 * ((var_92_36 - arg_89_1.typewritterCharCountI18N) / var_92_31)

				if var_92_37 > 0 and var_92_32 < var_92_37 then
					arg_89_1.talkMaxDuration = var_92_37

					if var_92_37 + var_92_30 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_37 + var_92_30
					end
				end
			end

			local var_92_38 = 2.26666666666667
			local var_92_39 = math.max(var_92_38, arg_89_1.talkMaxDuration)

			if var_92_30 <= arg_89_1.time_ and arg_89_1.time_ < var_92_30 + var_92_39 then
				local var_92_40 = (arg_89_1.time_ - var_92_30) / var_92_39

				arg_89_1.fswtw_.percent = Mathf.Lerp(arg_89_1.var_.oldValueTypewriter, var_92_35, var_92_40)
				arg_89_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_89_1.fswtw_:SetDirty()
			end

			if arg_89_1.time_ >= var_92_30 + var_92_39 and arg_89_1.time_ < var_92_30 + var_92_39 + arg_92_0 then
				arg_89_1.fswtw_.percent = var_92_35

				arg_89_1.fswtw_:SetDirty()
				arg_89_1:ShowNextGo(true)

				arg_89_1.typewritterCharCountI18N = var_92_36
			end

			local var_92_41 = 2

			if var_92_41 < arg_89_1.time_ and arg_89_1.time_ <= var_92_41 + arg_92_0 then
				local var_92_42 = arg_89_1.fswbg_.transform:Find("textbox/adapt/content") or arg_89_1.fswbg_.transform:Find("textbox/content")
				local var_92_43 = arg_89_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_92_44 = var_92_42:GetComponent("Text")
				local var_92_45 = var_92_42:GetComponent("RectTransform")

				var_92_44.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_92_45.offsetMin = Vector2.New(0, 0)
				var_92_45.offsetMax = Vector2.New(0, 0)
			end

			local var_92_46 = arg_89_1.actors_["10044ui_story"].transform
			local var_92_47 = 1.966

			if var_92_47 < arg_89_1.time_ and arg_89_1.time_ <= var_92_47 + arg_92_0 then
				arg_89_1.var_.moveOldPos10044ui_story = var_92_46.localPosition
			end

			local var_92_48 = 0.001

			if var_92_47 <= arg_89_1.time_ and arg_89_1.time_ < var_92_47 + var_92_48 then
				local var_92_49 = (arg_89_1.time_ - var_92_47) / var_92_48
				local var_92_50 = Vector3.New(0, 100, 0)

				var_92_46.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos10044ui_story, var_92_50, var_92_49)

				local var_92_51 = manager.ui.mainCamera.transform.position - var_92_46.position

				var_92_46.forward = Vector3.New(var_92_51.x, var_92_51.y, var_92_51.z)

				local var_92_52 = var_92_46.localEulerAngles

				var_92_52.z = 0
				var_92_52.x = 0
				var_92_46.localEulerAngles = var_92_52
			end

			if arg_89_1.time_ >= var_92_47 + var_92_48 and arg_89_1.time_ < var_92_47 + var_92_48 + arg_92_0 then
				var_92_46.localPosition = Vector3.New(0, 100, 0)

				local var_92_53 = manager.ui.mainCamera.transform.position - var_92_46.position

				var_92_46.forward = Vector3.New(var_92_53.x, var_92_53.y, var_92_53.z)

				local var_92_54 = var_92_46.localEulerAngles

				var_92_54.z = 0
				var_92_54.x = 0
				var_92_46.localEulerAngles = var_92_54
			end

			local var_92_55 = arg_89_1.actors_["1075ui_story"].transform
			local var_92_56 = 1.966

			if var_92_56 < arg_89_1.time_ and arg_89_1.time_ <= var_92_56 + arg_92_0 then
				arg_89_1.var_.moveOldPos1075ui_story = var_92_55.localPosition
			end

			local var_92_57 = 0.001

			if var_92_56 <= arg_89_1.time_ and arg_89_1.time_ < var_92_56 + var_92_57 then
				local var_92_58 = (arg_89_1.time_ - var_92_56) / var_92_57
				local var_92_59 = Vector3.New(0, 100, 0)

				var_92_55.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos1075ui_story, var_92_59, var_92_58)

				local var_92_60 = manager.ui.mainCamera.transform.position - var_92_55.position

				var_92_55.forward = Vector3.New(var_92_60.x, var_92_60.y, var_92_60.z)

				local var_92_61 = var_92_55.localEulerAngles

				var_92_61.z = 0
				var_92_61.x = 0
				var_92_55.localEulerAngles = var_92_61
			end

			if arg_89_1.time_ >= var_92_56 + var_92_57 and arg_89_1.time_ < var_92_56 + var_92_57 + arg_92_0 then
				var_92_55.localPosition = Vector3.New(0, 100, 0)

				local var_92_62 = manager.ui.mainCamera.transform.position - var_92_55.position

				var_92_55.forward = Vector3.New(var_92_62.x, var_92_62.y, var_92_62.z)

				local var_92_63 = var_92_55.localEulerAngles

				var_92_63.z = 0
				var_92_63.x = 0
				var_92_55.localEulerAngles = var_92_63
			end
		end

		arg_89_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_89_1:InitPlayNodeList()
	end,
	Play120051023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 120051023
		arg_93_1.duration_ = 3.28

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play120051024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = 0

			if var_96_0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_0 + arg_96_0 then
				arg_93_1.fswbg_:SetActive(true)
				arg_93_1.dialog_:SetActive(false)

				arg_93_1.fswtw_.percent = 0

				local var_96_1 = arg_93_1:GetWordFromCfg(120051023)
				local var_96_2 = arg_93_1:FormatText(var_96_1.content)

				arg_93_1.fswt_.text = var_96_2

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.fswt_)

				arg_93_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_93_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_93_1.fswtw_:SetDirty()

				arg_93_1.typewritterCharCountI18N = 0

				SetActive(arg_93_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_93_1:ShowNextGo(false)
			end

			local var_96_3 = 0.0166666666666667

			if var_96_3 < arg_93_1.time_ and arg_93_1.time_ <= var_96_3 + arg_96_0 then
				arg_93_1.var_.oldValueTypewriter = arg_93_1.fswtw_.percent

				SetActive(arg_93_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_93_1:ShowNextGo(false)
			end

			local var_96_4 = 49
			local var_96_5 = 3.26666666666667
			local var_96_6 = arg_93_1:GetWordFromCfg(120051023)
			local var_96_7 = arg_93_1:FormatText(var_96_6.content)
			local var_96_8, var_96_9 = arg_93_1:GetPercentByPara(var_96_7, 1)

			if var_96_3 < arg_93_1.time_ and arg_93_1.time_ <= var_96_3 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0

				local var_96_10 = var_96_4 <= 0 and var_96_5 or var_96_5 * ((var_96_9 - arg_93_1.typewritterCharCountI18N) / var_96_4)

				if var_96_10 > 0 and var_96_5 < var_96_10 then
					arg_93_1.talkMaxDuration = var_96_10

					if var_96_10 + var_96_3 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_10 + var_96_3
					end
				end
			end

			local var_96_11 = 3.26666666666667
			local var_96_12 = math.max(var_96_11, arg_93_1.talkMaxDuration)

			if var_96_3 <= arg_93_1.time_ and arg_93_1.time_ < var_96_3 + var_96_12 then
				local var_96_13 = (arg_93_1.time_ - var_96_3) / var_96_12

				arg_93_1.fswtw_.percent = Mathf.Lerp(arg_93_1.var_.oldValueTypewriter, var_96_8, var_96_13)
				arg_93_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_93_1.fswtw_:SetDirty()
			end

			if arg_93_1.time_ >= var_96_3 + var_96_12 and arg_93_1.time_ < var_96_3 + var_96_12 + arg_96_0 then
				arg_93_1.fswtw_.percent = var_96_8

				arg_93_1.fswtw_:SetDirty()
				arg_93_1:ShowNextGo(true)

				arg_93_1.typewritterCharCountI18N = var_96_9
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play120051024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 120051024
		arg_97_1.duration_ = 5.73

		local var_97_0 = {
			zh = 2.366,
			ja = 5.733
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
				arg_97_0:Play120051025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = 0

			if var_100_0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_0 + arg_100_0 then
				arg_97_1.fswbg_:SetActive(false)
				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_97_1:ShowNextGo(false)
			end

			local var_100_1 = 0
			local var_100_2 = 0.275

			if var_100_1 < arg_97_1.time_ and arg_97_1.time_ <= var_100_1 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				local var_100_3 = arg_97_1:FormatText(StoryNameCfg[6].name)

				arg_97_1.leftNameTxt_.text = var_100_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, true)
				arg_97_1.iconController_:SetSelectedState("hero")

				arg_97_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1184")

				arg_97_1.callingController_:SetSelectedState("normal")

				arg_97_1.keyicon_.color = Color.New(1, 1, 1)
				arg_97_1.icon_.color = Color.New(1, 1, 1)

				local var_100_4 = arg_97_1:GetWordFromCfg(120051024)
				local var_100_5 = arg_97_1:FormatText(var_100_4.content)

				arg_97_1.text_.text = var_100_5

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_6 = 11
				local var_100_7 = utf8.len(var_100_5)
				local var_100_8 = var_100_6 <= 0 and var_100_2 or var_100_2 * (var_100_7 / var_100_6)

				if var_100_8 > 0 and var_100_2 < var_100_8 then
					arg_97_1.talkMaxDuration = var_100_8

					if var_100_8 + var_100_1 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_8 + var_100_1
					end
				end

				arg_97_1.text_.text = var_100_5
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120051", "120051024", "story_v_out_120051.awb") ~= 0 then
					local var_100_9 = manager.audio:GetVoiceLength("story_v_out_120051", "120051024", "story_v_out_120051.awb") / 1000

					if var_100_9 + var_100_1 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_9 + var_100_1
					end

					if var_100_4.prefab_name ~= "" and arg_97_1.actors_[var_100_4.prefab_name] ~= nil then
						local var_100_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_4.prefab_name].transform, "story_v_out_120051", "120051024", "story_v_out_120051.awb")

						arg_97_1:RecordAudio("120051024", var_100_10)
						arg_97_1:RecordAudio("120051024", var_100_10)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_120051", "120051024", "story_v_out_120051.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_120051", "120051024", "story_v_out_120051.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_11 = math.max(var_100_2, arg_97_1.talkMaxDuration)

			if var_100_1 <= arg_97_1.time_ and arg_97_1.time_ < var_100_1 + var_100_11 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_1) / var_100_11

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_1 + var_100_11 and arg_97_1.time_ < var_100_1 + var_100_11 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play120051025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 120051025
		arg_101_1.duration_ = 5

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play120051026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = 0
			local var_104_1 = 0.2

			if var_104_0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_0 + arg_104_0 then
				local var_104_2 = "play"
				local var_104_3 = "music"

				arg_101_1:AudioAction(var_104_2, var_104_3, "ui_battle", "ui_battle_stopbgm", "")

				local var_104_4 = ""
				local var_104_5 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_104_5 ~= "" then
					if arg_101_1.bgmTxt_.text ~= var_104_5 and arg_101_1.bgmTxt_.text ~= "" then
						if arg_101_1.bgmTxt2_.text ~= "" then
							arg_101_1.bgmTxt_.text = arg_101_1.bgmTxt2_.text
						end

						arg_101_1.bgmTxt2_.text = var_104_5

						arg_101_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_101_1.bgmTxt_.text = var_104_5
						arg_101_1.bgmTxt2_.text = var_104_5
					end

					if arg_101_1.bgmTimer then
						arg_101_1.bgmTimer:Stop()

						arg_101_1.bgmTimer = nil
					end

					if arg_101_1.settingData.show_music_name == 1 then
						arg_101_1.musicController:SetSelectedState("show")
						arg_101_1.musicAnimator_:Play("open", 0, 0)

						if arg_101_1.settingData.music_time ~= 0 then
							arg_101_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_101_1.settingData.music_time), function()
								if arg_101_1 == nil or isNil(arg_101_1.bgmTxt_) then
									return
								end

								arg_101_1.musicController:SetSelectedState("hide")
								arg_101_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_104_6 = 0
			local var_104_7 = 0.15

			if var_104_6 < arg_101_1.time_ and arg_101_1.time_ <= var_104_6 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				local var_104_8 = arg_101_1:FormatText(StoryNameCfg[7].name)

				arg_101_1.leftNameTxt_.text = var_104_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, true)
				arg_101_1.iconController_:SetSelectedState("hero")

				arg_101_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_101_1.callingController_:SetSelectedState("normal")

				arg_101_1.keyicon_.color = Color.New(1, 1, 1)
				arg_101_1.icon_.color = Color.New(1, 1, 1)

				local var_104_9 = arg_101_1:GetWordFromCfg(120051025)
				local var_104_10 = arg_101_1:FormatText(var_104_9.content)

				arg_101_1.text_.text = var_104_10

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_11 = 6
				local var_104_12 = utf8.len(var_104_10)
				local var_104_13 = var_104_11 <= 0 and var_104_7 or var_104_7 * (var_104_12 / var_104_11)

				if var_104_13 > 0 and var_104_7 < var_104_13 then
					arg_101_1.talkMaxDuration = var_104_13

					if var_104_13 + var_104_6 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_13 + var_104_6
					end
				end

				arg_101_1.text_.text = var_104_10
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)
				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_14 = math.max(var_104_7, arg_101_1.talkMaxDuration)

			if var_104_6 <= arg_101_1.time_ and arg_101_1.time_ < var_104_6 + var_104_14 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_6) / var_104_14

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_6 + var_104_14 and arg_101_1.time_ < var_104_6 + var_104_14 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play120051026 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 120051026
		arg_106_1.duration_ = 0.02

		SetActive(arg_106_1.tipsGo_, false)

		function arg_106_1.onSingleLineFinish_()
			arg_106_1.onSingleLineUpdate_ = nil
			arg_106_1.onSingleLineFinish_ = nil
			arg_106_1.state_ = "waiting"

			SetActive(arg_106_1.choicesGo_, true)

			for iter_107_0, iter_107_1 in ipairs(arg_106_1.choices_) do
				local var_107_0 = iter_107_0 <= 2

				SetActive(iter_107_1.go, var_107_0)
			end

			arg_106_1.choices_[1].txt.text = arg_106_1:FormatText(StoryChoiceCfg[370].name)
			arg_106_1.choices_[2].txt.text = arg_106_1:FormatText(StoryChoiceCfg[371].name)
		end

		function arg_106_1.playNext_(arg_108_0)
			if arg_108_0 == 1 then
				arg_106_0:Play120051027(arg_106_1)
			end

			if arg_108_0 == 2 then
				arg_106_0:Play120051027(arg_106_1)
			end

			arg_106_1:RecordChoiceLog(120051026, 370, 371)
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			return
		end

		arg_106_1.nodeConfigList_ = {}

		arg_106_1:InitPlayNodeList()
	end,
	Play120051027 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 120051027
		arg_110_1.duration_ = 9

		SetActive(arg_110_1.tipsGo_, false)

		function arg_110_1.onSingleLineFinish_()
			arg_110_1.onSingleLineUpdate_ = nil
			arg_110_1.onSingleLineFinish_ = nil
			arg_110_1.state_ = "waiting"
		end

		function arg_110_1.playNext_(arg_112_0)
			if arg_112_0 == 1 then
				arg_110_0:Play120051028(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			local var_113_0 = "J03f"

			if arg_110_1.bgs_[var_113_0] == nil then
				local var_113_1 = Object.Instantiate(arg_110_1.paintGo_)

				var_113_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_113_0)
				var_113_1.name = var_113_0
				var_113_1.transform.parent = arg_110_1.stage_.transform
				var_113_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_110_1.bgs_[var_113_0] = var_113_1
			end

			local var_113_2 = 2

			if var_113_2 < arg_110_1.time_ and arg_110_1.time_ <= var_113_2 + arg_113_0 then
				local var_113_3 = manager.ui.mainCamera.transform.localPosition
				local var_113_4 = Vector3.New(0, 0, 10) + Vector3.New(var_113_3.x, var_113_3.y, 0)
				local var_113_5 = arg_110_1.bgs_.J03f

				var_113_5.transform.localPosition = var_113_4
				var_113_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_113_6 = var_113_5:GetComponent("SpriteRenderer")

				if var_113_6 and var_113_6.sprite then
					local var_113_7 = (var_113_5.transform.localPosition - var_113_3).z
					local var_113_8 = manager.ui.mainCameraCom_
					local var_113_9 = 2 * var_113_7 * Mathf.Tan(var_113_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_113_10 = var_113_9 * var_113_8.aspect
					local var_113_11 = var_113_6.sprite.bounds.size.x
					local var_113_12 = var_113_6.sprite.bounds.size.y
					local var_113_13 = var_113_10 / var_113_11
					local var_113_14 = var_113_9 / var_113_12
					local var_113_15 = var_113_14 < var_113_13 and var_113_13 or var_113_14

					var_113_5.transform.localScale = Vector3.New(var_113_15, var_113_15, 0)
				end

				for iter_113_0, iter_113_1 in pairs(arg_110_1.bgs_) do
					if iter_113_0 ~= "J03f" then
						iter_113_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_113_16 = 0

			if var_113_16 < arg_110_1.time_ and arg_110_1.time_ <= var_113_16 + arg_113_0 then
				arg_110_1.mask_.enabled = true
				arg_110_1.mask_.raycastTarget = true

				arg_110_1:SetGaussion(false)
			end

			local var_113_17 = 2

			if var_113_16 <= arg_110_1.time_ and arg_110_1.time_ < var_113_16 + var_113_17 then
				local var_113_18 = (arg_110_1.time_ - var_113_16) / var_113_17
				local var_113_19 = Color.New(0, 0, 0)

				var_113_19.a = Mathf.Lerp(0, 1, var_113_18)
				arg_110_1.mask_.color = var_113_19
			end

			if arg_110_1.time_ >= var_113_16 + var_113_17 and arg_110_1.time_ < var_113_16 + var_113_17 + arg_113_0 then
				local var_113_20 = Color.New(0, 0, 0)

				var_113_20.a = 1
				arg_110_1.mask_.color = var_113_20
			end

			local var_113_21 = 2

			if var_113_21 < arg_110_1.time_ and arg_110_1.time_ <= var_113_21 + arg_113_0 then
				arg_110_1.mask_.enabled = true
				arg_110_1.mask_.raycastTarget = true

				arg_110_1:SetGaussion(false)
			end

			local var_113_22 = 2

			if var_113_21 <= arg_110_1.time_ and arg_110_1.time_ < var_113_21 + var_113_22 then
				local var_113_23 = (arg_110_1.time_ - var_113_21) / var_113_22
				local var_113_24 = Color.New(0, 0, 0)

				var_113_24.a = Mathf.Lerp(1, 0, var_113_23)
				arg_110_1.mask_.color = var_113_24
			end

			if arg_110_1.time_ >= var_113_21 + var_113_22 and arg_110_1.time_ < var_113_21 + var_113_22 + arg_113_0 then
				local var_113_25 = Color.New(0, 0, 0)
				local var_113_26 = 0

				arg_110_1.mask_.enabled = false
				var_113_25.a = var_113_26
				arg_110_1.mask_.color = var_113_25
			end

			local var_113_27 = manager.ui.mainCamera.transform
			local var_113_28 = 4

			if var_113_28 < arg_110_1.time_ and arg_110_1.time_ <= var_113_28 + arg_113_0 then
				arg_110_1.var_.shakeOldPos = var_113_27.localPosition
			end

			local var_113_29 = 0.5

			if var_113_28 <= arg_110_1.time_ and arg_110_1.time_ < var_113_28 + var_113_29 then
				local var_113_30 = (arg_110_1.time_ - var_113_28) / 0.066
				local var_113_31, var_113_32 = math.modf(var_113_30)

				var_113_27.localPosition = Vector3.New(var_113_32 * 0.13, var_113_32 * 0.13, var_113_32 * 0.13) + arg_110_1.var_.shakeOldPos
			end

			if arg_110_1.time_ >= var_113_28 + var_113_29 and arg_110_1.time_ < var_113_28 + var_113_29 + arg_113_0 then
				var_113_27.localPosition = arg_110_1.var_.shakeOldPos
			end

			if arg_110_1.frameCnt_ <= 1 then
				arg_110_1.dialog_:SetActive(false)
			end

			local var_113_33 = 4
			local var_113_34 = 0.875

			if var_113_33 < arg_110_1.time_ and arg_110_1.time_ <= var_113_33 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0

				arg_110_1.dialog_:SetActive(true)

				arg_110_1.dialogCg_.alpha = 0

				local var_113_35 = LeanTween.value(arg_110_1.dialog_, 0, 1, 0.3)

				var_113_35:setOnUpdate(LuaHelper.FloatAction(function(arg_114_0)
					arg_110_1.dialogCg_.alpha = arg_114_0
				end))
				var_113_35:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_110_1.dialog_)
					var_113_35:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_110_1.duration_ = arg_110_1.duration_ + 0.3

				SetActive(arg_110_1.leftNameGo_, false)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_110_1.iconTrs_.gameObject, false)
				arg_110_1.callingController_:SetSelectedState("normal")

				local var_113_36 = arg_110_1:GetWordFromCfg(120051027)
				local var_113_37 = arg_110_1:FormatText(var_113_36.content)

				arg_110_1.text_.text = var_113_37

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_38 = 35
				local var_113_39 = utf8.len(var_113_37)
				local var_113_40 = var_113_38 <= 0 and var_113_34 or var_113_34 * (var_113_39 / var_113_38)

				if var_113_40 > 0 and var_113_34 < var_113_40 then
					arg_110_1.talkMaxDuration = var_113_40
					var_113_33 = var_113_33 + 0.3

					if var_113_40 + var_113_33 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_40 + var_113_33
					end
				end

				arg_110_1.text_.text = var_113_37
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)
				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_41 = var_113_33 + 0.3
			local var_113_42 = math.max(var_113_34, arg_110_1.talkMaxDuration)

			if var_113_41 <= arg_110_1.time_ and arg_110_1.time_ < var_113_41 + var_113_42 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - var_113_41) / var_113_42

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= var_113_41 + var_113_42 and arg_110_1.time_ < var_113_41 + var_113_42 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {}

		arg_110_1:InitPlayNodeList()
	end,
	Play120051028 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 120051028
		arg_116_1.duration_ = 5

		SetActive(arg_116_1.tipsGo_, false)

		function arg_116_1.onSingleLineFinish_()
			arg_116_1.onSingleLineUpdate_ = nil
			arg_116_1.onSingleLineFinish_ = nil
			arg_116_1.state_ = "waiting"
		end

		function arg_116_1.playNext_(arg_118_0)
			if arg_118_0 == 1 then
				arg_116_0:Play120051029(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			local var_119_0 = 0
			local var_119_1 = 0.175

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

				local var_119_3 = arg_116_1:GetWordFromCfg(120051028)
				local var_119_4 = arg_116_1:FormatText(var_119_3.content)

				arg_116_1.text_.text = var_119_4

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_5 = 7
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
	Play120051029 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 120051029
		arg_120_1.duration_ = 5

		SetActive(arg_120_1.tipsGo_, false)

		function arg_120_1.onSingleLineFinish_()
			arg_120_1.onSingleLineUpdate_ = nil
			arg_120_1.onSingleLineFinish_ = nil
			arg_120_1.state_ = "waiting"
		end

		function arg_120_1.playNext_(arg_122_0)
			if arg_122_0 == 1 then
				arg_120_0:Play120051030(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			local var_123_0 = 0
			local var_123_1 = 1.025

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

				local var_123_2 = arg_120_1:GetWordFromCfg(120051029)
				local var_123_3 = arg_120_1:FormatText(var_123_2.content)

				arg_120_1.text_.text = var_123_3

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_4 = 41
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
	Play120051030 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 120051030
		arg_124_1.duration_ = 5

		SetActive(arg_124_1.tipsGo_, false)

		function arg_124_1.onSingleLineFinish_()
			arg_124_1.onSingleLineUpdate_ = nil
			arg_124_1.onSingleLineFinish_ = nil
			arg_124_1.state_ = "waiting"
		end

		function arg_124_1.playNext_(arg_126_0)
			if arg_126_0 == 1 then
				arg_124_0:Play120051031(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			local var_127_0 = 0
			local var_127_1 = 0.0666666666666667

			if var_127_0 < arg_124_1.time_ and arg_124_1.time_ <= var_127_0 + arg_127_0 then
				local var_127_2 = "play"
				local var_127_3 = "music"

				arg_124_1:AudioAction(var_127_2, var_127_3, "ui_battle", "ui_battle_stopbgm", "")

				local var_127_4 = ""
				local var_127_5 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_127_5 ~= "" then
					if arg_124_1.bgmTxt_.text ~= var_127_5 and arg_124_1.bgmTxt_.text ~= "" then
						if arg_124_1.bgmTxt2_.text ~= "" then
							arg_124_1.bgmTxt_.text = arg_124_1.bgmTxt2_.text
						end

						arg_124_1.bgmTxt2_.text = var_127_5

						arg_124_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_124_1.bgmTxt_.text = var_127_5
						arg_124_1.bgmTxt2_.text = var_127_5
					end

					if arg_124_1.bgmTimer then
						arg_124_1.bgmTimer:Stop()

						arg_124_1.bgmTimer = nil
					end

					if arg_124_1.settingData.show_music_name == 1 then
						arg_124_1.musicController:SetSelectedState("show")
						arg_124_1.musicAnimator_:Play("open", 0, 0)

						if arg_124_1.settingData.music_time ~= 0 then
							arg_124_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_124_1.settingData.music_time), function()
								if arg_124_1 == nil or isNil(arg_124_1.bgmTxt_) then
									return
								end

								arg_124_1.musicController:SetSelectedState("hide")
								arg_124_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_127_6 = 0.1
			local var_127_7 = 1.075

			if var_127_6 < arg_124_1.time_ and arg_124_1.time_ <= var_127_6 + arg_127_0 then
				local var_127_8 = "play"
				local var_127_9 = "music"

				arg_124_1:AudioAction(var_127_8, var_127_9, "bgm_activity_2_0_story_jingdu", "bgm_activity_2_0_story_jingdu", "bgm_activity_2_0_story_jingdu.awb")

				local var_127_10 = ""
				local var_127_11 = manager.audio:GetAudioName("bgm_activity_2_0_story_jingdu", "bgm_activity_2_0_story_jingdu")

				if var_127_11 ~= "" then
					if arg_124_1.bgmTxt_.text ~= var_127_11 and arg_124_1.bgmTxt_.text ~= "" then
						if arg_124_1.bgmTxt2_.text ~= "" then
							arg_124_1.bgmTxt_.text = arg_124_1.bgmTxt2_.text
						end

						arg_124_1.bgmTxt2_.text = var_127_11

						arg_124_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_124_1.bgmTxt_.text = var_127_11
						arg_124_1.bgmTxt2_.text = var_127_11
					end

					if arg_124_1.bgmTimer then
						arg_124_1.bgmTimer:Stop()

						arg_124_1.bgmTimer = nil
					end

					if arg_124_1.settingData.show_music_name == 1 then
						arg_124_1.musicController:SetSelectedState("show")
						arg_124_1.musicAnimator_:Play("open", 0, 0)

						if arg_124_1.settingData.music_time ~= 0 then
							arg_124_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_124_1.settingData.music_time), function()
								if arg_124_1 == nil or isNil(arg_124_1.bgmTxt_) then
									return
								end

								arg_124_1.musicController:SetSelectedState("hide")
								arg_124_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_127_12 = 0
			local var_127_13 = 1.175

			if var_127_12 < arg_124_1.time_ and arg_124_1.time_ <= var_127_12 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, false)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_14 = arg_124_1:GetWordFromCfg(120051030)
				local var_127_15 = arg_124_1:FormatText(var_127_14.content)

				arg_124_1.text_.text = var_127_15

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_16 = 47
				local var_127_17 = utf8.len(var_127_15)
				local var_127_18 = var_127_16 <= 0 and var_127_13 or var_127_13 * (var_127_17 / var_127_16)

				if var_127_18 > 0 and var_127_13 < var_127_18 then
					arg_124_1.talkMaxDuration = var_127_18

					if var_127_18 + var_127_12 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_18 + var_127_12
					end
				end

				arg_124_1.text_.text = var_127_15
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)
				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_19 = math.max(var_127_13, arg_124_1.talkMaxDuration)

			if var_127_12 <= arg_124_1.time_ and arg_124_1.time_ < var_127_12 + var_127_19 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_12) / var_127_19

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_12 + var_127_19 and arg_124_1.time_ < var_127_12 + var_127_19 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {}

		arg_124_1:InitPlayNodeList()
	end,
	Play120051031 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 120051031
		arg_130_1.duration_ = 5

		SetActive(arg_130_1.tipsGo_, false)

		function arg_130_1.onSingleLineFinish_()
			arg_130_1.onSingleLineUpdate_ = nil
			arg_130_1.onSingleLineFinish_ = nil
			arg_130_1.state_ = "waiting"
		end

		function arg_130_1.playNext_(arg_132_0)
			if arg_132_0 == 1 then
				arg_130_0:Play120051032(arg_130_1)
			end
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			local var_133_0 = 0
			local var_133_1 = 0.825

			if var_133_0 < arg_130_1.time_ and arg_130_1.time_ <= var_133_0 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0
				arg_130_1.dialogCg_.alpha = 1

				arg_130_1.dialog_:SetActive(true)
				SetActive(arg_130_1.leftNameGo_, false)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_130_1.iconTrs_.gameObject, false)
				arg_130_1.callingController_:SetSelectedState("normal")

				local var_133_2 = arg_130_1:GetWordFromCfg(120051031)
				local var_133_3 = arg_130_1:FormatText(var_133_2.content)

				arg_130_1.text_.text = var_133_3

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_4 = 33
				local var_133_5 = utf8.len(var_133_3)
				local var_133_6 = var_133_4 <= 0 and var_133_1 or var_133_1 * (var_133_5 / var_133_4)

				if var_133_6 > 0 and var_133_1 < var_133_6 then
					arg_130_1.talkMaxDuration = var_133_6

					if var_133_6 + var_133_0 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_6 + var_133_0
					end
				end

				arg_130_1.text_.text = var_133_3
				arg_130_1.typewritter.percent = 0

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(false)
				arg_130_1:RecordContent(arg_130_1.text_.text)
			end

			local var_133_7 = math.max(var_133_1, arg_130_1.talkMaxDuration)

			if var_133_0 <= arg_130_1.time_ and arg_130_1.time_ < var_133_0 + var_133_7 then
				arg_130_1.typewritter.percent = (arg_130_1.time_ - var_133_0) / var_133_7

				arg_130_1.typewritter:SetDirty()
			end

			if arg_130_1.time_ >= var_133_0 + var_133_7 and arg_130_1.time_ < var_133_0 + var_133_7 + arg_133_0 then
				arg_130_1.typewritter.percent = 1

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(true)
			end
		end

		arg_130_1.nodeConfigList_ = {}

		arg_130_1:InitPlayNodeList()
	end,
	Play120051032 = function(arg_134_0, arg_134_1)
		arg_134_1.time_ = 0
		arg_134_1.frameCnt_ = 0
		arg_134_1.state_ = "playing"
		arg_134_1.curTalkId_ = 120051032
		arg_134_1.duration_ = 2.63

		SetActive(arg_134_1.tipsGo_, false)

		function arg_134_1.onSingleLineFinish_()
			arg_134_1.onSingleLineUpdate_ = nil
			arg_134_1.onSingleLineFinish_ = nil
			arg_134_1.state_ = "waiting"
		end

		function arg_134_1.playNext_(arg_136_0)
			if arg_136_0 == 1 then
				arg_134_0:Play120051033(arg_134_1)
			end
		end

		function arg_134_1.onSingleLineUpdate_(arg_137_0)
			local var_137_0 = "1069ui_story"

			if arg_134_1.actors_[var_137_0] == nil then
				local var_137_1 = Asset.Load("Char/" .. "1069ui_story")

				if not isNil(var_137_1) then
					local var_137_2 = Object.Instantiate(Asset.Load("Char/" .. "1069ui_story"), arg_134_1.stage_.transform)

					var_137_2.name = var_137_0
					var_137_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_134_1.actors_[var_137_0] = var_137_2

					local var_137_3 = var_137_2:GetComponentInChildren(typeof(CharacterEffect))

					var_137_3.enabled = true

					local var_137_4 = GameObjectTools.GetOrAddComponent(var_137_2, typeof(DynamicBoneHelper))

					if var_137_4 then
						var_137_4:EnableDynamicBone(false)
					end

					arg_134_1:ShowWeapon(var_137_3.transform, false)

					arg_134_1.var_[var_137_0 .. "Animator"] = var_137_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_134_1.var_[var_137_0 .. "Animator"].applyRootMotion = true
					arg_134_1.var_[var_137_0 .. "LipSync"] = var_137_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_137_5 = arg_134_1.actors_["1069ui_story"].transform
			local var_137_6 = 0

			if var_137_6 < arg_134_1.time_ and arg_134_1.time_ <= var_137_6 + arg_137_0 then
				arg_134_1.var_.moveOldPos1069ui_story = var_137_5.localPosition
			end

			local var_137_7 = 0.001

			if var_137_6 <= arg_134_1.time_ and arg_134_1.time_ < var_137_6 + var_137_7 then
				local var_137_8 = (arg_134_1.time_ - var_137_6) / var_137_7
				local var_137_9 = Vector3.New(-0.7, -1, -6)

				var_137_5.localPosition = Vector3.Lerp(arg_134_1.var_.moveOldPos1069ui_story, var_137_9, var_137_8)

				local var_137_10 = manager.ui.mainCamera.transform.position - var_137_5.position

				var_137_5.forward = Vector3.New(var_137_10.x, var_137_10.y, var_137_10.z)

				local var_137_11 = var_137_5.localEulerAngles

				var_137_11.z = 0
				var_137_11.x = 0
				var_137_5.localEulerAngles = var_137_11
			end

			if arg_134_1.time_ >= var_137_6 + var_137_7 and arg_134_1.time_ < var_137_6 + var_137_7 + arg_137_0 then
				var_137_5.localPosition = Vector3.New(-0.7, -1, -6)

				local var_137_12 = manager.ui.mainCamera.transform.position - var_137_5.position

				var_137_5.forward = Vector3.New(var_137_12.x, var_137_12.y, var_137_12.z)

				local var_137_13 = var_137_5.localEulerAngles

				var_137_13.z = 0
				var_137_13.x = 0
				var_137_5.localEulerAngles = var_137_13
			end

			local var_137_14 = arg_134_1.actors_["1069ui_story"]
			local var_137_15 = 0

			if var_137_15 < arg_134_1.time_ and arg_134_1.time_ <= var_137_15 + arg_137_0 and not isNil(var_137_14) and arg_134_1.var_.characterEffect1069ui_story == nil then
				arg_134_1.var_.characterEffect1069ui_story = var_137_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_137_16 = 0.2

			if var_137_15 <= arg_134_1.time_ and arg_134_1.time_ < var_137_15 + var_137_16 and not isNil(var_137_14) then
				local var_137_17 = (arg_134_1.time_ - var_137_15) / var_137_16

				if arg_134_1.var_.characterEffect1069ui_story and not isNil(var_137_14) then
					arg_134_1.var_.characterEffect1069ui_story.fillFlat = false
				end
			end

			if arg_134_1.time_ >= var_137_15 + var_137_16 and arg_134_1.time_ < var_137_15 + var_137_16 + arg_137_0 and not isNil(var_137_14) and arg_134_1.var_.characterEffect1069ui_story then
				arg_134_1.var_.characterEffect1069ui_story.fillFlat = false
			end

			local var_137_18 = arg_134_1.actors_["1075ui_story"].transform
			local var_137_19 = 0

			if var_137_19 < arg_134_1.time_ and arg_134_1.time_ <= var_137_19 + arg_137_0 then
				arg_134_1.var_.moveOldPos1075ui_story = var_137_18.localPosition
			end

			local var_137_20 = 0.001

			if var_137_19 <= arg_134_1.time_ and arg_134_1.time_ < var_137_19 + var_137_20 then
				local var_137_21 = (arg_134_1.time_ - var_137_19) / var_137_20
				local var_137_22 = Vector3.New(0.7, -1.055, -6.16)

				var_137_18.localPosition = Vector3.Lerp(arg_134_1.var_.moveOldPos1075ui_story, var_137_22, var_137_21)

				local var_137_23 = manager.ui.mainCamera.transform.position - var_137_18.position

				var_137_18.forward = Vector3.New(var_137_23.x, var_137_23.y, var_137_23.z)

				local var_137_24 = var_137_18.localEulerAngles

				var_137_24.z = 0
				var_137_24.x = 0
				var_137_18.localEulerAngles = var_137_24
			end

			if arg_134_1.time_ >= var_137_19 + var_137_20 and arg_134_1.time_ < var_137_19 + var_137_20 + arg_137_0 then
				var_137_18.localPosition = Vector3.New(0.7, -1.055, -6.16)

				local var_137_25 = manager.ui.mainCamera.transform.position - var_137_18.position

				var_137_18.forward = Vector3.New(var_137_25.x, var_137_25.y, var_137_25.z)

				local var_137_26 = var_137_18.localEulerAngles

				var_137_26.z = 0
				var_137_26.x = 0
				var_137_18.localEulerAngles = var_137_26
			end

			local var_137_27 = arg_134_1.actors_["1075ui_story"]
			local var_137_28 = 0

			if var_137_28 < arg_134_1.time_ and arg_134_1.time_ <= var_137_28 + arg_137_0 and not isNil(var_137_27) and arg_134_1.var_.characterEffect1075ui_story == nil then
				arg_134_1.var_.characterEffect1075ui_story = var_137_27:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_137_29 = 0.2

			if var_137_28 <= arg_134_1.time_ and arg_134_1.time_ < var_137_28 + var_137_29 and not isNil(var_137_27) then
				local var_137_30 = (arg_134_1.time_ - var_137_28) / var_137_29

				if arg_134_1.var_.characterEffect1075ui_story and not isNil(var_137_27) then
					local var_137_31 = Mathf.Lerp(0, 0.5, var_137_30)

					arg_134_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_134_1.var_.characterEffect1075ui_story.fillRatio = var_137_31
				end
			end

			if arg_134_1.time_ >= var_137_28 + var_137_29 and arg_134_1.time_ < var_137_28 + var_137_29 + arg_137_0 and not isNil(var_137_27) and arg_134_1.var_.characterEffect1075ui_story then
				local var_137_32 = 0.5

				arg_134_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_134_1.var_.characterEffect1075ui_story.fillRatio = var_137_32
			end

			local var_137_33 = 0

			if var_137_33 < arg_134_1.time_ and arg_134_1.time_ <= var_137_33 + arg_137_0 then
				arg_134_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/story1069/story1069action/1069action2_1")
			end

			local var_137_34 = 0

			if var_137_34 < arg_134_1.time_ and arg_134_1.time_ <= var_137_34 + arg_137_0 then
				arg_134_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_137_35 = 0

			if var_137_35 < arg_134_1.time_ and arg_134_1.time_ <= var_137_35 + arg_137_0 then
				arg_134_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action1_1")
			end

			local var_137_36 = 0
			local var_137_37 = 0.175

			if var_137_36 < arg_134_1.time_ and arg_134_1.time_ <= var_137_36 + arg_137_0 then
				arg_134_1.talkMaxDuration = 0
				arg_134_1.dialogCg_.alpha = 1

				arg_134_1.dialog_:SetActive(true)
				SetActive(arg_134_1.leftNameGo_, true)

				local var_137_38 = arg_134_1:FormatText(StoryNameCfg[378].name)

				arg_134_1.leftNameTxt_.text = var_137_38

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_134_1.leftNameTxt_.transform)

				arg_134_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_134_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_134_1:RecordName(arg_134_1.leftNameTxt_.text)
				SetActive(arg_134_1.iconTrs_.gameObject, false)
				arg_134_1.callingController_:SetSelectedState("normal")

				local var_137_39 = arg_134_1:GetWordFromCfg(120051032)
				local var_137_40 = arg_134_1:FormatText(var_137_39.content)

				arg_134_1.text_.text = var_137_40

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.text_)

				local var_137_41 = 7
				local var_137_42 = utf8.len(var_137_40)
				local var_137_43 = var_137_41 <= 0 and var_137_37 or var_137_37 * (var_137_42 / var_137_41)

				if var_137_43 > 0 and var_137_37 < var_137_43 then
					arg_134_1.talkMaxDuration = var_137_43

					if var_137_43 + var_137_36 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_43 + var_137_36
					end
				end

				arg_134_1.text_.text = var_137_40
				arg_134_1.typewritter.percent = 0

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120051", "120051032", "story_v_out_120051.awb") ~= 0 then
					local var_137_44 = manager.audio:GetVoiceLength("story_v_out_120051", "120051032", "story_v_out_120051.awb") / 1000

					if var_137_44 + var_137_36 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_44 + var_137_36
					end

					if var_137_39.prefab_name ~= "" and arg_134_1.actors_[var_137_39.prefab_name] ~= nil then
						local var_137_45 = LuaForUtil.PlayVoiceWithCriLipsync(arg_134_1.actors_[var_137_39.prefab_name].transform, "story_v_out_120051", "120051032", "story_v_out_120051.awb")

						arg_134_1:RecordAudio("120051032", var_137_45)
						arg_134_1:RecordAudio("120051032", var_137_45)
					else
						arg_134_1:AudioAction("play", "voice", "story_v_out_120051", "120051032", "story_v_out_120051.awb")
					end

					arg_134_1:RecordHistoryTalkVoice("story_v_out_120051", "120051032", "story_v_out_120051.awb")
				end

				arg_134_1:RecordContent(arg_134_1.text_.text)
			end

			local var_137_46 = math.max(var_137_37, arg_134_1.talkMaxDuration)

			if var_137_36 <= arg_134_1.time_ and arg_134_1.time_ < var_137_36 + var_137_46 then
				arg_134_1.typewritter.percent = (arg_134_1.time_ - var_137_36) / var_137_46

				arg_134_1.typewritter:SetDirty()
			end

			if arg_134_1.time_ >= var_137_36 + var_137_46 and arg_134_1.time_ < var_137_36 + var_137_46 + arg_137_0 then
				arg_134_1.typewritter.percent = 1

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(true)
			end
		end

		arg_134_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_134_1:InitPlayNodeList()
	end,
	Play120051033 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 120051033
		arg_138_1.duration_ = 10.6

		local var_138_0 = {
			zh = 8.033,
			ja = 10.6
		}
		local var_138_1 = manager.audio:GetLocalizationFlag()

		if var_138_0[var_138_1] ~= nil then
			arg_138_1.duration_ = var_138_0[var_138_1]
		end

		SetActive(arg_138_1.tipsGo_, false)

		function arg_138_1.onSingleLineFinish_()
			arg_138_1.onSingleLineUpdate_ = nil
			arg_138_1.onSingleLineFinish_ = nil
			arg_138_1.state_ = "waiting"
		end

		function arg_138_1.playNext_(arg_140_0)
			if arg_140_0 == 1 then
				arg_138_0:Play120051034(arg_138_1)
			end
		end

		function arg_138_1.onSingleLineUpdate_(arg_141_0)
			local var_141_0 = arg_138_1.actors_["1069ui_story"]
			local var_141_1 = 0

			if var_141_1 < arg_138_1.time_ and arg_138_1.time_ <= var_141_1 + arg_141_0 and not isNil(var_141_0) and arg_138_1.var_.characterEffect1069ui_story == nil then
				arg_138_1.var_.characterEffect1069ui_story = var_141_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_141_2 = 0.2

			if var_141_1 <= arg_138_1.time_ and arg_138_1.time_ < var_141_1 + var_141_2 and not isNil(var_141_0) then
				local var_141_3 = (arg_138_1.time_ - var_141_1) / var_141_2

				if arg_138_1.var_.characterEffect1069ui_story and not isNil(var_141_0) then
					local var_141_4 = Mathf.Lerp(0, 0.5, var_141_3)

					arg_138_1.var_.characterEffect1069ui_story.fillFlat = true
					arg_138_1.var_.characterEffect1069ui_story.fillRatio = var_141_4
				end
			end

			if arg_138_1.time_ >= var_141_1 + var_141_2 and arg_138_1.time_ < var_141_1 + var_141_2 + arg_141_0 and not isNil(var_141_0) and arg_138_1.var_.characterEffect1069ui_story then
				local var_141_5 = 0.5

				arg_138_1.var_.characterEffect1069ui_story.fillFlat = true
				arg_138_1.var_.characterEffect1069ui_story.fillRatio = var_141_5
			end

			local var_141_6 = arg_138_1.actors_["1075ui_story"]
			local var_141_7 = 0

			if var_141_7 < arg_138_1.time_ and arg_138_1.time_ <= var_141_7 + arg_141_0 and not isNil(var_141_6) and arg_138_1.var_.characterEffect1075ui_story == nil then
				arg_138_1.var_.characterEffect1075ui_story = var_141_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_141_8 = 0.2

			if var_141_7 <= arg_138_1.time_ and arg_138_1.time_ < var_141_7 + var_141_8 and not isNil(var_141_6) then
				local var_141_9 = (arg_138_1.time_ - var_141_7) / var_141_8

				if arg_138_1.var_.characterEffect1075ui_story and not isNil(var_141_6) then
					arg_138_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_138_1.time_ >= var_141_7 + var_141_8 and arg_138_1.time_ < var_141_7 + var_141_8 + arg_141_0 and not isNil(var_141_6) and arg_138_1.var_.characterEffect1075ui_story then
				arg_138_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_141_10 = 0

			if var_141_10 < arg_138_1.time_ and arg_138_1.time_ <= var_141_10 + arg_141_0 then
				arg_138_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action5_1")
			end

			local var_141_11 = 0

			if var_141_11 < arg_138_1.time_ and arg_138_1.time_ <= var_141_11 + arg_141_0 then
				arg_138_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_141_12 = 0
			local var_141_13 = 0.775

			if var_141_12 < arg_138_1.time_ and arg_138_1.time_ <= var_141_12 + arg_141_0 then
				arg_138_1.talkMaxDuration = 0
				arg_138_1.dialogCg_.alpha = 1

				arg_138_1.dialog_:SetActive(true)
				SetActive(arg_138_1.leftNameGo_, true)

				local var_141_14 = arg_138_1:FormatText(StoryNameCfg[381].name)

				arg_138_1.leftNameTxt_.text = var_141_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_138_1.leftNameTxt_.transform)

				arg_138_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_138_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_138_1:RecordName(arg_138_1.leftNameTxt_.text)
				SetActive(arg_138_1.iconTrs_.gameObject, false)
				arg_138_1.callingController_:SetSelectedState("normal")

				local var_141_15 = arg_138_1:GetWordFromCfg(120051033)
				local var_141_16 = arg_138_1:FormatText(var_141_15.content)

				arg_138_1.text_.text = var_141_16

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.text_)

				local var_141_17 = 31
				local var_141_18 = utf8.len(var_141_16)
				local var_141_19 = var_141_17 <= 0 and var_141_13 or var_141_13 * (var_141_18 / var_141_17)

				if var_141_19 > 0 and var_141_13 < var_141_19 then
					arg_138_1.talkMaxDuration = var_141_19

					if var_141_19 + var_141_12 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_19 + var_141_12
					end
				end

				arg_138_1.text_.text = var_141_16
				arg_138_1.typewritter.percent = 0

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120051", "120051033", "story_v_out_120051.awb") ~= 0 then
					local var_141_20 = manager.audio:GetVoiceLength("story_v_out_120051", "120051033", "story_v_out_120051.awb") / 1000

					if var_141_20 + var_141_12 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_20 + var_141_12
					end

					if var_141_15.prefab_name ~= "" and arg_138_1.actors_[var_141_15.prefab_name] ~= nil then
						local var_141_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_138_1.actors_[var_141_15.prefab_name].transform, "story_v_out_120051", "120051033", "story_v_out_120051.awb")

						arg_138_1:RecordAudio("120051033", var_141_21)
						arg_138_1:RecordAudio("120051033", var_141_21)
					else
						arg_138_1:AudioAction("play", "voice", "story_v_out_120051", "120051033", "story_v_out_120051.awb")
					end

					arg_138_1:RecordHistoryTalkVoice("story_v_out_120051", "120051033", "story_v_out_120051.awb")
				end

				arg_138_1:RecordContent(arg_138_1.text_.text)
			end

			local var_141_22 = math.max(var_141_13, arg_138_1.talkMaxDuration)

			if var_141_12 <= arg_138_1.time_ and arg_138_1.time_ < var_141_12 + var_141_22 then
				arg_138_1.typewritter.percent = (arg_138_1.time_ - var_141_12) / var_141_22

				arg_138_1.typewritter:SetDirty()
			end

			if arg_138_1.time_ >= var_141_12 + var_141_22 and arg_138_1.time_ < var_141_12 + var_141_22 + arg_141_0 then
				arg_138_1.typewritter.percent = 1

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(true)
			end
		end

		arg_138_1.nodeConfigList_ = {}

		arg_138_1:InitPlayNodeList()
	end,
	Play120051034 = function(arg_142_0, arg_142_1)
		arg_142_1.time_ = 0
		arg_142_1.frameCnt_ = 0
		arg_142_1.state_ = "playing"
		arg_142_1.curTalkId_ = 120051034
		arg_142_1.duration_ = 5.1

		local var_142_0 = {
			zh = 5.1,
			ja = 3.2
		}
		local var_142_1 = manager.audio:GetLocalizationFlag()

		if var_142_0[var_142_1] ~= nil then
			arg_142_1.duration_ = var_142_0[var_142_1]
		end

		SetActive(arg_142_1.tipsGo_, false)

		function arg_142_1.onSingleLineFinish_()
			arg_142_1.onSingleLineUpdate_ = nil
			arg_142_1.onSingleLineFinish_ = nil
			arg_142_1.state_ = "waiting"
		end

		function arg_142_1.playNext_(arg_144_0)
			if arg_144_0 == 1 then
				arg_142_0:Play120051035(arg_142_1)
			end
		end

		function arg_142_1.onSingleLineUpdate_(arg_145_0)
			local var_145_0 = 0
			local var_145_1 = 0.4

			if var_145_0 < arg_142_1.time_ and arg_142_1.time_ <= var_145_0 + arg_145_0 then
				arg_142_1.talkMaxDuration = 0
				arg_142_1.dialogCg_.alpha = 1

				arg_142_1.dialog_:SetActive(true)
				SetActive(arg_142_1.leftNameGo_, true)

				local var_145_2 = arg_142_1:FormatText(StoryNameCfg[381].name)

				arg_142_1.leftNameTxt_.text = var_145_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_142_1.leftNameTxt_.transform)

				arg_142_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_142_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_142_1:RecordName(arg_142_1.leftNameTxt_.text)
				SetActive(arg_142_1.iconTrs_.gameObject, false)
				arg_142_1.callingController_:SetSelectedState("normal")

				local var_145_3 = arg_142_1:GetWordFromCfg(120051034)
				local var_145_4 = arg_142_1:FormatText(var_145_3.content)

				arg_142_1.text_.text = var_145_4

				LuaForUtil.ClearLinePrefixSymbol(arg_142_1.text_)

				local var_145_5 = 16
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

				if manager.audio:GetVoiceLength("story_v_out_120051", "120051034", "story_v_out_120051.awb") ~= 0 then
					local var_145_8 = manager.audio:GetVoiceLength("story_v_out_120051", "120051034", "story_v_out_120051.awb") / 1000

					if var_145_8 + var_145_0 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_8 + var_145_0
					end

					if var_145_3.prefab_name ~= "" and arg_142_1.actors_[var_145_3.prefab_name] ~= nil then
						local var_145_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_142_1.actors_[var_145_3.prefab_name].transform, "story_v_out_120051", "120051034", "story_v_out_120051.awb")

						arg_142_1:RecordAudio("120051034", var_145_9)
						arg_142_1:RecordAudio("120051034", var_145_9)
					else
						arg_142_1:AudioAction("play", "voice", "story_v_out_120051", "120051034", "story_v_out_120051.awb")
					end

					arg_142_1:RecordHistoryTalkVoice("story_v_out_120051", "120051034", "story_v_out_120051.awb")
				end

				arg_142_1:RecordContent(arg_142_1.text_.text)
			end

			local var_145_10 = math.max(var_145_1, arg_142_1.talkMaxDuration)

			if var_145_0 <= arg_142_1.time_ and arg_142_1.time_ < var_145_0 + var_145_10 then
				arg_142_1.typewritter.percent = (arg_142_1.time_ - var_145_0) / var_145_10

				arg_142_1.typewritter:SetDirty()
			end

			if arg_142_1.time_ >= var_145_0 + var_145_10 and arg_142_1.time_ < var_145_0 + var_145_10 + arg_145_0 then
				arg_142_1.typewritter.percent = 1

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(true)
			end
		end

		arg_142_1.nodeConfigList_ = {}

		arg_142_1:InitPlayNodeList()
	end,
	Play120051035 = function(arg_146_0, arg_146_1)
		arg_146_1.time_ = 0
		arg_146_1.frameCnt_ = 0
		arg_146_1.state_ = "playing"
		arg_146_1.curTalkId_ = 120051035
		arg_146_1.duration_ = 5

		SetActive(arg_146_1.tipsGo_, false)

		function arg_146_1.onSingleLineFinish_()
			arg_146_1.onSingleLineUpdate_ = nil
			arg_146_1.onSingleLineFinish_ = nil
			arg_146_1.state_ = "waiting"
		end

		function arg_146_1.playNext_(arg_148_0)
			if arg_148_0 == 1 then
				arg_146_0:Play120051036(arg_146_1)
			end
		end

		function arg_146_1.onSingleLineUpdate_(arg_149_0)
			local var_149_0 = arg_146_1.actors_["1069ui_story"].transform
			local var_149_1 = 0

			if var_149_1 < arg_146_1.time_ and arg_146_1.time_ <= var_149_1 + arg_149_0 then
				arg_146_1.var_.moveOldPos1069ui_story = var_149_0.localPosition
			end

			local var_149_2 = 0.001

			if var_149_1 <= arg_146_1.time_ and arg_146_1.time_ < var_149_1 + var_149_2 then
				local var_149_3 = (arg_146_1.time_ - var_149_1) / var_149_2
				local var_149_4 = Vector3.New(0, 100, 0)

				var_149_0.localPosition = Vector3.Lerp(arg_146_1.var_.moveOldPos1069ui_story, var_149_4, var_149_3)

				local var_149_5 = manager.ui.mainCamera.transform.position - var_149_0.position

				var_149_0.forward = Vector3.New(var_149_5.x, var_149_5.y, var_149_5.z)

				local var_149_6 = var_149_0.localEulerAngles

				var_149_6.z = 0
				var_149_6.x = 0
				var_149_0.localEulerAngles = var_149_6
			end

			if arg_146_1.time_ >= var_149_1 + var_149_2 and arg_146_1.time_ < var_149_1 + var_149_2 + arg_149_0 then
				var_149_0.localPosition = Vector3.New(0, 100, 0)

				local var_149_7 = manager.ui.mainCamera.transform.position - var_149_0.position

				var_149_0.forward = Vector3.New(var_149_7.x, var_149_7.y, var_149_7.z)

				local var_149_8 = var_149_0.localEulerAngles

				var_149_8.z = 0
				var_149_8.x = 0
				var_149_0.localEulerAngles = var_149_8
			end

			local var_149_9 = arg_146_1.actors_["1075ui_story"].transform
			local var_149_10 = 0

			if var_149_10 < arg_146_1.time_ and arg_146_1.time_ <= var_149_10 + arg_149_0 then
				arg_146_1.var_.moveOldPos1075ui_story = var_149_9.localPosition
			end

			local var_149_11 = 0.001

			if var_149_10 <= arg_146_1.time_ and arg_146_1.time_ < var_149_10 + var_149_11 then
				local var_149_12 = (arg_146_1.time_ - var_149_10) / var_149_11
				local var_149_13 = Vector3.New(0, 100, 0)

				var_149_9.localPosition = Vector3.Lerp(arg_146_1.var_.moveOldPos1075ui_story, var_149_13, var_149_12)

				local var_149_14 = manager.ui.mainCamera.transform.position - var_149_9.position

				var_149_9.forward = Vector3.New(var_149_14.x, var_149_14.y, var_149_14.z)

				local var_149_15 = var_149_9.localEulerAngles

				var_149_15.z = 0
				var_149_15.x = 0
				var_149_9.localEulerAngles = var_149_15
			end

			if arg_146_1.time_ >= var_149_10 + var_149_11 and arg_146_1.time_ < var_149_10 + var_149_11 + arg_149_0 then
				var_149_9.localPosition = Vector3.New(0, 100, 0)

				local var_149_16 = manager.ui.mainCamera.transform.position - var_149_9.position

				var_149_9.forward = Vector3.New(var_149_16.x, var_149_16.y, var_149_16.z)

				local var_149_17 = var_149_9.localEulerAngles

				var_149_17.z = 0
				var_149_17.x = 0
				var_149_9.localEulerAngles = var_149_17
			end

			local var_149_18 = 0
			local var_149_19 = 1.275

			if var_149_18 < arg_146_1.time_ and arg_146_1.time_ <= var_149_18 + arg_149_0 then
				arg_146_1.talkMaxDuration = 0
				arg_146_1.dialogCg_.alpha = 1

				arg_146_1.dialog_:SetActive(true)
				SetActive(arg_146_1.leftNameGo_, false)

				arg_146_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_146_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_146_1:RecordName(arg_146_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_146_1.iconTrs_.gameObject, false)
				arg_146_1.callingController_:SetSelectedState("normal")

				local var_149_20 = arg_146_1:GetWordFromCfg(120051035)
				local var_149_21 = arg_146_1:FormatText(var_149_20.content)

				arg_146_1.text_.text = var_149_21

				LuaForUtil.ClearLinePrefixSymbol(arg_146_1.text_)

				local var_149_22 = 51
				local var_149_23 = utf8.len(var_149_21)
				local var_149_24 = var_149_22 <= 0 and var_149_19 or var_149_19 * (var_149_23 / var_149_22)

				if var_149_24 > 0 and var_149_19 < var_149_24 then
					arg_146_1.talkMaxDuration = var_149_24

					if var_149_24 + var_149_18 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_24 + var_149_18
					end
				end

				arg_146_1.text_.text = var_149_21
				arg_146_1.typewritter.percent = 0

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(false)
				arg_146_1:RecordContent(arg_146_1.text_.text)
			end

			local var_149_25 = math.max(var_149_19, arg_146_1.talkMaxDuration)

			if var_149_18 <= arg_146_1.time_ and arg_146_1.time_ < var_149_18 + var_149_25 then
				arg_146_1.typewritter.percent = (arg_146_1.time_ - var_149_18) / var_149_25

				arg_146_1.typewritter:SetDirty()
			end

			if arg_146_1.time_ >= var_149_18 + var_149_25 and arg_146_1.time_ < var_149_18 + var_149_25 + arg_149_0 then
				arg_146_1.typewritter.percent = 1

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(true)
			end
		end

		arg_146_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_146_1:InitPlayNodeList()
	end,
	Play120051036 = function(arg_150_0, arg_150_1)
		arg_150_1.time_ = 0
		arg_150_1.frameCnt_ = 0
		arg_150_1.state_ = "playing"
		arg_150_1.curTalkId_ = 120051036
		arg_150_1.duration_ = 5

		SetActive(arg_150_1.tipsGo_, false)

		function arg_150_1.onSingleLineFinish_()
			arg_150_1.onSingleLineUpdate_ = nil
			arg_150_1.onSingleLineFinish_ = nil
			arg_150_1.state_ = "waiting"
		end

		function arg_150_1.playNext_(arg_152_0)
			if arg_152_0 == 1 then
				arg_150_0:Play120051037(arg_150_1)
			end
		end

		function arg_150_1.onSingleLineUpdate_(arg_153_0)
			local var_153_0 = 0

			if var_153_0 < arg_150_1.time_ and arg_150_1.time_ <= var_153_0 + arg_153_0 then
				arg_150_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_153_1 = 0
			local var_153_2 = 0.775

			if var_153_1 < arg_150_1.time_ and arg_150_1.time_ <= var_153_1 + arg_153_0 then
				arg_150_1.talkMaxDuration = 0
				arg_150_1.dialogCg_.alpha = 1

				arg_150_1.dialog_:SetActive(true)
				SetActive(arg_150_1.leftNameGo_, false)

				arg_150_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_150_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_150_1:RecordName(arg_150_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_150_1.iconTrs_.gameObject, false)
				arg_150_1.callingController_:SetSelectedState("normal")

				local var_153_3 = arg_150_1:GetWordFromCfg(120051036)
				local var_153_4 = arg_150_1:FormatText(var_153_3.content)

				arg_150_1.text_.text = var_153_4

				LuaForUtil.ClearLinePrefixSymbol(arg_150_1.text_)

				local var_153_5 = 31
				local var_153_6 = utf8.len(var_153_4)
				local var_153_7 = var_153_5 <= 0 and var_153_2 or var_153_2 * (var_153_6 / var_153_5)

				if var_153_7 > 0 and var_153_2 < var_153_7 then
					arg_150_1.talkMaxDuration = var_153_7

					if var_153_7 + var_153_1 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_7 + var_153_1
					end
				end

				arg_150_1.text_.text = var_153_4
				arg_150_1.typewritter.percent = 0

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(false)
				arg_150_1:RecordContent(arg_150_1.text_.text)
			end

			local var_153_8 = math.max(var_153_2, arg_150_1.talkMaxDuration)

			if var_153_1 <= arg_150_1.time_ and arg_150_1.time_ < var_153_1 + var_153_8 then
				arg_150_1.typewritter.percent = (arg_150_1.time_ - var_153_1) / var_153_8

				arg_150_1.typewritter:SetDirty()
			end

			if arg_150_1.time_ >= var_153_1 + var_153_8 and arg_150_1.time_ < var_153_1 + var_153_8 + arg_153_0 then
				arg_150_1.typewritter.percent = 1

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(true)
			end
		end

		arg_150_1.nodeConfigList_ = {}

		arg_150_1:InitPlayNodeList()
	end,
	Play120051037 = function(arg_154_0, arg_154_1)
		arg_154_1.time_ = 0
		arg_154_1.frameCnt_ = 0
		arg_154_1.state_ = "playing"
		arg_154_1.curTalkId_ = 120051037
		arg_154_1.duration_ = 9.67

		local var_154_0 = {
			zh = 6.9,
			ja = 9.666
		}
		local var_154_1 = manager.audio:GetLocalizationFlag()

		if var_154_0[var_154_1] ~= nil then
			arg_154_1.duration_ = var_154_0[var_154_1]
		end

		SetActive(arg_154_1.tipsGo_, false)

		function arg_154_1.onSingleLineFinish_()
			arg_154_1.onSingleLineUpdate_ = nil
			arg_154_1.onSingleLineFinish_ = nil
			arg_154_1.state_ = "waiting"
		end

		function arg_154_1.playNext_(arg_156_0)
			if arg_156_0 == 1 then
				arg_154_0:Play120051038(arg_154_1)
			end
		end

		function arg_154_1.onSingleLineUpdate_(arg_157_0)
			local var_157_0 = arg_154_1.actors_["1071ui_story"].transform
			local var_157_1 = 0

			if var_157_1 < arg_154_1.time_ and arg_154_1.time_ <= var_157_1 + arg_157_0 then
				arg_154_1.var_.moveOldPos1071ui_story = var_157_0.localPosition
			end

			local var_157_2 = 0.001

			if var_157_1 <= arg_154_1.time_ and arg_154_1.time_ < var_157_1 + var_157_2 then
				local var_157_3 = (arg_154_1.time_ - var_157_1) / var_157_2
				local var_157_4 = Vector3.New(0, -1.05, -6.2)

				var_157_0.localPosition = Vector3.Lerp(arg_154_1.var_.moveOldPos1071ui_story, var_157_4, var_157_3)

				local var_157_5 = manager.ui.mainCamera.transform.position - var_157_0.position

				var_157_0.forward = Vector3.New(var_157_5.x, var_157_5.y, var_157_5.z)

				local var_157_6 = var_157_0.localEulerAngles

				var_157_6.z = 0
				var_157_6.x = 0
				var_157_0.localEulerAngles = var_157_6
			end

			if arg_154_1.time_ >= var_157_1 + var_157_2 and arg_154_1.time_ < var_157_1 + var_157_2 + arg_157_0 then
				var_157_0.localPosition = Vector3.New(0, -1.05, -6.2)

				local var_157_7 = manager.ui.mainCamera.transform.position - var_157_0.position

				var_157_0.forward = Vector3.New(var_157_7.x, var_157_7.y, var_157_7.z)

				local var_157_8 = var_157_0.localEulerAngles

				var_157_8.z = 0
				var_157_8.x = 0
				var_157_0.localEulerAngles = var_157_8
			end

			local var_157_9 = arg_154_1.actors_["1071ui_story"]
			local var_157_10 = 0

			if var_157_10 < arg_154_1.time_ and arg_154_1.time_ <= var_157_10 + arg_157_0 and not isNil(var_157_9) and arg_154_1.var_.characterEffect1071ui_story == nil then
				arg_154_1.var_.characterEffect1071ui_story = var_157_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_157_11 = 0.2

			if var_157_10 <= arg_154_1.time_ and arg_154_1.time_ < var_157_10 + var_157_11 and not isNil(var_157_9) then
				local var_157_12 = (arg_154_1.time_ - var_157_10) / var_157_11

				if arg_154_1.var_.characterEffect1071ui_story and not isNil(var_157_9) then
					arg_154_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_154_1.time_ >= var_157_10 + var_157_11 and arg_154_1.time_ < var_157_10 + var_157_11 + arg_157_0 and not isNil(var_157_9) and arg_154_1.var_.characterEffect1071ui_story then
				arg_154_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_157_13 = 0

			if var_157_13 < arg_154_1.time_ and arg_154_1.time_ <= var_157_13 + arg_157_0 then
				arg_154_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action3_1")
			end

			local var_157_14 = 0
			local var_157_15 = 1

			if var_157_14 < arg_154_1.time_ and arg_154_1.time_ <= var_157_14 + arg_157_0 then
				arg_154_1.talkMaxDuration = 0
				arg_154_1.dialogCg_.alpha = 1

				arg_154_1.dialog_:SetActive(true)
				SetActive(arg_154_1.leftNameGo_, true)

				local var_157_16 = arg_154_1:FormatText(StoryNameCfg[384].name)

				arg_154_1.leftNameTxt_.text = var_157_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_154_1.leftNameTxt_.transform)

				arg_154_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_154_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_154_1:RecordName(arg_154_1.leftNameTxt_.text)
				SetActive(arg_154_1.iconTrs_.gameObject, false)
				arg_154_1.callingController_:SetSelectedState("normal")

				local var_157_17 = arg_154_1:GetWordFromCfg(120051037)
				local var_157_18 = arg_154_1:FormatText(var_157_17.content)

				arg_154_1.text_.text = var_157_18

				LuaForUtil.ClearLinePrefixSymbol(arg_154_1.text_)

				local var_157_19 = 42
				local var_157_20 = utf8.len(var_157_18)
				local var_157_21 = var_157_19 <= 0 and var_157_15 or var_157_15 * (var_157_20 / var_157_19)

				if var_157_21 > 0 and var_157_15 < var_157_21 then
					arg_154_1.talkMaxDuration = var_157_21

					if var_157_21 + var_157_14 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_21 + var_157_14
					end
				end

				arg_154_1.text_.text = var_157_18
				arg_154_1.typewritter.percent = 0

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120051", "120051037", "story_v_out_120051.awb") ~= 0 then
					local var_157_22 = manager.audio:GetVoiceLength("story_v_out_120051", "120051037", "story_v_out_120051.awb") / 1000

					if var_157_22 + var_157_14 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_22 + var_157_14
					end

					if var_157_17.prefab_name ~= "" and arg_154_1.actors_[var_157_17.prefab_name] ~= nil then
						local var_157_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_154_1.actors_[var_157_17.prefab_name].transform, "story_v_out_120051", "120051037", "story_v_out_120051.awb")

						arg_154_1:RecordAudio("120051037", var_157_23)
						arg_154_1:RecordAudio("120051037", var_157_23)
					else
						arg_154_1:AudioAction("play", "voice", "story_v_out_120051", "120051037", "story_v_out_120051.awb")
					end

					arg_154_1:RecordHistoryTalkVoice("story_v_out_120051", "120051037", "story_v_out_120051.awb")
				end

				arg_154_1:RecordContent(arg_154_1.text_.text)
			end

			local var_157_24 = math.max(var_157_15, arg_154_1.talkMaxDuration)

			if var_157_14 <= arg_154_1.time_ and arg_154_1.time_ < var_157_14 + var_157_24 then
				arg_154_1.typewritter.percent = (arg_154_1.time_ - var_157_14) / var_157_24

				arg_154_1.typewritter:SetDirty()
			end

			if arg_154_1.time_ >= var_157_14 + var_157_24 and arg_154_1.time_ < var_157_14 + var_157_24 + arg_157_0 then
				arg_154_1.typewritter.percent = 1

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(true)
			end
		end

		arg_154_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_154_1:InitPlayNodeList()
	end,
	Play120051038 = function(arg_158_0, arg_158_1)
		arg_158_1.time_ = 0
		arg_158_1.frameCnt_ = 0
		arg_158_1.state_ = "playing"
		arg_158_1.curTalkId_ = 120051038
		arg_158_1.duration_ = 5

		SetActive(arg_158_1.tipsGo_, false)

		function arg_158_1.onSingleLineFinish_()
			arg_158_1.onSingleLineUpdate_ = nil
			arg_158_1.onSingleLineFinish_ = nil
			arg_158_1.state_ = "waiting"
		end

		function arg_158_1.playNext_(arg_160_0)
			if arg_160_0 == 1 then
				arg_158_0:Play120051039(arg_158_1)
			end
		end

		function arg_158_1.onSingleLineUpdate_(arg_161_0)
			local var_161_0 = arg_158_1.actors_["1071ui_story"]
			local var_161_1 = 0

			if var_161_1 < arg_158_1.time_ and arg_158_1.time_ <= var_161_1 + arg_161_0 and not isNil(var_161_0) and arg_158_1.var_.characterEffect1071ui_story == nil then
				arg_158_1.var_.characterEffect1071ui_story = var_161_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_161_2 = 0.2

			if var_161_1 <= arg_158_1.time_ and arg_158_1.time_ < var_161_1 + var_161_2 and not isNil(var_161_0) then
				local var_161_3 = (arg_158_1.time_ - var_161_1) / var_161_2

				if arg_158_1.var_.characterEffect1071ui_story and not isNil(var_161_0) then
					local var_161_4 = Mathf.Lerp(0, 0.5, var_161_3)

					arg_158_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_158_1.var_.characterEffect1071ui_story.fillRatio = var_161_4
				end
			end

			if arg_158_1.time_ >= var_161_1 + var_161_2 and arg_158_1.time_ < var_161_1 + var_161_2 + arg_161_0 and not isNil(var_161_0) and arg_158_1.var_.characterEffect1071ui_story then
				local var_161_5 = 0.5

				arg_158_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_158_1.var_.characterEffect1071ui_story.fillRatio = var_161_5
			end

			local var_161_6 = 0
			local var_161_7 = 0.525

			if var_161_6 < arg_158_1.time_ and arg_158_1.time_ <= var_161_6 + arg_161_0 then
				arg_158_1.talkMaxDuration = 0
				arg_158_1.dialogCg_.alpha = 1

				arg_158_1.dialog_:SetActive(true)
				SetActive(arg_158_1.leftNameGo_, true)

				local var_161_8 = arg_158_1:FormatText(StoryNameCfg[7].name)

				arg_158_1.leftNameTxt_.text = var_161_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_158_1.leftNameTxt_.transform)

				arg_158_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_158_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_158_1:RecordName(arg_158_1.leftNameTxt_.text)
				SetActive(arg_158_1.iconTrs_.gameObject, true)
				arg_158_1.iconController_:SetSelectedState("hero")

				arg_158_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_158_1.callingController_:SetSelectedState("normal")

				arg_158_1.keyicon_.color = Color.New(1, 1, 1)
				arg_158_1.icon_.color = Color.New(1, 1, 1)

				local var_161_9 = arg_158_1:GetWordFromCfg(120051038)
				local var_161_10 = arg_158_1:FormatText(var_161_9.content)

				arg_158_1.text_.text = var_161_10

				LuaForUtil.ClearLinePrefixSymbol(arg_158_1.text_)

				local var_161_11 = 21
				local var_161_12 = utf8.len(var_161_10)
				local var_161_13 = var_161_11 <= 0 and var_161_7 or var_161_7 * (var_161_12 / var_161_11)

				if var_161_13 > 0 and var_161_7 < var_161_13 then
					arg_158_1.talkMaxDuration = var_161_13

					if var_161_13 + var_161_6 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_13 + var_161_6
					end
				end

				arg_158_1.text_.text = var_161_10
				arg_158_1.typewritter.percent = 0

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(false)
				arg_158_1:RecordContent(arg_158_1.text_.text)
			end

			local var_161_14 = math.max(var_161_7, arg_158_1.talkMaxDuration)

			if var_161_6 <= arg_158_1.time_ and arg_158_1.time_ < var_161_6 + var_161_14 then
				arg_158_1.typewritter.percent = (arg_158_1.time_ - var_161_6) / var_161_14

				arg_158_1.typewritter:SetDirty()
			end

			if arg_158_1.time_ >= var_161_6 + var_161_14 and arg_158_1.time_ < var_161_6 + var_161_14 + arg_161_0 then
				arg_158_1.typewritter.percent = 1

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(true)
			end
		end

		arg_158_1.nodeConfigList_ = {}

		arg_158_1:InitPlayNodeList()
	end,
	Play120051039 = function(arg_162_0, arg_162_1)
		arg_162_1.time_ = 0
		arg_162_1.frameCnt_ = 0
		arg_162_1.state_ = "playing"
		arg_162_1.curTalkId_ = 120051039
		arg_162_1.duration_ = 2.6

		SetActive(arg_162_1.tipsGo_, false)

		function arg_162_1.onSingleLineFinish_()
			arg_162_1.onSingleLineUpdate_ = nil
			arg_162_1.onSingleLineFinish_ = nil
			arg_162_1.state_ = "waiting"
		end

		function arg_162_1.playNext_(arg_164_0)
			if arg_164_0 == 1 then
				arg_162_0:Play120051040(arg_162_1)
			end
		end

		function arg_162_1.onSingleLineUpdate_(arg_165_0)
			local var_165_0 = arg_162_1.actors_["1075ui_story"].transform
			local var_165_1 = 0

			if var_165_1 < arg_162_1.time_ and arg_162_1.time_ <= var_165_1 + arg_165_0 then
				arg_162_1.var_.moveOldPos1075ui_story = var_165_0.localPosition
			end

			local var_165_2 = 0.001

			if var_165_1 <= arg_162_1.time_ and arg_162_1.time_ < var_165_1 + var_165_2 then
				local var_165_3 = (arg_162_1.time_ - var_165_1) / var_165_2
				local var_165_4 = Vector3.New(-0.7, -1.055, -6.16)

				var_165_0.localPosition = Vector3.Lerp(arg_162_1.var_.moveOldPos1075ui_story, var_165_4, var_165_3)

				local var_165_5 = manager.ui.mainCamera.transform.position - var_165_0.position

				var_165_0.forward = Vector3.New(var_165_5.x, var_165_5.y, var_165_5.z)

				local var_165_6 = var_165_0.localEulerAngles

				var_165_6.z = 0
				var_165_6.x = 0
				var_165_0.localEulerAngles = var_165_6
			end

			if arg_162_1.time_ >= var_165_1 + var_165_2 and arg_162_1.time_ < var_165_1 + var_165_2 + arg_165_0 then
				var_165_0.localPosition = Vector3.New(-0.7, -1.055, -6.16)

				local var_165_7 = manager.ui.mainCamera.transform.position - var_165_0.position

				var_165_0.forward = Vector3.New(var_165_7.x, var_165_7.y, var_165_7.z)

				local var_165_8 = var_165_0.localEulerAngles

				var_165_8.z = 0
				var_165_8.x = 0
				var_165_0.localEulerAngles = var_165_8
			end

			local var_165_9 = arg_162_1.actors_["1071ui_story"].transform
			local var_165_10 = 0

			if var_165_10 < arg_162_1.time_ and arg_162_1.time_ <= var_165_10 + arg_165_0 then
				arg_162_1.var_.moveOldPos1071ui_story = var_165_9.localPosition
			end

			local var_165_11 = 0.001

			if var_165_10 <= arg_162_1.time_ and arg_162_1.time_ < var_165_10 + var_165_11 then
				local var_165_12 = (arg_162_1.time_ - var_165_10) / var_165_11
				local var_165_13 = Vector3.New(0, 100, 0)

				var_165_9.localPosition = Vector3.Lerp(arg_162_1.var_.moveOldPos1071ui_story, var_165_13, var_165_12)

				local var_165_14 = manager.ui.mainCamera.transform.position - var_165_9.position

				var_165_9.forward = Vector3.New(var_165_14.x, var_165_14.y, var_165_14.z)

				local var_165_15 = var_165_9.localEulerAngles

				var_165_15.z = 0
				var_165_15.x = 0
				var_165_9.localEulerAngles = var_165_15
			end

			if arg_162_1.time_ >= var_165_10 + var_165_11 and arg_162_1.time_ < var_165_10 + var_165_11 + arg_165_0 then
				var_165_9.localPosition = Vector3.New(0, 100, 0)

				local var_165_16 = manager.ui.mainCamera.transform.position - var_165_9.position

				var_165_9.forward = Vector3.New(var_165_16.x, var_165_16.y, var_165_16.z)

				local var_165_17 = var_165_9.localEulerAngles

				var_165_17.z = 0
				var_165_17.x = 0
				var_165_9.localEulerAngles = var_165_17
			end

			local var_165_18 = arg_162_1.actors_["1069ui_story"].transform
			local var_165_19 = 0

			if var_165_19 < arg_162_1.time_ and arg_162_1.time_ <= var_165_19 + arg_165_0 then
				arg_162_1.var_.moveOldPos1069ui_story = var_165_18.localPosition
			end

			local var_165_20 = 0.001

			if var_165_19 <= arg_162_1.time_ and arg_162_1.time_ < var_165_19 + var_165_20 then
				local var_165_21 = (arg_162_1.time_ - var_165_19) / var_165_20
				local var_165_22 = Vector3.New(0.7, -1, -6)

				var_165_18.localPosition = Vector3.Lerp(arg_162_1.var_.moveOldPos1069ui_story, var_165_22, var_165_21)

				local var_165_23 = manager.ui.mainCamera.transform.position - var_165_18.position

				var_165_18.forward = Vector3.New(var_165_23.x, var_165_23.y, var_165_23.z)

				local var_165_24 = var_165_18.localEulerAngles

				var_165_24.z = 0
				var_165_24.x = 0
				var_165_18.localEulerAngles = var_165_24
			end

			if arg_162_1.time_ >= var_165_19 + var_165_20 and arg_162_1.time_ < var_165_19 + var_165_20 + arg_165_0 then
				var_165_18.localPosition = Vector3.New(0.7, -1, -6)

				local var_165_25 = manager.ui.mainCamera.transform.position - var_165_18.position

				var_165_18.forward = Vector3.New(var_165_25.x, var_165_25.y, var_165_25.z)

				local var_165_26 = var_165_18.localEulerAngles

				var_165_26.z = 0
				var_165_26.x = 0
				var_165_18.localEulerAngles = var_165_26
			end

			local var_165_27 = arg_162_1.actors_["1069ui_story"]
			local var_165_28 = 0

			if var_165_28 < arg_162_1.time_ and arg_162_1.time_ <= var_165_28 + arg_165_0 and not isNil(var_165_27) and arg_162_1.var_.characterEffect1069ui_story == nil then
				arg_162_1.var_.characterEffect1069ui_story = var_165_27:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_165_29 = 0.034

			if var_165_28 <= arg_162_1.time_ and arg_162_1.time_ < var_165_28 + var_165_29 and not isNil(var_165_27) then
				local var_165_30 = (arg_162_1.time_ - var_165_28) / var_165_29

				if arg_162_1.var_.characterEffect1069ui_story and not isNil(var_165_27) then
					local var_165_31 = Mathf.Lerp(0, 0.5, var_165_30)

					arg_162_1.var_.characterEffect1069ui_story.fillFlat = true
					arg_162_1.var_.characterEffect1069ui_story.fillRatio = var_165_31
				end
			end

			if arg_162_1.time_ >= var_165_28 + var_165_29 and arg_162_1.time_ < var_165_28 + var_165_29 + arg_165_0 and not isNil(var_165_27) and arg_162_1.var_.characterEffect1069ui_story then
				local var_165_32 = 0.5

				arg_162_1.var_.characterEffect1069ui_story.fillFlat = true
				arg_162_1.var_.characterEffect1069ui_story.fillRatio = var_165_32
			end

			local var_165_33 = arg_162_1.actors_["1075ui_story"]
			local var_165_34 = 0

			if var_165_34 < arg_162_1.time_ and arg_162_1.time_ <= var_165_34 + arg_165_0 and not isNil(var_165_33) and arg_162_1.var_.characterEffect1075ui_story == nil then
				arg_162_1.var_.characterEffect1075ui_story = var_165_33:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_165_35 = 0.2

			if var_165_34 <= arg_162_1.time_ and arg_162_1.time_ < var_165_34 + var_165_35 and not isNil(var_165_33) then
				local var_165_36 = (arg_162_1.time_ - var_165_34) / var_165_35

				if arg_162_1.var_.characterEffect1075ui_story and not isNil(var_165_33) then
					arg_162_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_162_1.time_ >= var_165_34 + var_165_35 and arg_162_1.time_ < var_165_34 + var_165_35 + arg_165_0 and not isNil(var_165_33) and arg_162_1.var_.characterEffect1075ui_story then
				arg_162_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_165_37 = 0

			if var_165_37 < arg_162_1.time_ and arg_162_1.time_ <= var_165_37 + arg_165_0 then
				arg_162_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action1_1")
			end

			local var_165_38 = 0

			if var_165_38 < arg_162_1.time_ and arg_162_1.time_ <= var_165_38 + arg_165_0 then
				arg_162_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_165_39 = 0
			local var_165_40 = 0.225

			if var_165_39 < arg_162_1.time_ and arg_162_1.time_ <= var_165_39 + arg_165_0 then
				arg_162_1.talkMaxDuration = 0
				arg_162_1.dialogCg_.alpha = 1

				arg_162_1.dialog_:SetActive(true)
				SetActive(arg_162_1.leftNameGo_, true)

				local var_165_41 = arg_162_1:FormatText(StoryNameCfg[381].name)

				arg_162_1.leftNameTxt_.text = var_165_41

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_162_1.leftNameTxt_.transform)

				arg_162_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_162_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_162_1:RecordName(arg_162_1.leftNameTxt_.text)
				SetActive(arg_162_1.iconTrs_.gameObject, false)
				arg_162_1.callingController_:SetSelectedState("normal")

				local var_165_42 = arg_162_1:GetWordFromCfg(120051039)
				local var_165_43 = arg_162_1:FormatText(var_165_42.content)

				arg_162_1.text_.text = var_165_43

				LuaForUtil.ClearLinePrefixSymbol(arg_162_1.text_)

				local var_165_44 = 9
				local var_165_45 = utf8.len(var_165_43)
				local var_165_46 = var_165_44 <= 0 and var_165_40 or var_165_40 * (var_165_45 / var_165_44)

				if var_165_46 > 0 and var_165_40 < var_165_46 then
					arg_162_1.talkMaxDuration = var_165_46

					if var_165_46 + var_165_39 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_46 + var_165_39
					end
				end

				arg_162_1.text_.text = var_165_43
				arg_162_1.typewritter.percent = 0

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120051", "120051039", "story_v_out_120051.awb") ~= 0 then
					local var_165_47 = manager.audio:GetVoiceLength("story_v_out_120051", "120051039", "story_v_out_120051.awb") / 1000

					if var_165_47 + var_165_39 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_47 + var_165_39
					end

					if var_165_42.prefab_name ~= "" and arg_162_1.actors_[var_165_42.prefab_name] ~= nil then
						local var_165_48 = LuaForUtil.PlayVoiceWithCriLipsync(arg_162_1.actors_[var_165_42.prefab_name].transform, "story_v_out_120051", "120051039", "story_v_out_120051.awb")

						arg_162_1:RecordAudio("120051039", var_165_48)
						arg_162_1:RecordAudio("120051039", var_165_48)
					else
						arg_162_1:AudioAction("play", "voice", "story_v_out_120051", "120051039", "story_v_out_120051.awb")
					end

					arg_162_1:RecordHistoryTalkVoice("story_v_out_120051", "120051039", "story_v_out_120051.awb")
				end

				arg_162_1:RecordContent(arg_162_1.text_.text)
			end

			local var_165_49 = math.max(var_165_40, arg_162_1.talkMaxDuration)

			if var_165_39 <= arg_162_1.time_ and arg_162_1.time_ < var_165_39 + var_165_49 then
				arg_162_1.typewritter.percent = (arg_162_1.time_ - var_165_39) / var_165_49

				arg_162_1.typewritter:SetDirty()
			end

			if arg_162_1.time_ >= var_165_39 + var_165_49 and arg_162_1.time_ < var_165_39 + var_165_49 + arg_165_0 then
				arg_162_1.typewritter.percent = 1

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(true)
			end
		end

		arg_162_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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
				actorName = "1069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_162_1:InitPlayNodeList()
	end,
	Play120051040 = function(arg_166_0, arg_166_1)
		arg_166_1.time_ = 0
		arg_166_1.frameCnt_ = 0
		arg_166_1.state_ = "playing"
		arg_166_1.curTalkId_ = 120051040
		arg_166_1.duration_ = 4.97

		local var_166_0 = {
			zh = 2.166,
			ja = 4.966
		}
		local var_166_1 = manager.audio:GetLocalizationFlag()

		if var_166_0[var_166_1] ~= nil then
			arg_166_1.duration_ = var_166_0[var_166_1]
		end

		SetActive(arg_166_1.tipsGo_, false)

		function arg_166_1.onSingleLineFinish_()
			arg_166_1.onSingleLineUpdate_ = nil
			arg_166_1.onSingleLineFinish_ = nil
			arg_166_1.state_ = "waiting"
		end

		function arg_166_1.playNext_(arg_168_0)
			if arg_168_0 == 1 then
				arg_166_0:Play120051041(arg_166_1)
			end
		end

		function arg_166_1.onSingleLineUpdate_(arg_169_0)
			local var_169_0 = arg_166_1.actors_["1069ui_story"]
			local var_169_1 = 0

			if var_169_1 < arg_166_1.time_ and arg_166_1.time_ <= var_169_1 + arg_169_0 and not isNil(var_169_0) and arg_166_1.var_.characterEffect1069ui_story == nil then
				arg_166_1.var_.characterEffect1069ui_story = var_169_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_169_2 = 0.2

			if var_169_1 <= arg_166_1.time_ and arg_166_1.time_ < var_169_1 + var_169_2 and not isNil(var_169_0) then
				local var_169_3 = (arg_166_1.time_ - var_169_1) / var_169_2

				if arg_166_1.var_.characterEffect1069ui_story and not isNil(var_169_0) then
					arg_166_1.var_.characterEffect1069ui_story.fillFlat = false
				end
			end

			if arg_166_1.time_ >= var_169_1 + var_169_2 and arg_166_1.time_ < var_169_1 + var_169_2 + arg_169_0 and not isNil(var_169_0) and arg_166_1.var_.characterEffect1069ui_story then
				arg_166_1.var_.characterEffect1069ui_story.fillFlat = false
			end

			local var_169_4 = arg_166_1.actors_["1075ui_story"]
			local var_169_5 = 0

			if var_169_5 < arg_166_1.time_ and arg_166_1.time_ <= var_169_5 + arg_169_0 and not isNil(var_169_4) and arg_166_1.var_.characterEffect1075ui_story == nil then
				arg_166_1.var_.characterEffect1075ui_story = var_169_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_169_6 = 0.2

			if var_169_5 <= arg_166_1.time_ and arg_166_1.time_ < var_169_5 + var_169_6 and not isNil(var_169_4) then
				local var_169_7 = (arg_166_1.time_ - var_169_5) / var_169_6

				if arg_166_1.var_.characterEffect1075ui_story and not isNil(var_169_4) then
					local var_169_8 = Mathf.Lerp(0, 0.5, var_169_7)

					arg_166_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_166_1.var_.characterEffect1075ui_story.fillRatio = var_169_8
				end
			end

			if arg_166_1.time_ >= var_169_5 + var_169_6 and arg_166_1.time_ < var_169_5 + var_169_6 + arg_169_0 and not isNil(var_169_4) and arg_166_1.var_.characterEffect1075ui_story then
				local var_169_9 = 0.5

				arg_166_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_166_1.var_.characterEffect1075ui_story.fillRatio = var_169_9
			end

			local var_169_10 = 0
			local var_169_11 = 0.25

			if var_169_10 < arg_166_1.time_ and arg_166_1.time_ <= var_169_10 + arg_169_0 then
				arg_166_1.talkMaxDuration = 0
				arg_166_1.dialogCg_.alpha = 1

				arg_166_1.dialog_:SetActive(true)
				SetActive(arg_166_1.leftNameGo_, true)

				local var_169_12 = arg_166_1:FormatText(StoryNameCfg[378].name)

				arg_166_1.leftNameTxt_.text = var_169_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_166_1.leftNameTxt_.transform)

				arg_166_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_166_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_166_1:RecordName(arg_166_1.leftNameTxt_.text)
				SetActive(arg_166_1.iconTrs_.gameObject, false)
				arg_166_1.callingController_:SetSelectedState("normal")

				local var_169_13 = arg_166_1:GetWordFromCfg(120051040)
				local var_169_14 = arg_166_1:FormatText(var_169_13.content)

				arg_166_1.text_.text = var_169_14

				LuaForUtil.ClearLinePrefixSymbol(arg_166_1.text_)

				local var_169_15 = 10
				local var_169_16 = utf8.len(var_169_14)
				local var_169_17 = var_169_15 <= 0 and var_169_11 or var_169_11 * (var_169_16 / var_169_15)

				if var_169_17 > 0 and var_169_11 < var_169_17 then
					arg_166_1.talkMaxDuration = var_169_17

					if var_169_17 + var_169_10 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_17 + var_169_10
					end
				end

				arg_166_1.text_.text = var_169_14
				arg_166_1.typewritter.percent = 0

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120051", "120051040", "story_v_out_120051.awb") ~= 0 then
					local var_169_18 = manager.audio:GetVoiceLength("story_v_out_120051", "120051040", "story_v_out_120051.awb") / 1000

					if var_169_18 + var_169_10 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_18 + var_169_10
					end

					if var_169_13.prefab_name ~= "" and arg_166_1.actors_[var_169_13.prefab_name] ~= nil then
						local var_169_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_166_1.actors_[var_169_13.prefab_name].transform, "story_v_out_120051", "120051040", "story_v_out_120051.awb")

						arg_166_1:RecordAudio("120051040", var_169_19)
						arg_166_1:RecordAudio("120051040", var_169_19)
					else
						arg_166_1:AudioAction("play", "voice", "story_v_out_120051", "120051040", "story_v_out_120051.awb")
					end

					arg_166_1:RecordHistoryTalkVoice("story_v_out_120051", "120051040", "story_v_out_120051.awb")
				end

				arg_166_1:RecordContent(arg_166_1.text_.text)
			end

			local var_169_20 = math.max(var_169_11, arg_166_1.talkMaxDuration)

			if var_169_10 <= arg_166_1.time_ and arg_166_1.time_ < var_169_10 + var_169_20 then
				arg_166_1.typewritter.percent = (arg_166_1.time_ - var_169_10) / var_169_20

				arg_166_1.typewritter:SetDirty()
			end

			if arg_166_1.time_ >= var_169_10 + var_169_20 and arg_166_1.time_ < var_169_10 + var_169_20 + arg_169_0 then
				arg_166_1.typewritter.percent = 1

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(true)
			end
		end

		arg_166_1.nodeConfigList_ = {}

		arg_166_1:InitPlayNodeList()
	end,
	Play120051041 = function(arg_170_0, arg_170_1)
		arg_170_1.time_ = 0
		arg_170_1.frameCnt_ = 0
		arg_170_1.state_ = "playing"
		arg_170_1.curTalkId_ = 120051041
		arg_170_1.duration_ = 10.27

		local var_170_0 = {
			zh = 9.6,
			ja = 10.266
		}
		local var_170_1 = manager.audio:GetLocalizationFlag()

		if var_170_0[var_170_1] ~= nil then
			arg_170_1.duration_ = var_170_0[var_170_1]
		end

		SetActive(arg_170_1.tipsGo_, false)

		function arg_170_1.onSingleLineFinish_()
			arg_170_1.onSingleLineUpdate_ = nil
			arg_170_1.onSingleLineFinish_ = nil
			arg_170_1.state_ = "waiting"
		end

		function arg_170_1.playNext_(arg_172_0)
			if arg_172_0 == 1 then
				arg_170_0:Play120051042(arg_170_1)
			end
		end

		function arg_170_1.onSingleLineUpdate_(arg_173_0)
			local var_173_0 = arg_170_1.actors_["1075ui_story"].transform
			local var_173_1 = 0

			if var_173_1 < arg_170_1.time_ and arg_170_1.time_ <= var_173_1 + arg_173_0 then
				arg_170_1.var_.moveOldPos1075ui_story = var_173_0.localPosition
			end

			local var_173_2 = 0.001

			if var_173_1 <= arg_170_1.time_ and arg_170_1.time_ < var_173_1 + var_173_2 then
				local var_173_3 = (arg_170_1.time_ - var_173_1) / var_173_2
				local var_173_4 = Vector3.New(0, 100, 0)

				var_173_0.localPosition = Vector3.Lerp(arg_170_1.var_.moveOldPos1075ui_story, var_173_4, var_173_3)

				local var_173_5 = manager.ui.mainCamera.transform.position - var_173_0.position

				var_173_0.forward = Vector3.New(var_173_5.x, var_173_5.y, var_173_5.z)

				local var_173_6 = var_173_0.localEulerAngles

				var_173_6.z = 0
				var_173_6.x = 0
				var_173_0.localEulerAngles = var_173_6
			end

			if arg_170_1.time_ >= var_173_1 + var_173_2 and arg_170_1.time_ < var_173_1 + var_173_2 + arg_173_0 then
				var_173_0.localPosition = Vector3.New(0, 100, 0)

				local var_173_7 = manager.ui.mainCamera.transform.position - var_173_0.position

				var_173_0.forward = Vector3.New(var_173_7.x, var_173_7.y, var_173_7.z)

				local var_173_8 = var_173_0.localEulerAngles

				var_173_8.z = 0
				var_173_8.x = 0
				var_173_0.localEulerAngles = var_173_8
			end

			local var_173_9 = arg_170_1.actors_["1069ui_story"]
			local var_173_10 = 0

			if var_173_10 < arg_170_1.time_ and arg_170_1.time_ <= var_173_10 + arg_173_0 and not isNil(var_173_9) and arg_170_1.var_.characterEffect1069ui_story == nil then
				arg_170_1.var_.characterEffect1069ui_story = var_173_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_173_11 = 0.2

			if var_173_10 <= arg_170_1.time_ and arg_170_1.time_ < var_173_10 + var_173_11 and not isNil(var_173_9) then
				local var_173_12 = (arg_170_1.time_ - var_173_10) / var_173_11

				if arg_170_1.var_.characterEffect1069ui_story and not isNil(var_173_9) then
					local var_173_13 = Mathf.Lerp(0, 0.5, var_173_12)

					arg_170_1.var_.characterEffect1069ui_story.fillFlat = true
					arg_170_1.var_.characterEffect1069ui_story.fillRatio = var_173_13
				end
			end

			if arg_170_1.time_ >= var_173_10 + var_173_11 and arg_170_1.time_ < var_173_10 + var_173_11 + arg_173_0 and not isNil(var_173_9) and arg_170_1.var_.characterEffect1069ui_story then
				local var_173_14 = 0.5

				arg_170_1.var_.characterEffect1069ui_story.fillFlat = true
				arg_170_1.var_.characterEffect1069ui_story.fillRatio = var_173_14
			end

			local var_173_15 = arg_170_1.actors_["1071ui_story"]
			local var_173_16 = 0

			if var_173_16 < arg_170_1.time_ and arg_170_1.time_ <= var_173_16 + arg_173_0 and not isNil(var_173_15) and arg_170_1.var_.characterEffect1071ui_story == nil then
				arg_170_1.var_.characterEffect1071ui_story = var_173_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_173_17 = 0.2

			if var_173_16 <= arg_170_1.time_ and arg_170_1.time_ < var_173_16 + var_173_17 and not isNil(var_173_15) then
				local var_173_18 = (arg_170_1.time_ - var_173_16) / var_173_17

				if arg_170_1.var_.characterEffect1071ui_story and not isNil(var_173_15) then
					arg_170_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_170_1.time_ >= var_173_16 + var_173_17 and arg_170_1.time_ < var_173_16 + var_173_17 + arg_173_0 and not isNil(var_173_15) and arg_170_1.var_.characterEffect1071ui_story then
				arg_170_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_173_19 = arg_170_1.actors_["1071ui_story"].transform
			local var_173_20 = 0

			if var_173_20 < arg_170_1.time_ and arg_170_1.time_ <= var_173_20 + arg_173_0 then
				arg_170_1.var_.moveOldPos1071ui_story = var_173_19.localPosition
			end

			local var_173_21 = 0.001

			if var_173_20 <= arg_170_1.time_ and arg_170_1.time_ < var_173_20 + var_173_21 then
				local var_173_22 = (arg_170_1.time_ - var_173_20) / var_173_21
				local var_173_23 = Vector3.New(-0.7, -1.05, -6.2)

				var_173_19.localPosition = Vector3.Lerp(arg_170_1.var_.moveOldPos1071ui_story, var_173_23, var_173_22)

				local var_173_24 = manager.ui.mainCamera.transform.position - var_173_19.position

				var_173_19.forward = Vector3.New(var_173_24.x, var_173_24.y, var_173_24.z)

				local var_173_25 = var_173_19.localEulerAngles

				var_173_25.z = 0
				var_173_25.x = 0
				var_173_19.localEulerAngles = var_173_25
			end

			if arg_170_1.time_ >= var_173_20 + var_173_21 and arg_170_1.time_ < var_173_20 + var_173_21 + arg_173_0 then
				var_173_19.localPosition = Vector3.New(-0.7, -1.05, -6.2)

				local var_173_26 = manager.ui.mainCamera.transform.position - var_173_19.position

				var_173_19.forward = Vector3.New(var_173_26.x, var_173_26.y, var_173_26.z)

				local var_173_27 = var_173_19.localEulerAngles

				var_173_27.z = 0
				var_173_27.x = 0
				var_173_19.localEulerAngles = var_173_27
			end

			local var_173_28 = 0

			if var_173_28 < arg_170_1.time_ and arg_170_1.time_ <= var_173_28 + arg_173_0 then
				arg_170_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action1_1")
			end

			local var_173_29 = 0
			local var_173_30 = 1.05

			if var_173_29 < arg_170_1.time_ and arg_170_1.time_ <= var_173_29 + arg_173_0 then
				arg_170_1.talkMaxDuration = 0
				arg_170_1.dialogCg_.alpha = 1

				arg_170_1.dialog_:SetActive(true)
				SetActive(arg_170_1.leftNameGo_, true)

				local var_173_31 = arg_170_1:FormatText(StoryNameCfg[384].name)

				arg_170_1.leftNameTxt_.text = var_173_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_170_1.leftNameTxt_.transform)

				arg_170_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_170_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_170_1:RecordName(arg_170_1.leftNameTxt_.text)
				SetActive(arg_170_1.iconTrs_.gameObject, false)
				arg_170_1.callingController_:SetSelectedState("normal")

				local var_173_32 = arg_170_1:GetWordFromCfg(120051041)
				local var_173_33 = arg_170_1:FormatText(var_173_32.content)

				arg_170_1.text_.text = var_173_33

				LuaForUtil.ClearLinePrefixSymbol(arg_170_1.text_)

				local var_173_34 = 42
				local var_173_35 = utf8.len(var_173_33)
				local var_173_36 = var_173_34 <= 0 and var_173_30 or var_173_30 * (var_173_35 / var_173_34)

				if var_173_36 > 0 and var_173_30 < var_173_36 then
					arg_170_1.talkMaxDuration = var_173_36

					if var_173_36 + var_173_29 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_36 + var_173_29
					end
				end

				arg_170_1.text_.text = var_173_33
				arg_170_1.typewritter.percent = 0

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120051", "120051041", "story_v_out_120051.awb") ~= 0 then
					local var_173_37 = manager.audio:GetVoiceLength("story_v_out_120051", "120051041", "story_v_out_120051.awb") / 1000

					if var_173_37 + var_173_29 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_37 + var_173_29
					end

					if var_173_32.prefab_name ~= "" and arg_170_1.actors_[var_173_32.prefab_name] ~= nil then
						local var_173_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_170_1.actors_[var_173_32.prefab_name].transform, "story_v_out_120051", "120051041", "story_v_out_120051.awb")

						arg_170_1:RecordAudio("120051041", var_173_38)
						arg_170_1:RecordAudio("120051041", var_173_38)
					else
						arg_170_1:AudioAction("play", "voice", "story_v_out_120051", "120051041", "story_v_out_120051.awb")
					end

					arg_170_1:RecordHistoryTalkVoice("story_v_out_120051", "120051041", "story_v_out_120051.awb")
				end

				arg_170_1:RecordContent(arg_170_1.text_.text)
			end

			local var_173_39 = math.max(var_173_30, arg_170_1.talkMaxDuration)

			if var_173_29 <= arg_170_1.time_ and arg_170_1.time_ < var_173_29 + var_173_39 then
				arg_170_1.typewritter.percent = (arg_170_1.time_ - var_173_29) / var_173_39

				arg_170_1.typewritter:SetDirty()
			end

			if arg_170_1.time_ >= var_173_29 + var_173_39 and arg_170_1.time_ < var_173_29 + var_173_39 + arg_173_0 then
				arg_170_1.typewritter.percent = 1

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(true)
			end
		end

		arg_170_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_170_1:InitPlayNodeList()
	end,
	Play120051042 = function(arg_174_0, arg_174_1)
		arg_174_1.time_ = 0
		arg_174_1.frameCnt_ = 0
		arg_174_1.state_ = "playing"
		arg_174_1.curTalkId_ = 120051042
		arg_174_1.duration_ = 14.27

		local var_174_0 = {
			zh = 14.266,
			ja = 13.533
		}
		local var_174_1 = manager.audio:GetLocalizationFlag()

		if var_174_0[var_174_1] ~= nil then
			arg_174_1.duration_ = var_174_0[var_174_1]
		end

		SetActive(arg_174_1.tipsGo_, false)

		function arg_174_1.onSingleLineFinish_()
			arg_174_1.onSingleLineUpdate_ = nil
			arg_174_1.onSingleLineFinish_ = nil
			arg_174_1.state_ = "waiting"
		end

		function arg_174_1.playNext_(arg_176_0)
			if arg_176_0 == 1 then
				arg_174_0:Play120051043(arg_174_1)
			end
		end

		function arg_174_1.onSingleLineUpdate_(arg_177_0)
			local var_177_0 = 0
			local var_177_1 = 1.475

			if var_177_0 < arg_174_1.time_ and arg_174_1.time_ <= var_177_0 + arg_177_0 then
				arg_174_1.talkMaxDuration = 0
				arg_174_1.dialogCg_.alpha = 1

				arg_174_1.dialog_:SetActive(true)
				SetActive(arg_174_1.leftNameGo_, true)

				local var_177_2 = arg_174_1:FormatText(StoryNameCfg[384].name)

				arg_174_1.leftNameTxt_.text = var_177_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_174_1.leftNameTxt_.transform)

				arg_174_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_174_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_174_1:RecordName(arg_174_1.leftNameTxt_.text)
				SetActive(arg_174_1.iconTrs_.gameObject, false)
				arg_174_1.callingController_:SetSelectedState("normal")

				local var_177_3 = arg_174_1:GetWordFromCfg(120051042)
				local var_177_4 = arg_174_1:FormatText(var_177_3.content)

				arg_174_1.text_.text = var_177_4

				LuaForUtil.ClearLinePrefixSymbol(arg_174_1.text_)

				local var_177_5 = 59
				local var_177_6 = utf8.len(var_177_4)
				local var_177_7 = var_177_5 <= 0 and var_177_1 or var_177_1 * (var_177_6 / var_177_5)

				if var_177_7 > 0 and var_177_1 < var_177_7 then
					arg_174_1.talkMaxDuration = var_177_7

					if var_177_7 + var_177_0 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_7 + var_177_0
					end
				end

				arg_174_1.text_.text = var_177_4
				arg_174_1.typewritter.percent = 0

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120051", "120051042", "story_v_out_120051.awb") ~= 0 then
					local var_177_8 = manager.audio:GetVoiceLength("story_v_out_120051", "120051042", "story_v_out_120051.awb") / 1000

					if var_177_8 + var_177_0 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_8 + var_177_0
					end

					if var_177_3.prefab_name ~= "" and arg_174_1.actors_[var_177_3.prefab_name] ~= nil then
						local var_177_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_174_1.actors_[var_177_3.prefab_name].transform, "story_v_out_120051", "120051042", "story_v_out_120051.awb")

						arg_174_1:RecordAudio("120051042", var_177_9)
						arg_174_1:RecordAudio("120051042", var_177_9)
					else
						arg_174_1:AudioAction("play", "voice", "story_v_out_120051", "120051042", "story_v_out_120051.awb")
					end

					arg_174_1:RecordHistoryTalkVoice("story_v_out_120051", "120051042", "story_v_out_120051.awb")
				end

				arg_174_1:RecordContent(arg_174_1.text_.text)
			end

			local var_177_10 = math.max(var_177_1, arg_174_1.talkMaxDuration)

			if var_177_0 <= arg_174_1.time_ and arg_174_1.time_ < var_177_0 + var_177_10 then
				arg_174_1.typewritter.percent = (arg_174_1.time_ - var_177_0) / var_177_10

				arg_174_1.typewritter:SetDirty()
			end

			if arg_174_1.time_ >= var_177_0 + var_177_10 and arg_174_1.time_ < var_177_0 + var_177_10 + arg_177_0 then
				arg_174_1.typewritter.percent = 1

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(true)
			end
		end

		arg_174_1.nodeConfigList_ = {}

		arg_174_1:InitPlayNodeList()
	end,
	Play120051043 = function(arg_178_0, arg_178_1)
		arg_178_1.time_ = 0
		arg_178_1.frameCnt_ = 0
		arg_178_1.state_ = "playing"
		arg_178_1.curTalkId_ = 120051043
		arg_178_1.duration_ = 4.83

		local var_178_0 = {
			zh = 4.4,
			ja = 4.833
		}
		local var_178_1 = manager.audio:GetLocalizationFlag()

		if var_178_0[var_178_1] ~= nil then
			arg_178_1.duration_ = var_178_0[var_178_1]
		end

		SetActive(arg_178_1.tipsGo_, false)

		function arg_178_1.onSingleLineFinish_()
			arg_178_1.onSingleLineUpdate_ = nil
			arg_178_1.onSingleLineFinish_ = nil
			arg_178_1.state_ = "waiting"
		end

		function arg_178_1.playNext_(arg_180_0)
			if arg_180_0 == 1 then
				arg_178_0:Play120051044(arg_178_1)
			end
		end

		function arg_178_1.onSingleLineUpdate_(arg_181_0)
			local var_181_0 = arg_178_1.actors_["1069ui_story"].transform
			local var_181_1 = 0

			if var_181_1 < arg_178_1.time_ and arg_178_1.time_ <= var_181_1 + arg_181_0 then
				arg_178_1.var_.moveOldPos1069ui_story = var_181_0.localPosition
			end

			local var_181_2 = 0.001

			if var_181_1 <= arg_178_1.time_ and arg_178_1.time_ < var_181_1 + var_181_2 then
				local var_181_3 = (arg_178_1.time_ - var_181_1) / var_181_2
				local var_181_4 = Vector3.New(0, 100, 0)

				var_181_0.localPosition = Vector3.Lerp(arg_178_1.var_.moveOldPos1069ui_story, var_181_4, var_181_3)

				local var_181_5 = manager.ui.mainCamera.transform.position - var_181_0.position

				var_181_0.forward = Vector3.New(var_181_5.x, var_181_5.y, var_181_5.z)

				local var_181_6 = var_181_0.localEulerAngles

				var_181_6.z = 0
				var_181_6.x = 0
				var_181_0.localEulerAngles = var_181_6
			end

			if arg_178_1.time_ >= var_181_1 + var_181_2 and arg_178_1.time_ < var_181_1 + var_181_2 + arg_181_0 then
				var_181_0.localPosition = Vector3.New(0, 100, 0)

				local var_181_7 = manager.ui.mainCamera.transform.position - var_181_0.position

				var_181_0.forward = Vector3.New(var_181_7.x, var_181_7.y, var_181_7.z)

				local var_181_8 = var_181_0.localEulerAngles

				var_181_8.z = 0
				var_181_8.x = 0
				var_181_0.localEulerAngles = var_181_8
			end

			local var_181_9 = "1184ui_story"

			if arg_178_1.actors_[var_181_9] == nil then
				local var_181_10 = Asset.Load("Char/" .. "1184ui_story")

				if not isNil(var_181_10) then
					local var_181_11 = Object.Instantiate(Asset.Load("Char/" .. "1184ui_story"), arg_178_1.stage_.transform)

					var_181_11.name = var_181_9
					var_181_11.transform.localPosition = Vector3.New(0, 100, 0)
					arg_178_1.actors_[var_181_9] = var_181_11

					local var_181_12 = var_181_11:GetComponentInChildren(typeof(CharacterEffect))

					var_181_12.enabled = true

					local var_181_13 = GameObjectTools.GetOrAddComponent(var_181_11, typeof(DynamicBoneHelper))

					if var_181_13 then
						var_181_13:EnableDynamicBone(false)
					end

					arg_178_1:ShowWeapon(var_181_12.transform, false)

					arg_178_1.var_[var_181_9 .. "Animator"] = var_181_12.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_178_1.var_[var_181_9 .. "Animator"].applyRootMotion = true
					arg_178_1.var_[var_181_9 .. "LipSync"] = var_181_12.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_181_14 = arg_178_1.actors_["1184ui_story"].transform
			local var_181_15 = 0

			if var_181_15 < arg_178_1.time_ and arg_178_1.time_ <= var_181_15 + arg_181_0 then
				arg_178_1.var_.moveOldPos1184ui_story = var_181_14.localPosition
			end

			local var_181_16 = 0.001

			if var_181_15 <= arg_178_1.time_ and arg_178_1.time_ < var_181_15 + var_181_16 then
				local var_181_17 = (arg_178_1.time_ - var_181_15) / var_181_16
				local var_181_18 = Vector3.New(0.7, -0.97, -6)

				var_181_14.localPosition = Vector3.Lerp(arg_178_1.var_.moveOldPos1184ui_story, var_181_18, var_181_17)

				local var_181_19 = manager.ui.mainCamera.transform.position - var_181_14.position

				var_181_14.forward = Vector3.New(var_181_19.x, var_181_19.y, var_181_19.z)

				local var_181_20 = var_181_14.localEulerAngles

				var_181_20.z = 0
				var_181_20.x = 0
				var_181_14.localEulerAngles = var_181_20
			end

			if arg_178_1.time_ >= var_181_15 + var_181_16 and arg_178_1.time_ < var_181_15 + var_181_16 + arg_181_0 then
				var_181_14.localPosition = Vector3.New(0.7, -0.97, -6)

				local var_181_21 = manager.ui.mainCamera.transform.position - var_181_14.position

				var_181_14.forward = Vector3.New(var_181_21.x, var_181_21.y, var_181_21.z)

				local var_181_22 = var_181_14.localEulerAngles

				var_181_22.z = 0
				var_181_22.x = 0
				var_181_14.localEulerAngles = var_181_22
			end

			local var_181_23 = arg_178_1.actors_["1184ui_story"]
			local var_181_24 = 0

			if var_181_24 < arg_178_1.time_ and arg_178_1.time_ <= var_181_24 + arg_181_0 and not isNil(var_181_23) and arg_178_1.var_.characterEffect1184ui_story == nil then
				arg_178_1.var_.characterEffect1184ui_story = var_181_23:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_181_25 = 0.2

			if var_181_24 <= arg_178_1.time_ and arg_178_1.time_ < var_181_24 + var_181_25 and not isNil(var_181_23) then
				local var_181_26 = (arg_178_1.time_ - var_181_24) / var_181_25

				if arg_178_1.var_.characterEffect1184ui_story and not isNil(var_181_23) then
					arg_178_1.var_.characterEffect1184ui_story.fillFlat = false
				end
			end

			if arg_178_1.time_ >= var_181_24 + var_181_25 and arg_178_1.time_ < var_181_24 + var_181_25 + arg_181_0 and not isNil(var_181_23) and arg_178_1.var_.characterEffect1184ui_story then
				arg_178_1.var_.characterEffect1184ui_story.fillFlat = false
			end

			local var_181_27 = arg_178_1.actors_["1071ui_story"]
			local var_181_28 = 0

			if var_181_28 < arg_178_1.time_ and arg_178_1.time_ <= var_181_28 + arg_181_0 and not isNil(var_181_27) and arg_178_1.var_.characterEffect1071ui_story == nil then
				arg_178_1.var_.characterEffect1071ui_story = var_181_27:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_181_29 = 0.2

			if var_181_28 <= arg_178_1.time_ and arg_178_1.time_ < var_181_28 + var_181_29 and not isNil(var_181_27) then
				local var_181_30 = (arg_178_1.time_ - var_181_28) / var_181_29

				if arg_178_1.var_.characterEffect1071ui_story and not isNil(var_181_27) then
					local var_181_31 = Mathf.Lerp(0, 0.5, var_181_30)

					arg_178_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_178_1.var_.characterEffect1071ui_story.fillRatio = var_181_31
				end
			end

			if arg_178_1.time_ >= var_181_28 + var_181_29 and arg_178_1.time_ < var_181_28 + var_181_29 + arg_181_0 and not isNil(var_181_27) and arg_178_1.var_.characterEffect1071ui_story then
				local var_181_32 = 0.5

				arg_178_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_178_1.var_.characterEffect1071ui_story.fillRatio = var_181_32
			end

			local var_181_33 = 0

			if var_181_33 < arg_178_1.time_ and arg_178_1.time_ <= var_181_33 + arg_181_0 then
				arg_178_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action6_1")
			end

			local var_181_34 = 0

			if var_181_34 < arg_178_1.time_ and arg_178_1.time_ <= var_181_34 + arg_181_0 then
				arg_178_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_181_35 = 0
			local var_181_36 = 0.35

			if var_181_35 < arg_178_1.time_ and arg_178_1.time_ <= var_181_35 + arg_181_0 then
				arg_178_1.talkMaxDuration = 0
				arg_178_1.dialogCg_.alpha = 1

				arg_178_1.dialog_:SetActive(true)
				SetActive(arg_178_1.leftNameGo_, true)

				local var_181_37 = arg_178_1:FormatText(StoryNameCfg[6].name)

				arg_178_1.leftNameTxt_.text = var_181_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_178_1.leftNameTxt_.transform)

				arg_178_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_178_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_178_1:RecordName(arg_178_1.leftNameTxt_.text)
				SetActive(arg_178_1.iconTrs_.gameObject, false)
				arg_178_1.callingController_:SetSelectedState("normal")

				local var_181_38 = arg_178_1:GetWordFromCfg(120051043)
				local var_181_39 = arg_178_1:FormatText(var_181_38.content)

				arg_178_1.text_.text = var_181_39

				LuaForUtil.ClearLinePrefixSymbol(arg_178_1.text_)

				local var_181_40 = 14
				local var_181_41 = utf8.len(var_181_39)
				local var_181_42 = var_181_40 <= 0 and var_181_36 or var_181_36 * (var_181_41 / var_181_40)

				if var_181_42 > 0 and var_181_36 < var_181_42 then
					arg_178_1.talkMaxDuration = var_181_42

					if var_181_42 + var_181_35 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_42 + var_181_35
					end
				end

				arg_178_1.text_.text = var_181_39
				arg_178_1.typewritter.percent = 0

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120051", "120051043", "story_v_out_120051.awb") ~= 0 then
					local var_181_43 = manager.audio:GetVoiceLength("story_v_out_120051", "120051043", "story_v_out_120051.awb") / 1000

					if var_181_43 + var_181_35 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_43 + var_181_35
					end

					if var_181_38.prefab_name ~= "" and arg_178_1.actors_[var_181_38.prefab_name] ~= nil then
						local var_181_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_178_1.actors_[var_181_38.prefab_name].transform, "story_v_out_120051", "120051043", "story_v_out_120051.awb")

						arg_178_1:RecordAudio("120051043", var_181_44)
						arg_178_1:RecordAudio("120051043", var_181_44)
					else
						arg_178_1:AudioAction("play", "voice", "story_v_out_120051", "120051043", "story_v_out_120051.awb")
					end

					arg_178_1:RecordHistoryTalkVoice("story_v_out_120051", "120051043", "story_v_out_120051.awb")
				end

				arg_178_1:RecordContent(arg_178_1.text_.text)
			end

			local var_181_45 = math.max(var_181_36, arg_178_1.talkMaxDuration)

			if var_181_35 <= arg_178_1.time_ and arg_178_1.time_ < var_181_35 + var_181_45 then
				arg_178_1.typewritter.percent = (arg_178_1.time_ - var_181_35) / var_181_45

				arg_178_1.typewritter:SetDirty()
			end

			if arg_178_1.time_ >= var_181_35 + var_181_45 and arg_178_1.time_ < var_181_35 + var_181_45 + arg_181_0 then
				arg_178_1.typewritter.percent = 1

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(true)
			end
		end

		arg_178_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1069ui_story",
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

		arg_178_1:InitPlayNodeList()
	end,
	Play120051044 = function(arg_182_0, arg_182_1)
		arg_182_1.time_ = 0
		arg_182_1.frameCnt_ = 0
		arg_182_1.state_ = "playing"
		arg_182_1.curTalkId_ = 120051044
		arg_182_1.duration_ = 12.67

		local var_182_0 = {
			zh = 9.833,
			ja = 12.666
		}
		local var_182_1 = manager.audio:GetLocalizationFlag()

		if var_182_0[var_182_1] ~= nil then
			arg_182_1.duration_ = var_182_0[var_182_1]
		end

		SetActive(arg_182_1.tipsGo_, false)

		function arg_182_1.onSingleLineFinish_()
			arg_182_1.onSingleLineUpdate_ = nil
			arg_182_1.onSingleLineFinish_ = nil
			arg_182_1.state_ = "waiting"
		end

		function arg_182_1.playNext_(arg_184_0)
			if arg_184_0 == 1 then
				arg_182_0:Play120051045(arg_182_1)
			end
		end

		function arg_182_1.onSingleLineUpdate_(arg_185_0)
			local var_185_0 = arg_182_1.actors_["1184ui_story"]
			local var_185_1 = 0

			if var_185_1 < arg_182_1.time_ and arg_182_1.time_ <= var_185_1 + arg_185_0 and not isNil(var_185_0) and arg_182_1.var_.characterEffect1184ui_story == nil then
				arg_182_1.var_.characterEffect1184ui_story = var_185_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_185_2 = 0.2

			if var_185_1 <= arg_182_1.time_ and arg_182_1.time_ < var_185_1 + var_185_2 and not isNil(var_185_0) then
				local var_185_3 = (arg_182_1.time_ - var_185_1) / var_185_2

				if arg_182_1.var_.characterEffect1184ui_story and not isNil(var_185_0) then
					local var_185_4 = Mathf.Lerp(0, 0.5, var_185_3)

					arg_182_1.var_.characterEffect1184ui_story.fillFlat = true
					arg_182_1.var_.characterEffect1184ui_story.fillRatio = var_185_4
				end
			end

			if arg_182_1.time_ >= var_185_1 + var_185_2 and arg_182_1.time_ < var_185_1 + var_185_2 + arg_185_0 and not isNil(var_185_0) and arg_182_1.var_.characterEffect1184ui_story then
				local var_185_5 = 0.5

				arg_182_1.var_.characterEffect1184ui_story.fillFlat = true
				arg_182_1.var_.characterEffect1184ui_story.fillRatio = var_185_5
			end

			local var_185_6 = arg_182_1.actors_["1071ui_story"]
			local var_185_7 = 0

			if var_185_7 < arg_182_1.time_ and arg_182_1.time_ <= var_185_7 + arg_185_0 and not isNil(var_185_6) and arg_182_1.var_.characterEffect1071ui_story == nil then
				arg_182_1.var_.characterEffect1071ui_story = var_185_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_185_8 = 0.2

			if var_185_7 <= arg_182_1.time_ and arg_182_1.time_ < var_185_7 + var_185_8 and not isNil(var_185_6) then
				local var_185_9 = (arg_182_1.time_ - var_185_7) / var_185_8

				if arg_182_1.var_.characterEffect1071ui_story and not isNil(var_185_6) then
					arg_182_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_182_1.time_ >= var_185_7 + var_185_8 and arg_182_1.time_ < var_185_7 + var_185_8 + arg_185_0 and not isNil(var_185_6) and arg_182_1.var_.characterEffect1071ui_story then
				arg_182_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_185_10 = 0

			if var_185_10 < arg_182_1.time_ and arg_182_1.time_ <= var_185_10 + arg_185_0 then
				arg_182_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action6_2")
			end

			local var_185_11 = 0
			local var_185_12 = 1.35

			if var_185_11 < arg_182_1.time_ and arg_182_1.time_ <= var_185_11 + arg_185_0 then
				arg_182_1.talkMaxDuration = 0
				arg_182_1.dialogCg_.alpha = 1

				arg_182_1.dialog_:SetActive(true)
				SetActive(arg_182_1.leftNameGo_, true)

				local var_185_13 = arg_182_1:FormatText(StoryNameCfg[384].name)

				arg_182_1.leftNameTxt_.text = var_185_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_182_1.leftNameTxt_.transform)

				arg_182_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_182_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_182_1:RecordName(arg_182_1.leftNameTxt_.text)
				SetActive(arg_182_1.iconTrs_.gameObject, false)
				arg_182_1.callingController_:SetSelectedState("normal")

				local var_185_14 = arg_182_1:GetWordFromCfg(120051044)
				local var_185_15 = arg_182_1:FormatText(var_185_14.content)

				arg_182_1.text_.text = var_185_15

				LuaForUtil.ClearLinePrefixSymbol(arg_182_1.text_)

				local var_185_16 = 45
				local var_185_17 = utf8.len(var_185_15)
				local var_185_18 = var_185_16 <= 0 and var_185_12 or var_185_12 * (var_185_17 / var_185_16)

				if var_185_18 > 0 and var_185_12 < var_185_18 then
					arg_182_1.talkMaxDuration = var_185_18

					if var_185_18 + var_185_11 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_18 + var_185_11
					end
				end

				arg_182_1.text_.text = var_185_15
				arg_182_1.typewritter.percent = 0

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120051", "120051044", "story_v_out_120051.awb") ~= 0 then
					local var_185_19 = manager.audio:GetVoiceLength("story_v_out_120051", "120051044", "story_v_out_120051.awb") / 1000

					if var_185_19 + var_185_11 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_19 + var_185_11
					end

					if var_185_14.prefab_name ~= "" and arg_182_1.actors_[var_185_14.prefab_name] ~= nil then
						local var_185_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_182_1.actors_[var_185_14.prefab_name].transform, "story_v_out_120051", "120051044", "story_v_out_120051.awb")

						arg_182_1:RecordAudio("120051044", var_185_20)
						arg_182_1:RecordAudio("120051044", var_185_20)
					else
						arg_182_1:AudioAction("play", "voice", "story_v_out_120051", "120051044", "story_v_out_120051.awb")
					end

					arg_182_1:RecordHistoryTalkVoice("story_v_out_120051", "120051044", "story_v_out_120051.awb")
				end

				arg_182_1:RecordContent(arg_182_1.text_.text)
			end

			local var_185_21 = math.max(var_185_12, arg_182_1.talkMaxDuration)

			if var_185_11 <= arg_182_1.time_ and arg_182_1.time_ < var_185_11 + var_185_21 then
				arg_182_1.typewritter.percent = (arg_182_1.time_ - var_185_11) / var_185_21

				arg_182_1.typewritter:SetDirty()
			end

			if arg_182_1.time_ >= var_185_11 + var_185_21 and arg_182_1.time_ < var_185_11 + var_185_21 + arg_185_0 then
				arg_182_1.typewritter.percent = 1

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(true)
			end
		end

		arg_182_1.nodeConfigList_ = {}

		arg_182_1:InitPlayNodeList()
	end,
	Play120051045 = function(arg_186_0, arg_186_1)
		arg_186_1.time_ = 0
		arg_186_1.frameCnt_ = 0
		arg_186_1.state_ = "playing"
		arg_186_1.curTalkId_ = 120051045
		arg_186_1.duration_ = 15.1

		local var_186_0 = {
			zh = 10.566,
			ja = 15.1
		}
		local var_186_1 = manager.audio:GetLocalizationFlag()

		if var_186_0[var_186_1] ~= nil then
			arg_186_1.duration_ = var_186_0[var_186_1]
		end

		SetActive(arg_186_1.tipsGo_, false)

		function arg_186_1.onSingleLineFinish_()
			arg_186_1.onSingleLineUpdate_ = nil
			arg_186_1.onSingleLineFinish_ = nil
			arg_186_1.state_ = "waiting"
		end

		function arg_186_1.playNext_(arg_188_0)
			if arg_188_0 == 1 then
				arg_186_0:Play120051046(arg_186_1)
			end
		end

		function arg_186_1.onSingleLineUpdate_(arg_189_0)
			local var_189_0 = 0
			local var_189_1 = 1.2

			if var_189_0 < arg_186_1.time_ and arg_186_1.time_ <= var_189_0 + arg_189_0 then
				arg_186_1.talkMaxDuration = 0
				arg_186_1.dialogCg_.alpha = 1

				arg_186_1.dialog_:SetActive(true)
				SetActive(arg_186_1.leftNameGo_, true)

				local var_189_2 = arg_186_1:FormatText(StoryNameCfg[384].name)

				arg_186_1.leftNameTxt_.text = var_189_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_186_1.leftNameTxt_.transform)

				arg_186_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_186_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_186_1:RecordName(arg_186_1.leftNameTxt_.text)
				SetActive(arg_186_1.iconTrs_.gameObject, false)
				arg_186_1.callingController_:SetSelectedState("normal")

				local var_189_3 = arg_186_1:GetWordFromCfg(120051045)
				local var_189_4 = arg_186_1:FormatText(var_189_3.content)

				arg_186_1.text_.text = var_189_4

				LuaForUtil.ClearLinePrefixSymbol(arg_186_1.text_)

				local var_189_5 = 48
				local var_189_6 = utf8.len(var_189_4)
				local var_189_7 = var_189_5 <= 0 and var_189_1 or var_189_1 * (var_189_6 / var_189_5)

				if var_189_7 > 0 and var_189_1 < var_189_7 then
					arg_186_1.talkMaxDuration = var_189_7

					if var_189_7 + var_189_0 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_7 + var_189_0
					end
				end

				arg_186_1.text_.text = var_189_4
				arg_186_1.typewritter.percent = 0

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120051", "120051045", "story_v_out_120051.awb") ~= 0 then
					local var_189_8 = manager.audio:GetVoiceLength("story_v_out_120051", "120051045", "story_v_out_120051.awb") / 1000

					if var_189_8 + var_189_0 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_8 + var_189_0
					end

					if var_189_3.prefab_name ~= "" and arg_186_1.actors_[var_189_3.prefab_name] ~= nil then
						local var_189_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_186_1.actors_[var_189_3.prefab_name].transform, "story_v_out_120051", "120051045", "story_v_out_120051.awb")

						arg_186_1:RecordAudio("120051045", var_189_9)
						arg_186_1:RecordAudio("120051045", var_189_9)
					else
						arg_186_1:AudioAction("play", "voice", "story_v_out_120051", "120051045", "story_v_out_120051.awb")
					end

					arg_186_1:RecordHistoryTalkVoice("story_v_out_120051", "120051045", "story_v_out_120051.awb")
				end

				arg_186_1:RecordContent(arg_186_1.text_.text)
			end

			local var_189_10 = math.max(var_189_1, arg_186_1.talkMaxDuration)

			if var_189_0 <= arg_186_1.time_ and arg_186_1.time_ < var_189_0 + var_189_10 then
				arg_186_1.typewritter.percent = (arg_186_1.time_ - var_189_0) / var_189_10

				arg_186_1.typewritter:SetDirty()
			end

			if arg_186_1.time_ >= var_189_0 + var_189_10 and arg_186_1.time_ < var_189_0 + var_189_10 + arg_189_0 then
				arg_186_1.typewritter.percent = 1

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(true)
			end
		end

		arg_186_1.nodeConfigList_ = {}

		arg_186_1:InitPlayNodeList()
	end,
	Play120051046 = function(arg_190_0, arg_190_1)
		arg_190_1.time_ = 0
		arg_190_1.frameCnt_ = 0
		arg_190_1.state_ = "playing"
		arg_190_1.curTalkId_ = 120051046
		arg_190_1.duration_ = 2.8

		local var_190_0 = {
			zh = 2.8,
			ja = 2.7
		}
		local var_190_1 = manager.audio:GetLocalizationFlag()

		if var_190_0[var_190_1] ~= nil then
			arg_190_1.duration_ = var_190_0[var_190_1]
		end

		SetActive(arg_190_1.tipsGo_, false)

		function arg_190_1.onSingleLineFinish_()
			arg_190_1.onSingleLineUpdate_ = nil
			arg_190_1.onSingleLineFinish_ = nil
			arg_190_1.state_ = "waiting"
		end

		function arg_190_1.playNext_(arg_192_0)
			if arg_192_0 == 1 then
				arg_190_0:Play120051047(arg_190_1)
			end
		end

		function arg_190_1.onSingleLineUpdate_(arg_193_0)
			local var_193_0 = arg_190_1.actors_["1184ui_story"]
			local var_193_1 = 0

			if var_193_1 < arg_190_1.time_ and arg_190_1.time_ <= var_193_1 + arg_193_0 and not isNil(var_193_0) and arg_190_1.var_.characterEffect1184ui_story == nil then
				arg_190_1.var_.characterEffect1184ui_story = var_193_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_193_2 = 0.2

			if var_193_1 <= arg_190_1.time_ and arg_190_1.time_ < var_193_1 + var_193_2 and not isNil(var_193_0) then
				local var_193_3 = (arg_190_1.time_ - var_193_1) / var_193_2

				if arg_190_1.var_.characterEffect1184ui_story and not isNil(var_193_0) then
					arg_190_1.var_.characterEffect1184ui_story.fillFlat = false
				end
			end

			if arg_190_1.time_ >= var_193_1 + var_193_2 and arg_190_1.time_ < var_193_1 + var_193_2 + arg_193_0 and not isNil(var_193_0) and arg_190_1.var_.characterEffect1184ui_story then
				arg_190_1.var_.characterEffect1184ui_story.fillFlat = false
			end

			local var_193_4 = arg_190_1.actors_["1071ui_story"]
			local var_193_5 = 0

			if var_193_5 < arg_190_1.time_ and arg_190_1.time_ <= var_193_5 + arg_193_0 and not isNil(var_193_4) and arg_190_1.var_.characterEffect1071ui_story == nil then
				arg_190_1.var_.characterEffect1071ui_story = var_193_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_193_6 = 0.2

			if var_193_5 <= arg_190_1.time_ and arg_190_1.time_ < var_193_5 + var_193_6 and not isNil(var_193_4) then
				local var_193_7 = (arg_190_1.time_ - var_193_5) / var_193_6

				if arg_190_1.var_.characterEffect1071ui_story and not isNil(var_193_4) then
					local var_193_8 = Mathf.Lerp(0, 0.5, var_193_7)

					arg_190_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_190_1.var_.characterEffect1071ui_story.fillRatio = var_193_8
				end
			end

			if arg_190_1.time_ >= var_193_5 + var_193_6 and arg_190_1.time_ < var_193_5 + var_193_6 + arg_193_0 and not isNil(var_193_4) and arg_190_1.var_.characterEffect1071ui_story then
				local var_193_9 = 0.5

				arg_190_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_190_1.var_.characterEffect1071ui_story.fillRatio = var_193_9
			end

			local var_193_10 = 0
			local var_193_11 = 0.15

			if var_193_10 < arg_190_1.time_ and arg_190_1.time_ <= var_193_10 + arg_193_0 then
				arg_190_1.talkMaxDuration = 0
				arg_190_1.dialogCg_.alpha = 1

				arg_190_1.dialog_:SetActive(true)
				SetActive(arg_190_1.leftNameGo_, true)

				local var_193_12 = arg_190_1:FormatText(StoryNameCfg[6].name)

				arg_190_1.leftNameTxt_.text = var_193_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_190_1.leftNameTxt_.transform)

				arg_190_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_190_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_190_1:RecordName(arg_190_1.leftNameTxt_.text)
				SetActive(arg_190_1.iconTrs_.gameObject, false)
				arg_190_1.callingController_:SetSelectedState("normal")

				local var_193_13 = arg_190_1:GetWordFromCfg(120051046)
				local var_193_14 = arg_190_1:FormatText(var_193_13.content)

				arg_190_1.text_.text = var_193_14

				LuaForUtil.ClearLinePrefixSymbol(arg_190_1.text_)

				local var_193_15 = 6
				local var_193_16 = utf8.len(var_193_14)
				local var_193_17 = var_193_15 <= 0 and var_193_11 or var_193_11 * (var_193_16 / var_193_15)

				if var_193_17 > 0 and var_193_11 < var_193_17 then
					arg_190_1.talkMaxDuration = var_193_17

					if var_193_17 + var_193_10 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_17 + var_193_10
					end
				end

				arg_190_1.text_.text = var_193_14
				arg_190_1.typewritter.percent = 0

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120051", "120051046", "story_v_out_120051.awb") ~= 0 then
					local var_193_18 = manager.audio:GetVoiceLength("story_v_out_120051", "120051046", "story_v_out_120051.awb") / 1000

					if var_193_18 + var_193_10 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_18 + var_193_10
					end

					if var_193_13.prefab_name ~= "" and arg_190_1.actors_[var_193_13.prefab_name] ~= nil then
						local var_193_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_190_1.actors_[var_193_13.prefab_name].transform, "story_v_out_120051", "120051046", "story_v_out_120051.awb")

						arg_190_1:RecordAudio("120051046", var_193_19)
						arg_190_1:RecordAudio("120051046", var_193_19)
					else
						arg_190_1:AudioAction("play", "voice", "story_v_out_120051", "120051046", "story_v_out_120051.awb")
					end

					arg_190_1:RecordHistoryTalkVoice("story_v_out_120051", "120051046", "story_v_out_120051.awb")
				end

				arg_190_1:RecordContent(arg_190_1.text_.text)
			end

			local var_193_20 = math.max(var_193_11, arg_190_1.talkMaxDuration)

			if var_193_10 <= arg_190_1.time_ and arg_190_1.time_ < var_193_10 + var_193_20 then
				arg_190_1.typewritter.percent = (arg_190_1.time_ - var_193_10) / var_193_20

				arg_190_1.typewritter:SetDirty()
			end

			if arg_190_1.time_ >= var_193_10 + var_193_20 and arg_190_1.time_ < var_193_10 + var_193_20 + arg_193_0 then
				arg_190_1.typewritter.percent = 1

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(true)
			end
		end

		arg_190_1.nodeConfigList_ = {}

		arg_190_1:InitPlayNodeList()
	end,
	Play120051047 = function(arg_194_0, arg_194_1)
		arg_194_1.time_ = 0
		arg_194_1.frameCnt_ = 0
		arg_194_1.state_ = "playing"
		arg_194_1.curTalkId_ = 120051047
		arg_194_1.duration_ = 7.7

		local var_194_0 = {
			zh = 7.7,
			ja = 5.4
		}
		local var_194_1 = manager.audio:GetLocalizationFlag()

		if var_194_0[var_194_1] ~= nil then
			arg_194_1.duration_ = var_194_0[var_194_1]
		end

		SetActive(arg_194_1.tipsGo_, false)

		function arg_194_1.onSingleLineFinish_()
			arg_194_1.onSingleLineUpdate_ = nil
			arg_194_1.onSingleLineFinish_ = nil
			arg_194_1.state_ = "waiting"
		end

		function arg_194_1.playNext_(arg_196_0)
			if arg_196_0 == 1 then
				arg_194_0:Play120051048(arg_194_1)
			end
		end

		function arg_194_1.onSingleLineUpdate_(arg_197_0)
			local var_197_0 = arg_194_1.actors_["1184ui_story"]
			local var_197_1 = 0

			if var_197_1 < arg_194_1.time_ and arg_194_1.time_ <= var_197_1 + arg_197_0 and not isNil(var_197_0) and arg_194_1.var_.characterEffect1184ui_story == nil then
				arg_194_1.var_.characterEffect1184ui_story = var_197_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_197_2 = 0.2

			if var_197_1 <= arg_194_1.time_ and arg_194_1.time_ < var_197_1 + var_197_2 and not isNil(var_197_0) then
				local var_197_3 = (arg_194_1.time_ - var_197_1) / var_197_2

				if arg_194_1.var_.characterEffect1184ui_story and not isNil(var_197_0) then
					local var_197_4 = Mathf.Lerp(0, 0.5, var_197_3)

					arg_194_1.var_.characterEffect1184ui_story.fillFlat = true
					arg_194_1.var_.characterEffect1184ui_story.fillRatio = var_197_4
				end
			end

			if arg_194_1.time_ >= var_197_1 + var_197_2 and arg_194_1.time_ < var_197_1 + var_197_2 + arg_197_0 and not isNil(var_197_0) and arg_194_1.var_.characterEffect1184ui_story then
				local var_197_5 = 0.5

				arg_194_1.var_.characterEffect1184ui_story.fillFlat = true
				arg_194_1.var_.characterEffect1184ui_story.fillRatio = var_197_5
			end

			local var_197_6 = arg_194_1.actors_["1071ui_story"]
			local var_197_7 = 0

			if var_197_7 < arg_194_1.time_ and arg_194_1.time_ <= var_197_7 + arg_197_0 and not isNil(var_197_6) and arg_194_1.var_.characterEffect1071ui_story == nil then
				arg_194_1.var_.characterEffect1071ui_story = var_197_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_197_8 = 0.2

			if var_197_7 <= arg_194_1.time_ and arg_194_1.time_ < var_197_7 + var_197_8 and not isNil(var_197_6) then
				local var_197_9 = (arg_194_1.time_ - var_197_7) / var_197_8

				if arg_194_1.var_.characterEffect1071ui_story and not isNil(var_197_6) then
					arg_194_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_194_1.time_ >= var_197_7 + var_197_8 and arg_194_1.time_ < var_197_7 + var_197_8 + arg_197_0 and not isNil(var_197_6) and arg_194_1.var_.characterEffect1071ui_story then
				arg_194_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_197_10 = 0

			if var_197_10 < arg_194_1.time_ and arg_194_1.time_ <= var_197_10 + arg_197_0 then
				arg_194_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action5_1")
			end

			local var_197_11 = 0
			local var_197_12 = 0.9

			if var_197_11 < arg_194_1.time_ and arg_194_1.time_ <= var_197_11 + arg_197_0 then
				arg_194_1.talkMaxDuration = 0
				arg_194_1.dialogCg_.alpha = 1

				arg_194_1.dialog_:SetActive(true)
				SetActive(arg_194_1.leftNameGo_, true)

				local var_197_13 = arg_194_1:FormatText(StoryNameCfg[384].name)

				arg_194_1.leftNameTxt_.text = var_197_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_194_1.leftNameTxt_.transform)

				arg_194_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_194_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_194_1:RecordName(arg_194_1.leftNameTxt_.text)
				SetActive(arg_194_1.iconTrs_.gameObject, false)
				arg_194_1.callingController_:SetSelectedState("normal")

				local var_197_14 = arg_194_1:GetWordFromCfg(120051047)
				local var_197_15 = arg_194_1:FormatText(var_197_14.content)

				arg_194_1.text_.text = var_197_15

				LuaForUtil.ClearLinePrefixSymbol(arg_194_1.text_)

				local var_197_16 = 36
				local var_197_17 = utf8.len(var_197_15)
				local var_197_18 = var_197_16 <= 0 and var_197_12 or var_197_12 * (var_197_17 / var_197_16)

				if var_197_18 > 0 and var_197_12 < var_197_18 then
					arg_194_1.talkMaxDuration = var_197_18

					if var_197_18 + var_197_11 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_18 + var_197_11
					end
				end

				arg_194_1.text_.text = var_197_15
				arg_194_1.typewritter.percent = 0

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120051", "120051047", "story_v_out_120051.awb") ~= 0 then
					local var_197_19 = manager.audio:GetVoiceLength("story_v_out_120051", "120051047", "story_v_out_120051.awb") / 1000

					if var_197_19 + var_197_11 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_19 + var_197_11
					end

					if var_197_14.prefab_name ~= "" and arg_194_1.actors_[var_197_14.prefab_name] ~= nil then
						local var_197_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_194_1.actors_[var_197_14.prefab_name].transform, "story_v_out_120051", "120051047", "story_v_out_120051.awb")

						arg_194_1:RecordAudio("120051047", var_197_20)
						arg_194_1:RecordAudio("120051047", var_197_20)
					else
						arg_194_1:AudioAction("play", "voice", "story_v_out_120051", "120051047", "story_v_out_120051.awb")
					end

					arg_194_1:RecordHistoryTalkVoice("story_v_out_120051", "120051047", "story_v_out_120051.awb")
				end

				arg_194_1:RecordContent(arg_194_1.text_.text)
			end

			local var_197_21 = math.max(var_197_12, arg_194_1.talkMaxDuration)

			if var_197_11 <= arg_194_1.time_ and arg_194_1.time_ < var_197_11 + var_197_21 then
				arg_194_1.typewritter.percent = (arg_194_1.time_ - var_197_11) / var_197_21

				arg_194_1.typewritter:SetDirty()
			end

			if arg_194_1.time_ >= var_197_11 + var_197_21 and arg_194_1.time_ < var_197_11 + var_197_21 + arg_197_0 then
				arg_194_1.typewritter.percent = 1

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(true)
			end
		end

		arg_194_1.nodeConfigList_ = {}

		arg_194_1:InitPlayNodeList()
	end,
	Play120051048 = function(arg_198_0, arg_198_1)
		arg_198_1.time_ = 0
		arg_198_1.frameCnt_ = 0
		arg_198_1.state_ = "playing"
		arg_198_1.curTalkId_ = 120051048
		arg_198_1.duration_ = 6.37

		local var_198_0 = {
			zh = 6.366,
			ja = 5.633
		}
		local var_198_1 = manager.audio:GetLocalizationFlag()

		if var_198_0[var_198_1] ~= nil then
			arg_198_1.duration_ = var_198_0[var_198_1]
		end

		SetActive(arg_198_1.tipsGo_, false)

		function arg_198_1.onSingleLineFinish_()
			arg_198_1.onSingleLineUpdate_ = nil
			arg_198_1.onSingleLineFinish_ = nil
			arg_198_1.state_ = "waiting"
		end

		function arg_198_1.playNext_(arg_200_0)
			if arg_200_0 == 1 then
				arg_198_0:Play120051049(arg_198_1)
			end
		end

		function arg_198_1.onSingleLineUpdate_(arg_201_0)
			local var_201_0 = 0

			if var_201_0 < arg_198_1.time_ and arg_198_1.time_ <= var_201_0 + arg_201_0 then
				arg_198_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action5_2")
			end

			local var_201_1 = 0
			local var_201_2 = 0.625

			if var_201_1 < arg_198_1.time_ and arg_198_1.time_ <= var_201_1 + arg_201_0 then
				arg_198_1.talkMaxDuration = 0
				arg_198_1.dialogCg_.alpha = 1

				arg_198_1.dialog_:SetActive(true)
				SetActive(arg_198_1.leftNameGo_, true)

				local var_201_3 = arg_198_1:FormatText(StoryNameCfg[384].name)

				arg_198_1.leftNameTxt_.text = var_201_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_198_1.leftNameTxt_.transform)

				arg_198_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_198_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_198_1:RecordName(arg_198_1.leftNameTxt_.text)
				SetActive(arg_198_1.iconTrs_.gameObject, false)
				arg_198_1.callingController_:SetSelectedState("normal")

				local var_201_4 = arg_198_1:GetWordFromCfg(120051048)
				local var_201_5 = arg_198_1:FormatText(var_201_4.content)

				arg_198_1.text_.text = var_201_5

				LuaForUtil.ClearLinePrefixSymbol(arg_198_1.text_)

				local var_201_6 = 25
				local var_201_7 = utf8.len(var_201_5)
				local var_201_8 = var_201_6 <= 0 and var_201_2 or var_201_2 * (var_201_7 / var_201_6)

				if var_201_8 > 0 and var_201_2 < var_201_8 then
					arg_198_1.talkMaxDuration = var_201_8

					if var_201_8 + var_201_1 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_8 + var_201_1
					end
				end

				arg_198_1.text_.text = var_201_5
				arg_198_1.typewritter.percent = 0

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120051", "120051048", "story_v_out_120051.awb") ~= 0 then
					local var_201_9 = manager.audio:GetVoiceLength("story_v_out_120051", "120051048", "story_v_out_120051.awb") / 1000

					if var_201_9 + var_201_1 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_9 + var_201_1
					end

					if var_201_4.prefab_name ~= "" and arg_198_1.actors_[var_201_4.prefab_name] ~= nil then
						local var_201_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_198_1.actors_[var_201_4.prefab_name].transform, "story_v_out_120051", "120051048", "story_v_out_120051.awb")

						arg_198_1:RecordAudio("120051048", var_201_10)
						arg_198_1:RecordAudio("120051048", var_201_10)
					else
						arg_198_1:AudioAction("play", "voice", "story_v_out_120051", "120051048", "story_v_out_120051.awb")
					end

					arg_198_1:RecordHistoryTalkVoice("story_v_out_120051", "120051048", "story_v_out_120051.awb")
				end

				arg_198_1:RecordContent(arg_198_1.text_.text)
			end

			local var_201_11 = math.max(var_201_2, arg_198_1.talkMaxDuration)

			if var_201_1 <= arg_198_1.time_ and arg_198_1.time_ < var_201_1 + var_201_11 then
				arg_198_1.typewritter.percent = (arg_198_1.time_ - var_201_1) / var_201_11

				arg_198_1.typewritter:SetDirty()
			end

			if arg_198_1.time_ >= var_201_1 + var_201_11 and arg_198_1.time_ < var_201_1 + var_201_11 + arg_201_0 then
				arg_198_1.typewritter.percent = 1

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(true)
			end
		end

		arg_198_1.nodeConfigList_ = {}

		arg_198_1:InitPlayNodeList()
	end,
	Play120051049 = function(arg_202_0, arg_202_1)
		arg_202_1.time_ = 0
		arg_202_1.frameCnt_ = 0
		arg_202_1.state_ = "playing"
		arg_202_1.curTalkId_ = 120051049
		arg_202_1.duration_ = 5

		SetActive(arg_202_1.tipsGo_, false)

		function arg_202_1.onSingleLineFinish_()
			arg_202_1.onSingleLineUpdate_ = nil
			arg_202_1.onSingleLineFinish_ = nil
			arg_202_1.state_ = "waiting"
		end

		function arg_202_1.playNext_(arg_204_0)
			if arg_204_0 == 1 then
				arg_202_0:Play120051050(arg_202_1)
			end
		end

		function arg_202_1.onSingleLineUpdate_(arg_205_0)
			local var_205_0 = arg_202_1.actors_["1071ui_story"]
			local var_205_1 = 0

			if var_205_1 < arg_202_1.time_ and arg_202_1.time_ <= var_205_1 + arg_205_0 and not isNil(var_205_0) and arg_202_1.var_.characterEffect1071ui_story == nil then
				arg_202_1.var_.characterEffect1071ui_story = var_205_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_205_2 = 0.2

			if var_205_1 <= arg_202_1.time_ and arg_202_1.time_ < var_205_1 + var_205_2 and not isNil(var_205_0) then
				local var_205_3 = (arg_202_1.time_ - var_205_1) / var_205_2

				if arg_202_1.var_.characterEffect1071ui_story and not isNil(var_205_0) then
					local var_205_4 = Mathf.Lerp(0, 0.5, var_205_3)

					arg_202_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_202_1.var_.characterEffect1071ui_story.fillRatio = var_205_4
				end
			end

			if arg_202_1.time_ >= var_205_1 + var_205_2 and arg_202_1.time_ < var_205_1 + var_205_2 + arg_205_0 and not isNil(var_205_0) and arg_202_1.var_.characterEffect1071ui_story then
				local var_205_5 = 0.5

				arg_202_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_202_1.var_.characterEffect1071ui_story.fillRatio = var_205_5
			end

			local var_205_6 = 0
			local var_205_7 = 0.575

			if var_205_6 < arg_202_1.time_ and arg_202_1.time_ <= var_205_6 + arg_205_0 then
				arg_202_1.talkMaxDuration = 0
				arg_202_1.dialogCg_.alpha = 1

				arg_202_1.dialog_:SetActive(true)
				SetActive(arg_202_1.leftNameGo_, true)

				local var_205_8 = arg_202_1:FormatText(StoryNameCfg[7].name)

				arg_202_1.leftNameTxt_.text = var_205_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_202_1.leftNameTxt_.transform)

				arg_202_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_202_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_202_1:RecordName(arg_202_1.leftNameTxt_.text)
				SetActive(arg_202_1.iconTrs_.gameObject, true)
				arg_202_1.iconController_:SetSelectedState("hero")

				arg_202_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_202_1.callingController_:SetSelectedState("normal")

				arg_202_1.keyicon_.color = Color.New(1, 1, 1)
				arg_202_1.icon_.color = Color.New(1, 1, 1)

				local var_205_9 = arg_202_1:GetWordFromCfg(120051049)
				local var_205_10 = arg_202_1:FormatText(var_205_9.content)

				arg_202_1.text_.text = var_205_10

				LuaForUtil.ClearLinePrefixSymbol(arg_202_1.text_)

				local var_205_11 = 23
				local var_205_12 = utf8.len(var_205_10)
				local var_205_13 = var_205_11 <= 0 and var_205_7 or var_205_7 * (var_205_12 / var_205_11)

				if var_205_13 > 0 and var_205_7 < var_205_13 then
					arg_202_1.talkMaxDuration = var_205_13

					if var_205_13 + var_205_6 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_13 + var_205_6
					end
				end

				arg_202_1.text_.text = var_205_10
				arg_202_1.typewritter.percent = 0

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(false)
				arg_202_1:RecordContent(arg_202_1.text_.text)
			end

			local var_205_14 = math.max(var_205_7, arg_202_1.talkMaxDuration)

			if var_205_6 <= arg_202_1.time_ and arg_202_1.time_ < var_205_6 + var_205_14 then
				arg_202_1.typewritter.percent = (arg_202_1.time_ - var_205_6) / var_205_14

				arg_202_1.typewritter:SetDirty()
			end

			if arg_202_1.time_ >= var_205_6 + var_205_14 and arg_202_1.time_ < var_205_6 + var_205_14 + arg_205_0 then
				arg_202_1.typewritter.percent = 1

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(true)
			end
		end

		arg_202_1.nodeConfigList_ = {}

		arg_202_1:InitPlayNodeList()
	end,
	Play120051050 = function(arg_206_0, arg_206_1)
		arg_206_1.time_ = 0
		arg_206_1.frameCnt_ = 0
		arg_206_1.state_ = "playing"
		arg_206_1.curTalkId_ = 120051050
		arg_206_1.duration_ = 5

		SetActive(arg_206_1.tipsGo_, false)

		function arg_206_1.onSingleLineFinish_()
			arg_206_1.onSingleLineUpdate_ = nil
			arg_206_1.onSingleLineFinish_ = nil
			arg_206_1.state_ = "waiting"
		end

		function arg_206_1.playNext_(arg_208_0)
			if arg_208_0 == 1 then
				arg_206_0:Play120051051(arg_206_1)
			end
		end

		function arg_206_1.onSingleLineUpdate_(arg_209_0)
			local var_209_0 = arg_206_1.actors_["1184ui_story"].transform
			local var_209_1 = 0

			if var_209_1 < arg_206_1.time_ and arg_206_1.time_ <= var_209_1 + arg_209_0 then
				arg_206_1.var_.moveOldPos1184ui_story = var_209_0.localPosition
			end

			local var_209_2 = 0.001

			if var_209_1 <= arg_206_1.time_ and arg_206_1.time_ < var_209_1 + var_209_2 then
				local var_209_3 = (arg_206_1.time_ - var_209_1) / var_209_2
				local var_209_4 = Vector3.New(0, 100, 0)

				var_209_0.localPosition = Vector3.Lerp(arg_206_1.var_.moveOldPos1184ui_story, var_209_4, var_209_3)

				local var_209_5 = manager.ui.mainCamera.transform.position - var_209_0.position

				var_209_0.forward = Vector3.New(var_209_5.x, var_209_5.y, var_209_5.z)

				local var_209_6 = var_209_0.localEulerAngles

				var_209_6.z = 0
				var_209_6.x = 0
				var_209_0.localEulerAngles = var_209_6
			end

			if arg_206_1.time_ >= var_209_1 + var_209_2 and arg_206_1.time_ < var_209_1 + var_209_2 + arg_209_0 then
				var_209_0.localPosition = Vector3.New(0, 100, 0)

				local var_209_7 = manager.ui.mainCamera.transform.position - var_209_0.position

				var_209_0.forward = Vector3.New(var_209_7.x, var_209_7.y, var_209_7.z)

				local var_209_8 = var_209_0.localEulerAngles

				var_209_8.z = 0
				var_209_8.x = 0
				var_209_0.localEulerAngles = var_209_8
			end

			local var_209_9 = arg_206_1.actors_["1071ui_story"].transform
			local var_209_10 = 0

			if var_209_10 < arg_206_1.time_ and arg_206_1.time_ <= var_209_10 + arg_209_0 then
				arg_206_1.var_.moveOldPos1071ui_story = var_209_9.localPosition
			end

			local var_209_11 = 0.001

			if var_209_10 <= arg_206_1.time_ and arg_206_1.time_ < var_209_10 + var_209_11 then
				local var_209_12 = (arg_206_1.time_ - var_209_10) / var_209_11
				local var_209_13 = Vector3.New(0, 100, 0)

				var_209_9.localPosition = Vector3.Lerp(arg_206_1.var_.moveOldPos1071ui_story, var_209_13, var_209_12)

				local var_209_14 = manager.ui.mainCamera.transform.position - var_209_9.position

				var_209_9.forward = Vector3.New(var_209_14.x, var_209_14.y, var_209_14.z)

				local var_209_15 = var_209_9.localEulerAngles

				var_209_15.z = 0
				var_209_15.x = 0
				var_209_9.localEulerAngles = var_209_15
			end

			if arg_206_1.time_ >= var_209_10 + var_209_11 and arg_206_1.time_ < var_209_10 + var_209_11 + arg_209_0 then
				var_209_9.localPosition = Vector3.New(0, 100, 0)

				local var_209_16 = manager.ui.mainCamera.transform.position - var_209_9.position

				var_209_9.forward = Vector3.New(var_209_16.x, var_209_16.y, var_209_16.z)

				local var_209_17 = var_209_9.localEulerAngles

				var_209_17.z = 0
				var_209_17.x = 0
				var_209_9.localEulerAngles = var_209_17
			end

			local var_209_18 = 0
			local var_209_19 = 1.025

			if var_209_18 < arg_206_1.time_ and arg_206_1.time_ <= var_209_18 + arg_209_0 then
				arg_206_1.talkMaxDuration = 0
				arg_206_1.dialogCg_.alpha = 1

				arg_206_1.dialog_:SetActive(true)
				SetActive(arg_206_1.leftNameGo_, false)

				arg_206_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_206_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_206_1:RecordName(arg_206_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_206_1.iconTrs_.gameObject, false)
				arg_206_1.callingController_:SetSelectedState("normal")

				local var_209_20 = arg_206_1:GetWordFromCfg(120051050)
				local var_209_21 = arg_206_1:FormatText(var_209_20.content)

				arg_206_1.text_.text = var_209_21

				LuaForUtil.ClearLinePrefixSymbol(arg_206_1.text_)

				local var_209_22 = 41
				local var_209_23 = utf8.len(var_209_21)
				local var_209_24 = var_209_22 <= 0 and var_209_19 or var_209_19 * (var_209_23 / var_209_22)

				if var_209_24 > 0 and var_209_19 < var_209_24 then
					arg_206_1.talkMaxDuration = var_209_24

					if var_209_24 + var_209_18 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_24 + var_209_18
					end
				end

				arg_206_1.text_.text = var_209_21
				arg_206_1.typewritter.percent = 0

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(false)
				arg_206_1:RecordContent(arg_206_1.text_.text)
			end

			local var_209_25 = math.max(var_209_19, arg_206_1.talkMaxDuration)

			if var_209_18 <= arg_206_1.time_ and arg_206_1.time_ < var_209_18 + var_209_25 then
				arg_206_1.typewritter.percent = (arg_206_1.time_ - var_209_18) / var_209_25

				arg_206_1.typewritter:SetDirty()
			end

			if arg_206_1.time_ >= var_209_18 + var_209_25 and arg_206_1.time_ < var_209_18 + var_209_25 + arg_209_0 then
				arg_206_1.typewritter.percent = 1

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(true)
			end
		end

		arg_206_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1184ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_206_1:InitPlayNodeList()
	end,
	Play120051051 = function(arg_210_0, arg_210_1)
		arg_210_1.time_ = 0
		arg_210_1.frameCnt_ = 0
		arg_210_1.state_ = "playing"
		arg_210_1.curTalkId_ = 120051051
		arg_210_1.duration_ = 9

		SetActive(arg_210_1.tipsGo_, false)

		function arg_210_1.onSingleLineFinish_()
			arg_210_1.onSingleLineUpdate_ = nil
			arg_210_1.onSingleLineFinish_ = nil
			arg_210_1.state_ = "waiting"
		end

		function arg_210_1.playNext_(arg_212_0)
			if arg_212_0 == 1 then
				arg_210_0:Play120051052(arg_210_1)
			end
		end

		function arg_210_1.onSingleLineUpdate_(arg_213_0)
			local var_213_0 = 2

			if var_213_0 < arg_210_1.time_ and arg_210_1.time_ <= var_213_0 + arg_213_0 then
				local var_213_1 = manager.ui.mainCamera.transform.localPosition
				local var_213_2 = Vector3.New(0, 0, 10) + Vector3.New(var_213_1.x, var_213_1.y, 0)
				local var_213_3 = arg_210_1.bgs_.J03f

				var_213_3.transform.localPosition = var_213_2
				var_213_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_213_4 = var_213_3:GetComponent("SpriteRenderer")

				if var_213_4 and var_213_4.sprite then
					local var_213_5 = (var_213_3.transform.localPosition - var_213_1).z
					local var_213_6 = manager.ui.mainCameraCom_
					local var_213_7 = 2 * var_213_5 * Mathf.Tan(var_213_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_213_8 = var_213_7 * var_213_6.aspect
					local var_213_9 = var_213_4.sprite.bounds.size.x
					local var_213_10 = var_213_4.sprite.bounds.size.y
					local var_213_11 = var_213_8 / var_213_9
					local var_213_12 = var_213_7 / var_213_10
					local var_213_13 = var_213_12 < var_213_11 and var_213_11 or var_213_12

					var_213_3.transform.localScale = Vector3.New(var_213_13, var_213_13, 0)
				end

				for iter_213_0, iter_213_1 in pairs(arg_210_1.bgs_) do
					if iter_213_0 ~= "J03f" then
						iter_213_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_213_14 = 0

			if var_213_14 < arg_210_1.time_ and arg_210_1.time_ <= var_213_14 + arg_213_0 then
				arg_210_1.mask_.enabled = true
				arg_210_1.mask_.raycastTarget = true

				arg_210_1:SetGaussion(false)
			end

			local var_213_15 = 2

			if var_213_14 <= arg_210_1.time_ and arg_210_1.time_ < var_213_14 + var_213_15 then
				local var_213_16 = (arg_210_1.time_ - var_213_14) / var_213_15
				local var_213_17 = Color.New(0, 0, 0)

				var_213_17.a = Mathf.Lerp(0, 1, var_213_16)
				arg_210_1.mask_.color = var_213_17
			end

			if arg_210_1.time_ >= var_213_14 + var_213_15 and arg_210_1.time_ < var_213_14 + var_213_15 + arg_213_0 then
				local var_213_18 = Color.New(0, 0, 0)

				var_213_18.a = 1
				arg_210_1.mask_.color = var_213_18
			end

			local var_213_19 = 2

			if var_213_19 < arg_210_1.time_ and arg_210_1.time_ <= var_213_19 + arg_213_0 then
				arg_210_1.mask_.enabled = true
				arg_210_1.mask_.raycastTarget = true

				arg_210_1:SetGaussion(false)
			end

			local var_213_20 = 2

			if var_213_19 <= arg_210_1.time_ and arg_210_1.time_ < var_213_19 + var_213_20 then
				local var_213_21 = (arg_210_1.time_ - var_213_19) / var_213_20
				local var_213_22 = Color.New(0, 0, 0)

				var_213_22.a = Mathf.Lerp(1, 0, var_213_21)
				arg_210_1.mask_.color = var_213_22
			end

			if arg_210_1.time_ >= var_213_19 + var_213_20 and arg_210_1.time_ < var_213_19 + var_213_20 + arg_213_0 then
				local var_213_23 = Color.New(0, 0, 0)
				local var_213_24 = 0

				arg_210_1.mask_.enabled = false
				var_213_23.a = var_213_24
				arg_210_1.mask_.color = var_213_23
			end

			if arg_210_1.frameCnt_ <= 1 then
				arg_210_1.dialog_:SetActive(false)
			end

			local var_213_25 = 4
			local var_213_26 = 1

			if var_213_25 < arg_210_1.time_ and arg_210_1.time_ <= var_213_25 + arg_213_0 then
				arg_210_1.talkMaxDuration = 0

				arg_210_1.dialog_:SetActive(true)

				arg_210_1.dialogCg_.alpha = 0

				local var_213_27 = LeanTween.value(arg_210_1.dialog_, 0, 1, 0.3)

				var_213_27:setOnUpdate(LuaHelper.FloatAction(function(arg_214_0)
					arg_210_1.dialogCg_.alpha = arg_214_0
				end))
				var_213_27:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_210_1.dialog_)
					var_213_27:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_210_1.duration_ = arg_210_1.duration_ + 0.3

				SetActive(arg_210_1.leftNameGo_, false)

				arg_210_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_210_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_210_1:RecordName(arg_210_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_210_1.iconTrs_.gameObject, false)
				arg_210_1.callingController_:SetSelectedState("normal")

				local var_213_28 = arg_210_1:GetWordFromCfg(120051051)
				local var_213_29 = arg_210_1:FormatText(var_213_28.content)

				arg_210_1.text_.text = var_213_29

				LuaForUtil.ClearLinePrefixSymbol(arg_210_1.text_)

				local var_213_30 = 40
				local var_213_31 = utf8.len(var_213_29)
				local var_213_32 = var_213_30 <= 0 and var_213_26 or var_213_26 * (var_213_31 / var_213_30)

				if var_213_32 > 0 and var_213_26 < var_213_32 then
					arg_210_1.talkMaxDuration = var_213_32
					var_213_25 = var_213_25 + 0.3

					if var_213_32 + var_213_25 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_32 + var_213_25
					end
				end

				arg_210_1.text_.text = var_213_29
				arg_210_1.typewritter.percent = 0

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(false)
				arg_210_1:RecordContent(arg_210_1.text_.text)
			end

			local var_213_33 = var_213_25 + 0.3
			local var_213_34 = math.max(var_213_26, arg_210_1.talkMaxDuration)

			if var_213_33 <= arg_210_1.time_ and arg_210_1.time_ < var_213_33 + var_213_34 then
				arg_210_1.typewritter.percent = (arg_210_1.time_ - var_213_33) / var_213_34

				arg_210_1.typewritter:SetDirty()
			end

			if arg_210_1.time_ >= var_213_33 + var_213_34 and arg_210_1.time_ < var_213_33 + var_213_34 + arg_213_0 then
				arg_210_1.typewritter.percent = 1

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(true)
			end
		end

		arg_210_1.nodeConfigList_ = {}

		arg_210_1:InitPlayNodeList()
	end,
	Play120051052 = function(arg_216_0, arg_216_1)
		arg_216_1.time_ = 0
		arg_216_1.frameCnt_ = 0
		arg_216_1.state_ = "playing"
		arg_216_1.curTalkId_ = 120051052
		arg_216_1.duration_ = 5

		SetActive(arg_216_1.tipsGo_, false)

		function arg_216_1.onSingleLineFinish_()
			arg_216_1.onSingleLineUpdate_ = nil
			arg_216_1.onSingleLineFinish_ = nil
			arg_216_1.state_ = "waiting"
		end

		function arg_216_1.playNext_(arg_218_0)
			if arg_218_0 == 1 then
				arg_216_0:Play120051053(arg_216_1)
			end
		end

		function arg_216_1.onSingleLineUpdate_(arg_219_0)
			local var_219_0 = 0
			local var_219_1 = 1.025

			if var_219_0 < arg_216_1.time_ and arg_216_1.time_ <= var_219_0 + arg_219_0 then
				arg_216_1.talkMaxDuration = 0
				arg_216_1.dialogCg_.alpha = 1

				arg_216_1.dialog_:SetActive(true)
				SetActive(arg_216_1.leftNameGo_, false)

				arg_216_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_216_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_216_1:RecordName(arg_216_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_216_1.iconTrs_.gameObject, false)
				arg_216_1.callingController_:SetSelectedState("normal")

				local var_219_2 = arg_216_1:GetWordFromCfg(120051052)
				local var_219_3 = arg_216_1:FormatText(var_219_2.content)

				arg_216_1.text_.text = var_219_3

				LuaForUtil.ClearLinePrefixSymbol(arg_216_1.text_)

				local var_219_4 = 41
				local var_219_5 = utf8.len(var_219_3)
				local var_219_6 = var_219_4 <= 0 and var_219_1 or var_219_1 * (var_219_5 / var_219_4)

				if var_219_6 > 0 and var_219_1 < var_219_6 then
					arg_216_1.talkMaxDuration = var_219_6

					if var_219_6 + var_219_0 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_6 + var_219_0
					end
				end

				arg_216_1.text_.text = var_219_3
				arg_216_1.typewritter.percent = 0

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(false)
				arg_216_1:RecordContent(arg_216_1.text_.text)
			end

			local var_219_7 = math.max(var_219_1, arg_216_1.talkMaxDuration)

			if var_219_0 <= arg_216_1.time_ and arg_216_1.time_ < var_219_0 + var_219_7 then
				arg_216_1.typewritter.percent = (arg_216_1.time_ - var_219_0) / var_219_7

				arg_216_1.typewritter:SetDirty()
			end

			if arg_216_1.time_ >= var_219_0 + var_219_7 and arg_216_1.time_ < var_219_0 + var_219_7 + arg_219_0 then
				arg_216_1.typewritter.percent = 1

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(true)
			end
		end

		arg_216_1.nodeConfigList_ = {}

		arg_216_1:InitPlayNodeList()
	end,
	Play120051053 = function(arg_220_0, arg_220_1)
		arg_220_1.time_ = 0
		arg_220_1.frameCnt_ = 0
		arg_220_1.state_ = "playing"
		arg_220_1.curTalkId_ = 120051053
		arg_220_1.duration_ = 2.9

		SetActive(arg_220_1.tipsGo_, false)

		function arg_220_1.onSingleLineFinish_()
			arg_220_1.onSingleLineUpdate_ = nil
			arg_220_1.onSingleLineFinish_ = nil
			arg_220_1.state_ = "waiting"
		end

		function arg_220_1.playNext_(arg_222_0)
			if arg_222_0 == 1 then
				arg_220_0:Play120051054(arg_220_1)
			end
		end

		function arg_220_1.onSingleLineUpdate_(arg_223_0)
			local var_223_0 = arg_220_1.actors_["1184ui_story"].transform
			local var_223_1 = 0

			if var_223_1 < arg_220_1.time_ and arg_220_1.time_ <= var_223_1 + arg_223_0 then
				arg_220_1.var_.moveOldPos1184ui_story = var_223_0.localPosition
			end

			local var_223_2 = 0.001

			if var_223_1 <= arg_220_1.time_ and arg_220_1.time_ < var_223_1 + var_223_2 then
				local var_223_3 = (arg_220_1.time_ - var_223_1) / var_223_2
				local var_223_4 = Vector3.New(-0.7, -0.97, -6)

				var_223_0.localPosition = Vector3.Lerp(arg_220_1.var_.moveOldPos1184ui_story, var_223_4, var_223_3)

				local var_223_5 = manager.ui.mainCamera.transform.position - var_223_0.position

				var_223_0.forward = Vector3.New(var_223_5.x, var_223_5.y, var_223_5.z)

				local var_223_6 = var_223_0.localEulerAngles

				var_223_6.z = 0
				var_223_6.x = 0
				var_223_0.localEulerAngles = var_223_6
			end

			if arg_220_1.time_ >= var_223_1 + var_223_2 and arg_220_1.time_ < var_223_1 + var_223_2 + arg_223_0 then
				var_223_0.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_223_7 = manager.ui.mainCamera.transform.position - var_223_0.position

				var_223_0.forward = Vector3.New(var_223_7.x, var_223_7.y, var_223_7.z)

				local var_223_8 = var_223_0.localEulerAngles

				var_223_8.z = 0
				var_223_8.x = 0
				var_223_0.localEulerAngles = var_223_8
			end

			local var_223_9 = arg_220_1.actors_["1069ui_story"].transform
			local var_223_10 = 0

			if var_223_10 < arg_220_1.time_ and arg_220_1.time_ <= var_223_10 + arg_223_0 then
				arg_220_1.var_.moveOldPos1069ui_story = var_223_9.localPosition
			end

			local var_223_11 = 0.001

			if var_223_10 <= arg_220_1.time_ and arg_220_1.time_ < var_223_10 + var_223_11 then
				local var_223_12 = (arg_220_1.time_ - var_223_10) / var_223_11
				local var_223_13 = Vector3.New(0.7, -1, -6)

				var_223_9.localPosition = Vector3.Lerp(arg_220_1.var_.moveOldPos1069ui_story, var_223_13, var_223_12)

				local var_223_14 = manager.ui.mainCamera.transform.position - var_223_9.position

				var_223_9.forward = Vector3.New(var_223_14.x, var_223_14.y, var_223_14.z)

				local var_223_15 = var_223_9.localEulerAngles

				var_223_15.z = 0
				var_223_15.x = 0
				var_223_9.localEulerAngles = var_223_15
			end

			if arg_220_1.time_ >= var_223_10 + var_223_11 and arg_220_1.time_ < var_223_10 + var_223_11 + arg_223_0 then
				var_223_9.localPosition = Vector3.New(0.7, -1, -6)

				local var_223_16 = manager.ui.mainCamera.transform.position - var_223_9.position

				var_223_9.forward = Vector3.New(var_223_16.x, var_223_16.y, var_223_16.z)

				local var_223_17 = var_223_9.localEulerAngles

				var_223_17.z = 0
				var_223_17.x = 0
				var_223_9.localEulerAngles = var_223_17
			end

			local var_223_18 = arg_220_1.actors_["1184ui_story"]
			local var_223_19 = 0

			if var_223_19 < arg_220_1.time_ and arg_220_1.time_ <= var_223_19 + arg_223_0 and not isNil(var_223_18) and arg_220_1.var_.characterEffect1184ui_story == nil then
				arg_220_1.var_.characterEffect1184ui_story = var_223_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_223_20 = 0.2

			if var_223_19 <= arg_220_1.time_ and arg_220_1.time_ < var_223_19 + var_223_20 and not isNil(var_223_18) then
				local var_223_21 = (arg_220_1.time_ - var_223_19) / var_223_20

				if arg_220_1.var_.characterEffect1184ui_story and not isNil(var_223_18) then
					arg_220_1.var_.characterEffect1184ui_story.fillFlat = false
				end
			end

			if arg_220_1.time_ >= var_223_19 + var_223_20 and arg_220_1.time_ < var_223_19 + var_223_20 + arg_223_0 and not isNil(var_223_18) and arg_220_1.var_.characterEffect1184ui_story then
				arg_220_1.var_.characterEffect1184ui_story.fillFlat = false
			end

			local var_223_22 = arg_220_1.actors_["1069ui_story"]
			local var_223_23 = 0

			if var_223_23 < arg_220_1.time_ and arg_220_1.time_ <= var_223_23 + arg_223_0 and not isNil(var_223_22) and arg_220_1.var_.characterEffect1069ui_story == nil then
				arg_220_1.var_.characterEffect1069ui_story = var_223_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_223_24 = 0.2

			if var_223_23 <= arg_220_1.time_ and arg_220_1.time_ < var_223_23 + var_223_24 and not isNil(var_223_22) then
				local var_223_25 = (arg_220_1.time_ - var_223_23) / var_223_24

				if arg_220_1.var_.characterEffect1069ui_story and not isNil(var_223_22) then
					local var_223_26 = Mathf.Lerp(0, 0.5, var_223_25)

					arg_220_1.var_.characterEffect1069ui_story.fillFlat = true
					arg_220_1.var_.characterEffect1069ui_story.fillRatio = var_223_26
				end
			end

			if arg_220_1.time_ >= var_223_23 + var_223_24 and arg_220_1.time_ < var_223_23 + var_223_24 + arg_223_0 and not isNil(var_223_22) and arg_220_1.var_.characterEffect1069ui_story then
				local var_223_27 = 0.5

				arg_220_1.var_.characterEffect1069ui_story.fillFlat = true
				arg_220_1.var_.characterEffect1069ui_story.fillRatio = var_223_27
			end

			local var_223_28 = 0

			if var_223_28 < arg_220_1.time_ and arg_220_1.time_ <= var_223_28 + arg_223_0 then
				arg_220_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action6_1")
			end

			local var_223_29 = 0

			if var_223_29 < arg_220_1.time_ and arg_220_1.time_ <= var_223_29 + arg_223_0 then
				arg_220_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_223_30 = 0

			if var_223_30 < arg_220_1.time_ and arg_220_1.time_ <= var_223_30 + arg_223_0 then
				arg_220_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/story1069/story1069action/1069action4_1")
			end

			local var_223_31 = 0
			local var_223_32 = 0.25

			if var_223_31 < arg_220_1.time_ and arg_220_1.time_ <= var_223_31 + arg_223_0 then
				arg_220_1.talkMaxDuration = 0
				arg_220_1.dialogCg_.alpha = 1

				arg_220_1.dialog_:SetActive(true)
				SetActive(arg_220_1.leftNameGo_, true)

				local var_223_33 = arg_220_1:FormatText(StoryNameCfg[6].name)

				arg_220_1.leftNameTxt_.text = var_223_33

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_220_1.leftNameTxt_.transform)

				arg_220_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_220_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_220_1:RecordName(arg_220_1.leftNameTxt_.text)
				SetActive(arg_220_1.iconTrs_.gameObject, false)
				arg_220_1.callingController_:SetSelectedState("normal")

				local var_223_34 = arg_220_1:GetWordFromCfg(120051053)
				local var_223_35 = arg_220_1:FormatText(var_223_34.content)

				arg_220_1.text_.text = var_223_35

				LuaForUtil.ClearLinePrefixSymbol(arg_220_1.text_)

				local var_223_36 = 10
				local var_223_37 = utf8.len(var_223_35)
				local var_223_38 = var_223_36 <= 0 and var_223_32 or var_223_32 * (var_223_37 / var_223_36)

				if var_223_38 > 0 and var_223_32 < var_223_38 then
					arg_220_1.talkMaxDuration = var_223_38

					if var_223_38 + var_223_31 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_38 + var_223_31
					end
				end

				arg_220_1.text_.text = var_223_35
				arg_220_1.typewritter.percent = 0

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120051", "120051053", "story_v_out_120051.awb") ~= 0 then
					local var_223_39 = manager.audio:GetVoiceLength("story_v_out_120051", "120051053", "story_v_out_120051.awb") / 1000

					if var_223_39 + var_223_31 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_39 + var_223_31
					end

					if var_223_34.prefab_name ~= "" and arg_220_1.actors_[var_223_34.prefab_name] ~= nil then
						local var_223_40 = LuaForUtil.PlayVoiceWithCriLipsync(arg_220_1.actors_[var_223_34.prefab_name].transform, "story_v_out_120051", "120051053", "story_v_out_120051.awb")

						arg_220_1:RecordAudio("120051053", var_223_40)
						arg_220_1:RecordAudio("120051053", var_223_40)
					else
						arg_220_1:AudioAction("play", "voice", "story_v_out_120051", "120051053", "story_v_out_120051.awb")
					end

					arg_220_1:RecordHistoryTalkVoice("story_v_out_120051", "120051053", "story_v_out_120051.awb")
				end

				arg_220_1:RecordContent(arg_220_1.text_.text)
			end

			local var_223_41 = math.max(var_223_32, arg_220_1.talkMaxDuration)

			if var_223_31 <= arg_220_1.time_ and arg_220_1.time_ < var_223_31 + var_223_41 then
				arg_220_1.typewritter.percent = (arg_220_1.time_ - var_223_31) / var_223_41

				arg_220_1.typewritter:SetDirty()
			end

			if arg_220_1.time_ >= var_223_31 + var_223_41 and arg_220_1.time_ < var_223_31 + var_223_41 + arg_223_0 then
				arg_220_1.typewritter.percent = 1

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(true)
			end
		end

		arg_220_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1184ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_220_1:InitPlayNodeList()
	end,
	Play120051054 = function(arg_224_0, arg_224_1)
		arg_224_1.time_ = 0
		arg_224_1.frameCnt_ = 0
		arg_224_1.state_ = "playing"
		arg_224_1.curTalkId_ = 120051054
		arg_224_1.duration_ = 5.23

		local var_224_0 = {
			zh = 4.2,
			ja = 5.233
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
				arg_224_0:Play120051055(arg_224_1)
			end
		end

		function arg_224_1.onSingleLineUpdate_(arg_227_0)
			local var_227_0 = arg_224_1.actors_["1184ui_story"]
			local var_227_1 = 0

			if var_227_1 < arg_224_1.time_ and arg_224_1.time_ <= var_227_1 + arg_227_0 and not isNil(var_227_0) and arg_224_1.var_.characterEffect1184ui_story == nil then
				arg_224_1.var_.characterEffect1184ui_story = var_227_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_227_2 = 0.2

			if var_227_1 <= arg_224_1.time_ and arg_224_1.time_ < var_227_1 + var_227_2 and not isNil(var_227_0) then
				local var_227_3 = (arg_224_1.time_ - var_227_1) / var_227_2

				if arg_224_1.var_.characterEffect1184ui_story and not isNil(var_227_0) then
					local var_227_4 = Mathf.Lerp(0, 0.5, var_227_3)

					arg_224_1.var_.characterEffect1184ui_story.fillFlat = true
					arg_224_1.var_.characterEffect1184ui_story.fillRatio = var_227_4
				end
			end

			if arg_224_1.time_ >= var_227_1 + var_227_2 and arg_224_1.time_ < var_227_1 + var_227_2 + arg_227_0 and not isNil(var_227_0) and arg_224_1.var_.characterEffect1184ui_story then
				local var_227_5 = 0.5

				arg_224_1.var_.characterEffect1184ui_story.fillFlat = true
				arg_224_1.var_.characterEffect1184ui_story.fillRatio = var_227_5
			end

			local var_227_6 = arg_224_1.actors_["1069ui_story"]
			local var_227_7 = 0

			if var_227_7 < arg_224_1.time_ and arg_224_1.time_ <= var_227_7 + arg_227_0 and not isNil(var_227_6) and arg_224_1.var_.characterEffect1069ui_story == nil then
				arg_224_1.var_.characterEffect1069ui_story = var_227_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_227_8 = 0.2

			if var_227_7 <= arg_224_1.time_ and arg_224_1.time_ < var_227_7 + var_227_8 and not isNil(var_227_6) then
				local var_227_9 = (arg_224_1.time_ - var_227_7) / var_227_8

				if arg_224_1.var_.characterEffect1069ui_story and not isNil(var_227_6) then
					arg_224_1.var_.characterEffect1069ui_story.fillFlat = false
				end
			end

			if arg_224_1.time_ >= var_227_7 + var_227_8 and arg_224_1.time_ < var_227_7 + var_227_8 + arg_227_0 and not isNil(var_227_6) and arg_224_1.var_.characterEffect1069ui_story then
				arg_224_1.var_.characterEffect1069ui_story.fillFlat = false
			end

			local var_227_10 = 0

			if var_227_10 < arg_224_1.time_ and arg_224_1.time_ <= var_227_10 + arg_227_0 then
				arg_224_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/story1069/story1069actionlink/1069action442")
			end

			local var_227_11 = 0

			if var_227_11 < arg_224_1.time_ and arg_224_1.time_ <= var_227_11 + arg_227_0 then
				arg_224_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_227_12 = 0
			local var_227_13 = 0.425

			if var_227_12 < arg_224_1.time_ and arg_224_1.time_ <= var_227_12 + arg_227_0 then
				arg_224_1.talkMaxDuration = 0
				arg_224_1.dialogCg_.alpha = 1

				arg_224_1.dialog_:SetActive(true)
				SetActive(arg_224_1.leftNameGo_, true)

				local var_227_14 = arg_224_1:FormatText(StoryNameCfg[378].name)

				arg_224_1.leftNameTxt_.text = var_227_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_224_1.leftNameTxt_.transform)

				arg_224_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_224_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_224_1:RecordName(arg_224_1.leftNameTxt_.text)
				SetActive(arg_224_1.iconTrs_.gameObject, false)
				arg_224_1.callingController_:SetSelectedState("normal")

				local var_227_15 = arg_224_1:GetWordFromCfg(120051054)
				local var_227_16 = arg_224_1:FormatText(var_227_15.content)

				arg_224_1.text_.text = var_227_16

				LuaForUtil.ClearLinePrefixSymbol(arg_224_1.text_)

				local var_227_17 = 17
				local var_227_18 = utf8.len(var_227_16)
				local var_227_19 = var_227_17 <= 0 and var_227_13 or var_227_13 * (var_227_18 / var_227_17)

				if var_227_19 > 0 and var_227_13 < var_227_19 then
					arg_224_1.talkMaxDuration = var_227_19

					if var_227_19 + var_227_12 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_19 + var_227_12
					end
				end

				arg_224_1.text_.text = var_227_16
				arg_224_1.typewritter.percent = 0

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120051", "120051054", "story_v_out_120051.awb") ~= 0 then
					local var_227_20 = manager.audio:GetVoiceLength("story_v_out_120051", "120051054", "story_v_out_120051.awb") / 1000

					if var_227_20 + var_227_12 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_20 + var_227_12
					end

					if var_227_15.prefab_name ~= "" and arg_224_1.actors_[var_227_15.prefab_name] ~= nil then
						local var_227_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_224_1.actors_[var_227_15.prefab_name].transform, "story_v_out_120051", "120051054", "story_v_out_120051.awb")

						arg_224_1:RecordAudio("120051054", var_227_21)
						arg_224_1:RecordAudio("120051054", var_227_21)
					else
						arg_224_1:AudioAction("play", "voice", "story_v_out_120051", "120051054", "story_v_out_120051.awb")
					end

					arg_224_1:RecordHistoryTalkVoice("story_v_out_120051", "120051054", "story_v_out_120051.awb")
				end

				arg_224_1:RecordContent(arg_224_1.text_.text)
			end

			local var_227_22 = math.max(var_227_13, arg_224_1.talkMaxDuration)

			if var_227_12 <= arg_224_1.time_ and arg_224_1.time_ < var_227_12 + var_227_22 then
				arg_224_1.typewritter.percent = (arg_224_1.time_ - var_227_12) / var_227_22

				arg_224_1.typewritter:SetDirty()
			end

			if arg_224_1.time_ >= var_227_12 + var_227_22 and arg_224_1.time_ < var_227_12 + var_227_22 + arg_227_0 then
				arg_224_1.typewritter.percent = 1

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(true)
			end
		end

		arg_224_1.nodeConfigList_ = {}

		arg_224_1:InitPlayNodeList()
	end,
	Play120051055 = function(arg_228_0, arg_228_1)
		arg_228_1.time_ = 0
		arg_228_1.frameCnt_ = 0
		arg_228_1.state_ = "playing"
		arg_228_1.curTalkId_ = 120051055
		arg_228_1.duration_ = 5.6

		local var_228_0 = {
			zh = 3.433,
			ja = 5.6
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
				arg_228_0:Play120051056(arg_228_1)
			end
		end

		function arg_228_1.onSingleLineUpdate_(arg_231_0)
			local var_231_0 = arg_228_1.actors_["1184ui_story"].transform
			local var_231_1 = 0

			if var_231_1 < arg_228_1.time_ and arg_228_1.time_ <= var_231_1 + arg_231_0 then
				arg_228_1.var_.moveOldPos1184ui_story = var_231_0.localPosition
			end

			local var_231_2 = 0.001

			if var_231_1 <= arg_228_1.time_ and arg_228_1.time_ < var_231_1 + var_231_2 then
				local var_231_3 = (arg_228_1.time_ - var_231_1) / var_231_2
				local var_231_4 = Vector3.New(0, 100, 0)

				var_231_0.localPosition = Vector3.Lerp(arg_228_1.var_.moveOldPos1184ui_story, var_231_4, var_231_3)

				local var_231_5 = manager.ui.mainCamera.transform.position - var_231_0.position

				var_231_0.forward = Vector3.New(var_231_5.x, var_231_5.y, var_231_5.z)

				local var_231_6 = var_231_0.localEulerAngles

				var_231_6.z = 0
				var_231_6.x = 0
				var_231_0.localEulerAngles = var_231_6
			end

			if arg_228_1.time_ >= var_231_1 + var_231_2 and arg_228_1.time_ < var_231_1 + var_231_2 + arg_231_0 then
				var_231_0.localPosition = Vector3.New(0, 100, 0)

				local var_231_7 = manager.ui.mainCamera.transform.position - var_231_0.position

				var_231_0.forward = Vector3.New(var_231_7.x, var_231_7.y, var_231_7.z)

				local var_231_8 = var_231_0.localEulerAngles

				var_231_8.z = 0
				var_231_8.x = 0
				var_231_0.localEulerAngles = var_231_8
			end

			local var_231_9 = arg_228_1.actors_["1071ui_story"].transform
			local var_231_10 = 0

			if var_231_10 < arg_228_1.time_ and arg_228_1.time_ <= var_231_10 + arg_231_0 then
				arg_228_1.var_.moveOldPos1071ui_story = var_231_9.localPosition
			end

			local var_231_11 = 0.001

			if var_231_10 <= arg_228_1.time_ and arg_228_1.time_ < var_231_10 + var_231_11 then
				local var_231_12 = (arg_228_1.time_ - var_231_10) / var_231_11
				local var_231_13 = Vector3.New(-0.7, -1.05, -6.2)

				var_231_9.localPosition = Vector3.Lerp(arg_228_1.var_.moveOldPos1071ui_story, var_231_13, var_231_12)

				local var_231_14 = manager.ui.mainCamera.transform.position - var_231_9.position

				var_231_9.forward = Vector3.New(var_231_14.x, var_231_14.y, var_231_14.z)

				local var_231_15 = var_231_9.localEulerAngles

				var_231_15.z = 0
				var_231_15.x = 0
				var_231_9.localEulerAngles = var_231_15
			end

			if arg_228_1.time_ >= var_231_10 + var_231_11 and arg_228_1.time_ < var_231_10 + var_231_11 + arg_231_0 then
				var_231_9.localPosition = Vector3.New(-0.7, -1.05, -6.2)

				local var_231_16 = manager.ui.mainCamera.transform.position - var_231_9.position

				var_231_9.forward = Vector3.New(var_231_16.x, var_231_16.y, var_231_16.z)

				local var_231_17 = var_231_9.localEulerAngles

				var_231_17.z = 0
				var_231_17.x = 0
				var_231_9.localEulerAngles = var_231_17
			end

			local var_231_18 = arg_228_1.actors_["1071ui_story"]
			local var_231_19 = 0

			if var_231_19 < arg_228_1.time_ and arg_228_1.time_ <= var_231_19 + arg_231_0 and not isNil(var_231_18) and arg_228_1.var_.characterEffect1071ui_story == nil then
				arg_228_1.var_.characterEffect1071ui_story = var_231_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_231_20 = 0.2

			if var_231_19 <= arg_228_1.time_ and arg_228_1.time_ < var_231_19 + var_231_20 and not isNil(var_231_18) then
				local var_231_21 = (arg_228_1.time_ - var_231_19) / var_231_20

				if arg_228_1.var_.characterEffect1071ui_story and not isNil(var_231_18) then
					arg_228_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_228_1.time_ >= var_231_19 + var_231_20 and arg_228_1.time_ < var_231_19 + var_231_20 + arg_231_0 and not isNil(var_231_18) and arg_228_1.var_.characterEffect1071ui_story then
				arg_228_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_231_22 = arg_228_1.actors_["1069ui_story"]
			local var_231_23 = 0

			if var_231_23 < arg_228_1.time_ and arg_228_1.time_ <= var_231_23 + arg_231_0 and not isNil(var_231_22) and arg_228_1.var_.characterEffect1069ui_story == nil then
				arg_228_1.var_.characterEffect1069ui_story = var_231_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_231_24 = 0.2

			if var_231_23 <= arg_228_1.time_ and arg_228_1.time_ < var_231_23 + var_231_24 and not isNil(var_231_22) then
				local var_231_25 = (arg_228_1.time_ - var_231_23) / var_231_24

				if arg_228_1.var_.characterEffect1069ui_story and not isNil(var_231_22) then
					local var_231_26 = Mathf.Lerp(0, 0.5, var_231_25)

					arg_228_1.var_.characterEffect1069ui_story.fillFlat = true
					arg_228_1.var_.characterEffect1069ui_story.fillRatio = var_231_26
				end
			end

			if arg_228_1.time_ >= var_231_23 + var_231_24 and arg_228_1.time_ < var_231_23 + var_231_24 + arg_231_0 and not isNil(var_231_22) and arg_228_1.var_.characterEffect1069ui_story then
				local var_231_27 = 0.5

				arg_228_1.var_.characterEffect1069ui_story.fillFlat = true
				arg_228_1.var_.characterEffect1069ui_story.fillRatio = var_231_27
			end

			local var_231_28 = 0
			local var_231_29 = 0.3

			if var_231_28 < arg_228_1.time_ and arg_228_1.time_ <= var_231_28 + arg_231_0 then
				arg_228_1.talkMaxDuration = 0
				arg_228_1.dialogCg_.alpha = 1

				arg_228_1.dialog_:SetActive(true)
				SetActive(arg_228_1.leftNameGo_, true)

				local var_231_30 = arg_228_1:FormatText(StoryNameCfg[384].name)

				arg_228_1.leftNameTxt_.text = var_231_30

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_228_1.leftNameTxt_.transform)

				arg_228_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_228_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_228_1:RecordName(arg_228_1.leftNameTxt_.text)
				SetActive(arg_228_1.iconTrs_.gameObject, false)
				arg_228_1.callingController_:SetSelectedState("normal")

				local var_231_31 = arg_228_1:GetWordFromCfg(120051055)
				local var_231_32 = arg_228_1:FormatText(var_231_31.content)

				arg_228_1.text_.text = var_231_32

				LuaForUtil.ClearLinePrefixSymbol(arg_228_1.text_)

				local var_231_33 = 12
				local var_231_34 = utf8.len(var_231_32)
				local var_231_35 = var_231_33 <= 0 and var_231_29 or var_231_29 * (var_231_34 / var_231_33)

				if var_231_35 > 0 and var_231_29 < var_231_35 then
					arg_228_1.talkMaxDuration = var_231_35

					if var_231_35 + var_231_28 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_35 + var_231_28
					end
				end

				arg_228_1.text_.text = var_231_32
				arg_228_1.typewritter.percent = 0

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120051", "120051055", "story_v_out_120051.awb") ~= 0 then
					local var_231_36 = manager.audio:GetVoiceLength("story_v_out_120051", "120051055", "story_v_out_120051.awb") / 1000

					if var_231_36 + var_231_28 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_36 + var_231_28
					end

					if var_231_31.prefab_name ~= "" and arg_228_1.actors_[var_231_31.prefab_name] ~= nil then
						local var_231_37 = LuaForUtil.PlayVoiceWithCriLipsync(arg_228_1.actors_[var_231_31.prefab_name].transform, "story_v_out_120051", "120051055", "story_v_out_120051.awb")

						arg_228_1:RecordAudio("120051055", var_231_37)
						arg_228_1:RecordAudio("120051055", var_231_37)
					else
						arg_228_1:AudioAction("play", "voice", "story_v_out_120051", "120051055", "story_v_out_120051.awb")
					end

					arg_228_1:RecordHistoryTalkVoice("story_v_out_120051", "120051055", "story_v_out_120051.awb")
				end

				arg_228_1:RecordContent(arg_228_1.text_.text)
			end

			local var_231_38 = math.max(var_231_29, arg_228_1.talkMaxDuration)

			if var_231_28 <= arg_228_1.time_ and arg_228_1.time_ < var_231_28 + var_231_38 then
				arg_228_1.typewritter.percent = (arg_228_1.time_ - var_231_28) / var_231_38

				arg_228_1.typewritter:SetDirty()
			end

			if arg_228_1.time_ >= var_231_28 + var_231_38 and arg_228_1.time_ < var_231_28 + var_231_38 + arg_231_0 then
				arg_228_1.typewritter.percent = 1

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(true)
			end
		end

		arg_228_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1184ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_228_1:InitPlayNodeList()
	end,
	Play120051056 = function(arg_232_0, arg_232_1)
		arg_232_1.time_ = 0
		arg_232_1.frameCnt_ = 0
		arg_232_1.state_ = "playing"
		arg_232_1.curTalkId_ = 120051056
		arg_232_1.duration_ = 3.67

		local var_232_0 = {
			zh = 3.633,
			ja = 3.666
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
				arg_232_0:Play120051057(arg_232_1)
			end
		end

		function arg_232_1.onSingleLineUpdate_(arg_235_0)
			local var_235_0 = 0
			local var_235_1 = 0.625

			if var_235_0 < arg_232_1.time_ and arg_232_1.time_ <= var_235_0 + arg_235_0 then
				arg_232_1.talkMaxDuration = 0
				arg_232_1.dialogCg_.alpha = 1

				arg_232_1.dialog_:SetActive(true)
				SetActive(arg_232_1.leftNameGo_, true)

				local var_235_2 = arg_232_1:FormatText(StoryNameCfg[384].name)

				arg_232_1.leftNameTxt_.text = var_235_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_232_1.leftNameTxt_.transform)

				arg_232_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_232_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_232_1:RecordName(arg_232_1.leftNameTxt_.text)
				SetActive(arg_232_1.iconTrs_.gameObject, false)
				arg_232_1.callingController_:SetSelectedState("normal")

				local var_235_3 = arg_232_1:GetWordFromCfg(120051056)
				local var_235_4 = arg_232_1:FormatText(var_235_3.content)

				arg_232_1.text_.text = var_235_4

				LuaForUtil.ClearLinePrefixSymbol(arg_232_1.text_)

				local var_235_5 = 27
				local var_235_6 = utf8.len(var_235_4)
				local var_235_7 = var_235_5 <= 0 and var_235_1 or var_235_1 * (var_235_6 / var_235_5)

				if var_235_7 > 0 and var_235_1 < var_235_7 then
					arg_232_1.talkMaxDuration = var_235_7

					if var_235_7 + var_235_0 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_7 + var_235_0
					end
				end

				arg_232_1.text_.text = var_235_4
				arg_232_1.typewritter.percent = 0

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120051", "120051056", "story_v_out_120051.awb") ~= 0 then
					local var_235_8 = manager.audio:GetVoiceLength("story_v_out_120051", "120051056", "story_v_out_120051.awb") / 1000

					if var_235_8 + var_235_0 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_8 + var_235_0
					end

					if var_235_3.prefab_name ~= "" and arg_232_1.actors_[var_235_3.prefab_name] ~= nil then
						local var_235_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_232_1.actors_[var_235_3.prefab_name].transform, "story_v_out_120051", "120051056", "story_v_out_120051.awb")

						arg_232_1:RecordAudio("120051056", var_235_9)
						arg_232_1:RecordAudio("120051056", var_235_9)
					else
						arg_232_1:AudioAction("play", "voice", "story_v_out_120051", "120051056", "story_v_out_120051.awb")
					end

					arg_232_1:RecordHistoryTalkVoice("story_v_out_120051", "120051056", "story_v_out_120051.awb")
				end

				arg_232_1:RecordContent(arg_232_1.text_.text)
			end

			local var_235_10 = math.max(var_235_1, arg_232_1.talkMaxDuration)

			if var_235_0 <= arg_232_1.time_ and arg_232_1.time_ < var_235_0 + var_235_10 then
				arg_232_1.typewritter.percent = (arg_232_1.time_ - var_235_0) / var_235_10

				arg_232_1.typewritter:SetDirty()
			end

			if arg_232_1.time_ >= var_235_0 + var_235_10 and arg_232_1.time_ < var_235_0 + var_235_10 + arg_235_0 then
				arg_232_1.typewritter.percent = 1

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(true)
			end
		end

		arg_232_1.nodeConfigList_ = {}

		arg_232_1:InitPlayNodeList()
	end,
	Play120051057 = function(arg_236_0, arg_236_1)
		arg_236_1.time_ = 0
		arg_236_1.frameCnt_ = 0
		arg_236_1.state_ = "playing"
		arg_236_1.curTalkId_ = 120051057
		arg_236_1.duration_ = 5

		SetActive(arg_236_1.tipsGo_, false)

		function arg_236_1.onSingleLineFinish_()
			arg_236_1.onSingleLineUpdate_ = nil
			arg_236_1.onSingleLineFinish_ = nil
			arg_236_1.state_ = "waiting"
		end

		function arg_236_1.playNext_(arg_238_0)
			if arg_238_0 == 1 then
				arg_236_0:Play120051058(arg_236_1)
			end
		end

		function arg_236_1.onSingleLineUpdate_(arg_239_0)
			local var_239_0 = arg_236_1.actors_["1071ui_story"]
			local var_239_1 = 0

			if var_239_1 < arg_236_1.time_ and arg_236_1.time_ <= var_239_1 + arg_239_0 and not isNil(var_239_0) and arg_236_1.var_.characterEffect1071ui_story == nil then
				arg_236_1.var_.characterEffect1071ui_story = var_239_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_239_2 = 0.2

			if var_239_1 <= arg_236_1.time_ and arg_236_1.time_ < var_239_1 + var_239_2 and not isNil(var_239_0) then
				local var_239_3 = (arg_236_1.time_ - var_239_1) / var_239_2

				if arg_236_1.var_.characterEffect1071ui_story and not isNil(var_239_0) then
					local var_239_4 = Mathf.Lerp(0, 0.5, var_239_3)

					arg_236_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_236_1.var_.characterEffect1071ui_story.fillRatio = var_239_4
				end
			end

			if arg_236_1.time_ >= var_239_1 + var_239_2 and arg_236_1.time_ < var_239_1 + var_239_2 + arg_239_0 and not isNil(var_239_0) and arg_236_1.var_.characterEffect1071ui_story then
				local var_239_5 = 0.5

				arg_236_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_236_1.var_.characterEffect1071ui_story.fillRatio = var_239_5
			end

			local var_239_6 = 0
			local var_239_7 = 0.85

			if var_239_6 < arg_236_1.time_ and arg_236_1.time_ <= var_239_6 + arg_239_0 then
				arg_236_1.talkMaxDuration = 0
				arg_236_1.dialogCg_.alpha = 1

				arg_236_1.dialog_:SetActive(true)
				SetActive(arg_236_1.leftNameGo_, true)

				local var_239_8 = arg_236_1:FormatText(StoryNameCfg[7].name)

				arg_236_1.leftNameTxt_.text = var_239_8

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

				local var_239_9 = arg_236_1:GetWordFromCfg(120051057)
				local var_239_10 = arg_236_1:FormatText(var_239_9.content)

				arg_236_1.text_.text = var_239_10

				LuaForUtil.ClearLinePrefixSymbol(arg_236_1.text_)

				local var_239_11 = 34
				local var_239_12 = utf8.len(var_239_10)
				local var_239_13 = var_239_11 <= 0 and var_239_7 or var_239_7 * (var_239_12 / var_239_11)

				if var_239_13 > 0 and var_239_7 < var_239_13 then
					arg_236_1.talkMaxDuration = var_239_13

					if var_239_13 + var_239_6 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_13 + var_239_6
					end
				end

				arg_236_1.text_.text = var_239_10
				arg_236_1.typewritter.percent = 0

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(false)
				arg_236_1:RecordContent(arg_236_1.text_.text)
			end

			local var_239_14 = math.max(var_239_7, arg_236_1.talkMaxDuration)

			if var_239_6 <= arg_236_1.time_ and arg_236_1.time_ < var_239_6 + var_239_14 then
				arg_236_1.typewritter.percent = (arg_236_1.time_ - var_239_6) / var_239_14

				arg_236_1.typewritter:SetDirty()
			end

			if arg_236_1.time_ >= var_239_6 + var_239_14 and arg_236_1.time_ < var_239_6 + var_239_14 + arg_239_0 then
				arg_236_1.typewritter.percent = 1

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(true)
			end
		end

		arg_236_1.nodeConfigList_ = {}

		arg_236_1:InitPlayNodeList()
	end,
	Play120051058 = function(arg_240_0, arg_240_1)
		arg_240_1.time_ = 0
		arg_240_1.frameCnt_ = 0
		arg_240_1.state_ = "playing"
		arg_240_1.curTalkId_ = 120051058
		arg_240_1.duration_ = 5

		SetActive(arg_240_1.tipsGo_, false)

		function arg_240_1.onSingleLineFinish_()
			arg_240_1.onSingleLineUpdate_ = nil
			arg_240_1.onSingleLineFinish_ = nil
			arg_240_1.state_ = "waiting"
		end

		function arg_240_1.playNext_(arg_242_0)
			if arg_242_0 == 1 then
				arg_240_0:Play120051059(arg_240_1)
			end
		end

		function arg_240_1.onSingleLineUpdate_(arg_243_0)
			local var_243_0 = 0
			local var_243_1 = 0.525

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

				local var_243_2 = arg_240_1:GetWordFromCfg(120051058)
				local var_243_3 = arg_240_1:FormatText(var_243_2.content)

				arg_240_1.text_.text = var_243_3

				LuaForUtil.ClearLinePrefixSymbol(arg_240_1.text_)

				local var_243_4 = 21
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
	Play120051059 = function(arg_244_0, arg_244_1)
		arg_244_1.time_ = 0
		arg_244_1.frameCnt_ = 0
		arg_244_1.state_ = "playing"
		arg_244_1.curTalkId_ = 120051059
		arg_244_1.duration_ = 18.8

		local var_244_0 = {
			zh = 12.533,
			ja = 18.8
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
				arg_244_0:Play120051060(arg_244_1)
			end
		end

		function arg_244_1.onSingleLineUpdate_(arg_247_0)
			local var_247_0 = arg_244_1.actors_["1071ui_story"]
			local var_247_1 = 0

			if var_247_1 < arg_244_1.time_ and arg_244_1.time_ <= var_247_1 + arg_247_0 and not isNil(var_247_0) and arg_244_1.var_.characterEffect1071ui_story == nil then
				arg_244_1.var_.characterEffect1071ui_story = var_247_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_247_2 = 0.2

			if var_247_1 <= arg_244_1.time_ and arg_244_1.time_ < var_247_1 + var_247_2 and not isNil(var_247_0) then
				local var_247_3 = (arg_244_1.time_ - var_247_1) / var_247_2

				if arg_244_1.var_.characterEffect1071ui_story and not isNil(var_247_0) then
					arg_244_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_244_1.time_ >= var_247_1 + var_247_2 and arg_244_1.time_ < var_247_1 + var_247_2 + arg_247_0 and not isNil(var_247_0) and arg_244_1.var_.characterEffect1071ui_story then
				arg_244_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_247_4 = 0
			local var_247_5 = 1.125

			if var_247_4 < arg_244_1.time_ and arg_244_1.time_ <= var_247_4 + arg_247_0 then
				arg_244_1.talkMaxDuration = 0
				arg_244_1.dialogCg_.alpha = 1

				arg_244_1.dialog_:SetActive(true)
				SetActive(arg_244_1.leftNameGo_, true)

				local var_247_6 = arg_244_1:FormatText(StoryNameCfg[384].name)

				arg_244_1.leftNameTxt_.text = var_247_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_244_1.leftNameTxt_.transform)

				arg_244_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_244_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_244_1:RecordName(arg_244_1.leftNameTxt_.text)
				SetActive(arg_244_1.iconTrs_.gameObject, false)
				arg_244_1.callingController_:SetSelectedState("normal")

				local var_247_7 = arg_244_1:GetWordFromCfg(120051059)
				local var_247_8 = arg_244_1:FormatText(var_247_7.content)

				arg_244_1.text_.text = var_247_8

				LuaForUtil.ClearLinePrefixSymbol(arg_244_1.text_)

				local var_247_9 = 45
				local var_247_10 = utf8.len(var_247_8)
				local var_247_11 = var_247_9 <= 0 and var_247_5 or var_247_5 * (var_247_10 / var_247_9)

				if var_247_11 > 0 and var_247_5 < var_247_11 then
					arg_244_1.talkMaxDuration = var_247_11

					if var_247_11 + var_247_4 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_11 + var_247_4
					end
				end

				arg_244_1.text_.text = var_247_8
				arg_244_1.typewritter.percent = 0

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120051", "120051059", "story_v_out_120051.awb") ~= 0 then
					local var_247_12 = manager.audio:GetVoiceLength("story_v_out_120051", "120051059", "story_v_out_120051.awb") / 1000

					if var_247_12 + var_247_4 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_12 + var_247_4
					end

					if var_247_7.prefab_name ~= "" and arg_244_1.actors_[var_247_7.prefab_name] ~= nil then
						local var_247_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_244_1.actors_[var_247_7.prefab_name].transform, "story_v_out_120051", "120051059", "story_v_out_120051.awb")

						arg_244_1:RecordAudio("120051059", var_247_13)
						arg_244_1:RecordAudio("120051059", var_247_13)
					else
						arg_244_1:AudioAction("play", "voice", "story_v_out_120051", "120051059", "story_v_out_120051.awb")
					end

					arg_244_1:RecordHistoryTalkVoice("story_v_out_120051", "120051059", "story_v_out_120051.awb")
				end

				arg_244_1:RecordContent(arg_244_1.text_.text)
			end

			local var_247_14 = math.max(var_247_5, arg_244_1.talkMaxDuration)

			if var_247_4 <= arg_244_1.time_ and arg_244_1.time_ < var_247_4 + var_247_14 then
				arg_244_1.typewritter.percent = (arg_244_1.time_ - var_247_4) / var_247_14

				arg_244_1.typewritter:SetDirty()
			end

			if arg_244_1.time_ >= var_247_4 + var_247_14 and arg_244_1.time_ < var_247_4 + var_247_14 + arg_247_0 then
				arg_244_1.typewritter.percent = 1

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(true)
			end
		end

		arg_244_1.nodeConfigList_ = {}

		arg_244_1:InitPlayNodeList()
	end,
	Play120051060 = function(arg_248_0, arg_248_1)
		arg_248_1.time_ = 0
		arg_248_1.frameCnt_ = 0
		arg_248_1.state_ = "playing"
		arg_248_1.curTalkId_ = 120051060
		arg_248_1.duration_ = 3.43

		local var_248_0 = {
			zh = 3.433,
			ja = 3.3
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
				arg_248_0:Play120051061(arg_248_1)
			end
		end

		function arg_248_1.onSingleLineUpdate_(arg_251_0)
			local var_251_0 = 0
			local var_251_1 = 0.325

			if var_251_0 < arg_248_1.time_ and arg_248_1.time_ <= var_251_0 + arg_251_0 then
				arg_248_1.talkMaxDuration = 0
				arg_248_1.dialogCg_.alpha = 1

				arg_248_1.dialog_:SetActive(true)
				SetActive(arg_248_1.leftNameGo_, true)

				local var_251_2 = arg_248_1:FormatText(StoryNameCfg[384].name)

				arg_248_1.leftNameTxt_.text = var_251_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_248_1.leftNameTxt_.transform)

				arg_248_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_248_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_248_1:RecordName(arg_248_1.leftNameTxt_.text)
				SetActive(arg_248_1.iconTrs_.gameObject, false)
				arg_248_1.callingController_:SetSelectedState("normal")

				local var_251_3 = arg_248_1:GetWordFromCfg(120051060)
				local var_251_4 = arg_248_1:FormatText(var_251_3.content)

				arg_248_1.text_.text = var_251_4

				LuaForUtil.ClearLinePrefixSymbol(arg_248_1.text_)

				local var_251_5 = 13
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

				if manager.audio:GetVoiceLength("story_v_out_120051", "120051060", "story_v_out_120051.awb") ~= 0 then
					local var_251_8 = manager.audio:GetVoiceLength("story_v_out_120051", "120051060", "story_v_out_120051.awb") / 1000

					if var_251_8 + var_251_0 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_8 + var_251_0
					end

					if var_251_3.prefab_name ~= "" and arg_248_1.actors_[var_251_3.prefab_name] ~= nil then
						local var_251_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_248_1.actors_[var_251_3.prefab_name].transform, "story_v_out_120051", "120051060", "story_v_out_120051.awb")

						arg_248_1:RecordAudio("120051060", var_251_9)
						arg_248_1:RecordAudio("120051060", var_251_9)
					else
						arg_248_1:AudioAction("play", "voice", "story_v_out_120051", "120051060", "story_v_out_120051.awb")
					end

					arg_248_1:RecordHistoryTalkVoice("story_v_out_120051", "120051060", "story_v_out_120051.awb")
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
	Play120051061 = function(arg_252_0, arg_252_1)
		arg_252_1.time_ = 0
		arg_252_1.frameCnt_ = 0
		arg_252_1.state_ = "playing"
		arg_252_1.curTalkId_ = 120051061
		arg_252_1.duration_ = 5.57

		local var_252_0 = {
			zh = 3.5,
			ja = 5.566
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
			arg_252_1.auto_ = false
		end

		function arg_252_1.playNext_(arg_254_0)
			arg_252_1.onStoryFinished_()
		end

		function arg_252_1.onSingleLineUpdate_(arg_255_0)
			local var_255_0 = 0
			local var_255_1 = 0.4

			if var_255_0 < arg_252_1.time_ and arg_252_1.time_ <= var_255_0 + arg_255_0 then
				arg_252_1.talkMaxDuration = 0
				arg_252_1.dialogCg_.alpha = 1

				arg_252_1.dialog_:SetActive(true)
				SetActive(arg_252_1.leftNameGo_, true)

				local var_255_2 = arg_252_1:FormatText(StoryNameCfg[384].name)

				arg_252_1.leftNameTxt_.text = var_255_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_252_1.leftNameTxt_.transform)

				arg_252_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_252_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_252_1:RecordName(arg_252_1.leftNameTxt_.text)
				SetActive(arg_252_1.iconTrs_.gameObject, false)
				arg_252_1.callingController_:SetSelectedState("normal")

				local var_255_3 = arg_252_1:GetWordFromCfg(120051061)
				local var_255_4 = arg_252_1:FormatText(var_255_3.content)

				arg_252_1.text_.text = var_255_4

				LuaForUtil.ClearLinePrefixSymbol(arg_252_1.text_)

				local var_255_5 = 16
				local var_255_6 = utf8.len(var_255_4)
				local var_255_7 = var_255_5 <= 0 and var_255_1 or var_255_1 * (var_255_6 / var_255_5)

				if var_255_7 > 0 and var_255_1 < var_255_7 then
					arg_252_1.talkMaxDuration = var_255_7

					if var_255_7 + var_255_0 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_7 + var_255_0
					end
				end

				arg_252_1.text_.text = var_255_4
				arg_252_1.typewritter.percent = 0

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120051", "120051061", "story_v_out_120051.awb") ~= 0 then
					local var_255_8 = manager.audio:GetVoiceLength("story_v_out_120051", "120051061", "story_v_out_120051.awb") / 1000

					if var_255_8 + var_255_0 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_8 + var_255_0
					end

					if var_255_3.prefab_name ~= "" and arg_252_1.actors_[var_255_3.prefab_name] ~= nil then
						local var_255_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_252_1.actors_[var_255_3.prefab_name].transform, "story_v_out_120051", "120051061", "story_v_out_120051.awb")

						arg_252_1:RecordAudio("120051061", var_255_9)
						arg_252_1:RecordAudio("120051061", var_255_9)
					else
						arg_252_1:AudioAction("play", "voice", "story_v_out_120051", "120051061", "story_v_out_120051.awb")
					end

					arg_252_1:RecordHistoryTalkVoice("story_v_out_120051", "120051061", "story_v_out_120051.awb")
				end

				arg_252_1:RecordContent(arg_252_1.text_.text)
			end

			local var_255_10 = math.max(var_255_1, arg_252_1.talkMaxDuration)

			if var_255_0 <= arg_252_1.time_ and arg_252_1.time_ < var_255_0 + var_255_10 then
				arg_252_1.typewritter.percent = (arg_252_1.time_ - var_255_0) / var_255_10

				arg_252_1.typewritter:SetDirty()
			end

			if arg_252_1.time_ >= var_255_0 + var_255_10 and arg_252_1.time_ < var_255_0 + var_255_10 + arg_255_0 then
				arg_252_1.typewritter.percent = 1

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(true)
			end
		end

		arg_252_1.nodeConfigList_ = {}

		arg_252_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/J02g",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/J03f"
	},
	voices = {
		"story_v_out_120051.awb"
	}
}
