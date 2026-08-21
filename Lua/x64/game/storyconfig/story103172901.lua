return {
	Play317291001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 317291001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play317291002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "K11f"

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
				local var_4_5 = arg_1_1.bgs_.K11f

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
					if iter_4_0 ~= "K11f" then
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
			local var_4_23 = 0.6

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

			local var_4_28 = 0.733333333333333
			local var_4_29 = 1

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				local var_4_30 = "play"
				local var_4_31 = "music"

				arg_1_1:AudioAction(var_4_30, var_4_31, "bgm_activity_2_6_story_karasugo_garden", "bgm_activity_2_6_story_karasugo_garden", "bgm_activity_2_6_story_karasugo_garden.awb")

				local var_4_32 = ""
				local var_4_33 = manager.audio:GetAudioName("bgm_activity_2_6_story_karasugo_garden", "bgm_activity_2_6_story_karasugo_garden")

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
			local var_4_35 = 0.75

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

				local var_4_37 = arg_1_1:GetWordFromCfg(317291001)
				local var_4_38 = arg_1_1:FormatText(var_4_37.content)

				arg_1_1.text_.text = var_4_38

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_39 = 30
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
	Play317291002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 317291002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play317291003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0
			local var_12_1 = 0.975

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

				local var_12_2 = arg_9_1:GetWordFromCfg(317291002)
				local var_12_3 = arg_9_1:FormatText(var_12_2.content)

				arg_9_1.text_.text = var_12_3

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_4 = 39
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
	Play317291003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 317291003
		arg_13_1.duration_ = 7.1

		local var_13_0 = {
			zh = 7.1,
			ja = 5.766
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
				arg_13_0:Play317291004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0
			local var_16_1 = 0.45

			if var_16_0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_2 = arg_13_1:FormatText(StoryNameCfg[572].name)

				arg_13_1.leftNameTxt_.text = var_16_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, true)
				arg_13_1.iconController_:SetSelectedState("hero")

				arg_13_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2079")

				arg_13_1.callingController_:SetSelectedState("normal")

				arg_13_1.keyicon_.color = Color.New(1, 1, 1)
				arg_13_1.icon_.color = Color.New(1, 1, 1)

				local var_16_3 = arg_13_1:GetWordFromCfg(317291003)
				local var_16_4 = arg_13_1:FormatText(var_16_3.content)

				arg_13_1.text_.text = var_16_4

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_5 = 18
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

				if manager.audio:GetVoiceLength("story_v_out_317291", "317291003", "story_v_out_317291.awb") ~= 0 then
					local var_16_8 = manager.audio:GetVoiceLength("story_v_out_317291", "317291003", "story_v_out_317291.awb") / 1000

					if var_16_8 + var_16_0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_8 + var_16_0
					end

					if var_16_3.prefab_name ~= "" and arg_13_1.actors_[var_16_3.prefab_name] ~= nil then
						local var_16_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_3.prefab_name].transform, "story_v_out_317291", "317291003", "story_v_out_317291.awb")

						arg_13_1:RecordAudio("317291003", var_16_9)
						arg_13_1:RecordAudio("317291003", var_16_9)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_317291", "317291003", "story_v_out_317291.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_317291", "317291003", "story_v_out_317291.awb")
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
	Play317291004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 317291004
		arg_17_1.duration_ = 8.13

		local var_17_0 = {
			zh = 6.9,
			ja = 8.133
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
				arg_17_0:Play317291005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = "STblack"

			if arg_17_1.bgs_[var_20_0] == nil then
				local var_20_1 = Object.Instantiate(arg_17_1.paintGo_)

				var_20_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_20_0)
				var_20_1.name = var_20_0
				var_20_1.transform.parent = arg_17_1.stage_.transform
				var_20_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_17_1.bgs_[var_20_0] = var_20_1
			end

			local var_20_2 = 2

			if var_20_2 < arg_17_1.time_ and arg_17_1.time_ <= var_20_2 + arg_20_0 then
				local var_20_3 = manager.ui.mainCamera.transform.localPosition
				local var_20_4 = Vector3.New(0, 0, 10) + Vector3.New(var_20_3.x, var_20_3.y, 0)
				local var_20_5 = arg_17_1.bgs_.STblack

				var_20_5.transform.localPosition = var_20_4
				var_20_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_20_6 = var_20_5:GetComponent("SpriteRenderer")

				if var_20_6 and var_20_6.sprite then
					local var_20_7 = (var_20_5.transform.localPosition - var_20_3).z
					local var_20_8 = manager.ui.mainCameraCom_
					local var_20_9 = 2 * var_20_7 * Mathf.Tan(var_20_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_20_10 = var_20_9 * var_20_8.aspect
					local var_20_11 = var_20_6.sprite.bounds.size.x
					local var_20_12 = var_20_6.sprite.bounds.size.y
					local var_20_13 = var_20_10 / var_20_11
					local var_20_14 = var_20_9 / var_20_12
					local var_20_15 = var_20_14 < var_20_13 and var_20_13 or var_20_14

					var_20_5.transform.localScale = Vector3.New(var_20_15, var_20_15, 0)
				end

				for iter_20_0, iter_20_1 in pairs(arg_17_1.bgs_) do
					if iter_20_0 ~= "STblack" then
						iter_20_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_20_16 = 0

			if var_20_16 < arg_17_1.time_ and arg_17_1.time_ <= var_20_16 + arg_20_0 then
				arg_17_1.mask_.enabled = true
				arg_17_1.mask_.raycastTarget = true

				arg_17_1:SetGaussion(false)
			end

			local var_20_17 = 2

			if var_20_16 <= arg_17_1.time_ and arg_17_1.time_ < var_20_16 + var_20_17 then
				local var_20_18 = (arg_17_1.time_ - var_20_16) / var_20_17
				local var_20_19 = Color.New(0, 0, 0)

				var_20_19.a = Mathf.Lerp(0, 1, var_20_18)
				arg_17_1.mask_.color = var_20_19
			end

			if arg_17_1.time_ >= var_20_16 + var_20_17 and arg_17_1.time_ < var_20_16 + var_20_17 + arg_20_0 then
				local var_20_20 = Color.New(0, 0, 0)

				var_20_20.a = 1
				arg_17_1.mask_.color = var_20_20
			end

			local var_20_21 = 2

			if var_20_21 < arg_17_1.time_ and arg_17_1.time_ <= var_20_21 + arg_20_0 then
				arg_17_1.mask_.enabled = true
				arg_17_1.mask_.raycastTarget = true

				arg_17_1:SetGaussion(false)
			end

			local var_20_22 = 2

			if var_20_21 <= arg_17_1.time_ and arg_17_1.time_ < var_20_21 + var_20_22 then
				local var_20_23 = (arg_17_1.time_ - var_20_21) / var_20_22
				local var_20_24 = Color.New(0, 0, 0)

				var_20_24.a = Mathf.Lerp(1, 0, var_20_23)
				arg_17_1.mask_.color = var_20_24
			end

			if arg_17_1.time_ >= var_20_21 + var_20_22 and arg_17_1.time_ < var_20_21 + var_20_22 + arg_20_0 then
				local var_20_25 = Color.New(0, 0, 0)
				local var_20_26 = 0

				arg_17_1.mask_.enabled = false
				var_20_25.a = var_20_26
				arg_17_1.mask_.color = var_20_25
			end

			if arg_17_1.frameCnt_ <= 1 then
				arg_17_1.dialog_:SetActive(false)
			end

			local var_20_27 = 4
			local var_20_28 = 0.2

			if var_20_27 < arg_17_1.time_ and arg_17_1.time_ <= var_20_27 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0

				arg_17_1.dialog_:SetActive(true)

				arg_17_1.dialogCg_.alpha = 0

				local var_20_29 = LeanTween.value(arg_17_1.dialog_, 0, 1, 0.3)

				var_20_29:setOnUpdate(LuaHelper.FloatAction(function(arg_21_0)
					arg_17_1.dialogCg_.alpha = arg_21_0
				end))
				var_20_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_17_1.dialog_)
					var_20_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_17_1.duration_ = arg_17_1.duration_ + 0.3

				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_30 = arg_17_1:FormatText(StoryNameCfg[570].name)

				arg_17_1.leftNameTxt_.text = var_20_30

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, true)
				arg_17_1.iconController_:SetSelectedState("hero")

				arg_17_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2094")

				arg_17_1.callingController_:SetSelectedState("normal")

				arg_17_1.keyicon_.color = Color.New(1, 1, 1)
				arg_17_1.icon_.color = Color.New(1, 1, 1)

				local var_20_31 = arg_17_1:GetWordFromCfg(317291004)
				local var_20_32 = arg_17_1:FormatText(var_20_31.content)

				arg_17_1.text_.text = var_20_32

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_33 = 8
				local var_20_34 = utf8.len(var_20_32)
				local var_20_35 = var_20_33 <= 0 and var_20_28 or var_20_28 * (var_20_34 / var_20_33)

				if var_20_35 > 0 and var_20_28 < var_20_35 then
					arg_17_1.talkMaxDuration = var_20_35
					var_20_27 = var_20_27 + 0.3

					if var_20_35 + var_20_27 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_35 + var_20_27
					end
				end

				arg_17_1.text_.text = var_20_32
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317291", "317291004", "story_v_out_317291.awb") ~= 0 then
					local var_20_36 = manager.audio:GetVoiceLength("story_v_out_317291", "317291004", "story_v_out_317291.awb") / 1000

					if var_20_36 + var_20_27 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_36 + var_20_27
					end

					if var_20_31.prefab_name ~= "" and arg_17_1.actors_[var_20_31.prefab_name] ~= nil then
						local var_20_37 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_31.prefab_name].transform, "story_v_out_317291", "317291004", "story_v_out_317291.awb")

						arg_17_1:RecordAudio("317291004", var_20_37)
						arg_17_1:RecordAudio("317291004", var_20_37)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_317291", "317291004", "story_v_out_317291.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_317291", "317291004", "story_v_out_317291.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_38 = var_20_27 + 0.3
			local var_20_39 = math.max(var_20_28, arg_17_1.talkMaxDuration)

			if var_20_38 <= arg_17_1.time_ and arg_17_1.time_ < var_20_38 + var_20_39 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_38) / var_20_39

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_38 + var_20_39 and arg_17_1.time_ < var_20_38 + var_20_39 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play317291005 = function(arg_23_0, arg_23_1)
		arg_23_1.time_ = 0
		arg_23_1.frameCnt_ = 0
		arg_23_1.state_ = "playing"
		arg_23_1.curTalkId_ = 317291005
		arg_23_1.duration_ = 10

		local var_23_0 = {
			zh = 9.533,
			ja = 10
		}
		local var_23_1 = manager.audio:GetLocalizationFlag()

		if var_23_0[var_23_1] ~= nil then
			arg_23_1.duration_ = var_23_0[var_23_1]
		end

		SetActive(arg_23_1.tipsGo_, false)

		function arg_23_1.onSingleLineFinish_()
			arg_23_1.onSingleLineUpdate_ = nil
			arg_23_1.onSingleLineFinish_ = nil
			arg_23_1.state_ = "waiting"
		end

		function arg_23_1.playNext_(arg_25_0)
			if arg_25_0 == 1 then
				arg_23_0:Play317291006(arg_23_1)
			end
		end

		function arg_23_1.onSingleLineUpdate_(arg_26_0)
			local var_26_0 = 0

			if var_26_0 < arg_23_1.time_ and arg_23_1.time_ <= var_26_0 + arg_26_0 then
				local var_26_1 = manager.ui.mainCamera.transform.localPosition
				local var_26_2 = Vector3.New(0, 0, 10) + Vector3.New(var_26_1.x, var_26_1.y, 0)
				local var_26_3 = arg_23_1.bgs_.K11f

				var_26_3.transform.localPosition = var_26_2
				var_26_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_26_4 = var_26_3:GetComponent("SpriteRenderer")

				if var_26_4 and var_26_4.sprite then
					local var_26_5 = (var_26_3.transform.localPosition - var_26_1).z
					local var_26_6 = manager.ui.mainCameraCom_
					local var_26_7 = 2 * var_26_5 * Mathf.Tan(var_26_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_26_8 = var_26_7 * var_26_6.aspect
					local var_26_9 = var_26_4.sprite.bounds.size.x
					local var_26_10 = var_26_4.sprite.bounds.size.y
					local var_26_11 = var_26_8 / var_26_9
					local var_26_12 = var_26_7 / var_26_10
					local var_26_13 = var_26_12 < var_26_11 and var_26_11 or var_26_12

					var_26_3.transform.localScale = Vector3.New(var_26_13, var_26_13, 0)
				end

				for iter_26_0, iter_26_1 in pairs(arg_23_1.bgs_) do
					if iter_26_0 ~= "K11f" then
						iter_26_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_26_14 = 0

			if var_26_14 < arg_23_1.time_ and arg_23_1.time_ <= var_26_14 + arg_26_0 then
				arg_23_1.mask_.enabled = true
				arg_23_1.mask_.raycastTarget = true

				arg_23_1:SetGaussion(false)
			end

			local var_26_15 = 2

			if var_26_14 <= arg_23_1.time_ and arg_23_1.time_ < var_26_14 + var_26_15 then
				local var_26_16 = (arg_23_1.time_ - var_26_14) / var_26_15
				local var_26_17 = Color.New(0, 0, 0)

				var_26_17.a = Mathf.Lerp(1, 0, var_26_16)
				arg_23_1.mask_.color = var_26_17
			end

			if arg_23_1.time_ >= var_26_14 + var_26_15 and arg_23_1.time_ < var_26_14 + var_26_15 + arg_26_0 then
				local var_26_18 = Color.New(0, 0, 0)
				local var_26_19 = 0

				arg_23_1.mask_.enabled = false
				var_26_18.a = var_26_19
				arg_23_1.mask_.color = var_26_18
			end

			if arg_23_1.frameCnt_ <= 1 then
				arg_23_1.dialog_:SetActive(false)
			end

			local var_26_20 = 2
			local var_26_21 = 0.475

			if var_26_20 < arg_23_1.time_ and arg_23_1.time_ <= var_26_20 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0

				arg_23_1.dialog_:SetActive(true)

				arg_23_1.dialogCg_.alpha = 0

				local var_26_22 = LeanTween.value(arg_23_1.dialog_, 0, 1, 0.3)

				var_26_22:setOnUpdate(LuaHelper.FloatAction(function(arg_27_0)
					arg_23_1.dialogCg_.alpha = arg_27_0
				end))
				var_26_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_23_1.dialog_)
					var_26_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_23_1.duration_ = arg_23_1.duration_ + 0.3

				SetActive(arg_23_1.leftNameGo_, true)

				local var_26_23 = arg_23_1:FormatText(StoryNameCfg[572].name)

				arg_23_1.leftNameTxt_.text = var_26_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_23_1.leftNameTxt_.transform)

				arg_23_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_23_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_23_1:RecordName(arg_23_1.leftNameTxt_.text)
				SetActive(arg_23_1.iconTrs_.gameObject, true)
				arg_23_1.iconController_:SetSelectedState("hero")

				arg_23_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2079")

				arg_23_1.callingController_:SetSelectedState("normal")

				arg_23_1.keyicon_.color = Color.New(1, 1, 1)
				arg_23_1.icon_.color = Color.New(1, 1, 1)

				local var_26_24 = arg_23_1:GetWordFromCfg(317291005)
				local var_26_25 = arg_23_1:FormatText(var_26_24.content)

				arg_23_1.text_.text = var_26_25

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_26 = 19
				local var_26_27 = utf8.len(var_26_25)
				local var_26_28 = var_26_26 <= 0 and var_26_21 or var_26_21 * (var_26_27 / var_26_26)

				if var_26_28 > 0 and var_26_21 < var_26_28 then
					arg_23_1.talkMaxDuration = var_26_28
					var_26_20 = var_26_20 + 0.3

					if var_26_28 + var_26_20 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_28 + var_26_20
					end
				end

				arg_23_1.text_.text = var_26_25
				arg_23_1.typewritter.percent = 0

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317291", "317291005", "story_v_out_317291.awb") ~= 0 then
					local var_26_29 = manager.audio:GetVoiceLength("story_v_out_317291", "317291005", "story_v_out_317291.awb") / 1000

					if var_26_29 + var_26_20 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_29 + var_26_20
					end

					if var_26_24.prefab_name ~= "" and arg_23_1.actors_[var_26_24.prefab_name] ~= nil then
						local var_26_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_23_1.actors_[var_26_24.prefab_name].transform, "story_v_out_317291", "317291005", "story_v_out_317291.awb")

						arg_23_1:RecordAudio("317291005", var_26_30)
						arg_23_1:RecordAudio("317291005", var_26_30)
					else
						arg_23_1:AudioAction("play", "voice", "story_v_out_317291", "317291005", "story_v_out_317291.awb")
					end

					arg_23_1:RecordHistoryTalkVoice("story_v_out_317291", "317291005", "story_v_out_317291.awb")
				end

				arg_23_1:RecordContent(arg_23_1.text_.text)
			end

			local var_26_31 = var_26_20 + 0.3
			local var_26_32 = math.max(var_26_21, arg_23_1.talkMaxDuration)

			if var_26_31 <= arg_23_1.time_ and arg_23_1.time_ < var_26_31 + var_26_32 then
				arg_23_1.typewritter.percent = (arg_23_1.time_ - var_26_31) / var_26_32

				arg_23_1.typewritter:SetDirty()
			end

			if arg_23_1.time_ >= var_26_31 + var_26_32 and arg_23_1.time_ < var_26_31 + var_26_32 + arg_26_0 then
				arg_23_1.typewritter.percent = 1

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(true)
			end
		end

		arg_23_1.nodeConfigList_ = {}

		arg_23_1:InitPlayNodeList()
	end,
	Play317291006 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 317291006
		arg_29_1.duration_ = 9.5

		local var_29_0 = {
			zh = 7.2,
			ja = 9.5
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
				arg_29_0:Play317291007(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 2

			if var_32_0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_0 + arg_32_0 then
				local var_32_1 = manager.ui.mainCamera.transform.localPosition
				local var_32_2 = Vector3.New(0, 0, 10) + Vector3.New(var_32_1.x, var_32_1.y, 0)
				local var_32_3 = arg_29_1.bgs_.STblack

				var_32_3.transform.localPosition = var_32_2
				var_32_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_32_4 = var_32_3:GetComponent("SpriteRenderer")

				if var_32_4 and var_32_4.sprite then
					local var_32_5 = (var_32_3.transform.localPosition - var_32_1).z
					local var_32_6 = manager.ui.mainCameraCom_
					local var_32_7 = 2 * var_32_5 * Mathf.Tan(var_32_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_32_8 = var_32_7 * var_32_6.aspect
					local var_32_9 = var_32_4.sprite.bounds.size.x
					local var_32_10 = var_32_4.sprite.bounds.size.y
					local var_32_11 = var_32_8 / var_32_9
					local var_32_12 = var_32_7 / var_32_10
					local var_32_13 = var_32_12 < var_32_11 and var_32_11 or var_32_12

					var_32_3.transform.localScale = Vector3.New(var_32_13, var_32_13, 0)
				end

				for iter_32_0, iter_32_1 in pairs(arg_29_1.bgs_) do
					if iter_32_0 ~= "STblack" then
						iter_32_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_32_14 = 0

			if var_32_14 < arg_29_1.time_ and arg_29_1.time_ <= var_32_14 + arg_32_0 then
				arg_29_1.mask_.enabled = true
				arg_29_1.mask_.raycastTarget = true

				arg_29_1:SetGaussion(false)
			end

			local var_32_15 = 2

			if var_32_14 <= arg_29_1.time_ and arg_29_1.time_ < var_32_14 + var_32_15 then
				local var_32_16 = (arg_29_1.time_ - var_32_14) / var_32_15
				local var_32_17 = Color.New(0, 0, 0)

				var_32_17.a = Mathf.Lerp(0, 1, var_32_16)
				arg_29_1.mask_.color = var_32_17
			end

			if arg_29_1.time_ >= var_32_14 + var_32_15 and arg_29_1.time_ < var_32_14 + var_32_15 + arg_32_0 then
				local var_32_18 = Color.New(0, 0, 0)

				var_32_18.a = 1
				arg_29_1.mask_.color = var_32_18
			end

			local var_32_19 = 2

			if var_32_19 < arg_29_1.time_ and arg_29_1.time_ <= var_32_19 + arg_32_0 then
				arg_29_1.mask_.enabled = true
				arg_29_1.mask_.raycastTarget = true

				arg_29_1:SetGaussion(false)
			end

			local var_32_20 = 2

			if var_32_19 <= arg_29_1.time_ and arg_29_1.time_ < var_32_19 + var_32_20 then
				local var_32_21 = (arg_29_1.time_ - var_32_19) / var_32_20
				local var_32_22 = Color.New(0, 0, 0)

				var_32_22.a = Mathf.Lerp(1, 0, var_32_21)
				arg_29_1.mask_.color = var_32_22
			end

			if arg_29_1.time_ >= var_32_19 + var_32_20 and arg_29_1.time_ < var_32_19 + var_32_20 + arg_32_0 then
				local var_32_23 = Color.New(0, 0, 0)
				local var_32_24 = 0

				arg_29_1.mask_.enabled = false
				var_32_23.a = var_32_24
				arg_29_1.mask_.color = var_32_23
			end

			if arg_29_1.frameCnt_ <= 1 then
				arg_29_1.dialog_:SetActive(false)
			end

			local var_32_25 = 4
			local var_32_26 = 0.25

			if var_32_25 < arg_29_1.time_ and arg_29_1.time_ <= var_32_25 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0

				arg_29_1.dialog_:SetActive(true)

				arg_29_1.dialogCg_.alpha = 0

				local var_32_27 = LeanTween.value(arg_29_1.dialog_, 0, 1, 0.3)

				var_32_27:setOnUpdate(LuaHelper.FloatAction(function(arg_33_0)
					arg_29_1.dialogCg_.alpha = arg_33_0
				end))
				var_32_27:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_29_1.dialog_)
					var_32_27:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_29_1.duration_ = arg_29_1.duration_ + 0.3

				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_28 = arg_29_1:FormatText(StoryNameCfg[570].name)

				arg_29_1.leftNameTxt_.text = var_32_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, true)
				arg_29_1.iconController_:SetSelectedState("hero")

				arg_29_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2094")

				arg_29_1.callingController_:SetSelectedState("normal")

				arg_29_1.keyicon_.color = Color.New(1, 1, 1)
				arg_29_1.icon_.color = Color.New(1, 1, 1)

				local var_32_29 = arg_29_1:GetWordFromCfg(317291006)
				local var_32_30 = arg_29_1:FormatText(var_32_29.content)

				arg_29_1.text_.text = var_32_30

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_31 = 10
				local var_32_32 = utf8.len(var_32_30)
				local var_32_33 = var_32_31 <= 0 and var_32_26 or var_32_26 * (var_32_32 / var_32_31)

				if var_32_33 > 0 and var_32_26 < var_32_33 then
					arg_29_1.talkMaxDuration = var_32_33
					var_32_25 = var_32_25 + 0.3

					if var_32_33 + var_32_25 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_33 + var_32_25
					end
				end

				arg_29_1.text_.text = var_32_30
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317291", "317291006", "story_v_out_317291.awb") ~= 0 then
					local var_32_34 = manager.audio:GetVoiceLength("story_v_out_317291", "317291006", "story_v_out_317291.awb") / 1000

					if var_32_34 + var_32_25 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_34 + var_32_25
					end

					if var_32_29.prefab_name ~= "" and arg_29_1.actors_[var_32_29.prefab_name] ~= nil then
						local var_32_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_29.prefab_name].transform, "story_v_out_317291", "317291006", "story_v_out_317291.awb")

						arg_29_1:RecordAudio("317291006", var_32_35)
						arg_29_1:RecordAudio("317291006", var_32_35)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_317291", "317291006", "story_v_out_317291.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_317291", "317291006", "story_v_out_317291.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_36 = var_32_25 + 0.3
			local var_32_37 = math.max(var_32_26, arg_29_1.talkMaxDuration)

			if var_32_36 <= arg_29_1.time_ and arg_29_1.time_ < var_32_36 + var_32_37 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_36) / var_32_37

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_36 + var_32_37 and arg_29_1.time_ < var_32_36 + var_32_37 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play317291007 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 317291007
		arg_35_1.duration_ = 11.67

		local var_35_0 = {
			zh = 11.666,
			ja = 9.866
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
				arg_35_0:Play317291008(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			local var_38_0 = 0

			if var_38_0 < arg_35_1.time_ and arg_35_1.time_ <= var_38_0 + arg_38_0 then
				local var_38_1 = manager.ui.mainCamera.transform.localPosition
				local var_38_2 = Vector3.New(0, 0, 10) + Vector3.New(var_38_1.x, var_38_1.y, 0)
				local var_38_3 = arg_35_1.bgs_.K11f

				var_38_3.transform.localPosition = var_38_2
				var_38_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_38_4 = var_38_3:GetComponent("SpriteRenderer")

				if var_38_4 and var_38_4.sprite then
					local var_38_5 = (var_38_3.transform.localPosition - var_38_1).z
					local var_38_6 = manager.ui.mainCameraCom_
					local var_38_7 = 2 * var_38_5 * Mathf.Tan(var_38_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_38_8 = var_38_7 * var_38_6.aspect
					local var_38_9 = var_38_4.sprite.bounds.size.x
					local var_38_10 = var_38_4.sprite.bounds.size.y
					local var_38_11 = var_38_8 / var_38_9
					local var_38_12 = var_38_7 / var_38_10
					local var_38_13 = var_38_12 < var_38_11 and var_38_11 or var_38_12

					var_38_3.transform.localScale = Vector3.New(var_38_13, var_38_13, 0)
				end

				for iter_38_0, iter_38_1 in pairs(arg_35_1.bgs_) do
					if iter_38_0 ~= "K11f" then
						iter_38_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_38_14 = 0

			if var_38_14 < arg_35_1.time_ and arg_35_1.time_ <= var_38_14 + arg_38_0 then
				arg_35_1.mask_.enabled = true
				arg_35_1.mask_.raycastTarget = true

				arg_35_1:SetGaussion(false)
			end

			local var_38_15 = 2

			if var_38_14 <= arg_35_1.time_ and arg_35_1.time_ < var_38_14 + var_38_15 then
				local var_38_16 = (arg_35_1.time_ - var_38_14) / var_38_15
				local var_38_17 = Color.New(0, 0, 0)

				var_38_17.a = Mathf.Lerp(1, 0, var_38_16)
				arg_35_1.mask_.color = var_38_17
			end

			if arg_35_1.time_ >= var_38_14 + var_38_15 and arg_35_1.time_ < var_38_14 + var_38_15 + arg_38_0 then
				local var_38_18 = Color.New(0, 0, 0)
				local var_38_19 = 0

				arg_35_1.mask_.enabled = false
				var_38_18.a = var_38_19
				arg_35_1.mask_.color = var_38_18
			end

			if arg_35_1.frameCnt_ <= 1 then
				arg_35_1.dialog_:SetActive(false)
			end

			local var_38_20 = 2
			local var_38_21 = 0.475

			if var_38_20 < arg_35_1.time_ and arg_35_1.time_ <= var_38_20 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0

				arg_35_1.dialog_:SetActive(true)

				arg_35_1.dialogCg_.alpha = 0

				local var_38_22 = LeanTween.value(arg_35_1.dialog_, 0, 1, 0.3)

				var_38_22:setOnUpdate(LuaHelper.FloatAction(function(arg_39_0)
					arg_35_1.dialogCg_.alpha = arg_39_0
				end))
				var_38_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_35_1.dialog_)
					var_38_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_35_1.duration_ = arg_35_1.duration_ + 0.3

				SetActive(arg_35_1.leftNameGo_, true)

				local var_38_23 = arg_35_1:FormatText(StoryNameCfg[572].name)

				arg_35_1.leftNameTxt_.text = var_38_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_35_1.leftNameTxt_.transform)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1.leftNameTxt_.text)
				SetActive(arg_35_1.iconTrs_.gameObject, true)
				arg_35_1.iconController_:SetSelectedState("hero")

				arg_35_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2079")

				arg_35_1.callingController_:SetSelectedState("normal")

				arg_35_1.keyicon_.color = Color.New(1, 1, 1)
				arg_35_1.icon_.color = Color.New(1, 1, 1)

				local var_38_24 = arg_35_1:GetWordFromCfg(317291007)
				local var_38_25 = arg_35_1:FormatText(var_38_24.content)

				arg_35_1.text_.text = var_38_25

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_26 = 19
				local var_38_27 = utf8.len(var_38_25)
				local var_38_28 = var_38_26 <= 0 and var_38_21 or var_38_21 * (var_38_27 / var_38_26)

				if var_38_28 > 0 and var_38_21 < var_38_28 then
					arg_35_1.talkMaxDuration = var_38_28
					var_38_20 = var_38_20 + 0.3

					if var_38_28 + var_38_20 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_28 + var_38_20
					end
				end

				arg_35_1.text_.text = var_38_25
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317291", "317291007", "story_v_out_317291.awb") ~= 0 then
					local var_38_29 = manager.audio:GetVoiceLength("story_v_out_317291", "317291007", "story_v_out_317291.awb") / 1000

					if var_38_29 + var_38_20 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_29 + var_38_20
					end

					if var_38_24.prefab_name ~= "" and arg_35_1.actors_[var_38_24.prefab_name] ~= nil then
						local var_38_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_35_1.actors_[var_38_24.prefab_name].transform, "story_v_out_317291", "317291007", "story_v_out_317291.awb")

						arg_35_1:RecordAudio("317291007", var_38_30)
						arg_35_1:RecordAudio("317291007", var_38_30)
					else
						arg_35_1:AudioAction("play", "voice", "story_v_out_317291", "317291007", "story_v_out_317291.awb")
					end

					arg_35_1:RecordHistoryTalkVoice("story_v_out_317291", "317291007", "story_v_out_317291.awb")
				end

				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_31 = var_38_20 + 0.3
			local var_38_32 = math.max(var_38_21, arg_35_1.talkMaxDuration)

			if var_38_31 <= arg_35_1.time_ and arg_35_1.time_ < var_38_31 + var_38_32 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - var_38_31) / var_38_32

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= var_38_31 + var_38_32 and arg_35_1.time_ < var_38_31 + var_38_32 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {}

		arg_35_1:InitPlayNodeList()
	end,
	Play317291008 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 317291008
		arg_41_1.duration_ = 8.77

		local var_41_0 = {
			zh = 6.333,
			ja = 8.76599999999999
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
				arg_41_0:Play317291009(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = 2

			if var_44_0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_0 + arg_44_0 then
				local var_44_1 = manager.ui.mainCamera.transform.localPosition
				local var_44_2 = Vector3.New(0, 0, 10) + Vector3.New(var_44_1.x, var_44_1.y, 0)
				local var_44_3 = arg_41_1.bgs_.STblack

				var_44_3.transform.localPosition = var_44_2
				var_44_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_44_4 = var_44_3:GetComponent("SpriteRenderer")

				if var_44_4 and var_44_4.sprite then
					local var_44_5 = (var_44_3.transform.localPosition - var_44_1).z
					local var_44_6 = manager.ui.mainCameraCom_
					local var_44_7 = 2 * var_44_5 * Mathf.Tan(var_44_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_44_8 = var_44_7 * var_44_6.aspect
					local var_44_9 = var_44_4.sprite.bounds.size.x
					local var_44_10 = var_44_4.sprite.bounds.size.y
					local var_44_11 = var_44_8 / var_44_9
					local var_44_12 = var_44_7 / var_44_10
					local var_44_13 = var_44_12 < var_44_11 and var_44_11 or var_44_12

					var_44_3.transform.localScale = Vector3.New(var_44_13, var_44_13, 0)
				end

				for iter_44_0, iter_44_1 in pairs(arg_41_1.bgs_) do
					if iter_44_0 ~= "STblack" then
						iter_44_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_44_14 = 0

			if var_44_14 < arg_41_1.time_ and arg_41_1.time_ <= var_44_14 + arg_44_0 then
				arg_41_1.mask_.enabled = true
				arg_41_1.mask_.raycastTarget = true

				arg_41_1:SetGaussion(false)
			end

			local var_44_15 = 2

			if var_44_14 <= arg_41_1.time_ and arg_41_1.time_ < var_44_14 + var_44_15 then
				local var_44_16 = (arg_41_1.time_ - var_44_14) / var_44_15
				local var_44_17 = Color.New(0, 0, 0)

				var_44_17.a = Mathf.Lerp(0, 1, var_44_16)
				arg_41_1.mask_.color = var_44_17
			end

			if arg_41_1.time_ >= var_44_14 + var_44_15 and arg_41_1.time_ < var_44_14 + var_44_15 + arg_44_0 then
				local var_44_18 = Color.New(0, 0, 0)

				var_44_18.a = 1
				arg_41_1.mask_.color = var_44_18
			end

			local var_44_19 = 2

			if var_44_19 < arg_41_1.time_ and arg_41_1.time_ <= var_44_19 + arg_44_0 then
				arg_41_1.mask_.enabled = true
				arg_41_1.mask_.raycastTarget = true

				arg_41_1:SetGaussion(false)
			end

			local var_44_20 = 2

			if var_44_19 <= arg_41_1.time_ and arg_41_1.time_ < var_44_19 + var_44_20 then
				local var_44_21 = (arg_41_1.time_ - var_44_19) / var_44_20
				local var_44_22 = Color.New(0, 0, 0)

				var_44_22.a = Mathf.Lerp(1, 0, var_44_21)
				arg_41_1.mask_.color = var_44_22
			end

			if arg_41_1.time_ >= var_44_19 + var_44_20 and arg_41_1.time_ < var_44_19 + var_44_20 + arg_44_0 then
				local var_44_23 = Color.New(0, 0, 0)
				local var_44_24 = 0

				arg_41_1.mask_.enabled = false
				var_44_23.a = var_44_24
				arg_41_1.mask_.color = var_44_23
			end

			if arg_41_1.frameCnt_ <= 1 then
				arg_41_1.dialog_:SetActive(false)
			end

			local var_44_25 = 4
			local var_44_26 = 0.2

			if var_44_25 < arg_41_1.time_ and arg_41_1.time_ <= var_44_25 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0

				arg_41_1.dialog_:SetActive(true)

				arg_41_1.dialogCg_.alpha = 0

				local var_44_27 = LeanTween.value(arg_41_1.dialog_, 0, 1, 0.3)

				var_44_27:setOnUpdate(LuaHelper.FloatAction(function(arg_45_0)
					arg_41_1.dialogCg_.alpha = arg_45_0
				end))
				var_44_27:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_41_1.dialog_)
					var_44_27:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_41_1.duration_ = arg_41_1.duration_ + 0.3

				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_28 = arg_41_1:FormatText(StoryNameCfg[570].name)

				arg_41_1.leftNameTxt_.text = var_44_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, true)
				arg_41_1.iconController_:SetSelectedState("hero")

				arg_41_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2094")

				arg_41_1.callingController_:SetSelectedState("normal")

				arg_41_1.keyicon_.color = Color.New(1, 1, 1)
				arg_41_1.icon_.color = Color.New(1, 1, 1)

				local var_44_29 = arg_41_1:GetWordFromCfg(317291008)
				local var_44_30 = arg_41_1:FormatText(var_44_29.content)

				arg_41_1.text_.text = var_44_30

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_31 = 8
				local var_44_32 = utf8.len(var_44_30)
				local var_44_33 = var_44_31 <= 0 and var_44_26 or var_44_26 * (var_44_32 / var_44_31)

				if var_44_33 > 0 and var_44_26 < var_44_33 then
					arg_41_1.talkMaxDuration = var_44_33
					var_44_25 = var_44_25 + 0.3

					if var_44_33 + var_44_25 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_33 + var_44_25
					end
				end

				arg_41_1.text_.text = var_44_30
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317291", "317291008", "story_v_out_317291.awb") ~= 0 then
					local var_44_34 = manager.audio:GetVoiceLength("story_v_out_317291", "317291008", "story_v_out_317291.awb") / 1000

					if var_44_34 + var_44_25 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_34 + var_44_25
					end

					if var_44_29.prefab_name ~= "" and arg_41_1.actors_[var_44_29.prefab_name] ~= nil then
						local var_44_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_29.prefab_name].transform, "story_v_out_317291", "317291008", "story_v_out_317291.awb")

						arg_41_1:RecordAudio("317291008", var_44_35)
						arg_41_1:RecordAudio("317291008", var_44_35)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_317291", "317291008", "story_v_out_317291.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_317291", "317291008", "story_v_out_317291.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_36 = var_44_25 + 0.3
			local var_44_37 = math.max(var_44_26, arg_41_1.talkMaxDuration)

			if var_44_36 <= arg_41_1.time_ and arg_41_1.time_ < var_44_36 + var_44_37 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_36) / var_44_37

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_36 + var_44_37 and arg_41_1.time_ < var_44_36 + var_44_37 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play317291009 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 317291009
		arg_47_1.duration_ = 5.77

		local var_47_0 = {
			zh = 5.766,
			ja = 2.666
		}
		local var_47_1 = manager.audio:GetLocalizationFlag()

		if var_47_0[var_47_1] ~= nil then
			arg_47_1.duration_ = var_47_0[var_47_1]
		end

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play317291010(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			local var_50_0 = 0

			if var_50_0 < arg_47_1.time_ and arg_47_1.time_ <= var_50_0 + arg_50_0 then
				local var_50_1 = manager.ui.mainCamera.transform.localPosition
				local var_50_2 = Vector3.New(0, 0, 10) + Vector3.New(var_50_1.x, var_50_1.y, 0)
				local var_50_3 = arg_47_1.bgs_.K11f

				var_50_3.transform.localPosition = var_50_2
				var_50_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_50_4 = var_50_3:GetComponent("SpriteRenderer")

				if var_50_4 and var_50_4.sprite then
					local var_50_5 = (var_50_3.transform.localPosition - var_50_1).z
					local var_50_6 = manager.ui.mainCameraCom_
					local var_50_7 = 2 * var_50_5 * Mathf.Tan(var_50_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_50_8 = var_50_7 * var_50_6.aspect
					local var_50_9 = var_50_4.sprite.bounds.size.x
					local var_50_10 = var_50_4.sprite.bounds.size.y
					local var_50_11 = var_50_8 / var_50_9
					local var_50_12 = var_50_7 / var_50_10
					local var_50_13 = var_50_12 < var_50_11 and var_50_11 or var_50_12

					var_50_3.transform.localScale = Vector3.New(var_50_13, var_50_13, 0)
				end

				for iter_50_0, iter_50_1 in pairs(arg_47_1.bgs_) do
					if iter_50_0 ~= "K11f" then
						iter_50_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_50_14 = 0

			if var_50_14 < arg_47_1.time_ and arg_47_1.time_ <= var_50_14 + arg_50_0 then
				arg_47_1.mask_.enabled = true
				arg_47_1.mask_.raycastTarget = true

				arg_47_1:SetGaussion(false)
			end

			local var_50_15 = 2

			if var_50_14 <= arg_47_1.time_ and arg_47_1.time_ < var_50_14 + var_50_15 then
				local var_50_16 = (arg_47_1.time_ - var_50_14) / var_50_15
				local var_50_17 = Color.New(0, 0, 0)

				var_50_17.a = Mathf.Lerp(1, 0, var_50_16)
				arg_47_1.mask_.color = var_50_17
			end

			if arg_47_1.time_ >= var_50_14 + var_50_15 and arg_47_1.time_ < var_50_14 + var_50_15 + arg_50_0 then
				local var_50_18 = Color.New(0, 0, 0)
				local var_50_19 = 0

				arg_47_1.mask_.enabled = false
				var_50_18.a = var_50_19
				arg_47_1.mask_.color = var_50_18
			end

			if arg_47_1.frameCnt_ <= 1 then
				arg_47_1.dialog_:SetActive(false)
			end

			local var_50_20 = 2
			local var_50_21 = 0.075

			if var_50_20 < arg_47_1.time_ and arg_47_1.time_ <= var_50_20 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0

				arg_47_1.dialog_:SetActive(true)

				arg_47_1.dialogCg_.alpha = 0

				local var_50_22 = LeanTween.value(arg_47_1.dialog_, 0, 1, 0.3)

				var_50_22:setOnUpdate(LuaHelper.FloatAction(function(arg_51_0)
					arg_47_1.dialogCg_.alpha = arg_51_0
				end))
				var_50_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_47_1.dialog_)
					var_50_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_47_1.duration_ = arg_47_1.duration_ + 0.3

				SetActive(arg_47_1.leftNameGo_, true)

				local var_50_23 = arg_47_1:FormatText(StoryNameCfg[572].name)

				arg_47_1.leftNameTxt_.text = var_50_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, true)
				arg_47_1.iconController_:SetSelectedState("hero")

				arg_47_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2079")

				arg_47_1.callingController_:SetSelectedState("normal")

				arg_47_1.keyicon_.color = Color.New(1, 1, 1)
				arg_47_1.icon_.color = Color.New(1, 1, 1)

				local var_50_24 = arg_47_1:GetWordFromCfg(317291009)
				local var_50_25 = arg_47_1:FormatText(var_50_24.content)

				arg_47_1.text_.text = var_50_25

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_26 = 3
				local var_50_27 = utf8.len(var_50_25)
				local var_50_28 = var_50_26 <= 0 and var_50_21 or var_50_21 * (var_50_27 / var_50_26)

				if var_50_28 > 0 and var_50_21 < var_50_28 then
					arg_47_1.talkMaxDuration = var_50_28
					var_50_20 = var_50_20 + 0.3

					if var_50_28 + var_50_20 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_28 + var_50_20
					end
				end

				arg_47_1.text_.text = var_50_25
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317291", "317291009", "story_v_out_317291.awb") ~= 0 then
					local var_50_29 = manager.audio:GetVoiceLength("story_v_out_317291", "317291009", "story_v_out_317291.awb") / 1000

					if var_50_29 + var_50_20 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_29 + var_50_20
					end

					if var_50_24.prefab_name ~= "" and arg_47_1.actors_[var_50_24.prefab_name] ~= nil then
						local var_50_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_47_1.actors_[var_50_24.prefab_name].transform, "story_v_out_317291", "317291009", "story_v_out_317291.awb")

						arg_47_1:RecordAudio("317291009", var_50_30)
						arg_47_1:RecordAudio("317291009", var_50_30)
					else
						arg_47_1:AudioAction("play", "voice", "story_v_out_317291", "317291009", "story_v_out_317291.awb")
					end

					arg_47_1:RecordHistoryTalkVoice("story_v_out_317291", "317291009", "story_v_out_317291.awb")
				end

				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_31 = var_50_20 + 0.3
			local var_50_32 = math.max(var_50_21, arg_47_1.talkMaxDuration)

			if var_50_31 <= arg_47_1.time_ and arg_47_1.time_ < var_50_31 + var_50_32 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_31) / var_50_32

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_31 + var_50_32 and arg_47_1.time_ < var_50_31 + var_50_32 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {}

		arg_47_1:InitPlayNodeList()
	end,
	Play317291010 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 317291010
		arg_53_1.duration_ = 10.23

		local var_53_0 = {
			zh = 5.6,
			ja = 10.233
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
				arg_53_0:Play317291011(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 2

			if var_56_0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_0 + arg_56_0 then
				local var_56_1 = manager.ui.mainCamera.transform.localPosition
				local var_56_2 = Vector3.New(0, 0, 10) + Vector3.New(var_56_1.x, var_56_1.y, 0)
				local var_56_3 = arg_53_1.bgs_.STblack

				var_56_3.transform.localPosition = var_56_2
				var_56_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_56_4 = var_56_3:GetComponent("SpriteRenderer")

				if var_56_4 and var_56_4.sprite then
					local var_56_5 = (var_56_3.transform.localPosition - var_56_1).z
					local var_56_6 = manager.ui.mainCameraCom_
					local var_56_7 = 2 * var_56_5 * Mathf.Tan(var_56_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_56_8 = var_56_7 * var_56_6.aspect
					local var_56_9 = var_56_4.sprite.bounds.size.x
					local var_56_10 = var_56_4.sprite.bounds.size.y
					local var_56_11 = var_56_8 / var_56_9
					local var_56_12 = var_56_7 / var_56_10
					local var_56_13 = var_56_12 < var_56_11 and var_56_11 or var_56_12

					var_56_3.transform.localScale = Vector3.New(var_56_13, var_56_13, 0)
				end

				for iter_56_0, iter_56_1 in pairs(arg_53_1.bgs_) do
					if iter_56_0 ~= "STblack" then
						iter_56_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_56_14 = 0

			if var_56_14 < arg_53_1.time_ and arg_53_1.time_ <= var_56_14 + arg_56_0 then
				arg_53_1.mask_.enabled = true
				arg_53_1.mask_.raycastTarget = true

				arg_53_1:SetGaussion(false)
			end

			local var_56_15 = 2

			if var_56_14 <= arg_53_1.time_ and arg_53_1.time_ < var_56_14 + var_56_15 then
				local var_56_16 = (arg_53_1.time_ - var_56_14) / var_56_15
				local var_56_17 = Color.New(0, 0, 0)

				var_56_17.a = Mathf.Lerp(0, 1, var_56_16)
				arg_53_1.mask_.color = var_56_17
			end

			if arg_53_1.time_ >= var_56_14 + var_56_15 and arg_53_1.time_ < var_56_14 + var_56_15 + arg_56_0 then
				local var_56_18 = Color.New(0, 0, 0)

				var_56_18.a = 1
				arg_53_1.mask_.color = var_56_18
			end

			local var_56_19 = 2

			if var_56_19 < arg_53_1.time_ and arg_53_1.time_ <= var_56_19 + arg_56_0 then
				arg_53_1.mask_.enabled = true
				arg_53_1.mask_.raycastTarget = true

				arg_53_1:SetGaussion(false)
			end

			local var_56_20 = 2

			if var_56_19 <= arg_53_1.time_ and arg_53_1.time_ < var_56_19 + var_56_20 then
				local var_56_21 = (arg_53_1.time_ - var_56_19) / var_56_20
				local var_56_22 = Color.New(0, 0, 0)

				var_56_22.a = Mathf.Lerp(1, 0, var_56_21)
				arg_53_1.mask_.color = var_56_22
			end

			if arg_53_1.time_ >= var_56_19 + var_56_20 and arg_53_1.time_ < var_56_19 + var_56_20 + arg_56_0 then
				local var_56_23 = Color.New(0, 0, 0)
				local var_56_24 = 0

				arg_53_1.mask_.enabled = false
				var_56_23.a = var_56_24
				arg_53_1.mask_.color = var_56_23
			end

			if arg_53_1.frameCnt_ <= 1 then
				arg_53_1.dialog_:SetActive(false)
			end

			local var_56_25 = 4
			local var_56_26 = 0.1

			if var_56_25 < arg_53_1.time_ and arg_53_1.time_ <= var_56_25 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0

				arg_53_1.dialog_:SetActive(true)

				arg_53_1.dialogCg_.alpha = 0

				local var_56_27 = LeanTween.value(arg_53_1.dialog_, 0, 1, 0.3)

				var_56_27:setOnUpdate(LuaHelper.FloatAction(function(arg_57_0)
					arg_53_1.dialogCg_.alpha = arg_57_0
				end))
				var_56_27:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_53_1.dialog_)
					var_56_27:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_53_1.duration_ = arg_53_1.duration_ + 0.3

				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_28 = arg_53_1:FormatText(StoryNameCfg[570].name)

				arg_53_1.leftNameTxt_.text = var_56_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, true)
				arg_53_1.iconController_:SetSelectedState("hero")

				arg_53_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2094")

				arg_53_1.callingController_:SetSelectedState("normal")

				arg_53_1.keyicon_.color = Color.New(1, 1, 1)
				arg_53_1.icon_.color = Color.New(1, 1, 1)

				local var_56_29 = arg_53_1:GetWordFromCfg(317291010)
				local var_56_30 = arg_53_1:FormatText(var_56_29.content)

				arg_53_1.text_.text = var_56_30

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_31 = 4
				local var_56_32 = utf8.len(var_56_30)
				local var_56_33 = var_56_31 <= 0 and var_56_26 or var_56_26 * (var_56_32 / var_56_31)

				if var_56_33 > 0 and var_56_26 < var_56_33 then
					arg_53_1.talkMaxDuration = var_56_33
					var_56_25 = var_56_25 + 0.3

					if var_56_33 + var_56_25 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_33 + var_56_25
					end
				end

				arg_53_1.text_.text = var_56_30
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317291", "317291010", "story_v_out_317291.awb") ~= 0 then
					local var_56_34 = manager.audio:GetVoiceLength("story_v_out_317291", "317291010", "story_v_out_317291.awb") / 1000

					if var_56_34 + var_56_25 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_34 + var_56_25
					end

					if var_56_29.prefab_name ~= "" and arg_53_1.actors_[var_56_29.prefab_name] ~= nil then
						local var_56_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_29.prefab_name].transform, "story_v_out_317291", "317291010", "story_v_out_317291.awb")

						arg_53_1:RecordAudio("317291010", var_56_35)
						arg_53_1:RecordAudio("317291010", var_56_35)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_317291", "317291010", "story_v_out_317291.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_317291", "317291010", "story_v_out_317291.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_36 = var_56_25 + 0.3
			local var_56_37 = math.max(var_56_26, arg_53_1.talkMaxDuration)

			if var_56_36 <= arg_53_1.time_ and arg_53_1.time_ < var_56_36 + var_56_37 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_36) / var_56_37

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_36 + var_56_37 and arg_53_1.time_ < var_56_36 + var_56_37 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play317291011 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 317291011
		arg_59_1.duration_ = 4.4

		local var_59_0 = {
			zh = 4.4,
			ja = 3.533
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
				arg_59_0:Play317291012(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			local var_62_0 = 0

			if var_62_0 < arg_59_1.time_ and arg_59_1.time_ <= var_62_0 + arg_62_0 then
				local var_62_1 = manager.ui.mainCamera.transform.localPosition
				local var_62_2 = Vector3.New(0, 0, 10) + Vector3.New(var_62_1.x, var_62_1.y, 0)
				local var_62_3 = arg_59_1.bgs_.K11f

				var_62_3.transform.localPosition = var_62_2
				var_62_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_62_4 = var_62_3:GetComponent("SpriteRenderer")

				if var_62_4 and var_62_4.sprite then
					local var_62_5 = (var_62_3.transform.localPosition - var_62_1).z
					local var_62_6 = manager.ui.mainCameraCom_
					local var_62_7 = 2 * var_62_5 * Mathf.Tan(var_62_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_62_8 = var_62_7 * var_62_6.aspect
					local var_62_9 = var_62_4.sprite.bounds.size.x
					local var_62_10 = var_62_4.sprite.bounds.size.y
					local var_62_11 = var_62_8 / var_62_9
					local var_62_12 = var_62_7 / var_62_10
					local var_62_13 = var_62_12 < var_62_11 and var_62_11 or var_62_12

					var_62_3.transform.localScale = Vector3.New(var_62_13, var_62_13, 0)
				end

				for iter_62_0, iter_62_1 in pairs(arg_59_1.bgs_) do
					if iter_62_0 ~= "K11f" then
						iter_62_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_62_14 = 0

			if var_62_14 < arg_59_1.time_ and arg_59_1.time_ <= var_62_14 + arg_62_0 then
				arg_59_1.mask_.enabled = true
				arg_59_1.mask_.raycastTarget = true

				arg_59_1:SetGaussion(false)
			end

			local var_62_15 = 2

			if var_62_14 <= arg_59_1.time_ and arg_59_1.time_ < var_62_14 + var_62_15 then
				local var_62_16 = (arg_59_1.time_ - var_62_14) / var_62_15
				local var_62_17 = Color.New(0, 0, 0)

				var_62_17.a = Mathf.Lerp(1, 0, var_62_16)
				arg_59_1.mask_.color = var_62_17
			end

			if arg_59_1.time_ >= var_62_14 + var_62_15 and arg_59_1.time_ < var_62_14 + var_62_15 + arg_62_0 then
				local var_62_18 = Color.New(0, 0, 0)
				local var_62_19 = 0

				arg_59_1.mask_.enabled = false
				var_62_18.a = var_62_19
				arg_59_1.mask_.color = var_62_18
			end

			if arg_59_1.frameCnt_ <= 1 then
				arg_59_1.dialog_:SetActive(false)
			end

			local var_62_20 = 2
			local var_62_21 = 0.075

			if var_62_20 < arg_59_1.time_ and arg_59_1.time_ <= var_62_20 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0

				arg_59_1.dialog_:SetActive(true)

				arg_59_1.dialogCg_.alpha = 0

				local var_62_22 = LeanTween.value(arg_59_1.dialog_, 0, 1, 0.3)

				var_62_22:setOnUpdate(LuaHelper.FloatAction(function(arg_63_0)
					arg_59_1.dialogCg_.alpha = arg_63_0
				end))
				var_62_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_59_1.dialog_)
					var_62_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_59_1.duration_ = arg_59_1.duration_ + 0.3

				SetActive(arg_59_1.leftNameGo_, true)

				local var_62_23 = arg_59_1:FormatText(StoryNameCfg[572].name)

				arg_59_1.leftNameTxt_.text = var_62_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, true)
				arg_59_1.iconController_:SetSelectedState("hero")

				arg_59_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2079")

				arg_59_1.callingController_:SetSelectedState("normal")

				arg_59_1.keyicon_.color = Color.New(1, 1, 1)
				arg_59_1.icon_.color = Color.New(1, 1, 1)

				local var_62_24 = arg_59_1:GetWordFromCfg(317291011)
				local var_62_25 = arg_59_1:FormatText(var_62_24.content)

				arg_59_1.text_.text = var_62_25

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_26 = 3
				local var_62_27 = utf8.len(var_62_25)
				local var_62_28 = var_62_26 <= 0 and var_62_21 or var_62_21 * (var_62_27 / var_62_26)

				if var_62_28 > 0 and var_62_21 < var_62_28 then
					arg_59_1.talkMaxDuration = var_62_28
					var_62_20 = var_62_20 + 0.3

					if var_62_28 + var_62_20 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_28 + var_62_20
					end
				end

				arg_59_1.text_.text = var_62_25
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317291", "317291011", "story_v_out_317291.awb") ~= 0 then
					local var_62_29 = manager.audio:GetVoiceLength("story_v_out_317291", "317291011", "story_v_out_317291.awb") / 1000

					if var_62_29 + var_62_20 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_29 + var_62_20
					end

					if var_62_24.prefab_name ~= "" and arg_59_1.actors_[var_62_24.prefab_name] ~= nil then
						local var_62_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_59_1.actors_[var_62_24.prefab_name].transform, "story_v_out_317291", "317291011", "story_v_out_317291.awb")

						arg_59_1:RecordAudio("317291011", var_62_30)
						arg_59_1:RecordAudio("317291011", var_62_30)
					else
						arg_59_1:AudioAction("play", "voice", "story_v_out_317291", "317291011", "story_v_out_317291.awb")
					end

					arg_59_1:RecordHistoryTalkVoice("story_v_out_317291", "317291011", "story_v_out_317291.awb")
				end

				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_31 = var_62_20 + 0.3
			local var_62_32 = math.max(var_62_21, arg_59_1.talkMaxDuration)

			if var_62_31 <= arg_59_1.time_ and arg_59_1.time_ < var_62_31 + var_62_32 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_31) / var_62_32

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_31 + var_62_32 and arg_59_1.time_ < var_62_31 + var_62_32 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {}

		arg_59_1:InitPlayNodeList()
	end,
	Play317291012 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 317291012
		arg_65_1.duration_ = 5.27

		local var_65_0 = {
			zh = 2.233,
			ja = 5.266
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
				arg_65_0:Play317291013(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = 0
			local var_68_1 = 0.175

			if var_68_0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_0 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				local var_68_2 = arg_65_1:FormatText(StoryNameCfg[570].name)

				arg_65_1.leftNameTxt_.text = var_68_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, true)
				arg_65_1.iconController_:SetSelectedState("hero")

				arg_65_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2094")

				arg_65_1.callingController_:SetSelectedState("normal")

				arg_65_1.keyicon_.color = Color.New(1, 1, 1)
				arg_65_1.icon_.color = Color.New(1, 1, 1)

				local var_68_3 = arg_65_1:GetWordFromCfg(317291012)
				local var_68_4 = arg_65_1:FormatText(var_68_3.content)

				arg_65_1.text_.text = var_68_4

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_5 = 7
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

				if manager.audio:GetVoiceLength("story_v_out_317291", "317291012", "story_v_out_317291.awb") ~= 0 then
					local var_68_8 = manager.audio:GetVoiceLength("story_v_out_317291", "317291012", "story_v_out_317291.awb") / 1000

					if var_68_8 + var_68_0 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_8 + var_68_0
					end

					if var_68_3.prefab_name ~= "" and arg_65_1.actors_[var_68_3.prefab_name] ~= nil then
						local var_68_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_3.prefab_name].transform, "story_v_out_317291", "317291012", "story_v_out_317291.awb")

						arg_65_1:RecordAudio("317291012", var_68_9)
						arg_65_1:RecordAudio("317291012", var_68_9)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_317291", "317291012", "story_v_out_317291.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_317291", "317291012", "story_v_out_317291.awb")
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
	Play317291013 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 317291013
		arg_69_1.duration_ = 5

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play317291014(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = 0
			local var_72_1 = 1.575

			if var_72_0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_0 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, false)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_2 = arg_69_1:GetWordFromCfg(317291013)
				local var_72_3 = arg_69_1:FormatText(var_72_2.content)

				arg_69_1.text_.text = var_72_3

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_4 = 63
				local var_72_5 = utf8.len(var_72_3)
				local var_72_6 = var_72_4 <= 0 and var_72_1 or var_72_1 * (var_72_5 / var_72_4)

				if var_72_6 > 0 and var_72_1 < var_72_6 then
					arg_69_1.talkMaxDuration = var_72_6

					if var_72_6 + var_72_0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_6 + var_72_0
					end
				end

				arg_69_1.text_.text = var_72_3
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)
				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_7 = math.max(var_72_1, arg_69_1.talkMaxDuration)

			if var_72_0 <= arg_69_1.time_ and arg_69_1.time_ < var_72_0 + var_72_7 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_0) / var_72_7

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_0 + var_72_7 and arg_69_1.time_ < var_72_0 + var_72_7 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play317291014 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 317291014
		arg_73_1.duration_ = 15.8

		local var_73_0 = {
			zh = 12.2,
			ja = 15.8
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
				arg_73_0:Play317291015(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = 0
			local var_76_1 = 0.975

			if var_76_0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_0 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				local var_76_2 = arg_73_1:FormatText(StoryNameCfg[570].name)

				arg_73_1.leftNameTxt_.text = var_76_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, true)
				arg_73_1.iconController_:SetSelectedState("hero")

				arg_73_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2094")

				arg_73_1.callingController_:SetSelectedState("normal")

				arg_73_1.keyicon_.color = Color.New(1, 1, 1)
				arg_73_1.icon_.color = Color.New(1, 1, 1)

				local var_76_3 = arg_73_1:GetWordFromCfg(317291014)
				local var_76_4 = arg_73_1:FormatText(var_76_3.content)

				arg_73_1.text_.text = var_76_4

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_5 = 39
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

				if manager.audio:GetVoiceLength("story_v_out_317291", "317291014", "story_v_out_317291.awb") ~= 0 then
					local var_76_8 = manager.audio:GetVoiceLength("story_v_out_317291", "317291014", "story_v_out_317291.awb") / 1000

					if var_76_8 + var_76_0 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_8 + var_76_0
					end

					if var_76_3.prefab_name ~= "" and arg_73_1.actors_[var_76_3.prefab_name] ~= nil then
						local var_76_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_3.prefab_name].transform, "story_v_out_317291", "317291014", "story_v_out_317291.awb")

						arg_73_1:RecordAudio("317291014", var_76_9)
						arg_73_1:RecordAudio("317291014", var_76_9)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_317291", "317291014", "story_v_out_317291.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_317291", "317291014", "story_v_out_317291.awb")
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
	Play317291015 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 317291015
		arg_77_1.duration_ = 10.83

		local var_77_0 = {
			zh = 10.833,
			ja = 9.266
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
				arg_77_0:Play317291016(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = 0
			local var_80_1 = 0.775

			if var_80_0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_0 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				local var_80_2 = arg_77_1:FormatText(StoryNameCfg[570].name)

				arg_77_1.leftNameTxt_.text = var_80_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, true)
				arg_77_1.iconController_:SetSelectedState("hero")

				arg_77_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2094")

				arg_77_1.callingController_:SetSelectedState("normal")

				arg_77_1.keyicon_.color = Color.New(1, 1, 1)
				arg_77_1.icon_.color = Color.New(1, 1, 1)

				local var_80_3 = arg_77_1:GetWordFromCfg(317291015)
				local var_80_4 = arg_77_1:FormatText(var_80_3.content)

				arg_77_1.text_.text = var_80_4

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_5 = 31
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

				if manager.audio:GetVoiceLength("story_v_out_317291", "317291015", "story_v_out_317291.awb") ~= 0 then
					local var_80_8 = manager.audio:GetVoiceLength("story_v_out_317291", "317291015", "story_v_out_317291.awb") / 1000

					if var_80_8 + var_80_0 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_8 + var_80_0
					end

					if var_80_3.prefab_name ~= "" and arg_77_1.actors_[var_80_3.prefab_name] ~= nil then
						local var_80_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_3.prefab_name].transform, "story_v_out_317291", "317291015", "story_v_out_317291.awb")

						arg_77_1:RecordAudio("317291015", var_80_9)
						arg_77_1:RecordAudio("317291015", var_80_9)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_317291", "317291015", "story_v_out_317291.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_317291", "317291015", "story_v_out_317291.awb")
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
	Play317291016 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 317291016
		arg_81_1.duration_ = 13.1

		local var_81_0 = {
			zh = 10.933,
			ja = 13.1
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
				arg_81_0:Play317291017(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = 0
			local var_84_1 = 0.75

			if var_84_0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_0 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				local var_84_2 = arg_81_1:FormatText(StoryNameCfg[570].name)

				arg_81_1.leftNameTxt_.text = var_84_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, true)
				arg_81_1.iconController_:SetSelectedState("hero")

				arg_81_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2094")

				arg_81_1.callingController_:SetSelectedState("normal")

				arg_81_1.keyicon_.color = Color.New(1, 1, 1)
				arg_81_1.icon_.color = Color.New(1, 1, 1)

				local var_84_3 = arg_81_1:GetWordFromCfg(317291016)
				local var_84_4 = arg_81_1:FormatText(var_84_3.content)

				arg_81_1.text_.text = var_84_4

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_5 = 30
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

				if manager.audio:GetVoiceLength("story_v_out_317291", "317291016", "story_v_out_317291.awb") ~= 0 then
					local var_84_8 = manager.audio:GetVoiceLength("story_v_out_317291", "317291016", "story_v_out_317291.awb") / 1000

					if var_84_8 + var_84_0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_8 + var_84_0
					end

					if var_84_3.prefab_name ~= "" and arg_81_1.actors_[var_84_3.prefab_name] ~= nil then
						local var_84_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_3.prefab_name].transform, "story_v_out_317291", "317291016", "story_v_out_317291.awb")

						arg_81_1:RecordAudio("317291016", var_84_9)
						arg_81_1:RecordAudio("317291016", var_84_9)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_317291", "317291016", "story_v_out_317291.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_317291", "317291016", "story_v_out_317291.awb")
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
	Play317291017 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 317291017
		arg_85_1.duration_ = 15.4

		local var_85_0 = {
			zh = 11.166,
			ja = 15.4
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
				arg_85_0:Play317291018(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = 0
			local var_88_1 = 0.775

			if var_88_0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_0 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				local var_88_2 = arg_85_1:FormatText(StoryNameCfg[570].name)

				arg_85_1.leftNameTxt_.text = var_88_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, true)
				arg_85_1.iconController_:SetSelectedState("hero")

				arg_85_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2094")

				arg_85_1.callingController_:SetSelectedState("normal")

				arg_85_1.keyicon_.color = Color.New(1, 1, 1)
				arg_85_1.icon_.color = Color.New(1, 1, 1)

				local var_88_3 = arg_85_1:GetWordFromCfg(317291017)
				local var_88_4 = arg_85_1:FormatText(var_88_3.content)

				arg_85_1.text_.text = var_88_4

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_5 = 31
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

				if manager.audio:GetVoiceLength("story_v_out_317291", "317291017", "story_v_out_317291.awb") ~= 0 then
					local var_88_8 = manager.audio:GetVoiceLength("story_v_out_317291", "317291017", "story_v_out_317291.awb") / 1000

					if var_88_8 + var_88_0 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_8 + var_88_0
					end

					if var_88_3.prefab_name ~= "" and arg_85_1.actors_[var_88_3.prefab_name] ~= nil then
						local var_88_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_3.prefab_name].transform, "story_v_out_317291", "317291017", "story_v_out_317291.awb")

						arg_85_1:RecordAudio("317291017", var_88_9)
						arg_85_1:RecordAudio("317291017", var_88_9)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_317291", "317291017", "story_v_out_317291.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_317291", "317291017", "story_v_out_317291.awb")
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
	Play317291018 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 317291018
		arg_89_1.duration_ = 5.3

		local var_89_0 = {
			zh = 5.3,
			ja = 4.466
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
				arg_89_0:Play317291019(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = 0
			local var_92_1 = 0.25

			if var_92_0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_0 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				local var_92_2 = arg_89_1:FormatText(StoryNameCfg[570].name)

				arg_89_1.leftNameTxt_.text = var_92_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, true)
				arg_89_1.iconController_:SetSelectedState("hero")

				arg_89_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2094")

				arg_89_1.callingController_:SetSelectedState("normal")

				arg_89_1.keyicon_.color = Color.New(1, 1, 1)
				arg_89_1.icon_.color = Color.New(1, 1, 1)

				local var_92_3 = arg_89_1:GetWordFromCfg(317291018)
				local var_92_4 = arg_89_1:FormatText(var_92_3.content)

				arg_89_1.text_.text = var_92_4

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_5 = 10
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

				if manager.audio:GetVoiceLength("story_v_out_317291", "317291018", "story_v_out_317291.awb") ~= 0 then
					local var_92_8 = manager.audio:GetVoiceLength("story_v_out_317291", "317291018", "story_v_out_317291.awb") / 1000

					if var_92_8 + var_92_0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_8 + var_92_0
					end

					if var_92_3.prefab_name ~= "" and arg_89_1.actors_[var_92_3.prefab_name] ~= nil then
						local var_92_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_3.prefab_name].transform, "story_v_out_317291", "317291018", "story_v_out_317291.awb")

						arg_89_1:RecordAudio("317291018", var_92_9)
						arg_89_1:RecordAudio("317291018", var_92_9)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_317291", "317291018", "story_v_out_317291.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_317291", "317291018", "story_v_out_317291.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_10 = math.max(var_92_1, arg_89_1.talkMaxDuration)

			if var_92_0 <= arg_89_1.time_ and arg_89_1.time_ < var_92_0 + var_92_10 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_0) / var_92_10

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_0 + var_92_10 and arg_89_1.time_ < var_92_0 + var_92_10 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play317291019 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 317291019
		arg_93_1.duration_ = 9

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play317291020(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = 2

			if var_96_0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_0 + arg_96_0 then
				local var_96_1 = manager.ui.mainCamera.transform.localPosition
				local var_96_2 = Vector3.New(0, 0, 10) + Vector3.New(var_96_1.x, var_96_1.y, 0)
				local var_96_3 = arg_93_1.bgs_.STblack

				var_96_3.transform.localPosition = var_96_2
				var_96_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_96_4 = var_96_3:GetComponent("SpriteRenderer")

				if var_96_4 and var_96_4.sprite then
					local var_96_5 = (var_96_3.transform.localPosition - var_96_1).z
					local var_96_6 = manager.ui.mainCameraCom_
					local var_96_7 = 2 * var_96_5 * Mathf.Tan(var_96_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_96_8 = var_96_7 * var_96_6.aspect
					local var_96_9 = var_96_4.sprite.bounds.size.x
					local var_96_10 = var_96_4.sprite.bounds.size.y
					local var_96_11 = var_96_8 / var_96_9
					local var_96_12 = var_96_7 / var_96_10
					local var_96_13 = var_96_12 < var_96_11 and var_96_11 or var_96_12

					var_96_3.transform.localScale = Vector3.New(var_96_13, var_96_13, 0)
				end

				for iter_96_0, iter_96_1 in pairs(arg_93_1.bgs_) do
					if iter_96_0 ~= "STblack" then
						iter_96_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_96_14 = 0

			if var_96_14 < arg_93_1.time_ and arg_93_1.time_ <= var_96_14 + arg_96_0 then
				arg_93_1.mask_.enabled = true
				arg_93_1.mask_.raycastTarget = true

				arg_93_1:SetGaussion(false)
			end

			local var_96_15 = 2

			if var_96_14 <= arg_93_1.time_ and arg_93_1.time_ < var_96_14 + var_96_15 then
				local var_96_16 = (arg_93_1.time_ - var_96_14) / var_96_15
				local var_96_17 = Color.New(0, 0, 0)

				var_96_17.a = Mathf.Lerp(0, 1, var_96_16)
				arg_93_1.mask_.color = var_96_17
			end

			if arg_93_1.time_ >= var_96_14 + var_96_15 and arg_93_1.time_ < var_96_14 + var_96_15 + arg_96_0 then
				local var_96_18 = Color.New(0, 0, 0)

				var_96_18.a = 1
				arg_93_1.mask_.color = var_96_18
			end

			local var_96_19 = 2

			if var_96_19 < arg_93_1.time_ and arg_93_1.time_ <= var_96_19 + arg_96_0 then
				arg_93_1.mask_.enabled = true
				arg_93_1.mask_.raycastTarget = true

				arg_93_1:SetGaussion(false)
			end

			local var_96_20 = 2

			if var_96_19 <= arg_93_1.time_ and arg_93_1.time_ < var_96_19 + var_96_20 then
				local var_96_21 = (arg_93_1.time_ - var_96_19) / var_96_20
				local var_96_22 = Color.New(0, 0, 0)

				var_96_22.a = Mathf.Lerp(1, 0, var_96_21)
				arg_93_1.mask_.color = var_96_22
			end

			if arg_93_1.time_ >= var_96_19 + var_96_20 and arg_93_1.time_ < var_96_19 + var_96_20 + arg_96_0 then
				local var_96_23 = Color.New(0, 0, 0)
				local var_96_24 = 0

				arg_93_1.mask_.enabled = false
				var_96_23.a = var_96_24
				arg_93_1.mask_.color = var_96_23
			end

			if arg_93_1.frameCnt_ <= 1 then
				arg_93_1.dialog_:SetActive(false)
			end

			local var_96_25 = 4
			local var_96_26 = 0.775

			if var_96_25 < arg_93_1.time_ and arg_93_1.time_ <= var_96_25 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0

				arg_93_1.dialog_:SetActive(true)

				arg_93_1.dialogCg_.alpha = 0

				local var_96_27 = LeanTween.value(arg_93_1.dialog_, 0, 1, 0.3)

				var_96_27:setOnUpdate(LuaHelper.FloatAction(function(arg_97_0)
					arg_93_1.dialogCg_.alpha = arg_97_0
				end))
				var_96_27:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_93_1.dialog_)
					var_96_27:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_93_1.duration_ = arg_93_1.duration_ + 0.3

				SetActive(arg_93_1.leftNameGo_, false)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_28 = arg_93_1:GetWordFromCfg(317291019)
				local var_96_29 = arg_93_1:FormatText(var_96_28.content)

				arg_93_1.text_.text = var_96_29

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_30 = 31
				local var_96_31 = utf8.len(var_96_29)
				local var_96_32 = var_96_30 <= 0 and var_96_26 or var_96_26 * (var_96_31 / var_96_30)

				if var_96_32 > 0 and var_96_26 < var_96_32 then
					arg_93_1.talkMaxDuration = var_96_32
					var_96_25 = var_96_25 + 0.3

					if var_96_32 + var_96_25 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_32 + var_96_25
					end
				end

				arg_93_1.text_.text = var_96_29
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)
				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_33 = var_96_25 + 0.3
			local var_96_34 = math.max(var_96_26, arg_93_1.talkMaxDuration)

			if var_96_33 <= arg_93_1.time_ and arg_93_1.time_ < var_96_33 + var_96_34 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_33) / var_96_34

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_33 + var_96_34 and arg_93_1.time_ < var_96_33 + var_96_34 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play317291020 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 317291020
		arg_99_1.duration_ = 5

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play317291021(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			local var_102_0 = 0
			local var_102_1 = 0.6

			if var_102_0 < arg_99_1.time_ and arg_99_1.time_ <= var_102_0 + arg_102_0 then
				local var_102_2 = "play"
				local var_102_3 = "effect"

				arg_99_1:AudioAction(var_102_2, var_102_3, "se_story_126_01", "se_story_126_01_noise", "")
			end

			local var_102_4 = 0
			local var_102_5 = 0.1

			if var_102_4 < arg_99_1.time_ and arg_99_1.time_ <= var_102_4 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, true)

				local var_102_6 = arg_99_1:FormatText(StoryNameCfg[68].name)

				arg_99_1.leftNameTxt_.text = var_102_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, true)
				arg_99_1.iconController_:SetSelectedState("hero")

				arg_99_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2096")

				arg_99_1.callingController_:SetSelectedState("normal")

				arg_99_1.keyicon_.color = Color.New(1, 1, 1)
				arg_99_1.icon_.color = Color.New(1, 1, 1)

				local var_102_7 = arg_99_1:GetWordFromCfg(317291020)
				local var_102_8 = arg_99_1:FormatText(var_102_7.content)

				arg_99_1.text_.text = var_102_8

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_9 = 4
				local var_102_10 = utf8.len(var_102_8)
				local var_102_11 = var_102_9 <= 0 and var_102_5 or var_102_5 * (var_102_10 / var_102_9)

				if var_102_11 > 0 and var_102_5 < var_102_11 then
					arg_99_1.talkMaxDuration = var_102_11

					if var_102_11 + var_102_4 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_11 + var_102_4
					end
				end

				arg_99_1.text_.text = var_102_8
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)
				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_12 = math.max(var_102_5, arg_99_1.talkMaxDuration)

			if var_102_4 <= arg_99_1.time_ and arg_99_1.time_ < var_102_4 + var_102_12 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_4) / var_102_12

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_4 + var_102_12 and arg_99_1.time_ < var_102_4 + var_102_12 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {}

		arg_99_1:InitPlayNodeList()
	end,
	Play317291021 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 317291021
		arg_103_1.duration_ = 4.83

		local var_103_0 = {
			zh = 3.866,
			ja = 4.833
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
				arg_103_0:Play317291022(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			local var_106_0 = 0
			local var_106_1 = 0.55

			if var_106_0 < arg_103_1.time_ and arg_103_1.time_ <= var_106_0 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				local var_106_2 = arg_103_1:FormatText(StoryNameCfg[73].name)

				arg_103_1.leftNameTxt_.text = var_106_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, true)
				arg_103_1.iconController_:SetSelectedState("hero")

				arg_103_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1093")

				arg_103_1.callingController_:SetSelectedState("normal")

				arg_103_1.keyicon_.color = Color.New(1, 1, 1)
				arg_103_1.icon_.color = Color.New(1, 1, 1)

				local var_106_3 = arg_103_1:GetWordFromCfg(317291021)
				local var_106_4 = arg_103_1:FormatText(var_106_3.content)

				arg_103_1.text_.text = var_106_4

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_5 = 22
				local var_106_6 = utf8.len(var_106_4)
				local var_106_7 = var_106_5 <= 0 and var_106_1 or var_106_1 * (var_106_6 / var_106_5)

				if var_106_7 > 0 and var_106_1 < var_106_7 then
					arg_103_1.talkMaxDuration = var_106_7

					if var_106_7 + var_106_0 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_7 + var_106_0
					end
				end

				arg_103_1.text_.text = var_106_4
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317291", "317291021", "story_v_out_317291.awb") ~= 0 then
					local var_106_8 = manager.audio:GetVoiceLength("story_v_out_317291", "317291021", "story_v_out_317291.awb") / 1000

					if var_106_8 + var_106_0 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_8 + var_106_0
					end

					if var_106_3.prefab_name ~= "" and arg_103_1.actors_[var_106_3.prefab_name] ~= nil then
						local var_106_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_103_1.actors_[var_106_3.prefab_name].transform, "story_v_out_317291", "317291021", "story_v_out_317291.awb")

						arg_103_1:RecordAudio("317291021", var_106_9)
						arg_103_1:RecordAudio("317291021", var_106_9)
					else
						arg_103_1:AudioAction("play", "voice", "story_v_out_317291", "317291021", "story_v_out_317291.awb")
					end

					arg_103_1:RecordHistoryTalkVoice("story_v_out_317291", "317291021", "story_v_out_317291.awb")
				end

				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_10 = math.max(var_106_1, arg_103_1.talkMaxDuration)

			if var_106_0 <= arg_103_1.time_ and arg_103_1.time_ < var_106_0 + var_106_10 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_0) / var_106_10

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_0 + var_106_10 and arg_103_1.time_ < var_106_0 + var_106_10 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {}

		arg_103_1:InitPlayNodeList()
	end,
	Play317291022 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 317291022
		arg_107_1.duration_ = 4.7

		local var_107_0 = {
			zh = 4.7,
			ja = 4.4
		}
		local var_107_1 = manager.audio:GetLocalizationFlag()

		if var_107_0[var_107_1] ~= nil then
			arg_107_1.duration_ = var_107_0[var_107_1]
		end

		SetActive(arg_107_1.tipsGo_, false)

		function arg_107_1.onSingleLineFinish_()
			arg_107_1.onSingleLineUpdate_ = nil
			arg_107_1.onSingleLineFinish_ = nil
			arg_107_1.state_ = "waiting"
			arg_107_1.auto_ = false
		end

		function arg_107_1.playNext_(arg_109_0)
			arg_107_1.onStoryFinished_()
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			local var_110_0 = 0
			local var_110_1 = 0.625

			if var_110_0 < arg_107_1.time_ and arg_107_1.time_ <= var_110_0 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				local var_110_2 = arg_107_1:FormatText(StoryNameCfg[84].name)

				arg_107_1.leftNameTxt_.text = var_110_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, true)
				arg_107_1.iconController_:SetSelectedState("hero")

				arg_107_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1199")

				arg_107_1.callingController_:SetSelectedState("normal")

				arg_107_1.keyicon_.color = Color.New(1, 1, 1)
				arg_107_1.icon_.color = Color.New(1, 1, 1)

				local var_110_3 = arg_107_1:GetWordFromCfg(317291022)
				local var_110_4 = arg_107_1:FormatText(var_110_3.content)

				arg_107_1.text_.text = var_110_4

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_5 = 25
				local var_110_6 = utf8.len(var_110_4)
				local var_110_7 = var_110_5 <= 0 and var_110_1 or var_110_1 * (var_110_6 / var_110_5)

				if var_110_7 > 0 and var_110_1 < var_110_7 then
					arg_107_1.talkMaxDuration = var_110_7

					if var_110_7 + var_110_0 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_7 + var_110_0
					end
				end

				arg_107_1.text_.text = var_110_4
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317291", "317291022", "story_v_out_317291.awb") ~= 0 then
					local var_110_8 = manager.audio:GetVoiceLength("story_v_out_317291", "317291022", "story_v_out_317291.awb") / 1000

					if var_110_8 + var_110_0 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_8 + var_110_0
					end

					if var_110_3.prefab_name ~= "" and arg_107_1.actors_[var_110_3.prefab_name] ~= nil then
						local var_110_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_107_1.actors_[var_110_3.prefab_name].transform, "story_v_out_317291", "317291022", "story_v_out_317291.awb")

						arg_107_1:RecordAudio("317291022", var_110_9)
						arg_107_1:RecordAudio("317291022", var_110_9)
					else
						arg_107_1:AudioAction("play", "voice", "story_v_out_317291", "317291022", "story_v_out_317291.awb")
					end

					arg_107_1:RecordHistoryTalkVoice("story_v_out_317291", "317291022", "story_v_out_317291.awb")
				end

				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_10 = math.max(var_110_1, arg_107_1.talkMaxDuration)

			if var_110_0 <= arg_107_1.time_ and arg_107_1.time_ < var_110_0 + var_110_10 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_0) / var_110_10

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_0 + var_110_10 and arg_107_1.time_ < var_110_0 + var_110_10 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {}

		arg_107_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/K11f",
		"TextureConfig/Background/STblack"
	},
	voices = {
		"story_v_out_317291.awb"
	}
}
