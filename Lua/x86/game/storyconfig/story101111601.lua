return {
	Play111161001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 111161001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play111161002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "D11"

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
				local var_4_5 = arg_1_1.bgs_.D11

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
					if iter_4_0 ~= "D11" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = arg_1_1.bgs_.D11
			local var_4_17 = 0

			if var_4_17 < arg_1_1.time_ and arg_1_1.time_ <= var_4_17 + arg_4_0 then
				local var_4_18 = var_4_16:GetComponent("SpriteRenderer")

				if var_4_18 then
					arg_1_1.var_.alphaOldValueD11 = var_4_18.color.a
					arg_1_1.var_.alphaMatValueD11 = var_4_18
				end

				arg_1_1.var_.alphaOldValueD11 = 0
			end

			local var_4_19 = 1.5

			if var_4_17 <= arg_1_1.time_ and arg_1_1.time_ < var_4_17 + var_4_19 then
				local var_4_20 = (arg_1_1.time_ - var_4_17) / var_4_19
				local var_4_21 = Mathf.Lerp(arg_1_1.var_.alphaOldValueD11, 1, var_4_20)

				if arg_1_1.var_.alphaMatValueD11 then
					local var_4_22 = arg_1_1.var_.alphaMatValueD11.color

					var_4_22.a = var_4_21
					arg_1_1.var_.alphaMatValueD11.color = var_4_22
				end
			end

			if arg_1_1.time_ >= var_4_17 + var_4_19 and arg_1_1.time_ < var_4_17 + var_4_19 + arg_4_0 and arg_1_1.var_.alphaMatValueD11 then
				local var_4_23 = arg_1_1.var_.alphaMatValueD11
				local var_4_24 = var_4_23.color

				var_4_24.a = 1
				var_4_23.color = var_4_24
			end

			local var_4_25 = 0
			local var_4_26 = 1

			if var_4_25 < arg_1_1.time_ and arg_1_1.time_ <= var_4_25 + arg_4_0 then
				local var_4_27 = "play"
				local var_4_28 = "music"

				arg_1_1:AudioAction(var_4_27, var_4_28, "bgm_activity_1_1_hel_story_warm", "bgm_activity_1_1_hel_story_warm", "bgm_activity_1_1_hel_story_warm.awb")

				local var_4_29 = ""
				local var_4_30 = manager.audio:GetAudioName("bgm_activity_1_1_hel_story_warm", "bgm_activity_1_1_hel_story_warm")

				if var_4_30 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_30 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_30

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_30
						arg_1_1.bgmTxt2_.text = var_4_30
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

			local var_4_31 = 2
			local var_4_32 = 1.05

			if var_4_31 < arg_1_1.time_ and arg_1_1.time_ <= var_4_31 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_33 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_33:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_33:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_33:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_34 = arg_1_1:GetWordFromCfg(111161001)
				local var_4_35 = arg_1_1:FormatText(var_4_34.content)

				arg_1_1.text_.text = var_4_35

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_36 = 42
				local var_4_37 = utf8.len(var_4_35)
				local var_4_38 = var_4_36 <= 0 and var_4_32 or var_4_32 * (var_4_37 / var_4_36)

				if var_4_38 > 0 and var_4_32 < var_4_38 then
					arg_1_1.talkMaxDuration = var_4_38
					var_4_31 = var_4_31 + 0.3

					if var_4_38 + var_4_31 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_38 + var_4_31
					end
				end

				arg_1_1.text_.text = var_4_35
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_39 = var_4_31 + 0.3
			local var_4_40 = math.max(var_4_32, arg_1_1.talkMaxDuration)

			if var_4_39 <= arg_1_1.time_ and arg_1_1.time_ < var_4_39 + var_4_40 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_39) / var_4_40

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_39 + var_4_40 and arg_1_1.time_ < var_4_39 + var_4_40 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play111161002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 111161002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play111161003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 0
			local var_11_1 = 0.3

			if var_11_0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_0 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				local var_11_2 = arg_8_1:FormatText(StoryNameCfg[7].name)

				arg_8_1.leftNameTxt_.text = var_11_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, true)
				arg_8_1.iconController_:SetSelectedState("hero")

				arg_8_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_8_1.callingController_:SetSelectedState("normal")

				arg_8_1.keyicon_.color = Color.New(1, 1, 1)
				arg_8_1.icon_.color = Color.New(1, 1, 1)

				local var_11_3 = arg_8_1:GetWordFromCfg(111161002)
				local var_11_4 = arg_8_1:FormatText(var_11_3.content)

				arg_8_1.text_.text = var_11_4

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_5 = 12
				local var_11_6 = utf8.len(var_11_4)
				local var_11_7 = var_11_5 <= 0 and var_11_1 or var_11_1 * (var_11_6 / var_11_5)

				if var_11_7 > 0 and var_11_1 < var_11_7 then
					arg_8_1.talkMaxDuration = var_11_7

					if var_11_7 + var_11_0 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_7 + var_11_0
					end
				end

				arg_8_1.text_.text = var_11_4
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)
				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_8 = math.max(var_11_1, arg_8_1.talkMaxDuration)

			if var_11_0 <= arg_8_1.time_ and arg_8_1.time_ < var_11_0 + var_11_8 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_0) / var_11_8

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_0 + var_11_8 and arg_8_1.time_ < var_11_0 + var_11_8 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play111161003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 111161003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play111161004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = 0
			local var_15_1 = 1.05

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

				local var_15_2 = arg_12_1:GetWordFromCfg(111161003)
				local var_15_3 = arg_12_1:FormatText(var_15_2.content)

				arg_12_1.text_.text = var_15_3

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_4 = 42
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
	Play111161004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 111161004
		arg_16_1.duration_ = 5

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play111161005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = 0
			local var_19_1 = 1.1

			if var_19_0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_0 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, false)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_2 = arg_16_1:GetWordFromCfg(111161004)
				local var_19_3 = arg_16_1:FormatText(var_19_2.content)

				arg_16_1.text_.text = var_19_3

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_4 = 44
				local var_19_5 = utf8.len(var_19_3)
				local var_19_6 = var_19_4 <= 0 and var_19_1 or var_19_1 * (var_19_5 / var_19_4)

				if var_19_6 > 0 and var_19_1 < var_19_6 then
					arg_16_1.talkMaxDuration = var_19_6

					if var_19_6 + var_19_0 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_6 + var_19_0
					end
				end

				arg_16_1.text_.text = var_19_3
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)
				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_7 = math.max(var_19_1, arg_16_1.talkMaxDuration)

			if var_19_0 <= arg_16_1.time_ and arg_16_1.time_ < var_19_0 + var_19_7 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_0) / var_19_7

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_0 + var_19_7 and arg_16_1.time_ < var_19_0 + var_19_7 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {}

		arg_16_1:InitPlayNodeList()
	end,
	Play111161005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 111161005
		arg_20_1.duration_ = 5

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play111161006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = 0
			local var_23_1 = 0.325

			if var_23_0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_0 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				local var_23_2 = arg_20_1:FormatText(StoryNameCfg[7].name)

				arg_20_1.leftNameTxt_.text = var_23_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, true)
				arg_20_1.iconController_:SetSelectedState("hero")

				arg_20_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_20_1.callingController_:SetSelectedState("normal")

				arg_20_1.keyicon_.color = Color.New(1, 1, 1)
				arg_20_1.icon_.color = Color.New(1, 1, 1)

				local var_23_3 = arg_20_1:GetWordFromCfg(111161005)
				local var_23_4 = arg_20_1:FormatText(var_23_3.content)

				arg_20_1.text_.text = var_23_4

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_5 = 13
				local var_23_6 = utf8.len(var_23_4)
				local var_23_7 = var_23_5 <= 0 and var_23_1 or var_23_1 * (var_23_6 / var_23_5)

				if var_23_7 > 0 and var_23_1 < var_23_7 then
					arg_20_1.talkMaxDuration = var_23_7

					if var_23_7 + var_23_0 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_7 + var_23_0
					end
				end

				arg_20_1.text_.text = var_23_4
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)
				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_8 = math.max(var_23_1, arg_20_1.talkMaxDuration)

			if var_23_0 <= arg_20_1.time_ and arg_20_1.time_ < var_23_0 + var_23_8 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_0) / var_23_8

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_0 + var_23_8 and arg_20_1.time_ < var_23_0 + var_23_8 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play111161006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 111161006
		arg_24_1.duration_ = 9.3

		local var_24_0 = {
			ja = 6.6,
			ko = 7.333,
			zh = 8.233,
			en = 9.3
		}
		local var_24_1 = manager.audio:GetLocalizationFlag()

		if var_24_0[var_24_1] ~= nil then
			arg_24_1.duration_ = var_24_0[var_24_1]
		end

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play111161007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = "1019ui_story"

			if arg_24_1.actors_[var_27_0] == nil then
				local var_27_1 = Asset.Load("Char/" .. "1019ui_story")

				if not isNil(var_27_1) then
					local var_27_2 = Object.Instantiate(Asset.Load("Char/" .. "1019ui_story"), arg_24_1.stage_.transform)

					var_27_2.name = var_27_0
					var_27_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_24_1.actors_[var_27_0] = var_27_2

					local var_27_3 = var_27_2:GetComponentInChildren(typeof(CharacterEffect))

					var_27_3.enabled = true

					local var_27_4 = GameObjectTools.GetOrAddComponent(var_27_2, typeof(DynamicBoneHelper))

					if var_27_4 then
						var_27_4:EnableDynamicBone(false)
					end

					arg_24_1:ShowWeapon(var_27_3.transform, false)

					arg_24_1.var_[var_27_0 .. "Animator"] = var_27_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_24_1.var_[var_27_0 .. "Animator"].applyRootMotion = true
					arg_24_1.var_[var_27_0 .. "LipSync"] = var_27_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_27_5 = arg_24_1.actors_["1019ui_story"].transform
			local var_27_6 = 0

			if var_27_6 < arg_24_1.time_ and arg_24_1.time_ <= var_27_6 + arg_27_0 then
				arg_24_1.var_.moveOldPos1019ui_story = var_27_5.localPosition
			end

			local var_27_7 = 0.001

			if var_27_6 <= arg_24_1.time_ and arg_24_1.time_ < var_27_6 + var_27_7 then
				local var_27_8 = (arg_24_1.time_ - var_27_6) / var_27_7
				local var_27_9 = Vector3.New(-0.7, -1.08, -5.9)

				var_27_5.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos1019ui_story, var_27_9, var_27_8)

				local var_27_10 = manager.ui.mainCamera.transform.position - var_27_5.position

				var_27_5.forward = Vector3.New(var_27_10.x, var_27_10.y, var_27_10.z)

				local var_27_11 = var_27_5.localEulerAngles

				var_27_11.z = 0
				var_27_11.x = 0
				var_27_5.localEulerAngles = var_27_11
			end

			if arg_24_1.time_ >= var_27_6 + var_27_7 and arg_24_1.time_ < var_27_6 + var_27_7 + arg_27_0 then
				var_27_5.localPosition = Vector3.New(-0.7, -1.08, -5.9)

				local var_27_12 = manager.ui.mainCamera.transform.position - var_27_5.position

				var_27_5.forward = Vector3.New(var_27_12.x, var_27_12.y, var_27_12.z)

				local var_27_13 = var_27_5.localEulerAngles

				var_27_13.z = 0
				var_27_13.x = 0
				var_27_5.localEulerAngles = var_27_13
			end

			local var_27_14 = 0

			if var_27_14 < arg_24_1.time_ and arg_24_1.time_ <= var_27_14 + arg_27_0 then
				arg_24_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action1_1")
			end

			local var_27_15 = 0

			if var_27_15 < arg_24_1.time_ and arg_24_1.time_ <= var_27_15 + arg_27_0 then
				arg_24_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_27_16 = arg_24_1.actors_["1019ui_story"]
			local var_27_17 = 0

			if var_27_17 < arg_24_1.time_ and arg_24_1.time_ <= var_27_17 + arg_27_0 and not isNil(var_27_16) and arg_24_1.var_.characterEffect1019ui_story == nil then
				arg_24_1.var_.characterEffect1019ui_story = var_27_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_18 = 0.2

			if var_27_17 <= arg_24_1.time_ and arg_24_1.time_ < var_27_17 + var_27_18 and not isNil(var_27_16) then
				local var_27_19 = (arg_24_1.time_ - var_27_17) / var_27_18

				if arg_24_1.var_.characterEffect1019ui_story and not isNil(var_27_16) then
					arg_24_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_24_1.time_ >= var_27_17 + var_27_18 and arg_24_1.time_ < var_27_17 + var_27_18 + arg_27_0 and not isNil(var_27_16) and arg_24_1.var_.characterEffect1019ui_story then
				arg_24_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_27_20 = 0
			local var_27_21 = 1.025

			if var_27_20 < arg_24_1.time_ and arg_24_1.time_ <= var_27_20 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				local var_27_22 = arg_24_1:FormatText(StoryNameCfg[13].name)

				arg_24_1.leftNameTxt_.text = var_27_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_23 = arg_24_1:GetWordFromCfg(111161006)
				local var_27_24 = arg_24_1:FormatText(var_27_23.content)

				arg_24_1.text_.text = var_27_24

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_25 = 41
				local var_27_26 = utf8.len(var_27_24)
				local var_27_27 = var_27_25 <= 0 and var_27_21 or var_27_21 * (var_27_26 / var_27_25)

				if var_27_27 > 0 and var_27_21 < var_27_27 then
					arg_24_1.talkMaxDuration = var_27_27

					if var_27_27 + var_27_20 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_27 + var_27_20
					end
				end

				arg_24_1.text_.text = var_27_24
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111161", "111161006", "story_v_out_111161.awb") ~= 0 then
					local var_27_28 = manager.audio:GetVoiceLength("story_v_out_111161", "111161006", "story_v_out_111161.awb") / 1000

					if var_27_28 + var_27_20 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_28 + var_27_20
					end

					if var_27_23.prefab_name ~= "" and arg_24_1.actors_[var_27_23.prefab_name] ~= nil then
						local var_27_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_23.prefab_name].transform, "story_v_out_111161", "111161006", "story_v_out_111161.awb")

						arg_24_1:RecordAudio("111161006", var_27_29)
						arg_24_1:RecordAudio("111161006", var_27_29)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_111161", "111161006", "story_v_out_111161.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_111161", "111161006", "story_v_out_111161.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_30 = math.max(var_27_21, arg_24_1.talkMaxDuration)

			if var_27_20 <= arg_24_1.time_ and arg_24_1.time_ < var_27_20 + var_27_30 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_20) / var_27_30

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_20 + var_27_30 and arg_24_1.time_ < var_27_20 + var_27_30 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {
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

		arg_24_1:InitPlayNodeList()
	end,
	Play111161007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 111161007
		arg_28_1.duration_ = 2

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play111161008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = "1094ui_story"

			if arg_28_1.actors_[var_31_0] == nil then
				local var_31_1 = Asset.Load("Char/" .. "1094ui_story")

				if not isNil(var_31_1) then
					local var_31_2 = Object.Instantiate(Asset.Load("Char/" .. "1094ui_story"), arg_28_1.stage_.transform)

					var_31_2.name = var_31_0
					var_31_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_28_1.actors_[var_31_0] = var_31_2

					local var_31_3 = var_31_2:GetComponentInChildren(typeof(CharacterEffect))

					var_31_3.enabled = true

					local var_31_4 = GameObjectTools.GetOrAddComponent(var_31_2, typeof(DynamicBoneHelper))

					if var_31_4 then
						var_31_4:EnableDynamicBone(false)
					end

					arg_28_1:ShowWeapon(var_31_3.transform, false)

					arg_28_1.var_[var_31_0 .. "Animator"] = var_31_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_28_1.var_[var_31_0 .. "Animator"].applyRootMotion = true
					arg_28_1.var_[var_31_0 .. "LipSync"] = var_31_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_31_5 = arg_28_1.actors_["1094ui_story"].transform
			local var_31_6 = 0

			if var_31_6 < arg_28_1.time_ and arg_28_1.time_ <= var_31_6 + arg_31_0 then
				arg_28_1.var_.moveOldPos1094ui_story = var_31_5.localPosition
			end

			local var_31_7 = 0.001

			if var_31_6 <= arg_28_1.time_ and arg_28_1.time_ < var_31_6 + var_31_7 then
				local var_31_8 = (arg_28_1.time_ - var_31_6) / var_31_7
				local var_31_9 = Vector3.New(0.7, -0.84, -6.1)

				var_31_5.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos1094ui_story, var_31_9, var_31_8)

				local var_31_10 = manager.ui.mainCamera.transform.position - var_31_5.position

				var_31_5.forward = Vector3.New(var_31_10.x, var_31_10.y, var_31_10.z)

				local var_31_11 = var_31_5.localEulerAngles

				var_31_11.z = 0
				var_31_11.x = 0
				var_31_5.localEulerAngles = var_31_11
			end

			if arg_28_1.time_ >= var_31_6 + var_31_7 and arg_28_1.time_ < var_31_6 + var_31_7 + arg_31_0 then
				var_31_5.localPosition = Vector3.New(0.7, -0.84, -6.1)

				local var_31_12 = manager.ui.mainCamera.transform.position - var_31_5.position

				var_31_5.forward = Vector3.New(var_31_12.x, var_31_12.y, var_31_12.z)

				local var_31_13 = var_31_5.localEulerAngles

				var_31_13.z = 0
				var_31_13.x = 0
				var_31_5.localEulerAngles = var_31_13
			end

			local var_31_14 = 0

			if var_31_14 < arg_28_1.time_ and arg_28_1.time_ <= var_31_14 + arg_31_0 then
				arg_28_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action1_1")
			end

			local var_31_15 = 0

			if var_31_15 < arg_28_1.time_ and arg_28_1.time_ <= var_31_15 + arg_31_0 then
				arg_28_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_31_16 = arg_28_1.actors_["1094ui_story"]
			local var_31_17 = 0

			if var_31_17 < arg_28_1.time_ and arg_28_1.time_ <= var_31_17 + arg_31_0 and not isNil(var_31_16) and arg_28_1.var_.characterEffect1094ui_story == nil then
				arg_28_1.var_.characterEffect1094ui_story = var_31_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_18 = 0.2

			if var_31_17 <= arg_28_1.time_ and arg_28_1.time_ < var_31_17 + var_31_18 and not isNil(var_31_16) then
				local var_31_19 = (arg_28_1.time_ - var_31_17) / var_31_18

				if arg_28_1.var_.characterEffect1094ui_story and not isNil(var_31_16) then
					arg_28_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_28_1.time_ >= var_31_17 + var_31_18 and arg_28_1.time_ < var_31_17 + var_31_18 + arg_31_0 and not isNil(var_31_16) and arg_28_1.var_.characterEffect1094ui_story then
				arg_28_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_31_20 = arg_28_1.actors_["1019ui_story"]
			local var_31_21 = 0

			if var_31_21 < arg_28_1.time_ and arg_28_1.time_ <= var_31_21 + arg_31_0 and not isNil(var_31_20) and arg_28_1.var_.characterEffect1019ui_story == nil then
				arg_28_1.var_.characterEffect1019ui_story = var_31_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_22 = 0.2

			if var_31_21 <= arg_28_1.time_ and arg_28_1.time_ < var_31_21 + var_31_22 and not isNil(var_31_20) then
				local var_31_23 = (arg_28_1.time_ - var_31_21) / var_31_22

				if arg_28_1.var_.characterEffect1019ui_story and not isNil(var_31_20) then
					local var_31_24 = Mathf.Lerp(0, 0.5, var_31_23)

					arg_28_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_28_1.var_.characterEffect1019ui_story.fillRatio = var_31_24
				end
			end

			if arg_28_1.time_ >= var_31_21 + var_31_22 and arg_28_1.time_ < var_31_21 + var_31_22 + arg_31_0 and not isNil(var_31_20) and arg_28_1.var_.characterEffect1019ui_story then
				local var_31_25 = 0.5

				arg_28_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_28_1.var_.characterEffect1019ui_story.fillRatio = var_31_25
			end

			local var_31_26 = 0
			local var_31_27 = 0.15

			if var_31_26 < arg_28_1.time_ and arg_28_1.time_ <= var_31_26 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				local var_31_28 = arg_28_1:FormatText(StoryNameCfg[181].name)

				arg_28_1.leftNameTxt_.text = var_31_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_29 = arg_28_1:GetWordFromCfg(111161007)
				local var_31_30 = arg_28_1:FormatText(var_31_29.content)

				arg_28_1.text_.text = var_31_30

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_31 = 6
				local var_31_32 = utf8.len(var_31_30)
				local var_31_33 = var_31_31 <= 0 and var_31_27 or var_31_27 * (var_31_32 / var_31_31)

				if var_31_33 > 0 and var_31_27 < var_31_33 then
					arg_28_1.talkMaxDuration = var_31_33

					if var_31_33 + var_31_26 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_33 + var_31_26
					end
				end

				arg_28_1.text_.text = var_31_30
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111161", "111161007", "story_v_out_111161.awb") ~= 0 then
					local var_31_34 = manager.audio:GetVoiceLength("story_v_out_111161", "111161007", "story_v_out_111161.awb") / 1000

					if var_31_34 + var_31_26 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_34 + var_31_26
					end

					if var_31_29.prefab_name ~= "" and arg_28_1.actors_[var_31_29.prefab_name] ~= nil then
						local var_31_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_29.prefab_name].transform, "story_v_out_111161", "111161007", "story_v_out_111161.awb")

						arg_28_1:RecordAudio("111161007", var_31_35)
						arg_28_1:RecordAudio("111161007", var_31_35)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_111161", "111161007", "story_v_out_111161.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_111161", "111161007", "story_v_out_111161.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_36 = math.max(var_31_27, arg_28_1.talkMaxDuration)

			if var_31_26 <= arg_28_1.time_ and arg_28_1.time_ < var_31_26 + var_31_36 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_26) / var_31_36

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_26 + var_31_36 and arg_28_1.time_ < var_31_26 + var_31_36 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {
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

		arg_28_1:InitPlayNodeList()
	end,
	Play111161008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 111161008
		arg_32_1.duration_ = 5.3

		local var_32_0 = {
			ja = 4.333,
			ko = 5.3,
			zh = 4,
			en = 4.3
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
				arg_32_0:Play111161009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = 0

			if var_35_0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_0 + arg_35_0 then
				arg_32_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_35_1 = arg_32_1.actors_["1094ui_story"]
			local var_35_2 = 0

			if var_35_2 < arg_32_1.time_ and arg_32_1.time_ <= var_35_2 + arg_35_0 and not isNil(var_35_1) and arg_32_1.var_.characterEffect1094ui_story == nil then
				arg_32_1.var_.characterEffect1094ui_story = var_35_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_3 = 0.2

			if var_35_2 <= arg_32_1.time_ and arg_32_1.time_ < var_35_2 + var_35_3 and not isNil(var_35_1) then
				local var_35_4 = (arg_32_1.time_ - var_35_2) / var_35_3

				if arg_32_1.var_.characterEffect1094ui_story and not isNil(var_35_1) then
					arg_32_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_32_1.time_ >= var_35_2 + var_35_3 and arg_32_1.time_ < var_35_2 + var_35_3 + arg_35_0 and not isNil(var_35_1) and arg_32_1.var_.characterEffect1094ui_story then
				arg_32_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_35_5 = 0
			local var_35_6 = 0.525

			if var_35_5 < arg_32_1.time_ and arg_32_1.time_ <= var_35_5 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				local var_35_7 = arg_32_1:FormatText(StoryNameCfg[181].name)

				arg_32_1.leftNameTxt_.text = var_35_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_8 = arg_32_1:GetWordFromCfg(111161008)
				local var_35_9 = arg_32_1:FormatText(var_35_8.content)

				arg_32_1.text_.text = var_35_9

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_10 = 18
				local var_35_11 = utf8.len(var_35_9)
				local var_35_12 = var_35_10 <= 0 and var_35_6 or var_35_6 * (var_35_11 / var_35_10)

				if var_35_12 > 0 and var_35_6 < var_35_12 then
					arg_32_1.talkMaxDuration = var_35_12

					if var_35_12 + var_35_5 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_12 + var_35_5
					end
				end

				arg_32_1.text_.text = var_35_9
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111161", "111161008", "story_v_out_111161.awb") ~= 0 then
					local var_35_13 = manager.audio:GetVoiceLength("story_v_out_111161", "111161008", "story_v_out_111161.awb") / 1000

					if var_35_13 + var_35_5 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_13 + var_35_5
					end

					if var_35_8.prefab_name ~= "" and arg_32_1.actors_[var_35_8.prefab_name] ~= nil then
						local var_35_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_8.prefab_name].transform, "story_v_out_111161", "111161008", "story_v_out_111161.awb")

						arg_32_1:RecordAudio("111161008", var_35_14)
						arg_32_1:RecordAudio("111161008", var_35_14)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_111161", "111161008", "story_v_out_111161.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_111161", "111161008", "story_v_out_111161.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_15 = math.max(var_35_6, arg_32_1.talkMaxDuration)

			if var_35_5 <= arg_32_1.time_ and arg_32_1.time_ < var_35_5 + var_35_15 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_5) / var_35_15

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_5 + var_35_15 and arg_32_1.time_ < var_35_5 + var_35_15 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play111161009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 111161009
		arg_36_1.duration_ = 4.4

		local var_36_0 = {
			ja = 4.4,
			ko = 1.999999999999,
			zh = 1.999999999999,
			en = 1.999999999999
		}
		local var_36_1 = manager.audio:GetLocalizationFlag()

		if var_36_0[var_36_1] ~= nil then
			arg_36_1.duration_ = var_36_0[var_36_1]
		end

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play111161010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = 0

			if var_39_0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_0 + arg_39_0 then
				arg_36_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_39_1 = arg_36_1.actors_["1094ui_story"]
			local var_39_2 = 0

			if var_39_2 < arg_36_1.time_ and arg_36_1.time_ <= var_39_2 + arg_39_0 and not isNil(var_39_1) and arg_36_1.var_.characterEffect1094ui_story == nil then
				arg_36_1.var_.characterEffect1094ui_story = var_39_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_3 = 0.2

			if var_39_2 <= arg_36_1.time_ and arg_36_1.time_ < var_39_2 + var_39_3 and not isNil(var_39_1) then
				local var_39_4 = (arg_36_1.time_ - var_39_2) / var_39_3

				if arg_36_1.var_.characterEffect1094ui_story and not isNil(var_39_1) then
					arg_36_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_36_1.time_ >= var_39_2 + var_39_3 and arg_36_1.time_ < var_39_2 + var_39_3 + arg_39_0 and not isNil(var_39_1) and arg_36_1.var_.characterEffect1094ui_story then
				arg_36_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_39_5 = 0
			local var_39_6 = 0.125

			if var_39_5 < arg_36_1.time_ and arg_36_1.time_ <= var_39_5 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				local var_39_7 = arg_36_1:FormatText(StoryNameCfg[181].name)

				arg_36_1.leftNameTxt_.text = var_39_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_8 = arg_36_1:GetWordFromCfg(111161009)
				local var_39_9 = arg_36_1:FormatText(var_39_8.content)

				arg_36_1.text_.text = var_39_9

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_10 = 5
				local var_39_11 = utf8.len(var_39_9)
				local var_39_12 = var_39_10 <= 0 and var_39_6 or var_39_6 * (var_39_11 / var_39_10)

				if var_39_12 > 0 and var_39_6 < var_39_12 then
					arg_36_1.talkMaxDuration = var_39_12

					if var_39_12 + var_39_5 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_12 + var_39_5
					end
				end

				arg_36_1.text_.text = var_39_9
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111161", "111161009", "story_v_out_111161.awb") ~= 0 then
					local var_39_13 = manager.audio:GetVoiceLength("story_v_out_111161", "111161009", "story_v_out_111161.awb") / 1000

					if var_39_13 + var_39_5 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_13 + var_39_5
					end

					if var_39_8.prefab_name ~= "" and arg_36_1.actors_[var_39_8.prefab_name] ~= nil then
						local var_39_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_8.prefab_name].transform, "story_v_out_111161", "111161009", "story_v_out_111161.awb")

						arg_36_1:RecordAudio("111161009", var_39_14)
						arg_36_1:RecordAudio("111161009", var_39_14)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_111161", "111161009", "story_v_out_111161.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_111161", "111161009", "story_v_out_111161.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_15 = math.max(var_39_6, arg_36_1.talkMaxDuration)

			if var_39_5 <= arg_36_1.time_ and arg_36_1.time_ < var_39_5 + var_39_15 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_5) / var_39_15

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_5 + var_39_15 and arg_36_1.time_ < var_39_5 + var_39_15 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play111161010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 111161010
		arg_40_1.duration_ = 5

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play111161011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = arg_40_1.actors_["1094ui_story"]
			local var_43_1 = 0

			if var_43_1 < arg_40_1.time_ and arg_40_1.time_ <= var_43_1 + arg_43_0 and not isNil(var_43_0) and arg_40_1.var_.characterEffect1094ui_story == nil then
				arg_40_1.var_.characterEffect1094ui_story = var_43_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_2 = 0.2

			if var_43_1 <= arg_40_1.time_ and arg_40_1.time_ < var_43_1 + var_43_2 and not isNil(var_43_0) then
				local var_43_3 = (arg_40_1.time_ - var_43_1) / var_43_2

				if arg_40_1.var_.characterEffect1094ui_story and not isNil(var_43_0) then
					local var_43_4 = Mathf.Lerp(0, 0.5, var_43_3)

					arg_40_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_40_1.var_.characterEffect1094ui_story.fillRatio = var_43_4
				end
			end

			if arg_40_1.time_ >= var_43_1 + var_43_2 and arg_40_1.time_ < var_43_1 + var_43_2 + arg_43_0 and not isNil(var_43_0) and arg_40_1.var_.characterEffect1094ui_story then
				local var_43_5 = 0.5

				arg_40_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_40_1.var_.characterEffect1094ui_story.fillRatio = var_43_5
			end

			local var_43_6 = arg_40_1.actors_["1019ui_story"].transform
			local var_43_7 = 0

			if var_43_7 < arg_40_1.time_ and arg_40_1.time_ <= var_43_7 + arg_43_0 then
				arg_40_1.var_.moveOldPos1019ui_story = var_43_6.localPosition
			end

			local var_43_8 = 0.001

			if var_43_7 <= arg_40_1.time_ and arg_40_1.time_ < var_43_7 + var_43_8 then
				local var_43_9 = (arg_40_1.time_ - var_43_7) / var_43_8
				local var_43_10 = Vector3.New(0, 100, 0)

				var_43_6.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos1019ui_story, var_43_10, var_43_9)

				local var_43_11 = manager.ui.mainCamera.transform.position - var_43_6.position

				var_43_6.forward = Vector3.New(var_43_11.x, var_43_11.y, var_43_11.z)

				local var_43_12 = var_43_6.localEulerAngles

				var_43_12.z = 0
				var_43_12.x = 0
				var_43_6.localEulerAngles = var_43_12
			end

			if arg_40_1.time_ >= var_43_7 + var_43_8 and arg_40_1.time_ < var_43_7 + var_43_8 + arg_43_0 then
				var_43_6.localPosition = Vector3.New(0, 100, 0)

				local var_43_13 = manager.ui.mainCamera.transform.position - var_43_6.position

				var_43_6.forward = Vector3.New(var_43_13.x, var_43_13.y, var_43_13.z)

				local var_43_14 = var_43_6.localEulerAngles

				var_43_14.z = 0
				var_43_14.x = 0
				var_43_6.localEulerAngles = var_43_14
			end

			local var_43_15 = arg_40_1.actors_["1094ui_story"].transform
			local var_43_16 = 0

			if var_43_16 < arg_40_1.time_ and arg_40_1.time_ <= var_43_16 + arg_43_0 then
				arg_40_1.var_.moveOldPos1094ui_story = var_43_15.localPosition
			end

			local var_43_17 = 0.001

			if var_43_16 <= arg_40_1.time_ and arg_40_1.time_ < var_43_16 + var_43_17 then
				local var_43_18 = (arg_40_1.time_ - var_43_16) / var_43_17
				local var_43_19 = Vector3.New(0, 100, 0)

				var_43_15.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos1094ui_story, var_43_19, var_43_18)

				local var_43_20 = manager.ui.mainCamera.transform.position - var_43_15.position

				var_43_15.forward = Vector3.New(var_43_20.x, var_43_20.y, var_43_20.z)

				local var_43_21 = var_43_15.localEulerAngles

				var_43_21.z = 0
				var_43_21.x = 0
				var_43_15.localEulerAngles = var_43_21
			end

			if arg_40_1.time_ >= var_43_16 + var_43_17 and arg_40_1.time_ < var_43_16 + var_43_17 + arg_43_0 then
				var_43_15.localPosition = Vector3.New(0, 100, 0)

				local var_43_22 = manager.ui.mainCamera.transform.position - var_43_15.position

				var_43_15.forward = Vector3.New(var_43_22.x, var_43_22.y, var_43_22.z)

				local var_43_23 = var_43_15.localEulerAngles

				var_43_23.z = 0
				var_43_23.x = 0
				var_43_15.localEulerAngles = var_43_23
			end

			local var_43_24 = 0
			local var_43_25 = 0.55

			if var_43_24 < arg_40_1.time_ and arg_40_1.time_ <= var_43_24 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, false)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_26 = arg_40_1:GetWordFromCfg(111161010)
				local var_43_27 = arg_40_1:FormatText(var_43_26.content)

				arg_40_1.text_.text = var_43_27

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_28 = 22
				local var_43_29 = utf8.len(var_43_27)
				local var_43_30 = var_43_28 <= 0 and var_43_25 or var_43_25 * (var_43_29 / var_43_28)

				if var_43_30 > 0 and var_43_25 < var_43_30 then
					arg_40_1.talkMaxDuration = var_43_30

					if var_43_30 + var_43_24 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_30 + var_43_24
					end
				end

				arg_40_1.text_.text = var_43_27
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)
				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_31 = math.max(var_43_25, arg_40_1.talkMaxDuration)

			if var_43_24 <= arg_40_1.time_ and arg_40_1.time_ < var_43_24 + var_43_31 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_24) / var_43_31

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_24 + var_43_31 and arg_40_1.time_ < var_43_24 + var_43_31 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_40_1:InitPlayNodeList()
	end,
	Play111161011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 111161011
		arg_44_1.duration_ = 9.37

		local var_44_0 = {
			ja = 4.533,
			ko = 9.366,
			zh = 9.3,
			en = 6.333
		}
		local var_44_1 = manager.audio:GetLocalizationFlag()

		if var_44_0[var_44_1] ~= nil then
			arg_44_1.duration_ = var_44_0[var_44_1]
		end

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play111161012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = 0
			local var_47_1 = 0.55

			if var_47_0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_0 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				local var_47_2 = arg_44_1:FormatText(StoryNameCfg[189].name)

				arg_44_1.leftNameTxt_.text = var_47_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, true)
				arg_44_1.iconController_:SetSelectedState("hero")

				arg_44_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_vina")

				arg_44_1.callingController_:SetSelectedState("normal")

				arg_44_1.keyicon_.color = Color.New(1, 1, 1)
				arg_44_1.icon_.color = Color.New(1, 1, 1)

				local var_47_3 = arg_44_1:GetWordFromCfg(111161011)
				local var_47_4 = arg_44_1:FormatText(var_47_3.content)

				arg_44_1.text_.text = var_47_4

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_5 = 22
				local var_47_6 = utf8.len(var_47_4)
				local var_47_7 = var_47_5 <= 0 and var_47_1 or var_47_1 * (var_47_6 / var_47_5)

				if var_47_7 > 0 and var_47_1 < var_47_7 then
					arg_44_1.talkMaxDuration = var_47_7

					if var_47_7 + var_47_0 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_7 + var_47_0
					end
				end

				arg_44_1.text_.text = var_47_4
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111161", "111161011", "story_v_out_111161.awb") ~= 0 then
					local var_47_8 = manager.audio:GetVoiceLength("story_v_out_111161", "111161011", "story_v_out_111161.awb") / 1000

					if var_47_8 + var_47_0 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_8 + var_47_0
					end

					if var_47_3.prefab_name ~= "" and arg_44_1.actors_[var_47_3.prefab_name] ~= nil then
						local var_47_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_3.prefab_name].transform, "story_v_out_111161", "111161011", "story_v_out_111161.awb")

						arg_44_1:RecordAudio("111161011", var_47_9)
						arg_44_1:RecordAudio("111161011", var_47_9)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_111161", "111161011", "story_v_out_111161.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_111161", "111161011", "story_v_out_111161.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_10 = math.max(var_47_1, arg_44_1.talkMaxDuration)

			if var_47_0 <= arg_44_1.time_ and arg_44_1.time_ < var_47_0 + var_47_10 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_0) / var_47_10

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_0 + var_47_10 and arg_44_1.time_ < var_47_0 + var_47_10 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play111161012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 111161012
		arg_48_1.duration_ = 5

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play111161013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = 0
			local var_51_1 = 0.55

			if var_51_0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_0 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				local var_51_2 = arg_48_1:FormatText(StoryNameCfg[7].name)

				arg_48_1.leftNameTxt_.text = var_51_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, true)
				arg_48_1.iconController_:SetSelectedState("hero")

				arg_48_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_48_1.callingController_:SetSelectedState("normal")

				arg_48_1.keyicon_.color = Color.New(1, 1, 1)
				arg_48_1.icon_.color = Color.New(1, 1, 1)

				local var_51_3 = arg_48_1:GetWordFromCfg(111161012)
				local var_51_4 = arg_48_1:FormatText(var_51_3.content)

				arg_48_1.text_.text = var_51_4

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_5 = 22
				local var_51_6 = utf8.len(var_51_4)
				local var_51_7 = var_51_5 <= 0 and var_51_1 or var_51_1 * (var_51_6 / var_51_5)

				if var_51_7 > 0 and var_51_1 < var_51_7 then
					arg_48_1.talkMaxDuration = var_51_7

					if var_51_7 + var_51_0 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_7 + var_51_0
					end
				end

				arg_48_1.text_.text = var_51_4
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)
				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_8 = math.max(var_51_1, arg_48_1.talkMaxDuration)

			if var_51_0 <= arg_48_1.time_ and arg_48_1.time_ < var_51_0 + var_51_8 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_0) / var_51_8

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_0 + var_51_8 and arg_48_1.time_ < var_51_0 + var_51_8 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play111161013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 111161013
		arg_52_1.duration_ = 6.87

		local var_52_0 = {
			ja = 6.5,
			ko = 6.1,
			zh = 6.1,
			en = 6.866
		}
		local var_52_1 = manager.audio:GetLocalizationFlag()

		if var_52_0[var_52_1] ~= nil then
			arg_52_1.duration_ = var_52_0[var_52_1]
		end

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play111161014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = 0
			local var_55_1 = 0.4

			if var_55_0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_0 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				local var_55_2 = arg_52_1:FormatText(StoryNameCfg[189].name)

				arg_52_1.leftNameTxt_.text = var_55_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, true)
				arg_52_1.iconController_:SetSelectedState("hero")

				arg_52_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_vina")

				arg_52_1.callingController_:SetSelectedState("normal")

				arg_52_1.keyicon_.color = Color.New(1, 1, 1)
				arg_52_1.icon_.color = Color.New(1, 1, 1)

				local var_55_3 = arg_52_1:GetWordFromCfg(111161013)
				local var_55_4 = arg_52_1:FormatText(var_55_3.content)

				arg_52_1.text_.text = var_55_4

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_5 = 17
				local var_55_6 = utf8.len(var_55_4)
				local var_55_7 = var_55_5 <= 0 and var_55_1 or var_55_1 * (var_55_6 / var_55_5)

				if var_55_7 > 0 and var_55_1 < var_55_7 then
					arg_52_1.talkMaxDuration = var_55_7

					if var_55_7 + var_55_0 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_7 + var_55_0
					end
				end

				arg_52_1.text_.text = var_55_4
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111161", "111161013", "story_v_out_111161.awb") ~= 0 then
					local var_55_8 = manager.audio:GetVoiceLength("story_v_out_111161", "111161013", "story_v_out_111161.awb") / 1000

					if var_55_8 + var_55_0 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_8 + var_55_0
					end

					if var_55_3.prefab_name ~= "" and arg_52_1.actors_[var_55_3.prefab_name] ~= nil then
						local var_55_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_3.prefab_name].transform, "story_v_out_111161", "111161013", "story_v_out_111161.awb")

						arg_52_1:RecordAudio("111161013", var_55_9)
						arg_52_1:RecordAudio("111161013", var_55_9)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_111161", "111161013", "story_v_out_111161.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_111161", "111161013", "story_v_out_111161.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_10 = math.max(var_55_1, arg_52_1.talkMaxDuration)

			if var_55_0 <= arg_52_1.time_ and arg_52_1.time_ < var_55_0 + var_55_10 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_0) / var_55_10

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_0 + var_55_10 and arg_52_1.time_ < var_55_0 + var_55_10 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play111161014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 111161014
		arg_56_1.duration_ = 18.2

		local var_56_0 = {
			ja = 18.2,
			ko = 11.533,
			zh = 8.566,
			en = 10.433
		}
		local var_56_1 = manager.audio:GetLocalizationFlag()

		if var_56_0[var_56_1] ~= nil then
			arg_56_1.duration_ = var_56_0[var_56_1]
		end

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play111161015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = 0
			local var_59_1 = 0.825

			if var_59_0 < arg_56_1.time_ and arg_56_1.time_ <= var_59_0 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				local var_59_2 = arg_56_1:FormatText(StoryNameCfg[189].name)

				arg_56_1.leftNameTxt_.text = var_59_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, true)
				arg_56_1.iconController_:SetSelectedState("hero")

				arg_56_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_vina")

				arg_56_1.callingController_:SetSelectedState("normal")

				arg_56_1.keyicon_.color = Color.New(1, 1, 1)
				arg_56_1.icon_.color = Color.New(1, 1, 1)

				local var_59_3 = arg_56_1:GetWordFromCfg(111161014)
				local var_59_4 = arg_56_1:FormatText(var_59_3.content)

				arg_56_1.text_.text = var_59_4

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_5 = 33
				local var_59_6 = utf8.len(var_59_4)
				local var_59_7 = var_59_5 <= 0 and var_59_1 or var_59_1 * (var_59_6 / var_59_5)

				if var_59_7 > 0 and var_59_1 < var_59_7 then
					arg_56_1.talkMaxDuration = var_59_7

					if var_59_7 + var_59_0 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_7 + var_59_0
					end
				end

				arg_56_1.text_.text = var_59_4
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111161", "111161014", "story_v_out_111161.awb") ~= 0 then
					local var_59_8 = manager.audio:GetVoiceLength("story_v_out_111161", "111161014", "story_v_out_111161.awb") / 1000

					if var_59_8 + var_59_0 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_8 + var_59_0
					end

					if var_59_3.prefab_name ~= "" and arg_56_1.actors_[var_59_3.prefab_name] ~= nil then
						local var_59_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_3.prefab_name].transform, "story_v_out_111161", "111161014", "story_v_out_111161.awb")

						arg_56_1:RecordAudio("111161014", var_59_9)
						arg_56_1:RecordAudio("111161014", var_59_9)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_out_111161", "111161014", "story_v_out_111161.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_out_111161", "111161014", "story_v_out_111161.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_10 = math.max(var_59_1, arg_56_1.talkMaxDuration)

			if var_59_0 <= arg_56_1.time_ and arg_56_1.time_ < var_59_0 + var_59_10 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_0) / var_59_10

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_0 + var_59_10 and arg_56_1.time_ < var_59_0 + var_59_10 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {}

		arg_56_1:InitPlayNodeList()
	end,
	Play111161015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 111161015
		arg_60_1.duration_ = 11.7

		local var_60_0 = {
			ja = 10.733,
			ko = 11.7,
			zh = 11.133,
			en = 11.6
		}
		local var_60_1 = manager.audio:GetLocalizationFlag()

		if var_60_0[var_60_1] ~= nil then
			arg_60_1.duration_ = var_60_0[var_60_1]
		end

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play111161016(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = 0
			local var_63_1 = 0.95

			if var_63_0 < arg_60_1.time_ and arg_60_1.time_ <= var_63_0 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				local var_63_2 = arg_60_1:FormatText(StoryNameCfg[189].name)

				arg_60_1.leftNameTxt_.text = var_63_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, true)
				arg_60_1.iconController_:SetSelectedState("hero")

				arg_60_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_vina")

				arg_60_1.callingController_:SetSelectedState("normal")

				arg_60_1.keyicon_.color = Color.New(1, 1, 1)
				arg_60_1.icon_.color = Color.New(1, 1, 1)

				local var_63_3 = arg_60_1:GetWordFromCfg(111161015)
				local var_63_4 = arg_60_1:FormatText(var_63_3.content)

				arg_60_1.text_.text = var_63_4

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_5 = 38
				local var_63_6 = utf8.len(var_63_4)
				local var_63_7 = var_63_5 <= 0 and var_63_1 or var_63_1 * (var_63_6 / var_63_5)

				if var_63_7 > 0 and var_63_1 < var_63_7 then
					arg_60_1.talkMaxDuration = var_63_7

					if var_63_7 + var_63_0 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_7 + var_63_0
					end
				end

				arg_60_1.text_.text = var_63_4
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111161", "111161015", "story_v_out_111161.awb") ~= 0 then
					local var_63_8 = manager.audio:GetVoiceLength("story_v_out_111161", "111161015", "story_v_out_111161.awb") / 1000

					if var_63_8 + var_63_0 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_8 + var_63_0
					end

					if var_63_3.prefab_name ~= "" and arg_60_1.actors_[var_63_3.prefab_name] ~= nil then
						local var_63_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_3.prefab_name].transform, "story_v_out_111161", "111161015", "story_v_out_111161.awb")

						arg_60_1:RecordAudio("111161015", var_63_9)
						arg_60_1:RecordAudio("111161015", var_63_9)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_111161", "111161015", "story_v_out_111161.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_111161", "111161015", "story_v_out_111161.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_10 = math.max(var_63_1, arg_60_1.talkMaxDuration)

			if var_63_0 <= arg_60_1.time_ and arg_60_1.time_ < var_63_0 + var_63_10 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_0) / var_63_10

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_0 + var_63_10 and arg_60_1.time_ < var_63_0 + var_63_10 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play111161016 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 111161016
		arg_64_1.duration_ = 5

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play111161017(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_0 = 0
			local var_67_1 = 0.75

			if var_67_0 < arg_64_1.time_ and arg_64_1.time_ <= var_67_0 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, false)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_2 = arg_64_1:GetWordFromCfg(111161016)
				local var_67_3 = arg_64_1:FormatText(var_67_2.content)

				arg_64_1.text_.text = var_67_3

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_4 = 30
				local var_67_5 = utf8.len(var_67_3)
				local var_67_6 = var_67_4 <= 0 and var_67_1 or var_67_1 * (var_67_5 / var_67_4)

				if var_67_6 > 0 and var_67_1 < var_67_6 then
					arg_64_1.talkMaxDuration = var_67_6

					if var_67_6 + var_67_0 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_6 + var_67_0
					end
				end

				arg_64_1.text_.text = var_67_3
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)
				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_7 = math.max(var_67_1, arg_64_1.talkMaxDuration)

			if var_67_0 <= arg_64_1.time_ and arg_64_1.time_ < var_67_0 + var_67_7 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_0) / var_67_7

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_0 + var_67_7 and arg_64_1.time_ < var_67_0 + var_67_7 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {}

		arg_64_1:InitPlayNodeList()
	end,
	Play111161017 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 111161017
		arg_68_1.duration_ = 5

		SetActive(arg_68_1.tipsGo_, false)

		function arg_68_1.onSingleLineFinish_()
			arg_68_1.onSingleLineUpdate_ = nil
			arg_68_1.onSingleLineFinish_ = nil
			arg_68_1.state_ = "waiting"
		end

		function arg_68_1.playNext_(arg_70_0)
			if arg_70_0 == 1 then
				arg_68_0:Play111161018(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = 0
			local var_71_1 = 1.025

			if var_71_0 < arg_68_1.time_ and arg_68_1.time_ <= var_71_0 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, false)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_2 = arg_68_1:GetWordFromCfg(111161017)
				local var_71_3 = arg_68_1:FormatText(var_71_2.content)

				arg_68_1.text_.text = var_71_3

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_4 = 41
				local var_71_5 = utf8.len(var_71_3)
				local var_71_6 = var_71_4 <= 0 and var_71_1 or var_71_1 * (var_71_5 / var_71_4)

				if var_71_6 > 0 and var_71_1 < var_71_6 then
					arg_68_1.talkMaxDuration = var_71_6

					if var_71_6 + var_71_0 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_6 + var_71_0
					end
				end

				arg_68_1.text_.text = var_71_3
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)
				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_7 = math.max(var_71_1, arg_68_1.talkMaxDuration)

			if var_71_0 <= arg_68_1.time_ and arg_68_1.time_ < var_71_0 + var_71_7 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_0) / var_71_7

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_0 + var_71_7 and arg_68_1.time_ < var_71_0 + var_71_7 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {}

		arg_68_1:InitPlayNodeList()
	end,
	Play111161018 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 111161018
		arg_72_1.duration_ = 4.23

		local var_72_0 = {
			ja = 4.233,
			ko = 3.266,
			zh = 3.166,
			en = 2.733
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
				arg_72_0:Play111161019(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			local var_75_0 = 0

			if var_75_0 < arg_72_1.time_ and arg_72_1.time_ <= var_75_0 + arg_75_0 then
				arg_72_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action1_1")
			end

			local var_75_1 = 0

			if var_75_1 < arg_72_1.time_ and arg_72_1.time_ <= var_75_1 + arg_75_0 then
				arg_72_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_75_2 = arg_72_1.actors_["1094ui_story"]
			local var_75_3 = 0

			if var_75_3 < arg_72_1.time_ and arg_72_1.time_ <= var_75_3 + arg_75_0 and not isNil(var_75_2) and arg_72_1.var_.characterEffect1094ui_story == nil then
				arg_72_1.var_.characterEffect1094ui_story = var_75_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_75_4 = 0.2

			if var_75_3 <= arg_72_1.time_ and arg_72_1.time_ < var_75_3 + var_75_4 and not isNil(var_75_2) then
				local var_75_5 = (arg_72_1.time_ - var_75_3) / var_75_4

				if arg_72_1.var_.characterEffect1094ui_story and not isNil(var_75_2) then
					arg_72_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_72_1.time_ >= var_75_3 + var_75_4 and arg_72_1.time_ < var_75_3 + var_75_4 + arg_75_0 and not isNil(var_75_2) and arg_72_1.var_.characterEffect1094ui_story then
				arg_72_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_75_6 = arg_72_1.actors_["1094ui_story"].transform
			local var_75_7 = 0

			if var_75_7 < arg_72_1.time_ and arg_72_1.time_ <= var_75_7 + arg_75_0 then
				arg_72_1.var_.moveOldPos1094ui_story = var_75_6.localPosition
			end

			local var_75_8 = 0.001

			if var_75_7 <= arg_72_1.time_ and arg_72_1.time_ < var_75_7 + var_75_8 then
				local var_75_9 = (arg_72_1.time_ - var_75_7) / var_75_8
				local var_75_10 = Vector3.New(0, -0.84, -6.1)

				var_75_6.localPosition = Vector3.Lerp(arg_72_1.var_.moveOldPos1094ui_story, var_75_10, var_75_9)

				local var_75_11 = manager.ui.mainCamera.transform.position - var_75_6.position

				var_75_6.forward = Vector3.New(var_75_11.x, var_75_11.y, var_75_11.z)

				local var_75_12 = var_75_6.localEulerAngles

				var_75_12.z = 0
				var_75_12.x = 0
				var_75_6.localEulerAngles = var_75_12
			end

			if arg_72_1.time_ >= var_75_7 + var_75_8 and arg_72_1.time_ < var_75_7 + var_75_8 + arg_75_0 then
				var_75_6.localPosition = Vector3.New(0, -0.84, -6.1)

				local var_75_13 = manager.ui.mainCamera.transform.position - var_75_6.position

				var_75_6.forward = Vector3.New(var_75_13.x, var_75_13.y, var_75_13.z)

				local var_75_14 = var_75_6.localEulerAngles

				var_75_14.z = 0
				var_75_14.x = 0
				var_75_6.localEulerAngles = var_75_14
			end

			local var_75_15 = 0
			local var_75_16 = 0.225

			if var_75_15 < arg_72_1.time_ and arg_72_1.time_ <= var_75_15 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				local var_75_17 = arg_72_1:FormatText(StoryNameCfg[181].name)

				arg_72_1.leftNameTxt_.text = var_75_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_18 = arg_72_1:GetWordFromCfg(111161018)
				local var_75_19 = arg_72_1:FormatText(var_75_18.content)

				arg_72_1.text_.text = var_75_19

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_20 = 9
				local var_75_21 = utf8.len(var_75_19)
				local var_75_22 = var_75_20 <= 0 and var_75_16 or var_75_16 * (var_75_21 / var_75_20)

				if var_75_22 > 0 and var_75_16 < var_75_22 then
					arg_72_1.talkMaxDuration = var_75_22

					if var_75_22 + var_75_15 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_22 + var_75_15
					end
				end

				arg_72_1.text_.text = var_75_19
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111161", "111161018", "story_v_out_111161.awb") ~= 0 then
					local var_75_23 = manager.audio:GetVoiceLength("story_v_out_111161", "111161018", "story_v_out_111161.awb") / 1000

					if var_75_23 + var_75_15 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_23 + var_75_15
					end

					if var_75_18.prefab_name ~= "" and arg_72_1.actors_[var_75_18.prefab_name] ~= nil then
						local var_75_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_18.prefab_name].transform, "story_v_out_111161", "111161018", "story_v_out_111161.awb")

						arg_72_1:RecordAudio("111161018", var_75_24)
						arg_72_1:RecordAudio("111161018", var_75_24)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_out_111161", "111161018", "story_v_out_111161.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_out_111161", "111161018", "story_v_out_111161.awb")
				end

				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_25 = math.max(var_75_16, arg_72_1.talkMaxDuration)

			if var_75_15 <= arg_72_1.time_ and arg_72_1.time_ < var_75_15 + var_75_25 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_15) / var_75_25

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_15 + var_75_25 and arg_72_1.time_ < var_75_15 + var_75_25 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {
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

		arg_72_1:InitPlayNodeList()
	end,
	Play111161019 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 111161019
		arg_76_1.duration_ = 5.5

		local var_76_0 = {
			ja = 5.5,
			ko = 2.666,
			zh = 3.033,
			en = 2.433
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
				arg_76_0:Play111161020(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			local var_79_0 = 0

			if var_79_0 < arg_76_1.time_ and arg_76_1.time_ <= var_79_0 + arg_79_0 then
				arg_76_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action5_1")
			end

			local var_79_1 = 0

			if var_79_1 < arg_76_1.time_ and arg_76_1.time_ <= var_79_1 + arg_79_0 then
				arg_76_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_79_2 = arg_76_1.actors_["1019ui_story"]
			local var_79_3 = 0

			if var_79_3 < arg_76_1.time_ and arg_76_1.time_ <= var_79_3 + arg_79_0 and not isNil(var_79_2) and arg_76_1.var_.characterEffect1019ui_story == nil then
				arg_76_1.var_.characterEffect1019ui_story = var_79_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_4 = 0.2

			if var_79_3 <= arg_76_1.time_ and arg_76_1.time_ < var_79_3 + var_79_4 and not isNil(var_79_2) then
				local var_79_5 = (arg_76_1.time_ - var_79_3) / var_79_4

				if arg_76_1.var_.characterEffect1019ui_story and not isNil(var_79_2) then
					arg_76_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_76_1.time_ >= var_79_3 + var_79_4 and arg_76_1.time_ < var_79_3 + var_79_4 + arg_79_0 and not isNil(var_79_2) and arg_76_1.var_.characterEffect1019ui_story then
				arg_76_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_79_6 = arg_76_1.actors_["1094ui_story"]
			local var_79_7 = 0

			if var_79_7 < arg_76_1.time_ and arg_76_1.time_ <= var_79_7 + arg_79_0 and not isNil(var_79_6) and arg_76_1.var_.characterEffect1094ui_story == nil then
				arg_76_1.var_.characterEffect1094ui_story = var_79_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_8 = 0.2

			if var_79_7 <= arg_76_1.time_ and arg_76_1.time_ < var_79_7 + var_79_8 and not isNil(var_79_6) then
				local var_79_9 = (arg_76_1.time_ - var_79_7) / var_79_8

				if arg_76_1.var_.characterEffect1094ui_story and not isNil(var_79_6) then
					local var_79_10 = Mathf.Lerp(0, 0.5, var_79_9)

					arg_76_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_76_1.var_.characterEffect1094ui_story.fillRatio = var_79_10
				end
			end

			if arg_76_1.time_ >= var_79_7 + var_79_8 and arg_76_1.time_ < var_79_7 + var_79_8 + arg_79_0 and not isNil(var_79_6) and arg_76_1.var_.characterEffect1094ui_story then
				local var_79_11 = 0.5

				arg_76_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_76_1.var_.characterEffect1094ui_story.fillRatio = var_79_11
			end

			local var_79_12 = arg_76_1.actors_["1019ui_story"].transform
			local var_79_13 = 0

			if var_79_13 < arg_76_1.time_ and arg_76_1.time_ <= var_79_13 + arg_79_0 then
				arg_76_1.var_.moveOldPos1019ui_story = var_79_12.localPosition
			end

			local var_79_14 = 0.001

			if var_79_13 <= arg_76_1.time_ and arg_76_1.time_ < var_79_13 + var_79_14 then
				local var_79_15 = (arg_76_1.time_ - var_79_13) / var_79_14
				local var_79_16 = Vector3.New(-0.2, -1.08, -5.9)

				var_79_12.localPosition = Vector3.Lerp(arg_76_1.var_.moveOldPos1019ui_story, var_79_16, var_79_15)

				local var_79_17 = manager.ui.mainCamera.transform.position - var_79_12.position

				var_79_12.forward = Vector3.New(var_79_17.x, var_79_17.y, var_79_17.z)

				local var_79_18 = var_79_12.localEulerAngles

				var_79_18.z = 0
				var_79_18.x = 0
				var_79_12.localEulerAngles = var_79_18
			end

			if arg_76_1.time_ >= var_79_13 + var_79_14 and arg_76_1.time_ < var_79_13 + var_79_14 + arg_79_0 then
				var_79_12.localPosition = Vector3.New(-0.2, -1.08, -5.9)

				local var_79_19 = manager.ui.mainCamera.transform.position - var_79_12.position

				var_79_12.forward = Vector3.New(var_79_19.x, var_79_19.y, var_79_19.z)

				local var_79_20 = var_79_12.localEulerAngles

				var_79_20.z = 0
				var_79_20.x = 0
				var_79_12.localEulerAngles = var_79_20
			end

			local var_79_21 = arg_76_1.actors_["1094ui_story"].transform
			local var_79_22 = 0

			if var_79_22 < arg_76_1.time_ and arg_76_1.time_ <= var_79_22 + arg_79_0 then
				arg_76_1.var_.moveOldPos1094ui_story = var_79_21.localPosition
			end

			local var_79_23 = 0.001

			if var_79_22 <= arg_76_1.time_ and arg_76_1.time_ < var_79_22 + var_79_23 then
				local var_79_24 = (arg_76_1.time_ - var_79_22) / var_79_23
				local var_79_25 = Vector3.New(0, 100, 0)

				var_79_21.localPosition = Vector3.Lerp(arg_76_1.var_.moveOldPos1094ui_story, var_79_25, var_79_24)

				local var_79_26 = manager.ui.mainCamera.transform.position - var_79_21.position

				var_79_21.forward = Vector3.New(var_79_26.x, var_79_26.y, var_79_26.z)

				local var_79_27 = var_79_21.localEulerAngles

				var_79_27.z = 0
				var_79_27.x = 0
				var_79_21.localEulerAngles = var_79_27
			end

			if arg_76_1.time_ >= var_79_22 + var_79_23 and arg_76_1.time_ < var_79_22 + var_79_23 + arg_79_0 then
				var_79_21.localPosition = Vector3.New(0, 100, 0)

				local var_79_28 = manager.ui.mainCamera.transform.position - var_79_21.position

				var_79_21.forward = Vector3.New(var_79_28.x, var_79_28.y, var_79_28.z)

				local var_79_29 = var_79_21.localEulerAngles

				var_79_29.z = 0
				var_79_29.x = 0
				var_79_21.localEulerAngles = var_79_29
			end

			local var_79_30 = 0
			local var_79_31 = 0.35

			if var_79_30 < arg_76_1.time_ and arg_76_1.time_ <= var_79_30 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				local var_79_32 = arg_76_1:FormatText(StoryNameCfg[13].name)

				arg_76_1.leftNameTxt_.text = var_79_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_33 = arg_76_1:GetWordFromCfg(111161019)
				local var_79_34 = arg_76_1:FormatText(var_79_33.content)

				arg_76_1.text_.text = var_79_34

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_35 = 14
				local var_79_36 = utf8.len(var_79_34)
				local var_79_37 = var_79_35 <= 0 and var_79_31 or var_79_31 * (var_79_36 / var_79_35)

				if var_79_37 > 0 and var_79_31 < var_79_37 then
					arg_76_1.talkMaxDuration = var_79_37

					if var_79_37 + var_79_30 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_37 + var_79_30
					end
				end

				arg_76_1.text_.text = var_79_34
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111161", "111161019", "story_v_out_111161.awb") ~= 0 then
					local var_79_38 = manager.audio:GetVoiceLength("story_v_out_111161", "111161019", "story_v_out_111161.awb") / 1000

					if var_79_38 + var_79_30 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_38 + var_79_30
					end

					if var_79_33.prefab_name ~= "" and arg_76_1.actors_[var_79_33.prefab_name] ~= nil then
						local var_79_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_33.prefab_name].transform, "story_v_out_111161", "111161019", "story_v_out_111161.awb")

						arg_76_1:RecordAudio("111161019", var_79_39)
						arg_76_1:RecordAudio("111161019", var_79_39)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_out_111161", "111161019", "story_v_out_111161.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_out_111161", "111161019", "story_v_out_111161.awb")
				end

				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_40 = math.max(var_79_31, arg_76_1.talkMaxDuration)

			if var_79_30 <= arg_76_1.time_ and arg_76_1.time_ < var_79_30 + var_79_40 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_30) / var_79_40

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_30 + var_79_40 and arg_76_1.time_ < var_79_30 + var_79_40 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_76_1:InitPlayNodeList()
	end,
	Play111161020 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 111161020
		arg_80_1.duration_ = 8.97

		local var_80_0 = {
			ja = 8.966,
			ko = 5,
			zh = 4.2,
			en = 5.166
		}
		local var_80_1 = manager.audio:GetLocalizationFlag()

		if var_80_0[var_80_1] ~= nil then
			arg_80_1.duration_ = var_80_0[var_80_1]
		end

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play111161021(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			local var_83_0 = 0

			if var_83_0 < arg_80_1.time_ and arg_80_1.time_ <= var_83_0 + arg_83_0 then
				arg_80_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_83_1 = 0
			local var_83_2 = 0.575

			if var_83_1 < arg_80_1.time_ and arg_80_1.time_ <= var_83_1 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				local var_83_3 = arg_80_1:FormatText(StoryNameCfg[13].name)

				arg_80_1.leftNameTxt_.text = var_83_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_4 = arg_80_1:GetWordFromCfg(111161020)
				local var_83_5 = arg_80_1:FormatText(var_83_4.content)

				arg_80_1.text_.text = var_83_5

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_6 = 23
				local var_83_7 = utf8.len(var_83_5)
				local var_83_8 = var_83_6 <= 0 and var_83_2 or var_83_2 * (var_83_7 / var_83_6)

				if var_83_8 > 0 and var_83_2 < var_83_8 then
					arg_80_1.talkMaxDuration = var_83_8

					if var_83_8 + var_83_1 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_8 + var_83_1
					end
				end

				arg_80_1.text_.text = var_83_5
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111161", "111161020", "story_v_out_111161.awb") ~= 0 then
					local var_83_9 = manager.audio:GetVoiceLength("story_v_out_111161", "111161020", "story_v_out_111161.awb") / 1000

					if var_83_9 + var_83_1 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_9 + var_83_1
					end

					if var_83_4.prefab_name ~= "" and arg_80_1.actors_[var_83_4.prefab_name] ~= nil then
						local var_83_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_80_1.actors_[var_83_4.prefab_name].transform, "story_v_out_111161", "111161020", "story_v_out_111161.awb")

						arg_80_1:RecordAudio("111161020", var_83_10)
						arg_80_1:RecordAudio("111161020", var_83_10)
					else
						arg_80_1:AudioAction("play", "voice", "story_v_out_111161", "111161020", "story_v_out_111161.awb")
					end

					arg_80_1:RecordHistoryTalkVoice("story_v_out_111161", "111161020", "story_v_out_111161.awb")
				end

				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_11 = math.max(var_83_2, arg_80_1.talkMaxDuration)

			if var_83_1 <= arg_80_1.time_ and arg_80_1.time_ < var_83_1 + var_83_11 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_1) / var_83_11

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_1 + var_83_11 and arg_80_1.time_ < var_83_1 + var_83_11 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {}

		arg_80_1:InitPlayNodeList()
	end,
	Play111161021 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 111161021
		arg_84_1.duration_ = 5.47

		local var_84_0 = {
			ja = 5.466,
			ko = 1.999999999999,
			zh = 1.999999999999,
			en = 2.4
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
				arg_84_0:Play111161022(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			local var_87_0 = 0

			if var_87_0 < arg_84_1.time_ and arg_84_1.time_ <= var_87_0 + arg_87_0 then
				arg_84_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_87_1 = arg_84_1.actors_["1094ui_story"]
			local var_87_2 = 0

			if var_87_2 < arg_84_1.time_ and arg_84_1.time_ <= var_87_2 + arg_87_0 and not isNil(var_87_1) and arg_84_1.var_.characterEffect1094ui_story == nil then
				arg_84_1.var_.characterEffect1094ui_story = var_87_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_87_3 = 0.2

			if var_87_2 <= arg_84_1.time_ and arg_84_1.time_ < var_87_2 + var_87_3 and not isNil(var_87_1) then
				local var_87_4 = (arg_84_1.time_ - var_87_2) / var_87_3

				if arg_84_1.var_.characterEffect1094ui_story and not isNil(var_87_1) then
					arg_84_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_84_1.time_ >= var_87_2 + var_87_3 and arg_84_1.time_ < var_87_2 + var_87_3 + arg_87_0 and not isNil(var_87_1) and arg_84_1.var_.characterEffect1094ui_story then
				arg_84_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_87_5 = arg_84_1.actors_["1019ui_story"]
			local var_87_6 = 0

			if var_87_6 < arg_84_1.time_ and arg_84_1.time_ <= var_87_6 + arg_87_0 and not isNil(var_87_5) and arg_84_1.var_.characterEffect1019ui_story == nil then
				arg_84_1.var_.characterEffect1019ui_story = var_87_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_87_7 = 0.2

			if var_87_6 <= arg_84_1.time_ and arg_84_1.time_ < var_87_6 + var_87_7 and not isNil(var_87_5) then
				local var_87_8 = (arg_84_1.time_ - var_87_6) / var_87_7

				if arg_84_1.var_.characterEffect1019ui_story and not isNil(var_87_5) then
					local var_87_9 = Mathf.Lerp(0, 0.5, var_87_8)

					arg_84_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_84_1.var_.characterEffect1019ui_story.fillRatio = var_87_9
				end
			end

			if arg_84_1.time_ >= var_87_6 + var_87_7 and arg_84_1.time_ < var_87_6 + var_87_7 + arg_87_0 and not isNil(var_87_5) and arg_84_1.var_.characterEffect1019ui_story then
				local var_87_10 = 0.5

				arg_84_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_84_1.var_.characterEffect1019ui_story.fillRatio = var_87_10
			end

			local var_87_11 = arg_84_1.actors_["1094ui_story"].transform
			local var_87_12 = 0

			if var_87_12 < arg_84_1.time_ and arg_84_1.time_ <= var_87_12 + arg_87_0 then
				arg_84_1.var_.moveOldPos1094ui_story = var_87_11.localPosition
			end

			local var_87_13 = 0.001

			if var_87_12 <= arg_84_1.time_ and arg_84_1.time_ < var_87_12 + var_87_13 then
				local var_87_14 = (arg_84_1.time_ - var_87_12) / var_87_13
				local var_87_15 = Vector3.New(0.7, -0.84, -6.1)

				var_87_11.localPosition = Vector3.Lerp(arg_84_1.var_.moveOldPos1094ui_story, var_87_15, var_87_14)

				local var_87_16 = manager.ui.mainCamera.transform.position - var_87_11.position

				var_87_11.forward = Vector3.New(var_87_16.x, var_87_16.y, var_87_16.z)

				local var_87_17 = var_87_11.localEulerAngles

				var_87_17.z = 0
				var_87_17.x = 0
				var_87_11.localEulerAngles = var_87_17
			end

			if arg_84_1.time_ >= var_87_12 + var_87_13 and arg_84_1.time_ < var_87_12 + var_87_13 + arg_87_0 then
				var_87_11.localPosition = Vector3.New(0.7, -0.84, -6.1)

				local var_87_18 = manager.ui.mainCamera.transform.position - var_87_11.position

				var_87_11.forward = Vector3.New(var_87_18.x, var_87_18.y, var_87_18.z)

				local var_87_19 = var_87_11.localEulerAngles

				var_87_19.z = 0
				var_87_19.x = 0
				var_87_11.localEulerAngles = var_87_19
			end

			local var_87_20 = 0

			if var_87_20 < arg_84_1.time_ and arg_84_1.time_ <= var_87_20 + arg_87_0 then
				arg_84_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action1_1")
			end

			local var_87_21 = arg_84_1.actors_["1019ui_story"].transform
			local var_87_22 = 0

			if var_87_22 < arg_84_1.time_ and arg_84_1.time_ <= var_87_22 + arg_87_0 then
				arg_84_1.var_.moveOldPos1019ui_story = var_87_21.localPosition
			end

			local var_87_23 = 0.5

			if var_87_22 <= arg_84_1.time_ and arg_84_1.time_ < var_87_22 + var_87_23 then
				local var_87_24 = (arg_84_1.time_ - var_87_22) / var_87_23
				local var_87_25 = Vector3.New(-0.7, -1.08, -5.9)

				var_87_21.localPosition = Vector3.Lerp(arg_84_1.var_.moveOldPos1019ui_story, var_87_25, var_87_24)

				local var_87_26 = manager.ui.mainCamera.transform.position - var_87_21.position

				var_87_21.forward = Vector3.New(var_87_26.x, var_87_26.y, var_87_26.z)

				local var_87_27 = var_87_21.localEulerAngles

				var_87_27.z = 0
				var_87_27.x = 0
				var_87_21.localEulerAngles = var_87_27
			end

			if arg_84_1.time_ >= var_87_22 + var_87_23 and arg_84_1.time_ < var_87_22 + var_87_23 + arg_87_0 then
				var_87_21.localPosition = Vector3.New(-0.7, -1.08, -5.9)

				local var_87_28 = manager.ui.mainCamera.transform.position - var_87_21.position

				var_87_21.forward = Vector3.New(var_87_28.x, var_87_28.y, var_87_28.z)

				local var_87_29 = var_87_21.localEulerAngles

				var_87_29.z = 0
				var_87_29.x = 0
				var_87_21.localEulerAngles = var_87_29
			end

			local var_87_30 = 0
			local var_87_31 = 0.175

			if var_87_30 < arg_84_1.time_ and arg_84_1.time_ <= var_87_30 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				local var_87_32 = arg_84_1:FormatText(StoryNameCfg[181].name)

				arg_84_1.leftNameTxt_.text = var_87_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_33 = arg_84_1:GetWordFromCfg(111161021)
				local var_87_34 = arg_84_1:FormatText(var_87_33.content)

				arg_84_1.text_.text = var_87_34

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_35 = 7
				local var_87_36 = utf8.len(var_87_34)
				local var_87_37 = var_87_35 <= 0 and var_87_31 or var_87_31 * (var_87_36 / var_87_35)

				if var_87_37 > 0 and var_87_31 < var_87_37 then
					arg_84_1.talkMaxDuration = var_87_37

					if var_87_37 + var_87_30 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_37 + var_87_30
					end
				end

				arg_84_1.text_.text = var_87_34
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111161", "111161021", "story_v_out_111161.awb") ~= 0 then
					local var_87_38 = manager.audio:GetVoiceLength("story_v_out_111161", "111161021", "story_v_out_111161.awb") / 1000

					if var_87_38 + var_87_30 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_38 + var_87_30
					end

					if var_87_33.prefab_name ~= "" and arg_84_1.actors_[var_87_33.prefab_name] ~= nil then
						local var_87_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_84_1.actors_[var_87_33.prefab_name].transform, "story_v_out_111161", "111161021", "story_v_out_111161.awb")

						arg_84_1:RecordAudio("111161021", var_87_39)
						arg_84_1:RecordAudio("111161021", var_87_39)
					else
						arg_84_1:AudioAction("play", "voice", "story_v_out_111161", "111161021", "story_v_out_111161.awb")
					end

					arg_84_1:RecordHistoryTalkVoice("story_v_out_111161", "111161021", "story_v_out_111161.awb")
				end

				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_40 = math.max(var_87_31, arg_84_1.talkMaxDuration)

			if var_87_30 <= arg_84_1.time_ and arg_84_1.time_ < var_87_30 + var_87_40 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_30) / var_87_40

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_30 + var_87_40 and arg_84_1.time_ < var_87_30 + var_87_40 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
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
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_84_1:InitPlayNodeList()
	end,
	Play111161022 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 111161022
		arg_88_1.duration_ = 2.9

		local var_88_0 = {
			ja = 1.266,
			ko = 1.4,
			zh = 2.9,
			en = 1.233
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
				arg_88_0:Play111161023(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			local var_91_0 = arg_88_1.actors_["1094ui_story"]
			local var_91_1 = 0

			if var_91_1 < arg_88_1.time_ and arg_88_1.time_ <= var_91_1 + arg_91_0 and not isNil(var_91_0) and arg_88_1.var_.characterEffect1094ui_story == nil then
				arg_88_1.var_.characterEffect1094ui_story = var_91_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_91_2 = 0.2

			if var_91_1 <= arg_88_1.time_ and arg_88_1.time_ < var_91_1 + var_91_2 and not isNil(var_91_0) then
				local var_91_3 = (arg_88_1.time_ - var_91_1) / var_91_2

				if arg_88_1.var_.characterEffect1094ui_story and not isNil(var_91_0) then
					local var_91_4 = Mathf.Lerp(0, 0.5, var_91_3)

					arg_88_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_88_1.var_.characterEffect1094ui_story.fillRatio = var_91_4
				end
			end

			if arg_88_1.time_ >= var_91_1 + var_91_2 and arg_88_1.time_ < var_91_1 + var_91_2 + arg_91_0 and not isNil(var_91_0) and arg_88_1.var_.characterEffect1094ui_story then
				local var_91_5 = 0.5

				arg_88_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_88_1.var_.characterEffect1094ui_story.fillRatio = var_91_5
			end

			local var_91_6 = 0
			local var_91_7 = 0.125

			if var_91_6 < arg_88_1.time_ and arg_88_1.time_ <= var_91_6 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				local var_91_8 = arg_88_1:FormatText(StoryNameCfg[189].name)

				arg_88_1.leftNameTxt_.text = var_91_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, true)
				arg_88_1.iconController_:SetSelectedState("hero")

				arg_88_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_vina")

				arg_88_1.callingController_:SetSelectedState("normal")

				arg_88_1.keyicon_.color = Color.New(1, 1, 1)
				arg_88_1.icon_.color = Color.New(1, 1, 1)

				local var_91_9 = arg_88_1:GetWordFromCfg(111161022)
				local var_91_10 = arg_88_1:FormatText(var_91_9.content)

				arg_88_1.text_.text = var_91_10

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_11 = 5
				local var_91_12 = utf8.len(var_91_10)
				local var_91_13 = var_91_11 <= 0 and var_91_7 or var_91_7 * (var_91_12 / var_91_11)

				if var_91_13 > 0 and var_91_7 < var_91_13 then
					arg_88_1.talkMaxDuration = var_91_13

					if var_91_13 + var_91_6 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_13 + var_91_6
					end
				end

				arg_88_1.text_.text = var_91_10
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111161", "111161022", "story_v_out_111161.awb") ~= 0 then
					local var_91_14 = manager.audio:GetVoiceLength("story_v_out_111161", "111161022", "story_v_out_111161.awb") / 1000

					if var_91_14 + var_91_6 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_14 + var_91_6
					end

					if var_91_9.prefab_name ~= "" and arg_88_1.actors_[var_91_9.prefab_name] ~= nil then
						local var_91_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_88_1.actors_[var_91_9.prefab_name].transform, "story_v_out_111161", "111161022", "story_v_out_111161.awb")

						arg_88_1:RecordAudio("111161022", var_91_15)
						arg_88_1:RecordAudio("111161022", var_91_15)
					else
						arg_88_1:AudioAction("play", "voice", "story_v_out_111161", "111161022", "story_v_out_111161.awb")
					end

					arg_88_1:RecordHistoryTalkVoice("story_v_out_111161", "111161022", "story_v_out_111161.awb")
				end

				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_16 = math.max(var_91_7, arg_88_1.talkMaxDuration)

			if var_91_6 <= arg_88_1.time_ and arg_88_1.time_ < var_91_6 + var_91_16 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_6) / var_91_16

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_6 + var_91_16 and arg_88_1.time_ < var_91_6 + var_91_16 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {}

		arg_88_1:InitPlayNodeList()
	end,
	Play111161023 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 111161023
		arg_92_1.duration_ = 5.2

		local var_92_0 = {
			ja = 5.2,
			ko = 2.933,
			zh = 3.433,
			en = 4.133
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
				arg_92_0:Play111161024(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			local var_95_0 = 0

			if var_95_0 < arg_92_1.time_ and arg_92_1.time_ <= var_95_0 + arg_95_0 then
				arg_92_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_95_1 = arg_92_1.actors_["1019ui_story"]
			local var_95_2 = 0

			if var_95_2 < arg_92_1.time_ and arg_92_1.time_ <= var_95_2 + arg_95_0 and not isNil(var_95_1) and arg_92_1.var_.characterEffect1019ui_story == nil then
				arg_92_1.var_.characterEffect1019ui_story = var_95_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_95_3 = 0.2

			if var_95_2 <= arg_92_1.time_ and arg_92_1.time_ < var_95_2 + var_95_3 and not isNil(var_95_1) then
				local var_95_4 = (arg_92_1.time_ - var_95_2) / var_95_3

				if arg_92_1.var_.characterEffect1019ui_story and not isNil(var_95_1) then
					arg_92_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_92_1.time_ >= var_95_2 + var_95_3 and arg_92_1.time_ < var_95_2 + var_95_3 + arg_95_0 and not isNil(var_95_1) and arg_92_1.var_.characterEffect1019ui_story then
				arg_92_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_95_5 = 0
			local var_95_6 = 0.425

			if var_95_5 < arg_92_1.time_ and arg_92_1.time_ <= var_95_5 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				local var_95_7 = arg_92_1:FormatText(StoryNameCfg[13].name)

				arg_92_1.leftNameTxt_.text = var_95_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_8 = arg_92_1:GetWordFromCfg(111161023)
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

				if manager.audio:GetVoiceLength("story_v_out_111161", "111161023", "story_v_out_111161.awb") ~= 0 then
					local var_95_13 = manager.audio:GetVoiceLength("story_v_out_111161", "111161023", "story_v_out_111161.awb") / 1000

					if var_95_13 + var_95_5 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_13 + var_95_5
					end

					if var_95_8.prefab_name ~= "" and arg_92_1.actors_[var_95_8.prefab_name] ~= nil then
						local var_95_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_92_1.actors_[var_95_8.prefab_name].transform, "story_v_out_111161", "111161023", "story_v_out_111161.awb")

						arg_92_1:RecordAudio("111161023", var_95_14)
						arg_92_1:RecordAudio("111161023", var_95_14)
					else
						arg_92_1:AudioAction("play", "voice", "story_v_out_111161", "111161023", "story_v_out_111161.awb")
					end

					arg_92_1:RecordHistoryTalkVoice("story_v_out_111161", "111161023", "story_v_out_111161.awb")
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
	Play111161024 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 111161024
		arg_96_1.duration_ = 9.4

		local var_96_0 = {
			ja = 9.4,
			ko = 2.6,
			zh = 3.5,
			en = 2.8
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
				arg_96_0:Play111161025(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			local var_99_0 = 0

			if var_99_0 < arg_96_1.time_ and arg_96_1.time_ <= var_99_0 + arg_99_0 then
				arg_96_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action3_2")
			end

			local var_99_1 = 0

			if var_99_1 < arg_96_1.time_ and arg_96_1.time_ <= var_99_1 + arg_99_0 then
				arg_96_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_99_2 = arg_96_1.actors_["1094ui_story"]
			local var_99_3 = 0

			if var_99_3 < arg_96_1.time_ and arg_96_1.time_ <= var_99_3 + arg_99_0 and not isNil(var_99_2) and arg_96_1.var_.characterEffect1094ui_story == nil then
				arg_96_1.var_.characterEffect1094ui_story = var_99_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_4 = 0.2

			if var_99_3 <= arg_96_1.time_ and arg_96_1.time_ < var_99_3 + var_99_4 and not isNil(var_99_2) then
				local var_99_5 = (arg_96_1.time_ - var_99_3) / var_99_4

				if arg_96_1.var_.characterEffect1094ui_story and not isNil(var_99_2) then
					arg_96_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_96_1.time_ >= var_99_3 + var_99_4 and arg_96_1.time_ < var_99_3 + var_99_4 + arg_99_0 and not isNil(var_99_2) and arg_96_1.var_.characterEffect1094ui_story then
				arg_96_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_99_6 = arg_96_1.actors_["1019ui_story"]
			local var_99_7 = 0

			if var_99_7 < arg_96_1.time_ and arg_96_1.time_ <= var_99_7 + arg_99_0 and not isNil(var_99_6) and arg_96_1.var_.characterEffect1019ui_story == nil then
				arg_96_1.var_.characterEffect1019ui_story = var_99_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_8 = 0.2

			if var_99_7 <= arg_96_1.time_ and arg_96_1.time_ < var_99_7 + var_99_8 and not isNil(var_99_6) then
				local var_99_9 = (arg_96_1.time_ - var_99_7) / var_99_8

				if arg_96_1.var_.characterEffect1019ui_story and not isNil(var_99_6) then
					local var_99_10 = Mathf.Lerp(0, 0.5, var_99_9)

					arg_96_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_96_1.var_.characterEffect1019ui_story.fillRatio = var_99_10
				end
			end

			if arg_96_1.time_ >= var_99_7 + var_99_8 and arg_96_1.time_ < var_99_7 + var_99_8 + arg_99_0 and not isNil(var_99_6) and arg_96_1.var_.characterEffect1019ui_story then
				local var_99_11 = 0.5

				arg_96_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_96_1.var_.characterEffect1019ui_story.fillRatio = var_99_11
			end

			local var_99_12 = 0
			local var_99_13 = 0.325

			if var_99_12 < arg_96_1.time_ and arg_96_1.time_ <= var_99_12 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				local var_99_14 = arg_96_1:FormatText(StoryNameCfg[181].name)

				arg_96_1.leftNameTxt_.text = var_99_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_15 = arg_96_1:GetWordFromCfg(111161024)
				local var_99_16 = arg_96_1:FormatText(var_99_15.content)

				arg_96_1.text_.text = var_99_16

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_17 = 12
				local var_99_18 = utf8.len(var_99_16)
				local var_99_19 = var_99_17 <= 0 and var_99_13 or var_99_13 * (var_99_18 / var_99_17)

				if var_99_19 > 0 and var_99_13 < var_99_19 then
					arg_96_1.talkMaxDuration = var_99_19

					if var_99_19 + var_99_12 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_19 + var_99_12
					end
				end

				arg_96_1.text_.text = var_99_16
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111161", "111161024", "story_v_out_111161.awb") ~= 0 then
					local var_99_20 = manager.audio:GetVoiceLength("story_v_out_111161", "111161024", "story_v_out_111161.awb") / 1000

					if var_99_20 + var_99_12 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_20 + var_99_12
					end

					if var_99_15.prefab_name ~= "" and arg_96_1.actors_[var_99_15.prefab_name] ~= nil then
						local var_99_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_96_1.actors_[var_99_15.prefab_name].transform, "story_v_out_111161", "111161024", "story_v_out_111161.awb")

						arg_96_1:RecordAudio("111161024", var_99_21)
						arg_96_1:RecordAudio("111161024", var_99_21)
					else
						arg_96_1:AudioAction("play", "voice", "story_v_out_111161", "111161024", "story_v_out_111161.awb")
					end

					arg_96_1:RecordHistoryTalkVoice("story_v_out_111161", "111161024", "story_v_out_111161.awb")
				end

				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_22 = math.max(var_99_13, arg_96_1.talkMaxDuration)

			if var_99_12 <= arg_96_1.time_ and arg_96_1.time_ < var_99_12 + var_99_22 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_12) / var_99_22

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_12 + var_99_22 and arg_96_1.time_ < var_99_12 + var_99_22 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {}

		arg_96_1:InitPlayNodeList()
	end,
	Play111161025 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 111161025
		arg_100_1.duration_ = 7.27

		local var_100_0 = {
			ja = 7.266,
			ko = 4.066,
			zh = 4.433,
			en = 2.4
		}
		local var_100_1 = manager.audio:GetLocalizationFlag()

		if var_100_0[var_100_1] ~= nil then
			arg_100_1.duration_ = var_100_0[var_100_1]
		end

		SetActive(arg_100_1.tipsGo_, false)

		function arg_100_1.onSingleLineFinish_()
			arg_100_1.onSingleLineUpdate_ = nil
			arg_100_1.onSingleLineFinish_ = nil
			arg_100_1.state_ = "waiting"
		end

		function arg_100_1.playNext_(arg_102_0)
			if arg_102_0 == 1 then
				arg_100_0:Play111161026(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			local var_103_0 = arg_100_1.actors_["1094ui_story"]
			local var_103_1 = 0

			if var_103_1 < arg_100_1.time_ and arg_100_1.time_ <= var_103_1 + arg_103_0 and not isNil(var_103_0) and arg_100_1.var_.characterEffect1094ui_story == nil then
				arg_100_1.var_.characterEffect1094ui_story = var_103_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_103_2 = 0.2

			if var_103_1 <= arg_100_1.time_ and arg_100_1.time_ < var_103_1 + var_103_2 and not isNil(var_103_0) then
				local var_103_3 = (arg_100_1.time_ - var_103_1) / var_103_2

				if arg_100_1.var_.characterEffect1094ui_story and not isNil(var_103_0) then
					local var_103_4 = Mathf.Lerp(0, 0.5, var_103_3)

					arg_100_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_100_1.var_.characterEffect1094ui_story.fillRatio = var_103_4
				end
			end

			if arg_100_1.time_ >= var_103_1 + var_103_2 and arg_100_1.time_ < var_103_1 + var_103_2 + arg_103_0 and not isNil(var_103_0) and arg_100_1.var_.characterEffect1094ui_story then
				local var_103_5 = 0.5

				arg_100_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_100_1.var_.characterEffect1094ui_story.fillRatio = var_103_5
			end

			local var_103_6 = 0
			local var_103_7 = 0.266666666666667

			if var_103_6 < arg_100_1.time_ and arg_100_1.time_ <= var_103_6 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				local var_103_8 = arg_100_1:FormatText(StoryNameCfg[189].name)

				arg_100_1.leftNameTxt_.text = var_103_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, true)
				arg_100_1.iconController_:SetSelectedState("hero")

				arg_100_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_vina")

				arg_100_1.callingController_:SetSelectedState("normal")

				arg_100_1.keyicon_.color = Color.New(1, 1, 1)
				arg_100_1.icon_.color = Color.New(1, 1, 1)

				local var_103_9 = arg_100_1:GetWordFromCfg(111161025)
				local var_103_10 = arg_100_1:FormatText(var_103_9.content)

				arg_100_1.text_.text = var_103_10

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_11 = 14
				local var_103_12 = utf8.len(var_103_10)
				local var_103_13 = var_103_11 <= 0 and var_103_7 or var_103_7 * (var_103_12 / var_103_11)

				if var_103_13 > 0 and var_103_7 < var_103_13 then
					arg_100_1.talkMaxDuration = var_103_13

					if var_103_13 + var_103_6 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_13 + var_103_6
					end
				end

				arg_100_1.text_.text = var_103_10
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111161", "111161025", "story_v_out_111161.awb") ~= 0 then
					local var_103_14 = manager.audio:GetVoiceLength("story_v_out_111161", "111161025", "story_v_out_111161.awb") / 1000

					if var_103_14 + var_103_6 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_14 + var_103_6
					end

					if var_103_9.prefab_name ~= "" and arg_100_1.actors_[var_103_9.prefab_name] ~= nil then
						local var_103_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_100_1.actors_[var_103_9.prefab_name].transform, "story_v_out_111161", "111161025", "story_v_out_111161.awb")

						arg_100_1:RecordAudio("111161025", var_103_15)
						arg_100_1:RecordAudio("111161025", var_103_15)
					else
						arg_100_1:AudioAction("play", "voice", "story_v_out_111161", "111161025", "story_v_out_111161.awb")
					end

					arg_100_1:RecordHistoryTalkVoice("story_v_out_111161", "111161025", "story_v_out_111161.awb")
				end

				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_16 = math.max(var_103_7, arg_100_1.talkMaxDuration)

			if var_103_6 <= arg_100_1.time_ and arg_100_1.time_ < var_103_6 + var_103_16 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_6) / var_103_16

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_6 + var_103_16 and arg_100_1.time_ < var_103_6 + var_103_16 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {}

		arg_100_1:InitPlayNodeList()
	end,
	Play111161026 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 111161026
		arg_104_1.duration_ = 10.07

		local var_104_0 = {
			ja = 10.066,
			ko = 5.366,
			zh = 6.2,
			en = 4.233
		}
		local var_104_1 = manager.audio:GetLocalizationFlag()

		if var_104_0[var_104_1] ~= nil then
			arg_104_1.duration_ = var_104_0[var_104_1]
		end

		SetActive(arg_104_1.tipsGo_, false)

		function arg_104_1.onSingleLineFinish_()
			arg_104_1.onSingleLineUpdate_ = nil
			arg_104_1.onSingleLineFinish_ = nil
			arg_104_1.state_ = "waiting"
		end

		function arg_104_1.playNext_(arg_106_0)
			if arg_106_0 == 1 then
				arg_104_0:Play111161027(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			local var_107_0 = "AS0107"

			if arg_104_1.bgs_[var_107_0] == nil then
				local var_107_1 = Object.Instantiate(arg_104_1.paintGo_)

				var_107_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_107_0)
				var_107_1.name = var_107_0
				var_107_1.transform.parent = arg_104_1.stage_.transform
				var_107_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_104_1.bgs_[var_107_0] = var_107_1
			end

			local var_107_2 = 0

			if var_107_2 < arg_104_1.time_ and arg_104_1.time_ <= var_107_2 + arg_107_0 then
				local var_107_3 = manager.ui.mainCamera.transform.localPosition
				local var_107_4 = Vector3.New(0, 0, 10) + Vector3.New(var_107_3.x, var_107_3.y, 0)
				local var_107_5 = arg_104_1.bgs_.AS0107

				var_107_5.transform.localPosition = var_107_4
				var_107_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_107_6 = var_107_5:GetComponent("SpriteRenderer")

				if var_107_6 and var_107_6.sprite then
					local var_107_7 = (var_107_5.transform.localPosition - var_107_3).z
					local var_107_8 = manager.ui.mainCameraCom_
					local var_107_9 = 2 * var_107_7 * Mathf.Tan(var_107_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_107_10 = var_107_9 * var_107_8.aspect
					local var_107_11 = var_107_6.sprite.bounds.size.x
					local var_107_12 = var_107_6.sprite.bounds.size.y
					local var_107_13 = var_107_10 / var_107_11
					local var_107_14 = var_107_9 / var_107_12
					local var_107_15 = var_107_14 < var_107_13 and var_107_13 or var_107_14

					var_107_5.transform.localScale = Vector3.New(var_107_15, var_107_15, 0)
				end

				for iter_107_0, iter_107_1 in pairs(arg_104_1.bgs_) do
					if iter_107_0 ~= "AS0107" then
						iter_107_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_107_16 = 0

			if var_107_16 < arg_104_1.time_ and arg_104_1.time_ <= var_107_16 + arg_107_0 then
				arg_104_1.mask_.enabled = true
				arg_104_1.mask_.raycastTarget = true

				arg_104_1:SetGaussion(false)
			end

			local var_107_17 = 2

			if var_107_16 <= arg_104_1.time_ and arg_104_1.time_ < var_107_16 + var_107_17 then
				local var_107_18 = (arg_104_1.time_ - var_107_16) / var_107_17
				local var_107_19 = Color.New(1, 1, 1)

				var_107_19.a = Mathf.Lerp(1, 0, var_107_18)
				arg_104_1.mask_.color = var_107_19
			end

			if arg_104_1.time_ >= var_107_16 + var_107_17 and arg_104_1.time_ < var_107_16 + var_107_17 + arg_107_0 then
				local var_107_20 = Color.New(1, 1, 1)
				local var_107_21 = 0

				arg_104_1.mask_.enabled = false
				var_107_20.a = var_107_21
				arg_104_1.mask_.color = var_107_20
			end

			local var_107_22 = arg_104_1.actors_["1019ui_story"].transform
			local var_107_23 = 0

			if var_107_23 < arg_104_1.time_ and arg_104_1.time_ <= var_107_23 + arg_107_0 then
				arg_104_1.var_.moveOldPos1019ui_story = var_107_22.localPosition
			end

			local var_107_24 = 0.001

			if var_107_23 <= arg_104_1.time_ and arg_104_1.time_ < var_107_23 + var_107_24 then
				local var_107_25 = (arg_104_1.time_ - var_107_23) / var_107_24
				local var_107_26 = Vector3.New(0, 100, 0)

				var_107_22.localPosition = Vector3.Lerp(arg_104_1.var_.moveOldPos1019ui_story, var_107_26, var_107_25)

				local var_107_27 = manager.ui.mainCamera.transform.position - var_107_22.position

				var_107_22.forward = Vector3.New(var_107_27.x, var_107_27.y, var_107_27.z)

				local var_107_28 = var_107_22.localEulerAngles

				var_107_28.z = 0
				var_107_28.x = 0
				var_107_22.localEulerAngles = var_107_28
			end

			if arg_104_1.time_ >= var_107_23 + var_107_24 and arg_104_1.time_ < var_107_23 + var_107_24 + arg_107_0 then
				var_107_22.localPosition = Vector3.New(0, 100, 0)

				local var_107_29 = manager.ui.mainCamera.transform.position - var_107_22.position

				var_107_22.forward = Vector3.New(var_107_29.x, var_107_29.y, var_107_29.z)

				local var_107_30 = var_107_22.localEulerAngles

				var_107_30.z = 0
				var_107_30.x = 0
				var_107_22.localEulerAngles = var_107_30
			end

			local var_107_31 = arg_104_1.actors_["1094ui_story"].transform
			local var_107_32 = 0

			if var_107_32 < arg_104_1.time_ and arg_104_1.time_ <= var_107_32 + arg_107_0 then
				arg_104_1.var_.moveOldPos1094ui_story = var_107_31.localPosition
			end

			local var_107_33 = 0.001

			if var_107_32 <= arg_104_1.time_ and arg_104_1.time_ < var_107_32 + var_107_33 then
				local var_107_34 = (arg_104_1.time_ - var_107_32) / var_107_33
				local var_107_35 = Vector3.New(0, 100, 0)

				var_107_31.localPosition = Vector3.Lerp(arg_104_1.var_.moveOldPos1094ui_story, var_107_35, var_107_34)

				local var_107_36 = manager.ui.mainCamera.transform.position - var_107_31.position

				var_107_31.forward = Vector3.New(var_107_36.x, var_107_36.y, var_107_36.z)

				local var_107_37 = var_107_31.localEulerAngles

				var_107_37.z = 0
				var_107_37.x = 0
				var_107_31.localEulerAngles = var_107_37
			end

			if arg_104_1.time_ >= var_107_32 + var_107_33 and arg_104_1.time_ < var_107_32 + var_107_33 + arg_107_0 then
				var_107_31.localPosition = Vector3.New(0, 100, 0)

				local var_107_38 = manager.ui.mainCamera.transform.position - var_107_31.position

				var_107_31.forward = Vector3.New(var_107_38.x, var_107_38.y, var_107_38.z)

				local var_107_39 = var_107_31.localEulerAngles

				var_107_39.z = 0
				var_107_39.x = 0
				var_107_31.localEulerAngles = var_107_39
			end

			local var_107_40 = 0

			if var_107_40 < arg_104_1.time_ and arg_104_1.time_ <= var_107_40 + arg_107_0 then
				arg_104_1.allBtn_.enabled = false
			end

			local var_107_41 = 2

			if arg_104_1.time_ >= var_107_40 + var_107_41 and arg_104_1.time_ < var_107_40 + var_107_41 + arg_107_0 then
				arg_104_1.allBtn_.enabled = true
			end

			if arg_104_1.frameCnt_ <= 1 then
				arg_104_1.dialog_:SetActive(false)
			end

			local var_107_42 = 2
			local var_107_43 = 0.325

			if var_107_42 < arg_104_1.time_ and arg_104_1.time_ <= var_107_42 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0

				arg_104_1.dialog_:SetActive(true)

				arg_104_1.dialogCg_.alpha = 0

				local var_107_44 = LeanTween.value(arg_104_1.dialog_, 0, 1, 0.3)

				var_107_44:setOnUpdate(LuaHelper.FloatAction(function(arg_108_0)
					arg_104_1.dialogCg_.alpha = arg_108_0
				end))
				var_107_44:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_104_1.dialog_)
					var_107_44:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_104_1.duration_ = arg_104_1.duration_ + 0.3

				SetActive(arg_104_1.leftNameGo_, true)

				local var_107_45 = arg_104_1:FormatText(StoryNameCfg[176].name)

				arg_104_1.leftNameTxt_.text = var_107_45

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, true)
				arg_104_1.iconController_:SetSelectedState("hero")

				arg_104_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_helena")

				arg_104_1.callingController_:SetSelectedState("normal")

				arg_104_1.keyicon_.color = Color.New(1, 1, 1)
				arg_104_1.icon_.color = Color.New(1, 1, 1)

				local var_107_46 = arg_104_1:GetWordFromCfg(111161026)
				local var_107_47 = arg_104_1:FormatText(var_107_46.content)

				arg_104_1.text_.text = var_107_47

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_48 = 13
				local var_107_49 = utf8.len(var_107_47)
				local var_107_50 = var_107_48 <= 0 and var_107_43 or var_107_43 * (var_107_49 / var_107_48)

				if var_107_50 > 0 and var_107_43 < var_107_50 then
					arg_104_1.talkMaxDuration = var_107_50
					var_107_42 = var_107_42 + 0.3

					if var_107_50 + var_107_42 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_50 + var_107_42
					end
				end

				arg_104_1.text_.text = var_107_47
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111161", "111161026", "story_v_out_111161.awb") ~= 0 then
					local var_107_51 = manager.audio:GetVoiceLength("story_v_out_111161", "111161026", "story_v_out_111161.awb") / 1000

					if var_107_51 + var_107_42 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_51 + var_107_42
					end

					if var_107_46.prefab_name ~= "" and arg_104_1.actors_[var_107_46.prefab_name] ~= nil then
						local var_107_52 = LuaForUtil.PlayVoiceWithCriLipsync(arg_104_1.actors_[var_107_46.prefab_name].transform, "story_v_out_111161", "111161026", "story_v_out_111161.awb")

						arg_104_1:RecordAudio("111161026", var_107_52)
						arg_104_1:RecordAudio("111161026", var_107_52)
					else
						arg_104_1:AudioAction("play", "voice", "story_v_out_111161", "111161026", "story_v_out_111161.awb")
					end

					arg_104_1:RecordHistoryTalkVoice("story_v_out_111161", "111161026", "story_v_out_111161.awb")
				end

				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_53 = var_107_42 + 0.3
			local var_107_54 = math.max(var_107_43, arg_104_1.talkMaxDuration)

			if var_107_53 <= arg_104_1.time_ and arg_104_1.time_ < var_107_53 + var_107_54 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_53) / var_107_54

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_53 + var_107_54 and arg_104_1.time_ < var_107_53 + var_107_54 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_104_1:InitPlayNodeList()
	end,
	Play111161027 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 111161027
		arg_110_1.duration_ = 6.1

		local var_110_0 = {
			ja = 5,
			ko = 4.2,
			zh = 6.1,
			en = 3.233
		}
		local var_110_1 = manager.audio:GetLocalizationFlag()

		if var_110_0[var_110_1] ~= nil then
			arg_110_1.duration_ = var_110_0[var_110_1]
		end

		SetActive(arg_110_1.tipsGo_, false)

		function arg_110_1.onSingleLineFinish_()
			arg_110_1.onSingleLineUpdate_ = nil
			arg_110_1.onSingleLineFinish_ = nil
			arg_110_1.state_ = "waiting"
		end

		function arg_110_1.playNext_(arg_112_0)
			if arg_112_0 == 1 then
				arg_110_0:Play111161028(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			local var_113_0 = 0
			local var_113_1 = 0.425

			if var_113_0 < arg_110_1.time_ and arg_110_1.time_ <= var_113_0 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, true)

				local var_113_2 = arg_110_1:FormatText(StoryNameCfg[182].name)

				arg_110_1.leftNameTxt_.text = var_113_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_110_1.leftNameTxt_.transform)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1.leftNameTxt_.text)
				SetActive(arg_110_1.iconTrs_.gameObject, true)
				arg_110_1.iconController_:SetSelectedState("hero")

				arg_110_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_vena")

				arg_110_1.callingController_:SetSelectedState("normal")

				arg_110_1.keyicon_.color = Color.New(1, 1, 1)
				arg_110_1.icon_.color = Color.New(1, 1, 1)

				local var_113_3 = arg_110_1:GetWordFromCfg(111161027)
				local var_113_4 = arg_110_1:FormatText(var_113_3.content)

				arg_110_1.text_.text = var_113_4

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_5 = 15
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

				if manager.audio:GetVoiceLength("story_v_out_111161", "111161027", "story_v_out_111161.awb") ~= 0 then
					local var_113_8 = manager.audio:GetVoiceLength("story_v_out_111161", "111161027", "story_v_out_111161.awb") / 1000

					if var_113_8 + var_113_0 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_8 + var_113_0
					end

					if var_113_3.prefab_name ~= "" and arg_110_1.actors_[var_113_3.prefab_name] ~= nil then
						local var_113_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_110_1.actors_[var_113_3.prefab_name].transform, "story_v_out_111161", "111161027", "story_v_out_111161.awb")

						arg_110_1:RecordAudio("111161027", var_113_9)
						arg_110_1:RecordAudio("111161027", var_113_9)
					else
						arg_110_1:AudioAction("play", "voice", "story_v_out_111161", "111161027", "story_v_out_111161.awb")
					end

					arg_110_1:RecordHistoryTalkVoice("story_v_out_111161", "111161027", "story_v_out_111161.awb")
				end

				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_10 = math.max(var_113_1, arg_110_1.talkMaxDuration)

			if var_113_0 <= arg_110_1.time_ and arg_110_1.time_ < var_113_0 + var_113_10 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - var_113_0) / var_113_10

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= var_113_0 + var_113_10 and arg_110_1.time_ < var_113_0 + var_113_10 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {}

		arg_110_1:InitPlayNodeList()
	end,
	Play111161028 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 111161028
		arg_114_1.duration_ = 5

		SetActive(arg_114_1.tipsGo_, false)

		function arg_114_1.onSingleLineFinish_()
			arg_114_1.onSingleLineUpdate_ = nil
			arg_114_1.onSingleLineFinish_ = nil
			arg_114_1.state_ = "waiting"
		end

		function arg_114_1.playNext_(arg_116_0)
			if arg_116_0 == 1 then
				arg_114_0:Play111161029(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			local var_117_0 = 0
			local var_117_1 = 0.95

			if var_117_0 < arg_114_1.time_ and arg_114_1.time_ <= var_117_0 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, false)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_114_1.iconTrs_.gameObject, false)
				arg_114_1.callingController_:SetSelectedState("normal")

				local var_117_2 = arg_114_1:GetWordFromCfg(111161028)
				local var_117_3 = arg_114_1:FormatText(var_117_2.content)

				arg_114_1.text_.text = var_117_3

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_4 = 38
				local var_117_5 = utf8.len(var_117_3)
				local var_117_6 = var_117_4 <= 0 and var_117_1 or var_117_1 * (var_117_5 / var_117_4)

				if var_117_6 > 0 and var_117_1 < var_117_6 then
					arg_114_1.talkMaxDuration = var_117_6

					if var_117_6 + var_117_0 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_6 + var_117_0
					end
				end

				arg_114_1.text_.text = var_117_3
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)
				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_7 = math.max(var_117_1, arg_114_1.talkMaxDuration)

			if var_117_0 <= arg_114_1.time_ and arg_114_1.time_ < var_117_0 + var_117_7 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - var_117_0) / var_117_7

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= var_117_0 + var_117_7 and arg_114_1.time_ < var_117_0 + var_117_7 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {}

		arg_114_1:InitPlayNodeList()
	end,
	Play111161029 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 111161029
		arg_118_1.duration_ = 5

		SetActive(arg_118_1.tipsGo_, false)

		function arg_118_1.onSingleLineFinish_()
			arg_118_1.onSingleLineUpdate_ = nil
			arg_118_1.onSingleLineFinish_ = nil
			arg_118_1.state_ = "waiting"
		end

		function arg_118_1.playNext_(arg_120_0)
			if arg_120_0 == 1 then
				arg_118_0:Play111161030(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			local var_121_0 = 0
			local var_121_1 = 0.575

			if var_121_0 < arg_118_1.time_ and arg_118_1.time_ <= var_121_0 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0
				arg_118_1.dialogCg_.alpha = 1

				arg_118_1.dialog_:SetActive(true)
				SetActive(arg_118_1.leftNameGo_, false)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_118_1.iconTrs_.gameObject, false)
				arg_118_1.callingController_:SetSelectedState("normal")

				local var_121_2 = arg_118_1:GetWordFromCfg(111161029)
				local var_121_3 = arg_118_1:FormatText(var_121_2.content)

				arg_118_1.text_.text = var_121_3

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_4 = 23
				local var_121_5 = utf8.len(var_121_3)
				local var_121_6 = var_121_4 <= 0 and var_121_1 or var_121_1 * (var_121_5 / var_121_4)

				if var_121_6 > 0 and var_121_1 < var_121_6 then
					arg_118_1.talkMaxDuration = var_121_6

					if var_121_6 + var_121_0 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_6 + var_121_0
					end
				end

				arg_118_1.text_.text = var_121_3
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)
				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_7 = math.max(var_121_1, arg_118_1.talkMaxDuration)

			if var_121_0 <= arg_118_1.time_ and arg_118_1.time_ < var_121_0 + var_121_7 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - var_121_0) / var_121_7

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= var_121_0 + var_121_7 and arg_118_1.time_ < var_121_0 + var_121_7 + arg_121_0 then
				arg_118_1.typewritter.percent = 1

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(true)
			end
		end

		arg_118_1.nodeConfigList_ = {}

		arg_118_1:InitPlayNodeList()
	end,
	Play111161030 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 111161030
		arg_122_1.duration_ = 5.67

		local var_122_0 = {
			ja = 5.666,
			ko = 2.8,
			zh = 2.833,
			en = 3.1
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
				arg_122_0:Play111161031(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			local var_125_0 = "AS0106"

			if arg_122_1.bgs_[var_125_0] == nil then
				local var_125_1 = Object.Instantiate(arg_122_1.paintGo_)

				var_125_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_125_0)
				var_125_1.name = var_125_0
				var_125_1.transform.parent = arg_122_1.stage_.transform
				var_125_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_122_1.bgs_[var_125_0] = var_125_1
			end

			local var_125_2 = 0

			if var_125_2 < arg_122_1.time_ and arg_122_1.time_ <= var_125_2 + arg_125_0 then
				local var_125_3 = manager.ui.mainCamera.transform.localPosition
				local var_125_4 = Vector3.New(0, 0, 10) + Vector3.New(var_125_3.x, var_125_3.y, 0)
				local var_125_5 = arg_122_1.bgs_.AS0106

				var_125_5.transform.localPosition = var_125_4
				var_125_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_125_6 = var_125_5:GetComponent("SpriteRenderer")

				if var_125_6 and var_125_6.sprite then
					local var_125_7 = (var_125_5.transform.localPosition - var_125_3).z
					local var_125_8 = manager.ui.mainCameraCom_
					local var_125_9 = 2 * var_125_7 * Mathf.Tan(var_125_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_125_10 = var_125_9 * var_125_8.aspect
					local var_125_11 = var_125_6.sprite.bounds.size.x
					local var_125_12 = var_125_6.sprite.bounds.size.y
					local var_125_13 = var_125_10 / var_125_11
					local var_125_14 = var_125_9 / var_125_12
					local var_125_15 = var_125_14 < var_125_13 and var_125_13 or var_125_14

					var_125_5.transform.localScale = Vector3.New(var_125_15, var_125_15, 0)
				end

				for iter_125_0, iter_125_1 in pairs(arg_122_1.bgs_) do
					if iter_125_0 ~= "AS0106" then
						iter_125_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_125_16 = 0

			if var_125_16 < arg_122_1.time_ and arg_122_1.time_ <= var_125_16 + arg_125_0 then
				arg_122_1.mask_.enabled = true
				arg_122_1.mask_.raycastTarget = true

				arg_122_1:SetGaussion(false)
			end

			local var_125_17 = 2

			if var_125_16 <= arg_122_1.time_ and arg_122_1.time_ < var_125_16 + var_125_17 then
				local var_125_18 = (arg_122_1.time_ - var_125_16) / var_125_17
				local var_125_19 = Color.New(1, 1, 1)

				var_125_19.a = Mathf.Lerp(1, 0, var_125_18)
				arg_122_1.mask_.color = var_125_19
			end

			if arg_122_1.time_ >= var_125_16 + var_125_17 and arg_122_1.time_ < var_125_16 + var_125_17 + arg_125_0 then
				local var_125_20 = Color.New(1, 1, 1)
				local var_125_21 = 0

				arg_122_1.mask_.enabled = false
				var_125_20.a = var_125_21
				arg_122_1.mask_.color = var_125_20
			end

			if arg_122_1.frameCnt_ <= 1 then
				arg_122_1.dialog_:SetActive(false)
			end

			local var_125_22 = 2
			local var_125_23 = 0.05

			if var_125_22 < arg_122_1.time_ and arg_122_1.time_ <= var_125_22 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0

				arg_122_1.dialog_:SetActive(true)

				arg_122_1.dialogCg_.alpha = 0

				local var_125_24 = LeanTween.value(arg_122_1.dialog_, 0, 1, 0.3)

				var_125_24:setOnUpdate(LuaHelper.FloatAction(function(arg_126_0)
					arg_122_1.dialogCg_.alpha = arg_126_0
				end))
				var_125_24:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_122_1.dialog_)
					var_125_24:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_122_1.duration_ = arg_122_1.duration_ + 0.3

				SetActive(arg_122_1.leftNameGo_, true)

				local var_125_25 = arg_122_1:FormatText(StoryNameCfg[181].name)

				arg_122_1.leftNameTxt_.text = var_125_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_122_1.leftNameTxt_.transform)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1.leftNameTxt_.text)
				SetActive(arg_122_1.iconTrs_.gameObject, false)
				arg_122_1.callingController_:SetSelectedState("normal")

				local var_125_26 = arg_122_1:GetWordFromCfg(111161030)
				local var_125_27 = arg_122_1:FormatText(var_125_26.content)

				arg_122_1.text_.text = var_125_27

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_28 = 2
				local var_125_29 = utf8.len(var_125_27)
				local var_125_30 = var_125_28 <= 0 and var_125_23 or var_125_23 * (var_125_29 / var_125_28)

				if var_125_30 > 0 and var_125_23 < var_125_30 then
					arg_122_1.talkMaxDuration = var_125_30
					var_125_22 = var_125_22 + 0.3

					if var_125_30 + var_125_22 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_30 + var_125_22
					end
				end

				arg_122_1.text_.text = var_125_27
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111161", "111161030", "story_v_out_111161.awb") ~= 0 then
					local var_125_31 = manager.audio:GetVoiceLength("story_v_out_111161", "111161030", "story_v_out_111161.awb") / 1000

					if var_125_31 + var_125_22 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_31 + var_125_22
					end

					if var_125_26.prefab_name ~= "" and arg_122_1.actors_[var_125_26.prefab_name] ~= nil then
						local var_125_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_122_1.actors_[var_125_26.prefab_name].transform, "story_v_out_111161", "111161030", "story_v_out_111161.awb")

						arg_122_1:RecordAudio("111161030", var_125_32)
						arg_122_1:RecordAudio("111161030", var_125_32)
					else
						arg_122_1:AudioAction("play", "voice", "story_v_out_111161", "111161030", "story_v_out_111161.awb")
					end

					arg_122_1:RecordHistoryTalkVoice("story_v_out_111161", "111161030", "story_v_out_111161.awb")
				end

				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_33 = var_125_22 + 0.3
			local var_125_34 = math.max(var_125_23, arg_122_1.talkMaxDuration)

			if var_125_33 <= arg_122_1.time_ and arg_122_1.time_ < var_125_33 + var_125_34 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - var_125_33) / var_125_34

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= var_125_33 + var_125_34 and arg_122_1.time_ < var_125_33 + var_125_34 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {}

		arg_122_1:InitPlayNodeList()
	end,
	Play111161031 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 111161031
		arg_128_1.duration_ = 6.27

		local var_128_0 = {
			ja = 6.266,
			ko = 1.1,
			zh = 2.133,
			en = 1.2
		}
		local var_128_1 = manager.audio:GetLocalizationFlag()

		if var_128_0[var_128_1] ~= nil then
			arg_128_1.duration_ = var_128_0[var_128_1]
		end

		SetActive(arg_128_1.tipsGo_, false)

		function arg_128_1.onSingleLineFinish_()
			arg_128_1.onSingleLineUpdate_ = nil
			arg_128_1.onSingleLineFinish_ = nil
			arg_128_1.state_ = "waiting"
		end

		function arg_128_1.playNext_(arg_130_0)
			if arg_130_0 == 1 then
				arg_128_0:Play111161032(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			local var_131_0 = 0
			local var_131_1 = 0.1

			if var_131_0 < arg_128_1.time_ and arg_128_1.time_ <= var_131_0 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				local var_131_2 = arg_128_1:FormatText(StoryNameCfg[189].name)

				arg_128_1.leftNameTxt_.text = var_131_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, true)
				arg_128_1.iconController_:SetSelectedState("hero")

				arg_128_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_vina")

				arg_128_1.callingController_:SetSelectedState("normal")

				arg_128_1.keyicon_.color = Color.New(1, 1, 1)
				arg_128_1.icon_.color = Color.New(1, 1, 1)

				local var_131_3 = arg_128_1:GetWordFromCfg(111161031)
				local var_131_4 = arg_128_1:FormatText(var_131_3.content)

				arg_128_1.text_.text = var_131_4

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_5 = 4
				local var_131_6 = utf8.len(var_131_4)
				local var_131_7 = var_131_5 <= 0 and var_131_1 or var_131_1 * (var_131_6 / var_131_5)

				if var_131_7 > 0 and var_131_1 < var_131_7 then
					arg_128_1.talkMaxDuration = var_131_7

					if var_131_7 + var_131_0 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_7 + var_131_0
					end
				end

				arg_128_1.text_.text = var_131_4
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111161", "111161031", "story_v_out_111161.awb") ~= 0 then
					local var_131_8 = manager.audio:GetVoiceLength("story_v_out_111161", "111161031", "story_v_out_111161.awb") / 1000

					if var_131_8 + var_131_0 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_8 + var_131_0
					end

					if var_131_3.prefab_name ~= "" and arg_128_1.actors_[var_131_3.prefab_name] ~= nil then
						local var_131_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_128_1.actors_[var_131_3.prefab_name].transform, "story_v_out_111161", "111161031", "story_v_out_111161.awb")

						arg_128_1:RecordAudio("111161031", var_131_9)
						arg_128_1:RecordAudio("111161031", var_131_9)
					else
						arg_128_1:AudioAction("play", "voice", "story_v_out_111161", "111161031", "story_v_out_111161.awb")
					end

					arg_128_1:RecordHistoryTalkVoice("story_v_out_111161", "111161031", "story_v_out_111161.awb")
				end

				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_10 = math.max(var_131_1, arg_128_1.talkMaxDuration)

			if var_131_0 <= arg_128_1.time_ and arg_128_1.time_ < var_131_0 + var_131_10 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_0) / var_131_10

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_0 + var_131_10 and arg_128_1.time_ < var_131_0 + var_131_10 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {}

		arg_128_1:InitPlayNodeList()
	end,
	Play111161032 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 111161032
		arg_132_1.duration_ = 5

		SetActive(arg_132_1.tipsGo_, false)

		function arg_132_1.onSingleLineFinish_()
			arg_132_1.onSingleLineUpdate_ = nil
			arg_132_1.onSingleLineFinish_ = nil
			arg_132_1.state_ = "waiting"
		end

		function arg_132_1.playNext_(arg_134_0)
			if arg_134_0 == 1 then
				arg_132_0:Play111161033(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			local var_135_0 = 0
			local var_135_1 = 0.3

			if var_135_0 < arg_132_1.time_ and arg_132_1.time_ <= var_135_0 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, false)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_2 = arg_132_1:GetWordFromCfg(111161032)
				local var_135_3 = arg_132_1:FormatText(var_135_2.content)

				arg_132_1.text_.text = var_135_3

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_4 = 12
				local var_135_5 = utf8.len(var_135_3)
				local var_135_6 = var_135_4 <= 0 and var_135_1 or var_135_1 * (var_135_5 / var_135_4)

				if var_135_6 > 0 and var_135_1 < var_135_6 then
					arg_132_1.talkMaxDuration = var_135_6

					if var_135_6 + var_135_0 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_6 + var_135_0
					end
				end

				arg_132_1.text_.text = var_135_3
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)
				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_7 = math.max(var_135_1, arg_132_1.talkMaxDuration)

			if var_135_0 <= arg_132_1.time_ and arg_132_1.time_ < var_135_0 + var_135_7 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_0) / var_135_7

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_0 + var_135_7 and arg_132_1.time_ < var_135_0 + var_135_7 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {}

		arg_132_1:InitPlayNodeList()
	end,
	Play111161033 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 111161033
		arg_136_1.duration_ = 5

		SetActive(arg_136_1.tipsGo_, false)

		function arg_136_1.onSingleLineFinish_()
			arg_136_1.onSingleLineUpdate_ = nil
			arg_136_1.onSingleLineFinish_ = nil
			arg_136_1.state_ = "waiting"
		end

		function arg_136_1.playNext_(arg_138_0)
			if arg_138_0 == 1 then
				arg_136_0:Play111161034(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			local var_139_0 = 0
			local var_139_1 = 0.2

			if var_139_0 < arg_136_1.time_ and arg_136_1.time_ <= var_139_0 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, true)

				local var_139_2 = arg_136_1:FormatText(StoryNameCfg[7].name)

				arg_136_1.leftNameTxt_.text = var_139_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_136_1.leftNameTxt_.transform)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1.leftNameTxt_.text)
				SetActive(arg_136_1.iconTrs_.gameObject, true)
				arg_136_1.iconController_:SetSelectedState("hero")

				arg_136_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_136_1.callingController_:SetSelectedState("normal")

				arg_136_1.keyicon_.color = Color.New(1, 1, 1)
				arg_136_1.icon_.color = Color.New(1, 1, 1)

				local var_139_3 = arg_136_1:GetWordFromCfg(111161033)
				local var_139_4 = arg_136_1:FormatText(var_139_3.content)

				arg_136_1.text_.text = var_139_4

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_5 = 8
				local var_139_6 = utf8.len(var_139_4)
				local var_139_7 = var_139_5 <= 0 and var_139_1 or var_139_1 * (var_139_6 / var_139_5)

				if var_139_7 > 0 and var_139_1 < var_139_7 then
					arg_136_1.talkMaxDuration = var_139_7

					if var_139_7 + var_139_0 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_7 + var_139_0
					end
				end

				arg_136_1.text_.text = var_139_4
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)
				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_8 = math.max(var_139_1, arg_136_1.talkMaxDuration)

			if var_139_0 <= arg_136_1.time_ and arg_136_1.time_ < var_139_0 + var_139_8 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_0) / var_139_8

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_0 + var_139_8 and arg_136_1.time_ < var_139_0 + var_139_8 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {}

		arg_136_1:InitPlayNodeList()
	end,
	Play111161034 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 111161034
		arg_140_1.duration_ = 2.57

		local var_140_0 = {
			ja = 1.033,
			ko = 1,
			zh = 1.3,
			en = 2.566
		}
		local var_140_1 = manager.audio:GetLocalizationFlag()

		if var_140_0[var_140_1] ~= nil then
			arg_140_1.duration_ = var_140_0[var_140_1]
		end

		SetActive(arg_140_1.tipsGo_, false)

		function arg_140_1.onSingleLineFinish_()
			arg_140_1.onSingleLineUpdate_ = nil
			arg_140_1.onSingleLineFinish_ = nil
			arg_140_1.state_ = "waiting"
		end

		function arg_140_1.playNext_(arg_142_0)
			if arg_142_0 == 1 then
				arg_140_0:Play111161035(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			local var_143_0 = 0
			local var_143_1 = 0.05

			if var_143_0 < arg_140_1.time_ and arg_140_1.time_ <= var_143_0 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, true)

				local var_143_2 = arg_140_1:FormatText(StoryNameCfg[189].name)

				arg_140_1.leftNameTxt_.text = var_143_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_140_1.leftNameTxt_.transform)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1.leftNameTxt_.text)
				SetActive(arg_140_1.iconTrs_.gameObject, true)
				arg_140_1.iconController_:SetSelectedState("hero")

				arg_140_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_vina")

				arg_140_1.callingController_:SetSelectedState("normal")

				arg_140_1.keyicon_.color = Color.New(1, 1, 1)
				arg_140_1.icon_.color = Color.New(1, 1, 1)

				local var_143_3 = arg_140_1:GetWordFromCfg(111161034)
				local var_143_4 = arg_140_1:FormatText(var_143_3.content)

				arg_140_1.text_.text = var_143_4

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_5 = 2
				local var_143_6 = utf8.len(var_143_4)
				local var_143_7 = var_143_5 <= 0 and var_143_1 or var_143_1 * (var_143_6 / var_143_5)

				if var_143_7 > 0 and var_143_1 < var_143_7 then
					arg_140_1.talkMaxDuration = var_143_7

					if var_143_7 + var_143_0 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_7 + var_143_0
					end
				end

				arg_140_1.text_.text = var_143_4
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111161", "111161034", "story_v_out_111161.awb") ~= 0 then
					local var_143_8 = manager.audio:GetVoiceLength("story_v_out_111161", "111161034", "story_v_out_111161.awb") / 1000

					if var_143_8 + var_143_0 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_8 + var_143_0
					end

					if var_143_3.prefab_name ~= "" and arg_140_1.actors_[var_143_3.prefab_name] ~= nil then
						local var_143_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_140_1.actors_[var_143_3.prefab_name].transform, "story_v_out_111161", "111161034", "story_v_out_111161.awb")

						arg_140_1:RecordAudio("111161034", var_143_9)
						arg_140_1:RecordAudio("111161034", var_143_9)
					else
						arg_140_1:AudioAction("play", "voice", "story_v_out_111161", "111161034", "story_v_out_111161.awb")
					end

					arg_140_1:RecordHistoryTalkVoice("story_v_out_111161", "111161034", "story_v_out_111161.awb")
				end

				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_10 = math.max(var_143_1, arg_140_1.talkMaxDuration)

			if var_143_0 <= arg_140_1.time_ and arg_140_1.time_ < var_143_0 + var_143_10 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_0) / var_143_10

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_0 + var_143_10 and arg_140_1.time_ < var_143_0 + var_143_10 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {}

		arg_140_1:InitPlayNodeList()
	end,
	Play111161035 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 111161035
		arg_144_1.duration_ = 5

		SetActive(arg_144_1.tipsGo_, false)

		function arg_144_1.onSingleLineFinish_()
			arg_144_1.onSingleLineUpdate_ = nil
			arg_144_1.onSingleLineFinish_ = nil
			arg_144_1.state_ = "waiting"
		end

		function arg_144_1.playNext_(arg_146_0)
			if arg_146_0 == 1 then
				arg_144_0:Play111161036(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			local var_147_0 = 0
			local var_147_1 = 0.175

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

				local var_147_3 = arg_144_1:GetWordFromCfg(111161035)
				local var_147_4 = arg_144_1:FormatText(var_147_3.content)

				arg_144_1.text_.text = var_147_4

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_5 = 7
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
	Play111161036 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 111161036
		arg_148_1.duration_ = 7.12

		SetActive(arg_148_1.tipsGo_, false)

		function arg_148_1.onSingleLineFinish_()
			arg_148_1.onSingleLineUpdate_ = nil
			arg_148_1.onSingleLineFinish_ = nil
			arg_148_1.state_ = "waiting"
		end

		function arg_148_1.playNext_(arg_150_0)
			if arg_150_0 == 1 then
				arg_148_0:Play111161037(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			local var_151_0 = "D09a"

			if arg_148_1.bgs_[var_151_0] == nil then
				local var_151_1 = Object.Instantiate(arg_148_1.paintGo_)

				var_151_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_151_0)
				var_151_1.name = var_151_0
				var_151_1.transform.parent = arg_148_1.stage_.transform
				var_151_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_148_1.bgs_[var_151_0] = var_151_1
			end

			local var_151_2 = 1.5

			if var_151_2 < arg_148_1.time_ and arg_148_1.time_ <= var_151_2 + arg_151_0 then
				local var_151_3 = manager.ui.mainCamera.transform.localPosition
				local var_151_4 = Vector3.New(0, 0, 10) + Vector3.New(var_151_3.x, var_151_3.y, 0)
				local var_151_5 = arg_148_1.bgs_.D09a

				var_151_5.transform.localPosition = var_151_4
				var_151_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_151_6 = var_151_5:GetComponent("SpriteRenderer")

				if var_151_6 and var_151_6.sprite then
					local var_151_7 = (var_151_5.transform.localPosition - var_151_3).z
					local var_151_8 = manager.ui.mainCameraCom_
					local var_151_9 = 2 * var_151_7 * Mathf.Tan(var_151_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_151_10 = var_151_9 * var_151_8.aspect
					local var_151_11 = var_151_6.sprite.bounds.size.x
					local var_151_12 = var_151_6.sprite.bounds.size.y
					local var_151_13 = var_151_10 / var_151_11
					local var_151_14 = var_151_9 / var_151_12
					local var_151_15 = var_151_14 < var_151_13 and var_151_13 or var_151_14

					var_151_5.transform.localScale = Vector3.New(var_151_15, var_151_15, 0)
				end

				for iter_151_0, iter_151_1 in pairs(arg_148_1.bgs_) do
					if iter_151_0 ~= "D09a" then
						iter_151_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_151_16 = arg_148_1.bgs_.AS0106
			local var_151_17 = 0

			if var_151_17 < arg_148_1.time_ and arg_148_1.time_ <= var_151_17 + arg_151_0 then
				local var_151_18 = var_151_16:GetComponent("SpriteRenderer")

				if var_151_18 then
					arg_148_1.var_.alphaOldValueAS0106 = var_151_18.color.a
					arg_148_1.var_.alphaMatValueAS0106 = var_151_18
				end

				arg_148_1.var_.alphaOldValueAS0106 = 1
			end

			local var_151_19 = 1.5

			if var_151_17 <= arg_148_1.time_ and arg_148_1.time_ < var_151_17 + var_151_19 then
				local var_151_20 = (arg_148_1.time_ - var_151_17) / var_151_19
				local var_151_21 = Mathf.Lerp(arg_148_1.var_.alphaOldValueAS0106, 0, var_151_20)

				if arg_148_1.var_.alphaMatValueAS0106 then
					local var_151_22 = arg_148_1.var_.alphaMatValueAS0106.color

					var_151_22.a = var_151_21
					arg_148_1.var_.alphaMatValueAS0106.color = var_151_22
				end
			end

			if arg_148_1.time_ >= var_151_17 + var_151_19 and arg_148_1.time_ < var_151_17 + var_151_19 + arg_151_0 and arg_148_1.var_.alphaMatValueAS0106 then
				local var_151_23 = arg_148_1.var_.alphaMatValueAS0106
				local var_151_24 = var_151_23.color

				var_151_24.a = 0
				var_151_23.color = var_151_24
			end

			local var_151_25 = arg_148_1.bgs_.D09a
			local var_151_26 = 1.5

			if var_151_26 < arg_148_1.time_ and arg_148_1.time_ <= var_151_26 + arg_151_0 then
				local var_151_27 = var_151_25:GetComponent("SpriteRenderer")

				if var_151_27 then
					arg_148_1.var_.alphaOldValueD09a = var_151_27.color.a
					arg_148_1.var_.alphaMatValueD09a = var_151_27
				end

				arg_148_1.var_.alphaOldValueD09a = 0
			end

			local var_151_28 = 1.5

			if var_151_26 <= arg_148_1.time_ and arg_148_1.time_ < var_151_26 + var_151_28 then
				local var_151_29 = (arg_148_1.time_ - var_151_26) / var_151_28
				local var_151_30 = Mathf.Lerp(arg_148_1.var_.alphaOldValueD09a, 1, var_151_29)

				if arg_148_1.var_.alphaMatValueD09a then
					local var_151_31 = arg_148_1.var_.alphaMatValueD09a.color

					var_151_31.a = var_151_30
					arg_148_1.var_.alphaMatValueD09a.color = var_151_31
				end
			end

			if arg_148_1.time_ >= var_151_26 + var_151_28 and arg_148_1.time_ < var_151_26 + var_151_28 + arg_151_0 and arg_148_1.var_.alphaMatValueD09a then
				local var_151_32 = arg_148_1.var_.alphaMatValueD09a
				local var_151_33 = var_151_32.color

				var_151_33.a = 1
				var_151_32.color = var_151_33
			end

			if arg_148_1.frameCnt_ <= 1 then
				arg_148_1.dialog_:SetActive(false)
			end

			local var_151_34 = 2.125
			local var_151_35 = 0.875

			if var_151_34 < arg_148_1.time_ and arg_148_1.time_ <= var_151_34 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0

				arg_148_1.dialog_:SetActive(true)

				arg_148_1.dialogCg_.alpha = 0

				local var_151_36 = LeanTween.value(arg_148_1.dialog_, 0, 1, 0.3)

				var_151_36:setOnUpdate(LuaHelper.FloatAction(function(arg_152_0)
					arg_148_1.dialogCg_.alpha = arg_152_0
				end))
				var_151_36:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_148_1.dialog_)
					var_151_36:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_148_1.duration_ = arg_148_1.duration_ + 0.3

				SetActive(arg_148_1.leftNameGo_, false)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_148_1.iconTrs_.gameObject, false)
				arg_148_1.callingController_:SetSelectedState("normal")

				local var_151_37 = arg_148_1:GetWordFromCfg(111161036)
				local var_151_38 = arg_148_1:FormatText(var_151_37.content)

				arg_148_1.text_.text = var_151_38

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_39 = 35
				local var_151_40 = utf8.len(var_151_38)
				local var_151_41 = var_151_39 <= 0 and var_151_35 or var_151_35 * (var_151_40 / var_151_39)

				if var_151_41 > 0 and var_151_35 < var_151_41 then
					arg_148_1.talkMaxDuration = var_151_41
					var_151_34 = var_151_34 + 0.3

					if var_151_41 + var_151_34 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_41 + var_151_34
					end
				end

				arg_148_1.text_.text = var_151_38
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)
				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_42 = var_151_34 + 0.3
			local var_151_43 = math.max(var_151_35, arg_148_1.talkMaxDuration)

			if var_151_42 <= arg_148_1.time_ and arg_148_1.time_ < var_151_42 + var_151_43 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - var_151_42) / var_151_43

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= var_151_42 + var_151_43 and arg_148_1.time_ < var_151_42 + var_151_43 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {}

		arg_148_1:InitPlayNodeList()
	end,
	Play111161037 = function(arg_154_0, arg_154_1)
		arg_154_1.time_ = 0
		arg_154_1.frameCnt_ = 0
		arg_154_1.state_ = "playing"
		arg_154_1.curTalkId_ = 111161037
		arg_154_1.duration_ = 5

		SetActive(arg_154_1.tipsGo_, false)

		function arg_154_1.onSingleLineFinish_()
			arg_154_1.onSingleLineUpdate_ = nil
			arg_154_1.onSingleLineFinish_ = nil
			arg_154_1.state_ = "waiting"
		end

		function arg_154_1.playNext_(arg_156_0)
			if arg_156_0 == 1 then
				arg_154_0:Play111161038(arg_154_1)
			end
		end

		function arg_154_1.onSingleLineUpdate_(arg_157_0)
			local var_157_0 = 0
			local var_157_1 = 0.925

			if var_157_0 < arg_154_1.time_ and arg_154_1.time_ <= var_157_0 + arg_157_0 then
				arg_154_1.talkMaxDuration = 0
				arg_154_1.dialogCg_.alpha = 1

				arg_154_1.dialog_:SetActive(true)
				SetActive(arg_154_1.leftNameGo_, false)

				arg_154_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_154_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_154_1:RecordName(arg_154_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_154_1.iconTrs_.gameObject, false)
				arg_154_1.callingController_:SetSelectedState("normal")

				local var_157_2 = arg_154_1:GetWordFromCfg(111161037)
				local var_157_3 = arg_154_1:FormatText(var_157_2.content)

				arg_154_1.text_.text = var_157_3

				LuaForUtil.ClearLinePrefixSymbol(arg_154_1.text_)

				local var_157_4 = 37
				local var_157_5 = utf8.len(var_157_3)
				local var_157_6 = var_157_4 <= 0 and var_157_1 or var_157_1 * (var_157_5 / var_157_4)

				if var_157_6 > 0 and var_157_1 < var_157_6 then
					arg_154_1.talkMaxDuration = var_157_6

					if var_157_6 + var_157_0 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_6 + var_157_0
					end
				end

				arg_154_1.text_.text = var_157_3
				arg_154_1.typewritter.percent = 0

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(false)
				arg_154_1:RecordContent(arg_154_1.text_.text)
			end

			local var_157_7 = math.max(var_157_1, arg_154_1.talkMaxDuration)

			if var_157_0 <= arg_154_1.time_ and arg_154_1.time_ < var_157_0 + var_157_7 then
				arg_154_1.typewritter.percent = (arg_154_1.time_ - var_157_0) / var_157_7

				arg_154_1.typewritter:SetDirty()
			end

			if arg_154_1.time_ >= var_157_0 + var_157_7 and arg_154_1.time_ < var_157_0 + var_157_7 + arg_157_0 then
				arg_154_1.typewritter.percent = 1

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(true)
			end
		end

		arg_154_1.nodeConfigList_ = {}

		arg_154_1:InitPlayNodeList()
	end,
	Play111161038 = function(arg_158_0, arg_158_1)
		arg_158_1.time_ = 0
		arg_158_1.frameCnt_ = 0
		arg_158_1.state_ = "playing"
		arg_158_1.curTalkId_ = 111161038
		arg_158_1.duration_ = 5

		SetActive(arg_158_1.tipsGo_, false)

		function arg_158_1.onSingleLineFinish_()
			arg_158_1.onSingleLineUpdate_ = nil
			arg_158_1.onSingleLineFinish_ = nil
			arg_158_1.state_ = "waiting"
		end

		function arg_158_1.playNext_(arg_160_0)
			if arg_160_0 == 1 then
				arg_158_0:Play111161039(arg_158_1)
			end
		end

		function arg_158_1.onSingleLineUpdate_(arg_161_0)
			local var_161_0 = 0
			local var_161_1 = 1.35

			if var_161_0 < arg_158_1.time_ and arg_158_1.time_ <= var_161_0 + arg_161_0 then
				arg_158_1.talkMaxDuration = 0
				arg_158_1.dialogCg_.alpha = 1

				arg_158_1.dialog_:SetActive(true)
				SetActive(arg_158_1.leftNameGo_, false)

				arg_158_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_158_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_158_1:RecordName(arg_158_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_158_1.iconTrs_.gameObject, false)
				arg_158_1.callingController_:SetSelectedState("normal")

				local var_161_2 = arg_158_1:GetWordFromCfg(111161038)
				local var_161_3 = arg_158_1:FormatText(var_161_2.content)

				arg_158_1.text_.text = var_161_3

				LuaForUtil.ClearLinePrefixSymbol(arg_158_1.text_)

				local var_161_4 = 54
				local var_161_5 = utf8.len(var_161_3)
				local var_161_6 = var_161_4 <= 0 and var_161_1 or var_161_1 * (var_161_5 / var_161_4)

				if var_161_6 > 0 and var_161_1 < var_161_6 then
					arg_158_1.talkMaxDuration = var_161_6

					if var_161_6 + var_161_0 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_6 + var_161_0
					end
				end

				arg_158_1.text_.text = var_161_3
				arg_158_1.typewritter.percent = 0

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(false)
				arg_158_1:RecordContent(arg_158_1.text_.text)
			end

			local var_161_7 = math.max(var_161_1, arg_158_1.talkMaxDuration)

			if var_161_0 <= arg_158_1.time_ and arg_158_1.time_ < var_161_0 + var_161_7 then
				arg_158_1.typewritter.percent = (arg_158_1.time_ - var_161_0) / var_161_7

				arg_158_1.typewritter:SetDirty()
			end

			if arg_158_1.time_ >= var_161_0 + var_161_7 and arg_158_1.time_ < var_161_0 + var_161_7 + arg_161_0 then
				arg_158_1.typewritter.percent = 1

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(true)
			end
		end

		arg_158_1.nodeConfigList_ = {}

		arg_158_1:InitPlayNodeList()
	end,
	Play111161039 = function(arg_162_0, arg_162_1)
		arg_162_1.time_ = 0
		arg_162_1.frameCnt_ = 0
		arg_162_1.state_ = "playing"
		arg_162_1.curTalkId_ = 111161039
		arg_162_1.duration_ = 5

		SetActive(arg_162_1.tipsGo_, false)

		function arg_162_1.onSingleLineFinish_()
			arg_162_1.onSingleLineUpdate_ = nil
			arg_162_1.onSingleLineFinish_ = nil
			arg_162_1.state_ = "waiting"
		end

		function arg_162_1.playNext_(arg_164_0)
			if arg_164_0 == 1 then
				arg_162_0:Play111161040(arg_162_1)
			end
		end

		function arg_162_1.onSingleLineUpdate_(arg_165_0)
			local var_165_0 = 0
			local var_165_1 = 0.25

			if var_165_0 < arg_162_1.time_ and arg_162_1.time_ <= var_165_0 + arg_165_0 then
				arg_162_1.talkMaxDuration = 0
				arg_162_1.dialogCg_.alpha = 1

				arg_162_1.dialog_:SetActive(true)
				SetActive(arg_162_1.leftNameGo_, true)

				local var_165_2 = arg_162_1:FormatText(StoryNameCfg[7].name)

				arg_162_1.leftNameTxt_.text = var_165_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_162_1.leftNameTxt_.transform)

				arg_162_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_162_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_162_1:RecordName(arg_162_1.leftNameTxt_.text)
				SetActive(arg_162_1.iconTrs_.gameObject, true)
				arg_162_1.iconController_:SetSelectedState("hero")

				arg_162_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_162_1.callingController_:SetSelectedState("normal")

				arg_162_1.keyicon_.color = Color.New(1, 1, 1)
				arg_162_1.icon_.color = Color.New(1, 1, 1)

				local var_165_3 = arg_162_1:GetWordFromCfg(111161039)
				local var_165_4 = arg_162_1:FormatText(var_165_3.content)

				arg_162_1.text_.text = var_165_4

				LuaForUtil.ClearLinePrefixSymbol(arg_162_1.text_)

				local var_165_5 = 10
				local var_165_6 = utf8.len(var_165_4)
				local var_165_7 = var_165_5 <= 0 and var_165_1 or var_165_1 * (var_165_6 / var_165_5)

				if var_165_7 > 0 and var_165_1 < var_165_7 then
					arg_162_1.talkMaxDuration = var_165_7

					if var_165_7 + var_165_0 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_7 + var_165_0
					end
				end

				arg_162_1.text_.text = var_165_4
				arg_162_1.typewritter.percent = 0

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(false)
				arg_162_1:RecordContent(arg_162_1.text_.text)
			end

			local var_165_8 = math.max(var_165_1, arg_162_1.talkMaxDuration)

			if var_165_0 <= arg_162_1.time_ and arg_162_1.time_ < var_165_0 + var_165_8 then
				arg_162_1.typewritter.percent = (arg_162_1.time_ - var_165_0) / var_165_8

				arg_162_1.typewritter:SetDirty()
			end

			if arg_162_1.time_ >= var_165_0 + var_165_8 and arg_162_1.time_ < var_165_0 + var_165_8 + arg_165_0 then
				arg_162_1.typewritter.percent = 1

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(true)
			end
		end

		arg_162_1.nodeConfigList_ = {}

		arg_162_1:InitPlayNodeList()
	end,
	Play111161040 = function(arg_166_0, arg_166_1)
		arg_166_1.time_ = 0
		arg_166_1.frameCnt_ = 0
		arg_166_1.state_ = "playing"
		arg_166_1.curTalkId_ = 111161040
		arg_166_1.duration_ = 3.93

		local var_166_0 = {
			ja = 2.9,
			ko = 2.4,
			zh = 3,
			en = 3.933
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
				arg_166_0:Play111161041(arg_166_1)
			end
		end

		function arg_166_1.onSingleLineUpdate_(arg_169_0)
			local var_169_0 = arg_166_1.actors_["1094ui_story"].transform
			local var_169_1 = 0

			if var_169_1 < arg_166_1.time_ and arg_166_1.time_ <= var_169_1 + arg_169_0 then
				arg_166_1.var_.moveOldPos1094ui_story = var_169_0.localPosition
			end

			local var_169_2 = 0.001

			if var_169_1 <= arg_166_1.time_ and arg_166_1.time_ < var_169_1 + var_169_2 then
				local var_169_3 = (arg_166_1.time_ - var_169_1) / var_169_2
				local var_169_4 = Vector3.New(0, -0.84, -6.1)

				var_169_0.localPosition = Vector3.Lerp(arg_166_1.var_.moveOldPos1094ui_story, var_169_4, var_169_3)

				local var_169_5 = manager.ui.mainCamera.transform.position - var_169_0.position

				var_169_0.forward = Vector3.New(var_169_5.x, var_169_5.y, var_169_5.z)

				local var_169_6 = var_169_0.localEulerAngles

				var_169_6.z = 0
				var_169_6.x = 0
				var_169_0.localEulerAngles = var_169_6
			end

			if arg_166_1.time_ >= var_169_1 + var_169_2 and arg_166_1.time_ < var_169_1 + var_169_2 + arg_169_0 then
				var_169_0.localPosition = Vector3.New(0, -0.84, -6.1)

				local var_169_7 = manager.ui.mainCamera.transform.position - var_169_0.position

				var_169_0.forward = Vector3.New(var_169_7.x, var_169_7.y, var_169_7.z)

				local var_169_8 = var_169_0.localEulerAngles

				var_169_8.z = 0
				var_169_8.x = 0
				var_169_0.localEulerAngles = var_169_8
			end

			local var_169_9 = 0

			if var_169_9 < arg_166_1.time_ and arg_166_1.time_ <= var_169_9 + arg_169_0 then
				arg_166_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action4_1")
			end

			local var_169_10 = 0

			if var_169_10 < arg_166_1.time_ and arg_166_1.time_ <= var_169_10 + arg_169_0 then
				arg_166_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_169_11 = arg_166_1.actors_["1094ui_story"]
			local var_169_12 = 0

			if var_169_12 < arg_166_1.time_ and arg_166_1.time_ <= var_169_12 + arg_169_0 and not isNil(var_169_11) and arg_166_1.var_.characterEffect1094ui_story == nil then
				arg_166_1.var_.characterEffect1094ui_story = var_169_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_169_13 = 0.2

			if var_169_12 <= arg_166_1.time_ and arg_166_1.time_ < var_169_12 + var_169_13 and not isNil(var_169_11) then
				local var_169_14 = (arg_166_1.time_ - var_169_12) / var_169_13

				if arg_166_1.var_.characterEffect1094ui_story and not isNil(var_169_11) then
					arg_166_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_166_1.time_ >= var_169_12 + var_169_13 and arg_166_1.time_ < var_169_12 + var_169_13 + arg_169_0 and not isNil(var_169_11) and arg_166_1.var_.characterEffect1094ui_story then
				arg_166_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_169_15 = 0
			local var_169_16 = 0.275

			if var_169_15 < arg_166_1.time_ and arg_166_1.time_ <= var_169_15 + arg_169_0 then
				arg_166_1.talkMaxDuration = 0
				arg_166_1.dialogCg_.alpha = 1

				arg_166_1.dialog_:SetActive(true)
				SetActive(arg_166_1.leftNameGo_, true)

				local var_169_17 = arg_166_1:FormatText(StoryNameCfg[181].name)

				arg_166_1.leftNameTxt_.text = var_169_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_166_1.leftNameTxt_.transform)

				arg_166_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_166_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_166_1:RecordName(arg_166_1.leftNameTxt_.text)
				SetActive(arg_166_1.iconTrs_.gameObject, false)
				arg_166_1.callingController_:SetSelectedState("normal")

				local var_169_18 = arg_166_1:GetWordFromCfg(111161040)
				local var_169_19 = arg_166_1:FormatText(var_169_18.content)

				arg_166_1.text_.text = var_169_19

				LuaForUtil.ClearLinePrefixSymbol(arg_166_1.text_)

				local var_169_20 = 11
				local var_169_21 = utf8.len(var_169_19)
				local var_169_22 = var_169_20 <= 0 and var_169_16 or var_169_16 * (var_169_21 / var_169_20)

				if var_169_22 > 0 and var_169_16 < var_169_22 then
					arg_166_1.talkMaxDuration = var_169_22

					if var_169_22 + var_169_15 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_22 + var_169_15
					end
				end

				arg_166_1.text_.text = var_169_19
				arg_166_1.typewritter.percent = 0

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111161", "111161040", "story_v_out_111161.awb") ~= 0 then
					local var_169_23 = manager.audio:GetVoiceLength("story_v_out_111161", "111161040", "story_v_out_111161.awb") / 1000

					if var_169_23 + var_169_15 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_23 + var_169_15
					end

					if var_169_18.prefab_name ~= "" and arg_166_1.actors_[var_169_18.prefab_name] ~= nil then
						local var_169_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_166_1.actors_[var_169_18.prefab_name].transform, "story_v_out_111161", "111161040", "story_v_out_111161.awb")

						arg_166_1:RecordAudio("111161040", var_169_24)
						arg_166_1:RecordAudio("111161040", var_169_24)
					else
						arg_166_1:AudioAction("play", "voice", "story_v_out_111161", "111161040", "story_v_out_111161.awb")
					end

					arg_166_1:RecordHistoryTalkVoice("story_v_out_111161", "111161040", "story_v_out_111161.awb")
				end

				arg_166_1:RecordContent(arg_166_1.text_.text)
			end

			local var_169_25 = math.max(var_169_16, arg_166_1.talkMaxDuration)

			if var_169_15 <= arg_166_1.time_ and arg_166_1.time_ < var_169_15 + var_169_25 then
				arg_166_1.typewritter.percent = (arg_166_1.time_ - var_169_15) / var_169_25

				arg_166_1.typewritter:SetDirty()
			end

			if arg_166_1.time_ >= var_169_15 + var_169_25 and arg_166_1.time_ < var_169_15 + var_169_25 + arg_169_0 then
				arg_166_1.typewritter.percent = 1

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(true)
			end
		end

		arg_166_1.nodeConfigList_ = {
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

		arg_166_1:InitPlayNodeList()
	end,
	Play111161041 = function(arg_170_0, arg_170_1)
		arg_170_1.time_ = 0
		arg_170_1.frameCnt_ = 0
		arg_170_1.state_ = "playing"
		arg_170_1.curTalkId_ = 111161041
		arg_170_1.duration_ = 4.9

		local var_170_0 = {
			ja = 4.9,
			ko = 2.333,
			zh = 2.9,
			en = 3.633
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
				arg_170_0:Play111161042(arg_170_1)
			end
		end

		function arg_170_1.onSingleLineUpdate_(arg_173_0)
			local var_173_0 = 0

			if var_173_0 < arg_170_1.time_ and arg_170_1.time_ <= var_173_0 + arg_173_0 then
				arg_170_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_173_1 = arg_170_1.actors_["1094ui_story"]
			local var_173_2 = 0

			if var_173_2 < arg_170_1.time_ and arg_170_1.time_ <= var_173_2 + arg_173_0 and not isNil(var_173_1) and arg_170_1.var_.characterEffect1094ui_story == nil then
				arg_170_1.var_.characterEffect1094ui_story = var_173_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_173_3 = 0.2

			if var_173_2 <= arg_170_1.time_ and arg_170_1.time_ < var_173_2 + var_173_3 and not isNil(var_173_1) then
				local var_173_4 = (arg_170_1.time_ - var_173_2) / var_173_3

				if arg_170_1.var_.characterEffect1094ui_story and not isNil(var_173_1) then
					arg_170_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_170_1.time_ >= var_173_2 + var_173_3 and arg_170_1.time_ < var_173_2 + var_173_3 + arg_173_0 and not isNil(var_173_1) and arg_170_1.var_.characterEffect1094ui_story then
				arg_170_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_173_5 = 0
			local var_173_6 = 0.275

			if var_173_5 < arg_170_1.time_ and arg_170_1.time_ <= var_173_5 + arg_173_0 then
				arg_170_1.talkMaxDuration = 0
				arg_170_1.dialogCg_.alpha = 1

				arg_170_1.dialog_:SetActive(true)
				SetActive(arg_170_1.leftNameGo_, true)

				local var_173_7 = arg_170_1:FormatText(StoryNameCfg[181].name)

				arg_170_1.leftNameTxt_.text = var_173_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_170_1.leftNameTxt_.transform)

				arg_170_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_170_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_170_1:RecordName(arg_170_1.leftNameTxt_.text)
				SetActive(arg_170_1.iconTrs_.gameObject, false)
				arg_170_1.callingController_:SetSelectedState("normal")

				local var_173_8 = arg_170_1:GetWordFromCfg(111161041)
				local var_173_9 = arg_170_1:FormatText(var_173_8.content)

				arg_170_1.text_.text = var_173_9

				LuaForUtil.ClearLinePrefixSymbol(arg_170_1.text_)

				local var_173_10 = 11
				local var_173_11 = utf8.len(var_173_9)
				local var_173_12 = var_173_10 <= 0 and var_173_6 or var_173_6 * (var_173_11 / var_173_10)

				if var_173_12 > 0 and var_173_6 < var_173_12 then
					arg_170_1.talkMaxDuration = var_173_12

					if var_173_12 + var_173_5 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_12 + var_173_5
					end
				end

				arg_170_1.text_.text = var_173_9
				arg_170_1.typewritter.percent = 0

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111161", "111161041", "story_v_out_111161.awb") ~= 0 then
					local var_173_13 = manager.audio:GetVoiceLength("story_v_out_111161", "111161041", "story_v_out_111161.awb") / 1000

					if var_173_13 + var_173_5 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_13 + var_173_5
					end

					if var_173_8.prefab_name ~= "" and arg_170_1.actors_[var_173_8.prefab_name] ~= nil then
						local var_173_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_170_1.actors_[var_173_8.prefab_name].transform, "story_v_out_111161", "111161041", "story_v_out_111161.awb")

						arg_170_1:RecordAudio("111161041", var_173_14)
						arg_170_1:RecordAudio("111161041", var_173_14)
					else
						arg_170_1:AudioAction("play", "voice", "story_v_out_111161", "111161041", "story_v_out_111161.awb")
					end

					arg_170_1:RecordHistoryTalkVoice("story_v_out_111161", "111161041", "story_v_out_111161.awb")
				end

				arg_170_1:RecordContent(arg_170_1.text_.text)
			end

			local var_173_15 = math.max(var_173_6, arg_170_1.talkMaxDuration)

			if var_173_5 <= arg_170_1.time_ and arg_170_1.time_ < var_173_5 + var_173_15 then
				arg_170_1.typewritter.percent = (arg_170_1.time_ - var_173_5) / var_173_15

				arg_170_1.typewritter:SetDirty()
			end

			if arg_170_1.time_ >= var_173_5 + var_173_15 and arg_170_1.time_ < var_173_5 + var_173_15 + arg_173_0 then
				arg_170_1.typewritter.percent = 1

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(true)
			end
		end

		arg_170_1.nodeConfigList_ = {}

		arg_170_1:InitPlayNodeList()
	end,
	Play111161042 = function(arg_174_0, arg_174_1)
		arg_174_1.time_ = 0
		arg_174_1.frameCnt_ = 0
		arg_174_1.state_ = "playing"
		arg_174_1.curTalkId_ = 111161042
		arg_174_1.duration_ = 5

		SetActive(arg_174_1.tipsGo_, false)

		function arg_174_1.onSingleLineFinish_()
			arg_174_1.onSingleLineUpdate_ = nil
			arg_174_1.onSingleLineFinish_ = nil
			arg_174_1.state_ = "waiting"
		end

		function arg_174_1.playNext_(arg_176_0)
			if arg_176_0 == 1 then
				arg_174_0:Play111161043(arg_174_1)
			end
		end

		function arg_174_1.onSingleLineUpdate_(arg_177_0)
			local var_177_0 = arg_174_1.actors_["1094ui_story"]
			local var_177_1 = 0

			if var_177_1 < arg_174_1.time_ and arg_174_1.time_ <= var_177_1 + arg_177_0 and not isNil(var_177_0) and arg_174_1.var_.characterEffect1094ui_story == nil then
				arg_174_1.var_.characterEffect1094ui_story = var_177_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_177_2 = 0.2

			if var_177_1 <= arg_174_1.time_ and arg_174_1.time_ < var_177_1 + var_177_2 and not isNil(var_177_0) then
				local var_177_3 = (arg_174_1.time_ - var_177_1) / var_177_2

				if arg_174_1.var_.characterEffect1094ui_story and not isNil(var_177_0) then
					local var_177_4 = Mathf.Lerp(0, 0.5, var_177_3)

					arg_174_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_174_1.var_.characterEffect1094ui_story.fillRatio = var_177_4
				end
			end

			if arg_174_1.time_ >= var_177_1 + var_177_2 and arg_174_1.time_ < var_177_1 + var_177_2 + arg_177_0 and not isNil(var_177_0) and arg_174_1.var_.characterEffect1094ui_story then
				local var_177_5 = 0.5

				arg_174_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_174_1.var_.characterEffect1094ui_story.fillRatio = var_177_5
			end

			local var_177_6 = 0
			local var_177_7 = 0.275

			if var_177_6 < arg_174_1.time_ and arg_174_1.time_ <= var_177_6 + arg_177_0 then
				arg_174_1.talkMaxDuration = 0
				arg_174_1.dialogCg_.alpha = 1

				arg_174_1.dialog_:SetActive(true)
				SetActive(arg_174_1.leftNameGo_, true)

				local var_177_8 = arg_174_1:FormatText(StoryNameCfg[7].name)

				arg_174_1.leftNameTxt_.text = var_177_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_174_1.leftNameTxt_.transform)

				arg_174_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_174_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_174_1:RecordName(arg_174_1.leftNameTxt_.text)
				SetActive(arg_174_1.iconTrs_.gameObject, true)
				arg_174_1.iconController_:SetSelectedState("hero")

				arg_174_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_174_1.callingController_:SetSelectedState("normal")

				arg_174_1.keyicon_.color = Color.New(1, 1, 1)
				arg_174_1.icon_.color = Color.New(1, 1, 1)

				local var_177_9 = arg_174_1:GetWordFromCfg(111161042)
				local var_177_10 = arg_174_1:FormatText(var_177_9.content)

				arg_174_1.text_.text = var_177_10

				LuaForUtil.ClearLinePrefixSymbol(arg_174_1.text_)

				local var_177_11 = 11
				local var_177_12 = utf8.len(var_177_10)
				local var_177_13 = var_177_11 <= 0 and var_177_7 or var_177_7 * (var_177_12 / var_177_11)

				if var_177_13 > 0 and var_177_7 < var_177_13 then
					arg_174_1.talkMaxDuration = var_177_13

					if var_177_13 + var_177_6 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_13 + var_177_6
					end
				end

				arg_174_1.text_.text = var_177_10
				arg_174_1.typewritter.percent = 0

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(false)
				arg_174_1:RecordContent(arg_174_1.text_.text)
			end

			local var_177_14 = math.max(var_177_7, arg_174_1.talkMaxDuration)

			if var_177_6 <= arg_174_1.time_ and arg_174_1.time_ < var_177_6 + var_177_14 then
				arg_174_1.typewritter.percent = (arg_174_1.time_ - var_177_6) / var_177_14

				arg_174_1.typewritter:SetDirty()
			end

			if arg_174_1.time_ >= var_177_6 + var_177_14 and arg_174_1.time_ < var_177_6 + var_177_14 + arg_177_0 then
				arg_174_1.typewritter.percent = 1

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(true)
			end
		end

		arg_174_1.nodeConfigList_ = {}

		arg_174_1:InitPlayNodeList()
	end,
	Play111161043 = function(arg_178_0, arg_178_1)
		arg_178_1.time_ = 0
		arg_178_1.frameCnt_ = 0
		arg_178_1.state_ = "playing"
		arg_178_1.curTalkId_ = 111161043
		arg_178_1.duration_ = 2

		SetActive(arg_178_1.tipsGo_, false)

		function arg_178_1.onSingleLineFinish_()
			arg_178_1.onSingleLineUpdate_ = nil
			arg_178_1.onSingleLineFinish_ = nil
			arg_178_1.state_ = "waiting"
		end

		function arg_178_1.playNext_(arg_180_0)
			if arg_180_0 == 1 then
				arg_178_0:Play111161044(arg_178_1)
			end
		end

		function arg_178_1.onSingleLineUpdate_(arg_181_0)
			local var_181_0 = 0

			if var_181_0 < arg_178_1.time_ and arg_178_1.time_ <= var_181_0 + arg_181_0 then
				arg_178_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			local var_181_1 = arg_178_1.actors_["1094ui_story"]
			local var_181_2 = 0

			if var_181_2 < arg_178_1.time_ and arg_178_1.time_ <= var_181_2 + arg_181_0 and not isNil(var_181_1) and arg_178_1.var_.characterEffect1094ui_story == nil then
				arg_178_1.var_.characterEffect1094ui_story = var_181_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_181_3 = 0.2

			if var_181_2 <= arg_178_1.time_ and arg_178_1.time_ < var_181_2 + var_181_3 and not isNil(var_181_1) then
				local var_181_4 = (arg_178_1.time_ - var_181_2) / var_181_3

				if arg_178_1.var_.characterEffect1094ui_story and not isNil(var_181_1) then
					arg_178_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_178_1.time_ >= var_181_2 + var_181_3 and arg_178_1.time_ < var_181_2 + var_181_3 + arg_181_0 and not isNil(var_181_1) and arg_178_1.var_.characterEffect1094ui_story then
				arg_178_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_181_5 = 0
			local var_181_6 = 0.15

			if var_181_5 < arg_178_1.time_ and arg_178_1.time_ <= var_181_5 + arg_181_0 then
				arg_178_1.talkMaxDuration = 0
				arg_178_1.dialogCg_.alpha = 1

				arg_178_1.dialog_:SetActive(true)
				SetActive(arg_178_1.leftNameGo_, true)

				local var_181_7 = arg_178_1:FormatText(StoryNameCfg[181].name)

				arg_178_1.leftNameTxt_.text = var_181_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_178_1.leftNameTxt_.transform)

				arg_178_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_178_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_178_1:RecordName(arg_178_1.leftNameTxt_.text)
				SetActive(arg_178_1.iconTrs_.gameObject, false)
				arg_178_1.callingController_:SetSelectedState("normal")

				local var_181_8 = arg_178_1:GetWordFromCfg(111161043)
				local var_181_9 = arg_178_1:FormatText(var_181_8.content)

				arg_178_1.text_.text = var_181_9

				LuaForUtil.ClearLinePrefixSymbol(arg_178_1.text_)

				local var_181_10 = 6
				local var_181_11 = utf8.len(var_181_9)
				local var_181_12 = var_181_10 <= 0 and var_181_6 or var_181_6 * (var_181_11 / var_181_10)

				if var_181_12 > 0 and var_181_6 < var_181_12 then
					arg_178_1.talkMaxDuration = var_181_12

					if var_181_12 + var_181_5 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_12 + var_181_5
					end
				end

				arg_178_1.text_.text = var_181_9
				arg_178_1.typewritter.percent = 0

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111161", "111161043", "story_v_out_111161.awb") ~= 0 then
					local var_181_13 = manager.audio:GetVoiceLength("story_v_out_111161", "111161043", "story_v_out_111161.awb") / 1000

					if var_181_13 + var_181_5 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_13 + var_181_5
					end

					if var_181_8.prefab_name ~= "" and arg_178_1.actors_[var_181_8.prefab_name] ~= nil then
						local var_181_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_178_1.actors_[var_181_8.prefab_name].transform, "story_v_out_111161", "111161043", "story_v_out_111161.awb")

						arg_178_1:RecordAudio("111161043", var_181_14)
						arg_178_1:RecordAudio("111161043", var_181_14)
					else
						arg_178_1:AudioAction("play", "voice", "story_v_out_111161", "111161043", "story_v_out_111161.awb")
					end

					arg_178_1:RecordHistoryTalkVoice("story_v_out_111161", "111161043", "story_v_out_111161.awb")
				end

				arg_178_1:RecordContent(arg_178_1.text_.text)
			end

			local var_181_15 = math.max(var_181_6, arg_178_1.talkMaxDuration)

			if var_181_5 <= arg_178_1.time_ and arg_178_1.time_ < var_181_5 + var_181_15 then
				arg_178_1.typewritter.percent = (arg_178_1.time_ - var_181_5) / var_181_15

				arg_178_1.typewritter:SetDirty()
			end

			if arg_178_1.time_ >= var_181_5 + var_181_15 and arg_178_1.time_ < var_181_5 + var_181_15 + arg_181_0 then
				arg_178_1.typewritter.percent = 1

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(true)
			end
		end

		arg_178_1.nodeConfigList_ = {}

		arg_178_1:InitPlayNodeList()
	end,
	Play111161044 = function(arg_182_0, arg_182_1)
		arg_182_1.time_ = 0
		arg_182_1.frameCnt_ = 0
		arg_182_1.state_ = "playing"
		arg_182_1.curTalkId_ = 111161044
		arg_182_1.duration_ = 5

		SetActive(arg_182_1.tipsGo_, false)

		function arg_182_1.onSingleLineFinish_()
			arg_182_1.onSingleLineUpdate_ = nil
			arg_182_1.onSingleLineFinish_ = nil
			arg_182_1.state_ = "waiting"
		end

		function arg_182_1.playNext_(arg_184_0)
			if arg_184_0 == 1 then
				arg_182_0:Play111161045(arg_182_1)
			end
		end

		function arg_182_1.onSingleLineUpdate_(arg_185_0)
			local var_185_0 = arg_182_1.actors_["1094ui_story"]
			local var_185_1 = 0

			if var_185_1 < arg_182_1.time_ and arg_182_1.time_ <= var_185_1 + arg_185_0 and not isNil(var_185_0) and arg_182_1.var_.characterEffect1094ui_story == nil then
				arg_182_1.var_.characterEffect1094ui_story = var_185_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_185_2 = 0.2

			if var_185_1 <= arg_182_1.time_ and arg_182_1.time_ < var_185_1 + var_185_2 and not isNil(var_185_0) then
				local var_185_3 = (arg_182_1.time_ - var_185_1) / var_185_2

				if arg_182_1.var_.characterEffect1094ui_story and not isNil(var_185_0) then
					local var_185_4 = Mathf.Lerp(0, 0.5, var_185_3)

					arg_182_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_182_1.var_.characterEffect1094ui_story.fillRatio = var_185_4
				end
			end

			if arg_182_1.time_ >= var_185_1 + var_185_2 and arg_182_1.time_ < var_185_1 + var_185_2 + arg_185_0 and not isNil(var_185_0) and arg_182_1.var_.characterEffect1094ui_story then
				local var_185_5 = 0.5

				arg_182_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_182_1.var_.characterEffect1094ui_story.fillRatio = var_185_5
			end

			local var_185_6 = 0
			local var_185_7 = 0.7

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

				local var_185_9 = arg_182_1:GetWordFromCfg(111161044)
				local var_185_10 = arg_182_1:FormatText(var_185_9.content)

				arg_182_1.text_.text = var_185_10

				LuaForUtil.ClearLinePrefixSymbol(arg_182_1.text_)

				local var_185_11 = 28
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
	Play111161045 = function(arg_186_0, arg_186_1)
		arg_186_1.time_ = 0
		arg_186_1.frameCnt_ = 0
		arg_186_1.state_ = "playing"
		arg_186_1.curTalkId_ = 111161045
		arg_186_1.duration_ = 7.47

		local var_186_0 = {
			ja = 1.999999999999,
			ko = 6.333,
			zh = 7.466,
			en = 6.833
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
				arg_186_0:Play111161046(arg_186_1)
			end
		end

		function arg_186_1.onSingleLineUpdate_(arg_189_0)
			local var_189_0 = 0

			if var_189_0 < arg_186_1.time_ and arg_186_1.time_ <= var_189_0 + arg_189_0 then
				arg_186_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_189_1 = arg_186_1.actors_["1094ui_story"]
			local var_189_2 = 0

			if var_189_2 < arg_186_1.time_ and arg_186_1.time_ <= var_189_2 + arg_189_0 and not isNil(var_189_1) and arg_186_1.var_.characterEffect1094ui_story == nil then
				arg_186_1.var_.characterEffect1094ui_story = var_189_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_189_3 = 0.2

			if var_189_2 <= arg_186_1.time_ and arg_186_1.time_ < var_189_2 + var_189_3 and not isNil(var_189_1) then
				local var_189_4 = (arg_186_1.time_ - var_189_2) / var_189_3

				if arg_186_1.var_.characterEffect1094ui_story and not isNil(var_189_1) then
					arg_186_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_186_1.time_ >= var_189_2 + var_189_3 and arg_186_1.time_ < var_189_2 + var_189_3 + arg_189_0 and not isNil(var_189_1) and arg_186_1.var_.characterEffect1094ui_story then
				arg_186_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_189_5 = 0
			local var_189_6 = 0.55

			if var_189_5 < arg_186_1.time_ and arg_186_1.time_ <= var_189_5 + arg_189_0 then
				arg_186_1.talkMaxDuration = 0
				arg_186_1.dialogCg_.alpha = 1

				arg_186_1.dialog_:SetActive(true)
				SetActive(arg_186_1.leftNameGo_, true)

				local var_189_7 = arg_186_1:FormatText(StoryNameCfg[181].name)

				arg_186_1.leftNameTxt_.text = var_189_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_186_1.leftNameTxt_.transform)

				arg_186_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_186_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_186_1:RecordName(arg_186_1.leftNameTxt_.text)
				SetActive(arg_186_1.iconTrs_.gameObject, false)
				arg_186_1.callingController_:SetSelectedState("normal")

				local var_189_8 = arg_186_1:GetWordFromCfg(111161045)
				local var_189_9 = arg_186_1:FormatText(var_189_8.content)

				arg_186_1.text_.text = var_189_9

				LuaForUtil.ClearLinePrefixSymbol(arg_186_1.text_)

				local var_189_10 = 22
				local var_189_11 = utf8.len(var_189_9)
				local var_189_12 = var_189_10 <= 0 and var_189_6 or var_189_6 * (var_189_11 / var_189_10)

				if var_189_12 > 0 and var_189_6 < var_189_12 then
					arg_186_1.talkMaxDuration = var_189_12

					if var_189_12 + var_189_5 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_12 + var_189_5
					end
				end

				arg_186_1.text_.text = var_189_9
				arg_186_1.typewritter.percent = 0

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111161", "111161045", "story_v_out_111161.awb") ~= 0 then
					local var_189_13 = manager.audio:GetVoiceLength("story_v_out_111161", "111161045", "story_v_out_111161.awb") / 1000

					if var_189_13 + var_189_5 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_13 + var_189_5
					end

					if var_189_8.prefab_name ~= "" and arg_186_1.actors_[var_189_8.prefab_name] ~= nil then
						local var_189_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_186_1.actors_[var_189_8.prefab_name].transform, "story_v_out_111161", "111161045", "story_v_out_111161.awb")

						arg_186_1:RecordAudio("111161045", var_189_14)
						arg_186_1:RecordAudio("111161045", var_189_14)
					else
						arg_186_1:AudioAction("play", "voice", "story_v_out_111161", "111161045", "story_v_out_111161.awb")
					end

					arg_186_1:RecordHistoryTalkVoice("story_v_out_111161", "111161045", "story_v_out_111161.awb")
				end

				arg_186_1:RecordContent(arg_186_1.text_.text)
			end

			local var_189_15 = math.max(var_189_6, arg_186_1.talkMaxDuration)

			if var_189_5 <= arg_186_1.time_ and arg_186_1.time_ < var_189_5 + var_189_15 then
				arg_186_1.typewritter.percent = (arg_186_1.time_ - var_189_5) / var_189_15

				arg_186_1.typewritter:SetDirty()
			end

			if arg_186_1.time_ >= var_189_5 + var_189_15 and arg_186_1.time_ < var_189_5 + var_189_15 + arg_189_0 then
				arg_186_1.typewritter.percent = 1

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(true)
			end
		end

		arg_186_1.nodeConfigList_ = {}

		arg_186_1:InitPlayNodeList()
	end,
	Play111161046 = function(arg_190_0, arg_190_1)
		arg_190_1.time_ = 0
		arg_190_1.frameCnt_ = 0
		arg_190_1.state_ = "playing"
		arg_190_1.curTalkId_ = 111161046
		arg_190_1.duration_ = 7

		local var_190_0 = {
			ja = 6.766,
			ko = 6.566,
			zh = 7,
			en = 5.133
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
				arg_190_0:Play111161047(arg_190_1)
			end
		end

		function arg_190_1.onSingleLineUpdate_(arg_193_0)
			local var_193_0 = 0

			if var_193_0 < arg_190_1.time_ and arg_190_1.time_ <= var_193_0 + arg_193_0 then
				arg_190_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094actionlink/1094action445")
			end

			local var_193_1 = 0

			if var_193_1 < arg_190_1.time_ and arg_190_1.time_ <= var_193_1 + arg_193_0 then
				arg_190_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_193_2 = arg_190_1.actors_["1094ui_story"]
			local var_193_3 = 0

			if var_193_3 < arg_190_1.time_ and arg_190_1.time_ <= var_193_3 + arg_193_0 and not isNil(var_193_2) and arg_190_1.var_.characterEffect1094ui_story == nil then
				arg_190_1.var_.characterEffect1094ui_story = var_193_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_193_4 = 0.2

			if var_193_3 <= arg_190_1.time_ and arg_190_1.time_ < var_193_3 + var_193_4 and not isNil(var_193_2) then
				local var_193_5 = (arg_190_1.time_ - var_193_3) / var_193_4

				if arg_190_1.var_.characterEffect1094ui_story and not isNil(var_193_2) then
					arg_190_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_190_1.time_ >= var_193_3 + var_193_4 and arg_190_1.time_ < var_193_3 + var_193_4 + arg_193_0 and not isNil(var_193_2) and arg_190_1.var_.characterEffect1094ui_story then
				arg_190_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_193_6 = 0
			local var_193_7 = 0.675

			if var_193_6 < arg_190_1.time_ and arg_190_1.time_ <= var_193_6 + arg_193_0 then
				arg_190_1.talkMaxDuration = 0
				arg_190_1.dialogCg_.alpha = 1

				arg_190_1.dialog_:SetActive(true)
				SetActive(arg_190_1.leftNameGo_, true)

				local var_193_8 = arg_190_1:FormatText(StoryNameCfg[181].name)

				arg_190_1.leftNameTxt_.text = var_193_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_190_1.leftNameTxt_.transform)

				arg_190_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_190_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_190_1:RecordName(arg_190_1.leftNameTxt_.text)
				SetActive(arg_190_1.iconTrs_.gameObject, false)
				arg_190_1.callingController_:SetSelectedState("normal")

				local var_193_9 = arg_190_1:GetWordFromCfg(111161046)
				local var_193_10 = arg_190_1:FormatText(var_193_9.content)

				arg_190_1.text_.text = var_193_10

				LuaForUtil.ClearLinePrefixSymbol(arg_190_1.text_)

				local var_193_11 = 27
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

				if manager.audio:GetVoiceLength("story_v_out_111161", "111161046", "story_v_out_111161.awb") ~= 0 then
					local var_193_14 = manager.audio:GetVoiceLength("story_v_out_111161", "111161046", "story_v_out_111161.awb") / 1000

					if var_193_14 + var_193_6 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_14 + var_193_6
					end

					if var_193_9.prefab_name ~= "" and arg_190_1.actors_[var_193_9.prefab_name] ~= nil then
						local var_193_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_190_1.actors_[var_193_9.prefab_name].transform, "story_v_out_111161", "111161046", "story_v_out_111161.awb")

						arg_190_1:RecordAudio("111161046", var_193_15)
						arg_190_1:RecordAudio("111161046", var_193_15)
					else
						arg_190_1:AudioAction("play", "voice", "story_v_out_111161", "111161046", "story_v_out_111161.awb")
					end

					arg_190_1:RecordHistoryTalkVoice("story_v_out_111161", "111161046", "story_v_out_111161.awb")
				end

				arg_190_1:RecordContent(arg_190_1.text_.text)
			end

			local var_193_16 = math.max(var_193_7, arg_190_1.talkMaxDuration)

			if var_193_6 <= arg_190_1.time_ and arg_190_1.time_ < var_193_6 + var_193_16 then
				arg_190_1.typewritter.percent = (arg_190_1.time_ - var_193_6) / var_193_16

				arg_190_1.typewritter:SetDirty()
			end

			if arg_190_1.time_ >= var_193_6 + var_193_16 and arg_190_1.time_ < var_193_6 + var_193_16 + arg_193_0 then
				arg_190_1.typewritter.percent = 1

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(true)
			end
		end

		arg_190_1.nodeConfigList_ = {}

		arg_190_1:InitPlayNodeList()
	end,
	Play111161047 = function(arg_194_0, arg_194_1)
		arg_194_1.time_ = 0
		arg_194_1.frameCnt_ = 0
		arg_194_1.state_ = "playing"
		arg_194_1.curTalkId_ = 111161047
		arg_194_1.duration_ = 5

		SetActive(arg_194_1.tipsGo_, false)

		function arg_194_1.onSingleLineFinish_()
			arg_194_1.onSingleLineUpdate_ = nil
			arg_194_1.onSingleLineFinish_ = nil
			arg_194_1.state_ = "waiting"
		end

		function arg_194_1.playNext_(arg_196_0)
			if arg_196_0 == 1 then
				arg_194_0:Play111161048(arg_194_1)
			end
		end

		function arg_194_1.onSingleLineUpdate_(arg_197_0)
			local var_197_0 = arg_194_1.actors_["1094ui_story"]
			local var_197_1 = 0

			if var_197_1 < arg_194_1.time_ and arg_194_1.time_ <= var_197_1 + arg_197_0 and not isNil(var_197_0) and arg_194_1.var_.characterEffect1094ui_story == nil then
				arg_194_1.var_.characterEffect1094ui_story = var_197_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_197_2 = 0.2

			if var_197_1 <= arg_194_1.time_ and arg_194_1.time_ < var_197_1 + var_197_2 and not isNil(var_197_0) then
				local var_197_3 = (arg_194_1.time_ - var_197_1) / var_197_2

				if arg_194_1.var_.characterEffect1094ui_story and not isNil(var_197_0) then
					local var_197_4 = Mathf.Lerp(0, 0.5, var_197_3)

					arg_194_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_194_1.var_.characterEffect1094ui_story.fillRatio = var_197_4
				end
			end

			if arg_194_1.time_ >= var_197_1 + var_197_2 and arg_194_1.time_ < var_197_1 + var_197_2 + arg_197_0 and not isNil(var_197_0) and arg_194_1.var_.characterEffect1094ui_story then
				local var_197_5 = 0.5

				arg_194_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_194_1.var_.characterEffect1094ui_story.fillRatio = var_197_5
			end

			local var_197_6 = 0
			local var_197_7 = 0.825

			if var_197_6 < arg_194_1.time_ and arg_194_1.time_ <= var_197_6 + arg_197_0 then
				arg_194_1.talkMaxDuration = 0
				arg_194_1.dialogCg_.alpha = 1

				arg_194_1.dialog_:SetActive(true)
				SetActive(arg_194_1.leftNameGo_, true)

				local var_197_8 = arg_194_1:FormatText(StoryNameCfg[7].name)

				arg_194_1.leftNameTxt_.text = var_197_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_194_1.leftNameTxt_.transform)

				arg_194_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_194_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_194_1:RecordName(arg_194_1.leftNameTxt_.text)
				SetActive(arg_194_1.iconTrs_.gameObject, true)
				arg_194_1.iconController_:SetSelectedState("hero")

				arg_194_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_194_1.callingController_:SetSelectedState("normal")

				arg_194_1.keyicon_.color = Color.New(1, 1, 1)
				arg_194_1.icon_.color = Color.New(1, 1, 1)

				local var_197_9 = arg_194_1:GetWordFromCfg(111161047)
				local var_197_10 = arg_194_1:FormatText(var_197_9.content)

				arg_194_1.text_.text = var_197_10

				LuaForUtil.ClearLinePrefixSymbol(arg_194_1.text_)

				local var_197_11 = 33
				local var_197_12 = utf8.len(var_197_10)
				local var_197_13 = var_197_11 <= 0 and var_197_7 or var_197_7 * (var_197_12 / var_197_11)

				if var_197_13 > 0 and var_197_7 < var_197_13 then
					arg_194_1.talkMaxDuration = var_197_13

					if var_197_13 + var_197_6 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_13 + var_197_6
					end
				end

				arg_194_1.text_.text = var_197_10
				arg_194_1.typewritter.percent = 0

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(false)
				arg_194_1:RecordContent(arg_194_1.text_.text)
			end

			local var_197_14 = math.max(var_197_7, arg_194_1.talkMaxDuration)

			if var_197_6 <= arg_194_1.time_ and arg_194_1.time_ < var_197_6 + var_197_14 then
				arg_194_1.typewritter.percent = (arg_194_1.time_ - var_197_6) / var_197_14

				arg_194_1.typewritter:SetDirty()
			end

			if arg_194_1.time_ >= var_197_6 + var_197_14 and arg_194_1.time_ < var_197_6 + var_197_14 + arg_197_0 then
				arg_194_1.typewritter.percent = 1

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(true)
			end
		end

		arg_194_1.nodeConfigList_ = {}

		arg_194_1:InitPlayNodeList()
	end,
	Play111161048 = function(arg_198_0, arg_198_1)
		arg_198_1.time_ = 0
		arg_198_1.frameCnt_ = 0
		arg_198_1.state_ = "playing"
		arg_198_1.curTalkId_ = 111161048
		arg_198_1.duration_ = 6

		local var_198_0 = {
			ja = 6,
			ko = 3.166,
			zh = 4.133,
			en = 4.766
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
				arg_198_0:Play111161049(arg_198_1)
			end
		end

		function arg_198_1.onSingleLineUpdate_(arg_201_0)
			local var_201_0 = 0

			if var_201_0 < arg_198_1.time_ and arg_198_1.time_ <= var_201_0 + arg_201_0 then
				arg_198_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action5_2")
			end

			local var_201_1 = 0

			if var_201_1 < arg_198_1.time_ and arg_198_1.time_ <= var_201_1 + arg_201_0 then
				arg_198_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_201_2 = arg_198_1.actors_["1094ui_story"]
			local var_201_3 = 0

			if var_201_3 < arg_198_1.time_ and arg_198_1.time_ <= var_201_3 + arg_201_0 and not isNil(var_201_2) and arg_198_1.var_.characterEffect1094ui_story == nil then
				arg_198_1.var_.characterEffect1094ui_story = var_201_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_201_4 = 0.2

			if var_201_3 <= arg_198_1.time_ and arg_198_1.time_ < var_201_3 + var_201_4 and not isNil(var_201_2) then
				local var_201_5 = (arg_198_1.time_ - var_201_3) / var_201_4

				if arg_198_1.var_.characterEffect1094ui_story and not isNil(var_201_2) then
					arg_198_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_198_1.time_ >= var_201_3 + var_201_4 and arg_198_1.time_ < var_201_3 + var_201_4 + arg_201_0 and not isNil(var_201_2) and arg_198_1.var_.characterEffect1094ui_story then
				arg_198_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_201_6 = 0
			local var_201_7 = 0.275

			if var_201_6 < arg_198_1.time_ and arg_198_1.time_ <= var_201_6 + arg_201_0 then
				arg_198_1.talkMaxDuration = 0
				arg_198_1.dialogCg_.alpha = 1

				arg_198_1.dialog_:SetActive(true)
				SetActive(arg_198_1.leftNameGo_, true)

				local var_201_8 = arg_198_1:FormatText(StoryNameCfg[181].name)

				arg_198_1.leftNameTxt_.text = var_201_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_198_1.leftNameTxt_.transform)

				arg_198_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_198_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_198_1:RecordName(arg_198_1.leftNameTxt_.text)
				SetActive(arg_198_1.iconTrs_.gameObject, false)
				arg_198_1.callingController_:SetSelectedState("normal")

				local var_201_9 = arg_198_1:GetWordFromCfg(111161048)
				local var_201_10 = arg_198_1:FormatText(var_201_9.content)

				arg_198_1.text_.text = var_201_10

				LuaForUtil.ClearLinePrefixSymbol(arg_198_1.text_)

				local var_201_11 = 11
				local var_201_12 = utf8.len(var_201_10)
				local var_201_13 = var_201_11 <= 0 and var_201_7 or var_201_7 * (var_201_12 / var_201_11)

				if var_201_13 > 0 and var_201_7 < var_201_13 then
					arg_198_1.talkMaxDuration = var_201_13

					if var_201_13 + var_201_6 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_13 + var_201_6
					end
				end

				arg_198_1.text_.text = var_201_10
				arg_198_1.typewritter.percent = 0

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111161", "111161048", "story_v_out_111161.awb") ~= 0 then
					local var_201_14 = manager.audio:GetVoiceLength("story_v_out_111161", "111161048", "story_v_out_111161.awb") / 1000

					if var_201_14 + var_201_6 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_14 + var_201_6
					end

					if var_201_9.prefab_name ~= "" and arg_198_1.actors_[var_201_9.prefab_name] ~= nil then
						local var_201_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_198_1.actors_[var_201_9.prefab_name].transform, "story_v_out_111161", "111161048", "story_v_out_111161.awb")

						arg_198_1:RecordAudio("111161048", var_201_15)
						arg_198_1:RecordAudio("111161048", var_201_15)
					else
						arg_198_1:AudioAction("play", "voice", "story_v_out_111161", "111161048", "story_v_out_111161.awb")
					end

					arg_198_1:RecordHistoryTalkVoice("story_v_out_111161", "111161048", "story_v_out_111161.awb")
				end

				arg_198_1:RecordContent(arg_198_1.text_.text)
			end

			local var_201_16 = math.max(var_201_7, arg_198_1.talkMaxDuration)

			if var_201_6 <= arg_198_1.time_ and arg_198_1.time_ < var_201_6 + var_201_16 then
				arg_198_1.typewritter.percent = (arg_198_1.time_ - var_201_6) / var_201_16

				arg_198_1.typewritter:SetDirty()
			end

			if arg_198_1.time_ >= var_201_6 + var_201_16 and arg_198_1.time_ < var_201_6 + var_201_16 + arg_201_0 then
				arg_198_1.typewritter.percent = 1

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(true)
			end
		end

		arg_198_1.nodeConfigList_ = {}

		arg_198_1:InitPlayNodeList()
	end,
	Play111161049 = function(arg_202_0, arg_202_1)
		arg_202_1.time_ = 0
		arg_202_1.frameCnt_ = 0
		arg_202_1.state_ = "playing"
		arg_202_1.curTalkId_ = 111161049
		arg_202_1.duration_ = 5

		SetActive(arg_202_1.tipsGo_, false)

		function arg_202_1.onSingleLineFinish_()
			arg_202_1.onSingleLineUpdate_ = nil
			arg_202_1.onSingleLineFinish_ = nil
			arg_202_1.state_ = "waiting"
		end

		function arg_202_1.playNext_(arg_204_0)
			if arg_204_0 == 1 then
				arg_202_0:Play111161050(arg_202_1)
			end
		end

		function arg_202_1.onSingleLineUpdate_(arg_205_0)
			local var_205_0 = arg_202_1.actors_["1094ui_story"]
			local var_205_1 = 0

			if var_205_1 < arg_202_1.time_ and arg_202_1.time_ <= var_205_1 + arg_205_0 and not isNil(var_205_0) and arg_202_1.var_.characterEffect1094ui_story == nil then
				arg_202_1.var_.characterEffect1094ui_story = var_205_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_205_2 = 0.2

			if var_205_1 <= arg_202_1.time_ and arg_202_1.time_ < var_205_1 + var_205_2 and not isNil(var_205_0) then
				local var_205_3 = (arg_202_1.time_ - var_205_1) / var_205_2

				if arg_202_1.var_.characterEffect1094ui_story and not isNil(var_205_0) then
					local var_205_4 = Mathf.Lerp(0, 0.5, var_205_3)

					arg_202_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_202_1.var_.characterEffect1094ui_story.fillRatio = var_205_4
				end
			end

			if arg_202_1.time_ >= var_205_1 + var_205_2 and arg_202_1.time_ < var_205_1 + var_205_2 + arg_205_0 and not isNil(var_205_0) and arg_202_1.var_.characterEffect1094ui_story then
				local var_205_5 = 0.5

				arg_202_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_202_1.var_.characterEffect1094ui_story.fillRatio = var_205_5
			end

			local var_205_6 = 0
			local var_205_7 = 0.525

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

				local var_205_9 = arg_202_1:GetWordFromCfg(111161049)
				local var_205_10 = arg_202_1:FormatText(var_205_9.content)

				arg_202_1.text_.text = var_205_10

				LuaForUtil.ClearLinePrefixSymbol(arg_202_1.text_)

				local var_205_11 = 21
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
	Play111161050 = function(arg_206_0, arg_206_1)
		arg_206_1.time_ = 0
		arg_206_1.frameCnt_ = 0
		arg_206_1.state_ = "playing"
		arg_206_1.curTalkId_ = 111161050
		arg_206_1.duration_ = 5.13

		local var_206_0 = {
			ja = 3.4,
			ko = 4.333,
			zh = 5.133,
			en = 5.066
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
				arg_206_0:Play111161051(arg_206_1)
			end
		end

		function arg_206_1.onSingleLineUpdate_(arg_209_0)
			local var_209_0 = 0

			if var_209_0 < arg_206_1.time_ and arg_206_1.time_ <= var_209_0 + arg_209_0 then
				arg_206_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_209_1 = arg_206_1.actors_["1094ui_story"]
			local var_209_2 = 0

			if var_209_2 < arg_206_1.time_ and arg_206_1.time_ <= var_209_2 + arg_209_0 and not isNil(var_209_1) and arg_206_1.var_.characterEffect1094ui_story == nil then
				arg_206_1.var_.characterEffect1094ui_story = var_209_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_209_3 = 0.2

			if var_209_2 <= arg_206_1.time_ and arg_206_1.time_ < var_209_2 + var_209_3 and not isNil(var_209_1) then
				local var_209_4 = (arg_206_1.time_ - var_209_2) / var_209_3

				if arg_206_1.var_.characterEffect1094ui_story and not isNil(var_209_1) then
					arg_206_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_206_1.time_ >= var_209_2 + var_209_3 and arg_206_1.time_ < var_209_2 + var_209_3 + arg_209_0 and not isNil(var_209_1) and arg_206_1.var_.characterEffect1094ui_story then
				arg_206_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_209_5 = 0
			local var_209_6 = 0.5

			if var_209_5 < arg_206_1.time_ and arg_206_1.time_ <= var_209_5 + arg_209_0 then
				arg_206_1.talkMaxDuration = 0
				arg_206_1.dialogCg_.alpha = 1

				arg_206_1.dialog_:SetActive(true)
				SetActive(arg_206_1.leftNameGo_, true)

				local var_209_7 = arg_206_1:FormatText(StoryNameCfg[181].name)

				arg_206_1.leftNameTxt_.text = var_209_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_206_1.leftNameTxt_.transform)

				arg_206_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_206_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_206_1:RecordName(arg_206_1.leftNameTxt_.text)
				SetActive(arg_206_1.iconTrs_.gameObject, false)
				arg_206_1.callingController_:SetSelectedState("normal")

				local var_209_8 = arg_206_1:GetWordFromCfg(111161050)
				local var_209_9 = arg_206_1:FormatText(var_209_8.content)

				arg_206_1.text_.text = var_209_9

				LuaForUtil.ClearLinePrefixSymbol(arg_206_1.text_)

				local var_209_10 = 20
				local var_209_11 = utf8.len(var_209_9)
				local var_209_12 = var_209_10 <= 0 and var_209_6 or var_209_6 * (var_209_11 / var_209_10)

				if var_209_12 > 0 and var_209_6 < var_209_12 then
					arg_206_1.talkMaxDuration = var_209_12

					if var_209_12 + var_209_5 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_12 + var_209_5
					end
				end

				arg_206_1.text_.text = var_209_9
				arg_206_1.typewritter.percent = 0

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111161", "111161050", "story_v_out_111161.awb") ~= 0 then
					local var_209_13 = manager.audio:GetVoiceLength("story_v_out_111161", "111161050", "story_v_out_111161.awb") / 1000

					if var_209_13 + var_209_5 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_13 + var_209_5
					end

					if var_209_8.prefab_name ~= "" and arg_206_1.actors_[var_209_8.prefab_name] ~= nil then
						local var_209_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_206_1.actors_[var_209_8.prefab_name].transform, "story_v_out_111161", "111161050", "story_v_out_111161.awb")

						arg_206_1:RecordAudio("111161050", var_209_14)
						arg_206_1:RecordAudio("111161050", var_209_14)
					else
						arg_206_1:AudioAction("play", "voice", "story_v_out_111161", "111161050", "story_v_out_111161.awb")
					end

					arg_206_1:RecordHistoryTalkVoice("story_v_out_111161", "111161050", "story_v_out_111161.awb")
				end

				arg_206_1:RecordContent(arg_206_1.text_.text)
			end

			local var_209_15 = math.max(var_209_6, arg_206_1.talkMaxDuration)

			if var_209_5 <= arg_206_1.time_ and arg_206_1.time_ < var_209_5 + var_209_15 then
				arg_206_1.typewritter.percent = (arg_206_1.time_ - var_209_5) / var_209_15

				arg_206_1.typewritter:SetDirty()
			end

			if arg_206_1.time_ >= var_209_5 + var_209_15 and arg_206_1.time_ < var_209_5 + var_209_15 + arg_209_0 then
				arg_206_1.typewritter.percent = 1

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(true)
			end
		end

		arg_206_1.nodeConfigList_ = {}

		arg_206_1:InitPlayNodeList()
	end,
	Play111161051 = function(arg_210_0, arg_210_1)
		arg_210_1.time_ = 0
		arg_210_1.frameCnt_ = 0
		arg_210_1.state_ = "playing"
		arg_210_1.curTalkId_ = 111161051
		arg_210_1.duration_ = 8.37

		local var_210_0 = {
			ja = 6.2,
			ko = 7.233,
			zh = 7.9,
			en = 8.366
		}
		local var_210_1 = manager.audio:GetLocalizationFlag()

		if var_210_0[var_210_1] ~= nil then
			arg_210_1.duration_ = var_210_0[var_210_1]
		end

		SetActive(arg_210_1.tipsGo_, false)

		function arg_210_1.onSingleLineFinish_()
			arg_210_1.onSingleLineUpdate_ = nil
			arg_210_1.onSingleLineFinish_ = nil
			arg_210_1.state_ = "waiting"
		end

		function arg_210_1.playNext_(arg_212_0)
			if arg_212_0 == 1 then
				arg_210_0:Play111161052(arg_210_1)
			end
		end

		function arg_210_1.onSingleLineUpdate_(arg_213_0)
			local var_213_0 = 0

			if var_213_0 < arg_210_1.time_ and arg_210_1.time_ <= var_213_0 + arg_213_0 then
				arg_210_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_213_1 = arg_210_1.actors_["1094ui_story"]
			local var_213_2 = 0

			if var_213_2 < arg_210_1.time_ and arg_210_1.time_ <= var_213_2 + arg_213_0 and not isNil(var_213_1) and arg_210_1.var_.characterEffect1094ui_story == nil then
				arg_210_1.var_.characterEffect1094ui_story = var_213_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_213_3 = 0.2

			if var_213_2 <= arg_210_1.time_ and arg_210_1.time_ < var_213_2 + var_213_3 and not isNil(var_213_1) then
				local var_213_4 = (arg_210_1.time_ - var_213_2) / var_213_3

				if arg_210_1.var_.characterEffect1094ui_story and not isNil(var_213_1) then
					arg_210_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_210_1.time_ >= var_213_2 + var_213_3 and arg_210_1.time_ < var_213_2 + var_213_3 + arg_213_0 and not isNil(var_213_1) and arg_210_1.var_.characterEffect1094ui_story then
				arg_210_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_213_5 = 0

			if var_213_5 < arg_210_1.time_ and arg_210_1.time_ <= var_213_5 + arg_213_0 then
				arg_210_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action4_1")
			end

			local var_213_6 = 0
			local var_213_7 = 0.875

			if var_213_6 < arg_210_1.time_ and arg_210_1.time_ <= var_213_6 + arg_213_0 then
				arg_210_1.talkMaxDuration = 0
				arg_210_1.dialogCg_.alpha = 1

				arg_210_1.dialog_:SetActive(true)
				SetActive(arg_210_1.leftNameGo_, true)

				local var_213_8 = arg_210_1:FormatText(StoryNameCfg[181].name)

				arg_210_1.leftNameTxt_.text = var_213_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_210_1.leftNameTxt_.transform)

				arg_210_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_210_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_210_1:RecordName(arg_210_1.leftNameTxt_.text)
				SetActive(arg_210_1.iconTrs_.gameObject, false)
				arg_210_1.callingController_:SetSelectedState("normal")

				local var_213_9 = arg_210_1:GetWordFromCfg(111161051)
				local var_213_10 = arg_210_1:FormatText(var_213_9.content)

				arg_210_1.text_.text = var_213_10

				LuaForUtil.ClearLinePrefixSymbol(arg_210_1.text_)

				local var_213_11 = 35
				local var_213_12 = utf8.len(var_213_10)
				local var_213_13 = var_213_11 <= 0 and var_213_7 or var_213_7 * (var_213_12 / var_213_11)

				if var_213_13 > 0 and var_213_7 < var_213_13 then
					arg_210_1.talkMaxDuration = var_213_13

					if var_213_13 + var_213_6 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_13 + var_213_6
					end
				end

				arg_210_1.text_.text = var_213_10
				arg_210_1.typewritter.percent = 0

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111161", "111161051", "story_v_out_111161.awb") ~= 0 then
					local var_213_14 = manager.audio:GetVoiceLength("story_v_out_111161", "111161051", "story_v_out_111161.awb") / 1000

					if var_213_14 + var_213_6 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_14 + var_213_6
					end

					if var_213_9.prefab_name ~= "" and arg_210_1.actors_[var_213_9.prefab_name] ~= nil then
						local var_213_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_210_1.actors_[var_213_9.prefab_name].transform, "story_v_out_111161", "111161051", "story_v_out_111161.awb")

						arg_210_1:RecordAudio("111161051", var_213_15)
						arg_210_1:RecordAudio("111161051", var_213_15)
					else
						arg_210_1:AudioAction("play", "voice", "story_v_out_111161", "111161051", "story_v_out_111161.awb")
					end

					arg_210_1:RecordHistoryTalkVoice("story_v_out_111161", "111161051", "story_v_out_111161.awb")
				end

				arg_210_1:RecordContent(arg_210_1.text_.text)
			end

			local var_213_16 = math.max(var_213_7, arg_210_1.talkMaxDuration)

			if var_213_6 <= arg_210_1.time_ and arg_210_1.time_ < var_213_6 + var_213_16 then
				arg_210_1.typewritter.percent = (arg_210_1.time_ - var_213_6) / var_213_16

				arg_210_1.typewritter:SetDirty()
			end

			if arg_210_1.time_ >= var_213_6 + var_213_16 and arg_210_1.time_ < var_213_6 + var_213_16 + arg_213_0 then
				arg_210_1.typewritter.percent = 1

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(true)
			end
		end

		arg_210_1.nodeConfigList_ = {}

		arg_210_1:InitPlayNodeList()
	end,
	Play111161052 = function(arg_214_0, arg_214_1)
		arg_214_1.time_ = 0
		arg_214_1.frameCnt_ = 0
		arg_214_1.state_ = "playing"
		arg_214_1.curTalkId_ = 111161052
		arg_214_1.duration_ = 5

		SetActive(arg_214_1.tipsGo_, false)

		function arg_214_1.onSingleLineFinish_()
			arg_214_1.onSingleLineUpdate_ = nil
			arg_214_1.onSingleLineFinish_ = nil
			arg_214_1.state_ = "waiting"
		end

		function arg_214_1.playNext_(arg_216_0)
			if arg_216_0 == 1 then
				arg_214_0:Play111161053(arg_214_1)
			end
		end

		function arg_214_1.onSingleLineUpdate_(arg_217_0)
			local var_217_0 = arg_214_1.actors_["1094ui_story"]
			local var_217_1 = 0

			if var_217_1 < arg_214_1.time_ and arg_214_1.time_ <= var_217_1 + arg_217_0 and not isNil(var_217_0) and arg_214_1.var_.characterEffect1094ui_story == nil then
				arg_214_1.var_.characterEffect1094ui_story = var_217_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_217_2 = 0.2

			if var_217_1 <= arg_214_1.time_ and arg_214_1.time_ < var_217_1 + var_217_2 and not isNil(var_217_0) then
				local var_217_3 = (arg_214_1.time_ - var_217_1) / var_217_2

				if arg_214_1.var_.characterEffect1094ui_story and not isNil(var_217_0) then
					local var_217_4 = Mathf.Lerp(0, 0.5, var_217_3)

					arg_214_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_214_1.var_.characterEffect1094ui_story.fillRatio = var_217_4
				end
			end

			if arg_214_1.time_ >= var_217_1 + var_217_2 and arg_214_1.time_ < var_217_1 + var_217_2 + arg_217_0 and not isNil(var_217_0) and arg_214_1.var_.characterEffect1094ui_story then
				local var_217_5 = 0.5

				arg_214_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_214_1.var_.characterEffect1094ui_story.fillRatio = var_217_5
			end

			local var_217_6 = 0
			local var_217_7 = 1.1

			if var_217_6 < arg_214_1.time_ and arg_214_1.time_ <= var_217_6 + arg_217_0 then
				arg_214_1.talkMaxDuration = 0
				arg_214_1.dialogCg_.alpha = 1

				arg_214_1.dialog_:SetActive(true)
				SetActive(arg_214_1.leftNameGo_, true)

				local var_217_8 = arg_214_1:FormatText(StoryNameCfg[7].name)

				arg_214_1.leftNameTxt_.text = var_217_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_214_1.leftNameTxt_.transform)

				arg_214_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_214_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_214_1:RecordName(arg_214_1.leftNameTxt_.text)
				SetActive(arg_214_1.iconTrs_.gameObject, true)
				arg_214_1.iconController_:SetSelectedState("hero")

				arg_214_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_214_1.callingController_:SetSelectedState("normal")

				arg_214_1.keyicon_.color = Color.New(1, 1, 1)
				arg_214_1.icon_.color = Color.New(1, 1, 1)

				local var_217_9 = arg_214_1:GetWordFromCfg(111161052)
				local var_217_10 = arg_214_1:FormatText(var_217_9.content)

				arg_214_1.text_.text = var_217_10

				LuaForUtil.ClearLinePrefixSymbol(arg_214_1.text_)

				local var_217_11 = 44
				local var_217_12 = utf8.len(var_217_10)
				local var_217_13 = var_217_11 <= 0 and var_217_7 or var_217_7 * (var_217_12 / var_217_11)

				if var_217_13 > 0 and var_217_7 < var_217_13 then
					arg_214_1.talkMaxDuration = var_217_13

					if var_217_13 + var_217_6 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_13 + var_217_6
					end
				end

				arg_214_1.text_.text = var_217_10
				arg_214_1.typewritter.percent = 0

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(false)
				arg_214_1:RecordContent(arg_214_1.text_.text)
			end

			local var_217_14 = math.max(var_217_7, arg_214_1.talkMaxDuration)

			if var_217_6 <= arg_214_1.time_ and arg_214_1.time_ < var_217_6 + var_217_14 then
				arg_214_1.typewritter.percent = (arg_214_1.time_ - var_217_6) / var_217_14

				arg_214_1.typewritter:SetDirty()
			end

			if arg_214_1.time_ >= var_217_6 + var_217_14 and arg_214_1.time_ < var_217_6 + var_217_14 + arg_217_0 then
				arg_214_1.typewritter.percent = 1

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(true)
			end
		end

		arg_214_1.nodeConfigList_ = {}

		arg_214_1:InitPlayNodeList()
	end,
	Play111161053 = function(arg_218_0, arg_218_1)
		arg_218_1.time_ = 0
		arg_218_1.frameCnt_ = 0
		arg_218_1.state_ = "playing"
		arg_218_1.curTalkId_ = 111161053
		arg_218_1.duration_ = 5

		SetActive(arg_218_1.tipsGo_, false)

		function arg_218_1.onSingleLineFinish_()
			arg_218_1.onSingleLineUpdate_ = nil
			arg_218_1.onSingleLineFinish_ = nil
			arg_218_1.state_ = "waiting"
		end

		function arg_218_1.playNext_(arg_220_0)
			if arg_220_0 == 1 then
				arg_218_0:Play111161054(arg_218_1)
			end
		end

		function arg_218_1.onSingleLineUpdate_(arg_221_0)
			local var_221_0 = 0
			local var_221_1 = 1.125

			if var_221_0 < arg_218_1.time_ and arg_218_1.time_ <= var_221_0 + arg_221_0 then
				arg_218_1.talkMaxDuration = 0
				arg_218_1.dialogCg_.alpha = 1

				arg_218_1.dialog_:SetActive(true)
				SetActive(arg_218_1.leftNameGo_, true)

				local var_221_2 = arg_218_1:FormatText(StoryNameCfg[7].name)

				arg_218_1.leftNameTxt_.text = var_221_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_218_1.leftNameTxt_.transform)

				arg_218_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_218_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_218_1:RecordName(arg_218_1.leftNameTxt_.text)
				SetActive(arg_218_1.iconTrs_.gameObject, true)
				arg_218_1.iconController_:SetSelectedState("hero")

				arg_218_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_218_1.callingController_:SetSelectedState("normal")

				arg_218_1.keyicon_.color = Color.New(1, 1, 1)
				arg_218_1.icon_.color = Color.New(1, 1, 1)

				local var_221_3 = arg_218_1:GetWordFromCfg(111161053)
				local var_221_4 = arg_218_1:FormatText(var_221_3.content)

				arg_218_1.text_.text = var_221_4

				LuaForUtil.ClearLinePrefixSymbol(arg_218_1.text_)

				local var_221_5 = 45
				local var_221_6 = utf8.len(var_221_4)
				local var_221_7 = var_221_5 <= 0 and var_221_1 or var_221_1 * (var_221_6 / var_221_5)

				if var_221_7 > 0 and var_221_1 < var_221_7 then
					arg_218_1.talkMaxDuration = var_221_7

					if var_221_7 + var_221_0 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_7 + var_221_0
					end
				end

				arg_218_1.text_.text = var_221_4
				arg_218_1.typewritter.percent = 0

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(false)
				arg_218_1:RecordContent(arg_218_1.text_.text)
			end

			local var_221_8 = math.max(var_221_1, arg_218_1.talkMaxDuration)

			if var_221_0 <= arg_218_1.time_ and arg_218_1.time_ < var_221_0 + var_221_8 then
				arg_218_1.typewritter.percent = (arg_218_1.time_ - var_221_0) / var_221_8

				arg_218_1.typewritter:SetDirty()
			end

			if arg_218_1.time_ >= var_221_0 + var_221_8 and arg_218_1.time_ < var_221_0 + var_221_8 + arg_221_0 then
				arg_218_1.typewritter.percent = 1

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(true)
			end
		end

		arg_218_1.nodeConfigList_ = {}

		arg_218_1:InitPlayNodeList()
	end,
	Play111161054 = function(arg_222_0, arg_222_1)
		arg_222_1.time_ = 0
		arg_222_1.frameCnt_ = 0
		arg_222_1.state_ = "playing"
		arg_222_1.curTalkId_ = 111161054
		arg_222_1.duration_ = 5

		SetActive(arg_222_1.tipsGo_, false)

		function arg_222_1.onSingleLineFinish_()
			arg_222_1.onSingleLineUpdate_ = nil
			arg_222_1.onSingleLineFinish_ = nil
			arg_222_1.state_ = "waiting"
		end

		function arg_222_1.playNext_(arg_224_0)
			if arg_224_0 == 1 then
				arg_222_0:Play111161055(arg_222_1)
			end
		end

		function arg_222_1.onSingleLineUpdate_(arg_225_0)
			local var_225_0 = 0
			local var_225_1 = 0.1

			if var_225_0 < arg_222_1.time_ and arg_222_1.time_ <= var_225_0 + arg_225_0 then
				arg_222_1.talkMaxDuration = 0
				arg_222_1.dialogCg_.alpha = 1

				arg_222_1.dialog_:SetActive(true)
				SetActive(arg_222_1.leftNameGo_, true)

				local var_225_2 = arg_222_1:FormatText(StoryNameCfg[7].name)

				arg_222_1.leftNameTxt_.text = var_225_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_222_1.leftNameTxt_.transform)

				arg_222_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_222_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_222_1:RecordName(arg_222_1.leftNameTxt_.text)
				SetActive(arg_222_1.iconTrs_.gameObject, true)
				arg_222_1.iconController_:SetSelectedState("hero")

				arg_222_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_222_1.callingController_:SetSelectedState("normal")

				arg_222_1.keyicon_.color = Color.New(1, 1, 1)
				arg_222_1.icon_.color = Color.New(1, 1, 1)

				local var_225_3 = arg_222_1:GetWordFromCfg(111161054)
				local var_225_4 = arg_222_1:FormatText(var_225_3.content)

				arg_222_1.text_.text = var_225_4

				LuaForUtil.ClearLinePrefixSymbol(arg_222_1.text_)

				local var_225_5 = 4
				local var_225_6 = utf8.len(var_225_4)
				local var_225_7 = var_225_5 <= 0 and var_225_1 or var_225_1 * (var_225_6 / var_225_5)

				if var_225_7 > 0 and var_225_1 < var_225_7 then
					arg_222_1.talkMaxDuration = var_225_7

					if var_225_7 + var_225_0 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_7 + var_225_0
					end
				end

				arg_222_1.text_.text = var_225_4
				arg_222_1.typewritter.percent = 0

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(false)
				arg_222_1:RecordContent(arg_222_1.text_.text)
			end

			local var_225_8 = math.max(var_225_1, arg_222_1.talkMaxDuration)

			if var_225_0 <= arg_222_1.time_ and arg_222_1.time_ < var_225_0 + var_225_8 then
				arg_222_1.typewritter.percent = (arg_222_1.time_ - var_225_0) / var_225_8

				arg_222_1.typewritter:SetDirty()
			end

			if arg_222_1.time_ >= var_225_0 + var_225_8 and arg_222_1.time_ < var_225_0 + var_225_8 + arg_225_0 then
				arg_222_1.typewritter.percent = 1

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(true)
			end
		end

		arg_222_1.nodeConfigList_ = {}

		arg_222_1:InitPlayNodeList()
	end,
	Play111161055 = function(arg_226_0, arg_226_1)
		arg_226_1.time_ = 0
		arg_226_1.frameCnt_ = 0
		arg_226_1.state_ = "playing"
		arg_226_1.curTalkId_ = 111161055
		arg_226_1.duration_ = 7.4

		local var_226_0 = {
			ja = 7.4,
			ko = 2.766,
			zh = 4.266,
			en = 3.266
		}
		local var_226_1 = manager.audio:GetLocalizationFlag()

		if var_226_0[var_226_1] ~= nil then
			arg_226_1.duration_ = var_226_0[var_226_1]
		end

		SetActive(arg_226_1.tipsGo_, false)

		function arg_226_1.onSingleLineFinish_()
			arg_226_1.onSingleLineUpdate_ = nil
			arg_226_1.onSingleLineFinish_ = nil
			arg_226_1.state_ = "waiting"
		end

		function arg_226_1.playNext_(arg_228_0)
			if arg_228_0 == 1 then
				arg_226_0:Play111161056(arg_226_1)
			end
		end

		function arg_226_1.onSingleLineUpdate_(arg_229_0)
			local var_229_0 = 0

			if var_229_0 < arg_226_1.time_ and arg_226_1.time_ <= var_229_0 + arg_229_0 then
				arg_226_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_229_1 = arg_226_1.actors_["1094ui_story"]
			local var_229_2 = 0

			if var_229_2 < arg_226_1.time_ and arg_226_1.time_ <= var_229_2 + arg_229_0 and not isNil(var_229_1) and arg_226_1.var_.characterEffect1094ui_story == nil then
				arg_226_1.var_.characterEffect1094ui_story = var_229_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_229_3 = 0.2

			if var_229_2 <= arg_226_1.time_ and arg_226_1.time_ < var_229_2 + var_229_3 and not isNil(var_229_1) then
				local var_229_4 = (arg_226_1.time_ - var_229_2) / var_229_3

				if arg_226_1.var_.characterEffect1094ui_story and not isNil(var_229_1) then
					arg_226_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_226_1.time_ >= var_229_2 + var_229_3 and arg_226_1.time_ < var_229_2 + var_229_3 + arg_229_0 and not isNil(var_229_1) and arg_226_1.var_.characterEffect1094ui_story then
				arg_226_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_229_5 = 0

			if var_229_5 < arg_226_1.time_ and arg_226_1.time_ <= var_229_5 + arg_229_0 then
				arg_226_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action4_2")
			end

			local var_229_6 = 0
			local var_229_7 = 0.35

			if var_229_6 < arg_226_1.time_ and arg_226_1.time_ <= var_229_6 + arg_229_0 then
				arg_226_1.talkMaxDuration = 0
				arg_226_1.dialogCg_.alpha = 1

				arg_226_1.dialog_:SetActive(true)
				SetActive(arg_226_1.leftNameGo_, true)

				local var_229_8 = arg_226_1:FormatText(StoryNameCfg[181].name)

				arg_226_1.leftNameTxt_.text = var_229_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_226_1.leftNameTxt_.transform)

				arg_226_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_226_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_226_1:RecordName(arg_226_1.leftNameTxt_.text)
				SetActive(arg_226_1.iconTrs_.gameObject, false)
				arg_226_1.callingController_:SetSelectedState("normal")

				local var_229_9 = arg_226_1:GetWordFromCfg(111161055)
				local var_229_10 = arg_226_1:FormatText(var_229_9.content)

				arg_226_1.text_.text = var_229_10

				LuaForUtil.ClearLinePrefixSymbol(arg_226_1.text_)

				local var_229_11 = 14
				local var_229_12 = utf8.len(var_229_10)
				local var_229_13 = var_229_11 <= 0 and var_229_7 or var_229_7 * (var_229_12 / var_229_11)

				if var_229_13 > 0 and var_229_7 < var_229_13 then
					arg_226_1.talkMaxDuration = var_229_13

					if var_229_13 + var_229_6 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_13 + var_229_6
					end
				end

				arg_226_1.text_.text = var_229_10
				arg_226_1.typewritter.percent = 0

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111161", "111161055", "story_v_out_111161.awb") ~= 0 then
					local var_229_14 = manager.audio:GetVoiceLength("story_v_out_111161", "111161055", "story_v_out_111161.awb") / 1000

					if var_229_14 + var_229_6 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_14 + var_229_6
					end

					if var_229_9.prefab_name ~= "" and arg_226_1.actors_[var_229_9.prefab_name] ~= nil then
						local var_229_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_226_1.actors_[var_229_9.prefab_name].transform, "story_v_out_111161", "111161055", "story_v_out_111161.awb")

						arg_226_1:RecordAudio("111161055", var_229_15)
						arg_226_1:RecordAudio("111161055", var_229_15)
					else
						arg_226_1:AudioAction("play", "voice", "story_v_out_111161", "111161055", "story_v_out_111161.awb")
					end

					arg_226_1:RecordHistoryTalkVoice("story_v_out_111161", "111161055", "story_v_out_111161.awb")
				end

				arg_226_1:RecordContent(arg_226_1.text_.text)
			end

			local var_229_16 = math.max(var_229_7, arg_226_1.talkMaxDuration)

			if var_229_6 <= arg_226_1.time_ and arg_226_1.time_ < var_229_6 + var_229_16 then
				arg_226_1.typewritter.percent = (arg_226_1.time_ - var_229_6) / var_229_16

				arg_226_1.typewritter:SetDirty()
			end

			if arg_226_1.time_ >= var_229_6 + var_229_16 and arg_226_1.time_ < var_229_6 + var_229_16 + arg_229_0 then
				arg_226_1.typewritter.percent = 1

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(true)
			end
		end

		arg_226_1.nodeConfigList_ = {}

		arg_226_1:InitPlayNodeList()
	end,
	Play111161056 = function(arg_230_0, arg_230_1)
		arg_230_1.time_ = 0
		arg_230_1.frameCnt_ = 0
		arg_230_1.state_ = "playing"
		arg_230_1.curTalkId_ = 111161056
		arg_230_1.duration_ = 5.07

		local var_230_0 = {
			ja = 3.733,
			ko = 5.066,
			zh = 4.4,
			en = 4.4
		}
		local var_230_1 = manager.audio:GetLocalizationFlag()

		if var_230_0[var_230_1] ~= nil then
			arg_230_1.duration_ = var_230_0[var_230_1]
		end

		SetActive(arg_230_1.tipsGo_, false)

		function arg_230_1.onSingleLineFinish_()
			arg_230_1.onSingleLineUpdate_ = nil
			arg_230_1.onSingleLineFinish_ = nil
			arg_230_1.state_ = "waiting"
		end

		function arg_230_1.playNext_(arg_232_0)
			if arg_232_0 == 1 then
				arg_230_0:Play111161057(arg_230_1)
			end
		end

		function arg_230_1.onSingleLineUpdate_(arg_233_0)
			local var_233_0 = "D999"

			if arg_230_1.bgs_[var_233_0] == nil then
				local var_233_1 = Object.Instantiate(arg_230_1.paintGo_)

				var_233_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_233_0)
				var_233_1.name = var_233_0
				var_233_1.transform.parent = arg_230_1.stage_.transform
				var_233_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_230_1.bgs_[var_233_0] = var_233_1
			end

			local var_233_2 = 0

			if var_233_2 < arg_230_1.time_ and arg_230_1.time_ <= var_233_2 + arg_233_0 then
				local var_233_3 = manager.ui.mainCamera.transform.localPosition
				local var_233_4 = Vector3.New(0, 0, 10) + Vector3.New(var_233_3.x, var_233_3.y, 0)
				local var_233_5 = arg_230_1.bgs_.D999

				var_233_5.transform.localPosition = var_233_4
				var_233_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_233_6 = var_233_5:GetComponent("SpriteRenderer")

				if var_233_6 and var_233_6.sprite then
					local var_233_7 = (var_233_5.transform.localPosition - var_233_3).z
					local var_233_8 = manager.ui.mainCameraCom_
					local var_233_9 = 2 * var_233_7 * Mathf.Tan(var_233_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_233_10 = var_233_9 * var_233_8.aspect
					local var_233_11 = var_233_6.sprite.bounds.size.x
					local var_233_12 = var_233_6.sprite.bounds.size.y
					local var_233_13 = var_233_10 / var_233_11
					local var_233_14 = var_233_9 / var_233_12
					local var_233_15 = var_233_14 < var_233_13 and var_233_13 or var_233_14

					var_233_5.transform.localScale = Vector3.New(var_233_15, var_233_15, 0)
				end

				for iter_233_0, iter_233_1 in pairs(arg_230_1.bgs_) do
					if iter_233_0 ~= "D999" then
						iter_233_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_233_16 = arg_230_1.actors_["1094ui_story"].transform
			local var_233_17 = 0

			if var_233_17 < arg_230_1.time_ and arg_230_1.time_ <= var_233_17 + arg_233_0 then
				arg_230_1.var_.moveOldPos1094ui_story = var_233_16.localPosition
			end

			local var_233_18 = 0.001

			if var_233_17 <= arg_230_1.time_ and arg_230_1.time_ < var_233_17 + var_233_18 then
				local var_233_19 = (arg_230_1.time_ - var_233_17) / var_233_18
				local var_233_20 = Vector3.New(0, 100, 0)

				var_233_16.localPosition = Vector3.Lerp(arg_230_1.var_.moveOldPos1094ui_story, var_233_20, var_233_19)

				local var_233_21 = manager.ui.mainCamera.transform.position - var_233_16.position

				var_233_16.forward = Vector3.New(var_233_21.x, var_233_21.y, var_233_21.z)

				local var_233_22 = var_233_16.localEulerAngles

				var_233_22.z = 0
				var_233_22.x = 0
				var_233_16.localEulerAngles = var_233_22
			end

			if arg_230_1.time_ >= var_233_17 + var_233_18 and arg_230_1.time_ < var_233_17 + var_233_18 + arg_233_0 then
				var_233_16.localPosition = Vector3.New(0, 100, 0)

				local var_233_23 = manager.ui.mainCamera.transform.position - var_233_16.position

				var_233_16.forward = Vector3.New(var_233_23.x, var_233_23.y, var_233_23.z)

				local var_233_24 = var_233_16.localEulerAngles

				var_233_24.z = 0
				var_233_24.x = 0
				var_233_16.localEulerAngles = var_233_24
			end

			local var_233_25 = 0

			if var_233_25 < arg_230_1.time_ and arg_230_1.time_ <= var_233_25 + arg_233_0 then
				arg_230_1.mask_.enabled = true
				arg_230_1.mask_.raycastTarget = false

				arg_230_1:SetGaussion(false)
			end

			local var_233_26 = 1.5

			if var_233_25 <= arg_230_1.time_ and arg_230_1.time_ < var_233_25 + var_233_26 then
				local var_233_27 = (arg_230_1.time_ - var_233_25) / var_233_26
				local var_233_28 = Color.New(1, 1, 1)

				var_233_28.a = Mathf.Lerp(1, 0, var_233_27)
				arg_230_1.mask_.color = var_233_28
			end

			if arg_230_1.time_ >= var_233_25 + var_233_26 and arg_230_1.time_ < var_233_25 + var_233_26 + arg_233_0 then
				local var_233_29 = Color.New(1, 1, 1)
				local var_233_30 = 0

				arg_230_1.mask_.enabled = false
				var_233_29.a = var_233_30
				arg_230_1.mask_.color = var_233_29
			end

			local var_233_31 = 0

			if var_233_31 < arg_230_1.time_ and arg_230_1.time_ <= var_233_31 + arg_233_0 then
				arg_230_1.allBtn_.enabled = false
			end

			local var_233_32 = 2

			if arg_230_1.time_ >= var_233_31 + var_233_32 and arg_230_1.time_ < var_233_31 + var_233_32 + arg_233_0 then
				arg_230_1.allBtn_.enabled = true
			end

			if arg_230_1.frameCnt_ <= 1 then
				arg_230_1.dialog_:SetActive(false)
			end

			local var_233_33 = 2
			local var_233_34 = 0.225

			if var_233_33 < arg_230_1.time_ and arg_230_1.time_ <= var_233_33 + arg_233_0 then
				arg_230_1.talkMaxDuration = 0

				arg_230_1.dialog_:SetActive(true)

				arg_230_1.dialogCg_.alpha = 0

				local var_233_35 = LeanTween.value(arg_230_1.dialog_, 0, 1, 0.3)

				var_233_35:setOnUpdate(LuaHelper.FloatAction(function(arg_234_0)
					arg_230_1.dialogCg_.alpha = arg_234_0
				end))
				var_233_35:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_230_1.dialog_)
					var_233_35:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_230_1.duration_ = arg_230_1.duration_ + 0.3

				SetActive(arg_230_1.leftNameGo_, true)

				local var_233_36 = arg_230_1:FormatText(StoryNameCfg[176].name)

				arg_230_1.leftNameTxt_.text = var_233_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_230_1.leftNameTxt_.transform)

				arg_230_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_230_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_230_1:RecordName(arg_230_1.leftNameTxt_.text)
				SetActive(arg_230_1.iconTrs_.gameObject, true)
				arg_230_1.iconController_:SetSelectedState("hero")

				arg_230_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_helena")

				arg_230_1.callingController_:SetSelectedState("normal")

				arg_230_1.keyicon_.color = Color.New(1, 1, 1)
				arg_230_1.icon_.color = Color.New(1, 1, 1)

				local var_233_37 = arg_230_1:GetWordFromCfg(111161056)
				local var_233_38 = arg_230_1:FormatText(var_233_37.content)

				arg_230_1.text_.text = var_233_38

				LuaForUtil.ClearLinePrefixSymbol(arg_230_1.text_)

				local var_233_39 = 9
				local var_233_40 = utf8.len(var_233_38)
				local var_233_41 = var_233_39 <= 0 and var_233_34 or var_233_34 * (var_233_40 / var_233_39)

				if var_233_41 > 0 and var_233_34 < var_233_41 then
					arg_230_1.talkMaxDuration = var_233_41
					var_233_33 = var_233_33 + 0.3

					if var_233_41 + var_233_33 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_41 + var_233_33
					end
				end

				arg_230_1.text_.text = var_233_38
				arg_230_1.typewritter.percent = 0

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111161", "111161056", "story_v_out_111161.awb") ~= 0 then
					local var_233_42 = manager.audio:GetVoiceLength("story_v_out_111161", "111161056", "story_v_out_111161.awb") / 1000

					if var_233_42 + var_233_33 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_42 + var_233_33
					end

					if var_233_37.prefab_name ~= "" and arg_230_1.actors_[var_233_37.prefab_name] ~= nil then
						local var_233_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_230_1.actors_[var_233_37.prefab_name].transform, "story_v_out_111161", "111161056", "story_v_out_111161.awb")

						arg_230_1:RecordAudio("111161056", var_233_43)
						arg_230_1:RecordAudio("111161056", var_233_43)
					else
						arg_230_1:AudioAction("play", "voice", "story_v_out_111161", "111161056", "story_v_out_111161.awb")
					end

					arg_230_1:RecordHistoryTalkVoice("story_v_out_111161", "111161056", "story_v_out_111161.awb")
				end

				arg_230_1:RecordContent(arg_230_1.text_.text)
			end

			local var_233_44 = var_233_33 + 0.3
			local var_233_45 = math.max(var_233_34, arg_230_1.talkMaxDuration)

			if var_233_44 <= arg_230_1.time_ and arg_230_1.time_ < var_233_44 + var_233_45 then
				arg_230_1.typewritter.percent = (arg_230_1.time_ - var_233_44) / var_233_45

				arg_230_1.typewritter:SetDirty()
			end

			if arg_230_1.time_ >= var_233_44 + var_233_45 and arg_230_1.time_ < var_233_44 + var_233_45 + arg_233_0 then
				arg_230_1.typewritter.percent = 1

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(true)
			end
		end

		arg_230_1.nodeConfigList_ = {
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

		arg_230_1:InitPlayNodeList()
	end,
	Play111161057 = function(arg_236_0, arg_236_1)
		arg_236_1.time_ = 0
		arg_236_1.frameCnt_ = 0
		arg_236_1.state_ = "playing"
		arg_236_1.curTalkId_ = 111161057
		arg_236_1.duration_ = 5.2

		local var_236_0 = {
			ja = 3.666,
			ko = 3.166,
			zh = 5.2,
			en = 3
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
				arg_236_0:Play111161058(arg_236_1)
			end
		end

		function arg_236_1.onSingleLineUpdate_(arg_239_0)
			local var_239_0 = 0
			local var_239_1 = 0.4

			if var_239_0 < arg_236_1.time_ and arg_236_1.time_ <= var_239_0 + arg_239_0 then
				arg_236_1.talkMaxDuration = 0
				arg_236_1.dialogCg_.alpha = 1

				arg_236_1.dialog_:SetActive(true)
				SetActive(arg_236_1.leftNameGo_, true)

				local var_239_2 = arg_236_1:FormatText(StoryNameCfg[182].name)

				arg_236_1.leftNameTxt_.text = var_239_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_236_1.leftNameTxt_.transform)

				arg_236_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_236_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_236_1:RecordName(arg_236_1.leftNameTxt_.text)
				SetActive(arg_236_1.iconTrs_.gameObject, true)
				arg_236_1.iconController_:SetSelectedState("hero")

				arg_236_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_vena")

				arg_236_1.callingController_:SetSelectedState("normal")

				arg_236_1.keyicon_.color = Color.New(1, 1, 1)
				arg_236_1.icon_.color = Color.New(1, 1, 1)

				local var_239_3 = arg_236_1:GetWordFromCfg(111161057)
				local var_239_4 = arg_236_1:FormatText(var_239_3.content)

				arg_236_1.text_.text = var_239_4

				LuaForUtil.ClearLinePrefixSymbol(arg_236_1.text_)

				local var_239_5 = 16
				local var_239_6 = utf8.len(var_239_4)
				local var_239_7 = var_239_5 <= 0 and var_239_1 or var_239_1 * (var_239_6 / var_239_5)

				if var_239_7 > 0 and var_239_1 < var_239_7 then
					arg_236_1.talkMaxDuration = var_239_7

					if var_239_7 + var_239_0 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_7 + var_239_0
					end
				end

				arg_236_1.text_.text = var_239_4
				arg_236_1.typewritter.percent = 0

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111161", "111161057", "story_v_out_111161.awb") ~= 0 then
					local var_239_8 = manager.audio:GetVoiceLength("story_v_out_111161", "111161057", "story_v_out_111161.awb") / 1000

					if var_239_8 + var_239_0 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_8 + var_239_0
					end

					if var_239_3.prefab_name ~= "" and arg_236_1.actors_[var_239_3.prefab_name] ~= nil then
						local var_239_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_236_1.actors_[var_239_3.prefab_name].transform, "story_v_out_111161", "111161057", "story_v_out_111161.awb")

						arg_236_1:RecordAudio("111161057", var_239_9)
						arg_236_1:RecordAudio("111161057", var_239_9)
					else
						arg_236_1:AudioAction("play", "voice", "story_v_out_111161", "111161057", "story_v_out_111161.awb")
					end

					arg_236_1:RecordHistoryTalkVoice("story_v_out_111161", "111161057", "story_v_out_111161.awb")
				end

				arg_236_1:RecordContent(arg_236_1.text_.text)
			end

			local var_239_10 = math.max(var_239_1, arg_236_1.talkMaxDuration)

			if var_239_0 <= arg_236_1.time_ and arg_236_1.time_ < var_239_0 + var_239_10 then
				arg_236_1.typewritter.percent = (arg_236_1.time_ - var_239_0) / var_239_10

				arg_236_1.typewritter:SetDirty()
			end

			if arg_236_1.time_ >= var_239_0 + var_239_10 and arg_236_1.time_ < var_239_0 + var_239_10 + arg_239_0 then
				arg_236_1.typewritter.percent = 1

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(true)
			end
		end

		arg_236_1.nodeConfigList_ = {}

		arg_236_1:InitPlayNodeList()
	end,
	Play111161058 = function(arg_240_0, arg_240_1)
		arg_240_1.time_ = 0
		arg_240_1.frameCnt_ = 0
		arg_240_1.state_ = "playing"
		arg_240_1.curTalkId_ = 111161058
		arg_240_1.duration_ = 13.6

		local var_240_0 = {
			ja = 13.6,
			ko = 6.5,
			zh = 7,
			en = 3.433
		}
		local var_240_1 = manager.audio:GetLocalizationFlag()

		if var_240_0[var_240_1] ~= nil then
			arg_240_1.duration_ = var_240_0[var_240_1]
		end

		SetActive(arg_240_1.tipsGo_, false)

		function arg_240_1.onSingleLineFinish_()
			arg_240_1.onSingleLineUpdate_ = nil
			arg_240_1.onSingleLineFinish_ = nil
			arg_240_1.state_ = "waiting"
		end

		function arg_240_1.playNext_(arg_242_0)
			if arg_242_0 == 1 then
				arg_240_0:Play111161059(arg_240_1)
			end
		end

		function arg_240_1.onSingleLineUpdate_(arg_243_0)
			local var_243_0 = 0
			local var_243_1 = 0.525

			if var_243_0 < arg_240_1.time_ and arg_240_1.time_ <= var_243_0 + arg_243_0 then
				arg_240_1.talkMaxDuration = 0
				arg_240_1.dialogCg_.alpha = 1

				arg_240_1.dialog_:SetActive(true)
				SetActive(arg_240_1.leftNameGo_, true)

				local var_243_2 = arg_240_1:FormatText(StoryNameCfg[176].name)

				arg_240_1.leftNameTxt_.text = var_243_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_240_1.leftNameTxt_.transform)

				arg_240_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_240_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_240_1:RecordName(arg_240_1.leftNameTxt_.text)
				SetActive(arg_240_1.iconTrs_.gameObject, true)
				arg_240_1.iconController_:SetSelectedState("hero")

				arg_240_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_helena")

				arg_240_1.callingController_:SetSelectedState("normal")

				arg_240_1.keyicon_.color = Color.New(1, 1, 1)
				arg_240_1.icon_.color = Color.New(1, 1, 1)

				local var_243_3 = arg_240_1:GetWordFromCfg(111161058)
				local var_243_4 = arg_240_1:FormatText(var_243_3.content)

				arg_240_1.text_.text = var_243_4

				LuaForUtil.ClearLinePrefixSymbol(arg_240_1.text_)

				local var_243_5 = 21
				local var_243_6 = utf8.len(var_243_4)
				local var_243_7 = var_243_5 <= 0 and var_243_1 or var_243_1 * (var_243_6 / var_243_5)

				if var_243_7 > 0 and var_243_1 < var_243_7 then
					arg_240_1.talkMaxDuration = var_243_7

					if var_243_7 + var_243_0 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_7 + var_243_0
					end
				end

				arg_240_1.text_.text = var_243_4
				arg_240_1.typewritter.percent = 0

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111161", "111161058", "story_v_out_111161.awb") ~= 0 then
					local var_243_8 = manager.audio:GetVoiceLength("story_v_out_111161", "111161058", "story_v_out_111161.awb") / 1000

					if var_243_8 + var_243_0 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_8 + var_243_0
					end

					if var_243_3.prefab_name ~= "" and arg_240_1.actors_[var_243_3.prefab_name] ~= nil then
						local var_243_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_240_1.actors_[var_243_3.prefab_name].transform, "story_v_out_111161", "111161058", "story_v_out_111161.awb")

						arg_240_1:RecordAudio("111161058", var_243_9)
						arg_240_1:RecordAudio("111161058", var_243_9)
					else
						arg_240_1:AudioAction("play", "voice", "story_v_out_111161", "111161058", "story_v_out_111161.awb")
					end

					arg_240_1:RecordHistoryTalkVoice("story_v_out_111161", "111161058", "story_v_out_111161.awb")
				end

				arg_240_1:RecordContent(arg_240_1.text_.text)
			end

			local var_243_10 = math.max(var_243_1, arg_240_1.talkMaxDuration)

			if var_243_0 <= arg_240_1.time_ and arg_240_1.time_ < var_243_0 + var_243_10 then
				arg_240_1.typewritter.percent = (arg_240_1.time_ - var_243_0) / var_243_10

				arg_240_1.typewritter:SetDirty()
			end

			if arg_240_1.time_ >= var_243_0 + var_243_10 and arg_240_1.time_ < var_243_0 + var_243_10 + arg_243_0 then
				arg_240_1.typewritter.percent = 1

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(true)
			end
		end

		arg_240_1.nodeConfigList_ = {}

		arg_240_1:InitPlayNodeList()
	end,
	Play111161059 = function(arg_244_0, arg_244_1)
		arg_244_1.time_ = 0
		arg_244_1.frameCnt_ = 0
		arg_244_1.state_ = "playing"
		arg_244_1.curTalkId_ = 111161059
		arg_244_1.duration_ = 6.93

		local var_244_0 = {
			ja = 3.766,
			ko = 2.833,
			zh = 6.933,
			en = 3.633
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
				arg_244_0:Play111161060(arg_244_1)
			end
		end

		function arg_244_1.onSingleLineUpdate_(arg_247_0)
			local var_247_0 = 0
			local var_247_1 = 0.35

			if var_247_0 < arg_244_1.time_ and arg_244_1.time_ <= var_247_0 + arg_247_0 then
				arg_244_1.talkMaxDuration = 0
				arg_244_1.dialogCg_.alpha = 1

				arg_244_1.dialog_:SetActive(true)
				SetActive(arg_244_1.leftNameGo_, true)

				local var_247_2 = arg_244_1:FormatText(StoryNameCfg[182].name)

				arg_244_1.leftNameTxt_.text = var_247_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_244_1.leftNameTxt_.transform)

				arg_244_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_244_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_244_1:RecordName(arg_244_1.leftNameTxt_.text)
				SetActive(arg_244_1.iconTrs_.gameObject, true)
				arg_244_1.iconController_:SetSelectedState("hero")

				arg_244_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_vena")

				arg_244_1.callingController_:SetSelectedState("normal")

				arg_244_1.keyicon_.color = Color.New(1, 1, 1)
				arg_244_1.icon_.color = Color.New(1, 1, 1)

				local var_247_3 = arg_244_1:GetWordFromCfg(111161059)
				local var_247_4 = arg_244_1:FormatText(var_247_3.content)

				arg_244_1.text_.text = var_247_4

				LuaForUtil.ClearLinePrefixSymbol(arg_244_1.text_)

				local var_247_5 = 14
				local var_247_6 = utf8.len(var_247_4)
				local var_247_7 = var_247_5 <= 0 and var_247_1 or var_247_1 * (var_247_6 / var_247_5)

				if var_247_7 > 0 and var_247_1 < var_247_7 then
					arg_244_1.talkMaxDuration = var_247_7

					if var_247_7 + var_247_0 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_7 + var_247_0
					end
				end

				arg_244_1.text_.text = var_247_4
				arg_244_1.typewritter.percent = 0

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111161", "111161059", "story_v_out_111161.awb") ~= 0 then
					local var_247_8 = manager.audio:GetVoiceLength("story_v_out_111161", "111161059", "story_v_out_111161.awb") / 1000

					if var_247_8 + var_247_0 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_8 + var_247_0
					end

					if var_247_3.prefab_name ~= "" and arg_244_1.actors_[var_247_3.prefab_name] ~= nil then
						local var_247_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_244_1.actors_[var_247_3.prefab_name].transform, "story_v_out_111161", "111161059", "story_v_out_111161.awb")

						arg_244_1:RecordAudio("111161059", var_247_9)
						arg_244_1:RecordAudio("111161059", var_247_9)
					else
						arg_244_1:AudioAction("play", "voice", "story_v_out_111161", "111161059", "story_v_out_111161.awb")
					end

					arg_244_1:RecordHistoryTalkVoice("story_v_out_111161", "111161059", "story_v_out_111161.awb")
				end

				arg_244_1:RecordContent(arg_244_1.text_.text)
			end

			local var_247_10 = math.max(var_247_1, arg_244_1.talkMaxDuration)

			if var_247_0 <= arg_244_1.time_ and arg_244_1.time_ < var_247_0 + var_247_10 then
				arg_244_1.typewritter.percent = (arg_244_1.time_ - var_247_0) / var_247_10

				arg_244_1.typewritter:SetDirty()
			end

			if arg_244_1.time_ >= var_247_0 + var_247_10 and arg_244_1.time_ < var_247_0 + var_247_10 + arg_247_0 then
				arg_244_1.typewritter.percent = 1

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(true)
			end
		end

		arg_244_1.nodeConfigList_ = {}

		arg_244_1:InitPlayNodeList()
	end,
	Play111161060 = function(arg_248_0, arg_248_1)
		arg_248_1.time_ = 0
		arg_248_1.frameCnt_ = 0
		arg_248_1.state_ = "playing"
		arg_248_1.curTalkId_ = 111161060
		arg_248_1.duration_ = 4.2

		local var_248_0 = {
			ja = 3.4,
			ko = 3,
			zh = 4.2,
			en = 1.766
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
				arg_248_0:Play111161061(arg_248_1)
			end
		end

		function arg_248_1.onSingleLineUpdate_(arg_251_0)
			local var_251_0 = 0
			local var_251_1 = 0.3

			if var_251_0 < arg_248_1.time_ and arg_248_1.time_ <= var_251_0 + arg_251_0 then
				arg_248_1.talkMaxDuration = 0
				arg_248_1.dialogCg_.alpha = 1

				arg_248_1.dialog_:SetActive(true)
				SetActive(arg_248_1.leftNameGo_, true)

				local var_251_2 = arg_248_1:FormatText(StoryNameCfg[176].name)

				arg_248_1.leftNameTxt_.text = var_251_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_248_1.leftNameTxt_.transform)

				arg_248_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_248_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_248_1:RecordName(arg_248_1.leftNameTxt_.text)
				SetActive(arg_248_1.iconTrs_.gameObject, true)
				arg_248_1.iconController_:SetSelectedState("hero")

				arg_248_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_helena")

				arg_248_1.callingController_:SetSelectedState("normal")

				arg_248_1.keyicon_.color = Color.New(1, 1, 1)
				arg_248_1.icon_.color = Color.New(1, 1, 1)

				local var_251_3 = arg_248_1:GetWordFromCfg(111161060)
				local var_251_4 = arg_248_1:FormatText(var_251_3.content)

				arg_248_1.text_.text = var_251_4

				LuaForUtil.ClearLinePrefixSymbol(arg_248_1.text_)

				local var_251_5 = 12
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

				if manager.audio:GetVoiceLength("story_v_out_111161", "111161060", "story_v_out_111161.awb") ~= 0 then
					local var_251_8 = manager.audio:GetVoiceLength("story_v_out_111161", "111161060", "story_v_out_111161.awb") / 1000

					if var_251_8 + var_251_0 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_8 + var_251_0
					end

					if var_251_3.prefab_name ~= "" and arg_248_1.actors_[var_251_3.prefab_name] ~= nil then
						local var_251_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_248_1.actors_[var_251_3.prefab_name].transform, "story_v_out_111161", "111161060", "story_v_out_111161.awb")

						arg_248_1:RecordAudio("111161060", var_251_9)
						arg_248_1:RecordAudio("111161060", var_251_9)
					else
						arg_248_1:AudioAction("play", "voice", "story_v_out_111161", "111161060", "story_v_out_111161.awb")
					end

					arg_248_1:RecordHistoryTalkVoice("story_v_out_111161", "111161060", "story_v_out_111161.awb")
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
	Play111161061 = function(arg_252_0, arg_252_1)
		arg_252_1.time_ = 0
		arg_252_1.frameCnt_ = 0
		arg_252_1.state_ = "playing"
		arg_252_1.curTalkId_ = 111161061
		arg_252_1.duration_ = 2.3

		local var_252_0 = {
			ja = 2.233,
			ko = 1.4,
			zh = 2.3,
			en = 1.233
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
				arg_252_0:Play111161062(arg_252_1)
			end
		end

		function arg_252_1.onSingleLineUpdate_(arg_255_0)
			local var_255_0 = manager.ui.mainCamera.transform
			local var_255_1 = 0

			if var_255_1 < arg_252_1.time_ and arg_252_1.time_ <= var_255_1 + arg_255_0 then
				arg_252_1.var_.shakeOldPos = var_255_0.localPosition
			end

			local var_255_2 = 0.6

			if var_255_1 <= arg_252_1.time_ and arg_252_1.time_ < var_255_1 + var_255_2 then
				local var_255_3 = (arg_252_1.time_ - var_255_1) / 0.066
				local var_255_4, var_255_5 = math.modf(var_255_3)

				var_255_0.localPosition = Vector3.New(var_255_5 * 0.13, var_255_5 * 0.13, var_255_5 * 0.13) + arg_252_1.var_.shakeOldPos
			end

			if arg_252_1.time_ >= var_255_1 + var_255_2 and arg_252_1.time_ < var_255_1 + var_255_2 + arg_255_0 then
				var_255_0.localPosition = arg_252_1.var_.shakeOldPos
			end

			local var_255_6 = 0
			local var_255_7 = 0.125

			if var_255_6 < arg_252_1.time_ and arg_252_1.time_ <= var_255_6 + arg_255_0 then
				arg_252_1.talkMaxDuration = 0
				arg_252_1.dialogCg_.alpha = 1

				arg_252_1.dialog_:SetActive(true)
				SetActive(arg_252_1.leftNameGo_, true)

				local var_255_8 = arg_252_1:FormatText(StoryNameCfg[182].name)

				arg_252_1.leftNameTxt_.text = var_255_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_252_1.leftNameTxt_.transform)

				arg_252_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_252_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_252_1:RecordName(arg_252_1.leftNameTxt_.text)
				SetActive(arg_252_1.iconTrs_.gameObject, true)
				arg_252_1.iconController_:SetSelectedState("hero")

				arg_252_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_vena")

				arg_252_1.callingController_:SetSelectedState("normal")

				arg_252_1.keyicon_.color = Color.New(1, 1, 1)
				arg_252_1.icon_.color = Color.New(1, 1, 1)

				local var_255_9 = arg_252_1:GetWordFromCfg(111161061)
				local var_255_10 = arg_252_1:FormatText(var_255_9.content)

				arg_252_1.text_.text = var_255_10

				LuaForUtil.ClearLinePrefixSymbol(arg_252_1.text_)

				local var_255_11 = 5
				local var_255_12 = utf8.len(var_255_10)
				local var_255_13 = var_255_11 <= 0 and var_255_7 or var_255_7 * (var_255_12 / var_255_11)

				if var_255_13 > 0 and var_255_7 < var_255_13 then
					arg_252_1.talkMaxDuration = var_255_13

					if var_255_13 + var_255_6 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_13 + var_255_6
					end
				end

				arg_252_1.text_.text = var_255_10
				arg_252_1.typewritter.percent = 0

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111161", "111161061", "story_v_out_111161.awb") ~= 0 then
					local var_255_14 = manager.audio:GetVoiceLength("story_v_out_111161", "111161061", "story_v_out_111161.awb") / 1000

					if var_255_14 + var_255_6 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_14 + var_255_6
					end

					if var_255_9.prefab_name ~= "" and arg_252_1.actors_[var_255_9.prefab_name] ~= nil then
						local var_255_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_252_1.actors_[var_255_9.prefab_name].transform, "story_v_out_111161", "111161061", "story_v_out_111161.awb")

						arg_252_1:RecordAudio("111161061", var_255_15)
						arg_252_1:RecordAudio("111161061", var_255_15)
					else
						arg_252_1:AudioAction("play", "voice", "story_v_out_111161", "111161061", "story_v_out_111161.awb")
					end

					arg_252_1:RecordHistoryTalkVoice("story_v_out_111161", "111161061", "story_v_out_111161.awb")
				end

				arg_252_1:RecordContent(arg_252_1.text_.text)
			end

			local var_255_16 = math.max(var_255_7, arg_252_1.talkMaxDuration)

			if var_255_6 <= arg_252_1.time_ and arg_252_1.time_ < var_255_6 + var_255_16 then
				arg_252_1.typewritter.percent = (arg_252_1.time_ - var_255_6) / var_255_16

				arg_252_1.typewritter:SetDirty()
			end

			if arg_252_1.time_ >= var_255_6 + var_255_16 and arg_252_1.time_ < var_255_6 + var_255_16 + arg_255_0 then
				arg_252_1.typewritter.percent = 1

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(true)
			end
		end

		arg_252_1.nodeConfigList_ = {}

		arg_252_1:InitPlayNodeList()
	end,
	Play111161062 = function(arg_256_0, arg_256_1)
		arg_256_1.time_ = 0
		arg_256_1.frameCnt_ = 0
		arg_256_1.state_ = "playing"
		arg_256_1.curTalkId_ = 111161062
		arg_256_1.duration_ = 4.27

		local var_256_0 = {
			ja = 3.366,
			ko = 3.3,
			zh = 4.266,
			en = 2.2
		}
		local var_256_1 = manager.audio:GetLocalizationFlag()

		if var_256_0[var_256_1] ~= nil then
			arg_256_1.duration_ = var_256_0[var_256_1]
		end

		SetActive(arg_256_1.tipsGo_, false)

		function arg_256_1.onSingleLineFinish_()
			arg_256_1.onSingleLineUpdate_ = nil
			arg_256_1.onSingleLineFinish_ = nil
			arg_256_1.state_ = "waiting"
		end

		function arg_256_1.playNext_(arg_258_0)
			if arg_258_0 == 1 then
				arg_256_0:Play111161063(arg_256_1)
			end
		end

		function arg_256_1.onSingleLineUpdate_(arg_259_0)
			local var_259_0 = 0
			local var_259_1 = 0.325

			if var_259_0 < arg_256_1.time_ and arg_256_1.time_ <= var_259_0 + arg_259_0 then
				arg_256_1.talkMaxDuration = 0
				arg_256_1.dialogCg_.alpha = 1

				arg_256_1.dialog_:SetActive(true)
				SetActive(arg_256_1.leftNameGo_, true)

				local var_259_2 = arg_256_1:FormatText(StoryNameCfg[182].name)

				arg_256_1.leftNameTxt_.text = var_259_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_256_1.leftNameTxt_.transform)

				arg_256_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_256_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_256_1:RecordName(arg_256_1.leftNameTxt_.text)
				SetActive(arg_256_1.iconTrs_.gameObject, true)
				arg_256_1.iconController_:SetSelectedState("hero")

				arg_256_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_vena")

				arg_256_1.callingController_:SetSelectedState("normal")

				arg_256_1.keyicon_.color = Color.New(1, 1, 1)
				arg_256_1.icon_.color = Color.New(1, 1, 1)

				local var_259_3 = arg_256_1:GetWordFromCfg(111161062)
				local var_259_4 = arg_256_1:FormatText(var_259_3.content)

				arg_256_1.text_.text = var_259_4

				LuaForUtil.ClearLinePrefixSymbol(arg_256_1.text_)

				local var_259_5 = 13
				local var_259_6 = utf8.len(var_259_4)
				local var_259_7 = var_259_5 <= 0 and var_259_1 or var_259_1 * (var_259_6 / var_259_5)

				if var_259_7 > 0 and var_259_1 < var_259_7 then
					arg_256_1.talkMaxDuration = var_259_7

					if var_259_7 + var_259_0 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_7 + var_259_0
					end
				end

				arg_256_1.text_.text = var_259_4
				arg_256_1.typewritter.percent = 0

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111161", "111161062", "story_v_out_111161.awb") ~= 0 then
					local var_259_8 = manager.audio:GetVoiceLength("story_v_out_111161", "111161062", "story_v_out_111161.awb") / 1000

					if var_259_8 + var_259_0 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_8 + var_259_0
					end

					if var_259_3.prefab_name ~= "" and arg_256_1.actors_[var_259_3.prefab_name] ~= nil then
						local var_259_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_256_1.actors_[var_259_3.prefab_name].transform, "story_v_out_111161", "111161062", "story_v_out_111161.awb")

						arg_256_1:RecordAudio("111161062", var_259_9)
						arg_256_1:RecordAudio("111161062", var_259_9)
					else
						arg_256_1:AudioAction("play", "voice", "story_v_out_111161", "111161062", "story_v_out_111161.awb")
					end

					arg_256_1:RecordHistoryTalkVoice("story_v_out_111161", "111161062", "story_v_out_111161.awb")
				end

				arg_256_1:RecordContent(arg_256_1.text_.text)
			end

			local var_259_10 = math.max(var_259_1, arg_256_1.talkMaxDuration)

			if var_259_0 <= arg_256_1.time_ and arg_256_1.time_ < var_259_0 + var_259_10 then
				arg_256_1.typewritter.percent = (arg_256_1.time_ - var_259_0) / var_259_10

				arg_256_1.typewritter:SetDirty()
			end

			if arg_256_1.time_ >= var_259_0 + var_259_10 and arg_256_1.time_ < var_259_0 + var_259_10 + arg_259_0 then
				arg_256_1.typewritter.percent = 1

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(true)
			end
		end

		arg_256_1.nodeConfigList_ = {}

		arg_256_1:InitPlayNodeList()
	end,
	Play111161063 = function(arg_260_0, arg_260_1)
		arg_260_1.time_ = 0
		arg_260_1.frameCnt_ = 0
		arg_260_1.state_ = "playing"
		arg_260_1.curTalkId_ = 111161063
		arg_260_1.duration_ = 5.87

		local var_260_0 = {
			ja = 5.866,
			ko = 4.9,
			zh = 4.9,
			en = 3.666
		}
		local var_260_1 = manager.audio:GetLocalizationFlag()

		if var_260_0[var_260_1] ~= nil then
			arg_260_1.duration_ = var_260_0[var_260_1]
		end

		SetActive(arg_260_1.tipsGo_, false)

		function arg_260_1.onSingleLineFinish_()
			arg_260_1.onSingleLineUpdate_ = nil
			arg_260_1.onSingleLineFinish_ = nil
			arg_260_1.state_ = "waiting"
		end

		function arg_260_1.playNext_(arg_262_0)
			if arg_262_0 == 1 then
				arg_260_0:Play111161064(arg_260_1)
			end
		end

		function arg_260_1.onSingleLineUpdate_(arg_263_0)
			local var_263_0 = 0
			local var_263_1 = 0.425

			if var_263_0 < arg_260_1.time_ and arg_260_1.time_ <= var_263_0 + arg_263_0 then
				arg_260_1.talkMaxDuration = 0
				arg_260_1.dialogCg_.alpha = 1

				arg_260_1.dialog_:SetActive(true)
				SetActive(arg_260_1.leftNameGo_, true)

				local var_263_2 = arg_260_1:FormatText(StoryNameCfg[176].name)

				arg_260_1.leftNameTxt_.text = var_263_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_260_1.leftNameTxt_.transform)

				arg_260_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_260_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_260_1:RecordName(arg_260_1.leftNameTxt_.text)
				SetActive(arg_260_1.iconTrs_.gameObject, true)
				arg_260_1.iconController_:SetSelectedState("hero")

				arg_260_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_helena")

				arg_260_1.callingController_:SetSelectedState("normal")

				arg_260_1.keyicon_.color = Color.New(1, 1, 1)
				arg_260_1.icon_.color = Color.New(1, 1, 1)

				local var_263_3 = arg_260_1:GetWordFromCfg(111161063)
				local var_263_4 = arg_260_1:FormatText(var_263_3.content)

				arg_260_1.text_.text = var_263_4

				LuaForUtil.ClearLinePrefixSymbol(arg_260_1.text_)

				local var_263_5 = 17
				local var_263_6 = utf8.len(var_263_4)
				local var_263_7 = var_263_5 <= 0 and var_263_1 or var_263_1 * (var_263_6 / var_263_5)

				if var_263_7 > 0 and var_263_1 < var_263_7 then
					arg_260_1.talkMaxDuration = var_263_7

					if var_263_7 + var_263_0 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_7 + var_263_0
					end
				end

				arg_260_1.text_.text = var_263_4
				arg_260_1.typewritter.percent = 0

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111161", "111161063", "story_v_out_111161.awb") ~= 0 then
					local var_263_8 = manager.audio:GetVoiceLength("story_v_out_111161", "111161063", "story_v_out_111161.awb") / 1000

					if var_263_8 + var_263_0 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_8 + var_263_0
					end

					if var_263_3.prefab_name ~= "" and arg_260_1.actors_[var_263_3.prefab_name] ~= nil then
						local var_263_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_260_1.actors_[var_263_3.prefab_name].transform, "story_v_out_111161", "111161063", "story_v_out_111161.awb")

						arg_260_1:RecordAudio("111161063", var_263_9)
						arg_260_1:RecordAudio("111161063", var_263_9)
					else
						arg_260_1:AudioAction("play", "voice", "story_v_out_111161", "111161063", "story_v_out_111161.awb")
					end

					arg_260_1:RecordHistoryTalkVoice("story_v_out_111161", "111161063", "story_v_out_111161.awb")
				end

				arg_260_1:RecordContent(arg_260_1.text_.text)
			end

			local var_263_10 = math.max(var_263_1, arg_260_1.talkMaxDuration)

			if var_263_0 <= arg_260_1.time_ and arg_260_1.time_ < var_263_0 + var_263_10 then
				arg_260_1.typewritter.percent = (arg_260_1.time_ - var_263_0) / var_263_10

				arg_260_1.typewritter:SetDirty()
			end

			if arg_260_1.time_ >= var_263_0 + var_263_10 and arg_260_1.time_ < var_263_0 + var_263_10 + arg_263_0 then
				arg_260_1.typewritter.percent = 1

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(true)
			end
		end

		arg_260_1.nodeConfigList_ = {}

		arg_260_1:InitPlayNodeList()
	end,
	Play111161064 = function(arg_264_0, arg_264_1)
		arg_264_1.time_ = 0
		arg_264_1.frameCnt_ = 0
		arg_264_1.state_ = "playing"
		arg_264_1.curTalkId_ = 111161064
		arg_264_1.duration_ = 7.53

		local var_264_0 = {
			ja = 7.533,
			ko = 4.866,
			zh = 4.666,
			en = 3
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
				arg_264_0:Play111161065(arg_264_1)
			end
		end

		function arg_264_1.onSingleLineUpdate_(arg_267_0)
			local var_267_0 = 0
			local var_267_1 = 0.4

			if var_267_0 < arg_264_1.time_ and arg_264_1.time_ <= var_267_0 + arg_267_0 then
				arg_264_1.talkMaxDuration = 0
				arg_264_1.dialogCg_.alpha = 1

				arg_264_1.dialog_:SetActive(true)
				SetActive(arg_264_1.leftNameGo_, true)

				local var_267_2 = arg_264_1:FormatText(StoryNameCfg[182].name)

				arg_264_1.leftNameTxt_.text = var_267_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_264_1.leftNameTxt_.transform)

				arg_264_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_264_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_264_1:RecordName(arg_264_1.leftNameTxt_.text)
				SetActive(arg_264_1.iconTrs_.gameObject, true)
				arg_264_1.iconController_:SetSelectedState("hero")

				arg_264_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_vena")

				arg_264_1.callingController_:SetSelectedState("normal")

				arg_264_1.keyicon_.color = Color.New(1, 1, 1)
				arg_264_1.icon_.color = Color.New(1, 1, 1)

				local var_267_3 = arg_264_1:GetWordFromCfg(111161064)
				local var_267_4 = arg_264_1:FormatText(var_267_3.content)

				arg_264_1.text_.text = var_267_4

				LuaForUtil.ClearLinePrefixSymbol(arg_264_1.text_)

				local var_267_5 = 16
				local var_267_6 = utf8.len(var_267_4)
				local var_267_7 = var_267_5 <= 0 and var_267_1 or var_267_1 * (var_267_6 / var_267_5)

				if var_267_7 > 0 and var_267_1 < var_267_7 then
					arg_264_1.talkMaxDuration = var_267_7

					if var_267_7 + var_267_0 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_7 + var_267_0
					end
				end

				arg_264_1.text_.text = var_267_4
				arg_264_1.typewritter.percent = 0

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111161", "111161064", "story_v_out_111161.awb") ~= 0 then
					local var_267_8 = manager.audio:GetVoiceLength("story_v_out_111161", "111161064", "story_v_out_111161.awb") / 1000

					if var_267_8 + var_267_0 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_8 + var_267_0
					end

					if var_267_3.prefab_name ~= "" and arg_264_1.actors_[var_267_3.prefab_name] ~= nil then
						local var_267_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_264_1.actors_[var_267_3.prefab_name].transform, "story_v_out_111161", "111161064", "story_v_out_111161.awb")

						arg_264_1:RecordAudio("111161064", var_267_9)
						arg_264_1:RecordAudio("111161064", var_267_9)
					else
						arg_264_1:AudioAction("play", "voice", "story_v_out_111161", "111161064", "story_v_out_111161.awb")
					end

					arg_264_1:RecordHistoryTalkVoice("story_v_out_111161", "111161064", "story_v_out_111161.awb")
				end

				arg_264_1:RecordContent(arg_264_1.text_.text)
			end

			local var_267_10 = math.max(var_267_1, arg_264_1.talkMaxDuration)

			if var_267_0 <= arg_264_1.time_ and arg_264_1.time_ < var_267_0 + var_267_10 then
				arg_264_1.typewritter.percent = (arg_264_1.time_ - var_267_0) / var_267_10

				arg_264_1.typewritter:SetDirty()
			end

			if arg_264_1.time_ >= var_267_0 + var_267_10 and arg_264_1.time_ < var_267_0 + var_267_10 + arg_267_0 then
				arg_264_1.typewritter.percent = 1

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(true)
			end
		end

		arg_264_1.nodeConfigList_ = {}

		arg_264_1:InitPlayNodeList()
	end,
	Play111161065 = function(arg_268_0, arg_268_1)
		arg_268_1.time_ = 0
		arg_268_1.frameCnt_ = 0
		arg_268_1.state_ = "playing"
		arg_268_1.curTalkId_ = 111161065
		arg_268_1.duration_ = 7

		SetActive(arg_268_1.tipsGo_, false)

		function arg_268_1.onSingleLineFinish_()
			arg_268_1.onSingleLineUpdate_ = nil
			arg_268_1.onSingleLineFinish_ = nil
			arg_268_1.state_ = "waiting"
		end

		function arg_268_1.playNext_(arg_270_0)
			if arg_270_0 == 1 then
				arg_268_0:Play111161066(arg_268_1)
			end
		end

		function arg_268_1.onSingleLineUpdate_(arg_271_0)
			local var_271_0 = 0

			if var_271_0 < arg_268_1.time_ and arg_268_1.time_ <= var_271_0 + arg_271_0 then
				local var_271_1 = manager.ui.mainCamera.transform.localPosition
				local var_271_2 = Vector3.New(0, 0, 10) + Vector3.New(var_271_1.x, var_271_1.y, 0)
				local var_271_3 = arg_268_1.bgs_.D09a

				var_271_3.transform.localPosition = var_271_2
				var_271_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_271_4 = var_271_3:GetComponent("SpriteRenderer")

				if var_271_4 and var_271_4.sprite then
					local var_271_5 = (var_271_3.transform.localPosition - var_271_1).z
					local var_271_6 = manager.ui.mainCameraCom_
					local var_271_7 = 2 * var_271_5 * Mathf.Tan(var_271_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_271_8 = var_271_7 * var_271_6.aspect
					local var_271_9 = var_271_4.sprite.bounds.size.x
					local var_271_10 = var_271_4.sprite.bounds.size.y
					local var_271_11 = var_271_8 / var_271_9
					local var_271_12 = var_271_7 / var_271_10
					local var_271_13 = var_271_12 < var_271_11 and var_271_11 or var_271_12

					var_271_3.transform.localScale = Vector3.New(var_271_13, var_271_13, 0)
				end

				for iter_271_0, iter_271_1 in pairs(arg_268_1.bgs_) do
					if iter_271_0 ~= "D09a" then
						iter_271_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_271_14 = 0

			if var_271_14 < arg_268_1.time_ and arg_268_1.time_ <= var_271_14 + arg_271_0 then
				arg_268_1.mask_.enabled = true
				arg_268_1.mask_.raycastTarget = true

				arg_268_1:SetGaussion(false)
			end

			local var_271_15 = 2

			if var_271_14 <= arg_268_1.time_ and arg_268_1.time_ < var_271_14 + var_271_15 then
				local var_271_16 = (arg_268_1.time_ - var_271_14) / var_271_15
				local var_271_17 = Color.New(1, 1, 1)

				var_271_17.a = Mathf.Lerp(1, 0, var_271_16)
				arg_268_1.mask_.color = var_271_17
			end

			if arg_268_1.time_ >= var_271_14 + var_271_15 and arg_268_1.time_ < var_271_14 + var_271_15 + arg_271_0 then
				local var_271_18 = Color.New(1, 1, 1)
				local var_271_19 = 0

				arg_268_1.mask_.enabled = false
				var_271_18.a = var_271_19
				arg_268_1.mask_.color = var_271_18
			end

			local var_271_20 = 0

			if var_271_20 < arg_268_1.time_ and arg_268_1.time_ <= var_271_20 + arg_271_0 then
				arg_268_1.allBtn_.enabled = false
			end

			local var_271_21 = 2

			if arg_268_1.time_ >= var_271_20 + var_271_21 and arg_268_1.time_ < var_271_20 + var_271_21 + arg_271_0 then
				arg_268_1.allBtn_.enabled = true
			end

			if arg_268_1.frameCnt_ <= 1 then
				arg_268_1.dialog_:SetActive(false)
			end

			local var_271_22 = 2
			local var_271_23 = 0.325

			if var_271_22 < arg_268_1.time_ and arg_268_1.time_ <= var_271_22 + arg_271_0 then
				arg_268_1.talkMaxDuration = 0

				arg_268_1.dialog_:SetActive(true)

				arg_268_1.dialogCg_.alpha = 0

				local var_271_24 = LeanTween.value(arg_268_1.dialog_, 0, 1, 0.3)

				var_271_24:setOnUpdate(LuaHelper.FloatAction(function(arg_272_0)
					arg_268_1.dialogCg_.alpha = arg_272_0
				end))
				var_271_24:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_268_1.dialog_)
					var_271_24:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_268_1.duration_ = arg_268_1.duration_ + 0.3

				SetActive(arg_268_1.leftNameGo_, true)

				local var_271_25 = arg_268_1:FormatText(StoryNameCfg[7].name)

				arg_268_1.leftNameTxt_.text = var_271_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_268_1.leftNameTxt_.transform)

				arg_268_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_268_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_268_1:RecordName(arg_268_1.leftNameTxt_.text)
				SetActive(arg_268_1.iconTrs_.gameObject, true)
				arg_268_1.iconController_:SetSelectedState("hero")

				arg_268_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_268_1.callingController_:SetSelectedState("normal")

				arg_268_1.keyicon_.color = Color.New(1, 1, 1)
				arg_268_1.icon_.color = Color.New(1, 1, 1)

				local var_271_26 = arg_268_1:GetWordFromCfg(111161065)
				local var_271_27 = arg_268_1:FormatText(var_271_26.content)

				arg_268_1.text_.text = var_271_27

				LuaForUtil.ClearLinePrefixSymbol(arg_268_1.text_)

				local var_271_28 = 13
				local var_271_29 = utf8.len(var_271_27)
				local var_271_30 = var_271_28 <= 0 and var_271_23 or var_271_23 * (var_271_29 / var_271_28)

				if var_271_30 > 0 and var_271_23 < var_271_30 then
					arg_268_1.talkMaxDuration = var_271_30
					var_271_22 = var_271_22 + 0.3

					if var_271_30 + var_271_22 > arg_268_1.duration_ then
						arg_268_1.duration_ = var_271_30 + var_271_22
					end
				end

				arg_268_1.text_.text = var_271_27
				arg_268_1.typewritter.percent = 0

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(false)
				arg_268_1:RecordContent(arg_268_1.text_.text)
			end

			local var_271_31 = var_271_22 + 0.3
			local var_271_32 = math.max(var_271_23, arg_268_1.talkMaxDuration)

			if var_271_31 <= arg_268_1.time_ and arg_268_1.time_ < var_271_31 + var_271_32 then
				arg_268_1.typewritter.percent = (arg_268_1.time_ - var_271_31) / var_271_32

				arg_268_1.typewritter:SetDirty()
			end

			if arg_268_1.time_ >= var_271_31 + var_271_32 and arg_268_1.time_ < var_271_31 + var_271_32 + arg_271_0 then
				arg_268_1.typewritter.percent = 1

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(true)
			end
		end

		arg_268_1.nodeConfigList_ = {}

		arg_268_1:InitPlayNodeList()
	end,
	Play111161066 = function(arg_274_0, arg_274_1)
		arg_274_1.time_ = 0
		arg_274_1.frameCnt_ = 0
		arg_274_1.state_ = "playing"
		arg_274_1.curTalkId_ = 111161066
		arg_274_1.duration_ = 10.27

		local var_274_0 = {
			ja = 10.266,
			ko = 5.7,
			zh = 7.433,
			en = 6.533
		}
		local var_274_1 = manager.audio:GetLocalizationFlag()

		if var_274_0[var_274_1] ~= nil then
			arg_274_1.duration_ = var_274_0[var_274_1]
		end

		SetActive(arg_274_1.tipsGo_, false)

		function arg_274_1.onSingleLineFinish_()
			arg_274_1.onSingleLineUpdate_ = nil
			arg_274_1.onSingleLineFinish_ = nil
			arg_274_1.state_ = "waiting"
		end

		function arg_274_1.playNext_(arg_276_0)
			if arg_276_0 == 1 then
				arg_274_0:Play111161067(arg_274_1)
			end
		end

		function arg_274_1.onSingleLineUpdate_(arg_277_0)
			local var_277_0 = arg_274_1.actors_["1094ui_story"].transform
			local var_277_1 = 0

			if var_277_1 < arg_274_1.time_ and arg_274_1.time_ <= var_277_1 + arg_277_0 then
				arg_274_1.var_.moveOldPos1094ui_story = var_277_0.localPosition
			end

			local var_277_2 = 0.001

			if var_277_1 <= arg_274_1.time_ and arg_274_1.time_ < var_277_1 + var_277_2 then
				local var_277_3 = (arg_274_1.time_ - var_277_1) / var_277_2
				local var_277_4 = Vector3.New(0, -0.84, -6.1)

				var_277_0.localPosition = Vector3.Lerp(arg_274_1.var_.moveOldPos1094ui_story, var_277_4, var_277_3)

				local var_277_5 = manager.ui.mainCamera.transform.position - var_277_0.position

				var_277_0.forward = Vector3.New(var_277_5.x, var_277_5.y, var_277_5.z)

				local var_277_6 = var_277_0.localEulerAngles

				var_277_6.z = 0
				var_277_6.x = 0
				var_277_0.localEulerAngles = var_277_6
			end

			if arg_274_1.time_ >= var_277_1 + var_277_2 and arg_274_1.time_ < var_277_1 + var_277_2 + arg_277_0 then
				var_277_0.localPosition = Vector3.New(0, -0.84, -6.1)

				local var_277_7 = manager.ui.mainCamera.transform.position - var_277_0.position

				var_277_0.forward = Vector3.New(var_277_7.x, var_277_7.y, var_277_7.z)

				local var_277_8 = var_277_0.localEulerAngles

				var_277_8.z = 0
				var_277_8.x = 0
				var_277_0.localEulerAngles = var_277_8
			end

			local var_277_9 = 0

			if var_277_9 < arg_274_1.time_ and arg_274_1.time_ <= var_277_9 + arg_277_0 then
				arg_274_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_277_10 = arg_274_1.actors_["1094ui_story"]
			local var_277_11 = 0

			if var_277_11 < arg_274_1.time_ and arg_274_1.time_ <= var_277_11 + arg_277_0 and not isNil(var_277_10) and arg_274_1.var_.characterEffect1094ui_story == nil then
				arg_274_1.var_.characterEffect1094ui_story = var_277_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_277_12 = 0.2

			if var_277_11 <= arg_274_1.time_ and arg_274_1.time_ < var_277_11 + var_277_12 and not isNil(var_277_10) then
				local var_277_13 = (arg_274_1.time_ - var_277_11) / var_277_12

				if arg_274_1.var_.characterEffect1094ui_story and not isNil(var_277_10) then
					arg_274_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_274_1.time_ >= var_277_11 + var_277_12 and arg_274_1.time_ < var_277_11 + var_277_12 + arg_277_0 and not isNil(var_277_10) and arg_274_1.var_.characterEffect1094ui_story then
				arg_274_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_277_14 = 0

			if var_277_14 < arg_274_1.time_ and arg_274_1.time_ <= var_277_14 + arg_277_0 then
				arg_274_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action1_1")
			end

			local var_277_15 = 0
			local var_277_16 = 0.55

			if var_277_15 < arg_274_1.time_ and arg_274_1.time_ <= var_277_15 + arg_277_0 then
				arg_274_1.talkMaxDuration = 0
				arg_274_1.dialogCg_.alpha = 1

				arg_274_1.dialog_:SetActive(true)
				SetActive(arg_274_1.leftNameGo_, true)

				local var_277_17 = arg_274_1:FormatText(StoryNameCfg[181].name)

				arg_274_1.leftNameTxt_.text = var_277_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_274_1.leftNameTxt_.transform)

				arg_274_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_274_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_274_1:RecordName(arg_274_1.leftNameTxt_.text)
				SetActive(arg_274_1.iconTrs_.gameObject, false)
				arg_274_1.callingController_:SetSelectedState("normal")

				local var_277_18 = arg_274_1:GetWordFromCfg(111161066)
				local var_277_19 = arg_274_1:FormatText(var_277_18.content)

				arg_274_1.text_.text = var_277_19

				LuaForUtil.ClearLinePrefixSymbol(arg_274_1.text_)

				local var_277_20 = 22
				local var_277_21 = utf8.len(var_277_19)
				local var_277_22 = var_277_20 <= 0 and var_277_16 or var_277_16 * (var_277_21 / var_277_20)

				if var_277_22 > 0 and var_277_16 < var_277_22 then
					arg_274_1.talkMaxDuration = var_277_22

					if var_277_22 + var_277_15 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_22 + var_277_15
					end
				end

				arg_274_1.text_.text = var_277_19
				arg_274_1.typewritter.percent = 0

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111161", "111161066", "story_v_out_111161.awb") ~= 0 then
					local var_277_23 = manager.audio:GetVoiceLength("story_v_out_111161", "111161066", "story_v_out_111161.awb") / 1000

					if var_277_23 + var_277_15 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_23 + var_277_15
					end

					if var_277_18.prefab_name ~= "" and arg_274_1.actors_[var_277_18.prefab_name] ~= nil then
						local var_277_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_274_1.actors_[var_277_18.prefab_name].transform, "story_v_out_111161", "111161066", "story_v_out_111161.awb")

						arg_274_1:RecordAudio("111161066", var_277_24)
						arg_274_1:RecordAudio("111161066", var_277_24)
					else
						arg_274_1:AudioAction("play", "voice", "story_v_out_111161", "111161066", "story_v_out_111161.awb")
					end

					arg_274_1:RecordHistoryTalkVoice("story_v_out_111161", "111161066", "story_v_out_111161.awb")
				end

				arg_274_1:RecordContent(arg_274_1.text_.text)
			end

			local var_277_25 = math.max(var_277_16, arg_274_1.talkMaxDuration)

			if var_277_15 <= arg_274_1.time_ and arg_274_1.time_ < var_277_15 + var_277_25 then
				arg_274_1.typewritter.percent = (arg_274_1.time_ - var_277_15) / var_277_25

				arg_274_1.typewritter:SetDirty()
			end

			if arg_274_1.time_ >= var_277_15 + var_277_25 and arg_274_1.time_ < var_277_15 + var_277_25 + arg_277_0 then
				arg_274_1.typewritter.percent = 1

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(true)
			end
		end

		arg_274_1.nodeConfigList_ = {
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

		arg_274_1:InitPlayNodeList()
	end,
	Play111161067 = function(arg_278_0, arg_278_1)
		arg_278_1.time_ = 0
		arg_278_1.frameCnt_ = 0
		arg_278_1.state_ = "playing"
		arg_278_1.curTalkId_ = 111161067
		arg_278_1.duration_ = 5

		SetActive(arg_278_1.tipsGo_, false)

		function arg_278_1.onSingleLineFinish_()
			arg_278_1.onSingleLineUpdate_ = nil
			arg_278_1.onSingleLineFinish_ = nil
			arg_278_1.state_ = "waiting"
		end

		function arg_278_1.playNext_(arg_280_0)
			if arg_280_0 == 1 then
				arg_278_0:Play111161068(arg_278_1)
			end
		end

		function arg_278_1.onSingleLineUpdate_(arg_281_0)
			local var_281_0 = arg_278_1.actors_["1094ui_story"]
			local var_281_1 = 0

			if var_281_1 < arg_278_1.time_ and arg_278_1.time_ <= var_281_1 + arg_281_0 and not isNil(var_281_0) and arg_278_1.var_.characterEffect1094ui_story == nil then
				arg_278_1.var_.characterEffect1094ui_story = var_281_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_281_2 = 0.2

			if var_281_1 <= arg_278_1.time_ and arg_278_1.time_ < var_281_1 + var_281_2 and not isNil(var_281_0) then
				local var_281_3 = (arg_278_1.time_ - var_281_1) / var_281_2

				if arg_278_1.var_.characterEffect1094ui_story and not isNil(var_281_0) then
					local var_281_4 = Mathf.Lerp(0, 0.5, var_281_3)

					arg_278_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_278_1.var_.characterEffect1094ui_story.fillRatio = var_281_4
				end
			end

			if arg_278_1.time_ >= var_281_1 + var_281_2 and arg_278_1.time_ < var_281_1 + var_281_2 + arg_281_0 and not isNil(var_281_0) and arg_278_1.var_.characterEffect1094ui_story then
				local var_281_5 = 0.5

				arg_278_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_278_1.var_.characterEffect1094ui_story.fillRatio = var_281_5
			end

			local var_281_6 = 0
			local var_281_7 = 1.1

			if var_281_6 < arg_278_1.time_ and arg_278_1.time_ <= var_281_6 + arg_281_0 then
				arg_278_1.talkMaxDuration = 0
				arg_278_1.dialogCg_.alpha = 1

				arg_278_1.dialog_:SetActive(true)
				SetActive(arg_278_1.leftNameGo_, true)

				local var_281_8 = arg_278_1:FormatText(StoryNameCfg[7].name)

				arg_278_1.leftNameTxt_.text = var_281_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_278_1.leftNameTxt_.transform)

				arg_278_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_278_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_278_1:RecordName(arg_278_1.leftNameTxt_.text)
				SetActive(arg_278_1.iconTrs_.gameObject, true)
				arg_278_1.iconController_:SetSelectedState("hero")

				arg_278_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_278_1.callingController_:SetSelectedState("normal")

				arg_278_1.keyicon_.color = Color.New(1, 1, 1)
				arg_278_1.icon_.color = Color.New(1, 1, 1)

				local var_281_9 = arg_278_1:GetWordFromCfg(111161067)
				local var_281_10 = arg_278_1:FormatText(var_281_9.content)

				arg_278_1.text_.text = var_281_10

				LuaForUtil.ClearLinePrefixSymbol(arg_278_1.text_)

				local var_281_11 = 32
				local var_281_12 = utf8.len(var_281_10)
				local var_281_13 = var_281_11 <= 0 and var_281_7 or var_281_7 * (var_281_12 / var_281_11)

				if var_281_13 > 0 and var_281_7 < var_281_13 then
					arg_278_1.talkMaxDuration = var_281_13

					if var_281_13 + var_281_6 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_13 + var_281_6
					end
				end

				arg_278_1.text_.text = var_281_10
				arg_278_1.typewritter.percent = 0

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(false)
				arg_278_1:RecordContent(arg_278_1.text_.text)
			end

			local var_281_14 = math.max(var_281_7, arg_278_1.talkMaxDuration)

			if var_281_6 <= arg_278_1.time_ and arg_278_1.time_ < var_281_6 + var_281_14 then
				arg_278_1.typewritter.percent = (arg_278_1.time_ - var_281_6) / var_281_14

				arg_278_1.typewritter:SetDirty()
			end

			if arg_278_1.time_ >= var_281_6 + var_281_14 and arg_278_1.time_ < var_281_6 + var_281_14 + arg_281_0 then
				arg_278_1.typewritter.percent = 1

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(true)
			end
		end

		arg_278_1.nodeConfigList_ = {}

		arg_278_1:InitPlayNodeList()
	end,
	Play111161068 = function(arg_282_0, arg_282_1)
		arg_282_1.time_ = 0
		arg_282_1.frameCnt_ = 0
		arg_282_1.state_ = "playing"
		arg_282_1.curTalkId_ = 111161068
		arg_282_1.duration_ = 5

		SetActive(arg_282_1.tipsGo_, false)

		function arg_282_1.onSingleLineFinish_()
			arg_282_1.onSingleLineUpdate_ = nil
			arg_282_1.onSingleLineFinish_ = nil
			arg_282_1.state_ = "waiting"
		end

		function arg_282_1.playNext_(arg_284_0)
			if arg_284_0 == 1 then
				arg_282_0:Play111161069(arg_282_1)
			end
		end

		function arg_282_1.onSingleLineUpdate_(arg_285_0)
			local var_285_0 = 0
			local var_285_1 = 0.8

			if var_285_0 < arg_282_1.time_ and arg_282_1.time_ <= var_285_0 + arg_285_0 then
				arg_282_1.talkMaxDuration = 0
				arg_282_1.dialogCg_.alpha = 1

				arg_282_1.dialog_:SetActive(true)
				SetActive(arg_282_1.leftNameGo_, true)

				local var_285_2 = arg_282_1:FormatText(StoryNameCfg[7].name)

				arg_282_1.leftNameTxt_.text = var_285_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_282_1.leftNameTxt_.transform)

				arg_282_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_282_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_282_1:RecordName(arg_282_1.leftNameTxt_.text)
				SetActive(arg_282_1.iconTrs_.gameObject, true)
				arg_282_1.iconController_:SetSelectedState("hero")

				arg_282_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_282_1.callingController_:SetSelectedState("normal")

				arg_282_1.keyicon_.color = Color.New(1, 1, 1)
				arg_282_1.icon_.color = Color.New(1, 1, 1)

				local var_285_3 = arg_282_1:GetWordFromCfg(111161068)
				local var_285_4 = arg_282_1:FormatText(var_285_3.content)

				arg_282_1.text_.text = var_285_4

				LuaForUtil.ClearLinePrefixSymbol(arg_282_1.text_)

				local var_285_5 = 22
				local var_285_6 = utf8.len(var_285_4)
				local var_285_7 = var_285_5 <= 0 and var_285_1 or var_285_1 * (var_285_6 / var_285_5)

				if var_285_7 > 0 and var_285_1 < var_285_7 then
					arg_282_1.talkMaxDuration = var_285_7

					if var_285_7 + var_285_0 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_7 + var_285_0
					end
				end

				arg_282_1.text_.text = var_285_4
				arg_282_1.typewritter.percent = 0

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(false)
				arg_282_1:RecordContent(arg_282_1.text_.text)
			end

			local var_285_8 = math.max(var_285_1, arg_282_1.talkMaxDuration)

			if var_285_0 <= arg_282_1.time_ and arg_282_1.time_ < var_285_0 + var_285_8 then
				arg_282_1.typewritter.percent = (arg_282_1.time_ - var_285_0) / var_285_8

				arg_282_1.typewritter:SetDirty()
			end

			if arg_282_1.time_ >= var_285_0 + var_285_8 and arg_282_1.time_ < var_285_0 + var_285_8 + arg_285_0 then
				arg_282_1.typewritter.percent = 1

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(true)
			end
		end

		arg_282_1.nodeConfigList_ = {}

		arg_282_1:InitPlayNodeList()
	end,
	Play111161069 = function(arg_286_0, arg_286_1)
		arg_286_1.time_ = 0
		arg_286_1.frameCnt_ = 0
		arg_286_1.state_ = "playing"
		arg_286_1.curTalkId_ = 111161069
		arg_286_1.duration_ = 5.97

		local var_286_0 = {
			ja = 5.966,
			ko = 1.999999999999,
			zh = 2.266,
			en = 1.999999999999
		}
		local var_286_1 = manager.audio:GetLocalizationFlag()

		if var_286_0[var_286_1] ~= nil then
			arg_286_1.duration_ = var_286_0[var_286_1]
		end

		SetActive(arg_286_1.tipsGo_, false)

		function arg_286_1.onSingleLineFinish_()
			arg_286_1.onSingleLineUpdate_ = nil
			arg_286_1.onSingleLineFinish_ = nil
			arg_286_1.state_ = "waiting"
		end

		function arg_286_1.playNext_(arg_288_0)
			if arg_288_0 == 1 then
				arg_286_0:Play111161070(arg_286_1)
			end
		end

		function arg_286_1.onSingleLineUpdate_(arg_289_0)
			local var_289_0 = 0

			if var_289_0 < arg_286_1.time_ and arg_286_1.time_ <= var_289_0 + arg_289_0 then
				arg_286_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action4_1")
			end

			local var_289_1 = 0

			if var_289_1 < arg_286_1.time_ and arg_286_1.time_ <= var_289_1 + arg_289_0 then
				arg_286_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_289_2 = arg_286_1.actors_["1094ui_story"]
			local var_289_3 = 0

			if var_289_3 < arg_286_1.time_ and arg_286_1.time_ <= var_289_3 + arg_289_0 and not isNil(var_289_2) and arg_286_1.var_.characterEffect1094ui_story == nil then
				arg_286_1.var_.characterEffect1094ui_story = var_289_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_289_4 = 0.2

			if var_289_3 <= arg_286_1.time_ and arg_286_1.time_ < var_289_3 + var_289_4 and not isNil(var_289_2) then
				local var_289_5 = (arg_286_1.time_ - var_289_3) / var_289_4

				if arg_286_1.var_.characterEffect1094ui_story and not isNil(var_289_2) then
					arg_286_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_286_1.time_ >= var_289_3 + var_289_4 and arg_286_1.time_ < var_289_3 + var_289_4 + arg_289_0 and not isNil(var_289_2) and arg_286_1.var_.characterEffect1094ui_story then
				arg_286_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_289_6 = 0
			local var_289_7 = 0.25

			if var_289_6 < arg_286_1.time_ and arg_286_1.time_ <= var_289_6 + arg_289_0 then
				arg_286_1.talkMaxDuration = 0
				arg_286_1.dialogCg_.alpha = 1

				arg_286_1.dialog_:SetActive(true)
				SetActive(arg_286_1.leftNameGo_, true)

				local var_289_8 = arg_286_1:FormatText(StoryNameCfg[181].name)

				arg_286_1.leftNameTxt_.text = var_289_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_286_1.leftNameTxt_.transform)

				arg_286_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_286_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_286_1:RecordName(arg_286_1.leftNameTxt_.text)
				SetActive(arg_286_1.iconTrs_.gameObject, false)
				arg_286_1.callingController_:SetSelectedState("normal")

				local var_289_9 = arg_286_1:GetWordFromCfg(111161069)
				local var_289_10 = arg_286_1:FormatText(var_289_9.content)

				arg_286_1.text_.text = var_289_10

				LuaForUtil.ClearLinePrefixSymbol(arg_286_1.text_)

				local var_289_11 = 10
				local var_289_12 = utf8.len(var_289_10)
				local var_289_13 = var_289_11 <= 0 and var_289_7 or var_289_7 * (var_289_12 / var_289_11)

				if var_289_13 > 0 and var_289_7 < var_289_13 then
					arg_286_1.talkMaxDuration = var_289_13

					if var_289_13 + var_289_6 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_13 + var_289_6
					end
				end

				arg_286_1.text_.text = var_289_10
				arg_286_1.typewritter.percent = 0

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111161", "111161069", "story_v_out_111161.awb") ~= 0 then
					local var_289_14 = manager.audio:GetVoiceLength("story_v_out_111161", "111161069", "story_v_out_111161.awb") / 1000

					if var_289_14 + var_289_6 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_14 + var_289_6
					end

					if var_289_9.prefab_name ~= "" and arg_286_1.actors_[var_289_9.prefab_name] ~= nil then
						local var_289_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_286_1.actors_[var_289_9.prefab_name].transform, "story_v_out_111161", "111161069", "story_v_out_111161.awb")

						arg_286_1:RecordAudio("111161069", var_289_15)
						arg_286_1:RecordAudio("111161069", var_289_15)
					else
						arg_286_1:AudioAction("play", "voice", "story_v_out_111161", "111161069", "story_v_out_111161.awb")
					end

					arg_286_1:RecordHistoryTalkVoice("story_v_out_111161", "111161069", "story_v_out_111161.awb")
				end

				arg_286_1:RecordContent(arg_286_1.text_.text)
			end

			local var_289_16 = math.max(var_289_7, arg_286_1.talkMaxDuration)

			if var_289_6 <= arg_286_1.time_ and arg_286_1.time_ < var_289_6 + var_289_16 then
				arg_286_1.typewritter.percent = (arg_286_1.time_ - var_289_6) / var_289_16

				arg_286_1.typewritter:SetDirty()
			end

			if arg_286_1.time_ >= var_289_6 + var_289_16 and arg_286_1.time_ < var_289_6 + var_289_16 + arg_289_0 then
				arg_286_1.typewritter.percent = 1

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(true)
			end
		end

		arg_286_1.nodeConfigList_ = {}

		arg_286_1:InitPlayNodeList()
	end,
	Play111161070 = function(arg_290_0, arg_290_1)
		arg_290_1.time_ = 0
		arg_290_1.frameCnt_ = 0
		arg_290_1.state_ = "playing"
		arg_290_1.curTalkId_ = 111161070
		arg_290_1.duration_ = 5

		SetActive(arg_290_1.tipsGo_, false)

		function arg_290_1.onSingleLineFinish_()
			arg_290_1.onSingleLineUpdate_ = nil
			arg_290_1.onSingleLineFinish_ = nil
			arg_290_1.state_ = "waiting"
		end

		function arg_290_1.playNext_(arg_292_0)
			if arg_292_0 == 1 then
				arg_290_0:Play111161071(arg_290_1)
			end
		end

		function arg_290_1.onSingleLineUpdate_(arg_293_0)
			local var_293_0 = arg_290_1.actors_["1094ui_story"]
			local var_293_1 = 0

			if var_293_1 < arg_290_1.time_ and arg_290_1.time_ <= var_293_1 + arg_293_0 and not isNil(var_293_0) and arg_290_1.var_.characterEffect1094ui_story == nil then
				arg_290_1.var_.characterEffect1094ui_story = var_293_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_293_2 = 0.2

			if var_293_1 <= arg_290_1.time_ and arg_290_1.time_ < var_293_1 + var_293_2 and not isNil(var_293_0) then
				local var_293_3 = (arg_290_1.time_ - var_293_1) / var_293_2

				if arg_290_1.var_.characterEffect1094ui_story and not isNil(var_293_0) then
					local var_293_4 = Mathf.Lerp(0, 0.5, var_293_3)

					arg_290_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_290_1.var_.characterEffect1094ui_story.fillRatio = var_293_4
				end
			end

			if arg_290_1.time_ >= var_293_1 + var_293_2 and arg_290_1.time_ < var_293_1 + var_293_2 + arg_293_0 and not isNil(var_293_0) and arg_290_1.var_.characterEffect1094ui_story then
				local var_293_5 = 0.5

				arg_290_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_290_1.var_.characterEffect1094ui_story.fillRatio = var_293_5
			end

			local var_293_6 = 0
			local var_293_7 = 0.975

			if var_293_6 < arg_290_1.time_ and arg_290_1.time_ <= var_293_6 + arg_293_0 then
				arg_290_1.talkMaxDuration = 0
				arg_290_1.dialogCg_.alpha = 1

				arg_290_1.dialog_:SetActive(true)
				SetActive(arg_290_1.leftNameGo_, true)

				local var_293_8 = arg_290_1:FormatText(StoryNameCfg[7].name)

				arg_290_1.leftNameTxt_.text = var_293_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_290_1.leftNameTxt_.transform)

				arg_290_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_290_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_290_1:RecordName(arg_290_1.leftNameTxt_.text)
				SetActive(arg_290_1.iconTrs_.gameObject, true)
				arg_290_1.iconController_:SetSelectedState("hero")

				arg_290_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_290_1.callingController_:SetSelectedState("normal")

				arg_290_1.keyicon_.color = Color.New(1, 1, 1)
				arg_290_1.icon_.color = Color.New(1, 1, 1)

				local var_293_9 = arg_290_1:GetWordFromCfg(111161070)
				local var_293_10 = arg_290_1:FormatText(var_293_9.content)

				arg_290_1.text_.text = var_293_10

				LuaForUtil.ClearLinePrefixSymbol(arg_290_1.text_)

				local var_293_11 = 33
				local var_293_12 = utf8.len(var_293_10)
				local var_293_13 = var_293_11 <= 0 and var_293_7 or var_293_7 * (var_293_12 / var_293_11)

				if var_293_13 > 0 and var_293_7 < var_293_13 then
					arg_290_1.talkMaxDuration = var_293_13

					if var_293_13 + var_293_6 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_13 + var_293_6
					end
				end

				arg_290_1.text_.text = var_293_10
				arg_290_1.typewritter.percent = 0

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(false)
				arg_290_1:RecordContent(arg_290_1.text_.text)
			end

			local var_293_14 = math.max(var_293_7, arg_290_1.talkMaxDuration)

			if var_293_6 <= arg_290_1.time_ and arg_290_1.time_ < var_293_6 + var_293_14 then
				arg_290_1.typewritter.percent = (arg_290_1.time_ - var_293_6) / var_293_14

				arg_290_1.typewritter:SetDirty()
			end

			if arg_290_1.time_ >= var_293_6 + var_293_14 and arg_290_1.time_ < var_293_6 + var_293_14 + arg_293_0 then
				arg_290_1.typewritter.percent = 1

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(true)
			end
		end

		arg_290_1.nodeConfigList_ = {}

		arg_290_1:InitPlayNodeList()
	end,
	Play111161071 = function(arg_294_0, arg_294_1)
		arg_294_1.time_ = 0
		arg_294_1.frameCnt_ = 0
		arg_294_1.state_ = "playing"
		arg_294_1.curTalkId_ = 111161071
		arg_294_1.duration_ = 5

		SetActive(arg_294_1.tipsGo_, false)

		function arg_294_1.onSingleLineFinish_()
			arg_294_1.onSingleLineUpdate_ = nil
			arg_294_1.onSingleLineFinish_ = nil
			arg_294_1.state_ = "waiting"
		end

		function arg_294_1.playNext_(arg_296_0)
			if arg_296_0 == 1 then
				arg_294_0:Play111161072(arg_294_1)
			end
		end

		function arg_294_1.onSingleLineUpdate_(arg_297_0)
			local var_297_0 = 0
			local var_297_1 = 0.625

			if var_297_0 < arg_294_1.time_ and arg_294_1.time_ <= var_297_0 + arg_297_0 then
				arg_294_1.talkMaxDuration = 0
				arg_294_1.dialogCg_.alpha = 1

				arg_294_1.dialog_:SetActive(true)
				SetActive(arg_294_1.leftNameGo_, true)

				local var_297_2 = arg_294_1:FormatText(StoryNameCfg[7].name)

				arg_294_1.leftNameTxt_.text = var_297_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_294_1.leftNameTxt_.transform)

				arg_294_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_294_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_294_1:RecordName(arg_294_1.leftNameTxt_.text)
				SetActive(arg_294_1.iconTrs_.gameObject, true)
				arg_294_1.iconController_:SetSelectedState("hero")

				arg_294_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_294_1.callingController_:SetSelectedState("normal")

				arg_294_1.keyicon_.color = Color.New(1, 1, 1)
				arg_294_1.icon_.color = Color.New(1, 1, 1)

				local var_297_3 = arg_294_1:GetWordFromCfg(111161071)
				local var_297_4 = arg_294_1:FormatText(var_297_3.content)

				arg_294_1.text_.text = var_297_4

				LuaForUtil.ClearLinePrefixSymbol(arg_294_1.text_)

				local var_297_5 = 66
				local var_297_6 = utf8.len(var_297_4)
				local var_297_7 = var_297_5 <= 0 and var_297_1 or var_297_1 * (var_297_6 / var_297_5)

				if var_297_7 > 0 and var_297_1 < var_297_7 then
					arg_294_1.talkMaxDuration = var_297_7

					if var_297_7 + var_297_0 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_7 + var_297_0
					end
				end

				arg_294_1.text_.text = var_297_4
				arg_294_1.typewritter.percent = 0

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(false)
				arg_294_1:RecordContent(arg_294_1.text_.text)
			end

			local var_297_8 = math.max(var_297_1, arg_294_1.talkMaxDuration)

			if var_297_0 <= arg_294_1.time_ and arg_294_1.time_ < var_297_0 + var_297_8 then
				arg_294_1.typewritter.percent = (arg_294_1.time_ - var_297_0) / var_297_8

				arg_294_1.typewritter:SetDirty()
			end

			if arg_294_1.time_ >= var_297_0 + var_297_8 and arg_294_1.time_ < var_297_0 + var_297_8 + arg_297_0 then
				arg_294_1.typewritter.percent = 1

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(true)
			end
		end

		arg_294_1.nodeConfigList_ = {}

		arg_294_1:InitPlayNodeList()
	end,
	Play111161072 = function(arg_298_0, arg_298_1)
		arg_298_1.time_ = 0
		arg_298_1.frameCnt_ = 0
		arg_298_1.state_ = "playing"
		arg_298_1.curTalkId_ = 111161072
		arg_298_1.duration_ = 10

		local var_298_0 = {
			ja = 10,
			ko = 3.266,
			zh = 6.333,
			en = 6.033
		}
		local var_298_1 = manager.audio:GetLocalizationFlag()

		if var_298_0[var_298_1] ~= nil then
			arg_298_1.duration_ = var_298_0[var_298_1]
		end

		SetActive(arg_298_1.tipsGo_, false)

		function arg_298_1.onSingleLineFinish_()
			arg_298_1.onSingleLineUpdate_ = nil
			arg_298_1.onSingleLineFinish_ = nil
			arg_298_1.state_ = "waiting"
		end

		function arg_298_1.playNext_(arg_300_0)
			if arg_300_0 == 1 then
				arg_298_0:Play111161073(arg_298_1)
			end
		end

		function arg_298_1.onSingleLineUpdate_(arg_301_0)
			local var_301_0 = 0

			if var_301_0 < arg_298_1.time_ and arg_298_1.time_ <= var_301_0 + arg_301_0 then
				arg_298_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_301_1 = arg_298_1.actors_["1094ui_story"]
			local var_301_2 = 0

			if var_301_2 < arg_298_1.time_ and arg_298_1.time_ <= var_301_2 + arg_301_0 and not isNil(var_301_1) and arg_298_1.var_.characterEffect1094ui_story == nil then
				arg_298_1.var_.characterEffect1094ui_story = var_301_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_301_3 = 0.2

			if var_301_2 <= arg_298_1.time_ and arg_298_1.time_ < var_301_2 + var_301_3 and not isNil(var_301_1) then
				local var_301_4 = (arg_298_1.time_ - var_301_2) / var_301_3

				if arg_298_1.var_.characterEffect1094ui_story and not isNil(var_301_1) then
					arg_298_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_298_1.time_ >= var_301_2 + var_301_3 and arg_298_1.time_ < var_301_2 + var_301_3 + arg_301_0 and not isNil(var_301_1) and arg_298_1.var_.characterEffect1094ui_story then
				arg_298_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_301_5 = 0
			local var_301_6 = 0.475

			if var_301_5 < arg_298_1.time_ and arg_298_1.time_ <= var_301_5 + arg_301_0 then
				arg_298_1.talkMaxDuration = 0
				arg_298_1.dialogCg_.alpha = 1

				arg_298_1.dialog_:SetActive(true)
				SetActive(arg_298_1.leftNameGo_, true)

				local var_301_7 = arg_298_1:FormatText(StoryNameCfg[181].name)

				arg_298_1.leftNameTxt_.text = var_301_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_298_1.leftNameTxt_.transform)

				arg_298_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_298_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_298_1:RecordName(arg_298_1.leftNameTxt_.text)
				SetActive(arg_298_1.iconTrs_.gameObject, false)
				arg_298_1.callingController_:SetSelectedState("normal")

				local var_301_8 = arg_298_1:GetWordFromCfg(111161072)
				local var_301_9 = arg_298_1:FormatText(var_301_8.content)

				arg_298_1.text_.text = var_301_9

				LuaForUtil.ClearLinePrefixSymbol(arg_298_1.text_)

				local var_301_10 = 19
				local var_301_11 = utf8.len(var_301_9)
				local var_301_12 = var_301_10 <= 0 and var_301_6 or var_301_6 * (var_301_11 / var_301_10)

				if var_301_12 > 0 and var_301_6 < var_301_12 then
					arg_298_1.talkMaxDuration = var_301_12

					if var_301_12 + var_301_5 > arg_298_1.duration_ then
						arg_298_1.duration_ = var_301_12 + var_301_5
					end
				end

				arg_298_1.text_.text = var_301_9
				arg_298_1.typewritter.percent = 0

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111161", "111161072", "story_v_out_111161.awb") ~= 0 then
					local var_301_13 = manager.audio:GetVoiceLength("story_v_out_111161", "111161072", "story_v_out_111161.awb") / 1000

					if var_301_13 + var_301_5 > arg_298_1.duration_ then
						arg_298_1.duration_ = var_301_13 + var_301_5
					end

					if var_301_8.prefab_name ~= "" and arg_298_1.actors_[var_301_8.prefab_name] ~= nil then
						local var_301_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_298_1.actors_[var_301_8.prefab_name].transform, "story_v_out_111161", "111161072", "story_v_out_111161.awb")

						arg_298_1:RecordAudio("111161072", var_301_14)
						arg_298_1:RecordAudio("111161072", var_301_14)
					else
						arg_298_1:AudioAction("play", "voice", "story_v_out_111161", "111161072", "story_v_out_111161.awb")
					end

					arg_298_1:RecordHistoryTalkVoice("story_v_out_111161", "111161072", "story_v_out_111161.awb")
				end

				arg_298_1:RecordContent(arg_298_1.text_.text)
			end

			local var_301_15 = math.max(var_301_6, arg_298_1.talkMaxDuration)

			if var_301_5 <= arg_298_1.time_ and arg_298_1.time_ < var_301_5 + var_301_15 then
				arg_298_1.typewritter.percent = (arg_298_1.time_ - var_301_5) / var_301_15

				arg_298_1.typewritter:SetDirty()
			end

			if arg_298_1.time_ >= var_301_5 + var_301_15 and arg_298_1.time_ < var_301_5 + var_301_15 + arg_301_0 then
				arg_298_1.typewritter.percent = 1

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(true)
			end
		end

		arg_298_1.nodeConfigList_ = {}

		arg_298_1:InitPlayNodeList()
	end,
	Play111161073 = function(arg_302_0, arg_302_1)
		arg_302_1.time_ = 0
		arg_302_1.frameCnt_ = 0
		arg_302_1.state_ = "playing"
		arg_302_1.curTalkId_ = 111161073
		arg_302_1.duration_ = 5

		SetActive(arg_302_1.tipsGo_, false)

		function arg_302_1.onSingleLineFinish_()
			arg_302_1.onSingleLineUpdate_ = nil
			arg_302_1.onSingleLineFinish_ = nil
			arg_302_1.state_ = "waiting"
		end

		function arg_302_1.playNext_(arg_304_0)
			if arg_304_0 == 1 then
				arg_302_0:Play111161074(arg_302_1)
			end
		end

		function arg_302_1.onSingleLineUpdate_(arg_305_0)
			local var_305_0 = arg_302_1.actors_["1094ui_story"]
			local var_305_1 = 0

			if var_305_1 < arg_302_1.time_ and arg_302_1.time_ <= var_305_1 + arg_305_0 and not isNil(var_305_0) and arg_302_1.var_.characterEffect1094ui_story == nil then
				arg_302_1.var_.characterEffect1094ui_story = var_305_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_305_2 = 0.2

			if var_305_1 <= arg_302_1.time_ and arg_302_1.time_ < var_305_1 + var_305_2 and not isNil(var_305_0) then
				local var_305_3 = (arg_302_1.time_ - var_305_1) / var_305_2

				if arg_302_1.var_.characterEffect1094ui_story and not isNil(var_305_0) then
					local var_305_4 = Mathf.Lerp(0, 0.5, var_305_3)

					arg_302_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_302_1.var_.characterEffect1094ui_story.fillRatio = var_305_4
				end
			end

			if arg_302_1.time_ >= var_305_1 + var_305_2 and arg_302_1.time_ < var_305_1 + var_305_2 + arg_305_0 and not isNil(var_305_0) and arg_302_1.var_.characterEffect1094ui_story then
				local var_305_5 = 0.5

				arg_302_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_302_1.var_.characterEffect1094ui_story.fillRatio = var_305_5
			end

			local var_305_6 = 0
			local var_305_7 = 0.125

			if var_305_6 < arg_302_1.time_ and arg_302_1.time_ <= var_305_6 + arg_305_0 then
				arg_302_1.talkMaxDuration = 0
				arg_302_1.dialogCg_.alpha = 1

				arg_302_1.dialog_:SetActive(true)
				SetActive(arg_302_1.leftNameGo_, true)

				local var_305_8 = arg_302_1:FormatText(StoryNameCfg[7].name)

				arg_302_1.leftNameTxt_.text = var_305_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_302_1.leftNameTxt_.transform)

				arg_302_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_302_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_302_1:RecordName(arg_302_1.leftNameTxt_.text)
				SetActive(arg_302_1.iconTrs_.gameObject, true)
				arg_302_1.iconController_:SetSelectedState("hero")

				arg_302_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_302_1.callingController_:SetSelectedState("normal")

				arg_302_1.keyicon_.color = Color.New(1, 1, 1)
				arg_302_1.icon_.color = Color.New(1, 1, 1)

				local var_305_9 = arg_302_1:GetWordFromCfg(111161073)
				local var_305_10 = arg_302_1:FormatText(var_305_9.content)

				arg_302_1.text_.text = var_305_10

				LuaForUtil.ClearLinePrefixSymbol(arg_302_1.text_)

				local var_305_11 = 5
				local var_305_12 = utf8.len(var_305_10)
				local var_305_13 = var_305_11 <= 0 and var_305_7 or var_305_7 * (var_305_12 / var_305_11)

				if var_305_13 > 0 and var_305_7 < var_305_13 then
					arg_302_1.talkMaxDuration = var_305_13

					if var_305_13 + var_305_6 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_13 + var_305_6
					end
				end

				arg_302_1.text_.text = var_305_10
				arg_302_1.typewritter.percent = 0

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(false)
				arg_302_1:RecordContent(arg_302_1.text_.text)
			end

			local var_305_14 = math.max(var_305_7, arg_302_1.talkMaxDuration)

			if var_305_6 <= arg_302_1.time_ and arg_302_1.time_ < var_305_6 + var_305_14 then
				arg_302_1.typewritter.percent = (arg_302_1.time_ - var_305_6) / var_305_14

				arg_302_1.typewritter:SetDirty()
			end

			if arg_302_1.time_ >= var_305_6 + var_305_14 and arg_302_1.time_ < var_305_6 + var_305_14 + arg_305_0 then
				arg_302_1.typewritter.percent = 1

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(true)
			end
		end

		arg_302_1.nodeConfigList_ = {}

		arg_302_1:InitPlayNodeList()
	end,
	Play111161074 = function(arg_306_0, arg_306_1)
		arg_306_1.time_ = 0
		arg_306_1.frameCnt_ = 0
		arg_306_1.state_ = "playing"
		arg_306_1.curTalkId_ = 111161074
		arg_306_1.duration_ = 5

		SetActive(arg_306_1.tipsGo_, false)

		function arg_306_1.onSingleLineFinish_()
			arg_306_1.onSingleLineUpdate_ = nil
			arg_306_1.onSingleLineFinish_ = nil
			arg_306_1.state_ = "waiting"
		end

		function arg_306_1.playNext_(arg_308_0)
			if arg_308_0 == 1 then
				arg_306_0:Play111161075(arg_306_1)
			end
		end

		function arg_306_1.onSingleLineUpdate_(arg_309_0)
			local var_309_0 = arg_306_1.actors_["1094ui_story"].transform
			local var_309_1 = 0

			if var_309_1 < arg_306_1.time_ and arg_306_1.time_ <= var_309_1 + arg_309_0 then
				arg_306_1.var_.moveOldPos1094ui_story = var_309_0.localPosition
			end

			local var_309_2 = 0.001

			if var_309_1 <= arg_306_1.time_ and arg_306_1.time_ < var_309_1 + var_309_2 then
				local var_309_3 = (arg_306_1.time_ - var_309_1) / var_309_2
				local var_309_4 = Vector3.New(0, 100, 0)

				var_309_0.localPosition = Vector3.Lerp(arg_306_1.var_.moveOldPos1094ui_story, var_309_4, var_309_3)

				local var_309_5 = manager.ui.mainCamera.transform.position - var_309_0.position

				var_309_0.forward = Vector3.New(var_309_5.x, var_309_5.y, var_309_5.z)

				local var_309_6 = var_309_0.localEulerAngles

				var_309_6.z = 0
				var_309_6.x = 0
				var_309_0.localEulerAngles = var_309_6
			end

			if arg_306_1.time_ >= var_309_1 + var_309_2 and arg_306_1.time_ < var_309_1 + var_309_2 + arg_309_0 then
				var_309_0.localPosition = Vector3.New(0, 100, 0)

				local var_309_7 = manager.ui.mainCamera.transform.position - var_309_0.position

				var_309_0.forward = Vector3.New(var_309_7.x, var_309_7.y, var_309_7.z)

				local var_309_8 = var_309_0.localEulerAngles

				var_309_8.z = 0
				var_309_8.x = 0
				var_309_0.localEulerAngles = var_309_8
			end

			local var_309_9 = 0
			local var_309_10 = 0.675

			if var_309_9 < arg_306_1.time_ and arg_306_1.time_ <= var_309_9 + arg_309_0 then
				arg_306_1.talkMaxDuration = 0
				arg_306_1.dialogCg_.alpha = 1

				arg_306_1.dialog_:SetActive(true)
				SetActive(arg_306_1.leftNameGo_, false)

				arg_306_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_306_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_306_1:RecordName(arg_306_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_306_1.iconTrs_.gameObject, false)
				arg_306_1.callingController_:SetSelectedState("normal")

				local var_309_11 = arg_306_1:GetWordFromCfg(111161074)
				local var_309_12 = arg_306_1:FormatText(var_309_11.content)

				arg_306_1.text_.text = var_309_12

				LuaForUtil.ClearLinePrefixSymbol(arg_306_1.text_)

				local var_309_13 = 27
				local var_309_14 = utf8.len(var_309_12)
				local var_309_15 = var_309_13 <= 0 and var_309_10 or var_309_10 * (var_309_14 / var_309_13)

				if var_309_15 > 0 and var_309_10 < var_309_15 then
					arg_306_1.talkMaxDuration = var_309_15

					if var_309_15 + var_309_9 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_15 + var_309_9
					end
				end

				arg_306_1.text_.text = var_309_12
				arg_306_1.typewritter.percent = 0

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(false)
				arg_306_1:RecordContent(arg_306_1.text_.text)
			end

			local var_309_16 = math.max(var_309_10, arg_306_1.talkMaxDuration)

			if var_309_9 <= arg_306_1.time_ and arg_306_1.time_ < var_309_9 + var_309_16 then
				arg_306_1.typewritter.percent = (arg_306_1.time_ - var_309_9) / var_309_16

				arg_306_1.typewritter:SetDirty()
			end

			if arg_306_1.time_ >= var_309_9 + var_309_16 and arg_306_1.time_ < var_309_9 + var_309_16 + arg_309_0 then
				arg_306_1.typewritter.percent = 1

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(true)
			end
		end

		arg_306_1.nodeConfigList_ = {
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

		arg_306_1:InitPlayNodeList()
	end,
	Play111161075 = function(arg_310_0, arg_310_1)
		arg_310_1.time_ = 0
		arg_310_1.frameCnt_ = 0
		arg_310_1.state_ = "playing"
		arg_310_1.curTalkId_ = 111161075
		arg_310_1.duration_ = 9.93

		local var_310_0 = {
			ja = 9.933,
			ko = 2.7,
			zh = 3.2,
			en = 2
		}
		local var_310_1 = manager.audio:GetLocalizationFlag()

		if var_310_0[var_310_1] ~= nil then
			arg_310_1.duration_ = var_310_0[var_310_1]
		end

		SetActive(arg_310_1.tipsGo_, false)

		function arg_310_1.onSingleLineFinish_()
			arg_310_1.onSingleLineUpdate_ = nil
			arg_310_1.onSingleLineFinish_ = nil
			arg_310_1.state_ = "waiting"
		end

		function arg_310_1.playNext_(arg_312_0)
			if arg_312_0 == 1 then
				arg_310_0:Play111161076(arg_310_1)
			end
		end

		function arg_310_1.onSingleLineUpdate_(arg_313_0)
			local var_313_0 = 0

			if var_313_0 < arg_310_1.time_ and arg_310_1.time_ <= var_313_0 + arg_313_0 then
				arg_310_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_313_1 = arg_310_1.actors_["1094ui_story"]
			local var_313_2 = 0

			if var_313_2 < arg_310_1.time_ and arg_310_1.time_ <= var_313_2 + arg_313_0 and not isNil(var_313_1) and arg_310_1.var_.characterEffect1094ui_story == nil then
				arg_310_1.var_.characterEffect1094ui_story = var_313_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_313_3 = 0.2

			if var_313_2 <= arg_310_1.time_ and arg_310_1.time_ < var_313_2 + var_313_3 and not isNil(var_313_1) then
				local var_313_4 = (arg_310_1.time_ - var_313_2) / var_313_3

				if arg_310_1.var_.characterEffect1094ui_story and not isNil(var_313_1) then
					arg_310_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_310_1.time_ >= var_313_2 + var_313_3 and arg_310_1.time_ < var_313_2 + var_313_3 + arg_313_0 and not isNil(var_313_1) and arg_310_1.var_.characterEffect1094ui_story then
				arg_310_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_313_5 = arg_310_1.actors_["1094ui_story"].transform
			local var_313_6 = 0

			if var_313_6 < arg_310_1.time_ and arg_310_1.time_ <= var_313_6 + arg_313_0 then
				arg_310_1.var_.moveOldPos1094ui_story = var_313_5.localPosition
			end

			local var_313_7 = 0.001

			if var_313_6 <= arg_310_1.time_ and arg_310_1.time_ < var_313_6 + var_313_7 then
				local var_313_8 = (arg_310_1.time_ - var_313_6) / var_313_7
				local var_313_9 = Vector3.New(0, -0.84, -6.1)

				var_313_5.localPosition = Vector3.Lerp(arg_310_1.var_.moveOldPos1094ui_story, var_313_9, var_313_8)

				local var_313_10 = manager.ui.mainCamera.transform.position - var_313_5.position

				var_313_5.forward = Vector3.New(var_313_10.x, var_313_10.y, var_313_10.z)

				local var_313_11 = var_313_5.localEulerAngles

				var_313_11.z = 0
				var_313_11.x = 0
				var_313_5.localEulerAngles = var_313_11
			end

			if arg_310_1.time_ >= var_313_6 + var_313_7 and arg_310_1.time_ < var_313_6 + var_313_7 + arg_313_0 then
				var_313_5.localPosition = Vector3.New(0, -0.84, -6.1)

				local var_313_12 = manager.ui.mainCamera.transform.position - var_313_5.position

				var_313_5.forward = Vector3.New(var_313_12.x, var_313_12.y, var_313_12.z)

				local var_313_13 = var_313_5.localEulerAngles

				var_313_13.z = 0
				var_313_13.x = 0
				var_313_5.localEulerAngles = var_313_13
			end

			local var_313_14 = 0

			if var_313_14 < arg_310_1.time_ and arg_310_1.time_ <= var_313_14 + arg_313_0 then
				arg_310_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action1_1")
			end

			local var_313_15 = 0
			local var_313_16 = 0.325

			if var_313_15 < arg_310_1.time_ and arg_310_1.time_ <= var_313_15 + arg_313_0 then
				arg_310_1.talkMaxDuration = 0
				arg_310_1.dialogCg_.alpha = 1

				arg_310_1.dialog_:SetActive(true)
				SetActive(arg_310_1.leftNameGo_, true)

				local var_313_17 = arg_310_1:FormatText(StoryNameCfg[181].name)

				arg_310_1.leftNameTxt_.text = var_313_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_310_1.leftNameTxt_.transform)

				arg_310_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_310_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_310_1:RecordName(arg_310_1.leftNameTxt_.text)
				SetActive(arg_310_1.iconTrs_.gameObject, false)
				arg_310_1.callingController_:SetSelectedState("normal")

				local var_313_18 = arg_310_1:GetWordFromCfg(111161075)
				local var_313_19 = arg_310_1:FormatText(var_313_18.content)

				arg_310_1.text_.text = var_313_19

				LuaForUtil.ClearLinePrefixSymbol(arg_310_1.text_)

				local var_313_20 = 13
				local var_313_21 = utf8.len(var_313_19)
				local var_313_22 = var_313_20 <= 0 and var_313_16 or var_313_16 * (var_313_21 / var_313_20)

				if var_313_22 > 0 and var_313_16 < var_313_22 then
					arg_310_1.talkMaxDuration = var_313_22

					if var_313_22 + var_313_15 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_22 + var_313_15
					end
				end

				arg_310_1.text_.text = var_313_19
				arg_310_1.typewritter.percent = 0

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111161", "111161075", "story_v_out_111161.awb") ~= 0 then
					local var_313_23 = manager.audio:GetVoiceLength("story_v_out_111161", "111161075", "story_v_out_111161.awb") / 1000

					if var_313_23 + var_313_15 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_23 + var_313_15
					end

					if var_313_18.prefab_name ~= "" and arg_310_1.actors_[var_313_18.prefab_name] ~= nil then
						local var_313_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_310_1.actors_[var_313_18.prefab_name].transform, "story_v_out_111161", "111161075", "story_v_out_111161.awb")

						arg_310_1:RecordAudio("111161075", var_313_24)
						arg_310_1:RecordAudio("111161075", var_313_24)
					else
						arg_310_1:AudioAction("play", "voice", "story_v_out_111161", "111161075", "story_v_out_111161.awb")
					end

					arg_310_1:RecordHistoryTalkVoice("story_v_out_111161", "111161075", "story_v_out_111161.awb")
				end

				arg_310_1:RecordContent(arg_310_1.text_.text)
			end

			local var_313_25 = math.max(var_313_16, arg_310_1.talkMaxDuration)

			if var_313_15 <= arg_310_1.time_ and arg_310_1.time_ < var_313_15 + var_313_25 then
				arg_310_1.typewritter.percent = (arg_310_1.time_ - var_313_15) / var_313_25

				arg_310_1.typewritter:SetDirty()
			end

			if arg_310_1.time_ >= var_313_15 + var_313_25 and arg_310_1.time_ < var_313_15 + var_313_25 + arg_313_0 then
				arg_310_1.typewritter.percent = 1

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(true)
			end
		end

		arg_310_1.nodeConfigList_ = {
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

		arg_310_1:InitPlayNodeList()
	end,
	Play111161076 = function(arg_314_0, arg_314_1)
		arg_314_1.time_ = 0
		arg_314_1.frameCnt_ = 0
		arg_314_1.state_ = "playing"
		arg_314_1.curTalkId_ = 111161076
		arg_314_1.duration_ = 8.4

		local var_314_0 = {
			ja = 8.4,
			ko = 3.4,
			zh = 5.866,
			en = 4.066
		}
		local var_314_1 = manager.audio:GetLocalizationFlag()

		if var_314_0[var_314_1] ~= nil then
			arg_314_1.duration_ = var_314_0[var_314_1]
		end

		SetActive(arg_314_1.tipsGo_, false)

		function arg_314_1.onSingleLineFinish_()
			arg_314_1.onSingleLineUpdate_ = nil
			arg_314_1.onSingleLineFinish_ = nil
			arg_314_1.state_ = "waiting"
		end

		function arg_314_1.playNext_(arg_316_0)
			if arg_316_0 == 1 then
				arg_314_0:Play111161077(arg_314_1)
			end
		end

		function arg_314_1.onSingleLineUpdate_(arg_317_0)
			local var_317_0 = 0

			if var_317_0 < arg_314_1.time_ and arg_314_1.time_ <= var_317_0 + arg_317_0 then
				arg_314_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0204cva")
			end

			local var_317_1 = arg_314_1.actors_["1094ui_story"]
			local var_317_2 = 0

			if var_317_2 < arg_314_1.time_ and arg_314_1.time_ <= var_317_2 + arg_317_0 and not isNil(var_317_1) and arg_314_1.var_.characterEffect1094ui_story == nil then
				arg_314_1.var_.characterEffect1094ui_story = var_317_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_317_3 = 0.2

			if var_317_2 <= arg_314_1.time_ and arg_314_1.time_ < var_317_2 + var_317_3 and not isNil(var_317_1) then
				local var_317_4 = (arg_314_1.time_ - var_317_2) / var_317_3

				if arg_314_1.var_.characterEffect1094ui_story and not isNil(var_317_1) then
					arg_314_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_314_1.time_ >= var_317_2 + var_317_3 and arg_314_1.time_ < var_317_2 + var_317_3 + arg_317_0 and not isNil(var_317_1) and arg_314_1.var_.characterEffect1094ui_story then
				arg_314_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_317_5 = 0

			if var_317_5 < arg_314_1.time_ and arg_314_1.time_ <= var_317_5 + arg_317_0 then
				arg_314_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action4_1")
			end

			local var_317_6 = 0
			local var_317_7 = 0.4

			if var_317_6 < arg_314_1.time_ and arg_314_1.time_ <= var_317_6 + arg_317_0 then
				arg_314_1.talkMaxDuration = 0
				arg_314_1.dialogCg_.alpha = 1

				arg_314_1.dialog_:SetActive(true)
				SetActive(arg_314_1.leftNameGo_, true)

				local var_317_8 = arg_314_1:FormatText(StoryNameCfg[181].name)

				arg_314_1.leftNameTxt_.text = var_317_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_314_1.leftNameTxt_.transform)

				arg_314_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_314_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_314_1:RecordName(arg_314_1.leftNameTxt_.text)
				SetActive(arg_314_1.iconTrs_.gameObject, false)
				arg_314_1.callingController_:SetSelectedState("normal")

				local var_317_9 = arg_314_1:GetWordFromCfg(111161076)
				local var_317_10 = arg_314_1:FormatText(var_317_9.content)

				arg_314_1.text_.text = var_317_10

				LuaForUtil.ClearLinePrefixSymbol(arg_314_1.text_)

				local var_317_11 = 16
				local var_317_12 = utf8.len(var_317_10)
				local var_317_13 = var_317_11 <= 0 and var_317_7 or var_317_7 * (var_317_12 / var_317_11)

				if var_317_13 > 0 and var_317_7 < var_317_13 then
					arg_314_1.talkMaxDuration = var_317_13

					if var_317_13 + var_317_6 > arg_314_1.duration_ then
						arg_314_1.duration_ = var_317_13 + var_317_6
					end
				end

				arg_314_1.text_.text = var_317_10
				arg_314_1.typewritter.percent = 0

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111161", "111161076", "story_v_out_111161.awb") ~= 0 then
					local var_317_14 = manager.audio:GetVoiceLength("story_v_out_111161", "111161076", "story_v_out_111161.awb") / 1000

					if var_317_14 + var_317_6 > arg_314_1.duration_ then
						arg_314_1.duration_ = var_317_14 + var_317_6
					end

					if var_317_9.prefab_name ~= "" and arg_314_1.actors_[var_317_9.prefab_name] ~= nil then
						local var_317_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_314_1.actors_[var_317_9.prefab_name].transform, "story_v_out_111161", "111161076", "story_v_out_111161.awb")

						arg_314_1:RecordAudio("111161076", var_317_15)
						arg_314_1:RecordAudio("111161076", var_317_15)
					else
						arg_314_1:AudioAction("play", "voice", "story_v_out_111161", "111161076", "story_v_out_111161.awb")
					end

					arg_314_1:RecordHistoryTalkVoice("story_v_out_111161", "111161076", "story_v_out_111161.awb")
				end

				arg_314_1:RecordContent(arg_314_1.text_.text)
			end

			local var_317_16 = math.max(var_317_7, arg_314_1.talkMaxDuration)

			if var_317_6 <= arg_314_1.time_ and arg_314_1.time_ < var_317_6 + var_317_16 then
				arg_314_1.typewritter.percent = (arg_314_1.time_ - var_317_6) / var_317_16

				arg_314_1.typewritter:SetDirty()
			end

			if arg_314_1.time_ >= var_317_6 + var_317_16 and arg_314_1.time_ < var_317_6 + var_317_16 + arg_317_0 then
				arg_314_1.typewritter.percent = 1

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(true)
			end
		end

		arg_314_1.nodeConfigList_ = {}

		arg_314_1:InitPlayNodeList()
	end,
	Play111161077 = function(arg_318_0, arg_318_1)
		arg_318_1.time_ = 0
		arg_318_1.frameCnt_ = 0
		arg_318_1.state_ = "playing"
		arg_318_1.curTalkId_ = 111161077
		arg_318_1.duration_ = 15.93

		local var_318_0 = {
			ja = 15.933,
			ko = 4.666,
			zh = 4.8,
			en = 4.933
		}
		local var_318_1 = manager.audio:GetLocalizationFlag()

		if var_318_0[var_318_1] ~= nil then
			arg_318_1.duration_ = var_318_0[var_318_1]
		end

		SetActive(arg_318_1.tipsGo_, false)

		function arg_318_1.onSingleLineFinish_()
			arg_318_1.onSingleLineUpdate_ = nil
			arg_318_1.onSingleLineFinish_ = nil
			arg_318_1.state_ = "waiting"
		end

		function arg_318_1.playNext_(arg_320_0)
			if arg_320_0 == 1 then
				arg_318_0:Play111161078(arg_318_1)
			end
		end

		function arg_318_1.onSingleLineUpdate_(arg_321_0)
			local var_321_0 = 0

			if var_321_0 < arg_318_1.time_ and arg_318_1.time_ <= var_321_0 + arg_321_0 then
				arg_318_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_321_1 = arg_318_1.actors_["1094ui_story"]
			local var_321_2 = 0

			if var_321_2 < arg_318_1.time_ and arg_318_1.time_ <= var_321_2 + arg_321_0 and not isNil(var_321_1) and arg_318_1.var_.characterEffect1094ui_story == nil then
				arg_318_1.var_.characterEffect1094ui_story = var_321_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_321_3 = 0.2

			if var_321_2 <= arg_318_1.time_ and arg_318_1.time_ < var_321_2 + var_321_3 and not isNil(var_321_1) then
				local var_321_4 = (arg_318_1.time_ - var_321_2) / var_321_3

				if arg_318_1.var_.characterEffect1094ui_story and not isNil(var_321_1) then
					arg_318_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_318_1.time_ >= var_321_2 + var_321_3 and arg_318_1.time_ < var_321_2 + var_321_3 + arg_321_0 and not isNil(var_321_1) and arg_318_1.var_.characterEffect1094ui_story then
				arg_318_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_321_5 = 0
			local var_321_6 = 0.45

			if var_321_5 < arg_318_1.time_ and arg_318_1.time_ <= var_321_5 + arg_321_0 then
				arg_318_1.talkMaxDuration = 0
				arg_318_1.dialogCg_.alpha = 1

				arg_318_1.dialog_:SetActive(true)
				SetActive(arg_318_1.leftNameGo_, true)

				local var_321_7 = arg_318_1:FormatText(StoryNameCfg[181].name)

				arg_318_1.leftNameTxt_.text = var_321_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_318_1.leftNameTxt_.transform)

				arg_318_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_318_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_318_1:RecordName(arg_318_1.leftNameTxt_.text)
				SetActive(arg_318_1.iconTrs_.gameObject, false)
				arg_318_1.callingController_:SetSelectedState("normal")

				local var_321_8 = arg_318_1:GetWordFromCfg(111161077)
				local var_321_9 = arg_318_1:FormatText(var_321_8.content)

				arg_318_1.text_.text = var_321_9

				LuaForUtil.ClearLinePrefixSymbol(arg_318_1.text_)

				local var_321_10 = 18
				local var_321_11 = utf8.len(var_321_9)
				local var_321_12 = var_321_10 <= 0 and var_321_6 or var_321_6 * (var_321_11 / var_321_10)

				if var_321_12 > 0 and var_321_6 < var_321_12 then
					arg_318_1.talkMaxDuration = var_321_12

					if var_321_12 + var_321_5 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_12 + var_321_5
					end
				end

				arg_318_1.text_.text = var_321_9
				arg_318_1.typewritter.percent = 0

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111161", "111161077", "story_v_out_111161.awb") ~= 0 then
					local var_321_13 = manager.audio:GetVoiceLength("story_v_out_111161", "111161077", "story_v_out_111161.awb") / 1000

					if var_321_13 + var_321_5 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_13 + var_321_5
					end

					if var_321_8.prefab_name ~= "" and arg_318_1.actors_[var_321_8.prefab_name] ~= nil then
						local var_321_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_318_1.actors_[var_321_8.prefab_name].transform, "story_v_out_111161", "111161077", "story_v_out_111161.awb")

						arg_318_1:RecordAudio("111161077", var_321_14)
						arg_318_1:RecordAudio("111161077", var_321_14)
					else
						arg_318_1:AudioAction("play", "voice", "story_v_out_111161", "111161077", "story_v_out_111161.awb")
					end

					arg_318_1:RecordHistoryTalkVoice("story_v_out_111161", "111161077", "story_v_out_111161.awb")
				end

				arg_318_1:RecordContent(arg_318_1.text_.text)
			end

			local var_321_15 = math.max(var_321_6, arg_318_1.talkMaxDuration)

			if var_321_5 <= arg_318_1.time_ and arg_318_1.time_ < var_321_5 + var_321_15 then
				arg_318_1.typewritter.percent = (arg_318_1.time_ - var_321_5) / var_321_15

				arg_318_1.typewritter:SetDirty()
			end

			if arg_318_1.time_ >= var_321_5 + var_321_15 and arg_318_1.time_ < var_321_5 + var_321_15 + arg_321_0 then
				arg_318_1.typewritter.percent = 1

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(true)
			end
		end

		arg_318_1.nodeConfigList_ = {}

		arg_318_1:InitPlayNodeList()
	end,
	Play111161078 = function(arg_322_0, arg_322_1)
		arg_322_1.time_ = 0
		arg_322_1.frameCnt_ = 0
		arg_322_1.state_ = "playing"
		arg_322_1.curTalkId_ = 111161078
		arg_322_1.duration_ = 12.53

		local var_322_0 = {
			ja = 12.533,
			ko = 2.533,
			zh = 3.6,
			en = 1.999999999999
		}
		local var_322_1 = manager.audio:GetLocalizationFlag()

		if var_322_0[var_322_1] ~= nil then
			arg_322_1.duration_ = var_322_0[var_322_1]
		end

		SetActive(arg_322_1.tipsGo_, false)

		function arg_322_1.onSingleLineFinish_()
			arg_322_1.onSingleLineUpdate_ = nil
			arg_322_1.onSingleLineFinish_ = nil
			arg_322_1.state_ = "waiting"
		end

		function arg_322_1.playNext_(arg_324_0)
			if arg_324_0 == 1 then
				arg_322_0:Play111161079(arg_322_1)
			end
		end

		function arg_322_1.onSingleLineUpdate_(arg_325_0)
			local var_325_0 = 0

			if var_325_0 < arg_322_1.time_ and arg_322_1.time_ <= var_325_0 + arg_325_0 then
				arg_322_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_325_1 = arg_322_1.actors_["1094ui_story"]
			local var_325_2 = 0

			if var_325_2 < arg_322_1.time_ and arg_322_1.time_ <= var_325_2 + arg_325_0 and not isNil(var_325_1) and arg_322_1.var_.characterEffect1094ui_story == nil then
				arg_322_1.var_.characterEffect1094ui_story = var_325_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_325_3 = 0.2

			if var_325_2 <= arg_322_1.time_ and arg_322_1.time_ < var_325_2 + var_325_3 and not isNil(var_325_1) then
				local var_325_4 = (arg_322_1.time_ - var_325_2) / var_325_3

				if arg_322_1.var_.characterEffect1094ui_story and not isNil(var_325_1) then
					arg_322_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_322_1.time_ >= var_325_2 + var_325_3 and arg_322_1.time_ < var_325_2 + var_325_3 + arg_325_0 and not isNil(var_325_1) and arg_322_1.var_.characterEffect1094ui_story then
				arg_322_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_325_5 = 0
			local var_325_6 = 0.15

			if var_325_5 < arg_322_1.time_ and arg_322_1.time_ <= var_325_5 + arg_325_0 then
				arg_322_1.talkMaxDuration = 0
				arg_322_1.dialogCg_.alpha = 1

				arg_322_1.dialog_:SetActive(true)
				SetActive(arg_322_1.leftNameGo_, true)

				local var_325_7 = arg_322_1:FormatText(StoryNameCfg[181].name)

				arg_322_1.leftNameTxt_.text = var_325_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_322_1.leftNameTxt_.transform)

				arg_322_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_322_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_322_1:RecordName(arg_322_1.leftNameTxt_.text)
				SetActive(arg_322_1.iconTrs_.gameObject, false)
				arg_322_1.callingController_:SetSelectedState("normal")

				local var_325_8 = arg_322_1:GetWordFromCfg(111161078)
				local var_325_9 = arg_322_1:FormatText(var_325_8.content)

				arg_322_1.text_.text = var_325_9

				LuaForUtil.ClearLinePrefixSymbol(arg_322_1.text_)

				local var_325_10 = 6
				local var_325_11 = utf8.len(var_325_9)
				local var_325_12 = var_325_10 <= 0 and var_325_6 or var_325_6 * (var_325_11 / var_325_10)

				if var_325_12 > 0 and var_325_6 < var_325_12 then
					arg_322_1.talkMaxDuration = var_325_12

					if var_325_12 + var_325_5 > arg_322_1.duration_ then
						arg_322_1.duration_ = var_325_12 + var_325_5
					end
				end

				arg_322_1.text_.text = var_325_9
				arg_322_1.typewritter.percent = 0

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111161", "111161078", "story_v_out_111161.awb") ~= 0 then
					local var_325_13 = manager.audio:GetVoiceLength("story_v_out_111161", "111161078", "story_v_out_111161.awb") / 1000

					if var_325_13 + var_325_5 > arg_322_1.duration_ then
						arg_322_1.duration_ = var_325_13 + var_325_5
					end

					if var_325_8.prefab_name ~= "" and arg_322_1.actors_[var_325_8.prefab_name] ~= nil then
						local var_325_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_322_1.actors_[var_325_8.prefab_name].transform, "story_v_out_111161", "111161078", "story_v_out_111161.awb")

						arg_322_1:RecordAudio("111161078", var_325_14)
						arg_322_1:RecordAudio("111161078", var_325_14)
					else
						arg_322_1:AudioAction("play", "voice", "story_v_out_111161", "111161078", "story_v_out_111161.awb")
					end

					arg_322_1:RecordHistoryTalkVoice("story_v_out_111161", "111161078", "story_v_out_111161.awb")
				end

				arg_322_1:RecordContent(arg_322_1.text_.text)
			end

			local var_325_15 = math.max(var_325_6, arg_322_1.talkMaxDuration)

			if var_325_5 <= arg_322_1.time_ and arg_322_1.time_ < var_325_5 + var_325_15 then
				arg_322_1.typewritter.percent = (arg_322_1.time_ - var_325_5) / var_325_15

				arg_322_1.typewritter:SetDirty()
			end

			if arg_322_1.time_ >= var_325_5 + var_325_15 and arg_322_1.time_ < var_325_5 + var_325_15 + arg_325_0 then
				arg_322_1.typewritter.percent = 1

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(true)
			end
		end

		arg_322_1.nodeConfigList_ = {}

		arg_322_1:InitPlayNodeList()
	end,
	Play111161079 = function(arg_326_0, arg_326_1)
		arg_326_1.time_ = 0
		arg_326_1.frameCnt_ = 0
		arg_326_1.state_ = "playing"
		arg_326_1.curTalkId_ = 111161079
		arg_326_1.duration_ = 11.77

		local var_326_0 = {
			ja = 11.766,
			ko = 4.8,
			zh = 5.9,
			en = 5.4
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
				arg_326_0:Play111161080(arg_326_1)
			end
		end

		function arg_326_1.onSingleLineUpdate_(arg_329_0)
			local var_329_0 = arg_326_1.actors_["1094ui_story"].transform
			local var_329_1 = 0

			if var_329_1 < arg_326_1.time_ and arg_326_1.time_ <= var_329_1 + arg_329_0 then
				arg_326_1.var_.moveOldPos1094ui_story = var_329_0.localPosition
			end

			local var_329_2 = 0.001

			if var_329_1 <= arg_326_1.time_ and arg_326_1.time_ < var_329_1 + var_329_2 then
				local var_329_3 = (arg_326_1.time_ - var_329_1) / var_329_2
				local var_329_4 = Vector3.New(0, 100, 0)

				var_329_0.localPosition = Vector3.Lerp(arg_326_1.var_.moveOldPos1094ui_story, var_329_4, var_329_3)

				local var_329_5 = manager.ui.mainCamera.transform.position - var_329_0.position

				var_329_0.forward = Vector3.New(var_329_5.x, var_329_5.y, var_329_5.z)

				local var_329_6 = var_329_0.localEulerAngles

				var_329_6.z = 0
				var_329_6.x = 0
				var_329_0.localEulerAngles = var_329_6
			end

			if arg_326_1.time_ >= var_329_1 + var_329_2 and arg_326_1.time_ < var_329_1 + var_329_2 + arg_329_0 then
				var_329_0.localPosition = Vector3.New(0, 100, 0)

				local var_329_7 = manager.ui.mainCamera.transform.position - var_329_0.position

				var_329_0.forward = Vector3.New(var_329_7.x, var_329_7.y, var_329_7.z)

				local var_329_8 = var_329_0.localEulerAngles

				var_329_8.z = 0
				var_329_8.x = 0
				var_329_0.localEulerAngles = var_329_8
			end

			local var_329_9 = 0
			local var_329_10 = 0.425

			if var_329_9 < arg_326_1.time_ and arg_326_1.time_ <= var_329_9 + arg_329_0 then
				arg_326_1.talkMaxDuration = 0
				arg_326_1.dialogCg_.alpha = 1

				arg_326_1.dialog_:SetActive(true)
				SetActive(arg_326_1.leftNameGo_, true)

				local var_329_11 = arg_326_1:FormatText(StoryNameCfg[178].name)

				arg_326_1.leftNameTxt_.text = var_329_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_326_1.leftNameTxt_.transform)

				arg_326_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_326_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_326_1:RecordName(arg_326_1.leftNameTxt_.text)
				SetActive(arg_326_1.iconTrs_.gameObject, true)
				arg_326_1.iconController_:SetSelectedState("hero")

				arg_326_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_heidie")

				arg_326_1.callingController_:SetSelectedState("normal")

				arg_326_1.keyicon_.color = Color.New(1, 1, 1)
				arg_326_1.icon_.color = Color.New(1, 1, 1)

				local var_329_12 = arg_326_1:GetWordFromCfg(111161079)
				local var_329_13 = arg_326_1:FormatText(var_329_12.content)

				arg_326_1.text_.text = var_329_13

				LuaForUtil.ClearLinePrefixSymbol(arg_326_1.text_)

				local var_329_14 = 17
				local var_329_15 = utf8.len(var_329_13)
				local var_329_16 = var_329_14 <= 0 and var_329_10 or var_329_10 * (var_329_15 / var_329_14)

				if var_329_16 > 0 and var_329_10 < var_329_16 then
					arg_326_1.talkMaxDuration = var_329_16

					if var_329_16 + var_329_9 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_16 + var_329_9
					end
				end

				arg_326_1.text_.text = var_329_13
				arg_326_1.typewritter.percent = 0

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111161", "111161079", "story_v_out_111161.awb") ~= 0 then
					local var_329_17 = manager.audio:GetVoiceLength("story_v_out_111161", "111161079", "story_v_out_111161.awb") / 1000

					if var_329_17 + var_329_9 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_17 + var_329_9
					end

					if var_329_12.prefab_name ~= "" and arg_326_1.actors_[var_329_12.prefab_name] ~= nil then
						local var_329_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_326_1.actors_[var_329_12.prefab_name].transform, "story_v_out_111161", "111161079", "story_v_out_111161.awb")

						arg_326_1:RecordAudio("111161079", var_329_18)
						arg_326_1:RecordAudio("111161079", var_329_18)
					else
						arg_326_1:AudioAction("play", "voice", "story_v_out_111161", "111161079", "story_v_out_111161.awb")
					end

					arg_326_1:RecordHistoryTalkVoice("story_v_out_111161", "111161079", "story_v_out_111161.awb")
				end

				arg_326_1:RecordContent(arg_326_1.text_.text)
			end

			local var_329_19 = math.max(var_329_10, arg_326_1.talkMaxDuration)

			if var_329_9 <= arg_326_1.time_ and arg_326_1.time_ < var_329_9 + var_329_19 then
				arg_326_1.typewritter.percent = (arg_326_1.time_ - var_329_9) / var_329_19

				arg_326_1.typewritter:SetDirty()
			end

			if arg_326_1.time_ >= var_329_9 + var_329_19 and arg_326_1.time_ < var_329_9 + var_329_19 + arg_329_0 then
				arg_326_1.typewritter.percent = 1

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(true)
			end
		end

		arg_326_1.nodeConfigList_ = {
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

		arg_326_1:InitPlayNodeList()
	end,
	Play111161080 = function(arg_330_0, arg_330_1)
		arg_330_1.time_ = 0
		arg_330_1.frameCnt_ = 0
		arg_330_1.state_ = "playing"
		arg_330_1.curTalkId_ = 111161080
		arg_330_1.duration_ = 5

		SetActive(arg_330_1.tipsGo_, false)

		function arg_330_1.onSingleLineFinish_()
			arg_330_1.onSingleLineUpdate_ = nil
			arg_330_1.onSingleLineFinish_ = nil
			arg_330_1.state_ = "waiting"
		end

		function arg_330_1.playNext_(arg_332_0)
			if arg_332_0 == 1 then
				arg_330_0:Play111161081(arg_330_1)
			end
		end

		function arg_330_1.onSingleLineUpdate_(arg_333_0)
			local var_333_0 = 0
			local var_333_1 = 0.55

			if var_333_0 < arg_330_1.time_ and arg_330_1.time_ <= var_333_0 + arg_333_0 then
				arg_330_1.talkMaxDuration = 0
				arg_330_1.dialogCg_.alpha = 1

				arg_330_1.dialog_:SetActive(true)
				SetActive(arg_330_1.leftNameGo_, false)

				arg_330_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_330_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_330_1:RecordName(arg_330_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_330_1.iconTrs_.gameObject, false)
				arg_330_1.callingController_:SetSelectedState("normal")

				local var_333_2 = arg_330_1:GetWordFromCfg(111161080)
				local var_333_3 = arg_330_1:FormatText(var_333_2.content)

				arg_330_1.text_.text = var_333_3

				LuaForUtil.ClearLinePrefixSymbol(arg_330_1.text_)

				local var_333_4 = 22
				local var_333_5 = utf8.len(var_333_3)
				local var_333_6 = var_333_4 <= 0 and var_333_1 or var_333_1 * (var_333_5 / var_333_4)

				if var_333_6 > 0 and var_333_1 < var_333_6 then
					arg_330_1.talkMaxDuration = var_333_6

					if var_333_6 + var_333_0 > arg_330_1.duration_ then
						arg_330_1.duration_ = var_333_6 + var_333_0
					end
				end

				arg_330_1.text_.text = var_333_3
				arg_330_1.typewritter.percent = 0

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(false)
				arg_330_1:RecordContent(arg_330_1.text_.text)
			end

			local var_333_7 = math.max(var_333_1, arg_330_1.talkMaxDuration)

			if var_333_0 <= arg_330_1.time_ and arg_330_1.time_ < var_333_0 + var_333_7 then
				arg_330_1.typewritter.percent = (arg_330_1.time_ - var_333_0) / var_333_7

				arg_330_1.typewritter:SetDirty()
			end

			if arg_330_1.time_ >= var_333_0 + var_333_7 and arg_330_1.time_ < var_333_0 + var_333_7 + arg_333_0 then
				arg_330_1.typewritter.percent = 1

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(true)
			end
		end

		arg_330_1.nodeConfigList_ = {}

		arg_330_1:InitPlayNodeList()
	end,
	Play111161081 = function(arg_334_0, arg_334_1)
		arg_334_1.time_ = 0
		arg_334_1.frameCnt_ = 0
		arg_334_1.state_ = "playing"
		arg_334_1.curTalkId_ = 111161081
		arg_334_1.duration_ = 5

		SetActive(arg_334_1.tipsGo_, false)

		function arg_334_1.onSingleLineFinish_()
			arg_334_1.onSingleLineUpdate_ = nil
			arg_334_1.onSingleLineFinish_ = nil
			arg_334_1.state_ = "waiting"
			arg_334_1.auto_ = false
		end

		function arg_334_1.playNext_(arg_336_0)
			arg_334_1.onStoryFinished_()
		end

		function arg_334_1.onSingleLineUpdate_(arg_337_0)
			local var_337_0 = 0
			local var_337_1 = 0.45

			if var_337_0 < arg_334_1.time_ and arg_334_1.time_ <= var_337_0 + arg_337_0 then
				arg_334_1.talkMaxDuration = 0
				arg_334_1.dialogCg_.alpha = 1

				arg_334_1.dialog_:SetActive(true)
				SetActive(arg_334_1.leftNameGo_, false)

				arg_334_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_334_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_334_1:RecordName(arg_334_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_334_1.iconTrs_.gameObject, false)
				arg_334_1.callingController_:SetSelectedState("normal")

				local var_337_2 = arg_334_1:GetWordFromCfg(111161081)
				local var_337_3 = arg_334_1:FormatText(var_337_2.content)

				arg_334_1.text_.text = var_337_3

				LuaForUtil.ClearLinePrefixSymbol(arg_334_1.text_)

				local var_337_4 = 18
				local var_337_5 = utf8.len(var_337_3)
				local var_337_6 = var_337_4 <= 0 and var_337_1 or var_337_1 * (var_337_5 / var_337_4)

				if var_337_6 > 0 and var_337_1 < var_337_6 then
					arg_334_1.talkMaxDuration = var_337_6

					if var_337_6 + var_337_0 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_6 + var_337_0
					end
				end

				arg_334_1.text_.text = var_337_3
				arg_334_1.typewritter.percent = 0

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(false)
				arg_334_1:RecordContent(arg_334_1.text_.text)
			end

			local var_337_7 = math.max(var_337_1, arg_334_1.talkMaxDuration)

			if var_337_0 <= arg_334_1.time_ and arg_334_1.time_ < var_337_0 + var_337_7 then
				arg_334_1.typewritter.percent = (arg_334_1.time_ - var_337_0) / var_337_7

				arg_334_1.typewritter:SetDirty()
			end

			if arg_334_1.time_ >= var_337_0 + var_337_7 and arg_334_1.time_ < var_337_0 + var_337_7 + arg_337_0 then
				arg_334_1.typewritter.percent = 1

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(true)
			end
		end

		arg_334_1.nodeConfigList_ = {}

		arg_334_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/D11",
		"TextureConfig/Background/AS0107",
		"TextureConfig/Background/AS0106",
		"TextureConfig/Background/D09a",
		"TextureConfig/Background/D999"
	},
	voices = {
		"story_v_out_111161.awb"
	}
}
