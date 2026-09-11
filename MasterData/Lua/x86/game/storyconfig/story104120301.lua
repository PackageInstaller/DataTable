return {
	Play412031001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 412031001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play412031002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.I09j == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I09j")
				var_4_0.name = "I09j"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.I09j = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.I09j

				arg_1_1.bgs_.I09j.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "I09j" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 1.999999999999

			if 1.999999999999 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_4 + 0.3 and arg_1_1.time_ < var_4_4 + 0.3 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_5 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_5 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_6 = 2

			if var_4_5 <= arg_1_1.time_ and arg_1_1.time_ < var_4_5 + var_4_6 then
				local var_4_7 = Color.New(0, 0, 0)

				var_4_7.a = Mathf.Lerp(1, 0, (arg_1_1.time_ - var_4_5) / var_4_6)
				arg_1_1.mask_.color = var_4_7
			end

			if arg_1_1.time_ >= var_4_5 + var_4_6 and arg_1_1.time_ < var_4_5 + var_4_6 + arg_4_0 then
				local var_4_8 = Color.New(0, 0, 0)

				arg_1_1.mask_.enabled = false
				var_4_8.a = 0
				arg_1_1.mask_.color = var_4_8
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_11 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_11 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_11

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_11
						arg_1_1.bgmTxt2_.text = var_4_11
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

			if 1.1 < arg_1_1.time_ and arg_1_1.time_ <= 1.1 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_3_2_story_corridor_slow", "bgm_activity_3_2_story_corridor_slow", "bgm_activity_3_2_story_corridor_slow.awb")

				local var_4_14 = manager.audio:GetAudioName("bgm_activity_3_2_story_corridor_slow", "bgm_activity_3_2_story_corridor_slow")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_14 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_14

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_14
						arg_1_1.bgmTxt2_.text = var_4_14
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

			local var_4_15 = 2
			local var_4_16 = 0.475

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_15 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_17 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_17:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_18 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(412031001).content)

				arg_1_1.text_.text = var_4_18

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_20 = 19 <= 0 and var_4_16 or var_4_16 * (utf8.len(var_4_18) / 19)

				if (19 <= 0 and var_4_16 or var_4_16 * (utf8.len(var_4_18) / 19)) > 0 and var_4_16 < var_4_20 then
					arg_1_1.talkMaxDuration = var_4_20
					var_4_15 = var_4_15 + 0.3

					if var_4_20 + var_4_15 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_20 + var_4_15
					end
				end

				arg_1_1.text_.text = var_4_18
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_21 = var_4_15 + 0.3
			local var_4_22 = math.max(var_4_16, arg_1_1.talkMaxDuration)

			if var_4_15 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_21 + var_4_22 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_21) / var_4_22

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_21 + var_4_22 and arg_1_1.time_ < var_4_21 + var_4_22 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play412031002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 412031002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play412031003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0.875

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, false)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_1 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(412031002).content)

				arg_9_1.text_.text = var_12_1

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_3 = 35 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 35)

				if (35 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 35)) > 0 and var_12_0 < var_12_3 then
					arg_9_1.talkMaxDuration = var_12_3

					if var_12_3 + 0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_3 + 0
					end
				end

				arg_9_1.text_.text = var_12_1
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_4 = math.max(var_12_0, arg_9_1.talkMaxDuration)

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_4 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - 0) / var_12_4

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= 0 + var_12_4 and arg_9_1.time_ < 0 + var_12_4 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play412031003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 412031003
		arg_13_1.duration_ = 3.67

		local var_13_0 = {
			zh = 3.666,
			ja = 2.9
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
				arg_13_0:Play412031004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0.25

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, true)
				arg_13_1.iconController_:SetSelectedState("hero")

				arg_13_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1097")

				arg_13_1.callingController_:SetSelectedState("normal")

				arg_13_1.keyicon_.color = Color.New(1, 1, 1)
				arg_13_1.icon_.color = Color.New(1, 1, 1)

				local var_16_1 = arg_13_1:GetWordFromCfg(412031003)
				local var_16_2 = arg_13_1:FormatText(var_16_1.content)

				arg_13_1.text_.text = var_16_2

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_4 = 10 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_2) / 10)

				if (10 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_2) / 10)) > 0 and var_16_0 < var_16_4 then
					arg_13_1.talkMaxDuration = var_16_4

					if var_16_4 + 0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_4 + 0
					end
				end

				arg_13_1.text_.text = var_16_2
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031003", "story_v_out_412031.awb") ~= 0 then
					local var_16_5 = manager.audio:GetVoiceLength("story_v_out_412031", "412031003", "story_v_out_412031.awb") / 1000

					if var_16_5 + 0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_5 + 0
					end

					if var_16_1.prefab_name ~= "" and arg_13_1.actors_[var_16_1.prefab_name] ~= nil then
						local var_16_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_1.prefab_name].transform, "story_v_out_412031", "412031003", "story_v_out_412031.awb")

						arg_13_1:RecordAudio("412031003", var_16_6)
						arg_13_1:RecordAudio("412031003", var_16_6)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_412031", "412031003", "story_v_out_412031.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_412031", "412031003", "story_v_out_412031.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_7 = math.max(var_16_0, arg_13_1.talkMaxDuration)

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_7 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - 0) / var_16_7

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= 0 + var_16_7 and arg_13_1.time_ < 0 + var_16_7 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play412031004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 412031004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play412031005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 1.05

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, false)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_1 = arg_17_1:FormatText(arg_17_1:GetWordFromCfg(412031004).content)

				arg_17_1.text_.text = var_20_1

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_3 = 42 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_1) / 42)

				if (42 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_1) / 42)) > 0 and var_20_0 < var_20_3 then
					arg_17_1.talkMaxDuration = var_20_3

					if var_20_3 + 0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_3 + 0
					end
				end

				arg_17_1.text_.text = var_20_1
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)
				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_4 = math.max(var_20_0, arg_17_1.talkMaxDuration)

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_4 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - 0) / var_20_4

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= 0 + var_20_4 and arg_17_1.time_ < 0 + var_20_4 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play412031005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 412031005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play412031006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 0.125

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, false)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_1 = arg_21_1:FormatText(arg_21_1:GetWordFromCfg(412031005).content)

				arg_21_1.text_.text = var_24_1

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_3 = 5 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_1) / 5)

				if (5 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_1) / 5)) > 0 and var_24_0 < var_24_3 then
					arg_21_1.talkMaxDuration = var_24_3

					if var_24_3 + 0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_3 + 0
					end
				end

				arg_21_1.text_.text = var_24_1
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)
				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_4 = math.max(var_24_0, arg_21_1.talkMaxDuration)

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_4 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - 0) / var_24_4

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= 0 + var_24_4 and arg_21_1.time_ < 0 + var_24_4 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play412031006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 412031006
		arg_25_1.duration_ = 5.13

		local var_25_0 = {
			zh = 5.133,
			ja = 4.233
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
				arg_25_0:Play412031007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if arg_25_1.actors_["1097ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1097ui_story"))) then
				local var_28_0 = Object.Instantiate(Asset.Load("Char/" .. "1097ui_story"), arg_25_1.stage_.transform)

				var_28_0.name = "1097ui_story"
				var_28_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_25_1.actors_["1097ui_story"] = var_28_0

				local var_28_1 = var_28_0:GetComponentInChildren(typeof(CharacterEffect))

				var_28_1.enabled = true

				local var_28_2 = GameObjectTools.GetOrAddComponent(var_28_0, typeof(DynamicBoneHelper))

				if var_28_2 then
					var_28_2:EnableDynamicBone(false)
				end

				arg_25_1:ShowWeapon(var_28_1.transform, false)

				arg_25_1.var_["1097ui_story" .. "Animator"] = var_28_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_25_1.var_["1097ui_story" .. "Animator"].applyRootMotion = true
				arg_25_1.var_["1097ui_story" .. "LipSync"] = var_28_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_28_3 = arg_25_1.actors_["1097ui_story"].transform

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.var_.moveOldPos1097ui_story = var_28_3.localPosition
			end

			local var_28_4 = 0.001

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_4 then
				var_28_3.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1097ui_story, Vector3.New(0, -0.54, -6.3), (arg_25_1.time_ - 0) / var_28_4)
				var_28_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_28_3.position).x, (manager.ui.mainCamera.transform.position - var_28_3.position).y, (manager.ui.mainCamera.transform.position - var_28_3.position).z)
				var_28_3.localEulerAngles.z = 0
				var_28_3.localEulerAngles.x = 0
				var_28_3.localEulerAngles = var_28_3.localEulerAngles
			end

			if arg_25_1.time_ >= 0 + var_28_4 and arg_25_1.time_ < 0 + var_28_4 + arg_28_0 then
				var_28_3.localPosition = Vector3.New(0, -0.54, -6.3)
				var_28_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_28_3.position).x, (manager.ui.mainCamera.transform.position - var_28_3.position).y, (manager.ui.mainCamera.transform.position - var_28_3.position).z)
				var_28_3.localEulerAngles.z = 0
				var_28_3.localEulerAngles.x = 0
				var_28_3.localEulerAngles = var_28_3.localEulerAngles
			end

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_28_5 = arg_25_1.actors_["1097ui_story"]

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(var_28_5) and arg_25_1.var_.characterEffect1097ui_story == nil then
				arg_25_1.var_.characterEffect1097ui_story = var_28_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_6 = 0.2

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_6 and not isNil(var_28_5) then
				if arg_25_1.var_.characterEffect1097ui_story and not isNil(var_28_5) then
					arg_25_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_25_1.time_ >= 0 + var_28_6 and arg_25_1.time_ < 0 + var_28_6 + arg_28_0 and not isNil(var_28_5) and arg_25_1.var_.characterEffect1097ui_story then
				arg_25_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_28_8 = 0
			local var_28_9 = 0.275

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_8 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_10 = arg_25_1:GetWordFromCfg(412031006)
				local var_28_11 = arg_25_1:FormatText(var_28_10.content)

				arg_25_1.text_.text = var_28_11

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_13 = 11 <= 0 and var_28_9 or var_28_9 * (utf8.len(var_28_11) / 11)

				if (11 <= 0 and var_28_9 or var_28_9 * (utf8.len(var_28_11) / 11)) > 0 and var_28_9 < var_28_13 then
					arg_25_1.talkMaxDuration = var_28_13

					if var_28_13 + var_28_8 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_13 + var_28_8
					end
				end

				arg_25_1.text_.text = var_28_11
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031006", "story_v_out_412031.awb") ~= 0 then
					local var_28_14 = manager.audio:GetVoiceLength("story_v_out_412031", "412031006", "story_v_out_412031.awb") / 1000

					if var_28_14 + var_28_8 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_14 + var_28_8
					end

					if var_28_10.prefab_name ~= "" and arg_25_1.actors_[var_28_10.prefab_name] ~= nil then
						local var_28_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_10.prefab_name].transform, "story_v_out_412031", "412031006", "story_v_out_412031.awb")

						arg_25_1:RecordAudio("412031006", var_28_15)
						arg_25_1:RecordAudio("412031006", var_28_15)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_412031", "412031006", "story_v_out_412031.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_412031", "412031006", "story_v_out_412031.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_16 = math.max(var_28_9, arg_25_1.talkMaxDuration)

			if var_28_8 <= arg_25_1.time_ and arg_25_1.time_ < var_28_8 + var_28_16 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_8) / var_28_16

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_8 + var_28_16 and arg_25_1.time_ < var_28_8 + var_28_16 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_25_1:InitPlayNodeList()
	end,
	Play412031007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 412031007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play412031008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(arg_29_1.actors_["1097ui_story"]) and arg_29_1.var_.characterEffect1097ui_story == nil then
				arg_29_1.var_.characterEffect1097ui_story = arg_29_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_0 = 0.2

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_0 and not isNil(arg_29_1.actors_["1097ui_story"]) then
				if arg_29_1.var_.characterEffect1097ui_story and not isNil(arg_29_1.actors_["1097ui_story"]) then
					arg_29_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_29_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_29_1.time_ - 0) / var_32_0)
				end
			end

			if arg_29_1.time_ >= 0 + var_32_0 and arg_29_1.time_ < 0 + var_32_0 + arg_32_0 and not isNil(arg_29_1.actors_["1097ui_story"]) and arg_29_1.var_.characterEffect1097ui_story then
				arg_29_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_29_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_32_1 = arg_29_1.actors_["1097ui_story"].transform

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.var_.moveOldPos1097ui_story = var_32_1.localPosition
			end

			local var_32_2 = 0.001

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_2 then
				var_32_1.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos1097ui_story, Vector3.New(0, 100, 0), (arg_29_1.time_ - 0) / var_32_2)
				var_32_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_32_1.position).x, (manager.ui.mainCamera.transform.position - var_32_1.position).y, (manager.ui.mainCamera.transform.position - var_32_1.position).z)
				var_32_1.localEulerAngles.z = 0
				var_32_1.localEulerAngles.x = 0
				var_32_1.localEulerAngles = var_32_1.localEulerAngles
			end

			if arg_29_1.time_ >= 0 + var_32_2 and arg_29_1.time_ < 0 + var_32_2 + arg_32_0 then
				var_32_1.localPosition = Vector3.New(0, 100, 0)
				var_32_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_32_1.position).x, (manager.ui.mainCamera.transform.position - var_32_1.position).y, (manager.ui.mainCamera.transform.position - var_32_1.position).z)
				var_32_1.localEulerAngles.z = 0
				var_32_1.localEulerAngles.x = 0
				var_32_1.localEulerAngles = var_32_1.localEulerAngles
			end

			local var_32_3 = 0
			local var_32_4 = 1.35

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_3 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, false)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_5 = arg_29_1:FormatText(arg_29_1:GetWordFromCfg(412031007).content)

				arg_29_1.text_.text = var_32_5

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_7 = 54 <= 0 and var_32_4 or var_32_4 * (utf8.len(var_32_5) / 54)

				if (54 <= 0 and var_32_4 or var_32_4 * (utf8.len(var_32_5) / 54)) > 0 and var_32_4 < var_32_7 then
					arg_29_1.talkMaxDuration = var_32_7

					if var_32_7 + var_32_3 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_7 + var_32_3
					end
				end

				arg_29_1.text_.text = var_32_5
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)
				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_8 = math.max(var_32_4, arg_29_1.talkMaxDuration)

			if var_32_3 <= arg_29_1.time_ and arg_29_1.time_ < var_32_3 + var_32_8 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_3) / var_32_8

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_3 + var_32_8 and arg_29_1.time_ < var_32_3 + var_32_8 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_29_1:InitPlayNodeList()
	end,
	Play412031008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 412031008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play412031009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = 0.5

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, false)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_1 = arg_33_1:FormatText(arg_33_1:GetWordFromCfg(412031008).content)

				arg_33_1.text_.text = var_36_1

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_3 = 20 <= 0 and var_36_0 or var_36_0 * (utf8.len(var_36_1) / 20)

				if (20 <= 0 and var_36_0 or var_36_0 * (utf8.len(var_36_1) / 20)) > 0 and var_36_0 < var_36_3 then
					arg_33_1.talkMaxDuration = var_36_3

					if var_36_3 + 0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_3 + 0
					end
				end

				arg_33_1.text_.text = var_36_1
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_4 = math.max(var_36_0, arg_33_1.talkMaxDuration)

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_4 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - 0) / var_36_4

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= 0 + var_36_4 and arg_33_1.time_ < 0 + var_36_4 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play412031009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 412031009
		arg_37_1.duration_ = 5.07

		local var_37_0 = {
			zh = 5.066,
			ja = 4.066
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
				arg_37_0:Play412031010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if arg_37_1.actors_["3043ui_story"] == nil and not isNil((Asset.Load("Char/" .. "3043ui_story"))) then
				local var_40_0 = Object.Instantiate(Asset.Load("Char/" .. "3043ui_story"), arg_37_1.stage_.transform)

				var_40_0.name = "3043ui_story"
				var_40_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_37_1.actors_["3043ui_story"] = var_40_0

				local var_40_1 = var_40_0:GetComponentInChildren(typeof(CharacterEffect))

				var_40_1.enabled = true

				local var_40_2 = GameObjectTools.GetOrAddComponent(var_40_0, typeof(DynamicBoneHelper))

				if var_40_2 then
					var_40_2:EnableDynamicBone(false)
				end

				arg_37_1:ShowWeapon(var_40_1.transform, false)

				arg_37_1.var_["3043ui_story" .. "Animator"] = var_40_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_37_1.var_["3043ui_story" .. "Animator"].applyRootMotion = true
				arg_37_1.var_["3043ui_story" .. "LipSync"] = var_40_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_40_3 = arg_37_1.actors_["3043ui_story"].transform

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.var_.moveOldPos3043ui_story = var_40_3.localPosition
			end

			local var_40_4 = 0.001

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_4 then
				var_40_3.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos3043ui_story, Vector3.New(0, -1.41, -5.7), (arg_37_1.time_ - 0) / var_40_4)
				var_40_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_40_3.position).x, (manager.ui.mainCamera.transform.position - var_40_3.position).y, (manager.ui.mainCamera.transform.position - var_40_3.position).z)
				var_40_3.localEulerAngles.z = 0
				var_40_3.localEulerAngles.x = 0
				var_40_3.localEulerAngles = var_40_3.localEulerAngles
			end

			if arg_37_1.time_ >= 0 + var_40_4 and arg_37_1.time_ < 0 + var_40_4 + arg_40_0 then
				var_40_3.localPosition = Vector3.New(0, -1.41, -5.7)
				var_40_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_40_3.position).x, (manager.ui.mainCamera.transform.position - var_40_3.position).y, (manager.ui.mainCamera.transform.position - var_40_3.position).z)
				var_40_3.localEulerAngles.z = 0
				var_40_3.localEulerAngles.x = 0
				var_40_3.localEulerAngles = var_40_3.localEulerAngles
			end

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1:PlayTimeline("3043ui_story", "StoryTimeline/CharAction/story3043/story3043action/3043action1_1")
			end

			local var_40_5 = arg_37_1.actors_["3043ui_story"]

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(var_40_5) and arg_37_1.var_.characterEffect3043ui_story == nil then
				arg_37_1.var_.characterEffect3043ui_story = var_40_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_6 = 0.2

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_6 and not isNil(var_40_5) then
				if arg_37_1.var_.characterEffect3043ui_story and not isNil(var_40_5) then
					arg_37_1.var_.characterEffect3043ui_story.fillFlat = false
				end
			end

			if arg_37_1.time_ >= 0 + var_40_6 and arg_37_1.time_ < 0 + var_40_6 + arg_40_0 and not isNil(var_40_5) and arg_37_1.var_.characterEffect3043ui_story then
				arg_37_1.var_.characterEffect3043ui_story.fillFlat = false
			end

			local var_40_8 = 0
			local var_40_9 = 0.425

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_8 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_10 = arg_37_1:GetWordFromCfg(412031009)
				local var_40_11 = arg_37_1:FormatText(var_40_10.content)

				arg_37_1.text_.text = var_40_11

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_13 = 17 <= 0 and var_40_9 or var_40_9 * (utf8.len(var_40_11) / 17)

				if (17 <= 0 and var_40_9 or var_40_9 * (utf8.len(var_40_11) / 17)) > 0 and var_40_9 < var_40_13 then
					arg_37_1.talkMaxDuration = var_40_13

					if var_40_13 + var_40_8 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_13 + var_40_8
					end
				end

				arg_37_1.text_.text = var_40_11
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031009", "story_v_out_412031.awb") ~= 0 then
					local var_40_14 = manager.audio:GetVoiceLength("story_v_out_412031", "412031009", "story_v_out_412031.awb") / 1000

					if var_40_14 + var_40_8 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_14 + var_40_8
					end

					if var_40_10.prefab_name ~= "" and arg_37_1.actors_[var_40_10.prefab_name] ~= nil then
						local var_40_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_10.prefab_name].transform, "story_v_out_412031", "412031009", "story_v_out_412031.awb")

						arg_37_1:RecordAudio("412031009", var_40_15)
						arg_37_1:RecordAudio("412031009", var_40_15)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_412031", "412031009", "story_v_out_412031.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_412031", "412031009", "story_v_out_412031.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_16 = math.max(var_40_9, arg_37_1.talkMaxDuration)

			if var_40_8 <= arg_37_1.time_ and arg_37_1.time_ < var_40_8 + var_40_16 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_8) / var_40_16

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_8 + var_40_16 and arg_37_1.time_ < var_40_8 + var_40_16 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_37_1:InitPlayNodeList()
	end,
	Play412031010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 412031010
		arg_41_1.duration_ = 5.03

		local var_41_0 = {
			zh = 5.033,
			ja = 3.933
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
				arg_41_0:Play412031011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.var_.moveOldPos1097ui_story = arg_41_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_44_0 = 0.001

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_0 then
				arg_41_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos1097ui_story, Vector3.New(-0.7, -0.54, -6.3), (arg_41_1.time_ - 0) / var_44_0)
				arg_41_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_41_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1097ui_story"].transform.position).z)
				arg_41_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_41_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_41_1.actors_["1097ui_story"].transform.localEulerAngles = arg_41_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_41_1.time_ >= 0 + var_44_0 and arg_41_1.time_ < 0 + var_44_0 + arg_44_0 then
				arg_41_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(-0.7, -0.54, -6.3)
				arg_41_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_41_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1097ui_story"].transform.position).z)
				arg_41_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_41_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_41_1.actors_["1097ui_story"].transform.localEulerAngles = arg_41_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_44_1 = arg_41_1.actors_["1097ui_story"]

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(var_44_1) and arg_41_1.var_.characterEffect1097ui_story == nil then
				arg_41_1.var_.characterEffect1097ui_story = var_44_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_2 = 0.200000002980232

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_2 and not isNil(var_44_1) then
				if arg_41_1.var_.characterEffect1097ui_story and not isNil(var_44_1) then
					arg_41_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_41_1.time_ >= 0 + var_44_2 and arg_41_1.time_ < 0 + var_44_2 + arg_44_0 and not isNil(var_44_1) and arg_41_1.var_.characterEffect1097ui_story then
				arg_41_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_44_4 = arg_41_1.actors_["3043ui_story"].transform

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.var_.moveOldPos3043ui_story = var_44_4.localPosition
			end

			local var_44_5 = 0.001

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_5 then
				var_44_4.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos3043ui_story, Vector3.New(0.7, -1.41, -5.7), (arg_41_1.time_ - 0) / var_44_5)
				var_44_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_44_4.position).x, (manager.ui.mainCamera.transform.position - var_44_4.position).y, (manager.ui.mainCamera.transform.position - var_44_4.position).z)
				var_44_4.localEulerAngles.z = 0
				var_44_4.localEulerAngles.x = 0
				var_44_4.localEulerAngles = var_44_4.localEulerAngles
			end

			if arg_41_1.time_ >= 0 + var_44_5 and arg_41_1.time_ < 0 + var_44_5 + arg_44_0 then
				var_44_4.localPosition = Vector3.New(0.7, -1.41, -5.7)
				var_44_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_44_4.position).x, (manager.ui.mainCamera.transform.position - var_44_4.position).y, (manager.ui.mainCamera.transform.position - var_44_4.position).z)
				var_44_4.localEulerAngles.z = 0
				var_44_4.localEulerAngles.x = 0
				var_44_4.localEulerAngles = var_44_4.localEulerAngles
			end

			local var_44_6 = arg_41_1.actors_["3043ui_story"]

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(var_44_6) and arg_41_1.var_.characterEffect3043ui_story == nil then
				arg_41_1.var_.characterEffect3043ui_story = var_44_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_7 = 0.200000002980232

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_7 and not isNil(var_44_6) then
				if arg_41_1.var_.characterEffect3043ui_story and not isNil(var_44_6) then
					arg_41_1.var_.characterEffect3043ui_story.fillFlat = true
					arg_41_1.var_.characterEffect3043ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_41_1.time_ - 0) / var_44_7)
				end
			end

			if arg_41_1.time_ >= 0 + var_44_7 and arg_41_1.time_ < 0 + var_44_7 + arg_44_0 and not isNil(var_44_6) and arg_41_1.var_.characterEffect3043ui_story then
				arg_41_1.var_.characterEffect3043ui_story.fillFlat = true
				arg_41_1.var_.characterEffect3043ui_story.fillRatio = 0.5
			end

			local var_44_8 = 0
			local var_44_9 = 0.425

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_8 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_10 = arg_41_1:GetWordFromCfg(412031010)
				local var_44_11 = arg_41_1:FormatText(var_44_10.content)

				arg_41_1.text_.text = var_44_11

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_13 = 17 <= 0 and var_44_9 or var_44_9 * (utf8.len(var_44_11) / 17)

				if (17 <= 0 and var_44_9 or var_44_9 * (utf8.len(var_44_11) / 17)) > 0 and var_44_9 < var_44_13 then
					arg_41_1.talkMaxDuration = var_44_13

					if var_44_13 + var_44_8 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_13 + var_44_8
					end
				end

				arg_41_1.text_.text = var_44_11
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031010", "story_v_out_412031.awb") ~= 0 then
					local var_44_14 = manager.audio:GetVoiceLength("story_v_out_412031", "412031010", "story_v_out_412031.awb") / 1000

					if var_44_14 + var_44_8 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_14 + var_44_8
					end

					if var_44_10.prefab_name ~= "" and arg_41_1.actors_[var_44_10.prefab_name] ~= nil then
						local var_44_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_10.prefab_name].transform, "story_v_out_412031", "412031010", "story_v_out_412031.awb")

						arg_41_1:RecordAudio("412031010", var_44_15)
						arg_41_1:RecordAudio("412031010", var_44_15)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_412031", "412031010", "story_v_out_412031.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_412031", "412031010", "story_v_out_412031.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_16 = math.max(var_44_9, arg_41_1.talkMaxDuration)

			if var_44_8 <= arg_41_1.time_ and arg_41_1.time_ < var_44_8 + var_44_16 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_8) / var_44_16

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_8 + var_44_16 and arg_41_1.time_ < var_44_8 + var_44_16 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "3043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_41_1:InitPlayNodeList()
	end,
	Play412031011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 412031011
		arg_45_1.duration_ = 5

		local var_45_0 = {
			zh = 3.4,
			ja = 5
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
				arg_45_0:Play412031012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.var_.moveOldPos3043ui_story = arg_45_1.actors_["3043ui_story"].transform.localPosition
			end

			local var_48_0 = 0.001

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_0 then
				arg_45_1.actors_["3043ui_story"].transform.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos3043ui_story, Vector3.New(0.7, -1.41, -5.7), (arg_45_1.time_ - 0) / var_48_0)
				arg_45_1.actors_["3043ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_45_1.actors_["3043ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["3043ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["3043ui_story"].transform.position).z)
				arg_45_1.actors_["3043ui_story"].transform.localEulerAngles.z = 0
				arg_45_1.actors_["3043ui_story"].transform.localEulerAngles.x = 0
				arg_45_1.actors_["3043ui_story"].transform.localEulerAngles = arg_45_1.actors_["3043ui_story"].transform.localEulerAngles
			end

			if arg_45_1.time_ >= 0 + var_48_0 and arg_45_1.time_ < 0 + var_48_0 + arg_48_0 then
				arg_45_1.actors_["3043ui_story"].transform.localPosition = Vector3.New(0.7, -1.41, -5.7)
				arg_45_1.actors_["3043ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_45_1.actors_["3043ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["3043ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["3043ui_story"].transform.position).z)
				arg_45_1.actors_["3043ui_story"].transform.localEulerAngles.z = 0
				arg_45_1.actors_["3043ui_story"].transform.localEulerAngles.x = 0
				arg_45_1.actors_["3043ui_story"].transform.localEulerAngles = arg_45_1.actors_["3043ui_story"].transform.localEulerAngles
			end

			local var_48_1 = arg_45_1.actors_["3043ui_story"]

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(var_48_1) and arg_45_1.var_.characterEffect3043ui_story == nil then
				arg_45_1.var_.characterEffect3043ui_story = var_48_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_2 = 0.200000002980232

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_2 and not isNil(var_48_1) then
				if arg_45_1.var_.characterEffect3043ui_story and not isNil(var_48_1) then
					arg_45_1.var_.characterEffect3043ui_story.fillFlat = false
				end
			end

			if arg_45_1.time_ >= 0 + var_48_2 and arg_45_1.time_ < 0 + var_48_2 + arg_48_0 and not isNil(var_48_1) and arg_45_1.var_.characterEffect3043ui_story then
				arg_45_1.var_.characterEffect3043ui_story.fillFlat = false
			end

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1:PlayTimeline("3043ui_story", "StoryTimeline/CharAction/story3043/story3043action/3043action1_1")
			end

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1:PlayTimeline("3043ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_48_4 = arg_45_1.actors_["1097ui_story"]

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(var_48_4) and arg_45_1.var_.characterEffect1097ui_story == nil then
				arg_45_1.var_.characterEffect1097ui_story = var_48_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_5 = 0.200000002980232

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_5 and not isNil(var_48_4) then
				if arg_45_1.var_.characterEffect1097ui_story and not isNil(var_48_4) then
					arg_45_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_45_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_45_1.time_ - 0) / var_48_5)
				end
			end

			if arg_45_1.time_ >= 0 + var_48_5 and arg_45_1.time_ < 0 + var_48_5 + arg_48_0 and not isNil(var_48_4) and arg_45_1.var_.characterEffect1097ui_story then
				arg_45_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_45_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_48_6 = 0
			local var_48_7 = 0.375

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_6 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[920].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_8 = arg_45_1:GetWordFromCfg(412031011)
				local var_48_9 = arg_45_1:FormatText(var_48_8.content)

				arg_45_1.text_.text = var_48_9

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_11 = 15 <= 0 and var_48_7 or var_48_7 * (utf8.len(var_48_9) / 15)

				if (15 <= 0 and var_48_7 or var_48_7 * (utf8.len(var_48_9) / 15)) > 0 and var_48_7 < var_48_11 then
					arg_45_1.talkMaxDuration = var_48_11

					if var_48_11 + var_48_6 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_11 + var_48_6
					end
				end

				arg_45_1.text_.text = var_48_9
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031011", "story_v_out_412031.awb") ~= 0 then
					local var_48_12 = manager.audio:GetVoiceLength("story_v_out_412031", "412031011", "story_v_out_412031.awb") / 1000

					if var_48_12 + var_48_6 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_12 + var_48_6
					end

					if var_48_8.prefab_name ~= "" and arg_45_1.actors_[var_48_8.prefab_name] ~= nil then
						local var_48_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_8.prefab_name].transform, "story_v_out_412031", "412031011", "story_v_out_412031.awb")

						arg_45_1:RecordAudio("412031011", var_48_13)
						arg_45_1:RecordAudio("412031011", var_48_13)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_412031", "412031011", "story_v_out_412031.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_412031", "412031011", "story_v_out_412031.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_14 = math.max(var_48_7, arg_45_1.talkMaxDuration)

			if var_48_6 <= arg_45_1.time_ and arg_45_1.time_ < var_48_6 + var_48_14 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_6) / var_48_14

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_6 + var_48_14 and arg_45_1.time_ < var_48_6 + var_48_14 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3043ui_story",
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
	Play412031012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 412031012
		arg_49_1.duration_ = 8

		local var_49_0 = {
			zh = 6.033,
			ja = 8
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
				arg_49_0:Play412031013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.var_.moveOldPos1097ui_story = arg_49_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_52_0 = 0.001

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_0 then
				arg_49_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos1097ui_story, Vector3.New(-0.7, -0.54, -6.3), (arg_49_1.time_ - 0) / var_52_0)
				arg_49_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_49_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["1097ui_story"].transform.position).z)
				arg_49_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_49_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_49_1.actors_["1097ui_story"].transform.localEulerAngles = arg_49_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_49_1.time_ >= 0 + var_52_0 and arg_49_1.time_ < 0 + var_52_0 + arg_52_0 then
				arg_49_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(-0.7, -0.54, -6.3)
				arg_49_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_49_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["1097ui_story"].transform.position).z)
				arg_49_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_49_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_49_1.actors_["1097ui_story"].transform.localEulerAngles = arg_49_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_52_1 = arg_49_1.actors_["1097ui_story"]

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(var_52_1) and arg_49_1.var_.characterEffect1097ui_story == nil then
				arg_49_1.var_.characterEffect1097ui_story = var_52_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_2 = 0.200000002980232

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_2 and not isNil(var_52_1) then
				if arg_49_1.var_.characterEffect1097ui_story and not isNil(var_52_1) then
					arg_49_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_49_1.time_ >= 0 + var_52_2 and arg_49_1.time_ < 0 + var_52_2 + arg_52_0 and not isNil(var_52_1) and arg_49_1.var_.characterEffect1097ui_story then
				arg_49_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_52_4 = arg_49_1.actors_["3043ui_story"]

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(var_52_4) and arg_49_1.var_.characterEffect3043ui_story == nil then
				arg_49_1.var_.characterEffect3043ui_story = var_52_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_5 = 0.200000002980232

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_5 and not isNil(var_52_4) then
				if arg_49_1.var_.characterEffect3043ui_story and not isNil(var_52_4) then
					arg_49_1.var_.characterEffect3043ui_story.fillFlat = true
					arg_49_1.var_.characterEffect3043ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_49_1.time_ - 0) / var_52_5)
				end
			end

			if arg_49_1.time_ >= 0 + var_52_5 and arg_49_1.time_ < 0 + var_52_5 + arg_52_0 and not isNil(var_52_4) and arg_49_1.var_.characterEffect3043ui_story then
				arg_49_1.var_.characterEffect3043ui_story.fillFlat = true
				arg_49_1.var_.characterEffect3043ui_story.fillRatio = 0.5
			end

			local var_52_6 = 0
			local var_52_7 = 0.475

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_6 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_8 = arg_49_1:GetWordFromCfg(412031012)
				local var_52_9 = arg_49_1:FormatText(var_52_8.content)

				arg_49_1.text_.text = var_52_9

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_11 = 19 <= 0 and var_52_7 or var_52_7 * (utf8.len(var_52_9) / 19)

				if (19 <= 0 and var_52_7 or var_52_7 * (utf8.len(var_52_9) / 19)) > 0 and var_52_7 < var_52_11 then
					arg_49_1.talkMaxDuration = var_52_11

					if var_52_11 + var_52_6 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_11 + var_52_6
					end
				end

				arg_49_1.text_.text = var_52_9
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031012", "story_v_out_412031.awb") ~= 0 then
					local var_52_12 = manager.audio:GetVoiceLength("story_v_out_412031", "412031012", "story_v_out_412031.awb") / 1000

					if var_52_12 + var_52_6 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_12 + var_52_6
					end

					if var_52_8.prefab_name ~= "" and arg_49_1.actors_[var_52_8.prefab_name] ~= nil then
						local var_52_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_8.prefab_name].transform, "story_v_out_412031", "412031012", "story_v_out_412031.awb")

						arg_49_1:RecordAudio("412031012", var_52_13)
						arg_49_1:RecordAudio("412031012", var_52_13)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_412031", "412031012", "story_v_out_412031.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_412031", "412031012", "story_v_out_412031.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_14 = math.max(var_52_7, arg_49_1.talkMaxDuration)

			if var_52_6 <= arg_49_1.time_ and arg_49_1.time_ < var_52_6 + var_52_14 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_6) / var_52_14

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_6 + var_52_14 and arg_49_1.time_ < var_52_6 + var_52_14 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_49_1:InitPlayNodeList()
	end,
	Play412031013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 412031013
		arg_53_1.duration_ = 11.77

		local var_53_0 = {
			zh = 5.666,
			ja = 11.766
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
				arg_53_0:Play412031014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(arg_53_1.actors_["3043ui_story"]) and arg_53_1.var_.characterEffect3043ui_story == nil then
				arg_53_1.var_.characterEffect3043ui_story = arg_53_1.actors_["3043ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_0 = 0.200000002980232

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_0 and not isNil(arg_53_1.actors_["3043ui_story"]) then
				if arg_53_1.var_.characterEffect3043ui_story and not isNil(arg_53_1.actors_["3043ui_story"]) then
					arg_53_1.var_.characterEffect3043ui_story.fillFlat = false
				end
			end

			if arg_53_1.time_ >= 0 + var_56_0 and arg_53_1.time_ < 0 + var_56_0 + arg_56_0 and not isNil(arg_53_1.actors_["3043ui_story"]) and arg_53_1.var_.characterEffect3043ui_story then
				arg_53_1.var_.characterEffect3043ui_story.fillFlat = false
			end

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1:PlayTimeline("3043ui_story", "StoryTimeline/CharAction/story3043/story3043action/3043action1_1")
			end

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1:PlayTimeline("3043ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_56_2 = arg_53_1.actors_["1097ui_story"]

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(var_56_2) and arg_53_1.var_.characterEffect1097ui_story == nil then
				arg_53_1.var_.characterEffect1097ui_story = var_56_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_3 = 0.200000002980232

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_3 and not isNil(var_56_2) then
				if arg_53_1.var_.characterEffect1097ui_story and not isNil(var_56_2) then
					arg_53_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_53_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_53_1.time_ - 0) / var_56_3)
				end
			end

			if arg_53_1.time_ >= 0 + var_56_3 and arg_53_1.time_ < 0 + var_56_3 + arg_56_0 and not isNil(var_56_2) and arg_53_1.var_.characterEffect1097ui_story then
				arg_53_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_53_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_56_4 = 0
			local var_56_5 = 0.6

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_4 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[920].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_6 = arg_53_1:GetWordFromCfg(412031013)
				local var_56_7 = arg_53_1:FormatText(var_56_6.content)

				arg_53_1.text_.text = var_56_7

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_9 = 24 <= 0 and var_56_5 or var_56_5 * (utf8.len(var_56_7) / 24)

				if (24 <= 0 and var_56_5 or var_56_5 * (utf8.len(var_56_7) / 24)) > 0 and var_56_5 < var_56_9 then
					arg_53_1.talkMaxDuration = var_56_9

					if var_56_9 + var_56_4 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_9 + var_56_4
					end
				end

				arg_53_1.text_.text = var_56_7
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031013", "story_v_out_412031.awb") ~= 0 then
					local var_56_10 = manager.audio:GetVoiceLength("story_v_out_412031", "412031013", "story_v_out_412031.awb") / 1000

					if var_56_10 + var_56_4 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_10 + var_56_4
					end

					if var_56_6.prefab_name ~= "" and arg_53_1.actors_[var_56_6.prefab_name] ~= nil then
						local var_56_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_6.prefab_name].transform, "story_v_out_412031", "412031013", "story_v_out_412031.awb")

						arg_53_1:RecordAudio("412031013", var_56_11)
						arg_53_1:RecordAudio("412031013", var_56_11)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_412031", "412031013", "story_v_out_412031.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_412031", "412031013", "story_v_out_412031.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_12 = math.max(var_56_5, arg_53_1.talkMaxDuration)

			if var_56_4 <= arg_53_1.time_ and arg_53_1.time_ < var_56_4 + var_56_12 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_4) / var_56_12

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_4 + var_56_12 and arg_53_1.time_ < var_56_4 + var_56_12 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play412031014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 412031014
		arg_57_1.duration_ = 4.43

		local var_57_0 = {
			zh = 2.766,
			ja = 4.433
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
				arg_57_0:Play412031015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(arg_57_1.actors_["1097ui_story"]) and arg_57_1.var_.characterEffect1097ui_story == nil then
				arg_57_1.var_.characterEffect1097ui_story = arg_57_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_0 = 0.200000002980232

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_0 and not isNil(arg_57_1.actors_["1097ui_story"]) then
				if arg_57_1.var_.characterEffect1097ui_story and not isNil(arg_57_1.actors_["1097ui_story"]) then
					arg_57_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_57_1.time_ >= 0 + var_60_0 and arg_57_1.time_ < 0 + var_60_0 + arg_60_0 and not isNil(arg_57_1.actors_["1097ui_story"]) and arg_57_1.var_.characterEffect1097ui_story then
				arg_57_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_60_2 = arg_57_1.actors_["3043ui_story"]

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(var_60_2) and arg_57_1.var_.characterEffect3043ui_story == nil then
				arg_57_1.var_.characterEffect3043ui_story = var_60_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_3 = 0.200000002980232

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_3 and not isNil(var_60_2) then
				if arg_57_1.var_.characterEffect3043ui_story and not isNil(var_60_2) then
					arg_57_1.var_.characterEffect3043ui_story.fillFlat = true
					arg_57_1.var_.characterEffect3043ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_57_1.time_ - 0) / var_60_3)
				end
			end

			if arg_57_1.time_ >= 0 + var_60_3 and arg_57_1.time_ < 0 + var_60_3 + arg_60_0 and not isNil(var_60_2) and arg_57_1.var_.characterEffect3043ui_story then
				arg_57_1.var_.characterEffect3043ui_story.fillFlat = true
				arg_57_1.var_.characterEffect3043ui_story.fillRatio = 0.5
			end

			local var_60_4 = 0
			local var_60_5 = 0.175

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_4 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_6 = arg_57_1:GetWordFromCfg(412031014)
				local var_60_7 = arg_57_1:FormatText(var_60_6.content)

				arg_57_1.text_.text = var_60_7

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_9 = 7 <= 0 and var_60_5 or var_60_5 * (utf8.len(var_60_7) / 7)

				if (7 <= 0 and var_60_5 or var_60_5 * (utf8.len(var_60_7) / 7)) > 0 and var_60_5 < var_60_9 then
					arg_57_1.talkMaxDuration = var_60_9

					if var_60_9 + var_60_4 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_9 + var_60_4
					end
				end

				arg_57_1.text_.text = var_60_7
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031014", "story_v_out_412031.awb") ~= 0 then
					local var_60_10 = manager.audio:GetVoiceLength("story_v_out_412031", "412031014", "story_v_out_412031.awb") / 1000

					if var_60_10 + var_60_4 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_10 + var_60_4
					end

					if var_60_6.prefab_name ~= "" and arg_57_1.actors_[var_60_6.prefab_name] ~= nil then
						local var_60_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_6.prefab_name].transform, "story_v_out_412031", "412031014", "story_v_out_412031.awb")

						arg_57_1:RecordAudio("412031014", var_60_11)
						arg_57_1:RecordAudio("412031014", var_60_11)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_412031", "412031014", "story_v_out_412031.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_412031", "412031014", "story_v_out_412031.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_12 = math.max(var_60_5, arg_57_1.talkMaxDuration)

			if var_60_4 <= arg_57_1.time_ and arg_57_1.time_ < var_60_4 + var_60_12 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_4) / var_60_12

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_4 + var_60_12 and arg_57_1.time_ < var_60_4 + var_60_12 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play412031015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 412031015
		arg_61_1.duration_ = 8.57

		local var_61_0 = {
			zh = 4.3,
			ja = 8.566
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
				arg_61_0:Play412031016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(arg_61_1.actors_["3043ui_story"]) and arg_61_1.var_.characterEffect3043ui_story == nil then
				arg_61_1.var_.characterEffect3043ui_story = arg_61_1.actors_["3043ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_0 = 0.200000002980232

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_0 and not isNil(arg_61_1.actors_["3043ui_story"]) then
				if arg_61_1.var_.characterEffect3043ui_story and not isNil(arg_61_1.actors_["3043ui_story"]) then
					arg_61_1.var_.characterEffect3043ui_story.fillFlat = false
				end
			end

			if arg_61_1.time_ >= 0 + var_64_0 and arg_61_1.time_ < 0 + var_64_0 + arg_64_0 and not isNil(arg_61_1.actors_["3043ui_story"]) and arg_61_1.var_.characterEffect3043ui_story then
				arg_61_1.var_.characterEffect3043ui_story.fillFlat = false
			end

			local var_64_2 = arg_61_1.actors_["1097ui_story"]

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(var_64_2) and arg_61_1.var_.characterEffect1097ui_story == nil then
				arg_61_1.var_.characterEffect1097ui_story = var_64_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_3 = 0.200000002980232

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_3 and not isNil(var_64_2) then
				if arg_61_1.var_.characterEffect1097ui_story and not isNil(var_64_2) then
					arg_61_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_61_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_61_1.time_ - 0) / var_64_3)
				end
			end

			if arg_61_1.time_ >= 0 + var_64_3 and arg_61_1.time_ < 0 + var_64_3 + arg_64_0 and not isNil(var_64_2) and arg_61_1.var_.characterEffect1097ui_story then
				arg_61_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_61_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_64_4 = 0
			local var_64_5 = 0.375

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_4 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[920].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_6 = arg_61_1:GetWordFromCfg(412031015)
				local var_64_7 = arg_61_1:FormatText(var_64_6.content)

				arg_61_1.text_.text = var_64_7

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_9 = 15 <= 0 and var_64_5 or var_64_5 * (utf8.len(var_64_7) / 15)

				if (15 <= 0 and var_64_5 or var_64_5 * (utf8.len(var_64_7) / 15)) > 0 and var_64_5 < var_64_9 then
					arg_61_1.talkMaxDuration = var_64_9

					if var_64_9 + var_64_4 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_9 + var_64_4
					end
				end

				arg_61_1.text_.text = var_64_7
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031015", "story_v_out_412031.awb") ~= 0 then
					local var_64_10 = manager.audio:GetVoiceLength("story_v_out_412031", "412031015", "story_v_out_412031.awb") / 1000

					if var_64_10 + var_64_4 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_10 + var_64_4
					end

					if var_64_6.prefab_name ~= "" and arg_61_1.actors_[var_64_6.prefab_name] ~= nil then
						local var_64_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_6.prefab_name].transform, "story_v_out_412031", "412031015", "story_v_out_412031.awb")

						arg_61_1:RecordAudio("412031015", var_64_11)
						arg_61_1:RecordAudio("412031015", var_64_11)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_412031", "412031015", "story_v_out_412031.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_412031", "412031015", "story_v_out_412031.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_12 = math.max(var_64_5, arg_61_1.talkMaxDuration)

			if var_64_4 <= arg_61_1.time_ and arg_61_1.time_ < var_64_4 + var_64_12 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_4) / var_64_12

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_4 + var_64_12 and arg_61_1.time_ < var_64_4 + var_64_12 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play412031016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 412031016
		arg_65_1.duration_ = 6.63

		local var_65_0 = {
			zh = 6.333,
			ja = 6.633
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
				arg_65_0:Play412031017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if arg_65_1.actors_["10083ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10083ui_story"))) then
				local var_68_0 = Object.Instantiate(Asset.Load("Char/" .. "10083ui_story"), arg_65_1.stage_.transform)

				var_68_0.name = "10083ui_story"
				var_68_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_65_1.actors_["10083ui_story"] = var_68_0

				local var_68_1 = var_68_0:GetComponentInChildren(typeof(CharacterEffect))

				var_68_1.enabled = true

				local var_68_2 = GameObjectTools.GetOrAddComponent(var_68_0, typeof(DynamicBoneHelper))

				if var_68_2 then
					var_68_2:EnableDynamicBone(false)
				end

				arg_65_1:ShowWeapon(var_68_1.transform, false)

				arg_65_1.var_["10083ui_story" .. "Animator"] = var_68_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_65_1.var_["10083ui_story" .. "Animator"].applyRootMotion = true
				arg_65_1.var_["10083ui_story" .. "LipSync"] = var_68_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_68_3 = arg_65_1.actors_["10083ui_story"].transform

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.var_.moveOldPos10083ui_story = var_68_3.localPosition
			end

			local var_68_4 = 0.001

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_4 then
				var_68_3.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos10083ui_story, Vector3.New(0, -2.6, -2.8), (arg_65_1.time_ - 0) / var_68_4)
				var_68_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_68_3.position).x, (manager.ui.mainCamera.transform.position - var_68_3.position).y, (manager.ui.mainCamera.transform.position - var_68_3.position).z)
				var_68_3.localEulerAngles.z = 0
				var_68_3.localEulerAngles.x = 0
				var_68_3.localEulerAngles = var_68_3.localEulerAngles
			end

			if arg_65_1.time_ >= 0 + var_68_4 and arg_65_1.time_ < 0 + var_68_4 + arg_68_0 then
				var_68_3.localPosition = Vector3.New(0, -2.6, -2.8)
				var_68_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_68_3.position).x, (manager.ui.mainCamera.transform.position - var_68_3.position).y, (manager.ui.mainCamera.transform.position - var_68_3.position).z)
				var_68_3.localEulerAngles.z = 0
				var_68_3.localEulerAngles.x = 0
				var_68_3.localEulerAngles = var_68_3.localEulerAngles
			end

			local var_68_5 = arg_65_1.actors_["10083ui_story"]

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(var_68_5) and arg_65_1.var_.characterEffect10083ui_story == nil then
				arg_65_1.var_.characterEffect10083ui_story = var_68_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_6 = 0.200000002980232

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_6 and not isNil(var_68_5) then
				if arg_65_1.var_.characterEffect10083ui_story and not isNil(var_68_5) then
					arg_65_1.var_.characterEffect10083ui_story.fillFlat = false
				end
			end

			if arg_65_1.time_ >= 0 + var_68_6 and arg_65_1.time_ < 0 + var_68_6 + arg_68_0 and not isNil(var_68_5) and arg_65_1.var_.characterEffect10083ui_story then
				arg_65_1.var_.characterEffect10083ui_story.fillFlat = false
			end

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1:PlayTimeline("10083ui_story", "StoryTimeline/CharAction/story10083/story10083action/10083action4_1")
			end

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1:PlayTimeline("10083ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_68_8 = arg_65_1.actors_["3043ui_story"].transform

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.var_.moveOldPos3043ui_story = var_68_8.localPosition
			end

			local var_68_9 = 0.001

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_9 then
				var_68_8.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos3043ui_story, Vector3.New(0, 100, 0), (arg_65_1.time_ - 0) / var_68_9)
				var_68_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_68_8.position).x, (manager.ui.mainCamera.transform.position - var_68_8.position).y, (manager.ui.mainCamera.transform.position - var_68_8.position).z)
				var_68_8.localEulerAngles.z = 0
				var_68_8.localEulerAngles.x = 0
				var_68_8.localEulerAngles = var_68_8.localEulerAngles
			end

			if arg_65_1.time_ >= 0 + var_68_9 and arg_65_1.time_ < 0 + var_68_9 + arg_68_0 then
				var_68_8.localPosition = Vector3.New(0, 100, 0)
				var_68_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_68_8.position).x, (manager.ui.mainCamera.transform.position - var_68_8.position).y, (manager.ui.mainCamera.transform.position - var_68_8.position).z)
				var_68_8.localEulerAngles.z = 0
				var_68_8.localEulerAngles.x = 0
				var_68_8.localEulerAngles = var_68_8.localEulerAngles
			end

			local var_68_10 = arg_65_1.actors_["3043ui_story"]

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(var_68_10) and arg_65_1.var_.characterEffect3043ui_story == nil then
				arg_65_1.var_.characterEffect3043ui_story = var_68_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_11 = 0.200000002980232

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_11 and not isNil(var_68_10) then
				if arg_65_1.var_.characterEffect3043ui_story and not isNil(var_68_10) then
					arg_65_1.var_.characterEffect3043ui_story.fillFlat = true
					arg_65_1.var_.characterEffect3043ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_65_1.time_ - 0) / var_68_11)
				end
			end

			if arg_65_1.time_ >= 0 + var_68_11 and arg_65_1.time_ < 0 + var_68_11 + arg_68_0 and not isNil(var_68_10) and arg_65_1.var_.characterEffect3043ui_story then
				arg_65_1.var_.characterEffect3043ui_story.fillFlat = true
				arg_65_1.var_.characterEffect3043ui_story.fillRatio = 0.5
			end

			local var_68_12 = arg_65_1.actors_["1097ui_story"].transform

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.var_.moveOldPos1097ui_story = var_68_12.localPosition
			end

			local var_68_13 = 0.001

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_13 then
				var_68_12.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos1097ui_story, Vector3.New(0, 100, 0), (arg_65_1.time_ - 0) / var_68_13)
				var_68_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_68_12.position).x, (manager.ui.mainCamera.transform.position - var_68_12.position).y, (manager.ui.mainCamera.transform.position - var_68_12.position).z)
				var_68_12.localEulerAngles.z = 0
				var_68_12.localEulerAngles.x = 0
				var_68_12.localEulerAngles = var_68_12.localEulerAngles
			end

			if arg_65_1.time_ >= 0 + var_68_13 and arg_65_1.time_ < 0 + var_68_13 + arg_68_0 then
				var_68_12.localPosition = Vector3.New(0, 100, 0)
				var_68_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_68_12.position).x, (manager.ui.mainCamera.transform.position - var_68_12.position).y, (manager.ui.mainCamera.transform.position - var_68_12.position).z)
				var_68_12.localEulerAngles.z = 0
				var_68_12.localEulerAngles.x = 0
				var_68_12.localEulerAngles = var_68_12.localEulerAngles
			end

			local var_68_14 = arg_65_1.actors_["1097ui_story"]

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(var_68_14) and arg_65_1.var_.characterEffect1097ui_story == nil then
				arg_65_1.var_.characterEffect1097ui_story = var_68_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_15 = 0.200000002980232

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_15 and not isNil(var_68_14) then
				if arg_65_1.var_.characterEffect1097ui_story and not isNil(var_68_14) then
					arg_65_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_65_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_65_1.time_ - 0) / var_68_15)
				end
			end

			if arg_65_1.time_ >= 0 + var_68_15 and arg_65_1.time_ < 0 + var_68_15 + arg_68_0 and not isNil(var_68_14) and arg_65_1.var_.characterEffect1097ui_story then
				arg_65_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_65_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_68_16 = 0
			local var_68_17 = 0.625

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_16 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[918].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_18 = arg_65_1:GetWordFromCfg(412031016)
				local var_68_19 = arg_65_1:FormatText(var_68_18.content)

				arg_65_1.text_.text = var_68_19

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_21 = 25 <= 0 and var_68_17 or var_68_17 * (utf8.len(var_68_19) / 25)

				if (25 <= 0 and var_68_17 or var_68_17 * (utf8.len(var_68_19) / 25)) > 0 and var_68_17 < var_68_21 then
					arg_65_1.talkMaxDuration = var_68_21

					if var_68_21 + var_68_16 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_21 + var_68_16
					end
				end

				arg_65_1.text_.text = var_68_19
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031016", "story_v_out_412031.awb") ~= 0 then
					local var_68_22 = manager.audio:GetVoiceLength("story_v_out_412031", "412031016", "story_v_out_412031.awb") / 1000

					if var_68_22 + var_68_16 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_22 + var_68_16
					end

					if var_68_18.prefab_name ~= "" and arg_65_1.actors_[var_68_18.prefab_name] ~= nil then
						local var_68_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_18.prefab_name].transform, "story_v_out_412031", "412031016", "story_v_out_412031.awb")

						arg_65_1:RecordAudio("412031016", var_68_23)
						arg_65_1:RecordAudio("412031016", var_68_23)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_412031", "412031016", "story_v_out_412031.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_412031", "412031016", "story_v_out_412031.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_24 = math.max(var_68_17, arg_65_1.talkMaxDuration)

			if var_68_16 <= arg_65_1.time_ and arg_65_1.time_ < var_68_16 + var_68_24 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_16) / var_68_24

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_16 + var_68_24 and arg_65_1.time_ < var_68_16 + var_68_24 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10083ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "3043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_65_1:InitPlayNodeList()
	end,
	Play412031017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 412031017
		arg_69_1.duration_ = 5.47

		local var_69_0 = {
			zh = 5.466,
			ja = 3.833
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
				arg_69_0:Play412031018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if arg_69_1.actors_["10076ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10076ui_story"))) then
				local var_72_0 = Object.Instantiate(Asset.Load("Char/" .. "10076ui_story"), arg_69_1.stage_.transform)

				var_72_0.name = "10076ui_story"
				var_72_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_69_1.actors_["10076ui_story"] = var_72_0

				local var_72_1 = var_72_0:GetComponentInChildren(typeof(CharacterEffect))

				var_72_1.enabled = true

				local var_72_2 = GameObjectTools.GetOrAddComponent(var_72_0, typeof(DynamicBoneHelper))

				if var_72_2 then
					var_72_2:EnableDynamicBone(false)
				end

				arg_69_1:ShowWeapon(var_72_1.transform, false)

				arg_69_1.var_["10076ui_story" .. "Animator"] = var_72_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_69_1.var_["10076ui_story" .. "Animator"].applyRootMotion = true
				arg_69_1.var_["10076ui_story" .. "LipSync"] = var_72_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_72_3 = arg_69_1.actors_["10076ui_story"].transform

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.var_.moveOldPos10076ui_story = var_72_3.localPosition
			end

			local var_72_4 = 0.001

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_4 then
				var_72_3.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos10076ui_story, Vector3.New(0, -0.35, -4), (arg_69_1.time_ - 0) / var_72_4)
				var_72_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_72_3.position).x, (manager.ui.mainCamera.transform.position - var_72_3.position).y, (manager.ui.mainCamera.transform.position - var_72_3.position).z)
				var_72_3.localEulerAngles.z = 0
				var_72_3.localEulerAngles.x = 0
				var_72_3.localEulerAngles = var_72_3.localEulerAngles
			end

			if arg_69_1.time_ >= 0 + var_72_4 and arg_69_1.time_ < 0 + var_72_4 + arg_72_0 then
				var_72_3.localPosition = Vector3.New(0, -0.35, -4)
				var_72_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_72_3.position).x, (manager.ui.mainCamera.transform.position - var_72_3.position).y, (manager.ui.mainCamera.transform.position - var_72_3.position).z)
				var_72_3.localEulerAngles.z = 0
				var_72_3.localEulerAngles.x = 0
				var_72_3.localEulerAngles = var_72_3.localEulerAngles
			end

			local var_72_5 = arg_69_1.actors_["10076ui_story"]

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(var_72_5) and arg_69_1.var_.characterEffect10076ui_story == nil then
				arg_69_1.var_.characterEffect10076ui_story = var_72_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_6 = 0.200000002980232

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_6 and not isNil(var_72_5) then
				if arg_69_1.var_.characterEffect10076ui_story and not isNil(var_72_5) then
					arg_69_1.var_.characterEffect10076ui_story.fillFlat = false
				end
			end

			if arg_69_1.time_ >= 0 + var_72_6 and arg_69_1.time_ < 0 + var_72_6 + arg_72_0 and not isNil(var_72_5) and arg_69_1.var_.characterEffect10076ui_story then
				arg_69_1.var_.characterEffect10076ui_story.fillFlat = false
			end

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1:PlayTimeline("10076ui_story", "StoryTimeline/CharAction/story10076/story10076action/10076action2_1")
			end

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1:PlayTimeline("10076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_72_8 = arg_69_1.actors_["10083ui_story"].transform

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.var_.moveOldPos10083ui_story = var_72_8.localPosition
			end

			local var_72_9 = 0.001

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_9 then
				var_72_8.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos10083ui_story, Vector3.New(0, 100, 0), (arg_69_1.time_ - 0) / var_72_9)
				var_72_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_72_8.position).x, (manager.ui.mainCamera.transform.position - var_72_8.position).y, (manager.ui.mainCamera.transform.position - var_72_8.position).z)
				var_72_8.localEulerAngles.z = 0
				var_72_8.localEulerAngles.x = 0
				var_72_8.localEulerAngles = var_72_8.localEulerAngles
			end

			if arg_69_1.time_ >= 0 + var_72_9 and arg_69_1.time_ < 0 + var_72_9 + arg_72_0 then
				var_72_8.localPosition = Vector3.New(0, 100, 0)
				var_72_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_72_8.position).x, (manager.ui.mainCamera.transform.position - var_72_8.position).y, (manager.ui.mainCamera.transform.position - var_72_8.position).z)
				var_72_8.localEulerAngles.z = 0
				var_72_8.localEulerAngles.x = 0
				var_72_8.localEulerAngles = var_72_8.localEulerAngles
			end

			local var_72_10 = arg_69_1.actors_["10083ui_story"]

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(var_72_10) and arg_69_1.var_.characterEffect10083ui_story == nil then
				arg_69_1.var_.characterEffect10083ui_story = var_72_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_11 = 0.200000002980232

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_11 and not isNil(var_72_10) then
				if arg_69_1.var_.characterEffect10083ui_story and not isNil(var_72_10) then
					arg_69_1.var_.characterEffect10083ui_story.fillFlat = true
					arg_69_1.var_.characterEffect10083ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_69_1.time_ - 0) / var_72_11)
				end
			end

			if arg_69_1.time_ >= 0 + var_72_11 and arg_69_1.time_ < 0 + var_72_11 + arg_72_0 and not isNil(var_72_10) and arg_69_1.var_.characterEffect10083ui_story then
				arg_69_1.var_.characterEffect10083ui_story.fillFlat = true
				arg_69_1.var_.characterEffect10083ui_story.fillRatio = 0.5
			end

			local var_72_12 = 0
			local var_72_13 = 0.675

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_12 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[917].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_14 = arg_69_1:GetWordFromCfg(412031017)
				local var_72_15 = arg_69_1:FormatText(var_72_14.content)

				arg_69_1.text_.text = var_72_15

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_17 = 27 <= 0 and var_72_13 or var_72_13 * (utf8.len(var_72_15) / 27)

				if (27 <= 0 and var_72_13 or var_72_13 * (utf8.len(var_72_15) / 27)) > 0 and var_72_13 < var_72_17 then
					arg_69_1.talkMaxDuration = var_72_17

					if var_72_17 + var_72_12 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_17 + var_72_12
					end
				end

				arg_69_1.text_.text = var_72_15
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031017", "story_v_out_412031.awb") ~= 0 then
					local var_72_18 = manager.audio:GetVoiceLength("story_v_out_412031", "412031017", "story_v_out_412031.awb") / 1000

					if var_72_18 + var_72_12 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_18 + var_72_12
					end

					if var_72_14.prefab_name ~= "" and arg_69_1.actors_[var_72_14.prefab_name] ~= nil then
						local var_72_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_14.prefab_name].transform, "story_v_out_412031", "412031017", "story_v_out_412031.awb")

						arg_69_1:RecordAudio("412031017", var_72_19)
						arg_69_1:RecordAudio("412031017", var_72_19)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_412031", "412031017", "story_v_out_412031.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_412031", "412031017", "story_v_out_412031.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_20 = math.max(var_72_13, arg_69_1.talkMaxDuration)

			if var_72_12 <= arg_69_1.time_ and arg_69_1.time_ < var_72_12 + var_72_20 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_12) / var_72_20

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_12 + var_72_20 and arg_69_1.time_ < var_72_12 + var_72_20 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10083ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_69_1:InitPlayNodeList()
	end,
	Play412031018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 412031018
		arg_73_1.duration_ = 2

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play412031019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if arg_73_1.actors_["10078ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10078ui_story"))) then
				local var_76_0 = Object.Instantiate(Asset.Load("Char/" .. "10078ui_story"), arg_73_1.stage_.transform)

				var_76_0.name = "10078ui_story"
				var_76_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_73_1.actors_["10078ui_story"] = var_76_0

				local var_76_1 = var_76_0:GetComponentInChildren(typeof(CharacterEffect))

				var_76_1.enabled = true

				local var_76_2 = GameObjectTools.GetOrAddComponent(var_76_0, typeof(DynamicBoneHelper))

				if var_76_2 then
					var_76_2:EnableDynamicBone(false)
				end

				arg_73_1:ShowWeapon(var_76_1.transform, false)

				arg_73_1.var_["10078ui_story" .. "Animator"] = var_76_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_73_1.var_["10078ui_story" .. "Animator"].applyRootMotion = true
				arg_73_1.var_["10078ui_story" .. "LipSync"] = var_76_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_76_3 = arg_73_1.actors_["10078ui_story"].transform

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1.var_.moveOldPos10078ui_story = var_76_3.localPosition
			end

			local var_76_4 = 0.001

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_4 then
				var_76_3.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos10078ui_story, Vector3.New(0, -0.5, -6.3), (arg_73_1.time_ - 0) / var_76_4)
				var_76_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_76_3.position).x, (manager.ui.mainCamera.transform.position - var_76_3.position).y, (manager.ui.mainCamera.transform.position - var_76_3.position).z)
				var_76_3.localEulerAngles.z = 0
				var_76_3.localEulerAngles.x = 0
				var_76_3.localEulerAngles = var_76_3.localEulerAngles
			end

			if arg_73_1.time_ >= 0 + var_76_4 and arg_73_1.time_ < 0 + var_76_4 + arg_76_0 then
				var_76_3.localPosition = Vector3.New(0, -0.5, -6.3)
				var_76_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_76_3.position).x, (manager.ui.mainCamera.transform.position - var_76_3.position).y, (manager.ui.mainCamera.transform.position - var_76_3.position).z)
				var_76_3.localEulerAngles.z = 0
				var_76_3.localEulerAngles.x = 0
				var_76_3.localEulerAngles = var_76_3.localEulerAngles
			end

			local var_76_5 = arg_73_1.actors_["10078ui_story"]

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(var_76_5) and arg_73_1.var_.characterEffect10078ui_story == nil then
				arg_73_1.var_.characterEffect10078ui_story = var_76_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_6 = 0.200000002980232

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_6 and not isNil(var_76_5) then
				if arg_73_1.var_.characterEffect10078ui_story and not isNil(var_76_5) then
					arg_73_1.var_.characterEffect10078ui_story.fillFlat = false
				end
			end

			if arg_73_1.time_ >= 0 + var_76_6 and arg_73_1.time_ < 0 + var_76_6 + arg_76_0 and not isNil(var_76_5) and arg_73_1.var_.characterEffect10078ui_story then
				arg_73_1.var_.characterEffect10078ui_story.fillFlat = false
			end

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1:PlayTimeline("10078ui_story", "StoryTimeline/CharAction/story6046/story6046action/6046action1_1")
			end

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1:PlayTimeline("10078ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_76_8 = arg_73_1.actors_["10076ui_story"].transform

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1.var_.moveOldPos10076ui_story = var_76_8.localPosition
			end

			local var_76_9 = 0.001

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_9 then
				var_76_8.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos10076ui_story, Vector3.New(0, 100, 0), (arg_73_1.time_ - 0) / var_76_9)
				var_76_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_76_8.position).x, (manager.ui.mainCamera.transform.position - var_76_8.position).y, (manager.ui.mainCamera.transform.position - var_76_8.position).z)
				var_76_8.localEulerAngles.z = 0
				var_76_8.localEulerAngles.x = 0
				var_76_8.localEulerAngles = var_76_8.localEulerAngles
			end

			if arg_73_1.time_ >= 0 + var_76_9 and arg_73_1.time_ < 0 + var_76_9 + arg_76_0 then
				var_76_8.localPosition = Vector3.New(0, 100, 0)
				var_76_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_76_8.position).x, (manager.ui.mainCamera.transform.position - var_76_8.position).y, (manager.ui.mainCamera.transform.position - var_76_8.position).z)
				var_76_8.localEulerAngles.z = 0
				var_76_8.localEulerAngles.x = 0
				var_76_8.localEulerAngles = var_76_8.localEulerAngles
			end

			local var_76_10 = arg_73_1.actors_["10076ui_story"]

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(var_76_10) and arg_73_1.var_.characterEffect10076ui_story == nil then
				arg_73_1.var_.characterEffect10076ui_story = var_76_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_11 = 0.200000002980232

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_11 and not isNil(var_76_10) then
				if arg_73_1.var_.characterEffect10076ui_story and not isNil(var_76_10) then
					arg_73_1.var_.characterEffect10076ui_story.fillFlat = true
					arg_73_1.var_.characterEffect10076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_73_1.time_ - 0) / var_76_11)
				end
			end

			if arg_73_1.time_ >= 0 + var_76_11 and arg_73_1.time_ < 0 + var_76_11 + arg_76_0 and not isNil(var_76_10) and arg_73_1.var_.characterEffect10076ui_story then
				arg_73_1.var_.characterEffect10076ui_story.fillFlat = true
				arg_73_1.var_.characterEffect10076ui_story.fillRatio = 0.5
			end

			local var_76_12 = 0
			local var_76_13 = 0.05

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_12 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[919].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_14 = arg_73_1:GetWordFromCfg(412031018)
				local var_76_15 = arg_73_1:FormatText(var_76_14.content)

				arg_73_1.text_.text = var_76_15

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_17 = 2 <= 0 and var_76_13 or var_76_13 * (utf8.len(var_76_15) / 2)

				if (2 <= 0 and var_76_13 or var_76_13 * (utf8.len(var_76_15) / 2)) > 0 and var_76_13 < var_76_17 then
					arg_73_1.talkMaxDuration = var_76_17

					if var_76_17 + var_76_12 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_17 + var_76_12
					end
				end

				arg_73_1.text_.text = var_76_15
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031018", "story_v_out_412031.awb") ~= 0 then
					local var_76_18 = manager.audio:GetVoiceLength("story_v_out_412031", "412031018", "story_v_out_412031.awb") / 1000

					if var_76_18 + var_76_12 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_18 + var_76_12
					end

					if var_76_14.prefab_name ~= "" and arg_73_1.actors_[var_76_14.prefab_name] ~= nil then
						local var_76_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_14.prefab_name].transform, "story_v_out_412031", "412031018", "story_v_out_412031.awb")

						arg_73_1:RecordAudio("412031018", var_76_19)
						arg_73_1:RecordAudio("412031018", var_76_19)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_412031", "412031018", "story_v_out_412031.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_412031", "412031018", "story_v_out_412031.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_20 = math.max(var_76_13, arg_73_1.talkMaxDuration)

			if var_76_12 <= arg_73_1.time_ and arg_73_1.time_ < var_76_12 + var_76_20 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_12) / var_76_20

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_12 + var_76_20 and arg_73_1.time_ < var_76_12 + var_76_20 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_73_1:InitPlayNodeList()
	end,
	Play412031019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 412031019
		arg_77_1.duration_ = 5.07

		local var_77_0 = {
			zh = 4.966,
			ja = 5.066
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
				arg_77_0:Play412031020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.var_.moveOldPos1097ui_story = arg_77_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_80_0 = 0.001

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_0 then
				arg_77_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos1097ui_story, Vector3.New(-0.7, -0.54, -6.3), (arg_77_1.time_ - 0) / var_80_0)
				arg_77_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_77_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["1097ui_story"].transform.position).z)
				arg_77_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_77_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_77_1.actors_["1097ui_story"].transform.localEulerAngles = arg_77_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_77_1.time_ >= 0 + var_80_0 and arg_77_1.time_ < 0 + var_80_0 + arg_80_0 then
				arg_77_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(-0.7, -0.54, -6.3)
				arg_77_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_77_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["1097ui_story"].transform.position).z)
				arg_77_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_77_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_77_1.actors_["1097ui_story"].transform.localEulerAngles = arg_77_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_80_1 = arg_77_1.actors_["1097ui_story"]

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(var_80_1) and arg_77_1.var_.characterEffect1097ui_story == nil then
				arg_77_1.var_.characterEffect1097ui_story = var_80_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_2 = 0.200000002980232

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_2 and not isNil(var_80_1) then
				if arg_77_1.var_.characterEffect1097ui_story and not isNil(var_80_1) then
					arg_77_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_77_1.time_ >= 0 + var_80_2 and arg_77_1.time_ < 0 + var_80_2 + arg_80_0 and not isNil(var_80_1) and arg_77_1.var_.characterEffect1097ui_story then
				arg_77_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_80_4 = arg_77_1.actors_["10078ui_story"].transform

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.var_.moveOldPos10078ui_story = var_80_4.localPosition
			end

			local var_80_5 = 0.001

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_5 then
				var_80_4.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos10078ui_story, Vector3.New(0, 100, 0), (arg_77_1.time_ - 0) / var_80_5)
				var_80_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_80_4.position).x, (manager.ui.mainCamera.transform.position - var_80_4.position).y, (manager.ui.mainCamera.transform.position - var_80_4.position).z)
				var_80_4.localEulerAngles.z = 0
				var_80_4.localEulerAngles.x = 0
				var_80_4.localEulerAngles = var_80_4.localEulerAngles
			end

			if arg_77_1.time_ >= 0 + var_80_5 and arg_77_1.time_ < 0 + var_80_5 + arg_80_0 then
				var_80_4.localPosition = Vector3.New(0, 100, 0)
				var_80_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_80_4.position).x, (manager.ui.mainCamera.transform.position - var_80_4.position).y, (manager.ui.mainCamera.transform.position - var_80_4.position).z)
				var_80_4.localEulerAngles.z = 0
				var_80_4.localEulerAngles.x = 0
				var_80_4.localEulerAngles = var_80_4.localEulerAngles
			end

			local var_80_6 = arg_77_1.actors_["10078ui_story"]

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(var_80_6) and arg_77_1.var_.characterEffect10078ui_story == nil then
				arg_77_1.var_.characterEffect10078ui_story = var_80_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_7 = 0.200000002980232

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_7 and not isNil(var_80_6) then
				if arg_77_1.var_.characterEffect10078ui_story and not isNil(var_80_6) then
					arg_77_1.var_.characterEffect10078ui_story.fillFlat = true
					arg_77_1.var_.characterEffect10078ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_77_1.time_ - 0) / var_80_7)
				end
			end

			if arg_77_1.time_ >= 0 + var_80_7 and arg_77_1.time_ < 0 + var_80_7 + arg_80_0 and not isNil(var_80_6) and arg_77_1.var_.characterEffect10078ui_story then
				arg_77_1.var_.characterEffect10078ui_story.fillFlat = true
				arg_77_1.var_.characterEffect10078ui_story.fillRatio = 0.5
			end

			local var_80_8 = 0
			local var_80_9 = 0.45

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_8 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_10 = arg_77_1:GetWordFromCfg(412031019)
				local var_80_11 = arg_77_1:FormatText(var_80_10.content)

				arg_77_1.text_.text = var_80_11

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_13 = 18 <= 0 and var_80_9 or var_80_9 * (utf8.len(var_80_11) / 18)

				if (18 <= 0 and var_80_9 or var_80_9 * (utf8.len(var_80_11) / 18)) > 0 and var_80_9 < var_80_13 then
					arg_77_1.talkMaxDuration = var_80_13

					if var_80_13 + var_80_8 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_13 + var_80_8
					end
				end

				arg_77_1.text_.text = var_80_11
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031019", "story_v_out_412031.awb") ~= 0 then
					local var_80_14 = manager.audio:GetVoiceLength("story_v_out_412031", "412031019", "story_v_out_412031.awb") / 1000

					if var_80_14 + var_80_8 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_14 + var_80_8
					end

					if var_80_10.prefab_name ~= "" and arg_77_1.actors_[var_80_10.prefab_name] ~= nil then
						local var_80_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_10.prefab_name].transform, "story_v_out_412031", "412031019", "story_v_out_412031.awb")

						arg_77_1:RecordAudio("412031019", var_80_15)
						arg_77_1:RecordAudio("412031019", var_80_15)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_412031", "412031019", "story_v_out_412031.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_412031", "412031019", "story_v_out_412031.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_16 = math.max(var_80_9, arg_77_1.talkMaxDuration)

			if var_80_8 <= arg_77_1.time_ and arg_77_1.time_ < var_80_8 + var_80_16 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_8) / var_80_16

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_8 + var_80_16 and arg_77_1.time_ < var_80_8 + var_80_16 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_77_1:InitPlayNodeList()
	end,
	Play412031020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 412031020
		arg_81_1.duration_ = 7.37

		local var_81_0 = {
			zh = 5.066,
			ja = 7.366
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
				arg_81_0:Play412031021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.var_.moveOldPos3043ui_story = arg_81_1.actors_["3043ui_story"].transform.localPosition
			end

			local var_84_0 = 0.001

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_0 then
				arg_81_1.actors_["3043ui_story"].transform.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos3043ui_story, Vector3.New(0.7, -1.41, -5.7), (arg_81_1.time_ - 0) / var_84_0)
				arg_81_1.actors_["3043ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_81_1.actors_["3043ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["3043ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["3043ui_story"].transform.position).z)
				arg_81_1.actors_["3043ui_story"].transform.localEulerAngles.z = 0
				arg_81_1.actors_["3043ui_story"].transform.localEulerAngles.x = 0
				arg_81_1.actors_["3043ui_story"].transform.localEulerAngles = arg_81_1.actors_["3043ui_story"].transform.localEulerAngles
			end

			if arg_81_1.time_ >= 0 + var_84_0 and arg_81_1.time_ < 0 + var_84_0 + arg_84_0 then
				arg_81_1.actors_["3043ui_story"].transform.localPosition = Vector3.New(0.7, -1.41, -5.7)
				arg_81_1.actors_["3043ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_81_1.actors_["3043ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["3043ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["3043ui_story"].transform.position).z)
				arg_81_1.actors_["3043ui_story"].transform.localEulerAngles.z = 0
				arg_81_1.actors_["3043ui_story"].transform.localEulerAngles.x = 0
				arg_81_1.actors_["3043ui_story"].transform.localEulerAngles = arg_81_1.actors_["3043ui_story"].transform.localEulerAngles
			end

			local var_84_1 = arg_81_1.actors_["3043ui_story"]

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(var_84_1) and arg_81_1.var_.characterEffect3043ui_story == nil then
				arg_81_1.var_.characterEffect3043ui_story = var_84_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_2 = 0.200000002980232

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_2 and not isNil(var_84_1) then
				if arg_81_1.var_.characterEffect3043ui_story and not isNil(var_84_1) then
					arg_81_1.var_.characterEffect3043ui_story.fillFlat = false
				end
			end

			if arg_81_1.time_ >= 0 + var_84_2 and arg_81_1.time_ < 0 + var_84_2 + arg_84_0 and not isNil(var_84_1) and arg_81_1.var_.characterEffect3043ui_story then
				arg_81_1.var_.characterEffect3043ui_story.fillFlat = false
			end

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1:PlayTimeline("3043ui_story", "StoryTimeline/CharAction/story3043/story3043action/3043action2_1")
			end

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1:PlayTimeline("3043ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_84_4 = arg_81_1.actors_["1097ui_story"]

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(var_84_4) and arg_81_1.var_.characterEffect1097ui_story == nil then
				arg_81_1.var_.characterEffect1097ui_story = var_84_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_5 = 0.200000002980232

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_5 and not isNil(var_84_4) then
				if arg_81_1.var_.characterEffect1097ui_story and not isNil(var_84_4) then
					arg_81_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_81_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_81_1.time_ - 0) / var_84_5)
				end
			end

			if arg_81_1.time_ >= 0 + var_84_5 and arg_81_1.time_ < 0 + var_84_5 + arg_84_0 and not isNil(var_84_4) and arg_81_1.var_.characterEffect1097ui_story then
				arg_81_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_81_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_84_6 = 0
			local var_84_7 = 0.525

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_6 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[920].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_8 = arg_81_1:GetWordFromCfg(412031020)
				local var_84_9 = arg_81_1:FormatText(var_84_8.content)

				arg_81_1.text_.text = var_84_9

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_11 = 21 <= 0 and var_84_7 or var_84_7 * (utf8.len(var_84_9) / 21)

				if (21 <= 0 and var_84_7 or var_84_7 * (utf8.len(var_84_9) / 21)) > 0 and var_84_7 < var_84_11 then
					arg_81_1.talkMaxDuration = var_84_11

					if var_84_11 + var_84_6 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_11 + var_84_6
					end
				end

				arg_81_1.text_.text = var_84_9
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031020", "story_v_out_412031.awb") ~= 0 then
					local var_84_12 = manager.audio:GetVoiceLength("story_v_out_412031", "412031020", "story_v_out_412031.awb") / 1000

					if var_84_12 + var_84_6 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_12 + var_84_6
					end

					if var_84_8.prefab_name ~= "" and arg_81_1.actors_[var_84_8.prefab_name] ~= nil then
						local var_84_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_8.prefab_name].transform, "story_v_out_412031", "412031020", "story_v_out_412031.awb")

						arg_81_1:RecordAudio("412031020", var_84_13)
						arg_81_1:RecordAudio("412031020", var_84_13)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_412031", "412031020", "story_v_out_412031.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_412031", "412031020", "story_v_out_412031.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_14 = math.max(var_84_7, arg_81_1.talkMaxDuration)

			if var_84_6 <= arg_81_1.time_ and arg_81_1.time_ < var_84_6 + var_84_14 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_6) / var_84_14

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_6 + var_84_14 and arg_81_1.time_ < var_84_6 + var_84_14 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_81_1:InitPlayNodeList()
	end,
	Play412031021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 412031021
		arg_85_1.duration_ = 12.7

		local var_85_0 = {
			zh = 10.8,
			ja = 12.7
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
				arg_85_0:Play412031022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			if arg_85_1.bgs_.ST30 == nil then
				local var_88_0 = Object.Instantiate(arg_85_1.paintGo_)

				var_88_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST30")
				var_88_0.name = "ST30"
				var_88_0.transform.parent = arg_85_1.stage_.transform
				var_88_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_85_1.bgs_.ST30 = var_88_0
			end

			if 2 < arg_85_1.time_ and arg_85_1.time_ <= 2 + arg_88_0 then
				local var_88_1 = arg_85_1.bgs_.ST30

				arg_85_1.bgs_.ST30.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_88_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_88_2 = var_88_1:GetComponent("SpriteRenderer")

				if var_88_2 and var_88_2.sprite then
					local var_88_3 = 2 * (var_88_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_88_1.transform.localScale = Vector3.New(var_88_3 / var_88_2.sprite.bounds.size.y < var_88_3 * manager.ui.mainCameraCom_.aspect / var_88_2.sprite.bounds.size.x and var_88_3 * manager.ui.mainCameraCom_.aspect / var_88_2.sprite.bounds.size.x or var_88_3 / var_88_2.sprite.bounds.size.y, var_88_3 / var_88_2.sprite.bounds.size.y < var_88_3 * manager.ui.mainCameraCom_.aspect / var_88_2.sprite.bounds.size.x and var_88_3 * manager.ui.mainCameraCom_.aspect / var_88_2.sprite.bounds.size.x or var_88_3 / var_88_2.sprite.bounds.size.y, 0)
				end

				for iter_88_0, iter_88_1 in pairs(arg_85_1.bgs_) do
					if iter_88_0 ~= "ST30" then
						iter_88_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_88_4 = 4

			if 4 < arg_85_1.time_ and arg_85_1.time_ <= var_88_4 + arg_88_0 then
				arg_85_1.allBtn_.enabled = false
			end

			if arg_85_1.time_ >= var_88_4 + 0.3 and arg_85_1.time_ < var_88_4 + 0.3 + arg_88_0 then
				arg_85_1.allBtn_.enabled = true
			end

			local var_88_5 = 0

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_5 + arg_88_0 then
				arg_85_1.mask_.enabled = true
				arg_85_1.mask_.raycastTarget = true

				arg_85_1:SetGaussion(false)
			end

			local var_88_6 = 2

			if var_88_5 <= arg_85_1.time_ and arg_85_1.time_ < var_88_5 + var_88_6 then
				local var_88_7 = Color.New(0, 0, 0)

				var_88_7.a = Mathf.Lerp(0, 1, (arg_85_1.time_ - var_88_5) / var_88_6)
				arg_85_1.mask_.color = var_88_7
			end

			if arg_85_1.time_ >= var_88_5 + var_88_6 and arg_85_1.time_ < var_88_5 + var_88_6 + arg_88_0 then
				local var_88_8 = Color.New(0, 0, 0)

				var_88_8.a = 1
				arg_85_1.mask_.color = var_88_8
			end

			local var_88_9 = 2

			if 2 < arg_85_1.time_ and arg_85_1.time_ <= var_88_9 + arg_88_0 then
				arg_85_1.mask_.enabled = true
				arg_85_1.mask_.raycastTarget = true

				arg_85_1:SetGaussion(false)
			end

			local var_88_10 = 2

			if var_88_9 <= arg_85_1.time_ and arg_85_1.time_ < var_88_9 + var_88_10 then
				local var_88_11 = Color.New(0, 0, 0)

				var_88_11.a = Mathf.Lerp(1, 0, (arg_85_1.time_ - var_88_9) / var_88_10)
				arg_85_1.mask_.color = var_88_11
			end

			if arg_85_1.time_ >= var_88_9 + var_88_10 and arg_85_1.time_ < var_88_9 + var_88_10 + arg_88_0 then
				local var_88_12 = Color.New(0, 0, 0)

				arg_85_1.mask_.enabled = false
				var_88_12.a = 0
				arg_85_1.mask_.color = var_88_12
			end

			local var_88_13 = arg_85_1.actors_["3043ui_story"].transform

			if 3.8 < arg_85_1.time_ and arg_85_1.time_ <= 3.8 + arg_88_0 then
				arg_85_1.var_.moveOldPos3043ui_story = var_88_13.localPosition
			end

			local var_88_14 = 0.001

			if 3.8 <= arg_85_1.time_ and arg_85_1.time_ < 3.8 + var_88_14 then
				var_88_13.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos3043ui_story, Vector3.New(0, -1.41, -5.7), (arg_85_1.time_ - 3.8) / var_88_14)
				var_88_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_88_13.position).x, (manager.ui.mainCamera.transform.position - var_88_13.position).y, (manager.ui.mainCamera.transform.position - var_88_13.position).z)
				var_88_13.localEulerAngles.z = 0
				var_88_13.localEulerAngles.x = 0
				var_88_13.localEulerAngles = var_88_13.localEulerAngles
			end

			if arg_85_1.time_ >= 3.8 + var_88_14 and arg_85_1.time_ < 3.8 + var_88_14 + arg_88_0 then
				var_88_13.localPosition = Vector3.New(0, -1.41, -5.7)
				var_88_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_88_13.position).x, (manager.ui.mainCamera.transform.position - var_88_13.position).y, (manager.ui.mainCamera.transform.position - var_88_13.position).z)
				var_88_13.localEulerAngles.z = 0
				var_88_13.localEulerAngles.x = 0
				var_88_13.localEulerAngles = var_88_13.localEulerAngles
			end

			local var_88_15 = arg_85_1.actors_["3043ui_story"]

			if 3.8 < arg_85_1.time_ and arg_85_1.time_ <= 3.8 + arg_88_0 and not isNil(var_88_15) and arg_85_1.var_.characterEffect3043ui_story == nil then
				arg_85_1.var_.characterEffect3043ui_story = var_88_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_16 = 0.200000002980232

			if 3.8 <= arg_85_1.time_ and arg_85_1.time_ < 3.8 + var_88_16 and not isNil(var_88_15) then
				if arg_85_1.var_.characterEffect3043ui_story and not isNil(var_88_15) then
					arg_85_1.var_.characterEffect3043ui_story.fillFlat = false
				end
			end

			if arg_85_1.time_ >= 3.8 + var_88_16 and arg_85_1.time_ < 3.8 + var_88_16 + arg_88_0 and not isNil(var_88_15) and arg_85_1.var_.characterEffect3043ui_story then
				arg_85_1.var_.characterEffect3043ui_story.fillFlat = false
			end

			if 3.8 < arg_85_1.time_ and arg_85_1.time_ <= 3.8 + arg_88_0 then
				arg_85_1:PlayTimeline("3043ui_story", "StoryTimeline/CharAction/story3043/story3043action/3043action1_1")
			end

			if 3.8 < arg_85_1.time_ and arg_85_1.time_ <= 3.8 + arg_88_0 then
				arg_85_1:PlayTimeline("3043ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_88_18 = arg_85_1.actors_["3043ui_story"].transform

			if 1.96599999815226 < arg_85_1.time_ and arg_85_1.time_ <= 1.96599999815226 + arg_88_0 then
				arg_85_1.var_.moveOldPos3043ui_story = var_88_18.localPosition
			end

			local var_88_19 = 0.001

			if 1.96599999815226 <= arg_85_1.time_ and arg_85_1.time_ < 1.96599999815226 + var_88_19 then
				var_88_18.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos3043ui_story, Vector3.New(0, 100, 0), (arg_85_1.time_ - 1.96599999815226) / var_88_19)
				var_88_18.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_88_18.position).x, (manager.ui.mainCamera.transform.position - var_88_18.position).y, (manager.ui.mainCamera.transform.position - var_88_18.position).z)
				var_88_18.localEulerAngles.z = 0
				var_88_18.localEulerAngles.x = 0
				var_88_18.localEulerAngles = var_88_18.localEulerAngles
			end

			if arg_85_1.time_ >= 1.96599999815226 + var_88_19 and arg_85_1.time_ < 1.96599999815226 + var_88_19 + arg_88_0 then
				var_88_18.localPosition = Vector3.New(0, 100, 0)
				var_88_18.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_88_18.position).x, (manager.ui.mainCamera.transform.position - var_88_18.position).y, (manager.ui.mainCamera.transform.position - var_88_18.position).z)
				var_88_18.localEulerAngles.z = 0
				var_88_18.localEulerAngles.x = 0
				var_88_18.localEulerAngles = var_88_18.localEulerAngles
			end

			local var_88_20 = arg_85_1.actors_["1097ui_story"].transform

			if 1.96599999815226 < arg_85_1.time_ and arg_85_1.time_ <= 1.96599999815226 + arg_88_0 then
				arg_85_1.var_.moveOldPos1097ui_story = var_88_20.localPosition
			end

			local var_88_21 = 0.001

			if 1.96599999815226 <= arg_85_1.time_ and arg_85_1.time_ < 1.96599999815226 + var_88_21 then
				var_88_20.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos1097ui_story, Vector3.New(0, 100, 0), (arg_85_1.time_ - 1.96599999815226) / var_88_21)
				var_88_20.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_88_20.position).x, (manager.ui.mainCamera.transform.position - var_88_20.position).y, (manager.ui.mainCamera.transform.position - var_88_20.position).z)
				var_88_20.localEulerAngles.z = 0
				var_88_20.localEulerAngles.x = 0
				var_88_20.localEulerAngles = var_88_20.localEulerAngles
			end

			if arg_85_1.time_ >= 1.96599999815226 + var_88_21 and arg_85_1.time_ < 1.96599999815226 + var_88_21 + arg_88_0 then
				var_88_20.localPosition = Vector3.New(0, 100, 0)
				var_88_20.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_88_20.position).x, (manager.ui.mainCamera.transform.position - var_88_20.position).y, (manager.ui.mainCamera.transform.position - var_88_20.position).z)
				var_88_20.localEulerAngles.z = 0
				var_88_20.localEulerAngles.x = 0
				var_88_20.localEulerAngles = var_88_20.localEulerAngles
			end

			if arg_85_1.frameCnt_ <= 1 then
				arg_85_1.dialog_:SetActive(false)
			end

			local var_88_22 = 4
			local var_88_23 = 0.675

			if 4 < arg_85_1.time_ and arg_85_1.time_ <= var_88_22 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0

				arg_85_1.dialog_:SetActive(true)

				arg_85_1.dialogCg_.alpha = 0

				local var_88_24 = LeanTween.value(arg_85_1.dialog_, 0, 1, 0.3)

				var_88_24:setOnUpdate(LuaHelper.FloatAction(function(arg_89_0)
					arg_85_1.dialogCg_.alpha = arg_89_0
				end))
				var_88_24:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_85_1.dialog_)
					var_88_24:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_85_1.duration_ = arg_85_1.duration_ + 0.3

				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[920].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_25 = arg_85_1:GetWordFromCfg(412031021)
				local var_88_26 = arg_85_1:FormatText(var_88_25.content)

				arg_85_1.text_.text = var_88_26

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_28 = 27 <= 0 and var_88_23 or var_88_23 * (utf8.len(var_88_26) / 27)

				if (27 <= 0 and var_88_23 or var_88_23 * (utf8.len(var_88_26) / 27)) > 0 and var_88_23 < var_88_28 then
					arg_85_1.talkMaxDuration = var_88_28
					var_88_22 = var_88_22 + 0.3

					if var_88_28 + var_88_22 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_28 + var_88_22
					end
				end

				arg_85_1.text_.text = var_88_26
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031021", "story_v_out_412031.awb") ~= 0 then
					local var_88_29 = manager.audio:GetVoiceLength("story_v_out_412031", "412031021", "story_v_out_412031.awb") / 1000

					if var_88_29 + var_88_22 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_29 + var_88_22
					end

					if var_88_25.prefab_name ~= "" and arg_85_1.actors_[var_88_25.prefab_name] ~= nil then
						local var_88_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_25.prefab_name].transform, "story_v_out_412031", "412031021", "story_v_out_412031.awb")

						arg_85_1:RecordAudio("412031021", var_88_30)
						arg_85_1:RecordAudio("412031021", var_88_30)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_412031", "412031021", "story_v_out_412031.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_412031", "412031021", "story_v_out_412031.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_31 = var_88_22 + 0.3
			local var_88_32 = math.max(var_88_23, arg_85_1.talkMaxDuration)

			if var_88_22 + 0.3 <= arg_85_1.time_ and arg_85_1.time_ < var_88_31 + var_88_32 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_31) / var_88_32

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_31 + var_88_32 and arg_85_1.time_ < var_88_31 + var_88_32 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "3043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_85_1:InitPlayNodeList()
	end,
	Play412031022 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 412031022
		arg_91_1.duration_ = 6.6

		local var_91_0 = {
			zh = 3.466,
			ja = 6.6
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
				arg_91_0:Play412031023(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1.var_.moveOldPos1097ui_story = arg_91_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_94_0 = 0.001

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_0 then
				arg_91_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_91_1.var_.moveOldPos1097ui_story, Vector3.New(-0.7, -0.54, -6.3), (arg_91_1.time_ - 0) / var_94_0)
				arg_91_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_91_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_91_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_91_1.actors_["1097ui_story"].transform.position).z)
				arg_91_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_91_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_91_1.actors_["1097ui_story"].transform.localEulerAngles = arg_91_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_91_1.time_ >= 0 + var_94_0 and arg_91_1.time_ < 0 + var_94_0 + arg_94_0 then
				arg_91_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(-0.7, -0.54, -6.3)
				arg_91_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_91_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_91_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_91_1.actors_["1097ui_story"].transform.position).z)
				arg_91_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_91_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_91_1.actors_["1097ui_story"].transform.localEulerAngles = arg_91_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_94_1 = arg_91_1.actors_["1097ui_story"]

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 and not isNil(var_94_1) and arg_91_1.var_.characterEffect1097ui_story == nil then
				arg_91_1.var_.characterEffect1097ui_story = var_94_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_94_2 = 0.200000002980232

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_2 and not isNil(var_94_1) then
				if arg_91_1.var_.characterEffect1097ui_story and not isNil(var_94_1) then
					arg_91_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_91_1.time_ >= 0 + var_94_2 and arg_91_1.time_ < 0 + var_94_2 + arg_94_0 and not isNil(var_94_1) and arg_91_1.var_.characterEffect1097ui_story then
				arg_91_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_94_4 = arg_91_1.actors_["3043ui_story"]

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 and not isNil(var_94_4) and arg_91_1.var_.characterEffect3043ui_story == nil then
				arg_91_1.var_.characterEffect3043ui_story = var_94_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_94_5 = 0.200000002980232

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_5 and not isNil(var_94_4) then
				if arg_91_1.var_.characterEffect3043ui_story and not isNil(var_94_4) then
					arg_91_1.var_.characterEffect3043ui_story.fillFlat = true
					arg_91_1.var_.characterEffect3043ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_91_1.time_ - 0) / var_94_5)
				end
			end

			if arg_91_1.time_ >= 0 + var_94_5 and arg_91_1.time_ < 0 + var_94_5 + arg_94_0 and not isNil(var_94_4) and arg_91_1.var_.characterEffect3043ui_story then
				arg_91_1.var_.characterEffect3043ui_story.fillFlat = true
				arg_91_1.var_.characterEffect3043ui_story.fillRatio = 0.5
			end

			local var_94_6 = arg_91_1.actors_["3043ui_story"].transform

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1.var_.moveOldPos3043ui_story = var_94_6.localPosition
			end

			local var_94_7 = 0.001

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_7 then
				var_94_6.localPosition = Vector3.Lerp(arg_91_1.var_.moveOldPos3043ui_story, Vector3.New(0.7, -1.41, -5.7), (arg_91_1.time_ - 0) / var_94_7)
				var_94_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_94_6.position).x, (manager.ui.mainCamera.transform.position - var_94_6.position).y, (manager.ui.mainCamera.transform.position - var_94_6.position).z)
				var_94_6.localEulerAngles.z = 0
				var_94_6.localEulerAngles.x = 0
				var_94_6.localEulerAngles = var_94_6.localEulerAngles
			end

			if arg_91_1.time_ >= 0 + var_94_7 and arg_91_1.time_ < 0 + var_94_7 + arg_94_0 then
				var_94_6.localPosition = Vector3.New(0.7, -1.41, -5.7)
				var_94_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_94_6.position).x, (manager.ui.mainCamera.transform.position - var_94_6.position).y, (manager.ui.mainCamera.transform.position - var_94_6.position).z)
				var_94_6.localEulerAngles.z = 0
				var_94_6.localEulerAngles.x = 0
				var_94_6.localEulerAngles = var_94_6.localEulerAngles
			end

			local var_94_8 = 0
			local var_94_9 = 0.275

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= var_94_8 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				arg_91_1.leftNameTxt_.text = arg_91_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_10 = arg_91_1:GetWordFromCfg(412031022)
				local var_94_11 = arg_91_1:FormatText(var_94_10.content)

				arg_91_1.text_.text = var_94_11

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_13 = 11 <= 0 and var_94_9 or var_94_9 * (utf8.len(var_94_11) / 11)

				if (11 <= 0 and var_94_9 or var_94_9 * (utf8.len(var_94_11) / 11)) > 0 and var_94_9 < var_94_13 then
					arg_91_1.talkMaxDuration = var_94_13

					if var_94_13 + var_94_8 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_13 + var_94_8
					end
				end

				arg_91_1.text_.text = var_94_11
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031022", "story_v_out_412031.awb") ~= 0 then
					local var_94_14 = manager.audio:GetVoiceLength("story_v_out_412031", "412031022", "story_v_out_412031.awb") / 1000

					if var_94_14 + var_94_8 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_14 + var_94_8
					end

					if var_94_10.prefab_name ~= "" and arg_91_1.actors_[var_94_10.prefab_name] ~= nil then
						local var_94_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_91_1.actors_[var_94_10.prefab_name].transform, "story_v_out_412031", "412031022", "story_v_out_412031.awb")

						arg_91_1:RecordAudio("412031022", var_94_15)
						arg_91_1:RecordAudio("412031022", var_94_15)
					else
						arg_91_1:AudioAction("play", "voice", "story_v_out_412031", "412031022", "story_v_out_412031.awb")
					end

					arg_91_1:RecordHistoryTalkVoice("story_v_out_412031", "412031022", "story_v_out_412031.awb")
				end

				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_16 = math.max(var_94_9, arg_91_1.talkMaxDuration)

			if var_94_8 <= arg_91_1.time_ and arg_91_1.time_ < var_94_8 + var_94_16 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_8) / var_94_16

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_8 + var_94_16 and arg_91_1.time_ < var_94_8 + var_94_16 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "3043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_91_1:InitPlayNodeList()
	end,
	Play412031023 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 412031023
		arg_95_1.duration_ = 5

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play412031024(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1.var_.moveOldPos1097ui_story = arg_95_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_98_0 = 0.001

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_0 then
				arg_95_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_95_1.var_.moveOldPos1097ui_story, Vector3.New(0, 100, 0), (arg_95_1.time_ - 0) / var_98_0)
				arg_95_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_95_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_95_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_95_1.actors_["1097ui_story"].transform.position).z)
				arg_95_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_95_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_95_1.actors_["1097ui_story"].transform.localEulerAngles = arg_95_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_95_1.time_ >= 0 + var_98_0 and arg_95_1.time_ < 0 + var_98_0 + arg_98_0 then
				arg_95_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_95_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_95_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_95_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_95_1.actors_["1097ui_story"].transform.position).z)
				arg_95_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_95_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_95_1.actors_["1097ui_story"].transform.localEulerAngles = arg_95_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_98_1 = arg_95_1.actors_["1097ui_story"]

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 and not isNil(var_98_1) and arg_95_1.var_.characterEffect1097ui_story == nil then
				arg_95_1.var_.characterEffect1097ui_story = var_98_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_98_2 = 0.200000002980232

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_2 and not isNil(var_98_1) then
				if arg_95_1.var_.characterEffect1097ui_story and not isNil(var_98_1) then
					arg_95_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_95_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_95_1.time_ - 0) / var_98_2)
				end
			end

			if arg_95_1.time_ >= 0 + var_98_2 and arg_95_1.time_ < 0 + var_98_2 + arg_98_0 and not isNil(var_98_1) and arg_95_1.var_.characterEffect1097ui_story then
				arg_95_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_95_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_98_3 = arg_95_1.actors_["3043ui_story"].transform

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1.var_.moveOldPos3043ui_story = var_98_3.localPosition
			end

			local var_98_4 = 0.001

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_4 then
				var_98_3.localPosition = Vector3.Lerp(arg_95_1.var_.moveOldPos3043ui_story, Vector3.New(0, 100, 0), (arg_95_1.time_ - 0) / var_98_4)
				var_98_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_98_3.position).x, (manager.ui.mainCamera.transform.position - var_98_3.position).y, (manager.ui.mainCamera.transform.position - var_98_3.position).z)
				var_98_3.localEulerAngles.z = 0
				var_98_3.localEulerAngles.x = 0
				var_98_3.localEulerAngles = var_98_3.localEulerAngles
			end

			if arg_95_1.time_ >= 0 + var_98_4 and arg_95_1.time_ < 0 + var_98_4 + arg_98_0 then
				var_98_3.localPosition = Vector3.New(0, 100, 0)
				var_98_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_98_3.position).x, (manager.ui.mainCamera.transform.position - var_98_3.position).y, (manager.ui.mainCamera.transform.position - var_98_3.position).z)
				var_98_3.localEulerAngles.z = 0
				var_98_3.localEulerAngles.x = 0
				var_98_3.localEulerAngles = var_98_3.localEulerAngles
			end

			local var_98_5 = arg_95_1.actors_["3043ui_story"]

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 and not isNil(var_98_5) and arg_95_1.var_.characterEffect3043ui_story == nil then
				arg_95_1.var_.characterEffect3043ui_story = var_98_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_98_6 = 0.200000002980232

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_6 and not isNil(var_98_5) then
				if arg_95_1.var_.characterEffect3043ui_story and not isNil(var_98_5) then
					arg_95_1.var_.characterEffect3043ui_story.fillFlat = true
					arg_95_1.var_.characterEffect3043ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_95_1.time_ - 0) / var_98_6)
				end
			end

			if arg_95_1.time_ >= 0 + var_98_6 and arg_95_1.time_ < 0 + var_98_6 + arg_98_0 and not isNil(var_98_5) and arg_95_1.var_.characterEffect3043ui_story then
				arg_95_1.var_.characterEffect3043ui_story.fillFlat = true
				arg_95_1.var_.characterEffect3043ui_story.fillRatio = 0.5
			end

			local var_98_7 = 0
			local var_98_8 = 0.375

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= var_98_7 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, false)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_9 = arg_95_1:FormatText(arg_95_1:GetWordFromCfg(412031023).content)

				arg_95_1.text_.text = var_98_9

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_11 = 15 <= 0 and var_98_8 or var_98_8 * (utf8.len(var_98_9) / 15)

				if (15 <= 0 and var_98_8 or var_98_8 * (utf8.len(var_98_9) / 15)) > 0 and var_98_8 < var_98_11 then
					arg_95_1.talkMaxDuration = var_98_11

					if var_98_11 + var_98_7 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_11 + var_98_7
					end
				end

				arg_95_1.text_.text = var_98_9
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)
				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_12 = math.max(var_98_8, arg_95_1.talkMaxDuration)

			if var_98_7 <= arg_95_1.time_ and arg_95_1.time_ < var_98_7 + var_98_12 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_7) / var_98_12

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_7 + var_98_12 and arg_95_1.time_ < var_98_7 + var_98_12 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "3043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_95_1:InitPlayNodeList()
	end,
	Play412031024 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 412031024
		arg_99_1.duration_ = 5

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play412031025(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			local var_102_0 = 0.9

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, false)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_1 = arg_99_1:FormatText(arg_99_1:GetWordFromCfg(412031024).content)

				arg_99_1.text_.text = var_102_1

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_3 = 36 <= 0 and var_102_0 or var_102_0 * (utf8.len(var_102_1) / 36)

				if (36 <= 0 and var_102_0 or var_102_0 * (utf8.len(var_102_1) / 36)) > 0 and var_102_0 < var_102_3 then
					arg_99_1.talkMaxDuration = var_102_3

					if var_102_3 + 0 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_3 + 0
					end
				end

				arg_99_1.text_.text = var_102_1
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)
				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_4 = math.max(var_102_0, arg_99_1.talkMaxDuration)

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_4 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - 0) / var_102_4

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= 0 + var_102_4 and arg_99_1.time_ < 0 + var_102_4 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {}

		arg_99_1:InitPlayNodeList()
	end,
	Play412031025 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 412031025
		arg_103_1.duration_ = 7.5

		local var_103_0 = {
			zh = 7.233,
			ja = 7.5
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
				arg_103_0:Play412031026(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 then
				arg_103_1.var_.moveOldPos3043ui_story = arg_103_1.actors_["3043ui_story"].transform.localPosition
			end

			local var_106_0 = 0.001

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_0 then
				arg_103_1.actors_["3043ui_story"].transform.localPosition = Vector3.Lerp(arg_103_1.var_.moveOldPos3043ui_story, Vector3.New(0, -1.41, -5.7), (arg_103_1.time_ - 0) / var_106_0)
				arg_103_1.actors_["3043ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_103_1.actors_["3043ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_103_1.actors_["3043ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_103_1.actors_["3043ui_story"].transform.position).z)
				arg_103_1.actors_["3043ui_story"].transform.localEulerAngles.z = 0
				arg_103_1.actors_["3043ui_story"].transform.localEulerAngles.x = 0
				arg_103_1.actors_["3043ui_story"].transform.localEulerAngles = arg_103_1.actors_["3043ui_story"].transform.localEulerAngles
			end

			if arg_103_1.time_ >= 0 + var_106_0 and arg_103_1.time_ < 0 + var_106_0 + arg_106_0 then
				arg_103_1.actors_["3043ui_story"].transform.localPosition = Vector3.New(0, -1.41, -5.7)
				arg_103_1.actors_["3043ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_103_1.actors_["3043ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_103_1.actors_["3043ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_103_1.actors_["3043ui_story"].transform.position).z)
				arg_103_1.actors_["3043ui_story"].transform.localEulerAngles.z = 0
				arg_103_1.actors_["3043ui_story"].transform.localEulerAngles.x = 0
				arg_103_1.actors_["3043ui_story"].transform.localEulerAngles = arg_103_1.actors_["3043ui_story"].transform.localEulerAngles
			end

			local var_106_1 = arg_103_1.actors_["3043ui_story"]

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 and not isNil(var_106_1) and arg_103_1.var_.characterEffect3043ui_story == nil then
				arg_103_1.var_.characterEffect3043ui_story = var_106_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_106_2 = 0.200000002980232

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_2 and not isNil(var_106_1) then
				if arg_103_1.var_.characterEffect3043ui_story and not isNil(var_106_1) then
					arg_103_1.var_.characterEffect3043ui_story.fillFlat = false
				end
			end

			if arg_103_1.time_ >= 0 + var_106_2 and arg_103_1.time_ < 0 + var_106_2 + arg_106_0 and not isNil(var_106_1) and arg_103_1.var_.characterEffect3043ui_story then
				arg_103_1.var_.characterEffect3043ui_story.fillFlat = false
			end

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 then
				arg_103_1:PlayTimeline("3043ui_story", "StoryTimeline/CharAction/story3043/story3043action/3043action1_1")
			end

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 then
				arg_103_1:PlayTimeline("3043ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_106_4 = 0
			local var_106_5 = 0.8

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= var_106_4 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				arg_103_1.leftNameTxt_.text = arg_103_1:FormatText(StoryNameCfg[920].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_6 = arg_103_1:GetWordFromCfg(412031025)
				local var_106_7 = arg_103_1:FormatText(var_106_6.content)

				arg_103_1.text_.text = var_106_7

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_9 = 32 <= 0 and var_106_5 or var_106_5 * (utf8.len(var_106_7) / 32)

				if (32 <= 0 and var_106_5 or var_106_5 * (utf8.len(var_106_7) / 32)) > 0 and var_106_5 < var_106_9 then
					arg_103_1.talkMaxDuration = var_106_9

					if var_106_9 + var_106_4 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_9 + var_106_4
					end
				end

				arg_103_1.text_.text = var_106_7
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031025", "story_v_out_412031.awb") ~= 0 then
					local var_106_10 = manager.audio:GetVoiceLength("story_v_out_412031", "412031025", "story_v_out_412031.awb") / 1000

					if var_106_10 + var_106_4 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_10 + var_106_4
					end

					if var_106_6.prefab_name ~= "" and arg_103_1.actors_[var_106_6.prefab_name] ~= nil then
						local var_106_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_103_1.actors_[var_106_6.prefab_name].transform, "story_v_out_412031", "412031025", "story_v_out_412031.awb")

						arg_103_1:RecordAudio("412031025", var_106_11)
						arg_103_1:RecordAudio("412031025", var_106_11)
					else
						arg_103_1:AudioAction("play", "voice", "story_v_out_412031", "412031025", "story_v_out_412031.awb")
					end

					arg_103_1:RecordHistoryTalkVoice("story_v_out_412031", "412031025", "story_v_out_412031.awb")
				end

				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_12 = math.max(var_106_5, arg_103_1.talkMaxDuration)

			if var_106_4 <= arg_103_1.time_ and arg_103_1.time_ < var_106_4 + var_106_12 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_4) / var_106_12

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_4 + var_106_12 and arg_103_1.time_ < var_106_4 + var_106_12 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_103_1:InitPlayNodeList()
	end,
	Play412031026 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 412031026
		arg_107_1.duration_ = 7.2

		SetActive(arg_107_1.tipsGo_, false)

		function arg_107_1.onSingleLineFinish_()
			arg_107_1.onSingleLineUpdate_ = nil
			arg_107_1.onSingleLineFinish_ = nil
			arg_107_1.state_ = "waiting"
		end

		function arg_107_1.playNext_(arg_109_0)
			if arg_109_0 == 1 then
				arg_107_0:Play412031027(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1.var_.moveOldPos1097ui_story = arg_107_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_110_0 = 0.001

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_0 then
				arg_107_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_107_1.var_.moveOldPos1097ui_story, Vector3.New(-0.7, -0.54, -6.3), (arg_107_1.time_ - 0) / var_110_0)
				arg_107_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_107_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_107_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_107_1.actors_["1097ui_story"].transform.position).z)
				arg_107_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_107_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_107_1.actors_["1097ui_story"].transform.localEulerAngles = arg_107_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_107_1.time_ >= 0 + var_110_0 and arg_107_1.time_ < 0 + var_110_0 + arg_110_0 then
				arg_107_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(-0.7, -0.54, -6.3)
				arg_107_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_107_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_107_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_107_1.actors_["1097ui_story"].transform.position).z)
				arg_107_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_107_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_107_1.actors_["1097ui_story"].transform.localEulerAngles = arg_107_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_110_1 = arg_107_1.actors_["1097ui_story"]

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 and not isNil(var_110_1) and arg_107_1.var_.characterEffect1097ui_story == nil then
				arg_107_1.var_.characterEffect1097ui_story = var_110_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_110_2 = 0.200000002980232

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_2 and not isNil(var_110_1) then
				if arg_107_1.var_.characterEffect1097ui_story and not isNil(var_110_1) then
					arg_107_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_107_1.time_ >= 0 + var_110_2 and arg_107_1.time_ < 0 + var_110_2 + arg_110_0 and not isNil(var_110_1) and arg_107_1.var_.characterEffect1097ui_story then
				arg_107_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action7_1")
			end

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_110_4 = arg_107_1.actors_["3043ui_story"]

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 and not isNil(var_110_4) and arg_107_1.var_.characterEffect3043ui_story == nil then
				arg_107_1.var_.characterEffect3043ui_story = var_110_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_110_5 = 0.200000002980232

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_5 and not isNil(var_110_4) then
				if arg_107_1.var_.characterEffect3043ui_story and not isNil(var_110_4) then
					arg_107_1.var_.characterEffect3043ui_story.fillFlat = true
					arg_107_1.var_.characterEffect3043ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_107_1.time_ - 0) / var_110_5)
				end
			end

			if arg_107_1.time_ >= 0 + var_110_5 and arg_107_1.time_ < 0 + var_110_5 + arg_110_0 and not isNil(var_110_4) and arg_107_1.var_.characterEffect3043ui_story then
				arg_107_1.var_.characterEffect3043ui_story.fillFlat = true
				arg_107_1.var_.characterEffect3043ui_story.fillRatio = 0.5
			end

			local var_110_6 = arg_107_1.actors_["3043ui_story"].transform

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1.var_.moveOldPos3043ui_story = var_110_6.localPosition
			end

			local var_110_7 = 0.001

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_7 then
				var_110_6.localPosition = Vector3.Lerp(arg_107_1.var_.moveOldPos3043ui_story, Vector3.New(0.7, -1.41, -5.7), (arg_107_1.time_ - 0) / var_110_7)
				var_110_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_110_6.position).x, (manager.ui.mainCamera.transform.position - var_110_6.position).y, (manager.ui.mainCamera.transform.position - var_110_6.position).z)
				var_110_6.localEulerAngles.z = 0
				var_110_6.localEulerAngles.x = 0
				var_110_6.localEulerAngles = var_110_6.localEulerAngles
			end

			if arg_107_1.time_ >= 0 + var_110_7 and arg_107_1.time_ < 0 + var_110_7 + arg_110_0 then
				var_110_6.localPosition = Vector3.New(0.7, -1.41, -5.7)
				var_110_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_110_6.position).x, (manager.ui.mainCamera.transform.position - var_110_6.position).y, (manager.ui.mainCamera.transform.position - var_110_6.position).z)
				var_110_6.localEulerAngles.z = 0
				var_110_6.localEulerAngles.x = 0
				var_110_6.localEulerAngles = var_110_6.localEulerAngles
			end

			local var_110_8 = 0
			local var_110_9 = 0.575

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= var_110_8 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				arg_107_1.leftNameTxt_.text = arg_107_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_10 = arg_107_1:GetWordFromCfg(412031026)
				local var_110_11 = arg_107_1:FormatText(var_110_10.content)

				arg_107_1.text_.text = var_110_11

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_13 = 23 <= 0 and var_110_9 or var_110_9 * (utf8.len(var_110_11) / 23)

				if (23 <= 0 and var_110_9 or var_110_9 * (utf8.len(var_110_11) / 23)) > 0 and var_110_9 < var_110_13 then
					arg_107_1.talkMaxDuration = var_110_13

					if var_110_13 + var_110_8 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_13 + var_110_8
					end
				end

				arg_107_1.text_.text = var_110_11
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031026", "story_v_out_412031.awb") ~= 0 then
					local var_110_14 = manager.audio:GetVoiceLength("story_v_out_412031", "412031026", "story_v_out_412031.awb") / 1000

					if var_110_14 + var_110_8 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_14 + var_110_8
					end

					if var_110_10.prefab_name ~= "" and arg_107_1.actors_[var_110_10.prefab_name] ~= nil then
						local var_110_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_107_1.actors_[var_110_10.prefab_name].transform, "story_v_out_412031", "412031026", "story_v_out_412031.awb")

						arg_107_1:RecordAudio("412031026", var_110_15)
						arg_107_1:RecordAudio("412031026", var_110_15)
					else
						arg_107_1:AudioAction("play", "voice", "story_v_out_412031", "412031026", "story_v_out_412031.awb")
					end

					arg_107_1:RecordHistoryTalkVoice("story_v_out_412031", "412031026", "story_v_out_412031.awb")
				end

				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_16 = math.max(var_110_9, arg_107_1.talkMaxDuration)

			if var_110_8 <= arg_107_1.time_ and arg_107_1.time_ < var_110_8 + var_110_16 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_8) / var_110_16

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_8 + var_110_16 and arg_107_1.time_ < var_110_8 + var_110_16 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "3043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_107_1:InitPlayNodeList()
	end,
	Play412031027 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 412031027
		arg_111_1.duration_ = 7.4

		local var_111_0 = {
			zh = 7.2,
			ja = 7.4
		}
		local var_111_1 = manager.audio:GetLocalizationFlag()

		if var_111_0[var_111_1] ~= nil then
			arg_111_1.duration_ = var_111_0[var_111_1]
		end

		SetActive(arg_111_1.tipsGo_, false)

		function arg_111_1.onSingleLineFinish_()
			arg_111_1.onSingleLineUpdate_ = nil
			arg_111_1.onSingleLineFinish_ = nil
			arg_111_1.state_ = "waiting"
		end

		function arg_111_1.playNext_(arg_113_0)
			if arg_113_0 == 1 then
				arg_111_0:Play412031028(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 and not isNil(arg_111_1.actors_["1097ui_story"]) and arg_111_1.var_.characterEffect1097ui_story == nil then
				arg_111_1.var_.characterEffect1097ui_story = arg_111_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_114_0 = 0.200000002980232

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_0 and not isNil(arg_111_1.actors_["1097ui_story"]) then
				if arg_111_1.var_.characterEffect1097ui_story and not isNil(arg_111_1.actors_["1097ui_story"]) then
					arg_111_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_111_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_111_1.time_ - 0) / var_114_0)
				end
			end

			if arg_111_1.time_ >= 0 + var_114_0 and arg_111_1.time_ < 0 + var_114_0 + arg_114_0 and not isNil(arg_111_1.actors_["1097ui_story"]) and arg_111_1.var_.characterEffect1097ui_story then
				arg_111_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_111_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				arg_111_1:PlayTimeline("3043ui_story", "StoryTimeline/CharAction/story3043/story3043action/3043action2_1")
			end

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				arg_111_1:PlayTimeline("3043ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_114_1 = arg_111_1.actors_["3043ui_story"]

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 and not isNil(var_114_1) and arg_111_1.var_.characterEffect3043ui_story == nil then
				arg_111_1.var_.characterEffect3043ui_story = var_114_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_114_2 = 0.200000002980232

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_2 and not isNil(var_114_1) then
				if arg_111_1.var_.characterEffect3043ui_story and not isNil(var_114_1) then
					arg_111_1.var_.characterEffect3043ui_story.fillFlat = false
				end
			end

			if arg_111_1.time_ >= 0 + var_114_2 and arg_111_1.time_ < 0 + var_114_2 + arg_114_0 and not isNil(var_114_1) and arg_111_1.var_.characterEffect3043ui_story then
				arg_111_1.var_.characterEffect3043ui_story.fillFlat = false
			end

			local var_114_4 = 0
			local var_114_5 = 0.55

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= var_114_4 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				arg_111_1.leftNameTxt_.text = arg_111_1:FormatText(StoryNameCfg[920].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_6 = arg_111_1:GetWordFromCfg(412031027)
				local var_114_7 = arg_111_1:FormatText(var_114_6.content)

				arg_111_1.text_.text = var_114_7

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_9 = 22 <= 0 and var_114_5 or var_114_5 * (utf8.len(var_114_7) / 22)

				if (22 <= 0 and var_114_5 or var_114_5 * (utf8.len(var_114_7) / 22)) > 0 and var_114_5 < var_114_9 then
					arg_111_1.talkMaxDuration = var_114_9

					if var_114_9 + var_114_4 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_9 + var_114_4
					end
				end

				arg_111_1.text_.text = var_114_7
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031027", "story_v_out_412031.awb") ~= 0 then
					local var_114_10 = manager.audio:GetVoiceLength("story_v_out_412031", "412031027", "story_v_out_412031.awb") / 1000

					if var_114_10 + var_114_4 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_10 + var_114_4
					end

					if var_114_6.prefab_name ~= "" and arg_111_1.actors_[var_114_6.prefab_name] ~= nil then
						local var_114_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_6.prefab_name].transform, "story_v_out_412031", "412031027", "story_v_out_412031.awb")

						arg_111_1:RecordAudio("412031027", var_114_11)
						arg_111_1:RecordAudio("412031027", var_114_11)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_out_412031", "412031027", "story_v_out_412031.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_out_412031", "412031027", "story_v_out_412031.awb")
				end

				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_12 = math.max(var_114_5, arg_111_1.talkMaxDuration)

			if var_114_4 <= arg_111_1.time_ and arg_111_1.time_ < var_114_4 + var_114_12 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_4) / var_114_12

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_4 + var_114_12 and arg_111_1.time_ < var_114_4 + var_114_12 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {}

		arg_111_1:InitPlayNodeList()
	end,
	Play412031028 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 412031028
		arg_115_1.duration_ = 3.33

		local var_115_0 = {
			zh = 2.5,
			ja = 3.333
		}
		local var_115_1 = manager.audio:GetLocalizationFlag()

		if var_115_0[var_115_1] ~= nil then
			arg_115_1.duration_ = var_115_0[var_115_1]
		end

		SetActive(arg_115_1.tipsGo_, false)

		function arg_115_1.onSingleLineFinish_()
			arg_115_1.onSingleLineUpdate_ = nil
			arg_115_1.onSingleLineFinish_ = nil
			arg_115_1.state_ = "waiting"
		end

		function arg_115_1.playNext_(arg_117_0)
			if arg_117_0 == 1 then
				arg_115_0:Play412031029(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 and not isNil(arg_115_1.actors_["1097ui_story"]) and arg_115_1.var_.characterEffect1097ui_story == nil then
				arg_115_1.var_.characterEffect1097ui_story = arg_115_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_0 = 0.200000002980232

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_0 and not isNil(arg_115_1.actors_["1097ui_story"]) then
				if arg_115_1.var_.characterEffect1097ui_story and not isNil(arg_115_1.actors_["1097ui_story"]) then
					arg_115_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_115_1.time_ >= 0 + var_118_0 and arg_115_1.time_ < 0 + var_118_0 + arg_118_0 and not isNil(arg_115_1.actors_["1097ui_story"]) and arg_115_1.var_.characterEffect1097ui_story then
				arg_115_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action7_2")
			end

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_118_2 = arg_115_1.actors_["3043ui_story"]

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 and not isNil(var_118_2) and arg_115_1.var_.characterEffect3043ui_story == nil then
				arg_115_1.var_.characterEffect3043ui_story = var_118_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_3 = 0.200000002980232

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_3 and not isNil(var_118_2) then
				if arg_115_1.var_.characterEffect3043ui_story and not isNil(var_118_2) then
					arg_115_1.var_.characterEffect3043ui_story.fillFlat = true
					arg_115_1.var_.characterEffect3043ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_115_1.time_ - 0) / var_118_3)
				end
			end

			if arg_115_1.time_ >= 0 + var_118_3 and arg_115_1.time_ < 0 + var_118_3 + arg_118_0 and not isNil(var_118_2) and arg_115_1.var_.characterEffect3043ui_story then
				arg_115_1.var_.characterEffect3043ui_story.fillFlat = true
				arg_115_1.var_.characterEffect3043ui_story.fillRatio = 0.5
			end

			local var_118_4 = 0
			local var_118_5 = 0.125

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= var_118_4 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				arg_115_1.leftNameTxt_.text = arg_115_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_6 = arg_115_1:GetWordFromCfg(412031028)
				local var_118_7 = arg_115_1:FormatText(var_118_6.content)

				arg_115_1.text_.text = var_118_7

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_9 = 5 <= 0 and var_118_5 or var_118_5 * (utf8.len(var_118_7) / 5)

				if (5 <= 0 and var_118_5 or var_118_5 * (utf8.len(var_118_7) / 5)) > 0 and var_118_5 < var_118_9 then
					arg_115_1.talkMaxDuration = var_118_9

					if var_118_9 + var_118_4 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_9 + var_118_4
					end
				end

				arg_115_1.text_.text = var_118_7
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031028", "story_v_out_412031.awb") ~= 0 then
					local var_118_10 = manager.audio:GetVoiceLength("story_v_out_412031", "412031028", "story_v_out_412031.awb") / 1000

					if var_118_10 + var_118_4 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_10 + var_118_4
					end

					if var_118_6.prefab_name ~= "" and arg_115_1.actors_[var_118_6.prefab_name] ~= nil then
						local var_118_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_6.prefab_name].transform, "story_v_out_412031", "412031028", "story_v_out_412031.awb")

						arg_115_1:RecordAudio("412031028", var_118_11)
						arg_115_1:RecordAudio("412031028", var_118_11)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_412031", "412031028", "story_v_out_412031.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_412031", "412031028", "story_v_out_412031.awb")
				end

				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_12 = math.max(var_118_5, arg_115_1.talkMaxDuration)

			if var_118_4 <= arg_115_1.time_ and arg_115_1.time_ < var_118_4 + var_118_12 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_4) / var_118_12

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_4 + var_118_12 and arg_115_1.time_ < var_118_4 + var_118_12 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {}

		arg_115_1:InitPlayNodeList()
	end,
	Play412031029 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 412031029
		arg_119_1.duration_ = 5

		SetActive(arg_119_1.tipsGo_, false)

		function arg_119_1.onSingleLineFinish_()
			arg_119_1.onSingleLineUpdate_ = nil
			arg_119_1.onSingleLineFinish_ = nil
			arg_119_1.state_ = "waiting"
		end

		function arg_119_1.playNext_(arg_121_0)
			if arg_121_0 == 1 then
				arg_119_0:Play412031030(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1.var_.moveOldPos1097ui_story = arg_119_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_122_0 = 0.001

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_0 then
				arg_119_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos1097ui_story, Vector3.New(0, 100, 0), (arg_119_1.time_ - 0) / var_122_0)
				arg_119_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_119_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_119_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_119_1.actors_["1097ui_story"].transform.position).z)
				arg_119_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_119_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_119_1.actors_["1097ui_story"].transform.localEulerAngles = arg_119_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_119_1.time_ >= 0 + var_122_0 and arg_119_1.time_ < 0 + var_122_0 + arg_122_0 then
				arg_119_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_119_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_119_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_119_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_119_1.actors_["1097ui_story"].transform.position).z)
				arg_119_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_119_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_119_1.actors_["1097ui_story"].transform.localEulerAngles = arg_119_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_122_1 = arg_119_1.actors_["1097ui_story"]

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 and not isNil(var_122_1) and arg_119_1.var_.characterEffect1097ui_story == nil then
				arg_119_1.var_.characterEffect1097ui_story = var_122_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_2 = 0.200000002980232

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_2 and not isNil(var_122_1) then
				if arg_119_1.var_.characterEffect1097ui_story and not isNil(var_122_1) then
					arg_119_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_119_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_119_1.time_ - 0) / var_122_2)
				end
			end

			if arg_119_1.time_ >= 0 + var_122_2 and arg_119_1.time_ < 0 + var_122_2 + arg_122_0 and not isNil(var_122_1) and arg_119_1.var_.characterEffect1097ui_story then
				arg_119_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_119_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_122_3 = arg_119_1.actors_["3043ui_story"].transform

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1.var_.moveOldPos3043ui_story = var_122_3.localPosition
			end

			local var_122_4 = 0.001

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_4 then
				var_122_3.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos3043ui_story, Vector3.New(0, 100, 0), (arg_119_1.time_ - 0) / var_122_4)
				var_122_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_122_3.position).x, (manager.ui.mainCamera.transform.position - var_122_3.position).y, (manager.ui.mainCamera.transform.position - var_122_3.position).z)
				var_122_3.localEulerAngles.z = 0
				var_122_3.localEulerAngles.x = 0
				var_122_3.localEulerAngles = var_122_3.localEulerAngles
			end

			if arg_119_1.time_ >= 0 + var_122_4 and arg_119_1.time_ < 0 + var_122_4 + arg_122_0 then
				var_122_3.localPosition = Vector3.New(0, 100, 0)
				var_122_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_122_3.position).x, (manager.ui.mainCamera.transform.position - var_122_3.position).y, (manager.ui.mainCamera.transform.position - var_122_3.position).z)
				var_122_3.localEulerAngles.z = 0
				var_122_3.localEulerAngles.x = 0
				var_122_3.localEulerAngles = var_122_3.localEulerAngles
			end

			local var_122_5 = arg_119_1.actors_["3043ui_story"]

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 and not isNil(var_122_5) and arg_119_1.var_.characterEffect3043ui_story == nil then
				arg_119_1.var_.characterEffect3043ui_story = var_122_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_6 = 0.200000002980232

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_6 and not isNil(var_122_5) then
				if arg_119_1.var_.characterEffect3043ui_story and not isNil(var_122_5) then
					arg_119_1.var_.characterEffect3043ui_story.fillFlat = true
					arg_119_1.var_.characterEffect3043ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_119_1.time_ - 0) / var_122_6)
				end
			end

			if arg_119_1.time_ >= 0 + var_122_6 and arg_119_1.time_ < 0 + var_122_6 + arg_122_0 and not isNil(var_122_5) and arg_119_1.var_.characterEffect3043ui_story then
				arg_119_1.var_.characterEffect3043ui_story.fillFlat = true
				arg_119_1.var_.characterEffect3043ui_story.fillRatio = 0.5
			end

			local var_122_7 = 0
			local var_122_8 = 0.925

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= var_122_7 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, false)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_9 = arg_119_1:FormatText(arg_119_1:GetWordFromCfg(412031029).content)

				arg_119_1.text_.text = var_122_9

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_11 = 37 <= 0 and var_122_8 or var_122_8 * (utf8.len(var_122_9) / 37)

				if (37 <= 0 and var_122_8 or var_122_8 * (utf8.len(var_122_9) / 37)) > 0 and var_122_8 < var_122_11 then
					arg_119_1.talkMaxDuration = var_122_11

					if var_122_11 + var_122_7 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_11 + var_122_7
					end
				end

				arg_119_1.text_.text = var_122_9
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)
				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_12 = math.max(var_122_8, arg_119_1.talkMaxDuration)

			if var_122_7 <= arg_119_1.time_ and arg_119_1.time_ < var_122_7 + var_122_12 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_7) / var_122_12

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_7 + var_122_12 and arg_119_1.time_ < var_122_7 + var_122_12 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "3043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_119_1:InitPlayNodeList()
	end,
	Play412031030 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 412031030
		arg_123_1.duration_ = 6.37

		local var_123_0 = {
			zh = 5.166,
			ja = 6.366
		}
		local var_123_1 = manager.audio:GetLocalizationFlag()

		if var_123_0[var_123_1] ~= nil then
			arg_123_1.duration_ = var_123_0[var_123_1]
		end

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play412031031(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1.var_.moveOldPos1097ui_story = arg_123_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_126_0 = 0.001

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_0 then
				arg_123_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_123_1.var_.moveOldPos1097ui_story, Vector3.New(0, -0.54, -6.3), (arg_123_1.time_ - 0) / var_126_0)
				arg_123_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_123_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_123_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_123_1.actors_["1097ui_story"].transform.position).z)
				arg_123_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_123_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_123_1.actors_["1097ui_story"].transform.localEulerAngles = arg_123_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_123_1.time_ >= 0 + var_126_0 and arg_123_1.time_ < 0 + var_126_0 + arg_126_0 then
				arg_123_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(0, -0.54, -6.3)
				arg_123_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_123_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_123_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_123_1.actors_["1097ui_story"].transform.position).z)
				arg_123_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_123_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_123_1.actors_["1097ui_story"].transform.localEulerAngles = arg_123_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_126_1 = arg_123_1.actors_["1097ui_story"]

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 and not isNil(var_126_1) and arg_123_1.var_.characterEffect1097ui_story == nil then
				arg_123_1.var_.characterEffect1097ui_story = var_126_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_126_2 = 0.200000002980232

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_2 and not isNil(var_126_1) then
				if arg_123_1.var_.characterEffect1097ui_story and not isNil(var_126_1) then
					arg_123_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_123_1.time_ >= 0 + var_126_2 and arg_123_1.time_ < 0 + var_126_2 + arg_126_0 and not isNil(var_126_1) and arg_123_1.var_.characterEffect1097ui_story then
				arg_123_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action6_1")
			end

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_126_4 = 0
			local var_126_5 = 0.475

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_4 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				arg_123_1.leftNameTxt_.text = arg_123_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_6 = arg_123_1:GetWordFromCfg(412031030)
				local var_126_7 = arg_123_1:FormatText(var_126_6.content)

				arg_123_1.text_.text = var_126_7

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_9 = 19 <= 0 and var_126_5 or var_126_5 * (utf8.len(var_126_7) / 19)

				if (19 <= 0 and var_126_5 or var_126_5 * (utf8.len(var_126_7) / 19)) > 0 and var_126_5 < var_126_9 then
					arg_123_1.talkMaxDuration = var_126_9

					if var_126_9 + var_126_4 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_9 + var_126_4
					end
				end

				arg_123_1.text_.text = var_126_7
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031030", "story_v_out_412031.awb") ~= 0 then
					local var_126_10 = manager.audio:GetVoiceLength("story_v_out_412031", "412031030", "story_v_out_412031.awb") / 1000

					if var_126_10 + var_126_4 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_10 + var_126_4
					end

					if var_126_6.prefab_name ~= "" and arg_123_1.actors_[var_126_6.prefab_name] ~= nil then
						local var_126_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_6.prefab_name].transform, "story_v_out_412031", "412031030", "story_v_out_412031.awb")

						arg_123_1:RecordAudio("412031030", var_126_11)
						arg_123_1:RecordAudio("412031030", var_126_11)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_412031", "412031030", "story_v_out_412031.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_412031", "412031030", "story_v_out_412031.awb")
				end

				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_12 = math.max(var_126_5, arg_123_1.talkMaxDuration)

			if var_126_4 <= arg_123_1.time_ and arg_123_1.time_ < var_126_4 + var_126_12 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_4) / var_126_12

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_4 + var_126_12 and arg_123_1.time_ < var_126_4 + var_126_12 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_123_1:InitPlayNodeList()
	end,
	Play412031031 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 412031031
		arg_127_1.duration_ = 10.6

		local var_127_0 = {
			zh = 8.5,
			ja = 10.6
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
				arg_127_0:Play412031032(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = 0.75

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				arg_127_1.leftNameTxt_.text = arg_127_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_1 = arg_127_1:GetWordFromCfg(412031031)
				local var_130_2 = arg_127_1:FormatText(var_130_1.content)

				arg_127_1.text_.text = var_130_2

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_4 = 30 <= 0 and var_130_0 or var_130_0 * (utf8.len(var_130_2) / 30)

				if (30 <= 0 and var_130_0 or var_130_0 * (utf8.len(var_130_2) / 30)) > 0 and var_130_0 < var_130_4 then
					arg_127_1.talkMaxDuration = var_130_4

					if var_130_4 + 0 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_4 + 0
					end
				end

				arg_127_1.text_.text = var_130_2
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031031", "story_v_out_412031.awb") ~= 0 then
					local var_130_5 = manager.audio:GetVoiceLength("story_v_out_412031", "412031031", "story_v_out_412031.awb") / 1000

					if var_130_5 + 0 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_5 + 0
					end

					if var_130_1.prefab_name ~= "" and arg_127_1.actors_[var_130_1.prefab_name] ~= nil then
						local var_130_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_1.prefab_name].transform, "story_v_out_412031", "412031031", "story_v_out_412031.awb")

						arg_127_1:RecordAudio("412031031", var_130_6)
						arg_127_1:RecordAudio("412031031", var_130_6)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_412031", "412031031", "story_v_out_412031.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_412031", "412031031", "story_v_out_412031.awb")
				end

				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_7 = math.max(var_130_0, arg_127_1.talkMaxDuration)

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_7 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - 0) / var_130_7

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= 0 + var_130_7 and arg_127_1.time_ < 0 + var_130_7 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {}

		arg_127_1:InitPlayNodeList()
	end,
	Play412031032 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 412031032
		arg_131_1.duration_ = 8.73

		local var_131_0 = {
			zh = 8.733,
			ja = 7.1
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
				arg_131_0:Play412031033(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1.var_.moveOldPos3043ui_story = arg_131_1.actors_["3043ui_story"].transform.localPosition
			end

			local var_134_0 = 0.001

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_0 then
				arg_131_1.actors_["3043ui_story"].transform.localPosition = Vector3.Lerp(arg_131_1.var_.moveOldPos3043ui_story, Vector3.New(0, -1.41, -5.7), (arg_131_1.time_ - 0) / var_134_0)
				arg_131_1.actors_["3043ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_131_1.actors_["3043ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_131_1.actors_["3043ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_131_1.actors_["3043ui_story"].transform.position).z)
				arg_131_1.actors_["3043ui_story"].transform.localEulerAngles.z = 0
				arg_131_1.actors_["3043ui_story"].transform.localEulerAngles.x = 0
				arg_131_1.actors_["3043ui_story"].transform.localEulerAngles = arg_131_1.actors_["3043ui_story"].transform.localEulerAngles
			end

			if arg_131_1.time_ >= 0 + var_134_0 and arg_131_1.time_ < 0 + var_134_0 + arg_134_0 then
				arg_131_1.actors_["3043ui_story"].transform.localPosition = Vector3.New(0, -1.41, -5.7)
				arg_131_1.actors_["3043ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_131_1.actors_["3043ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_131_1.actors_["3043ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_131_1.actors_["3043ui_story"].transform.position).z)
				arg_131_1.actors_["3043ui_story"].transform.localEulerAngles.z = 0
				arg_131_1.actors_["3043ui_story"].transform.localEulerAngles.x = 0
				arg_131_1.actors_["3043ui_story"].transform.localEulerAngles = arg_131_1.actors_["3043ui_story"].transform.localEulerAngles
			end

			local var_134_1 = arg_131_1.actors_["3043ui_story"]

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 and not isNil(var_134_1) and arg_131_1.var_.characterEffect3043ui_story == nil then
				arg_131_1.var_.characterEffect3043ui_story = var_134_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_2 = 0.200000002980232

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_2 and not isNil(var_134_1) then
				if arg_131_1.var_.characterEffect3043ui_story and not isNil(var_134_1) then
					arg_131_1.var_.characterEffect3043ui_story.fillFlat = false
				end
			end

			if arg_131_1.time_ >= 0 + var_134_2 and arg_131_1.time_ < 0 + var_134_2 + arg_134_0 and not isNil(var_134_1) and arg_131_1.var_.characterEffect3043ui_story then
				arg_131_1.var_.characterEffect3043ui_story.fillFlat = false
			end

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1:PlayTimeline("3043ui_story", "StoryTimeline/CharAction/story3043/story3043action/3043action1_1")
			end

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1:PlayTimeline("3043ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_134_4 = arg_131_1.actors_["1097ui_story"].transform

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1.var_.moveOldPos1097ui_story = var_134_4.localPosition
			end

			local var_134_5 = 0.001

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_5 then
				var_134_4.localPosition = Vector3.Lerp(arg_131_1.var_.moveOldPos1097ui_story, Vector3.New(0, 100, 0), (arg_131_1.time_ - 0) / var_134_5)
				var_134_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_134_4.position).x, (manager.ui.mainCamera.transform.position - var_134_4.position).y, (manager.ui.mainCamera.transform.position - var_134_4.position).z)
				var_134_4.localEulerAngles.z = 0
				var_134_4.localEulerAngles.x = 0
				var_134_4.localEulerAngles = var_134_4.localEulerAngles
			end

			if arg_131_1.time_ >= 0 + var_134_5 and arg_131_1.time_ < 0 + var_134_5 + arg_134_0 then
				var_134_4.localPosition = Vector3.New(0, 100, 0)
				var_134_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_134_4.position).x, (manager.ui.mainCamera.transform.position - var_134_4.position).y, (manager.ui.mainCamera.transform.position - var_134_4.position).z)
				var_134_4.localEulerAngles.z = 0
				var_134_4.localEulerAngles.x = 0
				var_134_4.localEulerAngles = var_134_4.localEulerAngles
			end

			local var_134_6 = arg_131_1.actors_["1097ui_story"]

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 and not isNil(var_134_6) and arg_131_1.var_.characterEffect1097ui_story == nil then
				arg_131_1.var_.characterEffect1097ui_story = var_134_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_7 = 0.200000002980232

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_7 and not isNil(var_134_6) then
				if arg_131_1.var_.characterEffect1097ui_story and not isNil(var_134_6) then
					arg_131_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_131_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_131_1.time_ - 0) / var_134_7)
				end
			end

			if arg_131_1.time_ >= 0 + var_134_7 and arg_131_1.time_ < 0 + var_134_7 + arg_134_0 and not isNil(var_134_6) and arg_131_1.var_.characterEffect1097ui_story then
				arg_131_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_131_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_134_8 = 0
			local var_134_9 = 0.925

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= var_134_8 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				arg_131_1.leftNameTxt_.text = arg_131_1:FormatText(StoryNameCfg[920].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_10 = arg_131_1:GetWordFromCfg(412031032)
				local var_134_11 = arg_131_1:FormatText(var_134_10.content)

				arg_131_1.text_.text = var_134_11

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_13 = 37 <= 0 and var_134_9 or var_134_9 * (utf8.len(var_134_11) / 37)

				if (37 <= 0 and var_134_9 or var_134_9 * (utf8.len(var_134_11) / 37)) > 0 and var_134_9 < var_134_13 then
					arg_131_1.talkMaxDuration = var_134_13

					if var_134_13 + var_134_8 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_13 + var_134_8
					end
				end

				arg_131_1.text_.text = var_134_11
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031032", "story_v_out_412031.awb") ~= 0 then
					local var_134_14 = manager.audio:GetVoiceLength("story_v_out_412031", "412031032", "story_v_out_412031.awb") / 1000

					if var_134_14 + var_134_8 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_14 + var_134_8
					end

					if var_134_10.prefab_name ~= "" and arg_131_1.actors_[var_134_10.prefab_name] ~= nil then
						local var_134_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_10.prefab_name].transform, "story_v_out_412031", "412031032", "story_v_out_412031.awb")

						arg_131_1:RecordAudio("412031032", var_134_15)
						arg_131_1:RecordAudio("412031032", var_134_15)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_412031", "412031032", "story_v_out_412031.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_412031", "412031032", "story_v_out_412031.awb")
				end

				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_16 = math.max(var_134_9, arg_131_1.talkMaxDuration)

			if var_134_8 <= arg_131_1.time_ and arg_131_1.time_ < var_134_8 + var_134_16 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_8) / var_134_16

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_8 + var_134_16 and arg_131_1.time_ < var_134_8 + var_134_16 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1097ui_story",
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
	Play412031033 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 412031033
		arg_135_1.duration_ = 7.23

		local var_135_0 = {
			zh = 7.233,
			ja = 6.033
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
				arg_135_0:Play412031034(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1.var_.moveOldPos10083ui_story = arg_135_1.actors_["10083ui_story"].transform.localPosition
			end

			local var_138_0 = 0.001

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_0 then
				arg_135_1.actors_["10083ui_story"].transform.localPosition = Vector3.Lerp(arg_135_1.var_.moveOldPos10083ui_story, Vector3.New(0, -2.6, -2.8), (arg_135_1.time_ - 0) / var_138_0)
				arg_135_1.actors_["10083ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_135_1.actors_["10083ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_135_1.actors_["10083ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_135_1.actors_["10083ui_story"].transform.position).z)
				arg_135_1.actors_["10083ui_story"].transform.localEulerAngles.z = 0
				arg_135_1.actors_["10083ui_story"].transform.localEulerAngles.x = 0
				arg_135_1.actors_["10083ui_story"].transform.localEulerAngles = arg_135_1.actors_["10083ui_story"].transform.localEulerAngles
			end

			if arg_135_1.time_ >= 0 + var_138_0 and arg_135_1.time_ < 0 + var_138_0 + arg_138_0 then
				arg_135_1.actors_["10083ui_story"].transform.localPosition = Vector3.New(0, -2.6, -2.8)
				arg_135_1.actors_["10083ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_135_1.actors_["10083ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_135_1.actors_["10083ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_135_1.actors_["10083ui_story"].transform.position).z)
				arg_135_1.actors_["10083ui_story"].transform.localEulerAngles.z = 0
				arg_135_1.actors_["10083ui_story"].transform.localEulerAngles.x = 0
				arg_135_1.actors_["10083ui_story"].transform.localEulerAngles = arg_135_1.actors_["10083ui_story"].transform.localEulerAngles
			end

			local var_138_1 = arg_135_1.actors_["10083ui_story"]

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 and not isNil(var_138_1) and arg_135_1.var_.characterEffect10083ui_story == nil then
				arg_135_1.var_.characterEffect10083ui_story = var_138_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_138_2 = 0.200000002980232

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_2 and not isNil(var_138_1) then
				if arg_135_1.var_.characterEffect10083ui_story and not isNil(var_138_1) then
					arg_135_1.var_.characterEffect10083ui_story.fillFlat = false
				end
			end

			if arg_135_1.time_ >= 0 + var_138_2 and arg_135_1.time_ < 0 + var_138_2 + arg_138_0 and not isNil(var_138_1) and arg_135_1.var_.characterEffect10083ui_story then
				arg_135_1.var_.characterEffect10083ui_story.fillFlat = false
			end

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1:PlayTimeline("10083ui_story", "StoryTimeline/CharAction/story10083/story10083action/10083action3_1")
			end

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1:PlayTimeline("10083ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_138_4 = arg_135_1.actors_["3043ui_story"].transform

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1.var_.moveOldPos3043ui_story = var_138_4.localPosition
			end

			local var_138_5 = 0.001

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_5 then
				var_138_4.localPosition = Vector3.Lerp(arg_135_1.var_.moveOldPos3043ui_story, Vector3.New(0, 100, 0), (arg_135_1.time_ - 0) / var_138_5)
				var_138_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_138_4.position).x, (manager.ui.mainCamera.transform.position - var_138_4.position).y, (manager.ui.mainCamera.transform.position - var_138_4.position).z)
				var_138_4.localEulerAngles.z = 0
				var_138_4.localEulerAngles.x = 0
				var_138_4.localEulerAngles = var_138_4.localEulerAngles
			end

			if arg_135_1.time_ >= 0 + var_138_5 and arg_135_1.time_ < 0 + var_138_5 + arg_138_0 then
				var_138_4.localPosition = Vector3.New(0, 100, 0)
				var_138_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_138_4.position).x, (manager.ui.mainCamera.transform.position - var_138_4.position).y, (manager.ui.mainCamera.transform.position - var_138_4.position).z)
				var_138_4.localEulerAngles.z = 0
				var_138_4.localEulerAngles.x = 0
				var_138_4.localEulerAngles = var_138_4.localEulerAngles
			end

			local var_138_6 = arg_135_1.actors_["3043ui_story"]

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 and not isNil(var_138_6) and arg_135_1.var_.characterEffect3043ui_story == nil then
				arg_135_1.var_.characterEffect3043ui_story = var_138_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_138_7 = 0.200000002980232

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_7 and not isNil(var_138_6) then
				if arg_135_1.var_.characterEffect3043ui_story and not isNil(var_138_6) then
					arg_135_1.var_.characterEffect3043ui_story.fillFlat = true
					arg_135_1.var_.characterEffect3043ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_135_1.time_ - 0) / var_138_7)
				end
			end

			if arg_135_1.time_ >= 0 + var_138_7 and arg_135_1.time_ < 0 + var_138_7 + arg_138_0 and not isNil(var_138_6) and arg_135_1.var_.characterEffect3043ui_story then
				arg_135_1.var_.characterEffect3043ui_story.fillFlat = true
				arg_135_1.var_.characterEffect3043ui_story.fillRatio = 0.5
			end

			local var_138_8 = 0
			local var_138_9 = 0.925

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_8 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				arg_135_1.leftNameTxt_.text = arg_135_1:FormatText(StoryNameCfg[918].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_10 = arg_135_1:GetWordFromCfg(412031033)
				local var_138_11 = arg_135_1:FormatText(var_138_10.content)

				arg_135_1.text_.text = var_138_11

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_13 = 37 <= 0 and var_138_9 or var_138_9 * (utf8.len(var_138_11) / 37)

				if (37 <= 0 and var_138_9 or var_138_9 * (utf8.len(var_138_11) / 37)) > 0 and var_138_9 < var_138_13 then
					arg_135_1.talkMaxDuration = var_138_13

					if var_138_13 + var_138_8 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_13 + var_138_8
					end
				end

				arg_135_1.text_.text = var_138_11
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031033", "story_v_out_412031.awb") ~= 0 then
					local var_138_14 = manager.audio:GetVoiceLength("story_v_out_412031", "412031033", "story_v_out_412031.awb") / 1000

					if var_138_14 + var_138_8 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_14 + var_138_8
					end

					if var_138_10.prefab_name ~= "" and arg_135_1.actors_[var_138_10.prefab_name] ~= nil then
						local var_138_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_10.prefab_name].transform, "story_v_out_412031", "412031033", "story_v_out_412031.awb")

						arg_135_1:RecordAudio("412031033", var_138_15)
						arg_135_1:RecordAudio("412031033", var_138_15)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_412031", "412031033", "story_v_out_412031.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_412031", "412031033", "story_v_out_412031.awb")
				end

				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_16 = math.max(var_138_9, arg_135_1.talkMaxDuration)

			if var_138_8 <= arg_135_1.time_ and arg_135_1.time_ < var_138_8 + var_138_16 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_8) / var_138_16

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_8 + var_138_16 and arg_135_1.time_ < var_138_8 + var_138_16 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10083ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "3043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_135_1:InitPlayNodeList()
	end,
	Play412031034 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 412031034
		arg_139_1.duration_ = 8.87

		local var_139_0 = {
			zh = 8.866,
			ja = 5.4
		}
		local var_139_1 = manager.audio:GetLocalizationFlag()

		if var_139_0[var_139_1] ~= nil then
			arg_139_1.duration_ = var_139_0[var_139_1]
		end

		SetActive(arg_139_1.tipsGo_, false)

		function arg_139_1.onSingleLineFinish_()
			arg_139_1.onSingleLineUpdate_ = nil
			arg_139_1.onSingleLineFinish_ = nil
			arg_139_1.state_ = "waiting"
		end

		function arg_139_1.playNext_(arg_141_0)
			if arg_141_0 == 1 then
				arg_139_0:Play412031035(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			local var_142_0 = 0.95

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				arg_139_1.leftNameTxt_.text = arg_139_1:FormatText(StoryNameCfg[918].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_1 = arg_139_1:GetWordFromCfg(412031034)
				local var_142_2 = arg_139_1:FormatText(var_142_1.content)

				arg_139_1.text_.text = var_142_2

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_4 = 38 <= 0 and var_142_0 or var_142_0 * (utf8.len(var_142_2) / 38)

				if (38 <= 0 and var_142_0 or var_142_0 * (utf8.len(var_142_2) / 38)) > 0 and var_142_0 < var_142_4 then
					arg_139_1.talkMaxDuration = var_142_4

					if var_142_4 + 0 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_4 + 0
					end
				end

				arg_139_1.text_.text = var_142_2
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031034", "story_v_out_412031.awb") ~= 0 then
					local var_142_5 = manager.audio:GetVoiceLength("story_v_out_412031", "412031034", "story_v_out_412031.awb") / 1000

					if var_142_5 + 0 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_5 + 0
					end

					if var_142_1.prefab_name ~= "" and arg_139_1.actors_[var_142_1.prefab_name] ~= nil then
						local var_142_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_1.prefab_name].transform, "story_v_out_412031", "412031034", "story_v_out_412031.awb")

						arg_139_1:RecordAudio("412031034", var_142_6)
						arg_139_1:RecordAudio("412031034", var_142_6)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_out_412031", "412031034", "story_v_out_412031.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_out_412031", "412031034", "story_v_out_412031.awb")
				end

				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_7 = math.max(var_142_0, arg_139_1.talkMaxDuration)

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_7 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - 0) / var_142_7

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= 0 + var_142_7 and arg_139_1.time_ < 0 + var_142_7 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {}

		arg_139_1:InitPlayNodeList()
	end,
	Play412031035 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 412031035
		arg_143_1.duration_ = 5.4

		local var_143_0 = {
			zh = 1.999999999999,
			ja = 5.4
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
				arg_143_0:Play412031036(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1.var_.moveOldPos3043ui_story = arg_143_1.actors_["3043ui_story"].transform.localPosition
			end

			local var_146_0 = 0.001

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_0 then
				arg_143_1.actors_["3043ui_story"].transform.localPosition = Vector3.Lerp(arg_143_1.var_.moveOldPos3043ui_story, Vector3.New(0, -1.41, -5.7), (arg_143_1.time_ - 0) / var_146_0)
				arg_143_1.actors_["3043ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_143_1.actors_["3043ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_143_1.actors_["3043ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_143_1.actors_["3043ui_story"].transform.position).z)
				arg_143_1.actors_["3043ui_story"].transform.localEulerAngles.z = 0
				arg_143_1.actors_["3043ui_story"].transform.localEulerAngles.x = 0
				arg_143_1.actors_["3043ui_story"].transform.localEulerAngles = arg_143_1.actors_["3043ui_story"].transform.localEulerAngles
			end

			if arg_143_1.time_ >= 0 + var_146_0 and arg_143_1.time_ < 0 + var_146_0 + arg_146_0 then
				arg_143_1.actors_["3043ui_story"].transform.localPosition = Vector3.New(0, -1.41, -5.7)
				arg_143_1.actors_["3043ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_143_1.actors_["3043ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_143_1.actors_["3043ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_143_1.actors_["3043ui_story"].transform.position).z)
				arg_143_1.actors_["3043ui_story"].transform.localEulerAngles.z = 0
				arg_143_1.actors_["3043ui_story"].transform.localEulerAngles.x = 0
				arg_143_1.actors_["3043ui_story"].transform.localEulerAngles = arg_143_1.actors_["3043ui_story"].transform.localEulerAngles
			end

			local var_146_1 = arg_143_1.actors_["3043ui_story"]

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 and not isNil(var_146_1) and arg_143_1.var_.characterEffect3043ui_story == nil then
				arg_143_1.var_.characterEffect3043ui_story = var_146_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_146_2 = 0.200000002980232

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_2 and not isNil(var_146_1) then
				if arg_143_1.var_.characterEffect3043ui_story and not isNil(var_146_1) then
					arg_143_1.var_.characterEffect3043ui_story.fillFlat = false
				end
			end

			if arg_143_1.time_ >= 0 + var_146_2 and arg_143_1.time_ < 0 + var_146_2 + arg_146_0 and not isNil(var_146_1) and arg_143_1.var_.characterEffect3043ui_story then
				arg_143_1.var_.characterEffect3043ui_story.fillFlat = false
			end

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1:PlayTimeline("3043ui_story", "StoryTimeline/CharAction/story3043/story3043action/3043action1_1")
			end

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1:PlayTimeline("3043ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_146_4 = arg_143_1.actors_["10083ui_story"].transform

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1.var_.moveOldPos10083ui_story = var_146_4.localPosition
			end

			local var_146_5 = 0.001

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_5 then
				var_146_4.localPosition = Vector3.Lerp(arg_143_1.var_.moveOldPos10083ui_story, Vector3.New(0, 100, 0), (arg_143_1.time_ - 0) / var_146_5)
				var_146_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_146_4.position).x, (manager.ui.mainCamera.transform.position - var_146_4.position).y, (manager.ui.mainCamera.transform.position - var_146_4.position).z)
				var_146_4.localEulerAngles.z = 0
				var_146_4.localEulerAngles.x = 0
				var_146_4.localEulerAngles = var_146_4.localEulerAngles
			end

			if arg_143_1.time_ >= 0 + var_146_5 and arg_143_1.time_ < 0 + var_146_5 + arg_146_0 then
				var_146_4.localPosition = Vector3.New(0, 100, 0)
				var_146_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_146_4.position).x, (manager.ui.mainCamera.transform.position - var_146_4.position).y, (manager.ui.mainCamera.transform.position - var_146_4.position).z)
				var_146_4.localEulerAngles.z = 0
				var_146_4.localEulerAngles.x = 0
				var_146_4.localEulerAngles = var_146_4.localEulerAngles
			end

			local var_146_6 = arg_143_1.actors_["10083ui_story"]

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 and not isNil(var_146_6) and arg_143_1.var_.characterEffect10083ui_story == nil then
				arg_143_1.var_.characterEffect10083ui_story = var_146_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_146_7 = 0.200000002980232

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_7 and not isNil(var_146_6) then
				if arg_143_1.var_.characterEffect10083ui_story and not isNil(var_146_6) then
					arg_143_1.var_.characterEffect10083ui_story.fillFlat = true
					arg_143_1.var_.characterEffect10083ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_143_1.time_ - 0) / var_146_7)
				end
			end

			if arg_143_1.time_ >= 0 + var_146_7 and arg_143_1.time_ < 0 + var_146_7 + arg_146_0 and not isNil(var_146_6) and arg_143_1.var_.characterEffect10083ui_story then
				arg_143_1.var_.characterEffect10083ui_story.fillFlat = true
				arg_143_1.var_.characterEffect10083ui_story.fillRatio = 0.5
			end

			local var_146_8 = 0
			local var_146_9 = 0.25

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= var_146_8 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				arg_143_1.leftNameTxt_.text = arg_143_1:FormatText(StoryNameCfg[920].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_10 = arg_143_1:GetWordFromCfg(412031035)
				local var_146_11 = arg_143_1:FormatText(var_146_10.content)

				arg_143_1.text_.text = var_146_11

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_13 = 10 <= 0 and var_146_9 or var_146_9 * (utf8.len(var_146_11) / 10)

				if (10 <= 0 and var_146_9 or var_146_9 * (utf8.len(var_146_11) / 10)) > 0 and var_146_9 < var_146_13 then
					arg_143_1.talkMaxDuration = var_146_13

					if var_146_13 + var_146_8 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_13 + var_146_8
					end
				end

				arg_143_1.text_.text = var_146_11
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031035", "story_v_out_412031.awb") ~= 0 then
					local var_146_14 = manager.audio:GetVoiceLength("story_v_out_412031", "412031035", "story_v_out_412031.awb") / 1000

					if var_146_14 + var_146_8 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_14 + var_146_8
					end

					if var_146_10.prefab_name ~= "" and arg_143_1.actors_[var_146_10.prefab_name] ~= nil then
						local var_146_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_10.prefab_name].transform, "story_v_out_412031", "412031035", "story_v_out_412031.awb")

						arg_143_1:RecordAudio("412031035", var_146_15)
						arg_143_1:RecordAudio("412031035", var_146_15)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_out_412031", "412031035", "story_v_out_412031.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_out_412031", "412031035", "story_v_out_412031.awb")
				end

				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_16 = math.max(var_146_9, arg_143_1.talkMaxDuration)

			if var_146_8 <= arg_143_1.time_ and arg_143_1.time_ < var_146_8 + var_146_16 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_8) / var_146_16

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_8 + var_146_16 and arg_143_1.time_ < var_146_8 + var_146_16 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10083ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_143_1:InitPlayNodeList()
	end,
	Play412031036 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 412031036
		arg_147_1.duration_ = 7

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play412031037(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			if arg_147_1.bgs_.EN0101 == nil then
				local var_150_0 = Object.Instantiate(arg_147_1.paintGo_)

				var_150_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "EN0101")
				var_150_0.name = "EN0101"
				var_150_0.transform.parent = arg_147_1.stage_.transform
				var_150_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_147_1.bgs_.EN0101 = var_150_0
			end

			if 0.5 < arg_147_1.time_ and arg_147_1.time_ <= 0.5 + arg_150_0 then
				local var_150_1 = arg_147_1.bgs_.EN0101

				arg_147_1.bgs_.EN0101.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_150_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_150_2 = var_150_1:GetComponent("SpriteRenderer")

				if var_150_2 and var_150_2.sprite then
					local var_150_3 = 2 * (var_150_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_150_1.transform.localScale = Vector3.New(var_150_3 / var_150_2.sprite.bounds.size.y < var_150_3 * manager.ui.mainCameraCom_.aspect / var_150_2.sprite.bounds.size.x and var_150_3 * manager.ui.mainCameraCom_.aspect / var_150_2.sprite.bounds.size.x or var_150_3 / var_150_2.sprite.bounds.size.y, var_150_3 / var_150_2.sprite.bounds.size.y < var_150_3 * manager.ui.mainCameraCom_.aspect / var_150_2.sprite.bounds.size.x and var_150_3 * manager.ui.mainCameraCom_.aspect / var_150_2.sprite.bounds.size.x or var_150_3 / var_150_2.sprite.bounds.size.y, 0)
				end

				for iter_150_0, iter_150_1 in pairs(arg_147_1.bgs_) do
					if iter_150_0 ~= "EN0101" then
						iter_150_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_150_4 = 2

			if 2 < arg_147_1.time_ and arg_147_1.time_ <= var_150_4 + arg_150_0 then
				arg_147_1.allBtn_.enabled = false
			end

			if arg_147_1.time_ >= var_150_4 + 0.3 and arg_147_1.time_ < var_150_4 + 0.3 + arg_150_0 then
				arg_147_1.allBtn_.enabled = true
			end

			local var_150_5 = 0

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_5 + arg_150_0 then
				arg_147_1.mask_.enabled = true
				arg_147_1.mask_.raycastTarget = true

				arg_147_1:SetGaussion(false)
			end

			local var_150_6 = 0.5

			if var_150_5 <= arg_147_1.time_ and arg_147_1.time_ < var_150_5 + var_150_6 then
				local var_150_7 = Color.New(0, 0, 0)

				var_150_7.a = Mathf.Lerp(0, 1, (arg_147_1.time_ - var_150_5) / var_150_6)
				arg_147_1.mask_.color = var_150_7
			end

			if arg_147_1.time_ >= var_150_5 + var_150_6 and arg_147_1.time_ < var_150_5 + var_150_6 + arg_150_0 then
				local var_150_8 = Color.New(0, 0, 0)

				var_150_8.a = 1
				arg_147_1.mask_.color = var_150_8
			end

			local var_150_9 = 0.5

			if 0.5 < arg_147_1.time_ and arg_147_1.time_ <= var_150_9 + arg_150_0 then
				arg_147_1.mask_.enabled = true
				arg_147_1.mask_.raycastTarget = true

				arg_147_1:SetGaussion(false)
			end

			local var_150_10 = 1.5

			if var_150_9 <= arg_147_1.time_ and arg_147_1.time_ < var_150_9 + var_150_10 then
				local var_150_11 = Color.New(0, 0, 0)

				var_150_11.a = Mathf.Lerp(1, 0, (arg_147_1.time_ - var_150_9) / var_150_10)
				arg_147_1.mask_.color = var_150_11
			end

			if arg_147_1.time_ >= var_150_9 + var_150_10 and arg_147_1.time_ < var_150_9 + var_150_10 + arg_150_0 then
				local var_150_12 = Color.New(0, 0, 0)

				arg_147_1.mask_.enabled = false
				var_150_12.a = 0
				arg_147_1.mask_.color = var_150_12
			end

			local var_150_13 = arg_147_1.actors_["3043ui_story"].transform

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1.var_.moveOldPos3043ui_story = var_150_13.localPosition
			end

			local var_150_14 = 0.001

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_14 then
				var_150_13.localPosition = Vector3.Lerp(arg_147_1.var_.moveOldPos3043ui_story, Vector3.New(0, 100, 0), (arg_147_1.time_ - 0) / var_150_14)
				var_150_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_150_13.position).x, (manager.ui.mainCamera.transform.position - var_150_13.position).y, (manager.ui.mainCamera.transform.position - var_150_13.position).z)
				var_150_13.localEulerAngles.z = 0
				var_150_13.localEulerAngles.x = 0
				var_150_13.localEulerAngles = var_150_13.localEulerAngles
			end

			if arg_147_1.time_ >= 0 + var_150_14 and arg_147_1.time_ < 0 + var_150_14 + arg_150_0 then
				var_150_13.localPosition = Vector3.New(0, 100, 0)
				var_150_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_150_13.position).x, (manager.ui.mainCamera.transform.position - var_150_13.position).y, (manager.ui.mainCamera.transform.position - var_150_13.position).z)
				var_150_13.localEulerAngles.z = 0
				var_150_13.localEulerAngles.x = 0
				var_150_13.localEulerAngles = var_150_13.localEulerAngles
			end

			local var_150_15 = arg_147_1.actors_["3043ui_story"]

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 and not isNil(var_150_15) and arg_147_1.var_.characterEffect3043ui_story == nil then
				arg_147_1.var_.characterEffect3043ui_story = var_150_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_150_16 = 0.034000001847744

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_16 and not isNil(var_150_15) then
				if arg_147_1.var_.characterEffect3043ui_story and not isNil(var_150_15) then
					arg_147_1.var_.characterEffect3043ui_story.fillFlat = true
					arg_147_1.var_.characterEffect3043ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_147_1.time_ - 0) / var_150_16)
				end
			end

			if arg_147_1.time_ >= 0 + var_150_16 and arg_147_1.time_ < 0 + var_150_16 + arg_150_0 and not isNil(var_150_15) and arg_147_1.var_.characterEffect3043ui_story then
				arg_147_1.var_.characterEffect3043ui_story.fillFlat = true
				arg_147_1.var_.characterEffect3043ui_story.fillRatio = 0.5
			end

			local var_150_17 = arg_147_1.bgs_.EN0101.transform

			if 0.5 < arg_147_1.time_ and arg_147_1.time_ <= 0.5 + arg_150_0 then
				arg_147_1.var_.moveOldPosEN0101 = var_150_17.localPosition
			end

			local var_150_18 = 0.001

			if 0.5 <= arg_147_1.time_ and arg_147_1.time_ < 0.5 + var_150_18 then
				var_150_17.localPosition = Vector3.Lerp(arg_147_1.var_.moveOldPosEN0101, Vector3.New(0, 1, 9), (arg_147_1.time_ - 0.5) / var_150_18)
			end

			if arg_147_1.time_ >= 0.5 + var_150_18 and arg_147_1.time_ < 0.5 + var_150_18 + arg_150_0 then
				var_150_17.localPosition = Vector3.New(0, 1, 9)
			end

			local var_150_19 = arg_147_1.bgs_.EN0101.transform

			if 0.534000001847744 < arg_147_1.time_ and arg_147_1.time_ <= 0.534000001847744 + arg_150_0 then
				arg_147_1.var_.moveOldPosEN0101 = var_150_19.localPosition
			end

			local var_150_20 = 4.5

			if 0.534000001847744 <= arg_147_1.time_ and arg_147_1.time_ < 0.534000001847744 + var_150_20 then
				var_150_19.localPosition = Vector3.Lerp(arg_147_1.var_.moveOldPosEN0101, Vector3.New(0, 1, 10), (arg_147_1.time_ - 0.534000001847744) / var_150_20)
			end

			if arg_147_1.time_ >= 0.534000001847744 + var_150_20 and arg_147_1.time_ < 0.534000001847744 + var_150_20 + arg_150_0 then
				var_150_19.localPosition = Vector3.New(0, 1, 10)
			end

			local var_150_21 = 2

			if 2 < arg_147_1.time_ and arg_147_1.time_ <= var_150_21 + arg_150_0 then
				arg_147_1.allBtn_.enabled = false
			end

			if arg_147_1.time_ >= var_150_21 + 2.53400000184774 and arg_147_1.time_ < var_150_21 + 2.53400000184774 + arg_150_0 then
				arg_147_1.allBtn_.enabled = true
			end

			if arg_147_1.frameCnt_ <= 1 then
				arg_147_1.dialog_:SetActive(false)
			end

			local var_150_22 = 2
			local var_150_23 = 0.95

			if 2 < arg_147_1.time_ and arg_147_1.time_ <= var_150_22 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0

				arg_147_1.dialog_:SetActive(true)

				arg_147_1.dialogCg_.alpha = 0

				local var_150_24 = LeanTween.value(arg_147_1.dialog_, 0, 1, 0.3)

				var_150_24:setOnUpdate(LuaHelper.FloatAction(function(arg_151_0)
					arg_147_1.dialogCg_.alpha = arg_151_0
				end))
				var_150_24:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_147_1.dialog_)
					var_150_24:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_147_1.duration_ = arg_147_1.duration_ + 0.3

				SetActive(arg_147_1.leftNameGo_, false)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_25 = arg_147_1:FormatText(arg_147_1:GetWordFromCfg(412031036).content)

				arg_147_1.text_.text = var_150_25

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_27 = 38 <= 0 and var_150_23 or var_150_23 * (utf8.len(var_150_25) / 38)

				if (38 <= 0 and var_150_23 or var_150_23 * (utf8.len(var_150_25) / 38)) > 0 and var_150_23 < var_150_27 then
					arg_147_1.talkMaxDuration = var_150_27
					var_150_22 = var_150_22 + 0.3

					if var_150_27 + var_150_22 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_27 + var_150_22
					end
				end

				arg_147_1.text_.text = var_150_25
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)
				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_28 = var_150_22 + 0.3
			local var_150_29 = math.max(var_150_23, arg_147_1.talkMaxDuration)

			if var_150_22 + 0.3 <= arg_147_1.time_ and arg_147_1.time_ < var_150_28 + var_150_29 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_28) / var_150_29

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_28 + var_150_29 and arg_147_1.time_ < var_150_28 + var_150_29 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "EN0101",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0.5,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "EN0101",
				changeDisplayLayer = false,
				needEase = false,
				duration = 4.5,
				className = "StoryMoveNode",
				startTime = 0.534000001847744,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_147_1:InitPlayNodeList()
	end,
	Play412031037 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 412031037
		arg_153_1.duration_ = 4.63

		local var_153_0 = {
			zh = 3.5,
			ja = 4.633
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
				arg_153_0:Play412031038(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = 0.4

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				arg_153_1.leftNameTxt_.text = arg_153_1:FormatText(StoryNameCfg[920].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_1 = arg_153_1:GetWordFromCfg(412031037)
				local var_156_2 = arg_153_1:FormatText(var_156_1.content)

				arg_153_1.text_.text = var_156_2

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_4 = 16 <= 0 and var_156_0 or var_156_0 * (utf8.len(var_156_2) / 16)

				if (16 <= 0 and var_156_0 or var_156_0 * (utf8.len(var_156_2) / 16)) > 0 and var_156_0 < var_156_4 then
					arg_153_1.talkMaxDuration = var_156_4

					if var_156_4 + 0 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_4 + 0
					end
				end

				arg_153_1.text_.text = var_156_2
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031037", "story_v_out_412031.awb") ~= 0 then
					local var_156_5 = manager.audio:GetVoiceLength("story_v_out_412031", "412031037", "story_v_out_412031.awb") / 1000

					if var_156_5 + 0 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_5 + 0
					end

					if var_156_1.prefab_name ~= "" and arg_153_1.actors_[var_156_1.prefab_name] ~= nil then
						local var_156_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_1.prefab_name].transform, "story_v_out_412031", "412031037", "story_v_out_412031.awb")

						arg_153_1:RecordAudio("412031037", var_156_6)
						arg_153_1:RecordAudio("412031037", var_156_6)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_412031", "412031037", "story_v_out_412031.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_412031", "412031037", "story_v_out_412031.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_7 = math.max(var_156_0, arg_153_1.talkMaxDuration)

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_7 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - 0) / var_156_7

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= 0 + var_156_7 and arg_153_1.time_ < 0 + var_156_7 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play412031038 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 412031038
		arg_157_1.duration_ = 7.07

		local var_157_0 = {
			zh = 5.6,
			ja = 7.066
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
				arg_157_0:Play412031039(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = 0.425

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				arg_157_1.leftNameTxt_.text = arg_157_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, true)
				arg_157_1.iconController_:SetSelectedState("hero")

				arg_157_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1097")

				arg_157_1.callingController_:SetSelectedState("normal")

				arg_157_1.keyicon_.color = Color.New(1, 1, 1)
				arg_157_1.icon_.color = Color.New(1, 1, 1)

				local var_160_1 = arg_157_1:GetWordFromCfg(412031038)
				local var_160_2 = arg_157_1:FormatText(var_160_1.content)

				arg_157_1.text_.text = var_160_2

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_4 = 17 <= 0 and var_160_0 or var_160_0 * (utf8.len(var_160_2) / 17)

				if (17 <= 0 and var_160_0 or var_160_0 * (utf8.len(var_160_2) / 17)) > 0 and var_160_0 < var_160_4 then
					arg_157_1.talkMaxDuration = var_160_4

					if var_160_4 + 0 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_4 + 0
					end
				end

				arg_157_1.text_.text = var_160_2
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031038", "story_v_out_412031.awb") ~= 0 then
					local var_160_5 = manager.audio:GetVoiceLength("story_v_out_412031", "412031038", "story_v_out_412031.awb") / 1000

					if var_160_5 + 0 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_5 + 0
					end

					if var_160_1.prefab_name ~= "" and arg_157_1.actors_[var_160_1.prefab_name] ~= nil then
						local var_160_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_1.prefab_name].transform, "story_v_out_412031", "412031038", "story_v_out_412031.awb")

						arg_157_1:RecordAudio("412031038", var_160_6)
						arg_157_1:RecordAudio("412031038", var_160_6)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_out_412031", "412031038", "story_v_out_412031.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_out_412031", "412031038", "story_v_out_412031.awb")
				end

				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_7 = math.max(var_160_0, arg_157_1.talkMaxDuration)

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_7 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - 0) / var_160_7

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= 0 + var_160_7 and arg_157_1.time_ < 0 + var_160_7 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play412031039 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 412031039
		arg_161_1.duration_ = 1.9

		local var_161_0 = {
			zh = 1.2,
			ja = 1.9
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
				arg_161_0:Play412031040(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = 0.1

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				arg_161_1.leftNameTxt_.text = arg_161_1:FormatText(StoryNameCfg[920].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_1 = arg_161_1:GetWordFromCfg(412031039)
				local var_164_2 = arg_161_1:FormatText(var_164_1.content)

				arg_161_1.text_.text = var_164_2

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_4 = 4 <= 0 and var_164_0 or var_164_0 * (utf8.len(var_164_2) / 4)

				if (4 <= 0 and var_164_0 or var_164_0 * (utf8.len(var_164_2) / 4)) > 0 and var_164_0 < var_164_4 then
					arg_161_1.talkMaxDuration = var_164_4

					if var_164_4 + 0 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_4 + 0
					end
				end

				arg_161_1.text_.text = var_164_2
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031039", "story_v_out_412031.awb") ~= 0 then
					local var_164_5 = manager.audio:GetVoiceLength("story_v_out_412031", "412031039", "story_v_out_412031.awb") / 1000

					if var_164_5 + 0 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_5 + 0
					end

					if var_164_1.prefab_name ~= "" and arg_161_1.actors_[var_164_1.prefab_name] ~= nil then
						local var_164_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_1.prefab_name].transform, "story_v_out_412031", "412031039", "story_v_out_412031.awb")

						arg_161_1:RecordAudio("412031039", var_164_6)
						arg_161_1:RecordAudio("412031039", var_164_6)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_out_412031", "412031039", "story_v_out_412031.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_out_412031", "412031039", "story_v_out_412031.awb")
				end

				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_7 = math.max(var_164_0, arg_161_1.talkMaxDuration)

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_7 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - 0) / var_164_7

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= 0 + var_164_7 and arg_161_1.time_ < 0 + var_164_7 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	Play412031040 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 412031040
		arg_165_1.duration_ = 8.97

		local var_165_0 = {
			zh = 7.333,
			ja = 8.966
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
				arg_165_0:Play412031041(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = 0.55

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				arg_165_1.leftNameTxt_.text = arg_165_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, true)
				arg_165_1.iconController_:SetSelectedState("hero")

				arg_165_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1097")

				arg_165_1.callingController_:SetSelectedState("normal")

				arg_165_1.keyicon_.color = Color.New(1, 1, 1)
				arg_165_1.icon_.color = Color.New(1, 1, 1)

				local var_168_1 = arg_165_1:GetWordFromCfg(412031040)
				local var_168_2 = arg_165_1:FormatText(var_168_1.content)

				arg_165_1.text_.text = var_168_2

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_4 = 22 <= 0 and var_168_0 or var_168_0 * (utf8.len(var_168_2) / 22)

				if (22 <= 0 and var_168_0 or var_168_0 * (utf8.len(var_168_2) / 22)) > 0 and var_168_0 < var_168_4 then
					arg_165_1.talkMaxDuration = var_168_4

					if var_168_4 + 0 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_4 + 0
					end
				end

				arg_165_1.text_.text = var_168_2
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031040", "story_v_out_412031.awb") ~= 0 then
					local var_168_5 = manager.audio:GetVoiceLength("story_v_out_412031", "412031040", "story_v_out_412031.awb") / 1000

					if var_168_5 + 0 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_5 + 0
					end

					if var_168_1.prefab_name ~= "" and arg_165_1.actors_[var_168_1.prefab_name] ~= nil then
						local var_168_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_1.prefab_name].transform, "story_v_out_412031", "412031040", "story_v_out_412031.awb")

						arg_165_1:RecordAudio("412031040", var_168_6)
						arg_165_1:RecordAudio("412031040", var_168_6)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_out_412031", "412031040", "story_v_out_412031.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_out_412031", "412031040", "story_v_out_412031.awb")
				end

				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_7 = math.max(var_168_0, arg_165_1.talkMaxDuration)

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_7 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - 0) / var_168_7

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= 0 + var_168_7 and arg_165_1.time_ < 0 + var_168_7 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {}

		arg_165_1:InitPlayNodeList()
	end,
	Play412031041 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 412031041
		arg_169_1.duration_ = 6.23

		local var_169_0 = {
			zh = 3.466,
			ja = 6.233
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
				arg_169_0:Play412031042(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = 0.35

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				arg_169_1.leftNameTxt_.text = arg_169_1:FormatText(StoryNameCfg[920].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_1 = arg_169_1:GetWordFromCfg(412031041)
				local var_172_2 = arg_169_1:FormatText(var_172_1.content)

				arg_169_1.text_.text = var_172_2

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_4 = 14 <= 0 and var_172_0 or var_172_0 * (utf8.len(var_172_2) / 14)

				if (14 <= 0 and var_172_0 or var_172_0 * (utf8.len(var_172_2) / 14)) > 0 and var_172_0 < var_172_4 then
					arg_169_1.talkMaxDuration = var_172_4

					if var_172_4 + 0 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_4 + 0
					end
				end

				arg_169_1.text_.text = var_172_2
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031041", "story_v_out_412031.awb") ~= 0 then
					local var_172_5 = manager.audio:GetVoiceLength("story_v_out_412031", "412031041", "story_v_out_412031.awb") / 1000

					if var_172_5 + 0 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_5 + 0
					end

					if var_172_1.prefab_name ~= "" and arg_169_1.actors_[var_172_1.prefab_name] ~= nil then
						local var_172_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_1.prefab_name].transform, "story_v_out_412031", "412031041", "story_v_out_412031.awb")

						arg_169_1:RecordAudio("412031041", var_172_6)
						arg_169_1:RecordAudio("412031041", var_172_6)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_out_412031", "412031041", "story_v_out_412031.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_out_412031", "412031041", "story_v_out_412031.awb")
				end

				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_7 = math.max(var_172_0, arg_169_1.talkMaxDuration)

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_7 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - 0) / var_172_7

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= 0 + var_172_7 and arg_169_1.time_ < 0 + var_172_7 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {}

		arg_169_1:InitPlayNodeList()
	end,
	Play412031042 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 412031042
		arg_173_1.duration_ = 4.93

		local var_173_0 = {
			zh = 3,
			ja = 4.933
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
				arg_173_0:Play412031043(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			local var_176_0 = 0.2

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				arg_173_1.leftNameTxt_.text = arg_173_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, true)
				arg_173_1.iconController_:SetSelectedState("hero")

				arg_173_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1097")

				arg_173_1.callingController_:SetSelectedState("normal")

				arg_173_1.keyicon_.color = Color.New(1, 1, 1)
				arg_173_1.icon_.color = Color.New(1, 1, 1)

				local var_176_1 = arg_173_1:GetWordFromCfg(412031042)
				local var_176_2 = arg_173_1:FormatText(var_176_1.content)

				arg_173_1.text_.text = var_176_2

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_4 = 8 <= 0 and var_176_0 or var_176_0 * (utf8.len(var_176_2) / 8)

				if (8 <= 0 and var_176_0 or var_176_0 * (utf8.len(var_176_2) / 8)) > 0 and var_176_0 < var_176_4 then
					arg_173_1.talkMaxDuration = var_176_4

					if var_176_4 + 0 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_4 + 0
					end
				end

				arg_173_1.text_.text = var_176_2
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031042", "story_v_out_412031.awb") ~= 0 then
					local var_176_5 = manager.audio:GetVoiceLength("story_v_out_412031", "412031042", "story_v_out_412031.awb") / 1000

					if var_176_5 + 0 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_5 + 0
					end

					if var_176_1.prefab_name ~= "" and arg_173_1.actors_[var_176_1.prefab_name] ~= nil then
						local var_176_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_1.prefab_name].transform, "story_v_out_412031", "412031042", "story_v_out_412031.awb")

						arg_173_1:RecordAudio("412031042", var_176_6)
						arg_173_1:RecordAudio("412031042", var_176_6)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_out_412031", "412031042", "story_v_out_412031.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_out_412031", "412031042", "story_v_out_412031.awb")
				end

				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_7 = math.max(var_176_0, arg_173_1.talkMaxDuration)

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_7 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - 0) / var_176_7

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= 0 + var_176_7 and arg_173_1.time_ < 0 + var_176_7 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {}

		arg_173_1:InitPlayNodeList()
	end,
	Play412031043 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 412031043
		arg_177_1.duration_ = 4.87

		local var_177_0 = {
			zh = 3.3,
			ja = 4.866
		}
		local var_177_1 = manager.audio:GetLocalizationFlag()

		if var_177_0[var_177_1] ~= nil then
			arg_177_1.duration_ = var_177_0[var_177_1]
		end

		SetActive(arg_177_1.tipsGo_, false)

		function arg_177_1.onSingleLineFinish_()
			arg_177_1.onSingleLineUpdate_ = nil
			arg_177_1.onSingleLineFinish_ = nil
			arg_177_1.state_ = "waiting"
		end

		function arg_177_1.playNext_(arg_179_0)
			if arg_179_0 == 1 then
				arg_177_0:Play412031044(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = 0.35

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				arg_177_1.leftNameTxt_.text = arg_177_1:FormatText(StoryNameCfg[920].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_1 = arg_177_1:GetWordFromCfg(412031043)
				local var_180_2 = arg_177_1:FormatText(var_180_1.content)

				arg_177_1.text_.text = var_180_2

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_4 = 14 <= 0 and var_180_0 or var_180_0 * (utf8.len(var_180_2) / 14)

				if (14 <= 0 and var_180_0 or var_180_0 * (utf8.len(var_180_2) / 14)) > 0 and var_180_0 < var_180_4 then
					arg_177_1.talkMaxDuration = var_180_4

					if var_180_4 + 0 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_4 + 0
					end
				end

				arg_177_1.text_.text = var_180_2
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031043", "story_v_out_412031.awb") ~= 0 then
					local var_180_5 = manager.audio:GetVoiceLength("story_v_out_412031", "412031043", "story_v_out_412031.awb") / 1000

					if var_180_5 + 0 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_5 + 0
					end

					if var_180_1.prefab_name ~= "" and arg_177_1.actors_[var_180_1.prefab_name] ~= nil then
						local var_180_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_1.prefab_name].transform, "story_v_out_412031", "412031043", "story_v_out_412031.awb")

						arg_177_1:RecordAudio("412031043", var_180_6)
						arg_177_1:RecordAudio("412031043", var_180_6)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_412031", "412031043", "story_v_out_412031.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_412031", "412031043", "story_v_out_412031.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_7 = math.max(var_180_0, arg_177_1.talkMaxDuration)

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_7 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - 0) / var_180_7

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= 0 + var_180_7 and arg_177_1.time_ < 0 + var_180_7 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {}

		arg_177_1:InitPlayNodeList()
	end,
	Play412031044 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 412031044
		arg_181_1.duration_ = 9.7

		local var_181_0 = {
			zh = 9.7,
			ja = 6.8
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
				arg_181_0:Play412031045(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = 0.975

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				arg_181_1.leftNameTxt_.text = arg_181_1:FormatText(StoryNameCfg[920].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_1 = arg_181_1:GetWordFromCfg(412031044)
				local var_184_2 = arg_181_1:FormatText(var_184_1.content)

				arg_181_1.text_.text = var_184_2

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_4 = 39 <= 0 and var_184_0 or var_184_0 * (utf8.len(var_184_2) / 39)

				if (39 <= 0 and var_184_0 or var_184_0 * (utf8.len(var_184_2) / 39)) > 0 and var_184_0 < var_184_4 then
					arg_181_1.talkMaxDuration = var_184_4

					if var_184_4 + 0 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_4 + 0
					end
				end

				arg_181_1.text_.text = var_184_2
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031044", "story_v_out_412031.awb") ~= 0 then
					local var_184_5 = manager.audio:GetVoiceLength("story_v_out_412031", "412031044", "story_v_out_412031.awb") / 1000

					if var_184_5 + 0 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_5 + 0
					end

					if var_184_1.prefab_name ~= "" and arg_181_1.actors_[var_184_1.prefab_name] ~= nil then
						local var_184_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_1.prefab_name].transform, "story_v_out_412031", "412031044", "story_v_out_412031.awb")

						arg_181_1:RecordAudio("412031044", var_184_6)
						arg_181_1:RecordAudio("412031044", var_184_6)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_out_412031", "412031044", "story_v_out_412031.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_out_412031", "412031044", "story_v_out_412031.awb")
				end

				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_7 = math.max(var_184_0, arg_181_1.talkMaxDuration)

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_7 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - 0) / var_184_7

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= 0 + var_184_7 and arg_181_1.time_ < 0 + var_184_7 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {}

		arg_181_1:InitPlayNodeList()
	end,
	Play412031045 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 412031045
		arg_185_1.duration_ = 9.9

		local var_185_0 = {
			zh = 8.333,
			ja = 9.9
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
				arg_185_0:Play412031046(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = 0.65

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				arg_185_1.leftNameTxt_.text = arg_185_1:FormatText(StoryNameCfg[920].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_1 = arg_185_1:GetWordFromCfg(412031045)
				local var_188_2 = arg_185_1:FormatText(var_188_1.content)

				arg_185_1.text_.text = var_188_2

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_4 = 26 <= 0 and var_188_0 or var_188_0 * (utf8.len(var_188_2) / 26)

				if (26 <= 0 and var_188_0 or var_188_0 * (utf8.len(var_188_2) / 26)) > 0 and var_188_0 < var_188_4 then
					arg_185_1.talkMaxDuration = var_188_4

					if var_188_4 + 0 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_4 + 0
					end
				end

				arg_185_1.text_.text = var_188_2
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031045", "story_v_out_412031.awb") ~= 0 then
					local var_188_5 = manager.audio:GetVoiceLength("story_v_out_412031", "412031045", "story_v_out_412031.awb") / 1000

					if var_188_5 + 0 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_5 + 0
					end

					if var_188_1.prefab_name ~= "" and arg_185_1.actors_[var_188_1.prefab_name] ~= nil then
						local var_188_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_1.prefab_name].transform, "story_v_out_412031", "412031045", "story_v_out_412031.awb")

						arg_185_1:RecordAudio("412031045", var_188_6)
						arg_185_1:RecordAudio("412031045", var_188_6)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_out_412031", "412031045", "story_v_out_412031.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_out_412031", "412031045", "story_v_out_412031.awb")
				end

				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_7 = math.max(var_188_0, arg_185_1.talkMaxDuration)

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_7 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - 0) / var_188_7

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= 0 + var_188_7 and arg_185_1.time_ < 0 + var_188_7 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {}

		arg_185_1:InitPlayNodeList()
	end,
	Play412031046 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 412031046
		arg_189_1.duration_ = 7

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
		end

		function arg_189_1.playNext_(arg_191_0)
			if arg_191_0 == 1 then
				arg_189_0:Play412031047(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				local var_192_0 = arg_189_1.bgs_.ST30

				arg_189_1.bgs_.ST30.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_192_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_192_1 = var_192_0:GetComponent("SpriteRenderer")

				if var_192_1 and var_192_1.sprite then
					local var_192_2 = 2 * (var_192_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_192_0.transform.localScale = Vector3.New(var_192_2 / var_192_1.sprite.bounds.size.y < var_192_2 * manager.ui.mainCameraCom_.aspect / var_192_1.sprite.bounds.size.x and var_192_2 * manager.ui.mainCameraCom_.aspect / var_192_1.sprite.bounds.size.x or var_192_2 / var_192_1.sprite.bounds.size.y, var_192_2 / var_192_1.sprite.bounds.size.y < var_192_2 * manager.ui.mainCameraCom_.aspect / var_192_1.sprite.bounds.size.x and var_192_2 * manager.ui.mainCameraCom_.aspect / var_192_1.sprite.bounds.size.x or var_192_2 / var_192_1.sprite.bounds.size.y, 0)
				end

				for iter_192_0, iter_192_1 in pairs(arg_189_1.bgs_) do
					if iter_192_0 ~= "ST30" then
						iter_192_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_192_3 = 1.999999999999

			if 1.999999999999 < arg_189_1.time_ and arg_189_1.time_ <= var_192_3 + arg_192_0 then
				arg_189_1.allBtn_.enabled = false
			end

			if arg_189_1.time_ >= var_192_3 + 0.3 and arg_189_1.time_ < var_192_3 + 0.3 + arg_192_0 then
				arg_189_1.allBtn_.enabled = true
			end

			local var_192_4 = 0

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= var_192_4 + arg_192_0 then
				arg_189_1.mask_.enabled = true
				arg_189_1.mask_.raycastTarget = true

				arg_189_1:SetGaussion(false)
			end

			local var_192_5 = 2

			if var_192_4 <= arg_189_1.time_ and arg_189_1.time_ < var_192_4 + var_192_5 then
				local var_192_6 = Color.New(1, 1, 1)

				var_192_6.a = Mathf.Lerp(1, 0, (arg_189_1.time_ - var_192_4) / var_192_5)
				arg_189_1.mask_.color = var_192_6
			end

			if arg_189_1.time_ >= var_192_4 + var_192_5 and arg_189_1.time_ < var_192_4 + var_192_5 + arg_192_0 then
				local var_192_7 = Color.New(1, 1, 1)

				arg_189_1.mask_.enabled = false
				var_192_7.a = 0
				arg_189_1.mask_.color = var_192_7
			end

			if arg_189_1.frameCnt_ <= 1 then
				arg_189_1.dialog_:SetActive(false)
			end

			local var_192_8 = 2
			local var_192_9 = 0.375

			if 2 < arg_189_1.time_ and arg_189_1.time_ <= var_192_8 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0

				arg_189_1.dialog_:SetActive(true)

				arg_189_1.dialogCg_.alpha = 0

				local var_192_10 = LeanTween.value(arg_189_1.dialog_, 0, 1, 0.3)

				var_192_10:setOnUpdate(LuaHelper.FloatAction(function(arg_193_0)
					arg_189_1.dialogCg_.alpha = arg_193_0
				end))
				var_192_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_189_1.dialog_)
					var_192_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_189_1.duration_ = arg_189_1.duration_ + 0.3

				SetActive(arg_189_1.leftNameGo_, false)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_11 = arg_189_1:FormatText(arg_189_1:GetWordFromCfg(412031046).content)

				arg_189_1.text_.text = var_192_11

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_13 = 15 <= 0 and var_192_9 or var_192_9 * (utf8.len(var_192_11) / 15)

				if (15 <= 0 and var_192_9 or var_192_9 * (utf8.len(var_192_11) / 15)) > 0 and var_192_9 < var_192_13 then
					arg_189_1.talkMaxDuration = var_192_13
					var_192_8 = var_192_8 + 0.3

					if var_192_13 + var_192_8 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_13 + var_192_8
					end
				end

				arg_189_1.text_.text = var_192_11
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)
				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_14 = var_192_8 + 0.3
			local var_192_15 = math.max(var_192_9, arg_189_1.talkMaxDuration)

			if var_192_8 + 0.3 <= arg_189_1.time_ and arg_189_1.time_ < var_192_14 + var_192_15 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_14) / var_192_15

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_14 + var_192_15 and arg_189_1.time_ < var_192_14 + var_192_15 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {}

		arg_189_1:InitPlayNodeList()
	end,
	Play412031047 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 412031047
		arg_195_1.duration_ = 8.57

		local var_195_0 = {
			zh = 6.633,
			ja = 8.566
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
				arg_195_0:Play412031048(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1.var_.moveOldPos10076ui_story = arg_195_1.actors_["10076ui_story"].transform.localPosition
			end

			local var_198_0 = 0.001

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_0 then
				arg_195_1.actors_["10076ui_story"].transform.localPosition = Vector3.Lerp(arg_195_1.var_.moveOldPos10076ui_story, Vector3.New(0, -0.35, -4), (arg_195_1.time_ - 0) / var_198_0)
				arg_195_1.actors_["10076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_195_1.actors_["10076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_195_1.actors_["10076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_195_1.actors_["10076ui_story"].transform.position).z)
				arg_195_1.actors_["10076ui_story"].transform.localEulerAngles.z = 0
				arg_195_1.actors_["10076ui_story"].transform.localEulerAngles.x = 0
				arg_195_1.actors_["10076ui_story"].transform.localEulerAngles = arg_195_1.actors_["10076ui_story"].transform.localEulerAngles
			end

			if arg_195_1.time_ >= 0 + var_198_0 and arg_195_1.time_ < 0 + var_198_0 + arg_198_0 then
				arg_195_1.actors_["10076ui_story"].transform.localPosition = Vector3.New(0, -0.35, -4)
				arg_195_1.actors_["10076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_195_1.actors_["10076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_195_1.actors_["10076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_195_1.actors_["10076ui_story"].transform.position).z)
				arg_195_1.actors_["10076ui_story"].transform.localEulerAngles.z = 0
				arg_195_1.actors_["10076ui_story"].transform.localEulerAngles.x = 0
				arg_195_1.actors_["10076ui_story"].transform.localEulerAngles = arg_195_1.actors_["10076ui_story"].transform.localEulerAngles
			end

			local var_198_1 = arg_195_1.actors_["10076ui_story"]

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 and not isNil(var_198_1) and arg_195_1.var_.characterEffect10076ui_story == nil then
				arg_195_1.var_.characterEffect10076ui_story = var_198_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_198_2 = 0.200000002980232

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_2 and not isNil(var_198_1) then
				if arg_195_1.var_.characterEffect10076ui_story and not isNil(var_198_1) then
					arg_195_1.var_.characterEffect10076ui_story.fillFlat = false
				end
			end

			if arg_195_1.time_ >= 0 + var_198_2 and arg_195_1.time_ < 0 + var_198_2 + arg_198_0 and not isNil(var_198_1) and arg_195_1.var_.characterEffect10076ui_story then
				arg_195_1.var_.characterEffect10076ui_story.fillFlat = false
			end

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1:PlayTimeline("10076ui_story", "StoryTimeline/CharAction/story10076/story10076action/10076action1_1")
			end

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1:PlayTimeline("10076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_198_4 = 0
			local var_198_5 = 0.75

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= var_198_4 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				arg_195_1.leftNameTxt_.text = arg_195_1:FormatText(StoryNameCfg[917].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_6 = arg_195_1:GetWordFromCfg(412031047)
				local var_198_7 = arg_195_1:FormatText(var_198_6.content)

				arg_195_1.text_.text = var_198_7

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_9 = 30 <= 0 and var_198_5 or var_198_5 * (utf8.len(var_198_7) / 30)

				if (30 <= 0 and var_198_5 or var_198_5 * (utf8.len(var_198_7) / 30)) > 0 and var_198_5 < var_198_9 then
					arg_195_1.talkMaxDuration = var_198_9

					if var_198_9 + var_198_4 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_9 + var_198_4
					end
				end

				arg_195_1.text_.text = var_198_7
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031047", "story_v_out_412031.awb") ~= 0 then
					local var_198_10 = manager.audio:GetVoiceLength("story_v_out_412031", "412031047", "story_v_out_412031.awb") / 1000

					if var_198_10 + var_198_4 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_10 + var_198_4
					end

					if var_198_6.prefab_name ~= "" and arg_195_1.actors_[var_198_6.prefab_name] ~= nil then
						local var_198_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_195_1.actors_[var_198_6.prefab_name].transform, "story_v_out_412031", "412031047", "story_v_out_412031.awb")

						arg_195_1:RecordAudio("412031047", var_198_11)
						arg_195_1:RecordAudio("412031047", var_198_11)
					else
						arg_195_1:AudioAction("play", "voice", "story_v_out_412031", "412031047", "story_v_out_412031.awb")
					end

					arg_195_1:RecordHistoryTalkVoice("story_v_out_412031", "412031047", "story_v_out_412031.awb")
				end

				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_12 = math.max(var_198_5, arg_195_1.talkMaxDuration)

			if var_198_4 <= arg_195_1.time_ and arg_195_1.time_ < var_198_4 + var_198_12 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_4) / var_198_12

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_4 + var_198_12 and arg_195_1.time_ < var_198_4 + var_198_12 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10076ui_story",
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
	Play412031048 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 412031048
		arg_199_1.duration_ = 9.7

		local var_199_0 = {
			zh = 6.933,
			ja = 9.7
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
				arg_199_0:Play412031049(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1.var_.moveOldPos1097ui_story = arg_199_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_202_0 = 0.001

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_0 then
				arg_199_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_199_1.var_.moveOldPos1097ui_story, Vector3.New(0, -0.54, -6.3), (arg_199_1.time_ - 0) / var_202_0)
				arg_199_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_199_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_199_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_199_1.actors_["1097ui_story"].transform.position).z)
				arg_199_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_199_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_199_1.actors_["1097ui_story"].transform.localEulerAngles = arg_199_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_199_1.time_ >= 0 + var_202_0 and arg_199_1.time_ < 0 + var_202_0 + arg_202_0 then
				arg_199_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(0, -0.54, -6.3)
				arg_199_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_199_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_199_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_199_1.actors_["1097ui_story"].transform.position).z)
				arg_199_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_199_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_199_1.actors_["1097ui_story"].transform.localEulerAngles = arg_199_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_202_1 = arg_199_1.actors_["1097ui_story"]

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 and not isNil(var_202_1) and arg_199_1.var_.characterEffect1097ui_story == nil then
				arg_199_1.var_.characterEffect1097ui_story = var_202_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_202_2 = 0.200000002980232

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_2 and not isNil(var_202_1) then
				if arg_199_1.var_.characterEffect1097ui_story and not isNil(var_202_1) then
					arg_199_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_199_1.time_ >= 0 + var_202_2 and arg_199_1.time_ < 0 + var_202_2 + arg_202_0 and not isNil(var_202_1) and arg_199_1.var_.characterEffect1097ui_story then
				arg_199_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action7_1")
			end

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_202_4 = arg_199_1.actors_["10076ui_story"].transform

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1.var_.moveOldPos10076ui_story = var_202_4.localPosition
			end

			local var_202_5 = 0.001

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_5 then
				var_202_4.localPosition = Vector3.Lerp(arg_199_1.var_.moveOldPos10076ui_story, Vector3.New(0, 100, 0), (arg_199_1.time_ - 0) / var_202_5)
				var_202_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_202_4.position).x, (manager.ui.mainCamera.transform.position - var_202_4.position).y, (manager.ui.mainCamera.transform.position - var_202_4.position).z)
				var_202_4.localEulerAngles.z = 0
				var_202_4.localEulerAngles.x = 0
				var_202_4.localEulerAngles = var_202_4.localEulerAngles
			end

			if arg_199_1.time_ >= 0 + var_202_5 and arg_199_1.time_ < 0 + var_202_5 + arg_202_0 then
				var_202_4.localPosition = Vector3.New(0, 100, 0)
				var_202_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_202_4.position).x, (manager.ui.mainCamera.transform.position - var_202_4.position).y, (manager.ui.mainCamera.transform.position - var_202_4.position).z)
				var_202_4.localEulerAngles.z = 0
				var_202_4.localEulerAngles.x = 0
				var_202_4.localEulerAngles = var_202_4.localEulerAngles
			end

			local var_202_6 = arg_199_1.actors_["10076ui_story"]

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 and not isNil(var_202_6) and arg_199_1.var_.characterEffect10076ui_story == nil then
				arg_199_1.var_.characterEffect10076ui_story = var_202_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_202_7 = 0.200000002980232

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_7 and not isNil(var_202_6) then
				if arg_199_1.var_.characterEffect10076ui_story and not isNil(var_202_6) then
					arg_199_1.var_.characterEffect10076ui_story.fillFlat = true
					arg_199_1.var_.characterEffect10076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_199_1.time_ - 0) / var_202_7)
				end
			end

			if arg_199_1.time_ >= 0 + var_202_7 and arg_199_1.time_ < 0 + var_202_7 + arg_202_0 and not isNil(var_202_6) and arg_199_1.var_.characterEffect10076ui_story then
				arg_199_1.var_.characterEffect10076ui_story.fillFlat = true
				arg_199_1.var_.characterEffect10076ui_story.fillRatio = 0.5
			end

			local var_202_8 = 0
			local var_202_9 = 0.55

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= var_202_8 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				arg_199_1.leftNameTxt_.text = arg_199_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_10 = arg_199_1:GetWordFromCfg(412031048)
				local var_202_11 = arg_199_1:FormatText(var_202_10.content)

				arg_199_1.text_.text = var_202_11

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_13 = 22 <= 0 and var_202_9 or var_202_9 * (utf8.len(var_202_11) / 22)

				if (22 <= 0 and var_202_9 or var_202_9 * (utf8.len(var_202_11) / 22)) > 0 and var_202_9 < var_202_13 then
					arg_199_1.talkMaxDuration = var_202_13

					if var_202_13 + var_202_8 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_13 + var_202_8
					end
				end

				arg_199_1.text_.text = var_202_11
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031048", "story_v_out_412031.awb") ~= 0 then
					local var_202_14 = manager.audio:GetVoiceLength("story_v_out_412031", "412031048", "story_v_out_412031.awb") / 1000

					if var_202_14 + var_202_8 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_14 + var_202_8
					end

					if var_202_10.prefab_name ~= "" and arg_199_1.actors_[var_202_10.prefab_name] ~= nil then
						local var_202_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_199_1.actors_[var_202_10.prefab_name].transform, "story_v_out_412031", "412031048", "story_v_out_412031.awb")

						arg_199_1:RecordAudio("412031048", var_202_15)
						arg_199_1:RecordAudio("412031048", var_202_15)
					else
						arg_199_1:AudioAction("play", "voice", "story_v_out_412031", "412031048", "story_v_out_412031.awb")
					end

					arg_199_1:RecordHistoryTalkVoice("story_v_out_412031", "412031048", "story_v_out_412031.awb")
				end

				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_16 = math.max(var_202_9, arg_199_1.talkMaxDuration)

			if var_202_8 <= arg_199_1.time_ and arg_199_1.time_ < var_202_8 + var_202_16 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_8) / var_202_16

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_8 + var_202_16 and arg_199_1.time_ < var_202_8 + var_202_16 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_199_1:InitPlayNodeList()
	end,
	Play412031049 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 412031049
		arg_203_1.duration_ = 6.4

		local var_203_0 = {
			zh = 4.833,
			ja = 6.4
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
				arg_203_0:Play412031050(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1.var_.moveOldPos10078ui_story = arg_203_1.actors_["10078ui_story"].transform.localPosition
			end

			local var_206_0 = 0.001

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_0 then
				arg_203_1.actors_["10078ui_story"].transform.localPosition = Vector3.Lerp(arg_203_1.var_.moveOldPos10078ui_story, Vector3.New(0, -0.5, -6.3), (arg_203_1.time_ - 0) / var_206_0)
				arg_203_1.actors_["10078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_203_1.actors_["10078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_203_1.actors_["10078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_203_1.actors_["10078ui_story"].transform.position).z)
				arg_203_1.actors_["10078ui_story"].transform.localEulerAngles.z = 0
				arg_203_1.actors_["10078ui_story"].transform.localEulerAngles.x = 0
				arg_203_1.actors_["10078ui_story"].transform.localEulerAngles = arg_203_1.actors_["10078ui_story"].transform.localEulerAngles
			end

			if arg_203_1.time_ >= 0 + var_206_0 and arg_203_1.time_ < 0 + var_206_0 + arg_206_0 then
				arg_203_1.actors_["10078ui_story"].transform.localPosition = Vector3.New(0, -0.5, -6.3)
				arg_203_1.actors_["10078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_203_1.actors_["10078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_203_1.actors_["10078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_203_1.actors_["10078ui_story"].transform.position).z)
				arg_203_1.actors_["10078ui_story"].transform.localEulerAngles.z = 0
				arg_203_1.actors_["10078ui_story"].transform.localEulerAngles.x = 0
				arg_203_1.actors_["10078ui_story"].transform.localEulerAngles = arg_203_1.actors_["10078ui_story"].transform.localEulerAngles
			end

			local var_206_1 = arg_203_1.actors_["10078ui_story"]

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 and not isNil(var_206_1) and arg_203_1.var_.characterEffect10078ui_story == nil then
				arg_203_1.var_.characterEffect10078ui_story = var_206_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_206_2 = 0.200000002980232

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_2 and not isNil(var_206_1) then
				if arg_203_1.var_.characterEffect10078ui_story and not isNil(var_206_1) then
					arg_203_1.var_.characterEffect10078ui_story.fillFlat = false
				end
			end

			if arg_203_1.time_ >= 0 + var_206_2 and arg_203_1.time_ < 0 + var_206_2 + arg_206_0 and not isNil(var_206_1) and arg_203_1.var_.characterEffect10078ui_story then
				arg_203_1.var_.characterEffect10078ui_story.fillFlat = false
			end

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1:PlayTimeline("10078ui_story", "StoryTimeline/CharAction/story6046/story6046action/6046action4_1")
			end

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1:PlayTimeline("10078ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_206_4 = arg_203_1.actors_["1097ui_story"].transform

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1.var_.moveOldPos1097ui_story = var_206_4.localPosition
			end

			local var_206_5 = 0.001

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_5 then
				var_206_4.localPosition = Vector3.Lerp(arg_203_1.var_.moveOldPos1097ui_story, Vector3.New(0, 100, 0), (arg_203_1.time_ - 0) / var_206_5)
				var_206_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_206_4.position).x, (manager.ui.mainCamera.transform.position - var_206_4.position).y, (manager.ui.mainCamera.transform.position - var_206_4.position).z)
				var_206_4.localEulerAngles.z = 0
				var_206_4.localEulerAngles.x = 0
				var_206_4.localEulerAngles = var_206_4.localEulerAngles
			end

			if arg_203_1.time_ >= 0 + var_206_5 and arg_203_1.time_ < 0 + var_206_5 + arg_206_0 then
				var_206_4.localPosition = Vector3.New(0, 100, 0)
				var_206_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_206_4.position).x, (manager.ui.mainCamera.transform.position - var_206_4.position).y, (manager.ui.mainCamera.transform.position - var_206_4.position).z)
				var_206_4.localEulerAngles.z = 0
				var_206_4.localEulerAngles.x = 0
				var_206_4.localEulerAngles = var_206_4.localEulerAngles
			end

			local var_206_6 = arg_203_1.actors_["1097ui_story"]

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 and not isNil(var_206_6) and arg_203_1.var_.characterEffect1097ui_story == nil then
				arg_203_1.var_.characterEffect1097ui_story = var_206_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_206_7 = 0.200000002980232

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_7 and not isNil(var_206_6) then
				if arg_203_1.var_.characterEffect1097ui_story and not isNil(var_206_6) then
					arg_203_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_203_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_203_1.time_ - 0) / var_206_7)
				end
			end

			if arg_203_1.time_ >= 0 + var_206_7 and arg_203_1.time_ < 0 + var_206_7 + arg_206_0 and not isNil(var_206_6) and arg_203_1.var_.characterEffect1097ui_story then
				arg_203_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_203_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_206_8 = 0
			local var_206_9 = 0.375

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= var_206_8 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				arg_203_1.leftNameTxt_.text = arg_203_1:FormatText(StoryNameCfg[919].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_10 = arg_203_1:GetWordFromCfg(412031049)
				local var_206_11 = arg_203_1:FormatText(var_206_10.content)

				arg_203_1.text_.text = var_206_11

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_13 = 15 <= 0 and var_206_9 or var_206_9 * (utf8.len(var_206_11) / 15)

				if (15 <= 0 and var_206_9 or var_206_9 * (utf8.len(var_206_11) / 15)) > 0 and var_206_9 < var_206_13 then
					arg_203_1.talkMaxDuration = var_206_13

					if var_206_13 + var_206_8 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_13 + var_206_8
					end
				end

				arg_203_1.text_.text = var_206_11
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031049", "story_v_out_412031.awb") ~= 0 then
					local var_206_14 = manager.audio:GetVoiceLength("story_v_out_412031", "412031049", "story_v_out_412031.awb") / 1000

					if var_206_14 + var_206_8 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_14 + var_206_8
					end

					if var_206_10.prefab_name ~= "" and arg_203_1.actors_[var_206_10.prefab_name] ~= nil then
						local var_206_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_10.prefab_name].transform, "story_v_out_412031", "412031049", "story_v_out_412031.awb")

						arg_203_1:RecordAudio("412031049", var_206_15)
						arg_203_1:RecordAudio("412031049", var_206_15)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_out_412031", "412031049", "story_v_out_412031.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_out_412031", "412031049", "story_v_out_412031.awb")
				end

				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_16 = math.max(var_206_9, arg_203_1.talkMaxDuration)

			if var_206_8 <= arg_203_1.time_ and arg_203_1.time_ < var_206_8 + var_206_16 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_8) / var_206_16

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_8 + var_206_16 and arg_203_1.time_ < var_206_8 + var_206_16 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_203_1:InitPlayNodeList()
	end,
	Play412031050 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 412031050
		arg_207_1.duration_ = 13.17

		local var_207_0 = {
			zh = 13.166,
			ja = 11.933
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
				arg_207_0:Play412031051(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1.var_.moveOldPos10083ui_story = arg_207_1.actors_["10083ui_story"].transform.localPosition
			end

			local var_210_0 = 0.001

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_0 then
				arg_207_1.actors_["10083ui_story"].transform.localPosition = Vector3.Lerp(arg_207_1.var_.moveOldPos10083ui_story, Vector3.New(-1, -2.6, -2.8), (arg_207_1.time_ - 0) / var_210_0)
				arg_207_1.actors_["10083ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_207_1.actors_["10083ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_207_1.actors_["10083ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_207_1.actors_["10083ui_story"].transform.position).z)
				arg_207_1.actors_["10083ui_story"].transform.localEulerAngles.z = 0
				arg_207_1.actors_["10083ui_story"].transform.localEulerAngles.x = 0
				arg_207_1.actors_["10083ui_story"].transform.localEulerAngles = arg_207_1.actors_["10083ui_story"].transform.localEulerAngles
			end

			if arg_207_1.time_ >= 0 + var_210_0 and arg_207_1.time_ < 0 + var_210_0 + arg_210_0 then
				arg_207_1.actors_["10083ui_story"].transform.localPosition = Vector3.New(-1, -2.6, -2.8)
				arg_207_1.actors_["10083ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_207_1.actors_["10083ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_207_1.actors_["10083ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_207_1.actors_["10083ui_story"].transform.position).z)
				arg_207_1.actors_["10083ui_story"].transform.localEulerAngles.z = 0
				arg_207_1.actors_["10083ui_story"].transform.localEulerAngles.x = 0
				arg_207_1.actors_["10083ui_story"].transform.localEulerAngles = arg_207_1.actors_["10083ui_story"].transform.localEulerAngles
			end

			local var_210_1 = arg_207_1.actors_["10083ui_story"]

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 and not isNil(var_210_1) and arg_207_1.var_.characterEffect10083ui_story == nil then
				arg_207_1.var_.characterEffect10083ui_story = var_210_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_210_2 = 0.200000002980232

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_2 and not isNil(var_210_1) then
				if arg_207_1.var_.characterEffect10083ui_story and not isNil(var_210_1) then
					arg_207_1.var_.characterEffect10083ui_story.fillFlat = false
				end
			end

			if arg_207_1.time_ >= 0 + var_210_2 and arg_207_1.time_ < 0 + var_210_2 + arg_210_0 and not isNil(var_210_1) and arg_207_1.var_.characterEffect10083ui_story then
				arg_207_1.var_.characterEffect10083ui_story.fillFlat = false
			end

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1:PlayTimeline("10083ui_story", "StoryTimeline/CharAction/story10083/story10083action/10083action1_1")
			end

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1:PlayTimeline("10083ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_210_4 = arg_207_1.actors_["10078ui_story"].transform

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1.var_.moveOldPos10078ui_story = var_210_4.localPosition
			end

			local var_210_5 = 0.001

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_5 then
				var_210_4.localPosition = Vector3.Lerp(arg_207_1.var_.moveOldPos10078ui_story, Vector3.New(0, 100, 0), (arg_207_1.time_ - 0) / var_210_5)
				var_210_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_210_4.position).x, (manager.ui.mainCamera.transform.position - var_210_4.position).y, (manager.ui.mainCamera.transform.position - var_210_4.position).z)
				var_210_4.localEulerAngles.z = 0
				var_210_4.localEulerAngles.x = 0
				var_210_4.localEulerAngles = var_210_4.localEulerAngles
			end

			if arg_207_1.time_ >= 0 + var_210_5 and arg_207_1.time_ < 0 + var_210_5 + arg_210_0 then
				var_210_4.localPosition = Vector3.New(0, 100, 0)
				var_210_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_210_4.position).x, (manager.ui.mainCamera.transform.position - var_210_4.position).y, (manager.ui.mainCamera.transform.position - var_210_4.position).z)
				var_210_4.localEulerAngles.z = 0
				var_210_4.localEulerAngles.x = 0
				var_210_4.localEulerAngles = var_210_4.localEulerAngles
			end

			local var_210_6 = arg_207_1.actors_["10078ui_story"]

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 and not isNil(var_210_6) and arg_207_1.var_.characterEffect10078ui_story == nil then
				arg_207_1.var_.characterEffect10078ui_story = var_210_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_210_7 = 0.200000002980232

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_7 and not isNil(var_210_6) then
				if arg_207_1.var_.characterEffect10078ui_story and not isNil(var_210_6) then
					arg_207_1.var_.characterEffect10078ui_story.fillFlat = true
					arg_207_1.var_.characterEffect10078ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_207_1.time_ - 0) / var_210_7)
				end
			end

			if arg_207_1.time_ >= 0 + var_210_7 and arg_207_1.time_ < 0 + var_210_7 + arg_210_0 and not isNil(var_210_6) and arg_207_1.var_.characterEffect10078ui_story then
				arg_207_1.var_.characterEffect10078ui_story.fillFlat = true
				arg_207_1.var_.characterEffect10078ui_story.fillRatio = 0.5
			end

			local var_210_8 = 0
			local var_210_9 = 1.475

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= var_210_8 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				arg_207_1.leftNameTxt_.text = arg_207_1:FormatText(StoryNameCfg[918].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_10 = arg_207_1:GetWordFromCfg(412031050)
				local var_210_11 = arg_207_1:FormatText(var_210_10.content)

				arg_207_1.text_.text = var_210_11

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_13 = 58 <= 0 and var_210_9 or var_210_9 * (utf8.len(var_210_11) / 58)

				if (58 <= 0 and var_210_9 or var_210_9 * (utf8.len(var_210_11) / 58)) > 0 and var_210_9 < var_210_13 then
					arg_207_1.talkMaxDuration = var_210_13

					if var_210_13 + var_210_8 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_13 + var_210_8
					end
				end

				arg_207_1.text_.text = var_210_11
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031050", "story_v_out_412031.awb") ~= 0 then
					local var_210_14 = manager.audio:GetVoiceLength("story_v_out_412031", "412031050", "story_v_out_412031.awb") / 1000

					if var_210_14 + var_210_8 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_14 + var_210_8
					end

					if var_210_10.prefab_name ~= "" and arg_207_1.actors_[var_210_10.prefab_name] ~= nil then
						local var_210_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_207_1.actors_[var_210_10.prefab_name].transform, "story_v_out_412031", "412031050", "story_v_out_412031.awb")

						arg_207_1:RecordAudio("412031050", var_210_15)
						arg_207_1:RecordAudio("412031050", var_210_15)
					else
						arg_207_1:AudioAction("play", "voice", "story_v_out_412031", "412031050", "story_v_out_412031.awb")
					end

					arg_207_1:RecordHistoryTalkVoice("story_v_out_412031", "412031050", "story_v_out_412031.awb")
				end

				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_16 = math.max(var_210_9, arg_207_1.talkMaxDuration)

			if var_210_8 <= arg_207_1.time_ and arg_207_1.time_ < var_210_8 + var_210_16 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_8) / var_210_16

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_8 + var_210_16 and arg_207_1.time_ < var_210_8 + var_210_16 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10083ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10078ui_story",
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
	Play412031051 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 412031051
		arg_211_1.duration_ = 9.03

		local var_211_0 = {
			zh = 9.033,
			ja = 5.466
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
				arg_211_0:Play412031052(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1.var_.moveOldPos1097ui_story = arg_211_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_214_0 = 0.001

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_0 then
				arg_211_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_211_1.var_.moveOldPos1097ui_story, Vector3.New(0.7, -0.54, -6.3), (arg_211_1.time_ - 0) / var_214_0)
				arg_211_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_211_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_211_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_211_1.actors_["1097ui_story"].transform.position).z)
				arg_211_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_211_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_211_1.actors_["1097ui_story"].transform.localEulerAngles = arg_211_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_211_1.time_ >= 0 + var_214_0 and arg_211_1.time_ < 0 + var_214_0 + arg_214_0 then
				arg_211_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(0.7, -0.54, -6.3)
				arg_211_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_211_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_211_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_211_1.actors_["1097ui_story"].transform.position).z)
				arg_211_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_211_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_211_1.actors_["1097ui_story"].transform.localEulerAngles = arg_211_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_214_1 = arg_211_1.actors_["1097ui_story"]

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 and not isNil(var_214_1) and arg_211_1.var_.characterEffect1097ui_story == nil then
				arg_211_1.var_.characterEffect1097ui_story = var_214_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_214_2 = 0.200000002980232

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_2 and not isNil(var_214_1) then
				if arg_211_1.var_.characterEffect1097ui_story and not isNil(var_214_1) then
					arg_211_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_211_1.time_ >= 0 + var_214_2 and arg_211_1.time_ < 0 + var_214_2 + arg_214_0 and not isNil(var_214_1) and arg_211_1.var_.characterEffect1097ui_story then
				arg_211_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action7_1")
			end

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_214_4 = arg_211_1.actors_["10083ui_story"]

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 and not isNil(var_214_4) and arg_211_1.var_.characterEffect10083ui_story == nil then
				arg_211_1.var_.characterEffect10083ui_story = var_214_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_214_5 = 0.200000002980232

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_5 and not isNil(var_214_4) then
				if arg_211_1.var_.characterEffect10083ui_story and not isNil(var_214_4) then
					arg_211_1.var_.characterEffect10083ui_story.fillFlat = true
					arg_211_1.var_.characterEffect10083ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_211_1.time_ - 0) / var_214_5)
				end
			end

			if arg_211_1.time_ >= 0 + var_214_5 and arg_211_1.time_ < 0 + var_214_5 + arg_214_0 and not isNil(var_214_4) and arg_211_1.var_.characterEffect10083ui_story then
				arg_211_1.var_.characterEffect10083ui_story.fillFlat = true
				arg_211_1.var_.characterEffect10083ui_story.fillRatio = 0.5
			end

			local var_214_6 = 0
			local var_214_7 = 0.65

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= var_214_6 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, true)

				arg_211_1.leftNameTxt_.text = arg_211_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_211_1.leftNameTxt_.transform)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1.leftNameTxt_.text)
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_8 = arg_211_1:GetWordFromCfg(412031051)
				local var_214_9 = arg_211_1:FormatText(var_214_8.content)

				arg_211_1.text_.text = var_214_9

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_11 = 26 <= 0 and var_214_7 or var_214_7 * (utf8.len(var_214_9) / 26)

				if (26 <= 0 and var_214_7 or var_214_7 * (utf8.len(var_214_9) / 26)) > 0 and var_214_7 < var_214_11 then
					arg_211_1.talkMaxDuration = var_214_11

					if var_214_11 + var_214_6 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_11 + var_214_6
					end
				end

				arg_211_1.text_.text = var_214_9
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031051", "story_v_out_412031.awb") ~= 0 then
					local var_214_12 = manager.audio:GetVoiceLength("story_v_out_412031", "412031051", "story_v_out_412031.awb") / 1000

					if var_214_12 + var_214_6 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_12 + var_214_6
					end

					if var_214_8.prefab_name ~= "" and arg_211_1.actors_[var_214_8.prefab_name] ~= nil then
						local var_214_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_211_1.actors_[var_214_8.prefab_name].transform, "story_v_out_412031", "412031051", "story_v_out_412031.awb")

						arg_211_1:RecordAudio("412031051", var_214_13)
						arg_211_1:RecordAudio("412031051", var_214_13)
					else
						arg_211_1:AudioAction("play", "voice", "story_v_out_412031", "412031051", "story_v_out_412031.awb")
					end

					arg_211_1:RecordHistoryTalkVoice("story_v_out_412031", "412031051", "story_v_out_412031.awb")
				end

				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_14 = math.max(var_214_7, arg_211_1.talkMaxDuration)

			if var_214_6 <= arg_211_1.time_ and arg_211_1.time_ < var_214_6 + var_214_14 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_6) / var_214_14

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_6 + var_214_14 and arg_211_1.time_ < var_214_6 + var_214_14 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_211_1:InitPlayNodeList()
	end,
	Play412031052 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 412031052
		arg_215_1.duration_ = 5.2

		local var_215_0 = {
			zh = 5.2,
			ja = 4.666
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
				arg_215_0:Play412031053(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1.var_.moveOldPos10083ui_story = arg_215_1.actors_["10083ui_story"].transform.localPosition
			end

			local var_218_0 = 0.001

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_0 then
				arg_215_1.actors_["10083ui_story"].transform.localPosition = Vector3.Lerp(arg_215_1.var_.moveOldPos10083ui_story, Vector3.New(-1, -2.6, -2.8), (arg_215_1.time_ - 0) / var_218_0)
				arg_215_1.actors_["10083ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_215_1.actors_["10083ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_215_1.actors_["10083ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_215_1.actors_["10083ui_story"].transform.position).z)
				arg_215_1.actors_["10083ui_story"].transform.localEulerAngles.z = 0
				arg_215_1.actors_["10083ui_story"].transform.localEulerAngles.x = 0
				arg_215_1.actors_["10083ui_story"].transform.localEulerAngles = arg_215_1.actors_["10083ui_story"].transform.localEulerAngles
			end

			if arg_215_1.time_ >= 0 + var_218_0 and arg_215_1.time_ < 0 + var_218_0 + arg_218_0 then
				arg_215_1.actors_["10083ui_story"].transform.localPosition = Vector3.New(-1, -2.6, -2.8)
				arg_215_1.actors_["10083ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_215_1.actors_["10083ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_215_1.actors_["10083ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_215_1.actors_["10083ui_story"].transform.position).z)
				arg_215_1.actors_["10083ui_story"].transform.localEulerAngles.z = 0
				arg_215_1.actors_["10083ui_story"].transform.localEulerAngles.x = 0
				arg_215_1.actors_["10083ui_story"].transform.localEulerAngles = arg_215_1.actors_["10083ui_story"].transform.localEulerAngles
			end

			local var_218_1 = arg_215_1.actors_["10083ui_story"]

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 and not isNil(var_218_1) and arg_215_1.var_.characterEffect10083ui_story == nil then
				arg_215_1.var_.characterEffect10083ui_story = var_218_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_218_2 = 0.200000002980232

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_2 and not isNil(var_218_1) then
				if arg_215_1.var_.characterEffect10083ui_story and not isNil(var_218_1) then
					arg_215_1.var_.characterEffect10083ui_story.fillFlat = false
				end
			end

			if arg_215_1.time_ >= 0 + var_218_2 and arg_215_1.time_ < 0 + var_218_2 + arg_218_0 and not isNil(var_218_1) and arg_215_1.var_.characterEffect10083ui_story then
				arg_215_1.var_.characterEffect10083ui_story.fillFlat = false
			end

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1:PlayTimeline("10083ui_story", "StoryTimeline/CharAction/story10083/story10083action/10083action4_1")
			end

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1:PlayTimeline("10083ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_218_4 = arg_215_1.actors_["1097ui_story"]

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 and not isNil(var_218_4) and arg_215_1.var_.characterEffect1097ui_story == nil then
				arg_215_1.var_.characterEffect1097ui_story = var_218_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_218_5 = 0.200000002980232

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_5 and not isNil(var_218_4) then
				if arg_215_1.var_.characterEffect1097ui_story and not isNil(var_218_4) then
					arg_215_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_215_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_215_1.time_ - 0) / var_218_5)
				end
			end

			if arg_215_1.time_ >= 0 + var_218_5 and arg_215_1.time_ < 0 + var_218_5 + arg_218_0 and not isNil(var_218_4) and arg_215_1.var_.characterEffect1097ui_story then
				arg_215_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_215_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_218_6 = 0
			local var_218_7 = 0.625

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= var_218_6 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				arg_215_1.leftNameTxt_.text = arg_215_1:FormatText(StoryNameCfg[918].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_8 = arg_215_1:GetWordFromCfg(412031052)
				local var_218_9 = arg_215_1:FormatText(var_218_8.content)

				arg_215_1.text_.text = var_218_9

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_11 = 25 <= 0 and var_218_7 or var_218_7 * (utf8.len(var_218_9) / 25)

				if (25 <= 0 and var_218_7 or var_218_7 * (utf8.len(var_218_9) / 25)) > 0 and var_218_7 < var_218_11 then
					arg_215_1.talkMaxDuration = var_218_11

					if var_218_11 + var_218_6 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_11 + var_218_6
					end
				end

				arg_215_1.text_.text = var_218_9
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031052", "story_v_out_412031.awb") ~= 0 then
					local var_218_12 = manager.audio:GetVoiceLength("story_v_out_412031", "412031052", "story_v_out_412031.awb") / 1000

					if var_218_12 + var_218_6 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_12 + var_218_6
					end

					if var_218_8.prefab_name ~= "" and arg_215_1.actors_[var_218_8.prefab_name] ~= nil then
						local var_218_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_215_1.actors_[var_218_8.prefab_name].transform, "story_v_out_412031", "412031052", "story_v_out_412031.awb")

						arg_215_1:RecordAudio("412031052", var_218_13)
						arg_215_1:RecordAudio("412031052", var_218_13)
					else
						arg_215_1:AudioAction("play", "voice", "story_v_out_412031", "412031052", "story_v_out_412031.awb")
					end

					arg_215_1:RecordHistoryTalkVoice("story_v_out_412031", "412031052", "story_v_out_412031.awb")
				end

				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_14 = math.max(var_218_7, arg_215_1.talkMaxDuration)

			if var_218_6 <= arg_215_1.time_ and arg_215_1.time_ < var_218_6 + var_218_14 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_6) / var_218_14

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_6 + var_218_14 and arg_215_1.time_ < var_218_6 + var_218_14 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10083ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_215_1:InitPlayNodeList()
	end,
	Play412031053 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 412031053
		arg_219_1.duration_ = 10.97

		local var_219_0 = {
			zh = 5.233,
			ja = 10.966
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
				arg_219_0:Play412031054(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1.var_.moveOldPos1097ui_story = arg_219_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_222_0 = 0.001

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_0 then
				arg_219_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_219_1.var_.moveOldPos1097ui_story, Vector3.New(0.7, -0.54, -6.3), (arg_219_1.time_ - 0) / var_222_0)
				arg_219_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_219_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_219_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_219_1.actors_["1097ui_story"].transform.position).z)
				arg_219_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_219_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_219_1.actors_["1097ui_story"].transform.localEulerAngles = arg_219_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_219_1.time_ >= 0 + var_222_0 and arg_219_1.time_ < 0 + var_222_0 + arg_222_0 then
				arg_219_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(0.7, -0.54, -6.3)
				arg_219_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_219_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_219_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_219_1.actors_["1097ui_story"].transform.position).z)
				arg_219_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_219_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_219_1.actors_["1097ui_story"].transform.localEulerAngles = arg_219_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_222_1 = arg_219_1.actors_["1097ui_story"]

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 and not isNil(var_222_1) and arg_219_1.var_.characterEffect1097ui_story == nil then
				arg_219_1.var_.characterEffect1097ui_story = var_222_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_222_2 = 0.200000002980232

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_2 and not isNil(var_222_1) then
				if arg_219_1.var_.characterEffect1097ui_story and not isNil(var_222_1) then
					arg_219_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_219_1.time_ >= 0 + var_222_2 and arg_219_1.time_ < 0 + var_222_2 + arg_222_0 and not isNil(var_222_1) and arg_219_1.var_.characterEffect1097ui_story then
				arg_219_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action7_2")
			end

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_222_4 = arg_219_1.actors_["10083ui_story"]

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 and not isNil(var_222_4) and arg_219_1.var_.characterEffect10083ui_story == nil then
				arg_219_1.var_.characterEffect10083ui_story = var_222_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_222_5 = 0.200000002980232

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_5 and not isNil(var_222_4) then
				if arg_219_1.var_.characterEffect10083ui_story and not isNil(var_222_4) then
					arg_219_1.var_.characterEffect10083ui_story.fillFlat = true
					arg_219_1.var_.characterEffect10083ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_219_1.time_ - 0) / var_222_5)
				end
			end

			if arg_219_1.time_ >= 0 + var_222_5 and arg_219_1.time_ < 0 + var_222_5 + arg_222_0 and not isNil(var_222_4) and arg_219_1.var_.characterEffect10083ui_story then
				arg_219_1.var_.characterEffect10083ui_story.fillFlat = true
				arg_219_1.var_.characterEffect10083ui_story.fillRatio = 0.5
			end

			local var_222_6 = 0
			local var_222_7 = 0.4

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= var_222_6 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, true)

				arg_219_1.leftNameTxt_.text = arg_219_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_219_1.leftNameTxt_.transform)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1.leftNameTxt_.text)
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_8 = arg_219_1:GetWordFromCfg(412031053)
				local var_222_9 = arg_219_1:FormatText(var_222_8.content)

				arg_219_1.text_.text = var_222_9

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_11 = 16 <= 0 and var_222_7 or var_222_7 * (utf8.len(var_222_9) / 16)

				if (16 <= 0 and var_222_7 or var_222_7 * (utf8.len(var_222_9) / 16)) > 0 and var_222_7 < var_222_11 then
					arg_219_1.talkMaxDuration = var_222_11

					if var_222_11 + var_222_6 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_11 + var_222_6
					end
				end

				arg_219_1.text_.text = var_222_9
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031053", "story_v_out_412031.awb") ~= 0 then
					local var_222_12 = manager.audio:GetVoiceLength("story_v_out_412031", "412031053", "story_v_out_412031.awb") / 1000

					if var_222_12 + var_222_6 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_12 + var_222_6
					end

					if var_222_8.prefab_name ~= "" and arg_219_1.actors_[var_222_8.prefab_name] ~= nil then
						local var_222_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_219_1.actors_[var_222_8.prefab_name].transform, "story_v_out_412031", "412031053", "story_v_out_412031.awb")

						arg_219_1:RecordAudio("412031053", var_222_13)
						arg_219_1:RecordAudio("412031053", var_222_13)
					else
						arg_219_1:AudioAction("play", "voice", "story_v_out_412031", "412031053", "story_v_out_412031.awb")
					end

					arg_219_1:RecordHistoryTalkVoice("story_v_out_412031", "412031053", "story_v_out_412031.awb")
				end

				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_14 = math.max(var_222_7, arg_219_1.talkMaxDuration)

			if var_222_6 <= arg_219_1.time_ and arg_219_1.time_ < var_222_6 + var_222_14 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_6) / var_222_14

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_6 + var_222_14 and arg_219_1.time_ < var_222_6 + var_222_14 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_219_1:InitPlayNodeList()
	end,
	Play412031054 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 412031054
		arg_223_1.duration_ = 10.17

		local var_223_0 = {
			zh = 10.165999999999,
			ja = 9.265999999999
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
				arg_223_0:Play412031055(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			if arg_223_1.bgs_.STblack == nil then
				local var_226_0 = Object.Instantiate(arg_223_1.paintGo_)

				var_226_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STblack")
				var_226_0.name = "STblack"
				var_226_0.transform.parent = arg_223_1.stage_.transform
				var_226_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_223_1.bgs_.STblack = var_226_0
			end

			if 2 < arg_223_1.time_ and arg_223_1.time_ <= 2 + arg_226_0 then
				local var_226_1 = arg_223_1.bgs_.STblack

				arg_223_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_226_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_226_2 = var_226_1:GetComponent("SpriteRenderer")

				if var_226_2 and var_226_2.sprite then
					local var_226_3 = 2 * (var_226_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_226_1.transform.localScale = Vector3.New(var_226_3 / var_226_2.sprite.bounds.size.y < var_226_3 * manager.ui.mainCameraCom_.aspect / var_226_2.sprite.bounds.size.x and var_226_3 * manager.ui.mainCameraCom_.aspect / var_226_2.sprite.bounds.size.x or var_226_3 / var_226_2.sprite.bounds.size.y, var_226_3 / var_226_2.sprite.bounds.size.y < var_226_3 * manager.ui.mainCameraCom_.aspect / var_226_2.sprite.bounds.size.x and var_226_3 * manager.ui.mainCameraCom_.aspect / var_226_2.sprite.bounds.size.x or var_226_3 / var_226_2.sprite.bounds.size.y, 0)
				end

				for iter_226_0, iter_226_1 in pairs(arg_223_1.bgs_) do
					if iter_226_0 ~= "STblack" then
						iter_226_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_226_4 = 3.999999999999

			if 3.999999999999 < arg_223_1.time_ and arg_223_1.time_ <= var_226_4 + arg_226_0 then
				arg_223_1.allBtn_.enabled = false
			end

			if arg_223_1.time_ >= var_226_4 + 0.3 and arg_223_1.time_ < var_226_4 + 0.3 + arg_226_0 then
				arg_223_1.allBtn_.enabled = true
			end

			local var_226_5 = 0

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= var_226_5 + arg_226_0 then
				arg_223_1.mask_.enabled = true
				arg_223_1.mask_.raycastTarget = true

				arg_223_1:SetGaussion(false)
			end

			local var_226_6 = 2

			if var_226_5 <= arg_223_1.time_ and arg_223_1.time_ < var_226_5 + var_226_6 then
				local var_226_7 = Color.New(0, 0, 0)

				var_226_7.a = Mathf.Lerp(0, 1, (arg_223_1.time_ - var_226_5) / var_226_6)
				arg_223_1.mask_.color = var_226_7
			end

			if arg_223_1.time_ >= var_226_5 + var_226_6 and arg_223_1.time_ < var_226_5 + var_226_6 + arg_226_0 then
				local var_226_8 = Color.New(0, 0, 0)

				var_226_8.a = 1
				arg_223_1.mask_.color = var_226_8
			end

			local var_226_9 = 2

			if 2 < arg_223_1.time_ and arg_223_1.time_ <= var_226_9 + arg_226_0 then
				arg_223_1.mask_.enabled = true
				arg_223_1.mask_.raycastTarget = true

				arg_223_1:SetGaussion(false)
			end

			local var_226_10 = 2

			if var_226_9 <= arg_223_1.time_ and arg_223_1.time_ < var_226_9 + var_226_10 then
				local var_226_11 = Color.New(0, 0, 0)

				var_226_11.a = Mathf.Lerp(1, 0, (arg_223_1.time_ - var_226_9) / var_226_10)
				arg_223_1.mask_.color = var_226_11
			end

			if arg_223_1.time_ >= var_226_9 + var_226_10 and arg_223_1.time_ < var_226_9 + var_226_10 + arg_226_0 then
				local var_226_12 = Color.New(0, 0, 0)

				arg_223_1.mask_.enabled = false
				var_226_12.a = 0
				arg_223_1.mask_.color = var_226_12
			end

			local var_226_13 = arg_223_1.actors_["1097ui_story"].transform

			if 1.966 < arg_223_1.time_ and arg_223_1.time_ <= 1.966 + arg_226_0 then
				arg_223_1.var_.moveOldPos1097ui_story = var_226_13.localPosition
			end

			local var_226_14 = 0.001

			if 1.966 <= arg_223_1.time_ and arg_223_1.time_ < 1.966 + var_226_14 then
				var_226_13.localPosition = Vector3.Lerp(arg_223_1.var_.moveOldPos1097ui_story, Vector3.New(0, 100, 0), (arg_223_1.time_ - 1.966) / var_226_14)
				var_226_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_226_13.position).x, (manager.ui.mainCamera.transform.position - var_226_13.position).y, (manager.ui.mainCamera.transform.position - var_226_13.position).z)
				var_226_13.localEulerAngles.z = 0
				var_226_13.localEulerAngles.x = 0
				var_226_13.localEulerAngles = var_226_13.localEulerAngles
			end

			if arg_223_1.time_ >= 1.966 + var_226_14 and arg_223_1.time_ < 1.966 + var_226_14 + arg_226_0 then
				var_226_13.localPosition = Vector3.New(0, 100, 0)
				var_226_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_226_13.position).x, (manager.ui.mainCamera.transform.position - var_226_13.position).y, (manager.ui.mainCamera.transform.position - var_226_13.position).z)
				var_226_13.localEulerAngles.z = 0
				var_226_13.localEulerAngles.x = 0
				var_226_13.localEulerAngles = var_226_13.localEulerAngles
			end

			local var_226_15 = arg_223_1.actors_["10083ui_story"].transform

			if 1.966 < arg_223_1.time_ and arg_223_1.time_ <= 1.966 + arg_226_0 then
				arg_223_1.var_.moveOldPos10083ui_story = var_226_15.localPosition
			end

			local var_226_16 = 0.001

			if 1.966 <= arg_223_1.time_ and arg_223_1.time_ < 1.966 + var_226_16 then
				var_226_15.localPosition = Vector3.Lerp(arg_223_1.var_.moveOldPos10083ui_story, Vector3.New(0, 100, 0), (arg_223_1.time_ - 1.966) / var_226_16)
				var_226_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_226_15.position).x, (manager.ui.mainCamera.transform.position - var_226_15.position).y, (manager.ui.mainCamera.transform.position - var_226_15.position).z)
				var_226_15.localEulerAngles.z = 0
				var_226_15.localEulerAngles.x = 0
				var_226_15.localEulerAngles = var_226_15.localEulerAngles
			end

			if arg_223_1.time_ >= 1.966 + var_226_16 and arg_223_1.time_ < 1.966 + var_226_16 + arg_226_0 then
				var_226_15.localPosition = Vector3.New(0, 100, 0)
				var_226_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_226_15.position).x, (manager.ui.mainCamera.transform.position - var_226_15.position).y, (manager.ui.mainCamera.transform.position - var_226_15.position).z)
				var_226_15.localEulerAngles.z = 0
				var_226_15.localEulerAngles.x = 0
				var_226_15.localEulerAngles = var_226_15.localEulerAngles
			end

			if arg_223_1.frameCnt_ <= 1 then
				arg_223_1.dialog_:SetActive(false)
			end

			local var_226_17 = 3.999999999999
			local var_226_18 = 0.55

			if 3.999999999999 < arg_223_1.time_ and arg_223_1.time_ <= var_226_17 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0

				arg_223_1.dialog_:SetActive(true)

				arg_223_1.dialogCg_.alpha = 0

				local var_226_19 = LeanTween.value(arg_223_1.dialog_, 0, 1, 0.3)

				var_226_19:setOnUpdate(LuaHelper.FloatAction(function(arg_227_0)
					arg_223_1.dialogCg_.alpha = arg_227_0
				end))
				var_226_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_223_1.dialog_)
					var_226_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_223_1.duration_ = arg_223_1.duration_ + 0.3

				SetActive(arg_223_1.leftNameGo_, true)

				arg_223_1.leftNameTxt_.text = arg_223_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_223_1.leftNameTxt_.transform)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1.leftNameTxt_.text)
				SetActive(arg_223_1.iconTrs_.gameObject, true)
				arg_223_1.iconController_:SetSelectedState("hero")

				arg_223_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1097")

				arg_223_1.callingController_:SetSelectedState("normal")

				arg_223_1.keyicon_.color = Color.New(1, 1, 1)
				arg_223_1.icon_.color = Color.New(1, 1, 1)

				local var_226_20 = arg_223_1:GetWordFromCfg(412031054)
				local var_226_21 = arg_223_1:FormatText(var_226_20.content)

				arg_223_1.text_.text = var_226_21

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_23 = 22 <= 0 and var_226_18 or var_226_18 * (utf8.len(var_226_21) / 22)

				if (22 <= 0 and var_226_18 or var_226_18 * (utf8.len(var_226_21) / 22)) > 0 and var_226_18 < var_226_23 then
					arg_223_1.talkMaxDuration = var_226_23
					var_226_17 = var_226_17 + 0.3

					if var_226_23 + var_226_17 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_23 + var_226_17
					end
				end

				arg_223_1.text_.text = var_226_21
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031054", "story_v_out_412031.awb") ~= 0 then
					local var_226_24 = manager.audio:GetVoiceLength("story_v_out_412031", "412031054", "story_v_out_412031.awb") / 1000

					if var_226_24 + var_226_17 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_24 + var_226_17
					end

					if var_226_20.prefab_name ~= "" and arg_223_1.actors_[var_226_20.prefab_name] ~= nil then
						local var_226_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_223_1.actors_[var_226_20.prefab_name].transform, "story_v_out_412031", "412031054", "story_v_out_412031.awb")

						arg_223_1:RecordAudio("412031054", var_226_25)
						arg_223_1:RecordAudio("412031054", var_226_25)
					else
						arg_223_1:AudioAction("play", "voice", "story_v_out_412031", "412031054", "story_v_out_412031.awb")
					end

					arg_223_1:RecordHistoryTalkVoice("story_v_out_412031", "412031054", "story_v_out_412031.awb")
				end

				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_26 = var_226_17 + 0.3
			local var_226_27 = math.max(var_226_18, arg_223_1.talkMaxDuration)

			if var_226_17 + 0.3 <= arg_223_1.time_ and arg_223_1.time_ < var_226_26 + var_226_27 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_26) / var_226_27

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_26 + var_226_27 and arg_223_1.time_ < var_226_26 + var_226_27 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10083ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_223_1:InitPlayNodeList()
	end,
	Play412031055 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 412031055
		arg_229_1.duration_ = 6.9

		local var_229_0 = {
			zh = 6.765999999999,
			ja = 6.899999999999
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
				arg_229_0:Play412031056(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			if 1.999999999999 < arg_229_1.time_ and arg_229_1.time_ <= 1.999999999999 + arg_232_0 then
				local var_232_0 = arg_229_1.bgs_.ST30

				arg_229_1.bgs_.ST30.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_232_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_232_1 = var_232_0:GetComponent("SpriteRenderer")

				if var_232_1 and var_232_1.sprite then
					local var_232_2 = 2 * (var_232_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_232_0.transform.localScale = Vector3.New(var_232_2 / var_232_1.sprite.bounds.size.y < var_232_2 * manager.ui.mainCameraCom_.aspect / var_232_1.sprite.bounds.size.x and var_232_2 * manager.ui.mainCameraCom_.aspect / var_232_1.sprite.bounds.size.x or var_232_2 / var_232_1.sprite.bounds.size.y, var_232_2 / var_232_1.sprite.bounds.size.y < var_232_2 * manager.ui.mainCameraCom_.aspect / var_232_1.sprite.bounds.size.x and var_232_2 * manager.ui.mainCameraCom_.aspect / var_232_1.sprite.bounds.size.x or var_232_2 / var_232_1.sprite.bounds.size.y, 0)
				end

				for iter_232_0, iter_232_1 in pairs(arg_229_1.bgs_) do
					if iter_232_0 ~= "ST30" then
						iter_232_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_232_3 = 3.999999999999

			if 3.999999999999 < arg_229_1.time_ and arg_229_1.time_ <= var_232_3 + arg_232_0 then
				arg_229_1.allBtn_.enabled = false
			end

			if arg_229_1.time_ >= var_232_3 + 0.299999997018768 and arg_229_1.time_ < var_232_3 + 0.299999997018768 + arg_232_0 then
				arg_229_1.allBtn_.enabled = true
			end

			local var_232_4 = 0

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= var_232_4 + arg_232_0 then
				arg_229_1.mask_.enabled = true
				arg_229_1.mask_.raycastTarget = true

				arg_229_1:SetGaussion(false)
			end

			local var_232_5 = 2

			if var_232_4 <= arg_229_1.time_ and arg_229_1.time_ < var_232_4 + var_232_5 then
				local var_232_6 = Color.New(0, 0, 0)

				var_232_6.a = Mathf.Lerp(0, 1, (arg_229_1.time_ - var_232_4) / var_232_5)
				arg_229_1.mask_.color = var_232_6
			end

			if arg_229_1.time_ >= var_232_4 + var_232_5 and arg_229_1.time_ < var_232_4 + var_232_5 + arg_232_0 then
				local var_232_7 = Color.New(0, 0, 0)

				var_232_7.a = 1
				arg_229_1.mask_.color = var_232_7
			end

			local var_232_8 = 1.999999999999

			if 1.999999999999 < arg_229_1.time_ and arg_229_1.time_ <= var_232_8 + arg_232_0 then
				arg_229_1.mask_.enabled = true
				arg_229_1.mask_.raycastTarget = true

				arg_229_1:SetGaussion(false)
			end

			local var_232_9 = 2

			if var_232_8 <= arg_229_1.time_ and arg_229_1.time_ < var_232_8 + var_232_9 then
				local var_232_10 = Color.New(0, 0, 0)

				var_232_10.a = Mathf.Lerp(1, 0, (arg_229_1.time_ - var_232_8) / var_232_9)
				arg_229_1.mask_.color = var_232_10
			end

			if arg_229_1.time_ >= var_232_8 + var_232_9 and arg_229_1.time_ < var_232_8 + var_232_9 + arg_232_0 then
				local var_232_11 = Color.New(0, 0, 0)

				arg_229_1.mask_.enabled = false
				var_232_11.a = 0
				arg_229_1.mask_.color = var_232_11
			end

			local var_232_12 = arg_229_1.actors_["10078ui_story"].transform

			if 3.8 < arg_229_1.time_ and arg_229_1.time_ <= 3.8 + arg_232_0 then
				arg_229_1.var_.moveOldPos10078ui_story = var_232_12.localPosition
			end

			local var_232_13 = 0.001

			if 3.8 <= arg_229_1.time_ and arg_229_1.time_ < 3.8 + var_232_13 then
				var_232_12.localPosition = Vector3.Lerp(arg_229_1.var_.moveOldPos10078ui_story, Vector3.New(0, -0.5, -6.3), (arg_229_1.time_ - 3.8) / var_232_13)
				var_232_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_232_12.position).x, (manager.ui.mainCamera.transform.position - var_232_12.position).y, (manager.ui.mainCamera.transform.position - var_232_12.position).z)
				var_232_12.localEulerAngles.z = 0
				var_232_12.localEulerAngles.x = 0
				var_232_12.localEulerAngles = var_232_12.localEulerAngles
			end

			if arg_229_1.time_ >= 3.8 + var_232_13 and arg_229_1.time_ < 3.8 + var_232_13 + arg_232_0 then
				var_232_12.localPosition = Vector3.New(0, -0.5, -6.3)
				var_232_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_232_12.position).x, (manager.ui.mainCamera.transform.position - var_232_12.position).y, (manager.ui.mainCamera.transform.position - var_232_12.position).z)
				var_232_12.localEulerAngles.z = 0
				var_232_12.localEulerAngles.x = 0
				var_232_12.localEulerAngles = var_232_12.localEulerAngles
			end

			local var_232_14 = arg_229_1.actors_["10078ui_story"]

			if 3.8 < arg_229_1.time_ and arg_229_1.time_ <= 3.8 + arg_232_0 and not isNil(var_232_14) and arg_229_1.var_.characterEffect10078ui_story == nil then
				arg_229_1.var_.characterEffect10078ui_story = var_232_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_232_15 = 0.200000002980232

			if 3.8 <= arg_229_1.time_ and arg_229_1.time_ < 3.8 + var_232_15 and not isNil(var_232_14) then
				if arg_229_1.var_.characterEffect10078ui_story and not isNil(var_232_14) then
					arg_229_1.var_.characterEffect10078ui_story.fillFlat = false
				end
			end

			if arg_229_1.time_ >= 3.8 + var_232_15 and arg_229_1.time_ < 3.8 + var_232_15 + arg_232_0 and not isNil(var_232_14) and arg_229_1.var_.characterEffect10078ui_story then
				arg_229_1.var_.characterEffect10078ui_story.fillFlat = false
			end

			if 3.8 < arg_229_1.time_ and arg_229_1.time_ <= 3.8 + arg_232_0 then
				arg_229_1:PlayTimeline("10078ui_story", "StoryTimeline/CharAction/story6046/story6046action/6046action4_1")
			end

			if 3.8 < arg_229_1.time_ and arg_229_1.time_ <= 3.8 + arg_232_0 then
				arg_229_1:PlayTimeline("10078ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_232_17 = arg_229_1.actors_["1097ui_story"].transform

			if 1.966 < arg_229_1.time_ and arg_229_1.time_ <= 1.966 + arg_232_0 then
				arg_229_1.var_.moveOldPos1097ui_story = var_232_17.localPosition
			end

			local var_232_18 = 0.001

			if 1.966 <= arg_229_1.time_ and arg_229_1.time_ < 1.966 + var_232_18 then
				var_232_17.localPosition = Vector3.Lerp(arg_229_1.var_.moveOldPos1097ui_story, Vector3.New(0, 100, 0), (arg_229_1.time_ - 1.966) / var_232_18)
				var_232_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_232_17.position).x, (manager.ui.mainCamera.transform.position - var_232_17.position).y, (manager.ui.mainCamera.transform.position - var_232_17.position).z)
				var_232_17.localEulerAngles.z = 0
				var_232_17.localEulerAngles.x = 0
				var_232_17.localEulerAngles = var_232_17.localEulerAngles
			end

			if arg_229_1.time_ >= 1.966 + var_232_18 and arg_229_1.time_ < 1.966 + var_232_18 + arg_232_0 then
				var_232_17.localPosition = Vector3.New(0, 100, 0)
				var_232_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_232_17.position).x, (manager.ui.mainCamera.transform.position - var_232_17.position).y, (manager.ui.mainCamera.transform.position - var_232_17.position).z)
				var_232_17.localEulerAngles.z = 0
				var_232_17.localEulerAngles.x = 0
				var_232_17.localEulerAngles = var_232_17.localEulerAngles
			end

			local var_232_19 = arg_229_1.actors_["10083ui_story"].transform

			if 1.966 < arg_229_1.time_ and arg_229_1.time_ <= 1.966 + arg_232_0 then
				arg_229_1.var_.moveOldPos10083ui_story = var_232_19.localPosition
			end

			local var_232_20 = 0.001

			if 1.966 <= arg_229_1.time_ and arg_229_1.time_ < 1.966 + var_232_20 then
				var_232_19.localPosition = Vector3.Lerp(arg_229_1.var_.moveOldPos10083ui_story, Vector3.New(0, 100, 0), (arg_229_1.time_ - 1.966) / var_232_20)
				var_232_19.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_232_19.position).x, (manager.ui.mainCamera.transform.position - var_232_19.position).y, (manager.ui.mainCamera.transform.position - var_232_19.position).z)
				var_232_19.localEulerAngles.z = 0
				var_232_19.localEulerAngles.x = 0
				var_232_19.localEulerAngles = var_232_19.localEulerAngles
			end

			if arg_229_1.time_ >= 1.966 + var_232_20 and arg_229_1.time_ < 1.966 + var_232_20 + arg_232_0 then
				var_232_19.localPosition = Vector3.New(0, 100, 0)
				var_232_19.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_232_19.position).x, (manager.ui.mainCamera.transform.position - var_232_19.position).y, (manager.ui.mainCamera.transform.position - var_232_19.position).z)
				var_232_19.localEulerAngles.z = 0
				var_232_19.localEulerAngles.x = 0
				var_232_19.localEulerAngles = var_232_19.localEulerAngles
			end

			if arg_229_1.frameCnt_ <= 1 then
				arg_229_1.dialog_:SetActive(false)
			end

			local var_232_21 = 3.999999999999
			local var_232_22 = 0.2

			if 3.999999999999 < arg_229_1.time_ and arg_229_1.time_ <= var_232_21 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0

				arg_229_1.dialog_:SetActive(true)

				arg_229_1.dialogCg_.alpha = 0

				local var_232_23 = LeanTween.value(arg_229_1.dialog_, 0, 1, 0.3)

				var_232_23:setOnUpdate(LuaHelper.FloatAction(function(arg_233_0)
					arg_229_1.dialogCg_.alpha = arg_233_0
				end))
				var_232_23:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_229_1.dialog_)
					var_232_23:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_229_1.duration_ = arg_229_1.duration_ + 0.3

				SetActive(arg_229_1.leftNameGo_, true)

				arg_229_1.leftNameTxt_.text = arg_229_1:FormatText(StoryNameCfg[919].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_24 = arg_229_1:GetWordFromCfg(412031055)
				local var_232_25 = arg_229_1:FormatText(var_232_24.content)

				arg_229_1.text_.text = var_232_25

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_27 = 8 <= 0 and var_232_22 or var_232_22 * (utf8.len(var_232_25) / 8)

				if (8 <= 0 and var_232_22 or var_232_22 * (utf8.len(var_232_25) / 8)) > 0 and var_232_22 < var_232_27 then
					arg_229_1.talkMaxDuration = var_232_27
					var_232_21 = var_232_21 + 0.3

					if var_232_27 + var_232_21 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_27 + var_232_21
					end
				end

				arg_229_1.text_.text = var_232_25
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031055", "story_v_out_412031.awb") ~= 0 then
					local var_232_28 = manager.audio:GetVoiceLength("story_v_out_412031", "412031055", "story_v_out_412031.awb") / 1000

					if var_232_28 + var_232_21 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_28 + var_232_21
					end

					if var_232_24.prefab_name ~= "" and arg_229_1.actors_[var_232_24.prefab_name] ~= nil then
						local var_232_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_229_1.actors_[var_232_24.prefab_name].transform, "story_v_out_412031", "412031055", "story_v_out_412031.awb")

						arg_229_1:RecordAudio("412031055", var_232_29)
						arg_229_1:RecordAudio("412031055", var_232_29)
					else
						arg_229_1:AudioAction("play", "voice", "story_v_out_412031", "412031055", "story_v_out_412031.awb")
					end

					arg_229_1:RecordHistoryTalkVoice("story_v_out_412031", "412031055", "story_v_out_412031.awb")
				end

				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_30 = var_232_21 + 0.3
			local var_232_31 = math.max(var_232_22, arg_229_1.talkMaxDuration)

			if var_232_21 + 0.3 <= arg_229_1.time_ and arg_229_1.time_ < var_232_30 + var_232_31 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_30) / var_232_31

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_30 + var_232_31 and arg_229_1.time_ < var_232_30 + var_232_31 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10083ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_229_1:InitPlayNodeList()
	end,
	Play412031056 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 412031056
		arg_235_1.duration_ = 5

		SetActive(arg_235_1.tipsGo_, false)

		function arg_235_1.onSingleLineFinish_()
			arg_235_1.onSingleLineUpdate_ = nil
			arg_235_1.onSingleLineFinish_ = nil
			arg_235_1.state_ = "waiting"
		end

		function arg_235_1.playNext_(arg_237_0)
			if arg_237_0 == 1 then
				arg_235_0:Play412031057(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 then
				arg_235_1.var_.moveOldPos10078ui_story = arg_235_1.actors_["10078ui_story"].transform.localPosition
			end

			local var_238_0 = 0.001

			if 0 <= arg_235_1.time_ and arg_235_1.time_ < 0 + var_238_0 then
				arg_235_1.actors_["10078ui_story"].transform.localPosition = Vector3.Lerp(arg_235_1.var_.moveOldPos10078ui_story, Vector3.New(0, 100, 0), (arg_235_1.time_ - 0) / var_238_0)
				arg_235_1.actors_["10078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_235_1.actors_["10078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_235_1.actors_["10078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_235_1.actors_["10078ui_story"].transform.position).z)
				arg_235_1.actors_["10078ui_story"].transform.localEulerAngles.z = 0
				arg_235_1.actors_["10078ui_story"].transform.localEulerAngles.x = 0
				arg_235_1.actors_["10078ui_story"].transform.localEulerAngles = arg_235_1.actors_["10078ui_story"].transform.localEulerAngles
			end

			if arg_235_1.time_ >= 0 + var_238_0 and arg_235_1.time_ < 0 + var_238_0 + arg_238_0 then
				arg_235_1.actors_["10078ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_235_1.actors_["10078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_235_1.actors_["10078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_235_1.actors_["10078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_235_1.actors_["10078ui_story"].transform.position).z)
				arg_235_1.actors_["10078ui_story"].transform.localEulerAngles.z = 0
				arg_235_1.actors_["10078ui_story"].transform.localEulerAngles.x = 0
				arg_235_1.actors_["10078ui_story"].transform.localEulerAngles = arg_235_1.actors_["10078ui_story"].transform.localEulerAngles
			end

			local var_238_1 = arg_235_1.actors_["10078ui_story"]

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 and not isNil(var_238_1) and arg_235_1.var_.characterEffect10078ui_story == nil then
				arg_235_1.var_.characterEffect10078ui_story = var_238_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_238_2 = 0.200000002980232

			if 0 <= arg_235_1.time_ and arg_235_1.time_ < 0 + var_238_2 and not isNil(var_238_1) then
				if arg_235_1.var_.characterEffect10078ui_story and not isNil(var_238_1) then
					arg_235_1.var_.characterEffect10078ui_story.fillFlat = true
					arg_235_1.var_.characterEffect10078ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_235_1.time_ - 0) / var_238_2)
				end
			end

			if arg_235_1.time_ >= 0 + var_238_2 and arg_235_1.time_ < 0 + var_238_2 + arg_238_0 and not isNil(var_238_1) and arg_235_1.var_.characterEffect10078ui_story then
				arg_235_1.var_.characterEffect10078ui_story.fillFlat = true
				arg_235_1.var_.characterEffect10078ui_story.fillRatio = 0.5
			end

			local var_238_3 = 0
			local var_238_4 = 1.35

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= var_238_3 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, false)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_235_1.iconTrs_.gameObject, false)
				arg_235_1.callingController_:SetSelectedState("normal")

				local var_238_5 = arg_235_1:FormatText(arg_235_1:GetWordFromCfg(412031056).content)

				arg_235_1.text_.text = var_238_5

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_7 = 54 <= 0 and var_238_4 or var_238_4 * (utf8.len(var_238_5) / 54)

				if (54 <= 0 and var_238_4 or var_238_4 * (utf8.len(var_238_5) / 54)) > 0 and var_238_4 < var_238_7 then
					arg_235_1.talkMaxDuration = var_238_7

					if var_238_7 + var_238_3 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_7 + var_238_3
					end
				end

				arg_235_1.text_.text = var_238_5
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)
				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_8 = math.max(var_238_4, arg_235_1.talkMaxDuration)

			if var_238_3 <= arg_235_1.time_ and arg_235_1.time_ < var_238_3 + var_238_8 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_3) / var_238_8

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_3 + var_238_8 and arg_235_1.time_ < var_238_3 + var_238_8 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_235_1:InitPlayNodeList()
	end,
	Play412031057 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 412031057
		arg_239_1.duration_ = 5

		SetActive(arg_239_1.tipsGo_, false)

		function arg_239_1.onSingleLineFinish_()
			arg_239_1.onSingleLineUpdate_ = nil
			arg_239_1.onSingleLineFinish_ = nil
			arg_239_1.state_ = "waiting"
		end

		function arg_239_1.playNext_(arg_241_0)
			if arg_241_0 == 1 then
				arg_239_0:Play412031058(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			local var_242_0 = 0.925

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, false)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_239_1.iconTrs_.gameObject, false)
				arg_239_1.callingController_:SetSelectedState("normal")

				local var_242_1 = arg_239_1:FormatText(arg_239_1:GetWordFromCfg(412031057).content)

				arg_239_1.text_.text = var_242_1

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_3 = 37 <= 0 and var_242_0 or var_242_0 * (utf8.len(var_242_1) / 37)

				if (37 <= 0 and var_242_0 or var_242_0 * (utf8.len(var_242_1) / 37)) > 0 and var_242_0 < var_242_3 then
					arg_239_1.talkMaxDuration = var_242_3

					if var_242_3 + 0 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_3 + 0
					end
				end

				arg_239_1.text_.text = var_242_1
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)
				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_4 = math.max(var_242_0, arg_239_1.talkMaxDuration)

			if 0 <= arg_239_1.time_ and arg_239_1.time_ < 0 + var_242_4 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - 0) / var_242_4

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= 0 + var_242_4 and arg_239_1.time_ < 0 + var_242_4 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {}

		arg_239_1:InitPlayNodeList()
	end,
	Play412031058 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 412031058
		arg_243_1.duration_ = 5

		SetActive(arg_243_1.tipsGo_, false)

		function arg_243_1.onSingleLineFinish_()
			arg_243_1.onSingleLineUpdate_ = nil
			arg_243_1.onSingleLineFinish_ = nil
			arg_243_1.state_ = "waiting"
		end

		function arg_243_1.playNext_(arg_245_0)
			if arg_245_0 == 1 then
				arg_243_0:Play412031059(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			local var_246_0 = 0.675

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, false)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_243_1.iconTrs_.gameObject, false)
				arg_243_1.callingController_:SetSelectedState("normal")

				local var_246_1 = arg_243_1:FormatText(arg_243_1:GetWordFromCfg(412031058).content)

				arg_243_1.text_.text = var_246_1

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_3 = 27 <= 0 and var_246_0 or var_246_0 * (utf8.len(var_246_1) / 27)

				if (27 <= 0 and var_246_0 or var_246_0 * (utf8.len(var_246_1) / 27)) > 0 and var_246_0 < var_246_3 then
					arg_243_1.talkMaxDuration = var_246_3

					if var_246_3 + 0 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_3 + 0
					end
				end

				arg_243_1.text_.text = var_246_1
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)
				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_4 = math.max(var_246_0, arg_243_1.talkMaxDuration)

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_4 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - 0) / var_246_4

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= 0 + var_246_4 and arg_243_1.time_ < 0 + var_246_4 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {}

		arg_243_1:InitPlayNodeList()
	end,
	Play412031059 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 412031059
		arg_247_1.duration_ = 11.03

		local var_247_0 = {
			zh = 5.5,
			ja = 11.033
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
				arg_247_0:Play412031060(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 then
				arg_247_1.var_.moveOldPos10078ui_story = arg_247_1.actors_["10078ui_story"].transform.localPosition
			end

			local var_250_0 = 0.001

			if 0 <= arg_247_1.time_ and arg_247_1.time_ < 0 + var_250_0 then
				arg_247_1.actors_["10078ui_story"].transform.localPosition = Vector3.Lerp(arg_247_1.var_.moveOldPos10078ui_story, Vector3.New(0, -0.5, -6.3), (arg_247_1.time_ - 0) / var_250_0)
				arg_247_1.actors_["10078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_247_1.actors_["10078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_247_1.actors_["10078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_247_1.actors_["10078ui_story"].transform.position).z)
				arg_247_1.actors_["10078ui_story"].transform.localEulerAngles.z = 0
				arg_247_1.actors_["10078ui_story"].transform.localEulerAngles.x = 0
				arg_247_1.actors_["10078ui_story"].transform.localEulerAngles = arg_247_1.actors_["10078ui_story"].transform.localEulerAngles
			end

			if arg_247_1.time_ >= 0 + var_250_0 and arg_247_1.time_ < 0 + var_250_0 + arg_250_0 then
				arg_247_1.actors_["10078ui_story"].transform.localPosition = Vector3.New(0, -0.5, -6.3)
				arg_247_1.actors_["10078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_247_1.actors_["10078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_247_1.actors_["10078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_247_1.actors_["10078ui_story"].transform.position).z)
				arg_247_1.actors_["10078ui_story"].transform.localEulerAngles.z = 0
				arg_247_1.actors_["10078ui_story"].transform.localEulerAngles.x = 0
				arg_247_1.actors_["10078ui_story"].transform.localEulerAngles = arg_247_1.actors_["10078ui_story"].transform.localEulerAngles
			end

			local var_250_1 = arg_247_1.actors_["10078ui_story"]

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 and not isNil(var_250_1) and arg_247_1.var_.characterEffect10078ui_story == nil then
				arg_247_1.var_.characterEffect10078ui_story = var_250_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_250_2 = 0.200000002980232

			if 0 <= arg_247_1.time_ and arg_247_1.time_ < 0 + var_250_2 and not isNil(var_250_1) then
				if arg_247_1.var_.characterEffect10078ui_story and not isNil(var_250_1) then
					arg_247_1.var_.characterEffect10078ui_story.fillFlat = false
				end
			end

			if arg_247_1.time_ >= 0 + var_250_2 and arg_247_1.time_ < 0 + var_250_2 + arg_250_0 and not isNil(var_250_1) and arg_247_1.var_.characterEffect10078ui_story then
				arg_247_1.var_.characterEffect10078ui_story.fillFlat = false
			end

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 then
				arg_247_1:PlayTimeline("10078ui_story", "StoryTimeline/CharAction/story6046/story6046action/6046action4_2")
			end

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 then
				arg_247_1:PlayTimeline("10078ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_250_4 = 0
			local var_250_5 = 0.375

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= var_250_4 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				arg_247_1.leftNameTxt_.text = arg_247_1:FormatText(StoryNameCfg[919].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, false)
				arg_247_1.callingController_:SetSelectedState("normal")

				local var_250_6 = arg_247_1:GetWordFromCfg(412031059)
				local var_250_7 = arg_247_1:FormatText(var_250_6.content)

				arg_247_1.text_.text = var_250_7

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_9 = 15 <= 0 and var_250_5 or var_250_5 * (utf8.len(var_250_7) / 15)

				if (15 <= 0 and var_250_5 or var_250_5 * (utf8.len(var_250_7) / 15)) > 0 and var_250_5 < var_250_9 then
					arg_247_1.talkMaxDuration = var_250_9

					if var_250_9 + var_250_4 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_9 + var_250_4
					end
				end

				arg_247_1.text_.text = var_250_7
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031059", "story_v_out_412031.awb") ~= 0 then
					local var_250_10 = manager.audio:GetVoiceLength("story_v_out_412031", "412031059", "story_v_out_412031.awb") / 1000

					if var_250_10 + var_250_4 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_10 + var_250_4
					end

					if var_250_6.prefab_name ~= "" and arg_247_1.actors_[var_250_6.prefab_name] ~= nil then
						local var_250_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_247_1.actors_[var_250_6.prefab_name].transform, "story_v_out_412031", "412031059", "story_v_out_412031.awb")

						arg_247_1:RecordAudio("412031059", var_250_11)
						arg_247_1:RecordAudio("412031059", var_250_11)
					else
						arg_247_1:AudioAction("play", "voice", "story_v_out_412031", "412031059", "story_v_out_412031.awb")
					end

					arg_247_1:RecordHistoryTalkVoice("story_v_out_412031", "412031059", "story_v_out_412031.awb")
				end

				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_12 = math.max(var_250_5, arg_247_1.talkMaxDuration)

			if var_250_4 <= arg_247_1.time_ and arg_247_1.time_ < var_250_4 + var_250_12 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_4) / var_250_12

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_4 + var_250_12 and arg_247_1.time_ < var_250_4 + var_250_12 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_247_1:InitPlayNodeList()
	end,
	Play412031060 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 412031060
		arg_251_1.duration_ = 5

		SetActive(arg_251_1.tipsGo_, false)

		function arg_251_1.onSingleLineFinish_()
			arg_251_1.onSingleLineUpdate_ = nil
			arg_251_1.onSingleLineFinish_ = nil
			arg_251_1.state_ = "waiting"
		end

		function arg_251_1.playNext_(arg_253_0)
			if arg_253_0 == 1 then
				arg_251_0:Play412031061(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 then
				arg_251_1.var_.moveOldPos10078ui_story = arg_251_1.actors_["10078ui_story"].transform.localPosition
			end

			local var_254_0 = 0.001

			if 0 <= arg_251_1.time_ and arg_251_1.time_ < 0 + var_254_0 then
				arg_251_1.actors_["10078ui_story"].transform.localPosition = Vector3.Lerp(arg_251_1.var_.moveOldPos10078ui_story, Vector3.New(0, 100, 0), (arg_251_1.time_ - 0) / var_254_0)
				arg_251_1.actors_["10078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_251_1.actors_["10078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_251_1.actors_["10078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_251_1.actors_["10078ui_story"].transform.position).z)
				arg_251_1.actors_["10078ui_story"].transform.localEulerAngles.z = 0
				arg_251_1.actors_["10078ui_story"].transform.localEulerAngles.x = 0
				arg_251_1.actors_["10078ui_story"].transform.localEulerAngles = arg_251_1.actors_["10078ui_story"].transform.localEulerAngles
			end

			if arg_251_1.time_ >= 0 + var_254_0 and arg_251_1.time_ < 0 + var_254_0 + arg_254_0 then
				arg_251_1.actors_["10078ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_251_1.actors_["10078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_251_1.actors_["10078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_251_1.actors_["10078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_251_1.actors_["10078ui_story"].transform.position).z)
				arg_251_1.actors_["10078ui_story"].transform.localEulerAngles.z = 0
				arg_251_1.actors_["10078ui_story"].transform.localEulerAngles.x = 0
				arg_251_1.actors_["10078ui_story"].transform.localEulerAngles = arg_251_1.actors_["10078ui_story"].transform.localEulerAngles
			end

			local var_254_1 = arg_251_1.actors_["10078ui_story"]

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 and not isNil(var_254_1) and arg_251_1.var_.characterEffect10078ui_story == nil then
				arg_251_1.var_.characterEffect10078ui_story = var_254_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_254_2 = 0.200000002980232

			if 0 <= arg_251_1.time_ and arg_251_1.time_ < 0 + var_254_2 and not isNil(var_254_1) then
				if arg_251_1.var_.characterEffect10078ui_story and not isNil(var_254_1) then
					arg_251_1.var_.characterEffect10078ui_story.fillFlat = true
					arg_251_1.var_.characterEffect10078ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_251_1.time_ - 0) / var_254_2)
				end
			end

			if arg_251_1.time_ >= 0 + var_254_2 and arg_251_1.time_ < 0 + var_254_2 + arg_254_0 and not isNil(var_254_1) and arg_251_1.var_.characterEffect10078ui_story then
				arg_251_1.var_.characterEffect10078ui_story.fillFlat = true
				arg_251_1.var_.characterEffect10078ui_story.fillRatio = 0.5
			end

			local var_254_3 = 0
			local var_254_4 = 0.725

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= var_254_3 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, false)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_251_1.iconTrs_.gameObject, false)
				arg_251_1.callingController_:SetSelectedState("normal")

				local var_254_5 = arg_251_1:FormatText(arg_251_1:GetWordFromCfg(412031060).content)

				arg_251_1.text_.text = var_254_5

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_7 = 29 <= 0 and var_254_4 or var_254_4 * (utf8.len(var_254_5) / 29)

				if (29 <= 0 and var_254_4 or var_254_4 * (utf8.len(var_254_5) / 29)) > 0 and var_254_4 < var_254_7 then
					arg_251_1.talkMaxDuration = var_254_7

					if var_254_7 + var_254_3 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_7 + var_254_3
					end
				end

				arg_251_1.text_.text = var_254_5
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)
				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_8 = math.max(var_254_4, arg_251_1.talkMaxDuration)

			if var_254_3 <= arg_251_1.time_ and arg_251_1.time_ < var_254_3 + var_254_8 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - var_254_3) / var_254_8

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= var_254_3 + var_254_8 and arg_251_1.time_ < var_254_3 + var_254_8 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_251_1:InitPlayNodeList()
	end,
	Play412031061 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 412031061
		arg_255_1.duration_ = 5

		SetActive(arg_255_1.tipsGo_, false)

		function arg_255_1.onSingleLineFinish_()
			arg_255_1.onSingleLineUpdate_ = nil
			arg_255_1.onSingleLineFinish_ = nil
			arg_255_1.state_ = "waiting"
		end

		function arg_255_1.playNext_(arg_257_0)
			if arg_257_0 == 1 then
				arg_255_0:Play412031062(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			local var_258_0 = 0
			local var_258_1 = 0.55

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= var_258_0 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0

				arg_255_1.dialog_:SetActive(true)

				arg_255_1.dialogCg_.alpha = 0

				local var_258_2 = LeanTween.value(arg_255_1.dialog_, 0, 1, 0.3)

				var_258_2:setOnUpdate(LuaHelper.FloatAction(function(arg_259_0)
					arg_255_1.dialogCg_.alpha = arg_259_0
				end))
				var_258_2:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_255_1.dialog_)
					var_258_2:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_255_1.duration_ = arg_255_1.duration_ + 0.3

				SetActive(arg_255_1.leftNameGo_, false)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_255_1.iconTrs_.gameObject, false)
				arg_255_1.callingController_:SetSelectedState("normal")

				local var_258_3 = arg_255_1:FormatText(arg_255_1:GetWordFromCfg(412031061).content)

				arg_255_1.text_.text = var_258_3

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_5 = 22 <= 0 and var_258_1 or var_258_1 * (utf8.len(var_258_3) / 22)

				if (22 <= 0 and var_258_1 or var_258_1 * (utf8.len(var_258_3) / 22)) > 0 and var_258_1 < var_258_5 then
					arg_255_1.talkMaxDuration = var_258_5
					var_258_0 = var_258_0 + 0.3

					if var_258_5 + var_258_0 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_5 + var_258_0
					end
				end

				arg_255_1.text_.text = var_258_3
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)
				arg_255_1:RecordContent(arg_255_1.text_.text)
			end

			local var_258_6 = var_258_0 + 0.3
			local var_258_7 = math.max(var_258_1, arg_255_1.talkMaxDuration)

			if var_258_0 + 0.3 <= arg_255_1.time_ and arg_255_1.time_ < var_258_6 + var_258_7 then
				arg_255_1.typewritter.percent = (arg_255_1.time_ - var_258_6) / var_258_7

				arg_255_1.typewritter:SetDirty()
			end

			if arg_255_1.time_ >= var_258_6 + var_258_7 and arg_255_1.time_ < var_258_6 + var_258_7 + arg_258_0 then
				arg_255_1.typewritter.percent = 1

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(true)
			end
		end

		arg_255_1.nodeConfigList_ = {}

		arg_255_1:InitPlayNodeList()
	end,
	Play412031062 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 412031062
		arg_261_1.duration_ = 13.93

		local var_261_0 = {
			zh = 12.166,
			ja = 13.933
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
				arg_261_0:Play412031063(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			if 2.00000000298023 < arg_261_1.time_ and arg_261_1.time_ <= 2.00000000298023 + arg_264_0 then
				local var_264_0 = arg_261_1.bgs_.ST30

				arg_261_1.bgs_.ST30.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_264_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_264_1 = var_264_0:GetComponent("SpriteRenderer")

				if var_264_1 and var_264_1.sprite then
					local var_264_2 = 2 * (var_264_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_264_0.transform.localScale = Vector3.New(var_264_2 / var_264_1.sprite.bounds.size.y < var_264_2 * manager.ui.mainCameraCom_.aspect / var_264_1.sprite.bounds.size.x and var_264_2 * manager.ui.mainCameraCom_.aspect / var_264_1.sprite.bounds.size.x or var_264_2 / var_264_1.sprite.bounds.size.y, var_264_2 / var_264_1.sprite.bounds.size.y < var_264_2 * manager.ui.mainCameraCom_.aspect / var_264_1.sprite.bounds.size.x and var_264_2 * manager.ui.mainCameraCom_.aspect / var_264_1.sprite.bounds.size.x or var_264_2 / var_264_1.sprite.bounds.size.y, 0)
				end

				for iter_264_0, iter_264_1 in pairs(arg_261_1.bgs_) do
					if iter_264_0 ~= "ST30" then
						iter_264_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_264_3 = 4.00000000298023

			if 4.00000000298023 < arg_261_1.time_ and arg_261_1.time_ <= var_264_3 + arg_264_0 then
				arg_261_1.allBtn_.enabled = false
			end

			if arg_261_1.time_ >= var_264_3 + 0.3 and arg_261_1.time_ < var_264_3 + 0.3 + arg_264_0 then
				arg_261_1.allBtn_.enabled = true
			end

			local var_264_4 = 0

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= var_264_4 + arg_264_0 then
				arg_261_1.mask_.enabled = true
				arg_261_1.mask_.raycastTarget = true

				arg_261_1:SetGaussion(false)
			end

			local var_264_5 = 2

			if var_264_4 <= arg_261_1.time_ and arg_261_1.time_ < var_264_4 + var_264_5 then
				local var_264_6 = Color.New(0, 0, 0)

				var_264_6.a = Mathf.Lerp(0, 1, (arg_261_1.time_ - var_264_4) / var_264_5)
				arg_261_1.mask_.color = var_264_6
			end

			if arg_261_1.time_ >= var_264_4 + var_264_5 and arg_261_1.time_ < var_264_4 + var_264_5 + arg_264_0 then
				local var_264_7 = Color.New(0, 0, 0)

				var_264_7.a = 1
				arg_261_1.mask_.color = var_264_7
			end

			local var_264_8 = 2

			if 2 < arg_261_1.time_ and arg_261_1.time_ <= var_264_8 + arg_264_0 then
				arg_261_1.mask_.enabled = true
				arg_261_1.mask_.raycastTarget = true

				arg_261_1:SetGaussion(false)
			end

			local var_264_9 = 2

			if var_264_8 <= arg_261_1.time_ and arg_261_1.time_ < var_264_8 + var_264_9 then
				local var_264_10 = Color.New(0, 0, 0)

				var_264_10.a = Mathf.Lerp(1, 0, (arg_261_1.time_ - var_264_8) / var_264_9)
				arg_261_1.mask_.color = var_264_10
			end

			if arg_261_1.time_ >= var_264_8 + var_264_9 and arg_261_1.time_ < var_264_8 + var_264_9 + arg_264_0 then
				local var_264_11 = Color.New(0, 0, 0)

				arg_261_1.mask_.enabled = false
				var_264_11.a = 0
				arg_261_1.mask_.color = var_264_11
			end

			local var_264_12 = arg_261_1.actors_["10083ui_story"].transform

			if 3.8 < arg_261_1.time_ and arg_261_1.time_ <= 3.8 + arg_264_0 then
				arg_261_1.var_.moveOldPos10083ui_story = var_264_12.localPosition
			end

			local var_264_13 = 0.001

			if 3.8 <= arg_261_1.time_ and arg_261_1.time_ < 3.8 + var_264_13 then
				var_264_12.localPosition = Vector3.Lerp(arg_261_1.var_.moveOldPos10083ui_story, Vector3.New(0, -2.6, -2.8), (arg_261_1.time_ - 3.8) / var_264_13)
				var_264_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_264_12.position).x, (manager.ui.mainCamera.transform.position - var_264_12.position).y, (manager.ui.mainCamera.transform.position - var_264_12.position).z)
				var_264_12.localEulerAngles.z = 0
				var_264_12.localEulerAngles.x = 0
				var_264_12.localEulerAngles = var_264_12.localEulerAngles
			end

			if arg_261_1.time_ >= 3.8 + var_264_13 and arg_261_1.time_ < 3.8 + var_264_13 + arg_264_0 then
				var_264_12.localPosition = Vector3.New(0, -2.6, -2.8)
				var_264_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_264_12.position).x, (manager.ui.mainCamera.transform.position - var_264_12.position).y, (manager.ui.mainCamera.transform.position - var_264_12.position).z)
				var_264_12.localEulerAngles.z = 0
				var_264_12.localEulerAngles.x = 0
				var_264_12.localEulerAngles = var_264_12.localEulerAngles
			end

			local var_264_14 = arg_261_1.actors_["10083ui_story"]

			if 3.8 < arg_261_1.time_ and arg_261_1.time_ <= 3.8 + arg_264_0 and not isNil(var_264_14) and arg_261_1.var_.characterEffect10083ui_story == nil then
				arg_261_1.var_.characterEffect10083ui_story = var_264_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_264_15 = 0.200000002980232

			if 3.8 <= arg_261_1.time_ and arg_261_1.time_ < 3.8 + var_264_15 and not isNil(var_264_14) then
				if arg_261_1.var_.characterEffect10083ui_story and not isNil(var_264_14) then
					arg_261_1.var_.characterEffect10083ui_story.fillFlat = false
				end
			end

			if arg_261_1.time_ >= 3.8 + var_264_15 and arg_261_1.time_ < 3.8 + var_264_15 + arg_264_0 and not isNil(var_264_14) and arg_261_1.var_.characterEffect10083ui_story then
				arg_261_1.var_.characterEffect10083ui_story.fillFlat = false
			end

			if 3.8 < arg_261_1.time_ and arg_261_1.time_ <= 3.8 + arg_264_0 then
				arg_261_1:PlayTimeline("10083ui_story", "StoryTimeline/CharAction/story10083/story10083action/10083action4_1")
			end

			if 3.8 < arg_261_1.time_ and arg_261_1.time_ <= 3.8 + arg_264_0 then
				arg_261_1:PlayTimeline("10083ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_264_17 = arg_261_1.actors_["10078ui_story"].transform

			if 1.96599999815226 < arg_261_1.time_ and arg_261_1.time_ <= 1.96599999815226 + arg_264_0 then
				arg_261_1.var_.moveOldPos10078ui_story = var_264_17.localPosition
			end

			local var_264_18 = 0.001

			if 1.96599999815226 <= arg_261_1.time_ and arg_261_1.time_ < 1.96599999815226 + var_264_18 then
				var_264_17.localPosition = Vector3.Lerp(arg_261_1.var_.moveOldPos10078ui_story, Vector3.New(0, 100, 0), (arg_261_1.time_ - 1.96599999815226) / var_264_18)
				var_264_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_264_17.position).x, (manager.ui.mainCamera.transform.position - var_264_17.position).y, (manager.ui.mainCamera.transform.position - var_264_17.position).z)
				var_264_17.localEulerAngles.z = 0
				var_264_17.localEulerAngles.x = 0
				var_264_17.localEulerAngles = var_264_17.localEulerAngles
			end

			if arg_261_1.time_ >= 1.96599999815226 + var_264_18 and arg_261_1.time_ < 1.96599999815226 + var_264_18 + arg_264_0 then
				var_264_17.localPosition = Vector3.New(0, 100, 0)
				var_264_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_264_17.position).x, (manager.ui.mainCamera.transform.position - var_264_17.position).y, (manager.ui.mainCamera.transform.position - var_264_17.position).z)
				var_264_17.localEulerAngles.z = 0
				var_264_17.localEulerAngles.x = 0
				var_264_17.localEulerAngles = var_264_17.localEulerAngles
			end

			if arg_261_1.frameCnt_ <= 1 then
				arg_261_1.dialog_:SetActive(false)
			end

			local var_264_19 = 4
			local var_264_20 = 0.875

			if 4 < arg_261_1.time_ and arg_261_1.time_ <= var_264_19 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0

				arg_261_1.dialog_:SetActive(true)

				arg_261_1.dialogCg_.alpha = 0

				local var_264_21 = LeanTween.value(arg_261_1.dialog_, 0, 1, 0.3)

				var_264_21:setOnUpdate(LuaHelper.FloatAction(function(arg_265_0)
					arg_261_1.dialogCg_.alpha = arg_265_0
				end))
				var_264_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_261_1.dialog_)
					var_264_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_261_1.duration_ = arg_261_1.duration_ + 0.3

				SetActive(arg_261_1.leftNameGo_, true)

				arg_261_1.leftNameTxt_.text = arg_261_1:FormatText(StoryNameCfg[918].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_22 = arg_261_1:GetWordFromCfg(412031062)
				local var_264_23 = arg_261_1:FormatText(var_264_22.content)

				arg_261_1.text_.text = var_264_23

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_25 = 35 <= 0 and var_264_20 or var_264_20 * (utf8.len(var_264_23) / 35)

				if (35 <= 0 and var_264_20 or var_264_20 * (utf8.len(var_264_23) / 35)) > 0 and var_264_20 < var_264_25 then
					arg_261_1.talkMaxDuration = var_264_25
					var_264_19 = var_264_19 + 0.3

					if var_264_25 + var_264_19 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_25 + var_264_19
					end
				end

				arg_261_1.text_.text = var_264_23
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031062", "story_v_out_412031.awb") ~= 0 then
					local var_264_26 = manager.audio:GetVoiceLength("story_v_out_412031", "412031062", "story_v_out_412031.awb") / 1000

					if var_264_26 + var_264_19 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_26 + var_264_19
					end

					if var_264_22.prefab_name ~= "" and arg_261_1.actors_[var_264_22.prefab_name] ~= nil then
						local var_264_27 = LuaForUtil.PlayVoiceWithCriLipsync(arg_261_1.actors_[var_264_22.prefab_name].transform, "story_v_out_412031", "412031062", "story_v_out_412031.awb")

						arg_261_1:RecordAudio("412031062", var_264_27)
						arg_261_1:RecordAudio("412031062", var_264_27)
					else
						arg_261_1:AudioAction("play", "voice", "story_v_out_412031", "412031062", "story_v_out_412031.awb")
					end

					arg_261_1:RecordHistoryTalkVoice("story_v_out_412031", "412031062", "story_v_out_412031.awb")
				end

				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_28 = var_264_19 + 0.3
			local var_264_29 = math.max(var_264_20, arg_261_1.talkMaxDuration)

			if var_264_19 + 0.3 <= arg_261_1.time_ and arg_261_1.time_ < var_264_28 + var_264_29 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_28) / var_264_29

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_28 + var_264_29 and arg_261_1.time_ < var_264_28 + var_264_29 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10083ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_261_1:InitPlayNodeList()
	end,
	Play412031063 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 412031063
		arg_267_1.duration_ = 5

		SetActive(arg_267_1.tipsGo_, false)

		function arg_267_1.onSingleLineFinish_()
			arg_267_1.onSingleLineUpdate_ = nil
			arg_267_1.onSingleLineFinish_ = nil
			arg_267_1.state_ = "waiting"
		end

		function arg_267_1.playNext_(arg_269_0)
			if arg_269_0 == 1 then
				arg_267_0:Play412031064(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 then
				arg_267_1.var_.moveOldPos10083ui_story = arg_267_1.actors_["10083ui_story"].transform.localPosition
			end

			local var_270_0 = 0.001

			if 0 <= arg_267_1.time_ and arg_267_1.time_ < 0 + var_270_0 then
				arg_267_1.actors_["10083ui_story"].transform.localPosition = Vector3.Lerp(arg_267_1.var_.moveOldPos10083ui_story, Vector3.New(0, 100, 0), (arg_267_1.time_ - 0) / var_270_0)
				arg_267_1.actors_["10083ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_267_1.actors_["10083ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_267_1.actors_["10083ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_267_1.actors_["10083ui_story"].transform.position).z)
				arg_267_1.actors_["10083ui_story"].transform.localEulerAngles.z = 0
				arg_267_1.actors_["10083ui_story"].transform.localEulerAngles.x = 0
				arg_267_1.actors_["10083ui_story"].transform.localEulerAngles = arg_267_1.actors_["10083ui_story"].transform.localEulerAngles
			end

			if arg_267_1.time_ >= 0 + var_270_0 and arg_267_1.time_ < 0 + var_270_0 + arg_270_0 then
				arg_267_1.actors_["10083ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_267_1.actors_["10083ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_267_1.actors_["10083ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_267_1.actors_["10083ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_267_1.actors_["10083ui_story"].transform.position).z)
				arg_267_1.actors_["10083ui_story"].transform.localEulerAngles.z = 0
				arg_267_1.actors_["10083ui_story"].transform.localEulerAngles.x = 0
				arg_267_1.actors_["10083ui_story"].transform.localEulerAngles = arg_267_1.actors_["10083ui_story"].transform.localEulerAngles
			end

			local var_270_1 = arg_267_1.actors_["10083ui_story"]

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 and not isNil(var_270_1) and arg_267_1.var_.characterEffect10083ui_story == nil then
				arg_267_1.var_.characterEffect10083ui_story = var_270_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_270_2 = 0.200000002980232

			if 0 <= arg_267_1.time_ and arg_267_1.time_ < 0 + var_270_2 and not isNil(var_270_1) then
				if arg_267_1.var_.characterEffect10083ui_story and not isNil(var_270_1) then
					arg_267_1.var_.characterEffect10083ui_story.fillFlat = true
					arg_267_1.var_.characterEffect10083ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_267_1.time_ - 0) / var_270_2)
				end
			end

			if arg_267_1.time_ >= 0 + var_270_2 and arg_267_1.time_ < 0 + var_270_2 + arg_270_0 and not isNil(var_270_1) and arg_267_1.var_.characterEffect10083ui_story then
				arg_267_1.var_.characterEffect10083ui_story.fillFlat = true
				arg_267_1.var_.characterEffect10083ui_story.fillRatio = 0.5
			end

			local var_270_3 = 0
			local var_270_4 = 1.475

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= var_270_3 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0
				arg_267_1.dialogCg_.alpha = 1

				arg_267_1.dialog_:SetActive(true)
				SetActive(arg_267_1.leftNameGo_, false)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_267_1.iconTrs_.gameObject, false)
				arg_267_1.callingController_:SetSelectedState("normal")

				local var_270_5 = arg_267_1:FormatText(arg_267_1:GetWordFromCfg(412031063).content)

				arg_267_1.text_.text = var_270_5

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_7 = 59 <= 0 and var_270_4 or var_270_4 * (utf8.len(var_270_5) / 59)

				if (59 <= 0 and var_270_4 or var_270_4 * (utf8.len(var_270_5) / 59)) > 0 and var_270_4 < var_270_7 then
					arg_267_1.talkMaxDuration = var_270_7

					if var_270_7 + var_270_3 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_7 + var_270_3
					end
				end

				arg_267_1.text_.text = var_270_5
				arg_267_1.typewritter.percent = 0

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(false)
				arg_267_1:RecordContent(arg_267_1.text_.text)
			end

			local var_270_8 = math.max(var_270_4, arg_267_1.talkMaxDuration)

			if var_270_3 <= arg_267_1.time_ and arg_267_1.time_ < var_270_3 + var_270_8 then
				arg_267_1.typewritter.percent = (arg_267_1.time_ - var_270_3) / var_270_8

				arg_267_1.typewritter:SetDirty()
			end

			if arg_267_1.time_ >= var_270_3 + var_270_8 and arg_267_1.time_ < var_270_3 + var_270_8 + arg_270_0 then
				arg_267_1.typewritter.percent = 1

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(true)
			end
		end

		arg_267_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10083ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_267_1:InitPlayNodeList()
	end,
	Play412031064 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 412031064
		arg_271_1.duration_ = 5

		SetActive(arg_271_1.tipsGo_, false)

		function arg_271_1.onSingleLineFinish_()
			arg_271_1.onSingleLineUpdate_ = nil
			arg_271_1.onSingleLineFinish_ = nil
			arg_271_1.state_ = "waiting"
		end

		function arg_271_1.playNext_(arg_273_0)
			if arg_273_0 == 1 then
				arg_271_0:Play412031065(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			local var_274_0 = 1.4

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, false)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_271_1.iconTrs_.gameObject, false)
				arg_271_1.callingController_:SetSelectedState("normal")

				local var_274_1 = arg_271_1:FormatText(arg_271_1:GetWordFromCfg(412031064).content)

				arg_271_1.text_.text = var_274_1

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_3 = 56 <= 0 and var_274_0 or var_274_0 * (utf8.len(var_274_1) / 56)

				if (56 <= 0 and var_274_0 or var_274_0 * (utf8.len(var_274_1) / 56)) > 0 and var_274_0 < var_274_3 then
					arg_271_1.talkMaxDuration = var_274_3

					if var_274_3 + 0 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_3 + 0
					end
				end

				arg_271_1.text_.text = var_274_1
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)
				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_4 = math.max(var_274_0, arg_271_1.talkMaxDuration)

			if 0 <= arg_271_1.time_ and arg_271_1.time_ < 0 + var_274_4 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - 0) / var_274_4

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= 0 + var_274_4 and arg_271_1.time_ < 0 + var_274_4 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {}

		arg_271_1:InitPlayNodeList()
	end,
	Play412031065 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 412031065
		arg_275_1.duration_ = 5

		SetActive(arg_275_1.tipsGo_, false)

		function arg_275_1.onSingleLineFinish_()
			arg_275_1.onSingleLineUpdate_ = nil
			arg_275_1.onSingleLineFinish_ = nil
			arg_275_1.state_ = "waiting"
		end

		function arg_275_1.playNext_(arg_277_0)
			if arg_277_0 == 1 then
				arg_275_0:Play412031066(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			local var_278_0 = 0.75

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0
				arg_275_1.dialogCg_.alpha = 1

				arg_275_1.dialog_:SetActive(true)
				SetActive(arg_275_1.leftNameGo_, false)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_275_1.iconTrs_.gameObject, false)
				arg_275_1.callingController_:SetSelectedState("normal")

				local var_278_1 = arg_275_1:FormatText(arg_275_1:GetWordFromCfg(412031065).content)

				arg_275_1.text_.text = var_278_1

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_3 = 30 <= 0 and var_278_0 or var_278_0 * (utf8.len(var_278_1) / 30)

				if (30 <= 0 and var_278_0 or var_278_0 * (utf8.len(var_278_1) / 30)) > 0 and var_278_0 < var_278_3 then
					arg_275_1.talkMaxDuration = var_278_3

					if var_278_3 + 0 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_3 + 0
					end
				end

				arg_275_1.text_.text = var_278_1
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)
				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_4 = math.max(var_278_0, arg_275_1.talkMaxDuration)

			if 0 <= arg_275_1.time_ and arg_275_1.time_ < 0 + var_278_4 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - 0) / var_278_4

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= 0 + var_278_4 and arg_275_1.time_ < 0 + var_278_4 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {}

		arg_275_1:InitPlayNodeList()
	end,
	Play412031066 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 412031066
		arg_279_1.duration_ = 9.57

		local var_279_0 = {
			zh = 9.566,
			ja = 5.733
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
				arg_279_0:Play412031067(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 then
				arg_279_1.var_.moveOldPos10083ui_story = arg_279_1.actors_["10083ui_story"].transform.localPosition
			end

			local var_282_0 = 0.001

			if 0 <= arg_279_1.time_ and arg_279_1.time_ < 0 + var_282_0 then
				arg_279_1.actors_["10083ui_story"].transform.localPosition = Vector3.Lerp(arg_279_1.var_.moveOldPos10083ui_story, Vector3.New(0, -2.6, -2.8), (arg_279_1.time_ - 0) / var_282_0)
				arg_279_1.actors_["10083ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_279_1.actors_["10083ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_279_1.actors_["10083ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_279_1.actors_["10083ui_story"].transform.position).z)
				arg_279_1.actors_["10083ui_story"].transform.localEulerAngles.z = 0
				arg_279_1.actors_["10083ui_story"].transform.localEulerAngles.x = 0
				arg_279_1.actors_["10083ui_story"].transform.localEulerAngles = arg_279_1.actors_["10083ui_story"].transform.localEulerAngles
			end

			if arg_279_1.time_ >= 0 + var_282_0 and arg_279_1.time_ < 0 + var_282_0 + arg_282_0 then
				arg_279_1.actors_["10083ui_story"].transform.localPosition = Vector3.New(0, -2.6, -2.8)
				arg_279_1.actors_["10083ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_279_1.actors_["10083ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_279_1.actors_["10083ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_279_1.actors_["10083ui_story"].transform.position).z)
				arg_279_1.actors_["10083ui_story"].transform.localEulerAngles.z = 0
				arg_279_1.actors_["10083ui_story"].transform.localEulerAngles.x = 0
				arg_279_1.actors_["10083ui_story"].transform.localEulerAngles = arg_279_1.actors_["10083ui_story"].transform.localEulerAngles
			end

			local var_282_1 = arg_279_1.actors_["10083ui_story"]

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 and not isNil(var_282_1) and arg_279_1.var_.characterEffect10083ui_story == nil then
				arg_279_1.var_.characterEffect10083ui_story = var_282_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_282_2 = 0.200000002980232

			if 0 <= arg_279_1.time_ and arg_279_1.time_ < 0 + var_282_2 and not isNil(var_282_1) then
				if arg_279_1.var_.characterEffect10083ui_story and not isNil(var_282_1) then
					arg_279_1.var_.characterEffect10083ui_story.fillFlat = false
				end
			end

			if arg_279_1.time_ >= 0 + var_282_2 and arg_279_1.time_ < 0 + var_282_2 + arg_282_0 and not isNil(var_282_1) and arg_279_1.var_.characterEffect10083ui_story then
				arg_279_1.var_.characterEffect10083ui_story.fillFlat = false
			end

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 then
				arg_279_1:PlayTimeline("10083ui_story", "StoryTimeline/CharAction/story10083/story10083actionlink/10083action445")
			end

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 then
				arg_279_1:PlayTimeline("10083ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_282_4 = 0
			local var_282_5 = 1.1

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= var_282_4 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0
				arg_279_1.dialogCg_.alpha = 1

				arg_279_1.dialog_:SetActive(true)
				SetActive(arg_279_1.leftNameGo_, true)

				arg_279_1.leftNameTxt_.text = arg_279_1:FormatText(StoryNameCfg[918].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_279_1.leftNameTxt_.transform)

				arg_279_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_279_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_279_1:RecordName(arg_279_1.leftNameTxt_.text)
				SetActive(arg_279_1.iconTrs_.gameObject, false)
				arg_279_1.callingController_:SetSelectedState("normal")

				local var_282_6 = arg_279_1:GetWordFromCfg(412031066)
				local var_282_7 = arg_279_1:FormatText(var_282_6.content)

				arg_279_1.text_.text = var_282_7

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_9 = 44 <= 0 and var_282_5 or var_282_5 * (utf8.len(var_282_7) / 44)

				if (44 <= 0 and var_282_5 or var_282_5 * (utf8.len(var_282_7) / 44)) > 0 and var_282_5 < var_282_9 then
					arg_279_1.talkMaxDuration = var_282_9

					if var_282_9 + var_282_4 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_9 + var_282_4
					end
				end

				arg_279_1.text_.text = var_282_7
				arg_279_1.typewritter.percent = 0

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031066", "story_v_out_412031.awb") ~= 0 then
					local var_282_10 = manager.audio:GetVoiceLength("story_v_out_412031", "412031066", "story_v_out_412031.awb") / 1000

					if var_282_10 + var_282_4 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_10 + var_282_4
					end

					if var_282_6.prefab_name ~= "" and arg_279_1.actors_[var_282_6.prefab_name] ~= nil then
						local var_282_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_279_1.actors_[var_282_6.prefab_name].transform, "story_v_out_412031", "412031066", "story_v_out_412031.awb")

						arg_279_1:RecordAudio("412031066", var_282_11)
						arg_279_1:RecordAudio("412031066", var_282_11)
					else
						arg_279_1:AudioAction("play", "voice", "story_v_out_412031", "412031066", "story_v_out_412031.awb")
					end

					arg_279_1:RecordHistoryTalkVoice("story_v_out_412031", "412031066", "story_v_out_412031.awb")
				end

				arg_279_1:RecordContent(arg_279_1.text_.text)
			end

			local var_282_12 = math.max(var_282_5, arg_279_1.talkMaxDuration)

			if var_282_4 <= arg_279_1.time_ and arg_279_1.time_ < var_282_4 + var_282_12 then
				arg_279_1.typewritter.percent = (arg_279_1.time_ - var_282_4) / var_282_12

				arg_279_1.typewritter:SetDirty()
			end

			if arg_279_1.time_ >= var_282_4 + var_282_12 and arg_279_1.time_ < var_282_4 + var_282_12 + arg_282_0 then
				arg_279_1.typewritter.percent = 1

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(true)
			end
		end

		arg_279_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10083ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_279_1:InitPlayNodeList()
	end,
	Play412031067 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 412031067
		arg_283_1.duration_ = 8.53

		local var_283_0 = {
			zh = 8.533,
			ja = 7.4
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
				arg_283_0:Play412031068(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			local var_286_0 = 0.875

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 then
				arg_283_1.talkMaxDuration = 0
				arg_283_1.dialogCg_.alpha = 1

				arg_283_1.dialog_:SetActive(true)
				SetActive(arg_283_1.leftNameGo_, true)

				arg_283_1.leftNameTxt_.text = arg_283_1:FormatText(StoryNameCfg[918].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_283_1.leftNameTxt_.transform)

				arg_283_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_283_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_283_1:RecordName(arg_283_1.leftNameTxt_.text)
				SetActive(arg_283_1.iconTrs_.gameObject, false)
				arg_283_1.callingController_:SetSelectedState("normal")

				local var_286_1 = arg_283_1:GetWordFromCfg(412031067)
				local var_286_2 = arg_283_1:FormatText(var_286_1.content)

				arg_283_1.text_.text = var_286_2

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_4 = 35 <= 0 and var_286_0 or var_286_0 * (utf8.len(var_286_2) / 35)

				if (35 <= 0 and var_286_0 or var_286_0 * (utf8.len(var_286_2) / 35)) > 0 and var_286_0 < var_286_4 then
					arg_283_1.talkMaxDuration = var_286_4

					if var_286_4 + 0 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_4 + 0
					end
				end

				arg_283_1.text_.text = var_286_2
				arg_283_1.typewritter.percent = 0

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031067", "story_v_out_412031.awb") ~= 0 then
					local var_286_5 = manager.audio:GetVoiceLength("story_v_out_412031", "412031067", "story_v_out_412031.awb") / 1000

					if var_286_5 + 0 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_5 + 0
					end

					if var_286_1.prefab_name ~= "" and arg_283_1.actors_[var_286_1.prefab_name] ~= nil then
						local var_286_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_283_1.actors_[var_286_1.prefab_name].transform, "story_v_out_412031", "412031067", "story_v_out_412031.awb")

						arg_283_1:RecordAudio("412031067", var_286_6)
						arg_283_1:RecordAudio("412031067", var_286_6)
					else
						arg_283_1:AudioAction("play", "voice", "story_v_out_412031", "412031067", "story_v_out_412031.awb")
					end

					arg_283_1:RecordHistoryTalkVoice("story_v_out_412031", "412031067", "story_v_out_412031.awb")
				end

				arg_283_1:RecordContent(arg_283_1.text_.text)
			end

			local var_286_7 = math.max(var_286_0, arg_283_1.talkMaxDuration)

			if 0 <= arg_283_1.time_ and arg_283_1.time_ < 0 + var_286_7 then
				arg_283_1.typewritter.percent = (arg_283_1.time_ - 0) / var_286_7

				arg_283_1.typewritter:SetDirty()
			end

			if arg_283_1.time_ >= 0 + var_286_7 and arg_283_1.time_ < 0 + var_286_7 + arg_286_0 then
				arg_283_1.typewritter.percent = 1

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(true)
			end
		end

		arg_283_1.nodeConfigList_ = {}

		arg_283_1:InitPlayNodeList()
	end,
	Play412031068 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 412031068
		arg_287_1.duration_ = 5

		SetActive(arg_287_1.tipsGo_, false)

		function arg_287_1.onSingleLineFinish_()
			arg_287_1.onSingleLineUpdate_ = nil
			arg_287_1.onSingleLineFinish_ = nil
			arg_287_1.state_ = "waiting"
		end

		function arg_287_1.playNext_(arg_289_0)
			if arg_289_0 == 1 then
				arg_287_0:Play412031069(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 then
				arg_287_1.var_.moveOldPos10083ui_story = arg_287_1.actors_["10083ui_story"].transform.localPosition
			end

			local var_290_0 = 0.001

			if 0 <= arg_287_1.time_ and arg_287_1.time_ < 0 + var_290_0 then
				arg_287_1.actors_["10083ui_story"].transform.localPosition = Vector3.Lerp(arg_287_1.var_.moveOldPos10083ui_story, Vector3.New(0, 100, 0), (arg_287_1.time_ - 0) / var_290_0)
				arg_287_1.actors_["10083ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_287_1.actors_["10083ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_287_1.actors_["10083ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_287_1.actors_["10083ui_story"].transform.position).z)
				arg_287_1.actors_["10083ui_story"].transform.localEulerAngles.z = 0
				arg_287_1.actors_["10083ui_story"].transform.localEulerAngles.x = 0
				arg_287_1.actors_["10083ui_story"].transform.localEulerAngles = arg_287_1.actors_["10083ui_story"].transform.localEulerAngles
			end

			if arg_287_1.time_ >= 0 + var_290_0 and arg_287_1.time_ < 0 + var_290_0 + arg_290_0 then
				arg_287_1.actors_["10083ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_287_1.actors_["10083ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_287_1.actors_["10083ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_287_1.actors_["10083ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_287_1.actors_["10083ui_story"].transform.position).z)
				arg_287_1.actors_["10083ui_story"].transform.localEulerAngles.z = 0
				arg_287_1.actors_["10083ui_story"].transform.localEulerAngles.x = 0
				arg_287_1.actors_["10083ui_story"].transform.localEulerAngles = arg_287_1.actors_["10083ui_story"].transform.localEulerAngles
			end

			local var_290_1 = arg_287_1.actors_["10083ui_story"]

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 and not isNil(var_290_1) and arg_287_1.var_.characterEffect10083ui_story == nil then
				arg_287_1.var_.characterEffect10083ui_story = var_290_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_290_2 = 0.034000001847744

			if 0 <= arg_287_1.time_ and arg_287_1.time_ < 0 + var_290_2 and not isNil(var_290_1) then
				if arg_287_1.var_.characterEffect10083ui_story and not isNil(var_290_1) then
					arg_287_1.var_.characterEffect10083ui_story.fillFlat = true
					arg_287_1.var_.characterEffect10083ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_287_1.time_ - 0) / var_290_2)
				end
			end

			if arg_287_1.time_ >= 0 + var_290_2 and arg_287_1.time_ < 0 + var_290_2 + arg_290_0 and not isNil(var_290_1) and arg_287_1.var_.characterEffect10083ui_story then
				arg_287_1.var_.characterEffect10083ui_story.fillFlat = true
				arg_287_1.var_.characterEffect10083ui_story.fillRatio = 0.5
			end

			local var_290_3 = 0
			local var_290_4 = 0.475

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= var_290_3 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0

				arg_287_1.dialog_:SetActive(true)

				arg_287_1.dialogCg_.alpha = 0

				local var_290_5 = LeanTween.value(arg_287_1.dialog_, 0, 1, 0.3)

				var_290_5:setOnUpdate(LuaHelper.FloatAction(function(arg_291_0)
					arg_287_1.dialogCg_.alpha = arg_291_0
				end))
				var_290_5:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_287_1.dialog_)
					var_290_5:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_287_1.duration_ = arg_287_1.duration_ + 0.3

				SetActive(arg_287_1.leftNameGo_, false)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_287_1.iconTrs_.gameObject, false)
				arg_287_1.callingController_:SetSelectedState("normal")

				local var_290_6 = arg_287_1:FormatText(arg_287_1:GetWordFromCfg(412031068).content)

				arg_287_1.text_.text = var_290_6

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_8 = 19 <= 0 and var_290_4 or var_290_4 * (utf8.len(var_290_6) / 19)

				if (19 <= 0 and var_290_4 or var_290_4 * (utf8.len(var_290_6) / 19)) > 0 and var_290_4 < var_290_8 then
					arg_287_1.talkMaxDuration = var_290_8
					var_290_3 = var_290_3 + 0.3

					if var_290_8 + var_290_3 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_8 + var_290_3
					end
				end

				arg_287_1.text_.text = var_290_6
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)
				arg_287_1:RecordContent(arg_287_1.text_.text)
			end

			local var_290_9 = var_290_3 + 0.3
			local var_290_10 = math.max(var_290_4, arg_287_1.talkMaxDuration)

			if var_290_3 + 0.3 <= arg_287_1.time_ and arg_287_1.time_ < var_290_9 + var_290_10 then
				arg_287_1.typewritter.percent = (arg_287_1.time_ - var_290_9) / var_290_10

				arg_287_1.typewritter:SetDirty()
			end

			if arg_287_1.time_ >= var_290_9 + var_290_10 and arg_287_1.time_ < var_290_9 + var_290_10 + arg_290_0 then
				arg_287_1.typewritter.percent = 1

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(true)
			end
		end

		arg_287_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10083ui_story",
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
	Play412031069 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 412031069
		arg_293_1.duration_ = 10.83

		local var_293_0 = {
			zh = 10.832999999999,
			ja = 9.99999999999899
		}
		local var_293_1 = manager.audio:GetLocalizationFlag()

		if var_293_0[var_293_1] ~= nil then
			arg_293_1.duration_ = var_293_0[var_293_1]
		end

		SetActive(arg_293_1.tipsGo_, false)

		function arg_293_1.onSingleLineFinish_()
			arg_293_1.onSingleLineUpdate_ = nil
			arg_293_1.onSingleLineFinish_ = nil
			arg_293_1.state_ = "waiting"
		end

		function arg_293_1.playNext_(arg_295_0)
			if arg_295_0 == 1 then
				arg_293_0:Play412031070(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			if 4 < arg_293_1.time_ and arg_293_1.time_ <= 4 + arg_296_0 then
				local var_296_0 = arg_293_1.bgs_.ST30

				arg_293_1.bgs_.ST30.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_296_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_296_1 = var_296_0:GetComponent("SpriteRenderer")

				if var_296_1 and var_296_1.sprite then
					local var_296_2 = 2 * (var_296_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_296_0.transform.localScale = Vector3.New(var_296_2 / var_296_1.sprite.bounds.size.y < var_296_2 * manager.ui.mainCameraCom_.aspect / var_296_1.sprite.bounds.size.x and var_296_2 * manager.ui.mainCameraCom_.aspect / var_296_1.sprite.bounds.size.x or var_296_2 / var_296_1.sprite.bounds.size.y, var_296_2 / var_296_1.sprite.bounds.size.y < var_296_2 * manager.ui.mainCameraCom_.aspect / var_296_1.sprite.bounds.size.x and var_296_2 * manager.ui.mainCameraCom_.aspect / var_296_1.sprite.bounds.size.x or var_296_2 / var_296_1.sprite.bounds.size.y, 0)
				end

				for iter_296_0, iter_296_1 in pairs(arg_293_1.bgs_) do
					if iter_296_0 ~= "ST30" then
						iter_296_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_296_3 = 5.99999999999999

			if 5.99999999999999 < arg_293_1.time_ and arg_293_1.time_ <= var_296_3 + arg_296_0 then
				arg_293_1.allBtn_.enabled = false
			end

			if arg_293_1.time_ >= var_296_3 + 0.3 and arg_293_1.time_ < var_296_3 + 0.3 + arg_296_0 then
				arg_293_1.allBtn_.enabled = true
			end

			local var_296_4 = 0

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= var_296_4 + arg_296_0 then
				arg_293_1.mask_.enabled = true
				arg_293_1.mask_.raycastTarget = true

				arg_293_1:SetGaussion(false)
			end

			local var_296_5 = 3

			if var_296_4 <= arg_293_1.time_ and arg_293_1.time_ < var_296_4 + var_296_5 then
				local var_296_6 = Color.New(0, 0, 0)

				var_296_6.a = Mathf.Lerp(0, 1, (arg_293_1.time_ - var_296_4) / var_296_5)
				arg_293_1.mask_.color = var_296_6
			end

			if arg_293_1.time_ >= var_296_4 + var_296_5 and arg_293_1.time_ < var_296_4 + var_296_5 + arg_296_0 then
				local var_296_7 = Color.New(0, 0, 0)

				var_296_7.a = 1
				arg_293_1.mask_.color = var_296_7
			end

			local var_296_8 = 3

			if 3 < arg_293_1.time_ and arg_293_1.time_ <= var_296_8 + arg_296_0 then
				arg_293_1.mask_.enabled = true
				arg_293_1.mask_.raycastTarget = true

				arg_293_1:SetGaussion(false)
			end

			local var_296_9 = 3

			if var_296_8 <= arg_293_1.time_ and arg_293_1.time_ < var_296_8 + var_296_9 then
				local var_296_10 = Color.New(0, 0, 0)

				var_296_10.a = Mathf.Lerp(1, 0, (arg_293_1.time_ - var_296_8) / var_296_9)
				arg_293_1.mask_.color = var_296_10
			end

			if arg_293_1.time_ >= var_296_8 + var_296_9 and arg_293_1.time_ < var_296_8 + var_296_9 + arg_296_0 then
				local var_296_11 = Color.New(0, 0, 0)

				arg_293_1.mask_.enabled = false
				var_296_11.a = 0
				arg_293_1.mask_.color = var_296_11
			end

			local var_296_12 = arg_293_1.actors_["10076ui_story"].transform

			if 5.8 < arg_293_1.time_ and arg_293_1.time_ <= 5.8 + arg_296_0 then
				arg_293_1.var_.moveOldPos10076ui_story = var_296_12.localPosition
			end

			local var_296_13 = 0.001

			if 5.8 <= arg_293_1.time_ and arg_293_1.time_ < 5.8 + var_296_13 then
				var_296_12.localPosition = Vector3.Lerp(arg_293_1.var_.moveOldPos10076ui_story, Vector3.New(-1, -0.35, -4), (arg_293_1.time_ - 5.8) / var_296_13)
				var_296_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_296_12.position).x, (manager.ui.mainCamera.transform.position - var_296_12.position).y, (manager.ui.mainCamera.transform.position - var_296_12.position).z)
				var_296_12.localEulerAngles.z = 0
				var_296_12.localEulerAngles.x = 0
				var_296_12.localEulerAngles = var_296_12.localEulerAngles
			end

			if arg_293_1.time_ >= 5.8 + var_296_13 and arg_293_1.time_ < 5.8 + var_296_13 + arg_296_0 then
				var_296_12.localPosition = Vector3.New(-1, -0.35, -4)
				var_296_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_296_12.position).x, (manager.ui.mainCamera.transform.position - var_296_12.position).y, (manager.ui.mainCamera.transform.position - var_296_12.position).z)
				var_296_12.localEulerAngles.z = 0
				var_296_12.localEulerAngles.x = 0
				var_296_12.localEulerAngles = var_296_12.localEulerAngles
			end

			local var_296_14 = arg_293_1.actors_["10076ui_story"]

			if 5.8 < arg_293_1.time_ and arg_293_1.time_ <= 5.8 + arg_296_0 and not isNil(var_296_14) and arg_293_1.var_.characterEffect10076ui_story == nil then
				arg_293_1.var_.characterEffect10076ui_story = var_296_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_296_15 = 0.200000002980232

			if 5.8 <= arg_293_1.time_ and arg_293_1.time_ < 5.8 + var_296_15 and not isNil(var_296_14) then
				if arg_293_1.var_.characterEffect10076ui_story and not isNil(var_296_14) then
					arg_293_1.var_.characterEffect10076ui_story.fillFlat = false
				end
			end

			if arg_293_1.time_ >= 5.8 + var_296_15 and arg_293_1.time_ < 5.8 + var_296_15 + arg_296_0 and not isNil(var_296_14) and arg_293_1.var_.characterEffect10076ui_story then
				arg_293_1.var_.characterEffect10076ui_story.fillFlat = false
			end

			if 5.8 < arg_293_1.time_ and arg_293_1.time_ <= 5.8 + arg_296_0 then
				arg_293_1:PlayTimeline("10076ui_story", "StoryTimeline/CharAction/story10076/story10076action/10076action1_1")
			end

			if 5.8 < arg_293_1.time_ and arg_293_1.time_ <= 5.8 + arg_296_0 then
				arg_293_1:PlayTimeline("10076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if arg_293_1.frameCnt_ <= 1 then
				arg_293_1.dialog_:SetActive(false)
			end

			local var_296_17 = 5.99999999999899
			local var_296_18 = 0.5

			if 5.99999999999899 < arg_293_1.time_ and arg_293_1.time_ <= var_296_17 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0

				arg_293_1.dialog_:SetActive(true)

				arg_293_1.dialogCg_.alpha = 0

				local var_296_19 = LeanTween.value(arg_293_1.dialog_, 0, 1, 0.3)

				var_296_19:setOnUpdate(LuaHelper.FloatAction(function(arg_297_0)
					arg_293_1.dialogCg_.alpha = arg_297_0
				end))
				var_296_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_293_1.dialog_)
					var_296_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_293_1.duration_ = arg_293_1.duration_ + 0.3

				SetActive(arg_293_1.leftNameGo_, true)

				arg_293_1.leftNameTxt_.text = arg_293_1:FormatText(StoryNameCfg[917].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_293_1.leftNameTxt_.transform)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1.leftNameTxt_.text)
				SetActive(arg_293_1.iconTrs_.gameObject, false)
				arg_293_1.callingController_:SetSelectedState("normal")

				local var_296_20 = arg_293_1:GetWordFromCfg(412031069)
				local var_296_21 = arg_293_1:FormatText(var_296_20.content)

				arg_293_1.text_.text = var_296_21

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_23 = 20 <= 0 and var_296_18 or var_296_18 * (utf8.len(var_296_21) / 20)

				if (20 <= 0 and var_296_18 or var_296_18 * (utf8.len(var_296_21) / 20)) > 0 and var_296_18 < var_296_23 then
					arg_293_1.talkMaxDuration = var_296_23
					var_296_17 = var_296_17 + 0.3

					if var_296_23 + var_296_17 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_23 + var_296_17
					end
				end

				arg_293_1.text_.text = var_296_21
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031069", "story_v_out_412031.awb") ~= 0 then
					local var_296_24 = manager.audio:GetVoiceLength("story_v_out_412031", "412031069", "story_v_out_412031.awb") / 1000

					if var_296_24 + var_296_17 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_24 + var_296_17
					end

					if var_296_20.prefab_name ~= "" and arg_293_1.actors_[var_296_20.prefab_name] ~= nil then
						local var_296_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_293_1.actors_[var_296_20.prefab_name].transform, "story_v_out_412031", "412031069", "story_v_out_412031.awb")

						arg_293_1:RecordAudio("412031069", var_296_25)
						arg_293_1:RecordAudio("412031069", var_296_25)
					else
						arg_293_1:AudioAction("play", "voice", "story_v_out_412031", "412031069", "story_v_out_412031.awb")
					end

					arg_293_1:RecordHistoryTalkVoice("story_v_out_412031", "412031069", "story_v_out_412031.awb")
				end

				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_26 = var_296_17 + 0.3
			local var_296_27 = math.max(var_296_18, arg_293_1.talkMaxDuration)

			if var_296_17 + 0.3 <= arg_293_1.time_ and arg_293_1.time_ < var_296_26 + var_296_27 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - var_296_26) / var_296_27

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= var_296_26 + var_296_27 and arg_293_1.time_ < var_296_26 + var_296_27 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 5.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_293_1:InitPlayNodeList()
	end,
	Play412031070 = function(arg_299_0, arg_299_1)
		arg_299_1.time_ = 0
		arg_299_1.frameCnt_ = 0
		arg_299_1.state_ = "playing"
		arg_299_1.curTalkId_ = 412031070
		arg_299_1.duration_ = 3.2

		local var_299_0 = {
			zh = 2.6,
			ja = 3.2
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
				arg_299_0:Play412031071(arg_299_1)
			end
		end

		function arg_299_1.onSingleLineUpdate_(arg_302_0)
			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 then
				arg_299_1.var_.moveOldPos1097ui_story = arg_299_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_302_0 = 0.001

			if 0 <= arg_299_1.time_ and arg_299_1.time_ < 0 + var_302_0 then
				arg_299_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_299_1.var_.moveOldPos1097ui_story, Vector3.New(0.7, -0.54, -6.3), (arg_299_1.time_ - 0) / var_302_0)
				arg_299_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_299_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_299_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_299_1.actors_["1097ui_story"].transform.position).z)
				arg_299_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_299_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_299_1.actors_["1097ui_story"].transform.localEulerAngles = arg_299_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_299_1.time_ >= 0 + var_302_0 and arg_299_1.time_ < 0 + var_302_0 + arg_302_0 then
				arg_299_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(0.7, -0.54, -6.3)
				arg_299_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_299_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_299_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_299_1.actors_["1097ui_story"].transform.position).z)
				arg_299_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_299_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_299_1.actors_["1097ui_story"].transform.localEulerAngles = arg_299_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_302_1 = arg_299_1.actors_["1097ui_story"]

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 and not isNil(var_302_1) and arg_299_1.var_.characterEffect1097ui_story == nil then
				arg_299_1.var_.characterEffect1097ui_story = var_302_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_302_2 = 0.200000002980232

			if 0 <= arg_299_1.time_ and arg_299_1.time_ < 0 + var_302_2 and not isNil(var_302_1) then
				if arg_299_1.var_.characterEffect1097ui_story and not isNil(var_302_1) then
					arg_299_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_299_1.time_ >= 0 + var_302_2 and arg_299_1.time_ < 0 + var_302_2 + arg_302_0 and not isNil(var_302_1) and arg_299_1.var_.characterEffect1097ui_story then
				arg_299_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 then
				arg_299_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 then
				arg_299_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_302_4 = arg_299_1.actors_["10076ui_story"]

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 and not isNil(var_302_4) and arg_299_1.var_.characterEffect10076ui_story == nil then
				arg_299_1.var_.characterEffect10076ui_story = var_302_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_302_5 = 0.200000002980232

			if 0 <= arg_299_1.time_ and arg_299_1.time_ < 0 + var_302_5 and not isNil(var_302_4) then
				if arg_299_1.var_.characterEffect10076ui_story and not isNil(var_302_4) then
					arg_299_1.var_.characterEffect10076ui_story.fillFlat = true
					arg_299_1.var_.characterEffect10076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_299_1.time_ - 0) / var_302_5)
				end
			end

			if arg_299_1.time_ >= 0 + var_302_5 and arg_299_1.time_ < 0 + var_302_5 + arg_302_0 and not isNil(var_302_4) and arg_299_1.var_.characterEffect10076ui_story then
				arg_299_1.var_.characterEffect10076ui_story.fillFlat = true
				arg_299_1.var_.characterEffect10076ui_story.fillRatio = 0.5
			end

			local var_302_6 = 0
			local var_302_7 = 0.15

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= var_302_6 + arg_302_0 then
				arg_299_1.talkMaxDuration = 0
				arg_299_1.dialogCg_.alpha = 1

				arg_299_1.dialog_:SetActive(true)
				SetActive(arg_299_1.leftNameGo_, true)

				arg_299_1.leftNameTxt_.text = arg_299_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_299_1.leftNameTxt_.transform)

				arg_299_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_299_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_299_1:RecordName(arg_299_1.leftNameTxt_.text)
				SetActive(arg_299_1.iconTrs_.gameObject, false)
				arg_299_1.callingController_:SetSelectedState("normal")

				local var_302_8 = arg_299_1:GetWordFromCfg(412031070)
				local var_302_9 = arg_299_1:FormatText(var_302_8.content)

				arg_299_1.text_.text = var_302_9

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.text_)

				local var_302_11 = 6 <= 0 and var_302_7 or var_302_7 * (utf8.len(var_302_9) / 6)

				if (6 <= 0 and var_302_7 or var_302_7 * (utf8.len(var_302_9) / 6)) > 0 and var_302_7 < var_302_11 then
					arg_299_1.talkMaxDuration = var_302_11

					if var_302_11 + var_302_6 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_11 + var_302_6
					end
				end

				arg_299_1.text_.text = var_302_9
				arg_299_1.typewritter.percent = 0

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031070", "story_v_out_412031.awb") ~= 0 then
					local var_302_12 = manager.audio:GetVoiceLength("story_v_out_412031", "412031070", "story_v_out_412031.awb") / 1000

					if var_302_12 + var_302_6 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_12 + var_302_6
					end

					if var_302_8.prefab_name ~= "" and arg_299_1.actors_[var_302_8.prefab_name] ~= nil then
						local var_302_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_299_1.actors_[var_302_8.prefab_name].transform, "story_v_out_412031", "412031070", "story_v_out_412031.awb")

						arg_299_1:RecordAudio("412031070", var_302_13)
						arg_299_1:RecordAudio("412031070", var_302_13)
					else
						arg_299_1:AudioAction("play", "voice", "story_v_out_412031", "412031070", "story_v_out_412031.awb")
					end

					arg_299_1:RecordHistoryTalkVoice("story_v_out_412031", "412031070", "story_v_out_412031.awb")
				end

				arg_299_1:RecordContent(arg_299_1.text_.text)
			end

			local var_302_14 = math.max(var_302_7, arg_299_1.talkMaxDuration)

			if var_302_6 <= arg_299_1.time_ and arg_299_1.time_ < var_302_6 + var_302_14 then
				arg_299_1.typewritter.percent = (arg_299_1.time_ - var_302_6) / var_302_14

				arg_299_1.typewritter:SetDirty()
			end

			if arg_299_1.time_ >= var_302_6 + var_302_14 and arg_299_1.time_ < var_302_6 + var_302_14 + arg_302_0 then
				arg_299_1.typewritter.percent = 1

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(true)
			end
		end

		arg_299_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
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
	Play412031071 = function(arg_303_0, arg_303_1)
		arg_303_1.time_ = 0
		arg_303_1.frameCnt_ = 0
		arg_303_1.state_ = "playing"
		arg_303_1.curTalkId_ = 412031071
		arg_303_1.duration_ = 10.67

		local var_303_0 = {
			zh = 9.566,
			ja = 10.666
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
				arg_303_0:Play412031072(arg_303_1)
			end
		end

		function arg_303_1.onSingleLineUpdate_(arg_306_0)
			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 then
				arg_303_1.var_.moveOldPos10076ui_story = arg_303_1.actors_["10076ui_story"].transform.localPosition
			end

			local var_306_0 = 0.001

			if 0 <= arg_303_1.time_ and arg_303_1.time_ < 0 + var_306_0 then
				arg_303_1.actors_["10076ui_story"].transform.localPosition = Vector3.Lerp(arg_303_1.var_.moveOldPos10076ui_story, Vector3.New(-1, -0.35, -4), (arg_303_1.time_ - 0) / var_306_0)
				arg_303_1.actors_["10076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_303_1.actors_["10076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_303_1.actors_["10076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_303_1.actors_["10076ui_story"].transform.position).z)
				arg_303_1.actors_["10076ui_story"].transform.localEulerAngles.z = 0
				arg_303_1.actors_["10076ui_story"].transform.localEulerAngles.x = 0
				arg_303_1.actors_["10076ui_story"].transform.localEulerAngles = arg_303_1.actors_["10076ui_story"].transform.localEulerAngles
			end

			if arg_303_1.time_ >= 0 + var_306_0 and arg_303_1.time_ < 0 + var_306_0 + arg_306_0 then
				arg_303_1.actors_["10076ui_story"].transform.localPosition = Vector3.New(-1, -0.35, -4)
				arg_303_1.actors_["10076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_303_1.actors_["10076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_303_1.actors_["10076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_303_1.actors_["10076ui_story"].transform.position).z)
				arg_303_1.actors_["10076ui_story"].transform.localEulerAngles.z = 0
				arg_303_1.actors_["10076ui_story"].transform.localEulerAngles.x = 0
				arg_303_1.actors_["10076ui_story"].transform.localEulerAngles = arg_303_1.actors_["10076ui_story"].transform.localEulerAngles
			end

			local var_306_1 = arg_303_1.actors_["10076ui_story"]

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 and not isNil(var_306_1) and arg_303_1.var_.characterEffect10076ui_story == nil then
				arg_303_1.var_.characterEffect10076ui_story = var_306_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_306_2 = 0.200000002980232

			if 0 <= arg_303_1.time_ and arg_303_1.time_ < 0 + var_306_2 and not isNil(var_306_1) then
				if arg_303_1.var_.characterEffect10076ui_story and not isNil(var_306_1) then
					arg_303_1.var_.characterEffect10076ui_story.fillFlat = false
				end
			end

			if arg_303_1.time_ >= 0 + var_306_2 and arg_303_1.time_ < 0 + var_306_2 + arg_306_0 and not isNil(var_306_1) and arg_303_1.var_.characterEffect10076ui_story then
				arg_303_1.var_.characterEffect10076ui_story.fillFlat = false
			end

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 then
				arg_303_1:PlayTimeline("10076ui_story", "StoryTimeline/CharAction/story10076/story10076action/10076action3_1")
			end

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 then
				arg_303_1:PlayTimeline("10076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_306_4 = arg_303_1.actors_["1097ui_story"]

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 and not isNil(var_306_4) and arg_303_1.var_.characterEffect1097ui_story == nil then
				arg_303_1.var_.characterEffect1097ui_story = var_306_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_306_5 = 0.200000002980232

			if 0 <= arg_303_1.time_ and arg_303_1.time_ < 0 + var_306_5 and not isNil(var_306_4) then
				if arg_303_1.var_.characterEffect1097ui_story and not isNil(var_306_4) then
					arg_303_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_303_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_303_1.time_ - 0) / var_306_5)
				end
			end

			if arg_303_1.time_ >= 0 + var_306_5 and arg_303_1.time_ < 0 + var_306_5 + arg_306_0 and not isNil(var_306_4) and arg_303_1.var_.characterEffect1097ui_story then
				arg_303_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_303_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_306_6 = 0
			local var_306_7 = 1.2

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= var_306_6 + arg_306_0 then
				arg_303_1.talkMaxDuration = 0
				arg_303_1.dialogCg_.alpha = 1

				arg_303_1.dialog_:SetActive(true)
				SetActive(arg_303_1.leftNameGo_, true)

				arg_303_1.leftNameTxt_.text = arg_303_1:FormatText(StoryNameCfg[917].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_303_1.leftNameTxt_.transform)

				arg_303_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_303_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_303_1:RecordName(arg_303_1.leftNameTxt_.text)
				SetActive(arg_303_1.iconTrs_.gameObject, false)
				arg_303_1.callingController_:SetSelectedState("normal")

				local var_306_8 = arg_303_1:GetWordFromCfg(412031071)
				local var_306_9 = arg_303_1:FormatText(var_306_8.content)

				arg_303_1.text_.text = var_306_9

				LuaForUtil.ClearLinePrefixSymbol(arg_303_1.text_)

				local var_306_11 = 48 <= 0 and var_306_7 or var_306_7 * (utf8.len(var_306_9) / 48)

				if (48 <= 0 and var_306_7 or var_306_7 * (utf8.len(var_306_9) / 48)) > 0 and var_306_7 < var_306_11 then
					arg_303_1.talkMaxDuration = var_306_11

					if var_306_11 + var_306_6 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_11 + var_306_6
					end
				end

				arg_303_1.text_.text = var_306_9
				arg_303_1.typewritter.percent = 0

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031071", "story_v_out_412031.awb") ~= 0 then
					local var_306_12 = manager.audio:GetVoiceLength("story_v_out_412031", "412031071", "story_v_out_412031.awb") / 1000

					if var_306_12 + var_306_6 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_12 + var_306_6
					end

					if var_306_8.prefab_name ~= "" and arg_303_1.actors_[var_306_8.prefab_name] ~= nil then
						local var_306_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_303_1.actors_[var_306_8.prefab_name].transform, "story_v_out_412031", "412031071", "story_v_out_412031.awb")

						arg_303_1:RecordAudio("412031071", var_306_13)
						arg_303_1:RecordAudio("412031071", var_306_13)
					else
						arg_303_1:AudioAction("play", "voice", "story_v_out_412031", "412031071", "story_v_out_412031.awb")
					end

					arg_303_1:RecordHistoryTalkVoice("story_v_out_412031", "412031071", "story_v_out_412031.awb")
				end

				arg_303_1:RecordContent(arg_303_1.text_.text)
			end

			local var_306_14 = math.max(var_306_7, arg_303_1.talkMaxDuration)

			if var_306_6 <= arg_303_1.time_ and arg_303_1.time_ < var_306_6 + var_306_14 then
				arg_303_1.typewritter.percent = (arg_303_1.time_ - var_306_6) / var_306_14

				arg_303_1.typewritter:SetDirty()
			end

			if arg_303_1.time_ >= var_306_6 + var_306_14 and arg_303_1.time_ < var_306_6 + var_306_14 + arg_306_0 then
				arg_303_1.typewritter.percent = 1

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(true)
			end
		end

		arg_303_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10076ui_story",
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
	Play412031072 = function(arg_307_0, arg_307_1)
		arg_307_1.time_ = 0
		arg_307_1.frameCnt_ = 0
		arg_307_1.state_ = "playing"
		arg_307_1.curTalkId_ = 412031072
		arg_307_1.duration_ = 5

		SetActive(arg_307_1.tipsGo_, false)

		function arg_307_1.onSingleLineFinish_()
			arg_307_1.onSingleLineUpdate_ = nil
			arg_307_1.onSingleLineFinish_ = nil
			arg_307_1.state_ = "waiting"
		end

		function arg_307_1.playNext_(arg_309_0)
			if arg_309_0 == 1 then
				arg_307_0:Play412031073(arg_307_1)
			end
		end

		function arg_307_1.onSingleLineUpdate_(arg_310_0)
			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 and not isNil(arg_307_1.actors_["10076ui_story"]) and arg_307_1.var_.characterEffect10076ui_story == nil then
				arg_307_1.var_.characterEffect10076ui_story = arg_307_1.actors_["10076ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_310_0 = 0.200000002980232

			if 0 <= arg_307_1.time_ and arg_307_1.time_ < 0 + var_310_0 and not isNil(arg_307_1.actors_["10076ui_story"]) then
				if arg_307_1.var_.characterEffect10076ui_story and not isNil(arg_307_1.actors_["10076ui_story"]) then
					arg_307_1.var_.characterEffect10076ui_story.fillFlat = true
					arg_307_1.var_.characterEffect10076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_307_1.time_ - 0) / var_310_0)
				end
			end

			if arg_307_1.time_ >= 0 + var_310_0 and arg_307_1.time_ < 0 + var_310_0 + arg_310_0 and not isNil(arg_307_1.actors_["10076ui_story"]) and arg_307_1.var_.characterEffect10076ui_story then
				arg_307_1.var_.characterEffect10076ui_story.fillFlat = true
				arg_307_1.var_.characterEffect10076ui_story.fillRatio = 0.5
			end

			local var_310_1 = 0
			local var_310_2 = 1.3

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= var_310_1 + arg_310_0 then
				arg_307_1.talkMaxDuration = 0
				arg_307_1.dialogCg_.alpha = 1

				arg_307_1.dialog_:SetActive(true)
				SetActive(arg_307_1.leftNameGo_, false)

				arg_307_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_307_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_307_1:RecordName(arg_307_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_307_1.iconTrs_.gameObject, false)
				arg_307_1.callingController_:SetSelectedState("normal")

				local var_310_3 = arg_307_1:FormatText(arg_307_1:GetWordFromCfg(412031072).content)

				arg_307_1.text_.text = var_310_3

				LuaForUtil.ClearLinePrefixSymbol(arg_307_1.text_)

				local var_310_5 = 52 <= 0 and var_310_2 or var_310_2 * (utf8.len(var_310_3) / 52)

				if (52 <= 0 and var_310_2 or var_310_2 * (utf8.len(var_310_3) / 52)) > 0 and var_310_2 < var_310_5 then
					arg_307_1.talkMaxDuration = var_310_5

					if var_310_5 + var_310_1 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_5 + var_310_1
					end
				end

				arg_307_1.text_.text = var_310_3
				arg_307_1.typewritter.percent = 0

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(false)
				arg_307_1:RecordContent(arg_307_1.text_.text)
			end

			local var_310_6 = math.max(var_310_2, arg_307_1.talkMaxDuration)

			if var_310_1 <= arg_307_1.time_ and arg_307_1.time_ < var_310_1 + var_310_6 then
				arg_307_1.typewritter.percent = (arg_307_1.time_ - var_310_1) / var_310_6

				arg_307_1.typewritter:SetDirty()
			end

			if arg_307_1.time_ >= var_310_1 + var_310_6 and arg_307_1.time_ < var_310_1 + var_310_6 + arg_310_0 then
				arg_307_1.typewritter.percent = 1

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(true)
			end
		end

		arg_307_1.nodeConfigList_ = {}

		arg_307_1:InitPlayNodeList()
	end,
	Play412031073 = function(arg_311_0, arg_311_1)
		arg_311_1.time_ = 0
		arg_311_1.frameCnt_ = 0
		arg_311_1.state_ = "playing"
		arg_311_1.curTalkId_ = 412031073
		arg_311_1.duration_ = 9.43

		local var_311_0 = {
			zh = 9.433,
			ja = 7.933
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
				arg_311_0:Play412031074(arg_311_1)
			end
		end

		function arg_311_1.onSingleLineUpdate_(arg_314_0)
			if 0 < arg_311_1.time_ and arg_311_1.time_ <= 0 + arg_314_0 then
				arg_311_1.var_.moveOldPos1097ui_story = arg_311_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_314_0 = 0.001

			if 0 <= arg_311_1.time_ and arg_311_1.time_ < 0 + var_314_0 then
				arg_311_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_311_1.var_.moveOldPos1097ui_story, Vector3.New(0.7, -0.54, -6.3), (arg_311_1.time_ - 0) / var_314_0)
				arg_311_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_311_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_311_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_311_1.actors_["1097ui_story"].transform.position).z)
				arg_311_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_311_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_311_1.actors_["1097ui_story"].transform.localEulerAngles = arg_311_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_311_1.time_ >= 0 + var_314_0 and arg_311_1.time_ < 0 + var_314_0 + arg_314_0 then
				arg_311_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(0.7, -0.54, -6.3)
				arg_311_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_311_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_311_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_311_1.actors_["1097ui_story"].transform.position).z)
				arg_311_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_311_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_311_1.actors_["1097ui_story"].transform.localEulerAngles = arg_311_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_314_1 = arg_311_1.actors_["1097ui_story"]

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= 0 + arg_314_0 and not isNil(var_314_1) and arg_311_1.var_.characterEffect1097ui_story == nil then
				arg_311_1.var_.characterEffect1097ui_story = var_314_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_314_2 = 0.200000002980232

			if 0 <= arg_311_1.time_ and arg_311_1.time_ < 0 + var_314_2 and not isNil(var_314_1) then
				if arg_311_1.var_.characterEffect1097ui_story and not isNil(var_314_1) then
					arg_311_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_311_1.time_ >= 0 + var_314_2 and arg_311_1.time_ < 0 + var_314_2 + arg_314_0 and not isNil(var_314_1) and arg_311_1.var_.characterEffect1097ui_story then
				arg_311_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= 0 + arg_314_0 then
				arg_311_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= 0 + arg_314_0 then
				arg_311_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_314_4 = 0
			local var_314_5 = 0.775

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= var_314_4 + arg_314_0 then
				arg_311_1.talkMaxDuration = 0
				arg_311_1.dialogCg_.alpha = 1

				arg_311_1.dialog_:SetActive(true)
				SetActive(arg_311_1.leftNameGo_, true)

				arg_311_1.leftNameTxt_.text = arg_311_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_311_1.leftNameTxt_.transform)

				arg_311_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_311_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_311_1:RecordName(arg_311_1.leftNameTxt_.text)
				SetActive(arg_311_1.iconTrs_.gameObject, false)
				arg_311_1.callingController_:SetSelectedState("normal")

				local var_314_6 = arg_311_1:GetWordFromCfg(412031073)
				local var_314_7 = arg_311_1:FormatText(var_314_6.content)

				arg_311_1.text_.text = var_314_7

				LuaForUtil.ClearLinePrefixSymbol(arg_311_1.text_)

				local var_314_9 = 31 <= 0 and var_314_5 or var_314_5 * (utf8.len(var_314_7) / 31)

				if (31 <= 0 and var_314_5 or var_314_5 * (utf8.len(var_314_7) / 31)) > 0 and var_314_5 < var_314_9 then
					arg_311_1.talkMaxDuration = var_314_9

					if var_314_9 + var_314_4 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_9 + var_314_4
					end
				end

				arg_311_1.text_.text = var_314_7
				arg_311_1.typewritter.percent = 0

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031073", "story_v_out_412031.awb") ~= 0 then
					local var_314_10 = manager.audio:GetVoiceLength("story_v_out_412031", "412031073", "story_v_out_412031.awb") / 1000

					if var_314_10 + var_314_4 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_10 + var_314_4
					end

					if var_314_6.prefab_name ~= "" and arg_311_1.actors_[var_314_6.prefab_name] ~= nil then
						local var_314_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_311_1.actors_[var_314_6.prefab_name].transform, "story_v_out_412031", "412031073", "story_v_out_412031.awb")

						arg_311_1:RecordAudio("412031073", var_314_11)
						arg_311_1:RecordAudio("412031073", var_314_11)
					else
						arg_311_1:AudioAction("play", "voice", "story_v_out_412031", "412031073", "story_v_out_412031.awb")
					end

					arg_311_1:RecordHistoryTalkVoice("story_v_out_412031", "412031073", "story_v_out_412031.awb")
				end

				arg_311_1:RecordContent(arg_311_1.text_.text)
			end

			local var_314_12 = math.max(var_314_5, arg_311_1.talkMaxDuration)

			if var_314_4 <= arg_311_1.time_ and arg_311_1.time_ < var_314_4 + var_314_12 then
				arg_311_1.typewritter.percent = (arg_311_1.time_ - var_314_4) / var_314_12

				arg_311_1.typewritter:SetDirty()
			end

			if arg_311_1.time_ >= var_314_4 + var_314_12 and arg_311_1.time_ < var_314_4 + var_314_12 + arg_314_0 then
				arg_311_1.typewritter.percent = 1

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(true)
			end
		end

		arg_311_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_311_1:InitPlayNodeList()
	end,
	Play412031074 = function(arg_315_0, arg_315_1)
		arg_315_1.time_ = 0
		arg_315_1.frameCnt_ = 0
		arg_315_1.state_ = "playing"
		arg_315_1.curTalkId_ = 412031074
		arg_315_1.duration_ = 14.4

		local var_315_0 = {
			zh = 10.566,
			ja = 14.4
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
				arg_315_0:Play412031075(arg_315_1)
			end
		end

		function arg_315_1.onSingleLineUpdate_(arg_318_0)
			local var_318_0 = 0.975

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 then
				arg_315_1.talkMaxDuration = 0
				arg_315_1.dialogCg_.alpha = 1

				arg_315_1.dialog_:SetActive(true)
				SetActive(arg_315_1.leftNameGo_, true)

				arg_315_1.leftNameTxt_.text = arg_315_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_315_1.leftNameTxt_.transform)

				arg_315_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_315_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_315_1:RecordName(arg_315_1.leftNameTxt_.text)
				SetActive(arg_315_1.iconTrs_.gameObject, false)
				arg_315_1.callingController_:SetSelectedState("normal")

				local var_318_1 = arg_315_1:GetWordFromCfg(412031074)
				local var_318_2 = arg_315_1:FormatText(var_318_1.content)

				arg_315_1.text_.text = var_318_2

				LuaForUtil.ClearLinePrefixSymbol(arg_315_1.text_)

				local var_318_4 = 39 <= 0 and var_318_0 or var_318_0 * (utf8.len(var_318_2) / 39)

				if (39 <= 0 and var_318_0 or var_318_0 * (utf8.len(var_318_2) / 39)) > 0 and var_318_0 < var_318_4 then
					arg_315_1.talkMaxDuration = var_318_4

					if var_318_4 + 0 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_4 + 0
					end
				end

				arg_315_1.text_.text = var_318_2
				arg_315_1.typewritter.percent = 0

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031074", "story_v_out_412031.awb") ~= 0 then
					local var_318_5 = manager.audio:GetVoiceLength("story_v_out_412031", "412031074", "story_v_out_412031.awb") / 1000

					if var_318_5 + 0 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_5 + 0
					end

					if var_318_1.prefab_name ~= "" and arg_315_1.actors_[var_318_1.prefab_name] ~= nil then
						local var_318_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_315_1.actors_[var_318_1.prefab_name].transform, "story_v_out_412031", "412031074", "story_v_out_412031.awb")

						arg_315_1:RecordAudio("412031074", var_318_6)
						arg_315_1:RecordAudio("412031074", var_318_6)
					else
						arg_315_1:AudioAction("play", "voice", "story_v_out_412031", "412031074", "story_v_out_412031.awb")
					end

					arg_315_1:RecordHistoryTalkVoice("story_v_out_412031", "412031074", "story_v_out_412031.awb")
				end

				arg_315_1:RecordContent(arg_315_1.text_.text)
			end

			local var_318_7 = math.max(var_318_0, arg_315_1.talkMaxDuration)

			if 0 <= arg_315_1.time_ and arg_315_1.time_ < 0 + var_318_7 then
				arg_315_1.typewritter.percent = (arg_315_1.time_ - 0) / var_318_7

				arg_315_1.typewritter:SetDirty()
			end

			if arg_315_1.time_ >= 0 + var_318_7 and arg_315_1.time_ < 0 + var_318_7 + arg_318_0 then
				arg_315_1.typewritter.percent = 1

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(true)
			end
		end

		arg_315_1.nodeConfigList_ = {}

		arg_315_1:InitPlayNodeList()
	end,
	Play412031075 = function(arg_319_0, arg_319_1)
		arg_319_1.time_ = 0
		arg_319_1.frameCnt_ = 0
		arg_319_1.state_ = "playing"
		arg_319_1.curTalkId_ = 412031075
		arg_319_1.duration_ = 5.97

		local var_319_0 = {
			zh = 5.966,
			ja = 3.5
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
				arg_319_0:Play412031076(arg_319_1)
			end
		end

		function arg_319_1.onSingleLineUpdate_(arg_322_0)
			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 and not isNil(arg_319_1.actors_["10076ui_story"]) and arg_319_1.var_.characterEffect10076ui_story == nil then
				arg_319_1.var_.characterEffect10076ui_story = arg_319_1.actors_["10076ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_322_0 = 0.200000002980232

			if 0 <= arg_319_1.time_ and arg_319_1.time_ < 0 + var_322_0 and not isNil(arg_319_1.actors_["10076ui_story"]) then
				if arg_319_1.var_.characterEffect10076ui_story and not isNil(arg_319_1.actors_["10076ui_story"]) then
					arg_319_1.var_.characterEffect10076ui_story.fillFlat = false
				end
			end

			if arg_319_1.time_ >= 0 + var_322_0 and arg_319_1.time_ < 0 + var_322_0 + arg_322_0 and not isNil(arg_319_1.actors_["10076ui_story"]) and arg_319_1.var_.characterEffect10076ui_story then
				arg_319_1.var_.characterEffect10076ui_story.fillFlat = false
			end

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 then
				arg_319_1:PlayTimeline("10076ui_story", "StoryTimeline/CharAction/story10076/story10076action/10076action3_2")
			end

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 then
				arg_319_1:PlayTimeline("10076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_322_2 = arg_319_1.actors_["1097ui_story"]

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 and not isNil(var_322_2) and arg_319_1.var_.characterEffect1097ui_story == nil then
				arg_319_1.var_.characterEffect1097ui_story = var_322_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_322_3 = 0.200000002980232

			if 0 <= arg_319_1.time_ and arg_319_1.time_ < 0 + var_322_3 and not isNil(var_322_2) then
				if arg_319_1.var_.characterEffect1097ui_story and not isNil(var_322_2) then
					arg_319_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_319_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_319_1.time_ - 0) / var_322_3)
				end
			end

			if arg_319_1.time_ >= 0 + var_322_3 and arg_319_1.time_ < 0 + var_322_3 + arg_322_0 and not isNil(var_322_2) and arg_319_1.var_.characterEffect1097ui_story then
				arg_319_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_319_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_322_4 = 0
			local var_322_5 = 0.675

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= var_322_4 + arg_322_0 then
				arg_319_1.talkMaxDuration = 0
				arg_319_1.dialogCg_.alpha = 1

				arg_319_1.dialog_:SetActive(true)
				SetActive(arg_319_1.leftNameGo_, true)

				arg_319_1.leftNameTxt_.text = arg_319_1:FormatText(StoryNameCfg[917].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_319_1.leftNameTxt_.transform)

				arg_319_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_319_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_319_1:RecordName(arg_319_1.leftNameTxt_.text)
				SetActive(arg_319_1.iconTrs_.gameObject, false)
				arg_319_1.callingController_:SetSelectedState("normal")

				local var_322_6 = arg_319_1:GetWordFromCfg(412031075)
				local var_322_7 = arg_319_1:FormatText(var_322_6.content)

				arg_319_1.text_.text = var_322_7

				LuaForUtil.ClearLinePrefixSymbol(arg_319_1.text_)

				local var_322_9 = 27 <= 0 and var_322_5 or var_322_5 * (utf8.len(var_322_7) / 27)

				if (27 <= 0 and var_322_5 or var_322_5 * (utf8.len(var_322_7) / 27)) > 0 and var_322_5 < var_322_9 then
					arg_319_1.talkMaxDuration = var_322_9

					if var_322_9 + var_322_4 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_9 + var_322_4
					end
				end

				arg_319_1.text_.text = var_322_7
				arg_319_1.typewritter.percent = 0

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031075", "story_v_out_412031.awb") ~= 0 then
					local var_322_10 = manager.audio:GetVoiceLength("story_v_out_412031", "412031075", "story_v_out_412031.awb") / 1000

					if var_322_10 + var_322_4 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_10 + var_322_4
					end

					if var_322_6.prefab_name ~= "" and arg_319_1.actors_[var_322_6.prefab_name] ~= nil then
						local var_322_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_319_1.actors_[var_322_6.prefab_name].transform, "story_v_out_412031", "412031075", "story_v_out_412031.awb")

						arg_319_1:RecordAudio("412031075", var_322_11)
						arg_319_1:RecordAudio("412031075", var_322_11)
					else
						arg_319_1:AudioAction("play", "voice", "story_v_out_412031", "412031075", "story_v_out_412031.awb")
					end

					arg_319_1:RecordHistoryTalkVoice("story_v_out_412031", "412031075", "story_v_out_412031.awb")
				end

				arg_319_1:RecordContent(arg_319_1.text_.text)
			end

			local var_322_12 = math.max(var_322_5, arg_319_1.talkMaxDuration)

			if var_322_4 <= arg_319_1.time_ and arg_319_1.time_ < var_322_4 + var_322_12 then
				arg_319_1.typewritter.percent = (arg_319_1.time_ - var_322_4) / var_322_12

				arg_319_1.typewritter:SetDirty()
			end

			if arg_319_1.time_ >= var_322_4 + var_322_12 and arg_319_1.time_ < var_322_4 + var_322_12 + arg_322_0 then
				arg_319_1.typewritter.percent = 1

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(true)
			end
		end

		arg_319_1.nodeConfigList_ = {}

		arg_319_1:InitPlayNodeList()
	end,
	Play412031076 = function(arg_323_0, arg_323_1)
		arg_323_1.time_ = 0
		arg_323_1.frameCnt_ = 0
		arg_323_1.state_ = "playing"
		arg_323_1.curTalkId_ = 412031076
		arg_323_1.duration_ = 13.1

		local var_323_0 = {
			zh = 13.1,
			ja = 12
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
				arg_323_0:Play412031077(arg_323_1)
			end
		end

		function arg_323_1.onSingleLineUpdate_(arg_326_0)
			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 then
				arg_323_1.var_.moveOldPos10083ui_story = arg_323_1.actors_["10083ui_story"].transform.localPosition
			end

			local var_326_0 = 0.001

			if 0 <= arg_323_1.time_ and arg_323_1.time_ < 0 + var_326_0 then
				arg_323_1.actors_["10083ui_story"].transform.localPosition = Vector3.Lerp(arg_323_1.var_.moveOldPos10083ui_story, Vector3.New(0, -2.6, -2.8), (arg_323_1.time_ - 0) / var_326_0)
				arg_323_1.actors_["10083ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_323_1.actors_["10083ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_323_1.actors_["10083ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_323_1.actors_["10083ui_story"].transform.position).z)
				arg_323_1.actors_["10083ui_story"].transform.localEulerAngles.z = 0
				arg_323_1.actors_["10083ui_story"].transform.localEulerAngles.x = 0
				arg_323_1.actors_["10083ui_story"].transform.localEulerAngles = arg_323_1.actors_["10083ui_story"].transform.localEulerAngles
			end

			if arg_323_1.time_ >= 0 + var_326_0 and arg_323_1.time_ < 0 + var_326_0 + arg_326_0 then
				arg_323_1.actors_["10083ui_story"].transform.localPosition = Vector3.New(0, -2.6, -2.8)
				arg_323_1.actors_["10083ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_323_1.actors_["10083ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_323_1.actors_["10083ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_323_1.actors_["10083ui_story"].transform.position).z)
				arg_323_1.actors_["10083ui_story"].transform.localEulerAngles.z = 0
				arg_323_1.actors_["10083ui_story"].transform.localEulerAngles.x = 0
				arg_323_1.actors_["10083ui_story"].transform.localEulerAngles = arg_323_1.actors_["10083ui_story"].transform.localEulerAngles
			end

			local var_326_1 = arg_323_1.actors_["10083ui_story"]

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 and not isNil(var_326_1) and arg_323_1.var_.characterEffect10083ui_story == nil then
				arg_323_1.var_.characterEffect10083ui_story = var_326_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_326_2 = 0.200000002980232

			if 0 <= arg_323_1.time_ and arg_323_1.time_ < 0 + var_326_2 and not isNil(var_326_1) then
				if arg_323_1.var_.characterEffect10083ui_story and not isNil(var_326_1) then
					arg_323_1.var_.characterEffect10083ui_story.fillFlat = false
				end
			end

			if arg_323_1.time_ >= 0 + var_326_2 and arg_323_1.time_ < 0 + var_326_2 + arg_326_0 and not isNil(var_326_1) and arg_323_1.var_.characterEffect10083ui_story then
				arg_323_1.var_.characterEffect10083ui_story.fillFlat = false
			end

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 then
				arg_323_1:PlayTimeline("10083ui_story", "StoryTimeline/CharAction/story10083/story10083action/10083action2_1")
			end

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 then
				arg_323_1:PlayTimeline("10083ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_326_4 = arg_323_1.actors_["1097ui_story"].transform

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 then
				arg_323_1.var_.moveOldPos1097ui_story = var_326_4.localPosition
			end

			local var_326_5 = 0.001

			if 0 <= arg_323_1.time_ and arg_323_1.time_ < 0 + var_326_5 then
				var_326_4.localPosition = Vector3.Lerp(arg_323_1.var_.moveOldPos1097ui_story, Vector3.New(0, 100, 0), (arg_323_1.time_ - 0) / var_326_5)
				var_326_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_326_4.position).x, (manager.ui.mainCamera.transform.position - var_326_4.position).y, (manager.ui.mainCamera.transform.position - var_326_4.position).z)
				var_326_4.localEulerAngles.z = 0
				var_326_4.localEulerAngles.x = 0
				var_326_4.localEulerAngles = var_326_4.localEulerAngles
			end

			if arg_323_1.time_ >= 0 + var_326_5 and arg_323_1.time_ < 0 + var_326_5 + arg_326_0 then
				var_326_4.localPosition = Vector3.New(0, 100, 0)
				var_326_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_326_4.position).x, (manager.ui.mainCamera.transform.position - var_326_4.position).y, (manager.ui.mainCamera.transform.position - var_326_4.position).z)
				var_326_4.localEulerAngles.z = 0
				var_326_4.localEulerAngles.x = 0
				var_326_4.localEulerAngles = var_326_4.localEulerAngles
			end

			local var_326_6 = arg_323_1.actors_["1097ui_story"]

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 and not isNil(var_326_6) and arg_323_1.var_.characterEffect1097ui_story == nil then
				arg_323_1.var_.characterEffect1097ui_story = var_326_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_326_7 = 0.200000002980232

			if 0 <= arg_323_1.time_ and arg_323_1.time_ < 0 + var_326_7 and not isNil(var_326_6) then
				if arg_323_1.var_.characterEffect1097ui_story and not isNil(var_326_6) then
					arg_323_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_323_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_323_1.time_ - 0) / var_326_7)
				end
			end

			if arg_323_1.time_ >= 0 + var_326_7 and arg_323_1.time_ < 0 + var_326_7 + arg_326_0 and not isNil(var_326_6) and arg_323_1.var_.characterEffect1097ui_story then
				arg_323_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_323_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_326_8 = arg_323_1.actors_["10076ui_story"].transform

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 then
				arg_323_1.var_.moveOldPos10076ui_story = var_326_8.localPosition
			end

			local var_326_9 = 0.001

			if 0 <= arg_323_1.time_ and arg_323_1.time_ < 0 + var_326_9 then
				var_326_8.localPosition = Vector3.Lerp(arg_323_1.var_.moveOldPos10076ui_story, Vector3.New(0, 100, 0), (arg_323_1.time_ - 0) / var_326_9)
				var_326_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_326_8.position).x, (manager.ui.mainCamera.transform.position - var_326_8.position).y, (manager.ui.mainCamera.transform.position - var_326_8.position).z)
				var_326_8.localEulerAngles.z = 0
				var_326_8.localEulerAngles.x = 0
				var_326_8.localEulerAngles = var_326_8.localEulerAngles
			end

			if arg_323_1.time_ >= 0 + var_326_9 and arg_323_1.time_ < 0 + var_326_9 + arg_326_0 then
				var_326_8.localPosition = Vector3.New(0, 100, 0)
				var_326_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_326_8.position).x, (manager.ui.mainCamera.transform.position - var_326_8.position).y, (manager.ui.mainCamera.transform.position - var_326_8.position).z)
				var_326_8.localEulerAngles.z = 0
				var_326_8.localEulerAngles.x = 0
				var_326_8.localEulerAngles = var_326_8.localEulerAngles
			end

			local var_326_10 = arg_323_1.actors_["10076ui_story"]

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 and not isNil(var_326_10) and arg_323_1.var_.characterEffect10076ui_story == nil then
				arg_323_1.var_.characterEffect10076ui_story = var_326_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_326_11 = 0.200000002980232

			if 0 <= arg_323_1.time_ and arg_323_1.time_ < 0 + var_326_11 and not isNil(var_326_10) then
				if arg_323_1.var_.characterEffect10076ui_story and not isNil(var_326_10) then
					arg_323_1.var_.characterEffect10076ui_story.fillFlat = true
					arg_323_1.var_.characterEffect10076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_323_1.time_ - 0) / var_326_11)
				end
			end

			if arg_323_1.time_ >= 0 + var_326_11 and arg_323_1.time_ < 0 + var_326_11 + arg_326_0 and not isNil(var_326_10) and arg_323_1.var_.characterEffect10076ui_story then
				arg_323_1.var_.characterEffect10076ui_story.fillFlat = true
				arg_323_1.var_.characterEffect10076ui_story.fillRatio = 0.5
			end

			local var_326_12 = 0
			local var_326_13 = 1.675

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= var_326_12 + arg_326_0 then
				arg_323_1.talkMaxDuration = 0
				arg_323_1.dialogCg_.alpha = 1

				arg_323_1.dialog_:SetActive(true)
				SetActive(arg_323_1.leftNameGo_, true)

				arg_323_1.leftNameTxt_.text = arg_323_1:FormatText(StoryNameCfg[918].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_323_1.leftNameTxt_.transform)

				arg_323_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_323_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_323_1:RecordName(arg_323_1.leftNameTxt_.text)
				SetActive(arg_323_1.iconTrs_.gameObject, false)
				arg_323_1.callingController_:SetSelectedState("normal")

				local var_326_14 = arg_323_1:GetWordFromCfg(412031076)
				local var_326_15 = arg_323_1:FormatText(var_326_14.content)

				arg_323_1.text_.text = var_326_15

				LuaForUtil.ClearLinePrefixSymbol(arg_323_1.text_)

				local var_326_17 = 67 <= 0 and var_326_13 or var_326_13 * (utf8.len(var_326_15) / 67)

				if (67 <= 0 and var_326_13 or var_326_13 * (utf8.len(var_326_15) / 67)) > 0 and var_326_13 < var_326_17 then
					arg_323_1.talkMaxDuration = var_326_17

					if var_326_17 + var_326_12 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_17 + var_326_12
					end
				end

				arg_323_1.text_.text = var_326_15
				arg_323_1.typewritter.percent = 0

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031076", "story_v_out_412031.awb") ~= 0 then
					local var_326_18 = manager.audio:GetVoiceLength("story_v_out_412031", "412031076", "story_v_out_412031.awb") / 1000

					if var_326_18 + var_326_12 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_18 + var_326_12
					end

					if var_326_14.prefab_name ~= "" and arg_323_1.actors_[var_326_14.prefab_name] ~= nil then
						local var_326_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_323_1.actors_[var_326_14.prefab_name].transform, "story_v_out_412031", "412031076", "story_v_out_412031.awb")

						arg_323_1:RecordAudio("412031076", var_326_19)
						arg_323_1:RecordAudio("412031076", var_326_19)
					else
						arg_323_1:AudioAction("play", "voice", "story_v_out_412031", "412031076", "story_v_out_412031.awb")
					end

					arg_323_1:RecordHistoryTalkVoice("story_v_out_412031", "412031076", "story_v_out_412031.awb")
				end

				arg_323_1:RecordContent(arg_323_1.text_.text)
			end

			local var_326_20 = math.max(var_326_13, arg_323_1.talkMaxDuration)

			if var_326_12 <= arg_323_1.time_ and arg_323_1.time_ < var_326_12 + var_326_20 then
				arg_323_1.typewritter.percent = (arg_323_1.time_ - var_326_12) / var_326_20

				arg_323_1.typewritter:SetDirty()
			end

			if arg_323_1.time_ >= var_326_12 + var_326_20 and arg_323_1.time_ < var_326_12 + var_326_20 + arg_326_0 then
				arg_323_1.typewritter.percent = 1

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(true)
			end
		end

		arg_323_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10083ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10076ui_story",
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
	Play412031077 = function(arg_327_0, arg_327_1)
		arg_327_1.time_ = 0
		arg_327_1.frameCnt_ = 0
		arg_327_1.state_ = "playing"
		arg_327_1.curTalkId_ = 412031077
		arg_327_1.duration_ = 5.03

		local var_327_0 = {
			zh = 3.433,
			ja = 5.033
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
				arg_327_0:Play412031078(arg_327_1)
			end
		end

		function arg_327_1.onSingleLineUpdate_(arg_330_0)
			if 0 < arg_327_1.time_ and arg_327_1.time_ <= 0 + arg_330_0 then
				arg_327_1.var_.moveOldPos10078ui_story = arg_327_1.actors_["10078ui_story"].transform.localPosition
			end

			local var_330_0 = 0.001

			if 0 <= arg_327_1.time_ and arg_327_1.time_ < 0 + var_330_0 then
				arg_327_1.actors_["10078ui_story"].transform.localPosition = Vector3.Lerp(arg_327_1.var_.moveOldPos10078ui_story, Vector3.New(0, -0.5, -6.3), (arg_327_1.time_ - 0) / var_330_0)
				arg_327_1.actors_["10078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_327_1.actors_["10078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_327_1.actors_["10078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_327_1.actors_["10078ui_story"].transform.position).z)
				arg_327_1.actors_["10078ui_story"].transform.localEulerAngles.z = 0
				arg_327_1.actors_["10078ui_story"].transform.localEulerAngles.x = 0
				arg_327_1.actors_["10078ui_story"].transform.localEulerAngles = arg_327_1.actors_["10078ui_story"].transform.localEulerAngles
			end

			if arg_327_1.time_ >= 0 + var_330_0 and arg_327_1.time_ < 0 + var_330_0 + arg_330_0 then
				arg_327_1.actors_["10078ui_story"].transform.localPosition = Vector3.New(0, -0.5, -6.3)
				arg_327_1.actors_["10078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_327_1.actors_["10078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_327_1.actors_["10078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_327_1.actors_["10078ui_story"].transform.position).z)
				arg_327_1.actors_["10078ui_story"].transform.localEulerAngles.z = 0
				arg_327_1.actors_["10078ui_story"].transform.localEulerAngles.x = 0
				arg_327_1.actors_["10078ui_story"].transform.localEulerAngles = arg_327_1.actors_["10078ui_story"].transform.localEulerAngles
			end

			local var_330_1 = arg_327_1.actors_["10078ui_story"]

			if 0 < arg_327_1.time_ and arg_327_1.time_ <= 0 + arg_330_0 and not isNil(var_330_1) and arg_327_1.var_.characterEffect10078ui_story == nil then
				arg_327_1.var_.characterEffect10078ui_story = var_330_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_330_2 = 0.200000002980232

			if 0 <= arg_327_1.time_ and arg_327_1.time_ < 0 + var_330_2 and not isNil(var_330_1) then
				if arg_327_1.var_.characterEffect10078ui_story and not isNil(var_330_1) then
					arg_327_1.var_.characterEffect10078ui_story.fillFlat = false
				end
			end

			if arg_327_1.time_ >= 0 + var_330_2 and arg_327_1.time_ < 0 + var_330_2 + arg_330_0 and not isNil(var_330_1) and arg_327_1.var_.characterEffect10078ui_story then
				arg_327_1.var_.characterEffect10078ui_story.fillFlat = false
			end

			if 0 < arg_327_1.time_ and arg_327_1.time_ <= 0 + arg_330_0 then
				arg_327_1:PlayTimeline("10078ui_story", "StoryTimeline/CharAction/story6046/story6046action/6046action1_1")
			end

			if 0 < arg_327_1.time_ and arg_327_1.time_ <= 0 + arg_330_0 then
				arg_327_1:PlayTimeline("10078ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_330_4 = arg_327_1.actors_["10083ui_story"].transform

			if 0 < arg_327_1.time_ and arg_327_1.time_ <= 0 + arg_330_0 then
				arg_327_1.var_.moveOldPos10083ui_story = var_330_4.localPosition
			end

			local var_330_5 = 0.001

			if 0 <= arg_327_1.time_ and arg_327_1.time_ < 0 + var_330_5 then
				var_330_4.localPosition = Vector3.Lerp(arg_327_1.var_.moveOldPos10083ui_story, Vector3.New(0, 100, 0), (arg_327_1.time_ - 0) / var_330_5)
				var_330_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_330_4.position).x, (manager.ui.mainCamera.transform.position - var_330_4.position).y, (manager.ui.mainCamera.transform.position - var_330_4.position).z)
				var_330_4.localEulerAngles.z = 0
				var_330_4.localEulerAngles.x = 0
				var_330_4.localEulerAngles = var_330_4.localEulerAngles
			end

			if arg_327_1.time_ >= 0 + var_330_5 and arg_327_1.time_ < 0 + var_330_5 + arg_330_0 then
				var_330_4.localPosition = Vector3.New(0, 100, 0)
				var_330_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_330_4.position).x, (manager.ui.mainCamera.transform.position - var_330_4.position).y, (manager.ui.mainCamera.transform.position - var_330_4.position).z)
				var_330_4.localEulerAngles.z = 0
				var_330_4.localEulerAngles.x = 0
				var_330_4.localEulerAngles = var_330_4.localEulerAngles
			end

			local var_330_6 = arg_327_1.actors_["10083ui_story"]

			if 0 < arg_327_1.time_ and arg_327_1.time_ <= 0 + arg_330_0 and not isNil(var_330_6) and arg_327_1.var_.characterEffect10083ui_story == nil then
				arg_327_1.var_.characterEffect10083ui_story = var_330_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_330_7 = 0.200000002980232

			if 0 <= arg_327_1.time_ and arg_327_1.time_ < 0 + var_330_7 and not isNil(var_330_6) then
				if arg_327_1.var_.characterEffect10083ui_story and not isNil(var_330_6) then
					arg_327_1.var_.characterEffect10083ui_story.fillFlat = true
					arg_327_1.var_.characterEffect10083ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_327_1.time_ - 0) / var_330_7)
				end
			end

			if arg_327_1.time_ >= 0 + var_330_7 and arg_327_1.time_ < 0 + var_330_7 + arg_330_0 and not isNil(var_330_6) and arg_327_1.var_.characterEffect10083ui_story then
				arg_327_1.var_.characterEffect10083ui_story.fillFlat = true
				arg_327_1.var_.characterEffect10083ui_story.fillRatio = 0.5
			end

			local var_330_8 = 0
			local var_330_9 = 0.2

			if 0 < arg_327_1.time_ and arg_327_1.time_ <= var_330_8 + arg_330_0 then
				arg_327_1.talkMaxDuration = 0
				arg_327_1.dialogCg_.alpha = 1

				arg_327_1.dialog_:SetActive(true)
				SetActive(arg_327_1.leftNameGo_, true)

				arg_327_1.leftNameTxt_.text = arg_327_1:FormatText(StoryNameCfg[919].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_327_1.leftNameTxt_.transform)

				arg_327_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_327_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_327_1:RecordName(arg_327_1.leftNameTxt_.text)
				SetActive(arg_327_1.iconTrs_.gameObject, false)
				arg_327_1.callingController_:SetSelectedState("normal")

				local var_330_10 = arg_327_1:GetWordFromCfg(412031077)
				local var_330_11 = arg_327_1:FormatText(var_330_10.content)

				arg_327_1.text_.text = var_330_11

				LuaForUtil.ClearLinePrefixSymbol(arg_327_1.text_)

				local var_330_13 = 8 <= 0 and var_330_9 or var_330_9 * (utf8.len(var_330_11) / 8)

				if (8 <= 0 and var_330_9 or var_330_9 * (utf8.len(var_330_11) / 8)) > 0 and var_330_9 < var_330_13 then
					arg_327_1.talkMaxDuration = var_330_13

					if var_330_13 + var_330_8 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_13 + var_330_8
					end
				end

				arg_327_1.text_.text = var_330_11
				arg_327_1.typewritter.percent = 0

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031077", "story_v_out_412031.awb") ~= 0 then
					local var_330_14 = manager.audio:GetVoiceLength("story_v_out_412031", "412031077", "story_v_out_412031.awb") / 1000

					if var_330_14 + var_330_8 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_14 + var_330_8
					end

					if var_330_10.prefab_name ~= "" and arg_327_1.actors_[var_330_10.prefab_name] ~= nil then
						local var_330_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_327_1.actors_[var_330_10.prefab_name].transform, "story_v_out_412031", "412031077", "story_v_out_412031.awb")

						arg_327_1:RecordAudio("412031077", var_330_15)
						arg_327_1:RecordAudio("412031077", var_330_15)
					else
						arg_327_1:AudioAction("play", "voice", "story_v_out_412031", "412031077", "story_v_out_412031.awb")
					end

					arg_327_1:RecordHistoryTalkVoice("story_v_out_412031", "412031077", "story_v_out_412031.awb")
				end

				arg_327_1:RecordContent(arg_327_1.text_.text)
			end

			local var_330_16 = math.max(var_330_9, arg_327_1.talkMaxDuration)

			if var_330_8 <= arg_327_1.time_ and arg_327_1.time_ < var_330_8 + var_330_16 then
				arg_327_1.typewritter.percent = (arg_327_1.time_ - var_330_8) / var_330_16

				arg_327_1.typewritter:SetDirty()
			end

			if arg_327_1.time_ >= var_330_8 + var_330_16 and arg_327_1.time_ < var_330_8 + var_330_16 + arg_330_0 then
				arg_327_1.typewritter.percent = 1

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(true)
			end
		end

		arg_327_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10083ui_story",
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
	Play412031078 = function(arg_331_0, arg_331_1)
		arg_331_1.time_ = 0
		arg_331_1.frameCnt_ = 0
		arg_331_1.state_ = "playing"
		arg_331_1.curTalkId_ = 412031078
		arg_331_1.duration_ = 13.57

		local var_331_0 = {
			zh = 8.766,
			ja = 13.566
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
				arg_331_0:Play412031079(arg_331_1)
			end
		end

		function arg_331_1.onSingleLineUpdate_(arg_334_0)
			if 0 < arg_331_1.time_ and arg_331_1.time_ <= 0 + arg_334_0 then
				arg_331_1.var_.moveOldPos1097ui_story = arg_331_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_334_0 = 0.001

			if 0 <= arg_331_1.time_ and arg_331_1.time_ < 0 + var_334_0 then
				arg_331_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_331_1.var_.moveOldPos1097ui_story, Vector3.New(0, -0.54, -6.3), (arg_331_1.time_ - 0) / var_334_0)
				arg_331_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_331_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_331_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_331_1.actors_["1097ui_story"].transform.position).z)
				arg_331_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_331_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_331_1.actors_["1097ui_story"].transform.localEulerAngles = arg_331_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_331_1.time_ >= 0 + var_334_0 and arg_331_1.time_ < 0 + var_334_0 + arg_334_0 then
				arg_331_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(0, -0.54, -6.3)
				arg_331_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_331_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_331_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_331_1.actors_["1097ui_story"].transform.position).z)
				arg_331_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_331_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_331_1.actors_["1097ui_story"].transform.localEulerAngles = arg_331_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_334_1 = arg_331_1.actors_["1097ui_story"]

			if 0 < arg_331_1.time_ and arg_331_1.time_ <= 0 + arg_334_0 and not isNil(var_334_1) and arg_331_1.var_.characterEffect1097ui_story == nil then
				arg_331_1.var_.characterEffect1097ui_story = var_334_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_334_2 = 0.200000002980232

			if 0 <= arg_331_1.time_ and arg_331_1.time_ < 0 + var_334_2 and not isNil(var_334_1) then
				if arg_331_1.var_.characterEffect1097ui_story and not isNil(var_334_1) then
					arg_331_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_331_1.time_ >= 0 + var_334_2 and arg_331_1.time_ < 0 + var_334_2 + arg_334_0 and not isNil(var_334_1) and arg_331_1.var_.characterEffect1097ui_story then
				arg_331_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_331_1.time_ and arg_331_1.time_ <= 0 + arg_334_0 then
				arg_331_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			if 0 < arg_331_1.time_ and arg_331_1.time_ <= 0 + arg_334_0 then
				arg_331_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_334_4 = arg_331_1.actors_["10078ui_story"].transform

			if 0 < arg_331_1.time_ and arg_331_1.time_ <= 0 + arg_334_0 then
				arg_331_1.var_.moveOldPos10078ui_story = var_334_4.localPosition
			end

			local var_334_5 = 0.001

			if 0 <= arg_331_1.time_ and arg_331_1.time_ < 0 + var_334_5 then
				var_334_4.localPosition = Vector3.Lerp(arg_331_1.var_.moveOldPos10078ui_story, Vector3.New(0, 100, 0), (arg_331_1.time_ - 0) / var_334_5)
				var_334_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_334_4.position).x, (manager.ui.mainCamera.transform.position - var_334_4.position).y, (manager.ui.mainCamera.transform.position - var_334_4.position).z)
				var_334_4.localEulerAngles.z = 0
				var_334_4.localEulerAngles.x = 0
				var_334_4.localEulerAngles = var_334_4.localEulerAngles
			end

			if arg_331_1.time_ >= 0 + var_334_5 and arg_331_1.time_ < 0 + var_334_5 + arg_334_0 then
				var_334_4.localPosition = Vector3.New(0, 100, 0)
				var_334_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_334_4.position).x, (manager.ui.mainCamera.transform.position - var_334_4.position).y, (manager.ui.mainCamera.transform.position - var_334_4.position).z)
				var_334_4.localEulerAngles.z = 0
				var_334_4.localEulerAngles.x = 0
				var_334_4.localEulerAngles = var_334_4.localEulerAngles
			end

			local var_334_6 = arg_331_1.actors_["10078ui_story"]

			if 0 < arg_331_1.time_ and arg_331_1.time_ <= 0 + arg_334_0 and not isNil(var_334_6) and arg_331_1.var_.characterEffect10078ui_story == nil then
				arg_331_1.var_.characterEffect10078ui_story = var_334_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_334_7 = 0.200000002980232

			if 0 <= arg_331_1.time_ and arg_331_1.time_ < 0 + var_334_7 and not isNil(var_334_6) then
				if arg_331_1.var_.characterEffect10078ui_story and not isNil(var_334_6) then
					arg_331_1.var_.characterEffect10078ui_story.fillFlat = true
					arg_331_1.var_.characterEffect10078ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_331_1.time_ - 0) / var_334_7)
				end
			end

			if arg_331_1.time_ >= 0 + var_334_7 and arg_331_1.time_ < 0 + var_334_7 + arg_334_0 and not isNil(var_334_6) and arg_331_1.var_.characterEffect10078ui_story then
				arg_331_1.var_.characterEffect10078ui_story.fillFlat = true
				arg_331_1.var_.characterEffect10078ui_story.fillRatio = 0.5
			end

			local var_334_8 = 0
			local var_334_9 = 0.85

			if 0 < arg_331_1.time_ and arg_331_1.time_ <= var_334_8 + arg_334_0 then
				arg_331_1.talkMaxDuration = 0
				arg_331_1.dialogCg_.alpha = 1

				arg_331_1.dialog_:SetActive(true)
				SetActive(arg_331_1.leftNameGo_, true)

				arg_331_1.leftNameTxt_.text = arg_331_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_331_1.leftNameTxt_.transform)

				arg_331_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_331_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_331_1:RecordName(arg_331_1.leftNameTxt_.text)
				SetActive(arg_331_1.iconTrs_.gameObject, false)
				arg_331_1.callingController_:SetSelectedState("normal")

				local var_334_10 = arg_331_1:GetWordFromCfg(412031078)
				local var_334_11 = arg_331_1:FormatText(var_334_10.content)

				arg_331_1.text_.text = var_334_11

				LuaForUtil.ClearLinePrefixSymbol(arg_331_1.text_)

				local var_334_13 = 34 <= 0 and var_334_9 or var_334_9 * (utf8.len(var_334_11) / 34)

				if (34 <= 0 and var_334_9 or var_334_9 * (utf8.len(var_334_11) / 34)) > 0 and var_334_9 < var_334_13 then
					arg_331_1.talkMaxDuration = var_334_13

					if var_334_13 + var_334_8 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_13 + var_334_8
					end
				end

				arg_331_1.text_.text = var_334_11
				arg_331_1.typewritter.percent = 0

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031078", "story_v_out_412031.awb") ~= 0 then
					local var_334_14 = manager.audio:GetVoiceLength("story_v_out_412031", "412031078", "story_v_out_412031.awb") / 1000

					if var_334_14 + var_334_8 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_14 + var_334_8
					end

					if var_334_10.prefab_name ~= "" and arg_331_1.actors_[var_334_10.prefab_name] ~= nil then
						local var_334_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_331_1.actors_[var_334_10.prefab_name].transform, "story_v_out_412031", "412031078", "story_v_out_412031.awb")

						arg_331_1:RecordAudio("412031078", var_334_15)
						arg_331_1:RecordAudio("412031078", var_334_15)
					else
						arg_331_1:AudioAction("play", "voice", "story_v_out_412031", "412031078", "story_v_out_412031.awb")
					end

					arg_331_1:RecordHistoryTalkVoice("story_v_out_412031", "412031078", "story_v_out_412031.awb")
				end

				arg_331_1:RecordContent(arg_331_1.text_.text)
			end

			local var_334_16 = math.max(var_334_9, arg_331_1.talkMaxDuration)

			if var_334_8 <= arg_331_1.time_ and arg_331_1.time_ < var_334_8 + var_334_16 then
				arg_331_1.typewritter.percent = (arg_331_1.time_ - var_334_8) / var_334_16

				arg_331_1.typewritter:SetDirty()
			end

			if arg_331_1.time_ >= var_334_8 + var_334_16 and arg_331_1.time_ < var_334_8 + var_334_16 + arg_334_0 then
				arg_331_1.typewritter.percent = 1

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(true)
			end
		end

		arg_331_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10078ui_story",
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
	Play412031079 = function(arg_335_0, arg_335_1)
		arg_335_1.time_ = 0
		arg_335_1.frameCnt_ = 0
		arg_335_1.state_ = "playing"
		arg_335_1.curTalkId_ = 412031079
		arg_335_1.duration_ = 5

		SetActive(arg_335_1.tipsGo_, false)

		function arg_335_1.onSingleLineFinish_()
			arg_335_1.onSingleLineUpdate_ = nil
			arg_335_1.onSingleLineFinish_ = nil
			arg_335_1.state_ = "waiting"
		end

		function arg_335_1.playNext_(arg_337_0)
			if arg_337_0 == 1 then
				arg_335_0:Play412031080(arg_335_1)
			end
		end

		function arg_335_1.onSingleLineUpdate_(arg_338_0)
			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 then
				arg_335_1.var_.moveOldPos1097ui_story = arg_335_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_338_0 = 0.001

			if 0 <= arg_335_1.time_ and arg_335_1.time_ < 0 + var_338_0 then
				arg_335_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_335_1.var_.moveOldPos1097ui_story, Vector3.New(0, 100, 0), (arg_335_1.time_ - 0) / var_338_0)
				arg_335_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_335_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_335_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_335_1.actors_["1097ui_story"].transform.position).z)
				arg_335_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_335_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_335_1.actors_["1097ui_story"].transform.localEulerAngles = arg_335_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_335_1.time_ >= 0 + var_338_0 and arg_335_1.time_ < 0 + var_338_0 + arg_338_0 then
				arg_335_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_335_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_335_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_335_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_335_1.actors_["1097ui_story"].transform.position).z)
				arg_335_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_335_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_335_1.actors_["1097ui_story"].transform.localEulerAngles = arg_335_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_338_1 = arg_335_1.actors_["1097ui_story"]

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 and not isNil(var_338_1) and arg_335_1.var_.characterEffect1097ui_story == nil then
				arg_335_1.var_.characterEffect1097ui_story = var_338_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_338_2 = 0.200000002980232

			if 0 <= arg_335_1.time_ and arg_335_1.time_ < 0 + var_338_2 and not isNil(var_338_1) then
				if arg_335_1.var_.characterEffect1097ui_story and not isNil(var_338_1) then
					arg_335_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_335_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_335_1.time_ - 0) / var_338_2)
				end
			end

			if arg_335_1.time_ >= 0 + var_338_2 and arg_335_1.time_ < 0 + var_338_2 + arg_338_0 and not isNil(var_338_1) and arg_335_1.var_.characterEffect1097ui_story then
				arg_335_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_335_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_338_3 = 0
			local var_338_4 = 1.075

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= var_338_3 + arg_338_0 then
				arg_335_1.talkMaxDuration = 0
				arg_335_1.dialogCg_.alpha = 1

				arg_335_1.dialog_:SetActive(true)
				SetActive(arg_335_1.leftNameGo_, false)

				arg_335_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_335_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_335_1:RecordName(arg_335_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_335_1.iconTrs_.gameObject, false)
				arg_335_1.callingController_:SetSelectedState("normal")

				local var_338_5 = arg_335_1:FormatText(arg_335_1:GetWordFromCfg(412031079).content)

				arg_335_1.text_.text = var_338_5

				LuaForUtil.ClearLinePrefixSymbol(arg_335_1.text_)

				local var_338_7 = 43 <= 0 and var_338_4 or var_338_4 * (utf8.len(var_338_5) / 43)

				if (43 <= 0 and var_338_4 or var_338_4 * (utf8.len(var_338_5) / 43)) > 0 and var_338_4 < var_338_7 then
					arg_335_1.talkMaxDuration = var_338_7

					if var_338_7 + var_338_3 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_7 + var_338_3
					end
				end

				arg_335_1.text_.text = var_338_5
				arg_335_1.typewritter.percent = 0

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(false)
				arg_335_1:RecordContent(arg_335_1.text_.text)
			end

			local var_338_8 = math.max(var_338_4, arg_335_1.talkMaxDuration)

			if var_338_3 <= arg_335_1.time_ and arg_335_1.time_ < var_338_3 + var_338_8 then
				arg_335_1.typewritter.percent = (arg_335_1.time_ - var_338_3) / var_338_8

				arg_335_1.typewritter:SetDirty()
			end

			if arg_335_1.time_ >= var_338_3 + var_338_8 and arg_335_1.time_ < var_338_3 + var_338_8 + arg_338_0 then
				arg_335_1.typewritter.percent = 1

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(true)
			end
		end

		arg_335_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
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
	Play412031080 = function(arg_339_0, arg_339_1)
		arg_339_1.time_ = 0
		arg_339_1.frameCnt_ = 0
		arg_339_1.state_ = "playing"
		arg_339_1.curTalkId_ = 412031080
		arg_339_1.duration_ = 2

		local var_339_0 = {
			zh = 2,
			ja = 1.999999999999
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
				arg_339_0:Play412031081(arg_339_1)
			end
		end

		function arg_339_1.onSingleLineUpdate_(arg_342_0)
			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 then
				arg_339_1.var_.moveOldPos1097ui_story = arg_339_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_342_0 = 0.001

			if 0 <= arg_339_1.time_ and arg_339_1.time_ < 0 + var_342_0 then
				arg_339_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_339_1.var_.moveOldPos1097ui_story, Vector3.New(0, -0.54, -6.3), (arg_339_1.time_ - 0) / var_342_0)
				arg_339_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_339_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_339_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_339_1.actors_["1097ui_story"].transform.position).z)
				arg_339_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_339_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_339_1.actors_["1097ui_story"].transform.localEulerAngles = arg_339_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_339_1.time_ >= 0 + var_342_0 and arg_339_1.time_ < 0 + var_342_0 + arg_342_0 then
				arg_339_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(0, -0.54, -6.3)
				arg_339_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_339_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_339_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_339_1.actors_["1097ui_story"].transform.position).z)
				arg_339_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_339_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_339_1.actors_["1097ui_story"].transform.localEulerAngles = arg_339_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_342_1 = arg_339_1.actors_["1097ui_story"]

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 and not isNil(var_342_1) and arg_339_1.var_.characterEffect1097ui_story == nil then
				arg_339_1.var_.characterEffect1097ui_story = var_342_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_342_2 = 0.200000002980232

			if 0 <= arg_339_1.time_ and arg_339_1.time_ < 0 + var_342_2 and not isNil(var_342_1) then
				if arg_339_1.var_.characterEffect1097ui_story and not isNil(var_342_1) then
					arg_339_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_339_1.time_ >= 0 + var_342_2 and arg_339_1.time_ < 0 + var_342_2 + arg_342_0 and not isNil(var_342_1) and arg_339_1.var_.characterEffect1097ui_story then
				arg_339_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 then
				arg_339_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 then
				arg_339_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_342_4 = 0
			local var_342_5 = 0.15

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= var_342_4 + arg_342_0 then
				arg_339_1.talkMaxDuration = 0
				arg_339_1.dialogCg_.alpha = 1

				arg_339_1.dialog_:SetActive(true)
				SetActive(arg_339_1.leftNameGo_, true)

				arg_339_1.leftNameTxt_.text = arg_339_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_339_1.leftNameTxt_.transform)

				arg_339_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_339_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_339_1:RecordName(arg_339_1.leftNameTxt_.text)
				SetActive(arg_339_1.iconTrs_.gameObject, false)
				arg_339_1.callingController_:SetSelectedState("normal")

				local var_342_6 = arg_339_1:GetWordFromCfg(412031080)
				local var_342_7 = arg_339_1:FormatText(var_342_6.content)

				arg_339_1.text_.text = var_342_7

				LuaForUtil.ClearLinePrefixSymbol(arg_339_1.text_)

				local var_342_9 = 6 <= 0 and var_342_5 or var_342_5 * (utf8.len(var_342_7) / 6)

				if (6 <= 0 and var_342_5 or var_342_5 * (utf8.len(var_342_7) / 6)) > 0 and var_342_5 < var_342_9 then
					arg_339_1.talkMaxDuration = var_342_9

					if var_342_9 + var_342_4 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_9 + var_342_4
					end
				end

				arg_339_1.text_.text = var_342_7
				arg_339_1.typewritter.percent = 0

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031080", "story_v_out_412031.awb") ~= 0 then
					local var_342_10 = manager.audio:GetVoiceLength("story_v_out_412031", "412031080", "story_v_out_412031.awb") / 1000

					if var_342_10 + var_342_4 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_10 + var_342_4
					end

					if var_342_6.prefab_name ~= "" and arg_339_1.actors_[var_342_6.prefab_name] ~= nil then
						local var_342_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_339_1.actors_[var_342_6.prefab_name].transform, "story_v_out_412031", "412031080", "story_v_out_412031.awb")

						arg_339_1:RecordAudio("412031080", var_342_11)
						arg_339_1:RecordAudio("412031080", var_342_11)
					else
						arg_339_1:AudioAction("play", "voice", "story_v_out_412031", "412031080", "story_v_out_412031.awb")
					end

					arg_339_1:RecordHistoryTalkVoice("story_v_out_412031", "412031080", "story_v_out_412031.awb")
				end

				arg_339_1:RecordContent(arg_339_1.text_.text)
			end

			local var_342_12 = math.max(var_342_5, arg_339_1.talkMaxDuration)

			if var_342_4 <= arg_339_1.time_ and arg_339_1.time_ < var_342_4 + var_342_12 then
				arg_339_1.typewritter.percent = (arg_339_1.time_ - var_342_4) / var_342_12

				arg_339_1.typewritter:SetDirty()
			end

			if arg_339_1.time_ >= var_342_4 + var_342_12 and arg_339_1.time_ < var_342_4 + var_342_12 + arg_342_0 then
				arg_339_1.typewritter.percent = 1

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(true)
			end
		end

		arg_339_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_339_1:InitPlayNodeList()
	end,
	Play412031081 = function(arg_343_0, arg_343_1)
		arg_343_1.time_ = 0
		arg_343_1.frameCnt_ = 0
		arg_343_1.state_ = "playing"
		arg_343_1.curTalkId_ = 412031081
		arg_343_1.duration_ = 5

		SetActive(arg_343_1.tipsGo_, false)

		function arg_343_1.onSingleLineFinish_()
			arg_343_1.onSingleLineUpdate_ = nil
			arg_343_1.onSingleLineFinish_ = nil
			arg_343_1.state_ = "waiting"
		end

		function arg_343_1.playNext_(arg_345_0)
			if arg_345_0 == 1 then
				arg_343_0:Play412031082(arg_343_1)
			end
		end

		function arg_343_1.onSingleLineUpdate_(arg_346_0)
			if 0 < arg_343_1.time_ and arg_343_1.time_ <= 0 + arg_346_0 and not isNil(arg_343_1.actors_["1097ui_story"]) and arg_343_1.var_.characterEffect1097ui_story == nil then
				arg_343_1.var_.characterEffect1097ui_story = arg_343_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_346_0 = 0.200000002980232

			if 0 <= arg_343_1.time_ and arg_343_1.time_ < 0 + var_346_0 and not isNil(arg_343_1.actors_["1097ui_story"]) then
				if arg_343_1.var_.characterEffect1097ui_story and not isNil(arg_343_1.actors_["1097ui_story"]) then
					arg_343_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_343_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_343_1.time_ - 0) / var_346_0)
				end
			end

			if arg_343_1.time_ >= 0 + var_346_0 and arg_343_1.time_ < 0 + var_346_0 + arg_346_0 and not isNil(arg_343_1.actors_["1097ui_story"]) and arg_343_1.var_.characterEffect1097ui_story then
				arg_343_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_343_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_346_1 = 0
			local var_346_2 = 1.125

			if 0 < arg_343_1.time_ and arg_343_1.time_ <= var_346_1 + arg_346_0 then
				arg_343_1.talkMaxDuration = 0
				arg_343_1.dialogCg_.alpha = 1

				arg_343_1.dialog_:SetActive(true)
				SetActive(arg_343_1.leftNameGo_, false)

				arg_343_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_343_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_343_1:RecordName(arg_343_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_343_1.iconTrs_.gameObject, false)
				arg_343_1.callingController_:SetSelectedState("normal")

				local var_346_3 = arg_343_1:FormatText(arg_343_1:GetWordFromCfg(412031081).content)

				arg_343_1.text_.text = var_346_3

				LuaForUtil.ClearLinePrefixSymbol(arg_343_1.text_)

				local var_346_5 = 45 <= 0 and var_346_2 or var_346_2 * (utf8.len(var_346_3) / 45)

				if (45 <= 0 and var_346_2 or var_346_2 * (utf8.len(var_346_3) / 45)) > 0 and var_346_2 < var_346_5 then
					arg_343_1.talkMaxDuration = var_346_5

					if var_346_5 + var_346_1 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_5 + var_346_1
					end
				end

				arg_343_1.text_.text = var_346_3
				arg_343_1.typewritter.percent = 0

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(false)
				arg_343_1:RecordContent(arg_343_1.text_.text)
			end

			local var_346_6 = math.max(var_346_2, arg_343_1.talkMaxDuration)

			if var_346_1 <= arg_343_1.time_ and arg_343_1.time_ < var_346_1 + var_346_6 then
				arg_343_1.typewritter.percent = (arg_343_1.time_ - var_346_1) / var_346_6

				arg_343_1.typewritter:SetDirty()
			end

			if arg_343_1.time_ >= var_346_1 + var_346_6 and arg_343_1.time_ < var_346_1 + var_346_6 + arg_346_0 then
				arg_343_1.typewritter.percent = 1

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(true)
			end
		end

		arg_343_1.nodeConfigList_ = {}

		arg_343_1:InitPlayNodeList()
	end,
	Play412031082 = function(arg_347_0, arg_347_1)
		arg_347_1.time_ = 0
		arg_347_1.frameCnt_ = 0
		arg_347_1.state_ = "playing"
		arg_347_1.curTalkId_ = 412031082
		arg_347_1.duration_ = 3.87

		local var_347_0 = {
			zh = 3.866,
			ja = 3.1
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
				arg_347_0:Play412031083(arg_347_1)
			end
		end

		function arg_347_1.onSingleLineUpdate_(arg_350_0)
			if 0 < arg_347_1.time_ and arg_347_1.time_ <= 0 + arg_350_0 then
				arg_347_1.var_.moveOldPos10076ui_story = arg_347_1.actors_["10076ui_story"].transform.localPosition
			end

			local var_350_0 = 0.001

			if 0 <= arg_347_1.time_ and arg_347_1.time_ < 0 + var_350_0 then
				arg_347_1.actors_["10076ui_story"].transform.localPosition = Vector3.Lerp(arg_347_1.var_.moveOldPos10076ui_story, Vector3.New(-1, -0.35, -4), (arg_347_1.time_ - 0) / var_350_0)
				arg_347_1.actors_["10076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_347_1.actors_["10076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_347_1.actors_["10076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_347_1.actors_["10076ui_story"].transform.position).z)
				arg_347_1.actors_["10076ui_story"].transform.localEulerAngles.z = 0
				arg_347_1.actors_["10076ui_story"].transform.localEulerAngles.x = 0
				arg_347_1.actors_["10076ui_story"].transform.localEulerAngles = arg_347_1.actors_["10076ui_story"].transform.localEulerAngles
			end

			if arg_347_1.time_ >= 0 + var_350_0 and arg_347_1.time_ < 0 + var_350_0 + arg_350_0 then
				arg_347_1.actors_["10076ui_story"].transform.localPosition = Vector3.New(-1, -0.35, -4)
				arg_347_1.actors_["10076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_347_1.actors_["10076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_347_1.actors_["10076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_347_1.actors_["10076ui_story"].transform.position).z)
				arg_347_1.actors_["10076ui_story"].transform.localEulerAngles.z = 0
				arg_347_1.actors_["10076ui_story"].transform.localEulerAngles.x = 0
				arg_347_1.actors_["10076ui_story"].transform.localEulerAngles = arg_347_1.actors_["10076ui_story"].transform.localEulerAngles
			end

			local var_350_1 = arg_347_1.actors_["10076ui_story"]

			if 0 < arg_347_1.time_ and arg_347_1.time_ <= 0 + arg_350_0 and not isNil(var_350_1) and arg_347_1.var_.characterEffect10076ui_story == nil then
				arg_347_1.var_.characterEffect10076ui_story = var_350_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_350_2 = 0.200000002980232

			if 0 <= arg_347_1.time_ and arg_347_1.time_ < 0 + var_350_2 and not isNil(var_350_1) then
				if arg_347_1.var_.characterEffect10076ui_story and not isNil(var_350_1) then
					arg_347_1.var_.characterEffect10076ui_story.fillFlat = false
				end
			end

			if arg_347_1.time_ >= 0 + var_350_2 and arg_347_1.time_ < 0 + var_350_2 + arg_350_0 and not isNil(var_350_1) and arg_347_1.var_.characterEffect10076ui_story then
				arg_347_1.var_.characterEffect10076ui_story.fillFlat = false
			end

			if 0 < arg_347_1.time_ and arg_347_1.time_ <= 0 + arg_350_0 then
				arg_347_1:PlayTimeline("10076ui_story", "StoryTimeline/CharAction/story10076/story10076action/10076action1_1")
			end

			if 0 < arg_347_1.time_ and arg_347_1.time_ <= 0 + arg_350_0 then
				arg_347_1:PlayTimeline("10076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_350_4 = arg_347_1.actors_["1097ui_story"].transform

			if 0 < arg_347_1.time_ and arg_347_1.time_ <= 0 + arg_350_0 then
				arg_347_1.var_.moveOldPos1097ui_story = var_350_4.localPosition
			end

			local var_350_5 = 0.001

			if 0 <= arg_347_1.time_ and arg_347_1.time_ < 0 + var_350_5 then
				var_350_4.localPosition = Vector3.Lerp(arg_347_1.var_.moveOldPos1097ui_story, Vector3.New(0.7, -0.54, -6.3), (arg_347_1.time_ - 0) / var_350_5)
				var_350_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_350_4.position).x, (manager.ui.mainCamera.transform.position - var_350_4.position).y, (manager.ui.mainCamera.transform.position - var_350_4.position).z)
				var_350_4.localEulerAngles.z = 0
				var_350_4.localEulerAngles.x = 0
				var_350_4.localEulerAngles = var_350_4.localEulerAngles
			end

			if arg_347_1.time_ >= 0 + var_350_5 and arg_347_1.time_ < 0 + var_350_5 + arg_350_0 then
				var_350_4.localPosition = Vector3.New(0.7, -0.54, -6.3)
				var_350_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_350_4.position).x, (manager.ui.mainCamera.transform.position - var_350_4.position).y, (manager.ui.mainCamera.transform.position - var_350_4.position).z)
				var_350_4.localEulerAngles.z = 0
				var_350_4.localEulerAngles.x = 0
				var_350_4.localEulerAngles = var_350_4.localEulerAngles
			end

			local var_350_6 = 0
			local var_350_7 = 0.45

			if 0 < arg_347_1.time_ and arg_347_1.time_ <= var_350_6 + arg_350_0 then
				arg_347_1.talkMaxDuration = 0
				arg_347_1.dialogCg_.alpha = 1

				arg_347_1.dialog_:SetActive(true)
				SetActive(arg_347_1.leftNameGo_, true)

				arg_347_1.leftNameTxt_.text = arg_347_1:FormatText(StoryNameCfg[917].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_347_1.leftNameTxt_.transform)

				arg_347_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_347_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_347_1:RecordName(arg_347_1.leftNameTxt_.text)
				SetActive(arg_347_1.iconTrs_.gameObject, false)
				arg_347_1.callingController_:SetSelectedState("normal")

				local var_350_8 = arg_347_1:GetWordFromCfg(412031082)
				local var_350_9 = arg_347_1:FormatText(var_350_8.content)

				arg_347_1.text_.text = var_350_9

				LuaForUtil.ClearLinePrefixSymbol(arg_347_1.text_)

				local var_350_11 = 18 <= 0 and var_350_7 or var_350_7 * (utf8.len(var_350_9) / 18)

				if (18 <= 0 and var_350_7 or var_350_7 * (utf8.len(var_350_9) / 18)) > 0 and var_350_7 < var_350_11 then
					arg_347_1.talkMaxDuration = var_350_11

					if var_350_11 + var_350_6 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_11 + var_350_6
					end
				end

				arg_347_1.text_.text = var_350_9
				arg_347_1.typewritter.percent = 0

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031082", "story_v_out_412031.awb") ~= 0 then
					local var_350_12 = manager.audio:GetVoiceLength("story_v_out_412031", "412031082", "story_v_out_412031.awb") / 1000

					if var_350_12 + var_350_6 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_12 + var_350_6
					end

					if var_350_8.prefab_name ~= "" and arg_347_1.actors_[var_350_8.prefab_name] ~= nil then
						local var_350_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_347_1.actors_[var_350_8.prefab_name].transform, "story_v_out_412031", "412031082", "story_v_out_412031.awb")

						arg_347_1:RecordAudio("412031082", var_350_13)
						arg_347_1:RecordAudio("412031082", var_350_13)
					else
						arg_347_1:AudioAction("play", "voice", "story_v_out_412031", "412031082", "story_v_out_412031.awb")
					end

					arg_347_1:RecordHistoryTalkVoice("story_v_out_412031", "412031082", "story_v_out_412031.awb")
				end

				arg_347_1:RecordContent(arg_347_1.text_.text)
			end

			local var_350_14 = math.max(var_350_7, arg_347_1.talkMaxDuration)

			if var_350_6 <= arg_347_1.time_ and arg_347_1.time_ < var_350_6 + var_350_14 then
				arg_347_1.typewritter.percent = (arg_347_1.time_ - var_350_6) / var_350_14

				arg_347_1.typewritter:SetDirty()
			end

			if arg_347_1.time_ >= var_350_6 + var_350_14 and arg_347_1.time_ < var_350_6 + var_350_14 + arg_350_0 then
				arg_347_1.typewritter.percent = 1

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(true)
			end
		end

		arg_347_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_347_1:InitPlayNodeList()
	end,
	Play412031083 = function(arg_351_0, arg_351_1)
		arg_351_1.time_ = 0
		arg_351_1.frameCnt_ = 0
		arg_351_1.state_ = "playing"
		arg_351_1.curTalkId_ = 412031083
		arg_351_1.duration_ = 12.67

		local var_351_0 = {
			zh = 6.666,
			ja = 12.666
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
				arg_351_0:Play412031084(arg_351_1)
			end
		end

		function arg_351_1.onSingleLineUpdate_(arg_354_0)
			if 0 < arg_351_1.time_ and arg_351_1.time_ <= 0 + arg_354_0 and not isNil(arg_351_1.actors_["1097ui_story"]) and arg_351_1.var_.characterEffect1097ui_story == nil then
				arg_351_1.var_.characterEffect1097ui_story = arg_351_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_354_0 = 0.200000002980232

			if 0 <= arg_351_1.time_ and arg_351_1.time_ < 0 + var_354_0 and not isNil(arg_351_1.actors_["1097ui_story"]) then
				if arg_351_1.var_.characterEffect1097ui_story and not isNil(arg_351_1.actors_["1097ui_story"]) then
					arg_351_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_351_1.time_ >= 0 + var_354_0 and arg_351_1.time_ < 0 + var_354_0 + arg_354_0 and not isNil(arg_351_1.actors_["1097ui_story"]) and arg_351_1.var_.characterEffect1097ui_story then
				arg_351_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= 0 + arg_354_0 then
				arg_351_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= 0 + arg_354_0 then
				arg_351_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_354_2 = arg_351_1.actors_["10076ui_story"]

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= 0 + arg_354_0 and not isNil(var_354_2) and arg_351_1.var_.characterEffect10076ui_story == nil then
				arg_351_1.var_.characterEffect10076ui_story = var_354_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_354_3 = 0.200000002980232

			if 0 <= arg_351_1.time_ and arg_351_1.time_ < 0 + var_354_3 and not isNil(var_354_2) then
				if arg_351_1.var_.characterEffect10076ui_story and not isNil(var_354_2) then
					arg_351_1.var_.characterEffect10076ui_story.fillFlat = true
					arg_351_1.var_.characterEffect10076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_351_1.time_ - 0) / var_354_3)
				end
			end

			if arg_351_1.time_ >= 0 + var_354_3 and arg_351_1.time_ < 0 + var_354_3 + arg_354_0 and not isNil(var_354_2) and arg_351_1.var_.characterEffect10076ui_story then
				arg_351_1.var_.characterEffect10076ui_story.fillFlat = true
				arg_351_1.var_.characterEffect10076ui_story.fillRatio = 0.5
			end

			local var_354_4 = 0
			local var_354_5 = 0.6

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= var_354_4 + arg_354_0 then
				arg_351_1.talkMaxDuration = 0
				arg_351_1.dialogCg_.alpha = 1

				arg_351_1.dialog_:SetActive(true)
				SetActive(arg_351_1.leftNameGo_, true)

				arg_351_1.leftNameTxt_.text = arg_351_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_351_1.leftNameTxt_.transform)

				arg_351_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_351_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_351_1:RecordName(arg_351_1.leftNameTxt_.text)
				SetActive(arg_351_1.iconTrs_.gameObject, false)
				arg_351_1.callingController_:SetSelectedState("normal")

				local var_354_6 = arg_351_1:GetWordFromCfg(412031083)
				local var_354_7 = arg_351_1:FormatText(var_354_6.content)

				arg_351_1.text_.text = var_354_7

				LuaForUtil.ClearLinePrefixSymbol(arg_351_1.text_)

				local var_354_9 = 24 <= 0 and var_354_5 or var_354_5 * (utf8.len(var_354_7) / 24)

				if (24 <= 0 and var_354_5 or var_354_5 * (utf8.len(var_354_7) / 24)) > 0 and var_354_5 < var_354_9 then
					arg_351_1.talkMaxDuration = var_354_9

					if var_354_9 + var_354_4 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_9 + var_354_4
					end
				end

				arg_351_1.text_.text = var_354_7
				arg_351_1.typewritter.percent = 0

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031083", "story_v_out_412031.awb") ~= 0 then
					local var_354_10 = manager.audio:GetVoiceLength("story_v_out_412031", "412031083", "story_v_out_412031.awb") / 1000

					if var_354_10 + var_354_4 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_10 + var_354_4
					end

					if var_354_6.prefab_name ~= "" and arg_351_1.actors_[var_354_6.prefab_name] ~= nil then
						local var_354_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_351_1.actors_[var_354_6.prefab_name].transform, "story_v_out_412031", "412031083", "story_v_out_412031.awb")

						arg_351_1:RecordAudio("412031083", var_354_11)
						arg_351_1:RecordAudio("412031083", var_354_11)
					else
						arg_351_1:AudioAction("play", "voice", "story_v_out_412031", "412031083", "story_v_out_412031.awb")
					end

					arg_351_1:RecordHistoryTalkVoice("story_v_out_412031", "412031083", "story_v_out_412031.awb")
				end

				arg_351_1:RecordContent(arg_351_1.text_.text)
			end

			local var_354_12 = math.max(var_354_5, arg_351_1.talkMaxDuration)

			if var_354_4 <= arg_351_1.time_ and arg_351_1.time_ < var_354_4 + var_354_12 then
				arg_351_1.typewritter.percent = (arg_351_1.time_ - var_354_4) / var_354_12

				arg_351_1.typewritter:SetDirty()
			end

			if arg_351_1.time_ >= var_354_4 + var_354_12 and arg_351_1.time_ < var_354_4 + var_354_12 + arg_354_0 then
				arg_351_1.typewritter.percent = 1

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(true)
			end
		end

		arg_351_1.nodeConfigList_ = {}

		arg_351_1:InitPlayNodeList()
	end,
	Play412031084 = function(arg_355_0, arg_355_1)
		arg_355_1.time_ = 0
		arg_355_1.frameCnt_ = 0
		arg_355_1.state_ = "playing"
		arg_355_1.curTalkId_ = 412031084
		arg_355_1.duration_ = 5.67

		local var_355_0 = {
			zh = 5.666,
			ja = 2.833
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
				arg_355_0:Play412031085(arg_355_1)
			end
		end

		function arg_355_1.onSingleLineUpdate_(arg_358_0)
			local var_358_0 = 0.35

			if 0 < arg_355_1.time_ and arg_355_1.time_ <= 0 + arg_358_0 then
				arg_355_1.talkMaxDuration = 0
				arg_355_1.dialogCg_.alpha = 1

				arg_355_1.dialog_:SetActive(true)
				SetActive(arg_355_1.leftNameGo_, true)

				arg_355_1.leftNameTxt_.text = arg_355_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_355_1.leftNameTxt_.transform)

				arg_355_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_355_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_355_1:RecordName(arg_355_1.leftNameTxt_.text)
				SetActive(arg_355_1.iconTrs_.gameObject, false)
				arg_355_1.callingController_:SetSelectedState("normal")

				local var_358_1 = arg_355_1:GetWordFromCfg(412031084)
				local var_358_2 = arg_355_1:FormatText(var_358_1.content)

				arg_355_1.text_.text = var_358_2

				LuaForUtil.ClearLinePrefixSymbol(arg_355_1.text_)

				local var_358_4 = 14 <= 0 and var_358_0 or var_358_0 * (utf8.len(var_358_2) / 14)

				if (14 <= 0 and var_358_0 or var_358_0 * (utf8.len(var_358_2) / 14)) > 0 and var_358_0 < var_358_4 then
					arg_355_1.talkMaxDuration = var_358_4

					if var_358_4 + 0 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_4 + 0
					end
				end

				arg_355_1.text_.text = var_358_2
				arg_355_1.typewritter.percent = 0

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031084", "story_v_out_412031.awb") ~= 0 then
					local var_358_5 = manager.audio:GetVoiceLength("story_v_out_412031", "412031084", "story_v_out_412031.awb") / 1000

					if var_358_5 + 0 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_5 + 0
					end

					if var_358_1.prefab_name ~= "" and arg_355_1.actors_[var_358_1.prefab_name] ~= nil then
						local var_358_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_355_1.actors_[var_358_1.prefab_name].transform, "story_v_out_412031", "412031084", "story_v_out_412031.awb")

						arg_355_1:RecordAudio("412031084", var_358_6)
						arg_355_1:RecordAudio("412031084", var_358_6)
					else
						arg_355_1:AudioAction("play", "voice", "story_v_out_412031", "412031084", "story_v_out_412031.awb")
					end

					arg_355_1:RecordHistoryTalkVoice("story_v_out_412031", "412031084", "story_v_out_412031.awb")
				end

				arg_355_1:RecordContent(arg_355_1.text_.text)
			end

			local var_358_7 = math.max(var_358_0, arg_355_1.talkMaxDuration)

			if 0 <= arg_355_1.time_ and arg_355_1.time_ < 0 + var_358_7 then
				arg_355_1.typewritter.percent = (arg_355_1.time_ - 0) / var_358_7

				arg_355_1.typewritter:SetDirty()
			end

			if arg_355_1.time_ >= 0 + var_358_7 and arg_355_1.time_ < 0 + var_358_7 + arg_358_0 then
				arg_355_1.typewritter.percent = 1

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(true)
			end
		end

		arg_355_1.nodeConfigList_ = {}

		arg_355_1:InitPlayNodeList()
	end,
	Play412031085 = function(arg_359_0, arg_359_1)
		arg_359_1.time_ = 0
		arg_359_1.frameCnt_ = 0
		arg_359_1.state_ = "playing"
		arg_359_1.curTalkId_ = 412031085
		arg_359_1.duration_ = 5

		SetActive(arg_359_1.tipsGo_, false)

		function arg_359_1.onSingleLineFinish_()
			arg_359_1.onSingleLineUpdate_ = nil
			arg_359_1.onSingleLineFinish_ = nil
			arg_359_1.state_ = "waiting"
		end

		function arg_359_1.playNext_(arg_361_0)
			if arg_361_0 == 1 then
				arg_359_0:Play412031086(arg_359_1)
			end
		end

		function arg_359_1.onSingleLineUpdate_(arg_362_0)
			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 then
				arg_359_1.var_.moveOldPos10076ui_story = arg_359_1.actors_["10076ui_story"].transform.localPosition
			end

			local var_362_0 = 0.001

			if 0 <= arg_359_1.time_ and arg_359_1.time_ < 0 + var_362_0 then
				arg_359_1.actors_["10076ui_story"].transform.localPosition = Vector3.Lerp(arg_359_1.var_.moveOldPos10076ui_story, Vector3.New(0, 100, 0), (arg_359_1.time_ - 0) / var_362_0)
				arg_359_1.actors_["10076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_359_1.actors_["10076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_359_1.actors_["10076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_359_1.actors_["10076ui_story"].transform.position).z)
				arg_359_1.actors_["10076ui_story"].transform.localEulerAngles.z = 0
				arg_359_1.actors_["10076ui_story"].transform.localEulerAngles.x = 0
				arg_359_1.actors_["10076ui_story"].transform.localEulerAngles = arg_359_1.actors_["10076ui_story"].transform.localEulerAngles
			end

			if arg_359_1.time_ >= 0 + var_362_0 and arg_359_1.time_ < 0 + var_362_0 + arg_362_0 then
				arg_359_1.actors_["10076ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_359_1.actors_["10076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_359_1.actors_["10076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_359_1.actors_["10076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_359_1.actors_["10076ui_story"].transform.position).z)
				arg_359_1.actors_["10076ui_story"].transform.localEulerAngles.z = 0
				arg_359_1.actors_["10076ui_story"].transform.localEulerAngles.x = 0
				arg_359_1.actors_["10076ui_story"].transform.localEulerAngles = arg_359_1.actors_["10076ui_story"].transform.localEulerAngles
			end

			local var_362_1 = arg_359_1.actors_["10076ui_story"]

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 and not isNil(var_362_1) and arg_359_1.var_.characterEffect10076ui_story == nil then
				arg_359_1.var_.characterEffect10076ui_story = var_362_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_362_2 = 0.200000002980232

			if 0 <= arg_359_1.time_ and arg_359_1.time_ < 0 + var_362_2 and not isNil(var_362_1) then
				if arg_359_1.var_.characterEffect10076ui_story and not isNil(var_362_1) then
					arg_359_1.var_.characterEffect10076ui_story.fillFlat = true
					arg_359_1.var_.characterEffect10076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_359_1.time_ - 0) / var_362_2)
				end
			end

			if arg_359_1.time_ >= 0 + var_362_2 and arg_359_1.time_ < 0 + var_362_2 + arg_362_0 and not isNil(var_362_1) and arg_359_1.var_.characterEffect10076ui_story then
				arg_359_1.var_.characterEffect10076ui_story.fillFlat = true
				arg_359_1.var_.characterEffect10076ui_story.fillRatio = 0.5
			end

			local var_362_3 = arg_359_1.actors_["1097ui_story"].transform

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 then
				arg_359_1.var_.moveOldPos1097ui_story = var_362_3.localPosition
			end

			local var_362_4 = 0.001

			if 0 <= arg_359_1.time_ and arg_359_1.time_ < 0 + var_362_4 then
				var_362_3.localPosition = Vector3.Lerp(arg_359_1.var_.moveOldPos1097ui_story, Vector3.New(0, 100, 0), (arg_359_1.time_ - 0) / var_362_4)
				var_362_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_362_3.position).x, (manager.ui.mainCamera.transform.position - var_362_3.position).y, (manager.ui.mainCamera.transform.position - var_362_3.position).z)
				var_362_3.localEulerAngles.z = 0
				var_362_3.localEulerAngles.x = 0
				var_362_3.localEulerAngles = var_362_3.localEulerAngles
			end

			if arg_359_1.time_ >= 0 + var_362_4 and arg_359_1.time_ < 0 + var_362_4 + arg_362_0 then
				var_362_3.localPosition = Vector3.New(0, 100, 0)
				var_362_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_362_3.position).x, (manager.ui.mainCamera.transform.position - var_362_3.position).y, (manager.ui.mainCamera.transform.position - var_362_3.position).z)
				var_362_3.localEulerAngles.z = 0
				var_362_3.localEulerAngles.x = 0
				var_362_3.localEulerAngles = var_362_3.localEulerAngles
			end

			local var_362_5 = arg_359_1.actors_["1097ui_story"]

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 and not isNil(var_362_5) and arg_359_1.var_.characterEffect1097ui_story == nil then
				arg_359_1.var_.characterEffect1097ui_story = var_362_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_362_6 = 0.200000002980232

			if 0 <= arg_359_1.time_ and arg_359_1.time_ < 0 + var_362_6 and not isNil(var_362_5) then
				if arg_359_1.var_.characterEffect1097ui_story and not isNil(var_362_5) then
					arg_359_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_359_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_359_1.time_ - 0) / var_362_6)
				end
			end

			if arg_359_1.time_ >= 0 + var_362_6 and arg_359_1.time_ < 0 + var_362_6 + arg_362_0 and not isNil(var_362_5) and arg_359_1.var_.characterEffect1097ui_story then
				arg_359_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_359_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_362_7 = 0
			local var_362_8 = 0.375

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= var_362_7 + arg_362_0 then
				arg_359_1.talkMaxDuration = 0
				arg_359_1.dialogCg_.alpha = 1

				arg_359_1.dialog_:SetActive(true)
				SetActive(arg_359_1.leftNameGo_, false)

				arg_359_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_359_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_359_1:RecordName(arg_359_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_359_1.iconTrs_.gameObject, false)
				arg_359_1.callingController_:SetSelectedState("normal")

				local var_362_9 = arg_359_1:FormatText(arg_359_1:GetWordFromCfg(412031085).content)

				arg_359_1.text_.text = var_362_9

				LuaForUtil.ClearLinePrefixSymbol(arg_359_1.text_)

				local var_362_11 = 15 <= 0 and var_362_8 or var_362_8 * (utf8.len(var_362_9) / 15)

				if (15 <= 0 and var_362_8 or var_362_8 * (utf8.len(var_362_9) / 15)) > 0 and var_362_8 < var_362_11 then
					arg_359_1.talkMaxDuration = var_362_11

					if var_362_11 + var_362_7 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_11 + var_362_7
					end
				end

				arg_359_1.text_.text = var_362_9
				arg_359_1.typewritter.percent = 0

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(false)
				arg_359_1:RecordContent(arg_359_1.text_.text)
			end

			local var_362_12 = math.max(var_362_8, arg_359_1.talkMaxDuration)

			if var_362_7 <= arg_359_1.time_ and arg_359_1.time_ < var_362_7 + var_362_12 then
				arg_359_1.typewritter.percent = (arg_359_1.time_ - var_362_7) / var_362_12

				arg_359_1.typewritter:SetDirty()
			end

			if arg_359_1.time_ >= var_362_7 + var_362_12 and arg_359_1.time_ < var_362_7 + var_362_12 + arg_362_0 then
				arg_359_1.typewritter.percent = 1

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(true)
			end
		end

		arg_359_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1097ui_story",
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
	Play412031086 = function(arg_363_0, arg_363_1)
		arg_363_1.time_ = 0
		arg_363_1.frameCnt_ = 0
		arg_363_1.state_ = "playing"
		arg_363_1.curTalkId_ = 412031086
		arg_363_1.duration_ = 2.47

		local var_363_0 = {
			zh = 1.999999999999,
			ja = 2.466
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
				arg_363_0:Play412031087(arg_363_1)
			end
		end

		function arg_363_1.onSingleLineUpdate_(arg_366_0)
			if 0 < arg_363_1.time_ and arg_363_1.time_ <= 0 + arg_366_0 then
				arg_363_1.var_.moveOldPos3043ui_story = arg_363_1.actors_["3043ui_story"].transform.localPosition
			end

			local var_366_0 = 0.001

			if 0 <= arg_363_1.time_ and arg_363_1.time_ < 0 + var_366_0 then
				arg_363_1.actors_["3043ui_story"].transform.localPosition = Vector3.Lerp(arg_363_1.var_.moveOldPos3043ui_story, Vector3.New(0, -1.41, -5.7), (arg_363_1.time_ - 0) / var_366_0)
				arg_363_1.actors_["3043ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_363_1.actors_["3043ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_363_1.actors_["3043ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_363_1.actors_["3043ui_story"].transform.position).z)
				arg_363_1.actors_["3043ui_story"].transform.localEulerAngles.z = 0
				arg_363_1.actors_["3043ui_story"].transform.localEulerAngles.x = 0
				arg_363_1.actors_["3043ui_story"].transform.localEulerAngles = arg_363_1.actors_["3043ui_story"].transform.localEulerAngles
			end

			if arg_363_1.time_ >= 0 + var_366_0 and arg_363_1.time_ < 0 + var_366_0 + arg_366_0 then
				arg_363_1.actors_["3043ui_story"].transform.localPosition = Vector3.New(0, -1.41, -5.7)
				arg_363_1.actors_["3043ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_363_1.actors_["3043ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_363_1.actors_["3043ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_363_1.actors_["3043ui_story"].transform.position).z)
				arg_363_1.actors_["3043ui_story"].transform.localEulerAngles.z = 0
				arg_363_1.actors_["3043ui_story"].transform.localEulerAngles.x = 0
				arg_363_1.actors_["3043ui_story"].transform.localEulerAngles = arg_363_1.actors_["3043ui_story"].transform.localEulerAngles
			end

			local var_366_1 = arg_363_1.actors_["3043ui_story"]

			if 0 < arg_363_1.time_ and arg_363_1.time_ <= 0 + arg_366_0 and not isNil(var_366_1) and arg_363_1.var_.characterEffect3043ui_story == nil then
				arg_363_1.var_.characterEffect3043ui_story = var_366_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_366_2 = 0.200000002980232

			if 0 <= arg_363_1.time_ and arg_363_1.time_ < 0 + var_366_2 and not isNil(var_366_1) then
				if arg_363_1.var_.characterEffect3043ui_story and not isNil(var_366_1) then
					arg_363_1.var_.characterEffect3043ui_story.fillFlat = false
				end
			end

			if arg_363_1.time_ >= 0 + var_366_2 and arg_363_1.time_ < 0 + var_366_2 + arg_366_0 and not isNil(var_366_1) and arg_363_1.var_.characterEffect3043ui_story then
				arg_363_1.var_.characterEffect3043ui_story.fillFlat = false
			end

			if 0 < arg_363_1.time_ and arg_363_1.time_ <= 0 + arg_366_0 then
				arg_363_1:PlayTimeline("3043ui_story", "StoryTimeline/CharAction/story3043/story3043action/3043action1_1")
			end

			if 0 < arg_363_1.time_ and arg_363_1.time_ <= 0 + arg_366_0 then
				arg_363_1:PlayTimeline("3043ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_366_4 = 0
			local var_366_5 = 0.15

			if 0 < arg_363_1.time_ and arg_363_1.time_ <= var_366_4 + arg_366_0 then
				arg_363_1.talkMaxDuration = 0
				arg_363_1.dialogCg_.alpha = 1

				arg_363_1.dialog_:SetActive(true)
				SetActive(arg_363_1.leftNameGo_, true)

				arg_363_1.leftNameTxt_.text = arg_363_1:FormatText(StoryNameCfg[920].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_363_1.leftNameTxt_.transform)

				arg_363_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_363_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_363_1:RecordName(arg_363_1.leftNameTxt_.text)
				SetActive(arg_363_1.iconTrs_.gameObject, false)
				arg_363_1.callingController_:SetSelectedState("normal")

				local var_366_6 = arg_363_1:GetWordFromCfg(412031086)
				local var_366_7 = arg_363_1:FormatText(var_366_6.content)

				arg_363_1.text_.text = var_366_7

				LuaForUtil.ClearLinePrefixSymbol(arg_363_1.text_)

				local var_366_9 = 6 <= 0 and var_366_5 or var_366_5 * (utf8.len(var_366_7) / 6)

				if (6 <= 0 and var_366_5 or var_366_5 * (utf8.len(var_366_7) / 6)) > 0 and var_366_5 < var_366_9 then
					arg_363_1.talkMaxDuration = var_366_9

					if var_366_9 + var_366_4 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_9 + var_366_4
					end
				end

				arg_363_1.text_.text = var_366_7
				arg_363_1.typewritter.percent = 0

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031086", "story_v_out_412031.awb") ~= 0 then
					local var_366_10 = manager.audio:GetVoiceLength("story_v_out_412031", "412031086", "story_v_out_412031.awb") / 1000

					if var_366_10 + var_366_4 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_10 + var_366_4
					end

					if var_366_6.prefab_name ~= "" and arg_363_1.actors_[var_366_6.prefab_name] ~= nil then
						local var_366_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_363_1.actors_[var_366_6.prefab_name].transform, "story_v_out_412031", "412031086", "story_v_out_412031.awb")

						arg_363_1:RecordAudio("412031086", var_366_11)
						arg_363_1:RecordAudio("412031086", var_366_11)
					else
						arg_363_1:AudioAction("play", "voice", "story_v_out_412031", "412031086", "story_v_out_412031.awb")
					end

					arg_363_1:RecordHistoryTalkVoice("story_v_out_412031", "412031086", "story_v_out_412031.awb")
				end

				arg_363_1:RecordContent(arg_363_1.text_.text)
			end

			local var_366_12 = math.max(var_366_5, arg_363_1.talkMaxDuration)

			if var_366_4 <= arg_363_1.time_ and arg_363_1.time_ < var_366_4 + var_366_12 then
				arg_363_1.typewritter.percent = (arg_363_1.time_ - var_366_4) / var_366_12

				arg_363_1.typewritter:SetDirty()
			end

			if arg_363_1.time_ >= var_366_4 + var_366_12 and arg_363_1.time_ < var_366_4 + var_366_12 + arg_366_0 then
				arg_363_1.typewritter.percent = 1

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(true)
			end
		end

		arg_363_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_363_1:InitPlayNodeList()
	end,
	Play412031087 = function(arg_367_0, arg_367_1)
		arg_367_1.time_ = 0
		arg_367_1.frameCnt_ = 0
		arg_367_1.state_ = "playing"
		arg_367_1.curTalkId_ = 412031087
		arg_367_1.duration_ = 10.3

		local var_367_0 = {
			zh = 5.966,
			ja = 10.3
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
				arg_367_0:Play412031088(arg_367_1)
			end
		end

		function arg_367_1.onSingleLineUpdate_(arg_370_0)
			if 0 < arg_367_1.time_ and arg_367_1.time_ <= 0 + arg_370_0 then
				arg_367_1.var_.moveOldPos1097ui_story = arg_367_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_370_0 = 0.001

			if 0 <= arg_367_1.time_ and arg_367_1.time_ < 0 + var_370_0 then
				arg_367_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_367_1.var_.moveOldPos1097ui_story, Vector3.New(0.7, -0.54, -6.3), (arg_367_1.time_ - 0) / var_370_0)
				arg_367_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_367_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_367_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_367_1.actors_["1097ui_story"].transform.position).z)
				arg_367_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_367_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_367_1.actors_["1097ui_story"].transform.localEulerAngles = arg_367_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_367_1.time_ >= 0 + var_370_0 and arg_367_1.time_ < 0 + var_370_0 + arg_370_0 then
				arg_367_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(0.7, -0.54, -6.3)
				arg_367_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_367_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_367_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_367_1.actors_["1097ui_story"].transform.position).z)
				arg_367_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_367_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_367_1.actors_["1097ui_story"].transform.localEulerAngles = arg_367_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_370_1 = arg_367_1.actors_["1097ui_story"]

			if 0 < arg_367_1.time_ and arg_367_1.time_ <= 0 + arg_370_0 and not isNil(var_370_1) and arg_367_1.var_.characterEffect1097ui_story == nil then
				arg_367_1.var_.characterEffect1097ui_story = var_370_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_370_2 = 0.200000002980232

			if 0 <= arg_367_1.time_ and arg_367_1.time_ < 0 + var_370_2 and not isNil(var_370_1) then
				if arg_367_1.var_.characterEffect1097ui_story and not isNil(var_370_1) then
					arg_367_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_367_1.time_ >= 0 + var_370_2 and arg_367_1.time_ < 0 + var_370_2 + arg_370_0 and not isNil(var_370_1) and arg_367_1.var_.characterEffect1097ui_story then
				arg_367_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_367_1.time_ and arg_367_1.time_ <= 0 + arg_370_0 then
				arg_367_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			if 0 < arg_367_1.time_ and arg_367_1.time_ <= 0 + arg_370_0 then
				arg_367_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_370_4 = arg_367_1.actors_["3043ui_story"]

			if 0 < arg_367_1.time_ and arg_367_1.time_ <= 0 + arg_370_0 and not isNil(var_370_4) and arg_367_1.var_.characterEffect3043ui_story == nil then
				arg_367_1.var_.characterEffect3043ui_story = var_370_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_370_5 = 0.200000002980232

			if 0 <= arg_367_1.time_ and arg_367_1.time_ < 0 + var_370_5 and not isNil(var_370_4) then
				if arg_367_1.var_.characterEffect3043ui_story and not isNil(var_370_4) then
					arg_367_1.var_.characterEffect3043ui_story.fillFlat = true
					arg_367_1.var_.characterEffect3043ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_367_1.time_ - 0) / var_370_5)
				end
			end

			if arg_367_1.time_ >= 0 + var_370_5 and arg_367_1.time_ < 0 + var_370_5 + arg_370_0 and not isNil(var_370_4) and arg_367_1.var_.characterEffect3043ui_story then
				arg_367_1.var_.characterEffect3043ui_story.fillFlat = true
				arg_367_1.var_.characterEffect3043ui_story.fillRatio = 0.5
			end

			local var_370_6 = arg_367_1.actors_["3043ui_story"].transform

			if 0 < arg_367_1.time_ and arg_367_1.time_ <= 0 + arg_370_0 then
				arg_367_1.var_.moveOldPos3043ui_story = var_370_6.localPosition
			end

			local var_370_7 = 0.001

			if 0 <= arg_367_1.time_ and arg_367_1.time_ < 0 + var_370_7 then
				var_370_6.localPosition = Vector3.Lerp(arg_367_1.var_.moveOldPos3043ui_story, Vector3.New(-0.7, -1.41, -5.7), (arg_367_1.time_ - 0) / var_370_7)
				var_370_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_370_6.position).x, (manager.ui.mainCamera.transform.position - var_370_6.position).y, (manager.ui.mainCamera.transform.position - var_370_6.position).z)
				var_370_6.localEulerAngles.z = 0
				var_370_6.localEulerAngles.x = 0
				var_370_6.localEulerAngles = var_370_6.localEulerAngles
			end

			if arg_367_1.time_ >= 0 + var_370_7 and arg_367_1.time_ < 0 + var_370_7 + arg_370_0 then
				var_370_6.localPosition = Vector3.New(-0.7, -1.41, -5.7)
				var_370_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_370_6.position).x, (manager.ui.mainCamera.transform.position - var_370_6.position).y, (manager.ui.mainCamera.transform.position - var_370_6.position).z)
				var_370_6.localEulerAngles.z = 0
				var_370_6.localEulerAngles.x = 0
				var_370_6.localEulerAngles = var_370_6.localEulerAngles
			end

			local var_370_8 = 0
			local var_370_9 = 0.525

			if 0 < arg_367_1.time_ and arg_367_1.time_ <= var_370_8 + arg_370_0 then
				arg_367_1.talkMaxDuration = 0
				arg_367_1.dialogCg_.alpha = 1

				arg_367_1.dialog_:SetActive(true)
				SetActive(arg_367_1.leftNameGo_, true)

				arg_367_1.leftNameTxt_.text = arg_367_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_367_1.leftNameTxt_.transform)

				arg_367_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_367_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_367_1:RecordName(arg_367_1.leftNameTxt_.text)
				SetActive(arg_367_1.iconTrs_.gameObject, false)
				arg_367_1.callingController_:SetSelectedState("normal")

				local var_370_10 = arg_367_1:GetWordFromCfg(412031087)
				local var_370_11 = arg_367_1:FormatText(var_370_10.content)

				arg_367_1.text_.text = var_370_11

				LuaForUtil.ClearLinePrefixSymbol(arg_367_1.text_)

				local var_370_13 = 21 <= 0 and var_370_9 or var_370_9 * (utf8.len(var_370_11) / 21)

				if (21 <= 0 and var_370_9 or var_370_9 * (utf8.len(var_370_11) / 21)) > 0 and var_370_9 < var_370_13 then
					arg_367_1.talkMaxDuration = var_370_13

					if var_370_13 + var_370_8 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_13 + var_370_8
					end
				end

				arg_367_1.text_.text = var_370_11
				arg_367_1.typewritter.percent = 0

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031087", "story_v_out_412031.awb") ~= 0 then
					local var_370_14 = manager.audio:GetVoiceLength("story_v_out_412031", "412031087", "story_v_out_412031.awb") / 1000

					if var_370_14 + var_370_8 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_14 + var_370_8
					end

					if var_370_10.prefab_name ~= "" and arg_367_1.actors_[var_370_10.prefab_name] ~= nil then
						local var_370_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_367_1.actors_[var_370_10.prefab_name].transform, "story_v_out_412031", "412031087", "story_v_out_412031.awb")

						arg_367_1:RecordAudio("412031087", var_370_15)
						arg_367_1:RecordAudio("412031087", var_370_15)
					else
						arg_367_1:AudioAction("play", "voice", "story_v_out_412031", "412031087", "story_v_out_412031.awb")
					end

					arg_367_1:RecordHistoryTalkVoice("story_v_out_412031", "412031087", "story_v_out_412031.awb")
				end

				arg_367_1:RecordContent(arg_367_1.text_.text)
			end

			local var_370_16 = math.max(var_370_9, arg_367_1.talkMaxDuration)

			if var_370_8 <= arg_367_1.time_ and arg_367_1.time_ < var_370_8 + var_370_16 then
				arg_367_1.typewritter.percent = (arg_367_1.time_ - var_370_8) / var_370_16

				arg_367_1.typewritter:SetDirty()
			end

			if arg_367_1.time_ >= var_370_8 + var_370_16 and arg_367_1.time_ < var_370_8 + var_370_16 + arg_370_0 then
				arg_367_1.typewritter.percent = 1

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(true)
			end
		end

		arg_367_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "3043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_367_1:InitPlayNodeList()
	end,
	Play412031088 = function(arg_371_0, arg_371_1)
		arg_371_1.time_ = 0
		arg_371_1.frameCnt_ = 0
		arg_371_1.state_ = "playing"
		arg_371_1.curTalkId_ = 412031088
		arg_371_1.duration_ = 7.27

		local var_371_0 = {
			zh = 3.333,
			ja = 7.266
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
				arg_371_0:Play412031089(arg_371_1)
			end
		end

		function arg_371_1.onSingleLineUpdate_(arg_374_0)
			if 0 < arg_371_1.time_ and arg_371_1.time_ <= 0 + arg_374_0 and not isNil(arg_371_1.actors_["3043ui_story"]) and arg_371_1.var_.characterEffect3043ui_story == nil then
				arg_371_1.var_.characterEffect3043ui_story = arg_371_1.actors_["3043ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_374_0 = 0.200000002980232

			if 0 <= arg_371_1.time_ and arg_371_1.time_ < 0 + var_374_0 and not isNil(arg_371_1.actors_["3043ui_story"]) then
				if arg_371_1.var_.characterEffect3043ui_story and not isNil(arg_371_1.actors_["3043ui_story"]) then
					arg_371_1.var_.characterEffect3043ui_story.fillFlat = false
				end
			end

			if arg_371_1.time_ >= 0 + var_374_0 and arg_371_1.time_ < 0 + var_374_0 + arg_374_0 and not isNil(arg_371_1.actors_["3043ui_story"]) and arg_371_1.var_.characterEffect3043ui_story then
				arg_371_1.var_.characterEffect3043ui_story.fillFlat = false
			end

			if 0 < arg_371_1.time_ and arg_371_1.time_ <= 0 + arg_374_0 then
				arg_371_1:PlayTimeline("3043ui_story", "StoryTimeline/CharAction/story3043/story3043action/3043action1_1")
			end

			if 0 < arg_371_1.time_ and arg_371_1.time_ <= 0 + arg_374_0 then
				arg_371_1:PlayTimeline("3043ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_374_2 = arg_371_1.actors_["1097ui_story"]

			if 0 < arg_371_1.time_ and arg_371_1.time_ <= 0 + arg_374_0 and not isNil(var_374_2) and arg_371_1.var_.characterEffect1097ui_story == nil then
				arg_371_1.var_.characterEffect1097ui_story = var_374_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_374_3 = 0.200000002980232

			if 0 <= arg_371_1.time_ and arg_371_1.time_ < 0 + var_374_3 and not isNil(var_374_2) then
				if arg_371_1.var_.characterEffect1097ui_story and not isNil(var_374_2) then
					arg_371_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_371_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_371_1.time_ - 0) / var_374_3)
				end
			end

			if arg_371_1.time_ >= 0 + var_374_3 and arg_371_1.time_ < 0 + var_374_3 + arg_374_0 and not isNil(var_374_2) and arg_371_1.var_.characterEffect1097ui_story then
				arg_371_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_371_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_374_4 = 0
			local var_374_5 = 0.275

			if 0 < arg_371_1.time_ and arg_371_1.time_ <= var_374_4 + arg_374_0 then
				arg_371_1.talkMaxDuration = 0
				arg_371_1.dialogCg_.alpha = 1

				arg_371_1.dialog_:SetActive(true)
				SetActive(arg_371_1.leftNameGo_, true)

				arg_371_1.leftNameTxt_.text = arg_371_1:FormatText(StoryNameCfg[920].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_371_1.leftNameTxt_.transform)

				arg_371_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_371_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_371_1:RecordName(arg_371_1.leftNameTxt_.text)
				SetActive(arg_371_1.iconTrs_.gameObject, false)
				arg_371_1.callingController_:SetSelectedState("normal")

				local var_374_6 = arg_371_1:GetWordFromCfg(412031088)
				local var_374_7 = arg_371_1:FormatText(var_374_6.content)

				arg_371_1.text_.text = var_374_7

				LuaForUtil.ClearLinePrefixSymbol(arg_371_1.text_)

				local var_374_9 = 11 <= 0 and var_374_5 or var_374_5 * (utf8.len(var_374_7) / 11)

				if (11 <= 0 and var_374_5 or var_374_5 * (utf8.len(var_374_7) / 11)) > 0 and var_374_5 < var_374_9 then
					arg_371_1.talkMaxDuration = var_374_9

					if var_374_9 + var_374_4 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_9 + var_374_4
					end
				end

				arg_371_1.text_.text = var_374_7
				arg_371_1.typewritter.percent = 0

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031088", "story_v_out_412031.awb") ~= 0 then
					local var_374_10 = manager.audio:GetVoiceLength("story_v_out_412031", "412031088", "story_v_out_412031.awb") / 1000

					if var_374_10 + var_374_4 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_10 + var_374_4
					end

					if var_374_6.prefab_name ~= "" and arg_371_1.actors_[var_374_6.prefab_name] ~= nil then
						local var_374_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_371_1.actors_[var_374_6.prefab_name].transform, "story_v_out_412031", "412031088", "story_v_out_412031.awb")

						arg_371_1:RecordAudio("412031088", var_374_11)
						arg_371_1:RecordAudio("412031088", var_374_11)
					else
						arg_371_1:AudioAction("play", "voice", "story_v_out_412031", "412031088", "story_v_out_412031.awb")
					end

					arg_371_1:RecordHistoryTalkVoice("story_v_out_412031", "412031088", "story_v_out_412031.awb")
				end

				arg_371_1:RecordContent(arg_371_1.text_.text)
			end

			local var_374_12 = math.max(var_374_5, arg_371_1.talkMaxDuration)

			if var_374_4 <= arg_371_1.time_ and arg_371_1.time_ < var_374_4 + var_374_12 then
				arg_371_1.typewritter.percent = (arg_371_1.time_ - var_374_4) / var_374_12

				arg_371_1.typewritter:SetDirty()
			end

			if arg_371_1.time_ >= var_374_4 + var_374_12 and arg_371_1.time_ < var_374_4 + var_374_12 + arg_374_0 then
				arg_371_1.typewritter.percent = 1

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(true)
			end
		end

		arg_371_1.nodeConfigList_ = {}

		arg_371_1:InitPlayNodeList()
	end,
	Play412031089 = function(arg_375_0, arg_375_1)
		arg_375_1.time_ = 0
		arg_375_1.frameCnt_ = 0
		arg_375_1.state_ = "playing"
		arg_375_1.curTalkId_ = 412031089
		arg_375_1.duration_ = 3.93

		local var_375_0 = {
			zh = 2.633,
			ja = 3.933
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
				arg_375_0:Play412031090(arg_375_1)
			end
		end

		function arg_375_1.onSingleLineUpdate_(arg_378_0)
			if 0 < arg_375_1.time_ and arg_375_1.time_ <= 0 + arg_378_0 and not isNil(arg_375_1.actors_["1097ui_story"]) and arg_375_1.var_.characterEffect1097ui_story == nil then
				arg_375_1.var_.characterEffect1097ui_story = arg_375_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_378_0 = 0.200000002980232

			if 0 <= arg_375_1.time_ and arg_375_1.time_ < 0 + var_378_0 and not isNil(arg_375_1.actors_["1097ui_story"]) then
				if arg_375_1.var_.characterEffect1097ui_story and not isNil(arg_375_1.actors_["1097ui_story"]) then
					arg_375_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_375_1.time_ >= 0 + var_378_0 and arg_375_1.time_ < 0 + var_378_0 + arg_378_0 and not isNil(arg_375_1.actors_["1097ui_story"]) and arg_375_1.var_.characterEffect1097ui_story then
				arg_375_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_375_1.time_ and arg_375_1.time_ <= 0 + arg_378_0 then
				arg_375_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			if 0 < arg_375_1.time_ and arg_375_1.time_ <= 0 + arg_378_0 then
				arg_375_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_378_2 = arg_375_1.actors_["3043ui_story"]

			if 0 < arg_375_1.time_ and arg_375_1.time_ <= 0 + arg_378_0 and not isNil(var_378_2) and arg_375_1.var_.characterEffect3043ui_story == nil then
				arg_375_1.var_.characterEffect3043ui_story = var_378_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_378_3 = 0.200000002980232

			if 0 <= arg_375_1.time_ and arg_375_1.time_ < 0 + var_378_3 and not isNil(var_378_2) then
				if arg_375_1.var_.characterEffect3043ui_story and not isNil(var_378_2) then
					arg_375_1.var_.characterEffect3043ui_story.fillFlat = true
					arg_375_1.var_.characterEffect3043ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_375_1.time_ - 0) / var_378_3)
				end
			end

			if arg_375_1.time_ >= 0 + var_378_3 and arg_375_1.time_ < 0 + var_378_3 + arg_378_0 and not isNil(var_378_2) and arg_375_1.var_.characterEffect3043ui_story then
				arg_375_1.var_.characterEffect3043ui_story.fillFlat = true
				arg_375_1.var_.characterEffect3043ui_story.fillRatio = 0.5
			end

			local var_378_4 = 0
			local var_378_5 = 0.175

			if 0 < arg_375_1.time_ and arg_375_1.time_ <= var_378_4 + arg_378_0 then
				arg_375_1.talkMaxDuration = 0
				arg_375_1.dialogCg_.alpha = 1

				arg_375_1.dialog_:SetActive(true)
				SetActive(arg_375_1.leftNameGo_, true)

				arg_375_1.leftNameTxt_.text = arg_375_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_375_1.leftNameTxt_.transform)

				arg_375_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_375_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_375_1:RecordName(arg_375_1.leftNameTxt_.text)
				SetActive(arg_375_1.iconTrs_.gameObject, false)
				arg_375_1.callingController_:SetSelectedState("normal")

				local var_378_6 = arg_375_1:GetWordFromCfg(412031089)
				local var_378_7 = arg_375_1:FormatText(var_378_6.content)

				arg_375_1.text_.text = var_378_7

				LuaForUtil.ClearLinePrefixSymbol(arg_375_1.text_)

				local var_378_9 = 7 <= 0 and var_378_5 or var_378_5 * (utf8.len(var_378_7) / 7)

				if (7 <= 0 and var_378_5 or var_378_5 * (utf8.len(var_378_7) / 7)) > 0 and var_378_5 < var_378_9 then
					arg_375_1.talkMaxDuration = var_378_9

					if var_378_9 + var_378_4 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_9 + var_378_4
					end
				end

				arg_375_1.text_.text = var_378_7
				arg_375_1.typewritter.percent = 0

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031089", "story_v_out_412031.awb") ~= 0 then
					local var_378_10 = manager.audio:GetVoiceLength("story_v_out_412031", "412031089", "story_v_out_412031.awb") / 1000

					if var_378_10 + var_378_4 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_10 + var_378_4
					end

					if var_378_6.prefab_name ~= "" and arg_375_1.actors_[var_378_6.prefab_name] ~= nil then
						local var_378_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_375_1.actors_[var_378_6.prefab_name].transform, "story_v_out_412031", "412031089", "story_v_out_412031.awb")

						arg_375_1:RecordAudio("412031089", var_378_11)
						arg_375_1:RecordAudio("412031089", var_378_11)
					else
						arg_375_1:AudioAction("play", "voice", "story_v_out_412031", "412031089", "story_v_out_412031.awb")
					end

					arg_375_1:RecordHistoryTalkVoice("story_v_out_412031", "412031089", "story_v_out_412031.awb")
				end

				arg_375_1:RecordContent(arg_375_1.text_.text)
			end

			local var_378_12 = math.max(var_378_5, arg_375_1.talkMaxDuration)

			if var_378_4 <= arg_375_1.time_ and arg_375_1.time_ < var_378_4 + var_378_12 then
				arg_375_1.typewritter.percent = (arg_375_1.time_ - var_378_4) / var_378_12

				arg_375_1.typewritter:SetDirty()
			end

			if arg_375_1.time_ >= var_378_4 + var_378_12 and arg_375_1.time_ < var_378_4 + var_378_12 + arg_378_0 then
				arg_375_1.typewritter.percent = 1

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(true)
			end
		end

		arg_375_1.nodeConfigList_ = {}

		arg_375_1:InitPlayNodeList()
	end,
	Play412031090 = function(arg_379_0, arg_379_1)
		arg_379_1.time_ = 0
		arg_379_1.frameCnt_ = 0
		arg_379_1.state_ = "playing"
		arg_379_1.curTalkId_ = 412031090
		arg_379_1.duration_ = 7.9

		local var_379_0 = {
			zh = 5.9,
			ja = 7.9
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
				arg_379_0:Play412031091(arg_379_1)
			end
		end

		function arg_379_1.onSingleLineUpdate_(arg_382_0)
			if 0 < arg_379_1.time_ and arg_379_1.time_ <= 0 + arg_382_0 and not isNil(arg_379_1.actors_["3043ui_story"]) and arg_379_1.var_.characterEffect3043ui_story == nil then
				arg_379_1.var_.characterEffect3043ui_story = arg_379_1.actors_["3043ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_382_0 = 0.200000002980232

			if 0 <= arg_379_1.time_ and arg_379_1.time_ < 0 + var_382_0 and not isNil(arg_379_1.actors_["3043ui_story"]) then
				if arg_379_1.var_.characterEffect3043ui_story and not isNil(arg_379_1.actors_["3043ui_story"]) then
					arg_379_1.var_.characterEffect3043ui_story.fillFlat = false
				end
			end

			if arg_379_1.time_ >= 0 + var_382_0 and arg_379_1.time_ < 0 + var_382_0 + arg_382_0 and not isNil(arg_379_1.actors_["3043ui_story"]) and arg_379_1.var_.characterEffect3043ui_story then
				arg_379_1.var_.characterEffect3043ui_story.fillFlat = false
			end

			if 0 < arg_379_1.time_ and arg_379_1.time_ <= 0 + arg_382_0 then
				arg_379_1:PlayTimeline("3043ui_story", "StoryTimeline/CharAction/story3043/story3043action/3043action1_1")
			end

			if 0 < arg_379_1.time_ and arg_379_1.time_ <= 0 + arg_382_0 then
				arg_379_1:PlayTimeline("3043ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_382_2 = arg_379_1.actors_["1097ui_story"]

			if 0 < arg_379_1.time_ and arg_379_1.time_ <= 0 + arg_382_0 and not isNil(var_382_2) and arg_379_1.var_.characterEffect1097ui_story == nil then
				arg_379_1.var_.characterEffect1097ui_story = var_382_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_382_3 = 0.200000002980232

			if 0 <= arg_379_1.time_ and arg_379_1.time_ < 0 + var_382_3 and not isNil(var_382_2) then
				if arg_379_1.var_.characterEffect1097ui_story and not isNil(var_382_2) then
					arg_379_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_379_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_379_1.time_ - 0) / var_382_3)
				end
			end

			if arg_379_1.time_ >= 0 + var_382_3 and arg_379_1.time_ < 0 + var_382_3 + arg_382_0 and not isNil(var_382_2) and arg_379_1.var_.characterEffect1097ui_story then
				arg_379_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_379_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_382_4 = 0
			local var_382_5 = 0.55

			if 0 < arg_379_1.time_ and arg_379_1.time_ <= var_382_4 + arg_382_0 then
				arg_379_1.talkMaxDuration = 0
				arg_379_1.dialogCg_.alpha = 1

				arg_379_1.dialog_:SetActive(true)
				SetActive(arg_379_1.leftNameGo_, true)

				arg_379_1.leftNameTxt_.text = arg_379_1:FormatText(StoryNameCfg[920].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_379_1.leftNameTxt_.transform)

				arg_379_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_379_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_379_1:RecordName(arg_379_1.leftNameTxt_.text)
				SetActive(arg_379_1.iconTrs_.gameObject, false)
				arg_379_1.callingController_:SetSelectedState("normal")

				local var_382_6 = arg_379_1:GetWordFromCfg(412031090)
				local var_382_7 = arg_379_1:FormatText(var_382_6.content)

				arg_379_1.text_.text = var_382_7

				LuaForUtil.ClearLinePrefixSymbol(arg_379_1.text_)

				local var_382_9 = 22 <= 0 and var_382_5 or var_382_5 * (utf8.len(var_382_7) / 22)

				if (22 <= 0 and var_382_5 or var_382_5 * (utf8.len(var_382_7) / 22)) > 0 and var_382_5 < var_382_9 then
					arg_379_1.talkMaxDuration = var_382_9

					if var_382_9 + var_382_4 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_9 + var_382_4
					end
				end

				arg_379_1.text_.text = var_382_7
				arg_379_1.typewritter.percent = 0

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031090", "story_v_out_412031.awb") ~= 0 then
					local var_382_10 = manager.audio:GetVoiceLength("story_v_out_412031", "412031090", "story_v_out_412031.awb") / 1000

					if var_382_10 + var_382_4 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_10 + var_382_4
					end

					if var_382_6.prefab_name ~= "" and arg_379_1.actors_[var_382_6.prefab_name] ~= nil then
						local var_382_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_379_1.actors_[var_382_6.prefab_name].transform, "story_v_out_412031", "412031090", "story_v_out_412031.awb")

						arg_379_1:RecordAudio("412031090", var_382_11)
						arg_379_1:RecordAudio("412031090", var_382_11)
					else
						arg_379_1:AudioAction("play", "voice", "story_v_out_412031", "412031090", "story_v_out_412031.awb")
					end

					arg_379_1:RecordHistoryTalkVoice("story_v_out_412031", "412031090", "story_v_out_412031.awb")
				end

				arg_379_1:RecordContent(arg_379_1.text_.text)
			end

			local var_382_12 = math.max(var_382_5, arg_379_1.talkMaxDuration)

			if var_382_4 <= arg_379_1.time_ and arg_379_1.time_ < var_382_4 + var_382_12 then
				arg_379_1.typewritter.percent = (arg_379_1.time_ - var_382_4) / var_382_12

				arg_379_1.typewritter:SetDirty()
			end

			if arg_379_1.time_ >= var_382_4 + var_382_12 and arg_379_1.time_ < var_382_4 + var_382_12 + arg_382_0 then
				arg_379_1.typewritter.percent = 1

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(true)
			end
		end

		arg_379_1.nodeConfigList_ = {}

		arg_379_1:InitPlayNodeList()
	end,
	Play412031091 = function(arg_383_0, arg_383_1)
		arg_383_1.time_ = 0
		arg_383_1.frameCnt_ = 0
		arg_383_1.state_ = "playing"
		arg_383_1.curTalkId_ = 412031091
		arg_383_1.duration_ = 8.53

		local var_383_0 = {
			zh = 4.966,
			ja = 8.533
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
				arg_383_0:Play412031092(arg_383_1)
			end
		end

		function arg_383_1.onSingleLineUpdate_(arg_386_0)
			if 0 < arg_383_1.time_ and arg_383_1.time_ <= 0 + arg_386_0 then
				arg_383_1.var_.moveOldPos10078ui_story = arg_383_1.actors_["10078ui_story"].transform.localPosition
			end

			local var_386_0 = 0.001

			if 0 <= arg_383_1.time_ and arg_383_1.time_ < 0 + var_386_0 then
				arg_383_1.actors_["10078ui_story"].transform.localPosition = Vector3.Lerp(arg_383_1.var_.moveOldPos10078ui_story, Vector3.New(0, -0.5, -6.3), (arg_383_1.time_ - 0) / var_386_0)
				arg_383_1.actors_["10078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_383_1.actors_["10078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_383_1.actors_["10078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_383_1.actors_["10078ui_story"].transform.position).z)
				arg_383_1.actors_["10078ui_story"].transform.localEulerAngles.z = 0
				arg_383_1.actors_["10078ui_story"].transform.localEulerAngles.x = 0
				arg_383_1.actors_["10078ui_story"].transform.localEulerAngles = arg_383_1.actors_["10078ui_story"].transform.localEulerAngles
			end

			if arg_383_1.time_ >= 0 + var_386_0 and arg_383_1.time_ < 0 + var_386_0 + arg_386_0 then
				arg_383_1.actors_["10078ui_story"].transform.localPosition = Vector3.New(0, -0.5, -6.3)
				arg_383_1.actors_["10078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_383_1.actors_["10078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_383_1.actors_["10078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_383_1.actors_["10078ui_story"].transform.position).z)
				arg_383_1.actors_["10078ui_story"].transform.localEulerAngles.z = 0
				arg_383_1.actors_["10078ui_story"].transform.localEulerAngles.x = 0
				arg_383_1.actors_["10078ui_story"].transform.localEulerAngles = arg_383_1.actors_["10078ui_story"].transform.localEulerAngles
			end

			local var_386_1 = arg_383_1.actors_["10078ui_story"]

			if 0 < arg_383_1.time_ and arg_383_1.time_ <= 0 + arg_386_0 and not isNil(var_386_1) and arg_383_1.var_.characterEffect10078ui_story == nil then
				arg_383_1.var_.characterEffect10078ui_story = var_386_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_386_2 = 0.200000002980232

			if 0 <= arg_383_1.time_ and arg_383_1.time_ < 0 + var_386_2 and not isNil(var_386_1) then
				if arg_383_1.var_.characterEffect10078ui_story and not isNil(var_386_1) then
					arg_383_1.var_.characterEffect10078ui_story.fillFlat = false
				end
			end

			if arg_383_1.time_ >= 0 + var_386_2 and arg_383_1.time_ < 0 + var_386_2 + arg_386_0 and not isNil(var_386_1) and arg_383_1.var_.characterEffect10078ui_story then
				arg_383_1.var_.characterEffect10078ui_story.fillFlat = false
			end

			if 0 < arg_383_1.time_ and arg_383_1.time_ <= 0 + arg_386_0 then
				arg_383_1:PlayTimeline("10078ui_story", "StoryTimeline/CharAction/story6046/story6046action/6046action4_1")
			end

			if 0 < arg_383_1.time_ and arg_383_1.time_ <= 0 + arg_386_0 then
				arg_383_1:PlayTimeline("10078ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_386_4 = arg_383_1.actors_["1097ui_story"].transform

			if 0 < arg_383_1.time_ and arg_383_1.time_ <= 0 + arg_386_0 then
				arg_383_1.var_.moveOldPos1097ui_story = var_386_4.localPosition
			end

			local var_386_5 = 0.001

			if 0 <= arg_383_1.time_ and arg_383_1.time_ < 0 + var_386_5 then
				var_386_4.localPosition = Vector3.Lerp(arg_383_1.var_.moveOldPos1097ui_story, Vector3.New(0, 100, 0), (arg_383_1.time_ - 0) / var_386_5)
				var_386_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_386_4.position).x, (manager.ui.mainCamera.transform.position - var_386_4.position).y, (manager.ui.mainCamera.transform.position - var_386_4.position).z)
				var_386_4.localEulerAngles.z = 0
				var_386_4.localEulerAngles.x = 0
				var_386_4.localEulerAngles = var_386_4.localEulerAngles
			end

			if arg_383_1.time_ >= 0 + var_386_5 and arg_383_1.time_ < 0 + var_386_5 + arg_386_0 then
				var_386_4.localPosition = Vector3.New(0, 100, 0)
				var_386_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_386_4.position).x, (manager.ui.mainCamera.transform.position - var_386_4.position).y, (manager.ui.mainCamera.transform.position - var_386_4.position).z)
				var_386_4.localEulerAngles.z = 0
				var_386_4.localEulerAngles.x = 0
				var_386_4.localEulerAngles = var_386_4.localEulerAngles
			end

			local var_386_6 = arg_383_1.actors_["1097ui_story"]

			if 0 < arg_383_1.time_ and arg_383_1.time_ <= 0 + arg_386_0 and not isNil(var_386_6) and arg_383_1.var_.characterEffect1097ui_story == nil then
				arg_383_1.var_.characterEffect1097ui_story = var_386_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_386_7 = 0.200000002980232

			if 0 <= arg_383_1.time_ and arg_383_1.time_ < 0 + var_386_7 and not isNil(var_386_6) then
				if arg_383_1.var_.characterEffect1097ui_story and not isNil(var_386_6) then
					arg_383_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_383_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_383_1.time_ - 0) / var_386_7)
				end
			end

			if arg_383_1.time_ >= 0 + var_386_7 and arg_383_1.time_ < 0 + var_386_7 + arg_386_0 and not isNil(var_386_6) and arg_383_1.var_.characterEffect1097ui_story then
				arg_383_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_383_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_386_8 = arg_383_1.actors_["3043ui_story"].transform

			if 0 < arg_383_1.time_ and arg_383_1.time_ <= 0 + arg_386_0 then
				arg_383_1.var_.moveOldPos3043ui_story = var_386_8.localPosition
			end

			local var_386_9 = 0.001

			if 0 <= arg_383_1.time_ and arg_383_1.time_ < 0 + var_386_9 then
				var_386_8.localPosition = Vector3.Lerp(arg_383_1.var_.moveOldPos3043ui_story, Vector3.New(0, 100, 0), (arg_383_1.time_ - 0) / var_386_9)
				var_386_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_386_8.position).x, (manager.ui.mainCamera.transform.position - var_386_8.position).y, (manager.ui.mainCamera.transform.position - var_386_8.position).z)
				var_386_8.localEulerAngles.z = 0
				var_386_8.localEulerAngles.x = 0
				var_386_8.localEulerAngles = var_386_8.localEulerAngles
			end

			if arg_383_1.time_ >= 0 + var_386_9 and arg_383_1.time_ < 0 + var_386_9 + arg_386_0 then
				var_386_8.localPosition = Vector3.New(0, 100, 0)
				var_386_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_386_8.position).x, (manager.ui.mainCamera.transform.position - var_386_8.position).y, (manager.ui.mainCamera.transform.position - var_386_8.position).z)
				var_386_8.localEulerAngles.z = 0
				var_386_8.localEulerAngles.x = 0
				var_386_8.localEulerAngles = var_386_8.localEulerAngles
			end

			local var_386_10 = arg_383_1.actors_["3043ui_story"]

			if 0 < arg_383_1.time_ and arg_383_1.time_ <= 0 + arg_386_0 and not isNil(var_386_10) and arg_383_1.var_.characterEffect3043ui_story == nil then
				arg_383_1.var_.characterEffect3043ui_story = var_386_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_386_11 = 0.200000002980232

			if 0 <= arg_383_1.time_ and arg_383_1.time_ < 0 + var_386_11 and not isNil(var_386_10) then
				if arg_383_1.var_.characterEffect3043ui_story and not isNil(var_386_10) then
					arg_383_1.var_.characterEffect3043ui_story.fillFlat = true
					arg_383_1.var_.characterEffect3043ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_383_1.time_ - 0) / var_386_11)
				end
			end

			if arg_383_1.time_ >= 0 + var_386_11 and arg_383_1.time_ < 0 + var_386_11 + arg_386_0 and not isNil(var_386_10) and arg_383_1.var_.characterEffect3043ui_story then
				arg_383_1.var_.characterEffect3043ui_story.fillFlat = true
				arg_383_1.var_.characterEffect3043ui_story.fillRatio = 0.5
			end

			local var_386_12 = 0
			local var_386_13 = 0.475

			if 0 < arg_383_1.time_ and arg_383_1.time_ <= var_386_12 + arg_386_0 then
				arg_383_1.talkMaxDuration = 0
				arg_383_1.dialogCg_.alpha = 1

				arg_383_1.dialog_:SetActive(true)
				SetActive(arg_383_1.leftNameGo_, true)

				arg_383_1.leftNameTxt_.text = arg_383_1:FormatText(StoryNameCfg[919].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_383_1.leftNameTxt_.transform)

				arg_383_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_383_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_383_1:RecordName(arg_383_1.leftNameTxt_.text)
				SetActive(arg_383_1.iconTrs_.gameObject, false)
				arg_383_1.callingController_:SetSelectedState("normal")

				local var_386_14 = arg_383_1:GetWordFromCfg(412031091)
				local var_386_15 = arg_383_1:FormatText(var_386_14.content)

				arg_383_1.text_.text = var_386_15

				LuaForUtil.ClearLinePrefixSymbol(arg_383_1.text_)

				local var_386_17 = 19 <= 0 and var_386_13 or var_386_13 * (utf8.len(var_386_15) / 19)

				if (19 <= 0 and var_386_13 or var_386_13 * (utf8.len(var_386_15) / 19)) > 0 and var_386_13 < var_386_17 then
					arg_383_1.talkMaxDuration = var_386_17

					if var_386_17 + var_386_12 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_17 + var_386_12
					end
				end

				arg_383_1.text_.text = var_386_15
				arg_383_1.typewritter.percent = 0

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031091", "story_v_out_412031.awb") ~= 0 then
					local var_386_18 = manager.audio:GetVoiceLength("story_v_out_412031", "412031091", "story_v_out_412031.awb") / 1000

					if var_386_18 + var_386_12 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_18 + var_386_12
					end

					if var_386_14.prefab_name ~= "" and arg_383_1.actors_[var_386_14.prefab_name] ~= nil then
						local var_386_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_383_1.actors_[var_386_14.prefab_name].transform, "story_v_out_412031", "412031091", "story_v_out_412031.awb")

						arg_383_1:RecordAudio("412031091", var_386_19)
						arg_383_1:RecordAudio("412031091", var_386_19)
					else
						arg_383_1:AudioAction("play", "voice", "story_v_out_412031", "412031091", "story_v_out_412031.awb")
					end

					arg_383_1:RecordHistoryTalkVoice("story_v_out_412031", "412031091", "story_v_out_412031.awb")
				end

				arg_383_1:RecordContent(arg_383_1.text_.text)
			end

			local var_386_20 = math.max(var_386_13, arg_383_1.talkMaxDuration)

			if var_386_12 <= arg_383_1.time_ and arg_383_1.time_ < var_386_12 + var_386_20 then
				arg_383_1.typewritter.percent = (arg_383_1.time_ - var_386_12) / var_386_20

				arg_383_1.typewritter:SetDirty()
			end

			if arg_383_1.time_ >= var_386_12 + var_386_20 and arg_383_1.time_ < var_386_12 + var_386_20 + arg_386_0 then
				arg_383_1.typewritter.percent = 1

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(true)
			end
		end

		arg_383_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "3043ui_story",
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
	Play412031092 = function(arg_387_0, arg_387_1)
		arg_387_1.time_ = 0
		arg_387_1.frameCnt_ = 0
		arg_387_1.state_ = "playing"
		arg_387_1.curTalkId_ = 412031092
		arg_387_1.duration_ = 3.27

		local var_387_0 = {
			zh = 1.999999999999,
			ja = 3.266
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
				arg_387_0:Play412031093(arg_387_1)
			end
		end

		function arg_387_1.onSingleLineUpdate_(arg_390_0)
			if 0 < arg_387_1.time_ and arg_387_1.time_ <= 0 + arg_390_0 then
				arg_387_1.var_.moveOldPos10076ui_story = arg_387_1.actors_["10076ui_story"].transform.localPosition
			end

			local var_390_0 = 0.001

			if 0 <= arg_387_1.time_ and arg_387_1.time_ < 0 + var_390_0 then
				arg_387_1.actors_["10076ui_story"].transform.localPosition = Vector3.Lerp(arg_387_1.var_.moveOldPos10076ui_story, Vector3.New(0, -0.35, -4), (arg_387_1.time_ - 0) / var_390_0)
				arg_387_1.actors_["10076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_387_1.actors_["10076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_387_1.actors_["10076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_387_1.actors_["10076ui_story"].transform.position).z)
				arg_387_1.actors_["10076ui_story"].transform.localEulerAngles.z = 0
				arg_387_1.actors_["10076ui_story"].transform.localEulerAngles.x = 0
				arg_387_1.actors_["10076ui_story"].transform.localEulerAngles = arg_387_1.actors_["10076ui_story"].transform.localEulerAngles
			end

			if arg_387_1.time_ >= 0 + var_390_0 and arg_387_1.time_ < 0 + var_390_0 + arg_390_0 then
				arg_387_1.actors_["10076ui_story"].transform.localPosition = Vector3.New(0, -0.35, -4)
				arg_387_1.actors_["10076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_387_1.actors_["10076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_387_1.actors_["10076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_387_1.actors_["10076ui_story"].transform.position).z)
				arg_387_1.actors_["10076ui_story"].transform.localEulerAngles.z = 0
				arg_387_1.actors_["10076ui_story"].transform.localEulerAngles.x = 0
				arg_387_1.actors_["10076ui_story"].transform.localEulerAngles = arg_387_1.actors_["10076ui_story"].transform.localEulerAngles
			end

			local var_390_1 = arg_387_1.actors_["10076ui_story"]

			if 0 < arg_387_1.time_ and arg_387_1.time_ <= 0 + arg_390_0 and not isNil(var_390_1) and arg_387_1.var_.characterEffect10076ui_story == nil then
				arg_387_1.var_.characterEffect10076ui_story = var_390_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_390_2 = 0.200000002980232

			if 0 <= arg_387_1.time_ and arg_387_1.time_ < 0 + var_390_2 and not isNil(var_390_1) then
				if arg_387_1.var_.characterEffect10076ui_story and not isNil(var_390_1) then
					arg_387_1.var_.characterEffect10076ui_story.fillFlat = false
				end
			end

			if arg_387_1.time_ >= 0 + var_390_2 and arg_387_1.time_ < 0 + var_390_2 + arg_390_0 and not isNil(var_390_1) and arg_387_1.var_.characterEffect10076ui_story then
				arg_387_1.var_.characterEffect10076ui_story.fillFlat = false
			end

			if 0 < arg_387_1.time_ and arg_387_1.time_ <= 0 + arg_390_0 then
				arg_387_1:PlayTimeline("10076ui_story", "StoryTimeline/CharAction/story10076/story10076action/10076action2_1")
			end

			if 0 < arg_387_1.time_ and arg_387_1.time_ <= 0 + arg_390_0 then
				arg_387_1:PlayTimeline("10076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_390_4 = arg_387_1.actors_["10078ui_story"].transform

			if 0 < arg_387_1.time_ and arg_387_1.time_ <= 0 + arg_390_0 then
				arg_387_1.var_.moveOldPos10078ui_story = var_390_4.localPosition
			end

			local var_390_5 = 0.001

			if 0 <= arg_387_1.time_ and arg_387_1.time_ < 0 + var_390_5 then
				var_390_4.localPosition = Vector3.Lerp(arg_387_1.var_.moveOldPos10078ui_story, Vector3.New(0, 100, 0), (arg_387_1.time_ - 0) / var_390_5)
				var_390_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_390_4.position).x, (manager.ui.mainCamera.transform.position - var_390_4.position).y, (manager.ui.mainCamera.transform.position - var_390_4.position).z)
				var_390_4.localEulerAngles.z = 0
				var_390_4.localEulerAngles.x = 0
				var_390_4.localEulerAngles = var_390_4.localEulerAngles
			end

			if arg_387_1.time_ >= 0 + var_390_5 and arg_387_1.time_ < 0 + var_390_5 + arg_390_0 then
				var_390_4.localPosition = Vector3.New(0, 100, 0)
				var_390_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_390_4.position).x, (manager.ui.mainCamera.transform.position - var_390_4.position).y, (manager.ui.mainCamera.transform.position - var_390_4.position).z)
				var_390_4.localEulerAngles.z = 0
				var_390_4.localEulerAngles.x = 0
				var_390_4.localEulerAngles = var_390_4.localEulerAngles
			end

			local var_390_6 = arg_387_1.actors_["10078ui_story"]

			if 0 < arg_387_1.time_ and arg_387_1.time_ <= 0 + arg_390_0 and not isNil(var_390_6) and arg_387_1.var_.characterEffect10078ui_story == nil then
				arg_387_1.var_.characterEffect10078ui_story = var_390_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_390_7 = 0.200000002980232

			if 0 <= arg_387_1.time_ and arg_387_1.time_ < 0 + var_390_7 and not isNil(var_390_6) then
				if arg_387_1.var_.characterEffect10078ui_story and not isNil(var_390_6) then
					arg_387_1.var_.characterEffect10078ui_story.fillFlat = true
					arg_387_1.var_.characterEffect10078ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_387_1.time_ - 0) / var_390_7)
				end
			end

			if arg_387_1.time_ >= 0 + var_390_7 and arg_387_1.time_ < 0 + var_390_7 + arg_390_0 and not isNil(var_390_6) and arg_387_1.var_.characterEffect10078ui_story then
				arg_387_1.var_.characterEffect10078ui_story.fillFlat = true
				arg_387_1.var_.characterEffect10078ui_story.fillRatio = 0.5
			end

			local var_390_8 = 0
			local var_390_9 = 0.25

			if 0 < arg_387_1.time_ and arg_387_1.time_ <= var_390_8 + arg_390_0 then
				arg_387_1.talkMaxDuration = 0
				arg_387_1.dialogCg_.alpha = 1

				arg_387_1.dialog_:SetActive(true)
				SetActive(arg_387_1.leftNameGo_, true)

				arg_387_1.leftNameTxt_.text = arg_387_1:FormatText(StoryNameCfg[917].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_387_1.leftNameTxt_.transform)

				arg_387_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_387_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_387_1:RecordName(arg_387_1.leftNameTxt_.text)
				SetActive(arg_387_1.iconTrs_.gameObject, false)
				arg_387_1.callingController_:SetSelectedState("normal")

				local var_390_10 = arg_387_1:GetWordFromCfg(412031092)
				local var_390_11 = arg_387_1:FormatText(var_390_10.content)

				arg_387_1.text_.text = var_390_11

				LuaForUtil.ClearLinePrefixSymbol(arg_387_1.text_)

				local var_390_13 = 10 <= 0 and var_390_9 or var_390_9 * (utf8.len(var_390_11) / 10)

				if (10 <= 0 and var_390_9 or var_390_9 * (utf8.len(var_390_11) / 10)) > 0 and var_390_9 < var_390_13 then
					arg_387_1.talkMaxDuration = var_390_13

					if var_390_13 + var_390_8 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_13 + var_390_8
					end
				end

				arg_387_1.text_.text = var_390_11
				arg_387_1.typewritter.percent = 0

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031092", "story_v_out_412031.awb") ~= 0 then
					local var_390_14 = manager.audio:GetVoiceLength("story_v_out_412031", "412031092", "story_v_out_412031.awb") / 1000

					if var_390_14 + var_390_8 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_14 + var_390_8
					end

					if var_390_10.prefab_name ~= "" and arg_387_1.actors_[var_390_10.prefab_name] ~= nil then
						local var_390_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_387_1.actors_[var_390_10.prefab_name].transform, "story_v_out_412031", "412031092", "story_v_out_412031.awb")

						arg_387_1:RecordAudio("412031092", var_390_15)
						arg_387_1:RecordAudio("412031092", var_390_15)
					else
						arg_387_1:AudioAction("play", "voice", "story_v_out_412031", "412031092", "story_v_out_412031.awb")
					end

					arg_387_1:RecordHistoryTalkVoice("story_v_out_412031", "412031092", "story_v_out_412031.awb")
				end

				arg_387_1:RecordContent(arg_387_1.text_.text)
			end

			local var_390_16 = math.max(var_390_9, arg_387_1.talkMaxDuration)

			if var_390_8 <= arg_387_1.time_ and arg_387_1.time_ < var_390_8 + var_390_16 then
				arg_387_1.typewritter.percent = (arg_387_1.time_ - var_390_8) / var_390_16

				arg_387_1.typewritter:SetDirty()
			end

			if arg_387_1.time_ >= var_390_8 + var_390_16 and arg_387_1.time_ < var_390_8 + var_390_16 + arg_390_0 then
				arg_387_1.typewritter.percent = 1

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(true)
			end
		end

		arg_387_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_387_1:InitPlayNodeList()
	end,
	Play412031093 = function(arg_391_0, arg_391_1)
		arg_391_1.time_ = 0
		arg_391_1.frameCnt_ = 0
		arg_391_1.state_ = "playing"
		arg_391_1.curTalkId_ = 412031093
		arg_391_1.duration_ = 9.53

		local var_391_0 = {
			zh = 6.133,
			ja = 9.533
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
				arg_391_0:Play412031094(arg_391_1)
			end
		end

		function arg_391_1.onSingleLineUpdate_(arg_394_0)
			if 0 < arg_391_1.time_ and arg_391_1.time_ <= 0 + arg_394_0 then
				arg_391_1.var_.moveOldPos1097ui_story = arg_391_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_394_0 = 0.001

			if 0 <= arg_391_1.time_ and arg_391_1.time_ < 0 + var_394_0 then
				arg_391_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_391_1.var_.moveOldPos1097ui_story, Vector3.New(-0.7, -0.54, -6.3), (arg_391_1.time_ - 0) / var_394_0)
				arg_391_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_391_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_391_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_391_1.actors_["1097ui_story"].transform.position).z)
				arg_391_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_391_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_391_1.actors_["1097ui_story"].transform.localEulerAngles = arg_391_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_391_1.time_ >= 0 + var_394_0 and arg_391_1.time_ < 0 + var_394_0 + arg_394_0 then
				arg_391_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(-0.7, -0.54, -6.3)
				arg_391_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_391_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_391_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_391_1.actors_["1097ui_story"].transform.position).z)
				arg_391_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_391_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_391_1.actors_["1097ui_story"].transform.localEulerAngles = arg_391_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_394_1 = arg_391_1.actors_["1097ui_story"]

			if 0 < arg_391_1.time_ and arg_391_1.time_ <= 0 + arg_394_0 and not isNil(var_394_1) and arg_391_1.var_.characterEffect1097ui_story == nil then
				arg_391_1.var_.characterEffect1097ui_story = var_394_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_394_2 = 0.200000002980232

			if 0 <= arg_391_1.time_ and arg_391_1.time_ < 0 + var_394_2 and not isNil(var_394_1) then
				if arg_391_1.var_.characterEffect1097ui_story and not isNil(var_394_1) then
					arg_391_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_391_1.time_ >= 0 + var_394_2 and arg_391_1.time_ < 0 + var_394_2 + arg_394_0 and not isNil(var_394_1) and arg_391_1.var_.characterEffect1097ui_story then
				arg_391_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_391_1.time_ and arg_391_1.time_ <= 0 + arg_394_0 then
				arg_391_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			if 0 < arg_391_1.time_ and arg_391_1.time_ <= 0 + arg_394_0 then
				arg_391_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_394_4 = arg_391_1.actors_["10076ui_story"].transform

			if 0 < arg_391_1.time_ and arg_391_1.time_ <= 0 + arg_394_0 then
				arg_391_1.var_.moveOldPos10076ui_story = var_394_4.localPosition
			end

			local var_394_5 = 0.001

			if 0 <= arg_391_1.time_ and arg_391_1.time_ < 0 + var_394_5 then
				var_394_4.localPosition = Vector3.Lerp(arg_391_1.var_.moveOldPos10076ui_story, Vector3.New(0, 100, 0), (arg_391_1.time_ - 0) / var_394_5)
				var_394_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_394_4.position).x, (manager.ui.mainCamera.transform.position - var_394_4.position).y, (manager.ui.mainCamera.transform.position - var_394_4.position).z)
				var_394_4.localEulerAngles.z = 0
				var_394_4.localEulerAngles.x = 0
				var_394_4.localEulerAngles = var_394_4.localEulerAngles
			end

			if arg_391_1.time_ >= 0 + var_394_5 and arg_391_1.time_ < 0 + var_394_5 + arg_394_0 then
				var_394_4.localPosition = Vector3.New(0, 100, 0)
				var_394_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_394_4.position).x, (manager.ui.mainCamera.transform.position - var_394_4.position).y, (manager.ui.mainCamera.transform.position - var_394_4.position).z)
				var_394_4.localEulerAngles.z = 0
				var_394_4.localEulerAngles.x = 0
				var_394_4.localEulerAngles = var_394_4.localEulerAngles
			end

			local var_394_6 = arg_391_1.actors_["10076ui_story"]

			if 0 < arg_391_1.time_ and arg_391_1.time_ <= 0 + arg_394_0 and not isNil(var_394_6) and arg_391_1.var_.characterEffect10076ui_story == nil then
				arg_391_1.var_.characterEffect10076ui_story = var_394_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_394_7 = 0.200000002980232

			if 0 <= arg_391_1.time_ and arg_391_1.time_ < 0 + var_394_7 and not isNil(var_394_6) then
				if arg_391_1.var_.characterEffect10076ui_story and not isNil(var_394_6) then
					arg_391_1.var_.characterEffect10076ui_story.fillFlat = true
					arg_391_1.var_.characterEffect10076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_391_1.time_ - 0) / var_394_7)
				end
			end

			if arg_391_1.time_ >= 0 + var_394_7 and arg_391_1.time_ < 0 + var_394_7 + arg_394_0 and not isNil(var_394_6) and arg_391_1.var_.characterEffect10076ui_story then
				arg_391_1.var_.characterEffect10076ui_story.fillFlat = true
				arg_391_1.var_.characterEffect10076ui_story.fillRatio = 0.5
			end

			local var_394_8 = 0
			local var_394_9 = 0.575

			if 0 < arg_391_1.time_ and arg_391_1.time_ <= var_394_8 + arg_394_0 then
				arg_391_1.talkMaxDuration = 0
				arg_391_1.dialogCg_.alpha = 1

				arg_391_1.dialog_:SetActive(true)
				SetActive(arg_391_1.leftNameGo_, true)

				arg_391_1.leftNameTxt_.text = arg_391_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_391_1.leftNameTxt_.transform)

				arg_391_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_391_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_391_1:RecordName(arg_391_1.leftNameTxt_.text)
				SetActive(arg_391_1.iconTrs_.gameObject, false)
				arg_391_1.callingController_:SetSelectedState("normal")

				local var_394_10 = arg_391_1:GetWordFromCfg(412031093)
				local var_394_11 = arg_391_1:FormatText(var_394_10.content)

				arg_391_1.text_.text = var_394_11

				LuaForUtil.ClearLinePrefixSymbol(arg_391_1.text_)

				local var_394_13 = 23 <= 0 and var_394_9 or var_394_9 * (utf8.len(var_394_11) / 23)

				if (23 <= 0 and var_394_9 or var_394_9 * (utf8.len(var_394_11) / 23)) > 0 and var_394_9 < var_394_13 then
					arg_391_1.talkMaxDuration = var_394_13

					if var_394_13 + var_394_8 > arg_391_1.duration_ then
						arg_391_1.duration_ = var_394_13 + var_394_8
					end
				end

				arg_391_1.text_.text = var_394_11
				arg_391_1.typewritter.percent = 0

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031093", "story_v_out_412031.awb") ~= 0 then
					local var_394_14 = manager.audio:GetVoiceLength("story_v_out_412031", "412031093", "story_v_out_412031.awb") / 1000

					if var_394_14 + var_394_8 > arg_391_1.duration_ then
						arg_391_1.duration_ = var_394_14 + var_394_8
					end

					if var_394_10.prefab_name ~= "" and arg_391_1.actors_[var_394_10.prefab_name] ~= nil then
						local var_394_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_391_1.actors_[var_394_10.prefab_name].transform, "story_v_out_412031", "412031093", "story_v_out_412031.awb")

						arg_391_1:RecordAudio("412031093", var_394_15)
						arg_391_1:RecordAudio("412031093", var_394_15)
					else
						arg_391_1:AudioAction("play", "voice", "story_v_out_412031", "412031093", "story_v_out_412031.awb")
					end

					arg_391_1:RecordHistoryTalkVoice("story_v_out_412031", "412031093", "story_v_out_412031.awb")
				end

				arg_391_1:RecordContent(arg_391_1.text_.text)
			end

			local var_394_16 = math.max(var_394_9, arg_391_1.talkMaxDuration)

			if var_394_8 <= arg_391_1.time_ and arg_391_1.time_ < var_394_8 + var_394_16 then
				arg_391_1.typewritter.percent = (arg_391_1.time_ - var_394_8) / var_394_16

				arg_391_1.typewritter:SetDirty()
			end

			if arg_391_1.time_ >= var_394_8 + var_394_16 and arg_391_1.time_ < var_394_8 + var_394_16 + arg_394_0 then
				arg_391_1.typewritter.percent = 1

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(true)
			end
		end

		arg_391_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10076ui_story",
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
	Play412031094 = function(arg_395_0, arg_395_1)
		arg_395_1.time_ = 0
		arg_395_1.frameCnt_ = 0
		arg_395_1.state_ = "playing"
		arg_395_1.curTalkId_ = 412031094
		arg_395_1.duration_ = 8.1

		local var_395_0 = {
			zh = 7.033,
			ja = 8.1
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
				arg_395_0:Play412031095(arg_395_1)
			end
		end

		function arg_395_1.onSingleLineUpdate_(arg_398_0)
			if 0 < arg_395_1.time_ and arg_395_1.time_ <= 0 + arg_398_0 then
				arg_395_1.var_.moveOldPos3043ui_story = arg_395_1.actors_["3043ui_story"].transform.localPosition
			end

			local var_398_0 = 0.001

			if 0 <= arg_395_1.time_ and arg_395_1.time_ < 0 + var_398_0 then
				arg_395_1.actors_["3043ui_story"].transform.localPosition = Vector3.Lerp(arg_395_1.var_.moveOldPos3043ui_story, Vector3.New(0.7, -1.41, -5.7), (arg_395_1.time_ - 0) / var_398_0)
				arg_395_1.actors_["3043ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_395_1.actors_["3043ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_395_1.actors_["3043ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_395_1.actors_["3043ui_story"].transform.position).z)
				arg_395_1.actors_["3043ui_story"].transform.localEulerAngles.z = 0
				arg_395_1.actors_["3043ui_story"].transform.localEulerAngles.x = 0
				arg_395_1.actors_["3043ui_story"].transform.localEulerAngles = arg_395_1.actors_["3043ui_story"].transform.localEulerAngles
			end

			if arg_395_1.time_ >= 0 + var_398_0 and arg_395_1.time_ < 0 + var_398_0 + arg_398_0 then
				arg_395_1.actors_["3043ui_story"].transform.localPosition = Vector3.New(0.7, -1.41, -5.7)
				arg_395_1.actors_["3043ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_395_1.actors_["3043ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_395_1.actors_["3043ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_395_1.actors_["3043ui_story"].transform.position).z)
				arg_395_1.actors_["3043ui_story"].transform.localEulerAngles.z = 0
				arg_395_1.actors_["3043ui_story"].transform.localEulerAngles.x = 0
				arg_395_1.actors_["3043ui_story"].transform.localEulerAngles = arg_395_1.actors_["3043ui_story"].transform.localEulerAngles
			end

			local var_398_1 = arg_395_1.actors_["3043ui_story"]

			if 0 < arg_395_1.time_ and arg_395_1.time_ <= 0 + arg_398_0 and not isNil(var_398_1) and arg_395_1.var_.characterEffect3043ui_story == nil then
				arg_395_1.var_.characterEffect3043ui_story = var_398_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_398_2 = 0.200000002980232

			if 0 <= arg_395_1.time_ and arg_395_1.time_ < 0 + var_398_2 and not isNil(var_398_1) then
				if arg_395_1.var_.characterEffect3043ui_story and not isNil(var_398_1) then
					arg_395_1.var_.characterEffect3043ui_story.fillFlat = false
				end
			end

			if arg_395_1.time_ >= 0 + var_398_2 and arg_395_1.time_ < 0 + var_398_2 + arg_398_0 and not isNil(var_398_1) and arg_395_1.var_.characterEffect3043ui_story then
				arg_395_1.var_.characterEffect3043ui_story.fillFlat = false
			end

			if 0 < arg_395_1.time_ and arg_395_1.time_ <= 0 + arg_398_0 then
				arg_395_1:PlayTimeline("3043ui_story", "StoryTimeline/CharAction/story3043/story3043action/3043action1_1")
			end

			if 0 < arg_395_1.time_ and arg_395_1.time_ <= 0 + arg_398_0 then
				arg_395_1:PlayTimeline("3043ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_398_4 = arg_395_1.actors_["1097ui_story"]

			if 0 < arg_395_1.time_ and arg_395_1.time_ <= 0 + arg_398_0 and not isNil(var_398_4) and arg_395_1.var_.characterEffect1097ui_story == nil then
				arg_395_1.var_.characterEffect1097ui_story = var_398_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_398_5 = 0.200000002980232

			if 0 <= arg_395_1.time_ and arg_395_1.time_ < 0 + var_398_5 and not isNil(var_398_4) then
				if arg_395_1.var_.characterEffect1097ui_story and not isNil(var_398_4) then
					arg_395_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_395_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_395_1.time_ - 0) / var_398_5)
				end
			end

			if arg_395_1.time_ >= 0 + var_398_5 and arg_395_1.time_ < 0 + var_398_5 + arg_398_0 and not isNil(var_398_4) and arg_395_1.var_.characterEffect1097ui_story then
				arg_395_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_395_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_398_6 = 0
			local var_398_7 = 0.75

			if 0 < arg_395_1.time_ and arg_395_1.time_ <= var_398_6 + arg_398_0 then
				arg_395_1.talkMaxDuration = 0
				arg_395_1.dialogCg_.alpha = 1

				arg_395_1.dialog_:SetActive(true)
				SetActive(arg_395_1.leftNameGo_, true)

				arg_395_1.leftNameTxt_.text = arg_395_1:FormatText(StoryNameCfg[920].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_395_1.leftNameTxt_.transform)

				arg_395_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_395_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_395_1:RecordName(arg_395_1.leftNameTxt_.text)
				SetActive(arg_395_1.iconTrs_.gameObject, false)
				arg_395_1.callingController_:SetSelectedState("normal")

				local var_398_8 = arg_395_1:GetWordFromCfg(412031094)
				local var_398_9 = arg_395_1:FormatText(var_398_8.content)

				arg_395_1.text_.text = var_398_9

				LuaForUtil.ClearLinePrefixSymbol(arg_395_1.text_)

				local var_398_11 = 30 <= 0 and var_398_7 or var_398_7 * (utf8.len(var_398_9) / 30)

				if (30 <= 0 and var_398_7 or var_398_7 * (utf8.len(var_398_9) / 30)) > 0 and var_398_7 < var_398_11 then
					arg_395_1.talkMaxDuration = var_398_11

					if var_398_11 + var_398_6 > arg_395_1.duration_ then
						arg_395_1.duration_ = var_398_11 + var_398_6
					end
				end

				arg_395_1.text_.text = var_398_9
				arg_395_1.typewritter.percent = 0

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031094", "story_v_out_412031.awb") ~= 0 then
					local var_398_12 = manager.audio:GetVoiceLength("story_v_out_412031", "412031094", "story_v_out_412031.awb") / 1000

					if var_398_12 + var_398_6 > arg_395_1.duration_ then
						arg_395_1.duration_ = var_398_12 + var_398_6
					end

					if var_398_8.prefab_name ~= "" and arg_395_1.actors_[var_398_8.prefab_name] ~= nil then
						local var_398_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_395_1.actors_[var_398_8.prefab_name].transform, "story_v_out_412031", "412031094", "story_v_out_412031.awb")

						arg_395_1:RecordAudio("412031094", var_398_13)
						arg_395_1:RecordAudio("412031094", var_398_13)
					else
						arg_395_1:AudioAction("play", "voice", "story_v_out_412031", "412031094", "story_v_out_412031.awb")
					end

					arg_395_1:RecordHistoryTalkVoice("story_v_out_412031", "412031094", "story_v_out_412031.awb")
				end

				arg_395_1:RecordContent(arg_395_1.text_.text)
			end

			local var_398_14 = math.max(var_398_7, arg_395_1.talkMaxDuration)

			if var_398_6 <= arg_395_1.time_ and arg_395_1.time_ < var_398_6 + var_398_14 then
				arg_395_1.typewritter.percent = (arg_395_1.time_ - var_398_6) / var_398_14

				arg_395_1.typewritter:SetDirty()
			end

			if arg_395_1.time_ >= var_398_6 + var_398_14 and arg_395_1.time_ < var_398_6 + var_398_14 + arg_398_0 then
				arg_395_1.typewritter.percent = 1

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(true)
			end
		end

		arg_395_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_395_1:InitPlayNodeList()
	end,
	Play412031095 = function(arg_399_0, arg_399_1)
		arg_399_1.time_ = 0
		arg_399_1.frameCnt_ = 0
		arg_399_1.state_ = "playing"
		arg_399_1.curTalkId_ = 412031095
		arg_399_1.duration_ = 6.33

		local var_399_0 = {
			zh = 6.333,
			ja = 6
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
				arg_399_0:Play412031096(arg_399_1)
			end
		end

		function arg_399_1.onSingleLineUpdate_(arg_402_0)
			if 0 < arg_399_1.time_ and arg_399_1.time_ <= 0 + arg_402_0 and not isNil(arg_399_1.actors_["1097ui_story"]) and arg_399_1.var_.characterEffect1097ui_story == nil then
				arg_399_1.var_.characterEffect1097ui_story = arg_399_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_402_0 = 0.200000002980232

			if 0 <= arg_399_1.time_ and arg_399_1.time_ < 0 + var_402_0 and not isNil(arg_399_1.actors_["1097ui_story"]) then
				if arg_399_1.var_.characterEffect1097ui_story and not isNil(arg_399_1.actors_["1097ui_story"]) then
					arg_399_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_399_1.time_ >= 0 + var_402_0 and arg_399_1.time_ < 0 + var_402_0 + arg_402_0 and not isNil(arg_399_1.actors_["1097ui_story"]) and arg_399_1.var_.characterEffect1097ui_story then
				arg_399_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_399_1.time_ and arg_399_1.time_ <= 0 + arg_402_0 then
				arg_399_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action7_1")
			end

			if 0 < arg_399_1.time_ and arg_399_1.time_ <= 0 + arg_402_0 then
				arg_399_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_402_2 = arg_399_1.actors_["3043ui_story"]

			if 0 < arg_399_1.time_ and arg_399_1.time_ <= 0 + arg_402_0 and not isNil(var_402_2) and arg_399_1.var_.characterEffect3043ui_story == nil then
				arg_399_1.var_.characterEffect3043ui_story = var_402_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_402_3 = 0.200000002980232

			if 0 <= arg_399_1.time_ and arg_399_1.time_ < 0 + var_402_3 and not isNil(var_402_2) then
				if arg_399_1.var_.characterEffect3043ui_story and not isNil(var_402_2) then
					arg_399_1.var_.characterEffect3043ui_story.fillFlat = true
					arg_399_1.var_.characterEffect3043ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_399_1.time_ - 0) / var_402_3)
				end
			end

			if arg_399_1.time_ >= 0 + var_402_3 and arg_399_1.time_ < 0 + var_402_3 + arg_402_0 and not isNil(var_402_2) and arg_399_1.var_.characterEffect3043ui_story then
				arg_399_1.var_.characterEffect3043ui_story.fillFlat = true
				arg_399_1.var_.characterEffect3043ui_story.fillRatio = 0.5
			end

			local var_402_4 = 0
			local var_402_5 = 0.575

			if 0 < arg_399_1.time_ and arg_399_1.time_ <= var_402_4 + arg_402_0 then
				arg_399_1.talkMaxDuration = 0
				arg_399_1.dialogCg_.alpha = 1

				arg_399_1.dialog_:SetActive(true)
				SetActive(arg_399_1.leftNameGo_, true)

				arg_399_1.leftNameTxt_.text = arg_399_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_399_1.leftNameTxt_.transform)

				arg_399_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_399_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_399_1:RecordName(arg_399_1.leftNameTxt_.text)
				SetActive(arg_399_1.iconTrs_.gameObject, false)
				arg_399_1.callingController_:SetSelectedState("normal")

				local var_402_6 = arg_399_1:GetWordFromCfg(412031095)
				local var_402_7 = arg_399_1:FormatText(var_402_6.content)

				arg_399_1.text_.text = var_402_7

				LuaForUtil.ClearLinePrefixSymbol(arg_399_1.text_)

				local var_402_9 = 23 <= 0 and var_402_5 or var_402_5 * (utf8.len(var_402_7) / 23)

				if (23 <= 0 and var_402_5 or var_402_5 * (utf8.len(var_402_7) / 23)) > 0 and var_402_5 < var_402_9 then
					arg_399_1.talkMaxDuration = var_402_9

					if var_402_9 + var_402_4 > arg_399_1.duration_ then
						arg_399_1.duration_ = var_402_9 + var_402_4
					end
				end

				arg_399_1.text_.text = var_402_7
				arg_399_1.typewritter.percent = 0

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031095", "story_v_out_412031.awb") ~= 0 then
					local var_402_10 = manager.audio:GetVoiceLength("story_v_out_412031", "412031095", "story_v_out_412031.awb") / 1000

					if var_402_10 + var_402_4 > arg_399_1.duration_ then
						arg_399_1.duration_ = var_402_10 + var_402_4
					end

					if var_402_6.prefab_name ~= "" and arg_399_1.actors_[var_402_6.prefab_name] ~= nil then
						local var_402_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_399_1.actors_[var_402_6.prefab_name].transform, "story_v_out_412031", "412031095", "story_v_out_412031.awb")

						arg_399_1:RecordAudio("412031095", var_402_11)
						arg_399_1:RecordAudio("412031095", var_402_11)
					else
						arg_399_1:AudioAction("play", "voice", "story_v_out_412031", "412031095", "story_v_out_412031.awb")
					end

					arg_399_1:RecordHistoryTalkVoice("story_v_out_412031", "412031095", "story_v_out_412031.awb")
				end

				arg_399_1:RecordContent(arg_399_1.text_.text)
			end

			local var_402_12 = math.max(var_402_5, arg_399_1.talkMaxDuration)

			if var_402_4 <= arg_399_1.time_ and arg_399_1.time_ < var_402_4 + var_402_12 then
				arg_399_1.typewritter.percent = (arg_399_1.time_ - var_402_4) / var_402_12

				arg_399_1.typewritter:SetDirty()
			end

			if arg_399_1.time_ >= var_402_4 + var_402_12 and arg_399_1.time_ < var_402_4 + var_402_12 + arg_402_0 then
				arg_399_1.typewritter.percent = 1

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(true)
			end
		end

		arg_399_1.nodeConfigList_ = {}

		arg_399_1:InitPlayNodeList()
	end,
	Play412031096 = function(arg_403_0, arg_403_1)
		arg_403_1.time_ = 0
		arg_403_1.frameCnt_ = 0
		arg_403_1.state_ = "playing"
		arg_403_1.curTalkId_ = 412031096
		arg_403_1.duration_ = 9.6

		local var_403_0 = {
			zh = 9.6,
			ja = 7.6
		}
		local var_403_1 = manager.audio:GetLocalizationFlag()

		if var_403_0[var_403_1] ~= nil then
			arg_403_1.duration_ = var_403_0[var_403_1]
		end

		SetActive(arg_403_1.tipsGo_, false)

		function arg_403_1.onSingleLineFinish_()
			arg_403_1.onSingleLineUpdate_ = nil
			arg_403_1.onSingleLineFinish_ = nil
			arg_403_1.state_ = "waiting"
		end

		function arg_403_1.playNext_(arg_405_0)
			if arg_405_0 == 1 then
				arg_403_0:Play412031097(arg_403_1)
			end
		end

		function arg_403_1.onSingleLineUpdate_(arg_406_0)
			if 0 < arg_403_1.time_ and arg_403_1.time_ <= 0 + arg_406_0 and not isNil(arg_403_1.actors_["3043ui_story"]) and arg_403_1.var_.characterEffect3043ui_story == nil then
				arg_403_1.var_.characterEffect3043ui_story = arg_403_1.actors_["3043ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_406_0 = 0.200000002980232

			if 0 <= arg_403_1.time_ and arg_403_1.time_ < 0 + var_406_0 and not isNil(arg_403_1.actors_["3043ui_story"]) then
				if arg_403_1.var_.characterEffect3043ui_story and not isNil(arg_403_1.actors_["3043ui_story"]) then
					arg_403_1.var_.characterEffect3043ui_story.fillFlat = false
				end
			end

			if arg_403_1.time_ >= 0 + var_406_0 and arg_403_1.time_ < 0 + var_406_0 + arg_406_0 and not isNil(arg_403_1.actors_["3043ui_story"]) and arg_403_1.var_.characterEffect3043ui_story then
				arg_403_1.var_.characterEffect3043ui_story.fillFlat = false
			end

			if 0 < arg_403_1.time_ and arg_403_1.time_ <= 0 + arg_406_0 then
				arg_403_1:PlayTimeline("3043ui_story", "StoryTimeline/CharAction/story3043/story3043action/3043action1_1")
			end

			if 0 < arg_403_1.time_ and arg_403_1.time_ <= 0 + arg_406_0 then
				arg_403_1:PlayTimeline("3043ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_406_2 = arg_403_1.actors_["1097ui_story"]

			if 0 < arg_403_1.time_ and arg_403_1.time_ <= 0 + arg_406_0 and not isNil(var_406_2) and arg_403_1.var_.characterEffect1097ui_story == nil then
				arg_403_1.var_.characterEffect1097ui_story = var_406_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_406_3 = 0.200000002980232

			if 0 <= arg_403_1.time_ and arg_403_1.time_ < 0 + var_406_3 and not isNil(var_406_2) then
				if arg_403_1.var_.characterEffect1097ui_story and not isNil(var_406_2) then
					arg_403_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_403_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_403_1.time_ - 0) / var_406_3)
				end
			end

			if arg_403_1.time_ >= 0 + var_406_3 and arg_403_1.time_ < 0 + var_406_3 + arg_406_0 and not isNil(var_406_2) and arg_403_1.var_.characterEffect1097ui_story then
				arg_403_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_403_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_406_4 = 0
			local var_406_5 = 0.95

			if 0 < arg_403_1.time_ and arg_403_1.time_ <= var_406_4 + arg_406_0 then
				arg_403_1.talkMaxDuration = 0
				arg_403_1.dialogCg_.alpha = 1

				arg_403_1.dialog_:SetActive(true)
				SetActive(arg_403_1.leftNameGo_, true)

				arg_403_1.leftNameTxt_.text = arg_403_1:FormatText(StoryNameCfg[920].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_403_1.leftNameTxt_.transform)

				arg_403_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_403_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_403_1:RecordName(arg_403_1.leftNameTxt_.text)
				SetActive(arg_403_1.iconTrs_.gameObject, false)
				arg_403_1.callingController_:SetSelectedState("normal")

				local var_406_6 = arg_403_1:GetWordFromCfg(412031096)
				local var_406_7 = arg_403_1:FormatText(var_406_6.content)

				arg_403_1.text_.text = var_406_7

				LuaForUtil.ClearLinePrefixSymbol(arg_403_1.text_)

				local var_406_9 = 38 <= 0 and var_406_5 or var_406_5 * (utf8.len(var_406_7) / 38)

				if (38 <= 0 and var_406_5 or var_406_5 * (utf8.len(var_406_7) / 38)) > 0 and var_406_5 < var_406_9 then
					arg_403_1.talkMaxDuration = var_406_9

					if var_406_9 + var_406_4 > arg_403_1.duration_ then
						arg_403_1.duration_ = var_406_9 + var_406_4
					end
				end

				arg_403_1.text_.text = var_406_7
				arg_403_1.typewritter.percent = 0

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031096", "story_v_out_412031.awb") ~= 0 then
					local var_406_10 = manager.audio:GetVoiceLength("story_v_out_412031", "412031096", "story_v_out_412031.awb") / 1000

					if var_406_10 + var_406_4 > arg_403_1.duration_ then
						arg_403_1.duration_ = var_406_10 + var_406_4
					end

					if var_406_6.prefab_name ~= "" and arg_403_1.actors_[var_406_6.prefab_name] ~= nil then
						local var_406_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_403_1.actors_[var_406_6.prefab_name].transform, "story_v_out_412031", "412031096", "story_v_out_412031.awb")

						arg_403_1:RecordAudio("412031096", var_406_11)
						arg_403_1:RecordAudio("412031096", var_406_11)
					else
						arg_403_1:AudioAction("play", "voice", "story_v_out_412031", "412031096", "story_v_out_412031.awb")
					end

					arg_403_1:RecordHistoryTalkVoice("story_v_out_412031", "412031096", "story_v_out_412031.awb")
				end

				arg_403_1:RecordContent(arg_403_1.text_.text)
			end

			local var_406_12 = math.max(var_406_5, arg_403_1.talkMaxDuration)

			if var_406_4 <= arg_403_1.time_ and arg_403_1.time_ < var_406_4 + var_406_12 then
				arg_403_1.typewritter.percent = (arg_403_1.time_ - var_406_4) / var_406_12

				arg_403_1.typewritter:SetDirty()
			end

			if arg_403_1.time_ >= var_406_4 + var_406_12 and arg_403_1.time_ < var_406_4 + var_406_12 + arg_406_0 then
				arg_403_1.typewritter.percent = 1

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(true)
			end
		end

		arg_403_1.nodeConfigList_ = {}

		arg_403_1:InitPlayNodeList()
	end,
	Play412031097 = function(arg_407_0, arg_407_1)
		arg_407_1.time_ = 0
		arg_407_1.frameCnt_ = 0
		arg_407_1.state_ = "playing"
		arg_407_1.curTalkId_ = 412031097
		arg_407_1.duration_ = 3.17

		local var_407_0 = {
			zh = 3.133,
			ja = 3.166
		}
		local var_407_1 = manager.audio:GetLocalizationFlag()

		if var_407_0[var_407_1] ~= nil then
			arg_407_1.duration_ = var_407_0[var_407_1]
		end

		SetActive(arg_407_1.tipsGo_, false)

		function arg_407_1.onSingleLineFinish_()
			arg_407_1.onSingleLineUpdate_ = nil
			arg_407_1.onSingleLineFinish_ = nil
			arg_407_1.state_ = "waiting"
		end

		function arg_407_1.playNext_(arg_409_0)
			if arg_409_0 == 1 then
				arg_407_0:Play412031098(arg_407_1)
			end
		end

		function arg_407_1.onSingleLineUpdate_(arg_410_0)
			if 0 < arg_407_1.time_ and arg_407_1.time_ <= 0 + arg_410_0 and not isNil(arg_407_1.actors_["1097ui_story"]) and arg_407_1.var_.characterEffect1097ui_story == nil then
				arg_407_1.var_.characterEffect1097ui_story = arg_407_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_410_0 = 0.200000002980232

			if 0 <= arg_407_1.time_ and arg_407_1.time_ < 0 + var_410_0 and not isNil(arg_407_1.actors_["1097ui_story"]) then
				if arg_407_1.var_.characterEffect1097ui_story and not isNil(arg_407_1.actors_["1097ui_story"]) then
					arg_407_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_407_1.time_ >= 0 + var_410_0 and arg_407_1.time_ < 0 + var_410_0 + arg_410_0 and not isNil(arg_407_1.actors_["1097ui_story"]) and arg_407_1.var_.characterEffect1097ui_story then
				arg_407_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_407_1.time_ and arg_407_1.time_ <= 0 + arg_410_0 then
				arg_407_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action7_2")
			end

			if 0 < arg_407_1.time_ and arg_407_1.time_ <= 0 + arg_410_0 then
				arg_407_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_410_2 = arg_407_1.actors_["3043ui_story"]

			if 0 < arg_407_1.time_ and arg_407_1.time_ <= 0 + arg_410_0 and not isNil(var_410_2) and arg_407_1.var_.characterEffect3043ui_story == nil then
				arg_407_1.var_.characterEffect3043ui_story = var_410_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_410_3 = 0.200000002980232

			if 0 <= arg_407_1.time_ and arg_407_1.time_ < 0 + var_410_3 and not isNil(var_410_2) then
				if arg_407_1.var_.characterEffect3043ui_story and not isNil(var_410_2) then
					arg_407_1.var_.characterEffect3043ui_story.fillFlat = true
					arg_407_1.var_.characterEffect3043ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_407_1.time_ - 0) / var_410_3)
				end
			end

			if arg_407_1.time_ >= 0 + var_410_3 and arg_407_1.time_ < 0 + var_410_3 + arg_410_0 and not isNil(var_410_2) and arg_407_1.var_.characterEffect3043ui_story then
				arg_407_1.var_.characterEffect3043ui_story.fillFlat = true
				arg_407_1.var_.characterEffect3043ui_story.fillRatio = 0.5
			end

			local var_410_4 = 0
			local var_410_5 = 0.2

			if 0 < arg_407_1.time_ and arg_407_1.time_ <= var_410_4 + arg_410_0 then
				arg_407_1.talkMaxDuration = 0
				arg_407_1.dialogCg_.alpha = 1

				arg_407_1.dialog_:SetActive(true)
				SetActive(arg_407_1.leftNameGo_, true)

				arg_407_1.leftNameTxt_.text = arg_407_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_407_1.leftNameTxt_.transform)

				arg_407_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_407_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_407_1:RecordName(arg_407_1.leftNameTxt_.text)
				SetActive(arg_407_1.iconTrs_.gameObject, false)
				arg_407_1.callingController_:SetSelectedState("normal")

				local var_410_6 = arg_407_1:GetWordFromCfg(412031097)
				local var_410_7 = arg_407_1:FormatText(var_410_6.content)

				arg_407_1.text_.text = var_410_7

				LuaForUtil.ClearLinePrefixSymbol(arg_407_1.text_)

				local var_410_9 = 8 <= 0 and var_410_5 or var_410_5 * (utf8.len(var_410_7) / 8)

				if (8 <= 0 and var_410_5 or var_410_5 * (utf8.len(var_410_7) / 8)) > 0 and var_410_5 < var_410_9 then
					arg_407_1.talkMaxDuration = var_410_9

					if var_410_9 + var_410_4 > arg_407_1.duration_ then
						arg_407_1.duration_ = var_410_9 + var_410_4
					end
				end

				arg_407_1.text_.text = var_410_7
				arg_407_1.typewritter.percent = 0

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031097", "story_v_out_412031.awb") ~= 0 then
					local var_410_10 = manager.audio:GetVoiceLength("story_v_out_412031", "412031097", "story_v_out_412031.awb") / 1000

					if var_410_10 + var_410_4 > arg_407_1.duration_ then
						arg_407_1.duration_ = var_410_10 + var_410_4
					end

					if var_410_6.prefab_name ~= "" and arg_407_1.actors_[var_410_6.prefab_name] ~= nil then
						local var_410_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_407_1.actors_[var_410_6.prefab_name].transform, "story_v_out_412031", "412031097", "story_v_out_412031.awb")

						arg_407_1:RecordAudio("412031097", var_410_11)
						arg_407_1:RecordAudio("412031097", var_410_11)
					else
						arg_407_1:AudioAction("play", "voice", "story_v_out_412031", "412031097", "story_v_out_412031.awb")
					end

					arg_407_1:RecordHistoryTalkVoice("story_v_out_412031", "412031097", "story_v_out_412031.awb")
				end

				arg_407_1:RecordContent(arg_407_1.text_.text)
			end

			local var_410_12 = math.max(var_410_5, arg_407_1.talkMaxDuration)

			if var_410_4 <= arg_407_1.time_ and arg_407_1.time_ < var_410_4 + var_410_12 then
				arg_407_1.typewritter.percent = (arg_407_1.time_ - var_410_4) / var_410_12

				arg_407_1.typewritter:SetDirty()
			end

			if arg_407_1.time_ >= var_410_4 + var_410_12 and arg_407_1.time_ < var_410_4 + var_410_12 + arg_410_0 then
				arg_407_1.typewritter.percent = 1

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(true)
			end
		end

		arg_407_1.nodeConfigList_ = {}

		arg_407_1:InitPlayNodeList()
	end,
	Play412031098 = function(arg_411_0, arg_411_1)
		arg_411_1.time_ = 0
		arg_411_1.frameCnt_ = 0
		arg_411_1.state_ = "playing"
		arg_411_1.curTalkId_ = 412031098
		arg_411_1.duration_ = 4.1

		local var_411_0 = {
			zh = 2.533,
			ja = 4.1
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
				arg_411_0:Play412031099(arg_411_1)
			end
		end

		function arg_411_1.onSingleLineUpdate_(arg_414_0)
			if 0 < arg_411_1.time_ and arg_411_1.time_ <= 0 + arg_414_0 and not isNil(arg_411_1.actors_["3043ui_story"]) and arg_411_1.var_.characterEffect3043ui_story == nil then
				arg_411_1.var_.characterEffect3043ui_story = arg_411_1.actors_["3043ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_414_0 = 0.200000002980232

			if 0 <= arg_411_1.time_ and arg_411_1.time_ < 0 + var_414_0 and not isNil(arg_411_1.actors_["3043ui_story"]) then
				if arg_411_1.var_.characterEffect3043ui_story and not isNil(arg_411_1.actors_["3043ui_story"]) then
					arg_411_1.var_.characterEffect3043ui_story.fillFlat = false
				end
			end

			if arg_411_1.time_ >= 0 + var_414_0 and arg_411_1.time_ < 0 + var_414_0 + arg_414_0 and not isNil(arg_411_1.actors_["3043ui_story"]) and arg_411_1.var_.characterEffect3043ui_story then
				arg_411_1.var_.characterEffect3043ui_story.fillFlat = false
			end

			local var_414_2 = arg_411_1.actors_["1097ui_story"]

			if 0 < arg_411_1.time_ and arg_411_1.time_ <= 0 + arg_414_0 and not isNil(var_414_2) and arg_411_1.var_.characterEffect1097ui_story == nil then
				arg_411_1.var_.characterEffect1097ui_story = var_414_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_414_3 = 0.200000002980232

			if 0 <= arg_411_1.time_ and arg_411_1.time_ < 0 + var_414_3 and not isNil(var_414_2) then
				if arg_411_1.var_.characterEffect1097ui_story and not isNil(var_414_2) then
					arg_411_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_411_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_411_1.time_ - 0) / var_414_3)
				end
			end

			if arg_411_1.time_ >= 0 + var_414_3 and arg_411_1.time_ < 0 + var_414_3 + arg_414_0 and not isNil(var_414_2) and arg_411_1.var_.characterEffect1097ui_story then
				arg_411_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_411_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_414_4 = 0
			local var_414_5 = 0.25

			if 0 < arg_411_1.time_ and arg_411_1.time_ <= var_414_4 + arg_414_0 then
				arg_411_1.talkMaxDuration = 0
				arg_411_1.dialogCg_.alpha = 1

				arg_411_1.dialog_:SetActive(true)
				SetActive(arg_411_1.leftNameGo_, true)

				arg_411_1.leftNameTxt_.text = arg_411_1:FormatText(StoryNameCfg[920].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_411_1.leftNameTxt_.transform)

				arg_411_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_411_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_411_1:RecordName(arg_411_1.leftNameTxt_.text)
				SetActive(arg_411_1.iconTrs_.gameObject, false)
				arg_411_1.callingController_:SetSelectedState("normal")

				local var_414_6 = arg_411_1:GetWordFromCfg(412031098)
				local var_414_7 = arg_411_1:FormatText(var_414_6.content)

				arg_411_1.text_.text = var_414_7

				LuaForUtil.ClearLinePrefixSymbol(arg_411_1.text_)

				local var_414_9 = 10 <= 0 and var_414_5 or var_414_5 * (utf8.len(var_414_7) / 10)

				if (10 <= 0 and var_414_5 or var_414_5 * (utf8.len(var_414_7) / 10)) > 0 and var_414_5 < var_414_9 then
					arg_411_1.talkMaxDuration = var_414_9

					if var_414_9 + var_414_4 > arg_411_1.duration_ then
						arg_411_1.duration_ = var_414_9 + var_414_4
					end
				end

				arg_411_1.text_.text = var_414_7
				arg_411_1.typewritter.percent = 0

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031098", "story_v_out_412031.awb") ~= 0 then
					local var_414_10 = manager.audio:GetVoiceLength("story_v_out_412031", "412031098", "story_v_out_412031.awb") / 1000

					if var_414_10 + var_414_4 > arg_411_1.duration_ then
						arg_411_1.duration_ = var_414_10 + var_414_4
					end

					if var_414_6.prefab_name ~= "" and arg_411_1.actors_[var_414_6.prefab_name] ~= nil then
						local var_414_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_411_1.actors_[var_414_6.prefab_name].transform, "story_v_out_412031", "412031098", "story_v_out_412031.awb")

						arg_411_1:RecordAudio("412031098", var_414_11)
						arg_411_1:RecordAudio("412031098", var_414_11)
					else
						arg_411_1:AudioAction("play", "voice", "story_v_out_412031", "412031098", "story_v_out_412031.awb")
					end

					arg_411_1:RecordHistoryTalkVoice("story_v_out_412031", "412031098", "story_v_out_412031.awb")
				end

				arg_411_1:RecordContent(arg_411_1.text_.text)
			end

			local var_414_12 = math.max(var_414_5, arg_411_1.talkMaxDuration)

			if var_414_4 <= arg_411_1.time_ and arg_411_1.time_ < var_414_4 + var_414_12 then
				arg_411_1.typewritter.percent = (arg_411_1.time_ - var_414_4) / var_414_12

				arg_411_1.typewritter:SetDirty()
			end

			if arg_411_1.time_ >= var_414_4 + var_414_12 and arg_411_1.time_ < var_414_4 + var_414_12 + arg_414_0 then
				arg_411_1.typewritter.percent = 1

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(true)
			end
		end

		arg_411_1.nodeConfigList_ = {}

		arg_411_1:InitPlayNodeList()
	end,
	Play412031099 = function(arg_415_0, arg_415_1)
		arg_415_1.time_ = 0
		arg_415_1.frameCnt_ = 0
		arg_415_1.state_ = "playing"
		arg_415_1.curTalkId_ = 412031099
		arg_415_1.duration_ = 4.53

		local var_415_0 = {
			zh = 3.233,
			ja = 4.533
		}
		local var_415_1 = manager.audio:GetLocalizationFlag()

		if var_415_0[var_415_1] ~= nil then
			arg_415_1.duration_ = var_415_0[var_415_1]
		end

		SetActive(arg_415_1.tipsGo_, false)

		function arg_415_1.onSingleLineFinish_()
			arg_415_1.onSingleLineUpdate_ = nil
			arg_415_1.onSingleLineFinish_ = nil
			arg_415_1.state_ = "waiting"
		end

		function arg_415_1.playNext_(arg_417_0)
			if arg_417_0 == 1 then
				arg_415_0:Play412031100(arg_415_1)
			end
		end

		function arg_415_1.onSingleLineUpdate_(arg_418_0)
			if 0 < arg_415_1.time_ and arg_415_1.time_ <= 0 + arg_418_0 and not isNil(arg_415_1.actors_["3043ui_story"]) and arg_415_1.var_.characterEffect3043ui_story == nil then
				arg_415_1.var_.characterEffect3043ui_story = arg_415_1.actors_["3043ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_418_0 = 0.200000002980232

			if 0 <= arg_415_1.time_ and arg_415_1.time_ < 0 + var_418_0 and not isNil(arg_415_1.actors_["3043ui_story"]) then
				if arg_415_1.var_.characterEffect3043ui_story and not isNil(arg_415_1.actors_["3043ui_story"]) then
					arg_415_1.var_.characterEffect3043ui_story.fillFlat = true
					arg_415_1.var_.characterEffect3043ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_415_1.time_ - 0) / var_418_0)
				end
			end

			if arg_415_1.time_ >= 0 + var_418_0 and arg_415_1.time_ < 0 + var_418_0 + arg_418_0 and not isNil(arg_415_1.actors_["3043ui_story"]) and arg_415_1.var_.characterEffect3043ui_story then
				arg_415_1.var_.characterEffect3043ui_story.fillFlat = true
				arg_415_1.var_.characterEffect3043ui_story.fillRatio = 0.5
			end

			local var_418_1 = arg_415_1.actors_["1097ui_story"]

			if 0 < arg_415_1.time_ and arg_415_1.time_ <= 0 + arg_418_0 and not isNil(var_418_1) and arg_415_1.var_.characterEffect1097ui_story == nil then
				arg_415_1.var_.characterEffect1097ui_story = var_418_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_418_2 = 0.200000002980232

			if 0 <= arg_415_1.time_ and arg_415_1.time_ < 0 + var_418_2 and not isNil(var_418_1) then
				if arg_415_1.var_.characterEffect1097ui_story and not isNil(var_418_1) then
					arg_415_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_415_1.time_ >= 0 + var_418_2 and arg_415_1.time_ < 0 + var_418_2 + arg_418_0 and not isNil(var_418_1) and arg_415_1.var_.characterEffect1097ui_story then
				arg_415_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_418_4 = 0
			local var_418_5 = 0.35

			if 0 < arg_415_1.time_ and arg_415_1.time_ <= var_418_4 + arg_418_0 then
				arg_415_1.talkMaxDuration = 0
				arg_415_1.dialogCg_.alpha = 1

				arg_415_1.dialog_:SetActive(true)
				SetActive(arg_415_1.leftNameGo_, true)

				arg_415_1.leftNameTxt_.text = arg_415_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_415_1.leftNameTxt_.transform)

				arg_415_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_415_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_415_1:RecordName(arg_415_1.leftNameTxt_.text)
				SetActive(arg_415_1.iconTrs_.gameObject, false)
				arg_415_1.callingController_:SetSelectedState("normal")

				local var_418_6 = arg_415_1:GetWordFromCfg(412031099)
				local var_418_7 = arg_415_1:FormatText(var_418_6.content)

				arg_415_1.text_.text = var_418_7

				LuaForUtil.ClearLinePrefixSymbol(arg_415_1.text_)

				local var_418_9 = 13 <= 0 and var_418_5 or var_418_5 * (utf8.len(var_418_7) / 13)

				if (13 <= 0 and var_418_5 or var_418_5 * (utf8.len(var_418_7) / 13)) > 0 and var_418_5 < var_418_9 then
					arg_415_1.talkMaxDuration = var_418_9

					if var_418_9 + var_418_4 > arg_415_1.duration_ then
						arg_415_1.duration_ = var_418_9 + var_418_4
					end
				end

				arg_415_1.text_.text = var_418_7
				arg_415_1.typewritter.percent = 0

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031099", "story_v_out_412031.awb") ~= 0 then
					local var_418_10 = manager.audio:GetVoiceLength("story_v_out_412031", "412031099", "story_v_out_412031.awb") / 1000

					if var_418_10 + var_418_4 > arg_415_1.duration_ then
						arg_415_1.duration_ = var_418_10 + var_418_4
					end

					if var_418_6.prefab_name ~= "" and arg_415_1.actors_[var_418_6.prefab_name] ~= nil then
						local var_418_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_415_1.actors_[var_418_6.prefab_name].transform, "story_v_out_412031", "412031099", "story_v_out_412031.awb")

						arg_415_1:RecordAudio("412031099", var_418_11)
						arg_415_1:RecordAudio("412031099", var_418_11)
					else
						arg_415_1:AudioAction("play", "voice", "story_v_out_412031", "412031099", "story_v_out_412031.awb")
					end

					arg_415_1:RecordHistoryTalkVoice("story_v_out_412031", "412031099", "story_v_out_412031.awb")
				end

				arg_415_1:RecordContent(arg_415_1.text_.text)
			end

			local var_418_12 = math.max(var_418_5, arg_415_1.talkMaxDuration)

			if var_418_4 <= arg_415_1.time_ and arg_415_1.time_ < var_418_4 + var_418_12 then
				arg_415_1.typewritter.percent = (arg_415_1.time_ - var_418_4) / var_418_12

				arg_415_1.typewritter:SetDirty()
			end

			if arg_415_1.time_ >= var_418_4 + var_418_12 and arg_415_1.time_ < var_418_4 + var_418_12 + arg_418_0 then
				arg_415_1.typewritter.percent = 1

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(true)
			end
		end

		arg_415_1.nodeConfigList_ = {}

		arg_415_1:InitPlayNodeList()
	end,
	Play412031100 = function(arg_419_0, arg_419_1)
		arg_419_1.time_ = 0
		arg_419_1.frameCnt_ = 0
		arg_419_1.state_ = "playing"
		arg_419_1.curTalkId_ = 412031100
		arg_419_1.duration_ = 1.4

		local var_419_0 = {
			zh = 1.4,
			ja = 1.3
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
				arg_419_0:Play412031101(arg_419_1)
			end
		end

		function arg_419_1.onSingleLineUpdate_(arg_422_0)
			if 0 < arg_419_1.time_ and arg_419_1.time_ <= 0 + arg_422_0 and not isNil(arg_419_1.actors_["3043ui_story"]) and arg_419_1.var_.characterEffect3043ui_story == nil then
				arg_419_1.var_.characterEffect3043ui_story = arg_419_1.actors_["3043ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_422_0 = 0.200000002980232

			if 0 <= arg_419_1.time_ and arg_419_1.time_ < 0 + var_422_0 and not isNil(arg_419_1.actors_["3043ui_story"]) then
				if arg_419_1.var_.characterEffect3043ui_story and not isNil(arg_419_1.actors_["3043ui_story"]) then
					arg_419_1.var_.characterEffect3043ui_story.fillFlat = false
				end
			end

			if arg_419_1.time_ >= 0 + var_422_0 and arg_419_1.time_ < 0 + var_422_0 + arg_422_0 and not isNil(arg_419_1.actors_["3043ui_story"]) and arg_419_1.var_.characterEffect3043ui_story then
				arg_419_1.var_.characterEffect3043ui_story.fillFlat = false
			end

			local var_422_2 = arg_419_1.actors_["1097ui_story"]

			if 0 < arg_419_1.time_ and arg_419_1.time_ <= 0 + arg_422_0 and not isNil(var_422_2) and arg_419_1.var_.characterEffect1097ui_story == nil then
				arg_419_1.var_.characterEffect1097ui_story = var_422_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_422_3 = 0.200000002980232

			if 0 <= arg_419_1.time_ and arg_419_1.time_ < 0 + var_422_3 and not isNil(var_422_2) then
				if arg_419_1.var_.characterEffect1097ui_story and not isNil(var_422_2) then
					arg_419_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_419_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_419_1.time_ - 0) / var_422_3)
				end
			end

			if arg_419_1.time_ >= 0 + var_422_3 and arg_419_1.time_ < 0 + var_422_3 + arg_422_0 and not isNil(var_422_2) and arg_419_1.var_.characterEffect1097ui_story then
				arg_419_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_419_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_422_4 = 0
			local var_422_5 = 0.1

			if 0 < arg_419_1.time_ and arg_419_1.time_ <= var_422_4 + arg_422_0 then
				arg_419_1.talkMaxDuration = 0
				arg_419_1.dialogCg_.alpha = 1

				arg_419_1.dialog_:SetActive(true)
				SetActive(arg_419_1.leftNameGo_, true)

				arg_419_1.leftNameTxt_.text = arg_419_1:FormatText(StoryNameCfg[920].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_419_1.leftNameTxt_.transform)

				arg_419_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_419_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_419_1:RecordName(arg_419_1.leftNameTxt_.text)
				SetActive(arg_419_1.iconTrs_.gameObject, false)
				arg_419_1.callingController_:SetSelectedState("normal")

				local var_422_6 = arg_419_1:GetWordFromCfg(412031100)
				local var_422_7 = arg_419_1:FormatText(var_422_6.content)

				arg_419_1.text_.text = var_422_7

				LuaForUtil.ClearLinePrefixSymbol(arg_419_1.text_)

				local var_422_9 = 4 <= 0 and var_422_5 or var_422_5 * (utf8.len(var_422_7) / 4)

				if (4 <= 0 and var_422_5 or var_422_5 * (utf8.len(var_422_7) / 4)) > 0 and var_422_5 < var_422_9 then
					arg_419_1.talkMaxDuration = var_422_9

					if var_422_9 + var_422_4 > arg_419_1.duration_ then
						arg_419_1.duration_ = var_422_9 + var_422_4
					end
				end

				arg_419_1.text_.text = var_422_7
				arg_419_1.typewritter.percent = 0

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031100", "story_v_out_412031.awb") ~= 0 then
					local var_422_10 = manager.audio:GetVoiceLength("story_v_out_412031", "412031100", "story_v_out_412031.awb") / 1000

					if var_422_10 + var_422_4 > arg_419_1.duration_ then
						arg_419_1.duration_ = var_422_10 + var_422_4
					end

					if var_422_6.prefab_name ~= "" and arg_419_1.actors_[var_422_6.prefab_name] ~= nil then
						local var_422_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_419_1.actors_[var_422_6.prefab_name].transform, "story_v_out_412031", "412031100", "story_v_out_412031.awb")

						arg_419_1:RecordAudio("412031100", var_422_11)
						arg_419_1:RecordAudio("412031100", var_422_11)
					else
						arg_419_1:AudioAction("play", "voice", "story_v_out_412031", "412031100", "story_v_out_412031.awb")
					end

					arg_419_1:RecordHistoryTalkVoice("story_v_out_412031", "412031100", "story_v_out_412031.awb")
				end

				arg_419_1:RecordContent(arg_419_1.text_.text)
			end

			local var_422_12 = math.max(var_422_5, arg_419_1.talkMaxDuration)

			if var_422_4 <= arg_419_1.time_ and arg_419_1.time_ < var_422_4 + var_422_12 then
				arg_419_1.typewritter.percent = (arg_419_1.time_ - var_422_4) / var_422_12

				arg_419_1.typewritter:SetDirty()
			end

			if arg_419_1.time_ >= var_422_4 + var_422_12 and arg_419_1.time_ < var_422_4 + var_422_12 + arg_422_0 then
				arg_419_1.typewritter.percent = 1

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(true)
			end
		end

		arg_419_1.nodeConfigList_ = {}

		arg_419_1:InitPlayNodeList()
	end,
	Play412031101 = function(arg_423_0, arg_423_1)
		arg_423_1.time_ = 0
		arg_423_1.frameCnt_ = 0
		arg_423_1.state_ = "playing"
		arg_423_1.curTalkId_ = 412031101
		arg_423_1.duration_ = 6.5

		local var_423_0 = {
			zh = 3.566,
			ja = 6.5
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
				arg_423_0:Play412031102(arg_423_1)
			end
		end

		function arg_423_1.onSingleLineUpdate_(arg_426_0)
			if 0 < arg_423_1.time_ and arg_423_1.time_ <= 0 + arg_426_0 and not isNil(arg_423_1.actors_["1097ui_story"]) and arg_423_1.var_.characterEffect1097ui_story == nil then
				arg_423_1.var_.characterEffect1097ui_story = arg_423_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_426_0 = 0.200000002980232

			if 0 <= arg_423_1.time_ and arg_423_1.time_ < 0 + var_426_0 and not isNil(arg_423_1.actors_["1097ui_story"]) then
				if arg_423_1.var_.characterEffect1097ui_story and not isNil(arg_423_1.actors_["1097ui_story"]) then
					arg_423_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_423_1.time_ >= 0 + var_426_0 and arg_423_1.time_ < 0 + var_426_0 + arg_426_0 and not isNil(arg_423_1.actors_["1097ui_story"]) and arg_423_1.var_.characterEffect1097ui_story then
				arg_423_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_423_1.time_ and arg_423_1.time_ <= 0 + arg_426_0 then
				arg_423_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			if 0 < arg_423_1.time_ and arg_423_1.time_ <= 0 + arg_426_0 then
				arg_423_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_426_2 = arg_423_1.actors_["3043ui_story"]

			if 0 < arg_423_1.time_ and arg_423_1.time_ <= 0 + arg_426_0 and not isNil(var_426_2) and arg_423_1.var_.characterEffect3043ui_story == nil then
				arg_423_1.var_.characterEffect3043ui_story = var_426_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_426_3 = 0.200000002980232

			if 0 <= arg_423_1.time_ and arg_423_1.time_ < 0 + var_426_3 and not isNil(var_426_2) then
				if arg_423_1.var_.characterEffect3043ui_story and not isNil(var_426_2) then
					arg_423_1.var_.characterEffect3043ui_story.fillFlat = true
					arg_423_1.var_.characterEffect3043ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_423_1.time_ - 0) / var_426_3)
				end
			end

			if arg_423_1.time_ >= 0 + var_426_3 and arg_423_1.time_ < 0 + var_426_3 + arg_426_0 and not isNil(var_426_2) and arg_423_1.var_.characterEffect3043ui_story then
				arg_423_1.var_.characterEffect3043ui_story.fillFlat = true
				arg_423_1.var_.characterEffect3043ui_story.fillRatio = 0.5
			end

			local var_426_4 = 0
			local var_426_5 = 0.3

			if 0 < arg_423_1.time_ and arg_423_1.time_ <= var_426_4 + arg_426_0 then
				arg_423_1.talkMaxDuration = 0
				arg_423_1.dialogCg_.alpha = 1

				arg_423_1.dialog_:SetActive(true)
				SetActive(arg_423_1.leftNameGo_, true)

				arg_423_1.leftNameTxt_.text = arg_423_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_423_1.leftNameTxt_.transform)

				arg_423_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_423_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_423_1:RecordName(arg_423_1.leftNameTxt_.text)
				SetActive(arg_423_1.iconTrs_.gameObject, false)
				arg_423_1.callingController_:SetSelectedState("normal")

				local var_426_6 = arg_423_1:GetWordFromCfg(412031101)
				local var_426_7 = arg_423_1:FormatText(var_426_6.content)

				arg_423_1.text_.text = var_426_7

				LuaForUtil.ClearLinePrefixSymbol(arg_423_1.text_)

				local var_426_9 = 12 <= 0 and var_426_5 or var_426_5 * (utf8.len(var_426_7) / 12)

				if (12 <= 0 and var_426_5 or var_426_5 * (utf8.len(var_426_7) / 12)) > 0 and var_426_5 < var_426_9 then
					arg_423_1.talkMaxDuration = var_426_9

					if var_426_9 + var_426_4 > arg_423_1.duration_ then
						arg_423_1.duration_ = var_426_9 + var_426_4
					end
				end

				arg_423_1.text_.text = var_426_7
				arg_423_1.typewritter.percent = 0

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031101", "story_v_out_412031.awb") ~= 0 then
					local var_426_10 = manager.audio:GetVoiceLength("story_v_out_412031", "412031101", "story_v_out_412031.awb") / 1000

					if var_426_10 + var_426_4 > arg_423_1.duration_ then
						arg_423_1.duration_ = var_426_10 + var_426_4
					end

					if var_426_6.prefab_name ~= "" and arg_423_1.actors_[var_426_6.prefab_name] ~= nil then
						local var_426_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_423_1.actors_[var_426_6.prefab_name].transform, "story_v_out_412031", "412031101", "story_v_out_412031.awb")

						arg_423_1:RecordAudio("412031101", var_426_11)
						arg_423_1:RecordAudio("412031101", var_426_11)
					else
						arg_423_1:AudioAction("play", "voice", "story_v_out_412031", "412031101", "story_v_out_412031.awb")
					end

					arg_423_1:RecordHistoryTalkVoice("story_v_out_412031", "412031101", "story_v_out_412031.awb")
				end

				arg_423_1:RecordContent(arg_423_1.text_.text)
			end

			local var_426_12 = math.max(var_426_5, arg_423_1.talkMaxDuration)

			if var_426_4 <= arg_423_1.time_ and arg_423_1.time_ < var_426_4 + var_426_12 then
				arg_423_1.typewritter.percent = (arg_423_1.time_ - var_426_4) / var_426_12

				arg_423_1.typewritter:SetDirty()
			end

			if arg_423_1.time_ >= var_426_4 + var_426_12 and arg_423_1.time_ < var_426_4 + var_426_12 + arg_426_0 then
				arg_423_1.typewritter.percent = 1

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(true)
			end
		end

		arg_423_1.nodeConfigList_ = {}

		arg_423_1:InitPlayNodeList()
	end,
	Play412031102 = function(arg_427_0, arg_427_1)
		arg_427_1.time_ = 0
		arg_427_1.frameCnt_ = 0
		arg_427_1.state_ = "playing"
		arg_427_1.curTalkId_ = 412031102
		arg_427_1.duration_ = 2.93

		local var_427_0 = {
			zh = 1.999999999999,
			ja = 2.933
		}
		local var_427_1 = manager.audio:GetLocalizationFlag()

		if var_427_0[var_427_1] ~= nil then
			arg_427_1.duration_ = var_427_0[var_427_1]
		end

		SetActive(arg_427_1.tipsGo_, false)

		function arg_427_1.onSingleLineFinish_()
			arg_427_1.onSingleLineUpdate_ = nil
			arg_427_1.onSingleLineFinish_ = nil
			arg_427_1.state_ = "waiting"
		end

		function arg_427_1.playNext_(arg_429_0)
			if arg_429_0 == 1 then
				arg_427_0:Play412031103(arg_427_1)
			end
		end

		function arg_427_1.onSingleLineUpdate_(arg_430_0)
			if 0 < arg_427_1.time_ and arg_427_1.time_ <= 0 + arg_430_0 and not isNil(arg_427_1.actors_["3043ui_story"]) and arg_427_1.var_.characterEffect3043ui_story == nil then
				arg_427_1.var_.characterEffect3043ui_story = arg_427_1.actors_["3043ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_430_0 = 0.200000002980232

			if 0 <= arg_427_1.time_ and arg_427_1.time_ < 0 + var_430_0 and not isNil(arg_427_1.actors_["3043ui_story"]) then
				if arg_427_1.var_.characterEffect3043ui_story and not isNil(arg_427_1.actors_["3043ui_story"]) then
					arg_427_1.var_.characterEffect3043ui_story.fillFlat = false
				end
			end

			if arg_427_1.time_ >= 0 + var_430_0 and arg_427_1.time_ < 0 + var_430_0 + arg_430_0 and not isNil(arg_427_1.actors_["3043ui_story"]) and arg_427_1.var_.characterEffect3043ui_story then
				arg_427_1.var_.characterEffect3043ui_story.fillFlat = false
			end

			if 0 < arg_427_1.time_ and arg_427_1.time_ <= 0 + arg_430_0 then
				arg_427_1:PlayTimeline("3043ui_story", "StoryTimeline/CharAction/story3043/story3043action/3043action1_1")
			end

			if 0 < arg_427_1.time_ and arg_427_1.time_ <= 0 + arg_430_0 then
				arg_427_1:PlayTimeline("3043ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_430_2 = arg_427_1.actors_["1097ui_story"]

			if 0 < arg_427_1.time_ and arg_427_1.time_ <= 0 + arg_430_0 and not isNil(var_430_2) and arg_427_1.var_.characterEffect1097ui_story == nil then
				arg_427_1.var_.characterEffect1097ui_story = var_430_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_430_3 = 0.200000002980232

			if 0 <= arg_427_1.time_ and arg_427_1.time_ < 0 + var_430_3 and not isNil(var_430_2) then
				if arg_427_1.var_.characterEffect1097ui_story and not isNil(var_430_2) then
					arg_427_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_427_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_427_1.time_ - 0) / var_430_3)
				end
			end

			if arg_427_1.time_ >= 0 + var_430_3 and arg_427_1.time_ < 0 + var_430_3 + arg_430_0 and not isNil(var_430_2) and arg_427_1.var_.characterEffect1097ui_story then
				arg_427_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_427_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_430_4 = 0
			local var_430_5 = 0.125

			if 0 < arg_427_1.time_ and arg_427_1.time_ <= var_430_4 + arg_430_0 then
				arg_427_1.talkMaxDuration = 0
				arg_427_1.dialogCg_.alpha = 1

				arg_427_1.dialog_:SetActive(true)
				SetActive(arg_427_1.leftNameGo_, true)

				arg_427_1.leftNameTxt_.text = arg_427_1:FormatText(StoryNameCfg[920].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_427_1.leftNameTxt_.transform)

				arg_427_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_427_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_427_1:RecordName(arg_427_1.leftNameTxt_.text)
				SetActive(arg_427_1.iconTrs_.gameObject, false)
				arg_427_1.callingController_:SetSelectedState("normal")

				local var_430_6 = arg_427_1:GetWordFromCfg(412031102)
				local var_430_7 = arg_427_1:FormatText(var_430_6.content)

				arg_427_1.text_.text = var_430_7

				LuaForUtil.ClearLinePrefixSymbol(arg_427_1.text_)

				local var_430_9 = 5 <= 0 and var_430_5 or var_430_5 * (utf8.len(var_430_7) / 5)

				if (5 <= 0 and var_430_5 or var_430_5 * (utf8.len(var_430_7) / 5)) > 0 and var_430_5 < var_430_9 then
					arg_427_1.talkMaxDuration = var_430_9

					if var_430_9 + var_430_4 > arg_427_1.duration_ then
						arg_427_1.duration_ = var_430_9 + var_430_4
					end
				end

				arg_427_1.text_.text = var_430_7
				arg_427_1.typewritter.percent = 0

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031102", "story_v_out_412031.awb") ~= 0 then
					local var_430_10 = manager.audio:GetVoiceLength("story_v_out_412031", "412031102", "story_v_out_412031.awb") / 1000

					if var_430_10 + var_430_4 > arg_427_1.duration_ then
						arg_427_1.duration_ = var_430_10 + var_430_4
					end

					if var_430_6.prefab_name ~= "" and arg_427_1.actors_[var_430_6.prefab_name] ~= nil then
						local var_430_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_427_1.actors_[var_430_6.prefab_name].transform, "story_v_out_412031", "412031102", "story_v_out_412031.awb")

						arg_427_1:RecordAudio("412031102", var_430_11)
						arg_427_1:RecordAudio("412031102", var_430_11)
					else
						arg_427_1:AudioAction("play", "voice", "story_v_out_412031", "412031102", "story_v_out_412031.awb")
					end

					arg_427_1:RecordHistoryTalkVoice("story_v_out_412031", "412031102", "story_v_out_412031.awb")
				end

				arg_427_1:RecordContent(arg_427_1.text_.text)
			end

			local var_430_12 = math.max(var_430_5, arg_427_1.talkMaxDuration)

			if var_430_4 <= arg_427_1.time_ and arg_427_1.time_ < var_430_4 + var_430_12 then
				arg_427_1.typewritter.percent = (arg_427_1.time_ - var_430_4) / var_430_12

				arg_427_1.typewritter:SetDirty()
			end

			if arg_427_1.time_ >= var_430_4 + var_430_12 and arg_427_1.time_ < var_430_4 + var_430_12 + arg_430_0 then
				arg_427_1.typewritter.percent = 1

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(true)
			end
		end

		arg_427_1.nodeConfigList_ = {}

		arg_427_1:InitPlayNodeList()
	end,
	Play412031103 = function(arg_431_0, arg_431_1)
		arg_431_1.time_ = 0
		arg_431_1.frameCnt_ = 0
		arg_431_1.state_ = "playing"
		arg_431_1.curTalkId_ = 412031103
		arg_431_1.duration_ = 4.13

		local var_431_0 = {
			zh = 4.133,
			ja = 1.999999999999
		}
		local var_431_1 = manager.audio:GetLocalizationFlag()

		if var_431_0[var_431_1] ~= nil then
			arg_431_1.duration_ = var_431_0[var_431_1]
		end

		SetActive(arg_431_1.tipsGo_, false)

		function arg_431_1.onSingleLineFinish_()
			arg_431_1.onSingleLineUpdate_ = nil
			arg_431_1.onSingleLineFinish_ = nil
			arg_431_1.state_ = "waiting"
		end

		function arg_431_1.playNext_(arg_433_0)
			if arg_433_0 == 1 then
				arg_431_0:Play412031104(arg_431_1)
			end
		end

		function arg_431_1.onSingleLineUpdate_(arg_434_0)
			if 0 < arg_431_1.time_ and arg_431_1.time_ <= 0 + arg_434_0 and not isNil(arg_431_1.actors_["1097ui_story"]) and arg_431_1.var_.characterEffect1097ui_story == nil then
				arg_431_1.var_.characterEffect1097ui_story = arg_431_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_434_0 = 0.200000002980232

			if 0 <= arg_431_1.time_ and arg_431_1.time_ < 0 + var_434_0 and not isNil(arg_431_1.actors_["1097ui_story"]) then
				if arg_431_1.var_.characterEffect1097ui_story and not isNil(arg_431_1.actors_["1097ui_story"]) then
					arg_431_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_431_1.time_ >= 0 + var_434_0 and arg_431_1.time_ < 0 + var_434_0 + arg_434_0 and not isNil(arg_431_1.actors_["1097ui_story"]) and arg_431_1.var_.characterEffect1097ui_story then
				arg_431_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_431_1.time_ and arg_431_1.time_ <= 0 + arg_434_0 then
				arg_431_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action7_1")
			end

			if 0 < arg_431_1.time_ and arg_431_1.time_ <= 0 + arg_434_0 then
				arg_431_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_434_2 = arg_431_1.actors_["3043ui_story"]

			if 0 < arg_431_1.time_ and arg_431_1.time_ <= 0 + arg_434_0 and not isNil(var_434_2) and arg_431_1.var_.characterEffect3043ui_story == nil then
				arg_431_1.var_.characterEffect3043ui_story = var_434_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_434_3 = 0.200000002980232

			if 0 <= arg_431_1.time_ and arg_431_1.time_ < 0 + var_434_3 and not isNil(var_434_2) then
				if arg_431_1.var_.characterEffect3043ui_story and not isNil(var_434_2) then
					arg_431_1.var_.characterEffect3043ui_story.fillFlat = true
					arg_431_1.var_.characterEffect3043ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_431_1.time_ - 0) / var_434_3)
				end
			end

			if arg_431_1.time_ >= 0 + var_434_3 and arg_431_1.time_ < 0 + var_434_3 + arg_434_0 and not isNil(var_434_2) and arg_431_1.var_.characterEffect3043ui_story then
				arg_431_1.var_.characterEffect3043ui_story.fillFlat = true
				arg_431_1.var_.characterEffect3043ui_story.fillRatio = 0.5
			end

			local var_434_4 = 0
			local var_434_5 = 0.325

			if 0 < arg_431_1.time_ and arg_431_1.time_ <= var_434_4 + arg_434_0 then
				arg_431_1.talkMaxDuration = 0
				arg_431_1.dialogCg_.alpha = 1

				arg_431_1.dialog_:SetActive(true)
				SetActive(arg_431_1.leftNameGo_, true)

				arg_431_1.leftNameTxt_.text = arg_431_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_431_1.leftNameTxt_.transform)

				arg_431_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_431_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_431_1:RecordName(arg_431_1.leftNameTxt_.text)
				SetActive(arg_431_1.iconTrs_.gameObject, false)
				arg_431_1.callingController_:SetSelectedState("normal")

				local var_434_6 = arg_431_1:GetWordFromCfg(412031103)
				local var_434_7 = arg_431_1:FormatText(var_434_6.content)

				arg_431_1.text_.text = var_434_7

				LuaForUtil.ClearLinePrefixSymbol(arg_431_1.text_)

				local var_434_9 = 13 <= 0 and var_434_5 or var_434_5 * (utf8.len(var_434_7) / 13)

				if (13 <= 0 and var_434_5 or var_434_5 * (utf8.len(var_434_7) / 13)) > 0 and var_434_5 < var_434_9 then
					arg_431_1.talkMaxDuration = var_434_9

					if var_434_9 + var_434_4 > arg_431_1.duration_ then
						arg_431_1.duration_ = var_434_9 + var_434_4
					end
				end

				arg_431_1.text_.text = var_434_7
				arg_431_1.typewritter.percent = 0

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031103", "story_v_out_412031.awb") ~= 0 then
					local var_434_10 = manager.audio:GetVoiceLength("story_v_out_412031", "412031103", "story_v_out_412031.awb") / 1000

					if var_434_10 + var_434_4 > arg_431_1.duration_ then
						arg_431_1.duration_ = var_434_10 + var_434_4
					end

					if var_434_6.prefab_name ~= "" and arg_431_1.actors_[var_434_6.prefab_name] ~= nil then
						local var_434_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_431_1.actors_[var_434_6.prefab_name].transform, "story_v_out_412031", "412031103", "story_v_out_412031.awb")

						arg_431_1:RecordAudio("412031103", var_434_11)
						arg_431_1:RecordAudio("412031103", var_434_11)
					else
						arg_431_1:AudioAction("play", "voice", "story_v_out_412031", "412031103", "story_v_out_412031.awb")
					end

					arg_431_1:RecordHistoryTalkVoice("story_v_out_412031", "412031103", "story_v_out_412031.awb")
				end

				arg_431_1:RecordContent(arg_431_1.text_.text)
			end

			local var_434_12 = math.max(var_434_5, arg_431_1.talkMaxDuration)

			if var_434_4 <= arg_431_1.time_ and arg_431_1.time_ < var_434_4 + var_434_12 then
				arg_431_1.typewritter.percent = (arg_431_1.time_ - var_434_4) / var_434_12

				arg_431_1.typewritter:SetDirty()
			end

			if arg_431_1.time_ >= var_434_4 + var_434_12 and arg_431_1.time_ < var_434_4 + var_434_12 + arg_434_0 then
				arg_431_1.typewritter.percent = 1

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(true)
			end
		end

		arg_431_1.nodeConfigList_ = {}

		arg_431_1:InitPlayNodeList()
	end,
	Play412031104 = function(arg_435_0, arg_435_1)
		arg_435_1.time_ = 0
		arg_435_1.frameCnt_ = 0
		arg_435_1.state_ = "playing"
		arg_435_1.curTalkId_ = 412031104
		arg_435_1.duration_ = 5

		SetActive(arg_435_1.tipsGo_, false)

		function arg_435_1.onSingleLineFinish_()
			arg_435_1.onSingleLineUpdate_ = nil
			arg_435_1.onSingleLineFinish_ = nil
			arg_435_1.state_ = "waiting"
		end

		function arg_435_1.playNext_(arg_437_0)
			if arg_437_0 == 1 then
				arg_435_0:Play412031105(arg_435_1)
			end
		end

		function arg_435_1.onSingleLineUpdate_(arg_438_0)
			if 0 < arg_435_1.time_ and arg_435_1.time_ <= 0 + arg_438_0 then
				arg_435_1.var_.moveOldPos1097ui_story = arg_435_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_438_0 = 0.001

			if 0 <= arg_435_1.time_ and arg_435_1.time_ < 0 + var_438_0 then
				arg_435_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_435_1.var_.moveOldPos1097ui_story, Vector3.New(0, 100, 0), (arg_435_1.time_ - 0) / var_438_0)
				arg_435_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_435_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_435_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_435_1.actors_["1097ui_story"].transform.position).z)
				arg_435_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_435_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_435_1.actors_["1097ui_story"].transform.localEulerAngles = arg_435_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_435_1.time_ >= 0 + var_438_0 and arg_435_1.time_ < 0 + var_438_0 + arg_438_0 then
				arg_435_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_435_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_435_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_435_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_435_1.actors_["1097ui_story"].transform.position).z)
				arg_435_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_435_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_435_1.actors_["1097ui_story"].transform.localEulerAngles = arg_435_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_438_1 = arg_435_1.actors_["1097ui_story"]

			if 0 < arg_435_1.time_ and arg_435_1.time_ <= 0 + arg_438_0 and not isNil(var_438_1) and arg_435_1.var_.characterEffect1097ui_story == nil then
				arg_435_1.var_.characterEffect1097ui_story = var_438_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_438_2 = 0.034000001847744

			if 0 <= arg_435_1.time_ and arg_435_1.time_ < 0 + var_438_2 and not isNil(var_438_1) then
				if arg_435_1.var_.characterEffect1097ui_story and not isNil(var_438_1) then
					arg_435_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_435_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_435_1.time_ - 0) / var_438_2)
				end
			end

			if arg_435_1.time_ >= 0 + var_438_2 and arg_435_1.time_ < 0 + var_438_2 + arg_438_0 and not isNil(var_438_1) and arg_435_1.var_.characterEffect1097ui_story then
				arg_435_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_435_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_438_3 = arg_435_1.actors_["3043ui_story"].transform

			if 0 < arg_435_1.time_ and arg_435_1.time_ <= 0 + arg_438_0 then
				arg_435_1.var_.moveOldPos3043ui_story = var_438_3.localPosition
			end

			local var_438_4 = 0.001

			if 0 <= arg_435_1.time_ and arg_435_1.time_ < 0 + var_438_4 then
				var_438_3.localPosition = Vector3.Lerp(arg_435_1.var_.moveOldPos3043ui_story, Vector3.New(0, 100, 0), (arg_435_1.time_ - 0) / var_438_4)
				var_438_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_438_3.position).x, (manager.ui.mainCamera.transform.position - var_438_3.position).y, (manager.ui.mainCamera.transform.position - var_438_3.position).z)
				var_438_3.localEulerAngles.z = 0
				var_438_3.localEulerAngles.x = 0
				var_438_3.localEulerAngles = var_438_3.localEulerAngles
			end

			if arg_435_1.time_ >= 0 + var_438_4 and arg_435_1.time_ < 0 + var_438_4 + arg_438_0 then
				var_438_3.localPosition = Vector3.New(0, 100, 0)
				var_438_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_438_3.position).x, (manager.ui.mainCamera.transform.position - var_438_3.position).y, (manager.ui.mainCamera.transform.position - var_438_3.position).z)
				var_438_3.localEulerAngles.z = 0
				var_438_3.localEulerAngles.x = 0
				var_438_3.localEulerAngles = var_438_3.localEulerAngles
			end

			local var_438_5 = arg_435_1.actors_["3043ui_story"]

			if 0 < arg_435_1.time_ and arg_435_1.time_ <= 0 + arg_438_0 and not isNil(var_438_5) and arg_435_1.var_.characterEffect3043ui_story == nil then
				arg_435_1.var_.characterEffect3043ui_story = var_438_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_438_6 = 0.034000001847744

			if 0 <= arg_435_1.time_ and arg_435_1.time_ < 0 + var_438_6 and not isNil(var_438_5) then
				if arg_435_1.var_.characterEffect3043ui_story and not isNil(var_438_5) then
					arg_435_1.var_.characterEffect3043ui_story.fillFlat = true
					arg_435_1.var_.characterEffect3043ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_435_1.time_ - 0) / var_438_6)
				end
			end

			if arg_435_1.time_ >= 0 + var_438_6 and arg_435_1.time_ < 0 + var_438_6 + arg_438_0 and not isNil(var_438_5) and arg_435_1.var_.characterEffect3043ui_story then
				arg_435_1.var_.characterEffect3043ui_story.fillFlat = true
				arg_435_1.var_.characterEffect3043ui_story.fillRatio = 0.5
			end

			local var_438_7 = 0
			local var_438_8 = 0.15

			if 0 < arg_435_1.time_ and arg_435_1.time_ <= var_438_7 + arg_438_0 then
				arg_435_1.talkMaxDuration = 0
				arg_435_1.dialogCg_.alpha = 1

				arg_435_1.dialog_:SetActive(true)
				SetActive(arg_435_1.leftNameGo_, false)

				arg_435_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_435_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_435_1:RecordName(arg_435_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_435_1.iconTrs_.gameObject, false)
				arg_435_1.callingController_:SetSelectedState("normal")

				local var_438_9 = arg_435_1:FormatText(arg_435_1:GetWordFromCfg(412031104).content)

				arg_435_1.text_.text = var_438_9

				LuaForUtil.ClearLinePrefixSymbol(arg_435_1.text_)

				local var_438_11 = 6 <= 0 and var_438_8 or var_438_8 * (utf8.len(var_438_9) / 6)

				if (6 <= 0 and var_438_8 or var_438_8 * (utf8.len(var_438_9) / 6)) > 0 and var_438_8 < var_438_11 then
					arg_435_1.talkMaxDuration = var_438_11

					if var_438_11 + var_438_7 > arg_435_1.duration_ then
						arg_435_1.duration_ = var_438_11 + var_438_7
					end
				end

				arg_435_1.text_.text = var_438_9
				arg_435_1.typewritter.percent = 0

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(false)
				arg_435_1:RecordContent(arg_435_1.text_.text)
			end

			local var_438_12 = math.max(var_438_8, arg_435_1.talkMaxDuration)

			if var_438_7 <= arg_435_1.time_ and arg_435_1.time_ < var_438_7 + var_438_12 then
				arg_435_1.typewritter.percent = (arg_435_1.time_ - var_438_7) / var_438_12

				arg_435_1.typewritter:SetDirty()
			end

			if arg_435_1.time_ >= var_438_7 + var_438_12 and arg_435_1.time_ < var_438_7 + var_438_12 + arg_438_0 then
				arg_435_1.typewritter.percent = 1

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(true)
			end
		end

		arg_435_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "3043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_435_1:InitPlayNodeList()
	end,
	Play412031105 = function(arg_439_0, arg_439_1)
		arg_439_1.time_ = 0
		arg_439_1.frameCnt_ = 0
		arg_439_1.state_ = "playing"
		arg_439_1.curTalkId_ = 412031105
		arg_439_1.duration_ = 2

		SetActive(arg_439_1.tipsGo_, false)

		function arg_439_1.onSingleLineFinish_()
			arg_439_1.onSingleLineUpdate_ = nil
			arg_439_1.onSingleLineFinish_ = nil
			arg_439_1.state_ = "waiting"
		end

		function arg_439_1.playNext_(arg_441_0)
			if arg_441_0 == 1 then
				arg_439_0:Play412031106(arg_439_1)
			end
		end

		function arg_439_1.onSingleLineUpdate_(arg_442_0)
			if 0 < arg_439_1.time_ and arg_439_1.time_ <= 0 + arg_442_0 then
				arg_439_1.var_.moveOldPos1097ui_story = arg_439_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_442_0 = 0.001

			if 0 <= arg_439_1.time_ and arg_439_1.time_ < 0 + var_442_0 then
				arg_439_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_439_1.var_.moveOldPos1097ui_story, Vector3.New(-0.7, -0.54, -6.3), (arg_439_1.time_ - 0) / var_442_0)
				arg_439_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_439_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_439_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_439_1.actors_["1097ui_story"].transform.position).z)
				arg_439_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_439_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_439_1.actors_["1097ui_story"].transform.localEulerAngles = arg_439_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_439_1.time_ >= 0 + var_442_0 and arg_439_1.time_ < 0 + var_442_0 + arg_442_0 then
				arg_439_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(-0.7, -0.54, -6.3)
				arg_439_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_439_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_439_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_439_1.actors_["1097ui_story"].transform.position).z)
				arg_439_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_439_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_439_1.actors_["1097ui_story"].transform.localEulerAngles = arg_439_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_442_1 = arg_439_1.actors_["1097ui_story"]

			if 0 < arg_439_1.time_ and arg_439_1.time_ <= 0 + arg_442_0 and not isNil(var_442_1) and arg_439_1.var_.characterEffect1097ui_story == nil then
				arg_439_1.var_.characterEffect1097ui_story = var_442_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_442_2 = 0.200000002980232

			if 0 <= arg_439_1.time_ and arg_439_1.time_ < 0 + var_442_2 and not isNil(var_442_1) then
				if arg_439_1.var_.characterEffect1097ui_story and not isNil(var_442_1) then
					arg_439_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_439_1.time_ >= 0 + var_442_2 and arg_439_1.time_ < 0 + var_442_2 + arg_442_0 and not isNil(var_442_1) and arg_439_1.var_.characterEffect1097ui_story then
				arg_439_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_439_1.time_ and arg_439_1.time_ <= 0 + arg_442_0 then
				arg_439_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action7_2")
			end

			if 0 < arg_439_1.time_ and arg_439_1.time_ <= 0 + arg_442_0 then
				arg_439_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_442_4 = 0
			local var_442_5 = 0.1

			if 0 < arg_439_1.time_ and arg_439_1.time_ <= var_442_4 + arg_442_0 then
				arg_439_1.talkMaxDuration = 0
				arg_439_1.dialogCg_.alpha = 1

				arg_439_1.dialog_:SetActive(true)
				SetActive(arg_439_1.leftNameGo_, true)

				arg_439_1.leftNameTxt_.text = arg_439_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_439_1.leftNameTxt_.transform)

				arg_439_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_439_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_439_1:RecordName(arg_439_1.leftNameTxt_.text)
				SetActive(arg_439_1.iconTrs_.gameObject, false)
				arg_439_1.callingController_:SetSelectedState("normal")

				local var_442_6 = arg_439_1:GetWordFromCfg(412031105)
				local var_442_7 = arg_439_1:FormatText(var_442_6.content)

				arg_439_1.text_.text = var_442_7

				LuaForUtil.ClearLinePrefixSymbol(arg_439_1.text_)

				local var_442_9 = 4 <= 0 and var_442_5 or var_442_5 * (utf8.len(var_442_7) / 4)

				if (4 <= 0 and var_442_5 or var_442_5 * (utf8.len(var_442_7) / 4)) > 0 and var_442_5 < var_442_9 then
					arg_439_1.talkMaxDuration = var_442_9

					if var_442_9 + var_442_4 > arg_439_1.duration_ then
						arg_439_1.duration_ = var_442_9 + var_442_4
					end
				end

				arg_439_1.text_.text = var_442_7
				arg_439_1.typewritter.percent = 0

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031105", "story_v_out_412031.awb") ~= 0 then
					local var_442_10 = manager.audio:GetVoiceLength("story_v_out_412031", "412031105", "story_v_out_412031.awb") / 1000

					if var_442_10 + var_442_4 > arg_439_1.duration_ then
						arg_439_1.duration_ = var_442_10 + var_442_4
					end

					if var_442_6.prefab_name ~= "" and arg_439_1.actors_[var_442_6.prefab_name] ~= nil then
						local var_442_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_439_1.actors_[var_442_6.prefab_name].transform, "story_v_out_412031", "412031105", "story_v_out_412031.awb")

						arg_439_1:RecordAudio("412031105", var_442_11)
						arg_439_1:RecordAudio("412031105", var_442_11)
					else
						arg_439_1:AudioAction("play", "voice", "story_v_out_412031", "412031105", "story_v_out_412031.awb")
					end

					arg_439_1:RecordHistoryTalkVoice("story_v_out_412031", "412031105", "story_v_out_412031.awb")
				end

				arg_439_1:RecordContent(arg_439_1.text_.text)
			end

			local var_442_12 = math.max(var_442_5, arg_439_1.talkMaxDuration)

			if var_442_4 <= arg_439_1.time_ and arg_439_1.time_ < var_442_4 + var_442_12 then
				arg_439_1.typewritter.percent = (arg_439_1.time_ - var_442_4) / var_442_12

				arg_439_1.typewritter:SetDirty()
			end

			if arg_439_1.time_ >= var_442_4 + var_442_12 and arg_439_1.time_ < var_442_4 + var_442_12 + arg_442_0 then
				arg_439_1.typewritter.percent = 1

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(true)
			end
		end

		arg_439_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_439_1:InitPlayNodeList()
	end,
	Play412031106 = function(arg_443_0, arg_443_1)
		arg_443_1.time_ = 0
		arg_443_1.frameCnt_ = 0
		arg_443_1.state_ = "playing"
		arg_443_1.curTalkId_ = 412031106
		arg_443_1.duration_ = 6.5

		local var_443_0 = {
			zh = 5.966,
			ja = 6.5
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
				arg_443_0:Play412031107(arg_443_1)
			end
		end

		function arg_443_1.onSingleLineUpdate_(arg_446_0)
			if 0 < arg_443_1.time_ and arg_443_1.time_ <= 0 + arg_446_0 then
				arg_443_1.var_.moveOldPos3043ui_story = arg_443_1.actors_["3043ui_story"].transform.localPosition
			end

			local var_446_0 = 0.001

			if 0 <= arg_443_1.time_ and arg_443_1.time_ < 0 + var_446_0 then
				arg_443_1.actors_["3043ui_story"].transform.localPosition = Vector3.Lerp(arg_443_1.var_.moveOldPos3043ui_story, Vector3.New(0.7, -1.41, -5.7), (arg_443_1.time_ - 0) / var_446_0)
				arg_443_1.actors_["3043ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_443_1.actors_["3043ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_443_1.actors_["3043ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_443_1.actors_["3043ui_story"].transform.position).z)
				arg_443_1.actors_["3043ui_story"].transform.localEulerAngles.z = 0
				arg_443_1.actors_["3043ui_story"].transform.localEulerAngles.x = 0
				arg_443_1.actors_["3043ui_story"].transform.localEulerAngles = arg_443_1.actors_["3043ui_story"].transform.localEulerAngles
			end

			if arg_443_1.time_ >= 0 + var_446_0 and arg_443_1.time_ < 0 + var_446_0 + arg_446_0 then
				arg_443_1.actors_["3043ui_story"].transform.localPosition = Vector3.New(0.7, -1.41, -5.7)
				arg_443_1.actors_["3043ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_443_1.actors_["3043ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_443_1.actors_["3043ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_443_1.actors_["3043ui_story"].transform.position).z)
				arg_443_1.actors_["3043ui_story"].transform.localEulerAngles.z = 0
				arg_443_1.actors_["3043ui_story"].transform.localEulerAngles.x = 0
				arg_443_1.actors_["3043ui_story"].transform.localEulerAngles = arg_443_1.actors_["3043ui_story"].transform.localEulerAngles
			end

			local var_446_1 = arg_443_1.actors_["3043ui_story"]

			if 0 < arg_443_1.time_ and arg_443_1.time_ <= 0 + arg_446_0 and not isNil(var_446_1) and arg_443_1.var_.characterEffect3043ui_story == nil then
				arg_443_1.var_.characterEffect3043ui_story = var_446_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_446_2 = 0.200000002980232

			if 0 <= arg_443_1.time_ and arg_443_1.time_ < 0 + var_446_2 and not isNil(var_446_1) then
				if arg_443_1.var_.characterEffect3043ui_story and not isNil(var_446_1) then
					arg_443_1.var_.characterEffect3043ui_story.fillFlat = false
				end
			end

			if arg_443_1.time_ >= 0 + var_446_2 and arg_443_1.time_ < 0 + var_446_2 + arg_446_0 and not isNil(var_446_1) and arg_443_1.var_.characterEffect3043ui_story then
				arg_443_1.var_.characterEffect3043ui_story.fillFlat = false
			end

			if 0 < arg_443_1.time_ and arg_443_1.time_ <= 0 + arg_446_0 then
				arg_443_1:PlayTimeline("3043ui_story", "StoryTimeline/CharAction/story3043/story3043action/3043action1_1")
			end

			if 0 < arg_443_1.time_ and arg_443_1.time_ <= 0 + arg_446_0 then
				arg_443_1:PlayTimeline("3043ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_446_4 = arg_443_1.actors_["1097ui_story"]

			if 0 < arg_443_1.time_ and arg_443_1.time_ <= 0 + arg_446_0 and not isNil(var_446_4) and arg_443_1.var_.characterEffect1097ui_story == nil then
				arg_443_1.var_.characterEffect1097ui_story = var_446_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_446_5 = 0.200000002980232

			if 0 <= arg_443_1.time_ and arg_443_1.time_ < 0 + var_446_5 and not isNil(var_446_4) then
				if arg_443_1.var_.characterEffect1097ui_story and not isNil(var_446_4) then
					arg_443_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_443_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_443_1.time_ - 0) / var_446_5)
				end
			end

			if arg_443_1.time_ >= 0 + var_446_5 and arg_443_1.time_ < 0 + var_446_5 + arg_446_0 and not isNil(var_446_4) and arg_443_1.var_.characterEffect1097ui_story then
				arg_443_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_443_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_446_6 = 0
			local var_446_7 = 0.625

			if 0 < arg_443_1.time_ and arg_443_1.time_ <= var_446_6 + arg_446_0 then
				arg_443_1.talkMaxDuration = 0
				arg_443_1.dialogCg_.alpha = 1

				arg_443_1.dialog_:SetActive(true)
				SetActive(arg_443_1.leftNameGo_, true)

				arg_443_1.leftNameTxt_.text = arg_443_1:FormatText(StoryNameCfg[920].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_443_1.leftNameTxt_.transform)

				arg_443_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_443_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_443_1:RecordName(arg_443_1.leftNameTxt_.text)
				SetActive(arg_443_1.iconTrs_.gameObject, false)
				arg_443_1.callingController_:SetSelectedState("normal")

				local var_446_8 = arg_443_1:GetWordFromCfg(412031106)
				local var_446_9 = arg_443_1:FormatText(var_446_8.content)

				arg_443_1.text_.text = var_446_9

				LuaForUtil.ClearLinePrefixSymbol(arg_443_1.text_)

				local var_446_11 = 25 <= 0 and var_446_7 or var_446_7 * (utf8.len(var_446_9) / 25)

				if (25 <= 0 and var_446_7 or var_446_7 * (utf8.len(var_446_9) / 25)) > 0 and var_446_7 < var_446_11 then
					arg_443_1.talkMaxDuration = var_446_11

					if var_446_11 + var_446_6 > arg_443_1.duration_ then
						arg_443_1.duration_ = var_446_11 + var_446_6
					end
				end

				arg_443_1.text_.text = var_446_9
				arg_443_1.typewritter.percent = 0

				arg_443_1.typewritter:SetDirty()
				arg_443_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031106", "story_v_out_412031.awb") ~= 0 then
					local var_446_12 = manager.audio:GetVoiceLength("story_v_out_412031", "412031106", "story_v_out_412031.awb") / 1000

					if var_446_12 + var_446_6 > arg_443_1.duration_ then
						arg_443_1.duration_ = var_446_12 + var_446_6
					end

					if var_446_8.prefab_name ~= "" and arg_443_1.actors_[var_446_8.prefab_name] ~= nil then
						local var_446_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_443_1.actors_[var_446_8.prefab_name].transform, "story_v_out_412031", "412031106", "story_v_out_412031.awb")

						arg_443_1:RecordAudio("412031106", var_446_13)
						arg_443_1:RecordAudio("412031106", var_446_13)
					else
						arg_443_1:AudioAction("play", "voice", "story_v_out_412031", "412031106", "story_v_out_412031.awb")
					end

					arg_443_1:RecordHistoryTalkVoice("story_v_out_412031", "412031106", "story_v_out_412031.awb")
				end

				arg_443_1:RecordContent(arg_443_1.text_.text)
			end

			local var_446_14 = math.max(var_446_7, arg_443_1.talkMaxDuration)

			if var_446_6 <= arg_443_1.time_ and arg_443_1.time_ < var_446_6 + var_446_14 then
				arg_443_1.typewritter.percent = (arg_443_1.time_ - var_446_6) / var_446_14

				arg_443_1.typewritter:SetDirty()
			end

			if arg_443_1.time_ >= var_446_6 + var_446_14 and arg_443_1.time_ < var_446_6 + var_446_14 + arg_446_0 then
				arg_443_1.typewritter.percent = 1

				arg_443_1.typewritter:SetDirty()
				arg_443_1:ShowNextGo(true)
			end
		end

		arg_443_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_443_1:InitPlayNodeList()
	end,
	Play412031107 = function(arg_447_0, arg_447_1)
		arg_447_1.time_ = 0
		arg_447_1.frameCnt_ = 0
		arg_447_1.state_ = "playing"
		arg_447_1.curTalkId_ = 412031107
		arg_447_1.duration_ = 8.6

		local var_447_0 = {
			zh = 8.6,
			ja = 8.4
		}
		local var_447_1 = manager.audio:GetLocalizationFlag()

		if var_447_0[var_447_1] ~= nil then
			arg_447_1.duration_ = var_447_0[var_447_1]
		end

		SetActive(arg_447_1.tipsGo_, false)

		function arg_447_1.onSingleLineFinish_()
			arg_447_1.onSingleLineUpdate_ = nil
			arg_447_1.onSingleLineFinish_ = nil
			arg_447_1.state_ = "waiting"
		end

		function arg_447_1.playNext_(arg_449_0)
			if arg_449_0 == 1 then
				arg_447_0:Play412031108(arg_447_1)
			end
		end

		function arg_447_1.onSingleLineUpdate_(arg_450_0)
			local var_450_0 = 0.8

			if 0 < arg_447_1.time_ and arg_447_1.time_ <= 0 + arg_450_0 then
				arg_447_1.talkMaxDuration = 0
				arg_447_1.dialogCg_.alpha = 1

				arg_447_1.dialog_:SetActive(true)
				SetActive(arg_447_1.leftNameGo_, true)

				arg_447_1.leftNameTxt_.text = arg_447_1:FormatText(StoryNameCfg[920].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_447_1.leftNameTxt_.transform)

				arg_447_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_447_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_447_1:RecordName(arg_447_1.leftNameTxt_.text)
				SetActive(arg_447_1.iconTrs_.gameObject, false)
				arg_447_1.callingController_:SetSelectedState("normal")

				local var_450_1 = arg_447_1:GetWordFromCfg(412031107)
				local var_450_2 = arg_447_1:FormatText(var_450_1.content)

				arg_447_1.text_.text = var_450_2

				LuaForUtil.ClearLinePrefixSymbol(arg_447_1.text_)

				local var_450_4 = 32 <= 0 and var_450_0 or var_450_0 * (utf8.len(var_450_2) / 32)

				if (32 <= 0 and var_450_0 or var_450_0 * (utf8.len(var_450_2) / 32)) > 0 and var_450_0 < var_450_4 then
					arg_447_1.talkMaxDuration = var_450_4

					if var_450_4 + 0 > arg_447_1.duration_ then
						arg_447_1.duration_ = var_450_4 + 0
					end
				end

				arg_447_1.text_.text = var_450_2
				arg_447_1.typewritter.percent = 0

				arg_447_1.typewritter:SetDirty()
				arg_447_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031107", "story_v_out_412031.awb") ~= 0 then
					local var_450_5 = manager.audio:GetVoiceLength("story_v_out_412031", "412031107", "story_v_out_412031.awb") / 1000

					if var_450_5 + 0 > arg_447_1.duration_ then
						arg_447_1.duration_ = var_450_5 + 0
					end

					if var_450_1.prefab_name ~= "" and arg_447_1.actors_[var_450_1.prefab_name] ~= nil then
						local var_450_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_447_1.actors_[var_450_1.prefab_name].transform, "story_v_out_412031", "412031107", "story_v_out_412031.awb")

						arg_447_1:RecordAudio("412031107", var_450_6)
						arg_447_1:RecordAudio("412031107", var_450_6)
					else
						arg_447_1:AudioAction("play", "voice", "story_v_out_412031", "412031107", "story_v_out_412031.awb")
					end

					arg_447_1:RecordHistoryTalkVoice("story_v_out_412031", "412031107", "story_v_out_412031.awb")
				end

				arg_447_1:RecordContent(arg_447_1.text_.text)
			end

			local var_450_7 = math.max(var_450_0, arg_447_1.talkMaxDuration)

			if 0 <= arg_447_1.time_ and arg_447_1.time_ < 0 + var_450_7 then
				arg_447_1.typewritter.percent = (arg_447_1.time_ - 0) / var_450_7

				arg_447_1.typewritter:SetDirty()
			end

			if arg_447_1.time_ >= 0 + var_450_7 and arg_447_1.time_ < 0 + var_450_7 + arg_450_0 then
				arg_447_1.typewritter.percent = 1

				arg_447_1.typewritter:SetDirty()
				arg_447_1:ShowNextGo(true)
			end
		end

		arg_447_1.nodeConfigList_ = {}

		arg_447_1:InitPlayNodeList()
	end,
	Play412031108 = function(arg_451_0, arg_451_1)
		arg_451_1.time_ = 0
		arg_451_1.frameCnt_ = 0
		arg_451_1.state_ = "playing"
		arg_451_1.curTalkId_ = 412031108
		arg_451_1.duration_ = 12.67

		local var_451_0 = {
			zh = 12.666,
			ja = 7.466
		}
		local var_451_1 = manager.audio:GetLocalizationFlag()

		if var_451_0[var_451_1] ~= nil then
			arg_451_1.duration_ = var_451_0[var_451_1]
		end

		SetActive(arg_451_1.tipsGo_, false)

		function arg_451_1.onSingleLineFinish_()
			arg_451_1.onSingleLineUpdate_ = nil
			arg_451_1.onSingleLineFinish_ = nil
			arg_451_1.state_ = "waiting"
		end

		function arg_451_1.playNext_(arg_453_0)
			if arg_453_0 == 1 then
				arg_451_0:Play412031109(arg_451_1)
			end
		end

		function arg_451_1.onSingleLineUpdate_(arg_454_0)
			local var_454_0 = 1.2

			if 0 < arg_451_1.time_ and arg_451_1.time_ <= 0 + arg_454_0 then
				arg_451_1.talkMaxDuration = 0
				arg_451_1.dialogCg_.alpha = 1

				arg_451_1.dialog_:SetActive(true)
				SetActive(arg_451_1.leftNameGo_, true)

				arg_451_1.leftNameTxt_.text = arg_451_1:FormatText(StoryNameCfg[920].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_451_1.leftNameTxt_.transform)

				arg_451_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_451_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_451_1:RecordName(arg_451_1.leftNameTxt_.text)
				SetActive(arg_451_1.iconTrs_.gameObject, false)
				arg_451_1.callingController_:SetSelectedState("normal")

				local var_454_1 = arg_451_1:GetWordFromCfg(412031108)
				local var_454_2 = arg_451_1:FormatText(var_454_1.content)

				arg_451_1.text_.text = var_454_2

				LuaForUtil.ClearLinePrefixSymbol(arg_451_1.text_)

				local var_454_4 = 48 <= 0 and var_454_0 or var_454_0 * (utf8.len(var_454_2) / 48)

				if (48 <= 0 and var_454_0 or var_454_0 * (utf8.len(var_454_2) / 48)) > 0 and var_454_0 < var_454_4 then
					arg_451_1.talkMaxDuration = var_454_4

					if var_454_4 + 0 > arg_451_1.duration_ then
						arg_451_1.duration_ = var_454_4 + 0
					end
				end

				arg_451_1.text_.text = var_454_2
				arg_451_1.typewritter.percent = 0

				arg_451_1.typewritter:SetDirty()
				arg_451_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031108", "story_v_out_412031.awb") ~= 0 then
					local var_454_5 = manager.audio:GetVoiceLength("story_v_out_412031", "412031108", "story_v_out_412031.awb") / 1000

					if var_454_5 + 0 > arg_451_1.duration_ then
						arg_451_1.duration_ = var_454_5 + 0
					end

					if var_454_1.prefab_name ~= "" and arg_451_1.actors_[var_454_1.prefab_name] ~= nil then
						local var_454_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_451_1.actors_[var_454_1.prefab_name].transform, "story_v_out_412031", "412031108", "story_v_out_412031.awb")

						arg_451_1:RecordAudio("412031108", var_454_6)
						arg_451_1:RecordAudio("412031108", var_454_6)
					else
						arg_451_1:AudioAction("play", "voice", "story_v_out_412031", "412031108", "story_v_out_412031.awb")
					end

					arg_451_1:RecordHistoryTalkVoice("story_v_out_412031", "412031108", "story_v_out_412031.awb")
				end

				arg_451_1:RecordContent(arg_451_1.text_.text)
			end

			local var_454_7 = math.max(var_454_0, arg_451_1.talkMaxDuration)

			if 0 <= arg_451_1.time_ and arg_451_1.time_ < 0 + var_454_7 then
				arg_451_1.typewritter.percent = (arg_451_1.time_ - 0) / var_454_7

				arg_451_1.typewritter:SetDirty()
			end

			if arg_451_1.time_ >= 0 + var_454_7 and arg_451_1.time_ < 0 + var_454_7 + arg_454_0 then
				arg_451_1.typewritter.percent = 1

				arg_451_1.typewritter:SetDirty()
				arg_451_1:ShowNextGo(true)
			end
		end

		arg_451_1.nodeConfigList_ = {}

		arg_451_1:InitPlayNodeList()
	end,
	Play412031109 = function(arg_455_0, arg_455_1)
		arg_455_1.time_ = 0
		arg_455_1.frameCnt_ = 0
		arg_455_1.state_ = "playing"
		arg_455_1.curTalkId_ = 412031109
		arg_455_1.duration_ = 7.43

		local var_455_0 = {
			zh = 7.333,
			ja = 7.433
		}
		local var_455_1 = manager.audio:GetLocalizationFlag()

		if var_455_0[var_455_1] ~= nil then
			arg_455_1.duration_ = var_455_0[var_455_1]
		end

		SetActive(arg_455_1.tipsGo_, false)

		function arg_455_1.onSingleLineFinish_()
			arg_455_1.onSingleLineUpdate_ = nil
			arg_455_1.onSingleLineFinish_ = nil
			arg_455_1.state_ = "waiting"
		end

		function arg_455_1.playNext_(arg_457_0)
			if arg_457_0 == 1 then
				arg_455_0:Play412031110(arg_455_1)
			end
		end

		function arg_455_1.onSingleLineUpdate_(arg_458_0)
			if 0 < arg_455_1.time_ and arg_455_1.time_ <= 0 + arg_458_0 and not isNil(arg_455_1.actors_["1097ui_story"]) and arg_455_1.var_.characterEffect1097ui_story == nil then
				arg_455_1.var_.characterEffect1097ui_story = arg_455_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_458_0 = 0.200000002980232

			if 0 <= arg_455_1.time_ and arg_455_1.time_ < 0 + var_458_0 and not isNil(arg_455_1.actors_["1097ui_story"]) then
				if arg_455_1.var_.characterEffect1097ui_story and not isNil(arg_455_1.actors_["1097ui_story"]) then
					arg_455_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_455_1.time_ >= 0 + var_458_0 and arg_455_1.time_ < 0 + var_458_0 + arg_458_0 and not isNil(arg_455_1.actors_["1097ui_story"]) and arg_455_1.var_.characterEffect1097ui_story then
				arg_455_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_455_1.time_ and arg_455_1.time_ <= 0 + arg_458_0 then
				arg_455_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			if 0 < arg_455_1.time_ and arg_455_1.time_ <= 0 + arg_458_0 then
				arg_455_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_458_2 = arg_455_1.actors_["3043ui_story"]

			if 0 < arg_455_1.time_ and arg_455_1.time_ <= 0 + arg_458_0 and not isNil(var_458_2) and arg_455_1.var_.characterEffect3043ui_story == nil then
				arg_455_1.var_.characterEffect3043ui_story = var_458_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_458_3 = 0.200000002980232

			if 0 <= arg_455_1.time_ and arg_455_1.time_ < 0 + var_458_3 and not isNil(var_458_2) then
				if arg_455_1.var_.characterEffect3043ui_story and not isNil(var_458_2) then
					arg_455_1.var_.characterEffect3043ui_story.fillFlat = true
					arg_455_1.var_.characterEffect3043ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_455_1.time_ - 0) / var_458_3)
				end
			end

			if arg_455_1.time_ >= 0 + var_458_3 and arg_455_1.time_ < 0 + var_458_3 + arg_458_0 and not isNil(var_458_2) and arg_455_1.var_.characterEffect3043ui_story then
				arg_455_1.var_.characterEffect3043ui_story.fillFlat = true
				arg_455_1.var_.characterEffect3043ui_story.fillRatio = 0.5
			end

			local var_458_4 = 0
			local var_458_5 = 0.675

			if 0 < arg_455_1.time_ and arg_455_1.time_ <= var_458_4 + arg_458_0 then
				arg_455_1.talkMaxDuration = 0
				arg_455_1.dialogCg_.alpha = 1

				arg_455_1.dialog_:SetActive(true)
				SetActive(arg_455_1.leftNameGo_, true)

				arg_455_1.leftNameTxt_.text = arg_455_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_455_1.leftNameTxt_.transform)

				arg_455_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_455_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_455_1:RecordName(arg_455_1.leftNameTxt_.text)
				SetActive(arg_455_1.iconTrs_.gameObject, false)
				arg_455_1.callingController_:SetSelectedState("normal")

				local var_458_6 = arg_455_1:GetWordFromCfg(412031109)
				local var_458_7 = arg_455_1:FormatText(var_458_6.content)

				arg_455_1.text_.text = var_458_7

				LuaForUtil.ClearLinePrefixSymbol(arg_455_1.text_)

				local var_458_9 = 27 <= 0 and var_458_5 or var_458_5 * (utf8.len(var_458_7) / 27)

				if (27 <= 0 and var_458_5 or var_458_5 * (utf8.len(var_458_7) / 27)) > 0 and var_458_5 < var_458_9 then
					arg_455_1.talkMaxDuration = var_458_9

					if var_458_9 + var_458_4 > arg_455_1.duration_ then
						arg_455_1.duration_ = var_458_9 + var_458_4
					end
				end

				arg_455_1.text_.text = var_458_7
				arg_455_1.typewritter.percent = 0

				arg_455_1.typewritter:SetDirty()
				arg_455_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031109", "story_v_out_412031.awb") ~= 0 then
					local var_458_10 = manager.audio:GetVoiceLength("story_v_out_412031", "412031109", "story_v_out_412031.awb") / 1000

					if var_458_10 + var_458_4 > arg_455_1.duration_ then
						arg_455_1.duration_ = var_458_10 + var_458_4
					end

					if var_458_6.prefab_name ~= "" and arg_455_1.actors_[var_458_6.prefab_name] ~= nil then
						local var_458_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_455_1.actors_[var_458_6.prefab_name].transform, "story_v_out_412031", "412031109", "story_v_out_412031.awb")

						arg_455_1:RecordAudio("412031109", var_458_11)
						arg_455_1:RecordAudio("412031109", var_458_11)
					else
						arg_455_1:AudioAction("play", "voice", "story_v_out_412031", "412031109", "story_v_out_412031.awb")
					end

					arg_455_1:RecordHistoryTalkVoice("story_v_out_412031", "412031109", "story_v_out_412031.awb")
				end

				arg_455_1:RecordContent(arg_455_1.text_.text)
			end

			local var_458_12 = math.max(var_458_5, arg_455_1.talkMaxDuration)

			if var_458_4 <= arg_455_1.time_ and arg_455_1.time_ < var_458_4 + var_458_12 then
				arg_455_1.typewritter.percent = (arg_455_1.time_ - var_458_4) / var_458_12

				arg_455_1.typewritter:SetDirty()
			end

			if arg_455_1.time_ >= var_458_4 + var_458_12 and arg_455_1.time_ < var_458_4 + var_458_12 + arg_458_0 then
				arg_455_1.typewritter.percent = 1

				arg_455_1.typewritter:SetDirty()
				arg_455_1:ShowNextGo(true)
			end
		end

		arg_455_1.nodeConfigList_ = {}

		arg_455_1:InitPlayNodeList()
	end,
	Play412031110 = function(arg_459_0, arg_459_1)
		arg_459_1.time_ = 0
		arg_459_1.frameCnt_ = 0
		arg_459_1.state_ = "playing"
		arg_459_1.curTalkId_ = 412031110
		arg_459_1.duration_ = 10.23

		local var_459_0 = {
			zh = 10.233,
			ja = 6.3
		}
		local var_459_1 = manager.audio:GetLocalizationFlag()

		if var_459_0[var_459_1] ~= nil then
			arg_459_1.duration_ = var_459_0[var_459_1]
		end

		SetActive(arg_459_1.tipsGo_, false)

		function arg_459_1.onSingleLineFinish_()
			arg_459_1.onSingleLineUpdate_ = nil
			arg_459_1.onSingleLineFinish_ = nil
			arg_459_1.state_ = "waiting"
		end

		function arg_459_1.playNext_(arg_461_0)
			if arg_461_0 == 1 then
				arg_459_0:Play412031111(arg_459_1)
			end
		end

		function arg_459_1.onSingleLineUpdate_(arg_462_0)
			local var_462_0 = 0.95

			if 0 < arg_459_1.time_ and arg_459_1.time_ <= 0 + arg_462_0 then
				arg_459_1.talkMaxDuration = 0
				arg_459_1.dialogCg_.alpha = 1

				arg_459_1.dialog_:SetActive(true)
				SetActive(arg_459_1.leftNameGo_, true)

				arg_459_1.leftNameTxt_.text = arg_459_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_459_1.leftNameTxt_.transform)

				arg_459_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_459_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_459_1:RecordName(arg_459_1.leftNameTxt_.text)
				SetActive(arg_459_1.iconTrs_.gameObject, false)
				arg_459_1.callingController_:SetSelectedState("normal")

				local var_462_1 = arg_459_1:GetWordFromCfg(412031110)
				local var_462_2 = arg_459_1:FormatText(var_462_1.content)

				arg_459_1.text_.text = var_462_2

				LuaForUtil.ClearLinePrefixSymbol(arg_459_1.text_)

				local var_462_4 = 38 <= 0 and var_462_0 or var_462_0 * (utf8.len(var_462_2) / 38)

				if (38 <= 0 and var_462_0 or var_462_0 * (utf8.len(var_462_2) / 38)) > 0 and var_462_0 < var_462_4 then
					arg_459_1.talkMaxDuration = var_462_4

					if var_462_4 + 0 > arg_459_1.duration_ then
						arg_459_1.duration_ = var_462_4 + 0
					end
				end

				arg_459_1.text_.text = var_462_2
				arg_459_1.typewritter.percent = 0

				arg_459_1.typewritter:SetDirty()
				arg_459_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031110", "story_v_out_412031.awb") ~= 0 then
					local var_462_5 = manager.audio:GetVoiceLength("story_v_out_412031", "412031110", "story_v_out_412031.awb") / 1000

					if var_462_5 + 0 > arg_459_1.duration_ then
						arg_459_1.duration_ = var_462_5 + 0
					end

					if var_462_1.prefab_name ~= "" and arg_459_1.actors_[var_462_1.prefab_name] ~= nil then
						local var_462_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_459_1.actors_[var_462_1.prefab_name].transform, "story_v_out_412031", "412031110", "story_v_out_412031.awb")

						arg_459_1:RecordAudio("412031110", var_462_6)
						arg_459_1:RecordAudio("412031110", var_462_6)
					else
						arg_459_1:AudioAction("play", "voice", "story_v_out_412031", "412031110", "story_v_out_412031.awb")
					end

					arg_459_1:RecordHistoryTalkVoice("story_v_out_412031", "412031110", "story_v_out_412031.awb")
				end

				arg_459_1:RecordContent(arg_459_1.text_.text)
			end

			local var_462_7 = math.max(var_462_0, arg_459_1.talkMaxDuration)

			if 0 <= arg_459_1.time_ and arg_459_1.time_ < 0 + var_462_7 then
				arg_459_1.typewritter.percent = (arg_459_1.time_ - 0) / var_462_7

				arg_459_1.typewritter:SetDirty()
			end

			if arg_459_1.time_ >= 0 + var_462_7 and arg_459_1.time_ < 0 + var_462_7 + arg_462_0 then
				arg_459_1.typewritter.percent = 1

				arg_459_1.typewritter:SetDirty()
				arg_459_1:ShowNextGo(true)
			end
		end

		arg_459_1.nodeConfigList_ = {}

		arg_459_1:InitPlayNodeList()
	end,
	Play412031111 = function(arg_463_0, arg_463_1)
		arg_463_1.time_ = 0
		arg_463_1.frameCnt_ = 0
		arg_463_1.state_ = "playing"
		arg_463_1.curTalkId_ = 412031111
		arg_463_1.duration_ = 8.6

		local var_463_0 = {
			zh = 8.6,
			ja = 4.166
		}
		local var_463_1 = manager.audio:GetLocalizationFlag()

		if var_463_0[var_463_1] ~= nil then
			arg_463_1.duration_ = var_463_0[var_463_1]
		end

		SetActive(arg_463_1.tipsGo_, false)

		function arg_463_1.onSingleLineFinish_()
			arg_463_1.onSingleLineUpdate_ = nil
			arg_463_1.onSingleLineFinish_ = nil
			arg_463_1.state_ = "waiting"
		end

		function arg_463_1.playNext_(arg_465_0)
			if arg_465_0 == 1 then
				arg_463_0:Play412031112(arg_463_1)
			end
		end

		function arg_463_1.onSingleLineUpdate_(arg_466_0)
			local var_466_0 = 0.85

			if 0 < arg_463_1.time_ and arg_463_1.time_ <= 0 + arg_466_0 then
				arg_463_1.talkMaxDuration = 0
				arg_463_1.dialogCg_.alpha = 1

				arg_463_1.dialog_:SetActive(true)
				SetActive(arg_463_1.leftNameGo_, true)

				arg_463_1.leftNameTxt_.text = arg_463_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_463_1.leftNameTxt_.transform)

				arg_463_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_463_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_463_1:RecordName(arg_463_1.leftNameTxt_.text)
				SetActive(arg_463_1.iconTrs_.gameObject, false)
				arg_463_1.callingController_:SetSelectedState("normal")

				local var_466_1 = arg_463_1:GetWordFromCfg(412031111)
				local var_466_2 = arg_463_1:FormatText(var_466_1.content)

				arg_463_1.text_.text = var_466_2

				LuaForUtil.ClearLinePrefixSymbol(arg_463_1.text_)

				local var_466_4 = 34 <= 0 and var_466_0 or var_466_0 * (utf8.len(var_466_2) / 34)

				if (34 <= 0 and var_466_0 or var_466_0 * (utf8.len(var_466_2) / 34)) > 0 and var_466_0 < var_466_4 then
					arg_463_1.talkMaxDuration = var_466_4

					if var_466_4 + 0 > arg_463_1.duration_ then
						arg_463_1.duration_ = var_466_4 + 0
					end
				end

				arg_463_1.text_.text = var_466_2
				arg_463_1.typewritter.percent = 0

				arg_463_1.typewritter:SetDirty()
				arg_463_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031111", "story_v_out_412031.awb") ~= 0 then
					local var_466_5 = manager.audio:GetVoiceLength("story_v_out_412031", "412031111", "story_v_out_412031.awb") / 1000

					if var_466_5 + 0 > arg_463_1.duration_ then
						arg_463_1.duration_ = var_466_5 + 0
					end

					if var_466_1.prefab_name ~= "" and arg_463_1.actors_[var_466_1.prefab_name] ~= nil then
						local var_466_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_463_1.actors_[var_466_1.prefab_name].transform, "story_v_out_412031", "412031111", "story_v_out_412031.awb")

						arg_463_1:RecordAudio("412031111", var_466_6)
						arg_463_1:RecordAudio("412031111", var_466_6)
					else
						arg_463_1:AudioAction("play", "voice", "story_v_out_412031", "412031111", "story_v_out_412031.awb")
					end

					arg_463_1:RecordHistoryTalkVoice("story_v_out_412031", "412031111", "story_v_out_412031.awb")
				end

				arg_463_1:RecordContent(arg_463_1.text_.text)
			end

			local var_466_7 = math.max(var_466_0, arg_463_1.talkMaxDuration)

			if 0 <= arg_463_1.time_ and arg_463_1.time_ < 0 + var_466_7 then
				arg_463_1.typewritter.percent = (arg_463_1.time_ - 0) / var_466_7

				arg_463_1.typewritter:SetDirty()
			end

			if arg_463_1.time_ >= 0 + var_466_7 and arg_463_1.time_ < 0 + var_466_7 + arg_466_0 then
				arg_463_1.typewritter.percent = 1

				arg_463_1.typewritter:SetDirty()
				arg_463_1:ShowNextGo(true)
			end
		end

		arg_463_1.nodeConfigList_ = {}

		arg_463_1:InitPlayNodeList()
	end,
	Play412031112 = function(arg_467_0, arg_467_1)
		arg_467_1.time_ = 0
		arg_467_1.frameCnt_ = 0
		arg_467_1.state_ = "playing"
		arg_467_1.curTalkId_ = 412031112
		arg_467_1.duration_ = 8.3

		local var_467_0 = {
			zh = 8.3,
			ja = 4.9
		}
		local var_467_1 = manager.audio:GetLocalizationFlag()

		if var_467_0[var_467_1] ~= nil then
			arg_467_1.duration_ = var_467_0[var_467_1]
		end

		SetActive(arg_467_1.tipsGo_, false)

		function arg_467_1.onSingleLineFinish_()
			arg_467_1.onSingleLineUpdate_ = nil
			arg_467_1.onSingleLineFinish_ = nil
			arg_467_1.state_ = "waiting"
		end

		function arg_467_1.playNext_(arg_469_0)
			if arg_469_0 == 1 then
				arg_467_0:Play412031113(arg_467_1)
			end
		end

		function arg_467_1.onSingleLineUpdate_(arg_470_0)
			if 0 < arg_467_1.time_ and arg_467_1.time_ <= 0 + arg_470_0 and not isNil(arg_467_1.actors_["3043ui_story"]) and arg_467_1.var_.characterEffect3043ui_story == nil then
				arg_467_1.var_.characterEffect3043ui_story = arg_467_1.actors_["3043ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_470_0 = 0.200000002980232

			if 0 <= arg_467_1.time_ and arg_467_1.time_ < 0 + var_470_0 and not isNil(arg_467_1.actors_["3043ui_story"]) then
				if arg_467_1.var_.characterEffect3043ui_story and not isNil(arg_467_1.actors_["3043ui_story"]) then
					arg_467_1.var_.characterEffect3043ui_story.fillFlat = false
				end
			end

			if arg_467_1.time_ >= 0 + var_470_0 and arg_467_1.time_ < 0 + var_470_0 + arg_470_0 and not isNil(arg_467_1.actors_["3043ui_story"]) and arg_467_1.var_.characterEffect3043ui_story then
				arg_467_1.var_.characterEffect3043ui_story.fillFlat = false
			end

			if 0 < arg_467_1.time_ and arg_467_1.time_ <= 0 + arg_470_0 then
				arg_467_1:PlayTimeline("3043ui_story", "StoryTimeline/CharAction/story3043/story3043action/3043action2_1")
			end

			if 0 < arg_467_1.time_ and arg_467_1.time_ <= 0 + arg_470_0 then
				arg_467_1:PlayTimeline("3043ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_470_2 = arg_467_1.actors_["1097ui_story"]

			if 0 < arg_467_1.time_ and arg_467_1.time_ <= 0 + arg_470_0 and not isNil(var_470_2) and arg_467_1.var_.characterEffect1097ui_story == nil then
				arg_467_1.var_.characterEffect1097ui_story = var_470_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_470_3 = 0.200000002980232

			if 0 <= arg_467_1.time_ and arg_467_1.time_ < 0 + var_470_3 and not isNil(var_470_2) then
				if arg_467_1.var_.characterEffect1097ui_story and not isNil(var_470_2) then
					arg_467_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_467_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_467_1.time_ - 0) / var_470_3)
				end
			end

			if arg_467_1.time_ >= 0 + var_470_3 and arg_467_1.time_ < 0 + var_470_3 + arg_470_0 and not isNil(var_470_2) and arg_467_1.var_.characterEffect1097ui_story then
				arg_467_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_467_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_470_4 = 0
			local var_470_5 = 0.7

			if 0 < arg_467_1.time_ and arg_467_1.time_ <= var_470_4 + arg_470_0 then
				arg_467_1.talkMaxDuration = 0
				arg_467_1.dialogCg_.alpha = 1

				arg_467_1.dialog_:SetActive(true)
				SetActive(arg_467_1.leftNameGo_, true)

				arg_467_1.leftNameTxt_.text = arg_467_1:FormatText(StoryNameCfg[920].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_467_1.leftNameTxt_.transform)

				arg_467_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_467_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_467_1:RecordName(arg_467_1.leftNameTxt_.text)
				SetActive(arg_467_1.iconTrs_.gameObject, false)
				arg_467_1.callingController_:SetSelectedState("normal")

				local var_470_6 = arg_467_1:GetWordFromCfg(412031112)
				local var_470_7 = arg_467_1:FormatText(var_470_6.content)

				arg_467_1.text_.text = var_470_7

				LuaForUtil.ClearLinePrefixSymbol(arg_467_1.text_)

				local var_470_9 = 28 <= 0 and var_470_5 or var_470_5 * (utf8.len(var_470_7) / 28)

				if (28 <= 0 and var_470_5 or var_470_5 * (utf8.len(var_470_7) / 28)) > 0 and var_470_5 < var_470_9 then
					arg_467_1.talkMaxDuration = var_470_9

					if var_470_9 + var_470_4 > arg_467_1.duration_ then
						arg_467_1.duration_ = var_470_9 + var_470_4
					end
				end

				arg_467_1.text_.text = var_470_7
				arg_467_1.typewritter.percent = 0

				arg_467_1.typewritter:SetDirty()
				arg_467_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031112", "story_v_out_412031.awb") ~= 0 then
					local var_470_10 = manager.audio:GetVoiceLength("story_v_out_412031", "412031112", "story_v_out_412031.awb") / 1000

					if var_470_10 + var_470_4 > arg_467_1.duration_ then
						arg_467_1.duration_ = var_470_10 + var_470_4
					end

					if var_470_6.prefab_name ~= "" and arg_467_1.actors_[var_470_6.prefab_name] ~= nil then
						local var_470_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_467_1.actors_[var_470_6.prefab_name].transform, "story_v_out_412031", "412031112", "story_v_out_412031.awb")

						arg_467_1:RecordAudio("412031112", var_470_11)
						arg_467_1:RecordAudio("412031112", var_470_11)
					else
						arg_467_1:AudioAction("play", "voice", "story_v_out_412031", "412031112", "story_v_out_412031.awb")
					end

					arg_467_1:RecordHistoryTalkVoice("story_v_out_412031", "412031112", "story_v_out_412031.awb")
				end

				arg_467_1:RecordContent(arg_467_1.text_.text)
			end

			local var_470_12 = math.max(var_470_5, arg_467_1.talkMaxDuration)

			if var_470_4 <= arg_467_1.time_ and arg_467_1.time_ < var_470_4 + var_470_12 then
				arg_467_1.typewritter.percent = (arg_467_1.time_ - var_470_4) / var_470_12

				arg_467_1.typewritter:SetDirty()
			end

			if arg_467_1.time_ >= var_470_4 + var_470_12 and arg_467_1.time_ < var_470_4 + var_470_12 + arg_470_0 then
				arg_467_1.typewritter.percent = 1

				arg_467_1.typewritter:SetDirty()
				arg_467_1:ShowNextGo(true)
			end
		end

		arg_467_1.nodeConfigList_ = {}

		arg_467_1:InitPlayNodeList()
	end,
	Play412031113 = function(arg_471_0, arg_471_1)
		arg_471_1.time_ = 0
		arg_471_1.frameCnt_ = 0
		arg_471_1.state_ = "playing"
		arg_471_1.curTalkId_ = 412031113
		arg_471_1.duration_ = 4.57

		local var_471_0 = {
			zh = 4.566,
			ja = 3.5
		}
		local var_471_1 = manager.audio:GetLocalizationFlag()

		if var_471_0[var_471_1] ~= nil then
			arg_471_1.duration_ = var_471_0[var_471_1]
		end

		SetActive(arg_471_1.tipsGo_, false)

		function arg_471_1.onSingleLineFinish_()
			arg_471_1.onSingleLineUpdate_ = nil
			arg_471_1.onSingleLineFinish_ = nil
			arg_471_1.state_ = "waiting"
		end

		function arg_471_1.playNext_(arg_473_0)
			if arg_473_0 == 1 then
				arg_471_0:Play412031114(arg_471_1)
			end
		end

		function arg_471_1.onSingleLineUpdate_(arg_474_0)
			if 0 < arg_471_1.time_ and arg_471_1.time_ <= 0 + arg_474_0 then
				arg_471_1.var_.moveOldPos10076ui_story = arg_471_1.actors_["10076ui_story"].transform.localPosition
			end

			local var_474_0 = 0.001

			if 0 <= arg_471_1.time_ and arg_471_1.time_ < 0 + var_474_0 then
				arg_471_1.actors_["10076ui_story"].transform.localPosition = Vector3.Lerp(arg_471_1.var_.moveOldPos10076ui_story, Vector3.New(0, -0.35, -4), (arg_471_1.time_ - 0) / var_474_0)
				arg_471_1.actors_["10076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_471_1.actors_["10076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_471_1.actors_["10076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_471_1.actors_["10076ui_story"].transform.position).z)
				arg_471_1.actors_["10076ui_story"].transform.localEulerAngles.z = 0
				arg_471_1.actors_["10076ui_story"].transform.localEulerAngles.x = 0
				arg_471_1.actors_["10076ui_story"].transform.localEulerAngles = arg_471_1.actors_["10076ui_story"].transform.localEulerAngles
			end

			if arg_471_1.time_ >= 0 + var_474_0 and arg_471_1.time_ < 0 + var_474_0 + arg_474_0 then
				arg_471_1.actors_["10076ui_story"].transform.localPosition = Vector3.New(0, -0.35, -4)
				arg_471_1.actors_["10076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_471_1.actors_["10076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_471_1.actors_["10076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_471_1.actors_["10076ui_story"].transform.position).z)
				arg_471_1.actors_["10076ui_story"].transform.localEulerAngles.z = 0
				arg_471_1.actors_["10076ui_story"].transform.localEulerAngles.x = 0
				arg_471_1.actors_["10076ui_story"].transform.localEulerAngles = arg_471_1.actors_["10076ui_story"].transform.localEulerAngles
			end

			local var_474_1 = arg_471_1.actors_["10076ui_story"]

			if 0 < arg_471_1.time_ and arg_471_1.time_ <= 0 + arg_474_0 and not isNil(var_474_1) and arg_471_1.var_.characterEffect10076ui_story == nil then
				arg_471_1.var_.characterEffect10076ui_story = var_474_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_474_2 = 0.200000002980232

			if 0 <= arg_471_1.time_ and arg_471_1.time_ < 0 + var_474_2 and not isNil(var_474_1) then
				if arg_471_1.var_.characterEffect10076ui_story and not isNil(var_474_1) then
					arg_471_1.var_.characterEffect10076ui_story.fillFlat = false
				end
			end

			if arg_471_1.time_ >= 0 + var_474_2 and arg_471_1.time_ < 0 + var_474_2 + arg_474_0 and not isNil(var_474_1) and arg_471_1.var_.characterEffect10076ui_story then
				arg_471_1.var_.characterEffect10076ui_story.fillFlat = false
			end

			if 0 < arg_471_1.time_ and arg_471_1.time_ <= 0 + arg_474_0 then
				arg_471_1:PlayTimeline("10076ui_story", "StoryTimeline/CharAction/story10076/story10076action/10076action3_1")
			end

			if 0 < arg_471_1.time_ and arg_471_1.time_ <= 0 + arg_474_0 then
				arg_471_1:PlayTimeline("10076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_474_4 = arg_471_1.actors_["1097ui_story"].transform

			if 0 < arg_471_1.time_ and arg_471_1.time_ <= 0 + arg_474_0 then
				arg_471_1.var_.moveOldPos1097ui_story = var_474_4.localPosition
			end

			local var_474_5 = 0.001

			if 0 <= arg_471_1.time_ and arg_471_1.time_ < 0 + var_474_5 then
				var_474_4.localPosition = Vector3.Lerp(arg_471_1.var_.moveOldPos1097ui_story, Vector3.New(0, 100, 0), (arg_471_1.time_ - 0) / var_474_5)
				var_474_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_474_4.position).x, (manager.ui.mainCamera.transform.position - var_474_4.position).y, (manager.ui.mainCamera.transform.position - var_474_4.position).z)
				var_474_4.localEulerAngles.z = 0
				var_474_4.localEulerAngles.x = 0
				var_474_4.localEulerAngles = var_474_4.localEulerAngles
			end

			if arg_471_1.time_ >= 0 + var_474_5 and arg_471_1.time_ < 0 + var_474_5 + arg_474_0 then
				var_474_4.localPosition = Vector3.New(0, 100, 0)
				var_474_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_474_4.position).x, (manager.ui.mainCamera.transform.position - var_474_4.position).y, (manager.ui.mainCamera.transform.position - var_474_4.position).z)
				var_474_4.localEulerAngles.z = 0
				var_474_4.localEulerAngles.x = 0
				var_474_4.localEulerAngles = var_474_4.localEulerAngles
			end

			local var_474_6 = arg_471_1.actors_["1097ui_story"]

			if 0 < arg_471_1.time_ and arg_471_1.time_ <= 0 + arg_474_0 and not isNil(var_474_6) and arg_471_1.var_.characterEffect1097ui_story == nil then
				arg_471_1.var_.characterEffect1097ui_story = var_474_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_474_7 = 0.200000002980232

			if 0 <= arg_471_1.time_ and arg_471_1.time_ < 0 + var_474_7 and not isNil(var_474_6) then
				if arg_471_1.var_.characterEffect1097ui_story and not isNil(var_474_6) then
					arg_471_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_471_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_471_1.time_ - 0) / var_474_7)
				end
			end

			if arg_471_1.time_ >= 0 + var_474_7 and arg_471_1.time_ < 0 + var_474_7 + arg_474_0 and not isNil(var_474_6) and arg_471_1.var_.characterEffect1097ui_story then
				arg_471_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_471_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_474_8 = arg_471_1.actors_["3043ui_story"].transform

			if 0 < arg_471_1.time_ and arg_471_1.time_ <= 0 + arg_474_0 then
				arg_471_1.var_.moveOldPos3043ui_story = var_474_8.localPosition
			end

			local var_474_9 = 0.001

			if 0 <= arg_471_1.time_ and arg_471_1.time_ < 0 + var_474_9 then
				var_474_8.localPosition = Vector3.Lerp(arg_471_1.var_.moveOldPos3043ui_story, Vector3.New(0, 100, 0), (arg_471_1.time_ - 0) / var_474_9)
				var_474_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_474_8.position).x, (manager.ui.mainCamera.transform.position - var_474_8.position).y, (manager.ui.mainCamera.transform.position - var_474_8.position).z)
				var_474_8.localEulerAngles.z = 0
				var_474_8.localEulerAngles.x = 0
				var_474_8.localEulerAngles = var_474_8.localEulerAngles
			end

			if arg_471_1.time_ >= 0 + var_474_9 and arg_471_1.time_ < 0 + var_474_9 + arg_474_0 then
				var_474_8.localPosition = Vector3.New(0, 100, 0)
				var_474_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_474_8.position).x, (manager.ui.mainCamera.transform.position - var_474_8.position).y, (manager.ui.mainCamera.transform.position - var_474_8.position).z)
				var_474_8.localEulerAngles.z = 0
				var_474_8.localEulerAngles.x = 0
				var_474_8.localEulerAngles = var_474_8.localEulerAngles
			end

			local var_474_10 = arg_471_1.actors_["3043ui_story"]

			if 0 < arg_471_1.time_ and arg_471_1.time_ <= 0 + arg_474_0 and not isNil(var_474_10) and arg_471_1.var_.characterEffect3043ui_story == nil then
				arg_471_1.var_.characterEffect3043ui_story = var_474_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_474_11 = 0.200000002980232

			if 0 <= arg_471_1.time_ and arg_471_1.time_ < 0 + var_474_11 and not isNil(var_474_10) then
				if arg_471_1.var_.characterEffect3043ui_story and not isNil(var_474_10) then
					arg_471_1.var_.characterEffect3043ui_story.fillFlat = true
					arg_471_1.var_.characterEffect3043ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_471_1.time_ - 0) / var_474_11)
				end
			end

			if arg_471_1.time_ >= 0 + var_474_11 and arg_471_1.time_ < 0 + var_474_11 + arg_474_0 and not isNil(var_474_10) and arg_471_1.var_.characterEffect3043ui_story then
				arg_471_1.var_.characterEffect3043ui_story.fillFlat = true
				arg_471_1.var_.characterEffect3043ui_story.fillRatio = 0.5
			end

			local var_474_12 = 0
			local var_474_13 = 0.6

			if 0 < arg_471_1.time_ and arg_471_1.time_ <= var_474_12 + arg_474_0 then
				arg_471_1.talkMaxDuration = 0
				arg_471_1.dialogCg_.alpha = 1

				arg_471_1.dialog_:SetActive(true)
				SetActive(arg_471_1.leftNameGo_, true)

				arg_471_1.leftNameTxt_.text = arg_471_1:FormatText(StoryNameCfg[917].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_471_1.leftNameTxt_.transform)

				arg_471_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_471_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_471_1:RecordName(arg_471_1.leftNameTxt_.text)
				SetActive(arg_471_1.iconTrs_.gameObject, false)
				arg_471_1.callingController_:SetSelectedState("normal")

				local var_474_14 = arg_471_1:GetWordFromCfg(412031113)
				local var_474_15 = arg_471_1:FormatText(var_474_14.content)

				arg_471_1.text_.text = var_474_15

				LuaForUtil.ClearLinePrefixSymbol(arg_471_1.text_)

				local var_474_17 = 24 <= 0 and var_474_13 or var_474_13 * (utf8.len(var_474_15) / 24)

				if (24 <= 0 and var_474_13 or var_474_13 * (utf8.len(var_474_15) / 24)) > 0 and var_474_13 < var_474_17 then
					arg_471_1.talkMaxDuration = var_474_17

					if var_474_17 + var_474_12 > arg_471_1.duration_ then
						arg_471_1.duration_ = var_474_17 + var_474_12
					end
				end

				arg_471_1.text_.text = var_474_15
				arg_471_1.typewritter.percent = 0

				arg_471_1.typewritter:SetDirty()
				arg_471_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031113", "story_v_out_412031.awb") ~= 0 then
					local var_474_18 = manager.audio:GetVoiceLength("story_v_out_412031", "412031113", "story_v_out_412031.awb") / 1000

					if var_474_18 + var_474_12 > arg_471_1.duration_ then
						arg_471_1.duration_ = var_474_18 + var_474_12
					end

					if var_474_14.prefab_name ~= "" and arg_471_1.actors_[var_474_14.prefab_name] ~= nil then
						local var_474_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_471_1.actors_[var_474_14.prefab_name].transform, "story_v_out_412031", "412031113", "story_v_out_412031.awb")

						arg_471_1:RecordAudio("412031113", var_474_19)
						arg_471_1:RecordAudio("412031113", var_474_19)
					else
						arg_471_1:AudioAction("play", "voice", "story_v_out_412031", "412031113", "story_v_out_412031.awb")
					end

					arg_471_1:RecordHistoryTalkVoice("story_v_out_412031", "412031113", "story_v_out_412031.awb")
				end

				arg_471_1:RecordContent(arg_471_1.text_.text)
			end

			local var_474_20 = math.max(var_474_13, arg_471_1.talkMaxDuration)

			if var_474_12 <= arg_471_1.time_ and arg_471_1.time_ < var_474_12 + var_474_20 then
				arg_471_1.typewritter.percent = (arg_471_1.time_ - var_474_12) / var_474_20

				arg_471_1.typewritter:SetDirty()
			end

			if arg_471_1.time_ >= var_474_12 + var_474_20 and arg_471_1.time_ < var_474_12 + var_474_20 + arg_474_0 then
				arg_471_1.typewritter.percent = 1

				arg_471_1.typewritter:SetDirty()
				arg_471_1:ShowNextGo(true)
			end
		end

		arg_471_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "3043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_471_1:InitPlayNodeList()
	end,
	Play412031114 = function(arg_475_0, arg_475_1)
		arg_475_1.time_ = 0
		arg_475_1.frameCnt_ = 0
		arg_475_1.state_ = "playing"
		arg_475_1.curTalkId_ = 412031114
		arg_475_1.duration_ = 2

		SetActive(arg_475_1.tipsGo_, false)

		function arg_475_1.onSingleLineFinish_()
			arg_475_1.onSingleLineUpdate_ = nil
			arg_475_1.onSingleLineFinish_ = nil
			arg_475_1.state_ = "waiting"
		end

		function arg_475_1.playNext_(arg_477_0)
			if arg_477_0 == 1 then
				arg_475_0:Play412031115(arg_475_1)
			end
		end

		function arg_475_1.onSingleLineUpdate_(arg_478_0)
			if 0 < arg_475_1.time_ and arg_475_1.time_ <= 0 + arg_478_0 then
				arg_475_1.var_.moveOldPos1097ui_story = arg_475_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_478_0 = 0.001

			if 0 <= arg_475_1.time_ and arg_475_1.time_ < 0 + var_478_0 then
				arg_475_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_475_1.var_.moveOldPos1097ui_story, Vector3.New(0, -0.54, -6.3), (arg_475_1.time_ - 0) / var_478_0)
				arg_475_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_475_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_475_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_475_1.actors_["1097ui_story"].transform.position).z)
				arg_475_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_475_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_475_1.actors_["1097ui_story"].transform.localEulerAngles = arg_475_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_475_1.time_ >= 0 + var_478_0 and arg_475_1.time_ < 0 + var_478_0 + arg_478_0 then
				arg_475_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(0, -0.54, -6.3)
				arg_475_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_475_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_475_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_475_1.actors_["1097ui_story"].transform.position).z)
				arg_475_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_475_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_475_1.actors_["1097ui_story"].transform.localEulerAngles = arg_475_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_478_1 = arg_475_1.actors_["1097ui_story"]

			if 0 < arg_475_1.time_ and arg_475_1.time_ <= 0 + arg_478_0 and not isNil(var_478_1) and arg_475_1.var_.characterEffect1097ui_story == nil then
				arg_475_1.var_.characterEffect1097ui_story = var_478_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_478_2 = 0.200000002980232

			if 0 <= arg_475_1.time_ and arg_475_1.time_ < 0 + var_478_2 and not isNil(var_478_1) then
				if arg_475_1.var_.characterEffect1097ui_story and not isNil(var_478_1) then
					arg_475_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_475_1.time_ >= 0 + var_478_2 and arg_475_1.time_ < 0 + var_478_2 + arg_478_0 and not isNil(var_478_1) and arg_475_1.var_.characterEffect1097ui_story then
				arg_475_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_475_1.time_ and arg_475_1.time_ <= 0 + arg_478_0 then
				arg_475_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			if 0 < arg_475_1.time_ and arg_475_1.time_ <= 0 + arg_478_0 then
				arg_475_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_478_4 = arg_475_1.actors_["10076ui_story"].transform

			if 0 < arg_475_1.time_ and arg_475_1.time_ <= 0 + arg_478_0 then
				arg_475_1.var_.moveOldPos10076ui_story = var_478_4.localPosition
			end

			local var_478_5 = 0.001

			if 0 <= arg_475_1.time_ and arg_475_1.time_ < 0 + var_478_5 then
				var_478_4.localPosition = Vector3.Lerp(arg_475_1.var_.moveOldPos10076ui_story, Vector3.New(0, 100, 0), (arg_475_1.time_ - 0) / var_478_5)
				var_478_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_478_4.position).x, (manager.ui.mainCamera.transform.position - var_478_4.position).y, (manager.ui.mainCamera.transform.position - var_478_4.position).z)
				var_478_4.localEulerAngles.z = 0
				var_478_4.localEulerAngles.x = 0
				var_478_4.localEulerAngles = var_478_4.localEulerAngles
			end

			if arg_475_1.time_ >= 0 + var_478_5 and arg_475_1.time_ < 0 + var_478_5 + arg_478_0 then
				var_478_4.localPosition = Vector3.New(0, 100, 0)
				var_478_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_478_4.position).x, (manager.ui.mainCamera.transform.position - var_478_4.position).y, (manager.ui.mainCamera.transform.position - var_478_4.position).z)
				var_478_4.localEulerAngles.z = 0
				var_478_4.localEulerAngles.x = 0
				var_478_4.localEulerAngles = var_478_4.localEulerAngles
			end

			local var_478_6 = arg_475_1.actors_["10076ui_story"]

			if 0 < arg_475_1.time_ and arg_475_1.time_ <= 0 + arg_478_0 and not isNil(var_478_6) and arg_475_1.var_.characterEffect10076ui_story == nil then
				arg_475_1.var_.characterEffect10076ui_story = var_478_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_478_7 = 0.200000002980232

			if 0 <= arg_475_1.time_ and arg_475_1.time_ < 0 + var_478_7 and not isNil(var_478_6) then
				if arg_475_1.var_.characterEffect10076ui_story and not isNil(var_478_6) then
					arg_475_1.var_.characterEffect10076ui_story.fillFlat = true
					arg_475_1.var_.characterEffect10076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_475_1.time_ - 0) / var_478_7)
				end
			end

			if arg_475_1.time_ >= 0 + var_478_7 and arg_475_1.time_ < 0 + var_478_7 + arg_478_0 and not isNil(var_478_6) and arg_475_1.var_.characterEffect10076ui_story then
				arg_475_1.var_.characterEffect10076ui_story.fillFlat = true
				arg_475_1.var_.characterEffect10076ui_story.fillRatio = 0.5
			end

			local var_478_8 = 0
			local var_478_9 = 0.125

			if 0 < arg_475_1.time_ and arg_475_1.time_ <= var_478_8 + arg_478_0 then
				arg_475_1.talkMaxDuration = 0
				arg_475_1.dialogCg_.alpha = 1

				arg_475_1.dialog_:SetActive(true)
				SetActive(arg_475_1.leftNameGo_, true)

				arg_475_1.leftNameTxt_.text = arg_475_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_475_1.leftNameTxt_.transform)

				arg_475_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_475_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_475_1:RecordName(arg_475_1.leftNameTxt_.text)
				SetActive(arg_475_1.iconTrs_.gameObject, false)
				arg_475_1.callingController_:SetSelectedState("normal")

				local var_478_10 = arg_475_1:GetWordFromCfg(412031114)
				local var_478_11 = arg_475_1:FormatText(var_478_10.content)

				arg_475_1.text_.text = var_478_11

				LuaForUtil.ClearLinePrefixSymbol(arg_475_1.text_)

				local var_478_13 = 5 <= 0 and var_478_9 or var_478_9 * (utf8.len(var_478_11) / 5)

				if (5 <= 0 and var_478_9 or var_478_9 * (utf8.len(var_478_11) / 5)) > 0 and var_478_9 < var_478_13 then
					arg_475_1.talkMaxDuration = var_478_13

					if var_478_13 + var_478_8 > arg_475_1.duration_ then
						arg_475_1.duration_ = var_478_13 + var_478_8
					end
				end

				arg_475_1.text_.text = var_478_11
				arg_475_1.typewritter.percent = 0

				arg_475_1.typewritter:SetDirty()
				arg_475_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031114", "story_v_out_412031.awb") ~= 0 then
					local var_478_14 = manager.audio:GetVoiceLength("story_v_out_412031", "412031114", "story_v_out_412031.awb") / 1000

					if var_478_14 + var_478_8 > arg_475_1.duration_ then
						arg_475_1.duration_ = var_478_14 + var_478_8
					end

					if var_478_10.prefab_name ~= "" and arg_475_1.actors_[var_478_10.prefab_name] ~= nil then
						local var_478_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_475_1.actors_[var_478_10.prefab_name].transform, "story_v_out_412031", "412031114", "story_v_out_412031.awb")

						arg_475_1:RecordAudio("412031114", var_478_15)
						arg_475_1:RecordAudio("412031114", var_478_15)
					else
						arg_475_1:AudioAction("play", "voice", "story_v_out_412031", "412031114", "story_v_out_412031.awb")
					end

					arg_475_1:RecordHistoryTalkVoice("story_v_out_412031", "412031114", "story_v_out_412031.awb")
				end

				arg_475_1:RecordContent(arg_475_1.text_.text)
			end

			local var_478_16 = math.max(var_478_9, arg_475_1.talkMaxDuration)

			if var_478_8 <= arg_475_1.time_ and arg_475_1.time_ < var_478_8 + var_478_16 then
				arg_475_1.typewritter.percent = (arg_475_1.time_ - var_478_8) / var_478_16

				arg_475_1.typewritter:SetDirty()
			end

			if arg_475_1.time_ >= var_478_8 + var_478_16 and arg_475_1.time_ < var_478_8 + var_478_16 + arg_478_0 then
				arg_475_1.typewritter.percent = 1

				arg_475_1.typewritter:SetDirty()
				arg_475_1:ShowNextGo(true)
			end
		end

		arg_475_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_475_1:InitPlayNodeList()
	end,
	Play412031115 = function(arg_479_0, arg_479_1)
		arg_479_1.time_ = 0
		arg_479_1.frameCnt_ = 0
		arg_479_1.state_ = "playing"
		arg_479_1.curTalkId_ = 412031115
		arg_479_1.duration_ = 5

		SetActive(arg_479_1.tipsGo_, false)

		function arg_479_1.onSingleLineFinish_()
			arg_479_1.onSingleLineUpdate_ = nil
			arg_479_1.onSingleLineFinish_ = nil
			arg_479_1.state_ = "waiting"
		end

		function arg_479_1.playNext_(arg_481_0)
			if arg_481_0 == 1 then
				arg_479_0:Play412031116(arg_479_1)
			end
		end

		function arg_479_1.onSingleLineUpdate_(arg_482_0)
			if 0 < arg_479_1.time_ and arg_479_1.time_ <= 0 + arg_482_0 then
				arg_479_1.var_.moveOldPos1097ui_story = arg_479_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_482_0 = 0.001

			if 0 <= arg_479_1.time_ and arg_479_1.time_ < 0 + var_482_0 then
				arg_479_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_479_1.var_.moveOldPos1097ui_story, Vector3.New(0, 100, 0), (arg_479_1.time_ - 0) / var_482_0)
				arg_479_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_479_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_479_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_479_1.actors_["1097ui_story"].transform.position).z)
				arg_479_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_479_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_479_1.actors_["1097ui_story"].transform.localEulerAngles = arg_479_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_479_1.time_ >= 0 + var_482_0 and arg_479_1.time_ < 0 + var_482_0 + arg_482_0 then
				arg_479_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_479_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_479_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_479_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_479_1.actors_["1097ui_story"].transform.position).z)
				arg_479_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_479_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_479_1.actors_["1097ui_story"].transform.localEulerAngles = arg_479_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_482_1 = arg_479_1.actors_["1097ui_story"]

			if 0 < arg_479_1.time_ and arg_479_1.time_ <= 0 + arg_482_0 and not isNil(var_482_1) and arg_479_1.var_.characterEffect1097ui_story == nil then
				arg_479_1.var_.characterEffect1097ui_story = var_482_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_482_2 = 0.200000002980232

			if 0 <= arg_479_1.time_ and arg_479_1.time_ < 0 + var_482_2 and not isNil(var_482_1) then
				if arg_479_1.var_.characterEffect1097ui_story and not isNil(var_482_1) then
					arg_479_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_479_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_479_1.time_ - 0) / var_482_2)
				end
			end

			if arg_479_1.time_ >= 0 + var_482_2 and arg_479_1.time_ < 0 + var_482_2 + arg_482_0 and not isNil(var_482_1) and arg_479_1.var_.characterEffect1097ui_story then
				arg_479_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_479_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_482_3 = 0
			local var_482_4 = 1.25

			if 0 < arg_479_1.time_ and arg_479_1.time_ <= var_482_3 + arg_482_0 then
				arg_479_1.talkMaxDuration = 0
				arg_479_1.dialogCg_.alpha = 1

				arg_479_1.dialog_:SetActive(true)
				SetActive(arg_479_1.leftNameGo_, false)

				arg_479_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_479_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_479_1:RecordName(arg_479_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_479_1.iconTrs_.gameObject, false)
				arg_479_1.callingController_:SetSelectedState("normal")

				local var_482_5 = arg_479_1:FormatText(arg_479_1:GetWordFromCfg(412031115).content)

				arg_479_1.text_.text = var_482_5

				LuaForUtil.ClearLinePrefixSymbol(arg_479_1.text_)

				local var_482_7 = 50 <= 0 and var_482_4 or var_482_4 * (utf8.len(var_482_5) / 50)

				if (50 <= 0 and var_482_4 or var_482_4 * (utf8.len(var_482_5) / 50)) > 0 and var_482_4 < var_482_7 then
					arg_479_1.talkMaxDuration = var_482_7

					if var_482_7 + var_482_3 > arg_479_1.duration_ then
						arg_479_1.duration_ = var_482_7 + var_482_3
					end
				end

				arg_479_1.text_.text = var_482_5
				arg_479_1.typewritter.percent = 0

				arg_479_1.typewritter:SetDirty()
				arg_479_1:ShowNextGo(false)
				arg_479_1:RecordContent(arg_479_1.text_.text)
			end

			local var_482_8 = math.max(var_482_4, arg_479_1.talkMaxDuration)

			if var_482_3 <= arg_479_1.time_ and arg_479_1.time_ < var_482_3 + var_482_8 then
				arg_479_1.typewritter.percent = (arg_479_1.time_ - var_482_3) / var_482_8

				arg_479_1.typewritter:SetDirty()
			end

			if arg_479_1.time_ >= var_482_3 + var_482_8 and arg_479_1.time_ < var_482_3 + var_482_8 + arg_482_0 then
				arg_479_1.typewritter.percent = 1

				arg_479_1.typewritter:SetDirty()
				arg_479_1:ShowNextGo(true)
			end
		end

		arg_479_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_479_1:InitPlayNodeList()
	end,
	Play412031116 = function(arg_483_0, arg_483_1)
		arg_483_1.time_ = 0
		arg_483_1.frameCnt_ = 0
		arg_483_1.state_ = "playing"
		arg_483_1.curTalkId_ = 412031116
		arg_483_1.duration_ = 5.47

		local var_483_0 = {
			zh = 3.933,
			ja = 5.466
		}
		local var_483_1 = manager.audio:GetLocalizationFlag()

		if var_483_0[var_483_1] ~= nil then
			arg_483_1.duration_ = var_483_0[var_483_1]
		end

		SetActive(arg_483_1.tipsGo_, false)

		function arg_483_1.onSingleLineFinish_()
			arg_483_1.onSingleLineUpdate_ = nil
			arg_483_1.onSingleLineFinish_ = nil
			arg_483_1.state_ = "waiting"
		end

		function arg_483_1.playNext_(arg_485_0)
			if arg_485_0 == 1 then
				arg_483_0:Play412031117(arg_483_1)
			end
		end

		function arg_483_1.onSingleLineUpdate_(arg_486_0)
			if 0 < arg_483_1.time_ and arg_483_1.time_ <= 0 + arg_486_0 then
				arg_483_1.var_.moveOldPos10076ui_story = arg_483_1.actors_["10076ui_story"].transform.localPosition
			end

			local var_486_0 = 0.001

			if 0 <= arg_483_1.time_ and arg_483_1.time_ < 0 + var_486_0 then
				arg_483_1.actors_["10076ui_story"].transform.localPosition = Vector3.Lerp(arg_483_1.var_.moveOldPos10076ui_story, Vector3.New(0, -0.35, -4), (arg_483_1.time_ - 0) / var_486_0)
				arg_483_1.actors_["10076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_483_1.actors_["10076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_483_1.actors_["10076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_483_1.actors_["10076ui_story"].transform.position).z)
				arg_483_1.actors_["10076ui_story"].transform.localEulerAngles.z = 0
				arg_483_1.actors_["10076ui_story"].transform.localEulerAngles.x = 0
				arg_483_1.actors_["10076ui_story"].transform.localEulerAngles = arg_483_1.actors_["10076ui_story"].transform.localEulerAngles
			end

			if arg_483_1.time_ >= 0 + var_486_0 and arg_483_1.time_ < 0 + var_486_0 + arg_486_0 then
				arg_483_1.actors_["10076ui_story"].transform.localPosition = Vector3.New(0, -0.35, -4)
				arg_483_1.actors_["10076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_483_1.actors_["10076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_483_1.actors_["10076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_483_1.actors_["10076ui_story"].transform.position).z)
				arg_483_1.actors_["10076ui_story"].transform.localEulerAngles.z = 0
				arg_483_1.actors_["10076ui_story"].transform.localEulerAngles.x = 0
				arg_483_1.actors_["10076ui_story"].transform.localEulerAngles = arg_483_1.actors_["10076ui_story"].transform.localEulerAngles
			end

			local var_486_1 = arg_483_1.actors_["10076ui_story"]

			if 0 < arg_483_1.time_ and arg_483_1.time_ <= 0 + arg_486_0 and not isNil(var_486_1) and arg_483_1.var_.characterEffect10076ui_story == nil then
				arg_483_1.var_.characterEffect10076ui_story = var_486_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_486_2 = 0.200000002980232

			if 0 <= arg_483_1.time_ and arg_483_1.time_ < 0 + var_486_2 and not isNil(var_486_1) then
				if arg_483_1.var_.characterEffect10076ui_story and not isNil(var_486_1) then
					arg_483_1.var_.characterEffect10076ui_story.fillFlat = false
				end
			end

			if arg_483_1.time_ >= 0 + var_486_2 and arg_483_1.time_ < 0 + var_486_2 + arg_486_0 and not isNil(var_486_1) and arg_483_1.var_.characterEffect10076ui_story then
				arg_483_1.var_.characterEffect10076ui_story.fillFlat = false
			end

			if 0 < arg_483_1.time_ and arg_483_1.time_ <= 0 + arg_486_0 then
				arg_483_1:PlayTimeline("10076ui_story", "StoryTimeline/CharAction/story10076/story10076action/10076action1_1")
			end

			if 0 < arg_483_1.time_ and arg_483_1.time_ <= 0 + arg_486_0 then
				arg_483_1:PlayTimeline("10076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_486_4 = 0
			local var_486_5 = 0.5

			if 0 < arg_483_1.time_ and arg_483_1.time_ <= var_486_4 + arg_486_0 then
				arg_483_1.talkMaxDuration = 0
				arg_483_1.dialogCg_.alpha = 1

				arg_483_1.dialog_:SetActive(true)
				SetActive(arg_483_1.leftNameGo_, true)

				arg_483_1.leftNameTxt_.text = arg_483_1:FormatText(StoryNameCfg[917].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_483_1.leftNameTxt_.transform)

				arg_483_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_483_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_483_1:RecordName(arg_483_1.leftNameTxt_.text)
				SetActive(arg_483_1.iconTrs_.gameObject, false)
				arg_483_1.callingController_:SetSelectedState("normal")

				local var_486_6 = arg_483_1:GetWordFromCfg(412031116)
				local var_486_7 = arg_483_1:FormatText(var_486_6.content)

				arg_483_1.text_.text = var_486_7

				LuaForUtil.ClearLinePrefixSymbol(arg_483_1.text_)

				local var_486_9 = 20 <= 0 and var_486_5 or var_486_5 * (utf8.len(var_486_7) / 20)

				if (20 <= 0 and var_486_5 or var_486_5 * (utf8.len(var_486_7) / 20)) > 0 and var_486_5 < var_486_9 then
					arg_483_1.talkMaxDuration = var_486_9

					if var_486_9 + var_486_4 > arg_483_1.duration_ then
						arg_483_1.duration_ = var_486_9 + var_486_4
					end
				end

				arg_483_1.text_.text = var_486_7
				arg_483_1.typewritter.percent = 0

				arg_483_1.typewritter:SetDirty()
				arg_483_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031116", "story_v_out_412031.awb") ~= 0 then
					local var_486_10 = manager.audio:GetVoiceLength("story_v_out_412031", "412031116", "story_v_out_412031.awb") / 1000

					if var_486_10 + var_486_4 > arg_483_1.duration_ then
						arg_483_1.duration_ = var_486_10 + var_486_4
					end

					if var_486_6.prefab_name ~= "" and arg_483_1.actors_[var_486_6.prefab_name] ~= nil then
						local var_486_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_483_1.actors_[var_486_6.prefab_name].transform, "story_v_out_412031", "412031116", "story_v_out_412031.awb")

						arg_483_1:RecordAudio("412031116", var_486_11)
						arg_483_1:RecordAudio("412031116", var_486_11)
					else
						arg_483_1:AudioAction("play", "voice", "story_v_out_412031", "412031116", "story_v_out_412031.awb")
					end

					arg_483_1:RecordHistoryTalkVoice("story_v_out_412031", "412031116", "story_v_out_412031.awb")
				end

				arg_483_1:RecordContent(arg_483_1.text_.text)
			end

			local var_486_12 = math.max(var_486_5, arg_483_1.talkMaxDuration)

			if var_486_4 <= arg_483_1.time_ and arg_483_1.time_ < var_486_4 + var_486_12 then
				arg_483_1.typewritter.percent = (arg_483_1.time_ - var_486_4) / var_486_12

				arg_483_1.typewritter:SetDirty()
			end

			if arg_483_1.time_ >= var_486_4 + var_486_12 and arg_483_1.time_ < var_486_4 + var_486_12 + arg_486_0 then
				arg_483_1.typewritter.percent = 1

				arg_483_1.typewritter:SetDirty()
				arg_483_1:ShowNextGo(true)
			end
		end

		arg_483_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_483_1:InitPlayNodeList()
	end,
	Play412031117 = function(arg_487_0, arg_487_1)
		arg_487_1.time_ = 0
		arg_487_1.frameCnt_ = 0
		arg_487_1.state_ = "playing"
		arg_487_1.curTalkId_ = 412031117
		arg_487_1.duration_ = 8.8

		local var_487_0 = {
			zh = 6.066,
			ja = 8.8
		}
		local var_487_1 = manager.audio:GetLocalizationFlag()

		if var_487_0[var_487_1] ~= nil then
			arg_487_1.duration_ = var_487_0[var_487_1]
		end

		SetActive(arg_487_1.tipsGo_, false)

		function arg_487_1.onSingleLineFinish_()
			arg_487_1.onSingleLineUpdate_ = nil
			arg_487_1.onSingleLineFinish_ = nil
			arg_487_1.state_ = "waiting"
		end

		function arg_487_1.playNext_(arg_489_0)
			if arg_489_0 == 1 then
				arg_487_0:Play412031118(arg_487_1)
			end
		end

		function arg_487_1.onSingleLineUpdate_(arg_490_0)
			local var_490_0 = 0.85

			if 0 < arg_487_1.time_ and arg_487_1.time_ <= 0 + arg_490_0 then
				arg_487_1.talkMaxDuration = 0
				arg_487_1.dialogCg_.alpha = 1

				arg_487_1.dialog_:SetActive(true)
				SetActive(arg_487_1.leftNameGo_, true)

				arg_487_1.leftNameTxt_.text = arg_487_1:FormatText(StoryNameCfg[917].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_487_1.leftNameTxt_.transform)

				arg_487_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_487_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_487_1:RecordName(arg_487_1.leftNameTxt_.text)
				SetActive(arg_487_1.iconTrs_.gameObject, false)
				arg_487_1.callingController_:SetSelectedState("normal")

				local var_490_1 = arg_487_1:GetWordFromCfg(412031117)
				local var_490_2 = arg_487_1:FormatText(var_490_1.content)

				arg_487_1.text_.text = var_490_2

				LuaForUtil.ClearLinePrefixSymbol(arg_487_1.text_)

				local var_490_4 = 34 <= 0 and var_490_0 or var_490_0 * (utf8.len(var_490_2) / 34)

				if (34 <= 0 and var_490_0 or var_490_0 * (utf8.len(var_490_2) / 34)) > 0 and var_490_0 < var_490_4 then
					arg_487_1.talkMaxDuration = var_490_4

					if var_490_4 + 0 > arg_487_1.duration_ then
						arg_487_1.duration_ = var_490_4 + 0
					end
				end

				arg_487_1.text_.text = var_490_2
				arg_487_1.typewritter.percent = 0

				arg_487_1.typewritter:SetDirty()
				arg_487_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031117", "story_v_out_412031.awb") ~= 0 then
					local var_490_5 = manager.audio:GetVoiceLength("story_v_out_412031", "412031117", "story_v_out_412031.awb") / 1000

					if var_490_5 + 0 > arg_487_1.duration_ then
						arg_487_1.duration_ = var_490_5 + 0
					end

					if var_490_1.prefab_name ~= "" and arg_487_1.actors_[var_490_1.prefab_name] ~= nil then
						local var_490_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_487_1.actors_[var_490_1.prefab_name].transform, "story_v_out_412031", "412031117", "story_v_out_412031.awb")

						arg_487_1:RecordAudio("412031117", var_490_6)
						arg_487_1:RecordAudio("412031117", var_490_6)
					else
						arg_487_1:AudioAction("play", "voice", "story_v_out_412031", "412031117", "story_v_out_412031.awb")
					end

					arg_487_1:RecordHistoryTalkVoice("story_v_out_412031", "412031117", "story_v_out_412031.awb")
				end

				arg_487_1:RecordContent(arg_487_1.text_.text)
			end

			local var_490_7 = math.max(var_490_0, arg_487_1.talkMaxDuration)

			if 0 <= arg_487_1.time_ and arg_487_1.time_ < 0 + var_490_7 then
				arg_487_1.typewritter.percent = (arg_487_1.time_ - 0) / var_490_7

				arg_487_1.typewritter:SetDirty()
			end

			if arg_487_1.time_ >= 0 + var_490_7 and arg_487_1.time_ < 0 + var_490_7 + arg_490_0 then
				arg_487_1.typewritter.percent = 1

				arg_487_1.typewritter:SetDirty()
				arg_487_1:ShowNextGo(true)
			end
		end

		arg_487_1.nodeConfigList_ = {}

		arg_487_1:InitPlayNodeList()
	end,
	Play412031118 = function(arg_491_0, arg_491_1)
		arg_491_1.time_ = 0
		arg_491_1.frameCnt_ = 0
		arg_491_1.state_ = "playing"
		arg_491_1.curTalkId_ = 412031118
		arg_491_1.duration_ = 11.37

		local var_491_0 = {
			zh = 11.366,
			ja = 8.633
		}
		local var_491_1 = manager.audio:GetLocalizationFlag()

		if var_491_0[var_491_1] ~= nil then
			arg_491_1.duration_ = var_491_0[var_491_1]
		end

		SetActive(arg_491_1.tipsGo_, false)

		function arg_491_1.onSingleLineFinish_()
			arg_491_1.onSingleLineUpdate_ = nil
			arg_491_1.onSingleLineFinish_ = nil
			arg_491_1.state_ = "waiting"
		end

		function arg_491_1.playNext_(arg_493_0)
			if arg_493_0 == 1 then
				arg_491_0:Play412031119(arg_491_1)
			end
		end

		function arg_491_1.onSingleLineUpdate_(arg_494_0)
			local var_494_0 = 1.425

			if 0 < arg_491_1.time_ and arg_491_1.time_ <= 0 + arg_494_0 then
				arg_491_1.talkMaxDuration = 0
				arg_491_1.dialogCg_.alpha = 1

				arg_491_1.dialog_:SetActive(true)
				SetActive(arg_491_1.leftNameGo_, true)

				arg_491_1.leftNameTxt_.text = arg_491_1:FormatText(StoryNameCfg[917].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_491_1.leftNameTxt_.transform)

				arg_491_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_491_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_491_1:RecordName(arg_491_1.leftNameTxt_.text)
				SetActive(arg_491_1.iconTrs_.gameObject, false)
				arg_491_1.callingController_:SetSelectedState("normal")

				local var_494_1 = arg_491_1:GetWordFromCfg(412031118)
				local var_494_2 = arg_491_1:FormatText(var_494_1.content)

				arg_491_1.text_.text = var_494_2

				LuaForUtil.ClearLinePrefixSymbol(arg_491_1.text_)

				local var_494_4 = 57 <= 0 and var_494_0 or var_494_0 * (utf8.len(var_494_2) / 57)

				if (57 <= 0 and var_494_0 or var_494_0 * (utf8.len(var_494_2) / 57)) > 0 and var_494_0 < var_494_4 then
					arg_491_1.talkMaxDuration = var_494_4

					if var_494_4 + 0 > arg_491_1.duration_ then
						arg_491_1.duration_ = var_494_4 + 0
					end
				end

				arg_491_1.text_.text = var_494_2
				arg_491_1.typewritter.percent = 0

				arg_491_1.typewritter:SetDirty()
				arg_491_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031118", "story_v_out_412031.awb") ~= 0 then
					local var_494_5 = manager.audio:GetVoiceLength("story_v_out_412031", "412031118", "story_v_out_412031.awb") / 1000

					if var_494_5 + 0 > arg_491_1.duration_ then
						arg_491_1.duration_ = var_494_5 + 0
					end

					if var_494_1.prefab_name ~= "" and arg_491_1.actors_[var_494_1.prefab_name] ~= nil then
						local var_494_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_491_1.actors_[var_494_1.prefab_name].transform, "story_v_out_412031", "412031118", "story_v_out_412031.awb")

						arg_491_1:RecordAudio("412031118", var_494_6)
						arg_491_1:RecordAudio("412031118", var_494_6)
					else
						arg_491_1:AudioAction("play", "voice", "story_v_out_412031", "412031118", "story_v_out_412031.awb")
					end

					arg_491_1:RecordHistoryTalkVoice("story_v_out_412031", "412031118", "story_v_out_412031.awb")
				end

				arg_491_1:RecordContent(arg_491_1.text_.text)
			end

			local var_494_7 = math.max(var_494_0, arg_491_1.talkMaxDuration)

			if 0 <= arg_491_1.time_ and arg_491_1.time_ < 0 + var_494_7 then
				arg_491_1.typewritter.percent = (arg_491_1.time_ - 0) / var_494_7

				arg_491_1.typewritter:SetDirty()
			end

			if arg_491_1.time_ >= 0 + var_494_7 and arg_491_1.time_ < 0 + var_494_7 + arg_494_0 then
				arg_491_1.typewritter.percent = 1

				arg_491_1.typewritter:SetDirty()
				arg_491_1:ShowNextGo(true)
			end
		end

		arg_491_1.nodeConfigList_ = {}

		arg_491_1:InitPlayNodeList()
	end,
	Play412031119 = function(arg_495_0, arg_495_1)
		arg_495_1.time_ = 0
		arg_495_1.frameCnt_ = 0
		arg_495_1.state_ = "playing"
		arg_495_1.curTalkId_ = 412031119
		arg_495_1.duration_ = 4.8

		local var_495_0 = {
			zh = 4.8,
			ja = 3.133
		}
		local var_495_1 = manager.audio:GetLocalizationFlag()

		if var_495_0[var_495_1] ~= nil then
			arg_495_1.duration_ = var_495_0[var_495_1]
		end

		SetActive(arg_495_1.tipsGo_, false)

		function arg_495_1.onSingleLineFinish_()
			arg_495_1.onSingleLineUpdate_ = nil
			arg_495_1.onSingleLineFinish_ = nil
			arg_495_1.state_ = "waiting"
		end

		function arg_495_1.playNext_(arg_497_0)
			if arg_497_0 == 1 then
				arg_495_0:Play412031120(arg_495_1)
			end
		end

		function arg_495_1.onSingleLineUpdate_(arg_498_0)
			if 0 < arg_495_1.time_ and arg_495_1.time_ <= 0 + arg_498_0 then
				arg_495_1.var_.moveOldPos3043ui_story = arg_495_1.actors_["3043ui_story"].transform.localPosition
			end

			local var_498_0 = 0.001

			if 0 <= arg_495_1.time_ and arg_495_1.time_ < 0 + var_498_0 then
				arg_495_1.actors_["3043ui_story"].transform.localPosition = Vector3.Lerp(arg_495_1.var_.moveOldPos3043ui_story, Vector3.New(0, -1.41, -5.7), (arg_495_1.time_ - 0) / var_498_0)
				arg_495_1.actors_["3043ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_495_1.actors_["3043ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_495_1.actors_["3043ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_495_1.actors_["3043ui_story"].transform.position).z)
				arg_495_1.actors_["3043ui_story"].transform.localEulerAngles.z = 0
				arg_495_1.actors_["3043ui_story"].transform.localEulerAngles.x = 0
				arg_495_1.actors_["3043ui_story"].transform.localEulerAngles = arg_495_1.actors_["3043ui_story"].transform.localEulerAngles
			end

			if arg_495_1.time_ >= 0 + var_498_0 and arg_495_1.time_ < 0 + var_498_0 + arg_498_0 then
				arg_495_1.actors_["3043ui_story"].transform.localPosition = Vector3.New(0, -1.41, -5.7)
				arg_495_1.actors_["3043ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_495_1.actors_["3043ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_495_1.actors_["3043ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_495_1.actors_["3043ui_story"].transform.position).z)
				arg_495_1.actors_["3043ui_story"].transform.localEulerAngles.z = 0
				arg_495_1.actors_["3043ui_story"].transform.localEulerAngles.x = 0
				arg_495_1.actors_["3043ui_story"].transform.localEulerAngles = arg_495_1.actors_["3043ui_story"].transform.localEulerAngles
			end

			local var_498_1 = arg_495_1.actors_["3043ui_story"]

			if 0 < arg_495_1.time_ and arg_495_1.time_ <= 0 + arg_498_0 and not isNil(var_498_1) and arg_495_1.var_.characterEffect3043ui_story == nil then
				arg_495_1.var_.characterEffect3043ui_story = var_498_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_498_2 = 0.200000002980232

			if 0 <= arg_495_1.time_ and arg_495_1.time_ < 0 + var_498_2 and not isNil(var_498_1) then
				if arg_495_1.var_.characterEffect3043ui_story and not isNil(var_498_1) then
					arg_495_1.var_.characterEffect3043ui_story.fillFlat = false
				end
			end

			if arg_495_1.time_ >= 0 + var_498_2 and arg_495_1.time_ < 0 + var_498_2 + arg_498_0 and not isNil(var_498_1) and arg_495_1.var_.characterEffect3043ui_story then
				arg_495_1.var_.characterEffect3043ui_story.fillFlat = false
			end

			if 0 < arg_495_1.time_ and arg_495_1.time_ <= 0 + arg_498_0 then
				arg_495_1:PlayTimeline("3043ui_story", "StoryTimeline/CharAction/story3043/story3043action/3043action1_1")
			end

			if 0 < arg_495_1.time_ and arg_495_1.time_ <= 0 + arg_498_0 then
				arg_495_1:PlayTimeline("3043ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_498_4 = arg_495_1.actors_["10076ui_story"].transform

			if 0 < arg_495_1.time_ and arg_495_1.time_ <= 0 + arg_498_0 then
				arg_495_1.var_.moveOldPos10076ui_story = var_498_4.localPosition
			end

			local var_498_5 = 0.001

			if 0 <= arg_495_1.time_ and arg_495_1.time_ < 0 + var_498_5 then
				var_498_4.localPosition = Vector3.Lerp(arg_495_1.var_.moveOldPos10076ui_story, Vector3.New(0, 100, 0), (arg_495_1.time_ - 0) / var_498_5)
				var_498_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_498_4.position).x, (manager.ui.mainCamera.transform.position - var_498_4.position).y, (manager.ui.mainCamera.transform.position - var_498_4.position).z)
				var_498_4.localEulerAngles.z = 0
				var_498_4.localEulerAngles.x = 0
				var_498_4.localEulerAngles = var_498_4.localEulerAngles
			end

			if arg_495_1.time_ >= 0 + var_498_5 and arg_495_1.time_ < 0 + var_498_5 + arg_498_0 then
				var_498_4.localPosition = Vector3.New(0, 100, 0)
				var_498_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_498_4.position).x, (manager.ui.mainCamera.transform.position - var_498_4.position).y, (manager.ui.mainCamera.transform.position - var_498_4.position).z)
				var_498_4.localEulerAngles.z = 0
				var_498_4.localEulerAngles.x = 0
				var_498_4.localEulerAngles = var_498_4.localEulerAngles
			end

			local var_498_6 = arg_495_1.actors_["10076ui_story"]

			if 0 < arg_495_1.time_ and arg_495_1.time_ <= 0 + arg_498_0 and not isNil(var_498_6) and arg_495_1.var_.characterEffect10076ui_story == nil then
				arg_495_1.var_.characterEffect10076ui_story = var_498_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_498_7 = 0.200000002980232

			if 0 <= arg_495_1.time_ and arg_495_1.time_ < 0 + var_498_7 and not isNil(var_498_6) then
				if arg_495_1.var_.characterEffect10076ui_story and not isNil(var_498_6) then
					arg_495_1.var_.characterEffect10076ui_story.fillFlat = true
					arg_495_1.var_.characterEffect10076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_495_1.time_ - 0) / var_498_7)
				end
			end

			if arg_495_1.time_ >= 0 + var_498_7 and arg_495_1.time_ < 0 + var_498_7 + arg_498_0 and not isNil(var_498_6) and arg_495_1.var_.characterEffect10076ui_story then
				arg_495_1.var_.characterEffect10076ui_story.fillFlat = true
				arg_495_1.var_.characterEffect10076ui_story.fillRatio = 0.5
			end

			local var_498_8 = 0
			local var_498_9 = 0.525

			if 0 < arg_495_1.time_ and arg_495_1.time_ <= var_498_8 + arg_498_0 then
				arg_495_1.talkMaxDuration = 0
				arg_495_1.dialogCg_.alpha = 1

				arg_495_1.dialog_:SetActive(true)
				SetActive(arg_495_1.leftNameGo_, true)

				arg_495_1.leftNameTxt_.text = arg_495_1:FormatText(StoryNameCfg[920].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_495_1.leftNameTxt_.transform)

				arg_495_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_495_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_495_1:RecordName(arg_495_1.leftNameTxt_.text)
				SetActive(arg_495_1.iconTrs_.gameObject, false)
				arg_495_1.callingController_:SetSelectedState("normal")

				local var_498_10 = arg_495_1:GetWordFromCfg(412031119)
				local var_498_11 = arg_495_1:FormatText(var_498_10.content)

				arg_495_1.text_.text = var_498_11

				LuaForUtil.ClearLinePrefixSymbol(arg_495_1.text_)

				local var_498_13 = 21 <= 0 and var_498_9 or var_498_9 * (utf8.len(var_498_11) / 21)

				if (21 <= 0 and var_498_9 or var_498_9 * (utf8.len(var_498_11) / 21)) > 0 and var_498_9 < var_498_13 then
					arg_495_1.talkMaxDuration = var_498_13

					if var_498_13 + var_498_8 > arg_495_1.duration_ then
						arg_495_1.duration_ = var_498_13 + var_498_8
					end
				end

				arg_495_1.text_.text = var_498_11
				arg_495_1.typewritter.percent = 0

				arg_495_1.typewritter:SetDirty()
				arg_495_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031119", "story_v_out_412031.awb") ~= 0 then
					local var_498_14 = manager.audio:GetVoiceLength("story_v_out_412031", "412031119", "story_v_out_412031.awb") / 1000

					if var_498_14 + var_498_8 > arg_495_1.duration_ then
						arg_495_1.duration_ = var_498_14 + var_498_8
					end

					if var_498_10.prefab_name ~= "" and arg_495_1.actors_[var_498_10.prefab_name] ~= nil then
						local var_498_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_495_1.actors_[var_498_10.prefab_name].transform, "story_v_out_412031", "412031119", "story_v_out_412031.awb")

						arg_495_1:RecordAudio("412031119", var_498_15)
						arg_495_1:RecordAudio("412031119", var_498_15)
					else
						arg_495_1:AudioAction("play", "voice", "story_v_out_412031", "412031119", "story_v_out_412031.awb")
					end

					arg_495_1:RecordHistoryTalkVoice("story_v_out_412031", "412031119", "story_v_out_412031.awb")
				end

				arg_495_1:RecordContent(arg_495_1.text_.text)
			end

			local var_498_16 = math.max(var_498_9, arg_495_1.talkMaxDuration)

			if var_498_8 <= arg_495_1.time_ and arg_495_1.time_ < var_498_8 + var_498_16 then
				arg_495_1.typewritter.percent = (arg_495_1.time_ - var_498_8) / var_498_16

				arg_495_1.typewritter:SetDirty()
			end

			if arg_495_1.time_ >= var_498_8 + var_498_16 and arg_495_1.time_ < var_498_8 + var_498_16 + arg_498_0 then
				arg_495_1.typewritter.percent = 1

				arg_495_1.typewritter:SetDirty()
				arg_495_1:ShowNextGo(true)
			end
		end

		arg_495_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_495_1:InitPlayNodeList()
	end,
	Play412031120 = function(arg_499_0, arg_499_1)
		arg_499_1.time_ = 0
		arg_499_1.frameCnt_ = 0
		arg_499_1.state_ = "playing"
		arg_499_1.curTalkId_ = 412031120
		arg_499_1.duration_ = 6.67

		local var_499_0 = {
			zh = 2.7,
			ja = 6.666
		}
		local var_499_1 = manager.audio:GetLocalizationFlag()

		if var_499_0[var_499_1] ~= nil then
			arg_499_1.duration_ = var_499_0[var_499_1]
		end

		SetActive(arg_499_1.tipsGo_, false)

		function arg_499_1.onSingleLineFinish_()
			arg_499_1.onSingleLineUpdate_ = nil
			arg_499_1.onSingleLineFinish_ = nil
			arg_499_1.state_ = "waiting"
		end

		function arg_499_1.playNext_(arg_501_0)
			if arg_501_0 == 1 then
				arg_499_0:Play412031121(arg_499_1)
			end
		end

		function arg_499_1.onSingleLineUpdate_(arg_502_0)
			if 0 < arg_499_1.time_ and arg_499_1.time_ <= 0 + arg_502_0 then
				arg_499_1.var_.moveOldPos10076ui_story = arg_499_1.actors_["10076ui_story"].transform.localPosition
			end

			local var_502_0 = 0.001

			if 0 <= arg_499_1.time_ and arg_499_1.time_ < 0 + var_502_0 then
				arg_499_1.actors_["10076ui_story"].transform.localPosition = Vector3.Lerp(arg_499_1.var_.moveOldPos10076ui_story, Vector3.New(0, -0.35, -4), (arg_499_1.time_ - 0) / var_502_0)
				arg_499_1.actors_["10076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_499_1.actors_["10076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_499_1.actors_["10076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_499_1.actors_["10076ui_story"].transform.position).z)
				arg_499_1.actors_["10076ui_story"].transform.localEulerAngles.z = 0
				arg_499_1.actors_["10076ui_story"].transform.localEulerAngles.x = 0
				arg_499_1.actors_["10076ui_story"].transform.localEulerAngles = arg_499_1.actors_["10076ui_story"].transform.localEulerAngles
			end

			if arg_499_1.time_ >= 0 + var_502_0 and arg_499_1.time_ < 0 + var_502_0 + arg_502_0 then
				arg_499_1.actors_["10076ui_story"].transform.localPosition = Vector3.New(0, -0.35, -4)
				arg_499_1.actors_["10076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_499_1.actors_["10076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_499_1.actors_["10076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_499_1.actors_["10076ui_story"].transform.position).z)
				arg_499_1.actors_["10076ui_story"].transform.localEulerAngles.z = 0
				arg_499_1.actors_["10076ui_story"].transform.localEulerAngles.x = 0
				arg_499_1.actors_["10076ui_story"].transform.localEulerAngles = arg_499_1.actors_["10076ui_story"].transform.localEulerAngles
			end

			local var_502_1 = arg_499_1.actors_["10076ui_story"]

			if 0 < arg_499_1.time_ and arg_499_1.time_ <= 0 + arg_502_0 and not isNil(var_502_1) and arg_499_1.var_.characterEffect10076ui_story == nil then
				arg_499_1.var_.characterEffect10076ui_story = var_502_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_502_2 = 0.200000002980232

			if 0 <= arg_499_1.time_ and arg_499_1.time_ < 0 + var_502_2 and not isNil(var_502_1) then
				if arg_499_1.var_.characterEffect10076ui_story and not isNil(var_502_1) then
					arg_499_1.var_.characterEffect10076ui_story.fillFlat = false
				end
			end

			if arg_499_1.time_ >= 0 + var_502_2 and arg_499_1.time_ < 0 + var_502_2 + arg_502_0 and not isNil(var_502_1) and arg_499_1.var_.characterEffect10076ui_story then
				arg_499_1.var_.characterEffect10076ui_story.fillFlat = false
			end

			if 0 < arg_499_1.time_ and arg_499_1.time_ <= 0 + arg_502_0 then
				arg_499_1:PlayTimeline("10076ui_story", "StoryTimeline/CharAction/story10076/story10076action/10076action2_1")
			end

			if 0 < arg_499_1.time_ and arg_499_1.time_ <= 0 + arg_502_0 then
				arg_499_1:PlayTimeline("10076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_502_4 = arg_499_1.actors_["3043ui_story"].transform

			if 0 < arg_499_1.time_ and arg_499_1.time_ <= 0 + arg_502_0 then
				arg_499_1.var_.moveOldPos3043ui_story = var_502_4.localPosition
			end

			local var_502_5 = 0.001

			if 0 <= arg_499_1.time_ and arg_499_1.time_ < 0 + var_502_5 then
				var_502_4.localPosition = Vector3.Lerp(arg_499_1.var_.moveOldPos3043ui_story, Vector3.New(0, 100, 0), (arg_499_1.time_ - 0) / var_502_5)
				var_502_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_502_4.position).x, (manager.ui.mainCamera.transform.position - var_502_4.position).y, (manager.ui.mainCamera.transform.position - var_502_4.position).z)
				var_502_4.localEulerAngles.z = 0
				var_502_4.localEulerAngles.x = 0
				var_502_4.localEulerAngles = var_502_4.localEulerAngles
			end

			if arg_499_1.time_ >= 0 + var_502_5 and arg_499_1.time_ < 0 + var_502_5 + arg_502_0 then
				var_502_4.localPosition = Vector3.New(0, 100, 0)
				var_502_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_502_4.position).x, (manager.ui.mainCamera.transform.position - var_502_4.position).y, (manager.ui.mainCamera.transform.position - var_502_4.position).z)
				var_502_4.localEulerAngles.z = 0
				var_502_4.localEulerAngles.x = 0
				var_502_4.localEulerAngles = var_502_4.localEulerAngles
			end

			local var_502_6 = arg_499_1.actors_["3043ui_story"]

			if 0 < arg_499_1.time_ and arg_499_1.time_ <= 0 + arg_502_0 and not isNil(var_502_6) and arg_499_1.var_.characterEffect3043ui_story == nil then
				arg_499_1.var_.characterEffect3043ui_story = var_502_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_502_7 = 0.200000002980232

			if 0 <= arg_499_1.time_ and arg_499_1.time_ < 0 + var_502_7 and not isNil(var_502_6) then
				if arg_499_1.var_.characterEffect3043ui_story and not isNil(var_502_6) then
					arg_499_1.var_.characterEffect3043ui_story.fillFlat = true
					arg_499_1.var_.characterEffect3043ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_499_1.time_ - 0) / var_502_7)
				end
			end

			if arg_499_1.time_ >= 0 + var_502_7 and arg_499_1.time_ < 0 + var_502_7 + arg_502_0 and not isNil(var_502_6) and arg_499_1.var_.characterEffect3043ui_story then
				arg_499_1.var_.characterEffect3043ui_story.fillFlat = true
				arg_499_1.var_.characterEffect3043ui_story.fillRatio = 0.5
			end

			local var_502_8 = 0
			local var_502_9 = 0.35

			if 0 < arg_499_1.time_ and arg_499_1.time_ <= var_502_8 + arg_502_0 then
				arg_499_1.talkMaxDuration = 0
				arg_499_1.dialogCg_.alpha = 1

				arg_499_1.dialog_:SetActive(true)
				SetActive(arg_499_1.leftNameGo_, true)

				arg_499_1.leftNameTxt_.text = arg_499_1:FormatText(StoryNameCfg[917].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_499_1.leftNameTxt_.transform)

				arg_499_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_499_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_499_1:RecordName(arg_499_1.leftNameTxt_.text)
				SetActive(arg_499_1.iconTrs_.gameObject, false)
				arg_499_1.callingController_:SetSelectedState("normal")

				local var_502_10 = arg_499_1:GetWordFromCfg(412031120)
				local var_502_11 = arg_499_1:FormatText(var_502_10.content)

				arg_499_1.text_.text = var_502_11

				LuaForUtil.ClearLinePrefixSymbol(arg_499_1.text_)

				local var_502_13 = 14 <= 0 and var_502_9 or var_502_9 * (utf8.len(var_502_11) / 14)

				if (14 <= 0 and var_502_9 or var_502_9 * (utf8.len(var_502_11) / 14)) > 0 and var_502_9 < var_502_13 then
					arg_499_1.talkMaxDuration = var_502_13

					if var_502_13 + var_502_8 > arg_499_1.duration_ then
						arg_499_1.duration_ = var_502_13 + var_502_8
					end
				end

				arg_499_1.text_.text = var_502_11
				arg_499_1.typewritter.percent = 0

				arg_499_1.typewritter:SetDirty()
				arg_499_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031120", "story_v_out_412031.awb") ~= 0 then
					local var_502_14 = manager.audio:GetVoiceLength("story_v_out_412031", "412031120", "story_v_out_412031.awb") / 1000

					if var_502_14 + var_502_8 > arg_499_1.duration_ then
						arg_499_1.duration_ = var_502_14 + var_502_8
					end

					if var_502_10.prefab_name ~= "" and arg_499_1.actors_[var_502_10.prefab_name] ~= nil then
						local var_502_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_499_1.actors_[var_502_10.prefab_name].transform, "story_v_out_412031", "412031120", "story_v_out_412031.awb")

						arg_499_1:RecordAudio("412031120", var_502_15)
						arg_499_1:RecordAudio("412031120", var_502_15)
					else
						arg_499_1:AudioAction("play", "voice", "story_v_out_412031", "412031120", "story_v_out_412031.awb")
					end

					arg_499_1:RecordHistoryTalkVoice("story_v_out_412031", "412031120", "story_v_out_412031.awb")
				end

				arg_499_1:RecordContent(arg_499_1.text_.text)
			end

			local var_502_16 = math.max(var_502_9, arg_499_1.talkMaxDuration)

			if var_502_8 <= arg_499_1.time_ and arg_499_1.time_ < var_502_8 + var_502_16 then
				arg_499_1.typewritter.percent = (arg_499_1.time_ - var_502_8) / var_502_16

				arg_499_1.typewritter:SetDirty()
			end

			if arg_499_1.time_ >= var_502_8 + var_502_16 and arg_499_1.time_ < var_502_8 + var_502_16 + arg_502_0 then
				arg_499_1.typewritter.percent = 1

				arg_499_1.typewritter:SetDirty()
				arg_499_1:ShowNextGo(true)
			end
		end

		arg_499_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "3043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_499_1:InitPlayNodeList()
	end,
	Play412031121 = function(arg_503_0, arg_503_1)
		arg_503_1.time_ = 0
		arg_503_1.frameCnt_ = 0
		arg_503_1.state_ = "playing"
		arg_503_1.curTalkId_ = 412031121
		arg_503_1.duration_ = 4.13

		local var_503_0 = {
			zh = 4.133,
			ja = 2.7
		}
		local var_503_1 = manager.audio:GetLocalizationFlag()

		if var_503_0[var_503_1] ~= nil then
			arg_503_1.duration_ = var_503_0[var_503_1]
		end

		SetActive(arg_503_1.tipsGo_, false)

		function arg_503_1.onSingleLineFinish_()
			arg_503_1.onSingleLineUpdate_ = nil
			arg_503_1.onSingleLineFinish_ = nil
			arg_503_1.state_ = "waiting"
		end

		function arg_503_1.playNext_(arg_505_0)
			if arg_505_0 == 1 then
				arg_503_0:Play412031122(arg_503_1)
			end
		end

		function arg_503_1.onSingleLineUpdate_(arg_506_0)
			if 0 < arg_503_1.time_ and arg_503_1.time_ <= 0 + arg_506_0 then
				arg_503_1.var_.moveOldPos3043ui_story = arg_503_1.actors_["3043ui_story"].transform.localPosition
			end

			local var_506_0 = 0.001

			if 0 <= arg_503_1.time_ and arg_503_1.time_ < 0 + var_506_0 then
				arg_503_1.actors_["3043ui_story"].transform.localPosition = Vector3.Lerp(arg_503_1.var_.moveOldPos3043ui_story, Vector3.New(0, -1.41, -5.7), (arg_503_1.time_ - 0) / var_506_0)
				arg_503_1.actors_["3043ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_503_1.actors_["3043ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_503_1.actors_["3043ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_503_1.actors_["3043ui_story"].transform.position).z)
				arg_503_1.actors_["3043ui_story"].transform.localEulerAngles.z = 0
				arg_503_1.actors_["3043ui_story"].transform.localEulerAngles.x = 0
				arg_503_1.actors_["3043ui_story"].transform.localEulerAngles = arg_503_1.actors_["3043ui_story"].transform.localEulerAngles
			end

			if arg_503_1.time_ >= 0 + var_506_0 and arg_503_1.time_ < 0 + var_506_0 + arg_506_0 then
				arg_503_1.actors_["3043ui_story"].transform.localPosition = Vector3.New(0, -1.41, -5.7)
				arg_503_1.actors_["3043ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_503_1.actors_["3043ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_503_1.actors_["3043ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_503_1.actors_["3043ui_story"].transform.position).z)
				arg_503_1.actors_["3043ui_story"].transform.localEulerAngles.z = 0
				arg_503_1.actors_["3043ui_story"].transform.localEulerAngles.x = 0
				arg_503_1.actors_["3043ui_story"].transform.localEulerAngles = arg_503_1.actors_["3043ui_story"].transform.localEulerAngles
			end

			local var_506_1 = arg_503_1.actors_["3043ui_story"]

			if 0 < arg_503_1.time_ and arg_503_1.time_ <= 0 + arg_506_0 and not isNil(var_506_1) and arg_503_1.var_.characterEffect3043ui_story == nil then
				arg_503_1.var_.characterEffect3043ui_story = var_506_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_506_2 = 0.200000002980232

			if 0 <= arg_503_1.time_ and arg_503_1.time_ < 0 + var_506_2 and not isNil(var_506_1) then
				if arg_503_1.var_.characterEffect3043ui_story and not isNil(var_506_1) then
					arg_503_1.var_.characterEffect3043ui_story.fillFlat = false
				end
			end

			if arg_503_1.time_ >= 0 + var_506_2 and arg_503_1.time_ < 0 + var_506_2 + arg_506_0 and not isNil(var_506_1) and arg_503_1.var_.characterEffect3043ui_story then
				arg_503_1.var_.characterEffect3043ui_story.fillFlat = false
			end

			if 0 < arg_503_1.time_ and arg_503_1.time_ <= 0 + arg_506_0 then
				arg_503_1:PlayTimeline("3043ui_story", "StoryTimeline/CharAction/story3043/story3043action/3043action1_1")
			end

			if 0 < arg_503_1.time_ and arg_503_1.time_ <= 0 + arg_506_0 then
				arg_503_1:PlayTimeline("3043ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_506_4 = arg_503_1.actors_["10076ui_story"].transform

			if 0 < arg_503_1.time_ and arg_503_1.time_ <= 0 + arg_506_0 then
				arg_503_1.var_.moveOldPos10076ui_story = var_506_4.localPosition
			end

			local var_506_5 = 0.001

			if 0 <= arg_503_1.time_ and arg_503_1.time_ < 0 + var_506_5 then
				var_506_4.localPosition = Vector3.Lerp(arg_503_1.var_.moveOldPos10076ui_story, Vector3.New(0, 100, 0), (arg_503_1.time_ - 0) / var_506_5)
				var_506_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_506_4.position).x, (manager.ui.mainCamera.transform.position - var_506_4.position).y, (manager.ui.mainCamera.transform.position - var_506_4.position).z)
				var_506_4.localEulerAngles.z = 0
				var_506_4.localEulerAngles.x = 0
				var_506_4.localEulerAngles = var_506_4.localEulerAngles
			end

			if arg_503_1.time_ >= 0 + var_506_5 and arg_503_1.time_ < 0 + var_506_5 + arg_506_0 then
				var_506_4.localPosition = Vector3.New(0, 100, 0)
				var_506_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_506_4.position).x, (manager.ui.mainCamera.transform.position - var_506_4.position).y, (manager.ui.mainCamera.transform.position - var_506_4.position).z)
				var_506_4.localEulerAngles.z = 0
				var_506_4.localEulerAngles.x = 0
				var_506_4.localEulerAngles = var_506_4.localEulerAngles
			end

			local var_506_6 = arg_503_1.actors_["10076ui_story"]

			if 0 < arg_503_1.time_ and arg_503_1.time_ <= 0 + arg_506_0 and not isNil(var_506_6) and arg_503_1.var_.characterEffect10076ui_story == nil then
				arg_503_1.var_.characterEffect10076ui_story = var_506_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_506_7 = 0.200000002980232

			if 0 <= arg_503_1.time_ and arg_503_1.time_ < 0 + var_506_7 and not isNil(var_506_6) then
				if arg_503_1.var_.characterEffect10076ui_story and not isNil(var_506_6) then
					arg_503_1.var_.characterEffect10076ui_story.fillFlat = true
					arg_503_1.var_.characterEffect10076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_503_1.time_ - 0) / var_506_7)
				end
			end

			if arg_503_1.time_ >= 0 + var_506_7 and arg_503_1.time_ < 0 + var_506_7 + arg_506_0 and not isNil(var_506_6) and arg_503_1.var_.characterEffect10076ui_story then
				arg_503_1.var_.characterEffect10076ui_story.fillFlat = true
				arg_503_1.var_.characterEffect10076ui_story.fillRatio = 0.5
			end

			local var_506_8 = 0
			local var_506_9 = 0.475

			if 0 < arg_503_1.time_ and arg_503_1.time_ <= var_506_8 + arg_506_0 then
				arg_503_1.talkMaxDuration = 0
				arg_503_1.dialogCg_.alpha = 1

				arg_503_1.dialog_:SetActive(true)
				SetActive(arg_503_1.leftNameGo_, true)

				arg_503_1.leftNameTxt_.text = arg_503_1:FormatText(StoryNameCfg[920].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_503_1.leftNameTxt_.transform)

				arg_503_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_503_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_503_1:RecordName(arg_503_1.leftNameTxt_.text)
				SetActive(arg_503_1.iconTrs_.gameObject, false)
				arg_503_1.callingController_:SetSelectedState("normal")

				local var_506_10 = arg_503_1:GetWordFromCfg(412031121)
				local var_506_11 = arg_503_1:FormatText(var_506_10.content)

				arg_503_1.text_.text = var_506_11

				LuaForUtil.ClearLinePrefixSymbol(arg_503_1.text_)

				local var_506_13 = 19 <= 0 and var_506_9 or var_506_9 * (utf8.len(var_506_11) / 19)

				if (19 <= 0 and var_506_9 or var_506_9 * (utf8.len(var_506_11) / 19)) > 0 and var_506_9 < var_506_13 then
					arg_503_1.talkMaxDuration = var_506_13

					if var_506_13 + var_506_8 > arg_503_1.duration_ then
						arg_503_1.duration_ = var_506_13 + var_506_8
					end
				end

				arg_503_1.text_.text = var_506_11
				arg_503_1.typewritter.percent = 0

				arg_503_1.typewritter:SetDirty()
				arg_503_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031121", "story_v_out_412031.awb") ~= 0 then
					local var_506_14 = manager.audio:GetVoiceLength("story_v_out_412031", "412031121", "story_v_out_412031.awb") / 1000

					if var_506_14 + var_506_8 > arg_503_1.duration_ then
						arg_503_1.duration_ = var_506_14 + var_506_8
					end

					if var_506_10.prefab_name ~= "" and arg_503_1.actors_[var_506_10.prefab_name] ~= nil then
						local var_506_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_503_1.actors_[var_506_10.prefab_name].transform, "story_v_out_412031", "412031121", "story_v_out_412031.awb")

						arg_503_1:RecordAudio("412031121", var_506_15)
						arg_503_1:RecordAudio("412031121", var_506_15)
					else
						arg_503_1:AudioAction("play", "voice", "story_v_out_412031", "412031121", "story_v_out_412031.awb")
					end

					arg_503_1:RecordHistoryTalkVoice("story_v_out_412031", "412031121", "story_v_out_412031.awb")
				end

				arg_503_1:RecordContent(arg_503_1.text_.text)
			end

			local var_506_16 = math.max(var_506_9, arg_503_1.talkMaxDuration)

			if var_506_8 <= arg_503_1.time_ and arg_503_1.time_ < var_506_8 + var_506_16 then
				arg_503_1.typewritter.percent = (arg_503_1.time_ - var_506_8) / var_506_16

				arg_503_1.typewritter:SetDirty()
			end

			if arg_503_1.time_ >= var_506_8 + var_506_16 and arg_503_1.time_ < var_506_8 + var_506_16 + arg_506_0 then
				arg_503_1.typewritter.percent = 1

				arg_503_1.typewritter:SetDirty()
				arg_503_1:ShowNextGo(true)
			end
		end

		arg_503_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_503_1:InitPlayNodeList()
	end,
	Play412031122 = function(arg_507_0, arg_507_1)
		arg_507_1.time_ = 0
		arg_507_1.frameCnt_ = 0
		arg_507_1.state_ = "playing"
		arg_507_1.curTalkId_ = 412031122
		arg_507_1.duration_ = 9.67

		local var_507_0 = {
			zh = 8.533,
			ja = 9.666
		}
		local var_507_1 = manager.audio:GetLocalizationFlag()

		if var_507_0[var_507_1] ~= nil then
			arg_507_1.duration_ = var_507_0[var_507_1]
		end

		SetActive(arg_507_1.tipsGo_, false)

		function arg_507_1.onSingleLineFinish_()
			arg_507_1.onSingleLineUpdate_ = nil
			arg_507_1.onSingleLineFinish_ = nil
			arg_507_1.state_ = "waiting"
		end

		function arg_507_1.playNext_(arg_509_0)
			if arg_509_0 == 1 then
				arg_507_0:Play412031123(arg_507_1)
			end
		end

		function arg_507_1.onSingleLineUpdate_(arg_510_0)
			local var_510_0 = 0.8

			if 0 < arg_507_1.time_ and arg_507_1.time_ <= 0 + arg_510_0 then
				arg_507_1.talkMaxDuration = 0
				arg_507_1.dialogCg_.alpha = 1

				arg_507_1.dialog_:SetActive(true)
				SetActive(arg_507_1.leftNameGo_, true)

				arg_507_1.leftNameTxt_.text = arg_507_1:FormatText(StoryNameCfg[920].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_507_1.leftNameTxt_.transform)

				arg_507_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_507_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_507_1:RecordName(arg_507_1.leftNameTxt_.text)
				SetActive(arg_507_1.iconTrs_.gameObject, false)
				arg_507_1.callingController_:SetSelectedState("normal")

				local var_510_1 = arg_507_1:GetWordFromCfg(412031122)
				local var_510_2 = arg_507_1:FormatText(var_510_1.content)

				arg_507_1.text_.text = var_510_2

				LuaForUtil.ClearLinePrefixSymbol(arg_507_1.text_)

				local var_510_4 = 32 <= 0 and var_510_0 or var_510_0 * (utf8.len(var_510_2) / 32)

				if (32 <= 0 and var_510_0 or var_510_0 * (utf8.len(var_510_2) / 32)) > 0 and var_510_0 < var_510_4 then
					arg_507_1.talkMaxDuration = var_510_4

					if var_510_4 + 0 > arg_507_1.duration_ then
						arg_507_1.duration_ = var_510_4 + 0
					end
				end

				arg_507_1.text_.text = var_510_2
				arg_507_1.typewritter.percent = 0

				arg_507_1.typewritter:SetDirty()
				arg_507_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031122", "story_v_out_412031.awb") ~= 0 then
					local var_510_5 = manager.audio:GetVoiceLength("story_v_out_412031", "412031122", "story_v_out_412031.awb") / 1000

					if var_510_5 + 0 > arg_507_1.duration_ then
						arg_507_1.duration_ = var_510_5 + 0
					end

					if var_510_1.prefab_name ~= "" and arg_507_1.actors_[var_510_1.prefab_name] ~= nil then
						local var_510_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_507_1.actors_[var_510_1.prefab_name].transform, "story_v_out_412031", "412031122", "story_v_out_412031.awb")

						arg_507_1:RecordAudio("412031122", var_510_6)
						arg_507_1:RecordAudio("412031122", var_510_6)
					else
						arg_507_1:AudioAction("play", "voice", "story_v_out_412031", "412031122", "story_v_out_412031.awb")
					end

					arg_507_1:RecordHistoryTalkVoice("story_v_out_412031", "412031122", "story_v_out_412031.awb")
				end

				arg_507_1:RecordContent(arg_507_1.text_.text)
			end

			local var_510_7 = math.max(var_510_0, arg_507_1.talkMaxDuration)

			if 0 <= arg_507_1.time_ and arg_507_1.time_ < 0 + var_510_7 then
				arg_507_1.typewritter.percent = (arg_507_1.time_ - 0) / var_510_7

				arg_507_1.typewritter:SetDirty()
			end

			if arg_507_1.time_ >= 0 + var_510_7 and arg_507_1.time_ < 0 + var_510_7 + arg_510_0 then
				arg_507_1.typewritter.percent = 1

				arg_507_1.typewritter:SetDirty()
				arg_507_1:ShowNextGo(true)
			end
		end

		arg_507_1.nodeConfigList_ = {}

		arg_507_1:InitPlayNodeList()
	end,
	Play412031123 = function(arg_511_0, arg_511_1)
		arg_511_1.time_ = 0
		arg_511_1.frameCnt_ = 0
		arg_511_1.state_ = "playing"
		arg_511_1.curTalkId_ = 412031123
		arg_511_1.duration_ = 5

		SetActive(arg_511_1.tipsGo_, false)

		function arg_511_1.onSingleLineFinish_()
			arg_511_1.onSingleLineUpdate_ = nil
			arg_511_1.onSingleLineFinish_ = nil
			arg_511_1.state_ = "waiting"
		end

		function arg_511_1.playNext_(arg_513_0)
			if arg_513_0 == 1 then
				arg_511_0:Play412031124(arg_511_1)
			end
		end

		function arg_511_1.onSingleLineUpdate_(arg_514_0)
			if 0 < arg_511_1.time_ and arg_511_1.time_ <= 0 + arg_514_0 then
				arg_511_1.var_.moveOldPos3043ui_story = arg_511_1.actors_["3043ui_story"].transform.localPosition
			end

			local var_514_0 = 0.001

			if 0 <= arg_511_1.time_ and arg_511_1.time_ < 0 + var_514_0 then
				arg_511_1.actors_["3043ui_story"].transform.localPosition = Vector3.Lerp(arg_511_1.var_.moveOldPos3043ui_story, Vector3.New(0, 100, 0), (arg_511_1.time_ - 0) / var_514_0)
				arg_511_1.actors_["3043ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_511_1.actors_["3043ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_511_1.actors_["3043ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_511_1.actors_["3043ui_story"].transform.position).z)
				arg_511_1.actors_["3043ui_story"].transform.localEulerAngles.z = 0
				arg_511_1.actors_["3043ui_story"].transform.localEulerAngles.x = 0
				arg_511_1.actors_["3043ui_story"].transform.localEulerAngles = arg_511_1.actors_["3043ui_story"].transform.localEulerAngles
			end

			if arg_511_1.time_ >= 0 + var_514_0 and arg_511_1.time_ < 0 + var_514_0 + arg_514_0 then
				arg_511_1.actors_["3043ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_511_1.actors_["3043ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_511_1.actors_["3043ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_511_1.actors_["3043ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_511_1.actors_["3043ui_story"].transform.position).z)
				arg_511_1.actors_["3043ui_story"].transform.localEulerAngles.z = 0
				arg_511_1.actors_["3043ui_story"].transform.localEulerAngles.x = 0
				arg_511_1.actors_["3043ui_story"].transform.localEulerAngles = arg_511_1.actors_["3043ui_story"].transform.localEulerAngles
			end

			local var_514_1 = arg_511_1.actors_["3043ui_story"]

			if 0 < arg_511_1.time_ and arg_511_1.time_ <= 0 + arg_514_0 and not isNil(var_514_1) and arg_511_1.var_.characterEffect3043ui_story == nil then
				arg_511_1.var_.characterEffect3043ui_story = var_514_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_514_2 = 0.200000002980232

			if 0 <= arg_511_1.time_ and arg_511_1.time_ < 0 + var_514_2 and not isNil(var_514_1) then
				if arg_511_1.var_.characterEffect3043ui_story and not isNil(var_514_1) then
					arg_511_1.var_.characterEffect3043ui_story.fillFlat = true
					arg_511_1.var_.characterEffect3043ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_511_1.time_ - 0) / var_514_2)
				end
			end

			if arg_511_1.time_ >= 0 + var_514_2 and arg_511_1.time_ < 0 + var_514_2 + arg_514_0 and not isNil(var_514_1) and arg_511_1.var_.characterEffect3043ui_story then
				arg_511_1.var_.characterEffect3043ui_story.fillFlat = true
				arg_511_1.var_.characterEffect3043ui_story.fillRatio = 0.5
			end

			local var_514_3 = 0
			local var_514_4 = 0.35

			if 0 < arg_511_1.time_ and arg_511_1.time_ <= var_514_3 + arg_514_0 then
				arg_511_1.talkMaxDuration = 0
				arg_511_1.dialogCg_.alpha = 1

				arg_511_1.dialog_:SetActive(true)
				SetActive(arg_511_1.leftNameGo_, false)

				arg_511_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_511_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_511_1:RecordName(arg_511_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_511_1.iconTrs_.gameObject, false)
				arg_511_1.callingController_:SetSelectedState("normal")

				local var_514_5 = arg_511_1:FormatText(arg_511_1:GetWordFromCfg(412031123).content)

				arg_511_1.text_.text = var_514_5

				LuaForUtil.ClearLinePrefixSymbol(arg_511_1.text_)

				local var_514_7 = 14 <= 0 and var_514_4 or var_514_4 * (utf8.len(var_514_5) / 14)

				if (14 <= 0 and var_514_4 or var_514_4 * (utf8.len(var_514_5) / 14)) > 0 and var_514_4 < var_514_7 then
					arg_511_1.talkMaxDuration = var_514_7

					if var_514_7 + var_514_3 > arg_511_1.duration_ then
						arg_511_1.duration_ = var_514_7 + var_514_3
					end
				end

				arg_511_1.text_.text = var_514_5
				arg_511_1.typewritter.percent = 0

				arg_511_1.typewritter:SetDirty()
				arg_511_1:ShowNextGo(false)
				arg_511_1:RecordContent(arg_511_1.text_.text)
			end

			local var_514_8 = math.max(var_514_4, arg_511_1.talkMaxDuration)

			if var_514_3 <= arg_511_1.time_ and arg_511_1.time_ < var_514_3 + var_514_8 then
				arg_511_1.typewritter.percent = (arg_511_1.time_ - var_514_3) / var_514_8

				arg_511_1.typewritter:SetDirty()
			end

			if arg_511_1.time_ >= var_514_3 + var_514_8 and arg_511_1.time_ < var_514_3 + var_514_8 + arg_514_0 then
				arg_511_1.typewritter.percent = 1

				arg_511_1.typewritter:SetDirty()
				arg_511_1:ShowNextGo(true)
			end
		end

		arg_511_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_511_1:InitPlayNodeList()
	end,
	Play412031124 = function(arg_515_0, arg_515_1)
		arg_515_1.time_ = 0
		arg_515_1.frameCnt_ = 0
		arg_515_1.state_ = "playing"
		arg_515_1.curTalkId_ = 412031124
		arg_515_1.duration_ = 3.23

		local var_515_0 = {
			zh = 3.233,
			ja = 1.999999999999
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
				arg_515_0:Play412031125(arg_515_1)
			end
		end

		function arg_515_1.onSingleLineUpdate_(arg_518_0)
			if 0 < arg_515_1.time_ and arg_515_1.time_ <= 0 + arg_518_0 then
				arg_515_1.var_.moveOldPos1097ui_story = arg_515_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_518_0 = 0.001

			if 0 <= arg_515_1.time_ and arg_515_1.time_ < 0 + var_518_0 then
				arg_515_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_515_1.var_.moveOldPos1097ui_story, Vector3.New(0, -0.54, -6.3), (arg_515_1.time_ - 0) / var_518_0)
				arg_515_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_515_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_515_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_515_1.actors_["1097ui_story"].transform.position).z)
				arg_515_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_515_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_515_1.actors_["1097ui_story"].transform.localEulerAngles = arg_515_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_515_1.time_ >= 0 + var_518_0 and arg_515_1.time_ < 0 + var_518_0 + arg_518_0 then
				arg_515_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(0, -0.54, -6.3)
				arg_515_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_515_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_515_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_515_1.actors_["1097ui_story"].transform.position).z)
				arg_515_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_515_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_515_1.actors_["1097ui_story"].transform.localEulerAngles = arg_515_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_518_1 = arg_515_1.actors_["1097ui_story"]

			if 0 < arg_515_1.time_ and arg_515_1.time_ <= 0 + arg_518_0 and not isNil(var_518_1) and arg_515_1.var_.characterEffect1097ui_story == nil then
				arg_515_1.var_.characterEffect1097ui_story = var_518_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_518_2 = 0.200000002980232

			if 0 <= arg_515_1.time_ and arg_515_1.time_ < 0 + var_518_2 and not isNil(var_518_1) then
				if arg_515_1.var_.characterEffect1097ui_story and not isNil(var_518_1) then
					arg_515_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_515_1.time_ >= 0 + var_518_2 and arg_515_1.time_ < 0 + var_518_2 + arg_518_0 and not isNil(var_518_1) and arg_515_1.var_.characterEffect1097ui_story then
				arg_515_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_515_1.time_ and arg_515_1.time_ <= 0 + arg_518_0 then
				arg_515_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action3_1")
			end

			if 0 < arg_515_1.time_ and arg_515_1.time_ <= 0 + arg_518_0 then
				arg_515_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_518_4 = arg_515_1.actors_["3043ui_story"].transform

			if 0 < arg_515_1.time_ and arg_515_1.time_ <= 0 + arg_518_0 then
				arg_515_1.var_.moveOldPos3043ui_story = var_518_4.localPosition
			end

			local var_518_5 = 0.001

			if 0 <= arg_515_1.time_ and arg_515_1.time_ < 0 + var_518_5 then
				var_518_4.localPosition = Vector3.Lerp(arg_515_1.var_.moveOldPos3043ui_story, Vector3.New(0, 100, 0), (arg_515_1.time_ - 0) / var_518_5)
				var_518_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_518_4.position).x, (manager.ui.mainCamera.transform.position - var_518_4.position).y, (manager.ui.mainCamera.transform.position - var_518_4.position).z)
				var_518_4.localEulerAngles.z = 0
				var_518_4.localEulerAngles.x = 0
				var_518_4.localEulerAngles = var_518_4.localEulerAngles
			end

			if arg_515_1.time_ >= 0 + var_518_5 and arg_515_1.time_ < 0 + var_518_5 + arg_518_0 then
				var_518_4.localPosition = Vector3.New(0, 100, 0)
				var_518_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_518_4.position).x, (manager.ui.mainCamera.transform.position - var_518_4.position).y, (manager.ui.mainCamera.transform.position - var_518_4.position).z)
				var_518_4.localEulerAngles.z = 0
				var_518_4.localEulerAngles.x = 0
				var_518_4.localEulerAngles = var_518_4.localEulerAngles
			end

			local var_518_6 = 0
			local var_518_7 = 0.3

			if 0 < arg_515_1.time_ and arg_515_1.time_ <= var_518_6 + arg_518_0 then
				arg_515_1.talkMaxDuration = 0
				arg_515_1.dialogCg_.alpha = 1

				arg_515_1.dialog_:SetActive(true)
				SetActive(arg_515_1.leftNameGo_, true)

				arg_515_1.leftNameTxt_.text = arg_515_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_515_1.leftNameTxt_.transform)

				arg_515_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_515_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_515_1:RecordName(arg_515_1.leftNameTxt_.text)
				SetActive(arg_515_1.iconTrs_.gameObject, false)
				arg_515_1.callingController_:SetSelectedState("normal")

				local var_518_8 = arg_515_1:GetWordFromCfg(412031124)
				local var_518_9 = arg_515_1:FormatText(var_518_8.content)

				arg_515_1.text_.text = var_518_9

				LuaForUtil.ClearLinePrefixSymbol(arg_515_1.text_)

				local var_518_11 = 12 <= 0 and var_518_7 or var_518_7 * (utf8.len(var_518_9) / 12)

				if (12 <= 0 and var_518_7 or var_518_7 * (utf8.len(var_518_9) / 12)) > 0 and var_518_7 < var_518_11 then
					arg_515_1.talkMaxDuration = var_518_11

					if var_518_11 + var_518_6 > arg_515_1.duration_ then
						arg_515_1.duration_ = var_518_11 + var_518_6
					end
				end

				arg_515_1.text_.text = var_518_9
				arg_515_1.typewritter.percent = 0

				arg_515_1.typewritter:SetDirty()
				arg_515_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031124", "story_v_out_412031.awb") ~= 0 then
					local var_518_12 = manager.audio:GetVoiceLength("story_v_out_412031", "412031124", "story_v_out_412031.awb") / 1000

					if var_518_12 + var_518_6 > arg_515_1.duration_ then
						arg_515_1.duration_ = var_518_12 + var_518_6
					end

					if var_518_8.prefab_name ~= "" and arg_515_1.actors_[var_518_8.prefab_name] ~= nil then
						local var_518_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_515_1.actors_[var_518_8.prefab_name].transform, "story_v_out_412031", "412031124", "story_v_out_412031.awb")

						arg_515_1:RecordAudio("412031124", var_518_13)
						arg_515_1:RecordAudio("412031124", var_518_13)
					else
						arg_515_1:AudioAction("play", "voice", "story_v_out_412031", "412031124", "story_v_out_412031.awb")
					end

					arg_515_1:RecordHistoryTalkVoice("story_v_out_412031", "412031124", "story_v_out_412031.awb")
				end

				arg_515_1:RecordContent(arg_515_1.text_.text)
			end

			local var_518_14 = math.max(var_518_7, arg_515_1.talkMaxDuration)

			if var_518_6 <= arg_515_1.time_ and arg_515_1.time_ < var_518_6 + var_518_14 then
				arg_515_1.typewritter.percent = (arg_515_1.time_ - var_518_6) / var_518_14

				arg_515_1.typewritter:SetDirty()
			end

			if arg_515_1.time_ >= var_518_6 + var_518_14 and arg_515_1.time_ < var_518_6 + var_518_14 + arg_518_0 then
				arg_515_1.typewritter.percent = 1

				arg_515_1.typewritter:SetDirty()
				arg_515_1:ShowNextGo(true)
			end
		end

		arg_515_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "3043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_515_1:InitPlayNodeList()
	end,
	Play412031125 = function(arg_519_0, arg_519_1)
		arg_519_1.time_ = 0
		arg_519_1.frameCnt_ = 0
		arg_519_1.state_ = "playing"
		arg_519_1.curTalkId_ = 412031125
		arg_519_1.duration_ = 3.5

		local var_519_0 = {
			zh = 2.6,
			ja = 3.5
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
				arg_519_0:Play412031126(arg_519_1)
			end
		end

		function arg_519_1.onSingleLineUpdate_(arg_522_0)
			if 0 < arg_519_1.time_ and arg_519_1.time_ <= 0 + arg_522_0 then
				arg_519_1.var_.moveOldPos10078ui_story = arg_519_1.actors_["10078ui_story"].transform.localPosition
			end

			local var_522_0 = 0.001

			if 0 <= arg_519_1.time_ and arg_519_1.time_ < 0 + var_522_0 then
				arg_519_1.actors_["10078ui_story"].transform.localPosition = Vector3.Lerp(arg_519_1.var_.moveOldPos10078ui_story, Vector3.New(0, -0.5, -6.3), (arg_519_1.time_ - 0) / var_522_0)
				arg_519_1.actors_["10078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_519_1.actors_["10078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_519_1.actors_["10078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_519_1.actors_["10078ui_story"].transform.position).z)
				arg_519_1.actors_["10078ui_story"].transform.localEulerAngles.z = 0
				arg_519_1.actors_["10078ui_story"].transform.localEulerAngles.x = 0
				arg_519_1.actors_["10078ui_story"].transform.localEulerAngles = arg_519_1.actors_["10078ui_story"].transform.localEulerAngles
			end

			if arg_519_1.time_ >= 0 + var_522_0 and arg_519_1.time_ < 0 + var_522_0 + arg_522_0 then
				arg_519_1.actors_["10078ui_story"].transform.localPosition = Vector3.New(0, -0.5, -6.3)
				arg_519_1.actors_["10078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_519_1.actors_["10078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_519_1.actors_["10078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_519_1.actors_["10078ui_story"].transform.position).z)
				arg_519_1.actors_["10078ui_story"].transform.localEulerAngles.z = 0
				arg_519_1.actors_["10078ui_story"].transform.localEulerAngles.x = 0
				arg_519_1.actors_["10078ui_story"].transform.localEulerAngles = arg_519_1.actors_["10078ui_story"].transform.localEulerAngles
			end

			local var_522_1 = arg_519_1.actors_["10078ui_story"]

			if 0 < arg_519_1.time_ and arg_519_1.time_ <= 0 + arg_522_0 and not isNil(var_522_1) and arg_519_1.var_.characterEffect10078ui_story == nil then
				arg_519_1.var_.characterEffect10078ui_story = var_522_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_522_2 = 0.200000002980232

			if 0 <= arg_519_1.time_ and arg_519_1.time_ < 0 + var_522_2 and not isNil(var_522_1) then
				if arg_519_1.var_.characterEffect10078ui_story and not isNil(var_522_1) then
					arg_519_1.var_.characterEffect10078ui_story.fillFlat = false
				end
			end

			if arg_519_1.time_ >= 0 + var_522_2 and arg_519_1.time_ < 0 + var_522_2 + arg_522_0 and not isNil(var_522_1) and arg_519_1.var_.characterEffect10078ui_story then
				arg_519_1.var_.characterEffect10078ui_story.fillFlat = false
			end

			if 0 < arg_519_1.time_ and arg_519_1.time_ <= 0 + arg_522_0 then
				arg_519_1:PlayTimeline("10078ui_story", "StoryTimeline/CharAction/story6046/story6046action/6046action4_2")
			end

			if 0 < arg_519_1.time_ and arg_519_1.time_ <= 0 + arg_522_0 then
				arg_519_1:PlayTimeline("10078ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_522_4 = arg_519_1.actors_["1097ui_story"].transform

			if 0 < arg_519_1.time_ and arg_519_1.time_ <= 0 + arg_522_0 then
				arg_519_1.var_.moveOldPos1097ui_story = var_522_4.localPosition
			end

			local var_522_5 = 0.001

			if 0 <= arg_519_1.time_ and arg_519_1.time_ < 0 + var_522_5 then
				var_522_4.localPosition = Vector3.Lerp(arg_519_1.var_.moveOldPos1097ui_story, Vector3.New(0, 100, 0), (arg_519_1.time_ - 0) / var_522_5)
				var_522_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_522_4.position).x, (manager.ui.mainCamera.transform.position - var_522_4.position).y, (manager.ui.mainCamera.transform.position - var_522_4.position).z)
				var_522_4.localEulerAngles.z = 0
				var_522_4.localEulerAngles.x = 0
				var_522_4.localEulerAngles = var_522_4.localEulerAngles
			end

			if arg_519_1.time_ >= 0 + var_522_5 and arg_519_1.time_ < 0 + var_522_5 + arg_522_0 then
				var_522_4.localPosition = Vector3.New(0, 100, 0)
				var_522_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_522_4.position).x, (manager.ui.mainCamera.transform.position - var_522_4.position).y, (manager.ui.mainCamera.transform.position - var_522_4.position).z)
				var_522_4.localEulerAngles.z = 0
				var_522_4.localEulerAngles.x = 0
				var_522_4.localEulerAngles = var_522_4.localEulerAngles
			end

			local var_522_6 = arg_519_1.actors_["1097ui_story"]

			if 0 < arg_519_1.time_ and arg_519_1.time_ <= 0 + arg_522_0 and not isNil(var_522_6) and arg_519_1.var_.characterEffect1097ui_story == nil then
				arg_519_1.var_.characterEffect1097ui_story = var_522_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_522_7 = 0.200000002980232

			if 0 <= arg_519_1.time_ and arg_519_1.time_ < 0 + var_522_7 and not isNil(var_522_6) then
				if arg_519_1.var_.characterEffect1097ui_story and not isNil(var_522_6) then
					arg_519_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_519_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_519_1.time_ - 0) / var_522_7)
				end
			end

			if arg_519_1.time_ >= 0 + var_522_7 and arg_519_1.time_ < 0 + var_522_7 + arg_522_0 and not isNil(var_522_6) and arg_519_1.var_.characterEffect1097ui_story then
				arg_519_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_519_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_522_8 = 0
			local var_522_9 = 0.175

			if 0 < arg_519_1.time_ and arg_519_1.time_ <= var_522_8 + arg_522_0 then
				arg_519_1.talkMaxDuration = 0
				arg_519_1.dialogCg_.alpha = 1

				arg_519_1.dialog_:SetActive(true)
				SetActive(arg_519_1.leftNameGo_, true)

				arg_519_1.leftNameTxt_.text = arg_519_1:FormatText(StoryNameCfg[919].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_519_1.leftNameTxt_.transform)

				arg_519_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_519_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_519_1:RecordName(arg_519_1.leftNameTxt_.text)
				SetActive(arg_519_1.iconTrs_.gameObject, false)
				arg_519_1.callingController_:SetSelectedState("normal")

				local var_522_10 = arg_519_1:GetWordFromCfg(412031125)
				local var_522_11 = arg_519_1:FormatText(var_522_10.content)

				arg_519_1.text_.text = var_522_11

				LuaForUtil.ClearLinePrefixSymbol(arg_519_1.text_)

				local var_522_13 = 7 <= 0 and var_522_9 or var_522_9 * (utf8.len(var_522_11) / 7)

				if (7 <= 0 and var_522_9 or var_522_9 * (utf8.len(var_522_11) / 7)) > 0 and var_522_9 < var_522_13 then
					arg_519_1.talkMaxDuration = var_522_13

					if var_522_13 + var_522_8 > arg_519_1.duration_ then
						arg_519_1.duration_ = var_522_13 + var_522_8
					end
				end

				arg_519_1.text_.text = var_522_11
				arg_519_1.typewritter.percent = 0

				arg_519_1.typewritter:SetDirty()
				arg_519_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031125", "story_v_out_412031.awb") ~= 0 then
					local var_522_14 = manager.audio:GetVoiceLength("story_v_out_412031", "412031125", "story_v_out_412031.awb") / 1000

					if var_522_14 + var_522_8 > arg_519_1.duration_ then
						arg_519_1.duration_ = var_522_14 + var_522_8
					end

					if var_522_10.prefab_name ~= "" and arg_519_1.actors_[var_522_10.prefab_name] ~= nil then
						local var_522_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_519_1.actors_[var_522_10.prefab_name].transform, "story_v_out_412031", "412031125", "story_v_out_412031.awb")

						arg_519_1:RecordAudio("412031125", var_522_15)
						arg_519_1:RecordAudio("412031125", var_522_15)
					else
						arg_519_1:AudioAction("play", "voice", "story_v_out_412031", "412031125", "story_v_out_412031.awb")
					end

					arg_519_1:RecordHistoryTalkVoice("story_v_out_412031", "412031125", "story_v_out_412031.awb")
				end

				arg_519_1:RecordContent(arg_519_1.text_.text)
			end

			local var_522_16 = math.max(var_522_9, arg_519_1.talkMaxDuration)

			if var_522_8 <= arg_519_1.time_ and arg_519_1.time_ < var_522_8 + var_522_16 then
				arg_519_1.typewritter.percent = (arg_519_1.time_ - var_522_8) / var_522_16

				arg_519_1.typewritter:SetDirty()
			end

			if arg_519_1.time_ >= var_522_8 + var_522_16 and arg_519_1.time_ < var_522_8 + var_522_16 + arg_522_0 then
				arg_519_1.typewritter.percent = 1

				arg_519_1.typewritter:SetDirty()
				arg_519_1:ShowNextGo(true)
			end
		end

		arg_519_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_519_1:InitPlayNodeList()
	end,
	Play412031126 = function(arg_523_0, arg_523_1)
		arg_523_1.time_ = 0
		arg_523_1.frameCnt_ = 0
		arg_523_1.state_ = "playing"
		arg_523_1.curTalkId_ = 412031126
		arg_523_1.duration_ = 9.17

		local var_523_0 = {
			zh = 8.266,
			ja = 9.166
		}
		local var_523_1 = manager.audio:GetLocalizationFlag()

		if var_523_0[var_523_1] ~= nil then
			arg_523_1.duration_ = var_523_0[var_523_1]
		end

		SetActive(arg_523_1.tipsGo_, false)

		function arg_523_1.onSingleLineFinish_()
			arg_523_1.onSingleLineUpdate_ = nil
			arg_523_1.onSingleLineFinish_ = nil
			arg_523_1.state_ = "waiting"
		end

		function arg_523_1.playNext_(arg_525_0)
			if arg_525_0 == 1 then
				arg_523_0:Play412031127(arg_523_1)
			end
		end

		function arg_523_1.onSingleLineUpdate_(arg_526_0)
			if 0 < arg_523_1.time_ and arg_523_1.time_ <= 0 + arg_526_0 then
				arg_523_1.var_.moveOldPos10083ui_story = arg_523_1.actors_["10083ui_story"].transform.localPosition
			end

			local var_526_0 = 0.001

			if 0 <= arg_523_1.time_ and arg_523_1.time_ < 0 + var_526_0 then
				arg_523_1.actors_["10083ui_story"].transform.localPosition = Vector3.Lerp(arg_523_1.var_.moveOldPos10083ui_story, Vector3.New(0, -2.6, -2.8), (arg_523_1.time_ - 0) / var_526_0)
				arg_523_1.actors_["10083ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_523_1.actors_["10083ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_523_1.actors_["10083ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_523_1.actors_["10083ui_story"].transform.position).z)
				arg_523_1.actors_["10083ui_story"].transform.localEulerAngles.z = 0
				arg_523_1.actors_["10083ui_story"].transform.localEulerAngles.x = 0
				arg_523_1.actors_["10083ui_story"].transform.localEulerAngles = arg_523_1.actors_["10083ui_story"].transform.localEulerAngles
			end

			if arg_523_1.time_ >= 0 + var_526_0 and arg_523_1.time_ < 0 + var_526_0 + arg_526_0 then
				arg_523_1.actors_["10083ui_story"].transform.localPosition = Vector3.New(0, -2.6, -2.8)
				arg_523_1.actors_["10083ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_523_1.actors_["10083ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_523_1.actors_["10083ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_523_1.actors_["10083ui_story"].transform.position).z)
				arg_523_1.actors_["10083ui_story"].transform.localEulerAngles.z = 0
				arg_523_1.actors_["10083ui_story"].transform.localEulerAngles.x = 0
				arg_523_1.actors_["10083ui_story"].transform.localEulerAngles = arg_523_1.actors_["10083ui_story"].transform.localEulerAngles
			end

			local var_526_1 = arg_523_1.actors_["10083ui_story"]

			if 0 < arg_523_1.time_ and arg_523_1.time_ <= 0 + arg_526_0 and not isNil(var_526_1) and arg_523_1.var_.characterEffect10083ui_story == nil then
				arg_523_1.var_.characterEffect10083ui_story = var_526_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_526_2 = 0.200000002980232

			if 0 <= arg_523_1.time_ and arg_523_1.time_ < 0 + var_526_2 and not isNil(var_526_1) then
				if arg_523_1.var_.characterEffect10083ui_story and not isNil(var_526_1) then
					arg_523_1.var_.characterEffect10083ui_story.fillFlat = false
				end
			end

			if arg_523_1.time_ >= 0 + var_526_2 and arg_523_1.time_ < 0 + var_526_2 + arg_526_0 and not isNil(var_526_1) and arg_523_1.var_.characterEffect10083ui_story then
				arg_523_1.var_.characterEffect10083ui_story.fillFlat = false
			end

			if 0 < arg_523_1.time_ and arg_523_1.time_ <= 0 + arg_526_0 then
				arg_523_1:PlayTimeline("10083ui_story", "StoryTimeline/CharAction/story10083/story10083action/10083action1_1")
			end

			if 0 < arg_523_1.time_ and arg_523_1.time_ <= 0 + arg_526_0 then
				arg_523_1:PlayTimeline("10083ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_526_4 = arg_523_1.actors_["10078ui_story"].transform

			if 0 < arg_523_1.time_ and arg_523_1.time_ <= 0 + arg_526_0 then
				arg_523_1.var_.moveOldPos10078ui_story = var_526_4.localPosition
			end

			local var_526_5 = 0.001

			if 0 <= arg_523_1.time_ and arg_523_1.time_ < 0 + var_526_5 then
				var_526_4.localPosition = Vector3.Lerp(arg_523_1.var_.moveOldPos10078ui_story, Vector3.New(0, 100, 0), (arg_523_1.time_ - 0) / var_526_5)
				var_526_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_526_4.position).x, (manager.ui.mainCamera.transform.position - var_526_4.position).y, (manager.ui.mainCamera.transform.position - var_526_4.position).z)
				var_526_4.localEulerAngles.z = 0
				var_526_4.localEulerAngles.x = 0
				var_526_4.localEulerAngles = var_526_4.localEulerAngles
			end

			if arg_523_1.time_ >= 0 + var_526_5 and arg_523_1.time_ < 0 + var_526_5 + arg_526_0 then
				var_526_4.localPosition = Vector3.New(0, 100, 0)
				var_526_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_526_4.position).x, (manager.ui.mainCamera.transform.position - var_526_4.position).y, (manager.ui.mainCamera.transform.position - var_526_4.position).z)
				var_526_4.localEulerAngles.z = 0
				var_526_4.localEulerAngles.x = 0
				var_526_4.localEulerAngles = var_526_4.localEulerAngles
			end

			local var_526_6 = arg_523_1.actors_["10078ui_story"]

			if 0 < arg_523_1.time_ and arg_523_1.time_ <= 0 + arg_526_0 and not isNil(var_526_6) and arg_523_1.var_.characterEffect10078ui_story == nil then
				arg_523_1.var_.characterEffect10078ui_story = var_526_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_526_7 = 0.200000002980232

			if 0 <= arg_523_1.time_ and arg_523_1.time_ < 0 + var_526_7 and not isNil(var_526_6) then
				if arg_523_1.var_.characterEffect10078ui_story and not isNil(var_526_6) then
					arg_523_1.var_.characterEffect10078ui_story.fillFlat = true
					arg_523_1.var_.characterEffect10078ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_523_1.time_ - 0) / var_526_7)
				end
			end

			if arg_523_1.time_ >= 0 + var_526_7 and arg_523_1.time_ < 0 + var_526_7 + arg_526_0 and not isNil(var_526_6) and arg_523_1.var_.characterEffect10078ui_story then
				arg_523_1.var_.characterEffect10078ui_story.fillFlat = true
				arg_523_1.var_.characterEffect10078ui_story.fillRatio = 0.5
			end

			local var_526_8 = 0
			local var_526_9 = 0.85

			if 0 < arg_523_1.time_ and arg_523_1.time_ <= var_526_8 + arg_526_0 then
				arg_523_1.talkMaxDuration = 0
				arg_523_1.dialogCg_.alpha = 1

				arg_523_1.dialog_:SetActive(true)
				SetActive(arg_523_1.leftNameGo_, true)

				arg_523_1.leftNameTxt_.text = arg_523_1:FormatText(StoryNameCfg[918].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_523_1.leftNameTxt_.transform)

				arg_523_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_523_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_523_1:RecordName(arg_523_1.leftNameTxt_.text)
				SetActive(arg_523_1.iconTrs_.gameObject, false)
				arg_523_1.callingController_:SetSelectedState("normal")

				local var_526_10 = arg_523_1:GetWordFromCfg(412031126)
				local var_526_11 = arg_523_1:FormatText(var_526_10.content)

				arg_523_1.text_.text = var_526_11

				LuaForUtil.ClearLinePrefixSymbol(arg_523_1.text_)

				local var_526_13 = 34 <= 0 and var_526_9 or var_526_9 * (utf8.len(var_526_11) / 34)

				if (34 <= 0 and var_526_9 or var_526_9 * (utf8.len(var_526_11) / 34)) > 0 and var_526_9 < var_526_13 then
					arg_523_1.talkMaxDuration = var_526_13

					if var_526_13 + var_526_8 > arg_523_1.duration_ then
						arg_523_1.duration_ = var_526_13 + var_526_8
					end
				end

				arg_523_1.text_.text = var_526_11
				arg_523_1.typewritter.percent = 0

				arg_523_1.typewritter:SetDirty()
				arg_523_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031126", "story_v_out_412031.awb") ~= 0 then
					local var_526_14 = manager.audio:GetVoiceLength("story_v_out_412031", "412031126", "story_v_out_412031.awb") / 1000

					if var_526_14 + var_526_8 > arg_523_1.duration_ then
						arg_523_1.duration_ = var_526_14 + var_526_8
					end

					if var_526_10.prefab_name ~= "" and arg_523_1.actors_[var_526_10.prefab_name] ~= nil then
						local var_526_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_523_1.actors_[var_526_10.prefab_name].transform, "story_v_out_412031", "412031126", "story_v_out_412031.awb")

						arg_523_1:RecordAudio("412031126", var_526_15)
						arg_523_1:RecordAudio("412031126", var_526_15)
					else
						arg_523_1:AudioAction("play", "voice", "story_v_out_412031", "412031126", "story_v_out_412031.awb")
					end

					arg_523_1:RecordHistoryTalkVoice("story_v_out_412031", "412031126", "story_v_out_412031.awb")
				end

				arg_523_1:RecordContent(arg_523_1.text_.text)
			end

			local var_526_16 = math.max(var_526_9, arg_523_1.talkMaxDuration)

			if var_526_8 <= arg_523_1.time_ and arg_523_1.time_ < var_526_8 + var_526_16 then
				arg_523_1.typewritter.percent = (arg_523_1.time_ - var_526_8) / var_526_16

				arg_523_1.typewritter:SetDirty()
			end

			if arg_523_1.time_ >= var_526_8 + var_526_16 and arg_523_1.time_ < var_526_8 + var_526_16 + arg_526_0 then
				arg_523_1.typewritter.percent = 1

				arg_523_1.typewritter:SetDirty()
				arg_523_1:ShowNextGo(true)
			end
		end

		arg_523_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10083ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_523_1:InitPlayNodeList()
	end,
	Play412031127 = function(arg_527_0, arg_527_1)
		arg_527_1.time_ = 0
		arg_527_1.frameCnt_ = 0
		arg_527_1.state_ = "playing"
		arg_527_1.curTalkId_ = 412031127
		arg_527_1.duration_ = 10.97

		local var_527_0 = {
			zh = 4.833,
			ja = 10.966
		}
		local var_527_1 = manager.audio:GetLocalizationFlag()

		if var_527_0[var_527_1] ~= nil then
			arg_527_1.duration_ = var_527_0[var_527_1]
		end

		SetActive(arg_527_1.tipsGo_, false)

		function arg_527_1.onSingleLineFinish_()
			arg_527_1.onSingleLineUpdate_ = nil
			arg_527_1.onSingleLineFinish_ = nil
			arg_527_1.state_ = "waiting"
		end

		function arg_527_1.playNext_(arg_529_0)
			if arg_529_0 == 1 then
				arg_527_0:Play412031128(arg_527_1)
			end
		end

		function arg_527_1.onSingleLineUpdate_(arg_530_0)
			if 0 < arg_527_1.time_ and arg_527_1.time_ <= 0 + arg_530_0 then
				arg_527_1.var_.moveOldPos1097ui_story = arg_527_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_530_0 = 0.001

			if 0 <= arg_527_1.time_ and arg_527_1.time_ < 0 + var_530_0 then
				arg_527_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_527_1.var_.moveOldPos1097ui_story, Vector3.New(0, -0.54, -6.3), (arg_527_1.time_ - 0) / var_530_0)
				arg_527_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_527_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_527_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_527_1.actors_["1097ui_story"].transform.position).z)
				arg_527_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_527_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_527_1.actors_["1097ui_story"].transform.localEulerAngles = arg_527_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_527_1.time_ >= 0 + var_530_0 and arg_527_1.time_ < 0 + var_530_0 + arg_530_0 then
				arg_527_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(0, -0.54, -6.3)
				arg_527_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_527_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_527_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_527_1.actors_["1097ui_story"].transform.position).z)
				arg_527_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_527_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_527_1.actors_["1097ui_story"].transform.localEulerAngles = arg_527_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_530_1 = arg_527_1.actors_["1097ui_story"]

			if 0 < arg_527_1.time_ and arg_527_1.time_ <= 0 + arg_530_0 and not isNil(var_530_1) and arg_527_1.var_.characterEffect1097ui_story == nil then
				arg_527_1.var_.characterEffect1097ui_story = var_530_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_530_2 = 0.200000002980232

			if 0 <= arg_527_1.time_ and arg_527_1.time_ < 0 + var_530_2 and not isNil(var_530_1) then
				if arg_527_1.var_.characterEffect1097ui_story and not isNil(var_530_1) then
					arg_527_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_527_1.time_ >= 0 + var_530_2 and arg_527_1.time_ < 0 + var_530_2 + arg_530_0 and not isNil(var_530_1) and arg_527_1.var_.characterEffect1097ui_story then
				arg_527_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_527_1.time_ and arg_527_1.time_ <= 0 + arg_530_0 then
				arg_527_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			if 0 < arg_527_1.time_ and arg_527_1.time_ <= 0 + arg_530_0 then
				arg_527_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_530_4 = arg_527_1.actors_["10083ui_story"].transform

			if 0 < arg_527_1.time_ and arg_527_1.time_ <= 0 + arg_530_0 then
				arg_527_1.var_.moveOldPos10083ui_story = var_530_4.localPosition
			end

			local var_530_5 = 0.001

			if 0 <= arg_527_1.time_ and arg_527_1.time_ < 0 + var_530_5 then
				var_530_4.localPosition = Vector3.Lerp(arg_527_1.var_.moveOldPos10083ui_story, Vector3.New(0, 100, 0), (arg_527_1.time_ - 0) / var_530_5)
				var_530_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_530_4.position).x, (manager.ui.mainCamera.transform.position - var_530_4.position).y, (manager.ui.mainCamera.transform.position - var_530_4.position).z)
				var_530_4.localEulerAngles.z = 0
				var_530_4.localEulerAngles.x = 0
				var_530_4.localEulerAngles = var_530_4.localEulerAngles
			end

			if arg_527_1.time_ >= 0 + var_530_5 and arg_527_1.time_ < 0 + var_530_5 + arg_530_0 then
				var_530_4.localPosition = Vector3.New(0, 100, 0)
				var_530_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_530_4.position).x, (manager.ui.mainCamera.transform.position - var_530_4.position).y, (manager.ui.mainCamera.transform.position - var_530_4.position).z)
				var_530_4.localEulerAngles.z = 0
				var_530_4.localEulerAngles.x = 0
				var_530_4.localEulerAngles = var_530_4.localEulerAngles
			end

			local var_530_6 = arg_527_1.actors_["10083ui_story"]

			if 0 < arg_527_1.time_ and arg_527_1.time_ <= 0 + arg_530_0 and not isNil(var_530_6) and arg_527_1.var_.characterEffect10083ui_story == nil then
				arg_527_1.var_.characterEffect10083ui_story = var_530_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_530_7 = 0.200000002980232

			if 0 <= arg_527_1.time_ and arg_527_1.time_ < 0 + var_530_7 and not isNil(var_530_6) then
				if arg_527_1.var_.characterEffect10083ui_story and not isNil(var_530_6) then
					arg_527_1.var_.characterEffect10083ui_story.fillFlat = true
					arg_527_1.var_.characterEffect10083ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_527_1.time_ - 0) / var_530_7)
				end
			end

			if arg_527_1.time_ >= 0 + var_530_7 and arg_527_1.time_ < 0 + var_530_7 + arg_530_0 and not isNil(var_530_6) and arg_527_1.var_.characterEffect10083ui_story then
				arg_527_1.var_.characterEffect10083ui_story.fillFlat = true
				arg_527_1.var_.characterEffect10083ui_story.fillRatio = 0.5
			end

			local var_530_8 = 0
			local var_530_9 = 0.425

			if 0 < arg_527_1.time_ and arg_527_1.time_ <= var_530_8 + arg_530_0 then
				arg_527_1.talkMaxDuration = 0
				arg_527_1.dialogCg_.alpha = 1

				arg_527_1.dialog_:SetActive(true)
				SetActive(arg_527_1.leftNameGo_, true)

				arg_527_1.leftNameTxt_.text = arg_527_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_527_1.leftNameTxt_.transform)

				arg_527_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_527_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_527_1:RecordName(arg_527_1.leftNameTxt_.text)
				SetActive(arg_527_1.iconTrs_.gameObject, false)
				arg_527_1.callingController_:SetSelectedState("normal")

				local var_530_10 = arg_527_1:GetWordFromCfg(412031127)
				local var_530_11 = arg_527_1:FormatText(var_530_10.content)

				arg_527_1.text_.text = var_530_11

				LuaForUtil.ClearLinePrefixSymbol(arg_527_1.text_)

				local var_530_13 = 17 <= 0 and var_530_9 or var_530_9 * (utf8.len(var_530_11) / 17)

				if (17 <= 0 and var_530_9 or var_530_9 * (utf8.len(var_530_11) / 17)) > 0 and var_530_9 < var_530_13 then
					arg_527_1.talkMaxDuration = var_530_13

					if var_530_13 + var_530_8 > arg_527_1.duration_ then
						arg_527_1.duration_ = var_530_13 + var_530_8
					end
				end

				arg_527_1.text_.text = var_530_11
				arg_527_1.typewritter.percent = 0

				arg_527_1.typewritter:SetDirty()
				arg_527_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031127", "story_v_out_412031.awb") ~= 0 then
					local var_530_14 = manager.audio:GetVoiceLength("story_v_out_412031", "412031127", "story_v_out_412031.awb") / 1000

					if var_530_14 + var_530_8 > arg_527_1.duration_ then
						arg_527_1.duration_ = var_530_14 + var_530_8
					end

					if var_530_10.prefab_name ~= "" and arg_527_1.actors_[var_530_10.prefab_name] ~= nil then
						local var_530_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_527_1.actors_[var_530_10.prefab_name].transform, "story_v_out_412031", "412031127", "story_v_out_412031.awb")

						arg_527_1:RecordAudio("412031127", var_530_15)
						arg_527_1:RecordAudio("412031127", var_530_15)
					else
						arg_527_1:AudioAction("play", "voice", "story_v_out_412031", "412031127", "story_v_out_412031.awb")
					end

					arg_527_1:RecordHistoryTalkVoice("story_v_out_412031", "412031127", "story_v_out_412031.awb")
				end

				arg_527_1:RecordContent(arg_527_1.text_.text)
			end

			local var_530_16 = math.max(var_530_9, arg_527_1.talkMaxDuration)

			if var_530_8 <= arg_527_1.time_ and arg_527_1.time_ < var_530_8 + var_530_16 then
				arg_527_1.typewritter.percent = (arg_527_1.time_ - var_530_8) / var_530_16

				arg_527_1.typewritter:SetDirty()
			end

			if arg_527_1.time_ >= var_530_8 + var_530_16 and arg_527_1.time_ < var_530_8 + var_530_16 + arg_530_0 then
				arg_527_1.typewritter.percent = 1

				arg_527_1.typewritter:SetDirty()
				arg_527_1:ShowNextGo(true)
			end
		end

		arg_527_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10083ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_527_1:InitPlayNodeList()
	end,
	Play412031128 = function(arg_531_0, arg_531_1)
		arg_531_1.time_ = 0
		arg_531_1.frameCnt_ = 0
		arg_531_1.state_ = "playing"
		arg_531_1.curTalkId_ = 412031128
		arg_531_1.duration_ = 5

		SetActive(arg_531_1.tipsGo_, false)

		function arg_531_1.onSingleLineFinish_()
			arg_531_1.onSingleLineUpdate_ = nil
			arg_531_1.onSingleLineFinish_ = nil
			arg_531_1.state_ = "waiting"
		end

		function arg_531_1.playNext_(arg_533_0)
			if arg_533_0 == 1 then
				arg_531_0:Play412031129(arg_531_1)
			end
		end

		function arg_531_1.onSingleLineUpdate_(arg_534_0)
			if 0 < arg_531_1.time_ and arg_531_1.time_ <= 0 + arg_534_0 then
				arg_531_1.var_.moveOldPos1097ui_story = arg_531_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_534_0 = 0.001

			if 0 <= arg_531_1.time_ and arg_531_1.time_ < 0 + var_534_0 then
				arg_531_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_531_1.var_.moveOldPos1097ui_story, Vector3.New(0, 100, 0), (arg_531_1.time_ - 0) / var_534_0)
				arg_531_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_531_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_531_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_531_1.actors_["1097ui_story"].transform.position).z)
				arg_531_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_531_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_531_1.actors_["1097ui_story"].transform.localEulerAngles = arg_531_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_531_1.time_ >= 0 + var_534_0 and arg_531_1.time_ < 0 + var_534_0 + arg_534_0 then
				arg_531_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_531_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_531_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_531_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_531_1.actors_["1097ui_story"].transform.position).z)
				arg_531_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_531_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_531_1.actors_["1097ui_story"].transform.localEulerAngles = arg_531_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_534_1 = arg_531_1.actors_["1097ui_story"]

			if 0 < arg_531_1.time_ and arg_531_1.time_ <= 0 + arg_534_0 and not isNil(var_534_1) and arg_531_1.var_.characterEffect1097ui_story == nil then
				arg_531_1.var_.characterEffect1097ui_story = var_534_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_534_2 = 0.200000002980232

			if 0 <= arg_531_1.time_ and arg_531_1.time_ < 0 + var_534_2 and not isNil(var_534_1) then
				if arg_531_1.var_.characterEffect1097ui_story and not isNil(var_534_1) then
					arg_531_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_531_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_531_1.time_ - 0) / var_534_2)
				end
			end

			if arg_531_1.time_ >= 0 + var_534_2 and arg_531_1.time_ < 0 + var_534_2 + arg_534_0 and not isNil(var_534_1) and arg_531_1.var_.characterEffect1097ui_story then
				arg_531_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_531_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_534_3 = 0
			local var_534_4 = 1.1

			if 0 < arg_531_1.time_ and arg_531_1.time_ <= var_534_3 + arg_534_0 then
				arg_531_1.talkMaxDuration = 0
				arg_531_1.dialogCg_.alpha = 1

				arg_531_1.dialog_:SetActive(true)
				SetActive(arg_531_1.leftNameGo_, false)

				arg_531_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_531_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_531_1:RecordName(arg_531_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_531_1.iconTrs_.gameObject, false)
				arg_531_1.callingController_:SetSelectedState("normal")

				local var_534_5 = arg_531_1:FormatText(arg_531_1:GetWordFromCfg(412031128).content)

				arg_531_1.text_.text = var_534_5

				LuaForUtil.ClearLinePrefixSymbol(arg_531_1.text_)

				local var_534_7 = 44 <= 0 and var_534_4 or var_534_4 * (utf8.len(var_534_5) / 44)

				if (44 <= 0 and var_534_4 or var_534_4 * (utf8.len(var_534_5) / 44)) > 0 and var_534_4 < var_534_7 then
					arg_531_1.talkMaxDuration = var_534_7

					if var_534_7 + var_534_3 > arg_531_1.duration_ then
						arg_531_1.duration_ = var_534_7 + var_534_3
					end
				end

				arg_531_1.text_.text = var_534_5
				arg_531_1.typewritter.percent = 0

				arg_531_1.typewritter:SetDirty()
				arg_531_1:ShowNextGo(false)
				arg_531_1:RecordContent(arg_531_1.text_.text)
			end

			local var_534_8 = math.max(var_534_4, arg_531_1.talkMaxDuration)

			if var_534_3 <= arg_531_1.time_ and arg_531_1.time_ < var_534_3 + var_534_8 then
				arg_531_1.typewritter.percent = (arg_531_1.time_ - var_534_3) / var_534_8

				arg_531_1.typewritter:SetDirty()
			end

			if arg_531_1.time_ >= var_534_3 + var_534_8 and arg_531_1.time_ < var_534_3 + var_534_8 + arg_534_0 then
				arg_531_1.typewritter.percent = 1

				arg_531_1.typewritter:SetDirty()
				arg_531_1:ShowNextGo(true)
			end
		end

		arg_531_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_531_1:InitPlayNodeList()
	end,
	Play412031129 = function(arg_535_0, arg_535_1)
		arg_535_1.time_ = 0
		arg_535_1.frameCnt_ = 0
		arg_535_1.state_ = "playing"
		arg_535_1.curTalkId_ = 412031129
		arg_535_1.duration_ = 9

		SetActive(arg_535_1.tipsGo_, false)

		function arg_535_1.onSingleLineFinish_()
			arg_535_1.onSingleLineUpdate_ = nil
			arg_535_1.onSingleLineFinish_ = nil
			arg_535_1.state_ = "waiting"
		end

		function arg_535_1.playNext_(arg_537_0)
			if arg_537_0 == 1 then
				arg_535_0:Play412031130(arg_535_1)
			end
		end

		function arg_535_1.onSingleLineUpdate_(arg_538_0)
			if arg_535_1.bgs_.EN0103 == nil then
				local var_538_0 = Object.Instantiate(arg_535_1.paintGo_)

				var_538_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "EN0103")
				var_538_0.name = "EN0103"
				var_538_0.transform.parent = arg_535_1.stage_.transform
				var_538_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_535_1.bgs_.EN0103 = var_538_0
			end

			if 2 < arg_535_1.time_ and arg_535_1.time_ <= 2 + arg_538_0 then
				local var_538_1 = arg_535_1.bgs_.EN0103

				arg_535_1.bgs_.EN0103.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_538_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_538_2 = var_538_1:GetComponent("SpriteRenderer")

				if var_538_2 and var_538_2.sprite then
					local var_538_3 = 2 * (var_538_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_538_1.transform.localScale = Vector3.New(var_538_3 / var_538_2.sprite.bounds.size.y < var_538_3 * manager.ui.mainCameraCom_.aspect / var_538_2.sprite.bounds.size.x and var_538_3 * manager.ui.mainCameraCom_.aspect / var_538_2.sprite.bounds.size.x or var_538_3 / var_538_2.sprite.bounds.size.y, var_538_3 / var_538_2.sprite.bounds.size.y < var_538_3 * manager.ui.mainCameraCom_.aspect / var_538_2.sprite.bounds.size.x and var_538_3 * manager.ui.mainCameraCom_.aspect / var_538_2.sprite.bounds.size.x or var_538_3 / var_538_2.sprite.bounds.size.y, 0)
				end

				for iter_538_0, iter_538_1 in pairs(arg_535_1.bgs_) do
					if iter_538_0 ~= "EN0103" then
						iter_538_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_538_4 = 4

			if 4 < arg_535_1.time_ and arg_535_1.time_ <= var_538_4 + arg_538_0 then
				arg_535_1.allBtn_.enabled = false
			end

			if arg_535_1.time_ >= var_538_4 + 0.3 and arg_535_1.time_ < var_538_4 + 0.3 + arg_538_0 then
				arg_535_1.allBtn_.enabled = true
			end

			local var_538_5 = 0

			if 0 < arg_535_1.time_ and arg_535_1.time_ <= var_538_5 + arg_538_0 then
				arg_535_1.mask_.enabled = true
				arg_535_1.mask_.raycastTarget = true

				arg_535_1:SetGaussion(false)
			end

			local var_538_6 = 2

			if var_538_5 <= arg_535_1.time_ and arg_535_1.time_ < var_538_5 + var_538_6 then
				local var_538_7 = Color.New(0, 0, 0)

				var_538_7.a = Mathf.Lerp(0, 1, (arg_535_1.time_ - var_538_5) / var_538_6)
				arg_535_1.mask_.color = var_538_7
			end

			if arg_535_1.time_ >= var_538_5 + var_538_6 and arg_535_1.time_ < var_538_5 + var_538_6 + arg_538_0 then
				local var_538_8 = Color.New(0, 0, 0)

				var_538_8.a = 1
				arg_535_1.mask_.color = var_538_8
			end

			local var_538_9 = 2

			if 2 < arg_535_1.time_ and arg_535_1.time_ <= var_538_9 + arg_538_0 then
				arg_535_1.mask_.enabled = true
				arg_535_1.mask_.raycastTarget = true

				arg_535_1:SetGaussion(false)
			end

			local var_538_10 = 2

			if var_538_9 <= arg_535_1.time_ and arg_535_1.time_ < var_538_9 + var_538_10 then
				local var_538_11 = Color.New(0, 0, 0)

				var_538_11.a = Mathf.Lerp(1, 0, (arg_535_1.time_ - var_538_9) / var_538_10)
				arg_535_1.mask_.color = var_538_11
			end

			if arg_535_1.time_ >= var_538_9 + var_538_10 and arg_535_1.time_ < var_538_9 + var_538_10 + arg_538_0 then
				local var_538_12 = Color.New(0, 0, 0)

				arg_535_1.mask_.enabled = false
				var_538_12.a = 0
				arg_535_1.mask_.color = var_538_12
			end

			if 0 < arg_535_1.time_ and arg_535_1.time_ <= 0 + arg_538_0 then
				arg_535_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_538_15 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_535_1.bgmTxt_.text ~= var_538_15 and arg_535_1.bgmTxt_.text ~= "" then
						if arg_535_1.bgmTxt2_.text ~= "" then
							arg_535_1.bgmTxt_.text = arg_535_1.bgmTxt2_.text
						end

						arg_535_1.bgmTxt2_.text = var_538_15

						arg_535_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_535_1.bgmTxt_.text = var_538_15
						arg_535_1.bgmTxt2_.text = var_538_15
					end

					if arg_535_1.bgmTimer then
						arg_535_1.bgmTimer:Stop()

						arg_535_1.bgmTimer = nil
					end

					if arg_535_1.settingData.show_music_name == 1 then
						arg_535_1.musicController:SetSelectedState("show")
						arg_535_1.musicAnimator_:Play("open", 0, 0)

						if arg_535_1.settingData.music_time ~= 0 then
							arg_535_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_535_1.settingData.music_time), function()
								if arg_535_1 == nil or isNil(arg_535_1.bgmTxt_) then
									return
								end

								arg_535_1.musicController:SetSelectedState("hide")
								arg_535_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_538_16 = arg_535_1.bgs_.EN0103.transform

			if 2 < arg_535_1.time_ and arg_535_1.time_ <= 2 + arg_538_0 then
				arg_535_1.var_.moveOldPosEN0103 = var_538_16.localPosition
			end

			local var_538_17 = 3

			if 2 <= arg_535_1.time_ and arg_535_1.time_ < 2 + var_538_17 then
				var_538_16.localPosition = Vector3.Lerp(arg_535_1.var_.moveOldPosEN0103, Vector3.New(0, 1, 9), (arg_535_1.time_ - 2) / var_538_17)
			end

			if arg_535_1.time_ >= 2 + var_538_17 and arg_535_1.time_ < 2 + var_538_17 + arg_538_0 then
				var_538_16.localPosition = Vector3.New(0, 1, 9)
			end

			local var_538_18 = 4

			if 4 < arg_535_1.time_ and arg_535_1.time_ <= var_538_18 + arg_538_0 then
				arg_535_1.allBtn_.enabled = false
			end

			if arg_535_1.time_ >= var_538_18 + 1 and arg_535_1.time_ < var_538_18 + 1 + arg_538_0 then
				arg_535_1.allBtn_.enabled = true
			end

			if arg_535_1.frameCnt_ <= 1 then
				arg_535_1.dialog_:SetActive(false)
			end

			local var_538_19 = 4
			local var_538_20 = 0.45

			if 4 < arg_535_1.time_ and arg_535_1.time_ <= var_538_19 + arg_538_0 then
				arg_535_1.talkMaxDuration = 0

				arg_535_1.dialog_:SetActive(true)

				arg_535_1.dialogCg_.alpha = 0

				local var_538_21 = LeanTween.value(arg_535_1.dialog_, 0, 1, 0.3)

				var_538_21:setOnUpdate(LuaHelper.FloatAction(function(arg_540_0)
					arg_535_1.dialogCg_.alpha = arg_540_0
				end))
				var_538_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_535_1.dialog_)
					var_538_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_535_1.duration_ = arg_535_1.duration_ + 0.3

				SetActive(arg_535_1.leftNameGo_, false)

				arg_535_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_535_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_535_1:RecordName(arg_535_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_535_1.iconTrs_.gameObject, false)
				arg_535_1.callingController_:SetSelectedState("normal")

				local var_538_22 = arg_535_1:FormatText(arg_535_1:GetWordFromCfg(412031129).content)

				arg_535_1.text_.text = var_538_22

				LuaForUtil.ClearLinePrefixSymbol(arg_535_1.text_)

				local var_538_24 = 18 <= 0 and var_538_20 or var_538_20 * (utf8.len(var_538_22) / 18)

				if (18 <= 0 and var_538_20 or var_538_20 * (utf8.len(var_538_22) / 18)) > 0 and var_538_20 < var_538_24 then
					arg_535_1.talkMaxDuration = var_538_24
					var_538_19 = var_538_19 + 0.3

					if var_538_24 + var_538_19 > arg_535_1.duration_ then
						arg_535_1.duration_ = var_538_24 + var_538_19
					end
				end

				arg_535_1.text_.text = var_538_22
				arg_535_1.typewritter.percent = 0

				arg_535_1.typewritter:SetDirty()
				arg_535_1:ShowNextGo(false)
				arg_535_1:RecordContent(arg_535_1.text_.text)
			end

			local var_538_25 = var_538_19 + 0.3
			local var_538_26 = math.max(var_538_20, arg_535_1.talkMaxDuration)

			if var_538_19 + 0.3 <= arg_535_1.time_ and arg_535_1.time_ < var_538_25 + var_538_26 then
				arg_535_1.typewritter.percent = (arg_535_1.time_ - var_538_25) / var_538_26

				arg_535_1.typewritter:SetDirty()
			end

			if arg_535_1.time_ >= var_538_25 + var_538_26 and arg_535_1.time_ < var_538_25 + var_538_26 + arg_538_0 then
				arg_535_1.typewritter.percent = 1

				arg_535_1.typewritter:SetDirty()
				arg_535_1:ShowNextGo(true)
			end
		end

		arg_535_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "EN0103",
				changeDisplayLayer = false,
				needEase = false,
				duration = 3,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_535_1:InitPlayNodeList()
	end,
	Play412031130 = function(arg_542_0, arg_542_1)
		arg_542_1.time_ = 0
		arg_542_1.frameCnt_ = 0
		arg_542_1.state_ = "playing"
		arg_542_1.curTalkId_ = 412031130
		arg_542_1.duration_ = 5

		SetActive(arg_542_1.tipsGo_, false)

		function arg_542_1.onSingleLineFinish_()
			arg_542_1.onSingleLineUpdate_ = nil
			arg_542_1.onSingleLineFinish_ = nil
			arg_542_1.state_ = "waiting"
		end

		function arg_542_1.playNext_(arg_544_0)
			if arg_544_0 == 1 then
				arg_542_0:Play412031131(arg_542_1)
			end
		end

		function arg_542_1.onSingleLineUpdate_(arg_545_0)
			local var_545_0 = 0.85

			if 0 < arg_542_1.time_ and arg_542_1.time_ <= 0 + arg_545_0 then
				arg_542_1.talkMaxDuration = 0
				arg_542_1.dialogCg_.alpha = 1

				arg_542_1.dialog_:SetActive(true)
				SetActive(arg_542_1.leftNameGo_, false)

				arg_542_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_542_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_542_1:RecordName(arg_542_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_542_1.iconTrs_.gameObject, false)
				arg_542_1.callingController_:SetSelectedState("normal")

				local var_545_1 = arg_542_1:FormatText(arg_542_1:GetWordFromCfg(412031130).content)

				arg_542_1.text_.text = var_545_1

				LuaForUtil.ClearLinePrefixSymbol(arg_542_1.text_)

				local var_545_3 = 34 <= 0 and var_545_0 or var_545_0 * (utf8.len(var_545_1) / 34)

				if (34 <= 0 and var_545_0 or var_545_0 * (utf8.len(var_545_1) / 34)) > 0 and var_545_0 < var_545_3 then
					arg_542_1.talkMaxDuration = var_545_3

					if var_545_3 + 0 > arg_542_1.duration_ then
						arg_542_1.duration_ = var_545_3 + 0
					end
				end

				arg_542_1.text_.text = var_545_1
				arg_542_1.typewritter.percent = 0

				arg_542_1.typewritter:SetDirty()
				arg_542_1:ShowNextGo(false)
				arg_542_1:RecordContent(arg_542_1.text_.text)
			end

			local var_545_4 = math.max(var_545_0, arg_542_1.talkMaxDuration)

			if 0 <= arg_542_1.time_ and arg_542_1.time_ < 0 + var_545_4 then
				arg_542_1.typewritter.percent = (arg_542_1.time_ - 0) / var_545_4

				arg_542_1.typewritter:SetDirty()
			end

			if arg_542_1.time_ >= 0 + var_545_4 and arg_542_1.time_ < 0 + var_545_4 + arg_545_0 then
				arg_542_1.typewritter.percent = 1

				arg_542_1.typewritter:SetDirty()
				arg_542_1:ShowNextGo(true)
			end
		end

		arg_542_1.nodeConfigList_ = {}

		arg_542_1:InitPlayNodeList()
	end,
	Play412031131 = function(arg_546_0, arg_546_1)
		arg_546_1.time_ = 0
		arg_546_1.frameCnt_ = 0
		arg_546_1.state_ = "playing"
		arg_546_1.curTalkId_ = 412031131
		arg_546_1.duration_ = 5

		SetActive(arg_546_1.tipsGo_, false)

		function arg_546_1.onSingleLineFinish_()
			arg_546_1.onSingleLineUpdate_ = nil
			arg_546_1.onSingleLineFinish_ = nil
			arg_546_1.state_ = "waiting"
		end

		function arg_546_1.playNext_(arg_548_0)
			if arg_548_0 == 1 then
				arg_546_0:Play412031132(arg_546_1)
			end
		end

		function arg_546_1.onSingleLineUpdate_(arg_549_0)
			local var_549_0 = 0.45

			if 0 < arg_546_1.time_ and arg_546_1.time_ <= 0 + arg_549_0 then
				arg_546_1.talkMaxDuration = 0
				arg_546_1.dialogCg_.alpha = 1

				arg_546_1.dialog_:SetActive(true)
				SetActive(arg_546_1.leftNameGo_, false)

				arg_546_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_546_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_546_1:RecordName(arg_546_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_546_1.iconTrs_.gameObject, false)
				arg_546_1.callingController_:SetSelectedState("normal")

				local var_549_1 = arg_546_1:FormatText(arg_546_1:GetWordFromCfg(412031131).content)

				arg_546_1.text_.text = var_549_1

				LuaForUtil.ClearLinePrefixSymbol(arg_546_1.text_)

				local var_549_3 = 18 <= 0 and var_549_0 or var_549_0 * (utf8.len(var_549_1) / 18)

				if (18 <= 0 and var_549_0 or var_549_0 * (utf8.len(var_549_1) / 18)) > 0 and var_549_0 < var_549_3 then
					arg_546_1.talkMaxDuration = var_549_3

					if var_549_3 + 0 > arg_546_1.duration_ then
						arg_546_1.duration_ = var_549_3 + 0
					end
				end

				arg_546_1.text_.text = var_549_1
				arg_546_1.typewritter.percent = 0

				arg_546_1.typewritter:SetDirty()
				arg_546_1:ShowNextGo(false)
				arg_546_1:RecordContent(arg_546_1.text_.text)
			end

			local var_549_4 = math.max(var_549_0, arg_546_1.talkMaxDuration)

			if 0 <= arg_546_1.time_ and arg_546_1.time_ < 0 + var_549_4 then
				arg_546_1.typewritter.percent = (arg_546_1.time_ - 0) / var_549_4

				arg_546_1.typewritter:SetDirty()
			end

			if arg_546_1.time_ >= 0 + var_549_4 and arg_546_1.time_ < 0 + var_549_4 + arg_549_0 then
				arg_546_1.typewritter.percent = 1

				arg_546_1.typewritter:SetDirty()
				arg_546_1:ShowNextGo(true)
			end
		end

		arg_546_1.nodeConfigList_ = {}

		arg_546_1:InitPlayNodeList()
	end,
	Play412031132 = function(arg_550_0, arg_550_1)
		arg_550_1.time_ = 0
		arg_550_1.frameCnt_ = 0
		arg_550_1.state_ = "playing"
		arg_550_1.curTalkId_ = 412031132
		arg_550_1.duration_ = 5

		SetActive(arg_550_1.tipsGo_, false)

		function arg_550_1.onSingleLineFinish_()
			arg_550_1.onSingleLineUpdate_ = nil
			arg_550_1.onSingleLineFinish_ = nil
			arg_550_1.state_ = "waiting"
		end

		function arg_550_1.playNext_(arg_552_0)
			if arg_552_0 == 1 then
				arg_550_0:Play412031133(arg_550_1)
			end
		end

		function arg_550_1.onSingleLineUpdate_(arg_553_0)
			local var_553_0 = 1.075

			if 0 < arg_550_1.time_ and arg_550_1.time_ <= 0 + arg_553_0 then
				arg_550_1.talkMaxDuration = 0
				arg_550_1.dialogCg_.alpha = 1

				arg_550_1.dialog_:SetActive(true)
				SetActive(arg_550_1.leftNameGo_, false)

				arg_550_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_550_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_550_1:RecordName(arg_550_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_550_1.iconTrs_.gameObject, false)
				arg_550_1.callingController_:SetSelectedState("normal")

				local var_553_1 = arg_550_1:FormatText(arg_550_1:GetWordFromCfg(412031132).content)

				arg_550_1.text_.text = var_553_1

				LuaForUtil.ClearLinePrefixSymbol(arg_550_1.text_)

				local var_553_3 = 43 <= 0 and var_553_0 or var_553_0 * (utf8.len(var_553_1) / 43)

				if (43 <= 0 and var_553_0 or var_553_0 * (utf8.len(var_553_1) / 43)) > 0 and var_553_0 < var_553_3 then
					arg_550_1.talkMaxDuration = var_553_3

					if var_553_3 + 0 > arg_550_1.duration_ then
						arg_550_1.duration_ = var_553_3 + 0
					end
				end

				arg_550_1.text_.text = var_553_1
				arg_550_1.typewritter.percent = 0

				arg_550_1.typewritter:SetDirty()
				arg_550_1:ShowNextGo(false)
				arg_550_1:RecordContent(arg_550_1.text_.text)
			end

			local var_553_4 = math.max(var_553_0, arg_550_1.talkMaxDuration)

			if 0 <= arg_550_1.time_ and arg_550_1.time_ < 0 + var_553_4 then
				arg_550_1.typewritter.percent = (arg_550_1.time_ - 0) / var_553_4

				arg_550_1.typewritter:SetDirty()
			end

			if arg_550_1.time_ >= 0 + var_553_4 and arg_550_1.time_ < 0 + var_553_4 + arg_553_0 then
				arg_550_1.typewritter.percent = 1

				arg_550_1.typewritter:SetDirty()
				arg_550_1:ShowNextGo(true)
			end
		end

		arg_550_1.nodeConfigList_ = {}

		arg_550_1:InitPlayNodeList()
	end,
	Play412031133 = function(arg_554_0, arg_554_1)
		arg_554_1.time_ = 0
		arg_554_1.frameCnt_ = 0
		arg_554_1.state_ = "playing"
		arg_554_1.curTalkId_ = 412031133
		arg_554_1.duration_ = 6.33

		local var_554_0 = {
			zh = 6.1,
			ja = 6.333
		}
		local var_554_1 = manager.audio:GetLocalizationFlag()

		if var_554_0[var_554_1] ~= nil then
			arg_554_1.duration_ = var_554_0[var_554_1]
		end

		SetActive(arg_554_1.tipsGo_, false)

		function arg_554_1.onSingleLineFinish_()
			arg_554_1.onSingleLineUpdate_ = nil
			arg_554_1.onSingleLineFinish_ = nil
			arg_554_1.state_ = "waiting"
		end

		function arg_554_1.playNext_(arg_556_0)
			if arg_556_0 == 1 then
				arg_554_0:Play412031134(arg_554_1)
			end
		end

		function arg_554_1.onSingleLineUpdate_(arg_557_0)
			local var_557_0 = 0.6

			if 0 < arg_554_1.time_ and arg_554_1.time_ <= 0 + arg_557_0 then
				arg_554_1.talkMaxDuration = 0
				arg_554_1.dialogCg_.alpha = 1

				arg_554_1.dialog_:SetActive(true)
				SetActive(arg_554_1.leftNameGo_, true)

				arg_554_1.leftNameTxt_.text = arg_554_1:FormatText(StoryNameCfg[917].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_554_1.leftNameTxt_.transform)

				arg_554_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_554_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_554_1:RecordName(arg_554_1.leftNameTxt_.text)
				SetActive(arg_554_1.iconTrs_.gameObject, true)
				arg_554_1.iconController_:SetSelectedState("hero")

				arg_554_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10076")

				arg_554_1.callingController_:SetSelectedState("normal")

				arg_554_1.keyicon_.color = Color.New(1, 1, 1)
				arg_554_1.icon_.color = Color.New(1, 1, 1)

				local var_557_1 = arg_554_1:GetWordFromCfg(412031133)
				local var_557_2 = arg_554_1:FormatText(var_557_1.content)

				arg_554_1.text_.text = var_557_2

				LuaForUtil.ClearLinePrefixSymbol(arg_554_1.text_)

				local var_557_4 = 24 <= 0 and var_557_0 or var_557_0 * (utf8.len(var_557_2) / 24)

				if (24 <= 0 and var_557_0 or var_557_0 * (utf8.len(var_557_2) / 24)) > 0 and var_557_0 < var_557_4 then
					arg_554_1.talkMaxDuration = var_557_4

					if var_557_4 + 0 > arg_554_1.duration_ then
						arg_554_1.duration_ = var_557_4 + 0
					end
				end

				arg_554_1.text_.text = var_557_2
				arg_554_1.typewritter.percent = 0

				arg_554_1.typewritter:SetDirty()
				arg_554_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031133", "story_v_out_412031.awb") ~= 0 then
					local var_557_5 = manager.audio:GetVoiceLength("story_v_out_412031", "412031133", "story_v_out_412031.awb") / 1000

					if var_557_5 + 0 > arg_554_1.duration_ then
						arg_554_1.duration_ = var_557_5 + 0
					end

					if var_557_1.prefab_name ~= "" and arg_554_1.actors_[var_557_1.prefab_name] ~= nil then
						local var_557_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_554_1.actors_[var_557_1.prefab_name].transform, "story_v_out_412031", "412031133", "story_v_out_412031.awb")

						arg_554_1:RecordAudio("412031133", var_557_6)
						arg_554_1:RecordAudio("412031133", var_557_6)
					else
						arg_554_1:AudioAction("play", "voice", "story_v_out_412031", "412031133", "story_v_out_412031.awb")
					end

					arg_554_1:RecordHistoryTalkVoice("story_v_out_412031", "412031133", "story_v_out_412031.awb")
				end

				arg_554_1:RecordContent(arg_554_1.text_.text)
			end

			local var_557_7 = math.max(var_557_0, arg_554_1.talkMaxDuration)

			if 0 <= arg_554_1.time_ and arg_554_1.time_ < 0 + var_557_7 then
				arg_554_1.typewritter.percent = (arg_554_1.time_ - 0) / var_557_7

				arg_554_1.typewritter:SetDirty()
			end

			if arg_554_1.time_ >= 0 + var_557_7 and arg_554_1.time_ < 0 + var_557_7 + arg_557_0 then
				arg_554_1.typewritter.percent = 1

				arg_554_1.typewritter:SetDirty()
				arg_554_1:ShowNextGo(true)
			end
		end

		arg_554_1.nodeConfigList_ = {}

		arg_554_1:InitPlayNodeList()
	end,
	Play412031134 = function(arg_558_0, arg_558_1)
		arg_558_1.time_ = 0
		arg_558_1.frameCnt_ = 0
		arg_558_1.state_ = "playing"
		arg_558_1.curTalkId_ = 412031134
		arg_558_1.duration_ = 5

		local var_558_0 = {
			zh = 4,
			ja = 5
		}
		local var_558_1 = manager.audio:GetLocalizationFlag()

		if var_558_0[var_558_1] ~= nil then
			arg_558_1.duration_ = var_558_0[var_558_1]
		end

		SetActive(arg_558_1.tipsGo_, false)

		function arg_558_1.onSingleLineFinish_()
			arg_558_1.onSingleLineUpdate_ = nil
			arg_558_1.onSingleLineFinish_ = nil
			arg_558_1.state_ = "waiting"
		end

		function arg_558_1.playNext_(arg_560_0)
			if arg_560_0 == 1 then
				arg_558_0:Play412031135(arg_558_1)
			end
		end

		function arg_558_1.onSingleLineUpdate_(arg_561_0)
			local var_561_0 = 0.275

			if 0 < arg_558_1.time_ and arg_558_1.time_ <= 0 + arg_561_0 then
				arg_558_1.talkMaxDuration = 0
				arg_558_1.dialogCg_.alpha = 1

				arg_558_1.dialog_:SetActive(true)
				SetActive(arg_558_1.leftNameGo_, true)

				arg_558_1.leftNameTxt_.text = arg_558_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_558_1.leftNameTxt_.transform)

				arg_558_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_558_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_558_1:RecordName(arg_558_1.leftNameTxt_.text)
				SetActive(arg_558_1.iconTrs_.gameObject, false)
				arg_558_1.callingController_:SetSelectedState("normal")

				local var_561_1 = arg_558_1:GetWordFromCfg(412031134)
				local var_561_2 = arg_558_1:FormatText(var_561_1.content)

				arg_558_1.text_.text = var_561_2

				LuaForUtil.ClearLinePrefixSymbol(arg_558_1.text_)

				local var_561_4 = 11 <= 0 and var_561_0 or var_561_0 * (utf8.len(var_561_2) / 11)

				if (11 <= 0 and var_561_0 or var_561_0 * (utf8.len(var_561_2) / 11)) > 0 and var_561_0 < var_561_4 then
					arg_558_1.talkMaxDuration = var_561_4

					if var_561_4 + 0 > arg_558_1.duration_ then
						arg_558_1.duration_ = var_561_4 + 0
					end
				end

				arg_558_1.text_.text = var_561_2
				arg_558_1.typewritter.percent = 0

				arg_558_1.typewritter:SetDirty()
				arg_558_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031134", "story_v_out_412031.awb") ~= 0 then
					local var_561_5 = manager.audio:GetVoiceLength("story_v_out_412031", "412031134", "story_v_out_412031.awb") / 1000

					if var_561_5 + 0 > arg_558_1.duration_ then
						arg_558_1.duration_ = var_561_5 + 0
					end

					if var_561_1.prefab_name ~= "" and arg_558_1.actors_[var_561_1.prefab_name] ~= nil then
						local var_561_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_558_1.actors_[var_561_1.prefab_name].transform, "story_v_out_412031", "412031134", "story_v_out_412031.awb")

						arg_558_1:RecordAudio("412031134", var_561_6)
						arg_558_1:RecordAudio("412031134", var_561_6)
					else
						arg_558_1:AudioAction("play", "voice", "story_v_out_412031", "412031134", "story_v_out_412031.awb")
					end

					arg_558_1:RecordHistoryTalkVoice("story_v_out_412031", "412031134", "story_v_out_412031.awb")
				end

				arg_558_1:RecordContent(arg_558_1.text_.text)
			end

			local var_561_7 = math.max(var_561_0, arg_558_1.talkMaxDuration)

			if 0 <= arg_558_1.time_ and arg_558_1.time_ < 0 + var_561_7 then
				arg_558_1.typewritter.percent = (arg_558_1.time_ - 0) / var_561_7

				arg_558_1.typewritter:SetDirty()
			end

			if arg_558_1.time_ >= 0 + var_561_7 and arg_558_1.time_ < 0 + var_561_7 + arg_561_0 then
				arg_558_1.typewritter.percent = 1

				arg_558_1.typewritter:SetDirty()
				arg_558_1:ShowNextGo(true)
			end
		end

		arg_558_1.nodeConfigList_ = {}

		arg_558_1:InitPlayNodeList()
	end,
	Play412031135 = function(arg_562_0, arg_562_1)
		arg_562_1.time_ = 0
		arg_562_1.frameCnt_ = 0
		arg_562_1.state_ = "playing"
		arg_562_1.curTalkId_ = 412031135
		arg_562_1.duration_ = 5.13

		local var_562_0 = {
			zh = 3.833,
			ja = 5.133
		}
		local var_562_1 = manager.audio:GetLocalizationFlag()

		if var_562_0[var_562_1] ~= nil then
			arg_562_1.duration_ = var_562_0[var_562_1]
		end

		SetActive(arg_562_1.tipsGo_, false)

		function arg_562_1.onSingleLineFinish_()
			arg_562_1.onSingleLineUpdate_ = nil
			arg_562_1.onSingleLineFinish_ = nil
			arg_562_1.state_ = "waiting"
			arg_562_1.auto_ = false
		end

		function arg_562_1.playNext_(arg_564_0)
			arg_562_1.onStoryFinished_()
		end

		function arg_562_1.onSingleLineUpdate_(arg_565_0)
			local var_565_0 = 0.25

			if 0 < arg_562_1.time_ and arg_562_1.time_ <= 0 + arg_565_0 then
				arg_562_1.talkMaxDuration = 0
				arg_562_1.dialogCg_.alpha = 1

				arg_562_1.dialog_:SetActive(true)
				SetActive(arg_562_1.leftNameGo_, true)

				arg_562_1.leftNameTxt_.text = arg_562_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_562_1.leftNameTxt_.transform)

				arg_562_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_562_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_562_1:RecordName(arg_562_1.leftNameTxt_.text)
				SetActive(arg_562_1.iconTrs_.gameObject, false)
				arg_562_1.callingController_:SetSelectedState("normal")

				local var_565_1 = arg_562_1:GetWordFromCfg(412031135)
				local var_565_2 = arg_562_1:FormatText(var_565_1.content)

				arg_562_1.text_.text = var_565_2

				LuaForUtil.ClearLinePrefixSymbol(arg_562_1.text_)

				local var_565_4 = 10 <= 0 and var_565_0 or var_565_0 * (utf8.len(var_565_2) / 10)

				if (10 <= 0 and var_565_0 or var_565_0 * (utf8.len(var_565_2) / 10)) > 0 and var_565_0 < var_565_4 then
					arg_562_1.talkMaxDuration = var_565_4

					if var_565_4 + 0 > arg_562_1.duration_ then
						arg_562_1.duration_ = var_565_4 + 0
					end
				end

				arg_562_1.text_.text = var_565_2
				arg_562_1.typewritter.percent = 0

				arg_562_1.typewritter:SetDirty()
				arg_562_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031135", "story_v_out_412031.awb") ~= 0 then
					local var_565_5 = manager.audio:GetVoiceLength("story_v_out_412031", "412031135", "story_v_out_412031.awb") / 1000

					if var_565_5 + 0 > arg_562_1.duration_ then
						arg_562_1.duration_ = var_565_5 + 0
					end

					if var_565_1.prefab_name ~= "" and arg_562_1.actors_[var_565_1.prefab_name] ~= nil then
						local var_565_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_562_1.actors_[var_565_1.prefab_name].transform, "story_v_out_412031", "412031135", "story_v_out_412031.awb")

						arg_562_1:RecordAudio("412031135", var_565_6)
						arg_562_1:RecordAudio("412031135", var_565_6)
					else
						arg_562_1:AudioAction("play", "voice", "story_v_out_412031", "412031135", "story_v_out_412031.awb")
					end

					arg_562_1:RecordHistoryTalkVoice("story_v_out_412031", "412031135", "story_v_out_412031.awb")
				end

				arg_562_1:RecordContent(arg_562_1.text_.text)
			end

			local var_565_7 = math.max(var_565_0, arg_562_1.talkMaxDuration)

			if 0 <= arg_562_1.time_ and arg_562_1.time_ < 0 + var_565_7 then
				arg_562_1.typewritter.percent = (arg_562_1.time_ - 0) / var_565_7

				arg_562_1.typewritter:SetDirty()
			end

			if arg_562_1.time_ >= 0 + var_565_7 and arg_562_1.time_ < 0 + var_565_7 + arg_565_0 then
				arg_562_1.typewritter.percent = 1

				arg_562_1.typewritter:SetDirty()
				arg_562_1:ShowNextGo(true)
			end
		end

		arg_562_1.nodeConfigList_ = {}

		arg_562_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/I09j",
		"TextureConfig/Background/ST30",
		"TextureConfig/Background/EN0101",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/EN0103"
	},
	voices = {
		"story_v_out_412031.awb"
	}
}
