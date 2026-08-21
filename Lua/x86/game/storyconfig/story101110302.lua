return {
	Play111032001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 111032001
		arg_1_1.duration_ = 6.5

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play111032002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "D05"

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
				local var_4_5 = arg_1_1.bgs_.D05

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
					if iter_4_0 ~= "D05" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = arg_1_1.bgs_.D05
			local var_4_17 = 0

			if var_4_17 < arg_1_1.time_ and arg_1_1.time_ <= var_4_17 + arg_4_0 then
				local var_4_18 = var_4_16:GetComponent("SpriteRenderer")

				if var_4_18 then
					arg_1_1.var_.alphaOldValueD05 = var_4_18.color.a
					arg_1_1.var_.alphaMatValueD05 = var_4_18
				end
			end

			local var_4_19 = 1.5

			if var_4_17 <= arg_1_1.time_ and arg_1_1.time_ < var_4_17 + var_4_19 then
				local var_4_20 = (arg_1_1.time_ - var_4_17) / var_4_19
				local var_4_21 = Mathf.Lerp(arg_1_1.var_.alphaOldValueD05, 0.5, var_4_20)

				if arg_1_1.var_.alphaMatValueD05 then
					local var_4_22 = arg_1_1.var_.alphaMatValueD05.color

					var_4_22.a = var_4_21
					arg_1_1.var_.alphaMatValueD05.color = var_4_22
				end
			end

			if arg_1_1.time_ >= var_4_17 + var_4_19 and arg_1_1.time_ < var_4_17 + var_4_19 + arg_4_0 and arg_1_1.var_.alphaMatValueD05 then
				local var_4_23 = arg_1_1.var_.alphaMatValueD05
				local var_4_24 = var_4_23.color

				var_4_24.a = 0.5
				var_4_23.color = var_4_24
			end

			local var_4_25 = 0

			if var_4_25 < arg_1_1.time_ and arg_1_1.time_ <= var_4_25 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_26 = 1.5

			if var_4_25 <= arg_1_1.time_ and arg_1_1.time_ < var_4_25 + var_4_26 then
				local var_4_27 = (arg_1_1.time_ - var_4_25) / var_4_26
				local var_4_28 = Color.New(1, 1, 1)

				var_4_28.a = Mathf.Lerp(1, 0, var_4_27)
				arg_1_1.mask_.color = var_4_28
			end

			if arg_1_1.time_ >= var_4_25 + var_4_26 and arg_1_1.time_ < var_4_25 + var_4_26 + arg_4_0 then
				local var_4_29 = Color.New(1, 1, 1)
				local var_4_30 = 0

				arg_1_1.mask_.enabled = false
				var_4_29.a = var_4_30
				arg_1_1.mask_.color = var_4_29
			end

			local var_4_31 = 0

			if var_4_31 < arg_1_1.time_ and arg_1_1.time_ <= var_4_31 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			local var_4_32 = 1.5

			if arg_1_1.time_ >= var_4_31 + var_4_32 and arg_1_1.time_ < var_4_31 + var_4_32 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_33 = 0
			local var_4_34 = 1

			if var_4_33 < arg_1_1.time_ and arg_1_1.time_ <= var_4_33 + arg_4_0 then
				local var_4_35 = "play"
				local var_4_36 = "music"

				arg_1_1:AudioAction(var_4_35, var_4_36, "bgm_activity_1_1_hel_story", "bgm_activity_1_1_hel_story", "bgm_activity_1_1_hel_story.awb")

				local var_4_37 = ""
				local var_4_38 = manager.audio:GetAudioName("bgm_activity_1_1_hel_story", "bgm_activity_1_1_hel_story")

				if var_4_38 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_38 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_38

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_38
						arg_1_1.bgmTxt2_.text = var_4_38
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

			local var_4_39 = 1.5
			local var_4_40 = 0.1

			if var_4_39 < arg_1_1.time_ and arg_1_1.time_ <= var_4_39 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_41 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_41:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_41:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_41:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_42 = arg_1_1:GetWordFromCfg(111032001)
				local var_4_43 = arg_1_1:FormatText(var_4_42.content)

				arg_1_1.text_.text = var_4_43

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_44 = 4
				local var_4_45 = utf8.len(var_4_43)
				local var_4_46 = var_4_44 <= 0 and var_4_40 or var_4_40 * (var_4_45 / var_4_44)

				if var_4_46 > 0 and var_4_40 < var_4_46 then
					arg_1_1.talkMaxDuration = var_4_46
					var_4_39 = var_4_39 + 0.3

					if var_4_46 + var_4_39 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_46 + var_4_39
					end
				end

				arg_1_1.text_.text = var_4_43
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_47 = var_4_39 + 0.3
			local var_4_48 = math.max(var_4_40, arg_1_1.talkMaxDuration)

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
	Play111032002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 111032002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play111032003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 0
			local var_11_1 = 1.15

			if var_11_0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_0 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, false)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_2 = arg_8_1:GetWordFromCfg(111032002)
				local var_11_3 = arg_8_1:FormatText(var_11_2.content)

				arg_8_1.text_.text = var_11_3

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_4 = 46
				local var_11_5 = utf8.len(var_11_3)
				local var_11_6 = var_11_4 <= 0 and var_11_1 or var_11_1 * (var_11_5 / var_11_4)

				if var_11_6 > 0 and var_11_1 < var_11_6 then
					arg_8_1.talkMaxDuration = var_11_6

					if var_11_6 + var_11_0 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_6 + var_11_0
					end
				end

				arg_8_1.text_.text = var_11_3
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)
				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_7 = math.max(var_11_1, arg_8_1.talkMaxDuration)

			if var_11_0 <= arg_8_1.time_ and arg_8_1.time_ < var_11_0 + var_11_7 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_0) / var_11_7

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_0 + var_11_7 and arg_8_1.time_ < var_11_0 + var_11_7 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play111032003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 111032003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play111032004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = 0
			local var_15_1 = 0.925

			if var_15_0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_0 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, false)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_2 = arg_12_1:GetWordFromCfg(111032003)
				local var_15_3 = arg_12_1:FormatText(var_15_2.content)

				arg_12_1.text_.text = var_15_3

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_4 = 37
				local var_15_5 = utf8.len(var_15_3)
				local var_15_6 = var_15_4 <= 0 and var_15_1 or var_15_1 * (var_15_5 / var_15_4)

				if var_15_6 > 0 and var_15_1 < var_15_6 then
					arg_12_1.talkMaxDuration = var_15_6

					if var_15_6 + var_15_0 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_6 + var_15_0
					end
				end

				arg_12_1.text_.text = var_15_3
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)
				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_7 = math.max(var_15_1, arg_12_1.talkMaxDuration)

			if var_15_0 <= arg_12_1.time_ and arg_12_1.time_ < var_15_0 + var_15_7 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_0) / var_15_7

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_0 + var_15_7 and arg_12_1.time_ < var_15_0 + var_15_7 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play111032004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 111032004
		arg_16_1.duration_ = 5

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play111032005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = 0
			local var_19_1 = 0.45

			if var_19_0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_0 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				local var_19_2 = arg_16_1:FormatText(StoryNameCfg[7].name)

				arg_16_1.leftNameTxt_.text = var_19_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, true)
				arg_16_1.iconController_:SetSelectedState("hero")

				arg_16_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_16_1.callingController_:SetSelectedState("normal")

				arg_16_1.keyicon_.color = Color.New(1, 1, 1)
				arg_16_1.icon_.color = Color.New(1, 1, 1)

				local var_19_3 = arg_16_1:GetWordFromCfg(111032004)
				local var_19_4 = arg_16_1:FormatText(var_19_3.content)

				arg_16_1.text_.text = var_19_4

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_5 = 18
				local var_19_6 = utf8.len(var_19_4)
				local var_19_7 = var_19_5 <= 0 and var_19_1 or var_19_1 * (var_19_6 / var_19_5)

				if var_19_7 > 0 and var_19_1 < var_19_7 then
					arg_16_1.talkMaxDuration = var_19_7

					if var_19_7 + var_19_0 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_7 + var_19_0
					end
				end

				arg_16_1.text_.text = var_19_4
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)
				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_8 = math.max(var_19_1, arg_16_1.talkMaxDuration)

			if var_19_0 <= arg_16_1.time_ and arg_16_1.time_ < var_19_0 + var_19_8 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_0) / var_19_8

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_0 + var_19_8 and arg_16_1.time_ < var_19_0 + var_19_8 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {}

		arg_16_1:InitPlayNodeList()
	end,
	Play111032005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 111032005
		arg_20_1.duration_ = 5

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play111032006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = 0
			local var_23_1 = 1.175

			if var_23_0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_0 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, false)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_2 = arg_20_1:GetWordFromCfg(111032005)
				local var_23_3 = arg_20_1:FormatText(var_23_2.content)

				arg_20_1.text_.text = var_23_3

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_4 = 47
				local var_23_5 = utf8.len(var_23_3)
				local var_23_6 = var_23_4 <= 0 and var_23_1 or var_23_1 * (var_23_5 / var_23_4)

				if var_23_6 > 0 and var_23_1 < var_23_6 then
					arg_20_1.talkMaxDuration = var_23_6

					if var_23_6 + var_23_0 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_6 + var_23_0
					end
				end

				arg_20_1.text_.text = var_23_3
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)
				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_7 = math.max(var_23_1, arg_20_1.talkMaxDuration)

			if var_23_0 <= arg_20_1.time_ and arg_20_1.time_ < var_23_0 + var_23_7 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_0) / var_23_7

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_0 + var_23_7 and arg_20_1.time_ < var_23_0 + var_23_7 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play111032006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 111032006
		arg_24_1.duration_ = 5

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play111032007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = 0
			local var_27_1 = 0.25

			if var_27_0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_0 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				local var_27_2 = arg_24_1:FormatText(StoryNameCfg[7].name)

				arg_24_1.leftNameTxt_.text = var_27_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, true)
				arg_24_1.iconController_:SetSelectedState("hero")

				arg_24_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_24_1.callingController_:SetSelectedState("normal")

				arg_24_1.keyicon_.color = Color.New(1, 1, 1)
				arg_24_1.icon_.color = Color.New(1, 1, 1)

				local var_27_3 = arg_24_1:GetWordFromCfg(111032006)
				local var_27_4 = arg_24_1:FormatText(var_27_3.content)

				arg_24_1.text_.text = var_27_4

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_5 = 10
				local var_27_6 = utf8.len(var_27_4)
				local var_27_7 = var_27_5 <= 0 and var_27_1 or var_27_1 * (var_27_6 / var_27_5)

				if var_27_7 > 0 and var_27_1 < var_27_7 then
					arg_24_1.talkMaxDuration = var_27_7

					if var_27_7 + var_27_0 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_7 + var_27_0
					end
				end

				arg_24_1.text_.text = var_27_4
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)
				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_8 = math.max(var_27_1, arg_24_1.talkMaxDuration)

			if var_27_0 <= arg_24_1.time_ and arg_24_1.time_ < var_27_0 + var_27_8 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_0) / var_27_8

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_0 + var_27_8 and arg_24_1.time_ < var_27_0 + var_27_8 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play111032007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 111032007
		arg_28_1.duration_ = 5

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play111032008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = 0
			local var_31_1 = 0.25

			if var_31_0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_0 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				local var_31_2 = arg_28_1:FormatText(StoryNameCfg[7].name)

				arg_28_1.leftNameTxt_.text = var_31_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, true)
				arg_28_1.iconController_:SetSelectedState("hero")

				arg_28_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_28_1.callingController_:SetSelectedState("normal")

				arg_28_1.keyicon_.color = Color.New(1, 1, 1)
				arg_28_1.icon_.color = Color.New(1, 1, 1)

				local var_31_3 = arg_28_1:GetWordFromCfg(111032007)
				local var_31_4 = arg_28_1:FormatText(var_31_3.content)

				arg_28_1.text_.text = var_31_4

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_5 = 10
				local var_31_6 = utf8.len(var_31_4)
				local var_31_7 = var_31_5 <= 0 and var_31_1 or var_31_1 * (var_31_6 / var_31_5)

				if var_31_7 > 0 and var_31_1 < var_31_7 then
					arg_28_1.talkMaxDuration = var_31_7

					if var_31_7 + var_31_0 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_7 + var_31_0
					end
				end

				arg_28_1.text_.text = var_31_4
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)
				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_8 = math.max(var_31_1, arg_28_1.talkMaxDuration)

			if var_31_0 <= arg_28_1.time_ and arg_28_1.time_ < var_31_0 + var_31_8 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_0) / var_31_8

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_0 + var_31_8 and arg_28_1.time_ < var_31_0 + var_31_8 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play111032008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 111032008
		arg_32_1.duration_ = 9.1

		local var_32_0 = {
			ja = 4.133,
			ko = 6.166,
			zh = 9.1,
			en = 6.133
		}
		local var_32_1 = manager.audio:GetLocalizationFlag()

		if var_32_0[var_32_1] ~= nil then
			arg_32_1.duration_ = var_32_0[var_32_1]
		end

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play111032009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = manager.ui.mainCamera.transform
			local var_35_1 = 0

			if var_35_1 < arg_32_1.time_ and arg_32_1.time_ <= var_35_1 + arg_35_0 then
				arg_32_1.var_.shakeOldPos = var_35_0.localPosition
			end

			local var_35_2 = 0.3

			if var_35_1 <= arg_32_1.time_ and arg_32_1.time_ < var_35_1 + var_35_2 then
				local var_35_3 = (arg_32_1.time_ - var_35_1) / 0.099
				local var_35_4, var_35_5 = math.modf(var_35_3)

				var_35_0.localPosition = Vector3.New(var_35_5 * 0.13, var_35_5 * 0.13, var_35_5 * 0.13) + arg_32_1.var_.shakeOldPos
			end

			if arg_32_1.time_ >= var_35_1 + var_35_2 and arg_32_1.time_ < var_35_1 + var_35_2 + arg_35_0 then
				var_35_0.localPosition = arg_32_1.var_.shakeOldPos
			end

			local var_35_6 = 0
			local var_35_7 = 0.725

			if var_35_6 < arg_32_1.time_ and arg_32_1.time_ <= var_35_6 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				local var_35_8 = arg_32_1:FormatText(StoryNameCfg[36].name)

				arg_32_1.leftNameTxt_.text = var_35_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_9 = arg_32_1:GetWordFromCfg(111032008)
				local var_35_10 = arg_32_1:FormatText(var_35_9.content)

				arg_32_1.text_.text = var_35_10

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_11 = 29
				local var_35_12 = utf8.len(var_35_10)
				local var_35_13 = var_35_11 <= 0 and var_35_7 or var_35_7 * (var_35_12 / var_35_11)

				if var_35_13 > 0 and var_35_7 < var_35_13 then
					arg_32_1.talkMaxDuration = var_35_13

					if var_35_13 + var_35_6 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_13 + var_35_6
					end
				end

				arg_32_1.text_.text = var_35_10
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111032", "111032008", "story_v_out_111032.awb") ~= 0 then
					local var_35_14 = manager.audio:GetVoiceLength("story_v_out_111032", "111032008", "story_v_out_111032.awb") / 1000

					if var_35_14 + var_35_6 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_14 + var_35_6
					end

					if var_35_9.prefab_name ~= "" and arg_32_1.actors_[var_35_9.prefab_name] ~= nil then
						local var_35_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_9.prefab_name].transform, "story_v_out_111032", "111032008", "story_v_out_111032.awb")

						arg_32_1:RecordAudio("111032008", var_35_15)
						arg_32_1:RecordAudio("111032008", var_35_15)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_111032", "111032008", "story_v_out_111032.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_111032", "111032008", "story_v_out_111032.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_16 = math.max(var_35_7, arg_32_1.talkMaxDuration)

			if var_35_6 <= arg_32_1.time_ and arg_32_1.time_ < var_35_6 + var_35_16 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_6) / var_35_16

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_6 + var_35_16 and arg_32_1.time_ < var_35_6 + var_35_16 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play111032009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 111032009
		arg_36_1.duration_ = 5

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play111032010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = 0
			local var_39_1 = 1.4

			if var_39_0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_0 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, false)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_2 = arg_36_1:GetWordFromCfg(111032009)
				local var_39_3 = arg_36_1:FormatText(var_39_2.content)

				arg_36_1.text_.text = var_39_3

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_4 = 56
				local var_39_5 = utf8.len(var_39_3)
				local var_39_6 = var_39_4 <= 0 and var_39_1 or var_39_1 * (var_39_5 / var_39_4)

				if var_39_6 > 0 and var_39_1 < var_39_6 then
					arg_36_1.talkMaxDuration = var_39_6

					if var_39_6 + var_39_0 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_6 + var_39_0
					end
				end

				arg_36_1.text_.text = var_39_3
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)
				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_7 = math.max(var_39_1, arg_36_1.talkMaxDuration)

			if var_39_0 <= arg_36_1.time_ and arg_36_1.time_ < var_39_0 + var_39_7 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_0) / var_39_7

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_0 + var_39_7 and arg_36_1.time_ < var_39_0 + var_39_7 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play111032010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 111032010
		arg_40_1.duration_ = 7.7

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play111032011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = "AS0101"

			if arg_40_1.bgs_[var_43_0] == nil then
				local var_43_1 = Object.Instantiate(arg_40_1.paintGo_)

				var_43_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_43_0)
				var_43_1.name = var_43_0
				var_43_1.transform.parent = arg_40_1.stage_.transform
				var_43_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_40_1.bgs_[var_43_0] = var_43_1
			end

			local var_43_2 = 0

			if var_43_2 < arg_40_1.time_ and arg_40_1.time_ <= var_43_2 + arg_43_0 then
				local var_43_3 = manager.ui.mainCamera.transform.localPosition
				local var_43_4 = Vector3.New(0, 0, 10) + Vector3.New(var_43_3.x, var_43_3.y, 0)
				local var_43_5 = arg_40_1.bgs_.AS0101

				var_43_5.transform.localPosition = var_43_4
				var_43_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_43_6 = var_43_5:GetComponent("SpriteRenderer")

				if var_43_6 and var_43_6.sprite then
					local var_43_7 = (var_43_5.transform.localPosition - var_43_3).z
					local var_43_8 = manager.ui.mainCameraCom_
					local var_43_9 = 2 * var_43_7 * Mathf.Tan(var_43_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_43_10 = var_43_9 * var_43_8.aspect
					local var_43_11 = var_43_6.sprite.bounds.size.x
					local var_43_12 = var_43_6.sprite.bounds.size.y
					local var_43_13 = var_43_10 / var_43_11
					local var_43_14 = var_43_9 / var_43_12
					local var_43_15 = var_43_14 < var_43_13 and var_43_13 or var_43_14

					var_43_5.transform.localScale = Vector3.New(var_43_15, var_43_15, 0)
				end

				for iter_43_0, iter_43_1 in pairs(arg_40_1.bgs_) do
					if iter_43_0 ~= "AS0101" then
						iter_43_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_43_16 = 0

			if var_43_16 < arg_40_1.time_ and arg_40_1.time_ <= var_43_16 + arg_43_0 then
				arg_40_1.mask_.enabled = true
				arg_40_1.mask_.raycastTarget = true

				arg_40_1:SetGaussion(false)
			end

			local var_43_17 = 2.7

			if var_43_16 <= arg_40_1.time_ and arg_40_1.time_ < var_43_16 + var_43_17 then
				local var_43_18 = (arg_40_1.time_ - var_43_16) / var_43_17
				local var_43_19 = Color.New(1, 1, 1)

				var_43_19.a = Mathf.Lerp(1, 0, var_43_18)
				arg_40_1.mask_.color = var_43_19
			end

			if arg_40_1.time_ >= var_43_16 + var_43_17 and arg_40_1.time_ < var_43_16 + var_43_17 + arg_43_0 then
				local var_43_20 = Color.New(1, 1, 1)
				local var_43_21 = 0

				arg_40_1.mask_.enabled = false
				var_43_20.a = var_43_21
				arg_40_1.mask_.color = var_43_20
			end

			local var_43_22 = 0

			if var_43_22 < arg_40_1.time_ and arg_40_1.time_ <= var_43_22 + arg_43_0 then
				arg_40_1.allBtn_.enabled = false
			end

			local var_43_23 = 2.7

			if arg_40_1.time_ >= var_43_22 + var_43_23 and arg_40_1.time_ < var_43_22 + var_43_23 + arg_43_0 then
				arg_40_1.allBtn_.enabled = true
			end

			if arg_40_1.frameCnt_ <= 1 then
				arg_40_1.dialog_:SetActive(false)
			end

			local var_43_24 = 2.7
			local var_43_25 = 1.8

			if var_43_24 < arg_40_1.time_ and arg_40_1.time_ <= var_43_24 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0

				arg_40_1.dialog_:SetActive(true)

				arg_40_1.dialogCg_.alpha = 0

				local var_43_26 = LeanTween.value(arg_40_1.dialog_, 0, 1, 0.3)

				var_43_26:setOnUpdate(LuaHelper.FloatAction(function(arg_44_0)
					arg_40_1.dialogCg_.alpha = arg_44_0
				end))
				var_43_26:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_40_1.dialog_)
					var_43_26:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_40_1.duration_ = arg_40_1.duration_ + 0.3

				SetActive(arg_40_1.leftNameGo_, false)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_27 = arg_40_1:GetWordFromCfg(111032010)
				local var_43_28 = arg_40_1:FormatText(var_43_27.content)

				arg_40_1.text_.text = var_43_28

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_29 = 72
				local var_43_30 = utf8.len(var_43_28)
				local var_43_31 = var_43_29 <= 0 and var_43_25 or var_43_25 * (var_43_30 / var_43_29)

				if var_43_31 > 0 and var_43_25 < var_43_31 then
					arg_40_1.talkMaxDuration = var_43_31
					var_43_24 = var_43_24 + 0.3

					if var_43_31 + var_43_24 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_31 + var_43_24
					end
				end

				arg_40_1.text_.text = var_43_28
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)
				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_32 = var_43_24 + 0.3
			local var_43_33 = math.max(var_43_25, arg_40_1.talkMaxDuration)

			if var_43_32 <= arg_40_1.time_ and arg_40_1.time_ < var_43_32 + var_43_33 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_32) / var_43_33

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_32 + var_43_33 and arg_40_1.time_ < var_43_32 + var_43_33 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play111032011 = function(arg_46_0, arg_46_1)
		arg_46_1.time_ = 0
		arg_46_1.frameCnt_ = 0
		arg_46_1.state_ = "playing"
		arg_46_1.curTalkId_ = 111032011
		arg_46_1.duration_ = 5

		SetActive(arg_46_1.tipsGo_, false)

		function arg_46_1.onSingleLineFinish_()
			arg_46_1.onSingleLineUpdate_ = nil
			arg_46_1.onSingleLineFinish_ = nil
			arg_46_1.state_ = "waiting"
		end

		function arg_46_1.playNext_(arg_48_0)
			if arg_48_0 == 1 then
				arg_46_0:Play111032012(arg_46_1)
			end
		end

		function arg_46_1.onSingleLineUpdate_(arg_49_0)
			local var_49_0 = 0
			local var_49_1 = 1.45

			if var_49_0 < arg_46_1.time_ and arg_46_1.time_ <= var_49_0 + arg_49_0 then
				arg_46_1.talkMaxDuration = 0
				arg_46_1.dialogCg_.alpha = 1

				arg_46_1.dialog_:SetActive(true)
				SetActive(arg_46_1.leftNameGo_, false)

				arg_46_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_46_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_46_1:RecordName(arg_46_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_46_1.iconTrs_.gameObject, false)
				arg_46_1.callingController_:SetSelectedState("normal")

				local var_49_2 = arg_46_1:GetWordFromCfg(111032011)
				local var_49_3 = arg_46_1:FormatText(var_49_2.content)

				arg_46_1.text_.text = var_49_3

				LuaForUtil.ClearLinePrefixSymbol(arg_46_1.text_)

				local var_49_4 = 58
				local var_49_5 = utf8.len(var_49_3)
				local var_49_6 = var_49_4 <= 0 and var_49_1 or var_49_1 * (var_49_5 / var_49_4)

				if var_49_6 > 0 and var_49_1 < var_49_6 then
					arg_46_1.talkMaxDuration = var_49_6

					if var_49_6 + var_49_0 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_6 + var_49_0
					end
				end

				arg_46_1.text_.text = var_49_3
				arg_46_1.typewritter.percent = 0

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(false)
				arg_46_1:RecordContent(arg_46_1.text_.text)
			end

			local var_49_7 = math.max(var_49_1, arg_46_1.talkMaxDuration)

			if var_49_0 <= arg_46_1.time_ and arg_46_1.time_ < var_49_0 + var_49_7 then
				arg_46_1.typewritter.percent = (arg_46_1.time_ - var_49_0) / var_49_7

				arg_46_1.typewritter:SetDirty()
			end

			if arg_46_1.time_ >= var_49_0 + var_49_7 and arg_46_1.time_ < var_49_0 + var_49_7 + arg_49_0 then
				arg_46_1.typewritter.percent = 1

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(true)
			end
		end

		arg_46_1.nodeConfigList_ = {}

		arg_46_1:InitPlayNodeList()
	end,
	Play111032012 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 111032012
		arg_50_1.duration_ = 11.8

		local var_50_0 = {
			ja = 3.466,
			ko = 8.4,
			zh = 11.8,
			en = 5.033
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
				arg_50_0:Play111032013(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			local var_53_0 = 0
			local var_53_1 = 0.425

			if var_53_0 < arg_50_1.time_ and arg_50_1.time_ <= var_53_0 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0
				arg_50_1.dialogCg_.alpha = 1

				arg_50_1.dialog_:SetActive(true)
				SetActive(arg_50_1.leftNameGo_, true)

				local var_53_2 = arg_50_1:FormatText(StoryNameCfg[36].name)

				arg_50_1.leftNameTxt_.text = var_53_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_50_1.leftNameTxt_.transform)

				arg_50_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_50_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_50_1:RecordName(arg_50_1.leftNameTxt_.text)
				SetActive(arg_50_1.iconTrs_.gameObject, true)
				arg_50_1.iconController_:SetSelectedState("hero")

				arg_50_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_woundedb")

				arg_50_1.callingController_:SetSelectedState("normal")

				arg_50_1.keyicon_.color = Color.New(1, 1, 1)
				arg_50_1.icon_.color = Color.New(1, 1, 1)

				local var_53_3 = arg_50_1:GetWordFromCfg(111032012)
				local var_53_4 = arg_50_1:FormatText(var_53_3.content)

				arg_50_1.text_.text = var_53_4

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_5 = 17
				local var_53_6 = utf8.len(var_53_4)
				local var_53_7 = var_53_5 <= 0 and var_53_1 or var_53_1 * (var_53_6 / var_53_5)

				if var_53_7 > 0 and var_53_1 < var_53_7 then
					arg_50_1.talkMaxDuration = var_53_7

					if var_53_7 + var_53_0 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_7 + var_53_0
					end
				end

				arg_50_1.text_.text = var_53_4
				arg_50_1.typewritter.percent = 0

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111032", "111032012", "story_v_out_111032.awb") ~= 0 then
					local var_53_8 = manager.audio:GetVoiceLength("story_v_out_111032", "111032012", "story_v_out_111032.awb") / 1000

					if var_53_8 + var_53_0 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_8 + var_53_0
					end

					if var_53_3.prefab_name ~= "" and arg_50_1.actors_[var_53_3.prefab_name] ~= nil then
						local var_53_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_50_1.actors_[var_53_3.prefab_name].transform, "story_v_out_111032", "111032012", "story_v_out_111032.awb")

						arg_50_1:RecordAudio("111032012", var_53_9)
						arg_50_1:RecordAudio("111032012", var_53_9)
					else
						arg_50_1:AudioAction("play", "voice", "story_v_out_111032", "111032012", "story_v_out_111032.awb")
					end

					arg_50_1:RecordHistoryTalkVoice("story_v_out_111032", "111032012", "story_v_out_111032.awb")
				end

				arg_50_1:RecordContent(arg_50_1.text_.text)
			end

			local var_53_10 = math.max(var_53_1, arg_50_1.talkMaxDuration)

			if var_53_0 <= arg_50_1.time_ and arg_50_1.time_ < var_53_0 + var_53_10 then
				arg_50_1.typewritter.percent = (arg_50_1.time_ - var_53_0) / var_53_10

				arg_50_1.typewritter:SetDirty()
			end

			if arg_50_1.time_ >= var_53_0 + var_53_10 and arg_50_1.time_ < var_53_0 + var_53_10 + arg_53_0 then
				arg_50_1.typewritter.percent = 1

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(true)
			end
		end

		arg_50_1.nodeConfigList_ = {}

		arg_50_1:InitPlayNodeList()
	end,
	Play111032013 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 111032013
		arg_54_1.duration_ = 2.77

		local var_54_0 = {
			ja = 1.166,
			ko = 1.9,
			zh = 2.533,
			en = 2.766
		}
		local var_54_1 = manager.audio:GetLocalizationFlag()

		if var_54_0[var_54_1] ~= nil then
			arg_54_1.duration_ = var_54_0[var_54_1]
		end

		SetActive(arg_54_1.tipsGo_, false)

		function arg_54_1.onSingleLineFinish_()
			arg_54_1.onSingleLineUpdate_ = nil
			arg_54_1.onSingleLineFinish_ = nil
			arg_54_1.state_ = "waiting"
		end

		function arg_54_1.playNext_(arg_56_0)
			if arg_56_0 == 1 then
				arg_54_0:Play111032014(arg_54_1)
			end
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			local var_57_0 = 0
			local var_57_1 = 0.175

			if var_57_0 < arg_54_1.time_ and arg_54_1.time_ <= var_57_0 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0
				arg_54_1.dialogCg_.alpha = 1

				arg_54_1.dialog_:SetActive(true)
				SetActive(arg_54_1.leftNameGo_, true)

				local var_57_2 = arg_54_1:FormatText(StoryNameCfg[181].name)

				arg_54_1.leftNameTxt_.text = var_57_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_54_1.leftNameTxt_.transform)

				arg_54_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_54_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_54_1:RecordName(arg_54_1.leftNameTxt_.text)
				SetActive(arg_54_1.iconTrs_.gameObject, true)
				arg_54_1.iconController_:SetSelectedState("hero")

				arg_54_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1094")

				arg_54_1.callingController_:SetSelectedState("normal")

				arg_54_1.keyicon_.color = Color.New(1, 1, 1)
				arg_54_1.icon_.color = Color.New(1, 1, 1)

				local var_57_3 = arg_54_1:GetWordFromCfg(111032013)
				local var_57_4 = arg_54_1:FormatText(var_57_3.content)

				arg_54_1.text_.text = var_57_4

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_5 = 7
				local var_57_6 = utf8.len(var_57_4)
				local var_57_7 = var_57_5 <= 0 and var_57_1 or var_57_1 * (var_57_6 / var_57_5)

				if var_57_7 > 0 and var_57_1 < var_57_7 then
					arg_54_1.talkMaxDuration = var_57_7

					if var_57_7 + var_57_0 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_7 + var_57_0
					end
				end

				arg_54_1.text_.text = var_57_4
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111032", "111032013", "story_v_out_111032.awb") ~= 0 then
					local var_57_8 = manager.audio:GetVoiceLength("story_v_out_111032", "111032013", "story_v_out_111032.awb") / 1000

					if var_57_8 + var_57_0 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_8 + var_57_0
					end

					if var_57_3.prefab_name ~= "" and arg_54_1.actors_[var_57_3.prefab_name] ~= nil then
						local var_57_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_54_1.actors_[var_57_3.prefab_name].transform, "story_v_out_111032", "111032013", "story_v_out_111032.awb")

						arg_54_1:RecordAudio("111032013", var_57_9)
						arg_54_1:RecordAudio("111032013", var_57_9)
					else
						arg_54_1:AudioAction("play", "voice", "story_v_out_111032", "111032013", "story_v_out_111032.awb")
					end

					arg_54_1:RecordHistoryTalkVoice("story_v_out_111032", "111032013", "story_v_out_111032.awb")
				end

				arg_54_1:RecordContent(arg_54_1.text_.text)
			end

			local var_57_10 = math.max(var_57_1, arg_54_1.talkMaxDuration)

			if var_57_0 <= arg_54_1.time_ and arg_54_1.time_ < var_57_0 + var_57_10 then
				arg_54_1.typewritter.percent = (arg_54_1.time_ - var_57_0) / var_57_10

				arg_54_1.typewritter:SetDirty()
			end

			if arg_54_1.time_ >= var_57_0 + var_57_10 and arg_54_1.time_ < var_57_0 + var_57_10 + arg_57_0 then
				arg_54_1.typewritter.percent = 1

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(true)
			end
		end

		arg_54_1.nodeConfigList_ = {}

		arg_54_1:InitPlayNodeList()
	end,
	Play111032014 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 111032014
		arg_58_1.duration_ = 5

		SetActive(arg_58_1.tipsGo_, false)

		function arg_58_1.onSingleLineFinish_()
			arg_58_1.onSingleLineUpdate_ = nil
			arg_58_1.onSingleLineFinish_ = nil
			arg_58_1.state_ = "waiting"
		end

		function arg_58_1.playNext_(arg_60_0)
			if arg_60_0 == 1 then
				arg_58_0:Play111032015(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			local var_61_0 = manager.ui.mainCamera.transform
			local var_61_1 = 0

			if var_61_1 < arg_58_1.time_ and arg_58_1.time_ <= var_61_1 + arg_61_0 then
				arg_58_1.var_.shakeOldPos = var_61_0.localPosition
			end

			local var_61_2 = 0.5

			if var_61_1 <= arg_58_1.time_ and arg_58_1.time_ < var_61_1 + var_61_2 then
				local var_61_3 = (arg_58_1.time_ - var_61_1) / 0.066
				local var_61_4, var_61_5 = math.modf(var_61_3)

				var_61_0.localPosition = Vector3.New(var_61_5 * 0.13, var_61_5 * 0.13, var_61_5 * 0.13) + arg_58_1.var_.shakeOldPos
			end

			if arg_58_1.time_ >= var_61_1 + var_61_2 and arg_58_1.time_ < var_61_1 + var_61_2 + arg_61_0 then
				var_61_0.localPosition = arg_58_1.var_.shakeOldPos
			end

			local var_61_6 = 0

			if var_61_6 < arg_58_1.time_ and arg_58_1.time_ <= var_61_6 + arg_61_0 then
				arg_58_1.mask_.enabled = true
				arg_58_1.mask_.raycastTarget = true

				arg_58_1:SetGaussion(false)
			end

			local var_61_7 = 0.1

			if var_61_6 <= arg_58_1.time_ and arg_58_1.time_ < var_61_6 + var_61_7 then
				local var_61_8 = (arg_58_1.time_ - var_61_6) / var_61_7
				local var_61_9 = Color.New(1, 1, 1)

				var_61_9.a = Mathf.Lerp(1, 0, var_61_8)
				arg_58_1.mask_.color = var_61_9
			end

			if arg_58_1.time_ >= var_61_6 + var_61_7 and arg_58_1.time_ < var_61_6 + var_61_7 + arg_61_0 then
				local var_61_10 = Color.New(1, 1, 1)
				local var_61_11 = 0

				arg_58_1.mask_.enabled = false
				var_61_10.a = var_61_11
				arg_58_1.mask_.color = var_61_10
			end

			local var_61_12 = 0
			local var_61_13 = 1

			if var_61_12 < arg_58_1.time_ and arg_58_1.time_ <= var_61_12 + arg_61_0 then
				local var_61_14 = "play"
				local var_61_15 = "effect"

				arg_58_1:AudioAction(var_61_14, var_61_15, "se_story_activity_1_1", "se_story_activity_1_1_hel_cannon", "")
			end

			local var_61_16 = 0
			local var_61_17 = 1.05

			if var_61_16 < arg_58_1.time_ and arg_58_1.time_ <= var_61_16 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0
				arg_58_1.dialogCg_.alpha = 1

				arg_58_1.dialog_:SetActive(true)
				SetActive(arg_58_1.leftNameGo_, false)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_58_1.iconTrs_.gameObject, false)
				arg_58_1.callingController_:SetSelectedState("normal")

				local var_61_18 = arg_58_1:GetWordFromCfg(111032014)
				local var_61_19 = arg_58_1:FormatText(var_61_18.content)

				arg_58_1.text_.text = var_61_19

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_20 = 42
				local var_61_21 = utf8.len(var_61_19)
				local var_61_22 = var_61_20 <= 0 and var_61_17 or var_61_17 * (var_61_21 / var_61_20)

				if var_61_22 > 0 and var_61_17 < var_61_22 then
					arg_58_1.talkMaxDuration = var_61_22

					if var_61_22 + var_61_16 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_22 + var_61_16
					end
				end

				arg_58_1.text_.text = var_61_19
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)
				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_23 = math.max(var_61_17, arg_58_1.talkMaxDuration)

			if var_61_16 <= arg_58_1.time_ and arg_58_1.time_ < var_61_16 + var_61_23 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - var_61_16) / var_61_23

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= var_61_16 + var_61_23 and arg_58_1.time_ < var_61_16 + var_61_23 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {}

		arg_58_1:InitPlayNodeList()
	end,
	Play111032015 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 111032015
		arg_62_1.duration_ = 5

		SetActive(arg_62_1.tipsGo_, false)

		function arg_62_1.onSingleLineFinish_()
			arg_62_1.onSingleLineUpdate_ = nil
			arg_62_1.onSingleLineFinish_ = nil
			arg_62_1.state_ = "waiting"
		end

		function arg_62_1.playNext_(arg_64_0)
			if arg_64_0 == 1 then
				arg_62_0:Play111032016(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			local var_65_0 = 0
			local var_65_1 = 0.2

			if var_65_0 < arg_62_1.time_ and arg_62_1.time_ <= var_65_0 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, true)

				local var_65_2 = arg_62_1:FormatText(StoryNameCfg[7].name)

				arg_62_1.leftNameTxt_.text = var_65_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_62_1.leftNameTxt_.transform)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1.leftNameTxt_.text)
				SetActive(arg_62_1.iconTrs_.gameObject, true)
				arg_62_1.iconController_:SetSelectedState("hero")

				arg_62_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_62_1.callingController_:SetSelectedState("normal")

				arg_62_1.keyicon_.color = Color.New(1, 1, 1)
				arg_62_1.icon_.color = Color.New(1, 1, 1)

				local var_65_3 = arg_62_1:GetWordFromCfg(111032015)
				local var_65_4 = arg_62_1:FormatText(var_65_3.content)

				arg_62_1.text_.text = var_65_4

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_5 = 8
				local var_65_6 = utf8.len(var_65_4)
				local var_65_7 = var_65_5 <= 0 and var_65_1 or var_65_1 * (var_65_6 / var_65_5)

				if var_65_7 > 0 and var_65_1 < var_65_7 then
					arg_62_1.talkMaxDuration = var_65_7

					if var_65_7 + var_65_0 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_7 + var_65_0
					end
				end

				arg_62_1.text_.text = var_65_4
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)
				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_8 = math.max(var_65_1, arg_62_1.talkMaxDuration)

			if var_65_0 <= arg_62_1.time_ and arg_62_1.time_ < var_65_0 + var_65_8 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - var_65_0) / var_65_8

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= var_65_0 + var_65_8 and arg_62_1.time_ < var_65_0 + var_65_8 + arg_65_0 then
				arg_62_1.typewritter.percent = 1

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(true)
			end
		end

		arg_62_1.nodeConfigList_ = {}

		arg_62_1:InitPlayNodeList()
	end,
	Play111032016 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 111032016
		arg_66_1.duration_ = 1

		SetActive(arg_66_1.tipsGo_, false)

		function arg_66_1.onSingleLineFinish_()
			arg_66_1.onSingleLineUpdate_ = nil
			arg_66_1.onSingleLineFinish_ = nil
			arg_66_1.state_ = "waiting"
		end

		function arg_66_1.playNext_(arg_68_0)
			if arg_68_0 == 1 then
				arg_66_0:Play111032017(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			local var_69_0 = 0
			local var_69_1 = 0.716666666666667

			if var_69_0 < arg_66_1.time_ and arg_66_1.time_ <= var_69_0 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, true)

				local var_69_2 = arg_66_1:FormatText(StoryNameCfg[181].name)

				arg_66_1.leftNameTxt_.text = var_69_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_66_1.leftNameTxt_.transform)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1.leftNameTxt_.text)
				SetActive(arg_66_1.iconTrs_.gameObject, true)
				arg_66_1.iconController_:SetSelectedState("hero")

				arg_66_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1094")

				arg_66_1.callingController_:SetSelectedState("normal")

				arg_66_1.keyicon_.color = Color.New(1, 1, 1)
				arg_66_1.icon_.color = Color.New(1, 1, 1)

				local var_69_3 = arg_66_1:GetWordFromCfg(111032016)
				local var_69_4 = arg_66_1:FormatText(var_69_3.content)

				arg_66_1.text_.text = var_69_4

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_5 = 2
				local var_69_6 = utf8.len(var_69_4)
				local var_69_7 = var_69_5 <= 0 and var_69_1 or var_69_1 * (var_69_6 / var_69_5)

				if var_69_7 > 0 and var_69_1 < var_69_7 then
					arg_66_1.talkMaxDuration = var_69_7

					if var_69_7 + var_69_0 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_7 + var_69_0
					end
				end

				arg_66_1.text_.text = var_69_4
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111032", "111032016", "story_v_out_111032.awb") ~= 0 then
					local var_69_8 = manager.audio:GetVoiceLength("story_v_out_111032", "111032016", "story_v_out_111032.awb") / 1000

					if var_69_8 + var_69_0 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_8 + var_69_0
					end

					if var_69_3.prefab_name ~= "" and arg_66_1.actors_[var_69_3.prefab_name] ~= nil then
						local var_69_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_66_1.actors_[var_69_3.prefab_name].transform, "story_v_out_111032", "111032016", "story_v_out_111032.awb")

						arg_66_1:RecordAudio("111032016", var_69_9)
						arg_66_1:RecordAudio("111032016", var_69_9)
					else
						arg_66_1:AudioAction("play", "voice", "story_v_out_111032", "111032016", "story_v_out_111032.awb")
					end

					arg_66_1:RecordHistoryTalkVoice("story_v_out_111032", "111032016", "story_v_out_111032.awb")
				end

				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_10 = math.max(var_69_1, arg_66_1.talkMaxDuration)

			if var_69_0 <= arg_66_1.time_ and arg_66_1.time_ < var_69_0 + var_69_10 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - var_69_0) / var_69_10

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= var_69_0 + var_69_10 and arg_66_1.time_ < var_69_0 + var_69_10 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {}

		arg_66_1:InitPlayNodeList()
	end,
	Play111032017 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 111032017
		arg_70_1.duration_ = 5

		SetActive(arg_70_1.tipsGo_, false)

		function arg_70_1.onSingleLineFinish_()
			arg_70_1.onSingleLineUpdate_ = nil
			arg_70_1.onSingleLineFinish_ = nil
			arg_70_1.state_ = "waiting"
		end

		function arg_70_1.playNext_(arg_72_0)
			if arg_72_0 == 1 then
				arg_70_0:Play111032018(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			local var_73_0 = 0
			local var_73_1 = 1.675

			if var_73_0 < arg_70_1.time_ and arg_70_1.time_ <= var_73_0 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, false)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_70_1.iconTrs_.gameObject, false)
				arg_70_1.callingController_:SetSelectedState("normal")

				local var_73_2 = arg_70_1:GetWordFromCfg(111032017)
				local var_73_3 = arg_70_1:FormatText(var_73_2.content)

				arg_70_1.text_.text = var_73_3

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_4 = 67
				local var_73_5 = utf8.len(var_73_3)
				local var_73_6 = var_73_4 <= 0 and var_73_1 or var_73_1 * (var_73_5 / var_73_4)

				if var_73_6 > 0 and var_73_1 < var_73_6 then
					arg_70_1.talkMaxDuration = var_73_6

					if var_73_6 + var_73_0 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_6 + var_73_0
					end
				end

				arg_70_1.text_.text = var_73_3
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)
				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_7 = math.max(var_73_1, arg_70_1.talkMaxDuration)

			if var_73_0 <= arg_70_1.time_ and arg_70_1.time_ < var_73_0 + var_73_7 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_0) / var_73_7

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_0 + var_73_7 and arg_70_1.time_ < var_73_0 + var_73_7 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {}

		arg_70_1:InitPlayNodeList()
	end,
	Play111032018 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 111032018
		arg_74_1.duration_ = 5

		SetActive(arg_74_1.tipsGo_, false)

		function arg_74_1.onSingleLineFinish_()
			arg_74_1.onSingleLineUpdate_ = nil
			arg_74_1.onSingleLineFinish_ = nil
			arg_74_1.state_ = "waiting"
		end

		function arg_74_1.playNext_(arg_76_0)
			if arg_76_0 == 1 then
				arg_74_0:Play111032019(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			local var_77_0 = 0
			local var_77_1 = 0.825

			if var_77_0 < arg_74_1.time_ and arg_74_1.time_ <= var_77_0 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, false)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_74_1.iconTrs_.gameObject, false)
				arg_74_1.callingController_:SetSelectedState("normal")

				local var_77_2 = arg_74_1:GetWordFromCfg(111032018)
				local var_77_3 = arg_74_1:FormatText(var_77_2.content)

				arg_74_1.text_.text = var_77_3

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_4 = 33
				local var_77_5 = utf8.len(var_77_3)
				local var_77_6 = var_77_4 <= 0 and var_77_1 or var_77_1 * (var_77_5 / var_77_4)

				if var_77_6 > 0 and var_77_1 < var_77_6 then
					arg_74_1.talkMaxDuration = var_77_6

					if var_77_6 + var_77_0 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_6 + var_77_0
					end
				end

				arg_74_1.text_.text = var_77_3
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)
				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_7 = math.max(var_77_1, arg_74_1.talkMaxDuration)

			if var_77_0 <= arg_74_1.time_ and arg_74_1.time_ < var_77_0 + var_77_7 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - var_77_0) / var_77_7

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= var_77_0 + var_77_7 and arg_74_1.time_ < var_77_0 + var_77_7 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {}

		arg_74_1:InitPlayNodeList()
	end,
	Play111032019 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 111032019
		arg_78_1.duration_ = 7.5

		SetActive(arg_78_1.tipsGo_, false)

		function arg_78_1.onSingleLineFinish_()
			arg_78_1.onSingleLineUpdate_ = nil
			arg_78_1.onSingleLineFinish_ = nil
			arg_78_1.state_ = "waiting"
		end

		function arg_78_1.playNext_(arg_80_0)
			if arg_80_0 == 1 then
				arg_78_0:Play111032020(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			local var_81_0 = 1

			if var_81_0 < arg_78_1.time_ and arg_78_1.time_ <= var_81_0 + arg_81_0 then
				local var_81_1 = manager.ui.mainCamera.transform.localPosition
				local var_81_2 = Vector3.New(0, 0, 10) + Vector3.New(var_81_1.x, var_81_1.y, 0)
				local var_81_3 = arg_78_1.bgs_.D05

				var_81_3.transform.localPosition = var_81_2
				var_81_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_81_4 = var_81_3:GetComponent("SpriteRenderer")

				if var_81_4 and var_81_4.sprite then
					local var_81_5 = (var_81_3.transform.localPosition - var_81_1).z
					local var_81_6 = manager.ui.mainCameraCom_
					local var_81_7 = 2 * var_81_5 * Mathf.Tan(var_81_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_81_8 = var_81_7 * var_81_6.aspect
					local var_81_9 = var_81_4.sprite.bounds.size.x
					local var_81_10 = var_81_4.sprite.bounds.size.y
					local var_81_11 = var_81_8 / var_81_9
					local var_81_12 = var_81_7 / var_81_10
					local var_81_13 = var_81_12 < var_81_11 and var_81_11 or var_81_12

					var_81_3.transform.localScale = Vector3.New(var_81_13, var_81_13, 0)
				end

				for iter_81_0, iter_81_1 in pairs(arg_78_1.bgs_) do
					if iter_81_0 ~= "D05" then
						iter_81_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_81_14 = arg_78_1.bgs_.D05
			local var_81_15 = 1

			if var_81_15 < arg_78_1.time_ and arg_78_1.time_ <= var_81_15 + arg_81_0 then
				local var_81_16 = var_81_14:GetComponent("SpriteRenderer")

				if var_81_16 then
					arg_78_1.var_.alphaOldValueD05 = var_81_16.color.a
					arg_78_1.var_.alphaMatValueD05 = var_81_16
				end

				arg_78_1.var_.alphaOldValueD05 = 0
			end

			local var_81_17 = 1.5

			if var_81_15 <= arg_78_1.time_ and arg_78_1.time_ < var_81_15 + var_81_17 then
				local var_81_18 = (arg_78_1.time_ - var_81_15) / var_81_17
				local var_81_19 = Mathf.Lerp(arg_78_1.var_.alphaOldValueD05, 1, var_81_18)

				if arg_78_1.var_.alphaMatValueD05 then
					local var_81_20 = arg_78_1.var_.alphaMatValueD05.color

					var_81_20.a = var_81_19
					arg_78_1.var_.alphaMatValueD05.color = var_81_20
				end
			end

			if arg_78_1.time_ >= var_81_15 + var_81_17 and arg_78_1.time_ < var_81_15 + var_81_17 + arg_81_0 and arg_78_1.var_.alphaMatValueD05 then
				local var_81_21 = arg_78_1.var_.alphaMatValueD05
				local var_81_22 = var_81_21.color

				var_81_22.a = 1
				var_81_21.color = var_81_22
			end

			local var_81_23 = arg_78_1.bgs_.AS0101
			local var_81_24 = 0

			if var_81_24 < arg_78_1.time_ and arg_78_1.time_ <= var_81_24 + arg_81_0 then
				local var_81_25 = var_81_23:GetComponent("SpriteRenderer")

				if var_81_25 then
					arg_78_1.var_.alphaOldValueAS0101 = var_81_25.color.a
					arg_78_1.var_.alphaMatValueAS0101 = var_81_25
				end

				arg_78_1.var_.alphaOldValueAS0101 = 1
			end

			local var_81_26 = 1

			if var_81_24 <= arg_78_1.time_ and arg_78_1.time_ < var_81_24 + var_81_26 then
				local var_81_27 = (arg_78_1.time_ - var_81_24) / var_81_26
				local var_81_28 = Mathf.Lerp(arg_78_1.var_.alphaOldValueAS0101, 0, var_81_27)

				if arg_78_1.var_.alphaMatValueAS0101 then
					local var_81_29 = arg_78_1.var_.alphaMatValueAS0101.color

					var_81_29.a = var_81_28
					arg_78_1.var_.alphaMatValueAS0101.color = var_81_29
				end
			end

			if arg_78_1.time_ >= var_81_24 + var_81_26 and arg_78_1.time_ < var_81_24 + var_81_26 + arg_81_0 and arg_78_1.var_.alphaMatValueAS0101 then
				local var_81_30 = arg_78_1.var_.alphaMatValueAS0101
				local var_81_31 = var_81_30.color

				var_81_31.a = 0
				var_81_30.color = var_81_31
			end

			local var_81_32 = 0

			if var_81_32 < arg_78_1.time_ and arg_78_1.time_ <= var_81_32 + arg_81_0 then
				arg_78_1.allBtn_.enabled = false
			end

			local var_81_33 = 2.5

			if arg_78_1.time_ >= var_81_32 + var_81_33 and arg_78_1.time_ < var_81_32 + var_81_33 + arg_81_0 then
				arg_78_1.allBtn_.enabled = true
			end

			if arg_78_1.frameCnt_ <= 1 then
				arg_78_1.dialog_:SetActive(false)
			end

			local var_81_34 = 2.5
			local var_81_35 = 0.95

			if var_81_34 < arg_78_1.time_ and arg_78_1.time_ <= var_81_34 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0

				arg_78_1.dialog_:SetActive(true)

				arg_78_1.dialogCg_.alpha = 0

				local var_81_36 = LeanTween.value(arg_78_1.dialog_, 0, 1, 0.3)

				var_81_36:setOnUpdate(LuaHelper.FloatAction(function(arg_82_0)
					arg_78_1.dialogCg_.alpha = arg_82_0
				end))
				var_81_36:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_78_1.dialog_)
					var_81_36:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_78_1.duration_ = arg_78_1.duration_ + 0.3

				SetActive(arg_78_1.leftNameGo_, true)

				local var_81_37 = arg_78_1:FormatText(StoryNameCfg[7].name)

				arg_78_1.leftNameTxt_.text = var_81_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_78_1.leftNameTxt_.transform)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1.leftNameTxt_.text)
				SetActive(arg_78_1.iconTrs_.gameObject, true)
				arg_78_1.iconController_:SetSelectedState("hero")

				arg_78_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_78_1.callingController_:SetSelectedState("normal")

				arg_78_1.keyicon_.color = Color.New(1, 1, 1)
				arg_78_1.icon_.color = Color.New(1, 1, 1)

				local var_81_38 = arg_78_1:GetWordFromCfg(111032019)
				local var_81_39 = arg_78_1:FormatText(var_81_38.content)

				arg_78_1.text_.text = var_81_39

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_40 = 38
				local var_81_41 = utf8.len(var_81_39)
				local var_81_42 = var_81_40 <= 0 and var_81_35 or var_81_35 * (var_81_41 / var_81_40)

				if var_81_42 > 0 and var_81_35 < var_81_42 then
					arg_78_1.talkMaxDuration = var_81_42
					var_81_34 = var_81_34 + 0.3

					if var_81_42 + var_81_34 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_42 + var_81_34
					end
				end

				arg_78_1.text_.text = var_81_39
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)
				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_43 = var_81_34 + 0.3
			local var_81_44 = math.max(var_81_35, arg_78_1.talkMaxDuration)

			if var_81_43 <= arg_78_1.time_ and arg_78_1.time_ < var_81_43 + var_81_44 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - var_81_43) / var_81_44

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= var_81_43 + var_81_44 and arg_78_1.time_ < var_81_43 + var_81_44 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {}

		arg_78_1:InitPlayNodeList()
	end,
	Play111032020 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 111032020
		arg_84_1.duration_ = 5

		SetActive(arg_84_1.tipsGo_, false)

		function arg_84_1.onSingleLineFinish_()
			arg_84_1.onSingleLineUpdate_ = nil
			arg_84_1.onSingleLineFinish_ = nil
			arg_84_1.state_ = "waiting"
		end

		function arg_84_1.playNext_(arg_86_0)
			if arg_86_0 == 1 then
				arg_84_0:Play111032021(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			local var_87_0 = 0
			local var_87_1 = 0.325

			if var_87_0 < arg_84_1.time_ and arg_84_1.time_ <= var_87_0 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				local var_87_2 = arg_84_1:FormatText(StoryNameCfg[7].name)

				arg_84_1.leftNameTxt_.text = var_87_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, true)
				arg_84_1.iconController_:SetSelectedState("hero")

				arg_84_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_84_1.callingController_:SetSelectedState("normal")

				arg_84_1.keyicon_.color = Color.New(1, 1, 1)
				arg_84_1.icon_.color = Color.New(1, 1, 1)

				local var_87_3 = arg_84_1:GetWordFromCfg(111032020)
				local var_87_4 = arg_84_1:FormatText(var_87_3.content)

				arg_84_1.text_.text = var_87_4

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_5 = 13
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
				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_8 = math.max(var_87_1, arg_84_1.talkMaxDuration)

			if var_87_0 <= arg_84_1.time_ and arg_84_1.time_ < var_87_0 + var_87_8 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_0) / var_87_8

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_0 + var_87_8 and arg_84_1.time_ < var_87_0 + var_87_8 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {}

		arg_84_1:InitPlayNodeList()
	end,
	Play111032021 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 111032021
		arg_88_1.duration_ = 2

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play111032022(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			local var_91_0 = "1094ui_story"

			if arg_88_1.actors_[var_91_0] == nil then
				local var_91_1 = Asset.Load("Char/" .. "1094ui_story")

				if not isNil(var_91_1) then
					local var_91_2 = Object.Instantiate(Asset.Load("Char/" .. "1094ui_story"), arg_88_1.stage_.transform)

					var_91_2.name = var_91_0
					var_91_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_88_1.actors_[var_91_0] = var_91_2

					local var_91_3 = var_91_2:GetComponentInChildren(typeof(CharacterEffect))

					var_91_3.enabled = true

					local var_91_4 = GameObjectTools.GetOrAddComponent(var_91_2, typeof(DynamicBoneHelper))

					if var_91_4 then
						var_91_4:EnableDynamicBone(false)
					end

					arg_88_1:ShowWeapon(var_91_3.transform, false)

					arg_88_1.var_[var_91_0 .. "Animator"] = var_91_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_88_1.var_[var_91_0 .. "Animator"].applyRootMotion = true
					arg_88_1.var_[var_91_0 .. "LipSync"] = var_91_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_91_5 = arg_88_1.actors_["1094ui_story"]
			local var_91_6 = 0

			if var_91_6 < arg_88_1.time_ and arg_88_1.time_ <= var_91_6 + arg_91_0 and not isNil(var_91_5) and arg_88_1.var_.characterEffect1094ui_story == nil then
				arg_88_1.var_.characterEffect1094ui_story = var_91_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_91_7 = 0.2

			if var_91_6 <= arg_88_1.time_ and arg_88_1.time_ < var_91_6 + var_91_7 and not isNil(var_91_5) then
				local var_91_8 = (arg_88_1.time_ - var_91_6) / var_91_7

				if arg_88_1.var_.characterEffect1094ui_story and not isNil(var_91_5) then
					arg_88_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_88_1.time_ >= var_91_6 + var_91_7 and arg_88_1.time_ < var_91_6 + var_91_7 + arg_91_0 and not isNil(var_91_5) and arg_88_1.var_.characterEffect1094ui_story then
				arg_88_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_91_9 = arg_88_1.actors_["1094ui_story"].transform
			local var_91_10 = 0

			if var_91_10 < arg_88_1.time_ and arg_88_1.time_ <= var_91_10 + arg_91_0 then
				arg_88_1.var_.moveOldPos1094ui_story = var_91_9.localPosition
			end

			local var_91_11 = 0.001

			if var_91_10 <= arg_88_1.time_ and arg_88_1.time_ < var_91_10 + var_91_11 then
				local var_91_12 = (arg_88_1.time_ - var_91_10) / var_91_11
				local var_91_13 = Vector3.New(0, -0.84, -6.1)

				var_91_9.localPosition = Vector3.Lerp(arg_88_1.var_.moveOldPos1094ui_story, var_91_13, var_91_12)

				local var_91_14 = manager.ui.mainCamera.transform.position - var_91_9.position

				var_91_9.forward = Vector3.New(var_91_14.x, var_91_14.y, var_91_14.z)

				local var_91_15 = var_91_9.localEulerAngles

				var_91_15.z = 0
				var_91_15.x = 0
				var_91_9.localEulerAngles = var_91_15
			end

			if arg_88_1.time_ >= var_91_10 + var_91_11 and arg_88_1.time_ < var_91_10 + var_91_11 + arg_91_0 then
				var_91_9.localPosition = Vector3.New(0, -0.84, -6.1)

				local var_91_16 = manager.ui.mainCamera.transform.position - var_91_9.position

				var_91_9.forward = Vector3.New(var_91_16.x, var_91_16.y, var_91_16.z)

				local var_91_17 = var_91_9.localEulerAngles

				var_91_17.z = 0
				var_91_17.x = 0
				var_91_9.localEulerAngles = var_91_17
			end

			local var_91_18 = 0

			if var_91_18 < arg_88_1.time_ and arg_88_1.time_ <= var_91_18 + arg_91_0 then
				arg_88_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action3_1")
			end

			local var_91_19 = 0

			if var_91_19 < arg_88_1.time_ and arg_88_1.time_ <= var_91_19 + arg_91_0 then
				arg_88_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_91_20 = 0
			local var_91_21 = 0.1

			if var_91_20 < arg_88_1.time_ and arg_88_1.time_ <= var_91_20 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				local var_91_22 = arg_88_1:FormatText(StoryNameCfg[181].name)

				arg_88_1.leftNameTxt_.text = var_91_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_23 = arg_88_1:GetWordFromCfg(111032021)
				local var_91_24 = arg_88_1:FormatText(var_91_23.content)

				arg_88_1.text_.text = var_91_24

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_25 = 2
				local var_91_26 = utf8.len(var_91_24)
				local var_91_27 = var_91_25 <= 0 and var_91_21 or var_91_21 * (var_91_26 / var_91_25)

				if var_91_27 > 0 and var_91_21 < var_91_27 then
					arg_88_1.talkMaxDuration = var_91_27

					if var_91_27 + var_91_20 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_27 + var_91_20
					end
				end

				arg_88_1.text_.text = var_91_24
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111032", "111032021", "story_v_out_111032.awb") ~= 0 then
					local var_91_28 = manager.audio:GetVoiceLength("story_v_out_111032", "111032021", "story_v_out_111032.awb") / 1000

					if var_91_28 + var_91_20 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_28 + var_91_20
					end

					if var_91_23.prefab_name ~= "" and arg_88_1.actors_[var_91_23.prefab_name] ~= nil then
						local var_91_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_88_1.actors_[var_91_23.prefab_name].transform, "story_v_out_111032", "111032021", "story_v_out_111032.awb")

						arg_88_1:RecordAudio("111032021", var_91_29)
						arg_88_1:RecordAudio("111032021", var_91_29)
					else
						arg_88_1:AudioAction("play", "voice", "story_v_out_111032", "111032021", "story_v_out_111032.awb")
					end

					arg_88_1:RecordHistoryTalkVoice("story_v_out_111032", "111032021", "story_v_out_111032.awb")
				end

				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_30 = math.max(var_91_21, arg_88_1.talkMaxDuration)

			if var_91_20 <= arg_88_1.time_ and arg_88_1.time_ < var_91_20 + var_91_30 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_20) / var_91_30

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_20 + var_91_30 and arg_88_1.time_ < var_91_20 + var_91_30 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_88_1:InitPlayNodeList()
	end,
	Play111032022 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 111032022
		arg_92_1.duration_ = 4.57

		local var_92_0 = {
			ja = 4.566,
			ko = 4.3,
			zh = 3.8,
			en = 3.966
		}
		local var_92_1 = manager.audio:GetLocalizationFlag()

		if var_92_0[var_92_1] ~= nil then
			arg_92_1.duration_ = var_92_0[var_92_1]
		end

		SetActive(arg_92_1.tipsGo_, false)

		function arg_92_1.onSingleLineFinish_()
			arg_92_1.onSingleLineUpdate_ = nil
			arg_92_1.onSingleLineFinish_ = nil
			arg_92_1.state_ = "waiting"
		end

		function arg_92_1.playNext_(arg_94_0)
			if arg_94_0 == 1 then
				arg_92_0:Play111032023(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			local var_95_0 = 0

			if var_95_0 < arg_92_1.time_ and arg_92_1.time_ <= var_95_0 + arg_95_0 then
				arg_92_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_95_1 = arg_92_1.actors_["1094ui_story"]
			local var_95_2 = 0

			if var_95_2 < arg_92_1.time_ and arg_92_1.time_ <= var_95_2 + arg_95_0 and not isNil(var_95_1) and arg_92_1.var_.characterEffect1094ui_story == nil then
				arg_92_1.var_.characterEffect1094ui_story = var_95_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_95_3 = 0.2

			if var_95_2 <= arg_92_1.time_ and arg_92_1.time_ < var_95_2 + var_95_3 and not isNil(var_95_1) then
				local var_95_4 = (arg_92_1.time_ - var_95_2) / var_95_3

				if arg_92_1.var_.characterEffect1094ui_story and not isNil(var_95_1) then
					arg_92_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_92_1.time_ >= var_95_2 + var_95_3 and arg_92_1.time_ < var_95_2 + var_95_3 + arg_95_0 and not isNil(var_95_1) and arg_92_1.var_.characterEffect1094ui_story then
				arg_92_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_95_5 = 0
			local var_95_6 = 0.425

			if var_95_5 < arg_92_1.time_ and arg_92_1.time_ <= var_95_5 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				local var_95_7 = arg_92_1:FormatText(StoryNameCfg[181].name)

				arg_92_1.leftNameTxt_.text = var_95_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_8 = arg_92_1:GetWordFromCfg(111032022)
				local var_95_9 = arg_92_1:FormatText(var_95_8.content)

				arg_92_1.text_.text = var_95_9

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_10 = 17
				local var_95_11 = utf8.len(var_95_9)
				local var_95_12 = var_95_10 <= 0 and var_95_6 or var_95_6 * (var_95_11 / var_95_10)

				if var_95_12 > 0 and var_95_6 < var_95_12 then
					arg_92_1.talkMaxDuration = var_95_12

					if var_95_12 + var_95_5 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_12 + var_95_5
					end
				end

				arg_92_1.text_.text = var_95_9
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111032", "111032022", "story_v_out_111032.awb") ~= 0 then
					local var_95_13 = manager.audio:GetVoiceLength("story_v_out_111032", "111032022", "story_v_out_111032.awb") / 1000

					if var_95_13 + var_95_5 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_13 + var_95_5
					end

					if var_95_8.prefab_name ~= "" and arg_92_1.actors_[var_95_8.prefab_name] ~= nil then
						local var_95_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_92_1.actors_[var_95_8.prefab_name].transform, "story_v_out_111032", "111032022", "story_v_out_111032.awb")

						arg_92_1:RecordAudio("111032022", var_95_14)
						arg_92_1:RecordAudio("111032022", var_95_14)
					else
						arg_92_1:AudioAction("play", "voice", "story_v_out_111032", "111032022", "story_v_out_111032.awb")
					end

					arg_92_1:RecordHistoryTalkVoice("story_v_out_111032", "111032022", "story_v_out_111032.awb")
				end

				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_15 = math.max(var_95_6, arg_92_1.talkMaxDuration)

			if var_95_5 <= arg_92_1.time_ and arg_92_1.time_ < var_95_5 + var_95_15 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_5) / var_95_15

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_5 + var_95_15 and arg_92_1.time_ < var_95_5 + var_95_15 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {}

		arg_92_1:InitPlayNodeList()
	end,
	Play111032023 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 111032023
		arg_96_1.duration_ = 5

		SetActive(arg_96_1.tipsGo_, false)

		function arg_96_1.onSingleLineFinish_()
			arg_96_1.onSingleLineUpdate_ = nil
			arg_96_1.onSingleLineFinish_ = nil
			arg_96_1.state_ = "waiting"
		end

		function arg_96_1.playNext_(arg_98_0)
			if arg_98_0 == 1 then
				arg_96_0:Play111032024(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			local var_99_0 = arg_96_1.actors_["1094ui_story"]
			local var_99_1 = 0

			if var_99_1 < arg_96_1.time_ and arg_96_1.time_ <= var_99_1 + arg_99_0 and not isNil(var_99_0) and arg_96_1.var_.characterEffect1094ui_story == nil then
				arg_96_1.var_.characterEffect1094ui_story = var_99_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_2 = 0.2

			if var_99_1 <= arg_96_1.time_ and arg_96_1.time_ < var_99_1 + var_99_2 and not isNil(var_99_0) then
				local var_99_3 = (arg_96_1.time_ - var_99_1) / var_99_2

				if arg_96_1.var_.characterEffect1094ui_story and not isNil(var_99_0) then
					local var_99_4 = Mathf.Lerp(0, 0.5, var_99_3)

					arg_96_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_96_1.var_.characterEffect1094ui_story.fillRatio = var_99_4
				end
			end

			if arg_96_1.time_ >= var_99_1 + var_99_2 and arg_96_1.time_ < var_99_1 + var_99_2 + arg_99_0 and not isNil(var_99_0) and arg_96_1.var_.characterEffect1094ui_story then
				local var_99_5 = 0.5

				arg_96_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_96_1.var_.characterEffect1094ui_story.fillRatio = var_99_5
			end

			local var_99_6 = 0
			local var_99_7 = 0.75

			if var_99_6 < arg_96_1.time_ and arg_96_1.time_ <= var_99_6 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, false)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_8 = arg_96_1:GetWordFromCfg(111032023)
				local var_99_9 = arg_96_1:FormatText(var_99_8.content)

				arg_96_1.text_.text = var_99_9

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_10 = 30
				local var_99_11 = utf8.len(var_99_9)
				local var_99_12 = var_99_10 <= 0 and var_99_7 or var_99_7 * (var_99_11 / var_99_10)

				if var_99_12 > 0 and var_99_7 < var_99_12 then
					arg_96_1.talkMaxDuration = var_99_12

					if var_99_12 + var_99_6 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_12 + var_99_6
					end
				end

				arg_96_1.text_.text = var_99_9
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)
				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_13 = math.max(var_99_7, arg_96_1.talkMaxDuration)

			if var_99_6 <= arg_96_1.time_ and arg_96_1.time_ < var_99_6 + var_99_13 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_6) / var_99_13

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_6 + var_99_13 and arg_96_1.time_ < var_99_6 + var_99_13 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {}

		arg_96_1:InitPlayNodeList()
	end,
	Play111032024 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 111032024
		arg_100_1.duration_ = 5

		SetActive(arg_100_1.tipsGo_, false)

		function arg_100_1.onSingleLineFinish_()
			arg_100_1.onSingleLineUpdate_ = nil
			arg_100_1.onSingleLineFinish_ = nil
			arg_100_1.state_ = "waiting"
		end

		function arg_100_1.playNext_(arg_102_0)
			if arg_102_0 == 1 then
				arg_100_0:Play111032025(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			local var_103_0 = 0
			local var_103_1 = 1.125

			if var_103_0 < arg_100_1.time_ and arg_100_1.time_ <= var_103_0 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, false)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_100_1.iconTrs_.gameObject, false)
				arg_100_1.callingController_:SetSelectedState("normal")

				local var_103_2 = arg_100_1:GetWordFromCfg(111032024)
				local var_103_3 = arg_100_1:FormatText(var_103_2.content)

				arg_100_1.text_.text = var_103_3

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_4 = 45
				local var_103_5 = utf8.len(var_103_3)
				local var_103_6 = var_103_4 <= 0 and var_103_1 or var_103_1 * (var_103_5 / var_103_4)

				if var_103_6 > 0 and var_103_1 < var_103_6 then
					arg_100_1.talkMaxDuration = var_103_6

					if var_103_6 + var_103_0 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_6 + var_103_0
					end
				end

				arg_100_1.text_.text = var_103_3
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)
				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_7 = math.max(var_103_1, arg_100_1.talkMaxDuration)

			if var_103_0 <= arg_100_1.time_ and arg_100_1.time_ < var_103_0 + var_103_7 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_0) / var_103_7

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_0 + var_103_7 and arg_100_1.time_ < var_103_0 + var_103_7 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {}

		arg_100_1:InitPlayNodeList()
	end,
	Play111032025 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 111032025
		arg_104_1.duration_ = 5

		SetActive(arg_104_1.tipsGo_, false)

		function arg_104_1.onSingleLineFinish_()
			arg_104_1.onSingleLineUpdate_ = nil
			arg_104_1.onSingleLineFinish_ = nil
			arg_104_1.state_ = "waiting"
		end

		function arg_104_1.playNext_(arg_106_0)
			if arg_106_0 == 1 then
				arg_104_0:Play111032026(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			local var_107_0 = 0
			local var_107_1 = 0.9

			if var_107_0 < arg_104_1.time_ and arg_104_1.time_ <= var_107_0 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				local var_107_2 = arg_104_1:FormatText(StoryNameCfg[7].name)

				arg_104_1.leftNameTxt_.text = var_107_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, true)
				arg_104_1.iconController_:SetSelectedState("hero")

				arg_104_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_104_1.callingController_:SetSelectedState("normal")

				arg_104_1.keyicon_.color = Color.New(1, 1, 1)
				arg_104_1.icon_.color = Color.New(1, 1, 1)

				local var_107_3 = arg_104_1:GetWordFromCfg(111032025)
				local var_107_4 = arg_104_1:FormatText(var_107_3.content)

				arg_104_1.text_.text = var_107_4

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_5 = 36
				local var_107_6 = utf8.len(var_107_4)
				local var_107_7 = var_107_5 <= 0 and var_107_1 or var_107_1 * (var_107_6 / var_107_5)

				if var_107_7 > 0 and var_107_1 < var_107_7 then
					arg_104_1.talkMaxDuration = var_107_7

					if var_107_7 + var_107_0 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_7 + var_107_0
					end
				end

				arg_104_1.text_.text = var_107_4
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)
				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_8 = math.max(var_107_1, arg_104_1.talkMaxDuration)

			if var_107_0 <= arg_104_1.time_ and arg_104_1.time_ < var_107_0 + var_107_8 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_0) / var_107_8

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_0 + var_107_8 and arg_104_1.time_ < var_107_0 + var_107_8 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {}

		arg_104_1:InitPlayNodeList()
	end,
	Play111032026 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 111032026
		arg_108_1.duration_ = 5.8

		local var_108_0 = {
			ja = 3.233,
			ko = 2.833,
			zh = 5.8,
			en = 3.566
		}
		local var_108_1 = manager.audio:GetLocalizationFlag()

		if var_108_0[var_108_1] ~= nil then
			arg_108_1.duration_ = var_108_0[var_108_1]
		end

		SetActive(arg_108_1.tipsGo_, false)

		function arg_108_1.onSingleLineFinish_()
			arg_108_1.onSingleLineUpdate_ = nil
			arg_108_1.onSingleLineFinish_ = nil
			arg_108_1.state_ = "waiting"
		end

		function arg_108_1.playNext_(arg_110_0)
			if arg_110_0 == 1 then
				arg_108_0:Play111032027(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			local var_111_0 = 0

			if var_111_0 < arg_108_1.time_ and arg_108_1.time_ <= var_111_0 + arg_111_0 then
				arg_108_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094actionlink/1094action435")
			end

			local var_111_1 = 0

			if var_111_1 < arg_108_1.time_ and arg_108_1.time_ <= var_111_1 + arg_111_0 then
				arg_108_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_111_2 = arg_108_1.actors_["1094ui_story"]
			local var_111_3 = 0

			if var_111_3 < arg_108_1.time_ and arg_108_1.time_ <= var_111_3 + arg_111_0 and not isNil(var_111_2) and arg_108_1.var_.characterEffect1094ui_story == nil then
				arg_108_1.var_.characterEffect1094ui_story = var_111_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_111_4 = 0.2

			if var_111_3 <= arg_108_1.time_ and arg_108_1.time_ < var_111_3 + var_111_4 and not isNil(var_111_2) then
				local var_111_5 = (arg_108_1.time_ - var_111_3) / var_111_4

				if arg_108_1.var_.characterEffect1094ui_story and not isNil(var_111_2) then
					arg_108_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_108_1.time_ >= var_111_3 + var_111_4 and arg_108_1.time_ < var_111_3 + var_111_4 + arg_111_0 and not isNil(var_111_2) and arg_108_1.var_.characterEffect1094ui_story then
				arg_108_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_111_6 = 0
			local var_111_7 = 0.325

			if var_111_6 < arg_108_1.time_ and arg_108_1.time_ <= var_111_6 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				local var_111_8 = arg_108_1:FormatText(StoryNameCfg[181].name)

				arg_108_1.leftNameTxt_.text = var_111_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, false)
				arg_108_1.callingController_:SetSelectedState("normal")

				local var_111_9 = arg_108_1:GetWordFromCfg(111032026)
				local var_111_10 = arg_108_1:FormatText(var_111_9.content)

				arg_108_1.text_.text = var_111_10

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_11 = 13
				local var_111_12 = utf8.len(var_111_10)
				local var_111_13 = var_111_11 <= 0 and var_111_7 or var_111_7 * (var_111_12 / var_111_11)

				if var_111_13 > 0 and var_111_7 < var_111_13 then
					arg_108_1.talkMaxDuration = var_111_13

					if var_111_13 + var_111_6 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_13 + var_111_6
					end
				end

				arg_108_1.text_.text = var_111_10
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111032", "111032026", "story_v_out_111032.awb") ~= 0 then
					local var_111_14 = manager.audio:GetVoiceLength("story_v_out_111032", "111032026", "story_v_out_111032.awb") / 1000

					if var_111_14 + var_111_6 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_14 + var_111_6
					end

					if var_111_9.prefab_name ~= "" and arg_108_1.actors_[var_111_9.prefab_name] ~= nil then
						local var_111_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_108_1.actors_[var_111_9.prefab_name].transform, "story_v_out_111032", "111032026", "story_v_out_111032.awb")

						arg_108_1:RecordAudio("111032026", var_111_15)
						arg_108_1:RecordAudio("111032026", var_111_15)
					else
						arg_108_1:AudioAction("play", "voice", "story_v_out_111032", "111032026", "story_v_out_111032.awb")
					end

					arg_108_1:RecordHistoryTalkVoice("story_v_out_111032", "111032026", "story_v_out_111032.awb")
				end

				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_16 = math.max(var_111_7, arg_108_1.talkMaxDuration)

			if var_111_6 <= arg_108_1.time_ and arg_108_1.time_ < var_111_6 + var_111_16 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_6) / var_111_16

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_6 + var_111_16 and arg_108_1.time_ < var_111_6 + var_111_16 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {}

		arg_108_1:InitPlayNodeList()
	end,
	Play111032027 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 111032027
		arg_112_1.duration_ = 7.67

		local var_112_0 = {
			ja = 5.6,
			ko = 3.533,
			zh = 7.666,
			en = 4.7
		}
		local var_112_1 = manager.audio:GetLocalizationFlag()

		if var_112_0[var_112_1] ~= nil then
			arg_112_1.duration_ = var_112_0[var_112_1]
		end

		SetActive(arg_112_1.tipsGo_, false)

		function arg_112_1.onSingleLineFinish_()
			arg_112_1.onSingleLineUpdate_ = nil
			arg_112_1.onSingleLineFinish_ = nil
			arg_112_1.state_ = "waiting"
		end

		function arg_112_1.playNext_(arg_114_0)
			if arg_114_0 == 1 then
				arg_112_0:Play111032028(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			local var_115_0 = 0

			if var_115_0 < arg_112_1.time_ and arg_112_1.time_ <= var_115_0 + arg_115_0 then
				arg_112_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_115_1 = 0
			local var_115_2 = 0.475

			if var_115_1 < arg_112_1.time_ and arg_112_1.time_ <= var_115_1 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				local var_115_3 = arg_112_1:FormatText(StoryNameCfg[181].name)

				arg_112_1.leftNameTxt_.text = var_115_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, false)
				arg_112_1.callingController_:SetSelectedState("normal")

				local var_115_4 = arg_112_1:GetWordFromCfg(111032027)
				local var_115_5 = arg_112_1:FormatText(var_115_4.content)

				arg_112_1.text_.text = var_115_5

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_6 = 19
				local var_115_7 = utf8.len(var_115_5)
				local var_115_8 = var_115_6 <= 0 and var_115_2 or var_115_2 * (var_115_7 / var_115_6)

				if var_115_8 > 0 and var_115_2 < var_115_8 then
					arg_112_1.talkMaxDuration = var_115_8

					if var_115_8 + var_115_1 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_8 + var_115_1
					end
				end

				arg_112_1.text_.text = var_115_5
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111032", "111032027", "story_v_out_111032.awb") ~= 0 then
					local var_115_9 = manager.audio:GetVoiceLength("story_v_out_111032", "111032027", "story_v_out_111032.awb") / 1000

					if var_115_9 + var_115_1 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_9 + var_115_1
					end

					if var_115_4.prefab_name ~= "" and arg_112_1.actors_[var_115_4.prefab_name] ~= nil then
						local var_115_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_112_1.actors_[var_115_4.prefab_name].transform, "story_v_out_111032", "111032027", "story_v_out_111032.awb")

						arg_112_1:RecordAudio("111032027", var_115_10)
						arg_112_1:RecordAudio("111032027", var_115_10)
					else
						arg_112_1:AudioAction("play", "voice", "story_v_out_111032", "111032027", "story_v_out_111032.awb")
					end

					arg_112_1:RecordHistoryTalkVoice("story_v_out_111032", "111032027", "story_v_out_111032.awb")
				end

				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_11 = math.max(var_115_2, arg_112_1.talkMaxDuration)

			if var_115_1 <= arg_112_1.time_ and arg_112_1.time_ < var_115_1 + var_115_11 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_1) / var_115_11

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_1 + var_115_11 and arg_112_1.time_ < var_115_1 + var_115_11 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {}

		arg_112_1:InitPlayNodeList()
	end,
	Play111032028 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 111032028
		arg_116_1.duration_ = 6.4

		local var_116_0 = {
			ja = 6.4,
			ko = 3.866,
			zh = 4.866,
			en = 2.833
		}
		local var_116_1 = manager.audio:GetLocalizationFlag()

		if var_116_0[var_116_1] ~= nil then
			arg_116_1.duration_ = var_116_0[var_116_1]
		end

		SetActive(arg_116_1.tipsGo_, false)

		function arg_116_1.onSingleLineFinish_()
			arg_116_1.onSingleLineUpdate_ = nil
			arg_116_1.onSingleLineFinish_ = nil
			arg_116_1.state_ = "waiting"
		end

		function arg_116_1.playNext_(arg_118_0)
			if arg_118_0 == 1 then
				arg_116_0:Play111032029(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			local var_119_0 = 0

			if var_119_0 < arg_116_1.time_ and arg_116_1.time_ <= var_119_0 + arg_119_0 then
				arg_116_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_119_1 = arg_116_1.actors_["1094ui_story"]
			local var_119_2 = 0

			if var_119_2 < arg_116_1.time_ and arg_116_1.time_ <= var_119_2 + arg_119_0 and not isNil(var_119_1) and arg_116_1.var_.characterEffect1094ui_story == nil then
				arg_116_1.var_.characterEffect1094ui_story = var_119_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_119_3 = 0.2

			if var_119_2 <= arg_116_1.time_ and arg_116_1.time_ < var_119_2 + var_119_3 and not isNil(var_119_1) then
				local var_119_4 = (arg_116_1.time_ - var_119_2) / var_119_3

				if arg_116_1.var_.characterEffect1094ui_story and not isNil(var_119_1) then
					arg_116_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_116_1.time_ >= var_119_2 + var_119_3 and arg_116_1.time_ < var_119_2 + var_119_3 + arg_119_0 and not isNil(var_119_1) and arg_116_1.var_.characterEffect1094ui_story then
				arg_116_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_119_5 = 0
			local var_119_6 = 0.475

			if var_119_5 < arg_116_1.time_ and arg_116_1.time_ <= var_119_5 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, true)

				local var_119_7 = arg_116_1:FormatText(StoryNameCfg[181].name)

				arg_116_1.leftNameTxt_.text = var_119_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_8 = arg_116_1:GetWordFromCfg(111032028)
				local var_119_9 = arg_116_1:FormatText(var_119_8.content)

				arg_116_1.text_.text = var_119_9

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_10 = 19
				local var_119_11 = utf8.len(var_119_9)
				local var_119_12 = var_119_10 <= 0 and var_119_6 or var_119_6 * (var_119_11 / var_119_10)

				if var_119_12 > 0 and var_119_6 < var_119_12 then
					arg_116_1.talkMaxDuration = var_119_12

					if var_119_12 + var_119_5 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_12 + var_119_5
					end
				end

				arg_116_1.text_.text = var_119_9
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111032", "111032028", "story_v_out_111032.awb") ~= 0 then
					local var_119_13 = manager.audio:GetVoiceLength("story_v_out_111032", "111032028", "story_v_out_111032.awb") / 1000

					if var_119_13 + var_119_5 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_13 + var_119_5
					end

					if var_119_8.prefab_name ~= "" and arg_116_1.actors_[var_119_8.prefab_name] ~= nil then
						local var_119_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_116_1.actors_[var_119_8.prefab_name].transform, "story_v_out_111032", "111032028", "story_v_out_111032.awb")

						arg_116_1:RecordAudio("111032028", var_119_14)
						arg_116_1:RecordAudio("111032028", var_119_14)
					else
						arg_116_1:AudioAction("play", "voice", "story_v_out_111032", "111032028", "story_v_out_111032.awb")
					end

					arg_116_1:RecordHistoryTalkVoice("story_v_out_111032", "111032028", "story_v_out_111032.awb")
				end

				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_15 = math.max(var_119_6, arg_116_1.talkMaxDuration)

			if var_119_5 <= arg_116_1.time_ and arg_116_1.time_ < var_119_5 + var_119_15 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_5) / var_119_15

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_5 + var_119_15 and arg_116_1.time_ < var_119_5 + var_119_15 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {}

		arg_116_1:InitPlayNodeList()
	end,
	Play111032029 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 111032029
		arg_120_1.duration_ = 5

		SetActive(arg_120_1.tipsGo_, false)

		function arg_120_1.onSingleLineFinish_()
			arg_120_1.onSingleLineUpdate_ = nil
			arg_120_1.onSingleLineFinish_ = nil
			arg_120_1.state_ = "waiting"
		end

		function arg_120_1.playNext_(arg_122_0)
			if arg_122_0 == 1 then
				arg_120_0:Play111032030(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			local var_123_0 = arg_120_1.actors_["1094ui_story"]
			local var_123_1 = 0

			if var_123_1 < arg_120_1.time_ and arg_120_1.time_ <= var_123_1 + arg_123_0 and not isNil(var_123_0) and arg_120_1.var_.characterEffect1094ui_story == nil then
				arg_120_1.var_.characterEffect1094ui_story = var_123_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_123_2 = 0.2

			if var_123_1 <= arg_120_1.time_ and arg_120_1.time_ < var_123_1 + var_123_2 and not isNil(var_123_0) then
				local var_123_3 = (arg_120_1.time_ - var_123_1) / var_123_2

				if arg_120_1.var_.characterEffect1094ui_story and not isNil(var_123_0) then
					local var_123_4 = Mathf.Lerp(0, 0.5, var_123_3)

					arg_120_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_120_1.var_.characterEffect1094ui_story.fillRatio = var_123_4
				end
			end

			if arg_120_1.time_ >= var_123_1 + var_123_2 and arg_120_1.time_ < var_123_1 + var_123_2 + arg_123_0 and not isNil(var_123_0) and arg_120_1.var_.characterEffect1094ui_story then
				local var_123_5 = 0.5

				arg_120_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_120_1.var_.characterEffect1094ui_story.fillRatio = var_123_5
			end

			local var_123_6 = 0
			local var_123_7 = 0.275

			if var_123_6 < arg_120_1.time_ and arg_120_1.time_ <= var_123_6 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				local var_123_8 = arg_120_1:FormatText(StoryNameCfg[7].name)

				arg_120_1.leftNameTxt_.text = var_123_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, true)
				arg_120_1.iconController_:SetSelectedState("hero")

				arg_120_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_120_1.callingController_:SetSelectedState("normal")

				arg_120_1.keyicon_.color = Color.New(1, 1, 1)
				arg_120_1.icon_.color = Color.New(1, 1, 1)

				local var_123_9 = arg_120_1:GetWordFromCfg(111032029)
				local var_123_10 = arg_120_1:FormatText(var_123_9.content)

				arg_120_1.text_.text = var_123_10

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_11 = 11
				local var_123_12 = utf8.len(var_123_10)
				local var_123_13 = var_123_11 <= 0 and var_123_7 or var_123_7 * (var_123_12 / var_123_11)

				if var_123_13 > 0 and var_123_7 < var_123_13 then
					arg_120_1.talkMaxDuration = var_123_13

					if var_123_13 + var_123_6 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_13 + var_123_6
					end
				end

				arg_120_1.text_.text = var_123_10
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)
				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_14 = math.max(var_123_7, arg_120_1.talkMaxDuration)

			if var_123_6 <= arg_120_1.time_ and arg_120_1.time_ < var_123_6 + var_123_14 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_6) / var_123_14

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_6 + var_123_14 and arg_120_1.time_ < var_123_6 + var_123_14 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {}

		arg_120_1:InitPlayNodeList()
	end,
	Play111032030 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 111032030
		arg_124_1.duration_ = 5.63

		local var_124_0 = {
			ja = 4.433,
			ko = 4.8,
			zh = 5.633,
			en = 3.933
		}
		local var_124_1 = manager.audio:GetLocalizationFlag()

		if var_124_0[var_124_1] ~= nil then
			arg_124_1.duration_ = var_124_0[var_124_1]
		end

		SetActive(arg_124_1.tipsGo_, false)

		function arg_124_1.onSingleLineFinish_()
			arg_124_1.onSingleLineUpdate_ = nil
			arg_124_1.onSingleLineFinish_ = nil
			arg_124_1.state_ = "waiting"
		end

		function arg_124_1.playNext_(arg_126_0)
			if arg_126_0 == 1 then
				arg_124_0:Play111032031(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			local var_127_0 = 0

			if var_127_0 < arg_124_1.time_ and arg_124_1.time_ <= var_127_0 + arg_127_0 then
				arg_124_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094actionlink/1094action453")
			end

			local var_127_1 = 0

			if var_127_1 < arg_124_1.time_ and arg_124_1.time_ <= var_127_1 + arg_127_0 then
				arg_124_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_127_2 = arg_124_1.actors_["1094ui_story"]
			local var_127_3 = 0

			if var_127_3 < arg_124_1.time_ and arg_124_1.time_ <= var_127_3 + arg_127_0 and not isNil(var_127_2) and arg_124_1.var_.characterEffect1094ui_story == nil then
				arg_124_1.var_.characterEffect1094ui_story = var_127_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_127_4 = 0.2

			if var_127_3 <= arg_124_1.time_ and arg_124_1.time_ < var_127_3 + var_127_4 and not isNil(var_127_2) then
				local var_127_5 = (arg_124_1.time_ - var_127_3) / var_127_4

				if arg_124_1.var_.characterEffect1094ui_story and not isNil(var_127_2) then
					arg_124_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_124_1.time_ >= var_127_3 + var_127_4 and arg_124_1.time_ < var_127_3 + var_127_4 + arg_127_0 and not isNil(var_127_2) and arg_124_1.var_.characterEffect1094ui_story then
				arg_124_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_127_6 = 0
			local var_127_7 = 0.45

			if var_127_6 < arg_124_1.time_ and arg_124_1.time_ <= var_127_6 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, true)

				local var_127_8 = arg_124_1:FormatText(StoryNameCfg[181].name)

				arg_124_1.leftNameTxt_.text = var_127_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_124_1.leftNameTxt_.transform)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1.leftNameTxt_.text)
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_9 = arg_124_1:GetWordFromCfg(111032030)
				local var_127_10 = arg_124_1:FormatText(var_127_9.content)

				arg_124_1.text_.text = var_127_10

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_11 = 18
				local var_127_12 = utf8.len(var_127_10)
				local var_127_13 = var_127_11 <= 0 and var_127_7 or var_127_7 * (var_127_12 / var_127_11)

				if var_127_13 > 0 and var_127_7 < var_127_13 then
					arg_124_1.talkMaxDuration = var_127_13

					if var_127_13 + var_127_6 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_13 + var_127_6
					end
				end

				arg_124_1.text_.text = var_127_10
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111032", "111032030", "story_v_out_111032.awb") ~= 0 then
					local var_127_14 = manager.audio:GetVoiceLength("story_v_out_111032", "111032030", "story_v_out_111032.awb") / 1000

					if var_127_14 + var_127_6 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_14 + var_127_6
					end

					if var_127_9.prefab_name ~= "" and arg_124_1.actors_[var_127_9.prefab_name] ~= nil then
						local var_127_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_124_1.actors_[var_127_9.prefab_name].transform, "story_v_out_111032", "111032030", "story_v_out_111032.awb")

						arg_124_1:RecordAudio("111032030", var_127_15)
						arg_124_1:RecordAudio("111032030", var_127_15)
					else
						arg_124_1:AudioAction("play", "voice", "story_v_out_111032", "111032030", "story_v_out_111032.awb")
					end

					arg_124_1:RecordHistoryTalkVoice("story_v_out_111032", "111032030", "story_v_out_111032.awb")
				end

				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_16 = math.max(var_127_7, arg_124_1.talkMaxDuration)

			if var_127_6 <= arg_124_1.time_ and arg_124_1.time_ < var_127_6 + var_127_16 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_6) / var_127_16

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_6 + var_127_16 and arg_124_1.time_ < var_127_6 + var_127_16 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {}

		arg_124_1:InitPlayNodeList()
	end,
	Play111032031 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 111032031
		arg_128_1.duration_ = 5

		SetActive(arg_128_1.tipsGo_, false)

		function arg_128_1.onSingleLineFinish_()
			arg_128_1.onSingleLineUpdate_ = nil
			arg_128_1.onSingleLineFinish_ = nil
			arg_128_1.state_ = "waiting"
		end

		function arg_128_1.playNext_(arg_130_0)
			if arg_130_0 == 1 then
				arg_128_0:Play111032032(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			local var_131_0 = arg_128_1.actors_["1094ui_story"]
			local var_131_1 = 0

			if var_131_1 < arg_128_1.time_ and arg_128_1.time_ <= var_131_1 + arg_131_0 and not isNil(var_131_0) and arg_128_1.var_.characterEffect1094ui_story == nil then
				arg_128_1.var_.characterEffect1094ui_story = var_131_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_131_2 = 0.2

			if var_131_1 <= arg_128_1.time_ and arg_128_1.time_ < var_131_1 + var_131_2 and not isNil(var_131_0) then
				local var_131_3 = (arg_128_1.time_ - var_131_1) / var_131_2

				if arg_128_1.var_.characterEffect1094ui_story and not isNil(var_131_0) then
					local var_131_4 = Mathf.Lerp(0, 0.5, var_131_3)

					arg_128_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_128_1.var_.characterEffect1094ui_story.fillRatio = var_131_4
				end
			end

			if arg_128_1.time_ >= var_131_1 + var_131_2 and arg_128_1.time_ < var_131_1 + var_131_2 + arg_131_0 and not isNil(var_131_0) and arg_128_1.var_.characterEffect1094ui_story then
				local var_131_5 = 0.5

				arg_128_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_128_1.var_.characterEffect1094ui_story.fillRatio = var_131_5
			end

			local var_131_6 = 0
			local var_131_7 = 0.85

			if var_131_6 < arg_128_1.time_ and arg_128_1.time_ <= var_131_6 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				local var_131_8 = arg_128_1:FormatText(StoryNameCfg[7].name)

				arg_128_1.leftNameTxt_.text = var_131_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, true)
				arg_128_1.iconController_:SetSelectedState("hero")

				arg_128_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_128_1.callingController_:SetSelectedState("normal")

				arg_128_1.keyicon_.color = Color.New(1, 1, 1)
				arg_128_1.icon_.color = Color.New(1, 1, 1)

				local var_131_9 = arg_128_1:GetWordFromCfg(111032031)
				local var_131_10 = arg_128_1:FormatText(var_131_9.content)

				arg_128_1.text_.text = var_131_10

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_11 = 34
				local var_131_12 = utf8.len(var_131_10)
				local var_131_13 = var_131_11 <= 0 and var_131_7 or var_131_7 * (var_131_12 / var_131_11)

				if var_131_13 > 0 and var_131_7 < var_131_13 then
					arg_128_1.talkMaxDuration = var_131_13

					if var_131_13 + var_131_6 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_13 + var_131_6
					end
				end

				arg_128_1.text_.text = var_131_10
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)
				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_14 = math.max(var_131_7, arg_128_1.talkMaxDuration)

			if var_131_6 <= arg_128_1.time_ and arg_128_1.time_ < var_131_6 + var_131_14 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_6) / var_131_14

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_6 + var_131_14 and arg_128_1.time_ < var_131_6 + var_131_14 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {}

		arg_128_1:InitPlayNodeList()
	end,
	Play111032032 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 111032032
		arg_132_1.duration_ = 2

		SetActive(arg_132_1.tipsGo_, false)

		function arg_132_1.onSingleLineFinish_()
			arg_132_1.onSingleLineUpdate_ = nil
			arg_132_1.onSingleLineFinish_ = nil
			arg_132_1.state_ = "waiting"
		end

		function arg_132_1.playNext_(arg_134_0)
			if arg_134_0 == 1 then
				arg_132_0:Play111032033(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			local var_135_0 = 0

			if var_135_0 < arg_132_1.time_ and arg_132_1.time_ <= var_135_0 + arg_135_0 then
				arg_132_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_135_1 = arg_132_1.actors_["1094ui_story"]
			local var_135_2 = 0

			if var_135_2 < arg_132_1.time_ and arg_132_1.time_ <= var_135_2 + arg_135_0 and not isNil(var_135_1) and arg_132_1.var_.characterEffect1094ui_story == nil then
				arg_132_1.var_.characterEffect1094ui_story = var_135_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_135_3 = 0.2

			if var_135_2 <= arg_132_1.time_ and arg_132_1.time_ < var_135_2 + var_135_3 and not isNil(var_135_1) then
				local var_135_4 = (arg_132_1.time_ - var_135_2) / var_135_3

				if arg_132_1.var_.characterEffect1094ui_story and not isNil(var_135_1) then
					arg_132_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_132_1.time_ >= var_135_2 + var_135_3 and arg_132_1.time_ < var_135_2 + var_135_3 + arg_135_0 and not isNil(var_135_1) and arg_132_1.var_.characterEffect1094ui_story then
				arg_132_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_135_5 = 0
			local var_135_6 = 0.2

			if var_135_5 < arg_132_1.time_ and arg_132_1.time_ <= var_135_5 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, true)

				local var_135_7 = arg_132_1:FormatText(StoryNameCfg[181].name)

				arg_132_1.leftNameTxt_.text = var_135_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_8 = arg_132_1:GetWordFromCfg(111032032)
				local var_135_9 = arg_132_1:FormatText(var_135_8.content)

				arg_132_1.text_.text = var_135_9

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_10 = 2
				local var_135_11 = utf8.len(var_135_9)
				local var_135_12 = var_135_10 <= 0 and var_135_6 or var_135_6 * (var_135_11 / var_135_10)

				if var_135_12 > 0 and var_135_6 < var_135_12 then
					arg_132_1.talkMaxDuration = var_135_12

					if var_135_12 + var_135_5 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_12 + var_135_5
					end
				end

				arg_132_1.text_.text = var_135_9
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111032", "111032032", "story_v_out_111032.awb") ~= 0 then
					local var_135_13 = manager.audio:GetVoiceLength("story_v_out_111032", "111032032", "story_v_out_111032.awb") / 1000

					if var_135_13 + var_135_5 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_13 + var_135_5
					end

					if var_135_8.prefab_name ~= "" and arg_132_1.actors_[var_135_8.prefab_name] ~= nil then
						local var_135_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_132_1.actors_[var_135_8.prefab_name].transform, "story_v_out_111032", "111032032", "story_v_out_111032.awb")

						arg_132_1:RecordAudio("111032032", var_135_14)
						arg_132_1:RecordAudio("111032032", var_135_14)
					else
						arg_132_1:AudioAction("play", "voice", "story_v_out_111032", "111032032", "story_v_out_111032.awb")
					end

					arg_132_1:RecordHistoryTalkVoice("story_v_out_111032", "111032032", "story_v_out_111032.awb")
				end

				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_15 = math.max(var_135_6, arg_132_1.talkMaxDuration)

			if var_135_5 <= arg_132_1.time_ and arg_132_1.time_ < var_135_5 + var_135_15 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_5) / var_135_15

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_5 + var_135_15 and arg_132_1.time_ < var_135_5 + var_135_15 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {}

		arg_132_1:InitPlayNodeList()
	end,
	Play111032033 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 111032033
		arg_136_1.duration_ = 5

		SetActive(arg_136_1.tipsGo_, false)

		function arg_136_1.onSingleLineFinish_()
			arg_136_1.onSingleLineUpdate_ = nil
			arg_136_1.onSingleLineFinish_ = nil
			arg_136_1.state_ = "waiting"
		end

		function arg_136_1.playNext_(arg_138_0)
			if arg_138_0 == 1 then
				arg_136_0:Play111032034(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			local var_139_0 = arg_136_1.actors_["1094ui_story"].transform
			local var_139_1 = 0

			if var_139_1 < arg_136_1.time_ and arg_136_1.time_ <= var_139_1 + arg_139_0 then
				arg_136_1.var_.moveOldPos1094ui_story = var_139_0.localPosition
			end

			local var_139_2 = 0.001

			if var_139_1 <= arg_136_1.time_ and arg_136_1.time_ < var_139_1 + var_139_2 then
				local var_139_3 = (arg_136_1.time_ - var_139_1) / var_139_2
				local var_139_4 = Vector3.New(0, 100, 0)

				var_139_0.localPosition = Vector3.Lerp(arg_136_1.var_.moveOldPos1094ui_story, var_139_4, var_139_3)

				local var_139_5 = manager.ui.mainCamera.transform.position - var_139_0.position

				var_139_0.forward = Vector3.New(var_139_5.x, var_139_5.y, var_139_5.z)

				local var_139_6 = var_139_0.localEulerAngles

				var_139_6.z = 0
				var_139_6.x = 0
				var_139_0.localEulerAngles = var_139_6
			end

			if arg_136_1.time_ >= var_139_1 + var_139_2 and arg_136_1.time_ < var_139_1 + var_139_2 + arg_139_0 then
				var_139_0.localPosition = Vector3.New(0, 100, 0)

				local var_139_7 = manager.ui.mainCamera.transform.position - var_139_0.position

				var_139_0.forward = Vector3.New(var_139_7.x, var_139_7.y, var_139_7.z)

				local var_139_8 = var_139_0.localEulerAngles

				var_139_8.z = 0
				var_139_8.x = 0
				var_139_0.localEulerAngles = var_139_8
			end

			local var_139_9 = 0
			local var_139_10 = 1.5

			if var_139_9 < arg_136_1.time_ and arg_136_1.time_ <= var_139_9 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, false)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_136_1.iconTrs_.gameObject, false)
				arg_136_1.callingController_:SetSelectedState("normal")

				local var_139_11 = arg_136_1:GetWordFromCfg(111032033)
				local var_139_12 = arg_136_1:FormatText(var_139_11.content)

				arg_136_1.text_.text = var_139_12

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_13 = 60
				local var_139_14 = utf8.len(var_139_12)
				local var_139_15 = var_139_13 <= 0 and var_139_10 or var_139_10 * (var_139_14 / var_139_13)

				if var_139_15 > 0 and var_139_10 < var_139_15 then
					arg_136_1.talkMaxDuration = var_139_15

					if var_139_15 + var_139_9 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_15 + var_139_9
					end
				end

				arg_136_1.text_.text = var_139_12
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)
				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_16 = math.max(var_139_10, arg_136_1.talkMaxDuration)

			if var_139_9 <= arg_136_1.time_ and arg_136_1.time_ < var_139_9 + var_139_16 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_9) / var_139_16

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_9 + var_139_16 and arg_136_1.time_ < var_139_9 + var_139_16 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_136_1:InitPlayNodeList()
	end,
	Play111032034 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 111032034
		arg_140_1.duration_ = 5

		SetActive(arg_140_1.tipsGo_, false)

		function arg_140_1.onSingleLineFinish_()
			arg_140_1.onSingleLineUpdate_ = nil
			arg_140_1.onSingleLineFinish_ = nil
			arg_140_1.state_ = "waiting"
		end

		function arg_140_1.playNext_(arg_142_0)
			if arg_142_0 == 1 then
				arg_140_0:Play111032035(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			local var_143_0 = 0
			local var_143_1 = 0.775

			if var_143_0 < arg_140_1.time_ and arg_140_1.time_ <= var_143_0 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, false)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_140_1.iconTrs_.gameObject, false)
				arg_140_1.callingController_:SetSelectedState("normal")

				local var_143_2 = arg_140_1:GetWordFromCfg(111032034)
				local var_143_3 = arg_140_1:FormatText(var_143_2.content)

				arg_140_1.text_.text = var_143_3

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_4 = 31
				local var_143_5 = utf8.len(var_143_3)
				local var_143_6 = var_143_4 <= 0 and var_143_1 or var_143_1 * (var_143_5 / var_143_4)

				if var_143_6 > 0 and var_143_1 < var_143_6 then
					arg_140_1.talkMaxDuration = var_143_6

					if var_143_6 + var_143_0 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_6 + var_143_0
					end
				end

				arg_140_1.text_.text = var_143_3
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)
				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_7 = math.max(var_143_1, arg_140_1.talkMaxDuration)

			if var_143_0 <= arg_140_1.time_ and arg_140_1.time_ < var_143_0 + var_143_7 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_0) / var_143_7

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_0 + var_143_7 and arg_140_1.time_ < var_143_0 + var_143_7 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {}

		arg_140_1:InitPlayNodeList()
	end,
	Play111032035 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 111032035
		arg_144_1.duration_ = 5

		SetActive(arg_144_1.tipsGo_, false)

		function arg_144_1.onSingleLineFinish_()
			arg_144_1.onSingleLineUpdate_ = nil
			arg_144_1.onSingleLineFinish_ = nil
			arg_144_1.state_ = "waiting"
		end

		function arg_144_1.playNext_(arg_146_0)
			if arg_146_0 == 1 then
				arg_144_0:Play111032036(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			local var_147_0 = 0
			local var_147_1 = 0.4

			if var_147_0 < arg_144_1.time_ and arg_144_1.time_ <= var_147_0 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, true)

				local var_147_2 = arg_144_1:FormatText(StoryNameCfg[7].name)

				arg_144_1.leftNameTxt_.text = var_147_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_144_1.leftNameTxt_.transform)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1.leftNameTxt_.text)
				SetActive(arg_144_1.iconTrs_.gameObject, true)
				arg_144_1.iconController_:SetSelectedState("hero")

				arg_144_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_144_1.callingController_:SetSelectedState("normal")

				arg_144_1.keyicon_.color = Color.New(1, 1, 1)
				arg_144_1.icon_.color = Color.New(1, 1, 1)

				local var_147_3 = arg_144_1:GetWordFromCfg(111032035)
				local var_147_4 = arg_144_1:FormatText(var_147_3.content)

				arg_144_1.text_.text = var_147_4

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_5 = 16
				local var_147_6 = utf8.len(var_147_4)
				local var_147_7 = var_147_5 <= 0 and var_147_1 or var_147_1 * (var_147_6 / var_147_5)

				if var_147_7 > 0 and var_147_1 < var_147_7 then
					arg_144_1.talkMaxDuration = var_147_7

					if var_147_7 + var_147_0 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_7 + var_147_0
					end
				end

				arg_144_1.text_.text = var_147_4
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)
				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_8 = math.max(var_147_1, arg_144_1.talkMaxDuration)

			if var_147_0 <= arg_144_1.time_ and arg_144_1.time_ < var_147_0 + var_147_8 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - var_147_0) / var_147_8

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= var_147_0 + var_147_8 and arg_144_1.time_ < var_147_0 + var_147_8 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {}

		arg_144_1:InitPlayNodeList()
	end,
	Play111032036 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 111032036
		arg_148_1.duration_ = 5.3

		local var_148_0 = {
			ja = 5.3,
			ko = 2.466,
			zh = 3.433,
			en = 2.533
		}
		local var_148_1 = manager.audio:GetLocalizationFlag()

		if var_148_0[var_148_1] ~= nil then
			arg_148_1.duration_ = var_148_0[var_148_1]
		end

		SetActive(arg_148_1.tipsGo_, false)

		function arg_148_1.onSingleLineFinish_()
			arg_148_1.onSingleLineUpdate_ = nil
			arg_148_1.onSingleLineFinish_ = nil
			arg_148_1.state_ = "waiting"
		end

		function arg_148_1.playNext_(arg_150_0)
			if arg_150_0 == 1 then
				arg_148_0:Play111032037(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			local var_151_0 = 0
			local var_151_1 = 0.275

			if var_151_0 < arg_148_1.time_ and arg_148_1.time_ <= var_151_0 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, true)

				local var_151_2 = arg_148_1:FormatText(StoryNameCfg[181].name)

				arg_148_1.leftNameTxt_.text = var_151_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_148_1.leftNameTxt_.transform)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1.leftNameTxt_.text)
				SetActive(arg_148_1.iconTrs_.gameObject, true)
				arg_148_1.iconController_:SetSelectedState("hero")

				arg_148_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1094")

				arg_148_1.callingController_:SetSelectedState("normal")

				arg_148_1.keyicon_.color = Color.New(1, 1, 1)
				arg_148_1.icon_.color = Color.New(1, 1, 1)

				local var_151_3 = arg_148_1:GetWordFromCfg(111032036)
				local var_151_4 = arg_148_1:FormatText(var_151_3.content)

				arg_148_1.text_.text = var_151_4

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_5 = 11
				local var_151_6 = utf8.len(var_151_4)
				local var_151_7 = var_151_5 <= 0 and var_151_1 or var_151_1 * (var_151_6 / var_151_5)

				if var_151_7 > 0 and var_151_1 < var_151_7 then
					arg_148_1.talkMaxDuration = var_151_7

					if var_151_7 + var_151_0 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_7 + var_151_0
					end
				end

				arg_148_1.text_.text = var_151_4
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111032", "111032036", "story_v_out_111032.awb") ~= 0 then
					local var_151_8 = manager.audio:GetVoiceLength("story_v_out_111032", "111032036", "story_v_out_111032.awb") / 1000

					if var_151_8 + var_151_0 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_8 + var_151_0
					end

					if var_151_3.prefab_name ~= "" and arg_148_1.actors_[var_151_3.prefab_name] ~= nil then
						local var_151_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_148_1.actors_[var_151_3.prefab_name].transform, "story_v_out_111032", "111032036", "story_v_out_111032.awb")

						arg_148_1:RecordAudio("111032036", var_151_9)
						arg_148_1:RecordAudio("111032036", var_151_9)
					else
						arg_148_1:AudioAction("play", "voice", "story_v_out_111032", "111032036", "story_v_out_111032.awb")
					end

					arg_148_1:RecordHistoryTalkVoice("story_v_out_111032", "111032036", "story_v_out_111032.awb")
				end

				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_10 = math.max(var_151_1, arg_148_1.talkMaxDuration)

			if var_151_0 <= arg_148_1.time_ and arg_148_1.time_ < var_151_0 + var_151_10 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - var_151_0) / var_151_10

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= var_151_0 + var_151_10 and arg_148_1.time_ < var_151_0 + var_151_10 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {}

		arg_148_1:InitPlayNodeList()
	end,
	Play111032037 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 111032037
		arg_152_1.duration_ = 5

		SetActive(arg_152_1.tipsGo_, false)

		function arg_152_1.onSingleLineFinish_()
			arg_152_1.onSingleLineUpdate_ = nil
			arg_152_1.onSingleLineFinish_ = nil
			arg_152_1.state_ = "waiting"
		end

		function arg_152_1.playNext_(arg_154_0)
			if arg_154_0 == 1 then
				arg_152_0:Play111032038(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			local var_155_0 = 0
			local var_155_1 = 0.95

			if var_155_0 < arg_152_1.time_ and arg_152_1.time_ <= var_155_0 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, false)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_152_1.iconTrs_.gameObject, false)
				arg_152_1.callingController_:SetSelectedState("normal")

				local var_155_2 = arg_152_1:GetWordFromCfg(111032037)
				local var_155_3 = arg_152_1:FormatText(var_155_2.content)

				arg_152_1.text_.text = var_155_3

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_4 = 38
				local var_155_5 = utf8.len(var_155_3)
				local var_155_6 = var_155_4 <= 0 and var_155_1 or var_155_1 * (var_155_5 / var_155_4)

				if var_155_6 > 0 and var_155_1 < var_155_6 then
					arg_152_1.talkMaxDuration = var_155_6

					if var_155_6 + var_155_0 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_6 + var_155_0
					end
				end

				arg_152_1.text_.text = var_155_3
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)
				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_7 = math.max(var_155_1, arg_152_1.talkMaxDuration)

			if var_155_0 <= arg_152_1.time_ and arg_152_1.time_ < var_155_0 + var_155_7 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - var_155_0) / var_155_7

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= var_155_0 + var_155_7 and arg_152_1.time_ < var_155_0 + var_155_7 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {}

		arg_152_1:InitPlayNodeList()
	end,
	Play111032038 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 111032038
		arg_156_1.duration_ = 5

		SetActive(arg_156_1.tipsGo_, false)

		function arg_156_1.onSingleLineFinish_()
			arg_156_1.onSingleLineUpdate_ = nil
			arg_156_1.onSingleLineFinish_ = nil
			arg_156_1.state_ = "waiting"
		end

		function arg_156_1.playNext_(arg_158_0)
			if arg_158_0 == 1 then
				arg_156_0:Play111032039(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			local var_159_0 = 0
			local var_159_1 = 1.175

			if var_159_0 < arg_156_1.time_ and arg_156_1.time_ <= var_159_0 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, false)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_156_1.iconTrs_.gameObject, false)
				arg_156_1.callingController_:SetSelectedState("normal")

				local var_159_2 = arg_156_1:GetWordFromCfg(111032038)
				local var_159_3 = arg_156_1:FormatText(var_159_2.content)

				arg_156_1.text_.text = var_159_3

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_4 = 46
				local var_159_5 = utf8.len(var_159_3)
				local var_159_6 = var_159_4 <= 0 and var_159_1 or var_159_1 * (var_159_5 / var_159_4)

				if var_159_6 > 0 and var_159_1 < var_159_6 then
					arg_156_1.talkMaxDuration = var_159_6

					if var_159_6 + var_159_0 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_6 + var_159_0
					end
				end

				arg_156_1.text_.text = var_159_3
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)
				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_7 = math.max(var_159_1, arg_156_1.talkMaxDuration)

			if var_159_0 <= arg_156_1.time_ and arg_156_1.time_ < var_159_0 + var_159_7 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - var_159_0) / var_159_7

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= var_159_0 + var_159_7 and arg_156_1.time_ < var_159_0 + var_159_7 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {}

		arg_156_1:InitPlayNodeList()
	end,
	Play111032039 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 111032039
		arg_160_1.duration_ = 6.13

		SetActive(arg_160_1.tipsGo_, false)

		function arg_160_1.onSingleLineFinish_()
			arg_160_1.onSingleLineUpdate_ = nil
			arg_160_1.onSingleLineFinish_ = nil
			arg_160_1.state_ = "waiting"
		end

		function arg_160_1.playNext_(arg_162_0)
			if arg_162_0 == 1 then
				arg_160_0:Play111032040(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			local var_163_0 = arg_160_1.bgs_.D05
			local var_163_1 = 0

			if var_163_1 < arg_160_1.time_ and arg_160_1.time_ <= var_163_1 + arg_163_0 then
				local var_163_2 = var_163_0:GetComponent("SpriteRenderer")

				if var_163_2 then
					arg_160_1.var_.alphaOldValueD05 = var_163_2.color.a
					arg_160_1.var_.alphaMatValueD05 = var_163_2
				end

				arg_160_1.var_.alphaOldValueD05 = 1
			end

			local var_163_3 = 2

			if var_163_1 <= arg_160_1.time_ and arg_160_1.time_ < var_163_1 + var_163_3 then
				local var_163_4 = (arg_160_1.time_ - var_163_1) / var_163_3
				local var_163_5 = Mathf.Lerp(arg_160_1.var_.alphaOldValueD05, 0, var_163_4)

				if arg_160_1.var_.alphaMatValueD05 then
					local var_163_6 = arg_160_1.var_.alphaMatValueD05.color

					var_163_6.a = var_163_5
					arg_160_1.var_.alphaMatValueD05.color = var_163_6
				end
			end

			if arg_160_1.time_ >= var_163_1 + var_163_3 and arg_160_1.time_ < var_163_1 + var_163_3 + arg_163_0 and arg_160_1.var_.alphaMatValueD05 then
				local var_163_7 = arg_160_1.var_.alphaMatValueD05
				local var_163_8 = var_163_7.color

				var_163_8.a = 0
				var_163_7.color = var_163_8
			end

			local var_163_9 = arg_160_1.bgs_.D05
			local var_163_10 = 2

			if var_163_10 < arg_160_1.time_ and arg_160_1.time_ <= var_163_10 + arg_163_0 then
				local var_163_11 = var_163_9:GetComponent("SpriteRenderer")

				if var_163_11 then
					arg_160_1.var_.alphaOldValueD05 = var_163_11.color.a
					arg_160_1.var_.alphaMatValueD05 = var_163_11
				end
			end

			local var_163_12 = 1.3

			if var_163_10 <= arg_160_1.time_ and arg_160_1.time_ < var_163_10 + var_163_12 then
				local var_163_13 = (arg_160_1.time_ - var_163_10) / var_163_12
				local var_163_14 = Mathf.Lerp(arg_160_1.var_.alphaOldValueD05, 0.5, var_163_13)

				if arg_160_1.var_.alphaMatValueD05 then
					local var_163_15 = arg_160_1.var_.alphaMatValueD05.color

					var_163_15.a = var_163_14
					arg_160_1.var_.alphaMatValueD05.color = var_163_15
				end
			end

			if arg_160_1.time_ >= var_163_10 + var_163_12 and arg_160_1.time_ < var_163_10 + var_163_12 + arg_163_0 and arg_160_1.var_.alphaMatValueD05 then
				local var_163_16 = arg_160_1.var_.alphaMatValueD05
				local var_163_17 = var_163_16.color

				var_163_17.a = 0.5
				var_163_16.color = var_163_17
			end

			local var_163_18 = arg_160_1.bgs_.D05
			local var_163_19 = 3.3

			if var_163_19 < arg_160_1.time_ and arg_160_1.time_ <= var_163_19 + arg_163_0 then
				local var_163_20 = var_163_18:GetComponent("SpriteRenderer")

				if var_163_20 then
					arg_160_1.var_.alphaOldValueD05 = var_163_20.color.a
					arg_160_1.var_.alphaMatValueD05 = var_163_20
				end

				arg_160_1.var_.alphaOldValueD05 = 1
			end

			local var_163_21 = 2.83333333333333

			if var_163_19 <= arg_160_1.time_ and arg_160_1.time_ < var_163_19 + var_163_21 then
				local var_163_22 = (arg_160_1.time_ - var_163_19) / var_163_21
				local var_163_23 = Mathf.Lerp(arg_160_1.var_.alphaOldValueD05, 0, var_163_22)

				if arg_160_1.var_.alphaMatValueD05 then
					local var_163_24 = arg_160_1.var_.alphaMatValueD05.color

					var_163_24.a = var_163_23
					arg_160_1.var_.alphaMatValueD05.color = var_163_24
				end
			end

			if arg_160_1.time_ >= var_163_19 + var_163_21 and arg_160_1.time_ < var_163_19 + var_163_21 + arg_163_0 and arg_160_1.var_.alphaMatValueD05 then
				local var_163_25 = arg_160_1.var_.alphaMatValueD05
				local var_163_26 = var_163_25.color

				var_163_26.a = 0
				var_163_25.color = var_163_26
			end

			local var_163_27 = 0

			if var_163_27 < arg_160_1.time_ and arg_160_1.time_ <= var_163_27 + arg_163_0 then
				arg_160_1.allBtn_.enabled = false
			end

			local var_163_28 = 6.13333333333333

			if arg_160_1.time_ >= var_163_27 + var_163_28 and arg_160_1.time_ < var_163_27 + var_163_28 + arg_163_0 then
				arg_160_1.allBtn_.enabled = true
			end

			local var_163_29 = 0
			local var_163_30 = 0.9

			if var_163_29 < arg_160_1.time_ and arg_160_1.time_ <= var_163_29 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0
				arg_160_1.dialogCg_.alpha = 1

				arg_160_1.dialog_:SetActive(true)
				SetActive(arg_160_1.leftNameGo_, false)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_160_1.iconTrs_.gameObject, false)
				arg_160_1.callingController_:SetSelectedState("normal")

				local var_163_31 = arg_160_1:GetWordFromCfg(111032039)
				local var_163_32 = arg_160_1:FormatText(var_163_31.content)

				arg_160_1.text_.text = var_163_32

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_33 = 36
				local var_163_34 = utf8.len(var_163_32)
				local var_163_35 = var_163_33 <= 0 and var_163_30 or var_163_30 * (var_163_34 / var_163_33)

				if var_163_35 > 0 and var_163_30 < var_163_35 then
					arg_160_1.talkMaxDuration = var_163_35

					if var_163_35 + var_163_29 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_35 + var_163_29
					end
				end

				arg_160_1.text_.text = var_163_32
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)
				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_36 = math.max(var_163_30, arg_160_1.talkMaxDuration)

			if var_163_29 <= arg_160_1.time_ and arg_160_1.time_ < var_163_29 + var_163_36 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - var_163_29) / var_163_36

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= var_163_29 + var_163_36 and arg_160_1.time_ < var_163_29 + var_163_36 + arg_163_0 then
				arg_160_1.typewritter.percent = 1

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(true)
			end
		end

		arg_160_1.nodeConfigList_ = {}

		arg_160_1:InitPlayNodeList()
	end,
	Play111032040 = function(arg_164_0, arg_164_1)
		arg_164_1.time_ = 0
		arg_164_1.frameCnt_ = 0
		arg_164_1.state_ = "playing"
		arg_164_1.curTalkId_ = 111032040
		arg_164_1.duration_ = 3.1

		local var_164_0 = {
			ja = 2.93266666666667,
			ko = 2.799999999999,
			zh = 2.799999999999,
			en = 3.09966666666667
		}
		local var_164_1 = manager.audio:GetLocalizationFlag()

		if var_164_0[var_164_1] ~= nil then
			arg_164_1.duration_ = var_164_0[var_164_1]
		end

		SetActive(arg_164_1.tipsGo_, false)

		function arg_164_1.onSingleLineFinish_()
			arg_164_1.onSingleLineUpdate_ = nil
			arg_164_1.onSingleLineFinish_ = nil
			arg_164_1.state_ = "waiting"
		end

		function arg_164_1.playNext_(arg_166_0)
			if arg_166_0 == 1 then
				arg_164_0:Play111032041(arg_164_1)
			end
		end

		function arg_164_1.onSingleLineUpdate_(arg_167_0)
			local var_167_0 = "1039ui_story"

			if arg_164_1.actors_[var_167_0] == nil then
				local var_167_1 = Asset.Load("Char/" .. "1039ui_story")

				if not isNil(var_167_1) then
					local var_167_2 = Object.Instantiate(Asset.Load("Char/" .. "1039ui_story"), arg_164_1.stage_.transform)

					var_167_2.name = var_167_0
					var_167_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_164_1.actors_[var_167_0] = var_167_2

					local var_167_3 = var_167_2:GetComponentInChildren(typeof(CharacterEffect))

					var_167_3.enabled = true

					local var_167_4 = GameObjectTools.GetOrAddComponent(var_167_2, typeof(DynamicBoneHelper))

					if var_167_4 then
						var_167_4:EnableDynamicBone(false)
					end

					arg_164_1:ShowWeapon(var_167_3.transform, false)

					arg_164_1.var_[var_167_0 .. "Animator"] = var_167_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_164_1.var_[var_167_0 .. "Animator"].applyRootMotion = true
					arg_164_1.var_[var_167_0 .. "LipSync"] = var_167_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_167_5 = arg_164_1.actors_["1039ui_story"].transform
			local var_167_6 = 0.8

			if var_167_6 < arg_164_1.time_ and arg_164_1.time_ <= var_167_6 + arg_167_0 then
				arg_164_1.var_.moveOldPos1039ui_story = var_167_5.localPosition
			end

			local var_167_7 = 0.001

			if var_167_6 <= arg_164_1.time_ and arg_164_1.time_ < var_167_6 + var_167_7 then
				local var_167_8 = (arg_164_1.time_ - var_167_6) / var_167_7
				local var_167_9 = Vector3.New(-0.7, -1.01, -5.9)

				var_167_5.localPosition = Vector3.Lerp(arg_164_1.var_.moveOldPos1039ui_story, var_167_9, var_167_8)

				local var_167_10 = manager.ui.mainCamera.transform.position - var_167_5.position

				var_167_5.forward = Vector3.New(var_167_10.x, var_167_10.y, var_167_10.z)

				local var_167_11 = var_167_5.localEulerAngles

				var_167_11.z = 0
				var_167_11.x = 0
				var_167_5.localEulerAngles = var_167_11
			end

			if arg_164_1.time_ >= var_167_6 + var_167_7 and arg_164_1.time_ < var_167_6 + var_167_7 + arg_167_0 then
				var_167_5.localPosition = Vector3.New(-0.7, -1.01, -5.9)

				local var_167_12 = manager.ui.mainCamera.transform.position - var_167_5.position

				var_167_5.forward = Vector3.New(var_167_12.x, var_167_12.y, var_167_12.z)

				local var_167_13 = var_167_5.localEulerAngles

				var_167_13.z = 0
				var_167_13.x = 0
				var_167_5.localEulerAngles = var_167_13
			end

			local var_167_14 = 0.8

			if var_167_14 < arg_164_1.time_ and arg_164_1.time_ <= var_167_14 + arg_167_0 then
				arg_164_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action5_1")
			end

			local var_167_15 = 0.8

			if var_167_15 < arg_164_1.time_ and arg_164_1.time_ <= var_167_15 + arg_167_0 then
				arg_164_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2203cva")
			end

			local var_167_16 = arg_164_1.actors_["1039ui_story"]
			local var_167_17 = 0.8

			if var_167_17 < arg_164_1.time_ and arg_164_1.time_ <= var_167_17 + arg_167_0 and not isNil(var_167_16) and arg_164_1.var_.characterEffect1039ui_story == nil then
				arg_164_1.var_.characterEffect1039ui_story = var_167_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_167_18 = 0.2

			if var_167_17 <= arg_164_1.time_ and arg_164_1.time_ < var_167_17 + var_167_18 and not isNil(var_167_16) then
				local var_167_19 = (arg_164_1.time_ - var_167_17) / var_167_18

				if arg_164_1.var_.characterEffect1039ui_story and not isNil(var_167_16) then
					arg_164_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_164_1.time_ >= var_167_17 + var_167_18 and arg_164_1.time_ < var_167_17 + var_167_18 + arg_167_0 and not isNil(var_167_16) and arg_164_1.var_.characterEffect1039ui_story then
				arg_164_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_167_20 = arg_164_1.bgs_.D05
			local var_167_21 = 0

			if var_167_21 < arg_164_1.time_ and arg_164_1.time_ <= var_167_21 + arg_167_0 then
				local var_167_22 = var_167_20:GetComponent("SpriteRenderer")

				if var_167_22 then
					arg_164_1.var_.alphaOldValueD05 = var_167_22.color.a
					arg_164_1.var_.alphaMatValueD05 = var_167_22
				end

				arg_164_1.var_.alphaOldValueD05 = 0
			end

			local var_167_23 = 1

			if var_167_21 <= arg_164_1.time_ and arg_164_1.time_ < var_167_21 + var_167_23 then
				local var_167_24 = (arg_164_1.time_ - var_167_21) / var_167_23
				local var_167_25 = Mathf.Lerp(arg_164_1.var_.alphaOldValueD05, 1, var_167_24)

				if arg_164_1.var_.alphaMatValueD05 then
					local var_167_26 = arg_164_1.var_.alphaMatValueD05.color

					var_167_26.a = var_167_25
					arg_164_1.var_.alphaMatValueD05.color = var_167_26
				end
			end

			if arg_164_1.time_ >= var_167_21 + var_167_23 and arg_164_1.time_ < var_167_21 + var_167_23 + arg_167_0 and arg_164_1.var_.alphaMatValueD05 then
				local var_167_27 = arg_164_1.var_.alphaMatValueD05
				local var_167_28 = var_167_27.color

				var_167_28.a = 1
				var_167_27.color = var_167_28
			end

			local var_167_29 = 0

			if var_167_29 < arg_164_1.time_ and arg_164_1.time_ <= var_167_29 + arg_167_0 then
				arg_164_1.allBtn_.enabled = false
			end

			local var_167_30 = 1

			if arg_164_1.time_ >= var_167_29 + var_167_30 and arg_164_1.time_ < var_167_29 + var_167_30 + arg_167_0 then
				arg_164_1.allBtn_.enabled = true
			end

			if arg_164_1.frameCnt_ <= 1 then
				arg_164_1.dialog_:SetActive(false)
			end

			local var_167_31 = 0.166666666666667
			local var_167_32 = 0.25

			if var_167_31 < arg_164_1.time_ and arg_164_1.time_ <= var_167_31 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0

				arg_164_1.dialog_:SetActive(true)

				arg_164_1.dialogCg_.alpha = 0

				local var_167_33 = LeanTween.value(arg_164_1.dialog_, 0, 1, 0.3)

				var_167_33:setOnUpdate(LuaHelper.FloatAction(function(arg_168_0)
					arg_164_1.dialogCg_.alpha = arg_168_0
				end))
				var_167_33:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_164_1.dialog_)
					var_167_33:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_164_1.duration_ = arg_164_1.duration_ + 0.3

				SetActive(arg_164_1.leftNameGo_, true)

				local var_167_34 = arg_164_1:FormatText(StoryNameCfg[9].name)

				arg_164_1.leftNameTxt_.text = var_167_34

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_164_1.leftNameTxt_.transform)

				arg_164_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_164_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_164_1:RecordName(arg_164_1.leftNameTxt_.text)
				SetActive(arg_164_1.iconTrs_.gameObject, false)
				arg_164_1.callingController_:SetSelectedState("normal")

				local var_167_35 = arg_164_1:GetWordFromCfg(111032040)
				local var_167_36 = arg_164_1:FormatText(var_167_35.content)

				arg_164_1.text_.text = var_167_36

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_37 = 10
				local var_167_38 = utf8.len(var_167_36)
				local var_167_39 = var_167_37 <= 0 and var_167_32 or var_167_32 * (var_167_38 / var_167_37)

				if var_167_39 > 0 and var_167_32 < var_167_39 then
					arg_164_1.talkMaxDuration = var_167_39
					var_167_31 = var_167_31 + 0.3

					if var_167_39 + var_167_31 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_39 + var_167_31
					end
				end

				arg_164_1.text_.text = var_167_36
				arg_164_1.typewritter.percent = 0

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111032", "111032040", "story_v_out_111032.awb") ~= 0 then
					local var_167_40 = manager.audio:GetVoiceLength("story_v_out_111032", "111032040", "story_v_out_111032.awb") / 1000

					if var_167_40 + var_167_31 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_40 + var_167_31
					end

					if var_167_35.prefab_name ~= "" and arg_164_1.actors_[var_167_35.prefab_name] ~= nil then
						local var_167_41 = LuaForUtil.PlayVoiceWithCriLipsync(arg_164_1.actors_[var_167_35.prefab_name].transform, "story_v_out_111032", "111032040", "story_v_out_111032.awb")

						arg_164_1:RecordAudio("111032040", var_167_41)
						arg_164_1:RecordAudio("111032040", var_167_41)
					else
						arg_164_1:AudioAction("play", "voice", "story_v_out_111032", "111032040", "story_v_out_111032.awb")
					end

					arg_164_1:RecordHistoryTalkVoice("story_v_out_111032", "111032040", "story_v_out_111032.awb")
				end

				arg_164_1:RecordContent(arg_164_1.text_.text)
			end

			local var_167_42 = var_167_31 + 0.3
			local var_167_43 = math.max(var_167_32, arg_164_1.talkMaxDuration)

			if var_167_42 <= arg_164_1.time_ and arg_164_1.time_ < var_167_42 + var_167_43 then
				arg_164_1.typewritter.percent = (arg_164_1.time_ - var_167_42) / var_167_43

				arg_164_1.typewritter:SetDirty()
			end

			if arg_164_1.time_ >= var_167_42 + var_167_43 and arg_164_1.time_ < var_167_42 + var_167_43 + arg_167_0 then
				arg_164_1.typewritter.percent = 1

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(true)
			end
		end

		arg_164_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_164_1:InitPlayNodeList()
	end,
	Play111032041 = function(arg_170_0, arg_170_1)
		arg_170_1.time_ = 0
		arg_170_1.frameCnt_ = 0
		arg_170_1.state_ = "playing"
		arg_170_1.curTalkId_ = 111032041
		arg_170_1.duration_ = 5

		SetActive(arg_170_1.tipsGo_, false)

		function arg_170_1.onSingleLineFinish_()
			arg_170_1.onSingleLineUpdate_ = nil
			arg_170_1.onSingleLineFinish_ = nil
			arg_170_1.state_ = "waiting"
		end

		function arg_170_1.playNext_(arg_172_0)
			if arg_172_0 == 1 then
				arg_170_0:Play111032042(arg_170_1)
			end
		end

		function arg_170_1.onSingleLineUpdate_(arg_173_0)
			local var_173_0 = arg_170_1.actors_["1039ui_story"]
			local var_173_1 = 0

			if var_173_1 < arg_170_1.time_ and arg_170_1.time_ <= var_173_1 + arg_173_0 and not isNil(var_173_0) and arg_170_1.var_.characterEffect1039ui_story == nil then
				arg_170_1.var_.characterEffect1039ui_story = var_173_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_173_2 = 0.2

			if var_173_1 <= arg_170_1.time_ and arg_170_1.time_ < var_173_1 + var_173_2 and not isNil(var_173_0) then
				local var_173_3 = (arg_170_1.time_ - var_173_1) / var_173_2

				if arg_170_1.var_.characterEffect1039ui_story and not isNil(var_173_0) then
					local var_173_4 = Mathf.Lerp(0, 0.5, var_173_3)

					arg_170_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_170_1.var_.characterEffect1039ui_story.fillRatio = var_173_4
				end
			end

			if arg_170_1.time_ >= var_173_1 + var_173_2 and arg_170_1.time_ < var_173_1 + var_173_2 + arg_173_0 and not isNil(var_173_0) and arg_170_1.var_.characterEffect1039ui_story then
				local var_173_5 = 0.5

				arg_170_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_170_1.var_.characterEffect1039ui_story.fillRatio = var_173_5
			end

			local var_173_6 = 0
			local var_173_7 = 0.325

			if var_173_6 < arg_170_1.time_ and arg_170_1.time_ <= var_173_6 + arg_173_0 then
				arg_170_1.talkMaxDuration = 0
				arg_170_1.dialogCg_.alpha = 1

				arg_170_1.dialog_:SetActive(true)
				SetActive(arg_170_1.leftNameGo_, true)

				local var_173_8 = arg_170_1:FormatText(StoryNameCfg[7].name)

				arg_170_1.leftNameTxt_.text = var_173_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_170_1.leftNameTxt_.transform)

				arg_170_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_170_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_170_1:RecordName(arg_170_1.leftNameTxt_.text)
				SetActive(arg_170_1.iconTrs_.gameObject, true)
				arg_170_1.iconController_:SetSelectedState("hero")

				arg_170_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_170_1.callingController_:SetSelectedState("normal")

				arg_170_1.keyicon_.color = Color.New(1, 1, 1)
				arg_170_1.icon_.color = Color.New(1, 1, 1)

				local var_173_9 = arg_170_1:GetWordFromCfg(111032041)
				local var_173_10 = arg_170_1:FormatText(var_173_9.content)

				arg_170_1.text_.text = var_173_10

				LuaForUtil.ClearLinePrefixSymbol(arg_170_1.text_)

				local var_173_11 = 13
				local var_173_12 = utf8.len(var_173_10)
				local var_173_13 = var_173_11 <= 0 and var_173_7 or var_173_7 * (var_173_12 / var_173_11)

				if var_173_13 > 0 and var_173_7 < var_173_13 then
					arg_170_1.talkMaxDuration = var_173_13

					if var_173_13 + var_173_6 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_13 + var_173_6
					end
				end

				arg_170_1.text_.text = var_173_10
				arg_170_1.typewritter.percent = 0

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(false)
				arg_170_1:RecordContent(arg_170_1.text_.text)
			end

			local var_173_14 = math.max(var_173_7, arg_170_1.talkMaxDuration)

			if var_173_6 <= arg_170_1.time_ and arg_170_1.time_ < var_173_6 + var_173_14 then
				arg_170_1.typewritter.percent = (arg_170_1.time_ - var_173_6) / var_173_14

				arg_170_1.typewritter:SetDirty()
			end

			if arg_170_1.time_ >= var_173_6 + var_173_14 and arg_170_1.time_ < var_173_6 + var_173_14 + arg_173_0 then
				arg_170_1.typewritter.percent = 1

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(true)
			end
		end

		arg_170_1.nodeConfigList_ = {}

		arg_170_1:InitPlayNodeList()
	end,
	Play111032042 = function(arg_174_0, arg_174_1)
		arg_174_1.time_ = 0
		arg_174_1.frameCnt_ = 0
		arg_174_1.state_ = "playing"
		arg_174_1.curTalkId_ = 111032042
		arg_174_1.duration_ = 7

		local var_174_0 = {
			ja = 4.766,
			ko = 5.1,
			zh = 5.6,
			en = 7
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
				arg_174_0:Play111032043(arg_174_1)
			end
		end

		function arg_174_1.onSingleLineUpdate_(arg_177_0)
			local var_177_0 = "1084ui_story"

			if arg_174_1.actors_[var_177_0] == nil then
				local var_177_1 = Asset.Load("Char/" .. "1084ui_story")

				if not isNil(var_177_1) then
					local var_177_2 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_174_1.stage_.transform)

					var_177_2.name = var_177_0
					var_177_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_174_1.actors_[var_177_0] = var_177_2

					local var_177_3 = var_177_2:GetComponentInChildren(typeof(CharacterEffect))

					var_177_3.enabled = true

					local var_177_4 = GameObjectTools.GetOrAddComponent(var_177_2, typeof(DynamicBoneHelper))

					if var_177_4 then
						var_177_4:EnableDynamicBone(false)
					end

					arg_174_1:ShowWeapon(var_177_3.transform, false)

					arg_174_1.var_[var_177_0 .. "Animator"] = var_177_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_174_1.var_[var_177_0 .. "Animator"].applyRootMotion = true
					arg_174_1.var_[var_177_0 .. "LipSync"] = var_177_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_177_5 = arg_174_1.actors_["1084ui_story"].transform
			local var_177_6 = 0

			if var_177_6 < arg_174_1.time_ and arg_174_1.time_ <= var_177_6 + arg_177_0 then
				arg_174_1.var_.moveOldPos1084ui_story = var_177_5.localPosition
			end

			local var_177_7 = 0.001

			if var_177_6 <= arg_174_1.time_ and arg_174_1.time_ < var_177_6 + var_177_7 then
				local var_177_8 = (arg_174_1.time_ - var_177_6) / var_177_7
				local var_177_9 = Vector3.New(0, -0.97, -6)

				var_177_5.localPosition = Vector3.Lerp(arg_174_1.var_.moveOldPos1084ui_story, var_177_9, var_177_8)

				local var_177_10 = manager.ui.mainCamera.transform.position - var_177_5.position

				var_177_5.forward = Vector3.New(var_177_10.x, var_177_10.y, var_177_10.z)

				local var_177_11 = var_177_5.localEulerAngles

				var_177_11.z = 0
				var_177_11.x = 0
				var_177_5.localEulerAngles = var_177_11
			end

			if arg_174_1.time_ >= var_177_6 + var_177_7 and arg_174_1.time_ < var_177_6 + var_177_7 + arg_177_0 then
				var_177_5.localPosition = Vector3.New(0, -0.97, -6)

				local var_177_12 = manager.ui.mainCamera.transform.position - var_177_5.position

				var_177_5.forward = Vector3.New(var_177_12.x, var_177_12.y, var_177_12.z)

				local var_177_13 = var_177_5.localEulerAngles

				var_177_13.z = 0
				var_177_13.x = 0
				var_177_5.localEulerAngles = var_177_13
			end

			local var_177_14 = 0

			if var_177_14 < arg_174_1.time_ and arg_174_1.time_ <= var_177_14 + arg_177_0 then
				arg_174_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_1")
			end

			local var_177_15 = 0

			if var_177_15 < arg_174_1.time_ and arg_174_1.time_ <= var_177_15 + arg_177_0 then
				arg_174_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2203cva")
			end

			local var_177_16 = arg_174_1.actors_["1039ui_story"]
			local var_177_17 = 0

			if var_177_17 < arg_174_1.time_ and arg_174_1.time_ <= var_177_17 + arg_177_0 and not isNil(var_177_16) and arg_174_1.var_.characterEffect1039ui_story == nil then
				arg_174_1.var_.characterEffect1039ui_story = var_177_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_177_18 = 0.2

			if var_177_17 <= arg_174_1.time_ and arg_174_1.time_ < var_177_17 + var_177_18 and not isNil(var_177_16) then
				local var_177_19 = (arg_174_1.time_ - var_177_17) / var_177_18

				if arg_174_1.var_.characterEffect1039ui_story and not isNil(var_177_16) then
					local var_177_20 = Mathf.Lerp(0, 0.5, var_177_19)

					arg_174_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_174_1.var_.characterEffect1039ui_story.fillRatio = var_177_20
				end
			end

			if arg_174_1.time_ >= var_177_17 + var_177_18 and arg_174_1.time_ < var_177_17 + var_177_18 + arg_177_0 and not isNil(var_177_16) and arg_174_1.var_.characterEffect1039ui_story then
				local var_177_21 = 0.5

				arg_174_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_174_1.var_.characterEffect1039ui_story.fillRatio = var_177_21
			end

			local var_177_22 = arg_174_1.actors_["1084ui_story"]
			local var_177_23 = 0

			if var_177_23 < arg_174_1.time_ and arg_174_1.time_ <= var_177_23 + arg_177_0 and not isNil(var_177_22) and arg_174_1.var_.characterEffect1084ui_story == nil then
				arg_174_1.var_.characterEffect1084ui_story = var_177_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_177_24 = 0.2

			if var_177_23 <= arg_174_1.time_ and arg_174_1.time_ < var_177_23 + var_177_24 and not isNil(var_177_22) then
				local var_177_25 = (arg_174_1.time_ - var_177_23) / var_177_24

				if arg_174_1.var_.characterEffect1084ui_story and not isNil(var_177_22) then
					arg_174_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_174_1.time_ >= var_177_23 + var_177_24 and arg_174_1.time_ < var_177_23 + var_177_24 + arg_177_0 and not isNil(var_177_22) and arg_174_1.var_.characterEffect1084ui_story then
				arg_174_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_177_26 = 0
			local var_177_27 = 0.775

			if var_177_26 < arg_174_1.time_ and arg_174_1.time_ <= var_177_26 + arg_177_0 then
				arg_174_1.talkMaxDuration = 0
				arg_174_1.dialogCg_.alpha = 1

				arg_174_1.dialog_:SetActive(true)
				SetActive(arg_174_1.leftNameGo_, true)

				local var_177_28 = arg_174_1:FormatText(StoryNameCfg[6].name)

				arg_174_1.leftNameTxt_.text = var_177_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_174_1.leftNameTxt_.transform)

				arg_174_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_174_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_174_1:RecordName(arg_174_1.leftNameTxt_.text)
				SetActive(arg_174_1.iconTrs_.gameObject, false)
				arg_174_1.callingController_:SetSelectedState("normal")

				local var_177_29 = arg_174_1:GetWordFromCfg(111032042)
				local var_177_30 = arg_174_1:FormatText(var_177_29.content)

				arg_174_1.text_.text = var_177_30

				LuaForUtil.ClearLinePrefixSymbol(arg_174_1.text_)

				local var_177_31 = 31
				local var_177_32 = utf8.len(var_177_30)
				local var_177_33 = var_177_31 <= 0 and var_177_27 or var_177_27 * (var_177_32 / var_177_31)

				if var_177_33 > 0 and var_177_27 < var_177_33 then
					arg_174_1.talkMaxDuration = var_177_33

					if var_177_33 + var_177_26 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_33 + var_177_26
					end
				end

				arg_174_1.text_.text = var_177_30
				arg_174_1.typewritter.percent = 0

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111032", "111032042", "story_v_out_111032.awb") ~= 0 then
					local var_177_34 = manager.audio:GetVoiceLength("story_v_out_111032", "111032042", "story_v_out_111032.awb") / 1000

					if var_177_34 + var_177_26 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_34 + var_177_26
					end

					if var_177_29.prefab_name ~= "" and arg_174_1.actors_[var_177_29.prefab_name] ~= nil then
						local var_177_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_174_1.actors_[var_177_29.prefab_name].transform, "story_v_out_111032", "111032042", "story_v_out_111032.awb")

						arg_174_1:RecordAudio("111032042", var_177_35)
						arg_174_1:RecordAudio("111032042", var_177_35)
					else
						arg_174_1:AudioAction("play", "voice", "story_v_out_111032", "111032042", "story_v_out_111032.awb")
					end

					arg_174_1:RecordHistoryTalkVoice("story_v_out_111032", "111032042", "story_v_out_111032.awb")
				end

				arg_174_1:RecordContent(arg_174_1.text_.text)
			end

			local var_177_36 = math.max(var_177_27, arg_174_1.talkMaxDuration)

			if var_177_26 <= arg_174_1.time_ and arg_174_1.time_ < var_177_26 + var_177_36 then
				arg_174_1.typewritter.percent = (arg_174_1.time_ - var_177_26) / var_177_36

				arg_174_1.typewritter:SetDirty()
			end

			if arg_174_1.time_ >= var_177_26 + var_177_36 and arg_174_1.time_ < var_177_26 + var_177_36 + arg_177_0 then
				arg_174_1.typewritter.percent = 1

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(true)
			end
		end

		arg_174_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_174_1:InitPlayNodeList()
	end,
	Play111032043 = function(arg_178_0, arg_178_1)
		arg_178_1.time_ = 0
		arg_178_1.frameCnt_ = 0
		arg_178_1.state_ = "playing"
		arg_178_1.curTalkId_ = 111032043
		arg_178_1.duration_ = 4.2

		local var_178_0 = {
			ja = 3.833,
			ko = 2.9,
			zh = 3.166,
			en = 4.2
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
				arg_178_0:Play111032044(arg_178_1)
			end
		end

		function arg_178_1.onSingleLineUpdate_(arg_181_0)
			local var_181_0 = "1048ui_story"

			if arg_178_1.actors_[var_181_0] == nil then
				local var_181_1 = Asset.Load("Char/" .. "1048ui_story")

				if not isNil(var_181_1) then
					local var_181_2 = Object.Instantiate(Asset.Load("Char/" .. "1048ui_story"), arg_178_1.stage_.transform)

					var_181_2.name = var_181_0
					var_181_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_178_1.actors_[var_181_0] = var_181_2

					local var_181_3 = var_181_2:GetComponentInChildren(typeof(CharacterEffect))

					var_181_3.enabled = true

					local var_181_4 = GameObjectTools.GetOrAddComponent(var_181_2, typeof(DynamicBoneHelper))

					if var_181_4 then
						var_181_4:EnableDynamicBone(false)
					end

					arg_178_1:ShowWeapon(var_181_3.transform, false)

					arg_178_1.var_[var_181_0 .. "Animator"] = var_181_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_178_1.var_[var_181_0 .. "Animator"].applyRootMotion = true
					arg_178_1.var_[var_181_0 .. "LipSync"] = var_181_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_181_5 = arg_178_1.actors_["1048ui_story"].transform
			local var_181_6 = 0

			if var_181_6 < arg_178_1.time_ and arg_178_1.time_ <= var_181_6 + arg_181_0 then
				arg_178_1.var_.moveOldPos1048ui_story = var_181_5.localPosition
			end

			local var_181_7 = 0.001

			if var_181_6 <= arg_178_1.time_ and arg_178_1.time_ < var_181_6 + var_181_7 then
				local var_181_8 = (arg_178_1.time_ - var_181_6) / var_181_7
				local var_181_9 = Vector3.New(0.7, -0.8, -6.2)

				var_181_5.localPosition = Vector3.Lerp(arg_178_1.var_.moveOldPos1048ui_story, var_181_9, var_181_8)

				local var_181_10 = manager.ui.mainCamera.transform.position - var_181_5.position

				var_181_5.forward = Vector3.New(var_181_10.x, var_181_10.y, var_181_10.z)

				local var_181_11 = var_181_5.localEulerAngles

				var_181_11.z = 0
				var_181_11.x = 0
				var_181_5.localEulerAngles = var_181_11
			end

			if arg_178_1.time_ >= var_181_6 + var_181_7 and arg_178_1.time_ < var_181_6 + var_181_7 + arg_181_0 then
				var_181_5.localPosition = Vector3.New(0.7, -0.8, -6.2)

				local var_181_12 = manager.ui.mainCamera.transform.position - var_181_5.position

				var_181_5.forward = Vector3.New(var_181_12.x, var_181_12.y, var_181_12.z)

				local var_181_13 = var_181_5.localEulerAngles

				var_181_13.z = 0
				var_181_13.x = 0
				var_181_5.localEulerAngles = var_181_13
			end

			local var_181_14 = 0

			if var_181_14 < arg_178_1.time_ and arg_178_1.time_ <= var_181_14 + arg_181_0 then
				arg_178_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/story1048/story1048action/1048action4_1")
			end

			local var_181_15 = 0

			if var_181_15 < arg_178_1.time_ and arg_178_1.time_ <= var_181_15 + arg_181_0 then
				arg_178_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0204cva")
			end

			local var_181_16 = arg_178_1.actors_["1048ui_story"]
			local var_181_17 = 0

			if var_181_17 < arg_178_1.time_ and arg_178_1.time_ <= var_181_17 + arg_181_0 and not isNil(var_181_16) and arg_178_1.var_.characterEffect1048ui_story == nil then
				arg_178_1.var_.characterEffect1048ui_story = var_181_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_181_18 = 0.2

			if var_181_17 <= arg_178_1.time_ and arg_178_1.time_ < var_181_17 + var_181_18 and not isNil(var_181_16) then
				local var_181_19 = (arg_178_1.time_ - var_181_17) / var_181_18

				if arg_178_1.var_.characterEffect1048ui_story and not isNil(var_181_16) then
					arg_178_1.var_.characterEffect1048ui_story.fillFlat = false
				end
			end

			if arg_178_1.time_ >= var_181_17 + var_181_18 and arg_178_1.time_ < var_181_17 + var_181_18 + arg_181_0 and not isNil(var_181_16) and arg_178_1.var_.characterEffect1048ui_story then
				arg_178_1.var_.characterEffect1048ui_story.fillFlat = false
			end

			local var_181_20 = arg_178_1.actors_["1084ui_story"]
			local var_181_21 = 0

			if var_181_21 < arg_178_1.time_ and arg_178_1.time_ <= var_181_21 + arg_181_0 and not isNil(var_181_20) and arg_178_1.var_.characterEffect1084ui_story == nil then
				arg_178_1.var_.characterEffect1084ui_story = var_181_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_181_22 = 0.2

			if var_181_21 <= arg_178_1.time_ and arg_178_1.time_ < var_181_21 + var_181_22 and not isNil(var_181_20) then
				local var_181_23 = (arg_178_1.time_ - var_181_21) / var_181_22

				if arg_178_1.var_.characterEffect1084ui_story and not isNil(var_181_20) then
					local var_181_24 = Mathf.Lerp(0, 0.5, var_181_23)

					arg_178_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_178_1.var_.characterEffect1084ui_story.fillRatio = var_181_24
				end
			end

			if arg_178_1.time_ >= var_181_21 + var_181_22 and arg_178_1.time_ < var_181_21 + var_181_22 + arg_181_0 and not isNil(var_181_20) and arg_178_1.var_.characterEffect1084ui_story then
				local var_181_25 = 0.5

				arg_178_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_178_1.var_.characterEffect1084ui_story.fillRatio = var_181_25
			end

			local var_181_26 = 0
			local var_181_27 = 0.325

			if var_181_26 < arg_178_1.time_ and arg_178_1.time_ <= var_181_26 + arg_181_0 then
				arg_178_1.talkMaxDuration = 0
				arg_178_1.dialogCg_.alpha = 1

				arg_178_1.dialog_:SetActive(true)
				SetActive(arg_178_1.leftNameGo_, true)

				local var_181_28 = arg_178_1:FormatText(StoryNameCfg[8].name)

				arg_178_1.leftNameTxt_.text = var_181_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_178_1.leftNameTxt_.transform)

				arg_178_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_178_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_178_1:RecordName(arg_178_1.leftNameTxt_.text)
				SetActive(arg_178_1.iconTrs_.gameObject, false)
				arg_178_1.callingController_:SetSelectedState("normal")

				local var_181_29 = arg_178_1:GetWordFromCfg(111032043)
				local var_181_30 = arg_178_1:FormatText(var_181_29.content)

				arg_178_1.text_.text = var_181_30

				LuaForUtil.ClearLinePrefixSymbol(arg_178_1.text_)

				local var_181_31 = 13
				local var_181_32 = utf8.len(var_181_30)
				local var_181_33 = var_181_31 <= 0 and var_181_27 or var_181_27 * (var_181_32 / var_181_31)

				if var_181_33 > 0 and var_181_27 < var_181_33 then
					arg_178_1.talkMaxDuration = var_181_33

					if var_181_33 + var_181_26 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_33 + var_181_26
					end
				end

				arg_178_1.text_.text = var_181_30
				arg_178_1.typewritter.percent = 0

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111032", "111032043", "story_v_out_111032.awb") ~= 0 then
					local var_181_34 = manager.audio:GetVoiceLength("story_v_out_111032", "111032043", "story_v_out_111032.awb") / 1000

					if var_181_34 + var_181_26 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_34 + var_181_26
					end

					if var_181_29.prefab_name ~= "" and arg_178_1.actors_[var_181_29.prefab_name] ~= nil then
						local var_181_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_178_1.actors_[var_181_29.prefab_name].transform, "story_v_out_111032", "111032043", "story_v_out_111032.awb")

						arg_178_1:RecordAudio("111032043", var_181_35)
						arg_178_1:RecordAudio("111032043", var_181_35)
					else
						arg_178_1:AudioAction("play", "voice", "story_v_out_111032", "111032043", "story_v_out_111032.awb")
					end

					arg_178_1:RecordHistoryTalkVoice("story_v_out_111032", "111032043", "story_v_out_111032.awb")
				end

				arg_178_1:RecordContent(arg_178_1.text_.text)
			end

			local var_181_36 = math.max(var_181_27, arg_178_1.talkMaxDuration)

			if var_181_26 <= arg_178_1.time_ and arg_178_1.time_ < var_181_26 + var_181_36 then
				arg_178_1.typewritter.percent = (arg_178_1.time_ - var_181_26) / var_181_36

				arg_178_1.typewritter:SetDirty()
			end

			if arg_178_1.time_ >= var_181_26 + var_181_36 and arg_178_1.time_ < var_181_26 + var_181_36 + arg_181_0 then
				arg_178_1.typewritter.percent = 1

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(true)
			end
		end

		arg_178_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1048ui_story",
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
	Play111032044 = function(arg_182_0, arg_182_1)
		arg_182_1.time_ = 0
		arg_182_1.frameCnt_ = 0
		arg_182_1.state_ = "playing"
		arg_182_1.curTalkId_ = 111032044
		arg_182_1.duration_ = 5

		SetActive(arg_182_1.tipsGo_, false)

		function arg_182_1.onSingleLineFinish_()
			arg_182_1.onSingleLineUpdate_ = nil
			arg_182_1.onSingleLineFinish_ = nil
			arg_182_1.state_ = "waiting"
		end

		function arg_182_1.playNext_(arg_184_0)
			if arg_184_0 == 1 then
				arg_182_0:Play111032045(arg_182_1)
			end
		end

		function arg_182_1.onSingleLineUpdate_(arg_185_0)
			local var_185_0 = arg_182_1.actors_["1048ui_story"]
			local var_185_1 = 0

			if var_185_1 < arg_182_1.time_ and arg_182_1.time_ <= var_185_1 + arg_185_0 and not isNil(var_185_0) and arg_182_1.var_.characterEffect1048ui_story == nil then
				arg_182_1.var_.characterEffect1048ui_story = var_185_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_185_2 = 0.2

			if var_185_1 <= arg_182_1.time_ and arg_182_1.time_ < var_185_1 + var_185_2 and not isNil(var_185_0) then
				local var_185_3 = (arg_182_1.time_ - var_185_1) / var_185_2

				if arg_182_1.var_.characterEffect1048ui_story and not isNil(var_185_0) then
					local var_185_4 = Mathf.Lerp(0, 0.5, var_185_3)

					arg_182_1.var_.characterEffect1048ui_story.fillFlat = true
					arg_182_1.var_.characterEffect1048ui_story.fillRatio = var_185_4
				end
			end

			if arg_182_1.time_ >= var_185_1 + var_185_2 and arg_182_1.time_ < var_185_1 + var_185_2 + arg_185_0 and not isNil(var_185_0) and arg_182_1.var_.characterEffect1048ui_story then
				local var_185_5 = 0.5

				arg_182_1.var_.characterEffect1048ui_story.fillFlat = true
				arg_182_1.var_.characterEffect1048ui_story.fillRatio = var_185_5
			end

			local var_185_6 = 0
			local var_185_7 = 0.425

			if var_185_6 < arg_182_1.time_ and arg_182_1.time_ <= var_185_6 + arg_185_0 then
				arg_182_1.talkMaxDuration = 0
				arg_182_1.dialogCg_.alpha = 1

				arg_182_1.dialog_:SetActive(true)
				SetActive(arg_182_1.leftNameGo_, true)

				local var_185_8 = arg_182_1:FormatText(StoryNameCfg[7].name)

				arg_182_1.leftNameTxt_.text = var_185_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_182_1.leftNameTxt_.transform)

				arg_182_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_182_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_182_1:RecordName(arg_182_1.leftNameTxt_.text)
				SetActive(arg_182_1.iconTrs_.gameObject, true)
				arg_182_1.iconController_:SetSelectedState("hero")

				arg_182_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_182_1.callingController_:SetSelectedState("normal")

				arg_182_1.keyicon_.color = Color.New(1, 1, 1)
				arg_182_1.icon_.color = Color.New(1, 1, 1)

				local var_185_9 = arg_182_1:GetWordFromCfg(111032044)
				local var_185_10 = arg_182_1:FormatText(var_185_9.content)

				arg_182_1.text_.text = var_185_10

				LuaForUtil.ClearLinePrefixSymbol(arg_182_1.text_)

				local var_185_11 = 17
				local var_185_12 = utf8.len(var_185_10)
				local var_185_13 = var_185_11 <= 0 and var_185_7 or var_185_7 * (var_185_12 / var_185_11)

				if var_185_13 > 0 and var_185_7 < var_185_13 then
					arg_182_1.talkMaxDuration = var_185_13

					if var_185_13 + var_185_6 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_13 + var_185_6
					end
				end

				arg_182_1.text_.text = var_185_10
				arg_182_1.typewritter.percent = 0

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(false)
				arg_182_1:RecordContent(arg_182_1.text_.text)
			end

			local var_185_14 = math.max(var_185_7, arg_182_1.talkMaxDuration)

			if var_185_6 <= arg_182_1.time_ and arg_182_1.time_ < var_185_6 + var_185_14 then
				arg_182_1.typewritter.percent = (arg_182_1.time_ - var_185_6) / var_185_14

				arg_182_1.typewritter:SetDirty()
			end

			if arg_182_1.time_ >= var_185_6 + var_185_14 and arg_182_1.time_ < var_185_6 + var_185_14 + arg_185_0 then
				arg_182_1.typewritter.percent = 1

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(true)
			end
		end

		arg_182_1.nodeConfigList_ = {}

		arg_182_1:InitPlayNodeList()
	end,
	Play111032045 = function(arg_186_0, arg_186_1)
		arg_186_1.time_ = 0
		arg_186_1.frameCnt_ = 0
		arg_186_1.state_ = "playing"
		arg_186_1.curTalkId_ = 111032045
		arg_186_1.duration_ = 11.63

		local var_186_0 = {
			ja = 5.766,
			ko = 10.2,
			zh = 8.766,
			en = 11.633
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
				arg_186_0:Play111032046(arg_186_1)
			end
		end

		function arg_186_1.onSingleLineUpdate_(arg_189_0)
			local var_189_0 = 0

			if var_189_0 < arg_186_1.time_ and arg_186_1.time_ <= var_189_0 + arg_189_0 then
				arg_186_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039actionlink/1039action452")
			end

			local var_189_1 = 0

			if var_189_1 < arg_186_1.time_ and arg_186_1.time_ <= var_189_1 + arg_189_0 then
				arg_186_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_189_2 = arg_186_1.actors_["1039ui_story"]
			local var_189_3 = 0

			if var_189_3 < arg_186_1.time_ and arg_186_1.time_ <= var_189_3 + arg_189_0 and not isNil(var_189_2) and arg_186_1.var_.characterEffect1039ui_story == nil then
				arg_186_1.var_.characterEffect1039ui_story = var_189_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_189_4 = 0.2

			if var_189_3 <= arg_186_1.time_ and arg_186_1.time_ < var_189_3 + var_189_4 and not isNil(var_189_2) then
				local var_189_5 = (arg_186_1.time_ - var_189_3) / var_189_4

				if arg_186_1.var_.characterEffect1039ui_story and not isNil(var_189_2) then
					arg_186_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_186_1.time_ >= var_189_3 + var_189_4 and arg_186_1.time_ < var_189_3 + var_189_4 + arg_189_0 and not isNil(var_189_2) and arg_186_1.var_.characterEffect1039ui_story then
				arg_186_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_189_6 = 0
			local var_189_7 = 1.15

			if var_189_6 < arg_186_1.time_ and arg_186_1.time_ <= var_189_6 + arg_189_0 then
				arg_186_1.talkMaxDuration = 0
				arg_186_1.dialogCg_.alpha = 1

				arg_186_1.dialog_:SetActive(true)
				SetActive(arg_186_1.leftNameGo_, true)

				local var_189_8 = arg_186_1:FormatText(StoryNameCfg[9].name)

				arg_186_1.leftNameTxt_.text = var_189_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_186_1.leftNameTxt_.transform)

				arg_186_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_186_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_186_1:RecordName(arg_186_1.leftNameTxt_.text)
				SetActive(arg_186_1.iconTrs_.gameObject, false)
				arg_186_1.callingController_:SetSelectedState("normal")

				local var_189_9 = arg_186_1:GetWordFromCfg(111032045)
				local var_189_10 = arg_186_1:FormatText(var_189_9.content)

				arg_186_1.text_.text = var_189_10

				LuaForUtil.ClearLinePrefixSymbol(arg_186_1.text_)

				local var_189_11 = 46
				local var_189_12 = utf8.len(var_189_10)
				local var_189_13 = var_189_11 <= 0 and var_189_7 or var_189_7 * (var_189_12 / var_189_11)

				if var_189_13 > 0 and var_189_7 < var_189_13 then
					arg_186_1.talkMaxDuration = var_189_13

					if var_189_13 + var_189_6 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_13 + var_189_6
					end
				end

				arg_186_1.text_.text = var_189_10
				arg_186_1.typewritter.percent = 0

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111032", "111032045", "story_v_out_111032.awb") ~= 0 then
					local var_189_14 = manager.audio:GetVoiceLength("story_v_out_111032", "111032045", "story_v_out_111032.awb") / 1000

					if var_189_14 + var_189_6 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_14 + var_189_6
					end

					if var_189_9.prefab_name ~= "" and arg_186_1.actors_[var_189_9.prefab_name] ~= nil then
						local var_189_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_186_1.actors_[var_189_9.prefab_name].transform, "story_v_out_111032", "111032045", "story_v_out_111032.awb")

						arg_186_1:RecordAudio("111032045", var_189_15)
						arg_186_1:RecordAudio("111032045", var_189_15)
					else
						arg_186_1:AudioAction("play", "voice", "story_v_out_111032", "111032045", "story_v_out_111032.awb")
					end

					arg_186_1:RecordHistoryTalkVoice("story_v_out_111032", "111032045", "story_v_out_111032.awb")
				end

				arg_186_1:RecordContent(arg_186_1.text_.text)
			end

			local var_189_16 = math.max(var_189_7, arg_186_1.talkMaxDuration)

			if var_189_6 <= arg_186_1.time_ and arg_186_1.time_ < var_189_6 + var_189_16 then
				arg_186_1.typewritter.percent = (arg_186_1.time_ - var_189_6) / var_189_16

				arg_186_1.typewritter:SetDirty()
			end

			if arg_186_1.time_ >= var_189_6 + var_189_16 and arg_186_1.time_ < var_189_6 + var_189_16 + arg_189_0 then
				arg_186_1.typewritter.percent = 1

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(true)
			end
		end

		arg_186_1.nodeConfigList_ = {}

		arg_186_1:InitPlayNodeList()
	end,
	Play111032046 = function(arg_190_0, arg_190_1)
		arg_190_1.time_ = 0
		arg_190_1.frameCnt_ = 0
		arg_190_1.state_ = "playing"
		arg_190_1.curTalkId_ = 111032046
		arg_190_1.duration_ = 5

		SetActive(arg_190_1.tipsGo_, false)

		function arg_190_1.onSingleLineFinish_()
			arg_190_1.onSingleLineUpdate_ = nil
			arg_190_1.onSingleLineFinish_ = nil
			arg_190_1.state_ = "waiting"
		end

		function arg_190_1.playNext_(arg_192_0)
			if arg_192_0 == 1 then
				arg_190_0:Play111032047(arg_190_1)
			end
		end

		function arg_190_1.onSingleLineUpdate_(arg_193_0)
			local var_193_0 = arg_190_1.actors_["1039ui_story"]
			local var_193_1 = 0

			if var_193_1 < arg_190_1.time_ and arg_190_1.time_ <= var_193_1 + arg_193_0 and not isNil(var_193_0) and arg_190_1.var_.characterEffect1039ui_story == nil then
				arg_190_1.var_.characterEffect1039ui_story = var_193_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_193_2 = 0.2

			if var_193_1 <= arg_190_1.time_ and arg_190_1.time_ < var_193_1 + var_193_2 and not isNil(var_193_0) then
				local var_193_3 = (arg_190_1.time_ - var_193_1) / var_193_2

				if arg_190_1.var_.characterEffect1039ui_story and not isNil(var_193_0) then
					local var_193_4 = Mathf.Lerp(0, 0.5, var_193_3)

					arg_190_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_190_1.var_.characterEffect1039ui_story.fillRatio = var_193_4
				end
			end

			if arg_190_1.time_ >= var_193_1 + var_193_2 and arg_190_1.time_ < var_193_1 + var_193_2 + arg_193_0 and not isNil(var_193_0) and arg_190_1.var_.characterEffect1039ui_story then
				local var_193_5 = 0.5

				arg_190_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_190_1.var_.characterEffect1039ui_story.fillRatio = var_193_5
			end

			local var_193_6 = 0
			local var_193_7 = 0.175

			if var_193_6 < arg_190_1.time_ and arg_190_1.time_ <= var_193_6 + arg_193_0 then
				arg_190_1.talkMaxDuration = 0
				arg_190_1.dialogCg_.alpha = 1

				arg_190_1.dialog_:SetActive(true)
				SetActive(arg_190_1.leftNameGo_, true)

				local var_193_8 = arg_190_1:FormatText(StoryNameCfg[7].name)

				arg_190_1.leftNameTxt_.text = var_193_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_190_1.leftNameTxt_.transform)

				arg_190_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_190_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_190_1:RecordName(arg_190_1.leftNameTxt_.text)
				SetActive(arg_190_1.iconTrs_.gameObject, true)
				arg_190_1.iconController_:SetSelectedState("hero")

				arg_190_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_190_1.callingController_:SetSelectedState("normal")

				arg_190_1.keyicon_.color = Color.New(1, 1, 1)
				arg_190_1.icon_.color = Color.New(1, 1, 1)

				local var_193_9 = arg_190_1:GetWordFromCfg(111032046)
				local var_193_10 = arg_190_1:FormatText(var_193_9.content)

				arg_190_1.text_.text = var_193_10

				LuaForUtil.ClearLinePrefixSymbol(arg_190_1.text_)

				local var_193_11 = 7
				local var_193_12 = utf8.len(var_193_10)
				local var_193_13 = var_193_11 <= 0 and var_193_7 or var_193_7 * (var_193_12 / var_193_11)

				if var_193_13 > 0 and var_193_7 < var_193_13 then
					arg_190_1.talkMaxDuration = var_193_13

					if var_193_13 + var_193_6 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_13 + var_193_6
					end
				end

				arg_190_1.text_.text = var_193_10
				arg_190_1.typewritter.percent = 0

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(false)
				arg_190_1:RecordContent(arg_190_1.text_.text)
			end

			local var_193_14 = math.max(var_193_7, arg_190_1.talkMaxDuration)

			if var_193_6 <= arg_190_1.time_ and arg_190_1.time_ < var_193_6 + var_193_14 then
				arg_190_1.typewritter.percent = (arg_190_1.time_ - var_193_6) / var_193_14

				arg_190_1.typewritter:SetDirty()
			end

			if arg_190_1.time_ >= var_193_6 + var_193_14 and arg_190_1.time_ < var_193_6 + var_193_14 + arg_193_0 then
				arg_190_1.typewritter.percent = 1

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(true)
			end
		end

		arg_190_1.nodeConfigList_ = {}

		arg_190_1:InitPlayNodeList()
	end,
	Play111032047 = function(arg_194_0, arg_194_1)
		arg_194_1.time_ = 0
		arg_194_1.frameCnt_ = 0
		arg_194_1.state_ = "playing"
		arg_194_1.curTalkId_ = 111032047
		arg_194_1.duration_ = 3.67

		local var_194_0 = {
			ja = 3.666,
			ko = 2.5,
			zh = 2.066,
			en = 2.533
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
				arg_194_0:Play111032048(arg_194_1)
			end
		end

		function arg_194_1.onSingleLineUpdate_(arg_197_0)
			local var_197_0 = 0

			if var_197_0 < arg_194_1.time_ and arg_194_1.time_ <= var_197_0 + arg_197_0 then
				arg_194_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_197_1 = arg_194_1.actors_["1039ui_story"]
			local var_197_2 = 0

			if var_197_2 < arg_194_1.time_ and arg_194_1.time_ <= var_197_2 + arg_197_0 and not isNil(var_197_1) and arg_194_1.var_.characterEffect1039ui_story == nil then
				arg_194_1.var_.characterEffect1039ui_story = var_197_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_197_3 = 0.2

			if var_197_2 <= arg_194_1.time_ and arg_194_1.time_ < var_197_2 + var_197_3 and not isNil(var_197_1) then
				local var_197_4 = (arg_194_1.time_ - var_197_2) / var_197_3

				if arg_194_1.var_.characterEffect1039ui_story and not isNil(var_197_1) then
					arg_194_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_194_1.time_ >= var_197_2 + var_197_3 and arg_194_1.time_ < var_197_2 + var_197_3 + arg_197_0 and not isNil(var_197_1) and arg_194_1.var_.characterEffect1039ui_story then
				arg_194_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_197_5 = 0
			local var_197_6 = 0.2

			if var_197_5 < arg_194_1.time_ and arg_194_1.time_ <= var_197_5 + arg_197_0 then
				arg_194_1.talkMaxDuration = 0
				arg_194_1.dialogCg_.alpha = 1

				arg_194_1.dialog_:SetActive(true)
				SetActive(arg_194_1.leftNameGo_, true)

				local var_197_7 = arg_194_1:FormatText(StoryNameCfg[9].name)

				arg_194_1.leftNameTxt_.text = var_197_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_194_1.leftNameTxt_.transform)

				arg_194_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_194_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_194_1:RecordName(arg_194_1.leftNameTxt_.text)
				SetActive(arg_194_1.iconTrs_.gameObject, false)
				arg_194_1.callingController_:SetSelectedState("normal")

				local var_197_8 = arg_194_1:GetWordFromCfg(111032047)
				local var_197_9 = arg_194_1:FormatText(var_197_8.content)

				arg_194_1.text_.text = var_197_9

				LuaForUtil.ClearLinePrefixSymbol(arg_194_1.text_)

				local var_197_10 = 8
				local var_197_11 = utf8.len(var_197_9)
				local var_197_12 = var_197_10 <= 0 and var_197_6 or var_197_6 * (var_197_11 / var_197_10)

				if var_197_12 > 0 and var_197_6 < var_197_12 then
					arg_194_1.talkMaxDuration = var_197_12

					if var_197_12 + var_197_5 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_12 + var_197_5
					end
				end

				arg_194_1.text_.text = var_197_9
				arg_194_1.typewritter.percent = 0

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111032", "111032047", "story_v_out_111032.awb") ~= 0 then
					local var_197_13 = manager.audio:GetVoiceLength("story_v_out_111032", "111032047", "story_v_out_111032.awb") / 1000

					if var_197_13 + var_197_5 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_13 + var_197_5
					end

					if var_197_8.prefab_name ~= "" and arg_194_1.actors_[var_197_8.prefab_name] ~= nil then
						local var_197_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_194_1.actors_[var_197_8.prefab_name].transform, "story_v_out_111032", "111032047", "story_v_out_111032.awb")

						arg_194_1:RecordAudio("111032047", var_197_14)
						arg_194_1:RecordAudio("111032047", var_197_14)
					else
						arg_194_1:AudioAction("play", "voice", "story_v_out_111032", "111032047", "story_v_out_111032.awb")
					end

					arg_194_1:RecordHistoryTalkVoice("story_v_out_111032", "111032047", "story_v_out_111032.awb")
				end

				arg_194_1:RecordContent(arg_194_1.text_.text)
			end

			local var_197_15 = math.max(var_197_6, arg_194_1.talkMaxDuration)

			if var_197_5 <= arg_194_1.time_ and arg_194_1.time_ < var_197_5 + var_197_15 then
				arg_194_1.typewritter.percent = (arg_194_1.time_ - var_197_5) / var_197_15

				arg_194_1.typewritter:SetDirty()
			end

			if arg_194_1.time_ >= var_197_5 + var_197_15 and arg_194_1.time_ < var_197_5 + var_197_15 + arg_197_0 then
				arg_194_1.typewritter.percent = 1

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(true)
			end
		end

		arg_194_1.nodeConfigList_ = {}

		arg_194_1:InitPlayNodeList()
	end,
	Play111032048 = function(arg_198_0, arg_198_1)
		arg_198_1.time_ = 0
		arg_198_1.frameCnt_ = 0
		arg_198_1.state_ = "playing"
		arg_198_1.curTalkId_ = 111032048
		arg_198_1.duration_ = 5

		SetActive(arg_198_1.tipsGo_, false)

		function arg_198_1.onSingleLineFinish_()
			arg_198_1.onSingleLineUpdate_ = nil
			arg_198_1.onSingleLineFinish_ = nil
			arg_198_1.state_ = "waiting"
			arg_198_1.auto_ = false
		end

		function arg_198_1.playNext_(arg_200_0)
			arg_198_1.onStoryFinished_()
		end

		function arg_198_1.onSingleLineUpdate_(arg_201_0)
			local var_201_0 = arg_198_1.actors_["1039ui_story"].transform
			local var_201_1 = 0

			if var_201_1 < arg_198_1.time_ and arg_198_1.time_ <= var_201_1 + arg_201_0 then
				arg_198_1.var_.moveOldPos1039ui_story = var_201_0.localPosition
			end

			local var_201_2 = 0.001

			if var_201_1 <= arg_198_1.time_ and arg_198_1.time_ < var_201_1 + var_201_2 then
				local var_201_3 = (arg_198_1.time_ - var_201_1) / var_201_2
				local var_201_4 = Vector3.New(0, 100, 0)

				var_201_0.localPosition = Vector3.Lerp(arg_198_1.var_.moveOldPos1039ui_story, var_201_4, var_201_3)

				local var_201_5 = manager.ui.mainCamera.transform.position - var_201_0.position

				var_201_0.forward = Vector3.New(var_201_5.x, var_201_5.y, var_201_5.z)

				local var_201_6 = var_201_0.localEulerAngles

				var_201_6.z = 0
				var_201_6.x = 0
				var_201_0.localEulerAngles = var_201_6
			end

			if arg_198_1.time_ >= var_201_1 + var_201_2 and arg_198_1.time_ < var_201_1 + var_201_2 + arg_201_0 then
				var_201_0.localPosition = Vector3.New(0, 100, 0)

				local var_201_7 = manager.ui.mainCamera.transform.position - var_201_0.position

				var_201_0.forward = Vector3.New(var_201_7.x, var_201_7.y, var_201_7.z)

				local var_201_8 = var_201_0.localEulerAngles

				var_201_8.z = 0
				var_201_8.x = 0
				var_201_0.localEulerAngles = var_201_8
			end

			local var_201_9 = arg_198_1.actors_["1048ui_story"].transform
			local var_201_10 = 0

			if var_201_10 < arg_198_1.time_ and arg_198_1.time_ <= var_201_10 + arg_201_0 then
				arg_198_1.var_.moveOldPos1048ui_story = var_201_9.localPosition
			end

			local var_201_11 = 0.001

			if var_201_10 <= arg_198_1.time_ and arg_198_1.time_ < var_201_10 + var_201_11 then
				local var_201_12 = (arg_198_1.time_ - var_201_10) / var_201_11
				local var_201_13 = Vector3.New(0, 100, 0)

				var_201_9.localPosition = Vector3.Lerp(arg_198_1.var_.moveOldPos1048ui_story, var_201_13, var_201_12)

				local var_201_14 = manager.ui.mainCamera.transform.position - var_201_9.position

				var_201_9.forward = Vector3.New(var_201_14.x, var_201_14.y, var_201_14.z)

				local var_201_15 = var_201_9.localEulerAngles

				var_201_15.z = 0
				var_201_15.x = 0
				var_201_9.localEulerAngles = var_201_15
			end

			if arg_198_1.time_ >= var_201_10 + var_201_11 and arg_198_1.time_ < var_201_10 + var_201_11 + arg_201_0 then
				var_201_9.localPosition = Vector3.New(0, 100, 0)

				local var_201_16 = manager.ui.mainCamera.transform.position - var_201_9.position

				var_201_9.forward = Vector3.New(var_201_16.x, var_201_16.y, var_201_16.z)

				local var_201_17 = var_201_9.localEulerAngles

				var_201_17.z = 0
				var_201_17.x = 0
				var_201_9.localEulerAngles = var_201_17
			end

			local var_201_18 = arg_198_1.actors_["1084ui_story"].transform
			local var_201_19 = 0

			if var_201_19 < arg_198_1.time_ and arg_198_1.time_ <= var_201_19 + arg_201_0 then
				arg_198_1.var_.moveOldPos1084ui_story = var_201_18.localPosition
			end

			local var_201_20 = 0.001

			if var_201_19 <= arg_198_1.time_ and arg_198_1.time_ < var_201_19 + var_201_20 then
				local var_201_21 = (arg_198_1.time_ - var_201_19) / var_201_20
				local var_201_22 = Vector3.New(0, 100, 0)

				var_201_18.localPosition = Vector3.Lerp(arg_198_1.var_.moveOldPos1084ui_story, var_201_22, var_201_21)

				local var_201_23 = manager.ui.mainCamera.transform.position - var_201_18.position

				var_201_18.forward = Vector3.New(var_201_23.x, var_201_23.y, var_201_23.z)

				local var_201_24 = var_201_18.localEulerAngles

				var_201_24.z = 0
				var_201_24.x = 0
				var_201_18.localEulerAngles = var_201_24
			end

			if arg_198_1.time_ >= var_201_19 + var_201_20 and arg_198_1.time_ < var_201_19 + var_201_20 + arg_201_0 then
				var_201_18.localPosition = Vector3.New(0, 100, 0)

				local var_201_25 = manager.ui.mainCamera.transform.position - var_201_18.position

				var_201_18.forward = Vector3.New(var_201_25.x, var_201_25.y, var_201_25.z)

				local var_201_26 = var_201_18.localEulerAngles

				var_201_26.z = 0
				var_201_26.x = 0
				var_201_18.localEulerAngles = var_201_26
			end

			local var_201_27 = 0
			local var_201_28 = 0.775

			if var_201_27 < arg_198_1.time_ and arg_198_1.time_ <= var_201_27 + arg_201_0 then
				arg_198_1.talkMaxDuration = 0
				arg_198_1.dialogCg_.alpha = 1

				arg_198_1.dialog_:SetActive(true)
				SetActive(arg_198_1.leftNameGo_, false)

				arg_198_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_198_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_198_1:RecordName(arg_198_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_198_1.iconTrs_.gameObject, false)
				arg_198_1.callingController_:SetSelectedState("normal")

				local var_201_29 = arg_198_1:GetWordFromCfg(111032048)
				local var_201_30 = arg_198_1:FormatText(var_201_29.content)

				arg_198_1.text_.text = var_201_30

				LuaForUtil.ClearLinePrefixSymbol(arg_198_1.text_)

				local var_201_31 = 31
				local var_201_32 = utf8.len(var_201_30)
				local var_201_33 = var_201_31 <= 0 and var_201_28 or var_201_28 * (var_201_32 / var_201_31)

				if var_201_33 > 0 and var_201_28 < var_201_33 then
					arg_198_1.talkMaxDuration = var_201_33

					if var_201_33 + var_201_27 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_33 + var_201_27
					end
				end

				arg_198_1.text_.text = var_201_30
				arg_198_1.typewritter.percent = 0

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(false)
				arg_198_1:RecordContent(arg_198_1.text_.text)
			end

			local var_201_34 = math.max(var_201_28, arg_198_1.talkMaxDuration)

			if var_201_27 <= arg_198_1.time_ and arg_198_1.time_ < var_201_27 + var_201_34 then
				arg_198_1.typewritter.percent = (arg_198_1.time_ - var_201_27) / var_201_34

				arg_198_1.typewritter:SetDirty()
			end

			if arg_198_1.time_ >= var_201_27 + var_201_34 and arg_198_1.time_ < var_201_27 + var_201_34 + arg_201_0 then
				arg_198_1.typewritter.percent = 1

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(true)
			end
		end

		arg_198_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1048ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_198_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/D05",
		"TextureConfig/Background/AS0101"
	},
	voices = {
		"story_v_out_111032.awb"
	}
}
