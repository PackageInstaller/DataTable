return {
	Play424081001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 424081001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play424081002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "I11r"

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
				local var_4_5 = arg_1_1.bgs_.I11r

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
					if iter_4_0 ~= "I11r" then
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
			local var_4_25 = 0.3

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

			local var_4_30 = 0.3
			local var_4_31 = 1

			if var_4_30 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 then
				local var_4_32 = "play"
				local var_4_33 = "music"

				arg_1_1:AudioAction(var_4_32, var_4_33, "bgm_activity_3_0_story_quiet", "bgm_activity_3_0_story_quiet", "bgm_activity_3_0_story_quiet.awb")

				local var_4_34 = ""
				local var_4_35 = manager.audio:GetAudioName("bgm_activity_3_0_story_quiet", "bgm_activity_3_0_story_quiet")

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

			local var_4_36 = 0.1
			local var_4_37 = 1

			if var_4_36 < arg_1_1.time_ and arg_1_1.time_ <= var_4_36 + arg_4_0 then
				local var_4_38 = "play"
				local var_4_39 = "effect"

				arg_1_1:AudioAction(var_4_38, var_4_39, "se_story_16", "se_story_16_street_loop", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_40 = 2
			local var_4_41 = 1.05

			if var_4_40 < arg_1_1.time_ and arg_1_1.time_ <= var_4_40 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_42 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_42:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_42:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_42:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_43 = arg_1_1:GetWordFromCfg(424081001)
				local var_4_44 = arg_1_1:FormatText(var_4_43.content)

				arg_1_1.text_.text = var_4_44

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_45 = 42
				local var_4_46 = utf8.len(var_4_44)
				local var_4_47 = var_4_45 <= 0 and var_4_41 or var_4_41 * (var_4_46 / var_4_45)

				if var_4_47 > 0 and var_4_41 < var_4_47 then
					arg_1_1.talkMaxDuration = var_4_47
					var_4_40 = var_4_40 + 0.3

					if var_4_47 + var_4_40 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_47 + var_4_40
					end
				end

				arg_1_1.text_.text = var_4_44
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_48 = var_4_40 + 0.3
			local var_4_49 = math.max(var_4_41, arg_1_1.talkMaxDuration)

			if var_4_48 <= arg_1_1.time_ and arg_1_1.time_ < var_4_48 + var_4_49 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_48) / var_4_49

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_48 + var_4_49 and arg_1_1.time_ < var_4_48 + var_4_49 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play424081002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 424081002
		arg_9_1.duration_ = 5.23

		local var_9_0 = {
			zh = 3.933,
			ja = 5.233
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
				arg_9_0:Play424081003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0
			local var_12_1 = 0.5

			if var_12_0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				local var_12_2 = arg_9_1:FormatText(StoryNameCfg[177].name)

				arg_9_1.leftNameTxt_.text = var_12_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, true)
				arg_9_1.iconController_:SetSelectedState("hero")

				arg_9_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_9_1.callingController_:SetSelectedState("normal")

				arg_9_1.keyicon_.color = Color.New(1, 1, 1)
				arg_9_1.icon_.color = Color.New(1, 1, 1)

				local var_12_3 = arg_9_1:GetWordFromCfg(424081002)
				local var_12_4 = arg_9_1:FormatText(var_12_3.content)

				arg_9_1.text_.text = var_12_4

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_5 = 20
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

				if manager.audio:GetVoiceLength("story_v_out_424081", "424081002", "story_v_out_424081.awb") ~= 0 then
					local var_12_8 = manager.audio:GetVoiceLength("story_v_out_424081", "424081002", "story_v_out_424081.awb") / 1000

					if var_12_8 + var_12_0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_8 + var_12_0
					end

					if var_12_3.prefab_name ~= "" and arg_9_1.actors_[var_12_3.prefab_name] ~= nil then
						local var_12_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_3.prefab_name].transform, "story_v_out_424081", "424081002", "story_v_out_424081.awb")

						arg_9_1:RecordAudio("424081002", var_12_9)
						arg_9_1:RecordAudio("424081002", var_12_9)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_424081", "424081002", "story_v_out_424081.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_424081", "424081002", "story_v_out_424081.awb")
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
	Play424081003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 424081003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play424081004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0
			local var_16_1 = 0.975

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

				arg_13_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_13_1.callingController_:SetSelectedState("normal")

				arg_13_1.keyicon_.color = Color.New(1, 1, 1)
				arg_13_1.icon_.color = Color.New(1, 1, 1)

				local var_16_3 = arg_13_1:GetWordFromCfg(424081003)
				local var_16_4 = arg_13_1:FormatText(var_16_3.content)

				arg_13_1.text_.text = var_16_4

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_5 = 39
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
	Play424081004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 424081004
		arg_17_1.duration_ = 8.07

		local var_17_0 = {
			zh = 5.266,
			ja = 8.066
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
				arg_17_0:Play424081005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0
			local var_20_1 = 0.7

			if var_20_0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_0 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_2 = arg_17_1:FormatText(StoryNameCfg[177].name)

				arg_17_1.leftNameTxt_.text = var_20_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, true)
				arg_17_1.iconController_:SetSelectedState("hero")

				arg_17_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_17_1.callingController_:SetSelectedState("normal")

				arg_17_1.keyicon_.color = Color.New(1, 1, 1)
				arg_17_1.icon_.color = Color.New(1, 1, 1)

				local var_20_3 = arg_17_1:GetWordFromCfg(424081004)
				local var_20_4 = arg_17_1:FormatText(var_20_3.content)

				arg_17_1.text_.text = var_20_4

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_5 = 28
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

				if manager.audio:GetVoiceLength("story_v_out_424081", "424081004", "story_v_out_424081.awb") ~= 0 then
					local var_20_8 = manager.audio:GetVoiceLength("story_v_out_424081", "424081004", "story_v_out_424081.awb") / 1000

					if var_20_8 + var_20_0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_8 + var_20_0
					end

					if var_20_3.prefab_name ~= "" and arg_17_1.actors_[var_20_3.prefab_name] ~= nil then
						local var_20_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_3.prefab_name].transform, "story_v_out_424081", "424081004", "story_v_out_424081.awb")

						arg_17_1:RecordAudio("424081004", var_20_9)
						arg_17_1:RecordAudio("424081004", var_20_9)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_424081", "424081004", "story_v_out_424081.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_424081", "424081004", "story_v_out_424081.awb")
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
	Play424081005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 424081005
		arg_21_1.duration_ = 3.03

		local var_21_0 = {
			zh = 2.2,
			ja = 3.033
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
				arg_21_0:Play424081006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = "1094"

			if arg_21_1.actors_[var_24_0] == nil then
				local var_24_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1094")

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

			local var_24_4 = arg_21_1.actors_["1094"]
			local var_24_5 = 0

			if var_24_5 < arg_21_1.time_ and arg_21_1.time_ <= var_24_5 + arg_24_0 and not isNil(var_24_4) and arg_21_1.var_.actorSpriteComps1094 == nil then
				arg_21_1.var_.actorSpriteComps1094 = var_24_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_24_6 = 0.2

			if var_24_5 <= arg_21_1.time_ and arg_21_1.time_ < var_24_5 + var_24_6 and not isNil(var_24_4) then
				local var_24_7 = (arg_21_1.time_ - var_24_5) / var_24_6

				if arg_21_1.var_.actorSpriteComps1094 then
					for iter_24_2, iter_24_3 in pairs(arg_21_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_24_3 then
							if arg_21_1.isInRecall_ then
								local var_24_8 = Mathf.Lerp(iter_24_3.color.r, arg_21_1.hightColor1.r, var_24_7)
								local var_24_9 = Mathf.Lerp(iter_24_3.color.g, arg_21_1.hightColor1.g, var_24_7)
								local var_24_10 = Mathf.Lerp(iter_24_3.color.b, arg_21_1.hightColor1.b, var_24_7)

								iter_24_3.color = Color.New(var_24_8, var_24_9, var_24_10)
							else
								local var_24_11 = Mathf.Lerp(iter_24_3.color.r, 1, var_24_7)

								iter_24_3.color = Color.New(var_24_11, var_24_11, var_24_11)
							end
						end
					end
				end
			end

			if arg_21_1.time_ >= var_24_5 + var_24_6 and arg_21_1.time_ < var_24_5 + var_24_6 + arg_24_0 and not isNil(var_24_4) and arg_21_1.var_.actorSpriteComps1094 then
				for iter_24_4, iter_24_5 in pairs(arg_21_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_24_5 then
						if arg_21_1.isInRecall_ then
							iter_24_5.color = arg_21_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_24_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_21_1.var_.actorSpriteComps1094 = nil
			end

			local var_24_12 = arg_21_1.actors_["1094"].transform
			local var_24_13 = 0

			if var_24_13 < arg_21_1.time_ and arg_21_1.time_ <= var_24_13 + arg_24_0 then
				arg_21_1.var_.moveOldPos1094 = var_24_12.localPosition
				var_24_12.localScale = Vector3.New(1, 1, 1)

				arg_21_1:CheckSpriteTmpPos("1094", 3)

				local var_24_14 = var_24_12.childCount

				for iter_24_6 = 0, var_24_14 - 1 do
					local var_24_15 = var_24_12:GetChild(iter_24_6)

					if var_24_15.name == "split_4" or not string.find(var_24_15.name, "split") then
						var_24_15.gameObject:SetActive(true)
					else
						var_24_15.gameObject:SetActive(false)
					end
				end
			end

			local var_24_16 = 0.001

			if var_24_13 <= arg_21_1.time_ and arg_21_1.time_ < var_24_13 + var_24_16 then
				local var_24_17 = (arg_21_1.time_ - var_24_13) / var_24_16
				local var_24_18 = Vector3.New(0, -335, -230)

				var_24_12.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1094, var_24_18, var_24_17)
			end

			if arg_21_1.time_ >= var_24_13 + var_24_16 and arg_21_1.time_ < var_24_13 + var_24_16 + arg_24_0 then
				var_24_12.localPosition = Vector3.New(0, -335, -230)
			end

			local var_24_19 = arg_21_1.actors_["1094"]
			local var_24_20 = 0

			if var_24_20 < arg_21_1.time_ and arg_21_1.time_ <= var_24_20 + arg_24_0 then
				local var_24_21 = var_24_19:GetComponentInChildren(typeof(CanvasGroup))

				if var_24_21 then
					arg_21_1.var_.alphaOldValue1094 = var_24_21.alpha
					arg_21_1.var_.characterEffect1094 = var_24_21
				end

				arg_21_1.var_.alphaOldValue1094 = 0
			end

			local var_24_22 = 0.5

			if var_24_20 <= arg_21_1.time_ and arg_21_1.time_ < var_24_20 + var_24_22 then
				local var_24_23 = (arg_21_1.time_ - var_24_20) / var_24_22
				local var_24_24 = Mathf.Lerp(arg_21_1.var_.alphaOldValue1094, 1, var_24_23)

				if arg_21_1.var_.characterEffect1094 then
					arg_21_1.var_.characterEffect1094.alpha = var_24_24
				end
			end

			if arg_21_1.time_ >= var_24_20 + var_24_22 and arg_21_1.time_ < var_24_20 + var_24_22 + arg_24_0 and arg_21_1.var_.characterEffect1094 then
				arg_21_1.var_.characterEffect1094.alpha = 1
			end

			local var_24_25 = 0
			local var_24_26 = 0.25

			if var_24_25 < arg_21_1.time_ and arg_21_1.time_ <= var_24_25 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0

				arg_21_1.dialog_:SetActive(true)

				arg_21_1.dialogCg_.alpha = 0

				local var_24_27 = LeanTween.value(arg_21_1.dialog_, 0, 1, 0.3)

				var_24_27:setOnUpdate(LuaHelper.FloatAction(function(arg_25_0)
					arg_21_1.dialogCg_.alpha = arg_25_0
				end))
				var_24_27:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_21_1.dialog_)
					var_24_27:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_21_1.duration_ = arg_21_1.duration_ + 0.3

				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_28 = arg_21_1:FormatText(StoryNameCfg[181].name)

				arg_21_1.leftNameTxt_.text = var_24_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_29 = arg_21_1:GetWordFromCfg(424081005)
				local var_24_30 = arg_21_1:FormatText(var_24_29.content)

				arg_21_1.text_.text = var_24_30

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_31 = 10
				local var_24_32 = utf8.len(var_24_30)
				local var_24_33 = var_24_31 <= 0 and var_24_26 or var_24_26 * (var_24_32 / var_24_31)

				if var_24_33 > 0 and var_24_26 < var_24_33 then
					arg_21_1.talkMaxDuration = var_24_33
					var_24_25 = var_24_25 + 0.3

					if var_24_33 + var_24_25 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_33 + var_24_25
					end
				end

				arg_21_1.text_.text = var_24_30
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424081", "424081005", "story_v_out_424081.awb") ~= 0 then
					local var_24_34 = manager.audio:GetVoiceLength("story_v_out_424081", "424081005", "story_v_out_424081.awb") / 1000

					if var_24_34 + var_24_25 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_34 + var_24_25
					end

					if var_24_29.prefab_name ~= "" and arg_21_1.actors_[var_24_29.prefab_name] ~= nil then
						local var_24_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_29.prefab_name].transform, "story_v_out_424081", "424081005", "story_v_out_424081.awb")

						arg_21_1:RecordAudio("424081005", var_24_35)
						arg_21_1:RecordAudio("424081005", var_24_35)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_424081", "424081005", "story_v_out_424081.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_424081", "424081005", "story_v_out_424081.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_36 = var_24_25 + 0.3
			local var_24_37 = math.max(var_24_26, arg_21_1.talkMaxDuration)

			if var_24_36 <= arg_21_1.time_ and arg_21_1.time_ < var_24_36 + var_24_37 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_36) / var_24_37

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_36 + var_24_37 and arg_21_1.time_ < var_24_36 + var_24_37 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094",
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
	Play424081006 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 424081006
		arg_27_1.duration_ = 5

		SetActive(arg_27_1.tipsGo_, false)

		function arg_27_1.onSingleLineFinish_()
			arg_27_1.onSingleLineUpdate_ = nil
			arg_27_1.onSingleLineFinish_ = nil
			arg_27_1.state_ = "waiting"
		end

		function arg_27_1.playNext_(arg_29_0)
			if arg_29_0 == 1 then
				arg_27_0:Play424081007(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			local var_30_0 = arg_27_1.actors_["1094"]
			local var_30_1 = 0

			if var_30_1 < arg_27_1.time_ and arg_27_1.time_ <= var_30_1 + arg_30_0 and not isNil(var_30_0) and arg_27_1.var_.actorSpriteComps1094 == nil then
				arg_27_1.var_.actorSpriteComps1094 = var_30_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_30_2 = 0.2

			if var_30_1 <= arg_27_1.time_ and arg_27_1.time_ < var_30_1 + var_30_2 and not isNil(var_30_0) then
				local var_30_3 = (arg_27_1.time_ - var_30_1) / var_30_2

				if arg_27_1.var_.actorSpriteComps1094 then
					for iter_30_0, iter_30_1 in pairs(arg_27_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_30_1 then
							if arg_27_1.isInRecall_ then
								local var_30_4 = Mathf.Lerp(iter_30_1.color.r, arg_27_1.hightColor2.r, var_30_3)
								local var_30_5 = Mathf.Lerp(iter_30_1.color.g, arg_27_1.hightColor2.g, var_30_3)
								local var_30_6 = Mathf.Lerp(iter_30_1.color.b, arg_27_1.hightColor2.b, var_30_3)

								iter_30_1.color = Color.New(var_30_4, var_30_5, var_30_6)
							else
								local var_30_7 = Mathf.Lerp(iter_30_1.color.r, 0.5, var_30_3)

								iter_30_1.color = Color.New(var_30_7, var_30_7, var_30_7)
							end
						end
					end
				end
			end

			if arg_27_1.time_ >= var_30_1 + var_30_2 and arg_27_1.time_ < var_30_1 + var_30_2 + arg_30_0 and not isNil(var_30_0) and arg_27_1.var_.actorSpriteComps1094 then
				for iter_30_2, iter_30_3 in pairs(arg_27_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_30_3 then
						if arg_27_1.isInRecall_ then
							iter_30_3.color = arg_27_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_30_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_27_1.var_.actorSpriteComps1094 = nil
			end

			local var_30_8 = 0
			local var_30_9 = 0.4

			if var_30_8 < arg_27_1.time_ and arg_27_1.time_ <= var_30_8 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, true)

				local var_30_10 = arg_27_1:FormatText(StoryNameCfg[7].name)

				arg_27_1.leftNameTxt_.text = var_30_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_27_1.leftNameTxt_.transform)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1.leftNameTxt_.text)
				SetActive(arg_27_1.iconTrs_.gameObject, true)
				arg_27_1.iconController_:SetSelectedState("hero")

				arg_27_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_27_1.callingController_:SetSelectedState("normal")

				arg_27_1.keyicon_.color = Color.New(1, 1, 1)
				arg_27_1.icon_.color = Color.New(1, 1, 1)

				local var_30_11 = arg_27_1:GetWordFromCfg(424081006)
				local var_30_12 = arg_27_1:FormatText(var_30_11.content)

				arg_27_1.text_.text = var_30_12

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_13 = 16
				local var_30_14 = utf8.len(var_30_12)
				local var_30_15 = var_30_13 <= 0 and var_30_9 or var_30_9 * (var_30_14 / var_30_13)

				if var_30_15 > 0 and var_30_9 < var_30_15 then
					arg_27_1.talkMaxDuration = var_30_15

					if var_30_15 + var_30_8 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_15 + var_30_8
					end
				end

				arg_27_1.text_.text = var_30_12
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)
				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_16 = math.max(var_30_9, arg_27_1.talkMaxDuration)

			if var_30_8 <= arg_27_1.time_ and arg_27_1.time_ < var_30_8 + var_30_16 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - var_30_8) / var_30_16

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= var_30_8 + var_30_16 and arg_27_1.time_ < var_30_8 + var_30_16 + arg_30_0 then
				arg_27_1.typewritter.percent = 1

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(true)
			end
		end

		arg_27_1.nodeConfigList_ = {}

		arg_27_1:InitPlayNodeList()
	end,
	Play424081007 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 424081007
		arg_31_1.duration_ = 3.3

		local var_31_0 = {
			zh = 1.533,
			ja = 3.3
		}
		local var_31_1 = manager.audio:GetLocalizationFlag()

		if var_31_0[var_31_1] ~= nil then
			arg_31_1.duration_ = var_31_0[var_31_1]
		end

		SetActive(arg_31_1.tipsGo_, false)

		function arg_31_1.onSingleLineFinish_()
			arg_31_1.onSingleLineUpdate_ = nil
			arg_31_1.onSingleLineFinish_ = nil
			arg_31_1.state_ = "waiting"
		end

		function arg_31_1.playNext_(arg_33_0)
			if arg_33_0 == 1 then
				arg_31_0:Play424081008(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			local var_34_0 = 0
			local var_34_1 = 0.125

			if var_34_0 < arg_31_1.time_ and arg_31_1.time_ <= var_34_0 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, true)

				local var_34_2 = arg_31_1:FormatText(StoryNameCfg[177].name)

				arg_31_1.leftNameTxt_.text = var_34_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_31_1.leftNameTxt_.transform)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1.leftNameTxt_.text)
				SetActive(arg_31_1.iconTrs_.gameObject, true)
				arg_31_1.iconController_:SetSelectedState("hero")

				arg_31_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_31_1.callingController_:SetSelectedState("normal")

				arg_31_1.keyicon_.color = Color.New(1, 1, 1)
				arg_31_1.icon_.color = Color.New(1, 1, 1)

				local var_34_3 = arg_31_1:GetWordFromCfg(424081007)
				local var_34_4 = arg_31_1:FormatText(var_34_3.content)

				arg_31_1.text_.text = var_34_4

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_5 = 5
				local var_34_6 = utf8.len(var_34_4)
				local var_34_7 = var_34_5 <= 0 and var_34_1 or var_34_1 * (var_34_6 / var_34_5)

				if var_34_7 > 0 and var_34_1 < var_34_7 then
					arg_31_1.talkMaxDuration = var_34_7

					if var_34_7 + var_34_0 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_7 + var_34_0
					end
				end

				arg_31_1.text_.text = var_34_4
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424081", "424081007", "story_v_out_424081.awb") ~= 0 then
					local var_34_8 = manager.audio:GetVoiceLength("story_v_out_424081", "424081007", "story_v_out_424081.awb") / 1000

					if var_34_8 + var_34_0 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_8 + var_34_0
					end

					if var_34_3.prefab_name ~= "" and arg_31_1.actors_[var_34_3.prefab_name] ~= nil then
						local var_34_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_31_1.actors_[var_34_3.prefab_name].transform, "story_v_out_424081", "424081007", "story_v_out_424081.awb")

						arg_31_1:RecordAudio("424081007", var_34_9)
						arg_31_1:RecordAudio("424081007", var_34_9)
					else
						arg_31_1:AudioAction("play", "voice", "story_v_out_424081", "424081007", "story_v_out_424081.awb")
					end

					arg_31_1:RecordHistoryTalkVoice("story_v_out_424081", "424081007", "story_v_out_424081.awb")
				end

				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_10 = math.max(var_34_1, arg_31_1.talkMaxDuration)

			if var_34_0 <= arg_31_1.time_ and arg_31_1.time_ < var_34_0 + var_34_10 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - var_34_0) / var_34_10

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= var_34_0 + var_34_10 and arg_31_1.time_ < var_34_0 + var_34_10 + arg_34_0 then
				arg_31_1.typewritter.percent = 1

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(true)
			end
		end

		arg_31_1.nodeConfigList_ = {}

		arg_31_1:InitPlayNodeList()
	end,
	Play424081008 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 424081008
		arg_35_1.duration_ = 1.2

		local var_35_0 = {
			zh = 1.033,
			ja = 1.2
		}
		local var_35_1 = manager.audio:GetLocalizationFlag()

		if var_35_0[var_35_1] ~= nil then
			arg_35_1.duration_ = var_35_0[var_35_1]
		end

		SetActive(arg_35_1.tipsGo_, false)

		function arg_35_1.onSingleLineFinish_()
			arg_35_1.onSingleLineUpdate_ = nil
			arg_35_1.onSingleLineFinish_ = nil
			arg_35_1.state_ = "waiting"
		end

		function arg_35_1.playNext_(arg_37_0)
			if arg_37_0 == 1 then
				arg_35_0:Play424081009(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			local var_38_0 = arg_35_1.actors_["1094"]
			local var_38_1 = 0

			if var_38_1 < arg_35_1.time_ and arg_35_1.time_ <= var_38_1 + arg_38_0 and not isNil(var_38_0) and arg_35_1.var_.actorSpriteComps1094 == nil then
				arg_35_1.var_.actorSpriteComps1094 = var_38_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_38_2 = 0.2

			if var_38_1 <= arg_35_1.time_ and arg_35_1.time_ < var_38_1 + var_38_2 and not isNil(var_38_0) then
				local var_38_3 = (arg_35_1.time_ - var_38_1) / var_38_2

				if arg_35_1.var_.actorSpriteComps1094 then
					for iter_38_0, iter_38_1 in pairs(arg_35_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_38_1 then
							if arg_35_1.isInRecall_ then
								local var_38_4 = Mathf.Lerp(iter_38_1.color.r, arg_35_1.hightColor1.r, var_38_3)
								local var_38_5 = Mathf.Lerp(iter_38_1.color.g, arg_35_1.hightColor1.g, var_38_3)
								local var_38_6 = Mathf.Lerp(iter_38_1.color.b, arg_35_1.hightColor1.b, var_38_3)

								iter_38_1.color = Color.New(var_38_4, var_38_5, var_38_6)
							else
								local var_38_7 = Mathf.Lerp(iter_38_1.color.r, 1, var_38_3)

								iter_38_1.color = Color.New(var_38_7, var_38_7, var_38_7)
							end
						end
					end
				end
			end

			if arg_35_1.time_ >= var_38_1 + var_38_2 and arg_35_1.time_ < var_38_1 + var_38_2 + arg_38_0 and not isNil(var_38_0) and arg_35_1.var_.actorSpriteComps1094 then
				for iter_38_2, iter_38_3 in pairs(arg_35_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_38_3 then
						if arg_35_1.isInRecall_ then
							iter_38_3.color = arg_35_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_38_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_35_1.var_.actorSpriteComps1094 = nil
			end

			local var_38_8 = arg_35_1.actors_["1094"].transform
			local var_38_9 = 0

			if var_38_9 < arg_35_1.time_ and arg_35_1.time_ <= var_38_9 + arg_38_0 then
				arg_35_1.var_.moveOldPos1094 = var_38_8.localPosition
				var_38_8.localScale = Vector3.New(1, 1, 1)

				arg_35_1:CheckSpriteTmpPos("1094", 3)

				local var_38_10 = var_38_8.childCount

				for iter_38_4 = 0, var_38_10 - 1 do
					local var_38_11 = var_38_8:GetChild(iter_38_4)

					if var_38_11.name == "split_1" then
						var_38_11:SetAsLastSibling()
						var_38_11.gameObject:SetActive(true)

						arg_35_1.var_.actorSpriteSplit1094 = var_38_11.gameObject:GetComponent(typeof(Image))

						arg_35_1.var_.actorSpriteSplit1094:SetAlpha(0)
					end
				end
			end

			local var_38_12 = 0.5

			if var_38_9 <= arg_35_1.time_ and arg_35_1.time_ < var_38_9 + var_38_12 then
				local var_38_13 = (arg_35_1.time_ - var_38_9) / var_38_12
				local var_38_14 = Vector3.New(0, -335, -230)

				var_38_8.localPosition = Vector3.Lerp(arg_35_1.var_.moveOldPos1094, var_38_14, var_38_13)

				if arg_35_1.var_.actorSpriteSplit1094 ~= nil then
					arg_35_1.var_.actorSpriteSplit1094:SetAlpha(var_38_13)
				end
			end

			if arg_35_1.time_ >= var_38_9 + var_38_12 and arg_35_1.time_ < var_38_9 + var_38_12 + arg_38_0 then
				var_38_8.localPosition = Vector3.New(0, -335, -230)

				if arg_35_1.var_.actorSpriteSplit1094 ~= nil then
					arg_35_1.var_.actorSpriteSplit1094:SetAlpha(1)
				end
			end

			local var_38_15 = 0
			local var_38_16 = 0.075

			if var_38_15 < arg_35_1.time_ and arg_35_1.time_ <= var_38_15 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, true)

				local var_38_17 = arg_35_1:FormatText(StoryNameCfg[181].name)

				arg_35_1.leftNameTxt_.text = var_38_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_35_1.leftNameTxt_.transform)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1.leftNameTxt_.text)
				SetActive(arg_35_1.iconTrs_.gameObject, false)
				arg_35_1.callingController_:SetSelectedState("normal")

				local var_38_18 = arg_35_1:GetWordFromCfg(424081008)
				local var_38_19 = arg_35_1:FormatText(var_38_18.content)

				arg_35_1.text_.text = var_38_19

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_20 = 3
				local var_38_21 = utf8.len(var_38_19)
				local var_38_22 = var_38_20 <= 0 and var_38_16 or var_38_16 * (var_38_21 / var_38_20)

				if var_38_22 > 0 and var_38_16 < var_38_22 then
					arg_35_1.talkMaxDuration = var_38_22

					if var_38_22 + var_38_15 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_22 + var_38_15
					end
				end

				arg_35_1.text_.text = var_38_19
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424081", "424081008", "story_v_out_424081.awb") ~= 0 then
					local var_38_23 = manager.audio:GetVoiceLength("story_v_out_424081", "424081008", "story_v_out_424081.awb") / 1000

					if var_38_23 + var_38_15 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_23 + var_38_15
					end

					if var_38_18.prefab_name ~= "" and arg_35_1.actors_[var_38_18.prefab_name] ~= nil then
						local var_38_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_35_1.actors_[var_38_18.prefab_name].transform, "story_v_out_424081", "424081008", "story_v_out_424081.awb")

						arg_35_1:RecordAudio("424081008", var_38_24)
						arg_35_1:RecordAudio("424081008", var_38_24)
					else
						arg_35_1:AudioAction("play", "voice", "story_v_out_424081", "424081008", "story_v_out_424081.awb")
					end

					arg_35_1:RecordHistoryTalkVoice("story_v_out_424081", "424081008", "story_v_out_424081.awb")
				end

				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_25 = math.max(var_38_16, arg_35_1.talkMaxDuration)

			if var_38_15 <= arg_35_1.time_ and arg_35_1.time_ < var_38_15 + var_38_25 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - var_38_15) / var_38_25

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= var_38_15 + var_38_25 and arg_35_1.time_ < var_38_15 + var_38_25 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_35_1:InitPlayNodeList()
	end,
	Play424081009 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 424081009
		arg_39_1.duration_ = 5

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play424081010(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			local var_42_0 = arg_39_1.actors_["1094"]
			local var_42_1 = 0

			if var_42_1 < arg_39_1.time_ and arg_39_1.time_ <= var_42_1 + arg_42_0 and not isNil(var_42_0) and arg_39_1.var_.actorSpriteComps1094 == nil then
				arg_39_1.var_.actorSpriteComps1094 = var_42_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_42_2 = 0.2

			if var_42_1 <= arg_39_1.time_ and arg_39_1.time_ < var_42_1 + var_42_2 and not isNil(var_42_0) then
				local var_42_3 = (arg_39_1.time_ - var_42_1) / var_42_2

				if arg_39_1.var_.actorSpriteComps1094 then
					for iter_42_0, iter_42_1 in pairs(arg_39_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_42_1 then
							if arg_39_1.isInRecall_ then
								local var_42_4 = Mathf.Lerp(iter_42_1.color.r, arg_39_1.hightColor2.r, var_42_3)
								local var_42_5 = Mathf.Lerp(iter_42_1.color.g, arg_39_1.hightColor2.g, var_42_3)
								local var_42_6 = Mathf.Lerp(iter_42_1.color.b, arg_39_1.hightColor2.b, var_42_3)

								iter_42_1.color = Color.New(var_42_4, var_42_5, var_42_6)
							else
								local var_42_7 = Mathf.Lerp(iter_42_1.color.r, 0.5, var_42_3)

								iter_42_1.color = Color.New(var_42_7, var_42_7, var_42_7)
							end
						end
					end
				end
			end

			if arg_39_1.time_ >= var_42_1 + var_42_2 and arg_39_1.time_ < var_42_1 + var_42_2 + arg_42_0 and not isNil(var_42_0) and arg_39_1.var_.actorSpriteComps1094 then
				for iter_42_2, iter_42_3 in pairs(arg_39_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_42_3 then
						if arg_39_1.isInRecall_ then
							iter_42_3.color = arg_39_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_42_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_39_1.var_.actorSpriteComps1094 = nil
			end

			local var_42_8 = 0
			local var_42_9 = 0.275

			if var_42_8 < arg_39_1.time_ and arg_39_1.time_ <= var_42_8 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, true)

				local var_42_10 = arg_39_1:FormatText(StoryNameCfg[7].name)

				arg_39_1.leftNameTxt_.text = var_42_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_39_1.leftNameTxt_.transform)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1.leftNameTxt_.text)
				SetActive(arg_39_1.iconTrs_.gameObject, true)
				arg_39_1.iconController_:SetSelectedState("hero")

				arg_39_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_39_1.callingController_:SetSelectedState("normal")

				arg_39_1.keyicon_.color = Color.New(1, 1, 1)
				arg_39_1.icon_.color = Color.New(1, 1, 1)

				local var_42_11 = arg_39_1:GetWordFromCfg(424081009)
				local var_42_12 = arg_39_1:FormatText(var_42_11.content)

				arg_39_1.text_.text = var_42_12

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_13 = 11
				local var_42_14 = utf8.len(var_42_12)
				local var_42_15 = var_42_13 <= 0 and var_42_9 or var_42_9 * (var_42_14 / var_42_13)

				if var_42_15 > 0 and var_42_9 < var_42_15 then
					arg_39_1.talkMaxDuration = var_42_15

					if var_42_15 + var_42_8 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_15 + var_42_8
					end
				end

				arg_39_1.text_.text = var_42_12
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)
				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_16 = math.max(var_42_9, arg_39_1.talkMaxDuration)

			if var_42_8 <= arg_39_1.time_ and arg_39_1.time_ < var_42_8 + var_42_16 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_8) / var_42_16

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_8 + var_42_16 and arg_39_1.time_ < var_42_8 + var_42_16 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {}

		arg_39_1:InitPlayNodeList()
	end,
	Play424081010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 424081010
		arg_43_1.duration_ = 9

		SetActive(arg_43_1.tipsGo_, false)

		function arg_43_1.onSingleLineFinish_()
			arg_43_1.onSingleLineUpdate_ = nil
			arg_43_1.onSingleLineFinish_ = nil
			arg_43_1.state_ = "waiting"
		end

		function arg_43_1.playNext_(arg_45_0)
			if arg_45_0 == 1 then
				arg_43_0:Play424081011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			local var_46_0 = "STblack"

			if arg_43_1.bgs_[var_46_0] == nil then
				local var_46_1 = Object.Instantiate(arg_43_1.paintGo_)

				var_46_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_46_0)
				var_46_1.name = var_46_0
				var_46_1.transform.parent = arg_43_1.stage_.transform
				var_46_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_43_1.bgs_[var_46_0] = var_46_1
			end

			local var_46_2 = 2

			if var_46_2 < arg_43_1.time_ and arg_43_1.time_ <= var_46_2 + arg_46_0 then
				local var_46_3 = manager.ui.mainCamera.transform.localPosition
				local var_46_4 = Vector3.New(0, 0, 10) + Vector3.New(var_46_3.x, var_46_3.y, 0)
				local var_46_5 = arg_43_1.bgs_.STblack

				var_46_5.transform.localPosition = var_46_4
				var_46_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_46_6 = var_46_5:GetComponent("SpriteRenderer")

				if var_46_6 and var_46_6.sprite then
					local var_46_7 = (var_46_5.transform.localPosition - var_46_3).z
					local var_46_8 = manager.ui.mainCameraCom_
					local var_46_9 = 2 * var_46_7 * Mathf.Tan(var_46_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_46_10 = var_46_9 * var_46_8.aspect
					local var_46_11 = var_46_6.sprite.bounds.size.x
					local var_46_12 = var_46_6.sprite.bounds.size.y
					local var_46_13 = var_46_10 / var_46_11
					local var_46_14 = var_46_9 / var_46_12
					local var_46_15 = var_46_14 < var_46_13 and var_46_13 or var_46_14

					var_46_5.transform.localScale = Vector3.New(var_46_15, var_46_15, 0)
				end

				for iter_46_0, iter_46_1 in pairs(arg_43_1.bgs_) do
					if iter_46_0 ~= "STblack" then
						iter_46_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_46_16 = 4

			if var_46_16 < arg_43_1.time_ and arg_43_1.time_ <= var_46_16 + arg_46_0 then
				arg_43_1.allBtn_.enabled = false
			end

			local var_46_17 = 0.3

			if arg_43_1.time_ >= var_46_16 + var_46_17 and arg_43_1.time_ < var_46_16 + var_46_17 + arg_46_0 then
				arg_43_1.allBtn_.enabled = true
			end

			local var_46_18 = 0

			if var_46_18 < arg_43_1.time_ and arg_43_1.time_ <= var_46_18 + arg_46_0 then
				arg_43_1.mask_.enabled = true
				arg_43_1.mask_.raycastTarget = true

				arg_43_1:SetGaussion(false)
			end

			local var_46_19 = 2

			if var_46_18 <= arg_43_1.time_ and arg_43_1.time_ < var_46_18 + var_46_19 then
				local var_46_20 = (arg_43_1.time_ - var_46_18) / var_46_19
				local var_46_21 = Color.New(0, 0, 0)

				var_46_21.a = Mathf.Lerp(0, 1, var_46_20)
				arg_43_1.mask_.color = var_46_21
			end

			if arg_43_1.time_ >= var_46_18 + var_46_19 and arg_43_1.time_ < var_46_18 + var_46_19 + arg_46_0 then
				local var_46_22 = Color.New(0, 0, 0)

				var_46_22.a = 1
				arg_43_1.mask_.color = var_46_22
			end

			local var_46_23 = 2

			if var_46_23 < arg_43_1.time_ and arg_43_1.time_ <= var_46_23 + arg_46_0 then
				arg_43_1.mask_.enabled = true
				arg_43_1.mask_.raycastTarget = true

				arg_43_1:SetGaussion(false)
			end

			local var_46_24 = 2

			if var_46_23 <= arg_43_1.time_ and arg_43_1.time_ < var_46_23 + var_46_24 then
				local var_46_25 = (arg_43_1.time_ - var_46_23) / var_46_24
				local var_46_26 = Color.New(0, 0, 0)

				var_46_26.a = Mathf.Lerp(1, 0, var_46_25)
				arg_43_1.mask_.color = var_46_26
			end

			if arg_43_1.time_ >= var_46_23 + var_46_24 and arg_43_1.time_ < var_46_23 + var_46_24 + arg_46_0 then
				local var_46_27 = Color.New(0, 0, 0)
				local var_46_28 = 0

				arg_43_1.mask_.enabled = false
				var_46_27.a = var_46_28
				arg_43_1.mask_.color = var_46_27
			end

			local var_46_29 = arg_43_1.actors_["1094"].transform
			local var_46_30 = 1.966

			if var_46_30 < arg_43_1.time_ and arg_43_1.time_ <= var_46_30 + arg_46_0 then
				arg_43_1.var_.moveOldPos1094 = var_46_29.localPosition
				var_46_29.localScale = Vector3.New(1, 1, 1)

				arg_43_1:CheckSpriteTmpPos("1094", 7)

				local var_46_31 = var_46_29.childCount

				for iter_46_2 = 0, var_46_31 - 1 do
					local var_46_32 = var_46_29:GetChild(iter_46_2)

					if var_46_32.name == "" or not string.find(var_46_32.name, "split") then
						var_46_32.gameObject:SetActive(true)
					else
						var_46_32.gameObject:SetActive(false)
					end
				end
			end

			local var_46_33 = 0.001

			if var_46_30 <= arg_43_1.time_ and arg_43_1.time_ < var_46_30 + var_46_33 then
				local var_46_34 = (arg_43_1.time_ - var_46_30) / var_46_33
				local var_46_35 = Vector3.New(0, -2000, 0)

				var_46_29.localPosition = Vector3.Lerp(arg_43_1.var_.moveOldPos1094, var_46_35, var_46_34)
			end

			if arg_43_1.time_ >= var_46_30 + var_46_33 and arg_43_1.time_ < var_46_30 + var_46_33 + arg_46_0 then
				var_46_29.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_46_36 = 0.1
			local var_46_37 = 1

			if var_46_36 < arg_43_1.time_ and arg_43_1.time_ <= var_46_36 + arg_46_0 then
				local var_46_38 = "stop"
				local var_46_39 = "effect"

				arg_43_1:AudioAction(var_46_38, var_46_39, "se_story_16", "se_story_16_street_loop", "")
			end

			local var_46_40 = 4.025
			local var_46_41 = 1

			if var_46_40 < arg_43_1.time_ and arg_43_1.time_ <= var_46_40 + arg_46_0 then
				local var_46_42 = "play"
				local var_46_43 = "effect"

				arg_43_1:AudioAction(var_46_42, var_46_43, "se_story_144", "se_story_144_door_open", "")
			end

			local var_46_44 = 0.1
			local var_46_45 = 0.3

			if var_46_44 < arg_43_1.time_ and arg_43_1.time_ <= var_46_44 + arg_46_0 then
				local var_46_46 = "play"
				local var_46_47 = "music"

				arg_43_1:AudioAction(var_46_46, var_46_47, "ui_battle", "ui_battle_stopbgm", "")

				local var_46_48 = ""
				local var_46_49 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_46_49 ~= "" then
					if arg_43_1.bgmTxt_.text ~= var_46_49 and arg_43_1.bgmTxt_.text ~= "" then
						if arg_43_1.bgmTxt2_.text ~= "" then
							arg_43_1.bgmTxt_.text = arg_43_1.bgmTxt2_.text
						end

						arg_43_1.bgmTxt2_.text = var_46_49

						arg_43_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_43_1.bgmTxt_.text = var_46_49
						arg_43_1.bgmTxt2_.text = var_46_49
					end

					if arg_43_1.bgmTimer then
						arg_43_1.bgmTimer:Stop()

						arg_43_1.bgmTimer = nil
					end

					if arg_43_1.settingData.show_music_name == 1 then
						arg_43_1.musicController:SetSelectedState("show")
						arg_43_1.musicAnimator_:Play("open", 0, 0)

						if arg_43_1.settingData.music_time ~= 0 then
							arg_43_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_43_1.settingData.music_time), function()
								if arg_43_1 == nil or isNil(arg_43_1.bgmTxt_) then
									return
								end

								arg_43_1.musicController:SetSelectedState("hide")
								arg_43_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_43_1.frameCnt_ <= 1 then
				arg_43_1.dialog_:SetActive(false)
			end

			local var_46_50 = 4
			local var_46_51 = 1.025

			if var_46_50 < arg_43_1.time_ and arg_43_1.time_ <= var_46_50 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0

				arg_43_1.dialog_:SetActive(true)

				arg_43_1.dialogCg_.alpha = 0

				local var_46_52 = LeanTween.value(arg_43_1.dialog_, 0, 1, 0.3)

				var_46_52:setOnUpdate(LuaHelper.FloatAction(function(arg_48_0)
					arg_43_1.dialogCg_.alpha = arg_48_0
				end))
				var_46_52:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_43_1.dialog_)
					var_46_52:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_43_1.duration_ = arg_43_1.duration_ + 0.3

				SetActive(arg_43_1.leftNameGo_, false)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_53 = arg_43_1:GetWordFromCfg(424081010)
				local var_46_54 = arg_43_1:FormatText(var_46_53.content)

				arg_43_1.text_.text = var_46_54

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_55 = 41
				local var_46_56 = utf8.len(var_46_54)
				local var_46_57 = var_46_55 <= 0 and var_46_51 or var_46_51 * (var_46_56 / var_46_55)

				if var_46_57 > 0 and var_46_51 < var_46_57 then
					arg_43_1.talkMaxDuration = var_46_57
					var_46_50 = var_46_50 + 0.3

					if var_46_57 + var_46_50 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_57 + var_46_50
					end
				end

				arg_43_1.text_.text = var_46_54
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)
				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_58 = var_46_50 + 0.3
			local var_46_59 = math.max(var_46_51, arg_43_1.talkMaxDuration)

			if var_46_58 <= arg_43_1.time_ and arg_43_1.time_ < var_46_58 + var_46_59 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_58) / var_46_59

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_58 + var_46_59 and arg_43_1.time_ < var_46_58 + var_46_59 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_43_1:InitPlayNodeList()
	end,
	Play424081011 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 424081011
		arg_50_1.duration_ = 8.47

		local var_50_0 = {
			zh = 7.166,
			ja = 8.466
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
				arg_50_0:Play424081012(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			local var_53_0 = "SS2402"

			if arg_50_1.bgs_[var_53_0] == nil then
				local var_53_1 = Object.Instantiate(arg_50_1.paintGo_)

				var_53_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_53_0)
				var_53_1.name = var_53_0
				var_53_1.transform.parent = arg_50_1.stage_.transform
				var_53_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_50_1.bgs_[var_53_0] = var_53_1
			end

			local var_53_2 = 0

			if var_53_2 < arg_50_1.time_ and arg_50_1.time_ <= var_53_2 + arg_53_0 then
				local var_53_3 = manager.ui.mainCamera.transform.localPosition
				local var_53_4 = Vector3.New(0, 0, 10) + Vector3.New(var_53_3.x, var_53_3.y, 0)
				local var_53_5 = arg_50_1.bgs_.SS2402

				var_53_5.transform.localPosition = var_53_4
				var_53_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_53_6 = var_53_5:GetComponent("SpriteRenderer")

				if var_53_6 and var_53_6.sprite then
					local var_53_7 = (var_53_5.transform.localPosition - var_53_3).z
					local var_53_8 = manager.ui.mainCameraCom_
					local var_53_9 = 2 * var_53_7 * Mathf.Tan(var_53_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_53_10 = var_53_9 * var_53_8.aspect
					local var_53_11 = var_53_6.sprite.bounds.size.x
					local var_53_12 = var_53_6.sprite.bounds.size.y
					local var_53_13 = var_53_10 / var_53_11
					local var_53_14 = var_53_9 / var_53_12
					local var_53_15 = var_53_14 < var_53_13 and var_53_13 or var_53_14

					var_53_5.transform.localScale = Vector3.New(var_53_15, var_53_15, 0)
				end

				for iter_53_0, iter_53_1 in pairs(arg_50_1.bgs_) do
					if iter_53_0 ~= "SS2402" then
						iter_53_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_53_16 = 2

			if var_53_16 < arg_50_1.time_ and arg_50_1.time_ <= var_53_16 + arg_53_0 then
				arg_50_1.allBtn_.enabled = false
			end

			local var_53_17 = 0.3

			if arg_50_1.time_ >= var_53_16 + var_53_17 and arg_50_1.time_ < var_53_16 + var_53_17 + arg_53_0 then
				arg_50_1.allBtn_.enabled = true
			end

			local var_53_18 = 0

			if var_53_18 < arg_50_1.time_ and arg_50_1.time_ <= var_53_18 + arg_53_0 then
				arg_50_1.mask_.enabled = true
				arg_50_1.mask_.raycastTarget = true

				arg_50_1:SetGaussion(false)
			end

			local var_53_19 = 2

			if var_53_18 <= arg_50_1.time_ and arg_50_1.time_ < var_53_18 + var_53_19 then
				local var_53_20 = (arg_50_1.time_ - var_53_18) / var_53_19
				local var_53_21 = Color.New(0, 0, 0)

				var_53_21.a = Mathf.Lerp(1, 0, var_53_20)
				arg_50_1.mask_.color = var_53_21
			end

			if arg_50_1.time_ >= var_53_18 + var_53_19 and arg_50_1.time_ < var_53_18 + var_53_19 + arg_53_0 then
				local var_53_22 = Color.New(0, 0, 0)
				local var_53_23 = 0

				arg_50_1.mask_.enabled = false
				var_53_22.a = var_53_23
				arg_50_1.mask_.color = var_53_22
			end

			local var_53_24 = arg_50_1.bgs_.SS2402.transform
			local var_53_25 = 0

			if var_53_25 < arg_50_1.time_ and arg_50_1.time_ <= var_53_25 + arg_53_0 then
				arg_50_1.var_.moveOldPosSS2402 = var_53_24.localPosition
			end

			local var_53_26 = 3

			if var_53_25 <= arg_50_1.time_ and arg_50_1.time_ < var_53_25 + var_53_26 then
				local var_53_27 = (arg_50_1.time_ - var_53_25) / var_53_26
				local var_53_28 = Vector3.New(4.5, -0.1, -2)

				var_53_24.localPosition = Vector3.Lerp(arg_50_1.var_.moveOldPosSS2402, var_53_28, var_53_27)
			end

			if arg_50_1.time_ >= var_53_25 + var_53_26 and arg_50_1.time_ < var_53_25 + var_53_26 + arg_53_0 then
				var_53_24.localPosition = Vector3.New(4.5, -0.1, -2)
			end

			local var_53_29 = 0
			local var_53_30 = 0.3

			if var_53_29 < arg_50_1.time_ and arg_50_1.time_ <= var_53_29 + arg_53_0 then
				local var_53_31 = "play"
				local var_53_32 = "music"

				arg_50_1:AudioAction(var_53_31, var_53_32, "ui_battle", "ui_battle_stopbgm", "")

				local var_53_33 = ""
				local var_53_34 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_53_34 ~= "" then
					if arg_50_1.bgmTxt_.text ~= var_53_34 and arg_50_1.bgmTxt_.text ~= "" then
						if arg_50_1.bgmTxt2_.text ~= "" then
							arg_50_1.bgmTxt_.text = arg_50_1.bgmTxt2_.text
						end

						arg_50_1.bgmTxt2_.text = var_53_34

						arg_50_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_50_1.bgmTxt_.text = var_53_34
						arg_50_1.bgmTxt2_.text = var_53_34
					end

					if arg_50_1.bgmTimer then
						arg_50_1.bgmTimer:Stop()

						arg_50_1.bgmTimer = nil
					end

					if arg_50_1.settingData.show_music_name == 1 then
						arg_50_1.musicController:SetSelectedState("show")
						arg_50_1.musicAnimator_:Play("open", 0, 0)

						if arg_50_1.settingData.music_time ~= 0 then
							arg_50_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_50_1.settingData.music_time), function()
								if arg_50_1 == nil or isNil(arg_50_1.bgmTxt_) then
									return
								end

								arg_50_1.musicController:SetSelectedState("hide")
								arg_50_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_53_35 = 0.433333333333333
			local var_53_36 = 1

			if var_53_35 < arg_50_1.time_ and arg_50_1.time_ <= var_53_35 + arg_53_0 then
				local var_53_37 = "play"
				local var_53_38 = "music"

				arg_50_1:AudioAction(var_53_37, var_53_38, "bgm_activity_4_6_story_daily", "bgm_activity_4_6_story_daily", "bgm_activity_4_6_story_daily.awb")

				local var_53_39 = ""
				local var_53_40 = manager.audio:GetAudioName("bgm_activity_4_6_story_daily", "bgm_activity_4_6_story_daily")

				if var_53_40 ~= "" then
					if arg_50_1.bgmTxt_.text ~= var_53_40 and arg_50_1.bgmTxt_.text ~= "" then
						if arg_50_1.bgmTxt2_.text ~= "" then
							arg_50_1.bgmTxt_.text = arg_50_1.bgmTxt2_.text
						end

						arg_50_1.bgmTxt2_.text = var_53_40

						arg_50_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_50_1.bgmTxt_.text = var_53_40
						arg_50_1.bgmTxt2_.text = var_53_40
					end

					if arg_50_1.bgmTimer then
						arg_50_1.bgmTimer:Stop()

						arg_50_1.bgmTimer = nil
					end

					if arg_50_1.settingData.show_music_name == 1 then
						arg_50_1.musicController:SetSelectedState("show")
						arg_50_1.musicAnimator_:Play("open", 0, 0)

						if arg_50_1.settingData.music_time ~= 0 then
							arg_50_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_50_1.settingData.music_time), function()
								if arg_50_1 == nil or isNil(arg_50_1.bgmTxt_) then
									return
								end

								arg_50_1.musicController:SetSelectedState("hide")
								arg_50_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_53_41 = 0.1
			local var_53_42 = 1

			if var_53_41 < arg_50_1.time_ and arg_50_1.time_ <= var_53_41 + arg_53_0 then
				local var_53_43 = "play"
				local var_53_44 = "effect"

				arg_50_1:AudioAction(var_53_43, var_53_44, "se_story_143", "se_story_143_amb_bar", "")
			end

			if arg_50_1.frameCnt_ <= 1 then
				arg_50_1.dialog_:SetActive(false)
			end

			local var_53_45 = 2
			local var_53_46 = 0.625

			if var_53_45 < arg_50_1.time_ and arg_50_1.time_ <= var_53_45 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0

				arg_50_1.dialog_:SetActive(true)

				arg_50_1.dialogCg_.alpha = 0

				local var_53_47 = LeanTween.value(arg_50_1.dialog_, 0, 1, 0.3)

				var_53_47:setOnUpdate(LuaHelper.FloatAction(function(arg_56_0)
					arg_50_1.dialogCg_.alpha = arg_56_0
				end))
				var_53_47:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_50_1.dialog_)
					var_53_47:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_50_1.duration_ = arg_50_1.duration_ + 0.3

				SetActive(arg_50_1.leftNameGo_, true)

				local var_53_48 = arg_50_1:FormatText(StoryNameCfg[1394].name)

				arg_50_1.leftNameTxt_.text = var_53_48

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_50_1.leftNameTxt_.transform)

				arg_50_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_50_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_50_1:RecordName(arg_50_1.leftNameTxt_.text)
				SetActive(arg_50_1.iconTrs_.gameObject, true)
				arg_50_1.iconController_:SetSelectedState("hero")

				arg_50_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lolib")

				arg_50_1.callingController_:SetSelectedState("normal")

				arg_50_1.keyicon_.color = Color.New(1, 1, 1)
				arg_50_1.icon_.color = Color.New(1, 1, 1)

				local var_53_49 = arg_50_1:GetWordFromCfg(424081011)
				local var_53_50 = arg_50_1:FormatText(var_53_49.content)

				arg_50_1.text_.text = var_53_50

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_51 = 25
				local var_53_52 = utf8.len(var_53_50)
				local var_53_53 = var_53_51 <= 0 and var_53_46 or var_53_46 * (var_53_52 / var_53_51)

				if var_53_53 > 0 and var_53_46 < var_53_53 then
					arg_50_1.talkMaxDuration = var_53_53
					var_53_45 = var_53_45 + 0.3

					if var_53_53 + var_53_45 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_53 + var_53_45
					end
				end

				arg_50_1.text_.text = var_53_50
				arg_50_1.typewritter.percent = 0

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424081", "424081011", "story_v_out_424081.awb") ~= 0 then
					local var_53_54 = manager.audio:GetVoiceLength("story_v_out_424081", "424081011", "story_v_out_424081.awb") / 1000

					if var_53_54 + var_53_45 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_54 + var_53_45
					end

					if var_53_49.prefab_name ~= "" and arg_50_1.actors_[var_53_49.prefab_name] ~= nil then
						local var_53_55 = LuaForUtil.PlayVoiceWithCriLipsync(arg_50_1.actors_[var_53_49.prefab_name].transform, "story_v_out_424081", "424081011", "story_v_out_424081.awb")

						arg_50_1:RecordAudio("424081011", var_53_55)
						arg_50_1:RecordAudio("424081011", var_53_55)
					else
						arg_50_1:AudioAction("play", "voice", "story_v_out_424081", "424081011", "story_v_out_424081.awb")
					end

					arg_50_1:RecordHistoryTalkVoice("story_v_out_424081", "424081011", "story_v_out_424081.awb")
				end

				arg_50_1:RecordContent(arg_50_1.text_.text)
			end

			local var_53_56 = var_53_45 + 0.3
			local var_53_57 = math.max(var_53_46, arg_50_1.talkMaxDuration)

			if var_53_56 <= arg_50_1.time_ and arg_50_1.time_ < var_53_56 + var_53_57 then
				arg_50_1.typewritter.percent = (arg_50_1.time_ - var_53_56) / var_53_57

				arg_50_1.typewritter:SetDirty()
			end

			if arg_50_1.time_ >= var_53_56 + var_53_57 and arg_50_1.time_ < var_53_56 + var_53_57 + arg_53_0 then
				arg_50_1.typewritter.percent = 1

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(true)
			end
		end

		arg_50_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "SS2402",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 3,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(4.7, 0, -2),
					endPos = Vector3.New(4.5, -0.1, -2),
					easeType = LeanTweenType.easeInOutSine
				}
			}
		}

		arg_50_1:InitPlayNodeList()
	end,
	Play424081012 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 424081012
		arg_58_1.duration_ = 3.13

		local var_58_0 = {
			zh = 2.999999999999,
			ja = 3.133
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
				arg_58_0:Play424081013(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			local var_61_0 = arg_58_1.bgs_.SS2402.transform
			local var_61_1 = 0

			if var_61_1 < arg_58_1.time_ and arg_58_1.time_ <= var_61_1 + arg_61_0 then
				arg_58_1.var_.moveOldPosSS2402 = var_61_0.localPosition
			end

			local var_61_2 = 3

			if var_61_1 <= arg_58_1.time_ and arg_58_1.time_ < var_61_1 + var_61_2 then
				local var_61_3 = (arg_58_1.time_ - var_61_1) / var_61_2
				local var_61_4 = Vector3.New(0, -0.47, 2)

				var_61_0.localPosition = Vector3.Lerp(arg_58_1.var_.moveOldPosSS2402, var_61_4, var_61_3)
			end

			if arg_58_1.time_ >= var_61_1 + var_61_2 and arg_58_1.time_ < var_61_1 + var_61_2 + arg_61_0 then
				var_61_0.localPosition = Vector3.New(0, -0.47, 2)
			end

			local var_61_5 = 0

			if var_61_5 < arg_58_1.time_ and arg_58_1.time_ <= var_61_5 + arg_61_0 then
				arg_58_1.allBtn_.enabled = false
			end

			local var_61_6 = 3

			if arg_58_1.time_ >= var_61_5 + var_61_6 and arg_58_1.time_ < var_61_5 + var_61_6 + arg_61_0 then
				arg_58_1.allBtn_.enabled = true
			end

			if arg_58_1.frameCnt_ <= 1 then
				arg_58_1.dialog_:SetActive(false)
			end

			local var_61_7 = 0.4
			local var_61_8 = 0.225

			if var_61_7 < arg_58_1.time_ and arg_58_1.time_ <= var_61_7 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0

				arg_58_1.dialog_:SetActive(true)

				arg_58_1.dialogCg_.alpha = 0

				local var_61_9 = LeanTween.value(arg_58_1.dialog_, 0, 1, 0.3)

				var_61_9:setOnUpdate(LuaHelper.FloatAction(function(arg_62_0)
					arg_58_1.dialogCg_.alpha = arg_62_0
				end))
				var_61_9:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_58_1.dialog_)
					var_61_9:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_58_1.duration_ = arg_58_1.duration_ + 0.3

				SetActive(arg_58_1.leftNameGo_, true)

				local var_61_10 = arg_58_1:FormatText(StoryNameCfg[1393].name)

				arg_58_1.leftNameTxt_.text = var_61_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_58_1.leftNameTxt_.transform)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1.leftNameTxt_.text)
				SetActive(arg_58_1.iconTrs_.gameObject, true)
				arg_58_1.iconController_:SetSelectedState("hero")

				arg_58_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lolia")

				arg_58_1.callingController_:SetSelectedState("normal")

				arg_58_1.keyicon_.color = Color.New(1, 1, 1)
				arg_58_1.icon_.color = Color.New(1, 1, 1)

				local var_61_11 = arg_58_1:GetWordFromCfg(424081012)
				local var_61_12 = arg_58_1:FormatText(var_61_11.content)

				arg_58_1.text_.text = var_61_12

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_13 = 9
				local var_61_14 = utf8.len(var_61_12)
				local var_61_15 = var_61_13 <= 0 and var_61_8 or var_61_8 * (var_61_14 / var_61_13)

				if var_61_15 > 0 and var_61_8 < var_61_15 then
					arg_58_1.talkMaxDuration = var_61_15
					var_61_7 = var_61_7 + 0.3

					if var_61_15 + var_61_7 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_15 + var_61_7
					end
				end

				arg_58_1.text_.text = var_61_12
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424081", "424081012", "story_v_out_424081.awb") ~= 0 then
					local var_61_16 = manager.audio:GetVoiceLength("story_v_out_424081", "424081012", "story_v_out_424081.awb") / 1000

					if var_61_16 + var_61_7 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_16 + var_61_7
					end

					if var_61_11.prefab_name ~= "" and arg_58_1.actors_[var_61_11.prefab_name] ~= nil then
						local var_61_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_58_1.actors_[var_61_11.prefab_name].transform, "story_v_out_424081", "424081012", "story_v_out_424081.awb")

						arg_58_1:RecordAudio("424081012", var_61_17)
						arg_58_1:RecordAudio("424081012", var_61_17)
					else
						arg_58_1:AudioAction("play", "voice", "story_v_out_424081", "424081012", "story_v_out_424081.awb")
					end

					arg_58_1:RecordHistoryTalkVoice("story_v_out_424081", "424081012", "story_v_out_424081.awb")
				end

				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_18 = var_61_7 + 0.3
			local var_61_19 = math.max(var_61_8, arg_58_1.talkMaxDuration)

			if var_61_18 <= arg_58_1.time_ and arg_58_1.time_ < var_61_18 + var_61_19 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - var_61_18) / var_61_19

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= var_61_18 + var_61_19 and arg_58_1.time_ < var_61_18 + var_61_19 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "SS2402",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 3,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(4.7, -0.1, -2),
					endPos = Vector3.New(0, -0.47, 2),
					easeType = LeanTweenType.easeOutExpo
				}
			}
		}

		arg_58_1:InitPlayNodeList()
	end,
	Play424081013 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 424081013
		arg_64_1.duration_ = 5

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play424081014(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_0 = 0.7
			local var_67_1 = 1

			if var_67_0 < arg_64_1.time_ and arg_64_1.time_ <= var_67_0 + arg_67_0 then
				local var_67_2 = "play"
				local var_67_3 = "effect"

				arg_64_1:AudioAction(var_67_2, var_67_3, "se_story_146", "se_story_146_cheer", "")
			end

			local var_67_4 = 0
			local var_67_5 = 1.15

			if var_67_4 < arg_64_1.time_ and arg_64_1.time_ <= var_67_4 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, false)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_6 = arg_64_1:GetWordFromCfg(424081013)
				local var_67_7 = arg_64_1:FormatText(var_67_6.content)

				arg_64_1.text_.text = var_67_7

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_8 = 46
				local var_67_9 = utf8.len(var_67_7)
				local var_67_10 = var_67_8 <= 0 and var_67_5 or var_67_5 * (var_67_9 / var_67_8)

				if var_67_10 > 0 and var_67_5 < var_67_10 then
					arg_64_1.talkMaxDuration = var_67_10

					if var_67_10 + var_67_4 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_10 + var_67_4
					end
				end

				arg_64_1.text_.text = var_67_7
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)
				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_11 = math.max(var_67_5, arg_64_1.talkMaxDuration)

			if var_67_4 <= arg_64_1.time_ and arg_64_1.time_ < var_67_4 + var_67_11 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_4) / var_67_11

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_4 + var_67_11 and arg_64_1.time_ < var_67_4 + var_67_11 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {}

		arg_64_1:InitPlayNodeList()
	end,
	Play424081014 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 424081014
		arg_68_1.duration_ = 5

		SetActive(arg_68_1.tipsGo_, false)

		function arg_68_1.onSingleLineFinish_()
			arg_68_1.onSingleLineUpdate_ = nil
			arg_68_1.onSingleLineFinish_ = nil
			arg_68_1.state_ = "waiting"
		end

		function arg_68_1.playNext_(arg_70_0)
			if arg_70_0 == 1 then
				arg_68_0:Play424081015(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = 0
			local var_71_1 = 0.225

			if var_71_0 < arg_68_1.time_ and arg_68_1.time_ <= var_71_0 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				local var_71_2 = arg_68_1:FormatText(StoryNameCfg[7].name)

				arg_68_1.leftNameTxt_.text = var_71_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, true)
				arg_68_1.iconController_:SetSelectedState("hero")

				arg_68_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_68_1.callingController_:SetSelectedState("normal")

				arg_68_1.keyicon_.color = Color.New(1, 1, 1)
				arg_68_1.icon_.color = Color.New(1, 1, 1)

				local var_71_3 = arg_68_1:GetWordFromCfg(424081014)
				local var_71_4 = arg_68_1:FormatText(var_71_3.content)

				arg_68_1.text_.text = var_71_4

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_5 = 9
				local var_71_6 = utf8.len(var_71_4)
				local var_71_7 = var_71_5 <= 0 and var_71_1 or var_71_1 * (var_71_6 / var_71_5)

				if var_71_7 > 0 and var_71_1 < var_71_7 then
					arg_68_1.talkMaxDuration = var_71_7

					if var_71_7 + var_71_0 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_7 + var_71_0
					end
				end

				arg_68_1.text_.text = var_71_4
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)
				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_8 = math.max(var_71_1, arg_68_1.talkMaxDuration)

			if var_71_0 <= arg_68_1.time_ and arg_68_1.time_ < var_71_0 + var_71_8 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_0) / var_71_8

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_0 + var_71_8 and arg_68_1.time_ < var_71_0 + var_71_8 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {}

		arg_68_1:InitPlayNodeList()
	end,
	Play424081015 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 424081015
		arg_72_1.duration_ = 7.5

		local var_72_0 = {
			zh = 4.933,
			ja = 7.5
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
				arg_72_0:Play424081016(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			local var_75_0 = 0
			local var_75_1 = 0.575

			if var_75_0 < arg_72_1.time_ and arg_72_1.time_ <= var_75_0 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				local var_75_2 = arg_72_1:FormatText(StoryNameCfg[1394].name)

				arg_72_1.leftNameTxt_.text = var_75_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, true)
				arg_72_1.iconController_:SetSelectedState("hero")

				arg_72_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lolib")

				arg_72_1.callingController_:SetSelectedState("normal")

				arg_72_1.keyicon_.color = Color.New(1, 1, 1)
				arg_72_1.icon_.color = Color.New(1, 1, 1)

				local var_75_3 = arg_72_1:GetWordFromCfg(424081015)
				local var_75_4 = arg_72_1:FormatText(var_75_3.content)

				arg_72_1.text_.text = var_75_4

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_5 = 23
				local var_75_6 = utf8.len(var_75_4)
				local var_75_7 = var_75_5 <= 0 and var_75_1 or var_75_1 * (var_75_6 / var_75_5)

				if var_75_7 > 0 and var_75_1 < var_75_7 then
					arg_72_1.talkMaxDuration = var_75_7

					if var_75_7 + var_75_0 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_7 + var_75_0
					end
				end

				arg_72_1.text_.text = var_75_4
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424081", "424081015", "story_v_out_424081.awb") ~= 0 then
					local var_75_8 = manager.audio:GetVoiceLength("story_v_out_424081", "424081015", "story_v_out_424081.awb") / 1000

					if var_75_8 + var_75_0 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_8 + var_75_0
					end

					if var_75_3.prefab_name ~= "" and arg_72_1.actors_[var_75_3.prefab_name] ~= nil then
						local var_75_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_3.prefab_name].transform, "story_v_out_424081", "424081015", "story_v_out_424081.awb")

						arg_72_1:RecordAudio("424081015", var_75_9)
						arg_72_1:RecordAudio("424081015", var_75_9)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_out_424081", "424081015", "story_v_out_424081.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_out_424081", "424081015", "story_v_out_424081.awb")
				end

				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_10 = math.max(var_75_1, arg_72_1.talkMaxDuration)

			if var_75_0 <= arg_72_1.time_ and arg_72_1.time_ < var_75_0 + var_75_10 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_0) / var_75_10

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_0 + var_75_10 and arg_72_1.time_ < var_75_0 + var_75_10 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {}

		arg_72_1:InitPlayNodeList()
	end,
	Play424081016 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 424081016
		arg_76_1.duration_ = 6.4

		local var_76_0 = {
			zh = 5.733,
			ja = 6.4
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
				arg_76_0:Play424081017(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			local var_79_0 = 0
			local var_79_1 = 0.45

			if var_79_0 < arg_76_1.time_ and arg_76_1.time_ <= var_79_0 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				local var_79_2 = arg_76_1:FormatText(StoryNameCfg[181].name)

				arg_76_1.leftNameTxt_.text = var_79_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_3 = arg_76_1:GetWordFromCfg(424081016)
				local var_79_4 = arg_76_1:FormatText(var_79_3.content)

				arg_76_1.text_.text = var_79_4

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_5 = 18
				local var_79_6 = utf8.len(var_79_4)
				local var_79_7 = var_79_5 <= 0 and var_79_1 or var_79_1 * (var_79_6 / var_79_5)

				if var_79_7 > 0 and var_79_1 < var_79_7 then
					arg_76_1.talkMaxDuration = var_79_7

					if var_79_7 + var_79_0 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_7 + var_79_0
					end
				end

				arg_76_1.text_.text = var_79_4
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424081", "424081016", "story_v_out_424081.awb") ~= 0 then
					local var_79_8 = manager.audio:GetVoiceLength("story_v_out_424081", "424081016", "story_v_out_424081.awb") / 1000

					if var_79_8 + var_79_0 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_8 + var_79_0
					end

					if var_79_3.prefab_name ~= "" and arg_76_1.actors_[var_79_3.prefab_name] ~= nil then
						local var_79_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_3.prefab_name].transform, "story_v_out_424081", "424081016", "story_v_out_424081.awb")

						arg_76_1:RecordAudio("424081016", var_79_9)
						arg_76_1:RecordAudio("424081016", var_79_9)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_out_424081", "424081016", "story_v_out_424081.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_out_424081", "424081016", "story_v_out_424081.awb")
				end

				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_10 = math.max(var_79_1, arg_76_1.talkMaxDuration)

			if var_79_0 <= arg_76_1.time_ and arg_76_1.time_ < var_79_0 + var_79_10 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_0) / var_79_10

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_0 + var_79_10 and arg_76_1.time_ < var_79_0 + var_79_10 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {}

		arg_76_1:InitPlayNodeList()
	end,
	Play424081017 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 424081017
		arg_80_1.duration_ = 5

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play424081018(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			local var_83_0 = 0
			local var_83_1 = 0.925

			if var_83_0 < arg_80_1.time_ and arg_80_1.time_ <= var_83_0 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				local var_83_2 = arg_80_1:FormatText(StoryNameCfg[7].name)

				arg_80_1.leftNameTxt_.text = var_83_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, true)
				arg_80_1.iconController_:SetSelectedState("hero")

				arg_80_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_80_1.callingController_:SetSelectedState("normal")

				arg_80_1.keyicon_.color = Color.New(1, 1, 1)
				arg_80_1.icon_.color = Color.New(1, 1, 1)

				local var_83_3 = arg_80_1:GetWordFromCfg(424081017)
				local var_83_4 = arg_80_1:FormatText(var_83_3.content)

				arg_80_1.text_.text = var_83_4

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_5 = 37
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
				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_8 = math.max(var_83_1, arg_80_1.talkMaxDuration)

			if var_83_0 <= arg_80_1.time_ and arg_80_1.time_ < var_83_0 + var_83_8 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_0) / var_83_8

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_0 + var_83_8 and arg_80_1.time_ < var_83_0 + var_83_8 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {}

		arg_80_1:InitPlayNodeList()
	end,
	Play424081018 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 424081018
		arg_84_1.duration_ = 6.47

		local var_84_0 = {
			zh = 5.166,
			ja = 6.466
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
				arg_84_0:Play424081019(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			local var_87_0 = 0
			local var_87_1 = 0.725

			if var_87_0 < arg_84_1.time_ and arg_84_1.time_ <= var_87_0 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				local var_87_2 = arg_84_1:FormatText(StoryNameCfg[1404].name)

				arg_84_1.leftNameTxt_.text = var_87_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, true)
				arg_84_1.iconController_:SetSelectedState("hero")

				arg_84_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_littleboya")

				arg_84_1.callingController_:SetSelectedState("normal")

				arg_84_1.keyicon_.color = Color.New(1, 1, 1)
				arg_84_1.icon_.color = Color.New(1, 1, 1)

				local var_87_3 = arg_84_1:GetWordFromCfg(424081018)
				local var_87_4 = arg_84_1:FormatText(var_87_3.content)

				arg_84_1.text_.text = var_87_4

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_5 = 29
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

				if manager.audio:GetVoiceLength("story_v_out_424081", "424081018", "story_v_out_424081.awb") ~= 0 then
					local var_87_8 = manager.audio:GetVoiceLength("story_v_out_424081", "424081018", "story_v_out_424081.awb") / 1000

					if var_87_8 + var_87_0 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_8 + var_87_0
					end

					if var_87_3.prefab_name ~= "" and arg_84_1.actors_[var_87_3.prefab_name] ~= nil then
						local var_87_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_84_1.actors_[var_87_3.prefab_name].transform, "story_v_out_424081", "424081018", "story_v_out_424081.awb")

						arg_84_1:RecordAudio("424081018", var_87_9)
						arg_84_1:RecordAudio("424081018", var_87_9)
					else
						arg_84_1:AudioAction("play", "voice", "story_v_out_424081", "424081018", "story_v_out_424081.awb")
					end

					arg_84_1:RecordHistoryTalkVoice("story_v_out_424081", "424081018", "story_v_out_424081.awb")
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
	Play424081019 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 424081019
		arg_88_1.duration_ = 2.8

		local var_88_0 = {
			zh = 2.166,
			ja = 2.8
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
				arg_88_0:Play424081020(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			local var_91_0 = 0
			local var_91_1 = 0.25

			if var_91_0 < arg_88_1.time_ and arg_88_1.time_ <= var_91_0 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				local var_91_2 = arg_88_1:FormatText(StoryNameCfg[1405].name)

				arg_88_1.leftNameTxt_.text = var_91_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, true)
				arg_88_1.iconController_:SetSelectedState("hero")

				arg_88_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lolia")

				arg_88_1.callingController_:SetSelectedState("normal")

				arg_88_1.keyicon_.color = Color.New(1, 1, 1)
				arg_88_1.icon_.color = Color.New(1, 1, 1)

				local var_91_3 = arg_88_1:GetWordFromCfg(424081019)
				local var_91_4 = arg_88_1:FormatText(var_91_3.content)

				arg_88_1.text_.text = var_91_4

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_5 = 10
				local var_91_6 = utf8.len(var_91_4)
				local var_91_7 = var_91_5 <= 0 and var_91_1 or var_91_1 * (var_91_6 / var_91_5)

				if var_91_7 > 0 and var_91_1 < var_91_7 then
					arg_88_1.talkMaxDuration = var_91_7

					if var_91_7 + var_91_0 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_7 + var_91_0
					end
				end

				arg_88_1.text_.text = var_91_4
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424081", "424081019", "story_v_out_424081.awb") ~= 0 then
					local var_91_8 = manager.audio:GetVoiceLength("story_v_out_424081", "424081019", "story_v_out_424081.awb") / 1000

					if var_91_8 + var_91_0 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_8 + var_91_0
					end

					if var_91_3.prefab_name ~= "" and arg_88_1.actors_[var_91_3.prefab_name] ~= nil then
						local var_91_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_88_1.actors_[var_91_3.prefab_name].transform, "story_v_out_424081", "424081019", "story_v_out_424081.awb")

						arg_88_1:RecordAudio("424081019", var_91_9)
						arg_88_1:RecordAudio("424081019", var_91_9)
					else
						arg_88_1:AudioAction("play", "voice", "story_v_out_424081", "424081019", "story_v_out_424081.awb")
					end

					arg_88_1:RecordHistoryTalkVoice("story_v_out_424081", "424081019", "story_v_out_424081.awb")
				end

				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_10 = math.max(var_91_1, arg_88_1.talkMaxDuration)

			if var_91_0 <= arg_88_1.time_ and arg_88_1.time_ < var_91_0 + var_91_10 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_0) / var_91_10

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_0 + var_91_10 and arg_88_1.time_ < var_91_0 + var_91_10 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {}

		arg_88_1:InitPlayNodeList()
	end,
	Play424081020 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 424081020
		arg_92_1.duration_ = 5

		SetActive(arg_92_1.tipsGo_, false)

		function arg_92_1.onSingleLineFinish_()
			arg_92_1.onSingleLineUpdate_ = nil
			arg_92_1.onSingleLineFinish_ = nil
			arg_92_1.state_ = "waiting"
		end

		function arg_92_1.playNext_(arg_94_0)
			if arg_94_0 == 1 then
				arg_92_0:Play424081021(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			local var_95_0 = 0
			local var_95_1 = 0.875

			if var_95_0 < arg_92_1.time_ and arg_92_1.time_ <= var_95_0 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				local var_95_2 = arg_92_1:FormatText(StoryNameCfg[7].name)

				arg_92_1.leftNameTxt_.text = var_95_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, true)
				arg_92_1.iconController_:SetSelectedState("hero")

				arg_92_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_92_1.callingController_:SetSelectedState("normal")

				arg_92_1.keyicon_.color = Color.New(1, 1, 1)
				arg_92_1.icon_.color = Color.New(1, 1, 1)

				local var_95_3 = arg_92_1:GetWordFromCfg(424081020)
				local var_95_4 = arg_92_1:FormatText(var_95_3.content)

				arg_92_1.text_.text = var_95_4

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_5 = 35
				local var_95_6 = utf8.len(var_95_4)
				local var_95_7 = var_95_5 <= 0 and var_95_1 or var_95_1 * (var_95_6 / var_95_5)

				if var_95_7 > 0 and var_95_1 < var_95_7 then
					arg_92_1.talkMaxDuration = var_95_7

					if var_95_7 + var_95_0 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_7 + var_95_0
					end
				end

				arg_92_1.text_.text = var_95_4
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)
				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_8 = math.max(var_95_1, arg_92_1.talkMaxDuration)

			if var_95_0 <= arg_92_1.time_ and arg_92_1.time_ < var_95_0 + var_95_8 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_0) / var_95_8

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_0 + var_95_8 and arg_92_1.time_ < var_95_0 + var_95_8 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {}

		arg_92_1:InitPlayNodeList()
	end,
	Play424081021 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 424081021
		arg_96_1.duration_ = 11.13

		local var_96_0 = {
			zh = 9.033,
			ja = 11.133
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
				arg_96_0:Play424081022(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			local var_99_0 = "SS2402a"

			if arg_96_1.bgs_[var_99_0] == nil then
				local var_99_1 = Object.Instantiate(arg_96_1.paintGo_)

				var_99_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_99_0)
				var_99_1.name = var_99_0
				var_99_1.transform.parent = arg_96_1.stage_.transform
				var_99_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_96_1.bgs_[var_99_0] = var_99_1
			end

			local var_99_2 = 2

			if var_99_2 < arg_96_1.time_ and arg_96_1.time_ <= var_99_2 + arg_99_0 then
				local var_99_3 = manager.ui.mainCamera.transform.localPosition
				local var_99_4 = Vector3.New(0, 0, 10) + Vector3.New(var_99_3.x, var_99_3.y, 0)
				local var_99_5 = arg_96_1.bgs_.SS2402a

				var_99_5.transform.localPosition = var_99_4
				var_99_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_99_6 = var_99_5:GetComponent("SpriteRenderer")

				if var_99_6 and var_99_6.sprite then
					local var_99_7 = (var_99_5.transform.localPosition - var_99_3).z
					local var_99_8 = manager.ui.mainCameraCom_
					local var_99_9 = 2 * var_99_7 * Mathf.Tan(var_99_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_99_10 = var_99_9 * var_99_8.aspect
					local var_99_11 = var_99_6.sprite.bounds.size.x
					local var_99_12 = var_99_6.sprite.bounds.size.y
					local var_99_13 = var_99_10 / var_99_11
					local var_99_14 = var_99_9 / var_99_12
					local var_99_15 = var_99_14 < var_99_13 and var_99_13 or var_99_14

					var_99_5.transform.localScale = Vector3.New(var_99_15, var_99_15, 0)
				end

				for iter_99_0, iter_99_1 in pairs(arg_96_1.bgs_) do
					if iter_99_0 ~= "SS2402a" then
						iter_99_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_99_16 = 4

			if var_99_16 < arg_96_1.time_ and arg_96_1.time_ <= var_99_16 + arg_99_0 then
				arg_96_1.allBtn_.enabled = false
			end

			local var_99_17 = 0.3

			if arg_96_1.time_ >= var_99_16 + var_99_17 and arg_96_1.time_ < var_99_16 + var_99_17 + arg_99_0 then
				arg_96_1.allBtn_.enabled = true
			end

			local var_99_18 = 0

			if var_99_18 < arg_96_1.time_ and arg_96_1.time_ <= var_99_18 + arg_99_0 then
				arg_96_1.mask_.enabled = true
				arg_96_1.mask_.raycastTarget = true

				arg_96_1:SetGaussion(false)
			end

			local var_99_19 = 2

			if var_99_18 <= arg_96_1.time_ and arg_96_1.time_ < var_99_18 + var_99_19 then
				local var_99_20 = (arg_96_1.time_ - var_99_18) / var_99_19
				local var_99_21 = Color.New(0, 0, 0)

				var_99_21.a = Mathf.Lerp(0, 1, var_99_20)
				arg_96_1.mask_.color = var_99_21
			end

			if arg_96_1.time_ >= var_99_18 + var_99_19 and arg_96_1.time_ < var_99_18 + var_99_19 + arg_99_0 then
				local var_99_22 = Color.New(0, 0, 0)

				var_99_22.a = 1
				arg_96_1.mask_.color = var_99_22
			end

			local var_99_23 = 2

			if var_99_23 < arg_96_1.time_ and arg_96_1.time_ <= var_99_23 + arg_99_0 then
				arg_96_1.mask_.enabled = true
				arg_96_1.mask_.raycastTarget = true

				arg_96_1:SetGaussion(false)
			end

			local var_99_24 = 2

			if var_99_23 <= arg_96_1.time_ and arg_96_1.time_ < var_99_23 + var_99_24 then
				local var_99_25 = (arg_96_1.time_ - var_99_23) / var_99_24
				local var_99_26 = Color.New(0, 0, 0)

				var_99_26.a = Mathf.Lerp(1, 0, var_99_25)
				arg_96_1.mask_.color = var_99_26
			end

			if arg_96_1.time_ >= var_99_23 + var_99_24 and arg_96_1.time_ < var_99_23 + var_99_24 + arg_99_0 then
				local var_99_27 = Color.New(0, 0, 0)
				local var_99_28 = 0

				arg_96_1.mask_.enabled = false
				var_99_27.a = var_99_28
				arg_96_1.mask_.color = var_99_27
			end

			local var_99_29 = arg_96_1.bgs_.SS2402a.transform
			local var_99_30 = 2

			if var_99_30 < arg_96_1.time_ and arg_96_1.time_ <= var_99_30 + arg_99_0 then
				arg_96_1.var_.moveOldPosSS2402a = var_99_29.localPosition
			end

			local var_99_31 = 3

			if var_99_30 <= arg_96_1.time_ and arg_96_1.time_ < var_99_30 + var_99_31 then
				local var_99_32 = (arg_96_1.time_ - var_99_30) / var_99_31
				local var_99_33 = Vector3.New(0, 1, 10)

				var_99_29.localPosition = Vector3.Lerp(arg_96_1.var_.moveOldPosSS2402a, var_99_33, var_99_32)
			end

			if arg_96_1.time_ >= var_99_30 + var_99_31 and arg_96_1.time_ < var_99_30 + var_99_31 + arg_99_0 then
				var_99_29.localPosition = Vector3.New(0, 1, 10)
			end

			local var_99_34 = 4

			if var_99_34 < arg_96_1.time_ and arg_96_1.time_ <= var_99_34 + arg_99_0 then
				arg_96_1.allBtn_.enabled = false
			end

			local var_99_35 = 1

			if arg_96_1.time_ >= var_99_34 + var_99_35 and arg_96_1.time_ < var_99_34 + var_99_35 + arg_99_0 then
				arg_96_1.allBtn_.enabled = true
			end

			if arg_96_1.frameCnt_ <= 1 then
				arg_96_1.dialog_:SetActive(false)
			end

			local var_99_36 = 4
			local var_99_37 = 0.575

			if var_99_36 < arg_96_1.time_ and arg_96_1.time_ <= var_99_36 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0

				arg_96_1.dialog_:SetActive(true)

				arg_96_1.dialogCg_.alpha = 0

				local var_99_38 = LeanTween.value(arg_96_1.dialog_, 0, 1, 0.3)

				var_99_38:setOnUpdate(LuaHelper.FloatAction(function(arg_100_0)
					arg_96_1.dialogCg_.alpha = arg_100_0
				end))
				var_99_38:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_96_1.dialog_)
					var_99_38:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_96_1.duration_ = arg_96_1.duration_ + 0.3

				SetActive(arg_96_1.leftNameGo_, true)

				local var_99_39 = arg_96_1:FormatText(StoryNameCfg[181].name)

				arg_96_1.leftNameTxt_.text = var_99_39

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_40 = arg_96_1:GetWordFromCfg(424081021)
				local var_99_41 = arg_96_1:FormatText(var_99_40.content)

				arg_96_1.text_.text = var_99_41

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_42 = 23
				local var_99_43 = utf8.len(var_99_41)
				local var_99_44 = var_99_42 <= 0 and var_99_37 or var_99_37 * (var_99_43 / var_99_42)

				if var_99_44 > 0 and var_99_37 < var_99_44 then
					arg_96_1.talkMaxDuration = var_99_44
					var_99_36 = var_99_36 + 0.3

					if var_99_44 + var_99_36 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_44 + var_99_36
					end
				end

				arg_96_1.text_.text = var_99_41
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424081", "424081021", "story_v_out_424081.awb") ~= 0 then
					local var_99_45 = manager.audio:GetVoiceLength("story_v_out_424081", "424081021", "story_v_out_424081.awb") / 1000

					if var_99_45 + var_99_36 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_45 + var_99_36
					end

					if var_99_40.prefab_name ~= "" and arg_96_1.actors_[var_99_40.prefab_name] ~= nil then
						local var_99_46 = LuaForUtil.PlayVoiceWithCriLipsync(arg_96_1.actors_[var_99_40.prefab_name].transform, "story_v_out_424081", "424081021", "story_v_out_424081.awb")

						arg_96_1:RecordAudio("424081021", var_99_46)
						arg_96_1:RecordAudio("424081021", var_99_46)
					else
						arg_96_1:AudioAction("play", "voice", "story_v_out_424081", "424081021", "story_v_out_424081.awb")
					end

					arg_96_1:RecordHistoryTalkVoice("story_v_out_424081", "424081021", "story_v_out_424081.awb")
				end

				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_47 = var_99_36 + 0.3
			local var_99_48 = math.max(var_99_37, arg_96_1.talkMaxDuration)

			if var_99_47 <= arg_96_1.time_ and arg_96_1.time_ < var_99_47 + var_99_48 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_47) / var_99_48

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_47 + var_99_48 and arg_96_1.time_ < var_99_47 + var_99_48 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "SS2402a",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 3,
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 9.5),
					endPos = Vector3.New(0, 1, 10),
					easeType = LeanTweenType.easeInOutSine
				}
			}
		}

		arg_96_1:InitPlayNodeList()
	end,
	Play424081022 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 424081022
		arg_102_1.duration_ = 2.77

		local var_102_0 = {
			zh = 2.133,
			ja = 2.766
		}
		local var_102_1 = manager.audio:GetLocalizationFlag()

		if var_102_0[var_102_1] ~= nil then
			arg_102_1.duration_ = var_102_0[var_102_1]
		end

		SetActive(arg_102_1.tipsGo_, false)

		function arg_102_1.onSingleLineFinish_()
			arg_102_1.onSingleLineUpdate_ = nil
			arg_102_1.onSingleLineFinish_ = nil
			arg_102_1.state_ = "waiting"
		end

		function arg_102_1.playNext_(arg_104_0)
			if arg_104_0 == 1 then
				arg_102_0:Play424081023(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			local var_105_0 = 0
			local var_105_1 = 0.25

			if var_105_0 < arg_102_1.time_ and arg_102_1.time_ <= var_105_0 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, true)

				local var_105_2 = arg_102_1:FormatText(StoryNameCfg[1404].name)

				arg_102_1.leftNameTxt_.text = var_105_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_102_1.leftNameTxt_.transform)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1.leftNameTxt_.text)
				SetActive(arg_102_1.iconTrs_.gameObject, true)
				arg_102_1.iconController_:SetSelectedState("hero")

				arg_102_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_littleboya")

				arg_102_1.callingController_:SetSelectedState("normal")

				arg_102_1.keyicon_.color = Color.New(1, 1, 1)
				arg_102_1.icon_.color = Color.New(1, 1, 1)

				local var_105_3 = arg_102_1:GetWordFromCfg(424081022)
				local var_105_4 = arg_102_1:FormatText(var_105_3.content)

				arg_102_1.text_.text = var_105_4

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_5 = 10
				local var_105_6 = utf8.len(var_105_4)
				local var_105_7 = var_105_5 <= 0 and var_105_1 or var_105_1 * (var_105_6 / var_105_5)

				if var_105_7 > 0 and var_105_1 < var_105_7 then
					arg_102_1.talkMaxDuration = var_105_7

					if var_105_7 + var_105_0 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_7 + var_105_0
					end
				end

				arg_102_1.text_.text = var_105_4
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424081", "424081022", "story_v_out_424081.awb") ~= 0 then
					local var_105_8 = manager.audio:GetVoiceLength("story_v_out_424081", "424081022", "story_v_out_424081.awb") / 1000

					if var_105_8 + var_105_0 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_8 + var_105_0
					end

					if var_105_3.prefab_name ~= "" and arg_102_1.actors_[var_105_3.prefab_name] ~= nil then
						local var_105_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_102_1.actors_[var_105_3.prefab_name].transform, "story_v_out_424081", "424081022", "story_v_out_424081.awb")

						arg_102_1:RecordAudio("424081022", var_105_9)
						arg_102_1:RecordAudio("424081022", var_105_9)
					else
						arg_102_1:AudioAction("play", "voice", "story_v_out_424081", "424081022", "story_v_out_424081.awb")
					end

					arg_102_1:RecordHistoryTalkVoice("story_v_out_424081", "424081022", "story_v_out_424081.awb")
				end

				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_10 = math.max(var_105_1, arg_102_1.talkMaxDuration)

			if var_105_0 <= arg_102_1.time_ and arg_102_1.time_ < var_105_0 + var_105_10 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - var_105_0) / var_105_10

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= var_105_0 + var_105_10 and arg_102_1.time_ < var_105_0 + var_105_10 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {}

		arg_102_1:InitPlayNodeList()
	end,
	Play424081023 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 424081023
		arg_106_1.duration_ = 2.8

		local var_106_0 = {
			zh = 2.8,
			ja = 2.533
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
				arg_106_0:Play424081024(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			local var_109_0 = 0
			local var_109_1 = 0.275

			if var_109_0 < arg_106_1.time_ and arg_106_1.time_ <= var_109_0 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, true)

				local var_109_2 = arg_106_1:FormatText(StoryNameCfg[1394].name)

				arg_106_1.leftNameTxt_.text = var_109_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_106_1.leftNameTxt_.transform)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1.leftNameTxt_.text)
				SetActive(arg_106_1.iconTrs_.gameObject, true)
				arg_106_1.iconController_:SetSelectedState("hero")

				arg_106_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lolib")

				arg_106_1.callingController_:SetSelectedState("normal")

				arg_106_1.keyicon_.color = Color.New(1, 1, 1)
				arg_106_1.icon_.color = Color.New(1, 1, 1)

				local var_109_3 = arg_106_1:GetWordFromCfg(424081023)
				local var_109_4 = arg_106_1:FormatText(var_109_3.content)

				arg_106_1.text_.text = var_109_4

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_5 = 11
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

				if manager.audio:GetVoiceLength("story_v_out_424081", "424081023", "story_v_out_424081.awb") ~= 0 then
					local var_109_8 = manager.audio:GetVoiceLength("story_v_out_424081", "424081023", "story_v_out_424081.awb") / 1000

					if var_109_8 + var_109_0 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_8 + var_109_0
					end

					if var_109_3.prefab_name ~= "" and arg_106_1.actors_[var_109_3.prefab_name] ~= nil then
						local var_109_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_106_1.actors_[var_109_3.prefab_name].transform, "story_v_out_424081", "424081023", "story_v_out_424081.awb")

						arg_106_1:RecordAudio("424081023", var_109_9)
						arg_106_1:RecordAudio("424081023", var_109_9)
					else
						arg_106_1:AudioAction("play", "voice", "story_v_out_424081", "424081023", "story_v_out_424081.awb")
					end

					arg_106_1:RecordHistoryTalkVoice("story_v_out_424081", "424081023", "story_v_out_424081.awb")
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
	Play424081024 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 424081024
		arg_110_1.duration_ = 5

		SetActive(arg_110_1.tipsGo_, false)

		function arg_110_1.onSingleLineFinish_()
			arg_110_1.onSingleLineUpdate_ = nil
			arg_110_1.onSingleLineFinish_ = nil
			arg_110_1.state_ = "waiting"
		end

		function arg_110_1.playNext_(arg_112_0)
			if arg_112_0 == 1 then
				arg_110_0:Play424081025(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			local var_113_0 = 0
			local var_113_1 = 0.125

			if var_113_0 < arg_110_1.time_ and arg_110_1.time_ <= var_113_0 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, true)

				local var_113_2 = arg_110_1:FormatText(StoryNameCfg[7].name)

				arg_110_1.leftNameTxt_.text = var_113_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_110_1.leftNameTxt_.transform)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1.leftNameTxt_.text)
				SetActive(arg_110_1.iconTrs_.gameObject, true)
				arg_110_1.iconController_:SetSelectedState("hero")

				arg_110_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_110_1.callingController_:SetSelectedState("normal")

				arg_110_1.keyicon_.color = Color.New(1, 1, 1)
				arg_110_1.icon_.color = Color.New(1, 1, 1)

				local var_113_3 = arg_110_1:GetWordFromCfg(424081024)
				local var_113_4 = arg_110_1:FormatText(var_113_3.content)

				arg_110_1.text_.text = var_113_4

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_5 = 5
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
				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_8 = math.max(var_113_1, arg_110_1.talkMaxDuration)

			if var_113_0 <= arg_110_1.time_ and arg_110_1.time_ < var_113_0 + var_113_8 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - var_113_0) / var_113_8

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= var_113_0 + var_113_8 and arg_110_1.time_ < var_113_0 + var_113_8 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {}

		arg_110_1:InitPlayNodeList()
	end,
	Play424081025 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 424081025
		arg_114_1.duration_ = 7.07

		local var_114_0 = {
			zh = 5.866,
			ja = 7.066
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
				arg_114_0:Play424081026(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			local var_117_0 = 0
			local var_117_1 = 0.55

			if var_117_0 < arg_114_1.time_ and arg_114_1.time_ <= var_117_0 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, true)

				local var_117_2 = arg_114_1:FormatText(StoryNameCfg[181].name)

				arg_114_1.leftNameTxt_.text = var_117_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_114_1.leftNameTxt_.transform)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1.leftNameTxt_.text)
				SetActive(arg_114_1.iconTrs_.gameObject, false)
				arg_114_1.callingController_:SetSelectedState("normal")

				local var_117_3 = arg_114_1:GetWordFromCfg(424081025)
				local var_117_4 = arg_114_1:FormatText(var_117_3.content)

				arg_114_1.text_.text = var_117_4

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_5 = 22
				local var_117_6 = utf8.len(var_117_4)
				local var_117_7 = var_117_5 <= 0 and var_117_1 or var_117_1 * (var_117_6 / var_117_5)

				if var_117_7 > 0 and var_117_1 < var_117_7 then
					arg_114_1.talkMaxDuration = var_117_7

					if var_117_7 + var_117_0 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_7 + var_117_0
					end
				end

				arg_114_1.text_.text = var_117_4
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424081", "424081025", "story_v_out_424081.awb") ~= 0 then
					local var_117_8 = manager.audio:GetVoiceLength("story_v_out_424081", "424081025", "story_v_out_424081.awb") / 1000

					if var_117_8 + var_117_0 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_8 + var_117_0
					end

					if var_117_3.prefab_name ~= "" and arg_114_1.actors_[var_117_3.prefab_name] ~= nil then
						local var_117_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_114_1.actors_[var_117_3.prefab_name].transform, "story_v_out_424081", "424081025", "story_v_out_424081.awb")

						arg_114_1:RecordAudio("424081025", var_117_9)
						arg_114_1:RecordAudio("424081025", var_117_9)
					else
						arg_114_1:AudioAction("play", "voice", "story_v_out_424081", "424081025", "story_v_out_424081.awb")
					end

					arg_114_1:RecordHistoryTalkVoice("story_v_out_424081", "424081025", "story_v_out_424081.awb")
				end

				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_10 = math.max(var_117_1, arg_114_1.talkMaxDuration)

			if var_117_0 <= arg_114_1.time_ and arg_114_1.time_ < var_117_0 + var_117_10 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - var_117_0) / var_117_10

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= var_117_0 + var_117_10 and arg_114_1.time_ < var_117_0 + var_117_10 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {}

		arg_114_1:InitPlayNodeList()
	end,
	Play424081026 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 424081026
		arg_118_1.duration_ = 5

		SetActive(arg_118_1.tipsGo_, false)

		function arg_118_1.onSingleLineFinish_()
			arg_118_1.onSingleLineUpdate_ = nil
			arg_118_1.onSingleLineFinish_ = nil
			arg_118_1.state_ = "waiting"
		end

		function arg_118_1.playNext_(arg_120_0)
			if arg_120_0 == 1 then
				arg_118_0:Play424081027(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			local var_121_0 = 0
			local var_121_1 = 0.075

			if var_121_0 < arg_118_1.time_ and arg_118_1.time_ <= var_121_0 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0
				arg_118_1.dialogCg_.alpha = 1

				arg_118_1.dialog_:SetActive(true)
				SetActive(arg_118_1.leftNameGo_, true)

				local var_121_2 = arg_118_1:FormatText(StoryNameCfg[7].name)

				arg_118_1.leftNameTxt_.text = var_121_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_118_1.leftNameTxt_.transform)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1.leftNameTxt_.text)
				SetActive(arg_118_1.iconTrs_.gameObject, true)
				arg_118_1.iconController_:SetSelectedState("hero")

				arg_118_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_118_1.callingController_:SetSelectedState("normal")

				arg_118_1.keyicon_.color = Color.New(1, 1, 1)
				arg_118_1.icon_.color = Color.New(1, 1, 1)

				local var_121_3 = arg_118_1:GetWordFromCfg(424081026)
				local var_121_4 = arg_118_1:FormatText(var_121_3.content)

				arg_118_1.text_.text = var_121_4

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_5 = 3
				local var_121_6 = utf8.len(var_121_4)
				local var_121_7 = var_121_5 <= 0 and var_121_1 or var_121_1 * (var_121_6 / var_121_5)

				if var_121_7 > 0 and var_121_1 < var_121_7 then
					arg_118_1.talkMaxDuration = var_121_7

					if var_121_7 + var_121_0 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_7 + var_121_0
					end
				end

				arg_118_1.text_.text = var_121_4
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)
				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_8 = math.max(var_121_1, arg_118_1.talkMaxDuration)

			if var_121_0 <= arg_118_1.time_ and arg_118_1.time_ < var_121_0 + var_121_8 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - var_121_0) / var_121_8

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= var_121_0 + var_121_8 and arg_118_1.time_ < var_121_0 + var_121_8 + arg_121_0 then
				arg_118_1.typewritter.percent = 1

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(true)
			end
		end

		arg_118_1.nodeConfigList_ = {}

		arg_118_1:InitPlayNodeList()
	end,
	Play424081027 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 424081027
		arg_122_1.duration_ = 5.07

		local var_122_0 = {
			zh = 3.133,
			ja = 5.066
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
				arg_122_0:Play424081028(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			local var_125_0 = 0
			local var_125_1 = 0.35

			if var_125_0 < arg_122_1.time_ and arg_122_1.time_ <= var_125_0 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, true)

				local var_125_2 = arg_122_1:FormatText(StoryNameCfg[1404].name)

				arg_122_1.leftNameTxt_.text = var_125_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_122_1.leftNameTxt_.transform)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1.leftNameTxt_.text)
				SetActive(arg_122_1.iconTrs_.gameObject, true)
				arg_122_1.iconController_:SetSelectedState("hero")

				arg_122_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_littleboya")

				arg_122_1.callingController_:SetSelectedState("normal")

				arg_122_1.keyicon_.color = Color.New(1, 1, 1)
				arg_122_1.icon_.color = Color.New(1, 1, 1)

				local var_125_3 = arg_122_1:GetWordFromCfg(424081027)
				local var_125_4 = arg_122_1:FormatText(var_125_3.content)

				arg_122_1.text_.text = var_125_4

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_5 = 14
				local var_125_6 = utf8.len(var_125_4)
				local var_125_7 = var_125_5 <= 0 and var_125_1 or var_125_1 * (var_125_6 / var_125_5)

				if var_125_7 > 0 and var_125_1 < var_125_7 then
					arg_122_1.talkMaxDuration = var_125_7

					if var_125_7 + var_125_0 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_7 + var_125_0
					end
				end

				arg_122_1.text_.text = var_125_4
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424081", "424081027", "story_v_out_424081.awb") ~= 0 then
					local var_125_8 = manager.audio:GetVoiceLength("story_v_out_424081", "424081027", "story_v_out_424081.awb") / 1000

					if var_125_8 + var_125_0 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_8 + var_125_0
					end

					if var_125_3.prefab_name ~= "" and arg_122_1.actors_[var_125_3.prefab_name] ~= nil then
						local var_125_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_122_1.actors_[var_125_3.prefab_name].transform, "story_v_out_424081", "424081027", "story_v_out_424081.awb")

						arg_122_1:RecordAudio("424081027", var_125_9)
						arg_122_1:RecordAudio("424081027", var_125_9)
					else
						arg_122_1:AudioAction("play", "voice", "story_v_out_424081", "424081027", "story_v_out_424081.awb")
					end

					arg_122_1:RecordHistoryTalkVoice("story_v_out_424081", "424081027", "story_v_out_424081.awb")
				end

				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_10 = math.max(var_125_1, arg_122_1.talkMaxDuration)

			if var_125_0 <= arg_122_1.time_ and arg_122_1.time_ < var_125_0 + var_125_10 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - var_125_0) / var_125_10

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= var_125_0 + var_125_10 and arg_122_1.time_ < var_125_0 + var_125_10 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {}

		arg_122_1:InitPlayNodeList()
	end,
	Play424081028 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 424081028
		arg_126_1.duration_ = 1

		SetActive(arg_126_1.tipsGo_, false)

		function arg_126_1.onSingleLineFinish_()
			arg_126_1.onSingleLineUpdate_ = nil
			arg_126_1.onSingleLineFinish_ = nil
			arg_126_1.state_ = "waiting"

			SetActive(arg_126_1.choicesGo_, true)

			for iter_127_0, iter_127_1 in ipairs(arg_126_1.choices_) do
				local var_127_0 = iter_127_0 <= 2

				SetActive(iter_127_1.go, var_127_0)
			end

			arg_126_1.choices_[1].txt.text = arg_126_1:FormatText(StoryChoiceCfg[1485].name)
			arg_126_1.choices_[2].txt.text = arg_126_1:FormatText(StoryChoiceCfg[1486].name)
		end

		function arg_126_1.playNext_(arg_128_0)
			if arg_128_0 == 1 then
				arg_126_0:Play424081029(arg_126_1)
			end

			if arg_128_0 == 2 then
				arg_126_0:Play424081032(arg_126_1)
			end

			arg_126_1:RecordChoiceLog(424081028, 1485, 1486)
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			local var_129_0 = 0

			if var_129_0 < arg_126_1.time_ and arg_126_1.time_ <= var_129_0 + arg_129_0 then
				arg_126_1.allBtn_.enabled = false
			end

			local var_129_1 = 0.6

			if arg_126_1.time_ >= var_129_0 + var_129_1 and arg_126_1.time_ < var_129_0 + var_129_1 + arg_129_0 then
				arg_126_1.allBtn_.enabled = true
			end
		end

		arg_126_1.nodeConfigList_ = {}

		arg_126_1:InitPlayNodeList()
	end,
	Play424081029 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 424081029
		arg_130_1.duration_ = 5

		SetActive(arg_130_1.tipsGo_, false)

		function arg_130_1.onSingleLineFinish_()
			arg_130_1.onSingleLineUpdate_ = nil
			arg_130_1.onSingleLineFinish_ = nil
			arg_130_1.state_ = "waiting"
		end

		function arg_130_1.playNext_(arg_132_0)
			if arg_132_0 == 1 then
				arg_130_0:Play424081030(arg_130_1)
			end
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			local var_133_0 = 0
			local var_133_1 = 0.725

			if var_133_0 < arg_130_1.time_ and arg_130_1.time_ <= var_133_0 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0
				arg_130_1.dialogCg_.alpha = 1

				arg_130_1.dialog_:SetActive(true)
				SetActive(arg_130_1.leftNameGo_, true)

				local var_133_2 = arg_130_1:FormatText(StoryNameCfg[7].name)

				arg_130_1.leftNameTxt_.text = var_133_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_130_1.leftNameTxt_.transform)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1.leftNameTxt_.text)
				SetActive(arg_130_1.iconTrs_.gameObject, true)
				arg_130_1.iconController_:SetSelectedState("hero")

				arg_130_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_130_1.callingController_:SetSelectedState("normal")

				arg_130_1.keyicon_.color = Color.New(1, 1, 1)
				arg_130_1.icon_.color = Color.New(1, 1, 1)

				local var_133_3 = arg_130_1:GetWordFromCfg(424081029)
				local var_133_4 = arg_130_1:FormatText(var_133_3.content)

				arg_130_1.text_.text = var_133_4

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_5 = 29
				local var_133_6 = utf8.len(var_133_4)
				local var_133_7 = var_133_5 <= 0 and var_133_1 or var_133_1 * (var_133_6 / var_133_5)

				if var_133_7 > 0 and var_133_1 < var_133_7 then
					arg_130_1.talkMaxDuration = var_133_7

					if var_133_7 + var_133_0 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_7 + var_133_0
					end
				end

				arg_130_1.text_.text = var_133_4
				arg_130_1.typewritter.percent = 0

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(false)
				arg_130_1:RecordContent(arg_130_1.text_.text)
			end

			local var_133_8 = math.max(var_133_1, arg_130_1.talkMaxDuration)

			if var_133_0 <= arg_130_1.time_ and arg_130_1.time_ < var_133_0 + var_133_8 then
				arg_130_1.typewritter.percent = (arg_130_1.time_ - var_133_0) / var_133_8

				arg_130_1.typewritter:SetDirty()
			end

			if arg_130_1.time_ >= var_133_0 + var_133_8 and arg_130_1.time_ < var_133_0 + var_133_8 + arg_133_0 then
				arg_130_1.typewritter.percent = 1

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(true)
			end
		end

		arg_130_1.nodeConfigList_ = {}

		arg_130_1:InitPlayNodeList()
	end,
	Play424081030 = function(arg_134_0, arg_134_1)
		arg_134_1.time_ = 0
		arg_134_1.frameCnt_ = 0
		arg_134_1.state_ = "playing"
		arg_134_1.curTalkId_ = 424081030
		arg_134_1.duration_ = 4.8

		local var_134_0 = {
			zh = 3.4,
			ja = 4.8
		}
		local var_134_1 = manager.audio:GetLocalizationFlag()

		if var_134_0[var_134_1] ~= nil then
			arg_134_1.duration_ = var_134_0[var_134_1]
		end

		SetActive(arg_134_1.tipsGo_, false)

		function arg_134_1.onSingleLineFinish_()
			arg_134_1.onSingleLineUpdate_ = nil
			arg_134_1.onSingleLineFinish_ = nil
			arg_134_1.state_ = "waiting"
		end

		function arg_134_1.playNext_(arg_136_0)
			if arg_136_0 == 1 then
				arg_134_0:Play424081031(arg_134_1)
			end
		end

		function arg_134_1.onSingleLineUpdate_(arg_137_0)
			local var_137_0 = 0
			local var_137_1 = 0.4

			if var_137_0 < arg_134_1.time_ and arg_134_1.time_ <= var_137_0 + arg_137_0 then
				arg_134_1.talkMaxDuration = 0
				arg_134_1.dialogCg_.alpha = 1

				arg_134_1.dialog_:SetActive(true)
				SetActive(arg_134_1.leftNameGo_, true)

				local var_137_2 = arg_134_1:FormatText(StoryNameCfg[1404].name)

				arg_134_1.leftNameTxt_.text = var_137_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_134_1.leftNameTxt_.transform)

				arg_134_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_134_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_134_1:RecordName(arg_134_1.leftNameTxt_.text)
				SetActive(arg_134_1.iconTrs_.gameObject, true)
				arg_134_1.iconController_:SetSelectedState("hero")

				arg_134_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_littleboya")

				arg_134_1.callingController_:SetSelectedState("normal")

				arg_134_1.keyicon_.color = Color.New(1, 1, 1)
				arg_134_1.icon_.color = Color.New(1, 1, 1)

				local var_137_3 = arg_134_1:GetWordFromCfg(424081030)
				local var_137_4 = arg_134_1:FormatText(var_137_3.content)

				arg_134_1.text_.text = var_137_4

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.text_)

				local var_137_5 = 16
				local var_137_6 = utf8.len(var_137_4)
				local var_137_7 = var_137_5 <= 0 and var_137_1 or var_137_1 * (var_137_6 / var_137_5)

				if var_137_7 > 0 and var_137_1 < var_137_7 then
					arg_134_1.talkMaxDuration = var_137_7

					if var_137_7 + var_137_0 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_7 + var_137_0
					end
				end

				arg_134_1.text_.text = var_137_4
				arg_134_1.typewritter.percent = 0

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424081", "424081030", "story_v_out_424081.awb") ~= 0 then
					local var_137_8 = manager.audio:GetVoiceLength("story_v_out_424081", "424081030", "story_v_out_424081.awb") / 1000

					if var_137_8 + var_137_0 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_8 + var_137_0
					end

					if var_137_3.prefab_name ~= "" and arg_134_1.actors_[var_137_3.prefab_name] ~= nil then
						local var_137_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_134_1.actors_[var_137_3.prefab_name].transform, "story_v_out_424081", "424081030", "story_v_out_424081.awb")

						arg_134_1:RecordAudio("424081030", var_137_9)
						arg_134_1:RecordAudio("424081030", var_137_9)
					else
						arg_134_1:AudioAction("play", "voice", "story_v_out_424081", "424081030", "story_v_out_424081.awb")
					end

					arg_134_1:RecordHistoryTalkVoice("story_v_out_424081", "424081030", "story_v_out_424081.awb")
				end

				arg_134_1:RecordContent(arg_134_1.text_.text)
			end

			local var_137_10 = math.max(var_137_1, arg_134_1.talkMaxDuration)

			if var_137_0 <= arg_134_1.time_ and arg_134_1.time_ < var_137_0 + var_137_10 then
				arg_134_1.typewritter.percent = (arg_134_1.time_ - var_137_0) / var_137_10

				arg_134_1.typewritter:SetDirty()
			end

			if arg_134_1.time_ >= var_137_0 + var_137_10 and arg_134_1.time_ < var_137_0 + var_137_10 + arg_137_0 then
				arg_134_1.typewritter.percent = 1

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(true)
			end
		end

		arg_134_1.nodeConfigList_ = {}

		arg_134_1:InitPlayNodeList()
	end,
	Play424081031 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 424081031
		arg_138_1.duration_ = 5

		SetActive(arg_138_1.tipsGo_, false)

		function arg_138_1.onSingleLineFinish_()
			arg_138_1.onSingleLineUpdate_ = nil
			arg_138_1.onSingleLineFinish_ = nil
			arg_138_1.state_ = "waiting"
		end

		function arg_138_1.playNext_(arg_140_0)
			if arg_140_0 == 1 then
				arg_138_0:Play424081034(arg_138_1)
			end
		end

		function arg_138_1.onSingleLineUpdate_(arg_141_0)
			local var_141_0 = 0
			local var_141_1 = 0.075

			if var_141_0 < arg_138_1.time_ and arg_138_1.time_ <= var_141_0 + arg_141_0 then
				arg_138_1.talkMaxDuration = 0
				arg_138_1.dialogCg_.alpha = 1

				arg_138_1.dialog_:SetActive(true)
				SetActive(arg_138_1.leftNameGo_, true)

				local var_141_2 = arg_138_1:FormatText(StoryNameCfg[7].name)

				arg_138_1.leftNameTxt_.text = var_141_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_138_1.leftNameTxt_.transform)

				arg_138_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_138_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_138_1:RecordName(arg_138_1.leftNameTxt_.text)
				SetActive(arg_138_1.iconTrs_.gameObject, true)
				arg_138_1.iconController_:SetSelectedState("hero")

				arg_138_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_138_1.callingController_:SetSelectedState("normal")

				arg_138_1.keyicon_.color = Color.New(1, 1, 1)
				arg_138_1.icon_.color = Color.New(1, 1, 1)

				local var_141_3 = arg_138_1:GetWordFromCfg(424081031)
				local var_141_4 = arg_138_1:FormatText(var_141_3.content)

				arg_138_1.text_.text = var_141_4

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.text_)

				local var_141_5 = 3
				local var_141_6 = utf8.len(var_141_4)
				local var_141_7 = var_141_5 <= 0 and var_141_1 or var_141_1 * (var_141_6 / var_141_5)

				if var_141_7 > 0 and var_141_1 < var_141_7 then
					arg_138_1.talkMaxDuration = var_141_7

					if var_141_7 + var_141_0 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_7 + var_141_0
					end
				end

				arg_138_1.text_.text = var_141_4
				arg_138_1.typewritter.percent = 0

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(false)
				arg_138_1:RecordContent(arg_138_1.text_.text)
			end

			local var_141_8 = math.max(var_141_1, arg_138_1.talkMaxDuration)

			if var_141_0 <= arg_138_1.time_ and arg_138_1.time_ < var_141_0 + var_141_8 then
				arg_138_1.typewritter.percent = (arg_138_1.time_ - var_141_0) / var_141_8

				arg_138_1.typewritter:SetDirty()
			end

			if arg_138_1.time_ >= var_141_0 + var_141_8 and arg_138_1.time_ < var_141_0 + var_141_8 + arg_141_0 then
				arg_138_1.typewritter.percent = 1

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(true)
			end
		end

		arg_138_1.nodeConfigList_ = {}

		arg_138_1:InitPlayNodeList()
	end,
	Play424081034 = function(arg_142_0, arg_142_1)
		arg_142_1.time_ = 0
		arg_142_1.frameCnt_ = 0
		arg_142_1.state_ = "playing"
		arg_142_1.curTalkId_ = 424081034
		arg_142_1.duration_ = 7.73

		SetActive(arg_142_1.tipsGo_, false)

		function arg_142_1.onSingleLineFinish_()
			arg_142_1.onSingleLineUpdate_ = nil
			arg_142_1.onSingleLineFinish_ = nil
			arg_142_1.state_ = "waiting"
		end

		function arg_142_1.playNext_(arg_144_0)
			if arg_144_0 == 1 then
				arg_142_0:Play424081035(arg_142_1)
			end
		end

		function arg_142_1.onSingleLineUpdate_(arg_145_0)
			local var_145_0 = 2

			if var_145_0 < arg_142_1.time_ and arg_142_1.time_ <= var_145_0 + arg_145_0 then
				local var_145_1 = manager.ui.mainCamera.transform.localPosition
				local var_145_2 = Vector3.New(0, 0, 10) + Vector3.New(var_145_1.x, var_145_1.y, 0)
				local var_145_3 = arg_142_1.bgs_.STblack

				var_145_3.transform.localPosition = var_145_2
				var_145_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_145_4 = var_145_3:GetComponent("SpriteRenderer")

				if var_145_4 and var_145_4.sprite then
					local var_145_5 = (var_145_3.transform.localPosition - var_145_1).z
					local var_145_6 = manager.ui.mainCameraCom_
					local var_145_7 = 2 * var_145_5 * Mathf.Tan(var_145_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_145_8 = var_145_7 * var_145_6.aspect
					local var_145_9 = var_145_4.sprite.bounds.size.x
					local var_145_10 = var_145_4.sprite.bounds.size.y
					local var_145_11 = var_145_8 / var_145_9
					local var_145_12 = var_145_7 / var_145_10
					local var_145_13 = var_145_12 < var_145_11 and var_145_11 or var_145_12

					var_145_3.transform.localScale = Vector3.New(var_145_13, var_145_13, 0)
				end

				for iter_145_0, iter_145_1 in pairs(arg_142_1.bgs_) do
					if iter_145_0 ~= "STblack" then
						iter_145_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_145_14 = 4

			if var_145_14 < arg_142_1.time_ and arg_142_1.time_ <= var_145_14 + arg_145_0 then
				arg_142_1.allBtn_.enabled = false
			end

			local var_145_15 = 0.3

			if arg_142_1.time_ >= var_145_14 + var_145_15 and arg_142_1.time_ < var_145_14 + var_145_15 + arg_145_0 then
				arg_142_1.allBtn_.enabled = true
			end

			local var_145_16 = 0

			if var_145_16 < arg_142_1.time_ and arg_142_1.time_ <= var_145_16 + arg_145_0 then
				arg_142_1.mask_.enabled = true
				arg_142_1.mask_.raycastTarget = true

				arg_142_1:SetGaussion(false)
			end

			local var_145_17 = 2

			if var_145_16 <= arg_142_1.time_ and arg_142_1.time_ < var_145_16 + var_145_17 then
				local var_145_18 = (arg_142_1.time_ - var_145_16) / var_145_17
				local var_145_19 = Color.New(0, 0, 0)

				var_145_19.a = Mathf.Lerp(0, 1, var_145_18)
				arg_142_1.mask_.color = var_145_19
			end

			if arg_142_1.time_ >= var_145_16 + var_145_17 and arg_142_1.time_ < var_145_16 + var_145_17 + arg_145_0 then
				local var_145_20 = Color.New(0, 0, 0)

				var_145_20.a = 1
				arg_142_1.mask_.color = var_145_20
			end

			local var_145_21 = 2

			if var_145_21 < arg_142_1.time_ and arg_142_1.time_ <= var_145_21 + arg_145_0 then
				arg_142_1.mask_.enabled = true
				arg_142_1.mask_.raycastTarget = true

				arg_142_1:SetGaussion(false)
			end

			local var_145_22 = 2

			if var_145_21 <= arg_142_1.time_ and arg_142_1.time_ < var_145_21 + var_145_22 then
				local var_145_23 = (arg_142_1.time_ - var_145_21) / var_145_22
				local var_145_24 = Color.New(0, 0, 0)

				var_145_24.a = Mathf.Lerp(1, 0, var_145_23)
				arg_142_1.mask_.color = var_145_24
			end

			if arg_142_1.time_ >= var_145_21 + var_145_22 and arg_142_1.time_ < var_145_21 + var_145_22 + arg_145_0 then
				local var_145_25 = Color.New(0, 0, 0)
				local var_145_26 = 0

				arg_142_1.mask_.enabled = false
				var_145_25.a = var_145_26
				arg_142_1.mask_.color = var_145_25
			end

			local var_145_27 = 2

			if var_145_27 < arg_142_1.time_ and arg_142_1.time_ <= var_145_27 + arg_145_0 then
				arg_142_1.fswbg_:SetActive(true)
				arg_142_1.dialog_:SetActive(false)

				arg_142_1.fswtw_.percent = 0

				local var_145_28 = arg_142_1:GetWordFromCfg(424081034)
				local var_145_29 = arg_142_1:FormatText(var_145_28.content)

				arg_142_1.fswt_.text = var_145_29

				LuaForUtil.ClearLinePrefixSymbol(arg_142_1.fswt_)

				arg_142_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_142_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_142_1.fswtw_:SetDirty()

				arg_142_1.typewritterCharCountI18N = 0

				SetActive(arg_142_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_142_1:ShowNextGo(false)
			end

			local var_145_30 = 4

			if var_145_30 < arg_142_1.time_ and arg_142_1.time_ <= var_145_30 + arg_145_0 then
				arg_142_1.var_.oldValueTypewriter = arg_142_1.fswtw_.percent

				SetActive(arg_142_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_142_1:ShowNextGo(false)
			end

			local var_145_31 = 56
			local var_145_32 = 3.73333333333333
			local var_145_33 = arg_142_1:GetWordFromCfg(424081034)
			local var_145_34 = arg_142_1:FormatText(var_145_33.content)
			local var_145_35, var_145_36 = arg_142_1:GetPercentByPara(var_145_34, 1)

			if var_145_30 < arg_142_1.time_ and arg_142_1.time_ <= var_145_30 + arg_145_0 then
				arg_142_1.talkMaxDuration = 0

				local var_145_37 = var_145_31 <= 0 and var_145_32 or var_145_32 * ((var_145_36 - arg_142_1.typewritterCharCountI18N) / var_145_31)

				if var_145_37 > 0 and var_145_32 < var_145_37 then
					arg_142_1.talkMaxDuration = var_145_37

					if var_145_37 + var_145_30 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_37 + var_145_30
					end
				end
			end

			local var_145_38 = 3.73333333333333
			local var_145_39 = math.max(var_145_38, arg_142_1.talkMaxDuration)

			if var_145_30 <= arg_142_1.time_ and arg_142_1.time_ < var_145_30 + var_145_39 then
				local var_145_40 = (arg_142_1.time_ - var_145_30) / var_145_39

				arg_142_1.fswtw_.percent = Mathf.Lerp(arg_142_1.var_.oldValueTypewriter, var_145_35, var_145_40)
				arg_142_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_142_1.fswtw_:SetDirty()
			end

			if arg_142_1.time_ >= var_145_30 + var_145_39 and arg_142_1.time_ < var_145_30 + var_145_39 + arg_145_0 then
				arg_142_1.fswtw_.percent = var_145_35

				arg_142_1.fswtw_:SetDirty()
				arg_142_1:ShowNextGo(true)

				arg_142_1.typewritterCharCountI18N = var_145_36
			end

			local var_145_41 = 3.9

			if var_145_41 < arg_142_1.time_ and arg_142_1.time_ <= var_145_41 + arg_145_0 then
				local var_145_42 = arg_142_1.fswbg_.transform:Find("textbox/adapt/content") or arg_142_1.fswbg_.transform:Find("textbox/content")
				local var_145_43 = arg_142_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_145_44 = var_145_42:GetComponent("Text")
				local var_145_45 = var_145_42:GetComponent("RectTransform")

				var_145_44.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_145_45.offsetMin = Vector2.New(0, 0)
				var_145_45.offsetMax = Vector2.New(0, 0)
			end
		end

		arg_142_1.nodeConfigList_ = {}

		arg_142_1:InitPlayNodeList()
	end,
	Play424081035 = function(arg_146_0, arg_146_1)
		arg_146_1.time_ = 0
		arg_146_1.frameCnt_ = 0
		arg_146_1.state_ = "playing"
		arg_146_1.curTalkId_ = 424081035
		arg_146_1.duration_ = 9

		SetActive(arg_146_1.tipsGo_, false)

		function arg_146_1.onSingleLineFinish_()
			arg_146_1.onSingleLineUpdate_ = nil
			arg_146_1.onSingleLineFinish_ = nil
			arg_146_1.state_ = "waiting"
		end

		function arg_146_1.playNext_(arg_148_0)
			if arg_148_0 == 1 then
				arg_146_0:Play424081036(arg_146_1)
			end
		end

		function arg_146_1.onSingleLineUpdate_(arg_149_0)
			local var_149_0 = "ST0115"

			if arg_146_1.bgs_[var_149_0] == nil then
				local var_149_1 = Object.Instantiate(arg_146_1.paintGo_)

				var_149_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_149_0)
				var_149_1.name = var_149_0
				var_149_1.transform.parent = arg_146_1.stage_.transform
				var_149_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_146_1.bgs_[var_149_0] = var_149_1
			end

			local var_149_2 = 2

			if var_149_2 < arg_146_1.time_ and arg_146_1.time_ <= var_149_2 + arg_149_0 then
				local var_149_3 = manager.ui.mainCamera.transform.localPosition
				local var_149_4 = Vector3.New(0, 0, 10) + Vector3.New(var_149_3.x, var_149_3.y, 0)
				local var_149_5 = arg_146_1.bgs_.ST0115

				var_149_5.transform.localPosition = var_149_4
				var_149_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_149_6 = var_149_5:GetComponent("SpriteRenderer")

				if var_149_6 and var_149_6.sprite then
					local var_149_7 = (var_149_5.transform.localPosition - var_149_3).z
					local var_149_8 = manager.ui.mainCameraCom_
					local var_149_9 = 2 * var_149_7 * Mathf.Tan(var_149_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_149_10 = var_149_9 * var_149_8.aspect
					local var_149_11 = var_149_6.sprite.bounds.size.x
					local var_149_12 = var_149_6.sprite.bounds.size.y
					local var_149_13 = var_149_10 / var_149_11
					local var_149_14 = var_149_9 / var_149_12
					local var_149_15 = var_149_14 < var_149_13 and var_149_13 or var_149_14

					var_149_5.transform.localScale = Vector3.New(var_149_15, var_149_15, 0)
				end

				for iter_149_0, iter_149_1 in pairs(arg_146_1.bgs_) do
					if iter_149_0 ~= "ST0115" then
						iter_149_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_149_16 = 4

			if var_149_16 < arg_146_1.time_ and arg_146_1.time_ <= var_149_16 + arg_149_0 then
				arg_146_1.allBtn_.enabled = false
			end

			local var_149_17 = 0.3

			if arg_146_1.time_ >= var_149_16 + var_149_17 and arg_146_1.time_ < var_149_16 + var_149_17 + arg_149_0 then
				arg_146_1.allBtn_.enabled = true
			end

			local var_149_18 = 0

			if var_149_18 < arg_146_1.time_ and arg_146_1.time_ <= var_149_18 + arg_149_0 then
				arg_146_1.mask_.enabled = true
				arg_146_1.mask_.raycastTarget = true

				arg_146_1:SetGaussion(false)
			end

			local var_149_19 = 2

			if var_149_18 <= arg_146_1.time_ and arg_146_1.time_ < var_149_18 + var_149_19 then
				local var_149_20 = (arg_146_1.time_ - var_149_18) / var_149_19
				local var_149_21 = Color.New(0, 0, 0)

				var_149_21.a = Mathf.Lerp(0, 1, var_149_20)
				arg_146_1.mask_.color = var_149_21
			end

			if arg_146_1.time_ >= var_149_18 + var_149_19 and arg_146_1.time_ < var_149_18 + var_149_19 + arg_149_0 then
				local var_149_22 = Color.New(0, 0, 0)

				var_149_22.a = 1
				arg_146_1.mask_.color = var_149_22
			end

			local var_149_23 = 2

			if var_149_23 < arg_146_1.time_ and arg_146_1.time_ <= var_149_23 + arg_149_0 then
				arg_146_1.mask_.enabled = true
				arg_146_1.mask_.raycastTarget = true

				arg_146_1:SetGaussion(false)
			end

			local var_149_24 = 2

			if var_149_23 <= arg_146_1.time_ and arg_146_1.time_ < var_149_23 + var_149_24 then
				local var_149_25 = (arg_146_1.time_ - var_149_23) / var_149_24
				local var_149_26 = Color.New(0, 0, 0)

				var_149_26.a = Mathf.Lerp(1, 0, var_149_25)
				arg_146_1.mask_.color = var_149_26
			end

			if arg_146_1.time_ >= var_149_23 + var_149_24 and arg_146_1.time_ < var_149_23 + var_149_24 + arg_149_0 then
				local var_149_27 = Color.New(0, 0, 0)
				local var_149_28 = 0

				arg_146_1.mask_.enabled = false
				var_149_27.a = var_149_28
				arg_146_1.mask_.color = var_149_27
			end

			local var_149_29 = 2

			if var_149_29 < arg_146_1.time_ and arg_146_1.time_ <= var_149_29 + arg_149_0 then
				arg_146_1.fswbg_:SetActive(false)
				arg_146_1.dialog_:SetActive(false)
				SetActive(arg_146_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_146_1:ShowNextGo(false)
			end

			local var_149_30 = 0.166666666666667
			local var_149_31 = 1

			if var_149_30 < arg_146_1.time_ and arg_146_1.time_ <= var_149_30 + arg_149_0 then
				local var_149_32 = "stop"
				local var_149_33 = "effect"

				arg_146_1:AudioAction(var_149_32, var_149_33, "se_story_143", "se_story_143_amb_bar", "")
			end

			local var_149_34 = 1.66666666666667
			local var_149_35 = 1

			if var_149_34 < arg_146_1.time_ and arg_146_1.time_ <= var_149_34 + arg_149_0 then
				local var_149_36 = "play"
				local var_149_37 = "effect"

				arg_146_1:AudioAction(var_149_36, var_149_37, "se_story_140", "se_story_140_amb_room01", "")
			end

			if arg_146_1.frameCnt_ <= 1 then
				arg_146_1.dialog_:SetActive(false)
			end

			local var_149_38 = 4
			local var_149_39 = 0.475

			if var_149_38 < arg_146_1.time_ and arg_146_1.time_ <= var_149_38 + arg_149_0 then
				arg_146_1.talkMaxDuration = 0

				arg_146_1.dialog_:SetActive(true)

				arg_146_1.dialogCg_.alpha = 0

				local var_149_40 = LeanTween.value(arg_146_1.dialog_, 0, 1, 0.3)

				var_149_40:setOnUpdate(LuaHelper.FloatAction(function(arg_150_0)
					arg_146_1.dialogCg_.alpha = arg_150_0
				end))
				var_149_40:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_146_1.dialog_)
					var_149_40:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_146_1.duration_ = arg_146_1.duration_ + 0.3

				SetActive(arg_146_1.leftNameGo_, true)

				local var_149_41 = arg_146_1:FormatText(StoryNameCfg[7].name)

				arg_146_1.leftNameTxt_.text = var_149_41

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_146_1.leftNameTxt_.transform)

				arg_146_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_146_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_146_1:RecordName(arg_146_1.leftNameTxt_.text)
				SetActive(arg_146_1.iconTrs_.gameObject, true)
				arg_146_1.iconController_:SetSelectedState("hero")

				arg_146_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_146_1.callingController_:SetSelectedState("normal")

				arg_146_1.keyicon_.color = Color.New(1, 1, 1)
				arg_146_1.icon_.color = Color.New(1, 1, 1)

				local var_149_42 = arg_146_1:GetWordFromCfg(424081035)
				local var_149_43 = arg_146_1:FormatText(var_149_42.content)

				arg_146_1.text_.text = var_149_43

				LuaForUtil.ClearLinePrefixSymbol(arg_146_1.text_)

				local var_149_44 = 19
				local var_149_45 = utf8.len(var_149_43)
				local var_149_46 = var_149_44 <= 0 and var_149_39 or var_149_39 * (var_149_45 / var_149_44)

				if var_149_46 > 0 and var_149_39 < var_149_46 then
					arg_146_1.talkMaxDuration = var_149_46
					var_149_38 = var_149_38 + 0.3

					if var_149_46 + var_149_38 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_46 + var_149_38
					end
				end

				arg_146_1.text_.text = var_149_43
				arg_146_1.typewritter.percent = 0

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(false)
				arg_146_1:RecordContent(arg_146_1.text_.text)
			end

			local var_149_47 = var_149_38 + 0.3
			local var_149_48 = math.max(var_149_39, arg_146_1.talkMaxDuration)

			if var_149_47 <= arg_146_1.time_ and arg_146_1.time_ < var_149_47 + var_149_48 then
				arg_146_1.typewritter.percent = (arg_146_1.time_ - var_149_47) / var_149_48

				arg_146_1.typewritter:SetDirty()
			end

			if arg_146_1.time_ >= var_149_47 + var_149_48 and arg_146_1.time_ < var_149_47 + var_149_48 + arg_149_0 then
				arg_146_1.typewritter.percent = 1

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(true)
			end
		end

		arg_146_1.nodeConfigList_ = {}

		arg_146_1:InitPlayNodeList()
	end,
	Play424081036 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 424081036
		arg_152_1.duration_ = 2.33

		local var_152_0 = {
			zh = 1.566,
			ja = 2.333
		}
		local var_152_1 = manager.audio:GetLocalizationFlag()

		if var_152_0[var_152_1] ~= nil then
			arg_152_1.duration_ = var_152_0[var_152_1]
		end

		SetActive(arg_152_1.tipsGo_, false)

		function arg_152_1.onSingleLineFinish_()
			arg_152_1.onSingleLineUpdate_ = nil
			arg_152_1.onSingleLineFinish_ = nil
			arg_152_1.state_ = "waiting"
		end

		function arg_152_1.playNext_(arg_154_0)
			if arg_154_0 == 1 then
				arg_152_0:Play424081037(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			local var_155_0 = arg_152_1.actors_["1094"]
			local var_155_1 = 0

			if var_155_1 < arg_152_1.time_ and arg_152_1.time_ <= var_155_1 + arg_155_0 and not isNil(var_155_0) and arg_152_1.var_.actorSpriteComps1094 == nil then
				arg_152_1.var_.actorSpriteComps1094 = var_155_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_155_2 = 0.2

			if var_155_1 <= arg_152_1.time_ and arg_152_1.time_ < var_155_1 + var_155_2 and not isNil(var_155_0) then
				local var_155_3 = (arg_152_1.time_ - var_155_1) / var_155_2

				if arg_152_1.var_.actorSpriteComps1094 then
					for iter_155_0, iter_155_1 in pairs(arg_152_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_155_1 then
							if arg_152_1.isInRecall_ then
								local var_155_4 = Mathf.Lerp(iter_155_1.color.r, arg_152_1.hightColor1.r, var_155_3)
								local var_155_5 = Mathf.Lerp(iter_155_1.color.g, arg_152_1.hightColor1.g, var_155_3)
								local var_155_6 = Mathf.Lerp(iter_155_1.color.b, arg_152_1.hightColor1.b, var_155_3)

								iter_155_1.color = Color.New(var_155_4, var_155_5, var_155_6)
							else
								local var_155_7 = Mathf.Lerp(iter_155_1.color.r, 1, var_155_3)

								iter_155_1.color = Color.New(var_155_7, var_155_7, var_155_7)
							end
						end
					end
				end
			end

			if arg_152_1.time_ >= var_155_1 + var_155_2 and arg_152_1.time_ < var_155_1 + var_155_2 + arg_155_0 and not isNil(var_155_0) and arg_152_1.var_.actorSpriteComps1094 then
				for iter_155_2, iter_155_3 in pairs(arg_152_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_155_3 then
						if arg_152_1.isInRecall_ then
							iter_155_3.color = arg_152_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_155_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_152_1.var_.actorSpriteComps1094 = nil
			end

			local var_155_8 = arg_152_1.actors_["1094"].transform
			local var_155_9 = 0

			if var_155_9 < arg_152_1.time_ and arg_152_1.time_ <= var_155_9 + arg_155_0 then
				arg_152_1.var_.moveOldPos1094 = var_155_8.localPosition
				var_155_8.localScale = Vector3.New(1, 1, 1)

				arg_152_1:CheckSpriteTmpPos("1094", 3)

				local var_155_10 = var_155_8.childCount

				for iter_155_4 = 0, var_155_10 - 1 do
					local var_155_11 = var_155_8:GetChild(iter_155_4)

					if var_155_11.name == "split_2" or not string.find(var_155_11.name, "split") then
						var_155_11.gameObject:SetActive(true)
					else
						var_155_11.gameObject:SetActive(false)
					end
				end
			end

			local var_155_12 = 0.001

			if var_155_9 <= arg_152_1.time_ and arg_152_1.time_ < var_155_9 + var_155_12 then
				local var_155_13 = (arg_152_1.time_ - var_155_9) / var_155_12
				local var_155_14 = Vector3.New(0, -335, -230)

				var_155_8.localPosition = Vector3.Lerp(arg_152_1.var_.moveOldPos1094, var_155_14, var_155_13)
			end

			if arg_152_1.time_ >= var_155_9 + var_155_12 and arg_152_1.time_ < var_155_9 + var_155_12 + arg_155_0 then
				var_155_8.localPosition = Vector3.New(0, -335, -230)
			end

			local var_155_15 = 0
			local var_155_16 = 0.15

			if var_155_15 < arg_152_1.time_ and arg_152_1.time_ <= var_155_15 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, true)

				local var_155_17 = arg_152_1:FormatText(StoryNameCfg[181].name)

				arg_152_1.leftNameTxt_.text = var_155_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_152_1.leftNameTxt_.transform)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1.leftNameTxt_.text)
				SetActive(arg_152_1.iconTrs_.gameObject, false)
				arg_152_1.callingController_:SetSelectedState("normal")

				local var_155_18 = arg_152_1:GetWordFromCfg(424081036)
				local var_155_19 = arg_152_1:FormatText(var_155_18.content)

				arg_152_1.text_.text = var_155_19

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_20 = 6
				local var_155_21 = utf8.len(var_155_19)
				local var_155_22 = var_155_20 <= 0 and var_155_16 or var_155_16 * (var_155_21 / var_155_20)

				if var_155_22 > 0 and var_155_16 < var_155_22 then
					arg_152_1.talkMaxDuration = var_155_22

					if var_155_22 + var_155_15 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_22 + var_155_15
					end
				end

				arg_152_1.text_.text = var_155_19
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424081", "424081036", "story_v_out_424081.awb") ~= 0 then
					local var_155_23 = manager.audio:GetVoiceLength("story_v_out_424081", "424081036", "story_v_out_424081.awb") / 1000

					if var_155_23 + var_155_15 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_23 + var_155_15
					end

					if var_155_18.prefab_name ~= "" and arg_152_1.actors_[var_155_18.prefab_name] ~= nil then
						local var_155_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_152_1.actors_[var_155_18.prefab_name].transform, "story_v_out_424081", "424081036", "story_v_out_424081.awb")

						arg_152_1:RecordAudio("424081036", var_155_24)
						arg_152_1:RecordAudio("424081036", var_155_24)
					else
						arg_152_1:AudioAction("play", "voice", "story_v_out_424081", "424081036", "story_v_out_424081.awb")
					end

					arg_152_1:RecordHistoryTalkVoice("story_v_out_424081", "424081036", "story_v_out_424081.awb")
				end

				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_25 = math.max(var_155_16, arg_152_1.talkMaxDuration)

			if var_155_15 <= arg_152_1.time_ and arg_152_1.time_ < var_155_15 + var_155_25 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - var_155_15) / var_155_25

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= var_155_15 + var_155_25 and arg_152_1.time_ < var_155_15 + var_155_25 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094",
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
	Play424081037 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 424081037
		arg_156_1.duration_ = 5

		SetActive(arg_156_1.tipsGo_, false)

		function arg_156_1.onSingleLineFinish_()
			arg_156_1.onSingleLineUpdate_ = nil
			arg_156_1.onSingleLineFinish_ = nil
			arg_156_1.state_ = "waiting"
		end

		function arg_156_1.playNext_(arg_158_0)
			if arg_158_0 == 1 then
				arg_156_0:Play424081038(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			local var_159_0 = arg_156_1.actors_["1094"]
			local var_159_1 = 0

			if var_159_1 < arg_156_1.time_ and arg_156_1.time_ <= var_159_1 + arg_159_0 and not isNil(var_159_0) and arg_156_1.var_.actorSpriteComps1094 == nil then
				arg_156_1.var_.actorSpriteComps1094 = var_159_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_159_2 = 0.2

			if var_159_1 <= arg_156_1.time_ and arg_156_1.time_ < var_159_1 + var_159_2 and not isNil(var_159_0) then
				local var_159_3 = (arg_156_1.time_ - var_159_1) / var_159_2

				if arg_156_1.var_.actorSpriteComps1094 then
					for iter_159_0, iter_159_1 in pairs(arg_156_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_159_1 then
							if arg_156_1.isInRecall_ then
								local var_159_4 = Mathf.Lerp(iter_159_1.color.r, arg_156_1.hightColor2.r, var_159_3)
								local var_159_5 = Mathf.Lerp(iter_159_1.color.g, arg_156_1.hightColor2.g, var_159_3)
								local var_159_6 = Mathf.Lerp(iter_159_1.color.b, arg_156_1.hightColor2.b, var_159_3)

								iter_159_1.color = Color.New(var_159_4, var_159_5, var_159_6)
							else
								local var_159_7 = Mathf.Lerp(iter_159_1.color.r, 0.5, var_159_3)

								iter_159_1.color = Color.New(var_159_7, var_159_7, var_159_7)
							end
						end
					end
				end
			end

			if arg_156_1.time_ >= var_159_1 + var_159_2 and arg_156_1.time_ < var_159_1 + var_159_2 + arg_159_0 and not isNil(var_159_0) and arg_156_1.var_.actorSpriteComps1094 then
				for iter_159_2, iter_159_3 in pairs(arg_156_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_159_3 then
						if arg_156_1.isInRecall_ then
							iter_159_3.color = arg_156_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_159_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_156_1.var_.actorSpriteComps1094 = nil
			end

			local var_159_8 = 0
			local var_159_9 = 0.4

			if var_159_8 < arg_156_1.time_ and arg_156_1.time_ <= var_159_8 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, true)

				local var_159_10 = arg_156_1:FormatText(StoryNameCfg[7].name)

				arg_156_1.leftNameTxt_.text = var_159_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_156_1.leftNameTxt_.transform)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1.leftNameTxt_.text)
				SetActive(arg_156_1.iconTrs_.gameObject, true)
				arg_156_1.iconController_:SetSelectedState("hero")

				arg_156_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_156_1.callingController_:SetSelectedState("normal")

				arg_156_1.keyicon_.color = Color.New(1, 1, 1)
				arg_156_1.icon_.color = Color.New(1, 1, 1)

				local var_159_11 = arg_156_1:GetWordFromCfg(424081037)
				local var_159_12 = arg_156_1:FormatText(var_159_11.content)

				arg_156_1.text_.text = var_159_12

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_13 = 16
				local var_159_14 = utf8.len(var_159_12)
				local var_159_15 = var_159_13 <= 0 and var_159_9 or var_159_9 * (var_159_14 / var_159_13)

				if var_159_15 > 0 and var_159_9 < var_159_15 then
					arg_156_1.talkMaxDuration = var_159_15

					if var_159_15 + var_159_8 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_15 + var_159_8
					end
				end

				arg_156_1.text_.text = var_159_12
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)
				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_16 = math.max(var_159_9, arg_156_1.talkMaxDuration)

			if var_159_8 <= arg_156_1.time_ and arg_156_1.time_ < var_159_8 + var_159_16 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - var_159_8) / var_159_16

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= var_159_8 + var_159_16 and arg_156_1.time_ < var_159_8 + var_159_16 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {}

		arg_156_1:InitPlayNodeList()
	end,
	Play424081038 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 424081038
		arg_160_1.duration_ = 4.33

		local var_160_0 = {
			zh = 3.3,
			ja = 4.333
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
				arg_160_0:Play424081039(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			local var_163_0 = 0
			local var_163_1 = 0.325

			if var_163_0 < arg_160_1.time_ and arg_160_1.time_ <= var_163_0 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0
				arg_160_1.dialogCg_.alpha = 1

				arg_160_1.dialog_:SetActive(true)
				SetActive(arg_160_1.leftNameGo_, true)

				local var_163_2 = arg_160_1:FormatText(StoryNameCfg[177].name)

				arg_160_1.leftNameTxt_.text = var_163_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_160_1.leftNameTxt_.transform)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1.leftNameTxt_.text)
				SetActive(arg_160_1.iconTrs_.gameObject, true)
				arg_160_1.iconController_:SetSelectedState("hero")

				arg_160_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_160_1.callingController_:SetSelectedState("normal")

				arg_160_1.keyicon_.color = Color.New(1, 1, 1)
				arg_160_1.icon_.color = Color.New(1, 1, 1)

				local var_163_3 = arg_160_1:GetWordFromCfg(424081038)
				local var_163_4 = arg_160_1:FormatText(var_163_3.content)

				arg_160_1.text_.text = var_163_4

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_5 = 13
				local var_163_6 = utf8.len(var_163_4)
				local var_163_7 = var_163_5 <= 0 and var_163_1 or var_163_1 * (var_163_6 / var_163_5)

				if var_163_7 > 0 and var_163_1 < var_163_7 then
					arg_160_1.talkMaxDuration = var_163_7

					if var_163_7 + var_163_0 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_7 + var_163_0
					end
				end

				arg_160_1.text_.text = var_163_4
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424081", "424081038", "story_v_out_424081.awb") ~= 0 then
					local var_163_8 = manager.audio:GetVoiceLength("story_v_out_424081", "424081038", "story_v_out_424081.awb") / 1000

					if var_163_8 + var_163_0 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_8 + var_163_0
					end

					if var_163_3.prefab_name ~= "" and arg_160_1.actors_[var_163_3.prefab_name] ~= nil then
						local var_163_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_160_1.actors_[var_163_3.prefab_name].transform, "story_v_out_424081", "424081038", "story_v_out_424081.awb")

						arg_160_1:RecordAudio("424081038", var_163_9)
						arg_160_1:RecordAudio("424081038", var_163_9)
					else
						arg_160_1:AudioAction("play", "voice", "story_v_out_424081", "424081038", "story_v_out_424081.awb")
					end

					arg_160_1:RecordHistoryTalkVoice("story_v_out_424081", "424081038", "story_v_out_424081.awb")
				end

				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_10 = math.max(var_163_1, arg_160_1.talkMaxDuration)

			if var_163_0 <= arg_160_1.time_ and arg_160_1.time_ < var_163_0 + var_163_10 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - var_163_0) / var_163_10

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= var_163_0 + var_163_10 and arg_160_1.time_ < var_163_0 + var_163_10 + arg_163_0 then
				arg_160_1.typewritter.percent = 1

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(true)
			end
		end

		arg_160_1.nodeConfigList_ = {}

		arg_160_1:InitPlayNodeList()
	end,
	Play424081039 = function(arg_164_0, arg_164_1)
		arg_164_1.time_ = 0
		arg_164_1.frameCnt_ = 0
		arg_164_1.state_ = "playing"
		arg_164_1.curTalkId_ = 424081039
		arg_164_1.duration_ = 5

		SetActive(arg_164_1.tipsGo_, false)

		function arg_164_1.onSingleLineFinish_()
			arg_164_1.onSingleLineUpdate_ = nil
			arg_164_1.onSingleLineFinish_ = nil
			arg_164_1.state_ = "waiting"
		end

		function arg_164_1.playNext_(arg_166_0)
			if arg_166_0 == 1 then
				arg_164_0:Play424081040(arg_164_1)
			end
		end

		function arg_164_1.onSingleLineUpdate_(arg_167_0)
			local var_167_0 = 0
			local var_167_1 = 0.425

			if var_167_0 < arg_164_1.time_ and arg_164_1.time_ <= var_167_0 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0
				arg_164_1.dialogCg_.alpha = 1

				arg_164_1.dialog_:SetActive(true)
				SetActive(arg_164_1.leftNameGo_, true)

				local var_167_2 = arg_164_1:FormatText(StoryNameCfg[7].name)

				arg_164_1.leftNameTxt_.text = var_167_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_164_1.leftNameTxt_.transform)

				arg_164_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_164_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_164_1:RecordName(arg_164_1.leftNameTxt_.text)
				SetActive(arg_164_1.iconTrs_.gameObject, true)
				arg_164_1.iconController_:SetSelectedState("hero")

				arg_164_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_164_1.callingController_:SetSelectedState("normal")

				arg_164_1.keyicon_.color = Color.New(1, 1, 1)
				arg_164_1.icon_.color = Color.New(1, 1, 1)

				local var_167_3 = arg_164_1:GetWordFromCfg(424081039)
				local var_167_4 = arg_164_1:FormatText(var_167_3.content)

				arg_164_1.text_.text = var_167_4

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_5 = 17
				local var_167_6 = utf8.len(var_167_4)
				local var_167_7 = var_167_5 <= 0 and var_167_1 or var_167_1 * (var_167_6 / var_167_5)

				if var_167_7 > 0 and var_167_1 < var_167_7 then
					arg_164_1.talkMaxDuration = var_167_7

					if var_167_7 + var_167_0 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_7 + var_167_0
					end
				end

				arg_164_1.text_.text = var_167_4
				arg_164_1.typewritter.percent = 0

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(false)
				arg_164_1:RecordContent(arg_164_1.text_.text)
			end

			local var_167_8 = math.max(var_167_1, arg_164_1.talkMaxDuration)

			if var_167_0 <= arg_164_1.time_ and arg_164_1.time_ < var_167_0 + var_167_8 then
				arg_164_1.typewritter.percent = (arg_164_1.time_ - var_167_0) / var_167_8

				arg_164_1.typewritter:SetDirty()
			end

			if arg_164_1.time_ >= var_167_0 + var_167_8 and arg_164_1.time_ < var_167_0 + var_167_8 + arg_167_0 then
				arg_164_1.typewritter.percent = 1

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(true)
			end
		end

		arg_164_1.nodeConfigList_ = {}

		arg_164_1:InitPlayNodeList()
	end,
	Play424081040 = function(arg_168_0, arg_168_1)
		arg_168_1.time_ = 0
		arg_168_1.frameCnt_ = 0
		arg_168_1.state_ = "playing"
		arg_168_1.curTalkId_ = 424081040
		arg_168_1.duration_ = 8.87

		local var_168_0 = {
			zh = 6.866,
			ja = 8.866
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
				arg_168_0:Play424081041(arg_168_1)
			end
		end

		function arg_168_1.onSingleLineUpdate_(arg_171_0)
			local var_171_0 = 0
			local var_171_1 = 0.925

			if var_171_0 < arg_168_1.time_ and arg_168_1.time_ <= var_171_0 + arg_171_0 then
				arg_168_1.talkMaxDuration = 0
				arg_168_1.dialogCg_.alpha = 1

				arg_168_1.dialog_:SetActive(true)
				SetActive(arg_168_1.leftNameGo_, true)

				local var_171_2 = arg_168_1:FormatText(StoryNameCfg[177].name)

				arg_168_1.leftNameTxt_.text = var_171_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_168_1.leftNameTxt_.transform)

				arg_168_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_168_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_168_1:RecordName(arg_168_1.leftNameTxt_.text)
				SetActive(arg_168_1.iconTrs_.gameObject, true)
				arg_168_1.iconController_:SetSelectedState("hero")

				arg_168_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_168_1.callingController_:SetSelectedState("normal")

				arg_168_1.keyicon_.color = Color.New(1, 1, 1)
				arg_168_1.icon_.color = Color.New(1, 1, 1)

				local var_171_3 = arg_168_1:GetWordFromCfg(424081040)
				local var_171_4 = arg_168_1:FormatText(var_171_3.content)

				arg_168_1.text_.text = var_171_4

				LuaForUtil.ClearLinePrefixSymbol(arg_168_1.text_)

				local var_171_5 = 37
				local var_171_6 = utf8.len(var_171_4)
				local var_171_7 = var_171_5 <= 0 and var_171_1 or var_171_1 * (var_171_6 / var_171_5)

				if var_171_7 > 0 and var_171_1 < var_171_7 then
					arg_168_1.talkMaxDuration = var_171_7

					if var_171_7 + var_171_0 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_7 + var_171_0
					end
				end

				arg_168_1.text_.text = var_171_4
				arg_168_1.typewritter.percent = 0

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424081", "424081040", "story_v_out_424081.awb") ~= 0 then
					local var_171_8 = manager.audio:GetVoiceLength("story_v_out_424081", "424081040", "story_v_out_424081.awb") / 1000

					if var_171_8 + var_171_0 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_8 + var_171_0
					end

					if var_171_3.prefab_name ~= "" and arg_168_1.actors_[var_171_3.prefab_name] ~= nil then
						local var_171_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_168_1.actors_[var_171_3.prefab_name].transform, "story_v_out_424081", "424081040", "story_v_out_424081.awb")

						arg_168_1:RecordAudio("424081040", var_171_9)
						arg_168_1:RecordAudio("424081040", var_171_9)
					else
						arg_168_1:AudioAction("play", "voice", "story_v_out_424081", "424081040", "story_v_out_424081.awb")
					end

					arg_168_1:RecordHistoryTalkVoice("story_v_out_424081", "424081040", "story_v_out_424081.awb")
				end

				arg_168_1:RecordContent(arg_168_1.text_.text)
			end

			local var_171_10 = math.max(var_171_1, arg_168_1.talkMaxDuration)

			if var_171_0 <= arg_168_1.time_ and arg_168_1.time_ < var_171_0 + var_171_10 then
				arg_168_1.typewritter.percent = (arg_168_1.time_ - var_171_0) / var_171_10

				arg_168_1.typewritter:SetDirty()
			end

			if arg_168_1.time_ >= var_171_0 + var_171_10 and arg_168_1.time_ < var_171_0 + var_171_10 + arg_171_0 then
				arg_168_1.typewritter.percent = 1

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(true)
			end
		end

		arg_168_1.nodeConfigList_ = {}

		arg_168_1:InitPlayNodeList()
	end,
	Play424081041 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 424081041
		arg_172_1.duration_ = 5

		SetActive(arg_172_1.tipsGo_, false)

		function arg_172_1.onSingleLineFinish_()
			arg_172_1.onSingleLineUpdate_ = nil
			arg_172_1.onSingleLineFinish_ = nil
			arg_172_1.state_ = "waiting"
		end

		function arg_172_1.playNext_(arg_174_0)
			if arg_174_0 == 1 then
				arg_172_0:Play424081042(arg_172_1)
			end
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			local var_175_0 = arg_172_1.actors_["1094"].transform
			local var_175_1 = 0

			if var_175_1 < arg_172_1.time_ and arg_172_1.time_ <= var_175_1 + arg_175_0 then
				arg_172_1.var_.moveOldPos1094 = var_175_0.localPosition
				var_175_0.localScale = Vector3.New(1, 1, 1)

				arg_172_1:CheckSpriteTmpPos("1094", 7)

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
				local var_175_6 = Vector3.New(0, -2000, 0)

				var_175_0.localPosition = Vector3.Lerp(arg_172_1.var_.moveOldPos1094, var_175_6, var_175_5)
			end

			if arg_172_1.time_ >= var_175_1 + var_175_4 and arg_172_1.time_ < var_175_1 + var_175_4 + arg_175_0 then
				var_175_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_175_7 = 0.1
			local var_175_8 = 1

			if var_175_7 < arg_172_1.time_ and arg_172_1.time_ <= var_175_7 + arg_175_0 then
				local var_175_9 = "play"
				local var_175_10 = "effect"

				arg_172_1:AudioAction(var_175_9, var_175_10, "se_story_side_1081", "se_story_side_1081_dooropen", "")
			end

			local var_175_11 = 0
			local var_175_12 = 0.6

			if var_175_11 < arg_172_1.time_ and arg_172_1.time_ <= var_175_11 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0
				arg_172_1.dialogCg_.alpha = 1

				arg_172_1.dialog_:SetActive(true)
				SetActive(arg_172_1.leftNameGo_, false)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_172_1.iconTrs_.gameObject, false)
				arg_172_1.callingController_:SetSelectedState("normal")

				local var_175_13 = arg_172_1:GetWordFromCfg(424081041)
				local var_175_14 = arg_172_1:FormatText(var_175_13.content)

				arg_172_1.text_.text = var_175_14

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_15 = 24
				local var_175_16 = utf8.len(var_175_14)
				local var_175_17 = var_175_15 <= 0 and var_175_12 or var_175_12 * (var_175_16 / var_175_15)

				if var_175_17 > 0 and var_175_12 < var_175_17 then
					arg_172_1.talkMaxDuration = var_175_17

					if var_175_17 + var_175_11 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_17 + var_175_11
					end
				end

				arg_172_1.text_.text = var_175_14
				arg_172_1.typewritter.percent = 0

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(false)
				arg_172_1:RecordContent(arg_172_1.text_.text)
			end

			local var_175_18 = math.max(var_175_12, arg_172_1.talkMaxDuration)

			if var_175_11 <= arg_172_1.time_ and arg_172_1.time_ < var_175_11 + var_175_18 then
				arg_172_1.typewritter.percent = (arg_172_1.time_ - var_175_11) / var_175_18

				arg_172_1.typewritter:SetDirty()
			end

			if arg_172_1.time_ >= var_175_11 + var_175_18 and arg_172_1.time_ < var_175_11 + var_175_18 + arg_175_0 then
				arg_172_1.typewritter.percent = 1

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(true)
			end
		end

		arg_172_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094",
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
	Play424081042 = function(arg_176_0, arg_176_1)
		arg_176_1.time_ = 0
		arg_176_1.frameCnt_ = 0
		arg_176_1.state_ = "playing"
		arg_176_1.curTalkId_ = 424081042
		arg_176_1.duration_ = 5

		SetActive(arg_176_1.tipsGo_, false)

		function arg_176_1.onSingleLineFinish_()
			arg_176_1.onSingleLineUpdate_ = nil
			arg_176_1.onSingleLineFinish_ = nil
			arg_176_1.state_ = "waiting"
		end

		function arg_176_1.playNext_(arg_178_0)
			if arg_178_0 == 1 then
				arg_176_0:Play424081043(arg_176_1)
			end
		end

		function arg_176_1.onSingleLineUpdate_(arg_179_0)
			local var_179_0 = 0
			local var_179_1 = 0.125

			if var_179_0 < arg_176_1.time_ and arg_176_1.time_ <= var_179_0 + arg_179_0 then
				arg_176_1.talkMaxDuration = 0
				arg_176_1.dialogCg_.alpha = 1

				arg_176_1.dialog_:SetActive(true)
				SetActive(arg_176_1.leftNameGo_, true)

				local var_179_2 = arg_176_1:FormatText(StoryNameCfg[7].name)

				arg_176_1.leftNameTxt_.text = var_179_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_176_1.leftNameTxt_.transform)

				arg_176_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_176_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_176_1:RecordName(arg_176_1.leftNameTxt_.text)
				SetActive(arg_176_1.iconTrs_.gameObject, true)
				arg_176_1.iconController_:SetSelectedState("hero")

				arg_176_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_176_1.callingController_:SetSelectedState("normal")

				arg_176_1.keyicon_.color = Color.New(1, 1, 1)
				arg_176_1.icon_.color = Color.New(1, 1, 1)

				local var_179_3 = arg_176_1:GetWordFromCfg(424081042)
				local var_179_4 = arg_176_1:FormatText(var_179_3.content)

				arg_176_1.text_.text = var_179_4

				LuaForUtil.ClearLinePrefixSymbol(arg_176_1.text_)

				local var_179_5 = 5
				local var_179_6 = utf8.len(var_179_4)
				local var_179_7 = var_179_5 <= 0 and var_179_1 or var_179_1 * (var_179_6 / var_179_5)

				if var_179_7 > 0 and var_179_1 < var_179_7 then
					arg_176_1.talkMaxDuration = var_179_7

					if var_179_7 + var_179_0 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_7 + var_179_0
					end
				end

				arg_176_1.text_.text = var_179_4
				arg_176_1.typewritter.percent = 0

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(false)
				arg_176_1:RecordContent(arg_176_1.text_.text)
			end

			local var_179_8 = math.max(var_179_1, arg_176_1.talkMaxDuration)

			if var_179_0 <= arg_176_1.time_ and arg_176_1.time_ < var_179_0 + var_179_8 then
				arg_176_1.typewritter.percent = (arg_176_1.time_ - var_179_0) / var_179_8

				arg_176_1.typewritter:SetDirty()
			end

			if arg_176_1.time_ >= var_179_0 + var_179_8 and arg_176_1.time_ < var_179_0 + var_179_8 + arg_179_0 then
				arg_176_1.typewritter.percent = 1

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(true)
			end
		end

		arg_176_1.nodeConfigList_ = {}

		arg_176_1:InitPlayNodeList()
	end,
	Play424081043 = function(arg_180_0, arg_180_1)
		arg_180_1.time_ = 0
		arg_180_1.frameCnt_ = 0
		arg_180_1.state_ = "playing"
		arg_180_1.curTalkId_ = 424081043
		arg_180_1.duration_ = 4.33

		local var_180_0 = {
			zh = 3.766,
			ja = 4.333
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
				arg_180_0:Play424081044(arg_180_1)
			end
		end

		function arg_180_1.onSingleLineUpdate_(arg_183_0)
			local var_183_0 = arg_180_1.actors_["1094"]
			local var_183_1 = 0

			if var_183_1 < arg_180_1.time_ and arg_180_1.time_ <= var_183_1 + arg_183_0 and not isNil(var_183_0) and arg_180_1.var_.actorSpriteComps1094 == nil then
				arg_180_1.var_.actorSpriteComps1094 = var_183_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_183_2 = 0.2

			if var_183_1 <= arg_180_1.time_ and arg_180_1.time_ < var_183_1 + var_183_2 and not isNil(var_183_0) then
				local var_183_3 = (arg_180_1.time_ - var_183_1) / var_183_2

				if arg_180_1.var_.actorSpriteComps1094 then
					for iter_183_0, iter_183_1 in pairs(arg_180_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_183_1 then
							if arg_180_1.isInRecall_ then
								local var_183_4 = Mathf.Lerp(iter_183_1.color.r, arg_180_1.hightColor1.r, var_183_3)
								local var_183_5 = Mathf.Lerp(iter_183_1.color.g, arg_180_1.hightColor1.g, var_183_3)
								local var_183_6 = Mathf.Lerp(iter_183_1.color.b, arg_180_1.hightColor1.b, var_183_3)

								iter_183_1.color = Color.New(var_183_4, var_183_5, var_183_6)
							else
								local var_183_7 = Mathf.Lerp(iter_183_1.color.r, 1, var_183_3)

								iter_183_1.color = Color.New(var_183_7, var_183_7, var_183_7)
							end
						end
					end
				end
			end

			if arg_180_1.time_ >= var_183_1 + var_183_2 and arg_180_1.time_ < var_183_1 + var_183_2 + arg_183_0 and not isNil(var_183_0) and arg_180_1.var_.actorSpriteComps1094 then
				for iter_183_2, iter_183_3 in pairs(arg_180_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_183_3 then
						if arg_180_1.isInRecall_ then
							iter_183_3.color = arg_180_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_183_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_180_1.var_.actorSpriteComps1094 = nil
			end

			local var_183_8 = arg_180_1.actors_["1094"].transform
			local var_183_9 = 0

			if var_183_9 < arg_180_1.time_ and arg_180_1.time_ <= var_183_9 + arg_183_0 then
				arg_180_1.var_.moveOldPos1094 = var_183_8.localPosition
				var_183_8.localScale = Vector3.New(1, 1, 1)

				arg_180_1:CheckSpriteTmpPos("1094", 3)

				local var_183_10 = var_183_8.childCount

				for iter_183_4 = 0, var_183_10 - 1 do
					local var_183_11 = var_183_8:GetChild(iter_183_4)

					if var_183_11.name == "split_3" or not string.find(var_183_11.name, "split") then
						var_183_11.gameObject:SetActive(true)
					else
						var_183_11.gameObject:SetActive(false)
					end
				end
			end

			local var_183_12 = 0.001

			if var_183_9 <= arg_180_1.time_ and arg_180_1.time_ < var_183_9 + var_183_12 then
				local var_183_13 = (arg_180_1.time_ - var_183_9) / var_183_12
				local var_183_14 = Vector3.New(0, -335, -230)

				var_183_8.localPosition = Vector3.Lerp(arg_180_1.var_.moveOldPos1094, var_183_14, var_183_13)
			end

			if arg_180_1.time_ >= var_183_9 + var_183_12 and arg_180_1.time_ < var_183_9 + var_183_12 + arg_183_0 then
				var_183_8.localPosition = Vector3.New(0, -335, -230)
			end

			local var_183_15 = 0
			local var_183_16 = 0.3

			if var_183_15 < arg_180_1.time_ and arg_180_1.time_ <= var_183_15 + arg_183_0 then
				arg_180_1.talkMaxDuration = 0
				arg_180_1.dialogCg_.alpha = 1

				arg_180_1.dialog_:SetActive(true)
				SetActive(arg_180_1.leftNameGo_, true)

				local var_183_17 = arg_180_1:FormatText(StoryNameCfg[181].name)

				arg_180_1.leftNameTxt_.text = var_183_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_180_1.leftNameTxt_.transform)

				arg_180_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_180_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_180_1:RecordName(arg_180_1.leftNameTxt_.text)
				SetActive(arg_180_1.iconTrs_.gameObject, false)
				arg_180_1.callingController_:SetSelectedState("normal")

				local var_183_18 = arg_180_1:GetWordFromCfg(424081043)
				local var_183_19 = arg_180_1:FormatText(var_183_18.content)

				arg_180_1.text_.text = var_183_19

				LuaForUtil.ClearLinePrefixSymbol(arg_180_1.text_)

				local var_183_20 = 12
				local var_183_21 = utf8.len(var_183_19)
				local var_183_22 = var_183_20 <= 0 and var_183_16 or var_183_16 * (var_183_21 / var_183_20)

				if var_183_22 > 0 and var_183_16 < var_183_22 then
					arg_180_1.talkMaxDuration = var_183_22

					if var_183_22 + var_183_15 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_22 + var_183_15
					end
				end

				arg_180_1.text_.text = var_183_19
				arg_180_1.typewritter.percent = 0

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424081", "424081043", "story_v_out_424081.awb") ~= 0 then
					local var_183_23 = manager.audio:GetVoiceLength("story_v_out_424081", "424081043", "story_v_out_424081.awb") / 1000

					if var_183_23 + var_183_15 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_23 + var_183_15
					end

					if var_183_18.prefab_name ~= "" and arg_180_1.actors_[var_183_18.prefab_name] ~= nil then
						local var_183_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_180_1.actors_[var_183_18.prefab_name].transform, "story_v_out_424081", "424081043", "story_v_out_424081.awb")

						arg_180_1:RecordAudio("424081043", var_183_24)
						arg_180_1:RecordAudio("424081043", var_183_24)
					else
						arg_180_1:AudioAction("play", "voice", "story_v_out_424081", "424081043", "story_v_out_424081.awb")
					end

					arg_180_1:RecordHistoryTalkVoice("story_v_out_424081", "424081043", "story_v_out_424081.awb")
				end

				arg_180_1:RecordContent(arg_180_1.text_.text)
			end

			local var_183_25 = math.max(var_183_16, arg_180_1.talkMaxDuration)

			if var_183_15 <= arg_180_1.time_ and arg_180_1.time_ < var_183_15 + var_183_25 then
				arg_180_1.typewritter.percent = (arg_180_1.time_ - var_183_15) / var_183_25

				arg_180_1.typewritter:SetDirty()
			end

			if arg_180_1.time_ >= var_183_15 + var_183_25 and arg_180_1.time_ < var_183_15 + var_183_25 + arg_183_0 then
				arg_180_1.typewritter.percent = 1

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(true)
			end
		end

		arg_180_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_180_1:InitPlayNodeList()
	end,
	Play424081044 = function(arg_184_0, arg_184_1)
		arg_184_1.time_ = 0
		arg_184_1.frameCnt_ = 0
		arg_184_1.state_ = "playing"
		arg_184_1.curTalkId_ = 424081044
		arg_184_1.duration_ = 5

		SetActive(arg_184_1.tipsGo_, false)

		function arg_184_1.onSingleLineFinish_()
			arg_184_1.onSingleLineUpdate_ = nil
			arg_184_1.onSingleLineFinish_ = nil
			arg_184_1.state_ = "waiting"
		end

		function arg_184_1.playNext_(arg_186_0)
			if arg_186_0 == 1 then
				arg_184_0:Play424081045(arg_184_1)
			end
		end

		function arg_184_1.onSingleLineUpdate_(arg_187_0)
			local var_187_0 = arg_184_1.actors_["1094"]
			local var_187_1 = 0

			if var_187_1 < arg_184_1.time_ and arg_184_1.time_ <= var_187_1 + arg_187_0 and not isNil(var_187_0) and arg_184_1.var_.actorSpriteComps1094 == nil then
				arg_184_1.var_.actorSpriteComps1094 = var_187_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_187_2 = 0.2

			if var_187_1 <= arg_184_1.time_ and arg_184_1.time_ < var_187_1 + var_187_2 and not isNil(var_187_0) then
				local var_187_3 = (arg_184_1.time_ - var_187_1) / var_187_2

				if arg_184_1.var_.actorSpriteComps1094 then
					for iter_187_0, iter_187_1 in pairs(arg_184_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_187_1 then
							if arg_184_1.isInRecall_ then
								local var_187_4 = Mathf.Lerp(iter_187_1.color.r, arg_184_1.hightColor2.r, var_187_3)
								local var_187_5 = Mathf.Lerp(iter_187_1.color.g, arg_184_1.hightColor2.g, var_187_3)
								local var_187_6 = Mathf.Lerp(iter_187_1.color.b, arg_184_1.hightColor2.b, var_187_3)

								iter_187_1.color = Color.New(var_187_4, var_187_5, var_187_6)
							else
								local var_187_7 = Mathf.Lerp(iter_187_1.color.r, 0.5, var_187_3)

								iter_187_1.color = Color.New(var_187_7, var_187_7, var_187_7)
							end
						end
					end
				end
			end

			if arg_184_1.time_ >= var_187_1 + var_187_2 and arg_184_1.time_ < var_187_1 + var_187_2 + arg_187_0 and not isNil(var_187_0) and arg_184_1.var_.actorSpriteComps1094 then
				for iter_187_2, iter_187_3 in pairs(arg_184_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_187_3 then
						if arg_184_1.isInRecall_ then
							iter_187_3.color = arg_184_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_187_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_184_1.var_.actorSpriteComps1094 = nil
			end

			local var_187_8 = 0
			local var_187_9 = 0.6

			if var_187_8 < arg_184_1.time_ and arg_184_1.time_ <= var_187_8 + arg_187_0 then
				arg_184_1.talkMaxDuration = 0
				arg_184_1.dialogCg_.alpha = 1

				arg_184_1.dialog_:SetActive(true)
				SetActive(arg_184_1.leftNameGo_, true)

				local var_187_10 = arg_184_1:FormatText(StoryNameCfg[7].name)

				arg_184_1.leftNameTxt_.text = var_187_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_184_1.leftNameTxt_.transform)

				arg_184_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_184_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_184_1:RecordName(arg_184_1.leftNameTxt_.text)
				SetActive(arg_184_1.iconTrs_.gameObject, true)
				arg_184_1.iconController_:SetSelectedState("hero")

				arg_184_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_184_1.callingController_:SetSelectedState("normal")

				arg_184_1.keyicon_.color = Color.New(1, 1, 1)
				arg_184_1.icon_.color = Color.New(1, 1, 1)

				local var_187_11 = arg_184_1:GetWordFromCfg(424081044)
				local var_187_12 = arg_184_1:FormatText(var_187_11.content)

				arg_184_1.text_.text = var_187_12

				LuaForUtil.ClearLinePrefixSymbol(arg_184_1.text_)

				local var_187_13 = 24
				local var_187_14 = utf8.len(var_187_12)
				local var_187_15 = var_187_13 <= 0 and var_187_9 or var_187_9 * (var_187_14 / var_187_13)

				if var_187_15 > 0 and var_187_9 < var_187_15 then
					arg_184_1.talkMaxDuration = var_187_15

					if var_187_15 + var_187_8 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_15 + var_187_8
					end
				end

				arg_184_1.text_.text = var_187_12
				arg_184_1.typewritter.percent = 0

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(false)
				arg_184_1:RecordContent(arg_184_1.text_.text)
			end

			local var_187_16 = math.max(var_187_9, arg_184_1.talkMaxDuration)

			if var_187_8 <= arg_184_1.time_ and arg_184_1.time_ < var_187_8 + var_187_16 then
				arg_184_1.typewritter.percent = (arg_184_1.time_ - var_187_8) / var_187_16

				arg_184_1.typewritter:SetDirty()
			end

			if arg_184_1.time_ >= var_187_8 + var_187_16 and arg_184_1.time_ < var_187_8 + var_187_16 + arg_187_0 then
				arg_184_1.typewritter.percent = 1

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(true)
			end
		end

		arg_184_1.nodeConfigList_ = {}

		arg_184_1:InitPlayNodeList()
	end,
	Play424081045 = function(arg_188_0, arg_188_1)
		arg_188_1.time_ = 0
		arg_188_1.frameCnt_ = 0
		arg_188_1.state_ = "playing"
		arg_188_1.curTalkId_ = 424081045
		arg_188_1.duration_ = 4.43

		local var_188_0 = {
			zh = 3.4,
			ja = 4.433
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
				arg_188_0:Play424081046(arg_188_1)
			end
		end

		function arg_188_1.onSingleLineUpdate_(arg_191_0)
			local var_191_0 = arg_188_1.actors_["1094"]
			local var_191_1 = 0

			if var_191_1 < arg_188_1.time_ and arg_188_1.time_ <= var_191_1 + arg_191_0 and not isNil(var_191_0) and arg_188_1.var_.actorSpriteComps1094 == nil then
				arg_188_1.var_.actorSpriteComps1094 = var_191_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_191_2 = 0.2

			if var_191_1 <= arg_188_1.time_ and arg_188_1.time_ < var_191_1 + var_191_2 and not isNil(var_191_0) then
				local var_191_3 = (arg_188_1.time_ - var_191_1) / var_191_2

				if arg_188_1.var_.actorSpriteComps1094 then
					for iter_191_0, iter_191_1 in pairs(arg_188_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_191_1 then
							if arg_188_1.isInRecall_ then
								local var_191_4 = Mathf.Lerp(iter_191_1.color.r, arg_188_1.hightColor1.r, var_191_3)
								local var_191_5 = Mathf.Lerp(iter_191_1.color.g, arg_188_1.hightColor1.g, var_191_3)
								local var_191_6 = Mathf.Lerp(iter_191_1.color.b, arg_188_1.hightColor1.b, var_191_3)

								iter_191_1.color = Color.New(var_191_4, var_191_5, var_191_6)
							else
								local var_191_7 = Mathf.Lerp(iter_191_1.color.r, 1, var_191_3)

								iter_191_1.color = Color.New(var_191_7, var_191_7, var_191_7)
							end
						end
					end
				end
			end

			if arg_188_1.time_ >= var_191_1 + var_191_2 and arg_188_1.time_ < var_191_1 + var_191_2 + arg_191_0 and not isNil(var_191_0) and arg_188_1.var_.actorSpriteComps1094 then
				for iter_191_2, iter_191_3 in pairs(arg_188_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_191_3 then
						if arg_188_1.isInRecall_ then
							iter_191_3.color = arg_188_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_191_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_188_1.var_.actorSpriteComps1094 = nil
			end

			local var_191_8 = arg_188_1.actors_["1094"].transform
			local var_191_9 = 0

			if var_191_9 < arg_188_1.time_ and arg_188_1.time_ <= var_191_9 + arg_191_0 then
				arg_188_1.var_.moveOldPos1094 = var_191_8.localPosition
				var_191_8.localScale = Vector3.New(1, 1, 1)

				arg_188_1:CheckSpriteTmpPos("1094", 3)

				local var_191_10 = var_191_8.childCount

				for iter_191_4 = 0, var_191_10 - 1 do
					local var_191_11 = var_191_8:GetChild(iter_191_4)

					if var_191_11.name == "split_4" then
						var_191_11:SetAsLastSibling()
						var_191_11.gameObject:SetActive(true)

						arg_188_1.var_.actorSpriteSplit1094 = var_191_11.gameObject:GetComponent(typeof(Image))

						arg_188_1.var_.actorSpriteSplit1094:SetAlpha(0)
					end
				end
			end

			local var_191_12 = 0.5

			if var_191_9 <= arg_188_1.time_ and arg_188_1.time_ < var_191_9 + var_191_12 then
				local var_191_13 = (arg_188_1.time_ - var_191_9) / var_191_12
				local var_191_14 = Vector3.New(0, -335, -230)

				var_191_8.localPosition = Vector3.Lerp(arg_188_1.var_.moveOldPos1094, var_191_14, var_191_13)

				if arg_188_1.var_.actorSpriteSplit1094 ~= nil then
					arg_188_1.var_.actorSpriteSplit1094:SetAlpha(var_191_13)
				end
			end

			if arg_188_1.time_ >= var_191_9 + var_191_12 and arg_188_1.time_ < var_191_9 + var_191_12 + arg_191_0 then
				var_191_8.localPosition = Vector3.New(0, -335, -230)

				if arg_188_1.var_.actorSpriteSplit1094 ~= nil then
					arg_188_1.var_.actorSpriteSplit1094:SetAlpha(1)
				end
			end

			local var_191_15 = 0
			local var_191_16 = 0.3

			if var_191_15 < arg_188_1.time_ and arg_188_1.time_ <= var_191_15 + arg_191_0 then
				arg_188_1.talkMaxDuration = 0
				arg_188_1.dialogCg_.alpha = 1

				arg_188_1.dialog_:SetActive(true)
				SetActive(arg_188_1.leftNameGo_, true)

				local var_191_17 = arg_188_1:FormatText(StoryNameCfg[181].name)

				arg_188_1.leftNameTxt_.text = var_191_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_188_1.leftNameTxt_.transform)

				arg_188_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_188_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_188_1:RecordName(arg_188_1.leftNameTxt_.text)
				SetActive(arg_188_1.iconTrs_.gameObject, false)
				arg_188_1.callingController_:SetSelectedState("normal")

				local var_191_18 = arg_188_1:GetWordFromCfg(424081045)
				local var_191_19 = arg_188_1:FormatText(var_191_18.content)

				arg_188_1.text_.text = var_191_19

				LuaForUtil.ClearLinePrefixSymbol(arg_188_1.text_)

				local var_191_20 = 12
				local var_191_21 = utf8.len(var_191_19)
				local var_191_22 = var_191_20 <= 0 and var_191_16 or var_191_16 * (var_191_21 / var_191_20)

				if var_191_22 > 0 and var_191_16 < var_191_22 then
					arg_188_1.talkMaxDuration = var_191_22

					if var_191_22 + var_191_15 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_22 + var_191_15
					end
				end

				arg_188_1.text_.text = var_191_19
				arg_188_1.typewritter.percent = 0

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424081", "424081045", "story_v_out_424081.awb") ~= 0 then
					local var_191_23 = manager.audio:GetVoiceLength("story_v_out_424081", "424081045", "story_v_out_424081.awb") / 1000

					if var_191_23 + var_191_15 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_23 + var_191_15
					end

					if var_191_18.prefab_name ~= "" and arg_188_1.actors_[var_191_18.prefab_name] ~= nil then
						local var_191_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_188_1.actors_[var_191_18.prefab_name].transform, "story_v_out_424081", "424081045", "story_v_out_424081.awb")

						arg_188_1:RecordAudio("424081045", var_191_24)
						arg_188_1:RecordAudio("424081045", var_191_24)
					else
						arg_188_1:AudioAction("play", "voice", "story_v_out_424081", "424081045", "story_v_out_424081.awb")
					end

					arg_188_1:RecordHistoryTalkVoice("story_v_out_424081", "424081045", "story_v_out_424081.awb")
				end

				arg_188_1:RecordContent(arg_188_1.text_.text)
			end

			local var_191_25 = math.max(var_191_16, arg_188_1.talkMaxDuration)

			if var_191_15 <= arg_188_1.time_ and arg_188_1.time_ < var_191_15 + var_191_25 then
				arg_188_1.typewritter.percent = (arg_188_1.time_ - var_191_15) / var_191_25

				arg_188_1.typewritter:SetDirty()
			end

			if arg_188_1.time_ >= var_191_15 + var_191_25 and arg_188_1.time_ < var_191_15 + var_191_25 + arg_191_0 then
				arg_188_1.typewritter.percent = 1

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(true)
			end
		end

		arg_188_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_188_1:InitPlayNodeList()
	end,
	Play424081046 = function(arg_192_0, arg_192_1)
		arg_192_1.time_ = 0
		arg_192_1.frameCnt_ = 0
		arg_192_1.state_ = "playing"
		arg_192_1.curTalkId_ = 424081046
		arg_192_1.duration_ = 5

		SetActive(arg_192_1.tipsGo_, false)

		function arg_192_1.onSingleLineFinish_()
			arg_192_1.onSingleLineUpdate_ = nil
			arg_192_1.onSingleLineFinish_ = nil
			arg_192_1.state_ = "waiting"
		end

		function arg_192_1.playNext_(arg_194_0)
			if arg_194_0 == 1 then
				arg_192_0:Play424081047(arg_192_1)
			end
		end

		function arg_192_1.onSingleLineUpdate_(arg_195_0)
			local var_195_0 = arg_192_1.actors_["1094"]
			local var_195_1 = 0

			if var_195_1 < arg_192_1.time_ and arg_192_1.time_ <= var_195_1 + arg_195_0 and not isNil(var_195_0) and arg_192_1.var_.actorSpriteComps1094 == nil then
				arg_192_1.var_.actorSpriteComps1094 = var_195_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_195_2 = 0.2

			if var_195_1 <= arg_192_1.time_ and arg_192_1.time_ < var_195_1 + var_195_2 and not isNil(var_195_0) then
				local var_195_3 = (arg_192_1.time_ - var_195_1) / var_195_2

				if arg_192_1.var_.actorSpriteComps1094 then
					for iter_195_0, iter_195_1 in pairs(arg_192_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_195_1 then
							if arg_192_1.isInRecall_ then
								local var_195_4 = Mathf.Lerp(iter_195_1.color.r, arg_192_1.hightColor2.r, var_195_3)
								local var_195_5 = Mathf.Lerp(iter_195_1.color.g, arg_192_1.hightColor2.g, var_195_3)
								local var_195_6 = Mathf.Lerp(iter_195_1.color.b, arg_192_1.hightColor2.b, var_195_3)

								iter_195_1.color = Color.New(var_195_4, var_195_5, var_195_6)
							else
								local var_195_7 = Mathf.Lerp(iter_195_1.color.r, 0.5, var_195_3)

								iter_195_1.color = Color.New(var_195_7, var_195_7, var_195_7)
							end
						end
					end
				end
			end

			if arg_192_1.time_ >= var_195_1 + var_195_2 and arg_192_1.time_ < var_195_1 + var_195_2 + arg_195_0 and not isNil(var_195_0) and arg_192_1.var_.actorSpriteComps1094 then
				for iter_195_2, iter_195_3 in pairs(arg_192_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_195_3 then
						if arg_192_1.isInRecall_ then
							iter_195_3.color = arg_192_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_195_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_192_1.var_.actorSpriteComps1094 = nil
			end

			local var_195_8 = 0
			local var_195_9 = 0.65

			if var_195_8 < arg_192_1.time_ and arg_192_1.time_ <= var_195_8 + arg_195_0 then
				arg_192_1.talkMaxDuration = 0
				arg_192_1.dialogCg_.alpha = 1

				arg_192_1.dialog_:SetActive(true)
				SetActive(arg_192_1.leftNameGo_, true)

				local var_195_10 = arg_192_1:FormatText(StoryNameCfg[7].name)

				arg_192_1.leftNameTxt_.text = var_195_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_192_1.leftNameTxt_.transform)

				arg_192_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_192_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_192_1:RecordName(arg_192_1.leftNameTxt_.text)
				SetActive(arg_192_1.iconTrs_.gameObject, true)
				arg_192_1.iconController_:SetSelectedState("hero")

				arg_192_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_192_1.callingController_:SetSelectedState("normal")

				arg_192_1.keyicon_.color = Color.New(1, 1, 1)
				arg_192_1.icon_.color = Color.New(1, 1, 1)

				local var_195_11 = arg_192_1:GetWordFromCfg(424081046)
				local var_195_12 = arg_192_1:FormatText(var_195_11.content)

				arg_192_1.text_.text = var_195_12

				LuaForUtil.ClearLinePrefixSymbol(arg_192_1.text_)

				local var_195_13 = 26
				local var_195_14 = utf8.len(var_195_12)
				local var_195_15 = var_195_13 <= 0 and var_195_9 or var_195_9 * (var_195_14 / var_195_13)

				if var_195_15 > 0 and var_195_9 < var_195_15 then
					arg_192_1.talkMaxDuration = var_195_15

					if var_195_15 + var_195_8 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_15 + var_195_8
					end
				end

				arg_192_1.text_.text = var_195_12
				arg_192_1.typewritter.percent = 0

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(false)
				arg_192_1:RecordContent(arg_192_1.text_.text)
			end

			local var_195_16 = math.max(var_195_9, arg_192_1.talkMaxDuration)

			if var_195_8 <= arg_192_1.time_ and arg_192_1.time_ < var_195_8 + var_195_16 then
				arg_192_1.typewritter.percent = (arg_192_1.time_ - var_195_8) / var_195_16

				arg_192_1.typewritter:SetDirty()
			end

			if arg_192_1.time_ >= var_195_8 + var_195_16 and arg_192_1.time_ < var_195_8 + var_195_16 + arg_195_0 then
				arg_192_1.typewritter.percent = 1

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(true)
			end
		end

		arg_192_1.nodeConfigList_ = {}

		arg_192_1:InitPlayNodeList()
	end,
	Play424081047 = function(arg_196_0, arg_196_1)
		arg_196_1.time_ = 0
		arg_196_1.frameCnt_ = 0
		arg_196_1.state_ = "playing"
		arg_196_1.curTalkId_ = 424081047
		arg_196_1.duration_ = 5

		SetActive(arg_196_1.tipsGo_, false)

		function arg_196_1.onSingleLineFinish_()
			arg_196_1.onSingleLineUpdate_ = nil
			arg_196_1.onSingleLineFinish_ = nil
			arg_196_1.state_ = "waiting"
		end

		function arg_196_1.playNext_(arg_198_0)
			if arg_198_0 == 1 then
				arg_196_0:Play424081048(arg_196_1)
			end
		end

		function arg_196_1.onSingleLineUpdate_(arg_199_0)
			local var_199_0 = arg_196_1.actors_["1094"].transform
			local var_199_1 = 0

			if var_199_1 < arg_196_1.time_ and arg_196_1.time_ <= var_199_1 + arg_199_0 then
				arg_196_1.var_.moveOldPos1094 = var_199_0.localPosition
				var_199_0.localScale = Vector3.New(1, 1, 1)

				arg_196_1:CheckSpriteTmpPos("1094", 7)

				local var_199_2 = var_199_0.childCount

				for iter_199_0 = 0, var_199_2 - 1 do
					local var_199_3 = var_199_0:GetChild(iter_199_0)

					if var_199_3.name == "" or not string.find(var_199_3.name, "split") then
						var_199_3.gameObject:SetActive(true)
					else
						var_199_3.gameObject:SetActive(false)
					end
				end
			end

			local var_199_4 = 0.001

			if var_199_1 <= arg_196_1.time_ and arg_196_1.time_ < var_199_1 + var_199_4 then
				local var_199_5 = (arg_196_1.time_ - var_199_1) / var_199_4
				local var_199_6 = Vector3.New(0, -2000, 0)

				var_199_0.localPosition = Vector3.Lerp(arg_196_1.var_.moveOldPos1094, var_199_6, var_199_5)
			end

			if arg_196_1.time_ >= var_199_1 + var_199_4 and arg_196_1.time_ < var_199_1 + var_199_4 + arg_199_0 then
				var_199_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_199_7 = 0.1
			local var_199_8 = 1

			if var_199_7 < arg_196_1.time_ and arg_196_1.time_ <= var_199_7 + arg_199_0 then
				local var_199_9 = "play"
				local var_199_10 = "effect"

				arg_196_1:AudioAction(var_199_9, var_199_10, "minigame_activity_4_0", "minigame_activity_4_0_pintu_walk01", "")
			end

			local var_199_11 = 0
			local var_199_12 = 0.95

			if var_199_11 < arg_196_1.time_ and arg_196_1.time_ <= var_199_11 + arg_199_0 then
				arg_196_1.talkMaxDuration = 0
				arg_196_1.dialogCg_.alpha = 1

				arg_196_1.dialog_:SetActive(true)
				SetActive(arg_196_1.leftNameGo_, false)

				arg_196_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_196_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_196_1:RecordName(arg_196_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_196_1.iconTrs_.gameObject, false)
				arg_196_1.callingController_:SetSelectedState("normal")

				local var_199_13 = arg_196_1:GetWordFromCfg(424081047)
				local var_199_14 = arg_196_1:FormatText(var_199_13.content)

				arg_196_1.text_.text = var_199_14

				LuaForUtil.ClearLinePrefixSymbol(arg_196_1.text_)

				local var_199_15 = 38
				local var_199_16 = utf8.len(var_199_14)
				local var_199_17 = var_199_15 <= 0 and var_199_12 or var_199_12 * (var_199_16 / var_199_15)

				if var_199_17 > 0 and var_199_12 < var_199_17 then
					arg_196_1.talkMaxDuration = var_199_17

					if var_199_17 + var_199_11 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_17 + var_199_11
					end
				end

				arg_196_1.text_.text = var_199_14
				arg_196_1.typewritter.percent = 0

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(false)
				arg_196_1:RecordContent(arg_196_1.text_.text)
			end

			local var_199_18 = math.max(var_199_12, arg_196_1.talkMaxDuration)

			if var_199_11 <= arg_196_1.time_ and arg_196_1.time_ < var_199_11 + var_199_18 then
				arg_196_1.typewritter.percent = (arg_196_1.time_ - var_199_11) / var_199_18

				arg_196_1.typewritter:SetDirty()
			end

			if arg_196_1.time_ >= var_199_11 + var_199_18 and arg_196_1.time_ < var_199_11 + var_199_18 + arg_199_0 then
				arg_196_1.typewritter.percent = 1

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(true)
			end
		end

		arg_196_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094",
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
	Play424081048 = function(arg_200_0, arg_200_1)
		arg_200_1.time_ = 0
		arg_200_1.frameCnt_ = 0
		arg_200_1.state_ = "playing"
		arg_200_1.curTalkId_ = 424081048
		arg_200_1.duration_ = 9

		SetActive(arg_200_1.tipsGo_, false)

		function arg_200_1.onSingleLineFinish_()
			arg_200_1.onSingleLineUpdate_ = nil
			arg_200_1.onSingleLineFinish_ = nil
			arg_200_1.state_ = "waiting"
		end

		function arg_200_1.playNext_(arg_202_0)
			if arg_202_0 == 1 then
				arg_200_0:Play424081049(arg_200_1)
			end
		end

		function arg_200_1.onSingleLineUpdate_(arg_203_0)
			local var_203_0 = 2

			if var_203_0 < arg_200_1.time_ and arg_200_1.time_ <= var_203_0 + arg_203_0 then
				local var_203_1 = manager.ui.mainCamera.transform.localPosition
				local var_203_2 = Vector3.New(0, 0, 10) + Vector3.New(var_203_1.x, var_203_1.y, 0)
				local var_203_3 = arg_200_1.bgs_.STblack

				var_203_3.transform.localPosition = var_203_2
				var_203_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_203_4 = var_203_3:GetComponent("SpriteRenderer")

				if var_203_4 and var_203_4.sprite then
					local var_203_5 = (var_203_3.transform.localPosition - var_203_1).z
					local var_203_6 = manager.ui.mainCameraCom_
					local var_203_7 = 2 * var_203_5 * Mathf.Tan(var_203_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_203_8 = var_203_7 * var_203_6.aspect
					local var_203_9 = var_203_4.sprite.bounds.size.x
					local var_203_10 = var_203_4.sprite.bounds.size.y
					local var_203_11 = var_203_8 / var_203_9
					local var_203_12 = var_203_7 / var_203_10
					local var_203_13 = var_203_12 < var_203_11 and var_203_11 or var_203_12

					var_203_3.transform.localScale = Vector3.New(var_203_13, var_203_13, 0)
				end

				for iter_203_0, iter_203_1 in pairs(arg_200_1.bgs_) do
					if iter_203_0 ~= "STblack" then
						iter_203_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_203_14 = 4

			if var_203_14 < arg_200_1.time_ and arg_200_1.time_ <= var_203_14 + arg_203_0 then
				arg_200_1.allBtn_.enabled = false
			end

			local var_203_15 = 0.3

			if arg_200_1.time_ >= var_203_14 + var_203_15 and arg_200_1.time_ < var_203_14 + var_203_15 + arg_203_0 then
				arg_200_1.allBtn_.enabled = true
			end

			local var_203_16 = 0

			if var_203_16 < arg_200_1.time_ and arg_200_1.time_ <= var_203_16 + arg_203_0 then
				arg_200_1.mask_.enabled = true
				arg_200_1.mask_.raycastTarget = true

				arg_200_1:SetGaussion(false)
			end

			local var_203_17 = 2

			if var_203_16 <= arg_200_1.time_ and arg_200_1.time_ < var_203_16 + var_203_17 then
				local var_203_18 = (arg_200_1.time_ - var_203_16) / var_203_17
				local var_203_19 = Color.New(0, 0, 0)

				var_203_19.a = Mathf.Lerp(0, 1, var_203_18)
				arg_200_1.mask_.color = var_203_19
			end

			if arg_200_1.time_ >= var_203_16 + var_203_17 and arg_200_1.time_ < var_203_16 + var_203_17 + arg_203_0 then
				local var_203_20 = Color.New(0, 0, 0)

				var_203_20.a = 1
				arg_200_1.mask_.color = var_203_20
			end

			local var_203_21 = 2

			if var_203_21 < arg_200_1.time_ and arg_200_1.time_ <= var_203_21 + arg_203_0 then
				arg_200_1.mask_.enabled = true
				arg_200_1.mask_.raycastTarget = true

				arg_200_1:SetGaussion(false)
			end

			local var_203_22 = 2

			if var_203_21 <= arg_200_1.time_ and arg_200_1.time_ < var_203_21 + var_203_22 then
				local var_203_23 = (arg_200_1.time_ - var_203_21) / var_203_22
				local var_203_24 = Color.New(0, 0, 0)

				var_203_24.a = Mathf.Lerp(1, 0, var_203_23)
				arg_200_1.mask_.color = var_203_24
			end

			if arg_200_1.time_ >= var_203_21 + var_203_22 and arg_200_1.time_ < var_203_21 + var_203_22 + arg_203_0 then
				local var_203_25 = Color.New(0, 0, 0)
				local var_203_26 = 0

				arg_200_1.mask_.enabled = false
				var_203_25.a = var_203_26
				arg_200_1.mask_.color = var_203_25
			end

			local var_203_27 = 0.5
			local var_203_28 = 1

			if var_203_27 < arg_200_1.time_ and arg_200_1.time_ <= var_203_27 + arg_203_0 then
				local var_203_29 = "stop"
				local var_203_30 = "effect"

				arg_200_1:AudioAction(var_203_29, var_203_30, "se_story_140", "se_story_140_amb_room01", "")
			end

			if arg_200_1.frameCnt_ <= 1 then
				arg_200_1.dialog_:SetActive(false)
			end

			local var_203_31 = 4
			local var_203_32 = 1.5

			if var_203_31 < arg_200_1.time_ and arg_200_1.time_ <= var_203_31 + arg_203_0 then
				arg_200_1.talkMaxDuration = 0

				arg_200_1.dialog_:SetActive(true)

				arg_200_1.dialogCg_.alpha = 0

				local var_203_33 = LeanTween.value(arg_200_1.dialog_, 0, 1, 0.3)

				var_203_33:setOnUpdate(LuaHelper.FloatAction(function(arg_204_0)
					arg_200_1.dialogCg_.alpha = arg_204_0
				end))
				var_203_33:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_200_1.dialog_)
					var_203_33:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_200_1.duration_ = arg_200_1.duration_ + 0.3

				SetActive(arg_200_1.leftNameGo_, false)

				arg_200_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_200_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_200_1:RecordName(arg_200_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_200_1.iconTrs_.gameObject, false)
				arg_200_1.callingController_:SetSelectedState("normal")

				local var_203_34 = arg_200_1:GetWordFromCfg(424081048)
				local var_203_35 = arg_200_1:FormatText(var_203_34.content)

				arg_200_1.text_.text = var_203_35

				LuaForUtil.ClearLinePrefixSymbol(arg_200_1.text_)

				local var_203_36 = 60
				local var_203_37 = utf8.len(var_203_35)
				local var_203_38 = var_203_36 <= 0 and var_203_32 or var_203_32 * (var_203_37 / var_203_36)

				if var_203_38 > 0 and var_203_32 < var_203_38 then
					arg_200_1.talkMaxDuration = var_203_38
					var_203_31 = var_203_31 + 0.3

					if var_203_38 + var_203_31 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_38 + var_203_31
					end
				end

				arg_200_1.text_.text = var_203_35
				arg_200_1.typewritter.percent = 0

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(false)
				arg_200_1:RecordContent(arg_200_1.text_.text)
			end

			local var_203_39 = var_203_31 + 0.3
			local var_203_40 = math.max(var_203_32, arg_200_1.talkMaxDuration)

			if var_203_39 <= arg_200_1.time_ and arg_200_1.time_ < var_203_39 + var_203_40 then
				arg_200_1.typewritter.percent = (arg_200_1.time_ - var_203_39) / var_203_40

				arg_200_1.typewritter:SetDirty()
			end

			if arg_200_1.time_ >= var_203_39 + var_203_40 and arg_200_1.time_ < var_203_39 + var_203_40 + arg_203_0 then
				arg_200_1.typewritter.percent = 1

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(true)
			end
		end

		arg_200_1.nodeConfigList_ = {}

		arg_200_1:InitPlayNodeList()
	end,
	Play424081049 = function(arg_206_0, arg_206_1)
		arg_206_1.time_ = 0
		arg_206_1.frameCnt_ = 0
		arg_206_1.state_ = "playing"
		arg_206_1.curTalkId_ = 424081049
		arg_206_1.duration_ = 5

		SetActive(arg_206_1.tipsGo_, false)

		function arg_206_1.onSingleLineFinish_()
			arg_206_1.onSingleLineUpdate_ = nil
			arg_206_1.onSingleLineFinish_ = nil
			arg_206_1.state_ = "waiting"
		end

		function arg_206_1.playNext_(arg_208_0)
			if arg_208_0 == 1 then
				arg_206_0:Play424081050(arg_206_1)
			end
		end

		function arg_206_1.onSingleLineUpdate_(arg_209_0)
			local var_209_0 = 0
			local var_209_1 = 1.075

			if var_209_0 < arg_206_1.time_ and arg_206_1.time_ <= var_209_0 + arg_209_0 then
				arg_206_1.talkMaxDuration = 0
				arg_206_1.dialogCg_.alpha = 1

				arg_206_1.dialog_:SetActive(true)
				SetActive(arg_206_1.leftNameGo_, false)

				arg_206_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_206_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_206_1:RecordName(arg_206_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_206_1.iconTrs_.gameObject, false)
				arg_206_1.callingController_:SetSelectedState("normal")

				local var_209_2 = arg_206_1:GetWordFromCfg(424081049)
				local var_209_3 = arg_206_1:FormatText(var_209_2.content)

				arg_206_1.text_.text = var_209_3

				LuaForUtil.ClearLinePrefixSymbol(arg_206_1.text_)

				local var_209_4 = 43
				local var_209_5 = utf8.len(var_209_3)
				local var_209_6 = var_209_4 <= 0 and var_209_1 or var_209_1 * (var_209_5 / var_209_4)

				if var_209_6 > 0 and var_209_1 < var_209_6 then
					arg_206_1.talkMaxDuration = var_209_6

					if var_209_6 + var_209_0 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_6 + var_209_0
					end
				end

				arg_206_1.text_.text = var_209_3
				arg_206_1.typewritter.percent = 0

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(false)
				arg_206_1:RecordContent(arg_206_1.text_.text)
			end

			local var_209_7 = math.max(var_209_1, arg_206_1.talkMaxDuration)

			if var_209_0 <= arg_206_1.time_ and arg_206_1.time_ < var_209_0 + var_209_7 then
				arg_206_1.typewritter.percent = (arg_206_1.time_ - var_209_0) / var_209_7

				arg_206_1.typewritter:SetDirty()
			end

			if arg_206_1.time_ >= var_209_0 + var_209_7 and arg_206_1.time_ < var_209_0 + var_209_7 + arg_209_0 then
				arg_206_1.typewritter.percent = 1

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(true)
			end
		end

		arg_206_1.nodeConfigList_ = {}

		arg_206_1:InitPlayNodeList()
	end,
	Play424081050 = function(arg_210_0, arg_210_1)
		arg_210_1.time_ = 0
		arg_210_1.frameCnt_ = 0
		arg_210_1.state_ = "playing"
		arg_210_1.curTalkId_ = 424081050
		arg_210_1.duration_ = 5

		SetActive(arg_210_1.tipsGo_, false)

		function arg_210_1.onSingleLineFinish_()
			arg_210_1.onSingleLineUpdate_ = nil
			arg_210_1.onSingleLineFinish_ = nil
			arg_210_1.state_ = "waiting"
		end

		function arg_210_1.playNext_(arg_212_0)
			if arg_212_0 == 1 then
				arg_210_0:Play424081051(arg_210_1)
			end
		end

		function arg_210_1.onSingleLineUpdate_(arg_213_0)
			local var_213_0 = 0
			local var_213_1 = 0.875

			if var_213_0 < arg_210_1.time_ and arg_210_1.time_ <= var_213_0 + arg_213_0 then
				arg_210_1.talkMaxDuration = 0
				arg_210_1.dialogCg_.alpha = 1

				arg_210_1.dialog_:SetActive(true)
				SetActive(arg_210_1.leftNameGo_, false)

				arg_210_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_210_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_210_1:RecordName(arg_210_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_210_1.iconTrs_.gameObject, false)
				arg_210_1.callingController_:SetSelectedState("normal")

				local var_213_2 = arg_210_1:GetWordFromCfg(424081050)
				local var_213_3 = arg_210_1:FormatText(var_213_2.content)

				arg_210_1.text_.text = var_213_3

				LuaForUtil.ClearLinePrefixSymbol(arg_210_1.text_)

				local var_213_4 = 35
				local var_213_5 = utf8.len(var_213_3)
				local var_213_6 = var_213_4 <= 0 and var_213_1 or var_213_1 * (var_213_5 / var_213_4)

				if var_213_6 > 0 and var_213_1 < var_213_6 then
					arg_210_1.talkMaxDuration = var_213_6

					if var_213_6 + var_213_0 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_6 + var_213_0
					end
				end

				arg_210_1.text_.text = var_213_3
				arg_210_1.typewritter.percent = 0

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(false)
				arg_210_1:RecordContent(arg_210_1.text_.text)
			end

			local var_213_7 = math.max(var_213_1, arg_210_1.talkMaxDuration)

			if var_213_0 <= arg_210_1.time_ and arg_210_1.time_ < var_213_0 + var_213_7 then
				arg_210_1.typewritter.percent = (arg_210_1.time_ - var_213_0) / var_213_7

				arg_210_1.typewritter:SetDirty()
			end

			if arg_210_1.time_ >= var_213_0 + var_213_7 and arg_210_1.time_ < var_213_0 + var_213_7 + arg_213_0 then
				arg_210_1.typewritter.percent = 1

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(true)
			end
		end

		arg_210_1.nodeConfigList_ = {}

		arg_210_1:InitPlayNodeList()
	end,
	Play424081051 = function(arg_214_0, arg_214_1)
		arg_214_1.time_ = 0
		arg_214_1.frameCnt_ = 0
		arg_214_1.state_ = "playing"
		arg_214_1.curTalkId_ = 424081051
		arg_214_1.duration_ = 6.97

		local var_214_0 = {
			zh = 4.966,
			ja = 6.966
		}
		local var_214_1 = manager.audio:GetLocalizationFlag()

		if var_214_0[var_214_1] ~= nil then
			arg_214_1.duration_ = var_214_0[var_214_1]
		end

		SetActive(arg_214_1.tipsGo_, false)

		function arg_214_1.onSingleLineFinish_()
			arg_214_1.onSingleLineUpdate_ = nil
			arg_214_1.onSingleLineFinish_ = nil
			arg_214_1.state_ = "waiting"
		end

		function arg_214_1.playNext_(arg_216_0)
			if arg_216_0 == 1 then
				arg_214_0:Play424081052(arg_214_1)
			end
		end

		function arg_214_1.onSingleLineUpdate_(arg_217_0)
			local var_217_0 = 0

			if var_217_0 < arg_214_1.time_ and arg_214_1.time_ <= var_217_0 + arg_217_0 then
				local var_217_1 = manager.ui.mainCamera.transform.localPosition
				local var_217_2 = Vector3.New(0, 0, 10) + Vector3.New(var_217_1.x, var_217_1.y, 0)
				local var_217_3 = arg_214_1.bgs_.ST0115

				var_217_3.transform.localPosition = var_217_2
				var_217_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_217_4 = var_217_3:GetComponent("SpriteRenderer")

				if var_217_4 and var_217_4.sprite then
					local var_217_5 = (var_217_3.transform.localPosition - var_217_1).z
					local var_217_6 = manager.ui.mainCameraCom_
					local var_217_7 = 2 * var_217_5 * Mathf.Tan(var_217_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_217_8 = var_217_7 * var_217_6.aspect
					local var_217_9 = var_217_4.sprite.bounds.size.x
					local var_217_10 = var_217_4.sprite.bounds.size.y
					local var_217_11 = var_217_8 / var_217_9
					local var_217_12 = var_217_7 / var_217_10
					local var_217_13 = var_217_12 < var_217_11 and var_217_11 or var_217_12

					var_217_3.transform.localScale = Vector3.New(var_217_13, var_217_13, 0)
				end

				for iter_217_0, iter_217_1 in pairs(arg_214_1.bgs_) do
					if iter_217_0 ~= "ST0115" then
						iter_217_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_217_14 = 2

			if var_217_14 < arg_214_1.time_ and arg_214_1.time_ <= var_217_14 + arg_217_0 then
				arg_214_1.allBtn_.enabled = false
			end

			local var_217_15 = 0.3

			if arg_214_1.time_ >= var_217_14 + var_217_15 and arg_214_1.time_ < var_217_14 + var_217_15 + arg_217_0 then
				arg_214_1.allBtn_.enabled = true
			end

			local var_217_16 = 0

			if var_217_16 < arg_214_1.time_ and arg_214_1.time_ <= var_217_16 + arg_217_0 then
				arg_214_1.mask_.enabled = true
				arg_214_1.mask_.raycastTarget = true

				arg_214_1:SetGaussion(false)
			end

			local var_217_17 = 2

			if var_217_16 <= arg_214_1.time_ and arg_214_1.time_ < var_217_16 + var_217_17 then
				local var_217_18 = (arg_214_1.time_ - var_217_16) / var_217_17
				local var_217_19 = Color.New(0, 0, 0)

				var_217_19.a = Mathf.Lerp(1, 0, var_217_18)
				arg_214_1.mask_.color = var_217_19
			end

			if arg_214_1.time_ >= var_217_16 + var_217_17 and arg_214_1.time_ < var_217_16 + var_217_17 + arg_217_0 then
				local var_217_20 = Color.New(0, 0, 0)
				local var_217_21 = 0

				arg_214_1.mask_.enabled = false
				var_217_20.a = var_217_21
				arg_214_1.mask_.color = var_217_20
			end

			local var_217_22 = "10154"

			if arg_214_1.actors_[var_217_22] == nil then
				local var_217_23 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10154")

				if not isNil(var_217_23) then
					local var_217_24 = Object.Instantiate(var_217_23, arg_214_1.canvasGo_.transform)

					var_217_24.transform:SetSiblingIndex(1)

					var_217_24.name = var_217_22
					var_217_24.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_214_1.actors_[var_217_22] = var_217_24

					local var_217_25 = var_217_24:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_214_1.isInRecall_ then
						for iter_217_2, iter_217_3 in ipairs(var_217_25) do
							iter_217_3.color = arg_214_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_217_26 = arg_214_1.actors_["10154"]
			local var_217_27 = 2

			if var_217_27 < arg_214_1.time_ and arg_214_1.time_ <= var_217_27 + arg_217_0 and not isNil(var_217_26) and arg_214_1.var_.actorSpriteComps10154 == nil then
				arg_214_1.var_.actorSpriteComps10154 = var_217_26:GetComponentsInChildren(typeof(Image), true)
			end

			local var_217_28 = 0.2

			if var_217_27 <= arg_214_1.time_ and arg_214_1.time_ < var_217_27 + var_217_28 and not isNil(var_217_26) then
				local var_217_29 = (arg_214_1.time_ - var_217_27) / var_217_28

				if arg_214_1.var_.actorSpriteComps10154 then
					for iter_217_4, iter_217_5 in pairs(arg_214_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_217_5 then
							if arg_214_1.isInRecall_ then
								local var_217_30 = Mathf.Lerp(iter_217_5.color.r, arg_214_1.hightColor1.r, var_217_29)
								local var_217_31 = Mathf.Lerp(iter_217_5.color.g, arg_214_1.hightColor1.g, var_217_29)
								local var_217_32 = Mathf.Lerp(iter_217_5.color.b, arg_214_1.hightColor1.b, var_217_29)

								iter_217_5.color = Color.New(var_217_30, var_217_31, var_217_32)
							else
								local var_217_33 = Mathf.Lerp(iter_217_5.color.r, 1, var_217_29)

								iter_217_5.color = Color.New(var_217_33, var_217_33, var_217_33)
							end
						end
					end
				end
			end

			if arg_214_1.time_ >= var_217_27 + var_217_28 and arg_214_1.time_ < var_217_27 + var_217_28 + arg_217_0 and not isNil(var_217_26) and arg_214_1.var_.actorSpriteComps10154 then
				for iter_217_6, iter_217_7 in pairs(arg_214_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_217_7 then
						if arg_214_1.isInRecall_ then
							iter_217_7.color = arg_214_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_217_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_214_1.var_.actorSpriteComps10154 = nil
			end

			local var_217_34 = arg_214_1.actors_["10154"].transform
			local var_217_35 = 2

			if var_217_35 < arg_214_1.time_ and arg_214_1.time_ <= var_217_35 + arg_217_0 then
				arg_214_1.var_.moveOldPos10154 = var_217_34.localPosition
				var_217_34.localScale = Vector3.New(1, 1, 1)

				arg_214_1:CheckSpriteTmpPos("10154", 3)

				local var_217_36 = var_217_34.childCount

				for iter_217_8 = 0, var_217_36 - 1 do
					local var_217_37 = var_217_34:GetChild(iter_217_8)

					if var_217_37.name == "split_4" or not string.find(var_217_37.name, "split") then
						var_217_37.gameObject:SetActive(true)
					else
						var_217_37.gameObject:SetActive(false)
					end
				end
			end

			local var_217_38 = 0.001

			if var_217_35 <= arg_214_1.time_ and arg_214_1.time_ < var_217_35 + var_217_38 then
				local var_217_39 = (arg_214_1.time_ - var_217_35) / var_217_38
				local var_217_40 = Vector3.New(-20, -338, -538)

				var_217_34.localPosition = Vector3.Lerp(arg_214_1.var_.moveOldPos10154, var_217_40, var_217_39)
			end

			if arg_214_1.time_ >= var_217_35 + var_217_38 and arg_214_1.time_ < var_217_35 + var_217_38 + arg_217_0 then
				var_217_34.localPosition = Vector3.New(-20, -338, -538)
			end

			local var_217_41 = 0.258331506978721
			local var_217_42 = 1

			if var_217_41 < arg_214_1.time_ and arg_214_1.time_ <= var_217_41 + arg_217_0 then
				local var_217_43 = "play"
				local var_217_44 = "effect"

				arg_214_1:AudioAction(var_217_43, var_217_44, "se_story_140", "se_story_140_amb_room01", "")
			end

			if arg_214_1.frameCnt_ <= 1 then
				arg_214_1.dialog_:SetActive(false)
			end

			local var_217_45 = 2
			local var_217_46 = 0.25

			if var_217_45 < arg_214_1.time_ and arg_214_1.time_ <= var_217_45 + arg_217_0 then
				arg_214_1.talkMaxDuration = 0

				arg_214_1.dialog_:SetActive(true)

				arg_214_1.dialogCg_.alpha = 0

				local var_217_47 = LeanTween.value(arg_214_1.dialog_, 0, 1, 0.3)

				var_217_47:setOnUpdate(LuaHelper.FloatAction(function(arg_218_0)
					arg_214_1.dialogCg_.alpha = arg_218_0
				end))
				var_217_47:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_214_1.dialog_)
					var_217_47:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_214_1.duration_ = arg_214_1.duration_ + 0.3

				SetActive(arg_214_1.leftNameGo_, true)

				local var_217_48 = arg_214_1:FormatText(StoryNameCfg[1392].name)

				arg_214_1.leftNameTxt_.text = var_217_48

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_214_1.leftNameTxt_.transform)

				arg_214_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_214_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_214_1:RecordName(arg_214_1.leftNameTxt_.text)
				SetActive(arg_214_1.iconTrs_.gameObject, false)
				arg_214_1.callingController_:SetSelectedState("normal")

				local var_217_49 = arg_214_1:GetWordFromCfg(424081051)
				local var_217_50 = arg_214_1:FormatText(var_217_49.content)

				arg_214_1.text_.text = var_217_50

				LuaForUtil.ClearLinePrefixSymbol(arg_214_1.text_)

				local var_217_51 = 10
				local var_217_52 = utf8.len(var_217_50)
				local var_217_53 = var_217_51 <= 0 and var_217_46 or var_217_46 * (var_217_52 / var_217_51)

				if var_217_53 > 0 and var_217_46 < var_217_53 then
					arg_214_1.talkMaxDuration = var_217_53
					var_217_45 = var_217_45 + 0.3

					if var_217_53 + var_217_45 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_53 + var_217_45
					end
				end

				arg_214_1.text_.text = var_217_50
				arg_214_1.typewritter.percent = 0

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424081", "424081051", "story_v_out_424081.awb") ~= 0 then
					local var_217_54 = manager.audio:GetVoiceLength("story_v_out_424081", "424081051", "story_v_out_424081.awb") / 1000

					if var_217_54 + var_217_45 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_54 + var_217_45
					end

					if var_217_49.prefab_name ~= "" and arg_214_1.actors_[var_217_49.prefab_name] ~= nil then
						local var_217_55 = LuaForUtil.PlayVoiceWithCriLipsync(arg_214_1.actors_[var_217_49.prefab_name].transform, "story_v_out_424081", "424081051", "story_v_out_424081.awb")

						arg_214_1:RecordAudio("424081051", var_217_55)
						arg_214_1:RecordAudio("424081051", var_217_55)
					else
						arg_214_1:AudioAction("play", "voice", "story_v_out_424081", "424081051", "story_v_out_424081.awb")
					end

					arg_214_1:RecordHistoryTalkVoice("story_v_out_424081", "424081051", "story_v_out_424081.awb")
				end

				arg_214_1:RecordContent(arg_214_1.text_.text)
			end

			local var_217_56 = var_217_45 + 0.3
			local var_217_57 = math.max(var_217_46, arg_214_1.talkMaxDuration)

			if var_217_56 <= arg_214_1.time_ and arg_214_1.time_ < var_217_56 + var_217_57 then
				arg_214_1.typewritter.percent = (arg_214_1.time_ - var_217_56) / var_217_57

				arg_214_1.typewritter:SetDirty()
			end

			if arg_214_1.time_ >= var_217_56 + var_217_57 and arg_214_1.time_ < var_217_56 + var_217_57 + arg_217_0 then
				arg_214_1.typewritter.percent = 1

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(true)
			end
		end

		arg_214_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10154",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_214_1:InitPlayNodeList()
	end,
	Play424081052 = function(arg_220_0, arg_220_1)
		arg_220_1.time_ = 0
		arg_220_1.frameCnt_ = 0
		arg_220_1.state_ = "playing"
		arg_220_1.curTalkId_ = 424081052
		arg_220_1.duration_ = 5

		SetActive(arg_220_1.tipsGo_, false)

		function arg_220_1.onSingleLineFinish_()
			arg_220_1.onSingleLineUpdate_ = nil
			arg_220_1.onSingleLineFinish_ = nil
			arg_220_1.state_ = "waiting"
		end

		function arg_220_1.playNext_(arg_222_0)
			if arg_222_0 == 1 then
				arg_220_0:Play424081053(arg_220_1)
			end
		end

		function arg_220_1.onSingleLineUpdate_(arg_223_0)
			local var_223_0 = arg_220_1.actors_["10154"]
			local var_223_1 = 0

			if var_223_1 < arg_220_1.time_ and arg_220_1.time_ <= var_223_1 + arg_223_0 and not isNil(var_223_0) and arg_220_1.var_.actorSpriteComps10154 == nil then
				arg_220_1.var_.actorSpriteComps10154 = var_223_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_223_2 = 0.2

			if var_223_1 <= arg_220_1.time_ and arg_220_1.time_ < var_223_1 + var_223_2 and not isNil(var_223_0) then
				local var_223_3 = (arg_220_1.time_ - var_223_1) / var_223_2

				if arg_220_1.var_.actorSpriteComps10154 then
					for iter_223_0, iter_223_1 in pairs(arg_220_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_223_1 then
							if arg_220_1.isInRecall_ then
								local var_223_4 = Mathf.Lerp(iter_223_1.color.r, arg_220_1.hightColor2.r, var_223_3)
								local var_223_5 = Mathf.Lerp(iter_223_1.color.g, arg_220_1.hightColor2.g, var_223_3)
								local var_223_6 = Mathf.Lerp(iter_223_1.color.b, arg_220_1.hightColor2.b, var_223_3)

								iter_223_1.color = Color.New(var_223_4, var_223_5, var_223_6)
							else
								local var_223_7 = Mathf.Lerp(iter_223_1.color.r, 0.5, var_223_3)

								iter_223_1.color = Color.New(var_223_7, var_223_7, var_223_7)
							end
						end
					end
				end
			end

			if arg_220_1.time_ >= var_223_1 + var_223_2 and arg_220_1.time_ < var_223_1 + var_223_2 + arg_223_0 and not isNil(var_223_0) and arg_220_1.var_.actorSpriteComps10154 then
				for iter_223_2, iter_223_3 in pairs(arg_220_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_223_3 then
						if arg_220_1.isInRecall_ then
							iter_223_3.color = arg_220_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_223_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_220_1.var_.actorSpriteComps10154 = nil
			end

			local var_223_8 = 0
			local var_223_9 = 0.625

			if var_223_8 < arg_220_1.time_ and arg_220_1.time_ <= var_223_8 + arg_223_0 then
				arg_220_1.talkMaxDuration = 0
				arg_220_1.dialogCg_.alpha = 1

				arg_220_1.dialog_:SetActive(true)
				SetActive(arg_220_1.leftNameGo_, true)

				local var_223_10 = arg_220_1:FormatText(StoryNameCfg[7].name)

				arg_220_1.leftNameTxt_.text = var_223_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_220_1.leftNameTxt_.transform)

				arg_220_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_220_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_220_1:RecordName(arg_220_1.leftNameTxt_.text)
				SetActive(arg_220_1.iconTrs_.gameObject, true)
				arg_220_1.iconController_:SetSelectedState("hero")

				arg_220_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_220_1.callingController_:SetSelectedState("normal")

				arg_220_1.keyicon_.color = Color.New(1, 1, 1)
				arg_220_1.icon_.color = Color.New(1, 1, 1)

				local var_223_11 = arg_220_1:GetWordFromCfg(424081052)
				local var_223_12 = arg_220_1:FormatText(var_223_11.content)

				arg_220_1.text_.text = var_223_12

				LuaForUtil.ClearLinePrefixSymbol(arg_220_1.text_)

				local var_223_13 = 25
				local var_223_14 = utf8.len(var_223_12)
				local var_223_15 = var_223_13 <= 0 and var_223_9 or var_223_9 * (var_223_14 / var_223_13)

				if var_223_15 > 0 and var_223_9 < var_223_15 then
					arg_220_1.talkMaxDuration = var_223_15

					if var_223_15 + var_223_8 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_15 + var_223_8
					end
				end

				arg_220_1.text_.text = var_223_12
				arg_220_1.typewritter.percent = 0

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(false)
				arg_220_1:RecordContent(arg_220_1.text_.text)
			end

			local var_223_16 = math.max(var_223_9, arg_220_1.talkMaxDuration)

			if var_223_8 <= arg_220_1.time_ and arg_220_1.time_ < var_223_8 + var_223_16 then
				arg_220_1.typewritter.percent = (arg_220_1.time_ - var_223_8) / var_223_16

				arg_220_1.typewritter:SetDirty()
			end

			if arg_220_1.time_ >= var_223_8 + var_223_16 and arg_220_1.time_ < var_223_8 + var_223_16 + arg_223_0 then
				arg_220_1.typewritter.percent = 1

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(true)
			end
		end

		arg_220_1.nodeConfigList_ = {}

		arg_220_1:InitPlayNodeList()
	end,
	Play424081053 = function(arg_224_0, arg_224_1)
		arg_224_1.time_ = 0
		arg_224_1.frameCnt_ = 0
		arg_224_1.state_ = "playing"
		arg_224_1.curTalkId_ = 424081053
		arg_224_1.duration_ = 9.73

		local var_224_0 = {
			zh = 7.3,
			ja = 9.733
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
				arg_224_0:Play424081054(arg_224_1)
			end
		end

		function arg_224_1.onSingleLineUpdate_(arg_227_0)
			local var_227_0 = arg_224_1.actors_["10154"]
			local var_227_1 = 0

			if var_227_1 < arg_224_1.time_ and arg_224_1.time_ <= var_227_1 + arg_227_0 and not isNil(var_227_0) and arg_224_1.var_.actorSpriteComps10154 == nil then
				arg_224_1.var_.actorSpriteComps10154 = var_227_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_227_2 = 0.2

			if var_227_1 <= arg_224_1.time_ and arg_224_1.time_ < var_227_1 + var_227_2 and not isNil(var_227_0) then
				local var_227_3 = (arg_224_1.time_ - var_227_1) / var_227_2

				if arg_224_1.var_.actorSpriteComps10154 then
					for iter_227_0, iter_227_1 in pairs(arg_224_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_227_1 then
							if arg_224_1.isInRecall_ then
								local var_227_4 = Mathf.Lerp(iter_227_1.color.r, arg_224_1.hightColor1.r, var_227_3)
								local var_227_5 = Mathf.Lerp(iter_227_1.color.g, arg_224_1.hightColor1.g, var_227_3)
								local var_227_6 = Mathf.Lerp(iter_227_1.color.b, arg_224_1.hightColor1.b, var_227_3)

								iter_227_1.color = Color.New(var_227_4, var_227_5, var_227_6)
							else
								local var_227_7 = Mathf.Lerp(iter_227_1.color.r, 1, var_227_3)

								iter_227_1.color = Color.New(var_227_7, var_227_7, var_227_7)
							end
						end
					end
				end
			end

			if arg_224_1.time_ >= var_227_1 + var_227_2 and arg_224_1.time_ < var_227_1 + var_227_2 + arg_227_0 and not isNil(var_227_0) and arg_224_1.var_.actorSpriteComps10154 then
				for iter_227_2, iter_227_3 in pairs(arg_224_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_227_3 then
						if arg_224_1.isInRecall_ then
							iter_227_3.color = arg_224_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_227_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_224_1.var_.actorSpriteComps10154 = nil
			end

			local var_227_8 = 0
			local var_227_9 = 0.625

			if var_227_8 < arg_224_1.time_ and arg_224_1.time_ <= var_227_8 + arg_227_0 then
				arg_224_1.talkMaxDuration = 0
				arg_224_1.dialogCg_.alpha = 1

				arg_224_1.dialog_:SetActive(true)
				SetActive(arg_224_1.leftNameGo_, true)

				local var_227_10 = arg_224_1:FormatText(StoryNameCfg[1392].name)

				arg_224_1.leftNameTxt_.text = var_227_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_224_1.leftNameTxt_.transform)

				arg_224_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_224_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_224_1:RecordName(arg_224_1.leftNameTxt_.text)
				SetActive(arg_224_1.iconTrs_.gameObject, false)
				arg_224_1.callingController_:SetSelectedState("normal")

				local var_227_11 = arg_224_1:GetWordFromCfg(424081053)
				local var_227_12 = arg_224_1:FormatText(var_227_11.content)

				arg_224_1.text_.text = var_227_12

				LuaForUtil.ClearLinePrefixSymbol(arg_224_1.text_)

				local var_227_13 = 25
				local var_227_14 = utf8.len(var_227_12)
				local var_227_15 = var_227_13 <= 0 and var_227_9 or var_227_9 * (var_227_14 / var_227_13)

				if var_227_15 > 0 and var_227_9 < var_227_15 then
					arg_224_1.talkMaxDuration = var_227_15

					if var_227_15 + var_227_8 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_15 + var_227_8
					end
				end

				arg_224_1.text_.text = var_227_12
				arg_224_1.typewritter.percent = 0

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424081", "424081053", "story_v_out_424081.awb") ~= 0 then
					local var_227_16 = manager.audio:GetVoiceLength("story_v_out_424081", "424081053", "story_v_out_424081.awb") / 1000

					if var_227_16 + var_227_8 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_16 + var_227_8
					end

					if var_227_11.prefab_name ~= "" and arg_224_1.actors_[var_227_11.prefab_name] ~= nil then
						local var_227_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_224_1.actors_[var_227_11.prefab_name].transform, "story_v_out_424081", "424081053", "story_v_out_424081.awb")

						arg_224_1:RecordAudio("424081053", var_227_17)
						arg_224_1:RecordAudio("424081053", var_227_17)
					else
						arg_224_1:AudioAction("play", "voice", "story_v_out_424081", "424081053", "story_v_out_424081.awb")
					end

					arg_224_1:RecordHistoryTalkVoice("story_v_out_424081", "424081053", "story_v_out_424081.awb")
				end

				arg_224_1:RecordContent(arg_224_1.text_.text)
			end

			local var_227_18 = math.max(var_227_9, arg_224_1.talkMaxDuration)

			if var_227_8 <= arg_224_1.time_ and arg_224_1.time_ < var_227_8 + var_227_18 then
				arg_224_1.typewritter.percent = (arg_224_1.time_ - var_227_8) / var_227_18

				arg_224_1.typewritter:SetDirty()
			end

			if arg_224_1.time_ >= var_227_8 + var_227_18 and arg_224_1.time_ < var_227_8 + var_227_18 + arg_227_0 then
				arg_224_1.typewritter.percent = 1

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(true)
			end
		end

		arg_224_1.nodeConfigList_ = {}

		arg_224_1:InitPlayNodeList()
	end,
	Play424081054 = function(arg_228_0, arg_228_1)
		arg_228_1.time_ = 0
		arg_228_1.frameCnt_ = 0
		arg_228_1.state_ = "playing"
		arg_228_1.curTalkId_ = 424081054
		arg_228_1.duration_ = 5

		SetActive(arg_228_1.tipsGo_, false)

		function arg_228_1.onSingleLineFinish_()
			arg_228_1.onSingleLineUpdate_ = nil
			arg_228_1.onSingleLineFinish_ = nil
			arg_228_1.state_ = "waiting"
		end

		function arg_228_1.playNext_(arg_230_0)
			if arg_230_0 == 1 then
				arg_228_0:Play424081055(arg_228_1)
			end
		end

		function arg_228_1.onSingleLineUpdate_(arg_231_0)
			local var_231_0 = arg_228_1.actors_["10154"]
			local var_231_1 = 0

			if var_231_1 < arg_228_1.time_ and arg_228_1.time_ <= var_231_1 + arg_231_0 and not isNil(var_231_0) and arg_228_1.var_.actorSpriteComps10154 == nil then
				arg_228_1.var_.actorSpriteComps10154 = var_231_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_231_2 = 0.2

			if var_231_1 <= arg_228_1.time_ and arg_228_1.time_ < var_231_1 + var_231_2 and not isNil(var_231_0) then
				local var_231_3 = (arg_228_1.time_ - var_231_1) / var_231_2

				if arg_228_1.var_.actorSpriteComps10154 then
					for iter_231_0, iter_231_1 in pairs(arg_228_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_231_1 then
							if arg_228_1.isInRecall_ then
								local var_231_4 = Mathf.Lerp(iter_231_1.color.r, arg_228_1.hightColor2.r, var_231_3)
								local var_231_5 = Mathf.Lerp(iter_231_1.color.g, arg_228_1.hightColor2.g, var_231_3)
								local var_231_6 = Mathf.Lerp(iter_231_1.color.b, arg_228_1.hightColor2.b, var_231_3)

								iter_231_1.color = Color.New(var_231_4, var_231_5, var_231_6)
							else
								local var_231_7 = Mathf.Lerp(iter_231_1.color.r, 0.5, var_231_3)

								iter_231_1.color = Color.New(var_231_7, var_231_7, var_231_7)
							end
						end
					end
				end
			end

			if arg_228_1.time_ >= var_231_1 + var_231_2 and arg_228_1.time_ < var_231_1 + var_231_2 + arg_231_0 and not isNil(var_231_0) and arg_228_1.var_.actorSpriteComps10154 then
				for iter_231_2, iter_231_3 in pairs(arg_228_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_231_3 then
						if arg_228_1.isInRecall_ then
							iter_231_3.color = arg_228_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_231_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_228_1.var_.actorSpriteComps10154 = nil
			end

			local var_231_8 = arg_228_1.actors_["10154"].transform
			local var_231_9 = 0

			if var_231_9 < arg_228_1.time_ and arg_228_1.time_ <= var_231_9 + arg_231_0 then
				arg_228_1.var_.moveOldPos10154 = var_231_8.localPosition
				var_231_8.localScale = Vector3.New(1, 1, 1)

				arg_228_1:CheckSpriteTmpPos("10154", 7)

				local var_231_10 = var_231_8.childCount

				for iter_231_4 = 0, var_231_10 - 1 do
					local var_231_11 = var_231_8:GetChild(iter_231_4)

					if var_231_11.name == "" or not string.find(var_231_11.name, "split") then
						var_231_11.gameObject:SetActive(true)
					else
						var_231_11.gameObject:SetActive(false)
					end
				end
			end

			local var_231_12 = 0.001

			if var_231_9 <= arg_228_1.time_ and arg_228_1.time_ < var_231_9 + var_231_12 then
				local var_231_13 = (arg_228_1.time_ - var_231_9) / var_231_12
				local var_231_14 = Vector3.New(0, -2000, 0)

				var_231_8.localPosition = Vector3.Lerp(arg_228_1.var_.moveOldPos10154, var_231_14, var_231_13)
			end

			if arg_228_1.time_ >= var_231_9 + var_231_12 and arg_228_1.time_ < var_231_9 + var_231_12 + arg_231_0 then
				var_231_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_231_15 = 0
			local var_231_16 = 0.7

			if var_231_15 < arg_228_1.time_ and arg_228_1.time_ <= var_231_15 + arg_231_0 then
				arg_228_1.talkMaxDuration = 0
				arg_228_1.dialogCg_.alpha = 1

				arg_228_1.dialog_:SetActive(true)
				SetActive(arg_228_1.leftNameGo_, false)

				arg_228_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_228_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_228_1:RecordName(arg_228_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_228_1.iconTrs_.gameObject, false)
				arg_228_1.callingController_:SetSelectedState("normal")

				local var_231_17 = arg_228_1:GetWordFromCfg(424081054)
				local var_231_18 = arg_228_1:FormatText(var_231_17.content)

				arg_228_1.text_.text = var_231_18

				LuaForUtil.ClearLinePrefixSymbol(arg_228_1.text_)

				local var_231_19 = 28
				local var_231_20 = utf8.len(var_231_18)
				local var_231_21 = var_231_19 <= 0 and var_231_16 or var_231_16 * (var_231_20 / var_231_19)

				if var_231_21 > 0 and var_231_16 < var_231_21 then
					arg_228_1.talkMaxDuration = var_231_21

					if var_231_21 + var_231_15 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_21 + var_231_15
					end
				end

				arg_228_1.text_.text = var_231_18
				arg_228_1.typewritter.percent = 0

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(false)
				arg_228_1:RecordContent(arg_228_1.text_.text)
			end

			local var_231_22 = math.max(var_231_16, arg_228_1.talkMaxDuration)

			if var_231_15 <= arg_228_1.time_ and arg_228_1.time_ < var_231_15 + var_231_22 then
				arg_228_1.typewritter.percent = (arg_228_1.time_ - var_231_15) / var_231_22

				arg_228_1.typewritter:SetDirty()
			end

			if arg_228_1.time_ >= var_231_15 + var_231_22 and arg_228_1.time_ < var_231_15 + var_231_22 + arg_231_0 then
				arg_228_1.typewritter.percent = 1

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(true)
			end
		end

		arg_228_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10154",
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
	Play424081055 = function(arg_232_0, arg_232_1)
		arg_232_1.time_ = 0
		arg_232_1.frameCnt_ = 0
		arg_232_1.state_ = "playing"
		arg_232_1.curTalkId_ = 424081055
		arg_232_1.duration_ = 13.53

		local var_232_0 = {
			zh = 13.533,
			ja = 7.933
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
				arg_232_0:Play424081056(arg_232_1)
			end
		end

		function arg_232_1.onSingleLineUpdate_(arg_235_0)
			local var_235_0 = arg_232_1.actors_["10154"]
			local var_235_1 = 0

			if var_235_1 < arg_232_1.time_ and arg_232_1.time_ <= var_235_1 + arg_235_0 and not isNil(var_235_0) and arg_232_1.var_.actorSpriteComps10154 == nil then
				arg_232_1.var_.actorSpriteComps10154 = var_235_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_235_2 = 0.2

			if var_235_1 <= arg_232_1.time_ and arg_232_1.time_ < var_235_1 + var_235_2 and not isNil(var_235_0) then
				local var_235_3 = (arg_232_1.time_ - var_235_1) / var_235_2

				if arg_232_1.var_.actorSpriteComps10154 then
					for iter_235_0, iter_235_1 in pairs(arg_232_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_235_1 then
							if arg_232_1.isInRecall_ then
								local var_235_4 = Mathf.Lerp(iter_235_1.color.r, arg_232_1.hightColor1.r, var_235_3)
								local var_235_5 = Mathf.Lerp(iter_235_1.color.g, arg_232_1.hightColor1.g, var_235_3)
								local var_235_6 = Mathf.Lerp(iter_235_1.color.b, arg_232_1.hightColor1.b, var_235_3)

								iter_235_1.color = Color.New(var_235_4, var_235_5, var_235_6)
							else
								local var_235_7 = Mathf.Lerp(iter_235_1.color.r, 1, var_235_3)

								iter_235_1.color = Color.New(var_235_7, var_235_7, var_235_7)
							end
						end
					end
				end
			end

			if arg_232_1.time_ >= var_235_1 + var_235_2 and arg_232_1.time_ < var_235_1 + var_235_2 + arg_235_0 and not isNil(var_235_0) and arg_232_1.var_.actorSpriteComps10154 then
				for iter_235_2, iter_235_3 in pairs(arg_232_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_235_3 then
						if arg_232_1.isInRecall_ then
							iter_235_3.color = arg_232_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_235_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_232_1.var_.actorSpriteComps10154 = nil
			end

			local var_235_8 = arg_232_1.actors_["10154"].transform
			local var_235_9 = 0

			if var_235_9 < arg_232_1.time_ and arg_232_1.time_ <= var_235_9 + arg_235_0 then
				arg_232_1.var_.moveOldPos10154 = var_235_8.localPosition
				var_235_8.localScale = Vector3.New(1, 1, 1)

				arg_232_1:CheckSpriteTmpPos("10154", 3)

				local var_235_10 = var_235_8.childCount

				for iter_235_4 = 0, var_235_10 - 1 do
					local var_235_11 = var_235_8:GetChild(iter_235_4)

					if var_235_11.name == "split_4" or not string.find(var_235_11.name, "split") then
						var_235_11.gameObject:SetActive(true)
					else
						var_235_11.gameObject:SetActive(false)
					end
				end
			end

			local var_235_12 = 0.001

			if var_235_9 <= arg_232_1.time_ and arg_232_1.time_ < var_235_9 + var_235_12 then
				local var_235_13 = (arg_232_1.time_ - var_235_9) / var_235_12
				local var_235_14 = Vector3.New(-20, -338, -538)

				var_235_8.localPosition = Vector3.Lerp(arg_232_1.var_.moveOldPos10154, var_235_14, var_235_13)
			end

			if arg_232_1.time_ >= var_235_9 + var_235_12 and arg_232_1.time_ < var_235_9 + var_235_12 + arg_235_0 then
				var_235_8.localPosition = Vector3.New(-20, -338, -538)
			end

			local var_235_15 = 0
			local var_235_16 = 0.95

			if var_235_15 < arg_232_1.time_ and arg_232_1.time_ <= var_235_15 + arg_235_0 then
				arg_232_1.talkMaxDuration = 0
				arg_232_1.dialogCg_.alpha = 1

				arg_232_1.dialog_:SetActive(true)
				SetActive(arg_232_1.leftNameGo_, true)

				local var_235_17 = arg_232_1:FormatText(StoryNameCfg[1392].name)

				arg_232_1.leftNameTxt_.text = var_235_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_232_1.leftNameTxt_.transform)

				arg_232_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_232_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_232_1:RecordName(arg_232_1.leftNameTxt_.text)
				SetActive(arg_232_1.iconTrs_.gameObject, false)
				arg_232_1.callingController_:SetSelectedState("normal")

				local var_235_18 = arg_232_1:GetWordFromCfg(424081055)
				local var_235_19 = arg_232_1:FormatText(var_235_18.content)

				arg_232_1.text_.text = var_235_19

				LuaForUtil.ClearLinePrefixSymbol(arg_232_1.text_)

				local var_235_20 = 38
				local var_235_21 = utf8.len(var_235_19)
				local var_235_22 = var_235_20 <= 0 and var_235_16 or var_235_16 * (var_235_21 / var_235_20)

				if var_235_22 > 0 and var_235_16 < var_235_22 then
					arg_232_1.talkMaxDuration = var_235_22

					if var_235_22 + var_235_15 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_22 + var_235_15
					end
				end

				arg_232_1.text_.text = var_235_19
				arg_232_1.typewritter.percent = 0

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424081", "424081055", "story_v_out_424081.awb") ~= 0 then
					local var_235_23 = manager.audio:GetVoiceLength("story_v_out_424081", "424081055", "story_v_out_424081.awb") / 1000

					if var_235_23 + var_235_15 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_23 + var_235_15
					end

					if var_235_18.prefab_name ~= "" and arg_232_1.actors_[var_235_18.prefab_name] ~= nil then
						local var_235_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_232_1.actors_[var_235_18.prefab_name].transform, "story_v_out_424081", "424081055", "story_v_out_424081.awb")

						arg_232_1:RecordAudio("424081055", var_235_24)
						arg_232_1:RecordAudio("424081055", var_235_24)
					else
						arg_232_1:AudioAction("play", "voice", "story_v_out_424081", "424081055", "story_v_out_424081.awb")
					end

					arg_232_1:RecordHistoryTalkVoice("story_v_out_424081", "424081055", "story_v_out_424081.awb")
				end

				arg_232_1:RecordContent(arg_232_1.text_.text)
			end

			local var_235_25 = math.max(var_235_16, arg_232_1.talkMaxDuration)

			if var_235_15 <= arg_232_1.time_ and arg_232_1.time_ < var_235_15 + var_235_25 then
				arg_232_1.typewritter.percent = (arg_232_1.time_ - var_235_15) / var_235_25

				arg_232_1.typewritter:SetDirty()
			end

			if arg_232_1.time_ >= var_235_15 + var_235_25 and arg_232_1.time_ < var_235_15 + var_235_25 + arg_235_0 then
				arg_232_1.typewritter.percent = 1

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(true)
			end
		end

		arg_232_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10154",
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
	Play424081056 = function(arg_236_0, arg_236_1)
		arg_236_1.time_ = 0
		arg_236_1.frameCnt_ = 0
		arg_236_1.state_ = "playing"
		arg_236_1.curTalkId_ = 424081056
		arg_236_1.duration_ = 13.3

		local var_236_0 = {
			zh = 11.9,
			ja = 13.3
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
				arg_236_0:Play424081057(arg_236_1)
			end
		end

		function arg_236_1.onSingleLineUpdate_(arg_239_0)
			local var_239_0 = arg_236_1.actors_["10154"].transform
			local var_239_1 = 0

			if var_239_1 < arg_236_1.time_ and arg_236_1.time_ <= var_239_1 + arg_239_0 then
				arg_236_1.var_.moveOldPos10154 = var_239_0.localPosition
				var_239_0.localScale = Vector3.New(1, 1, 1)

				arg_236_1:CheckSpriteTmpPos("10154", 3)

				local var_239_2 = var_239_0.childCount

				for iter_239_0 = 0, var_239_2 - 1 do
					local var_239_3 = var_239_0:GetChild(iter_239_0)

					if var_239_3.name == "split_1" then
						var_239_3:SetAsLastSibling()
						var_239_3.gameObject:SetActive(true)

						arg_236_1.var_.actorSpriteSplit10154 = var_239_3.gameObject:GetComponent(typeof(Image))

						arg_236_1.var_.actorSpriteSplit10154:SetAlpha(0)
					end
				end
			end

			local var_239_4 = 0.5

			if var_239_1 <= arg_236_1.time_ and arg_236_1.time_ < var_239_1 + var_239_4 then
				local var_239_5 = (arg_236_1.time_ - var_239_1) / var_239_4
				local var_239_6 = Vector3.New(-20, -338, -538)

				var_239_0.localPosition = Vector3.Lerp(arg_236_1.var_.moveOldPos10154, var_239_6, var_239_5)

				if arg_236_1.var_.actorSpriteSplit10154 ~= nil then
					arg_236_1.var_.actorSpriteSplit10154:SetAlpha(var_239_5)
				end
			end

			if arg_236_1.time_ >= var_239_1 + var_239_4 and arg_236_1.time_ < var_239_1 + var_239_4 + arg_239_0 then
				var_239_0.localPosition = Vector3.New(-20, -338, -538)

				if arg_236_1.var_.actorSpriteSplit10154 ~= nil then
					arg_236_1.var_.actorSpriteSplit10154:SetAlpha(1)
				end
			end

			local var_239_7 = 0
			local var_239_8 = 1.15

			if var_239_7 < arg_236_1.time_ and arg_236_1.time_ <= var_239_7 + arg_239_0 then
				arg_236_1.talkMaxDuration = 0
				arg_236_1.dialogCg_.alpha = 1

				arg_236_1.dialog_:SetActive(true)
				SetActive(arg_236_1.leftNameGo_, true)

				local var_239_9 = arg_236_1:FormatText(StoryNameCfg[1392].name)

				arg_236_1.leftNameTxt_.text = var_239_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_236_1.leftNameTxt_.transform)

				arg_236_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_236_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_236_1:RecordName(arg_236_1.leftNameTxt_.text)
				SetActive(arg_236_1.iconTrs_.gameObject, false)
				arg_236_1.callingController_:SetSelectedState("normal")

				local var_239_10 = arg_236_1:GetWordFromCfg(424081056)
				local var_239_11 = arg_236_1:FormatText(var_239_10.content)

				arg_236_1.text_.text = var_239_11

				LuaForUtil.ClearLinePrefixSymbol(arg_236_1.text_)

				local var_239_12 = 46
				local var_239_13 = utf8.len(var_239_11)
				local var_239_14 = var_239_12 <= 0 and var_239_8 or var_239_8 * (var_239_13 / var_239_12)

				if var_239_14 > 0 and var_239_8 < var_239_14 then
					arg_236_1.talkMaxDuration = var_239_14

					if var_239_14 + var_239_7 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_14 + var_239_7
					end
				end

				arg_236_1.text_.text = var_239_11
				arg_236_1.typewritter.percent = 0

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424081", "424081056", "story_v_out_424081.awb") ~= 0 then
					local var_239_15 = manager.audio:GetVoiceLength("story_v_out_424081", "424081056", "story_v_out_424081.awb") / 1000

					if var_239_15 + var_239_7 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_15 + var_239_7
					end

					if var_239_10.prefab_name ~= "" and arg_236_1.actors_[var_239_10.prefab_name] ~= nil then
						local var_239_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_236_1.actors_[var_239_10.prefab_name].transform, "story_v_out_424081", "424081056", "story_v_out_424081.awb")

						arg_236_1:RecordAudio("424081056", var_239_16)
						arg_236_1:RecordAudio("424081056", var_239_16)
					else
						arg_236_1:AudioAction("play", "voice", "story_v_out_424081", "424081056", "story_v_out_424081.awb")
					end

					arg_236_1:RecordHistoryTalkVoice("story_v_out_424081", "424081056", "story_v_out_424081.awb")
				end

				arg_236_1:RecordContent(arg_236_1.text_.text)
			end

			local var_239_17 = math.max(var_239_8, arg_236_1.talkMaxDuration)

			if var_239_7 <= arg_236_1.time_ and arg_236_1.time_ < var_239_7 + var_239_17 then
				arg_236_1.typewritter.percent = (arg_236_1.time_ - var_239_7) / var_239_17

				arg_236_1.typewritter:SetDirty()
			end

			if arg_236_1.time_ >= var_239_7 + var_239_17 and arg_236_1.time_ < var_239_7 + var_239_17 + arg_239_0 then
				arg_236_1.typewritter.percent = 1

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(true)
			end
		end

		arg_236_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10154",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_236_1:InitPlayNodeList()
	end,
	Play424081057 = function(arg_240_0, arg_240_1)
		arg_240_1.time_ = 0
		arg_240_1.frameCnt_ = 0
		arg_240_1.state_ = "playing"
		arg_240_1.curTalkId_ = 424081057
		arg_240_1.duration_ = 5

		SetActive(arg_240_1.tipsGo_, false)

		function arg_240_1.onSingleLineFinish_()
			arg_240_1.onSingleLineUpdate_ = nil
			arg_240_1.onSingleLineFinish_ = nil
			arg_240_1.state_ = "waiting"
		end

		function arg_240_1.playNext_(arg_242_0)
			if arg_242_0 == 1 then
				arg_240_0:Play424081058(arg_240_1)
			end
		end

		function arg_240_1.onSingleLineUpdate_(arg_243_0)
			local var_243_0 = arg_240_1.actors_["10154"]
			local var_243_1 = 0

			if var_243_1 < arg_240_1.time_ and arg_240_1.time_ <= var_243_1 + arg_243_0 and not isNil(var_243_0) and arg_240_1.var_.actorSpriteComps10154 == nil then
				arg_240_1.var_.actorSpriteComps10154 = var_243_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_243_2 = 0.2

			if var_243_1 <= arg_240_1.time_ and arg_240_1.time_ < var_243_1 + var_243_2 and not isNil(var_243_0) then
				local var_243_3 = (arg_240_1.time_ - var_243_1) / var_243_2

				if arg_240_1.var_.actorSpriteComps10154 then
					for iter_243_0, iter_243_1 in pairs(arg_240_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_243_1 then
							if arg_240_1.isInRecall_ then
								local var_243_4 = Mathf.Lerp(iter_243_1.color.r, arg_240_1.hightColor2.r, var_243_3)
								local var_243_5 = Mathf.Lerp(iter_243_1.color.g, arg_240_1.hightColor2.g, var_243_3)
								local var_243_6 = Mathf.Lerp(iter_243_1.color.b, arg_240_1.hightColor2.b, var_243_3)

								iter_243_1.color = Color.New(var_243_4, var_243_5, var_243_6)
							else
								local var_243_7 = Mathf.Lerp(iter_243_1.color.r, 0.5, var_243_3)

								iter_243_1.color = Color.New(var_243_7, var_243_7, var_243_7)
							end
						end
					end
				end
			end

			if arg_240_1.time_ >= var_243_1 + var_243_2 and arg_240_1.time_ < var_243_1 + var_243_2 + arg_243_0 and not isNil(var_243_0) and arg_240_1.var_.actorSpriteComps10154 then
				for iter_243_2, iter_243_3 in pairs(arg_240_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_243_3 then
						if arg_240_1.isInRecall_ then
							iter_243_3.color = arg_240_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_243_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_240_1.var_.actorSpriteComps10154 = nil
			end

			local var_243_8 = 0
			local var_243_9 = 0.675

			if var_243_8 < arg_240_1.time_ and arg_240_1.time_ <= var_243_8 + arg_243_0 then
				arg_240_1.talkMaxDuration = 0
				arg_240_1.dialogCg_.alpha = 1

				arg_240_1.dialog_:SetActive(true)
				SetActive(arg_240_1.leftNameGo_, true)

				local var_243_10 = arg_240_1:FormatText(StoryNameCfg[7].name)

				arg_240_1.leftNameTxt_.text = var_243_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_240_1.leftNameTxt_.transform)

				arg_240_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_240_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_240_1:RecordName(arg_240_1.leftNameTxt_.text)
				SetActive(arg_240_1.iconTrs_.gameObject, true)
				arg_240_1.iconController_:SetSelectedState("hero")

				arg_240_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_240_1.callingController_:SetSelectedState("normal")

				arg_240_1.keyicon_.color = Color.New(1, 1, 1)
				arg_240_1.icon_.color = Color.New(1, 1, 1)

				local var_243_11 = arg_240_1:GetWordFromCfg(424081057)
				local var_243_12 = arg_240_1:FormatText(var_243_11.content)

				arg_240_1.text_.text = var_243_12

				LuaForUtil.ClearLinePrefixSymbol(arg_240_1.text_)

				local var_243_13 = 27
				local var_243_14 = utf8.len(var_243_12)
				local var_243_15 = var_243_13 <= 0 and var_243_9 or var_243_9 * (var_243_14 / var_243_13)

				if var_243_15 > 0 and var_243_9 < var_243_15 then
					arg_240_1.talkMaxDuration = var_243_15

					if var_243_15 + var_243_8 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_15 + var_243_8
					end
				end

				arg_240_1.text_.text = var_243_12
				arg_240_1.typewritter.percent = 0

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(false)
				arg_240_1:RecordContent(arg_240_1.text_.text)
			end

			local var_243_16 = math.max(var_243_9, arg_240_1.talkMaxDuration)

			if var_243_8 <= arg_240_1.time_ and arg_240_1.time_ < var_243_8 + var_243_16 then
				arg_240_1.typewritter.percent = (arg_240_1.time_ - var_243_8) / var_243_16

				arg_240_1.typewritter:SetDirty()
			end

			if arg_240_1.time_ >= var_243_8 + var_243_16 and arg_240_1.time_ < var_243_8 + var_243_16 + arg_243_0 then
				arg_240_1.typewritter.percent = 1

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(true)
			end
		end

		arg_240_1.nodeConfigList_ = {}

		arg_240_1:InitPlayNodeList()
	end,
	Play424081058 = function(arg_244_0, arg_244_1)
		arg_244_1.time_ = 0
		arg_244_1.frameCnt_ = 0
		arg_244_1.state_ = "playing"
		arg_244_1.curTalkId_ = 424081058
		arg_244_1.duration_ = 7.27

		local var_244_0 = {
			zh = 6.733,
			ja = 7.266
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
				arg_244_0:Play424081059(arg_244_1)
			end
		end

		function arg_244_1.onSingleLineUpdate_(arg_247_0)
			local var_247_0 = arg_244_1.actors_["10154"]
			local var_247_1 = 0

			if var_247_1 < arg_244_1.time_ and arg_244_1.time_ <= var_247_1 + arg_247_0 and not isNil(var_247_0) and arg_244_1.var_.actorSpriteComps10154 == nil then
				arg_244_1.var_.actorSpriteComps10154 = var_247_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_247_2 = 0.2

			if var_247_1 <= arg_244_1.time_ and arg_244_1.time_ < var_247_1 + var_247_2 and not isNil(var_247_0) then
				local var_247_3 = (arg_244_1.time_ - var_247_1) / var_247_2

				if arg_244_1.var_.actorSpriteComps10154 then
					for iter_247_0, iter_247_1 in pairs(arg_244_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_247_1 then
							if arg_244_1.isInRecall_ then
								local var_247_4 = Mathf.Lerp(iter_247_1.color.r, arg_244_1.hightColor1.r, var_247_3)
								local var_247_5 = Mathf.Lerp(iter_247_1.color.g, arg_244_1.hightColor1.g, var_247_3)
								local var_247_6 = Mathf.Lerp(iter_247_1.color.b, arg_244_1.hightColor1.b, var_247_3)

								iter_247_1.color = Color.New(var_247_4, var_247_5, var_247_6)
							else
								local var_247_7 = Mathf.Lerp(iter_247_1.color.r, 1, var_247_3)

								iter_247_1.color = Color.New(var_247_7, var_247_7, var_247_7)
							end
						end
					end
				end
			end

			if arg_244_1.time_ >= var_247_1 + var_247_2 and arg_244_1.time_ < var_247_1 + var_247_2 + arg_247_0 and not isNil(var_247_0) and arg_244_1.var_.actorSpriteComps10154 then
				for iter_247_2, iter_247_3 in pairs(arg_244_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_247_3 then
						if arg_244_1.isInRecall_ then
							iter_247_3.color = arg_244_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_247_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_244_1.var_.actorSpriteComps10154 = nil
			end

			local var_247_8 = arg_244_1.actors_["10154"].transform
			local var_247_9 = 0

			if var_247_9 < arg_244_1.time_ and arg_244_1.time_ <= var_247_9 + arg_247_0 then
				arg_244_1.var_.moveOldPos10154 = var_247_8.localPosition
				var_247_8.localScale = Vector3.New(1, 1, 1)

				arg_244_1:CheckSpriteTmpPos("10154", 3)

				local var_247_10 = var_247_8.childCount

				for iter_247_4 = 0, var_247_10 - 1 do
					local var_247_11 = var_247_8:GetChild(iter_247_4)

					if var_247_11.name == "" or not string.find(var_247_11.name, "split") then
						var_247_11.gameObject:SetActive(true)
					else
						var_247_11.gameObject:SetActive(false)
					end
				end
			end

			local var_247_12 = 0.001

			if var_247_9 <= arg_244_1.time_ and arg_244_1.time_ < var_247_9 + var_247_12 then
				local var_247_13 = (arg_244_1.time_ - var_247_9) / var_247_12
				local var_247_14 = Vector3.New(-20, -338, -538)

				var_247_8.localPosition = Vector3.Lerp(arg_244_1.var_.moveOldPos10154, var_247_14, var_247_13)
			end

			if arg_244_1.time_ >= var_247_9 + var_247_12 and arg_244_1.time_ < var_247_9 + var_247_12 + arg_247_0 then
				var_247_8.localPosition = Vector3.New(-20, -338, -538)
			end

			local var_247_15 = 0
			local var_247_16 = 0.675

			if var_247_15 < arg_244_1.time_ and arg_244_1.time_ <= var_247_15 + arg_247_0 then
				arg_244_1.talkMaxDuration = 0
				arg_244_1.dialogCg_.alpha = 1

				arg_244_1.dialog_:SetActive(true)
				SetActive(arg_244_1.leftNameGo_, true)

				local var_247_17 = arg_244_1:FormatText(StoryNameCfg[1392].name)

				arg_244_1.leftNameTxt_.text = var_247_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_244_1.leftNameTxt_.transform)

				arg_244_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_244_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_244_1:RecordName(arg_244_1.leftNameTxt_.text)
				SetActive(arg_244_1.iconTrs_.gameObject, false)
				arg_244_1.callingController_:SetSelectedState("normal")

				local var_247_18 = arg_244_1:GetWordFromCfg(424081058)
				local var_247_19 = arg_244_1:FormatText(var_247_18.content)

				arg_244_1.text_.text = var_247_19

				LuaForUtil.ClearLinePrefixSymbol(arg_244_1.text_)

				local var_247_20 = 27
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

				if manager.audio:GetVoiceLength("story_v_out_424081", "424081058", "story_v_out_424081.awb") ~= 0 then
					local var_247_23 = manager.audio:GetVoiceLength("story_v_out_424081", "424081058", "story_v_out_424081.awb") / 1000

					if var_247_23 + var_247_15 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_23 + var_247_15
					end

					if var_247_18.prefab_name ~= "" and arg_244_1.actors_[var_247_18.prefab_name] ~= nil then
						local var_247_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_244_1.actors_[var_247_18.prefab_name].transform, "story_v_out_424081", "424081058", "story_v_out_424081.awb")

						arg_244_1:RecordAudio("424081058", var_247_24)
						arg_244_1:RecordAudio("424081058", var_247_24)
					else
						arg_244_1:AudioAction("play", "voice", "story_v_out_424081", "424081058", "story_v_out_424081.awb")
					end

					arg_244_1:RecordHistoryTalkVoice("story_v_out_424081", "424081058", "story_v_out_424081.awb")
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
				actorName = "10154",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_244_1:InitPlayNodeList()
	end,
	Play424081059 = function(arg_248_0, arg_248_1)
		arg_248_1.time_ = 0
		arg_248_1.frameCnt_ = 0
		arg_248_1.state_ = "playing"
		arg_248_1.curTalkId_ = 424081059
		arg_248_1.duration_ = 5

		SetActive(arg_248_1.tipsGo_, false)

		function arg_248_1.onSingleLineFinish_()
			arg_248_1.onSingleLineUpdate_ = nil
			arg_248_1.onSingleLineFinish_ = nil
			arg_248_1.state_ = "waiting"
		end

		function arg_248_1.playNext_(arg_250_0)
			if arg_250_0 == 1 then
				arg_248_0:Play424081060(arg_248_1)
			end
		end

		function arg_248_1.onSingleLineUpdate_(arg_251_0)
			local var_251_0 = arg_248_1.actors_["10154"]
			local var_251_1 = 0

			if var_251_1 < arg_248_1.time_ and arg_248_1.time_ <= var_251_1 + arg_251_0 and not isNil(var_251_0) and arg_248_1.var_.actorSpriteComps10154 == nil then
				arg_248_1.var_.actorSpriteComps10154 = var_251_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_251_2 = 0.2

			if var_251_1 <= arg_248_1.time_ and arg_248_1.time_ < var_251_1 + var_251_2 and not isNil(var_251_0) then
				local var_251_3 = (arg_248_1.time_ - var_251_1) / var_251_2

				if arg_248_1.var_.actorSpriteComps10154 then
					for iter_251_0, iter_251_1 in pairs(arg_248_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_251_1 then
							if arg_248_1.isInRecall_ then
								local var_251_4 = Mathf.Lerp(iter_251_1.color.r, arg_248_1.hightColor2.r, var_251_3)
								local var_251_5 = Mathf.Lerp(iter_251_1.color.g, arg_248_1.hightColor2.g, var_251_3)
								local var_251_6 = Mathf.Lerp(iter_251_1.color.b, arg_248_1.hightColor2.b, var_251_3)

								iter_251_1.color = Color.New(var_251_4, var_251_5, var_251_6)
							else
								local var_251_7 = Mathf.Lerp(iter_251_1.color.r, 0.5, var_251_3)

								iter_251_1.color = Color.New(var_251_7, var_251_7, var_251_7)
							end
						end
					end
				end
			end

			if arg_248_1.time_ >= var_251_1 + var_251_2 and arg_248_1.time_ < var_251_1 + var_251_2 + arg_251_0 and not isNil(var_251_0) and arg_248_1.var_.actorSpriteComps10154 then
				for iter_251_2, iter_251_3 in pairs(arg_248_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_251_3 then
						if arg_248_1.isInRecall_ then
							iter_251_3.color = arg_248_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_251_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_248_1.var_.actorSpriteComps10154 = nil
			end

			local var_251_8 = 0
			local var_251_9 = 0.85

			if var_251_8 < arg_248_1.time_ and arg_248_1.time_ <= var_251_8 + arg_251_0 then
				arg_248_1.talkMaxDuration = 0
				arg_248_1.dialogCg_.alpha = 1

				arg_248_1.dialog_:SetActive(true)
				SetActive(arg_248_1.leftNameGo_, true)

				local var_251_10 = arg_248_1:FormatText(StoryNameCfg[7].name)

				arg_248_1.leftNameTxt_.text = var_251_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_248_1.leftNameTxt_.transform)

				arg_248_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_248_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_248_1:RecordName(arg_248_1.leftNameTxt_.text)
				SetActive(arg_248_1.iconTrs_.gameObject, true)
				arg_248_1.iconController_:SetSelectedState("hero")

				arg_248_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_248_1.callingController_:SetSelectedState("normal")

				arg_248_1.keyicon_.color = Color.New(1, 1, 1)
				arg_248_1.icon_.color = Color.New(1, 1, 1)

				local var_251_11 = arg_248_1:GetWordFromCfg(424081059)
				local var_251_12 = arg_248_1:FormatText(var_251_11.content)

				arg_248_1.text_.text = var_251_12

				LuaForUtil.ClearLinePrefixSymbol(arg_248_1.text_)

				local var_251_13 = 34
				local var_251_14 = utf8.len(var_251_12)
				local var_251_15 = var_251_13 <= 0 and var_251_9 or var_251_9 * (var_251_14 / var_251_13)

				if var_251_15 > 0 and var_251_9 < var_251_15 then
					arg_248_1.talkMaxDuration = var_251_15

					if var_251_15 + var_251_8 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_15 + var_251_8
					end
				end

				arg_248_1.text_.text = var_251_12
				arg_248_1.typewritter.percent = 0

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(false)
				arg_248_1:RecordContent(arg_248_1.text_.text)
			end

			local var_251_16 = math.max(var_251_9, arg_248_1.talkMaxDuration)

			if var_251_8 <= arg_248_1.time_ and arg_248_1.time_ < var_251_8 + var_251_16 then
				arg_248_1.typewritter.percent = (arg_248_1.time_ - var_251_8) / var_251_16

				arg_248_1.typewritter:SetDirty()
			end

			if arg_248_1.time_ >= var_251_8 + var_251_16 and arg_248_1.time_ < var_251_8 + var_251_16 + arg_251_0 then
				arg_248_1.typewritter.percent = 1

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(true)
			end
		end

		arg_248_1.nodeConfigList_ = {}

		arg_248_1:InitPlayNodeList()
	end,
	Play424081060 = function(arg_252_0, arg_252_1)
		arg_252_1.time_ = 0
		arg_252_1.frameCnt_ = 0
		arg_252_1.state_ = "playing"
		arg_252_1.curTalkId_ = 424081060
		arg_252_1.duration_ = 9.33

		local var_252_0 = {
			zh = 9.333,
			ja = 7.133
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
				arg_252_0:Play424081061(arg_252_1)
			end
		end

		function arg_252_1.onSingleLineUpdate_(arg_255_0)
			local var_255_0 = arg_252_1.actors_["10154"]
			local var_255_1 = 0

			if var_255_1 < arg_252_1.time_ and arg_252_1.time_ <= var_255_1 + arg_255_0 and not isNil(var_255_0) and arg_252_1.var_.actorSpriteComps10154 == nil then
				arg_252_1.var_.actorSpriteComps10154 = var_255_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_255_2 = 0.2

			if var_255_1 <= arg_252_1.time_ and arg_252_1.time_ < var_255_1 + var_255_2 and not isNil(var_255_0) then
				local var_255_3 = (arg_252_1.time_ - var_255_1) / var_255_2

				if arg_252_1.var_.actorSpriteComps10154 then
					for iter_255_0, iter_255_1 in pairs(arg_252_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_255_1 then
							if arg_252_1.isInRecall_ then
								local var_255_4 = Mathf.Lerp(iter_255_1.color.r, arg_252_1.hightColor1.r, var_255_3)
								local var_255_5 = Mathf.Lerp(iter_255_1.color.g, arg_252_1.hightColor1.g, var_255_3)
								local var_255_6 = Mathf.Lerp(iter_255_1.color.b, arg_252_1.hightColor1.b, var_255_3)

								iter_255_1.color = Color.New(var_255_4, var_255_5, var_255_6)
							else
								local var_255_7 = Mathf.Lerp(iter_255_1.color.r, 1, var_255_3)

								iter_255_1.color = Color.New(var_255_7, var_255_7, var_255_7)
							end
						end
					end
				end
			end

			if arg_252_1.time_ >= var_255_1 + var_255_2 and arg_252_1.time_ < var_255_1 + var_255_2 + arg_255_0 and not isNil(var_255_0) and arg_252_1.var_.actorSpriteComps10154 then
				for iter_255_2, iter_255_3 in pairs(arg_252_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_255_3 then
						if arg_252_1.isInRecall_ then
							iter_255_3.color = arg_252_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_255_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_252_1.var_.actorSpriteComps10154 = nil
			end

			local var_255_8 = arg_252_1.actors_["10154"].transform
			local var_255_9 = 0

			if var_255_9 < arg_252_1.time_ and arg_252_1.time_ <= var_255_9 + arg_255_0 then
				arg_252_1.var_.moveOldPos10154 = var_255_8.localPosition
				var_255_8.localScale = Vector3.New(1, 1, 1)

				arg_252_1:CheckSpriteTmpPos("10154", 3)

				local var_255_10 = var_255_8.childCount

				for iter_255_4 = 0, var_255_10 - 1 do
					local var_255_11 = var_255_8:GetChild(iter_255_4)

					if var_255_11.name == "" or not string.find(var_255_11.name, "split") then
						var_255_11.gameObject:SetActive(true)
					else
						var_255_11.gameObject:SetActive(false)
					end
				end
			end

			local var_255_12 = 0.001

			if var_255_9 <= arg_252_1.time_ and arg_252_1.time_ < var_255_9 + var_255_12 then
				local var_255_13 = (arg_252_1.time_ - var_255_9) / var_255_12
				local var_255_14 = Vector3.New(-20, -338, -538)

				var_255_8.localPosition = Vector3.Lerp(arg_252_1.var_.moveOldPos10154, var_255_14, var_255_13)
			end

			if arg_252_1.time_ >= var_255_9 + var_255_12 and arg_252_1.time_ < var_255_9 + var_255_12 + arg_255_0 then
				var_255_8.localPosition = Vector3.New(-20, -338, -538)
			end

			local var_255_15 = 0
			local var_255_16 = 1.075

			if var_255_15 < arg_252_1.time_ and arg_252_1.time_ <= var_255_15 + arg_255_0 then
				arg_252_1.talkMaxDuration = 0
				arg_252_1.dialogCg_.alpha = 1

				arg_252_1.dialog_:SetActive(true)
				SetActive(arg_252_1.leftNameGo_, true)

				local var_255_17 = arg_252_1:FormatText(StoryNameCfg[1392].name)

				arg_252_1.leftNameTxt_.text = var_255_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_252_1.leftNameTxt_.transform)

				arg_252_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_252_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_252_1:RecordName(arg_252_1.leftNameTxt_.text)
				SetActive(arg_252_1.iconTrs_.gameObject, false)
				arg_252_1.callingController_:SetSelectedState("normal")

				local var_255_18 = arg_252_1:GetWordFromCfg(424081060)
				local var_255_19 = arg_252_1:FormatText(var_255_18.content)

				arg_252_1.text_.text = var_255_19

				LuaForUtil.ClearLinePrefixSymbol(arg_252_1.text_)

				local var_255_20 = 43
				local var_255_21 = utf8.len(var_255_19)
				local var_255_22 = var_255_20 <= 0 and var_255_16 or var_255_16 * (var_255_21 / var_255_20)

				if var_255_22 > 0 and var_255_16 < var_255_22 then
					arg_252_1.talkMaxDuration = var_255_22

					if var_255_22 + var_255_15 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_22 + var_255_15
					end
				end

				arg_252_1.text_.text = var_255_19
				arg_252_1.typewritter.percent = 0

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424081", "424081060", "story_v_out_424081.awb") ~= 0 then
					local var_255_23 = manager.audio:GetVoiceLength("story_v_out_424081", "424081060", "story_v_out_424081.awb") / 1000

					if var_255_23 + var_255_15 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_23 + var_255_15
					end

					if var_255_18.prefab_name ~= "" and arg_252_1.actors_[var_255_18.prefab_name] ~= nil then
						local var_255_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_252_1.actors_[var_255_18.prefab_name].transform, "story_v_out_424081", "424081060", "story_v_out_424081.awb")

						arg_252_1:RecordAudio("424081060", var_255_24)
						arg_252_1:RecordAudio("424081060", var_255_24)
					else
						arg_252_1:AudioAction("play", "voice", "story_v_out_424081", "424081060", "story_v_out_424081.awb")
					end

					arg_252_1:RecordHistoryTalkVoice("story_v_out_424081", "424081060", "story_v_out_424081.awb")
				end

				arg_252_1:RecordContent(arg_252_1.text_.text)
			end

			local var_255_25 = math.max(var_255_16, arg_252_1.talkMaxDuration)

			if var_255_15 <= arg_252_1.time_ and arg_252_1.time_ < var_255_15 + var_255_25 then
				arg_252_1.typewritter.percent = (arg_252_1.time_ - var_255_15) / var_255_25

				arg_252_1.typewritter:SetDirty()
			end

			if arg_252_1.time_ >= var_255_15 + var_255_25 and arg_252_1.time_ < var_255_15 + var_255_25 + arg_255_0 then
				arg_252_1.typewritter.percent = 1

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(true)
			end
		end

		arg_252_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10154",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_252_1:InitPlayNodeList()
	end,
	Play424081061 = function(arg_256_0, arg_256_1)
		arg_256_1.time_ = 0
		arg_256_1.frameCnt_ = 0
		arg_256_1.state_ = "playing"
		arg_256_1.curTalkId_ = 424081061
		arg_256_1.duration_ = 5

		SetActive(arg_256_1.tipsGo_, false)

		function arg_256_1.onSingleLineFinish_()
			arg_256_1.onSingleLineUpdate_ = nil
			arg_256_1.onSingleLineFinish_ = nil
			arg_256_1.state_ = "waiting"
		end

		function arg_256_1.playNext_(arg_258_0)
			if arg_258_0 == 1 then
				arg_256_0:Play424081062(arg_256_1)
			end
		end

		function arg_256_1.onSingleLineUpdate_(arg_259_0)
			local var_259_0 = arg_256_1.actors_["10154"]
			local var_259_1 = 0

			if var_259_1 < arg_256_1.time_ and arg_256_1.time_ <= var_259_1 + arg_259_0 and not isNil(var_259_0) and arg_256_1.var_.actorSpriteComps10154 == nil then
				arg_256_1.var_.actorSpriteComps10154 = var_259_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_259_2 = 0.2

			if var_259_1 <= arg_256_1.time_ and arg_256_1.time_ < var_259_1 + var_259_2 and not isNil(var_259_0) then
				local var_259_3 = (arg_256_1.time_ - var_259_1) / var_259_2

				if arg_256_1.var_.actorSpriteComps10154 then
					for iter_259_0, iter_259_1 in pairs(arg_256_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_259_1 then
							if arg_256_1.isInRecall_ then
								local var_259_4 = Mathf.Lerp(iter_259_1.color.r, arg_256_1.hightColor2.r, var_259_3)
								local var_259_5 = Mathf.Lerp(iter_259_1.color.g, arg_256_1.hightColor2.g, var_259_3)
								local var_259_6 = Mathf.Lerp(iter_259_1.color.b, arg_256_1.hightColor2.b, var_259_3)

								iter_259_1.color = Color.New(var_259_4, var_259_5, var_259_6)
							else
								local var_259_7 = Mathf.Lerp(iter_259_1.color.r, 0.5, var_259_3)

								iter_259_1.color = Color.New(var_259_7, var_259_7, var_259_7)
							end
						end
					end
				end
			end

			if arg_256_1.time_ >= var_259_1 + var_259_2 and arg_256_1.time_ < var_259_1 + var_259_2 + arg_259_0 and not isNil(var_259_0) and arg_256_1.var_.actorSpriteComps10154 then
				for iter_259_2, iter_259_3 in pairs(arg_256_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_259_3 then
						if arg_256_1.isInRecall_ then
							iter_259_3.color = arg_256_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_259_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_256_1.var_.actorSpriteComps10154 = nil
			end

			local var_259_8 = 0
			local var_259_9 = 0.275

			if var_259_8 < arg_256_1.time_ and arg_256_1.time_ <= var_259_8 + arg_259_0 then
				arg_256_1.talkMaxDuration = 0
				arg_256_1.dialogCg_.alpha = 1

				arg_256_1.dialog_:SetActive(true)
				SetActive(arg_256_1.leftNameGo_, true)

				local var_259_10 = arg_256_1:FormatText(StoryNameCfg[7].name)

				arg_256_1.leftNameTxt_.text = var_259_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_256_1.leftNameTxt_.transform)

				arg_256_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_256_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_256_1:RecordName(arg_256_1.leftNameTxt_.text)
				SetActive(arg_256_1.iconTrs_.gameObject, true)
				arg_256_1.iconController_:SetSelectedState("hero")

				arg_256_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_256_1.callingController_:SetSelectedState("normal")

				arg_256_1.keyicon_.color = Color.New(1, 1, 1)
				arg_256_1.icon_.color = Color.New(1, 1, 1)

				local var_259_11 = arg_256_1:GetWordFromCfg(424081061)
				local var_259_12 = arg_256_1:FormatText(var_259_11.content)

				arg_256_1.text_.text = var_259_12

				LuaForUtil.ClearLinePrefixSymbol(arg_256_1.text_)

				local var_259_13 = 11
				local var_259_14 = utf8.len(var_259_12)
				local var_259_15 = var_259_13 <= 0 and var_259_9 or var_259_9 * (var_259_14 / var_259_13)

				if var_259_15 > 0 and var_259_9 < var_259_15 then
					arg_256_1.talkMaxDuration = var_259_15

					if var_259_15 + var_259_8 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_15 + var_259_8
					end
				end

				arg_256_1.text_.text = var_259_12
				arg_256_1.typewritter.percent = 0

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(false)
				arg_256_1:RecordContent(arg_256_1.text_.text)
			end

			local var_259_16 = math.max(var_259_9, arg_256_1.talkMaxDuration)

			if var_259_8 <= arg_256_1.time_ and arg_256_1.time_ < var_259_8 + var_259_16 then
				arg_256_1.typewritter.percent = (arg_256_1.time_ - var_259_8) / var_259_16

				arg_256_1.typewritter:SetDirty()
			end

			if arg_256_1.time_ >= var_259_8 + var_259_16 and arg_256_1.time_ < var_259_8 + var_259_16 + arg_259_0 then
				arg_256_1.typewritter.percent = 1

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(true)
			end
		end

		arg_256_1.nodeConfigList_ = {}

		arg_256_1:InitPlayNodeList()
	end,
	Play424081062 = function(arg_260_0, arg_260_1)
		arg_260_1.time_ = 0
		arg_260_1.frameCnt_ = 0
		arg_260_1.state_ = "playing"
		arg_260_1.curTalkId_ = 424081062
		arg_260_1.duration_ = 5

		SetActive(arg_260_1.tipsGo_, false)

		function arg_260_1.onSingleLineFinish_()
			arg_260_1.onSingleLineUpdate_ = nil
			arg_260_1.onSingleLineFinish_ = nil
			arg_260_1.state_ = "waiting"
		end

		function arg_260_1.playNext_(arg_262_0)
			if arg_262_0 == 1 then
				arg_260_0:Play424081063(arg_260_1)
			end
		end

		function arg_260_1.onSingleLineUpdate_(arg_263_0)
			local var_263_0 = arg_260_1.actors_["10154"].transform
			local var_263_1 = 0

			if var_263_1 < arg_260_1.time_ and arg_260_1.time_ <= var_263_1 + arg_263_0 then
				arg_260_1.var_.moveOldPos10154 = var_263_0.localPosition
				var_263_0.localScale = Vector3.New(1, 1, 1)

				arg_260_1:CheckSpriteTmpPos("10154", 7)

				local var_263_2 = var_263_0.childCount

				for iter_263_0 = 0, var_263_2 - 1 do
					local var_263_3 = var_263_0:GetChild(iter_263_0)

					if var_263_3.name == "" or not string.find(var_263_3.name, "split") then
						var_263_3.gameObject:SetActive(true)
					else
						var_263_3.gameObject:SetActive(false)
					end
				end
			end

			local var_263_4 = 0.001

			if var_263_1 <= arg_260_1.time_ and arg_260_1.time_ < var_263_1 + var_263_4 then
				local var_263_5 = (arg_260_1.time_ - var_263_1) / var_263_4
				local var_263_6 = Vector3.New(0, -2000, 0)

				var_263_0.localPosition = Vector3.Lerp(arg_260_1.var_.moveOldPos10154, var_263_6, var_263_5)
			end

			if arg_260_1.time_ >= var_263_1 + var_263_4 and arg_260_1.time_ < var_263_1 + var_263_4 + arg_263_0 then
				var_263_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_263_7 = 0
			local var_263_8 = 0.85

			if var_263_7 < arg_260_1.time_ and arg_260_1.time_ <= var_263_7 + arg_263_0 then
				arg_260_1.talkMaxDuration = 0
				arg_260_1.dialogCg_.alpha = 1

				arg_260_1.dialog_:SetActive(true)
				SetActive(arg_260_1.leftNameGo_, false)

				arg_260_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_260_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_260_1:RecordName(arg_260_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_260_1.iconTrs_.gameObject, false)
				arg_260_1.callingController_:SetSelectedState("normal")

				local var_263_9 = arg_260_1:GetWordFromCfg(424081062)
				local var_263_10 = arg_260_1:FormatText(var_263_9.content)

				arg_260_1.text_.text = var_263_10

				LuaForUtil.ClearLinePrefixSymbol(arg_260_1.text_)

				local var_263_11 = 34
				local var_263_12 = utf8.len(var_263_10)
				local var_263_13 = var_263_11 <= 0 and var_263_8 or var_263_8 * (var_263_12 / var_263_11)

				if var_263_13 > 0 and var_263_8 < var_263_13 then
					arg_260_1.talkMaxDuration = var_263_13

					if var_263_13 + var_263_7 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_13 + var_263_7
					end
				end

				arg_260_1.text_.text = var_263_10
				arg_260_1.typewritter.percent = 0

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(false)
				arg_260_1:RecordContent(arg_260_1.text_.text)
			end

			local var_263_14 = math.max(var_263_8, arg_260_1.talkMaxDuration)

			if var_263_7 <= arg_260_1.time_ and arg_260_1.time_ < var_263_7 + var_263_14 then
				arg_260_1.typewritter.percent = (arg_260_1.time_ - var_263_7) / var_263_14

				arg_260_1.typewritter:SetDirty()
			end

			if arg_260_1.time_ >= var_263_7 + var_263_14 and arg_260_1.time_ < var_263_7 + var_263_14 + arg_263_0 then
				arg_260_1.typewritter.percent = 1

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(true)
			end
		end

		arg_260_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10154",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_260_1:InitPlayNodeList()
	end,
	Play424081063 = function(arg_264_0, arg_264_1)
		arg_264_1.time_ = 0
		arg_264_1.frameCnt_ = 0
		arg_264_1.state_ = "playing"
		arg_264_1.curTalkId_ = 424081063
		arg_264_1.duration_ = 1

		local var_264_0 = {
			zh = 1,
			ja = 0.999999999999
		}
		local var_264_1 = manager.audio:GetLocalizationFlag()

		if var_264_0[var_264_1] ~= nil then
			arg_264_1.duration_ = var_264_0[var_264_1]
		end

		SetActive(arg_264_1.tipsGo_, false)

		function arg_264_1.onSingleLineFinish_()
			arg_264_1.onSingleLineUpdate_ = nil
			arg_264_1.onSingleLineFinish_ = nil
			arg_264_1.state_ = "waiting"
		end

		function arg_264_1.playNext_(arg_266_0)
			if arg_266_0 == 1 then
				arg_264_0:Play424081064(arg_264_1)
			end
		end

		function arg_264_1.onSingleLineUpdate_(arg_267_0)
			local var_267_0 = arg_264_1.actors_["10154"]
			local var_267_1 = 0

			if var_267_1 < arg_264_1.time_ and arg_264_1.time_ <= var_267_1 + arg_267_0 and not isNil(var_267_0) and arg_264_1.var_.actorSpriteComps10154 == nil then
				arg_264_1.var_.actorSpriteComps10154 = var_267_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_267_2 = 0.2

			if var_267_1 <= arg_264_1.time_ and arg_264_1.time_ < var_267_1 + var_267_2 and not isNil(var_267_0) then
				local var_267_3 = (arg_264_1.time_ - var_267_1) / var_267_2

				if arg_264_1.var_.actorSpriteComps10154 then
					for iter_267_0, iter_267_1 in pairs(arg_264_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_267_1 then
							if arg_264_1.isInRecall_ then
								local var_267_4 = Mathf.Lerp(iter_267_1.color.r, arg_264_1.hightColor1.r, var_267_3)
								local var_267_5 = Mathf.Lerp(iter_267_1.color.g, arg_264_1.hightColor1.g, var_267_3)
								local var_267_6 = Mathf.Lerp(iter_267_1.color.b, arg_264_1.hightColor1.b, var_267_3)

								iter_267_1.color = Color.New(var_267_4, var_267_5, var_267_6)
							else
								local var_267_7 = Mathf.Lerp(iter_267_1.color.r, 1, var_267_3)

								iter_267_1.color = Color.New(var_267_7, var_267_7, var_267_7)
							end
						end
					end
				end
			end

			if arg_264_1.time_ >= var_267_1 + var_267_2 and arg_264_1.time_ < var_267_1 + var_267_2 + arg_267_0 and not isNil(var_267_0) and arg_264_1.var_.actorSpriteComps10154 then
				for iter_267_2, iter_267_3 in pairs(arg_264_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_267_3 then
						if arg_264_1.isInRecall_ then
							iter_267_3.color = arg_264_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_267_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_264_1.var_.actorSpriteComps10154 = nil
			end

			local var_267_8 = arg_264_1.actors_["10154"].transform
			local var_267_9 = 0

			if var_267_9 < arg_264_1.time_ and arg_264_1.time_ <= var_267_9 + arg_267_0 then
				arg_264_1.var_.moveOldPos10154 = var_267_8.localPosition
				var_267_8.localScale = Vector3.New(1, 1, 1)

				arg_264_1:CheckSpriteTmpPos("10154", 3)

				local var_267_10 = var_267_8.childCount

				for iter_267_4 = 0, var_267_10 - 1 do
					local var_267_11 = var_267_8:GetChild(iter_267_4)

					if var_267_11.name == "split_5" then
						var_267_11:SetAsLastSibling()
						var_267_11.gameObject:SetActive(true)

						arg_264_1.var_.actorSpriteSplit10154 = var_267_11.gameObject:GetComponent(typeof(Image))

						arg_264_1.var_.actorSpriteSplit10154:SetAlpha(0)
					end
				end
			end

			local var_267_12 = 0.001

			if var_267_9 <= arg_264_1.time_ and arg_264_1.time_ < var_267_9 + var_267_12 then
				local var_267_13 = (arg_264_1.time_ - var_267_9) / var_267_12
				local var_267_14 = Vector3.New(-20, -338, -538)

				var_267_8.localPosition = Vector3.Lerp(arg_264_1.var_.moveOldPos10154, var_267_14, var_267_13)

				if arg_264_1.var_.actorSpriteSplit10154 ~= nil then
					arg_264_1.var_.actorSpriteSplit10154:SetAlpha(var_267_13)
				end
			end

			if arg_264_1.time_ >= var_267_9 + var_267_12 and arg_264_1.time_ < var_267_9 + var_267_12 + arg_267_0 then
				var_267_8.localPosition = Vector3.New(-20, -338, -538)

				if arg_264_1.var_.actorSpriteSplit10154 ~= nil then
					arg_264_1.var_.actorSpriteSplit10154:SetAlpha(1)
				end
			end

			local var_267_15 = 0
			local var_267_16 = 0.075

			if var_267_15 < arg_264_1.time_ and arg_264_1.time_ <= var_267_15 + arg_267_0 then
				arg_264_1.talkMaxDuration = 0
				arg_264_1.dialogCg_.alpha = 1

				arg_264_1.dialog_:SetActive(true)
				SetActive(arg_264_1.leftNameGo_, true)

				local var_267_17 = arg_264_1:FormatText(StoryNameCfg[1392].name)

				arg_264_1.leftNameTxt_.text = var_267_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_264_1.leftNameTxt_.transform)

				arg_264_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_264_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_264_1:RecordName(arg_264_1.leftNameTxt_.text)
				SetActive(arg_264_1.iconTrs_.gameObject, false)
				arg_264_1.callingController_:SetSelectedState("normal")

				local var_267_18 = arg_264_1:GetWordFromCfg(424081063)
				local var_267_19 = arg_264_1:FormatText(var_267_18.content)

				arg_264_1.text_.text = var_267_19

				LuaForUtil.ClearLinePrefixSymbol(arg_264_1.text_)

				local var_267_20 = 3
				local var_267_21 = utf8.len(var_267_19)
				local var_267_22 = var_267_20 <= 0 and var_267_16 or var_267_16 * (var_267_21 / var_267_20)

				if var_267_22 > 0 and var_267_16 < var_267_22 then
					arg_264_1.talkMaxDuration = var_267_22

					if var_267_22 + var_267_15 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_22 + var_267_15
					end
				end

				arg_264_1.text_.text = var_267_19
				arg_264_1.typewritter.percent = 0

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424081", "424081063", "story_v_out_424081.awb") ~= 0 then
					local var_267_23 = manager.audio:GetVoiceLength("story_v_out_424081", "424081063", "story_v_out_424081.awb") / 1000

					if var_267_23 + var_267_15 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_23 + var_267_15
					end

					if var_267_18.prefab_name ~= "" and arg_264_1.actors_[var_267_18.prefab_name] ~= nil then
						local var_267_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_264_1.actors_[var_267_18.prefab_name].transform, "story_v_out_424081", "424081063", "story_v_out_424081.awb")

						arg_264_1:RecordAudio("424081063", var_267_24)
						arg_264_1:RecordAudio("424081063", var_267_24)
					else
						arg_264_1:AudioAction("play", "voice", "story_v_out_424081", "424081063", "story_v_out_424081.awb")
					end

					arg_264_1:RecordHistoryTalkVoice("story_v_out_424081", "424081063", "story_v_out_424081.awb")
				end

				arg_264_1:RecordContent(arg_264_1.text_.text)
			end

			local var_267_25 = math.max(var_267_16, arg_264_1.talkMaxDuration)

			if var_267_15 <= arg_264_1.time_ and arg_264_1.time_ < var_267_15 + var_267_25 then
				arg_264_1.typewritter.percent = (arg_264_1.time_ - var_267_15) / var_267_25

				arg_264_1.typewritter:SetDirty()
			end

			if arg_264_1.time_ >= var_267_15 + var_267_25 and arg_264_1.time_ < var_267_15 + var_267_25 + arg_267_0 then
				arg_264_1.typewritter.percent = 1

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(true)
			end
		end

		arg_264_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10154",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_264_1:InitPlayNodeList()
	end,
	Play424081064 = function(arg_268_0, arg_268_1)
		arg_268_1.time_ = 0
		arg_268_1.frameCnt_ = 0
		arg_268_1.state_ = "playing"
		arg_268_1.curTalkId_ = 424081064
		arg_268_1.duration_ = 5

		SetActive(arg_268_1.tipsGo_, false)

		function arg_268_1.onSingleLineFinish_()
			arg_268_1.onSingleLineUpdate_ = nil
			arg_268_1.onSingleLineFinish_ = nil
			arg_268_1.state_ = "waiting"
		end

		function arg_268_1.playNext_(arg_270_0)
			if arg_270_0 == 1 then
				arg_268_0:Play424081065(arg_268_1)
			end
		end

		function arg_268_1.onSingleLineUpdate_(arg_271_0)
			local var_271_0 = arg_268_1.actors_["10154"]
			local var_271_1 = 0

			if var_271_1 < arg_268_1.time_ and arg_268_1.time_ <= var_271_1 + arg_271_0 and not isNil(var_271_0) and arg_268_1.var_.actorSpriteComps10154 == nil then
				arg_268_1.var_.actorSpriteComps10154 = var_271_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_271_2 = 0.2

			if var_271_1 <= arg_268_1.time_ and arg_268_1.time_ < var_271_1 + var_271_2 and not isNil(var_271_0) then
				local var_271_3 = (arg_268_1.time_ - var_271_1) / var_271_2

				if arg_268_1.var_.actorSpriteComps10154 then
					for iter_271_0, iter_271_1 in pairs(arg_268_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_271_1 then
							if arg_268_1.isInRecall_ then
								local var_271_4 = Mathf.Lerp(iter_271_1.color.r, arg_268_1.hightColor2.r, var_271_3)
								local var_271_5 = Mathf.Lerp(iter_271_1.color.g, arg_268_1.hightColor2.g, var_271_3)
								local var_271_6 = Mathf.Lerp(iter_271_1.color.b, arg_268_1.hightColor2.b, var_271_3)

								iter_271_1.color = Color.New(var_271_4, var_271_5, var_271_6)
							else
								local var_271_7 = Mathf.Lerp(iter_271_1.color.r, 0.5, var_271_3)

								iter_271_1.color = Color.New(var_271_7, var_271_7, var_271_7)
							end
						end
					end
				end
			end

			if arg_268_1.time_ >= var_271_1 + var_271_2 and arg_268_1.time_ < var_271_1 + var_271_2 + arg_271_0 and not isNil(var_271_0) and arg_268_1.var_.actorSpriteComps10154 then
				for iter_271_2, iter_271_3 in pairs(arg_268_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_271_3 then
						if arg_268_1.isInRecall_ then
							iter_271_3.color = arg_268_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_271_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_268_1.var_.actorSpriteComps10154 = nil
			end

			local var_271_8 = 0
			local var_271_9 = 1.65

			if var_271_8 < arg_268_1.time_ and arg_268_1.time_ <= var_271_8 + arg_271_0 then
				arg_268_1.talkMaxDuration = 0
				arg_268_1.dialogCg_.alpha = 1

				arg_268_1.dialog_:SetActive(true)
				SetActive(arg_268_1.leftNameGo_, true)

				local var_271_10 = arg_268_1:FormatText(StoryNameCfg[7].name)

				arg_268_1.leftNameTxt_.text = var_271_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_268_1.leftNameTxt_.transform)

				arg_268_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_268_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_268_1:RecordName(arg_268_1.leftNameTxt_.text)
				SetActive(arg_268_1.iconTrs_.gameObject, true)
				arg_268_1.iconController_:SetSelectedState("hero")

				arg_268_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_268_1.callingController_:SetSelectedState("normal")

				arg_268_1.keyicon_.color = Color.New(1, 1, 1)
				arg_268_1.icon_.color = Color.New(1, 1, 1)

				local var_271_11 = arg_268_1:GetWordFromCfg(424081064)
				local var_271_12 = arg_268_1:FormatText(var_271_11.content)

				arg_268_1.text_.text = var_271_12

				LuaForUtil.ClearLinePrefixSymbol(arg_268_1.text_)

				local var_271_13 = 66
				local var_271_14 = utf8.len(var_271_12)
				local var_271_15 = var_271_13 <= 0 and var_271_9 or var_271_9 * (var_271_14 / var_271_13)

				if var_271_15 > 0 and var_271_9 < var_271_15 then
					arg_268_1.talkMaxDuration = var_271_15

					if var_271_15 + var_271_8 > arg_268_1.duration_ then
						arg_268_1.duration_ = var_271_15 + var_271_8
					end
				end

				arg_268_1.text_.text = var_271_12
				arg_268_1.typewritter.percent = 0

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(false)
				arg_268_1:RecordContent(arg_268_1.text_.text)
			end

			local var_271_16 = math.max(var_271_9, arg_268_1.talkMaxDuration)

			if var_271_8 <= arg_268_1.time_ and arg_268_1.time_ < var_271_8 + var_271_16 then
				arg_268_1.typewritter.percent = (arg_268_1.time_ - var_271_8) / var_271_16

				arg_268_1.typewritter:SetDirty()
			end

			if arg_268_1.time_ >= var_271_8 + var_271_16 and arg_268_1.time_ < var_271_8 + var_271_16 + arg_271_0 then
				arg_268_1.typewritter.percent = 1

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(true)
			end
		end

		arg_268_1.nodeConfigList_ = {}

		arg_268_1:InitPlayNodeList()
	end,
	Play424081065 = function(arg_272_0, arg_272_1)
		arg_272_1.time_ = 0
		arg_272_1.frameCnt_ = 0
		arg_272_1.state_ = "playing"
		arg_272_1.curTalkId_ = 424081065
		arg_272_1.duration_ = 5

		SetActive(arg_272_1.tipsGo_, false)

		function arg_272_1.onSingleLineFinish_()
			arg_272_1.onSingleLineUpdate_ = nil
			arg_272_1.onSingleLineFinish_ = nil
			arg_272_1.state_ = "waiting"
		end

		function arg_272_1.playNext_(arg_274_0)
			if arg_274_0 == 1 then
				arg_272_0:Play424081066(arg_272_1)
			end
		end

		function arg_272_1.onSingleLineUpdate_(arg_275_0)
			local var_275_0 = 0
			local var_275_1 = 0.55

			if var_275_0 < arg_272_1.time_ and arg_272_1.time_ <= var_275_0 + arg_275_0 then
				arg_272_1.talkMaxDuration = 0
				arg_272_1.dialogCg_.alpha = 1

				arg_272_1.dialog_:SetActive(true)
				SetActive(arg_272_1.leftNameGo_, true)

				local var_275_2 = arg_272_1:FormatText(StoryNameCfg[7].name)

				arg_272_1.leftNameTxt_.text = var_275_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_272_1.leftNameTxt_.transform)

				arg_272_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_272_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_272_1:RecordName(arg_272_1.leftNameTxt_.text)
				SetActive(arg_272_1.iconTrs_.gameObject, true)
				arg_272_1.iconController_:SetSelectedState("hero")

				arg_272_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_272_1.callingController_:SetSelectedState("normal")

				arg_272_1.keyicon_.color = Color.New(1, 1, 1)
				arg_272_1.icon_.color = Color.New(1, 1, 1)

				local var_275_3 = arg_272_1:GetWordFromCfg(424081065)
				local var_275_4 = arg_272_1:FormatText(var_275_3.content)

				arg_272_1.text_.text = var_275_4

				LuaForUtil.ClearLinePrefixSymbol(arg_272_1.text_)

				local var_275_5 = 22
				local var_275_6 = utf8.len(var_275_4)
				local var_275_7 = var_275_5 <= 0 and var_275_1 or var_275_1 * (var_275_6 / var_275_5)

				if var_275_7 > 0 and var_275_1 < var_275_7 then
					arg_272_1.talkMaxDuration = var_275_7

					if var_275_7 + var_275_0 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_7 + var_275_0
					end
				end

				arg_272_1.text_.text = var_275_4
				arg_272_1.typewritter.percent = 0

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(false)
				arg_272_1:RecordContent(arg_272_1.text_.text)
			end

			local var_275_8 = math.max(var_275_1, arg_272_1.talkMaxDuration)

			if var_275_0 <= arg_272_1.time_ and arg_272_1.time_ < var_275_0 + var_275_8 then
				arg_272_1.typewritter.percent = (arg_272_1.time_ - var_275_0) / var_275_8

				arg_272_1.typewritter:SetDirty()
			end

			if arg_272_1.time_ >= var_275_0 + var_275_8 and arg_272_1.time_ < var_275_0 + var_275_8 + arg_275_0 then
				arg_272_1.typewritter.percent = 1

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(true)
			end
		end

		arg_272_1.nodeConfigList_ = {}

		arg_272_1:InitPlayNodeList()
	end,
	Play424081066 = function(arg_276_0, arg_276_1)
		arg_276_1.time_ = 0
		arg_276_1.frameCnt_ = 0
		arg_276_1.state_ = "playing"
		arg_276_1.curTalkId_ = 424081066
		arg_276_1.duration_ = 2.9

		local var_276_0 = {
			zh = 2.333,
			ja = 2.9
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
				arg_276_0:Play424081067(arg_276_1)
			end
		end

		function arg_276_1.onSingleLineUpdate_(arg_279_0)
			local var_279_0 = arg_276_1.actors_["10154"]
			local var_279_1 = 0

			if var_279_1 < arg_276_1.time_ and arg_276_1.time_ <= var_279_1 + arg_279_0 and not isNil(var_279_0) and arg_276_1.var_.actorSpriteComps10154 == nil then
				arg_276_1.var_.actorSpriteComps10154 = var_279_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_279_2 = 0.2

			if var_279_1 <= arg_276_1.time_ and arg_276_1.time_ < var_279_1 + var_279_2 and not isNil(var_279_0) then
				local var_279_3 = (arg_276_1.time_ - var_279_1) / var_279_2

				if arg_276_1.var_.actorSpriteComps10154 then
					for iter_279_0, iter_279_1 in pairs(arg_276_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_279_1 then
							if arg_276_1.isInRecall_ then
								local var_279_4 = Mathf.Lerp(iter_279_1.color.r, arg_276_1.hightColor1.r, var_279_3)
								local var_279_5 = Mathf.Lerp(iter_279_1.color.g, arg_276_1.hightColor1.g, var_279_3)
								local var_279_6 = Mathf.Lerp(iter_279_1.color.b, arg_276_1.hightColor1.b, var_279_3)

								iter_279_1.color = Color.New(var_279_4, var_279_5, var_279_6)
							else
								local var_279_7 = Mathf.Lerp(iter_279_1.color.r, 1, var_279_3)

								iter_279_1.color = Color.New(var_279_7, var_279_7, var_279_7)
							end
						end
					end
				end
			end

			if arg_276_1.time_ >= var_279_1 + var_279_2 and arg_276_1.time_ < var_279_1 + var_279_2 + arg_279_0 and not isNil(var_279_0) and arg_276_1.var_.actorSpriteComps10154 then
				for iter_279_2, iter_279_3 in pairs(arg_276_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_279_3 then
						if arg_276_1.isInRecall_ then
							iter_279_3.color = arg_276_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_279_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_276_1.var_.actorSpriteComps10154 = nil
			end

			local var_279_8 = arg_276_1.actors_["10154"].transform
			local var_279_9 = 0

			if var_279_9 < arg_276_1.time_ and arg_276_1.time_ <= var_279_9 + arg_279_0 then
				arg_276_1.var_.moveOldPos10154 = var_279_8.localPosition
				var_279_8.localScale = Vector3.New(1, 1, 1)

				arg_276_1:CheckSpriteTmpPos("10154", 3)

				local var_279_10 = var_279_8.childCount

				for iter_279_4 = 0, var_279_10 - 1 do
					local var_279_11 = var_279_8:GetChild(iter_279_4)

					if var_279_11.name == "split_1" then
						var_279_11:SetAsLastSibling()
						var_279_11.gameObject:SetActive(true)

						arg_276_1.var_.actorSpriteSplit10154 = var_279_11.gameObject:GetComponent(typeof(Image))

						arg_276_1.var_.actorSpriteSplit10154:SetAlpha(0)
					end
				end
			end

			local var_279_12 = 0.5

			if var_279_9 <= arg_276_1.time_ and arg_276_1.time_ < var_279_9 + var_279_12 then
				local var_279_13 = (arg_276_1.time_ - var_279_9) / var_279_12
				local var_279_14 = Vector3.New(-20, -338, -538)

				var_279_8.localPosition = Vector3.Lerp(arg_276_1.var_.moveOldPos10154, var_279_14, var_279_13)

				if arg_276_1.var_.actorSpriteSplit10154 ~= nil then
					arg_276_1.var_.actorSpriteSplit10154:SetAlpha(var_279_13)
				end
			end

			if arg_276_1.time_ >= var_279_9 + var_279_12 and arg_276_1.time_ < var_279_9 + var_279_12 + arg_279_0 then
				var_279_8.localPosition = Vector3.New(-20, -338, -538)

				if arg_276_1.var_.actorSpriteSplit10154 ~= nil then
					arg_276_1.var_.actorSpriteSplit10154:SetAlpha(1)
				end
			end

			local var_279_15 = 0
			local var_279_16 = 0.3

			if var_279_15 < arg_276_1.time_ and arg_276_1.time_ <= var_279_15 + arg_279_0 then
				arg_276_1.talkMaxDuration = 0
				arg_276_1.dialogCg_.alpha = 1

				arg_276_1.dialog_:SetActive(true)
				SetActive(arg_276_1.leftNameGo_, true)

				local var_279_17 = arg_276_1:FormatText(StoryNameCfg[1392].name)

				arg_276_1.leftNameTxt_.text = var_279_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_276_1.leftNameTxt_.transform)

				arg_276_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_276_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_276_1:RecordName(arg_276_1.leftNameTxt_.text)
				SetActive(arg_276_1.iconTrs_.gameObject, false)
				arg_276_1.callingController_:SetSelectedState("normal")

				local var_279_18 = arg_276_1:GetWordFromCfg(424081066)
				local var_279_19 = arg_276_1:FormatText(var_279_18.content)

				arg_276_1.text_.text = var_279_19

				LuaForUtil.ClearLinePrefixSymbol(arg_276_1.text_)

				local var_279_20 = 12
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

				if manager.audio:GetVoiceLength("story_v_out_424081", "424081066", "story_v_out_424081.awb") ~= 0 then
					local var_279_23 = manager.audio:GetVoiceLength("story_v_out_424081", "424081066", "story_v_out_424081.awb") / 1000

					if var_279_23 + var_279_15 > arg_276_1.duration_ then
						arg_276_1.duration_ = var_279_23 + var_279_15
					end

					if var_279_18.prefab_name ~= "" and arg_276_1.actors_[var_279_18.prefab_name] ~= nil then
						local var_279_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_276_1.actors_[var_279_18.prefab_name].transform, "story_v_out_424081", "424081066", "story_v_out_424081.awb")

						arg_276_1:RecordAudio("424081066", var_279_24)
						arg_276_1:RecordAudio("424081066", var_279_24)
					else
						arg_276_1:AudioAction("play", "voice", "story_v_out_424081", "424081066", "story_v_out_424081.awb")
					end

					arg_276_1:RecordHistoryTalkVoice("story_v_out_424081", "424081066", "story_v_out_424081.awb")
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
				actorName = "10154",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_276_1:InitPlayNodeList()
	end,
	Play424081067 = function(arg_280_0, arg_280_1)
		arg_280_1.time_ = 0
		arg_280_1.frameCnt_ = 0
		arg_280_1.state_ = "playing"
		arg_280_1.curTalkId_ = 424081067
		arg_280_1.duration_ = 5

		SetActive(arg_280_1.tipsGo_, false)

		function arg_280_1.onSingleLineFinish_()
			arg_280_1.onSingleLineUpdate_ = nil
			arg_280_1.onSingleLineFinish_ = nil
			arg_280_1.state_ = "waiting"
		end

		function arg_280_1.playNext_(arg_282_0)
			if arg_282_0 == 1 then
				arg_280_0:Play424081068(arg_280_1)
			end
		end

		function arg_280_1.onSingleLineUpdate_(arg_283_0)
			local var_283_0 = arg_280_1.actors_["10154"]
			local var_283_1 = 0

			if var_283_1 < arg_280_1.time_ and arg_280_1.time_ <= var_283_1 + arg_283_0 and not isNil(var_283_0) and arg_280_1.var_.actorSpriteComps10154 == nil then
				arg_280_1.var_.actorSpriteComps10154 = var_283_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_283_2 = 0.2

			if var_283_1 <= arg_280_1.time_ and arg_280_1.time_ < var_283_1 + var_283_2 and not isNil(var_283_0) then
				local var_283_3 = (arg_280_1.time_ - var_283_1) / var_283_2

				if arg_280_1.var_.actorSpriteComps10154 then
					for iter_283_0, iter_283_1 in pairs(arg_280_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_283_1 then
							if arg_280_1.isInRecall_ then
								local var_283_4 = Mathf.Lerp(iter_283_1.color.r, arg_280_1.hightColor2.r, var_283_3)
								local var_283_5 = Mathf.Lerp(iter_283_1.color.g, arg_280_1.hightColor2.g, var_283_3)
								local var_283_6 = Mathf.Lerp(iter_283_1.color.b, arg_280_1.hightColor2.b, var_283_3)

								iter_283_1.color = Color.New(var_283_4, var_283_5, var_283_6)
							else
								local var_283_7 = Mathf.Lerp(iter_283_1.color.r, 0.5, var_283_3)

								iter_283_1.color = Color.New(var_283_7, var_283_7, var_283_7)
							end
						end
					end
				end
			end

			if arg_280_1.time_ >= var_283_1 + var_283_2 and arg_280_1.time_ < var_283_1 + var_283_2 + arg_283_0 and not isNil(var_283_0) and arg_280_1.var_.actorSpriteComps10154 then
				for iter_283_2, iter_283_3 in pairs(arg_280_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_283_3 then
						if arg_280_1.isInRecall_ then
							iter_283_3.color = arg_280_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_283_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_280_1.var_.actorSpriteComps10154 = nil
			end

			local var_283_8 = 0
			local var_283_9 = 1.2

			if var_283_8 < arg_280_1.time_ and arg_280_1.time_ <= var_283_8 + arg_283_0 then
				arg_280_1.talkMaxDuration = 0
				arg_280_1.dialogCg_.alpha = 1

				arg_280_1.dialog_:SetActive(true)
				SetActive(arg_280_1.leftNameGo_, true)

				local var_283_10 = arg_280_1:FormatText(StoryNameCfg[7].name)

				arg_280_1.leftNameTxt_.text = var_283_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_280_1.leftNameTxt_.transform)

				arg_280_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_280_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_280_1:RecordName(arg_280_1.leftNameTxt_.text)
				SetActive(arg_280_1.iconTrs_.gameObject, true)
				arg_280_1.iconController_:SetSelectedState("hero")

				arg_280_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_280_1.callingController_:SetSelectedState("normal")

				arg_280_1.keyicon_.color = Color.New(1, 1, 1)
				arg_280_1.icon_.color = Color.New(1, 1, 1)

				local var_283_11 = arg_280_1:GetWordFromCfg(424081067)
				local var_283_12 = arg_280_1:FormatText(var_283_11.content)

				arg_280_1.text_.text = var_283_12

				LuaForUtil.ClearLinePrefixSymbol(arg_280_1.text_)

				local var_283_13 = 48
				local var_283_14 = utf8.len(var_283_12)
				local var_283_15 = var_283_13 <= 0 and var_283_9 or var_283_9 * (var_283_14 / var_283_13)

				if var_283_15 > 0 and var_283_9 < var_283_15 then
					arg_280_1.talkMaxDuration = var_283_15

					if var_283_15 + var_283_8 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_15 + var_283_8
					end
				end

				arg_280_1.text_.text = var_283_12
				arg_280_1.typewritter.percent = 0

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(false)
				arg_280_1:RecordContent(arg_280_1.text_.text)
			end

			local var_283_16 = math.max(var_283_9, arg_280_1.talkMaxDuration)

			if var_283_8 <= arg_280_1.time_ and arg_280_1.time_ < var_283_8 + var_283_16 then
				arg_280_1.typewritter.percent = (arg_280_1.time_ - var_283_8) / var_283_16

				arg_280_1.typewritter:SetDirty()
			end

			if arg_280_1.time_ >= var_283_8 + var_283_16 and arg_280_1.time_ < var_283_8 + var_283_16 + arg_283_0 then
				arg_280_1.typewritter.percent = 1

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(true)
			end
		end

		arg_280_1.nodeConfigList_ = {}

		arg_280_1:InitPlayNodeList()
	end,
	Play424081068 = function(arg_284_0, arg_284_1)
		arg_284_1.time_ = 0
		arg_284_1.frameCnt_ = 0
		arg_284_1.state_ = "playing"
		arg_284_1.curTalkId_ = 424081068
		arg_284_1.duration_ = 5.3

		local var_284_0 = {
			zh = 3.733,
			ja = 5.3
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
				arg_284_0:Play424081069(arg_284_1)
			end
		end

		function arg_284_1.onSingleLineUpdate_(arg_287_0)
			local var_287_0 = arg_284_1.actors_["10154"]
			local var_287_1 = 0

			if var_287_1 < arg_284_1.time_ and arg_284_1.time_ <= var_287_1 + arg_287_0 and not isNil(var_287_0) and arg_284_1.var_.actorSpriteComps10154 == nil then
				arg_284_1.var_.actorSpriteComps10154 = var_287_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_287_2 = 0.2

			if var_287_1 <= arg_284_1.time_ and arg_284_1.time_ < var_287_1 + var_287_2 and not isNil(var_287_0) then
				local var_287_3 = (arg_284_1.time_ - var_287_1) / var_287_2

				if arg_284_1.var_.actorSpriteComps10154 then
					for iter_287_0, iter_287_1 in pairs(arg_284_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_287_1 then
							if arg_284_1.isInRecall_ then
								local var_287_4 = Mathf.Lerp(iter_287_1.color.r, arg_284_1.hightColor1.r, var_287_3)
								local var_287_5 = Mathf.Lerp(iter_287_1.color.g, arg_284_1.hightColor1.g, var_287_3)
								local var_287_6 = Mathf.Lerp(iter_287_1.color.b, arg_284_1.hightColor1.b, var_287_3)

								iter_287_1.color = Color.New(var_287_4, var_287_5, var_287_6)
							else
								local var_287_7 = Mathf.Lerp(iter_287_1.color.r, 1, var_287_3)

								iter_287_1.color = Color.New(var_287_7, var_287_7, var_287_7)
							end
						end
					end
				end
			end

			if arg_284_1.time_ >= var_287_1 + var_287_2 and arg_284_1.time_ < var_287_1 + var_287_2 + arg_287_0 and not isNil(var_287_0) and arg_284_1.var_.actorSpriteComps10154 then
				for iter_287_2, iter_287_3 in pairs(arg_284_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_287_3 then
						if arg_284_1.isInRecall_ then
							iter_287_3.color = arg_284_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_287_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_284_1.var_.actorSpriteComps10154 = nil
			end

			local var_287_8 = arg_284_1.actors_["10154"].transform
			local var_287_9 = 0

			if var_287_9 < arg_284_1.time_ and arg_284_1.time_ <= var_287_9 + arg_287_0 then
				arg_284_1.var_.moveOldPos10154 = var_287_8.localPosition
				var_287_8.localScale = Vector3.New(1, 1, 1)

				arg_284_1:CheckSpriteTmpPos("10154", 3)

				local var_287_10 = var_287_8.childCount

				for iter_287_4 = 0, var_287_10 - 1 do
					local var_287_11 = var_287_8:GetChild(iter_287_4)

					if var_287_11.name == "" or not string.find(var_287_11.name, "split") then
						var_287_11.gameObject:SetActive(true)
					else
						var_287_11.gameObject:SetActive(false)
					end
				end
			end

			local var_287_12 = 0.001

			if var_287_9 <= arg_284_1.time_ and arg_284_1.time_ < var_287_9 + var_287_12 then
				local var_287_13 = (arg_284_1.time_ - var_287_9) / var_287_12
				local var_287_14 = Vector3.New(-20, -338, -538)

				var_287_8.localPosition = Vector3.Lerp(arg_284_1.var_.moveOldPos10154, var_287_14, var_287_13)
			end

			if arg_284_1.time_ >= var_287_9 + var_287_12 and arg_284_1.time_ < var_287_9 + var_287_12 + arg_287_0 then
				var_287_8.localPosition = Vector3.New(-20, -338, -538)
			end

			local var_287_15 = 0
			local var_287_16 = 0.5

			if var_287_15 < arg_284_1.time_ and arg_284_1.time_ <= var_287_15 + arg_287_0 then
				arg_284_1.talkMaxDuration = 0
				arg_284_1.dialogCg_.alpha = 1

				arg_284_1.dialog_:SetActive(true)
				SetActive(arg_284_1.leftNameGo_, true)

				local var_287_17 = arg_284_1:FormatText(StoryNameCfg[1392].name)

				arg_284_1.leftNameTxt_.text = var_287_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_284_1.leftNameTxt_.transform)

				arg_284_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_284_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_284_1:RecordName(arg_284_1.leftNameTxt_.text)
				SetActive(arg_284_1.iconTrs_.gameObject, false)
				arg_284_1.callingController_:SetSelectedState("normal")

				local var_287_18 = arg_284_1:GetWordFromCfg(424081068)
				local var_287_19 = arg_284_1:FormatText(var_287_18.content)

				arg_284_1.text_.text = var_287_19

				LuaForUtil.ClearLinePrefixSymbol(arg_284_1.text_)

				local var_287_20 = 20
				local var_287_21 = utf8.len(var_287_19)
				local var_287_22 = var_287_20 <= 0 and var_287_16 or var_287_16 * (var_287_21 / var_287_20)

				if var_287_22 > 0 and var_287_16 < var_287_22 then
					arg_284_1.talkMaxDuration = var_287_22

					if var_287_22 + var_287_15 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_22 + var_287_15
					end
				end

				arg_284_1.text_.text = var_287_19
				arg_284_1.typewritter.percent = 0

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424081", "424081068", "story_v_out_424081.awb") ~= 0 then
					local var_287_23 = manager.audio:GetVoiceLength("story_v_out_424081", "424081068", "story_v_out_424081.awb") / 1000

					if var_287_23 + var_287_15 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_23 + var_287_15
					end

					if var_287_18.prefab_name ~= "" and arg_284_1.actors_[var_287_18.prefab_name] ~= nil then
						local var_287_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_284_1.actors_[var_287_18.prefab_name].transform, "story_v_out_424081", "424081068", "story_v_out_424081.awb")

						arg_284_1:RecordAudio("424081068", var_287_24)
						arg_284_1:RecordAudio("424081068", var_287_24)
					else
						arg_284_1:AudioAction("play", "voice", "story_v_out_424081", "424081068", "story_v_out_424081.awb")
					end

					arg_284_1:RecordHistoryTalkVoice("story_v_out_424081", "424081068", "story_v_out_424081.awb")
				end

				arg_284_1:RecordContent(arg_284_1.text_.text)
			end

			local var_287_25 = math.max(var_287_16, arg_284_1.talkMaxDuration)

			if var_287_15 <= arg_284_1.time_ and arg_284_1.time_ < var_287_15 + var_287_25 then
				arg_284_1.typewritter.percent = (arg_284_1.time_ - var_287_15) / var_287_25

				arg_284_1.typewritter:SetDirty()
			end

			if arg_284_1.time_ >= var_287_15 + var_287_25 and arg_284_1.time_ < var_287_15 + var_287_25 + arg_287_0 then
				arg_284_1.typewritter.percent = 1

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(true)
			end
		end

		arg_284_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10154",
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
	Play424081069 = function(arg_288_0, arg_288_1)
		arg_288_1.time_ = 0
		arg_288_1.frameCnt_ = 0
		arg_288_1.state_ = "playing"
		arg_288_1.curTalkId_ = 424081069
		arg_288_1.duration_ = 5

		SetActive(arg_288_1.tipsGo_, false)

		function arg_288_1.onSingleLineFinish_()
			arg_288_1.onSingleLineUpdate_ = nil
			arg_288_1.onSingleLineFinish_ = nil
			arg_288_1.state_ = "waiting"
		end

		function arg_288_1.playNext_(arg_290_0)
			if arg_290_0 == 1 then
				arg_288_0:Play424081070(arg_288_1)
			end
		end

		function arg_288_1.onSingleLineUpdate_(arg_291_0)
			local var_291_0 = arg_288_1.actors_["10154"]
			local var_291_1 = 0

			if var_291_1 < arg_288_1.time_ and arg_288_1.time_ <= var_291_1 + arg_291_0 and not isNil(var_291_0) and arg_288_1.var_.actorSpriteComps10154 == nil then
				arg_288_1.var_.actorSpriteComps10154 = var_291_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_291_2 = 0.2

			if var_291_1 <= arg_288_1.time_ and arg_288_1.time_ < var_291_1 + var_291_2 and not isNil(var_291_0) then
				local var_291_3 = (arg_288_1.time_ - var_291_1) / var_291_2

				if arg_288_1.var_.actorSpriteComps10154 then
					for iter_291_0, iter_291_1 in pairs(arg_288_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_291_1 then
							if arg_288_1.isInRecall_ then
								local var_291_4 = Mathf.Lerp(iter_291_1.color.r, arg_288_1.hightColor2.r, var_291_3)
								local var_291_5 = Mathf.Lerp(iter_291_1.color.g, arg_288_1.hightColor2.g, var_291_3)
								local var_291_6 = Mathf.Lerp(iter_291_1.color.b, arg_288_1.hightColor2.b, var_291_3)

								iter_291_1.color = Color.New(var_291_4, var_291_5, var_291_6)
							else
								local var_291_7 = Mathf.Lerp(iter_291_1.color.r, 0.5, var_291_3)

								iter_291_1.color = Color.New(var_291_7, var_291_7, var_291_7)
							end
						end
					end
				end
			end

			if arg_288_1.time_ >= var_291_1 + var_291_2 and arg_288_1.time_ < var_291_1 + var_291_2 + arg_291_0 and not isNil(var_291_0) and arg_288_1.var_.actorSpriteComps10154 then
				for iter_291_2, iter_291_3 in pairs(arg_288_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_291_3 then
						if arg_288_1.isInRecall_ then
							iter_291_3.color = arg_288_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_291_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_288_1.var_.actorSpriteComps10154 = nil
			end

			local var_291_8 = 0
			local var_291_9 = 0.25

			if var_291_8 < arg_288_1.time_ and arg_288_1.time_ <= var_291_8 + arg_291_0 then
				arg_288_1.talkMaxDuration = 0
				arg_288_1.dialogCg_.alpha = 1

				arg_288_1.dialog_:SetActive(true)
				SetActive(arg_288_1.leftNameGo_, true)

				local var_291_10 = arg_288_1:FormatText(StoryNameCfg[7].name)

				arg_288_1.leftNameTxt_.text = var_291_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_288_1.leftNameTxt_.transform)

				arg_288_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_288_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_288_1:RecordName(arg_288_1.leftNameTxt_.text)
				SetActive(arg_288_1.iconTrs_.gameObject, true)
				arg_288_1.iconController_:SetSelectedState("hero")

				arg_288_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_288_1.callingController_:SetSelectedState("normal")

				arg_288_1.keyicon_.color = Color.New(1, 1, 1)
				arg_288_1.icon_.color = Color.New(1, 1, 1)

				local var_291_11 = arg_288_1:GetWordFromCfg(424081069)
				local var_291_12 = arg_288_1:FormatText(var_291_11.content)

				arg_288_1.text_.text = var_291_12

				LuaForUtil.ClearLinePrefixSymbol(arg_288_1.text_)

				local var_291_13 = 10
				local var_291_14 = utf8.len(var_291_12)
				local var_291_15 = var_291_13 <= 0 and var_291_9 or var_291_9 * (var_291_14 / var_291_13)

				if var_291_15 > 0 and var_291_9 < var_291_15 then
					arg_288_1.talkMaxDuration = var_291_15

					if var_291_15 + var_291_8 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_15 + var_291_8
					end
				end

				arg_288_1.text_.text = var_291_12
				arg_288_1.typewritter.percent = 0

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(false)
				arg_288_1:RecordContent(arg_288_1.text_.text)
			end

			local var_291_16 = math.max(var_291_9, arg_288_1.talkMaxDuration)

			if var_291_8 <= arg_288_1.time_ and arg_288_1.time_ < var_291_8 + var_291_16 then
				arg_288_1.typewritter.percent = (arg_288_1.time_ - var_291_8) / var_291_16

				arg_288_1.typewritter:SetDirty()
			end

			if arg_288_1.time_ >= var_291_8 + var_291_16 and arg_288_1.time_ < var_291_8 + var_291_16 + arg_291_0 then
				arg_288_1.typewritter.percent = 1

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(true)
			end
		end

		arg_288_1.nodeConfigList_ = {}

		arg_288_1:InitPlayNodeList()
	end,
	Play424081070 = function(arg_292_0, arg_292_1)
		arg_292_1.time_ = 0
		arg_292_1.frameCnt_ = 0
		arg_292_1.state_ = "playing"
		arg_292_1.curTalkId_ = 424081070
		arg_292_1.duration_ = 2.37

		local var_292_0 = {
			zh = 2.366,
			ja = 1.4
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
				arg_292_0:Play424081071(arg_292_1)
			end
		end

		function arg_292_1.onSingleLineUpdate_(arg_295_0)
			local var_295_0 = arg_292_1.actors_["10154"]
			local var_295_1 = 0

			if var_295_1 < arg_292_1.time_ and arg_292_1.time_ <= var_295_1 + arg_295_0 and not isNil(var_295_0) and arg_292_1.var_.actorSpriteComps10154 == nil then
				arg_292_1.var_.actorSpriteComps10154 = var_295_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_295_2 = 0.2

			if var_295_1 <= arg_292_1.time_ and arg_292_1.time_ < var_295_1 + var_295_2 and not isNil(var_295_0) then
				local var_295_3 = (arg_292_1.time_ - var_295_1) / var_295_2

				if arg_292_1.var_.actorSpriteComps10154 then
					for iter_295_0, iter_295_1 in pairs(arg_292_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_295_1 then
							if arg_292_1.isInRecall_ then
								local var_295_4 = Mathf.Lerp(iter_295_1.color.r, arg_292_1.hightColor1.r, var_295_3)
								local var_295_5 = Mathf.Lerp(iter_295_1.color.g, arg_292_1.hightColor1.g, var_295_3)
								local var_295_6 = Mathf.Lerp(iter_295_1.color.b, arg_292_1.hightColor1.b, var_295_3)

								iter_295_1.color = Color.New(var_295_4, var_295_5, var_295_6)
							else
								local var_295_7 = Mathf.Lerp(iter_295_1.color.r, 1, var_295_3)

								iter_295_1.color = Color.New(var_295_7, var_295_7, var_295_7)
							end
						end
					end
				end
			end

			if arg_292_1.time_ >= var_295_1 + var_295_2 and arg_292_1.time_ < var_295_1 + var_295_2 + arg_295_0 and not isNil(var_295_0) and arg_292_1.var_.actorSpriteComps10154 then
				for iter_295_2, iter_295_3 in pairs(arg_292_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_295_3 then
						if arg_292_1.isInRecall_ then
							iter_295_3.color = arg_292_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_295_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_292_1.var_.actorSpriteComps10154 = nil
			end

			local var_295_8 = arg_292_1.actors_["10154"].transform
			local var_295_9 = 0

			if var_295_9 < arg_292_1.time_ and arg_292_1.time_ <= var_295_9 + arg_295_0 then
				arg_292_1.var_.moveOldPos10154 = var_295_8.localPosition
				var_295_8.localScale = Vector3.New(1, 1, 1)

				arg_292_1:CheckSpriteTmpPos("10154", 3)

				local var_295_10 = var_295_8.childCount

				for iter_295_4 = 0, var_295_10 - 1 do
					local var_295_11 = var_295_8:GetChild(iter_295_4)

					if var_295_11.name == "split_2" then
						var_295_11:SetAsLastSibling()
						var_295_11.gameObject:SetActive(true)

						arg_292_1.var_.actorSpriteSplit10154 = var_295_11.gameObject:GetComponent(typeof(Image))

						arg_292_1.var_.actorSpriteSplit10154:SetAlpha(0)
					end
				end
			end

			local var_295_12 = 0.5

			if var_295_9 <= arg_292_1.time_ and arg_292_1.time_ < var_295_9 + var_295_12 then
				local var_295_13 = (arg_292_1.time_ - var_295_9) / var_295_12
				local var_295_14 = Vector3.New(-20, -338, -538)

				var_295_8.localPosition = Vector3.Lerp(arg_292_1.var_.moveOldPos10154, var_295_14, var_295_13)

				if arg_292_1.var_.actorSpriteSplit10154 ~= nil then
					arg_292_1.var_.actorSpriteSplit10154:SetAlpha(var_295_13)
				end
			end

			if arg_292_1.time_ >= var_295_9 + var_295_12 and arg_292_1.time_ < var_295_9 + var_295_12 + arg_295_0 then
				var_295_8.localPosition = Vector3.New(-20, -338, -538)

				if arg_292_1.var_.actorSpriteSplit10154 ~= nil then
					arg_292_1.var_.actorSpriteSplit10154:SetAlpha(1)
				end
			end

			local var_295_15 = 0
			local var_295_16 = 0.25

			if var_295_15 < arg_292_1.time_ and arg_292_1.time_ <= var_295_15 + arg_295_0 then
				arg_292_1.talkMaxDuration = 0
				arg_292_1.dialogCg_.alpha = 1

				arg_292_1.dialog_:SetActive(true)
				SetActive(arg_292_1.leftNameGo_, true)

				local var_295_17 = arg_292_1:FormatText(StoryNameCfg[1392].name)

				arg_292_1.leftNameTxt_.text = var_295_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_292_1.leftNameTxt_.transform)

				arg_292_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_292_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_292_1:RecordName(arg_292_1.leftNameTxt_.text)
				SetActive(arg_292_1.iconTrs_.gameObject, false)
				arg_292_1.callingController_:SetSelectedState("normal")

				local var_295_18 = arg_292_1:GetWordFromCfg(424081070)
				local var_295_19 = arg_292_1:FormatText(var_295_18.content)

				arg_292_1.text_.text = var_295_19

				LuaForUtil.ClearLinePrefixSymbol(arg_292_1.text_)

				local var_295_20 = 10
				local var_295_21 = utf8.len(var_295_19)
				local var_295_22 = var_295_20 <= 0 and var_295_16 or var_295_16 * (var_295_21 / var_295_20)

				if var_295_22 > 0 and var_295_16 < var_295_22 then
					arg_292_1.talkMaxDuration = var_295_22

					if var_295_22 + var_295_15 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_22 + var_295_15
					end
				end

				arg_292_1.text_.text = var_295_19
				arg_292_1.typewritter.percent = 0

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424081", "424081070", "story_v_out_424081.awb") ~= 0 then
					local var_295_23 = manager.audio:GetVoiceLength("story_v_out_424081", "424081070", "story_v_out_424081.awb") / 1000

					if var_295_23 + var_295_15 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_23 + var_295_15
					end

					if var_295_18.prefab_name ~= "" and arg_292_1.actors_[var_295_18.prefab_name] ~= nil then
						local var_295_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_292_1.actors_[var_295_18.prefab_name].transform, "story_v_out_424081", "424081070", "story_v_out_424081.awb")

						arg_292_1:RecordAudio("424081070", var_295_24)
						arg_292_1:RecordAudio("424081070", var_295_24)
					else
						arg_292_1:AudioAction("play", "voice", "story_v_out_424081", "424081070", "story_v_out_424081.awb")
					end

					arg_292_1:RecordHistoryTalkVoice("story_v_out_424081", "424081070", "story_v_out_424081.awb")
				end

				arg_292_1:RecordContent(arg_292_1.text_.text)
			end

			local var_295_25 = math.max(var_295_16, arg_292_1.talkMaxDuration)

			if var_295_15 <= arg_292_1.time_ and arg_292_1.time_ < var_295_15 + var_295_25 then
				arg_292_1.typewritter.percent = (arg_292_1.time_ - var_295_15) / var_295_25

				arg_292_1.typewritter:SetDirty()
			end

			if arg_292_1.time_ >= var_295_15 + var_295_25 and arg_292_1.time_ < var_295_15 + var_295_25 + arg_295_0 then
				arg_292_1.typewritter.percent = 1

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(true)
			end
		end

		arg_292_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10154",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_292_1:InitPlayNodeList()
	end,
	Play424081071 = function(arg_296_0, arg_296_1)
		arg_296_1.time_ = 0
		arg_296_1.frameCnt_ = 0
		arg_296_1.state_ = "playing"
		arg_296_1.curTalkId_ = 424081071
		arg_296_1.duration_ = 5

		SetActive(arg_296_1.tipsGo_, false)

		function arg_296_1.onSingleLineFinish_()
			arg_296_1.onSingleLineUpdate_ = nil
			arg_296_1.onSingleLineFinish_ = nil
			arg_296_1.state_ = "waiting"
		end

		function arg_296_1.playNext_(arg_298_0)
			if arg_298_0 == 1 then
				arg_296_0:Play424081072(arg_296_1)
			end
		end

		function arg_296_1.onSingleLineUpdate_(arg_299_0)
			local var_299_0 = arg_296_1.actors_["10154"]
			local var_299_1 = 0

			if var_299_1 < arg_296_1.time_ and arg_296_1.time_ <= var_299_1 + arg_299_0 and not isNil(var_299_0) and arg_296_1.var_.actorSpriteComps10154 == nil then
				arg_296_1.var_.actorSpriteComps10154 = var_299_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_299_2 = 0.2

			if var_299_1 <= arg_296_1.time_ and arg_296_1.time_ < var_299_1 + var_299_2 and not isNil(var_299_0) then
				local var_299_3 = (arg_296_1.time_ - var_299_1) / var_299_2

				if arg_296_1.var_.actorSpriteComps10154 then
					for iter_299_0, iter_299_1 in pairs(arg_296_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_299_1 then
							if arg_296_1.isInRecall_ then
								local var_299_4 = Mathf.Lerp(iter_299_1.color.r, arg_296_1.hightColor2.r, var_299_3)
								local var_299_5 = Mathf.Lerp(iter_299_1.color.g, arg_296_1.hightColor2.g, var_299_3)
								local var_299_6 = Mathf.Lerp(iter_299_1.color.b, arg_296_1.hightColor2.b, var_299_3)

								iter_299_1.color = Color.New(var_299_4, var_299_5, var_299_6)
							else
								local var_299_7 = Mathf.Lerp(iter_299_1.color.r, 0.5, var_299_3)

								iter_299_1.color = Color.New(var_299_7, var_299_7, var_299_7)
							end
						end
					end
				end
			end

			if arg_296_1.time_ >= var_299_1 + var_299_2 and arg_296_1.time_ < var_299_1 + var_299_2 + arg_299_0 and not isNil(var_299_0) and arg_296_1.var_.actorSpriteComps10154 then
				for iter_299_2, iter_299_3 in pairs(arg_296_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_299_3 then
						if arg_296_1.isInRecall_ then
							iter_299_3.color = arg_296_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_299_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_296_1.var_.actorSpriteComps10154 = nil
			end

			local var_299_8 = 0
			local var_299_9 = 1

			if var_299_8 < arg_296_1.time_ and arg_296_1.time_ <= var_299_8 + arg_299_0 then
				arg_296_1.talkMaxDuration = 0
				arg_296_1.dialogCg_.alpha = 1

				arg_296_1.dialog_:SetActive(true)
				SetActive(arg_296_1.leftNameGo_, false)

				arg_296_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_296_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_296_1:RecordName(arg_296_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_296_1.iconTrs_.gameObject, false)
				arg_296_1.callingController_:SetSelectedState("normal")

				local var_299_10 = arg_296_1:GetWordFromCfg(424081071)
				local var_299_11 = arg_296_1:FormatText(var_299_10.content)

				arg_296_1.text_.text = var_299_11

				LuaForUtil.ClearLinePrefixSymbol(arg_296_1.text_)

				local var_299_12 = 40
				local var_299_13 = utf8.len(var_299_11)
				local var_299_14 = var_299_12 <= 0 and var_299_9 or var_299_9 * (var_299_13 / var_299_12)

				if var_299_14 > 0 and var_299_9 < var_299_14 then
					arg_296_1.talkMaxDuration = var_299_14

					if var_299_14 + var_299_8 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_14 + var_299_8
					end
				end

				arg_296_1.text_.text = var_299_11
				arg_296_1.typewritter.percent = 0

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(false)
				arg_296_1:RecordContent(arg_296_1.text_.text)
			end

			local var_299_15 = math.max(var_299_9, arg_296_1.talkMaxDuration)

			if var_299_8 <= arg_296_1.time_ and arg_296_1.time_ < var_299_8 + var_299_15 then
				arg_296_1.typewritter.percent = (arg_296_1.time_ - var_299_8) / var_299_15

				arg_296_1.typewritter:SetDirty()
			end

			if arg_296_1.time_ >= var_299_8 + var_299_15 and arg_296_1.time_ < var_299_8 + var_299_15 + arg_299_0 then
				arg_296_1.typewritter.percent = 1

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(true)
			end
		end

		arg_296_1.nodeConfigList_ = {}

		arg_296_1:InitPlayNodeList()
	end,
	Play424081072 = function(arg_300_0, arg_300_1)
		arg_300_1.time_ = 0
		arg_300_1.frameCnt_ = 0
		arg_300_1.state_ = "playing"
		arg_300_1.curTalkId_ = 424081072
		arg_300_1.duration_ = 3.47

		local var_300_0 = {
			zh = 3.466,
			ja = 1.8
		}
		local var_300_1 = manager.audio:GetLocalizationFlag()

		if var_300_0[var_300_1] ~= nil then
			arg_300_1.duration_ = var_300_0[var_300_1]
		end

		SetActive(arg_300_1.tipsGo_, false)

		function arg_300_1.onSingleLineFinish_()
			arg_300_1.onSingleLineUpdate_ = nil
			arg_300_1.onSingleLineFinish_ = nil
			arg_300_1.state_ = "waiting"
		end

		function arg_300_1.playNext_(arg_302_0)
			if arg_302_0 == 1 then
				arg_300_0:Play424081073(arg_300_1)
			end
		end

		function arg_300_1.onSingleLineUpdate_(arg_303_0)
			local var_303_0 = arg_300_1.actors_["10154"]
			local var_303_1 = 0

			if var_303_1 < arg_300_1.time_ and arg_300_1.time_ <= var_303_1 + arg_303_0 and not isNil(var_303_0) and arg_300_1.var_.actorSpriteComps10154 == nil then
				arg_300_1.var_.actorSpriteComps10154 = var_303_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_303_2 = 0.2

			if var_303_1 <= arg_300_1.time_ and arg_300_1.time_ < var_303_1 + var_303_2 and not isNil(var_303_0) then
				local var_303_3 = (arg_300_1.time_ - var_303_1) / var_303_2

				if arg_300_1.var_.actorSpriteComps10154 then
					for iter_303_0, iter_303_1 in pairs(arg_300_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_303_1 then
							if arg_300_1.isInRecall_ then
								local var_303_4 = Mathf.Lerp(iter_303_1.color.r, arg_300_1.hightColor1.r, var_303_3)
								local var_303_5 = Mathf.Lerp(iter_303_1.color.g, arg_300_1.hightColor1.g, var_303_3)
								local var_303_6 = Mathf.Lerp(iter_303_1.color.b, arg_300_1.hightColor1.b, var_303_3)

								iter_303_1.color = Color.New(var_303_4, var_303_5, var_303_6)
							else
								local var_303_7 = Mathf.Lerp(iter_303_1.color.r, 1, var_303_3)

								iter_303_1.color = Color.New(var_303_7, var_303_7, var_303_7)
							end
						end
					end
				end
			end

			if arg_300_1.time_ >= var_303_1 + var_303_2 and arg_300_1.time_ < var_303_1 + var_303_2 + arg_303_0 and not isNil(var_303_0) and arg_300_1.var_.actorSpriteComps10154 then
				for iter_303_2, iter_303_3 in pairs(arg_300_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_303_3 then
						if arg_300_1.isInRecall_ then
							iter_303_3.color = arg_300_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_303_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_300_1.var_.actorSpriteComps10154 = nil
			end

			local var_303_8 = arg_300_1.actors_["10154"].transform
			local var_303_9 = 0

			if var_303_9 < arg_300_1.time_ and arg_300_1.time_ <= var_303_9 + arg_303_0 then
				arg_300_1.var_.moveOldPos10154 = var_303_8.localPosition
				var_303_8.localScale = Vector3.New(1, 1, 1)

				arg_300_1:CheckSpriteTmpPos("10154", 3)

				local var_303_10 = var_303_8.childCount

				for iter_303_4 = 0, var_303_10 - 1 do
					local var_303_11 = var_303_8:GetChild(iter_303_4)

					if var_303_11.name == "split_1" then
						var_303_11:SetAsLastSibling()
						var_303_11.gameObject:SetActive(true)

						arg_300_1.var_.actorSpriteSplit10154 = var_303_11.gameObject:GetComponent(typeof(Image))

						arg_300_1.var_.actorSpriteSplit10154:SetAlpha(0)
					end
				end
			end

			local var_303_12 = 0.001

			if var_303_9 <= arg_300_1.time_ and arg_300_1.time_ < var_303_9 + var_303_12 then
				local var_303_13 = (arg_300_1.time_ - var_303_9) / var_303_12
				local var_303_14 = Vector3.New(-20, -338, -538)

				var_303_8.localPosition = Vector3.Lerp(arg_300_1.var_.moveOldPos10154, var_303_14, var_303_13)

				if arg_300_1.var_.actorSpriteSplit10154 ~= nil then
					arg_300_1.var_.actorSpriteSplit10154:SetAlpha(var_303_13)
				end
			end

			if arg_300_1.time_ >= var_303_9 + var_303_12 and arg_300_1.time_ < var_303_9 + var_303_12 + arg_303_0 then
				var_303_8.localPosition = Vector3.New(-20, -338, -538)

				if arg_300_1.var_.actorSpriteSplit10154 ~= nil then
					arg_300_1.var_.actorSpriteSplit10154:SetAlpha(1)
				end
			end

			local var_303_15 = 0
			local var_303_16 = 0.35

			if var_303_15 < arg_300_1.time_ and arg_300_1.time_ <= var_303_15 + arg_303_0 then
				arg_300_1.talkMaxDuration = 0
				arg_300_1.dialogCg_.alpha = 1

				arg_300_1.dialog_:SetActive(true)
				SetActive(arg_300_1.leftNameGo_, true)

				local var_303_17 = arg_300_1:FormatText(StoryNameCfg[1392].name)

				arg_300_1.leftNameTxt_.text = var_303_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_300_1.leftNameTxt_.transform)

				arg_300_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_300_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_300_1:RecordName(arg_300_1.leftNameTxt_.text)
				SetActive(arg_300_1.iconTrs_.gameObject, false)
				arg_300_1.callingController_:SetSelectedState("normal")

				local var_303_18 = arg_300_1:GetWordFromCfg(424081072)
				local var_303_19 = arg_300_1:FormatText(var_303_18.content)

				arg_300_1.text_.text = var_303_19

				LuaForUtil.ClearLinePrefixSymbol(arg_300_1.text_)

				local var_303_20 = 14
				local var_303_21 = utf8.len(var_303_19)
				local var_303_22 = var_303_20 <= 0 and var_303_16 or var_303_16 * (var_303_21 / var_303_20)

				if var_303_22 > 0 and var_303_16 < var_303_22 then
					arg_300_1.talkMaxDuration = var_303_22

					if var_303_22 + var_303_15 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_22 + var_303_15
					end
				end

				arg_300_1.text_.text = var_303_19
				arg_300_1.typewritter.percent = 0

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424081", "424081072", "story_v_out_424081.awb") ~= 0 then
					local var_303_23 = manager.audio:GetVoiceLength("story_v_out_424081", "424081072", "story_v_out_424081.awb") / 1000

					if var_303_23 + var_303_15 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_23 + var_303_15
					end

					if var_303_18.prefab_name ~= "" and arg_300_1.actors_[var_303_18.prefab_name] ~= nil then
						local var_303_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_300_1.actors_[var_303_18.prefab_name].transform, "story_v_out_424081", "424081072", "story_v_out_424081.awb")

						arg_300_1:RecordAudio("424081072", var_303_24)
						arg_300_1:RecordAudio("424081072", var_303_24)
					else
						arg_300_1:AudioAction("play", "voice", "story_v_out_424081", "424081072", "story_v_out_424081.awb")
					end

					arg_300_1:RecordHistoryTalkVoice("story_v_out_424081", "424081072", "story_v_out_424081.awb")
				end

				arg_300_1:RecordContent(arg_300_1.text_.text)
			end

			local var_303_25 = math.max(var_303_16, arg_300_1.talkMaxDuration)

			if var_303_15 <= arg_300_1.time_ and arg_300_1.time_ < var_303_15 + var_303_25 then
				arg_300_1.typewritter.percent = (arg_300_1.time_ - var_303_15) / var_303_25

				arg_300_1.typewritter:SetDirty()
			end

			if arg_300_1.time_ >= var_303_15 + var_303_25 and arg_300_1.time_ < var_303_15 + var_303_25 + arg_303_0 then
				arg_300_1.typewritter.percent = 1

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(true)
			end
		end

		arg_300_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10154",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_300_1:InitPlayNodeList()
	end,
	Play424081073 = function(arg_304_0, arg_304_1)
		arg_304_1.time_ = 0
		arg_304_1.frameCnt_ = 0
		arg_304_1.state_ = "playing"
		arg_304_1.curTalkId_ = 424081073
		arg_304_1.duration_ = 5

		SetActive(arg_304_1.tipsGo_, false)

		function arg_304_1.onSingleLineFinish_()
			arg_304_1.onSingleLineUpdate_ = nil
			arg_304_1.onSingleLineFinish_ = nil
			arg_304_1.state_ = "waiting"
		end

		function arg_304_1.playNext_(arg_306_0)
			if arg_306_0 == 1 then
				arg_304_0:Play424081074(arg_304_1)
			end
		end

		function arg_304_1.onSingleLineUpdate_(arg_307_0)
			local var_307_0 = arg_304_1.actors_["10154"]
			local var_307_1 = 0

			if var_307_1 < arg_304_1.time_ and arg_304_1.time_ <= var_307_1 + arg_307_0 and not isNil(var_307_0) and arg_304_1.var_.actorSpriteComps10154 == nil then
				arg_304_1.var_.actorSpriteComps10154 = var_307_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_307_2 = 0.2

			if var_307_1 <= arg_304_1.time_ and arg_304_1.time_ < var_307_1 + var_307_2 and not isNil(var_307_0) then
				local var_307_3 = (arg_304_1.time_ - var_307_1) / var_307_2

				if arg_304_1.var_.actorSpriteComps10154 then
					for iter_307_0, iter_307_1 in pairs(arg_304_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_307_1 then
							if arg_304_1.isInRecall_ then
								local var_307_4 = Mathf.Lerp(iter_307_1.color.r, arg_304_1.hightColor2.r, var_307_3)
								local var_307_5 = Mathf.Lerp(iter_307_1.color.g, arg_304_1.hightColor2.g, var_307_3)
								local var_307_6 = Mathf.Lerp(iter_307_1.color.b, arg_304_1.hightColor2.b, var_307_3)

								iter_307_1.color = Color.New(var_307_4, var_307_5, var_307_6)
							else
								local var_307_7 = Mathf.Lerp(iter_307_1.color.r, 0.5, var_307_3)

								iter_307_1.color = Color.New(var_307_7, var_307_7, var_307_7)
							end
						end
					end
				end
			end

			if arg_304_1.time_ >= var_307_1 + var_307_2 and arg_304_1.time_ < var_307_1 + var_307_2 + arg_307_0 and not isNil(var_307_0) and arg_304_1.var_.actorSpriteComps10154 then
				for iter_307_2, iter_307_3 in pairs(arg_304_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_307_3 then
						if arg_304_1.isInRecall_ then
							iter_307_3.color = arg_304_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_307_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_304_1.var_.actorSpriteComps10154 = nil
			end

			local var_307_8 = 0
			local var_307_9 = 1.3

			if var_307_8 < arg_304_1.time_ and arg_304_1.time_ <= var_307_8 + arg_307_0 then
				arg_304_1.talkMaxDuration = 0
				arg_304_1.dialogCg_.alpha = 1

				arg_304_1.dialog_:SetActive(true)
				SetActive(arg_304_1.leftNameGo_, false)

				arg_304_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_304_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_304_1:RecordName(arg_304_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_304_1.iconTrs_.gameObject, false)
				arg_304_1.callingController_:SetSelectedState("normal")

				local var_307_10 = arg_304_1:GetWordFromCfg(424081073)
				local var_307_11 = arg_304_1:FormatText(var_307_10.content)

				arg_304_1.text_.text = var_307_11

				LuaForUtil.ClearLinePrefixSymbol(arg_304_1.text_)

				local var_307_12 = 52
				local var_307_13 = utf8.len(var_307_11)
				local var_307_14 = var_307_12 <= 0 and var_307_9 or var_307_9 * (var_307_13 / var_307_12)

				if var_307_14 > 0 and var_307_9 < var_307_14 then
					arg_304_1.talkMaxDuration = var_307_14

					if var_307_14 + var_307_8 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_14 + var_307_8
					end
				end

				arg_304_1.text_.text = var_307_11
				arg_304_1.typewritter.percent = 0

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(false)
				arg_304_1:RecordContent(arg_304_1.text_.text)
			end

			local var_307_15 = math.max(var_307_9, arg_304_1.talkMaxDuration)

			if var_307_8 <= arg_304_1.time_ and arg_304_1.time_ < var_307_8 + var_307_15 then
				arg_304_1.typewritter.percent = (arg_304_1.time_ - var_307_8) / var_307_15

				arg_304_1.typewritter:SetDirty()
			end

			if arg_304_1.time_ >= var_307_8 + var_307_15 and arg_304_1.time_ < var_307_8 + var_307_15 + arg_307_0 then
				arg_304_1.typewritter.percent = 1

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(true)
			end
		end

		arg_304_1.nodeConfigList_ = {}

		arg_304_1:InitPlayNodeList()
	end,
	Play424081074 = function(arg_308_0, arg_308_1)
		arg_308_1.time_ = 0
		arg_308_1.frameCnt_ = 0
		arg_308_1.state_ = "playing"
		arg_308_1.curTalkId_ = 424081074
		arg_308_1.duration_ = 8.93

		local var_308_0 = {
			zh = 8.933,
			ja = 7
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
				arg_308_0:Play424081075(arg_308_1)
			end
		end

		function arg_308_1.onSingleLineUpdate_(arg_311_0)
			local var_311_0 = arg_308_1.actors_["10154"]
			local var_311_1 = 0

			if var_311_1 < arg_308_1.time_ and arg_308_1.time_ <= var_311_1 + arg_311_0 and not isNil(var_311_0) and arg_308_1.var_.actorSpriteComps10154 == nil then
				arg_308_1.var_.actorSpriteComps10154 = var_311_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_311_2 = 0.2

			if var_311_1 <= arg_308_1.time_ and arg_308_1.time_ < var_311_1 + var_311_2 and not isNil(var_311_0) then
				local var_311_3 = (arg_308_1.time_ - var_311_1) / var_311_2

				if arg_308_1.var_.actorSpriteComps10154 then
					for iter_311_0, iter_311_1 in pairs(arg_308_1.var_.actorSpriteComps10154:ToTable()) do
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

			if arg_308_1.time_ >= var_311_1 + var_311_2 and arg_308_1.time_ < var_311_1 + var_311_2 + arg_311_0 and not isNil(var_311_0) and arg_308_1.var_.actorSpriteComps10154 then
				for iter_311_2, iter_311_3 in pairs(arg_308_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_311_3 then
						if arg_308_1.isInRecall_ then
							iter_311_3.color = arg_308_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_311_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_308_1.var_.actorSpriteComps10154 = nil
			end

			local var_311_8 = arg_308_1.actors_["10154"].transform
			local var_311_9 = 0

			if var_311_9 < arg_308_1.time_ and arg_308_1.time_ <= var_311_9 + arg_311_0 then
				arg_308_1.var_.moveOldPos10154 = var_311_8.localPosition
				var_311_8.localScale = Vector3.New(1, 1, 1)

				arg_308_1:CheckSpriteTmpPos("10154", 3)

				local var_311_10 = var_311_8.childCount

				for iter_311_4 = 0, var_311_10 - 1 do
					local var_311_11 = var_311_8:GetChild(iter_311_4)

					if var_311_11.name == "split_5" then
						var_311_11:SetAsLastSibling()
						var_311_11.gameObject:SetActive(true)

						arg_308_1.var_.actorSpriteSplit10154 = var_311_11.gameObject:GetComponent(typeof(Image))

						arg_308_1.var_.actorSpriteSplit10154:SetAlpha(0)
					end
				end
			end

			local var_311_12 = 0.5

			if var_311_9 <= arg_308_1.time_ and arg_308_1.time_ < var_311_9 + var_311_12 then
				local var_311_13 = (arg_308_1.time_ - var_311_9) / var_311_12
				local var_311_14 = Vector3.New(-20, -338, -538)

				var_311_8.localPosition = Vector3.Lerp(arg_308_1.var_.moveOldPos10154, var_311_14, var_311_13)

				if arg_308_1.var_.actorSpriteSplit10154 ~= nil then
					arg_308_1.var_.actorSpriteSplit10154:SetAlpha(var_311_13)
				end
			end

			if arg_308_1.time_ >= var_311_9 + var_311_12 and arg_308_1.time_ < var_311_9 + var_311_12 + arg_311_0 then
				var_311_8.localPosition = Vector3.New(-20, -338, -538)

				if arg_308_1.var_.actorSpriteSplit10154 ~= nil then
					arg_308_1.var_.actorSpriteSplit10154:SetAlpha(1)
				end
			end

			local var_311_15 = 0
			local var_311_16 = 0.975

			if var_311_15 < arg_308_1.time_ and arg_308_1.time_ <= var_311_15 + arg_311_0 then
				arg_308_1.talkMaxDuration = 0
				arg_308_1.dialogCg_.alpha = 1

				arg_308_1.dialog_:SetActive(true)
				SetActive(arg_308_1.leftNameGo_, true)

				local var_311_17 = arg_308_1:FormatText(StoryNameCfg[1392].name)

				arg_308_1.leftNameTxt_.text = var_311_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_308_1.leftNameTxt_.transform)

				arg_308_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_308_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_308_1:RecordName(arg_308_1.leftNameTxt_.text)
				SetActive(arg_308_1.iconTrs_.gameObject, false)
				arg_308_1.callingController_:SetSelectedState("normal")

				local var_311_18 = arg_308_1:GetWordFromCfg(424081074)
				local var_311_19 = arg_308_1:FormatText(var_311_18.content)

				arg_308_1.text_.text = var_311_19

				LuaForUtil.ClearLinePrefixSymbol(arg_308_1.text_)

				local var_311_20 = 39
				local var_311_21 = utf8.len(var_311_19)
				local var_311_22 = var_311_20 <= 0 and var_311_16 or var_311_16 * (var_311_21 / var_311_20)

				if var_311_22 > 0 and var_311_16 < var_311_22 then
					arg_308_1.talkMaxDuration = var_311_22

					if var_311_22 + var_311_15 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_22 + var_311_15
					end
				end

				arg_308_1.text_.text = var_311_19
				arg_308_1.typewritter.percent = 0

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424081", "424081074", "story_v_out_424081.awb") ~= 0 then
					local var_311_23 = manager.audio:GetVoiceLength("story_v_out_424081", "424081074", "story_v_out_424081.awb") / 1000

					if var_311_23 + var_311_15 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_23 + var_311_15
					end

					if var_311_18.prefab_name ~= "" and arg_308_1.actors_[var_311_18.prefab_name] ~= nil then
						local var_311_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_308_1.actors_[var_311_18.prefab_name].transform, "story_v_out_424081", "424081074", "story_v_out_424081.awb")

						arg_308_1:RecordAudio("424081074", var_311_24)
						arg_308_1:RecordAudio("424081074", var_311_24)
					else
						arg_308_1:AudioAction("play", "voice", "story_v_out_424081", "424081074", "story_v_out_424081.awb")
					end

					arg_308_1:RecordHistoryTalkVoice("story_v_out_424081", "424081074", "story_v_out_424081.awb")
				end

				arg_308_1:RecordContent(arg_308_1.text_.text)
			end

			local var_311_25 = math.max(var_311_16, arg_308_1.talkMaxDuration)

			if var_311_15 <= arg_308_1.time_ and arg_308_1.time_ < var_311_15 + var_311_25 then
				arg_308_1.typewritter.percent = (arg_308_1.time_ - var_311_15) / var_311_25

				arg_308_1.typewritter:SetDirty()
			end

			if arg_308_1.time_ >= var_311_15 + var_311_25 and arg_308_1.time_ < var_311_15 + var_311_25 + arg_311_0 then
				arg_308_1.typewritter.percent = 1

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(true)
			end
		end

		arg_308_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10154",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_308_1:InitPlayNodeList()
	end,
	Play424081075 = function(arg_312_0, arg_312_1)
		arg_312_1.time_ = 0
		arg_312_1.frameCnt_ = 0
		arg_312_1.state_ = "playing"
		arg_312_1.curTalkId_ = 424081075
		arg_312_1.duration_ = 5

		SetActive(arg_312_1.tipsGo_, false)

		function arg_312_1.onSingleLineFinish_()
			arg_312_1.onSingleLineUpdate_ = nil
			arg_312_1.onSingleLineFinish_ = nil
			arg_312_1.state_ = "waiting"
		end

		function arg_312_1.playNext_(arg_314_0)
			if arg_314_0 == 1 then
				arg_312_0:Play424081076(arg_312_1)
			end
		end

		function arg_312_1.onSingleLineUpdate_(arg_315_0)
			local var_315_0 = arg_312_1.actors_["10154"]
			local var_315_1 = 0

			if var_315_1 < arg_312_1.time_ and arg_312_1.time_ <= var_315_1 + arg_315_0 and not isNil(var_315_0) and arg_312_1.var_.actorSpriteComps10154 == nil then
				arg_312_1.var_.actorSpriteComps10154 = var_315_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_315_2 = 0.2

			if var_315_1 <= arg_312_1.time_ and arg_312_1.time_ < var_315_1 + var_315_2 and not isNil(var_315_0) then
				local var_315_3 = (arg_312_1.time_ - var_315_1) / var_315_2

				if arg_312_1.var_.actorSpriteComps10154 then
					for iter_315_0, iter_315_1 in pairs(arg_312_1.var_.actorSpriteComps10154:ToTable()) do
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

			if arg_312_1.time_ >= var_315_1 + var_315_2 and arg_312_1.time_ < var_315_1 + var_315_2 + arg_315_0 and not isNil(var_315_0) and arg_312_1.var_.actorSpriteComps10154 then
				for iter_315_2, iter_315_3 in pairs(arg_312_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_315_3 then
						if arg_312_1.isInRecall_ then
							iter_315_3.color = arg_312_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_315_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_312_1.var_.actorSpriteComps10154 = nil
			end

			local var_315_8 = 0
			local var_315_9 = 0.875

			if var_315_8 < arg_312_1.time_ and arg_312_1.time_ <= var_315_8 + arg_315_0 then
				arg_312_1.talkMaxDuration = 0
				arg_312_1.dialogCg_.alpha = 1

				arg_312_1.dialog_:SetActive(true)
				SetActive(arg_312_1.leftNameGo_, true)

				local var_315_10 = arg_312_1:FormatText(StoryNameCfg[7].name)

				arg_312_1.leftNameTxt_.text = var_315_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_312_1.leftNameTxt_.transform)

				arg_312_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_312_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_312_1:RecordName(arg_312_1.leftNameTxt_.text)
				SetActive(arg_312_1.iconTrs_.gameObject, true)
				arg_312_1.iconController_:SetSelectedState("hero")

				arg_312_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_312_1.callingController_:SetSelectedState("normal")

				arg_312_1.keyicon_.color = Color.New(1, 1, 1)
				arg_312_1.icon_.color = Color.New(1, 1, 1)

				local var_315_11 = arg_312_1:GetWordFromCfg(424081075)
				local var_315_12 = arg_312_1:FormatText(var_315_11.content)

				arg_312_1.text_.text = var_315_12

				LuaForUtil.ClearLinePrefixSymbol(arg_312_1.text_)

				local var_315_13 = 31
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
				arg_312_1:RecordContent(arg_312_1.text_.text)
			end

			local var_315_16 = math.max(var_315_9, arg_312_1.talkMaxDuration)

			if var_315_8 <= arg_312_1.time_ and arg_312_1.time_ < var_315_8 + var_315_16 then
				arg_312_1.typewritter.percent = (arg_312_1.time_ - var_315_8) / var_315_16

				arg_312_1.typewritter:SetDirty()
			end

			if arg_312_1.time_ >= var_315_8 + var_315_16 and arg_312_1.time_ < var_315_8 + var_315_16 + arg_315_0 then
				arg_312_1.typewritter.percent = 1

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(true)
			end
		end

		arg_312_1.nodeConfigList_ = {}

		arg_312_1:InitPlayNodeList()
	end,
	Play424081076 = function(arg_316_0, arg_316_1)
		arg_316_1.time_ = 0
		arg_316_1.frameCnt_ = 0
		arg_316_1.state_ = "playing"
		arg_316_1.curTalkId_ = 424081076
		arg_316_1.duration_ = 4.07

		local var_316_0 = {
			zh = 4.066,
			ja = 3.966
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
				arg_316_0:Play424081077(arg_316_1)
			end
		end

		function arg_316_1.onSingleLineUpdate_(arg_319_0)
			local var_319_0 = arg_316_1.actors_["10154"]
			local var_319_1 = 0

			if var_319_1 < arg_316_1.time_ and arg_316_1.time_ <= var_319_1 + arg_319_0 and not isNil(var_319_0) and arg_316_1.var_.actorSpriteComps10154 == nil then
				arg_316_1.var_.actorSpriteComps10154 = var_319_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_319_2 = 0.2

			if var_319_1 <= arg_316_1.time_ and arg_316_1.time_ < var_319_1 + var_319_2 and not isNil(var_319_0) then
				local var_319_3 = (arg_316_1.time_ - var_319_1) / var_319_2

				if arg_316_1.var_.actorSpriteComps10154 then
					for iter_319_0, iter_319_1 in pairs(arg_316_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_319_1 then
							if arg_316_1.isInRecall_ then
								local var_319_4 = Mathf.Lerp(iter_319_1.color.r, arg_316_1.hightColor1.r, var_319_3)
								local var_319_5 = Mathf.Lerp(iter_319_1.color.g, arg_316_1.hightColor1.g, var_319_3)
								local var_319_6 = Mathf.Lerp(iter_319_1.color.b, arg_316_1.hightColor1.b, var_319_3)

								iter_319_1.color = Color.New(var_319_4, var_319_5, var_319_6)
							else
								local var_319_7 = Mathf.Lerp(iter_319_1.color.r, 1, var_319_3)

								iter_319_1.color = Color.New(var_319_7, var_319_7, var_319_7)
							end
						end
					end
				end
			end

			if arg_316_1.time_ >= var_319_1 + var_319_2 and arg_316_1.time_ < var_319_1 + var_319_2 + arg_319_0 and not isNil(var_319_0) and arg_316_1.var_.actorSpriteComps10154 then
				for iter_319_2, iter_319_3 in pairs(arg_316_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_319_3 then
						if arg_316_1.isInRecall_ then
							iter_319_3.color = arg_316_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_319_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_316_1.var_.actorSpriteComps10154 = nil
			end

			local var_319_8 = arg_316_1.actors_["10154"].transform
			local var_319_9 = 0

			if var_319_9 < arg_316_1.time_ and arg_316_1.time_ <= var_319_9 + arg_319_0 then
				arg_316_1.var_.moveOldPos10154 = var_319_8.localPosition
				var_319_8.localScale = Vector3.New(1, 1, 1)

				arg_316_1:CheckSpriteTmpPos("10154", 3)

				local var_319_10 = var_319_8.childCount

				for iter_319_4 = 0, var_319_10 - 1 do
					local var_319_11 = var_319_8:GetChild(iter_319_4)

					if var_319_11.name == "split_3" then
						var_319_11:SetAsLastSibling()
						var_319_11.gameObject:SetActive(true)

						arg_316_1.var_.actorSpriteSplit10154 = var_319_11.gameObject:GetComponent(typeof(Image))

						arg_316_1.var_.actorSpriteSplit10154:SetAlpha(0)
					end
				end
			end

			local var_319_12 = 0.5

			if var_319_9 <= arg_316_1.time_ and arg_316_1.time_ < var_319_9 + var_319_12 then
				local var_319_13 = (arg_316_1.time_ - var_319_9) / var_319_12
				local var_319_14 = Vector3.New(-20, -338, -538)

				var_319_8.localPosition = Vector3.Lerp(arg_316_1.var_.moveOldPos10154, var_319_14, var_319_13)

				if arg_316_1.var_.actorSpriteSplit10154 ~= nil then
					arg_316_1.var_.actorSpriteSplit10154:SetAlpha(var_319_13)
				end
			end

			if arg_316_1.time_ >= var_319_9 + var_319_12 and arg_316_1.time_ < var_319_9 + var_319_12 + arg_319_0 then
				var_319_8.localPosition = Vector3.New(-20, -338, -538)

				if arg_316_1.var_.actorSpriteSplit10154 ~= nil then
					arg_316_1.var_.actorSpriteSplit10154:SetAlpha(1)
				end
			end

			local var_319_15 = 0
			local var_319_16 = 0.4

			if var_319_15 < arg_316_1.time_ and arg_316_1.time_ <= var_319_15 + arg_319_0 then
				arg_316_1.talkMaxDuration = 0
				arg_316_1.dialogCg_.alpha = 1

				arg_316_1.dialog_:SetActive(true)
				SetActive(arg_316_1.leftNameGo_, true)

				local var_319_17 = arg_316_1:FormatText(StoryNameCfg[1392].name)

				arg_316_1.leftNameTxt_.text = var_319_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_316_1.leftNameTxt_.transform)

				arg_316_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_316_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_316_1:RecordName(arg_316_1.leftNameTxt_.text)
				SetActive(arg_316_1.iconTrs_.gameObject, false)
				arg_316_1.callingController_:SetSelectedState("normal")

				local var_319_18 = arg_316_1:GetWordFromCfg(424081076)
				local var_319_19 = arg_316_1:FormatText(var_319_18.content)

				arg_316_1.text_.text = var_319_19

				LuaForUtil.ClearLinePrefixSymbol(arg_316_1.text_)

				local var_319_20 = 16
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

				if manager.audio:GetVoiceLength("story_v_out_424081", "424081076", "story_v_out_424081.awb") ~= 0 then
					local var_319_23 = manager.audio:GetVoiceLength("story_v_out_424081", "424081076", "story_v_out_424081.awb") / 1000

					if var_319_23 + var_319_15 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_23 + var_319_15
					end

					if var_319_18.prefab_name ~= "" and arg_316_1.actors_[var_319_18.prefab_name] ~= nil then
						local var_319_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_316_1.actors_[var_319_18.prefab_name].transform, "story_v_out_424081", "424081076", "story_v_out_424081.awb")

						arg_316_1:RecordAudio("424081076", var_319_24)
						arg_316_1:RecordAudio("424081076", var_319_24)
					else
						arg_316_1:AudioAction("play", "voice", "story_v_out_424081", "424081076", "story_v_out_424081.awb")
					end

					arg_316_1:RecordHistoryTalkVoice("story_v_out_424081", "424081076", "story_v_out_424081.awb")
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
				actorName = "10154",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_316_1:InitPlayNodeList()
	end,
	Play424081077 = function(arg_320_0, arg_320_1)
		arg_320_1.time_ = 0
		arg_320_1.frameCnt_ = 0
		arg_320_1.state_ = "playing"
		arg_320_1.curTalkId_ = 424081077
		arg_320_1.duration_ = 5

		SetActive(arg_320_1.tipsGo_, false)

		function arg_320_1.onSingleLineFinish_()
			arg_320_1.onSingleLineUpdate_ = nil
			arg_320_1.onSingleLineFinish_ = nil
			arg_320_1.state_ = "waiting"
		end

		function arg_320_1.playNext_(arg_322_0)
			if arg_322_0 == 1 then
				arg_320_0:Play424081078(arg_320_1)
			end
		end

		function arg_320_1.onSingleLineUpdate_(arg_323_0)
			local var_323_0 = arg_320_1.actors_["10154"]
			local var_323_1 = 0

			if var_323_1 < arg_320_1.time_ and arg_320_1.time_ <= var_323_1 + arg_323_0 and not isNil(var_323_0) and arg_320_1.var_.actorSpriteComps10154 == nil then
				arg_320_1.var_.actorSpriteComps10154 = var_323_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_323_2 = 0.2

			if var_323_1 <= arg_320_1.time_ and arg_320_1.time_ < var_323_1 + var_323_2 and not isNil(var_323_0) then
				local var_323_3 = (arg_320_1.time_ - var_323_1) / var_323_2

				if arg_320_1.var_.actorSpriteComps10154 then
					for iter_323_0, iter_323_1 in pairs(arg_320_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_323_1 then
							if arg_320_1.isInRecall_ then
								local var_323_4 = Mathf.Lerp(iter_323_1.color.r, arg_320_1.hightColor2.r, var_323_3)
								local var_323_5 = Mathf.Lerp(iter_323_1.color.g, arg_320_1.hightColor2.g, var_323_3)
								local var_323_6 = Mathf.Lerp(iter_323_1.color.b, arg_320_1.hightColor2.b, var_323_3)

								iter_323_1.color = Color.New(var_323_4, var_323_5, var_323_6)
							else
								local var_323_7 = Mathf.Lerp(iter_323_1.color.r, 0.5, var_323_3)

								iter_323_1.color = Color.New(var_323_7, var_323_7, var_323_7)
							end
						end
					end
				end
			end

			if arg_320_1.time_ >= var_323_1 + var_323_2 and arg_320_1.time_ < var_323_1 + var_323_2 + arg_323_0 and not isNil(var_323_0) and arg_320_1.var_.actorSpriteComps10154 then
				for iter_323_2, iter_323_3 in pairs(arg_320_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_323_3 then
						if arg_320_1.isInRecall_ then
							iter_323_3.color = arg_320_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_323_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_320_1.var_.actorSpriteComps10154 = nil
			end

			local var_323_8 = arg_320_1.actors_["10154"].transform
			local var_323_9 = 0

			if var_323_9 < arg_320_1.time_ and arg_320_1.time_ <= var_323_9 + arg_323_0 then
				arg_320_1.var_.moveOldPos10154 = var_323_8.localPosition
				var_323_8.localScale = Vector3.New(1, 1, 1)

				arg_320_1:CheckSpriteTmpPos("10154", 7)

				local var_323_10 = var_323_8.childCount

				for iter_323_4 = 0, var_323_10 - 1 do
					local var_323_11 = var_323_8:GetChild(iter_323_4)

					if var_323_11.name == "" or not string.find(var_323_11.name, "split") then
						var_323_11.gameObject:SetActive(true)
					else
						var_323_11.gameObject:SetActive(false)
					end
				end
			end

			local var_323_12 = 0.001

			if var_323_9 <= arg_320_1.time_ and arg_320_1.time_ < var_323_9 + var_323_12 then
				local var_323_13 = (arg_320_1.time_ - var_323_9) / var_323_12
				local var_323_14 = Vector3.New(0, -2000, 0)

				var_323_8.localPosition = Vector3.Lerp(arg_320_1.var_.moveOldPos10154, var_323_14, var_323_13)
			end

			if arg_320_1.time_ >= var_323_9 + var_323_12 and arg_320_1.time_ < var_323_9 + var_323_12 + arg_323_0 then
				var_323_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_323_15 = 0

			if var_323_15 < arg_320_1.time_ and arg_320_1.time_ <= var_323_15 + arg_323_0 then
				arg_320_1.allBtn_.enabled = false
			end

			local var_323_16 = 0.5

			if arg_320_1.time_ >= var_323_15 + var_323_16 and arg_320_1.time_ < var_323_15 + var_323_16 + arg_323_0 then
				arg_320_1.allBtn_.enabled = true
			end

			local var_323_17 = 0
			local var_323_18 = 1

			if var_323_17 < arg_320_1.time_ and arg_320_1.time_ <= var_323_17 + arg_323_0 then
				local var_323_19 = "play"
				local var_323_20 = "effect"

				arg_320_1:AudioAction(var_323_19, var_323_20, "se_story_121_04", "se_story_121_04_woodbucket", "")
			end

			local var_323_21 = 0.2
			local var_323_22 = 1

			if var_323_21 < arg_320_1.time_ and arg_320_1.time_ <= var_323_21 + arg_323_0 then
				local var_323_23 = "play"
				local var_323_24 = "effect"

				arg_320_1:AudioAction(var_323_23, var_323_24, "se_story_side_1061", "se_story_side_1061_clap_wood", "")
			end

			local var_323_25 = 0
			local var_323_26 = 0.85

			if var_323_25 < arg_320_1.time_ and arg_320_1.time_ <= var_323_25 + arg_323_0 then
				arg_320_1.talkMaxDuration = 0

				arg_320_1.dialog_:SetActive(true)

				arg_320_1.dialogCg_.alpha = 0

				local var_323_27 = LeanTween.value(arg_320_1.dialog_, 0, 1, 0.3)

				var_323_27:setOnUpdate(LuaHelper.FloatAction(function(arg_324_0)
					arg_320_1.dialogCg_.alpha = arg_324_0
				end))
				var_323_27:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_320_1.dialog_)
					var_323_27:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_320_1.duration_ = arg_320_1.duration_ + 0.3

				SetActive(arg_320_1.leftNameGo_, false)

				arg_320_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_320_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_320_1:RecordName(arg_320_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_320_1.iconTrs_.gameObject, false)
				arg_320_1.callingController_:SetSelectedState("normal")

				local var_323_28 = arg_320_1:GetWordFromCfg(424081077)
				local var_323_29 = arg_320_1:FormatText(var_323_28.content)

				arg_320_1.text_.text = var_323_29

				LuaForUtil.ClearLinePrefixSymbol(arg_320_1.text_)

				local var_323_30 = 34
				local var_323_31 = utf8.len(var_323_29)
				local var_323_32 = var_323_30 <= 0 and var_323_26 or var_323_26 * (var_323_31 / var_323_30)

				if var_323_32 > 0 and var_323_26 < var_323_32 then
					arg_320_1.talkMaxDuration = var_323_32
					var_323_25 = var_323_25 + 0.3

					if var_323_32 + var_323_25 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_32 + var_323_25
					end
				end

				arg_320_1.text_.text = var_323_29
				arg_320_1.typewritter.percent = 0

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(false)
				arg_320_1:RecordContent(arg_320_1.text_.text)
			end

			local var_323_33 = var_323_25 + 0.3
			local var_323_34 = math.max(var_323_26, arg_320_1.talkMaxDuration)

			if var_323_33 <= arg_320_1.time_ and arg_320_1.time_ < var_323_33 + var_323_34 then
				arg_320_1.typewritter.percent = (arg_320_1.time_ - var_323_33) / var_323_34

				arg_320_1.typewritter:SetDirty()
			end

			if arg_320_1.time_ >= var_323_33 + var_323_34 and arg_320_1.time_ < var_323_33 + var_323_34 + arg_323_0 then
				arg_320_1.typewritter.percent = 1

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(true)
			end
		end

		arg_320_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10154",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "",
				frequencyGain = 12,
				className = "StoryShakeNode",
				noiseSettingsAssetPath = "Camera/Noise/UpDown_Shake",
				duration = 0.3,
				amplitudeGain = 1,
				startTime = 0.2,
				actorType = StoryPlayerConst.ACTOR_TYPE.None,
				shakeTarget = StoryPlayerConst.SHAKE_TARGET.CAMERA
			}
		}

		arg_320_1:InitPlayNodeList()
	end,
	Play424081078 = function(arg_326_0, arg_326_1)
		arg_326_1.time_ = 0
		arg_326_1.frameCnt_ = 0
		arg_326_1.state_ = "playing"
		arg_326_1.curTalkId_ = 424081078
		arg_326_1.duration_ = 5

		local var_326_0 = {
			zh = 4.633,
			ja = 5
		}
		local var_326_1 = manager.audio:GetLocalizationFlag()

		if var_326_0[var_326_1] ~= nil then
			arg_326_1.duration_ = var_326_0[var_326_1]
		end

		SetActive(arg_326_1.tipsGo_, false)

		function arg_326_1.onSingleLineFinish_()
			arg_326_1.onSingleLineUpdate_ = nil
			arg_326_1.onSingleLineFinish_ = nil
			arg_326_1.state_ = "waiting"
		end

		function arg_326_1.playNext_(arg_328_0)
			if arg_328_0 == 1 then
				arg_326_0:Play424081079(arg_326_1)
			end
		end

		function arg_326_1.onSingleLineUpdate_(arg_329_0)
			local var_329_0 = arg_326_1.actors_["10154"]
			local var_329_1 = 0

			if var_329_1 < arg_326_1.time_ and arg_326_1.time_ <= var_329_1 + arg_329_0 and not isNil(var_329_0) and arg_326_1.var_.actorSpriteComps10154 == nil then
				arg_326_1.var_.actorSpriteComps10154 = var_329_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_329_2 = 0.2

			if var_329_1 <= arg_326_1.time_ and arg_326_1.time_ < var_329_1 + var_329_2 and not isNil(var_329_0) then
				local var_329_3 = (arg_326_1.time_ - var_329_1) / var_329_2

				if arg_326_1.var_.actorSpriteComps10154 then
					for iter_329_0, iter_329_1 in pairs(arg_326_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_329_1 then
							if arg_326_1.isInRecall_ then
								local var_329_4 = Mathf.Lerp(iter_329_1.color.r, arg_326_1.hightColor1.r, var_329_3)
								local var_329_5 = Mathf.Lerp(iter_329_1.color.g, arg_326_1.hightColor1.g, var_329_3)
								local var_329_6 = Mathf.Lerp(iter_329_1.color.b, arg_326_1.hightColor1.b, var_329_3)

								iter_329_1.color = Color.New(var_329_4, var_329_5, var_329_6)
							else
								local var_329_7 = Mathf.Lerp(iter_329_1.color.r, 1, var_329_3)

								iter_329_1.color = Color.New(var_329_7, var_329_7, var_329_7)
							end
						end
					end
				end
			end

			if arg_326_1.time_ >= var_329_1 + var_329_2 and arg_326_1.time_ < var_329_1 + var_329_2 + arg_329_0 and not isNil(var_329_0) and arg_326_1.var_.actorSpriteComps10154 then
				for iter_329_2, iter_329_3 in pairs(arg_326_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_329_3 then
						if arg_326_1.isInRecall_ then
							iter_329_3.color = arg_326_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_329_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_326_1.var_.actorSpriteComps10154 = nil
			end

			local var_329_8 = arg_326_1.actors_["10154"].transform
			local var_329_9 = 0

			if var_329_9 < arg_326_1.time_ and arg_326_1.time_ <= var_329_9 + arg_329_0 then
				arg_326_1.var_.moveOldPos10154 = var_329_8.localPosition
				var_329_8.localScale = Vector3.New(1, 1, 1)

				arg_326_1:CheckSpriteTmpPos("10154", 3)

				local var_329_10 = var_329_8.childCount

				for iter_329_4 = 0, var_329_10 - 1 do
					local var_329_11 = var_329_8:GetChild(iter_329_4)

					if var_329_11.name == "split_3" or not string.find(var_329_11.name, "split") then
						var_329_11.gameObject:SetActive(true)
					else
						var_329_11.gameObject:SetActive(false)
					end
				end
			end

			local var_329_12 = 0.001

			if var_329_9 <= arg_326_1.time_ and arg_326_1.time_ < var_329_9 + var_329_12 then
				local var_329_13 = (arg_326_1.time_ - var_329_9) / var_329_12
				local var_329_14 = Vector3.New(-20, -338, -538)

				var_329_8.localPosition = Vector3.Lerp(arg_326_1.var_.moveOldPos10154, var_329_14, var_329_13)
			end

			if arg_326_1.time_ >= var_329_9 + var_329_12 and arg_326_1.time_ < var_329_9 + var_329_12 + arg_329_0 then
				var_329_8.localPosition = Vector3.New(-20, -338, -538)
			end

			local var_329_15 = 0
			local var_329_16 = 0.65

			if var_329_15 < arg_326_1.time_ and arg_326_1.time_ <= var_329_15 + arg_329_0 then
				arg_326_1.talkMaxDuration = 0
				arg_326_1.dialogCg_.alpha = 1

				arg_326_1.dialog_:SetActive(true)
				SetActive(arg_326_1.leftNameGo_, true)

				local var_329_17 = arg_326_1:FormatText(StoryNameCfg[1392].name)

				arg_326_1.leftNameTxt_.text = var_329_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_326_1.leftNameTxt_.transform)

				arg_326_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_326_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_326_1:RecordName(arg_326_1.leftNameTxt_.text)
				SetActive(arg_326_1.iconTrs_.gameObject, false)
				arg_326_1.callingController_:SetSelectedState("normal")

				local var_329_18 = arg_326_1:GetWordFromCfg(424081078)
				local var_329_19 = arg_326_1:FormatText(var_329_18.content)

				arg_326_1.text_.text = var_329_19

				LuaForUtil.ClearLinePrefixSymbol(arg_326_1.text_)

				local var_329_20 = 26
				local var_329_21 = utf8.len(var_329_19)
				local var_329_22 = var_329_20 <= 0 and var_329_16 or var_329_16 * (var_329_21 / var_329_20)

				if var_329_22 > 0 and var_329_16 < var_329_22 then
					arg_326_1.talkMaxDuration = var_329_22

					if var_329_22 + var_329_15 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_22 + var_329_15
					end
				end

				arg_326_1.text_.text = var_329_19
				arg_326_1.typewritter.percent = 0

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424081", "424081078", "story_v_out_424081.awb") ~= 0 then
					local var_329_23 = manager.audio:GetVoiceLength("story_v_out_424081", "424081078", "story_v_out_424081.awb") / 1000

					if var_329_23 + var_329_15 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_23 + var_329_15
					end

					if var_329_18.prefab_name ~= "" and arg_326_1.actors_[var_329_18.prefab_name] ~= nil then
						local var_329_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_326_1.actors_[var_329_18.prefab_name].transform, "story_v_out_424081", "424081078", "story_v_out_424081.awb")

						arg_326_1:RecordAudio("424081078", var_329_24)
						arg_326_1:RecordAudio("424081078", var_329_24)
					else
						arg_326_1:AudioAction("play", "voice", "story_v_out_424081", "424081078", "story_v_out_424081.awb")
					end

					arg_326_1:RecordHistoryTalkVoice("story_v_out_424081", "424081078", "story_v_out_424081.awb")
				end

				arg_326_1:RecordContent(arg_326_1.text_.text)
			end

			local var_329_25 = math.max(var_329_16, arg_326_1.talkMaxDuration)

			if var_329_15 <= arg_326_1.time_ and arg_326_1.time_ < var_329_15 + var_329_25 then
				arg_326_1.typewritter.percent = (arg_326_1.time_ - var_329_15) / var_329_25

				arg_326_1.typewritter:SetDirty()
			end

			if arg_326_1.time_ >= var_329_15 + var_329_25 and arg_326_1.time_ < var_329_15 + var_329_25 + arg_329_0 then
				arg_326_1.typewritter.percent = 1

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(true)
			end
		end

		arg_326_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10154",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_326_1:InitPlayNodeList()
	end,
	Play424081079 = function(arg_330_0, arg_330_1)
		arg_330_1.time_ = 0
		arg_330_1.frameCnt_ = 0
		arg_330_1.state_ = "playing"
		arg_330_1.curTalkId_ = 424081079
		arg_330_1.duration_ = 5

		SetActive(arg_330_1.tipsGo_, false)

		function arg_330_1.onSingleLineFinish_()
			arg_330_1.onSingleLineUpdate_ = nil
			arg_330_1.onSingleLineFinish_ = nil
			arg_330_1.state_ = "waiting"
		end

		function arg_330_1.playNext_(arg_332_0)
			if arg_332_0 == 1 then
				arg_330_0:Play424081080(arg_330_1)
			end
		end

		function arg_330_1.onSingleLineUpdate_(arg_333_0)
			local var_333_0 = arg_330_1.actors_["10154"]
			local var_333_1 = 0

			if var_333_1 < arg_330_1.time_ and arg_330_1.time_ <= var_333_1 + arg_333_0 and not isNil(var_333_0) and arg_330_1.var_.actorSpriteComps10154 == nil then
				arg_330_1.var_.actorSpriteComps10154 = var_333_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_333_2 = 0.2

			if var_333_1 <= arg_330_1.time_ and arg_330_1.time_ < var_333_1 + var_333_2 and not isNil(var_333_0) then
				local var_333_3 = (arg_330_1.time_ - var_333_1) / var_333_2

				if arg_330_1.var_.actorSpriteComps10154 then
					for iter_333_0, iter_333_1 in pairs(arg_330_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_333_1 then
							if arg_330_1.isInRecall_ then
								local var_333_4 = Mathf.Lerp(iter_333_1.color.r, arg_330_1.hightColor2.r, var_333_3)
								local var_333_5 = Mathf.Lerp(iter_333_1.color.g, arg_330_1.hightColor2.g, var_333_3)
								local var_333_6 = Mathf.Lerp(iter_333_1.color.b, arg_330_1.hightColor2.b, var_333_3)

								iter_333_1.color = Color.New(var_333_4, var_333_5, var_333_6)
							else
								local var_333_7 = Mathf.Lerp(iter_333_1.color.r, 0.5, var_333_3)

								iter_333_1.color = Color.New(var_333_7, var_333_7, var_333_7)
							end
						end
					end
				end
			end

			if arg_330_1.time_ >= var_333_1 + var_333_2 and arg_330_1.time_ < var_333_1 + var_333_2 + arg_333_0 and not isNil(var_333_0) and arg_330_1.var_.actorSpriteComps10154 then
				for iter_333_2, iter_333_3 in pairs(arg_330_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_333_3 then
						if arg_330_1.isInRecall_ then
							iter_333_3.color = arg_330_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_333_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_330_1.var_.actorSpriteComps10154 = nil
			end

			local var_333_8 = arg_330_1.actors_["10154"].transform
			local var_333_9 = 0

			if var_333_9 < arg_330_1.time_ and arg_330_1.time_ <= var_333_9 + arg_333_0 then
				arg_330_1.var_.moveOldPos10154 = var_333_8.localPosition
				var_333_8.localScale = Vector3.New(1, 1, 1)

				arg_330_1:CheckSpriteTmpPos("10154", 7)

				local var_333_10 = var_333_8.childCount

				for iter_333_4 = 0, var_333_10 - 1 do
					local var_333_11 = var_333_8:GetChild(iter_333_4)

					if var_333_11.name == "" or not string.find(var_333_11.name, "split") then
						var_333_11.gameObject:SetActive(true)
					else
						var_333_11.gameObject:SetActive(false)
					end
				end
			end

			local var_333_12 = 0.001

			if var_333_9 <= arg_330_1.time_ and arg_330_1.time_ < var_333_9 + var_333_12 then
				local var_333_13 = (arg_330_1.time_ - var_333_9) / var_333_12
				local var_333_14 = Vector3.New(0, -2000, 0)

				var_333_8.localPosition = Vector3.Lerp(arg_330_1.var_.moveOldPos10154, var_333_14, var_333_13)
			end

			if arg_330_1.time_ >= var_333_9 + var_333_12 and arg_330_1.time_ < var_333_9 + var_333_12 + arg_333_0 then
				var_333_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_333_15 = 0
			local var_333_16 = 1

			if var_333_15 < arg_330_1.time_ and arg_330_1.time_ <= var_333_15 + arg_333_0 then
				local var_333_17 = "play"
				local var_333_18 = "effect"

				arg_330_1:AudioAction(var_333_17, var_333_18, "se_story_1310", "se_story_1310_footstep04", "")
			end

			local var_333_19 = 0
			local var_333_20 = 0.85

			if var_333_19 < arg_330_1.time_ and arg_330_1.time_ <= var_333_19 + arg_333_0 then
				arg_330_1.talkMaxDuration = 0
				arg_330_1.dialogCg_.alpha = 1

				arg_330_1.dialog_:SetActive(true)
				SetActive(arg_330_1.leftNameGo_, false)

				arg_330_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_330_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_330_1:RecordName(arg_330_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_330_1.iconTrs_.gameObject, false)
				arg_330_1.callingController_:SetSelectedState("normal")

				local var_333_21 = arg_330_1:GetWordFromCfg(424081079)
				local var_333_22 = arg_330_1:FormatText(var_333_21.content)

				arg_330_1.text_.text = var_333_22

				LuaForUtil.ClearLinePrefixSymbol(arg_330_1.text_)

				local var_333_23 = 34
				local var_333_24 = utf8.len(var_333_22)
				local var_333_25 = var_333_23 <= 0 and var_333_20 or var_333_20 * (var_333_24 / var_333_23)

				if var_333_25 > 0 and var_333_20 < var_333_25 then
					arg_330_1.talkMaxDuration = var_333_25

					if var_333_25 + var_333_19 > arg_330_1.duration_ then
						arg_330_1.duration_ = var_333_25 + var_333_19
					end
				end

				arg_330_1.text_.text = var_333_22
				arg_330_1.typewritter.percent = 0

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(false)
				arg_330_1:RecordContent(arg_330_1.text_.text)
			end

			local var_333_26 = math.max(var_333_20, arg_330_1.talkMaxDuration)

			if var_333_19 <= arg_330_1.time_ and arg_330_1.time_ < var_333_19 + var_333_26 then
				arg_330_1.typewritter.percent = (arg_330_1.time_ - var_333_19) / var_333_26

				arg_330_1.typewritter:SetDirty()
			end

			if arg_330_1.time_ >= var_333_19 + var_333_26 and arg_330_1.time_ < var_333_19 + var_333_26 + arg_333_0 then
				arg_330_1.typewritter.percent = 1

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(true)
			end
		end

		arg_330_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10154",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_330_1:InitPlayNodeList()
	end,
	Play424081080 = function(arg_334_0, arg_334_1)
		arg_334_1.time_ = 0
		arg_334_1.frameCnt_ = 0
		arg_334_1.state_ = "playing"
		arg_334_1.curTalkId_ = 424081080
		arg_334_1.duration_ = 5

		SetActive(arg_334_1.tipsGo_, false)

		function arg_334_1.onSingleLineFinish_()
			arg_334_1.onSingleLineUpdate_ = nil
			arg_334_1.onSingleLineFinish_ = nil
			arg_334_1.state_ = "waiting"
		end

		function arg_334_1.playNext_(arg_336_0)
			if arg_336_0 == 1 then
				arg_334_0:Play424081081(arg_334_1)
			end
		end

		function arg_334_1.onSingleLineUpdate_(arg_337_0)
			local var_337_0 = 0
			local var_337_1 = 0.475

			if var_337_0 < arg_334_1.time_ and arg_334_1.time_ <= var_337_0 + arg_337_0 then
				arg_334_1.talkMaxDuration = 0
				arg_334_1.dialogCg_.alpha = 1

				arg_334_1.dialog_:SetActive(true)
				SetActive(arg_334_1.leftNameGo_, true)

				local var_337_2 = arg_334_1:FormatText(StoryNameCfg[7].name)

				arg_334_1.leftNameTxt_.text = var_337_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_334_1.leftNameTxt_.transform)

				arg_334_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_334_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_334_1:RecordName(arg_334_1.leftNameTxt_.text)
				SetActive(arg_334_1.iconTrs_.gameObject, true)
				arg_334_1.iconController_:SetSelectedState("hero")

				arg_334_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_334_1.callingController_:SetSelectedState("normal")

				arg_334_1.keyicon_.color = Color.New(1, 1, 1)
				arg_334_1.icon_.color = Color.New(1, 1, 1)

				local var_337_3 = arg_334_1:GetWordFromCfg(424081080)
				local var_337_4 = arg_334_1:FormatText(var_337_3.content)

				arg_334_1.text_.text = var_337_4

				LuaForUtil.ClearLinePrefixSymbol(arg_334_1.text_)

				local var_337_5 = 19
				local var_337_6 = utf8.len(var_337_4)
				local var_337_7 = var_337_5 <= 0 and var_337_1 or var_337_1 * (var_337_6 / var_337_5)

				if var_337_7 > 0 and var_337_1 < var_337_7 then
					arg_334_1.talkMaxDuration = var_337_7

					if var_337_7 + var_337_0 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_7 + var_337_0
					end
				end

				arg_334_1.text_.text = var_337_4
				arg_334_1.typewritter.percent = 0

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(false)
				arg_334_1:RecordContent(arg_334_1.text_.text)
			end

			local var_337_8 = math.max(var_337_1, arg_334_1.talkMaxDuration)

			if var_337_0 <= arg_334_1.time_ and arg_334_1.time_ < var_337_0 + var_337_8 then
				arg_334_1.typewritter.percent = (arg_334_1.time_ - var_337_0) / var_337_8

				arg_334_1.typewritter:SetDirty()
			end

			if arg_334_1.time_ >= var_337_0 + var_337_8 and arg_334_1.time_ < var_337_0 + var_337_8 + arg_337_0 then
				arg_334_1.typewritter.percent = 1

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(true)
			end
		end

		arg_334_1.nodeConfigList_ = {}

		arg_334_1:InitPlayNodeList()
	end,
	Play424081081 = function(arg_338_0, arg_338_1)
		arg_338_1.time_ = 0
		arg_338_1.frameCnt_ = 0
		arg_338_1.state_ = "playing"
		arg_338_1.curTalkId_ = 424081081
		arg_338_1.duration_ = 10.67

		local var_338_0 = {
			zh = 9.9,
			ja = 10.666
		}
		local var_338_1 = manager.audio:GetLocalizationFlag()

		if var_338_0[var_338_1] ~= nil then
			arg_338_1.duration_ = var_338_0[var_338_1]
		end

		SetActive(arg_338_1.tipsGo_, false)

		function arg_338_1.onSingleLineFinish_()
			arg_338_1.onSingleLineUpdate_ = nil
			arg_338_1.onSingleLineFinish_ = nil
			arg_338_1.state_ = "waiting"
		end

		function arg_338_1.playNext_(arg_340_0)
			if arg_340_0 == 1 then
				arg_338_0:Play424081082(arg_338_1)
			end
		end

		function arg_338_1.onSingleLineUpdate_(arg_341_0)
			local var_341_0 = arg_338_1.actors_["10154"]
			local var_341_1 = 0

			if var_341_1 < arg_338_1.time_ and arg_338_1.time_ <= var_341_1 + arg_341_0 and not isNil(var_341_0) and arg_338_1.var_.actorSpriteComps10154 == nil then
				arg_338_1.var_.actorSpriteComps10154 = var_341_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_341_2 = 0.2

			if var_341_1 <= arg_338_1.time_ and arg_338_1.time_ < var_341_1 + var_341_2 and not isNil(var_341_0) then
				local var_341_3 = (arg_338_1.time_ - var_341_1) / var_341_2

				if arg_338_1.var_.actorSpriteComps10154 then
					for iter_341_0, iter_341_1 in pairs(arg_338_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_341_1 then
							if arg_338_1.isInRecall_ then
								local var_341_4 = Mathf.Lerp(iter_341_1.color.r, arg_338_1.hightColor1.r, var_341_3)
								local var_341_5 = Mathf.Lerp(iter_341_1.color.g, arg_338_1.hightColor1.g, var_341_3)
								local var_341_6 = Mathf.Lerp(iter_341_1.color.b, arg_338_1.hightColor1.b, var_341_3)

								iter_341_1.color = Color.New(var_341_4, var_341_5, var_341_6)
							else
								local var_341_7 = Mathf.Lerp(iter_341_1.color.r, 1, var_341_3)

								iter_341_1.color = Color.New(var_341_7, var_341_7, var_341_7)
							end
						end
					end
				end
			end

			if arg_338_1.time_ >= var_341_1 + var_341_2 and arg_338_1.time_ < var_341_1 + var_341_2 + arg_341_0 and not isNil(var_341_0) and arg_338_1.var_.actorSpriteComps10154 then
				for iter_341_2, iter_341_3 in pairs(arg_338_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_341_3 then
						if arg_338_1.isInRecall_ then
							iter_341_3.color = arg_338_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_341_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_338_1.var_.actorSpriteComps10154 = nil
			end

			local var_341_8 = arg_338_1.actors_["10154"].transform
			local var_341_9 = 0

			if var_341_9 < arg_338_1.time_ and arg_338_1.time_ <= var_341_9 + arg_341_0 then
				arg_338_1.var_.moveOldPos10154 = var_341_8.localPosition
				var_341_8.localScale = Vector3.New(1, 1, 1)

				arg_338_1:CheckSpriteTmpPos("10154", 3)

				local var_341_10 = var_341_8.childCount

				for iter_341_4 = 0, var_341_10 - 1 do
					local var_341_11 = var_341_8:GetChild(iter_341_4)

					if var_341_11.name == "split_4" then
						var_341_11:SetAsLastSibling()
						var_341_11.gameObject:SetActive(true)

						arg_338_1.var_.actorSpriteSplit10154 = var_341_11.gameObject:GetComponent(typeof(Image))

						arg_338_1.var_.actorSpriteSplit10154:SetAlpha(0)
					end
				end
			end

			local var_341_12 = 0.001

			if var_341_9 <= arg_338_1.time_ and arg_338_1.time_ < var_341_9 + var_341_12 then
				local var_341_13 = (arg_338_1.time_ - var_341_9) / var_341_12
				local var_341_14 = Vector3.New(-20, -338, -538)

				var_341_8.localPosition = Vector3.Lerp(arg_338_1.var_.moveOldPos10154, var_341_14, var_341_13)

				if arg_338_1.var_.actorSpriteSplit10154 ~= nil then
					arg_338_1.var_.actorSpriteSplit10154:SetAlpha(var_341_13)
				end
			end

			if arg_338_1.time_ >= var_341_9 + var_341_12 and arg_338_1.time_ < var_341_9 + var_341_12 + arg_341_0 then
				var_341_8.localPosition = Vector3.New(-20, -338, -538)

				if arg_338_1.var_.actorSpriteSplit10154 ~= nil then
					arg_338_1.var_.actorSpriteSplit10154:SetAlpha(1)
				end
			end

			local var_341_15 = 0
			local var_341_16 = 1.25

			if var_341_15 < arg_338_1.time_ and arg_338_1.time_ <= var_341_15 + arg_341_0 then
				arg_338_1.talkMaxDuration = 0
				arg_338_1.dialogCg_.alpha = 1

				arg_338_1.dialog_:SetActive(true)
				SetActive(arg_338_1.leftNameGo_, true)

				local var_341_17 = arg_338_1:FormatText(StoryNameCfg[1392].name)

				arg_338_1.leftNameTxt_.text = var_341_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_338_1.leftNameTxt_.transform)

				arg_338_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_338_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_338_1:RecordName(arg_338_1.leftNameTxt_.text)
				SetActive(arg_338_1.iconTrs_.gameObject, false)
				arg_338_1.callingController_:SetSelectedState("normal")

				local var_341_18 = arg_338_1:GetWordFromCfg(424081081)
				local var_341_19 = arg_338_1:FormatText(var_341_18.content)

				arg_338_1.text_.text = var_341_19

				LuaForUtil.ClearLinePrefixSymbol(arg_338_1.text_)

				local var_341_20 = 50
				local var_341_21 = utf8.len(var_341_19)
				local var_341_22 = var_341_20 <= 0 and var_341_16 or var_341_16 * (var_341_21 / var_341_20)

				if var_341_22 > 0 and var_341_16 < var_341_22 then
					arg_338_1.talkMaxDuration = var_341_22

					if var_341_22 + var_341_15 > arg_338_1.duration_ then
						arg_338_1.duration_ = var_341_22 + var_341_15
					end
				end

				arg_338_1.text_.text = var_341_19
				arg_338_1.typewritter.percent = 0

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424081", "424081081", "story_v_out_424081.awb") ~= 0 then
					local var_341_23 = manager.audio:GetVoiceLength("story_v_out_424081", "424081081", "story_v_out_424081.awb") / 1000

					if var_341_23 + var_341_15 > arg_338_1.duration_ then
						arg_338_1.duration_ = var_341_23 + var_341_15
					end

					if var_341_18.prefab_name ~= "" and arg_338_1.actors_[var_341_18.prefab_name] ~= nil then
						local var_341_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_338_1.actors_[var_341_18.prefab_name].transform, "story_v_out_424081", "424081081", "story_v_out_424081.awb")

						arg_338_1:RecordAudio("424081081", var_341_24)
						arg_338_1:RecordAudio("424081081", var_341_24)
					else
						arg_338_1:AudioAction("play", "voice", "story_v_out_424081", "424081081", "story_v_out_424081.awb")
					end

					arg_338_1:RecordHistoryTalkVoice("story_v_out_424081", "424081081", "story_v_out_424081.awb")
				end

				arg_338_1:RecordContent(arg_338_1.text_.text)
			end

			local var_341_25 = math.max(var_341_16, arg_338_1.talkMaxDuration)

			if var_341_15 <= arg_338_1.time_ and arg_338_1.time_ < var_341_15 + var_341_25 then
				arg_338_1.typewritter.percent = (arg_338_1.time_ - var_341_15) / var_341_25

				arg_338_1.typewritter:SetDirty()
			end

			if arg_338_1.time_ >= var_341_15 + var_341_25 and arg_338_1.time_ < var_341_15 + var_341_25 + arg_341_0 then
				arg_338_1.typewritter.percent = 1

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(true)
			end
		end

		arg_338_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10154",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_338_1:InitPlayNodeList()
	end,
	Play424081082 = function(arg_342_0, arg_342_1)
		arg_342_1.time_ = 0
		arg_342_1.frameCnt_ = 0
		arg_342_1.state_ = "playing"
		arg_342_1.curTalkId_ = 424081082
		arg_342_1.duration_ = 5

		SetActive(arg_342_1.tipsGo_, false)

		function arg_342_1.onSingleLineFinish_()
			arg_342_1.onSingleLineUpdate_ = nil
			arg_342_1.onSingleLineFinish_ = nil
			arg_342_1.state_ = "waiting"
		end

		function arg_342_1.playNext_(arg_344_0)
			if arg_344_0 == 1 then
				arg_342_0:Play424081083(arg_342_1)
			end
		end

		function arg_342_1.onSingleLineUpdate_(arg_345_0)
			local var_345_0 = arg_342_1.actors_["10154"]
			local var_345_1 = 0

			if var_345_1 < arg_342_1.time_ and arg_342_1.time_ <= var_345_1 + arg_345_0 and not isNil(var_345_0) and arg_342_1.var_.actorSpriteComps10154 == nil then
				arg_342_1.var_.actorSpriteComps10154 = var_345_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_345_2 = 0.2

			if var_345_1 <= arg_342_1.time_ and arg_342_1.time_ < var_345_1 + var_345_2 and not isNil(var_345_0) then
				local var_345_3 = (arg_342_1.time_ - var_345_1) / var_345_2

				if arg_342_1.var_.actorSpriteComps10154 then
					for iter_345_0, iter_345_1 in pairs(arg_342_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_345_1 then
							if arg_342_1.isInRecall_ then
								local var_345_4 = Mathf.Lerp(iter_345_1.color.r, arg_342_1.hightColor2.r, var_345_3)
								local var_345_5 = Mathf.Lerp(iter_345_1.color.g, arg_342_1.hightColor2.g, var_345_3)
								local var_345_6 = Mathf.Lerp(iter_345_1.color.b, arg_342_1.hightColor2.b, var_345_3)

								iter_345_1.color = Color.New(var_345_4, var_345_5, var_345_6)
							else
								local var_345_7 = Mathf.Lerp(iter_345_1.color.r, 0.5, var_345_3)

								iter_345_1.color = Color.New(var_345_7, var_345_7, var_345_7)
							end
						end
					end
				end
			end

			if arg_342_1.time_ >= var_345_1 + var_345_2 and arg_342_1.time_ < var_345_1 + var_345_2 + arg_345_0 and not isNil(var_345_0) and arg_342_1.var_.actorSpriteComps10154 then
				for iter_345_2, iter_345_3 in pairs(arg_342_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_345_3 then
						if arg_342_1.isInRecall_ then
							iter_345_3.color = arg_342_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_345_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_342_1.var_.actorSpriteComps10154 = nil
			end

			local var_345_8 = 0
			local var_345_9 = 0.875

			if var_345_8 < arg_342_1.time_ and arg_342_1.time_ <= var_345_8 + arg_345_0 then
				arg_342_1.talkMaxDuration = 0
				arg_342_1.dialogCg_.alpha = 1

				arg_342_1.dialog_:SetActive(true)
				SetActive(arg_342_1.leftNameGo_, true)

				local var_345_10 = arg_342_1:FormatText(StoryNameCfg[7].name)

				arg_342_1.leftNameTxt_.text = var_345_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_342_1.leftNameTxt_.transform)

				arg_342_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_342_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_342_1:RecordName(arg_342_1.leftNameTxt_.text)
				SetActive(arg_342_1.iconTrs_.gameObject, true)
				arg_342_1.iconController_:SetSelectedState("hero")

				arg_342_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_342_1.callingController_:SetSelectedState("normal")

				arg_342_1.keyicon_.color = Color.New(1, 1, 1)
				arg_342_1.icon_.color = Color.New(1, 1, 1)

				local var_345_11 = arg_342_1:GetWordFromCfg(424081082)
				local var_345_12 = arg_342_1:FormatText(var_345_11.content)

				arg_342_1.text_.text = var_345_12

				LuaForUtil.ClearLinePrefixSymbol(arg_342_1.text_)

				local var_345_13 = 35
				local var_345_14 = utf8.len(var_345_12)
				local var_345_15 = var_345_13 <= 0 and var_345_9 or var_345_9 * (var_345_14 / var_345_13)

				if var_345_15 > 0 and var_345_9 < var_345_15 then
					arg_342_1.talkMaxDuration = var_345_15

					if var_345_15 + var_345_8 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_15 + var_345_8
					end
				end

				arg_342_1.text_.text = var_345_12
				arg_342_1.typewritter.percent = 0

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(false)
				arg_342_1:RecordContent(arg_342_1.text_.text)
			end

			local var_345_16 = math.max(var_345_9, arg_342_1.talkMaxDuration)

			if var_345_8 <= arg_342_1.time_ and arg_342_1.time_ < var_345_8 + var_345_16 then
				arg_342_1.typewritter.percent = (arg_342_1.time_ - var_345_8) / var_345_16

				arg_342_1.typewritter:SetDirty()
			end

			if arg_342_1.time_ >= var_345_8 + var_345_16 and arg_342_1.time_ < var_345_8 + var_345_16 + arg_345_0 then
				arg_342_1.typewritter.percent = 1

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(true)
			end
		end

		arg_342_1.nodeConfigList_ = {}

		arg_342_1:InitPlayNodeList()
	end,
	Play424081083 = function(arg_346_0, arg_346_1)
		arg_346_1.time_ = 0
		arg_346_1.frameCnt_ = 0
		arg_346_1.state_ = "playing"
		arg_346_1.curTalkId_ = 424081083
		arg_346_1.duration_ = 5

		SetActive(arg_346_1.tipsGo_, false)

		function arg_346_1.onSingleLineFinish_()
			arg_346_1.onSingleLineUpdate_ = nil
			arg_346_1.onSingleLineFinish_ = nil
			arg_346_1.state_ = "waiting"
		end

		function arg_346_1.playNext_(arg_348_0)
			if arg_348_0 == 1 then
				arg_346_0:Play424081084(arg_346_1)
			end
		end

		function arg_346_1.onSingleLineUpdate_(arg_349_0)
			local var_349_0 = arg_346_1.actors_["10154"].transform
			local var_349_1 = 0

			if var_349_1 < arg_346_1.time_ and arg_346_1.time_ <= var_349_1 + arg_349_0 then
				arg_346_1.var_.moveOldPos10154 = var_349_0.localPosition
				var_349_0.localScale = Vector3.New(1, 1, 1)

				arg_346_1:CheckSpriteTmpPos("10154", 7)

				local var_349_2 = var_349_0.childCount

				for iter_349_0 = 0, var_349_2 - 1 do
					local var_349_3 = var_349_0:GetChild(iter_349_0)

					if var_349_3.name == "" or not string.find(var_349_3.name, "split") then
						var_349_3.gameObject:SetActive(true)
					else
						var_349_3.gameObject:SetActive(false)
					end
				end
			end

			local var_349_4 = 0.001

			if var_349_1 <= arg_346_1.time_ and arg_346_1.time_ < var_349_1 + var_349_4 then
				local var_349_5 = (arg_346_1.time_ - var_349_1) / var_349_4
				local var_349_6 = Vector3.New(0, -2000, 0)

				var_349_0.localPosition = Vector3.Lerp(arg_346_1.var_.moveOldPos10154, var_349_6, var_349_5)
			end

			if arg_346_1.time_ >= var_349_1 + var_349_4 and arg_346_1.time_ < var_349_1 + var_349_4 + arg_349_0 then
				var_349_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_349_7 = 0
			local var_349_8 = 1

			if var_349_7 < arg_346_1.time_ and arg_346_1.time_ <= var_349_7 + arg_349_0 then
				local var_349_9 = "play"
				local var_349_10 = "effect"

				arg_346_1:AudioAction(var_349_9, var_349_10, "se_story_side_1050", "se_story_side_1050_fall", "")
			end

			local var_349_11 = 0
			local var_349_12 = 0.65

			if var_349_11 < arg_346_1.time_ and arg_346_1.time_ <= var_349_11 + arg_349_0 then
				arg_346_1.talkMaxDuration = 0
				arg_346_1.dialogCg_.alpha = 1

				arg_346_1.dialog_:SetActive(true)
				SetActive(arg_346_1.leftNameGo_, false)

				arg_346_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_346_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_346_1:RecordName(arg_346_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_346_1.iconTrs_.gameObject, false)
				arg_346_1.callingController_:SetSelectedState("normal")

				local var_349_13 = arg_346_1:GetWordFromCfg(424081083)
				local var_349_14 = arg_346_1:FormatText(var_349_13.content)

				arg_346_1.text_.text = var_349_14

				LuaForUtil.ClearLinePrefixSymbol(arg_346_1.text_)

				local var_349_15 = 26
				local var_349_16 = utf8.len(var_349_14)
				local var_349_17 = var_349_15 <= 0 and var_349_12 or var_349_12 * (var_349_16 / var_349_15)

				if var_349_17 > 0 and var_349_12 < var_349_17 then
					arg_346_1.talkMaxDuration = var_349_17

					if var_349_17 + var_349_11 > arg_346_1.duration_ then
						arg_346_1.duration_ = var_349_17 + var_349_11
					end
				end

				arg_346_1.text_.text = var_349_14
				arg_346_1.typewritter.percent = 0

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(false)
				arg_346_1:RecordContent(arg_346_1.text_.text)
			end

			local var_349_18 = math.max(var_349_12, arg_346_1.talkMaxDuration)

			if var_349_11 <= arg_346_1.time_ and arg_346_1.time_ < var_349_11 + var_349_18 then
				arg_346_1.typewritter.percent = (arg_346_1.time_ - var_349_11) / var_349_18

				arg_346_1.typewritter:SetDirty()
			end

			if arg_346_1.time_ >= var_349_11 + var_349_18 and arg_346_1.time_ < var_349_11 + var_349_18 + arg_349_0 then
				arg_346_1.typewritter.percent = 1

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(true)
			end
		end

		arg_346_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10154",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_346_1:InitPlayNodeList()
	end,
	Play424081084 = function(arg_350_0, arg_350_1)
		arg_350_1.time_ = 0
		arg_350_1.frameCnt_ = 0
		arg_350_1.state_ = "playing"
		arg_350_1.curTalkId_ = 424081084
		arg_350_1.duration_ = 7

		local var_350_0 = {
			zh = 6.9,
			ja = 7
		}
		local var_350_1 = manager.audio:GetLocalizationFlag()

		if var_350_0[var_350_1] ~= nil then
			arg_350_1.duration_ = var_350_0[var_350_1]
		end

		SetActive(arg_350_1.tipsGo_, false)

		function arg_350_1.onSingleLineFinish_()
			arg_350_1.onSingleLineUpdate_ = nil
			arg_350_1.onSingleLineFinish_ = nil
			arg_350_1.state_ = "waiting"
		end

		function arg_350_1.playNext_(arg_352_0)
			if arg_352_0 == 1 then
				arg_350_0:Play424081085(arg_350_1)
			end
		end

		function arg_350_1.onSingleLineUpdate_(arg_353_0)
			local var_353_0 = arg_350_1.actors_["10154"]
			local var_353_1 = 0

			if var_353_1 < arg_350_1.time_ and arg_350_1.time_ <= var_353_1 + arg_353_0 and not isNil(var_353_0) and arg_350_1.var_.actorSpriteComps10154 == nil then
				arg_350_1.var_.actorSpriteComps10154 = var_353_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_353_2 = 0.2

			if var_353_1 <= arg_350_1.time_ and arg_350_1.time_ < var_353_1 + var_353_2 and not isNil(var_353_0) then
				local var_353_3 = (arg_350_1.time_ - var_353_1) / var_353_2

				if arg_350_1.var_.actorSpriteComps10154 then
					for iter_353_0, iter_353_1 in pairs(arg_350_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_353_1 then
							if arg_350_1.isInRecall_ then
								local var_353_4 = Mathf.Lerp(iter_353_1.color.r, arg_350_1.hightColor1.r, var_353_3)
								local var_353_5 = Mathf.Lerp(iter_353_1.color.g, arg_350_1.hightColor1.g, var_353_3)
								local var_353_6 = Mathf.Lerp(iter_353_1.color.b, arg_350_1.hightColor1.b, var_353_3)

								iter_353_1.color = Color.New(var_353_4, var_353_5, var_353_6)
							else
								local var_353_7 = Mathf.Lerp(iter_353_1.color.r, 1, var_353_3)

								iter_353_1.color = Color.New(var_353_7, var_353_7, var_353_7)
							end
						end
					end
				end
			end

			if arg_350_1.time_ >= var_353_1 + var_353_2 and arg_350_1.time_ < var_353_1 + var_353_2 + arg_353_0 and not isNil(var_353_0) and arg_350_1.var_.actorSpriteComps10154 then
				for iter_353_2, iter_353_3 in pairs(arg_350_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_353_3 then
						if arg_350_1.isInRecall_ then
							iter_353_3.color = arg_350_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_353_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_350_1.var_.actorSpriteComps10154 = nil
			end

			local var_353_8 = arg_350_1.actors_["10154"].transform
			local var_353_9 = 0

			if var_353_9 < arg_350_1.time_ and arg_350_1.time_ <= var_353_9 + arg_353_0 then
				arg_350_1.var_.moveOldPos10154 = var_353_8.localPosition
				var_353_8.localScale = Vector3.New(1, 1, 1)

				arg_350_1:CheckSpriteTmpPos("10154", 3)

				local var_353_10 = var_353_8.childCount

				for iter_353_4 = 0, var_353_10 - 1 do
					local var_353_11 = var_353_8:GetChild(iter_353_4)

					if var_353_11.name == "split_4" or not string.find(var_353_11.name, "split") then
						var_353_11.gameObject:SetActive(true)
					else
						var_353_11.gameObject:SetActive(false)
					end
				end
			end

			local var_353_12 = 0.001

			if var_353_9 <= arg_350_1.time_ and arg_350_1.time_ < var_353_9 + var_353_12 then
				local var_353_13 = (arg_350_1.time_ - var_353_9) / var_353_12
				local var_353_14 = Vector3.New(-20, -338, -538)

				var_353_8.localPosition = Vector3.Lerp(arg_350_1.var_.moveOldPos10154, var_353_14, var_353_13)
			end

			if arg_350_1.time_ >= var_353_9 + var_353_12 and arg_350_1.time_ < var_353_9 + var_353_12 + arg_353_0 then
				var_353_8.localPosition = Vector3.New(-20, -338, -538)
			end

			local var_353_15 = 0
			local var_353_16 = 0.475

			if var_353_15 < arg_350_1.time_ and arg_350_1.time_ <= var_353_15 + arg_353_0 then
				arg_350_1.talkMaxDuration = 0
				arg_350_1.dialogCg_.alpha = 1

				arg_350_1.dialog_:SetActive(true)
				SetActive(arg_350_1.leftNameGo_, true)

				local var_353_17 = arg_350_1:FormatText(StoryNameCfg[1392].name)

				arg_350_1.leftNameTxt_.text = var_353_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_350_1.leftNameTxt_.transform)

				arg_350_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_350_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_350_1:RecordName(arg_350_1.leftNameTxt_.text)
				SetActive(arg_350_1.iconTrs_.gameObject, false)
				arg_350_1.callingController_:SetSelectedState("normal")

				local var_353_18 = arg_350_1:GetWordFromCfg(424081084)
				local var_353_19 = arg_350_1:FormatText(var_353_18.content)

				arg_350_1.text_.text = var_353_19

				LuaForUtil.ClearLinePrefixSymbol(arg_350_1.text_)

				local var_353_20 = 19
				local var_353_21 = utf8.len(var_353_19)
				local var_353_22 = var_353_20 <= 0 and var_353_16 or var_353_16 * (var_353_21 / var_353_20)

				if var_353_22 > 0 and var_353_16 < var_353_22 then
					arg_350_1.talkMaxDuration = var_353_22

					if var_353_22 + var_353_15 > arg_350_1.duration_ then
						arg_350_1.duration_ = var_353_22 + var_353_15
					end
				end

				arg_350_1.text_.text = var_353_19
				arg_350_1.typewritter.percent = 0

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424081", "424081084", "story_v_out_424081.awb") ~= 0 then
					local var_353_23 = manager.audio:GetVoiceLength("story_v_out_424081", "424081084", "story_v_out_424081.awb") / 1000

					if var_353_23 + var_353_15 > arg_350_1.duration_ then
						arg_350_1.duration_ = var_353_23 + var_353_15
					end

					if var_353_18.prefab_name ~= "" and arg_350_1.actors_[var_353_18.prefab_name] ~= nil then
						local var_353_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_350_1.actors_[var_353_18.prefab_name].transform, "story_v_out_424081", "424081084", "story_v_out_424081.awb")

						arg_350_1:RecordAudio("424081084", var_353_24)
						arg_350_1:RecordAudio("424081084", var_353_24)
					else
						arg_350_1:AudioAction("play", "voice", "story_v_out_424081", "424081084", "story_v_out_424081.awb")
					end

					arg_350_1:RecordHistoryTalkVoice("story_v_out_424081", "424081084", "story_v_out_424081.awb")
				end

				arg_350_1:RecordContent(arg_350_1.text_.text)
			end

			local var_353_25 = math.max(var_353_16, arg_350_1.talkMaxDuration)

			if var_353_15 <= arg_350_1.time_ and arg_350_1.time_ < var_353_15 + var_353_25 then
				arg_350_1.typewritter.percent = (arg_350_1.time_ - var_353_15) / var_353_25

				arg_350_1.typewritter:SetDirty()
			end

			if arg_350_1.time_ >= var_353_15 + var_353_25 and arg_350_1.time_ < var_353_15 + var_353_25 + arg_353_0 then
				arg_350_1.typewritter.percent = 1

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(true)
			end
		end

		arg_350_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10154",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_350_1:InitPlayNodeList()
	end,
	Play424081085 = function(arg_354_0, arg_354_1)
		arg_354_1.time_ = 0
		arg_354_1.frameCnt_ = 0
		arg_354_1.state_ = "playing"
		arg_354_1.curTalkId_ = 424081085
		arg_354_1.duration_ = 5

		SetActive(arg_354_1.tipsGo_, false)

		function arg_354_1.onSingleLineFinish_()
			arg_354_1.onSingleLineUpdate_ = nil
			arg_354_1.onSingleLineFinish_ = nil
			arg_354_1.state_ = "waiting"
		end

		function arg_354_1.playNext_(arg_356_0)
			if arg_356_0 == 1 then
				arg_354_0:Play424081086(arg_354_1)
			end
		end

		function arg_354_1.onSingleLineUpdate_(arg_357_0)
			local var_357_0 = arg_354_1.actors_["10154"]
			local var_357_1 = 0

			if var_357_1 < arg_354_1.time_ and arg_354_1.time_ <= var_357_1 + arg_357_0 and not isNil(var_357_0) and arg_354_1.var_.actorSpriteComps10154 == nil then
				arg_354_1.var_.actorSpriteComps10154 = var_357_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_357_2 = 0.2

			if var_357_1 <= arg_354_1.time_ and arg_354_1.time_ < var_357_1 + var_357_2 and not isNil(var_357_0) then
				local var_357_3 = (arg_354_1.time_ - var_357_1) / var_357_2

				if arg_354_1.var_.actorSpriteComps10154 then
					for iter_357_0, iter_357_1 in pairs(arg_354_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_357_1 then
							if arg_354_1.isInRecall_ then
								local var_357_4 = Mathf.Lerp(iter_357_1.color.r, arg_354_1.hightColor2.r, var_357_3)
								local var_357_5 = Mathf.Lerp(iter_357_1.color.g, arg_354_1.hightColor2.g, var_357_3)
								local var_357_6 = Mathf.Lerp(iter_357_1.color.b, arg_354_1.hightColor2.b, var_357_3)

								iter_357_1.color = Color.New(var_357_4, var_357_5, var_357_6)
							else
								local var_357_7 = Mathf.Lerp(iter_357_1.color.r, 0.5, var_357_3)

								iter_357_1.color = Color.New(var_357_7, var_357_7, var_357_7)
							end
						end
					end
				end
			end

			if arg_354_1.time_ >= var_357_1 + var_357_2 and arg_354_1.time_ < var_357_1 + var_357_2 + arg_357_0 and not isNil(var_357_0) and arg_354_1.var_.actorSpriteComps10154 then
				for iter_357_2, iter_357_3 in pairs(arg_354_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_357_3 then
						if arg_354_1.isInRecall_ then
							iter_357_3.color = arg_354_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_357_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_354_1.var_.actorSpriteComps10154 = nil
			end

			local var_357_8 = 0
			local var_357_9 = 0.65

			if var_357_8 < arg_354_1.time_ and arg_354_1.time_ <= var_357_8 + arg_357_0 then
				arg_354_1.talkMaxDuration = 0
				arg_354_1.dialogCg_.alpha = 1

				arg_354_1.dialog_:SetActive(true)
				SetActive(arg_354_1.leftNameGo_, true)

				local var_357_10 = arg_354_1:FormatText(StoryNameCfg[7].name)

				arg_354_1.leftNameTxt_.text = var_357_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_354_1.leftNameTxt_.transform)

				arg_354_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_354_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_354_1:RecordName(arg_354_1.leftNameTxt_.text)
				SetActive(arg_354_1.iconTrs_.gameObject, true)
				arg_354_1.iconController_:SetSelectedState("hero")

				arg_354_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_354_1.callingController_:SetSelectedState("normal")

				arg_354_1.keyicon_.color = Color.New(1, 1, 1)
				arg_354_1.icon_.color = Color.New(1, 1, 1)

				local var_357_11 = arg_354_1:GetWordFromCfg(424081085)
				local var_357_12 = arg_354_1:FormatText(var_357_11.content)

				arg_354_1.text_.text = var_357_12

				LuaForUtil.ClearLinePrefixSymbol(arg_354_1.text_)

				local var_357_13 = 26
				local var_357_14 = utf8.len(var_357_12)
				local var_357_15 = var_357_13 <= 0 and var_357_9 or var_357_9 * (var_357_14 / var_357_13)

				if var_357_15 > 0 and var_357_9 < var_357_15 then
					arg_354_1.talkMaxDuration = var_357_15

					if var_357_15 + var_357_8 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_15 + var_357_8
					end
				end

				arg_354_1.text_.text = var_357_12
				arg_354_1.typewritter.percent = 0

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(false)
				arg_354_1:RecordContent(arg_354_1.text_.text)
			end

			local var_357_16 = math.max(var_357_9, arg_354_1.talkMaxDuration)

			if var_357_8 <= arg_354_1.time_ and arg_354_1.time_ < var_357_8 + var_357_16 then
				arg_354_1.typewritter.percent = (arg_354_1.time_ - var_357_8) / var_357_16

				arg_354_1.typewritter:SetDirty()
			end

			if arg_354_1.time_ >= var_357_8 + var_357_16 and arg_354_1.time_ < var_357_8 + var_357_16 + arg_357_0 then
				arg_354_1.typewritter.percent = 1

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(true)
			end
		end

		arg_354_1.nodeConfigList_ = {}

		arg_354_1:InitPlayNodeList()
	end,
	Play424081086 = function(arg_358_0, arg_358_1)
		arg_358_1.time_ = 0
		arg_358_1.frameCnt_ = 0
		arg_358_1.state_ = "playing"
		arg_358_1.curTalkId_ = 424081086
		arg_358_1.duration_ = 5

		SetActive(arg_358_1.tipsGo_, false)

		function arg_358_1.onSingleLineFinish_()
			arg_358_1.onSingleLineUpdate_ = nil
			arg_358_1.onSingleLineFinish_ = nil
			arg_358_1.state_ = "waiting"
		end

		function arg_358_1.playNext_(arg_360_0)
			if arg_360_0 == 1 then
				arg_358_0:Play424081087(arg_358_1)
			end
		end

		function arg_358_1.onSingleLineUpdate_(arg_361_0)
			local var_361_0 = arg_358_1.actors_["10154"].transform
			local var_361_1 = 0

			if var_361_1 < arg_358_1.time_ and arg_358_1.time_ <= var_361_1 + arg_361_0 then
				arg_358_1.var_.moveOldPos10154 = var_361_0.localPosition
				var_361_0.localScale = Vector3.New(1, 1, 1)

				arg_358_1:CheckSpriteTmpPos("10154", 7)

				local var_361_2 = var_361_0.childCount

				for iter_361_0 = 0, var_361_2 - 1 do
					local var_361_3 = var_361_0:GetChild(iter_361_0)

					if var_361_3.name == "" or not string.find(var_361_3.name, "split") then
						var_361_3.gameObject:SetActive(true)
					else
						var_361_3.gameObject:SetActive(false)
					end
				end
			end

			local var_361_4 = 0.001

			if var_361_1 <= arg_358_1.time_ and arg_358_1.time_ < var_361_1 + var_361_4 then
				local var_361_5 = (arg_358_1.time_ - var_361_1) / var_361_4
				local var_361_6 = Vector3.New(0, -2000, 0)

				var_361_0.localPosition = Vector3.Lerp(arg_358_1.var_.moveOldPos10154, var_361_6, var_361_5)
			end

			if arg_358_1.time_ >= var_361_1 + var_361_4 and arg_358_1.time_ < var_361_1 + var_361_4 + arg_361_0 then
				var_361_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_361_7 = 0.034
			local var_361_8 = 1

			if var_361_7 < arg_358_1.time_ and arg_358_1.time_ <= var_361_7 + arg_361_0 then
				local var_361_9 = "play"
				local var_361_10 = "effect"

				arg_358_1:AudioAction(var_361_9, var_361_10, "se_story_1311", "se_story_1311_clap01", "")
			end

			local var_361_11 = 0
			local var_361_12 = 0.575

			if var_361_11 < arg_358_1.time_ and arg_358_1.time_ <= var_361_11 + arg_361_0 then
				arg_358_1.talkMaxDuration = 0
				arg_358_1.dialogCg_.alpha = 1

				arg_358_1.dialog_:SetActive(true)
				SetActive(arg_358_1.leftNameGo_, false)

				arg_358_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_358_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_358_1:RecordName(arg_358_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_358_1.iconTrs_.gameObject, false)
				arg_358_1.callingController_:SetSelectedState("normal")

				local var_361_13 = arg_358_1:GetWordFromCfg(424081086)
				local var_361_14 = arg_358_1:FormatText(var_361_13.content)

				arg_358_1.text_.text = var_361_14

				LuaForUtil.ClearLinePrefixSymbol(arg_358_1.text_)

				local var_361_15 = 23
				local var_361_16 = utf8.len(var_361_14)
				local var_361_17 = var_361_15 <= 0 and var_361_12 or var_361_12 * (var_361_16 / var_361_15)

				if var_361_17 > 0 and var_361_12 < var_361_17 then
					arg_358_1.talkMaxDuration = var_361_17

					if var_361_17 + var_361_11 > arg_358_1.duration_ then
						arg_358_1.duration_ = var_361_17 + var_361_11
					end
				end

				arg_358_1.text_.text = var_361_14
				arg_358_1.typewritter.percent = 0

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(false)
				arg_358_1:RecordContent(arg_358_1.text_.text)
			end

			local var_361_18 = math.max(var_361_12, arg_358_1.talkMaxDuration)

			if var_361_11 <= arg_358_1.time_ and arg_358_1.time_ < var_361_11 + var_361_18 then
				arg_358_1.typewritter.percent = (arg_358_1.time_ - var_361_11) / var_361_18

				arg_358_1.typewritter:SetDirty()
			end

			if arg_358_1.time_ >= var_361_11 + var_361_18 and arg_358_1.time_ < var_361_11 + var_361_18 + arg_361_0 then
				arg_358_1.typewritter.percent = 1

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(true)
			end
		end

		arg_358_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10154",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_358_1:InitPlayNodeList()
	end,
	Play424081087 = function(arg_362_0, arg_362_1)
		arg_362_1.time_ = 0
		arg_362_1.frameCnt_ = 0
		arg_362_1.state_ = "playing"
		arg_362_1.curTalkId_ = 424081087
		arg_362_1.duration_ = 5.93

		local var_362_0 = {
			zh = 5.333,
			ja = 5.933
		}
		local var_362_1 = manager.audio:GetLocalizationFlag()

		if var_362_0[var_362_1] ~= nil then
			arg_362_1.duration_ = var_362_0[var_362_1]
		end

		SetActive(arg_362_1.tipsGo_, false)

		function arg_362_1.onSingleLineFinish_()
			arg_362_1.onSingleLineUpdate_ = nil
			arg_362_1.onSingleLineFinish_ = nil
			arg_362_1.state_ = "waiting"
		end

		function arg_362_1.playNext_(arg_364_0)
			if arg_364_0 == 1 then
				arg_362_0:Play424081088(arg_362_1)
			end
		end

		function arg_362_1.onSingleLineUpdate_(arg_365_0)
			local var_365_0 = "I11i"

			if arg_362_1.bgs_[var_365_0] == nil then
				local var_365_1 = Object.Instantiate(arg_362_1.paintGo_)

				var_365_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_365_0)
				var_365_1.name = var_365_0
				var_365_1.transform.parent = arg_362_1.stage_.transform
				var_365_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_362_1.bgs_[var_365_0] = var_365_1
			end

			local var_365_2 = 2

			if var_365_2 < arg_362_1.time_ and arg_362_1.time_ <= var_365_2 + arg_365_0 then
				local var_365_3 = manager.ui.mainCamera.transform.localPosition
				local var_365_4 = Vector3.New(0, 0, 10) + Vector3.New(var_365_3.x, var_365_3.y, 0)
				local var_365_5 = arg_362_1.bgs_.I11i

				var_365_5.transform.localPosition = var_365_4
				var_365_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_365_6 = var_365_5:GetComponent("SpriteRenderer")

				if var_365_6 and var_365_6.sprite then
					local var_365_7 = (var_365_5.transform.localPosition - var_365_3).z
					local var_365_8 = manager.ui.mainCameraCom_
					local var_365_9 = 2 * var_365_7 * Mathf.Tan(var_365_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_365_10 = var_365_9 * var_365_8.aspect
					local var_365_11 = var_365_6.sprite.bounds.size.x
					local var_365_12 = var_365_6.sprite.bounds.size.y
					local var_365_13 = var_365_10 / var_365_11
					local var_365_14 = var_365_9 / var_365_12
					local var_365_15 = var_365_14 < var_365_13 and var_365_13 or var_365_14

					var_365_5.transform.localScale = Vector3.New(var_365_15, var_365_15, 0)
				end

				for iter_365_0, iter_365_1 in pairs(arg_362_1.bgs_) do
					if iter_365_0 ~= "I11i" then
						iter_365_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_365_16 = 4

			if var_365_16 < arg_362_1.time_ and arg_362_1.time_ <= var_365_16 + arg_365_0 then
				arg_362_1.allBtn_.enabled = false
			end

			local var_365_17 = 0.3

			if arg_362_1.time_ >= var_365_16 + var_365_17 and arg_362_1.time_ < var_365_16 + var_365_17 + arg_365_0 then
				arg_362_1.allBtn_.enabled = true
			end

			local var_365_18 = 0

			if var_365_18 < arg_362_1.time_ and arg_362_1.time_ <= var_365_18 + arg_365_0 then
				arg_362_1.mask_.enabled = true
				arg_362_1.mask_.raycastTarget = true

				arg_362_1:SetGaussion(false)
			end

			local var_365_19 = 2

			if var_365_18 <= arg_362_1.time_ and arg_362_1.time_ < var_365_18 + var_365_19 then
				local var_365_20 = (arg_362_1.time_ - var_365_18) / var_365_19
				local var_365_21 = Color.New(0, 0, 0)

				var_365_21.a = Mathf.Lerp(0, 1, var_365_20)
				arg_362_1.mask_.color = var_365_21
			end

			if arg_362_1.time_ >= var_365_18 + var_365_19 and arg_362_1.time_ < var_365_18 + var_365_19 + arg_365_0 then
				local var_365_22 = Color.New(0, 0, 0)

				var_365_22.a = 1
				arg_362_1.mask_.color = var_365_22
			end

			local var_365_23 = 2

			if var_365_23 < arg_362_1.time_ and arg_362_1.time_ <= var_365_23 + arg_365_0 then
				arg_362_1.mask_.enabled = true
				arg_362_1.mask_.raycastTarget = true

				arg_362_1:SetGaussion(false)
			end

			local var_365_24 = 2

			if var_365_23 <= arg_362_1.time_ and arg_362_1.time_ < var_365_23 + var_365_24 then
				local var_365_25 = (arg_362_1.time_ - var_365_23) / var_365_24
				local var_365_26 = Color.New(0, 0, 0)

				var_365_26.a = Mathf.Lerp(1, 0, var_365_25)
				arg_362_1.mask_.color = var_365_26
			end

			if arg_362_1.time_ >= var_365_23 + var_365_24 and arg_362_1.time_ < var_365_23 + var_365_24 + arg_365_0 then
				local var_365_27 = Color.New(0, 0, 0)
				local var_365_28 = 0

				arg_362_1.mask_.enabled = false
				var_365_27.a = var_365_28
				arg_362_1.mask_.color = var_365_27
			end

			local var_365_29 = arg_362_1.actors_["1094"]
			local var_365_30 = 3.8

			if var_365_30 < arg_362_1.time_ and arg_362_1.time_ <= var_365_30 + arg_365_0 and not isNil(var_365_29) and arg_362_1.var_.actorSpriteComps1094 == nil then
				arg_362_1.var_.actorSpriteComps1094 = var_365_29:GetComponentsInChildren(typeof(Image), true)
			end

			local var_365_31 = 0.2

			if var_365_30 <= arg_362_1.time_ and arg_362_1.time_ < var_365_30 + var_365_31 and not isNil(var_365_29) then
				local var_365_32 = (arg_362_1.time_ - var_365_30) / var_365_31

				if arg_362_1.var_.actorSpriteComps1094 then
					for iter_365_2, iter_365_3 in pairs(arg_362_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_365_3 then
							if arg_362_1.isInRecall_ then
								local var_365_33 = Mathf.Lerp(iter_365_3.color.r, arg_362_1.hightColor1.r, var_365_32)
								local var_365_34 = Mathf.Lerp(iter_365_3.color.g, arg_362_1.hightColor1.g, var_365_32)
								local var_365_35 = Mathf.Lerp(iter_365_3.color.b, arg_362_1.hightColor1.b, var_365_32)

								iter_365_3.color = Color.New(var_365_33, var_365_34, var_365_35)
							else
								local var_365_36 = Mathf.Lerp(iter_365_3.color.r, 1, var_365_32)

								iter_365_3.color = Color.New(var_365_36, var_365_36, var_365_36)
							end
						end
					end
				end
			end

			if arg_362_1.time_ >= var_365_30 + var_365_31 and arg_362_1.time_ < var_365_30 + var_365_31 + arg_365_0 and not isNil(var_365_29) and arg_362_1.var_.actorSpriteComps1094 then
				for iter_365_4, iter_365_5 in pairs(arg_362_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_365_5 then
						if arg_362_1.isInRecall_ then
							iter_365_5.color = arg_362_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_365_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_362_1.var_.actorSpriteComps1094 = nil
			end

			local var_365_37 = arg_362_1.actors_["1094"].transform
			local var_365_38 = 3.8

			if var_365_38 < arg_362_1.time_ and arg_362_1.time_ <= var_365_38 + arg_365_0 then
				arg_362_1.var_.moveOldPos1094 = var_365_37.localPosition
				var_365_37.localScale = Vector3.New(1, 1, 1)

				arg_362_1:CheckSpriteTmpPos("1094", 3)

				local var_365_39 = var_365_37.childCount

				for iter_365_6 = 0, var_365_39 - 1 do
					local var_365_40 = var_365_37:GetChild(iter_365_6)

					if var_365_40.name == "split_1" or not string.find(var_365_40.name, "split") then
						var_365_40.gameObject:SetActive(true)
					else
						var_365_40.gameObject:SetActive(false)
					end
				end
			end

			local var_365_41 = 0.001

			if var_365_38 <= arg_362_1.time_ and arg_362_1.time_ < var_365_38 + var_365_41 then
				local var_365_42 = (arg_362_1.time_ - var_365_38) / var_365_41
				local var_365_43 = Vector3.New(0, -335, -230)

				var_365_37.localPosition = Vector3.Lerp(arg_362_1.var_.moveOldPos1094, var_365_43, var_365_42)
			end

			if arg_362_1.time_ >= var_365_38 + var_365_41 and arg_362_1.time_ < var_365_38 + var_365_41 + arg_365_0 then
				var_365_37.localPosition = Vector3.New(0, -335, -230)
			end

			local var_365_44 = 0.1
			local var_365_45 = 1

			if var_365_44 < arg_362_1.time_ and arg_362_1.time_ <= var_365_44 + arg_365_0 then
				local var_365_46 = "stop"
				local var_365_47 = "effect"

				arg_362_1:AudioAction(var_365_46, var_365_47, "se_story_140", "se_story_140_amb_room01", "")
			end

			local var_365_48 = 1.6
			local var_365_49 = 1

			if var_365_48 < arg_362_1.time_ and arg_362_1.time_ <= var_365_48 + arg_365_0 then
				local var_365_50 = "play"
				local var_365_51 = "effect"

				arg_362_1:AudioAction(var_365_50, var_365_51, "se_story_140", "se_story_140_amb_street02", "")
			end

			if arg_362_1.frameCnt_ <= 1 then
				arg_362_1.dialog_:SetActive(false)
			end

			local var_365_52 = 4
			local var_365_53 = 0.1

			if var_365_52 < arg_362_1.time_ and arg_362_1.time_ <= var_365_52 + arg_365_0 then
				arg_362_1.talkMaxDuration = 0

				arg_362_1.dialog_:SetActive(true)

				arg_362_1.dialogCg_.alpha = 0

				local var_365_54 = LeanTween.value(arg_362_1.dialog_, 0, 1, 0.3)

				var_365_54:setOnUpdate(LuaHelper.FloatAction(function(arg_366_0)
					arg_362_1.dialogCg_.alpha = arg_366_0
				end))
				var_365_54:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_362_1.dialog_)
					var_365_54:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_362_1.duration_ = arg_362_1.duration_ + 0.3

				SetActive(arg_362_1.leftNameGo_, true)

				local var_365_55 = arg_362_1:FormatText(StoryNameCfg[181].name)

				arg_362_1.leftNameTxt_.text = var_365_55

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_362_1.leftNameTxt_.transform)

				arg_362_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_362_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_362_1:RecordName(arg_362_1.leftNameTxt_.text)
				SetActive(arg_362_1.iconTrs_.gameObject, false)
				arg_362_1.callingController_:SetSelectedState("normal")

				local var_365_56 = arg_362_1:GetWordFromCfg(424081087)
				local var_365_57 = arg_362_1:FormatText(var_365_56.content)

				arg_362_1.text_.text = var_365_57

				LuaForUtil.ClearLinePrefixSymbol(arg_362_1.text_)

				local var_365_58 = 4
				local var_365_59 = utf8.len(var_365_57)
				local var_365_60 = var_365_58 <= 0 and var_365_53 or var_365_53 * (var_365_59 / var_365_58)

				if var_365_60 > 0 and var_365_53 < var_365_60 then
					arg_362_1.talkMaxDuration = var_365_60
					var_365_52 = var_365_52 + 0.3

					if var_365_60 + var_365_52 > arg_362_1.duration_ then
						arg_362_1.duration_ = var_365_60 + var_365_52
					end
				end

				arg_362_1.text_.text = var_365_57
				arg_362_1.typewritter.percent = 0

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424081", "424081087", "story_v_out_424081.awb") ~= 0 then
					local var_365_61 = manager.audio:GetVoiceLength("story_v_out_424081", "424081087", "story_v_out_424081.awb") / 1000

					if var_365_61 + var_365_52 > arg_362_1.duration_ then
						arg_362_1.duration_ = var_365_61 + var_365_52
					end

					if var_365_56.prefab_name ~= "" and arg_362_1.actors_[var_365_56.prefab_name] ~= nil then
						local var_365_62 = LuaForUtil.PlayVoiceWithCriLipsync(arg_362_1.actors_[var_365_56.prefab_name].transform, "story_v_out_424081", "424081087", "story_v_out_424081.awb")

						arg_362_1:RecordAudio("424081087", var_365_62)
						arg_362_1:RecordAudio("424081087", var_365_62)
					else
						arg_362_1:AudioAction("play", "voice", "story_v_out_424081", "424081087", "story_v_out_424081.awb")
					end

					arg_362_1:RecordHistoryTalkVoice("story_v_out_424081", "424081087", "story_v_out_424081.awb")
				end

				arg_362_1:RecordContent(arg_362_1.text_.text)
			end

			local var_365_63 = var_365_52 + 0.3
			local var_365_64 = math.max(var_365_53, arg_362_1.talkMaxDuration)

			if var_365_63 <= arg_362_1.time_ and arg_362_1.time_ < var_365_63 + var_365_64 then
				arg_362_1.typewritter.percent = (arg_362_1.time_ - var_365_63) / var_365_64

				arg_362_1.typewritter:SetDirty()
			end

			if arg_362_1.time_ >= var_365_63 + var_365_64 and arg_362_1.time_ < var_365_63 + var_365_64 + arg_365_0 then
				arg_362_1.typewritter.percent = 1

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(true)
			end
		end

		arg_362_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_362_1:InitPlayNodeList()
	end,
	Play424081088 = function(arg_368_0, arg_368_1)
		arg_368_1.time_ = 0
		arg_368_1.frameCnt_ = 0
		arg_368_1.state_ = "playing"
		arg_368_1.curTalkId_ = 424081088
		arg_368_1.duration_ = 5

		SetActive(arg_368_1.tipsGo_, false)

		function arg_368_1.onSingleLineFinish_()
			arg_368_1.onSingleLineUpdate_ = nil
			arg_368_1.onSingleLineFinish_ = nil
			arg_368_1.state_ = "waiting"
		end

		function arg_368_1.playNext_(arg_370_0)
			if arg_370_0 == 1 then
				arg_368_0:Play424081089(arg_368_1)
			end
		end

		function arg_368_1.onSingleLineUpdate_(arg_371_0)
			local var_371_0 = arg_368_1.actors_["1094"]
			local var_371_1 = 0

			if var_371_1 < arg_368_1.time_ and arg_368_1.time_ <= var_371_1 + arg_371_0 and not isNil(var_371_0) and arg_368_1.var_.actorSpriteComps1094 == nil then
				arg_368_1.var_.actorSpriteComps1094 = var_371_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_371_2 = 0.2

			if var_371_1 <= arg_368_1.time_ and arg_368_1.time_ < var_371_1 + var_371_2 and not isNil(var_371_0) then
				local var_371_3 = (arg_368_1.time_ - var_371_1) / var_371_2

				if arg_368_1.var_.actorSpriteComps1094 then
					for iter_371_0, iter_371_1 in pairs(arg_368_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_371_1 then
							if arg_368_1.isInRecall_ then
								local var_371_4 = Mathf.Lerp(iter_371_1.color.r, arg_368_1.hightColor2.r, var_371_3)
								local var_371_5 = Mathf.Lerp(iter_371_1.color.g, arg_368_1.hightColor2.g, var_371_3)
								local var_371_6 = Mathf.Lerp(iter_371_1.color.b, arg_368_1.hightColor2.b, var_371_3)

								iter_371_1.color = Color.New(var_371_4, var_371_5, var_371_6)
							else
								local var_371_7 = Mathf.Lerp(iter_371_1.color.r, 0.5, var_371_3)

								iter_371_1.color = Color.New(var_371_7, var_371_7, var_371_7)
							end
						end
					end
				end
			end

			if arg_368_1.time_ >= var_371_1 + var_371_2 and arg_368_1.time_ < var_371_1 + var_371_2 + arg_371_0 and not isNil(var_371_0) and arg_368_1.var_.actorSpriteComps1094 then
				for iter_371_2, iter_371_3 in pairs(arg_368_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_371_3 then
						if arg_368_1.isInRecall_ then
							iter_371_3.color = arg_368_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_371_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_368_1.var_.actorSpriteComps1094 = nil
			end

			local var_371_8 = 0
			local var_371_9 = 0.7

			if var_371_8 < arg_368_1.time_ and arg_368_1.time_ <= var_371_8 + arg_371_0 then
				arg_368_1.talkMaxDuration = 0
				arg_368_1.dialogCg_.alpha = 1

				arg_368_1.dialog_:SetActive(true)
				SetActive(arg_368_1.leftNameGo_, true)

				local var_371_10 = arg_368_1:FormatText(StoryNameCfg[7].name)

				arg_368_1.leftNameTxt_.text = var_371_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_368_1.leftNameTxt_.transform)

				arg_368_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_368_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_368_1:RecordName(arg_368_1.leftNameTxt_.text)
				SetActive(arg_368_1.iconTrs_.gameObject, true)
				arg_368_1.iconController_:SetSelectedState("hero")

				arg_368_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_368_1.callingController_:SetSelectedState("normal")

				arg_368_1.keyicon_.color = Color.New(1, 1, 1)
				arg_368_1.icon_.color = Color.New(1, 1, 1)

				local var_371_11 = arg_368_1:GetWordFromCfg(424081088)
				local var_371_12 = arg_368_1:FormatText(var_371_11.content)

				arg_368_1.text_.text = var_371_12

				LuaForUtil.ClearLinePrefixSymbol(arg_368_1.text_)

				local var_371_13 = 28
				local var_371_14 = utf8.len(var_371_12)
				local var_371_15 = var_371_13 <= 0 and var_371_9 or var_371_9 * (var_371_14 / var_371_13)

				if var_371_15 > 0 and var_371_9 < var_371_15 then
					arg_368_1.talkMaxDuration = var_371_15

					if var_371_15 + var_371_8 > arg_368_1.duration_ then
						arg_368_1.duration_ = var_371_15 + var_371_8
					end
				end

				arg_368_1.text_.text = var_371_12
				arg_368_1.typewritter.percent = 0

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(false)
				arg_368_1:RecordContent(arg_368_1.text_.text)
			end

			local var_371_16 = math.max(var_371_9, arg_368_1.talkMaxDuration)

			if var_371_8 <= arg_368_1.time_ and arg_368_1.time_ < var_371_8 + var_371_16 then
				arg_368_1.typewritter.percent = (arg_368_1.time_ - var_371_8) / var_371_16

				arg_368_1.typewritter:SetDirty()
			end

			if arg_368_1.time_ >= var_371_8 + var_371_16 and arg_368_1.time_ < var_371_8 + var_371_16 + arg_371_0 then
				arg_368_1.typewritter.percent = 1

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(true)
			end
		end

		arg_368_1.nodeConfigList_ = {}

		arg_368_1:InitPlayNodeList()
	end,
	Play424081089 = function(arg_372_0, arg_372_1)
		arg_372_1.time_ = 0
		arg_372_1.frameCnt_ = 0
		arg_372_1.state_ = "playing"
		arg_372_1.curTalkId_ = 424081089
		arg_372_1.duration_ = 9

		SetActive(arg_372_1.tipsGo_, false)

		function arg_372_1.onSingleLineFinish_()
			arg_372_1.onSingleLineUpdate_ = nil
			arg_372_1.onSingleLineFinish_ = nil
			arg_372_1.state_ = "waiting"
		end

		function arg_372_1.playNext_(arg_374_0)
			if arg_374_0 == 1 then
				arg_372_0:Play424081090(arg_372_1)
			end
		end

		function arg_372_1.onSingleLineUpdate_(arg_375_0)
			local var_375_0 = 2

			if var_375_0 < arg_372_1.time_ and arg_372_1.time_ <= var_375_0 + arg_375_0 then
				local var_375_1 = manager.ui.mainCamera.transform.localPosition
				local var_375_2 = Vector3.New(0, 0, 10) + Vector3.New(var_375_1.x, var_375_1.y, 0)
				local var_375_3 = arg_372_1.bgs_.STblack

				var_375_3.transform.localPosition = var_375_2
				var_375_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_375_4 = var_375_3:GetComponent("SpriteRenderer")

				if var_375_4 and var_375_4.sprite then
					local var_375_5 = (var_375_3.transform.localPosition - var_375_1).z
					local var_375_6 = manager.ui.mainCameraCom_
					local var_375_7 = 2 * var_375_5 * Mathf.Tan(var_375_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_375_8 = var_375_7 * var_375_6.aspect
					local var_375_9 = var_375_4.sprite.bounds.size.x
					local var_375_10 = var_375_4.sprite.bounds.size.y
					local var_375_11 = var_375_8 / var_375_9
					local var_375_12 = var_375_7 / var_375_10
					local var_375_13 = var_375_12 < var_375_11 and var_375_11 or var_375_12

					var_375_3.transform.localScale = Vector3.New(var_375_13, var_375_13, 0)
				end

				for iter_375_0, iter_375_1 in pairs(arg_372_1.bgs_) do
					if iter_375_0 ~= "STblack" then
						iter_375_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_375_14 = 4

			if var_375_14 < arg_372_1.time_ and arg_372_1.time_ <= var_375_14 + arg_375_0 then
				arg_372_1.allBtn_.enabled = false
			end

			local var_375_15 = 0.3

			if arg_372_1.time_ >= var_375_14 + var_375_15 and arg_372_1.time_ < var_375_14 + var_375_15 + arg_375_0 then
				arg_372_1.allBtn_.enabled = true
			end

			local var_375_16 = 0

			if var_375_16 < arg_372_1.time_ and arg_372_1.time_ <= var_375_16 + arg_375_0 then
				arg_372_1.mask_.enabled = true
				arg_372_1.mask_.raycastTarget = true

				arg_372_1:SetGaussion(false)
			end

			local var_375_17 = 2

			if var_375_16 <= arg_372_1.time_ and arg_372_1.time_ < var_375_16 + var_375_17 then
				local var_375_18 = (arg_372_1.time_ - var_375_16) / var_375_17
				local var_375_19 = Color.New(0, 0, 0)

				var_375_19.a = Mathf.Lerp(0, 1, var_375_18)
				arg_372_1.mask_.color = var_375_19
			end

			if arg_372_1.time_ >= var_375_16 + var_375_17 and arg_372_1.time_ < var_375_16 + var_375_17 + arg_375_0 then
				local var_375_20 = Color.New(0, 0, 0)

				var_375_20.a = 1
				arg_372_1.mask_.color = var_375_20
			end

			local var_375_21 = 2

			if var_375_21 < arg_372_1.time_ and arg_372_1.time_ <= var_375_21 + arg_375_0 then
				arg_372_1.mask_.enabled = true
				arg_372_1.mask_.raycastTarget = true

				arg_372_1:SetGaussion(false)
			end

			local var_375_22 = 2

			if var_375_21 <= arg_372_1.time_ and arg_372_1.time_ < var_375_21 + var_375_22 then
				local var_375_23 = (arg_372_1.time_ - var_375_21) / var_375_22
				local var_375_24 = Color.New(0, 0, 0)

				var_375_24.a = Mathf.Lerp(1, 0, var_375_23)
				arg_372_1.mask_.color = var_375_24
			end

			if arg_372_1.time_ >= var_375_21 + var_375_22 and arg_372_1.time_ < var_375_21 + var_375_22 + arg_375_0 then
				local var_375_25 = Color.New(0, 0, 0)
				local var_375_26 = 0

				arg_372_1.mask_.enabled = false
				var_375_25.a = var_375_26
				arg_372_1.mask_.color = var_375_25
			end

			local var_375_27 = arg_372_1.actors_["1094"].transform
			local var_375_28 = 1.966

			if var_375_28 < arg_372_1.time_ and arg_372_1.time_ <= var_375_28 + arg_375_0 then
				arg_372_1.var_.moveOldPos1094 = var_375_27.localPosition
				var_375_27.localScale = Vector3.New(1, 1, 1)

				arg_372_1:CheckSpriteTmpPos("1094", 7)

				local var_375_29 = var_375_27.childCount

				for iter_375_2 = 0, var_375_29 - 1 do
					local var_375_30 = var_375_27:GetChild(iter_375_2)

					if var_375_30.name == "" or not string.find(var_375_30.name, "split") then
						var_375_30.gameObject:SetActive(true)
					else
						var_375_30.gameObject:SetActive(false)
					end
				end
			end

			local var_375_31 = 0.001

			if var_375_28 <= arg_372_1.time_ and arg_372_1.time_ < var_375_28 + var_375_31 then
				local var_375_32 = (arg_372_1.time_ - var_375_28) / var_375_31
				local var_375_33 = Vector3.New(0, -2000, 0)

				var_375_27.localPosition = Vector3.Lerp(arg_372_1.var_.moveOldPos1094, var_375_33, var_375_32)
			end

			if arg_372_1.time_ >= var_375_28 + var_375_31 and arg_372_1.time_ < var_375_28 + var_375_31 + arg_375_0 then
				var_375_27.localPosition = Vector3.New(0, -2000, 0)
			end

			if arg_372_1.frameCnt_ <= 1 then
				arg_372_1.dialog_:SetActive(false)
			end

			local var_375_34 = 4
			local var_375_35 = 1.425

			if var_375_34 < arg_372_1.time_ and arg_372_1.time_ <= var_375_34 + arg_375_0 then
				arg_372_1.talkMaxDuration = 0

				arg_372_1.dialog_:SetActive(true)

				arg_372_1.dialogCg_.alpha = 0

				local var_375_36 = LeanTween.value(arg_372_1.dialog_, 0, 1, 0.3)

				var_375_36:setOnUpdate(LuaHelper.FloatAction(function(arg_376_0)
					arg_372_1.dialogCg_.alpha = arg_376_0
				end))
				var_375_36:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_372_1.dialog_)
					var_375_36:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_372_1.duration_ = arg_372_1.duration_ + 0.3

				SetActive(arg_372_1.leftNameGo_, false)

				arg_372_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_372_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_372_1:RecordName(arg_372_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_372_1.iconTrs_.gameObject, false)
				arg_372_1.callingController_:SetSelectedState("normal")

				local var_375_37 = arg_372_1:GetWordFromCfg(424081089)
				local var_375_38 = arg_372_1:FormatText(var_375_37.content)

				arg_372_1.text_.text = var_375_38

				LuaForUtil.ClearLinePrefixSymbol(arg_372_1.text_)

				local var_375_39 = 57
				local var_375_40 = utf8.len(var_375_38)
				local var_375_41 = var_375_39 <= 0 and var_375_35 or var_375_35 * (var_375_40 / var_375_39)

				if var_375_41 > 0 and var_375_35 < var_375_41 then
					arg_372_1.talkMaxDuration = var_375_41
					var_375_34 = var_375_34 + 0.3

					if var_375_41 + var_375_34 > arg_372_1.duration_ then
						arg_372_1.duration_ = var_375_41 + var_375_34
					end
				end

				arg_372_1.text_.text = var_375_38
				arg_372_1.typewritter.percent = 0

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(false)
				arg_372_1:RecordContent(arg_372_1.text_.text)
			end

			local var_375_42 = var_375_34 + 0.3
			local var_375_43 = math.max(var_375_35, arg_372_1.talkMaxDuration)

			if var_375_42 <= arg_372_1.time_ and arg_372_1.time_ < var_375_42 + var_375_43 then
				arg_372_1.typewritter.percent = (arg_372_1.time_ - var_375_42) / var_375_43

				arg_372_1.typewritter:SetDirty()
			end

			if arg_372_1.time_ >= var_375_42 + var_375_43 and arg_372_1.time_ < var_375_42 + var_375_43 + arg_375_0 then
				arg_372_1.typewritter.percent = 1

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(true)
			end
		end

		arg_372_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_372_1:InitPlayNodeList()
	end,
	Play424081090 = function(arg_378_0, arg_378_1)
		arg_378_1.time_ = 0
		arg_378_1.frameCnt_ = 0
		arg_378_1.state_ = "playing"
		arg_378_1.curTalkId_ = 424081090
		arg_378_1.duration_ = 5

		SetActive(arg_378_1.tipsGo_, false)

		function arg_378_1.onSingleLineFinish_()
			arg_378_1.onSingleLineUpdate_ = nil
			arg_378_1.onSingleLineFinish_ = nil
			arg_378_1.state_ = "waiting"
		end

		function arg_378_1.playNext_(arg_380_0)
			if arg_380_0 == 1 then
				arg_378_0:Play424081091(arg_378_1)
			end
		end

		function arg_378_1.onSingleLineUpdate_(arg_381_0)
			local var_381_0 = 0
			local var_381_1 = 0.925

			if var_381_0 < arg_378_1.time_ and arg_378_1.time_ <= var_381_0 + arg_381_0 then
				arg_378_1.talkMaxDuration = 0
				arg_378_1.dialogCg_.alpha = 1

				arg_378_1.dialog_:SetActive(true)
				SetActive(arg_378_1.leftNameGo_, false)

				arg_378_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_378_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_378_1:RecordName(arg_378_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_378_1.iconTrs_.gameObject, false)
				arg_378_1.callingController_:SetSelectedState("normal")

				local var_381_2 = arg_378_1:GetWordFromCfg(424081090)
				local var_381_3 = arg_378_1:FormatText(var_381_2.content)

				arg_378_1.text_.text = var_381_3

				LuaForUtil.ClearLinePrefixSymbol(arg_378_1.text_)

				local var_381_4 = 37
				local var_381_5 = utf8.len(var_381_3)
				local var_381_6 = var_381_4 <= 0 and var_381_1 or var_381_1 * (var_381_5 / var_381_4)

				if var_381_6 > 0 and var_381_1 < var_381_6 then
					arg_378_1.talkMaxDuration = var_381_6

					if var_381_6 + var_381_0 > arg_378_1.duration_ then
						arg_378_1.duration_ = var_381_6 + var_381_0
					end
				end

				arg_378_1.text_.text = var_381_3
				arg_378_1.typewritter.percent = 0

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(false)
				arg_378_1:RecordContent(arg_378_1.text_.text)
			end

			local var_381_7 = math.max(var_381_1, arg_378_1.talkMaxDuration)

			if var_381_0 <= arg_378_1.time_ and arg_378_1.time_ < var_381_0 + var_381_7 then
				arg_378_1.typewritter.percent = (arg_378_1.time_ - var_381_0) / var_381_7

				arg_378_1.typewritter:SetDirty()
			end

			if arg_378_1.time_ >= var_381_0 + var_381_7 and arg_378_1.time_ < var_381_0 + var_381_7 + arg_381_0 then
				arg_378_1.typewritter.percent = 1

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(true)
			end
		end

		arg_378_1.nodeConfigList_ = {}

		arg_378_1:InitPlayNodeList()
	end,
	Play424081091 = function(arg_382_0, arg_382_1)
		arg_382_1.time_ = 0
		arg_382_1.frameCnt_ = 0
		arg_382_1.state_ = "playing"
		arg_382_1.curTalkId_ = 424081091
		arg_382_1.duration_ = 6.27

		local var_382_0 = {
			zh = 5.7,
			ja = 6.266
		}
		local var_382_1 = manager.audio:GetLocalizationFlag()

		if var_382_0[var_382_1] ~= nil then
			arg_382_1.duration_ = var_382_0[var_382_1]
		end

		SetActive(arg_382_1.tipsGo_, false)

		function arg_382_1.onSingleLineFinish_()
			arg_382_1.onSingleLineUpdate_ = nil
			arg_382_1.onSingleLineFinish_ = nil
			arg_382_1.state_ = "waiting"
		end

		function arg_382_1.playNext_(arg_384_0)
			if arg_384_0 == 1 then
				arg_382_0:Play424081092(arg_382_1)
			end
		end

		function arg_382_1.onSingleLineUpdate_(arg_385_0)
			local var_385_0 = 0

			if var_385_0 < arg_382_1.time_ and arg_382_1.time_ <= var_385_0 + arg_385_0 then
				local var_385_1 = manager.ui.mainCamera.transform.localPosition
				local var_385_2 = Vector3.New(0, 0, 10) + Vector3.New(var_385_1.x, var_385_1.y, 0)
				local var_385_3 = arg_382_1.bgs_.SS2402

				var_385_3.transform.localPosition = var_385_2
				var_385_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_385_4 = var_385_3:GetComponent("SpriteRenderer")

				if var_385_4 and var_385_4.sprite then
					local var_385_5 = (var_385_3.transform.localPosition - var_385_1).z
					local var_385_6 = manager.ui.mainCameraCom_
					local var_385_7 = 2 * var_385_5 * Mathf.Tan(var_385_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_385_8 = var_385_7 * var_385_6.aspect
					local var_385_9 = var_385_4.sprite.bounds.size.x
					local var_385_10 = var_385_4.sprite.bounds.size.y
					local var_385_11 = var_385_8 / var_385_9
					local var_385_12 = var_385_7 / var_385_10
					local var_385_13 = var_385_12 < var_385_11 and var_385_11 or var_385_12

					var_385_3.transform.localScale = Vector3.New(var_385_13, var_385_13, 0)
				end

				for iter_385_0, iter_385_1 in pairs(arg_382_1.bgs_) do
					if iter_385_0 ~= "SS2402" then
						iter_385_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_385_14 = 2

			if var_385_14 < arg_382_1.time_ and arg_382_1.time_ <= var_385_14 + arg_385_0 then
				arg_382_1.allBtn_.enabled = false
			end

			local var_385_15 = 0.3

			if arg_382_1.time_ >= var_385_14 + var_385_15 and arg_382_1.time_ < var_385_14 + var_385_15 + arg_385_0 then
				arg_382_1.allBtn_.enabled = true
			end

			local var_385_16 = 0

			if var_385_16 < arg_382_1.time_ and arg_382_1.time_ <= var_385_16 + arg_385_0 then
				arg_382_1.mask_.enabled = true
				arg_382_1.mask_.raycastTarget = true

				arg_382_1:SetGaussion(false)
			end

			local var_385_17 = 2

			if var_385_16 <= arg_382_1.time_ and arg_382_1.time_ < var_385_16 + var_385_17 then
				local var_385_18 = (arg_382_1.time_ - var_385_16) / var_385_17
				local var_385_19 = Color.New(0, 0, 0)

				var_385_19.a = Mathf.Lerp(1, 0, var_385_18)
				arg_382_1.mask_.color = var_385_19
			end

			if arg_382_1.time_ >= var_385_16 + var_385_17 and arg_382_1.time_ < var_385_16 + var_385_17 + arg_385_0 then
				local var_385_20 = Color.New(0, 0, 0)
				local var_385_21 = 0

				arg_382_1.mask_.enabled = false
				var_385_20.a = var_385_21
				arg_382_1.mask_.color = var_385_20
			end

			local var_385_22 = arg_382_1.bgs_.SS2402.transform
			local var_385_23 = 0

			if var_385_23 < arg_382_1.time_ and arg_382_1.time_ <= var_385_23 + arg_385_0 then
				arg_382_1.var_.moveOldPosSS2402 = var_385_22.localPosition
			end

			local var_385_24 = 2

			if var_385_23 <= arg_382_1.time_ and arg_382_1.time_ < var_385_23 + var_385_24 then
				local var_385_25 = (arg_382_1.time_ - var_385_23) / var_385_24
				local var_385_26 = Vector3.New(-1.2, 0, 3.64)

				var_385_22.localPosition = Vector3.Lerp(arg_382_1.var_.moveOldPosSS2402, var_385_26, var_385_25)
			end

			if arg_382_1.time_ >= var_385_23 + var_385_24 and arg_382_1.time_ < var_385_23 + var_385_24 + arg_385_0 then
				var_385_22.localPosition = Vector3.New(-1.2, 0, 3.64)
			end

			local var_385_27 = 0
			local var_385_28 = 1

			if var_385_27 < arg_382_1.time_ and arg_382_1.time_ <= var_385_27 + arg_385_0 then
				local var_385_29 = "stop"
				local var_385_30 = "effect"

				arg_382_1:AudioAction(var_385_29, var_385_30, "se_story_140", "se_story_140_amb_street02", "")
			end

			local var_385_31 = 0.2
			local var_385_32 = 1

			if var_385_31 < arg_382_1.time_ and arg_382_1.time_ <= var_385_31 + arg_385_0 then
				local var_385_33 = "play"
				local var_385_34 = "effect"

				arg_382_1:AudioAction(var_385_33, var_385_34, "se_story_143", "se_story_143_amb_bar", "")
			end

			if arg_382_1.frameCnt_ <= 1 then
				arg_382_1.dialog_:SetActive(false)
			end

			local var_385_35 = 2
			local var_385_36 = 0.35

			if var_385_35 < arg_382_1.time_ and arg_382_1.time_ <= var_385_35 + arg_385_0 then
				arg_382_1.talkMaxDuration = 0

				arg_382_1.dialog_:SetActive(true)

				arg_382_1.dialogCg_.alpha = 0

				local var_385_37 = LeanTween.value(arg_382_1.dialog_, 0, 1, 0.3)

				var_385_37:setOnUpdate(LuaHelper.FloatAction(function(arg_386_0)
					arg_382_1.dialogCg_.alpha = arg_386_0
				end))
				var_385_37:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_382_1.dialog_)
					var_385_37:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_382_1.duration_ = arg_382_1.duration_ + 0.3

				SetActive(arg_382_1.leftNameGo_, true)

				local var_385_38 = arg_382_1:FormatText(StoryNameCfg[181].name)

				arg_382_1.leftNameTxt_.text = var_385_38

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_382_1.leftNameTxt_.transform)

				arg_382_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_382_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_382_1:RecordName(arg_382_1.leftNameTxt_.text)
				SetActive(arg_382_1.iconTrs_.gameObject, false)
				arg_382_1.callingController_:SetSelectedState("normal")

				local var_385_39 = arg_382_1:GetWordFromCfg(424081091)
				local var_385_40 = arg_382_1:FormatText(var_385_39.content)

				arg_382_1.text_.text = var_385_40

				LuaForUtil.ClearLinePrefixSymbol(arg_382_1.text_)

				local var_385_41 = 14
				local var_385_42 = utf8.len(var_385_40)
				local var_385_43 = var_385_41 <= 0 and var_385_36 or var_385_36 * (var_385_42 / var_385_41)

				if var_385_43 > 0 and var_385_36 < var_385_43 then
					arg_382_1.talkMaxDuration = var_385_43
					var_385_35 = var_385_35 + 0.3

					if var_385_43 + var_385_35 > arg_382_1.duration_ then
						arg_382_1.duration_ = var_385_43 + var_385_35
					end
				end

				arg_382_1.text_.text = var_385_40
				arg_382_1.typewritter.percent = 0

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424081", "424081091", "story_v_out_424081.awb") ~= 0 then
					local var_385_44 = manager.audio:GetVoiceLength("story_v_out_424081", "424081091", "story_v_out_424081.awb") / 1000

					if var_385_44 + var_385_35 > arg_382_1.duration_ then
						arg_382_1.duration_ = var_385_44 + var_385_35
					end

					if var_385_39.prefab_name ~= "" and arg_382_1.actors_[var_385_39.prefab_name] ~= nil then
						local var_385_45 = LuaForUtil.PlayVoiceWithCriLipsync(arg_382_1.actors_[var_385_39.prefab_name].transform, "story_v_out_424081", "424081091", "story_v_out_424081.awb")

						arg_382_1:RecordAudio("424081091", var_385_45)
						arg_382_1:RecordAudio("424081091", var_385_45)
					else
						arg_382_1:AudioAction("play", "voice", "story_v_out_424081", "424081091", "story_v_out_424081.awb")
					end

					arg_382_1:RecordHistoryTalkVoice("story_v_out_424081", "424081091", "story_v_out_424081.awb")
				end

				arg_382_1:RecordContent(arg_382_1.text_.text)
			end

			local var_385_46 = var_385_35 + 0.3
			local var_385_47 = math.max(var_385_36, arg_382_1.talkMaxDuration)

			if var_385_46 <= arg_382_1.time_ and arg_382_1.time_ < var_385_46 + var_385_47 then
				arg_382_1.typewritter.percent = (arg_382_1.time_ - var_385_46) / var_385_47

				arg_382_1.typewritter:SetDirty()
			end

			if arg_382_1.time_ >= var_385_46 + var_385_47 and arg_382_1.time_ < var_385_46 + var_385_47 + arg_385_0 then
				arg_382_1.typewritter.percent = 1

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(true)
			end
		end

		arg_382_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "SS2402",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 2,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = true,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(-1.2, 0.5, 3.64),
					endPos = Vector3.New(-1.2, 0, 3.64),
					easeType = LeanTweenType.easeInOutExpo
				}
			}
		}

		arg_382_1:InitPlayNodeList()
	end,
	Play424081092 = function(arg_388_0, arg_388_1)
		arg_388_1.time_ = 0
		arg_388_1.frameCnt_ = 0
		arg_388_1.state_ = "playing"
		arg_388_1.curTalkId_ = 424081092
		arg_388_1.duration_ = 5.3

		local var_388_0 = {
			zh = 4.333,
			ja = 5.3
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
				arg_388_0:Play424081093(arg_388_1)
			end
		end

		function arg_388_1.onSingleLineUpdate_(arg_391_0)
			local var_391_0 = 0
			local var_391_1 = 0.35

			if var_391_0 < arg_388_1.time_ and arg_388_1.time_ <= var_391_0 + arg_391_0 then
				arg_388_1.talkMaxDuration = 0
				arg_388_1.dialogCg_.alpha = 1

				arg_388_1.dialog_:SetActive(true)
				SetActive(arg_388_1.leftNameGo_, true)

				local var_391_2 = arg_388_1:FormatText(StoryNameCfg[1394].name)

				arg_388_1.leftNameTxt_.text = var_391_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_388_1.leftNameTxt_.transform)

				arg_388_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_388_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_388_1:RecordName(arg_388_1.leftNameTxt_.text)
				SetActive(arg_388_1.iconTrs_.gameObject, true)
				arg_388_1.iconController_:SetSelectedState("hero")

				arg_388_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lolib")

				arg_388_1.callingController_:SetSelectedState("normal")

				arg_388_1.keyicon_.color = Color.New(1, 1, 1)
				arg_388_1.icon_.color = Color.New(1, 1, 1)

				local var_391_3 = arg_388_1:GetWordFromCfg(424081092)
				local var_391_4 = arg_388_1:FormatText(var_391_3.content)

				arg_388_1.text_.text = var_391_4

				LuaForUtil.ClearLinePrefixSymbol(arg_388_1.text_)

				local var_391_5 = 14
				local var_391_6 = utf8.len(var_391_4)
				local var_391_7 = var_391_5 <= 0 and var_391_1 or var_391_1 * (var_391_6 / var_391_5)

				if var_391_7 > 0 and var_391_1 < var_391_7 then
					arg_388_1.talkMaxDuration = var_391_7

					if var_391_7 + var_391_0 > arg_388_1.duration_ then
						arg_388_1.duration_ = var_391_7 + var_391_0
					end
				end

				arg_388_1.text_.text = var_391_4
				arg_388_1.typewritter.percent = 0

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424081", "424081092", "story_v_out_424081.awb") ~= 0 then
					local var_391_8 = manager.audio:GetVoiceLength("story_v_out_424081", "424081092", "story_v_out_424081.awb") / 1000

					if var_391_8 + var_391_0 > arg_388_1.duration_ then
						arg_388_1.duration_ = var_391_8 + var_391_0
					end

					if var_391_3.prefab_name ~= "" and arg_388_1.actors_[var_391_3.prefab_name] ~= nil then
						local var_391_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_388_1.actors_[var_391_3.prefab_name].transform, "story_v_out_424081", "424081092", "story_v_out_424081.awb")

						arg_388_1:RecordAudio("424081092", var_391_9)
						arg_388_1:RecordAudio("424081092", var_391_9)
					else
						arg_388_1:AudioAction("play", "voice", "story_v_out_424081", "424081092", "story_v_out_424081.awb")
					end

					arg_388_1:RecordHistoryTalkVoice("story_v_out_424081", "424081092", "story_v_out_424081.awb")
				end

				arg_388_1:RecordContent(arg_388_1.text_.text)
			end

			local var_391_10 = math.max(var_391_1, arg_388_1.talkMaxDuration)

			if var_391_0 <= arg_388_1.time_ and arg_388_1.time_ < var_391_0 + var_391_10 then
				arg_388_1.typewritter.percent = (arg_388_1.time_ - var_391_0) / var_391_10

				arg_388_1.typewritter:SetDirty()
			end

			if arg_388_1.time_ >= var_391_0 + var_391_10 and arg_388_1.time_ < var_391_0 + var_391_10 + arg_391_0 then
				arg_388_1.typewritter.percent = 1

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(true)
			end
		end

		arg_388_1.nodeConfigList_ = {}

		arg_388_1:InitPlayNodeList()
	end,
	Play424081093 = function(arg_392_0, arg_392_1)
		arg_392_1.time_ = 0
		arg_392_1.frameCnt_ = 0
		arg_392_1.state_ = "playing"
		arg_392_1.curTalkId_ = 424081093
		arg_392_1.duration_ = 1

		local var_392_0 = {
			zh = 1,
			ja = 0.999999999999
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
				arg_392_0:Play424081094(arg_392_1)
			end
		end

		function arg_392_1.onSingleLineUpdate_(arg_395_0)
			local var_395_0 = 0
			local var_395_1 = 0.075

			if var_395_0 < arg_392_1.time_ and arg_392_1.time_ <= var_395_0 + arg_395_0 then
				arg_392_1.talkMaxDuration = 0
				arg_392_1.dialogCg_.alpha = 1

				arg_392_1.dialog_:SetActive(true)
				SetActive(arg_392_1.leftNameGo_, true)

				local var_395_2 = arg_392_1:FormatText(StoryNameCfg[181].name)

				arg_392_1.leftNameTxt_.text = var_395_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_392_1.leftNameTxt_.transform)

				arg_392_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_392_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_392_1:RecordName(arg_392_1.leftNameTxt_.text)
				SetActive(arg_392_1.iconTrs_.gameObject, false)
				arg_392_1.callingController_:SetSelectedState("normal")

				local var_395_3 = arg_392_1:GetWordFromCfg(424081093)
				local var_395_4 = arg_392_1:FormatText(var_395_3.content)

				arg_392_1.text_.text = var_395_4

				LuaForUtil.ClearLinePrefixSymbol(arg_392_1.text_)

				local var_395_5 = 3
				local var_395_6 = utf8.len(var_395_4)
				local var_395_7 = var_395_5 <= 0 and var_395_1 or var_395_1 * (var_395_6 / var_395_5)

				if var_395_7 > 0 and var_395_1 < var_395_7 then
					arg_392_1.talkMaxDuration = var_395_7

					if var_395_7 + var_395_0 > arg_392_1.duration_ then
						arg_392_1.duration_ = var_395_7 + var_395_0
					end
				end

				arg_392_1.text_.text = var_395_4
				arg_392_1.typewritter.percent = 0

				arg_392_1.typewritter:SetDirty()
				arg_392_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424081", "424081093", "story_v_out_424081.awb") ~= 0 then
					local var_395_8 = manager.audio:GetVoiceLength("story_v_out_424081", "424081093", "story_v_out_424081.awb") / 1000

					if var_395_8 + var_395_0 > arg_392_1.duration_ then
						arg_392_1.duration_ = var_395_8 + var_395_0
					end

					if var_395_3.prefab_name ~= "" and arg_392_1.actors_[var_395_3.prefab_name] ~= nil then
						local var_395_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_392_1.actors_[var_395_3.prefab_name].transform, "story_v_out_424081", "424081093", "story_v_out_424081.awb")

						arg_392_1:RecordAudio("424081093", var_395_9)
						arg_392_1:RecordAudio("424081093", var_395_9)
					else
						arg_392_1:AudioAction("play", "voice", "story_v_out_424081", "424081093", "story_v_out_424081.awb")
					end

					arg_392_1:RecordHistoryTalkVoice("story_v_out_424081", "424081093", "story_v_out_424081.awb")
				end

				arg_392_1:RecordContent(arg_392_1.text_.text)
			end

			local var_395_10 = math.max(var_395_1, arg_392_1.talkMaxDuration)

			if var_395_0 <= arg_392_1.time_ and arg_392_1.time_ < var_395_0 + var_395_10 then
				arg_392_1.typewritter.percent = (arg_392_1.time_ - var_395_0) / var_395_10

				arg_392_1.typewritter:SetDirty()
			end

			if arg_392_1.time_ >= var_395_0 + var_395_10 and arg_392_1.time_ < var_395_0 + var_395_10 + arg_395_0 then
				arg_392_1.typewritter.percent = 1

				arg_392_1.typewritter:SetDirty()
				arg_392_1:ShowNextGo(true)
			end
		end

		arg_392_1.nodeConfigList_ = {}

		arg_392_1:InitPlayNodeList()
	end,
	Play424081094 = function(arg_396_0, arg_396_1)
		arg_396_1.time_ = 0
		arg_396_1.frameCnt_ = 0
		arg_396_1.state_ = "playing"
		arg_396_1.curTalkId_ = 424081094
		arg_396_1.duration_ = 4.37

		local var_396_0 = {
			zh = 2.5,
			ja = 4.366
		}
		local var_396_1 = manager.audio:GetLocalizationFlag()

		if var_396_0[var_396_1] ~= nil then
			arg_396_1.duration_ = var_396_0[var_396_1]
		end

		SetActive(arg_396_1.tipsGo_, false)

		function arg_396_1.onSingleLineFinish_()
			arg_396_1.onSingleLineUpdate_ = nil
			arg_396_1.onSingleLineFinish_ = nil
			arg_396_1.state_ = "waiting"
		end

		function arg_396_1.playNext_(arg_398_0)
			if arg_398_0 == 1 then
				arg_396_0:Play424081095(arg_396_1)
			end
		end

		function arg_396_1.onSingleLineUpdate_(arg_399_0)
			local var_399_0 = 0
			local var_399_1 = 0.2

			if var_399_0 < arg_396_1.time_ and arg_396_1.time_ <= var_399_0 + arg_399_0 then
				arg_396_1.talkMaxDuration = 0
				arg_396_1.dialogCg_.alpha = 1

				arg_396_1.dialog_:SetActive(true)
				SetActive(arg_396_1.leftNameGo_, true)

				local var_399_2 = arg_396_1:FormatText(StoryNameCfg[1394].name)

				arg_396_1.leftNameTxt_.text = var_399_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_396_1.leftNameTxt_.transform)

				arg_396_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_396_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_396_1:RecordName(arg_396_1.leftNameTxt_.text)
				SetActive(arg_396_1.iconTrs_.gameObject, true)
				arg_396_1.iconController_:SetSelectedState("hero")

				arg_396_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lolib")

				arg_396_1.callingController_:SetSelectedState("normal")

				arg_396_1.keyicon_.color = Color.New(1, 1, 1)
				arg_396_1.icon_.color = Color.New(1, 1, 1)

				local var_399_3 = arg_396_1:GetWordFromCfg(424081094)
				local var_399_4 = arg_396_1:FormatText(var_399_3.content)

				arg_396_1.text_.text = var_399_4

				LuaForUtil.ClearLinePrefixSymbol(arg_396_1.text_)

				local var_399_5 = 8
				local var_399_6 = utf8.len(var_399_4)
				local var_399_7 = var_399_5 <= 0 and var_399_1 or var_399_1 * (var_399_6 / var_399_5)

				if var_399_7 > 0 and var_399_1 < var_399_7 then
					arg_396_1.talkMaxDuration = var_399_7

					if var_399_7 + var_399_0 > arg_396_1.duration_ then
						arg_396_1.duration_ = var_399_7 + var_399_0
					end
				end

				arg_396_1.text_.text = var_399_4
				arg_396_1.typewritter.percent = 0

				arg_396_1.typewritter:SetDirty()
				arg_396_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424081", "424081094", "story_v_out_424081.awb") ~= 0 then
					local var_399_8 = manager.audio:GetVoiceLength("story_v_out_424081", "424081094", "story_v_out_424081.awb") / 1000

					if var_399_8 + var_399_0 > arg_396_1.duration_ then
						arg_396_1.duration_ = var_399_8 + var_399_0
					end

					if var_399_3.prefab_name ~= "" and arg_396_1.actors_[var_399_3.prefab_name] ~= nil then
						local var_399_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_396_1.actors_[var_399_3.prefab_name].transform, "story_v_out_424081", "424081094", "story_v_out_424081.awb")

						arg_396_1:RecordAudio("424081094", var_399_9)
						arg_396_1:RecordAudio("424081094", var_399_9)
					else
						arg_396_1:AudioAction("play", "voice", "story_v_out_424081", "424081094", "story_v_out_424081.awb")
					end

					arg_396_1:RecordHistoryTalkVoice("story_v_out_424081", "424081094", "story_v_out_424081.awb")
				end

				arg_396_1:RecordContent(arg_396_1.text_.text)
			end

			local var_399_10 = math.max(var_399_1, arg_396_1.talkMaxDuration)

			if var_399_0 <= arg_396_1.time_ and arg_396_1.time_ < var_399_0 + var_399_10 then
				arg_396_1.typewritter.percent = (arg_396_1.time_ - var_399_0) / var_399_10

				arg_396_1.typewritter:SetDirty()
			end

			if arg_396_1.time_ >= var_399_0 + var_399_10 and arg_396_1.time_ < var_399_0 + var_399_10 + arg_399_0 then
				arg_396_1.typewritter.percent = 1

				arg_396_1.typewritter:SetDirty()
				arg_396_1:ShowNextGo(true)
			end
		end

		arg_396_1.nodeConfigList_ = {}

		arg_396_1:InitPlayNodeList()
	end,
	Play424081095 = function(arg_400_0, arg_400_1)
		arg_400_1.time_ = 0
		arg_400_1.frameCnt_ = 0
		arg_400_1.state_ = "playing"
		arg_400_1.curTalkId_ = 424081095
		arg_400_1.duration_ = 5

		SetActive(arg_400_1.tipsGo_, false)

		function arg_400_1.onSingleLineFinish_()
			arg_400_1.onSingleLineUpdate_ = nil
			arg_400_1.onSingleLineFinish_ = nil
			arg_400_1.state_ = "waiting"
		end

		function arg_400_1.playNext_(arg_402_0)
			if arg_402_0 == 1 then
				arg_400_0:Play424081096(arg_400_1)
			end
		end

		function arg_400_1.onSingleLineUpdate_(arg_403_0)
			local var_403_0 = 0
			local var_403_1 = 0.375

			if var_403_0 < arg_400_1.time_ and arg_400_1.time_ <= var_403_0 + arg_403_0 then
				arg_400_1.talkMaxDuration = 0
				arg_400_1.dialogCg_.alpha = 1

				arg_400_1.dialog_:SetActive(true)
				SetActive(arg_400_1.leftNameGo_, true)

				local var_403_2 = arg_400_1:FormatText(StoryNameCfg[7].name)

				arg_400_1.leftNameTxt_.text = var_403_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_400_1.leftNameTxt_.transform)

				arg_400_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_400_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_400_1:RecordName(arg_400_1.leftNameTxt_.text)
				SetActive(arg_400_1.iconTrs_.gameObject, true)
				arg_400_1.iconController_:SetSelectedState("hero")

				arg_400_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_400_1.callingController_:SetSelectedState("normal")

				arg_400_1.keyicon_.color = Color.New(1, 1, 1)
				arg_400_1.icon_.color = Color.New(1, 1, 1)

				local var_403_3 = arg_400_1:GetWordFromCfg(424081095)
				local var_403_4 = arg_400_1:FormatText(var_403_3.content)

				arg_400_1.text_.text = var_403_4

				LuaForUtil.ClearLinePrefixSymbol(arg_400_1.text_)

				local var_403_5 = 15
				local var_403_6 = utf8.len(var_403_4)
				local var_403_7 = var_403_5 <= 0 and var_403_1 or var_403_1 * (var_403_6 / var_403_5)

				if var_403_7 > 0 and var_403_1 < var_403_7 then
					arg_400_1.talkMaxDuration = var_403_7

					if var_403_7 + var_403_0 > arg_400_1.duration_ then
						arg_400_1.duration_ = var_403_7 + var_403_0
					end
				end

				arg_400_1.text_.text = var_403_4
				arg_400_1.typewritter.percent = 0

				arg_400_1.typewritter:SetDirty()
				arg_400_1:ShowNextGo(false)
				arg_400_1:RecordContent(arg_400_1.text_.text)
			end

			local var_403_8 = math.max(var_403_1, arg_400_1.talkMaxDuration)

			if var_403_0 <= arg_400_1.time_ and arg_400_1.time_ < var_403_0 + var_403_8 then
				arg_400_1.typewritter.percent = (arg_400_1.time_ - var_403_0) / var_403_8

				arg_400_1.typewritter:SetDirty()
			end

			if arg_400_1.time_ >= var_403_0 + var_403_8 and arg_400_1.time_ < var_403_0 + var_403_8 + arg_403_0 then
				arg_400_1.typewritter.percent = 1

				arg_400_1.typewritter:SetDirty()
				arg_400_1:ShowNextGo(true)
			end
		end

		arg_400_1.nodeConfigList_ = {}

		arg_400_1:InitPlayNodeList()
	end,
	Play424081096 = function(arg_404_0, arg_404_1)
		arg_404_1.time_ = 0
		arg_404_1.frameCnt_ = 0
		arg_404_1.state_ = "playing"
		arg_404_1.curTalkId_ = 424081096
		arg_404_1.duration_ = 12.13

		local var_404_0 = {
			zh = 11.933,
			ja = 12.133
		}
		local var_404_1 = manager.audio:GetLocalizationFlag()

		if var_404_0[var_404_1] ~= nil then
			arg_404_1.duration_ = var_404_0[var_404_1]
		end

		SetActive(arg_404_1.tipsGo_, false)

		function arg_404_1.onSingleLineFinish_()
			arg_404_1.onSingleLineUpdate_ = nil
			arg_404_1.onSingleLineFinish_ = nil
			arg_404_1.state_ = "waiting"
		end

		function arg_404_1.playNext_(arg_406_0)
			if arg_406_0 == 1 then
				arg_404_0:Play424081097(arg_404_1)
			end
		end

		function arg_404_1.onSingleLineUpdate_(arg_407_0)
			local var_407_0 = 0
			local var_407_1 = 1.125

			if var_407_0 < arg_404_1.time_ and arg_404_1.time_ <= var_407_0 + arg_407_0 then
				arg_404_1.talkMaxDuration = 0
				arg_404_1.dialogCg_.alpha = 1

				arg_404_1.dialog_:SetActive(true)
				SetActive(arg_404_1.leftNameGo_, true)

				local var_407_2 = arg_404_1:FormatText(StoryNameCfg[1394].name)

				arg_404_1.leftNameTxt_.text = var_407_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_404_1.leftNameTxt_.transform)

				arg_404_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_404_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_404_1:RecordName(arg_404_1.leftNameTxt_.text)
				SetActive(arg_404_1.iconTrs_.gameObject, true)
				arg_404_1.iconController_:SetSelectedState("hero")

				arg_404_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lolib")

				arg_404_1.callingController_:SetSelectedState("normal")

				arg_404_1.keyicon_.color = Color.New(1, 1, 1)
				arg_404_1.icon_.color = Color.New(1, 1, 1)

				local var_407_3 = arg_404_1:GetWordFromCfg(424081096)
				local var_407_4 = arg_404_1:FormatText(var_407_3.content)

				arg_404_1.text_.text = var_407_4

				LuaForUtil.ClearLinePrefixSymbol(arg_404_1.text_)

				local var_407_5 = 45
				local var_407_6 = utf8.len(var_407_4)
				local var_407_7 = var_407_5 <= 0 and var_407_1 or var_407_1 * (var_407_6 / var_407_5)

				if var_407_7 > 0 and var_407_1 < var_407_7 then
					arg_404_1.talkMaxDuration = var_407_7

					if var_407_7 + var_407_0 > arg_404_1.duration_ then
						arg_404_1.duration_ = var_407_7 + var_407_0
					end
				end

				arg_404_1.text_.text = var_407_4
				arg_404_1.typewritter.percent = 0

				arg_404_1.typewritter:SetDirty()
				arg_404_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424081", "424081096", "story_v_out_424081.awb") ~= 0 then
					local var_407_8 = manager.audio:GetVoiceLength("story_v_out_424081", "424081096", "story_v_out_424081.awb") / 1000

					if var_407_8 + var_407_0 > arg_404_1.duration_ then
						arg_404_1.duration_ = var_407_8 + var_407_0
					end

					if var_407_3.prefab_name ~= "" and arg_404_1.actors_[var_407_3.prefab_name] ~= nil then
						local var_407_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_404_1.actors_[var_407_3.prefab_name].transform, "story_v_out_424081", "424081096", "story_v_out_424081.awb")

						arg_404_1:RecordAudio("424081096", var_407_9)
						arg_404_1:RecordAudio("424081096", var_407_9)
					else
						arg_404_1:AudioAction("play", "voice", "story_v_out_424081", "424081096", "story_v_out_424081.awb")
					end

					arg_404_1:RecordHistoryTalkVoice("story_v_out_424081", "424081096", "story_v_out_424081.awb")
				end

				arg_404_1:RecordContent(arg_404_1.text_.text)
			end

			local var_407_10 = math.max(var_407_1, arg_404_1.talkMaxDuration)

			if var_407_0 <= arg_404_1.time_ and arg_404_1.time_ < var_407_0 + var_407_10 then
				arg_404_1.typewritter.percent = (arg_404_1.time_ - var_407_0) / var_407_10

				arg_404_1.typewritter:SetDirty()
			end

			if arg_404_1.time_ >= var_407_0 + var_407_10 and arg_404_1.time_ < var_407_0 + var_407_10 + arg_407_0 then
				arg_404_1.typewritter.percent = 1

				arg_404_1.typewritter:SetDirty()
				arg_404_1:ShowNextGo(true)
			end
		end

		arg_404_1.nodeConfigList_ = {}

		arg_404_1:InitPlayNodeList()
	end,
	Play424081097 = function(arg_408_0, arg_408_1)
		arg_408_1.time_ = 0
		arg_408_1.frameCnt_ = 0
		arg_408_1.state_ = "playing"
		arg_408_1.curTalkId_ = 424081097
		arg_408_1.duration_ = 3.07

		local var_408_0 = {
			zh = 2.3,
			ja = 3.066
		}
		local var_408_1 = manager.audio:GetLocalizationFlag()

		if var_408_0[var_408_1] ~= nil then
			arg_408_1.duration_ = var_408_0[var_408_1]
		end

		SetActive(arg_408_1.tipsGo_, false)

		function arg_408_1.onSingleLineFinish_()
			arg_408_1.onSingleLineUpdate_ = nil
			arg_408_1.onSingleLineFinish_ = nil
			arg_408_1.state_ = "waiting"
		end

		function arg_408_1.playNext_(arg_410_0)
			if arg_410_0 == 1 then
				arg_408_0:Play424081098(arg_408_1)
			end
		end

		function arg_408_1.onSingleLineUpdate_(arg_411_0)
			local var_411_0 = 0
			local var_411_1 = 0.25

			if var_411_0 < arg_408_1.time_ and arg_408_1.time_ <= var_411_0 + arg_411_0 then
				arg_408_1.talkMaxDuration = 0
				arg_408_1.dialogCg_.alpha = 1

				arg_408_1.dialog_:SetActive(true)
				SetActive(arg_408_1.leftNameGo_, true)

				local var_411_2 = arg_408_1:FormatText(StoryNameCfg[181].name)

				arg_408_1.leftNameTxt_.text = var_411_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_408_1.leftNameTxt_.transform)

				arg_408_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_408_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_408_1:RecordName(arg_408_1.leftNameTxt_.text)
				SetActive(arg_408_1.iconTrs_.gameObject, false)
				arg_408_1.callingController_:SetSelectedState("normal")

				local var_411_3 = arg_408_1:GetWordFromCfg(424081097)
				local var_411_4 = arg_408_1:FormatText(var_411_3.content)

				arg_408_1.text_.text = var_411_4

				LuaForUtil.ClearLinePrefixSymbol(arg_408_1.text_)

				local var_411_5 = 10
				local var_411_6 = utf8.len(var_411_4)
				local var_411_7 = var_411_5 <= 0 and var_411_1 or var_411_1 * (var_411_6 / var_411_5)

				if var_411_7 > 0 and var_411_1 < var_411_7 then
					arg_408_1.talkMaxDuration = var_411_7

					if var_411_7 + var_411_0 > arg_408_1.duration_ then
						arg_408_1.duration_ = var_411_7 + var_411_0
					end
				end

				arg_408_1.text_.text = var_411_4
				arg_408_1.typewritter.percent = 0

				arg_408_1.typewritter:SetDirty()
				arg_408_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424081", "424081097", "story_v_out_424081.awb") ~= 0 then
					local var_411_8 = manager.audio:GetVoiceLength("story_v_out_424081", "424081097", "story_v_out_424081.awb") / 1000

					if var_411_8 + var_411_0 > arg_408_1.duration_ then
						arg_408_1.duration_ = var_411_8 + var_411_0
					end

					if var_411_3.prefab_name ~= "" and arg_408_1.actors_[var_411_3.prefab_name] ~= nil then
						local var_411_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_408_1.actors_[var_411_3.prefab_name].transform, "story_v_out_424081", "424081097", "story_v_out_424081.awb")

						arg_408_1:RecordAudio("424081097", var_411_9)
						arg_408_1:RecordAudio("424081097", var_411_9)
					else
						arg_408_1:AudioAction("play", "voice", "story_v_out_424081", "424081097", "story_v_out_424081.awb")
					end

					arg_408_1:RecordHistoryTalkVoice("story_v_out_424081", "424081097", "story_v_out_424081.awb")
				end

				arg_408_1:RecordContent(arg_408_1.text_.text)
			end

			local var_411_10 = math.max(var_411_1, arg_408_1.talkMaxDuration)

			if var_411_0 <= arg_408_1.time_ and arg_408_1.time_ < var_411_0 + var_411_10 then
				arg_408_1.typewritter.percent = (arg_408_1.time_ - var_411_0) / var_411_10

				arg_408_1.typewritter:SetDirty()
			end

			if arg_408_1.time_ >= var_411_0 + var_411_10 and arg_408_1.time_ < var_411_0 + var_411_10 + arg_411_0 then
				arg_408_1.typewritter.percent = 1

				arg_408_1.typewritter:SetDirty()
				arg_408_1:ShowNextGo(true)
			end
		end

		arg_408_1.nodeConfigList_ = {}

		arg_408_1:InitPlayNodeList()
	end,
	Play424081098 = function(arg_412_0, arg_412_1)
		arg_412_1.time_ = 0
		arg_412_1.frameCnt_ = 0
		arg_412_1.state_ = "playing"
		arg_412_1.curTalkId_ = 424081098
		arg_412_1.duration_ = 3.2

		local var_412_0 = {
			zh = 2.7,
			ja = 3.2
		}
		local var_412_1 = manager.audio:GetLocalizationFlag()

		if var_412_0[var_412_1] ~= nil then
			arg_412_1.duration_ = var_412_0[var_412_1]
		end

		SetActive(arg_412_1.tipsGo_, false)

		function arg_412_1.onSingleLineFinish_()
			arg_412_1.onSingleLineUpdate_ = nil
			arg_412_1.onSingleLineFinish_ = nil
			arg_412_1.state_ = "waiting"
		end

		function arg_412_1.playNext_(arg_414_0)
			if arg_414_0 == 1 then
				arg_412_0:Play424081099(arg_412_1)
			end
		end

		function arg_412_1.onSingleLineUpdate_(arg_415_0)
			local var_415_0 = 0
			local var_415_1 = 0.225

			if var_415_0 < arg_412_1.time_ and arg_412_1.time_ <= var_415_0 + arg_415_0 then
				arg_412_1.talkMaxDuration = 0
				arg_412_1.dialogCg_.alpha = 1

				arg_412_1.dialog_:SetActive(true)
				SetActive(arg_412_1.leftNameGo_, true)

				local var_415_2 = arg_412_1:FormatText(StoryNameCfg[1404].name)

				arg_412_1.leftNameTxt_.text = var_415_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_412_1.leftNameTxt_.transform)

				arg_412_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_412_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_412_1:RecordName(arg_412_1.leftNameTxt_.text)
				SetActive(arg_412_1.iconTrs_.gameObject, true)
				arg_412_1.iconController_:SetSelectedState("hero")

				arg_412_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_littleboya")

				arg_412_1.callingController_:SetSelectedState("normal")

				arg_412_1.keyicon_.color = Color.New(1, 1, 1)
				arg_412_1.icon_.color = Color.New(1, 1, 1)

				local var_415_3 = arg_412_1:GetWordFromCfg(424081098)
				local var_415_4 = arg_412_1:FormatText(var_415_3.content)

				arg_412_1.text_.text = var_415_4

				LuaForUtil.ClearLinePrefixSymbol(arg_412_1.text_)

				local var_415_5 = 9
				local var_415_6 = utf8.len(var_415_4)
				local var_415_7 = var_415_5 <= 0 and var_415_1 or var_415_1 * (var_415_6 / var_415_5)

				if var_415_7 > 0 and var_415_1 < var_415_7 then
					arg_412_1.talkMaxDuration = var_415_7

					if var_415_7 + var_415_0 > arg_412_1.duration_ then
						arg_412_1.duration_ = var_415_7 + var_415_0
					end
				end

				arg_412_1.text_.text = var_415_4
				arg_412_1.typewritter.percent = 0

				arg_412_1.typewritter:SetDirty()
				arg_412_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424081", "424081098", "story_v_out_424081.awb") ~= 0 then
					local var_415_8 = manager.audio:GetVoiceLength("story_v_out_424081", "424081098", "story_v_out_424081.awb") / 1000

					if var_415_8 + var_415_0 > arg_412_1.duration_ then
						arg_412_1.duration_ = var_415_8 + var_415_0
					end

					if var_415_3.prefab_name ~= "" and arg_412_1.actors_[var_415_3.prefab_name] ~= nil then
						local var_415_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_412_1.actors_[var_415_3.prefab_name].transform, "story_v_out_424081", "424081098", "story_v_out_424081.awb")

						arg_412_1:RecordAudio("424081098", var_415_9)
						arg_412_1:RecordAudio("424081098", var_415_9)
					else
						arg_412_1:AudioAction("play", "voice", "story_v_out_424081", "424081098", "story_v_out_424081.awb")
					end

					arg_412_1:RecordHistoryTalkVoice("story_v_out_424081", "424081098", "story_v_out_424081.awb")
				end

				arg_412_1:RecordContent(arg_412_1.text_.text)
			end

			local var_415_10 = math.max(var_415_1, arg_412_1.talkMaxDuration)

			if var_415_0 <= arg_412_1.time_ and arg_412_1.time_ < var_415_0 + var_415_10 then
				arg_412_1.typewritter.percent = (arg_412_1.time_ - var_415_0) / var_415_10

				arg_412_1.typewritter:SetDirty()
			end

			if arg_412_1.time_ >= var_415_0 + var_415_10 and arg_412_1.time_ < var_415_0 + var_415_10 + arg_415_0 then
				arg_412_1.typewritter.percent = 1

				arg_412_1.typewritter:SetDirty()
				arg_412_1:ShowNextGo(true)
			end
		end

		arg_412_1.nodeConfigList_ = {}

		arg_412_1:InitPlayNodeList()
	end,
	Play424081099 = function(arg_416_0, arg_416_1)
		arg_416_1.time_ = 0
		arg_416_1.frameCnt_ = 0
		arg_416_1.state_ = "playing"
		arg_416_1.curTalkId_ = 424081099
		arg_416_1.duration_ = 5

		SetActive(arg_416_1.tipsGo_, false)

		function arg_416_1.onSingleLineFinish_()
			arg_416_1.onSingleLineUpdate_ = nil
			arg_416_1.onSingleLineFinish_ = nil
			arg_416_1.state_ = "waiting"
		end

		function arg_416_1.playNext_(arg_418_0)
			if arg_418_0 == 1 then
				arg_416_0:Play424081100(arg_416_1)
			end
		end

		function arg_416_1.onSingleLineUpdate_(arg_419_0)
			local var_419_0 = 0
			local var_419_1 = 0.375

			if var_419_0 < arg_416_1.time_ and arg_416_1.time_ <= var_419_0 + arg_419_0 then
				arg_416_1.talkMaxDuration = 0
				arg_416_1.dialogCg_.alpha = 1

				arg_416_1.dialog_:SetActive(true)
				SetActive(arg_416_1.leftNameGo_, true)

				local var_419_2 = arg_416_1:FormatText(StoryNameCfg[7].name)

				arg_416_1.leftNameTxt_.text = var_419_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_416_1.leftNameTxt_.transform)

				arg_416_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_416_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_416_1:RecordName(arg_416_1.leftNameTxt_.text)
				SetActive(arg_416_1.iconTrs_.gameObject, true)
				arg_416_1.iconController_:SetSelectedState("hero")

				arg_416_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_416_1.callingController_:SetSelectedState("normal")

				arg_416_1.keyicon_.color = Color.New(1, 1, 1)
				arg_416_1.icon_.color = Color.New(1, 1, 1)

				local var_419_3 = arg_416_1:GetWordFromCfg(424081099)
				local var_419_4 = arg_416_1:FormatText(var_419_3.content)

				arg_416_1.text_.text = var_419_4

				LuaForUtil.ClearLinePrefixSymbol(arg_416_1.text_)

				local var_419_5 = 15
				local var_419_6 = utf8.len(var_419_4)
				local var_419_7 = var_419_5 <= 0 and var_419_1 or var_419_1 * (var_419_6 / var_419_5)

				if var_419_7 > 0 and var_419_1 < var_419_7 then
					arg_416_1.talkMaxDuration = var_419_7

					if var_419_7 + var_419_0 > arg_416_1.duration_ then
						arg_416_1.duration_ = var_419_7 + var_419_0
					end
				end

				arg_416_1.text_.text = var_419_4
				arg_416_1.typewritter.percent = 0

				arg_416_1.typewritter:SetDirty()
				arg_416_1:ShowNextGo(false)
				arg_416_1:RecordContent(arg_416_1.text_.text)
			end

			local var_419_8 = math.max(var_419_1, arg_416_1.talkMaxDuration)

			if var_419_0 <= arg_416_1.time_ and arg_416_1.time_ < var_419_0 + var_419_8 then
				arg_416_1.typewritter.percent = (arg_416_1.time_ - var_419_0) / var_419_8

				arg_416_1.typewritter:SetDirty()
			end

			if arg_416_1.time_ >= var_419_0 + var_419_8 and arg_416_1.time_ < var_419_0 + var_419_8 + arg_419_0 then
				arg_416_1.typewritter.percent = 1

				arg_416_1.typewritter:SetDirty()
				arg_416_1:ShowNextGo(true)
			end
		end

		arg_416_1.nodeConfigList_ = {}

		arg_416_1:InitPlayNodeList()
	end,
	Play424081100 = function(arg_420_0, arg_420_1)
		arg_420_1.time_ = 0
		arg_420_1.frameCnt_ = 0
		arg_420_1.state_ = "playing"
		arg_420_1.curTalkId_ = 424081100
		arg_420_1.duration_ = 5.87

		local var_420_0 = {
			zh = 5.733,
			ja = 5.866
		}
		local var_420_1 = manager.audio:GetLocalizationFlag()

		if var_420_0[var_420_1] ~= nil then
			arg_420_1.duration_ = var_420_0[var_420_1]
		end

		SetActive(arg_420_1.tipsGo_, false)

		function arg_420_1.onSingleLineFinish_()
			arg_420_1.onSingleLineUpdate_ = nil
			arg_420_1.onSingleLineFinish_ = nil
			arg_420_1.state_ = "waiting"
		end

		function arg_420_1.playNext_(arg_422_0)
			if arg_422_0 == 1 then
				arg_420_0:Play424081101(arg_420_1)
			end
		end

		function arg_420_1.onSingleLineUpdate_(arg_423_0)
			local var_423_0 = "SS2402b"

			if arg_420_1.bgs_[var_423_0] == nil then
				local var_423_1 = Object.Instantiate(arg_420_1.paintGo_)

				var_423_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_423_0)
				var_423_1.name = var_423_0
				var_423_1.transform.parent = arg_420_1.stage_.transform
				var_423_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_420_1.bgs_[var_423_0] = var_423_1
			end

			local var_423_2 = 2

			if var_423_2 < arg_420_1.time_ and arg_420_1.time_ <= var_423_2 + arg_423_0 then
				local var_423_3 = manager.ui.mainCamera.transform.localPosition
				local var_423_4 = Vector3.New(0, 0, 10) + Vector3.New(var_423_3.x, var_423_3.y, 0)
				local var_423_5 = arg_420_1.bgs_.SS2402b

				var_423_5.transform.localPosition = var_423_4
				var_423_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_423_6 = var_423_5:GetComponent("SpriteRenderer")

				if var_423_6 and var_423_6.sprite then
					local var_423_7 = (var_423_5.transform.localPosition - var_423_3).z
					local var_423_8 = manager.ui.mainCameraCom_
					local var_423_9 = 2 * var_423_7 * Mathf.Tan(var_423_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_423_10 = var_423_9 * var_423_8.aspect
					local var_423_11 = var_423_6.sprite.bounds.size.x
					local var_423_12 = var_423_6.sprite.bounds.size.y
					local var_423_13 = var_423_10 / var_423_11
					local var_423_14 = var_423_9 / var_423_12
					local var_423_15 = var_423_14 < var_423_13 and var_423_13 or var_423_14

					var_423_5.transform.localScale = Vector3.New(var_423_15, var_423_15, 0)
				end

				for iter_423_0, iter_423_1 in pairs(arg_420_1.bgs_) do
					if iter_423_0 ~= "SS2402b" then
						iter_423_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_423_16 = 4

			if var_423_16 < arg_420_1.time_ and arg_420_1.time_ <= var_423_16 + arg_423_0 then
				arg_420_1.allBtn_.enabled = false
			end

			local var_423_17 = 0.3

			if arg_420_1.time_ >= var_423_16 + var_423_17 and arg_420_1.time_ < var_423_16 + var_423_17 + arg_423_0 then
				arg_420_1.allBtn_.enabled = true
			end

			local var_423_18 = 0

			if var_423_18 < arg_420_1.time_ and arg_420_1.time_ <= var_423_18 + arg_423_0 then
				arg_420_1.mask_.enabled = true
				arg_420_1.mask_.raycastTarget = true

				arg_420_1:SetGaussion(false)
			end

			local var_423_19 = 2

			if var_423_18 <= arg_420_1.time_ and arg_420_1.time_ < var_423_18 + var_423_19 then
				local var_423_20 = (arg_420_1.time_ - var_423_18) / var_423_19
				local var_423_21 = Color.New(0, 0, 0)

				var_423_21.a = Mathf.Lerp(0, 1, var_423_20)
				arg_420_1.mask_.color = var_423_21
			end

			if arg_420_1.time_ >= var_423_18 + var_423_19 and arg_420_1.time_ < var_423_18 + var_423_19 + arg_423_0 then
				local var_423_22 = Color.New(0, 0, 0)

				var_423_22.a = 1
				arg_420_1.mask_.color = var_423_22
			end

			local var_423_23 = 2

			if var_423_23 < arg_420_1.time_ and arg_420_1.time_ <= var_423_23 + arg_423_0 then
				arg_420_1.mask_.enabled = true
				arg_420_1.mask_.raycastTarget = true

				arg_420_1:SetGaussion(false)
			end

			local var_423_24 = 2

			if var_423_23 <= arg_420_1.time_ and arg_420_1.time_ < var_423_23 + var_423_24 then
				local var_423_25 = (arg_420_1.time_ - var_423_23) / var_423_24
				local var_423_26 = Color.New(0, 0, 0)

				var_423_26.a = Mathf.Lerp(1, 0, var_423_25)
				arg_420_1.mask_.color = var_423_26
			end

			if arg_420_1.time_ >= var_423_23 + var_423_24 and arg_420_1.time_ < var_423_23 + var_423_24 + arg_423_0 then
				local var_423_27 = Color.New(0, 0, 0)
				local var_423_28 = 0

				arg_420_1.mask_.enabled = false
				var_423_27.a = var_423_28
				arg_420_1.mask_.color = var_423_27
			end

			local var_423_29 = arg_420_1.bgs_.SS2402b.transform
			local var_423_30 = 2

			if var_423_30 < arg_420_1.time_ and arg_420_1.time_ <= var_423_30 + arg_423_0 then
				arg_420_1.var_.moveOldPosSS2402b = var_423_29.localPosition
			end

			local var_423_31 = 2

			if var_423_30 <= arg_420_1.time_ and arg_420_1.time_ < var_423_30 + var_423_31 then
				local var_423_32 = (arg_420_1.time_ - var_423_30) / var_423_31
				local var_423_33 = Vector3.New(-1.44, -0.5, 2.66)

				var_423_29.localPosition = Vector3.Lerp(arg_420_1.var_.moveOldPosSS2402b, var_423_33, var_423_32)
			end

			if arg_420_1.time_ >= var_423_30 + var_423_31 and arg_420_1.time_ < var_423_30 + var_423_31 + arg_423_0 then
				var_423_29.localPosition = Vector3.New(-1.44, -0.5, 2.66)
			end

			if arg_420_1.frameCnt_ <= 1 then
				arg_420_1.dialog_:SetActive(false)
			end

			local var_423_34 = 4
			local var_423_35 = 0.175

			if var_423_34 < arg_420_1.time_ and arg_420_1.time_ <= var_423_34 + arg_423_0 then
				arg_420_1.talkMaxDuration = 0

				arg_420_1.dialog_:SetActive(true)

				arg_420_1.dialogCg_.alpha = 0

				local var_423_36 = LeanTween.value(arg_420_1.dialog_, 0, 1, 0.3)

				var_423_36:setOnUpdate(LuaHelper.FloatAction(function(arg_424_0)
					arg_420_1.dialogCg_.alpha = arg_424_0
				end))
				var_423_36:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_420_1.dialog_)
					var_423_36:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_420_1.duration_ = arg_420_1.duration_ + 0.3

				SetActive(arg_420_1.leftNameGo_, true)

				local var_423_37 = arg_420_1:FormatText(StoryNameCfg[181].name)

				arg_420_1.leftNameTxt_.text = var_423_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_420_1.leftNameTxt_.transform)

				arg_420_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_420_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_420_1:RecordName(arg_420_1.leftNameTxt_.text)
				SetActive(arg_420_1.iconTrs_.gameObject, false)
				arg_420_1.callingController_:SetSelectedState("normal")

				local var_423_38 = arg_420_1:GetWordFromCfg(424081100)
				local var_423_39 = arg_420_1:FormatText(var_423_38.content)

				arg_420_1.text_.text = var_423_39

				LuaForUtil.ClearLinePrefixSymbol(arg_420_1.text_)

				local var_423_40 = 7
				local var_423_41 = utf8.len(var_423_39)
				local var_423_42 = var_423_40 <= 0 and var_423_35 or var_423_35 * (var_423_41 / var_423_40)

				if var_423_42 > 0 and var_423_35 < var_423_42 then
					arg_420_1.talkMaxDuration = var_423_42
					var_423_34 = var_423_34 + 0.3

					if var_423_42 + var_423_34 > arg_420_1.duration_ then
						arg_420_1.duration_ = var_423_42 + var_423_34
					end
				end

				arg_420_1.text_.text = var_423_39
				arg_420_1.typewritter.percent = 0

				arg_420_1.typewritter:SetDirty()
				arg_420_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424081", "424081100", "story_v_out_424081.awb") ~= 0 then
					local var_423_43 = manager.audio:GetVoiceLength("story_v_out_424081", "424081100", "story_v_out_424081.awb") / 1000

					if var_423_43 + var_423_34 > arg_420_1.duration_ then
						arg_420_1.duration_ = var_423_43 + var_423_34
					end

					if var_423_38.prefab_name ~= "" and arg_420_1.actors_[var_423_38.prefab_name] ~= nil then
						local var_423_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_420_1.actors_[var_423_38.prefab_name].transform, "story_v_out_424081", "424081100", "story_v_out_424081.awb")

						arg_420_1:RecordAudio("424081100", var_423_44)
						arg_420_1:RecordAudio("424081100", var_423_44)
					else
						arg_420_1:AudioAction("play", "voice", "story_v_out_424081", "424081100", "story_v_out_424081.awb")
					end

					arg_420_1:RecordHistoryTalkVoice("story_v_out_424081", "424081100", "story_v_out_424081.awb")
				end

				arg_420_1:RecordContent(arg_420_1.text_.text)
			end

			local var_423_45 = var_423_34 + 0.3
			local var_423_46 = math.max(var_423_35, arg_420_1.talkMaxDuration)

			if var_423_45 <= arg_420_1.time_ and arg_420_1.time_ < var_423_45 + var_423_46 then
				arg_420_1.typewritter.percent = (arg_420_1.time_ - var_423_45) / var_423_46

				arg_420_1.typewritter:SetDirty()
			end

			if arg_420_1.time_ >= var_423_45 + var_423_46 and arg_420_1.time_ < var_423_45 + var_423_46 + arg_423_0 then
				arg_420_1.typewritter.percent = 1

				arg_420_1.typewritter:SetDirty()
				arg_420_1:ShowNextGo(true)
			end
		end

		arg_420_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "SS2402b",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 2,
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = true,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(-1.44, -0.5, 3),
					endPos = Vector3.New(-1.44, -0.5, 2.66),
					easeType = LeanTweenType.linear
				}
			}
		}

		arg_420_1:InitPlayNodeList()
	end,
	Play424081101 = function(arg_426_0, arg_426_1)
		arg_426_1.time_ = 0
		arg_426_1.frameCnt_ = 0
		arg_426_1.state_ = "playing"
		arg_426_1.curTalkId_ = 424081101
		arg_426_1.duration_ = 4.97

		local var_426_0 = {
			zh = 4.966,
			ja = 4.4
		}
		local var_426_1 = manager.audio:GetLocalizationFlag()

		if var_426_0[var_426_1] ~= nil then
			arg_426_1.duration_ = var_426_0[var_426_1]
		end

		SetActive(arg_426_1.tipsGo_, false)

		function arg_426_1.onSingleLineFinish_()
			arg_426_1.onSingleLineUpdate_ = nil
			arg_426_1.onSingleLineFinish_ = nil
			arg_426_1.state_ = "waiting"
		end

		function arg_426_1.playNext_(arg_428_0)
			if arg_428_0 == 1 then
				arg_426_0:Play424081102(arg_426_1)
			end
		end

		function arg_426_1.onSingleLineUpdate_(arg_429_0)
			local var_429_0 = 0

			if var_429_0 < arg_426_1.time_ and arg_426_1.time_ <= var_429_0 + arg_429_0 then
				arg_426_1.allBtn_.enabled = false
			end

			local var_429_1 = 0.5

			if arg_426_1.time_ >= var_429_0 + var_429_1 and arg_426_1.time_ < var_429_0 + var_429_1 + arg_429_0 then
				arg_426_1.allBtn_.enabled = true
			end

			local var_429_2 = 0
			local var_429_3 = 0.425

			if var_429_2 < arg_426_1.time_ and arg_426_1.time_ <= var_429_2 + arg_429_0 then
				arg_426_1.talkMaxDuration = 0
				arg_426_1.dialogCg_.alpha = 1

				arg_426_1.dialog_:SetActive(true)
				SetActive(arg_426_1.leftNameGo_, true)

				local var_429_4 = arg_426_1:FormatText(StoryNameCfg[1406].name)

				arg_426_1.leftNameTxt_.text = var_429_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_426_1.leftNameTxt_.transform)

				arg_426_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_426_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_426_1:RecordName(arg_426_1.leftNameTxt_.text)
				SetActive(arg_426_1.iconTrs_.gameObject, false)
				arg_426_1.callingController_:SetSelectedState("normal")

				local var_429_5 = arg_426_1:GetWordFromCfg(424081101)
				local var_429_6 = arg_426_1:FormatText(var_429_5.content)

				arg_426_1.text_.text = var_429_6

				LuaForUtil.ClearLinePrefixSymbol(arg_426_1.text_)

				local var_429_7 = 17
				local var_429_8 = utf8.len(var_429_6)
				local var_429_9 = var_429_7 <= 0 and var_429_3 or var_429_3 * (var_429_8 / var_429_7)

				if var_429_9 > 0 and var_429_3 < var_429_9 then
					arg_426_1.talkMaxDuration = var_429_9

					if var_429_9 + var_429_2 > arg_426_1.duration_ then
						arg_426_1.duration_ = var_429_9 + var_429_2
					end
				end

				arg_426_1.text_.text = var_429_6
				arg_426_1.typewritter.percent = 0

				arg_426_1.typewritter:SetDirty()
				arg_426_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424081", "424081101", "story_v_out_424081.awb") ~= 0 then
					local var_429_10 = manager.audio:GetVoiceLength("story_v_out_424081", "424081101", "story_v_out_424081.awb") / 1000

					if var_429_10 + var_429_2 > arg_426_1.duration_ then
						arg_426_1.duration_ = var_429_10 + var_429_2
					end

					if var_429_5.prefab_name ~= "" and arg_426_1.actors_[var_429_5.prefab_name] ~= nil then
						local var_429_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_426_1.actors_[var_429_5.prefab_name].transform, "story_v_out_424081", "424081101", "story_v_out_424081.awb")

						arg_426_1:RecordAudio("424081101", var_429_11)
						arg_426_1:RecordAudio("424081101", var_429_11)
					else
						arg_426_1:AudioAction("play", "voice", "story_v_out_424081", "424081101", "story_v_out_424081.awb")
					end

					arg_426_1:RecordHistoryTalkVoice("story_v_out_424081", "424081101", "story_v_out_424081.awb")
				end

				arg_426_1:RecordContent(arg_426_1.text_.text)
			end

			local var_429_12 = math.max(var_429_3, arg_426_1.talkMaxDuration)

			if var_429_2 <= arg_426_1.time_ and arg_426_1.time_ < var_429_2 + var_429_12 then
				arg_426_1.typewritter.percent = (arg_426_1.time_ - var_429_2) / var_429_12

				arg_426_1.typewritter:SetDirty()
			end

			if arg_426_1.time_ >= var_429_2 + var_429_12 and arg_426_1.time_ < var_429_2 + var_429_12 + arg_429_0 then
				arg_426_1.typewritter.percent = 1

				arg_426_1.typewritter:SetDirty()
				arg_426_1:ShowNextGo(true)
			end
		end

		arg_426_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "",
				frequency = 12,
				className = "StoryShakeNode",
				duration = 0.3,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.None,
				shakeTarget = StoryPlayerConst.SHAKE_TARGET.DIALOG,
				offset = Vector3.New(0.1, 0.1, 0.1)
			}
		}

		arg_426_1:InitPlayNodeList()
	end,
	Play424081102 = function(arg_430_0, arg_430_1)
		arg_430_1.time_ = 0
		arg_430_1.frameCnt_ = 0
		arg_430_1.state_ = "playing"
		arg_430_1.curTalkId_ = 424081102
		arg_430_1.duration_ = 5.3

		local var_430_0 = {
			zh = 5.066,
			ja = 5.3
		}
		local var_430_1 = manager.audio:GetLocalizationFlag()

		if var_430_0[var_430_1] ~= nil then
			arg_430_1.duration_ = var_430_0[var_430_1]
		end

		SetActive(arg_430_1.tipsGo_, false)

		function arg_430_1.onSingleLineFinish_()
			arg_430_1.onSingleLineUpdate_ = nil
			arg_430_1.onSingleLineFinish_ = nil
			arg_430_1.state_ = "waiting"
		end

		function arg_430_1.playNext_(arg_432_0)
			if arg_432_0 == 1 then
				arg_430_0:Play424081103(arg_430_1)
			end
		end

		function arg_430_1.onSingleLineUpdate_(arg_433_0)
			local var_433_0 = 0
			local var_433_1 = 0.575

			if var_433_0 < arg_430_1.time_ and arg_430_1.time_ <= var_433_0 + arg_433_0 then
				arg_430_1.talkMaxDuration = 0
				arg_430_1.dialogCg_.alpha = 1

				arg_430_1.dialog_:SetActive(true)
				SetActive(arg_430_1.leftNameGo_, true)

				local var_433_2 = arg_430_1:FormatText(StoryNameCfg[1404].name)

				arg_430_1.leftNameTxt_.text = var_433_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_430_1.leftNameTxt_.transform)

				arg_430_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_430_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_430_1:RecordName(arg_430_1.leftNameTxt_.text)
				SetActive(arg_430_1.iconTrs_.gameObject, true)
				arg_430_1.iconController_:SetSelectedState("hero")

				arg_430_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_littleboya")

				arg_430_1.callingController_:SetSelectedState("normal")

				arg_430_1.keyicon_.color = Color.New(1, 1, 1)
				arg_430_1.icon_.color = Color.New(1, 1, 1)

				local var_433_3 = arg_430_1:GetWordFromCfg(424081102)
				local var_433_4 = arg_430_1:FormatText(var_433_3.content)

				arg_430_1.text_.text = var_433_4

				LuaForUtil.ClearLinePrefixSymbol(arg_430_1.text_)

				local var_433_5 = 23
				local var_433_6 = utf8.len(var_433_4)
				local var_433_7 = var_433_5 <= 0 and var_433_1 or var_433_1 * (var_433_6 / var_433_5)

				if var_433_7 > 0 and var_433_1 < var_433_7 then
					arg_430_1.talkMaxDuration = var_433_7

					if var_433_7 + var_433_0 > arg_430_1.duration_ then
						arg_430_1.duration_ = var_433_7 + var_433_0
					end
				end

				arg_430_1.text_.text = var_433_4
				arg_430_1.typewritter.percent = 0

				arg_430_1.typewritter:SetDirty()
				arg_430_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424081", "424081102", "story_v_out_424081.awb") ~= 0 then
					local var_433_8 = manager.audio:GetVoiceLength("story_v_out_424081", "424081102", "story_v_out_424081.awb") / 1000

					if var_433_8 + var_433_0 > arg_430_1.duration_ then
						arg_430_1.duration_ = var_433_8 + var_433_0
					end

					if var_433_3.prefab_name ~= "" and arg_430_1.actors_[var_433_3.prefab_name] ~= nil then
						local var_433_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_430_1.actors_[var_433_3.prefab_name].transform, "story_v_out_424081", "424081102", "story_v_out_424081.awb")

						arg_430_1:RecordAudio("424081102", var_433_9)
						arg_430_1:RecordAudio("424081102", var_433_9)
					else
						arg_430_1:AudioAction("play", "voice", "story_v_out_424081", "424081102", "story_v_out_424081.awb")
					end

					arg_430_1:RecordHistoryTalkVoice("story_v_out_424081", "424081102", "story_v_out_424081.awb")
				end

				arg_430_1:RecordContent(arg_430_1.text_.text)
			end

			local var_433_10 = math.max(var_433_1, arg_430_1.talkMaxDuration)

			if var_433_0 <= arg_430_1.time_ and arg_430_1.time_ < var_433_0 + var_433_10 then
				arg_430_1.typewritter.percent = (arg_430_1.time_ - var_433_0) / var_433_10

				arg_430_1.typewritter:SetDirty()
			end

			if arg_430_1.time_ >= var_433_0 + var_433_10 and arg_430_1.time_ < var_433_0 + var_433_10 + arg_433_0 then
				arg_430_1.typewritter.percent = 1

				arg_430_1.typewritter:SetDirty()
				arg_430_1:ShowNextGo(true)
			end
		end

		arg_430_1.nodeConfigList_ = {}

		arg_430_1:InitPlayNodeList()
	end,
	Play424081103 = function(arg_434_0, arg_434_1)
		arg_434_1.time_ = 0
		arg_434_1.frameCnt_ = 0
		arg_434_1.state_ = "playing"
		arg_434_1.curTalkId_ = 424081103
		arg_434_1.duration_ = 6.5

		SetActive(arg_434_1.tipsGo_, false)

		function arg_434_1.onSingleLineFinish_()
			arg_434_1.onSingleLineUpdate_ = nil
			arg_434_1.onSingleLineFinish_ = nil
			arg_434_1.state_ = "waiting"
		end

		function arg_434_1.playNext_(arg_436_0)
			if arg_436_0 == 1 then
				arg_434_0:Play424081104(arg_434_1)
			end
		end

		function arg_434_1.onSingleLineUpdate_(arg_437_0)
			local var_437_0 = 1

			if var_437_0 < arg_434_1.time_ and arg_434_1.time_ <= var_437_0 + arg_437_0 then
				local var_437_1 = manager.ui.mainCamera.transform.localPosition
				local var_437_2 = Vector3.New(0, 0, 10) + Vector3.New(var_437_1.x, var_437_1.y, 0)
				local var_437_3 = arg_434_1.bgs_.SS2402b

				var_437_3.transform.localPosition = var_437_2
				var_437_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_437_4 = var_437_3:GetComponent("SpriteRenderer")

				if var_437_4 and var_437_4.sprite then
					local var_437_5 = (var_437_3.transform.localPosition - var_437_1).z
					local var_437_6 = manager.ui.mainCameraCom_
					local var_437_7 = 2 * var_437_5 * Mathf.Tan(var_437_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_437_8 = var_437_7 * var_437_6.aspect
					local var_437_9 = var_437_4.sprite.bounds.size.x
					local var_437_10 = var_437_4.sprite.bounds.size.y
					local var_437_11 = var_437_8 / var_437_9
					local var_437_12 = var_437_7 / var_437_10
					local var_437_13 = var_437_12 < var_437_11 and var_437_11 or var_437_12

					var_437_3.transform.localScale = Vector3.New(var_437_13, var_437_13, 0)
				end

				for iter_437_0, iter_437_1 in pairs(arg_434_1.bgs_) do
					if iter_437_0 ~= "SS2402b" then
						iter_437_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_437_14 = 0

			if var_437_14 < arg_434_1.time_ and arg_434_1.time_ <= var_437_14 + arg_437_0 then
				arg_434_1.mask_.enabled = true
				arg_434_1.mask_.raycastTarget = true

				arg_434_1:SetGaussion(false)
			end

			local var_437_15 = 1

			if var_437_14 <= arg_434_1.time_ and arg_434_1.time_ < var_437_14 + var_437_15 then
				local var_437_16 = (arg_434_1.time_ - var_437_14) / var_437_15
				local var_437_17 = Color.New(0, 0, 0)

				var_437_17.a = Mathf.Lerp(0, 1, var_437_16)
				arg_434_1.mask_.color = var_437_17
			end

			if arg_434_1.time_ >= var_437_14 + var_437_15 and arg_434_1.time_ < var_437_14 + var_437_15 + arg_437_0 then
				local var_437_18 = Color.New(0, 0, 0)

				var_437_18.a = 1
				arg_434_1.mask_.color = var_437_18
			end

			local var_437_19 = 1

			if var_437_19 < arg_434_1.time_ and arg_434_1.time_ <= var_437_19 + arg_437_0 then
				arg_434_1.mask_.enabled = true
				arg_434_1.mask_.raycastTarget = true

				arg_434_1:SetGaussion(false)
			end

			local var_437_20 = 1

			if var_437_19 <= arg_434_1.time_ and arg_434_1.time_ < var_437_19 + var_437_20 then
				local var_437_21 = (arg_434_1.time_ - var_437_19) / var_437_20
				local var_437_22 = Color.New(0, 0, 0)

				var_437_22.a = Mathf.Lerp(1, 0, var_437_21)
				arg_434_1.mask_.color = var_437_22
			end

			if arg_434_1.time_ >= var_437_19 + var_437_20 and arg_434_1.time_ < var_437_19 + var_437_20 + arg_437_0 then
				local var_437_23 = Color.New(0, 0, 0)
				local var_437_24 = 0

				arg_434_1.mask_.enabled = false
				var_437_23.a = var_437_24
				arg_434_1.mask_.color = var_437_23
			end

			if arg_434_1.frameCnt_ <= 1 then
				arg_434_1.dialog_:SetActive(false)
			end

			local var_437_25 = 1.499999999999
			local var_437_26 = 1.5

			if var_437_25 < arg_434_1.time_ and arg_434_1.time_ <= var_437_25 + arg_437_0 then
				arg_434_1.talkMaxDuration = 0

				arg_434_1.dialog_:SetActive(true)

				arg_434_1.dialogCg_.alpha = 0

				local var_437_27 = LeanTween.value(arg_434_1.dialog_, 0, 1, 0.3)

				var_437_27:setOnUpdate(LuaHelper.FloatAction(function(arg_438_0)
					arg_434_1.dialogCg_.alpha = arg_438_0
				end))
				var_437_27:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_434_1.dialog_)
					var_437_27:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_434_1.duration_ = arg_434_1.duration_ + 0.3

				SetActive(arg_434_1.leftNameGo_, false)

				arg_434_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_434_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_434_1:RecordName(arg_434_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_434_1.iconTrs_.gameObject, false)
				arg_434_1.callingController_:SetSelectedState("normal")

				local var_437_28 = arg_434_1:GetWordFromCfg(424081103)
				local var_437_29 = arg_434_1:FormatText(var_437_28.content)

				arg_434_1.text_.text = var_437_29

				LuaForUtil.ClearLinePrefixSymbol(arg_434_1.text_)

				local var_437_30 = 60
				local var_437_31 = utf8.len(var_437_29)
				local var_437_32 = var_437_30 <= 0 and var_437_26 or var_437_26 * (var_437_31 / var_437_30)

				if var_437_32 > 0 and var_437_26 < var_437_32 then
					arg_434_1.talkMaxDuration = var_437_32
					var_437_25 = var_437_25 + 0.3

					if var_437_32 + var_437_25 > arg_434_1.duration_ then
						arg_434_1.duration_ = var_437_32 + var_437_25
					end
				end

				arg_434_1.text_.text = var_437_29
				arg_434_1.typewritter.percent = 0

				arg_434_1.typewritter:SetDirty()
				arg_434_1:ShowNextGo(false)
				arg_434_1:RecordContent(arg_434_1.text_.text)
			end

			local var_437_33 = var_437_25 + 0.3
			local var_437_34 = math.max(var_437_26, arg_434_1.talkMaxDuration)

			if var_437_33 <= arg_434_1.time_ and arg_434_1.time_ < var_437_33 + var_437_34 then
				arg_434_1.typewritter.percent = (arg_434_1.time_ - var_437_33) / var_437_34

				arg_434_1.typewritter:SetDirty()
			end

			if arg_434_1.time_ >= var_437_33 + var_437_34 and arg_434_1.time_ < var_437_33 + var_437_34 + arg_437_0 then
				arg_434_1.typewritter.percent = 1

				arg_434_1.typewritter:SetDirty()
				arg_434_1:ShowNextGo(true)
			end
		end

		arg_434_1.nodeConfigList_ = {}

		arg_434_1:InitPlayNodeList()
	end,
	Play424081104 = function(arg_440_0, arg_440_1)
		arg_440_1.time_ = 0
		arg_440_1.frameCnt_ = 0
		arg_440_1.state_ = "playing"
		arg_440_1.curTalkId_ = 424081104
		arg_440_1.duration_ = 5

		SetActive(arg_440_1.tipsGo_, false)

		function arg_440_1.onSingleLineFinish_()
			arg_440_1.onSingleLineUpdate_ = nil
			arg_440_1.onSingleLineFinish_ = nil
			arg_440_1.state_ = "waiting"
		end

		function arg_440_1.playNext_(arg_442_0)
			if arg_442_0 == 1 then
				arg_440_0:Play424081105(arg_440_1)
			end
		end

		function arg_440_1.onSingleLineUpdate_(arg_443_0)
			local var_443_0 = 0
			local var_443_1 = 0.225

			if var_443_0 < arg_440_1.time_ and arg_440_1.time_ <= var_443_0 + arg_443_0 then
				arg_440_1.talkMaxDuration = 0
				arg_440_1.dialogCg_.alpha = 1

				arg_440_1.dialog_:SetActive(true)
				SetActive(arg_440_1.leftNameGo_, true)

				local var_443_2 = arg_440_1:FormatText(StoryNameCfg[7].name)

				arg_440_1.leftNameTxt_.text = var_443_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_440_1.leftNameTxt_.transform)

				arg_440_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_440_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_440_1:RecordName(arg_440_1.leftNameTxt_.text)
				SetActive(arg_440_1.iconTrs_.gameObject, true)
				arg_440_1.iconController_:SetSelectedState("hero")

				arg_440_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_440_1.callingController_:SetSelectedState("normal")

				arg_440_1.keyicon_.color = Color.New(1, 1, 1)
				arg_440_1.icon_.color = Color.New(1, 1, 1)

				local var_443_3 = arg_440_1:GetWordFromCfg(424081104)
				local var_443_4 = arg_440_1:FormatText(var_443_3.content)

				arg_440_1.text_.text = var_443_4

				LuaForUtil.ClearLinePrefixSymbol(arg_440_1.text_)

				local var_443_5 = 9
				local var_443_6 = utf8.len(var_443_4)
				local var_443_7 = var_443_5 <= 0 and var_443_1 or var_443_1 * (var_443_6 / var_443_5)

				if var_443_7 > 0 and var_443_1 < var_443_7 then
					arg_440_1.talkMaxDuration = var_443_7

					if var_443_7 + var_443_0 > arg_440_1.duration_ then
						arg_440_1.duration_ = var_443_7 + var_443_0
					end
				end

				arg_440_1.text_.text = var_443_4
				arg_440_1.typewritter.percent = 0

				arg_440_1.typewritter:SetDirty()
				arg_440_1:ShowNextGo(false)
				arg_440_1:RecordContent(arg_440_1.text_.text)
			end

			local var_443_8 = math.max(var_443_1, arg_440_1.talkMaxDuration)

			if var_443_0 <= arg_440_1.time_ and arg_440_1.time_ < var_443_0 + var_443_8 then
				arg_440_1.typewritter.percent = (arg_440_1.time_ - var_443_0) / var_443_8

				arg_440_1.typewritter:SetDirty()
			end

			if arg_440_1.time_ >= var_443_0 + var_443_8 and arg_440_1.time_ < var_443_0 + var_443_8 + arg_443_0 then
				arg_440_1.typewritter.percent = 1

				arg_440_1.typewritter:SetDirty()
				arg_440_1:ShowNextGo(true)
			end
		end

		arg_440_1.nodeConfigList_ = {}

		arg_440_1:InitPlayNodeList()
	end,
	Play424081105 = function(arg_444_0, arg_444_1)
		arg_444_1.time_ = 0
		arg_444_1.frameCnt_ = 0
		arg_444_1.state_ = "playing"
		arg_444_1.curTalkId_ = 424081105
		arg_444_1.duration_ = 5.07

		local var_444_0 = {
			zh = 4.2,
			ja = 5.066
		}
		local var_444_1 = manager.audio:GetLocalizationFlag()

		if var_444_0[var_444_1] ~= nil then
			arg_444_1.duration_ = var_444_0[var_444_1]
		end

		SetActive(arg_444_1.tipsGo_, false)

		function arg_444_1.onSingleLineFinish_()
			arg_444_1.onSingleLineUpdate_ = nil
			arg_444_1.onSingleLineFinish_ = nil
			arg_444_1.state_ = "waiting"
		end

		function arg_444_1.playNext_(arg_446_0)
			if arg_446_0 == 1 then
				arg_444_0:Play424081106(arg_444_1)
			end
		end

		function arg_444_1.onSingleLineUpdate_(arg_447_0)
			local var_447_0 = 0
			local var_447_1 = 0.425

			if var_447_0 < arg_444_1.time_ and arg_444_1.time_ <= var_447_0 + arg_447_0 then
				arg_444_1.talkMaxDuration = 0
				arg_444_1.dialogCg_.alpha = 1

				arg_444_1.dialog_:SetActive(true)
				SetActive(arg_444_1.leftNameGo_, true)

				local var_447_2 = arg_444_1:FormatText(StoryNameCfg[181].name)

				arg_444_1.leftNameTxt_.text = var_447_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_444_1.leftNameTxt_.transform)

				arg_444_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_444_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_444_1:RecordName(arg_444_1.leftNameTxt_.text)
				SetActive(arg_444_1.iconTrs_.gameObject, false)
				arg_444_1.callingController_:SetSelectedState("normal")

				local var_447_3 = arg_444_1:GetWordFromCfg(424081105)
				local var_447_4 = arg_444_1:FormatText(var_447_3.content)

				arg_444_1.text_.text = var_447_4

				LuaForUtil.ClearLinePrefixSymbol(arg_444_1.text_)

				local var_447_5 = 17
				local var_447_6 = utf8.len(var_447_4)
				local var_447_7 = var_447_5 <= 0 and var_447_1 or var_447_1 * (var_447_6 / var_447_5)

				if var_447_7 > 0 and var_447_1 < var_447_7 then
					arg_444_1.talkMaxDuration = var_447_7

					if var_447_7 + var_447_0 > arg_444_1.duration_ then
						arg_444_1.duration_ = var_447_7 + var_447_0
					end
				end

				arg_444_1.text_.text = var_447_4
				arg_444_1.typewritter.percent = 0

				arg_444_1.typewritter:SetDirty()
				arg_444_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424081", "424081105", "story_v_out_424081.awb") ~= 0 then
					local var_447_8 = manager.audio:GetVoiceLength("story_v_out_424081", "424081105", "story_v_out_424081.awb") / 1000

					if var_447_8 + var_447_0 > arg_444_1.duration_ then
						arg_444_1.duration_ = var_447_8 + var_447_0
					end

					if var_447_3.prefab_name ~= "" and arg_444_1.actors_[var_447_3.prefab_name] ~= nil then
						local var_447_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_444_1.actors_[var_447_3.prefab_name].transform, "story_v_out_424081", "424081105", "story_v_out_424081.awb")

						arg_444_1:RecordAudio("424081105", var_447_9)
						arg_444_1:RecordAudio("424081105", var_447_9)
					else
						arg_444_1:AudioAction("play", "voice", "story_v_out_424081", "424081105", "story_v_out_424081.awb")
					end

					arg_444_1:RecordHistoryTalkVoice("story_v_out_424081", "424081105", "story_v_out_424081.awb")
				end

				arg_444_1:RecordContent(arg_444_1.text_.text)
			end

			local var_447_10 = math.max(var_447_1, arg_444_1.talkMaxDuration)

			if var_447_0 <= arg_444_1.time_ and arg_444_1.time_ < var_447_0 + var_447_10 then
				arg_444_1.typewritter.percent = (arg_444_1.time_ - var_447_0) / var_447_10

				arg_444_1.typewritter:SetDirty()
			end

			if arg_444_1.time_ >= var_447_0 + var_447_10 and arg_444_1.time_ < var_447_0 + var_447_10 + arg_447_0 then
				arg_444_1.typewritter.percent = 1

				arg_444_1.typewritter:SetDirty()
				arg_444_1:ShowNextGo(true)
			end
		end

		arg_444_1.nodeConfigList_ = {}

		arg_444_1:InitPlayNodeList()
	end,
	Play424081106 = function(arg_448_0, arg_448_1)
		arg_448_1.time_ = 0
		arg_448_1.frameCnt_ = 0
		arg_448_1.state_ = "playing"
		arg_448_1.curTalkId_ = 424081106
		arg_448_1.duration_ = 5

		SetActive(arg_448_1.tipsGo_, false)

		function arg_448_1.onSingleLineFinish_()
			arg_448_1.onSingleLineUpdate_ = nil
			arg_448_1.onSingleLineFinish_ = nil
			arg_448_1.state_ = "waiting"
		end

		function arg_448_1.playNext_(arg_450_0)
			if arg_450_0 == 1 then
				arg_448_0:Play424081107(arg_448_1)
			end
		end

		function arg_448_1.onSingleLineUpdate_(arg_451_0)
			local var_451_0 = 0
			local var_451_1 = 0.1

			if var_451_0 < arg_448_1.time_ and arg_448_1.time_ <= var_451_0 + arg_451_0 then
				arg_448_1.talkMaxDuration = 0
				arg_448_1.dialogCg_.alpha = 1

				arg_448_1.dialog_:SetActive(true)
				SetActive(arg_448_1.leftNameGo_, true)

				local var_451_2 = arg_448_1:FormatText(StoryNameCfg[7].name)

				arg_448_1.leftNameTxt_.text = var_451_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_448_1.leftNameTxt_.transform)

				arg_448_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_448_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_448_1:RecordName(arg_448_1.leftNameTxt_.text)
				SetActive(arg_448_1.iconTrs_.gameObject, true)
				arg_448_1.iconController_:SetSelectedState("hero")

				arg_448_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_448_1.callingController_:SetSelectedState("normal")

				arg_448_1.keyicon_.color = Color.New(1, 1, 1)
				arg_448_1.icon_.color = Color.New(1, 1, 1)

				local var_451_3 = arg_448_1:GetWordFromCfg(424081106)
				local var_451_4 = arg_448_1:FormatText(var_451_3.content)

				arg_448_1.text_.text = var_451_4

				LuaForUtil.ClearLinePrefixSymbol(arg_448_1.text_)

				local var_451_5 = 4
				local var_451_6 = utf8.len(var_451_4)
				local var_451_7 = var_451_5 <= 0 and var_451_1 or var_451_1 * (var_451_6 / var_451_5)

				if var_451_7 > 0 and var_451_1 < var_451_7 then
					arg_448_1.talkMaxDuration = var_451_7

					if var_451_7 + var_451_0 > arg_448_1.duration_ then
						arg_448_1.duration_ = var_451_7 + var_451_0
					end
				end

				arg_448_1.text_.text = var_451_4
				arg_448_1.typewritter.percent = 0

				arg_448_1.typewritter:SetDirty()
				arg_448_1:ShowNextGo(false)
				arg_448_1:RecordContent(arg_448_1.text_.text)
			end

			local var_451_8 = math.max(var_451_1, arg_448_1.talkMaxDuration)

			if var_451_0 <= arg_448_1.time_ and arg_448_1.time_ < var_451_0 + var_451_8 then
				arg_448_1.typewritter.percent = (arg_448_1.time_ - var_451_0) / var_451_8

				arg_448_1.typewritter:SetDirty()
			end

			if arg_448_1.time_ >= var_451_0 + var_451_8 and arg_448_1.time_ < var_451_0 + var_451_8 + arg_451_0 then
				arg_448_1.typewritter.percent = 1

				arg_448_1.typewritter:SetDirty()
				arg_448_1:ShowNextGo(true)
			end
		end

		arg_448_1.nodeConfigList_ = {}

		arg_448_1:InitPlayNodeList()
	end,
	Play424081107 = function(arg_452_0, arg_452_1)
		arg_452_1.time_ = 0
		arg_452_1.frameCnt_ = 0
		arg_452_1.state_ = "playing"
		arg_452_1.curTalkId_ = 424081107
		arg_452_1.duration_ = 5

		SetActive(arg_452_1.tipsGo_, false)

		function arg_452_1.onSingleLineFinish_()
			arg_452_1.onSingleLineUpdate_ = nil
			arg_452_1.onSingleLineFinish_ = nil
			arg_452_1.state_ = "waiting"
		end

		function arg_452_1.playNext_(arg_454_0)
			if arg_454_0 == 1 then
				arg_452_0:Play424081108(arg_452_1)
			end
		end

		function arg_452_1.onSingleLineUpdate_(arg_455_0)
			local var_455_0 = 0.333333333333333
			local var_455_1 = 1

			if var_455_0 < arg_452_1.time_ and arg_452_1.time_ <= var_455_0 + arg_455_0 then
				local var_455_2 = "play"
				local var_455_3 = "effect"

				arg_452_1:AudioAction(var_455_2, var_455_3, "se_story_140", "se_story_140_foley_clap", "")
			end

			local var_455_4 = 0
			local var_455_5 = 0.8

			if var_455_4 < arg_452_1.time_ and arg_452_1.time_ <= var_455_4 + arg_455_0 then
				arg_452_1.talkMaxDuration = 0
				arg_452_1.dialogCg_.alpha = 1

				arg_452_1.dialog_:SetActive(true)
				SetActive(arg_452_1.leftNameGo_, false)

				arg_452_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_452_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_452_1:RecordName(arg_452_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_452_1.iconTrs_.gameObject, false)
				arg_452_1.callingController_:SetSelectedState("normal")

				local var_455_6 = arg_452_1:GetWordFromCfg(424081107)
				local var_455_7 = arg_452_1:FormatText(var_455_6.content)

				arg_452_1.text_.text = var_455_7

				LuaForUtil.ClearLinePrefixSymbol(arg_452_1.text_)

				local var_455_8 = 32
				local var_455_9 = utf8.len(var_455_7)
				local var_455_10 = var_455_8 <= 0 and var_455_5 or var_455_5 * (var_455_9 / var_455_8)

				if var_455_10 > 0 and var_455_5 < var_455_10 then
					arg_452_1.talkMaxDuration = var_455_10

					if var_455_10 + var_455_4 > arg_452_1.duration_ then
						arg_452_1.duration_ = var_455_10 + var_455_4
					end
				end

				arg_452_1.text_.text = var_455_7
				arg_452_1.typewritter.percent = 0

				arg_452_1.typewritter:SetDirty()
				arg_452_1:ShowNextGo(false)
				arg_452_1:RecordContent(arg_452_1.text_.text)
			end

			local var_455_11 = math.max(var_455_5, arg_452_1.talkMaxDuration)

			if var_455_4 <= arg_452_1.time_ and arg_452_1.time_ < var_455_4 + var_455_11 then
				arg_452_1.typewritter.percent = (arg_452_1.time_ - var_455_4) / var_455_11

				arg_452_1.typewritter:SetDirty()
			end

			if arg_452_1.time_ >= var_455_4 + var_455_11 and arg_452_1.time_ < var_455_4 + var_455_11 + arg_455_0 then
				arg_452_1.typewritter.percent = 1

				arg_452_1.typewritter:SetDirty()
				arg_452_1:ShowNextGo(true)
			end
		end

		arg_452_1.nodeConfigList_ = {}

		arg_452_1:InitPlayNodeList()
	end,
	Play424081108 = function(arg_456_0, arg_456_1)
		arg_456_1.time_ = 0
		arg_456_1.frameCnt_ = 0
		arg_456_1.state_ = "playing"
		arg_456_1.curTalkId_ = 424081108
		arg_456_1.duration_ = 5

		SetActive(arg_456_1.tipsGo_, false)

		function arg_456_1.onSingleLineFinish_()
			arg_456_1.onSingleLineUpdate_ = nil
			arg_456_1.onSingleLineFinish_ = nil
			arg_456_1.state_ = "waiting"
		end

		function arg_456_1.playNext_(arg_458_0)
			if arg_458_0 == 1 then
				arg_456_0:Play424081109(arg_456_1)
			end
		end

		function arg_456_1.onSingleLineUpdate_(arg_459_0)
			local var_459_0 = 0
			local var_459_1 = 0.375

			if var_459_0 < arg_456_1.time_ and arg_456_1.time_ <= var_459_0 + arg_459_0 then
				arg_456_1.talkMaxDuration = 0
				arg_456_1.dialogCg_.alpha = 1

				arg_456_1.dialog_:SetActive(true)
				SetActive(arg_456_1.leftNameGo_, true)

				local var_459_2 = arg_456_1:FormatText(StoryNameCfg[7].name)

				arg_456_1.leftNameTxt_.text = var_459_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_456_1.leftNameTxt_.transform)

				arg_456_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_456_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_456_1:RecordName(arg_456_1.leftNameTxt_.text)
				SetActive(arg_456_1.iconTrs_.gameObject, true)
				arg_456_1.iconController_:SetSelectedState("hero")

				arg_456_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_456_1.callingController_:SetSelectedState("normal")

				arg_456_1.keyicon_.color = Color.New(1, 1, 1)
				arg_456_1.icon_.color = Color.New(1, 1, 1)

				local var_459_3 = arg_456_1:GetWordFromCfg(424081108)
				local var_459_4 = arg_456_1:FormatText(var_459_3.content)

				arg_456_1.text_.text = var_459_4

				LuaForUtil.ClearLinePrefixSymbol(arg_456_1.text_)

				local var_459_5 = 15
				local var_459_6 = utf8.len(var_459_4)
				local var_459_7 = var_459_5 <= 0 and var_459_1 or var_459_1 * (var_459_6 / var_459_5)

				if var_459_7 > 0 and var_459_1 < var_459_7 then
					arg_456_1.talkMaxDuration = var_459_7

					if var_459_7 + var_459_0 > arg_456_1.duration_ then
						arg_456_1.duration_ = var_459_7 + var_459_0
					end
				end

				arg_456_1.text_.text = var_459_4
				arg_456_1.typewritter.percent = 0

				arg_456_1.typewritter:SetDirty()
				arg_456_1:ShowNextGo(false)
				arg_456_1:RecordContent(arg_456_1.text_.text)
			end

			local var_459_8 = math.max(var_459_1, arg_456_1.talkMaxDuration)

			if var_459_0 <= arg_456_1.time_ and arg_456_1.time_ < var_459_0 + var_459_8 then
				arg_456_1.typewritter.percent = (arg_456_1.time_ - var_459_0) / var_459_8

				arg_456_1.typewritter:SetDirty()
			end

			if arg_456_1.time_ >= var_459_0 + var_459_8 and arg_456_1.time_ < var_459_0 + var_459_8 + arg_459_0 then
				arg_456_1.typewritter.percent = 1

				arg_456_1.typewritter:SetDirty()
				arg_456_1:ShowNextGo(true)
			end
		end

		arg_456_1.nodeConfigList_ = {}

		arg_456_1:InitPlayNodeList()
	end,
	Play424081109 = function(arg_460_0, arg_460_1)
		arg_460_1.time_ = 0
		arg_460_1.frameCnt_ = 0
		arg_460_1.state_ = "playing"
		arg_460_1.curTalkId_ = 424081109
		arg_460_1.duration_ = 6.1

		local var_460_0 = {
			zh = 6.1,
			ja = 4.733
		}
		local var_460_1 = manager.audio:GetLocalizationFlag()

		if var_460_0[var_460_1] ~= nil then
			arg_460_1.duration_ = var_460_0[var_460_1]
		end

		SetActive(arg_460_1.tipsGo_, false)

		function arg_460_1.onSingleLineFinish_()
			arg_460_1.onSingleLineUpdate_ = nil
			arg_460_1.onSingleLineFinish_ = nil
			arg_460_1.state_ = "waiting"
		end

		function arg_460_1.playNext_(arg_462_0)
			if arg_462_0 == 1 then
				arg_460_0:Play424081110(arg_460_1)
			end
		end

		function arg_460_1.onSingleLineUpdate_(arg_463_0)
			local var_463_0 = 0
			local var_463_1 = 0.6

			if var_463_0 < arg_460_1.time_ and arg_460_1.time_ <= var_463_0 + arg_463_0 then
				arg_460_1.talkMaxDuration = 0
				arg_460_1.dialogCg_.alpha = 1

				arg_460_1.dialog_:SetActive(true)
				SetActive(arg_460_1.leftNameGo_, true)

				local var_463_2 = arg_460_1:FormatText(StoryNameCfg[1394].name)

				arg_460_1.leftNameTxt_.text = var_463_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_460_1.leftNameTxt_.transform)

				arg_460_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_460_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_460_1:RecordName(arg_460_1.leftNameTxt_.text)
				SetActive(arg_460_1.iconTrs_.gameObject, true)
				arg_460_1.iconController_:SetSelectedState("hero")

				arg_460_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lolib")

				arg_460_1.callingController_:SetSelectedState("normal")

				arg_460_1.keyicon_.color = Color.New(1, 1, 1)
				arg_460_1.icon_.color = Color.New(1, 1, 1)

				local var_463_3 = arg_460_1:GetWordFromCfg(424081109)
				local var_463_4 = arg_460_1:FormatText(var_463_3.content)

				arg_460_1.text_.text = var_463_4

				LuaForUtil.ClearLinePrefixSymbol(arg_460_1.text_)

				local var_463_5 = 24
				local var_463_6 = utf8.len(var_463_4)
				local var_463_7 = var_463_5 <= 0 and var_463_1 or var_463_1 * (var_463_6 / var_463_5)

				if var_463_7 > 0 and var_463_1 < var_463_7 then
					arg_460_1.talkMaxDuration = var_463_7

					if var_463_7 + var_463_0 > arg_460_1.duration_ then
						arg_460_1.duration_ = var_463_7 + var_463_0
					end
				end

				arg_460_1.text_.text = var_463_4
				arg_460_1.typewritter.percent = 0

				arg_460_1.typewritter:SetDirty()
				arg_460_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424081", "424081109", "story_v_out_424081.awb") ~= 0 then
					local var_463_8 = manager.audio:GetVoiceLength("story_v_out_424081", "424081109", "story_v_out_424081.awb") / 1000

					if var_463_8 + var_463_0 > arg_460_1.duration_ then
						arg_460_1.duration_ = var_463_8 + var_463_0
					end

					if var_463_3.prefab_name ~= "" and arg_460_1.actors_[var_463_3.prefab_name] ~= nil then
						local var_463_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_460_1.actors_[var_463_3.prefab_name].transform, "story_v_out_424081", "424081109", "story_v_out_424081.awb")

						arg_460_1:RecordAudio("424081109", var_463_9)
						arg_460_1:RecordAudio("424081109", var_463_9)
					else
						arg_460_1:AudioAction("play", "voice", "story_v_out_424081", "424081109", "story_v_out_424081.awb")
					end

					arg_460_1:RecordHistoryTalkVoice("story_v_out_424081", "424081109", "story_v_out_424081.awb")
				end

				arg_460_1:RecordContent(arg_460_1.text_.text)
			end

			local var_463_10 = math.max(var_463_1, arg_460_1.talkMaxDuration)

			if var_463_0 <= arg_460_1.time_ and arg_460_1.time_ < var_463_0 + var_463_10 then
				arg_460_1.typewritter.percent = (arg_460_1.time_ - var_463_0) / var_463_10

				arg_460_1.typewritter:SetDirty()
			end

			if arg_460_1.time_ >= var_463_0 + var_463_10 and arg_460_1.time_ < var_463_0 + var_463_10 + arg_463_0 then
				arg_460_1.typewritter.percent = 1

				arg_460_1.typewritter:SetDirty()
				arg_460_1:ShowNextGo(true)
			end
		end

		arg_460_1.nodeConfigList_ = {}

		arg_460_1:InitPlayNodeList()
	end,
	Play424081110 = function(arg_464_0, arg_464_1)
		arg_464_1.time_ = 0
		arg_464_1.frameCnt_ = 0
		arg_464_1.state_ = "playing"
		arg_464_1.curTalkId_ = 424081110
		arg_464_1.duration_ = 2.63

		local var_464_0 = {
			zh = 2.533,
			ja = 2.633
		}
		local var_464_1 = manager.audio:GetLocalizationFlag()

		if var_464_0[var_464_1] ~= nil then
			arg_464_1.duration_ = var_464_0[var_464_1]
		end

		SetActive(arg_464_1.tipsGo_, false)

		function arg_464_1.onSingleLineFinish_()
			arg_464_1.onSingleLineUpdate_ = nil
			arg_464_1.onSingleLineFinish_ = nil
			arg_464_1.state_ = "waiting"
		end

		function arg_464_1.playNext_(arg_466_0)
			if arg_466_0 == 1 then
				arg_464_0:Play424081111(arg_464_1)
			end
		end

		function arg_464_1.onSingleLineUpdate_(arg_467_0)
			local var_467_0 = 0
			local var_467_1 = 0.125

			if var_467_0 < arg_464_1.time_ and arg_464_1.time_ <= var_467_0 + arg_467_0 then
				arg_464_1.talkMaxDuration = 0
				arg_464_1.dialogCg_.alpha = 1

				arg_464_1.dialog_:SetActive(true)
				SetActive(arg_464_1.leftNameGo_, true)

				local var_467_2 = arg_464_1:FormatText(StoryNameCfg[1407].name)

				arg_464_1.leftNameTxt_.text = var_467_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_464_1.leftNameTxt_.transform)

				arg_464_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_464_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_464_1:RecordName(arg_464_1.leftNameTxt_.text)
				SetActive(arg_464_1.iconTrs_.gameObject, true)
				arg_464_1.iconController_:SetSelectedState("hero")

				arg_464_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowstudentwa")

				arg_464_1.callingController_:SetSelectedState("normal")

				arg_464_1.keyicon_.color = Color.New(1, 1, 1)
				arg_464_1.icon_.color = Color.New(1, 1, 1)

				local var_467_3 = arg_464_1:GetWordFromCfg(424081110)
				local var_467_4 = arg_464_1:FormatText(var_467_3.content)

				arg_464_1.text_.text = var_467_4

				LuaForUtil.ClearLinePrefixSymbol(arg_464_1.text_)

				local var_467_5 = 5
				local var_467_6 = utf8.len(var_467_4)
				local var_467_7 = var_467_5 <= 0 and var_467_1 or var_467_1 * (var_467_6 / var_467_5)

				if var_467_7 > 0 and var_467_1 < var_467_7 then
					arg_464_1.talkMaxDuration = var_467_7

					if var_467_7 + var_467_0 > arg_464_1.duration_ then
						arg_464_1.duration_ = var_467_7 + var_467_0
					end
				end

				arg_464_1.text_.text = var_467_4
				arg_464_1.typewritter.percent = 0

				arg_464_1.typewritter:SetDirty()
				arg_464_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424081", "424081110", "story_v_out_424081.awb") ~= 0 then
					local var_467_8 = manager.audio:GetVoiceLength("story_v_out_424081", "424081110", "story_v_out_424081.awb") / 1000

					if var_467_8 + var_467_0 > arg_464_1.duration_ then
						arg_464_1.duration_ = var_467_8 + var_467_0
					end

					if var_467_3.prefab_name ~= "" and arg_464_1.actors_[var_467_3.prefab_name] ~= nil then
						local var_467_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_464_1.actors_[var_467_3.prefab_name].transform, "story_v_out_424081", "424081110", "story_v_out_424081.awb")

						arg_464_1:RecordAudio("424081110", var_467_9)
						arg_464_1:RecordAudio("424081110", var_467_9)
					else
						arg_464_1:AudioAction("play", "voice", "story_v_out_424081", "424081110", "story_v_out_424081.awb")
					end

					arg_464_1:RecordHistoryTalkVoice("story_v_out_424081", "424081110", "story_v_out_424081.awb")
				end

				arg_464_1:RecordContent(arg_464_1.text_.text)
			end

			local var_467_10 = math.max(var_467_1, arg_464_1.talkMaxDuration)

			if var_467_0 <= arg_464_1.time_ and arg_464_1.time_ < var_467_0 + var_467_10 then
				arg_464_1.typewritter.percent = (arg_464_1.time_ - var_467_0) / var_467_10

				arg_464_1.typewritter:SetDirty()
			end

			if arg_464_1.time_ >= var_467_0 + var_467_10 and arg_464_1.time_ < var_467_0 + var_467_10 + arg_467_0 then
				arg_464_1.typewritter.percent = 1

				arg_464_1.typewritter:SetDirty()
				arg_464_1:ShowNextGo(true)
			end
		end

		arg_464_1.nodeConfigList_ = {}

		arg_464_1:InitPlayNodeList()
	end,
	Play424081111 = function(arg_468_0, arg_468_1)
		arg_468_1.time_ = 0
		arg_468_1.frameCnt_ = 0
		arg_468_1.state_ = "playing"
		arg_468_1.curTalkId_ = 424081111
		arg_468_1.duration_ = 10.1

		local var_468_0 = {
			zh = 5,
			ja = 10.1
		}
		local var_468_1 = manager.audio:GetLocalizationFlag()

		if var_468_0[var_468_1] ~= nil then
			arg_468_1.duration_ = var_468_0[var_468_1]
		end

		SetActive(arg_468_1.tipsGo_, false)

		function arg_468_1.onSingleLineFinish_()
			arg_468_1.onSingleLineUpdate_ = nil
			arg_468_1.onSingleLineFinish_ = nil
			arg_468_1.state_ = "waiting"
		end

		function arg_468_1.playNext_(arg_470_0)
			if arg_470_0 == 1 then
				arg_468_0:Play424081112(arg_468_1)
			end
		end

		function arg_468_1.onSingleLineUpdate_(arg_471_0)
			local var_471_0 = 0
			local var_471_1 = 0.525

			if var_471_0 < arg_468_1.time_ and arg_468_1.time_ <= var_471_0 + arg_471_0 then
				arg_468_1.talkMaxDuration = 0
				arg_468_1.dialogCg_.alpha = 1

				arg_468_1.dialog_:SetActive(true)
				SetActive(arg_468_1.leftNameGo_, true)

				local var_471_2 = arg_468_1:FormatText(StoryNameCfg[181].name)

				arg_468_1.leftNameTxt_.text = var_471_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_468_1.leftNameTxt_.transform)

				arg_468_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_468_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_468_1:RecordName(arg_468_1.leftNameTxt_.text)
				SetActive(arg_468_1.iconTrs_.gameObject, false)
				arg_468_1.callingController_:SetSelectedState("normal")

				local var_471_3 = arg_468_1:GetWordFromCfg(424081111)
				local var_471_4 = arg_468_1:FormatText(var_471_3.content)

				arg_468_1.text_.text = var_471_4

				LuaForUtil.ClearLinePrefixSymbol(arg_468_1.text_)

				local var_471_5 = 21
				local var_471_6 = utf8.len(var_471_4)
				local var_471_7 = var_471_5 <= 0 and var_471_1 or var_471_1 * (var_471_6 / var_471_5)

				if var_471_7 > 0 and var_471_1 < var_471_7 then
					arg_468_1.talkMaxDuration = var_471_7

					if var_471_7 + var_471_0 > arg_468_1.duration_ then
						arg_468_1.duration_ = var_471_7 + var_471_0
					end
				end

				arg_468_1.text_.text = var_471_4
				arg_468_1.typewritter.percent = 0

				arg_468_1.typewritter:SetDirty()
				arg_468_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424081", "424081111", "story_v_out_424081.awb") ~= 0 then
					local var_471_8 = manager.audio:GetVoiceLength("story_v_out_424081", "424081111", "story_v_out_424081.awb") / 1000

					if var_471_8 + var_471_0 > arg_468_1.duration_ then
						arg_468_1.duration_ = var_471_8 + var_471_0
					end

					if var_471_3.prefab_name ~= "" and arg_468_1.actors_[var_471_3.prefab_name] ~= nil then
						local var_471_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_468_1.actors_[var_471_3.prefab_name].transform, "story_v_out_424081", "424081111", "story_v_out_424081.awb")

						arg_468_1:RecordAudio("424081111", var_471_9)
						arg_468_1:RecordAudio("424081111", var_471_9)
					else
						arg_468_1:AudioAction("play", "voice", "story_v_out_424081", "424081111", "story_v_out_424081.awb")
					end

					arg_468_1:RecordHistoryTalkVoice("story_v_out_424081", "424081111", "story_v_out_424081.awb")
				end

				arg_468_1:RecordContent(arg_468_1.text_.text)
			end

			local var_471_10 = math.max(var_471_1, arg_468_1.talkMaxDuration)

			if var_471_0 <= arg_468_1.time_ and arg_468_1.time_ < var_471_0 + var_471_10 then
				arg_468_1.typewritter.percent = (arg_468_1.time_ - var_471_0) / var_471_10

				arg_468_1.typewritter:SetDirty()
			end

			if arg_468_1.time_ >= var_471_0 + var_471_10 and arg_468_1.time_ < var_471_0 + var_471_10 + arg_471_0 then
				arg_468_1.typewritter.percent = 1

				arg_468_1.typewritter:SetDirty()
				arg_468_1:ShowNextGo(true)
			end
		end

		arg_468_1.nodeConfigList_ = {}

		arg_468_1:InitPlayNodeList()
	end,
	Play424081112 = function(arg_472_0, arg_472_1)
		arg_472_1.time_ = 0
		arg_472_1.frameCnt_ = 0
		arg_472_1.state_ = "playing"
		arg_472_1.curTalkId_ = 424081112
		arg_472_1.duration_ = 13.77

		local var_472_0 = {
			zh = 9.8,
			ja = 13.766
		}
		local var_472_1 = manager.audio:GetLocalizationFlag()

		if var_472_0[var_472_1] ~= nil then
			arg_472_1.duration_ = var_472_0[var_472_1]
		end

		SetActive(arg_472_1.tipsGo_, false)

		function arg_472_1.onSingleLineFinish_()
			arg_472_1.onSingleLineUpdate_ = nil
			arg_472_1.onSingleLineFinish_ = nil
			arg_472_1.state_ = "waiting"
		end

		function arg_472_1.playNext_(arg_474_0)
			if arg_474_0 == 1 then
				arg_472_0:Play424081113(arg_472_1)
			end
		end

		function arg_472_1.onSingleLineUpdate_(arg_475_0)
			local var_475_0 = 0
			local var_475_1 = 0.9

			if var_475_0 < arg_472_1.time_ and arg_472_1.time_ <= var_475_0 + arg_475_0 then
				arg_472_1.talkMaxDuration = 0
				arg_472_1.dialogCg_.alpha = 1

				arg_472_1.dialog_:SetActive(true)
				SetActive(arg_472_1.leftNameGo_, true)

				local var_475_2 = arg_472_1:FormatText(StoryNameCfg[181].name)

				arg_472_1.leftNameTxt_.text = var_475_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_472_1.leftNameTxt_.transform)

				arg_472_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_472_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_472_1:RecordName(arg_472_1.leftNameTxt_.text)
				SetActive(arg_472_1.iconTrs_.gameObject, false)
				arg_472_1.callingController_:SetSelectedState("normal")

				local var_475_3 = arg_472_1:GetWordFromCfg(424081112)
				local var_475_4 = arg_472_1:FormatText(var_475_3.content)

				arg_472_1.text_.text = var_475_4

				LuaForUtil.ClearLinePrefixSymbol(arg_472_1.text_)

				local var_475_5 = 36
				local var_475_6 = utf8.len(var_475_4)
				local var_475_7 = var_475_5 <= 0 and var_475_1 or var_475_1 * (var_475_6 / var_475_5)

				if var_475_7 > 0 and var_475_1 < var_475_7 then
					arg_472_1.talkMaxDuration = var_475_7

					if var_475_7 + var_475_0 > arg_472_1.duration_ then
						arg_472_1.duration_ = var_475_7 + var_475_0
					end
				end

				arg_472_1.text_.text = var_475_4
				arg_472_1.typewritter.percent = 0

				arg_472_1.typewritter:SetDirty()
				arg_472_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424081", "424081112", "story_v_out_424081.awb") ~= 0 then
					local var_475_8 = manager.audio:GetVoiceLength("story_v_out_424081", "424081112", "story_v_out_424081.awb") / 1000

					if var_475_8 + var_475_0 > arg_472_1.duration_ then
						arg_472_1.duration_ = var_475_8 + var_475_0
					end

					if var_475_3.prefab_name ~= "" and arg_472_1.actors_[var_475_3.prefab_name] ~= nil then
						local var_475_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_472_1.actors_[var_475_3.prefab_name].transform, "story_v_out_424081", "424081112", "story_v_out_424081.awb")

						arg_472_1:RecordAudio("424081112", var_475_9)
						arg_472_1:RecordAudio("424081112", var_475_9)
					else
						arg_472_1:AudioAction("play", "voice", "story_v_out_424081", "424081112", "story_v_out_424081.awb")
					end

					arg_472_1:RecordHistoryTalkVoice("story_v_out_424081", "424081112", "story_v_out_424081.awb")
				end

				arg_472_1:RecordContent(arg_472_1.text_.text)
			end

			local var_475_10 = math.max(var_475_1, arg_472_1.talkMaxDuration)

			if var_475_0 <= arg_472_1.time_ and arg_472_1.time_ < var_475_0 + var_475_10 then
				arg_472_1.typewritter.percent = (arg_472_1.time_ - var_475_0) / var_475_10

				arg_472_1.typewritter:SetDirty()
			end

			if arg_472_1.time_ >= var_475_0 + var_475_10 and arg_472_1.time_ < var_475_0 + var_475_10 + arg_475_0 then
				arg_472_1.typewritter.percent = 1

				arg_472_1.typewritter:SetDirty()
				arg_472_1:ShowNextGo(true)
			end
		end

		arg_472_1.nodeConfigList_ = {}

		arg_472_1:InitPlayNodeList()
	end,
	Play424081113 = function(arg_476_0, arg_476_1)
		arg_476_1.time_ = 0
		arg_476_1.frameCnt_ = 0
		arg_476_1.state_ = "playing"
		arg_476_1.curTalkId_ = 424081113
		arg_476_1.duration_ = 3.33

		local var_476_0 = {
			zh = 3.266,
			ja = 3.333
		}
		local var_476_1 = manager.audio:GetLocalizationFlag()

		if var_476_0[var_476_1] ~= nil then
			arg_476_1.duration_ = var_476_0[var_476_1]
		end

		SetActive(arg_476_1.tipsGo_, false)

		function arg_476_1.onSingleLineFinish_()
			arg_476_1.onSingleLineUpdate_ = nil
			arg_476_1.onSingleLineFinish_ = nil
			arg_476_1.state_ = "waiting"
		end

		function arg_476_1.playNext_(arg_478_0)
			if arg_478_0 == 1 then
				arg_476_0:Play424081114(arg_476_1)
			end
		end

		function arg_476_1.onSingleLineUpdate_(arg_479_0)
			local var_479_0 = 0
			local var_479_1 = 0.325

			if var_479_0 < arg_476_1.time_ and arg_476_1.time_ <= var_479_0 + arg_479_0 then
				arg_476_1.talkMaxDuration = 0
				arg_476_1.dialogCg_.alpha = 1

				arg_476_1.dialog_:SetActive(true)
				SetActive(arg_476_1.leftNameGo_, true)

				local var_479_2 = arg_476_1:FormatText(StoryNameCfg[1393].name)

				arg_476_1.leftNameTxt_.text = var_479_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_476_1.leftNameTxt_.transform)

				arg_476_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_476_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_476_1:RecordName(arg_476_1.leftNameTxt_.text)
				SetActive(arg_476_1.iconTrs_.gameObject, true)
				arg_476_1.iconController_:SetSelectedState("hero")

				arg_476_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lolia")

				arg_476_1.callingController_:SetSelectedState("normal")

				arg_476_1.keyicon_.color = Color.New(1, 1, 1)
				arg_476_1.icon_.color = Color.New(1, 1, 1)

				local var_479_3 = arg_476_1:GetWordFromCfg(424081113)
				local var_479_4 = arg_476_1:FormatText(var_479_3.content)

				arg_476_1.text_.text = var_479_4

				LuaForUtil.ClearLinePrefixSymbol(arg_476_1.text_)

				local var_479_5 = 13
				local var_479_6 = utf8.len(var_479_4)
				local var_479_7 = var_479_5 <= 0 and var_479_1 or var_479_1 * (var_479_6 / var_479_5)

				if var_479_7 > 0 and var_479_1 < var_479_7 then
					arg_476_1.talkMaxDuration = var_479_7

					if var_479_7 + var_479_0 > arg_476_1.duration_ then
						arg_476_1.duration_ = var_479_7 + var_479_0
					end
				end

				arg_476_1.text_.text = var_479_4
				arg_476_1.typewritter.percent = 0

				arg_476_1.typewritter:SetDirty()
				arg_476_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424081", "424081113", "story_v_out_424081.awb") ~= 0 then
					local var_479_8 = manager.audio:GetVoiceLength("story_v_out_424081", "424081113", "story_v_out_424081.awb") / 1000

					if var_479_8 + var_479_0 > arg_476_1.duration_ then
						arg_476_1.duration_ = var_479_8 + var_479_0
					end

					if var_479_3.prefab_name ~= "" and arg_476_1.actors_[var_479_3.prefab_name] ~= nil then
						local var_479_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_476_1.actors_[var_479_3.prefab_name].transform, "story_v_out_424081", "424081113", "story_v_out_424081.awb")

						arg_476_1:RecordAudio("424081113", var_479_9)
						arg_476_1:RecordAudio("424081113", var_479_9)
					else
						arg_476_1:AudioAction("play", "voice", "story_v_out_424081", "424081113", "story_v_out_424081.awb")
					end

					arg_476_1:RecordHistoryTalkVoice("story_v_out_424081", "424081113", "story_v_out_424081.awb")
				end

				arg_476_1:RecordContent(arg_476_1.text_.text)
			end

			local var_479_10 = math.max(var_479_1, arg_476_1.talkMaxDuration)

			if var_479_0 <= arg_476_1.time_ and arg_476_1.time_ < var_479_0 + var_479_10 then
				arg_476_1.typewritter.percent = (arg_476_1.time_ - var_479_0) / var_479_10

				arg_476_1.typewritter:SetDirty()
			end

			if arg_476_1.time_ >= var_479_0 + var_479_10 and arg_476_1.time_ < var_479_0 + var_479_10 + arg_479_0 then
				arg_476_1.typewritter.percent = 1

				arg_476_1.typewritter:SetDirty()
				arg_476_1:ShowNextGo(true)
			end
		end

		arg_476_1.nodeConfigList_ = {}

		arg_476_1:InitPlayNodeList()
	end,
	Play424081114 = function(arg_480_0, arg_480_1)
		arg_480_1.time_ = 0
		arg_480_1.frameCnt_ = 0
		arg_480_1.state_ = "playing"
		arg_480_1.curTalkId_ = 424081114
		arg_480_1.duration_ = 1.07

		local var_480_0 = {
			zh = 0.999999999999,
			ja = 1.066
		}
		local var_480_1 = manager.audio:GetLocalizationFlag()

		if var_480_0[var_480_1] ~= nil then
			arg_480_1.duration_ = var_480_0[var_480_1]
		end

		SetActive(arg_480_1.tipsGo_, false)

		function arg_480_1.onSingleLineFinish_()
			arg_480_1.onSingleLineUpdate_ = nil
			arg_480_1.onSingleLineFinish_ = nil
			arg_480_1.state_ = "waiting"
		end

		function arg_480_1.playNext_(arg_482_0)
			if arg_482_0 == 1 then
				arg_480_0:Play424081115(arg_480_1)
			end
		end

		function arg_480_1.onSingleLineUpdate_(arg_483_0)
			local var_483_0 = 0
			local var_483_1 = 0.05

			if var_483_0 < arg_480_1.time_ and arg_480_1.time_ <= var_483_0 + arg_483_0 then
				arg_480_1.talkMaxDuration = 0
				arg_480_1.dialogCg_.alpha = 1

				arg_480_1.dialog_:SetActive(true)
				SetActive(arg_480_1.leftNameGo_, true)

				local var_483_2 = arg_480_1:FormatText(StoryNameCfg[181].name)

				arg_480_1.leftNameTxt_.text = var_483_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_480_1.leftNameTxt_.transform)

				arg_480_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_480_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_480_1:RecordName(arg_480_1.leftNameTxt_.text)
				SetActive(arg_480_1.iconTrs_.gameObject, false)
				arg_480_1.callingController_:SetSelectedState("normal")

				local var_483_3 = arg_480_1:GetWordFromCfg(424081114)
				local var_483_4 = arg_480_1:FormatText(var_483_3.content)

				arg_480_1.text_.text = var_483_4

				LuaForUtil.ClearLinePrefixSymbol(arg_480_1.text_)

				local var_483_5 = 2
				local var_483_6 = utf8.len(var_483_4)
				local var_483_7 = var_483_5 <= 0 and var_483_1 or var_483_1 * (var_483_6 / var_483_5)

				if var_483_7 > 0 and var_483_1 < var_483_7 then
					arg_480_1.talkMaxDuration = var_483_7

					if var_483_7 + var_483_0 > arg_480_1.duration_ then
						arg_480_1.duration_ = var_483_7 + var_483_0
					end
				end

				arg_480_1.text_.text = var_483_4
				arg_480_1.typewritter.percent = 0

				arg_480_1.typewritter:SetDirty()
				arg_480_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424081", "424081114", "story_v_out_424081.awb") ~= 0 then
					local var_483_8 = manager.audio:GetVoiceLength("story_v_out_424081", "424081114", "story_v_out_424081.awb") / 1000

					if var_483_8 + var_483_0 > arg_480_1.duration_ then
						arg_480_1.duration_ = var_483_8 + var_483_0
					end

					if var_483_3.prefab_name ~= "" and arg_480_1.actors_[var_483_3.prefab_name] ~= nil then
						local var_483_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_480_1.actors_[var_483_3.prefab_name].transform, "story_v_out_424081", "424081114", "story_v_out_424081.awb")

						arg_480_1:RecordAudio("424081114", var_483_9)
						arg_480_1:RecordAudio("424081114", var_483_9)
					else
						arg_480_1:AudioAction("play", "voice", "story_v_out_424081", "424081114", "story_v_out_424081.awb")
					end

					arg_480_1:RecordHistoryTalkVoice("story_v_out_424081", "424081114", "story_v_out_424081.awb")
				end

				arg_480_1:RecordContent(arg_480_1.text_.text)
			end

			local var_483_10 = math.max(var_483_1, arg_480_1.talkMaxDuration)

			if var_483_0 <= arg_480_1.time_ and arg_480_1.time_ < var_483_0 + var_483_10 then
				arg_480_1.typewritter.percent = (arg_480_1.time_ - var_483_0) / var_483_10

				arg_480_1.typewritter:SetDirty()
			end

			if arg_480_1.time_ >= var_483_0 + var_483_10 and arg_480_1.time_ < var_483_0 + var_483_10 + arg_483_0 then
				arg_480_1.typewritter.percent = 1

				arg_480_1.typewritter:SetDirty()
				arg_480_1:ShowNextGo(true)
			end
		end

		arg_480_1.nodeConfigList_ = {}

		arg_480_1:InitPlayNodeList()
	end,
	Play424081115 = function(arg_484_0, arg_484_1)
		arg_484_1.time_ = 0
		arg_484_1.frameCnt_ = 0
		arg_484_1.state_ = "playing"
		arg_484_1.curTalkId_ = 424081115
		arg_484_1.duration_ = 5

		SetActive(arg_484_1.tipsGo_, false)

		function arg_484_1.onSingleLineFinish_()
			arg_484_1.onSingleLineUpdate_ = nil
			arg_484_1.onSingleLineFinish_ = nil
			arg_484_1.state_ = "waiting"
		end

		function arg_484_1.playNext_(arg_486_0)
			if arg_486_0 == 1 then
				arg_484_0:Play424081116(arg_484_1)
			end
		end

		function arg_484_1.onSingleLineUpdate_(arg_487_0)
			local var_487_0 = 0
			local var_487_1 = 0.975

			if var_487_0 < arg_484_1.time_ and arg_484_1.time_ <= var_487_0 + arg_487_0 then
				arg_484_1.talkMaxDuration = 0
				arg_484_1.dialogCg_.alpha = 1

				arg_484_1.dialog_:SetActive(true)
				SetActive(arg_484_1.leftNameGo_, false)

				arg_484_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_484_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_484_1:RecordName(arg_484_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_484_1.iconTrs_.gameObject, false)
				arg_484_1.callingController_:SetSelectedState("normal")

				local var_487_2 = arg_484_1:GetWordFromCfg(424081115)
				local var_487_3 = arg_484_1:FormatText(var_487_2.content)

				arg_484_1.text_.text = var_487_3

				LuaForUtil.ClearLinePrefixSymbol(arg_484_1.text_)

				local var_487_4 = 39
				local var_487_5 = utf8.len(var_487_3)
				local var_487_6 = var_487_4 <= 0 and var_487_1 or var_487_1 * (var_487_5 / var_487_4)

				if var_487_6 > 0 and var_487_1 < var_487_6 then
					arg_484_1.talkMaxDuration = var_487_6

					if var_487_6 + var_487_0 > arg_484_1.duration_ then
						arg_484_1.duration_ = var_487_6 + var_487_0
					end
				end

				arg_484_1.text_.text = var_487_3
				arg_484_1.typewritter.percent = 0

				arg_484_1.typewritter:SetDirty()
				arg_484_1:ShowNextGo(false)
				arg_484_1:RecordContent(arg_484_1.text_.text)
			end

			local var_487_7 = math.max(var_487_1, arg_484_1.talkMaxDuration)

			if var_487_0 <= arg_484_1.time_ and arg_484_1.time_ < var_487_0 + var_487_7 then
				arg_484_1.typewritter.percent = (arg_484_1.time_ - var_487_0) / var_487_7

				arg_484_1.typewritter:SetDirty()
			end

			if arg_484_1.time_ >= var_487_0 + var_487_7 and arg_484_1.time_ < var_487_0 + var_487_7 + arg_487_0 then
				arg_484_1.typewritter.percent = 1

				arg_484_1.typewritter:SetDirty()
				arg_484_1:ShowNextGo(true)
			end
		end

		arg_484_1.nodeConfigList_ = {}

		arg_484_1:InitPlayNodeList()
	end,
	Play424081116 = function(arg_488_0, arg_488_1)
		arg_488_1.time_ = 0
		arg_488_1.frameCnt_ = 0
		arg_488_1.state_ = "playing"
		arg_488_1.curTalkId_ = 424081116
		arg_488_1.duration_ = 15.6

		local var_488_0 = {
			zh = 13.8,
			ja = 15.6
		}
		local var_488_1 = manager.audio:GetLocalizationFlag()

		if var_488_0[var_488_1] ~= nil then
			arg_488_1.duration_ = var_488_0[var_488_1]
		end

		SetActive(arg_488_1.tipsGo_, false)

		function arg_488_1.onSingleLineFinish_()
			arg_488_1.onSingleLineUpdate_ = nil
			arg_488_1.onSingleLineFinish_ = nil
			arg_488_1.state_ = "waiting"
		end

		function arg_488_1.playNext_(arg_490_0)
			if arg_490_0 == 1 then
				arg_488_0:Play424081117(arg_488_1)
			end
		end

		function arg_488_1.onSingleLineUpdate_(arg_491_0)
			local var_491_0 = 0
			local var_491_1 = 1.35

			if var_491_0 < arg_488_1.time_ and arg_488_1.time_ <= var_491_0 + arg_491_0 then
				arg_488_1.talkMaxDuration = 0
				arg_488_1.dialogCg_.alpha = 1

				arg_488_1.dialog_:SetActive(true)
				SetActive(arg_488_1.leftNameGo_, true)

				local var_491_2 = arg_488_1:FormatText(StoryNameCfg[1394].name)

				arg_488_1.leftNameTxt_.text = var_491_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_488_1.leftNameTxt_.transform)

				arg_488_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_488_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_488_1:RecordName(arg_488_1.leftNameTxt_.text)
				SetActive(arg_488_1.iconTrs_.gameObject, true)
				arg_488_1.iconController_:SetSelectedState("hero")

				arg_488_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lolib")

				arg_488_1.callingController_:SetSelectedState("normal")

				arg_488_1.keyicon_.color = Color.New(1, 1, 1)
				arg_488_1.icon_.color = Color.New(1, 1, 1)

				local var_491_3 = arg_488_1:GetWordFromCfg(424081116)
				local var_491_4 = arg_488_1:FormatText(var_491_3.content)

				arg_488_1.text_.text = var_491_4

				LuaForUtil.ClearLinePrefixSymbol(arg_488_1.text_)

				local var_491_5 = 54
				local var_491_6 = utf8.len(var_491_4)
				local var_491_7 = var_491_5 <= 0 and var_491_1 or var_491_1 * (var_491_6 / var_491_5)

				if var_491_7 > 0 and var_491_1 < var_491_7 then
					arg_488_1.talkMaxDuration = var_491_7

					if var_491_7 + var_491_0 > arg_488_1.duration_ then
						arg_488_1.duration_ = var_491_7 + var_491_0
					end
				end

				arg_488_1.text_.text = var_491_4
				arg_488_1.typewritter.percent = 0

				arg_488_1.typewritter:SetDirty()
				arg_488_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424081", "424081116", "story_v_out_424081.awb") ~= 0 then
					local var_491_8 = manager.audio:GetVoiceLength("story_v_out_424081", "424081116", "story_v_out_424081.awb") / 1000

					if var_491_8 + var_491_0 > arg_488_1.duration_ then
						arg_488_1.duration_ = var_491_8 + var_491_0
					end

					if var_491_3.prefab_name ~= "" and arg_488_1.actors_[var_491_3.prefab_name] ~= nil then
						local var_491_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_488_1.actors_[var_491_3.prefab_name].transform, "story_v_out_424081", "424081116", "story_v_out_424081.awb")

						arg_488_1:RecordAudio("424081116", var_491_9)
						arg_488_1:RecordAudio("424081116", var_491_9)
					else
						arg_488_1:AudioAction("play", "voice", "story_v_out_424081", "424081116", "story_v_out_424081.awb")
					end

					arg_488_1:RecordHistoryTalkVoice("story_v_out_424081", "424081116", "story_v_out_424081.awb")
				end

				arg_488_1:RecordContent(arg_488_1.text_.text)
			end

			local var_491_10 = math.max(var_491_1, arg_488_1.talkMaxDuration)

			if var_491_0 <= arg_488_1.time_ and arg_488_1.time_ < var_491_0 + var_491_10 then
				arg_488_1.typewritter.percent = (arg_488_1.time_ - var_491_0) / var_491_10

				arg_488_1.typewritter:SetDirty()
			end

			if arg_488_1.time_ >= var_491_0 + var_491_10 and arg_488_1.time_ < var_491_0 + var_491_10 + arg_491_0 then
				arg_488_1.typewritter.percent = 1

				arg_488_1.typewritter:SetDirty()
				arg_488_1:ShowNextGo(true)
			end
		end

		arg_488_1.nodeConfigList_ = {}

		arg_488_1:InitPlayNodeList()
	end,
	Play424081117 = function(arg_492_0, arg_492_1)
		arg_492_1.time_ = 0
		arg_492_1.frameCnt_ = 0
		arg_492_1.state_ = "playing"
		arg_492_1.curTalkId_ = 424081117
		arg_492_1.duration_ = 10.2

		local var_492_0 = {
			zh = 10.2,
			ja = 9.233
		}
		local var_492_1 = manager.audio:GetLocalizationFlag()

		if var_492_0[var_492_1] ~= nil then
			arg_492_1.duration_ = var_492_0[var_492_1]
		end

		SetActive(arg_492_1.tipsGo_, false)

		function arg_492_1.onSingleLineFinish_()
			arg_492_1.onSingleLineUpdate_ = nil
			arg_492_1.onSingleLineFinish_ = nil
			arg_492_1.state_ = "waiting"
		end

		function arg_492_1.playNext_(arg_494_0)
			if arg_494_0 == 1 then
				arg_492_0:Play424081118(arg_492_1)
			end
		end

		function arg_492_1.onSingleLineUpdate_(arg_495_0)
			local var_495_0 = 0
			local var_495_1 = 0.85

			if var_495_0 < arg_492_1.time_ and arg_492_1.time_ <= var_495_0 + arg_495_0 then
				arg_492_1.talkMaxDuration = 0
				arg_492_1.dialogCg_.alpha = 1

				arg_492_1.dialog_:SetActive(true)
				SetActive(arg_492_1.leftNameGo_, true)

				local var_495_2 = arg_492_1:FormatText(StoryNameCfg[181].name)

				arg_492_1.leftNameTxt_.text = var_495_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_492_1.leftNameTxt_.transform)

				arg_492_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_492_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_492_1:RecordName(arg_492_1.leftNameTxt_.text)
				SetActive(arg_492_1.iconTrs_.gameObject, false)
				arg_492_1.callingController_:SetSelectedState("normal")

				local var_495_3 = arg_492_1:GetWordFromCfg(424081117)
				local var_495_4 = arg_492_1:FormatText(var_495_3.content)

				arg_492_1.text_.text = var_495_4

				LuaForUtil.ClearLinePrefixSymbol(arg_492_1.text_)

				local var_495_5 = 34
				local var_495_6 = utf8.len(var_495_4)
				local var_495_7 = var_495_5 <= 0 and var_495_1 or var_495_1 * (var_495_6 / var_495_5)

				if var_495_7 > 0 and var_495_1 < var_495_7 then
					arg_492_1.talkMaxDuration = var_495_7

					if var_495_7 + var_495_0 > arg_492_1.duration_ then
						arg_492_1.duration_ = var_495_7 + var_495_0
					end
				end

				arg_492_1.text_.text = var_495_4
				arg_492_1.typewritter.percent = 0

				arg_492_1.typewritter:SetDirty()
				arg_492_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424081", "424081117", "story_v_out_424081.awb") ~= 0 then
					local var_495_8 = manager.audio:GetVoiceLength("story_v_out_424081", "424081117", "story_v_out_424081.awb") / 1000

					if var_495_8 + var_495_0 > arg_492_1.duration_ then
						arg_492_1.duration_ = var_495_8 + var_495_0
					end

					if var_495_3.prefab_name ~= "" and arg_492_1.actors_[var_495_3.prefab_name] ~= nil then
						local var_495_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_492_1.actors_[var_495_3.prefab_name].transform, "story_v_out_424081", "424081117", "story_v_out_424081.awb")

						arg_492_1:RecordAudio("424081117", var_495_9)
						arg_492_1:RecordAudio("424081117", var_495_9)
					else
						arg_492_1:AudioAction("play", "voice", "story_v_out_424081", "424081117", "story_v_out_424081.awb")
					end

					arg_492_1:RecordHistoryTalkVoice("story_v_out_424081", "424081117", "story_v_out_424081.awb")
				end

				arg_492_1:RecordContent(arg_492_1.text_.text)
			end

			local var_495_10 = math.max(var_495_1, arg_492_1.talkMaxDuration)

			if var_495_0 <= arg_492_1.time_ and arg_492_1.time_ < var_495_0 + var_495_10 then
				arg_492_1.typewritter.percent = (arg_492_1.time_ - var_495_0) / var_495_10

				arg_492_1.typewritter:SetDirty()
			end

			if arg_492_1.time_ >= var_495_0 + var_495_10 and arg_492_1.time_ < var_495_0 + var_495_10 + arg_495_0 then
				arg_492_1.typewritter.percent = 1

				arg_492_1.typewritter:SetDirty()
				arg_492_1:ShowNextGo(true)
			end
		end

		arg_492_1.nodeConfigList_ = {}

		arg_492_1:InitPlayNodeList()
	end,
	Play424081118 = function(arg_496_0, arg_496_1)
		arg_496_1.time_ = 0
		arg_496_1.frameCnt_ = 0
		arg_496_1.state_ = "playing"
		arg_496_1.curTalkId_ = 424081118
		arg_496_1.duration_ = 9.47

		local var_496_0 = {
			zh = 6.166,
			ja = 9.466
		}
		local var_496_1 = manager.audio:GetLocalizationFlag()

		if var_496_0[var_496_1] ~= nil then
			arg_496_1.duration_ = var_496_0[var_496_1]
		end

		SetActive(arg_496_1.tipsGo_, false)

		function arg_496_1.onSingleLineFinish_()
			arg_496_1.onSingleLineUpdate_ = nil
			arg_496_1.onSingleLineFinish_ = nil
			arg_496_1.state_ = "waiting"
		end

		function arg_496_1.playNext_(arg_498_0)
			if arg_498_0 == 1 then
				arg_496_0:Play424081119(arg_496_1)
			end
		end

		function arg_496_1.onSingleLineUpdate_(arg_499_0)
			local var_499_0 = 0
			local var_499_1 = 0.675

			if var_499_0 < arg_496_1.time_ and arg_496_1.time_ <= var_499_0 + arg_499_0 then
				arg_496_1.talkMaxDuration = 0
				arg_496_1.dialogCg_.alpha = 1

				arg_496_1.dialog_:SetActive(true)
				SetActive(arg_496_1.leftNameGo_, true)

				local var_499_2 = arg_496_1:FormatText(StoryNameCfg[1404].name)

				arg_496_1.leftNameTxt_.text = var_499_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_496_1.leftNameTxt_.transform)

				arg_496_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_496_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_496_1:RecordName(arg_496_1.leftNameTxt_.text)
				SetActive(arg_496_1.iconTrs_.gameObject, true)
				arg_496_1.iconController_:SetSelectedState("hero")

				arg_496_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_littleboya")

				arg_496_1.callingController_:SetSelectedState("normal")

				arg_496_1.keyicon_.color = Color.New(1, 1, 1)
				arg_496_1.icon_.color = Color.New(1, 1, 1)

				local var_499_3 = arg_496_1:GetWordFromCfg(424081118)
				local var_499_4 = arg_496_1:FormatText(var_499_3.content)

				arg_496_1.text_.text = var_499_4

				LuaForUtil.ClearLinePrefixSymbol(arg_496_1.text_)

				local var_499_5 = 27
				local var_499_6 = utf8.len(var_499_4)
				local var_499_7 = var_499_5 <= 0 and var_499_1 or var_499_1 * (var_499_6 / var_499_5)

				if var_499_7 > 0 and var_499_1 < var_499_7 then
					arg_496_1.talkMaxDuration = var_499_7

					if var_499_7 + var_499_0 > arg_496_1.duration_ then
						arg_496_1.duration_ = var_499_7 + var_499_0
					end
				end

				arg_496_1.text_.text = var_499_4
				arg_496_1.typewritter.percent = 0

				arg_496_1.typewritter:SetDirty()
				arg_496_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424081", "424081118", "story_v_out_424081.awb") ~= 0 then
					local var_499_8 = manager.audio:GetVoiceLength("story_v_out_424081", "424081118", "story_v_out_424081.awb") / 1000

					if var_499_8 + var_499_0 > arg_496_1.duration_ then
						arg_496_1.duration_ = var_499_8 + var_499_0
					end

					if var_499_3.prefab_name ~= "" and arg_496_1.actors_[var_499_3.prefab_name] ~= nil then
						local var_499_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_496_1.actors_[var_499_3.prefab_name].transform, "story_v_out_424081", "424081118", "story_v_out_424081.awb")

						arg_496_1:RecordAudio("424081118", var_499_9)
						arg_496_1:RecordAudio("424081118", var_499_9)
					else
						arg_496_1:AudioAction("play", "voice", "story_v_out_424081", "424081118", "story_v_out_424081.awb")
					end

					arg_496_1:RecordHistoryTalkVoice("story_v_out_424081", "424081118", "story_v_out_424081.awb")
				end

				arg_496_1:RecordContent(arg_496_1.text_.text)
			end

			local var_499_10 = math.max(var_499_1, arg_496_1.talkMaxDuration)

			if var_499_0 <= arg_496_1.time_ and arg_496_1.time_ < var_499_0 + var_499_10 then
				arg_496_1.typewritter.percent = (arg_496_1.time_ - var_499_0) / var_499_10

				arg_496_1.typewritter:SetDirty()
			end

			if arg_496_1.time_ >= var_499_0 + var_499_10 and arg_496_1.time_ < var_499_0 + var_499_10 + arg_499_0 then
				arg_496_1.typewritter.percent = 1

				arg_496_1.typewritter:SetDirty()
				arg_496_1:ShowNextGo(true)
			end
		end

		arg_496_1.nodeConfigList_ = {}

		arg_496_1:InitPlayNodeList()
	end,
	Play424081119 = function(arg_500_0, arg_500_1)
		arg_500_1.time_ = 0
		arg_500_1.frameCnt_ = 0
		arg_500_1.state_ = "playing"
		arg_500_1.curTalkId_ = 424081119
		arg_500_1.duration_ = 5

		SetActive(arg_500_1.tipsGo_, false)

		function arg_500_1.onSingleLineFinish_()
			arg_500_1.onSingleLineUpdate_ = nil
			arg_500_1.onSingleLineFinish_ = nil
			arg_500_1.state_ = "waiting"
		end

		function arg_500_1.playNext_(arg_502_0)
			if arg_502_0 == 1 then
				arg_500_0:Play424081120(arg_500_1)
			end
		end

		function arg_500_1.onSingleLineUpdate_(arg_503_0)
			local var_503_0 = 0
			local var_503_1 = 0.725

			if var_503_0 < arg_500_1.time_ and arg_500_1.time_ <= var_503_0 + arg_503_0 then
				arg_500_1.talkMaxDuration = 0
				arg_500_1.dialogCg_.alpha = 1

				arg_500_1.dialog_:SetActive(true)
				SetActive(arg_500_1.leftNameGo_, true)

				local var_503_2 = arg_500_1:FormatText(StoryNameCfg[7].name)

				arg_500_1.leftNameTxt_.text = var_503_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_500_1.leftNameTxt_.transform)

				arg_500_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_500_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_500_1:RecordName(arg_500_1.leftNameTxt_.text)
				SetActive(arg_500_1.iconTrs_.gameObject, true)
				arg_500_1.iconController_:SetSelectedState("hero")

				arg_500_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_500_1.callingController_:SetSelectedState("normal")

				arg_500_1.keyicon_.color = Color.New(1, 1, 1)
				arg_500_1.icon_.color = Color.New(1, 1, 1)

				local var_503_3 = arg_500_1:GetWordFromCfg(424081119)
				local var_503_4 = arg_500_1:FormatText(var_503_3.content)

				arg_500_1.text_.text = var_503_4

				LuaForUtil.ClearLinePrefixSymbol(arg_500_1.text_)

				local var_503_5 = 29
				local var_503_6 = utf8.len(var_503_4)
				local var_503_7 = var_503_5 <= 0 and var_503_1 or var_503_1 * (var_503_6 / var_503_5)

				if var_503_7 > 0 and var_503_1 < var_503_7 then
					arg_500_1.talkMaxDuration = var_503_7

					if var_503_7 + var_503_0 > arg_500_1.duration_ then
						arg_500_1.duration_ = var_503_7 + var_503_0
					end
				end

				arg_500_1.text_.text = var_503_4
				arg_500_1.typewritter.percent = 0

				arg_500_1.typewritter:SetDirty()
				arg_500_1:ShowNextGo(false)
				arg_500_1:RecordContent(arg_500_1.text_.text)
			end

			local var_503_8 = math.max(var_503_1, arg_500_1.talkMaxDuration)

			if var_503_0 <= arg_500_1.time_ and arg_500_1.time_ < var_503_0 + var_503_8 then
				arg_500_1.typewritter.percent = (arg_500_1.time_ - var_503_0) / var_503_8

				arg_500_1.typewritter:SetDirty()
			end

			if arg_500_1.time_ >= var_503_0 + var_503_8 and arg_500_1.time_ < var_503_0 + var_503_8 + arg_503_0 then
				arg_500_1.typewritter.percent = 1

				arg_500_1.typewritter:SetDirty()
				arg_500_1:ShowNextGo(true)
			end
		end

		arg_500_1.nodeConfigList_ = {}

		arg_500_1:InitPlayNodeList()
	end,
	Play424081120 = function(arg_504_0, arg_504_1)
		arg_504_1.time_ = 0
		arg_504_1.frameCnt_ = 0
		arg_504_1.state_ = "playing"
		arg_504_1.curTalkId_ = 424081120
		arg_504_1.duration_ = 5

		SetActive(arg_504_1.tipsGo_, false)

		function arg_504_1.onSingleLineFinish_()
			arg_504_1.onSingleLineUpdate_ = nil
			arg_504_1.onSingleLineFinish_ = nil
			arg_504_1.state_ = "waiting"
		end

		function arg_504_1.playNext_(arg_506_0)
			if arg_506_0 == 1 then
				arg_504_0:Play424081121(arg_504_1)
			end
		end

		function arg_504_1.onSingleLineUpdate_(arg_507_0)
			local var_507_0 = 0
			local var_507_1 = 1

			if var_507_0 < arg_504_1.time_ and arg_504_1.time_ <= var_507_0 + arg_507_0 then
				arg_504_1.talkMaxDuration = 0
				arg_504_1.dialogCg_.alpha = 1

				arg_504_1.dialog_:SetActive(true)
				SetActive(arg_504_1.leftNameGo_, true)

				local var_507_2 = arg_504_1:FormatText(StoryNameCfg[7].name)

				arg_504_1.leftNameTxt_.text = var_507_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_504_1.leftNameTxt_.transform)

				arg_504_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_504_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_504_1:RecordName(arg_504_1.leftNameTxt_.text)
				SetActive(arg_504_1.iconTrs_.gameObject, true)
				arg_504_1.iconController_:SetSelectedState("hero")

				arg_504_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_504_1.callingController_:SetSelectedState("normal")

				arg_504_1.keyicon_.color = Color.New(1, 1, 1)
				arg_504_1.icon_.color = Color.New(1, 1, 1)

				local var_507_3 = arg_504_1:GetWordFromCfg(424081120)
				local var_507_4 = arg_504_1:FormatText(var_507_3.content)

				arg_504_1.text_.text = var_507_4

				LuaForUtil.ClearLinePrefixSymbol(arg_504_1.text_)

				local var_507_5 = 40
				local var_507_6 = utf8.len(var_507_4)
				local var_507_7 = var_507_5 <= 0 and var_507_1 or var_507_1 * (var_507_6 / var_507_5)

				if var_507_7 > 0 and var_507_1 < var_507_7 then
					arg_504_1.talkMaxDuration = var_507_7

					if var_507_7 + var_507_0 > arg_504_1.duration_ then
						arg_504_1.duration_ = var_507_7 + var_507_0
					end
				end

				arg_504_1.text_.text = var_507_4
				arg_504_1.typewritter.percent = 0

				arg_504_1.typewritter:SetDirty()
				arg_504_1:ShowNextGo(false)
				arg_504_1:RecordContent(arg_504_1.text_.text)
			end

			local var_507_8 = math.max(var_507_1, arg_504_1.talkMaxDuration)

			if var_507_0 <= arg_504_1.time_ and arg_504_1.time_ < var_507_0 + var_507_8 then
				arg_504_1.typewritter.percent = (arg_504_1.time_ - var_507_0) / var_507_8

				arg_504_1.typewritter:SetDirty()
			end

			if arg_504_1.time_ >= var_507_0 + var_507_8 and arg_504_1.time_ < var_507_0 + var_507_8 + arg_507_0 then
				arg_504_1.typewritter.percent = 1

				arg_504_1.typewritter:SetDirty()
				arg_504_1:ShowNextGo(true)
			end
		end

		arg_504_1.nodeConfigList_ = {}

		arg_504_1:InitPlayNodeList()
	end,
	Play424081121 = function(arg_508_0, arg_508_1)
		arg_508_1.time_ = 0
		arg_508_1.frameCnt_ = 0
		arg_508_1.state_ = "playing"
		arg_508_1.curTalkId_ = 424081121
		arg_508_1.duration_ = 10.5

		local var_508_0 = {
			zh = 7.599999999998,
			ja = 10.499999999998
		}
		local var_508_1 = manager.audio:GetLocalizationFlag()

		if var_508_0[var_508_1] ~= nil then
			arg_508_1.duration_ = var_508_0[var_508_1]
		end

		SetActive(arg_508_1.tipsGo_, false)

		function arg_508_1.onSingleLineFinish_()
			arg_508_1.onSingleLineUpdate_ = nil
			arg_508_1.onSingleLineFinish_ = nil
			arg_508_1.state_ = "waiting"
		end

		function arg_508_1.playNext_(arg_510_0)
			if arg_510_0 == 1 then
				arg_508_0:Play424081122(arg_508_1)
			end
		end

		function arg_508_1.onSingleLineUpdate_(arg_511_0)
			local var_511_0 = 2

			if var_511_0 < arg_508_1.time_ and arg_508_1.time_ <= var_511_0 + arg_511_0 then
				local var_511_1 = manager.ui.mainCamera.transform.localPosition
				local var_511_2 = Vector3.New(0, 0, 10) + Vector3.New(var_511_1.x, var_511_1.y, 0)
				local var_511_3 = arg_508_1.bgs_.SS2402

				var_511_3.transform.localPosition = var_511_2
				var_511_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_511_4 = var_511_3:GetComponent("SpriteRenderer")

				if var_511_4 and var_511_4.sprite then
					local var_511_5 = (var_511_3.transform.localPosition - var_511_1).z
					local var_511_6 = manager.ui.mainCameraCom_
					local var_511_7 = 2 * var_511_5 * Mathf.Tan(var_511_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_511_8 = var_511_7 * var_511_6.aspect
					local var_511_9 = var_511_4.sprite.bounds.size.x
					local var_511_10 = var_511_4.sprite.bounds.size.y
					local var_511_11 = var_511_8 / var_511_9
					local var_511_12 = var_511_7 / var_511_10
					local var_511_13 = var_511_12 < var_511_11 and var_511_11 or var_511_12

					var_511_3.transform.localScale = Vector3.New(var_511_13, var_511_13, 0)
				end

				for iter_511_0, iter_511_1 in pairs(arg_508_1.bgs_) do
					if iter_511_0 ~= "SS2402" then
						iter_511_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_511_14 = 3.999999999999

			if var_511_14 < arg_508_1.time_ and arg_508_1.time_ <= var_511_14 + arg_511_0 then
				arg_508_1.allBtn_.enabled = false
			end

			local var_511_15 = 0.3

			if arg_508_1.time_ >= var_511_14 + var_511_15 and arg_508_1.time_ < var_511_14 + var_511_15 + arg_511_0 then
				arg_508_1.allBtn_.enabled = true
			end

			local var_511_16 = 0

			if var_511_16 < arg_508_1.time_ and arg_508_1.time_ <= var_511_16 + arg_511_0 then
				arg_508_1.mask_.enabled = true
				arg_508_1.mask_.raycastTarget = true

				arg_508_1:SetGaussion(false)
			end

			local var_511_17 = 2

			if var_511_16 <= arg_508_1.time_ and arg_508_1.time_ < var_511_16 + var_511_17 then
				local var_511_18 = (arg_508_1.time_ - var_511_16) / var_511_17
				local var_511_19 = Color.New(0, 0, 0)

				var_511_19.a = Mathf.Lerp(0, 1, var_511_18)
				arg_508_1.mask_.color = var_511_19
			end

			if arg_508_1.time_ >= var_511_16 + var_511_17 and arg_508_1.time_ < var_511_16 + var_511_17 + arg_511_0 then
				local var_511_20 = Color.New(0, 0, 0)

				var_511_20.a = 1
				arg_508_1.mask_.color = var_511_20
			end

			local var_511_21 = 2

			if var_511_21 < arg_508_1.time_ and arg_508_1.time_ <= var_511_21 + arg_511_0 then
				arg_508_1.mask_.enabled = true
				arg_508_1.mask_.raycastTarget = true

				arg_508_1:SetGaussion(false)
			end

			local var_511_22 = 2

			if var_511_21 <= arg_508_1.time_ and arg_508_1.time_ < var_511_21 + var_511_22 then
				local var_511_23 = (arg_508_1.time_ - var_511_21) / var_511_22
				local var_511_24 = Color.New(0, 0, 0)

				var_511_24.a = Mathf.Lerp(1, 0, var_511_23)
				arg_508_1.mask_.color = var_511_24
			end

			if arg_508_1.time_ >= var_511_21 + var_511_22 and arg_508_1.time_ < var_511_21 + var_511_22 + arg_511_0 then
				local var_511_25 = Color.New(0, 0, 0)
				local var_511_26 = 0

				arg_508_1.mask_.enabled = false
				var_511_25.a = var_511_26
				arg_508_1.mask_.color = var_511_25
			end

			if arg_508_1.frameCnt_ <= 1 then
				arg_508_1.dialog_:SetActive(false)
			end

			local var_511_27 = 3.999999999998
			local var_511_28 = 0.3

			if var_511_27 < arg_508_1.time_ and arg_508_1.time_ <= var_511_27 + arg_511_0 then
				arg_508_1.talkMaxDuration = 0

				arg_508_1.dialog_:SetActive(true)

				arg_508_1.dialogCg_.alpha = 0

				local var_511_29 = LeanTween.value(arg_508_1.dialog_, 0, 1, 0.3)

				var_511_29:setOnUpdate(LuaHelper.FloatAction(function(arg_512_0)
					arg_508_1.dialogCg_.alpha = arg_512_0
				end))
				var_511_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_508_1.dialog_)
					var_511_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_508_1.duration_ = arg_508_1.duration_ + 0.3

				SetActive(arg_508_1.leftNameGo_, true)

				local var_511_30 = arg_508_1:FormatText(StoryNameCfg[181].name)

				arg_508_1.leftNameTxt_.text = var_511_30

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_508_1.leftNameTxt_.transform)

				arg_508_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_508_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_508_1:RecordName(arg_508_1.leftNameTxt_.text)
				SetActive(arg_508_1.iconTrs_.gameObject, false)
				arg_508_1.callingController_:SetSelectedState("normal")

				local var_511_31 = arg_508_1:GetWordFromCfg(424081121)
				local var_511_32 = arg_508_1:FormatText(var_511_31.content)

				arg_508_1.text_.text = var_511_32

				LuaForUtil.ClearLinePrefixSymbol(arg_508_1.text_)

				local var_511_33 = 12
				local var_511_34 = utf8.len(var_511_32)
				local var_511_35 = var_511_33 <= 0 and var_511_28 or var_511_28 * (var_511_34 / var_511_33)

				if var_511_35 > 0 and var_511_28 < var_511_35 then
					arg_508_1.talkMaxDuration = var_511_35
					var_511_27 = var_511_27 + 0.3

					if var_511_35 + var_511_27 > arg_508_1.duration_ then
						arg_508_1.duration_ = var_511_35 + var_511_27
					end
				end

				arg_508_1.text_.text = var_511_32
				arg_508_1.typewritter.percent = 0

				arg_508_1.typewritter:SetDirty()
				arg_508_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424081", "424081121", "story_v_out_424081.awb") ~= 0 then
					local var_511_36 = manager.audio:GetVoiceLength("story_v_out_424081", "424081121", "story_v_out_424081.awb") / 1000

					if var_511_36 + var_511_27 > arg_508_1.duration_ then
						arg_508_1.duration_ = var_511_36 + var_511_27
					end

					if var_511_31.prefab_name ~= "" and arg_508_1.actors_[var_511_31.prefab_name] ~= nil then
						local var_511_37 = LuaForUtil.PlayVoiceWithCriLipsync(arg_508_1.actors_[var_511_31.prefab_name].transform, "story_v_out_424081", "424081121", "story_v_out_424081.awb")

						arg_508_1:RecordAudio("424081121", var_511_37)
						arg_508_1:RecordAudio("424081121", var_511_37)
					else
						arg_508_1:AudioAction("play", "voice", "story_v_out_424081", "424081121", "story_v_out_424081.awb")
					end

					arg_508_1:RecordHistoryTalkVoice("story_v_out_424081", "424081121", "story_v_out_424081.awb")
				end

				arg_508_1:RecordContent(arg_508_1.text_.text)
			end

			local var_511_38 = var_511_27 + 0.3
			local var_511_39 = math.max(var_511_28, arg_508_1.talkMaxDuration)

			if var_511_38 <= arg_508_1.time_ and arg_508_1.time_ < var_511_38 + var_511_39 then
				arg_508_1.typewritter.percent = (arg_508_1.time_ - var_511_38) / var_511_39

				arg_508_1.typewritter:SetDirty()
			end

			if arg_508_1.time_ >= var_511_38 + var_511_39 and arg_508_1.time_ < var_511_38 + var_511_39 + arg_511_0 then
				arg_508_1.typewritter.percent = 1

				arg_508_1.typewritter:SetDirty()
				arg_508_1:ShowNextGo(true)
			end
		end

		arg_508_1.nodeConfigList_ = {}

		arg_508_1:InitPlayNodeList()
	end,
	Play424081122 = function(arg_514_0, arg_514_1)
		arg_514_1.time_ = 0
		arg_514_1.frameCnt_ = 0
		arg_514_1.state_ = "playing"
		arg_514_1.curTalkId_ = 424081122
		arg_514_1.duration_ = 7

		SetActive(arg_514_1.tipsGo_, false)

		function arg_514_1.onSingleLineFinish_()
			arg_514_1.onSingleLineUpdate_ = nil
			arg_514_1.onSingleLineFinish_ = nil
			arg_514_1.state_ = "waiting"
		end

		function arg_514_1.playNext_(arg_516_0)
			if arg_516_0 == 1 then
				arg_514_0:Play424081123(arg_514_1)
			end
		end

		function arg_514_1.onSingleLineUpdate_(arg_517_0)
			local var_517_0 = 0

			if var_517_0 < arg_514_1.time_ and arg_514_1.time_ <= var_517_0 + arg_517_0 then
				arg_514_1.mask_.enabled = true
				arg_514_1.mask_.raycastTarget = true

				arg_514_1:SetGaussion(false)
			end

			local var_517_1 = 1

			if var_517_0 <= arg_514_1.time_ and arg_514_1.time_ < var_517_0 + var_517_1 then
				local var_517_2 = (arg_514_1.time_ - var_517_0) / var_517_1
				local var_517_3 = Color.New(0.1320755, 0.1320755, 0.1320755)

				var_517_3.a = Mathf.Lerp(0, 1, var_517_2)
				arg_514_1.mask_.color = var_517_3
			end

			if arg_514_1.time_ >= var_517_0 + var_517_1 and arg_514_1.time_ < var_517_0 + var_517_1 + arg_517_0 then
				local var_517_4 = Color.New(0.1320755, 0.1320755, 0.1320755)

				var_517_4.a = 1
				arg_514_1.mask_.color = var_517_4
			end

			local var_517_5 = 1

			if var_517_5 < arg_514_1.time_ and arg_514_1.time_ <= var_517_5 + arg_517_0 then
				arg_514_1.mask_.enabled = true
				arg_514_1.mask_.raycastTarget = true

				arg_514_1:SetGaussion(false)
			end

			local var_517_6 = 1

			if var_517_5 <= arg_514_1.time_ and arg_514_1.time_ < var_517_5 + var_517_6 then
				local var_517_7 = (arg_514_1.time_ - var_517_5) / var_517_6
				local var_517_8 = Color.New(0.1320755, 0.1320755, 0.1320755)

				var_517_8.a = Mathf.Lerp(1, 0, var_517_7)
				arg_514_1.mask_.color = var_517_8
			end

			if arg_514_1.time_ >= var_517_5 + var_517_6 and arg_514_1.time_ < var_517_5 + var_517_6 + arg_517_0 then
				local var_517_9 = Color.New(0.1320755, 0.1320755, 0.1320755)
				local var_517_10 = 0

				arg_514_1.mask_.enabled = false
				var_517_9.a = var_517_10
				arg_514_1.mask_.color = var_517_9
			end

			local var_517_11 = arg_514_1.bgs_.SS2402.transform
			local var_517_12 = 1

			if var_517_12 < arg_514_1.time_ and arg_514_1.time_ <= var_517_12 + arg_517_0 then
				arg_514_1.var_.moveOldPosSS2402 = var_517_11.localPosition
			end

			local var_517_13 = 2

			if var_517_12 <= arg_514_1.time_ and arg_514_1.time_ < var_517_12 + var_517_13 then
				local var_517_14 = (arg_514_1.time_ - var_517_12) / var_517_13
				local var_517_15 = Vector3.New(0, 1, 6)

				var_517_11.localPosition = Vector3.Lerp(arg_514_1.var_.moveOldPosSS2402, var_517_15, var_517_14)
			end

			if arg_514_1.time_ >= var_517_12 + var_517_13 and arg_514_1.time_ < var_517_12 + var_517_13 + arg_517_0 then
				var_517_11.localPosition = Vector3.New(0, 1, 6)
			end

			if arg_514_1.frameCnt_ <= 1 then
				arg_514_1.dialog_:SetActive(false)
			end

			local var_517_16 = 2
			local var_517_17 = 0.625

			if var_517_16 < arg_514_1.time_ and arg_514_1.time_ <= var_517_16 + arg_517_0 then
				arg_514_1.talkMaxDuration = 0

				arg_514_1.dialog_:SetActive(true)

				arg_514_1.dialogCg_.alpha = 0

				local var_517_18 = LeanTween.value(arg_514_1.dialog_, 0, 1, 0.3)

				var_517_18:setOnUpdate(LuaHelper.FloatAction(function(arg_518_0)
					arg_514_1.dialogCg_.alpha = arg_518_0
				end))
				var_517_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_514_1.dialog_)
					var_517_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_514_1.duration_ = arg_514_1.duration_ + 0.3

				SetActive(arg_514_1.leftNameGo_, false)

				arg_514_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_514_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_514_1:RecordName(arg_514_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_514_1.iconTrs_.gameObject, false)
				arg_514_1.callingController_:SetSelectedState("normal")

				local var_517_19 = arg_514_1:GetWordFromCfg(424081122)
				local var_517_20 = arg_514_1:FormatText(var_517_19.content)

				arg_514_1.text_.text = var_517_20

				LuaForUtil.ClearLinePrefixSymbol(arg_514_1.text_)

				local var_517_21 = 25
				local var_517_22 = utf8.len(var_517_20)
				local var_517_23 = var_517_21 <= 0 and var_517_17 or var_517_17 * (var_517_22 / var_517_21)

				if var_517_23 > 0 and var_517_17 < var_517_23 then
					arg_514_1.talkMaxDuration = var_517_23
					var_517_16 = var_517_16 + 0.3

					if var_517_23 + var_517_16 > arg_514_1.duration_ then
						arg_514_1.duration_ = var_517_23 + var_517_16
					end
				end

				arg_514_1.text_.text = var_517_20
				arg_514_1.typewritter.percent = 0

				arg_514_1.typewritter:SetDirty()
				arg_514_1:ShowNextGo(false)
				arg_514_1:RecordContent(arg_514_1.text_.text)
			end

			local var_517_24 = var_517_16 + 0.3
			local var_517_25 = math.max(var_517_17, arg_514_1.talkMaxDuration)

			if var_517_24 <= arg_514_1.time_ and arg_514_1.time_ < var_517_24 + var_517_25 then
				arg_514_1.typewritter.percent = (arg_514_1.time_ - var_517_24) / var_517_25

				arg_514_1.typewritter:SetDirty()
			end

			if arg_514_1.time_ >= var_517_24 + var_517_25 and arg_514_1.time_ < var_517_24 + var_517_25 + arg_517_0 then
				arg_514_1.typewritter.percent = 1

				arg_514_1.typewritter:SetDirty()
				arg_514_1:ShowNextGo(true)
			end
		end

		arg_514_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "SS2402",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 2,
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 6.5),
					endPos = Vector3.New(0, 1, 6),
					easeType = LeanTweenType.notUsed
				}
			}
		}

		arg_514_1:InitPlayNodeList()
	end,
	Play424081123 = function(arg_520_0, arg_520_1)
		arg_520_1.time_ = 0
		arg_520_1.frameCnt_ = 0
		arg_520_1.state_ = "playing"
		arg_520_1.curTalkId_ = 424081123
		arg_520_1.duration_ = 2.5

		local var_520_0 = {
			zh = 2.1,
			ja = 2.5
		}
		local var_520_1 = manager.audio:GetLocalizationFlag()

		if var_520_0[var_520_1] ~= nil then
			arg_520_1.duration_ = var_520_0[var_520_1]
		end

		SetActive(arg_520_1.tipsGo_, false)

		function arg_520_1.onSingleLineFinish_()
			arg_520_1.onSingleLineUpdate_ = nil
			arg_520_1.onSingleLineFinish_ = nil
			arg_520_1.state_ = "waiting"
		end

		function arg_520_1.playNext_(arg_522_0)
			if arg_522_0 == 1 then
				arg_520_0:Play424081124(arg_520_1)
			end
		end

		function arg_520_1.onSingleLineUpdate_(arg_523_0)
			local var_523_0 = 0
			local var_523_1 = 0.2

			if var_523_0 < arg_520_1.time_ and arg_520_1.time_ <= var_523_0 + arg_523_0 then
				arg_520_1.talkMaxDuration = 0
				arg_520_1.dialogCg_.alpha = 1

				arg_520_1.dialog_:SetActive(true)
				SetActive(arg_520_1.leftNameGo_, true)

				local var_523_2 = arg_520_1:FormatText(StoryNameCfg[1404].name)

				arg_520_1.leftNameTxt_.text = var_523_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_520_1.leftNameTxt_.transform)

				arg_520_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_520_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_520_1:RecordName(arg_520_1.leftNameTxt_.text)
				SetActive(arg_520_1.iconTrs_.gameObject, true)
				arg_520_1.iconController_:SetSelectedState("hero")

				arg_520_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_littleboya")

				arg_520_1.callingController_:SetSelectedState("normal")

				arg_520_1.keyicon_.color = Color.New(1, 1, 1)
				arg_520_1.icon_.color = Color.New(1, 1, 1)

				local var_523_3 = arg_520_1:GetWordFromCfg(424081123)
				local var_523_4 = arg_520_1:FormatText(var_523_3.content)

				arg_520_1.text_.text = var_523_4

				LuaForUtil.ClearLinePrefixSymbol(arg_520_1.text_)

				local var_523_5 = 8
				local var_523_6 = utf8.len(var_523_4)
				local var_523_7 = var_523_5 <= 0 and var_523_1 or var_523_1 * (var_523_6 / var_523_5)

				if var_523_7 > 0 and var_523_1 < var_523_7 then
					arg_520_1.talkMaxDuration = var_523_7

					if var_523_7 + var_523_0 > arg_520_1.duration_ then
						arg_520_1.duration_ = var_523_7 + var_523_0
					end
				end

				arg_520_1.text_.text = var_523_4
				arg_520_1.typewritter.percent = 0

				arg_520_1.typewritter:SetDirty()
				arg_520_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424081", "424081123", "story_v_out_424081.awb") ~= 0 then
					local var_523_8 = manager.audio:GetVoiceLength("story_v_out_424081", "424081123", "story_v_out_424081.awb") / 1000

					if var_523_8 + var_523_0 > arg_520_1.duration_ then
						arg_520_1.duration_ = var_523_8 + var_523_0
					end

					if var_523_3.prefab_name ~= "" and arg_520_1.actors_[var_523_3.prefab_name] ~= nil then
						local var_523_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_520_1.actors_[var_523_3.prefab_name].transform, "story_v_out_424081", "424081123", "story_v_out_424081.awb")

						arg_520_1:RecordAudio("424081123", var_523_9)
						arg_520_1:RecordAudio("424081123", var_523_9)
					else
						arg_520_1:AudioAction("play", "voice", "story_v_out_424081", "424081123", "story_v_out_424081.awb")
					end

					arg_520_1:RecordHistoryTalkVoice("story_v_out_424081", "424081123", "story_v_out_424081.awb")
				end

				arg_520_1:RecordContent(arg_520_1.text_.text)
			end

			local var_523_10 = math.max(var_523_1, arg_520_1.talkMaxDuration)

			if var_523_0 <= arg_520_1.time_ and arg_520_1.time_ < var_523_0 + var_523_10 then
				arg_520_1.typewritter.percent = (arg_520_1.time_ - var_523_0) / var_523_10

				arg_520_1.typewritter:SetDirty()
			end

			if arg_520_1.time_ >= var_523_0 + var_523_10 and arg_520_1.time_ < var_523_0 + var_523_10 + arg_523_0 then
				arg_520_1.typewritter.percent = 1

				arg_520_1.typewritter:SetDirty()
				arg_520_1:ShowNextGo(true)
			end
		end

		arg_520_1.nodeConfigList_ = {}

		arg_520_1:InitPlayNodeList()
	end,
	Play424081124 = function(arg_524_0, arg_524_1)
		arg_524_1.time_ = 0
		arg_524_1.frameCnt_ = 0
		arg_524_1.state_ = "playing"
		arg_524_1.curTalkId_ = 424081124
		arg_524_1.duration_ = 2.4

		local var_524_0 = {
			zh = 1.5,
			ja = 2.4
		}
		local var_524_1 = manager.audio:GetLocalizationFlag()

		if var_524_0[var_524_1] ~= nil then
			arg_524_1.duration_ = var_524_0[var_524_1]
		end

		SetActive(arg_524_1.tipsGo_, false)

		function arg_524_1.onSingleLineFinish_()
			arg_524_1.onSingleLineUpdate_ = nil
			arg_524_1.onSingleLineFinish_ = nil
			arg_524_1.state_ = "waiting"
		end

		function arg_524_1.playNext_(arg_526_0)
			if arg_526_0 == 1 then
				arg_524_0:Play424081125(arg_524_1)
			end
		end

		function arg_524_1.onSingleLineUpdate_(arg_527_0)
			local var_527_0 = 0
			local var_527_1 = 0.2

			if var_527_0 < arg_524_1.time_ and arg_524_1.time_ <= var_527_0 + arg_527_0 then
				arg_524_1.talkMaxDuration = 0
				arg_524_1.dialogCg_.alpha = 1

				arg_524_1.dialog_:SetActive(true)
				SetActive(arg_524_1.leftNameGo_, true)

				local var_527_2 = arg_524_1:FormatText(StoryNameCfg[1408].name)

				arg_524_1.leftNameTxt_.text = var_527_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_524_1.leftNameTxt_.transform)

				arg_524_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_524_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_524_1:RecordName(arg_524_1.leftNameTxt_.text)
				SetActive(arg_524_1.iconTrs_.gameObject, false)
				arg_524_1.callingController_:SetSelectedState("normal")

				local var_527_3 = arg_524_1:GetWordFromCfg(424081124)
				local var_527_4 = arg_524_1:FormatText(var_527_3.content)

				arg_524_1.text_.text = var_527_4

				LuaForUtil.ClearLinePrefixSymbol(arg_524_1.text_)

				local var_527_5 = 8
				local var_527_6 = utf8.len(var_527_4)
				local var_527_7 = var_527_5 <= 0 and var_527_1 or var_527_1 * (var_527_6 / var_527_5)

				if var_527_7 > 0 and var_527_1 < var_527_7 then
					arg_524_1.talkMaxDuration = var_527_7

					if var_527_7 + var_527_0 > arg_524_1.duration_ then
						arg_524_1.duration_ = var_527_7 + var_527_0
					end
				end

				arg_524_1.text_.text = var_527_4
				arg_524_1.typewritter.percent = 0

				arg_524_1.typewritter:SetDirty()
				arg_524_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424081", "424081124", "story_v_out_424081.awb") ~= 0 then
					local var_527_8 = manager.audio:GetVoiceLength("story_v_out_424081", "424081124", "story_v_out_424081.awb") / 1000

					if var_527_8 + var_527_0 > arg_524_1.duration_ then
						arg_524_1.duration_ = var_527_8 + var_527_0
					end

					if var_527_3.prefab_name ~= "" and arg_524_1.actors_[var_527_3.prefab_name] ~= nil then
						local var_527_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_524_1.actors_[var_527_3.prefab_name].transform, "story_v_out_424081", "424081124", "story_v_out_424081.awb")

						arg_524_1:RecordAudio("424081124", var_527_9)
						arg_524_1:RecordAudio("424081124", var_527_9)
					else
						arg_524_1:AudioAction("play", "voice", "story_v_out_424081", "424081124", "story_v_out_424081.awb")
					end

					arg_524_1:RecordHistoryTalkVoice("story_v_out_424081", "424081124", "story_v_out_424081.awb")
				end

				arg_524_1:RecordContent(arg_524_1.text_.text)
			end

			local var_527_10 = math.max(var_527_1, arg_524_1.talkMaxDuration)

			if var_527_0 <= arg_524_1.time_ and arg_524_1.time_ < var_527_0 + var_527_10 then
				arg_524_1.typewritter.percent = (arg_524_1.time_ - var_527_0) / var_527_10

				arg_524_1.typewritter:SetDirty()
			end

			if arg_524_1.time_ >= var_527_0 + var_527_10 and arg_524_1.time_ < var_527_0 + var_527_10 + arg_527_0 then
				arg_524_1.typewritter.percent = 1

				arg_524_1.typewritter:SetDirty()
				arg_524_1:ShowNextGo(true)
			end
		end

		arg_524_1.nodeConfigList_ = {}

		arg_524_1:InitPlayNodeList()
	end,
	Play424081125 = function(arg_528_0, arg_528_1)
		arg_528_1.time_ = 0
		arg_528_1.frameCnt_ = 0
		arg_528_1.state_ = "playing"
		arg_528_1.curTalkId_ = 424081125
		arg_528_1.duration_ = 6.27

		local var_528_0 = {
			zh = 5,
			ja = 6.266
		}
		local var_528_1 = manager.audio:GetLocalizationFlag()

		if var_528_0[var_528_1] ~= nil then
			arg_528_1.duration_ = var_528_0[var_528_1]
		end

		SetActive(arg_528_1.tipsGo_, false)

		function arg_528_1.onSingleLineFinish_()
			arg_528_1.onSingleLineUpdate_ = nil
			arg_528_1.onSingleLineFinish_ = nil
			arg_528_1.state_ = "waiting"
		end

		function arg_528_1.playNext_(arg_530_0)
			if arg_530_0 == 1 then
				arg_528_0:Play424081126(arg_528_1)
			end
		end

		function arg_528_1.onSingleLineUpdate_(arg_531_0)
			local var_531_0 = 0
			local var_531_1 = 0.45

			if var_531_0 < arg_528_1.time_ and arg_528_1.time_ <= var_531_0 + arg_531_0 then
				arg_528_1.talkMaxDuration = 0
				arg_528_1.dialogCg_.alpha = 1

				arg_528_1.dialog_:SetActive(true)
				SetActive(arg_528_1.leftNameGo_, true)

				local var_531_2 = arg_528_1:FormatText(StoryNameCfg[181].name)

				arg_528_1.leftNameTxt_.text = var_531_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_528_1.leftNameTxt_.transform)

				arg_528_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_528_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_528_1:RecordName(arg_528_1.leftNameTxt_.text)
				SetActive(arg_528_1.iconTrs_.gameObject, false)
				arg_528_1.callingController_:SetSelectedState("normal")

				local var_531_3 = arg_528_1:GetWordFromCfg(424081125)
				local var_531_4 = arg_528_1:FormatText(var_531_3.content)

				arg_528_1.text_.text = var_531_4

				LuaForUtil.ClearLinePrefixSymbol(arg_528_1.text_)

				local var_531_5 = 18
				local var_531_6 = utf8.len(var_531_4)
				local var_531_7 = var_531_5 <= 0 and var_531_1 or var_531_1 * (var_531_6 / var_531_5)

				if var_531_7 > 0 and var_531_1 < var_531_7 then
					arg_528_1.talkMaxDuration = var_531_7

					if var_531_7 + var_531_0 > arg_528_1.duration_ then
						arg_528_1.duration_ = var_531_7 + var_531_0
					end
				end

				arg_528_1.text_.text = var_531_4
				arg_528_1.typewritter.percent = 0

				arg_528_1.typewritter:SetDirty()
				arg_528_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424081", "424081125", "story_v_out_424081.awb") ~= 0 then
					local var_531_8 = manager.audio:GetVoiceLength("story_v_out_424081", "424081125", "story_v_out_424081.awb") / 1000

					if var_531_8 + var_531_0 > arg_528_1.duration_ then
						arg_528_1.duration_ = var_531_8 + var_531_0
					end

					if var_531_3.prefab_name ~= "" and arg_528_1.actors_[var_531_3.prefab_name] ~= nil then
						local var_531_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_528_1.actors_[var_531_3.prefab_name].transform, "story_v_out_424081", "424081125", "story_v_out_424081.awb")

						arg_528_1:RecordAudio("424081125", var_531_9)
						arg_528_1:RecordAudio("424081125", var_531_9)
					else
						arg_528_1:AudioAction("play", "voice", "story_v_out_424081", "424081125", "story_v_out_424081.awb")
					end

					arg_528_1:RecordHistoryTalkVoice("story_v_out_424081", "424081125", "story_v_out_424081.awb")
				end

				arg_528_1:RecordContent(arg_528_1.text_.text)
			end

			local var_531_10 = math.max(var_531_1, arg_528_1.talkMaxDuration)

			if var_531_0 <= arg_528_1.time_ and arg_528_1.time_ < var_531_0 + var_531_10 then
				arg_528_1.typewritter.percent = (arg_528_1.time_ - var_531_0) / var_531_10

				arg_528_1.typewritter:SetDirty()
			end

			if arg_528_1.time_ >= var_531_0 + var_531_10 and arg_528_1.time_ < var_531_0 + var_531_10 + arg_531_0 then
				arg_528_1.typewritter.percent = 1

				arg_528_1.typewritter:SetDirty()
				arg_528_1:ShowNextGo(true)
			end
		end

		arg_528_1.nodeConfigList_ = {}

		arg_528_1:InitPlayNodeList()
	end,
	Play424081126 = function(arg_532_0, arg_532_1)
		arg_532_1.time_ = 0
		arg_532_1.frameCnt_ = 0
		arg_532_1.state_ = "playing"
		arg_532_1.curTalkId_ = 424081126
		arg_532_1.duration_ = 5

		SetActive(arg_532_1.tipsGo_, false)

		function arg_532_1.onSingleLineFinish_()
			arg_532_1.onSingleLineUpdate_ = nil
			arg_532_1.onSingleLineFinish_ = nil
			arg_532_1.state_ = "waiting"
		end

		function arg_532_1.playNext_(arg_534_0)
			if arg_534_0 == 1 then
				arg_532_0:Play424081127(arg_532_1)
			end
		end

		function arg_532_1.onSingleLineUpdate_(arg_535_0)
			local var_535_0 = 0
			local var_535_1 = 0.675

			if var_535_0 < arg_532_1.time_ and arg_532_1.time_ <= var_535_0 + arg_535_0 then
				arg_532_1.talkMaxDuration = 0
				arg_532_1.dialogCg_.alpha = 1

				arg_532_1.dialog_:SetActive(true)
				SetActive(arg_532_1.leftNameGo_, true)

				local var_535_2 = arg_532_1:FormatText(StoryNameCfg[7].name)

				arg_532_1.leftNameTxt_.text = var_535_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_532_1.leftNameTxt_.transform)

				arg_532_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_532_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_532_1:RecordName(arg_532_1.leftNameTxt_.text)
				SetActive(arg_532_1.iconTrs_.gameObject, true)
				arg_532_1.iconController_:SetSelectedState("hero")

				arg_532_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_532_1.callingController_:SetSelectedState("normal")

				arg_532_1.keyicon_.color = Color.New(1, 1, 1)
				arg_532_1.icon_.color = Color.New(1, 1, 1)

				local var_535_3 = arg_532_1:GetWordFromCfg(424081126)
				local var_535_4 = arg_532_1:FormatText(var_535_3.content)

				arg_532_1.text_.text = var_535_4

				LuaForUtil.ClearLinePrefixSymbol(arg_532_1.text_)

				local var_535_5 = 27
				local var_535_6 = utf8.len(var_535_4)
				local var_535_7 = var_535_5 <= 0 and var_535_1 or var_535_1 * (var_535_6 / var_535_5)

				if var_535_7 > 0 and var_535_1 < var_535_7 then
					arg_532_1.talkMaxDuration = var_535_7

					if var_535_7 + var_535_0 > arg_532_1.duration_ then
						arg_532_1.duration_ = var_535_7 + var_535_0
					end
				end

				arg_532_1.text_.text = var_535_4
				arg_532_1.typewritter.percent = 0

				arg_532_1.typewritter:SetDirty()
				arg_532_1:ShowNextGo(false)
				arg_532_1:RecordContent(arg_532_1.text_.text)
			end

			local var_535_8 = math.max(var_535_1, arg_532_1.talkMaxDuration)

			if var_535_0 <= arg_532_1.time_ and arg_532_1.time_ < var_535_0 + var_535_8 then
				arg_532_1.typewritter.percent = (arg_532_1.time_ - var_535_0) / var_535_8

				arg_532_1.typewritter:SetDirty()
			end

			if arg_532_1.time_ >= var_535_0 + var_535_8 and arg_532_1.time_ < var_535_0 + var_535_8 + arg_535_0 then
				arg_532_1.typewritter.percent = 1

				arg_532_1.typewritter:SetDirty()
				arg_532_1:ShowNextGo(true)
			end
		end

		arg_532_1.nodeConfigList_ = {}

		arg_532_1:InitPlayNodeList()
	end,
	Play424081127 = function(arg_536_0, arg_536_1)
		arg_536_1.time_ = 0
		arg_536_1.frameCnt_ = 0
		arg_536_1.state_ = "playing"
		arg_536_1.curTalkId_ = 424081127
		arg_536_1.duration_ = 3.1

		local var_536_0 = {
			zh = 2.4,
			ja = 3.1
		}
		local var_536_1 = manager.audio:GetLocalizationFlag()

		if var_536_0[var_536_1] ~= nil then
			arg_536_1.duration_ = var_536_0[var_536_1]
		end

		SetActive(arg_536_1.tipsGo_, false)

		function arg_536_1.onSingleLineFinish_()
			arg_536_1.onSingleLineUpdate_ = nil
			arg_536_1.onSingleLineFinish_ = nil
			arg_536_1.state_ = "waiting"
		end

		function arg_536_1.playNext_(arg_538_0)
			if arg_538_0 == 1 then
				arg_536_0:Play424081128(arg_536_1)
			end
		end

		function arg_536_1.onSingleLineUpdate_(arg_539_0)
			local var_539_0 = 0
			local var_539_1 = 0.2

			if var_539_0 < arg_536_1.time_ and arg_536_1.time_ <= var_539_0 + arg_539_0 then
				arg_536_1.talkMaxDuration = 0
				arg_536_1.dialogCg_.alpha = 1

				arg_536_1.dialog_:SetActive(true)
				SetActive(arg_536_1.leftNameGo_, true)

				local var_539_2 = arg_536_1:FormatText(StoryNameCfg[1404].name)

				arg_536_1.leftNameTxt_.text = var_539_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_536_1.leftNameTxt_.transform)

				arg_536_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_536_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_536_1:RecordName(arg_536_1.leftNameTxt_.text)
				SetActive(arg_536_1.iconTrs_.gameObject, true)
				arg_536_1.iconController_:SetSelectedState("hero")

				arg_536_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_littleboya")

				arg_536_1.callingController_:SetSelectedState("normal")

				arg_536_1.keyicon_.color = Color.New(1, 1, 1)
				arg_536_1.icon_.color = Color.New(1, 1, 1)

				local var_539_3 = arg_536_1:GetWordFromCfg(424081127)
				local var_539_4 = arg_536_1:FormatText(var_539_3.content)

				arg_536_1.text_.text = var_539_4

				LuaForUtil.ClearLinePrefixSymbol(arg_536_1.text_)

				local var_539_5 = 8
				local var_539_6 = utf8.len(var_539_4)
				local var_539_7 = var_539_5 <= 0 and var_539_1 or var_539_1 * (var_539_6 / var_539_5)

				if var_539_7 > 0 and var_539_1 < var_539_7 then
					arg_536_1.talkMaxDuration = var_539_7

					if var_539_7 + var_539_0 > arg_536_1.duration_ then
						arg_536_1.duration_ = var_539_7 + var_539_0
					end
				end

				arg_536_1.text_.text = var_539_4
				arg_536_1.typewritter.percent = 0

				arg_536_1.typewritter:SetDirty()
				arg_536_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424081", "424081127", "story_v_out_424081.awb") ~= 0 then
					local var_539_8 = manager.audio:GetVoiceLength("story_v_out_424081", "424081127", "story_v_out_424081.awb") / 1000

					if var_539_8 + var_539_0 > arg_536_1.duration_ then
						arg_536_1.duration_ = var_539_8 + var_539_0
					end

					if var_539_3.prefab_name ~= "" and arg_536_1.actors_[var_539_3.prefab_name] ~= nil then
						local var_539_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_536_1.actors_[var_539_3.prefab_name].transform, "story_v_out_424081", "424081127", "story_v_out_424081.awb")

						arg_536_1:RecordAudio("424081127", var_539_9)
						arg_536_1:RecordAudio("424081127", var_539_9)
					else
						arg_536_1:AudioAction("play", "voice", "story_v_out_424081", "424081127", "story_v_out_424081.awb")
					end

					arg_536_1:RecordHistoryTalkVoice("story_v_out_424081", "424081127", "story_v_out_424081.awb")
				end

				arg_536_1:RecordContent(arg_536_1.text_.text)
			end

			local var_539_10 = math.max(var_539_1, arg_536_1.talkMaxDuration)

			if var_539_0 <= arg_536_1.time_ and arg_536_1.time_ < var_539_0 + var_539_10 then
				arg_536_1.typewritter.percent = (arg_536_1.time_ - var_539_0) / var_539_10

				arg_536_1.typewritter:SetDirty()
			end

			if arg_536_1.time_ >= var_539_0 + var_539_10 and arg_536_1.time_ < var_539_0 + var_539_10 + arg_539_0 then
				arg_536_1.typewritter.percent = 1

				arg_536_1.typewritter:SetDirty()
				arg_536_1:ShowNextGo(true)
			end
		end

		arg_536_1.nodeConfigList_ = {}

		arg_536_1:InitPlayNodeList()
	end,
	Play424081128 = function(arg_540_0, arg_540_1)
		arg_540_1.time_ = 0
		arg_540_1.frameCnt_ = 0
		arg_540_1.state_ = "playing"
		arg_540_1.curTalkId_ = 424081128
		arg_540_1.duration_ = 4.8

		local var_540_0 = {
			zh = 2.4,
			ja = 4.8
		}
		local var_540_1 = manager.audio:GetLocalizationFlag()

		if var_540_0[var_540_1] ~= nil then
			arg_540_1.duration_ = var_540_0[var_540_1]
		end

		SetActive(arg_540_1.tipsGo_, false)

		function arg_540_1.onSingleLineFinish_()
			arg_540_1.onSingleLineUpdate_ = nil
			arg_540_1.onSingleLineFinish_ = nil
			arg_540_1.state_ = "waiting"
		end

		function arg_540_1.playNext_(arg_542_0)
			if arg_542_0 == 1 then
				arg_540_0:Play424081129(arg_540_1)
			end
		end

		function arg_540_1.onSingleLineUpdate_(arg_543_0)
			local var_543_0 = 0
			local var_543_1 = 0.3

			if var_543_0 < arg_540_1.time_ and arg_540_1.time_ <= var_543_0 + arg_543_0 then
				arg_540_1.talkMaxDuration = 0
				arg_540_1.dialogCg_.alpha = 1

				arg_540_1.dialog_:SetActive(true)
				SetActive(arg_540_1.leftNameGo_, true)

				local var_543_2 = arg_540_1:FormatText(StoryNameCfg[181].name)

				arg_540_1.leftNameTxt_.text = var_543_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_540_1.leftNameTxt_.transform)

				arg_540_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_540_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_540_1:RecordName(arg_540_1.leftNameTxt_.text)
				SetActive(arg_540_1.iconTrs_.gameObject, false)
				arg_540_1.callingController_:SetSelectedState("normal")

				local var_543_3 = arg_540_1:GetWordFromCfg(424081128)
				local var_543_4 = arg_540_1:FormatText(var_543_3.content)

				arg_540_1.text_.text = var_543_4

				LuaForUtil.ClearLinePrefixSymbol(arg_540_1.text_)

				local var_543_5 = 12
				local var_543_6 = utf8.len(var_543_4)
				local var_543_7 = var_543_5 <= 0 and var_543_1 or var_543_1 * (var_543_6 / var_543_5)

				if var_543_7 > 0 and var_543_1 < var_543_7 then
					arg_540_1.talkMaxDuration = var_543_7

					if var_543_7 + var_543_0 > arg_540_1.duration_ then
						arg_540_1.duration_ = var_543_7 + var_543_0
					end
				end

				arg_540_1.text_.text = var_543_4
				arg_540_1.typewritter.percent = 0

				arg_540_1.typewritter:SetDirty()
				arg_540_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424081", "424081128", "story_v_out_424081.awb") ~= 0 then
					local var_543_8 = manager.audio:GetVoiceLength("story_v_out_424081", "424081128", "story_v_out_424081.awb") / 1000

					if var_543_8 + var_543_0 > arg_540_1.duration_ then
						arg_540_1.duration_ = var_543_8 + var_543_0
					end

					if var_543_3.prefab_name ~= "" and arg_540_1.actors_[var_543_3.prefab_name] ~= nil then
						local var_543_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_540_1.actors_[var_543_3.prefab_name].transform, "story_v_out_424081", "424081128", "story_v_out_424081.awb")

						arg_540_1:RecordAudio("424081128", var_543_9)
						arg_540_1:RecordAudio("424081128", var_543_9)
					else
						arg_540_1:AudioAction("play", "voice", "story_v_out_424081", "424081128", "story_v_out_424081.awb")
					end

					arg_540_1:RecordHistoryTalkVoice("story_v_out_424081", "424081128", "story_v_out_424081.awb")
				end

				arg_540_1:RecordContent(arg_540_1.text_.text)
			end

			local var_543_10 = math.max(var_543_1, arg_540_1.talkMaxDuration)

			if var_543_0 <= arg_540_1.time_ and arg_540_1.time_ < var_543_0 + var_543_10 then
				arg_540_1.typewritter.percent = (arg_540_1.time_ - var_543_0) / var_543_10

				arg_540_1.typewritter:SetDirty()
			end

			if arg_540_1.time_ >= var_543_0 + var_543_10 and arg_540_1.time_ < var_543_0 + var_543_10 + arg_543_0 then
				arg_540_1.typewritter.percent = 1

				arg_540_1.typewritter:SetDirty()
				arg_540_1:ShowNextGo(true)
			end
		end

		arg_540_1.nodeConfigList_ = {}

		arg_540_1:InitPlayNodeList()
	end,
	Play424081129 = function(arg_544_0, arg_544_1)
		arg_544_1.time_ = 0
		arg_544_1.frameCnt_ = 0
		arg_544_1.state_ = "playing"
		arg_544_1.curTalkId_ = 424081129
		arg_544_1.duration_ = 9.67

		local var_544_0 = {
			zh = 4.566,
			ja = 9.666
		}
		local var_544_1 = manager.audio:GetLocalizationFlag()

		if var_544_0[var_544_1] ~= nil then
			arg_544_1.duration_ = var_544_0[var_544_1]
		end

		SetActive(arg_544_1.tipsGo_, false)

		function arg_544_1.onSingleLineFinish_()
			arg_544_1.onSingleLineUpdate_ = nil
			arg_544_1.onSingleLineFinish_ = nil
			arg_544_1.state_ = "waiting"
		end

		function arg_544_1.playNext_(arg_546_0)
			if arg_546_0 == 1 then
				arg_544_0:Play424081130(arg_544_1)
			end
		end

		function arg_544_1.onSingleLineUpdate_(arg_547_0)
			local var_547_0 = 0
			local var_547_1 = 0.425

			if var_547_0 < arg_544_1.time_ and arg_544_1.time_ <= var_547_0 + arg_547_0 then
				arg_544_1.talkMaxDuration = 0
				arg_544_1.dialogCg_.alpha = 1

				arg_544_1.dialog_:SetActive(true)
				SetActive(arg_544_1.leftNameGo_, true)

				local var_547_2 = arg_544_1:FormatText(StoryNameCfg[1404].name)

				arg_544_1.leftNameTxt_.text = var_547_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_544_1.leftNameTxt_.transform)

				arg_544_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_544_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_544_1:RecordName(arg_544_1.leftNameTxt_.text)
				SetActive(arg_544_1.iconTrs_.gameObject, true)
				arg_544_1.iconController_:SetSelectedState("hero")

				arg_544_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_littleboya")

				arg_544_1.callingController_:SetSelectedState("normal")

				arg_544_1.keyicon_.color = Color.New(1, 1, 1)
				arg_544_1.icon_.color = Color.New(1, 1, 1)

				local var_547_3 = arg_544_1:GetWordFromCfg(424081129)
				local var_547_4 = arg_544_1:FormatText(var_547_3.content)

				arg_544_1.text_.text = var_547_4

				LuaForUtil.ClearLinePrefixSymbol(arg_544_1.text_)

				local var_547_5 = 17
				local var_547_6 = utf8.len(var_547_4)
				local var_547_7 = var_547_5 <= 0 and var_547_1 or var_547_1 * (var_547_6 / var_547_5)

				if var_547_7 > 0 and var_547_1 < var_547_7 then
					arg_544_1.talkMaxDuration = var_547_7

					if var_547_7 + var_547_0 > arg_544_1.duration_ then
						arg_544_1.duration_ = var_547_7 + var_547_0
					end
				end

				arg_544_1.text_.text = var_547_4
				arg_544_1.typewritter.percent = 0

				arg_544_1.typewritter:SetDirty()
				arg_544_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424081", "424081129", "story_v_out_424081.awb") ~= 0 then
					local var_547_8 = manager.audio:GetVoiceLength("story_v_out_424081", "424081129", "story_v_out_424081.awb") / 1000

					if var_547_8 + var_547_0 > arg_544_1.duration_ then
						arg_544_1.duration_ = var_547_8 + var_547_0
					end

					if var_547_3.prefab_name ~= "" and arg_544_1.actors_[var_547_3.prefab_name] ~= nil then
						local var_547_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_544_1.actors_[var_547_3.prefab_name].transform, "story_v_out_424081", "424081129", "story_v_out_424081.awb")

						arg_544_1:RecordAudio("424081129", var_547_9)
						arg_544_1:RecordAudio("424081129", var_547_9)
					else
						arg_544_1:AudioAction("play", "voice", "story_v_out_424081", "424081129", "story_v_out_424081.awb")
					end

					arg_544_1:RecordHistoryTalkVoice("story_v_out_424081", "424081129", "story_v_out_424081.awb")
				end

				arg_544_1:RecordContent(arg_544_1.text_.text)
			end

			local var_547_10 = math.max(var_547_1, arg_544_1.talkMaxDuration)

			if var_547_0 <= arg_544_1.time_ and arg_544_1.time_ < var_547_0 + var_547_10 then
				arg_544_1.typewritter.percent = (arg_544_1.time_ - var_547_0) / var_547_10

				arg_544_1.typewritter:SetDirty()
			end

			if arg_544_1.time_ >= var_547_0 + var_547_10 and arg_544_1.time_ < var_547_0 + var_547_10 + arg_547_0 then
				arg_544_1.typewritter.percent = 1

				arg_544_1.typewritter:SetDirty()
				arg_544_1:ShowNextGo(true)
			end
		end

		arg_544_1.nodeConfigList_ = {}

		arg_544_1:InitPlayNodeList()
	end,
	Play424081130 = function(arg_548_0, arg_548_1)
		arg_548_1.time_ = 0
		arg_548_1.frameCnt_ = 0
		arg_548_1.state_ = "playing"
		arg_548_1.curTalkId_ = 424081130
		arg_548_1.duration_ = 3.97

		local var_548_0 = {
			zh = 2.6,
			ja = 3.966
		}
		local var_548_1 = manager.audio:GetLocalizationFlag()

		if var_548_0[var_548_1] ~= nil then
			arg_548_1.duration_ = var_548_0[var_548_1]
		end

		SetActive(arg_548_1.tipsGo_, false)

		function arg_548_1.onSingleLineFinish_()
			arg_548_1.onSingleLineUpdate_ = nil
			arg_548_1.onSingleLineFinish_ = nil
			arg_548_1.state_ = "waiting"
		end

		function arg_548_1.playNext_(arg_550_0)
			if arg_550_0 == 1 then
				arg_548_0:Play424081131(arg_548_1)
			end
		end

		function arg_548_1.onSingleLineUpdate_(arg_551_0)
			local var_551_0 = 0
			local var_551_1 = 0.225

			if var_551_0 < arg_548_1.time_ and arg_548_1.time_ <= var_551_0 + arg_551_0 then
				arg_548_1.talkMaxDuration = 0
				arg_548_1.dialogCg_.alpha = 1

				arg_548_1.dialog_:SetActive(true)
				SetActive(arg_548_1.leftNameGo_, true)

				local var_551_2 = arg_548_1:FormatText(StoryNameCfg[1407].name)

				arg_548_1.leftNameTxt_.text = var_551_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_548_1.leftNameTxt_.transform)

				arg_548_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_548_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_548_1:RecordName(arg_548_1.leftNameTxt_.text)
				SetActive(arg_548_1.iconTrs_.gameObject, true)
				arg_548_1.iconController_:SetSelectedState("hero")

				arg_548_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowstudentwa")

				arg_548_1.callingController_:SetSelectedState("normal")

				arg_548_1.keyicon_.color = Color.New(1, 1, 1)
				arg_548_1.icon_.color = Color.New(1, 1, 1)

				local var_551_3 = arg_548_1:GetWordFromCfg(424081130)
				local var_551_4 = arg_548_1:FormatText(var_551_3.content)

				arg_548_1.text_.text = var_551_4

				LuaForUtil.ClearLinePrefixSymbol(arg_548_1.text_)

				local var_551_5 = 9
				local var_551_6 = utf8.len(var_551_4)
				local var_551_7 = var_551_5 <= 0 and var_551_1 or var_551_1 * (var_551_6 / var_551_5)

				if var_551_7 > 0 and var_551_1 < var_551_7 then
					arg_548_1.talkMaxDuration = var_551_7

					if var_551_7 + var_551_0 > arg_548_1.duration_ then
						arg_548_1.duration_ = var_551_7 + var_551_0
					end
				end

				arg_548_1.text_.text = var_551_4
				arg_548_1.typewritter.percent = 0

				arg_548_1.typewritter:SetDirty()
				arg_548_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424081", "424081130", "story_v_out_424081.awb") ~= 0 then
					local var_551_8 = manager.audio:GetVoiceLength("story_v_out_424081", "424081130", "story_v_out_424081.awb") / 1000

					if var_551_8 + var_551_0 > arg_548_1.duration_ then
						arg_548_1.duration_ = var_551_8 + var_551_0
					end

					if var_551_3.prefab_name ~= "" and arg_548_1.actors_[var_551_3.prefab_name] ~= nil then
						local var_551_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_548_1.actors_[var_551_3.prefab_name].transform, "story_v_out_424081", "424081130", "story_v_out_424081.awb")

						arg_548_1:RecordAudio("424081130", var_551_9)
						arg_548_1:RecordAudio("424081130", var_551_9)
					else
						arg_548_1:AudioAction("play", "voice", "story_v_out_424081", "424081130", "story_v_out_424081.awb")
					end

					arg_548_1:RecordHistoryTalkVoice("story_v_out_424081", "424081130", "story_v_out_424081.awb")
				end

				arg_548_1:RecordContent(arg_548_1.text_.text)
			end

			local var_551_10 = math.max(var_551_1, arg_548_1.talkMaxDuration)

			if var_551_0 <= arg_548_1.time_ and arg_548_1.time_ < var_551_0 + var_551_10 then
				arg_548_1.typewritter.percent = (arg_548_1.time_ - var_551_0) / var_551_10

				arg_548_1.typewritter:SetDirty()
			end

			if arg_548_1.time_ >= var_551_0 + var_551_10 and arg_548_1.time_ < var_551_0 + var_551_10 + arg_551_0 then
				arg_548_1.typewritter.percent = 1

				arg_548_1.typewritter:SetDirty()
				arg_548_1:ShowNextGo(true)
			end
		end

		arg_548_1.nodeConfigList_ = {}

		arg_548_1:InitPlayNodeList()
	end,
	Play424081131 = function(arg_552_0, arg_552_1)
		arg_552_1.time_ = 0
		arg_552_1.frameCnt_ = 0
		arg_552_1.state_ = "playing"
		arg_552_1.curTalkId_ = 424081131
		arg_552_1.duration_ = 8.47

		local var_552_0 = {
			zh = 6,
			ja = 8.466
		}
		local var_552_1 = manager.audio:GetLocalizationFlag()

		if var_552_0[var_552_1] ~= nil then
			arg_552_1.duration_ = var_552_0[var_552_1]
		end

		SetActive(arg_552_1.tipsGo_, false)

		function arg_552_1.onSingleLineFinish_()
			arg_552_1.onSingleLineUpdate_ = nil
			arg_552_1.onSingleLineFinish_ = nil
			arg_552_1.state_ = "waiting"
		end

		function arg_552_1.playNext_(arg_554_0)
			if arg_554_0 == 1 then
				arg_552_0:Play424081132(arg_552_1)
			end
		end

		function arg_552_1.onSingleLineUpdate_(arg_555_0)
			local var_555_0 = 0
			local var_555_1 = 0.775

			if var_555_0 < arg_552_1.time_ and arg_552_1.time_ <= var_555_0 + arg_555_0 then
				arg_552_1.talkMaxDuration = 0
				arg_552_1.dialogCg_.alpha = 1

				arg_552_1.dialog_:SetActive(true)
				SetActive(arg_552_1.leftNameGo_, true)

				local var_555_2 = arg_552_1:FormatText(StoryNameCfg[1393].name)

				arg_552_1.leftNameTxt_.text = var_555_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_552_1.leftNameTxt_.transform)

				arg_552_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_552_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_552_1:RecordName(arg_552_1.leftNameTxt_.text)
				SetActive(arg_552_1.iconTrs_.gameObject, true)
				arg_552_1.iconController_:SetSelectedState("hero")

				arg_552_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lolia")

				arg_552_1.callingController_:SetSelectedState("normal")

				arg_552_1.keyicon_.color = Color.New(1, 1, 1)
				arg_552_1.icon_.color = Color.New(1, 1, 1)

				local var_555_3 = arg_552_1:GetWordFromCfg(424081131)
				local var_555_4 = arg_552_1:FormatText(var_555_3.content)

				arg_552_1.text_.text = var_555_4

				LuaForUtil.ClearLinePrefixSymbol(arg_552_1.text_)

				local var_555_5 = 31
				local var_555_6 = utf8.len(var_555_4)
				local var_555_7 = var_555_5 <= 0 and var_555_1 or var_555_1 * (var_555_6 / var_555_5)

				if var_555_7 > 0 and var_555_1 < var_555_7 then
					arg_552_1.talkMaxDuration = var_555_7

					if var_555_7 + var_555_0 > arg_552_1.duration_ then
						arg_552_1.duration_ = var_555_7 + var_555_0
					end
				end

				arg_552_1.text_.text = var_555_4
				arg_552_1.typewritter.percent = 0

				arg_552_1.typewritter:SetDirty()
				arg_552_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424081", "424081131", "story_v_out_424081.awb") ~= 0 then
					local var_555_8 = manager.audio:GetVoiceLength("story_v_out_424081", "424081131", "story_v_out_424081.awb") / 1000

					if var_555_8 + var_555_0 > arg_552_1.duration_ then
						arg_552_1.duration_ = var_555_8 + var_555_0
					end

					if var_555_3.prefab_name ~= "" and arg_552_1.actors_[var_555_3.prefab_name] ~= nil then
						local var_555_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_552_1.actors_[var_555_3.prefab_name].transform, "story_v_out_424081", "424081131", "story_v_out_424081.awb")

						arg_552_1:RecordAudio("424081131", var_555_9)
						arg_552_1:RecordAudio("424081131", var_555_9)
					else
						arg_552_1:AudioAction("play", "voice", "story_v_out_424081", "424081131", "story_v_out_424081.awb")
					end

					arg_552_1:RecordHistoryTalkVoice("story_v_out_424081", "424081131", "story_v_out_424081.awb")
				end

				arg_552_1:RecordContent(arg_552_1.text_.text)
			end

			local var_555_10 = math.max(var_555_1, arg_552_1.talkMaxDuration)

			if var_555_0 <= arg_552_1.time_ and arg_552_1.time_ < var_555_0 + var_555_10 then
				arg_552_1.typewritter.percent = (arg_552_1.time_ - var_555_0) / var_555_10

				arg_552_1.typewritter:SetDirty()
			end

			if arg_552_1.time_ >= var_555_0 + var_555_10 and arg_552_1.time_ < var_555_0 + var_555_10 + arg_555_0 then
				arg_552_1.typewritter.percent = 1

				arg_552_1.typewritter:SetDirty()
				arg_552_1:ShowNextGo(true)
			end
		end

		arg_552_1.nodeConfigList_ = {}

		arg_552_1:InitPlayNodeList()
	end,
	Play424081132 = function(arg_556_0, arg_556_1)
		arg_556_1.time_ = 0
		arg_556_1.frameCnt_ = 0
		arg_556_1.state_ = "playing"
		arg_556_1.curTalkId_ = 424081132
		arg_556_1.duration_ = 5

		SetActive(arg_556_1.tipsGo_, false)

		function arg_556_1.onSingleLineFinish_()
			arg_556_1.onSingleLineUpdate_ = nil
			arg_556_1.onSingleLineFinish_ = nil
			arg_556_1.state_ = "waiting"
		end

		function arg_556_1.playNext_(arg_558_0)
			if arg_558_0 == 1 then
				arg_556_0:Play424081133(arg_556_1)
			end
		end

		function arg_556_1.onSingleLineUpdate_(arg_559_0)
			local var_559_0 = 0
			local var_559_1 = 0.725

			if var_559_0 < arg_556_1.time_ and arg_556_1.time_ <= var_559_0 + arg_559_0 then
				arg_556_1.talkMaxDuration = 0
				arg_556_1.dialogCg_.alpha = 1

				arg_556_1.dialog_:SetActive(true)
				SetActive(arg_556_1.leftNameGo_, false)

				arg_556_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_556_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_556_1:RecordName(arg_556_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_556_1.iconTrs_.gameObject, false)
				arg_556_1.callingController_:SetSelectedState("normal")

				local var_559_2 = arg_556_1:GetWordFromCfg(424081132)
				local var_559_3 = arg_556_1:FormatText(var_559_2.content)

				arg_556_1.text_.text = var_559_3

				LuaForUtil.ClearLinePrefixSymbol(arg_556_1.text_)

				local var_559_4 = 29
				local var_559_5 = utf8.len(var_559_3)
				local var_559_6 = var_559_4 <= 0 and var_559_1 or var_559_1 * (var_559_5 / var_559_4)

				if var_559_6 > 0 and var_559_1 < var_559_6 then
					arg_556_1.talkMaxDuration = var_559_6

					if var_559_6 + var_559_0 > arg_556_1.duration_ then
						arg_556_1.duration_ = var_559_6 + var_559_0
					end
				end

				arg_556_1.text_.text = var_559_3
				arg_556_1.typewritter.percent = 0

				arg_556_1.typewritter:SetDirty()
				arg_556_1:ShowNextGo(false)
				arg_556_1:RecordContent(arg_556_1.text_.text)
			end

			local var_559_7 = math.max(var_559_1, arg_556_1.talkMaxDuration)

			if var_559_0 <= arg_556_1.time_ and arg_556_1.time_ < var_559_0 + var_559_7 then
				arg_556_1.typewritter.percent = (arg_556_1.time_ - var_559_0) / var_559_7

				arg_556_1.typewritter:SetDirty()
			end

			if arg_556_1.time_ >= var_559_0 + var_559_7 and arg_556_1.time_ < var_559_0 + var_559_7 + arg_559_0 then
				arg_556_1.typewritter.percent = 1

				arg_556_1.typewritter:SetDirty()
				arg_556_1:ShowNextGo(true)
			end
		end

		arg_556_1.nodeConfigList_ = {}

		arg_556_1:InitPlayNodeList()
	end,
	Play424081133 = function(arg_560_0, arg_560_1)
		arg_560_1.time_ = 0
		arg_560_1.frameCnt_ = 0
		arg_560_1.state_ = "playing"
		arg_560_1.curTalkId_ = 424081133
		arg_560_1.duration_ = 2.87

		local var_560_0 = {
			zh = 2.1,
			ja = 2.866
		}
		local var_560_1 = manager.audio:GetLocalizationFlag()

		if var_560_0[var_560_1] ~= nil then
			arg_560_1.duration_ = var_560_0[var_560_1]
		end

		SetActive(arg_560_1.tipsGo_, false)

		function arg_560_1.onSingleLineFinish_()
			arg_560_1.onSingleLineUpdate_ = nil
			arg_560_1.onSingleLineFinish_ = nil
			arg_560_1.state_ = "waiting"
		end

		function arg_560_1.playNext_(arg_562_0)
			if arg_562_0 == 1 then
				arg_560_0:Play424081134(arg_560_1)
			end
		end

		function arg_560_1.onSingleLineUpdate_(arg_563_0)
			local var_563_0 = 0
			local var_563_1 = 0.225

			if var_563_0 < arg_560_1.time_ and arg_560_1.time_ <= var_563_0 + arg_563_0 then
				arg_560_1.talkMaxDuration = 0
				arg_560_1.dialogCg_.alpha = 1

				arg_560_1.dialog_:SetActive(true)
				SetActive(arg_560_1.leftNameGo_, true)

				local var_563_2 = arg_560_1:FormatText(StoryNameCfg[1404].name)

				arg_560_1.leftNameTxt_.text = var_563_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_560_1.leftNameTxt_.transform)

				arg_560_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_560_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_560_1:RecordName(arg_560_1.leftNameTxt_.text)
				SetActive(arg_560_1.iconTrs_.gameObject, true)
				arg_560_1.iconController_:SetSelectedState("hero")

				arg_560_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_littleboya")

				arg_560_1.callingController_:SetSelectedState("normal")

				arg_560_1.keyicon_.color = Color.New(1, 1, 1)
				arg_560_1.icon_.color = Color.New(1, 1, 1)

				local var_563_3 = arg_560_1:GetWordFromCfg(424081133)
				local var_563_4 = arg_560_1:FormatText(var_563_3.content)

				arg_560_1.text_.text = var_563_4

				LuaForUtil.ClearLinePrefixSymbol(arg_560_1.text_)

				local var_563_5 = 9
				local var_563_6 = utf8.len(var_563_4)
				local var_563_7 = var_563_5 <= 0 and var_563_1 or var_563_1 * (var_563_6 / var_563_5)

				if var_563_7 > 0 and var_563_1 < var_563_7 then
					arg_560_1.talkMaxDuration = var_563_7

					if var_563_7 + var_563_0 > arg_560_1.duration_ then
						arg_560_1.duration_ = var_563_7 + var_563_0
					end
				end

				arg_560_1.text_.text = var_563_4
				arg_560_1.typewritter.percent = 0

				arg_560_1.typewritter:SetDirty()
				arg_560_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424081", "424081133", "story_v_out_424081.awb") ~= 0 then
					local var_563_8 = manager.audio:GetVoiceLength("story_v_out_424081", "424081133", "story_v_out_424081.awb") / 1000

					if var_563_8 + var_563_0 > arg_560_1.duration_ then
						arg_560_1.duration_ = var_563_8 + var_563_0
					end

					if var_563_3.prefab_name ~= "" and arg_560_1.actors_[var_563_3.prefab_name] ~= nil then
						local var_563_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_560_1.actors_[var_563_3.prefab_name].transform, "story_v_out_424081", "424081133", "story_v_out_424081.awb")

						arg_560_1:RecordAudio("424081133", var_563_9)
						arg_560_1:RecordAudio("424081133", var_563_9)
					else
						arg_560_1:AudioAction("play", "voice", "story_v_out_424081", "424081133", "story_v_out_424081.awb")
					end

					arg_560_1:RecordHistoryTalkVoice("story_v_out_424081", "424081133", "story_v_out_424081.awb")
				end

				arg_560_1:RecordContent(arg_560_1.text_.text)
			end

			local var_563_10 = math.max(var_563_1, arg_560_1.talkMaxDuration)

			if var_563_0 <= arg_560_1.time_ and arg_560_1.time_ < var_563_0 + var_563_10 then
				arg_560_1.typewritter.percent = (arg_560_1.time_ - var_563_0) / var_563_10

				arg_560_1.typewritter:SetDirty()
			end

			if arg_560_1.time_ >= var_563_0 + var_563_10 and arg_560_1.time_ < var_563_0 + var_563_10 + arg_563_0 then
				arg_560_1.typewritter.percent = 1

				arg_560_1.typewritter:SetDirty()
				arg_560_1:ShowNextGo(true)
			end
		end

		arg_560_1.nodeConfigList_ = {}

		arg_560_1:InitPlayNodeList()
	end,
	Play424081134 = function(arg_564_0, arg_564_1)
		arg_564_1.time_ = 0
		arg_564_1.frameCnt_ = 0
		arg_564_1.state_ = "playing"
		arg_564_1.curTalkId_ = 424081134
		arg_564_1.duration_ = 6.53

		local var_564_0 = {
			zh = 5.233,
			ja = 6.533
		}
		local var_564_1 = manager.audio:GetLocalizationFlag()

		if var_564_0[var_564_1] ~= nil then
			arg_564_1.duration_ = var_564_0[var_564_1]
		end

		SetActive(arg_564_1.tipsGo_, false)

		function arg_564_1.onSingleLineFinish_()
			arg_564_1.onSingleLineUpdate_ = nil
			arg_564_1.onSingleLineFinish_ = nil
			arg_564_1.state_ = "waiting"
		end

		function arg_564_1.playNext_(arg_566_0)
			if arg_566_0 == 1 then
				arg_564_0:Play424081135(arg_564_1)
			end
		end

		function arg_564_1.onSingleLineUpdate_(arg_567_0)
			local var_567_0 = 0
			local var_567_1 = 0.6

			if var_567_0 < arg_564_1.time_ and arg_564_1.time_ <= var_567_0 + arg_567_0 then
				arg_564_1.talkMaxDuration = 0
				arg_564_1.dialogCg_.alpha = 1

				arg_564_1.dialog_:SetActive(true)
				SetActive(arg_564_1.leftNameGo_, true)

				local var_567_2 = arg_564_1:FormatText(StoryNameCfg[1393].name)

				arg_564_1.leftNameTxt_.text = var_567_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_564_1.leftNameTxt_.transform)

				arg_564_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_564_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_564_1:RecordName(arg_564_1.leftNameTxt_.text)
				SetActive(arg_564_1.iconTrs_.gameObject, true)
				arg_564_1.iconController_:SetSelectedState("hero")

				arg_564_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lolia")

				arg_564_1.callingController_:SetSelectedState("normal")

				arg_564_1.keyicon_.color = Color.New(1, 1, 1)
				arg_564_1.icon_.color = Color.New(1, 1, 1)

				local var_567_3 = arg_564_1:GetWordFromCfg(424081134)
				local var_567_4 = arg_564_1:FormatText(var_567_3.content)

				arg_564_1.text_.text = var_567_4

				LuaForUtil.ClearLinePrefixSymbol(arg_564_1.text_)

				local var_567_5 = 24
				local var_567_6 = utf8.len(var_567_4)
				local var_567_7 = var_567_5 <= 0 and var_567_1 or var_567_1 * (var_567_6 / var_567_5)

				if var_567_7 > 0 and var_567_1 < var_567_7 then
					arg_564_1.talkMaxDuration = var_567_7

					if var_567_7 + var_567_0 > arg_564_1.duration_ then
						arg_564_1.duration_ = var_567_7 + var_567_0
					end
				end

				arg_564_1.text_.text = var_567_4
				arg_564_1.typewritter.percent = 0

				arg_564_1.typewritter:SetDirty()
				arg_564_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424081", "424081134", "story_v_out_424081.awb") ~= 0 then
					local var_567_8 = manager.audio:GetVoiceLength("story_v_out_424081", "424081134", "story_v_out_424081.awb") / 1000

					if var_567_8 + var_567_0 > arg_564_1.duration_ then
						arg_564_1.duration_ = var_567_8 + var_567_0
					end

					if var_567_3.prefab_name ~= "" and arg_564_1.actors_[var_567_3.prefab_name] ~= nil then
						local var_567_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_564_1.actors_[var_567_3.prefab_name].transform, "story_v_out_424081", "424081134", "story_v_out_424081.awb")

						arg_564_1:RecordAudio("424081134", var_567_9)
						arg_564_1:RecordAudio("424081134", var_567_9)
					else
						arg_564_1:AudioAction("play", "voice", "story_v_out_424081", "424081134", "story_v_out_424081.awb")
					end

					arg_564_1:RecordHistoryTalkVoice("story_v_out_424081", "424081134", "story_v_out_424081.awb")
				end

				arg_564_1:RecordContent(arg_564_1.text_.text)
			end

			local var_567_10 = math.max(var_567_1, arg_564_1.talkMaxDuration)

			if var_567_0 <= arg_564_1.time_ and arg_564_1.time_ < var_567_0 + var_567_10 then
				arg_564_1.typewritter.percent = (arg_564_1.time_ - var_567_0) / var_567_10

				arg_564_1.typewritter:SetDirty()
			end

			if arg_564_1.time_ >= var_567_0 + var_567_10 and arg_564_1.time_ < var_567_0 + var_567_10 + arg_567_0 then
				arg_564_1.typewritter.percent = 1

				arg_564_1.typewritter:SetDirty()
				arg_564_1:ShowNextGo(true)
			end
		end

		arg_564_1.nodeConfigList_ = {}

		arg_564_1:InitPlayNodeList()
	end,
	Play424081135 = function(arg_568_0, arg_568_1)
		arg_568_1.time_ = 0
		arg_568_1.frameCnt_ = 0
		arg_568_1.state_ = "playing"
		arg_568_1.curTalkId_ = 424081135
		arg_568_1.duration_ = 5

		SetActive(arg_568_1.tipsGo_, false)

		function arg_568_1.onSingleLineFinish_()
			arg_568_1.onSingleLineUpdate_ = nil
			arg_568_1.onSingleLineFinish_ = nil
			arg_568_1.state_ = "waiting"
		end

		function arg_568_1.playNext_(arg_570_0)
			if arg_570_0 == 1 then
				arg_568_0:Play424081136(arg_568_1)
			end
		end

		function arg_568_1.onSingleLineUpdate_(arg_571_0)
			local var_571_0 = 0
			local var_571_1 = 0.8

			if var_571_0 < arg_568_1.time_ and arg_568_1.time_ <= var_571_0 + arg_571_0 then
				arg_568_1.talkMaxDuration = 0
				arg_568_1.dialogCg_.alpha = 1

				arg_568_1.dialog_:SetActive(true)
				SetActive(arg_568_1.leftNameGo_, false)

				arg_568_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_568_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_568_1:RecordName(arg_568_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_568_1.iconTrs_.gameObject, false)
				arg_568_1.callingController_:SetSelectedState("normal")

				local var_571_2 = arg_568_1:GetWordFromCfg(424081135)
				local var_571_3 = arg_568_1:FormatText(var_571_2.content)

				arg_568_1.text_.text = var_571_3

				LuaForUtil.ClearLinePrefixSymbol(arg_568_1.text_)

				local var_571_4 = 32
				local var_571_5 = utf8.len(var_571_3)
				local var_571_6 = var_571_4 <= 0 and var_571_1 or var_571_1 * (var_571_5 / var_571_4)

				if var_571_6 > 0 and var_571_1 < var_571_6 then
					arg_568_1.talkMaxDuration = var_571_6

					if var_571_6 + var_571_0 > arg_568_1.duration_ then
						arg_568_1.duration_ = var_571_6 + var_571_0
					end
				end

				arg_568_1.text_.text = var_571_3
				arg_568_1.typewritter.percent = 0

				arg_568_1.typewritter:SetDirty()
				arg_568_1:ShowNextGo(false)
				arg_568_1:RecordContent(arg_568_1.text_.text)
			end

			local var_571_7 = math.max(var_571_1, arg_568_1.talkMaxDuration)

			if var_571_0 <= arg_568_1.time_ and arg_568_1.time_ < var_571_0 + var_571_7 then
				arg_568_1.typewritter.percent = (arg_568_1.time_ - var_571_0) / var_571_7

				arg_568_1.typewritter:SetDirty()
			end

			if arg_568_1.time_ >= var_571_0 + var_571_7 and arg_568_1.time_ < var_571_0 + var_571_7 + arg_571_0 then
				arg_568_1.typewritter.percent = 1

				arg_568_1.typewritter:SetDirty()
				arg_568_1:ShowNextGo(true)
			end
		end

		arg_568_1.nodeConfigList_ = {}

		arg_568_1:InitPlayNodeList()
	end,
	Play424081136 = function(arg_572_0, arg_572_1)
		arg_572_1.time_ = 0
		arg_572_1.frameCnt_ = 0
		arg_572_1.state_ = "playing"
		arg_572_1.curTalkId_ = 424081136
		arg_572_1.duration_ = 5

		SetActive(arg_572_1.tipsGo_, false)

		function arg_572_1.onSingleLineFinish_()
			arg_572_1.onSingleLineUpdate_ = nil
			arg_572_1.onSingleLineFinish_ = nil
			arg_572_1.state_ = "waiting"
		end

		function arg_572_1.playNext_(arg_574_0)
			if arg_574_0 == 1 then
				arg_572_0:Play424081137(arg_572_1)
			end
		end

		function arg_572_1.onSingleLineUpdate_(arg_575_0)
			local var_575_0 = 0
			local var_575_1 = 0.9

			if var_575_0 < arg_572_1.time_ and arg_572_1.time_ <= var_575_0 + arg_575_0 then
				arg_572_1.talkMaxDuration = 0
				arg_572_1.dialogCg_.alpha = 1

				arg_572_1.dialog_:SetActive(true)
				SetActive(arg_572_1.leftNameGo_, true)

				local var_575_2 = arg_572_1:FormatText(StoryNameCfg[7].name)

				arg_572_1.leftNameTxt_.text = var_575_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_572_1.leftNameTxt_.transform)

				arg_572_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_572_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_572_1:RecordName(arg_572_1.leftNameTxt_.text)
				SetActive(arg_572_1.iconTrs_.gameObject, true)
				arg_572_1.iconController_:SetSelectedState("hero")

				arg_572_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_572_1.callingController_:SetSelectedState("normal")

				arg_572_1.keyicon_.color = Color.New(1, 1, 1)
				arg_572_1.icon_.color = Color.New(1, 1, 1)

				local var_575_3 = arg_572_1:GetWordFromCfg(424081136)
				local var_575_4 = arg_572_1:FormatText(var_575_3.content)

				arg_572_1.text_.text = var_575_4

				LuaForUtil.ClearLinePrefixSymbol(arg_572_1.text_)

				local var_575_5 = 36
				local var_575_6 = utf8.len(var_575_4)
				local var_575_7 = var_575_5 <= 0 and var_575_1 or var_575_1 * (var_575_6 / var_575_5)

				if var_575_7 > 0 and var_575_1 < var_575_7 then
					arg_572_1.talkMaxDuration = var_575_7

					if var_575_7 + var_575_0 > arg_572_1.duration_ then
						arg_572_1.duration_ = var_575_7 + var_575_0
					end
				end

				arg_572_1.text_.text = var_575_4
				arg_572_1.typewritter.percent = 0

				arg_572_1.typewritter:SetDirty()
				arg_572_1:ShowNextGo(false)
				arg_572_1:RecordContent(arg_572_1.text_.text)
			end

			local var_575_8 = math.max(var_575_1, arg_572_1.talkMaxDuration)

			if var_575_0 <= arg_572_1.time_ and arg_572_1.time_ < var_575_0 + var_575_8 then
				arg_572_1.typewritter.percent = (arg_572_1.time_ - var_575_0) / var_575_8

				arg_572_1.typewritter:SetDirty()
			end

			if arg_572_1.time_ >= var_575_0 + var_575_8 and arg_572_1.time_ < var_575_0 + var_575_8 + arg_575_0 then
				arg_572_1.typewritter.percent = 1

				arg_572_1.typewritter:SetDirty()
				arg_572_1:ShowNextGo(true)
			end
		end

		arg_572_1.nodeConfigList_ = {}

		arg_572_1:InitPlayNodeList()
	end,
	Play424081137 = function(arg_576_0, arg_576_1)
		arg_576_1.time_ = 0
		arg_576_1.frameCnt_ = 0
		arg_576_1.state_ = "playing"
		arg_576_1.curTalkId_ = 424081137
		arg_576_1.duration_ = 9

		SetActive(arg_576_1.tipsGo_, false)

		function arg_576_1.onSingleLineFinish_()
			arg_576_1.onSingleLineUpdate_ = nil
			arg_576_1.onSingleLineFinish_ = nil
			arg_576_1.state_ = "waiting"
		end

		function arg_576_1.playNext_(arg_578_0)
			if arg_578_0 == 1 then
				arg_576_0:Play424081138(arg_576_1)
			end
		end

		function arg_576_1.onSingleLineUpdate_(arg_579_0)
			local var_579_0 = 2

			if var_579_0 < arg_576_1.time_ and arg_576_1.time_ <= var_579_0 + arg_579_0 then
				local var_579_1 = manager.ui.mainCamera.transform.localPosition
				local var_579_2 = Vector3.New(0, 0, 10) + Vector3.New(var_579_1.x, var_579_1.y, 0)
				local var_579_3 = arg_576_1.bgs_.STblack

				var_579_3.transform.localPosition = var_579_2
				var_579_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_579_4 = var_579_3:GetComponent("SpriteRenderer")

				if var_579_4 and var_579_4.sprite then
					local var_579_5 = (var_579_3.transform.localPosition - var_579_1).z
					local var_579_6 = manager.ui.mainCameraCom_
					local var_579_7 = 2 * var_579_5 * Mathf.Tan(var_579_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_579_8 = var_579_7 * var_579_6.aspect
					local var_579_9 = var_579_4.sprite.bounds.size.x
					local var_579_10 = var_579_4.sprite.bounds.size.y
					local var_579_11 = var_579_8 / var_579_9
					local var_579_12 = var_579_7 / var_579_10
					local var_579_13 = var_579_12 < var_579_11 and var_579_11 or var_579_12

					var_579_3.transform.localScale = Vector3.New(var_579_13, var_579_13, 0)
				end

				for iter_579_0, iter_579_1 in pairs(arg_576_1.bgs_) do
					if iter_579_0 ~= "STblack" then
						iter_579_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_579_14 = 4

			if var_579_14 < arg_576_1.time_ and arg_576_1.time_ <= var_579_14 + arg_579_0 then
				arg_576_1.allBtn_.enabled = false
			end

			local var_579_15 = 0.3

			if arg_576_1.time_ >= var_579_14 + var_579_15 and arg_576_1.time_ < var_579_14 + var_579_15 + arg_579_0 then
				arg_576_1.allBtn_.enabled = true
			end

			local var_579_16 = 0

			if var_579_16 < arg_576_1.time_ and arg_576_1.time_ <= var_579_16 + arg_579_0 then
				arg_576_1.mask_.enabled = true
				arg_576_1.mask_.raycastTarget = true

				arg_576_1:SetGaussion(false)
			end

			local var_579_17 = 2

			if var_579_16 <= arg_576_1.time_ and arg_576_1.time_ < var_579_16 + var_579_17 then
				local var_579_18 = (arg_576_1.time_ - var_579_16) / var_579_17
				local var_579_19 = Color.New(0, 0, 0)

				var_579_19.a = Mathf.Lerp(0, 1, var_579_18)
				arg_576_1.mask_.color = var_579_19
			end

			if arg_576_1.time_ >= var_579_16 + var_579_17 and arg_576_1.time_ < var_579_16 + var_579_17 + arg_579_0 then
				local var_579_20 = Color.New(0, 0, 0)

				var_579_20.a = 1
				arg_576_1.mask_.color = var_579_20
			end

			local var_579_21 = 2

			if var_579_21 < arg_576_1.time_ and arg_576_1.time_ <= var_579_21 + arg_579_0 then
				arg_576_1.mask_.enabled = true
				arg_576_1.mask_.raycastTarget = true

				arg_576_1:SetGaussion(false)
			end

			local var_579_22 = 2

			if var_579_21 <= arg_576_1.time_ and arg_576_1.time_ < var_579_21 + var_579_22 then
				local var_579_23 = (arg_576_1.time_ - var_579_21) / var_579_22
				local var_579_24 = Color.New(0, 0, 0)

				var_579_24.a = Mathf.Lerp(1, 0, var_579_23)
				arg_576_1.mask_.color = var_579_24
			end

			if arg_576_1.time_ >= var_579_21 + var_579_22 and arg_576_1.time_ < var_579_21 + var_579_22 + arg_579_0 then
				local var_579_25 = Color.New(0, 0, 0)
				local var_579_26 = 0

				arg_576_1.mask_.enabled = false
				var_579_25.a = var_579_26
				arg_576_1.mask_.color = var_579_25
			end

			if arg_576_1.frameCnt_ <= 1 then
				arg_576_1.dialog_:SetActive(false)
			end

			local var_579_27 = 4
			local var_579_28 = 0.9

			if var_579_27 < arg_576_1.time_ and arg_576_1.time_ <= var_579_27 + arg_579_0 then
				arg_576_1.talkMaxDuration = 0

				arg_576_1.dialog_:SetActive(true)

				arg_576_1.dialogCg_.alpha = 0

				local var_579_29 = LeanTween.value(arg_576_1.dialog_, 0, 1, 0.3)

				var_579_29:setOnUpdate(LuaHelper.FloatAction(function(arg_580_0)
					arg_576_1.dialogCg_.alpha = arg_580_0
				end))
				var_579_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_576_1.dialog_)
					var_579_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_576_1.duration_ = arg_576_1.duration_ + 0.3

				SetActive(arg_576_1.leftNameGo_, false)

				arg_576_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_576_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_576_1:RecordName(arg_576_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_576_1.iconTrs_.gameObject, false)
				arg_576_1.callingController_:SetSelectedState("normal")

				local var_579_30 = arg_576_1:GetWordFromCfg(424081137)
				local var_579_31 = arg_576_1:FormatText(var_579_30.content)

				arg_576_1.text_.text = var_579_31

				LuaForUtil.ClearLinePrefixSymbol(arg_576_1.text_)

				local var_579_32 = 36
				local var_579_33 = utf8.len(var_579_31)
				local var_579_34 = var_579_32 <= 0 and var_579_28 or var_579_28 * (var_579_33 / var_579_32)

				if var_579_34 > 0 and var_579_28 < var_579_34 then
					arg_576_1.talkMaxDuration = var_579_34
					var_579_27 = var_579_27 + 0.3

					if var_579_34 + var_579_27 > arg_576_1.duration_ then
						arg_576_1.duration_ = var_579_34 + var_579_27
					end
				end

				arg_576_1.text_.text = var_579_31
				arg_576_1.typewritter.percent = 0

				arg_576_1.typewritter:SetDirty()
				arg_576_1:ShowNextGo(false)
				arg_576_1:RecordContent(arg_576_1.text_.text)
			end

			local var_579_35 = var_579_27 + 0.3
			local var_579_36 = math.max(var_579_28, arg_576_1.talkMaxDuration)

			if var_579_35 <= arg_576_1.time_ and arg_576_1.time_ < var_579_35 + var_579_36 then
				arg_576_1.typewritter.percent = (arg_576_1.time_ - var_579_35) / var_579_36

				arg_576_1.typewritter:SetDirty()
			end

			if arg_576_1.time_ >= var_579_35 + var_579_36 and arg_576_1.time_ < var_579_35 + var_579_36 + arg_579_0 then
				arg_576_1.typewritter.percent = 1

				arg_576_1.typewritter:SetDirty()
				arg_576_1:ShowNextGo(true)
			end
		end

		arg_576_1.nodeConfigList_ = {}

		arg_576_1:InitPlayNodeList()
	end,
	Play424081138 = function(arg_582_0, arg_582_1)
		arg_582_1.time_ = 0
		arg_582_1.frameCnt_ = 0
		arg_582_1.state_ = "playing"
		arg_582_1.curTalkId_ = 424081138
		arg_582_1.duration_ = 4.8

		local var_582_0 = {
			zh = 4.466,
			ja = 4.8
		}
		local var_582_1 = manager.audio:GetLocalizationFlag()

		if var_582_0[var_582_1] ~= nil then
			arg_582_1.duration_ = var_582_0[var_582_1]
		end

		SetActive(arg_582_1.tipsGo_, false)

		function arg_582_1.onSingleLineFinish_()
			arg_582_1.onSingleLineUpdate_ = nil
			arg_582_1.onSingleLineFinish_ = nil
			arg_582_1.state_ = "waiting"
		end

		function arg_582_1.playNext_(arg_584_0)
			if arg_584_0 == 1 then
				arg_582_0:Play424081139(arg_582_1)
			end
		end

		function arg_582_1.onSingleLineUpdate_(arg_585_0)
			local var_585_0 = 0

			if var_585_0 < arg_582_1.time_ and arg_582_1.time_ <= var_585_0 + arg_585_0 then
				local var_585_1 = manager.ui.mainCamera.transform.localPosition
				local var_585_2 = Vector3.New(0, 0, 10) + Vector3.New(var_585_1.x, var_585_1.y, 0)
				local var_585_3 = arg_582_1.bgs_.I11i

				var_585_3.transform.localPosition = var_585_2
				var_585_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_585_4 = var_585_3:GetComponent("SpriteRenderer")

				if var_585_4 and var_585_4.sprite then
					local var_585_5 = (var_585_3.transform.localPosition - var_585_1).z
					local var_585_6 = manager.ui.mainCameraCom_
					local var_585_7 = 2 * var_585_5 * Mathf.Tan(var_585_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_585_8 = var_585_7 * var_585_6.aspect
					local var_585_9 = var_585_4.sprite.bounds.size.x
					local var_585_10 = var_585_4.sprite.bounds.size.y
					local var_585_11 = var_585_8 / var_585_9
					local var_585_12 = var_585_7 / var_585_10
					local var_585_13 = var_585_12 < var_585_11 and var_585_11 or var_585_12

					var_585_3.transform.localScale = Vector3.New(var_585_13, var_585_13, 0)
				end

				for iter_585_0, iter_585_1 in pairs(arg_582_1.bgs_) do
					if iter_585_0 ~= "I11i" then
						iter_585_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_585_14 = 2

			if var_585_14 < arg_582_1.time_ and arg_582_1.time_ <= var_585_14 + arg_585_0 then
				arg_582_1.allBtn_.enabled = false
			end

			local var_585_15 = 0.3

			if arg_582_1.time_ >= var_585_14 + var_585_15 and arg_582_1.time_ < var_585_14 + var_585_15 + arg_585_0 then
				arg_582_1.allBtn_.enabled = true
			end

			local var_585_16 = 0

			if var_585_16 < arg_582_1.time_ and arg_582_1.time_ <= var_585_16 + arg_585_0 then
				arg_582_1.mask_.enabled = true
				arg_582_1.mask_.raycastTarget = true

				arg_582_1:SetGaussion(false)
			end

			local var_585_17 = 2

			if var_585_16 <= arg_582_1.time_ and arg_582_1.time_ < var_585_16 + var_585_17 then
				local var_585_18 = (arg_582_1.time_ - var_585_16) / var_585_17
				local var_585_19 = Color.New(0, 0, 0)

				var_585_19.a = Mathf.Lerp(1, 0, var_585_18)
				arg_582_1.mask_.color = var_585_19
			end

			if arg_582_1.time_ >= var_585_16 + var_585_17 and arg_582_1.time_ < var_585_16 + var_585_17 + arg_585_0 then
				local var_585_20 = Color.New(0, 0, 0)
				local var_585_21 = 0

				arg_582_1.mask_.enabled = false
				var_585_20.a = var_585_21
				arg_582_1.mask_.color = var_585_20
			end

			local var_585_22 = 0
			local var_585_23 = 1

			if var_585_22 < arg_582_1.time_ and arg_582_1.time_ <= var_585_22 + arg_585_0 then
				local var_585_24 = "stop"
				local var_585_25 = "effect"

				arg_582_1:AudioAction(var_585_24, var_585_25, "se_story_143", "se_story_143_amb_bar", "")
			end

			local var_585_26 = 0.5
			local var_585_27 = 1

			if var_585_26 < arg_582_1.time_ and arg_582_1.time_ <= var_585_26 + arg_585_0 then
				local var_585_28 = "play"
				local var_585_29 = "effect"

				arg_582_1:AudioAction(var_585_28, var_585_29, "se_story_140", "se_story_140_amb_street02", "")
			end

			if arg_582_1.frameCnt_ <= 1 then
				arg_582_1.dialog_:SetActive(false)
			end

			local var_585_30 = 2
			local var_585_31 = 0.225

			if var_585_30 < arg_582_1.time_ and arg_582_1.time_ <= var_585_30 + arg_585_0 then
				arg_582_1.talkMaxDuration = 0

				arg_582_1.dialog_:SetActive(true)

				arg_582_1.dialogCg_.alpha = 0

				local var_585_32 = LeanTween.value(arg_582_1.dialog_, 0, 1, 0.3)

				var_585_32:setOnUpdate(LuaHelper.FloatAction(function(arg_586_0)
					arg_582_1.dialogCg_.alpha = arg_586_0
				end))
				var_585_32:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_582_1.dialog_)
					var_585_32:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_582_1.duration_ = arg_582_1.duration_ + 0.3

				SetActive(arg_582_1.leftNameGo_, true)

				local var_585_33 = arg_582_1:FormatText(StoryNameCfg[177].name)

				arg_582_1.leftNameTxt_.text = var_585_33

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_582_1.leftNameTxt_.transform)

				arg_582_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_582_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_582_1:RecordName(arg_582_1.leftNameTxt_.text)
				SetActive(arg_582_1.iconTrs_.gameObject, true)
				arg_582_1.iconController_:SetSelectedState("hero")

				arg_582_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_582_1.callingController_:SetSelectedState("normal")

				arg_582_1.keyicon_.color = Color.New(1, 1, 1)
				arg_582_1.icon_.color = Color.New(1, 1, 1)

				local var_585_34 = arg_582_1:GetWordFromCfg(424081138)
				local var_585_35 = arg_582_1:FormatText(var_585_34.content)

				arg_582_1.text_.text = var_585_35

				LuaForUtil.ClearLinePrefixSymbol(arg_582_1.text_)

				local var_585_36 = 9
				local var_585_37 = utf8.len(var_585_35)
				local var_585_38 = var_585_36 <= 0 and var_585_31 or var_585_31 * (var_585_37 / var_585_36)

				if var_585_38 > 0 and var_585_31 < var_585_38 then
					arg_582_1.talkMaxDuration = var_585_38
					var_585_30 = var_585_30 + 0.3

					if var_585_38 + var_585_30 > arg_582_1.duration_ then
						arg_582_1.duration_ = var_585_38 + var_585_30
					end
				end

				arg_582_1.text_.text = var_585_35
				arg_582_1.typewritter.percent = 0

				arg_582_1.typewritter:SetDirty()
				arg_582_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424081", "424081138", "story_v_out_424081.awb") ~= 0 then
					local var_585_39 = manager.audio:GetVoiceLength("story_v_out_424081", "424081138", "story_v_out_424081.awb") / 1000

					if var_585_39 + var_585_30 > arg_582_1.duration_ then
						arg_582_1.duration_ = var_585_39 + var_585_30
					end

					if var_585_34.prefab_name ~= "" and arg_582_1.actors_[var_585_34.prefab_name] ~= nil then
						local var_585_40 = LuaForUtil.PlayVoiceWithCriLipsync(arg_582_1.actors_[var_585_34.prefab_name].transform, "story_v_out_424081", "424081138", "story_v_out_424081.awb")

						arg_582_1:RecordAudio("424081138", var_585_40)
						arg_582_1:RecordAudio("424081138", var_585_40)
					else
						arg_582_1:AudioAction("play", "voice", "story_v_out_424081", "424081138", "story_v_out_424081.awb")
					end

					arg_582_1:RecordHistoryTalkVoice("story_v_out_424081", "424081138", "story_v_out_424081.awb")
				end

				arg_582_1:RecordContent(arg_582_1.text_.text)
			end

			local var_585_41 = var_585_30 + 0.3
			local var_585_42 = math.max(var_585_31, arg_582_1.talkMaxDuration)

			if var_585_41 <= arg_582_1.time_ and arg_582_1.time_ < var_585_41 + var_585_42 then
				arg_582_1.typewritter.percent = (arg_582_1.time_ - var_585_41) / var_585_42

				arg_582_1.typewritter:SetDirty()
			end

			if arg_582_1.time_ >= var_585_41 + var_585_42 and arg_582_1.time_ < var_585_41 + var_585_42 + arg_585_0 then
				arg_582_1.typewritter.percent = 1

				arg_582_1.typewritter:SetDirty()
				arg_582_1:ShowNextGo(true)
			end
		end

		arg_582_1.nodeConfigList_ = {}

		arg_582_1:InitPlayNodeList()
	end,
	Play424081139 = function(arg_588_0, arg_588_1)
		arg_588_1.time_ = 0
		arg_588_1.frameCnt_ = 0
		arg_588_1.state_ = "playing"
		arg_588_1.curTalkId_ = 424081139
		arg_588_1.duration_ = 5

		SetActive(arg_588_1.tipsGo_, false)

		function arg_588_1.onSingleLineFinish_()
			arg_588_1.onSingleLineUpdate_ = nil
			arg_588_1.onSingleLineFinish_ = nil
			arg_588_1.state_ = "waiting"
		end

		function arg_588_1.playNext_(arg_590_0)
			if arg_590_0 == 1 then
				arg_588_0:Play424081140(arg_588_1)
			end
		end

		function arg_588_1.onSingleLineUpdate_(arg_591_0)
			local var_591_0 = 0
			local var_591_1 = 0.2

			if var_591_0 < arg_588_1.time_ and arg_588_1.time_ <= var_591_0 + arg_591_0 then
				arg_588_1.talkMaxDuration = 0
				arg_588_1.dialogCg_.alpha = 1

				arg_588_1.dialog_:SetActive(true)
				SetActive(arg_588_1.leftNameGo_, true)

				local var_591_2 = arg_588_1:FormatText(StoryNameCfg[7].name)

				arg_588_1.leftNameTxt_.text = var_591_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_588_1.leftNameTxt_.transform)

				arg_588_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_588_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_588_1:RecordName(arg_588_1.leftNameTxt_.text)
				SetActive(arg_588_1.iconTrs_.gameObject, true)
				arg_588_1.iconController_:SetSelectedState("hero")

				arg_588_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_588_1.callingController_:SetSelectedState("normal")

				arg_588_1.keyicon_.color = Color.New(1, 1, 1)
				arg_588_1.icon_.color = Color.New(1, 1, 1)

				local var_591_3 = arg_588_1:GetWordFromCfg(424081139)
				local var_591_4 = arg_588_1:FormatText(var_591_3.content)

				arg_588_1.text_.text = var_591_4

				LuaForUtil.ClearLinePrefixSymbol(arg_588_1.text_)

				local var_591_5 = 8
				local var_591_6 = utf8.len(var_591_4)
				local var_591_7 = var_591_5 <= 0 and var_591_1 or var_591_1 * (var_591_6 / var_591_5)

				if var_591_7 > 0 and var_591_1 < var_591_7 then
					arg_588_1.talkMaxDuration = var_591_7

					if var_591_7 + var_591_0 > arg_588_1.duration_ then
						arg_588_1.duration_ = var_591_7 + var_591_0
					end
				end

				arg_588_1.text_.text = var_591_4
				arg_588_1.typewritter.percent = 0

				arg_588_1.typewritter:SetDirty()
				arg_588_1:ShowNextGo(false)
				arg_588_1:RecordContent(arg_588_1.text_.text)
			end

			local var_591_8 = math.max(var_591_1, arg_588_1.talkMaxDuration)

			if var_591_0 <= arg_588_1.time_ and arg_588_1.time_ < var_591_0 + var_591_8 then
				arg_588_1.typewritter.percent = (arg_588_1.time_ - var_591_0) / var_591_8

				arg_588_1.typewritter:SetDirty()
			end

			if arg_588_1.time_ >= var_591_0 + var_591_8 and arg_588_1.time_ < var_591_0 + var_591_8 + arg_591_0 then
				arg_588_1.typewritter.percent = 1

				arg_588_1.typewritter:SetDirty()
				arg_588_1:ShowNextGo(true)
			end
		end

		arg_588_1.nodeConfigList_ = {}

		arg_588_1:InitPlayNodeList()
	end,
	Play424081140 = function(arg_592_0, arg_592_1)
		arg_592_1.time_ = 0
		arg_592_1.frameCnt_ = 0
		arg_592_1.state_ = "playing"
		arg_592_1.curTalkId_ = 424081140
		arg_592_1.duration_ = 6.7

		local var_592_0 = {
			zh = 5.766,
			ja = 6.7
		}
		local var_592_1 = manager.audio:GetLocalizationFlag()

		if var_592_0[var_592_1] ~= nil then
			arg_592_1.duration_ = var_592_0[var_592_1]
		end

		SetActive(arg_592_1.tipsGo_, false)

		function arg_592_1.onSingleLineFinish_()
			arg_592_1.onSingleLineUpdate_ = nil
			arg_592_1.onSingleLineFinish_ = nil
			arg_592_1.state_ = "waiting"
		end

		function arg_592_1.playNext_(arg_594_0)
			if arg_594_0 == 1 then
				arg_592_0:Play424081141(arg_592_1)
			end
		end

		function arg_592_1.onSingleLineUpdate_(arg_595_0)
			local var_595_0 = 0
			local var_595_1 = 0.75

			if var_595_0 < arg_592_1.time_ and arg_592_1.time_ <= var_595_0 + arg_595_0 then
				arg_592_1.talkMaxDuration = 0
				arg_592_1.dialogCg_.alpha = 1

				arg_592_1.dialog_:SetActive(true)
				SetActive(arg_592_1.leftNameGo_, true)

				local var_595_2 = arg_592_1:FormatText(StoryNameCfg[177].name)

				arg_592_1.leftNameTxt_.text = var_595_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_592_1.leftNameTxt_.transform)

				arg_592_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_592_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_592_1:RecordName(arg_592_1.leftNameTxt_.text)
				SetActive(arg_592_1.iconTrs_.gameObject, true)
				arg_592_1.iconController_:SetSelectedState("hero")

				arg_592_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_592_1.callingController_:SetSelectedState("normal")

				arg_592_1.keyicon_.color = Color.New(1, 1, 1)
				arg_592_1.icon_.color = Color.New(1, 1, 1)

				local var_595_3 = arg_592_1:GetWordFromCfg(424081140)
				local var_595_4 = arg_592_1:FormatText(var_595_3.content)

				arg_592_1.text_.text = var_595_4

				LuaForUtil.ClearLinePrefixSymbol(arg_592_1.text_)

				local var_595_5 = 30
				local var_595_6 = utf8.len(var_595_4)
				local var_595_7 = var_595_5 <= 0 and var_595_1 or var_595_1 * (var_595_6 / var_595_5)

				if var_595_7 > 0 and var_595_1 < var_595_7 then
					arg_592_1.talkMaxDuration = var_595_7

					if var_595_7 + var_595_0 > arg_592_1.duration_ then
						arg_592_1.duration_ = var_595_7 + var_595_0
					end
				end

				arg_592_1.text_.text = var_595_4
				arg_592_1.typewritter.percent = 0

				arg_592_1.typewritter:SetDirty()
				arg_592_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424081", "424081140", "story_v_out_424081.awb") ~= 0 then
					local var_595_8 = manager.audio:GetVoiceLength("story_v_out_424081", "424081140", "story_v_out_424081.awb") / 1000

					if var_595_8 + var_595_0 > arg_592_1.duration_ then
						arg_592_1.duration_ = var_595_8 + var_595_0
					end

					if var_595_3.prefab_name ~= "" and arg_592_1.actors_[var_595_3.prefab_name] ~= nil then
						local var_595_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_592_1.actors_[var_595_3.prefab_name].transform, "story_v_out_424081", "424081140", "story_v_out_424081.awb")

						arg_592_1:RecordAudio("424081140", var_595_9)
						arg_592_1:RecordAudio("424081140", var_595_9)
					else
						arg_592_1:AudioAction("play", "voice", "story_v_out_424081", "424081140", "story_v_out_424081.awb")
					end

					arg_592_1:RecordHistoryTalkVoice("story_v_out_424081", "424081140", "story_v_out_424081.awb")
				end

				arg_592_1:RecordContent(arg_592_1.text_.text)
			end

			local var_595_10 = math.max(var_595_1, arg_592_1.talkMaxDuration)

			if var_595_0 <= arg_592_1.time_ and arg_592_1.time_ < var_595_0 + var_595_10 then
				arg_592_1.typewritter.percent = (arg_592_1.time_ - var_595_0) / var_595_10

				arg_592_1.typewritter:SetDirty()
			end

			if arg_592_1.time_ >= var_595_0 + var_595_10 and arg_592_1.time_ < var_595_0 + var_595_10 + arg_595_0 then
				arg_592_1.typewritter.percent = 1

				arg_592_1.typewritter:SetDirty()
				arg_592_1:ShowNextGo(true)
			end
		end

		arg_592_1.nodeConfigList_ = {}

		arg_592_1:InitPlayNodeList()
	end,
	Play424081141 = function(arg_596_0, arg_596_1)
		arg_596_1.time_ = 0
		arg_596_1.frameCnt_ = 0
		arg_596_1.state_ = "playing"
		arg_596_1.curTalkId_ = 424081141
		arg_596_1.duration_ = 5

		SetActive(arg_596_1.tipsGo_, false)

		function arg_596_1.onSingleLineFinish_()
			arg_596_1.onSingleLineUpdate_ = nil
			arg_596_1.onSingleLineFinish_ = nil
			arg_596_1.state_ = "waiting"
		end

		function arg_596_1.playNext_(arg_598_0)
			if arg_598_0 == 1 then
				arg_596_0:Play424081142(arg_596_1)
			end
		end

		function arg_596_1.onSingleLineUpdate_(arg_599_0)
			local var_599_0 = 0
			local var_599_1 = 0.425

			if var_599_0 < arg_596_1.time_ and arg_596_1.time_ <= var_599_0 + arg_599_0 then
				arg_596_1.talkMaxDuration = 0
				arg_596_1.dialogCg_.alpha = 1

				arg_596_1.dialog_:SetActive(true)
				SetActive(arg_596_1.leftNameGo_, true)

				local var_599_2 = arg_596_1:FormatText(StoryNameCfg[7].name)

				arg_596_1.leftNameTxt_.text = var_599_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_596_1.leftNameTxt_.transform)

				arg_596_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_596_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_596_1:RecordName(arg_596_1.leftNameTxt_.text)
				SetActive(arg_596_1.iconTrs_.gameObject, true)
				arg_596_1.iconController_:SetSelectedState("hero")

				arg_596_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_596_1.callingController_:SetSelectedState("normal")

				arg_596_1.keyicon_.color = Color.New(1, 1, 1)
				arg_596_1.icon_.color = Color.New(1, 1, 1)

				local var_599_3 = arg_596_1:GetWordFromCfg(424081141)
				local var_599_4 = arg_596_1:FormatText(var_599_3.content)

				arg_596_1.text_.text = var_599_4

				LuaForUtil.ClearLinePrefixSymbol(arg_596_1.text_)

				local var_599_5 = 17
				local var_599_6 = utf8.len(var_599_4)
				local var_599_7 = var_599_5 <= 0 and var_599_1 or var_599_1 * (var_599_6 / var_599_5)

				if var_599_7 > 0 and var_599_1 < var_599_7 then
					arg_596_1.talkMaxDuration = var_599_7

					if var_599_7 + var_599_0 > arg_596_1.duration_ then
						arg_596_1.duration_ = var_599_7 + var_599_0
					end
				end

				arg_596_1.text_.text = var_599_4
				arg_596_1.typewritter.percent = 0

				arg_596_1.typewritter:SetDirty()
				arg_596_1:ShowNextGo(false)
				arg_596_1:RecordContent(arg_596_1.text_.text)
			end

			local var_599_8 = math.max(var_599_1, arg_596_1.talkMaxDuration)

			if var_599_0 <= arg_596_1.time_ and arg_596_1.time_ < var_599_0 + var_599_8 then
				arg_596_1.typewritter.percent = (arg_596_1.time_ - var_599_0) / var_599_8

				arg_596_1.typewritter:SetDirty()
			end

			if arg_596_1.time_ >= var_599_0 + var_599_8 and arg_596_1.time_ < var_599_0 + var_599_8 + arg_599_0 then
				arg_596_1.typewritter.percent = 1

				arg_596_1.typewritter:SetDirty()
				arg_596_1:ShowNextGo(true)
			end
		end

		arg_596_1.nodeConfigList_ = {}

		arg_596_1:InitPlayNodeList()
	end,
	Play424081142 = function(arg_600_0, arg_600_1)
		arg_600_1.time_ = 0
		arg_600_1.frameCnt_ = 0
		arg_600_1.state_ = "playing"
		arg_600_1.curTalkId_ = 424081142
		arg_600_1.duration_ = 5

		SetActive(arg_600_1.tipsGo_, false)

		function arg_600_1.onSingleLineFinish_()
			arg_600_1.onSingleLineUpdate_ = nil
			arg_600_1.onSingleLineFinish_ = nil
			arg_600_1.state_ = "waiting"
		end

		function arg_600_1.playNext_(arg_602_0)
			if arg_602_0 == 1 then
				arg_600_0:Play424081143(arg_600_1)
			end
		end

		function arg_600_1.onSingleLineUpdate_(arg_603_0)
			local var_603_0 = 0
			local var_603_1 = 0.8

			if var_603_0 < arg_600_1.time_ and arg_600_1.time_ <= var_603_0 + arg_603_0 then
				arg_600_1.talkMaxDuration = 0
				arg_600_1.dialogCg_.alpha = 1

				arg_600_1.dialog_:SetActive(true)
				SetActive(arg_600_1.leftNameGo_, false)

				arg_600_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_600_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_600_1:RecordName(arg_600_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_600_1.iconTrs_.gameObject, false)
				arg_600_1.callingController_:SetSelectedState("normal")

				local var_603_2 = arg_600_1:GetWordFromCfg(424081142)
				local var_603_3 = arg_600_1:FormatText(var_603_2.content)

				arg_600_1.text_.text = var_603_3

				LuaForUtil.ClearLinePrefixSymbol(arg_600_1.text_)

				local var_603_4 = 32
				local var_603_5 = utf8.len(var_603_3)
				local var_603_6 = var_603_4 <= 0 and var_603_1 or var_603_1 * (var_603_5 / var_603_4)

				if var_603_6 > 0 and var_603_1 < var_603_6 then
					arg_600_1.talkMaxDuration = var_603_6

					if var_603_6 + var_603_0 > arg_600_1.duration_ then
						arg_600_1.duration_ = var_603_6 + var_603_0
					end
				end

				arg_600_1.text_.text = var_603_3
				arg_600_1.typewritter.percent = 0

				arg_600_1.typewritter:SetDirty()
				arg_600_1:ShowNextGo(false)
				arg_600_1:RecordContent(arg_600_1.text_.text)
			end

			local var_603_7 = math.max(var_603_1, arg_600_1.talkMaxDuration)

			if var_603_0 <= arg_600_1.time_ and arg_600_1.time_ < var_603_0 + var_603_7 then
				arg_600_1.typewritter.percent = (arg_600_1.time_ - var_603_0) / var_603_7

				arg_600_1.typewritter:SetDirty()
			end

			if arg_600_1.time_ >= var_603_0 + var_603_7 and arg_600_1.time_ < var_603_0 + var_603_7 + arg_603_0 then
				arg_600_1.typewritter.percent = 1

				arg_600_1.typewritter:SetDirty()
				arg_600_1:ShowNextGo(true)
			end
		end

		arg_600_1.nodeConfigList_ = {}

		arg_600_1:InitPlayNodeList()
	end,
	Play424081143 = function(arg_604_0, arg_604_1)
		arg_604_1.time_ = 0
		arg_604_1.frameCnt_ = 0
		arg_604_1.state_ = "playing"
		arg_604_1.curTalkId_ = 424081143
		arg_604_1.duration_ = 7.1

		local var_604_0 = {
			zh = 4.7,
			ja = 7.1
		}
		local var_604_1 = manager.audio:GetLocalizationFlag()

		if var_604_0[var_604_1] ~= nil then
			arg_604_1.duration_ = var_604_0[var_604_1]
		end

		SetActive(arg_604_1.tipsGo_, false)

		function arg_604_1.onSingleLineFinish_()
			arg_604_1.onSingleLineUpdate_ = nil
			arg_604_1.onSingleLineFinish_ = nil
			arg_604_1.state_ = "waiting"
		end

		function arg_604_1.playNext_(arg_606_0)
			if arg_606_0 == 1 then
				arg_604_0:Play424081144(arg_604_1)
			end
		end

		function arg_604_1.onSingleLineUpdate_(arg_607_0)
			local var_607_0 = arg_604_1.actors_["1094"]
			local var_607_1 = 0

			if var_607_1 < arg_604_1.time_ and arg_604_1.time_ <= var_607_1 + arg_607_0 and not isNil(var_607_0) and arg_604_1.var_.actorSpriteComps1094 == nil then
				arg_604_1.var_.actorSpriteComps1094 = var_607_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_607_2 = 0.2

			if var_607_1 <= arg_604_1.time_ and arg_604_1.time_ < var_607_1 + var_607_2 and not isNil(var_607_0) then
				local var_607_3 = (arg_604_1.time_ - var_607_1) / var_607_2

				if arg_604_1.var_.actorSpriteComps1094 then
					for iter_607_0, iter_607_1 in pairs(arg_604_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_607_1 then
							if arg_604_1.isInRecall_ then
								local var_607_4 = Mathf.Lerp(iter_607_1.color.r, arg_604_1.hightColor1.r, var_607_3)
								local var_607_5 = Mathf.Lerp(iter_607_1.color.g, arg_604_1.hightColor1.g, var_607_3)
								local var_607_6 = Mathf.Lerp(iter_607_1.color.b, arg_604_1.hightColor1.b, var_607_3)

								iter_607_1.color = Color.New(var_607_4, var_607_5, var_607_6)
							else
								local var_607_7 = Mathf.Lerp(iter_607_1.color.r, 1, var_607_3)

								iter_607_1.color = Color.New(var_607_7, var_607_7, var_607_7)
							end
						end
					end
				end
			end

			if arg_604_1.time_ >= var_607_1 + var_607_2 and arg_604_1.time_ < var_607_1 + var_607_2 + arg_607_0 and not isNil(var_607_0) and arg_604_1.var_.actorSpriteComps1094 then
				for iter_607_2, iter_607_3 in pairs(arg_604_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_607_3 then
						if arg_604_1.isInRecall_ then
							iter_607_3.color = arg_604_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_607_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_604_1.var_.actorSpriteComps1094 = nil
			end

			local var_607_8 = arg_604_1.actors_["1094"].transform
			local var_607_9 = 0

			if var_607_9 < arg_604_1.time_ and arg_604_1.time_ <= var_607_9 + arg_607_0 then
				arg_604_1.var_.moveOldPos1094 = var_607_8.localPosition
				var_607_8.localScale = Vector3.New(1, 1, 1)

				arg_604_1:CheckSpriteTmpPos("1094", 3)

				local var_607_10 = var_607_8.childCount

				for iter_607_4 = 0, var_607_10 - 1 do
					local var_607_11 = var_607_8:GetChild(iter_607_4)

					if var_607_11.name == "split_2" or not string.find(var_607_11.name, "split") then
						var_607_11.gameObject:SetActive(true)
					else
						var_607_11.gameObject:SetActive(false)
					end
				end
			end

			local var_607_12 = 0.001

			if var_607_9 <= arg_604_1.time_ and arg_604_1.time_ < var_607_9 + var_607_12 then
				local var_607_13 = (arg_604_1.time_ - var_607_9) / var_607_12
				local var_607_14 = Vector3.New(0, -335, -230)

				var_607_8.localPosition = Vector3.Lerp(arg_604_1.var_.moveOldPos1094, var_607_14, var_607_13)
			end

			if arg_604_1.time_ >= var_607_9 + var_607_12 and arg_604_1.time_ < var_607_9 + var_607_12 + arg_607_0 then
				var_607_8.localPosition = Vector3.New(0, -335, -230)
			end

			local var_607_15 = 0
			local var_607_16 = 0.3

			if var_607_15 < arg_604_1.time_ and arg_604_1.time_ <= var_607_15 + arg_607_0 then
				arg_604_1.talkMaxDuration = 0
				arg_604_1.dialogCg_.alpha = 1

				arg_604_1.dialog_:SetActive(true)
				SetActive(arg_604_1.leftNameGo_, true)

				local var_607_17 = arg_604_1:FormatText(StoryNameCfg[181].name)

				arg_604_1.leftNameTxt_.text = var_607_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_604_1.leftNameTxt_.transform)

				arg_604_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_604_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_604_1:RecordName(arg_604_1.leftNameTxt_.text)
				SetActive(arg_604_1.iconTrs_.gameObject, false)
				arg_604_1.callingController_:SetSelectedState("normal")

				local var_607_18 = arg_604_1:GetWordFromCfg(424081143)
				local var_607_19 = arg_604_1:FormatText(var_607_18.content)

				arg_604_1.text_.text = var_607_19

				LuaForUtil.ClearLinePrefixSymbol(arg_604_1.text_)

				local var_607_20 = 12
				local var_607_21 = utf8.len(var_607_19)
				local var_607_22 = var_607_20 <= 0 and var_607_16 or var_607_16 * (var_607_21 / var_607_20)

				if var_607_22 > 0 and var_607_16 < var_607_22 then
					arg_604_1.talkMaxDuration = var_607_22

					if var_607_22 + var_607_15 > arg_604_1.duration_ then
						arg_604_1.duration_ = var_607_22 + var_607_15
					end
				end

				arg_604_1.text_.text = var_607_19
				arg_604_1.typewritter.percent = 0

				arg_604_1.typewritter:SetDirty()
				arg_604_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424081", "424081143", "story_v_out_424081.awb") ~= 0 then
					local var_607_23 = manager.audio:GetVoiceLength("story_v_out_424081", "424081143", "story_v_out_424081.awb") / 1000

					if var_607_23 + var_607_15 > arg_604_1.duration_ then
						arg_604_1.duration_ = var_607_23 + var_607_15
					end

					if var_607_18.prefab_name ~= "" and arg_604_1.actors_[var_607_18.prefab_name] ~= nil then
						local var_607_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_604_1.actors_[var_607_18.prefab_name].transform, "story_v_out_424081", "424081143", "story_v_out_424081.awb")

						arg_604_1:RecordAudio("424081143", var_607_24)
						arg_604_1:RecordAudio("424081143", var_607_24)
					else
						arg_604_1:AudioAction("play", "voice", "story_v_out_424081", "424081143", "story_v_out_424081.awb")
					end

					arg_604_1:RecordHistoryTalkVoice("story_v_out_424081", "424081143", "story_v_out_424081.awb")
				end

				arg_604_1:RecordContent(arg_604_1.text_.text)
			end

			local var_607_25 = math.max(var_607_16, arg_604_1.talkMaxDuration)

			if var_607_15 <= arg_604_1.time_ and arg_604_1.time_ < var_607_15 + var_607_25 then
				arg_604_1.typewritter.percent = (arg_604_1.time_ - var_607_15) / var_607_25

				arg_604_1.typewritter:SetDirty()
			end

			if arg_604_1.time_ >= var_607_15 + var_607_25 and arg_604_1.time_ < var_607_15 + var_607_25 + arg_607_0 then
				arg_604_1.typewritter.percent = 1

				arg_604_1.typewritter:SetDirty()
				arg_604_1:ShowNextGo(true)
			end
		end

		arg_604_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_604_1:InitPlayNodeList()
	end,
	Play424081144 = function(arg_608_0, arg_608_1)
		arg_608_1.time_ = 0
		arg_608_1.frameCnt_ = 0
		arg_608_1.state_ = "playing"
		arg_608_1.curTalkId_ = 424081144
		arg_608_1.duration_ = 5

		SetActive(arg_608_1.tipsGo_, false)

		function arg_608_1.onSingleLineFinish_()
			arg_608_1.onSingleLineUpdate_ = nil
			arg_608_1.onSingleLineFinish_ = nil
			arg_608_1.state_ = "waiting"
		end

		function arg_608_1.playNext_(arg_610_0)
			if arg_610_0 == 1 then
				arg_608_0:Play424081145(arg_608_1)
			end
		end

		function arg_608_1.onSingleLineUpdate_(arg_611_0)
			local var_611_0 = arg_608_1.actors_["1094"]
			local var_611_1 = 0

			if var_611_1 < arg_608_1.time_ and arg_608_1.time_ <= var_611_1 + arg_611_0 and not isNil(var_611_0) and arg_608_1.var_.actorSpriteComps1094 == nil then
				arg_608_1.var_.actorSpriteComps1094 = var_611_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_611_2 = 0.2

			if var_611_1 <= arg_608_1.time_ and arg_608_1.time_ < var_611_1 + var_611_2 and not isNil(var_611_0) then
				local var_611_3 = (arg_608_1.time_ - var_611_1) / var_611_2

				if arg_608_1.var_.actorSpriteComps1094 then
					for iter_611_0, iter_611_1 in pairs(arg_608_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_611_1 then
							if arg_608_1.isInRecall_ then
								local var_611_4 = Mathf.Lerp(iter_611_1.color.r, arg_608_1.hightColor2.r, var_611_3)
								local var_611_5 = Mathf.Lerp(iter_611_1.color.g, arg_608_1.hightColor2.g, var_611_3)
								local var_611_6 = Mathf.Lerp(iter_611_1.color.b, arg_608_1.hightColor2.b, var_611_3)

								iter_611_1.color = Color.New(var_611_4, var_611_5, var_611_6)
							else
								local var_611_7 = Mathf.Lerp(iter_611_1.color.r, 0.5, var_611_3)

								iter_611_1.color = Color.New(var_611_7, var_611_7, var_611_7)
							end
						end
					end
				end
			end

			if arg_608_1.time_ >= var_611_1 + var_611_2 and arg_608_1.time_ < var_611_1 + var_611_2 + arg_611_0 and not isNil(var_611_0) and arg_608_1.var_.actorSpriteComps1094 then
				for iter_611_2, iter_611_3 in pairs(arg_608_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_611_3 then
						if arg_608_1.isInRecall_ then
							iter_611_3.color = arg_608_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_611_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_608_1.var_.actorSpriteComps1094 = nil
			end

			local var_611_8 = arg_608_1.actors_["1094"].transform
			local var_611_9 = 0

			if var_611_9 < arg_608_1.time_ and arg_608_1.time_ <= var_611_9 + arg_611_0 then
				arg_608_1.var_.moveOldPos1094 = var_611_8.localPosition
				var_611_8.localScale = Vector3.New(1, 1, 1)

				arg_608_1:CheckSpriteTmpPos("1094", 7)

				local var_611_10 = var_611_8.childCount

				for iter_611_4 = 0, var_611_10 - 1 do
					local var_611_11 = var_611_8:GetChild(iter_611_4)

					if var_611_11.name == "" or not string.find(var_611_11.name, "split") then
						var_611_11.gameObject:SetActive(true)
					else
						var_611_11.gameObject:SetActive(false)
					end
				end
			end

			local var_611_12 = 0.001

			if var_611_9 <= arg_608_1.time_ and arg_608_1.time_ < var_611_9 + var_611_12 then
				local var_611_13 = (arg_608_1.time_ - var_611_9) / var_611_12
				local var_611_14 = Vector3.New(0, -2000, 0)

				var_611_8.localPosition = Vector3.Lerp(arg_608_1.var_.moveOldPos1094, var_611_14, var_611_13)
			end

			if arg_608_1.time_ >= var_611_9 + var_611_12 and arg_608_1.time_ < var_611_9 + var_611_12 + arg_611_0 then
				var_611_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_611_15 = 0
			local var_611_16 = 0.5

			if var_611_15 < arg_608_1.time_ and arg_608_1.time_ <= var_611_15 + arg_611_0 then
				arg_608_1.talkMaxDuration = 0
				arg_608_1.dialogCg_.alpha = 1

				arg_608_1.dialog_:SetActive(true)
				SetActive(arg_608_1.leftNameGo_, false)

				arg_608_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_608_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_608_1:RecordName(arg_608_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_608_1.iconTrs_.gameObject, false)
				arg_608_1.callingController_:SetSelectedState("normal")

				local var_611_17 = arg_608_1:GetWordFromCfg(424081144)
				local var_611_18 = arg_608_1:FormatText(var_611_17.content)

				arg_608_1.text_.text = var_611_18

				LuaForUtil.ClearLinePrefixSymbol(arg_608_1.text_)

				local var_611_19 = 20
				local var_611_20 = utf8.len(var_611_18)
				local var_611_21 = var_611_19 <= 0 and var_611_16 or var_611_16 * (var_611_20 / var_611_19)

				if var_611_21 > 0 and var_611_16 < var_611_21 then
					arg_608_1.talkMaxDuration = var_611_21

					if var_611_21 + var_611_15 > arg_608_1.duration_ then
						arg_608_1.duration_ = var_611_21 + var_611_15
					end
				end

				arg_608_1.text_.text = var_611_18
				arg_608_1.typewritter.percent = 0

				arg_608_1.typewritter:SetDirty()
				arg_608_1:ShowNextGo(false)
				arg_608_1:RecordContent(arg_608_1.text_.text)
			end

			local var_611_22 = math.max(var_611_16, arg_608_1.talkMaxDuration)

			if var_611_15 <= arg_608_1.time_ and arg_608_1.time_ < var_611_15 + var_611_22 then
				arg_608_1.typewritter.percent = (arg_608_1.time_ - var_611_15) / var_611_22

				arg_608_1.typewritter:SetDirty()
			end

			if arg_608_1.time_ >= var_611_15 + var_611_22 and arg_608_1.time_ < var_611_15 + var_611_22 + arg_611_0 then
				arg_608_1.typewritter.percent = 1

				arg_608_1.typewritter:SetDirty()
				arg_608_1:ShowNextGo(true)
			end
		end

		arg_608_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_608_1:InitPlayNodeList()
	end,
	Play424081145 = function(arg_612_0, arg_612_1)
		arg_612_1.time_ = 0
		arg_612_1.frameCnt_ = 0
		arg_612_1.state_ = "playing"
		arg_612_1.curTalkId_ = 424081145
		arg_612_1.duration_ = 5

		SetActive(arg_612_1.tipsGo_, false)

		function arg_612_1.onSingleLineFinish_()
			arg_612_1.onSingleLineUpdate_ = nil
			arg_612_1.onSingleLineFinish_ = nil
			arg_612_1.state_ = "waiting"
		end

		function arg_612_1.playNext_(arg_614_0)
			if arg_614_0 == 1 then
				arg_612_0:Play424081146(arg_612_1)
			end
		end

		function arg_612_1.onSingleLineUpdate_(arg_615_0)
			local var_615_0 = 0
			local var_615_1 = 0.125

			if var_615_0 < arg_612_1.time_ and arg_612_1.time_ <= var_615_0 + arg_615_0 then
				arg_612_1.talkMaxDuration = 0
				arg_612_1.dialogCg_.alpha = 1

				arg_612_1.dialog_:SetActive(true)
				SetActive(arg_612_1.leftNameGo_, true)

				local var_615_2 = arg_612_1:FormatText(StoryNameCfg[7].name)

				arg_612_1.leftNameTxt_.text = var_615_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_612_1.leftNameTxt_.transform)

				arg_612_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_612_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_612_1:RecordName(arg_612_1.leftNameTxt_.text)
				SetActive(arg_612_1.iconTrs_.gameObject, true)
				arg_612_1.iconController_:SetSelectedState("hero")

				arg_612_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_612_1.callingController_:SetSelectedState("normal")

				arg_612_1.keyicon_.color = Color.New(1, 1, 1)
				arg_612_1.icon_.color = Color.New(1, 1, 1)

				local var_615_3 = arg_612_1:GetWordFromCfg(424081145)
				local var_615_4 = arg_612_1:FormatText(var_615_3.content)

				arg_612_1.text_.text = var_615_4

				LuaForUtil.ClearLinePrefixSymbol(arg_612_1.text_)

				local var_615_5 = 5
				local var_615_6 = utf8.len(var_615_4)
				local var_615_7 = var_615_5 <= 0 and var_615_1 or var_615_1 * (var_615_6 / var_615_5)

				if var_615_7 > 0 and var_615_1 < var_615_7 then
					arg_612_1.talkMaxDuration = var_615_7

					if var_615_7 + var_615_0 > arg_612_1.duration_ then
						arg_612_1.duration_ = var_615_7 + var_615_0
					end
				end

				arg_612_1.text_.text = var_615_4
				arg_612_1.typewritter.percent = 0

				arg_612_1.typewritter:SetDirty()
				arg_612_1:ShowNextGo(false)
				arg_612_1:RecordContent(arg_612_1.text_.text)
			end

			local var_615_8 = math.max(var_615_1, arg_612_1.talkMaxDuration)

			if var_615_0 <= arg_612_1.time_ and arg_612_1.time_ < var_615_0 + var_615_8 then
				arg_612_1.typewritter.percent = (arg_612_1.time_ - var_615_0) / var_615_8

				arg_612_1.typewritter:SetDirty()
			end

			if arg_612_1.time_ >= var_615_0 + var_615_8 and arg_612_1.time_ < var_615_0 + var_615_8 + arg_615_0 then
				arg_612_1.typewritter.percent = 1

				arg_612_1.typewritter:SetDirty()
				arg_612_1:ShowNextGo(true)
			end
		end

		arg_612_1.nodeConfigList_ = {}

		arg_612_1:InitPlayNodeList()
	end,
	Play424081146 = function(arg_616_0, arg_616_1)
		arg_616_1.time_ = 0
		arg_616_1.frameCnt_ = 0
		arg_616_1.state_ = "playing"
		arg_616_1.curTalkId_ = 424081146
		arg_616_1.duration_ = 5

		SetActive(arg_616_1.tipsGo_, false)

		function arg_616_1.onSingleLineFinish_()
			arg_616_1.onSingleLineUpdate_ = nil
			arg_616_1.onSingleLineFinish_ = nil
			arg_616_1.state_ = "waiting"
			arg_616_1.auto_ = false
		end

		function arg_616_1.playNext_(arg_618_0)
			arg_616_1.onStoryFinished_()
		end

		function arg_616_1.onSingleLineUpdate_(arg_619_0)
			local var_619_0 = 0
			local var_619_1 = 0.975

			if var_619_0 < arg_616_1.time_ and arg_616_1.time_ <= var_619_0 + arg_619_0 then
				arg_616_1.talkMaxDuration = 0
				arg_616_1.dialogCg_.alpha = 1

				arg_616_1.dialog_:SetActive(true)
				SetActive(arg_616_1.leftNameGo_, false)

				arg_616_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_616_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_616_1:RecordName(arg_616_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_616_1.iconTrs_.gameObject, false)
				arg_616_1.callingController_:SetSelectedState("normal")

				local var_619_2 = arg_616_1:GetWordFromCfg(424081146)
				local var_619_3 = arg_616_1:FormatText(var_619_2.content)

				arg_616_1.text_.text = var_619_3

				LuaForUtil.ClearLinePrefixSymbol(arg_616_1.text_)

				local var_619_4 = 39
				local var_619_5 = utf8.len(var_619_3)
				local var_619_6 = var_619_4 <= 0 and var_619_1 or var_619_1 * (var_619_5 / var_619_4)

				if var_619_6 > 0 and var_619_1 < var_619_6 then
					arg_616_1.talkMaxDuration = var_619_6

					if var_619_6 + var_619_0 > arg_616_1.duration_ then
						arg_616_1.duration_ = var_619_6 + var_619_0
					end
				end

				arg_616_1.text_.text = var_619_3
				arg_616_1.typewritter.percent = 0

				arg_616_1.typewritter:SetDirty()
				arg_616_1:ShowNextGo(false)
				arg_616_1:RecordContent(arg_616_1.text_.text)
			end

			local var_619_7 = math.max(var_619_1, arg_616_1.talkMaxDuration)

			if var_619_0 <= arg_616_1.time_ and arg_616_1.time_ < var_619_0 + var_619_7 then
				arg_616_1.typewritter.percent = (arg_616_1.time_ - var_619_0) / var_619_7

				arg_616_1.typewritter:SetDirty()
			end

			if arg_616_1.time_ >= var_619_0 + var_619_7 and arg_616_1.time_ < var_619_0 + var_619_7 + arg_619_0 then
				arg_616_1.typewritter.percent = 1

				arg_616_1.typewritter:SetDirty()
				arg_616_1:ShowNextGo(true)
			end
		end

		arg_616_1.nodeConfigList_ = {}

		arg_616_1:InitPlayNodeList()
	end,
	Play424081032 = function(arg_620_0, arg_620_1)
		arg_620_1.time_ = 0
		arg_620_1.frameCnt_ = 0
		arg_620_1.state_ = "playing"
		arg_620_1.curTalkId_ = 424081032
		arg_620_1.duration_ = 4.87

		local var_620_0 = {
			zh = 3.6,
			ja = 4.866
		}
		local var_620_1 = manager.audio:GetLocalizationFlag()

		if var_620_0[var_620_1] ~= nil then
			arg_620_1.duration_ = var_620_0[var_620_1]
		end

		SetActive(arg_620_1.tipsGo_, false)

		function arg_620_1.onSingleLineFinish_()
			arg_620_1.onSingleLineUpdate_ = nil
			arg_620_1.onSingleLineFinish_ = nil
			arg_620_1.state_ = "waiting"
		end

		function arg_620_1.playNext_(arg_622_0)
			if arg_622_0 == 1 then
				arg_620_0:Play424081033(arg_620_1)
			end
		end

		function arg_620_1.onSingleLineUpdate_(arg_623_0)
			local var_623_0 = 0
			local var_623_1 = 0.475

			if var_623_0 < arg_620_1.time_ and arg_620_1.time_ <= var_623_0 + arg_623_0 then
				arg_620_1.talkMaxDuration = 0
				arg_620_1.dialogCg_.alpha = 1

				arg_620_1.dialog_:SetActive(true)
				SetActive(arg_620_1.leftNameGo_, true)

				local var_623_2 = arg_620_1:FormatText(StoryNameCfg[1393].name)

				arg_620_1.leftNameTxt_.text = var_623_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_620_1.leftNameTxt_.transform)

				arg_620_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_620_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_620_1:RecordName(arg_620_1.leftNameTxt_.text)
				SetActive(arg_620_1.iconTrs_.gameObject, true)
				arg_620_1.iconController_:SetSelectedState("hero")

				arg_620_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lolia")

				arg_620_1.callingController_:SetSelectedState("normal")

				arg_620_1.keyicon_.color = Color.New(1, 1, 1)
				arg_620_1.icon_.color = Color.New(1, 1, 1)

				local var_623_3 = arg_620_1:GetWordFromCfg(424081032)
				local var_623_4 = arg_620_1:FormatText(var_623_3.content)

				arg_620_1.text_.text = var_623_4

				LuaForUtil.ClearLinePrefixSymbol(arg_620_1.text_)

				local var_623_5 = 19
				local var_623_6 = utf8.len(var_623_4)
				local var_623_7 = var_623_5 <= 0 and var_623_1 or var_623_1 * (var_623_6 / var_623_5)

				if var_623_7 > 0 and var_623_1 < var_623_7 then
					arg_620_1.talkMaxDuration = var_623_7

					if var_623_7 + var_623_0 > arg_620_1.duration_ then
						arg_620_1.duration_ = var_623_7 + var_623_0
					end
				end

				arg_620_1.text_.text = var_623_4
				arg_620_1.typewritter.percent = 0

				arg_620_1.typewritter:SetDirty()
				arg_620_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424081", "424081032", "story_v_out_424081.awb") ~= 0 then
					local var_623_8 = manager.audio:GetVoiceLength("story_v_out_424081", "424081032", "story_v_out_424081.awb") / 1000

					if var_623_8 + var_623_0 > arg_620_1.duration_ then
						arg_620_1.duration_ = var_623_8 + var_623_0
					end

					if var_623_3.prefab_name ~= "" and arg_620_1.actors_[var_623_3.prefab_name] ~= nil then
						local var_623_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_620_1.actors_[var_623_3.prefab_name].transform, "story_v_out_424081", "424081032", "story_v_out_424081.awb")

						arg_620_1:RecordAudio("424081032", var_623_9)
						arg_620_1:RecordAudio("424081032", var_623_9)
					else
						arg_620_1:AudioAction("play", "voice", "story_v_out_424081", "424081032", "story_v_out_424081.awb")
					end

					arg_620_1:RecordHistoryTalkVoice("story_v_out_424081", "424081032", "story_v_out_424081.awb")
				end

				arg_620_1:RecordContent(arg_620_1.text_.text)
			end

			local var_623_10 = math.max(var_623_1, arg_620_1.talkMaxDuration)

			if var_623_0 <= arg_620_1.time_ and arg_620_1.time_ < var_623_0 + var_623_10 then
				arg_620_1.typewritter.percent = (arg_620_1.time_ - var_623_0) / var_623_10

				arg_620_1.typewritter:SetDirty()
			end

			if arg_620_1.time_ >= var_623_0 + var_623_10 and arg_620_1.time_ < var_623_0 + var_623_10 + arg_623_0 then
				arg_620_1.typewritter.percent = 1

				arg_620_1.typewritter:SetDirty()
				arg_620_1:ShowNextGo(true)
			end
		end

		arg_620_1.nodeConfigList_ = {}

		arg_620_1:InitPlayNodeList()
	end,
	Play424081033 = function(arg_624_0, arg_624_1)
		arg_624_1.time_ = 0
		arg_624_1.frameCnt_ = 0
		arg_624_1.state_ = "playing"
		arg_624_1.curTalkId_ = 424081033
		arg_624_1.duration_ = 3.6

		local var_624_0 = {
			zh = 2.533,
			ja = 3.6
		}
		local var_624_1 = manager.audio:GetLocalizationFlag()

		if var_624_0[var_624_1] ~= nil then
			arg_624_1.duration_ = var_624_0[var_624_1]
		end

		SetActive(arg_624_1.tipsGo_, false)

		function arg_624_1.onSingleLineFinish_()
			arg_624_1.onSingleLineUpdate_ = nil
			arg_624_1.onSingleLineFinish_ = nil
			arg_624_1.state_ = "waiting"
		end

		function arg_624_1.playNext_(arg_626_0)
			if arg_626_0 == 1 then
				arg_624_0:Play424081034(arg_624_1)
			end
		end

		function arg_624_1.onSingleLineUpdate_(arg_627_0)
			local var_627_0 = 0
			local var_627_1 = 0.225

			if var_627_0 < arg_624_1.time_ and arg_624_1.time_ <= var_627_0 + arg_627_0 then
				arg_624_1.talkMaxDuration = 0
				arg_624_1.dialogCg_.alpha = 1

				arg_624_1.dialog_:SetActive(true)
				SetActive(arg_624_1.leftNameGo_, true)

				local var_627_2 = arg_624_1:FormatText(StoryNameCfg[1404].name)

				arg_624_1.leftNameTxt_.text = var_627_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_624_1.leftNameTxt_.transform)

				arg_624_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_624_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_624_1:RecordName(arg_624_1.leftNameTxt_.text)
				SetActive(arg_624_1.iconTrs_.gameObject, true)
				arg_624_1.iconController_:SetSelectedState("hero")

				arg_624_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_littleboya")

				arg_624_1.callingController_:SetSelectedState("normal")

				arg_624_1.keyicon_.color = Color.New(1, 1, 1)
				arg_624_1.icon_.color = Color.New(1, 1, 1)

				local var_627_3 = arg_624_1:GetWordFromCfg(424081033)
				local var_627_4 = arg_624_1:FormatText(var_627_3.content)

				arg_624_1.text_.text = var_627_4

				LuaForUtil.ClearLinePrefixSymbol(arg_624_1.text_)

				local var_627_5 = 9
				local var_627_6 = utf8.len(var_627_4)
				local var_627_7 = var_627_5 <= 0 and var_627_1 or var_627_1 * (var_627_6 / var_627_5)

				if var_627_7 > 0 and var_627_1 < var_627_7 then
					arg_624_1.talkMaxDuration = var_627_7

					if var_627_7 + var_627_0 > arg_624_1.duration_ then
						arg_624_1.duration_ = var_627_7 + var_627_0
					end
				end

				arg_624_1.text_.text = var_627_4
				arg_624_1.typewritter.percent = 0

				arg_624_1.typewritter:SetDirty()
				arg_624_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424081", "424081033", "story_v_out_424081.awb") ~= 0 then
					local var_627_8 = manager.audio:GetVoiceLength("story_v_out_424081", "424081033", "story_v_out_424081.awb") / 1000

					if var_627_8 + var_627_0 > arg_624_1.duration_ then
						arg_624_1.duration_ = var_627_8 + var_627_0
					end

					if var_627_3.prefab_name ~= "" and arg_624_1.actors_[var_627_3.prefab_name] ~= nil then
						local var_627_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_624_1.actors_[var_627_3.prefab_name].transform, "story_v_out_424081", "424081033", "story_v_out_424081.awb")

						arg_624_1:RecordAudio("424081033", var_627_9)
						arg_624_1:RecordAudio("424081033", var_627_9)
					else
						arg_624_1:AudioAction("play", "voice", "story_v_out_424081", "424081033", "story_v_out_424081.awb")
					end

					arg_624_1:RecordHistoryTalkVoice("story_v_out_424081", "424081033", "story_v_out_424081.awb")
				end

				arg_624_1:RecordContent(arg_624_1.text_.text)
			end

			local var_627_10 = math.max(var_627_1, arg_624_1.talkMaxDuration)

			if var_627_0 <= arg_624_1.time_ and arg_624_1.time_ < var_627_0 + var_627_10 then
				arg_624_1.typewritter.percent = (arg_624_1.time_ - var_627_0) / var_627_10

				arg_624_1.typewritter:SetDirty()
			end

			if arg_624_1.time_ >= var_627_0 + var_627_10 and arg_624_1.time_ < var_627_0 + var_627_10 + arg_627_0 then
				arg_624_1.typewritter.percent = 1

				arg_624_1.typewritter:SetDirty()
				arg_624_1:ShowNextGo(true)
			end
		end

		arg_624_1.nodeConfigList_ = {}

		arg_624_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/I11r",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/SS2402",
		"TextureConfig/Background/SS2402a",
		"TextureConfig/Background/ST0115",
		"TextureConfig/Background/I11i",
		"TextureConfig/Background/SS2402b"
	},
	voices = {
		"story_v_out_424081.awb"
	}
}
