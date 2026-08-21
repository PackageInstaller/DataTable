return {
	Play115281001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 115281001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play115281002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "STblack"

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
				local var_4_5 = arg_1_1.bgs_.STblack

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
					if iter_4_0 ~= "STblack" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = manager.ui.mainCamera.transform
			local var_4_17 = 2

			if var_4_17 < arg_1_1.time_ and arg_1_1.time_ <= var_4_17 + arg_4_0 then
				arg_1_1.var_.shakeOldPos = var_4_16.localPosition
			end

			local var_4_18 = 0.333333333333333

			if var_4_17 <= arg_1_1.time_ and arg_1_1.time_ < var_4_17 + var_4_18 then
				local var_4_19 = (arg_1_1.time_ - var_4_17) / 0.066
				local var_4_20, var_4_21 = math.modf(var_4_19)

				var_4_16.localPosition = Vector3.New(var_4_21 * 0.13, var_4_21 * 0.13, var_4_21 * 0.13) + arg_1_1.var_.shakeOldPos
			end

			if arg_1_1.time_ >= var_4_17 + var_4_18 and arg_1_1.time_ < var_4_17 + var_4_18 + arg_4_0 then
				var_4_16.localPosition = arg_1_1.var_.shakeOldPos
			end

			local var_4_22 = 0
			local var_4_23 = 0.766666666666667

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

			local var_4_28 = 1.075
			local var_4_29 = 1.925

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				local var_4_30 = "play"
				local var_4_31 = "music"

				arg_1_1:AudioAction(var_4_30, var_4_31, "bgm_side_daily03", "bgm_side_daily03", "bgm_side_daily03.awb")

				local var_4_32 = ""
				local var_4_33 = manager.audio:GetAudioName("bgm_side_daily03", "bgm_side_daily03")

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
			local var_4_35 = 1

			if var_4_34 < arg_1_1.time_ and arg_1_1.time_ <= var_4_34 + arg_4_0 then
				local var_4_36 = "play"
				local var_4_37 = "effect"

				arg_1_1:AudioAction(var_4_36, var_4_37, "se_story_activity_1_5_3", "se_story_activity_1_5_3_fireworks", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_38 = 2
			local var_4_39 = 0.075

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

				local var_4_41 = arg_1_1:GetWordFromCfg(115281001)
				local var_4_42 = arg_1_1:FormatText(var_4_41.content)

				arg_1_1.text_.text = var_4_42

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_43 = 3
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
	Play115281002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 115281002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play115281003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0
			local var_12_1 = 0.55

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

				local var_12_2 = arg_9_1:GetWordFromCfg(115281002)
				local var_12_3 = arg_9_1:FormatText(var_12_2.content)

				arg_9_1.text_.text = var_12_3

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_4 = 22
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
	Play115281003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 115281003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play115281004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0
			local var_16_1 = 0.7

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

				local var_16_2 = arg_13_1:GetWordFromCfg(115281003)
				local var_16_3 = arg_13_1:FormatText(var_16_2.content)

				arg_13_1.text_.text = var_16_3

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_4 = 28
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
	Play115281004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 115281004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play115281005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0
			local var_20_1 = 0.95

			if var_20_0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_0 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, false)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_2 = arg_17_1:GetWordFromCfg(115281004)
				local var_20_3 = arg_17_1:FormatText(var_20_2.content)

				arg_17_1.text_.text = var_20_3

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_4 = 38
				local var_20_5 = utf8.len(var_20_3)
				local var_20_6 = var_20_4 <= 0 and var_20_1 or var_20_1 * (var_20_5 / var_20_4)

				if var_20_6 > 0 and var_20_1 < var_20_6 then
					arg_17_1.talkMaxDuration = var_20_6

					if var_20_6 + var_20_0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_6 + var_20_0
					end
				end

				arg_17_1.text_.text = var_20_3
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)
				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_7 = math.max(var_20_1, arg_17_1.talkMaxDuration)

			if var_20_0 <= arg_17_1.time_ and arg_17_1.time_ < var_20_0 + var_20_7 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_0) / var_20_7

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_0 + var_20_7 and arg_17_1.time_ < var_20_0 + var_20_7 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play115281005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 115281005
		arg_21_1.duration_ = 2.17

		local var_21_0 = {
			ja = 1.466,
			ko = 1.833,
			zh = 1.833,
			en = 2.166
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
				arg_21_0:Play115281006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 0
			local var_24_1 = 0.15

			if var_24_0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_0 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_2 = arg_21_1:FormatText(StoryNameCfg[309].name)

				arg_21_1.leftNameTxt_.text = var_24_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, true)
				arg_21_1.iconController_:SetSelectedState("hero")

				arg_21_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10030_split_2")

				arg_21_1.callingController_:SetSelectedState("normal")

				arg_21_1.keyicon_.color = Color.New(1, 1, 1)
				arg_21_1.icon_.color = Color.New(1, 1, 1)

				local var_24_3 = arg_21_1:GetWordFromCfg(115281005)
				local var_24_4 = arg_21_1:FormatText(var_24_3.content)

				arg_21_1.text_.text = var_24_4

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_5 = 6
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

				if manager.audio:GetVoiceLength("story_v_out_115281", "115281005", "story_v_out_115281.awb") ~= 0 then
					local var_24_8 = manager.audio:GetVoiceLength("story_v_out_115281", "115281005", "story_v_out_115281.awb") / 1000

					if var_24_8 + var_24_0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_8 + var_24_0
					end

					if var_24_3.prefab_name ~= "" and arg_21_1.actors_[var_24_3.prefab_name] ~= nil then
						local var_24_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_3.prefab_name].transform, "story_v_out_115281", "115281005", "story_v_out_115281.awb")

						arg_21_1:RecordAudio("115281005", var_24_9)
						arg_21_1:RecordAudio("115281005", var_24_9)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_115281", "115281005", "story_v_out_115281.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_115281", "115281005", "story_v_out_115281.awb")
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
	Play115281006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 115281006
		arg_25_1.duration_ = 8

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play115281007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = "D999"

			if arg_25_1.bgs_[var_28_0] == nil then
				local var_28_1 = Object.Instantiate(arg_25_1.paintGo_)

				var_28_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_28_0)
				var_28_1.name = var_28_0
				var_28_1.transform.parent = arg_25_1.stage_.transform
				var_28_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_25_1.bgs_[var_28_0] = var_28_1
			end

			local var_28_2 = 1

			if var_28_2 < arg_25_1.time_ and arg_25_1.time_ <= var_28_2 + arg_28_0 then
				local var_28_3 = manager.ui.mainCamera.transform.localPosition
				local var_28_4 = Vector3.New(0, 0, 10) + Vector3.New(var_28_3.x, var_28_3.y, 0)
				local var_28_5 = arg_25_1.bgs_.D999

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
					if iter_28_0 ~= "D999" then
						iter_28_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_28_16 = 0

			if var_28_16 < arg_25_1.time_ and arg_25_1.time_ <= var_28_16 + arg_28_0 then
				arg_25_1.mask_.enabled = true
				arg_25_1.mask_.raycastTarget = false

				arg_25_1:SetGaussion(false)
			end

			local var_28_17 = 1

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

			local var_28_21 = 1

			if var_28_21 < arg_25_1.time_ and arg_25_1.time_ <= var_28_21 + arg_28_0 then
				arg_25_1.mask_.enabled = true
				arg_25_1.mask_.raycastTarget = false

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

			if arg_25_1.frameCnt_ <= 1 then
				arg_25_1.dialog_:SetActive(false)
			end

			local var_28_27 = 3
			local var_28_28 = 0.7

			if var_28_27 < arg_25_1.time_ and arg_25_1.time_ <= var_28_27 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0

				arg_25_1.dialog_:SetActive(true)

				arg_25_1.dialogCg_.alpha = 0

				local var_28_29 = LeanTween.value(arg_25_1.dialog_, 0, 1, 0.3)

				var_28_29:setOnUpdate(LuaHelper.FloatAction(function(arg_29_0)
					arg_25_1.dialogCg_.alpha = arg_29_0
				end))
				var_28_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_25_1.dialog_)
					var_28_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_25_1.duration_ = arg_25_1.duration_ + 0.3

				SetActive(arg_25_1.leftNameGo_, false)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_30 = arg_25_1:GetWordFromCfg(115281006)
				local var_28_31 = arg_25_1:FormatText(var_28_30.content)

				arg_25_1.text_.text = var_28_31

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_32 = 28
				local var_28_33 = utf8.len(var_28_31)
				local var_28_34 = var_28_32 <= 0 and var_28_28 or var_28_28 * (var_28_33 / var_28_32)

				if var_28_34 > 0 and var_28_28 < var_28_34 then
					arg_25_1.talkMaxDuration = var_28_34
					var_28_27 = var_28_27 + 0.3

					if var_28_34 + var_28_27 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_34 + var_28_27
					end
				end

				arg_25_1.text_.text = var_28_31
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_35 = var_28_27 + 0.3
			local var_28_36 = math.max(var_28_28, arg_25_1.talkMaxDuration)

			if var_28_35 <= arg_25_1.time_ and arg_25_1.time_ < var_28_35 + var_28_36 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_35) / var_28_36

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_35 + var_28_36 and arg_25_1.time_ < var_28_35 + var_28_36 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play115281007 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 115281007
		arg_31_1.duration_ = 5

		SetActive(arg_31_1.tipsGo_, false)

		function arg_31_1.onSingleLineFinish_()
			arg_31_1.onSingleLineUpdate_ = nil
			arg_31_1.onSingleLineFinish_ = nil
			arg_31_1.state_ = "waiting"
		end

		function arg_31_1.playNext_(arg_33_0)
			if arg_33_0 == 1 then
				arg_31_0:Play115281008(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			local var_34_0 = 0
			local var_34_1 = 0.975

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

				local var_34_2 = arg_31_1:GetWordFromCfg(115281007)
				local var_34_3 = arg_31_1:FormatText(var_34_2.content)

				arg_31_1.text_.text = var_34_3

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_4 = 39
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
	Play115281008 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 115281008
		arg_35_1.duration_ = 5

		SetActive(arg_35_1.tipsGo_, false)

		function arg_35_1.onSingleLineFinish_()
			arg_35_1.onSingleLineUpdate_ = nil
			arg_35_1.onSingleLineFinish_ = nil
			arg_35_1.state_ = "waiting"
		end

		function arg_35_1.playNext_(arg_37_0)
			if arg_37_0 == 1 then
				arg_35_0:Play115281009(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			local var_38_0 = 0
			local var_38_1 = 1.15

			if var_38_0 < arg_35_1.time_ and arg_35_1.time_ <= var_38_0 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, false)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_35_1.iconTrs_.gameObject, false)
				arg_35_1.callingController_:SetSelectedState("normal")

				local var_38_2 = arg_35_1:GetWordFromCfg(115281008)
				local var_38_3 = arg_35_1:FormatText(var_38_2.content)

				arg_35_1.text_.text = var_38_3

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_4 = 46
				local var_38_5 = utf8.len(var_38_3)
				local var_38_6 = var_38_4 <= 0 and var_38_1 or var_38_1 * (var_38_5 / var_38_4)

				if var_38_6 > 0 and var_38_1 < var_38_6 then
					arg_35_1.talkMaxDuration = var_38_6

					if var_38_6 + var_38_0 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_6 + var_38_0
					end
				end

				arg_35_1.text_.text = var_38_3
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)
				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_7 = math.max(var_38_1, arg_35_1.talkMaxDuration)

			if var_38_0 <= arg_35_1.time_ and arg_35_1.time_ < var_38_0 + var_38_7 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - var_38_0) / var_38_7

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= var_38_0 + var_38_7 and arg_35_1.time_ < var_38_0 + var_38_7 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {}

		arg_35_1:InitPlayNodeList()
	end,
	Play115281009 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 115281009
		arg_39_1.duration_ = 10.87

		local var_39_0 = {
			ja = 10.866,
			ko = 6.933,
			zh = 7.9,
			en = 7.4
		}
		local var_39_1 = manager.audio:GetLocalizationFlag()

		if var_39_0[var_39_1] ~= nil then
			arg_39_1.duration_ = var_39_0[var_39_1]
		end

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play115281010(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			local var_42_0 = "ST27"

			if arg_39_1.bgs_[var_42_0] == nil then
				local var_42_1 = Object.Instantiate(arg_39_1.paintGo_)

				var_42_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_42_0)
				var_42_1.name = var_42_0
				var_42_1.transform.parent = arg_39_1.stage_.transform
				var_42_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_39_1.bgs_[var_42_0] = var_42_1
			end

			local var_42_2 = 2

			if var_42_2 < arg_39_1.time_ and arg_39_1.time_ <= var_42_2 + arg_42_0 then
				local var_42_3 = manager.ui.mainCamera.transform.localPosition
				local var_42_4 = Vector3.New(0, 0, 10) + Vector3.New(var_42_3.x, var_42_3.y, 0)
				local var_42_5 = arg_39_1.bgs_.ST27

				var_42_5.transform.localPosition = var_42_4
				var_42_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_42_6 = var_42_5:GetComponent("SpriteRenderer")

				if var_42_6 and var_42_6.sprite then
					local var_42_7 = (var_42_5.transform.localPosition - var_42_3).z
					local var_42_8 = manager.ui.mainCameraCom_
					local var_42_9 = 2 * var_42_7 * Mathf.Tan(var_42_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_42_10 = var_42_9 * var_42_8.aspect
					local var_42_11 = var_42_6.sprite.bounds.size.x
					local var_42_12 = var_42_6.sprite.bounds.size.y
					local var_42_13 = var_42_10 / var_42_11
					local var_42_14 = var_42_9 / var_42_12
					local var_42_15 = var_42_14 < var_42_13 and var_42_13 or var_42_14

					var_42_5.transform.localScale = Vector3.New(var_42_15, var_42_15, 0)
				end

				for iter_42_0, iter_42_1 in pairs(arg_39_1.bgs_) do
					if iter_42_0 ~= "ST27" then
						iter_42_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_42_16 = 0

			if var_42_16 < arg_39_1.time_ and arg_39_1.time_ <= var_42_16 + arg_42_0 then
				arg_39_1.mask_.enabled = true
				arg_39_1.mask_.raycastTarget = false

				arg_39_1:SetGaussion(false)
			end

			local var_42_17 = 2

			if var_42_16 <= arg_39_1.time_ and arg_39_1.time_ < var_42_16 + var_42_17 then
				local var_42_18 = (arg_39_1.time_ - var_42_16) / var_42_17
				local var_42_19 = Color.New(0, 0, 0)

				var_42_19.a = Mathf.Lerp(0, 1, var_42_18)
				arg_39_1.mask_.color = var_42_19
			end

			if arg_39_1.time_ >= var_42_16 + var_42_17 and arg_39_1.time_ < var_42_16 + var_42_17 + arg_42_0 then
				local var_42_20 = Color.New(0, 0, 0)

				var_42_20.a = 1
				arg_39_1.mask_.color = var_42_20
			end

			local var_42_21 = 2

			if var_42_21 < arg_39_1.time_ and arg_39_1.time_ <= var_42_21 + arg_42_0 then
				arg_39_1.mask_.enabled = true
				arg_39_1.mask_.raycastTarget = false

				arg_39_1:SetGaussion(false)
			end

			local var_42_22 = 2

			if var_42_21 <= arg_39_1.time_ and arg_39_1.time_ < var_42_21 + var_42_22 then
				local var_42_23 = (arg_39_1.time_ - var_42_21) / var_42_22
				local var_42_24 = Color.New(0, 0, 0)

				var_42_24.a = Mathf.Lerp(1, 0, var_42_23)
				arg_39_1.mask_.color = var_42_24
			end

			if arg_39_1.time_ >= var_42_21 + var_42_22 and arg_39_1.time_ < var_42_21 + var_42_22 + arg_42_0 then
				local var_42_25 = Color.New(0, 0, 0)
				local var_42_26 = 0

				arg_39_1.mask_.enabled = false
				var_42_25.a = var_42_26
				arg_39_1.mask_.color = var_42_25
			end

			local var_42_27 = "10030"

			if arg_39_1.actors_[var_42_27] == nil then
				local var_42_28 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10030")

				if not isNil(var_42_28) then
					local var_42_29 = Object.Instantiate(var_42_28, arg_39_1.canvasGo_.transform)

					var_42_29.transform:SetSiblingIndex(1)

					var_42_29.name = var_42_27
					var_42_29.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_39_1.actors_[var_42_27] = var_42_29

					local var_42_30 = var_42_29:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_39_1.isInRecall_ then
						for iter_42_2, iter_42_3 in ipairs(var_42_30) do
							iter_42_3.color = arg_39_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_42_31 = arg_39_1.actors_["10030"].transform
			local var_42_32 = 4

			if var_42_32 < arg_39_1.time_ and arg_39_1.time_ <= var_42_32 + arg_42_0 then
				arg_39_1.var_.moveOldPos10030 = var_42_31.localPosition
				var_42_31.localScale = Vector3.New(1, 1, 1)

				arg_39_1:CheckSpriteTmpPos("10030", 3)

				local var_42_33 = var_42_31.childCount

				for iter_42_4 = 0, var_42_33 - 1 do
					local var_42_34 = var_42_31:GetChild(iter_42_4)

					if var_42_34.name == "split_3" or not string.find(var_42_34.name, "split") then
						var_42_34.gameObject:SetActive(true)
					else
						var_42_34.gameObject:SetActive(false)
					end
				end
			end

			local var_42_35 = 0.001

			if var_42_32 <= arg_39_1.time_ and arg_39_1.time_ < var_42_32 + var_42_35 then
				local var_42_36 = (arg_39_1.time_ - var_42_32) / var_42_35
				local var_42_37 = Vector3.New(0, -390, 150)

				var_42_31.localPosition = Vector3.Lerp(arg_39_1.var_.moveOldPos10030, var_42_37, var_42_36)
			end

			if arg_39_1.time_ >= var_42_32 + var_42_35 and arg_39_1.time_ < var_42_32 + var_42_35 + arg_42_0 then
				var_42_31.localPosition = Vector3.New(0, -390, 150)
			end

			local var_42_38 = arg_39_1.actors_["10030"]
			local var_42_39 = 4

			if var_42_39 < arg_39_1.time_ and arg_39_1.time_ <= var_42_39 + arg_42_0 then
				local var_42_40 = var_42_38:GetComponentInChildren(typeof(CanvasGroup))

				if var_42_40 then
					arg_39_1.var_.alphaOldValue10030 = var_42_40.alpha
					arg_39_1.var_.characterEffect10030 = var_42_40
				end

				arg_39_1.var_.alphaOldValue10030 = 0
			end

			local var_42_41 = 0.333333333333333

			if var_42_39 <= arg_39_1.time_ and arg_39_1.time_ < var_42_39 + var_42_41 then
				local var_42_42 = (arg_39_1.time_ - var_42_39) / var_42_41
				local var_42_43 = Mathf.Lerp(arg_39_1.var_.alphaOldValue10030, 1, var_42_42)

				if arg_39_1.var_.characterEffect10030 then
					arg_39_1.var_.characterEffect10030.alpha = var_42_43
				end
			end

			if arg_39_1.time_ >= var_42_39 + var_42_41 and arg_39_1.time_ < var_42_39 + var_42_41 + arg_42_0 and arg_39_1.var_.characterEffect10030 then
				arg_39_1.var_.characterEffect10030.alpha = 1
			end

			local var_42_44 = arg_39_1.actors_["10030"]
			local var_42_45 = 4

			if var_42_45 < arg_39_1.time_ and arg_39_1.time_ <= var_42_45 + arg_42_0 and not isNil(var_42_44) and arg_39_1.var_.actorSpriteComps10030 == nil then
				arg_39_1.var_.actorSpriteComps10030 = var_42_44:GetComponentsInChildren(typeof(Image), true)
			end

			local var_42_46 = 0.2

			if var_42_45 <= arg_39_1.time_ and arg_39_1.time_ < var_42_45 + var_42_46 and not isNil(var_42_44) then
				local var_42_47 = (arg_39_1.time_ - var_42_45) / var_42_46

				if arg_39_1.var_.actorSpriteComps10030 then
					for iter_42_5, iter_42_6 in pairs(arg_39_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_42_6 then
							if arg_39_1.isInRecall_ then
								local var_42_48 = Mathf.Lerp(iter_42_6.color.r, arg_39_1.hightColor1.r, var_42_47)
								local var_42_49 = Mathf.Lerp(iter_42_6.color.g, arg_39_1.hightColor1.g, var_42_47)
								local var_42_50 = Mathf.Lerp(iter_42_6.color.b, arg_39_1.hightColor1.b, var_42_47)

								iter_42_6.color = Color.New(var_42_48, var_42_49, var_42_50)
							else
								local var_42_51 = Mathf.Lerp(iter_42_6.color.r, 1, var_42_47)

								iter_42_6.color = Color.New(var_42_51, var_42_51, var_42_51)
							end
						end
					end
				end
			end

			if arg_39_1.time_ >= var_42_45 + var_42_46 and arg_39_1.time_ < var_42_45 + var_42_46 + arg_42_0 and not isNil(var_42_44) and arg_39_1.var_.actorSpriteComps10030 then
				for iter_42_7, iter_42_8 in pairs(arg_39_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_42_8 then
						if arg_39_1.isInRecall_ then
							iter_42_8.color = arg_39_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_42_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_39_1.var_.actorSpriteComps10030 = nil
			end

			if arg_39_1.frameCnt_ <= 1 then
				arg_39_1.dialog_:SetActive(false)
			end

			local var_42_52 = 4
			local var_42_53 = 0.225

			if var_42_52 < arg_39_1.time_ and arg_39_1.time_ <= var_42_52 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0

				arg_39_1.dialog_:SetActive(true)

				arg_39_1.dialogCg_.alpha = 0

				local var_42_54 = LeanTween.value(arg_39_1.dialog_, 0, 1, 0.3)

				var_42_54:setOnUpdate(LuaHelper.FloatAction(function(arg_43_0)
					arg_39_1.dialogCg_.alpha = arg_43_0
				end))
				var_42_54:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_39_1.dialog_)
					var_42_54:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_39_1.duration_ = arg_39_1.duration_ + 0.3

				SetActive(arg_39_1.leftNameGo_, true)

				local var_42_55 = arg_39_1:FormatText(StoryNameCfg[309].name)

				arg_39_1.leftNameTxt_.text = var_42_55

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_39_1.leftNameTxt_.transform)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1.leftNameTxt_.text)
				SetActive(arg_39_1.iconTrs_.gameObject, false)
				arg_39_1.callingController_:SetSelectedState("normal")

				local var_42_56 = arg_39_1:GetWordFromCfg(115281009)
				local var_42_57 = arg_39_1:FormatText(var_42_56.content)

				arg_39_1.text_.text = var_42_57

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_58 = 9
				local var_42_59 = utf8.len(var_42_57)
				local var_42_60 = var_42_58 <= 0 and var_42_53 or var_42_53 * (var_42_59 / var_42_58)

				if var_42_60 > 0 and var_42_53 < var_42_60 then
					arg_39_1.talkMaxDuration = var_42_60
					var_42_52 = var_42_52 + 0.3

					if var_42_60 + var_42_52 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_60 + var_42_52
					end
				end

				arg_39_1.text_.text = var_42_57
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115281", "115281009", "story_v_out_115281.awb") ~= 0 then
					local var_42_61 = manager.audio:GetVoiceLength("story_v_out_115281", "115281009", "story_v_out_115281.awb") / 1000

					if var_42_61 + var_42_52 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_61 + var_42_52
					end

					if var_42_56.prefab_name ~= "" and arg_39_1.actors_[var_42_56.prefab_name] ~= nil then
						local var_42_62 = LuaForUtil.PlayVoiceWithCriLipsync(arg_39_1.actors_[var_42_56.prefab_name].transform, "story_v_out_115281", "115281009", "story_v_out_115281.awb")

						arg_39_1:RecordAudio("115281009", var_42_62)
						arg_39_1:RecordAudio("115281009", var_42_62)
					else
						arg_39_1:AudioAction("play", "voice", "story_v_out_115281", "115281009", "story_v_out_115281.awb")
					end

					arg_39_1:RecordHistoryTalkVoice("story_v_out_115281", "115281009", "story_v_out_115281.awb")
				end

				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_63 = var_42_52 + 0.3
			local var_42_64 = math.max(var_42_53, arg_39_1.talkMaxDuration)

			if var_42_63 <= arg_39_1.time_ and arg_39_1.time_ < var_42_63 + var_42_64 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_63) / var_42_64

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_63 + var_42_64 and arg_39_1.time_ < var_42_63 + var_42_64 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10030",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_39_1:InitPlayNodeList()
	end,
	Play115281010 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 115281010
		arg_45_1.duration_ = 5

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play115281011(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = arg_45_1.actors_["10030"]
			local var_48_1 = 0

			if var_48_1 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 and not isNil(var_48_0) and arg_45_1.var_.actorSpriteComps10030 == nil then
				arg_45_1.var_.actorSpriteComps10030 = var_48_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_48_2 = 0.2

			if var_48_1 <= arg_45_1.time_ and arg_45_1.time_ < var_48_1 + var_48_2 and not isNil(var_48_0) then
				local var_48_3 = (arg_45_1.time_ - var_48_1) / var_48_2

				if arg_45_1.var_.actorSpriteComps10030 then
					for iter_48_0, iter_48_1 in pairs(arg_45_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_48_1 then
							if arg_45_1.isInRecall_ then
								local var_48_4 = Mathf.Lerp(iter_48_1.color.r, arg_45_1.hightColor2.r, var_48_3)
								local var_48_5 = Mathf.Lerp(iter_48_1.color.g, arg_45_1.hightColor2.g, var_48_3)
								local var_48_6 = Mathf.Lerp(iter_48_1.color.b, arg_45_1.hightColor2.b, var_48_3)

								iter_48_1.color = Color.New(var_48_4, var_48_5, var_48_6)
							else
								local var_48_7 = Mathf.Lerp(iter_48_1.color.r, 0.5, var_48_3)

								iter_48_1.color = Color.New(var_48_7, var_48_7, var_48_7)
							end
						end
					end
				end
			end

			if arg_45_1.time_ >= var_48_1 + var_48_2 and arg_45_1.time_ < var_48_1 + var_48_2 + arg_48_0 and not isNil(var_48_0) and arg_45_1.var_.actorSpriteComps10030 then
				for iter_48_2, iter_48_3 in pairs(arg_45_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_48_3 then
						if arg_45_1.isInRecall_ then
							iter_48_3.color = arg_45_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_48_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_45_1.var_.actorSpriteComps10030 = nil
			end

			local var_48_8 = 0
			local var_48_9 = 1.275

			if var_48_8 < arg_45_1.time_ and arg_45_1.time_ <= var_48_8 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, false)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_10 = arg_45_1:GetWordFromCfg(115281010)
				local var_48_11 = arg_45_1:FormatText(var_48_10.content)

				arg_45_1.text_.text = var_48_11

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_12 = 51
				local var_48_13 = utf8.len(var_48_11)
				local var_48_14 = var_48_12 <= 0 and var_48_9 or var_48_9 * (var_48_13 / var_48_12)

				if var_48_14 > 0 and var_48_9 < var_48_14 then
					arg_45_1.talkMaxDuration = var_48_14

					if var_48_14 + var_48_8 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_14 + var_48_8
					end
				end

				arg_45_1.text_.text = var_48_11
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)
				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_15 = math.max(var_48_9, arg_45_1.talkMaxDuration)

			if var_48_8 <= arg_45_1.time_ and arg_45_1.time_ < var_48_8 + var_48_15 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_8) / var_48_15

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_8 + var_48_15 and arg_45_1.time_ < var_48_8 + var_48_15 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play115281011 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 115281011
		arg_49_1.duration_ = 9.93

		local var_49_0 = {
			ja = 8.266,
			ko = 8.9,
			zh = 8.4,
			en = 9.933
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
				arg_49_0:Play115281012(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = arg_49_1.actors_["10030"]
			local var_52_1 = 0

			if var_52_1 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.actorSpriteComps10030 == nil then
				arg_49_1.var_.actorSpriteComps10030 = var_52_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_52_2 = 0.2

			if var_52_1 <= arg_49_1.time_ and arg_49_1.time_ < var_52_1 + var_52_2 and not isNil(var_52_0) then
				local var_52_3 = (arg_49_1.time_ - var_52_1) / var_52_2

				if arg_49_1.var_.actorSpriteComps10030 then
					for iter_52_0, iter_52_1 in pairs(arg_49_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_52_1 then
							if arg_49_1.isInRecall_ then
								local var_52_4 = Mathf.Lerp(iter_52_1.color.r, arg_49_1.hightColor1.r, var_52_3)
								local var_52_5 = Mathf.Lerp(iter_52_1.color.g, arg_49_1.hightColor1.g, var_52_3)
								local var_52_6 = Mathf.Lerp(iter_52_1.color.b, arg_49_1.hightColor1.b, var_52_3)

								iter_52_1.color = Color.New(var_52_4, var_52_5, var_52_6)
							else
								local var_52_7 = Mathf.Lerp(iter_52_1.color.r, 1, var_52_3)

								iter_52_1.color = Color.New(var_52_7, var_52_7, var_52_7)
							end
						end
					end
				end
			end

			if arg_49_1.time_ >= var_52_1 + var_52_2 and arg_49_1.time_ < var_52_1 + var_52_2 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.actorSpriteComps10030 then
				for iter_52_2, iter_52_3 in pairs(arg_49_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_52_3 then
						if arg_49_1.isInRecall_ then
							iter_52_3.color = arg_49_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_52_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_49_1.var_.actorSpriteComps10030 = nil
			end

			local var_52_8 = arg_49_1.actors_["10030"].transform
			local var_52_9 = 0

			if var_52_9 < arg_49_1.time_ and arg_49_1.time_ <= var_52_9 + arg_52_0 then
				arg_49_1.var_.moveOldPos10030 = var_52_8.localPosition
				var_52_8.localScale = Vector3.New(1, 1, 1)

				arg_49_1:CheckSpriteTmpPos("10030", 3)

				local var_52_10 = var_52_8.childCount

				for iter_52_4 = 0, var_52_10 - 1 do
					local var_52_11 = var_52_8:GetChild(iter_52_4)

					if var_52_11.name == "split_1" or not string.find(var_52_11.name, "split") then
						var_52_11.gameObject:SetActive(true)
					else
						var_52_11.gameObject:SetActive(false)
					end
				end
			end

			local var_52_12 = 0.001

			if var_52_9 <= arg_49_1.time_ and arg_49_1.time_ < var_52_9 + var_52_12 then
				local var_52_13 = (arg_49_1.time_ - var_52_9) / var_52_12
				local var_52_14 = Vector3.New(0, -390, 150)

				var_52_8.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos10030, var_52_14, var_52_13)
			end

			if arg_49_1.time_ >= var_52_9 + var_52_12 and arg_49_1.time_ < var_52_9 + var_52_12 + arg_52_0 then
				var_52_8.localPosition = Vector3.New(0, -390, 150)
			end

			local var_52_15 = 0
			local var_52_16 = 0.75

			if var_52_15 < arg_49_1.time_ and arg_49_1.time_ <= var_52_15 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_17 = arg_49_1:FormatText(StoryNameCfg[309].name)

				arg_49_1.leftNameTxt_.text = var_52_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_18 = arg_49_1:GetWordFromCfg(115281011)
				local var_52_19 = arg_49_1:FormatText(var_52_18.content)

				arg_49_1.text_.text = var_52_19

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_20 = 30
				local var_52_21 = utf8.len(var_52_19)
				local var_52_22 = var_52_20 <= 0 and var_52_16 or var_52_16 * (var_52_21 / var_52_20)

				if var_52_22 > 0 and var_52_16 < var_52_22 then
					arg_49_1.talkMaxDuration = var_52_22

					if var_52_22 + var_52_15 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_22 + var_52_15
					end
				end

				arg_49_1.text_.text = var_52_19
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115281", "115281011", "story_v_out_115281.awb") ~= 0 then
					local var_52_23 = manager.audio:GetVoiceLength("story_v_out_115281", "115281011", "story_v_out_115281.awb") / 1000

					if var_52_23 + var_52_15 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_23 + var_52_15
					end

					if var_52_18.prefab_name ~= "" and arg_49_1.actors_[var_52_18.prefab_name] ~= nil then
						local var_52_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_18.prefab_name].transform, "story_v_out_115281", "115281011", "story_v_out_115281.awb")

						arg_49_1:RecordAudio("115281011", var_52_24)
						arg_49_1:RecordAudio("115281011", var_52_24)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_115281", "115281011", "story_v_out_115281.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_115281", "115281011", "story_v_out_115281.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_25 = math.max(var_52_16, arg_49_1.talkMaxDuration)

			if var_52_15 <= arg_49_1.time_ and arg_49_1.time_ < var_52_15 + var_52_25 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_15) / var_52_25

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_15 + var_52_25 and arg_49_1.time_ < var_52_15 + var_52_25 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {
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

		arg_49_1:InitPlayNodeList()
	end,
	Play115281012 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 115281012
		arg_53_1.duration_ = 24.63

		local var_53_0 = {
			ja = 24.633,
			ko = 15.1,
			zh = 14.3,
			en = 13.8
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
				arg_53_0:Play115281013(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 0
			local var_56_1 = 1.075

			if var_56_0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_0 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_2 = arg_53_1:FormatText(StoryNameCfg[309].name)

				arg_53_1.leftNameTxt_.text = var_56_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_3 = arg_53_1:GetWordFromCfg(115281012)
				local var_56_4 = arg_53_1:FormatText(var_56_3.content)

				arg_53_1.text_.text = var_56_4

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_5 = 43
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

				if manager.audio:GetVoiceLength("story_v_out_115281", "115281012", "story_v_out_115281.awb") ~= 0 then
					local var_56_8 = manager.audio:GetVoiceLength("story_v_out_115281", "115281012", "story_v_out_115281.awb") / 1000

					if var_56_8 + var_56_0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_8 + var_56_0
					end

					if var_56_3.prefab_name ~= "" and arg_53_1.actors_[var_56_3.prefab_name] ~= nil then
						local var_56_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_3.prefab_name].transform, "story_v_out_115281", "115281012", "story_v_out_115281.awb")

						arg_53_1:RecordAudio("115281012", var_56_9)
						arg_53_1:RecordAudio("115281012", var_56_9)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_115281", "115281012", "story_v_out_115281.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_115281", "115281012", "story_v_out_115281.awb")
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
	Play115281013 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 115281013
		arg_57_1.duration_ = 5

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play115281014(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = arg_57_1.actors_["10030"]
			local var_60_1 = 0

			if var_60_1 < arg_57_1.time_ and arg_57_1.time_ <= var_60_1 + arg_60_0 and not isNil(var_60_0) and arg_57_1.var_.actorSpriteComps10030 == nil then
				arg_57_1.var_.actorSpriteComps10030 = var_60_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_60_2 = 0.2

			if var_60_1 <= arg_57_1.time_ and arg_57_1.time_ < var_60_1 + var_60_2 and not isNil(var_60_0) then
				local var_60_3 = (arg_57_1.time_ - var_60_1) / var_60_2

				if arg_57_1.var_.actorSpriteComps10030 then
					for iter_60_0, iter_60_1 in pairs(arg_57_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_60_1 then
							if arg_57_1.isInRecall_ then
								local var_60_4 = Mathf.Lerp(iter_60_1.color.r, arg_57_1.hightColor2.r, var_60_3)
								local var_60_5 = Mathf.Lerp(iter_60_1.color.g, arg_57_1.hightColor2.g, var_60_3)
								local var_60_6 = Mathf.Lerp(iter_60_1.color.b, arg_57_1.hightColor2.b, var_60_3)

								iter_60_1.color = Color.New(var_60_4, var_60_5, var_60_6)
							else
								local var_60_7 = Mathf.Lerp(iter_60_1.color.r, 0.5, var_60_3)

								iter_60_1.color = Color.New(var_60_7, var_60_7, var_60_7)
							end
						end
					end
				end
			end

			if arg_57_1.time_ >= var_60_1 + var_60_2 and arg_57_1.time_ < var_60_1 + var_60_2 + arg_60_0 and not isNil(var_60_0) and arg_57_1.var_.actorSpriteComps10030 then
				for iter_60_2, iter_60_3 in pairs(arg_57_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_60_3 then
						if arg_57_1.isInRecall_ then
							iter_60_3.color = arg_57_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_60_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_57_1.var_.actorSpriteComps10030 = nil
			end

			local var_60_8 = arg_57_1.actors_["10030"].transform
			local var_60_9 = 0

			if var_60_9 < arg_57_1.time_ and arg_57_1.time_ <= var_60_9 + arg_60_0 then
				arg_57_1.var_.moveOldPos10030 = var_60_8.localPosition
				var_60_8.localScale = Vector3.New(1, 1, 1)

				arg_57_1:CheckSpriteTmpPos("10030", 3)

				local var_60_10 = var_60_8.childCount

				for iter_60_4 = 0, var_60_10 - 1 do
					local var_60_11 = var_60_8:GetChild(iter_60_4)

					if var_60_11.name == "split_2" or not string.find(var_60_11.name, "split") then
						var_60_11.gameObject:SetActive(true)
					else
						var_60_11.gameObject:SetActive(false)
					end
				end
			end

			local var_60_12 = 0.001

			if var_60_9 <= arg_57_1.time_ and arg_57_1.time_ < var_60_9 + var_60_12 then
				local var_60_13 = (arg_57_1.time_ - var_60_9) / var_60_12
				local var_60_14 = Vector3.New(0, -390, 150)

				var_60_8.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos10030, var_60_14, var_60_13)
			end

			if arg_57_1.time_ >= var_60_9 + var_60_12 and arg_57_1.time_ < var_60_9 + var_60_12 + arg_60_0 then
				var_60_8.localPosition = Vector3.New(0, -390, 150)
			end

			local var_60_15 = 0
			local var_60_16 = 0.95

			if var_60_15 < arg_57_1.time_ and arg_57_1.time_ <= var_60_15 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, false)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_17 = arg_57_1:GetWordFromCfg(115281013)
				local var_60_18 = arg_57_1:FormatText(var_60_17.content)

				arg_57_1.text_.text = var_60_18

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_19 = 38
				local var_60_20 = utf8.len(var_60_18)
				local var_60_21 = var_60_19 <= 0 and var_60_16 or var_60_16 * (var_60_20 / var_60_19)

				if var_60_21 > 0 and var_60_16 < var_60_21 then
					arg_57_1.talkMaxDuration = var_60_21

					if var_60_21 + var_60_15 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_21 + var_60_15
					end
				end

				arg_57_1.text_.text = var_60_18
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)
				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_22 = math.max(var_60_16, arg_57_1.talkMaxDuration)

			if var_60_15 <= arg_57_1.time_ and arg_57_1.time_ < var_60_15 + var_60_22 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_15) / var_60_22

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_15 + var_60_22 and arg_57_1.time_ < var_60_15 + var_60_22 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {
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

		arg_57_1:InitPlayNodeList()
	end,
	Play115281014 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 115281014
		arg_61_1.duration_ = 3.53

		local var_61_0 = {
			ja = 3.533,
			ko = 1.933,
			zh = 2.9,
			en = 2.233
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
				arg_61_0:Play115281015(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = arg_61_1.actors_["10030"]
			local var_64_1 = 0

			if var_64_1 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 and not isNil(var_64_0) and arg_61_1.var_.actorSpriteComps10030 == nil then
				arg_61_1.var_.actorSpriteComps10030 = var_64_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_64_2 = 0.2

			if var_64_1 <= arg_61_1.time_ and arg_61_1.time_ < var_64_1 + var_64_2 and not isNil(var_64_0) then
				local var_64_3 = (arg_61_1.time_ - var_64_1) / var_64_2

				if arg_61_1.var_.actorSpriteComps10030 then
					for iter_64_0, iter_64_1 in pairs(arg_61_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_64_1 then
							if arg_61_1.isInRecall_ then
								local var_64_4 = Mathf.Lerp(iter_64_1.color.r, arg_61_1.hightColor1.r, var_64_3)
								local var_64_5 = Mathf.Lerp(iter_64_1.color.g, arg_61_1.hightColor1.g, var_64_3)
								local var_64_6 = Mathf.Lerp(iter_64_1.color.b, arg_61_1.hightColor1.b, var_64_3)

								iter_64_1.color = Color.New(var_64_4, var_64_5, var_64_6)
							else
								local var_64_7 = Mathf.Lerp(iter_64_1.color.r, 1, var_64_3)

								iter_64_1.color = Color.New(var_64_7, var_64_7, var_64_7)
							end
						end
					end
				end
			end

			if arg_61_1.time_ >= var_64_1 + var_64_2 and arg_61_1.time_ < var_64_1 + var_64_2 + arg_64_0 and not isNil(var_64_0) and arg_61_1.var_.actorSpriteComps10030 then
				for iter_64_2, iter_64_3 in pairs(arg_61_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_64_3 then
						if arg_61_1.isInRecall_ then
							iter_64_3.color = arg_61_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_64_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_61_1.var_.actorSpriteComps10030 = nil
			end

			local var_64_8 = 0
			local var_64_9 = 0.125

			if var_64_8 < arg_61_1.time_ and arg_61_1.time_ <= var_64_8 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_10 = arg_61_1:FormatText(StoryNameCfg[309].name)

				arg_61_1.leftNameTxt_.text = var_64_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_11 = arg_61_1:GetWordFromCfg(115281014)
				local var_64_12 = arg_61_1:FormatText(var_64_11.content)

				arg_61_1.text_.text = var_64_12

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_13 = 5
				local var_64_14 = utf8.len(var_64_12)
				local var_64_15 = var_64_13 <= 0 and var_64_9 or var_64_9 * (var_64_14 / var_64_13)

				if var_64_15 > 0 and var_64_9 < var_64_15 then
					arg_61_1.talkMaxDuration = var_64_15

					if var_64_15 + var_64_8 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_15 + var_64_8
					end
				end

				arg_61_1.text_.text = var_64_12
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115281", "115281014", "story_v_out_115281.awb") ~= 0 then
					local var_64_16 = manager.audio:GetVoiceLength("story_v_out_115281", "115281014", "story_v_out_115281.awb") / 1000

					if var_64_16 + var_64_8 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_16 + var_64_8
					end

					if var_64_11.prefab_name ~= "" and arg_61_1.actors_[var_64_11.prefab_name] ~= nil then
						local var_64_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_11.prefab_name].transform, "story_v_out_115281", "115281014", "story_v_out_115281.awb")

						arg_61_1:RecordAudio("115281014", var_64_17)
						arg_61_1:RecordAudio("115281014", var_64_17)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_115281", "115281014", "story_v_out_115281.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_115281", "115281014", "story_v_out_115281.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_18 = math.max(var_64_9, arg_61_1.talkMaxDuration)

			if var_64_8 <= arg_61_1.time_ and arg_61_1.time_ < var_64_8 + var_64_18 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_8) / var_64_18

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_8 + var_64_18 and arg_61_1.time_ < var_64_8 + var_64_18 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play115281015 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 115281015
		arg_65_1.duration_ = 5

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play115281016(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = arg_65_1.actors_["10030"]
			local var_68_1 = 0

			if var_68_1 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 then
				local var_68_2 = var_68_0:GetComponentInChildren(typeof(CanvasGroup))

				if var_68_2 then
					arg_65_1.var_.alphaOldValue10030 = var_68_2.alpha
					arg_65_1.var_.characterEffect10030 = var_68_2
				end

				arg_65_1.var_.alphaOldValue10030 = 1
			end

			local var_68_3 = 0.333333333333333

			if var_68_1 <= arg_65_1.time_ and arg_65_1.time_ < var_68_1 + var_68_3 then
				local var_68_4 = (arg_65_1.time_ - var_68_1) / var_68_3
				local var_68_5 = Mathf.Lerp(arg_65_1.var_.alphaOldValue10030, 0, var_68_4)

				if arg_65_1.var_.characterEffect10030 then
					arg_65_1.var_.characterEffect10030.alpha = var_68_5
				end
			end

			if arg_65_1.time_ >= var_68_1 + var_68_3 and arg_65_1.time_ < var_68_1 + var_68_3 + arg_68_0 and arg_65_1.var_.characterEffect10030 then
				arg_65_1.var_.characterEffect10030.alpha = 0
			end

			local var_68_6 = 0
			local var_68_7 = 1.35

			if var_68_6 < arg_65_1.time_ and arg_65_1.time_ <= var_68_6 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, false)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_8 = arg_65_1:GetWordFromCfg(115281015)
				local var_68_9 = arg_65_1:FormatText(var_68_8.content)

				arg_65_1.text_.text = var_68_9

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_10 = 54
				local var_68_11 = utf8.len(var_68_9)
				local var_68_12 = var_68_10 <= 0 and var_68_7 or var_68_7 * (var_68_11 / var_68_10)

				if var_68_12 > 0 and var_68_7 < var_68_12 then
					arg_65_1.talkMaxDuration = var_68_12

					if var_68_12 + var_68_6 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_12 + var_68_6
					end
				end

				arg_65_1.text_.text = var_68_9
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)
				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_13 = math.max(var_68_7, arg_65_1.talkMaxDuration)

			if var_68_6 <= arg_65_1.time_ and arg_65_1.time_ < var_68_6 + var_68_13 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_6) / var_68_13

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_6 + var_68_13 and arg_65_1.time_ < var_68_6 + var_68_13 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play115281016 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 115281016
		arg_69_1.duration_ = 14.7

		local var_69_0 = {
			ja = 14.7,
			ko = 8.333,
			zh = 8.133,
			en = 11.6
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
				arg_69_0:Play115281017(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = "ST28a"

			if arg_69_1.bgs_[var_72_0] == nil then
				local var_72_1 = Object.Instantiate(arg_69_1.paintGo_)

				var_72_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_72_0)
				var_72_1.name = var_72_0
				var_72_1.transform.parent = arg_69_1.stage_.transform
				var_72_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_69_1.bgs_[var_72_0] = var_72_1
			end

			local var_72_2 = 2

			if var_72_2 < arg_69_1.time_ and arg_69_1.time_ <= var_72_2 + arg_72_0 then
				local var_72_3 = manager.ui.mainCamera.transform.localPosition
				local var_72_4 = Vector3.New(0, 0, 10) + Vector3.New(var_72_3.x, var_72_3.y, 0)
				local var_72_5 = arg_69_1.bgs_.ST28a

				var_72_5.transform.localPosition = var_72_4
				var_72_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_72_6 = var_72_5:GetComponent("SpriteRenderer")

				if var_72_6 and var_72_6.sprite then
					local var_72_7 = (var_72_5.transform.localPosition - var_72_3).z
					local var_72_8 = manager.ui.mainCameraCom_
					local var_72_9 = 2 * var_72_7 * Mathf.Tan(var_72_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_72_10 = var_72_9 * var_72_8.aspect
					local var_72_11 = var_72_6.sprite.bounds.size.x
					local var_72_12 = var_72_6.sprite.bounds.size.y
					local var_72_13 = var_72_10 / var_72_11
					local var_72_14 = var_72_9 / var_72_12
					local var_72_15 = var_72_14 < var_72_13 and var_72_13 or var_72_14

					var_72_5.transform.localScale = Vector3.New(var_72_15, var_72_15, 0)
				end

				for iter_72_0, iter_72_1 in pairs(arg_69_1.bgs_) do
					if iter_72_0 ~= "ST28a" then
						iter_72_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_72_16 = 0

			if var_72_16 < arg_69_1.time_ and arg_69_1.time_ <= var_72_16 + arg_72_0 then
				arg_69_1.mask_.enabled = true
				arg_69_1.mask_.raycastTarget = false

				arg_69_1:SetGaussion(false)
			end

			local var_72_17 = 2

			if var_72_16 <= arg_69_1.time_ and arg_69_1.time_ < var_72_16 + var_72_17 then
				local var_72_18 = (arg_69_1.time_ - var_72_16) / var_72_17
				local var_72_19 = Color.New(0, 0, 0)

				var_72_19.a = Mathf.Lerp(0, 1, var_72_18)
				arg_69_1.mask_.color = var_72_19
			end

			if arg_69_1.time_ >= var_72_16 + var_72_17 and arg_69_1.time_ < var_72_16 + var_72_17 + arg_72_0 then
				local var_72_20 = Color.New(0, 0, 0)

				var_72_20.a = 1
				arg_69_1.mask_.color = var_72_20
			end

			local var_72_21 = 2

			if var_72_21 < arg_69_1.time_ and arg_69_1.time_ <= var_72_21 + arg_72_0 then
				arg_69_1.mask_.enabled = true
				arg_69_1.mask_.raycastTarget = false

				arg_69_1:SetGaussion(false)
			end

			local var_72_22 = 2

			if var_72_21 <= arg_69_1.time_ and arg_69_1.time_ < var_72_21 + var_72_22 then
				local var_72_23 = (arg_69_1.time_ - var_72_21) / var_72_22
				local var_72_24 = Color.New(0, 0, 0)

				var_72_24.a = Mathf.Lerp(1, 0, var_72_23)
				arg_69_1.mask_.color = var_72_24
			end

			if arg_69_1.time_ >= var_72_21 + var_72_22 and arg_69_1.time_ < var_72_21 + var_72_22 + arg_72_0 then
				local var_72_25 = Color.New(0, 0, 0)
				local var_72_26 = 0

				arg_69_1.mask_.enabled = false
				var_72_25.a = var_72_26
				arg_69_1.mask_.color = var_72_25
			end

			local var_72_27 = 0

			arg_69_1.isInRecall_ = false

			if var_72_27 < arg_69_1.time_ and arg_69_1.time_ <= var_72_27 + arg_72_0 then
				arg_69_1.screenFilterGo_:SetActive(true)

				arg_69_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile")

				for iter_72_2, iter_72_3 in pairs(arg_69_1.actors_) do
					local var_72_28 = iter_72_3:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_72_4, iter_72_5 in ipairs(var_72_28) do
						if iter_72_5.color.r > 0.51 then
							iter_72_5.color = Color.New(1, 1, 1)
						else
							iter_72_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end
			end

			local var_72_29 = 4

			if var_72_27 <= arg_69_1.time_ and arg_69_1.time_ < var_72_27 + var_72_29 then
				local var_72_30 = (arg_69_1.time_ - var_72_27) / var_72_29

				arg_69_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, var_72_30)
			end

			if arg_69_1.time_ >= var_72_27 + var_72_29 and arg_69_1.time_ < var_72_27 + var_72_29 + arg_72_0 then
				arg_69_1.screenFilterEffect_.weight = 1
			end

			local var_72_31 = "10029"

			if arg_69_1.actors_[var_72_31] == nil then
				local var_72_32 = Object.Instantiate(arg_69_1.imageGo_, arg_69_1.canvasGo_.transform)

				var_72_32.transform:SetSiblingIndex(1)

				var_72_32.name = var_72_31

				local var_72_33 = var_72_32:GetComponent(typeof(Image))

				var_72_33.sprite = getSpriteWithoutAtlas("TextureConfig/Character/Portrait/" .. "10029")

				var_72_33:SetNativeSize()

				var_72_32.transform.localPosition = Vector3.New(0, 100000, 0)
				arg_69_1.actors_[var_72_31] = var_72_32
			end

			local var_72_34 = arg_69_1.actors_["10029"].transform
			local var_72_35 = 3.99933333333333

			if var_72_35 < arg_69_1.time_ and arg_69_1.time_ <= var_72_35 + arg_72_0 then
				arg_69_1.var_.moveOldPos10029 = var_72_34.localPosition
				var_72_34.localScale = Vector3.New(1, 1, 1)

				arg_69_1:CheckSpriteTmpPos("10029", 3)
			end

			local var_72_36 = 0.001

			if var_72_35 <= arg_69_1.time_ and arg_69_1.time_ < var_72_35 + var_72_36 then
				local var_72_37 = (arg_69_1.time_ - var_72_35) / var_72_36
				local var_72_38 = Vector3.New(0, -350, -180)

				var_72_34.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos10029, var_72_38, var_72_37)
			end

			if arg_69_1.time_ >= var_72_35 + var_72_36 and arg_69_1.time_ < var_72_35 + var_72_36 + arg_72_0 then
				var_72_34.localPosition = Vector3.New(0, -350, -180)
			end

			local var_72_39 = arg_69_1.actors_["10029"]
			local var_72_40 = 3.69933333333333

			if var_72_40 < arg_69_1.time_ and arg_69_1.time_ <= var_72_40 + arg_72_0 then
				local var_72_41 = var_72_39:GetComponent("Image")

				if var_72_41 then
					arg_69_1.var_.alphaMatValue10029 = var_72_41
					arg_69_1.var_.alphaOldValue10029 = var_72_41.color.a
				end

				arg_69_1.var_.alphaOldValue10029 = 0
			end

			local var_72_42 = 0.334

			if var_72_40 <= arg_69_1.time_ and arg_69_1.time_ < var_72_40 + var_72_42 then
				local var_72_43 = (arg_69_1.time_ - var_72_40) / var_72_42
				local var_72_44 = Mathf.Lerp(arg_69_1.var_.alphaOldValue10029, 1, var_72_43)

				if arg_69_1.var_.alphaMatValue10029 then
					local var_72_45 = arg_69_1.var_.alphaMatValue10029.color

					var_72_45.a = var_72_44
					arg_69_1.var_.alphaMatValue10029.color = var_72_45
				end
			end

			if arg_69_1.time_ >= var_72_40 + var_72_42 and arg_69_1.time_ < var_72_40 + var_72_42 + arg_72_0 and arg_69_1.var_.alphaMatValue10029 then
				local var_72_46 = arg_69_1.var_.alphaMatValue10029
				local var_72_47 = var_72_46.color

				var_72_47.a = 1
				var_72_46.color = var_72_47
			end

			if arg_69_1.frameCnt_ <= 1 then
				arg_69_1.dialog_:SetActive(false)
			end

			local var_72_48 = 4
			local var_72_49 = 0.45

			if var_72_48 < arg_69_1.time_ and arg_69_1.time_ <= var_72_48 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0

				arg_69_1.dialog_:SetActive(true)

				arg_69_1.dialogCg_.alpha = 0

				local var_72_50 = LeanTween.value(arg_69_1.dialog_, 0, 1, 0.3)

				var_72_50:setOnUpdate(LuaHelper.FloatAction(function(arg_73_0)
					arg_69_1.dialogCg_.alpha = arg_73_0
				end))
				var_72_50:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_69_1.dialog_)
					var_72_50:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_69_1.duration_ = arg_69_1.duration_ + 0.3

				SetActive(arg_69_1.leftNameGo_, true)

				local var_72_51 = arg_69_1:FormatText(StoryNameCfg[312].name)

				arg_69_1.leftNameTxt_.text = var_72_51

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_52 = arg_69_1:GetWordFromCfg(115281016)
				local var_72_53 = arg_69_1:FormatText(var_72_52.content)

				arg_69_1.text_.text = var_72_53

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_54 = 18
				local var_72_55 = utf8.len(var_72_53)
				local var_72_56 = var_72_54 <= 0 and var_72_49 or var_72_49 * (var_72_55 / var_72_54)

				if var_72_56 > 0 and var_72_49 < var_72_56 then
					arg_69_1.talkMaxDuration = var_72_56
					var_72_48 = var_72_48 + 0.3

					if var_72_56 + var_72_48 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_56 + var_72_48
					end
				end

				arg_69_1.text_.text = var_72_53
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115281", "115281016", "story_v_out_115281.awb") ~= 0 then
					local var_72_57 = manager.audio:GetVoiceLength("story_v_out_115281", "115281016", "story_v_out_115281.awb") / 1000

					if var_72_57 + var_72_48 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_57 + var_72_48
					end

					if var_72_52.prefab_name ~= "" and arg_69_1.actors_[var_72_52.prefab_name] ~= nil then
						local var_72_58 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_52.prefab_name].transform, "story_v_out_115281", "115281016", "story_v_out_115281.awb")

						arg_69_1:RecordAudio("115281016", var_72_58)
						arg_69_1:RecordAudio("115281016", var_72_58)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_115281", "115281016", "story_v_out_115281.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_115281", "115281016", "story_v_out_115281.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_59 = var_72_48 + 0.3
			local var_72_60 = math.max(var_72_49, arg_69_1.talkMaxDuration)

			if var_72_59 <= arg_69_1.time_ and arg_69_1.time_ < var_72_59 + var_72_60 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_59) / var_72_60

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_59 + var_72_60 and arg_69_1.time_ < var_72_59 + var_72_60 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10029",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.99933333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Sprite
			}
		}

		arg_69_1:InitPlayNodeList()
	end,
	Play115281017 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 115281017
		arg_75_1.duration_ = 15.37

		local var_75_0 = {
			ja = 15.366,
			ko = 7.5,
			zh = 6.133,
			en = 7.2
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
				arg_75_0:Play115281018(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			local var_78_0 = 0
			local var_78_1 = 0.725

			if var_78_0 < arg_75_1.time_ and arg_75_1.time_ <= var_78_0 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				local var_78_2 = arg_75_1:FormatText(StoryNameCfg[312].name)

				arg_75_1.leftNameTxt_.text = var_78_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_3 = arg_75_1:GetWordFromCfg(115281017)
				local var_78_4 = arg_75_1:FormatText(var_78_3.content)

				arg_75_1.text_.text = var_78_4

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_5 = 29
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

				if manager.audio:GetVoiceLength("story_v_out_115281", "115281017", "story_v_out_115281.awb") ~= 0 then
					local var_78_8 = manager.audio:GetVoiceLength("story_v_out_115281", "115281017", "story_v_out_115281.awb") / 1000

					if var_78_8 + var_78_0 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_8 + var_78_0
					end

					if var_78_3.prefab_name ~= "" and arg_75_1.actors_[var_78_3.prefab_name] ~= nil then
						local var_78_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_75_1.actors_[var_78_3.prefab_name].transform, "story_v_out_115281", "115281017", "story_v_out_115281.awb")

						arg_75_1:RecordAudio("115281017", var_78_9)
						arg_75_1:RecordAudio("115281017", var_78_9)
					else
						arg_75_1:AudioAction("play", "voice", "story_v_out_115281", "115281017", "story_v_out_115281.awb")
					end

					arg_75_1:RecordHistoryTalkVoice("story_v_out_115281", "115281017", "story_v_out_115281.awb")
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
	Play115281018 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 115281018
		arg_79_1.duration_ = 12.6

		local var_79_0 = {
			ja = 12.6,
			ko = 9.7,
			zh = 8.833,
			en = 10.733
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
				arg_79_0:Play115281019(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			local var_82_0 = 2

			if var_82_0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_0 + arg_82_0 then
				local var_82_1 = manager.ui.mainCamera.transform.localPosition
				local var_82_2 = Vector3.New(0, 0, 10) + Vector3.New(var_82_1.x, var_82_1.y, 0)
				local var_82_3 = arg_79_1.bgs_.ST27

				var_82_3.transform.localPosition = var_82_2
				var_82_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_82_4 = var_82_3:GetComponent("SpriteRenderer")

				if var_82_4 and var_82_4.sprite then
					local var_82_5 = (var_82_3.transform.localPosition - var_82_1).z
					local var_82_6 = manager.ui.mainCameraCom_
					local var_82_7 = 2 * var_82_5 * Mathf.Tan(var_82_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_82_8 = var_82_7 * var_82_6.aspect
					local var_82_9 = var_82_4.sprite.bounds.size.x
					local var_82_10 = var_82_4.sprite.bounds.size.y
					local var_82_11 = var_82_8 / var_82_9
					local var_82_12 = var_82_7 / var_82_10
					local var_82_13 = var_82_12 < var_82_11 and var_82_11 or var_82_12

					var_82_3.transform.localScale = Vector3.New(var_82_13, var_82_13, 0)
				end

				for iter_82_0, iter_82_1 in pairs(arg_79_1.bgs_) do
					if iter_82_0 ~= "ST27" then
						iter_82_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_82_14 = 0

			if var_82_14 < arg_79_1.time_ and arg_79_1.time_ <= var_82_14 + arg_82_0 then
				arg_79_1.mask_.enabled = true
				arg_79_1.mask_.raycastTarget = true

				arg_79_1:SetGaussion(false)
			end

			local var_82_15 = 2

			if var_82_14 <= arg_79_1.time_ and arg_79_1.time_ < var_82_14 + var_82_15 then
				local var_82_16 = (arg_79_1.time_ - var_82_14) / var_82_15
				local var_82_17 = Color.New(0, 0, 0)

				var_82_17.a = Mathf.Lerp(0, 1, var_82_16)
				arg_79_1.mask_.color = var_82_17
			end

			if arg_79_1.time_ >= var_82_14 + var_82_15 and arg_79_1.time_ < var_82_14 + var_82_15 + arg_82_0 then
				local var_82_18 = Color.New(0, 0, 0)

				var_82_18.a = 1
				arg_79_1.mask_.color = var_82_18
			end

			local var_82_19 = 2

			if var_82_19 < arg_79_1.time_ and arg_79_1.time_ <= var_82_19 + arg_82_0 then
				arg_79_1.mask_.enabled = true
				arg_79_1.mask_.raycastTarget = true

				arg_79_1:SetGaussion(false)
			end

			local var_82_20 = 2

			if var_82_19 <= arg_79_1.time_ and arg_79_1.time_ < var_82_19 + var_82_20 then
				local var_82_21 = (arg_79_1.time_ - var_82_19) / var_82_20
				local var_82_22 = Color.New(0, 0, 0)

				var_82_22.a = Mathf.Lerp(1, 0, var_82_21)
				arg_79_1.mask_.color = var_82_22
			end

			if arg_79_1.time_ >= var_82_19 + var_82_20 and arg_79_1.time_ < var_82_19 + var_82_20 + arg_82_0 then
				local var_82_23 = Color.New(0, 0, 0)
				local var_82_24 = 0

				arg_79_1.mask_.enabled = false
				var_82_23.a = var_82_24
				arg_79_1.mask_.color = var_82_23
			end

			local var_82_25 = 2

			arg_79_1.isInRecall_ = false

			if var_82_25 < arg_79_1.time_ and arg_79_1.time_ <= var_82_25 + arg_82_0 then
				arg_79_1.screenFilterGo_:SetActive(false)

				for iter_82_2, iter_82_3 in pairs(arg_79_1.actors_) do
					local var_82_26 = iter_82_3:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_82_4, iter_82_5 in ipairs(var_82_26) do
						if iter_82_5.color.r > 0.51 then
							iter_82_5.color = Color.New(1, 1, 1)
						else
							iter_82_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end
			end

			local var_82_27 = 0.0166666666666667

			if var_82_25 <= arg_79_1.time_ and arg_79_1.time_ < var_82_25 + var_82_27 then
				local var_82_28 = (arg_79_1.time_ - var_82_25) / var_82_27

				arg_79_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, var_82_28)
			end

			if arg_79_1.time_ >= var_82_25 + var_82_27 and arg_79_1.time_ < var_82_25 + var_82_27 + arg_82_0 then
				arg_79_1.screenFilterEffect_.weight = 0
			end

			local var_82_29 = arg_79_1.actors_["10029"].transform
			local var_82_30 = 1.99933333333333

			if var_82_30 < arg_79_1.time_ and arg_79_1.time_ <= var_82_30 + arg_82_0 then
				arg_79_1.var_.moveOldPos10029 = var_82_29.localPosition
				var_82_29.localScale = Vector3.New(1, 1, 1)

				arg_79_1:CheckSpriteTmpPos("10029", 7)
			end

			local var_82_31 = 0.001

			if var_82_30 <= arg_79_1.time_ and arg_79_1.time_ < var_82_30 + var_82_31 then
				local var_82_32 = (arg_79_1.time_ - var_82_30) / var_82_31
				local var_82_33 = Vector3.New(0, -2000, -180)

				var_82_29.localPosition = Vector3.Lerp(arg_79_1.var_.moveOldPos10029, var_82_33, var_82_32)
			end

			if arg_79_1.time_ >= var_82_30 + var_82_31 and arg_79_1.time_ < var_82_30 + var_82_31 + arg_82_0 then
				var_82_29.localPosition = Vector3.New(0, -2000, -180)
			end

			local var_82_34 = arg_79_1.actors_["10030"].transform
			local var_82_35 = 4

			if var_82_35 < arg_79_1.time_ and arg_79_1.time_ <= var_82_35 + arg_82_0 then
				arg_79_1.var_.moveOldPos10030 = var_82_34.localPosition
				var_82_34.localScale = Vector3.New(1, 1, 1)

				arg_79_1:CheckSpriteTmpPos("10030", 3)

				local var_82_36 = var_82_34.childCount

				for iter_82_6 = 0, var_82_36 - 1 do
					local var_82_37 = var_82_34:GetChild(iter_82_6)

					if var_82_37.name == "split_5" or not string.find(var_82_37.name, "split") then
						var_82_37.gameObject:SetActive(true)
					else
						var_82_37.gameObject:SetActive(false)
					end
				end
			end

			local var_82_38 = 0.001

			if var_82_35 <= arg_79_1.time_ and arg_79_1.time_ < var_82_35 + var_82_38 then
				local var_82_39 = (arg_79_1.time_ - var_82_35) / var_82_38
				local var_82_40 = Vector3.New(0, -390, 150)

				var_82_34.localPosition = Vector3.Lerp(arg_79_1.var_.moveOldPos10030, var_82_40, var_82_39)
			end

			if arg_79_1.time_ >= var_82_35 + var_82_38 and arg_79_1.time_ < var_82_35 + var_82_38 + arg_82_0 then
				var_82_34.localPosition = Vector3.New(0, -390, 150)
			end

			local var_82_41 = arg_79_1.actors_["10030"]
			local var_82_42 = 4

			if var_82_42 < arg_79_1.time_ and arg_79_1.time_ <= var_82_42 + arg_82_0 then
				local var_82_43 = var_82_41:GetComponentInChildren(typeof(CanvasGroup))

				if var_82_43 then
					arg_79_1.var_.alphaOldValue10030 = var_82_43.alpha
					arg_79_1.var_.characterEffect10030 = var_82_43
				end

				arg_79_1.var_.alphaOldValue10030 = 0
			end

			local var_82_44 = 0.333333333333333

			if var_82_42 <= arg_79_1.time_ and arg_79_1.time_ < var_82_42 + var_82_44 then
				local var_82_45 = (arg_79_1.time_ - var_82_42) / var_82_44
				local var_82_46 = Mathf.Lerp(arg_79_1.var_.alphaOldValue10030, 1, var_82_45)

				if arg_79_1.var_.characterEffect10030 then
					arg_79_1.var_.characterEffect10030.alpha = var_82_46
				end
			end

			if arg_79_1.time_ >= var_82_42 + var_82_44 and arg_79_1.time_ < var_82_42 + var_82_44 + arg_82_0 and arg_79_1.var_.characterEffect10030 then
				arg_79_1.var_.characterEffect10030.alpha = 1
			end

			if arg_79_1.frameCnt_ <= 1 then
				arg_79_1.dialog_:SetActive(false)
			end

			local var_82_47 = 4
			local var_82_48 = 0.45

			if var_82_47 < arg_79_1.time_ and arg_79_1.time_ <= var_82_47 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0

				arg_79_1.dialog_:SetActive(true)

				arg_79_1.dialogCg_.alpha = 0

				local var_82_49 = LeanTween.value(arg_79_1.dialog_, 0, 1, 0.3)

				var_82_49:setOnUpdate(LuaHelper.FloatAction(function(arg_83_0)
					arg_79_1.dialogCg_.alpha = arg_83_0
				end))
				var_82_49:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_79_1.dialog_)
					var_82_49:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_79_1.duration_ = arg_79_1.duration_ + 0.3

				SetActive(arg_79_1.leftNameGo_, true)

				local var_82_50 = arg_79_1:FormatText(StoryNameCfg[309].name)

				arg_79_1.leftNameTxt_.text = var_82_50

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_51 = arg_79_1:GetWordFromCfg(115281018)
				local var_82_52 = arg_79_1:FormatText(var_82_51.content)

				arg_79_1.text_.text = var_82_52

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_53 = 17
				local var_82_54 = utf8.len(var_82_52)
				local var_82_55 = var_82_53 <= 0 and var_82_48 or var_82_48 * (var_82_54 / var_82_53)

				if var_82_55 > 0 and var_82_48 < var_82_55 then
					arg_79_1.talkMaxDuration = var_82_55
					var_82_47 = var_82_47 + 0.3

					if var_82_55 + var_82_47 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_55 + var_82_47
					end
				end

				arg_79_1.text_.text = var_82_52
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115281", "115281018", "story_v_out_115281.awb") ~= 0 then
					local var_82_56 = manager.audio:GetVoiceLength("story_v_out_115281", "115281018", "story_v_out_115281.awb") / 1000

					if var_82_56 + var_82_47 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_56 + var_82_47
					end

					if var_82_51.prefab_name ~= "" and arg_79_1.actors_[var_82_51.prefab_name] ~= nil then
						local var_82_57 = LuaForUtil.PlayVoiceWithCriLipsync(arg_79_1.actors_[var_82_51.prefab_name].transform, "story_v_out_115281", "115281018", "story_v_out_115281.awb")

						arg_79_1:RecordAudio("115281018", var_82_57)
						arg_79_1:RecordAudio("115281018", var_82_57)
					else
						arg_79_1:AudioAction("play", "voice", "story_v_out_115281", "115281018", "story_v_out_115281.awb")
					end

					arg_79_1:RecordHistoryTalkVoice("story_v_out_115281", "115281018", "story_v_out_115281.awb")
				end

				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_58 = var_82_47 + 0.3
			local var_82_59 = math.max(var_82_48, arg_79_1.talkMaxDuration)

			if var_82_58 <= arg_79_1.time_ and arg_79_1.time_ < var_82_58 + var_82_59 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_58) / var_82_59

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_58 + var_82_59 and arg_79_1.time_ < var_82_58 + var_82_59 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10029",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.99933333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Sprite
			},
			{
				assetPath = "",
				actorName = "10030",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_79_1:InitPlayNodeList()
	end,
	Play115281019 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 115281019
		arg_85_1.duration_ = 5

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play115281020(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = arg_85_1.actors_["10030"]
			local var_88_1 = 0

			if var_88_1 < arg_85_1.time_ and arg_85_1.time_ <= var_88_1 + arg_88_0 then
				local var_88_2 = var_88_0:GetComponentInChildren(typeof(CanvasGroup))

				if var_88_2 then
					arg_85_1.var_.alphaOldValue10030 = var_88_2.alpha
					arg_85_1.var_.characterEffect10030 = var_88_2
				end

				arg_85_1.var_.alphaOldValue10030 = 1
			end

			local var_88_3 = 0.333333333333333

			if var_88_1 <= arg_85_1.time_ and arg_85_1.time_ < var_88_1 + var_88_3 then
				local var_88_4 = (arg_85_1.time_ - var_88_1) / var_88_3
				local var_88_5 = Mathf.Lerp(arg_85_1.var_.alphaOldValue10030, 0, var_88_4)

				if arg_85_1.var_.characterEffect10030 then
					arg_85_1.var_.characterEffect10030.alpha = var_88_5
				end
			end

			if arg_85_1.time_ >= var_88_1 + var_88_3 and arg_85_1.time_ < var_88_1 + var_88_3 + arg_88_0 and arg_85_1.var_.characterEffect10030 then
				arg_85_1.var_.characterEffect10030.alpha = 0
			end

			local var_88_6 = 0
			local var_88_7 = 1.125

			if var_88_6 < arg_85_1.time_ and arg_85_1.time_ <= var_88_6 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, false)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_8 = arg_85_1:GetWordFromCfg(115281019)
				local var_88_9 = arg_85_1:FormatText(var_88_8.content)

				arg_85_1.text_.text = var_88_9

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_10 = 45
				local var_88_11 = utf8.len(var_88_9)
				local var_88_12 = var_88_10 <= 0 and var_88_7 or var_88_7 * (var_88_11 / var_88_10)

				if var_88_12 > 0 and var_88_7 < var_88_12 then
					arg_85_1.talkMaxDuration = var_88_12

					if var_88_12 + var_88_6 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_12 + var_88_6
					end
				end

				arg_85_1.text_.text = var_88_9
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)
				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_13 = math.max(var_88_7, arg_85_1.talkMaxDuration)

			if var_88_6 <= arg_85_1.time_ and arg_85_1.time_ < var_88_6 + var_88_13 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_6) / var_88_13

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_6 + var_88_13 and arg_85_1.time_ < var_88_6 + var_88_13 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play115281020 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 115281020
		arg_89_1.duration_ = 5

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play115281021(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = 0
			local var_92_1 = 0.95

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

				local var_92_2 = arg_89_1:GetWordFromCfg(115281020)
				local var_92_3 = arg_89_1:FormatText(var_92_2.content)

				arg_89_1.text_.text = var_92_3

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_4 = 38
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
	Play115281021 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 115281021
		arg_93_1.duration_ = 6.43

		local var_93_0 = {
			ja = 6.3,
			ko = 3.6,
			zh = 5.466,
			en = 6.433
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
				arg_93_0:Play115281022(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = arg_93_1.actors_["10029"].transform
			local var_96_1 = 0

			if var_96_1 < arg_93_1.time_ and arg_93_1.time_ <= var_96_1 + arg_96_0 then
				arg_93_1.var_.moveOldPos10029 = var_96_0.localPosition
				var_96_0.localScale = Vector3.New(1, 1, 1)

				arg_93_1:CheckSpriteTmpPos("10029", 2)
			end

			local var_96_2 = 0.001

			if var_96_1 <= arg_93_1.time_ and arg_93_1.time_ < var_96_1 + var_96_2 then
				local var_96_3 = (arg_93_1.time_ - var_96_1) / var_96_2
				local var_96_4 = Vector3.New(-390, -350, -180)

				var_96_0.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos10029, var_96_4, var_96_3)
			end

			if arg_93_1.time_ >= var_96_1 + var_96_2 and arg_93_1.time_ < var_96_1 + var_96_2 + arg_96_0 then
				var_96_0.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_96_5 = arg_93_1.actors_["10029"]
			local var_96_6 = 0

			if var_96_6 < arg_93_1.time_ and arg_93_1.time_ <= var_96_6 + arg_96_0 then
				local var_96_7 = var_96_5:GetComponent("Image")

				if var_96_7 then
					arg_93_1.var_.alphaMatValue10029 = var_96_7
					arg_93_1.var_.alphaOldValue10029 = var_96_7.color.a
				end

				arg_93_1.var_.alphaOldValue10029 = 0
			end

			local var_96_8 = 0.333333333333333

			if var_96_6 <= arg_93_1.time_ and arg_93_1.time_ < var_96_6 + var_96_8 then
				local var_96_9 = (arg_93_1.time_ - var_96_6) / var_96_8
				local var_96_10 = Mathf.Lerp(arg_93_1.var_.alphaOldValue10029, 1, var_96_9)

				if arg_93_1.var_.alphaMatValue10029 then
					local var_96_11 = arg_93_1.var_.alphaMatValue10029.color

					var_96_11.a = var_96_10
					arg_93_1.var_.alphaMatValue10029.color = var_96_11
				end
			end

			if arg_93_1.time_ >= var_96_6 + var_96_8 and arg_93_1.time_ < var_96_6 + var_96_8 + arg_96_0 and arg_93_1.var_.alphaMatValue10029 then
				local var_96_12 = arg_93_1.var_.alphaMatValue10029
				local var_96_13 = var_96_12.color

				var_96_13.a = 1
				var_96_12.color = var_96_13
			end

			local var_96_14 = 0
			local var_96_15 = 0.425

			if var_96_14 < arg_93_1.time_ and arg_93_1.time_ <= var_96_14 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				local var_96_16 = arg_93_1:FormatText(StoryNameCfg[312].name)

				arg_93_1.leftNameTxt_.text = var_96_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_17 = arg_93_1:GetWordFromCfg(115281021)
				local var_96_18 = arg_93_1:FormatText(var_96_17.content)

				arg_93_1.text_.text = var_96_18

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_19 = 17
				local var_96_20 = utf8.len(var_96_18)
				local var_96_21 = var_96_19 <= 0 and var_96_15 or var_96_15 * (var_96_20 / var_96_19)

				if var_96_21 > 0 and var_96_15 < var_96_21 then
					arg_93_1.talkMaxDuration = var_96_21

					if var_96_21 + var_96_14 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_21 + var_96_14
					end
				end

				arg_93_1.text_.text = var_96_18
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115281", "115281021", "story_v_out_115281.awb") ~= 0 then
					local var_96_22 = manager.audio:GetVoiceLength("story_v_out_115281", "115281021", "story_v_out_115281.awb") / 1000

					if var_96_22 + var_96_14 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_22 + var_96_14
					end

					if var_96_17.prefab_name ~= "" and arg_93_1.actors_[var_96_17.prefab_name] ~= nil then
						local var_96_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_17.prefab_name].transform, "story_v_out_115281", "115281021", "story_v_out_115281.awb")

						arg_93_1:RecordAudio("115281021", var_96_23)
						arg_93_1:RecordAudio("115281021", var_96_23)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_115281", "115281021", "story_v_out_115281.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_115281", "115281021", "story_v_out_115281.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_24 = math.max(var_96_15, arg_93_1.talkMaxDuration)

			if var_96_14 <= arg_93_1.time_ and arg_93_1.time_ < var_96_14 + var_96_24 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_14) / var_96_24

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_14 + var_96_24 and arg_93_1.time_ < var_96_14 + var_96_24 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {
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

		arg_93_1:InitPlayNodeList()
	end,
	Play115281022 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 115281022
		arg_97_1.duration_ = 10.83

		local var_97_0 = {
			ja = 10.833,
			ko = 5.033,
			zh = 5.6,
			en = 6.1
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
				arg_97_0:Play115281023(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = arg_97_1.actors_["10030"].transform
			local var_100_1 = 0

			if var_100_1 < arg_97_1.time_ and arg_97_1.time_ <= var_100_1 + arg_100_0 then
				arg_97_1.var_.moveOldPos10030 = var_100_0.localPosition
				var_100_0.localScale = Vector3.New(1, 1, 1)

				arg_97_1:CheckSpriteTmpPos("10030", 4)

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
				local var_100_6 = Vector3.New(390, -390, 150)

				var_100_0.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos10030, var_100_6, var_100_5)
			end

			if arg_97_1.time_ >= var_100_1 + var_100_4 and arg_97_1.time_ < var_100_1 + var_100_4 + arg_100_0 then
				var_100_0.localPosition = Vector3.New(390, -390, 150)
			end

			local var_100_7 = arg_97_1.actors_["10029"]
			local var_100_8 = 0

			if var_100_8 < arg_97_1.time_ and arg_97_1.time_ <= var_100_8 + arg_100_0 and not isNil(var_100_7) then
				local var_100_9 = var_100_7:GetComponent("Image")

				if var_100_9 then
					arg_97_1.var_.highlightMatValue10029 = var_100_9
				end
			end

			local var_100_10 = 0.2

			if var_100_8 <= arg_97_1.time_ and arg_97_1.time_ < var_100_8 + var_100_10 and not isNil(var_100_7) then
				local var_100_11 = (arg_97_1.time_ - var_100_8) / var_100_10

				if arg_97_1.var_.highlightMatValue10029 then
					local var_100_12 = Mathf.Lerp(1, 0.5, var_100_11)
					local var_100_13 = arg_97_1.var_.highlightMatValue10029
					local var_100_14 = var_100_13.color

					var_100_14.r = var_100_12
					var_100_14.g = var_100_12
					var_100_14.b = var_100_12
					var_100_13.color = var_100_14
				end
			end

			if arg_97_1.time_ >= var_100_8 + var_100_10 and arg_97_1.time_ < var_100_8 + var_100_10 + arg_100_0 and not isNil(var_100_7) and arg_97_1.var_.highlightMatValue10029 then
				local var_100_15 = 0.5
				local var_100_16 = arg_97_1.var_.highlightMatValue10029
				local var_100_17 = var_100_16.color

				var_100_17.r = var_100_15
				var_100_17.g = var_100_15
				var_100_17.b = var_100_15
				var_100_16.color = var_100_17
			end

			local var_100_18 = arg_97_1.actors_["10030"]
			local var_100_19 = 0

			if var_100_19 < arg_97_1.time_ and arg_97_1.time_ <= var_100_19 + arg_100_0 then
				local var_100_20 = var_100_18:GetComponentInChildren(typeof(CanvasGroup))

				if var_100_20 then
					arg_97_1.var_.alphaOldValue10030 = var_100_20.alpha
					arg_97_1.var_.characterEffect10030 = var_100_20
				end

				arg_97_1.var_.alphaOldValue10030 = 0
			end

			local var_100_21 = 0.333333333333333

			if var_100_19 <= arg_97_1.time_ and arg_97_1.time_ < var_100_19 + var_100_21 then
				local var_100_22 = (arg_97_1.time_ - var_100_19) / var_100_21
				local var_100_23 = Mathf.Lerp(arg_97_1.var_.alphaOldValue10030, 1, var_100_22)

				if arg_97_1.var_.characterEffect10030 then
					arg_97_1.var_.characterEffect10030.alpha = var_100_23
				end
			end

			if arg_97_1.time_ >= var_100_19 + var_100_21 and arg_97_1.time_ < var_100_19 + var_100_21 + arg_100_0 and arg_97_1.var_.characterEffect10030 then
				arg_97_1.var_.characterEffect10030.alpha = 1
			end

			local var_100_24 = 0
			local var_100_25 = 0.6

			if var_100_24 < arg_97_1.time_ and arg_97_1.time_ <= var_100_24 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				local var_100_26 = arg_97_1:FormatText(StoryNameCfg[309].name)

				arg_97_1.leftNameTxt_.text = var_100_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_27 = arg_97_1:GetWordFromCfg(115281022)
				local var_100_28 = arg_97_1:FormatText(var_100_27.content)

				arg_97_1.text_.text = var_100_28

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_29 = 24
				local var_100_30 = utf8.len(var_100_28)
				local var_100_31 = var_100_29 <= 0 and var_100_25 or var_100_25 * (var_100_30 / var_100_29)

				if var_100_31 > 0 and var_100_25 < var_100_31 then
					arg_97_1.talkMaxDuration = var_100_31

					if var_100_31 + var_100_24 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_31 + var_100_24
					end
				end

				arg_97_1.text_.text = var_100_28
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115281", "115281022", "story_v_out_115281.awb") ~= 0 then
					local var_100_32 = manager.audio:GetVoiceLength("story_v_out_115281", "115281022", "story_v_out_115281.awb") / 1000

					if var_100_32 + var_100_24 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_32 + var_100_24
					end

					if var_100_27.prefab_name ~= "" and arg_97_1.actors_[var_100_27.prefab_name] ~= nil then
						local var_100_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_27.prefab_name].transform, "story_v_out_115281", "115281022", "story_v_out_115281.awb")

						arg_97_1:RecordAudio("115281022", var_100_33)
						arg_97_1:RecordAudio("115281022", var_100_33)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_115281", "115281022", "story_v_out_115281.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_115281", "115281022", "story_v_out_115281.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_34 = math.max(var_100_25, arg_97_1.talkMaxDuration)

			if var_100_24 <= arg_97_1.time_ and arg_97_1.time_ < var_100_24 + var_100_34 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_24) / var_100_34

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_24 + var_100_34 and arg_97_1.time_ < var_100_24 + var_100_34 + arg_100_0 then
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
	Play115281023 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 115281023
		arg_101_1.duration_ = 5

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play115281024(arg_101_1)
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
			local var_104_9 = 0.875

			if var_104_8 < arg_101_1.time_ and arg_101_1.time_ <= var_104_8 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, false)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_10 = arg_101_1:GetWordFromCfg(115281023)
				local var_104_11 = arg_101_1:FormatText(var_104_10.content)

				arg_101_1.text_.text = var_104_11

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_12 = 35
				local var_104_13 = utf8.len(var_104_11)
				local var_104_14 = var_104_12 <= 0 and var_104_9 or var_104_9 * (var_104_13 / var_104_12)

				if var_104_14 > 0 and var_104_9 < var_104_14 then
					arg_101_1.talkMaxDuration = var_104_14

					if var_104_14 + var_104_8 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_14 + var_104_8
					end
				end

				arg_101_1.text_.text = var_104_11
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)
				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_15 = math.max(var_104_9, arg_101_1.talkMaxDuration)

			if var_104_8 <= arg_101_1.time_ and arg_101_1.time_ < var_104_8 + var_104_15 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_8) / var_104_15

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_8 + var_104_15 and arg_101_1.time_ < var_104_8 + var_104_15 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play115281024 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 115281024
		arg_105_1.duration_ = 6.73

		local var_105_0 = {
			ja = 6,
			ko = 4.666,
			zh = 4.933,
			en = 6.733
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
				arg_105_0:Play115281025(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = arg_105_1.actors_["10029"]
			local var_108_1 = 0

			if var_108_1 < arg_105_1.time_ and arg_105_1.time_ <= var_108_1 + arg_108_0 and not isNil(var_108_0) then
				local var_108_2 = var_108_0:GetComponent("Image")

				if var_108_2 then
					arg_105_1.var_.highlightMatValue10029 = var_108_2
				end
			end

			local var_108_3 = 0.2

			if var_108_1 <= arg_105_1.time_ and arg_105_1.time_ < var_108_1 + var_108_3 and not isNil(var_108_0) then
				local var_108_4 = (arg_105_1.time_ - var_108_1) / var_108_3

				if arg_105_1.var_.highlightMatValue10029 then
					local var_108_5 = Mathf.Lerp(0.5, 1, var_108_4)
					local var_108_6 = arg_105_1.var_.highlightMatValue10029
					local var_108_7 = var_108_6.color

					var_108_7.r = var_108_5
					var_108_7.g = var_108_5
					var_108_7.b = var_108_5
					var_108_6.color = var_108_7
				end
			end

			if arg_105_1.time_ >= var_108_1 + var_108_3 and arg_105_1.time_ < var_108_1 + var_108_3 + arg_108_0 and not isNil(var_108_0) and arg_105_1.var_.highlightMatValue10029 then
				local var_108_8 = 1

				var_108_0.transform:SetSiblingIndex(1)

				local var_108_9 = arg_105_1.var_.highlightMatValue10029
				local var_108_10 = var_108_9.color

				var_108_10.r = var_108_8
				var_108_10.g = var_108_8
				var_108_10.b = var_108_8
				var_108_9.color = var_108_10
			end

			local var_108_11 = 0
			local var_108_12 = 0.6

			if var_108_11 < arg_105_1.time_ and arg_105_1.time_ <= var_108_11 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				local var_108_13 = arg_105_1:FormatText(StoryNameCfg[312].name)

				arg_105_1.leftNameTxt_.text = var_108_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_14 = arg_105_1:GetWordFromCfg(115281024)
				local var_108_15 = arg_105_1:FormatText(var_108_14.content)

				arg_105_1.text_.text = var_108_15

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_16 = 21
				local var_108_17 = utf8.len(var_108_15)
				local var_108_18 = var_108_16 <= 0 and var_108_12 or var_108_12 * (var_108_17 / var_108_16)

				if var_108_18 > 0 and var_108_12 < var_108_18 then
					arg_105_1.talkMaxDuration = var_108_18

					if var_108_18 + var_108_11 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_18 + var_108_11
					end
				end

				arg_105_1.text_.text = var_108_15
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115281", "115281024", "story_v_out_115281.awb") ~= 0 then
					local var_108_19 = manager.audio:GetVoiceLength("story_v_out_115281", "115281024", "story_v_out_115281.awb") / 1000

					if var_108_19 + var_108_11 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_19 + var_108_11
					end

					if var_108_14.prefab_name ~= "" and arg_105_1.actors_[var_108_14.prefab_name] ~= nil then
						local var_108_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_14.prefab_name].transform, "story_v_out_115281", "115281024", "story_v_out_115281.awb")

						arg_105_1:RecordAudio("115281024", var_108_20)
						arg_105_1:RecordAudio("115281024", var_108_20)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_115281", "115281024", "story_v_out_115281.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_115281", "115281024", "story_v_out_115281.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_21 = math.max(var_108_12, arg_105_1.talkMaxDuration)

			if var_108_11 <= arg_105_1.time_ and arg_105_1.time_ < var_108_11 + var_108_21 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_11) / var_108_21

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_11 + var_108_21 and arg_105_1.time_ < var_108_11 + var_108_21 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play115281025 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 115281025
		arg_109_1.duration_ = 10.73

		local var_109_0 = {
			ja = 7,
			ko = 8.533,
			zh = 8.366,
			en = 10.733
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
				arg_109_0:Play115281026(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = arg_109_1.actors_["10030"].transform
			local var_112_1 = 0

			if var_112_1 < arg_109_1.time_ and arg_109_1.time_ <= var_112_1 + arg_112_0 then
				arg_109_1.var_.moveOldPos10030 = var_112_0.localPosition
				var_112_0.localScale = Vector3.New(1, 1, 1)

				arg_109_1:CheckSpriteTmpPos("10030", 4)

				local var_112_2 = var_112_0.childCount

				for iter_112_0 = 0, var_112_2 - 1 do
					local var_112_3 = var_112_0:GetChild(iter_112_0)

					if var_112_3.name == "split_2" or not string.find(var_112_3.name, "split") then
						var_112_3.gameObject:SetActive(true)
					else
						var_112_3.gameObject:SetActive(false)
					end
				end
			end

			local var_112_4 = 0.001

			if var_112_1 <= arg_109_1.time_ and arg_109_1.time_ < var_112_1 + var_112_4 then
				local var_112_5 = (arg_109_1.time_ - var_112_1) / var_112_4
				local var_112_6 = Vector3.New(390, -390, 150)

				var_112_0.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos10030, var_112_6, var_112_5)
			end

			if arg_109_1.time_ >= var_112_1 + var_112_4 and arg_109_1.time_ < var_112_1 + var_112_4 + arg_112_0 then
				var_112_0.localPosition = Vector3.New(390, -390, 150)
			end

			local var_112_7 = arg_109_1.actors_["10029"]
			local var_112_8 = 0

			if var_112_8 < arg_109_1.time_ and arg_109_1.time_ <= var_112_8 + arg_112_0 and not isNil(var_112_7) then
				local var_112_9 = var_112_7:GetComponent("Image")

				if var_112_9 then
					arg_109_1.var_.highlightMatValue10029 = var_112_9
				end
			end

			local var_112_10 = 0.2

			if var_112_8 <= arg_109_1.time_ and arg_109_1.time_ < var_112_8 + var_112_10 and not isNil(var_112_7) then
				local var_112_11 = (arg_109_1.time_ - var_112_8) / var_112_10

				if arg_109_1.var_.highlightMatValue10029 then
					local var_112_12 = Mathf.Lerp(1, 0.5, var_112_11)
					local var_112_13 = arg_109_1.var_.highlightMatValue10029
					local var_112_14 = var_112_13.color

					var_112_14.r = var_112_12
					var_112_14.g = var_112_12
					var_112_14.b = var_112_12
					var_112_13.color = var_112_14
				end
			end

			if arg_109_1.time_ >= var_112_8 + var_112_10 and arg_109_1.time_ < var_112_8 + var_112_10 + arg_112_0 and not isNil(var_112_7) and arg_109_1.var_.highlightMatValue10029 then
				local var_112_15 = 0.5
				local var_112_16 = arg_109_1.var_.highlightMatValue10029
				local var_112_17 = var_112_16.color

				var_112_17.r = var_112_15
				var_112_17.g = var_112_15
				var_112_17.b = var_112_15
				var_112_16.color = var_112_17
			end

			local var_112_18 = arg_109_1.actors_["10030"]
			local var_112_19 = 0

			if var_112_19 < arg_109_1.time_ and arg_109_1.time_ <= var_112_19 + arg_112_0 and not isNil(var_112_18) and arg_109_1.var_.actorSpriteComps10030 == nil then
				arg_109_1.var_.actorSpriteComps10030 = var_112_18:GetComponentsInChildren(typeof(Image), true)
			end

			local var_112_20 = 0.2

			if var_112_19 <= arg_109_1.time_ and arg_109_1.time_ < var_112_19 + var_112_20 and not isNil(var_112_18) then
				local var_112_21 = (arg_109_1.time_ - var_112_19) / var_112_20

				if arg_109_1.var_.actorSpriteComps10030 then
					for iter_112_1, iter_112_2 in pairs(arg_109_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_112_2 then
							if arg_109_1.isInRecall_ then
								local var_112_22 = Mathf.Lerp(iter_112_2.color.r, arg_109_1.hightColor1.r, var_112_21)
								local var_112_23 = Mathf.Lerp(iter_112_2.color.g, arg_109_1.hightColor1.g, var_112_21)
								local var_112_24 = Mathf.Lerp(iter_112_2.color.b, arg_109_1.hightColor1.b, var_112_21)

								iter_112_2.color = Color.New(var_112_22, var_112_23, var_112_24)
							else
								local var_112_25 = Mathf.Lerp(iter_112_2.color.r, 1, var_112_21)

								iter_112_2.color = Color.New(var_112_25, var_112_25, var_112_25)
							end
						end
					end
				end
			end

			if arg_109_1.time_ >= var_112_19 + var_112_20 and arg_109_1.time_ < var_112_19 + var_112_20 + arg_112_0 and not isNil(var_112_18) and arg_109_1.var_.actorSpriteComps10030 then
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

			local var_112_26 = 0
			local var_112_27 = 0.925

			if var_112_26 < arg_109_1.time_ and arg_109_1.time_ <= var_112_26 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				local var_112_28 = arg_109_1:FormatText(StoryNameCfg[309].name)

				arg_109_1.leftNameTxt_.text = var_112_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_29 = arg_109_1:GetWordFromCfg(115281025)
				local var_112_30 = arg_109_1:FormatText(var_112_29.content)

				arg_109_1.text_.text = var_112_30

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_31 = 37
				local var_112_32 = utf8.len(var_112_30)
				local var_112_33 = var_112_31 <= 0 and var_112_27 or var_112_27 * (var_112_32 / var_112_31)

				if var_112_33 > 0 and var_112_27 < var_112_33 then
					arg_109_1.talkMaxDuration = var_112_33

					if var_112_33 + var_112_26 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_33 + var_112_26
					end
				end

				arg_109_1.text_.text = var_112_30
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115281", "115281025", "story_v_out_115281.awb") ~= 0 then
					local var_112_34 = manager.audio:GetVoiceLength("story_v_out_115281", "115281025", "story_v_out_115281.awb") / 1000

					if var_112_34 + var_112_26 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_34 + var_112_26
					end

					if var_112_29.prefab_name ~= "" and arg_109_1.actors_[var_112_29.prefab_name] ~= nil then
						local var_112_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_29.prefab_name].transform, "story_v_out_115281", "115281025", "story_v_out_115281.awb")

						arg_109_1:RecordAudio("115281025", var_112_35)
						arg_109_1:RecordAudio("115281025", var_112_35)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_115281", "115281025", "story_v_out_115281.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_115281", "115281025", "story_v_out_115281.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_36 = math.max(var_112_27, arg_109_1.talkMaxDuration)

			if var_112_26 <= arg_109_1.time_ and arg_109_1.time_ < var_112_26 + var_112_36 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_26) / var_112_36

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_26 + var_112_36 and arg_109_1.time_ < var_112_26 + var_112_36 + arg_112_0 then
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
	Play115281026 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 115281026
		arg_113_1.duration_ = 12.2

		local var_113_0 = {
			ja = 12.2,
			ko = 9.733,
			zh = 8.066,
			en = 10.9
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
				arg_113_0:Play115281027(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = arg_113_1.actors_["10029"]
			local var_116_1 = 0

			if var_116_1 < arg_113_1.time_ and arg_113_1.time_ <= var_116_1 + arg_116_0 and not isNil(var_116_0) then
				local var_116_2 = var_116_0:GetComponent("Image")

				if var_116_2 then
					arg_113_1.var_.highlightMatValue10029 = var_116_2
				end
			end

			local var_116_3 = 0.2

			if var_116_1 <= arg_113_1.time_ and arg_113_1.time_ < var_116_1 + var_116_3 and not isNil(var_116_0) then
				local var_116_4 = (arg_113_1.time_ - var_116_1) / var_116_3

				if arg_113_1.var_.highlightMatValue10029 then
					local var_116_5 = Mathf.Lerp(0.5, 1, var_116_4)
					local var_116_6 = arg_113_1.var_.highlightMatValue10029
					local var_116_7 = var_116_6.color

					var_116_7.r = var_116_5
					var_116_7.g = var_116_5
					var_116_7.b = var_116_5
					var_116_6.color = var_116_7
				end
			end

			if arg_113_1.time_ >= var_116_1 + var_116_3 and arg_113_1.time_ < var_116_1 + var_116_3 + arg_116_0 and not isNil(var_116_0) and arg_113_1.var_.highlightMatValue10029 then
				local var_116_8 = 1

				var_116_0.transform:SetSiblingIndex(1)

				local var_116_9 = arg_113_1.var_.highlightMatValue10029
				local var_116_10 = var_116_9.color

				var_116_10.r = var_116_8
				var_116_10.g = var_116_8
				var_116_10.b = var_116_8
				var_116_9.color = var_116_10
			end

			local var_116_11 = arg_113_1.actors_["10030"]
			local var_116_12 = 0

			if var_116_12 < arg_113_1.time_ and arg_113_1.time_ <= var_116_12 + arg_116_0 and not isNil(var_116_11) and arg_113_1.var_.actorSpriteComps10030 == nil then
				arg_113_1.var_.actorSpriteComps10030 = var_116_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_116_13 = 0.2

			if var_116_12 <= arg_113_1.time_ and arg_113_1.time_ < var_116_12 + var_116_13 and not isNil(var_116_11) then
				local var_116_14 = (arg_113_1.time_ - var_116_12) / var_116_13

				if arg_113_1.var_.actorSpriteComps10030 then
					for iter_116_0, iter_116_1 in pairs(arg_113_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_116_1 then
							if arg_113_1.isInRecall_ then
								local var_116_15 = Mathf.Lerp(iter_116_1.color.r, arg_113_1.hightColor2.r, var_116_14)
								local var_116_16 = Mathf.Lerp(iter_116_1.color.g, arg_113_1.hightColor2.g, var_116_14)
								local var_116_17 = Mathf.Lerp(iter_116_1.color.b, arg_113_1.hightColor2.b, var_116_14)

								iter_116_1.color = Color.New(var_116_15, var_116_16, var_116_17)
							else
								local var_116_18 = Mathf.Lerp(iter_116_1.color.r, 0.5, var_116_14)

								iter_116_1.color = Color.New(var_116_18, var_116_18, var_116_18)
							end
						end
					end
				end
			end

			if arg_113_1.time_ >= var_116_12 + var_116_13 and arg_113_1.time_ < var_116_12 + var_116_13 + arg_116_0 and not isNil(var_116_11) and arg_113_1.var_.actorSpriteComps10030 then
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

			local var_116_19 = 0
			local var_116_20 = 0.9

			if var_116_19 < arg_113_1.time_ and arg_113_1.time_ <= var_116_19 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				local var_116_21 = arg_113_1:FormatText(StoryNameCfg[312].name)

				arg_113_1.leftNameTxt_.text = var_116_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_22 = arg_113_1:GetWordFromCfg(115281026)
				local var_116_23 = arg_113_1:FormatText(var_116_22.content)

				arg_113_1.text_.text = var_116_23

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_24 = 36
				local var_116_25 = utf8.len(var_116_23)
				local var_116_26 = var_116_24 <= 0 and var_116_20 or var_116_20 * (var_116_25 / var_116_24)

				if var_116_26 > 0 and var_116_20 < var_116_26 then
					arg_113_1.talkMaxDuration = var_116_26

					if var_116_26 + var_116_19 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_26 + var_116_19
					end
				end

				arg_113_1.text_.text = var_116_23
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115281", "115281026", "story_v_out_115281.awb") ~= 0 then
					local var_116_27 = manager.audio:GetVoiceLength("story_v_out_115281", "115281026", "story_v_out_115281.awb") / 1000

					if var_116_27 + var_116_19 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_27 + var_116_19
					end

					if var_116_22.prefab_name ~= "" and arg_113_1.actors_[var_116_22.prefab_name] ~= nil then
						local var_116_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_22.prefab_name].transform, "story_v_out_115281", "115281026", "story_v_out_115281.awb")

						arg_113_1:RecordAudio("115281026", var_116_28)
						arg_113_1:RecordAudio("115281026", var_116_28)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_115281", "115281026", "story_v_out_115281.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_115281", "115281026", "story_v_out_115281.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_29 = math.max(var_116_20, arg_113_1.talkMaxDuration)

			if var_116_19 <= arg_113_1.time_ and arg_113_1.time_ < var_116_19 + var_116_29 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_19) / var_116_29

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_19 + var_116_29 and arg_113_1.time_ < var_116_19 + var_116_29 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play115281027 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 115281027
		arg_117_1.duration_ = 10.33

		local var_117_0 = {
			ja = 10.333,
			ko = 9.333,
			zh = 7.733,
			en = 7.533
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
				arg_117_0:Play115281028(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = arg_117_1.actors_["10029"]
			local var_120_1 = 0

			if var_120_1 < arg_117_1.time_ and arg_117_1.time_ <= var_120_1 + arg_120_0 and not isNil(var_120_0) then
				local var_120_2 = var_120_0:GetComponent("Image")

				if var_120_2 then
					arg_117_1.var_.highlightMatValue10029 = var_120_2
				end
			end

			local var_120_3 = 0.2

			if var_120_1 <= arg_117_1.time_ and arg_117_1.time_ < var_120_1 + var_120_3 and not isNil(var_120_0) then
				local var_120_4 = (arg_117_1.time_ - var_120_1) / var_120_3

				if arg_117_1.var_.highlightMatValue10029 then
					local var_120_5 = Mathf.Lerp(1, 0.5, var_120_4)
					local var_120_6 = arg_117_1.var_.highlightMatValue10029
					local var_120_7 = var_120_6.color

					var_120_7.r = var_120_5
					var_120_7.g = var_120_5
					var_120_7.b = var_120_5
					var_120_6.color = var_120_7
				end
			end

			if arg_117_1.time_ >= var_120_1 + var_120_3 and arg_117_1.time_ < var_120_1 + var_120_3 + arg_120_0 and not isNil(var_120_0) and arg_117_1.var_.highlightMatValue10029 then
				local var_120_8 = 0.5
				local var_120_9 = arg_117_1.var_.highlightMatValue10029
				local var_120_10 = var_120_9.color

				var_120_10.r = var_120_8
				var_120_10.g = var_120_8
				var_120_10.b = var_120_8
				var_120_9.color = var_120_10
			end

			local var_120_11 = arg_117_1.actors_["10030"]
			local var_120_12 = 0

			if var_120_12 < arg_117_1.time_ and arg_117_1.time_ <= var_120_12 + arg_120_0 and not isNil(var_120_11) and arg_117_1.var_.actorSpriteComps10030 == nil then
				arg_117_1.var_.actorSpriteComps10030 = var_120_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_120_13 = 0.2

			if var_120_12 <= arg_117_1.time_ and arg_117_1.time_ < var_120_12 + var_120_13 and not isNil(var_120_11) then
				local var_120_14 = (arg_117_1.time_ - var_120_12) / var_120_13

				if arg_117_1.var_.actorSpriteComps10030 then
					for iter_120_0, iter_120_1 in pairs(arg_117_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_120_1 then
							if arg_117_1.isInRecall_ then
								local var_120_15 = Mathf.Lerp(iter_120_1.color.r, arg_117_1.hightColor1.r, var_120_14)
								local var_120_16 = Mathf.Lerp(iter_120_1.color.g, arg_117_1.hightColor1.g, var_120_14)
								local var_120_17 = Mathf.Lerp(iter_120_1.color.b, arg_117_1.hightColor1.b, var_120_14)

								iter_120_1.color = Color.New(var_120_15, var_120_16, var_120_17)
							else
								local var_120_18 = Mathf.Lerp(iter_120_1.color.r, 1, var_120_14)

								iter_120_1.color = Color.New(var_120_18, var_120_18, var_120_18)
							end
						end
					end
				end
			end

			if arg_117_1.time_ >= var_120_12 + var_120_13 and arg_117_1.time_ < var_120_12 + var_120_13 + arg_120_0 and not isNil(var_120_11) and arg_117_1.var_.actorSpriteComps10030 then
				for iter_120_2, iter_120_3 in pairs(arg_117_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_120_3 then
						if arg_117_1.isInRecall_ then
							iter_120_3.color = arg_117_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_120_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_117_1.var_.actorSpriteComps10030 = nil
			end

			local var_120_19 = arg_117_1.actors_["10030"].transform
			local var_120_20 = 0

			if var_120_20 < arg_117_1.time_ and arg_117_1.time_ <= var_120_20 + arg_120_0 then
				arg_117_1.var_.moveOldPos10030 = var_120_19.localPosition
				var_120_19.localScale = Vector3.New(1, 1, 1)

				arg_117_1:CheckSpriteTmpPos("10030", 4)

				local var_120_21 = var_120_19.childCount

				for iter_120_4 = 0, var_120_21 - 1 do
					local var_120_22 = var_120_19:GetChild(iter_120_4)

					if var_120_22.name == "split_3" or not string.find(var_120_22.name, "split") then
						var_120_22.gameObject:SetActive(true)
					else
						var_120_22.gameObject:SetActive(false)
					end
				end
			end

			local var_120_23 = 0.001

			if var_120_20 <= arg_117_1.time_ and arg_117_1.time_ < var_120_20 + var_120_23 then
				local var_120_24 = (arg_117_1.time_ - var_120_20) / var_120_23
				local var_120_25 = Vector3.New(390, -390, 150)

				var_120_19.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos10030, var_120_25, var_120_24)
			end

			if arg_117_1.time_ >= var_120_20 + var_120_23 and arg_117_1.time_ < var_120_20 + var_120_23 + arg_120_0 then
				var_120_19.localPosition = Vector3.New(390, -390, 150)
			end

			local var_120_26 = 0
			local var_120_27 = 0.75

			if var_120_26 < arg_117_1.time_ and arg_117_1.time_ <= var_120_26 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				local var_120_28 = arg_117_1:FormatText(StoryNameCfg[309].name)

				arg_117_1.leftNameTxt_.text = var_120_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_29 = arg_117_1:GetWordFromCfg(115281027)
				local var_120_30 = arg_117_1:FormatText(var_120_29.content)

				arg_117_1.text_.text = var_120_30

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_31 = 30
				local var_120_32 = utf8.len(var_120_30)
				local var_120_33 = var_120_31 <= 0 and var_120_27 or var_120_27 * (var_120_32 / var_120_31)

				if var_120_33 > 0 and var_120_27 < var_120_33 then
					arg_117_1.talkMaxDuration = var_120_33

					if var_120_33 + var_120_26 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_33 + var_120_26
					end
				end

				arg_117_1.text_.text = var_120_30
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115281", "115281027", "story_v_out_115281.awb") ~= 0 then
					local var_120_34 = manager.audio:GetVoiceLength("story_v_out_115281", "115281027", "story_v_out_115281.awb") / 1000

					if var_120_34 + var_120_26 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_34 + var_120_26
					end

					if var_120_29.prefab_name ~= "" and arg_117_1.actors_[var_120_29.prefab_name] ~= nil then
						local var_120_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_29.prefab_name].transform, "story_v_out_115281", "115281027", "story_v_out_115281.awb")

						arg_117_1:RecordAudio("115281027", var_120_35)
						arg_117_1:RecordAudio("115281027", var_120_35)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_115281", "115281027", "story_v_out_115281.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_115281", "115281027", "story_v_out_115281.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_36 = math.max(var_120_27, arg_117_1.talkMaxDuration)

			if var_120_26 <= arg_117_1.time_ and arg_117_1.time_ < var_120_26 + var_120_36 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_26) / var_120_36

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_26 + var_120_36 and arg_117_1.time_ < var_120_26 + var_120_36 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {
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

		arg_117_1:InitPlayNodeList()
	end,
	Play115281028 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 115281028
		arg_121_1.duration_ = 5

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play115281029(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = arg_121_1.actors_["10029"]
			local var_124_1 = 0

			if var_124_1 < arg_121_1.time_ and arg_121_1.time_ <= var_124_1 + arg_124_0 then
				local var_124_2 = var_124_0:GetComponent("Image")

				if var_124_2 then
					arg_121_1.var_.alphaMatValue10029 = var_124_2
					arg_121_1.var_.alphaOldValue10029 = var_124_2.color.a
				end

				arg_121_1.var_.alphaOldValue10029 = 1
			end

			local var_124_3 = 0.333333333333333

			if var_124_1 <= arg_121_1.time_ and arg_121_1.time_ < var_124_1 + var_124_3 then
				local var_124_4 = (arg_121_1.time_ - var_124_1) / var_124_3
				local var_124_5 = Mathf.Lerp(arg_121_1.var_.alphaOldValue10029, 0, var_124_4)

				if arg_121_1.var_.alphaMatValue10029 then
					local var_124_6 = arg_121_1.var_.alphaMatValue10029.color

					var_124_6.a = var_124_5
					arg_121_1.var_.alphaMatValue10029.color = var_124_6
				end
			end

			if arg_121_1.time_ >= var_124_1 + var_124_3 and arg_121_1.time_ < var_124_1 + var_124_3 + arg_124_0 and arg_121_1.var_.alphaMatValue10029 then
				local var_124_7 = arg_121_1.var_.alphaMatValue10029
				local var_124_8 = var_124_7.color

				var_124_8.a = 0
				var_124_7.color = var_124_8
			end

			local var_124_9 = arg_121_1.actors_["10030"]
			local var_124_10 = 0

			if var_124_10 < arg_121_1.time_ and arg_121_1.time_ <= var_124_10 + arg_124_0 then
				local var_124_11 = var_124_9:GetComponentInChildren(typeof(CanvasGroup))

				if var_124_11 then
					arg_121_1.var_.alphaOldValue10030 = var_124_11.alpha
					arg_121_1.var_.characterEffect10030 = var_124_11
				end

				arg_121_1.var_.alphaOldValue10030 = 1
			end

			local var_124_12 = 0.333333333333333

			if var_124_10 <= arg_121_1.time_ and arg_121_1.time_ < var_124_10 + var_124_12 then
				local var_124_13 = (arg_121_1.time_ - var_124_10) / var_124_12
				local var_124_14 = Mathf.Lerp(arg_121_1.var_.alphaOldValue10030, 0, var_124_13)

				if arg_121_1.var_.characterEffect10030 then
					arg_121_1.var_.characterEffect10030.alpha = var_124_14
				end
			end

			if arg_121_1.time_ >= var_124_10 + var_124_12 and arg_121_1.time_ < var_124_10 + var_124_12 + arg_124_0 and arg_121_1.var_.characterEffect10030 then
				arg_121_1.var_.characterEffect10030.alpha = 0
			end

			local var_124_15 = 0
			local var_124_16 = 0.5

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

				local var_124_17 = arg_121_1:GetWordFromCfg(115281028)
				local var_124_18 = arg_121_1:FormatText(var_124_17.content)

				arg_121_1.text_.text = var_124_18

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_19 = 20
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

		arg_121_1.nodeConfigList_ = {}

		arg_121_1:InitPlayNodeList()
	end,
	Play115281029 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 115281029
		arg_125_1.duration_ = 13.2

		local var_125_0 = {
			ja = 11.466,
			ko = 11.3,
			zh = 11.933,
			en = 13.2
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
				arg_125_0:Play115281030(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = arg_125_1.actors_["10029"].transform
			local var_128_1 = 0

			if var_128_1 < arg_125_1.time_ and arg_125_1.time_ <= var_128_1 + arg_128_0 then
				arg_125_1.var_.moveOldPos10029 = var_128_0.localPosition
				var_128_0.localScale = Vector3.New(1, 1, 1)

				arg_125_1:CheckSpriteTmpPos("10029", 3)
			end

			local var_128_2 = 0.001

			if var_128_1 <= arg_125_1.time_ and arg_125_1.time_ < var_128_1 + var_128_2 then
				local var_128_3 = (arg_125_1.time_ - var_128_1) / var_128_2
				local var_128_4 = Vector3.New(0, -350, -180)

				var_128_0.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos10029, var_128_4, var_128_3)
			end

			if arg_125_1.time_ >= var_128_1 + var_128_2 and arg_125_1.time_ < var_128_1 + var_128_2 + arg_128_0 then
				var_128_0.localPosition = Vector3.New(0, -350, -180)
			end

			local var_128_5 = arg_125_1.actors_["10029"]
			local var_128_6 = 0

			if var_128_6 < arg_125_1.time_ and arg_125_1.time_ <= var_128_6 + arg_128_0 and not isNil(var_128_5) then
				local var_128_7 = var_128_5:GetComponent("Image")

				if var_128_7 then
					arg_125_1.var_.highlightMatValue10029 = var_128_7
				end
			end

			local var_128_8 = 0.2

			if var_128_6 <= arg_125_1.time_ and arg_125_1.time_ < var_128_6 + var_128_8 and not isNil(var_128_5) then
				local var_128_9 = (arg_125_1.time_ - var_128_6) / var_128_8

				if arg_125_1.var_.highlightMatValue10029 then
					local var_128_10 = Mathf.Lerp(0.5, 1, var_128_9)
					local var_128_11 = arg_125_1.var_.highlightMatValue10029
					local var_128_12 = var_128_11.color

					var_128_12.r = var_128_10
					var_128_12.g = var_128_10
					var_128_12.b = var_128_10
					var_128_11.color = var_128_12
				end
			end

			if arg_125_1.time_ >= var_128_6 + var_128_8 and arg_125_1.time_ < var_128_6 + var_128_8 + arg_128_0 and not isNil(var_128_5) and arg_125_1.var_.highlightMatValue10029 then
				local var_128_13 = 1

				var_128_5.transform:SetSiblingIndex(1)

				local var_128_14 = arg_125_1.var_.highlightMatValue10029
				local var_128_15 = var_128_14.color

				var_128_15.r = var_128_13
				var_128_15.g = var_128_13
				var_128_15.b = var_128_13
				var_128_14.color = var_128_15
			end

			local var_128_16 = arg_125_1.actors_["10029"]
			local var_128_17 = 0

			if var_128_17 < arg_125_1.time_ and arg_125_1.time_ <= var_128_17 + arg_128_0 then
				local var_128_18 = var_128_16:GetComponent("Image")

				if var_128_18 then
					arg_125_1.var_.alphaMatValue10029 = var_128_18
					arg_125_1.var_.alphaOldValue10029 = var_128_18.color.a
				end

				arg_125_1.var_.alphaOldValue10029 = 0
			end

			local var_128_19 = 0.333333333333333

			if var_128_17 <= arg_125_1.time_ and arg_125_1.time_ < var_128_17 + var_128_19 then
				local var_128_20 = (arg_125_1.time_ - var_128_17) / var_128_19
				local var_128_21 = Mathf.Lerp(arg_125_1.var_.alphaOldValue10029, 1, var_128_20)

				if arg_125_1.var_.alphaMatValue10029 then
					local var_128_22 = arg_125_1.var_.alphaMatValue10029.color

					var_128_22.a = var_128_21
					arg_125_1.var_.alphaMatValue10029.color = var_128_22
				end
			end

			if arg_125_1.time_ >= var_128_17 + var_128_19 and arg_125_1.time_ < var_128_17 + var_128_19 + arg_128_0 and arg_125_1.var_.alphaMatValue10029 then
				local var_128_23 = arg_125_1.var_.alphaMatValue10029
				local var_128_24 = var_128_23.color

				var_128_24.a = 1
				var_128_23.color = var_128_24
			end

			local var_128_25 = 0
			local var_128_26 = 1.15

			if var_128_25 < arg_125_1.time_ and arg_125_1.time_ <= var_128_25 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				local var_128_27 = arg_125_1:FormatText(StoryNameCfg[312].name)

				arg_125_1.leftNameTxt_.text = var_128_27

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_28 = arg_125_1:GetWordFromCfg(115281029)
				local var_128_29 = arg_125_1:FormatText(var_128_28.content)

				arg_125_1.text_.text = var_128_29

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_30 = 46
				local var_128_31 = utf8.len(var_128_29)
				local var_128_32 = var_128_30 <= 0 and var_128_26 or var_128_26 * (var_128_31 / var_128_30)

				if var_128_32 > 0 and var_128_26 < var_128_32 then
					arg_125_1.talkMaxDuration = var_128_32

					if var_128_32 + var_128_25 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_32 + var_128_25
					end
				end

				arg_125_1.text_.text = var_128_29
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115281", "115281029", "story_v_out_115281.awb") ~= 0 then
					local var_128_33 = manager.audio:GetVoiceLength("story_v_out_115281", "115281029", "story_v_out_115281.awb") / 1000

					if var_128_33 + var_128_25 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_33 + var_128_25
					end

					if var_128_28.prefab_name ~= "" and arg_125_1.actors_[var_128_28.prefab_name] ~= nil then
						local var_128_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_28.prefab_name].transform, "story_v_out_115281", "115281029", "story_v_out_115281.awb")

						arg_125_1:RecordAudio("115281029", var_128_34)
						arg_125_1:RecordAudio("115281029", var_128_34)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_115281", "115281029", "story_v_out_115281.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_115281", "115281029", "story_v_out_115281.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_35 = math.max(var_128_26, arg_125_1.talkMaxDuration)

			if var_128_25 <= arg_125_1.time_ and arg_125_1.time_ < var_128_25 + var_128_35 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_25) / var_128_35

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_25 + var_128_35 and arg_125_1.time_ < var_128_25 + var_128_35 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {
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

		arg_125_1:InitPlayNodeList()
	end,
	Play115281030 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 115281030
		arg_129_1.duration_ = 15.47

		local var_129_0 = {
			ja = 15.466,
			ko = 13.933,
			zh = 13.133,
			en = 14.966
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
				arg_129_0:Play115281031(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = 0
			local var_132_1 = 1.475

			if var_132_0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_0 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				local var_132_2 = arg_129_1:FormatText(StoryNameCfg[312].name)

				arg_129_1.leftNameTxt_.text = var_132_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_3 = arg_129_1:GetWordFromCfg(115281030)
				local var_132_4 = arg_129_1:FormatText(var_132_3.content)

				arg_129_1.text_.text = var_132_4

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_5 = 59
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

				if manager.audio:GetVoiceLength("story_v_out_115281", "115281030", "story_v_out_115281.awb") ~= 0 then
					local var_132_8 = manager.audio:GetVoiceLength("story_v_out_115281", "115281030", "story_v_out_115281.awb") / 1000

					if var_132_8 + var_132_0 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_8 + var_132_0
					end

					if var_132_3.prefab_name ~= "" and arg_129_1.actors_[var_132_3.prefab_name] ~= nil then
						local var_132_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_3.prefab_name].transform, "story_v_out_115281", "115281030", "story_v_out_115281.awb")

						arg_129_1:RecordAudio("115281030", var_132_9)
						arg_129_1:RecordAudio("115281030", var_132_9)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_115281", "115281030", "story_v_out_115281.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_115281", "115281030", "story_v_out_115281.awb")
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
	Play115281031 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 115281031
		arg_133_1.duration_ = 5

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play115281032(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = arg_133_1.actors_["10029"]
			local var_136_1 = 0

			if var_136_1 < arg_133_1.time_ and arg_133_1.time_ <= var_136_1 + arg_136_0 then
				local var_136_2 = var_136_0:GetComponent("Image")

				if var_136_2 then
					arg_133_1.var_.alphaMatValue10029 = var_136_2
					arg_133_1.var_.alphaOldValue10029 = var_136_2.color.a
				end

				arg_133_1.var_.alphaOldValue10029 = 1
			end

			local var_136_3 = 0.333333333333333

			if var_136_1 <= arg_133_1.time_ and arg_133_1.time_ < var_136_1 + var_136_3 then
				local var_136_4 = (arg_133_1.time_ - var_136_1) / var_136_3
				local var_136_5 = Mathf.Lerp(arg_133_1.var_.alphaOldValue10029, 0, var_136_4)

				if arg_133_1.var_.alphaMatValue10029 then
					local var_136_6 = arg_133_1.var_.alphaMatValue10029.color

					var_136_6.a = var_136_5
					arg_133_1.var_.alphaMatValue10029.color = var_136_6
				end
			end

			if arg_133_1.time_ >= var_136_1 + var_136_3 and arg_133_1.time_ < var_136_1 + var_136_3 + arg_136_0 and arg_133_1.var_.alphaMatValue10029 then
				local var_136_7 = arg_133_1.var_.alphaMatValue10029
				local var_136_8 = var_136_7.color

				var_136_8.a = 0
				var_136_7.color = var_136_8
			end

			local var_136_9 = 0
			local var_136_10 = 1.125

			if var_136_9 < arg_133_1.time_ and arg_133_1.time_ <= var_136_9 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, false)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_11 = arg_133_1:GetWordFromCfg(115281031)
				local var_136_12 = arg_133_1:FormatText(var_136_11.content)

				arg_133_1.text_.text = var_136_12

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_13 = 45
				local var_136_14 = utf8.len(var_136_12)
				local var_136_15 = var_136_13 <= 0 and var_136_10 or var_136_10 * (var_136_14 / var_136_13)

				if var_136_15 > 0 and var_136_10 < var_136_15 then
					arg_133_1.talkMaxDuration = var_136_15

					if var_136_15 + var_136_9 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_15 + var_136_9
					end
				end

				arg_133_1.text_.text = var_136_12
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)
				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_16 = math.max(var_136_10, arg_133_1.talkMaxDuration)

			if var_136_9 <= arg_133_1.time_ and arg_133_1.time_ < var_136_9 + var_136_16 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_9) / var_136_16

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_9 + var_136_16 and arg_133_1.time_ < var_136_9 + var_136_16 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play115281032 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 115281032
		arg_137_1.duration_ = 17.43

		local var_137_0 = {
			ja = 14.333,
			ko = 16.366,
			zh = 13.866,
			en = 17.433
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
				arg_137_0:Play115281033(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = arg_137_1.actors_["10029"]
			local var_140_1 = 0

			if var_140_1 < arg_137_1.time_ and arg_137_1.time_ <= var_140_1 + arg_140_0 then
				local var_140_2 = var_140_0:GetComponent("Image")

				if var_140_2 then
					arg_137_1.var_.alphaMatValue10029 = var_140_2
					arg_137_1.var_.alphaOldValue10029 = var_140_2.color.a
				end

				arg_137_1.var_.alphaOldValue10029 = 0
			end

			local var_140_3 = 0.333333333333333

			if var_140_1 <= arg_137_1.time_ and arg_137_1.time_ < var_140_1 + var_140_3 then
				local var_140_4 = (arg_137_1.time_ - var_140_1) / var_140_3
				local var_140_5 = Mathf.Lerp(arg_137_1.var_.alphaOldValue10029, 1, var_140_4)

				if arg_137_1.var_.alphaMatValue10029 then
					local var_140_6 = arg_137_1.var_.alphaMatValue10029.color

					var_140_6.a = var_140_5
					arg_137_1.var_.alphaMatValue10029.color = var_140_6
				end
			end

			if arg_137_1.time_ >= var_140_1 + var_140_3 and arg_137_1.time_ < var_140_1 + var_140_3 + arg_140_0 and arg_137_1.var_.alphaMatValue10029 then
				local var_140_7 = arg_137_1.var_.alphaMatValue10029
				local var_140_8 = var_140_7.color

				var_140_8.a = 1
				var_140_7.color = var_140_8
			end

			local var_140_9 = 0
			local var_140_10 = 1.225

			if var_140_9 < arg_137_1.time_ and arg_137_1.time_ <= var_140_9 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				local var_140_11 = arg_137_1:FormatText(StoryNameCfg[312].name)

				arg_137_1.leftNameTxt_.text = var_140_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_12 = arg_137_1:GetWordFromCfg(115281032)
				local var_140_13 = arg_137_1:FormatText(var_140_12.content)

				arg_137_1.text_.text = var_140_13

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_14 = 49
				local var_140_15 = utf8.len(var_140_13)
				local var_140_16 = var_140_14 <= 0 and var_140_10 or var_140_10 * (var_140_15 / var_140_14)

				if var_140_16 > 0 and var_140_10 < var_140_16 then
					arg_137_1.talkMaxDuration = var_140_16

					if var_140_16 + var_140_9 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_16 + var_140_9
					end
				end

				arg_137_1.text_.text = var_140_13
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115281", "115281032", "story_v_out_115281.awb") ~= 0 then
					local var_140_17 = manager.audio:GetVoiceLength("story_v_out_115281", "115281032", "story_v_out_115281.awb") / 1000

					if var_140_17 + var_140_9 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_17 + var_140_9
					end

					if var_140_12.prefab_name ~= "" and arg_137_1.actors_[var_140_12.prefab_name] ~= nil then
						local var_140_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_12.prefab_name].transform, "story_v_out_115281", "115281032", "story_v_out_115281.awb")

						arg_137_1:RecordAudio("115281032", var_140_18)
						arg_137_1:RecordAudio("115281032", var_140_18)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_115281", "115281032", "story_v_out_115281.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_115281", "115281032", "story_v_out_115281.awb")
				end

				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_19 = math.max(var_140_10, arg_137_1.talkMaxDuration)

			if var_140_9 <= arg_137_1.time_ and arg_137_1.time_ < var_140_9 + var_140_19 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_9) / var_140_19

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_9 + var_140_19 and arg_137_1.time_ < var_140_9 + var_140_19 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play115281033 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 115281033
		arg_141_1.duration_ = 9.87

		local var_141_0 = {
			ja = 8.333,
			ko = 8.8,
			zh = 5.233,
			en = 9.866
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
				arg_141_0:Play115281034(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = 0
			local var_144_1 = 0.625

			if var_144_0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_0 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				local var_144_2 = arg_141_1:FormatText(StoryNameCfg[312].name)

				arg_141_1.leftNameTxt_.text = var_144_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_3 = arg_141_1:GetWordFromCfg(115281033)
				local var_144_4 = arg_141_1:FormatText(var_144_3.content)

				arg_141_1.text_.text = var_144_4

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_5 = 25
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

				if manager.audio:GetVoiceLength("story_v_out_115281", "115281033", "story_v_out_115281.awb") ~= 0 then
					local var_144_8 = manager.audio:GetVoiceLength("story_v_out_115281", "115281033", "story_v_out_115281.awb") / 1000

					if var_144_8 + var_144_0 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_8 + var_144_0
					end

					if var_144_3.prefab_name ~= "" and arg_141_1.actors_[var_144_3.prefab_name] ~= nil then
						local var_144_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_3.prefab_name].transform, "story_v_out_115281", "115281033", "story_v_out_115281.awb")

						arg_141_1:RecordAudio("115281033", var_144_9)
						arg_141_1:RecordAudio("115281033", var_144_9)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_115281", "115281033", "story_v_out_115281.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_115281", "115281033", "story_v_out_115281.awb")
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
	Play115281034 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 115281034
		arg_145_1.duration_ = 9

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play115281035(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = 2

			if var_148_0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_0 + arg_148_0 then
				local var_148_1 = manager.ui.mainCamera.transform.localPosition
				local var_148_2 = Vector3.New(0, 0, 10) + Vector3.New(var_148_1.x, var_148_1.y, 0)
				local var_148_3 = arg_145_1.bgs_.STblack

				var_148_3.transform.localPosition = var_148_2
				var_148_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_148_4 = var_148_3:GetComponent("SpriteRenderer")

				if var_148_4 and var_148_4.sprite then
					local var_148_5 = (var_148_3.transform.localPosition - var_148_1).z
					local var_148_6 = manager.ui.mainCameraCom_
					local var_148_7 = 2 * var_148_5 * Mathf.Tan(var_148_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_148_8 = var_148_7 * var_148_6.aspect
					local var_148_9 = var_148_4.sprite.bounds.size.x
					local var_148_10 = var_148_4.sprite.bounds.size.y
					local var_148_11 = var_148_8 / var_148_9
					local var_148_12 = var_148_7 / var_148_10
					local var_148_13 = var_148_12 < var_148_11 and var_148_11 or var_148_12

					var_148_3.transform.localScale = Vector3.New(var_148_13, var_148_13, 0)
				end

				for iter_148_0, iter_148_1 in pairs(arg_145_1.bgs_) do
					if iter_148_0 ~= "STblack" then
						iter_148_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_148_14 = 0

			if var_148_14 < arg_145_1.time_ and arg_145_1.time_ <= var_148_14 + arg_148_0 then
				arg_145_1.mask_.enabled = true
				arg_145_1.mask_.raycastTarget = false

				arg_145_1:SetGaussion(false)
			end

			local var_148_15 = 2

			if var_148_14 <= arg_145_1.time_ and arg_145_1.time_ < var_148_14 + var_148_15 then
				local var_148_16 = (arg_145_1.time_ - var_148_14) / var_148_15
				local var_148_17 = Color.New(0, 0, 0)

				var_148_17.a = Mathf.Lerp(0, 1, var_148_16)
				arg_145_1.mask_.color = var_148_17
			end

			if arg_145_1.time_ >= var_148_14 + var_148_15 and arg_145_1.time_ < var_148_14 + var_148_15 + arg_148_0 then
				local var_148_18 = Color.New(0, 0, 0)

				var_148_18.a = 1
				arg_145_1.mask_.color = var_148_18
			end

			local var_148_19 = 2

			if var_148_19 < arg_145_1.time_ and arg_145_1.time_ <= var_148_19 + arg_148_0 then
				arg_145_1.mask_.enabled = true
				arg_145_1.mask_.raycastTarget = false

				arg_145_1:SetGaussion(false)
			end

			local var_148_20 = 2

			if var_148_19 <= arg_145_1.time_ and arg_145_1.time_ < var_148_19 + var_148_20 then
				local var_148_21 = (arg_145_1.time_ - var_148_19) / var_148_20
				local var_148_22 = Color.New(0, 0, 0)

				var_148_22.a = Mathf.Lerp(1, 0, var_148_21)
				arg_145_1.mask_.color = var_148_22
			end

			if arg_145_1.time_ >= var_148_19 + var_148_20 and arg_145_1.time_ < var_148_19 + var_148_20 + arg_148_0 then
				local var_148_23 = Color.New(0, 0, 0)
				local var_148_24 = 0

				arg_145_1.mask_.enabled = false
				var_148_23.a = var_148_24
				arg_145_1.mask_.color = var_148_23
			end

			local var_148_25 = arg_145_1.actors_["10029"].transform
			local var_148_26 = 1.99933333333333

			if var_148_26 < arg_145_1.time_ and arg_145_1.time_ <= var_148_26 + arg_148_0 then
				arg_145_1.var_.moveOldPos10029 = var_148_25.localPosition
				var_148_25.localScale = Vector3.New(1, 1, 1)

				arg_145_1:CheckSpriteTmpPos("10029", 0)
			end

			local var_148_27 = 0.001

			if var_148_26 <= arg_145_1.time_ and arg_145_1.time_ < var_148_26 + var_148_27 then
				local var_148_28 = (arg_145_1.time_ - var_148_26) / var_148_27
				local var_148_29 = Vector3.New(-1500, -350, -180)

				var_148_25.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos10029, var_148_29, var_148_28)
			end

			if arg_145_1.time_ >= var_148_26 + var_148_27 and arg_145_1.time_ < var_148_26 + var_148_27 + arg_148_0 then
				var_148_25.localPosition = Vector3.New(-1500, -350, -180)
			end

			if arg_145_1.frameCnt_ <= 1 then
				arg_145_1.dialog_:SetActive(false)
			end

			local var_148_30 = 4
			local var_148_31 = 0.425

			if var_148_30 < arg_145_1.time_ and arg_145_1.time_ <= var_148_30 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0

				arg_145_1.dialog_:SetActive(true)

				arg_145_1.dialogCg_.alpha = 0

				local var_148_32 = LeanTween.value(arg_145_1.dialog_, 0, 1, 0.3)

				var_148_32:setOnUpdate(LuaHelper.FloatAction(function(arg_149_0)
					arg_145_1.dialogCg_.alpha = arg_149_0
				end))
				var_148_32:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_145_1.dialog_)
					var_148_32:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_145_1.duration_ = arg_145_1.duration_ + 0.3

				SetActive(arg_145_1.leftNameGo_, false)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_33 = arg_145_1:GetWordFromCfg(115281034)
				local var_148_34 = arg_145_1:FormatText(var_148_33.content)

				arg_145_1.text_.text = var_148_34

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_35 = 17
				local var_148_36 = utf8.len(var_148_34)
				local var_148_37 = var_148_35 <= 0 and var_148_31 or var_148_31 * (var_148_36 / var_148_35)

				if var_148_37 > 0 and var_148_31 < var_148_37 then
					arg_145_1.talkMaxDuration = var_148_37
					var_148_30 = var_148_30 + 0.3

					if var_148_37 + var_148_30 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_37 + var_148_30
					end
				end

				arg_145_1.text_.text = var_148_34
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)
				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_38 = var_148_30 + 0.3
			local var_148_39 = math.max(var_148_31, arg_145_1.talkMaxDuration)

			if var_148_38 <= arg_145_1.time_ and arg_145_1.time_ < var_148_38 + var_148_39 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_38) / var_148_39

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_38 + var_148_39 and arg_145_1.time_ < var_148_38 + var_148_39 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10029",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.99933333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Sprite
			}
		}

		arg_145_1:InitPlayNodeList()
	end,
	Play115281035 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 115281035
		arg_151_1.duration_ = 5

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play115281036(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = 0
			local var_154_1 = 1.175

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

				local var_154_2 = arg_151_1:GetWordFromCfg(115281035)
				local var_154_3 = arg_151_1:FormatText(var_154_2.content)

				arg_151_1.text_.text = var_154_3

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_4 = 47
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
	Play115281036 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 115281036
		arg_155_1.duration_ = 5

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play115281037(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = 0
			local var_158_1 = 0.55

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

				local var_158_2 = arg_155_1:GetWordFromCfg(115281036)
				local var_158_3 = arg_155_1:FormatText(var_158_2.content)

				arg_155_1.text_.text = var_158_3

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_4 = 22
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
	Play115281037 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 115281037
		arg_159_1.duration_ = 17.1

		local var_159_0 = {
			ja = 13.6,
			ko = 13.6,
			zh = 12.933,
			en = 17.1
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
				arg_159_0:Play115281038(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_0 = 1

			if var_162_0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_0 + arg_162_0 then
				local var_162_1 = manager.ui.mainCamera.transform.localPosition
				local var_162_2 = Vector3.New(0, 0, 10) + Vector3.New(var_162_1.x, var_162_1.y, 0)
				local var_162_3 = arg_159_1.bgs_.ST28a

				var_162_3.transform.localPosition = var_162_2
				var_162_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_162_4 = var_162_3:GetComponent("SpriteRenderer")

				if var_162_4 and var_162_4.sprite then
					local var_162_5 = (var_162_3.transform.localPosition - var_162_1).z
					local var_162_6 = manager.ui.mainCameraCom_
					local var_162_7 = 2 * var_162_5 * Mathf.Tan(var_162_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_162_8 = var_162_7 * var_162_6.aspect
					local var_162_9 = var_162_4.sprite.bounds.size.x
					local var_162_10 = var_162_4.sprite.bounds.size.y
					local var_162_11 = var_162_8 / var_162_9
					local var_162_12 = var_162_7 / var_162_10
					local var_162_13 = var_162_12 < var_162_11 and var_162_11 or var_162_12

					var_162_3.transform.localScale = Vector3.New(var_162_13, var_162_13, 0)
				end

				for iter_162_0, iter_162_1 in pairs(arg_159_1.bgs_) do
					if iter_162_0 ~= "ST28a" then
						iter_162_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_162_14 = 1

			if var_162_14 < arg_159_1.time_ and arg_159_1.time_ <= var_162_14 + arg_162_0 then
				arg_159_1.mask_.enabled = true
				arg_159_1.mask_.raycastTarget = false

				arg_159_1:SetGaussion(false)
			end

			local var_162_15 = 2

			if var_162_14 <= arg_159_1.time_ and arg_159_1.time_ < var_162_14 + var_162_15 then
				local var_162_16 = (arg_159_1.time_ - var_162_14) / var_162_15
				local var_162_17 = Color.New(0, 0, 0)

				var_162_17.a = Mathf.Lerp(1, 0, var_162_16)
				arg_159_1.mask_.color = var_162_17
			end

			if arg_159_1.time_ >= var_162_14 + var_162_15 and arg_159_1.time_ < var_162_14 + var_162_15 + arg_162_0 then
				local var_162_18 = Color.New(0, 0, 0)
				local var_162_19 = 0

				arg_159_1.mask_.enabled = false
				var_162_18.a = var_162_19
				arg_159_1.mask_.color = var_162_18
			end

			if arg_159_1.frameCnt_ <= 1 then
				arg_159_1.dialog_:SetActive(false)
			end

			local var_162_20 = 3
			local var_162_21 = 0.85

			if var_162_20 < arg_159_1.time_ and arg_159_1.time_ <= var_162_20 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0

				arg_159_1.dialog_:SetActive(true)

				arg_159_1.dialogCg_.alpha = 0

				local var_162_22 = LeanTween.value(arg_159_1.dialog_, 0, 1, 0.3)

				var_162_22:setOnUpdate(LuaHelper.FloatAction(function(arg_163_0)
					arg_159_1.dialogCg_.alpha = arg_163_0
				end))
				var_162_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_159_1.dialog_)
					var_162_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_159_1.duration_ = arg_159_1.duration_ + 0.3

				SetActive(arg_159_1.leftNameGo_, true)

				local var_162_23 = arg_159_1:FormatText(StoryNameCfg[224].name)

				arg_159_1.leftNameTxt_.text = var_162_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, true)
				arg_159_1.iconController_:SetSelectedState("hero")

				arg_159_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_clerkb")

				arg_159_1.callingController_:SetSelectedState("normal")

				arg_159_1.keyicon_.color = Color.New(1, 1, 1)
				arg_159_1.icon_.color = Color.New(1, 1, 1)

				local var_162_24 = arg_159_1:GetWordFromCfg(115281037)
				local var_162_25 = arg_159_1:FormatText(var_162_24.content)

				arg_159_1.text_.text = var_162_25

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_26 = 34
				local var_162_27 = utf8.len(var_162_25)
				local var_162_28 = var_162_26 <= 0 and var_162_21 or var_162_21 * (var_162_27 / var_162_26)

				if var_162_28 > 0 and var_162_21 < var_162_28 then
					arg_159_1.talkMaxDuration = var_162_28
					var_162_20 = var_162_20 + 0.3

					if var_162_28 + var_162_20 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_28 + var_162_20
					end
				end

				arg_159_1.text_.text = var_162_25
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115281", "115281037", "story_v_out_115281.awb") ~= 0 then
					local var_162_29 = manager.audio:GetVoiceLength("story_v_out_115281", "115281037", "story_v_out_115281.awb") / 1000

					if var_162_29 + var_162_20 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_29 + var_162_20
					end

					if var_162_24.prefab_name ~= "" and arg_159_1.actors_[var_162_24.prefab_name] ~= nil then
						local var_162_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_24.prefab_name].transform, "story_v_out_115281", "115281037", "story_v_out_115281.awb")

						arg_159_1:RecordAudio("115281037", var_162_30)
						arg_159_1:RecordAudio("115281037", var_162_30)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_out_115281", "115281037", "story_v_out_115281.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_out_115281", "115281037", "story_v_out_115281.awb")
				end

				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_31 = var_162_20 + 0.3
			local var_162_32 = math.max(var_162_21, arg_159_1.talkMaxDuration)

			if var_162_31 <= arg_159_1.time_ and arg_159_1.time_ < var_162_31 + var_162_32 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_31) / var_162_32

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_31 + var_162_32 and arg_159_1.time_ < var_162_31 + var_162_32 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {}

		arg_159_1:InitPlayNodeList()
	end,
	Play115281038 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 115281038
		arg_165_1.duration_ = 5

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play115281039(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = 0
			local var_168_1 = 0.65

			if var_168_0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_0 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, false)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_2 = arg_165_1:GetWordFromCfg(115281038)
				local var_168_3 = arg_165_1:FormatText(var_168_2.content)

				arg_165_1.text_.text = var_168_3

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_4 = 26
				local var_168_5 = utf8.len(var_168_3)
				local var_168_6 = var_168_4 <= 0 and var_168_1 or var_168_1 * (var_168_5 / var_168_4)

				if var_168_6 > 0 and var_168_1 < var_168_6 then
					arg_165_1.talkMaxDuration = var_168_6

					if var_168_6 + var_168_0 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_6 + var_168_0
					end
				end

				arg_165_1.text_.text = var_168_3
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)
				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_7 = math.max(var_168_1, arg_165_1.talkMaxDuration)

			if var_168_0 <= arg_165_1.time_ and arg_165_1.time_ < var_168_0 + var_168_7 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_0) / var_168_7

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_0 + var_168_7 and arg_165_1.time_ < var_168_0 + var_168_7 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {}

		arg_165_1:InitPlayNodeList()
	end,
	Play115281039 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 115281039
		arg_169_1.duration_ = 5

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play115281040(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = 0
			local var_172_1 = 1.675

			if var_172_0 < arg_169_1.time_ and arg_169_1.time_ <= var_172_0 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, false)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_2 = arg_169_1:GetWordFromCfg(115281039)
				local var_172_3 = arg_169_1:FormatText(var_172_2.content)

				arg_169_1.text_.text = var_172_3

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_4 = 67
				local var_172_5 = utf8.len(var_172_3)
				local var_172_6 = var_172_4 <= 0 and var_172_1 or var_172_1 * (var_172_5 / var_172_4)

				if var_172_6 > 0 and var_172_1 < var_172_6 then
					arg_169_1.talkMaxDuration = var_172_6

					if var_172_6 + var_172_0 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_6 + var_172_0
					end
				end

				arg_169_1.text_.text = var_172_3
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)
				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_7 = math.max(var_172_1, arg_169_1.talkMaxDuration)

			if var_172_0 <= arg_169_1.time_ and arg_169_1.time_ < var_172_0 + var_172_7 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_0) / var_172_7

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_0 + var_172_7 and arg_169_1.time_ < var_172_0 + var_172_7 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {}

		arg_169_1:InitPlayNodeList()
	end,
	Play115281040 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 115281040
		arg_173_1.duration_ = 5

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play115281041(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			local var_176_0 = 0
			local var_176_1 = 1.375

			if var_176_0 < arg_173_1.time_ and arg_173_1.time_ <= var_176_0 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, false)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_2 = arg_173_1:GetWordFromCfg(115281040)
				local var_176_3 = arg_173_1:FormatText(var_176_2.content)

				arg_173_1.text_.text = var_176_3

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_4 = 55
				local var_176_5 = utf8.len(var_176_3)
				local var_176_6 = var_176_4 <= 0 and var_176_1 or var_176_1 * (var_176_5 / var_176_4)

				if var_176_6 > 0 and var_176_1 < var_176_6 then
					arg_173_1.talkMaxDuration = var_176_6

					if var_176_6 + var_176_0 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_6 + var_176_0
					end
				end

				arg_173_1.text_.text = var_176_3
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)
				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_7 = math.max(var_176_1, arg_173_1.talkMaxDuration)

			if var_176_0 <= arg_173_1.time_ and arg_173_1.time_ < var_176_0 + var_176_7 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_0) / var_176_7

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_0 + var_176_7 and arg_173_1.time_ < var_176_0 + var_176_7 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {}

		arg_173_1:InitPlayNodeList()
	end,
	Play115281041 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 115281041
		arg_177_1.duration_ = 3.3

		local var_177_0 = {
			ja = 3.3,
			ko = 2.066,
			zh = 2.533,
			en = 2.266
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
				arg_177_0:Play115281042(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = arg_177_1.actors_["10030"].transform
			local var_180_1 = 0

			if var_180_1 < arg_177_1.time_ and arg_177_1.time_ <= var_180_1 + arg_180_0 then
				arg_177_1.var_.moveOldPos10030 = var_180_0.localPosition
				var_180_0.localScale = Vector3.New(1, 1, 1)

				arg_177_1:CheckSpriteTmpPos("10030", 3)

				local var_180_2 = var_180_0.childCount

				for iter_180_0 = 0, var_180_2 - 1 do
					local var_180_3 = var_180_0:GetChild(iter_180_0)

					if var_180_3.name == "split_3" or not string.find(var_180_3.name, "split") then
						var_180_3.gameObject:SetActive(true)
					else
						var_180_3.gameObject:SetActive(false)
					end
				end
			end

			local var_180_4 = 0.001

			if var_180_1 <= arg_177_1.time_ and arg_177_1.time_ < var_180_1 + var_180_4 then
				local var_180_5 = (arg_177_1.time_ - var_180_1) / var_180_4
				local var_180_6 = Vector3.New(0, -390, 150)

				var_180_0.localPosition = Vector3.Lerp(arg_177_1.var_.moveOldPos10030, var_180_6, var_180_5)
			end

			if arg_177_1.time_ >= var_180_1 + var_180_4 and arg_177_1.time_ < var_180_1 + var_180_4 + arg_180_0 then
				var_180_0.localPosition = Vector3.New(0, -390, 150)
			end

			local var_180_7 = arg_177_1.actors_["10030"]
			local var_180_8 = 0

			if var_180_8 < arg_177_1.time_ and arg_177_1.time_ <= var_180_8 + arg_180_0 then
				local var_180_9 = var_180_7:GetComponentInChildren(typeof(CanvasGroup))

				if var_180_9 then
					arg_177_1.var_.alphaOldValue10030 = var_180_9.alpha
					arg_177_1.var_.characterEffect10030 = var_180_9
				end

				arg_177_1.var_.alphaOldValue10030 = 0
			end

			local var_180_10 = 0.333333333333333

			if var_180_8 <= arg_177_1.time_ and arg_177_1.time_ < var_180_8 + var_180_10 then
				local var_180_11 = (arg_177_1.time_ - var_180_8) / var_180_10
				local var_180_12 = Mathf.Lerp(arg_177_1.var_.alphaOldValue10030, 1, var_180_11)

				if arg_177_1.var_.characterEffect10030 then
					arg_177_1.var_.characterEffect10030.alpha = var_180_12
				end
			end

			if arg_177_1.time_ >= var_180_8 + var_180_10 and arg_177_1.time_ < var_180_8 + var_180_10 + arg_180_0 and arg_177_1.var_.characterEffect10030 then
				arg_177_1.var_.characterEffect10030.alpha = 1
			end

			local var_180_13 = 0
			local var_180_14 = 0.2

			if var_180_13 < arg_177_1.time_ and arg_177_1.time_ <= var_180_13 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				local var_180_15 = arg_177_1:FormatText(StoryNameCfg[309].name)

				arg_177_1.leftNameTxt_.text = var_180_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_16 = arg_177_1:GetWordFromCfg(115281041)
				local var_180_17 = arg_177_1:FormatText(var_180_16.content)

				arg_177_1.text_.text = var_180_17

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_18 = 8
				local var_180_19 = utf8.len(var_180_17)
				local var_180_20 = var_180_18 <= 0 and var_180_14 or var_180_14 * (var_180_19 / var_180_18)

				if var_180_20 > 0 and var_180_14 < var_180_20 then
					arg_177_1.talkMaxDuration = var_180_20

					if var_180_20 + var_180_13 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_20 + var_180_13
					end
				end

				arg_177_1.text_.text = var_180_17
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115281", "115281041", "story_v_out_115281.awb") ~= 0 then
					local var_180_21 = manager.audio:GetVoiceLength("story_v_out_115281", "115281041", "story_v_out_115281.awb") / 1000

					if var_180_21 + var_180_13 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_21 + var_180_13
					end

					if var_180_16.prefab_name ~= "" and arg_177_1.actors_[var_180_16.prefab_name] ~= nil then
						local var_180_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_16.prefab_name].transform, "story_v_out_115281", "115281041", "story_v_out_115281.awb")

						arg_177_1:RecordAudio("115281041", var_180_22)
						arg_177_1:RecordAudio("115281041", var_180_22)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_115281", "115281041", "story_v_out_115281.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_115281", "115281041", "story_v_out_115281.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_23 = math.max(var_180_14, arg_177_1.talkMaxDuration)

			if var_180_13 <= arg_177_1.time_ and arg_177_1.time_ < var_180_13 + var_180_23 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_13) / var_180_23

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_13 + var_180_23 and arg_177_1.time_ < var_180_13 + var_180_23 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {
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

		arg_177_1:InitPlayNodeList()
	end,
	Play115281042 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 115281042
		arg_181_1.duration_ = 5

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play115281043(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = arg_181_1.actors_["10030"]
			local var_184_1 = 0

			if var_184_1 < arg_181_1.time_ and arg_181_1.time_ <= var_184_1 + arg_184_0 then
				local var_184_2 = var_184_0:GetComponentInChildren(typeof(CanvasGroup))

				if var_184_2 then
					arg_181_1.var_.alphaOldValue10030 = var_184_2.alpha
					arg_181_1.var_.characterEffect10030 = var_184_2
				end

				arg_181_1.var_.alphaOldValue10030 = 1
			end

			local var_184_3 = 0.333333333333333

			if var_184_1 <= arg_181_1.time_ and arg_181_1.time_ < var_184_1 + var_184_3 then
				local var_184_4 = (arg_181_1.time_ - var_184_1) / var_184_3
				local var_184_5 = Mathf.Lerp(arg_181_1.var_.alphaOldValue10030, 0, var_184_4)

				if arg_181_1.var_.characterEffect10030 then
					arg_181_1.var_.characterEffect10030.alpha = var_184_5
				end
			end

			if arg_181_1.time_ >= var_184_1 + var_184_3 and arg_181_1.time_ < var_184_1 + var_184_3 + arg_184_0 and arg_181_1.var_.characterEffect10030 then
				arg_181_1.var_.characterEffect10030.alpha = 0
			end

			local var_184_6 = 0
			local var_184_7 = 1.1

			if var_184_6 < arg_181_1.time_ and arg_181_1.time_ <= var_184_6 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, false)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_8 = arg_181_1:GetWordFromCfg(115281042)
				local var_184_9 = arg_181_1:FormatText(var_184_8.content)

				arg_181_1.text_.text = var_184_9

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_10 = 44
				local var_184_11 = utf8.len(var_184_9)
				local var_184_12 = var_184_10 <= 0 and var_184_7 or var_184_7 * (var_184_11 / var_184_10)

				if var_184_12 > 0 and var_184_7 < var_184_12 then
					arg_181_1.talkMaxDuration = var_184_12

					if var_184_12 + var_184_6 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_12 + var_184_6
					end
				end

				arg_181_1.text_.text = var_184_9
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)
				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_13 = math.max(var_184_7, arg_181_1.talkMaxDuration)

			if var_184_6 <= arg_181_1.time_ and arg_181_1.time_ < var_184_6 + var_184_13 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_6) / var_184_13

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_6 + var_184_13 and arg_181_1.time_ < var_184_6 + var_184_13 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {}

		arg_181_1:InitPlayNodeList()
	end,
	Play115281043 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 115281043
		arg_185_1.duration_ = 5

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play115281044(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = 0
			local var_188_1 = 0.9

			if var_188_0 < arg_185_1.time_ and arg_185_1.time_ <= var_188_0 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, false)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_2 = arg_185_1:GetWordFromCfg(115281043)
				local var_188_3 = arg_185_1:FormatText(var_188_2.content)

				arg_185_1.text_.text = var_188_3

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_4 = 36
				local var_188_5 = utf8.len(var_188_3)
				local var_188_6 = var_188_4 <= 0 and var_188_1 or var_188_1 * (var_188_5 / var_188_4)

				if var_188_6 > 0 and var_188_1 < var_188_6 then
					arg_185_1.talkMaxDuration = var_188_6

					if var_188_6 + var_188_0 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_6 + var_188_0
					end
				end

				arg_185_1.text_.text = var_188_3
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)
				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_7 = math.max(var_188_1, arg_185_1.talkMaxDuration)

			if var_188_0 <= arg_185_1.time_ and arg_185_1.time_ < var_188_0 + var_188_7 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_0) / var_188_7

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_0 + var_188_7 and arg_185_1.time_ < var_188_0 + var_188_7 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {}

		arg_185_1:InitPlayNodeList()
	end,
	Play115281044 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 115281044
		arg_189_1.duration_ = 18.9

		local var_189_0 = {
			ja = 16.166,
			ko = 13.266,
			zh = 13.1,
			en = 18.9
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
				arg_189_0:Play115281045(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = arg_189_1.actors_["10029"].transform
			local var_192_1 = 4

			if var_192_1 < arg_189_1.time_ and arg_189_1.time_ <= var_192_1 + arg_192_0 then
				arg_189_1.var_.moveOldPos10029 = var_192_0.localPosition
				var_192_0.localScale = Vector3.New(1, 1, 1)

				arg_189_1:CheckSpriteTmpPos("10029", 2)
			end

			local var_192_2 = 0.001

			if var_192_1 <= arg_189_1.time_ and arg_189_1.time_ < var_192_1 + var_192_2 then
				local var_192_3 = (arg_189_1.time_ - var_192_1) / var_192_2
				local var_192_4 = Vector3.New(-390, -350, -180)

				var_192_0.localPosition = Vector3.Lerp(arg_189_1.var_.moveOldPos10029, var_192_4, var_192_3)
			end

			if arg_189_1.time_ >= var_192_1 + var_192_2 and arg_189_1.time_ < var_192_1 + var_192_2 + arg_192_0 then
				var_192_0.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_192_5 = arg_189_1.actors_["10029"]
			local var_192_6 = 4

			if var_192_6 < arg_189_1.time_ and arg_189_1.time_ <= var_192_6 + arg_192_0 then
				local var_192_7 = var_192_5:GetComponent("Image")

				if var_192_7 then
					arg_189_1.var_.alphaMatValue10029 = var_192_7
					arg_189_1.var_.alphaOldValue10029 = var_192_7.color.a
				end

				arg_189_1.var_.alphaOldValue10029 = 0
			end

			local var_192_8 = 0.333333333333333

			if var_192_6 <= arg_189_1.time_ and arg_189_1.time_ < var_192_6 + var_192_8 then
				local var_192_9 = (arg_189_1.time_ - var_192_6) / var_192_8
				local var_192_10 = Mathf.Lerp(arg_189_1.var_.alphaOldValue10029, 1, var_192_9)

				if arg_189_1.var_.alphaMatValue10029 then
					local var_192_11 = arg_189_1.var_.alphaMatValue10029.color

					var_192_11.a = var_192_10
					arg_189_1.var_.alphaMatValue10029.color = var_192_11
				end
			end

			if arg_189_1.time_ >= var_192_6 + var_192_8 and arg_189_1.time_ < var_192_6 + var_192_8 + arg_192_0 and arg_189_1.var_.alphaMatValue10029 then
				local var_192_12 = arg_189_1.var_.alphaMatValue10029
				local var_192_13 = var_192_12.color

				var_192_13.a = 1
				var_192_12.color = var_192_13
			end

			local var_192_14 = arg_189_1.actors_["10030"].transform
			local var_192_15 = 4

			if var_192_15 < arg_189_1.time_ and arg_189_1.time_ <= var_192_15 + arg_192_0 then
				arg_189_1.var_.moveOldPos10030 = var_192_14.localPosition
				var_192_14.localScale = Vector3.New(1, 1, 1)

				arg_189_1:CheckSpriteTmpPos("10030", 4)

				local var_192_16 = var_192_14.childCount

				for iter_192_0 = 0, var_192_16 - 1 do
					local var_192_17 = var_192_14:GetChild(iter_192_0)

					if var_192_17.name == "split_1" or not string.find(var_192_17.name, "split") then
						var_192_17.gameObject:SetActive(true)
					else
						var_192_17.gameObject:SetActive(false)
					end
				end
			end

			local var_192_18 = 0.001

			if var_192_15 <= arg_189_1.time_ and arg_189_1.time_ < var_192_15 + var_192_18 then
				local var_192_19 = (arg_189_1.time_ - var_192_15) / var_192_18
				local var_192_20 = Vector3.New(390, -390, 150)

				var_192_14.localPosition = Vector3.Lerp(arg_189_1.var_.moveOldPos10030, var_192_20, var_192_19)
			end

			if arg_189_1.time_ >= var_192_15 + var_192_18 and arg_189_1.time_ < var_192_15 + var_192_18 + arg_192_0 then
				var_192_14.localPosition = Vector3.New(390, -390, 150)
			end

			local var_192_21 = arg_189_1.actors_["10030"]
			local var_192_22 = 4

			if var_192_22 < arg_189_1.time_ and arg_189_1.time_ <= var_192_22 + arg_192_0 then
				local var_192_23 = var_192_21:GetComponentInChildren(typeof(CanvasGroup))

				if var_192_23 then
					arg_189_1.var_.alphaOldValue10030 = var_192_23.alpha
					arg_189_1.var_.characterEffect10030 = var_192_23
				end

				arg_189_1.var_.alphaOldValue10030 = 0
			end

			local var_192_24 = 0.333333333333333

			if var_192_22 <= arg_189_1.time_ and arg_189_1.time_ < var_192_22 + var_192_24 then
				local var_192_25 = (arg_189_1.time_ - var_192_22) / var_192_24
				local var_192_26 = Mathf.Lerp(arg_189_1.var_.alphaOldValue10030, 1, var_192_25)

				if arg_189_1.var_.characterEffect10030 then
					arg_189_1.var_.characterEffect10030.alpha = var_192_26
				end
			end

			if arg_189_1.time_ >= var_192_22 + var_192_24 and arg_189_1.time_ < var_192_22 + var_192_24 + arg_192_0 and arg_189_1.var_.characterEffect10030 then
				arg_189_1.var_.characterEffect10030.alpha = 1
			end

			local var_192_27 = arg_189_1.actors_["10029"]
			local var_192_28 = 4

			if var_192_28 < arg_189_1.time_ and arg_189_1.time_ <= var_192_28 + arg_192_0 and not isNil(var_192_27) then
				local var_192_29 = var_192_27:GetComponent("Image")

				if var_192_29 then
					arg_189_1.var_.highlightMatValue10029 = var_192_29
				end
			end

			local var_192_30 = 0.2

			if var_192_28 <= arg_189_1.time_ and arg_189_1.time_ < var_192_28 + var_192_30 and not isNil(var_192_27) then
				local var_192_31 = (arg_189_1.time_ - var_192_28) / var_192_30

				if arg_189_1.var_.highlightMatValue10029 then
					local var_192_32 = Mathf.Lerp(0.5, 1, var_192_31)
					local var_192_33 = arg_189_1.var_.highlightMatValue10029
					local var_192_34 = var_192_33.color

					var_192_34.r = var_192_32
					var_192_34.g = var_192_32
					var_192_34.b = var_192_32
					var_192_33.color = var_192_34
				end
			end

			if arg_189_1.time_ >= var_192_28 + var_192_30 and arg_189_1.time_ < var_192_28 + var_192_30 + arg_192_0 and not isNil(var_192_27) and arg_189_1.var_.highlightMatValue10029 then
				local var_192_35 = 1

				var_192_27.transform:SetSiblingIndex(1)

				local var_192_36 = arg_189_1.var_.highlightMatValue10029
				local var_192_37 = var_192_36.color

				var_192_37.r = var_192_35
				var_192_37.g = var_192_35
				var_192_37.b = var_192_35
				var_192_36.color = var_192_37
			end

			local var_192_38 = arg_189_1.actors_["10030"]
			local var_192_39 = 4

			if var_192_39 < arg_189_1.time_ and arg_189_1.time_ <= var_192_39 + arg_192_0 and not isNil(var_192_38) and arg_189_1.var_.actorSpriteComps10030 == nil then
				arg_189_1.var_.actorSpriteComps10030 = var_192_38:GetComponentsInChildren(typeof(Image), true)
			end

			local var_192_40 = 0.2

			if var_192_39 <= arg_189_1.time_ and arg_189_1.time_ < var_192_39 + var_192_40 and not isNil(var_192_38) then
				local var_192_41 = (arg_189_1.time_ - var_192_39) / var_192_40

				if arg_189_1.var_.actorSpriteComps10030 then
					for iter_192_1, iter_192_2 in pairs(arg_189_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_192_2 then
							if arg_189_1.isInRecall_ then
								local var_192_42 = Mathf.Lerp(iter_192_2.color.r, arg_189_1.hightColor2.r, var_192_41)
								local var_192_43 = Mathf.Lerp(iter_192_2.color.g, arg_189_1.hightColor2.g, var_192_41)
								local var_192_44 = Mathf.Lerp(iter_192_2.color.b, arg_189_1.hightColor2.b, var_192_41)

								iter_192_2.color = Color.New(var_192_42, var_192_43, var_192_44)
							else
								local var_192_45 = Mathf.Lerp(iter_192_2.color.r, 0.5, var_192_41)

								iter_192_2.color = Color.New(var_192_45, var_192_45, var_192_45)
							end
						end
					end
				end
			end

			if arg_189_1.time_ >= var_192_39 + var_192_40 and arg_189_1.time_ < var_192_39 + var_192_40 + arg_192_0 and not isNil(var_192_38) and arg_189_1.var_.actorSpriteComps10030 then
				for iter_192_3, iter_192_4 in pairs(arg_189_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_192_4 then
						if arg_189_1.isInRecall_ then
							iter_192_4.color = arg_189_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_192_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_189_1.var_.actorSpriteComps10030 = nil
			end

			local var_192_46 = 0

			if var_192_46 < arg_189_1.time_ and arg_189_1.time_ <= var_192_46 + arg_192_0 then
				arg_189_1.mask_.enabled = true
				arg_189_1.mask_.raycastTarget = false

				arg_189_1:SetGaussion(false)
			end

			local var_192_47 = 2

			if var_192_46 <= arg_189_1.time_ and arg_189_1.time_ < var_192_46 + var_192_47 then
				local var_192_48 = (arg_189_1.time_ - var_192_46) / var_192_47
				local var_192_49 = Color.New(0, 0, 0)

				var_192_49.a = Mathf.Lerp(0, 1, var_192_48)
				arg_189_1.mask_.color = var_192_49
			end

			if arg_189_1.time_ >= var_192_46 + var_192_47 and arg_189_1.time_ < var_192_46 + var_192_47 + arg_192_0 then
				local var_192_50 = Color.New(0, 0, 0)

				var_192_50.a = 1
				arg_189_1.mask_.color = var_192_50
			end

			local var_192_51 = 2

			if var_192_51 < arg_189_1.time_ and arg_189_1.time_ <= var_192_51 + arg_192_0 then
				arg_189_1.mask_.enabled = true
				arg_189_1.mask_.raycastTarget = false

				arg_189_1:SetGaussion(false)
			end

			local var_192_52 = 2

			if var_192_51 <= arg_189_1.time_ and arg_189_1.time_ < var_192_51 + var_192_52 then
				local var_192_53 = (arg_189_1.time_ - var_192_51) / var_192_52
				local var_192_54 = Color.New(0, 0, 0)

				var_192_54.a = Mathf.Lerp(1, 0, var_192_53)
				arg_189_1.mask_.color = var_192_54
			end

			if arg_189_1.time_ >= var_192_51 + var_192_52 and arg_189_1.time_ < var_192_51 + var_192_52 + arg_192_0 then
				local var_192_55 = Color.New(0, 0, 0)
				local var_192_56 = 0

				arg_189_1.mask_.enabled = false
				var_192_55.a = var_192_56
				arg_189_1.mask_.color = var_192_55
			end

			if arg_189_1.frameCnt_ <= 1 then
				arg_189_1.dialog_:SetActive(false)
			end

			local var_192_57 = 4
			local var_192_58 = 1.025

			if var_192_57 < arg_189_1.time_ and arg_189_1.time_ <= var_192_57 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0

				arg_189_1.dialog_:SetActive(true)

				arg_189_1.dialogCg_.alpha = 0

				local var_192_59 = LeanTween.value(arg_189_1.dialog_, 0, 1, 0.3)

				var_192_59:setOnUpdate(LuaHelper.FloatAction(function(arg_193_0)
					arg_189_1.dialogCg_.alpha = arg_193_0
				end))
				var_192_59:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_189_1.dialog_)
					var_192_59:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_189_1.duration_ = arg_189_1.duration_ + 0.3

				SetActive(arg_189_1.leftNameGo_, true)

				local var_192_60 = arg_189_1:FormatText(StoryNameCfg[312].name)

				arg_189_1.leftNameTxt_.text = var_192_60

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_61 = arg_189_1:GetWordFromCfg(115281044)
				local var_192_62 = arg_189_1:FormatText(var_192_61.content)

				arg_189_1.text_.text = var_192_62

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_63 = 41
				local var_192_64 = utf8.len(var_192_62)
				local var_192_65 = var_192_63 <= 0 and var_192_58 or var_192_58 * (var_192_64 / var_192_63)

				if var_192_65 > 0 and var_192_58 < var_192_65 then
					arg_189_1.talkMaxDuration = var_192_65
					var_192_57 = var_192_57 + 0.3

					if var_192_65 + var_192_57 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_65 + var_192_57
					end
				end

				arg_189_1.text_.text = var_192_62
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115281", "115281044", "story_v_out_115281.awb") ~= 0 then
					local var_192_66 = manager.audio:GetVoiceLength("story_v_out_115281", "115281044", "story_v_out_115281.awb") / 1000

					if var_192_66 + var_192_57 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_66 + var_192_57
					end

					if var_192_61.prefab_name ~= "" and arg_189_1.actors_[var_192_61.prefab_name] ~= nil then
						local var_192_67 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_61.prefab_name].transform, "story_v_out_115281", "115281044", "story_v_out_115281.awb")

						arg_189_1:RecordAudio("115281044", var_192_67)
						arg_189_1:RecordAudio("115281044", var_192_67)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_115281", "115281044", "story_v_out_115281.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_115281", "115281044", "story_v_out_115281.awb")
				end

				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_68 = var_192_57 + 0.3
			local var_192_69 = math.max(var_192_58, arg_189_1.talkMaxDuration)

			if var_192_68 <= arg_189_1.time_ and arg_189_1.time_ < var_192_68 + var_192_69 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_68) / var_192_69

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_68 + var_192_69 and arg_189_1.time_ < var_192_68 + var_192_69 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10029",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.Sprite
			},
			{
				assetPath = "",
				actorName = "10030",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_189_1:InitPlayNodeList()
	end,
	Play115281045 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 115281045
		arg_195_1.duration_ = 16.17

		local var_195_0 = {
			ja = 11.033,
			ko = 15.466,
			zh = 12.1,
			en = 16.166
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
				arg_195_0:Play115281046(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			local var_198_0 = 0
			local var_198_1 = 1.275

			if var_198_0 < arg_195_1.time_ and arg_195_1.time_ <= var_198_0 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				local var_198_2 = arg_195_1:FormatText(StoryNameCfg[312].name)

				arg_195_1.leftNameTxt_.text = var_198_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_3 = arg_195_1:GetWordFromCfg(115281045)
				local var_198_4 = arg_195_1:FormatText(var_198_3.content)

				arg_195_1.text_.text = var_198_4

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_5 = 51
				local var_198_6 = utf8.len(var_198_4)
				local var_198_7 = var_198_5 <= 0 and var_198_1 or var_198_1 * (var_198_6 / var_198_5)

				if var_198_7 > 0 and var_198_1 < var_198_7 then
					arg_195_1.talkMaxDuration = var_198_7

					if var_198_7 + var_198_0 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_7 + var_198_0
					end
				end

				arg_195_1.text_.text = var_198_4
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115281", "115281045", "story_v_out_115281.awb") ~= 0 then
					local var_198_8 = manager.audio:GetVoiceLength("story_v_out_115281", "115281045", "story_v_out_115281.awb") / 1000

					if var_198_8 + var_198_0 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_8 + var_198_0
					end

					if var_198_3.prefab_name ~= "" and arg_195_1.actors_[var_198_3.prefab_name] ~= nil then
						local var_198_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_195_1.actors_[var_198_3.prefab_name].transform, "story_v_out_115281", "115281045", "story_v_out_115281.awb")

						arg_195_1:RecordAudio("115281045", var_198_9)
						arg_195_1:RecordAudio("115281045", var_198_9)
					else
						arg_195_1:AudioAction("play", "voice", "story_v_out_115281", "115281045", "story_v_out_115281.awb")
					end

					arg_195_1:RecordHistoryTalkVoice("story_v_out_115281", "115281045", "story_v_out_115281.awb")
				end

				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_10 = math.max(var_198_1, arg_195_1.talkMaxDuration)

			if var_198_0 <= arg_195_1.time_ and arg_195_1.time_ < var_198_0 + var_198_10 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_0) / var_198_10

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_0 + var_198_10 and arg_195_1.time_ < var_198_0 + var_198_10 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {}

		arg_195_1:InitPlayNodeList()
	end,
	Play115281046 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 115281046
		arg_199_1.duration_ = 2.8

		local var_199_0 = {
			ja = 2.8,
			ko = 1,
			zh = 1.4,
			en = 1.733
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
				arg_199_0:Play115281047(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			local var_202_0 = arg_199_1.actors_["10029"]
			local var_202_1 = 0

			if var_202_1 < arg_199_1.time_ and arg_199_1.time_ <= var_202_1 + arg_202_0 and not isNil(var_202_0) then
				local var_202_2 = var_202_0:GetComponent("Image")

				if var_202_2 then
					arg_199_1.var_.highlightMatValue10029 = var_202_2
				end
			end

			local var_202_3 = 0.2

			if var_202_1 <= arg_199_1.time_ and arg_199_1.time_ < var_202_1 + var_202_3 and not isNil(var_202_0) then
				local var_202_4 = (arg_199_1.time_ - var_202_1) / var_202_3

				if arg_199_1.var_.highlightMatValue10029 then
					local var_202_5 = Mathf.Lerp(1, 0.5, var_202_4)
					local var_202_6 = arg_199_1.var_.highlightMatValue10029
					local var_202_7 = var_202_6.color

					var_202_7.r = var_202_5
					var_202_7.g = var_202_5
					var_202_7.b = var_202_5
					var_202_6.color = var_202_7
				end
			end

			if arg_199_1.time_ >= var_202_1 + var_202_3 and arg_199_1.time_ < var_202_1 + var_202_3 + arg_202_0 and not isNil(var_202_0) and arg_199_1.var_.highlightMatValue10029 then
				local var_202_8 = 0.5
				local var_202_9 = arg_199_1.var_.highlightMatValue10029
				local var_202_10 = var_202_9.color

				var_202_10.r = var_202_8
				var_202_10.g = var_202_8
				var_202_10.b = var_202_8
				var_202_9.color = var_202_10
			end

			local var_202_11 = arg_199_1.actors_["10030"]
			local var_202_12 = 0

			if var_202_12 < arg_199_1.time_ and arg_199_1.time_ <= var_202_12 + arg_202_0 and not isNil(var_202_11) and arg_199_1.var_.actorSpriteComps10030 == nil then
				arg_199_1.var_.actorSpriteComps10030 = var_202_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_202_13 = 0.2

			if var_202_12 <= arg_199_1.time_ and arg_199_1.time_ < var_202_12 + var_202_13 and not isNil(var_202_11) then
				local var_202_14 = (arg_199_1.time_ - var_202_12) / var_202_13

				if arg_199_1.var_.actorSpriteComps10030 then
					for iter_202_0, iter_202_1 in pairs(arg_199_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_202_1 then
							if arg_199_1.isInRecall_ then
								local var_202_15 = Mathf.Lerp(iter_202_1.color.r, arg_199_1.hightColor1.r, var_202_14)
								local var_202_16 = Mathf.Lerp(iter_202_1.color.g, arg_199_1.hightColor1.g, var_202_14)
								local var_202_17 = Mathf.Lerp(iter_202_1.color.b, arg_199_1.hightColor1.b, var_202_14)

								iter_202_1.color = Color.New(var_202_15, var_202_16, var_202_17)
							else
								local var_202_18 = Mathf.Lerp(iter_202_1.color.r, 1, var_202_14)

								iter_202_1.color = Color.New(var_202_18, var_202_18, var_202_18)
							end
						end
					end
				end
			end

			if arg_199_1.time_ >= var_202_12 + var_202_13 and arg_199_1.time_ < var_202_12 + var_202_13 + arg_202_0 and not isNil(var_202_11) and arg_199_1.var_.actorSpriteComps10030 then
				for iter_202_2, iter_202_3 in pairs(arg_199_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_202_3 then
						if arg_199_1.isInRecall_ then
							iter_202_3.color = arg_199_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_202_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_199_1.var_.actorSpriteComps10030 = nil
			end

			local var_202_19 = 0
			local var_202_20 = 0.1

			if var_202_19 < arg_199_1.time_ and arg_199_1.time_ <= var_202_19 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				local var_202_21 = arg_199_1:FormatText(StoryNameCfg[309].name)

				arg_199_1.leftNameTxt_.text = var_202_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_22 = arg_199_1:GetWordFromCfg(115281046)
				local var_202_23 = arg_199_1:FormatText(var_202_22.content)

				arg_199_1.text_.text = var_202_23

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_24 = 4
				local var_202_25 = utf8.len(var_202_23)
				local var_202_26 = var_202_24 <= 0 and var_202_20 or var_202_20 * (var_202_25 / var_202_24)

				if var_202_26 > 0 and var_202_20 < var_202_26 then
					arg_199_1.talkMaxDuration = var_202_26

					if var_202_26 + var_202_19 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_26 + var_202_19
					end
				end

				arg_199_1.text_.text = var_202_23
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115281", "115281046", "story_v_out_115281.awb") ~= 0 then
					local var_202_27 = manager.audio:GetVoiceLength("story_v_out_115281", "115281046", "story_v_out_115281.awb") / 1000

					if var_202_27 + var_202_19 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_27 + var_202_19
					end

					if var_202_22.prefab_name ~= "" and arg_199_1.actors_[var_202_22.prefab_name] ~= nil then
						local var_202_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_199_1.actors_[var_202_22.prefab_name].transform, "story_v_out_115281", "115281046", "story_v_out_115281.awb")

						arg_199_1:RecordAudio("115281046", var_202_28)
						arg_199_1:RecordAudio("115281046", var_202_28)
					else
						arg_199_1:AudioAction("play", "voice", "story_v_out_115281", "115281046", "story_v_out_115281.awb")
					end

					arg_199_1:RecordHistoryTalkVoice("story_v_out_115281", "115281046", "story_v_out_115281.awb")
				end

				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_29 = math.max(var_202_20, arg_199_1.talkMaxDuration)

			if var_202_19 <= arg_199_1.time_ and arg_199_1.time_ < var_202_19 + var_202_29 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_19) / var_202_29

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_19 + var_202_29 and arg_199_1.time_ < var_202_19 + var_202_29 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {}

		arg_199_1:InitPlayNodeList()
	end,
	Play115281047 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 115281047
		arg_203_1.duration_ = 9

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"
		end

		function arg_203_1.playNext_(arg_205_0)
			if arg_205_0 == 1 then
				arg_203_0:Play115281048(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			local var_206_0 = arg_203_1.actors_["10030"]
			local var_206_1 = 2

			if var_206_1 < arg_203_1.time_ and arg_203_1.time_ <= var_206_1 + arg_206_0 then
				local var_206_2 = var_206_0:GetComponentInChildren(typeof(CanvasGroup))

				if var_206_2 then
					arg_203_1.var_.alphaOldValue10030 = var_206_2.alpha
					arg_203_1.var_.characterEffect10030 = var_206_2
				end

				arg_203_1.var_.alphaOldValue10030 = 1
			end

			local var_206_3 = 0.0166666666666667

			if var_206_1 <= arg_203_1.time_ and arg_203_1.time_ < var_206_1 + var_206_3 then
				local var_206_4 = (arg_203_1.time_ - var_206_1) / var_206_3
				local var_206_5 = Mathf.Lerp(arg_203_1.var_.alphaOldValue10030, 0, var_206_4)

				if arg_203_1.var_.characterEffect10030 then
					arg_203_1.var_.characterEffect10030.alpha = var_206_5
				end
			end

			if arg_203_1.time_ >= var_206_1 + var_206_3 and arg_203_1.time_ < var_206_1 + var_206_3 + arg_206_0 and arg_203_1.var_.characterEffect10030 then
				arg_203_1.var_.characterEffect10030.alpha = 0
			end

			local var_206_6 = arg_203_1.actors_["10029"]
			local var_206_7 = 2

			if var_206_7 < arg_203_1.time_ and arg_203_1.time_ <= var_206_7 + arg_206_0 then
				local var_206_8 = var_206_6:GetComponent("Image")

				if var_206_8 then
					arg_203_1.var_.alphaMatValue10029 = var_206_8
					arg_203_1.var_.alphaOldValue10029 = var_206_8.color.a
				end

				arg_203_1.var_.alphaOldValue10029 = 1
			end

			local var_206_9 = 0.0166666666666667

			if var_206_7 <= arg_203_1.time_ and arg_203_1.time_ < var_206_7 + var_206_9 then
				local var_206_10 = (arg_203_1.time_ - var_206_7) / var_206_9
				local var_206_11 = Mathf.Lerp(arg_203_1.var_.alphaOldValue10029, 0, var_206_10)

				if arg_203_1.var_.alphaMatValue10029 then
					local var_206_12 = arg_203_1.var_.alphaMatValue10029.color

					var_206_12.a = var_206_11
					arg_203_1.var_.alphaMatValue10029.color = var_206_12
				end
			end

			if arg_203_1.time_ >= var_206_7 + var_206_9 and arg_203_1.time_ < var_206_7 + var_206_9 + arg_206_0 and arg_203_1.var_.alphaMatValue10029 then
				local var_206_13 = arg_203_1.var_.alphaMatValue10029
				local var_206_14 = var_206_13.color

				var_206_14.a = 0
				var_206_13.color = var_206_14
			end

			local var_206_15 = 0

			if var_206_15 < arg_203_1.time_ and arg_203_1.time_ <= var_206_15 + arg_206_0 then
				arg_203_1.mask_.enabled = true
				arg_203_1.mask_.raycastTarget = false

				arg_203_1:SetGaussion(false)
			end

			local var_206_16 = 2

			if var_206_15 <= arg_203_1.time_ and arg_203_1.time_ < var_206_15 + var_206_16 then
				local var_206_17 = (arg_203_1.time_ - var_206_15) / var_206_16
				local var_206_18 = Color.New(0, 0, 0)

				var_206_18.a = Mathf.Lerp(0, 1, var_206_17)
				arg_203_1.mask_.color = var_206_18
			end

			if arg_203_1.time_ >= var_206_15 + var_206_16 and arg_203_1.time_ < var_206_15 + var_206_16 + arg_206_0 then
				local var_206_19 = Color.New(0, 0, 0)

				var_206_19.a = 1
				arg_203_1.mask_.color = var_206_19
			end

			local var_206_20 = 2

			if var_206_20 < arg_203_1.time_ and arg_203_1.time_ <= var_206_20 + arg_206_0 then
				arg_203_1.mask_.enabled = true
				arg_203_1.mask_.raycastTarget = false

				arg_203_1:SetGaussion(false)
			end

			local var_206_21 = 2

			if var_206_20 <= arg_203_1.time_ and arg_203_1.time_ < var_206_20 + var_206_21 then
				local var_206_22 = (arg_203_1.time_ - var_206_20) / var_206_21
				local var_206_23 = Color.New(0, 0, 0)

				var_206_23.a = Mathf.Lerp(1, 0, var_206_22)
				arg_203_1.mask_.color = var_206_23
			end

			if arg_203_1.time_ >= var_206_20 + var_206_21 and arg_203_1.time_ < var_206_20 + var_206_21 + arg_206_0 then
				local var_206_24 = Color.New(0, 0, 0)
				local var_206_25 = 0

				arg_203_1.mask_.enabled = false
				var_206_24.a = var_206_25
				arg_203_1.mask_.color = var_206_24
			end

			if arg_203_1.frameCnt_ <= 1 then
				arg_203_1.dialog_:SetActive(false)
			end

			local var_206_26 = 4
			local var_206_27 = 1.425

			if var_206_26 < arg_203_1.time_ and arg_203_1.time_ <= var_206_26 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0

				arg_203_1.dialog_:SetActive(true)

				arg_203_1.dialogCg_.alpha = 0

				local var_206_28 = LeanTween.value(arg_203_1.dialog_, 0, 1, 0.3)

				var_206_28:setOnUpdate(LuaHelper.FloatAction(function(arg_207_0)
					arg_203_1.dialogCg_.alpha = arg_207_0
				end))
				var_206_28:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_203_1.dialog_)
					var_206_28:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_203_1.duration_ = arg_203_1.duration_ + 0.3

				SetActive(arg_203_1.leftNameGo_, false)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_29 = arg_203_1:GetWordFromCfg(115281047)
				local var_206_30 = arg_203_1:FormatText(var_206_29.content)

				arg_203_1.text_.text = var_206_30

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_31 = 57
				local var_206_32 = utf8.len(var_206_30)
				local var_206_33 = var_206_31 <= 0 and var_206_27 or var_206_27 * (var_206_32 / var_206_31)

				if var_206_33 > 0 and var_206_27 < var_206_33 then
					arg_203_1.talkMaxDuration = var_206_33
					var_206_26 = var_206_26 + 0.3

					if var_206_33 + var_206_26 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_33 + var_206_26
					end
				end

				arg_203_1.text_.text = var_206_30
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)
				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_34 = var_206_26 + 0.3
			local var_206_35 = math.max(var_206_27, arg_203_1.talkMaxDuration)

			if var_206_34 <= arg_203_1.time_ and arg_203_1.time_ < var_206_34 + var_206_35 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_34) / var_206_35

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_34 + var_206_35 and arg_203_1.time_ < var_206_34 + var_206_35 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {}

		arg_203_1:InitPlayNodeList()
	end,
	Play115281048 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 115281048
		arg_209_1.duration_ = 5

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play115281049(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			local var_212_0 = 0
			local var_212_1 = 1.025

			if var_212_0 < arg_209_1.time_ and arg_209_1.time_ <= var_212_0 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, false)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_2 = arg_209_1:GetWordFromCfg(115281048)
				local var_212_3 = arg_209_1:FormatText(var_212_2.content)

				arg_209_1.text_.text = var_212_3

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_4 = 41
				local var_212_5 = utf8.len(var_212_3)
				local var_212_6 = var_212_4 <= 0 and var_212_1 or var_212_1 * (var_212_5 / var_212_4)

				if var_212_6 > 0 and var_212_1 < var_212_6 then
					arg_209_1.talkMaxDuration = var_212_6

					if var_212_6 + var_212_0 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_6 + var_212_0
					end
				end

				arg_209_1.text_.text = var_212_3
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)
				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_7 = math.max(var_212_1, arg_209_1.talkMaxDuration)

			if var_212_0 <= arg_209_1.time_ and arg_209_1.time_ < var_212_0 + var_212_7 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_0) / var_212_7

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_0 + var_212_7 and arg_209_1.time_ < var_212_0 + var_212_7 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {}

		arg_209_1:InitPlayNodeList()
	end,
	Play115281049 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 115281049
		arg_213_1.duration_ = 7.1

		local var_213_0 = {
			ja = 3.866,
			ko = 5.5,
			zh = 7.1,
			en = 6.133
		}
		local var_213_1 = manager.audio:GetLocalizationFlag()

		if var_213_0[var_213_1] ~= nil then
			arg_213_1.duration_ = var_213_0[var_213_1]
		end

		SetActive(arg_213_1.tipsGo_, false)

		function arg_213_1.onSingleLineFinish_()
			arg_213_1.onSingleLineUpdate_ = nil
			arg_213_1.onSingleLineFinish_ = nil
			arg_213_1.state_ = "waiting"
		end

		function arg_213_1.playNext_(arg_215_0)
			if arg_215_0 == 1 then
				arg_213_0:Play115281050(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			local var_216_0 = arg_213_1.actors_["10030"].transform
			local var_216_1 = 0

			if var_216_1 < arg_213_1.time_ and arg_213_1.time_ <= var_216_1 + arg_216_0 then
				arg_213_1.var_.moveOldPos10030 = var_216_0.localPosition
				var_216_0.localScale = Vector3.New(1, 1, 1)

				arg_213_1:CheckSpriteTmpPos("10030", 3)

				local var_216_2 = var_216_0.childCount

				for iter_216_0 = 0, var_216_2 - 1 do
					local var_216_3 = var_216_0:GetChild(iter_216_0)

					if var_216_3.name == "split_1" or not string.find(var_216_3.name, "split") then
						var_216_3.gameObject:SetActive(true)
					else
						var_216_3.gameObject:SetActive(false)
					end
				end
			end

			local var_216_4 = 0.001

			if var_216_1 <= arg_213_1.time_ and arg_213_1.time_ < var_216_1 + var_216_4 then
				local var_216_5 = (arg_213_1.time_ - var_216_1) / var_216_4
				local var_216_6 = Vector3.New(0, -390, 150)

				var_216_0.localPosition = Vector3.Lerp(arg_213_1.var_.moveOldPos10030, var_216_6, var_216_5)
			end

			if arg_213_1.time_ >= var_216_1 + var_216_4 and arg_213_1.time_ < var_216_1 + var_216_4 + arg_216_0 then
				var_216_0.localPosition = Vector3.New(0, -390, 150)
			end

			local var_216_7 = arg_213_1.actors_["10030"]
			local var_216_8 = 0

			if var_216_8 < arg_213_1.time_ and arg_213_1.time_ <= var_216_8 + arg_216_0 then
				local var_216_9 = var_216_7:GetComponentInChildren(typeof(CanvasGroup))

				if var_216_9 then
					arg_213_1.var_.alphaOldValue10030 = var_216_9.alpha
					arg_213_1.var_.characterEffect10030 = var_216_9
				end

				arg_213_1.var_.alphaOldValue10030 = 0
			end

			local var_216_10 = 0.333333333333333

			if var_216_8 <= arg_213_1.time_ and arg_213_1.time_ < var_216_8 + var_216_10 then
				local var_216_11 = (arg_213_1.time_ - var_216_8) / var_216_10
				local var_216_12 = Mathf.Lerp(arg_213_1.var_.alphaOldValue10030, 1, var_216_11)

				if arg_213_1.var_.characterEffect10030 then
					arg_213_1.var_.characterEffect10030.alpha = var_216_12
				end
			end

			if arg_213_1.time_ >= var_216_8 + var_216_10 and arg_213_1.time_ < var_216_8 + var_216_10 + arg_216_0 and arg_213_1.var_.characterEffect10030 then
				arg_213_1.var_.characterEffect10030.alpha = 1
			end

			local var_216_13 = arg_213_1.actors_["10030"]
			local var_216_14 = 0

			if var_216_14 < arg_213_1.time_ and arg_213_1.time_ <= var_216_14 + arg_216_0 and not isNil(var_216_13) and arg_213_1.var_.actorSpriteComps10030 == nil then
				arg_213_1.var_.actorSpriteComps10030 = var_216_13:GetComponentsInChildren(typeof(Image), true)
			end

			local var_216_15 = 0.2

			if var_216_14 <= arg_213_1.time_ and arg_213_1.time_ < var_216_14 + var_216_15 and not isNil(var_216_13) then
				local var_216_16 = (arg_213_1.time_ - var_216_14) / var_216_15

				if arg_213_1.var_.actorSpriteComps10030 then
					for iter_216_1, iter_216_2 in pairs(arg_213_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_216_2 then
							if arg_213_1.isInRecall_ then
								local var_216_17 = Mathf.Lerp(iter_216_2.color.r, arg_213_1.hightColor1.r, var_216_16)
								local var_216_18 = Mathf.Lerp(iter_216_2.color.g, arg_213_1.hightColor1.g, var_216_16)
								local var_216_19 = Mathf.Lerp(iter_216_2.color.b, arg_213_1.hightColor1.b, var_216_16)

								iter_216_2.color = Color.New(var_216_17, var_216_18, var_216_19)
							else
								local var_216_20 = Mathf.Lerp(iter_216_2.color.r, 1, var_216_16)

								iter_216_2.color = Color.New(var_216_20, var_216_20, var_216_20)
							end
						end
					end
				end
			end

			if arg_213_1.time_ >= var_216_14 + var_216_15 and arg_213_1.time_ < var_216_14 + var_216_15 + arg_216_0 and not isNil(var_216_13) and arg_213_1.var_.actorSpriteComps10030 then
				for iter_216_3, iter_216_4 in pairs(arg_213_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_216_4 then
						if arg_213_1.isInRecall_ then
							iter_216_4.color = arg_213_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_216_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_213_1.var_.actorSpriteComps10030 = nil
			end

			local var_216_21 = 0
			local var_216_22 = 0.45

			if var_216_21 < arg_213_1.time_ and arg_213_1.time_ <= var_216_21 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				local var_216_23 = arg_213_1:FormatText(StoryNameCfg[309].name)

				arg_213_1.leftNameTxt_.text = var_216_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_24 = arg_213_1:GetWordFromCfg(115281049)
				local var_216_25 = arg_213_1:FormatText(var_216_24.content)

				arg_213_1.text_.text = var_216_25

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_26 = 18
				local var_216_27 = utf8.len(var_216_25)
				local var_216_28 = var_216_26 <= 0 and var_216_22 or var_216_22 * (var_216_27 / var_216_26)

				if var_216_28 > 0 and var_216_22 < var_216_28 then
					arg_213_1.talkMaxDuration = var_216_28

					if var_216_28 + var_216_21 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_28 + var_216_21
					end
				end

				arg_213_1.text_.text = var_216_25
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115281", "115281049", "story_v_out_115281.awb") ~= 0 then
					local var_216_29 = manager.audio:GetVoiceLength("story_v_out_115281", "115281049", "story_v_out_115281.awb") / 1000

					if var_216_29 + var_216_21 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_29 + var_216_21
					end

					if var_216_24.prefab_name ~= "" and arg_213_1.actors_[var_216_24.prefab_name] ~= nil then
						local var_216_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_24.prefab_name].transform, "story_v_out_115281", "115281049", "story_v_out_115281.awb")

						arg_213_1:RecordAudio("115281049", var_216_30)
						arg_213_1:RecordAudio("115281049", var_216_30)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_out_115281", "115281049", "story_v_out_115281.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_out_115281", "115281049", "story_v_out_115281.awb")
				end

				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_31 = math.max(var_216_22, arg_213_1.talkMaxDuration)

			if var_216_21 <= arg_213_1.time_ and arg_213_1.time_ < var_216_21 + var_216_31 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_21) / var_216_31

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_21 + var_216_31 and arg_213_1.time_ < var_216_21 + var_216_31 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {
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

		arg_213_1:InitPlayNodeList()
	end,
	Play115281050 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 115281050
		arg_217_1.duration_ = 5

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"
		end

		function arg_217_1.playNext_(arg_219_0)
			if arg_219_0 == 1 then
				arg_217_0:Play115281051(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			local var_220_0 = arg_217_1.actors_["10030"]
			local var_220_1 = 0

			if var_220_1 < arg_217_1.time_ and arg_217_1.time_ <= var_220_1 + arg_220_0 and not isNil(var_220_0) and arg_217_1.var_.actorSpriteComps10030 == nil then
				arg_217_1.var_.actorSpriteComps10030 = var_220_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_220_2 = 0.2

			if var_220_1 <= arg_217_1.time_ and arg_217_1.time_ < var_220_1 + var_220_2 and not isNil(var_220_0) then
				local var_220_3 = (arg_217_1.time_ - var_220_1) / var_220_2

				if arg_217_1.var_.actorSpriteComps10030 then
					for iter_220_0, iter_220_1 in pairs(arg_217_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_220_1 then
							if arg_217_1.isInRecall_ then
								local var_220_4 = Mathf.Lerp(iter_220_1.color.r, arg_217_1.hightColor2.r, var_220_3)
								local var_220_5 = Mathf.Lerp(iter_220_1.color.g, arg_217_1.hightColor2.g, var_220_3)
								local var_220_6 = Mathf.Lerp(iter_220_1.color.b, arg_217_1.hightColor2.b, var_220_3)

								iter_220_1.color = Color.New(var_220_4, var_220_5, var_220_6)
							else
								local var_220_7 = Mathf.Lerp(iter_220_1.color.r, 0.5, var_220_3)

								iter_220_1.color = Color.New(var_220_7, var_220_7, var_220_7)
							end
						end
					end
				end
			end

			if arg_217_1.time_ >= var_220_1 + var_220_2 and arg_217_1.time_ < var_220_1 + var_220_2 + arg_220_0 and not isNil(var_220_0) and arg_217_1.var_.actorSpriteComps10030 then
				for iter_220_2, iter_220_3 in pairs(arg_217_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_220_3 then
						if arg_217_1.isInRecall_ then
							iter_220_3.color = arg_217_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_220_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_217_1.var_.actorSpriteComps10030 = nil
			end

			local var_220_8 = 0
			local var_220_9 = 0.775

			if var_220_8 < arg_217_1.time_ and arg_217_1.time_ <= var_220_8 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, false)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_217_1.iconTrs_.gameObject, false)
				arg_217_1.callingController_:SetSelectedState("normal")

				local var_220_10 = arg_217_1:GetWordFromCfg(115281050)
				local var_220_11 = arg_217_1:FormatText(var_220_10.content)

				arg_217_1.text_.text = var_220_11

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_12 = 31
				local var_220_13 = utf8.len(var_220_11)
				local var_220_14 = var_220_12 <= 0 and var_220_9 or var_220_9 * (var_220_13 / var_220_12)

				if var_220_14 > 0 and var_220_9 < var_220_14 then
					arg_217_1.talkMaxDuration = var_220_14

					if var_220_14 + var_220_8 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_14 + var_220_8
					end
				end

				arg_217_1.text_.text = var_220_11
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)
				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_15 = math.max(var_220_9, arg_217_1.talkMaxDuration)

			if var_220_8 <= arg_217_1.time_ and arg_217_1.time_ < var_220_8 + var_220_15 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_8) / var_220_15

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_8 + var_220_15 and arg_217_1.time_ < var_220_8 + var_220_15 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {}

		arg_217_1:InitPlayNodeList()
	end,
	Play115281051 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 115281051
		arg_221_1.duration_ = 12.27

		local var_221_0 = {
			ja = 12.266,
			ko = 8.733,
			zh = 8.1,
			en = 9.933
		}
		local var_221_1 = manager.audio:GetLocalizationFlag()

		if var_221_0[var_221_1] ~= nil then
			arg_221_1.duration_ = var_221_0[var_221_1]
		end

		SetActive(arg_221_1.tipsGo_, false)

		function arg_221_1.onSingleLineFinish_()
			arg_221_1.onSingleLineUpdate_ = nil
			arg_221_1.onSingleLineFinish_ = nil
			arg_221_1.state_ = "waiting"
		end

		function arg_221_1.playNext_(arg_223_0)
			if arg_223_0 == 1 then
				arg_221_0:Play115281052(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			local var_224_0 = arg_221_1.actors_["10030"].transform
			local var_224_1 = 2

			if var_224_1 < arg_221_1.time_ and arg_221_1.time_ <= var_224_1 + arg_224_0 then
				arg_221_1.var_.moveOldPos10030 = var_224_0.localPosition
				var_224_0.localScale = Vector3.New(1, 1, 1)

				arg_221_1:CheckSpriteTmpPos("10030", 7)

				local var_224_2 = var_224_0.childCount

				for iter_224_0 = 0, var_224_2 - 1 do
					local var_224_3 = var_224_0:GetChild(iter_224_0)

					if var_224_3.name == "split_1" or not string.find(var_224_3.name, "split") then
						var_224_3.gameObject:SetActive(true)
					else
						var_224_3.gameObject:SetActive(false)
					end
				end
			end

			local var_224_4 = 0.001

			if var_224_1 <= arg_221_1.time_ and arg_221_1.time_ < var_224_1 + var_224_4 then
				local var_224_5 = (arg_221_1.time_ - var_224_1) / var_224_4
				local var_224_6 = Vector3.New(0, -2000, 150)

				var_224_0.localPosition = Vector3.Lerp(arg_221_1.var_.moveOldPos10030, var_224_6, var_224_5)
			end

			if arg_221_1.time_ >= var_224_1 + var_224_4 and arg_221_1.time_ < var_224_1 + var_224_4 + arg_224_0 then
				var_224_0.localPosition = Vector3.New(0, -2000, 150)
			end

			local var_224_7 = 0

			if var_224_7 < arg_221_1.time_ and arg_221_1.time_ <= var_224_7 + arg_224_0 then
				arg_221_1.mask_.enabled = true
				arg_221_1.mask_.raycastTarget = false

				arg_221_1:SetGaussion(false)
			end

			local var_224_8 = 2

			if var_224_7 <= arg_221_1.time_ and arg_221_1.time_ < var_224_7 + var_224_8 then
				local var_224_9 = (arg_221_1.time_ - var_224_7) / var_224_8
				local var_224_10 = Color.New(0, 0, 0)

				var_224_10.a = Mathf.Lerp(0, 1, var_224_9)
				arg_221_1.mask_.color = var_224_10
			end

			if arg_221_1.time_ >= var_224_7 + var_224_8 and arg_221_1.time_ < var_224_7 + var_224_8 + arg_224_0 then
				local var_224_11 = Color.New(0, 0, 0)

				var_224_11.a = 1
				arg_221_1.mask_.color = var_224_11
			end

			local var_224_12 = 2

			if var_224_12 < arg_221_1.time_ and arg_221_1.time_ <= var_224_12 + arg_224_0 then
				arg_221_1.mask_.enabled = true
				arg_221_1.mask_.raycastTarget = false

				arg_221_1:SetGaussion(false)
			end

			local var_224_13 = 2

			if var_224_12 <= arg_221_1.time_ and arg_221_1.time_ < var_224_12 + var_224_13 then
				local var_224_14 = (arg_221_1.time_ - var_224_12) / var_224_13
				local var_224_15 = Color.New(0, 0, 0)

				var_224_15.a = Mathf.Lerp(1, 0, var_224_14)
				arg_221_1.mask_.color = var_224_15
			end

			if arg_221_1.time_ >= var_224_12 + var_224_13 and arg_221_1.time_ < var_224_12 + var_224_13 + arg_224_0 then
				local var_224_16 = Color.New(0, 0, 0)
				local var_224_17 = 0

				arg_221_1.mask_.enabled = false
				var_224_16.a = var_224_17
				arg_221_1.mask_.color = var_224_16
			end

			local var_224_18 = 0

			arg_221_1.isInRecall_ = false

			if var_224_18 < arg_221_1.time_ and arg_221_1.time_ <= var_224_18 + arg_224_0 then
				arg_221_1.screenFilterGo_:SetActive(true)

				arg_221_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile")

				for iter_224_1, iter_224_2 in pairs(arg_221_1.actors_) do
					local var_224_19 = iter_224_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_224_3, iter_224_4 in ipairs(var_224_19) do
						if iter_224_4.color.r > 0.51 then
							iter_224_4.color = Color.New(1, 1, 1)
						else
							iter_224_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end
			end

			local var_224_20 = 4

			if var_224_18 <= arg_221_1.time_ and arg_221_1.time_ < var_224_18 + var_224_20 then
				local var_224_21 = (arg_221_1.time_ - var_224_18) / var_224_20

				arg_221_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, var_224_21)
			end

			if arg_221_1.time_ >= var_224_18 + var_224_20 and arg_221_1.time_ < var_224_18 + var_224_20 + arg_224_0 then
				arg_221_1.screenFilterEffect_.weight = 1
			end

			if arg_221_1.frameCnt_ <= 1 then
				arg_221_1.dialog_:SetActive(false)
			end

			local var_224_22 = 4
			local var_224_23 = 0.525

			if var_224_22 < arg_221_1.time_ and arg_221_1.time_ <= var_224_22 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0

				arg_221_1.dialog_:SetActive(true)

				arg_221_1.dialogCg_.alpha = 0

				local var_224_24 = LeanTween.value(arg_221_1.dialog_, 0, 1, 0.3)

				var_224_24:setOnUpdate(LuaHelper.FloatAction(function(arg_225_0)
					arg_221_1.dialogCg_.alpha = arg_225_0
				end))
				var_224_24:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_221_1.dialog_)
					var_224_24:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_221_1.duration_ = arg_221_1.duration_ + 0.3

				SetActive(arg_221_1.leftNameGo_, true)

				local var_224_25 = arg_221_1:FormatText(StoryNameCfg[104].name)

				arg_221_1.leftNameTxt_.text = var_224_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, true)
				arg_221_1.iconController_:SetSelectedState("hero")

				arg_221_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_woundedd")

				arg_221_1.callingController_:SetSelectedState("normal")

				arg_221_1.keyicon_.color = Color.New(1, 1, 1)
				arg_221_1.icon_.color = Color.New(1, 1, 1)

				local var_224_26 = arg_221_1:GetWordFromCfg(115281051)
				local var_224_27 = arg_221_1:FormatText(var_224_26.content)

				arg_221_1.text_.text = var_224_27

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_28 = 21
				local var_224_29 = utf8.len(var_224_27)
				local var_224_30 = var_224_28 <= 0 and var_224_23 or var_224_23 * (var_224_29 / var_224_28)

				if var_224_30 > 0 and var_224_23 < var_224_30 then
					arg_221_1.talkMaxDuration = var_224_30
					var_224_22 = var_224_22 + 0.3

					if var_224_30 + var_224_22 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_30 + var_224_22
					end
				end

				arg_221_1.text_.text = var_224_27
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115281", "115281051", "story_v_out_115281.awb") ~= 0 then
					local var_224_31 = manager.audio:GetVoiceLength("story_v_out_115281", "115281051", "story_v_out_115281.awb") / 1000

					if var_224_31 + var_224_22 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_31 + var_224_22
					end

					if var_224_26.prefab_name ~= "" and arg_221_1.actors_[var_224_26.prefab_name] ~= nil then
						local var_224_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_26.prefab_name].transform, "story_v_out_115281", "115281051", "story_v_out_115281.awb")

						arg_221_1:RecordAudio("115281051", var_224_32)
						arg_221_1:RecordAudio("115281051", var_224_32)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_out_115281", "115281051", "story_v_out_115281.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_out_115281", "115281051", "story_v_out_115281.awb")
				end

				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_33 = var_224_22 + 0.3
			local var_224_34 = math.max(var_224_23, arg_221_1.talkMaxDuration)

			if var_224_33 <= arg_221_1.time_ and arg_221_1.time_ < var_224_33 + var_224_34 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_33) / var_224_34

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_33 + var_224_34 and arg_221_1.time_ < var_224_33 + var_224_34 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10030",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_221_1:InitPlayNodeList()
	end,
	Play115281052 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 115281052
		arg_227_1.duration_ = 3.3

		local var_227_0 = {
			ja = 3.3,
			ko = 2.666,
			zh = 2.533,
			en = 2.9
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
				arg_227_0:Play115281053(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			local var_230_0 = 0
			local var_230_1 = 0.3

			if var_230_0 < arg_227_1.time_ and arg_227_1.time_ <= var_230_0 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, true)

				local var_230_2 = arg_227_1:FormatText(StoryNameCfg[105].name)

				arg_227_1.leftNameTxt_.text = var_230_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, true)
				arg_227_1.iconController_:SetSelectedState("hero")

				arg_227_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officeladyb")

				arg_227_1.callingController_:SetSelectedState("normal")

				arg_227_1.keyicon_.color = Color.New(1, 1, 1)
				arg_227_1.icon_.color = Color.New(1, 1, 1)

				local var_230_3 = arg_227_1:GetWordFromCfg(115281052)
				local var_230_4 = arg_227_1:FormatText(var_230_3.content)

				arg_227_1.text_.text = var_230_4

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_5 = 12
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

				if manager.audio:GetVoiceLength("story_v_out_115281", "115281052", "story_v_out_115281.awb") ~= 0 then
					local var_230_8 = manager.audio:GetVoiceLength("story_v_out_115281", "115281052", "story_v_out_115281.awb") / 1000

					if var_230_8 + var_230_0 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_8 + var_230_0
					end

					if var_230_3.prefab_name ~= "" and arg_227_1.actors_[var_230_3.prefab_name] ~= nil then
						local var_230_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_227_1.actors_[var_230_3.prefab_name].transform, "story_v_out_115281", "115281052", "story_v_out_115281.awb")

						arg_227_1:RecordAudio("115281052", var_230_9)
						arg_227_1:RecordAudio("115281052", var_230_9)
					else
						arg_227_1:AudioAction("play", "voice", "story_v_out_115281", "115281052", "story_v_out_115281.awb")
					end

					arg_227_1:RecordHistoryTalkVoice("story_v_out_115281", "115281052", "story_v_out_115281.awb")
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
	Play115281053 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 115281053
		arg_231_1.duration_ = 5.9

		local var_231_0 = {
			ja = 3.766,
			ko = 3.666,
			zh = 4.366,
			en = 5.9
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
				arg_231_0:Play115281054(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			local var_234_0 = arg_231_1.actors_["10030"]
			local var_234_1 = 0

			if var_234_1 < arg_231_1.time_ and arg_231_1.time_ <= var_234_1 + arg_234_0 and not isNil(var_234_0) and arg_231_1.var_.actorSpriteComps10030 == nil then
				arg_231_1.var_.actorSpriteComps10030 = var_234_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_234_2 = 0.2

			if var_234_1 <= arg_231_1.time_ and arg_231_1.time_ < var_234_1 + var_234_2 and not isNil(var_234_0) then
				local var_234_3 = (arg_231_1.time_ - var_234_1) / var_234_2

				if arg_231_1.var_.actorSpriteComps10030 then
					for iter_234_0, iter_234_1 in pairs(arg_231_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_234_1 then
							if arg_231_1.isInRecall_ then
								local var_234_4 = Mathf.Lerp(iter_234_1.color.r, arg_231_1.hightColor1.r, var_234_3)
								local var_234_5 = Mathf.Lerp(iter_234_1.color.g, arg_231_1.hightColor1.g, var_234_3)
								local var_234_6 = Mathf.Lerp(iter_234_1.color.b, arg_231_1.hightColor1.b, var_234_3)

								iter_234_1.color = Color.New(var_234_4, var_234_5, var_234_6)
							else
								local var_234_7 = Mathf.Lerp(iter_234_1.color.r, 1, var_234_3)

								iter_234_1.color = Color.New(var_234_7, var_234_7, var_234_7)
							end
						end
					end
				end
			end

			if arg_231_1.time_ >= var_234_1 + var_234_2 and arg_231_1.time_ < var_234_1 + var_234_2 + arg_234_0 and not isNil(var_234_0) and arg_231_1.var_.actorSpriteComps10030 then
				for iter_234_2, iter_234_3 in pairs(arg_231_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_234_3 then
						if arg_231_1.isInRecall_ then
							iter_234_3.color = arg_231_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_234_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_231_1.var_.actorSpriteComps10030 = nil
			end

			local var_234_8 = arg_231_1.actors_["10030"].transform
			local var_234_9 = 0

			if var_234_9 < arg_231_1.time_ and arg_231_1.time_ <= var_234_9 + arg_234_0 then
				arg_231_1.var_.moveOldPos10030 = var_234_8.localPosition
				var_234_8.localScale = Vector3.New(1, 1, 1)

				arg_231_1:CheckSpriteTmpPos("10030", 3)

				local var_234_10 = var_234_8.childCount

				for iter_234_4 = 0, var_234_10 - 1 do
					local var_234_11 = var_234_8:GetChild(iter_234_4)

					if var_234_11.name == "split_1" or not string.find(var_234_11.name, "split") then
						var_234_11.gameObject:SetActive(true)
					else
						var_234_11.gameObject:SetActive(false)
					end
				end
			end

			local var_234_12 = 0.001

			if var_234_9 <= arg_231_1.time_ and arg_231_1.time_ < var_234_9 + var_234_12 then
				local var_234_13 = (arg_231_1.time_ - var_234_9) / var_234_12
				local var_234_14 = Vector3.New(0, -390, 150)

				var_234_8.localPosition = Vector3.Lerp(arg_231_1.var_.moveOldPos10030, var_234_14, var_234_13)
			end

			if arg_231_1.time_ >= var_234_9 + var_234_12 and arg_231_1.time_ < var_234_9 + var_234_12 + arg_234_0 then
				var_234_8.localPosition = Vector3.New(0, -390, 150)
			end

			local var_234_15 = arg_231_1.actors_["10030"]
			local var_234_16 = 0.0083333333333333

			if var_234_16 < arg_231_1.time_ and arg_231_1.time_ <= var_234_16 + arg_234_0 then
				local var_234_17 = var_234_15:GetComponentInChildren(typeof(CanvasGroup))

				if var_234_17 then
					arg_231_1.var_.alphaOldValue10030 = var_234_17.alpha
					arg_231_1.var_.characterEffect10030 = var_234_17
				end

				arg_231_1.var_.alphaOldValue10030 = 0
			end

			local var_234_18 = 0.333333333333333

			if var_234_16 <= arg_231_1.time_ and arg_231_1.time_ < var_234_16 + var_234_18 then
				local var_234_19 = (arg_231_1.time_ - var_234_16) / var_234_18
				local var_234_20 = Mathf.Lerp(arg_231_1.var_.alphaOldValue10030, 1, var_234_19)

				if arg_231_1.var_.characterEffect10030 then
					arg_231_1.var_.characterEffect10030.alpha = var_234_20
				end
			end

			if arg_231_1.time_ >= var_234_16 + var_234_18 and arg_231_1.time_ < var_234_16 + var_234_18 + arg_234_0 and arg_231_1.var_.characterEffect10030 then
				arg_231_1.var_.characterEffect10030.alpha = 1
			end

			local var_234_21 = 0
			local var_234_22 = 0.325

			if var_234_21 < arg_231_1.time_ and arg_231_1.time_ <= var_234_21 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, true)

				local var_234_23 = arg_231_1:FormatText(StoryNameCfg[309].name)

				arg_231_1.leftNameTxt_.text = var_234_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, false)
				arg_231_1.callingController_:SetSelectedState("normal")

				local var_234_24 = arg_231_1:GetWordFromCfg(115281053)
				local var_234_25 = arg_231_1:FormatText(var_234_24.content)

				arg_231_1.text_.text = var_234_25

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_26 = 13
				local var_234_27 = utf8.len(var_234_25)
				local var_234_28 = var_234_26 <= 0 and var_234_22 or var_234_22 * (var_234_27 / var_234_26)

				if var_234_28 > 0 and var_234_22 < var_234_28 then
					arg_231_1.talkMaxDuration = var_234_28

					if var_234_28 + var_234_21 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_28 + var_234_21
					end
				end

				arg_231_1.text_.text = var_234_25
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115281", "115281053", "story_v_out_115281.awb") ~= 0 then
					local var_234_29 = manager.audio:GetVoiceLength("story_v_out_115281", "115281053", "story_v_out_115281.awb") / 1000

					if var_234_29 + var_234_21 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_29 + var_234_21
					end

					if var_234_24.prefab_name ~= "" and arg_231_1.actors_[var_234_24.prefab_name] ~= nil then
						local var_234_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_231_1.actors_[var_234_24.prefab_name].transform, "story_v_out_115281", "115281053", "story_v_out_115281.awb")

						arg_231_1:RecordAudio("115281053", var_234_30)
						arg_231_1:RecordAudio("115281053", var_234_30)
					else
						arg_231_1:AudioAction("play", "voice", "story_v_out_115281", "115281053", "story_v_out_115281.awb")
					end

					arg_231_1:RecordHistoryTalkVoice("story_v_out_115281", "115281053", "story_v_out_115281.awb")
				end

				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_31 = math.max(var_234_22, arg_231_1.talkMaxDuration)

			if var_234_21 <= arg_231_1.time_ and arg_231_1.time_ < var_234_21 + var_234_31 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_21) / var_234_31

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_21 + var_234_31 and arg_231_1.time_ < var_234_21 + var_234_31 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {
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

		arg_231_1:InitPlayNodeList()
	end,
	Play115281054 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 115281054
		arg_235_1.duration_ = 9.83

		local var_235_0 = {
			ja = 9.833,
			ko = 6.366,
			zh = 5.7,
			en = 6.866
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
				arg_235_0:Play115281055(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			local var_238_0 = arg_235_1.actors_["10030"]
			local var_238_1 = 0

			if var_238_1 < arg_235_1.time_ and arg_235_1.time_ <= var_238_1 + arg_238_0 and not isNil(var_238_0) and arg_235_1.var_.actorSpriteComps10030 == nil then
				arg_235_1.var_.actorSpriteComps10030 = var_238_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_238_2 = 0.2

			if var_238_1 <= arg_235_1.time_ and arg_235_1.time_ < var_238_1 + var_238_2 and not isNil(var_238_0) then
				local var_238_3 = (arg_235_1.time_ - var_238_1) / var_238_2

				if arg_235_1.var_.actorSpriteComps10030 then
					for iter_238_0, iter_238_1 in pairs(arg_235_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_238_1 then
							if arg_235_1.isInRecall_ then
								local var_238_4 = Mathf.Lerp(iter_238_1.color.r, arg_235_1.hightColor2.r, var_238_3)
								local var_238_5 = Mathf.Lerp(iter_238_1.color.g, arg_235_1.hightColor2.g, var_238_3)
								local var_238_6 = Mathf.Lerp(iter_238_1.color.b, arg_235_1.hightColor2.b, var_238_3)

								iter_238_1.color = Color.New(var_238_4, var_238_5, var_238_6)
							else
								local var_238_7 = Mathf.Lerp(iter_238_1.color.r, 0.5, var_238_3)

								iter_238_1.color = Color.New(var_238_7, var_238_7, var_238_7)
							end
						end
					end
				end
			end

			if arg_235_1.time_ >= var_238_1 + var_238_2 and arg_235_1.time_ < var_238_1 + var_238_2 + arg_238_0 and not isNil(var_238_0) and arg_235_1.var_.actorSpriteComps10030 then
				for iter_238_2, iter_238_3 in pairs(arg_235_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_238_3 then
						if arg_235_1.isInRecall_ then
							iter_238_3.color = arg_235_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_238_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_235_1.var_.actorSpriteComps10030 = nil
			end

			local var_238_8 = 0
			local var_238_9 = 0.725

			if var_238_8 < arg_235_1.time_ and arg_235_1.time_ <= var_238_8 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, true)

				local var_238_10 = arg_235_1:FormatText(StoryNameCfg[105].name)

				arg_235_1.leftNameTxt_.text = var_238_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, true)
				arg_235_1.iconController_:SetSelectedState("hero")

				arg_235_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officeladyb")

				arg_235_1.callingController_:SetSelectedState("normal")

				arg_235_1.keyicon_.color = Color.New(1, 1, 1)
				arg_235_1.icon_.color = Color.New(1, 1, 1)

				local var_238_11 = arg_235_1:GetWordFromCfg(115281054)
				local var_238_12 = arg_235_1:FormatText(var_238_11.content)

				arg_235_1.text_.text = var_238_12

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_13 = 29
				local var_238_14 = utf8.len(var_238_12)
				local var_238_15 = var_238_13 <= 0 and var_238_9 or var_238_9 * (var_238_14 / var_238_13)

				if var_238_15 > 0 and var_238_9 < var_238_15 then
					arg_235_1.talkMaxDuration = var_238_15

					if var_238_15 + var_238_8 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_15 + var_238_8
					end
				end

				arg_235_1.text_.text = var_238_12
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115281", "115281054", "story_v_out_115281.awb") ~= 0 then
					local var_238_16 = manager.audio:GetVoiceLength("story_v_out_115281", "115281054", "story_v_out_115281.awb") / 1000

					if var_238_16 + var_238_8 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_16 + var_238_8
					end

					if var_238_11.prefab_name ~= "" and arg_235_1.actors_[var_238_11.prefab_name] ~= nil then
						local var_238_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_235_1.actors_[var_238_11.prefab_name].transform, "story_v_out_115281", "115281054", "story_v_out_115281.awb")

						arg_235_1:RecordAudio("115281054", var_238_17)
						arg_235_1:RecordAudio("115281054", var_238_17)
					else
						arg_235_1:AudioAction("play", "voice", "story_v_out_115281", "115281054", "story_v_out_115281.awb")
					end

					arg_235_1:RecordHistoryTalkVoice("story_v_out_115281", "115281054", "story_v_out_115281.awb")
				end

				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_18 = math.max(var_238_9, arg_235_1.talkMaxDuration)

			if var_238_8 <= arg_235_1.time_ and arg_235_1.time_ < var_238_8 + var_238_18 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_8) / var_238_18

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_8 + var_238_18 and arg_235_1.time_ < var_238_8 + var_238_18 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {}

		arg_235_1:InitPlayNodeList()
	end,
	Play115281055 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 115281055
		arg_239_1.duration_ = 8.37

		local var_239_0 = {
			ja = 8.133,
			ko = 5.966,
			zh = 5,
			en = 8.366
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
				arg_239_0:Play115281056(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			local var_242_0 = 0
			local var_242_1 = 0.675

			if var_242_0 < arg_239_1.time_ and arg_239_1.time_ <= var_242_0 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, true)

				local var_242_2 = arg_239_1:FormatText(StoryNameCfg[104].name)

				arg_239_1.leftNameTxt_.text = var_242_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_239_1.leftNameTxt_.transform)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1.leftNameTxt_.text)
				SetActive(arg_239_1.iconTrs_.gameObject, true)
				arg_239_1.iconController_:SetSelectedState("hero")

				arg_239_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_woundedd")

				arg_239_1.callingController_:SetSelectedState("normal")

				arg_239_1.keyicon_.color = Color.New(1, 1, 1)
				arg_239_1.icon_.color = Color.New(1, 1, 1)

				local var_242_3 = arg_239_1:GetWordFromCfg(115281055)
				local var_242_4 = arg_239_1:FormatText(var_242_3.content)

				arg_239_1.text_.text = var_242_4

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_5 = 27
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

				if manager.audio:GetVoiceLength("story_v_out_115281", "115281055", "story_v_out_115281.awb") ~= 0 then
					local var_242_8 = manager.audio:GetVoiceLength("story_v_out_115281", "115281055", "story_v_out_115281.awb") / 1000

					if var_242_8 + var_242_0 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_8 + var_242_0
					end

					if var_242_3.prefab_name ~= "" and arg_239_1.actors_[var_242_3.prefab_name] ~= nil then
						local var_242_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_239_1.actors_[var_242_3.prefab_name].transform, "story_v_out_115281", "115281055", "story_v_out_115281.awb")

						arg_239_1:RecordAudio("115281055", var_242_9)
						arg_239_1:RecordAudio("115281055", var_242_9)
					else
						arg_239_1:AudioAction("play", "voice", "story_v_out_115281", "115281055", "story_v_out_115281.awb")
					end

					arg_239_1:RecordHistoryTalkVoice("story_v_out_115281", "115281055", "story_v_out_115281.awb")
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
	Play115281056 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 115281056
		arg_243_1.duration_ = 8.37

		local var_243_0 = {
			ja = 8.366,
			ko = 4.7,
			zh = 4.433,
			en = 4.6
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
				arg_243_0:Play115281057(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			local var_246_0 = arg_243_1.actors_["10030"].transform
			local var_246_1 = 0

			if var_246_1 < arg_243_1.time_ and arg_243_1.time_ <= var_246_1 + arg_246_0 then
				arg_243_1.var_.moveOldPos10030 = var_246_0.localPosition
				var_246_0.localScale = Vector3.New(1, 1, 1)

				arg_243_1:CheckSpriteTmpPos("10030", 3)

				local var_246_2 = var_246_0.childCount

				for iter_246_0 = 0, var_246_2 - 1 do
					local var_246_3 = var_246_0:GetChild(iter_246_0)

					if var_246_3.name == "split_2" or not string.find(var_246_3.name, "split") then
						var_246_3.gameObject:SetActive(true)
					else
						var_246_3.gameObject:SetActive(false)
					end
				end
			end

			local var_246_4 = 0.001

			if var_246_1 <= arg_243_1.time_ and arg_243_1.time_ < var_246_1 + var_246_4 then
				local var_246_5 = (arg_243_1.time_ - var_246_1) / var_246_4
				local var_246_6 = Vector3.New(0, -390, 150)

				var_246_0.localPosition = Vector3.Lerp(arg_243_1.var_.moveOldPos10030, var_246_6, var_246_5)
			end

			if arg_243_1.time_ >= var_246_1 + var_246_4 and arg_243_1.time_ < var_246_1 + var_246_4 + arg_246_0 then
				var_246_0.localPosition = Vector3.New(0, -390, 150)
			end

			local var_246_7 = arg_243_1.actors_["10030"]
			local var_246_8 = 0

			if var_246_8 < arg_243_1.time_ and arg_243_1.time_ <= var_246_8 + arg_246_0 and not isNil(var_246_7) and arg_243_1.var_.actorSpriteComps10030 == nil then
				arg_243_1.var_.actorSpriteComps10030 = var_246_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_246_9 = 0.2

			if var_246_8 <= arg_243_1.time_ and arg_243_1.time_ < var_246_8 + var_246_9 and not isNil(var_246_7) then
				local var_246_10 = (arg_243_1.time_ - var_246_8) / var_246_9

				if arg_243_1.var_.actorSpriteComps10030 then
					for iter_246_1, iter_246_2 in pairs(arg_243_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_246_2 then
							if arg_243_1.isInRecall_ then
								local var_246_11 = Mathf.Lerp(iter_246_2.color.r, arg_243_1.hightColor1.r, var_246_10)
								local var_246_12 = Mathf.Lerp(iter_246_2.color.g, arg_243_1.hightColor1.g, var_246_10)
								local var_246_13 = Mathf.Lerp(iter_246_2.color.b, arg_243_1.hightColor1.b, var_246_10)

								iter_246_2.color = Color.New(var_246_11, var_246_12, var_246_13)
							else
								local var_246_14 = Mathf.Lerp(iter_246_2.color.r, 1, var_246_10)

								iter_246_2.color = Color.New(var_246_14, var_246_14, var_246_14)
							end
						end
					end
				end
			end

			if arg_243_1.time_ >= var_246_8 + var_246_9 and arg_243_1.time_ < var_246_8 + var_246_9 + arg_246_0 and not isNil(var_246_7) and arg_243_1.var_.actorSpriteComps10030 then
				for iter_246_3, iter_246_4 in pairs(arg_243_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_246_4 then
						if arg_243_1.isInRecall_ then
							iter_246_4.color = arg_243_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_246_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_243_1.var_.actorSpriteComps10030 = nil
			end

			local var_246_15 = 0
			local var_246_16 = 0.35

			if var_246_15 < arg_243_1.time_ and arg_243_1.time_ <= var_246_15 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, true)

				local var_246_17 = arg_243_1:FormatText(StoryNameCfg[309].name)

				arg_243_1.leftNameTxt_.text = var_246_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, false)
				arg_243_1.callingController_:SetSelectedState("normal")

				local var_246_18 = arg_243_1:GetWordFromCfg(115281056)
				local var_246_19 = arg_243_1:FormatText(var_246_18.content)

				arg_243_1.text_.text = var_246_19

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_20 = 14
				local var_246_21 = utf8.len(var_246_19)
				local var_246_22 = var_246_20 <= 0 and var_246_16 or var_246_16 * (var_246_21 / var_246_20)

				if var_246_22 > 0 and var_246_16 < var_246_22 then
					arg_243_1.talkMaxDuration = var_246_22

					if var_246_22 + var_246_15 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_22 + var_246_15
					end
				end

				arg_243_1.text_.text = var_246_19
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115281", "115281056", "story_v_out_115281.awb") ~= 0 then
					local var_246_23 = manager.audio:GetVoiceLength("story_v_out_115281", "115281056", "story_v_out_115281.awb") / 1000

					if var_246_23 + var_246_15 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_23 + var_246_15
					end

					if var_246_18.prefab_name ~= "" and arg_243_1.actors_[var_246_18.prefab_name] ~= nil then
						local var_246_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_243_1.actors_[var_246_18.prefab_name].transform, "story_v_out_115281", "115281056", "story_v_out_115281.awb")

						arg_243_1:RecordAudio("115281056", var_246_24)
						arg_243_1:RecordAudio("115281056", var_246_24)
					else
						arg_243_1:AudioAction("play", "voice", "story_v_out_115281", "115281056", "story_v_out_115281.awb")
					end

					arg_243_1:RecordHistoryTalkVoice("story_v_out_115281", "115281056", "story_v_out_115281.awb")
				end

				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_25 = math.max(var_246_16, arg_243_1.talkMaxDuration)

			if var_246_15 <= arg_243_1.time_ and arg_243_1.time_ < var_246_15 + var_246_25 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_15) / var_246_25

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_15 + var_246_25 and arg_243_1.time_ < var_246_15 + var_246_25 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {
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

		arg_243_1:InitPlayNodeList()
	end,
	Play115281057 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 115281057
		arg_247_1.duration_ = 9.87

		local var_247_0 = {
			ja = 9.866,
			ko = 7.5,
			zh = 8.933,
			en = 7.633
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
				arg_247_0:Play115281058(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			local var_250_0 = arg_247_1.actors_["10030"].transform
			local var_250_1 = 2

			if var_250_1 < arg_247_1.time_ and arg_247_1.time_ <= var_250_1 + arg_250_0 then
				arg_247_1.var_.moveOldPos10030 = var_250_0.localPosition
				var_250_0.localScale = Vector3.New(1, 1, 1)

				arg_247_1:CheckSpriteTmpPos("10030", 0)

				local var_250_2 = var_250_0.childCount

				for iter_250_0 = 0, var_250_2 - 1 do
					local var_250_3 = var_250_0:GetChild(iter_250_0)

					if var_250_3.name == "split_2" or not string.find(var_250_3.name, "split") then
						var_250_3.gameObject:SetActive(true)
					else
						var_250_3.gameObject:SetActive(false)
					end
				end
			end

			local var_250_4 = 0.001

			if var_250_1 <= arg_247_1.time_ and arg_247_1.time_ < var_250_1 + var_250_4 then
				local var_250_5 = (arg_247_1.time_ - var_250_1) / var_250_4
				local var_250_6 = Vector3.New(-2000, -390, 150)

				var_250_0.localPosition = Vector3.Lerp(arg_247_1.var_.moveOldPos10030, var_250_6, var_250_5)
			end

			if arg_247_1.time_ >= var_250_1 + var_250_4 and arg_247_1.time_ < var_250_1 + var_250_4 + arg_250_0 then
				var_250_0.localPosition = Vector3.New(-2000, -390, 150)
			end

			local var_250_7 = 0

			if var_250_7 < arg_247_1.time_ and arg_247_1.time_ <= var_250_7 + arg_250_0 then
				arg_247_1.mask_.enabled = true
				arg_247_1.mask_.raycastTarget = false

				arg_247_1:SetGaussion(false)
			end

			local var_250_8 = 2

			if var_250_7 <= arg_247_1.time_ and arg_247_1.time_ < var_250_7 + var_250_8 then
				local var_250_9 = (arg_247_1.time_ - var_250_7) / var_250_8
				local var_250_10 = Color.New(0, 0, 0)

				var_250_10.a = Mathf.Lerp(0, 1, var_250_9)
				arg_247_1.mask_.color = var_250_10
			end

			if arg_247_1.time_ >= var_250_7 + var_250_8 and arg_247_1.time_ < var_250_7 + var_250_8 + arg_250_0 then
				local var_250_11 = Color.New(0, 0, 0)

				var_250_11.a = 1
				arg_247_1.mask_.color = var_250_11
			end

			local var_250_12 = 2

			if var_250_12 < arg_247_1.time_ and arg_247_1.time_ <= var_250_12 + arg_250_0 then
				arg_247_1.mask_.enabled = true
				arg_247_1.mask_.raycastTarget = false

				arg_247_1:SetGaussion(false)
			end

			local var_250_13 = 2

			if var_250_12 <= arg_247_1.time_ and arg_247_1.time_ < var_250_12 + var_250_13 then
				local var_250_14 = (arg_247_1.time_ - var_250_12) / var_250_13
				local var_250_15 = Color.New(0, 0, 0)

				var_250_15.a = Mathf.Lerp(1, 0, var_250_14)
				arg_247_1.mask_.color = var_250_15
			end

			if arg_247_1.time_ >= var_250_12 + var_250_13 and arg_247_1.time_ < var_250_12 + var_250_13 + arg_250_0 then
				local var_250_16 = Color.New(0, 0, 0)
				local var_250_17 = 0

				arg_247_1.mask_.enabled = false
				var_250_16.a = var_250_17
				arg_247_1.mask_.color = var_250_16
			end

			local var_250_18 = 2

			arg_247_1.isInRecall_ = false

			if var_250_18 < arg_247_1.time_ and arg_247_1.time_ <= var_250_18 + arg_250_0 then
				arg_247_1.screenFilterGo_:SetActive(false)

				for iter_250_1, iter_250_2 in pairs(arg_247_1.actors_) do
					local var_250_19 = iter_250_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_250_3, iter_250_4 in ipairs(var_250_19) do
						if iter_250_4.color.r > 0.51 then
							iter_250_4.color = Color.New(1, 1, 1)
						else
							iter_250_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end
			end

			local var_250_20 = 0.0166666666666667

			if var_250_18 <= arg_247_1.time_ and arg_247_1.time_ < var_250_18 + var_250_20 then
				local var_250_21 = (arg_247_1.time_ - var_250_18) / var_250_20

				arg_247_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, var_250_21)
			end

			if arg_247_1.time_ >= var_250_18 + var_250_20 and arg_247_1.time_ < var_250_18 + var_250_20 + arg_250_0 then
				arg_247_1.screenFilterEffect_.weight = 0
			end

			if arg_247_1.frameCnt_ <= 1 then
				arg_247_1.dialog_:SetActive(false)
			end

			local var_250_22 = 4
			local var_250_23 = 0.425

			if var_250_22 < arg_247_1.time_ and arg_247_1.time_ <= var_250_22 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0

				arg_247_1.dialog_:SetActive(true)

				arg_247_1.dialogCg_.alpha = 0

				local var_250_24 = LeanTween.value(arg_247_1.dialog_, 0, 1, 0.3)

				var_250_24:setOnUpdate(LuaHelper.FloatAction(function(arg_251_0)
					arg_247_1.dialogCg_.alpha = arg_251_0
				end))
				var_250_24:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_247_1.dialog_)
					var_250_24:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_247_1.duration_ = arg_247_1.duration_ + 0.3

				SetActive(arg_247_1.leftNameGo_, true)

				local var_250_25 = arg_247_1:FormatText(StoryNameCfg[36].name)

				arg_247_1.leftNameTxt_.text = var_250_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, false)
				arg_247_1.callingController_:SetSelectedState("normal")

				local var_250_26 = arg_247_1:GetWordFromCfg(115281057)
				local var_250_27 = arg_247_1:FormatText(var_250_26.content)

				arg_247_1.text_.text = var_250_27

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_28 = 17
				local var_250_29 = utf8.len(var_250_27)
				local var_250_30 = var_250_28 <= 0 and var_250_23 or var_250_23 * (var_250_29 / var_250_28)

				if var_250_30 > 0 and var_250_23 < var_250_30 then
					arg_247_1.talkMaxDuration = var_250_30
					var_250_22 = var_250_22 + 0.3

					if var_250_30 + var_250_22 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_30 + var_250_22
					end
				end

				arg_247_1.text_.text = var_250_27
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115281", "115281057", "story_v_out_115281.awb") ~= 0 then
					local var_250_31 = manager.audio:GetVoiceLength("story_v_out_115281", "115281057", "story_v_out_115281.awb") / 1000

					if var_250_31 + var_250_22 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_31 + var_250_22
					end

					if var_250_26.prefab_name ~= "" and arg_247_1.actors_[var_250_26.prefab_name] ~= nil then
						local var_250_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_247_1.actors_[var_250_26.prefab_name].transform, "story_v_out_115281", "115281057", "story_v_out_115281.awb")

						arg_247_1:RecordAudio("115281057", var_250_32)
						arg_247_1:RecordAudio("115281057", var_250_32)
					else
						arg_247_1:AudioAction("play", "voice", "story_v_out_115281", "115281057", "story_v_out_115281.awb")
					end

					arg_247_1:RecordHistoryTalkVoice("story_v_out_115281", "115281057", "story_v_out_115281.awb")
				end

				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_33 = var_250_22 + 0.3
			local var_250_34 = math.max(var_250_23, arg_247_1.talkMaxDuration)

			if var_250_33 <= arg_247_1.time_ and arg_247_1.time_ < var_250_33 + var_250_34 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_33) / var_250_34

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_33 + var_250_34 and arg_247_1.time_ < var_250_33 + var_250_34 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10030",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_247_1:InitPlayNodeList()
	end,
	Play115281058 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 115281058
		arg_253_1.duration_ = 5

		SetActive(arg_253_1.tipsGo_, false)

		function arg_253_1.onSingleLineFinish_()
			arg_253_1.onSingleLineUpdate_ = nil
			arg_253_1.onSingleLineFinish_ = nil
			arg_253_1.state_ = "waiting"
		end

		function arg_253_1.playNext_(arg_255_0)
			if arg_255_0 == 1 then
				arg_253_0:Play115281059(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			local var_256_0 = 0
			local var_256_1 = 1.225

			if var_256_0 < arg_253_1.time_ and arg_253_1.time_ <= var_256_0 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, false)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_253_1.iconTrs_.gameObject, false)
				arg_253_1.callingController_:SetSelectedState("normal")

				local var_256_2 = arg_253_1:GetWordFromCfg(115281058)
				local var_256_3 = arg_253_1:FormatText(var_256_2.content)

				arg_253_1.text_.text = var_256_3

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_4 = 49
				local var_256_5 = utf8.len(var_256_3)
				local var_256_6 = var_256_4 <= 0 and var_256_1 or var_256_1 * (var_256_5 / var_256_4)

				if var_256_6 > 0 and var_256_1 < var_256_6 then
					arg_253_1.talkMaxDuration = var_256_6

					if var_256_6 + var_256_0 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_6 + var_256_0
					end
				end

				arg_253_1.text_.text = var_256_3
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)
				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_7 = math.max(var_256_1, arg_253_1.talkMaxDuration)

			if var_256_0 <= arg_253_1.time_ and arg_253_1.time_ < var_256_0 + var_256_7 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_0) / var_256_7

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_0 + var_256_7 and arg_253_1.time_ < var_256_0 + var_256_7 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {}

		arg_253_1:InitPlayNodeList()
	end,
	Play115281059 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 115281059
		arg_257_1.duration_ = 3.97

		local var_257_0 = {
			ja = 3.433,
			ko = 3.2,
			zh = 3.466,
			en = 3.966
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
				arg_257_0:Play115281060(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			local var_260_0 = arg_257_1.actors_["10030"].transform
			local var_260_1 = 0

			if var_260_1 < arg_257_1.time_ and arg_257_1.time_ <= var_260_1 + arg_260_0 then
				arg_257_1.var_.moveOldPos10030 = var_260_0.localPosition
				var_260_0.localScale = Vector3.New(1, 1, 1)

				arg_257_1:CheckSpriteTmpPos("10030", 4)

				local var_260_2 = var_260_0.childCount

				for iter_260_0 = 0, var_260_2 - 1 do
					local var_260_3 = var_260_0:GetChild(iter_260_0)

					if var_260_3.name == "split_1" or not string.find(var_260_3.name, "split") then
						var_260_3.gameObject:SetActive(true)
					else
						var_260_3.gameObject:SetActive(false)
					end
				end
			end

			local var_260_4 = 0.001

			if var_260_1 <= arg_257_1.time_ and arg_257_1.time_ < var_260_1 + var_260_4 then
				local var_260_5 = (arg_257_1.time_ - var_260_1) / var_260_4
				local var_260_6 = Vector3.New(390, -390, 150)

				var_260_0.localPosition = Vector3.Lerp(arg_257_1.var_.moveOldPos10030, var_260_6, var_260_5)
			end

			if arg_257_1.time_ >= var_260_1 + var_260_4 and arg_257_1.time_ < var_260_1 + var_260_4 + arg_260_0 then
				var_260_0.localPosition = Vector3.New(390, -390, 150)
			end

			local var_260_7 = "1038"

			if arg_257_1.actors_[var_260_7] == nil then
				local var_260_8 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1038")

				if not isNil(var_260_8) then
					local var_260_9 = Object.Instantiate(var_260_8, arg_257_1.canvasGo_.transform)

					var_260_9.transform:SetSiblingIndex(1)

					var_260_9.name = var_260_7
					var_260_9.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_257_1.actors_[var_260_7] = var_260_9

					local var_260_10 = var_260_9:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_257_1.isInRecall_ then
						for iter_260_1, iter_260_2 in ipairs(var_260_10) do
							iter_260_2.color = arg_257_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_260_11 = arg_257_1.actors_["1038"].transform
			local var_260_12 = 0

			if var_260_12 < arg_257_1.time_ and arg_257_1.time_ <= var_260_12 + arg_260_0 then
				arg_257_1.var_.moveOldPos1038 = var_260_11.localPosition
				var_260_11.localScale = Vector3.New(1, 1, 1)

				arg_257_1:CheckSpriteTmpPos("1038", 2)

				local var_260_13 = var_260_11.childCount

				for iter_260_3 = 0, var_260_13 - 1 do
					local var_260_14 = var_260_11:GetChild(iter_260_3)

					if var_260_14.name == "split_1" or not string.find(var_260_14.name, "split") then
						var_260_14.gameObject:SetActive(true)
					else
						var_260_14.gameObject:SetActive(false)
					end
				end
			end

			local var_260_15 = 0.001

			if var_260_12 <= arg_257_1.time_ and arg_257_1.time_ < var_260_12 + var_260_15 then
				local var_260_16 = (arg_257_1.time_ - var_260_12) / var_260_15
				local var_260_17 = Vector3.New(-390, -400, 0)

				var_260_11.localPosition = Vector3.Lerp(arg_257_1.var_.moveOldPos1038, var_260_17, var_260_16)
			end

			if arg_257_1.time_ >= var_260_12 + var_260_15 and arg_257_1.time_ < var_260_12 + var_260_15 + arg_260_0 then
				var_260_11.localPosition = Vector3.New(-390, -400, 0)
			end

			local var_260_18 = arg_257_1.actors_["10030"]
			local var_260_19 = 0

			if var_260_19 < arg_257_1.time_ and arg_257_1.time_ <= var_260_19 + arg_260_0 and not isNil(var_260_18) and arg_257_1.var_.actorSpriteComps10030 == nil then
				arg_257_1.var_.actorSpriteComps10030 = var_260_18:GetComponentsInChildren(typeof(Image), true)
			end

			local var_260_20 = 0.2

			if var_260_19 <= arg_257_1.time_ and arg_257_1.time_ < var_260_19 + var_260_20 and not isNil(var_260_18) then
				local var_260_21 = (arg_257_1.time_ - var_260_19) / var_260_20

				if arg_257_1.var_.actorSpriteComps10030 then
					for iter_260_4, iter_260_5 in pairs(arg_257_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_260_5 then
							if arg_257_1.isInRecall_ then
								local var_260_22 = Mathf.Lerp(iter_260_5.color.r, arg_257_1.hightColor1.r, var_260_21)
								local var_260_23 = Mathf.Lerp(iter_260_5.color.g, arg_257_1.hightColor1.g, var_260_21)
								local var_260_24 = Mathf.Lerp(iter_260_5.color.b, arg_257_1.hightColor1.b, var_260_21)

								iter_260_5.color = Color.New(var_260_22, var_260_23, var_260_24)
							else
								local var_260_25 = Mathf.Lerp(iter_260_5.color.r, 1, var_260_21)

								iter_260_5.color = Color.New(var_260_25, var_260_25, var_260_25)
							end
						end
					end
				end
			end

			if arg_257_1.time_ >= var_260_19 + var_260_20 and arg_257_1.time_ < var_260_19 + var_260_20 + arg_260_0 and not isNil(var_260_18) and arg_257_1.var_.actorSpriteComps10030 then
				for iter_260_6, iter_260_7 in pairs(arg_257_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_260_7 then
						if arg_257_1.isInRecall_ then
							iter_260_7.color = arg_257_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_260_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_257_1.var_.actorSpriteComps10030 = nil
			end

			local var_260_26 = arg_257_1.actors_["10030"]
			local var_260_27 = 0

			if var_260_27 < arg_257_1.time_ and arg_257_1.time_ <= var_260_27 + arg_260_0 then
				local var_260_28 = var_260_26:GetComponentInChildren(typeof(CanvasGroup))

				if var_260_28 then
					arg_257_1.var_.alphaOldValue10030 = var_260_28.alpha
					arg_257_1.var_.characterEffect10030 = var_260_28
				end

				arg_257_1.var_.alphaOldValue10030 = 0
			end

			local var_260_29 = 0.333333333333333

			if var_260_27 <= arg_257_1.time_ and arg_257_1.time_ < var_260_27 + var_260_29 then
				local var_260_30 = (arg_257_1.time_ - var_260_27) / var_260_29
				local var_260_31 = Mathf.Lerp(arg_257_1.var_.alphaOldValue10030, 1, var_260_30)

				if arg_257_1.var_.characterEffect10030 then
					arg_257_1.var_.characterEffect10030.alpha = var_260_31
				end
			end

			if arg_257_1.time_ >= var_260_27 + var_260_29 and arg_257_1.time_ < var_260_27 + var_260_29 + arg_260_0 and arg_257_1.var_.characterEffect10030 then
				arg_257_1.var_.characterEffect10030.alpha = 1
			end

			local var_260_32 = arg_257_1.actors_["1038"]
			local var_260_33 = 0

			if var_260_33 < arg_257_1.time_ and arg_257_1.time_ <= var_260_33 + arg_260_0 then
				local var_260_34 = var_260_32:GetComponentInChildren(typeof(CanvasGroup))

				if var_260_34 then
					arg_257_1.var_.alphaOldValue1038 = var_260_34.alpha
					arg_257_1.var_.characterEffect1038 = var_260_34
				end

				arg_257_1.var_.alphaOldValue1038 = 0
			end

			local var_260_35 = 0.333333333333333

			if var_260_33 <= arg_257_1.time_ and arg_257_1.time_ < var_260_33 + var_260_35 then
				local var_260_36 = (arg_257_1.time_ - var_260_33) / var_260_35
				local var_260_37 = Mathf.Lerp(arg_257_1.var_.alphaOldValue1038, 1, var_260_36)

				if arg_257_1.var_.characterEffect1038 then
					arg_257_1.var_.characterEffect1038.alpha = var_260_37
				end
			end

			if arg_257_1.time_ >= var_260_33 + var_260_35 and arg_257_1.time_ < var_260_33 + var_260_35 + arg_260_0 and arg_257_1.var_.characterEffect1038 then
				arg_257_1.var_.characterEffect1038.alpha = 1
			end

			local var_260_38 = arg_257_1.actors_["1038"]
			local var_260_39 = 0

			if var_260_39 < arg_257_1.time_ and arg_257_1.time_ <= var_260_39 + arg_260_0 and not isNil(var_260_38) and arg_257_1.var_.actorSpriteComps1038 == nil then
				arg_257_1.var_.actorSpriteComps1038 = var_260_38:GetComponentsInChildren(typeof(Image), true)
			end

			local var_260_40 = 0.0166666666666667

			if var_260_39 <= arg_257_1.time_ and arg_257_1.time_ < var_260_39 + var_260_40 and not isNil(var_260_38) then
				local var_260_41 = (arg_257_1.time_ - var_260_39) / var_260_40

				if arg_257_1.var_.actorSpriteComps1038 then
					for iter_260_8, iter_260_9 in pairs(arg_257_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_260_9 then
							if arg_257_1.isInRecall_ then
								local var_260_42 = Mathf.Lerp(iter_260_9.color.r, arg_257_1.hightColor2.r, var_260_41)
								local var_260_43 = Mathf.Lerp(iter_260_9.color.g, arg_257_1.hightColor2.g, var_260_41)
								local var_260_44 = Mathf.Lerp(iter_260_9.color.b, arg_257_1.hightColor2.b, var_260_41)

								iter_260_9.color = Color.New(var_260_42, var_260_43, var_260_44)
							else
								local var_260_45 = Mathf.Lerp(iter_260_9.color.r, 0.5, var_260_41)

								iter_260_9.color = Color.New(var_260_45, var_260_45, var_260_45)
							end
						end
					end
				end
			end

			if arg_257_1.time_ >= var_260_39 + var_260_40 and arg_257_1.time_ < var_260_39 + var_260_40 + arg_260_0 and not isNil(var_260_38) and arg_257_1.var_.actorSpriteComps1038 then
				for iter_260_10, iter_260_11 in pairs(arg_257_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_260_11 then
						if arg_257_1.isInRecall_ then
							iter_260_11.color = arg_257_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_260_11.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_257_1.var_.actorSpriteComps1038 = nil
			end

			local var_260_46 = 0
			local var_260_47 = 0.325

			if var_260_46 < arg_257_1.time_ and arg_257_1.time_ <= var_260_46 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				local var_260_48 = arg_257_1:FormatText(StoryNameCfg[309].name)

				arg_257_1.leftNameTxt_.text = var_260_48

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_49 = arg_257_1:GetWordFromCfg(115281059)
				local var_260_50 = arg_257_1:FormatText(var_260_49.content)

				arg_257_1.text_.text = var_260_50

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_51 = 13
				local var_260_52 = utf8.len(var_260_50)
				local var_260_53 = var_260_51 <= 0 and var_260_47 or var_260_47 * (var_260_52 / var_260_51)

				if var_260_53 > 0 and var_260_47 < var_260_53 then
					arg_257_1.talkMaxDuration = var_260_53

					if var_260_53 + var_260_46 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_53 + var_260_46
					end
				end

				arg_257_1.text_.text = var_260_50
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115281", "115281059", "story_v_out_115281.awb") ~= 0 then
					local var_260_54 = manager.audio:GetVoiceLength("story_v_out_115281", "115281059", "story_v_out_115281.awb") / 1000

					if var_260_54 + var_260_46 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_54 + var_260_46
					end

					if var_260_49.prefab_name ~= "" and arg_257_1.actors_[var_260_49.prefab_name] ~= nil then
						local var_260_55 = LuaForUtil.PlayVoiceWithCriLipsync(arg_257_1.actors_[var_260_49.prefab_name].transform, "story_v_out_115281", "115281059", "story_v_out_115281.awb")

						arg_257_1:RecordAudio("115281059", var_260_55)
						arg_257_1:RecordAudio("115281059", var_260_55)
					else
						arg_257_1:AudioAction("play", "voice", "story_v_out_115281", "115281059", "story_v_out_115281.awb")
					end

					arg_257_1:RecordHistoryTalkVoice("story_v_out_115281", "115281059", "story_v_out_115281.awb")
				end

				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_56 = math.max(var_260_47, arg_257_1.talkMaxDuration)

			if var_260_46 <= arg_257_1.time_ and arg_257_1.time_ < var_260_46 + var_260_56 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_46) / var_260_56

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_46 + var_260_56 and arg_257_1.time_ < var_260_46 + var_260_56 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10030",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
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

		arg_257_1:InitPlayNodeList()
	end,
	Play115281060 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 115281060
		arg_261_1.duration_ = 4.03

		local var_261_0 = {
			ja = 2.333,
			ko = 3.966,
			zh = 4.033,
			en = 3.2
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
				arg_261_0:Play115281061(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			local var_264_0 = arg_261_1.actors_["1038"].transform
			local var_264_1 = 0

			if var_264_1 < arg_261_1.time_ and arg_261_1.time_ <= var_264_1 + arg_264_0 then
				arg_261_1.var_.moveOldPos1038 = var_264_0.localPosition
				var_264_0.localScale = Vector3.New(1, 1, 1)

				arg_261_1:CheckSpriteTmpPos("1038", 2)

				local var_264_2 = var_264_0.childCount

				for iter_264_0 = 0, var_264_2 - 1 do
					local var_264_3 = var_264_0:GetChild(iter_264_0)

					if var_264_3.name == "split_1" or not string.find(var_264_3.name, "split") then
						var_264_3.gameObject:SetActive(true)
					else
						var_264_3.gameObject:SetActive(false)
					end
				end
			end

			local var_264_4 = 0.001

			if var_264_1 <= arg_261_1.time_ and arg_261_1.time_ < var_264_1 + var_264_4 then
				local var_264_5 = (arg_261_1.time_ - var_264_1) / var_264_4
				local var_264_6 = Vector3.New(-390, -400, 0)

				var_264_0.localPosition = Vector3.Lerp(arg_261_1.var_.moveOldPos1038, var_264_6, var_264_5)
			end

			if arg_261_1.time_ >= var_264_1 + var_264_4 and arg_261_1.time_ < var_264_1 + var_264_4 + arg_264_0 then
				var_264_0.localPosition = Vector3.New(-390, -400, 0)
			end

			local var_264_7 = arg_261_1.actors_["10030"]
			local var_264_8 = 0

			if var_264_8 < arg_261_1.time_ and arg_261_1.time_ <= var_264_8 + arg_264_0 and not isNil(var_264_7) and arg_261_1.var_.actorSpriteComps10030 == nil then
				arg_261_1.var_.actorSpriteComps10030 = var_264_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_264_9 = 0.2

			if var_264_8 <= arg_261_1.time_ and arg_261_1.time_ < var_264_8 + var_264_9 and not isNil(var_264_7) then
				local var_264_10 = (arg_261_1.time_ - var_264_8) / var_264_9

				if arg_261_1.var_.actorSpriteComps10030 then
					for iter_264_1, iter_264_2 in pairs(arg_261_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_264_2 then
							if arg_261_1.isInRecall_ then
								local var_264_11 = Mathf.Lerp(iter_264_2.color.r, arg_261_1.hightColor2.r, var_264_10)
								local var_264_12 = Mathf.Lerp(iter_264_2.color.g, arg_261_1.hightColor2.g, var_264_10)
								local var_264_13 = Mathf.Lerp(iter_264_2.color.b, arg_261_1.hightColor2.b, var_264_10)

								iter_264_2.color = Color.New(var_264_11, var_264_12, var_264_13)
							else
								local var_264_14 = Mathf.Lerp(iter_264_2.color.r, 0.5, var_264_10)

								iter_264_2.color = Color.New(var_264_14, var_264_14, var_264_14)
							end
						end
					end
				end
			end

			if arg_261_1.time_ >= var_264_8 + var_264_9 and arg_261_1.time_ < var_264_8 + var_264_9 + arg_264_0 and not isNil(var_264_7) and arg_261_1.var_.actorSpriteComps10030 then
				for iter_264_3, iter_264_4 in pairs(arg_261_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_264_4 then
						if arg_261_1.isInRecall_ then
							iter_264_4.color = arg_261_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_264_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_261_1.var_.actorSpriteComps10030 = nil
			end

			local var_264_15 = arg_261_1.actors_["1038"]
			local var_264_16 = 0

			if var_264_16 < arg_261_1.time_ and arg_261_1.time_ <= var_264_16 + arg_264_0 and not isNil(var_264_15) and arg_261_1.var_.actorSpriteComps1038 == nil then
				arg_261_1.var_.actorSpriteComps1038 = var_264_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_264_17 = 0.2

			if var_264_16 <= arg_261_1.time_ and arg_261_1.time_ < var_264_16 + var_264_17 and not isNil(var_264_15) then
				local var_264_18 = (arg_261_1.time_ - var_264_16) / var_264_17

				if arg_261_1.var_.actorSpriteComps1038 then
					for iter_264_5, iter_264_6 in pairs(arg_261_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_264_6 then
							if arg_261_1.isInRecall_ then
								local var_264_19 = Mathf.Lerp(iter_264_6.color.r, arg_261_1.hightColor1.r, var_264_18)
								local var_264_20 = Mathf.Lerp(iter_264_6.color.g, arg_261_1.hightColor1.g, var_264_18)
								local var_264_21 = Mathf.Lerp(iter_264_6.color.b, arg_261_1.hightColor1.b, var_264_18)

								iter_264_6.color = Color.New(var_264_19, var_264_20, var_264_21)
							else
								local var_264_22 = Mathf.Lerp(iter_264_6.color.r, 1, var_264_18)

								iter_264_6.color = Color.New(var_264_22, var_264_22, var_264_22)
							end
						end
					end
				end
			end

			if arg_261_1.time_ >= var_264_16 + var_264_17 and arg_261_1.time_ < var_264_16 + var_264_17 + arg_264_0 and not isNil(var_264_15) and arg_261_1.var_.actorSpriteComps1038 then
				for iter_264_7, iter_264_8 in pairs(arg_261_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_264_8 then
						if arg_261_1.isInRecall_ then
							iter_264_8.color = arg_261_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_264_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_261_1.var_.actorSpriteComps1038 = nil
			end

			local var_264_23 = 0
			local var_264_24 = 0.4

			if var_264_23 < arg_261_1.time_ and arg_261_1.time_ <= var_264_23 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				local var_264_25 = arg_261_1:FormatText(StoryNameCfg[94].name)

				arg_261_1.leftNameTxt_.text = var_264_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_26 = arg_261_1:GetWordFromCfg(115281060)
				local var_264_27 = arg_261_1:FormatText(var_264_26.content)

				arg_261_1.text_.text = var_264_27

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_28 = 16
				local var_264_29 = utf8.len(var_264_27)
				local var_264_30 = var_264_28 <= 0 and var_264_24 or var_264_24 * (var_264_29 / var_264_28)

				if var_264_30 > 0 and var_264_24 < var_264_30 then
					arg_261_1.talkMaxDuration = var_264_30

					if var_264_30 + var_264_23 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_30 + var_264_23
					end
				end

				arg_261_1.text_.text = var_264_27
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115281", "115281060", "story_v_out_115281.awb") ~= 0 then
					local var_264_31 = manager.audio:GetVoiceLength("story_v_out_115281", "115281060", "story_v_out_115281.awb") / 1000

					if var_264_31 + var_264_23 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_31 + var_264_23
					end

					if var_264_26.prefab_name ~= "" and arg_261_1.actors_[var_264_26.prefab_name] ~= nil then
						local var_264_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_261_1.actors_[var_264_26.prefab_name].transform, "story_v_out_115281", "115281060", "story_v_out_115281.awb")

						arg_261_1:RecordAudio("115281060", var_264_32)
						arg_261_1:RecordAudio("115281060", var_264_32)
					else
						arg_261_1:AudioAction("play", "voice", "story_v_out_115281", "115281060", "story_v_out_115281.awb")
					end

					arg_261_1:RecordHistoryTalkVoice("story_v_out_115281", "115281060", "story_v_out_115281.awb")
				end

				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_33 = math.max(var_264_24, arg_261_1.talkMaxDuration)

			if var_264_23 <= arg_261_1.time_ and arg_261_1.time_ < var_264_23 + var_264_33 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_23) / var_264_33

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_23 + var_264_33 and arg_261_1.time_ < var_264_23 + var_264_33 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {
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

		arg_261_1:InitPlayNodeList()
	end,
	Play115281061 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 115281061
		arg_265_1.duration_ = 8.4

		local var_265_0 = {
			ja = 8.4,
			ko = 3.766,
			zh = 4.9,
			en = 5.166
		}
		local var_265_1 = manager.audio:GetLocalizationFlag()

		if var_265_0[var_265_1] ~= nil then
			arg_265_1.duration_ = var_265_0[var_265_1]
		end

		SetActive(arg_265_1.tipsGo_, false)

		function arg_265_1.onSingleLineFinish_()
			arg_265_1.onSingleLineUpdate_ = nil
			arg_265_1.onSingleLineFinish_ = nil
			arg_265_1.state_ = "waiting"
		end

		function arg_265_1.playNext_(arg_267_0)
			if arg_267_0 == 1 then
				arg_265_0:Play115281062(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			local var_268_0 = 0
			local var_268_1 = 0.475

			if var_268_0 < arg_265_1.time_ and arg_265_1.time_ <= var_268_0 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, true)

				local var_268_2 = arg_265_1:FormatText(StoryNameCfg[94].name)

				arg_265_1.leftNameTxt_.text = var_268_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_265_1.leftNameTxt_.transform)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1.leftNameTxt_.text)
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_3 = arg_265_1:GetWordFromCfg(115281061)
				local var_268_4 = arg_265_1:FormatText(var_268_3.content)

				arg_265_1.text_.text = var_268_4

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_5 = 19
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

				if manager.audio:GetVoiceLength("story_v_out_115281", "115281061", "story_v_out_115281.awb") ~= 0 then
					local var_268_8 = manager.audio:GetVoiceLength("story_v_out_115281", "115281061", "story_v_out_115281.awb") / 1000

					if var_268_8 + var_268_0 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_8 + var_268_0
					end

					if var_268_3.prefab_name ~= "" and arg_265_1.actors_[var_268_3.prefab_name] ~= nil then
						local var_268_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_265_1.actors_[var_268_3.prefab_name].transform, "story_v_out_115281", "115281061", "story_v_out_115281.awb")

						arg_265_1:RecordAudio("115281061", var_268_9)
						arg_265_1:RecordAudio("115281061", var_268_9)
					else
						arg_265_1:AudioAction("play", "voice", "story_v_out_115281", "115281061", "story_v_out_115281.awb")
					end

					arg_265_1:RecordHistoryTalkVoice("story_v_out_115281", "115281061", "story_v_out_115281.awb")
				end

				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_10 = math.max(var_268_1, arg_265_1.talkMaxDuration)

			if var_268_0 <= arg_265_1.time_ and arg_265_1.time_ < var_268_0 + var_268_10 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_0) / var_268_10

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_0 + var_268_10 and arg_265_1.time_ < var_268_0 + var_268_10 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {}

		arg_265_1:InitPlayNodeList()
	end,
	Play115281062 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 115281062
		arg_269_1.duration_ = 6.33

		local var_269_0 = {
			ja = 6.333,
			ko = 3.6,
			zh = 3.1,
			en = 4.033
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
				arg_269_0:Play115281063(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			local var_272_0 = arg_269_1.actors_["10030"]
			local var_272_1 = 0

			if var_272_1 < arg_269_1.time_ and arg_269_1.time_ <= var_272_1 + arg_272_0 and not isNil(var_272_0) and arg_269_1.var_.actorSpriteComps10030 == nil then
				arg_269_1.var_.actorSpriteComps10030 = var_272_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_272_2 = 0.2

			if var_272_1 <= arg_269_1.time_ and arg_269_1.time_ < var_272_1 + var_272_2 and not isNil(var_272_0) then
				local var_272_3 = (arg_269_1.time_ - var_272_1) / var_272_2

				if arg_269_1.var_.actorSpriteComps10030 then
					for iter_272_0, iter_272_1 in pairs(arg_269_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_272_1 then
							if arg_269_1.isInRecall_ then
								local var_272_4 = Mathf.Lerp(iter_272_1.color.r, arg_269_1.hightColor1.r, var_272_3)
								local var_272_5 = Mathf.Lerp(iter_272_1.color.g, arg_269_1.hightColor1.g, var_272_3)
								local var_272_6 = Mathf.Lerp(iter_272_1.color.b, arg_269_1.hightColor1.b, var_272_3)

								iter_272_1.color = Color.New(var_272_4, var_272_5, var_272_6)
							else
								local var_272_7 = Mathf.Lerp(iter_272_1.color.r, 1, var_272_3)

								iter_272_1.color = Color.New(var_272_7, var_272_7, var_272_7)
							end
						end
					end
				end
			end

			if arg_269_1.time_ >= var_272_1 + var_272_2 and arg_269_1.time_ < var_272_1 + var_272_2 + arg_272_0 and not isNil(var_272_0) and arg_269_1.var_.actorSpriteComps10030 then
				for iter_272_2, iter_272_3 in pairs(arg_269_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_272_3 then
						if arg_269_1.isInRecall_ then
							iter_272_3.color = arg_269_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_272_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_269_1.var_.actorSpriteComps10030 = nil
			end

			local var_272_8 = arg_269_1.actors_["1038"]
			local var_272_9 = 0

			if var_272_9 < arg_269_1.time_ and arg_269_1.time_ <= var_272_9 + arg_272_0 and not isNil(var_272_8) and arg_269_1.var_.actorSpriteComps1038 == nil then
				arg_269_1.var_.actorSpriteComps1038 = var_272_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_272_10 = 0.2

			if var_272_9 <= arg_269_1.time_ and arg_269_1.time_ < var_272_9 + var_272_10 and not isNil(var_272_8) then
				local var_272_11 = (arg_269_1.time_ - var_272_9) / var_272_10

				if arg_269_1.var_.actorSpriteComps1038 then
					for iter_272_4, iter_272_5 in pairs(arg_269_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_272_5 then
							if arg_269_1.isInRecall_ then
								local var_272_12 = Mathf.Lerp(iter_272_5.color.r, arg_269_1.hightColor2.r, var_272_11)
								local var_272_13 = Mathf.Lerp(iter_272_5.color.g, arg_269_1.hightColor2.g, var_272_11)
								local var_272_14 = Mathf.Lerp(iter_272_5.color.b, arg_269_1.hightColor2.b, var_272_11)

								iter_272_5.color = Color.New(var_272_12, var_272_13, var_272_14)
							else
								local var_272_15 = Mathf.Lerp(iter_272_5.color.r, 0.5, var_272_11)

								iter_272_5.color = Color.New(var_272_15, var_272_15, var_272_15)
							end
						end
					end
				end
			end

			if arg_269_1.time_ >= var_272_9 + var_272_10 and arg_269_1.time_ < var_272_9 + var_272_10 + arg_272_0 and not isNil(var_272_8) and arg_269_1.var_.actorSpriteComps1038 then
				for iter_272_6, iter_272_7 in pairs(arg_269_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_272_7 then
						if arg_269_1.isInRecall_ then
							iter_272_7.color = arg_269_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_272_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_269_1.var_.actorSpriteComps1038 = nil
			end

			local var_272_16 = 0
			local var_272_17 = 0.35

			if var_272_16 < arg_269_1.time_ and arg_269_1.time_ <= var_272_16 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, true)

				local var_272_18 = arg_269_1:FormatText(StoryNameCfg[309].name)

				arg_269_1.leftNameTxt_.text = var_272_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_269_1.leftNameTxt_.transform)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1.leftNameTxt_.text)
				SetActive(arg_269_1.iconTrs_.gameObject, false)
				arg_269_1.callingController_:SetSelectedState("normal")

				local var_272_19 = arg_269_1:GetWordFromCfg(115281062)
				local var_272_20 = arg_269_1:FormatText(var_272_19.content)

				arg_269_1.text_.text = var_272_20

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_21 = 14
				local var_272_22 = utf8.len(var_272_20)
				local var_272_23 = var_272_21 <= 0 and var_272_17 or var_272_17 * (var_272_22 / var_272_21)

				if var_272_23 > 0 and var_272_17 < var_272_23 then
					arg_269_1.talkMaxDuration = var_272_23

					if var_272_23 + var_272_16 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_23 + var_272_16
					end
				end

				arg_269_1.text_.text = var_272_20
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115281", "115281062", "story_v_out_115281.awb") ~= 0 then
					local var_272_24 = manager.audio:GetVoiceLength("story_v_out_115281", "115281062", "story_v_out_115281.awb") / 1000

					if var_272_24 + var_272_16 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_24 + var_272_16
					end

					if var_272_19.prefab_name ~= "" and arg_269_1.actors_[var_272_19.prefab_name] ~= nil then
						local var_272_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_269_1.actors_[var_272_19.prefab_name].transform, "story_v_out_115281", "115281062", "story_v_out_115281.awb")

						arg_269_1:RecordAudio("115281062", var_272_25)
						arg_269_1:RecordAudio("115281062", var_272_25)
					else
						arg_269_1:AudioAction("play", "voice", "story_v_out_115281", "115281062", "story_v_out_115281.awb")
					end

					arg_269_1:RecordHistoryTalkVoice("story_v_out_115281", "115281062", "story_v_out_115281.awb")
				end

				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_26 = math.max(var_272_17, arg_269_1.talkMaxDuration)

			if var_272_16 <= arg_269_1.time_ and arg_269_1.time_ < var_272_16 + var_272_26 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - var_272_16) / var_272_26

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= var_272_16 + var_272_26 and arg_269_1.time_ < var_272_16 + var_272_26 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {}

		arg_269_1:InitPlayNodeList()
	end,
	Play115281063 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 115281063
		arg_273_1.duration_ = 5

		SetActive(arg_273_1.tipsGo_, false)

		function arg_273_1.onSingleLineFinish_()
			arg_273_1.onSingleLineUpdate_ = nil
			arg_273_1.onSingleLineFinish_ = nil
			arg_273_1.state_ = "waiting"
		end

		function arg_273_1.playNext_(arg_275_0)
			if arg_275_0 == 1 then
				arg_273_0:Play115281064(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			local var_276_0 = arg_273_1.actors_["10030"]
			local var_276_1 = 0

			if var_276_1 < arg_273_1.time_ and arg_273_1.time_ <= var_276_1 + arg_276_0 and not isNil(var_276_0) and arg_273_1.var_.actorSpriteComps10030 == nil then
				arg_273_1.var_.actorSpriteComps10030 = var_276_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_276_2 = 0.2

			if var_276_1 <= arg_273_1.time_ and arg_273_1.time_ < var_276_1 + var_276_2 and not isNil(var_276_0) then
				local var_276_3 = (arg_273_1.time_ - var_276_1) / var_276_2

				if arg_273_1.var_.actorSpriteComps10030 then
					for iter_276_0, iter_276_1 in pairs(arg_273_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_276_1 then
							if arg_273_1.isInRecall_ then
								local var_276_4 = Mathf.Lerp(iter_276_1.color.r, arg_273_1.hightColor2.r, var_276_3)
								local var_276_5 = Mathf.Lerp(iter_276_1.color.g, arg_273_1.hightColor2.g, var_276_3)
								local var_276_6 = Mathf.Lerp(iter_276_1.color.b, arg_273_1.hightColor2.b, var_276_3)

								iter_276_1.color = Color.New(var_276_4, var_276_5, var_276_6)
							else
								local var_276_7 = Mathf.Lerp(iter_276_1.color.r, 0.5, var_276_3)

								iter_276_1.color = Color.New(var_276_7, var_276_7, var_276_7)
							end
						end
					end
				end
			end

			if arg_273_1.time_ >= var_276_1 + var_276_2 and arg_273_1.time_ < var_276_1 + var_276_2 + arg_276_0 and not isNil(var_276_0) and arg_273_1.var_.actorSpriteComps10030 then
				for iter_276_2, iter_276_3 in pairs(arg_273_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_276_3 then
						if arg_273_1.isInRecall_ then
							iter_276_3.color = arg_273_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_276_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_273_1.var_.actorSpriteComps10030 = nil
			end

			local var_276_8 = 0
			local var_276_9 = 1.15

			if var_276_8 < arg_273_1.time_ and arg_273_1.time_ <= var_276_8 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, false)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_273_1.iconTrs_.gameObject, false)
				arg_273_1.callingController_:SetSelectedState("normal")

				local var_276_10 = arg_273_1:GetWordFromCfg(115281063)
				local var_276_11 = arg_273_1:FormatText(var_276_10.content)

				arg_273_1.text_.text = var_276_11

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_12 = 46
				local var_276_13 = utf8.len(var_276_11)
				local var_276_14 = var_276_12 <= 0 and var_276_9 or var_276_9 * (var_276_13 / var_276_12)

				if var_276_14 > 0 and var_276_9 < var_276_14 then
					arg_273_1.talkMaxDuration = var_276_14

					if var_276_14 + var_276_8 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_14 + var_276_8
					end
				end

				arg_273_1.text_.text = var_276_11
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)
				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_15 = math.max(var_276_9, arg_273_1.talkMaxDuration)

			if var_276_8 <= arg_273_1.time_ and arg_273_1.time_ < var_276_8 + var_276_15 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - var_276_8) / var_276_15

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= var_276_8 + var_276_15 and arg_273_1.time_ < var_276_8 + var_276_15 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {}

		arg_273_1:InitPlayNodeList()
	end,
	Play115281064 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 115281064
		arg_277_1.duration_ = 7

		local var_277_0 = {
			ja = 7,
			ko = 5.266,
			zh = 5.2,
			en = 5.3
		}
		local var_277_1 = manager.audio:GetLocalizationFlag()

		if var_277_0[var_277_1] ~= nil then
			arg_277_1.duration_ = var_277_0[var_277_1]
		end

		SetActive(arg_277_1.tipsGo_, false)

		function arg_277_1.onSingleLineFinish_()
			arg_277_1.onSingleLineUpdate_ = nil
			arg_277_1.onSingleLineFinish_ = nil
			arg_277_1.state_ = "waiting"
		end

		function arg_277_1.playNext_(arg_279_0)
			if arg_279_0 == 1 then
				arg_277_0:Play115281065(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			local var_280_0 = arg_277_1.actors_["1038"]
			local var_280_1 = 0

			if var_280_1 < arg_277_1.time_ and arg_277_1.time_ <= var_280_1 + arg_280_0 and not isNil(var_280_0) and arg_277_1.var_.actorSpriteComps1038 == nil then
				arg_277_1.var_.actorSpriteComps1038 = var_280_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_280_2 = 0.2

			if var_280_1 <= arg_277_1.time_ and arg_277_1.time_ < var_280_1 + var_280_2 and not isNil(var_280_0) then
				local var_280_3 = (arg_277_1.time_ - var_280_1) / var_280_2

				if arg_277_1.var_.actorSpriteComps1038 then
					for iter_280_0, iter_280_1 in pairs(arg_277_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_280_1 then
							if arg_277_1.isInRecall_ then
								local var_280_4 = Mathf.Lerp(iter_280_1.color.r, arg_277_1.hightColor1.r, var_280_3)
								local var_280_5 = Mathf.Lerp(iter_280_1.color.g, arg_277_1.hightColor1.g, var_280_3)
								local var_280_6 = Mathf.Lerp(iter_280_1.color.b, arg_277_1.hightColor1.b, var_280_3)

								iter_280_1.color = Color.New(var_280_4, var_280_5, var_280_6)
							else
								local var_280_7 = Mathf.Lerp(iter_280_1.color.r, 1, var_280_3)

								iter_280_1.color = Color.New(var_280_7, var_280_7, var_280_7)
							end
						end
					end
				end
			end

			if arg_277_1.time_ >= var_280_1 + var_280_2 and arg_277_1.time_ < var_280_1 + var_280_2 + arg_280_0 and not isNil(var_280_0) and arg_277_1.var_.actorSpriteComps1038 then
				for iter_280_2, iter_280_3 in pairs(arg_277_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_280_3 then
						if arg_277_1.isInRecall_ then
							iter_280_3.color = arg_277_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_280_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_277_1.var_.actorSpriteComps1038 = nil
			end

			local var_280_8 = 0
			local var_280_9 = 0.525

			if var_280_8 < arg_277_1.time_ and arg_277_1.time_ <= var_280_8 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, true)

				local var_280_10 = arg_277_1:FormatText(StoryNameCfg[94].name)

				arg_277_1.leftNameTxt_.text = var_280_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, false)
				arg_277_1.callingController_:SetSelectedState("normal")

				local var_280_11 = arg_277_1:GetWordFromCfg(115281064)
				local var_280_12 = arg_277_1:FormatText(var_280_11.content)

				arg_277_1.text_.text = var_280_12

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_13 = 19
				local var_280_14 = utf8.len(var_280_12)
				local var_280_15 = var_280_13 <= 0 and var_280_9 or var_280_9 * (var_280_14 / var_280_13)

				if var_280_15 > 0 and var_280_9 < var_280_15 then
					arg_277_1.talkMaxDuration = var_280_15

					if var_280_15 + var_280_8 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_15 + var_280_8
					end
				end

				arg_277_1.text_.text = var_280_12
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115281", "115281064", "story_v_out_115281.awb") ~= 0 then
					local var_280_16 = manager.audio:GetVoiceLength("story_v_out_115281", "115281064", "story_v_out_115281.awb") / 1000

					if var_280_16 + var_280_8 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_16 + var_280_8
					end

					if var_280_11.prefab_name ~= "" and arg_277_1.actors_[var_280_11.prefab_name] ~= nil then
						local var_280_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_277_1.actors_[var_280_11.prefab_name].transform, "story_v_out_115281", "115281064", "story_v_out_115281.awb")

						arg_277_1:RecordAudio("115281064", var_280_17)
						arg_277_1:RecordAudio("115281064", var_280_17)
					else
						arg_277_1:AudioAction("play", "voice", "story_v_out_115281", "115281064", "story_v_out_115281.awb")
					end

					arg_277_1:RecordHistoryTalkVoice("story_v_out_115281", "115281064", "story_v_out_115281.awb")
				end

				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_18 = math.max(var_280_9, arg_277_1.talkMaxDuration)

			if var_280_8 <= arg_277_1.time_ and arg_277_1.time_ < var_280_8 + var_280_18 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - var_280_8) / var_280_18

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= var_280_8 + var_280_18 and arg_277_1.time_ < var_280_8 + var_280_18 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {}

		arg_277_1:InitPlayNodeList()
	end,
	Play115281065 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 115281065
		arg_281_1.duration_ = 3.03

		local var_281_0 = {
			ja = 3.033,
			ko = 1.5,
			zh = 2.733,
			en = 2.7
		}
		local var_281_1 = manager.audio:GetLocalizationFlag()

		if var_281_0[var_281_1] ~= nil then
			arg_281_1.duration_ = var_281_0[var_281_1]
		end

		SetActive(arg_281_1.tipsGo_, false)

		function arg_281_1.onSingleLineFinish_()
			arg_281_1.onSingleLineUpdate_ = nil
			arg_281_1.onSingleLineFinish_ = nil
			arg_281_1.state_ = "waiting"
		end

		function arg_281_1.playNext_(arg_283_0)
			if arg_283_0 == 1 then
				arg_281_0:Play115281066(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			local var_284_0 = arg_281_1.actors_["1038"]
			local var_284_1 = 0

			if var_284_1 < arg_281_1.time_ and arg_281_1.time_ <= var_284_1 + arg_284_0 and not isNil(var_284_0) and arg_281_1.var_.actorSpriteComps1038 == nil then
				arg_281_1.var_.actorSpriteComps1038 = var_284_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_284_2 = 0.2

			if var_284_1 <= arg_281_1.time_ and arg_281_1.time_ < var_284_1 + var_284_2 and not isNil(var_284_0) then
				local var_284_3 = (arg_281_1.time_ - var_284_1) / var_284_2

				if arg_281_1.var_.actorSpriteComps1038 then
					for iter_284_0, iter_284_1 in pairs(arg_281_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_284_1 then
							if arg_281_1.isInRecall_ then
								local var_284_4 = Mathf.Lerp(iter_284_1.color.r, arg_281_1.hightColor2.r, var_284_3)
								local var_284_5 = Mathf.Lerp(iter_284_1.color.g, arg_281_1.hightColor2.g, var_284_3)
								local var_284_6 = Mathf.Lerp(iter_284_1.color.b, arg_281_1.hightColor2.b, var_284_3)

								iter_284_1.color = Color.New(var_284_4, var_284_5, var_284_6)
							else
								local var_284_7 = Mathf.Lerp(iter_284_1.color.r, 0.5, var_284_3)

								iter_284_1.color = Color.New(var_284_7, var_284_7, var_284_7)
							end
						end
					end
				end
			end

			if arg_281_1.time_ >= var_284_1 + var_284_2 and arg_281_1.time_ < var_284_1 + var_284_2 + arg_284_0 and not isNil(var_284_0) and arg_281_1.var_.actorSpriteComps1038 then
				for iter_284_2, iter_284_3 in pairs(arg_281_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_284_3 then
						if arg_281_1.isInRecall_ then
							iter_284_3.color = arg_281_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_284_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_281_1.var_.actorSpriteComps1038 = nil
			end

			local var_284_8 = arg_281_1.actors_["10030"]
			local var_284_9 = 0

			if var_284_9 < arg_281_1.time_ and arg_281_1.time_ <= var_284_9 + arg_284_0 and not isNil(var_284_8) and arg_281_1.var_.actorSpriteComps10030 == nil then
				arg_281_1.var_.actorSpriteComps10030 = var_284_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_284_10 = 0.2

			if var_284_9 <= arg_281_1.time_ and arg_281_1.time_ < var_284_9 + var_284_10 and not isNil(var_284_8) then
				local var_284_11 = (arg_281_1.time_ - var_284_9) / var_284_10

				if arg_281_1.var_.actorSpriteComps10030 then
					for iter_284_4, iter_284_5 in pairs(arg_281_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_284_5 then
							if arg_281_1.isInRecall_ then
								local var_284_12 = Mathf.Lerp(iter_284_5.color.r, arg_281_1.hightColor1.r, var_284_11)
								local var_284_13 = Mathf.Lerp(iter_284_5.color.g, arg_281_1.hightColor1.g, var_284_11)
								local var_284_14 = Mathf.Lerp(iter_284_5.color.b, arg_281_1.hightColor1.b, var_284_11)

								iter_284_5.color = Color.New(var_284_12, var_284_13, var_284_14)
							else
								local var_284_15 = Mathf.Lerp(iter_284_5.color.r, 1, var_284_11)

								iter_284_5.color = Color.New(var_284_15, var_284_15, var_284_15)
							end
						end
					end
				end
			end

			if arg_281_1.time_ >= var_284_9 + var_284_10 and arg_281_1.time_ < var_284_9 + var_284_10 + arg_284_0 and not isNil(var_284_8) and arg_281_1.var_.actorSpriteComps10030 then
				for iter_284_6, iter_284_7 in pairs(arg_281_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_284_7 then
						if arg_281_1.isInRecall_ then
							iter_284_7.color = arg_281_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_284_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_281_1.var_.actorSpriteComps10030 = nil
			end

			local var_284_16 = arg_281_1.actors_["10030"].transform
			local var_284_17 = 0

			if var_284_17 < arg_281_1.time_ and arg_281_1.time_ <= var_284_17 + arg_284_0 then
				arg_281_1.var_.moveOldPos10030 = var_284_16.localPosition
				var_284_16.localScale = Vector3.New(1, 1, 1)

				arg_281_1:CheckSpriteTmpPos("10030", 4)

				local var_284_18 = var_284_16.childCount

				for iter_284_8 = 0, var_284_18 - 1 do
					local var_284_19 = var_284_16:GetChild(iter_284_8)

					if var_284_19.name == "split_3" or not string.find(var_284_19.name, "split") then
						var_284_19.gameObject:SetActive(true)
					else
						var_284_19.gameObject:SetActive(false)
					end
				end
			end

			local var_284_20 = 0.001

			if var_284_17 <= arg_281_1.time_ and arg_281_1.time_ < var_284_17 + var_284_20 then
				local var_284_21 = (arg_281_1.time_ - var_284_17) / var_284_20
				local var_284_22 = Vector3.New(390, -390, 150)

				var_284_16.localPosition = Vector3.Lerp(arg_281_1.var_.moveOldPos10030, var_284_22, var_284_21)
			end

			if arg_281_1.time_ >= var_284_17 + var_284_20 and arg_281_1.time_ < var_284_17 + var_284_20 + arg_284_0 then
				var_284_16.localPosition = Vector3.New(390, -390, 150)
			end

			local var_284_23 = arg_281_1.actors_["10030"]
			local var_284_24 = 0

			if var_284_24 < arg_281_1.time_ and arg_281_1.time_ <= var_284_24 + arg_284_0 then
				local var_284_25 = var_284_23:GetComponentInChildren(typeof(CanvasGroup))

				if var_284_25 then
					arg_281_1.var_.alphaOldValue10030 = var_284_25.alpha
					arg_281_1.var_.characterEffect10030 = var_284_25
				end

				arg_281_1.var_.alphaOldValue10030 = 0
			end

			local var_284_26 = 0.0166666666666667

			if var_284_24 <= arg_281_1.time_ and arg_281_1.time_ < var_284_24 + var_284_26 then
				local var_284_27 = (arg_281_1.time_ - var_284_24) / var_284_26
				local var_284_28 = Mathf.Lerp(arg_281_1.var_.alphaOldValue10030, 1, var_284_27)

				if arg_281_1.var_.characterEffect10030 then
					arg_281_1.var_.characterEffect10030.alpha = var_284_28
				end
			end

			if arg_281_1.time_ >= var_284_24 + var_284_26 and arg_281_1.time_ < var_284_24 + var_284_26 + arg_284_0 and arg_281_1.var_.characterEffect10030 then
				arg_281_1.var_.characterEffect10030.alpha = 1
			end

			local var_284_29 = 0
			local var_284_30 = 0.125

			if var_284_29 < arg_281_1.time_ and arg_281_1.time_ <= var_284_29 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, true)

				local var_284_31 = arg_281_1:FormatText(StoryNameCfg[309].name)

				arg_281_1.leftNameTxt_.text = var_284_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_281_1.leftNameTxt_.transform)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1.leftNameTxt_.text)
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_32 = arg_281_1:GetWordFromCfg(115281065)
				local var_284_33 = arg_281_1:FormatText(var_284_32.content)

				arg_281_1.text_.text = var_284_33

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_34 = 5
				local var_284_35 = utf8.len(var_284_33)
				local var_284_36 = var_284_34 <= 0 and var_284_30 or var_284_30 * (var_284_35 / var_284_34)

				if var_284_36 > 0 and var_284_30 < var_284_36 then
					arg_281_1.talkMaxDuration = var_284_36

					if var_284_36 + var_284_29 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_36 + var_284_29
					end
				end

				arg_281_1.text_.text = var_284_33
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115281", "115281065", "story_v_out_115281.awb") ~= 0 then
					local var_284_37 = manager.audio:GetVoiceLength("story_v_out_115281", "115281065", "story_v_out_115281.awb") / 1000

					if var_284_37 + var_284_29 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_37 + var_284_29
					end

					if var_284_32.prefab_name ~= "" and arg_281_1.actors_[var_284_32.prefab_name] ~= nil then
						local var_284_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_281_1.actors_[var_284_32.prefab_name].transform, "story_v_out_115281", "115281065", "story_v_out_115281.awb")

						arg_281_1:RecordAudio("115281065", var_284_38)
						arg_281_1:RecordAudio("115281065", var_284_38)
					else
						arg_281_1:AudioAction("play", "voice", "story_v_out_115281", "115281065", "story_v_out_115281.awb")
					end

					arg_281_1:RecordHistoryTalkVoice("story_v_out_115281", "115281065", "story_v_out_115281.awb")
				end

				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_39 = math.max(var_284_30, arg_281_1.talkMaxDuration)

			if var_284_29 <= arg_281_1.time_ and arg_281_1.time_ < var_284_29 + var_284_39 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - var_284_29) / var_284_39

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= var_284_29 + var_284_39 and arg_281_1.time_ < var_284_29 + var_284_39 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {
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

		arg_281_1:InitPlayNodeList()
	end,
	Play115281066 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 115281066
		arg_285_1.duration_ = 12.5

		local var_285_0 = {
			ja = 12.5,
			ko = 7.266,
			zh = 8.333,
			en = 8.2
		}
		local var_285_1 = manager.audio:GetLocalizationFlag()

		if var_285_0[var_285_1] ~= nil then
			arg_285_1.duration_ = var_285_0[var_285_1]
		end

		SetActive(arg_285_1.tipsGo_, false)

		function arg_285_1.onSingleLineFinish_()
			arg_285_1.onSingleLineUpdate_ = nil
			arg_285_1.onSingleLineFinish_ = nil
			arg_285_1.state_ = "waiting"
		end

		function arg_285_1.playNext_(arg_287_0)
			if arg_287_0 == 1 then
				arg_285_0:Play115281067(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			local var_288_0 = arg_285_1.actors_["1038"]
			local var_288_1 = 0

			if var_288_1 < arg_285_1.time_ and arg_285_1.time_ <= var_288_1 + arg_288_0 and not isNil(var_288_0) and arg_285_1.var_.actorSpriteComps1038 == nil then
				arg_285_1.var_.actorSpriteComps1038 = var_288_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_288_2 = 0.2

			if var_288_1 <= arg_285_1.time_ and arg_285_1.time_ < var_288_1 + var_288_2 and not isNil(var_288_0) then
				local var_288_3 = (arg_285_1.time_ - var_288_1) / var_288_2

				if arg_285_1.var_.actorSpriteComps1038 then
					for iter_288_0, iter_288_1 in pairs(arg_285_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_288_1 then
							if arg_285_1.isInRecall_ then
								local var_288_4 = Mathf.Lerp(iter_288_1.color.r, arg_285_1.hightColor1.r, var_288_3)
								local var_288_5 = Mathf.Lerp(iter_288_1.color.g, arg_285_1.hightColor1.g, var_288_3)
								local var_288_6 = Mathf.Lerp(iter_288_1.color.b, arg_285_1.hightColor1.b, var_288_3)

								iter_288_1.color = Color.New(var_288_4, var_288_5, var_288_6)
							else
								local var_288_7 = Mathf.Lerp(iter_288_1.color.r, 1, var_288_3)

								iter_288_1.color = Color.New(var_288_7, var_288_7, var_288_7)
							end
						end
					end
				end
			end

			if arg_285_1.time_ >= var_288_1 + var_288_2 and arg_285_1.time_ < var_288_1 + var_288_2 + arg_288_0 and not isNil(var_288_0) and arg_285_1.var_.actorSpriteComps1038 then
				for iter_288_2, iter_288_3 in pairs(arg_285_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_288_3 then
						if arg_285_1.isInRecall_ then
							iter_288_3.color = arg_285_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_288_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_285_1.var_.actorSpriteComps1038 = nil
			end

			local var_288_8 = arg_285_1.actors_["10030"]
			local var_288_9 = 0

			if var_288_9 < arg_285_1.time_ and arg_285_1.time_ <= var_288_9 + arg_288_0 and not isNil(var_288_8) and arg_285_1.var_.actorSpriteComps10030 == nil then
				arg_285_1.var_.actorSpriteComps10030 = var_288_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_288_10 = 0.2

			if var_288_9 <= arg_285_1.time_ and arg_285_1.time_ < var_288_9 + var_288_10 and not isNil(var_288_8) then
				local var_288_11 = (arg_285_1.time_ - var_288_9) / var_288_10

				if arg_285_1.var_.actorSpriteComps10030 then
					for iter_288_4, iter_288_5 in pairs(arg_285_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_288_5 then
							if arg_285_1.isInRecall_ then
								local var_288_12 = Mathf.Lerp(iter_288_5.color.r, arg_285_1.hightColor2.r, var_288_11)
								local var_288_13 = Mathf.Lerp(iter_288_5.color.g, arg_285_1.hightColor2.g, var_288_11)
								local var_288_14 = Mathf.Lerp(iter_288_5.color.b, arg_285_1.hightColor2.b, var_288_11)

								iter_288_5.color = Color.New(var_288_12, var_288_13, var_288_14)
							else
								local var_288_15 = Mathf.Lerp(iter_288_5.color.r, 0.5, var_288_11)

								iter_288_5.color = Color.New(var_288_15, var_288_15, var_288_15)
							end
						end
					end
				end
			end

			if arg_285_1.time_ >= var_288_9 + var_288_10 and arg_285_1.time_ < var_288_9 + var_288_10 + arg_288_0 and not isNil(var_288_8) and arg_285_1.var_.actorSpriteComps10030 then
				for iter_288_6, iter_288_7 in pairs(arg_285_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_288_7 then
						if arg_285_1.isInRecall_ then
							iter_288_7.color = arg_285_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_288_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_285_1.var_.actorSpriteComps10030 = nil
			end

			local var_288_16 = 0
			local var_288_17 = 0.85

			if var_288_16 < arg_285_1.time_ and arg_285_1.time_ <= var_288_16 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, true)

				local var_288_18 = arg_285_1:FormatText(StoryNameCfg[94].name)

				arg_285_1.leftNameTxt_.text = var_288_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_285_1.leftNameTxt_.transform)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1.leftNameTxt_.text)
				SetActive(arg_285_1.iconTrs_.gameObject, false)
				arg_285_1.callingController_:SetSelectedState("normal")

				local var_288_19 = arg_285_1:GetWordFromCfg(115281066)
				local var_288_20 = arg_285_1:FormatText(var_288_19.content)

				arg_285_1.text_.text = var_288_20

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_21 = 34
				local var_288_22 = utf8.len(var_288_20)
				local var_288_23 = var_288_21 <= 0 and var_288_17 or var_288_17 * (var_288_22 / var_288_21)

				if var_288_23 > 0 and var_288_17 < var_288_23 then
					arg_285_1.talkMaxDuration = var_288_23

					if var_288_23 + var_288_16 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_23 + var_288_16
					end
				end

				arg_285_1.text_.text = var_288_20
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115281", "115281066", "story_v_out_115281.awb") ~= 0 then
					local var_288_24 = manager.audio:GetVoiceLength("story_v_out_115281", "115281066", "story_v_out_115281.awb") / 1000

					if var_288_24 + var_288_16 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_24 + var_288_16
					end

					if var_288_19.prefab_name ~= "" and arg_285_1.actors_[var_288_19.prefab_name] ~= nil then
						local var_288_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_285_1.actors_[var_288_19.prefab_name].transform, "story_v_out_115281", "115281066", "story_v_out_115281.awb")

						arg_285_1:RecordAudio("115281066", var_288_25)
						arg_285_1:RecordAudio("115281066", var_288_25)
					else
						arg_285_1:AudioAction("play", "voice", "story_v_out_115281", "115281066", "story_v_out_115281.awb")
					end

					arg_285_1:RecordHistoryTalkVoice("story_v_out_115281", "115281066", "story_v_out_115281.awb")
				end

				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_26 = math.max(var_288_17, arg_285_1.talkMaxDuration)

			if var_288_16 <= arg_285_1.time_ and arg_285_1.time_ < var_288_16 + var_288_26 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - var_288_16) / var_288_26

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= var_288_16 + var_288_26 and arg_285_1.time_ < var_288_16 + var_288_26 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {}

		arg_285_1:InitPlayNodeList()
	end,
	Play115281067 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 115281067
		arg_289_1.duration_ = 8.73

		local var_289_0 = {
			ja = 6.933,
			ko = 8.033,
			zh = 7.566,
			en = 8.733
		}
		local var_289_1 = manager.audio:GetLocalizationFlag()

		if var_289_0[var_289_1] ~= nil then
			arg_289_1.duration_ = var_289_0[var_289_1]
		end

		SetActive(arg_289_1.tipsGo_, false)

		function arg_289_1.onSingleLineFinish_()
			arg_289_1.onSingleLineUpdate_ = nil
			arg_289_1.onSingleLineFinish_ = nil
			arg_289_1.state_ = "waiting"
		end

		function arg_289_1.playNext_(arg_291_0)
			if arg_291_0 == 1 then
				arg_289_0:Play115281068(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			local var_292_0 = arg_289_1.actors_["1038"]
			local var_292_1 = 0

			if var_292_1 < arg_289_1.time_ and arg_289_1.time_ <= var_292_1 + arg_292_0 and not isNil(var_292_0) and arg_289_1.var_.actorSpriteComps1038 == nil then
				arg_289_1.var_.actorSpriteComps1038 = var_292_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_292_2 = 0.2

			if var_292_1 <= arg_289_1.time_ and arg_289_1.time_ < var_292_1 + var_292_2 and not isNil(var_292_0) then
				local var_292_3 = (arg_289_1.time_ - var_292_1) / var_292_2

				if arg_289_1.var_.actorSpriteComps1038 then
					for iter_292_0, iter_292_1 in pairs(arg_289_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_292_1 then
							if arg_289_1.isInRecall_ then
								local var_292_4 = Mathf.Lerp(iter_292_1.color.r, arg_289_1.hightColor2.r, var_292_3)
								local var_292_5 = Mathf.Lerp(iter_292_1.color.g, arg_289_1.hightColor2.g, var_292_3)
								local var_292_6 = Mathf.Lerp(iter_292_1.color.b, arg_289_1.hightColor2.b, var_292_3)

								iter_292_1.color = Color.New(var_292_4, var_292_5, var_292_6)
							else
								local var_292_7 = Mathf.Lerp(iter_292_1.color.r, 0.5, var_292_3)

								iter_292_1.color = Color.New(var_292_7, var_292_7, var_292_7)
							end
						end
					end
				end
			end

			if arg_289_1.time_ >= var_292_1 + var_292_2 and arg_289_1.time_ < var_292_1 + var_292_2 + arg_292_0 and not isNil(var_292_0) and arg_289_1.var_.actorSpriteComps1038 then
				for iter_292_2, iter_292_3 in pairs(arg_289_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_292_3 then
						if arg_289_1.isInRecall_ then
							iter_292_3.color = arg_289_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_292_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_289_1.var_.actorSpriteComps1038 = nil
			end

			local var_292_8 = arg_289_1.actors_["10030"]
			local var_292_9 = 0

			if var_292_9 < arg_289_1.time_ and arg_289_1.time_ <= var_292_9 + arg_292_0 and not isNil(var_292_8) and arg_289_1.var_.actorSpriteComps10030 == nil then
				arg_289_1.var_.actorSpriteComps10030 = var_292_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_292_10 = 0.2

			if var_292_9 <= arg_289_1.time_ and arg_289_1.time_ < var_292_9 + var_292_10 and not isNil(var_292_8) then
				local var_292_11 = (arg_289_1.time_ - var_292_9) / var_292_10

				if arg_289_1.var_.actorSpriteComps10030 then
					for iter_292_4, iter_292_5 in pairs(arg_289_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_292_5 then
							if arg_289_1.isInRecall_ then
								local var_292_12 = Mathf.Lerp(iter_292_5.color.r, arg_289_1.hightColor1.r, var_292_11)
								local var_292_13 = Mathf.Lerp(iter_292_5.color.g, arg_289_1.hightColor1.g, var_292_11)
								local var_292_14 = Mathf.Lerp(iter_292_5.color.b, arg_289_1.hightColor1.b, var_292_11)

								iter_292_5.color = Color.New(var_292_12, var_292_13, var_292_14)
							else
								local var_292_15 = Mathf.Lerp(iter_292_5.color.r, 1, var_292_11)

								iter_292_5.color = Color.New(var_292_15, var_292_15, var_292_15)
							end
						end
					end
				end
			end

			if arg_289_1.time_ >= var_292_9 + var_292_10 and arg_289_1.time_ < var_292_9 + var_292_10 + arg_292_0 and not isNil(var_292_8) and arg_289_1.var_.actorSpriteComps10030 then
				for iter_292_6, iter_292_7 in pairs(arg_289_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_292_7 then
						if arg_289_1.isInRecall_ then
							iter_292_7.color = arg_289_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_292_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_289_1.var_.actorSpriteComps10030 = nil
			end

			local var_292_16 = 0
			local var_292_17 = 0.75

			if var_292_16 < arg_289_1.time_ and arg_289_1.time_ <= var_292_16 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, true)

				local var_292_18 = arg_289_1:FormatText(StoryNameCfg[309].name)

				arg_289_1.leftNameTxt_.text = var_292_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_289_1.leftNameTxt_.transform)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1.leftNameTxt_.text)
				SetActive(arg_289_1.iconTrs_.gameObject, false)
				arg_289_1.callingController_:SetSelectedState("normal")

				local var_292_19 = arg_289_1:GetWordFromCfg(115281067)
				local var_292_20 = arg_289_1:FormatText(var_292_19.content)

				arg_289_1.text_.text = var_292_20

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_21 = 30
				local var_292_22 = utf8.len(var_292_20)
				local var_292_23 = var_292_21 <= 0 and var_292_17 or var_292_17 * (var_292_22 / var_292_21)

				if var_292_23 > 0 and var_292_17 < var_292_23 then
					arg_289_1.talkMaxDuration = var_292_23

					if var_292_23 + var_292_16 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_23 + var_292_16
					end
				end

				arg_289_1.text_.text = var_292_20
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115281", "115281067", "story_v_out_115281.awb") ~= 0 then
					local var_292_24 = manager.audio:GetVoiceLength("story_v_out_115281", "115281067", "story_v_out_115281.awb") / 1000

					if var_292_24 + var_292_16 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_24 + var_292_16
					end

					if var_292_19.prefab_name ~= "" and arg_289_1.actors_[var_292_19.prefab_name] ~= nil then
						local var_292_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_289_1.actors_[var_292_19.prefab_name].transform, "story_v_out_115281", "115281067", "story_v_out_115281.awb")

						arg_289_1:RecordAudio("115281067", var_292_25)
						arg_289_1:RecordAudio("115281067", var_292_25)
					else
						arg_289_1:AudioAction("play", "voice", "story_v_out_115281", "115281067", "story_v_out_115281.awb")
					end

					arg_289_1:RecordHistoryTalkVoice("story_v_out_115281", "115281067", "story_v_out_115281.awb")
				end

				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_26 = math.max(var_292_17, arg_289_1.talkMaxDuration)

			if var_292_16 <= arg_289_1.time_ and arg_289_1.time_ < var_292_16 + var_292_26 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - var_292_16) / var_292_26

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= var_292_16 + var_292_26 and arg_289_1.time_ < var_292_16 + var_292_26 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {}

		arg_289_1:InitPlayNodeList()
	end,
	Play115281068 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 115281068
		arg_293_1.duration_ = 12.33

		local var_293_0 = {
			ja = 10.666,
			ko = 12.333,
			zh = 8.1,
			en = 11.833
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
				arg_293_0:Play115281069(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			local var_296_0 = 0
			local var_296_1 = 0.825

			if var_296_0 < arg_293_1.time_ and arg_293_1.time_ <= var_296_0 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, true)

				local var_296_2 = arg_293_1:FormatText(StoryNameCfg[309].name)

				arg_293_1.leftNameTxt_.text = var_296_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_293_1.leftNameTxt_.transform)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1.leftNameTxt_.text)
				SetActive(arg_293_1.iconTrs_.gameObject, false)
				arg_293_1.callingController_:SetSelectedState("normal")

				local var_296_3 = arg_293_1:GetWordFromCfg(115281068)
				local var_296_4 = arg_293_1:FormatText(var_296_3.content)

				arg_293_1.text_.text = var_296_4

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_5 = 33
				local var_296_6 = utf8.len(var_296_4)
				local var_296_7 = var_296_5 <= 0 and var_296_1 or var_296_1 * (var_296_6 / var_296_5)

				if var_296_7 > 0 and var_296_1 < var_296_7 then
					arg_293_1.talkMaxDuration = var_296_7

					if var_296_7 + var_296_0 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_7 + var_296_0
					end
				end

				arg_293_1.text_.text = var_296_4
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115281", "115281068", "story_v_out_115281.awb") ~= 0 then
					local var_296_8 = manager.audio:GetVoiceLength("story_v_out_115281", "115281068", "story_v_out_115281.awb") / 1000

					if var_296_8 + var_296_0 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_8 + var_296_0
					end

					if var_296_3.prefab_name ~= "" and arg_293_1.actors_[var_296_3.prefab_name] ~= nil then
						local var_296_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_293_1.actors_[var_296_3.prefab_name].transform, "story_v_out_115281", "115281068", "story_v_out_115281.awb")

						arg_293_1:RecordAudio("115281068", var_296_9)
						arg_293_1:RecordAudio("115281068", var_296_9)
					else
						arg_293_1:AudioAction("play", "voice", "story_v_out_115281", "115281068", "story_v_out_115281.awb")
					end

					arg_293_1:RecordHistoryTalkVoice("story_v_out_115281", "115281068", "story_v_out_115281.awb")
				end

				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_10 = math.max(var_296_1, arg_293_1.talkMaxDuration)

			if var_296_0 <= arg_293_1.time_ and arg_293_1.time_ < var_296_0 + var_296_10 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - var_296_0) / var_296_10

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= var_296_0 + var_296_10 and arg_293_1.time_ < var_296_0 + var_296_10 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {}

		arg_293_1:InitPlayNodeList()
	end,
	Play115281069 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 115281069
		arg_297_1.duration_ = 5

		SetActive(arg_297_1.tipsGo_, false)

		function arg_297_1.onSingleLineFinish_()
			arg_297_1.onSingleLineUpdate_ = nil
			arg_297_1.onSingleLineFinish_ = nil
			arg_297_1.state_ = "waiting"
		end

		function arg_297_1.playNext_(arg_299_0)
			if arg_299_0 == 1 then
				arg_297_0:Play115281070(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			local var_300_0 = arg_297_1.actors_["10030"]
			local var_300_1 = 0

			if var_300_1 < arg_297_1.time_ and arg_297_1.time_ <= var_300_1 + arg_300_0 and not isNil(var_300_0) and arg_297_1.var_.actorSpriteComps10030 == nil then
				arg_297_1.var_.actorSpriteComps10030 = var_300_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_300_2 = 0.2

			if var_300_1 <= arg_297_1.time_ and arg_297_1.time_ < var_300_1 + var_300_2 and not isNil(var_300_0) then
				local var_300_3 = (arg_297_1.time_ - var_300_1) / var_300_2

				if arg_297_1.var_.actorSpriteComps10030 then
					for iter_300_0, iter_300_1 in pairs(arg_297_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_300_1 then
							if arg_297_1.isInRecall_ then
								local var_300_4 = Mathf.Lerp(iter_300_1.color.r, arg_297_1.hightColor2.r, var_300_3)
								local var_300_5 = Mathf.Lerp(iter_300_1.color.g, arg_297_1.hightColor2.g, var_300_3)
								local var_300_6 = Mathf.Lerp(iter_300_1.color.b, arg_297_1.hightColor2.b, var_300_3)

								iter_300_1.color = Color.New(var_300_4, var_300_5, var_300_6)
							else
								local var_300_7 = Mathf.Lerp(iter_300_1.color.r, 0.5, var_300_3)

								iter_300_1.color = Color.New(var_300_7, var_300_7, var_300_7)
							end
						end
					end
				end
			end

			if arg_297_1.time_ >= var_300_1 + var_300_2 and arg_297_1.time_ < var_300_1 + var_300_2 + arg_300_0 and not isNil(var_300_0) and arg_297_1.var_.actorSpriteComps10030 then
				for iter_300_2, iter_300_3 in pairs(arg_297_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_300_3 then
						if arg_297_1.isInRecall_ then
							iter_300_3.color = arg_297_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_300_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_297_1.var_.actorSpriteComps10030 = nil
			end

			local var_300_8 = arg_297_1.actors_["1038"].transform
			local var_300_9 = 0

			if var_300_9 < arg_297_1.time_ and arg_297_1.time_ <= var_300_9 + arg_300_0 then
				arg_297_1.var_.moveOldPos1038 = var_300_8.localPosition
				var_300_8.localScale = Vector3.New(1, 1, 1)

				arg_297_1:CheckSpriteTmpPos("1038", 2)

				local var_300_10 = var_300_8.childCount

				for iter_300_4 = 0, var_300_10 - 1 do
					local var_300_11 = var_300_8:GetChild(iter_300_4)

					if var_300_11.name == "split_1" or not string.find(var_300_11.name, "split") then
						var_300_11.gameObject:SetActive(true)
					else
						var_300_11.gameObject:SetActive(false)
					end
				end
			end

			local var_300_12 = 0.001

			if var_300_9 <= arg_297_1.time_ and arg_297_1.time_ < var_300_9 + var_300_12 then
				local var_300_13 = (arg_297_1.time_ - var_300_9) / var_300_12
				local var_300_14 = Vector3.New(-390, -400, 0)

				var_300_8.localPosition = Vector3.Lerp(arg_297_1.var_.moveOldPos1038, var_300_14, var_300_13)
			end

			if arg_297_1.time_ >= var_300_9 + var_300_12 and arg_297_1.time_ < var_300_9 + var_300_12 + arg_300_0 then
				var_300_8.localPosition = Vector3.New(-390, -400, 0)
			end

			local var_300_15 = arg_297_1.actors_["1038"]
			local var_300_16 = 0

			if var_300_16 < arg_297_1.time_ and arg_297_1.time_ <= var_300_16 + arg_300_0 and not isNil(var_300_15) and arg_297_1.var_.actorSpriteComps1038 == nil then
				arg_297_1.var_.actorSpriteComps1038 = var_300_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_300_17 = 0.2

			if var_300_16 <= arg_297_1.time_ and arg_297_1.time_ < var_300_16 + var_300_17 and not isNil(var_300_15) then
				local var_300_18 = (arg_297_1.time_ - var_300_16) / var_300_17

				if arg_297_1.var_.actorSpriteComps1038 then
					for iter_300_5, iter_300_6 in pairs(arg_297_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_300_6 then
							if arg_297_1.isInRecall_ then
								local var_300_19 = Mathf.Lerp(iter_300_6.color.r, arg_297_1.hightColor2.r, var_300_18)
								local var_300_20 = Mathf.Lerp(iter_300_6.color.g, arg_297_1.hightColor2.g, var_300_18)
								local var_300_21 = Mathf.Lerp(iter_300_6.color.b, arg_297_1.hightColor2.b, var_300_18)

								iter_300_6.color = Color.New(var_300_19, var_300_20, var_300_21)
							else
								local var_300_22 = Mathf.Lerp(iter_300_6.color.r, 0.5, var_300_18)

								iter_300_6.color = Color.New(var_300_22, var_300_22, var_300_22)
							end
						end
					end
				end
			end

			if arg_297_1.time_ >= var_300_16 + var_300_17 and arg_297_1.time_ < var_300_16 + var_300_17 + arg_300_0 and not isNil(var_300_15) and arg_297_1.var_.actorSpriteComps1038 then
				for iter_300_7, iter_300_8 in pairs(arg_297_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_300_8 then
						if arg_297_1.isInRecall_ then
							iter_300_8.color = arg_297_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_300_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_297_1.var_.actorSpriteComps1038 = nil
			end

			local var_300_23 = 0
			local var_300_24 = 0.65

			if var_300_23 < arg_297_1.time_ and arg_297_1.time_ <= var_300_23 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, false)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_297_1.iconTrs_.gameObject, false)
				arg_297_1.callingController_:SetSelectedState("normal")

				local var_300_25 = arg_297_1:GetWordFromCfg(115281069)
				local var_300_26 = arg_297_1:FormatText(var_300_25.content)

				arg_297_1.text_.text = var_300_26

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_27 = 26
				local var_300_28 = utf8.len(var_300_26)
				local var_300_29 = var_300_27 <= 0 and var_300_24 or var_300_24 * (var_300_28 / var_300_27)

				if var_300_29 > 0 and var_300_24 < var_300_29 then
					arg_297_1.talkMaxDuration = var_300_29

					if var_300_29 + var_300_23 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_29 + var_300_23
					end
				end

				arg_297_1.text_.text = var_300_26
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)
				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_30 = math.max(var_300_24, arg_297_1.talkMaxDuration)

			if var_300_23 <= arg_297_1.time_ and arg_297_1.time_ < var_300_23 + var_300_30 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - var_300_23) / var_300_30

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= var_300_23 + var_300_30 and arg_297_1.time_ < var_300_23 + var_300_30 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {
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

		arg_297_1:InitPlayNodeList()
	end,
	Play115281070 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 115281070
		arg_301_1.duration_ = 10.47

		local var_301_0 = {
			ja = 7.933,
			ko = 9.5,
			zh = 10.466,
			en = 8.933
		}
		local var_301_1 = manager.audio:GetLocalizationFlag()

		if var_301_0[var_301_1] ~= nil then
			arg_301_1.duration_ = var_301_0[var_301_1]
		end

		SetActive(arg_301_1.tipsGo_, false)

		function arg_301_1.onSingleLineFinish_()
			arg_301_1.onSingleLineUpdate_ = nil
			arg_301_1.onSingleLineFinish_ = nil
			arg_301_1.state_ = "waiting"
		end

		function arg_301_1.playNext_(arg_303_0)
			if arg_303_0 == 1 then
				arg_301_0:Play115281071(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			local var_304_0 = arg_301_1.actors_["1038"]
			local var_304_1 = 0

			if var_304_1 < arg_301_1.time_ and arg_301_1.time_ <= var_304_1 + arg_304_0 and not isNil(var_304_0) and arg_301_1.var_.actorSpriteComps1038 == nil then
				arg_301_1.var_.actorSpriteComps1038 = var_304_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_304_2 = 0.2

			if var_304_1 <= arg_301_1.time_ and arg_301_1.time_ < var_304_1 + var_304_2 and not isNil(var_304_0) then
				local var_304_3 = (arg_301_1.time_ - var_304_1) / var_304_2

				if arg_301_1.var_.actorSpriteComps1038 then
					for iter_304_0, iter_304_1 in pairs(arg_301_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_304_1 then
							if arg_301_1.isInRecall_ then
								local var_304_4 = Mathf.Lerp(iter_304_1.color.r, arg_301_1.hightColor1.r, var_304_3)
								local var_304_5 = Mathf.Lerp(iter_304_1.color.g, arg_301_1.hightColor1.g, var_304_3)
								local var_304_6 = Mathf.Lerp(iter_304_1.color.b, arg_301_1.hightColor1.b, var_304_3)

								iter_304_1.color = Color.New(var_304_4, var_304_5, var_304_6)
							else
								local var_304_7 = Mathf.Lerp(iter_304_1.color.r, 1, var_304_3)

								iter_304_1.color = Color.New(var_304_7, var_304_7, var_304_7)
							end
						end
					end
				end
			end

			if arg_301_1.time_ >= var_304_1 + var_304_2 and arg_301_1.time_ < var_304_1 + var_304_2 + arg_304_0 and not isNil(var_304_0) and arg_301_1.var_.actorSpriteComps1038 then
				for iter_304_2, iter_304_3 in pairs(arg_301_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_304_3 then
						if arg_301_1.isInRecall_ then
							iter_304_3.color = arg_301_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_304_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_301_1.var_.actorSpriteComps1038 = nil
			end

			local var_304_8 = arg_301_1.actors_["1038"].transform
			local var_304_9 = 0

			if var_304_9 < arg_301_1.time_ and arg_301_1.time_ <= var_304_9 + arg_304_0 then
				arg_301_1.var_.moveOldPos1038 = var_304_8.localPosition
				var_304_8.localScale = Vector3.New(1, 1, 1)

				arg_301_1:CheckSpriteTmpPos("1038", 2)

				local var_304_10 = var_304_8.childCount

				for iter_304_4 = 0, var_304_10 - 1 do
					local var_304_11 = var_304_8:GetChild(iter_304_4)

					if var_304_11.name == "split_5" or not string.find(var_304_11.name, "split") then
						var_304_11.gameObject:SetActive(true)
					else
						var_304_11.gameObject:SetActive(false)
					end
				end
			end

			local var_304_12 = 0.001

			if var_304_9 <= arg_301_1.time_ and arg_301_1.time_ < var_304_9 + var_304_12 then
				local var_304_13 = (arg_301_1.time_ - var_304_9) / var_304_12
				local var_304_14 = Vector3.New(-390, -400, 0)

				var_304_8.localPosition = Vector3.Lerp(arg_301_1.var_.moveOldPos1038, var_304_14, var_304_13)
			end

			if arg_301_1.time_ >= var_304_9 + var_304_12 and arg_301_1.time_ < var_304_9 + var_304_12 + arg_304_0 then
				var_304_8.localPosition = Vector3.New(-390, -400, 0)
			end

			local var_304_15 = 0
			local var_304_16 = 0.9

			if var_304_15 < arg_301_1.time_ and arg_301_1.time_ <= var_304_15 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, true)

				local var_304_17 = arg_301_1:FormatText(StoryNameCfg[94].name)

				arg_301_1.leftNameTxt_.text = var_304_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_301_1.leftNameTxt_.transform)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1.leftNameTxt_.text)
				SetActive(arg_301_1.iconTrs_.gameObject, false)
				arg_301_1.callingController_:SetSelectedState("normal")

				local var_304_18 = arg_301_1:GetWordFromCfg(115281070)
				local var_304_19 = arg_301_1:FormatText(var_304_18.content)

				arg_301_1.text_.text = var_304_19

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_20 = 36
				local var_304_21 = utf8.len(var_304_19)
				local var_304_22 = var_304_20 <= 0 and var_304_16 or var_304_16 * (var_304_21 / var_304_20)

				if var_304_22 > 0 and var_304_16 < var_304_22 then
					arg_301_1.talkMaxDuration = var_304_22

					if var_304_22 + var_304_15 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_22 + var_304_15
					end
				end

				arg_301_1.text_.text = var_304_19
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115281", "115281070", "story_v_out_115281.awb") ~= 0 then
					local var_304_23 = manager.audio:GetVoiceLength("story_v_out_115281", "115281070", "story_v_out_115281.awb") / 1000

					if var_304_23 + var_304_15 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_23 + var_304_15
					end

					if var_304_18.prefab_name ~= "" and arg_301_1.actors_[var_304_18.prefab_name] ~= nil then
						local var_304_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_301_1.actors_[var_304_18.prefab_name].transform, "story_v_out_115281", "115281070", "story_v_out_115281.awb")

						arg_301_1:RecordAudio("115281070", var_304_24)
						arg_301_1:RecordAudio("115281070", var_304_24)
					else
						arg_301_1:AudioAction("play", "voice", "story_v_out_115281", "115281070", "story_v_out_115281.awb")
					end

					arg_301_1:RecordHistoryTalkVoice("story_v_out_115281", "115281070", "story_v_out_115281.awb")
				end

				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_25 = math.max(var_304_16, arg_301_1.talkMaxDuration)

			if var_304_15 <= arg_301_1.time_ and arg_301_1.time_ < var_304_15 + var_304_25 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - var_304_15) / var_304_25

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= var_304_15 + var_304_25 and arg_301_1.time_ < var_304_15 + var_304_25 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {
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

		arg_301_1:InitPlayNodeList()
	end,
	Play115281071 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 115281071
		arg_305_1.duration_ = 12.7

		local var_305_0 = {
			ja = 12.7,
			ko = 8.366,
			zh = 8.166,
			en = 10.966
		}
		local var_305_1 = manager.audio:GetLocalizationFlag()

		if var_305_0[var_305_1] ~= nil then
			arg_305_1.duration_ = var_305_0[var_305_1]
		end

		SetActive(arg_305_1.tipsGo_, false)

		function arg_305_1.onSingleLineFinish_()
			arg_305_1.onSingleLineUpdate_ = nil
			arg_305_1.onSingleLineFinish_ = nil
			arg_305_1.state_ = "waiting"
		end

		function arg_305_1.playNext_(arg_307_0)
			if arg_307_0 == 1 then
				arg_305_0:Play115281072(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			local var_308_0 = arg_305_1.actors_["1038"].transform
			local var_308_1 = 0

			if var_308_1 < arg_305_1.time_ and arg_305_1.time_ <= var_308_1 + arg_308_0 then
				arg_305_1.var_.moveOldPos1038 = var_308_0.localPosition
				var_308_0.localScale = Vector3.New(1, 1, 1)

				arg_305_1:CheckSpriteTmpPos("1038", 2)

				local var_308_2 = var_308_0.childCount

				for iter_308_0 = 0, var_308_2 - 1 do
					local var_308_3 = var_308_0:GetChild(iter_308_0)

					if var_308_3.name == "split_7" or not string.find(var_308_3.name, "split") then
						var_308_3.gameObject:SetActive(true)
					else
						var_308_3.gameObject:SetActive(false)
					end
				end
			end

			local var_308_4 = 0.001

			if var_308_1 <= arg_305_1.time_ and arg_305_1.time_ < var_308_1 + var_308_4 then
				local var_308_5 = (arg_305_1.time_ - var_308_1) / var_308_4
				local var_308_6 = Vector3.New(-390, -400, 0)

				var_308_0.localPosition = Vector3.Lerp(arg_305_1.var_.moveOldPos1038, var_308_6, var_308_5)
			end

			if arg_305_1.time_ >= var_308_1 + var_308_4 and arg_305_1.time_ < var_308_1 + var_308_4 + arg_308_0 then
				var_308_0.localPosition = Vector3.New(-390, -400, 0)
			end

			local var_308_7 = 0
			local var_308_8 = 0.8

			if var_308_7 < arg_305_1.time_ and arg_305_1.time_ <= var_308_7 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0
				arg_305_1.dialogCg_.alpha = 1

				arg_305_1.dialog_:SetActive(true)
				SetActive(arg_305_1.leftNameGo_, true)

				local var_308_9 = arg_305_1:FormatText(StoryNameCfg[94].name)

				arg_305_1.leftNameTxt_.text = var_308_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_305_1.leftNameTxt_.transform)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1.leftNameTxt_.text)
				SetActive(arg_305_1.iconTrs_.gameObject, false)
				arg_305_1.callingController_:SetSelectedState("normal")

				local var_308_10 = arg_305_1:GetWordFromCfg(115281071)
				local var_308_11 = arg_305_1:FormatText(var_308_10.content)

				arg_305_1.text_.text = var_308_11

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_12 = 32
				local var_308_13 = utf8.len(var_308_11)
				local var_308_14 = var_308_12 <= 0 and var_308_8 or var_308_8 * (var_308_13 / var_308_12)

				if var_308_14 > 0 and var_308_8 < var_308_14 then
					arg_305_1.talkMaxDuration = var_308_14

					if var_308_14 + var_308_7 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_14 + var_308_7
					end
				end

				arg_305_1.text_.text = var_308_11
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115281", "115281071", "story_v_out_115281.awb") ~= 0 then
					local var_308_15 = manager.audio:GetVoiceLength("story_v_out_115281", "115281071", "story_v_out_115281.awb") / 1000

					if var_308_15 + var_308_7 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_15 + var_308_7
					end

					if var_308_10.prefab_name ~= "" and arg_305_1.actors_[var_308_10.prefab_name] ~= nil then
						local var_308_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_305_1.actors_[var_308_10.prefab_name].transform, "story_v_out_115281", "115281071", "story_v_out_115281.awb")

						arg_305_1:RecordAudio("115281071", var_308_16)
						arg_305_1:RecordAudio("115281071", var_308_16)
					else
						arg_305_1:AudioAction("play", "voice", "story_v_out_115281", "115281071", "story_v_out_115281.awb")
					end

					arg_305_1:RecordHistoryTalkVoice("story_v_out_115281", "115281071", "story_v_out_115281.awb")
				end

				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_17 = math.max(var_308_8, arg_305_1.talkMaxDuration)

			if var_308_7 <= arg_305_1.time_ and arg_305_1.time_ < var_308_7 + var_308_17 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - var_308_7) / var_308_17

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= var_308_7 + var_308_17 and arg_305_1.time_ < var_308_7 + var_308_17 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {
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

		arg_305_1:InitPlayNodeList()
	end,
	Play115281072 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 115281072
		arg_309_1.duration_ = 3.4

		local var_309_0 = {
			ja = 2.2,
			ko = 2.766,
			zh = 3.4,
			en = 3.1
		}
		local var_309_1 = manager.audio:GetLocalizationFlag()

		if var_309_0[var_309_1] ~= nil then
			arg_309_1.duration_ = var_309_0[var_309_1]
		end

		SetActive(arg_309_1.tipsGo_, false)

		function arg_309_1.onSingleLineFinish_()
			arg_309_1.onSingleLineUpdate_ = nil
			arg_309_1.onSingleLineFinish_ = nil
			arg_309_1.state_ = "waiting"
		end

		function arg_309_1.playNext_(arg_311_0)
			if arg_311_0 == 1 then
				arg_309_0:Play115281073(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			local var_312_0 = arg_309_1.actors_["10030"].transform
			local var_312_1 = 0

			if var_312_1 < arg_309_1.time_ and arg_309_1.time_ <= var_312_1 + arg_312_0 then
				arg_309_1.var_.moveOldPos10030 = var_312_0.localPosition
				var_312_0.localScale = Vector3.New(1, 1, 1)

				arg_309_1:CheckSpriteTmpPos("10030", 4)

				local var_312_2 = var_312_0.childCount

				for iter_312_0 = 0, var_312_2 - 1 do
					local var_312_3 = var_312_0:GetChild(iter_312_0)

					if var_312_3.name == "split_1" or not string.find(var_312_3.name, "split") then
						var_312_3.gameObject:SetActive(true)
					else
						var_312_3.gameObject:SetActive(false)
					end
				end
			end

			local var_312_4 = 0.001

			if var_312_1 <= arg_309_1.time_ and arg_309_1.time_ < var_312_1 + var_312_4 then
				local var_312_5 = (arg_309_1.time_ - var_312_1) / var_312_4
				local var_312_6 = Vector3.New(390, -390, 150)

				var_312_0.localPosition = Vector3.Lerp(arg_309_1.var_.moveOldPos10030, var_312_6, var_312_5)
			end

			if arg_309_1.time_ >= var_312_1 + var_312_4 and arg_309_1.time_ < var_312_1 + var_312_4 + arg_312_0 then
				var_312_0.localPosition = Vector3.New(390, -390, 150)
			end

			local var_312_7 = arg_309_1.actors_["1038"]
			local var_312_8 = 0

			if var_312_8 < arg_309_1.time_ and arg_309_1.time_ <= var_312_8 + arg_312_0 and not isNil(var_312_7) and arg_309_1.var_.actorSpriteComps1038 == nil then
				arg_309_1.var_.actorSpriteComps1038 = var_312_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_312_9 = 0.2

			if var_312_8 <= arg_309_1.time_ and arg_309_1.time_ < var_312_8 + var_312_9 and not isNil(var_312_7) then
				local var_312_10 = (arg_309_1.time_ - var_312_8) / var_312_9

				if arg_309_1.var_.actorSpriteComps1038 then
					for iter_312_1, iter_312_2 in pairs(arg_309_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_312_2 then
							if arg_309_1.isInRecall_ then
								local var_312_11 = Mathf.Lerp(iter_312_2.color.r, arg_309_1.hightColor2.r, var_312_10)
								local var_312_12 = Mathf.Lerp(iter_312_2.color.g, arg_309_1.hightColor2.g, var_312_10)
								local var_312_13 = Mathf.Lerp(iter_312_2.color.b, arg_309_1.hightColor2.b, var_312_10)

								iter_312_2.color = Color.New(var_312_11, var_312_12, var_312_13)
							else
								local var_312_14 = Mathf.Lerp(iter_312_2.color.r, 0.5, var_312_10)

								iter_312_2.color = Color.New(var_312_14, var_312_14, var_312_14)
							end
						end
					end
				end
			end

			if arg_309_1.time_ >= var_312_8 + var_312_9 and arg_309_1.time_ < var_312_8 + var_312_9 + arg_312_0 and not isNil(var_312_7) and arg_309_1.var_.actorSpriteComps1038 then
				for iter_312_3, iter_312_4 in pairs(arg_309_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_312_4 then
						if arg_309_1.isInRecall_ then
							iter_312_4.color = arg_309_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_312_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_309_1.var_.actorSpriteComps1038 = nil
			end

			local var_312_15 = arg_309_1.actors_["10030"]
			local var_312_16 = 0

			if var_312_16 < arg_309_1.time_ and arg_309_1.time_ <= var_312_16 + arg_312_0 and not isNil(var_312_15) and arg_309_1.var_.actorSpriteComps10030 == nil then
				arg_309_1.var_.actorSpriteComps10030 = var_312_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_312_17 = 0.2

			if var_312_16 <= arg_309_1.time_ and arg_309_1.time_ < var_312_16 + var_312_17 and not isNil(var_312_15) then
				local var_312_18 = (arg_309_1.time_ - var_312_16) / var_312_17

				if arg_309_1.var_.actorSpriteComps10030 then
					for iter_312_5, iter_312_6 in pairs(arg_309_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_312_6 then
							if arg_309_1.isInRecall_ then
								local var_312_19 = Mathf.Lerp(iter_312_6.color.r, arg_309_1.hightColor1.r, var_312_18)
								local var_312_20 = Mathf.Lerp(iter_312_6.color.g, arg_309_1.hightColor1.g, var_312_18)
								local var_312_21 = Mathf.Lerp(iter_312_6.color.b, arg_309_1.hightColor1.b, var_312_18)

								iter_312_6.color = Color.New(var_312_19, var_312_20, var_312_21)
							else
								local var_312_22 = Mathf.Lerp(iter_312_6.color.r, 1, var_312_18)

								iter_312_6.color = Color.New(var_312_22, var_312_22, var_312_22)
							end
						end
					end
				end
			end

			if arg_309_1.time_ >= var_312_16 + var_312_17 and arg_309_1.time_ < var_312_16 + var_312_17 + arg_312_0 and not isNil(var_312_15) and arg_309_1.var_.actorSpriteComps10030 then
				for iter_312_7, iter_312_8 in pairs(arg_309_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_312_8 then
						if arg_309_1.isInRecall_ then
							iter_312_8.color = arg_309_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_312_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_309_1.var_.actorSpriteComps10030 = nil
			end

			local var_312_23 = 0
			local var_312_24 = 0.2

			if var_312_23 < arg_309_1.time_ and arg_309_1.time_ <= var_312_23 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0
				arg_309_1.dialogCg_.alpha = 1

				arg_309_1.dialog_:SetActive(true)
				SetActive(arg_309_1.leftNameGo_, true)

				local var_312_25 = arg_309_1:FormatText(StoryNameCfg[309].name)

				arg_309_1.leftNameTxt_.text = var_312_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_309_1.leftNameTxt_.transform)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1.leftNameTxt_.text)
				SetActive(arg_309_1.iconTrs_.gameObject, false)
				arg_309_1.callingController_:SetSelectedState("normal")

				local var_312_26 = arg_309_1:GetWordFromCfg(115281072)
				local var_312_27 = arg_309_1:FormatText(var_312_26.content)

				arg_309_1.text_.text = var_312_27

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_28 = 8
				local var_312_29 = utf8.len(var_312_27)
				local var_312_30 = var_312_28 <= 0 and var_312_24 or var_312_24 * (var_312_29 / var_312_28)

				if var_312_30 > 0 and var_312_24 < var_312_30 then
					arg_309_1.talkMaxDuration = var_312_30

					if var_312_30 + var_312_23 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_30 + var_312_23
					end
				end

				arg_309_1.text_.text = var_312_27
				arg_309_1.typewritter.percent = 0

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115281", "115281072", "story_v_out_115281.awb") ~= 0 then
					local var_312_31 = manager.audio:GetVoiceLength("story_v_out_115281", "115281072", "story_v_out_115281.awb") / 1000

					if var_312_31 + var_312_23 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_31 + var_312_23
					end

					if var_312_26.prefab_name ~= "" and arg_309_1.actors_[var_312_26.prefab_name] ~= nil then
						local var_312_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_309_1.actors_[var_312_26.prefab_name].transform, "story_v_out_115281", "115281072", "story_v_out_115281.awb")

						arg_309_1:RecordAudio("115281072", var_312_32)
						arg_309_1:RecordAudio("115281072", var_312_32)
					else
						arg_309_1:AudioAction("play", "voice", "story_v_out_115281", "115281072", "story_v_out_115281.awb")
					end

					arg_309_1:RecordHistoryTalkVoice("story_v_out_115281", "115281072", "story_v_out_115281.awb")
				end

				arg_309_1:RecordContent(arg_309_1.text_.text)
			end

			local var_312_33 = math.max(var_312_24, arg_309_1.talkMaxDuration)

			if var_312_23 <= arg_309_1.time_ and arg_309_1.time_ < var_312_23 + var_312_33 then
				arg_309_1.typewritter.percent = (arg_309_1.time_ - var_312_23) / var_312_33

				arg_309_1.typewritter:SetDirty()
			end

			if arg_309_1.time_ >= var_312_23 + var_312_33 and arg_309_1.time_ < var_312_23 + var_312_33 + arg_312_0 then
				arg_309_1.typewritter.percent = 1

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(true)
			end
		end

		arg_309_1.nodeConfigList_ = {
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

		arg_309_1:InitPlayNodeList()
	end,
	Play115281073 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 115281073
		arg_313_1.duration_ = 5

		SetActive(arg_313_1.tipsGo_, false)

		function arg_313_1.onSingleLineFinish_()
			arg_313_1.onSingleLineUpdate_ = nil
			arg_313_1.onSingleLineFinish_ = nil
			arg_313_1.state_ = "waiting"
		end

		function arg_313_1.playNext_(arg_315_0)
			if arg_315_0 == 1 then
				arg_313_0:Play115281074(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			local var_316_0 = arg_313_1.actors_["10030"]
			local var_316_1 = 0

			if var_316_1 < arg_313_1.time_ and arg_313_1.time_ <= var_316_1 + arg_316_0 then
				local var_316_2 = var_316_0:GetComponentInChildren(typeof(CanvasGroup))

				if var_316_2 then
					arg_313_1.var_.alphaOldValue10030 = var_316_2.alpha
					arg_313_1.var_.characterEffect10030 = var_316_2
				end

				arg_313_1.var_.alphaOldValue10030 = 1
			end

			local var_316_3 = 0.333333333333333

			if var_316_1 <= arg_313_1.time_ and arg_313_1.time_ < var_316_1 + var_316_3 then
				local var_316_4 = (arg_313_1.time_ - var_316_1) / var_316_3
				local var_316_5 = Mathf.Lerp(arg_313_1.var_.alphaOldValue10030, 0, var_316_4)

				if arg_313_1.var_.characterEffect10030 then
					arg_313_1.var_.characterEffect10030.alpha = var_316_5
				end
			end

			if arg_313_1.time_ >= var_316_1 + var_316_3 and arg_313_1.time_ < var_316_1 + var_316_3 + arg_316_0 and arg_313_1.var_.characterEffect10030 then
				arg_313_1.var_.characterEffect10030.alpha = 0
			end

			local var_316_6 = arg_313_1.actors_["1038"]
			local var_316_7 = 0

			if var_316_7 < arg_313_1.time_ and arg_313_1.time_ <= var_316_7 + arg_316_0 then
				local var_316_8 = var_316_6:GetComponentInChildren(typeof(CanvasGroup))

				if var_316_8 then
					arg_313_1.var_.alphaOldValue1038 = var_316_8.alpha
					arg_313_1.var_.characterEffect1038 = var_316_8
				end

				arg_313_1.var_.alphaOldValue1038 = 1
			end

			local var_316_9 = 0.333333333333333

			if var_316_7 <= arg_313_1.time_ and arg_313_1.time_ < var_316_7 + var_316_9 then
				local var_316_10 = (arg_313_1.time_ - var_316_7) / var_316_9
				local var_316_11 = Mathf.Lerp(arg_313_1.var_.alphaOldValue1038, 0, var_316_10)

				if arg_313_1.var_.characterEffect1038 then
					arg_313_1.var_.characterEffect1038.alpha = var_316_11
				end
			end

			if arg_313_1.time_ >= var_316_7 + var_316_9 and arg_313_1.time_ < var_316_7 + var_316_9 + arg_316_0 and arg_313_1.var_.characterEffect1038 then
				arg_313_1.var_.characterEffect1038.alpha = 0
			end

			local var_316_12 = 0
			local var_316_13 = 1.2

			if var_316_12 < arg_313_1.time_ and arg_313_1.time_ <= var_316_12 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, false)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_313_1.iconTrs_.gameObject, false)
				arg_313_1.callingController_:SetSelectedState("normal")

				local var_316_14 = arg_313_1:GetWordFromCfg(115281073)
				local var_316_15 = arg_313_1:FormatText(var_316_14.content)

				arg_313_1.text_.text = var_316_15

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_16 = 48
				local var_316_17 = utf8.len(var_316_15)
				local var_316_18 = var_316_16 <= 0 and var_316_13 or var_316_13 * (var_316_17 / var_316_16)

				if var_316_18 > 0 and var_316_13 < var_316_18 then
					arg_313_1.talkMaxDuration = var_316_18

					if var_316_18 + var_316_12 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_18 + var_316_12
					end
				end

				arg_313_1.text_.text = var_316_15
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)
				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_19 = math.max(var_316_13, arg_313_1.talkMaxDuration)

			if var_316_12 <= arg_313_1.time_ and arg_313_1.time_ < var_316_12 + var_316_19 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - var_316_12) / var_316_19

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= var_316_12 + var_316_19 and arg_313_1.time_ < var_316_12 + var_316_19 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {}

		arg_313_1:InitPlayNodeList()
	end,
	Play115281074 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 115281074
		arg_317_1.duration_ = 5

		SetActive(arg_317_1.tipsGo_, false)

		function arg_317_1.onSingleLineFinish_()
			arg_317_1.onSingleLineUpdate_ = nil
			arg_317_1.onSingleLineFinish_ = nil
			arg_317_1.state_ = "waiting"
		end

		function arg_317_1.playNext_(arg_319_0)
			if arg_319_0 == 1 then
				arg_317_0:Play115281075(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			local var_320_0 = 0
			local var_320_1 = 0.65

			if var_320_0 < arg_317_1.time_ and arg_317_1.time_ <= var_320_0 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0
				arg_317_1.dialogCg_.alpha = 1

				arg_317_1.dialog_:SetActive(true)
				SetActive(arg_317_1.leftNameGo_, false)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_317_1.iconTrs_.gameObject, false)
				arg_317_1.callingController_:SetSelectedState("normal")

				local var_320_2 = arg_317_1:GetWordFromCfg(115281074)
				local var_320_3 = arg_317_1:FormatText(var_320_2.content)

				arg_317_1.text_.text = var_320_3

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_4 = 26
				local var_320_5 = utf8.len(var_320_3)
				local var_320_6 = var_320_4 <= 0 and var_320_1 or var_320_1 * (var_320_5 / var_320_4)

				if var_320_6 > 0 and var_320_1 < var_320_6 then
					arg_317_1.talkMaxDuration = var_320_6

					if var_320_6 + var_320_0 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_6 + var_320_0
					end
				end

				arg_317_1.text_.text = var_320_3
				arg_317_1.typewritter.percent = 0

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(false)
				arg_317_1:RecordContent(arg_317_1.text_.text)
			end

			local var_320_7 = math.max(var_320_1, arg_317_1.talkMaxDuration)

			if var_320_0 <= arg_317_1.time_ and arg_317_1.time_ < var_320_0 + var_320_7 then
				arg_317_1.typewritter.percent = (arg_317_1.time_ - var_320_0) / var_320_7

				arg_317_1.typewritter:SetDirty()
			end

			if arg_317_1.time_ >= var_320_0 + var_320_7 and arg_317_1.time_ < var_320_0 + var_320_7 + arg_320_0 then
				arg_317_1.typewritter.percent = 1

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(true)
			end
		end

		arg_317_1.nodeConfigList_ = {}

		arg_317_1:InitPlayNodeList()
	end,
	Play115281075 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 115281075
		arg_321_1.duration_ = 2.1

		local var_321_0 = {
			ja = 2.1,
			ko = 1.4,
			zh = 1.366,
			en = 1.3
		}
		local var_321_1 = manager.audio:GetLocalizationFlag()

		if var_321_0[var_321_1] ~= nil then
			arg_321_1.duration_ = var_321_0[var_321_1]
		end

		SetActive(arg_321_1.tipsGo_, false)

		function arg_321_1.onSingleLineFinish_()
			arg_321_1.onSingleLineUpdate_ = nil
			arg_321_1.onSingleLineFinish_ = nil
			arg_321_1.state_ = "waiting"
		end

		function arg_321_1.playNext_(arg_323_0)
			if arg_323_0 == 1 then
				arg_321_0:Play115281076(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			local var_324_0 = arg_321_1.actors_["10030"].transform
			local var_324_1 = 0

			if var_324_1 < arg_321_1.time_ and arg_321_1.time_ <= var_324_1 + arg_324_0 then
				arg_321_1.var_.moveOldPos10030 = var_324_0.localPosition
				var_324_0.localScale = Vector3.New(1, 1, 1)

				arg_321_1:CheckSpriteTmpPos("10030", 4)

				local var_324_2 = var_324_0.childCount

				for iter_324_0 = 0, var_324_2 - 1 do
					local var_324_3 = var_324_0:GetChild(iter_324_0)

					if var_324_3.name == "split_2" or not string.find(var_324_3.name, "split") then
						var_324_3.gameObject:SetActive(true)
					else
						var_324_3.gameObject:SetActive(false)
					end
				end
			end

			local var_324_4 = 0.001

			if var_324_1 <= arg_321_1.time_ and arg_321_1.time_ < var_324_1 + var_324_4 then
				local var_324_5 = (arg_321_1.time_ - var_324_1) / var_324_4
				local var_324_6 = Vector3.New(390, -390, 150)

				var_324_0.localPosition = Vector3.Lerp(arg_321_1.var_.moveOldPos10030, var_324_6, var_324_5)
			end

			if arg_321_1.time_ >= var_324_1 + var_324_4 and arg_321_1.time_ < var_324_1 + var_324_4 + arg_324_0 then
				var_324_0.localPosition = Vector3.New(390, -390, 150)
			end

			local var_324_7 = arg_321_1.actors_["10030"]
			local var_324_8 = 0

			if var_324_8 < arg_321_1.time_ and arg_321_1.time_ <= var_324_8 + arg_324_0 then
				local var_324_9 = var_324_7:GetComponentInChildren(typeof(CanvasGroup))

				if var_324_9 then
					arg_321_1.var_.alphaOldValue10030 = var_324_9.alpha
					arg_321_1.var_.characterEffect10030 = var_324_9
				end

				arg_321_1.var_.alphaOldValue10030 = 0
			end

			local var_324_10 = 0.333333333333333

			if var_324_8 <= arg_321_1.time_ and arg_321_1.time_ < var_324_8 + var_324_10 then
				local var_324_11 = (arg_321_1.time_ - var_324_8) / var_324_10
				local var_324_12 = Mathf.Lerp(arg_321_1.var_.alphaOldValue10030, 1, var_324_11)

				if arg_321_1.var_.characterEffect10030 then
					arg_321_1.var_.characterEffect10030.alpha = var_324_12
				end
			end

			if arg_321_1.time_ >= var_324_8 + var_324_10 and arg_321_1.time_ < var_324_8 + var_324_10 + arg_324_0 and arg_321_1.var_.characterEffect10030 then
				arg_321_1.var_.characterEffect10030.alpha = 1
			end

			local var_324_13 = arg_321_1.actors_["10030"]
			local var_324_14 = 0

			if var_324_14 < arg_321_1.time_ and arg_321_1.time_ <= var_324_14 + arg_324_0 and not isNil(var_324_13) and arg_321_1.var_.actorSpriteComps10030 == nil then
				arg_321_1.var_.actorSpriteComps10030 = var_324_13:GetComponentsInChildren(typeof(Image), true)
			end

			local var_324_15 = 0.2

			if var_324_14 <= arg_321_1.time_ and arg_321_1.time_ < var_324_14 + var_324_15 and not isNil(var_324_13) then
				local var_324_16 = (arg_321_1.time_ - var_324_14) / var_324_15

				if arg_321_1.var_.actorSpriteComps10030 then
					for iter_324_1, iter_324_2 in pairs(arg_321_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_324_2 then
							if arg_321_1.isInRecall_ then
								local var_324_17 = Mathf.Lerp(iter_324_2.color.r, arg_321_1.hightColor1.r, var_324_16)
								local var_324_18 = Mathf.Lerp(iter_324_2.color.g, arg_321_1.hightColor1.g, var_324_16)
								local var_324_19 = Mathf.Lerp(iter_324_2.color.b, arg_321_1.hightColor1.b, var_324_16)

								iter_324_2.color = Color.New(var_324_17, var_324_18, var_324_19)
							else
								local var_324_20 = Mathf.Lerp(iter_324_2.color.r, 1, var_324_16)

								iter_324_2.color = Color.New(var_324_20, var_324_20, var_324_20)
							end
						end
					end
				end
			end

			if arg_321_1.time_ >= var_324_14 + var_324_15 and arg_321_1.time_ < var_324_14 + var_324_15 + arg_324_0 and not isNil(var_324_13) and arg_321_1.var_.actorSpriteComps10030 then
				for iter_324_3, iter_324_4 in pairs(arg_321_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_324_4 then
						if arg_321_1.isInRecall_ then
							iter_324_4.color = arg_321_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_324_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_321_1.var_.actorSpriteComps10030 = nil
			end

			local var_324_21 = 0
			local var_324_22 = 0.075

			if var_324_21 < arg_321_1.time_ and arg_321_1.time_ <= var_324_21 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0
				arg_321_1.dialogCg_.alpha = 1

				arg_321_1.dialog_:SetActive(true)
				SetActive(arg_321_1.leftNameGo_, true)

				local var_324_23 = arg_321_1:FormatText(StoryNameCfg[309].name)

				arg_321_1.leftNameTxt_.text = var_324_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_321_1.leftNameTxt_.transform)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1.leftNameTxt_.text)
				SetActive(arg_321_1.iconTrs_.gameObject, false)
				arg_321_1.callingController_:SetSelectedState("normal")

				local var_324_24 = arg_321_1:GetWordFromCfg(115281075)
				local var_324_25 = arg_321_1:FormatText(var_324_24.content)

				arg_321_1.text_.text = var_324_25

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_26 = 3
				local var_324_27 = utf8.len(var_324_25)
				local var_324_28 = var_324_26 <= 0 and var_324_22 or var_324_22 * (var_324_27 / var_324_26)

				if var_324_28 > 0 and var_324_22 < var_324_28 then
					arg_321_1.talkMaxDuration = var_324_28

					if var_324_28 + var_324_21 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_28 + var_324_21
					end
				end

				arg_321_1.text_.text = var_324_25
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115281", "115281075", "story_v_out_115281.awb") ~= 0 then
					local var_324_29 = manager.audio:GetVoiceLength("story_v_out_115281", "115281075", "story_v_out_115281.awb") / 1000

					if var_324_29 + var_324_21 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_29 + var_324_21
					end

					if var_324_24.prefab_name ~= "" and arg_321_1.actors_[var_324_24.prefab_name] ~= nil then
						local var_324_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_321_1.actors_[var_324_24.prefab_name].transform, "story_v_out_115281", "115281075", "story_v_out_115281.awb")

						arg_321_1:RecordAudio("115281075", var_324_30)
						arg_321_1:RecordAudio("115281075", var_324_30)
					else
						arg_321_1:AudioAction("play", "voice", "story_v_out_115281", "115281075", "story_v_out_115281.awb")
					end

					arg_321_1:RecordHistoryTalkVoice("story_v_out_115281", "115281075", "story_v_out_115281.awb")
				end

				arg_321_1:RecordContent(arg_321_1.text_.text)
			end

			local var_324_31 = math.max(var_324_22, arg_321_1.talkMaxDuration)

			if var_324_21 <= arg_321_1.time_ and arg_321_1.time_ < var_324_21 + var_324_31 then
				arg_321_1.typewritter.percent = (arg_321_1.time_ - var_324_21) / var_324_31

				arg_321_1.typewritter:SetDirty()
			end

			if arg_321_1.time_ >= var_324_21 + var_324_31 and arg_321_1.time_ < var_324_21 + var_324_31 + arg_324_0 then
				arg_321_1.typewritter.percent = 1

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(true)
			end
		end

		arg_321_1.nodeConfigList_ = {
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

		arg_321_1:InitPlayNodeList()
	end,
	Play115281076 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 115281076
		arg_325_1.duration_ = 2.13

		local var_325_0 = {
			ja = 1,
			ko = 0.999999999999,
			zh = 2.133,
			en = 1.4
		}
		local var_325_1 = manager.audio:GetLocalizationFlag()

		if var_325_0[var_325_1] ~= nil then
			arg_325_1.duration_ = var_325_0[var_325_1]
		end

		SetActive(arg_325_1.tipsGo_, false)

		function arg_325_1.onSingleLineFinish_()
			arg_325_1.onSingleLineUpdate_ = nil
			arg_325_1.onSingleLineFinish_ = nil
			arg_325_1.state_ = "waiting"
		end

		function arg_325_1.playNext_(arg_327_0)
			if arg_327_0 == 1 then
				arg_325_0:Play115281077(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			local var_328_0 = arg_325_1.actors_["1038"].transform
			local var_328_1 = 0

			if var_328_1 < arg_325_1.time_ and arg_325_1.time_ <= var_328_1 + arg_328_0 then
				arg_325_1.var_.moveOldPos1038 = var_328_0.localPosition
				var_328_0.localScale = Vector3.New(1, 1, 1)

				arg_325_1:CheckSpriteTmpPos("1038", 2)

				local var_328_2 = var_328_0.childCount

				for iter_328_0 = 0, var_328_2 - 1 do
					local var_328_3 = var_328_0:GetChild(iter_328_0)

					if var_328_3.name == "split_5" or not string.find(var_328_3.name, "split") then
						var_328_3.gameObject:SetActive(true)
					else
						var_328_3.gameObject:SetActive(false)
					end
				end
			end

			local var_328_4 = 0.001

			if var_328_1 <= arg_325_1.time_ and arg_325_1.time_ < var_328_1 + var_328_4 then
				local var_328_5 = (arg_325_1.time_ - var_328_1) / var_328_4
				local var_328_6 = Vector3.New(-390, -400, 0)

				var_328_0.localPosition = Vector3.Lerp(arg_325_1.var_.moveOldPos1038, var_328_6, var_328_5)
			end

			if arg_325_1.time_ >= var_328_1 + var_328_4 and arg_325_1.time_ < var_328_1 + var_328_4 + arg_328_0 then
				var_328_0.localPosition = Vector3.New(-390, -400, 0)
			end

			local var_328_7 = arg_325_1.actors_["10030"]
			local var_328_8 = 0

			if var_328_8 < arg_325_1.time_ and arg_325_1.time_ <= var_328_8 + arg_328_0 and not isNil(var_328_7) and arg_325_1.var_.actorSpriteComps10030 == nil then
				arg_325_1.var_.actorSpriteComps10030 = var_328_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_328_9 = 0.2

			if var_328_8 <= arg_325_1.time_ and arg_325_1.time_ < var_328_8 + var_328_9 and not isNil(var_328_7) then
				local var_328_10 = (arg_325_1.time_ - var_328_8) / var_328_9

				if arg_325_1.var_.actorSpriteComps10030 then
					for iter_328_1, iter_328_2 in pairs(arg_325_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_328_2 then
							if arg_325_1.isInRecall_ then
								local var_328_11 = Mathf.Lerp(iter_328_2.color.r, arg_325_1.hightColor2.r, var_328_10)
								local var_328_12 = Mathf.Lerp(iter_328_2.color.g, arg_325_1.hightColor2.g, var_328_10)
								local var_328_13 = Mathf.Lerp(iter_328_2.color.b, arg_325_1.hightColor2.b, var_328_10)

								iter_328_2.color = Color.New(var_328_11, var_328_12, var_328_13)
							else
								local var_328_14 = Mathf.Lerp(iter_328_2.color.r, 0.5, var_328_10)

								iter_328_2.color = Color.New(var_328_14, var_328_14, var_328_14)
							end
						end
					end
				end
			end

			if arg_325_1.time_ >= var_328_8 + var_328_9 and arg_325_1.time_ < var_328_8 + var_328_9 + arg_328_0 and not isNil(var_328_7) and arg_325_1.var_.actorSpriteComps10030 then
				for iter_328_3, iter_328_4 in pairs(arg_325_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_328_4 then
						if arg_325_1.isInRecall_ then
							iter_328_4.color = arg_325_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_328_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_325_1.var_.actorSpriteComps10030 = nil
			end

			local var_328_15 = arg_325_1.actors_["1038"]
			local var_328_16 = 0

			if var_328_16 < arg_325_1.time_ and arg_325_1.time_ <= var_328_16 + arg_328_0 then
				local var_328_17 = var_328_15:GetComponentInChildren(typeof(CanvasGroup))

				if var_328_17 then
					arg_325_1.var_.alphaOldValue1038 = var_328_17.alpha
					arg_325_1.var_.characterEffect1038 = var_328_17
				end

				arg_325_1.var_.alphaOldValue1038 = 0
			end

			local var_328_18 = 0.333333333333333

			if var_328_16 <= arg_325_1.time_ and arg_325_1.time_ < var_328_16 + var_328_18 then
				local var_328_19 = (arg_325_1.time_ - var_328_16) / var_328_18
				local var_328_20 = Mathf.Lerp(arg_325_1.var_.alphaOldValue1038, 1, var_328_19)

				if arg_325_1.var_.characterEffect1038 then
					arg_325_1.var_.characterEffect1038.alpha = var_328_20
				end
			end

			if arg_325_1.time_ >= var_328_16 + var_328_18 and arg_325_1.time_ < var_328_16 + var_328_18 + arg_328_0 and arg_325_1.var_.characterEffect1038 then
				arg_325_1.var_.characterEffect1038.alpha = 1
			end

			local var_328_21 = 0
			local var_328_22 = 0.05

			if var_328_21 < arg_325_1.time_ and arg_325_1.time_ <= var_328_21 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0
				arg_325_1.dialogCg_.alpha = 1

				arg_325_1.dialog_:SetActive(true)
				SetActive(arg_325_1.leftNameGo_, true)

				local var_328_23 = arg_325_1:FormatText(StoryNameCfg[94].name)

				arg_325_1.leftNameTxt_.text = var_328_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_325_1.leftNameTxt_.transform)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1.leftNameTxt_.text)
				SetActive(arg_325_1.iconTrs_.gameObject, false)
				arg_325_1.callingController_:SetSelectedState("normal")

				local var_328_24 = arg_325_1:GetWordFromCfg(115281076)
				local var_328_25 = arg_325_1:FormatText(var_328_24.content)

				arg_325_1.text_.text = var_328_25

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_26 = 2
				local var_328_27 = utf8.len(var_328_25)
				local var_328_28 = var_328_26 <= 0 and var_328_22 or var_328_22 * (var_328_27 / var_328_26)

				if var_328_28 > 0 and var_328_22 < var_328_28 then
					arg_325_1.talkMaxDuration = var_328_28

					if var_328_28 + var_328_21 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_28 + var_328_21
					end
				end

				arg_325_1.text_.text = var_328_25
				arg_325_1.typewritter.percent = 0

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115281", "115281076", "story_v_out_115281.awb") ~= 0 then
					local var_328_29 = manager.audio:GetVoiceLength("story_v_out_115281", "115281076", "story_v_out_115281.awb") / 1000

					if var_328_29 + var_328_21 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_29 + var_328_21
					end

					if var_328_24.prefab_name ~= "" and arg_325_1.actors_[var_328_24.prefab_name] ~= nil then
						local var_328_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_325_1.actors_[var_328_24.prefab_name].transform, "story_v_out_115281", "115281076", "story_v_out_115281.awb")

						arg_325_1:RecordAudio("115281076", var_328_30)
						arg_325_1:RecordAudio("115281076", var_328_30)
					else
						arg_325_1:AudioAction("play", "voice", "story_v_out_115281", "115281076", "story_v_out_115281.awb")
					end

					arg_325_1:RecordHistoryTalkVoice("story_v_out_115281", "115281076", "story_v_out_115281.awb")
				end

				arg_325_1:RecordContent(arg_325_1.text_.text)
			end

			local var_328_31 = math.max(var_328_22, arg_325_1.talkMaxDuration)

			if var_328_21 <= arg_325_1.time_ and arg_325_1.time_ < var_328_21 + var_328_31 then
				arg_325_1.typewritter.percent = (arg_325_1.time_ - var_328_21) / var_328_31

				arg_325_1.typewritter:SetDirty()
			end

			if arg_325_1.time_ >= var_328_21 + var_328_31 and arg_325_1.time_ < var_328_21 + var_328_31 + arg_328_0 then
				arg_325_1.typewritter.percent = 1

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(true)
			end
		end

		arg_325_1.nodeConfigList_ = {
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

		arg_325_1:InitPlayNodeList()
	end,
	Play115281077 = function(arg_329_0, arg_329_1)
		arg_329_1.time_ = 0
		arg_329_1.frameCnt_ = 0
		arg_329_1.state_ = "playing"
		arg_329_1.curTalkId_ = 115281077
		arg_329_1.duration_ = 6.7

		local var_329_0 = {
			ja = 6.7,
			ko = 5.433,
			zh = 6.033,
			en = 5.666
		}
		local var_329_1 = manager.audio:GetLocalizationFlag()

		if var_329_0[var_329_1] ~= nil then
			arg_329_1.duration_ = var_329_0[var_329_1]
		end

		SetActive(arg_329_1.tipsGo_, false)

		function arg_329_1.onSingleLineFinish_()
			arg_329_1.onSingleLineUpdate_ = nil
			arg_329_1.onSingleLineFinish_ = nil
			arg_329_1.state_ = "waiting"
		end

		function arg_329_1.playNext_(arg_331_0)
			if arg_331_0 == 1 then
				arg_329_0:Play115281078(arg_329_1)
			end
		end

		function arg_329_1.onSingleLineUpdate_(arg_332_0)
			local var_332_0 = arg_329_1.actors_["1038"]
			local var_332_1 = 0

			if var_332_1 < arg_329_1.time_ and arg_329_1.time_ <= var_332_1 + arg_332_0 and not isNil(var_332_0) and arg_329_1.var_.actorSpriteComps1038 == nil then
				arg_329_1.var_.actorSpriteComps1038 = var_332_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_332_2 = 0.2

			if var_332_1 <= arg_329_1.time_ and arg_329_1.time_ < var_332_1 + var_332_2 and not isNil(var_332_0) then
				local var_332_3 = (arg_329_1.time_ - var_332_1) / var_332_2

				if arg_329_1.var_.actorSpriteComps1038 then
					for iter_332_0, iter_332_1 in pairs(arg_329_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_332_1 then
							if arg_329_1.isInRecall_ then
								local var_332_4 = Mathf.Lerp(iter_332_1.color.r, arg_329_1.hightColor2.r, var_332_3)
								local var_332_5 = Mathf.Lerp(iter_332_1.color.g, arg_329_1.hightColor2.g, var_332_3)
								local var_332_6 = Mathf.Lerp(iter_332_1.color.b, arg_329_1.hightColor2.b, var_332_3)

								iter_332_1.color = Color.New(var_332_4, var_332_5, var_332_6)
							else
								local var_332_7 = Mathf.Lerp(iter_332_1.color.r, 0.5, var_332_3)

								iter_332_1.color = Color.New(var_332_7, var_332_7, var_332_7)
							end
						end
					end
				end
			end

			if arg_329_1.time_ >= var_332_1 + var_332_2 and arg_329_1.time_ < var_332_1 + var_332_2 + arg_332_0 and not isNil(var_332_0) and arg_329_1.var_.actorSpriteComps1038 then
				for iter_332_2, iter_332_3 in pairs(arg_329_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_332_3 then
						if arg_329_1.isInRecall_ then
							iter_332_3.color = arg_329_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_332_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_329_1.var_.actorSpriteComps1038 = nil
			end

			local var_332_8 = arg_329_1.actors_["10030"]
			local var_332_9 = 0

			if var_332_9 < arg_329_1.time_ and arg_329_1.time_ <= var_332_9 + arg_332_0 and not isNil(var_332_8) and arg_329_1.var_.actorSpriteComps10030 == nil then
				arg_329_1.var_.actorSpriteComps10030 = var_332_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_332_10 = 0.2

			if var_332_9 <= arg_329_1.time_ and arg_329_1.time_ < var_332_9 + var_332_10 and not isNil(var_332_8) then
				local var_332_11 = (arg_329_1.time_ - var_332_9) / var_332_10

				if arg_329_1.var_.actorSpriteComps10030 then
					for iter_332_4, iter_332_5 in pairs(arg_329_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_332_5 then
							if arg_329_1.isInRecall_ then
								local var_332_12 = Mathf.Lerp(iter_332_5.color.r, arg_329_1.hightColor1.r, var_332_11)
								local var_332_13 = Mathf.Lerp(iter_332_5.color.g, arg_329_1.hightColor1.g, var_332_11)
								local var_332_14 = Mathf.Lerp(iter_332_5.color.b, arg_329_1.hightColor1.b, var_332_11)

								iter_332_5.color = Color.New(var_332_12, var_332_13, var_332_14)
							else
								local var_332_15 = Mathf.Lerp(iter_332_5.color.r, 1, var_332_11)

								iter_332_5.color = Color.New(var_332_15, var_332_15, var_332_15)
							end
						end
					end
				end
			end

			if arg_329_1.time_ >= var_332_9 + var_332_10 and arg_329_1.time_ < var_332_9 + var_332_10 + arg_332_0 and not isNil(var_332_8) and arg_329_1.var_.actorSpriteComps10030 then
				for iter_332_6, iter_332_7 in pairs(arg_329_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_332_7 then
						if arg_329_1.isInRecall_ then
							iter_332_7.color = arg_329_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_332_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_329_1.var_.actorSpriteComps10030 = nil
			end

			local var_332_16 = 0
			local var_332_17 = 0.525

			if var_332_16 < arg_329_1.time_ and arg_329_1.time_ <= var_332_16 + arg_332_0 then
				arg_329_1.talkMaxDuration = 0
				arg_329_1.dialogCg_.alpha = 1

				arg_329_1.dialog_:SetActive(true)
				SetActive(arg_329_1.leftNameGo_, true)

				local var_332_18 = arg_329_1:FormatText(StoryNameCfg[309].name)

				arg_329_1.leftNameTxt_.text = var_332_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_329_1.leftNameTxt_.transform)

				arg_329_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_329_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_329_1:RecordName(arg_329_1.leftNameTxt_.text)
				SetActive(arg_329_1.iconTrs_.gameObject, false)
				arg_329_1.callingController_:SetSelectedState("normal")

				local var_332_19 = arg_329_1:GetWordFromCfg(115281077)
				local var_332_20 = arg_329_1:FormatText(var_332_19.content)

				arg_329_1.text_.text = var_332_20

				LuaForUtil.ClearLinePrefixSymbol(arg_329_1.text_)

				local var_332_21 = 21
				local var_332_22 = utf8.len(var_332_20)
				local var_332_23 = var_332_21 <= 0 and var_332_17 or var_332_17 * (var_332_22 / var_332_21)

				if var_332_23 > 0 and var_332_17 < var_332_23 then
					arg_329_1.talkMaxDuration = var_332_23

					if var_332_23 + var_332_16 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_23 + var_332_16
					end
				end

				arg_329_1.text_.text = var_332_20
				arg_329_1.typewritter.percent = 0

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115281", "115281077", "story_v_out_115281.awb") ~= 0 then
					local var_332_24 = manager.audio:GetVoiceLength("story_v_out_115281", "115281077", "story_v_out_115281.awb") / 1000

					if var_332_24 + var_332_16 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_24 + var_332_16
					end

					if var_332_19.prefab_name ~= "" and arg_329_1.actors_[var_332_19.prefab_name] ~= nil then
						local var_332_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_329_1.actors_[var_332_19.prefab_name].transform, "story_v_out_115281", "115281077", "story_v_out_115281.awb")

						arg_329_1:RecordAudio("115281077", var_332_25)
						arg_329_1:RecordAudio("115281077", var_332_25)
					else
						arg_329_1:AudioAction("play", "voice", "story_v_out_115281", "115281077", "story_v_out_115281.awb")
					end

					arg_329_1:RecordHistoryTalkVoice("story_v_out_115281", "115281077", "story_v_out_115281.awb")
				end

				arg_329_1:RecordContent(arg_329_1.text_.text)
			end

			local var_332_26 = math.max(var_332_17, arg_329_1.talkMaxDuration)

			if var_332_16 <= arg_329_1.time_ and arg_329_1.time_ < var_332_16 + var_332_26 then
				arg_329_1.typewritter.percent = (arg_329_1.time_ - var_332_16) / var_332_26

				arg_329_1.typewritter:SetDirty()
			end

			if arg_329_1.time_ >= var_332_16 + var_332_26 and arg_329_1.time_ < var_332_16 + var_332_26 + arg_332_0 then
				arg_329_1.typewritter.percent = 1

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(true)
			end
		end

		arg_329_1.nodeConfigList_ = {}

		arg_329_1:InitPlayNodeList()
	end,
	Play115281078 = function(arg_333_0, arg_333_1)
		arg_333_1.time_ = 0
		arg_333_1.frameCnt_ = 0
		arg_333_1.state_ = "playing"
		arg_333_1.curTalkId_ = 115281078
		arg_333_1.duration_ = 11.4

		local var_333_0 = {
			ja = 9.066,
			ko = 10.133,
			zh = 10.266,
			en = 11.4
		}
		local var_333_1 = manager.audio:GetLocalizationFlag()

		if var_333_0[var_333_1] ~= nil then
			arg_333_1.duration_ = var_333_0[var_333_1]
		end

		SetActive(arg_333_1.tipsGo_, false)

		function arg_333_1.onSingleLineFinish_()
			arg_333_1.onSingleLineUpdate_ = nil
			arg_333_1.onSingleLineFinish_ = nil
			arg_333_1.state_ = "waiting"
		end

		function arg_333_1.playNext_(arg_335_0)
			if arg_335_0 == 1 then
				arg_333_0:Play115281079(arg_333_1)
			end
		end

		function arg_333_1.onSingleLineUpdate_(arg_336_0)
			local var_336_0 = 0
			local var_336_1 = 1.3

			if var_336_0 < arg_333_1.time_ and arg_333_1.time_ <= var_336_0 + arg_336_0 then
				arg_333_1.talkMaxDuration = 0
				arg_333_1.dialogCg_.alpha = 1

				arg_333_1.dialog_:SetActive(true)
				SetActive(arg_333_1.leftNameGo_, true)

				local var_336_2 = arg_333_1:FormatText(StoryNameCfg[309].name)

				arg_333_1.leftNameTxt_.text = var_336_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_333_1.leftNameTxt_.transform)

				arg_333_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_333_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_333_1:RecordName(arg_333_1.leftNameTxt_.text)
				SetActive(arg_333_1.iconTrs_.gameObject, false)
				arg_333_1.callingController_:SetSelectedState("normal")

				local var_336_3 = arg_333_1:GetWordFromCfg(115281078)
				local var_336_4 = arg_333_1:FormatText(var_336_3.content)

				arg_333_1.text_.text = var_336_4

				LuaForUtil.ClearLinePrefixSymbol(arg_333_1.text_)

				local var_336_5 = 52
				local var_336_6 = utf8.len(var_336_4)
				local var_336_7 = var_336_5 <= 0 and var_336_1 or var_336_1 * (var_336_6 / var_336_5)

				if var_336_7 > 0 and var_336_1 < var_336_7 then
					arg_333_1.talkMaxDuration = var_336_7

					if var_336_7 + var_336_0 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_7 + var_336_0
					end
				end

				arg_333_1.text_.text = var_336_4
				arg_333_1.typewritter.percent = 0

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115281", "115281078", "story_v_out_115281.awb") ~= 0 then
					local var_336_8 = manager.audio:GetVoiceLength("story_v_out_115281", "115281078", "story_v_out_115281.awb") / 1000

					if var_336_8 + var_336_0 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_8 + var_336_0
					end

					if var_336_3.prefab_name ~= "" and arg_333_1.actors_[var_336_3.prefab_name] ~= nil then
						local var_336_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_333_1.actors_[var_336_3.prefab_name].transform, "story_v_out_115281", "115281078", "story_v_out_115281.awb")

						arg_333_1:RecordAudio("115281078", var_336_9)
						arg_333_1:RecordAudio("115281078", var_336_9)
					else
						arg_333_1:AudioAction("play", "voice", "story_v_out_115281", "115281078", "story_v_out_115281.awb")
					end

					arg_333_1:RecordHistoryTalkVoice("story_v_out_115281", "115281078", "story_v_out_115281.awb")
				end

				arg_333_1:RecordContent(arg_333_1.text_.text)
			end

			local var_336_10 = math.max(var_336_1, arg_333_1.talkMaxDuration)

			if var_336_0 <= arg_333_1.time_ and arg_333_1.time_ < var_336_0 + var_336_10 then
				arg_333_1.typewritter.percent = (arg_333_1.time_ - var_336_0) / var_336_10

				arg_333_1.typewritter:SetDirty()
			end

			if arg_333_1.time_ >= var_336_0 + var_336_10 and arg_333_1.time_ < var_336_0 + var_336_10 + arg_336_0 then
				arg_333_1.typewritter.percent = 1

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(true)
			end
		end

		arg_333_1.nodeConfigList_ = {}

		arg_333_1:InitPlayNodeList()
	end,
	Play115281079 = function(arg_337_0, arg_337_1)
		arg_337_1.time_ = 0
		arg_337_1.frameCnt_ = 0
		arg_337_1.state_ = "playing"
		arg_337_1.curTalkId_ = 115281079
		arg_337_1.duration_ = 14.23

		local var_337_0 = {
			ja = 14.233,
			ko = 10.666,
			zh = 12.366,
			en = 11.566
		}
		local var_337_1 = manager.audio:GetLocalizationFlag()

		if var_337_0[var_337_1] ~= nil then
			arg_337_1.duration_ = var_337_0[var_337_1]
		end

		SetActive(arg_337_1.tipsGo_, false)

		function arg_337_1.onSingleLineFinish_()
			arg_337_1.onSingleLineUpdate_ = nil
			arg_337_1.onSingleLineFinish_ = nil
			arg_337_1.state_ = "waiting"
		end

		function arg_337_1.playNext_(arg_339_0)
			if arg_339_0 == 1 then
				arg_337_0:Play115281080(arg_337_1)
			end
		end

		function arg_337_1.onSingleLineUpdate_(arg_340_0)
			local var_340_0 = 0
			local var_340_1 = 1.425

			if var_340_0 < arg_337_1.time_ and arg_337_1.time_ <= var_340_0 + arg_340_0 then
				arg_337_1.talkMaxDuration = 0
				arg_337_1.dialogCg_.alpha = 1

				arg_337_1.dialog_:SetActive(true)
				SetActive(arg_337_1.leftNameGo_, true)

				local var_340_2 = arg_337_1:FormatText(StoryNameCfg[309].name)

				arg_337_1.leftNameTxt_.text = var_340_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_337_1.leftNameTxt_.transform)

				arg_337_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_337_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_337_1:RecordName(arg_337_1.leftNameTxt_.text)
				SetActive(arg_337_1.iconTrs_.gameObject, false)
				arg_337_1.callingController_:SetSelectedState("normal")

				local var_340_3 = arg_337_1:GetWordFromCfg(115281079)
				local var_340_4 = arg_337_1:FormatText(var_340_3.content)

				arg_337_1.text_.text = var_340_4

				LuaForUtil.ClearLinePrefixSymbol(arg_337_1.text_)

				local var_340_5 = 57
				local var_340_6 = utf8.len(var_340_4)
				local var_340_7 = var_340_5 <= 0 and var_340_1 or var_340_1 * (var_340_6 / var_340_5)

				if var_340_7 > 0 and var_340_1 < var_340_7 then
					arg_337_1.talkMaxDuration = var_340_7

					if var_340_7 + var_340_0 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_7 + var_340_0
					end
				end

				arg_337_1.text_.text = var_340_4
				arg_337_1.typewritter.percent = 0

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115281", "115281079", "story_v_out_115281.awb") ~= 0 then
					local var_340_8 = manager.audio:GetVoiceLength("story_v_out_115281", "115281079", "story_v_out_115281.awb") / 1000

					if var_340_8 + var_340_0 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_8 + var_340_0
					end

					if var_340_3.prefab_name ~= "" and arg_337_1.actors_[var_340_3.prefab_name] ~= nil then
						local var_340_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_337_1.actors_[var_340_3.prefab_name].transform, "story_v_out_115281", "115281079", "story_v_out_115281.awb")

						arg_337_1:RecordAudio("115281079", var_340_9)
						arg_337_1:RecordAudio("115281079", var_340_9)
					else
						arg_337_1:AudioAction("play", "voice", "story_v_out_115281", "115281079", "story_v_out_115281.awb")
					end

					arg_337_1:RecordHistoryTalkVoice("story_v_out_115281", "115281079", "story_v_out_115281.awb")
				end

				arg_337_1:RecordContent(arg_337_1.text_.text)
			end

			local var_340_10 = math.max(var_340_1, arg_337_1.talkMaxDuration)

			if var_340_0 <= arg_337_1.time_ and arg_337_1.time_ < var_340_0 + var_340_10 then
				arg_337_1.typewritter.percent = (arg_337_1.time_ - var_340_0) / var_340_10

				arg_337_1.typewritter:SetDirty()
			end

			if arg_337_1.time_ >= var_340_0 + var_340_10 and arg_337_1.time_ < var_340_0 + var_340_10 + arg_340_0 then
				arg_337_1.typewritter.percent = 1

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(true)
			end
		end

		arg_337_1.nodeConfigList_ = {}

		arg_337_1:InitPlayNodeList()
	end,
	Play115281080 = function(arg_341_0, arg_341_1)
		arg_341_1.time_ = 0
		arg_341_1.frameCnt_ = 0
		arg_341_1.state_ = "playing"
		arg_341_1.curTalkId_ = 115281080
		arg_341_1.duration_ = 13.7

		local var_341_0 = {
			ja = 13.7,
			ko = 10.566,
			zh = 9.633,
			en = 13.133
		}
		local var_341_1 = manager.audio:GetLocalizationFlag()

		if var_341_0[var_341_1] ~= nil then
			arg_341_1.duration_ = var_341_0[var_341_1]
		end

		SetActive(arg_341_1.tipsGo_, false)

		function arg_341_1.onSingleLineFinish_()
			arg_341_1.onSingleLineUpdate_ = nil
			arg_341_1.onSingleLineFinish_ = nil
			arg_341_1.state_ = "waiting"
		end

		function arg_341_1.playNext_(arg_343_0)
			if arg_343_0 == 1 then
				arg_341_0:Play115281081(arg_341_1)
			end
		end

		function arg_341_1.onSingleLineUpdate_(arg_344_0)
			local var_344_0 = 0
			local var_344_1 = 1.2

			if var_344_0 < arg_341_1.time_ and arg_341_1.time_ <= var_344_0 + arg_344_0 then
				arg_341_1.talkMaxDuration = 0
				arg_341_1.dialogCg_.alpha = 1

				arg_341_1.dialog_:SetActive(true)
				SetActive(arg_341_1.leftNameGo_, true)

				local var_344_2 = arg_341_1:FormatText(StoryNameCfg[309].name)

				arg_341_1.leftNameTxt_.text = var_344_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_341_1.leftNameTxt_.transform)

				arg_341_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_341_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_341_1:RecordName(arg_341_1.leftNameTxt_.text)
				SetActive(arg_341_1.iconTrs_.gameObject, false)
				arg_341_1.callingController_:SetSelectedState("normal")

				local var_344_3 = arg_341_1:GetWordFromCfg(115281080)
				local var_344_4 = arg_341_1:FormatText(var_344_3.content)

				arg_341_1.text_.text = var_344_4

				LuaForUtil.ClearLinePrefixSymbol(arg_341_1.text_)

				local var_344_5 = 48
				local var_344_6 = utf8.len(var_344_4)
				local var_344_7 = var_344_5 <= 0 and var_344_1 or var_344_1 * (var_344_6 / var_344_5)

				if var_344_7 > 0 and var_344_1 < var_344_7 then
					arg_341_1.talkMaxDuration = var_344_7

					if var_344_7 + var_344_0 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_7 + var_344_0
					end
				end

				arg_341_1.text_.text = var_344_4
				arg_341_1.typewritter.percent = 0

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115281", "115281080", "story_v_out_115281.awb") ~= 0 then
					local var_344_8 = manager.audio:GetVoiceLength("story_v_out_115281", "115281080", "story_v_out_115281.awb") / 1000

					if var_344_8 + var_344_0 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_8 + var_344_0
					end

					if var_344_3.prefab_name ~= "" and arg_341_1.actors_[var_344_3.prefab_name] ~= nil then
						local var_344_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_341_1.actors_[var_344_3.prefab_name].transform, "story_v_out_115281", "115281080", "story_v_out_115281.awb")

						arg_341_1:RecordAudio("115281080", var_344_9)
						arg_341_1:RecordAudio("115281080", var_344_9)
					else
						arg_341_1:AudioAction("play", "voice", "story_v_out_115281", "115281080", "story_v_out_115281.awb")
					end

					arg_341_1:RecordHistoryTalkVoice("story_v_out_115281", "115281080", "story_v_out_115281.awb")
				end

				arg_341_1:RecordContent(arg_341_1.text_.text)
			end

			local var_344_10 = math.max(var_344_1, arg_341_1.talkMaxDuration)

			if var_344_0 <= arg_341_1.time_ and arg_341_1.time_ < var_344_0 + var_344_10 then
				arg_341_1.typewritter.percent = (arg_341_1.time_ - var_344_0) / var_344_10

				arg_341_1.typewritter:SetDirty()
			end

			if arg_341_1.time_ >= var_344_0 + var_344_10 and arg_341_1.time_ < var_344_0 + var_344_10 + arg_344_0 then
				arg_341_1.typewritter.percent = 1

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(true)
			end
		end

		arg_341_1.nodeConfigList_ = {}

		arg_341_1:InitPlayNodeList()
	end,
	Play115281081 = function(arg_345_0, arg_345_1)
		arg_345_1.time_ = 0
		arg_345_1.frameCnt_ = 0
		arg_345_1.state_ = "playing"
		arg_345_1.curTalkId_ = 115281081
		arg_345_1.duration_ = 5

		SetActive(arg_345_1.tipsGo_, false)

		function arg_345_1.onSingleLineFinish_()
			arg_345_1.onSingleLineUpdate_ = nil
			arg_345_1.onSingleLineFinish_ = nil
			arg_345_1.state_ = "waiting"
		end

		function arg_345_1.playNext_(arg_347_0)
			if arg_347_0 == 1 then
				arg_345_0:Play115281082(arg_345_1)
			end
		end

		function arg_345_1.onSingleLineUpdate_(arg_348_0)
			local var_348_0 = arg_345_1.actors_["1038"]
			local var_348_1 = 0

			if var_348_1 < arg_345_1.time_ and arg_345_1.time_ <= var_348_1 + arg_348_0 then
				local var_348_2 = var_348_0:GetComponentInChildren(typeof(CanvasGroup))

				if var_348_2 then
					arg_345_1.var_.alphaOldValue1038 = var_348_2.alpha
					arg_345_1.var_.characterEffect1038 = var_348_2
				end

				arg_345_1.var_.alphaOldValue1038 = 1
			end

			local var_348_3 = 0.333333333333333

			if var_348_1 <= arg_345_1.time_ and arg_345_1.time_ < var_348_1 + var_348_3 then
				local var_348_4 = (arg_345_1.time_ - var_348_1) / var_348_3
				local var_348_5 = Mathf.Lerp(arg_345_1.var_.alphaOldValue1038, 0, var_348_4)

				if arg_345_1.var_.characterEffect1038 then
					arg_345_1.var_.characterEffect1038.alpha = var_348_5
				end
			end

			if arg_345_1.time_ >= var_348_1 + var_348_3 and arg_345_1.time_ < var_348_1 + var_348_3 + arg_348_0 and arg_345_1.var_.characterEffect1038 then
				arg_345_1.var_.characterEffect1038.alpha = 0
			end

			local var_348_6 = arg_345_1.actors_["10030"]
			local var_348_7 = 0

			if var_348_7 < arg_345_1.time_ and arg_345_1.time_ <= var_348_7 + arg_348_0 then
				local var_348_8 = var_348_6:GetComponentInChildren(typeof(CanvasGroup))

				if var_348_8 then
					arg_345_1.var_.alphaOldValue10030 = var_348_8.alpha
					arg_345_1.var_.characterEffect10030 = var_348_8
				end

				arg_345_1.var_.alphaOldValue10030 = 1
			end

			local var_348_9 = 0.333333333333333

			if var_348_7 <= arg_345_1.time_ and arg_345_1.time_ < var_348_7 + var_348_9 then
				local var_348_10 = (arg_345_1.time_ - var_348_7) / var_348_9
				local var_348_11 = Mathf.Lerp(arg_345_1.var_.alphaOldValue10030, 0, var_348_10)

				if arg_345_1.var_.characterEffect10030 then
					arg_345_1.var_.characterEffect10030.alpha = var_348_11
				end
			end

			if arg_345_1.time_ >= var_348_7 + var_348_9 and arg_345_1.time_ < var_348_7 + var_348_9 + arg_348_0 and arg_345_1.var_.characterEffect10030 then
				arg_345_1.var_.characterEffect10030.alpha = 0
			end

			local var_348_12 = 0
			local var_348_13 = 1.05

			if var_348_12 < arg_345_1.time_ and arg_345_1.time_ <= var_348_12 + arg_348_0 then
				arg_345_1.talkMaxDuration = 0
				arg_345_1.dialogCg_.alpha = 1

				arg_345_1.dialog_:SetActive(true)
				SetActive(arg_345_1.leftNameGo_, false)

				arg_345_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_345_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_345_1:RecordName(arg_345_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_345_1.iconTrs_.gameObject, false)
				arg_345_1.callingController_:SetSelectedState("normal")

				local var_348_14 = arg_345_1:GetWordFromCfg(115281081)
				local var_348_15 = arg_345_1:FormatText(var_348_14.content)

				arg_345_1.text_.text = var_348_15

				LuaForUtil.ClearLinePrefixSymbol(arg_345_1.text_)

				local var_348_16 = 42
				local var_348_17 = utf8.len(var_348_15)
				local var_348_18 = var_348_16 <= 0 and var_348_13 or var_348_13 * (var_348_17 / var_348_16)

				if var_348_18 > 0 and var_348_13 < var_348_18 then
					arg_345_1.talkMaxDuration = var_348_18

					if var_348_18 + var_348_12 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_18 + var_348_12
					end
				end

				arg_345_1.text_.text = var_348_15
				arg_345_1.typewritter.percent = 0

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(false)
				arg_345_1:RecordContent(arg_345_1.text_.text)
			end

			local var_348_19 = math.max(var_348_13, arg_345_1.talkMaxDuration)

			if var_348_12 <= arg_345_1.time_ and arg_345_1.time_ < var_348_12 + var_348_19 then
				arg_345_1.typewritter.percent = (arg_345_1.time_ - var_348_12) / var_348_19

				arg_345_1.typewritter:SetDirty()
			end

			if arg_345_1.time_ >= var_348_12 + var_348_19 and arg_345_1.time_ < var_348_12 + var_348_19 + arg_348_0 then
				arg_345_1.typewritter.percent = 1

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(true)
			end
		end

		arg_345_1.nodeConfigList_ = {}

		arg_345_1:InitPlayNodeList()
	end,
	Play115281082 = function(arg_349_0, arg_349_1)
		arg_349_1.time_ = 0
		arg_349_1.frameCnt_ = 0
		arg_349_1.state_ = "playing"
		arg_349_1.curTalkId_ = 115281082
		arg_349_1.duration_ = 4.4

		local var_349_0 = {
			ja = 2.1,
			ko = 3.366,
			zh = 3.4,
			en = 4.4
		}
		local var_349_1 = manager.audio:GetLocalizationFlag()

		if var_349_0[var_349_1] ~= nil then
			arg_349_1.duration_ = var_349_0[var_349_1]
		end

		SetActive(arg_349_1.tipsGo_, false)

		function arg_349_1.onSingleLineFinish_()
			arg_349_1.onSingleLineUpdate_ = nil
			arg_349_1.onSingleLineFinish_ = nil
			arg_349_1.state_ = "waiting"
		end

		function arg_349_1.playNext_(arg_351_0)
			if arg_351_0 == 1 then
				arg_349_0:Play115281083(arg_349_1)
			end
		end

		function arg_349_1.onSingleLineUpdate_(arg_352_0)
			local var_352_0 = arg_349_1.actors_["10030"].transform
			local var_352_1 = 0

			if var_352_1 < arg_349_1.time_ and arg_349_1.time_ <= var_352_1 + arg_352_0 then
				arg_349_1.var_.moveOldPos10030 = var_352_0.localPosition
				var_352_0.localScale = Vector3.New(1, 1, 1)

				arg_349_1:CheckSpriteTmpPos("10030", 4)

				local var_352_2 = var_352_0.childCount

				for iter_352_0 = 0, var_352_2 - 1 do
					local var_352_3 = var_352_0:GetChild(iter_352_0)

					if var_352_3.name == "split_2" or not string.find(var_352_3.name, "split") then
						var_352_3.gameObject:SetActive(true)
					else
						var_352_3.gameObject:SetActive(false)
					end
				end
			end

			local var_352_4 = 0.001

			if var_352_1 <= arg_349_1.time_ and arg_349_1.time_ < var_352_1 + var_352_4 then
				local var_352_5 = (arg_349_1.time_ - var_352_1) / var_352_4
				local var_352_6 = Vector3.New(390, -390, 150)

				var_352_0.localPosition = Vector3.Lerp(arg_349_1.var_.moveOldPos10030, var_352_6, var_352_5)
			end

			if arg_349_1.time_ >= var_352_1 + var_352_4 and arg_349_1.time_ < var_352_1 + var_352_4 + arg_352_0 then
				var_352_0.localPosition = Vector3.New(390, -390, 150)
			end

			local var_352_7 = arg_349_1.actors_["10030"]
			local var_352_8 = 0

			if var_352_8 < arg_349_1.time_ and arg_349_1.time_ <= var_352_8 + arg_352_0 then
				local var_352_9 = var_352_7:GetComponentInChildren(typeof(CanvasGroup))

				if var_352_9 then
					arg_349_1.var_.alphaOldValue10030 = var_352_9.alpha
					arg_349_1.var_.characterEffect10030 = var_352_9
				end

				arg_349_1.var_.alphaOldValue10030 = 0
			end

			local var_352_10 = 0.333333333333333

			if var_352_8 <= arg_349_1.time_ and arg_349_1.time_ < var_352_8 + var_352_10 then
				local var_352_11 = (arg_349_1.time_ - var_352_8) / var_352_10
				local var_352_12 = Mathf.Lerp(arg_349_1.var_.alphaOldValue10030, 1, var_352_11)

				if arg_349_1.var_.characterEffect10030 then
					arg_349_1.var_.characterEffect10030.alpha = var_352_12
				end
			end

			if arg_349_1.time_ >= var_352_8 + var_352_10 and arg_349_1.time_ < var_352_8 + var_352_10 + arg_352_0 and arg_349_1.var_.characterEffect10030 then
				arg_349_1.var_.characterEffect10030.alpha = 1
			end

			local var_352_13 = arg_349_1.actors_["10030"]
			local var_352_14 = 0

			if var_352_14 < arg_349_1.time_ and arg_349_1.time_ <= var_352_14 + arg_352_0 and not isNil(var_352_13) and arg_349_1.var_.actorSpriteComps10030 == nil then
				arg_349_1.var_.actorSpriteComps10030 = var_352_13:GetComponentsInChildren(typeof(Image), true)
			end

			local var_352_15 = 0.2

			if var_352_14 <= arg_349_1.time_ and arg_349_1.time_ < var_352_14 + var_352_15 and not isNil(var_352_13) then
				local var_352_16 = (arg_349_1.time_ - var_352_14) / var_352_15

				if arg_349_1.var_.actorSpriteComps10030 then
					for iter_352_1, iter_352_2 in pairs(arg_349_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_352_2 then
							if arg_349_1.isInRecall_ then
								local var_352_17 = Mathf.Lerp(iter_352_2.color.r, arg_349_1.hightColor1.r, var_352_16)
								local var_352_18 = Mathf.Lerp(iter_352_2.color.g, arg_349_1.hightColor1.g, var_352_16)
								local var_352_19 = Mathf.Lerp(iter_352_2.color.b, arg_349_1.hightColor1.b, var_352_16)

								iter_352_2.color = Color.New(var_352_17, var_352_18, var_352_19)
							else
								local var_352_20 = Mathf.Lerp(iter_352_2.color.r, 1, var_352_16)

								iter_352_2.color = Color.New(var_352_20, var_352_20, var_352_20)
							end
						end
					end
				end
			end

			if arg_349_1.time_ >= var_352_14 + var_352_15 and arg_349_1.time_ < var_352_14 + var_352_15 + arg_352_0 and not isNil(var_352_13) and arg_349_1.var_.actorSpriteComps10030 then
				for iter_352_3, iter_352_4 in pairs(arg_349_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_352_4 then
						if arg_349_1.isInRecall_ then
							iter_352_4.color = arg_349_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_352_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_349_1.var_.actorSpriteComps10030 = nil
			end

			local var_352_21 = 0
			local var_352_22 = 0.35

			if var_352_21 < arg_349_1.time_ and arg_349_1.time_ <= var_352_21 + arg_352_0 then
				arg_349_1.talkMaxDuration = 0
				arg_349_1.dialogCg_.alpha = 1

				arg_349_1.dialog_:SetActive(true)
				SetActive(arg_349_1.leftNameGo_, true)

				local var_352_23 = arg_349_1:FormatText(StoryNameCfg[309].name)

				arg_349_1.leftNameTxt_.text = var_352_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_349_1.leftNameTxt_.transform)

				arg_349_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_349_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_349_1:RecordName(arg_349_1.leftNameTxt_.text)
				SetActive(arg_349_1.iconTrs_.gameObject, false)
				arg_349_1.callingController_:SetSelectedState("normal")

				local var_352_24 = arg_349_1:GetWordFromCfg(115281082)
				local var_352_25 = arg_349_1:FormatText(var_352_24.content)

				arg_349_1.text_.text = var_352_25

				LuaForUtil.ClearLinePrefixSymbol(arg_349_1.text_)

				local var_352_26 = 14
				local var_352_27 = utf8.len(var_352_25)
				local var_352_28 = var_352_26 <= 0 and var_352_22 or var_352_22 * (var_352_27 / var_352_26)

				if var_352_28 > 0 and var_352_22 < var_352_28 then
					arg_349_1.talkMaxDuration = var_352_28

					if var_352_28 + var_352_21 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_28 + var_352_21
					end
				end

				arg_349_1.text_.text = var_352_25
				arg_349_1.typewritter.percent = 0

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115281", "115281082", "story_v_out_115281.awb") ~= 0 then
					local var_352_29 = manager.audio:GetVoiceLength("story_v_out_115281", "115281082", "story_v_out_115281.awb") / 1000

					if var_352_29 + var_352_21 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_29 + var_352_21
					end

					if var_352_24.prefab_name ~= "" and arg_349_1.actors_[var_352_24.prefab_name] ~= nil then
						local var_352_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_349_1.actors_[var_352_24.prefab_name].transform, "story_v_out_115281", "115281082", "story_v_out_115281.awb")

						arg_349_1:RecordAudio("115281082", var_352_30)
						arg_349_1:RecordAudio("115281082", var_352_30)
					else
						arg_349_1:AudioAction("play", "voice", "story_v_out_115281", "115281082", "story_v_out_115281.awb")
					end

					arg_349_1:RecordHistoryTalkVoice("story_v_out_115281", "115281082", "story_v_out_115281.awb")
				end

				arg_349_1:RecordContent(arg_349_1.text_.text)
			end

			local var_352_31 = math.max(var_352_22, arg_349_1.talkMaxDuration)

			if var_352_21 <= arg_349_1.time_ and arg_349_1.time_ < var_352_21 + var_352_31 then
				arg_349_1.typewritter.percent = (arg_349_1.time_ - var_352_21) / var_352_31

				arg_349_1.typewritter:SetDirty()
			end

			if arg_349_1.time_ >= var_352_21 + var_352_31 and arg_349_1.time_ < var_352_21 + var_352_31 + arg_352_0 then
				arg_349_1.typewritter.percent = 1

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(true)
			end
		end

		arg_349_1.nodeConfigList_ = {
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

		arg_349_1:InitPlayNodeList()
	end,
	Play115281083 = function(arg_353_0, arg_353_1)
		arg_353_1.time_ = 0
		arg_353_1.frameCnt_ = 0
		arg_353_1.state_ = "playing"
		arg_353_1.curTalkId_ = 115281083
		arg_353_1.duration_ = 5.53

		local var_353_0 = {
			ja = 5.533,
			ko = 3.366,
			zh = 3.3,
			en = 5.033
		}
		local var_353_1 = manager.audio:GetLocalizationFlag()

		if var_353_0[var_353_1] ~= nil then
			arg_353_1.duration_ = var_353_0[var_353_1]
		end

		SetActive(arg_353_1.tipsGo_, false)

		function arg_353_1.onSingleLineFinish_()
			arg_353_1.onSingleLineUpdate_ = nil
			arg_353_1.onSingleLineFinish_ = nil
			arg_353_1.state_ = "waiting"
		end

		function arg_353_1.playNext_(arg_355_0)
			if arg_355_0 == 1 then
				arg_353_0:Play115281084(arg_353_1)
			end
		end

		function arg_353_1.onSingleLineUpdate_(arg_356_0)
			local var_356_0 = arg_353_1.actors_["1038"].transform
			local var_356_1 = 0

			if var_356_1 < arg_353_1.time_ and arg_353_1.time_ <= var_356_1 + arg_356_0 then
				arg_353_1.var_.moveOldPos1038 = var_356_0.localPosition
				var_356_0.localScale = Vector3.New(1, 1, 1)

				arg_353_1:CheckSpriteTmpPos("1038", 2)

				local var_356_2 = var_356_0.childCount

				for iter_356_0 = 0, var_356_2 - 1 do
					local var_356_3 = var_356_0:GetChild(iter_356_0)

					if var_356_3.name == "split_7" or not string.find(var_356_3.name, "split") then
						var_356_3.gameObject:SetActive(true)
					else
						var_356_3.gameObject:SetActive(false)
					end
				end
			end

			local var_356_4 = 0.001

			if var_356_1 <= arg_353_1.time_ and arg_353_1.time_ < var_356_1 + var_356_4 then
				local var_356_5 = (arg_353_1.time_ - var_356_1) / var_356_4
				local var_356_6 = Vector3.New(-390, -400, 0)

				var_356_0.localPosition = Vector3.Lerp(arg_353_1.var_.moveOldPos1038, var_356_6, var_356_5)
			end

			if arg_353_1.time_ >= var_356_1 + var_356_4 and arg_353_1.time_ < var_356_1 + var_356_4 + arg_356_0 then
				var_356_0.localPosition = Vector3.New(-390, -400, 0)
			end

			local var_356_7 = arg_353_1.actors_["10030"]
			local var_356_8 = 0

			if var_356_8 < arg_353_1.time_ and arg_353_1.time_ <= var_356_8 + arg_356_0 and not isNil(var_356_7) and arg_353_1.var_.actorSpriteComps10030 == nil then
				arg_353_1.var_.actorSpriteComps10030 = var_356_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_356_9 = 0.2

			if var_356_8 <= arg_353_1.time_ and arg_353_1.time_ < var_356_8 + var_356_9 and not isNil(var_356_7) then
				local var_356_10 = (arg_353_1.time_ - var_356_8) / var_356_9

				if arg_353_1.var_.actorSpriteComps10030 then
					for iter_356_1, iter_356_2 in pairs(arg_353_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_356_2 then
							if arg_353_1.isInRecall_ then
								local var_356_11 = Mathf.Lerp(iter_356_2.color.r, arg_353_1.hightColor2.r, var_356_10)
								local var_356_12 = Mathf.Lerp(iter_356_2.color.g, arg_353_1.hightColor2.g, var_356_10)
								local var_356_13 = Mathf.Lerp(iter_356_2.color.b, arg_353_1.hightColor2.b, var_356_10)

								iter_356_2.color = Color.New(var_356_11, var_356_12, var_356_13)
							else
								local var_356_14 = Mathf.Lerp(iter_356_2.color.r, 0.5, var_356_10)

								iter_356_2.color = Color.New(var_356_14, var_356_14, var_356_14)
							end
						end
					end
				end
			end

			if arg_353_1.time_ >= var_356_8 + var_356_9 and arg_353_1.time_ < var_356_8 + var_356_9 + arg_356_0 and not isNil(var_356_7) and arg_353_1.var_.actorSpriteComps10030 then
				for iter_356_3, iter_356_4 in pairs(arg_353_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_356_4 then
						if arg_353_1.isInRecall_ then
							iter_356_4.color = arg_353_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_356_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_353_1.var_.actorSpriteComps10030 = nil
			end

			local var_356_15 = arg_353_1.actors_["1038"]
			local var_356_16 = 0

			if var_356_16 < arg_353_1.time_ and arg_353_1.time_ <= var_356_16 + arg_356_0 then
				local var_356_17 = var_356_15:GetComponentInChildren(typeof(CanvasGroup))

				if var_356_17 then
					arg_353_1.var_.alphaOldValue1038 = var_356_17.alpha
					arg_353_1.var_.characterEffect1038 = var_356_17
				end

				arg_353_1.var_.alphaOldValue1038 = 0
			end

			local var_356_18 = 0.333333333333333

			if var_356_16 <= arg_353_1.time_ and arg_353_1.time_ < var_356_16 + var_356_18 then
				local var_356_19 = (arg_353_1.time_ - var_356_16) / var_356_18
				local var_356_20 = Mathf.Lerp(arg_353_1.var_.alphaOldValue1038, 1, var_356_19)

				if arg_353_1.var_.characterEffect1038 then
					arg_353_1.var_.characterEffect1038.alpha = var_356_20
				end
			end

			if arg_353_1.time_ >= var_356_16 + var_356_18 and arg_353_1.time_ < var_356_16 + var_356_18 + arg_356_0 and arg_353_1.var_.characterEffect1038 then
				arg_353_1.var_.characterEffect1038.alpha = 1
			end

			local var_356_21 = arg_353_1.actors_["1038"]
			local var_356_22 = 0

			if var_356_22 < arg_353_1.time_ and arg_353_1.time_ <= var_356_22 + arg_356_0 and not isNil(var_356_21) and arg_353_1.var_.actorSpriteComps1038 == nil then
				arg_353_1.var_.actorSpriteComps1038 = var_356_21:GetComponentsInChildren(typeof(Image), true)
			end

			local var_356_23 = 0.2

			if var_356_22 <= arg_353_1.time_ and arg_353_1.time_ < var_356_22 + var_356_23 and not isNil(var_356_21) then
				local var_356_24 = (arg_353_1.time_ - var_356_22) / var_356_23

				if arg_353_1.var_.actorSpriteComps1038 then
					for iter_356_5, iter_356_6 in pairs(arg_353_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_356_6 then
							if arg_353_1.isInRecall_ then
								local var_356_25 = Mathf.Lerp(iter_356_6.color.r, arg_353_1.hightColor1.r, var_356_24)
								local var_356_26 = Mathf.Lerp(iter_356_6.color.g, arg_353_1.hightColor1.g, var_356_24)
								local var_356_27 = Mathf.Lerp(iter_356_6.color.b, arg_353_1.hightColor1.b, var_356_24)

								iter_356_6.color = Color.New(var_356_25, var_356_26, var_356_27)
							else
								local var_356_28 = Mathf.Lerp(iter_356_6.color.r, 1, var_356_24)

								iter_356_6.color = Color.New(var_356_28, var_356_28, var_356_28)
							end
						end
					end
				end
			end

			if arg_353_1.time_ >= var_356_22 + var_356_23 and arg_353_1.time_ < var_356_22 + var_356_23 + arg_356_0 and not isNil(var_356_21) and arg_353_1.var_.actorSpriteComps1038 then
				for iter_356_7, iter_356_8 in pairs(arg_353_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_356_8 then
						if arg_353_1.isInRecall_ then
							iter_356_8.color = arg_353_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_356_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_353_1.var_.actorSpriteComps1038 = nil
			end

			local var_356_29 = 0
			local var_356_30 = 0.225

			if var_356_29 < arg_353_1.time_ and arg_353_1.time_ <= var_356_29 + arg_356_0 then
				arg_353_1.talkMaxDuration = 0
				arg_353_1.dialogCg_.alpha = 1

				arg_353_1.dialog_:SetActive(true)
				SetActive(arg_353_1.leftNameGo_, true)

				local var_356_31 = arg_353_1:FormatText(StoryNameCfg[94].name)

				arg_353_1.leftNameTxt_.text = var_356_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_353_1.leftNameTxt_.transform)

				arg_353_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_353_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_353_1:RecordName(arg_353_1.leftNameTxt_.text)
				SetActive(arg_353_1.iconTrs_.gameObject, false)
				arg_353_1.callingController_:SetSelectedState("normal")

				local var_356_32 = arg_353_1:GetWordFromCfg(115281083)
				local var_356_33 = arg_353_1:FormatText(var_356_32.content)

				arg_353_1.text_.text = var_356_33

				LuaForUtil.ClearLinePrefixSymbol(arg_353_1.text_)

				local var_356_34 = 9
				local var_356_35 = utf8.len(var_356_33)
				local var_356_36 = var_356_34 <= 0 and var_356_30 or var_356_30 * (var_356_35 / var_356_34)

				if var_356_36 > 0 and var_356_30 < var_356_36 then
					arg_353_1.talkMaxDuration = var_356_36

					if var_356_36 + var_356_29 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_36 + var_356_29
					end
				end

				arg_353_1.text_.text = var_356_33
				arg_353_1.typewritter.percent = 0

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115281", "115281083", "story_v_out_115281.awb") ~= 0 then
					local var_356_37 = manager.audio:GetVoiceLength("story_v_out_115281", "115281083", "story_v_out_115281.awb") / 1000

					if var_356_37 + var_356_29 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_37 + var_356_29
					end

					if var_356_32.prefab_name ~= "" and arg_353_1.actors_[var_356_32.prefab_name] ~= nil then
						local var_356_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_353_1.actors_[var_356_32.prefab_name].transform, "story_v_out_115281", "115281083", "story_v_out_115281.awb")

						arg_353_1:RecordAudio("115281083", var_356_38)
						arg_353_1:RecordAudio("115281083", var_356_38)
					else
						arg_353_1:AudioAction("play", "voice", "story_v_out_115281", "115281083", "story_v_out_115281.awb")
					end

					arg_353_1:RecordHistoryTalkVoice("story_v_out_115281", "115281083", "story_v_out_115281.awb")
				end

				arg_353_1:RecordContent(arg_353_1.text_.text)
			end

			local var_356_39 = math.max(var_356_30, arg_353_1.talkMaxDuration)

			if var_356_29 <= arg_353_1.time_ and arg_353_1.time_ < var_356_29 + var_356_39 then
				arg_353_1.typewritter.percent = (arg_353_1.time_ - var_356_29) / var_356_39

				arg_353_1.typewritter:SetDirty()
			end

			if arg_353_1.time_ >= var_356_29 + var_356_39 and arg_353_1.time_ < var_356_29 + var_356_39 + arg_356_0 then
				arg_353_1.typewritter.percent = 1

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(true)
			end
		end

		arg_353_1.nodeConfigList_ = {
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

		arg_353_1:InitPlayNodeList()
	end,
	Play115281084 = function(arg_357_0, arg_357_1)
		arg_357_1.time_ = 0
		arg_357_1.frameCnt_ = 0
		arg_357_1.state_ = "playing"
		arg_357_1.curTalkId_ = 115281084
		arg_357_1.duration_ = 6.83

		local var_357_0 = {
			ja = 6.833,
			ko = 4.766,
			zh = 5.466,
			en = 5.566
		}
		local var_357_1 = manager.audio:GetLocalizationFlag()

		if var_357_0[var_357_1] ~= nil then
			arg_357_1.duration_ = var_357_0[var_357_1]
		end

		SetActive(arg_357_1.tipsGo_, false)

		function arg_357_1.onSingleLineFinish_()
			arg_357_1.onSingleLineUpdate_ = nil
			arg_357_1.onSingleLineFinish_ = nil
			arg_357_1.state_ = "waiting"
		end

		function arg_357_1.playNext_(arg_359_0)
			if arg_359_0 == 1 then
				arg_357_0:Play115281085(arg_357_1)
			end
		end

		function arg_357_1.onSingleLineUpdate_(arg_360_0)
			local var_360_0 = arg_357_1.actors_["10030"]
			local var_360_1 = 0

			if var_360_1 < arg_357_1.time_ and arg_357_1.time_ <= var_360_1 + arg_360_0 and not isNil(var_360_0) and arg_357_1.var_.actorSpriteComps10030 == nil then
				arg_357_1.var_.actorSpriteComps10030 = var_360_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_360_2 = 0.2

			if var_360_1 <= arg_357_1.time_ and arg_357_1.time_ < var_360_1 + var_360_2 and not isNil(var_360_0) then
				local var_360_3 = (arg_357_1.time_ - var_360_1) / var_360_2

				if arg_357_1.var_.actorSpriteComps10030 then
					for iter_360_0, iter_360_1 in pairs(arg_357_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_360_1 then
							if arg_357_1.isInRecall_ then
								local var_360_4 = Mathf.Lerp(iter_360_1.color.r, arg_357_1.hightColor1.r, var_360_3)
								local var_360_5 = Mathf.Lerp(iter_360_1.color.g, arg_357_1.hightColor1.g, var_360_3)
								local var_360_6 = Mathf.Lerp(iter_360_1.color.b, arg_357_1.hightColor1.b, var_360_3)

								iter_360_1.color = Color.New(var_360_4, var_360_5, var_360_6)
							else
								local var_360_7 = Mathf.Lerp(iter_360_1.color.r, 1, var_360_3)

								iter_360_1.color = Color.New(var_360_7, var_360_7, var_360_7)
							end
						end
					end
				end
			end

			if arg_357_1.time_ >= var_360_1 + var_360_2 and arg_357_1.time_ < var_360_1 + var_360_2 + arg_360_0 and not isNil(var_360_0) and arg_357_1.var_.actorSpriteComps10030 then
				for iter_360_2, iter_360_3 in pairs(arg_357_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_360_3 then
						if arg_357_1.isInRecall_ then
							iter_360_3.color = arg_357_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_360_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_357_1.var_.actorSpriteComps10030 = nil
			end

			local var_360_8 = arg_357_1.actors_["1038"]
			local var_360_9 = 0

			if var_360_9 < arg_357_1.time_ and arg_357_1.time_ <= var_360_9 + arg_360_0 and not isNil(var_360_8) and arg_357_1.var_.actorSpriteComps1038 == nil then
				arg_357_1.var_.actorSpriteComps1038 = var_360_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_360_10 = 0.2

			if var_360_9 <= arg_357_1.time_ and arg_357_1.time_ < var_360_9 + var_360_10 and not isNil(var_360_8) then
				local var_360_11 = (arg_357_1.time_ - var_360_9) / var_360_10

				if arg_357_1.var_.actorSpriteComps1038 then
					for iter_360_4, iter_360_5 in pairs(arg_357_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_360_5 then
							if arg_357_1.isInRecall_ then
								local var_360_12 = Mathf.Lerp(iter_360_5.color.r, arg_357_1.hightColor2.r, var_360_11)
								local var_360_13 = Mathf.Lerp(iter_360_5.color.g, arg_357_1.hightColor2.g, var_360_11)
								local var_360_14 = Mathf.Lerp(iter_360_5.color.b, arg_357_1.hightColor2.b, var_360_11)

								iter_360_5.color = Color.New(var_360_12, var_360_13, var_360_14)
							else
								local var_360_15 = Mathf.Lerp(iter_360_5.color.r, 0.5, var_360_11)

								iter_360_5.color = Color.New(var_360_15, var_360_15, var_360_15)
							end
						end
					end
				end
			end

			if arg_357_1.time_ >= var_360_9 + var_360_10 and arg_357_1.time_ < var_360_9 + var_360_10 + arg_360_0 and not isNil(var_360_8) and arg_357_1.var_.actorSpriteComps1038 then
				for iter_360_6, iter_360_7 in pairs(arg_357_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_360_7 then
						if arg_357_1.isInRecall_ then
							iter_360_7.color = arg_357_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_360_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_357_1.var_.actorSpriteComps1038 = nil
			end

			local var_360_16 = arg_357_1.actors_["10030"].transform
			local var_360_17 = 0

			if var_360_17 < arg_357_1.time_ and arg_357_1.time_ <= var_360_17 + arg_360_0 then
				arg_357_1.var_.moveOldPos10030 = var_360_16.localPosition
				var_360_16.localScale = Vector3.New(1, 1, 1)

				arg_357_1:CheckSpriteTmpPos("10030", 4)

				local var_360_18 = var_360_16.childCount

				for iter_360_8 = 0, var_360_18 - 1 do
					local var_360_19 = var_360_16:GetChild(iter_360_8)

					if var_360_19.name == "split_1" or not string.find(var_360_19.name, "split") then
						var_360_19.gameObject:SetActive(true)
					else
						var_360_19.gameObject:SetActive(false)
					end
				end
			end

			local var_360_20 = 0.001

			if var_360_17 <= arg_357_1.time_ and arg_357_1.time_ < var_360_17 + var_360_20 then
				local var_360_21 = (arg_357_1.time_ - var_360_17) / var_360_20
				local var_360_22 = Vector3.New(390, -390, 150)

				var_360_16.localPosition = Vector3.Lerp(arg_357_1.var_.moveOldPos10030, var_360_22, var_360_21)
			end

			if arg_357_1.time_ >= var_360_17 + var_360_20 and arg_357_1.time_ < var_360_17 + var_360_20 + arg_360_0 then
				var_360_16.localPosition = Vector3.New(390, -390, 150)
			end

			local var_360_23 = arg_357_1.actors_["10030"]
			local var_360_24 = 0

			if var_360_24 < arg_357_1.time_ and arg_357_1.time_ <= var_360_24 + arg_360_0 then
				local var_360_25 = var_360_23:GetComponentInChildren(typeof(CanvasGroup))

				if var_360_25 then
					arg_357_1.var_.alphaOldValue10030 = var_360_25.alpha
					arg_357_1.var_.characterEffect10030 = var_360_25
				end

				arg_357_1.var_.alphaOldValue10030 = 0
			end

			local var_360_26 = 0.0166666666666667

			if var_360_24 <= arg_357_1.time_ and arg_357_1.time_ < var_360_24 + var_360_26 then
				local var_360_27 = (arg_357_1.time_ - var_360_24) / var_360_26
				local var_360_28 = Mathf.Lerp(arg_357_1.var_.alphaOldValue10030, 1, var_360_27)

				if arg_357_1.var_.characterEffect10030 then
					arg_357_1.var_.characterEffect10030.alpha = var_360_28
				end
			end

			if arg_357_1.time_ >= var_360_24 + var_360_26 and arg_357_1.time_ < var_360_24 + var_360_26 + arg_360_0 and arg_357_1.var_.characterEffect10030 then
				arg_357_1.var_.characterEffect10030.alpha = 1
			end

			local var_360_29 = 0
			local var_360_30 = 0.35

			if var_360_29 < arg_357_1.time_ and arg_357_1.time_ <= var_360_29 + arg_360_0 then
				arg_357_1.talkMaxDuration = 0
				arg_357_1.dialogCg_.alpha = 1

				arg_357_1.dialog_:SetActive(true)
				SetActive(arg_357_1.leftNameGo_, true)

				local var_360_31 = arg_357_1:FormatText(StoryNameCfg[309].name)

				arg_357_1.leftNameTxt_.text = var_360_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_357_1.leftNameTxt_.transform)

				arg_357_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_357_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_357_1:RecordName(arg_357_1.leftNameTxt_.text)
				SetActive(arg_357_1.iconTrs_.gameObject, false)
				arg_357_1.callingController_:SetSelectedState("normal")

				local var_360_32 = arg_357_1:GetWordFromCfg(115281084)
				local var_360_33 = arg_357_1:FormatText(var_360_32.content)

				arg_357_1.text_.text = var_360_33

				LuaForUtil.ClearLinePrefixSymbol(arg_357_1.text_)

				local var_360_34 = 14
				local var_360_35 = utf8.len(var_360_33)
				local var_360_36 = var_360_34 <= 0 and var_360_30 or var_360_30 * (var_360_35 / var_360_34)

				if var_360_36 > 0 and var_360_30 < var_360_36 then
					arg_357_1.talkMaxDuration = var_360_36

					if var_360_36 + var_360_29 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_36 + var_360_29
					end
				end

				arg_357_1.text_.text = var_360_33
				arg_357_1.typewritter.percent = 0

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115281", "115281084", "story_v_out_115281.awb") ~= 0 then
					local var_360_37 = manager.audio:GetVoiceLength("story_v_out_115281", "115281084", "story_v_out_115281.awb") / 1000

					if var_360_37 + var_360_29 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_37 + var_360_29
					end

					if var_360_32.prefab_name ~= "" and arg_357_1.actors_[var_360_32.prefab_name] ~= nil then
						local var_360_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_357_1.actors_[var_360_32.prefab_name].transform, "story_v_out_115281", "115281084", "story_v_out_115281.awb")

						arg_357_1:RecordAudio("115281084", var_360_38)
						arg_357_1:RecordAudio("115281084", var_360_38)
					else
						arg_357_1:AudioAction("play", "voice", "story_v_out_115281", "115281084", "story_v_out_115281.awb")
					end

					arg_357_1:RecordHistoryTalkVoice("story_v_out_115281", "115281084", "story_v_out_115281.awb")
				end

				arg_357_1:RecordContent(arg_357_1.text_.text)
			end

			local var_360_39 = math.max(var_360_30, arg_357_1.talkMaxDuration)

			if var_360_29 <= arg_357_1.time_ and arg_357_1.time_ < var_360_29 + var_360_39 then
				arg_357_1.typewritter.percent = (arg_357_1.time_ - var_360_29) / var_360_39

				arg_357_1.typewritter:SetDirty()
			end

			if arg_357_1.time_ >= var_360_29 + var_360_39 and arg_357_1.time_ < var_360_29 + var_360_39 + arg_360_0 then
				arg_357_1.typewritter.percent = 1

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(true)
			end
		end

		arg_357_1.nodeConfigList_ = {
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

		arg_357_1:InitPlayNodeList()
	end,
	Play115281085 = function(arg_361_0, arg_361_1)
		arg_361_1.time_ = 0
		arg_361_1.frameCnt_ = 0
		arg_361_1.state_ = "playing"
		arg_361_1.curTalkId_ = 115281085
		arg_361_1.duration_ = 8.57

		local var_361_0 = {
			ja = 8.566,
			ko = 7.833,
			zh = 6.866,
			en = 7.766
		}
		local var_361_1 = manager.audio:GetLocalizationFlag()

		if var_361_0[var_361_1] ~= nil then
			arg_361_1.duration_ = var_361_0[var_361_1]
		end

		SetActive(arg_361_1.tipsGo_, false)

		function arg_361_1.onSingleLineFinish_()
			arg_361_1.onSingleLineUpdate_ = nil
			arg_361_1.onSingleLineFinish_ = nil
			arg_361_1.state_ = "waiting"
		end

		function arg_361_1.playNext_(arg_363_0)
			if arg_363_0 == 1 then
				arg_361_0:Play115281086(arg_361_1)
			end
		end

		function arg_361_1.onSingleLineUpdate_(arg_364_0)
			local var_364_0 = arg_361_1.actors_["1038"].transform
			local var_364_1 = 0

			if var_364_1 < arg_361_1.time_ and arg_361_1.time_ <= var_364_1 + arg_364_0 then
				arg_361_1.var_.moveOldPos1038 = var_364_0.localPosition
				var_364_0.localScale = Vector3.New(1, 1, 1)

				arg_361_1:CheckSpriteTmpPos("1038", 2)

				local var_364_2 = var_364_0.childCount

				for iter_364_0 = 0, var_364_2 - 1 do
					local var_364_3 = var_364_0:GetChild(iter_364_0)

					if var_364_3.name == "split_2" or not string.find(var_364_3.name, "split") then
						var_364_3.gameObject:SetActive(true)
					else
						var_364_3.gameObject:SetActive(false)
					end
				end
			end

			local var_364_4 = 0.001

			if var_364_1 <= arg_361_1.time_ and arg_361_1.time_ < var_364_1 + var_364_4 then
				local var_364_5 = (arg_361_1.time_ - var_364_1) / var_364_4
				local var_364_6 = Vector3.New(-390, -400, 0)

				var_364_0.localPosition = Vector3.Lerp(arg_361_1.var_.moveOldPos1038, var_364_6, var_364_5)
			end

			if arg_361_1.time_ >= var_364_1 + var_364_4 and arg_361_1.time_ < var_364_1 + var_364_4 + arg_364_0 then
				var_364_0.localPosition = Vector3.New(-390, -400, 0)
			end

			local var_364_7 = arg_361_1.actors_["10030"]
			local var_364_8 = 0

			if var_364_8 < arg_361_1.time_ and arg_361_1.time_ <= var_364_8 + arg_364_0 and not isNil(var_364_7) and arg_361_1.var_.actorSpriteComps10030 == nil then
				arg_361_1.var_.actorSpriteComps10030 = var_364_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_364_9 = 0.2

			if var_364_8 <= arg_361_1.time_ and arg_361_1.time_ < var_364_8 + var_364_9 and not isNil(var_364_7) then
				local var_364_10 = (arg_361_1.time_ - var_364_8) / var_364_9

				if arg_361_1.var_.actorSpriteComps10030 then
					for iter_364_1, iter_364_2 in pairs(arg_361_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_364_2 then
							if arg_361_1.isInRecall_ then
								local var_364_11 = Mathf.Lerp(iter_364_2.color.r, arg_361_1.hightColor2.r, var_364_10)
								local var_364_12 = Mathf.Lerp(iter_364_2.color.g, arg_361_1.hightColor2.g, var_364_10)
								local var_364_13 = Mathf.Lerp(iter_364_2.color.b, arg_361_1.hightColor2.b, var_364_10)

								iter_364_2.color = Color.New(var_364_11, var_364_12, var_364_13)
							else
								local var_364_14 = Mathf.Lerp(iter_364_2.color.r, 0.5, var_364_10)

								iter_364_2.color = Color.New(var_364_14, var_364_14, var_364_14)
							end
						end
					end
				end
			end

			if arg_361_1.time_ >= var_364_8 + var_364_9 and arg_361_1.time_ < var_364_8 + var_364_9 + arg_364_0 and not isNil(var_364_7) and arg_361_1.var_.actorSpriteComps10030 then
				for iter_364_3, iter_364_4 in pairs(arg_361_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_364_4 then
						if arg_361_1.isInRecall_ then
							iter_364_4.color = arg_361_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_364_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_361_1.var_.actorSpriteComps10030 = nil
			end

			local var_364_15 = arg_361_1.actors_["1038"]
			local var_364_16 = 0

			if var_364_16 < arg_361_1.time_ and arg_361_1.time_ <= var_364_16 + arg_364_0 and not isNil(var_364_15) and arg_361_1.var_.actorSpriteComps1038 == nil then
				arg_361_1.var_.actorSpriteComps1038 = var_364_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_364_17 = 0.2

			if var_364_16 <= arg_361_1.time_ and arg_361_1.time_ < var_364_16 + var_364_17 and not isNil(var_364_15) then
				local var_364_18 = (arg_361_1.time_ - var_364_16) / var_364_17

				if arg_361_1.var_.actorSpriteComps1038 then
					for iter_364_5, iter_364_6 in pairs(arg_361_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_364_6 then
							if arg_361_1.isInRecall_ then
								local var_364_19 = Mathf.Lerp(iter_364_6.color.r, arg_361_1.hightColor1.r, var_364_18)
								local var_364_20 = Mathf.Lerp(iter_364_6.color.g, arg_361_1.hightColor1.g, var_364_18)
								local var_364_21 = Mathf.Lerp(iter_364_6.color.b, arg_361_1.hightColor1.b, var_364_18)

								iter_364_6.color = Color.New(var_364_19, var_364_20, var_364_21)
							else
								local var_364_22 = Mathf.Lerp(iter_364_6.color.r, 1, var_364_18)

								iter_364_6.color = Color.New(var_364_22, var_364_22, var_364_22)
							end
						end
					end
				end
			end

			if arg_361_1.time_ >= var_364_16 + var_364_17 and arg_361_1.time_ < var_364_16 + var_364_17 + arg_364_0 and not isNil(var_364_15) and arg_361_1.var_.actorSpriteComps1038 then
				for iter_364_7, iter_364_8 in pairs(arg_361_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_364_8 then
						if arg_361_1.isInRecall_ then
							iter_364_8.color = arg_361_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_364_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_361_1.var_.actorSpriteComps1038 = nil
			end

			local var_364_23 = 0
			local var_364_24 = 0.675

			if var_364_23 < arg_361_1.time_ and arg_361_1.time_ <= var_364_23 + arg_364_0 then
				arg_361_1.talkMaxDuration = 0
				arg_361_1.dialogCg_.alpha = 1

				arg_361_1.dialog_:SetActive(true)
				SetActive(arg_361_1.leftNameGo_, true)

				local var_364_25 = arg_361_1:FormatText(StoryNameCfg[94].name)

				arg_361_1.leftNameTxt_.text = var_364_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_361_1.leftNameTxt_.transform)

				arg_361_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_361_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_361_1:RecordName(arg_361_1.leftNameTxt_.text)
				SetActive(arg_361_1.iconTrs_.gameObject, false)
				arg_361_1.callingController_:SetSelectedState("normal")

				local var_364_26 = arg_361_1:GetWordFromCfg(115281085)
				local var_364_27 = arg_361_1:FormatText(var_364_26.content)

				arg_361_1.text_.text = var_364_27

				LuaForUtil.ClearLinePrefixSymbol(arg_361_1.text_)

				local var_364_28 = 27
				local var_364_29 = utf8.len(var_364_27)
				local var_364_30 = var_364_28 <= 0 and var_364_24 or var_364_24 * (var_364_29 / var_364_28)

				if var_364_30 > 0 and var_364_24 < var_364_30 then
					arg_361_1.talkMaxDuration = var_364_30

					if var_364_30 + var_364_23 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_30 + var_364_23
					end
				end

				arg_361_1.text_.text = var_364_27
				arg_361_1.typewritter.percent = 0

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115281", "115281085", "story_v_out_115281.awb") ~= 0 then
					local var_364_31 = manager.audio:GetVoiceLength("story_v_out_115281", "115281085", "story_v_out_115281.awb") / 1000

					if var_364_31 + var_364_23 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_31 + var_364_23
					end

					if var_364_26.prefab_name ~= "" and arg_361_1.actors_[var_364_26.prefab_name] ~= nil then
						local var_364_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_361_1.actors_[var_364_26.prefab_name].transform, "story_v_out_115281", "115281085", "story_v_out_115281.awb")

						arg_361_1:RecordAudio("115281085", var_364_32)
						arg_361_1:RecordAudio("115281085", var_364_32)
					else
						arg_361_1:AudioAction("play", "voice", "story_v_out_115281", "115281085", "story_v_out_115281.awb")
					end

					arg_361_1:RecordHistoryTalkVoice("story_v_out_115281", "115281085", "story_v_out_115281.awb")
				end

				arg_361_1:RecordContent(arg_361_1.text_.text)
			end

			local var_364_33 = math.max(var_364_24, arg_361_1.talkMaxDuration)

			if var_364_23 <= arg_361_1.time_ and arg_361_1.time_ < var_364_23 + var_364_33 then
				arg_361_1.typewritter.percent = (arg_361_1.time_ - var_364_23) / var_364_33

				arg_361_1.typewritter:SetDirty()
			end

			if arg_361_1.time_ >= var_364_23 + var_364_33 and arg_361_1.time_ < var_364_23 + var_364_33 + arg_364_0 then
				arg_361_1.typewritter.percent = 1

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(true)
			end
		end

		arg_361_1.nodeConfigList_ = {
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

		arg_361_1:InitPlayNodeList()
	end,
	Play115281086 = function(arg_365_0, arg_365_1)
		arg_365_1.time_ = 0
		arg_365_1.frameCnt_ = 0
		arg_365_1.state_ = "playing"
		arg_365_1.curTalkId_ = 115281086
		arg_365_1.duration_ = 6.33

		local var_365_0 = {
			ja = 5.433,
			ko = 4.3,
			zh = 5.366,
			en = 6.333
		}
		local var_365_1 = manager.audio:GetLocalizationFlag()

		if var_365_0[var_365_1] ~= nil then
			arg_365_1.duration_ = var_365_0[var_365_1]
		end

		SetActive(arg_365_1.tipsGo_, false)

		function arg_365_1.onSingleLineFinish_()
			arg_365_1.onSingleLineUpdate_ = nil
			arg_365_1.onSingleLineFinish_ = nil
			arg_365_1.state_ = "waiting"
		end

		function arg_365_1.playNext_(arg_367_0)
			if arg_367_0 == 1 then
				arg_365_0:Play115281087(arg_365_1)
			end
		end

		function arg_365_1.onSingleLineUpdate_(arg_368_0)
			local var_368_0 = arg_365_1.actors_["10030"].transform
			local var_368_1 = 0

			if var_368_1 < arg_365_1.time_ and arg_365_1.time_ <= var_368_1 + arg_368_0 then
				arg_365_1.var_.moveOldPos10030 = var_368_0.localPosition
				var_368_0.localScale = Vector3.New(1, 1, 1)

				arg_365_1:CheckSpriteTmpPos("10030", 4)

				local var_368_2 = var_368_0.childCount

				for iter_368_0 = 0, var_368_2 - 1 do
					local var_368_3 = var_368_0:GetChild(iter_368_0)

					if var_368_3.name == "split_4" or not string.find(var_368_3.name, "split") then
						var_368_3.gameObject:SetActive(true)
					else
						var_368_3.gameObject:SetActive(false)
					end
				end
			end

			local var_368_4 = 0.001

			if var_368_1 <= arg_365_1.time_ and arg_365_1.time_ < var_368_1 + var_368_4 then
				local var_368_5 = (arg_365_1.time_ - var_368_1) / var_368_4
				local var_368_6 = Vector3.New(390, -390, 150)

				var_368_0.localPosition = Vector3.Lerp(arg_365_1.var_.moveOldPos10030, var_368_6, var_368_5)
			end

			if arg_365_1.time_ >= var_368_1 + var_368_4 and arg_365_1.time_ < var_368_1 + var_368_4 + arg_368_0 then
				var_368_0.localPosition = Vector3.New(390, -390, 150)
			end

			local var_368_7 = arg_365_1.actors_["10030"]
			local var_368_8 = 0

			if var_368_8 < arg_365_1.time_ and arg_365_1.time_ <= var_368_8 + arg_368_0 and not isNil(var_368_7) and arg_365_1.var_.actorSpriteComps10030 == nil then
				arg_365_1.var_.actorSpriteComps10030 = var_368_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_368_9 = 0.2

			if var_368_8 <= arg_365_1.time_ and arg_365_1.time_ < var_368_8 + var_368_9 and not isNil(var_368_7) then
				local var_368_10 = (arg_365_1.time_ - var_368_8) / var_368_9

				if arg_365_1.var_.actorSpriteComps10030 then
					for iter_368_1, iter_368_2 in pairs(arg_365_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_368_2 then
							if arg_365_1.isInRecall_ then
								local var_368_11 = Mathf.Lerp(iter_368_2.color.r, arg_365_1.hightColor1.r, var_368_10)
								local var_368_12 = Mathf.Lerp(iter_368_2.color.g, arg_365_1.hightColor1.g, var_368_10)
								local var_368_13 = Mathf.Lerp(iter_368_2.color.b, arg_365_1.hightColor1.b, var_368_10)

								iter_368_2.color = Color.New(var_368_11, var_368_12, var_368_13)
							else
								local var_368_14 = Mathf.Lerp(iter_368_2.color.r, 1, var_368_10)

								iter_368_2.color = Color.New(var_368_14, var_368_14, var_368_14)
							end
						end
					end
				end
			end

			if arg_365_1.time_ >= var_368_8 + var_368_9 and arg_365_1.time_ < var_368_8 + var_368_9 + arg_368_0 and not isNil(var_368_7) and arg_365_1.var_.actorSpriteComps10030 then
				for iter_368_3, iter_368_4 in pairs(arg_365_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_368_4 then
						if arg_365_1.isInRecall_ then
							iter_368_4.color = arg_365_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_368_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_365_1.var_.actorSpriteComps10030 = nil
			end

			local var_368_15 = arg_365_1.actors_["1038"]
			local var_368_16 = 0

			if var_368_16 < arg_365_1.time_ and arg_365_1.time_ <= var_368_16 + arg_368_0 and not isNil(var_368_15) and arg_365_1.var_.actorSpriteComps1038 == nil then
				arg_365_1.var_.actorSpriteComps1038 = var_368_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_368_17 = 0.2

			if var_368_16 <= arg_365_1.time_ and arg_365_1.time_ < var_368_16 + var_368_17 and not isNil(var_368_15) then
				local var_368_18 = (arg_365_1.time_ - var_368_16) / var_368_17

				if arg_365_1.var_.actorSpriteComps1038 then
					for iter_368_5, iter_368_6 in pairs(arg_365_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_368_6 then
							if arg_365_1.isInRecall_ then
								local var_368_19 = Mathf.Lerp(iter_368_6.color.r, arg_365_1.hightColor2.r, var_368_18)
								local var_368_20 = Mathf.Lerp(iter_368_6.color.g, arg_365_1.hightColor2.g, var_368_18)
								local var_368_21 = Mathf.Lerp(iter_368_6.color.b, arg_365_1.hightColor2.b, var_368_18)

								iter_368_6.color = Color.New(var_368_19, var_368_20, var_368_21)
							else
								local var_368_22 = Mathf.Lerp(iter_368_6.color.r, 0.5, var_368_18)

								iter_368_6.color = Color.New(var_368_22, var_368_22, var_368_22)
							end
						end
					end
				end
			end

			if arg_365_1.time_ >= var_368_16 + var_368_17 and arg_365_1.time_ < var_368_16 + var_368_17 + arg_368_0 and not isNil(var_368_15) and arg_365_1.var_.actorSpriteComps1038 then
				for iter_368_7, iter_368_8 in pairs(arg_365_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_368_8 then
						if arg_365_1.isInRecall_ then
							iter_368_8.color = arg_365_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_368_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_365_1.var_.actorSpriteComps1038 = nil
			end

			local var_368_23 = 0
			local var_368_24 = 0.425

			if var_368_23 < arg_365_1.time_ and arg_365_1.time_ <= var_368_23 + arg_368_0 then
				arg_365_1.talkMaxDuration = 0
				arg_365_1.dialogCg_.alpha = 1

				arg_365_1.dialog_:SetActive(true)
				SetActive(arg_365_1.leftNameGo_, true)

				local var_368_25 = arg_365_1:FormatText(StoryNameCfg[309].name)

				arg_365_1.leftNameTxt_.text = var_368_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_365_1.leftNameTxt_.transform)

				arg_365_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_365_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_365_1:RecordName(arg_365_1.leftNameTxt_.text)
				SetActive(arg_365_1.iconTrs_.gameObject, false)
				arg_365_1.callingController_:SetSelectedState("normal")

				local var_368_26 = arg_365_1:GetWordFromCfg(115281086)
				local var_368_27 = arg_365_1:FormatText(var_368_26.content)

				arg_365_1.text_.text = var_368_27

				LuaForUtil.ClearLinePrefixSymbol(arg_365_1.text_)

				local var_368_28 = 17
				local var_368_29 = utf8.len(var_368_27)
				local var_368_30 = var_368_28 <= 0 and var_368_24 or var_368_24 * (var_368_29 / var_368_28)

				if var_368_30 > 0 and var_368_24 < var_368_30 then
					arg_365_1.talkMaxDuration = var_368_30

					if var_368_30 + var_368_23 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_30 + var_368_23
					end
				end

				arg_365_1.text_.text = var_368_27
				arg_365_1.typewritter.percent = 0

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115281", "115281086", "story_v_out_115281.awb") ~= 0 then
					local var_368_31 = manager.audio:GetVoiceLength("story_v_out_115281", "115281086", "story_v_out_115281.awb") / 1000

					if var_368_31 + var_368_23 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_31 + var_368_23
					end

					if var_368_26.prefab_name ~= "" and arg_365_1.actors_[var_368_26.prefab_name] ~= nil then
						local var_368_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_365_1.actors_[var_368_26.prefab_name].transform, "story_v_out_115281", "115281086", "story_v_out_115281.awb")

						arg_365_1:RecordAudio("115281086", var_368_32)
						arg_365_1:RecordAudio("115281086", var_368_32)
					else
						arg_365_1:AudioAction("play", "voice", "story_v_out_115281", "115281086", "story_v_out_115281.awb")
					end

					arg_365_1:RecordHistoryTalkVoice("story_v_out_115281", "115281086", "story_v_out_115281.awb")
				end

				arg_365_1:RecordContent(arg_365_1.text_.text)
			end

			local var_368_33 = math.max(var_368_24, arg_365_1.talkMaxDuration)

			if var_368_23 <= arg_365_1.time_ and arg_365_1.time_ < var_368_23 + var_368_33 then
				arg_365_1.typewritter.percent = (arg_365_1.time_ - var_368_23) / var_368_33

				arg_365_1.typewritter:SetDirty()
			end

			if arg_365_1.time_ >= var_368_23 + var_368_33 and arg_365_1.time_ < var_368_23 + var_368_33 + arg_368_0 then
				arg_365_1.typewritter.percent = 1

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(true)
			end
		end

		arg_365_1.nodeConfigList_ = {
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

		arg_365_1:InitPlayNodeList()
	end,
	Play115281087 = function(arg_369_0, arg_369_1)
		arg_369_1.time_ = 0
		arg_369_1.frameCnt_ = 0
		arg_369_1.state_ = "playing"
		arg_369_1.curTalkId_ = 115281087
		arg_369_1.duration_ = 5.9

		local var_369_0 = {
			ja = 4.3,
			ko = 3.866,
			zh = 3.833,
			en = 5.9
		}
		local var_369_1 = manager.audio:GetLocalizationFlag()

		if var_369_0[var_369_1] ~= nil then
			arg_369_1.duration_ = var_369_0[var_369_1]
		end

		SetActive(arg_369_1.tipsGo_, false)

		function arg_369_1.onSingleLineFinish_()
			arg_369_1.onSingleLineUpdate_ = nil
			arg_369_1.onSingleLineFinish_ = nil
			arg_369_1.state_ = "waiting"
		end

		function arg_369_1.playNext_(arg_371_0)
			if arg_371_0 == 1 then
				arg_369_0:Play115281088(arg_369_1)
			end
		end

		function arg_369_1.onSingleLineUpdate_(arg_372_0)
			local var_372_0 = arg_369_1.actors_["10030"].transform
			local var_372_1 = 0

			if var_372_1 < arg_369_1.time_ and arg_369_1.time_ <= var_372_1 + arg_372_0 then
				arg_369_1.var_.moveOldPos10030 = var_372_0.localPosition
				var_372_0.localScale = Vector3.New(1, 1, 1)

				arg_369_1:CheckSpriteTmpPos("10030", 4)

				local var_372_2 = var_372_0.childCount

				for iter_372_0 = 0, var_372_2 - 1 do
					local var_372_3 = var_372_0:GetChild(iter_372_0)

					if var_372_3.name == "split_3" or not string.find(var_372_3.name, "split") then
						var_372_3.gameObject:SetActive(true)
					else
						var_372_3.gameObject:SetActive(false)
					end
				end
			end

			local var_372_4 = 0.001

			if var_372_1 <= arg_369_1.time_ and arg_369_1.time_ < var_372_1 + var_372_4 then
				local var_372_5 = (arg_369_1.time_ - var_372_1) / var_372_4
				local var_372_6 = Vector3.New(390, -390, 150)

				var_372_0.localPosition = Vector3.Lerp(arg_369_1.var_.moveOldPos10030, var_372_6, var_372_5)
			end

			if arg_369_1.time_ >= var_372_1 + var_372_4 and arg_369_1.time_ < var_372_1 + var_372_4 + arg_372_0 then
				var_372_0.localPosition = Vector3.New(390, -390, 150)
			end

			local var_372_7 = arg_369_1.actors_["10030"]
			local var_372_8 = 0

			if var_372_8 < arg_369_1.time_ and arg_369_1.time_ <= var_372_8 + arg_372_0 and not isNil(var_372_7) and arg_369_1.var_.actorSpriteComps10030 == nil then
				arg_369_1.var_.actorSpriteComps10030 = var_372_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_372_9 = 0.0166666666666667

			if var_372_8 <= arg_369_1.time_ and arg_369_1.time_ < var_372_8 + var_372_9 and not isNil(var_372_7) then
				local var_372_10 = (arg_369_1.time_ - var_372_8) / var_372_9

				if arg_369_1.var_.actorSpriteComps10030 then
					for iter_372_1, iter_372_2 in pairs(arg_369_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_372_2 then
							if arg_369_1.isInRecall_ then
								local var_372_11 = Mathf.Lerp(iter_372_2.color.r, arg_369_1.hightColor1.r, var_372_10)
								local var_372_12 = Mathf.Lerp(iter_372_2.color.g, arg_369_1.hightColor1.g, var_372_10)
								local var_372_13 = Mathf.Lerp(iter_372_2.color.b, arg_369_1.hightColor1.b, var_372_10)

								iter_372_2.color = Color.New(var_372_11, var_372_12, var_372_13)
							else
								local var_372_14 = Mathf.Lerp(iter_372_2.color.r, 1, var_372_10)

								iter_372_2.color = Color.New(var_372_14, var_372_14, var_372_14)
							end
						end
					end
				end
			end

			if arg_369_1.time_ >= var_372_8 + var_372_9 and arg_369_1.time_ < var_372_8 + var_372_9 + arg_372_0 and not isNil(var_372_7) and arg_369_1.var_.actorSpriteComps10030 then
				for iter_372_3, iter_372_4 in pairs(arg_369_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_372_4 then
						if arg_369_1.isInRecall_ then
							iter_372_4.color = arg_369_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_372_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_369_1.var_.actorSpriteComps10030 = nil
			end

			local var_372_15 = 0
			local var_372_16 = 0.5

			if var_372_15 < arg_369_1.time_ and arg_369_1.time_ <= var_372_15 + arg_372_0 then
				arg_369_1.talkMaxDuration = 0
				arg_369_1.dialogCg_.alpha = 1

				arg_369_1.dialog_:SetActive(true)
				SetActive(arg_369_1.leftNameGo_, true)

				local var_372_17 = arg_369_1:FormatText(StoryNameCfg[309].name)

				arg_369_1.leftNameTxt_.text = var_372_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_369_1.leftNameTxt_.transform)

				arg_369_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_369_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_369_1:RecordName(arg_369_1.leftNameTxt_.text)
				SetActive(arg_369_1.iconTrs_.gameObject, false)
				arg_369_1.callingController_:SetSelectedState("normal")

				local var_372_18 = arg_369_1:GetWordFromCfg(115281087)
				local var_372_19 = arg_369_1:FormatText(var_372_18.content)

				arg_369_1.text_.text = var_372_19

				LuaForUtil.ClearLinePrefixSymbol(arg_369_1.text_)

				local var_372_20 = 20
				local var_372_21 = utf8.len(var_372_19)
				local var_372_22 = var_372_20 <= 0 and var_372_16 or var_372_16 * (var_372_21 / var_372_20)

				if var_372_22 > 0 and var_372_16 < var_372_22 then
					arg_369_1.talkMaxDuration = var_372_22

					if var_372_22 + var_372_15 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_22 + var_372_15
					end
				end

				arg_369_1.text_.text = var_372_19
				arg_369_1.typewritter.percent = 0

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115281", "115281087", "story_v_out_115281.awb") ~= 0 then
					local var_372_23 = manager.audio:GetVoiceLength("story_v_out_115281", "115281087", "story_v_out_115281.awb") / 1000

					if var_372_23 + var_372_15 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_23 + var_372_15
					end

					if var_372_18.prefab_name ~= "" and arg_369_1.actors_[var_372_18.prefab_name] ~= nil then
						local var_372_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_369_1.actors_[var_372_18.prefab_name].transform, "story_v_out_115281", "115281087", "story_v_out_115281.awb")

						arg_369_1:RecordAudio("115281087", var_372_24)
						arg_369_1:RecordAudio("115281087", var_372_24)
					else
						arg_369_1:AudioAction("play", "voice", "story_v_out_115281", "115281087", "story_v_out_115281.awb")
					end

					arg_369_1:RecordHistoryTalkVoice("story_v_out_115281", "115281087", "story_v_out_115281.awb")
				end

				arg_369_1:RecordContent(arg_369_1.text_.text)
			end

			local var_372_25 = math.max(var_372_16, arg_369_1.talkMaxDuration)

			if var_372_15 <= arg_369_1.time_ and arg_369_1.time_ < var_372_15 + var_372_25 then
				arg_369_1.typewritter.percent = (arg_369_1.time_ - var_372_15) / var_372_25

				arg_369_1.typewritter:SetDirty()
			end

			if arg_369_1.time_ >= var_372_15 + var_372_25 and arg_369_1.time_ < var_372_15 + var_372_25 + arg_372_0 then
				arg_369_1.typewritter.percent = 1

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(true)
			end
		end

		arg_369_1.nodeConfigList_ = {
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

		arg_369_1:InitPlayNodeList()
	end,
	Play115281088 = function(arg_373_0, arg_373_1)
		arg_373_1.time_ = 0
		arg_373_1.frameCnt_ = 0
		arg_373_1.state_ = "playing"
		arg_373_1.curTalkId_ = 115281088
		arg_373_1.duration_ = 11.4

		local var_373_0 = {
			ja = 10.566,
			ko = 8.433,
			zh = 8.466,
			en = 11.4
		}
		local var_373_1 = manager.audio:GetLocalizationFlag()

		if var_373_0[var_373_1] ~= nil then
			arg_373_1.duration_ = var_373_0[var_373_1]
		end

		SetActive(arg_373_1.tipsGo_, false)

		function arg_373_1.onSingleLineFinish_()
			arg_373_1.onSingleLineUpdate_ = nil
			arg_373_1.onSingleLineFinish_ = nil
			arg_373_1.state_ = "waiting"
		end

		function arg_373_1.playNext_(arg_375_0)
			if arg_375_0 == 1 then
				arg_373_0:Play115281089(arg_373_1)
			end
		end

		function arg_373_1.onSingleLineUpdate_(arg_376_0)
			local var_376_0 = arg_373_1.actors_["1038"].transform
			local var_376_1 = 0

			if var_376_1 < arg_373_1.time_ and arg_373_1.time_ <= var_376_1 + arg_376_0 then
				arg_373_1.var_.moveOldPos1038 = var_376_0.localPosition
				var_376_0.localScale = Vector3.New(1, 1, 1)

				arg_373_1:CheckSpriteTmpPos("1038", 2)

				local var_376_2 = var_376_0.childCount

				for iter_376_0 = 0, var_376_2 - 1 do
					local var_376_3 = var_376_0:GetChild(iter_376_0)

					if var_376_3.name == "split_1" or not string.find(var_376_3.name, "split") then
						var_376_3.gameObject:SetActive(true)
					else
						var_376_3.gameObject:SetActive(false)
					end
				end
			end

			local var_376_4 = 0.001

			if var_376_1 <= arg_373_1.time_ and arg_373_1.time_ < var_376_1 + var_376_4 then
				local var_376_5 = (arg_373_1.time_ - var_376_1) / var_376_4
				local var_376_6 = Vector3.New(-390, -400, 0)

				var_376_0.localPosition = Vector3.Lerp(arg_373_1.var_.moveOldPos1038, var_376_6, var_376_5)
			end

			if arg_373_1.time_ >= var_376_1 + var_376_4 and arg_373_1.time_ < var_376_1 + var_376_4 + arg_376_0 then
				var_376_0.localPosition = Vector3.New(-390, -400, 0)
			end

			local var_376_7 = arg_373_1.actors_["10030"]
			local var_376_8 = 0

			if var_376_8 < arg_373_1.time_ and arg_373_1.time_ <= var_376_8 + arg_376_0 and not isNil(var_376_7) and arg_373_1.var_.actorSpriteComps10030 == nil then
				arg_373_1.var_.actorSpriteComps10030 = var_376_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_376_9 = 0.2

			if var_376_8 <= arg_373_1.time_ and arg_373_1.time_ < var_376_8 + var_376_9 and not isNil(var_376_7) then
				local var_376_10 = (arg_373_1.time_ - var_376_8) / var_376_9

				if arg_373_1.var_.actorSpriteComps10030 then
					for iter_376_1, iter_376_2 in pairs(arg_373_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_376_2 then
							if arg_373_1.isInRecall_ then
								local var_376_11 = Mathf.Lerp(iter_376_2.color.r, arg_373_1.hightColor2.r, var_376_10)
								local var_376_12 = Mathf.Lerp(iter_376_2.color.g, arg_373_1.hightColor2.g, var_376_10)
								local var_376_13 = Mathf.Lerp(iter_376_2.color.b, arg_373_1.hightColor2.b, var_376_10)

								iter_376_2.color = Color.New(var_376_11, var_376_12, var_376_13)
							else
								local var_376_14 = Mathf.Lerp(iter_376_2.color.r, 0.5, var_376_10)

								iter_376_2.color = Color.New(var_376_14, var_376_14, var_376_14)
							end
						end
					end
				end
			end

			if arg_373_1.time_ >= var_376_8 + var_376_9 and arg_373_1.time_ < var_376_8 + var_376_9 + arg_376_0 and not isNil(var_376_7) and arg_373_1.var_.actorSpriteComps10030 then
				for iter_376_3, iter_376_4 in pairs(arg_373_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_376_4 then
						if arg_373_1.isInRecall_ then
							iter_376_4.color = arg_373_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_376_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_373_1.var_.actorSpriteComps10030 = nil
			end

			local var_376_15 = arg_373_1.actors_["1038"]
			local var_376_16 = 0

			if var_376_16 < arg_373_1.time_ and arg_373_1.time_ <= var_376_16 + arg_376_0 and not isNil(var_376_15) and arg_373_1.var_.actorSpriteComps1038 == nil then
				arg_373_1.var_.actorSpriteComps1038 = var_376_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_376_17 = 0.2

			if var_376_16 <= arg_373_1.time_ and arg_373_1.time_ < var_376_16 + var_376_17 and not isNil(var_376_15) then
				local var_376_18 = (arg_373_1.time_ - var_376_16) / var_376_17

				if arg_373_1.var_.actorSpriteComps1038 then
					for iter_376_5, iter_376_6 in pairs(arg_373_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_376_6 then
							if arg_373_1.isInRecall_ then
								local var_376_19 = Mathf.Lerp(iter_376_6.color.r, arg_373_1.hightColor1.r, var_376_18)
								local var_376_20 = Mathf.Lerp(iter_376_6.color.g, arg_373_1.hightColor1.g, var_376_18)
								local var_376_21 = Mathf.Lerp(iter_376_6.color.b, arg_373_1.hightColor1.b, var_376_18)

								iter_376_6.color = Color.New(var_376_19, var_376_20, var_376_21)
							else
								local var_376_22 = Mathf.Lerp(iter_376_6.color.r, 1, var_376_18)

								iter_376_6.color = Color.New(var_376_22, var_376_22, var_376_22)
							end
						end
					end
				end
			end

			if arg_373_1.time_ >= var_376_16 + var_376_17 and arg_373_1.time_ < var_376_16 + var_376_17 + arg_376_0 and not isNil(var_376_15) and arg_373_1.var_.actorSpriteComps1038 then
				for iter_376_7, iter_376_8 in pairs(arg_373_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_376_8 then
						if arg_373_1.isInRecall_ then
							iter_376_8.color = arg_373_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_376_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_373_1.var_.actorSpriteComps1038 = nil
			end

			local var_376_23 = 0
			local var_376_24 = 0.75

			if var_376_23 < arg_373_1.time_ and arg_373_1.time_ <= var_376_23 + arg_376_0 then
				arg_373_1.talkMaxDuration = 0
				arg_373_1.dialogCg_.alpha = 1

				arg_373_1.dialog_:SetActive(true)
				SetActive(arg_373_1.leftNameGo_, true)

				local var_376_25 = arg_373_1:FormatText(StoryNameCfg[94].name)

				arg_373_1.leftNameTxt_.text = var_376_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_373_1.leftNameTxt_.transform)

				arg_373_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_373_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_373_1:RecordName(arg_373_1.leftNameTxt_.text)
				SetActive(arg_373_1.iconTrs_.gameObject, false)
				arg_373_1.callingController_:SetSelectedState("normal")

				local var_376_26 = arg_373_1:GetWordFromCfg(115281088)
				local var_376_27 = arg_373_1:FormatText(var_376_26.content)

				arg_373_1.text_.text = var_376_27

				LuaForUtil.ClearLinePrefixSymbol(arg_373_1.text_)

				local var_376_28 = 30
				local var_376_29 = utf8.len(var_376_27)
				local var_376_30 = var_376_28 <= 0 and var_376_24 or var_376_24 * (var_376_29 / var_376_28)

				if var_376_30 > 0 and var_376_24 < var_376_30 then
					arg_373_1.talkMaxDuration = var_376_30

					if var_376_30 + var_376_23 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_30 + var_376_23
					end
				end

				arg_373_1.text_.text = var_376_27
				arg_373_1.typewritter.percent = 0

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115281", "115281088", "story_v_out_115281.awb") ~= 0 then
					local var_376_31 = manager.audio:GetVoiceLength("story_v_out_115281", "115281088", "story_v_out_115281.awb") / 1000

					if var_376_31 + var_376_23 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_31 + var_376_23
					end

					if var_376_26.prefab_name ~= "" and arg_373_1.actors_[var_376_26.prefab_name] ~= nil then
						local var_376_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_373_1.actors_[var_376_26.prefab_name].transform, "story_v_out_115281", "115281088", "story_v_out_115281.awb")

						arg_373_1:RecordAudio("115281088", var_376_32)
						arg_373_1:RecordAudio("115281088", var_376_32)
					else
						arg_373_1:AudioAction("play", "voice", "story_v_out_115281", "115281088", "story_v_out_115281.awb")
					end

					arg_373_1:RecordHistoryTalkVoice("story_v_out_115281", "115281088", "story_v_out_115281.awb")
				end

				arg_373_1:RecordContent(arg_373_1.text_.text)
			end

			local var_376_33 = math.max(var_376_24, arg_373_1.talkMaxDuration)

			if var_376_23 <= arg_373_1.time_ and arg_373_1.time_ < var_376_23 + var_376_33 then
				arg_373_1.typewritter.percent = (arg_373_1.time_ - var_376_23) / var_376_33

				arg_373_1.typewritter:SetDirty()
			end

			if arg_373_1.time_ >= var_376_23 + var_376_33 and arg_373_1.time_ < var_376_23 + var_376_33 + arg_376_0 then
				arg_373_1.typewritter.percent = 1

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(true)
			end
		end

		arg_373_1.nodeConfigList_ = {
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

		arg_373_1:InitPlayNodeList()
	end,
	Play115281089 = function(arg_377_0, arg_377_1)
		arg_377_1.time_ = 0
		arg_377_1.frameCnt_ = 0
		arg_377_1.state_ = "playing"
		arg_377_1.curTalkId_ = 115281089
		arg_377_1.duration_ = 13.93

		local var_377_0 = {
			ja = 13.933,
			ko = 12.433,
			zh = 12.7,
			en = 12.633
		}
		local var_377_1 = manager.audio:GetLocalizationFlag()

		if var_377_0[var_377_1] ~= nil then
			arg_377_1.duration_ = var_377_0[var_377_1]
		end

		SetActive(arg_377_1.tipsGo_, false)

		function arg_377_1.onSingleLineFinish_()
			arg_377_1.onSingleLineUpdate_ = nil
			arg_377_1.onSingleLineFinish_ = nil
			arg_377_1.state_ = "waiting"
		end

		function arg_377_1.playNext_(arg_379_0)
			if arg_379_0 == 1 then
				arg_377_0:Play115281090(arg_377_1)
			end
		end

		function arg_377_1.onSingleLineUpdate_(arg_380_0)
			local var_380_0 = 0
			local var_380_1 = 1.15

			if var_380_0 < arg_377_1.time_ and arg_377_1.time_ <= var_380_0 + arg_380_0 then
				arg_377_1.talkMaxDuration = 0
				arg_377_1.dialogCg_.alpha = 1

				arg_377_1.dialog_:SetActive(true)
				SetActive(arg_377_1.leftNameGo_, true)

				local var_380_2 = arg_377_1:FormatText(StoryNameCfg[94].name)

				arg_377_1.leftNameTxt_.text = var_380_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_377_1.leftNameTxt_.transform)

				arg_377_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_377_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_377_1:RecordName(arg_377_1.leftNameTxt_.text)
				SetActive(arg_377_1.iconTrs_.gameObject, false)
				arg_377_1.callingController_:SetSelectedState("normal")

				local var_380_3 = arg_377_1:GetWordFromCfg(115281089)
				local var_380_4 = arg_377_1:FormatText(var_380_3.content)

				arg_377_1.text_.text = var_380_4

				LuaForUtil.ClearLinePrefixSymbol(arg_377_1.text_)

				local var_380_5 = 50
				local var_380_6 = utf8.len(var_380_4)
				local var_380_7 = var_380_5 <= 0 and var_380_1 or var_380_1 * (var_380_6 / var_380_5)

				if var_380_7 > 0 and var_380_1 < var_380_7 then
					arg_377_1.talkMaxDuration = var_380_7

					if var_380_7 + var_380_0 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_7 + var_380_0
					end
				end

				arg_377_1.text_.text = var_380_4
				arg_377_1.typewritter.percent = 0

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115281", "115281089", "story_v_out_115281.awb") ~= 0 then
					local var_380_8 = manager.audio:GetVoiceLength("story_v_out_115281", "115281089", "story_v_out_115281.awb") / 1000

					if var_380_8 + var_380_0 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_8 + var_380_0
					end

					if var_380_3.prefab_name ~= "" and arg_377_1.actors_[var_380_3.prefab_name] ~= nil then
						local var_380_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_377_1.actors_[var_380_3.prefab_name].transform, "story_v_out_115281", "115281089", "story_v_out_115281.awb")

						arg_377_1:RecordAudio("115281089", var_380_9)
						arg_377_1:RecordAudio("115281089", var_380_9)
					else
						arg_377_1:AudioAction("play", "voice", "story_v_out_115281", "115281089", "story_v_out_115281.awb")
					end

					arg_377_1:RecordHistoryTalkVoice("story_v_out_115281", "115281089", "story_v_out_115281.awb")
				end

				arg_377_1:RecordContent(arg_377_1.text_.text)
			end

			local var_380_10 = math.max(var_380_1, arg_377_1.talkMaxDuration)

			if var_380_0 <= arg_377_1.time_ and arg_377_1.time_ < var_380_0 + var_380_10 then
				arg_377_1.typewritter.percent = (arg_377_1.time_ - var_380_0) / var_380_10

				arg_377_1.typewritter:SetDirty()
			end

			if arg_377_1.time_ >= var_380_0 + var_380_10 and arg_377_1.time_ < var_380_0 + var_380_10 + arg_380_0 then
				arg_377_1.typewritter.percent = 1

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(true)
			end
		end

		arg_377_1.nodeConfigList_ = {}

		arg_377_1:InitPlayNodeList()
	end,
	Play115281090 = function(arg_381_0, arg_381_1)
		arg_381_1.time_ = 0
		arg_381_1.frameCnt_ = 0
		arg_381_1.state_ = "playing"
		arg_381_1.curTalkId_ = 115281090
		arg_381_1.duration_ = 5

		SetActive(arg_381_1.tipsGo_, false)

		function arg_381_1.onSingleLineFinish_()
			arg_381_1.onSingleLineUpdate_ = nil
			arg_381_1.onSingleLineFinish_ = nil
			arg_381_1.state_ = "waiting"
		end

		function arg_381_1.playNext_(arg_383_0)
			if arg_383_0 == 1 then
				arg_381_0:Play115281091(arg_381_1)
			end
		end

		function arg_381_1.onSingleLineUpdate_(arg_384_0)
			local var_384_0 = arg_381_1.actors_["1038"]
			local var_384_1 = 0

			if var_384_1 < arg_381_1.time_ and arg_381_1.time_ <= var_384_1 + arg_384_0 then
				local var_384_2 = var_384_0:GetComponentInChildren(typeof(CanvasGroup))

				if var_384_2 then
					arg_381_1.var_.alphaOldValue1038 = var_384_2.alpha
					arg_381_1.var_.characterEffect1038 = var_384_2
				end

				arg_381_1.var_.alphaOldValue1038 = 1
			end

			local var_384_3 = 0.333333333333333

			if var_384_1 <= arg_381_1.time_ and arg_381_1.time_ < var_384_1 + var_384_3 then
				local var_384_4 = (arg_381_1.time_ - var_384_1) / var_384_3
				local var_384_5 = Mathf.Lerp(arg_381_1.var_.alphaOldValue1038, 0, var_384_4)

				if arg_381_1.var_.characterEffect1038 then
					arg_381_1.var_.characterEffect1038.alpha = var_384_5
				end
			end

			if arg_381_1.time_ >= var_384_1 + var_384_3 and arg_381_1.time_ < var_384_1 + var_384_3 + arg_384_0 and arg_381_1.var_.characterEffect1038 then
				arg_381_1.var_.characterEffect1038.alpha = 0
			end

			local var_384_6 = arg_381_1.actors_["10030"]
			local var_384_7 = 0

			if var_384_7 < arg_381_1.time_ and arg_381_1.time_ <= var_384_7 + arg_384_0 then
				local var_384_8 = var_384_6:GetComponentInChildren(typeof(CanvasGroup))

				if var_384_8 then
					arg_381_1.var_.alphaOldValue10030 = var_384_8.alpha
					arg_381_1.var_.characterEffect10030 = var_384_8
				end

				arg_381_1.var_.alphaOldValue10030 = 1
			end

			local var_384_9 = 0.333333333333333

			if var_384_7 <= arg_381_1.time_ and arg_381_1.time_ < var_384_7 + var_384_9 then
				local var_384_10 = (arg_381_1.time_ - var_384_7) / var_384_9
				local var_384_11 = Mathf.Lerp(arg_381_1.var_.alphaOldValue10030, 0, var_384_10)

				if arg_381_1.var_.characterEffect10030 then
					arg_381_1.var_.characterEffect10030.alpha = var_384_11
				end
			end

			if arg_381_1.time_ >= var_384_7 + var_384_9 and arg_381_1.time_ < var_384_7 + var_384_9 + arg_384_0 and arg_381_1.var_.characterEffect10030 then
				arg_381_1.var_.characterEffect10030.alpha = 0
			end

			local var_384_12 = 0
			local var_384_13 = 0.25

			if var_384_12 < arg_381_1.time_ and arg_381_1.time_ <= var_384_12 + arg_384_0 then
				arg_381_1.talkMaxDuration = 0
				arg_381_1.dialogCg_.alpha = 1

				arg_381_1.dialog_:SetActive(true)
				SetActive(arg_381_1.leftNameGo_, false)

				arg_381_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_381_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_381_1:RecordName(arg_381_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_381_1.iconTrs_.gameObject, false)
				arg_381_1.callingController_:SetSelectedState("normal")

				local var_384_14 = arg_381_1:GetWordFromCfg(115281090)
				local var_384_15 = arg_381_1:FormatText(var_384_14.content)

				arg_381_1.text_.text = var_384_15

				LuaForUtil.ClearLinePrefixSymbol(arg_381_1.text_)

				local var_384_16 = 10
				local var_384_17 = utf8.len(var_384_15)
				local var_384_18 = var_384_16 <= 0 and var_384_13 or var_384_13 * (var_384_17 / var_384_16)

				if var_384_18 > 0 and var_384_13 < var_384_18 then
					arg_381_1.talkMaxDuration = var_384_18

					if var_384_18 + var_384_12 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_18 + var_384_12
					end
				end

				arg_381_1.text_.text = var_384_15
				arg_381_1.typewritter.percent = 0

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(false)
				arg_381_1:RecordContent(arg_381_1.text_.text)
			end

			local var_384_19 = math.max(var_384_13, arg_381_1.talkMaxDuration)

			if var_384_12 <= arg_381_1.time_ and arg_381_1.time_ < var_384_12 + var_384_19 then
				arg_381_1.typewritter.percent = (arg_381_1.time_ - var_384_12) / var_384_19

				arg_381_1.typewritter:SetDirty()
			end

			if arg_381_1.time_ >= var_384_12 + var_384_19 and arg_381_1.time_ < var_384_12 + var_384_19 + arg_384_0 then
				arg_381_1.typewritter.percent = 1

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(true)
			end
		end

		arg_381_1.nodeConfigList_ = {}

		arg_381_1:InitPlayNodeList()
	end,
	Play115281091 = function(arg_385_0, arg_385_1)
		arg_385_1.time_ = 0
		arg_385_1.frameCnt_ = 0
		arg_385_1.state_ = "playing"
		arg_385_1.curTalkId_ = 115281091
		arg_385_1.duration_ = 11.8

		local var_385_0 = {
			ja = 11.1,
			ko = 11.533,
			zh = 11.8,
			en = 9.5
		}
		local var_385_1 = manager.audio:GetLocalizationFlag()

		if var_385_0[var_385_1] ~= nil then
			arg_385_1.duration_ = var_385_0[var_385_1]
		end

		SetActive(arg_385_1.tipsGo_, false)

		function arg_385_1.onSingleLineFinish_()
			arg_385_1.onSingleLineUpdate_ = nil
			arg_385_1.onSingleLineFinish_ = nil
			arg_385_1.state_ = "waiting"
		end

		function arg_385_1.playNext_(arg_387_0)
			if arg_387_0 == 1 then
				arg_385_0:Play115281092(arg_385_1)
			end
		end

		function arg_385_1.onSingleLineUpdate_(arg_388_0)
			local var_388_0 = arg_385_1.actors_["1038"].transform
			local var_388_1 = 0

			if var_388_1 < arg_385_1.time_ and arg_385_1.time_ <= var_388_1 + arg_388_0 then
				arg_385_1.var_.moveOldPos1038 = var_388_0.localPosition
				var_388_0.localScale = Vector3.New(1, 1, 1)

				arg_385_1:CheckSpriteTmpPos("1038", 3)

				local var_388_2 = var_388_0.childCount

				for iter_388_0 = 0, var_388_2 - 1 do
					local var_388_3 = var_388_0:GetChild(iter_388_0)

					if var_388_3.name == "split_1" or not string.find(var_388_3.name, "split") then
						var_388_3.gameObject:SetActive(true)
					else
						var_388_3.gameObject:SetActive(false)
					end
				end
			end

			local var_388_4 = 0.001

			if var_388_1 <= arg_385_1.time_ and arg_385_1.time_ < var_388_1 + var_388_4 then
				local var_388_5 = (arg_385_1.time_ - var_388_1) / var_388_4
				local var_388_6 = Vector3.New(0, -400, 0)

				var_388_0.localPosition = Vector3.Lerp(arg_385_1.var_.moveOldPos1038, var_388_6, var_388_5)
			end

			if arg_385_1.time_ >= var_388_1 + var_388_4 and arg_385_1.time_ < var_388_1 + var_388_4 + arg_388_0 then
				var_388_0.localPosition = Vector3.New(0, -400, 0)
			end

			local var_388_7 = arg_385_1.actors_["1038"]
			local var_388_8 = 0

			if var_388_8 < arg_385_1.time_ and arg_385_1.time_ <= var_388_8 + arg_388_0 and not isNil(var_388_7) and arg_385_1.var_.actorSpriteComps1038 == nil then
				arg_385_1.var_.actorSpriteComps1038 = var_388_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_388_9 = 0.2

			if var_388_8 <= arg_385_1.time_ and arg_385_1.time_ < var_388_8 + var_388_9 and not isNil(var_388_7) then
				local var_388_10 = (arg_385_1.time_ - var_388_8) / var_388_9

				if arg_385_1.var_.actorSpriteComps1038 then
					for iter_388_1, iter_388_2 in pairs(arg_385_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_388_2 then
							if arg_385_1.isInRecall_ then
								local var_388_11 = Mathf.Lerp(iter_388_2.color.r, arg_385_1.hightColor1.r, var_388_10)
								local var_388_12 = Mathf.Lerp(iter_388_2.color.g, arg_385_1.hightColor1.g, var_388_10)
								local var_388_13 = Mathf.Lerp(iter_388_2.color.b, arg_385_1.hightColor1.b, var_388_10)

								iter_388_2.color = Color.New(var_388_11, var_388_12, var_388_13)
							else
								local var_388_14 = Mathf.Lerp(iter_388_2.color.r, 1, var_388_10)

								iter_388_2.color = Color.New(var_388_14, var_388_14, var_388_14)
							end
						end
					end
				end
			end

			if arg_385_1.time_ >= var_388_8 + var_388_9 and arg_385_1.time_ < var_388_8 + var_388_9 + arg_388_0 and not isNil(var_388_7) and arg_385_1.var_.actorSpriteComps1038 then
				for iter_388_3, iter_388_4 in pairs(arg_385_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_388_4 then
						if arg_385_1.isInRecall_ then
							iter_388_4.color = arg_385_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_388_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_385_1.var_.actorSpriteComps1038 = nil
			end

			local var_388_15 = arg_385_1.actors_["1038"]
			local var_388_16 = 0

			if var_388_16 < arg_385_1.time_ and arg_385_1.time_ <= var_388_16 + arg_388_0 then
				local var_388_17 = var_388_15:GetComponentInChildren(typeof(CanvasGroup))

				if var_388_17 then
					arg_385_1.var_.alphaOldValue1038 = var_388_17.alpha
					arg_385_1.var_.characterEffect1038 = var_388_17
				end

				arg_385_1.var_.alphaOldValue1038 = 0
			end

			local var_388_18 = 0.333333333333333

			if var_388_16 <= arg_385_1.time_ and arg_385_1.time_ < var_388_16 + var_388_18 then
				local var_388_19 = (arg_385_1.time_ - var_388_16) / var_388_18
				local var_388_20 = Mathf.Lerp(arg_385_1.var_.alphaOldValue1038, 1, var_388_19)

				if arg_385_1.var_.characterEffect1038 then
					arg_385_1.var_.characterEffect1038.alpha = var_388_20
				end
			end

			if arg_385_1.time_ >= var_388_16 + var_388_18 and arg_385_1.time_ < var_388_16 + var_388_18 + arg_388_0 and arg_385_1.var_.characterEffect1038 then
				arg_385_1.var_.characterEffect1038.alpha = 1
			end

			local var_388_21 = 0
			local var_388_22 = 1.15

			if var_388_21 < arg_385_1.time_ and arg_385_1.time_ <= var_388_21 + arg_388_0 then
				arg_385_1.talkMaxDuration = 0
				arg_385_1.dialogCg_.alpha = 1

				arg_385_1.dialog_:SetActive(true)
				SetActive(arg_385_1.leftNameGo_, true)

				local var_388_23 = arg_385_1:FormatText(StoryNameCfg[94].name)

				arg_385_1.leftNameTxt_.text = var_388_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_385_1.leftNameTxt_.transform)

				arg_385_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_385_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_385_1:RecordName(arg_385_1.leftNameTxt_.text)
				SetActive(arg_385_1.iconTrs_.gameObject, false)
				arg_385_1.callingController_:SetSelectedState("normal")

				local var_388_24 = arg_385_1:GetWordFromCfg(115281091)
				local var_388_25 = arg_385_1:FormatText(var_388_24.content)

				arg_385_1.text_.text = var_388_25

				LuaForUtil.ClearLinePrefixSymbol(arg_385_1.text_)

				local var_388_26 = 46
				local var_388_27 = utf8.len(var_388_25)
				local var_388_28 = var_388_26 <= 0 and var_388_22 or var_388_22 * (var_388_27 / var_388_26)

				if var_388_28 > 0 and var_388_22 < var_388_28 then
					arg_385_1.talkMaxDuration = var_388_28

					if var_388_28 + var_388_21 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_28 + var_388_21
					end
				end

				arg_385_1.text_.text = var_388_25
				arg_385_1.typewritter.percent = 0

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115281", "115281091", "story_v_out_115281.awb") ~= 0 then
					local var_388_29 = manager.audio:GetVoiceLength("story_v_out_115281", "115281091", "story_v_out_115281.awb") / 1000

					if var_388_29 + var_388_21 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_29 + var_388_21
					end

					if var_388_24.prefab_name ~= "" and arg_385_1.actors_[var_388_24.prefab_name] ~= nil then
						local var_388_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_385_1.actors_[var_388_24.prefab_name].transform, "story_v_out_115281", "115281091", "story_v_out_115281.awb")

						arg_385_1:RecordAudio("115281091", var_388_30)
						arg_385_1:RecordAudio("115281091", var_388_30)
					else
						arg_385_1:AudioAction("play", "voice", "story_v_out_115281", "115281091", "story_v_out_115281.awb")
					end

					arg_385_1:RecordHistoryTalkVoice("story_v_out_115281", "115281091", "story_v_out_115281.awb")
				end

				arg_385_1:RecordContent(arg_385_1.text_.text)
			end

			local var_388_31 = math.max(var_388_22, arg_385_1.talkMaxDuration)

			if var_388_21 <= arg_385_1.time_ and arg_385_1.time_ < var_388_21 + var_388_31 then
				arg_385_1.typewritter.percent = (arg_385_1.time_ - var_388_21) / var_388_31

				arg_385_1.typewritter:SetDirty()
			end

			if arg_385_1.time_ >= var_388_21 + var_388_31 and arg_385_1.time_ < var_388_21 + var_388_31 + arg_388_0 then
				arg_385_1.typewritter.percent = 1

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(true)
			end
		end

		arg_385_1.nodeConfigList_ = {
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

		arg_385_1:InitPlayNodeList()
	end,
	Play115281092 = function(arg_389_0, arg_389_1)
		arg_389_1.time_ = 0
		arg_389_1.frameCnt_ = 0
		arg_389_1.state_ = "playing"
		arg_389_1.curTalkId_ = 115281092
		arg_389_1.duration_ = 11.03

		local var_389_0 = {
			ja = 9.866,
			ko = 10.5,
			zh = 11.033,
			en = 10.866
		}
		local var_389_1 = manager.audio:GetLocalizationFlag()

		if var_389_0[var_389_1] ~= nil then
			arg_389_1.duration_ = var_389_0[var_389_1]
		end

		SetActive(arg_389_1.tipsGo_, false)

		function arg_389_1.onSingleLineFinish_()
			arg_389_1.onSingleLineUpdate_ = nil
			arg_389_1.onSingleLineFinish_ = nil
			arg_389_1.state_ = "waiting"
		end

		function arg_389_1.playNext_(arg_391_0)
			if arg_391_0 == 1 then
				arg_389_0:Play115281093(arg_389_1)
			end
		end

		function arg_389_1.onSingleLineUpdate_(arg_392_0)
			local var_392_0 = 0
			local var_392_1 = 1

			if var_392_0 < arg_389_1.time_ and arg_389_1.time_ <= var_392_0 + arg_392_0 then
				arg_389_1.talkMaxDuration = 0
				arg_389_1.dialogCg_.alpha = 1

				arg_389_1.dialog_:SetActive(true)
				SetActive(arg_389_1.leftNameGo_, true)

				local var_392_2 = arg_389_1:FormatText(StoryNameCfg[94].name)

				arg_389_1.leftNameTxt_.text = var_392_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_389_1.leftNameTxt_.transform)

				arg_389_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_389_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_389_1:RecordName(arg_389_1.leftNameTxt_.text)
				SetActive(arg_389_1.iconTrs_.gameObject, false)
				arg_389_1.callingController_:SetSelectedState("normal")

				local var_392_3 = arg_389_1:GetWordFromCfg(115281092)
				local var_392_4 = arg_389_1:FormatText(var_392_3.content)

				arg_389_1.text_.text = var_392_4

				LuaForUtil.ClearLinePrefixSymbol(arg_389_1.text_)

				local var_392_5 = 40
				local var_392_6 = utf8.len(var_392_4)
				local var_392_7 = var_392_5 <= 0 and var_392_1 or var_392_1 * (var_392_6 / var_392_5)

				if var_392_7 > 0 and var_392_1 < var_392_7 then
					arg_389_1.talkMaxDuration = var_392_7

					if var_392_7 + var_392_0 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_7 + var_392_0
					end
				end

				arg_389_1.text_.text = var_392_4
				arg_389_1.typewritter.percent = 0

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115281", "115281092", "story_v_out_115281.awb") ~= 0 then
					local var_392_8 = manager.audio:GetVoiceLength("story_v_out_115281", "115281092", "story_v_out_115281.awb") / 1000

					if var_392_8 + var_392_0 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_8 + var_392_0
					end

					if var_392_3.prefab_name ~= "" and arg_389_1.actors_[var_392_3.prefab_name] ~= nil then
						local var_392_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_389_1.actors_[var_392_3.prefab_name].transform, "story_v_out_115281", "115281092", "story_v_out_115281.awb")

						arg_389_1:RecordAudio("115281092", var_392_9)
						arg_389_1:RecordAudio("115281092", var_392_9)
					else
						arg_389_1:AudioAction("play", "voice", "story_v_out_115281", "115281092", "story_v_out_115281.awb")
					end

					arg_389_1:RecordHistoryTalkVoice("story_v_out_115281", "115281092", "story_v_out_115281.awb")
				end

				arg_389_1:RecordContent(arg_389_1.text_.text)
			end

			local var_392_10 = math.max(var_392_1, arg_389_1.talkMaxDuration)

			if var_392_0 <= arg_389_1.time_ and arg_389_1.time_ < var_392_0 + var_392_10 then
				arg_389_1.typewritter.percent = (arg_389_1.time_ - var_392_0) / var_392_10

				arg_389_1.typewritter:SetDirty()
			end

			if arg_389_1.time_ >= var_392_0 + var_392_10 and arg_389_1.time_ < var_392_0 + var_392_10 + arg_392_0 then
				arg_389_1.typewritter.percent = 1

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(true)
			end
		end

		arg_389_1.nodeConfigList_ = {}

		arg_389_1:InitPlayNodeList()
	end,
	Play115281093 = function(arg_393_0, arg_393_1)
		arg_393_1.time_ = 0
		arg_393_1.frameCnt_ = 0
		arg_393_1.state_ = "playing"
		arg_393_1.curTalkId_ = 115281093
		arg_393_1.duration_ = 5

		SetActive(arg_393_1.tipsGo_, false)

		function arg_393_1.onSingleLineFinish_()
			arg_393_1.onSingleLineUpdate_ = nil
			arg_393_1.onSingleLineFinish_ = nil
			arg_393_1.state_ = "waiting"
		end

		function arg_393_1.playNext_(arg_395_0)
			if arg_395_0 == 1 then
				arg_393_0:Play115281094(arg_393_1)
			end
		end

		function arg_393_1.onSingleLineUpdate_(arg_396_0)
			local var_396_0 = arg_393_1.actors_["1038"]
			local var_396_1 = 0

			if var_396_1 < arg_393_1.time_ and arg_393_1.time_ <= var_396_1 + arg_396_0 then
				local var_396_2 = var_396_0:GetComponentInChildren(typeof(CanvasGroup))

				if var_396_2 then
					arg_393_1.var_.alphaOldValue1038 = var_396_2.alpha
					arg_393_1.var_.characterEffect1038 = var_396_2
				end

				arg_393_1.var_.alphaOldValue1038 = 1
			end

			local var_396_3 = 0.333333333333333

			if var_396_1 <= arg_393_1.time_ and arg_393_1.time_ < var_396_1 + var_396_3 then
				local var_396_4 = (arg_393_1.time_ - var_396_1) / var_396_3
				local var_396_5 = Mathf.Lerp(arg_393_1.var_.alphaOldValue1038, 0, var_396_4)

				if arg_393_1.var_.characterEffect1038 then
					arg_393_1.var_.characterEffect1038.alpha = var_396_5
				end
			end

			if arg_393_1.time_ >= var_396_1 + var_396_3 and arg_393_1.time_ < var_396_1 + var_396_3 + arg_396_0 and arg_393_1.var_.characterEffect1038 then
				arg_393_1.var_.characterEffect1038.alpha = 0
			end

			local var_396_6 = 0
			local var_396_7 = 1.375

			if var_396_6 < arg_393_1.time_ and arg_393_1.time_ <= var_396_6 + arg_396_0 then
				arg_393_1.talkMaxDuration = 0
				arg_393_1.dialogCg_.alpha = 1

				arg_393_1.dialog_:SetActive(true)
				SetActive(arg_393_1.leftNameGo_, false)

				arg_393_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_393_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_393_1:RecordName(arg_393_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_393_1.iconTrs_.gameObject, false)
				arg_393_1.callingController_:SetSelectedState("normal")

				local var_396_8 = arg_393_1:GetWordFromCfg(115281093)
				local var_396_9 = arg_393_1:FormatText(var_396_8.content)

				arg_393_1.text_.text = var_396_9

				LuaForUtil.ClearLinePrefixSymbol(arg_393_1.text_)

				local var_396_10 = 55
				local var_396_11 = utf8.len(var_396_9)
				local var_396_12 = var_396_10 <= 0 and var_396_7 or var_396_7 * (var_396_11 / var_396_10)

				if var_396_12 > 0 and var_396_7 < var_396_12 then
					arg_393_1.talkMaxDuration = var_396_12

					if var_396_12 + var_396_6 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_12 + var_396_6
					end
				end

				arg_393_1.text_.text = var_396_9
				arg_393_1.typewritter.percent = 0

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(false)
				arg_393_1:RecordContent(arg_393_1.text_.text)
			end

			local var_396_13 = math.max(var_396_7, arg_393_1.talkMaxDuration)

			if var_396_6 <= arg_393_1.time_ and arg_393_1.time_ < var_396_6 + var_396_13 then
				arg_393_1.typewritter.percent = (arg_393_1.time_ - var_396_6) / var_396_13

				arg_393_1.typewritter:SetDirty()
			end

			if arg_393_1.time_ >= var_396_6 + var_396_13 and arg_393_1.time_ < var_396_6 + var_396_13 + arg_396_0 then
				arg_393_1.typewritter.percent = 1

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(true)
			end
		end

		arg_393_1.nodeConfigList_ = {}

		arg_393_1:InitPlayNodeList()
	end,
	Play115281094 = function(arg_397_0, arg_397_1)
		arg_397_1.time_ = 0
		arg_397_1.frameCnt_ = 0
		arg_397_1.state_ = "playing"
		arg_397_1.curTalkId_ = 115281094
		arg_397_1.duration_ = 6.9

		local var_397_0 = {
			ja = 6.9,
			ko = 4.1,
			zh = 4.8,
			en = 6.366
		}
		local var_397_1 = manager.audio:GetLocalizationFlag()

		if var_397_0[var_397_1] ~= nil then
			arg_397_1.duration_ = var_397_0[var_397_1]
		end

		SetActive(arg_397_1.tipsGo_, false)

		function arg_397_1.onSingleLineFinish_()
			arg_397_1.onSingleLineUpdate_ = nil
			arg_397_1.onSingleLineFinish_ = nil
			arg_397_1.state_ = "waiting"
		end

		function arg_397_1.playNext_(arg_399_0)
			if arg_399_0 == 1 then
				arg_397_0:Play115281095(arg_397_1)
			end
		end

		function arg_397_1.onSingleLineUpdate_(arg_400_0)
			local var_400_0 = arg_397_1.actors_["1038"].transform
			local var_400_1 = 0

			if var_400_1 < arg_397_1.time_ and arg_397_1.time_ <= var_400_1 + arg_400_0 then
				arg_397_1.var_.moveOldPos1038 = var_400_0.localPosition
				var_400_0.localScale = Vector3.New(1, 1, 1)

				arg_397_1:CheckSpriteTmpPos("1038", 2)

				local var_400_2 = var_400_0.childCount

				for iter_400_0 = 0, var_400_2 - 1 do
					local var_400_3 = var_400_0:GetChild(iter_400_0)

					if var_400_3.name == "split_1" or not string.find(var_400_3.name, "split") then
						var_400_3.gameObject:SetActive(true)
					else
						var_400_3.gameObject:SetActive(false)
					end
				end
			end

			local var_400_4 = 0.001

			if var_400_1 <= arg_397_1.time_ and arg_397_1.time_ < var_400_1 + var_400_4 then
				local var_400_5 = (arg_397_1.time_ - var_400_1) / var_400_4
				local var_400_6 = Vector3.New(-390, -400, 0)

				var_400_0.localPosition = Vector3.Lerp(arg_397_1.var_.moveOldPos1038, var_400_6, var_400_5)
			end

			if arg_397_1.time_ >= var_400_1 + var_400_4 and arg_397_1.time_ < var_400_1 + var_400_4 + arg_400_0 then
				var_400_0.localPosition = Vector3.New(-390, -400, 0)
			end

			local var_400_7 = arg_397_1.actors_["1038"]
			local var_400_8 = 0

			if var_400_8 < arg_397_1.time_ and arg_397_1.time_ <= var_400_8 + arg_400_0 then
				local var_400_9 = var_400_7:GetComponentInChildren(typeof(CanvasGroup))

				if var_400_9 then
					arg_397_1.var_.alphaOldValue1038 = var_400_9.alpha
					arg_397_1.var_.characterEffect1038 = var_400_9
				end

				arg_397_1.var_.alphaOldValue1038 = 0
			end

			local var_400_10 = 0.333333333333333

			if var_400_8 <= arg_397_1.time_ and arg_397_1.time_ < var_400_8 + var_400_10 then
				local var_400_11 = (arg_397_1.time_ - var_400_8) / var_400_10
				local var_400_12 = Mathf.Lerp(arg_397_1.var_.alphaOldValue1038, 1, var_400_11)

				if arg_397_1.var_.characterEffect1038 then
					arg_397_1.var_.characterEffect1038.alpha = var_400_12
				end
			end

			if arg_397_1.time_ >= var_400_8 + var_400_10 and arg_397_1.time_ < var_400_8 + var_400_10 + arg_400_0 and arg_397_1.var_.characterEffect1038 then
				arg_397_1.var_.characterEffect1038.alpha = 1
			end

			local var_400_13 = 0
			local var_400_14 = 0.4

			if var_400_13 < arg_397_1.time_ and arg_397_1.time_ <= var_400_13 + arg_400_0 then
				arg_397_1.talkMaxDuration = 0
				arg_397_1.dialogCg_.alpha = 1

				arg_397_1.dialog_:SetActive(true)
				SetActive(arg_397_1.leftNameGo_, true)

				local var_400_15 = arg_397_1:FormatText(StoryNameCfg[94].name)

				arg_397_1.leftNameTxt_.text = var_400_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_397_1.leftNameTxt_.transform)

				arg_397_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_397_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_397_1:RecordName(arg_397_1.leftNameTxt_.text)
				SetActive(arg_397_1.iconTrs_.gameObject, false)
				arg_397_1.callingController_:SetSelectedState("normal")

				local var_400_16 = arg_397_1:GetWordFromCfg(115281094)
				local var_400_17 = arg_397_1:FormatText(var_400_16.content)

				arg_397_1.text_.text = var_400_17

				LuaForUtil.ClearLinePrefixSymbol(arg_397_1.text_)

				local var_400_18 = 16
				local var_400_19 = utf8.len(var_400_17)
				local var_400_20 = var_400_18 <= 0 and var_400_14 or var_400_14 * (var_400_19 / var_400_18)

				if var_400_20 > 0 and var_400_14 < var_400_20 then
					arg_397_1.talkMaxDuration = var_400_20

					if var_400_20 + var_400_13 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_20 + var_400_13
					end
				end

				arg_397_1.text_.text = var_400_17
				arg_397_1.typewritter.percent = 0

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115281", "115281094", "story_v_out_115281.awb") ~= 0 then
					local var_400_21 = manager.audio:GetVoiceLength("story_v_out_115281", "115281094", "story_v_out_115281.awb") / 1000

					if var_400_21 + var_400_13 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_21 + var_400_13
					end

					if var_400_16.prefab_name ~= "" and arg_397_1.actors_[var_400_16.prefab_name] ~= nil then
						local var_400_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_397_1.actors_[var_400_16.prefab_name].transform, "story_v_out_115281", "115281094", "story_v_out_115281.awb")

						arg_397_1:RecordAudio("115281094", var_400_22)
						arg_397_1:RecordAudio("115281094", var_400_22)
					else
						arg_397_1:AudioAction("play", "voice", "story_v_out_115281", "115281094", "story_v_out_115281.awb")
					end

					arg_397_1:RecordHistoryTalkVoice("story_v_out_115281", "115281094", "story_v_out_115281.awb")
				end

				arg_397_1:RecordContent(arg_397_1.text_.text)
			end

			local var_400_23 = math.max(var_400_14, arg_397_1.talkMaxDuration)

			if var_400_13 <= arg_397_1.time_ and arg_397_1.time_ < var_400_13 + var_400_23 then
				arg_397_1.typewritter.percent = (arg_397_1.time_ - var_400_13) / var_400_23

				arg_397_1.typewritter:SetDirty()
			end

			if arg_397_1.time_ >= var_400_13 + var_400_23 and arg_397_1.time_ < var_400_13 + var_400_23 + arg_400_0 then
				arg_397_1.typewritter.percent = 1

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(true)
			end
		end

		arg_397_1.nodeConfigList_ = {
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

		arg_397_1:InitPlayNodeList()
	end,
	Play115281095 = function(arg_401_0, arg_401_1)
		arg_401_1.time_ = 0
		arg_401_1.frameCnt_ = 0
		arg_401_1.state_ = "playing"
		arg_401_1.curTalkId_ = 115281095
		arg_401_1.duration_ = 3.37

		local var_401_0 = {
			ja = 2.833,
			ko = 3,
			zh = 3.2,
			en = 3.366
		}
		local var_401_1 = manager.audio:GetLocalizationFlag()

		if var_401_0[var_401_1] ~= nil then
			arg_401_1.duration_ = var_401_0[var_401_1]
		end

		SetActive(arg_401_1.tipsGo_, false)

		function arg_401_1.onSingleLineFinish_()
			arg_401_1.onSingleLineUpdate_ = nil
			arg_401_1.onSingleLineFinish_ = nil
			arg_401_1.state_ = "waiting"
		end

		function arg_401_1.playNext_(arg_403_0)
			if arg_403_0 == 1 then
				arg_401_0:Play115281096(arg_401_1)
			end
		end

		function arg_401_1.onSingleLineUpdate_(arg_404_0)
			local var_404_0 = arg_401_1.actors_["10030"].transform
			local var_404_1 = 0

			if var_404_1 < arg_401_1.time_ and arg_401_1.time_ <= var_404_1 + arg_404_0 then
				arg_401_1.var_.moveOldPos10030 = var_404_0.localPosition
				var_404_0.localScale = Vector3.New(1, 1, 1)

				arg_401_1:CheckSpriteTmpPos("10030", 4)

				local var_404_2 = var_404_0.childCount

				for iter_404_0 = 0, var_404_2 - 1 do
					local var_404_3 = var_404_0:GetChild(iter_404_0)

					if var_404_3.name == "split_5" or not string.find(var_404_3.name, "split") then
						var_404_3.gameObject:SetActive(true)
					else
						var_404_3.gameObject:SetActive(false)
					end
				end
			end

			local var_404_4 = 0.001

			if var_404_1 <= arg_401_1.time_ and arg_401_1.time_ < var_404_1 + var_404_4 then
				local var_404_5 = (arg_401_1.time_ - var_404_1) / var_404_4
				local var_404_6 = Vector3.New(390, -390, 150)

				var_404_0.localPosition = Vector3.Lerp(arg_401_1.var_.moveOldPos10030, var_404_6, var_404_5)
			end

			if arg_401_1.time_ >= var_404_1 + var_404_4 and arg_401_1.time_ < var_404_1 + var_404_4 + arg_404_0 then
				var_404_0.localPosition = Vector3.New(390, -390, 150)
			end

			local var_404_7 = arg_401_1.actors_["1038"]
			local var_404_8 = 0

			if var_404_8 < arg_401_1.time_ and arg_401_1.time_ <= var_404_8 + arg_404_0 and not isNil(var_404_7) and arg_401_1.var_.actorSpriteComps1038 == nil then
				arg_401_1.var_.actorSpriteComps1038 = var_404_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_404_9 = 0.2

			if var_404_8 <= arg_401_1.time_ and arg_401_1.time_ < var_404_8 + var_404_9 and not isNil(var_404_7) then
				local var_404_10 = (arg_401_1.time_ - var_404_8) / var_404_9

				if arg_401_1.var_.actorSpriteComps1038 then
					for iter_404_1, iter_404_2 in pairs(arg_401_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_404_2 then
							if arg_401_1.isInRecall_ then
								local var_404_11 = Mathf.Lerp(iter_404_2.color.r, arg_401_1.hightColor2.r, var_404_10)
								local var_404_12 = Mathf.Lerp(iter_404_2.color.g, arg_401_1.hightColor2.g, var_404_10)
								local var_404_13 = Mathf.Lerp(iter_404_2.color.b, arg_401_1.hightColor2.b, var_404_10)

								iter_404_2.color = Color.New(var_404_11, var_404_12, var_404_13)
							else
								local var_404_14 = Mathf.Lerp(iter_404_2.color.r, 0.5, var_404_10)

								iter_404_2.color = Color.New(var_404_14, var_404_14, var_404_14)
							end
						end
					end
				end
			end

			if arg_401_1.time_ >= var_404_8 + var_404_9 and arg_401_1.time_ < var_404_8 + var_404_9 + arg_404_0 and not isNil(var_404_7) and arg_401_1.var_.actorSpriteComps1038 then
				for iter_404_3, iter_404_4 in pairs(arg_401_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_404_4 then
						if arg_401_1.isInRecall_ then
							iter_404_4.color = arg_401_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_404_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_401_1.var_.actorSpriteComps1038 = nil
			end

			local var_404_15 = arg_401_1.actors_["10030"]
			local var_404_16 = 0

			if var_404_16 < arg_401_1.time_ and arg_401_1.time_ <= var_404_16 + arg_404_0 then
				local var_404_17 = var_404_15:GetComponentInChildren(typeof(CanvasGroup))

				if var_404_17 then
					arg_401_1.var_.alphaOldValue10030 = var_404_17.alpha
					arg_401_1.var_.characterEffect10030 = var_404_17
				end

				arg_401_1.var_.alphaOldValue10030 = 0
			end

			local var_404_18 = 0.333333333333333

			if var_404_16 <= arg_401_1.time_ and arg_401_1.time_ < var_404_16 + var_404_18 then
				local var_404_19 = (arg_401_1.time_ - var_404_16) / var_404_18
				local var_404_20 = Mathf.Lerp(arg_401_1.var_.alphaOldValue10030, 1, var_404_19)

				if arg_401_1.var_.characterEffect10030 then
					arg_401_1.var_.characterEffect10030.alpha = var_404_20
				end
			end

			if arg_401_1.time_ >= var_404_16 + var_404_18 and arg_401_1.time_ < var_404_16 + var_404_18 + arg_404_0 and arg_401_1.var_.characterEffect10030 then
				arg_401_1.var_.characterEffect10030.alpha = 1
			end

			local var_404_21 = 0
			local var_404_22 = 0.275

			if var_404_21 < arg_401_1.time_ and arg_401_1.time_ <= var_404_21 + arg_404_0 then
				arg_401_1.talkMaxDuration = 0
				arg_401_1.dialogCg_.alpha = 1

				arg_401_1.dialog_:SetActive(true)
				SetActive(arg_401_1.leftNameGo_, true)

				local var_404_23 = arg_401_1:FormatText(StoryNameCfg[309].name)

				arg_401_1.leftNameTxt_.text = var_404_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_401_1.leftNameTxt_.transform)

				arg_401_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_401_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_401_1:RecordName(arg_401_1.leftNameTxt_.text)
				SetActive(arg_401_1.iconTrs_.gameObject, false)
				arg_401_1.callingController_:SetSelectedState("normal")

				local var_404_24 = arg_401_1:GetWordFromCfg(115281095)
				local var_404_25 = arg_401_1:FormatText(var_404_24.content)

				arg_401_1.text_.text = var_404_25

				LuaForUtil.ClearLinePrefixSymbol(arg_401_1.text_)

				local var_404_26 = 11
				local var_404_27 = utf8.len(var_404_25)
				local var_404_28 = var_404_26 <= 0 and var_404_22 or var_404_22 * (var_404_27 / var_404_26)

				if var_404_28 > 0 and var_404_22 < var_404_28 then
					arg_401_1.talkMaxDuration = var_404_28

					if var_404_28 + var_404_21 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_28 + var_404_21
					end
				end

				arg_401_1.text_.text = var_404_25
				arg_401_1.typewritter.percent = 0

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115281", "115281095", "story_v_out_115281.awb") ~= 0 then
					local var_404_29 = manager.audio:GetVoiceLength("story_v_out_115281", "115281095", "story_v_out_115281.awb") / 1000

					if var_404_29 + var_404_21 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_29 + var_404_21
					end

					if var_404_24.prefab_name ~= "" and arg_401_1.actors_[var_404_24.prefab_name] ~= nil then
						local var_404_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_401_1.actors_[var_404_24.prefab_name].transform, "story_v_out_115281", "115281095", "story_v_out_115281.awb")

						arg_401_1:RecordAudio("115281095", var_404_30)
						arg_401_1:RecordAudio("115281095", var_404_30)
					else
						arg_401_1:AudioAction("play", "voice", "story_v_out_115281", "115281095", "story_v_out_115281.awb")
					end

					arg_401_1:RecordHistoryTalkVoice("story_v_out_115281", "115281095", "story_v_out_115281.awb")
				end

				arg_401_1:RecordContent(arg_401_1.text_.text)
			end

			local var_404_31 = math.max(var_404_22, arg_401_1.talkMaxDuration)

			if var_404_21 <= arg_401_1.time_ and arg_401_1.time_ < var_404_21 + var_404_31 then
				arg_401_1.typewritter.percent = (arg_401_1.time_ - var_404_21) / var_404_31

				arg_401_1.typewritter:SetDirty()
			end

			if arg_401_1.time_ >= var_404_21 + var_404_31 and arg_401_1.time_ < var_404_21 + var_404_31 + arg_404_0 then
				arg_401_1.typewritter.percent = 1

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(true)
			end
		end

		arg_401_1.nodeConfigList_ = {
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

		arg_401_1:InitPlayNodeList()
	end,
	Play115281096 = function(arg_405_0, arg_405_1)
		arg_405_1.time_ = 0
		arg_405_1.frameCnt_ = 0
		arg_405_1.state_ = "playing"
		arg_405_1.curTalkId_ = 115281096
		arg_405_1.duration_ = 5

		SetActive(arg_405_1.tipsGo_, false)

		function arg_405_1.onSingleLineFinish_()
			arg_405_1.onSingleLineUpdate_ = nil
			arg_405_1.onSingleLineFinish_ = nil
			arg_405_1.state_ = "waiting"
		end

		function arg_405_1.playNext_(arg_407_0)
			if arg_407_0 == 1 then
				arg_405_0:Play115281097(arg_405_1)
			end
		end

		function arg_405_1.onSingleLineUpdate_(arg_408_0)
			local var_408_0 = arg_405_1.actors_["10030"]
			local var_408_1 = 0

			if var_408_1 < arg_405_1.time_ and arg_405_1.time_ <= var_408_1 + arg_408_0 then
				local var_408_2 = var_408_0:GetComponentInChildren(typeof(CanvasGroup))

				if var_408_2 then
					arg_405_1.var_.alphaOldValue10030 = var_408_2.alpha
					arg_405_1.var_.characterEffect10030 = var_408_2
				end

				arg_405_1.var_.alphaOldValue10030 = 1
			end

			local var_408_3 = 0.333333333333333

			if var_408_1 <= arg_405_1.time_ and arg_405_1.time_ < var_408_1 + var_408_3 then
				local var_408_4 = (arg_405_1.time_ - var_408_1) / var_408_3
				local var_408_5 = Mathf.Lerp(arg_405_1.var_.alphaOldValue10030, 0, var_408_4)

				if arg_405_1.var_.characterEffect10030 then
					arg_405_1.var_.characterEffect10030.alpha = var_408_5
				end
			end

			if arg_405_1.time_ >= var_408_1 + var_408_3 and arg_405_1.time_ < var_408_1 + var_408_3 + arg_408_0 and arg_405_1.var_.characterEffect10030 then
				arg_405_1.var_.characterEffect10030.alpha = 0
			end

			local var_408_6 = arg_405_1.actors_["1038"]
			local var_408_7 = 0

			if var_408_7 < arg_405_1.time_ and arg_405_1.time_ <= var_408_7 + arg_408_0 then
				local var_408_8 = var_408_6:GetComponentInChildren(typeof(CanvasGroup))

				if var_408_8 then
					arg_405_1.var_.alphaOldValue1038 = var_408_8.alpha
					arg_405_1.var_.characterEffect1038 = var_408_8
				end

				arg_405_1.var_.alphaOldValue1038 = 1
			end

			local var_408_9 = 0.333333333333333

			if var_408_7 <= arg_405_1.time_ and arg_405_1.time_ < var_408_7 + var_408_9 then
				local var_408_10 = (arg_405_1.time_ - var_408_7) / var_408_9
				local var_408_11 = Mathf.Lerp(arg_405_1.var_.alphaOldValue1038, 0, var_408_10)

				if arg_405_1.var_.characterEffect1038 then
					arg_405_1.var_.characterEffect1038.alpha = var_408_11
				end
			end

			if arg_405_1.time_ >= var_408_7 + var_408_9 and arg_405_1.time_ < var_408_7 + var_408_9 + arg_408_0 and arg_405_1.var_.characterEffect1038 then
				arg_405_1.var_.characterEffect1038.alpha = 0
			end

			local var_408_12 = 0
			local var_408_13 = 0.725

			if var_408_12 < arg_405_1.time_ and arg_405_1.time_ <= var_408_12 + arg_408_0 then
				arg_405_1.talkMaxDuration = 0
				arg_405_1.dialogCg_.alpha = 1

				arg_405_1.dialog_:SetActive(true)
				SetActive(arg_405_1.leftNameGo_, false)

				arg_405_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_405_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_405_1:RecordName(arg_405_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_405_1.iconTrs_.gameObject, false)
				arg_405_1.callingController_:SetSelectedState("normal")

				local var_408_14 = arg_405_1:GetWordFromCfg(115281096)
				local var_408_15 = arg_405_1:FormatText(var_408_14.content)

				arg_405_1.text_.text = var_408_15

				LuaForUtil.ClearLinePrefixSymbol(arg_405_1.text_)

				local var_408_16 = 29
				local var_408_17 = utf8.len(var_408_15)
				local var_408_18 = var_408_16 <= 0 and var_408_13 or var_408_13 * (var_408_17 / var_408_16)

				if var_408_18 > 0 and var_408_13 < var_408_18 then
					arg_405_1.talkMaxDuration = var_408_18

					if var_408_18 + var_408_12 > arg_405_1.duration_ then
						arg_405_1.duration_ = var_408_18 + var_408_12
					end
				end

				arg_405_1.text_.text = var_408_15
				arg_405_1.typewritter.percent = 0

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(false)
				arg_405_1:RecordContent(arg_405_1.text_.text)
			end

			local var_408_19 = math.max(var_408_13, arg_405_1.talkMaxDuration)

			if var_408_12 <= arg_405_1.time_ and arg_405_1.time_ < var_408_12 + var_408_19 then
				arg_405_1.typewritter.percent = (arg_405_1.time_ - var_408_12) / var_408_19

				arg_405_1.typewritter:SetDirty()
			end

			if arg_405_1.time_ >= var_408_12 + var_408_19 and arg_405_1.time_ < var_408_12 + var_408_19 + arg_408_0 then
				arg_405_1.typewritter.percent = 1

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(true)
			end
		end

		arg_405_1.nodeConfigList_ = {}

		arg_405_1:InitPlayNodeList()
	end,
	Play115281097 = function(arg_409_0, arg_409_1)
		arg_409_1.time_ = 0
		arg_409_1.frameCnt_ = 0
		arg_409_1.state_ = "playing"
		arg_409_1.curTalkId_ = 115281097
		arg_409_1.duration_ = 8.53

		local var_409_0 = {
			ja = 8.533,
			ko = 4.666,
			zh = 4.466,
			en = 6.833
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
				arg_409_0:Play115281098(arg_409_1)
			end
		end

		function arg_409_1.onSingleLineUpdate_(arg_412_0)
			local var_412_0 = 0
			local var_412_1 = 0.475

			if var_412_0 < arg_409_1.time_ and arg_409_1.time_ <= var_412_0 + arg_412_0 then
				arg_409_1.talkMaxDuration = 0
				arg_409_1.dialogCg_.alpha = 1

				arg_409_1.dialog_:SetActive(true)
				SetActive(arg_409_1.leftNameGo_, true)

				local var_412_2 = arg_409_1:FormatText(StoryNameCfg[309].name)

				arg_409_1.leftNameTxt_.text = var_412_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_409_1.leftNameTxt_.transform)

				arg_409_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_409_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_409_1:RecordName(arg_409_1.leftNameTxt_.text)
				SetActive(arg_409_1.iconTrs_.gameObject, true)
				arg_409_1.iconController_:SetSelectedState("hero")

				arg_409_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10030_split_1")

				arg_409_1.callingController_:SetSelectedState("normal")

				arg_409_1.keyicon_.color = Color.New(1, 1, 1)
				arg_409_1.icon_.color = Color.New(1, 1, 1)

				local var_412_3 = arg_409_1:GetWordFromCfg(115281097)
				local var_412_4 = arg_409_1:FormatText(var_412_3.content)

				arg_409_1.text_.text = var_412_4

				LuaForUtil.ClearLinePrefixSymbol(arg_409_1.text_)

				local var_412_5 = 19
				local var_412_6 = utf8.len(var_412_4)
				local var_412_7 = var_412_5 <= 0 and var_412_1 or var_412_1 * (var_412_6 / var_412_5)

				if var_412_7 > 0 and var_412_1 < var_412_7 then
					arg_409_1.talkMaxDuration = var_412_7

					if var_412_7 + var_412_0 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_7 + var_412_0
					end
				end

				arg_409_1.text_.text = var_412_4
				arg_409_1.typewritter.percent = 0

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115281", "115281097", "story_v_out_115281.awb") ~= 0 then
					local var_412_8 = manager.audio:GetVoiceLength("story_v_out_115281", "115281097", "story_v_out_115281.awb") / 1000

					if var_412_8 + var_412_0 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_8 + var_412_0
					end

					if var_412_3.prefab_name ~= "" and arg_409_1.actors_[var_412_3.prefab_name] ~= nil then
						local var_412_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_409_1.actors_[var_412_3.prefab_name].transform, "story_v_out_115281", "115281097", "story_v_out_115281.awb")

						arg_409_1:RecordAudio("115281097", var_412_9)
						arg_409_1:RecordAudio("115281097", var_412_9)
					else
						arg_409_1:AudioAction("play", "voice", "story_v_out_115281", "115281097", "story_v_out_115281.awb")
					end

					arg_409_1:RecordHistoryTalkVoice("story_v_out_115281", "115281097", "story_v_out_115281.awb")
				end

				arg_409_1:RecordContent(arg_409_1.text_.text)
			end

			local var_412_10 = math.max(var_412_1, arg_409_1.talkMaxDuration)

			if var_412_0 <= arg_409_1.time_ and arg_409_1.time_ < var_412_0 + var_412_10 then
				arg_409_1.typewritter.percent = (arg_409_1.time_ - var_412_0) / var_412_10

				arg_409_1.typewritter:SetDirty()
			end

			if arg_409_1.time_ >= var_412_0 + var_412_10 and arg_409_1.time_ < var_412_0 + var_412_10 + arg_412_0 then
				arg_409_1.typewritter.percent = 1

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(true)
			end
		end

		arg_409_1.nodeConfigList_ = {}

		arg_409_1:InitPlayNodeList()
	end,
	Play115281098 = function(arg_413_0, arg_413_1)
		arg_413_1.time_ = 0
		arg_413_1.frameCnt_ = 0
		arg_413_1.state_ = "playing"
		arg_413_1.curTalkId_ = 115281098
		arg_413_1.duration_ = 5

		SetActive(arg_413_1.tipsGo_, false)

		function arg_413_1.onSingleLineFinish_()
			arg_413_1.onSingleLineUpdate_ = nil
			arg_413_1.onSingleLineFinish_ = nil
			arg_413_1.state_ = "waiting"
		end

		function arg_413_1.playNext_(arg_415_0)
			if arg_415_0 == 1 then
				arg_413_0:Play115281099(arg_413_1)
			end
		end

		function arg_413_1.onSingleLineUpdate_(arg_416_0)
			local var_416_0 = 0
			local var_416_1 = 1.25

			if var_416_0 < arg_413_1.time_ and arg_413_1.time_ <= var_416_0 + arg_416_0 then
				arg_413_1.talkMaxDuration = 0
				arg_413_1.dialogCg_.alpha = 1

				arg_413_1.dialog_:SetActive(true)
				SetActive(arg_413_1.leftNameGo_, false)

				arg_413_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_413_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_413_1:RecordName(arg_413_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_413_1.iconTrs_.gameObject, false)
				arg_413_1.callingController_:SetSelectedState("normal")

				local var_416_2 = arg_413_1:GetWordFromCfg(115281098)
				local var_416_3 = arg_413_1:FormatText(var_416_2.content)

				arg_413_1.text_.text = var_416_3

				LuaForUtil.ClearLinePrefixSymbol(arg_413_1.text_)

				local var_416_4 = 49
				local var_416_5 = utf8.len(var_416_3)
				local var_416_6 = var_416_4 <= 0 and var_416_1 or var_416_1 * (var_416_5 / var_416_4)

				if var_416_6 > 0 and var_416_1 < var_416_6 then
					arg_413_1.talkMaxDuration = var_416_6

					if var_416_6 + var_416_0 > arg_413_1.duration_ then
						arg_413_1.duration_ = var_416_6 + var_416_0
					end
				end

				arg_413_1.text_.text = var_416_3
				arg_413_1.typewritter.percent = 0

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(false)
				arg_413_1:RecordContent(arg_413_1.text_.text)
			end

			local var_416_7 = math.max(var_416_1, arg_413_1.talkMaxDuration)

			if var_416_0 <= arg_413_1.time_ and arg_413_1.time_ < var_416_0 + var_416_7 then
				arg_413_1.typewritter.percent = (arg_413_1.time_ - var_416_0) / var_416_7

				arg_413_1.typewritter:SetDirty()
			end

			if arg_413_1.time_ >= var_416_0 + var_416_7 and arg_413_1.time_ < var_416_0 + var_416_7 + arg_416_0 then
				arg_413_1.typewritter.percent = 1

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(true)
			end
		end

		arg_413_1.nodeConfigList_ = {}

		arg_413_1:InitPlayNodeList()
	end,
	Play115281099 = function(arg_417_0, arg_417_1)
		arg_417_1.time_ = 0
		arg_417_1.frameCnt_ = 0
		arg_417_1.state_ = "playing"
		arg_417_1.curTalkId_ = 115281099
		arg_417_1.duration_ = 5

		SetActive(arg_417_1.tipsGo_, false)

		function arg_417_1.onSingleLineFinish_()
			arg_417_1.onSingleLineUpdate_ = nil
			arg_417_1.onSingleLineFinish_ = nil
			arg_417_1.state_ = "waiting"
		end

		function arg_417_1.playNext_(arg_419_0)
			if arg_419_0 == 1 then
				arg_417_0:Play115281100(arg_417_1)
			end
		end

		function arg_417_1.onSingleLineUpdate_(arg_420_0)
			local var_420_0 = manager.ui.mainCamera.transform
			local var_420_1 = 0

			if var_420_1 < arg_417_1.time_ and arg_417_1.time_ <= var_420_1 + arg_420_0 then
				arg_417_1.var_.shakeOldPos = var_420_0.localPosition
			end

			local var_420_2 = 0.166666666666667

			if var_420_1 <= arg_417_1.time_ and arg_417_1.time_ < var_420_1 + var_420_2 then
				local var_420_3 = (arg_417_1.time_ - var_420_1) / 0.066
				local var_420_4, var_420_5 = math.modf(var_420_3)

				var_420_0.localPosition = Vector3.New(var_420_5 * 0.13, var_420_5 * 0.13, var_420_5 * 0.13) + arg_417_1.var_.shakeOldPos
			end

			if arg_417_1.time_ >= var_420_1 + var_420_2 and arg_417_1.time_ < var_420_1 + var_420_2 + arg_420_0 then
				var_420_0.localPosition = arg_417_1.var_.shakeOldPos
			end

			local var_420_6 = 0
			local var_420_7 = 0.3

			if var_420_6 < arg_417_1.time_ and arg_417_1.time_ <= var_420_6 + arg_420_0 then
				local var_420_8 = "play"
				local var_420_9 = "music"

				arg_417_1:AudioAction(var_420_8, var_420_9, "ui_battle", "ui_battle_stopbgm", "")

				local var_420_10 = ""
				local var_420_11 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_420_11 ~= "" then
					if arg_417_1.bgmTxt_.text ~= var_420_11 and arg_417_1.bgmTxt_.text ~= "" then
						if arg_417_1.bgmTxt2_.text ~= "" then
							arg_417_1.bgmTxt_.text = arg_417_1.bgmTxt2_.text
						end

						arg_417_1.bgmTxt2_.text = var_420_11

						arg_417_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_417_1.bgmTxt_.text = var_420_11
						arg_417_1.bgmTxt2_.text = var_420_11
					end

					if arg_417_1.bgmTimer then
						arg_417_1.bgmTimer:Stop()

						arg_417_1.bgmTimer = nil
					end

					if arg_417_1.settingData.show_music_name == 1 then
						arg_417_1.musicController:SetSelectedState("show")
						arg_417_1.musicAnimator_:Play("open", 0, 0)

						if arg_417_1.settingData.music_time ~= 0 then
							arg_417_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_417_1.settingData.music_time), function()
								if arg_417_1 == nil or isNil(arg_417_1.bgmTxt_) then
									return
								end

								arg_417_1.musicController:SetSelectedState("hide")
								arg_417_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_420_12 = 0.4
			local var_420_13 = 0.6

			if var_420_12 < arg_417_1.time_ and arg_417_1.time_ <= var_420_12 + arg_420_0 then
				local var_420_14 = "play"
				local var_420_15 = "music"

				arg_417_1:AudioAction(var_420_14, var_420_15, "bgm_activity_1_4_story_surface", "bgm_activity_1_4_story_surface", "bgm_activity_1_4_story_surface.awb")

				local var_420_16 = ""
				local var_420_17 = manager.audio:GetAudioName("bgm_activity_1_4_story_surface", "bgm_activity_1_4_story_surface")

				if var_420_17 ~= "" then
					if arg_417_1.bgmTxt_.text ~= var_420_17 and arg_417_1.bgmTxt_.text ~= "" then
						if arg_417_1.bgmTxt2_.text ~= "" then
							arg_417_1.bgmTxt_.text = arg_417_1.bgmTxt2_.text
						end

						arg_417_1.bgmTxt2_.text = var_420_17

						arg_417_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_417_1.bgmTxt_.text = var_420_17
						arg_417_1.bgmTxt2_.text = var_420_17
					end

					if arg_417_1.bgmTimer then
						arg_417_1.bgmTimer:Stop()

						arg_417_1.bgmTimer = nil
					end

					if arg_417_1.settingData.show_music_name == 1 then
						arg_417_1.musicController:SetSelectedState("show")
						arg_417_1.musicAnimator_:Play("open", 0, 0)

						if arg_417_1.settingData.music_time ~= 0 then
							arg_417_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_417_1.settingData.music_time), function()
								if arg_417_1 == nil or isNil(arg_417_1.bgmTxt_) then
									return
								end

								arg_417_1.musicController:SetSelectedState("hide")
								arg_417_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_420_18 = 0
			local var_420_19 = 1

			if var_420_18 < arg_417_1.time_ and arg_417_1.time_ <= var_420_18 + arg_420_0 then
				local var_420_20 = "play"
				local var_420_21 = "effect"

				arg_417_1:AudioAction(var_420_20, var_420_21, "se_story_activity_1_5_3", "se_story_activity_1_5_3_fireworks03", "")
			end

			local var_420_22 = 0
			local var_420_23 = 0.075

			if var_420_22 < arg_417_1.time_ and arg_417_1.time_ <= var_420_22 + arg_420_0 then
				arg_417_1.talkMaxDuration = 0
				arg_417_1.dialogCg_.alpha = 1

				arg_417_1.dialog_:SetActive(true)
				SetActive(arg_417_1.leftNameGo_, false)

				arg_417_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_417_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_417_1:RecordName(arg_417_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_417_1.iconTrs_.gameObject, false)
				arg_417_1.callingController_:SetSelectedState("normal")

				local var_420_24 = arg_417_1:GetWordFromCfg(115281099)
				local var_420_25 = arg_417_1:FormatText(var_420_24.content)

				arg_417_1.text_.text = var_420_25

				LuaForUtil.ClearLinePrefixSymbol(arg_417_1.text_)

				local var_420_26 = 3
				local var_420_27 = utf8.len(var_420_25)
				local var_420_28 = var_420_26 <= 0 and var_420_23 or var_420_23 * (var_420_27 / var_420_26)

				if var_420_28 > 0 and var_420_23 < var_420_28 then
					arg_417_1.talkMaxDuration = var_420_28

					if var_420_28 + var_420_22 > arg_417_1.duration_ then
						arg_417_1.duration_ = var_420_28 + var_420_22
					end
				end

				arg_417_1.text_.text = var_420_25
				arg_417_1.typewritter.percent = 0

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(false)
				arg_417_1:RecordContent(arg_417_1.text_.text)
			end

			local var_420_29 = math.max(var_420_23, arg_417_1.talkMaxDuration)

			if var_420_22 <= arg_417_1.time_ and arg_417_1.time_ < var_420_22 + var_420_29 then
				arg_417_1.typewritter.percent = (arg_417_1.time_ - var_420_22) / var_420_29

				arg_417_1.typewritter:SetDirty()
			end

			if arg_417_1.time_ >= var_420_22 + var_420_29 and arg_417_1.time_ < var_420_22 + var_420_29 + arg_420_0 then
				arg_417_1.typewritter.percent = 1

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(true)
			end
		end

		arg_417_1.nodeConfigList_ = {}

		arg_417_1:InitPlayNodeList()
	end,
	Play115281100 = function(arg_423_0, arg_423_1)
		arg_423_1.time_ = 0
		arg_423_1.frameCnt_ = 0
		arg_423_1.state_ = "playing"
		arg_423_1.curTalkId_ = 115281100
		arg_423_1.duration_ = 2.47

		local var_423_0 = {
			ja = 1.8,
			ko = 1.8,
			zh = 2,
			en = 2.466
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
				arg_423_0:Play115281101(arg_423_1)
			end
		end

		function arg_423_1.onSingleLineUpdate_(arg_426_0)
			local var_426_0 = 0
			local var_426_1 = 0.15

			if var_426_0 < arg_423_1.time_ and arg_423_1.time_ <= var_426_0 + arg_426_0 then
				arg_423_1.talkMaxDuration = 0
				arg_423_1.dialogCg_.alpha = 1

				arg_423_1.dialog_:SetActive(true)
				SetActive(arg_423_1.leftNameGo_, true)

				local var_426_2 = arg_423_1:FormatText(StoryNameCfg[309].name)

				arg_423_1.leftNameTxt_.text = var_426_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_423_1.leftNameTxt_.transform)

				arg_423_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_423_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_423_1:RecordName(arg_423_1.leftNameTxt_.text)
				SetActive(arg_423_1.iconTrs_.gameObject, true)
				arg_423_1.iconController_:SetSelectedState("hero")

				arg_423_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10030_split_2")

				arg_423_1.callingController_:SetSelectedState("normal")

				arg_423_1.keyicon_.color = Color.New(1, 1, 1)
				arg_423_1.icon_.color = Color.New(1, 1, 1)

				local var_426_3 = arg_423_1:GetWordFromCfg(115281100)
				local var_426_4 = arg_423_1:FormatText(var_426_3.content)

				arg_423_1.text_.text = var_426_4

				LuaForUtil.ClearLinePrefixSymbol(arg_423_1.text_)

				local var_426_5 = 6
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

				if manager.audio:GetVoiceLength("story_v_out_115281", "115281100", "story_v_out_115281.awb") ~= 0 then
					local var_426_8 = manager.audio:GetVoiceLength("story_v_out_115281", "115281100", "story_v_out_115281.awb") / 1000

					if var_426_8 + var_426_0 > arg_423_1.duration_ then
						arg_423_1.duration_ = var_426_8 + var_426_0
					end

					if var_426_3.prefab_name ~= "" and arg_423_1.actors_[var_426_3.prefab_name] ~= nil then
						local var_426_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_423_1.actors_[var_426_3.prefab_name].transform, "story_v_out_115281", "115281100", "story_v_out_115281.awb")

						arg_423_1:RecordAudio("115281100", var_426_9)
						arg_423_1:RecordAudio("115281100", var_426_9)
					else
						arg_423_1:AudioAction("play", "voice", "story_v_out_115281", "115281100", "story_v_out_115281.awb")
					end

					arg_423_1:RecordHistoryTalkVoice("story_v_out_115281", "115281100", "story_v_out_115281.awb")
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
	Play115281101 = function(arg_427_0, arg_427_1)
		arg_427_1.time_ = 0
		arg_427_1.frameCnt_ = 0
		arg_427_1.state_ = "playing"
		arg_427_1.curTalkId_ = 115281101
		arg_427_1.duration_ = 5

		SetActive(arg_427_1.tipsGo_, false)

		function arg_427_1.onSingleLineFinish_()
			arg_427_1.onSingleLineUpdate_ = nil
			arg_427_1.onSingleLineFinish_ = nil
			arg_427_1.state_ = "waiting"
		end

		function arg_427_1.playNext_(arg_429_0)
			if arg_429_0 == 1 then
				arg_427_0:Play115281102(arg_427_1)
			end
		end

		function arg_427_1.onSingleLineUpdate_(arg_430_0)
			local var_430_0 = arg_427_1.actors_["10030"].transform
			local var_430_1 = 0

			if var_430_1 < arg_427_1.time_ and arg_427_1.time_ <= var_430_1 + arg_430_0 then
				arg_427_1.var_.moveOldPos10030 = var_430_0.localPosition
				var_430_0.localScale = Vector3.New(1, 1, 1)

				arg_427_1:CheckSpriteTmpPos("10030", 0)

				local var_430_2 = var_430_0.childCount

				for iter_430_0 = 0, var_430_2 - 1 do
					local var_430_3 = var_430_0:GetChild(iter_430_0)

					if var_430_3.name == "split_2" or not string.find(var_430_3.name, "split") then
						var_430_3.gameObject:SetActive(true)
					else
						var_430_3.gameObject:SetActive(false)
					end
				end
			end

			local var_430_4 = 0.001

			if var_430_1 <= arg_427_1.time_ and arg_427_1.time_ < var_430_1 + var_430_4 then
				local var_430_5 = (arg_427_1.time_ - var_430_1) / var_430_4
				local var_430_6 = Vector3.New(-1500, -350, -180)

				var_430_0.localPosition = Vector3.Lerp(arg_427_1.var_.moveOldPos10030, var_430_6, var_430_5)
			end

			if arg_427_1.time_ >= var_430_1 + var_430_4 and arg_427_1.time_ < var_430_1 + var_430_4 + arg_430_0 then
				var_430_0.localPosition = Vector3.New(-1500, -350, -180)
			end

			local var_430_7 = 0
			local var_430_8 = 0.55

			if var_430_7 < arg_427_1.time_ and arg_427_1.time_ <= var_430_7 + arg_430_0 then
				arg_427_1.talkMaxDuration = 0
				arg_427_1.dialogCg_.alpha = 1

				arg_427_1.dialog_:SetActive(true)
				SetActive(arg_427_1.leftNameGo_, false)

				arg_427_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_427_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_427_1:RecordName(arg_427_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_427_1.iconTrs_.gameObject, false)
				arg_427_1.callingController_:SetSelectedState("normal")

				local var_430_9 = arg_427_1:GetWordFromCfg(115281101)
				local var_430_10 = arg_427_1:FormatText(var_430_9.content)

				arg_427_1.text_.text = var_430_10

				LuaForUtil.ClearLinePrefixSymbol(arg_427_1.text_)

				local var_430_11 = 22
				local var_430_12 = utf8.len(var_430_10)
				local var_430_13 = var_430_11 <= 0 and var_430_8 or var_430_8 * (var_430_12 / var_430_11)

				if var_430_13 > 0 and var_430_8 < var_430_13 then
					arg_427_1.talkMaxDuration = var_430_13

					if var_430_13 + var_430_7 > arg_427_1.duration_ then
						arg_427_1.duration_ = var_430_13 + var_430_7
					end
				end

				arg_427_1.text_.text = var_430_10
				arg_427_1.typewritter.percent = 0

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(false)
				arg_427_1:RecordContent(arg_427_1.text_.text)
			end

			local var_430_14 = math.max(var_430_8, arg_427_1.talkMaxDuration)

			if var_430_7 <= arg_427_1.time_ and arg_427_1.time_ < var_430_7 + var_430_14 then
				arg_427_1.typewritter.percent = (arg_427_1.time_ - var_430_7) / var_430_14

				arg_427_1.typewritter:SetDirty()
			end

			if arg_427_1.time_ >= var_430_7 + var_430_14 and arg_427_1.time_ < var_430_7 + var_430_14 + arg_430_0 then
				arg_427_1.typewritter.percent = 1

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(true)
			end
		end

		arg_427_1.nodeConfigList_ = {
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

		arg_427_1:InitPlayNodeList()
	end,
	Play115281102 = function(arg_431_0, arg_431_1)
		arg_431_1.time_ = 0
		arg_431_1.frameCnt_ = 0
		arg_431_1.state_ = "playing"
		arg_431_1.curTalkId_ = 115281102
		arg_431_1.duration_ = 5

		SetActive(arg_431_1.tipsGo_, false)

		function arg_431_1.onSingleLineFinish_()
			arg_431_1.onSingleLineUpdate_ = nil
			arg_431_1.onSingleLineFinish_ = nil
			arg_431_1.state_ = "waiting"
		end

		function arg_431_1.playNext_(arg_433_0)
			if arg_433_0 == 1 then
				arg_431_0:Play115281103(arg_431_1)
			end
		end

		function arg_431_1.onSingleLineUpdate_(arg_434_0)
			local var_434_0 = 0
			local var_434_1 = 0.725

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

				local var_434_2 = arg_431_1:GetWordFromCfg(115281102)
				local var_434_3 = arg_431_1:FormatText(var_434_2.content)

				arg_431_1.text_.text = var_434_3

				LuaForUtil.ClearLinePrefixSymbol(arg_431_1.text_)

				local var_434_4 = 29
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
	Play115281103 = function(arg_435_0, arg_435_1)
		arg_435_1.time_ = 0
		arg_435_1.frameCnt_ = 0
		arg_435_1.state_ = "playing"
		arg_435_1.curTalkId_ = 115281103
		arg_435_1.duration_ = 7

		SetActive(arg_435_1.tipsGo_, false)

		function arg_435_1.onSingleLineFinish_()
			arg_435_1.onSingleLineUpdate_ = nil
			arg_435_1.onSingleLineFinish_ = nil
			arg_435_1.state_ = "waiting"
		end

		function arg_435_1.playNext_(arg_437_0)
			if arg_437_0 == 1 then
				arg_435_0:Play115281104(arg_435_1)
			end
		end

		function arg_435_1.onSingleLineUpdate_(arg_438_0)
			local var_438_0 = 1

			if var_438_0 < arg_435_1.time_ and arg_435_1.time_ <= var_438_0 + arg_438_0 then
				local var_438_1 = manager.ui.mainCamera.transform.localPosition
				local var_438_2 = Vector3.New(0, 0, 10) + Vector3.New(var_438_1.x, var_438_1.y, 0)
				local var_438_3 = arg_435_1.bgs_.STblack

				var_438_3.transform.localPosition = var_438_2
				var_438_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_438_4 = var_438_3:GetComponent("SpriteRenderer")

				if var_438_4 and var_438_4.sprite then
					local var_438_5 = (var_438_3.transform.localPosition - var_438_1).z
					local var_438_6 = manager.ui.mainCameraCom_
					local var_438_7 = 2 * var_438_5 * Mathf.Tan(var_438_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_438_8 = var_438_7 * var_438_6.aspect
					local var_438_9 = var_438_4.sprite.bounds.size.x
					local var_438_10 = var_438_4.sprite.bounds.size.y
					local var_438_11 = var_438_8 / var_438_9
					local var_438_12 = var_438_7 / var_438_10
					local var_438_13 = var_438_12 < var_438_11 and var_438_11 or var_438_12

					var_438_3.transform.localScale = Vector3.New(var_438_13, var_438_13, 0)
				end

				for iter_438_0, iter_438_1 in pairs(arg_435_1.bgs_) do
					if iter_438_0 ~= "STblack" then
						iter_438_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_438_14 = 0

			if var_438_14 < arg_435_1.time_ and arg_435_1.time_ <= var_438_14 + arg_438_0 then
				arg_435_1.mask_.enabled = true
				arg_435_1.mask_.raycastTarget = false

				arg_435_1:SetGaussion(false)
			end

			local var_438_15 = 1

			if var_438_14 <= arg_435_1.time_ and arg_435_1.time_ < var_438_14 + var_438_15 then
				local var_438_16 = (arg_435_1.time_ - var_438_14) / var_438_15
				local var_438_17 = Color.New(0, 0, 0)

				var_438_17.a = Mathf.Lerp(0, 1, var_438_16)
				arg_435_1.mask_.color = var_438_17
			end

			if arg_435_1.time_ >= var_438_14 + var_438_15 and arg_435_1.time_ < var_438_14 + var_438_15 + arg_438_0 then
				local var_438_18 = Color.New(0, 0, 0)

				var_438_18.a = 1
				arg_435_1.mask_.color = var_438_18
			end

			local var_438_19 = 1

			if var_438_19 < arg_435_1.time_ and arg_435_1.time_ <= var_438_19 + arg_438_0 then
				arg_435_1.mask_.enabled = true
				arg_435_1.mask_.raycastTarget = false

				arg_435_1:SetGaussion(false)
			end

			local var_438_20 = 1

			if var_438_19 <= arg_435_1.time_ and arg_435_1.time_ < var_438_19 + var_438_20 then
				local var_438_21 = (arg_435_1.time_ - var_438_19) / var_438_20
				local var_438_22 = Color.New(0, 0, 0)

				var_438_22.a = Mathf.Lerp(1, 0, var_438_21)
				arg_435_1.mask_.color = var_438_22
			end

			if arg_435_1.time_ >= var_438_19 + var_438_20 and arg_435_1.time_ < var_438_19 + var_438_20 + arg_438_0 then
				local var_438_23 = Color.New(0, 0, 0)
				local var_438_24 = 0

				arg_435_1.mask_.enabled = false
				var_438_23.a = var_438_24
				arg_435_1.mask_.color = var_438_23
			end

			if arg_435_1.frameCnt_ <= 1 then
				arg_435_1.dialog_:SetActive(false)
			end

			local var_438_25 = 2
			local var_438_26 = 0.5

			if var_438_25 < arg_435_1.time_ and arg_435_1.time_ <= var_438_25 + arg_438_0 then
				arg_435_1.talkMaxDuration = 0

				arg_435_1.dialog_:SetActive(true)

				arg_435_1.dialogCg_.alpha = 0

				local var_438_27 = LeanTween.value(arg_435_1.dialog_, 0, 1, 0.3)

				var_438_27:setOnUpdate(LuaHelper.FloatAction(function(arg_439_0)
					arg_435_1.dialogCg_.alpha = arg_439_0
				end))
				var_438_27:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_435_1.dialog_)
					var_438_27:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_435_1.duration_ = arg_435_1.duration_ + 0.3

				SetActive(arg_435_1.leftNameGo_, false)

				arg_435_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_435_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_435_1:RecordName(arg_435_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_435_1.iconTrs_.gameObject, false)
				arg_435_1.callingController_:SetSelectedState("normal")

				local var_438_28 = arg_435_1:GetWordFromCfg(115281103)
				local var_438_29 = arg_435_1:FormatText(var_438_28.content)

				arg_435_1.text_.text = var_438_29

				LuaForUtil.ClearLinePrefixSymbol(arg_435_1.text_)

				local var_438_30 = 20
				local var_438_31 = utf8.len(var_438_29)
				local var_438_32 = var_438_30 <= 0 and var_438_26 or var_438_26 * (var_438_31 / var_438_30)

				if var_438_32 > 0 and var_438_26 < var_438_32 then
					arg_435_1.talkMaxDuration = var_438_32
					var_438_25 = var_438_25 + 0.3

					if var_438_32 + var_438_25 > arg_435_1.duration_ then
						arg_435_1.duration_ = var_438_32 + var_438_25
					end
				end

				arg_435_1.text_.text = var_438_29
				arg_435_1.typewritter.percent = 0

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(false)
				arg_435_1:RecordContent(arg_435_1.text_.text)
			end

			local var_438_33 = var_438_25 + 0.3
			local var_438_34 = math.max(var_438_26, arg_435_1.talkMaxDuration)

			if var_438_33 <= arg_435_1.time_ and arg_435_1.time_ < var_438_33 + var_438_34 then
				arg_435_1.typewritter.percent = (arg_435_1.time_ - var_438_33) / var_438_34

				arg_435_1.typewritter:SetDirty()
			end

			if arg_435_1.time_ >= var_438_33 + var_438_34 and arg_435_1.time_ < var_438_33 + var_438_34 + arg_438_0 then
				arg_435_1.typewritter.percent = 1

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(true)
			end
		end

		arg_435_1.nodeConfigList_ = {}

		arg_435_1:InitPlayNodeList()
	end,
	Play115281104 = function(arg_441_0, arg_441_1)
		arg_441_1.time_ = 0
		arg_441_1.frameCnt_ = 0
		arg_441_1.state_ = "playing"
		arg_441_1.curTalkId_ = 115281104
		arg_441_1.duration_ = 5

		SetActive(arg_441_1.tipsGo_, false)

		function arg_441_1.onSingleLineFinish_()
			arg_441_1.onSingleLineUpdate_ = nil
			arg_441_1.onSingleLineFinish_ = nil
			arg_441_1.state_ = "waiting"
		end

		function arg_441_1.playNext_(arg_443_0)
			if arg_443_0 == 1 then
				arg_441_0:Play115281105(arg_441_1)
			end
		end

		function arg_441_1.onSingleLineUpdate_(arg_444_0)
			local var_444_0 = 0
			local var_444_1 = 0.5

			if var_444_0 < arg_441_1.time_ and arg_441_1.time_ <= var_444_0 + arg_444_0 then
				arg_441_1.talkMaxDuration = 0
				arg_441_1.dialogCg_.alpha = 1

				arg_441_1.dialog_:SetActive(true)
				SetActive(arg_441_1.leftNameGo_, false)

				arg_441_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_441_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_441_1:RecordName(arg_441_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_441_1.iconTrs_.gameObject, false)
				arg_441_1.callingController_:SetSelectedState("normal")

				local var_444_2 = arg_441_1:GetWordFromCfg(115281104)
				local var_444_3 = arg_441_1:FormatText(var_444_2.content)

				arg_441_1.text_.text = var_444_3

				LuaForUtil.ClearLinePrefixSymbol(arg_441_1.text_)

				local var_444_4 = 20
				local var_444_5 = utf8.len(var_444_3)
				local var_444_6 = var_444_4 <= 0 and var_444_1 or var_444_1 * (var_444_5 / var_444_4)

				if var_444_6 > 0 and var_444_1 < var_444_6 then
					arg_441_1.talkMaxDuration = var_444_6

					if var_444_6 + var_444_0 > arg_441_1.duration_ then
						arg_441_1.duration_ = var_444_6 + var_444_0
					end
				end

				arg_441_1.text_.text = var_444_3
				arg_441_1.typewritter.percent = 0

				arg_441_1.typewritter:SetDirty()
				arg_441_1:ShowNextGo(false)
				arg_441_1:RecordContent(arg_441_1.text_.text)
			end

			local var_444_7 = math.max(var_444_1, arg_441_1.talkMaxDuration)

			if var_444_0 <= arg_441_1.time_ and arg_441_1.time_ < var_444_0 + var_444_7 then
				arg_441_1.typewritter.percent = (arg_441_1.time_ - var_444_0) / var_444_7

				arg_441_1.typewritter:SetDirty()
			end

			if arg_441_1.time_ >= var_444_0 + var_444_7 and arg_441_1.time_ < var_444_0 + var_444_7 + arg_444_0 then
				arg_441_1.typewritter.percent = 1

				arg_441_1.typewritter:SetDirty()
				arg_441_1:ShowNextGo(true)
			end
		end

		arg_441_1.nodeConfigList_ = {}

		arg_441_1:InitPlayNodeList()
	end,
	Play115281105 = function(arg_445_0, arg_445_1)
		arg_445_1.time_ = 0
		arg_445_1.frameCnt_ = 0
		arg_445_1.state_ = "playing"
		arg_445_1.curTalkId_ = 115281105
		arg_445_1.duration_ = 5.63

		local var_445_0 = {
			ja = 3.999999999999,
			ko = 5.633,
			zh = 4.366,
			en = 3.999999999999
		}
		local var_445_1 = manager.audio:GetLocalizationFlag()

		if var_445_0[var_445_1] ~= nil then
			arg_445_1.duration_ = var_445_0[var_445_1]
		end

		SetActive(arg_445_1.tipsGo_, false)

		function arg_445_1.onSingleLineFinish_()
			arg_445_1.onSingleLineUpdate_ = nil
			arg_445_1.onSingleLineFinish_ = nil
			arg_445_1.state_ = "waiting"
		end

		function arg_445_1.playNext_(arg_447_0)
			if arg_447_0 == 1 then
				arg_445_0:Play115281106(arg_445_1)
			end
		end

		function arg_445_1.onSingleLineUpdate_(arg_448_0)
			local var_448_0 = 1

			if var_448_0 < arg_445_1.time_ and arg_445_1.time_ <= var_448_0 + arg_448_0 then
				local var_448_1 = manager.ui.mainCamera.transform.localPosition
				local var_448_2 = Vector3.New(0, 0, 10) + Vector3.New(var_448_1.x, var_448_1.y, 0)
				local var_448_3 = arg_445_1.bgs_.ST28a

				var_448_3.transform.localPosition = var_448_2
				var_448_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_448_4 = var_448_3:GetComponent("SpriteRenderer")

				if var_448_4 and var_448_4.sprite then
					local var_448_5 = (var_448_3.transform.localPosition - var_448_1).z
					local var_448_6 = manager.ui.mainCameraCom_
					local var_448_7 = 2 * var_448_5 * Mathf.Tan(var_448_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_448_8 = var_448_7 * var_448_6.aspect
					local var_448_9 = var_448_4.sprite.bounds.size.x
					local var_448_10 = var_448_4.sprite.bounds.size.y
					local var_448_11 = var_448_8 / var_448_9
					local var_448_12 = var_448_7 / var_448_10
					local var_448_13 = var_448_12 < var_448_11 and var_448_11 or var_448_12

					var_448_3.transform.localScale = Vector3.New(var_448_13, var_448_13, 0)
				end

				for iter_448_0, iter_448_1 in pairs(arg_445_1.bgs_) do
					if iter_448_0 ~= "ST28a" then
						iter_448_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_448_14 = 0

			if var_448_14 < arg_445_1.time_ and arg_445_1.time_ <= var_448_14 + arg_448_0 then
				arg_445_1.mask_.enabled = true
				arg_445_1.mask_.raycastTarget = false

				arg_445_1:SetGaussion(false)
			end

			local var_448_15 = 1

			if var_448_14 <= arg_445_1.time_ and arg_445_1.time_ < var_448_14 + var_448_15 then
				local var_448_16 = (arg_445_1.time_ - var_448_14) / var_448_15
				local var_448_17 = Color.New(0, 0, 0)

				var_448_17.a = Mathf.Lerp(0, 1, var_448_16)
				arg_445_1.mask_.color = var_448_17
			end

			if arg_445_1.time_ >= var_448_14 + var_448_15 and arg_445_1.time_ < var_448_14 + var_448_15 + arg_448_0 then
				local var_448_18 = Color.New(0, 0, 0)

				var_448_18.a = 1
				arg_445_1.mask_.color = var_448_18
			end

			local var_448_19 = 1

			if var_448_19 < arg_445_1.time_ and arg_445_1.time_ <= var_448_19 + arg_448_0 then
				arg_445_1.mask_.enabled = true
				arg_445_1.mask_.raycastTarget = false

				arg_445_1:SetGaussion(false)
			end

			local var_448_20 = 2

			if var_448_19 <= arg_445_1.time_ and arg_445_1.time_ < var_448_19 + var_448_20 then
				local var_448_21 = (arg_445_1.time_ - var_448_19) / var_448_20
				local var_448_22 = Color.New(0, 0, 0)

				var_448_22.a = Mathf.Lerp(1, 0, var_448_21)
				arg_445_1.mask_.color = var_448_22
			end

			if arg_445_1.time_ >= var_448_19 + var_448_20 and arg_445_1.time_ < var_448_19 + var_448_20 + arg_448_0 then
				local var_448_23 = Color.New(0, 0, 0)
				local var_448_24 = 0

				arg_445_1.mask_.enabled = false
				var_448_23.a = var_448_24
				arg_445_1.mask_.color = var_448_23
			end

			local var_448_25 = manager.ui.mainCamera.transform
			local var_448_26 = 3

			if var_448_26 < arg_445_1.time_ and arg_445_1.time_ <= var_448_26 + arg_448_0 then
				arg_445_1.var_.shakeOldPos = var_448_25.localPosition
			end

			local var_448_27 = 0.133333333333333

			if var_448_26 <= arg_445_1.time_ and arg_445_1.time_ < var_448_26 + var_448_27 then
				local var_448_28 = (arg_445_1.time_ - var_448_26) / 0.066
				local var_448_29, var_448_30 = math.modf(var_448_28)

				var_448_25.localPosition = Vector3.New(var_448_30 * 0.13, var_448_30 * 0.13, var_448_30 * 0.13) + arg_445_1.var_.shakeOldPos
			end

			if arg_445_1.time_ >= var_448_26 + var_448_27 and arg_445_1.time_ < var_448_26 + var_448_27 + arg_448_0 then
				var_448_25.localPosition = arg_445_1.var_.shakeOldPos
			end

			local var_448_31 = 3
			local var_448_32 = 1

			if var_448_31 < arg_445_1.time_ and arg_445_1.time_ <= var_448_31 + arg_448_0 then
				local var_448_33 = "play"
				local var_448_34 = "effect"

				arg_445_1:AudioAction(var_448_33, var_448_34, "se_story_activity_1_5_3", "se_story_activity_1_5_3_fireworks02", "")
			end

			local var_448_35 = arg_445_1.actors_["10030"].transform
			local var_448_36 = 3

			if var_448_36 < arg_445_1.time_ and arg_445_1.time_ <= var_448_36 + arg_448_0 then
				arg_445_1.var_.moveOldPos10030 = var_448_35.localPosition
				var_448_35.localScale = Vector3.New(1, 1, 1)

				arg_445_1:CheckSpriteTmpPos("10030", 3)

				local var_448_37 = var_448_35.childCount

				for iter_448_2 = 0, var_448_37 - 1 do
					local var_448_38 = var_448_35:GetChild(iter_448_2)

					if var_448_38.name == "split_1" or not string.find(var_448_38.name, "split") then
						var_448_38.gameObject:SetActive(true)
					else
						var_448_38.gameObject:SetActive(false)
					end
				end
			end

			local var_448_39 = 0.001

			if var_448_36 <= arg_445_1.time_ and arg_445_1.time_ < var_448_36 + var_448_39 then
				local var_448_40 = (arg_445_1.time_ - var_448_36) / var_448_39
				local var_448_41 = Vector3.New(0, -390, 150)

				var_448_35.localPosition = Vector3.Lerp(arg_445_1.var_.moveOldPos10030, var_448_41, var_448_40)
			end

			if arg_445_1.time_ >= var_448_36 + var_448_39 and arg_445_1.time_ < var_448_36 + var_448_39 + arg_448_0 then
				var_448_35.localPosition = Vector3.New(0, -390, 150)
			end

			local var_448_42 = arg_445_1.actors_["10030"]
			local var_448_43 = 2.70066666666667

			if var_448_43 < arg_445_1.time_ and arg_445_1.time_ <= var_448_43 + arg_448_0 then
				local var_448_44 = var_448_42:GetComponentInChildren(typeof(CanvasGroup))

				if var_448_44 then
					arg_445_1.var_.alphaOldValue10030 = var_448_44.alpha
					arg_445_1.var_.characterEffect10030 = var_448_44
				end

				arg_445_1.var_.alphaOldValue10030 = 0
			end

			local var_448_45 = 0.333333333333333

			if var_448_43 <= arg_445_1.time_ and arg_445_1.time_ < var_448_43 + var_448_45 then
				local var_448_46 = (arg_445_1.time_ - var_448_43) / var_448_45
				local var_448_47 = Mathf.Lerp(arg_445_1.var_.alphaOldValue10030, 1, var_448_46)

				if arg_445_1.var_.characterEffect10030 then
					arg_445_1.var_.characterEffect10030.alpha = var_448_47
				end
			end

			if arg_445_1.time_ >= var_448_43 + var_448_45 and arg_445_1.time_ < var_448_43 + var_448_45 + arg_448_0 and arg_445_1.var_.characterEffect10030 then
				arg_445_1.var_.characterEffect10030.alpha = 1
			end

			local var_448_48 = arg_445_1.actors_["10030"]
			local var_448_49 = 3.034

			if var_448_49 < arg_445_1.time_ and arg_445_1.time_ <= var_448_49 + arg_448_0 and not isNil(var_448_48) and arg_445_1.var_.actorSpriteComps10030 == nil then
				arg_445_1.var_.actorSpriteComps10030 = var_448_48:GetComponentsInChildren(typeof(Image), true)
			end

			local var_448_50 = 0.2

			if var_448_49 <= arg_445_1.time_ and arg_445_1.time_ < var_448_49 + var_448_50 and not isNil(var_448_48) then
				local var_448_51 = (arg_445_1.time_ - var_448_49) / var_448_50

				if arg_445_1.var_.actorSpriteComps10030 then
					for iter_448_3, iter_448_4 in pairs(arg_445_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_448_4 then
							if arg_445_1.isInRecall_ then
								local var_448_52 = Mathf.Lerp(iter_448_4.color.r, arg_445_1.hightColor1.r, var_448_51)
								local var_448_53 = Mathf.Lerp(iter_448_4.color.g, arg_445_1.hightColor1.g, var_448_51)
								local var_448_54 = Mathf.Lerp(iter_448_4.color.b, arg_445_1.hightColor1.b, var_448_51)

								iter_448_4.color = Color.New(var_448_52, var_448_53, var_448_54)
							else
								local var_448_55 = Mathf.Lerp(iter_448_4.color.r, 1, var_448_51)

								iter_448_4.color = Color.New(var_448_55, var_448_55, var_448_55)
							end
						end
					end
				end
			end

			if arg_445_1.time_ >= var_448_49 + var_448_50 and arg_445_1.time_ < var_448_49 + var_448_50 + arg_448_0 and not isNil(var_448_48) and arg_445_1.var_.actorSpriteComps10030 then
				for iter_448_5, iter_448_6 in pairs(arg_445_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_448_6 then
						if arg_445_1.isInRecall_ then
							iter_448_6.color = arg_445_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_448_6.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_445_1.var_.actorSpriteComps10030 = nil
			end

			local var_448_56 = manager.ui.mainCamera.transform
			local var_448_57 = 1

			if var_448_57 < arg_445_1.time_ and arg_445_1.time_ <= var_448_57 + arg_448_0 then
				local var_448_58 = arg_445_1.var_.effecthuo
				local var_448_59
				local var_448_60 = var_448_56

				if not var_448_58 then
					var_448_58 = Object.Instantiate(Asset.Load("Effect/Scene/fx_ui_red"), var_448_60)
					var_448_58.name = "huo"
					arg_445_1.var_.effecthuo = var_448_58
				else
					var_448_58.transform:SetParent(var_448_60)
				end

				var_448_58.transform.localPosition = Vector3.New(0, 0.02, 0.35)
				var_448_58.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if arg_445_1.frameCnt_ <= 1 then
				arg_445_1.dialog_:SetActive(false)
			end

			local var_448_61 = 3
			local var_448_62 = 0.025

			if var_448_61 < arg_445_1.time_ and arg_445_1.time_ <= var_448_61 + arg_448_0 then
				arg_445_1.talkMaxDuration = 0

				arg_445_1.dialog_:SetActive(true)

				arg_445_1.dialogCg_.alpha = 0

				local var_448_63 = LeanTween.value(arg_445_1.dialog_, 0, 1, 0.3)

				var_448_63:setOnUpdate(LuaHelper.FloatAction(function(arg_449_0)
					arg_445_1.dialogCg_.alpha = arg_449_0
				end))
				var_448_63:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_445_1.dialog_)
					var_448_63:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_445_1.duration_ = arg_445_1.duration_ + 0.3

				SetActive(arg_445_1.leftNameGo_, true)

				local var_448_64 = arg_445_1:FormatText(StoryNameCfg[309].name)

				arg_445_1.leftNameTxt_.text = var_448_64

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_445_1.leftNameTxt_.transform)

				arg_445_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_445_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_445_1:RecordName(arg_445_1.leftNameTxt_.text)
				SetActive(arg_445_1.iconTrs_.gameObject, false)
				arg_445_1.callingController_:SetSelectedState("normal")

				local var_448_65 = arg_445_1:GetWordFromCfg(115281105)
				local var_448_66 = arg_445_1:FormatText(var_448_65.content)

				arg_445_1.text_.text = var_448_66

				LuaForUtil.ClearLinePrefixSymbol(arg_445_1.text_)

				local var_448_67 = 1
				local var_448_68 = utf8.len(var_448_66)
				local var_448_69 = var_448_67 <= 0 and var_448_62 or var_448_62 * (var_448_68 / var_448_67)

				if var_448_69 > 0 and var_448_62 < var_448_69 then
					arg_445_1.talkMaxDuration = var_448_69
					var_448_61 = var_448_61 + 0.3

					if var_448_69 + var_448_61 > arg_445_1.duration_ then
						arg_445_1.duration_ = var_448_69 + var_448_61
					end
				end

				arg_445_1.text_.text = var_448_66
				arg_445_1.typewritter.percent = 0

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115281", "115281105", "story_v_out_115281.awb") ~= 0 then
					local var_448_70 = manager.audio:GetVoiceLength("story_v_out_115281", "115281105", "story_v_out_115281.awb") / 1000

					if var_448_70 + var_448_61 > arg_445_1.duration_ then
						arg_445_1.duration_ = var_448_70 + var_448_61
					end

					if var_448_65.prefab_name ~= "" and arg_445_1.actors_[var_448_65.prefab_name] ~= nil then
						local var_448_71 = LuaForUtil.PlayVoiceWithCriLipsync(arg_445_1.actors_[var_448_65.prefab_name].transform, "story_v_out_115281", "115281105", "story_v_out_115281.awb")

						arg_445_1:RecordAudio("115281105", var_448_71)
						arg_445_1:RecordAudio("115281105", var_448_71)
					else
						arg_445_1:AudioAction("play", "voice", "story_v_out_115281", "115281105", "story_v_out_115281.awb")
					end

					arg_445_1:RecordHistoryTalkVoice("story_v_out_115281", "115281105", "story_v_out_115281.awb")
				end

				arg_445_1:RecordContent(arg_445_1.text_.text)
			end

			local var_448_72 = var_448_61 + 0.3
			local var_448_73 = math.max(var_448_62, arg_445_1.talkMaxDuration)

			if var_448_72 <= arg_445_1.time_ and arg_445_1.time_ < var_448_72 + var_448_73 then
				arg_445_1.typewritter.percent = (arg_445_1.time_ - var_448_72) / var_448_73

				arg_445_1.typewritter:SetDirty()
			end

			if arg_445_1.time_ >= var_448_72 + var_448_73 and arg_445_1.time_ < var_448_72 + var_448_73 + arg_448_0 then
				arg_445_1.typewritter.percent = 1

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(true)
			end
		end

		arg_445_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10030",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_445_1:InitPlayNodeList()
	end,
	Play115281106 = function(arg_451_0, arg_451_1)
		arg_451_1.time_ = 0
		arg_451_1.frameCnt_ = 0
		arg_451_1.state_ = "playing"
		arg_451_1.curTalkId_ = 115281106
		arg_451_1.duration_ = 5

		SetActive(arg_451_1.tipsGo_, false)

		function arg_451_1.onSingleLineFinish_()
			arg_451_1.onSingleLineUpdate_ = nil
			arg_451_1.onSingleLineFinish_ = nil
			arg_451_1.state_ = "waiting"
		end

		function arg_451_1.playNext_(arg_453_0)
			if arg_453_0 == 1 then
				arg_451_0:Play115281107(arg_451_1)
			end
		end

		function arg_451_1.onSingleLineUpdate_(arg_454_0)
			local var_454_0 = arg_451_1.actors_["10030"]
			local var_454_1 = 0

			if var_454_1 < arg_451_1.time_ and arg_451_1.time_ <= var_454_1 + arg_454_0 then
				local var_454_2 = var_454_0:GetComponentInChildren(typeof(CanvasGroup))

				if var_454_2 then
					arg_451_1.var_.alphaOldValue10030 = var_454_2.alpha
					arg_451_1.var_.characterEffect10030 = var_454_2
				end

				arg_451_1.var_.alphaOldValue10030 = 1
			end

			local var_454_3 = 0.333333333333333

			if var_454_1 <= arg_451_1.time_ and arg_451_1.time_ < var_454_1 + var_454_3 then
				local var_454_4 = (arg_451_1.time_ - var_454_1) / var_454_3
				local var_454_5 = Mathf.Lerp(arg_451_1.var_.alphaOldValue10030, 0, var_454_4)

				if arg_451_1.var_.characterEffect10030 then
					arg_451_1.var_.characterEffect10030.alpha = var_454_5
				end
			end

			if arg_451_1.time_ >= var_454_1 + var_454_3 and arg_451_1.time_ < var_454_1 + var_454_3 + arg_454_0 and arg_451_1.var_.characterEffect10030 then
				arg_451_1.var_.characterEffect10030.alpha = 0
			end

			local var_454_6 = 0
			local var_454_7 = 0.65

			if var_454_6 < arg_451_1.time_ and arg_451_1.time_ <= var_454_6 + arg_454_0 then
				arg_451_1.talkMaxDuration = 0
				arg_451_1.dialogCg_.alpha = 1

				arg_451_1.dialog_:SetActive(true)
				SetActive(arg_451_1.leftNameGo_, false)

				arg_451_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_451_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_451_1:RecordName(arg_451_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_451_1.iconTrs_.gameObject, false)
				arg_451_1.callingController_:SetSelectedState("normal")

				local var_454_8 = arg_451_1:GetWordFromCfg(115281106)
				local var_454_9 = arg_451_1:FormatText(var_454_8.content)

				arg_451_1.text_.text = var_454_9

				LuaForUtil.ClearLinePrefixSymbol(arg_451_1.text_)

				local var_454_10 = 26
				local var_454_11 = utf8.len(var_454_9)
				local var_454_12 = var_454_10 <= 0 and var_454_7 or var_454_7 * (var_454_11 / var_454_10)

				if var_454_12 > 0 and var_454_7 < var_454_12 then
					arg_451_1.talkMaxDuration = var_454_12

					if var_454_12 + var_454_6 > arg_451_1.duration_ then
						arg_451_1.duration_ = var_454_12 + var_454_6
					end
				end

				arg_451_1.text_.text = var_454_9
				arg_451_1.typewritter.percent = 0

				arg_451_1.typewritter:SetDirty()
				arg_451_1:ShowNextGo(false)
				arg_451_1:RecordContent(arg_451_1.text_.text)
			end

			local var_454_13 = math.max(var_454_7, arg_451_1.talkMaxDuration)

			if var_454_6 <= arg_451_1.time_ and arg_451_1.time_ < var_454_6 + var_454_13 then
				arg_451_1.typewritter.percent = (arg_451_1.time_ - var_454_6) / var_454_13

				arg_451_1.typewritter:SetDirty()
			end

			if arg_451_1.time_ >= var_454_6 + var_454_13 and arg_451_1.time_ < var_454_6 + var_454_13 + arg_454_0 then
				arg_451_1.typewritter.percent = 1

				arg_451_1.typewritter:SetDirty()
				arg_451_1:ShowNextGo(true)
			end
		end

		arg_451_1.nodeConfigList_ = {}

		arg_451_1:InitPlayNodeList()
	end,
	Play115281107 = function(arg_455_0, arg_455_1)
		arg_455_1.time_ = 0
		arg_455_1.frameCnt_ = 0
		arg_455_1.state_ = "playing"
		arg_455_1.curTalkId_ = 115281107
		arg_455_1.duration_ = 5

		SetActive(arg_455_1.tipsGo_, false)

		function arg_455_1.onSingleLineFinish_()
			arg_455_1.onSingleLineUpdate_ = nil
			arg_455_1.onSingleLineFinish_ = nil
			arg_455_1.state_ = "waiting"
		end

		function arg_455_1.playNext_(arg_457_0)
			if arg_457_0 == 1 then
				arg_455_0:Play115281108(arg_455_1)
			end
		end

		function arg_455_1.onSingleLineUpdate_(arg_458_0)
			local var_458_0 = 0
			local var_458_1 = 1

			if var_458_0 < arg_455_1.time_ and arg_455_1.time_ <= var_458_0 + arg_458_0 then
				local var_458_2 = "play"
				local var_458_3 = "effect"

				arg_455_1:AudioAction(var_458_2, var_458_3, "se_story_activity_1_5_3", "se_story_activity_1_5_3_fireworks04", "")
			end

			local var_458_4 = 0
			local var_458_5 = 1.175

			if var_458_4 < arg_455_1.time_ and arg_455_1.time_ <= var_458_4 + arg_458_0 then
				arg_455_1.talkMaxDuration = 0
				arg_455_1.dialogCg_.alpha = 1

				arg_455_1.dialog_:SetActive(true)
				SetActive(arg_455_1.leftNameGo_, false)

				arg_455_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_455_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_455_1:RecordName(arg_455_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_455_1.iconTrs_.gameObject, false)
				arg_455_1.callingController_:SetSelectedState("normal")

				local var_458_6 = arg_455_1:GetWordFromCfg(115281107)
				local var_458_7 = arg_455_1:FormatText(var_458_6.content)

				arg_455_1.text_.text = var_458_7

				LuaForUtil.ClearLinePrefixSymbol(arg_455_1.text_)

				local var_458_8 = 47
				local var_458_9 = utf8.len(var_458_7)
				local var_458_10 = var_458_8 <= 0 and var_458_5 or var_458_5 * (var_458_9 / var_458_8)

				if var_458_10 > 0 and var_458_5 < var_458_10 then
					arg_455_1.talkMaxDuration = var_458_10

					if var_458_10 + var_458_4 > arg_455_1.duration_ then
						arg_455_1.duration_ = var_458_10 + var_458_4
					end
				end

				arg_455_1.text_.text = var_458_7
				arg_455_1.typewritter.percent = 0

				arg_455_1.typewritter:SetDirty()
				arg_455_1:ShowNextGo(false)
				arg_455_1:RecordContent(arg_455_1.text_.text)
			end

			local var_458_11 = math.max(var_458_5, arg_455_1.talkMaxDuration)

			if var_458_4 <= arg_455_1.time_ and arg_455_1.time_ < var_458_4 + var_458_11 then
				arg_455_1.typewritter.percent = (arg_455_1.time_ - var_458_4) / var_458_11

				arg_455_1.typewritter:SetDirty()
			end

			if arg_455_1.time_ >= var_458_4 + var_458_11 and arg_455_1.time_ < var_458_4 + var_458_11 + arg_458_0 then
				arg_455_1.typewritter.percent = 1

				arg_455_1.typewritter:SetDirty()
				arg_455_1:ShowNextGo(true)
			end
		end

		arg_455_1.nodeConfigList_ = {}

		arg_455_1:InitPlayNodeList()
	end,
	Play115281108 = function(arg_459_0, arg_459_1)
		arg_459_1.time_ = 0
		arg_459_1.frameCnt_ = 0
		arg_459_1.state_ = "playing"
		arg_459_1.curTalkId_ = 115281108
		arg_459_1.duration_ = 5

		SetActive(arg_459_1.tipsGo_, false)

		function arg_459_1.onSingleLineFinish_()
			arg_459_1.onSingleLineUpdate_ = nil
			arg_459_1.onSingleLineFinish_ = nil
			arg_459_1.state_ = "waiting"
		end

		function arg_459_1.playNext_(arg_461_0)
			if arg_461_0 == 1 then
				arg_459_0:Play115281109(arg_459_1)
			end
		end

		function arg_459_1.onSingleLineUpdate_(arg_462_0)
			local var_462_0 = 0
			local var_462_1 = 1.05

			if var_462_0 < arg_459_1.time_ and arg_459_1.time_ <= var_462_0 + arg_462_0 then
				arg_459_1.talkMaxDuration = 0
				arg_459_1.dialogCg_.alpha = 1

				arg_459_1.dialog_:SetActive(true)
				SetActive(arg_459_1.leftNameGo_, false)

				arg_459_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_459_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_459_1:RecordName(arg_459_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_459_1.iconTrs_.gameObject, false)
				arg_459_1.callingController_:SetSelectedState("normal")

				local var_462_2 = arg_459_1:GetWordFromCfg(115281108)
				local var_462_3 = arg_459_1:FormatText(var_462_2.content)

				arg_459_1.text_.text = var_462_3

				LuaForUtil.ClearLinePrefixSymbol(arg_459_1.text_)

				local var_462_4 = 42
				local var_462_5 = utf8.len(var_462_3)
				local var_462_6 = var_462_4 <= 0 and var_462_1 or var_462_1 * (var_462_5 / var_462_4)

				if var_462_6 > 0 and var_462_1 < var_462_6 then
					arg_459_1.talkMaxDuration = var_462_6

					if var_462_6 + var_462_0 > arg_459_1.duration_ then
						arg_459_1.duration_ = var_462_6 + var_462_0
					end
				end

				arg_459_1.text_.text = var_462_3
				arg_459_1.typewritter.percent = 0

				arg_459_1.typewritter:SetDirty()
				arg_459_1:ShowNextGo(false)
				arg_459_1:RecordContent(arg_459_1.text_.text)
			end

			local var_462_7 = math.max(var_462_1, arg_459_1.talkMaxDuration)

			if var_462_0 <= arg_459_1.time_ and arg_459_1.time_ < var_462_0 + var_462_7 then
				arg_459_1.typewritter.percent = (arg_459_1.time_ - var_462_0) / var_462_7

				arg_459_1.typewritter:SetDirty()
			end

			if arg_459_1.time_ >= var_462_0 + var_462_7 and arg_459_1.time_ < var_462_0 + var_462_7 + arg_462_0 then
				arg_459_1.typewritter.percent = 1

				arg_459_1.typewritter:SetDirty()
				arg_459_1:ShowNextGo(true)
			end
		end

		arg_459_1.nodeConfigList_ = {}

		arg_459_1:InitPlayNodeList()
	end,
	Play115281109 = function(arg_463_0, arg_463_1)
		arg_463_1.time_ = 0
		arg_463_1.frameCnt_ = 0
		arg_463_1.state_ = "playing"
		arg_463_1.curTalkId_ = 115281109
		arg_463_1.duration_ = 2.33

		local var_463_0 = {
			ja = 1.1,
			ko = 1.033,
			zh = 2.333,
			en = 1
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
				arg_463_0:Play115281110(arg_463_1)
			end
		end

		function arg_463_1.onSingleLineUpdate_(arg_466_0)
			local var_466_0 = arg_463_1.actors_["1038"].transform
			local var_466_1 = 0

			if var_466_1 < arg_463_1.time_ and arg_463_1.time_ <= var_466_1 + arg_466_0 then
				arg_463_1.var_.moveOldPos1038 = var_466_0.localPosition
				var_466_0.localScale = Vector3.New(1, 1, 1)

				arg_463_1:CheckSpriteTmpPos("1038", 3)

				local var_466_2 = var_466_0.childCount

				for iter_466_0 = 0, var_466_2 - 1 do
					local var_466_3 = var_466_0:GetChild(iter_466_0)

					if var_466_3.name == "split_5" or not string.find(var_466_3.name, "split") then
						var_466_3.gameObject:SetActive(true)
					else
						var_466_3.gameObject:SetActive(false)
					end
				end
			end

			local var_466_4 = 0.001

			if var_466_1 <= arg_463_1.time_ and arg_463_1.time_ < var_466_1 + var_466_4 then
				local var_466_5 = (arg_463_1.time_ - var_466_1) / var_466_4
				local var_466_6 = Vector3.New(0, -400, 0)

				var_466_0.localPosition = Vector3.Lerp(arg_463_1.var_.moveOldPos1038, var_466_6, var_466_5)
			end

			if arg_463_1.time_ >= var_466_1 + var_466_4 and arg_463_1.time_ < var_466_1 + var_466_4 + arg_466_0 then
				var_466_0.localPosition = Vector3.New(0, -400, 0)
			end

			local var_466_7 = arg_463_1.actors_["1038"]
			local var_466_8 = 0

			if var_466_8 < arg_463_1.time_ and arg_463_1.time_ <= var_466_8 + arg_466_0 and not isNil(var_466_7) and arg_463_1.var_.actorSpriteComps1038 == nil then
				arg_463_1.var_.actorSpriteComps1038 = var_466_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_466_9 = 0.2

			if var_466_8 <= arg_463_1.time_ and arg_463_1.time_ < var_466_8 + var_466_9 and not isNil(var_466_7) then
				local var_466_10 = (arg_463_1.time_ - var_466_8) / var_466_9

				if arg_463_1.var_.actorSpriteComps1038 then
					for iter_466_1, iter_466_2 in pairs(arg_463_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_466_2 then
							if arg_463_1.isInRecall_ then
								local var_466_11 = Mathf.Lerp(iter_466_2.color.r, arg_463_1.hightColor1.r, var_466_10)
								local var_466_12 = Mathf.Lerp(iter_466_2.color.g, arg_463_1.hightColor1.g, var_466_10)
								local var_466_13 = Mathf.Lerp(iter_466_2.color.b, arg_463_1.hightColor1.b, var_466_10)

								iter_466_2.color = Color.New(var_466_11, var_466_12, var_466_13)
							else
								local var_466_14 = Mathf.Lerp(iter_466_2.color.r, 1, var_466_10)

								iter_466_2.color = Color.New(var_466_14, var_466_14, var_466_14)
							end
						end
					end
				end
			end

			if arg_463_1.time_ >= var_466_8 + var_466_9 and arg_463_1.time_ < var_466_8 + var_466_9 + arg_466_0 and not isNil(var_466_7) and arg_463_1.var_.actorSpriteComps1038 then
				for iter_466_3, iter_466_4 in pairs(arg_463_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_466_4 then
						if arg_463_1.isInRecall_ then
							iter_466_4.color = arg_463_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_466_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_463_1.var_.actorSpriteComps1038 = nil
			end

			local var_466_15 = arg_463_1.actors_["1038"]
			local var_466_16 = 0

			if var_466_16 < arg_463_1.time_ and arg_463_1.time_ <= var_466_16 + arg_466_0 then
				local var_466_17 = var_466_15:GetComponentInChildren(typeof(CanvasGroup))

				if var_466_17 then
					arg_463_1.var_.alphaOldValue1038 = var_466_17.alpha
					arg_463_1.var_.characterEffect1038 = var_466_17
				end

				arg_463_1.var_.alphaOldValue1038 = 0
			end

			local var_466_18 = 0.333333333333333

			if var_466_16 <= arg_463_1.time_ and arg_463_1.time_ < var_466_16 + var_466_18 then
				local var_466_19 = (arg_463_1.time_ - var_466_16) / var_466_18
				local var_466_20 = Mathf.Lerp(arg_463_1.var_.alphaOldValue1038, 1, var_466_19)

				if arg_463_1.var_.characterEffect1038 then
					arg_463_1.var_.characterEffect1038.alpha = var_466_20
				end
			end

			if arg_463_1.time_ >= var_466_16 + var_466_18 and arg_463_1.time_ < var_466_16 + var_466_18 + arg_466_0 and arg_463_1.var_.characterEffect1038 then
				arg_463_1.var_.characterEffect1038.alpha = 1
			end

			local var_466_21 = manager.ui.mainCamera.transform
			local var_466_22 = 0

			if var_466_22 < arg_463_1.time_ and arg_463_1.time_ <= var_466_22 + arg_466_0 then
				arg_463_1.var_.shakeOldPos = var_466_21.localPosition
			end

			local var_466_23 = 0.333333333333333

			if var_466_22 <= arg_463_1.time_ and arg_463_1.time_ < var_466_22 + var_466_23 then
				local var_466_24 = (arg_463_1.time_ - var_466_22) / 0.066
				local var_466_25, var_466_26 = math.modf(var_466_24)

				var_466_21.localPosition = Vector3.New(var_466_26 * 0.13, var_466_26 * 0.13, var_466_26 * 0.13) + arg_463_1.var_.shakeOldPos
			end

			if arg_463_1.time_ >= var_466_22 + var_466_23 and arg_463_1.time_ < var_466_22 + var_466_23 + arg_466_0 then
				var_466_21.localPosition = arg_463_1.var_.shakeOldPos
			end

			local var_466_27 = 0
			local var_466_28 = 0.125

			if var_466_27 < arg_463_1.time_ and arg_463_1.time_ <= var_466_27 + arg_466_0 then
				arg_463_1.talkMaxDuration = 0
				arg_463_1.dialogCg_.alpha = 1

				arg_463_1.dialog_:SetActive(true)
				SetActive(arg_463_1.leftNameGo_, true)

				local var_466_29 = arg_463_1:FormatText(StoryNameCfg[94].name)

				arg_463_1.leftNameTxt_.text = var_466_29

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_463_1.leftNameTxt_.transform)

				arg_463_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_463_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_463_1:RecordName(arg_463_1.leftNameTxt_.text)
				SetActive(arg_463_1.iconTrs_.gameObject, false)
				arg_463_1.callingController_:SetSelectedState("normal")

				local var_466_30 = arg_463_1:GetWordFromCfg(115281109)
				local var_466_31 = arg_463_1:FormatText(var_466_30.content)

				arg_463_1.text_.text = var_466_31

				LuaForUtil.ClearLinePrefixSymbol(arg_463_1.text_)

				local var_466_32 = 5
				local var_466_33 = utf8.len(var_466_31)
				local var_466_34 = var_466_32 <= 0 and var_466_28 or var_466_28 * (var_466_33 / var_466_32)

				if var_466_34 > 0 and var_466_28 < var_466_34 then
					arg_463_1.talkMaxDuration = var_466_34

					if var_466_34 + var_466_27 > arg_463_1.duration_ then
						arg_463_1.duration_ = var_466_34 + var_466_27
					end
				end

				arg_463_1.text_.text = var_466_31
				arg_463_1.typewritter.percent = 0

				arg_463_1.typewritter:SetDirty()
				arg_463_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115281", "115281109", "story_v_out_115281.awb") ~= 0 then
					local var_466_35 = manager.audio:GetVoiceLength("story_v_out_115281", "115281109", "story_v_out_115281.awb") / 1000

					if var_466_35 + var_466_27 > arg_463_1.duration_ then
						arg_463_1.duration_ = var_466_35 + var_466_27
					end

					if var_466_30.prefab_name ~= "" and arg_463_1.actors_[var_466_30.prefab_name] ~= nil then
						local var_466_36 = LuaForUtil.PlayVoiceWithCriLipsync(arg_463_1.actors_[var_466_30.prefab_name].transform, "story_v_out_115281", "115281109", "story_v_out_115281.awb")

						arg_463_1:RecordAudio("115281109", var_466_36)
						arg_463_1:RecordAudio("115281109", var_466_36)
					else
						arg_463_1:AudioAction("play", "voice", "story_v_out_115281", "115281109", "story_v_out_115281.awb")
					end

					arg_463_1:RecordHistoryTalkVoice("story_v_out_115281", "115281109", "story_v_out_115281.awb")
				end

				arg_463_1:RecordContent(arg_463_1.text_.text)
			end

			local var_466_37 = math.max(var_466_28, arg_463_1.talkMaxDuration)

			if var_466_27 <= arg_463_1.time_ and arg_463_1.time_ < var_466_27 + var_466_37 then
				arg_463_1.typewritter.percent = (arg_463_1.time_ - var_466_27) / var_466_37

				arg_463_1.typewritter:SetDirty()
			end

			if arg_463_1.time_ >= var_466_27 + var_466_37 and arg_463_1.time_ < var_466_27 + var_466_37 + arg_466_0 then
				arg_463_1.typewritter.percent = 1

				arg_463_1.typewritter:SetDirty()
				arg_463_1:ShowNextGo(true)
			end
		end

		arg_463_1.nodeConfigList_ = {
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

		arg_463_1:InitPlayNodeList()
	end,
	Play115281110 = function(arg_467_0, arg_467_1)
		arg_467_1.time_ = 0
		arg_467_1.frameCnt_ = 0
		arg_467_1.state_ = "playing"
		arg_467_1.curTalkId_ = 115281110
		arg_467_1.duration_ = 5

		SetActive(arg_467_1.tipsGo_, false)

		function arg_467_1.onSingleLineFinish_()
			arg_467_1.onSingleLineUpdate_ = nil
			arg_467_1.onSingleLineFinish_ = nil
			arg_467_1.state_ = "waiting"
		end

		function arg_467_1.playNext_(arg_469_0)
			if arg_469_0 == 1 then
				arg_467_0:Play115281111(arg_467_1)
			end
		end

		function arg_467_1.onSingleLineUpdate_(arg_470_0)
			local var_470_0 = arg_467_1.actors_["1038"]
			local var_470_1 = 0

			if var_470_1 < arg_467_1.time_ and arg_467_1.time_ <= var_470_1 + arg_470_0 then
				local var_470_2 = var_470_0:GetComponentInChildren(typeof(CanvasGroup))

				if var_470_2 then
					arg_467_1.var_.alphaOldValue1038 = var_470_2.alpha
					arg_467_1.var_.characterEffect1038 = var_470_2
				end

				arg_467_1.var_.alphaOldValue1038 = 1
			end

			local var_470_3 = 0.333333333333333

			if var_470_1 <= arg_467_1.time_ and arg_467_1.time_ < var_470_1 + var_470_3 then
				local var_470_4 = (arg_467_1.time_ - var_470_1) / var_470_3
				local var_470_5 = Mathf.Lerp(arg_467_1.var_.alphaOldValue1038, 0, var_470_4)

				if arg_467_1.var_.characterEffect1038 then
					arg_467_1.var_.characterEffect1038.alpha = var_470_5
				end
			end

			if arg_467_1.time_ >= var_470_1 + var_470_3 and arg_467_1.time_ < var_470_1 + var_470_3 + arg_470_0 and arg_467_1.var_.characterEffect1038 then
				arg_467_1.var_.characterEffect1038.alpha = 0
			end

			local var_470_6 = 0
			local var_470_7 = 0.975

			if var_470_6 < arg_467_1.time_ and arg_467_1.time_ <= var_470_6 + arg_470_0 then
				arg_467_1.talkMaxDuration = 0
				arg_467_1.dialogCg_.alpha = 1

				arg_467_1.dialog_:SetActive(true)
				SetActive(arg_467_1.leftNameGo_, false)

				arg_467_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_467_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_467_1:RecordName(arg_467_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_467_1.iconTrs_.gameObject, false)
				arg_467_1.callingController_:SetSelectedState("normal")

				local var_470_8 = arg_467_1:GetWordFromCfg(115281110)
				local var_470_9 = arg_467_1:FormatText(var_470_8.content)

				arg_467_1.text_.text = var_470_9

				LuaForUtil.ClearLinePrefixSymbol(arg_467_1.text_)

				local var_470_10 = 39
				local var_470_11 = utf8.len(var_470_9)
				local var_470_12 = var_470_10 <= 0 and var_470_7 or var_470_7 * (var_470_11 / var_470_10)

				if var_470_12 > 0 and var_470_7 < var_470_12 then
					arg_467_1.talkMaxDuration = var_470_12

					if var_470_12 + var_470_6 > arg_467_1.duration_ then
						arg_467_1.duration_ = var_470_12 + var_470_6
					end
				end

				arg_467_1.text_.text = var_470_9
				arg_467_1.typewritter.percent = 0

				arg_467_1.typewritter:SetDirty()
				arg_467_1:ShowNextGo(false)
				arg_467_1:RecordContent(arg_467_1.text_.text)
			end

			local var_470_13 = math.max(var_470_7, arg_467_1.talkMaxDuration)

			if var_470_6 <= arg_467_1.time_ and arg_467_1.time_ < var_470_6 + var_470_13 then
				arg_467_1.typewritter.percent = (arg_467_1.time_ - var_470_6) / var_470_13

				arg_467_1.typewritter:SetDirty()
			end

			if arg_467_1.time_ >= var_470_6 + var_470_13 and arg_467_1.time_ < var_470_6 + var_470_13 + arg_470_0 then
				arg_467_1.typewritter.percent = 1

				arg_467_1.typewritter:SetDirty()
				arg_467_1:ShowNextGo(true)
			end
		end

		arg_467_1.nodeConfigList_ = {}

		arg_467_1:InitPlayNodeList()
	end,
	Play115281111 = function(arg_471_0, arg_471_1)
		arg_471_1.time_ = 0
		arg_471_1.frameCnt_ = 0
		arg_471_1.state_ = "playing"
		arg_471_1.curTalkId_ = 115281111
		arg_471_1.duration_ = 5

		SetActive(arg_471_1.tipsGo_, false)

		function arg_471_1.onSingleLineFinish_()
			arg_471_1.onSingleLineUpdate_ = nil
			arg_471_1.onSingleLineFinish_ = nil
			arg_471_1.state_ = "waiting"
		end

		function arg_471_1.playNext_(arg_473_0)
			if arg_473_0 == 1 then
				arg_471_0:Play115281112(arg_471_1)
			end
		end

		function arg_471_1.onSingleLineUpdate_(arg_474_0)
			local var_474_0 = 0
			local var_474_1 = 1.2

			if var_474_0 < arg_471_1.time_ and arg_471_1.time_ <= var_474_0 + arg_474_0 then
				arg_471_1.talkMaxDuration = 0
				arg_471_1.dialogCg_.alpha = 1

				arg_471_1.dialog_:SetActive(true)
				SetActive(arg_471_1.leftNameGo_, false)

				arg_471_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_471_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_471_1:RecordName(arg_471_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_471_1.iconTrs_.gameObject, false)
				arg_471_1.callingController_:SetSelectedState("normal")

				local var_474_2 = arg_471_1:GetWordFromCfg(115281111)
				local var_474_3 = arg_471_1:FormatText(var_474_2.content)

				arg_471_1.text_.text = var_474_3

				LuaForUtil.ClearLinePrefixSymbol(arg_471_1.text_)

				local var_474_4 = 48
				local var_474_5 = utf8.len(var_474_3)
				local var_474_6 = var_474_4 <= 0 and var_474_1 or var_474_1 * (var_474_5 / var_474_4)

				if var_474_6 > 0 and var_474_1 < var_474_6 then
					arg_471_1.talkMaxDuration = var_474_6

					if var_474_6 + var_474_0 > arg_471_1.duration_ then
						arg_471_1.duration_ = var_474_6 + var_474_0
					end
				end

				arg_471_1.text_.text = var_474_3
				arg_471_1.typewritter.percent = 0

				arg_471_1.typewritter:SetDirty()
				arg_471_1:ShowNextGo(false)
				arg_471_1:RecordContent(arg_471_1.text_.text)
			end

			local var_474_7 = math.max(var_474_1, arg_471_1.talkMaxDuration)

			if var_474_0 <= arg_471_1.time_ and arg_471_1.time_ < var_474_0 + var_474_7 then
				arg_471_1.typewritter.percent = (arg_471_1.time_ - var_474_0) / var_474_7

				arg_471_1.typewritter:SetDirty()
			end

			if arg_471_1.time_ >= var_474_0 + var_474_7 and arg_471_1.time_ < var_474_0 + var_474_7 + arg_474_0 then
				arg_471_1.typewritter.percent = 1

				arg_471_1.typewritter:SetDirty()
				arg_471_1:ShowNextGo(true)
			end
		end

		arg_471_1.nodeConfigList_ = {}

		arg_471_1:InitPlayNodeList()
	end,
	Play115281112 = function(arg_475_0, arg_475_1)
		arg_475_1.time_ = 0
		arg_475_1.frameCnt_ = 0
		arg_475_1.state_ = "playing"
		arg_475_1.curTalkId_ = 115281112
		arg_475_1.duration_ = 5

		SetActive(arg_475_1.tipsGo_, false)

		function arg_475_1.onSingleLineFinish_()
			arg_475_1.onSingleLineUpdate_ = nil
			arg_475_1.onSingleLineFinish_ = nil
			arg_475_1.state_ = "waiting"
		end

		function arg_475_1.playNext_(arg_477_0)
			if arg_477_0 == 1 then
				arg_475_0:Play115281113(arg_475_1)
			end
		end

		function arg_475_1.onSingleLineUpdate_(arg_478_0)
			local var_478_0 = 0
			local var_478_1 = 1.25

			if var_478_0 < arg_475_1.time_ and arg_475_1.time_ <= var_478_0 + arg_478_0 then
				arg_475_1.talkMaxDuration = 0
				arg_475_1.dialogCg_.alpha = 1

				arg_475_1.dialog_:SetActive(true)
				SetActive(arg_475_1.leftNameGo_, false)

				arg_475_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_475_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_475_1:RecordName(arg_475_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_475_1.iconTrs_.gameObject, false)
				arg_475_1.callingController_:SetSelectedState("normal")

				local var_478_2 = arg_475_1:GetWordFromCfg(115281112)
				local var_478_3 = arg_475_1:FormatText(var_478_2.content)

				arg_475_1.text_.text = var_478_3

				LuaForUtil.ClearLinePrefixSymbol(arg_475_1.text_)

				local var_478_4 = 50
				local var_478_5 = utf8.len(var_478_3)
				local var_478_6 = var_478_4 <= 0 and var_478_1 or var_478_1 * (var_478_5 / var_478_4)

				if var_478_6 > 0 and var_478_1 < var_478_6 then
					arg_475_1.talkMaxDuration = var_478_6

					if var_478_6 + var_478_0 > arg_475_1.duration_ then
						arg_475_1.duration_ = var_478_6 + var_478_0
					end
				end

				arg_475_1.text_.text = var_478_3
				arg_475_1.typewritter.percent = 0

				arg_475_1.typewritter:SetDirty()
				arg_475_1:ShowNextGo(false)
				arg_475_1:RecordContent(arg_475_1.text_.text)
			end

			local var_478_7 = math.max(var_478_1, arg_475_1.talkMaxDuration)

			if var_478_0 <= arg_475_1.time_ and arg_475_1.time_ < var_478_0 + var_478_7 then
				arg_475_1.typewritter.percent = (arg_475_1.time_ - var_478_0) / var_478_7

				arg_475_1.typewritter:SetDirty()
			end

			if arg_475_1.time_ >= var_478_0 + var_478_7 and arg_475_1.time_ < var_478_0 + var_478_7 + arg_478_0 then
				arg_475_1.typewritter.percent = 1

				arg_475_1.typewritter:SetDirty()
				arg_475_1:ShowNextGo(true)
			end
		end

		arg_475_1.nodeConfigList_ = {}

		arg_475_1:InitPlayNodeList()
	end,
	Play115281113 = function(arg_479_0, arg_479_1)
		arg_479_1.time_ = 0
		arg_479_1.frameCnt_ = 0
		arg_479_1.state_ = "playing"
		arg_479_1.curTalkId_ = 115281113
		arg_479_1.duration_ = 5

		SetActive(arg_479_1.tipsGo_, false)

		function arg_479_1.onSingleLineFinish_()
			arg_479_1.onSingleLineUpdate_ = nil
			arg_479_1.onSingleLineFinish_ = nil
			arg_479_1.state_ = "waiting"
		end

		function arg_479_1.playNext_(arg_481_0)
			if arg_481_0 == 1 then
				arg_479_0:Play115281114(arg_479_1)
			end
		end

		function arg_479_1.onSingleLineUpdate_(arg_482_0)
			local var_482_0 = 1.01666666666667

			if var_482_0 < arg_479_1.time_ and arg_479_1.time_ <= var_482_0 + arg_482_0 then
				local var_482_1 = manager.ui.mainCamera.transform.localPosition
				local var_482_2 = Vector3.New(0, 0, 10) + Vector3.New(var_482_1.x, var_482_1.y, 0)
				local var_482_3 = arg_479_1.bgs_.STblack

				var_482_3.transform.localPosition = var_482_2
				var_482_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_482_4 = var_482_3:GetComponent("SpriteRenderer")

				if var_482_4 and var_482_4.sprite then
					local var_482_5 = (var_482_3.transform.localPosition - var_482_1).z
					local var_482_6 = manager.ui.mainCameraCom_
					local var_482_7 = 2 * var_482_5 * Mathf.Tan(var_482_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_482_8 = var_482_7 * var_482_6.aspect
					local var_482_9 = var_482_4.sprite.bounds.size.x
					local var_482_10 = var_482_4.sprite.bounds.size.y
					local var_482_11 = var_482_8 / var_482_9
					local var_482_12 = var_482_7 / var_482_10
					local var_482_13 = var_482_12 < var_482_11 and var_482_11 or var_482_12

					var_482_3.transform.localScale = Vector3.New(var_482_13, var_482_13, 0)
				end

				for iter_482_0, iter_482_1 in pairs(arg_479_1.bgs_) do
					if iter_482_0 ~= "STblack" then
						iter_482_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_482_14 = 3

			if var_482_14 < arg_479_1.time_ and arg_479_1.time_ <= var_482_14 + arg_482_0 then
				arg_479_1.fswbg_:SetActive(true)
				arg_479_1.dialog_:SetActive(false)

				arg_479_1.fswtw_.percent = 0

				local var_482_15 = arg_479_1:GetWordFromCfg(115281113)
				local var_482_16 = arg_479_1:FormatText(var_482_15.content)

				arg_479_1.fswt_.text = var_482_16

				LuaForUtil.ClearLinePrefixSymbol(arg_479_1.fswt_)

				arg_479_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_479_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_479_1.fswtw_:SetDirty()

				arg_479_1.typewritterCharCountI18N = 0

				SetActive(arg_479_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_479_1:ShowNextGo(false)
			end

			local var_482_17 = 3.01666666666667

			if var_482_17 < arg_479_1.time_ and arg_479_1.time_ <= var_482_17 + arg_482_0 then
				arg_479_1.var_.oldValueTypewriter = arg_479_1.fswtw_.percent

				SetActive(arg_479_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_479_1:ShowNextGo(false)
			end

			local var_482_18 = 15
			local var_482_19 = 1
			local var_482_20 = arg_479_1:GetWordFromCfg(115281113)
			local var_482_21 = arg_479_1:FormatText(var_482_20.content)
			local var_482_22, var_482_23 = arg_479_1:GetPercentByPara(var_482_21, 1)

			if var_482_17 < arg_479_1.time_ and arg_479_1.time_ <= var_482_17 + arg_482_0 then
				arg_479_1.talkMaxDuration = 0

				local var_482_24 = var_482_18 <= 0 and var_482_19 or var_482_19 * ((var_482_23 - arg_479_1.typewritterCharCountI18N) / var_482_18)

				if var_482_24 > 0 and var_482_19 < var_482_24 then
					arg_479_1.talkMaxDuration = var_482_24

					if var_482_24 + var_482_17 > arg_479_1.duration_ then
						arg_479_1.duration_ = var_482_24 + var_482_17
					end
				end
			end

			local var_482_25 = 1
			local var_482_26 = math.max(var_482_25, arg_479_1.talkMaxDuration)

			if var_482_17 <= arg_479_1.time_ and arg_479_1.time_ < var_482_17 + var_482_26 then
				local var_482_27 = (arg_479_1.time_ - var_482_17) / var_482_26

				arg_479_1.fswtw_.percent = Mathf.Lerp(arg_479_1.var_.oldValueTypewriter, var_482_22, var_482_27)
				arg_479_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_479_1.fswtw_:SetDirty()
			end

			if arg_479_1.time_ >= var_482_17 + var_482_26 and arg_479_1.time_ < var_482_17 + var_482_26 + arg_482_0 then
				arg_479_1.fswtw_.percent = var_482_22

				arg_479_1.fswtw_:SetDirty()
				arg_479_1:ShowNextGo(true)

				arg_479_1.typewritterCharCountI18N = var_482_23
			end

			local var_482_28 = manager.ui.mainCamera.transform
			local var_482_29 = 1

			if var_482_29 < arg_479_1.time_ and arg_479_1.time_ <= var_482_29 + arg_482_0 then
				local var_482_30 = arg_479_1.var_.effecthuo

				if var_482_30 then
					Object.Destroy(var_482_30)

					arg_479_1.var_.effecthuo = nil
				end
			end

			local var_482_31 = 0

			if var_482_31 < arg_479_1.time_ and arg_479_1.time_ <= var_482_31 + arg_482_0 then
				arg_479_1.mask_.enabled = true
				arg_479_1.mask_.raycastTarget = true

				arg_479_1:SetGaussion(false)
			end

			local var_482_32 = 1.01666666666667

			if var_482_31 <= arg_479_1.time_ and arg_479_1.time_ < var_482_31 + var_482_32 then
				local var_482_33 = (arg_479_1.time_ - var_482_31) / var_482_32
				local var_482_34 = Color.New(0, 0, 0)

				var_482_34.a = Mathf.Lerp(0, 1, var_482_33)
				arg_479_1.mask_.color = var_482_34
			end

			if arg_479_1.time_ >= var_482_31 + var_482_32 and arg_479_1.time_ < var_482_31 + var_482_32 + arg_482_0 then
				local var_482_35 = Color.New(0, 0, 0)

				var_482_35.a = 1
				arg_479_1.mask_.color = var_482_35
			end

			local var_482_36 = 1.01666666666667

			if var_482_36 < arg_479_1.time_ and arg_479_1.time_ <= var_482_36 + arg_482_0 then
				arg_479_1.mask_.enabled = true
				arg_479_1.mask_.raycastTarget = true

				arg_479_1:SetGaussion(false)
			end

			local var_482_37 = 1.01666666666667

			if var_482_36 <= arg_479_1.time_ and arg_479_1.time_ < var_482_36 + var_482_37 then
				local var_482_38 = (arg_479_1.time_ - var_482_36) / var_482_37
				local var_482_39 = Color.New(0, 0, 0)

				var_482_39.a = Mathf.Lerp(1, 0, var_482_38)
				arg_479_1.mask_.color = var_482_39
			end

			if arg_479_1.time_ >= var_482_36 + var_482_37 and arg_479_1.time_ < var_482_36 + var_482_37 + arg_482_0 then
				local var_482_40 = Color.New(0, 0, 0)
				local var_482_41 = 0

				arg_479_1.mask_.enabled = false
				var_482_40.a = var_482_41
				arg_479_1.mask_.color = var_482_40
			end
		end

		arg_479_1.nodeConfigList_ = {}

		arg_479_1:InitPlayNodeList()
	end,
	Play115281114 = function(arg_483_0, arg_483_1)
		arg_483_1.time_ = 0
		arg_483_1.frameCnt_ = 0
		arg_483_1.state_ = "playing"
		arg_483_1.curTalkId_ = 115281114
		arg_483_1.duration_ = 1.2

		SetActive(arg_483_1.tipsGo_, false)

		function arg_483_1.onSingleLineFinish_()
			arg_483_1.onSingleLineUpdate_ = nil
			arg_483_1.onSingleLineFinish_ = nil
			arg_483_1.state_ = "waiting"
		end

		function arg_483_1.playNext_(arg_485_0)
			if arg_485_0 == 1 then
				arg_483_0:Play115281115(arg_483_1)
			end
		end

		function arg_483_1.onSingleLineUpdate_(arg_486_0)
			local var_486_0 = 0

			if var_486_0 < arg_483_1.time_ and arg_483_1.time_ <= var_486_0 + arg_486_0 then
				arg_483_1.var_.oldValueTypewriter = arg_483_1.fswtw_.percent

				SetActive(arg_483_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_483_1:ShowNextGo(false)
			end

			local var_486_1 = 18
			local var_486_2 = 1.2
			local var_486_3 = arg_483_1:GetWordFromCfg(115281113)
			local var_486_4 = arg_483_1:FormatText(var_486_3.content)
			local var_486_5, var_486_6 = arg_483_1:GetPercentByPara(var_486_4, 2)

			if var_486_0 < arg_483_1.time_ and arg_483_1.time_ <= var_486_0 + arg_486_0 then
				arg_483_1.talkMaxDuration = 0

				local var_486_7 = var_486_1 <= 0 and var_486_2 or var_486_2 * ((var_486_6 - arg_483_1.typewritterCharCountI18N) / var_486_1)

				if var_486_7 > 0 and var_486_2 < var_486_7 then
					arg_483_1.talkMaxDuration = var_486_7

					if var_486_7 + var_486_0 > arg_483_1.duration_ then
						arg_483_1.duration_ = var_486_7 + var_486_0
					end
				end
			end

			local var_486_8 = 1.2
			local var_486_9 = math.max(var_486_8, arg_483_1.talkMaxDuration)

			if var_486_0 <= arg_483_1.time_ and arg_483_1.time_ < var_486_0 + var_486_9 then
				local var_486_10 = (arg_483_1.time_ - var_486_0) / var_486_9

				arg_483_1.fswtw_.percent = Mathf.Lerp(arg_483_1.var_.oldValueTypewriter, var_486_5, var_486_10)
				arg_483_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_483_1.fswtw_:SetDirty()
			end

			if arg_483_1.time_ >= var_486_0 + var_486_9 and arg_483_1.time_ < var_486_0 + var_486_9 + arg_486_0 then
				arg_483_1.fswtw_.percent = var_486_5

				arg_483_1.fswtw_:SetDirty()
				arg_483_1:ShowNextGo(true)

				arg_483_1.typewritterCharCountI18N = var_486_6
			end
		end

		arg_483_1.nodeConfigList_ = {}

		arg_483_1:InitPlayNodeList()
	end,
	Play115281115 = function(arg_487_0, arg_487_1)
		arg_487_1.time_ = 0
		arg_487_1.frameCnt_ = 0
		arg_487_1.state_ = "playing"
		arg_487_1.curTalkId_ = 115281115
		arg_487_1.duration_ = 1.13

		SetActive(arg_487_1.tipsGo_, false)

		function arg_487_1.onSingleLineFinish_()
			arg_487_1.onSingleLineUpdate_ = nil
			arg_487_1.onSingleLineFinish_ = nil
			arg_487_1.state_ = "waiting"
		end

		function arg_487_1.playNext_(arg_489_0)
			if arg_489_0 == 1 then
				arg_487_0:Play115281116(arg_487_1)
			end
		end

		function arg_487_1.onSingleLineUpdate_(arg_490_0)
			local var_490_0 = 0

			if var_490_0 < arg_487_1.time_ and arg_487_1.time_ <= var_490_0 + arg_490_0 then
				arg_487_1.var_.oldValueTypewriter = arg_487_1.fswtw_.percent

				SetActive(arg_487_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_487_1:ShowNextGo(false)
			end

			local var_490_1 = 17
			local var_490_2 = 1.13333333333333
			local var_490_3 = arg_487_1:GetWordFromCfg(115281113)
			local var_490_4 = arg_487_1:FormatText(var_490_3.content)
			local var_490_5, var_490_6 = arg_487_1:GetPercentByPara(var_490_4, 3)

			if var_490_0 < arg_487_1.time_ and arg_487_1.time_ <= var_490_0 + arg_490_0 then
				arg_487_1.talkMaxDuration = 0

				local var_490_7 = var_490_1 <= 0 and var_490_2 or var_490_2 * ((var_490_6 - arg_487_1.typewritterCharCountI18N) / var_490_1)

				if var_490_7 > 0 and var_490_2 < var_490_7 then
					arg_487_1.talkMaxDuration = var_490_7

					if var_490_7 + var_490_0 > arg_487_1.duration_ then
						arg_487_1.duration_ = var_490_7 + var_490_0
					end
				end
			end

			local var_490_8 = 1.13333333333333
			local var_490_9 = math.max(var_490_8, arg_487_1.talkMaxDuration)

			if var_490_0 <= arg_487_1.time_ and arg_487_1.time_ < var_490_0 + var_490_9 then
				local var_490_10 = (arg_487_1.time_ - var_490_0) / var_490_9

				arg_487_1.fswtw_.percent = Mathf.Lerp(arg_487_1.var_.oldValueTypewriter, var_490_5, var_490_10)
				arg_487_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_487_1.fswtw_:SetDirty()
			end

			if arg_487_1.time_ >= var_490_0 + var_490_9 and arg_487_1.time_ < var_490_0 + var_490_9 + arg_490_0 then
				arg_487_1.fswtw_.percent = var_490_5

				arg_487_1.fswtw_:SetDirty()
				arg_487_1:ShowNextGo(true)

				arg_487_1.typewritterCharCountI18N = var_490_6
			end
		end

		arg_487_1.nodeConfigList_ = {}

		arg_487_1:InitPlayNodeList()
	end,
	Play115281116 = function(arg_491_0, arg_491_1)
		arg_491_1.time_ = 0
		arg_491_1.frameCnt_ = 0
		arg_491_1.state_ = "playing"
		arg_491_1.curTalkId_ = 115281116
		arg_491_1.duration_ = 1.4

		SetActive(arg_491_1.tipsGo_, false)

		function arg_491_1.onSingleLineFinish_()
			arg_491_1.onSingleLineUpdate_ = nil
			arg_491_1.onSingleLineFinish_ = nil
			arg_491_1.state_ = "waiting"
		end

		function arg_491_1.playNext_(arg_493_0)
			if arg_493_0 == 1 then
				arg_491_0:Play115281117(arg_491_1)
			end
		end

		function arg_491_1.onSingleLineUpdate_(arg_494_0)
			local var_494_0 = 0

			if var_494_0 < arg_491_1.time_ and arg_491_1.time_ <= var_494_0 + arg_494_0 then
				arg_491_1.var_.oldValueTypewriter = arg_491_1.fswtw_.percent

				SetActive(arg_491_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_491_1:ShowNextGo(false)
			end

			local var_494_1 = 21
			local var_494_2 = 1.4
			local var_494_3 = arg_491_1:GetWordFromCfg(115281113)
			local var_494_4 = arg_491_1:FormatText(var_494_3.content)
			local var_494_5, var_494_6 = arg_491_1:GetPercentByPara(var_494_4, 4)

			if var_494_0 < arg_491_1.time_ and arg_491_1.time_ <= var_494_0 + arg_494_0 then
				arg_491_1.talkMaxDuration = 0

				local var_494_7 = var_494_1 <= 0 and var_494_2 or var_494_2 * ((var_494_6 - arg_491_1.typewritterCharCountI18N) / var_494_1)

				if var_494_7 > 0 and var_494_2 < var_494_7 then
					arg_491_1.talkMaxDuration = var_494_7

					if var_494_7 + var_494_0 > arg_491_1.duration_ then
						arg_491_1.duration_ = var_494_7 + var_494_0
					end
				end
			end

			local var_494_8 = 1.4
			local var_494_9 = math.max(var_494_8, arg_491_1.talkMaxDuration)

			if var_494_0 <= arg_491_1.time_ and arg_491_1.time_ < var_494_0 + var_494_9 then
				local var_494_10 = (arg_491_1.time_ - var_494_0) / var_494_9

				arg_491_1.fswtw_.percent = Mathf.Lerp(arg_491_1.var_.oldValueTypewriter, var_494_5, var_494_10)
				arg_491_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_491_1.fswtw_:SetDirty()
			end

			if arg_491_1.time_ >= var_494_0 + var_494_9 and arg_491_1.time_ < var_494_0 + var_494_9 + arg_494_0 then
				arg_491_1.fswtw_.percent = var_494_5

				arg_491_1.fswtw_:SetDirty()
				arg_491_1:ShowNextGo(true)

				arg_491_1.typewritterCharCountI18N = var_494_6
			end
		end

		arg_491_1.nodeConfigList_ = {}

		arg_491_1:InitPlayNodeList()
	end,
	Play115281117 = function(arg_495_0, arg_495_1)
		arg_495_1.time_ = 0
		arg_495_1.frameCnt_ = 0
		arg_495_1.state_ = "playing"
		arg_495_1.curTalkId_ = 115281117
		arg_495_1.duration_ = 1.27

		SetActive(arg_495_1.tipsGo_, false)

		function arg_495_1.onSingleLineFinish_()
			arg_495_1.onSingleLineUpdate_ = nil
			arg_495_1.onSingleLineFinish_ = nil
			arg_495_1.state_ = "waiting"
		end

		function arg_495_1.playNext_(arg_497_0)
			if arg_497_0 == 1 then
				arg_495_0:Play115281118(arg_495_1)
			end
		end

		function arg_495_1.onSingleLineUpdate_(arg_498_0)
			local var_498_0 = 0

			if var_498_0 < arg_495_1.time_ and arg_495_1.time_ <= var_498_0 + arg_498_0 then
				arg_495_1.var_.oldValueTypewriter = arg_495_1.fswtw_.percent

				SetActive(arg_495_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_495_1:ShowNextGo(false)
			end

			local var_498_1 = 19
			local var_498_2 = 1.26666666666667
			local var_498_3 = arg_495_1:GetWordFromCfg(115281113)
			local var_498_4 = arg_495_1:FormatText(var_498_3.content)
			local var_498_5, var_498_6 = arg_495_1:GetPercentByPara(var_498_4, 5)

			if var_498_0 < arg_495_1.time_ and arg_495_1.time_ <= var_498_0 + arg_498_0 then
				arg_495_1.talkMaxDuration = 0

				local var_498_7 = var_498_1 <= 0 and var_498_2 or var_498_2 * ((var_498_6 - arg_495_1.typewritterCharCountI18N) / var_498_1)

				if var_498_7 > 0 and var_498_2 < var_498_7 then
					arg_495_1.talkMaxDuration = var_498_7

					if var_498_7 + var_498_0 > arg_495_1.duration_ then
						arg_495_1.duration_ = var_498_7 + var_498_0
					end
				end
			end

			local var_498_8 = 1.26666666666667
			local var_498_9 = math.max(var_498_8, arg_495_1.talkMaxDuration)

			if var_498_0 <= arg_495_1.time_ and arg_495_1.time_ < var_498_0 + var_498_9 then
				local var_498_10 = (arg_495_1.time_ - var_498_0) / var_498_9

				arg_495_1.fswtw_.percent = Mathf.Lerp(arg_495_1.var_.oldValueTypewriter, var_498_5, var_498_10)
				arg_495_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_495_1.fswtw_:SetDirty()
			end

			if arg_495_1.time_ >= var_498_0 + var_498_9 and arg_495_1.time_ < var_498_0 + var_498_9 + arg_498_0 then
				arg_495_1.fswtw_.percent = var_498_5

				arg_495_1.fswtw_:SetDirty()
				arg_495_1:ShowNextGo(true)

				arg_495_1.typewritterCharCountI18N = var_498_6
			end
		end

		arg_495_1.nodeConfigList_ = {}

		arg_495_1:InitPlayNodeList()
	end,
	Play115281118 = function(arg_499_0, arg_499_1)
		arg_499_1.time_ = 0
		arg_499_1.frameCnt_ = 0
		arg_499_1.state_ = "playing"
		arg_499_1.curTalkId_ = 115281118
		arg_499_1.duration_ = 1.47

		SetActive(arg_499_1.tipsGo_, false)

		function arg_499_1.onSingleLineFinish_()
			arg_499_1.onSingleLineUpdate_ = nil
			arg_499_1.onSingleLineFinish_ = nil
			arg_499_1.state_ = "waiting"
		end

		function arg_499_1.playNext_(arg_501_0)
			if arg_501_0 == 1 then
				arg_499_0:Play115281119(arg_499_1)
			end
		end

		function arg_499_1.onSingleLineUpdate_(arg_502_0)
			local var_502_0 = 0

			if var_502_0 < arg_499_1.time_ and arg_499_1.time_ <= var_502_0 + arg_502_0 then
				arg_499_1.var_.oldValueTypewriter = arg_499_1.fswtw_.percent

				SetActive(arg_499_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_499_1:ShowNextGo(false)
			end

			local var_502_1 = 22
			local var_502_2 = 1.46666666666667
			local var_502_3 = arg_499_1:GetWordFromCfg(115281113)
			local var_502_4 = arg_499_1:FormatText(var_502_3.content)
			local var_502_5, var_502_6 = arg_499_1:GetPercentByPara(var_502_4, 6)

			if var_502_0 < arg_499_1.time_ and arg_499_1.time_ <= var_502_0 + arg_502_0 then
				arg_499_1.talkMaxDuration = 0

				local var_502_7 = var_502_1 <= 0 and var_502_2 or var_502_2 * ((var_502_6 - arg_499_1.typewritterCharCountI18N) / var_502_1)

				if var_502_7 > 0 and var_502_2 < var_502_7 then
					arg_499_1.talkMaxDuration = var_502_7

					if var_502_7 + var_502_0 > arg_499_1.duration_ then
						arg_499_1.duration_ = var_502_7 + var_502_0
					end
				end
			end

			local var_502_8 = 1.46666666666667
			local var_502_9 = math.max(var_502_8, arg_499_1.talkMaxDuration)

			if var_502_0 <= arg_499_1.time_ and arg_499_1.time_ < var_502_0 + var_502_9 then
				local var_502_10 = (arg_499_1.time_ - var_502_0) / var_502_9

				arg_499_1.fswtw_.percent = Mathf.Lerp(arg_499_1.var_.oldValueTypewriter, var_502_5, var_502_10)
				arg_499_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_499_1.fswtw_:SetDirty()
			end

			if arg_499_1.time_ >= var_502_0 + var_502_9 and arg_499_1.time_ < var_502_0 + var_502_9 + arg_502_0 then
				arg_499_1.fswtw_.percent = var_502_5

				arg_499_1.fswtw_:SetDirty()
				arg_499_1:ShowNextGo(true)

				arg_499_1.typewritterCharCountI18N = var_502_6
			end
		end

		arg_499_1.nodeConfigList_ = {}

		arg_499_1:InitPlayNodeList()
	end,
	Play115281119 = function(arg_503_0, arg_503_1)
		arg_503_1.time_ = 0
		arg_503_1.frameCnt_ = 0
		arg_503_1.state_ = "playing"
		arg_503_1.curTalkId_ = 115281119
		arg_503_1.duration_ = 1

		SetActive(arg_503_1.tipsGo_, false)

		function arg_503_1.onSingleLineFinish_()
			arg_503_1.onSingleLineUpdate_ = nil
			arg_503_1.onSingleLineFinish_ = nil
			arg_503_1.state_ = "waiting"
		end

		function arg_503_1.playNext_(arg_505_0)
			if arg_505_0 == 1 then
				arg_503_0:Play115281120(arg_503_1)
			end
		end

		function arg_503_1.onSingleLineUpdate_(arg_506_0)
			local var_506_0 = 0

			if var_506_0 < arg_503_1.time_ and arg_503_1.time_ <= var_506_0 + arg_506_0 then
				arg_503_1.var_.oldValueTypewriter = arg_503_1.fswtw_.percent

				SetActive(arg_503_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_503_1:ShowNextGo(false)
			end

			local var_506_1 = 8
			local var_506_2 = 0.533333333333333
			local var_506_3 = arg_503_1:GetWordFromCfg(115281113)
			local var_506_4 = arg_503_1:FormatText(var_506_3.content)
			local var_506_5, var_506_6 = arg_503_1:GetPercentByPara(var_506_4, 7)

			if var_506_0 < arg_503_1.time_ and arg_503_1.time_ <= var_506_0 + arg_506_0 then
				arg_503_1.talkMaxDuration = 0

				local var_506_7 = var_506_1 <= 0 and var_506_2 or var_506_2 * ((var_506_6 - arg_503_1.typewritterCharCountI18N) / var_506_1)

				if var_506_7 > 0 and var_506_2 < var_506_7 then
					arg_503_1.talkMaxDuration = var_506_7

					if var_506_7 + var_506_0 > arg_503_1.duration_ then
						arg_503_1.duration_ = var_506_7 + var_506_0
					end
				end
			end

			local var_506_8 = 0.533333333333333
			local var_506_9 = math.max(var_506_8, arg_503_1.talkMaxDuration)

			if var_506_0 <= arg_503_1.time_ and arg_503_1.time_ < var_506_0 + var_506_9 then
				local var_506_10 = (arg_503_1.time_ - var_506_0) / var_506_9

				arg_503_1.fswtw_.percent = Mathf.Lerp(arg_503_1.var_.oldValueTypewriter, var_506_5, var_506_10)
				arg_503_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_503_1.fswtw_:SetDirty()
			end

			if arg_503_1.time_ >= var_506_0 + var_506_9 and arg_503_1.time_ < var_506_0 + var_506_9 + arg_506_0 then
				arg_503_1.fswtw_.percent = var_506_5

				arg_503_1.fswtw_:SetDirty()
				arg_503_1:ShowNextGo(true)

				arg_503_1.typewritterCharCountI18N = var_506_6
			end
		end

		arg_503_1.nodeConfigList_ = {}

		arg_503_1:InitPlayNodeList()
	end,
	Play115281120 = function(arg_507_0, arg_507_1)
		arg_507_1.time_ = 0
		arg_507_1.frameCnt_ = 0
		arg_507_1.state_ = "playing"
		arg_507_1.curTalkId_ = 115281120
		arg_507_1.duration_ = 1

		SetActive(arg_507_1.tipsGo_, false)

		function arg_507_1.onSingleLineFinish_()
			arg_507_1.onSingleLineUpdate_ = nil
			arg_507_1.onSingleLineFinish_ = nil
			arg_507_1.state_ = "waiting"
		end

		function arg_507_1.playNext_(arg_509_0)
			if arg_509_0 == 1 then
				arg_507_0:Play115281121(arg_507_1)
			end
		end

		function arg_507_1.onSingleLineUpdate_(arg_510_0)
			local var_510_0 = 0

			if var_510_0 < arg_507_1.time_ and arg_507_1.time_ <= var_510_0 + arg_510_0 then
				arg_507_1.var_.oldValueTypewriter = arg_507_1.fswtw_.percent

				SetActive(arg_507_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_507_1:ShowNextGo(false)
			end

			local var_510_1 = 12
			local var_510_2 = 0.8
			local var_510_3 = arg_507_1:GetWordFromCfg(115281113)
			local var_510_4 = arg_507_1:FormatText(var_510_3.content)
			local var_510_5, var_510_6 = arg_507_1:GetPercentByPara(var_510_4, 8)

			if var_510_0 < arg_507_1.time_ and arg_507_1.time_ <= var_510_0 + arg_510_0 then
				arg_507_1.talkMaxDuration = 0

				local var_510_7 = var_510_1 <= 0 and var_510_2 or var_510_2 * ((var_510_6 - arg_507_1.typewritterCharCountI18N) / var_510_1)

				if var_510_7 > 0 and var_510_2 < var_510_7 then
					arg_507_1.talkMaxDuration = var_510_7

					if var_510_7 + var_510_0 > arg_507_1.duration_ then
						arg_507_1.duration_ = var_510_7 + var_510_0
					end
				end
			end

			local var_510_8 = 0.8
			local var_510_9 = math.max(var_510_8, arg_507_1.talkMaxDuration)

			if var_510_0 <= arg_507_1.time_ and arg_507_1.time_ < var_510_0 + var_510_9 then
				local var_510_10 = (arg_507_1.time_ - var_510_0) / var_510_9

				arg_507_1.fswtw_.percent = Mathf.Lerp(arg_507_1.var_.oldValueTypewriter, var_510_5, var_510_10)
				arg_507_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_507_1.fswtw_:SetDirty()
			end

			if arg_507_1.time_ >= var_510_0 + var_510_9 and arg_507_1.time_ < var_510_0 + var_510_9 + arg_510_0 then
				arg_507_1.fswtw_.percent = var_510_5

				arg_507_1.fswtw_:SetDirty()
				arg_507_1:ShowNextGo(true)

				arg_507_1.typewritterCharCountI18N = var_510_6
			end
		end

		arg_507_1.nodeConfigList_ = {}

		arg_507_1:InitPlayNodeList()
	end,
	Play115281121 = function(arg_511_0, arg_511_1)
		arg_511_1.time_ = 0
		arg_511_1.frameCnt_ = 0
		arg_511_1.state_ = "playing"
		arg_511_1.curTalkId_ = 115281121
		arg_511_1.duration_ = 9

		SetActive(arg_511_1.tipsGo_, false)

		function arg_511_1.onSingleLineFinish_()
			arg_511_1.onSingleLineUpdate_ = nil
			arg_511_1.onSingleLineFinish_ = nil
			arg_511_1.state_ = "waiting"
		end

		function arg_511_1.playNext_(arg_513_0)
			if arg_513_0 == 1 then
				arg_511_0:Play115281122(arg_511_1)
			end
		end

		function arg_511_1.onSingleLineUpdate_(arg_514_0)
			local var_514_0 = 0

			if var_514_0 < arg_511_1.time_ and arg_511_1.time_ <= var_514_0 + arg_514_0 then
				local var_514_1 = manager.ui.mainCamera.transform.localPosition
				local var_514_2 = Vector3.New(0, 0, 10) + Vector3.New(var_514_1.x, var_514_1.y, 0)
				local var_514_3 = arg_511_1.bgs_.STblack

				var_514_3.transform.localPosition = var_514_2
				var_514_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_514_4 = var_514_3:GetComponent("SpriteRenderer")

				if var_514_4 and var_514_4.sprite then
					local var_514_5 = (var_514_3.transform.localPosition - var_514_1).z
					local var_514_6 = manager.ui.mainCameraCom_
					local var_514_7 = 2 * var_514_5 * Mathf.Tan(var_514_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_514_8 = var_514_7 * var_514_6.aspect
					local var_514_9 = var_514_4.sprite.bounds.size.x
					local var_514_10 = var_514_4.sprite.bounds.size.y
					local var_514_11 = var_514_8 / var_514_9
					local var_514_12 = var_514_7 / var_514_10
					local var_514_13 = var_514_12 < var_514_11 and var_514_11 or var_514_12

					var_514_3.transform.localScale = Vector3.New(var_514_13, var_514_13, 0)
				end

				for iter_514_0, iter_514_1 in pairs(arg_511_1.bgs_) do
					if iter_514_0 ~= "STblack" then
						iter_514_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_514_14 = 2

			if var_514_14 < arg_511_1.time_ and arg_511_1.time_ <= var_514_14 + arg_514_0 then
				local var_514_15 = manager.ui.mainCamera.transform.localPosition
				local var_514_16 = Vector3.New(0, 0, 10) + Vector3.New(var_514_15.x, var_514_15.y, 0)
				local var_514_17 = arg_511_1.bgs_.D999

				var_514_17.transform.localPosition = var_514_16
				var_514_17.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_514_18 = var_514_17:GetComponent("SpriteRenderer")

				if var_514_18 and var_514_18.sprite then
					local var_514_19 = (var_514_17.transform.localPosition - var_514_15).z
					local var_514_20 = manager.ui.mainCameraCom_
					local var_514_21 = 2 * var_514_19 * Mathf.Tan(var_514_20.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_514_22 = var_514_21 * var_514_20.aspect
					local var_514_23 = var_514_18.sprite.bounds.size.x
					local var_514_24 = var_514_18.sprite.bounds.size.y
					local var_514_25 = var_514_22 / var_514_23
					local var_514_26 = var_514_21 / var_514_24
					local var_514_27 = var_514_26 < var_514_25 and var_514_25 or var_514_26

					var_514_17.transform.localScale = Vector3.New(var_514_27, var_514_27, 0)
				end

				for iter_514_2, iter_514_3 in pairs(arg_511_1.bgs_) do
					if iter_514_2 ~= "D999" then
						iter_514_3.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_514_28 = 0

			if var_514_28 < arg_511_1.time_ and arg_511_1.time_ <= var_514_28 + arg_514_0 then
				arg_511_1.mask_.enabled = true
				arg_511_1.mask_.raycastTarget = false

				arg_511_1:SetGaussion(false)
			end

			local var_514_29 = 2

			if var_514_28 <= arg_511_1.time_ and arg_511_1.time_ < var_514_28 + var_514_29 then
				local var_514_30 = (arg_511_1.time_ - var_514_28) / var_514_29
				local var_514_31 = Color.New(0, 0, 0)

				var_514_31.a = Mathf.Lerp(0, 1, var_514_30)
				arg_511_1.mask_.color = var_514_31
			end

			if arg_511_1.time_ >= var_514_28 + var_514_29 and arg_511_1.time_ < var_514_28 + var_514_29 + arg_514_0 then
				local var_514_32 = Color.New(0, 0, 0)

				var_514_32.a = 1
				arg_511_1.mask_.color = var_514_32
			end

			local var_514_33 = 2

			if var_514_33 < arg_511_1.time_ and arg_511_1.time_ <= var_514_33 + arg_514_0 then
				arg_511_1.mask_.enabled = true
				arg_511_1.mask_.raycastTarget = false

				arg_511_1:SetGaussion(false)
			end

			local var_514_34 = 2

			if var_514_33 <= arg_511_1.time_ and arg_511_1.time_ < var_514_33 + var_514_34 then
				local var_514_35 = (arg_511_1.time_ - var_514_33) / var_514_34
				local var_514_36 = Color.New(0, 0, 0)

				var_514_36.a = Mathf.Lerp(1, 0, var_514_35)
				arg_511_1.mask_.color = var_514_36
			end

			if arg_511_1.time_ >= var_514_33 + var_514_34 and arg_511_1.time_ < var_514_33 + var_514_34 + arg_514_0 then
				local var_514_37 = Color.New(0, 0, 0)
				local var_514_38 = 0

				arg_511_1.mask_.enabled = false
				var_514_37.a = var_514_38
				arg_511_1.mask_.color = var_514_37
			end

			local var_514_39 = 0

			if var_514_39 < arg_511_1.time_ and arg_511_1.time_ <= var_514_39 + arg_514_0 then
				arg_511_1.fswbg_:SetActive(false)
				arg_511_1.dialog_:SetActive(true)
				SetActive(arg_511_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_511_1:ShowNextGo(false)
			end

			local var_514_40 = "STwhite"

			if arg_511_1.bgs_[var_514_40] == nil then
				local var_514_41 = Object.Instantiate(arg_511_1.paintGo_)

				var_514_41:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_514_40)
				var_514_41.name = var_514_40
				var_514_41.transform.parent = arg_511_1.stage_.transform
				var_514_41.transform.localPosition = Vector3.New(0, 100, 0)
				arg_511_1.bgs_[var_514_40] = var_514_41
			end

			local var_514_42 = arg_511_1.bgs_.STwhite.transform
			local var_514_43 = 2

			if var_514_43 < arg_511_1.time_ and arg_511_1.time_ <= var_514_43 + arg_514_0 then
				arg_511_1.var_.moveOldPosSTwhite = var_514_42.localPosition
				var_514_42.localScale = Vector3.New(12, 12, 12)
			end

			local var_514_44 = 0.001

			if var_514_43 <= arg_511_1.time_ and arg_511_1.time_ < var_514_43 + var_514_44 then
				local var_514_45 = (arg_511_1.time_ - var_514_43) / var_514_44
				local var_514_46 = Vector3.New(0, 0, 0)

				var_514_42.localPosition = Vector3.Lerp(arg_511_1.var_.moveOldPosSTwhite, var_514_46, var_514_45)
			end

			if arg_511_1.time_ >= var_514_43 + var_514_44 and arg_511_1.time_ < var_514_43 + var_514_44 + arg_514_0 then
				var_514_42.localPosition = Vector3.New(0, 0, 0)
			end

			if arg_511_1.frameCnt_ <= 1 then
				arg_511_1.dialog_:SetActive(false)
			end

			local var_514_47 = 4
			local var_514_48 = 0.975

			if var_514_47 < arg_511_1.time_ and arg_511_1.time_ <= var_514_47 + arg_514_0 then
				arg_511_1.talkMaxDuration = 0

				arg_511_1.dialog_:SetActive(true)

				arg_511_1.dialogCg_.alpha = 0

				local var_514_49 = LeanTween.value(arg_511_1.dialog_, 0, 1, 0.3)

				var_514_49:setOnUpdate(LuaHelper.FloatAction(function(arg_515_0)
					arg_511_1.dialogCg_.alpha = arg_515_0
				end))
				var_514_49:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_511_1.dialog_)
					var_514_49:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_511_1.duration_ = arg_511_1.duration_ + 0.3

				SetActive(arg_511_1.leftNameGo_, false)

				arg_511_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_511_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_511_1:RecordName(arg_511_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_511_1.iconTrs_.gameObject, false)
				arg_511_1.callingController_:SetSelectedState("normal")

				local var_514_50 = arg_511_1:GetWordFromCfg(115281121)
				local var_514_51 = arg_511_1:FormatText(var_514_50.content)

				arg_511_1.text_.text = var_514_51

				LuaForUtil.ClearLinePrefixSymbol(arg_511_1.text_)

				local var_514_52 = 39
				local var_514_53 = utf8.len(var_514_51)
				local var_514_54 = var_514_52 <= 0 and var_514_48 or var_514_48 * (var_514_53 / var_514_52)

				if var_514_54 > 0 and var_514_48 < var_514_54 then
					arg_511_1.talkMaxDuration = var_514_54
					var_514_47 = var_514_47 + 0.3

					if var_514_54 + var_514_47 > arg_511_1.duration_ then
						arg_511_1.duration_ = var_514_54 + var_514_47
					end
				end

				arg_511_1.text_.text = var_514_51
				arg_511_1.typewritter.percent = 0

				arg_511_1.typewritter:SetDirty()
				arg_511_1:ShowNextGo(false)
				arg_511_1:RecordContent(arg_511_1.text_.text)
			end

			local var_514_55 = var_514_47 + 0.3
			local var_514_56 = math.max(var_514_48, arg_511_1.talkMaxDuration)

			if var_514_55 <= arg_511_1.time_ and arg_511_1.time_ < var_514_55 + var_514_56 then
				arg_511_1.typewritter.percent = (arg_511_1.time_ - var_514_55) / var_514_56

				arg_511_1.typewritter:SetDirty()
			end

			if arg_511_1.time_ >= var_514_55 + var_514_56 and arg_511_1.time_ < var_514_55 + var_514_56 + arg_514_0 then
				arg_511_1.typewritter.percent = 1

				arg_511_1.typewritter:SetDirty()
				arg_511_1:ShowNextGo(true)
			end
		end

		arg_511_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "STwhite",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_511_1:InitPlayNodeList()
	end,
	Play115281122 = function(arg_517_0, arg_517_1)
		arg_517_1.time_ = 0
		arg_517_1.frameCnt_ = 0
		arg_517_1.state_ = "playing"
		arg_517_1.curTalkId_ = 115281122
		arg_517_1.duration_ = 5.67

		local var_517_0 = {
			ja = 5.666,
			ko = 2.433,
			zh = 5.533,
			en = 3.233
		}
		local var_517_1 = manager.audio:GetLocalizationFlag()

		if var_517_0[var_517_1] ~= nil then
			arg_517_1.duration_ = var_517_0[var_517_1]
		end

		SetActive(arg_517_1.tipsGo_, false)

		function arg_517_1.onSingleLineFinish_()
			arg_517_1.onSingleLineUpdate_ = nil
			arg_517_1.onSingleLineFinish_ = nil
			arg_517_1.state_ = "waiting"
		end

		function arg_517_1.playNext_(arg_519_0)
			if arg_519_0 == 1 then
				arg_517_0:Play115281123(arg_517_1)
			end
		end

		function arg_517_1.onSingleLineUpdate_(arg_520_0)
			local var_520_0 = 0
			local var_520_1 = 0.25

			if var_520_0 < arg_517_1.time_ and arg_517_1.time_ <= var_520_0 + arg_520_0 then
				arg_517_1.talkMaxDuration = 0
				arg_517_1.dialogCg_.alpha = 1

				arg_517_1.dialog_:SetActive(true)
				SetActive(arg_517_1.leftNameGo_, true)

				local var_520_2 = arg_517_1:FormatText(StoryNameCfg[309].name)

				arg_517_1.leftNameTxt_.text = var_520_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_517_1.leftNameTxt_.transform)

				arg_517_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_517_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_517_1:RecordName(arg_517_1.leftNameTxt_.text)
				SetActive(arg_517_1.iconTrs_.gameObject, true)
				arg_517_1.iconController_:SetSelectedState("hero")

				arg_517_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10030_split_3")

				arg_517_1.callingController_:SetSelectedState("normal")

				arg_517_1.keyicon_.color = Color.New(1, 1, 1)
				arg_517_1.icon_.color = Color.New(1, 1, 1)

				local var_520_3 = arg_517_1:GetWordFromCfg(115281122)
				local var_520_4 = arg_517_1:FormatText(var_520_3.content)

				arg_517_1.text_.text = var_520_4

				LuaForUtil.ClearLinePrefixSymbol(arg_517_1.text_)

				local var_520_5 = 10
				local var_520_6 = utf8.len(var_520_4)
				local var_520_7 = var_520_5 <= 0 and var_520_1 or var_520_1 * (var_520_6 / var_520_5)

				if var_520_7 > 0 and var_520_1 < var_520_7 then
					arg_517_1.talkMaxDuration = var_520_7

					if var_520_7 + var_520_0 > arg_517_1.duration_ then
						arg_517_1.duration_ = var_520_7 + var_520_0
					end
				end

				arg_517_1.text_.text = var_520_4
				arg_517_1.typewritter.percent = 0

				arg_517_1.typewritter:SetDirty()
				arg_517_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115281", "115281122", "story_v_out_115281.awb") ~= 0 then
					local var_520_8 = manager.audio:GetVoiceLength("story_v_out_115281", "115281122", "story_v_out_115281.awb") / 1000

					if var_520_8 + var_520_0 > arg_517_1.duration_ then
						arg_517_1.duration_ = var_520_8 + var_520_0
					end

					if var_520_3.prefab_name ~= "" and arg_517_1.actors_[var_520_3.prefab_name] ~= nil then
						local var_520_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_517_1.actors_[var_520_3.prefab_name].transform, "story_v_out_115281", "115281122", "story_v_out_115281.awb")

						arg_517_1:RecordAudio("115281122", var_520_9)
						arg_517_1:RecordAudio("115281122", var_520_9)
					else
						arg_517_1:AudioAction("play", "voice", "story_v_out_115281", "115281122", "story_v_out_115281.awb")
					end

					arg_517_1:RecordHistoryTalkVoice("story_v_out_115281", "115281122", "story_v_out_115281.awb")
				end

				arg_517_1:RecordContent(arg_517_1.text_.text)
			end

			local var_520_10 = math.max(var_520_1, arg_517_1.talkMaxDuration)

			if var_520_0 <= arg_517_1.time_ and arg_517_1.time_ < var_520_0 + var_520_10 then
				arg_517_1.typewritter.percent = (arg_517_1.time_ - var_520_0) / var_520_10

				arg_517_1.typewritter:SetDirty()
			end

			if arg_517_1.time_ >= var_520_0 + var_520_10 and arg_517_1.time_ < var_520_0 + var_520_10 + arg_520_0 then
				arg_517_1.typewritter.percent = 1

				arg_517_1.typewritter:SetDirty()
				arg_517_1:ShowNextGo(true)
			end
		end

		arg_517_1.nodeConfigList_ = {}

		arg_517_1:InitPlayNodeList()
	end,
	Play115281123 = function(arg_521_0, arg_521_1)
		arg_521_1.time_ = 0
		arg_521_1.frameCnt_ = 0
		arg_521_1.state_ = "playing"
		arg_521_1.curTalkId_ = 115281123
		arg_521_1.duration_ = 5

		SetActive(arg_521_1.tipsGo_, false)

		function arg_521_1.onSingleLineFinish_()
			arg_521_1.onSingleLineUpdate_ = nil
			arg_521_1.onSingleLineFinish_ = nil
			arg_521_1.state_ = "waiting"
		end

		function arg_521_1.playNext_(arg_523_0)
			if arg_523_0 == 1 then
				arg_521_0:Play115281124(arg_521_1)
			end
		end

		function arg_521_1.onSingleLineUpdate_(arg_524_0)
			local var_524_0 = 0
			local var_524_1 = 0.55

			if var_524_0 < arg_521_1.time_ and arg_521_1.time_ <= var_524_0 + arg_524_0 then
				arg_521_1.talkMaxDuration = 0
				arg_521_1.dialogCg_.alpha = 1

				arg_521_1.dialog_:SetActive(true)
				SetActive(arg_521_1.leftNameGo_, false)

				arg_521_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_521_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_521_1:RecordName(arg_521_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_521_1.iconTrs_.gameObject, false)
				arg_521_1.callingController_:SetSelectedState("normal")

				local var_524_2 = arg_521_1:GetWordFromCfg(115281123)
				local var_524_3 = arg_521_1:FormatText(var_524_2.content)

				arg_521_1.text_.text = var_524_3

				LuaForUtil.ClearLinePrefixSymbol(arg_521_1.text_)

				local var_524_4 = 22
				local var_524_5 = utf8.len(var_524_3)
				local var_524_6 = var_524_4 <= 0 and var_524_1 or var_524_1 * (var_524_5 / var_524_4)

				if var_524_6 > 0 and var_524_1 < var_524_6 then
					arg_521_1.talkMaxDuration = var_524_6

					if var_524_6 + var_524_0 > arg_521_1.duration_ then
						arg_521_1.duration_ = var_524_6 + var_524_0
					end
				end

				arg_521_1.text_.text = var_524_3
				arg_521_1.typewritter.percent = 0

				arg_521_1.typewritter:SetDirty()
				arg_521_1:ShowNextGo(false)
				arg_521_1:RecordContent(arg_521_1.text_.text)
			end

			local var_524_7 = math.max(var_524_1, arg_521_1.talkMaxDuration)

			if var_524_0 <= arg_521_1.time_ and arg_521_1.time_ < var_524_0 + var_524_7 then
				arg_521_1.typewritter.percent = (arg_521_1.time_ - var_524_0) / var_524_7

				arg_521_1.typewritter:SetDirty()
			end

			if arg_521_1.time_ >= var_524_0 + var_524_7 and arg_521_1.time_ < var_524_0 + var_524_7 + arg_524_0 then
				arg_521_1.typewritter.percent = 1

				arg_521_1.typewritter:SetDirty()
				arg_521_1:ShowNextGo(true)
			end
		end

		arg_521_1.nodeConfigList_ = {}

		arg_521_1:InitPlayNodeList()
	end,
	Play115281124 = function(arg_525_0, arg_525_1)
		arg_525_1.time_ = 0
		arg_525_1.frameCnt_ = 0
		arg_525_1.state_ = "playing"
		arg_525_1.curTalkId_ = 115281124
		arg_525_1.duration_ = 6.53

		local var_525_0 = {
			ja = 5,
			ko = 5.033,
			zh = 6.533,
			en = 5
		}
		local var_525_1 = manager.audio:GetLocalizationFlag()

		if var_525_0[var_525_1] ~= nil then
			arg_525_1.duration_ = var_525_0[var_525_1]
		end

		SetActive(arg_525_1.tipsGo_, false)

		function arg_525_1.onSingleLineFinish_()
			arg_525_1.onSingleLineUpdate_ = nil
			arg_525_1.onSingleLineFinish_ = nil
			arg_525_1.state_ = "waiting"
		end

		function arg_525_1.playNext_(arg_527_0)
			if arg_527_0 == 1 then
				arg_525_0:Play115281125(arg_525_1)
			end
		end

		function arg_525_1.onSingleLineUpdate_(arg_528_0)
			local var_528_0 = 2

			if var_528_0 < arg_525_1.time_ and arg_525_1.time_ <= var_528_0 + arg_528_0 then
				local var_528_1 = manager.ui.mainCamera.transform.localPosition
				local var_528_2 = Vector3.New(0, 0, 10) + Vector3.New(var_528_1.x, var_528_1.y, 0)
				local var_528_3 = arg_525_1.bgs_.ST28a

				var_528_3.transform.localPosition = var_528_2
				var_528_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_528_4 = var_528_3:GetComponent("SpriteRenderer")

				if var_528_4 and var_528_4.sprite then
					local var_528_5 = (var_528_3.transform.localPosition - var_528_1).z
					local var_528_6 = manager.ui.mainCameraCom_
					local var_528_7 = 2 * var_528_5 * Mathf.Tan(var_528_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_528_8 = var_528_7 * var_528_6.aspect
					local var_528_9 = var_528_4.sprite.bounds.size.x
					local var_528_10 = var_528_4.sprite.bounds.size.y
					local var_528_11 = var_528_8 / var_528_9
					local var_528_12 = var_528_7 / var_528_10
					local var_528_13 = var_528_12 < var_528_11 and var_528_11 or var_528_12

					var_528_3.transform.localScale = Vector3.New(var_528_13, var_528_13, 0)
				end

				for iter_528_0, iter_528_1 in pairs(arg_525_1.bgs_) do
					if iter_528_0 ~= "ST28a" then
						iter_528_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_528_14 = 0

			if var_528_14 < arg_525_1.time_ and arg_525_1.time_ <= var_528_14 + arg_528_0 then
				arg_525_1.mask_.enabled = true
				arg_525_1.mask_.raycastTarget = false

				arg_525_1:SetGaussion(false)
			end

			local var_528_15 = 2

			if var_528_14 <= arg_525_1.time_ and arg_525_1.time_ < var_528_14 + var_528_15 then
				local var_528_16 = (arg_525_1.time_ - var_528_14) / var_528_15
				local var_528_17 = Color.New(0, 0, 0)

				var_528_17.a = Mathf.Lerp(0, 1, var_528_16)
				arg_525_1.mask_.color = var_528_17
			end

			if arg_525_1.time_ >= var_528_14 + var_528_15 and arg_525_1.time_ < var_528_14 + var_528_15 + arg_528_0 then
				local var_528_18 = Color.New(0, 0, 0)

				var_528_18.a = 1
				arg_525_1.mask_.color = var_528_18
			end

			local var_528_19 = 2

			if var_528_19 < arg_525_1.time_ and arg_525_1.time_ <= var_528_19 + arg_528_0 then
				arg_525_1.mask_.enabled = true
				arg_525_1.mask_.raycastTarget = false

				arg_525_1:SetGaussion(false)
			end

			local var_528_20 = 2

			if var_528_19 <= arg_525_1.time_ and arg_525_1.time_ < var_528_19 + var_528_20 then
				local var_528_21 = (arg_525_1.time_ - var_528_19) / var_528_20
				local var_528_22 = Color.New(0, 0, 0)

				var_528_22.a = Mathf.Lerp(1, 0, var_528_21)
				arg_525_1.mask_.color = var_528_22
			end

			if arg_525_1.time_ >= var_528_19 + var_528_20 and arg_525_1.time_ < var_528_19 + var_528_20 + arg_528_0 then
				local var_528_23 = Color.New(0, 0, 0)
				local var_528_24 = 0

				arg_525_1.mask_.enabled = false
				var_528_23.a = var_528_24
				arg_525_1.mask_.color = var_528_23
			end

			local var_528_25 = manager.ui.mainCamera.transform
			local var_528_26 = 4

			if var_528_26 < arg_525_1.time_ and arg_525_1.time_ <= var_528_26 + arg_528_0 then
				arg_525_1.var_.shakeOldPos = var_528_25.localPosition
			end

			local var_528_27 = 0.333333333333333

			if var_528_26 <= arg_525_1.time_ and arg_525_1.time_ < var_528_26 + var_528_27 then
				local var_528_28 = (arg_525_1.time_ - var_528_26) / 0.066
				local var_528_29, var_528_30 = math.modf(var_528_28)

				var_528_25.localPosition = Vector3.New(var_528_30 * 0.13, var_528_30 * 0.13, var_528_30 * 0.13) + arg_525_1.var_.shakeOldPos
			end

			if arg_525_1.time_ >= var_528_26 + var_528_27 and arg_525_1.time_ < var_528_26 + var_528_27 + arg_528_0 then
				var_528_25.localPosition = arg_525_1.var_.shakeOldPos
			end

			local var_528_31 = manager.ui.mainCamera.transform
			local var_528_32 = 2

			if var_528_32 < arg_525_1.time_ and arg_525_1.time_ <= var_528_32 + arg_528_0 then
				local var_528_33 = arg_525_1.var_.effecthuo
				local var_528_34
				local var_528_35 = var_528_31

				if not var_528_33 then
					var_528_33 = Object.Instantiate(Asset.Load("Effect/Scene/fx_ui_red"), var_528_35)
					var_528_33.name = "huo"
					arg_525_1.var_.effecthuo = var_528_33
				else
					var_528_33.transform:SetParent(var_528_35)
				end

				var_528_33.transform.localPosition = Vector3.New(0, 0.02, 0.35)
				var_528_33.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if arg_525_1.frameCnt_ <= 1 then
				arg_525_1.dialog_:SetActive(false)
			end

			local var_528_36 = 4
			local var_528_37 = 0.125

			if var_528_36 < arg_525_1.time_ and arg_525_1.time_ <= var_528_36 + arg_528_0 then
				arg_525_1.talkMaxDuration = 0

				arg_525_1.dialog_:SetActive(true)

				arg_525_1.dialogCg_.alpha = 0

				local var_528_38 = LeanTween.value(arg_525_1.dialog_, 0, 1, 0.3)

				var_528_38:setOnUpdate(LuaHelper.FloatAction(function(arg_529_0)
					arg_525_1.dialogCg_.alpha = arg_529_0
				end))
				var_528_38:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_525_1.dialog_)
					var_528_38:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_525_1.duration_ = arg_525_1.duration_ + 0.3

				SetActive(arg_525_1.leftNameGo_, true)

				local var_528_39 = arg_525_1:FormatText(StoryNameCfg[94].name)

				arg_525_1.leftNameTxt_.text = var_528_39

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_525_1.leftNameTxt_.transform)

				arg_525_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_525_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_525_1:RecordName(arg_525_1.leftNameTxt_.text)
				SetActive(arg_525_1.iconTrs_.gameObject, true)
				arg_525_1.iconController_:SetSelectedState("hero")

				arg_525_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1038_split_5")

				arg_525_1.callingController_:SetSelectedState("normal")

				arg_525_1.keyicon_.color = Color.New(1, 1, 1)
				arg_525_1.icon_.color = Color.New(1, 1, 1)

				local var_528_40 = arg_525_1:GetWordFromCfg(115281124)
				local var_528_41 = arg_525_1:FormatText(var_528_40.content)

				arg_525_1.text_.text = var_528_41

				LuaForUtil.ClearLinePrefixSymbol(arg_525_1.text_)

				local var_528_42 = 5
				local var_528_43 = utf8.len(var_528_41)
				local var_528_44 = var_528_42 <= 0 and var_528_37 or var_528_37 * (var_528_43 / var_528_42)

				if var_528_44 > 0 and var_528_37 < var_528_44 then
					arg_525_1.talkMaxDuration = var_528_44
					var_528_36 = var_528_36 + 0.3

					if var_528_44 + var_528_36 > arg_525_1.duration_ then
						arg_525_1.duration_ = var_528_44 + var_528_36
					end
				end

				arg_525_1.text_.text = var_528_41
				arg_525_1.typewritter.percent = 0

				arg_525_1.typewritter:SetDirty()
				arg_525_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115281", "115281124", "story_v_out_115281.awb") ~= 0 then
					local var_528_45 = manager.audio:GetVoiceLength("story_v_out_115281", "115281124", "story_v_out_115281.awb") / 1000

					if var_528_45 + var_528_36 > arg_525_1.duration_ then
						arg_525_1.duration_ = var_528_45 + var_528_36
					end

					if var_528_40.prefab_name ~= "" and arg_525_1.actors_[var_528_40.prefab_name] ~= nil then
						local var_528_46 = LuaForUtil.PlayVoiceWithCriLipsync(arg_525_1.actors_[var_528_40.prefab_name].transform, "story_v_out_115281", "115281124", "story_v_out_115281.awb")

						arg_525_1:RecordAudio("115281124", var_528_46)
						arg_525_1:RecordAudio("115281124", var_528_46)
					else
						arg_525_1:AudioAction("play", "voice", "story_v_out_115281", "115281124", "story_v_out_115281.awb")
					end

					arg_525_1:RecordHistoryTalkVoice("story_v_out_115281", "115281124", "story_v_out_115281.awb")
				end

				arg_525_1:RecordContent(arg_525_1.text_.text)
			end

			local var_528_47 = var_528_36 + 0.3
			local var_528_48 = math.max(var_528_37, arg_525_1.talkMaxDuration)

			if var_528_47 <= arg_525_1.time_ and arg_525_1.time_ < var_528_47 + var_528_48 then
				arg_525_1.typewritter.percent = (arg_525_1.time_ - var_528_47) / var_528_48

				arg_525_1.typewritter:SetDirty()
			end

			if arg_525_1.time_ >= var_528_47 + var_528_48 and arg_525_1.time_ < var_528_47 + var_528_48 + arg_528_0 then
				arg_525_1.typewritter.percent = 1

				arg_525_1.typewritter:SetDirty()
				arg_525_1:ShowNextGo(true)
			end
		end

		arg_525_1.nodeConfigList_ = {}

		arg_525_1:InitPlayNodeList()
	end,
	Play115281125 = function(arg_531_0, arg_531_1)
		arg_531_1.time_ = 0
		arg_531_1.frameCnt_ = 0
		arg_531_1.state_ = "playing"
		arg_531_1.curTalkId_ = 115281125
		arg_531_1.duration_ = 5

		SetActive(arg_531_1.tipsGo_, false)

		function arg_531_1.onSingleLineFinish_()
			arg_531_1.onSingleLineUpdate_ = nil
			arg_531_1.onSingleLineFinish_ = nil
			arg_531_1.state_ = "waiting"
		end

		function arg_531_1.playNext_(arg_533_0)
			if arg_533_0 == 1 then
				arg_531_0:Play115281126(arg_531_1)
			end
		end

		function arg_531_1.onSingleLineUpdate_(arg_534_0)
			local var_534_0 = 0
			local var_534_1 = 1.225

			if var_534_0 < arg_531_1.time_ and arg_531_1.time_ <= var_534_0 + arg_534_0 then
				arg_531_1.talkMaxDuration = 0
				arg_531_1.dialogCg_.alpha = 1

				arg_531_1.dialog_:SetActive(true)
				SetActive(arg_531_1.leftNameGo_, false)

				arg_531_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_531_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_531_1:RecordName(arg_531_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_531_1.iconTrs_.gameObject, false)
				arg_531_1.callingController_:SetSelectedState("normal")

				local var_534_2 = arg_531_1:GetWordFromCfg(115281125)
				local var_534_3 = arg_531_1:FormatText(var_534_2.content)

				arg_531_1.text_.text = var_534_3

				LuaForUtil.ClearLinePrefixSymbol(arg_531_1.text_)

				local var_534_4 = 49
				local var_534_5 = utf8.len(var_534_3)
				local var_534_6 = var_534_4 <= 0 and var_534_1 or var_534_1 * (var_534_5 / var_534_4)

				if var_534_6 > 0 and var_534_1 < var_534_6 then
					arg_531_1.talkMaxDuration = var_534_6

					if var_534_6 + var_534_0 > arg_531_1.duration_ then
						arg_531_1.duration_ = var_534_6 + var_534_0
					end
				end

				arg_531_1.text_.text = var_534_3
				arg_531_1.typewritter.percent = 0

				arg_531_1.typewritter:SetDirty()
				arg_531_1:ShowNextGo(false)
				arg_531_1:RecordContent(arg_531_1.text_.text)
			end

			local var_534_7 = math.max(var_534_1, arg_531_1.talkMaxDuration)

			if var_534_0 <= arg_531_1.time_ and arg_531_1.time_ < var_534_0 + var_534_7 then
				arg_531_1.typewritter.percent = (arg_531_1.time_ - var_534_0) / var_534_7

				arg_531_1.typewritter:SetDirty()
			end

			if arg_531_1.time_ >= var_534_0 + var_534_7 and arg_531_1.time_ < var_534_0 + var_534_7 + arg_534_0 then
				arg_531_1.typewritter.percent = 1

				arg_531_1.typewritter:SetDirty()
				arg_531_1:ShowNextGo(true)
			end
		end

		arg_531_1.nodeConfigList_ = {}

		arg_531_1:InitPlayNodeList()
	end,
	Play115281126 = function(arg_535_0, arg_535_1)
		arg_535_1.time_ = 0
		arg_535_1.frameCnt_ = 0
		arg_535_1.state_ = "playing"
		arg_535_1.curTalkId_ = 115281126
		arg_535_1.duration_ = 5

		SetActive(arg_535_1.tipsGo_, false)

		function arg_535_1.onSingleLineFinish_()
			arg_535_1.onSingleLineUpdate_ = nil
			arg_535_1.onSingleLineFinish_ = nil
			arg_535_1.state_ = "waiting"
		end

		function arg_535_1.playNext_(arg_537_0)
			if arg_537_0 == 1 then
				arg_535_0:Play115281127(arg_535_1)
			end
		end

		function arg_535_1.onSingleLineUpdate_(arg_538_0)
			local var_538_0 = 0
			local var_538_1 = 0.7

			if var_538_0 < arg_535_1.time_ and arg_535_1.time_ <= var_538_0 + arg_538_0 then
				arg_535_1.talkMaxDuration = 0
				arg_535_1.dialogCg_.alpha = 1

				arg_535_1.dialog_:SetActive(true)
				SetActive(arg_535_1.leftNameGo_, false)

				arg_535_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_535_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_535_1:RecordName(arg_535_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_535_1.iconTrs_.gameObject, false)
				arg_535_1.callingController_:SetSelectedState("normal")

				local var_538_2 = arg_535_1:GetWordFromCfg(115281126)
				local var_538_3 = arg_535_1:FormatText(var_538_2.content)

				arg_535_1.text_.text = var_538_3

				LuaForUtil.ClearLinePrefixSymbol(arg_535_1.text_)

				local var_538_4 = 28
				local var_538_5 = utf8.len(var_538_3)
				local var_538_6 = var_538_4 <= 0 and var_538_1 or var_538_1 * (var_538_5 / var_538_4)

				if var_538_6 > 0 and var_538_1 < var_538_6 then
					arg_535_1.talkMaxDuration = var_538_6

					if var_538_6 + var_538_0 > arg_535_1.duration_ then
						arg_535_1.duration_ = var_538_6 + var_538_0
					end
				end

				arg_535_1.text_.text = var_538_3
				arg_535_1.typewritter.percent = 0

				arg_535_1.typewritter:SetDirty()
				arg_535_1:ShowNextGo(false)
				arg_535_1:RecordContent(arg_535_1.text_.text)
			end

			local var_538_7 = math.max(var_538_1, arg_535_1.talkMaxDuration)

			if var_538_0 <= arg_535_1.time_ and arg_535_1.time_ < var_538_0 + var_538_7 then
				arg_535_1.typewritter.percent = (arg_535_1.time_ - var_538_0) / var_538_7

				arg_535_1.typewritter:SetDirty()
			end

			if arg_535_1.time_ >= var_538_0 + var_538_7 and arg_535_1.time_ < var_538_0 + var_538_7 + arg_538_0 then
				arg_535_1.typewritter.percent = 1

				arg_535_1.typewritter:SetDirty()
				arg_535_1:ShowNextGo(true)
			end
		end

		arg_535_1.nodeConfigList_ = {}

		arg_535_1:InitPlayNodeList()
	end,
	Play115281127 = function(arg_539_0, arg_539_1)
		arg_539_1.time_ = 0
		arg_539_1.frameCnt_ = 0
		arg_539_1.state_ = "playing"
		arg_539_1.curTalkId_ = 115281127
		arg_539_1.duration_ = 5.2

		local var_539_0 = {
			ja = 3.766,
			ko = 4.633,
			zh = 5.2,
			en = 3.866
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
				arg_539_0:Play115281128(arg_539_1)
			end
		end

		function arg_539_1.onSingleLineUpdate_(arg_542_0)
			local var_542_0 = arg_539_1.actors_["1038"].transform
			local var_542_1 = 0

			if var_542_1 < arg_539_1.time_ and arg_539_1.time_ <= var_542_1 + arg_542_0 then
				arg_539_1.var_.moveOldPos1038 = var_542_0.localPosition
				var_542_0.localScale = Vector3.New(1, 1, 1)

				arg_539_1:CheckSpriteTmpPos("1038", 3)

				local var_542_2 = var_542_0.childCount

				for iter_542_0 = 0, var_542_2 - 1 do
					local var_542_3 = var_542_0:GetChild(iter_542_0)

					if var_542_3.name == "split_9" or not string.find(var_542_3.name, "split") then
						var_542_3.gameObject:SetActive(true)
					else
						var_542_3.gameObject:SetActive(false)
					end
				end
			end

			local var_542_4 = 0.001

			if var_542_1 <= arg_539_1.time_ and arg_539_1.time_ < var_542_1 + var_542_4 then
				local var_542_5 = (arg_539_1.time_ - var_542_1) / var_542_4
				local var_542_6 = Vector3.New(0, -400, 0)

				var_542_0.localPosition = Vector3.Lerp(arg_539_1.var_.moveOldPos1038, var_542_6, var_542_5)
			end

			if arg_539_1.time_ >= var_542_1 + var_542_4 and arg_539_1.time_ < var_542_1 + var_542_4 + arg_542_0 then
				var_542_0.localPosition = Vector3.New(0, -400, 0)
			end

			local var_542_7 = arg_539_1.actors_["1038"]
			local var_542_8 = 0

			if var_542_8 < arg_539_1.time_ and arg_539_1.time_ <= var_542_8 + arg_542_0 then
				local var_542_9 = var_542_7:GetComponentInChildren(typeof(CanvasGroup))

				if var_542_9 then
					arg_539_1.var_.alphaOldValue1038 = var_542_9.alpha
					arg_539_1.var_.characterEffect1038 = var_542_9
				end

				arg_539_1.var_.alphaOldValue1038 = 0
			end

			local var_542_10 = 0.333333333333333

			if var_542_8 <= arg_539_1.time_ and arg_539_1.time_ < var_542_8 + var_542_10 then
				local var_542_11 = (arg_539_1.time_ - var_542_8) / var_542_10
				local var_542_12 = Mathf.Lerp(arg_539_1.var_.alphaOldValue1038, 1, var_542_11)

				if arg_539_1.var_.characterEffect1038 then
					arg_539_1.var_.characterEffect1038.alpha = var_542_12
				end
			end

			if arg_539_1.time_ >= var_542_8 + var_542_10 and arg_539_1.time_ < var_542_8 + var_542_10 + arg_542_0 and arg_539_1.var_.characterEffect1038 then
				arg_539_1.var_.characterEffect1038.alpha = 1
			end

			local var_542_13 = 0
			local var_542_14 = 0.5

			if var_542_13 < arg_539_1.time_ and arg_539_1.time_ <= var_542_13 + arg_542_0 then
				arg_539_1.talkMaxDuration = 0
				arg_539_1.dialogCg_.alpha = 1

				arg_539_1.dialog_:SetActive(true)
				SetActive(arg_539_1.leftNameGo_, true)

				local var_542_15 = arg_539_1:FormatText(StoryNameCfg[94].name)

				arg_539_1.leftNameTxt_.text = var_542_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_539_1.leftNameTxt_.transform)

				arg_539_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_539_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_539_1:RecordName(arg_539_1.leftNameTxt_.text)
				SetActive(arg_539_1.iconTrs_.gameObject, false)
				arg_539_1.callingController_:SetSelectedState("normal")

				local var_542_16 = arg_539_1:GetWordFromCfg(115281127)
				local var_542_17 = arg_539_1:FormatText(var_542_16.content)

				arg_539_1.text_.text = var_542_17

				LuaForUtil.ClearLinePrefixSymbol(arg_539_1.text_)

				local var_542_18 = 19
				local var_542_19 = utf8.len(var_542_17)
				local var_542_20 = var_542_18 <= 0 and var_542_14 or var_542_14 * (var_542_19 / var_542_18)

				if var_542_20 > 0 and var_542_14 < var_542_20 then
					arg_539_1.talkMaxDuration = var_542_20

					if var_542_20 + var_542_13 > arg_539_1.duration_ then
						arg_539_1.duration_ = var_542_20 + var_542_13
					end
				end

				arg_539_1.text_.text = var_542_17
				arg_539_1.typewritter.percent = 0

				arg_539_1.typewritter:SetDirty()
				arg_539_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115281", "115281127", "story_v_out_115281.awb") ~= 0 then
					local var_542_21 = manager.audio:GetVoiceLength("story_v_out_115281", "115281127", "story_v_out_115281.awb") / 1000

					if var_542_21 + var_542_13 > arg_539_1.duration_ then
						arg_539_1.duration_ = var_542_21 + var_542_13
					end

					if var_542_16.prefab_name ~= "" and arg_539_1.actors_[var_542_16.prefab_name] ~= nil then
						local var_542_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_539_1.actors_[var_542_16.prefab_name].transform, "story_v_out_115281", "115281127", "story_v_out_115281.awb")

						arg_539_1:RecordAudio("115281127", var_542_22)
						arg_539_1:RecordAudio("115281127", var_542_22)
					else
						arg_539_1:AudioAction("play", "voice", "story_v_out_115281", "115281127", "story_v_out_115281.awb")
					end

					arg_539_1:RecordHistoryTalkVoice("story_v_out_115281", "115281127", "story_v_out_115281.awb")
				end

				arg_539_1:RecordContent(arg_539_1.text_.text)
			end

			local var_542_23 = math.max(var_542_14, arg_539_1.talkMaxDuration)

			if var_542_13 <= arg_539_1.time_ and arg_539_1.time_ < var_542_13 + var_542_23 then
				arg_539_1.typewritter.percent = (arg_539_1.time_ - var_542_13) / var_542_23

				arg_539_1.typewritter:SetDirty()
			end

			if arg_539_1.time_ >= var_542_13 + var_542_23 and arg_539_1.time_ < var_542_13 + var_542_23 + arg_542_0 then
				arg_539_1.typewritter.percent = 1

				arg_539_1.typewritter:SetDirty()
				arg_539_1:ShowNextGo(true)
			end
		end

		arg_539_1.nodeConfigList_ = {
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

		arg_539_1:InitPlayNodeList()
	end,
	Play115281128 = function(arg_543_0, arg_543_1)
		arg_543_1.time_ = 0
		arg_543_1.frameCnt_ = 0
		arg_543_1.state_ = "playing"
		arg_543_1.curTalkId_ = 115281128
		arg_543_1.duration_ = 5.3

		local var_543_0 = {
			ja = 3.133,
			ko = 2.033,
			zh = 5.3,
			en = 3.9
		}
		local var_543_1 = manager.audio:GetLocalizationFlag()

		if var_543_0[var_543_1] ~= nil then
			arg_543_1.duration_ = var_543_0[var_543_1]
		end

		SetActive(arg_543_1.tipsGo_, false)

		function arg_543_1.onSingleLineFinish_()
			arg_543_1.onSingleLineUpdate_ = nil
			arg_543_1.onSingleLineFinish_ = nil
			arg_543_1.state_ = "waiting"
		end

		function arg_543_1.playNext_(arg_545_0)
			if arg_545_0 == 1 then
				arg_543_0:Play115281129(arg_543_1)
			end
		end

		function arg_543_1.onSingleLineUpdate_(arg_546_0)
			local var_546_0 = arg_543_1.actors_["1038"].transform
			local var_546_1 = 0

			if var_546_1 < arg_543_1.time_ and arg_543_1.time_ <= var_546_1 + arg_546_0 then
				arg_543_1.var_.moveOldPos1038 = var_546_0.localPosition
				var_546_0.localScale = Vector3.New(1, 1, 1)

				arg_543_1:CheckSpriteTmpPos("1038", 3)

				local var_546_2 = var_546_0.childCount

				for iter_546_0 = 0, var_546_2 - 1 do
					local var_546_3 = var_546_0:GetChild(iter_546_0)

					if var_546_3.name == "split_7" or not string.find(var_546_3.name, "split") then
						var_546_3.gameObject:SetActive(true)
					else
						var_546_3.gameObject:SetActive(false)
					end
				end
			end

			local var_546_4 = 0.001

			if var_546_1 <= arg_543_1.time_ and arg_543_1.time_ < var_546_1 + var_546_4 then
				local var_546_5 = (arg_543_1.time_ - var_546_1) / var_546_4
				local var_546_6 = Vector3.New(0, -400, 0)

				var_546_0.localPosition = Vector3.Lerp(arg_543_1.var_.moveOldPos1038, var_546_6, var_546_5)
			end

			if arg_543_1.time_ >= var_546_1 + var_546_4 and arg_543_1.time_ < var_546_1 + var_546_4 + arg_546_0 then
				var_546_0.localPosition = Vector3.New(0, -400, 0)
			end

			local var_546_7 = 0
			local var_546_8 = 0.425

			if var_546_7 < arg_543_1.time_ and arg_543_1.time_ <= var_546_7 + arg_546_0 then
				arg_543_1.talkMaxDuration = 0
				arg_543_1.dialogCg_.alpha = 1

				arg_543_1.dialog_:SetActive(true)
				SetActive(arg_543_1.leftNameGo_, true)

				local var_546_9 = arg_543_1:FormatText(StoryNameCfg[94].name)

				arg_543_1.leftNameTxt_.text = var_546_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_543_1.leftNameTxt_.transform)

				arg_543_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_543_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_543_1:RecordName(arg_543_1.leftNameTxt_.text)
				SetActive(arg_543_1.iconTrs_.gameObject, false)
				arg_543_1.callingController_:SetSelectedState("normal")

				local var_546_10 = arg_543_1:GetWordFromCfg(115281128)
				local var_546_11 = arg_543_1:FormatText(var_546_10.content)

				arg_543_1.text_.text = var_546_11

				LuaForUtil.ClearLinePrefixSymbol(arg_543_1.text_)

				local var_546_12 = 17
				local var_546_13 = utf8.len(var_546_11)
				local var_546_14 = var_546_12 <= 0 and var_546_8 or var_546_8 * (var_546_13 / var_546_12)

				if var_546_14 > 0 and var_546_8 < var_546_14 then
					arg_543_1.talkMaxDuration = var_546_14

					if var_546_14 + var_546_7 > arg_543_1.duration_ then
						arg_543_1.duration_ = var_546_14 + var_546_7
					end
				end

				arg_543_1.text_.text = var_546_11
				arg_543_1.typewritter.percent = 0

				arg_543_1.typewritter:SetDirty()
				arg_543_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115281", "115281128", "story_v_out_115281.awb") ~= 0 then
					local var_546_15 = manager.audio:GetVoiceLength("story_v_out_115281", "115281128", "story_v_out_115281.awb") / 1000

					if var_546_15 + var_546_7 > arg_543_1.duration_ then
						arg_543_1.duration_ = var_546_15 + var_546_7
					end

					if var_546_10.prefab_name ~= "" and arg_543_1.actors_[var_546_10.prefab_name] ~= nil then
						local var_546_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_543_1.actors_[var_546_10.prefab_name].transform, "story_v_out_115281", "115281128", "story_v_out_115281.awb")

						arg_543_1:RecordAudio("115281128", var_546_16)
						arg_543_1:RecordAudio("115281128", var_546_16)
					else
						arg_543_1:AudioAction("play", "voice", "story_v_out_115281", "115281128", "story_v_out_115281.awb")
					end

					arg_543_1:RecordHistoryTalkVoice("story_v_out_115281", "115281128", "story_v_out_115281.awb")
				end

				arg_543_1:RecordContent(arg_543_1.text_.text)
			end

			local var_546_17 = math.max(var_546_8, arg_543_1.talkMaxDuration)

			if var_546_7 <= arg_543_1.time_ and arg_543_1.time_ < var_546_7 + var_546_17 then
				arg_543_1.typewritter.percent = (arg_543_1.time_ - var_546_7) / var_546_17

				arg_543_1.typewritter:SetDirty()
			end

			if arg_543_1.time_ >= var_546_7 + var_546_17 and arg_543_1.time_ < var_546_7 + var_546_17 + arg_546_0 then
				arg_543_1.typewritter.percent = 1

				arg_543_1.typewritter:SetDirty()
				arg_543_1:ShowNextGo(true)
			end
		end

		arg_543_1.nodeConfigList_ = {
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

		arg_543_1:InitPlayNodeList()
	end,
	Play115281129 = function(arg_547_0, arg_547_1)
		arg_547_1.time_ = 0
		arg_547_1.frameCnt_ = 0
		arg_547_1.state_ = "playing"
		arg_547_1.curTalkId_ = 115281129
		arg_547_1.duration_ = 9

		SetActive(arg_547_1.tipsGo_, false)

		function arg_547_1.onSingleLineFinish_()
			arg_547_1.onSingleLineUpdate_ = nil
			arg_547_1.onSingleLineFinish_ = nil
			arg_547_1.state_ = "waiting"
		end

		function arg_547_1.playNext_(arg_549_0)
			if arg_549_0 == 1 then
				arg_547_0:Play115281130(arg_547_1)
			end
		end

		function arg_547_1.onSingleLineUpdate_(arg_550_0)
			local var_550_0 = "RO0501"

			if arg_547_1.bgs_[var_550_0] == nil then
				local var_550_1 = Object.Instantiate(arg_547_1.paintGo_)

				var_550_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_550_0)
				var_550_1.name = var_550_0
				var_550_1.transform.parent = arg_547_1.stage_.transform
				var_550_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_547_1.bgs_[var_550_0] = var_550_1
			end

			local var_550_2 = 1.98333333333333

			if var_550_2 < arg_547_1.time_ and arg_547_1.time_ <= var_550_2 + arg_550_0 then
				local var_550_3 = manager.ui.mainCamera.transform.localPosition
				local var_550_4 = Vector3.New(0, 0, 10) + Vector3.New(var_550_3.x, var_550_3.y, 0)
				local var_550_5 = arg_547_1.bgs_.RO0501

				var_550_5.transform.localPosition = var_550_4
				var_550_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_550_6 = var_550_5:GetComponent("SpriteRenderer")

				if var_550_6 and var_550_6.sprite then
					local var_550_7 = (var_550_5.transform.localPosition - var_550_3).z
					local var_550_8 = manager.ui.mainCameraCom_
					local var_550_9 = 2 * var_550_7 * Mathf.Tan(var_550_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_550_10 = var_550_9 * var_550_8.aspect
					local var_550_11 = var_550_6.sprite.bounds.size.x
					local var_550_12 = var_550_6.sprite.bounds.size.y
					local var_550_13 = var_550_10 / var_550_11
					local var_550_14 = var_550_9 / var_550_12
					local var_550_15 = var_550_14 < var_550_13 and var_550_13 or var_550_14

					var_550_5.transform.localScale = Vector3.New(var_550_15, var_550_15, 0)
				end

				for iter_550_0, iter_550_1 in pairs(arg_547_1.bgs_) do
					if iter_550_0 ~= "RO0501" then
						iter_550_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_550_16 = 0

			if var_550_16 < arg_547_1.time_ and arg_547_1.time_ <= var_550_16 + arg_550_0 then
				arg_547_1.mask_.enabled = true
				arg_547_1.mask_.raycastTarget = true

				arg_547_1:SetGaussion(false)
			end

			local var_550_17 = 2

			if var_550_16 <= arg_547_1.time_ and arg_547_1.time_ < var_550_16 + var_550_17 then
				local var_550_18 = (arg_547_1.time_ - var_550_16) / var_550_17
				local var_550_19 = Color.New(1, 1, 1)

				var_550_19.a = Mathf.Lerp(0, 1, var_550_18)
				arg_547_1.mask_.color = var_550_19
			end

			if arg_547_1.time_ >= var_550_16 + var_550_17 and arg_547_1.time_ < var_550_16 + var_550_17 + arg_550_0 then
				local var_550_20 = Color.New(1, 1, 1)

				var_550_20.a = 1
				arg_547_1.mask_.color = var_550_20
			end

			local var_550_21 = 2

			if var_550_21 < arg_547_1.time_ and arg_547_1.time_ <= var_550_21 + arg_550_0 then
				arg_547_1.mask_.enabled = true
				arg_547_1.mask_.raycastTarget = true

				arg_547_1:SetGaussion(false)
			end

			local var_550_22 = 2

			if var_550_21 <= arg_547_1.time_ and arg_547_1.time_ < var_550_21 + var_550_22 then
				local var_550_23 = (arg_547_1.time_ - var_550_21) / var_550_22
				local var_550_24 = Color.New(1, 1, 1)

				var_550_24.a = Mathf.Lerp(1, 0, var_550_23)
				arg_547_1.mask_.color = var_550_24
			end

			if arg_547_1.time_ >= var_550_21 + var_550_22 and arg_547_1.time_ < var_550_21 + var_550_22 + arg_550_0 then
				local var_550_25 = Color.New(1, 1, 1)
				local var_550_26 = 0

				arg_547_1.mask_.enabled = false
				var_550_25.a = var_550_26
				arg_547_1.mask_.color = var_550_25
			end

			local var_550_27 = arg_547_1.actors_["1038"].transform
			local var_550_28 = 2

			if var_550_28 < arg_547_1.time_ and arg_547_1.time_ <= var_550_28 + arg_550_0 then
				arg_547_1.var_.moveOldPos1038 = var_550_27.localPosition
				var_550_27.localScale = Vector3.New(1, 1, 1)

				arg_547_1:CheckSpriteTmpPos("1038", 0)

				local var_550_29 = var_550_27.childCount

				for iter_550_2 = 0, var_550_29 - 1 do
					local var_550_30 = var_550_27:GetChild(iter_550_2)

					if var_550_30.name == "split_7" or not string.find(var_550_30.name, "split") then
						var_550_30.gameObject:SetActive(true)
					else
						var_550_30.gameObject:SetActive(false)
					end
				end
			end

			local var_550_31 = 0.001

			if var_550_28 <= arg_547_1.time_ and arg_547_1.time_ < var_550_28 + var_550_31 then
				local var_550_32 = (arg_547_1.time_ - var_550_28) / var_550_31
				local var_550_33 = Vector3.New(-1500, -350, -180)

				var_550_27.localPosition = Vector3.Lerp(arg_547_1.var_.moveOldPos1038, var_550_33, var_550_32)
			end

			if arg_547_1.time_ >= var_550_28 + var_550_31 and arg_547_1.time_ < var_550_28 + var_550_31 + arg_550_0 then
				var_550_27.localPosition = Vector3.New(-1500, -350, -180)
			end

			local var_550_34 = 4
			local var_550_35 = 1

			if var_550_34 < arg_547_1.time_ and arg_547_1.time_ <= var_550_34 + arg_550_0 then
				local var_550_36 = "play"
				local var_550_37 = "effect"

				arg_547_1:AudioAction(var_550_36, var_550_37, "se_story_activity_1_5_3", "se_story_activity_1_5_3_magic", "")
			end

			local var_550_38 = manager.ui.mainCamera.transform
			local var_550_39 = 1.98333333333333

			if var_550_39 < arg_547_1.time_ and arg_547_1.time_ <= var_550_39 + arg_550_0 then
				local var_550_40 = arg_547_1.var_.effecthuo

				if var_550_40 then
					Object.Destroy(var_550_40)

					arg_547_1.var_.effecthuo = nil
				end
			end

			local var_550_41 = arg_547_1.bgs_.RO0501.transform
			local var_550_42 = 2

			if var_550_42 < arg_547_1.time_ and arg_547_1.time_ <= var_550_42 + arg_550_0 then
				arg_547_1.var_.moveOldPosRO0501 = var_550_41.localPosition
			end

			local var_550_43 = 0.001

			if var_550_42 <= arg_547_1.time_ and arg_547_1.time_ < var_550_42 + var_550_43 then
				local var_550_44 = (arg_547_1.time_ - var_550_42) / var_550_43
				local var_550_45 = Vector3.New(3.68, 0.25, 1)

				var_550_41.localPosition = Vector3.Lerp(arg_547_1.var_.moveOldPosRO0501, var_550_45, var_550_44)
			end

			if arg_547_1.time_ >= var_550_42 + var_550_43 and arg_547_1.time_ < var_550_42 + var_550_43 + arg_550_0 then
				var_550_41.localPosition = Vector3.New(3.68, 0.25, 1)
			end

			local var_550_46 = arg_547_1.bgs_.RO0501.transform
			local var_550_47 = 2.83333333333333

			if var_550_47 < arg_547_1.time_ and arg_547_1.time_ <= var_550_47 + arg_550_0 then
				arg_547_1.var_.moveOldPosRO0501 = var_550_46.localPosition
			end

			local var_550_48 = 2.86666666666667

			if var_550_47 <= arg_547_1.time_ and arg_547_1.time_ < var_550_47 + var_550_48 then
				local var_550_49 = (arg_547_1.time_ - var_550_47) / var_550_48
				local var_550_50 = Vector3.New(-3.13, 0.25, 5)

				var_550_46.localPosition = Vector3.Lerp(arg_547_1.var_.moveOldPosRO0501, var_550_50, var_550_49)
			end

			if arg_547_1.time_ >= var_550_47 + var_550_48 and arg_547_1.time_ < var_550_47 + var_550_48 + arg_550_0 then
				var_550_46.localPosition = Vector3.New(-3.13, 0.25, 5)
			end

			local var_550_51 = 4
			local var_550_52 = 1.1

			if var_550_51 < arg_547_1.time_ and arg_547_1.time_ <= var_550_51 + arg_550_0 then
				arg_547_1.talkMaxDuration = 0
				arg_547_1.dialogCg_.alpha = 1

				arg_547_1.dialog_:SetActive(true)
				SetActive(arg_547_1.leftNameGo_, false)

				arg_547_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_547_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_547_1:RecordName(arg_547_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_547_1.iconTrs_.gameObject, false)
				arg_547_1.callingController_:SetSelectedState("normal")

				local var_550_53 = arg_547_1:GetWordFromCfg(115281129)
				local var_550_54 = arg_547_1:FormatText(var_550_53.content)

				arg_547_1.text_.text = var_550_54

				LuaForUtil.ClearLinePrefixSymbol(arg_547_1.text_)

				local var_550_55 = 44
				local var_550_56 = utf8.len(var_550_54)
				local var_550_57 = var_550_55 <= 0 and var_550_52 or var_550_52 * (var_550_56 / var_550_55)

				if var_550_57 > 0 and var_550_52 < var_550_57 then
					arg_547_1.talkMaxDuration = var_550_57

					if var_550_57 + var_550_51 > arg_547_1.duration_ then
						arg_547_1.duration_ = var_550_57 + var_550_51
					end
				end

				arg_547_1.text_.text = var_550_54
				arg_547_1.typewritter.percent = 0

				arg_547_1.typewritter:SetDirty()
				arg_547_1:ShowNextGo(false)
				arg_547_1:RecordContent(arg_547_1.text_.text)
			end

			local var_550_58 = math.max(var_550_52, arg_547_1.talkMaxDuration)

			if var_550_51 <= arg_547_1.time_ and arg_547_1.time_ < var_550_51 + var_550_58 then
				arg_547_1.typewritter.percent = (arg_547_1.time_ - var_550_51) / var_550_58

				arg_547_1.typewritter:SetDirty()
			end

			if arg_547_1.time_ >= var_550_51 + var_550_58 and arg_547_1.time_ < var_550_51 + var_550_58 + arg_550_0 then
				arg_547_1.typewritter.percent = 1

				arg_547_1.typewritter:SetDirty()
				arg_547_1:ShowNextGo(true)
			end
		end

		arg_547_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "RO0501",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0339999999999998,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "RO0501",
				changeDisplayLayer = false,
				needEase = false,
				duration = 2.86666666666667,
				className = "StoryMoveNode",
				startTime = 2.83333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_547_1:InitPlayNodeList()
	end,
	Play115281130 = function(arg_551_0, arg_551_1)
		arg_551_1.time_ = 0
		arg_551_1.frameCnt_ = 0
		arg_551_1.state_ = "playing"
		arg_551_1.curTalkId_ = 115281130
		arg_551_1.duration_ = 6.8

		local var_551_0 = {
			ja = 6.8,
			ko = 3.366,
			zh = 4.9,
			en = 2.766
		}
		local var_551_1 = manager.audio:GetLocalizationFlag()

		if var_551_0[var_551_1] ~= nil then
			arg_551_1.duration_ = var_551_0[var_551_1]
		end

		SetActive(arg_551_1.tipsGo_, false)

		function arg_551_1.onSingleLineFinish_()
			arg_551_1.onSingleLineUpdate_ = nil
			arg_551_1.onSingleLineFinish_ = nil
			arg_551_1.state_ = "waiting"
		end

		function arg_551_1.playNext_(arg_553_0)
			if arg_553_0 == 1 then
				arg_551_0:Play115281131(arg_551_1)
			end
		end

		function arg_551_1.onSingleLineUpdate_(arg_554_0)
			local var_554_0 = 0
			local var_554_1 = 0.325

			if var_554_0 < arg_551_1.time_ and arg_551_1.time_ <= var_554_0 + arg_554_0 then
				arg_551_1.talkMaxDuration = 0
				arg_551_1.dialogCg_.alpha = 1

				arg_551_1.dialog_:SetActive(true)
				SetActive(arg_551_1.leftNameGo_, true)

				local var_554_2 = arg_551_1:FormatText(StoryNameCfg[94].name)

				arg_551_1.leftNameTxt_.text = var_554_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_551_1.leftNameTxt_.transform)

				arg_551_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_551_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_551_1:RecordName(arg_551_1.leftNameTxt_.text)
				SetActive(arg_551_1.iconTrs_.gameObject, false)
				arg_551_1.callingController_:SetSelectedState("normal")

				local var_554_3 = arg_551_1:GetWordFromCfg(115281130)
				local var_554_4 = arg_551_1:FormatText(var_554_3.content)

				arg_551_1.text_.text = var_554_4

				LuaForUtil.ClearLinePrefixSymbol(arg_551_1.text_)

				local var_554_5 = 13
				local var_554_6 = utf8.len(var_554_4)
				local var_554_7 = var_554_5 <= 0 and var_554_1 or var_554_1 * (var_554_6 / var_554_5)

				if var_554_7 > 0 and var_554_1 < var_554_7 then
					arg_551_1.talkMaxDuration = var_554_7

					if var_554_7 + var_554_0 > arg_551_1.duration_ then
						arg_551_1.duration_ = var_554_7 + var_554_0
					end
				end

				arg_551_1.text_.text = var_554_4
				arg_551_1.typewritter.percent = 0

				arg_551_1.typewritter:SetDirty()
				arg_551_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115281", "115281130", "story_v_out_115281.awb") ~= 0 then
					local var_554_8 = manager.audio:GetVoiceLength("story_v_out_115281", "115281130", "story_v_out_115281.awb") / 1000

					if var_554_8 + var_554_0 > arg_551_1.duration_ then
						arg_551_1.duration_ = var_554_8 + var_554_0
					end

					if var_554_3.prefab_name ~= "" and arg_551_1.actors_[var_554_3.prefab_name] ~= nil then
						local var_554_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_551_1.actors_[var_554_3.prefab_name].transform, "story_v_out_115281", "115281130", "story_v_out_115281.awb")

						arg_551_1:RecordAudio("115281130", var_554_9)
						arg_551_1:RecordAudio("115281130", var_554_9)
					else
						arg_551_1:AudioAction("play", "voice", "story_v_out_115281", "115281130", "story_v_out_115281.awb")
					end

					arg_551_1:RecordHistoryTalkVoice("story_v_out_115281", "115281130", "story_v_out_115281.awb")
				end

				arg_551_1:RecordContent(arg_551_1.text_.text)
			end

			local var_554_10 = math.max(var_554_1, arg_551_1.talkMaxDuration)

			if var_554_0 <= arg_551_1.time_ and arg_551_1.time_ < var_554_0 + var_554_10 then
				arg_551_1.typewritter.percent = (arg_551_1.time_ - var_554_0) / var_554_10

				arg_551_1.typewritter:SetDirty()
			end

			if arg_551_1.time_ >= var_554_0 + var_554_10 and arg_551_1.time_ < var_554_0 + var_554_10 + arg_554_0 then
				arg_551_1.typewritter.percent = 1

				arg_551_1.typewritter:SetDirty()
				arg_551_1:ShowNextGo(true)
			end
		end

		arg_551_1.nodeConfigList_ = {}

		arg_551_1:InitPlayNodeList()
	end,
	Play115281131 = function(arg_555_0, arg_555_1)
		arg_555_1.time_ = 0
		arg_555_1.frameCnt_ = 0
		arg_555_1.state_ = "playing"
		arg_555_1.curTalkId_ = 115281131
		arg_555_1.duration_ = 5

		SetActive(arg_555_1.tipsGo_, false)

		function arg_555_1.onSingleLineFinish_()
			arg_555_1.onSingleLineUpdate_ = nil
			arg_555_1.onSingleLineFinish_ = nil
			arg_555_1.state_ = "waiting"
		end

		function arg_555_1.playNext_(arg_557_0)
			if arg_557_0 == 1 then
				arg_555_0:Play115281132(arg_555_1)
			end
		end

		function arg_555_1.onSingleLineUpdate_(arg_558_0)
			local var_558_0 = 0
			local var_558_1 = 1.05

			if var_558_0 < arg_555_1.time_ and arg_555_1.time_ <= var_558_0 + arg_558_0 then
				arg_555_1.talkMaxDuration = 0
				arg_555_1.dialogCg_.alpha = 1

				arg_555_1.dialog_:SetActive(true)
				SetActive(arg_555_1.leftNameGo_, false)

				arg_555_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_555_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_555_1:RecordName(arg_555_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_555_1.iconTrs_.gameObject, false)
				arg_555_1.callingController_:SetSelectedState("normal")

				local var_558_2 = arg_555_1:GetWordFromCfg(115281131)
				local var_558_3 = arg_555_1:FormatText(var_558_2.content)

				arg_555_1.text_.text = var_558_3

				LuaForUtil.ClearLinePrefixSymbol(arg_555_1.text_)

				local var_558_4 = 42
				local var_558_5 = utf8.len(var_558_3)
				local var_558_6 = var_558_4 <= 0 and var_558_1 or var_558_1 * (var_558_5 / var_558_4)

				if var_558_6 > 0 and var_558_1 < var_558_6 then
					arg_555_1.talkMaxDuration = var_558_6

					if var_558_6 + var_558_0 > arg_555_1.duration_ then
						arg_555_1.duration_ = var_558_6 + var_558_0
					end
				end

				arg_555_1.text_.text = var_558_3
				arg_555_1.typewritter.percent = 0

				arg_555_1.typewritter:SetDirty()
				arg_555_1:ShowNextGo(false)
				arg_555_1:RecordContent(arg_555_1.text_.text)
			end

			local var_558_7 = math.max(var_558_1, arg_555_1.talkMaxDuration)

			if var_558_0 <= arg_555_1.time_ and arg_555_1.time_ < var_558_0 + var_558_7 then
				arg_555_1.typewritter.percent = (arg_555_1.time_ - var_558_0) / var_558_7

				arg_555_1.typewritter:SetDirty()
			end

			if arg_555_1.time_ >= var_558_0 + var_558_7 and arg_555_1.time_ < var_558_0 + var_558_7 + arg_558_0 then
				arg_555_1.typewritter.percent = 1

				arg_555_1.typewritter:SetDirty()
				arg_555_1:ShowNextGo(true)
			end
		end

		arg_555_1.nodeConfigList_ = {}

		arg_555_1:InitPlayNodeList()
	end,
	Play115281132 = function(arg_559_0, arg_559_1)
		arg_559_1.time_ = 0
		arg_559_1.frameCnt_ = 0
		arg_559_1.state_ = "playing"
		arg_559_1.curTalkId_ = 115281132
		arg_559_1.duration_ = 5

		SetActive(arg_559_1.tipsGo_, false)

		function arg_559_1.onSingleLineFinish_()
			arg_559_1.onSingleLineUpdate_ = nil
			arg_559_1.onSingleLineFinish_ = nil
			arg_559_1.state_ = "waiting"
		end

		function arg_559_1.playNext_(arg_561_0)
			if arg_561_0 == 1 then
				arg_559_0:Play115281133(arg_559_1)
			end
		end

		function arg_559_1.onSingleLineUpdate_(arg_562_0)
			local var_562_0 = 0

			if var_562_0 < arg_559_1.time_ and arg_559_1.time_ <= var_562_0 + arg_562_0 then
				arg_559_1.mask_.enabled = true
				arg_559_1.mask_.raycastTarget = true

				arg_559_1:SetGaussion(false)
			end

			local var_562_1 = 0.8

			if var_562_0 <= arg_559_1.time_ and arg_559_1.time_ < var_562_0 + var_562_1 then
				local var_562_2 = (arg_559_1.time_ - var_562_0) / var_562_1
				local var_562_3 = Color.New(1, 1, 1)

				var_562_3.a = Mathf.Lerp(1, 0, var_562_2)
				arg_559_1.mask_.color = var_562_3
			end

			if arg_559_1.time_ >= var_562_0 + var_562_1 and arg_559_1.time_ < var_562_0 + var_562_1 + arg_562_0 then
				local var_562_4 = Color.New(1, 1, 1)
				local var_562_5 = 0

				arg_559_1.mask_.enabled = false
				var_562_4.a = var_562_5
				arg_559_1.mask_.color = var_562_4
			end

			local var_562_6 = 0
			local var_562_7 = 1.625

			if var_562_6 < arg_559_1.time_ and arg_559_1.time_ <= var_562_6 + arg_562_0 then
				arg_559_1.talkMaxDuration = 0
				arg_559_1.dialogCg_.alpha = 1

				arg_559_1.dialog_:SetActive(true)
				SetActive(arg_559_1.leftNameGo_, false)

				arg_559_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_559_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_559_1:RecordName(arg_559_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_559_1.iconTrs_.gameObject, false)
				arg_559_1.callingController_:SetSelectedState("normal")

				local var_562_8 = arg_559_1:GetWordFromCfg(115281132)
				local var_562_9 = arg_559_1:FormatText(var_562_8.content)

				arg_559_1.text_.text = var_562_9

				LuaForUtil.ClearLinePrefixSymbol(arg_559_1.text_)

				local var_562_10 = 65
				local var_562_11 = utf8.len(var_562_9)
				local var_562_12 = var_562_10 <= 0 and var_562_7 or var_562_7 * (var_562_11 / var_562_10)

				if var_562_12 > 0 and var_562_7 < var_562_12 then
					arg_559_1.talkMaxDuration = var_562_12

					if var_562_12 + var_562_6 > arg_559_1.duration_ then
						arg_559_1.duration_ = var_562_12 + var_562_6
					end
				end

				arg_559_1.text_.text = var_562_9
				arg_559_1.typewritter.percent = 0

				arg_559_1.typewritter:SetDirty()
				arg_559_1:ShowNextGo(false)
				arg_559_1:RecordContent(arg_559_1.text_.text)
			end

			local var_562_13 = math.max(var_562_7, arg_559_1.talkMaxDuration)

			if var_562_6 <= arg_559_1.time_ and arg_559_1.time_ < var_562_6 + var_562_13 then
				arg_559_1.typewritter.percent = (arg_559_1.time_ - var_562_6) / var_562_13

				arg_559_1.typewritter:SetDirty()
			end

			if arg_559_1.time_ >= var_562_6 + var_562_13 and arg_559_1.time_ < var_562_6 + var_562_13 + arg_562_0 then
				arg_559_1.typewritter.percent = 1

				arg_559_1.typewritter:SetDirty()
				arg_559_1:ShowNextGo(true)
			end
		end

		arg_559_1.nodeConfigList_ = {}

		arg_559_1:InitPlayNodeList()
	end,
	Play115281133 = function(arg_563_0, arg_563_1)
		arg_563_1.time_ = 0
		arg_563_1.frameCnt_ = 0
		arg_563_1.state_ = "playing"
		arg_563_1.curTalkId_ = 115281133
		arg_563_1.duration_ = 5

		SetActive(arg_563_1.tipsGo_, false)

		function arg_563_1.onSingleLineFinish_()
			arg_563_1.onSingleLineUpdate_ = nil
			arg_563_1.onSingleLineFinish_ = nil
			arg_563_1.state_ = "waiting"
		end

		function arg_563_1.playNext_(arg_565_0)
			if arg_565_0 == 1 then
				arg_563_0:Play115281134(arg_563_1)
			end
		end

		function arg_563_1.onSingleLineUpdate_(arg_566_0)
			local var_566_0 = 0
			local var_566_1 = 1.05

			if var_566_0 < arg_563_1.time_ and arg_563_1.time_ <= var_566_0 + arg_566_0 then
				arg_563_1.talkMaxDuration = 0
				arg_563_1.dialogCg_.alpha = 1

				arg_563_1.dialog_:SetActive(true)
				SetActive(arg_563_1.leftNameGo_, false)

				arg_563_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_563_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_563_1:RecordName(arg_563_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_563_1.iconTrs_.gameObject, false)
				arg_563_1.callingController_:SetSelectedState("normal")

				local var_566_2 = arg_563_1:GetWordFromCfg(115281133)
				local var_566_3 = arg_563_1:FormatText(var_566_2.content)

				arg_563_1.text_.text = var_566_3

				LuaForUtil.ClearLinePrefixSymbol(arg_563_1.text_)

				local var_566_4 = 42
				local var_566_5 = utf8.len(var_566_3)
				local var_566_6 = var_566_4 <= 0 and var_566_1 or var_566_1 * (var_566_5 / var_566_4)

				if var_566_6 > 0 and var_566_1 < var_566_6 then
					arg_563_1.talkMaxDuration = var_566_6

					if var_566_6 + var_566_0 > arg_563_1.duration_ then
						arg_563_1.duration_ = var_566_6 + var_566_0
					end
				end

				arg_563_1.text_.text = var_566_3
				arg_563_1.typewritter.percent = 0

				arg_563_1.typewritter:SetDirty()
				arg_563_1:ShowNextGo(false)
				arg_563_1:RecordContent(arg_563_1.text_.text)
			end

			local var_566_7 = math.max(var_566_1, arg_563_1.talkMaxDuration)

			if var_566_0 <= arg_563_1.time_ and arg_563_1.time_ < var_566_0 + var_566_7 then
				arg_563_1.typewritter.percent = (arg_563_1.time_ - var_566_0) / var_566_7

				arg_563_1.typewritter:SetDirty()
			end

			if arg_563_1.time_ >= var_566_0 + var_566_7 and arg_563_1.time_ < var_566_0 + var_566_7 + arg_566_0 then
				arg_563_1.typewritter.percent = 1

				arg_563_1.typewritter:SetDirty()
				arg_563_1:ShowNextGo(true)
			end
		end

		arg_563_1.nodeConfigList_ = {}

		arg_563_1:InitPlayNodeList()
	end,
	Play115281134 = function(arg_567_0, arg_567_1)
		arg_567_1.time_ = 0
		arg_567_1.frameCnt_ = 0
		arg_567_1.state_ = "playing"
		arg_567_1.curTalkId_ = 115281134
		arg_567_1.duration_ = 9.03

		local var_567_0 = {
			ja = 7.3,
			ko = 6.1,
			zh = 9.033,
			en = 8.866
		}
		local var_567_1 = manager.audio:GetLocalizationFlag()

		if var_567_0[var_567_1] ~= nil then
			arg_567_1.duration_ = var_567_0[var_567_1]
		end

		SetActive(arg_567_1.tipsGo_, false)

		function arg_567_1.onSingleLineFinish_()
			arg_567_1.onSingleLineUpdate_ = nil
			arg_567_1.onSingleLineFinish_ = nil
			arg_567_1.state_ = "waiting"
		end

		function arg_567_1.playNext_(arg_569_0)
			if arg_569_0 == 1 then
				arg_567_0:Play115281135(arg_567_1)
			end
		end

		function arg_567_1.onSingleLineUpdate_(arg_570_0)
			local var_570_0 = 0
			local var_570_1 = 0.65

			if var_570_0 < arg_567_1.time_ and arg_567_1.time_ <= var_570_0 + arg_570_0 then
				arg_567_1.talkMaxDuration = 0
				arg_567_1.dialogCg_.alpha = 1

				arg_567_1.dialog_:SetActive(true)
				SetActive(arg_567_1.leftNameGo_, true)

				local var_570_2 = arg_567_1:FormatText(StoryNameCfg[94].name)

				arg_567_1.leftNameTxt_.text = var_570_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_567_1.leftNameTxt_.transform)

				arg_567_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_567_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_567_1:RecordName(arg_567_1.leftNameTxt_.text)
				SetActive(arg_567_1.iconTrs_.gameObject, false)
				arg_567_1.callingController_:SetSelectedState("normal")

				local var_570_3 = arg_567_1:GetWordFromCfg(115281134)
				local var_570_4 = arg_567_1:FormatText(var_570_3.content)

				arg_567_1.text_.text = var_570_4

				LuaForUtil.ClearLinePrefixSymbol(arg_567_1.text_)

				local var_570_5 = 25
				local var_570_6 = utf8.len(var_570_4)
				local var_570_7 = var_570_5 <= 0 and var_570_1 or var_570_1 * (var_570_6 / var_570_5)

				if var_570_7 > 0 and var_570_1 < var_570_7 then
					arg_567_1.talkMaxDuration = var_570_7

					if var_570_7 + var_570_0 > arg_567_1.duration_ then
						arg_567_1.duration_ = var_570_7 + var_570_0
					end
				end

				arg_567_1.text_.text = var_570_4
				arg_567_1.typewritter.percent = 0

				arg_567_1.typewritter:SetDirty()
				arg_567_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115281", "115281134", "story_v_out_115281.awb") ~= 0 then
					local var_570_8 = manager.audio:GetVoiceLength("story_v_out_115281", "115281134", "story_v_out_115281.awb") / 1000

					if var_570_8 + var_570_0 > arg_567_1.duration_ then
						arg_567_1.duration_ = var_570_8 + var_570_0
					end

					if var_570_3.prefab_name ~= "" and arg_567_1.actors_[var_570_3.prefab_name] ~= nil then
						local var_570_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_567_1.actors_[var_570_3.prefab_name].transform, "story_v_out_115281", "115281134", "story_v_out_115281.awb")

						arg_567_1:RecordAudio("115281134", var_570_9)
						arg_567_1:RecordAudio("115281134", var_570_9)
					else
						arg_567_1:AudioAction("play", "voice", "story_v_out_115281", "115281134", "story_v_out_115281.awb")
					end

					arg_567_1:RecordHistoryTalkVoice("story_v_out_115281", "115281134", "story_v_out_115281.awb")
				end

				arg_567_1:RecordContent(arg_567_1.text_.text)
			end

			local var_570_10 = math.max(var_570_1, arg_567_1.talkMaxDuration)

			if var_570_0 <= arg_567_1.time_ and arg_567_1.time_ < var_570_0 + var_570_10 then
				arg_567_1.typewritter.percent = (arg_567_1.time_ - var_570_0) / var_570_10

				arg_567_1.typewritter:SetDirty()
			end

			if arg_567_1.time_ >= var_570_0 + var_570_10 and arg_567_1.time_ < var_570_0 + var_570_10 + arg_570_0 then
				arg_567_1.typewritter.percent = 1

				arg_567_1.typewritter:SetDirty()
				arg_567_1:ShowNextGo(true)
			end
		end

		arg_567_1.nodeConfigList_ = {}

		arg_567_1:InitPlayNodeList()
	end,
	Play115281135 = function(arg_571_0, arg_571_1)
		arg_571_1.time_ = 0
		arg_571_1.frameCnt_ = 0
		arg_571_1.state_ = "playing"
		arg_571_1.curTalkId_ = 115281135
		arg_571_1.duration_ = 5

		SetActive(arg_571_1.tipsGo_, false)

		function arg_571_1.onSingleLineFinish_()
			arg_571_1.onSingleLineUpdate_ = nil
			arg_571_1.onSingleLineFinish_ = nil
			arg_571_1.state_ = "waiting"
		end

		function arg_571_1.playNext_(arg_573_0)
			if arg_573_0 == 1 then
				arg_571_0:Play115281136(arg_571_1)
			end
		end

		function arg_571_1.onSingleLineUpdate_(arg_574_0)
			local var_574_0 = 0
			local var_574_1 = 1.15

			if var_574_0 < arg_571_1.time_ and arg_571_1.time_ <= var_574_0 + arg_574_0 then
				arg_571_1.talkMaxDuration = 0
				arg_571_1.dialogCg_.alpha = 1

				arg_571_1.dialog_:SetActive(true)
				SetActive(arg_571_1.leftNameGo_, false)

				arg_571_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_571_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_571_1:RecordName(arg_571_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_571_1.iconTrs_.gameObject, false)
				arg_571_1.callingController_:SetSelectedState("normal")

				local var_574_2 = arg_571_1:GetWordFromCfg(115281135)
				local var_574_3 = arg_571_1:FormatText(var_574_2.content)

				arg_571_1.text_.text = var_574_3

				LuaForUtil.ClearLinePrefixSymbol(arg_571_1.text_)

				local var_574_4 = 46
				local var_574_5 = utf8.len(var_574_3)
				local var_574_6 = var_574_4 <= 0 and var_574_1 or var_574_1 * (var_574_5 / var_574_4)

				if var_574_6 > 0 and var_574_1 < var_574_6 then
					arg_571_1.talkMaxDuration = var_574_6

					if var_574_6 + var_574_0 > arg_571_1.duration_ then
						arg_571_1.duration_ = var_574_6 + var_574_0
					end
				end

				arg_571_1.text_.text = var_574_3
				arg_571_1.typewritter.percent = 0

				arg_571_1.typewritter:SetDirty()
				arg_571_1:ShowNextGo(false)
				arg_571_1:RecordContent(arg_571_1.text_.text)
			end

			local var_574_7 = math.max(var_574_1, arg_571_1.talkMaxDuration)

			if var_574_0 <= arg_571_1.time_ and arg_571_1.time_ < var_574_0 + var_574_7 then
				arg_571_1.typewritter.percent = (arg_571_1.time_ - var_574_0) / var_574_7

				arg_571_1.typewritter:SetDirty()
			end

			if arg_571_1.time_ >= var_574_0 + var_574_7 and arg_571_1.time_ < var_574_0 + var_574_7 + arg_574_0 then
				arg_571_1.typewritter.percent = 1

				arg_571_1.typewritter:SetDirty()
				arg_571_1:ShowNextGo(true)
			end
		end

		arg_571_1.nodeConfigList_ = {}

		arg_571_1:InitPlayNodeList()
	end,
	Play115281136 = function(arg_575_0, arg_575_1)
		arg_575_1.time_ = 0
		arg_575_1.frameCnt_ = 0
		arg_575_1.state_ = "playing"
		arg_575_1.curTalkId_ = 115281136
		arg_575_1.duration_ = 5

		SetActive(arg_575_1.tipsGo_, false)

		function arg_575_1.onSingleLineFinish_()
			arg_575_1.onSingleLineUpdate_ = nil
			arg_575_1.onSingleLineFinish_ = nil
			arg_575_1.state_ = "waiting"
		end

		function arg_575_1.playNext_(arg_577_0)
			if arg_577_0 == 1 then
				arg_575_0:Play115281137(arg_575_1)
			end
		end

		function arg_575_1.onSingleLineUpdate_(arg_578_0)
			local var_578_0 = 0
			local var_578_1 = 0.95

			if var_578_0 < arg_575_1.time_ and arg_575_1.time_ <= var_578_0 + arg_578_0 then
				arg_575_1.talkMaxDuration = 0
				arg_575_1.dialogCg_.alpha = 1

				arg_575_1.dialog_:SetActive(true)
				SetActive(arg_575_1.leftNameGo_, false)

				arg_575_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_575_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_575_1:RecordName(arg_575_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_575_1.iconTrs_.gameObject, false)
				arg_575_1.callingController_:SetSelectedState("normal")

				local var_578_2 = arg_575_1:GetWordFromCfg(115281136)
				local var_578_3 = arg_575_1:FormatText(var_578_2.content)

				arg_575_1.text_.text = var_578_3

				LuaForUtil.ClearLinePrefixSymbol(arg_575_1.text_)

				local var_578_4 = 38
				local var_578_5 = utf8.len(var_578_3)
				local var_578_6 = var_578_4 <= 0 and var_578_1 or var_578_1 * (var_578_5 / var_578_4)

				if var_578_6 > 0 and var_578_1 < var_578_6 then
					arg_575_1.talkMaxDuration = var_578_6

					if var_578_6 + var_578_0 > arg_575_1.duration_ then
						arg_575_1.duration_ = var_578_6 + var_578_0
					end
				end

				arg_575_1.text_.text = var_578_3
				arg_575_1.typewritter.percent = 0

				arg_575_1.typewritter:SetDirty()
				arg_575_1:ShowNextGo(false)
				arg_575_1:RecordContent(arg_575_1.text_.text)
			end

			local var_578_7 = math.max(var_578_1, arg_575_1.talkMaxDuration)

			if var_578_0 <= arg_575_1.time_ and arg_575_1.time_ < var_578_0 + var_578_7 then
				arg_575_1.typewritter.percent = (arg_575_1.time_ - var_578_0) / var_578_7

				arg_575_1.typewritter:SetDirty()
			end

			if arg_575_1.time_ >= var_578_0 + var_578_7 and arg_575_1.time_ < var_578_0 + var_578_7 + arg_578_0 then
				arg_575_1.typewritter.percent = 1

				arg_575_1.typewritter:SetDirty()
				arg_575_1:ShowNextGo(true)
			end
		end

		arg_575_1.nodeConfigList_ = {}

		arg_575_1:InitPlayNodeList()
	end,
	Play115281137 = function(arg_579_0, arg_579_1)
		arg_579_1.time_ = 0
		arg_579_1.frameCnt_ = 0
		arg_579_1.state_ = "playing"
		arg_579_1.curTalkId_ = 115281137
		arg_579_1.duration_ = 5

		SetActive(arg_579_1.tipsGo_, false)

		function arg_579_1.onSingleLineFinish_()
			arg_579_1.onSingleLineUpdate_ = nil
			arg_579_1.onSingleLineFinish_ = nil
			arg_579_1.state_ = "waiting"
		end

		function arg_579_1.playNext_(arg_581_0)
			if arg_581_0 == 1 then
				arg_579_0:Play115281138(arg_579_1)
			end
		end

		function arg_579_1.onSingleLineUpdate_(arg_582_0)
			local var_582_0 = 0
			local var_582_1 = 0.75

			if var_582_0 < arg_579_1.time_ and arg_579_1.time_ <= var_582_0 + arg_582_0 then
				arg_579_1.talkMaxDuration = 0
				arg_579_1.dialogCg_.alpha = 1

				arg_579_1.dialog_:SetActive(true)
				SetActive(arg_579_1.leftNameGo_, false)

				arg_579_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_579_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_579_1:RecordName(arg_579_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_579_1.iconTrs_.gameObject, false)
				arg_579_1.callingController_:SetSelectedState("normal")

				local var_582_2 = arg_579_1:GetWordFromCfg(115281137)
				local var_582_3 = arg_579_1:FormatText(var_582_2.content)

				arg_579_1.text_.text = var_582_3

				LuaForUtil.ClearLinePrefixSymbol(arg_579_1.text_)

				local var_582_4 = 30
				local var_582_5 = utf8.len(var_582_3)
				local var_582_6 = var_582_4 <= 0 and var_582_1 or var_582_1 * (var_582_5 / var_582_4)

				if var_582_6 > 0 and var_582_1 < var_582_6 then
					arg_579_1.talkMaxDuration = var_582_6

					if var_582_6 + var_582_0 > arg_579_1.duration_ then
						arg_579_1.duration_ = var_582_6 + var_582_0
					end
				end

				arg_579_1.text_.text = var_582_3
				arg_579_1.typewritter.percent = 0

				arg_579_1.typewritter:SetDirty()
				arg_579_1:ShowNextGo(false)
				arg_579_1:RecordContent(arg_579_1.text_.text)
			end

			local var_582_7 = math.max(var_582_1, arg_579_1.talkMaxDuration)

			if var_582_0 <= arg_579_1.time_ and arg_579_1.time_ < var_582_0 + var_582_7 then
				arg_579_1.typewritter.percent = (arg_579_1.time_ - var_582_0) / var_582_7

				arg_579_1.typewritter:SetDirty()
			end

			if arg_579_1.time_ >= var_582_0 + var_582_7 and arg_579_1.time_ < var_582_0 + var_582_7 + arg_582_0 then
				arg_579_1.typewritter.percent = 1

				arg_579_1.typewritter:SetDirty()
				arg_579_1:ShowNextGo(true)
			end
		end

		arg_579_1.nodeConfigList_ = {}

		arg_579_1:InitPlayNodeList()
	end,
	Play115281138 = function(arg_583_0, arg_583_1)
		arg_583_1.time_ = 0
		arg_583_1.frameCnt_ = 0
		arg_583_1.state_ = "playing"
		arg_583_1.curTalkId_ = 115281138
		arg_583_1.duration_ = 7.7

		local var_583_0 = {
			ja = 3.666,
			ko = 5.466,
			zh = 7.2,
			en = 7.7
		}
		local var_583_1 = manager.audio:GetLocalizationFlag()

		if var_583_0[var_583_1] ~= nil then
			arg_583_1.duration_ = var_583_0[var_583_1]
		end

		SetActive(arg_583_1.tipsGo_, false)

		function arg_583_1.onSingleLineFinish_()
			arg_583_1.onSingleLineUpdate_ = nil
			arg_583_1.onSingleLineFinish_ = nil
			arg_583_1.state_ = "waiting"
		end

		function arg_583_1.playNext_(arg_585_0)
			if arg_585_0 == 1 then
				arg_583_0:Play115281139(arg_583_1)
			end
		end

		function arg_583_1.onSingleLineUpdate_(arg_586_0)
			local var_586_0 = 0
			local var_586_1 = 0.725

			if var_586_0 < arg_583_1.time_ and arg_583_1.time_ <= var_586_0 + arg_586_0 then
				arg_583_1.talkMaxDuration = 0
				arg_583_1.dialogCg_.alpha = 1

				arg_583_1.dialog_:SetActive(true)
				SetActive(arg_583_1.leftNameGo_, true)

				local var_586_2 = arg_583_1:FormatText(StoryNameCfg[94].name)

				arg_583_1.leftNameTxt_.text = var_586_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_583_1.leftNameTxt_.transform)

				arg_583_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_583_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_583_1:RecordName(arg_583_1.leftNameTxt_.text)
				SetActive(arg_583_1.iconTrs_.gameObject, false)
				arg_583_1.callingController_:SetSelectedState("normal")

				local var_586_3 = arg_583_1:GetWordFromCfg(115281138)
				local var_586_4 = arg_583_1:FormatText(var_586_3.content)

				arg_583_1.text_.text = var_586_4

				LuaForUtil.ClearLinePrefixSymbol(arg_583_1.text_)

				local var_586_5 = 29
				local var_586_6 = utf8.len(var_586_4)
				local var_586_7 = var_586_5 <= 0 and var_586_1 or var_586_1 * (var_586_6 / var_586_5)

				if var_586_7 > 0 and var_586_1 < var_586_7 then
					arg_583_1.talkMaxDuration = var_586_7

					if var_586_7 + var_586_0 > arg_583_1.duration_ then
						arg_583_1.duration_ = var_586_7 + var_586_0
					end
				end

				arg_583_1.text_.text = var_586_4
				arg_583_1.typewritter.percent = 0

				arg_583_1.typewritter:SetDirty()
				arg_583_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115281", "115281138", "story_v_out_115281.awb") ~= 0 then
					local var_586_8 = manager.audio:GetVoiceLength("story_v_out_115281", "115281138", "story_v_out_115281.awb") / 1000

					if var_586_8 + var_586_0 > arg_583_1.duration_ then
						arg_583_1.duration_ = var_586_8 + var_586_0
					end

					if var_586_3.prefab_name ~= "" and arg_583_1.actors_[var_586_3.prefab_name] ~= nil then
						local var_586_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_583_1.actors_[var_586_3.prefab_name].transform, "story_v_out_115281", "115281138", "story_v_out_115281.awb")

						arg_583_1:RecordAudio("115281138", var_586_9)
						arg_583_1:RecordAudio("115281138", var_586_9)
					else
						arg_583_1:AudioAction("play", "voice", "story_v_out_115281", "115281138", "story_v_out_115281.awb")
					end

					arg_583_1:RecordHistoryTalkVoice("story_v_out_115281", "115281138", "story_v_out_115281.awb")
				end

				arg_583_1:RecordContent(arg_583_1.text_.text)
			end

			local var_586_10 = math.max(var_586_1, arg_583_1.talkMaxDuration)

			if var_586_0 <= arg_583_1.time_ and arg_583_1.time_ < var_586_0 + var_586_10 then
				arg_583_1.typewritter.percent = (arg_583_1.time_ - var_586_0) / var_586_10

				arg_583_1.typewritter:SetDirty()
			end

			if arg_583_1.time_ >= var_586_0 + var_586_10 and arg_583_1.time_ < var_586_0 + var_586_10 + arg_586_0 then
				arg_583_1.typewritter.percent = 1

				arg_583_1.typewritter:SetDirty()
				arg_583_1:ShowNextGo(true)
			end
		end

		arg_583_1.nodeConfigList_ = {}

		arg_583_1:InitPlayNodeList()
	end,
	Play115281139 = function(arg_587_0, arg_587_1)
		arg_587_1.time_ = 0
		arg_587_1.frameCnt_ = 0
		arg_587_1.state_ = "playing"
		arg_587_1.curTalkId_ = 115281139
		arg_587_1.duration_ = 5

		SetActive(arg_587_1.tipsGo_, false)

		function arg_587_1.onSingleLineFinish_()
			arg_587_1.onSingleLineUpdate_ = nil
			arg_587_1.onSingleLineFinish_ = nil
			arg_587_1.state_ = "waiting"
		end

		function arg_587_1.playNext_(arg_589_0)
			if arg_589_0 == 1 then
				arg_587_0:Play115281140(arg_587_1)
			end
		end

		function arg_587_1.onSingleLineUpdate_(arg_590_0)
			local var_590_0 = 0
			local var_590_1 = 1.525

			if var_590_0 < arg_587_1.time_ and arg_587_1.time_ <= var_590_0 + arg_590_0 then
				arg_587_1.talkMaxDuration = 0
				arg_587_1.dialogCg_.alpha = 1

				arg_587_1.dialog_:SetActive(true)
				SetActive(arg_587_1.leftNameGo_, false)

				arg_587_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_587_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_587_1:RecordName(arg_587_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_587_1.iconTrs_.gameObject, false)
				arg_587_1.callingController_:SetSelectedState("normal")

				local var_590_2 = arg_587_1:GetWordFromCfg(115281139)
				local var_590_3 = arg_587_1:FormatText(var_590_2.content)

				arg_587_1.text_.text = var_590_3

				LuaForUtil.ClearLinePrefixSymbol(arg_587_1.text_)

				local var_590_4 = 61
				local var_590_5 = utf8.len(var_590_3)
				local var_590_6 = var_590_4 <= 0 and var_590_1 or var_590_1 * (var_590_5 / var_590_4)

				if var_590_6 > 0 and var_590_1 < var_590_6 then
					arg_587_1.talkMaxDuration = var_590_6

					if var_590_6 + var_590_0 > arg_587_1.duration_ then
						arg_587_1.duration_ = var_590_6 + var_590_0
					end
				end

				arg_587_1.text_.text = var_590_3
				arg_587_1.typewritter.percent = 0

				arg_587_1.typewritter:SetDirty()
				arg_587_1:ShowNextGo(false)
				arg_587_1:RecordContent(arg_587_1.text_.text)
			end

			local var_590_7 = math.max(var_590_1, arg_587_1.talkMaxDuration)

			if var_590_0 <= arg_587_1.time_ and arg_587_1.time_ < var_590_0 + var_590_7 then
				arg_587_1.typewritter.percent = (arg_587_1.time_ - var_590_0) / var_590_7

				arg_587_1.typewritter:SetDirty()
			end

			if arg_587_1.time_ >= var_590_0 + var_590_7 and arg_587_1.time_ < var_590_0 + var_590_7 + arg_590_0 then
				arg_587_1.typewritter.percent = 1

				arg_587_1.typewritter:SetDirty()
				arg_587_1:ShowNextGo(true)
			end
		end

		arg_587_1.nodeConfigList_ = {}

		arg_587_1:InitPlayNodeList()
	end,
	Play115281140 = function(arg_591_0, arg_591_1)
		arg_591_1.time_ = 0
		arg_591_1.frameCnt_ = 0
		arg_591_1.state_ = "playing"
		arg_591_1.curTalkId_ = 115281140
		arg_591_1.duration_ = 5

		SetActive(arg_591_1.tipsGo_, false)

		function arg_591_1.onSingleLineFinish_()
			arg_591_1.onSingleLineUpdate_ = nil
			arg_591_1.onSingleLineFinish_ = nil
			arg_591_1.state_ = "waiting"
		end

		function arg_591_1.playNext_(arg_593_0)
			if arg_593_0 == 1 then
				arg_591_0:Play115281141(arg_591_1)
			end
		end

		function arg_591_1.onSingleLineUpdate_(arg_594_0)
			local var_594_0 = 0
			local var_594_1 = 1.375

			if var_594_0 < arg_591_1.time_ and arg_591_1.time_ <= var_594_0 + arg_594_0 then
				arg_591_1.talkMaxDuration = 0
				arg_591_1.dialogCg_.alpha = 1

				arg_591_1.dialog_:SetActive(true)
				SetActive(arg_591_1.leftNameGo_, false)

				arg_591_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_591_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_591_1:RecordName(arg_591_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_591_1.iconTrs_.gameObject, false)
				arg_591_1.callingController_:SetSelectedState("normal")

				local var_594_2 = arg_591_1:GetWordFromCfg(115281140)
				local var_594_3 = arg_591_1:FormatText(var_594_2.content)

				arg_591_1.text_.text = var_594_3

				LuaForUtil.ClearLinePrefixSymbol(arg_591_1.text_)

				local var_594_4 = 55
				local var_594_5 = utf8.len(var_594_3)
				local var_594_6 = var_594_4 <= 0 and var_594_1 or var_594_1 * (var_594_5 / var_594_4)

				if var_594_6 > 0 and var_594_1 < var_594_6 then
					arg_591_1.talkMaxDuration = var_594_6

					if var_594_6 + var_594_0 > arg_591_1.duration_ then
						arg_591_1.duration_ = var_594_6 + var_594_0
					end
				end

				arg_591_1.text_.text = var_594_3
				arg_591_1.typewritter.percent = 0

				arg_591_1.typewritter:SetDirty()
				arg_591_1:ShowNextGo(false)
				arg_591_1:RecordContent(arg_591_1.text_.text)
			end

			local var_594_7 = math.max(var_594_1, arg_591_1.talkMaxDuration)

			if var_594_0 <= arg_591_1.time_ and arg_591_1.time_ < var_594_0 + var_594_7 then
				arg_591_1.typewritter.percent = (arg_591_1.time_ - var_594_0) / var_594_7

				arg_591_1.typewritter:SetDirty()
			end

			if arg_591_1.time_ >= var_594_0 + var_594_7 and arg_591_1.time_ < var_594_0 + var_594_7 + arg_594_0 then
				arg_591_1.typewritter.percent = 1

				arg_591_1.typewritter:SetDirty()
				arg_591_1:ShowNextGo(true)
			end
		end

		arg_591_1.nodeConfigList_ = {}

		arg_591_1:InitPlayNodeList()
	end,
	Play115281141 = function(arg_595_0, arg_595_1)
		arg_595_1.time_ = 0
		arg_595_1.frameCnt_ = 0
		arg_595_1.state_ = "playing"
		arg_595_1.curTalkId_ = 115281141
		arg_595_1.duration_ = 5

		SetActive(arg_595_1.tipsGo_, false)

		function arg_595_1.onSingleLineFinish_()
			arg_595_1.onSingleLineUpdate_ = nil
			arg_595_1.onSingleLineFinish_ = nil
			arg_595_1.state_ = "waiting"
		end

		function arg_595_1.playNext_(arg_597_0)
			if arg_597_0 == 1 then
				arg_595_0:Play115281142(arg_595_1)
			end
		end

		function arg_595_1.onSingleLineUpdate_(arg_598_0)
			local var_598_0 = 0
			local var_598_1 = 0.55

			if var_598_0 < arg_595_1.time_ and arg_595_1.time_ <= var_598_0 + arg_598_0 then
				arg_595_1.talkMaxDuration = 0
				arg_595_1.dialogCg_.alpha = 1

				arg_595_1.dialog_:SetActive(true)
				SetActive(arg_595_1.leftNameGo_, false)

				arg_595_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_595_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_595_1:RecordName(arg_595_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_595_1.iconTrs_.gameObject, false)
				arg_595_1.callingController_:SetSelectedState("normal")

				local var_598_2 = arg_595_1:GetWordFromCfg(115281141)
				local var_598_3 = arg_595_1:FormatText(var_598_2.content)

				arg_595_1.text_.text = var_598_3

				LuaForUtil.ClearLinePrefixSymbol(arg_595_1.text_)

				local var_598_4 = 22
				local var_598_5 = utf8.len(var_598_3)
				local var_598_6 = var_598_4 <= 0 and var_598_1 or var_598_1 * (var_598_5 / var_598_4)

				if var_598_6 > 0 and var_598_1 < var_598_6 then
					arg_595_1.talkMaxDuration = var_598_6

					if var_598_6 + var_598_0 > arg_595_1.duration_ then
						arg_595_1.duration_ = var_598_6 + var_598_0
					end
				end

				arg_595_1.text_.text = var_598_3
				arg_595_1.typewritter.percent = 0

				arg_595_1.typewritter:SetDirty()
				arg_595_1:ShowNextGo(false)
				arg_595_1:RecordContent(arg_595_1.text_.text)
			end

			local var_598_7 = math.max(var_598_1, arg_595_1.talkMaxDuration)

			if var_598_0 <= arg_595_1.time_ and arg_595_1.time_ < var_598_0 + var_598_7 then
				arg_595_1.typewritter.percent = (arg_595_1.time_ - var_598_0) / var_598_7

				arg_595_1.typewritter:SetDirty()
			end

			if arg_595_1.time_ >= var_598_0 + var_598_7 and arg_595_1.time_ < var_598_0 + var_598_7 + arg_598_0 then
				arg_595_1.typewritter.percent = 1

				arg_595_1.typewritter:SetDirty()
				arg_595_1:ShowNextGo(true)
			end
		end

		arg_595_1.nodeConfigList_ = {}

		arg_595_1:InitPlayNodeList()
	end,
	Play115281142 = function(arg_599_0, arg_599_1)
		arg_599_1.time_ = 0
		arg_599_1.frameCnt_ = 0
		arg_599_1.state_ = "playing"
		arg_599_1.curTalkId_ = 115281142
		arg_599_1.duration_ = 12.5

		local var_599_0 = {
			ja = 12.5,
			ko = 8.5,
			zh = 10.6,
			en = 9.466
		}
		local var_599_1 = manager.audio:GetLocalizationFlag()

		if var_599_0[var_599_1] ~= nil then
			arg_599_1.duration_ = var_599_0[var_599_1]
		end

		SetActive(arg_599_1.tipsGo_, false)

		function arg_599_1.onSingleLineFinish_()
			arg_599_1.onSingleLineUpdate_ = nil
			arg_599_1.onSingleLineFinish_ = nil
			arg_599_1.state_ = "waiting"
		end

		function arg_599_1.playNext_(arg_601_0)
			if arg_601_0 == 1 then
				arg_599_0:Play115281143(arg_599_1)
			end
		end

		function arg_599_1.onSingleLineUpdate_(arg_602_0)
			local var_602_0 = 0
			local var_602_1 = 0.925

			if var_602_0 < arg_599_1.time_ and arg_599_1.time_ <= var_602_0 + arg_602_0 then
				arg_599_1.talkMaxDuration = 0
				arg_599_1.dialogCg_.alpha = 1

				arg_599_1.dialog_:SetActive(true)
				SetActive(arg_599_1.leftNameGo_, true)

				local var_602_2 = arg_599_1:FormatText(StoryNameCfg[94].name)

				arg_599_1.leftNameTxt_.text = var_602_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_599_1.leftNameTxt_.transform)

				arg_599_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_599_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_599_1:RecordName(arg_599_1.leftNameTxt_.text)
				SetActive(arg_599_1.iconTrs_.gameObject, false)
				arg_599_1.callingController_:SetSelectedState("normal")

				local var_602_3 = arg_599_1:GetWordFromCfg(115281142)
				local var_602_4 = arg_599_1:FormatText(var_602_3.content)

				arg_599_1.text_.text = var_602_4

				LuaForUtil.ClearLinePrefixSymbol(arg_599_1.text_)

				local var_602_5 = 37
				local var_602_6 = utf8.len(var_602_4)
				local var_602_7 = var_602_5 <= 0 and var_602_1 or var_602_1 * (var_602_6 / var_602_5)

				if var_602_7 > 0 and var_602_1 < var_602_7 then
					arg_599_1.talkMaxDuration = var_602_7

					if var_602_7 + var_602_0 > arg_599_1.duration_ then
						arg_599_1.duration_ = var_602_7 + var_602_0
					end
				end

				arg_599_1.text_.text = var_602_4
				arg_599_1.typewritter.percent = 0

				arg_599_1.typewritter:SetDirty()
				arg_599_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115281", "115281142", "story_v_out_115281.awb") ~= 0 then
					local var_602_8 = manager.audio:GetVoiceLength("story_v_out_115281", "115281142", "story_v_out_115281.awb") / 1000

					if var_602_8 + var_602_0 > arg_599_1.duration_ then
						arg_599_1.duration_ = var_602_8 + var_602_0
					end

					if var_602_3.prefab_name ~= "" and arg_599_1.actors_[var_602_3.prefab_name] ~= nil then
						local var_602_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_599_1.actors_[var_602_3.prefab_name].transform, "story_v_out_115281", "115281142", "story_v_out_115281.awb")

						arg_599_1:RecordAudio("115281142", var_602_9)
						arg_599_1:RecordAudio("115281142", var_602_9)
					else
						arg_599_1:AudioAction("play", "voice", "story_v_out_115281", "115281142", "story_v_out_115281.awb")
					end

					arg_599_1:RecordHistoryTalkVoice("story_v_out_115281", "115281142", "story_v_out_115281.awb")
				end

				arg_599_1:RecordContent(arg_599_1.text_.text)
			end

			local var_602_10 = math.max(var_602_1, arg_599_1.talkMaxDuration)

			if var_602_0 <= arg_599_1.time_ and arg_599_1.time_ < var_602_0 + var_602_10 then
				arg_599_1.typewritter.percent = (arg_599_1.time_ - var_602_0) / var_602_10

				arg_599_1.typewritter:SetDirty()
			end

			if arg_599_1.time_ >= var_602_0 + var_602_10 and arg_599_1.time_ < var_602_0 + var_602_10 + arg_602_0 then
				arg_599_1.typewritter.percent = 1

				arg_599_1.typewritter:SetDirty()
				arg_599_1:ShowNextGo(true)
			end
		end

		arg_599_1.nodeConfigList_ = {}

		arg_599_1:InitPlayNodeList()
	end,
	Play115281143 = function(arg_603_0, arg_603_1)
		arg_603_1.time_ = 0
		arg_603_1.frameCnt_ = 0
		arg_603_1.state_ = "playing"
		arg_603_1.curTalkId_ = 115281143
		arg_603_1.duration_ = 14.3

		local var_603_0 = {
			ja = 14.3,
			ko = 7.766,
			zh = 8.7,
			en = 9.866
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
				arg_603_0:Play115281144(arg_603_1)
			end
		end

		function arg_603_1.onSingleLineUpdate_(arg_606_0)
			local var_606_0 = 0
			local var_606_1 = 0.95

			if var_606_0 < arg_603_1.time_ and arg_603_1.time_ <= var_606_0 + arg_606_0 then
				arg_603_1.talkMaxDuration = 0
				arg_603_1.dialogCg_.alpha = 1

				arg_603_1.dialog_:SetActive(true)
				SetActive(arg_603_1.leftNameGo_, true)

				local var_606_2 = arg_603_1:FormatText(StoryNameCfg[94].name)

				arg_603_1.leftNameTxt_.text = var_606_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_603_1.leftNameTxt_.transform)

				arg_603_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_603_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_603_1:RecordName(arg_603_1.leftNameTxt_.text)
				SetActive(arg_603_1.iconTrs_.gameObject, false)
				arg_603_1.callingController_:SetSelectedState("normal")

				local var_606_3 = arg_603_1:GetWordFromCfg(115281143)
				local var_606_4 = arg_603_1:FormatText(var_606_3.content)

				arg_603_1.text_.text = var_606_4

				LuaForUtil.ClearLinePrefixSymbol(arg_603_1.text_)

				local var_606_5 = 38
				local var_606_6 = utf8.len(var_606_4)
				local var_606_7 = var_606_5 <= 0 and var_606_1 or var_606_1 * (var_606_6 / var_606_5)

				if var_606_7 > 0 and var_606_1 < var_606_7 then
					arg_603_1.talkMaxDuration = var_606_7

					if var_606_7 + var_606_0 > arg_603_1.duration_ then
						arg_603_1.duration_ = var_606_7 + var_606_0
					end
				end

				arg_603_1.text_.text = var_606_4
				arg_603_1.typewritter.percent = 0

				arg_603_1.typewritter:SetDirty()
				arg_603_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115281", "115281143", "story_v_out_115281.awb") ~= 0 then
					local var_606_8 = manager.audio:GetVoiceLength("story_v_out_115281", "115281143", "story_v_out_115281.awb") / 1000

					if var_606_8 + var_606_0 > arg_603_1.duration_ then
						arg_603_1.duration_ = var_606_8 + var_606_0
					end

					if var_606_3.prefab_name ~= "" and arg_603_1.actors_[var_606_3.prefab_name] ~= nil then
						local var_606_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_603_1.actors_[var_606_3.prefab_name].transform, "story_v_out_115281", "115281143", "story_v_out_115281.awb")

						arg_603_1:RecordAudio("115281143", var_606_9)
						arg_603_1:RecordAudio("115281143", var_606_9)
					else
						arg_603_1:AudioAction("play", "voice", "story_v_out_115281", "115281143", "story_v_out_115281.awb")
					end

					arg_603_1:RecordHistoryTalkVoice("story_v_out_115281", "115281143", "story_v_out_115281.awb")
				end

				arg_603_1:RecordContent(arg_603_1.text_.text)
			end

			local var_606_10 = math.max(var_606_1, arg_603_1.talkMaxDuration)

			if var_606_0 <= arg_603_1.time_ and arg_603_1.time_ < var_606_0 + var_606_10 then
				arg_603_1.typewritter.percent = (arg_603_1.time_ - var_606_0) / var_606_10

				arg_603_1.typewritter:SetDirty()
			end

			if arg_603_1.time_ >= var_606_0 + var_606_10 and arg_603_1.time_ < var_606_0 + var_606_10 + arg_606_0 then
				arg_603_1.typewritter.percent = 1

				arg_603_1.typewritter:SetDirty()
				arg_603_1:ShowNextGo(true)
			end
		end

		arg_603_1.nodeConfigList_ = {}

		arg_603_1:InitPlayNodeList()
	end,
	Play115281144 = function(arg_607_0, arg_607_1)
		arg_607_1.time_ = 0
		arg_607_1.frameCnt_ = 0
		arg_607_1.state_ = "playing"
		arg_607_1.curTalkId_ = 115281144
		arg_607_1.duration_ = 5

		SetActive(arg_607_1.tipsGo_, false)

		function arg_607_1.onSingleLineFinish_()
			arg_607_1.onSingleLineUpdate_ = nil
			arg_607_1.onSingleLineFinish_ = nil
			arg_607_1.state_ = "waiting"
		end

		function arg_607_1.playNext_(arg_609_0)
			if arg_609_0 == 1 then
				arg_607_0:Play115281145(arg_607_1)
			end
		end

		function arg_607_1.onSingleLineUpdate_(arg_610_0)
			local var_610_0 = 0
			local var_610_1 = 0.75

			if var_610_0 < arg_607_1.time_ and arg_607_1.time_ <= var_610_0 + arg_610_0 then
				arg_607_1.talkMaxDuration = 0
				arg_607_1.dialogCg_.alpha = 1

				arg_607_1.dialog_:SetActive(true)
				SetActive(arg_607_1.leftNameGo_, false)

				arg_607_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_607_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_607_1:RecordName(arg_607_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_607_1.iconTrs_.gameObject, false)
				arg_607_1.callingController_:SetSelectedState("normal")

				local var_610_2 = arg_607_1:GetWordFromCfg(115281144)
				local var_610_3 = arg_607_1:FormatText(var_610_2.content)

				arg_607_1.text_.text = var_610_3

				LuaForUtil.ClearLinePrefixSymbol(arg_607_1.text_)

				local var_610_4 = 30
				local var_610_5 = utf8.len(var_610_3)
				local var_610_6 = var_610_4 <= 0 and var_610_1 or var_610_1 * (var_610_5 / var_610_4)

				if var_610_6 > 0 and var_610_1 < var_610_6 then
					arg_607_1.talkMaxDuration = var_610_6

					if var_610_6 + var_610_0 > arg_607_1.duration_ then
						arg_607_1.duration_ = var_610_6 + var_610_0
					end
				end

				arg_607_1.text_.text = var_610_3
				arg_607_1.typewritter.percent = 0

				arg_607_1.typewritter:SetDirty()
				arg_607_1:ShowNextGo(false)
				arg_607_1:RecordContent(arg_607_1.text_.text)
			end

			local var_610_7 = math.max(var_610_1, arg_607_1.talkMaxDuration)

			if var_610_0 <= arg_607_1.time_ and arg_607_1.time_ < var_610_0 + var_610_7 then
				arg_607_1.typewritter.percent = (arg_607_1.time_ - var_610_0) / var_610_7

				arg_607_1.typewritter:SetDirty()
			end

			if arg_607_1.time_ >= var_610_0 + var_610_7 and arg_607_1.time_ < var_610_0 + var_610_7 + arg_610_0 then
				arg_607_1.typewritter.percent = 1

				arg_607_1.typewritter:SetDirty()
				arg_607_1:ShowNextGo(true)
			end
		end

		arg_607_1.nodeConfigList_ = {}

		arg_607_1:InitPlayNodeList()
	end,
	Play115281145 = function(arg_611_0, arg_611_1)
		arg_611_1.time_ = 0
		arg_611_1.frameCnt_ = 0
		arg_611_1.state_ = "playing"
		arg_611_1.curTalkId_ = 115281145
		arg_611_1.duration_ = 8.1

		local var_611_0 = {
			ja = 8.1,
			ko = 6.033,
			zh = 6.266,
			en = 5.1
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
				arg_611_0:Play115281146(arg_611_1)
			end
		end

		function arg_611_1.onSingleLineUpdate_(arg_614_0)
			local var_614_0 = 0
			local var_614_1 = 0.625

			if var_614_0 < arg_611_1.time_ and arg_611_1.time_ <= var_614_0 + arg_614_0 then
				arg_611_1.talkMaxDuration = 0
				arg_611_1.dialogCg_.alpha = 1

				arg_611_1.dialog_:SetActive(true)
				SetActive(arg_611_1.leftNameGo_, true)

				local var_614_2 = arg_611_1:FormatText(StoryNameCfg[94].name)

				arg_611_1.leftNameTxt_.text = var_614_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_611_1.leftNameTxt_.transform)

				arg_611_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_611_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_611_1:RecordName(arg_611_1.leftNameTxt_.text)
				SetActive(arg_611_1.iconTrs_.gameObject, false)
				arg_611_1.callingController_:SetSelectedState("normal")

				local var_614_3 = arg_611_1:GetWordFromCfg(115281145)
				local var_614_4 = arg_611_1:FormatText(var_614_3.content)

				arg_611_1.text_.text = var_614_4

				LuaForUtil.ClearLinePrefixSymbol(arg_611_1.text_)

				local var_614_5 = 25
				local var_614_6 = utf8.len(var_614_4)
				local var_614_7 = var_614_5 <= 0 and var_614_1 or var_614_1 * (var_614_6 / var_614_5)

				if var_614_7 > 0 and var_614_1 < var_614_7 then
					arg_611_1.talkMaxDuration = var_614_7

					if var_614_7 + var_614_0 > arg_611_1.duration_ then
						arg_611_1.duration_ = var_614_7 + var_614_0
					end
				end

				arg_611_1.text_.text = var_614_4
				arg_611_1.typewritter.percent = 0

				arg_611_1.typewritter:SetDirty()
				arg_611_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115281", "115281145", "story_v_out_115281.awb") ~= 0 then
					local var_614_8 = manager.audio:GetVoiceLength("story_v_out_115281", "115281145", "story_v_out_115281.awb") / 1000

					if var_614_8 + var_614_0 > arg_611_1.duration_ then
						arg_611_1.duration_ = var_614_8 + var_614_0
					end

					if var_614_3.prefab_name ~= "" and arg_611_1.actors_[var_614_3.prefab_name] ~= nil then
						local var_614_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_611_1.actors_[var_614_3.prefab_name].transform, "story_v_out_115281", "115281145", "story_v_out_115281.awb")

						arg_611_1:RecordAudio("115281145", var_614_9)
						arg_611_1:RecordAudio("115281145", var_614_9)
					else
						arg_611_1:AudioAction("play", "voice", "story_v_out_115281", "115281145", "story_v_out_115281.awb")
					end

					arg_611_1:RecordHistoryTalkVoice("story_v_out_115281", "115281145", "story_v_out_115281.awb")
				end

				arg_611_1:RecordContent(arg_611_1.text_.text)
			end

			local var_614_10 = math.max(var_614_1, arg_611_1.talkMaxDuration)

			if var_614_0 <= arg_611_1.time_ and arg_611_1.time_ < var_614_0 + var_614_10 then
				arg_611_1.typewritter.percent = (arg_611_1.time_ - var_614_0) / var_614_10

				arg_611_1.typewritter:SetDirty()
			end

			if arg_611_1.time_ >= var_614_0 + var_614_10 and arg_611_1.time_ < var_614_0 + var_614_10 + arg_614_0 then
				arg_611_1.typewritter.percent = 1

				arg_611_1.typewritter:SetDirty()
				arg_611_1:ShowNextGo(true)
			end
		end

		arg_611_1.nodeConfigList_ = {}

		arg_611_1:InitPlayNodeList()
	end,
	Play115281146 = function(arg_615_0, arg_615_1)
		arg_615_1.time_ = 0
		arg_615_1.frameCnt_ = 0
		arg_615_1.state_ = "playing"
		arg_615_1.curTalkId_ = 115281146
		arg_615_1.duration_ = 13.83

		local var_615_0 = {
			ja = 13.833,
			ko = 5.333,
			zh = 7.6,
			en = 5.8
		}
		local var_615_1 = manager.audio:GetLocalizationFlag()

		if var_615_0[var_615_1] ~= nil then
			arg_615_1.duration_ = var_615_0[var_615_1]
		end

		SetActive(arg_615_1.tipsGo_, false)

		function arg_615_1.onSingleLineFinish_()
			arg_615_1.onSingleLineUpdate_ = nil
			arg_615_1.onSingleLineFinish_ = nil
			arg_615_1.state_ = "waiting"
		end

		function arg_615_1.playNext_(arg_617_0)
			if arg_617_0 == 1 then
				arg_615_0:Play115281147(arg_615_1)
			end
		end

		function arg_615_1.onSingleLineUpdate_(arg_618_0)
			local var_618_0 = 0
			local var_618_1 = 0.6

			if var_618_0 < arg_615_1.time_ and arg_615_1.time_ <= var_618_0 + arg_618_0 then
				arg_615_1.talkMaxDuration = 0
				arg_615_1.dialogCg_.alpha = 1

				arg_615_1.dialog_:SetActive(true)
				SetActive(arg_615_1.leftNameGo_, true)

				local var_618_2 = arg_615_1:FormatText(StoryNameCfg[94].name)

				arg_615_1.leftNameTxt_.text = var_618_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_615_1.leftNameTxt_.transform)

				arg_615_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_615_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_615_1:RecordName(arg_615_1.leftNameTxt_.text)
				SetActive(arg_615_1.iconTrs_.gameObject, false)
				arg_615_1.callingController_:SetSelectedState("normal")

				local var_618_3 = arg_615_1:GetWordFromCfg(115281146)
				local var_618_4 = arg_615_1:FormatText(var_618_3.content)

				arg_615_1.text_.text = var_618_4

				LuaForUtil.ClearLinePrefixSymbol(arg_615_1.text_)

				local var_618_5 = 24
				local var_618_6 = utf8.len(var_618_4)
				local var_618_7 = var_618_5 <= 0 and var_618_1 or var_618_1 * (var_618_6 / var_618_5)

				if var_618_7 > 0 and var_618_1 < var_618_7 then
					arg_615_1.talkMaxDuration = var_618_7

					if var_618_7 + var_618_0 > arg_615_1.duration_ then
						arg_615_1.duration_ = var_618_7 + var_618_0
					end
				end

				arg_615_1.text_.text = var_618_4
				arg_615_1.typewritter.percent = 0

				arg_615_1.typewritter:SetDirty()
				arg_615_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115281", "115281146", "story_v_out_115281.awb") ~= 0 then
					local var_618_8 = manager.audio:GetVoiceLength("story_v_out_115281", "115281146", "story_v_out_115281.awb") / 1000

					if var_618_8 + var_618_0 > arg_615_1.duration_ then
						arg_615_1.duration_ = var_618_8 + var_618_0
					end

					if var_618_3.prefab_name ~= "" and arg_615_1.actors_[var_618_3.prefab_name] ~= nil then
						local var_618_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_615_1.actors_[var_618_3.prefab_name].transform, "story_v_out_115281", "115281146", "story_v_out_115281.awb")

						arg_615_1:RecordAudio("115281146", var_618_9)
						arg_615_1:RecordAudio("115281146", var_618_9)
					else
						arg_615_1:AudioAction("play", "voice", "story_v_out_115281", "115281146", "story_v_out_115281.awb")
					end

					arg_615_1:RecordHistoryTalkVoice("story_v_out_115281", "115281146", "story_v_out_115281.awb")
				end

				arg_615_1:RecordContent(arg_615_1.text_.text)
			end

			local var_618_10 = math.max(var_618_1, arg_615_1.talkMaxDuration)

			if var_618_0 <= arg_615_1.time_ and arg_615_1.time_ < var_618_0 + var_618_10 then
				arg_615_1.typewritter.percent = (arg_615_1.time_ - var_618_0) / var_618_10

				arg_615_1.typewritter:SetDirty()
			end

			if arg_615_1.time_ >= var_618_0 + var_618_10 and arg_615_1.time_ < var_618_0 + var_618_10 + arg_618_0 then
				arg_615_1.typewritter.percent = 1

				arg_615_1.typewritter:SetDirty()
				arg_615_1:ShowNextGo(true)
			end
		end

		arg_615_1.nodeConfigList_ = {}

		arg_615_1:InitPlayNodeList()
	end,
	Play115281147 = function(arg_619_0, arg_619_1)
		arg_619_1.time_ = 0
		arg_619_1.frameCnt_ = 0
		arg_619_1.state_ = "playing"
		arg_619_1.curTalkId_ = 115281147
		arg_619_1.duration_ = 5

		SetActive(arg_619_1.tipsGo_, false)

		function arg_619_1.onSingleLineFinish_()
			arg_619_1.onSingleLineUpdate_ = nil
			arg_619_1.onSingleLineFinish_ = nil
			arg_619_1.state_ = "waiting"
		end

		function arg_619_1.playNext_(arg_621_0)
			if arg_621_0 == 1 then
				arg_619_0:Play115281148(arg_619_1)
			end
		end

		function arg_619_1.onSingleLineUpdate_(arg_622_0)
			local var_622_0 = 0

			if var_622_0 < arg_619_1.time_ and arg_619_1.time_ <= var_622_0 + arg_622_0 then
				local var_622_1 = manager.ui.mainCamera.transform.localPosition
				local var_622_2 = Vector3.New(0, 0, 10) + Vector3.New(var_622_1.x, var_622_1.y, 0)
				local var_622_3 = arg_619_1.bgs_.RO0501

				var_622_3.transform.localPosition = var_622_2
				var_622_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_622_4 = var_622_3:GetComponent("SpriteRenderer")

				if var_622_4 and var_622_4.sprite then
					local var_622_5 = (var_622_3.transform.localPosition - var_622_1).z
					local var_622_6 = manager.ui.mainCameraCom_
					local var_622_7 = 2 * var_622_5 * Mathf.Tan(var_622_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_622_8 = var_622_7 * var_622_6.aspect
					local var_622_9 = var_622_4.sprite.bounds.size.x
					local var_622_10 = var_622_4.sprite.bounds.size.y
					local var_622_11 = var_622_8 / var_622_9
					local var_622_12 = var_622_7 / var_622_10
					local var_622_13 = var_622_12 < var_622_11 and var_622_11 or var_622_12

					var_622_3.transform.localScale = Vector3.New(var_622_13, var_622_13, 0)
				end

				for iter_622_0, iter_622_1 in pairs(arg_619_1.bgs_) do
					if iter_622_0 ~= "RO0501" then
						iter_622_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_622_14 = 0

			if var_622_14 < arg_619_1.time_ and arg_619_1.time_ <= var_622_14 + arg_622_0 then
				arg_619_1.mask_.enabled = true
				arg_619_1.mask_.raycastTarget = true

				arg_619_1:SetGaussion(false)
			end

			local var_622_15 = 0.5

			if var_622_14 <= arg_619_1.time_ and arg_619_1.time_ < var_622_14 + var_622_15 then
				local var_622_16 = (arg_619_1.time_ - var_622_14) / var_622_15
				local var_622_17 = Color.New(1, 1, 1)

				var_622_17.a = Mathf.Lerp(1, 0, var_622_16)
				arg_619_1.mask_.color = var_622_17
			end

			if arg_619_1.time_ >= var_622_14 + var_622_15 and arg_619_1.time_ < var_622_14 + var_622_15 + arg_622_0 then
				local var_622_18 = Color.New(1, 1, 1)
				local var_622_19 = 0

				arg_619_1.mask_.enabled = false
				var_622_18.a = var_622_19
				arg_619_1.mask_.color = var_622_18
			end

			local var_622_20 = 0
			local var_622_21 = 0.975

			if var_622_20 < arg_619_1.time_ and arg_619_1.time_ <= var_622_20 + arg_622_0 then
				arg_619_1.talkMaxDuration = 0
				arg_619_1.dialogCg_.alpha = 1

				arg_619_1.dialog_:SetActive(true)
				SetActive(arg_619_1.leftNameGo_, false)

				arg_619_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_619_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_619_1:RecordName(arg_619_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_619_1.iconTrs_.gameObject, false)
				arg_619_1.callingController_:SetSelectedState("normal")

				local var_622_22 = arg_619_1:GetWordFromCfg(115281147)
				local var_622_23 = arg_619_1:FormatText(var_622_22.content)

				arg_619_1.text_.text = var_622_23

				LuaForUtil.ClearLinePrefixSymbol(arg_619_1.text_)

				local var_622_24 = 39
				local var_622_25 = utf8.len(var_622_23)
				local var_622_26 = var_622_24 <= 0 and var_622_21 or var_622_21 * (var_622_25 / var_622_24)

				if var_622_26 > 0 and var_622_21 < var_622_26 then
					arg_619_1.talkMaxDuration = var_622_26

					if var_622_26 + var_622_20 > arg_619_1.duration_ then
						arg_619_1.duration_ = var_622_26 + var_622_20
					end
				end

				arg_619_1.text_.text = var_622_23
				arg_619_1.typewritter.percent = 0

				arg_619_1.typewritter:SetDirty()
				arg_619_1:ShowNextGo(false)
				arg_619_1:RecordContent(arg_619_1.text_.text)
			end

			local var_622_27 = math.max(var_622_21, arg_619_1.talkMaxDuration)

			if var_622_20 <= arg_619_1.time_ and arg_619_1.time_ < var_622_20 + var_622_27 then
				arg_619_1.typewritter.percent = (arg_619_1.time_ - var_622_20) / var_622_27

				arg_619_1.typewritter:SetDirty()
			end

			if arg_619_1.time_ >= var_622_20 + var_622_27 and arg_619_1.time_ < var_622_20 + var_622_27 + arg_622_0 then
				arg_619_1.typewritter.percent = 1

				arg_619_1.typewritter:SetDirty()
				arg_619_1:ShowNextGo(true)
			end
		end

		arg_619_1.nodeConfigList_ = {}

		arg_619_1:InitPlayNodeList()
	end,
	Play115281148 = function(arg_623_0, arg_623_1)
		arg_623_1.time_ = 0
		arg_623_1.frameCnt_ = 0
		arg_623_1.state_ = "playing"
		arg_623_1.curTalkId_ = 115281148
		arg_623_1.duration_ = 3.77

		local var_623_0 = {
			ja = 2.766,
			ko = 2.1,
			zh = 3.766,
			en = 2.233
		}
		local var_623_1 = manager.audio:GetLocalizationFlag()

		if var_623_0[var_623_1] ~= nil then
			arg_623_1.duration_ = var_623_0[var_623_1]
		end

		SetActive(arg_623_1.tipsGo_, false)

		function arg_623_1.onSingleLineFinish_()
			arg_623_1.onSingleLineUpdate_ = nil
			arg_623_1.onSingleLineFinish_ = nil
			arg_623_1.state_ = "waiting"
		end

		function arg_623_1.playNext_(arg_625_0)
			if arg_625_0 == 1 then
				arg_623_0:Play115281149(arg_623_1)
			end
		end

		function arg_623_1.onSingleLineUpdate_(arg_626_0)
			local var_626_0 = 0
			local var_626_1 = 0.2

			if var_626_0 < arg_623_1.time_ and arg_623_1.time_ <= var_626_0 + arg_626_0 then
				arg_623_1.talkMaxDuration = 0
				arg_623_1.dialogCg_.alpha = 1

				arg_623_1.dialog_:SetActive(true)
				SetActive(arg_623_1.leftNameGo_, true)

				local var_626_2 = arg_623_1:FormatText(StoryNameCfg[94].name)

				arg_623_1.leftNameTxt_.text = var_626_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_623_1.leftNameTxt_.transform)

				arg_623_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_623_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_623_1:RecordName(arg_623_1.leftNameTxt_.text)
				SetActive(arg_623_1.iconTrs_.gameObject, false)
				arg_623_1.callingController_:SetSelectedState("normal")

				local var_626_3 = arg_623_1:GetWordFromCfg(115281148)
				local var_626_4 = arg_623_1:FormatText(var_626_3.content)

				arg_623_1.text_.text = var_626_4

				LuaForUtil.ClearLinePrefixSymbol(arg_623_1.text_)

				local var_626_5 = 8
				local var_626_6 = utf8.len(var_626_4)
				local var_626_7 = var_626_5 <= 0 and var_626_1 or var_626_1 * (var_626_6 / var_626_5)

				if var_626_7 > 0 and var_626_1 < var_626_7 then
					arg_623_1.talkMaxDuration = var_626_7

					if var_626_7 + var_626_0 > arg_623_1.duration_ then
						arg_623_1.duration_ = var_626_7 + var_626_0
					end
				end

				arg_623_1.text_.text = var_626_4
				arg_623_1.typewritter.percent = 0

				arg_623_1.typewritter:SetDirty()
				arg_623_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115281", "115281148", "story_v_out_115281.awb") ~= 0 then
					local var_626_8 = manager.audio:GetVoiceLength("story_v_out_115281", "115281148", "story_v_out_115281.awb") / 1000

					if var_626_8 + var_626_0 > arg_623_1.duration_ then
						arg_623_1.duration_ = var_626_8 + var_626_0
					end

					if var_626_3.prefab_name ~= "" and arg_623_1.actors_[var_626_3.prefab_name] ~= nil then
						local var_626_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_623_1.actors_[var_626_3.prefab_name].transform, "story_v_out_115281", "115281148", "story_v_out_115281.awb")

						arg_623_1:RecordAudio("115281148", var_626_9)
						arg_623_1:RecordAudio("115281148", var_626_9)
					else
						arg_623_1:AudioAction("play", "voice", "story_v_out_115281", "115281148", "story_v_out_115281.awb")
					end

					arg_623_1:RecordHistoryTalkVoice("story_v_out_115281", "115281148", "story_v_out_115281.awb")
				end

				arg_623_1:RecordContent(arg_623_1.text_.text)
			end

			local var_626_10 = math.max(var_626_1, arg_623_1.talkMaxDuration)

			if var_626_0 <= arg_623_1.time_ and arg_623_1.time_ < var_626_0 + var_626_10 then
				arg_623_1.typewritter.percent = (arg_623_1.time_ - var_626_0) / var_626_10

				arg_623_1.typewritter:SetDirty()
			end

			if arg_623_1.time_ >= var_626_0 + var_626_10 and arg_623_1.time_ < var_626_0 + var_626_10 + arg_626_0 then
				arg_623_1.typewritter.percent = 1

				arg_623_1.typewritter:SetDirty()
				arg_623_1:ShowNextGo(true)
			end
		end

		arg_623_1.nodeConfigList_ = {}

		arg_623_1:InitPlayNodeList()
	end,
	Play115281149 = function(arg_627_0, arg_627_1)
		arg_627_1.time_ = 0
		arg_627_1.frameCnt_ = 0
		arg_627_1.state_ = "playing"
		arg_627_1.curTalkId_ = 115281149
		arg_627_1.duration_ = 6

		local var_627_0 = {
			ja = 5.766,
			ko = 5.266,
			zh = 6,
			en = 5.333
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
				arg_627_0:Play115281150(arg_627_1)
			end
		end

		function arg_627_1.onSingleLineUpdate_(arg_630_0)
			local var_630_0 = 0
			local var_630_1 = 0.575

			if var_630_0 < arg_627_1.time_ and arg_627_1.time_ <= var_630_0 + arg_630_0 then
				arg_627_1.talkMaxDuration = 0
				arg_627_1.dialogCg_.alpha = 1

				arg_627_1.dialog_:SetActive(true)
				SetActive(arg_627_1.leftNameGo_, true)

				local var_630_2 = arg_627_1:FormatText(StoryNameCfg[94].name)

				arg_627_1.leftNameTxt_.text = var_630_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_627_1.leftNameTxt_.transform)

				arg_627_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_627_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_627_1:RecordName(arg_627_1.leftNameTxt_.text)
				SetActive(arg_627_1.iconTrs_.gameObject, false)
				arg_627_1.callingController_:SetSelectedState("normal")

				local var_630_3 = arg_627_1:GetWordFromCfg(115281149)
				local var_630_4 = arg_627_1:FormatText(var_630_3.content)

				arg_627_1.text_.text = var_630_4

				LuaForUtil.ClearLinePrefixSymbol(arg_627_1.text_)

				local var_630_5 = 23
				local var_630_6 = utf8.len(var_630_4)
				local var_630_7 = var_630_5 <= 0 and var_630_1 or var_630_1 * (var_630_6 / var_630_5)

				if var_630_7 > 0 and var_630_1 < var_630_7 then
					arg_627_1.talkMaxDuration = var_630_7

					if var_630_7 + var_630_0 > arg_627_1.duration_ then
						arg_627_1.duration_ = var_630_7 + var_630_0
					end
				end

				arg_627_1.text_.text = var_630_4
				arg_627_1.typewritter.percent = 0

				arg_627_1.typewritter:SetDirty()
				arg_627_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115281", "115281149", "story_v_out_115281.awb") ~= 0 then
					local var_630_8 = manager.audio:GetVoiceLength("story_v_out_115281", "115281149", "story_v_out_115281.awb") / 1000

					if var_630_8 + var_630_0 > arg_627_1.duration_ then
						arg_627_1.duration_ = var_630_8 + var_630_0
					end

					if var_630_3.prefab_name ~= "" and arg_627_1.actors_[var_630_3.prefab_name] ~= nil then
						local var_630_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_627_1.actors_[var_630_3.prefab_name].transform, "story_v_out_115281", "115281149", "story_v_out_115281.awb")

						arg_627_1:RecordAudio("115281149", var_630_9)
						arg_627_1:RecordAudio("115281149", var_630_9)
					else
						arg_627_1:AudioAction("play", "voice", "story_v_out_115281", "115281149", "story_v_out_115281.awb")
					end

					arg_627_1:RecordHistoryTalkVoice("story_v_out_115281", "115281149", "story_v_out_115281.awb")
				end

				arg_627_1:RecordContent(arg_627_1.text_.text)
			end

			local var_630_10 = math.max(var_630_1, arg_627_1.talkMaxDuration)

			if var_630_0 <= arg_627_1.time_ and arg_627_1.time_ < var_630_0 + var_630_10 then
				arg_627_1.typewritter.percent = (arg_627_1.time_ - var_630_0) / var_630_10

				arg_627_1.typewritter:SetDirty()
			end

			if arg_627_1.time_ >= var_630_0 + var_630_10 and arg_627_1.time_ < var_630_0 + var_630_10 + arg_630_0 then
				arg_627_1.typewritter.percent = 1

				arg_627_1.typewritter:SetDirty()
				arg_627_1:ShowNextGo(true)
			end
		end

		arg_627_1.nodeConfigList_ = {}

		arg_627_1:InitPlayNodeList()
	end,
	Play115281150 = function(arg_631_0, arg_631_1)
		arg_631_1.time_ = 0
		arg_631_1.frameCnt_ = 0
		arg_631_1.state_ = "playing"
		arg_631_1.curTalkId_ = 115281150
		arg_631_1.duration_ = 5

		SetActive(arg_631_1.tipsGo_, false)

		function arg_631_1.onSingleLineFinish_()
			arg_631_1.onSingleLineUpdate_ = nil
			arg_631_1.onSingleLineFinish_ = nil
			arg_631_1.state_ = "waiting"
		end

		function arg_631_1.playNext_(arg_633_0)
			if arg_633_0 == 1 then
				arg_631_0:Play115281151(arg_631_1)
			end
		end

		function arg_631_1.onSingleLineUpdate_(arg_634_0)
			local var_634_0 = 0
			local var_634_1 = 0.85

			if var_634_0 < arg_631_1.time_ and arg_631_1.time_ <= var_634_0 + arg_634_0 then
				arg_631_1.talkMaxDuration = 0
				arg_631_1.dialogCg_.alpha = 1

				arg_631_1.dialog_:SetActive(true)
				SetActive(arg_631_1.leftNameGo_, false)

				arg_631_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_631_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_631_1:RecordName(arg_631_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_631_1.iconTrs_.gameObject, false)
				arg_631_1.callingController_:SetSelectedState("normal")

				local var_634_2 = arg_631_1:GetWordFromCfg(115281150)
				local var_634_3 = arg_631_1:FormatText(var_634_2.content)

				arg_631_1.text_.text = var_634_3

				LuaForUtil.ClearLinePrefixSymbol(arg_631_1.text_)

				local var_634_4 = 34
				local var_634_5 = utf8.len(var_634_3)
				local var_634_6 = var_634_4 <= 0 and var_634_1 or var_634_1 * (var_634_5 / var_634_4)

				if var_634_6 > 0 and var_634_1 < var_634_6 then
					arg_631_1.talkMaxDuration = var_634_6

					if var_634_6 + var_634_0 > arg_631_1.duration_ then
						arg_631_1.duration_ = var_634_6 + var_634_0
					end
				end

				arg_631_1.text_.text = var_634_3
				arg_631_1.typewritter.percent = 0

				arg_631_1.typewritter:SetDirty()
				arg_631_1:ShowNextGo(false)
				arg_631_1:RecordContent(arg_631_1.text_.text)
			end

			local var_634_7 = math.max(var_634_1, arg_631_1.talkMaxDuration)

			if var_634_0 <= arg_631_1.time_ and arg_631_1.time_ < var_634_0 + var_634_7 then
				arg_631_1.typewritter.percent = (arg_631_1.time_ - var_634_0) / var_634_7

				arg_631_1.typewritter:SetDirty()
			end

			if arg_631_1.time_ >= var_634_0 + var_634_7 and arg_631_1.time_ < var_634_0 + var_634_7 + arg_634_0 then
				arg_631_1.typewritter.percent = 1

				arg_631_1.typewritter:SetDirty()
				arg_631_1:ShowNextGo(true)
			end
		end

		arg_631_1.nodeConfigList_ = {}

		arg_631_1:InitPlayNodeList()
	end,
	Play115281151 = function(arg_635_0, arg_635_1)
		arg_635_1.time_ = 0
		arg_635_1.frameCnt_ = 0
		arg_635_1.state_ = "playing"
		arg_635_1.curTalkId_ = 115281151
		arg_635_1.duration_ = 5

		SetActive(arg_635_1.tipsGo_, false)

		function arg_635_1.onSingleLineFinish_()
			arg_635_1.onSingleLineUpdate_ = nil
			arg_635_1.onSingleLineFinish_ = nil
			arg_635_1.state_ = "waiting"
		end

		function arg_635_1.playNext_(arg_637_0)
			if arg_637_0 == 1 then
				arg_635_0:Play115281152(arg_635_1)
			end
		end

		function arg_635_1.onSingleLineUpdate_(arg_638_0)
			local var_638_0 = 0
			local var_638_1 = 1.125

			if var_638_0 < arg_635_1.time_ and arg_635_1.time_ <= var_638_0 + arg_638_0 then
				arg_635_1.talkMaxDuration = 0
				arg_635_1.dialogCg_.alpha = 1

				arg_635_1.dialog_:SetActive(true)
				SetActive(arg_635_1.leftNameGo_, false)

				arg_635_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_635_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_635_1:RecordName(arg_635_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_635_1.iconTrs_.gameObject, false)
				arg_635_1.callingController_:SetSelectedState("normal")

				local var_638_2 = arg_635_1:GetWordFromCfg(115281151)
				local var_638_3 = arg_635_1:FormatText(var_638_2.content)

				arg_635_1.text_.text = var_638_3

				LuaForUtil.ClearLinePrefixSymbol(arg_635_1.text_)

				local var_638_4 = 45
				local var_638_5 = utf8.len(var_638_3)
				local var_638_6 = var_638_4 <= 0 and var_638_1 or var_638_1 * (var_638_5 / var_638_4)

				if var_638_6 > 0 and var_638_1 < var_638_6 then
					arg_635_1.talkMaxDuration = var_638_6

					if var_638_6 + var_638_0 > arg_635_1.duration_ then
						arg_635_1.duration_ = var_638_6 + var_638_0
					end
				end

				arg_635_1.text_.text = var_638_3
				arg_635_1.typewritter.percent = 0

				arg_635_1.typewritter:SetDirty()
				arg_635_1:ShowNextGo(false)
				arg_635_1:RecordContent(arg_635_1.text_.text)
			end

			local var_638_7 = math.max(var_638_1, arg_635_1.talkMaxDuration)

			if var_638_0 <= arg_635_1.time_ and arg_635_1.time_ < var_638_0 + var_638_7 then
				arg_635_1.typewritter.percent = (arg_635_1.time_ - var_638_0) / var_638_7

				arg_635_1.typewritter:SetDirty()
			end

			if arg_635_1.time_ >= var_638_0 + var_638_7 and arg_635_1.time_ < var_638_0 + var_638_7 + arg_638_0 then
				arg_635_1.typewritter.percent = 1

				arg_635_1.typewritter:SetDirty()
				arg_635_1:ShowNextGo(true)
			end
		end

		arg_635_1.nodeConfigList_ = {}

		arg_635_1:InitPlayNodeList()
	end,
	Play115281152 = function(arg_639_0, arg_639_1)
		arg_639_1.time_ = 0
		arg_639_1.frameCnt_ = 0
		arg_639_1.state_ = "playing"
		arg_639_1.curTalkId_ = 115281152
		arg_639_1.duration_ = 12.57

		local var_639_0 = {
			ja = 12.566,
			ko = 9.4,
			zh = 9.333,
			en = 9.166
		}
		local var_639_1 = manager.audio:GetLocalizationFlag()

		if var_639_0[var_639_1] ~= nil then
			arg_639_1.duration_ = var_639_0[var_639_1]
		end

		SetActive(arg_639_1.tipsGo_, false)

		function arg_639_1.onSingleLineFinish_()
			arg_639_1.onSingleLineUpdate_ = nil
			arg_639_1.onSingleLineFinish_ = nil
			arg_639_1.state_ = "waiting"
		end

		function arg_639_1.playNext_(arg_641_0)
			if arg_641_0 == 1 then
				arg_639_0:Play115281153(arg_639_1)
			end
		end

		function arg_639_1.onSingleLineUpdate_(arg_642_0)
			local var_642_0 = 2

			if var_642_0 < arg_639_1.time_ and arg_639_1.time_ <= var_642_0 + arg_642_0 then
				local var_642_1 = manager.ui.mainCamera.transform.localPosition
				local var_642_2 = Vector3.New(0, 0, 10) + Vector3.New(var_642_1.x, var_642_1.y, 0)
				local var_642_3 = arg_639_1.bgs_.STblack

				var_642_3.transform.localPosition = var_642_2
				var_642_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_642_4 = var_642_3:GetComponent("SpriteRenderer")

				if var_642_4 and var_642_4.sprite then
					local var_642_5 = (var_642_3.transform.localPosition - var_642_1).z
					local var_642_6 = manager.ui.mainCameraCom_
					local var_642_7 = 2 * var_642_5 * Mathf.Tan(var_642_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_642_8 = var_642_7 * var_642_6.aspect
					local var_642_9 = var_642_4.sprite.bounds.size.x
					local var_642_10 = var_642_4.sprite.bounds.size.y
					local var_642_11 = var_642_8 / var_642_9
					local var_642_12 = var_642_7 / var_642_10
					local var_642_13 = var_642_12 < var_642_11 and var_642_11 or var_642_12

					var_642_3.transform.localScale = Vector3.New(var_642_13, var_642_13, 0)
				end

				for iter_642_0, iter_642_1 in pairs(arg_639_1.bgs_) do
					if iter_642_0 ~= "STblack" then
						iter_642_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_642_14 = 0

			if var_642_14 < arg_639_1.time_ and arg_639_1.time_ <= var_642_14 + arg_642_0 then
				arg_639_1.mask_.enabled = true
				arg_639_1.mask_.raycastTarget = false

				arg_639_1:SetGaussion(false)
			end

			local var_642_15 = 2

			if var_642_14 <= arg_639_1.time_ and arg_639_1.time_ < var_642_14 + var_642_15 then
				local var_642_16 = (arg_639_1.time_ - var_642_14) / var_642_15
				local var_642_17 = Color.New(0, 0, 0)

				var_642_17.a = Mathf.Lerp(0, 1, var_642_16)
				arg_639_1.mask_.color = var_642_17
			end

			if arg_639_1.time_ >= var_642_14 + var_642_15 and arg_639_1.time_ < var_642_14 + var_642_15 + arg_642_0 then
				local var_642_18 = Color.New(0, 0, 0)

				var_642_18.a = 1
				arg_639_1.mask_.color = var_642_18
			end

			local var_642_19 = 2

			if var_642_19 < arg_639_1.time_ and arg_639_1.time_ <= var_642_19 + arg_642_0 then
				arg_639_1.mask_.enabled = true
				arg_639_1.mask_.raycastTarget = false

				arg_639_1:SetGaussion(false)
			end

			local var_642_20 = 2

			if var_642_19 <= arg_639_1.time_ and arg_639_1.time_ < var_642_19 + var_642_20 then
				local var_642_21 = (arg_639_1.time_ - var_642_19) / var_642_20
				local var_642_22 = Color.New(0, 0, 0)

				var_642_22.a = Mathf.Lerp(1, 0, var_642_21)
				arg_639_1.mask_.color = var_642_22
			end

			if arg_639_1.time_ >= var_642_19 + var_642_20 and arg_639_1.time_ < var_642_19 + var_642_20 + arg_642_0 then
				local var_642_23 = Color.New(0, 0, 0)
				local var_642_24 = 0

				arg_639_1.mask_.enabled = false
				var_642_23.a = var_642_24
				arg_639_1.mask_.color = var_642_23
			end

			if arg_639_1.frameCnt_ <= 1 then
				arg_639_1.dialog_:SetActive(false)
			end

			local var_642_25 = 4
			local var_642_26 = 0.525

			if var_642_25 < arg_639_1.time_ and arg_639_1.time_ <= var_642_25 + arg_642_0 then
				arg_639_1.talkMaxDuration = 0

				arg_639_1.dialog_:SetActive(true)

				arg_639_1.dialogCg_.alpha = 0

				local var_642_27 = LeanTween.value(arg_639_1.dialog_, 0, 1, 0.3)

				var_642_27:setOnUpdate(LuaHelper.FloatAction(function(arg_643_0)
					arg_639_1.dialogCg_.alpha = arg_643_0
				end))
				var_642_27:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_639_1.dialog_)
					var_642_27:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_639_1.duration_ = arg_639_1.duration_ + 0.3

				SetActive(arg_639_1.leftNameGo_, true)

				local var_642_28 = arg_639_1:FormatText(StoryNameCfg[94].name)

				arg_639_1.leftNameTxt_.text = var_642_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_639_1.leftNameTxt_.transform)

				arg_639_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_639_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_639_1:RecordName(arg_639_1.leftNameTxt_.text)
				SetActive(arg_639_1.iconTrs_.gameObject, true)
				arg_639_1.iconController_:SetSelectedState("hero")

				arg_639_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1138_split_6")

				arg_639_1.callingController_:SetSelectedState("normal")

				arg_639_1.keyicon_.color = Color.New(1, 1, 1)
				arg_639_1.icon_.color = Color.New(1, 1, 1)

				local var_642_29 = arg_639_1:GetWordFromCfg(115281152)
				local var_642_30 = arg_639_1:FormatText(var_642_29.content)

				arg_639_1.text_.text = var_642_30

				LuaForUtil.ClearLinePrefixSymbol(arg_639_1.text_)

				local var_642_31 = 21
				local var_642_32 = utf8.len(var_642_30)
				local var_642_33 = var_642_31 <= 0 and var_642_26 or var_642_26 * (var_642_32 / var_642_31)

				if var_642_33 > 0 and var_642_26 < var_642_33 then
					arg_639_1.talkMaxDuration = var_642_33
					var_642_25 = var_642_25 + 0.3

					if var_642_33 + var_642_25 > arg_639_1.duration_ then
						arg_639_1.duration_ = var_642_33 + var_642_25
					end
				end

				arg_639_1.text_.text = var_642_30
				arg_639_1.typewritter.percent = 0

				arg_639_1.typewritter:SetDirty()
				arg_639_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115281", "115281152", "story_v_out_115281.awb") ~= 0 then
					local var_642_34 = manager.audio:GetVoiceLength("story_v_out_115281", "115281152", "story_v_out_115281.awb") / 1000

					if var_642_34 + var_642_25 > arg_639_1.duration_ then
						arg_639_1.duration_ = var_642_34 + var_642_25
					end

					if var_642_29.prefab_name ~= "" and arg_639_1.actors_[var_642_29.prefab_name] ~= nil then
						local var_642_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_639_1.actors_[var_642_29.prefab_name].transform, "story_v_out_115281", "115281152", "story_v_out_115281.awb")

						arg_639_1:RecordAudio("115281152", var_642_35)
						arg_639_1:RecordAudio("115281152", var_642_35)
					else
						arg_639_1:AudioAction("play", "voice", "story_v_out_115281", "115281152", "story_v_out_115281.awb")
					end

					arg_639_1:RecordHistoryTalkVoice("story_v_out_115281", "115281152", "story_v_out_115281.awb")
				end

				arg_639_1:RecordContent(arg_639_1.text_.text)
			end

			local var_642_36 = var_642_25 + 0.3
			local var_642_37 = math.max(var_642_26, arg_639_1.talkMaxDuration)

			if var_642_36 <= arg_639_1.time_ and arg_639_1.time_ < var_642_36 + var_642_37 then
				arg_639_1.typewritter.percent = (arg_639_1.time_ - var_642_36) / var_642_37

				arg_639_1.typewritter:SetDirty()
			end

			if arg_639_1.time_ >= var_642_36 + var_642_37 and arg_639_1.time_ < var_642_36 + var_642_37 + arg_642_0 then
				arg_639_1.typewritter.percent = 1

				arg_639_1.typewritter:SetDirty()
				arg_639_1:ShowNextGo(true)
			end
		end

		arg_639_1.nodeConfigList_ = {}

		arg_639_1:InitPlayNodeList()
	end,
	Play115281153 = function(arg_645_0, arg_645_1)
		arg_645_1.time_ = 0
		arg_645_1.frameCnt_ = 0
		arg_645_1.state_ = "playing"
		arg_645_1.curTalkId_ = 115281153
		arg_645_1.duration_ = 5

		SetActive(arg_645_1.tipsGo_, false)

		function arg_645_1.onSingleLineFinish_()
			arg_645_1.onSingleLineUpdate_ = nil
			arg_645_1.onSingleLineFinish_ = nil
			arg_645_1.state_ = "waiting"
		end

		function arg_645_1.playNext_(arg_647_0)
			if arg_647_0 == 1 then
				arg_645_0:Play115281154(arg_645_1)
			end
		end

		function arg_645_1.onSingleLineUpdate_(arg_648_0)
			local var_648_0 = 0
			local var_648_1 = 0.975

			if var_648_0 < arg_645_1.time_ and arg_645_1.time_ <= var_648_0 + arg_648_0 then
				arg_645_1.talkMaxDuration = 0
				arg_645_1.dialogCg_.alpha = 1

				arg_645_1.dialog_:SetActive(true)
				SetActive(arg_645_1.leftNameGo_, false)

				arg_645_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_645_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_645_1:RecordName(arg_645_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_645_1.iconTrs_.gameObject, false)
				arg_645_1.callingController_:SetSelectedState("normal")

				local var_648_2 = arg_645_1:GetWordFromCfg(115281153)
				local var_648_3 = arg_645_1:FormatText(var_648_2.content)

				arg_645_1.text_.text = var_648_3

				LuaForUtil.ClearLinePrefixSymbol(arg_645_1.text_)

				local var_648_4 = 39
				local var_648_5 = utf8.len(var_648_3)
				local var_648_6 = var_648_4 <= 0 and var_648_1 or var_648_1 * (var_648_5 / var_648_4)

				if var_648_6 > 0 and var_648_1 < var_648_6 then
					arg_645_1.talkMaxDuration = var_648_6

					if var_648_6 + var_648_0 > arg_645_1.duration_ then
						arg_645_1.duration_ = var_648_6 + var_648_0
					end
				end

				arg_645_1.text_.text = var_648_3
				arg_645_1.typewritter.percent = 0

				arg_645_1.typewritter:SetDirty()
				arg_645_1:ShowNextGo(false)
				arg_645_1:RecordContent(arg_645_1.text_.text)
			end

			local var_648_7 = math.max(var_648_1, arg_645_1.talkMaxDuration)

			if var_648_0 <= arg_645_1.time_ and arg_645_1.time_ < var_648_0 + var_648_7 then
				arg_645_1.typewritter.percent = (arg_645_1.time_ - var_648_0) / var_648_7

				arg_645_1.typewritter:SetDirty()
			end

			if arg_645_1.time_ >= var_648_0 + var_648_7 and arg_645_1.time_ < var_648_0 + var_648_7 + arg_648_0 then
				arg_645_1.typewritter.percent = 1

				arg_645_1.typewritter:SetDirty()
				arg_645_1:ShowNextGo(true)
			end
		end

		arg_645_1.nodeConfigList_ = {}

		arg_645_1:InitPlayNodeList()
	end,
	Play115281154 = function(arg_649_0, arg_649_1)
		arg_649_1.time_ = 0
		arg_649_1.frameCnt_ = 0
		arg_649_1.state_ = "playing"
		arg_649_1.curTalkId_ = 115281154
		arg_649_1.duration_ = 5

		SetActive(arg_649_1.tipsGo_, false)

		function arg_649_1.onSingleLineFinish_()
			arg_649_1.onSingleLineUpdate_ = nil
			arg_649_1.onSingleLineFinish_ = nil
			arg_649_1.state_ = "waiting"
		end

		function arg_649_1.playNext_(arg_651_0)
			if arg_651_0 == 1 then
				arg_649_0:Play115281155(arg_649_1)
			end
		end

		function arg_649_1.onSingleLineUpdate_(arg_652_0)
			local var_652_0 = 0
			local var_652_1 = 0.95

			if var_652_0 < arg_649_1.time_ and arg_649_1.time_ <= var_652_0 + arg_652_0 then
				arg_649_1.talkMaxDuration = 0
				arg_649_1.dialogCg_.alpha = 1

				arg_649_1.dialog_:SetActive(true)
				SetActive(arg_649_1.leftNameGo_, false)

				arg_649_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_649_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_649_1:RecordName(arg_649_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_649_1.iconTrs_.gameObject, false)
				arg_649_1.callingController_:SetSelectedState("normal")

				local var_652_2 = arg_649_1:GetWordFromCfg(115281154)
				local var_652_3 = arg_649_1:FormatText(var_652_2.content)

				arg_649_1.text_.text = var_652_3

				LuaForUtil.ClearLinePrefixSymbol(arg_649_1.text_)

				local var_652_4 = 38
				local var_652_5 = utf8.len(var_652_3)
				local var_652_6 = var_652_4 <= 0 and var_652_1 or var_652_1 * (var_652_5 / var_652_4)

				if var_652_6 > 0 and var_652_1 < var_652_6 then
					arg_649_1.talkMaxDuration = var_652_6

					if var_652_6 + var_652_0 > arg_649_1.duration_ then
						arg_649_1.duration_ = var_652_6 + var_652_0
					end
				end

				arg_649_1.text_.text = var_652_3
				arg_649_1.typewritter.percent = 0

				arg_649_1.typewritter:SetDirty()
				arg_649_1:ShowNextGo(false)
				arg_649_1:RecordContent(arg_649_1.text_.text)
			end

			local var_652_7 = math.max(var_652_1, arg_649_1.talkMaxDuration)

			if var_652_0 <= arg_649_1.time_ and arg_649_1.time_ < var_652_0 + var_652_7 then
				arg_649_1.typewritter.percent = (arg_649_1.time_ - var_652_0) / var_652_7

				arg_649_1.typewritter:SetDirty()
			end

			if arg_649_1.time_ >= var_652_0 + var_652_7 and arg_649_1.time_ < var_652_0 + var_652_7 + arg_652_0 then
				arg_649_1.typewritter.percent = 1

				arg_649_1.typewritter:SetDirty()
				arg_649_1:ShowNextGo(true)
			end
		end

		arg_649_1.nodeConfigList_ = {}

		arg_649_1:InitPlayNodeList()
	end,
	Play115281155 = function(arg_653_0, arg_653_1)
		arg_653_1.time_ = 0
		arg_653_1.frameCnt_ = 0
		arg_653_1.state_ = "playing"
		arg_653_1.curTalkId_ = 115281155
		arg_653_1.duration_ = 8

		SetActive(arg_653_1.tipsGo_, false)

		function arg_653_1.onSingleLineFinish_()
			arg_653_1.onSingleLineUpdate_ = nil
			arg_653_1.onSingleLineFinish_ = nil
			arg_653_1.state_ = "waiting"
		end

		function arg_653_1.playNext_(arg_655_0)
			if arg_655_0 == 1 then
				arg_653_0:Play115281156(arg_653_1)
			end
		end

		function arg_653_1.onSingleLineUpdate_(arg_656_0)
			local var_656_0 = 1

			if var_656_0 < arg_653_1.time_ and arg_653_1.time_ <= var_656_0 + arg_656_0 then
				local var_656_1 = manager.ui.mainCamera.transform.localPosition
				local var_656_2 = Vector3.New(0, 0, 10) + Vector3.New(var_656_1.x, var_656_1.y, 0)
				local var_656_3 = arg_653_1.bgs_.ST28a

				var_656_3.transform.localPosition = var_656_2
				var_656_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_656_4 = var_656_3:GetComponent("SpriteRenderer")

				if var_656_4 and var_656_4.sprite then
					local var_656_5 = (var_656_3.transform.localPosition - var_656_1).z
					local var_656_6 = manager.ui.mainCameraCom_
					local var_656_7 = 2 * var_656_5 * Mathf.Tan(var_656_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_656_8 = var_656_7 * var_656_6.aspect
					local var_656_9 = var_656_4.sprite.bounds.size.x
					local var_656_10 = var_656_4.sprite.bounds.size.y
					local var_656_11 = var_656_8 / var_656_9
					local var_656_12 = var_656_7 / var_656_10
					local var_656_13 = var_656_12 < var_656_11 and var_656_11 or var_656_12

					var_656_3.transform.localScale = Vector3.New(var_656_13, var_656_13, 0)
				end

				for iter_656_0, iter_656_1 in pairs(arg_653_1.bgs_) do
					if iter_656_0 ~= "ST28a" then
						iter_656_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_656_14 = 0

			if var_656_14 < arg_653_1.time_ and arg_653_1.time_ <= var_656_14 + arg_656_0 then
				arg_653_1.mask_.enabled = true
				arg_653_1.mask_.raycastTarget = false

				arg_653_1:SetGaussion(false)
			end

			local var_656_15 = 1

			if var_656_14 <= arg_653_1.time_ and arg_653_1.time_ < var_656_14 + var_656_15 then
				local var_656_16 = (arg_653_1.time_ - var_656_14) / var_656_15
				local var_656_17 = Color.New(0, 0, 0)

				var_656_17.a = Mathf.Lerp(0, 1, var_656_16)
				arg_653_1.mask_.color = var_656_17
			end

			if arg_653_1.time_ >= var_656_14 + var_656_15 and arg_653_1.time_ < var_656_14 + var_656_15 + arg_656_0 then
				local var_656_18 = Color.New(0, 0, 0)

				var_656_18.a = 1
				arg_653_1.mask_.color = var_656_18
			end

			local var_656_19 = 1

			if var_656_19 < arg_653_1.time_ and arg_653_1.time_ <= var_656_19 + arg_656_0 then
				arg_653_1.mask_.enabled = true
				arg_653_1.mask_.raycastTarget = false

				arg_653_1:SetGaussion(false)
			end

			local var_656_20 = 2

			if var_656_19 <= arg_653_1.time_ and arg_653_1.time_ < var_656_19 + var_656_20 then
				local var_656_21 = (arg_653_1.time_ - var_656_19) / var_656_20
				local var_656_22 = Color.New(0, 0, 0)

				var_656_22.a = Mathf.Lerp(1, 0, var_656_21)
				arg_653_1.mask_.color = var_656_22
			end

			if arg_653_1.time_ >= var_656_19 + var_656_20 and arg_653_1.time_ < var_656_19 + var_656_20 + arg_656_0 then
				local var_656_23 = Color.New(0, 0, 0)
				local var_656_24 = 0

				arg_653_1.mask_.enabled = false
				var_656_23.a = var_656_24
				arg_653_1.mask_.color = var_656_23
			end

			if arg_653_1.frameCnt_ <= 1 then
				arg_653_1.dialog_:SetActive(false)
			end

			local var_656_25 = 3
			local var_656_26 = 0.225

			if var_656_25 < arg_653_1.time_ and arg_653_1.time_ <= var_656_25 + arg_656_0 then
				arg_653_1.talkMaxDuration = 0

				arg_653_1.dialog_:SetActive(true)

				arg_653_1.dialogCg_.alpha = 0

				local var_656_27 = LeanTween.value(arg_653_1.dialog_, 0, 1, 0.3)

				var_656_27:setOnUpdate(LuaHelper.FloatAction(function(arg_657_0)
					arg_653_1.dialogCg_.alpha = arg_657_0
				end))
				var_656_27:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_653_1.dialog_)
					var_656_27:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_653_1.duration_ = arg_653_1.duration_ + 0.3

				SetActive(arg_653_1.leftNameGo_, false)

				arg_653_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_653_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_653_1:RecordName(arg_653_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_653_1.iconTrs_.gameObject, false)
				arg_653_1.callingController_:SetSelectedState("normal")

				local var_656_28 = arg_653_1:GetWordFromCfg(115281155)
				local var_656_29 = arg_653_1:FormatText(var_656_28.content)

				arg_653_1.text_.text = var_656_29

				LuaForUtil.ClearLinePrefixSymbol(arg_653_1.text_)

				local var_656_30 = 9
				local var_656_31 = utf8.len(var_656_29)
				local var_656_32 = var_656_30 <= 0 and var_656_26 or var_656_26 * (var_656_31 / var_656_30)

				if var_656_32 > 0 and var_656_26 < var_656_32 then
					arg_653_1.talkMaxDuration = var_656_32
					var_656_25 = var_656_25 + 0.3

					if var_656_32 + var_656_25 > arg_653_1.duration_ then
						arg_653_1.duration_ = var_656_32 + var_656_25
					end
				end

				arg_653_1.text_.text = var_656_29
				arg_653_1.typewritter.percent = 0

				arg_653_1.typewritter:SetDirty()
				arg_653_1:ShowNextGo(false)
				arg_653_1:RecordContent(arg_653_1.text_.text)
			end

			local var_656_33 = var_656_25 + 0.3
			local var_656_34 = math.max(var_656_26, arg_653_1.talkMaxDuration)

			if var_656_33 <= arg_653_1.time_ and arg_653_1.time_ < var_656_33 + var_656_34 then
				arg_653_1.typewritter.percent = (arg_653_1.time_ - var_656_33) / var_656_34

				arg_653_1.typewritter:SetDirty()
			end

			if arg_653_1.time_ >= var_656_33 + var_656_34 and arg_653_1.time_ < var_656_33 + var_656_34 + arg_656_0 then
				arg_653_1.typewritter.percent = 1

				arg_653_1.typewritter:SetDirty()
				arg_653_1:ShowNextGo(true)
			end
		end

		arg_653_1.nodeConfigList_ = {}

		arg_653_1:InitPlayNodeList()
	end,
	Play115281156 = function(arg_659_0, arg_659_1)
		arg_659_1.time_ = 0
		arg_659_1.frameCnt_ = 0
		arg_659_1.state_ = "playing"
		arg_659_1.curTalkId_ = 115281156
		arg_659_1.duration_ = 5

		SetActive(arg_659_1.tipsGo_, false)

		function arg_659_1.onSingleLineFinish_()
			arg_659_1.onSingleLineUpdate_ = nil
			arg_659_1.onSingleLineFinish_ = nil
			arg_659_1.state_ = "waiting"
		end

		function arg_659_1.playNext_(arg_661_0)
			if arg_661_0 == 1 then
				arg_659_0:Play115281157(arg_659_1)
			end
		end

		function arg_659_1.onSingleLineUpdate_(arg_662_0)
			local var_662_0 = 0
			local var_662_1 = 1.05

			if var_662_0 < arg_659_1.time_ and arg_659_1.time_ <= var_662_0 + arg_662_0 then
				arg_659_1.talkMaxDuration = 0
				arg_659_1.dialogCg_.alpha = 1

				arg_659_1.dialog_:SetActive(true)
				SetActive(arg_659_1.leftNameGo_, false)

				arg_659_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_659_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_659_1:RecordName(arg_659_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_659_1.iconTrs_.gameObject, false)
				arg_659_1.callingController_:SetSelectedState("normal")

				local var_662_2 = arg_659_1:GetWordFromCfg(115281156)
				local var_662_3 = arg_659_1:FormatText(var_662_2.content)

				arg_659_1.text_.text = var_662_3

				LuaForUtil.ClearLinePrefixSymbol(arg_659_1.text_)

				local var_662_4 = 42
				local var_662_5 = utf8.len(var_662_3)
				local var_662_6 = var_662_4 <= 0 and var_662_1 or var_662_1 * (var_662_5 / var_662_4)

				if var_662_6 > 0 and var_662_1 < var_662_6 then
					arg_659_1.talkMaxDuration = var_662_6

					if var_662_6 + var_662_0 > arg_659_1.duration_ then
						arg_659_1.duration_ = var_662_6 + var_662_0
					end
				end

				arg_659_1.text_.text = var_662_3
				arg_659_1.typewritter.percent = 0

				arg_659_1.typewritter:SetDirty()
				arg_659_1:ShowNextGo(false)
				arg_659_1:RecordContent(arg_659_1.text_.text)
			end

			local var_662_7 = math.max(var_662_1, arg_659_1.talkMaxDuration)

			if var_662_0 <= arg_659_1.time_ and arg_659_1.time_ < var_662_0 + var_662_7 then
				arg_659_1.typewritter.percent = (arg_659_1.time_ - var_662_0) / var_662_7

				arg_659_1.typewritter:SetDirty()
			end

			if arg_659_1.time_ >= var_662_0 + var_662_7 and arg_659_1.time_ < var_662_0 + var_662_7 + arg_662_0 then
				arg_659_1.typewritter.percent = 1

				arg_659_1.typewritter:SetDirty()
				arg_659_1:ShowNextGo(true)
			end
		end

		arg_659_1.nodeConfigList_ = {}

		arg_659_1:InitPlayNodeList()
	end,
	Play115281157 = function(arg_663_0, arg_663_1)
		arg_663_1.time_ = 0
		arg_663_1.frameCnt_ = 0
		arg_663_1.state_ = "playing"
		arg_663_1.curTalkId_ = 115281157
		arg_663_1.duration_ = 5

		SetActive(arg_663_1.tipsGo_, false)

		function arg_663_1.onSingleLineFinish_()
			arg_663_1.onSingleLineUpdate_ = nil
			arg_663_1.onSingleLineFinish_ = nil
			arg_663_1.state_ = "waiting"
		end

		function arg_663_1.playNext_(arg_665_0)
			if arg_665_0 == 1 then
				arg_663_0:Play115281158(arg_663_1)
			end
		end

		function arg_663_1.onSingleLineUpdate_(arg_666_0)
			local var_666_0 = 0
			local var_666_1 = 1.125

			if var_666_0 < arg_663_1.time_ and arg_663_1.time_ <= var_666_0 + arg_666_0 then
				arg_663_1.talkMaxDuration = 0
				arg_663_1.dialogCg_.alpha = 1

				arg_663_1.dialog_:SetActive(true)
				SetActive(arg_663_1.leftNameGo_, false)

				arg_663_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_663_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_663_1:RecordName(arg_663_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_663_1.iconTrs_.gameObject, false)
				arg_663_1.callingController_:SetSelectedState("normal")

				local var_666_2 = arg_663_1:GetWordFromCfg(115281157)
				local var_666_3 = arg_663_1:FormatText(var_666_2.content)

				arg_663_1.text_.text = var_666_3

				LuaForUtil.ClearLinePrefixSymbol(arg_663_1.text_)

				local var_666_4 = 45
				local var_666_5 = utf8.len(var_666_3)
				local var_666_6 = var_666_4 <= 0 and var_666_1 or var_666_1 * (var_666_5 / var_666_4)

				if var_666_6 > 0 and var_666_1 < var_666_6 then
					arg_663_1.talkMaxDuration = var_666_6

					if var_666_6 + var_666_0 > arg_663_1.duration_ then
						arg_663_1.duration_ = var_666_6 + var_666_0
					end
				end

				arg_663_1.text_.text = var_666_3
				arg_663_1.typewritter.percent = 0

				arg_663_1.typewritter:SetDirty()
				arg_663_1:ShowNextGo(false)
				arg_663_1:RecordContent(arg_663_1.text_.text)
			end

			local var_666_7 = math.max(var_666_1, arg_663_1.talkMaxDuration)

			if var_666_0 <= arg_663_1.time_ and arg_663_1.time_ < var_666_0 + var_666_7 then
				arg_663_1.typewritter.percent = (arg_663_1.time_ - var_666_0) / var_666_7

				arg_663_1.typewritter:SetDirty()
			end

			if arg_663_1.time_ >= var_666_0 + var_666_7 and arg_663_1.time_ < var_666_0 + var_666_7 + arg_666_0 then
				arg_663_1.typewritter.percent = 1

				arg_663_1.typewritter:SetDirty()
				arg_663_1:ShowNextGo(true)
			end
		end

		arg_663_1.nodeConfigList_ = {}

		arg_663_1:InitPlayNodeList()
	end,
	Play115281158 = function(arg_667_0, arg_667_1)
		arg_667_1.time_ = 0
		arg_667_1.frameCnt_ = 0
		arg_667_1.state_ = "playing"
		arg_667_1.curTalkId_ = 115281158
		arg_667_1.duration_ = 14.2

		local var_667_0 = {
			ja = 10.466,
			ko = 10.233,
			zh = 9.266,
			en = 14.2
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
				arg_667_0:Play115281159(arg_667_1)
			end
		end

		function arg_667_1.onSingleLineUpdate_(arg_670_0)
			local var_670_0 = 0
			local var_670_1 = 0.975

			if var_670_0 < arg_667_1.time_ and arg_667_1.time_ <= var_670_0 + arg_670_0 then
				arg_667_1.talkMaxDuration = 0
				arg_667_1.dialogCg_.alpha = 1

				arg_667_1.dialog_:SetActive(true)
				SetActive(arg_667_1.leftNameGo_, true)

				local var_670_2 = arg_667_1:FormatText(StoryNameCfg[224].name)

				arg_667_1.leftNameTxt_.text = var_670_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_667_1.leftNameTxt_.transform)

				arg_667_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_667_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_667_1:RecordName(arg_667_1.leftNameTxt_.text)
				SetActive(arg_667_1.iconTrs_.gameObject, true)
				arg_667_1.iconController_:SetSelectedState("hero")

				arg_667_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_clerkb")

				arg_667_1.callingController_:SetSelectedState("normal")

				arg_667_1.keyicon_.color = Color.New(1, 1, 1)
				arg_667_1.icon_.color = Color.New(1, 1, 1)

				local var_670_3 = arg_667_1:GetWordFromCfg(115281158)
				local var_670_4 = arg_667_1:FormatText(var_670_3.content)

				arg_667_1.text_.text = var_670_4

				LuaForUtil.ClearLinePrefixSymbol(arg_667_1.text_)

				local var_670_5 = 39
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

				if manager.audio:GetVoiceLength("story_v_out_115281", "115281158", "story_v_out_115281.awb") ~= 0 then
					local var_670_8 = manager.audio:GetVoiceLength("story_v_out_115281", "115281158", "story_v_out_115281.awb") / 1000

					if var_670_8 + var_670_0 > arg_667_1.duration_ then
						arg_667_1.duration_ = var_670_8 + var_670_0
					end

					if var_670_3.prefab_name ~= "" and arg_667_1.actors_[var_670_3.prefab_name] ~= nil then
						local var_670_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_667_1.actors_[var_670_3.prefab_name].transform, "story_v_out_115281", "115281158", "story_v_out_115281.awb")

						arg_667_1:RecordAudio("115281158", var_670_9)
						arg_667_1:RecordAudio("115281158", var_670_9)
					else
						arg_667_1:AudioAction("play", "voice", "story_v_out_115281", "115281158", "story_v_out_115281.awb")
					end

					arg_667_1:RecordHistoryTalkVoice("story_v_out_115281", "115281158", "story_v_out_115281.awb")
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
	Play115281159 = function(arg_671_0, arg_671_1)
		arg_671_1.time_ = 0
		arg_671_1.frameCnt_ = 0
		arg_671_1.state_ = "playing"
		arg_671_1.curTalkId_ = 115281159
		arg_671_1.duration_ = 5

		SetActive(arg_671_1.tipsGo_, false)

		function arg_671_1.onSingleLineFinish_()
			arg_671_1.onSingleLineUpdate_ = nil
			arg_671_1.onSingleLineFinish_ = nil
			arg_671_1.state_ = "waiting"
		end

		function arg_671_1.playNext_(arg_673_0)
			if arg_673_0 == 1 then
				arg_671_0:Play115281160(arg_671_1)
			end
		end

		function arg_671_1.onSingleLineUpdate_(arg_674_0)
			local var_674_0 = 0
			local var_674_1 = 1.25

			if var_674_0 < arg_671_1.time_ and arg_671_1.time_ <= var_674_0 + arg_674_0 then
				arg_671_1.talkMaxDuration = 0
				arg_671_1.dialogCg_.alpha = 1

				arg_671_1.dialog_:SetActive(true)
				SetActive(arg_671_1.leftNameGo_, false)

				arg_671_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_671_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_671_1:RecordName(arg_671_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_671_1.iconTrs_.gameObject, false)
				arg_671_1.callingController_:SetSelectedState("normal")

				local var_674_2 = arg_671_1:GetWordFromCfg(115281159)
				local var_674_3 = arg_671_1:FormatText(var_674_2.content)

				arg_671_1.text_.text = var_674_3

				LuaForUtil.ClearLinePrefixSymbol(arg_671_1.text_)

				local var_674_4 = 50
				local var_674_5 = utf8.len(var_674_3)
				local var_674_6 = var_674_4 <= 0 and var_674_1 or var_674_1 * (var_674_5 / var_674_4)

				if var_674_6 > 0 and var_674_1 < var_674_6 then
					arg_671_1.talkMaxDuration = var_674_6

					if var_674_6 + var_674_0 > arg_671_1.duration_ then
						arg_671_1.duration_ = var_674_6 + var_674_0
					end
				end

				arg_671_1.text_.text = var_674_3
				arg_671_1.typewritter.percent = 0

				arg_671_1.typewritter:SetDirty()
				arg_671_1:ShowNextGo(false)
				arg_671_1:RecordContent(arg_671_1.text_.text)
			end

			local var_674_7 = math.max(var_674_1, arg_671_1.talkMaxDuration)

			if var_674_0 <= arg_671_1.time_ and arg_671_1.time_ < var_674_0 + var_674_7 then
				arg_671_1.typewritter.percent = (arg_671_1.time_ - var_674_0) / var_674_7

				arg_671_1.typewritter:SetDirty()
			end

			if arg_671_1.time_ >= var_674_0 + var_674_7 and arg_671_1.time_ < var_674_0 + var_674_7 + arg_674_0 then
				arg_671_1.typewritter.percent = 1

				arg_671_1.typewritter:SetDirty()
				arg_671_1:ShowNextGo(true)
			end
		end

		arg_671_1.nodeConfigList_ = {}

		arg_671_1:InitPlayNodeList()
	end,
	Play115281160 = function(arg_675_0, arg_675_1)
		arg_675_1.time_ = 0
		arg_675_1.frameCnt_ = 0
		arg_675_1.state_ = "playing"
		arg_675_1.curTalkId_ = 115281160
		arg_675_1.duration_ = 5.47

		local var_675_0 = {
			ja = 5.466,
			ko = 1.666,
			zh = 4.3,
			en = 1.666
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
				arg_675_0:Play115281161(arg_675_1)
			end
		end

		function arg_675_1.onSingleLineUpdate_(arg_678_0)
			local var_678_0 = arg_675_1.actors_["10030"].transform
			local var_678_1 = 0

			if var_678_1 < arg_675_1.time_ and arg_675_1.time_ <= var_678_1 + arg_678_0 then
				arg_675_1.var_.moveOldPos10030 = var_678_0.localPosition
				var_678_0.localScale = Vector3.New(1, 1, 1)

				arg_675_1:CheckSpriteTmpPos("10030", 3)

				local var_678_2 = var_678_0.childCount

				for iter_678_0 = 0, var_678_2 - 1 do
					local var_678_3 = var_678_0:GetChild(iter_678_0)

					if var_678_3.name == "split_3" or not string.find(var_678_3.name, "split") then
						var_678_3.gameObject:SetActive(true)
					else
						var_678_3.gameObject:SetActive(false)
					end
				end
			end

			local var_678_4 = 0.001

			if var_678_1 <= arg_675_1.time_ and arg_675_1.time_ < var_678_1 + var_678_4 then
				local var_678_5 = (arg_675_1.time_ - var_678_1) / var_678_4
				local var_678_6 = Vector3.New(0, -390, 150)

				var_678_0.localPosition = Vector3.Lerp(arg_675_1.var_.moveOldPos10030, var_678_6, var_678_5)
			end

			if arg_675_1.time_ >= var_678_1 + var_678_4 and arg_675_1.time_ < var_678_1 + var_678_4 + arg_678_0 then
				var_678_0.localPosition = Vector3.New(0, -390, 150)
			end

			local var_678_7 = arg_675_1.actors_["10030"]
			local var_678_8 = 0

			if var_678_8 < arg_675_1.time_ and arg_675_1.time_ <= var_678_8 + arg_678_0 and not isNil(var_678_7) and arg_675_1.var_.actorSpriteComps10030 == nil then
				arg_675_1.var_.actorSpriteComps10030 = var_678_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_678_9 = 0.2

			if var_678_8 <= arg_675_1.time_ and arg_675_1.time_ < var_678_8 + var_678_9 and not isNil(var_678_7) then
				local var_678_10 = (arg_675_1.time_ - var_678_8) / var_678_9

				if arg_675_1.var_.actorSpriteComps10030 then
					for iter_678_1, iter_678_2 in pairs(arg_675_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_678_2 then
							if arg_675_1.isInRecall_ then
								local var_678_11 = Mathf.Lerp(iter_678_2.color.r, arg_675_1.hightColor1.r, var_678_10)
								local var_678_12 = Mathf.Lerp(iter_678_2.color.g, arg_675_1.hightColor1.g, var_678_10)
								local var_678_13 = Mathf.Lerp(iter_678_2.color.b, arg_675_1.hightColor1.b, var_678_10)

								iter_678_2.color = Color.New(var_678_11, var_678_12, var_678_13)
							else
								local var_678_14 = Mathf.Lerp(iter_678_2.color.r, 1, var_678_10)

								iter_678_2.color = Color.New(var_678_14, var_678_14, var_678_14)
							end
						end
					end
				end
			end

			if arg_675_1.time_ >= var_678_8 + var_678_9 and arg_675_1.time_ < var_678_8 + var_678_9 + arg_678_0 and not isNil(var_678_7) and arg_675_1.var_.actorSpriteComps10030 then
				for iter_678_3, iter_678_4 in pairs(arg_675_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_678_4 then
						if arg_675_1.isInRecall_ then
							iter_678_4.color = arg_675_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_678_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_675_1.var_.actorSpriteComps10030 = nil
			end

			local var_678_15 = arg_675_1.actors_["10030"]
			local var_678_16 = 0

			if var_678_16 < arg_675_1.time_ and arg_675_1.time_ <= var_678_16 + arg_678_0 then
				local var_678_17 = var_678_15:GetComponentInChildren(typeof(CanvasGroup))

				if var_678_17 then
					arg_675_1.var_.alphaOldValue10030 = var_678_17.alpha
					arg_675_1.var_.characterEffect10030 = var_678_17
				end

				arg_675_1.var_.alphaOldValue10030 = 0
			end

			local var_678_18 = 0.333333333333333

			if var_678_16 <= arg_675_1.time_ and arg_675_1.time_ < var_678_16 + var_678_18 then
				local var_678_19 = (arg_675_1.time_ - var_678_16) / var_678_18
				local var_678_20 = Mathf.Lerp(arg_675_1.var_.alphaOldValue10030, 1, var_678_19)

				if arg_675_1.var_.characterEffect10030 then
					arg_675_1.var_.characterEffect10030.alpha = var_678_20
				end
			end

			if arg_675_1.time_ >= var_678_16 + var_678_18 and arg_675_1.time_ < var_678_16 + var_678_18 + arg_678_0 and arg_675_1.var_.characterEffect10030 then
				arg_675_1.var_.characterEffect10030.alpha = 1
			end

			local var_678_21 = 0
			local var_678_22 = 0.2

			if var_678_21 < arg_675_1.time_ and arg_675_1.time_ <= var_678_21 + arg_678_0 then
				arg_675_1.talkMaxDuration = 0
				arg_675_1.dialogCg_.alpha = 1

				arg_675_1.dialog_:SetActive(true)
				SetActive(arg_675_1.leftNameGo_, true)

				local var_678_23 = arg_675_1:FormatText(StoryNameCfg[309].name)

				arg_675_1.leftNameTxt_.text = var_678_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_675_1.leftNameTxt_.transform)

				arg_675_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_675_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_675_1:RecordName(arg_675_1.leftNameTxt_.text)
				SetActive(arg_675_1.iconTrs_.gameObject, false)
				arg_675_1.callingController_:SetSelectedState("normal")

				local var_678_24 = arg_675_1:GetWordFromCfg(115281160)
				local var_678_25 = arg_675_1:FormatText(var_678_24.content)

				arg_675_1.text_.text = var_678_25

				LuaForUtil.ClearLinePrefixSymbol(arg_675_1.text_)

				local var_678_26 = 8
				local var_678_27 = utf8.len(var_678_25)
				local var_678_28 = var_678_26 <= 0 and var_678_22 or var_678_22 * (var_678_27 / var_678_26)

				if var_678_28 > 0 and var_678_22 < var_678_28 then
					arg_675_1.talkMaxDuration = var_678_28

					if var_678_28 + var_678_21 > arg_675_1.duration_ then
						arg_675_1.duration_ = var_678_28 + var_678_21
					end
				end

				arg_675_1.text_.text = var_678_25
				arg_675_1.typewritter.percent = 0

				arg_675_1.typewritter:SetDirty()
				arg_675_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115281", "115281160", "story_v_out_115281.awb") ~= 0 then
					local var_678_29 = manager.audio:GetVoiceLength("story_v_out_115281", "115281160", "story_v_out_115281.awb") / 1000

					if var_678_29 + var_678_21 > arg_675_1.duration_ then
						arg_675_1.duration_ = var_678_29 + var_678_21
					end

					if var_678_24.prefab_name ~= "" and arg_675_1.actors_[var_678_24.prefab_name] ~= nil then
						local var_678_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_675_1.actors_[var_678_24.prefab_name].transform, "story_v_out_115281", "115281160", "story_v_out_115281.awb")

						arg_675_1:RecordAudio("115281160", var_678_30)
						arg_675_1:RecordAudio("115281160", var_678_30)
					else
						arg_675_1:AudioAction("play", "voice", "story_v_out_115281", "115281160", "story_v_out_115281.awb")
					end

					arg_675_1:RecordHistoryTalkVoice("story_v_out_115281", "115281160", "story_v_out_115281.awb")
				end

				arg_675_1:RecordContent(arg_675_1.text_.text)
			end

			local var_678_31 = math.max(var_678_22, arg_675_1.talkMaxDuration)

			if var_678_21 <= arg_675_1.time_ and arg_675_1.time_ < var_678_21 + var_678_31 then
				arg_675_1.typewritter.percent = (arg_675_1.time_ - var_678_21) / var_678_31

				arg_675_1.typewritter:SetDirty()
			end

			if arg_675_1.time_ >= var_678_21 + var_678_31 and arg_675_1.time_ < var_678_21 + var_678_31 + arg_678_0 then
				arg_675_1.typewritter.percent = 1

				arg_675_1.typewritter:SetDirty()
				arg_675_1:ShowNextGo(true)
			end
		end

		arg_675_1.nodeConfigList_ = {
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

		arg_675_1:InitPlayNodeList()
	end,
	Play115281161 = function(arg_679_0, arg_679_1)
		arg_679_1.time_ = 0
		arg_679_1.frameCnt_ = 0
		arg_679_1.state_ = "playing"
		arg_679_1.curTalkId_ = 115281161
		arg_679_1.duration_ = 5

		SetActive(arg_679_1.tipsGo_, false)

		function arg_679_1.onSingleLineFinish_()
			arg_679_1.onSingleLineUpdate_ = nil
			arg_679_1.onSingleLineFinish_ = nil
			arg_679_1.state_ = "waiting"
		end

		function arg_679_1.playNext_(arg_681_0)
			if arg_681_0 == 1 then
				arg_679_0:Play115281162(arg_679_1)
			end
		end

		function arg_679_1.onSingleLineUpdate_(arg_682_0)
			local var_682_0 = arg_679_1.actors_["10030"]
			local var_682_1 = 0

			if var_682_1 < arg_679_1.time_ and arg_679_1.time_ <= var_682_1 + arg_682_0 then
				local var_682_2 = var_682_0:GetComponentInChildren(typeof(CanvasGroup))

				if var_682_2 then
					arg_679_1.var_.alphaOldValue10030 = var_682_2.alpha
					arg_679_1.var_.characterEffect10030 = var_682_2
				end

				arg_679_1.var_.alphaOldValue10030 = 1
			end

			local var_682_3 = 0.333333333333333

			if var_682_1 <= arg_679_1.time_ and arg_679_1.time_ < var_682_1 + var_682_3 then
				local var_682_4 = (arg_679_1.time_ - var_682_1) / var_682_3
				local var_682_5 = Mathf.Lerp(arg_679_1.var_.alphaOldValue10030, 0, var_682_4)

				if arg_679_1.var_.characterEffect10030 then
					arg_679_1.var_.characterEffect10030.alpha = var_682_5
				end
			end

			if arg_679_1.time_ >= var_682_1 + var_682_3 and arg_679_1.time_ < var_682_1 + var_682_3 + arg_682_0 and arg_679_1.var_.characterEffect10030 then
				arg_679_1.var_.characterEffect10030.alpha = 0
			end

			local var_682_6 = 0
			local var_682_7 = 0.575

			if var_682_6 < arg_679_1.time_ and arg_679_1.time_ <= var_682_6 + arg_682_0 then
				arg_679_1.talkMaxDuration = 0
				arg_679_1.dialogCg_.alpha = 1

				arg_679_1.dialog_:SetActive(true)
				SetActive(arg_679_1.leftNameGo_, false)

				arg_679_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_679_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_679_1:RecordName(arg_679_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_679_1.iconTrs_.gameObject, false)
				arg_679_1.callingController_:SetSelectedState("normal")

				local var_682_8 = arg_679_1:GetWordFromCfg(115281161)
				local var_682_9 = arg_679_1:FormatText(var_682_8.content)

				arg_679_1.text_.text = var_682_9

				LuaForUtil.ClearLinePrefixSymbol(arg_679_1.text_)

				local var_682_10 = 23
				local var_682_11 = utf8.len(var_682_9)
				local var_682_12 = var_682_10 <= 0 and var_682_7 or var_682_7 * (var_682_11 / var_682_10)

				if var_682_12 > 0 and var_682_7 < var_682_12 then
					arg_679_1.talkMaxDuration = var_682_12

					if var_682_12 + var_682_6 > arg_679_1.duration_ then
						arg_679_1.duration_ = var_682_12 + var_682_6
					end
				end

				arg_679_1.text_.text = var_682_9
				arg_679_1.typewritter.percent = 0

				arg_679_1.typewritter:SetDirty()
				arg_679_1:ShowNextGo(false)
				arg_679_1:RecordContent(arg_679_1.text_.text)
			end

			local var_682_13 = math.max(var_682_7, arg_679_1.talkMaxDuration)

			if var_682_6 <= arg_679_1.time_ and arg_679_1.time_ < var_682_6 + var_682_13 then
				arg_679_1.typewritter.percent = (arg_679_1.time_ - var_682_6) / var_682_13

				arg_679_1.typewritter:SetDirty()
			end

			if arg_679_1.time_ >= var_682_6 + var_682_13 and arg_679_1.time_ < var_682_6 + var_682_13 + arg_682_0 then
				arg_679_1.typewritter.percent = 1

				arg_679_1.typewritter:SetDirty()
				arg_679_1:ShowNextGo(true)
			end
		end

		arg_679_1.nodeConfigList_ = {}

		arg_679_1:InitPlayNodeList()
	end,
	Play115281162 = function(arg_683_0, arg_683_1)
		arg_683_1.time_ = 0
		arg_683_1.frameCnt_ = 0
		arg_683_1.state_ = "playing"
		arg_683_1.curTalkId_ = 115281162
		arg_683_1.duration_ = 5.03

		local var_683_0 = {
			ja = 5.033,
			ko = 3.733,
			zh = 4.466,
			en = 4.7
		}
		local var_683_1 = manager.audio:GetLocalizationFlag()

		if var_683_0[var_683_1] ~= nil then
			arg_683_1.duration_ = var_683_0[var_683_1]
		end

		SetActive(arg_683_1.tipsGo_, false)

		function arg_683_1.onSingleLineFinish_()
			arg_683_1.onSingleLineUpdate_ = nil
			arg_683_1.onSingleLineFinish_ = nil
			arg_683_1.state_ = "waiting"
		end

		function arg_683_1.playNext_(arg_685_0)
			if arg_685_0 == 1 then
				arg_683_0:Play115281163(arg_683_1)
			end
		end

		function arg_683_1.onSingleLineUpdate_(arg_686_0)
			local var_686_0 = arg_683_1.actors_["1038"].transform
			local var_686_1 = 0

			if var_686_1 < arg_683_1.time_ and arg_683_1.time_ <= var_686_1 + arg_686_0 then
				arg_683_1.var_.moveOldPos1038 = var_686_0.localPosition
				var_686_0.localScale = Vector3.New(1, 1, 1)

				arg_683_1:CheckSpriteTmpPos("1038", 2)

				local var_686_2 = var_686_0.childCount

				for iter_686_0 = 0, var_686_2 - 1 do
					local var_686_3 = var_686_0:GetChild(iter_686_0)

					if var_686_3.name == "split_9" or not string.find(var_686_3.name, "split") then
						var_686_3.gameObject:SetActive(true)
					else
						var_686_3.gameObject:SetActive(false)
					end
				end
			end

			local var_686_4 = 0.001

			if var_686_1 <= arg_683_1.time_ and arg_683_1.time_ < var_686_1 + var_686_4 then
				local var_686_5 = (arg_683_1.time_ - var_686_1) / var_686_4
				local var_686_6 = Vector3.New(-390, -400, 0)

				var_686_0.localPosition = Vector3.Lerp(arg_683_1.var_.moveOldPos1038, var_686_6, var_686_5)
			end

			if arg_683_1.time_ >= var_686_1 + var_686_4 and arg_683_1.time_ < var_686_1 + var_686_4 + arg_686_0 then
				var_686_0.localPosition = Vector3.New(-390, -400, 0)
			end

			local var_686_7 = arg_683_1.actors_["1038"]
			local var_686_8 = 0

			if var_686_8 < arg_683_1.time_ and arg_683_1.time_ <= var_686_8 + arg_686_0 then
				local var_686_9 = var_686_7:GetComponentInChildren(typeof(CanvasGroup))

				if var_686_9 then
					arg_683_1.var_.alphaOldValue1038 = var_686_9.alpha
					arg_683_1.var_.characterEffect1038 = var_686_9
				end

				arg_683_1.var_.alphaOldValue1038 = 0
			end

			local var_686_10 = 0.333333333333333

			if var_686_8 <= arg_683_1.time_ and arg_683_1.time_ < var_686_8 + var_686_10 then
				local var_686_11 = (arg_683_1.time_ - var_686_8) / var_686_10
				local var_686_12 = Mathf.Lerp(arg_683_1.var_.alphaOldValue1038, 1, var_686_11)

				if arg_683_1.var_.characterEffect1038 then
					arg_683_1.var_.characterEffect1038.alpha = var_686_12
				end
			end

			if arg_683_1.time_ >= var_686_8 + var_686_10 and arg_683_1.time_ < var_686_8 + var_686_10 + arg_686_0 and arg_683_1.var_.characterEffect1038 then
				arg_683_1.var_.characterEffect1038.alpha = 1
			end

			local var_686_13 = 0
			local var_686_14 = 0.375

			if var_686_13 < arg_683_1.time_ and arg_683_1.time_ <= var_686_13 + arg_686_0 then
				arg_683_1.talkMaxDuration = 0
				arg_683_1.dialogCg_.alpha = 1

				arg_683_1.dialog_:SetActive(true)
				SetActive(arg_683_1.leftNameGo_, true)

				local var_686_15 = arg_683_1:FormatText(StoryNameCfg[94].name)

				arg_683_1.leftNameTxt_.text = var_686_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_683_1.leftNameTxt_.transform)

				arg_683_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_683_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_683_1:RecordName(arg_683_1.leftNameTxt_.text)
				SetActive(arg_683_1.iconTrs_.gameObject, false)
				arg_683_1.callingController_:SetSelectedState("normal")

				local var_686_16 = arg_683_1:GetWordFromCfg(115281162)
				local var_686_17 = arg_683_1:FormatText(var_686_16.content)

				arg_683_1.text_.text = var_686_17

				LuaForUtil.ClearLinePrefixSymbol(arg_683_1.text_)

				local var_686_18 = 15
				local var_686_19 = utf8.len(var_686_17)
				local var_686_20 = var_686_18 <= 0 and var_686_14 or var_686_14 * (var_686_19 / var_686_18)

				if var_686_20 > 0 and var_686_14 < var_686_20 then
					arg_683_1.talkMaxDuration = var_686_20

					if var_686_20 + var_686_13 > arg_683_1.duration_ then
						arg_683_1.duration_ = var_686_20 + var_686_13
					end
				end

				arg_683_1.text_.text = var_686_17
				arg_683_1.typewritter.percent = 0

				arg_683_1.typewritter:SetDirty()
				arg_683_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115281", "115281162", "story_v_out_115281.awb") ~= 0 then
					local var_686_21 = manager.audio:GetVoiceLength("story_v_out_115281", "115281162", "story_v_out_115281.awb") / 1000

					if var_686_21 + var_686_13 > arg_683_1.duration_ then
						arg_683_1.duration_ = var_686_21 + var_686_13
					end

					if var_686_16.prefab_name ~= "" and arg_683_1.actors_[var_686_16.prefab_name] ~= nil then
						local var_686_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_683_1.actors_[var_686_16.prefab_name].transform, "story_v_out_115281", "115281162", "story_v_out_115281.awb")

						arg_683_1:RecordAudio("115281162", var_686_22)
						arg_683_1:RecordAudio("115281162", var_686_22)
					else
						arg_683_1:AudioAction("play", "voice", "story_v_out_115281", "115281162", "story_v_out_115281.awb")
					end

					arg_683_1:RecordHistoryTalkVoice("story_v_out_115281", "115281162", "story_v_out_115281.awb")
				end

				arg_683_1:RecordContent(arg_683_1.text_.text)
			end

			local var_686_23 = math.max(var_686_14, arg_683_1.talkMaxDuration)

			if var_686_13 <= arg_683_1.time_ and arg_683_1.time_ < var_686_13 + var_686_23 then
				arg_683_1.typewritter.percent = (arg_683_1.time_ - var_686_13) / var_686_23

				arg_683_1.typewritter:SetDirty()
			end

			if arg_683_1.time_ >= var_686_13 + var_686_23 and arg_683_1.time_ < var_686_13 + var_686_23 + arg_686_0 then
				arg_683_1.typewritter.percent = 1

				arg_683_1.typewritter:SetDirty()
				arg_683_1:ShowNextGo(true)
			end
		end

		arg_683_1.nodeConfigList_ = {
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

		arg_683_1:InitPlayNodeList()
	end,
	Play115281163 = function(arg_687_0, arg_687_1)
		arg_687_1.time_ = 0
		arg_687_1.frameCnt_ = 0
		arg_687_1.state_ = "playing"
		arg_687_1.curTalkId_ = 115281163
		arg_687_1.duration_ = 2.17

		local var_687_0 = {
			ja = 1.5,
			ko = 1.4,
			zh = 2.166,
			en = 1.6
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
				arg_687_0:Play115281164(arg_687_1)
			end
		end

		function arg_687_1.onSingleLineUpdate_(arg_690_0)
			local var_690_0 = arg_687_1.actors_["10030"].transform
			local var_690_1 = 0

			if var_690_1 < arg_687_1.time_ and arg_687_1.time_ <= var_690_1 + arg_690_0 then
				arg_687_1.var_.moveOldPos10030 = var_690_0.localPosition
				var_690_0.localScale = Vector3.New(1, 1, 1)

				arg_687_1:CheckSpriteTmpPos("10030", 4)

				local var_690_2 = var_690_0.childCount

				for iter_690_0 = 0, var_690_2 - 1 do
					local var_690_3 = var_690_0:GetChild(iter_690_0)

					if var_690_3.name == "split_3" or not string.find(var_690_3.name, "split") then
						var_690_3.gameObject:SetActive(true)
					else
						var_690_3.gameObject:SetActive(false)
					end
				end
			end

			local var_690_4 = 0.001

			if var_690_1 <= arg_687_1.time_ and arg_687_1.time_ < var_690_1 + var_690_4 then
				local var_690_5 = (arg_687_1.time_ - var_690_1) / var_690_4
				local var_690_6 = Vector3.New(390, -390, 150)

				var_690_0.localPosition = Vector3.Lerp(arg_687_1.var_.moveOldPos10030, var_690_6, var_690_5)
			end

			if arg_687_1.time_ >= var_690_1 + var_690_4 and arg_687_1.time_ < var_690_1 + var_690_4 + arg_690_0 then
				var_690_0.localPosition = Vector3.New(390, -390, 150)
			end

			local var_690_7 = arg_687_1.actors_["1038"]
			local var_690_8 = 0

			if var_690_8 < arg_687_1.time_ and arg_687_1.time_ <= var_690_8 + arg_690_0 and not isNil(var_690_7) and arg_687_1.var_.actorSpriteComps1038 == nil then
				arg_687_1.var_.actorSpriteComps1038 = var_690_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_690_9 = 0.2

			if var_690_8 <= arg_687_1.time_ and arg_687_1.time_ < var_690_8 + var_690_9 and not isNil(var_690_7) then
				local var_690_10 = (arg_687_1.time_ - var_690_8) / var_690_9

				if arg_687_1.var_.actorSpriteComps1038 then
					for iter_690_1, iter_690_2 in pairs(arg_687_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_690_2 then
							if arg_687_1.isInRecall_ then
								local var_690_11 = Mathf.Lerp(iter_690_2.color.r, arg_687_1.hightColor2.r, var_690_10)
								local var_690_12 = Mathf.Lerp(iter_690_2.color.g, arg_687_1.hightColor2.g, var_690_10)
								local var_690_13 = Mathf.Lerp(iter_690_2.color.b, arg_687_1.hightColor2.b, var_690_10)

								iter_690_2.color = Color.New(var_690_11, var_690_12, var_690_13)
							else
								local var_690_14 = Mathf.Lerp(iter_690_2.color.r, 0.5, var_690_10)

								iter_690_2.color = Color.New(var_690_14, var_690_14, var_690_14)
							end
						end
					end
				end
			end

			if arg_687_1.time_ >= var_690_8 + var_690_9 and arg_687_1.time_ < var_690_8 + var_690_9 + arg_690_0 and not isNil(var_690_7) and arg_687_1.var_.actorSpriteComps1038 then
				for iter_690_3, iter_690_4 in pairs(arg_687_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_690_4 then
						if arg_687_1.isInRecall_ then
							iter_690_4.color = arg_687_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_690_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_687_1.var_.actorSpriteComps1038 = nil
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

			local var_690_18 = 0.333333333333333

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
			local var_690_22 = 0.15

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

				local var_690_24 = arg_687_1:GetWordFromCfg(115281163)
				local var_690_25 = arg_687_1:FormatText(var_690_24.content)

				arg_687_1.text_.text = var_690_25

				LuaForUtil.ClearLinePrefixSymbol(arg_687_1.text_)

				local var_690_26 = 6
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

				if manager.audio:GetVoiceLength("story_v_out_115281", "115281163", "story_v_out_115281.awb") ~= 0 then
					local var_690_29 = manager.audio:GetVoiceLength("story_v_out_115281", "115281163", "story_v_out_115281.awb") / 1000

					if var_690_29 + var_690_21 > arg_687_1.duration_ then
						arg_687_1.duration_ = var_690_29 + var_690_21
					end

					if var_690_24.prefab_name ~= "" and arg_687_1.actors_[var_690_24.prefab_name] ~= nil then
						local var_690_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_687_1.actors_[var_690_24.prefab_name].transform, "story_v_out_115281", "115281163", "story_v_out_115281.awb")

						arg_687_1:RecordAudio("115281163", var_690_30)
						arg_687_1:RecordAudio("115281163", var_690_30)
					else
						arg_687_1:AudioAction("play", "voice", "story_v_out_115281", "115281163", "story_v_out_115281.awb")
					end

					arg_687_1:RecordHistoryTalkVoice("story_v_out_115281", "115281163", "story_v_out_115281.awb")
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
	Play115281164 = function(arg_691_0, arg_691_1)
		arg_691_1.time_ = 0
		arg_691_1.frameCnt_ = 0
		arg_691_1.state_ = "playing"
		arg_691_1.curTalkId_ = 115281164
		arg_691_1.duration_ = 5

		SetActive(arg_691_1.tipsGo_, false)

		function arg_691_1.onSingleLineFinish_()
			arg_691_1.onSingleLineUpdate_ = nil
			arg_691_1.onSingleLineFinish_ = nil
			arg_691_1.state_ = "waiting"
		end

		function arg_691_1.playNext_(arg_693_0)
			if arg_693_0 == 1 then
				arg_691_0:Play115281165(arg_691_1)
			end
		end

		function arg_691_1.onSingleLineUpdate_(arg_694_0)
			local var_694_0 = arg_691_1.actors_["10030"].transform
			local var_694_1 = 0.299333333333333

			if var_694_1 < arg_691_1.time_ and arg_691_1.time_ <= var_694_1 + arg_694_0 then
				arg_691_1.var_.moveOldPos10030 = var_694_0.localPosition
				var_694_0.localScale = Vector3.New(1, 1, 1)

				arg_691_1:CheckSpriteTmpPos("10030", 0)

				local var_694_2 = var_694_0.childCount

				for iter_694_0 = 0, var_694_2 - 1 do
					local var_694_3 = var_694_0:GetChild(iter_694_0)

					if var_694_3.name == "split_3" or not string.find(var_694_3.name, "split") then
						var_694_3.gameObject:SetActive(true)
					else
						var_694_3.gameObject:SetActive(false)
					end
				end
			end

			local var_694_4 = 0.001

			if var_694_1 <= arg_691_1.time_ and arg_691_1.time_ < var_694_1 + var_694_4 then
				local var_694_5 = (arg_691_1.time_ - var_694_1) / var_694_4
				local var_694_6 = Vector3.New(-1500, -350, -180)

				var_694_0.localPosition = Vector3.Lerp(arg_691_1.var_.moveOldPos10030, var_694_6, var_694_5)
			end

			if arg_691_1.time_ >= var_694_1 + var_694_4 and arg_691_1.time_ < var_694_1 + var_694_4 + arg_694_0 then
				var_694_0.localPosition = Vector3.New(-1500, -350, -180)
			end

			local var_694_7 = arg_691_1.actors_["1038"].transform
			local var_694_8 = 0.299333333333333

			if var_694_8 < arg_691_1.time_ and arg_691_1.time_ <= var_694_8 + arg_694_0 then
				arg_691_1.var_.moveOldPos1038 = var_694_7.localPosition
				var_694_7.localScale = Vector3.New(1, 1, 1)

				arg_691_1:CheckSpriteTmpPos("1038", 0)

				local var_694_9 = var_694_7.childCount

				for iter_694_1 = 0, var_694_9 - 1 do
					local var_694_10 = var_694_7:GetChild(iter_694_1)

					if var_694_10.name == "split_9" or not string.find(var_694_10.name, "split") then
						var_694_10.gameObject:SetActive(true)
					else
						var_694_10.gameObject:SetActive(false)
					end
				end
			end

			local var_694_11 = 0.001

			if var_694_8 <= arg_691_1.time_ and arg_691_1.time_ < var_694_8 + var_694_11 then
				local var_694_12 = (arg_691_1.time_ - var_694_8) / var_694_11
				local var_694_13 = Vector3.New(-1500, -350, -180)

				var_694_7.localPosition = Vector3.Lerp(arg_691_1.var_.moveOldPos1038, var_694_13, var_694_12)
			end

			if arg_691_1.time_ >= var_694_8 + var_694_11 and arg_691_1.time_ < var_694_8 + var_694_11 + arg_694_0 then
				var_694_7.localPosition = Vector3.New(-1500, -350, -180)
			end

			local var_694_14 = arg_691_1.actors_["10030"]
			local var_694_15 = 0

			if var_694_15 < arg_691_1.time_ and arg_691_1.time_ <= var_694_15 + arg_694_0 then
				local var_694_16 = var_694_14:GetComponentInChildren(typeof(CanvasGroup))

				if var_694_16 then
					arg_691_1.var_.alphaOldValue10030 = var_694_16.alpha
					arg_691_1.var_.characterEffect10030 = var_694_16
				end

				arg_691_1.var_.alphaOldValue10030 = 1
			end

			local var_694_17 = 0.333333333333333

			if var_694_15 <= arg_691_1.time_ and arg_691_1.time_ < var_694_15 + var_694_17 then
				local var_694_18 = (arg_691_1.time_ - var_694_15) / var_694_17
				local var_694_19 = Mathf.Lerp(arg_691_1.var_.alphaOldValue10030, 0, var_694_18)

				if arg_691_1.var_.characterEffect10030 then
					arg_691_1.var_.characterEffect10030.alpha = var_694_19
				end
			end

			if arg_691_1.time_ >= var_694_15 + var_694_17 and arg_691_1.time_ < var_694_15 + var_694_17 + arg_694_0 and arg_691_1.var_.characterEffect10030 then
				arg_691_1.var_.characterEffect10030.alpha = 0
			end

			local var_694_20 = arg_691_1.actors_["1038"]
			local var_694_21 = 0

			if var_694_21 < arg_691_1.time_ and arg_691_1.time_ <= var_694_21 + arg_694_0 then
				local var_694_22 = var_694_20:GetComponentInChildren(typeof(CanvasGroup))

				if var_694_22 then
					arg_691_1.var_.alphaOldValue1038 = var_694_22.alpha
					arg_691_1.var_.characterEffect1038 = var_694_22
				end

				arg_691_1.var_.alphaOldValue1038 = 1
			end

			local var_694_23 = 0.333333333333333

			if var_694_21 <= arg_691_1.time_ and arg_691_1.time_ < var_694_21 + var_694_23 then
				local var_694_24 = (arg_691_1.time_ - var_694_21) / var_694_23
				local var_694_25 = Mathf.Lerp(arg_691_1.var_.alphaOldValue1038, 0, var_694_24)

				if arg_691_1.var_.characterEffect1038 then
					arg_691_1.var_.characterEffect1038.alpha = var_694_25
				end
			end

			if arg_691_1.time_ >= var_694_21 + var_694_23 and arg_691_1.time_ < var_694_21 + var_694_23 + arg_694_0 and arg_691_1.var_.characterEffect1038 then
				arg_691_1.var_.characterEffect1038.alpha = 0
			end

			local var_694_26 = 0
			local var_694_27 = 0.75

			if var_694_26 < arg_691_1.time_ and arg_691_1.time_ <= var_694_26 + arg_694_0 then
				arg_691_1.talkMaxDuration = 0
				arg_691_1.dialogCg_.alpha = 1

				arg_691_1.dialog_:SetActive(true)
				SetActive(arg_691_1.leftNameGo_, false)

				arg_691_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_691_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_691_1:RecordName(arg_691_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_691_1.iconTrs_.gameObject, false)
				arg_691_1.callingController_:SetSelectedState("normal")

				local var_694_28 = arg_691_1:GetWordFromCfg(115281164)
				local var_694_29 = arg_691_1:FormatText(var_694_28.content)

				arg_691_1.text_.text = var_694_29

				LuaForUtil.ClearLinePrefixSymbol(arg_691_1.text_)

				local var_694_30 = 30
				local var_694_31 = utf8.len(var_694_29)
				local var_694_32 = var_694_30 <= 0 and var_694_27 or var_694_27 * (var_694_31 / var_694_30)

				if var_694_32 > 0 and var_694_27 < var_694_32 then
					arg_691_1.talkMaxDuration = var_694_32

					if var_694_32 + var_694_26 > arg_691_1.duration_ then
						arg_691_1.duration_ = var_694_32 + var_694_26
					end
				end

				arg_691_1.text_.text = var_694_29
				arg_691_1.typewritter.percent = 0

				arg_691_1.typewritter:SetDirty()
				arg_691_1:ShowNextGo(false)
				arg_691_1:RecordContent(arg_691_1.text_.text)
			end

			local var_694_33 = math.max(var_694_27, arg_691_1.talkMaxDuration)

			if var_694_26 <= arg_691_1.time_ and arg_691_1.time_ < var_694_26 + var_694_33 then
				arg_691_1.typewritter.percent = (arg_691_1.time_ - var_694_26) / var_694_33

				arg_691_1.typewritter:SetDirty()
			end

			if arg_691_1.time_ >= var_694_26 + var_694_33 and arg_691_1.time_ < var_694_26 + var_694_33 + arg_694_0 then
				arg_691_1.typewritter.percent = 1

				arg_691_1.typewritter:SetDirty()
				arg_691_1:ShowNextGo(true)
			end
		end

		arg_691_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10030",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0.299333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1038",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0.299333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_691_1:InitPlayNodeList()
	end,
	Play115281165 = function(arg_695_0, arg_695_1)
		arg_695_1.time_ = 0
		arg_695_1.frameCnt_ = 0
		arg_695_1.state_ = "playing"
		arg_695_1.curTalkId_ = 115281165
		arg_695_1.duration_ = 11.07

		local var_695_0 = {
			ja = 9.566,
			ko = 8.633,
			zh = 11.066,
			en = 9.1
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
			arg_695_1.auto_ = false
		end

		function arg_695_1.playNext_(arg_697_0)
			arg_695_1.onStoryFinished_()
		end

		function arg_695_1.onSingleLineUpdate_(arg_698_0)
			local var_698_0 = arg_695_1.actors_["10030"].transform
			local var_698_1 = 0

			if var_698_1 < arg_695_1.time_ and arg_695_1.time_ <= var_698_1 + arg_698_0 then
				arg_695_1.var_.moveOldPos10030 = var_698_0.localPosition
				var_698_0.localScale = Vector3.New(1, 1, 1)

				arg_695_1:CheckSpriteTmpPos("10030", 3)

				local var_698_2 = var_698_0.childCount

				for iter_698_0 = 0, var_698_2 - 1 do
					local var_698_3 = var_698_0:GetChild(iter_698_0)

					if var_698_3.name == "split_3" or not string.find(var_698_3.name, "split") then
						var_698_3.gameObject:SetActive(true)
					else
						var_698_3.gameObject:SetActive(false)
					end
				end
			end

			local var_698_4 = 0.001

			if var_698_1 <= arg_695_1.time_ and arg_695_1.time_ < var_698_1 + var_698_4 then
				local var_698_5 = (arg_695_1.time_ - var_698_1) / var_698_4
				local var_698_6 = Vector3.New(0, -390, 150)

				var_698_0.localPosition = Vector3.Lerp(arg_695_1.var_.moveOldPos10030, var_698_6, var_698_5)
			end

			if arg_695_1.time_ >= var_698_1 + var_698_4 and arg_695_1.time_ < var_698_1 + var_698_4 + arg_698_0 then
				var_698_0.localPosition = Vector3.New(0, -390, 150)
			end

			local var_698_7 = arg_695_1.actors_["10030"]
			local var_698_8 = 0

			if var_698_8 < arg_695_1.time_ and arg_695_1.time_ <= var_698_8 + arg_698_0 then
				local var_698_9 = var_698_7:GetComponentInChildren(typeof(CanvasGroup))

				if var_698_9 then
					arg_695_1.var_.alphaOldValue10030 = var_698_9.alpha
					arg_695_1.var_.characterEffect10030 = var_698_9
				end

				arg_695_1.var_.alphaOldValue10030 = 0
			end

			local var_698_10 = 0.333333333333333

			if var_698_8 <= arg_695_1.time_ and arg_695_1.time_ < var_698_8 + var_698_10 then
				local var_698_11 = (arg_695_1.time_ - var_698_8) / var_698_10
				local var_698_12 = Mathf.Lerp(arg_695_1.var_.alphaOldValue10030, 1, var_698_11)

				if arg_695_1.var_.characterEffect10030 then
					arg_695_1.var_.characterEffect10030.alpha = var_698_12
				end
			end

			if arg_695_1.time_ >= var_698_8 + var_698_10 and arg_695_1.time_ < var_698_8 + var_698_10 + arg_698_0 and arg_695_1.var_.characterEffect10030 then
				arg_695_1.var_.characterEffect10030.alpha = 1
			end

			local var_698_13 = 0
			local var_698_14 = 0.825

			if var_698_13 < arg_695_1.time_ and arg_695_1.time_ <= var_698_13 + arg_698_0 then
				arg_695_1.talkMaxDuration = 0
				arg_695_1.dialogCg_.alpha = 1

				arg_695_1.dialog_:SetActive(true)
				SetActive(arg_695_1.leftNameGo_, true)

				local var_698_15 = arg_695_1:FormatText(StoryNameCfg[309].name)

				arg_695_1.leftNameTxt_.text = var_698_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_695_1.leftNameTxt_.transform)

				arg_695_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_695_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_695_1:RecordName(arg_695_1.leftNameTxt_.text)
				SetActive(arg_695_1.iconTrs_.gameObject, false)
				arg_695_1.callingController_:SetSelectedState("normal")

				local var_698_16 = arg_695_1:GetWordFromCfg(115281165)
				local var_698_17 = arg_695_1:FormatText(var_698_16.content)

				arg_695_1.text_.text = var_698_17

				LuaForUtil.ClearLinePrefixSymbol(arg_695_1.text_)

				local var_698_18 = 33
				local var_698_19 = utf8.len(var_698_17)
				local var_698_20 = var_698_18 <= 0 and var_698_14 or var_698_14 * (var_698_19 / var_698_18)

				if var_698_20 > 0 and var_698_14 < var_698_20 then
					arg_695_1.talkMaxDuration = var_698_20

					if var_698_20 + var_698_13 > arg_695_1.duration_ then
						arg_695_1.duration_ = var_698_20 + var_698_13
					end
				end

				arg_695_1.text_.text = var_698_17
				arg_695_1.typewritter.percent = 0

				arg_695_1.typewritter:SetDirty()
				arg_695_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115281", "115281165", "story_v_out_115281.awb") ~= 0 then
					local var_698_21 = manager.audio:GetVoiceLength("story_v_out_115281", "115281165", "story_v_out_115281.awb") / 1000

					if var_698_21 + var_698_13 > arg_695_1.duration_ then
						arg_695_1.duration_ = var_698_21 + var_698_13
					end

					if var_698_16.prefab_name ~= "" and arg_695_1.actors_[var_698_16.prefab_name] ~= nil then
						local var_698_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_695_1.actors_[var_698_16.prefab_name].transform, "story_v_out_115281", "115281165", "story_v_out_115281.awb")

						arg_695_1:RecordAudio("115281165", var_698_22)
						arg_695_1:RecordAudio("115281165", var_698_22)
					else
						arg_695_1:AudioAction("play", "voice", "story_v_out_115281", "115281165", "story_v_out_115281.awb")
					end

					arg_695_1:RecordHistoryTalkVoice("story_v_out_115281", "115281165", "story_v_out_115281.awb")
				end

				arg_695_1:RecordContent(arg_695_1.text_.text)
			end

			local var_698_23 = math.max(var_698_14, arg_695_1.talkMaxDuration)

			if var_698_13 <= arg_695_1.time_ and arg_695_1.time_ < var_698_13 + var_698_23 then
				arg_695_1.typewritter.percent = (arg_695_1.time_ - var_698_13) / var_698_23

				arg_695_1.typewritter:SetDirty()
			end

			if arg_695_1.time_ >= var_698_13 + var_698_23 and arg_695_1.time_ < var_698_13 + var_698_23 + arg_698_0 then
				arg_695_1.typewritter.percent = 1

				arg_695_1.typewritter:SetDirty()
				arg_695_1:ShowNextGo(true)
			end
		end

		arg_695_1.nodeConfigList_ = {
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

		arg_695_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/D999",
		"TextureConfig/Background/ST27",
		"TextureConfig/Background/ST28a",
		"TextureConfig/Background/RO0501"
	},
	voices = {
		"story_v_out_115281.awb"
	}
}
