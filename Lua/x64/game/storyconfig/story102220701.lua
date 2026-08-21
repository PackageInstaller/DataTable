return {
	Play222071001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 222071001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play222071002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "ST47"

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
				local var_4_5 = arg_1_1.bgs_.ST47

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
					if iter_4_0 ~= "ST47" then
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
			local var_4_23 = 0.7

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

			local var_4_28 = 0.9
			local var_4_29 = 1

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				local var_4_30 = "play"
				local var_4_31 = "music"

				arg_1_1:AudioAction(var_4_30, var_4_31, "bgm_activity_2_1_story_city", "bgm_activity_2_1_story_city", "bgm_activity_2_1_story_city.awb")

				local var_4_32 = ""
				local var_4_33 = manager.audio:GetAudioName("bgm_activity_2_1_story_city", "bgm_activity_2_1_story_city")

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

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_34 = 2
			local var_4_35 = 0.35

			if var_4_34 < arg_1_1.time_ and arg_1_1.time_ <= var_4_34 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_36 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_36:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_36:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_36:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_37 = arg_1_1:GetWordFromCfg(222071001)
				local var_4_38 = arg_1_1:FormatText(var_4_37.content)

				arg_1_1.text_.text = var_4_38

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_39 = 14
				local var_4_40 = utf8.len(var_4_38)
				local var_4_41 = var_4_39 <= 0 and var_4_35 or var_4_35 * (var_4_40 / var_4_39)

				if var_4_41 > 0 and var_4_35 < var_4_41 then
					arg_1_1.talkMaxDuration = var_4_41
					var_4_34 = var_4_34 + 0.3

					if var_4_41 + var_4_34 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_41 + var_4_34
					end
				end

				arg_1_1.text_.text = var_4_38
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_42 = var_4_34 + 0.3
			local var_4_43 = math.max(var_4_35, arg_1_1.talkMaxDuration)

			if var_4_42 <= arg_1_1.time_ and arg_1_1.time_ < var_4_42 + var_4_43 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_42) / var_4_43

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_42 + var_4_43 and arg_1_1.time_ < var_4_42 + var_4_43 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play222071002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 222071002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play222071003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0
			local var_12_1 = 0.825

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

				local var_12_2 = arg_9_1:GetWordFromCfg(222071002)
				local var_12_3 = arg_9_1:FormatText(var_12_2.content)

				arg_9_1.text_.text = var_12_3

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_4 = 33
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
	Play222071003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 222071003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play222071004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0
			local var_16_1 = 0.8

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

				local var_16_2 = arg_13_1:GetWordFromCfg(222071003)
				local var_16_3 = arg_13_1:FormatText(var_16_2.content)

				arg_13_1.text_.text = var_16_3

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_4 = 32
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
	Play222071004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 222071004
		arg_17_1.duration_ = 6.07

		local var_17_0 = {
			ja = 6.066,
			ko = 5.333,
			zh = 5.333
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
				arg_17_0:Play222071005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0
			local var_20_1 = 0.375

			if var_20_0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_0 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_2 = arg_17_1:FormatText(StoryNameCfg[466].name)

				arg_17_1.leftNameTxt_.text = var_20_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, true)
				arg_17_1.iconController_:SetSelectedState("hero")

				arg_17_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwc")

				arg_17_1.callingController_:SetSelectedState("normal")

				arg_17_1.keyicon_.color = Color.New(1, 1, 1)
				arg_17_1.icon_.color = Color.New(1, 1, 1)

				local var_20_3 = arg_17_1:GetWordFromCfg(222071004)
				local var_20_4 = arg_17_1:FormatText(var_20_3.content)

				arg_17_1.text_.text = var_20_4

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_5 = 15
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

				if manager.audio:GetVoiceLength("story_v_out_222071", "222071004", "story_v_out_222071.awb") ~= 0 then
					local var_20_8 = manager.audio:GetVoiceLength("story_v_out_222071", "222071004", "story_v_out_222071.awb") / 1000

					if var_20_8 + var_20_0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_8 + var_20_0
					end

					if var_20_3.prefab_name ~= "" and arg_17_1.actors_[var_20_3.prefab_name] ~= nil then
						local var_20_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_3.prefab_name].transform, "story_v_out_222071", "222071004", "story_v_out_222071.awb")

						arg_17_1:RecordAudio("222071004", var_20_9)
						arg_17_1:RecordAudio("222071004", var_20_9)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_222071", "222071004", "story_v_out_222071.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_222071", "222071004", "story_v_out_222071.awb")
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
	Play222071005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 222071005
		arg_21_1.duration_ = 5.43

		local var_21_0 = {
			ja = 5.366,
			ko = 5.433,
			zh = 5.433
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
				arg_21_0:Play222071006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 0
			local var_24_1 = 0.75

			if var_24_0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_0 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_2 = arg_21_1:FormatText(StoryNameCfg[465].name)

				arg_21_1.leftNameTxt_.text = var_24_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, true)
				arg_21_1.iconController_:SetSelectedState("hero")

				arg_21_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_21_1.callingController_:SetSelectedState("normal")

				arg_21_1.keyicon_.color = Color.New(1, 1, 1)
				arg_21_1.icon_.color = Color.New(1, 1, 1)

				local var_24_3 = arg_21_1:GetWordFromCfg(222071005)
				local var_24_4 = arg_21_1:FormatText(var_24_3.content)

				arg_21_1.text_.text = var_24_4

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_5 = 30
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

				if manager.audio:GetVoiceLength("story_v_out_222071", "222071005", "story_v_out_222071.awb") ~= 0 then
					local var_24_8 = manager.audio:GetVoiceLength("story_v_out_222071", "222071005", "story_v_out_222071.awb") / 1000

					if var_24_8 + var_24_0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_8 + var_24_0
					end

					if var_24_3.prefab_name ~= "" and arg_21_1.actors_[var_24_3.prefab_name] ~= nil then
						local var_24_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_3.prefab_name].transform, "story_v_out_222071", "222071005", "story_v_out_222071.awb")

						arg_21_1:RecordAudio("222071005", var_24_9)
						arg_21_1:RecordAudio("222071005", var_24_9)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_222071", "222071005", "story_v_out_222071.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_222071", "222071005", "story_v_out_222071.awb")
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
	Play222071006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 222071006
		arg_25_1.duration_ = 10.1

		local var_25_0 = {
			ja = 10.1,
			ko = 7.766,
			zh = 7.766
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
				arg_25_0:Play222071007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 0
			local var_28_1 = 0.95

			if var_28_0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_0 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_2 = arg_25_1:FormatText(StoryNameCfg[465].name)

				arg_25_1.leftNameTxt_.text = var_28_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, true)
				arg_25_1.iconController_:SetSelectedState("hero")

				arg_25_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_25_1.callingController_:SetSelectedState("normal")

				arg_25_1.keyicon_.color = Color.New(1, 1, 1)
				arg_25_1.icon_.color = Color.New(1, 1, 1)

				local var_28_3 = arg_25_1:GetWordFromCfg(222071006)
				local var_28_4 = arg_25_1:FormatText(var_28_3.content)

				arg_25_1.text_.text = var_28_4

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_5 = 38
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

				if manager.audio:GetVoiceLength("story_v_out_222071", "222071006", "story_v_out_222071.awb") ~= 0 then
					local var_28_8 = manager.audio:GetVoiceLength("story_v_out_222071", "222071006", "story_v_out_222071.awb") / 1000

					if var_28_8 + var_28_0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_8 + var_28_0
					end

					if var_28_3.prefab_name ~= "" and arg_25_1.actors_[var_28_3.prefab_name] ~= nil then
						local var_28_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_3.prefab_name].transform, "story_v_out_222071", "222071006", "story_v_out_222071.awb")

						arg_25_1:RecordAudio("222071006", var_28_9)
						arg_25_1:RecordAudio("222071006", var_28_9)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_222071", "222071006", "story_v_out_222071.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_222071", "222071006", "story_v_out_222071.awb")
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
	Play222071007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 222071007
		arg_29_1.duration_ = 6.5

		local var_29_0 = {
			ja = 6.5,
			ko = 2.333,
			zh = 2.333
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
				arg_29_0:Play222071008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 0
			local var_32_1 = 0.4

			if var_32_0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_0 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_2 = arg_29_1:FormatText(StoryNameCfg[466].name)

				arg_29_1.leftNameTxt_.text = var_32_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, true)
				arg_29_1.iconController_:SetSelectedState("hero")

				arg_29_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwc")

				arg_29_1.callingController_:SetSelectedState("normal")

				arg_29_1.keyicon_.color = Color.New(1, 1, 1)
				arg_29_1.icon_.color = Color.New(1, 1, 1)

				local var_32_3 = arg_29_1:GetWordFromCfg(222071007)
				local var_32_4 = arg_29_1:FormatText(var_32_3.content)

				arg_29_1.text_.text = var_32_4

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_5 = 16
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

				if manager.audio:GetVoiceLength("story_v_out_222071", "222071007", "story_v_out_222071.awb") ~= 0 then
					local var_32_8 = manager.audio:GetVoiceLength("story_v_out_222071", "222071007", "story_v_out_222071.awb") / 1000

					if var_32_8 + var_32_0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_8 + var_32_0
					end

					if var_32_3.prefab_name ~= "" and arg_29_1.actors_[var_32_3.prefab_name] ~= nil then
						local var_32_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_3.prefab_name].transform, "story_v_out_222071", "222071007", "story_v_out_222071.awb")

						arg_29_1:RecordAudio("222071007", var_32_9)
						arg_29_1:RecordAudio("222071007", var_32_9)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_222071", "222071007", "story_v_out_222071.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_222071", "222071007", "story_v_out_222071.awb")
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
	Play222071008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 222071008
		arg_33_1.duration_ = 6

		local var_33_0 = {
			ja = 6,
			ko = 3.2,
			zh = 3.2
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
				arg_33_0:Play222071009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = 0
			local var_36_1 = 0.35

			if var_36_0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_0 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_2 = arg_33_1:FormatText(StoryNameCfg[473].name)

				arg_33_1.leftNameTxt_.text = var_36_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, true)
				arg_33_1.iconController_:SetSelectedState("hero")

				arg_33_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_boffinm")

				arg_33_1.callingController_:SetSelectedState("normal")

				arg_33_1.keyicon_.color = Color.New(1, 1, 1)
				arg_33_1.icon_.color = Color.New(1, 1, 1)

				local var_36_3 = arg_33_1:GetWordFromCfg(222071008)
				local var_36_4 = arg_33_1:FormatText(var_36_3.content)

				arg_33_1.text_.text = var_36_4

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_5 = 14
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

				if manager.audio:GetVoiceLength("story_v_out_222071", "222071008", "story_v_out_222071.awb") ~= 0 then
					local var_36_8 = manager.audio:GetVoiceLength("story_v_out_222071", "222071008", "story_v_out_222071.awb") / 1000

					if var_36_8 + var_36_0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_8 + var_36_0
					end

					if var_36_3.prefab_name ~= "" and arg_33_1.actors_[var_36_3.prefab_name] ~= nil then
						local var_36_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_3.prefab_name].transform, "story_v_out_222071", "222071008", "story_v_out_222071.awb")

						arg_33_1:RecordAudio("222071008", var_36_9)
						arg_33_1:RecordAudio("222071008", var_36_9)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_222071", "222071008", "story_v_out_222071.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_222071", "222071008", "story_v_out_222071.awb")
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
	Play222071009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 222071009
		arg_37_1.duration_ = 4.37

		local var_37_0 = {
			ja = 4.366,
			ko = 1.999999999999,
			zh = 1.999999999999
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
				arg_37_0:Play222071010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = "1074ui_story"

			if arg_37_1.actors_[var_40_0] == nil then
				local var_40_1 = Asset.Load("Char/" .. "1074ui_story")

				if not isNil(var_40_1) then
					local var_40_2 = Object.Instantiate(Asset.Load("Char/" .. "1074ui_story"), arg_37_1.stage_.transform)

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

			local var_40_5 = arg_37_1.actors_["1074ui_story"].transform
			local var_40_6 = 0

			if var_40_6 < arg_37_1.time_ and arg_37_1.time_ <= var_40_6 + arg_40_0 then
				arg_37_1.var_.moveOldPos1074ui_story = var_40_5.localPosition
			end

			local var_40_7 = 0.001

			if var_40_6 <= arg_37_1.time_ and arg_37_1.time_ < var_40_6 + var_40_7 then
				local var_40_8 = (arg_37_1.time_ - var_40_6) / var_40_7
				local var_40_9 = Vector3.New(0, -1.055, -6.12)

				var_40_5.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos1074ui_story, var_40_9, var_40_8)

				local var_40_10 = manager.ui.mainCamera.transform.position - var_40_5.position

				var_40_5.forward = Vector3.New(var_40_10.x, var_40_10.y, var_40_10.z)

				local var_40_11 = var_40_5.localEulerAngles

				var_40_11.z = 0
				var_40_11.x = 0
				var_40_5.localEulerAngles = var_40_11
			end

			if arg_37_1.time_ >= var_40_6 + var_40_7 and arg_37_1.time_ < var_40_6 + var_40_7 + arg_40_0 then
				var_40_5.localPosition = Vector3.New(0, -1.055, -6.12)

				local var_40_12 = manager.ui.mainCamera.transform.position - var_40_5.position

				var_40_5.forward = Vector3.New(var_40_12.x, var_40_12.y, var_40_12.z)

				local var_40_13 = var_40_5.localEulerAngles

				var_40_13.z = 0
				var_40_13.x = 0
				var_40_5.localEulerAngles = var_40_13
			end

			local var_40_14 = arg_37_1.actors_["1074ui_story"]
			local var_40_15 = 0

			if var_40_15 < arg_37_1.time_ and arg_37_1.time_ <= var_40_15 + arg_40_0 and not isNil(var_40_14) and arg_37_1.var_.characterEffect1074ui_story == nil then
				arg_37_1.var_.characterEffect1074ui_story = var_40_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_16 = 0.200000002980232

			if var_40_15 <= arg_37_1.time_ and arg_37_1.time_ < var_40_15 + var_40_16 and not isNil(var_40_14) then
				local var_40_17 = (arg_37_1.time_ - var_40_15) / var_40_16

				if arg_37_1.var_.characterEffect1074ui_story and not isNil(var_40_14) then
					arg_37_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_37_1.time_ >= var_40_15 + var_40_16 and arg_37_1.time_ < var_40_15 + var_40_16 + arg_40_0 and not isNil(var_40_14) and arg_37_1.var_.characterEffect1074ui_story then
				arg_37_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_40_18 = 0

			if var_40_18 < arg_37_1.time_ and arg_37_1.time_ <= var_40_18 + arg_40_0 then
				arg_37_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action1_1")
			end

			local var_40_19 = 0

			if var_40_19 < arg_37_1.time_ and arg_37_1.time_ <= var_40_19 + arg_40_0 then
				arg_37_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_40_20 = 0
			local var_40_21 = 0.175

			if var_40_20 < arg_37_1.time_ and arg_37_1.time_ <= var_40_20 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_22 = arg_37_1:FormatText(StoryNameCfg[410].name)

				arg_37_1.leftNameTxt_.text = var_40_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_23 = arg_37_1:GetWordFromCfg(222071009)
				local var_40_24 = arg_37_1:FormatText(var_40_23.content)

				arg_37_1.text_.text = var_40_24

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_25 = 7
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

				if manager.audio:GetVoiceLength("story_v_out_222071", "222071009", "story_v_out_222071.awb") ~= 0 then
					local var_40_28 = manager.audio:GetVoiceLength("story_v_out_222071", "222071009", "story_v_out_222071.awb") / 1000

					if var_40_28 + var_40_20 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_28 + var_40_20
					end

					if var_40_23.prefab_name ~= "" and arg_37_1.actors_[var_40_23.prefab_name] ~= nil then
						local var_40_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_23.prefab_name].transform, "story_v_out_222071", "222071009", "story_v_out_222071.awb")

						arg_37_1:RecordAudio("222071009", var_40_29)
						arg_37_1:RecordAudio("222071009", var_40_29)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_222071", "222071009", "story_v_out_222071.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_222071", "222071009", "story_v_out_222071.awb")
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
				actorName = "1074ui_story",
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
	Play222071010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 222071010
		arg_41_1.duration_ = 5

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play222071011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = arg_41_1.actors_["1074ui_story"].transform
			local var_44_1 = 0

			if var_44_1 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 then
				arg_41_1.var_.moveOldPos1074ui_story = var_44_0.localPosition
			end

			local var_44_2 = 0.001

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_2 then
				local var_44_3 = (arg_41_1.time_ - var_44_1) / var_44_2
				local var_44_4 = Vector3.New(0, 100, 0)

				var_44_0.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos1074ui_story, var_44_4, var_44_3)

				local var_44_5 = manager.ui.mainCamera.transform.position - var_44_0.position

				var_44_0.forward = Vector3.New(var_44_5.x, var_44_5.y, var_44_5.z)

				local var_44_6 = var_44_0.localEulerAngles

				var_44_6.z = 0
				var_44_6.x = 0
				var_44_0.localEulerAngles = var_44_6
			end

			if arg_41_1.time_ >= var_44_1 + var_44_2 and arg_41_1.time_ < var_44_1 + var_44_2 + arg_44_0 then
				var_44_0.localPosition = Vector3.New(0, 100, 0)

				local var_44_7 = manager.ui.mainCamera.transform.position - var_44_0.position

				var_44_0.forward = Vector3.New(var_44_7.x, var_44_7.y, var_44_7.z)

				local var_44_8 = var_44_0.localEulerAngles

				var_44_8.z = 0
				var_44_8.x = 0
				var_44_0.localEulerAngles = var_44_8
			end

			local var_44_9 = arg_41_1.actors_["1074ui_story"]
			local var_44_10 = 0

			if var_44_10 < arg_41_1.time_ and arg_41_1.time_ <= var_44_10 + arg_44_0 and not isNil(var_44_9) and arg_41_1.var_.characterEffect1074ui_story == nil then
				arg_41_1.var_.characterEffect1074ui_story = var_44_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_11 = 0.200000002980232

			if var_44_10 <= arg_41_1.time_ and arg_41_1.time_ < var_44_10 + var_44_11 and not isNil(var_44_9) then
				local var_44_12 = (arg_41_1.time_ - var_44_10) / var_44_11

				if arg_41_1.var_.characterEffect1074ui_story and not isNil(var_44_9) then
					local var_44_13 = Mathf.Lerp(0, 0.5, var_44_12)

					arg_41_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_41_1.var_.characterEffect1074ui_story.fillRatio = var_44_13
				end
			end

			if arg_41_1.time_ >= var_44_10 + var_44_11 and arg_41_1.time_ < var_44_10 + var_44_11 + arg_44_0 and not isNil(var_44_9) and arg_41_1.var_.characterEffect1074ui_story then
				local var_44_14 = 0.5

				arg_41_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_41_1.var_.characterEffect1074ui_story.fillRatio = var_44_14
			end

			local var_44_15 = 0
			local var_44_16 = 0.95

			if var_44_15 < arg_41_1.time_ and arg_41_1.time_ <= var_44_15 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, false)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_17 = arg_41_1:GetWordFromCfg(222071010)
				local var_44_18 = arg_41_1:FormatText(var_44_17.content)

				arg_41_1.text_.text = var_44_18

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_19 = 38
				local var_44_20 = utf8.len(var_44_18)
				local var_44_21 = var_44_19 <= 0 and var_44_16 or var_44_16 * (var_44_20 / var_44_19)

				if var_44_21 > 0 and var_44_16 < var_44_21 then
					arg_41_1.talkMaxDuration = var_44_21

					if var_44_21 + var_44_15 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_21 + var_44_15
					end
				end

				arg_41_1.text_.text = var_44_18
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)
				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_22 = math.max(var_44_16, arg_41_1.talkMaxDuration)

			if var_44_15 <= arg_41_1.time_ and arg_41_1.time_ < var_44_15 + var_44_22 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_15) / var_44_22

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_15 + var_44_22 and arg_41_1.time_ < var_44_15 + var_44_22 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
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
	Play222071011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 222071011
		arg_45_1.duration_ = 11.5

		local var_45_0 = {
			ja = 11.5,
			ko = 5.4,
			zh = 5.4
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
				arg_45_0:Play222071012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = 0
			local var_48_1 = 0.6

			if var_48_0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_0 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_2 = arg_45_1:FormatText(StoryNameCfg[465].name)

				arg_45_1.leftNameTxt_.text = var_48_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, true)
				arg_45_1.iconController_:SetSelectedState("hero")

				arg_45_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_45_1.callingController_:SetSelectedState("normal")

				arg_45_1.keyicon_.color = Color.New(1, 1, 1)
				arg_45_1.icon_.color = Color.New(1, 1, 1)

				local var_48_3 = arg_45_1:GetWordFromCfg(222071011)
				local var_48_4 = arg_45_1:FormatText(var_48_3.content)

				arg_45_1.text_.text = var_48_4

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_5 = 24
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

				if manager.audio:GetVoiceLength("story_v_out_222071", "222071011", "story_v_out_222071.awb") ~= 0 then
					local var_48_8 = manager.audio:GetVoiceLength("story_v_out_222071", "222071011", "story_v_out_222071.awb") / 1000

					if var_48_8 + var_48_0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_8 + var_48_0
					end

					if var_48_3.prefab_name ~= "" and arg_45_1.actors_[var_48_3.prefab_name] ~= nil then
						local var_48_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_3.prefab_name].transform, "story_v_out_222071", "222071011", "story_v_out_222071.awb")

						arg_45_1:RecordAudio("222071011", var_48_9)
						arg_45_1:RecordAudio("222071011", var_48_9)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_222071", "222071011", "story_v_out_222071.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_222071", "222071011", "story_v_out_222071.awb")
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
	Play222071012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 222071012
		arg_49_1.duration_ = 16.6

		local var_49_0 = {
			ja = 16.6,
			ko = 9.9,
			zh = 9.9
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
				arg_49_0:Play222071013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = 0
			local var_52_1 = 1.375

			if var_52_0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_0 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_2 = arg_49_1:FormatText(StoryNameCfg[473].name)

				arg_49_1.leftNameTxt_.text = var_52_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, true)
				arg_49_1.iconController_:SetSelectedState("hero")

				arg_49_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_boffinm")

				arg_49_1.callingController_:SetSelectedState("normal")

				arg_49_1.keyicon_.color = Color.New(1, 1, 1)
				arg_49_1.icon_.color = Color.New(1, 1, 1)

				local var_52_3 = arg_49_1:GetWordFromCfg(222071012)
				local var_52_4 = arg_49_1:FormatText(var_52_3.content)

				arg_49_1.text_.text = var_52_4

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_5 = 55
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

				if manager.audio:GetVoiceLength("story_v_out_222071", "222071012", "story_v_out_222071.awb") ~= 0 then
					local var_52_8 = manager.audio:GetVoiceLength("story_v_out_222071", "222071012", "story_v_out_222071.awb") / 1000

					if var_52_8 + var_52_0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_8 + var_52_0
					end

					if var_52_3.prefab_name ~= "" and arg_49_1.actors_[var_52_3.prefab_name] ~= nil then
						local var_52_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_3.prefab_name].transform, "story_v_out_222071", "222071012", "story_v_out_222071.awb")

						arg_49_1:RecordAudio("222071012", var_52_9)
						arg_49_1:RecordAudio("222071012", var_52_9)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_222071", "222071012", "story_v_out_222071.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_222071", "222071012", "story_v_out_222071.awb")
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
	Play222071013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 222071013
		arg_53_1.duration_ = 17.2

		local var_53_0 = {
			ja = 17.2,
			ko = 9.133,
			zh = 9.133
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
				arg_53_0:Play222071014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 0
			local var_56_1 = 1.25

			if var_56_0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_0 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_2 = arg_53_1:FormatText(StoryNameCfg[473].name)

				arg_53_1.leftNameTxt_.text = var_56_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, true)
				arg_53_1.iconController_:SetSelectedState("hero")

				arg_53_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_boffinm")

				arg_53_1.callingController_:SetSelectedState("normal")

				arg_53_1.keyicon_.color = Color.New(1, 1, 1)
				arg_53_1.icon_.color = Color.New(1, 1, 1)

				local var_56_3 = arg_53_1:GetWordFromCfg(222071013)
				local var_56_4 = arg_53_1:FormatText(var_56_3.content)

				arg_53_1.text_.text = var_56_4

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_5 = 50
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

				if manager.audio:GetVoiceLength("story_v_out_222071", "222071013", "story_v_out_222071.awb") ~= 0 then
					local var_56_8 = manager.audio:GetVoiceLength("story_v_out_222071", "222071013", "story_v_out_222071.awb") / 1000

					if var_56_8 + var_56_0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_8 + var_56_0
					end

					if var_56_3.prefab_name ~= "" and arg_53_1.actors_[var_56_3.prefab_name] ~= nil then
						local var_56_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_3.prefab_name].transform, "story_v_out_222071", "222071013", "story_v_out_222071.awb")

						arg_53_1:RecordAudio("222071013", var_56_9)
						arg_53_1:RecordAudio("222071013", var_56_9)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_222071", "222071013", "story_v_out_222071.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_222071", "222071013", "story_v_out_222071.awb")
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
	Play222071014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 222071014
		arg_57_1.duration_ = 13.73

		local var_57_0 = {
			ja = 13.733,
			ko = 10.133,
			zh = 10.166
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
				arg_57_0:Play222071015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = 0
			local var_60_1 = 1.325

			if var_60_0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_0 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_2 = arg_57_1:FormatText(StoryNameCfg[473].name)

				arg_57_1.leftNameTxt_.text = var_60_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, true)
				arg_57_1.iconController_:SetSelectedState("hero")

				arg_57_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_boffinm")

				arg_57_1.callingController_:SetSelectedState("normal")

				arg_57_1.keyicon_.color = Color.New(1, 1, 1)
				arg_57_1.icon_.color = Color.New(1, 1, 1)

				local var_60_3 = arg_57_1:GetWordFromCfg(222071014)
				local var_60_4 = arg_57_1:FormatText(var_60_3.content)

				arg_57_1.text_.text = var_60_4

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_5 = 53
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

				if manager.audio:GetVoiceLength("story_v_out_222071", "222071014", "story_v_out_222071.awb") ~= 0 then
					local var_60_8 = manager.audio:GetVoiceLength("story_v_out_222071", "222071014", "story_v_out_222071.awb") / 1000

					if var_60_8 + var_60_0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_8 + var_60_0
					end

					if var_60_3.prefab_name ~= "" and arg_57_1.actors_[var_60_3.prefab_name] ~= nil then
						local var_60_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_3.prefab_name].transform, "story_v_out_222071", "222071014", "story_v_out_222071.awb")

						arg_57_1:RecordAudio("222071014", var_60_9)
						arg_57_1:RecordAudio("222071014", var_60_9)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_222071", "222071014", "story_v_out_222071.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_222071", "222071014", "story_v_out_222071.awb")
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
	Play222071015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 222071015
		arg_61_1.duration_ = 14.03

		local var_61_0 = {
			ja = 14.033,
			ko = 8.3,
			zh = 8.133
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
				arg_61_0:Play222071016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = 0
			local var_64_1 = 1.15

			if var_64_0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_0 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_2 = arg_61_1:FormatText(StoryNameCfg[465].name)

				arg_61_1.leftNameTxt_.text = var_64_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, true)
				arg_61_1.iconController_:SetSelectedState("hero")

				arg_61_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_61_1.callingController_:SetSelectedState("normal")

				arg_61_1.keyicon_.color = Color.New(1, 1, 1)
				arg_61_1.icon_.color = Color.New(1, 1, 1)

				local var_64_3 = arg_61_1:GetWordFromCfg(222071015)
				local var_64_4 = arg_61_1:FormatText(var_64_3.content)

				arg_61_1.text_.text = var_64_4

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_5 = 46
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

				if manager.audio:GetVoiceLength("story_v_out_222071", "222071015", "story_v_out_222071.awb") ~= 0 then
					local var_64_8 = manager.audio:GetVoiceLength("story_v_out_222071", "222071015", "story_v_out_222071.awb") / 1000

					if var_64_8 + var_64_0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_8 + var_64_0
					end

					if var_64_3.prefab_name ~= "" and arg_61_1.actors_[var_64_3.prefab_name] ~= nil then
						local var_64_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_3.prefab_name].transform, "story_v_out_222071", "222071015", "story_v_out_222071.awb")

						arg_61_1:RecordAudio("222071015", var_64_9)
						arg_61_1:RecordAudio("222071015", var_64_9)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_222071", "222071015", "story_v_out_222071.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_222071", "222071015", "story_v_out_222071.awb")
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
	Play222071016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 222071016
		arg_65_1.duration_ = 8.6

		local var_65_0 = {
			ja = 7.5,
			ko = 8.6,
			zh = 8.6
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
				arg_65_0:Play222071017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = "10057ui_story"

			if arg_65_1.actors_[var_68_0] == nil then
				local var_68_1 = Asset.Load("Char/" .. "10057ui_story")

				if not isNil(var_68_1) then
					local var_68_2 = Object.Instantiate(Asset.Load("Char/" .. "10057ui_story"), arg_65_1.stage_.transform)

					var_68_2.name = var_68_0
					var_68_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_65_1.actors_[var_68_0] = var_68_2

					local var_68_3 = var_68_2:GetComponentInChildren(typeof(CharacterEffect))

					var_68_3.enabled = true

					local var_68_4 = GameObjectTools.GetOrAddComponent(var_68_2, typeof(DynamicBoneHelper))

					if var_68_4 then
						var_68_4:EnableDynamicBone(false)
					end

					arg_65_1:ShowWeapon(var_68_3.transform, false)

					arg_65_1.var_[var_68_0 .. "Animator"] = var_68_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_65_1.var_[var_68_0 .. "Animator"].applyRootMotion = true
					arg_65_1.var_[var_68_0 .. "LipSync"] = var_68_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_68_5 = arg_65_1.actors_["10057ui_story"].transform
			local var_68_6 = 0

			if var_68_6 < arg_65_1.time_ and arg_65_1.time_ <= var_68_6 + arg_68_0 then
				arg_65_1.var_.moveOldPos10057ui_story = var_68_5.localPosition
			end

			local var_68_7 = 0.001

			if var_68_6 <= arg_65_1.time_ and arg_65_1.time_ < var_68_6 + var_68_7 then
				local var_68_8 = (arg_65_1.time_ - var_68_6) / var_68_7
				local var_68_9 = Vector3.New(0, -1.13, -5.72)

				var_68_5.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos10057ui_story, var_68_9, var_68_8)

				local var_68_10 = manager.ui.mainCamera.transform.position - var_68_5.position

				var_68_5.forward = Vector3.New(var_68_10.x, var_68_10.y, var_68_10.z)

				local var_68_11 = var_68_5.localEulerAngles

				var_68_11.z = 0
				var_68_11.x = 0
				var_68_5.localEulerAngles = var_68_11
			end

			if arg_65_1.time_ >= var_68_6 + var_68_7 and arg_65_1.time_ < var_68_6 + var_68_7 + arg_68_0 then
				var_68_5.localPosition = Vector3.New(0, -1.13, -5.72)

				local var_68_12 = manager.ui.mainCamera.transform.position - var_68_5.position

				var_68_5.forward = Vector3.New(var_68_12.x, var_68_12.y, var_68_12.z)

				local var_68_13 = var_68_5.localEulerAngles

				var_68_13.z = 0
				var_68_13.x = 0
				var_68_5.localEulerAngles = var_68_13
			end

			local var_68_14 = arg_65_1.actors_["10057ui_story"]
			local var_68_15 = 0

			if var_68_15 < arg_65_1.time_ and arg_65_1.time_ <= var_68_15 + arg_68_0 and not isNil(var_68_14) and arg_65_1.var_.characterEffect10057ui_story == nil then
				arg_65_1.var_.characterEffect10057ui_story = var_68_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_16 = 0.200000002980232

			if var_68_15 <= arg_65_1.time_ and arg_65_1.time_ < var_68_15 + var_68_16 and not isNil(var_68_14) then
				local var_68_17 = (arg_65_1.time_ - var_68_15) / var_68_16

				if arg_65_1.var_.characterEffect10057ui_story and not isNil(var_68_14) then
					arg_65_1.var_.characterEffect10057ui_story.fillFlat = false
				end
			end

			if arg_65_1.time_ >= var_68_15 + var_68_16 and arg_65_1.time_ < var_68_15 + var_68_16 + arg_68_0 and not isNil(var_68_14) and arg_65_1.var_.characterEffect10057ui_story then
				arg_65_1.var_.characterEffect10057ui_story.fillFlat = false
			end

			local var_68_18 = 0

			if var_68_18 < arg_65_1.time_ and arg_65_1.time_ <= var_68_18 + arg_68_0 then
				arg_65_1:PlayTimeline("10057ui_story", "StoryTimeline/CharAction/story10057/story10057action/10057action1_1")
			end

			local var_68_19 = 0

			if var_68_19 < arg_65_1.time_ and arg_65_1.time_ <= var_68_19 + arg_68_0 then
				arg_65_1:PlayTimeline("10057ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_68_20 = 0
			local var_68_21 = 0.825

			if var_68_20 < arg_65_1.time_ and arg_65_1.time_ <= var_68_20 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				local var_68_22 = arg_65_1:FormatText(StoryNameCfg[464].name)

				arg_65_1.leftNameTxt_.text = var_68_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_23 = arg_65_1:GetWordFromCfg(222071016)
				local var_68_24 = arg_65_1:FormatText(var_68_23.content)

				arg_65_1.text_.text = var_68_24

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_25 = 33
				local var_68_26 = utf8.len(var_68_24)
				local var_68_27 = var_68_25 <= 0 and var_68_21 or var_68_21 * (var_68_26 / var_68_25)

				if var_68_27 > 0 and var_68_21 < var_68_27 then
					arg_65_1.talkMaxDuration = var_68_27

					if var_68_27 + var_68_20 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_27 + var_68_20
					end
				end

				arg_65_1.text_.text = var_68_24
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222071", "222071016", "story_v_out_222071.awb") ~= 0 then
					local var_68_28 = manager.audio:GetVoiceLength("story_v_out_222071", "222071016", "story_v_out_222071.awb") / 1000

					if var_68_28 + var_68_20 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_28 + var_68_20
					end

					if var_68_23.prefab_name ~= "" and arg_65_1.actors_[var_68_23.prefab_name] ~= nil then
						local var_68_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_23.prefab_name].transform, "story_v_out_222071", "222071016", "story_v_out_222071.awb")

						arg_65_1:RecordAudio("222071016", var_68_29)
						arg_65_1:RecordAudio("222071016", var_68_29)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_222071", "222071016", "story_v_out_222071.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_222071", "222071016", "story_v_out_222071.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_30 = math.max(var_68_21, arg_65_1.talkMaxDuration)

			if var_68_20 <= arg_65_1.time_ and arg_65_1.time_ < var_68_20 + var_68_30 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_20) / var_68_30

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_20 + var_68_30 and arg_65_1.time_ < var_68_20 + var_68_30 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10057ui_story",
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
	Play222071017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 222071017
		arg_69_1.duration_ = 5

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play222071018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = arg_69_1.actors_["10057ui_story"]
			local var_72_1 = 0

			if var_72_1 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 and not isNil(var_72_0) and arg_69_1.var_.characterEffect10057ui_story == nil then
				arg_69_1.var_.characterEffect10057ui_story = var_72_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_2 = 0.200000002980232

			if var_72_1 <= arg_69_1.time_ and arg_69_1.time_ < var_72_1 + var_72_2 and not isNil(var_72_0) then
				local var_72_3 = (arg_69_1.time_ - var_72_1) / var_72_2

				if arg_69_1.var_.characterEffect10057ui_story and not isNil(var_72_0) then
					local var_72_4 = Mathf.Lerp(0, 0.5, var_72_3)

					arg_69_1.var_.characterEffect10057ui_story.fillFlat = true
					arg_69_1.var_.characterEffect10057ui_story.fillRatio = var_72_4
				end
			end

			if arg_69_1.time_ >= var_72_1 + var_72_2 and arg_69_1.time_ < var_72_1 + var_72_2 + arg_72_0 and not isNil(var_72_0) and arg_69_1.var_.characterEffect10057ui_story then
				local var_72_5 = 0.5

				arg_69_1.var_.characterEffect10057ui_story.fillFlat = true
				arg_69_1.var_.characterEffect10057ui_story.fillRatio = var_72_5
			end

			local var_72_6 = 0
			local var_72_7 = 1.375

			if var_72_6 < arg_69_1.time_ and arg_69_1.time_ <= var_72_6 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, false)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_8 = arg_69_1:GetWordFromCfg(222071017)
				local var_72_9 = arg_69_1:FormatText(var_72_8.content)

				arg_69_1.text_.text = var_72_9

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_10 = 55
				local var_72_11 = utf8.len(var_72_9)
				local var_72_12 = var_72_10 <= 0 and var_72_7 or var_72_7 * (var_72_11 / var_72_10)

				if var_72_12 > 0 and var_72_7 < var_72_12 then
					arg_69_1.talkMaxDuration = var_72_12

					if var_72_12 + var_72_6 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_12 + var_72_6
					end
				end

				arg_69_1.text_.text = var_72_9
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)
				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_13 = math.max(var_72_7, arg_69_1.talkMaxDuration)

			if var_72_6 <= arg_69_1.time_ and arg_69_1.time_ < var_72_6 + var_72_13 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_6) / var_72_13

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_6 + var_72_13 and arg_69_1.time_ < var_72_6 + var_72_13 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play222071018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 222071018
		arg_73_1.duration_ = 7.43

		local var_73_0 = {
			ja = 7.433,
			ko = 5.866,
			zh = 5.866
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
				arg_73_0:Play222071019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = 0
			local var_76_1 = 0.775

			if var_76_0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_0 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				local var_76_2 = arg_73_1:FormatText(StoryNameCfg[465].name)

				arg_73_1.leftNameTxt_.text = var_76_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, true)
				arg_73_1.iconController_:SetSelectedState("hero")

				arg_73_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_73_1.callingController_:SetSelectedState("normal")

				arg_73_1.keyicon_.color = Color.New(1, 1, 1)
				arg_73_1.icon_.color = Color.New(1, 1, 1)

				local var_76_3 = arg_73_1:GetWordFromCfg(222071018)
				local var_76_4 = arg_73_1:FormatText(var_76_3.content)

				arg_73_1.text_.text = var_76_4

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_5 = 31
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

				if manager.audio:GetVoiceLength("story_v_out_222071", "222071018", "story_v_out_222071.awb") ~= 0 then
					local var_76_8 = manager.audio:GetVoiceLength("story_v_out_222071", "222071018", "story_v_out_222071.awb") / 1000

					if var_76_8 + var_76_0 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_8 + var_76_0
					end

					if var_76_3.prefab_name ~= "" and arg_73_1.actors_[var_76_3.prefab_name] ~= nil then
						local var_76_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_3.prefab_name].transform, "story_v_out_222071", "222071018", "story_v_out_222071.awb")

						arg_73_1:RecordAudio("222071018", var_76_9)
						arg_73_1:RecordAudio("222071018", var_76_9)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_222071", "222071018", "story_v_out_222071.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_222071", "222071018", "story_v_out_222071.awb")
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
	Play222071019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 222071019
		arg_77_1.duration_ = 19.8

		local var_77_0 = {
			ja = 19.8,
			ko = 12.633,
			zh = 12.633
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
				arg_77_0:Play222071020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = arg_77_1.actors_["10057ui_story"].transform
			local var_80_1 = 0

			if var_80_1 < arg_77_1.time_ and arg_77_1.time_ <= var_80_1 + arg_80_0 then
				arg_77_1.var_.moveOldPos10057ui_story = var_80_0.localPosition
			end

			local var_80_2 = 0.001

			if var_80_1 <= arg_77_1.time_ and arg_77_1.time_ < var_80_1 + var_80_2 then
				local var_80_3 = (arg_77_1.time_ - var_80_1) / var_80_2
				local var_80_4 = Vector3.New(0, -1.13, -5.72)

				var_80_0.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos10057ui_story, var_80_4, var_80_3)

				local var_80_5 = manager.ui.mainCamera.transform.position - var_80_0.position

				var_80_0.forward = Vector3.New(var_80_5.x, var_80_5.y, var_80_5.z)

				local var_80_6 = var_80_0.localEulerAngles

				var_80_6.z = 0
				var_80_6.x = 0
				var_80_0.localEulerAngles = var_80_6
			end

			if arg_77_1.time_ >= var_80_1 + var_80_2 and arg_77_1.time_ < var_80_1 + var_80_2 + arg_80_0 then
				var_80_0.localPosition = Vector3.New(0, -1.13, -5.72)

				local var_80_7 = manager.ui.mainCamera.transform.position - var_80_0.position

				var_80_0.forward = Vector3.New(var_80_7.x, var_80_7.y, var_80_7.z)

				local var_80_8 = var_80_0.localEulerAngles

				var_80_8.z = 0
				var_80_8.x = 0
				var_80_0.localEulerAngles = var_80_8
			end

			local var_80_9 = arg_77_1.actors_["10057ui_story"]
			local var_80_10 = 0

			if var_80_10 < arg_77_1.time_ and arg_77_1.time_ <= var_80_10 + arg_80_0 and not isNil(var_80_9) and arg_77_1.var_.characterEffect10057ui_story == nil then
				arg_77_1.var_.characterEffect10057ui_story = var_80_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_11 = 0.200000002980232

			if var_80_10 <= arg_77_1.time_ and arg_77_1.time_ < var_80_10 + var_80_11 and not isNil(var_80_9) then
				local var_80_12 = (arg_77_1.time_ - var_80_10) / var_80_11

				if arg_77_1.var_.characterEffect10057ui_story and not isNil(var_80_9) then
					arg_77_1.var_.characterEffect10057ui_story.fillFlat = false
				end
			end

			if arg_77_1.time_ >= var_80_10 + var_80_11 and arg_77_1.time_ < var_80_10 + var_80_11 + arg_80_0 and not isNil(var_80_9) and arg_77_1.var_.characterEffect10057ui_story then
				arg_77_1.var_.characterEffect10057ui_story.fillFlat = false
			end

			local var_80_13 = 0

			if var_80_13 < arg_77_1.time_ and arg_77_1.time_ <= var_80_13 + arg_80_0 then
				arg_77_1:PlayTimeline("10057ui_story", "StoryTimeline/CharAction/story10057/story10057action/10057action1_1")
			end

			local var_80_14 = 0

			if var_80_14 < arg_77_1.time_ and arg_77_1.time_ <= var_80_14 + arg_80_0 then
				arg_77_1:PlayTimeline("10057ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_80_15 = 0
			local var_80_16 = 1.325

			if var_80_15 < arg_77_1.time_ and arg_77_1.time_ <= var_80_15 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				local var_80_17 = arg_77_1:FormatText(StoryNameCfg[464].name)

				arg_77_1.leftNameTxt_.text = var_80_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_18 = arg_77_1:GetWordFromCfg(222071019)
				local var_80_19 = arg_77_1:FormatText(var_80_18.content)

				arg_77_1.text_.text = var_80_19

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_20 = 54
				local var_80_21 = utf8.len(var_80_19)
				local var_80_22 = var_80_20 <= 0 and var_80_16 or var_80_16 * (var_80_21 / var_80_20)

				if var_80_22 > 0 and var_80_16 < var_80_22 then
					arg_77_1.talkMaxDuration = var_80_22

					if var_80_22 + var_80_15 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_22 + var_80_15
					end
				end

				arg_77_1.text_.text = var_80_19
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222071", "222071019", "story_v_out_222071.awb") ~= 0 then
					local var_80_23 = manager.audio:GetVoiceLength("story_v_out_222071", "222071019", "story_v_out_222071.awb") / 1000

					if var_80_23 + var_80_15 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_23 + var_80_15
					end

					if var_80_18.prefab_name ~= "" and arg_77_1.actors_[var_80_18.prefab_name] ~= nil then
						local var_80_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_18.prefab_name].transform, "story_v_out_222071", "222071019", "story_v_out_222071.awb")

						arg_77_1:RecordAudio("222071019", var_80_24)
						arg_77_1:RecordAudio("222071019", var_80_24)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_222071", "222071019", "story_v_out_222071.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_222071", "222071019", "story_v_out_222071.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_25 = math.max(var_80_16, arg_77_1.talkMaxDuration)

			if var_80_15 <= arg_77_1.time_ and arg_77_1.time_ < var_80_15 + var_80_25 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_15) / var_80_25

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_15 + var_80_25 and arg_77_1.time_ < var_80_15 + var_80_25 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10057ui_story",
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
	Play222071020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 222071020
		arg_81_1.duration_ = 21.23

		local var_81_0 = {
			ja = 21.233,
			ko = 9.666,
			zh = 9.666
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
				arg_81_0:Play222071021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = arg_81_1.actors_["10057ui_story"].transform
			local var_84_1 = 0

			if var_84_1 < arg_81_1.time_ and arg_81_1.time_ <= var_84_1 + arg_84_0 then
				arg_81_1.var_.moveOldPos10057ui_story = var_84_0.localPosition
			end

			local var_84_2 = 0.001

			if var_84_1 <= arg_81_1.time_ and arg_81_1.time_ < var_84_1 + var_84_2 then
				local var_84_3 = (arg_81_1.time_ - var_84_1) / var_84_2
				local var_84_4 = Vector3.New(0, -1.13, -5.72)

				var_84_0.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos10057ui_story, var_84_4, var_84_3)

				local var_84_5 = manager.ui.mainCamera.transform.position - var_84_0.position

				var_84_0.forward = Vector3.New(var_84_5.x, var_84_5.y, var_84_5.z)

				local var_84_6 = var_84_0.localEulerAngles

				var_84_6.z = 0
				var_84_6.x = 0
				var_84_0.localEulerAngles = var_84_6
			end

			if arg_81_1.time_ >= var_84_1 + var_84_2 and arg_81_1.time_ < var_84_1 + var_84_2 + arg_84_0 then
				var_84_0.localPosition = Vector3.New(0, -1.13, -5.72)

				local var_84_7 = manager.ui.mainCamera.transform.position - var_84_0.position

				var_84_0.forward = Vector3.New(var_84_7.x, var_84_7.y, var_84_7.z)

				local var_84_8 = var_84_0.localEulerAngles

				var_84_8.z = 0
				var_84_8.x = 0
				var_84_0.localEulerAngles = var_84_8
			end

			local var_84_9 = arg_81_1.actors_["10057ui_story"]
			local var_84_10 = 0

			if var_84_10 < arg_81_1.time_ and arg_81_1.time_ <= var_84_10 + arg_84_0 and not isNil(var_84_9) and arg_81_1.var_.characterEffect10057ui_story == nil then
				arg_81_1.var_.characterEffect10057ui_story = var_84_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_11 = 0.200000002980232

			if var_84_10 <= arg_81_1.time_ and arg_81_1.time_ < var_84_10 + var_84_11 and not isNil(var_84_9) then
				local var_84_12 = (arg_81_1.time_ - var_84_10) / var_84_11

				if arg_81_1.var_.characterEffect10057ui_story and not isNil(var_84_9) then
					arg_81_1.var_.characterEffect10057ui_story.fillFlat = false
				end
			end

			if arg_81_1.time_ >= var_84_10 + var_84_11 and arg_81_1.time_ < var_84_10 + var_84_11 + arg_84_0 and not isNil(var_84_9) and arg_81_1.var_.characterEffect10057ui_story then
				arg_81_1.var_.characterEffect10057ui_story.fillFlat = false
			end

			local var_84_13 = 0

			if var_84_13 < arg_81_1.time_ and arg_81_1.time_ <= var_84_13 + arg_84_0 then
				arg_81_1:PlayTimeline("10057ui_story", "StoryTimeline/CharAction/story10057/story10057action/10057action1_1")
			end

			local var_84_14 = 0

			if var_84_14 < arg_81_1.time_ and arg_81_1.time_ <= var_84_14 + arg_84_0 then
				arg_81_1:PlayTimeline("10057ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_84_15 = 0
			local var_84_16 = 0.9

			if var_84_15 < arg_81_1.time_ and arg_81_1.time_ <= var_84_15 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				local var_84_17 = arg_81_1:FormatText(StoryNameCfg[464].name)

				arg_81_1.leftNameTxt_.text = var_84_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_18 = arg_81_1:GetWordFromCfg(222071020)
				local var_84_19 = arg_81_1:FormatText(var_84_18.content)

				arg_81_1.text_.text = var_84_19

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_20 = 36
				local var_84_21 = utf8.len(var_84_19)
				local var_84_22 = var_84_20 <= 0 and var_84_16 or var_84_16 * (var_84_21 / var_84_20)

				if var_84_22 > 0 and var_84_16 < var_84_22 then
					arg_81_1.talkMaxDuration = var_84_22

					if var_84_22 + var_84_15 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_22 + var_84_15
					end
				end

				arg_81_1.text_.text = var_84_19
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222071", "222071020", "story_v_out_222071.awb") ~= 0 then
					local var_84_23 = manager.audio:GetVoiceLength("story_v_out_222071", "222071020", "story_v_out_222071.awb") / 1000

					if var_84_23 + var_84_15 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_23 + var_84_15
					end

					if var_84_18.prefab_name ~= "" and arg_81_1.actors_[var_84_18.prefab_name] ~= nil then
						local var_84_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_18.prefab_name].transform, "story_v_out_222071", "222071020", "story_v_out_222071.awb")

						arg_81_1:RecordAudio("222071020", var_84_24)
						arg_81_1:RecordAudio("222071020", var_84_24)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_222071", "222071020", "story_v_out_222071.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_222071", "222071020", "story_v_out_222071.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_25 = math.max(var_84_16, arg_81_1.talkMaxDuration)

			if var_84_15 <= arg_81_1.time_ and arg_81_1.time_ < var_84_15 + var_84_25 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_15) / var_84_25

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_15 + var_84_25 and arg_81_1.time_ < var_84_15 + var_84_25 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10057ui_story",
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
	Play222071021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 222071021
		arg_85_1.duration_ = 5.2

		local var_85_0 = {
			ja = 5.2,
			ko = 2.433,
			zh = 2.433
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
				arg_85_0:Play222071022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = arg_85_1.actors_["10057ui_story"]
			local var_88_1 = 0

			if var_88_1 < arg_85_1.time_ and arg_85_1.time_ <= var_88_1 + arg_88_0 and not isNil(var_88_0) and arg_85_1.var_.characterEffect10057ui_story == nil then
				arg_85_1.var_.characterEffect10057ui_story = var_88_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_2 = 0.200000002980232

			if var_88_1 <= arg_85_1.time_ and arg_85_1.time_ < var_88_1 + var_88_2 and not isNil(var_88_0) then
				local var_88_3 = (arg_85_1.time_ - var_88_1) / var_88_2

				if arg_85_1.var_.characterEffect10057ui_story and not isNil(var_88_0) then
					local var_88_4 = Mathf.Lerp(0, 0.5, var_88_3)

					arg_85_1.var_.characterEffect10057ui_story.fillFlat = true
					arg_85_1.var_.characterEffect10057ui_story.fillRatio = var_88_4
				end
			end

			if arg_85_1.time_ >= var_88_1 + var_88_2 and arg_85_1.time_ < var_88_1 + var_88_2 + arg_88_0 and not isNil(var_88_0) and arg_85_1.var_.characterEffect10057ui_story then
				local var_88_5 = 0.5

				arg_85_1.var_.characterEffect10057ui_story.fillFlat = true
				arg_85_1.var_.characterEffect10057ui_story.fillRatio = var_88_5
			end

			local var_88_6 = 0
			local var_88_7 = 0.3

			if var_88_6 < arg_85_1.time_ and arg_85_1.time_ <= var_88_6 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				local var_88_8 = arg_85_1:FormatText(StoryNameCfg[465].name)

				arg_85_1.leftNameTxt_.text = var_88_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, true)
				arg_85_1.iconController_:SetSelectedState("hero")

				arg_85_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_85_1.callingController_:SetSelectedState("normal")

				arg_85_1.keyicon_.color = Color.New(1, 1, 1)
				arg_85_1.icon_.color = Color.New(1, 1, 1)

				local var_88_9 = arg_85_1:GetWordFromCfg(222071021)
				local var_88_10 = arg_85_1:FormatText(var_88_9.content)

				arg_85_1.text_.text = var_88_10

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_11 = 12
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

				if manager.audio:GetVoiceLength("story_v_out_222071", "222071021", "story_v_out_222071.awb") ~= 0 then
					local var_88_14 = manager.audio:GetVoiceLength("story_v_out_222071", "222071021", "story_v_out_222071.awb") / 1000

					if var_88_14 + var_88_6 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_14 + var_88_6
					end

					if var_88_9.prefab_name ~= "" and arg_85_1.actors_[var_88_9.prefab_name] ~= nil then
						local var_88_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_9.prefab_name].transform, "story_v_out_222071", "222071021", "story_v_out_222071.awb")

						arg_85_1:RecordAudio("222071021", var_88_15)
						arg_85_1:RecordAudio("222071021", var_88_15)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_222071", "222071021", "story_v_out_222071.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_222071", "222071021", "story_v_out_222071.awb")
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
	Play222071022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 222071022
		arg_89_1.duration_ = 12.1

		local var_89_0 = {
			ja = 12.1,
			ko = 8,
			zh = 8
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
				arg_89_0:Play222071023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = arg_89_1.actors_["10057ui_story"].transform
			local var_92_1 = 0

			if var_92_1 < arg_89_1.time_ and arg_89_1.time_ <= var_92_1 + arg_92_0 then
				arg_89_1.var_.moveOldPos10057ui_story = var_92_0.localPosition
			end

			local var_92_2 = 0.001

			if var_92_1 <= arg_89_1.time_ and arg_89_1.time_ < var_92_1 + var_92_2 then
				local var_92_3 = (arg_89_1.time_ - var_92_1) / var_92_2
				local var_92_4 = Vector3.New(0, -1.13, -5.72)

				var_92_0.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos10057ui_story, var_92_4, var_92_3)

				local var_92_5 = manager.ui.mainCamera.transform.position - var_92_0.position

				var_92_0.forward = Vector3.New(var_92_5.x, var_92_5.y, var_92_5.z)

				local var_92_6 = var_92_0.localEulerAngles

				var_92_6.z = 0
				var_92_6.x = 0
				var_92_0.localEulerAngles = var_92_6
			end

			if arg_89_1.time_ >= var_92_1 + var_92_2 and arg_89_1.time_ < var_92_1 + var_92_2 + arg_92_0 then
				var_92_0.localPosition = Vector3.New(0, -1.13, -5.72)

				local var_92_7 = manager.ui.mainCamera.transform.position - var_92_0.position

				var_92_0.forward = Vector3.New(var_92_7.x, var_92_7.y, var_92_7.z)

				local var_92_8 = var_92_0.localEulerAngles

				var_92_8.z = 0
				var_92_8.x = 0
				var_92_0.localEulerAngles = var_92_8
			end

			local var_92_9 = arg_89_1.actors_["10057ui_story"]
			local var_92_10 = 0

			if var_92_10 < arg_89_1.time_ and arg_89_1.time_ <= var_92_10 + arg_92_0 and not isNil(var_92_9) and arg_89_1.var_.characterEffect10057ui_story == nil then
				arg_89_1.var_.characterEffect10057ui_story = var_92_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_11 = 0.200000002980232

			if var_92_10 <= arg_89_1.time_ and arg_89_1.time_ < var_92_10 + var_92_11 and not isNil(var_92_9) then
				local var_92_12 = (arg_89_1.time_ - var_92_10) / var_92_11

				if arg_89_1.var_.characterEffect10057ui_story and not isNil(var_92_9) then
					arg_89_1.var_.characterEffect10057ui_story.fillFlat = false
				end
			end

			if arg_89_1.time_ >= var_92_10 + var_92_11 and arg_89_1.time_ < var_92_10 + var_92_11 + arg_92_0 and not isNil(var_92_9) and arg_89_1.var_.characterEffect10057ui_story then
				arg_89_1.var_.characterEffect10057ui_story.fillFlat = false
			end

			local var_92_13 = 0

			if var_92_13 < arg_89_1.time_ and arg_89_1.time_ <= var_92_13 + arg_92_0 then
				arg_89_1:PlayTimeline("10057ui_story", "StoryTimeline/CharAction/story10057/story10057action/10057action1_1")
			end

			local var_92_14 = 0

			if var_92_14 < arg_89_1.time_ and arg_89_1.time_ <= var_92_14 + arg_92_0 then
				arg_89_1:PlayTimeline("10057ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_92_15 = 0
			local var_92_16 = 0.65

			if var_92_15 < arg_89_1.time_ and arg_89_1.time_ <= var_92_15 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				local var_92_17 = arg_89_1:FormatText(StoryNameCfg[464].name)

				arg_89_1.leftNameTxt_.text = var_92_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_18 = arg_89_1:GetWordFromCfg(222071022)
				local var_92_19 = arg_89_1:FormatText(var_92_18.content)

				arg_89_1.text_.text = var_92_19

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_20 = 26
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

				if manager.audio:GetVoiceLength("story_v_out_222071", "222071022", "story_v_out_222071.awb") ~= 0 then
					local var_92_23 = manager.audio:GetVoiceLength("story_v_out_222071", "222071022", "story_v_out_222071.awb") / 1000

					if var_92_23 + var_92_15 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_23 + var_92_15
					end

					if var_92_18.prefab_name ~= "" and arg_89_1.actors_[var_92_18.prefab_name] ~= nil then
						local var_92_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_18.prefab_name].transform, "story_v_out_222071", "222071022", "story_v_out_222071.awb")

						arg_89_1:RecordAudio("222071022", var_92_24)
						arg_89_1:RecordAudio("222071022", var_92_24)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_222071", "222071022", "story_v_out_222071.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_222071", "222071022", "story_v_out_222071.awb")
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
				actorName = "10057ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_89_1:InitPlayNodeList()
	end,
	Play222071023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 222071023
		arg_93_1.duration_ = 5

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play222071024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = arg_93_1.actors_["10057ui_story"]
			local var_96_1 = 0

			if var_96_1 < arg_93_1.time_ and arg_93_1.time_ <= var_96_1 + arg_96_0 and not isNil(var_96_0) and arg_93_1.var_.characterEffect10057ui_story == nil then
				arg_93_1.var_.characterEffect10057ui_story = var_96_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_2 = 0.200000002980232

			if var_96_1 <= arg_93_1.time_ and arg_93_1.time_ < var_96_1 + var_96_2 and not isNil(var_96_0) then
				local var_96_3 = (arg_93_1.time_ - var_96_1) / var_96_2

				if arg_93_1.var_.characterEffect10057ui_story and not isNil(var_96_0) then
					local var_96_4 = Mathf.Lerp(0, 0.5, var_96_3)

					arg_93_1.var_.characterEffect10057ui_story.fillFlat = true
					arg_93_1.var_.characterEffect10057ui_story.fillRatio = var_96_4
				end
			end

			if arg_93_1.time_ >= var_96_1 + var_96_2 and arg_93_1.time_ < var_96_1 + var_96_2 + arg_96_0 and not isNil(var_96_0) and arg_93_1.var_.characterEffect10057ui_story then
				local var_96_5 = 0.5

				arg_93_1.var_.characterEffect10057ui_story.fillFlat = true
				arg_93_1.var_.characterEffect10057ui_story.fillRatio = var_96_5
			end

			local var_96_6 = 0
			local var_96_7 = 0.825

			if var_96_6 < arg_93_1.time_ and arg_93_1.time_ <= var_96_6 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, false)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_8 = arg_93_1:GetWordFromCfg(222071023)
				local var_96_9 = arg_93_1:FormatText(var_96_8.content)

				arg_93_1.text_.text = var_96_9

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_10 = 33
				local var_96_11 = utf8.len(var_96_9)
				local var_96_12 = var_96_10 <= 0 and var_96_7 or var_96_7 * (var_96_11 / var_96_10)

				if var_96_12 > 0 and var_96_7 < var_96_12 then
					arg_93_1.talkMaxDuration = var_96_12

					if var_96_12 + var_96_6 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_12 + var_96_6
					end
				end

				arg_93_1.text_.text = var_96_9
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)
				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_13 = math.max(var_96_7, arg_93_1.talkMaxDuration)

			if var_96_6 <= arg_93_1.time_ and arg_93_1.time_ < var_96_6 + var_96_13 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_6) / var_96_13

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_6 + var_96_13 and arg_93_1.time_ < var_96_6 + var_96_13 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play222071024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 222071024
		arg_97_1.duration_ = 17.67

		local var_97_0 = {
			ja = 17.666,
			ko = 10.966,
			zh = 10.966
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
				arg_97_0:Play222071025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = arg_97_1.actors_["10057ui_story"]
			local var_100_1 = 0

			if var_100_1 < arg_97_1.time_ and arg_97_1.time_ <= var_100_1 + arg_100_0 and not isNil(var_100_0) and arg_97_1.var_.characterEffect10057ui_story == nil then
				arg_97_1.var_.characterEffect10057ui_story = var_100_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_2 = 0.200000002980232

			if var_100_1 <= arg_97_1.time_ and arg_97_1.time_ < var_100_1 + var_100_2 and not isNil(var_100_0) then
				local var_100_3 = (arg_97_1.time_ - var_100_1) / var_100_2

				if arg_97_1.var_.characterEffect10057ui_story and not isNil(var_100_0) then
					arg_97_1.var_.characterEffect10057ui_story.fillFlat = false
				end
			end

			if arg_97_1.time_ >= var_100_1 + var_100_2 and arg_97_1.time_ < var_100_1 + var_100_2 + arg_100_0 and not isNil(var_100_0) and arg_97_1.var_.characterEffect10057ui_story then
				arg_97_1.var_.characterEffect10057ui_story.fillFlat = false
			end

			local var_100_4 = 0

			if var_100_4 < arg_97_1.time_ and arg_97_1.time_ <= var_100_4 + arg_100_0 then
				arg_97_1:PlayTimeline("10057ui_story", "StoryTimeline/CharAction/story10057/story10057action/10057action1_1")
			end

			local var_100_5 = 0

			if var_100_5 < arg_97_1.time_ and arg_97_1.time_ <= var_100_5 + arg_100_0 then
				arg_97_1:PlayTimeline("10057ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_100_6 = 0
			local var_100_7 = 0.925

			if var_100_6 < arg_97_1.time_ and arg_97_1.time_ <= var_100_6 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				local var_100_8 = arg_97_1:FormatText(StoryNameCfg[464].name)

				arg_97_1.leftNameTxt_.text = var_100_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_9 = arg_97_1:GetWordFromCfg(222071024)
				local var_100_10 = arg_97_1:FormatText(var_100_9.content)

				arg_97_1.text_.text = var_100_10

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_11 = 37
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

				if manager.audio:GetVoiceLength("story_v_out_222071", "222071024", "story_v_out_222071.awb") ~= 0 then
					local var_100_14 = manager.audio:GetVoiceLength("story_v_out_222071", "222071024", "story_v_out_222071.awb") / 1000

					if var_100_14 + var_100_6 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_14 + var_100_6
					end

					if var_100_9.prefab_name ~= "" and arg_97_1.actors_[var_100_9.prefab_name] ~= nil then
						local var_100_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_9.prefab_name].transform, "story_v_out_222071", "222071024", "story_v_out_222071.awb")

						arg_97_1:RecordAudio("222071024", var_100_15)
						arg_97_1:RecordAudio("222071024", var_100_15)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_222071", "222071024", "story_v_out_222071.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_222071", "222071024", "story_v_out_222071.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_16 = math.max(var_100_7, arg_97_1.talkMaxDuration)

			if var_100_6 <= arg_97_1.time_ and arg_97_1.time_ < var_100_6 + var_100_16 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_6) / var_100_16

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_6 + var_100_16 and arg_97_1.time_ < var_100_6 + var_100_16 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play222071025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 222071025
		arg_101_1.duration_ = 20.9

		local var_101_0 = {
			ja = 20.9,
			ko = 9.1,
			zh = 9.1
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
				arg_101_0:Play222071026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = 0
			local var_104_1 = 1.075

			if var_104_0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_0 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				local var_104_2 = arg_101_1:FormatText(StoryNameCfg[464].name)

				arg_101_1.leftNameTxt_.text = var_104_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_3 = arg_101_1:GetWordFromCfg(222071025)
				local var_104_4 = arg_101_1:FormatText(var_104_3.content)

				arg_101_1.text_.text = var_104_4

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_5 = 43
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

				if manager.audio:GetVoiceLength("story_v_out_222071", "222071025", "story_v_out_222071.awb") ~= 0 then
					local var_104_8 = manager.audio:GetVoiceLength("story_v_out_222071", "222071025", "story_v_out_222071.awb") / 1000

					if var_104_8 + var_104_0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_8 + var_104_0
					end

					if var_104_3.prefab_name ~= "" and arg_101_1.actors_[var_104_3.prefab_name] ~= nil then
						local var_104_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_3.prefab_name].transform, "story_v_out_222071", "222071025", "story_v_out_222071.awb")

						arg_101_1:RecordAudio("222071025", var_104_9)
						arg_101_1:RecordAudio("222071025", var_104_9)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_222071", "222071025", "story_v_out_222071.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_222071", "222071025", "story_v_out_222071.awb")
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
	Play222071026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 222071026
		arg_105_1.duration_ = 16.13

		local var_105_0 = {
			ja = 16.133,
			ko = 12.766,
			zh = 12.766
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
				arg_105_0:Play222071027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = 0
			local var_108_1 = 1.325

			if var_108_0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_0 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				local var_108_2 = arg_105_1:FormatText(StoryNameCfg[464].name)

				arg_105_1.leftNameTxt_.text = var_108_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_3 = arg_105_1:GetWordFromCfg(222071026)
				local var_108_4 = arg_105_1:FormatText(var_108_3.content)

				arg_105_1.text_.text = var_108_4

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_5 = 53
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

				if manager.audio:GetVoiceLength("story_v_out_222071", "222071026", "story_v_out_222071.awb") ~= 0 then
					local var_108_8 = manager.audio:GetVoiceLength("story_v_out_222071", "222071026", "story_v_out_222071.awb") / 1000

					if var_108_8 + var_108_0 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_8 + var_108_0
					end

					if var_108_3.prefab_name ~= "" and arg_105_1.actors_[var_108_3.prefab_name] ~= nil then
						local var_108_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_3.prefab_name].transform, "story_v_out_222071", "222071026", "story_v_out_222071.awb")

						arg_105_1:RecordAudio("222071026", var_108_9)
						arg_105_1:RecordAudio("222071026", var_108_9)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_222071", "222071026", "story_v_out_222071.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_222071", "222071026", "story_v_out_222071.awb")
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
	Play222071027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 222071027
		arg_109_1.duration_ = 21.87

		local var_109_0 = {
			ja = 21.866,
			ko = 14.5,
			zh = 14.5
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
				arg_109_0:Play222071028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = arg_109_1.actors_["10057ui_story"].transform
			local var_112_1 = 0

			if var_112_1 < arg_109_1.time_ and arg_109_1.time_ <= var_112_1 + arg_112_0 then
				arg_109_1.var_.moveOldPos10057ui_story = var_112_0.localPosition
			end

			local var_112_2 = 0.001

			if var_112_1 <= arg_109_1.time_ and arg_109_1.time_ < var_112_1 + var_112_2 then
				local var_112_3 = (arg_109_1.time_ - var_112_1) / var_112_2
				local var_112_4 = Vector3.New(0, -1.13, -5.72)

				var_112_0.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos10057ui_story, var_112_4, var_112_3)

				local var_112_5 = manager.ui.mainCamera.transform.position - var_112_0.position

				var_112_0.forward = Vector3.New(var_112_5.x, var_112_5.y, var_112_5.z)

				local var_112_6 = var_112_0.localEulerAngles

				var_112_6.z = 0
				var_112_6.x = 0
				var_112_0.localEulerAngles = var_112_6
			end

			if arg_109_1.time_ >= var_112_1 + var_112_2 and arg_109_1.time_ < var_112_1 + var_112_2 + arg_112_0 then
				var_112_0.localPosition = Vector3.New(0, -1.13, -5.72)

				local var_112_7 = manager.ui.mainCamera.transform.position - var_112_0.position

				var_112_0.forward = Vector3.New(var_112_7.x, var_112_7.y, var_112_7.z)

				local var_112_8 = var_112_0.localEulerAngles

				var_112_8.z = 0
				var_112_8.x = 0
				var_112_0.localEulerAngles = var_112_8
			end

			local var_112_9 = arg_109_1.actors_["10057ui_story"]
			local var_112_10 = 0

			if var_112_10 < arg_109_1.time_ and arg_109_1.time_ <= var_112_10 + arg_112_0 and not isNil(var_112_9) and arg_109_1.var_.characterEffect10057ui_story == nil then
				arg_109_1.var_.characterEffect10057ui_story = var_112_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_11 = 0.200000002980232

			if var_112_10 <= arg_109_1.time_ and arg_109_1.time_ < var_112_10 + var_112_11 and not isNil(var_112_9) then
				local var_112_12 = (arg_109_1.time_ - var_112_10) / var_112_11

				if arg_109_1.var_.characterEffect10057ui_story and not isNil(var_112_9) then
					arg_109_1.var_.characterEffect10057ui_story.fillFlat = false
				end
			end

			if arg_109_1.time_ >= var_112_10 + var_112_11 and arg_109_1.time_ < var_112_10 + var_112_11 + arg_112_0 and not isNil(var_112_9) and arg_109_1.var_.characterEffect10057ui_story then
				arg_109_1.var_.characterEffect10057ui_story.fillFlat = false
			end

			local var_112_13 = 0

			if var_112_13 < arg_109_1.time_ and arg_109_1.time_ <= var_112_13 + arg_112_0 then
				arg_109_1:PlayTimeline("10057ui_story", "StoryTimeline/CharAction/story10057/story10057action/10057action1_1")
			end

			local var_112_14 = 0

			if var_112_14 < arg_109_1.time_ and arg_109_1.time_ <= var_112_14 + arg_112_0 then
				arg_109_1:PlayTimeline("10057ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_112_15 = 0
			local var_112_16 = 1.25

			if var_112_15 < arg_109_1.time_ and arg_109_1.time_ <= var_112_15 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				local var_112_17 = arg_109_1:FormatText(StoryNameCfg[464].name)

				arg_109_1.leftNameTxt_.text = var_112_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_18 = arg_109_1:GetWordFromCfg(222071027)
				local var_112_19 = arg_109_1:FormatText(var_112_18.content)

				arg_109_1.text_.text = var_112_19

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_20 = 50
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

				if manager.audio:GetVoiceLength("story_v_out_222071", "222071027", "story_v_out_222071.awb") ~= 0 then
					local var_112_23 = manager.audio:GetVoiceLength("story_v_out_222071", "222071027", "story_v_out_222071.awb") / 1000

					if var_112_23 + var_112_15 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_23 + var_112_15
					end

					if var_112_18.prefab_name ~= "" and arg_109_1.actors_[var_112_18.prefab_name] ~= nil then
						local var_112_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_18.prefab_name].transform, "story_v_out_222071", "222071027", "story_v_out_222071.awb")

						arg_109_1:RecordAudio("222071027", var_112_24)
						arg_109_1:RecordAudio("222071027", var_112_24)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_222071", "222071027", "story_v_out_222071.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_222071", "222071027", "story_v_out_222071.awb")
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
				actorName = "10057ui_story",
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
	Play222071028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 222071028
		arg_113_1.duration_ = 5

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play222071029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = arg_113_1.actors_["10057ui_story"].transform
			local var_116_1 = 0

			if var_116_1 < arg_113_1.time_ and arg_113_1.time_ <= var_116_1 + arg_116_0 then
				arg_113_1.var_.moveOldPos10057ui_story = var_116_0.localPosition
			end

			local var_116_2 = 0.001

			if var_116_1 <= arg_113_1.time_ and arg_113_1.time_ < var_116_1 + var_116_2 then
				local var_116_3 = (arg_113_1.time_ - var_116_1) / var_116_2
				local var_116_4 = Vector3.New(0, 100, 0)

				var_116_0.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos10057ui_story, var_116_4, var_116_3)

				local var_116_5 = manager.ui.mainCamera.transform.position - var_116_0.position

				var_116_0.forward = Vector3.New(var_116_5.x, var_116_5.y, var_116_5.z)

				local var_116_6 = var_116_0.localEulerAngles

				var_116_6.z = 0
				var_116_6.x = 0
				var_116_0.localEulerAngles = var_116_6
			end

			if arg_113_1.time_ >= var_116_1 + var_116_2 and arg_113_1.time_ < var_116_1 + var_116_2 + arg_116_0 then
				var_116_0.localPosition = Vector3.New(0, 100, 0)

				local var_116_7 = manager.ui.mainCamera.transform.position - var_116_0.position

				var_116_0.forward = Vector3.New(var_116_7.x, var_116_7.y, var_116_7.z)

				local var_116_8 = var_116_0.localEulerAngles

				var_116_8.z = 0
				var_116_8.x = 0
				var_116_0.localEulerAngles = var_116_8
			end

			local var_116_9 = arg_113_1.actors_["10057ui_story"]
			local var_116_10 = 0

			if var_116_10 < arg_113_1.time_ and arg_113_1.time_ <= var_116_10 + arg_116_0 and not isNil(var_116_9) and arg_113_1.var_.characterEffect10057ui_story == nil then
				arg_113_1.var_.characterEffect10057ui_story = var_116_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_11 = 0.200000002980232

			if var_116_10 <= arg_113_1.time_ and arg_113_1.time_ < var_116_10 + var_116_11 and not isNil(var_116_9) then
				local var_116_12 = (arg_113_1.time_ - var_116_10) / var_116_11

				if arg_113_1.var_.characterEffect10057ui_story and not isNil(var_116_9) then
					local var_116_13 = Mathf.Lerp(0, 0.5, var_116_12)

					arg_113_1.var_.characterEffect10057ui_story.fillFlat = true
					arg_113_1.var_.characterEffect10057ui_story.fillRatio = var_116_13
				end
			end

			if arg_113_1.time_ >= var_116_10 + var_116_11 and arg_113_1.time_ < var_116_10 + var_116_11 + arg_116_0 and not isNil(var_116_9) and arg_113_1.var_.characterEffect10057ui_story then
				local var_116_14 = 0.5

				arg_113_1.var_.characterEffect10057ui_story.fillFlat = true
				arg_113_1.var_.characterEffect10057ui_story.fillRatio = var_116_14
			end

			local var_116_15 = 0
			local var_116_16 = 1.225

			if var_116_15 < arg_113_1.time_ and arg_113_1.time_ <= var_116_15 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, false)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_17 = arg_113_1:GetWordFromCfg(222071028)
				local var_116_18 = arg_113_1:FormatText(var_116_17.content)

				arg_113_1.text_.text = var_116_18

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_19 = 49
				local var_116_20 = utf8.len(var_116_18)
				local var_116_21 = var_116_19 <= 0 and var_116_16 or var_116_16 * (var_116_20 / var_116_19)

				if var_116_21 > 0 and var_116_16 < var_116_21 then
					arg_113_1.talkMaxDuration = var_116_21

					if var_116_21 + var_116_15 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_21 + var_116_15
					end
				end

				arg_113_1.text_.text = var_116_18
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)
				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_22 = math.max(var_116_16, arg_113_1.talkMaxDuration)

			if var_116_15 <= arg_113_1.time_ and arg_113_1.time_ < var_116_15 + var_116_22 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_15) / var_116_22

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_15 + var_116_22 and arg_113_1.time_ < var_116_15 + var_116_22 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10057ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_113_1:InitPlayNodeList()
	end,
	Play222071029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 222071029
		arg_117_1.duration_ = 2.57

		local var_117_0 = {
			ja = 2.566,
			ko = 2.3,
			zh = 2.3
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
				arg_117_0:Play222071030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = 0
			local var_120_1 = 0.25

			if var_120_0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_0 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				local var_120_2 = arg_117_1:FormatText(StoryNameCfg[473].name)

				arg_117_1.leftNameTxt_.text = var_120_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, true)
				arg_117_1.iconController_:SetSelectedState("hero")

				arg_117_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_boffinm")

				arg_117_1.callingController_:SetSelectedState("normal")

				arg_117_1.keyicon_.color = Color.New(1, 1, 1)
				arg_117_1.icon_.color = Color.New(1, 1, 1)

				local var_120_3 = arg_117_1:GetWordFromCfg(222071029)
				local var_120_4 = arg_117_1:FormatText(var_120_3.content)

				arg_117_1.text_.text = var_120_4

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_5 = 10
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

				if manager.audio:GetVoiceLength("story_v_out_222071", "222071029", "story_v_out_222071.awb") ~= 0 then
					local var_120_8 = manager.audio:GetVoiceLength("story_v_out_222071", "222071029", "story_v_out_222071.awb") / 1000

					if var_120_8 + var_120_0 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_8 + var_120_0
					end

					if var_120_3.prefab_name ~= "" and arg_117_1.actors_[var_120_3.prefab_name] ~= nil then
						local var_120_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_3.prefab_name].transform, "story_v_out_222071", "222071029", "story_v_out_222071.awb")

						arg_117_1:RecordAudio("222071029", var_120_9)
						arg_117_1:RecordAudio("222071029", var_120_9)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_222071", "222071029", "story_v_out_222071.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_222071", "222071029", "story_v_out_222071.awb")
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
	Play222071030 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 222071030
		arg_121_1.duration_ = 14.83

		local var_121_0 = {
			ja = 14.833,
			ko = 8.933,
			zh = 8.933
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
				arg_121_0:Play222071031(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = arg_121_1.actors_["1074ui_story"].transform
			local var_124_1 = 0

			if var_124_1 < arg_121_1.time_ and arg_121_1.time_ <= var_124_1 + arg_124_0 then
				arg_121_1.var_.moveOldPos1074ui_story = var_124_0.localPosition
			end

			local var_124_2 = 0.001

			if var_124_1 <= arg_121_1.time_ and arg_121_1.time_ < var_124_1 + var_124_2 then
				local var_124_3 = (arg_121_1.time_ - var_124_1) / var_124_2
				local var_124_4 = Vector3.New(0, -1.055, -6.12)

				var_124_0.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos1074ui_story, var_124_4, var_124_3)

				local var_124_5 = manager.ui.mainCamera.transform.position - var_124_0.position

				var_124_0.forward = Vector3.New(var_124_5.x, var_124_5.y, var_124_5.z)

				local var_124_6 = var_124_0.localEulerAngles

				var_124_6.z = 0
				var_124_6.x = 0
				var_124_0.localEulerAngles = var_124_6
			end

			if arg_121_1.time_ >= var_124_1 + var_124_2 and arg_121_1.time_ < var_124_1 + var_124_2 + arg_124_0 then
				var_124_0.localPosition = Vector3.New(0, -1.055, -6.12)

				local var_124_7 = manager.ui.mainCamera.transform.position - var_124_0.position

				var_124_0.forward = Vector3.New(var_124_7.x, var_124_7.y, var_124_7.z)

				local var_124_8 = var_124_0.localEulerAngles

				var_124_8.z = 0
				var_124_8.x = 0
				var_124_0.localEulerAngles = var_124_8
			end

			local var_124_9 = arg_121_1.actors_["1074ui_story"]
			local var_124_10 = 0

			if var_124_10 < arg_121_1.time_ and arg_121_1.time_ <= var_124_10 + arg_124_0 and not isNil(var_124_9) and arg_121_1.var_.characterEffect1074ui_story == nil then
				arg_121_1.var_.characterEffect1074ui_story = var_124_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_11 = 0.200000002980232

			if var_124_10 <= arg_121_1.time_ and arg_121_1.time_ < var_124_10 + var_124_11 and not isNil(var_124_9) then
				local var_124_12 = (arg_121_1.time_ - var_124_10) / var_124_11

				if arg_121_1.var_.characterEffect1074ui_story and not isNil(var_124_9) then
					arg_121_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_121_1.time_ >= var_124_10 + var_124_11 and arg_121_1.time_ < var_124_10 + var_124_11 + arg_124_0 and not isNil(var_124_9) and arg_121_1.var_.characterEffect1074ui_story then
				arg_121_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_124_13 = 0

			if var_124_13 < arg_121_1.time_ and arg_121_1.time_ <= var_124_13 + arg_124_0 then
				arg_121_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action1_1")
			end

			local var_124_14 = 0

			if var_124_14 < arg_121_1.time_ and arg_121_1.time_ <= var_124_14 + arg_124_0 then
				arg_121_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_124_15 = 0
			local var_124_16 = 1.025

			if var_124_15 < arg_121_1.time_ and arg_121_1.time_ <= var_124_15 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				local var_124_17 = arg_121_1:FormatText(StoryNameCfg[410].name)

				arg_121_1.leftNameTxt_.text = var_124_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_18 = arg_121_1:GetWordFromCfg(222071030)
				local var_124_19 = arg_121_1:FormatText(var_124_18.content)

				arg_121_1.text_.text = var_124_19

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_20 = 41
				local var_124_21 = utf8.len(var_124_19)
				local var_124_22 = var_124_20 <= 0 and var_124_16 or var_124_16 * (var_124_21 / var_124_20)

				if var_124_22 > 0 and var_124_16 < var_124_22 then
					arg_121_1.talkMaxDuration = var_124_22

					if var_124_22 + var_124_15 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_22 + var_124_15
					end
				end

				arg_121_1.text_.text = var_124_19
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222071", "222071030", "story_v_out_222071.awb") ~= 0 then
					local var_124_23 = manager.audio:GetVoiceLength("story_v_out_222071", "222071030", "story_v_out_222071.awb") / 1000

					if var_124_23 + var_124_15 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_23 + var_124_15
					end

					if var_124_18.prefab_name ~= "" and arg_121_1.actors_[var_124_18.prefab_name] ~= nil then
						local var_124_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_18.prefab_name].transform, "story_v_out_222071", "222071030", "story_v_out_222071.awb")

						arg_121_1:RecordAudio("222071030", var_124_24)
						arg_121_1:RecordAudio("222071030", var_124_24)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_222071", "222071030", "story_v_out_222071.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_222071", "222071030", "story_v_out_222071.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_25 = math.max(var_124_16, arg_121_1.talkMaxDuration)

			if var_124_15 <= arg_121_1.time_ and arg_121_1.time_ < var_124_15 + var_124_25 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_15) / var_124_25

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_15 + var_124_25 and arg_121_1.time_ < var_124_15 + var_124_25 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
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
	Play222071031 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 222071031
		arg_125_1.duration_ = 5.57

		local var_125_0 = {
			ja = 5.566,
			ko = 4.933,
			zh = 4.933
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
				arg_125_0:Play222071032(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = arg_125_1.actors_["1074ui_story"]
			local var_128_1 = 0

			if var_128_1 < arg_125_1.time_ and arg_125_1.time_ <= var_128_1 + arg_128_0 and not isNil(var_128_0) and arg_125_1.var_.characterEffect1074ui_story == nil then
				arg_125_1.var_.characterEffect1074ui_story = var_128_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_2 = 0.200000002980232

			if var_128_1 <= arg_125_1.time_ and arg_125_1.time_ < var_128_1 + var_128_2 and not isNil(var_128_0) then
				local var_128_3 = (arg_125_1.time_ - var_128_1) / var_128_2

				if arg_125_1.var_.characterEffect1074ui_story and not isNil(var_128_0) then
					local var_128_4 = Mathf.Lerp(0, 0.5, var_128_3)

					arg_125_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_125_1.var_.characterEffect1074ui_story.fillRatio = var_128_4
				end
			end

			if arg_125_1.time_ >= var_128_1 + var_128_2 and arg_125_1.time_ < var_128_1 + var_128_2 + arg_128_0 and not isNil(var_128_0) and arg_125_1.var_.characterEffect1074ui_story then
				local var_128_5 = 0.5

				arg_125_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_125_1.var_.characterEffect1074ui_story.fillRatio = var_128_5
			end

			local var_128_6 = 0
			local var_128_7 = 0.4

			if var_128_6 < arg_125_1.time_ and arg_125_1.time_ <= var_128_6 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				local var_128_8 = arg_125_1:FormatText(StoryNameCfg[473].name)

				arg_125_1.leftNameTxt_.text = var_128_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, true)
				arg_125_1.iconController_:SetSelectedState("hero")

				arg_125_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_boffinm")

				arg_125_1.callingController_:SetSelectedState("normal")

				arg_125_1.keyicon_.color = Color.New(1, 1, 1)
				arg_125_1.icon_.color = Color.New(1, 1, 1)

				local var_128_9 = arg_125_1:GetWordFromCfg(222071031)
				local var_128_10 = arg_125_1:FormatText(var_128_9.content)

				arg_125_1.text_.text = var_128_10

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_11 = 16
				local var_128_12 = utf8.len(var_128_10)
				local var_128_13 = var_128_11 <= 0 and var_128_7 or var_128_7 * (var_128_12 / var_128_11)

				if var_128_13 > 0 and var_128_7 < var_128_13 then
					arg_125_1.talkMaxDuration = var_128_13

					if var_128_13 + var_128_6 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_13 + var_128_6
					end
				end

				arg_125_1.text_.text = var_128_10
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222071", "222071031", "story_v_out_222071.awb") ~= 0 then
					local var_128_14 = manager.audio:GetVoiceLength("story_v_out_222071", "222071031", "story_v_out_222071.awb") / 1000

					if var_128_14 + var_128_6 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_14 + var_128_6
					end

					if var_128_9.prefab_name ~= "" and arg_125_1.actors_[var_128_9.prefab_name] ~= nil then
						local var_128_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_9.prefab_name].transform, "story_v_out_222071", "222071031", "story_v_out_222071.awb")

						arg_125_1:RecordAudio("222071031", var_128_15)
						arg_125_1:RecordAudio("222071031", var_128_15)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_222071", "222071031", "story_v_out_222071.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_222071", "222071031", "story_v_out_222071.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_16 = math.max(var_128_7, arg_125_1.talkMaxDuration)

			if var_128_6 <= arg_125_1.time_ and arg_125_1.time_ < var_128_6 + var_128_16 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_6) / var_128_16

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_6 + var_128_16 and arg_125_1.time_ < var_128_6 + var_128_16 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play222071032 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 222071032
		arg_129_1.duration_ = 5

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play222071033(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = arg_129_1.actors_["1074ui_story"].transform
			local var_132_1 = 0

			if var_132_1 < arg_129_1.time_ and arg_129_1.time_ <= var_132_1 + arg_132_0 then
				arg_129_1.var_.moveOldPos1074ui_story = var_132_0.localPosition
			end

			local var_132_2 = 0.001

			if var_132_1 <= arg_129_1.time_ and arg_129_1.time_ < var_132_1 + var_132_2 then
				local var_132_3 = (arg_129_1.time_ - var_132_1) / var_132_2
				local var_132_4 = Vector3.New(0, 100, 0)

				var_132_0.localPosition = Vector3.Lerp(arg_129_1.var_.moveOldPos1074ui_story, var_132_4, var_132_3)

				local var_132_5 = manager.ui.mainCamera.transform.position - var_132_0.position

				var_132_0.forward = Vector3.New(var_132_5.x, var_132_5.y, var_132_5.z)

				local var_132_6 = var_132_0.localEulerAngles

				var_132_6.z = 0
				var_132_6.x = 0
				var_132_0.localEulerAngles = var_132_6
			end

			if arg_129_1.time_ >= var_132_1 + var_132_2 and arg_129_1.time_ < var_132_1 + var_132_2 + arg_132_0 then
				var_132_0.localPosition = Vector3.New(0, 100, 0)

				local var_132_7 = manager.ui.mainCamera.transform.position - var_132_0.position

				var_132_0.forward = Vector3.New(var_132_7.x, var_132_7.y, var_132_7.z)

				local var_132_8 = var_132_0.localEulerAngles

				var_132_8.z = 0
				var_132_8.x = 0
				var_132_0.localEulerAngles = var_132_8
			end

			local var_132_9 = arg_129_1.actors_["1074ui_story"]
			local var_132_10 = 0

			if var_132_10 < arg_129_1.time_ and arg_129_1.time_ <= var_132_10 + arg_132_0 and not isNil(var_132_9) and arg_129_1.var_.characterEffect1074ui_story == nil then
				arg_129_1.var_.characterEffect1074ui_story = var_132_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_11 = 0.200000002980232

			if var_132_10 <= arg_129_1.time_ and arg_129_1.time_ < var_132_10 + var_132_11 and not isNil(var_132_9) then
				local var_132_12 = (arg_129_1.time_ - var_132_10) / var_132_11

				if arg_129_1.var_.characterEffect1074ui_story and not isNil(var_132_9) then
					local var_132_13 = Mathf.Lerp(0, 0.5, var_132_12)

					arg_129_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_129_1.var_.characterEffect1074ui_story.fillRatio = var_132_13
				end
			end

			if arg_129_1.time_ >= var_132_10 + var_132_11 and arg_129_1.time_ < var_132_10 + var_132_11 + arg_132_0 and not isNil(var_132_9) and arg_129_1.var_.characterEffect1074ui_story then
				local var_132_14 = 0.5

				arg_129_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_129_1.var_.characterEffect1074ui_story.fillRatio = var_132_14
			end

			local var_132_15 = 0
			local var_132_16 = 0.675

			if var_132_15 < arg_129_1.time_ and arg_129_1.time_ <= var_132_15 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, false)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_17 = arg_129_1:GetWordFromCfg(222071032)
				local var_132_18 = arg_129_1:FormatText(var_132_17.content)

				arg_129_1.text_.text = var_132_18

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_19 = 27
				local var_132_20 = utf8.len(var_132_18)
				local var_132_21 = var_132_19 <= 0 and var_132_16 or var_132_16 * (var_132_20 / var_132_19)

				if var_132_21 > 0 and var_132_16 < var_132_21 then
					arg_129_1.talkMaxDuration = var_132_21

					if var_132_21 + var_132_15 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_21 + var_132_15
					end
				end

				arg_129_1.text_.text = var_132_18
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)
				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_22 = math.max(var_132_16, arg_129_1.talkMaxDuration)

			if var_132_15 <= arg_129_1.time_ and arg_129_1.time_ < var_132_15 + var_132_22 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_15) / var_132_22

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_15 + var_132_22 and arg_129_1.time_ < var_132_15 + var_132_22 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
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
	Play222071033 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 222071033
		arg_133_1.duration_ = 5

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play222071034(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = 0
			local var_136_1 = 0.925

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

				local var_136_2 = arg_133_1:GetWordFromCfg(222071033)
				local var_136_3 = arg_133_1:FormatText(var_136_2.content)

				arg_133_1.text_.text = var_136_3

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_4 = 37
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
	Play222071034 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 222071034
		arg_137_1.duration_ = 10.93

		local var_137_0 = {
			ja = 10.933,
			ko = 5.533,
			zh = 5.566
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
				arg_137_0:Play222071035(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = 0
			local var_140_1 = 0.775

			if var_140_0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_0 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				local var_140_2 = arg_137_1:FormatText(StoryNameCfg[473].name)

				arg_137_1.leftNameTxt_.text = var_140_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, true)
				arg_137_1.iconController_:SetSelectedState("hero")

				arg_137_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_boffinm")

				arg_137_1.callingController_:SetSelectedState("normal")

				arg_137_1.keyicon_.color = Color.New(1, 1, 1)
				arg_137_1.icon_.color = Color.New(1, 1, 1)

				local var_140_3 = arg_137_1:GetWordFromCfg(222071034)
				local var_140_4 = arg_137_1:FormatText(var_140_3.content)

				arg_137_1.text_.text = var_140_4

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_5 = 31
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

				if manager.audio:GetVoiceLength("story_v_out_222071", "222071034", "story_v_out_222071.awb") ~= 0 then
					local var_140_8 = manager.audio:GetVoiceLength("story_v_out_222071", "222071034", "story_v_out_222071.awb") / 1000

					if var_140_8 + var_140_0 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_8 + var_140_0
					end

					if var_140_3.prefab_name ~= "" and arg_137_1.actors_[var_140_3.prefab_name] ~= nil then
						local var_140_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_3.prefab_name].transform, "story_v_out_222071", "222071034", "story_v_out_222071.awb")

						arg_137_1:RecordAudio("222071034", var_140_9)
						arg_137_1:RecordAudio("222071034", var_140_9)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_222071", "222071034", "story_v_out_222071.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_222071", "222071034", "story_v_out_222071.awb")
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
	Play222071035 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 222071035
		arg_141_1.duration_ = 1.5

		local var_141_0 = {
			ja = 1.5,
			ko = 1.4,
			zh = 1.4
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
				arg_141_0:Play222071036(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = arg_141_1.actors_["1074ui_story"].transform
			local var_144_1 = 0

			if var_144_1 < arg_141_1.time_ and arg_141_1.time_ <= var_144_1 + arg_144_0 then
				arg_141_1.var_.moveOldPos1074ui_story = var_144_0.localPosition
			end

			local var_144_2 = 0.001

			if var_144_1 <= arg_141_1.time_ and arg_141_1.time_ < var_144_1 + var_144_2 then
				local var_144_3 = (arg_141_1.time_ - var_144_1) / var_144_2
				local var_144_4 = Vector3.New(0, -1.055, -6.12)

				var_144_0.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos1074ui_story, var_144_4, var_144_3)

				local var_144_5 = manager.ui.mainCamera.transform.position - var_144_0.position

				var_144_0.forward = Vector3.New(var_144_5.x, var_144_5.y, var_144_5.z)

				local var_144_6 = var_144_0.localEulerAngles

				var_144_6.z = 0
				var_144_6.x = 0
				var_144_0.localEulerAngles = var_144_6
			end

			if arg_141_1.time_ >= var_144_1 + var_144_2 and arg_141_1.time_ < var_144_1 + var_144_2 + arg_144_0 then
				var_144_0.localPosition = Vector3.New(0, -1.055, -6.12)

				local var_144_7 = manager.ui.mainCamera.transform.position - var_144_0.position

				var_144_0.forward = Vector3.New(var_144_7.x, var_144_7.y, var_144_7.z)

				local var_144_8 = var_144_0.localEulerAngles

				var_144_8.z = 0
				var_144_8.x = 0
				var_144_0.localEulerAngles = var_144_8
			end

			local var_144_9 = arg_141_1.actors_["1074ui_story"]
			local var_144_10 = 0

			if var_144_10 < arg_141_1.time_ and arg_141_1.time_ <= var_144_10 + arg_144_0 and not isNil(var_144_9) and arg_141_1.var_.characterEffect1074ui_story == nil then
				arg_141_1.var_.characterEffect1074ui_story = var_144_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_11 = 0.200000002980232

			if var_144_10 <= arg_141_1.time_ and arg_141_1.time_ < var_144_10 + var_144_11 and not isNil(var_144_9) then
				local var_144_12 = (arg_141_1.time_ - var_144_10) / var_144_11

				if arg_141_1.var_.characterEffect1074ui_story and not isNil(var_144_9) then
					arg_141_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_141_1.time_ >= var_144_10 + var_144_11 and arg_141_1.time_ < var_144_10 + var_144_11 + arg_144_0 and not isNil(var_144_9) and arg_141_1.var_.characterEffect1074ui_story then
				arg_141_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_144_13 = 0

			if var_144_13 < arg_141_1.time_ and arg_141_1.time_ <= var_144_13 + arg_144_0 then
				arg_141_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action1_1")
			end

			local var_144_14 = 0

			if var_144_14 < arg_141_1.time_ and arg_141_1.time_ <= var_144_14 + arg_144_0 then
				arg_141_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_144_15 = 0
			local var_144_16 = 0.075

			if var_144_15 < arg_141_1.time_ and arg_141_1.time_ <= var_144_15 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				local var_144_17 = arg_141_1:FormatText(StoryNameCfg[410].name)

				arg_141_1.leftNameTxt_.text = var_144_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_18 = arg_141_1:GetWordFromCfg(222071035)
				local var_144_19 = arg_141_1:FormatText(var_144_18.content)

				arg_141_1.text_.text = var_144_19

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_20 = 3
				local var_144_21 = utf8.len(var_144_19)
				local var_144_22 = var_144_20 <= 0 and var_144_16 or var_144_16 * (var_144_21 / var_144_20)

				if var_144_22 > 0 and var_144_16 < var_144_22 then
					arg_141_1.talkMaxDuration = var_144_22

					if var_144_22 + var_144_15 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_22 + var_144_15
					end
				end

				arg_141_1.text_.text = var_144_19
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222071", "222071035", "story_v_out_222071.awb") ~= 0 then
					local var_144_23 = manager.audio:GetVoiceLength("story_v_out_222071", "222071035", "story_v_out_222071.awb") / 1000

					if var_144_23 + var_144_15 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_23 + var_144_15
					end

					if var_144_18.prefab_name ~= "" and arg_141_1.actors_[var_144_18.prefab_name] ~= nil then
						local var_144_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_18.prefab_name].transform, "story_v_out_222071", "222071035", "story_v_out_222071.awb")

						arg_141_1:RecordAudio("222071035", var_144_24)
						arg_141_1:RecordAudio("222071035", var_144_24)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_222071", "222071035", "story_v_out_222071.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_222071", "222071035", "story_v_out_222071.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_25 = math.max(var_144_16, arg_141_1.talkMaxDuration)

			if var_144_15 <= arg_141_1.time_ and arg_141_1.time_ < var_144_15 + var_144_25 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_15) / var_144_25

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_15 + var_144_25 and arg_141_1.time_ < var_144_15 + var_144_25 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_141_1:InitPlayNodeList()
	end,
	Play222071036 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 222071036
		arg_145_1.duration_ = 5

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play222071037(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = arg_145_1.actors_["1074ui_story"].transform
			local var_148_1 = 0

			if var_148_1 < arg_145_1.time_ and arg_145_1.time_ <= var_148_1 + arg_148_0 then
				arg_145_1.var_.moveOldPos1074ui_story = var_148_0.localPosition
			end

			local var_148_2 = 0.001

			if var_148_1 <= arg_145_1.time_ and arg_145_1.time_ < var_148_1 + var_148_2 then
				local var_148_3 = (arg_145_1.time_ - var_148_1) / var_148_2
				local var_148_4 = Vector3.New(0, 100, 0)

				var_148_0.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos1074ui_story, var_148_4, var_148_3)

				local var_148_5 = manager.ui.mainCamera.transform.position - var_148_0.position

				var_148_0.forward = Vector3.New(var_148_5.x, var_148_5.y, var_148_5.z)

				local var_148_6 = var_148_0.localEulerAngles

				var_148_6.z = 0
				var_148_6.x = 0
				var_148_0.localEulerAngles = var_148_6
			end

			if arg_145_1.time_ >= var_148_1 + var_148_2 and arg_145_1.time_ < var_148_1 + var_148_2 + arg_148_0 then
				var_148_0.localPosition = Vector3.New(0, 100, 0)

				local var_148_7 = manager.ui.mainCamera.transform.position - var_148_0.position

				var_148_0.forward = Vector3.New(var_148_7.x, var_148_7.y, var_148_7.z)

				local var_148_8 = var_148_0.localEulerAngles

				var_148_8.z = 0
				var_148_8.x = 0
				var_148_0.localEulerAngles = var_148_8
			end

			local var_148_9 = arg_145_1.actors_["1074ui_story"]
			local var_148_10 = 0

			if var_148_10 < arg_145_1.time_ and arg_145_1.time_ <= var_148_10 + arg_148_0 and not isNil(var_148_9) and arg_145_1.var_.characterEffect1074ui_story == nil then
				arg_145_1.var_.characterEffect1074ui_story = var_148_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_11 = 0.200000002980232

			if var_148_10 <= arg_145_1.time_ and arg_145_1.time_ < var_148_10 + var_148_11 and not isNil(var_148_9) then
				local var_148_12 = (arg_145_1.time_ - var_148_10) / var_148_11

				if arg_145_1.var_.characterEffect1074ui_story and not isNil(var_148_9) then
					local var_148_13 = Mathf.Lerp(0, 0.5, var_148_12)

					arg_145_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_145_1.var_.characterEffect1074ui_story.fillRatio = var_148_13
				end
			end

			if arg_145_1.time_ >= var_148_10 + var_148_11 and arg_145_1.time_ < var_148_10 + var_148_11 + arg_148_0 and not isNil(var_148_9) and arg_145_1.var_.characterEffect1074ui_story then
				local var_148_14 = 0.5

				arg_145_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_145_1.var_.characterEffect1074ui_story.fillRatio = var_148_14
			end

			local var_148_15 = 0
			local var_148_16 = 0.8

			if var_148_15 < arg_145_1.time_ and arg_145_1.time_ <= var_148_15 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, false)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_17 = arg_145_1:GetWordFromCfg(222071036)
				local var_148_18 = arg_145_1:FormatText(var_148_17.content)

				arg_145_1.text_.text = var_148_18

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_19 = 32
				local var_148_20 = utf8.len(var_148_18)
				local var_148_21 = var_148_19 <= 0 and var_148_16 or var_148_16 * (var_148_20 / var_148_19)

				if var_148_21 > 0 and var_148_16 < var_148_21 then
					arg_145_1.talkMaxDuration = var_148_21

					if var_148_21 + var_148_15 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_21 + var_148_15
					end
				end

				arg_145_1.text_.text = var_148_18
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)
				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_22 = math.max(var_148_16, arg_145_1.talkMaxDuration)

			if var_148_15 <= arg_145_1.time_ and arg_145_1.time_ < var_148_15 + var_148_22 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_15) / var_148_22

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_15 + var_148_22 and arg_145_1.time_ < var_148_15 + var_148_22 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_145_1:InitPlayNodeList()
	end,
	Play222071037 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 222071037
		arg_149_1.duration_ = 7.93

		local var_149_0 = {
			ja = 7.933,
			ko = 6.6,
			zh = 6.6
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
				arg_149_0:Play222071038(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = "J16f"

			if arg_149_1.bgs_[var_152_0] == nil then
				local var_152_1 = Object.Instantiate(arg_149_1.paintGo_)

				var_152_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_152_0)
				var_152_1.name = var_152_0
				var_152_1.transform.parent = arg_149_1.stage_.transform
				var_152_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_149_1.bgs_[var_152_0] = var_152_1
			end

			local var_152_2 = 1.999999999999

			if var_152_2 < arg_149_1.time_ and arg_149_1.time_ <= var_152_2 + arg_152_0 then
				local var_152_3 = manager.ui.mainCamera.transform.localPosition
				local var_152_4 = Vector3.New(0, 0, 10) + Vector3.New(var_152_3.x, var_152_3.y, 0)
				local var_152_5 = arg_149_1.bgs_.J16f

				var_152_5.transform.localPosition = var_152_4
				var_152_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_152_6 = var_152_5:GetComponent("SpriteRenderer")

				if var_152_6 and var_152_6.sprite then
					local var_152_7 = (var_152_5.transform.localPosition - var_152_3).z
					local var_152_8 = manager.ui.mainCameraCom_
					local var_152_9 = 2 * var_152_7 * Mathf.Tan(var_152_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_152_10 = var_152_9 * var_152_8.aspect
					local var_152_11 = var_152_6.sprite.bounds.size.x
					local var_152_12 = var_152_6.sprite.bounds.size.y
					local var_152_13 = var_152_10 / var_152_11
					local var_152_14 = var_152_9 / var_152_12
					local var_152_15 = var_152_14 < var_152_13 and var_152_13 or var_152_14

					var_152_5.transform.localScale = Vector3.New(var_152_15, var_152_15, 0)
				end

				for iter_152_0, iter_152_1 in pairs(arg_149_1.bgs_) do
					if iter_152_0 ~= "J16f" then
						iter_152_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_152_16 = 0

			if var_152_16 < arg_149_1.time_ and arg_149_1.time_ <= var_152_16 + arg_152_0 then
				arg_149_1.mask_.enabled = true
				arg_149_1.mask_.raycastTarget = true

				arg_149_1:SetGaussion(false)
			end

			local var_152_17 = 2

			if var_152_16 <= arg_149_1.time_ and arg_149_1.time_ < var_152_16 + var_152_17 then
				local var_152_18 = (arg_149_1.time_ - var_152_16) / var_152_17
				local var_152_19 = Color.New(0, 0, 0)

				var_152_19.a = Mathf.Lerp(0, 1, var_152_18)
				arg_149_1.mask_.color = var_152_19
			end

			if arg_149_1.time_ >= var_152_16 + var_152_17 and arg_149_1.time_ < var_152_16 + var_152_17 + arg_152_0 then
				local var_152_20 = Color.New(0, 0, 0)

				var_152_20.a = 1
				arg_149_1.mask_.color = var_152_20
			end

			local var_152_21 = 2

			if var_152_21 < arg_149_1.time_ and arg_149_1.time_ <= var_152_21 + arg_152_0 then
				arg_149_1.mask_.enabled = true
				arg_149_1.mask_.raycastTarget = true

				arg_149_1:SetGaussion(false)
			end

			local var_152_22 = 2

			if var_152_21 <= arg_149_1.time_ and arg_149_1.time_ < var_152_21 + var_152_22 then
				local var_152_23 = (arg_149_1.time_ - var_152_21) / var_152_22
				local var_152_24 = Color.New(0, 0, 0)

				var_152_24.a = Mathf.Lerp(1, 0, var_152_23)
				arg_149_1.mask_.color = var_152_24
			end

			if arg_149_1.time_ >= var_152_21 + var_152_22 and arg_149_1.time_ < var_152_21 + var_152_22 + arg_152_0 then
				local var_152_25 = Color.New(0, 0, 0)
				local var_152_26 = 0

				arg_149_1.mask_.enabled = false
				var_152_25.a = var_152_26
				arg_149_1.mask_.color = var_152_25
			end

			local var_152_27 = arg_149_1.actors_["1074ui_story"].transform
			local var_152_28 = 3.8

			if var_152_28 < arg_149_1.time_ and arg_149_1.time_ <= var_152_28 + arg_152_0 then
				arg_149_1.var_.moveOldPos1074ui_story = var_152_27.localPosition
			end

			local var_152_29 = 0.001

			if var_152_28 <= arg_149_1.time_ and arg_149_1.time_ < var_152_28 + var_152_29 then
				local var_152_30 = (arg_149_1.time_ - var_152_28) / var_152_29
				local var_152_31 = Vector3.New(0, -1.055, -6.12)

				var_152_27.localPosition = Vector3.Lerp(arg_149_1.var_.moveOldPos1074ui_story, var_152_31, var_152_30)

				local var_152_32 = manager.ui.mainCamera.transform.position - var_152_27.position

				var_152_27.forward = Vector3.New(var_152_32.x, var_152_32.y, var_152_32.z)

				local var_152_33 = var_152_27.localEulerAngles

				var_152_33.z = 0
				var_152_33.x = 0
				var_152_27.localEulerAngles = var_152_33
			end

			if arg_149_1.time_ >= var_152_28 + var_152_29 and arg_149_1.time_ < var_152_28 + var_152_29 + arg_152_0 then
				var_152_27.localPosition = Vector3.New(0, -1.055, -6.12)

				local var_152_34 = manager.ui.mainCamera.transform.position - var_152_27.position

				var_152_27.forward = Vector3.New(var_152_34.x, var_152_34.y, var_152_34.z)

				local var_152_35 = var_152_27.localEulerAngles

				var_152_35.z = 0
				var_152_35.x = 0
				var_152_27.localEulerAngles = var_152_35
			end

			local var_152_36 = arg_149_1.actors_["1074ui_story"]
			local var_152_37 = 3.8

			if var_152_37 < arg_149_1.time_ and arg_149_1.time_ <= var_152_37 + arg_152_0 and not isNil(var_152_36) and arg_149_1.var_.characterEffect1074ui_story == nil then
				arg_149_1.var_.characterEffect1074ui_story = var_152_36:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_38 = 0.200000002980232

			if var_152_37 <= arg_149_1.time_ and arg_149_1.time_ < var_152_37 + var_152_38 and not isNil(var_152_36) then
				local var_152_39 = (arg_149_1.time_ - var_152_37) / var_152_38

				if arg_149_1.var_.characterEffect1074ui_story and not isNil(var_152_36) then
					arg_149_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_149_1.time_ >= var_152_37 + var_152_38 and arg_149_1.time_ < var_152_37 + var_152_38 + arg_152_0 and not isNil(var_152_36) and arg_149_1.var_.characterEffect1074ui_story then
				arg_149_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_152_40 = 3.8

			if var_152_40 < arg_149_1.time_ and arg_149_1.time_ <= var_152_40 + arg_152_0 then
				arg_149_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action1_1")
			end

			local var_152_41 = 3.8

			if var_152_41 < arg_149_1.time_ and arg_149_1.time_ <= var_152_41 + arg_152_0 then
				arg_149_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_152_42 = 4
			local var_152_43 = 0.35

			if var_152_42 < arg_149_1.time_ and arg_149_1.time_ <= var_152_42 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				local var_152_44 = arg_149_1:FormatText(StoryNameCfg[410].name)

				arg_149_1.leftNameTxt_.text = var_152_44

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_45 = arg_149_1:GetWordFromCfg(222071037)
				local var_152_46 = arg_149_1:FormatText(var_152_45.content)

				arg_149_1.text_.text = var_152_46

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_47 = 14
				local var_152_48 = utf8.len(var_152_46)
				local var_152_49 = var_152_47 <= 0 and var_152_43 or var_152_43 * (var_152_48 / var_152_47)

				if var_152_49 > 0 and var_152_43 < var_152_49 then
					arg_149_1.talkMaxDuration = var_152_49

					if var_152_49 + var_152_42 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_49 + var_152_42
					end
				end

				arg_149_1.text_.text = var_152_46
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222071", "222071037", "story_v_out_222071.awb") ~= 0 then
					local var_152_50 = manager.audio:GetVoiceLength("story_v_out_222071", "222071037", "story_v_out_222071.awb") / 1000

					if var_152_50 + var_152_42 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_50 + var_152_42
					end

					if var_152_45.prefab_name ~= "" and arg_149_1.actors_[var_152_45.prefab_name] ~= nil then
						local var_152_51 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_45.prefab_name].transform, "story_v_out_222071", "222071037", "story_v_out_222071.awb")

						arg_149_1:RecordAudio("222071037", var_152_51)
						arg_149_1:RecordAudio("222071037", var_152_51)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_out_222071", "222071037", "story_v_out_222071.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_out_222071", "222071037", "story_v_out_222071.awb")
				end

				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_52 = math.max(var_152_43, arg_149_1.talkMaxDuration)

			if var_152_42 <= arg_149_1.time_ and arg_149_1.time_ < var_152_42 + var_152_52 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_42) / var_152_52

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_42 + var_152_52 and arg_149_1.time_ < var_152_42 + var_152_52 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_149_1:InitPlayNodeList()
	end,
	Play222071038 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 222071038
		arg_153_1.duration_ = 9.73

		local var_153_0 = {
			ja = 9.733,
			ko = 9.3,
			zh = 9.3
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
				arg_153_0:Play222071039(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = arg_153_1.actors_["1074ui_story"]
			local var_156_1 = 0

			if var_156_1 < arg_153_1.time_ and arg_153_1.time_ <= var_156_1 + arg_156_0 and not isNil(var_156_0) and arg_153_1.var_.characterEffect1074ui_story == nil then
				arg_153_1.var_.characterEffect1074ui_story = var_156_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_2 = 0.200000002980232

			if var_156_1 <= arg_153_1.time_ and arg_153_1.time_ < var_156_1 + var_156_2 and not isNil(var_156_0) then
				local var_156_3 = (arg_153_1.time_ - var_156_1) / var_156_2

				if arg_153_1.var_.characterEffect1074ui_story and not isNil(var_156_0) then
					local var_156_4 = Mathf.Lerp(0, 0.5, var_156_3)

					arg_153_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_153_1.var_.characterEffect1074ui_story.fillRatio = var_156_4
				end
			end

			if arg_153_1.time_ >= var_156_1 + var_156_2 and arg_153_1.time_ < var_156_1 + var_156_2 + arg_156_0 and not isNil(var_156_0) and arg_153_1.var_.characterEffect1074ui_story then
				local var_156_5 = 0.5

				arg_153_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_153_1.var_.characterEffect1074ui_story.fillRatio = var_156_5
			end

			local var_156_6 = 0
			local var_156_7 = 0.825

			if var_156_6 < arg_153_1.time_ and arg_153_1.time_ <= var_156_6 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				local var_156_8 = arg_153_1:FormatText(StoryNameCfg[465].name)

				arg_153_1.leftNameTxt_.text = var_156_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, true)
				arg_153_1.iconController_:SetSelectedState("hero")

				arg_153_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_153_1.callingController_:SetSelectedState("normal")

				arg_153_1.keyicon_.color = Color.New(1, 1, 1)
				arg_153_1.icon_.color = Color.New(1, 1, 1)

				local var_156_9 = arg_153_1:GetWordFromCfg(222071038)
				local var_156_10 = arg_153_1:FormatText(var_156_9.content)

				arg_153_1.text_.text = var_156_10

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_11 = 33
				local var_156_12 = utf8.len(var_156_10)
				local var_156_13 = var_156_11 <= 0 and var_156_7 or var_156_7 * (var_156_12 / var_156_11)

				if var_156_13 > 0 and var_156_7 < var_156_13 then
					arg_153_1.talkMaxDuration = var_156_13

					if var_156_13 + var_156_6 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_13 + var_156_6
					end
				end

				arg_153_1.text_.text = var_156_10
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222071", "222071038", "story_v_out_222071.awb") ~= 0 then
					local var_156_14 = manager.audio:GetVoiceLength("story_v_out_222071", "222071038", "story_v_out_222071.awb") / 1000

					if var_156_14 + var_156_6 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_14 + var_156_6
					end

					if var_156_9.prefab_name ~= "" and arg_153_1.actors_[var_156_9.prefab_name] ~= nil then
						local var_156_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_9.prefab_name].transform, "story_v_out_222071", "222071038", "story_v_out_222071.awb")

						arg_153_1:RecordAudio("222071038", var_156_15)
						arg_153_1:RecordAudio("222071038", var_156_15)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_222071", "222071038", "story_v_out_222071.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_222071", "222071038", "story_v_out_222071.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_16 = math.max(var_156_7, arg_153_1.talkMaxDuration)

			if var_156_6 <= arg_153_1.time_ and arg_153_1.time_ < var_156_6 + var_156_16 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_6) / var_156_16

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_6 + var_156_16 and arg_153_1.time_ < var_156_6 + var_156_16 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play222071039 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 222071039
		arg_157_1.duration_ = 9.2

		local var_157_0 = {
			ja = 9.2,
			ko = 8,
			zh = 8
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
				arg_157_0:Play222071040(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = 0
			local var_160_1 = 1

			if var_160_0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_0 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				local var_160_2 = arg_157_1:FormatText(StoryNameCfg[466].name)

				arg_157_1.leftNameTxt_.text = var_160_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, true)
				arg_157_1.iconController_:SetSelectedState("hero")

				arg_157_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwc")

				arg_157_1.callingController_:SetSelectedState("normal")

				arg_157_1.keyicon_.color = Color.New(1, 1, 1)
				arg_157_1.icon_.color = Color.New(1, 1, 1)

				local var_160_3 = arg_157_1:GetWordFromCfg(222071039)
				local var_160_4 = arg_157_1:FormatText(var_160_3.content)

				arg_157_1.text_.text = var_160_4

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_5 = 40
				local var_160_6 = utf8.len(var_160_4)
				local var_160_7 = var_160_5 <= 0 and var_160_1 or var_160_1 * (var_160_6 / var_160_5)

				if var_160_7 > 0 and var_160_1 < var_160_7 then
					arg_157_1.talkMaxDuration = var_160_7

					if var_160_7 + var_160_0 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_7 + var_160_0
					end
				end

				arg_157_1.text_.text = var_160_4
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222071", "222071039", "story_v_out_222071.awb") ~= 0 then
					local var_160_8 = manager.audio:GetVoiceLength("story_v_out_222071", "222071039", "story_v_out_222071.awb") / 1000

					if var_160_8 + var_160_0 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_8 + var_160_0
					end

					if var_160_3.prefab_name ~= "" and arg_157_1.actors_[var_160_3.prefab_name] ~= nil then
						local var_160_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_3.prefab_name].transform, "story_v_out_222071", "222071039", "story_v_out_222071.awb")

						arg_157_1:RecordAudio("222071039", var_160_9)
						arg_157_1:RecordAudio("222071039", var_160_9)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_out_222071", "222071039", "story_v_out_222071.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_out_222071", "222071039", "story_v_out_222071.awb")
				end

				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_10 = math.max(var_160_1, arg_157_1.talkMaxDuration)

			if var_160_0 <= arg_157_1.time_ and arg_157_1.time_ < var_160_0 + var_160_10 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_0) / var_160_10

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_0 + var_160_10 and arg_157_1.time_ < var_160_0 + var_160_10 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play222071040 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 222071040
		arg_161_1.duration_ = 9.6

		local var_161_0 = {
			ja = 9.6,
			ko = 5.033,
			zh = 5.033
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
				arg_161_0:Play222071041(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = arg_161_1.actors_["1074ui_story"]
			local var_164_1 = 0

			if var_164_1 < arg_161_1.time_ and arg_161_1.time_ <= var_164_1 + arg_164_0 and not isNil(var_164_0) and arg_161_1.var_.characterEffect1074ui_story == nil then
				arg_161_1.var_.characterEffect1074ui_story = var_164_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_2 = 0.200000002980232

			if var_164_1 <= arg_161_1.time_ and arg_161_1.time_ < var_164_1 + var_164_2 and not isNil(var_164_0) then
				local var_164_3 = (arg_161_1.time_ - var_164_1) / var_164_2

				if arg_161_1.var_.characterEffect1074ui_story and not isNil(var_164_0) then
					arg_161_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_161_1.time_ >= var_164_1 + var_164_2 and arg_161_1.time_ < var_164_1 + var_164_2 + arg_164_0 and not isNil(var_164_0) and arg_161_1.var_.characterEffect1074ui_story then
				arg_161_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_164_4 = 0

			if var_164_4 < arg_161_1.time_ and arg_161_1.time_ <= var_164_4 + arg_164_0 then
				arg_161_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action1_1")
			end

			local var_164_5 = 0

			if var_164_5 < arg_161_1.time_ and arg_161_1.time_ <= var_164_5 + arg_164_0 then
				arg_161_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_164_6 = 0
			local var_164_7 = 0.75

			if var_164_6 < arg_161_1.time_ and arg_161_1.time_ <= var_164_6 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				local var_164_8 = arg_161_1:FormatText(StoryNameCfg[410].name)

				arg_161_1.leftNameTxt_.text = var_164_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_9 = arg_161_1:GetWordFromCfg(222071040)
				local var_164_10 = arg_161_1:FormatText(var_164_9.content)

				arg_161_1.text_.text = var_164_10

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_11 = 30
				local var_164_12 = utf8.len(var_164_10)
				local var_164_13 = var_164_11 <= 0 and var_164_7 or var_164_7 * (var_164_12 / var_164_11)

				if var_164_13 > 0 and var_164_7 < var_164_13 then
					arg_161_1.talkMaxDuration = var_164_13

					if var_164_13 + var_164_6 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_13 + var_164_6
					end
				end

				arg_161_1.text_.text = var_164_10
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222071", "222071040", "story_v_out_222071.awb") ~= 0 then
					local var_164_14 = manager.audio:GetVoiceLength("story_v_out_222071", "222071040", "story_v_out_222071.awb") / 1000

					if var_164_14 + var_164_6 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_14 + var_164_6
					end

					if var_164_9.prefab_name ~= "" and arg_161_1.actors_[var_164_9.prefab_name] ~= nil then
						local var_164_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_9.prefab_name].transform, "story_v_out_222071", "222071040", "story_v_out_222071.awb")

						arg_161_1:RecordAudio("222071040", var_164_15)
						arg_161_1:RecordAudio("222071040", var_164_15)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_out_222071", "222071040", "story_v_out_222071.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_out_222071", "222071040", "story_v_out_222071.awb")
				end

				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_16 = math.max(var_164_7, arg_161_1.talkMaxDuration)

			if var_164_6 <= arg_161_1.time_ and arg_161_1.time_ < var_164_6 + var_164_16 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_6) / var_164_16

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_6 + var_164_16 and arg_161_1.time_ < var_164_6 + var_164_16 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	Play222071041 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 222071041
		arg_165_1.duration_ = 10.4

		local var_165_0 = {
			ja = 10.4,
			ko = 6.9,
			zh = 6.9
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
				arg_165_0:Play222071042(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = arg_165_1.actors_["1074ui_story"]
			local var_168_1 = 0

			if var_168_1 < arg_165_1.time_ and arg_165_1.time_ <= var_168_1 + arg_168_0 and not isNil(var_168_0) and arg_165_1.var_.characterEffect1074ui_story == nil then
				arg_165_1.var_.characterEffect1074ui_story = var_168_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_2 = 0.200000002980232

			if var_168_1 <= arg_165_1.time_ and arg_165_1.time_ < var_168_1 + var_168_2 and not isNil(var_168_0) then
				local var_168_3 = (arg_165_1.time_ - var_168_1) / var_168_2

				if arg_165_1.var_.characterEffect1074ui_story and not isNil(var_168_0) then
					local var_168_4 = Mathf.Lerp(0, 0.5, var_168_3)

					arg_165_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_165_1.var_.characterEffect1074ui_story.fillRatio = var_168_4
				end
			end

			if arg_165_1.time_ >= var_168_1 + var_168_2 and arg_165_1.time_ < var_168_1 + var_168_2 + arg_168_0 and not isNil(var_168_0) and arg_165_1.var_.characterEffect1074ui_story then
				local var_168_5 = 0.5

				arg_165_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_165_1.var_.characterEffect1074ui_story.fillRatio = var_168_5
			end

			local var_168_6 = 0
			local var_168_7 = 0.85

			if var_168_6 < arg_165_1.time_ and arg_165_1.time_ <= var_168_6 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				local var_168_8 = arg_165_1:FormatText(StoryNameCfg[467].name)

				arg_165_1.leftNameTxt_.text = var_168_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, true)
				arg_165_1.iconController_:SetSelectedState("hero")

				arg_165_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenma")

				arg_165_1.callingController_:SetSelectedState("normal")

				arg_165_1.keyicon_.color = Color.New(1, 1, 1)
				arg_165_1.icon_.color = Color.New(1, 1, 1)

				local var_168_9 = arg_165_1:GetWordFromCfg(222071041)
				local var_168_10 = arg_165_1:FormatText(var_168_9.content)

				arg_165_1.text_.text = var_168_10

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_11 = 34
				local var_168_12 = utf8.len(var_168_10)
				local var_168_13 = var_168_11 <= 0 and var_168_7 or var_168_7 * (var_168_12 / var_168_11)

				if var_168_13 > 0 and var_168_7 < var_168_13 then
					arg_165_1.talkMaxDuration = var_168_13

					if var_168_13 + var_168_6 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_13 + var_168_6
					end
				end

				arg_165_1.text_.text = var_168_10
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222071", "222071041", "story_v_out_222071.awb") ~= 0 then
					local var_168_14 = manager.audio:GetVoiceLength("story_v_out_222071", "222071041", "story_v_out_222071.awb") / 1000

					if var_168_14 + var_168_6 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_14 + var_168_6
					end

					if var_168_9.prefab_name ~= "" and arg_165_1.actors_[var_168_9.prefab_name] ~= nil then
						local var_168_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_9.prefab_name].transform, "story_v_out_222071", "222071041", "story_v_out_222071.awb")

						arg_165_1:RecordAudio("222071041", var_168_15)
						arg_165_1:RecordAudio("222071041", var_168_15)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_out_222071", "222071041", "story_v_out_222071.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_out_222071", "222071041", "story_v_out_222071.awb")
				end

				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_16 = math.max(var_168_7, arg_165_1.talkMaxDuration)

			if var_168_6 <= arg_165_1.time_ and arg_165_1.time_ < var_168_6 + var_168_16 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_6) / var_168_16

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_6 + var_168_16 and arg_165_1.time_ < var_168_6 + var_168_16 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {}

		arg_165_1:InitPlayNodeList()
	end,
	Play222071042 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 222071042
		arg_169_1.duration_ = 12.57

		local var_169_0 = {
			ja = 12.566,
			ko = 8.6,
			zh = 8.6
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
				arg_169_0:Play222071043(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = 0
			local var_172_1 = 1.1

			if var_172_0 < arg_169_1.time_ and arg_169_1.time_ <= var_172_0 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				local var_172_2 = arg_169_1:FormatText(StoryNameCfg[467].name)

				arg_169_1.leftNameTxt_.text = var_172_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, true)
				arg_169_1.iconController_:SetSelectedState("hero")

				arg_169_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenma")

				arg_169_1.callingController_:SetSelectedState("normal")

				arg_169_1.keyicon_.color = Color.New(1, 1, 1)
				arg_169_1.icon_.color = Color.New(1, 1, 1)

				local var_172_3 = arg_169_1:GetWordFromCfg(222071042)
				local var_172_4 = arg_169_1:FormatText(var_172_3.content)

				arg_169_1.text_.text = var_172_4

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_5 = 44
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

				if manager.audio:GetVoiceLength("story_v_out_222071", "222071042", "story_v_out_222071.awb") ~= 0 then
					local var_172_8 = manager.audio:GetVoiceLength("story_v_out_222071", "222071042", "story_v_out_222071.awb") / 1000

					if var_172_8 + var_172_0 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_8 + var_172_0
					end

					if var_172_3.prefab_name ~= "" and arg_169_1.actors_[var_172_3.prefab_name] ~= nil then
						local var_172_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_3.prefab_name].transform, "story_v_out_222071", "222071042", "story_v_out_222071.awb")

						arg_169_1:RecordAudio("222071042", var_172_9)
						arg_169_1:RecordAudio("222071042", var_172_9)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_out_222071", "222071042", "story_v_out_222071.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_out_222071", "222071042", "story_v_out_222071.awb")
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
	Play222071043 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 222071043
		arg_173_1.duration_ = 4

		local var_173_0 = {
			ja = 1.999999999999,
			ko = 4,
			zh = 4
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
				arg_173_0:Play222071044(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			local var_176_0 = arg_173_1.actors_["1074ui_story"]
			local var_176_1 = 0

			if var_176_1 < arg_173_1.time_ and arg_173_1.time_ <= var_176_1 + arg_176_0 and not isNil(var_176_0) and arg_173_1.var_.characterEffect1074ui_story == nil then
				arg_173_1.var_.characterEffect1074ui_story = var_176_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_2 = 0.200000002980232

			if var_176_1 <= arg_173_1.time_ and arg_173_1.time_ < var_176_1 + var_176_2 and not isNil(var_176_0) then
				local var_176_3 = (arg_173_1.time_ - var_176_1) / var_176_2

				if arg_173_1.var_.characterEffect1074ui_story and not isNil(var_176_0) then
					arg_173_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_173_1.time_ >= var_176_1 + var_176_2 and arg_173_1.time_ < var_176_1 + var_176_2 + arg_176_0 and not isNil(var_176_0) and arg_173_1.var_.characterEffect1074ui_story then
				arg_173_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_176_4 = 0

			if var_176_4 < arg_173_1.time_ and arg_173_1.time_ <= var_176_4 + arg_176_0 then
				arg_173_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action1_1")
			end

			local var_176_5 = 0

			if var_176_5 < arg_173_1.time_ and arg_173_1.time_ <= var_176_5 + arg_176_0 then
				arg_173_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_176_6 = 0
			local var_176_7 = 0.05

			if var_176_6 < arg_173_1.time_ and arg_173_1.time_ <= var_176_6 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				local var_176_8 = arg_173_1:FormatText(StoryNameCfg[410].name)

				arg_173_1.leftNameTxt_.text = var_176_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_9 = arg_173_1:GetWordFromCfg(222071043)
				local var_176_10 = arg_173_1:FormatText(var_176_9.content)

				arg_173_1.text_.text = var_176_10

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_11 = 2
				local var_176_12 = utf8.len(var_176_10)
				local var_176_13 = var_176_11 <= 0 and var_176_7 or var_176_7 * (var_176_12 / var_176_11)

				if var_176_13 > 0 and var_176_7 < var_176_13 then
					arg_173_1.talkMaxDuration = var_176_13

					if var_176_13 + var_176_6 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_13 + var_176_6
					end
				end

				arg_173_1.text_.text = var_176_10
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222071", "222071043", "story_v_out_222071.awb") ~= 0 then
					local var_176_14 = manager.audio:GetVoiceLength("story_v_out_222071", "222071043", "story_v_out_222071.awb") / 1000

					if var_176_14 + var_176_6 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_14 + var_176_6
					end

					if var_176_9.prefab_name ~= "" and arg_173_1.actors_[var_176_9.prefab_name] ~= nil then
						local var_176_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_9.prefab_name].transform, "story_v_out_222071", "222071043", "story_v_out_222071.awb")

						arg_173_1:RecordAudio("222071043", var_176_15)
						arg_173_1:RecordAudio("222071043", var_176_15)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_out_222071", "222071043", "story_v_out_222071.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_out_222071", "222071043", "story_v_out_222071.awb")
				end

				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_16 = math.max(var_176_7, arg_173_1.talkMaxDuration)

			if var_176_6 <= arg_173_1.time_ and arg_173_1.time_ < var_176_6 + var_176_16 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_6) / var_176_16

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_6 + var_176_16 and arg_173_1.time_ < var_176_6 + var_176_16 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {}

		arg_173_1:InitPlayNodeList()
	end,
	Play222071044 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 222071044
		arg_177_1.duration_ = 5

		SetActive(arg_177_1.tipsGo_, false)

		function arg_177_1.onSingleLineFinish_()
			arg_177_1.onSingleLineUpdate_ = nil
			arg_177_1.onSingleLineFinish_ = nil
			arg_177_1.state_ = "waiting"
		end

		function arg_177_1.playNext_(arg_179_0)
			if arg_179_0 == 1 then
				arg_177_0:Play222071045(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = arg_177_1.actors_["1074ui_story"].transform
			local var_180_1 = 0

			if var_180_1 < arg_177_1.time_ and arg_177_1.time_ <= var_180_1 + arg_180_0 then
				arg_177_1.var_.moveOldPos1074ui_story = var_180_0.localPosition
			end

			local var_180_2 = 0.001

			if var_180_1 <= arg_177_1.time_ and arg_177_1.time_ < var_180_1 + var_180_2 then
				local var_180_3 = (arg_177_1.time_ - var_180_1) / var_180_2
				local var_180_4 = Vector3.New(0, 100, 0)

				var_180_0.localPosition = Vector3.Lerp(arg_177_1.var_.moveOldPos1074ui_story, var_180_4, var_180_3)

				local var_180_5 = manager.ui.mainCamera.transform.position - var_180_0.position

				var_180_0.forward = Vector3.New(var_180_5.x, var_180_5.y, var_180_5.z)

				local var_180_6 = var_180_0.localEulerAngles

				var_180_6.z = 0
				var_180_6.x = 0
				var_180_0.localEulerAngles = var_180_6
			end

			if arg_177_1.time_ >= var_180_1 + var_180_2 and arg_177_1.time_ < var_180_1 + var_180_2 + arg_180_0 then
				var_180_0.localPosition = Vector3.New(0, 100, 0)

				local var_180_7 = manager.ui.mainCamera.transform.position - var_180_0.position

				var_180_0.forward = Vector3.New(var_180_7.x, var_180_7.y, var_180_7.z)

				local var_180_8 = var_180_0.localEulerAngles

				var_180_8.z = 0
				var_180_8.x = 0
				var_180_0.localEulerAngles = var_180_8
			end

			local var_180_9 = arg_177_1.actors_["1074ui_story"]
			local var_180_10 = 0

			if var_180_10 < arg_177_1.time_ and arg_177_1.time_ <= var_180_10 + arg_180_0 and not isNil(var_180_9) and arg_177_1.var_.characterEffect1074ui_story == nil then
				arg_177_1.var_.characterEffect1074ui_story = var_180_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_11 = 0.200000002980232

			if var_180_10 <= arg_177_1.time_ and arg_177_1.time_ < var_180_10 + var_180_11 and not isNil(var_180_9) then
				local var_180_12 = (arg_177_1.time_ - var_180_10) / var_180_11

				if arg_177_1.var_.characterEffect1074ui_story and not isNil(var_180_9) then
					local var_180_13 = Mathf.Lerp(0, 0.5, var_180_12)

					arg_177_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_177_1.var_.characterEffect1074ui_story.fillRatio = var_180_13
				end
			end

			if arg_177_1.time_ >= var_180_10 + var_180_11 and arg_177_1.time_ < var_180_10 + var_180_11 + arg_180_0 and not isNil(var_180_9) and arg_177_1.var_.characterEffect1074ui_story then
				local var_180_14 = 0.5

				arg_177_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_177_1.var_.characterEffect1074ui_story.fillRatio = var_180_14
			end

			local var_180_15 = 0
			local var_180_16 = 1.425

			if var_180_15 < arg_177_1.time_ and arg_177_1.time_ <= var_180_15 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, false)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_17 = arg_177_1:GetWordFromCfg(222071044)
				local var_180_18 = arg_177_1:FormatText(var_180_17.content)

				arg_177_1.text_.text = var_180_18

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_19 = 57
				local var_180_20 = utf8.len(var_180_18)
				local var_180_21 = var_180_19 <= 0 and var_180_16 or var_180_16 * (var_180_20 / var_180_19)

				if var_180_21 > 0 and var_180_16 < var_180_21 then
					arg_177_1.talkMaxDuration = var_180_21

					if var_180_21 + var_180_15 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_21 + var_180_15
					end
				end

				arg_177_1.text_.text = var_180_18
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)
				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_22 = math.max(var_180_16, arg_177_1.talkMaxDuration)

			if var_180_15 <= arg_177_1.time_ and arg_177_1.time_ < var_180_15 + var_180_22 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_15) / var_180_22

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_15 + var_180_22 and arg_177_1.time_ < var_180_15 + var_180_22 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_177_1:InitPlayNodeList()
	end,
	Play222071045 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 222071045
		arg_181_1.duration_ = 5

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play222071046(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = 0
			local var_184_1 = 1.15

			if var_184_0 < arg_181_1.time_ and arg_181_1.time_ <= var_184_0 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, false)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_2 = arg_181_1:GetWordFromCfg(222071045)
				local var_184_3 = arg_181_1:FormatText(var_184_2.content)

				arg_181_1.text_.text = var_184_3

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_4 = 46
				local var_184_5 = utf8.len(var_184_3)
				local var_184_6 = var_184_4 <= 0 and var_184_1 or var_184_1 * (var_184_5 / var_184_4)

				if var_184_6 > 0 and var_184_1 < var_184_6 then
					arg_181_1.talkMaxDuration = var_184_6

					if var_184_6 + var_184_0 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_6 + var_184_0
					end
				end

				arg_181_1.text_.text = var_184_3
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)
				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_7 = math.max(var_184_1, arg_181_1.talkMaxDuration)

			if var_184_0 <= arg_181_1.time_ and arg_181_1.time_ < var_184_0 + var_184_7 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_0) / var_184_7

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_0 + var_184_7 and arg_181_1.time_ < var_184_0 + var_184_7 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {}

		arg_181_1:InitPlayNodeList()
	end,
	Play222071046 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 222071046
		arg_185_1.duration_ = 4.1

		local var_185_0 = {
			ja = 3.4,
			ko = 4.1,
			zh = 4.1
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
				arg_185_0:Play222071047(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = arg_185_1.actors_["1074ui_story"]
			local var_188_1 = 0

			if var_188_1 < arg_185_1.time_ and arg_185_1.time_ <= var_188_1 + arg_188_0 and not isNil(var_188_0) and arg_185_1.var_.characterEffect1074ui_story == nil then
				arg_185_1.var_.characterEffect1074ui_story = var_188_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_188_2 = 0.200000002980232

			if var_188_1 <= arg_185_1.time_ and arg_185_1.time_ < var_188_1 + var_188_2 and not isNil(var_188_0) then
				local var_188_3 = (arg_185_1.time_ - var_188_1) / var_188_2

				if arg_185_1.var_.characterEffect1074ui_story and not isNil(var_188_0) then
					arg_185_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_185_1.time_ >= var_188_1 + var_188_2 and arg_185_1.time_ < var_188_1 + var_188_2 + arg_188_0 and not isNil(var_188_0) and arg_185_1.var_.characterEffect1074ui_story then
				arg_185_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_188_4 = 0

			if var_188_4 < arg_185_1.time_ and arg_185_1.time_ <= var_188_4 + arg_188_0 then
				arg_185_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action1_1")
			end

			local var_188_5 = 0

			if var_188_5 < arg_185_1.time_ and arg_185_1.time_ <= var_188_5 + arg_188_0 then
				arg_185_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_188_6 = 0
			local var_188_7 = 0.375

			if var_188_6 < arg_185_1.time_ and arg_185_1.time_ <= var_188_6 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				local var_188_8 = arg_185_1:FormatText(StoryNameCfg[410].name)

				arg_185_1.leftNameTxt_.text = var_188_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_9 = arg_185_1:GetWordFromCfg(222071046)
				local var_188_10 = arg_185_1:FormatText(var_188_9.content)

				arg_185_1.text_.text = var_188_10

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_11 = 15
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

				if manager.audio:GetVoiceLength("story_v_out_222071", "222071046", "story_v_out_222071.awb") ~= 0 then
					local var_188_14 = manager.audio:GetVoiceLength("story_v_out_222071", "222071046", "story_v_out_222071.awb") / 1000

					if var_188_14 + var_188_6 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_14 + var_188_6
					end

					if var_188_9.prefab_name ~= "" and arg_185_1.actors_[var_188_9.prefab_name] ~= nil then
						local var_188_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_9.prefab_name].transform, "story_v_out_222071", "222071046", "story_v_out_222071.awb")

						arg_185_1:RecordAudio("222071046", var_188_15)
						arg_185_1:RecordAudio("222071046", var_188_15)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_out_222071", "222071046", "story_v_out_222071.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_out_222071", "222071046", "story_v_out_222071.awb")
				end

				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_16 = math.max(var_188_7, arg_185_1.talkMaxDuration)

			if var_188_6 <= arg_185_1.time_ and arg_185_1.time_ < var_188_6 + var_188_16 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_6) / var_188_16

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_6 + var_188_16 and arg_185_1.time_ < var_188_6 + var_188_16 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {}

		arg_185_1:InitPlayNodeList()
	end,
	Play222071047 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 222071047
		arg_189_1.duration_ = 9.1

		local var_189_0 = {
			ja = 9.1,
			ko = 7,
			zh = 7
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
				arg_189_0:Play222071048(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = 0

			if var_192_0 < arg_189_1.time_ and arg_189_1.time_ <= var_192_0 + arg_192_0 then
				arg_189_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action1_1")
			end

			local var_192_1 = 0

			if var_192_1 < arg_189_1.time_ and arg_189_1.time_ <= var_192_1 + arg_192_0 then
				arg_189_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_192_2 = 0
			local var_192_3 = 0.75

			if var_192_2 < arg_189_1.time_ and arg_189_1.time_ <= var_192_2 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				local var_192_4 = arg_189_1:FormatText(StoryNameCfg[410].name)

				arg_189_1.leftNameTxt_.text = var_192_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_5 = arg_189_1:GetWordFromCfg(222071047)
				local var_192_6 = arg_189_1:FormatText(var_192_5.content)

				arg_189_1.text_.text = var_192_6

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_7 = 30
				local var_192_8 = utf8.len(var_192_6)
				local var_192_9 = var_192_7 <= 0 and var_192_3 or var_192_3 * (var_192_8 / var_192_7)

				if var_192_9 > 0 and var_192_3 < var_192_9 then
					arg_189_1.talkMaxDuration = var_192_9

					if var_192_9 + var_192_2 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_9 + var_192_2
					end
				end

				arg_189_1.text_.text = var_192_6
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222071", "222071047", "story_v_out_222071.awb") ~= 0 then
					local var_192_10 = manager.audio:GetVoiceLength("story_v_out_222071", "222071047", "story_v_out_222071.awb") / 1000

					if var_192_10 + var_192_2 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_10 + var_192_2
					end

					if var_192_5.prefab_name ~= "" and arg_189_1.actors_[var_192_5.prefab_name] ~= nil then
						local var_192_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_5.prefab_name].transform, "story_v_out_222071", "222071047", "story_v_out_222071.awb")

						arg_189_1:RecordAudio("222071047", var_192_11)
						arg_189_1:RecordAudio("222071047", var_192_11)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_222071", "222071047", "story_v_out_222071.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_222071", "222071047", "story_v_out_222071.awb")
				end

				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_12 = math.max(var_192_3, arg_189_1.talkMaxDuration)

			if var_192_2 <= arg_189_1.time_ and arg_189_1.time_ < var_192_2 + var_192_12 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_2) / var_192_12

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_2 + var_192_12 and arg_189_1.time_ < var_192_2 + var_192_12 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {}

		arg_189_1:InitPlayNodeList()
	end,
	Play222071048 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 222071048
		arg_193_1.duration_ = 5

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play222071049(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = arg_193_1.actors_["1074ui_story"]
			local var_196_1 = 0

			if var_196_1 < arg_193_1.time_ and arg_193_1.time_ <= var_196_1 + arg_196_0 and not isNil(var_196_0) and arg_193_1.var_.characterEffect1074ui_story == nil then
				arg_193_1.var_.characterEffect1074ui_story = var_196_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_196_2 = 0.200000002980232

			if var_196_1 <= arg_193_1.time_ and arg_193_1.time_ < var_196_1 + var_196_2 and not isNil(var_196_0) then
				local var_196_3 = (arg_193_1.time_ - var_196_1) / var_196_2

				if arg_193_1.var_.characterEffect1074ui_story and not isNil(var_196_0) then
					local var_196_4 = Mathf.Lerp(0, 0.5, var_196_3)

					arg_193_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_193_1.var_.characterEffect1074ui_story.fillRatio = var_196_4
				end
			end

			if arg_193_1.time_ >= var_196_1 + var_196_2 and arg_193_1.time_ < var_196_1 + var_196_2 + arg_196_0 and not isNil(var_196_0) and arg_193_1.var_.characterEffect1074ui_story then
				local var_196_5 = 0.5

				arg_193_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_193_1.var_.characterEffect1074ui_story.fillRatio = var_196_5
			end

			local var_196_6 = 0
			local var_196_7 = 1.1

			if var_196_6 < arg_193_1.time_ and arg_193_1.time_ <= var_196_6 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, false)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_8 = arg_193_1:GetWordFromCfg(222071048)
				local var_196_9 = arg_193_1:FormatText(var_196_8.content)

				arg_193_1.text_.text = var_196_9

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_10 = 44
				local var_196_11 = utf8.len(var_196_9)
				local var_196_12 = var_196_10 <= 0 and var_196_7 or var_196_7 * (var_196_11 / var_196_10)

				if var_196_12 > 0 and var_196_7 < var_196_12 then
					arg_193_1.talkMaxDuration = var_196_12

					if var_196_12 + var_196_6 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_12 + var_196_6
					end
				end

				arg_193_1.text_.text = var_196_9
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)
				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_13 = math.max(var_196_7, arg_193_1.talkMaxDuration)

			if var_196_6 <= arg_193_1.time_ and arg_193_1.time_ < var_196_6 + var_196_13 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_6) / var_196_13

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_6 + var_196_13 and arg_193_1.time_ < var_196_6 + var_196_13 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {}

		arg_193_1:InitPlayNodeList()
	end,
	Play222071049 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 222071049
		arg_197_1.duration_ = 2.9

		local var_197_0 = {
			ja = 2.9,
			ko = 2.366,
			zh = 2.4
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
				arg_197_0:Play222071050(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = arg_197_1.actors_["1074ui_story"]
			local var_200_1 = 0

			if var_200_1 < arg_197_1.time_ and arg_197_1.time_ <= var_200_1 + arg_200_0 and not isNil(var_200_0) and arg_197_1.var_.characterEffect1074ui_story == nil then
				arg_197_1.var_.characterEffect1074ui_story = var_200_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_200_2 = 0.200000002980232

			if var_200_1 <= arg_197_1.time_ and arg_197_1.time_ < var_200_1 + var_200_2 and not isNil(var_200_0) then
				local var_200_3 = (arg_197_1.time_ - var_200_1) / var_200_2

				if arg_197_1.var_.characterEffect1074ui_story and not isNil(var_200_0) then
					arg_197_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_197_1.time_ >= var_200_1 + var_200_2 and arg_197_1.time_ < var_200_1 + var_200_2 + arg_200_0 and not isNil(var_200_0) and arg_197_1.var_.characterEffect1074ui_story then
				arg_197_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_200_4 = 0
			local var_200_5 = 0.200000002980232

			if var_200_4 < arg_197_1.time_ and arg_197_1.time_ <= var_200_4 + arg_200_0 then
				local var_200_6 = "play"
				local var_200_7 = "music"

				arg_197_1:AudioAction(var_200_6, var_200_7, "ui_battle", "ui_battle_stopbgm", "")

				local var_200_8 = ""
				local var_200_9 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_200_9 ~= "" then
					if arg_197_1.bgmTxt_.text ~= var_200_9 and arg_197_1.bgmTxt_.text ~= "" then
						if arg_197_1.bgmTxt2_.text ~= "" then
							arg_197_1.bgmTxt_.text = arg_197_1.bgmTxt2_.text
						end

						arg_197_1.bgmTxt2_.text = var_200_9

						arg_197_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_197_1.bgmTxt_.text = var_200_9
						arg_197_1.bgmTxt2_.text = var_200_9
					end

					if arg_197_1.bgmTimer then
						arg_197_1.bgmTimer:Stop()

						arg_197_1.bgmTimer = nil
					end

					if arg_197_1.settingData.show_music_name == 1 then
						arg_197_1.musicController:SetSelectedState("show")
						arg_197_1.musicAnimator_:Play("open", 0, 0)

						if arg_197_1.settingData.music_time ~= 0 then
							arg_197_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_197_1.settingData.music_time), function()
								if arg_197_1 == nil or isNil(arg_197_1.bgmTxt_) then
									return
								end

								arg_197_1.musicController:SetSelectedState("hide")
								arg_197_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_200_10 = 0
			local var_200_11 = 0.125

			if var_200_10 < arg_197_1.time_ and arg_197_1.time_ <= var_200_10 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				local var_200_12 = arg_197_1:FormatText(StoryNameCfg[410].name)

				arg_197_1.leftNameTxt_.text = var_200_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_13 = arg_197_1:GetWordFromCfg(222071049)
				local var_200_14 = arg_197_1:FormatText(var_200_13.content)

				arg_197_1.text_.text = var_200_14

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_15 = 5
				local var_200_16 = utf8.len(var_200_14)
				local var_200_17 = var_200_15 <= 0 and var_200_11 or var_200_11 * (var_200_16 / var_200_15)

				if var_200_17 > 0 and var_200_11 < var_200_17 then
					arg_197_1.talkMaxDuration = var_200_17

					if var_200_17 + var_200_10 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_17 + var_200_10
					end
				end

				arg_197_1.text_.text = var_200_14
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222071", "222071049", "story_v_out_222071.awb") ~= 0 then
					local var_200_18 = manager.audio:GetVoiceLength("story_v_out_222071", "222071049", "story_v_out_222071.awb") / 1000

					if var_200_18 + var_200_10 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_18 + var_200_10
					end

					if var_200_13.prefab_name ~= "" and arg_197_1.actors_[var_200_13.prefab_name] ~= nil then
						local var_200_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_13.prefab_name].transform, "story_v_out_222071", "222071049", "story_v_out_222071.awb")

						arg_197_1:RecordAudio("222071049", var_200_19)
						arg_197_1:RecordAudio("222071049", var_200_19)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_out_222071", "222071049", "story_v_out_222071.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_out_222071", "222071049", "story_v_out_222071.awb")
				end

				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_20 = math.max(var_200_11, arg_197_1.talkMaxDuration)

			if var_200_10 <= arg_197_1.time_ and arg_197_1.time_ < var_200_10 + var_200_20 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_10) / var_200_20

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_10 + var_200_20 and arg_197_1.time_ < var_200_10 + var_200_20 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {}

		arg_197_1:InitPlayNodeList()
	end,
	Play222071050 = function(arg_202_0, arg_202_1)
		arg_202_1.time_ = 0
		arg_202_1.frameCnt_ = 0
		arg_202_1.state_ = "playing"
		arg_202_1.curTalkId_ = 222071050
		arg_202_1.duration_ = 5

		SetActive(arg_202_1.tipsGo_, false)

		function arg_202_1.onSingleLineFinish_()
			arg_202_1.onSingleLineUpdate_ = nil
			arg_202_1.onSingleLineFinish_ = nil
			arg_202_1.state_ = "waiting"
		end

		function arg_202_1.playNext_(arg_204_0)
			if arg_204_0 == 1 then
				arg_202_0:Play222071051(arg_202_1)
			end
		end

		function arg_202_1.onSingleLineUpdate_(arg_205_0)
			local var_205_0 = 0
			local var_205_1 = 0.95

			if var_205_0 < arg_202_1.time_ and arg_202_1.time_ <= var_205_0 + arg_205_0 then
				arg_202_1.talkMaxDuration = 0
				arg_202_1.dialogCg_.alpha = 1

				arg_202_1.dialog_:SetActive(true)
				SetActive(arg_202_1.leftNameGo_, false)

				arg_202_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_202_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_202_1:RecordName(arg_202_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_202_1.iconTrs_.gameObject, false)
				arg_202_1.callingController_:SetSelectedState("normal")

				local var_205_2 = arg_202_1:GetWordFromCfg(222071050)
				local var_205_3 = arg_202_1:FormatText(var_205_2.content)

				arg_202_1.text_.text = var_205_3

				LuaForUtil.ClearLinePrefixSymbol(arg_202_1.text_)

				local var_205_4 = 38
				local var_205_5 = utf8.len(var_205_3)
				local var_205_6 = var_205_4 <= 0 and var_205_1 or var_205_1 * (var_205_5 / var_205_4)

				if var_205_6 > 0 and var_205_1 < var_205_6 then
					arg_202_1.talkMaxDuration = var_205_6

					if var_205_6 + var_205_0 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_6 + var_205_0
					end
				end

				arg_202_1.text_.text = var_205_3
				arg_202_1.typewritter.percent = 0

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(false)
				arg_202_1:RecordContent(arg_202_1.text_.text)
			end

			local var_205_7 = math.max(var_205_1, arg_202_1.talkMaxDuration)

			if var_205_0 <= arg_202_1.time_ and arg_202_1.time_ < var_205_0 + var_205_7 then
				arg_202_1.typewritter.percent = (arg_202_1.time_ - var_205_0) / var_205_7

				arg_202_1.typewritter:SetDirty()
			end

			if arg_202_1.time_ >= var_205_0 + var_205_7 and arg_202_1.time_ < var_205_0 + var_205_7 + arg_205_0 then
				arg_202_1.typewritter.percent = 1

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(true)
			end
		end

		arg_202_1.nodeConfigList_ = {}

		arg_202_1:InitPlayNodeList()
	end,
	Play222071051 = function(arg_206_0, arg_206_1)
		arg_206_1.time_ = 0
		arg_206_1.frameCnt_ = 0
		arg_206_1.state_ = "playing"
		arg_206_1.curTalkId_ = 222071051
		arg_206_1.duration_ = 11.07

		local var_206_0 = {
			ja = 11.066,
			ko = 5.266,
			zh = 5.266
		}
		local var_206_1 = manager.audio:GetLocalizationFlag()

		if var_206_0[var_206_1] ~= nil then
			arg_206_1.duration_ = var_206_0[var_206_1]
		end

		SetActive(arg_206_1.tipsGo_, false)

		function arg_206_1.onSingleLineFinish_()
			arg_206_1.onSingleLineUpdate_ = nil
			arg_206_1.onSingleLineFinish_ = nil
			arg_206_1.state_ = "waiting"
		end

		function arg_206_1.playNext_(arg_208_0)
			if arg_208_0 == 1 then
				arg_206_0:Play222071052(arg_206_1)
			end
		end

		function arg_206_1.onSingleLineUpdate_(arg_209_0)
			local var_209_0 = 0

			if var_209_0 < arg_206_1.time_ and arg_206_1.time_ <= var_209_0 + arg_209_0 then
				arg_206_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action1_1")
			end

			local var_209_1 = 0

			if var_209_1 < arg_206_1.time_ and arg_206_1.time_ <= var_209_1 + arg_209_0 then
				arg_206_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_209_2 = 0
			local var_209_3 = 0.575

			if var_209_2 < arg_206_1.time_ and arg_206_1.time_ <= var_209_2 + arg_209_0 then
				arg_206_1.talkMaxDuration = 0
				arg_206_1.dialogCg_.alpha = 1

				arg_206_1.dialog_:SetActive(true)
				SetActive(arg_206_1.leftNameGo_, true)

				local var_209_4 = arg_206_1:FormatText(StoryNameCfg[410].name)

				arg_206_1.leftNameTxt_.text = var_209_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_206_1.leftNameTxt_.transform)

				arg_206_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_206_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_206_1:RecordName(arg_206_1.leftNameTxt_.text)
				SetActive(arg_206_1.iconTrs_.gameObject, false)
				arg_206_1.callingController_:SetSelectedState("normal")

				local var_209_5 = arg_206_1:GetWordFromCfg(222071051)
				local var_209_6 = arg_206_1:FormatText(var_209_5.content)

				arg_206_1.text_.text = var_209_6

				LuaForUtil.ClearLinePrefixSymbol(arg_206_1.text_)

				local var_209_7 = 23
				local var_209_8 = utf8.len(var_209_6)
				local var_209_9 = var_209_7 <= 0 and var_209_3 or var_209_3 * (var_209_8 / var_209_7)

				if var_209_9 > 0 and var_209_3 < var_209_9 then
					arg_206_1.talkMaxDuration = var_209_9

					if var_209_9 + var_209_2 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_9 + var_209_2
					end
				end

				arg_206_1.text_.text = var_209_6
				arg_206_1.typewritter.percent = 0

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222071", "222071051", "story_v_out_222071.awb") ~= 0 then
					local var_209_10 = manager.audio:GetVoiceLength("story_v_out_222071", "222071051", "story_v_out_222071.awb") / 1000

					if var_209_10 + var_209_2 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_10 + var_209_2
					end

					if var_209_5.prefab_name ~= "" and arg_206_1.actors_[var_209_5.prefab_name] ~= nil then
						local var_209_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_206_1.actors_[var_209_5.prefab_name].transform, "story_v_out_222071", "222071051", "story_v_out_222071.awb")

						arg_206_1:RecordAudio("222071051", var_209_11)
						arg_206_1:RecordAudio("222071051", var_209_11)
					else
						arg_206_1:AudioAction("play", "voice", "story_v_out_222071", "222071051", "story_v_out_222071.awb")
					end

					arg_206_1:RecordHistoryTalkVoice("story_v_out_222071", "222071051", "story_v_out_222071.awb")
				end

				arg_206_1:RecordContent(arg_206_1.text_.text)
			end

			local var_209_12 = math.max(var_209_3, arg_206_1.talkMaxDuration)

			if var_209_2 <= arg_206_1.time_ and arg_206_1.time_ < var_209_2 + var_209_12 then
				arg_206_1.typewritter.percent = (arg_206_1.time_ - var_209_2) / var_209_12

				arg_206_1.typewritter:SetDirty()
			end

			if arg_206_1.time_ >= var_209_2 + var_209_12 and arg_206_1.time_ < var_209_2 + var_209_12 + arg_209_0 then
				arg_206_1.typewritter.percent = 1

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(true)
			end
		end

		arg_206_1.nodeConfigList_ = {}

		arg_206_1:InitPlayNodeList()
	end,
	Play222071052 = function(arg_210_0, arg_210_1)
		arg_210_1.time_ = 0
		arg_210_1.frameCnt_ = 0
		arg_210_1.state_ = "playing"
		arg_210_1.curTalkId_ = 222071052
		arg_210_1.duration_ = 7

		SetActive(arg_210_1.tipsGo_, false)

		function arg_210_1.onSingleLineFinish_()
			arg_210_1.onSingleLineUpdate_ = nil
			arg_210_1.onSingleLineFinish_ = nil
			arg_210_1.state_ = "waiting"
		end

		function arg_210_1.playNext_(arg_212_0)
			if arg_212_0 == 1 then
				arg_210_0:Play222071053(arg_210_1)
			end
		end

		function arg_210_1.onSingleLineUpdate_(arg_213_0)
			local var_213_0 = "ST52"

			if arg_210_1.bgs_[var_213_0] == nil then
				local var_213_1 = Object.Instantiate(arg_210_1.paintGo_)

				var_213_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_213_0)
				var_213_1.name = var_213_0
				var_213_1.transform.parent = arg_210_1.stage_.transform
				var_213_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_210_1.bgs_[var_213_0] = var_213_1
			end

			local var_213_2 = 0

			if var_213_2 < arg_210_1.time_ and arg_210_1.time_ <= var_213_2 + arg_213_0 then
				local var_213_3 = manager.ui.mainCamera.transform.localPosition
				local var_213_4 = Vector3.New(0, 0, 10) + Vector3.New(var_213_3.x, var_213_3.y, 0)
				local var_213_5 = arg_210_1.bgs_.ST52

				var_213_5.transform.localPosition = var_213_4
				var_213_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_213_6 = var_213_5:GetComponent("SpriteRenderer")

				if var_213_6 and var_213_6.sprite then
					local var_213_7 = (var_213_5.transform.localPosition - var_213_3).z
					local var_213_8 = manager.ui.mainCameraCom_
					local var_213_9 = 2 * var_213_7 * Mathf.Tan(var_213_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_213_10 = var_213_9 * var_213_8.aspect
					local var_213_11 = var_213_6.sprite.bounds.size.x
					local var_213_12 = var_213_6.sprite.bounds.size.y
					local var_213_13 = var_213_10 / var_213_11
					local var_213_14 = var_213_9 / var_213_12
					local var_213_15 = var_213_14 < var_213_13 and var_213_13 or var_213_14

					var_213_5.transform.localScale = Vector3.New(var_213_15, var_213_15, 0)
				end

				for iter_213_0, iter_213_1 in pairs(arg_210_1.bgs_) do
					if iter_213_0 ~= "ST52" then
						iter_213_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_213_16 = 0

			if var_213_16 < arg_210_1.time_ and arg_210_1.time_ <= var_213_16 + arg_213_0 then
				arg_210_1.mask_.enabled = true
				arg_210_1.mask_.raycastTarget = true

				arg_210_1:SetGaussion(false)
			end

			local var_213_17 = 2

			if var_213_16 <= arg_210_1.time_ and arg_210_1.time_ < var_213_16 + var_213_17 then
				local var_213_18 = (arg_210_1.time_ - var_213_16) / var_213_17
				local var_213_19 = Color.New(1, 1, 1)

				var_213_19.a = Mathf.Lerp(1, 0, var_213_18)
				arg_210_1.mask_.color = var_213_19
			end

			if arg_210_1.time_ >= var_213_16 + var_213_17 and arg_210_1.time_ < var_213_16 + var_213_17 + arg_213_0 then
				local var_213_20 = Color.New(1, 1, 1)
				local var_213_21 = 0

				arg_210_1.mask_.enabled = false
				var_213_20.a = var_213_21
				arg_210_1.mask_.color = var_213_20
			end

			local var_213_22 = arg_210_1.actors_["1074ui_story"].transform
			local var_213_23 = 0

			if var_213_23 < arg_210_1.time_ and arg_210_1.time_ <= var_213_23 + arg_213_0 then
				arg_210_1.var_.moveOldPos1074ui_story = var_213_22.localPosition
			end

			local var_213_24 = 0.001

			if var_213_23 <= arg_210_1.time_ and arg_210_1.time_ < var_213_23 + var_213_24 then
				local var_213_25 = (arg_210_1.time_ - var_213_23) / var_213_24
				local var_213_26 = Vector3.New(0, 100, 0)

				var_213_22.localPosition = Vector3.Lerp(arg_210_1.var_.moveOldPos1074ui_story, var_213_26, var_213_25)

				local var_213_27 = manager.ui.mainCamera.transform.position - var_213_22.position

				var_213_22.forward = Vector3.New(var_213_27.x, var_213_27.y, var_213_27.z)

				local var_213_28 = var_213_22.localEulerAngles

				var_213_28.z = 0
				var_213_28.x = 0
				var_213_22.localEulerAngles = var_213_28
			end

			if arg_210_1.time_ >= var_213_23 + var_213_24 and arg_210_1.time_ < var_213_23 + var_213_24 + arg_213_0 then
				var_213_22.localPosition = Vector3.New(0, 100, 0)

				local var_213_29 = manager.ui.mainCamera.transform.position - var_213_22.position

				var_213_22.forward = Vector3.New(var_213_29.x, var_213_29.y, var_213_29.z)

				local var_213_30 = var_213_22.localEulerAngles

				var_213_30.z = 0
				var_213_30.x = 0
				var_213_22.localEulerAngles = var_213_30
			end

			local var_213_31 = arg_210_1.actors_["1074ui_story"]
			local var_213_32 = 0

			if var_213_32 < arg_210_1.time_ and arg_210_1.time_ <= var_213_32 + arg_213_0 and not isNil(var_213_31) and arg_210_1.var_.characterEffect1074ui_story == nil then
				arg_210_1.var_.characterEffect1074ui_story = var_213_31:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_213_33 = 0.200000002980232

			if var_213_32 <= arg_210_1.time_ and arg_210_1.time_ < var_213_32 + var_213_33 and not isNil(var_213_31) then
				local var_213_34 = (arg_210_1.time_ - var_213_32) / var_213_33

				if arg_210_1.var_.characterEffect1074ui_story and not isNil(var_213_31) then
					local var_213_35 = Mathf.Lerp(0, 0.5, var_213_34)

					arg_210_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_210_1.var_.characterEffect1074ui_story.fillRatio = var_213_35
				end
			end

			if arg_210_1.time_ >= var_213_32 + var_213_33 and arg_210_1.time_ < var_213_32 + var_213_33 + arg_213_0 and not isNil(var_213_31) and arg_210_1.var_.characterEffect1074ui_story then
				local var_213_36 = 0.5

				arg_210_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_210_1.var_.characterEffect1074ui_story.fillRatio = var_213_36
			end

			local var_213_37 = 0
			local var_213_38 = 0.366666666666667

			if var_213_37 < arg_210_1.time_ and arg_210_1.time_ <= var_213_37 + arg_213_0 then
				local var_213_39 = "play"
				local var_213_40 = "effect"

				arg_210_1:AudioAction(var_213_39, var_213_40, "se_story_222_00", "se_story_222_00_enchantment_start", "")
			end

			local var_213_41 = 0
			local var_213_42 = 0.034000001847744

			if var_213_41 < arg_210_1.time_ and arg_210_1.time_ <= var_213_41 + arg_213_0 then
				local var_213_43 = "play"
				local var_213_44 = "music"

				arg_210_1:AudioAction(var_213_43, var_213_44, "ui_battle", "ui_battle_stopbgm", "")

				local var_213_45 = ""
				local var_213_46 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_213_46 ~= "" then
					if arg_210_1.bgmTxt_.text ~= var_213_46 and arg_210_1.bgmTxt_.text ~= "" then
						if arg_210_1.bgmTxt2_.text ~= "" then
							arg_210_1.bgmTxt_.text = arg_210_1.bgmTxt2_.text
						end

						arg_210_1.bgmTxt2_.text = var_213_46

						arg_210_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_210_1.bgmTxt_.text = var_213_46
						arg_210_1.bgmTxt2_.text = var_213_46
					end

					if arg_210_1.bgmTimer then
						arg_210_1.bgmTimer:Stop()

						arg_210_1.bgmTimer = nil
					end

					if arg_210_1.settingData.show_music_name == 1 then
						arg_210_1.musicController:SetSelectedState("show")
						arg_210_1.musicAnimator_:Play("open", 0, 0)

						if arg_210_1.settingData.music_time ~= 0 then
							arg_210_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_210_1.settingData.music_time), function()
								if arg_210_1 == nil or isNil(arg_210_1.bgmTxt_) then
									return
								end

								arg_210_1.musicController:SetSelectedState("hide")
								arg_210_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_213_47 = arg_210_1.bgs_.ST52.transform
			local var_213_48 = 0

			if var_213_48 < arg_210_1.time_ and arg_210_1.time_ <= var_213_48 + arg_213_0 then
				arg_210_1.var_.moveOldPosST52 = var_213_47.localPosition
			end

			local var_213_49 = 4

			if var_213_48 <= arg_210_1.time_ and arg_210_1.time_ < var_213_48 + var_213_49 then
				local var_213_50 = (arg_210_1.time_ - var_213_48) / var_213_49
				local var_213_51 = Vector3.New(0, 1, 9.5)

				var_213_47.localPosition = Vector3.Lerp(arg_210_1.var_.moveOldPosST52, var_213_51, var_213_50)
			end

			if arg_210_1.time_ >= var_213_48 + var_213_49 and arg_210_1.time_ < var_213_48 + var_213_49 + arg_213_0 then
				var_213_47.localPosition = Vector3.New(0, 1, 9.5)
			end

			local var_213_52 = 2

			if var_213_52 < arg_210_1.time_ and arg_210_1.time_ <= var_213_52 + arg_213_0 then
				arg_210_1.allBtn_.enabled = false
			end

			local var_213_53 = 1.93333333333333

			if arg_210_1.time_ >= var_213_52 + var_213_53 and arg_210_1.time_ < var_213_52 + var_213_53 + arg_213_0 then
				arg_210_1.allBtn_.enabled = true
			end

			local var_213_54 = 0
			local var_213_55 = 0.7

			if var_213_54 < arg_210_1.time_ and arg_210_1.time_ <= var_213_54 + arg_213_0 then
				local var_213_56 = "play"
				local var_213_57 = "music"

				arg_210_1:AudioAction(var_213_56, var_213_57, "ui_battle", "ui_battle_stopbgm", "")

				local var_213_58 = ""
				local var_213_59 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_213_59 ~= "" then
					if arg_210_1.bgmTxt_.text ~= var_213_59 and arg_210_1.bgmTxt_.text ~= "" then
						if arg_210_1.bgmTxt2_.text ~= "" then
							arg_210_1.bgmTxt_.text = arg_210_1.bgmTxt2_.text
						end

						arg_210_1.bgmTxt2_.text = var_213_59

						arg_210_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_210_1.bgmTxt_.text = var_213_59
						arg_210_1.bgmTxt2_.text = var_213_59
					end

					if arg_210_1.bgmTimer then
						arg_210_1.bgmTimer:Stop()

						arg_210_1.bgmTimer = nil
					end

					if arg_210_1.settingData.show_music_name == 1 then
						arg_210_1.musicController:SetSelectedState("show")
						arg_210_1.musicAnimator_:Play("open", 0, 0)

						if arg_210_1.settingData.music_time ~= 0 then
							arg_210_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_210_1.settingData.music_time), function()
								if arg_210_1 == nil or isNil(arg_210_1.bgmTxt_) then
									return
								end

								arg_210_1.musicController:SetSelectedState("hide")
								arg_210_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_213_60 = 0.9
			local var_213_61 = 1

			if var_213_60 < arg_210_1.time_ and arg_210_1.time_ <= var_213_60 + arg_213_0 then
				local var_213_62 = "play"
				local var_213_63 = "music"

				arg_210_1:AudioAction(var_213_62, var_213_63, "bgm_activity_2_2_story_ruomuhuajing", "bgm_activity_2_2_story_ruomuhuajing", "bgm_activity_2_2_story_ruomuhuajing.awb")

				local var_213_64 = ""
				local var_213_65 = manager.audio:GetAudioName("bgm_activity_2_2_story_ruomuhuajing", "bgm_activity_2_2_story_ruomuhuajing")

				if var_213_65 ~= "" then
					if arg_210_1.bgmTxt_.text ~= var_213_65 and arg_210_1.bgmTxt_.text ~= "" then
						if arg_210_1.bgmTxt2_.text ~= "" then
							arg_210_1.bgmTxt_.text = arg_210_1.bgmTxt2_.text
						end

						arg_210_1.bgmTxt2_.text = var_213_65

						arg_210_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_210_1.bgmTxt_.text = var_213_65
						arg_210_1.bgmTxt2_.text = var_213_65
					end

					if arg_210_1.bgmTimer then
						arg_210_1.bgmTimer:Stop()

						arg_210_1.bgmTimer = nil
					end

					if arg_210_1.settingData.show_music_name == 1 then
						arg_210_1.musicController:SetSelectedState("show")
						arg_210_1.musicAnimator_:Play("open", 0, 0)

						if arg_210_1.settingData.music_time ~= 0 then
							arg_210_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_210_1.settingData.music_time), function()
								if arg_210_1 == nil or isNil(arg_210_1.bgmTxt_) then
									return
								end

								arg_210_1.musicController:SetSelectedState("hide")
								arg_210_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_210_1.frameCnt_ <= 1 then
				arg_210_1.dialog_:SetActive(false)
			end

			local var_213_66 = 2
			local var_213_67 = 1.475

			if var_213_66 < arg_210_1.time_ and arg_210_1.time_ <= var_213_66 + arg_213_0 then
				arg_210_1.talkMaxDuration = 0

				arg_210_1.dialog_:SetActive(true)

				arg_210_1.dialogCg_.alpha = 0

				local var_213_68 = LeanTween.value(arg_210_1.dialog_, 0, 1, 0.3)

				var_213_68:setOnUpdate(LuaHelper.FloatAction(function(arg_217_0)
					arg_210_1.dialogCg_.alpha = arg_217_0
				end))
				var_213_68:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_210_1.dialog_)
					var_213_68:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_210_1.duration_ = arg_210_1.duration_ + 0.3

				SetActive(arg_210_1.leftNameGo_, false)

				arg_210_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_210_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_210_1:RecordName(arg_210_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_210_1.iconTrs_.gameObject, false)
				arg_210_1.callingController_:SetSelectedState("normal")

				local var_213_69 = arg_210_1:GetWordFromCfg(222071052)
				local var_213_70 = arg_210_1:FormatText(var_213_69.content)

				arg_210_1.text_.text = var_213_70

				LuaForUtil.ClearLinePrefixSymbol(arg_210_1.text_)

				local var_213_71 = 59
				local var_213_72 = utf8.len(var_213_70)
				local var_213_73 = var_213_71 <= 0 and var_213_67 or var_213_67 * (var_213_72 / var_213_71)

				if var_213_73 > 0 and var_213_67 < var_213_73 then
					arg_210_1.talkMaxDuration = var_213_73
					var_213_66 = var_213_66 + 0.3

					if var_213_73 + var_213_66 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_73 + var_213_66
					end
				end

				arg_210_1.text_.text = var_213_70
				arg_210_1.typewritter.percent = 0

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(false)
				arg_210_1:RecordContent(arg_210_1.text_.text)
			end

			local var_213_74 = var_213_66 + 0.3
			local var_213_75 = math.max(var_213_67, arg_210_1.talkMaxDuration)

			if var_213_74 <= arg_210_1.time_ and arg_210_1.time_ < var_213_74 + var_213_75 then
				arg_210_1.typewritter.percent = (arg_210_1.time_ - var_213_74) / var_213_75

				arg_210_1.typewritter:SetDirty()
			end

			if arg_210_1.time_ >= var_213_74 + var_213_75 and arg_210_1.time_ < var_213_74 + var_213_75 + arg_213_0 then
				arg_210_1.typewritter.percent = 1

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(true)
			end
		end

		arg_210_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "ST52",
				changeDisplayLayer = false,
				needEase = false,
				duration = 4,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_210_1:InitPlayNodeList()
	end,
	Play222071053 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 222071053
		arg_219_1.duration_ = 5

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"
		end

		function arg_219_1.playNext_(arg_221_0)
			if arg_221_0 == 1 then
				arg_219_0:Play222071054(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			local var_222_0 = 0
			local var_222_1 = 1.3

			if var_222_0 < arg_219_1.time_ and arg_219_1.time_ <= var_222_0 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, false)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_2 = arg_219_1:GetWordFromCfg(222071053)
				local var_222_3 = arg_219_1:FormatText(var_222_2.content)

				arg_219_1.text_.text = var_222_3

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_4 = 52
				local var_222_5 = utf8.len(var_222_3)
				local var_222_6 = var_222_4 <= 0 and var_222_1 or var_222_1 * (var_222_5 / var_222_4)

				if var_222_6 > 0 and var_222_1 < var_222_6 then
					arg_219_1.talkMaxDuration = var_222_6

					if var_222_6 + var_222_0 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_6 + var_222_0
					end
				end

				arg_219_1.text_.text = var_222_3
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)
				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_7 = math.max(var_222_1, arg_219_1.talkMaxDuration)

			if var_222_0 <= arg_219_1.time_ and arg_219_1.time_ < var_222_0 + var_222_7 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_0) / var_222_7

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_0 + var_222_7 and arg_219_1.time_ < var_222_0 + var_222_7 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {}

		arg_219_1:InitPlayNodeList()
	end,
	Play222071054 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 222071054
		arg_223_1.duration_ = 5

		SetActive(arg_223_1.tipsGo_, false)

		function arg_223_1.onSingleLineFinish_()
			arg_223_1.onSingleLineUpdate_ = nil
			arg_223_1.onSingleLineFinish_ = nil
			arg_223_1.state_ = "waiting"
		end

		function arg_223_1.playNext_(arg_225_0)
			if arg_225_0 == 1 then
				arg_223_0:Play222071055(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			local var_226_0 = 0
			local var_226_1 = 0.6

			if var_226_0 < arg_223_1.time_ and arg_223_1.time_ <= var_226_0 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, false)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_223_1.iconTrs_.gameObject, false)
				arg_223_1.callingController_:SetSelectedState("normal")

				local var_226_2 = arg_223_1:GetWordFromCfg(222071054)
				local var_226_3 = arg_223_1:FormatText(var_226_2.content)

				arg_223_1.text_.text = var_226_3

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_4 = 24
				local var_226_5 = utf8.len(var_226_3)
				local var_226_6 = var_226_4 <= 0 and var_226_1 or var_226_1 * (var_226_5 / var_226_4)

				if var_226_6 > 0 and var_226_1 < var_226_6 then
					arg_223_1.talkMaxDuration = var_226_6

					if var_226_6 + var_226_0 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_6 + var_226_0
					end
				end

				arg_223_1.text_.text = var_226_3
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)
				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_7 = math.max(var_226_1, arg_223_1.talkMaxDuration)

			if var_226_0 <= arg_223_1.time_ and arg_223_1.time_ < var_226_0 + var_226_7 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_0) / var_226_7

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_0 + var_226_7 and arg_223_1.time_ < var_226_0 + var_226_7 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {}

		arg_223_1:InitPlayNodeList()
	end,
	Play222071055 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 222071055
		arg_227_1.duration_ = 18.73

		local var_227_0 = {
			ja = 18.733,
			ko = 9.2,
			zh = 9.2
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
				arg_227_0:Play222071056(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			local var_230_0 = 0
			local var_230_1 = 0.975

			if var_230_0 < arg_227_1.time_ and arg_227_1.time_ <= var_230_0 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, true)

				local var_230_2 = arg_227_1:FormatText(StoryNameCfg[36].name)

				arg_227_1.leftNameTxt_.text = var_230_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, true)
				arg_227_1.iconController_:SetSelectedState("hero")

				arg_227_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1074_1")

				arg_227_1.callingController_:SetSelectedState("normal")

				arg_227_1.keyicon_.color = Color.New(1, 1, 1)
				arg_227_1.icon_.color = Color.New(1, 1, 1)

				local var_230_3 = arg_227_1:GetWordFromCfg(222071055)
				local var_230_4 = arg_227_1:FormatText(var_230_3.content)

				arg_227_1.text_.text = var_230_4

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_5 = 40
				local var_230_6 = utf8.len(var_230_4)
				local var_230_7 = var_230_5 <= 0 and var_230_1 or var_230_1 * (var_230_6 / var_230_5)

				if var_230_7 > 0 and var_230_1 < var_230_7 then
					arg_227_1.talkMaxDuration = var_230_7

					if var_230_7 + var_230_0 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_7 + var_230_0
					end
				end

				arg_227_1.text_.text = var_230_4
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222071", "222071055", "story_v_out_222071.awb") ~= 0 then
					local var_230_8 = manager.audio:GetVoiceLength("story_v_out_222071", "222071055", "story_v_out_222071.awb") / 1000

					if var_230_8 + var_230_0 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_8 + var_230_0
					end

					if var_230_3.prefab_name ~= "" and arg_227_1.actors_[var_230_3.prefab_name] ~= nil then
						local var_230_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_227_1.actors_[var_230_3.prefab_name].transform, "story_v_out_222071", "222071055", "story_v_out_222071.awb")

						arg_227_1:RecordAudio("222071055", var_230_9)
						arg_227_1:RecordAudio("222071055", var_230_9)
					else
						arg_227_1:AudioAction("play", "voice", "story_v_out_222071", "222071055", "story_v_out_222071.awb")
					end

					arg_227_1:RecordHistoryTalkVoice("story_v_out_222071", "222071055", "story_v_out_222071.awb")
				end

				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_10 = math.max(var_230_1, arg_227_1.talkMaxDuration)

			if var_230_0 <= arg_227_1.time_ and arg_227_1.time_ < var_230_0 + var_230_10 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_0) / var_230_10

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_0 + var_230_10 and arg_227_1.time_ < var_230_0 + var_230_10 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {}

		arg_227_1:InitPlayNodeList()
	end,
	Play222071056 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 222071056
		arg_231_1.duration_ = 11.13

		local var_231_0 = {
			ja = 11.133,
			ko = 7.433,
			zh = 7.433
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
				arg_231_0:Play222071057(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			local var_234_0 = 0
			local var_234_1 = 0.7

			if var_234_0 < arg_231_1.time_ and arg_231_1.time_ <= var_234_0 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, true)

				local var_234_2 = arg_231_1:FormatText(StoryNameCfg[36].name)

				arg_231_1.leftNameTxt_.text = var_234_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, true)
				arg_231_1.iconController_:SetSelectedState("hero")

				arg_231_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1074_1")

				arg_231_1.callingController_:SetSelectedState("normal")

				arg_231_1.keyicon_.color = Color.New(1, 1, 1)
				arg_231_1.icon_.color = Color.New(1, 1, 1)

				local var_234_3 = arg_231_1:GetWordFromCfg(222071056)
				local var_234_4 = arg_231_1:FormatText(var_234_3.content)

				arg_231_1.text_.text = var_234_4

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_5 = 28
				local var_234_6 = utf8.len(var_234_4)
				local var_234_7 = var_234_5 <= 0 and var_234_1 or var_234_1 * (var_234_6 / var_234_5)

				if var_234_7 > 0 and var_234_1 < var_234_7 then
					arg_231_1.talkMaxDuration = var_234_7

					if var_234_7 + var_234_0 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_7 + var_234_0
					end
				end

				arg_231_1.text_.text = var_234_4
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222071", "222071056", "story_v_out_222071.awb") ~= 0 then
					local var_234_8 = manager.audio:GetVoiceLength("story_v_out_222071", "222071056", "story_v_out_222071.awb") / 1000

					if var_234_8 + var_234_0 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_8 + var_234_0
					end

					if var_234_3.prefab_name ~= "" and arg_231_1.actors_[var_234_3.prefab_name] ~= nil then
						local var_234_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_231_1.actors_[var_234_3.prefab_name].transform, "story_v_out_222071", "222071056", "story_v_out_222071.awb")

						arg_231_1:RecordAudio("222071056", var_234_9)
						arg_231_1:RecordAudio("222071056", var_234_9)
					else
						arg_231_1:AudioAction("play", "voice", "story_v_out_222071", "222071056", "story_v_out_222071.awb")
					end

					arg_231_1:RecordHistoryTalkVoice("story_v_out_222071", "222071056", "story_v_out_222071.awb")
				end

				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_10 = math.max(var_234_1, arg_231_1.talkMaxDuration)

			if var_234_0 <= arg_231_1.time_ and arg_231_1.time_ < var_234_0 + var_234_10 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_0) / var_234_10

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_0 + var_234_10 and arg_231_1.time_ < var_234_0 + var_234_10 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {}

		arg_231_1:InitPlayNodeList()
	end,
	Play222071057 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 222071057
		arg_235_1.duration_ = 16.8

		local var_235_0 = {
			ja = 16.8,
			ko = 8.633,
			zh = 8.666
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
			arg_235_1.auto_ = false
		end

		function arg_235_1.playNext_(arg_237_0)
			arg_235_1.onStoryFinished_()
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			local var_238_0 = 0
			local var_238_1 = 0.7

			if var_238_0 < arg_235_1.time_ and arg_235_1.time_ <= var_238_0 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, true)

				local var_238_2 = arg_235_1:FormatText(StoryNameCfg[36].name)

				arg_235_1.leftNameTxt_.text = var_238_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, true)
				arg_235_1.iconController_:SetSelectedState("hero")

				arg_235_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1074_1")

				arg_235_1.callingController_:SetSelectedState("normal")

				arg_235_1.keyicon_.color = Color.New(1, 1, 1)
				arg_235_1.icon_.color = Color.New(1, 1, 1)

				local var_238_3 = arg_235_1:GetWordFromCfg(222071057)
				local var_238_4 = arg_235_1:FormatText(var_238_3.content)

				arg_235_1.text_.text = var_238_4

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_5 = 28
				local var_238_6 = utf8.len(var_238_4)
				local var_238_7 = var_238_5 <= 0 and var_238_1 or var_238_1 * (var_238_6 / var_238_5)

				if var_238_7 > 0 and var_238_1 < var_238_7 then
					arg_235_1.talkMaxDuration = var_238_7

					if var_238_7 + var_238_0 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_7 + var_238_0
					end
				end

				arg_235_1.text_.text = var_238_4
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222071", "222071057", "story_v_out_222071.awb") ~= 0 then
					local var_238_8 = manager.audio:GetVoiceLength("story_v_out_222071", "222071057", "story_v_out_222071.awb") / 1000

					if var_238_8 + var_238_0 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_8 + var_238_0
					end

					if var_238_3.prefab_name ~= "" and arg_235_1.actors_[var_238_3.prefab_name] ~= nil then
						local var_238_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_235_1.actors_[var_238_3.prefab_name].transform, "story_v_out_222071", "222071057", "story_v_out_222071.awb")

						arg_235_1:RecordAudio("222071057", var_238_9)
						arg_235_1:RecordAudio("222071057", var_238_9)
					else
						arg_235_1:AudioAction("play", "voice", "story_v_out_222071", "222071057", "story_v_out_222071.awb")
					end

					arg_235_1:RecordHistoryTalkVoice("story_v_out_222071", "222071057", "story_v_out_222071.awb")
				end

				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_10 = math.max(var_238_1, arg_235_1.talkMaxDuration)

			if var_238_0 <= arg_235_1.time_ and arg_235_1.time_ < var_238_0 + var_238_10 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_0) / var_238_10

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_0 + var_238_10 and arg_235_1.time_ < var_238_0 + var_238_10 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {}

		arg_235_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST47",
		"TextureConfig/Background/J16f",
		"TextureConfig/Background/ST52"
	},
	voices = {
		"story_v_out_222071.awb"
	}
}
