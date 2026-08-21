return {
	Play414121001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 414121001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play414121002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "ST15"

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
				local var_4_5 = arg_1_1.bgs_.ST15

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
					if iter_4_0 ~= "ST15" then
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
			local var_4_23 = 0.266666666666667

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

			local var_4_28 = 0.366666666666667
			local var_4_29 = 0.833333333333333

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				local var_4_30 = "play"
				local var_4_31 = "music"

				arg_1_1:AudioAction(var_4_30, var_4_31, "bgm_activity_1_2_summer1_story_intense", "bgm_activity_1_2_summer1_story_intense", "bgm_activity_1_2_summer1_story_intense.awb")

				local var_4_32 = ""
				local var_4_33 = manager.audio:GetAudioName("bgm_activity_1_2_summer1_story_intense", "bgm_activity_1_2_summer1_story_intense")

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

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_37 = arg_1_1:FormatText(StoryNameCfg[978].name)

				arg_1_1.leftNameTxt_.text = var_4_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenma")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_38 = arg_1_1:GetWordFromCfg(414121001)
				local var_4_39 = arg_1_1:FormatText(var_4_38.content)

				arg_1_1.text_.text = var_4_39

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_40 = 14
				local var_4_41 = utf8.len(var_4_39)
				local var_4_42 = var_4_40 <= 0 and var_4_35 or var_4_35 * (var_4_41 / var_4_40)

				if var_4_42 > 0 and var_4_35 < var_4_42 then
					arg_1_1.talkMaxDuration = var_4_42
					var_4_34 = var_4_34 + 0.3

					if var_4_42 + var_4_34 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_42 + var_4_34
					end
				end

				arg_1_1.text_.text = var_4_39
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_43 = var_4_34 + 0.3
			local var_4_44 = math.max(var_4_35, arg_1_1.talkMaxDuration)

			if var_4_43 <= arg_1_1.time_ and arg_1_1.time_ < var_4_43 + var_4_44 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_43) / var_4_44

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_43 + var_4_44 and arg_1_1.time_ < var_4_43 + var_4_44 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play414121002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 414121002
		arg_9_1.duration_ = 5.3

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play414121003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = manager.ui.mainCamera.transform
			local var_12_1 = 0.0333333333333333

			if var_12_1 < arg_9_1.time_ and arg_9_1.time_ <= var_12_1 + arg_12_0 then
				arg_9_1.var_.shakeOldPos = var_12_0.localPosition
			end

			local var_12_2 = 0.6

			if var_12_1 <= arg_9_1.time_ and arg_9_1.time_ < var_12_1 + var_12_2 then
				local var_12_3 = (arg_9_1.time_ - var_12_1) / 0.066
				local var_12_4, var_12_5 = math.modf(var_12_3)

				var_12_0.localPosition = Vector3.New(var_12_5 * 0.13, var_12_5 * 0.13, var_12_5 * 0.13) + arg_9_1.var_.shakeOldPos
			end

			if arg_9_1.time_ >= var_12_1 + var_12_2 and arg_9_1.time_ < var_12_1 + var_12_2 + arg_12_0 then
				var_12_0.localPosition = arg_9_1.var_.shakeOldPos
			end

			if arg_9_1.frameCnt_ <= 1 then
				arg_9_1.dialog_:SetActive(false)
			end

			local var_12_6 = 0.3
			local var_12_7 = 0.15

			if var_12_6 < arg_9_1.time_ and arg_9_1.time_ <= var_12_6 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0

				arg_9_1.dialog_:SetActive(true)

				arg_9_1.dialogCg_.alpha = 0

				local var_12_8 = LeanTween.value(arg_9_1.dialog_, 0, 1, 0.3)

				var_12_8:setOnUpdate(LuaHelper.FloatAction(function(arg_13_0)
					arg_9_1.dialogCg_.alpha = arg_13_0
				end))
				var_12_8:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_9_1.dialog_)
					var_12_8:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_9_1.duration_ = arg_9_1.duration_ + 0.3

				SetActive(arg_9_1.leftNameGo_, true)

				local var_12_9 = arg_9_1:FormatText(StoryNameCfg[982].name)

				arg_9_1.leftNameTxt_.text = var_12_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_10 = arg_9_1:GetWordFromCfg(414121002)
				local var_12_11 = arg_9_1:FormatText(var_12_10.content)

				arg_9_1.text_.text = var_12_11

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_12 = 6
				local var_12_13 = utf8.len(var_12_11)
				local var_12_14 = var_12_12 <= 0 and var_12_7 or var_12_7 * (var_12_13 / var_12_12)

				if var_12_14 > 0 and var_12_7 < var_12_14 then
					arg_9_1.talkMaxDuration = var_12_14
					var_12_6 = var_12_6 + 0.3

					if var_12_14 + var_12_6 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_14 + var_12_6
					end
				end

				arg_9_1.text_.text = var_12_11
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_15 = var_12_6 + 0.3
			local var_12_16 = math.max(var_12_7, arg_9_1.talkMaxDuration)

			if var_12_15 <= arg_9_1.time_ and arg_9_1.time_ < var_12_15 + var_12_16 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_15) / var_12_16

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_15 + var_12_16 and arg_9_1.time_ < var_12_15 + var_12_16 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play414121003 = function(arg_15_0, arg_15_1)
		arg_15_1.time_ = 0
		arg_15_1.frameCnt_ = 0
		arg_15_1.state_ = "playing"
		arg_15_1.curTalkId_ = 414121003
		arg_15_1.duration_ = 5

		SetActive(arg_15_1.tipsGo_, false)

		function arg_15_1.onSingleLineFinish_()
			arg_15_1.onSingleLineUpdate_ = nil
			arg_15_1.onSingleLineFinish_ = nil
			arg_15_1.state_ = "waiting"
		end

		function arg_15_1.playNext_(arg_17_0)
			if arg_17_0 == 1 then
				arg_15_0:Play414121004(arg_15_1)
			end
		end

		function arg_15_1.onSingleLineUpdate_(arg_18_0)
			local var_18_0 = 0
			local var_18_1 = 1

			if var_18_0 < arg_15_1.time_ and arg_15_1.time_ <= var_18_0 + arg_18_0 then
				local var_18_2 = "play"
				local var_18_3 = "effect"

				arg_15_1:AudioAction(var_18_2, var_18_3, "se_story_128", "se_story_128_cheer", "")
			end

			local var_18_4 = 0
			local var_18_5 = 0.925

			if var_18_4 < arg_15_1.time_ and arg_15_1.time_ <= var_18_4 + arg_18_0 then
				arg_15_1.talkMaxDuration = 0
				arg_15_1.dialogCg_.alpha = 1

				arg_15_1.dialog_:SetActive(true)
				SetActive(arg_15_1.leftNameGo_, true)

				local var_18_6 = arg_15_1:FormatText(StoryNameCfg[978].name)

				arg_15_1.leftNameTxt_.text = var_18_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_15_1.leftNameTxt_.transform)

				arg_15_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_15_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_15_1:RecordName(arg_15_1.leftNameTxt_.text)
				SetActive(arg_15_1.iconTrs_.gameObject, true)
				arg_15_1.iconController_:SetSelectedState("hero")

				arg_15_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenma")

				arg_15_1.callingController_:SetSelectedState("normal")

				arg_15_1.keyicon_.color = Color.New(1, 1, 1)
				arg_15_1.icon_.color = Color.New(1, 1, 1)

				local var_18_7 = arg_15_1:GetWordFromCfg(414121003)
				local var_18_8 = arg_15_1:FormatText(var_18_7.content)

				arg_15_1.text_.text = var_18_8

				LuaForUtil.ClearLinePrefixSymbol(arg_15_1.text_)

				local var_18_9 = 37
				local var_18_10 = utf8.len(var_18_8)
				local var_18_11 = var_18_9 <= 0 and var_18_5 or var_18_5 * (var_18_10 / var_18_9)

				if var_18_11 > 0 and var_18_5 < var_18_11 then
					arg_15_1.talkMaxDuration = var_18_11

					if var_18_11 + var_18_4 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_11 + var_18_4
					end
				end

				arg_15_1.text_.text = var_18_8
				arg_15_1.typewritter.percent = 0

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(false)
				arg_15_1:RecordContent(arg_15_1.text_.text)
			end

			local var_18_12 = math.max(var_18_5, arg_15_1.talkMaxDuration)

			if var_18_4 <= arg_15_1.time_ and arg_15_1.time_ < var_18_4 + var_18_12 then
				arg_15_1.typewritter.percent = (arg_15_1.time_ - var_18_4) / var_18_12

				arg_15_1.typewritter:SetDirty()
			end

			if arg_15_1.time_ >= var_18_4 + var_18_12 and arg_15_1.time_ < var_18_4 + var_18_12 + arg_18_0 then
				arg_15_1.typewritter.percent = 1

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(true)
			end
		end

		arg_15_1.nodeConfigList_ = {}

		arg_15_1:InitPlayNodeList()
	end,
	Play414121004 = function(arg_19_0, arg_19_1)
		arg_19_1.time_ = 0
		arg_19_1.frameCnt_ = 0
		arg_19_1.state_ = "playing"
		arg_19_1.curTalkId_ = 414121004
		arg_19_1.duration_ = 5

		SetActive(arg_19_1.tipsGo_, false)

		function arg_19_1.onSingleLineFinish_()
			arg_19_1.onSingleLineUpdate_ = nil
			arg_19_1.onSingleLineFinish_ = nil
			arg_19_1.state_ = "waiting"
		end

		function arg_19_1.playNext_(arg_21_0)
			if arg_21_0 == 1 then
				arg_19_0:Play414121005(arg_19_1)
			end
		end

		function arg_19_1.onSingleLineUpdate_(arg_22_0)
			local var_22_0 = 0
			local var_22_1 = 0.875

			if var_22_0 < arg_19_1.time_ and arg_19_1.time_ <= var_22_0 + arg_22_0 then
				arg_19_1.talkMaxDuration = 0
				arg_19_1.dialogCg_.alpha = 1

				arg_19_1.dialog_:SetActive(true)
				SetActive(arg_19_1.leftNameGo_, false)

				arg_19_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_19_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_19_1:RecordName(arg_19_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_19_1.iconTrs_.gameObject, false)
				arg_19_1.callingController_:SetSelectedState("normal")

				local var_22_2 = arg_19_1:GetWordFromCfg(414121004)
				local var_22_3 = arg_19_1:FormatText(var_22_2.content)

				arg_19_1.text_.text = var_22_3

				LuaForUtil.ClearLinePrefixSymbol(arg_19_1.text_)

				local var_22_4 = 35
				local var_22_5 = utf8.len(var_22_3)
				local var_22_6 = var_22_4 <= 0 and var_22_1 or var_22_1 * (var_22_5 / var_22_4)

				if var_22_6 > 0 and var_22_1 < var_22_6 then
					arg_19_1.talkMaxDuration = var_22_6

					if var_22_6 + var_22_0 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_6 + var_22_0
					end
				end

				arg_19_1.text_.text = var_22_3
				arg_19_1.typewritter.percent = 0

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(false)
				arg_19_1:RecordContent(arg_19_1.text_.text)
			end

			local var_22_7 = math.max(var_22_1, arg_19_1.talkMaxDuration)

			if var_22_0 <= arg_19_1.time_ and arg_19_1.time_ < var_22_0 + var_22_7 then
				arg_19_1.typewritter.percent = (arg_19_1.time_ - var_22_0) / var_22_7

				arg_19_1.typewritter:SetDirty()
			end

			if arg_19_1.time_ >= var_22_0 + var_22_7 and arg_19_1.time_ < var_22_0 + var_22_7 + arg_22_0 then
				arg_19_1.typewritter.percent = 1

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(true)
			end
		end

		arg_19_1.nodeConfigList_ = {}

		arg_19_1:InitPlayNodeList()
	end,
	Play414121005 = function(arg_23_0, arg_23_1)
		arg_23_1.time_ = 0
		arg_23_1.frameCnt_ = 0
		arg_23_1.state_ = "playing"
		arg_23_1.curTalkId_ = 414121005
		arg_23_1.duration_ = 5

		SetActive(arg_23_1.tipsGo_, false)

		function arg_23_1.onSingleLineFinish_()
			arg_23_1.onSingleLineUpdate_ = nil
			arg_23_1.onSingleLineFinish_ = nil
			arg_23_1.state_ = "waiting"
		end

		function arg_23_1.playNext_(arg_25_0)
			if arg_25_0 == 1 then
				arg_23_0:Play414121006(arg_23_1)
			end
		end

		function arg_23_1.onSingleLineUpdate_(arg_26_0)
			local var_26_0 = "4010ui_story"

			if arg_23_1.actors_[var_26_0] == nil then
				local var_26_1 = Asset.Load("Char/" .. "4010ui_story")

				if not isNil(var_26_1) then
					local var_26_2 = Object.Instantiate(Asset.Load("Char/" .. "4010ui_story"), arg_23_1.stage_.transform)

					var_26_2.name = var_26_0
					var_26_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_23_1.actors_[var_26_0] = var_26_2

					local var_26_3 = var_26_2:GetComponentInChildren(typeof(CharacterEffect))

					var_26_3.enabled = true

					local var_26_4 = GameObjectTools.GetOrAddComponent(var_26_2, typeof(DynamicBoneHelper))

					if var_26_4 then
						var_26_4:EnableDynamicBone(false)
					end

					arg_23_1:ShowWeapon(var_26_3.transform, false)

					arg_23_1.var_[var_26_0 .. "Animator"] = var_26_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_23_1.var_[var_26_0 .. "Animator"].applyRootMotion = true
					arg_23_1.var_[var_26_0 .. "LipSync"] = var_26_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_26_5 = arg_23_1.actors_["4010ui_story"].transform
			local var_26_6 = 0

			if var_26_6 < arg_23_1.time_ and arg_23_1.time_ <= var_26_6 + arg_26_0 then
				arg_23_1.var_.moveOldPos4010ui_story = var_26_5.localPosition
			end

			local var_26_7 = 0.001

			if var_26_6 <= arg_23_1.time_ and arg_23_1.time_ < var_26_6 + var_26_7 then
				local var_26_8 = (arg_23_1.time_ - var_26_6) / var_26_7
				local var_26_9 = Vector3.New(0, -1.59, -5.2)

				var_26_5.localPosition = Vector3.Lerp(arg_23_1.var_.moveOldPos4010ui_story, var_26_9, var_26_8)

				local var_26_10 = manager.ui.mainCamera.transform.position - var_26_5.position

				var_26_5.forward = Vector3.New(var_26_10.x, var_26_10.y, var_26_10.z)

				local var_26_11 = var_26_5.localEulerAngles

				var_26_11.z = 0
				var_26_11.x = 0
				var_26_5.localEulerAngles = var_26_11
			end

			if arg_23_1.time_ >= var_26_6 + var_26_7 and arg_23_1.time_ < var_26_6 + var_26_7 + arg_26_0 then
				var_26_5.localPosition = Vector3.New(0, -1.59, -5.2)

				local var_26_12 = manager.ui.mainCamera.transform.position - var_26_5.position

				var_26_5.forward = Vector3.New(var_26_12.x, var_26_12.y, var_26_12.z)

				local var_26_13 = var_26_5.localEulerAngles

				var_26_13.z = 0
				var_26_13.x = 0
				var_26_5.localEulerAngles = var_26_13
			end

			local var_26_14 = arg_23_1.actors_["4010ui_story"]
			local var_26_15 = 0

			if var_26_15 < arg_23_1.time_ and arg_23_1.time_ <= var_26_15 + arg_26_0 and not isNil(var_26_14) and arg_23_1.var_.characterEffect4010ui_story == nil then
				arg_23_1.var_.characterEffect4010ui_story = var_26_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_26_16 = 0.200000002980232

			if var_26_15 <= arg_23_1.time_ and arg_23_1.time_ < var_26_15 + var_26_16 and not isNil(var_26_14) then
				local var_26_17 = (arg_23_1.time_ - var_26_15) / var_26_16

				if arg_23_1.var_.characterEffect4010ui_story and not isNil(var_26_14) then
					arg_23_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_23_1.time_ >= var_26_15 + var_26_16 and arg_23_1.time_ < var_26_15 + var_26_16 + arg_26_0 and not isNil(var_26_14) and arg_23_1.var_.characterEffect4010ui_story then
				arg_23_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_26_18 = 0

			if var_26_18 < arg_23_1.time_ and arg_23_1.time_ <= var_26_18 + arg_26_0 then
				arg_23_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action3_1")
			end

			local var_26_19 = 0

			if var_26_19 < arg_23_1.time_ and arg_23_1.time_ <= var_26_19 + arg_26_0 then
				arg_23_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_26_20 = 0
			local var_26_21 = 0.525

			if var_26_20 < arg_23_1.time_ and arg_23_1.time_ <= var_26_20 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0
				arg_23_1.dialogCg_.alpha = 1

				arg_23_1.dialog_:SetActive(true)
				SetActive(arg_23_1.leftNameGo_, true)

				local var_26_22 = arg_23_1:FormatText(StoryNameCfg[42].name)

				arg_23_1.leftNameTxt_.text = var_26_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_23_1.leftNameTxt_.transform)

				arg_23_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_23_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_23_1:RecordName(arg_23_1.leftNameTxt_.text)
				SetActive(arg_23_1.iconTrs_.gameObject, false)
				arg_23_1.callingController_:SetSelectedState("normal")

				local var_26_23 = arg_23_1:GetWordFromCfg(414121005)
				local var_26_24 = arg_23_1:FormatText(var_26_23.content)

				arg_23_1.text_.text = var_26_24

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_25 = 21
				local var_26_26 = utf8.len(var_26_24)
				local var_26_27 = var_26_25 <= 0 and var_26_21 or var_26_21 * (var_26_26 / var_26_25)

				if var_26_27 > 0 and var_26_21 < var_26_27 then
					arg_23_1.talkMaxDuration = var_26_27

					if var_26_27 + var_26_20 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_27 + var_26_20
					end
				end

				arg_23_1.text_.text = var_26_24
				arg_23_1.typewritter.percent = 0

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(false)
				arg_23_1:RecordContent(arg_23_1.text_.text)
			end

			local var_26_28 = math.max(var_26_21, arg_23_1.talkMaxDuration)

			if var_26_20 <= arg_23_1.time_ and arg_23_1.time_ < var_26_20 + var_26_28 then
				arg_23_1.typewritter.percent = (arg_23_1.time_ - var_26_20) / var_26_28

				arg_23_1.typewritter:SetDirty()
			end

			if arg_23_1.time_ >= var_26_20 + var_26_28 and arg_23_1.time_ < var_26_20 + var_26_28 + arg_26_0 then
				arg_23_1.typewritter.percent = 1

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(true)
			end
		end

		arg_23_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_23_1:InitPlayNodeList()
	end,
	Play414121006 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 414121006
		arg_27_1.duration_ = 5

		SetActive(arg_27_1.tipsGo_, false)

		function arg_27_1.onSingleLineFinish_()
			arg_27_1.onSingleLineUpdate_ = nil
			arg_27_1.onSingleLineFinish_ = nil
			arg_27_1.state_ = "waiting"
		end

		function arg_27_1.playNext_(arg_29_0)
			if arg_29_0 == 1 then
				arg_27_0:Play414121007(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			local var_30_0 = arg_27_1.actors_["4010ui_story"].transform
			local var_30_1 = 0

			if var_30_1 < arg_27_1.time_ and arg_27_1.time_ <= var_30_1 + arg_30_0 then
				arg_27_1.var_.moveOldPos4010ui_story = var_30_0.localPosition
			end

			local var_30_2 = 0.001

			if var_30_1 <= arg_27_1.time_ and arg_27_1.time_ < var_30_1 + var_30_2 then
				local var_30_3 = (arg_27_1.time_ - var_30_1) / var_30_2
				local var_30_4 = Vector3.New(0, 100, 0)

				var_30_0.localPosition = Vector3.Lerp(arg_27_1.var_.moveOldPos4010ui_story, var_30_4, var_30_3)

				local var_30_5 = manager.ui.mainCamera.transform.position - var_30_0.position

				var_30_0.forward = Vector3.New(var_30_5.x, var_30_5.y, var_30_5.z)

				local var_30_6 = var_30_0.localEulerAngles

				var_30_6.z = 0
				var_30_6.x = 0
				var_30_0.localEulerAngles = var_30_6
			end

			if arg_27_1.time_ >= var_30_1 + var_30_2 and arg_27_1.time_ < var_30_1 + var_30_2 + arg_30_0 then
				var_30_0.localPosition = Vector3.New(0, 100, 0)

				local var_30_7 = manager.ui.mainCamera.transform.position - var_30_0.position

				var_30_0.forward = Vector3.New(var_30_7.x, var_30_7.y, var_30_7.z)

				local var_30_8 = var_30_0.localEulerAngles

				var_30_8.z = 0
				var_30_8.x = 0
				var_30_0.localEulerAngles = var_30_8
			end

			local var_30_9 = arg_27_1.actors_["4010ui_story"]
			local var_30_10 = 0

			if var_30_10 < arg_27_1.time_ and arg_27_1.time_ <= var_30_10 + arg_30_0 and not isNil(var_30_9) and arg_27_1.var_.characterEffect4010ui_story == nil then
				arg_27_1.var_.characterEffect4010ui_story = var_30_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_30_11 = 0.200000002980232

			if var_30_10 <= arg_27_1.time_ and arg_27_1.time_ < var_30_10 + var_30_11 and not isNil(var_30_9) then
				local var_30_12 = (arg_27_1.time_ - var_30_10) / var_30_11

				if arg_27_1.var_.characterEffect4010ui_story and not isNil(var_30_9) then
					local var_30_13 = Mathf.Lerp(0, 0.5, var_30_12)

					arg_27_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_27_1.var_.characterEffect4010ui_story.fillRatio = var_30_13
				end
			end

			if arg_27_1.time_ >= var_30_10 + var_30_11 and arg_27_1.time_ < var_30_10 + var_30_11 + arg_30_0 and not isNil(var_30_9) and arg_27_1.var_.characterEffect4010ui_story then
				local var_30_14 = 0.5

				arg_27_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_27_1.var_.characterEffect4010ui_story.fillRatio = var_30_14
			end

			local var_30_15 = "3045ui_story"

			if arg_27_1.actors_[var_30_15] == nil then
				local var_30_16 = Asset.Load("Char/" .. "3045ui_story")

				if not isNil(var_30_16) then
					local var_30_17 = Object.Instantiate(Asset.Load("Char/" .. "3045ui_story"), arg_27_1.stage_.transform)

					var_30_17.name = var_30_15
					var_30_17.transform.localPosition = Vector3.New(0, 100, 0)
					arg_27_1.actors_[var_30_15] = var_30_17

					local var_30_18 = var_30_17:GetComponentInChildren(typeof(CharacterEffect))

					var_30_18.enabled = true

					local var_30_19 = GameObjectTools.GetOrAddComponent(var_30_17, typeof(DynamicBoneHelper))

					if var_30_19 then
						var_30_19:EnableDynamicBone(false)
					end

					arg_27_1:ShowWeapon(var_30_18.transform, false)

					arg_27_1.var_[var_30_15 .. "Animator"] = var_30_18.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_27_1.var_[var_30_15 .. "Animator"].applyRootMotion = true
					arg_27_1.var_[var_30_15 .. "LipSync"] = var_30_18.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_30_20 = arg_27_1.actors_["3045ui_story"].transform
			local var_30_21 = 0

			if var_30_21 < arg_27_1.time_ and arg_27_1.time_ <= var_30_21 + arg_30_0 then
				arg_27_1.var_.moveOldPos3045ui_story = var_30_20.localPosition

				local var_30_22 = "3045ui_story"

				arg_27_1:ShowWeapon(arg_27_1.var_[var_30_22 .. "Animator"].transform, false)
			end

			local var_30_23 = 0.001

			if var_30_21 <= arg_27_1.time_ and arg_27_1.time_ < var_30_21 + var_30_23 then
				local var_30_24 = (arg_27_1.time_ - var_30_21) / var_30_23
				local var_30_25 = Vector3.New(0, -1.75, -4.8)

				var_30_20.localPosition = Vector3.Lerp(arg_27_1.var_.moveOldPos3045ui_story, var_30_25, var_30_24)

				local var_30_26 = manager.ui.mainCamera.transform.position - var_30_20.position

				var_30_20.forward = Vector3.New(var_30_26.x, var_30_26.y, var_30_26.z)

				local var_30_27 = var_30_20.localEulerAngles

				var_30_27.z = 0
				var_30_27.x = 0
				var_30_20.localEulerAngles = var_30_27
			end

			if arg_27_1.time_ >= var_30_21 + var_30_23 and arg_27_1.time_ < var_30_21 + var_30_23 + arg_30_0 then
				var_30_20.localPosition = Vector3.New(0, -1.75, -4.8)

				local var_30_28 = manager.ui.mainCamera.transform.position - var_30_20.position

				var_30_20.forward = Vector3.New(var_30_28.x, var_30_28.y, var_30_28.z)

				local var_30_29 = var_30_20.localEulerAngles

				var_30_29.z = 0
				var_30_29.x = 0
				var_30_20.localEulerAngles = var_30_29
			end

			local var_30_30 = arg_27_1.actors_["3045ui_story"]
			local var_30_31 = 0

			if var_30_31 < arg_27_1.time_ and arg_27_1.time_ <= var_30_31 + arg_30_0 and not isNil(var_30_30) and arg_27_1.var_.characterEffect3045ui_story == nil then
				arg_27_1.var_.characterEffect3045ui_story = var_30_30:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_30_32 = 0.200000002980232

			if var_30_31 <= arg_27_1.time_ and arg_27_1.time_ < var_30_31 + var_30_32 and not isNil(var_30_30) then
				local var_30_33 = (arg_27_1.time_ - var_30_31) / var_30_32

				if arg_27_1.var_.characterEffect3045ui_story and not isNil(var_30_30) then
					arg_27_1.var_.characterEffect3045ui_story.fillFlat = false
				end
			end

			if arg_27_1.time_ >= var_30_31 + var_30_32 and arg_27_1.time_ < var_30_31 + var_30_32 + arg_30_0 and not isNil(var_30_30) and arg_27_1.var_.characterEffect3045ui_story then
				arg_27_1.var_.characterEffect3045ui_story.fillFlat = false
			end

			local var_30_34 = 0

			if var_30_34 < arg_27_1.time_ and arg_27_1.time_ <= var_30_34 + arg_30_0 then
				arg_27_1:PlayTimeline("3045ui_story", "StoryTimeline/CharAction/story3009/story3009action/3009action2_1")
			end

			local var_30_35 = 0

			if var_30_35 < arg_27_1.time_ and arg_27_1.time_ <= var_30_35 + arg_30_0 then
				arg_27_1:PlayTimeline("3045ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_30_36 = 0
			local var_30_37 = 1.15

			if var_30_36 < arg_27_1.time_ and arg_27_1.time_ <= var_30_36 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, true)

				local var_30_38 = arg_27_1:FormatText(StoryNameCfg[43].name)

				arg_27_1.leftNameTxt_.text = var_30_38

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_27_1.leftNameTxt_.transform)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1.leftNameTxt_.text)
				SetActive(arg_27_1.iconTrs_.gameObject, false)
				arg_27_1.callingController_:SetSelectedState("normal")

				local var_30_39 = arg_27_1:GetWordFromCfg(414121006)
				local var_30_40 = arg_27_1:FormatText(var_30_39.content)

				arg_27_1.text_.text = var_30_40

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_41 = 46
				local var_30_42 = utf8.len(var_30_40)
				local var_30_43 = var_30_41 <= 0 and var_30_37 or var_30_37 * (var_30_42 / var_30_41)

				if var_30_43 > 0 and var_30_37 < var_30_43 then
					arg_27_1.talkMaxDuration = var_30_43

					if var_30_43 + var_30_36 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_43 + var_30_36
					end
				end

				arg_27_1.text_.text = var_30_40
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)
				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_44 = math.max(var_30_37, arg_27_1.talkMaxDuration)

			if var_30_36 <= arg_27_1.time_ and arg_27_1.time_ < var_30_36 + var_30_44 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - var_30_36) / var_30_44

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= var_30_36 + var_30_44 and arg_27_1.time_ < var_30_36 + var_30_44 + arg_30_0 then
				arg_27_1.typewritter.percent = 1

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(true)
			end
		end

		arg_27_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "3045ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_27_1:InitPlayNodeList()
	end,
	Play414121007 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 414121007
		arg_31_1.duration_ = 5

		SetActive(arg_31_1.tipsGo_, false)

		function arg_31_1.onSingleLineFinish_()
			arg_31_1.onSingleLineUpdate_ = nil
			arg_31_1.onSingleLineFinish_ = nil
			arg_31_1.state_ = "waiting"
		end

		function arg_31_1.playNext_(arg_33_0)
			if arg_33_0 == 1 then
				arg_31_0:Play414121008(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			local var_34_0 = arg_31_1.actors_["3045ui_story"].transform
			local var_34_1 = 0

			if var_34_1 < arg_31_1.time_ and arg_31_1.time_ <= var_34_1 + arg_34_0 then
				arg_31_1.var_.moveOldPos3045ui_story = var_34_0.localPosition
			end

			local var_34_2 = 0.001

			if var_34_1 <= arg_31_1.time_ and arg_31_1.time_ < var_34_1 + var_34_2 then
				local var_34_3 = (arg_31_1.time_ - var_34_1) / var_34_2
				local var_34_4 = Vector3.New(0, 100, 0)

				var_34_0.localPosition = Vector3.Lerp(arg_31_1.var_.moveOldPos3045ui_story, var_34_4, var_34_3)

				local var_34_5 = manager.ui.mainCamera.transform.position - var_34_0.position

				var_34_0.forward = Vector3.New(var_34_5.x, var_34_5.y, var_34_5.z)

				local var_34_6 = var_34_0.localEulerAngles

				var_34_6.z = 0
				var_34_6.x = 0
				var_34_0.localEulerAngles = var_34_6
			end

			if arg_31_1.time_ >= var_34_1 + var_34_2 and arg_31_1.time_ < var_34_1 + var_34_2 + arg_34_0 then
				var_34_0.localPosition = Vector3.New(0, 100, 0)

				local var_34_7 = manager.ui.mainCamera.transform.position - var_34_0.position

				var_34_0.forward = Vector3.New(var_34_7.x, var_34_7.y, var_34_7.z)

				local var_34_8 = var_34_0.localEulerAngles

				var_34_8.z = 0
				var_34_8.x = 0
				var_34_0.localEulerAngles = var_34_8
			end

			local var_34_9 = arg_31_1.actors_["3045ui_story"]
			local var_34_10 = 0

			if var_34_10 < arg_31_1.time_ and arg_31_1.time_ <= var_34_10 + arg_34_0 and not isNil(var_34_9) and arg_31_1.var_.characterEffect3045ui_story == nil then
				arg_31_1.var_.characterEffect3045ui_story = var_34_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_34_11 = 0.200000002980232

			if var_34_10 <= arg_31_1.time_ and arg_31_1.time_ < var_34_10 + var_34_11 and not isNil(var_34_9) then
				local var_34_12 = (arg_31_1.time_ - var_34_10) / var_34_11

				if arg_31_1.var_.characterEffect3045ui_story and not isNil(var_34_9) then
					local var_34_13 = Mathf.Lerp(0, 0.5, var_34_12)

					arg_31_1.var_.characterEffect3045ui_story.fillFlat = true
					arg_31_1.var_.characterEffect3045ui_story.fillRatio = var_34_13
				end
			end

			if arg_31_1.time_ >= var_34_10 + var_34_11 and arg_31_1.time_ < var_34_10 + var_34_11 + arg_34_0 and not isNil(var_34_9) and arg_31_1.var_.characterEffect3045ui_story then
				local var_34_14 = 0.5

				arg_31_1.var_.characterEffect3045ui_story.fillFlat = true
				arg_31_1.var_.characterEffect3045ui_story.fillRatio = var_34_14
			end

			local var_34_15 = arg_31_1.actors_["4010ui_story"].transform
			local var_34_16 = 0

			if var_34_16 < arg_31_1.time_ and arg_31_1.time_ <= var_34_16 + arg_34_0 then
				arg_31_1.var_.moveOldPos4010ui_story = var_34_15.localPosition
			end

			local var_34_17 = 0.001

			if var_34_16 <= arg_31_1.time_ and arg_31_1.time_ < var_34_16 + var_34_17 then
				local var_34_18 = (arg_31_1.time_ - var_34_16) / var_34_17
				local var_34_19 = Vector3.New(0, -1.59, -5.2)

				var_34_15.localPosition = Vector3.Lerp(arg_31_1.var_.moveOldPos4010ui_story, var_34_19, var_34_18)

				local var_34_20 = manager.ui.mainCamera.transform.position - var_34_15.position

				var_34_15.forward = Vector3.New(var_34_20.x, var_34_20.y, var_34_20.z)

				local var_34_21 = var_34_15.localEulerAngles

				var_34_21.z = 0
				var_34_21.x = 0
				var_34_15.localEulerAngles = var_34_21
			end

			if arg_31_1.time_ >= var_34_16 + var_34_17 and arg_31_1.time_ < var_34_16 + var_34_17 + arg_34_0 then
				var_34_15.localPosition = Vector3.New(0, -1.59, -5.2)

				local var_34_22 = manager.ui.mainCamera.transform.position - var_34_15.position

				var_34_15.forward = Vector3.New(var_34_22.x, var_34_22.y, var_34_22.z)

				local var_34_23 = var_34_15.localEulerAngles

				var_34_23.z = 0
				var_34_23.x = 0
				var_34_15.localEulerAngles = var_34_23
			end

			local var_34_24 = arg_31_1.actors_["4010ui_story"]
			local var_34_25 = 0

			if var_34_25 < arg_31_1.time_ and arg_31_1.time_ <= var_34_25 + arg_34_0 and not isNil(var_34_24) and arg_31_1.var_.characterEffect4010ui_story == nil then
				arg_31_1.var_.characterEffect4010ui_story = var_34_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_34_26 = 0.200000002980232

			if var_34_25 <= arg_31_1.time_ and arg_31_1.time_ < var_34_25 + var_34_26 and not isNil(var_34_24) then
				local var_34_27 = (arg_31_1.time_ - var_34_25) / var_34_26

				if arg_31_1.var_.characterEffect4010ui_story and not isNil(var_34_24) then
					arg_31_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_31_1.time_ >= var_34_25 + var_34_26 and arg_31_1.time_ < var_34_25 + var_34_26 + arg_34_0 and not isNil(var_34_24) and arg_31_1.var_.characterEffect4010ui_story then
				arg_31_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_34_28 = 0

			if var_34_28 < arg_31_1.time_ and arg_31_1.time_ <= var_34_28 + arg_34_0 then
				arg_31_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action3_2")
			end

			local var_34_29 = 0

			if var_34_29 < arg_31_1.time_ and arg_31_1.time_ <= var_34_29 + arg_34_0 then
				arg_31_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_34_30 = 0
			local var_34_31 = 0.3

			if var_34_30 < arg_31_1.time_ and arg_31_1.time_ <= var_34_30 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, true)

				local var_34_32 = arg_31_1:FormatText(StoryNameCfg[42].name)

				arg_31_1.leftNameTxt_.text = var_34_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_31_1.leftNameTxt_.transform)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1.leftNameTxt_.text)
				SetActive(arg_31_1.iconTrs_.gameObject, false)
				arg_31_1.callingController_:SetSelectedState("normal")

				local var_34_33 = arg_31_1:GetWordFromCfg(414121007)
				local var_34_34 = arg_31_1:FormatText(var_34_33.content)

				arg_31_1.text_.text = var_34_34

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_35 = 12
				local var_34_36 = utf8.len(var_34_34)
				local var_34_37 = var_34_35 <= 0 and var_34_31 or var_34_31 * (var_34_36 / var_34_35)

				if var_34_37 > 0 and var_34_31 < var_34_37 then
					arg_31_1.talkMaxDuration = var_34_37

					if var_34_37 + var_34_30 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_37 + var_34_30
					end
				end

				arg_31_1.text_.text = var_34_34
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)
				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_38 = math.max(var_34_31, arg_31_1.talkMaxDuration)

			if var_34_30 <= arg_31_1.time_ and arg_31_1.time_ < var_34_30 + var_34_38 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - var_34_30) / var_34_38

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= var_34_30 + var_34_38 and arg_31_1.time_ < var_34_30 + var_34_38 + arg_34_0 then
				arg_31_1.typewritter.percent = 1

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(true)
			end
		end

		arg_31_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3045ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_31_1:InitPlayNodeList()
	end,
	Play414121008 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 414121008
		arg_35_1.duration_ = 5

		SetActive(arg_35_1.tipsGo_, false)

		function arg_35_1.onSingleLineFinish_()
			arg_35_1.onSingleLineUpdate_ = nil
			arg_35_1.onSingleLineFinish_ = nil
			arg_35_1.state_ = "waiting"
		end

		function arg_35_1.playNext_(arg_37_0)
			if arg_37_0 == 1 then
				arg_35_0:Play414121009(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			local var_38_0 = arg_35_1.actors_["4010ui_story"].transform
			local var_38_1 = 0

			if var_38_1 < arg_35_1.time_ and arg_35_1.time_ <= var_38_1 + arg_38_0 then
				arg_35_1.var_.moveOldPos4010ui_story = var_38_0.localPosition
			end

			local var_38_2 = 0.001

			if var_38_1 <= arg_35_1.time_ and arg_35_1.time_ < var_38_1 + var_38_2 then
				local var_38_3 = (arg_35_1.time_ - var_38_1) / var_38_2
				local var_38_4 = Vector3.New(0, -1.59, -5.2)

				var_38_0.localPosition = Vector3.Lerp(arg_35_1.var_.moveOldPos4010ui_story, var_38_4, var_38_3)

				local var_38_5 = manager.ui.mainCamera.transform.position - var_38_0.position

				var_38_0.forward = Vector3.New(var_38_5.x, var_38_5.y, var_38_5.z)

				local var_38_6 = var_38_0.localEulerAngles

				var_38_6.z = 0
				var_38_6.x = 0
				var_38_0.localEulerAngles = var_38_6
			end

			if arg_35_1.time_ >= var_38_1 + var_38_2 and arg_35_1.time_ < var_38_1 + var_38_2 + arg_38_0 then
				var_38_0.localPosition = Vector3.New(0, -1.59, -5.2)

				local var_38_7 = manager.ui.mainCamera.transform.position - var_38_0.position

				var_38_0.forward = Vector3.New(var_38_7.x, var_38_7.y, var_38_7.z)

				local var_38_8 = var_38_0.localEulerAngles

				var_38_8.z = 0
				var_38_8.x = 0
				var_38_0.localEulerAngles = var_38_8
			end

			local var_38_9 = arg_35_1.actors_["4010ui_story"]
			local var_38_10 = 0

			if var_38_10 < arg_35_1.time_ and arg_35_1.time_ <= var_38_10 + arg_38_0 and not isNil(var_38_9) and arg_35_1.var_.characterEffect4010ui_story == nil then
				arg_35_1.var_.characterEffect4010ui_story = var_38_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_38_11 = 0.200000002980232

			if var_38_10 <= arg_35_1.time_ and arg_35_1.time_ < var_38_10 + var_38_11 and not isNil(var_38_9) then
				local var_38_12 = (arg_35_1.time_ - var_38_10) / var_38_11

				if arg_35_1.var_.characterEffect4010ui_story and not isNil(var_38_9) then
					arg_35_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_35_1.time_ >= var_38_10 + var_38_11 and arg_35_1.time_ < var_38_10 + var_38_11 + arg_38_0 and not isNil(var_38_9) and arg_35_1.var_.characterEffect4010ui_story then
				arg_35_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_38_13 = 0

			if var_38_13 < arg_35_1.time_ and arg_35_1.time_ <= var_38_13 + arg_38_0 then
				arg_35_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action4_1")
			end

			local var_38_14 = 0

			if var_38_14 < arg_35_1.time_ and arg_35_1.time_ <= var_38_14 + arg_38_0 then
				arg_35_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_38_15 = 0
			local var_38_16 = 0.6

			if var_38_15 < arg_35_1.time_ and arg_35_1.time_ <= var_38_15 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, true)

				local var_38_17 = arg_35_1:FormatText(StoryNameCfg[42].name)

				arg_35_1.leftNameTxt_.text = var_38_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_35_1.leftNameTxt_.transform)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1.leftNameTxt_.text)
				SetActive(arg_35_1.iconTrs_.gameObject, false)
				arg_35_1.callingController_:SetSelectedState("normal")

				local var_38_18 = arg_35_1:GetWordFromCfg(414121008)
				local var_38_19 = arg_35_1:FormatText(var_38_18.content)

				arg_35_1.text_.text = var_38_19

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_20 = 24
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
				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_23 = math.max(var_38_16, arg_35_1.talkMaxDuration)

			if var_38_15 <= arg_35_1.time_ and arg_35_1.time_ < var_38_15 + var_38_23 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - var_38_15) / var_38_23

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= var_38_15 + var_38_23 and arg_35_1.time_ < var_38_15 + var_38_23 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_35_1:InitPlayNodeList()
	end,
	Play414121009 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 414121009
		arg_39_1.duration_ = 5

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play414121010(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			local var_42_0 = arg_39_1.actors_["4010ui_story"]
			local var_42_1 = 0

			if var_42_1 < arg_39_1.time_ and arg_39_1.time_ <= var_42_1 + arg_42_0 and not isNil(var_42_0) and arg_39_1.var_.characterEffect4010ui_story == nil then
				arg_39_1.var_.characterEffect4010ui_story = var_42_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_42_2 = 0.200000002980232

			if var_42_1 <= arg_39_1.time_ and arg_39_1.time_ < var_42_1 + var_42_2 and not isNil(var_42_0) then
				local var_42_3 = (arg_39_1.time_ - var_42_1) / var_42_2

				if arg_39_1.var_.characterEffect4010ui_story and not isNil(var_42_0) then
					local var_42_4 = Mathf.Lerp(0, 0.5, var_42_3)

					arg_39_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_39_1.var_.characterEffect4010ui_story.fillRatio = var_42_4
				end
			end

			if arg_39_1.time_ >= var_42_1 + var_42_2 and arg_39_1.time_ < var_42_1 + var_42_2 + arg_42_0 and not isNil(var_42_0) and arg_39_1.var_.characterEffect4010ui_story then
				local var_42_5 = 0.5

				arg_39_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_39_1.var_.characterEffect4010ui_story.fillRatio = var_42_5
			end

			local var_42_6 = 0
			local var_42_7 = 0.2

			if var_42_6 < arg_39_1.time_ and arg_39_1.time_ <= var_42_6 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, true)

				local var_42_8 = arg_39_1:FormatText(StoryNameCfg[7].name)

				arg_39_1.leftNameTxt_.text = var_42_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_39_1.leftNameTxt_.transform)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1.leftNameTxt_.text)
				SetActive(arg_39_1.iconTrs_.gameObject, true)
				arg_39_1.iconController_:SetSelectedState("hero")

				arg_39_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_39_1.callingController_:SetSelectedState("normal")

				arg_39_1.keyicon_.color = Color.New(1, 1, 1)
				arg_39_1.icon_.color = Color.New(1, 1, 1)

				local var_42_9 = arg_39_1:GetWordFromCfg(414121009)
				local var_42_10 = arg_39_1:FormatText(var_42_9.content)

				arg_39_1.text_.text = var_42_10

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_11 = 8
				local var_42_12 = utf8.len(var_42_10)
				local var_42_13 = var_42_11 <= 0 and var_42_7 or var_42_7 * (var_42_12 / var_42_11)

				if var_42_13 > 0 and var_42_7 < var_42_13 then
					arg_39_1.talkMaxDuration = var_42_13

					if var_42_13 + var_42_6 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_13 + var_42_6
					end
				end

				arg_39_1.text_.text = var_42_10
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)
				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_14 = math.max(var_42_7, arg_39_1.talkMaxDuration)

			if var_42_6 <= arg_39_1.time_ and arg_39_1.time_ < var_42_6 + var_42_14 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_6) / var_42_14

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_6 + var_42_14 and arg_39_1.time_ < var_42_6 + var_42_14 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {}

		arg_39_1:InitPlayNodeList()
	end,
	Play414121010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 414121010
		arg_43_1.duration_ = 5

		SetActive(arg_43_1.tipsGo_, false)

		function arg_43_1.onSingleLineFinish_()
			arg_43_1.onSingleLineUpdate_ = nil
			arg_43_1.onSingleLineFinish_ = nil
			arg_43_1.state_ = "waiting"
		end

		function arg_43_1.playNext_(arg_45_0)
			if arg_45_0 == 1 then
				arg_43_0:Play414121011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			local var_46_0 = arg_43_1.actors_["4010ui_story"]
			local var_46_1 = 0

			if var_46_1 < arg_43_1.time_ and arg_43_1.time_ <= var_46_1 + arg_46_0 and not isNil(var_46_0) and arg_43_1.var_.characterEffect4010ui_story == nil then
				arg_43_1.var_.characterEffect4010ui_story = var_46_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_46_2 = 0.200000002980232

			if var_46_1 <= arg_43_1.time_ and arg_43_1.time_ < var_46_1 + var_46_2 and not isNil(var_46_0) then
				local var_46_3 = (arg_43_1.time_ - var_46_1) / var_46_2

				if arg_43_1.var_.characterEffect4010ui_story and not isNil(var_46_0) then
					arg_43_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_43_1.time_ >= var_46_1 + var_46_2 and arg_43_1.time_ < var_46_1 + var_46_2 + arg_46_0 and not isNil(var_46_0) and arg_43_1.var_.characterEffect4010ui_story then
				arg_43_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_46_4 = 0
			local var_46_5 = 1.225

			if var_46_4 < arg_43_1.time_ and arg_43_1.time_ <= var_46_4 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, true)

				local var_46_6 = arg_43_1:FormatText(StoryNameCfg[42].name)

				arg_43_1.leftNameTxt_.text = var_46_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_7 = arg_43_1:GetWordFromCfg(414121010)
				local var_46_8 = arg_43_1:FormatText(var_46_7.content)

				arg_43_1.text_.text = var_46_8

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_9 = 49
				local var_46_10 = utf8.len(var_46_8)
				local var_46_11 = var_46_9 <= 0 and var_46_5 or var_46_5 * (var_46_10 / var_46_9)

				if var_46_11 > 0 and var_46_5 < var_46_11 then
					arg_43_1.talkMaxDuration = var_46_11

					if var_46_11 + var_46_4 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_11 + var_46_4
					end
				end

				arg_43_1.text_.text = var_46_8
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)
				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_12 = math.max(var_46_5, arg_43_1.talkMaxDuration)

			if var_46_4 <= arg_43_1.time_ and arg_43_1.time_ < var_46_4 + var_46_12 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_4) / var_46_12

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_4 + var_46_12 and arg_43_1.time_ < var_46_4 + var_46_12 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {}

		arg_43_1:InitPlayNodeList()
	end,
	Play414121011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 414121011
		arg_47_1.duration_ = 5

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play414121012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			local var_50_0 = arg_47_1.actors_["4010ui_story"].transform
			local var_50_1 = 0

			if var_50_1 < arg_47_1.time_ and arg_47_1.time_ <= var_50_1 + arg_50_0 then
				arg_47_1.var_.moveOldPos4010ui_story = var_50_0.localPosition
			end

			local var_50_2 = 0.001

			if var_50_1 <= arg_47_1.time_ and arg_47_1.time_ < var_50_1 + var_50_2 then
				local var_50_3 = (arg_47_1.time_ - var_50_1) / var_50_2
				local var_50_4 = Vector3.New(0, -1.59, -5.2)

				var_50_0.localPosition = Vector3.Lerp(arg_47_1.var_.moveOldPos4010ui_story, var_50_4, var_50_3)

				local var_50_5 = manager.ui.mainCamera.transform.position - var_50_0.position

				var_50_0.forward = Vector3.New(var_50_5.x, var_50_5.y, var_50_5.z)

				local var_50_6 = var_50_0.localEulerAngles

				var_50_6.z = 0
				var_50_6.x = 0
				var_50_0.localEulerAngles = var_50_6
			end

			if arg_47_1.time_ >= var_50_1 + var_50_2 and arg_47_1.time_ < var_50_1 + var_50_2 + arg_50_0 then
				var_50_0.localPosition = Vector3.New(0, -1.59, -5.2)

				local var_50_7 = manager.ui.mainCamera.transform.position - var_50_0.position

				var_50_0.forward = Vector3.New(var_50_7.x, var_50_7.y, var_50_7.z)

				local var_50_8 = var_50_0.localEulerAngles

				var_50_8.z = 0
				var_50_8.x = 0
				var_50_0.localEulerAngles = var_50_8
			end

			local var_50_9 = 0

			if var_50_9 < arg_47_1.time_ and arg_47_1.time_ <= var_50_9 + arg_50_0 then
				arg_47_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action4_2")
			end

			local var_50_10 = 0

			if var_50_10 < arg_47_1.time_ and arg_47_1.time_ <= var_50_10 + arg_50_0 then
				arg_47_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_50_11 = 0
			local var_50_12 = 0.475

			if var_50_11 < arg_47_1.time_ and arg_47_1.time_ <= var_50_11 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, true)

				local var_50_13 = arg_47_1:FormatText(StoryNameCfg[42].name)

				arg_47_1.leftNameTxt_.text = var_50_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_14 = arg_47_1:GetWordFromCfg(414121011)
				local var_50_15 = arg_47_1:FormatText(var_50_14.content)

				arg_47_1.text_.text = var_50_15

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_16 = 19
				local var_50_17 = utf8.len(var_50_15)
				local var_50_18 = var_50_16 <= 0 and var_50_12 or var_50_12 * (var_50_17 / var_50_16)

				if var_50_18 > 0 and var_50_12 < var_50_18 then
					arg_47_1.talkMaxDuration = var_50_18

					if var_50_18 + var_50_11 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_18 + var_50_11
					end
				end

				arg_47_1.text_.text = var_50_15
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)
				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_19 = math.max(var_50_12, arg_47_1.talkMaxDuration)

			if var_50_11 <= arg_47_1.time_ and arg_47_1.time_ < var_50_11 + var_50_19 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_11) / var_50_19

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_11 + var_50_19 and arg_47_1.time_ < var_50_11 + var_50_19 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_47_1:InitPlayNodeList()
	end,
	Play414121012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 414121012
		arg_51_1.duration_ = 5

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play414121013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			local var_54_0 = arg_51_1.actors_["4010ui_story"]
			local var_54_1 = 0

			if var_54_1 < arg_51_1.time_ and arg_51_1.time_ <= var_54_1 + arg_54_0 and not isNil(var_54_0) and arg_51_1.var_.characterEffect4010ui_story == nil then
				arg_51_1.var_.characterEffect4010ui_story = var_54_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_54_2 = 0.200000002980232

			if var_54_1 <= arg_51_1.time_ and arg_51_1.time_ < var_54_1 + var_54_2 and not isNil(var_54_0) then
				local var_54_3 = (arg_51_1.time_ - var_54_1) / var_54_2

				if arg_51_1.var_.characterEffect4010ui_story and not isNil(var_54_0) then
					local var_54_4 = Mathf.Lerp(0, 0.5, var_54_3)

					arg_51_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_51_1.var_.characterEffect4010ui_story.fillRatio = var_54_4
				end
			end

			if arg_51_1.time_ >= var_54_1 + var_54_2 and arg_51_1.time_ < var_54_1 + var_54_2 + arg_54_0 and not isNil(var_54_0) and arg_51_1.var_.characterEffect4010ui_story then
				local var_54_5 = 0.5

				arg_51_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_51_1.var_.characterEffect4010ui_story.fillRatio = var_54_5
			end

			local var_54_6 = 0
			local var_54_7 = 0.325

			if var_54_6 < arg_51_1.time_ and arg_51_1.time_ <= var_54_6 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				local var_54_8 = arg_51_1:FormatText(StoryNameCfg[7].name)

				arg_51_1.leftNameTxt_.text = var_54_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, true)
				arg_51_1.iconController_:SetSelectedState("hero")

				arg_51_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_51_1.callingController_:SetSelectedState("normal")

				arg_51_1.keyicon_.color = Color.New(1, 1, 1)
				arg_51_1.icon_.color = Color.New(1, 1, 1)

				local var_54_9 = arg_51_1:GetWordFromCfg(414121012)
				local var_54_10 = arg_51_1:FormatText(var_54_9.content)

				arg_51_1.text_.text = var_54_10

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_11 = 13
				local var_54_12 = utf8.len(var_54_10)
				local var_54_13 = var_54_11 <= 0 and var_54_7 or var_54_7 * (var_54_12 / var_54_11)

				if var_54_13 > 0 and var_54_7 < var_54_13 then
					arg_51_1.talkMaxDuration = var_54_13

					if var_54_13 + var_54_6 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_13 + var_54_6
					end
				end

				arg_51_1.text_.text = var_54_10
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)
				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_14 = math.max(var_54_7, arg_51_1.talkMaxDuration)

			if var_54_6 <= arg_51_1.time_ and arg_51_1.time_ < var_54_6 + var_54_14 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_6) / var_54_14

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_6 + var_54_14 and arg_51_1.time_ < var_54_6 + var_54_14 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {}

		arg_51_1:InitPlayNodeList()
	end,
	Play414121013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 414121013
		arg_55_1.duration_ = 5

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play414121014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			local var_58_0 = 0
			local var_58_1 = 0.15

			if var_58_0 < arg_55_1.time_ and arg_55_1.time_ <= var_58_0 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				local var_58_2 = arg_55_1:FormatText(StoryNameCfg[36].name)

				arg_55_1.leftNameTxt_.text = var_58_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, true)
				arg_55_1.iconController_:SetSelectedState("hero")

				arg_55_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1024")

				arg_55_1.callingController_:SetSelectedState("normal")

				arg_55_1.keyicon_.color = Color.New(1, 1, 1)
				arg_55_1.icon_.color = Color.New(1, 1, 1)

				local var_58_3 = arg_55_1:GetWordFromCfg(414121013)
				local var_58_4 = arg_55_1:FormatText(var_58_3.content)

				arg_55_1.text_.text = var_58_4

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_5 = 6
				local var_58_6 = utf8.len(var_58_4)
				local var_58_7 = var_58_5 <= 0 and var_58_1 or var_58_1 * (var_58_6 / var_58_5)

				if var_58_7 > 0 and var_58_1 < var_58_7 then
					arg_55_1.talkMaxDuration = var_58_7

					if var_58_7 + var_58_0 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_7 + var_58_0
					end
				end

				arg_55_1.text_.text = var_58_4
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)
				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_8 = math.max(var_58_1, arg_55_1.talkMaxDuration)

			if var_58_0 <= arg_55_1.time_ and arg_55_1.time_ < var_58_0 + var_58_8 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_0) / var_58_8

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_0 + var_58_8 and arg_55_1.time_ < var_58_0 + var_58_8 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {}

		arg_55_1:InitPlayNodeList()
	end,
	Play414121014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 414121014
		arg_59_1.duration_ = 5

		SetActive(arg_59_1.tipsGo_, false)

		function arg_59_1.onSingleLineFinish_()
			arg_59_1.onSingleLineUpdate_ = nil
			arg_59_1.onSingleLineFinish_ = nil
			arg_59_1.state_ = "waiting"
		end

		function arg_59_1.playNext_(arg_61_0)
			if arg_61_0 == 1 then
				arg_59_0:Play414121015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			local var_62_0 = arg_59_1.actors_["4010ui_story"].transform
			local var_62_1 = 0

			if var_62_1 < arg_59_1.time_ and arg_59_1.time_ <= var_62_1 + arg_62_0 then
				arg_59_1.var_.moveOldPos4010ui_story = var_62_0.localPosition
			end

			local var_62_2 = 0.001

			if var_62_1 <= arg_59_1.time_ and arg_59_1.time_ < var_62_1 + var_62_2 then
				local var_62_3 = (arg_59_1.time_ - var_62_1) / var_62_2
				local var_62_4 = Vector3.New(0, -1.59, -5.2)

				var_62_0.localPosition = Vector3.Lerp(arg_59_1.var_.moveOldPos4010ui_story, var_62_4, var_62_3)

				local var_62_5 = manager.ui.mainCamera.transform.position - var_62_0.position

				var_62_0.forward = Vector3.New(var_62_5.x, var_62_5.y, var_62_5.z)

				local var_62_6 = var_62_0.localEulerAngles

				var_62_6.z = 0
				var_62_6.x = 0
				var_62_0.localEulerAngles = var_62_6
			end

			if arg_59_1.time_ >= var_62_1 + var_62_2 and arg_59_1.time_ < var_62_1 + var_62_2 + arg_62_0 then
				var_62_0.localPosition = Vector3.New(0, -1.59, -5.2)

				local var_62_7 = manager.ui.mainCamera.transform.position - var_62_0.position

				var_62_0.forward = Vector3.New(var_62_7.x, var_62_7.y, var_62_7.z)

				local var_62_8 = var_62_0.localEulerAngles

				var_62_8.z = 0
				var_62_8.x = 0
				var_62_0.localEulerAngles = var_62_8
			end

			local var_62_9 = arg_59_1.actors_["4010ui_story"]
			local var_62_10 = 0

			if var_62_10 < arg_59_1.time_ and arg_59_1.time_ <= var_62_10 + arg_62_0 and not isNil(var_62_9) and arg_59_1.var_.characterEffect4010ui_story == nil then
				arg_59_1.var_.characterEffect4010ui_story = var_62_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_62_11 = 0.200000002980232

			if var_62_10 <= arg_59_1.time_ and arg_59_1.time_ < var_62_10 + var_62_11 and not isNil(var_62_9) then
				local var_62_12 = (arg_59_1.time_ - var_62_10) / var_62_11

				if arg_59_1.var_.characterEffect4010ui_story and not isNil(var_62_9) then
					arg_59_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_59_1.time_ >= var_62_10 + var_62_11 and arg_59_1.time_ < var_62_10 + var_62_11 + arg_62_0 and not isNil(var_62_9) and arg_59_1.var_.characterEffect4010ui_story then
				arg_59_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_62_13 = 0

			if var_62_13 < arg_59_1.time_ and arg_59_1.time_ <= var_62_13 + arg_62_0 then
				arg_59_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action3_1")
			end

			local var_62_14 = 0

			if var_62_14 < arg_59_1.time_ and arg_59_1.time_ <= var_62_14 + arg_62_0 then
				arg_59_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_62_15 = 0
			local var_62_16 = 0.45

			if var_62_15 < arg_59_1.time_ and arg_59_1.time_ <= var_62_15 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				local var_62_17 = arg_59_1:FormatText(StoryNameCfg[42].name)

				arg_59_1.leftNameTxt_.text = var_62_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_18 = arg_59_1:GetWordFromCfg(414121014)
				local var_62_19 = arg_59_1:FormatText(var_62_18.content)

				arg_59_1.text_.text = var_62_19

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_20 = 18
				local var_62_21 = utf8.len(var_62_19)
				local var_62_22 = var_62_20 <= 0 and var_62_16 or var_62_16 * (var_62_21 / var_62_20)

				if var_62_22 > 0 and var_62_16 < var_62_22 then
					arg_59_1.talkMaxDuration = var_62_22

					if var_62_22 + var_62_15 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_22 + var_62_15
					end
				end

				arg_59_1.text_.text = var_62_19
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)
				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_23 = math.max(var_62_16, arg_59_1.talkMaxDuration)

			if var_62_15 <= arg_59_1.time_ and arg_59_1.time_ < var_62_15 + var_62_23 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_15) / var_62_23

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_15 + var_62_23 and arg_59_1.time_ < var_62_15 + var_62_23 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_59_1:InitPlayNodeList()
	end,
	Play414121015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 414121015
		arg_63_1.duration_ = 5

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play414121016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			local var_66_0 = 0
			local var_66_1 = 0.55

			if var_66_0 < arg_63_1.time_ and arg_63_1.time_ <= var_66_0 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				local var_66_2 = arg_63_1:FormatText(StoryNameCfg[42].name)

				arg_63_1.leftNameTxt_.text = var_66_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_3 = arg_63_1:GetWordFromCfg(414121015)
				local var_66_4 = arg_63_1:FormatText(var_66_3.content)

				arg_63_1.text_.text = var_66_4

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_5 = 22
				local var_66_6 = utf8.len(var_66_4)
				local var_66_7 = var_66_5 <= 0 and var_66_1 or var_66_1 * (var_66_6 / var_66_5)

				if var_66_7 > 0 and var_66_1 < var_66_7 then
					arg_63_1.talkMaxDuration = var_66_7

					if var_66_7 + var_66_0 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_7 + var_66_0
					end
				end

				arg_63_1.text_.text = var_66_4
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)
				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_8 = math.max(var_66_1, arg_63_1.talkMaxDuration)

			if var_66_0 <= arg_63_1.time_ and arg_63_1.time_ < var_66_0 + var_66_8 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_0) / var_66_8

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_0 + var_66_8 and arg_63_1.time_ < var_66_0 + var_66_8 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {}

		arg_63_1:InitPlayNodeList()
	end,
	Play414121016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 414121016
		arg_67_1.duration_ = 5

		SetActive(arg_67_1.tipsGo_, false)

		function arg_67_1.onSingleLineFinish_()
			arg_67_1.onSingleLineUpdate_ = nil
			arg_67_1.onSingleLineFinish_ = nil
			arg_67_1.state_ = "waiting"
		end

		function arg_67_1.playNext_(arg_69_0)
			if arg_69_0 == 1 then
				arg_67_0:Play414121017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = "1024ui_story"

			if arg_67_1.actors_[var_70_0] == nil then
				local var_70_1 = Asset.Load("Char/" .. "1024ui_story")

				if not isNil(var_70_1) then
					local var_70_2 = Object.Instantiate(Asset.Load("Char/" .. "1024ui_story"), arg_67_1.stage_.transform)

					var_70_2.name = var_70_0
					var_70_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_67_1.actors_[var_70_0] = var_70_2

					local var_70_3 = var_70_2:GetComponentInChildren(typeof(CharacterEffect))

					var_70_3.enabled = true

					local var_70_4 = GameObjectTools.GetOrAddComponent(var_70_2, typeof(DynamicBoneHelper))

					if var_70_4 then
						var_70_4:EnableDynamicBone(false)
					end

					arg_67_1:ShowWeapon(var_70_3.transform, false)

					arg_67_1.var_[var_70_0 .. "Animator"] = var_70_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_67_1.var_[var_70_0 .. "Animator"].applyRootMotion = true
					arg_67_1.var_[var_70_0 .. "LipSync"] = var_70_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_70_5 = arg_67_1.actors_["1024ui_story"].transform
			local var_70_6 = 0

			if var_70_6 < arg_67_1.time_ and arg_67_1.time_ <= var_70_6 + arg_70_0 then
				arg_67_1.var_.moveOldPos1024ui_story = var_70_5.localPosition

				local var_70_7 = "1024ui_story"

				arg_67_1:ShowWeapon(arg_67_1.var_[var_70_7 .. "Animator"].transform, false)
			end

			local var_70_8 = 0.001

			if var_70_6 <= arg_67_1.time_ and arg_67_1.time_ < var_70_6 + var_70_8 then
				local var_70_9 = (arg_67_1.time_ - var_70_6) / var_70_8
				local var_70_10 = Vector3.New(0, -1, -6.05)

				var_70_5.localPosition = Vector3.Lerp(arg_67_1.var_.moveOldPos1024ui_story, var_70_10, var_70_9)

				local var_70_11 = manager.ui.mainCamera.transform.position - var_70_5.position

				var_70_5.forward = Vector3.New(var_70_11.x, var_70_11.y, var_70_11.z)

				local var_70_12 = var_70_5.localEulerAngles

				var_70_12.z = 0
				var_70_12.x = 0
				var_70_5.localEulerAngles = var_70_12
			end

			if arg_67_1.time_ >= var_70_6 + var_70_8 and arg_67_1.time_ < var_70_6 + var_70_8 + arg_70_0 then
				var_70_5.localPosition = Vector3.New(0, -1, -6.05)

				local var_70_13 = manager.ui.mainCamera.transform.position - var_70_5.position

				var_70_5.forward = Vector3.New(var_70_13.x, var_70_13.y, var_70_13.z)

				local var_70_14 = var_70_5.localEulerAngles

				var_70_14.z = 0
				var_70_14.x = 0
				var_70_5.localEulerAngles = var_70_14
			end

			local var_70_15 = arg_67_1.actors_["1024ui_story"]
			local var_70_16 = 0

			if var_70_16 < arg_67_1.time_ and arg_67_1.time_ <= var_70_16 + arg_70_0 and not isNil(var_70_15) and arg_67_1.var_.characterEffect1024ui_story == nil then
				arg_67_1.var_.characterEffect1024ui_story = var_70_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_70_17 = 0.200000002980232

			if var_70_16 <= arg_67_1.time_ and arg_67_1.time_ < var_70_16 + var_70_17 and not isNil(var_70_15) then
				local var_70_18 = (arg_67_1.time_ - var_70_16) / var_70_17

				if arg_67_1.var_.characterEffect1024ui_story and not isNil(var_70_15) then
					arg_67_1.var_.characterEffect1024ui_story.fillFlat = false
				end
			end

			if arg_67_1.time_ >= var_70_16 + var_70_17 and arg_67_1.time_ < var_70_16 + var_70_17 + arg_70_0 and not isNil(var_70_15) and arg_67_1.var_.characterEffect1024ui_story then
				arg_67_1.var_.characterEffect1024ui_story.fillFlat = false
			end

			local var_70_19 = 0

			if var_70_19 < arg_67_1.time_ and arg_67_1.time_ <= var_70_19 + arg_70_0 then
				arg_67_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/story1024/story1024action/1024action6_1")
			end

			local var_70_20 = 0

			if var_70_20 < arg_67_1.time_ and arg_67_1.time_ <= var_70_20 + arg_70_0 then
				arg_67_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_70_21 = arg_67_1.actors_["4010ui_story"].transform
			local var_70_22 = 0

			if var_70_22 < arg_67_1.time_ and arg_67_1.time_ <= var_70_22 + arg_70_0 then
				arg_67_1.var_.moveOldPos4010ui_story = var_70_21.localPosition
			end

			local var_70_23 = 0.001

			if var_70_22 <= arg_67_1.time_ and arg_67_1.time_ < var_70_22 + var_70_23 then
				local var_70_24 = (arg_67_1.time_ - var_70_22) / var_70_23
				local var_70_25 = Vector3.New(0, 100, 0)

				var_70_21.localPosition = Vector3.Lerp(arg_67_1.var_.moveOldPos4010ui_story, var_70_25, var_70_24)

				local var_70_26 = manager.ui.mainCamera.transform.position - var_70_21.position

				var_70_21.forward = Vector3.New(var_70_26.x, var_70_26.y, var_70_26.z)

				local var_70_27 = var_70_21.localEulerAngles

				var_70_27.z = 0
				var_70_27.x = 0
				var_70_21.localEulerAngles = var_70_27
			end

			if arg_67_1.time_ >= var_70_22 + var_70_23 and arg_67_1.time_ < var_70_22 + var_70_23 + arg_70_0 then
				var_70_21.localPosition = Vector3.New(0, 100, 0)

				local var_70_28 = manager.ui.mainCamera.transform.position - var_70_21.position

				var_70_21.forward = Vector3.New(var_70_28.x, var_70_28.y, var_70_28.z)

				local var_70_29 = var_70_21.localEulerAngles

				var_70_29.z = 0
				var_70_29.x = 0
				var_70_21.localEulerAngles = var_70_29
			end

			local var_70_30 = 0
			local var_70_31 = 0.45

			if var_70_30 < arg_67_1.time_ and arg_67_1.time_ <= var_70_30 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				local var_70_32 = arg_67_1:FormatText(StoryNameCfg[265].name)

				arg_67_1.leftNameTxt_.text = var_70_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_33 = arg_67_1:GetWordFromCfg(414121016)
				local var_70_34 = arg_67_1:FormatText(var_70_33.content)

				arg_67_1.text_.text = var_70_34

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_35 = 18
				local var_70_36 = utf8.len(var_70_34)
				local var_70_37 = var_70_35 <= 0 and var_70_31 or var_70_31 * (var_70_36 / var_70_35)

				if var_70_37 > 0 and var_70_31 < var_70_37 then
					arg_67_1.talkMaxDuration = var_70_37

					if var_70_37 + var_70_30 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_37 + var_70_30
					end
				end

				arg_67_1.text_.text = var_70_34
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)
				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_38 = math.max(var_70_31, arg_67_1.talkMaxDuration)

			if var_70_30 <= arg_67_1.time_ and arg_67_1.time_ < var_70_30 + var_70_38 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_30) / var_70_38

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_30 + var_70_38 and arg_67_1.time_ < var_70_30 + var_70_38 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_67_1:InitPlayNodeList()
	end,
	Play414121017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 414121017
		arg_71_1.duration_ = 5

		SetActive(arg_71_1.tipsGo_, false)

		function arg_71_1.onSingleLineFinish_()
			arg_71_1.onSingleLineUpdate_ = nil
			arg_71_1.onSingleLineFinish_ = nil
			arg_71_1.state_ = "waiting"
		end

		function arg_71_1.playNext_(arg_73_0)
			if arg_73_0 == 1 then
				arg_71_0:Play414121018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			local var_74_0 = arg_71_1.actors_["4010ui_story"].transform
			local var_74_1 = 0

			if var_74_1 < arg_71_1.time_ and arg_71_1.time_ <= var_74_1 + arg_74_0 then
				arg_71_1.var_.moveOldPos4010ui_story = var_74_0.localPosition
			end

			local var_74_2 = 0.001

			if var_74_1 <= arg_71_1.time_ and arg_71_1.time_ < var_74_1 + var_74_2 then
				local var_74_3 = (arg_71_1.time_ - var_74_1) / var_74_2
				local var_74_4 = Vector3.New(0, -1.59, -5.2)

				var_74_0.localPosition = Vector3.Lerp(arg_71_1.var_.moveOldPos4010ui_story, var_74_4, var_74_3)

				local var_74_5 = manager.ui.mainCamera.transform.position - var_74_0.position

				var_74_0.forward = Vector3.New(var_74_5.x, var_74_5.y, var_74_5.z)

				local var_74_6 = var_74_0.localEulerAngles

				var_74_6.z = 0
				var_74_6.x = 0
				var_74_0.localEulerAngles = var_74_6
			end

			if arg_71_1.time_ >= var_74_1 + var_74_2 and arg_71_1.time_ < var_74_1 + var_74_2 + arg_74_0 then
				var_74_0.localPosition = Vector3.New(0, -1.59, -5.2)

				local var_74_7 = manager.ui.mainCamera.transform.position - var_74_0.position

				var_74_0.forward = Vector3.New(var_74_7.x, var_74_7.y, var_74_7.z)

				local var_74_8 = var_74_0.localEulerAngles

				var_74_8.z = 0
				var_74_8.x = 0
				var_74_0.localEulerAngles = var_74_8
			end

			local var_74_9 = arg_71_1.actors_["4010ui_story"]
			local var_74_10 = 0

			if var_74_10 < arg_71_1.time_ and arg_71_1.time_ <= var_74_10 + arg_74_0 and not isNil(var_74_9) and arg_71_1.var_.characterEffect4010ui_story == nil then
				arg_71_1.var_.characterEffect4010ui_story = var_74_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_11 = 0.200000002980232

			if var_74_10 <= arg_71_1.time_ and arg_71_1.time_ < var_74_10 + var_74_11 and not isNil(var_74_9) then
				local var_74_12 = (arg_71_1.time_ - var_74_10) / var_74_11

				if arg_71_1.var_.characterEffect4010ui_story and not isNil(var_74_9) then
					arg_71_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_71_1.time_ >= var_74_10 + var_74_11 and arg_71_1.time_ < var_74_10 + var_74_11 + arg_74_0 and not isNil(var_74_9) and arg_71_1.var_.characterEffect4010ui_story then
				arg_71_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_74_13 = 0

			if var_74_13 < arg_71_1.time_ and arg_71_1.time_ <= var_74_13 + arg_74_0 then
				arg_71_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action3_2")
			end

			local var_74_14 = 0

			if var_74_14 < arg_71_1.time_ and arg_71_1.time_ <= var_74_14 + arg_74_0 then
				arg_71_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_74_15 = arg_71_1.actors_["1024ui_story"].transform
			local var_74_16 = 0

			if var_74_16 < arg_71_1.time_ and arg_71_1.time_ <= var_74_16 + arg_74_0 then
				arg_71_1.var_.moveOldPos1024ui_story = var_74_15.localPosition
			end

			local var_74_17 = 0.001

			if var_74_16 <= arg_71_1.time_ and arg_71_1.time_ < var_74_16 + var_74_17 then
				local var_74_18 = (arg_71_1.time_ - var_74_16) / var_74_17
				local var_74_19 = Vector3.New(0, 100, 0)

				var_74_15.localPosition = Vector3.Lerp(arg_71_1.var_.moveOldPos1024ui_story, var_74_19, var_74_18)

				local var_74_20 = manager.ui.mainCamera.transform.position - var_74_15.position

				var_74_15.forward = Vector3.New(var_74_20.x, var_74_20.y, var_74_20.z)

				local var_74_21 = var_74_15.localEulerAngles

				var_74_21.z = 0
				var_74_21.x = 0
				var_74_15.localEulerAngles = var_74_21
			end

			if arg_71_1.time_ >= var_74_16 + var_74_17 and arg_71_1.time_ < var_74_16 + var_74_17 + arg_74_0 then
				var_74_15.localPosition = Vector3.New(0, 100, 0)

				local var_74_22 = manager.ui.mainCamera.transform.position - var_74_15.position

				var_74_15.forward = Vector3.New(var_74_22.x, var_74_22.y, var_74_22.z)

				local var_74_23 = var_74_15.localEulerAngles

				var_74_23.z = 0
				var_74_23.x = 0
				var_74_15.localEulerAngles = var_74_23
			end

			local var_74_24 = 0
			local var_74_25 = 0.6

			if var_74_24 < arg_71_1.time_ and arg_71_1.time_ <= var_74_24 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				local var_74_26 = arg_71_1:FormatText(StoryNameCfg[42].name)

				arg_71_1.leftNameTxt_.text = var_74_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_27 = arg_71_1:GetWordFromCfg(414121017)
				local var_74_28 = arg_71_1:FormatText(var_74_27.content)

				arg_71_1.text_.text = var_74_28

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_29 = 19
				local var_74_30 = utf8.len(var_74_28)
				local var_74_31 = var_74_29 <= 0 and var_74_25 or var_74_25 * (var_74_30 / var_74_29)

				if var_74_31 > 0 and var_74_25 < var_74_31 then
					arg_71_1.talkMaxDuration = var_74_31

					if var_74_31 + var_74_24 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_31 + var_74_24
					end
				end

				arg_71_1.text_.text = var_74_28
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)
				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_32 = math.max(var_74_25, arg_71_1.talkMaxDuration)

			if var_74_24 <= arg_71_1.time_ and arg_71_1.time_ < var_74_24 + var_74_32 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_24) / var_74_32

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_24 + var_74_32 and arg_71_1.time_ < var_74_24 + var_74_32 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_71_1:InitPlayNodeList()
	end,
	Play414121018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 414121018
		arg_75_1.duration_ = 5

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play414121019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			local var_78_0 = arg_75_1.actors_["4010ui_story"].transform
			local var_78_1 = 0

			if var_78_1 < arg_75_1.time_ and arg_75_1.time_ <= var_78_1 + arg_78_0 then
				arg_75_1.var_.moveOldPos4010ui_story = var_78_0.localPosition
			end

			local var_78_2 = 0.001

			if var_78_1 <= arg_75_1.time_ and arg_75_1.time_ < var_78_1 + var_78_2 then
				local var_78_3 = (arg_75_1.time_ - var_78_1) / var_78_2
				local var_78_4 = Vector3.New(0, 100, 0)

				var_78_0.localPosition = Vector3.Lerp(arg_75_1.var_.moveOldPos4010ui_story, var_78_4, var_78_3)

				local var_78_5 = manager.ui.mainCamera.transform.position - var_78_0.position

				var_78_0.forward = Vector3.New(var_78_5.x, var_78_5.y, var_78_5.z)

				local var_78_6 = var_78_0.localEulerAngles

				var_78_6.z = 0
				var_78_6.x = 0
				var_78_0.localEulerAngles = var_78_6
			end

			if arg_75_1.time_ >= var_78_1 + var_78_2 and arg_75_1.time_ < var_78_1 + var_78_2 + arg_78_0 then
				var_78_0.localPosition = Vector3.New(0, 100, 0)

				local var_78_7 = manager.ui.mainCamera.transform.position - var_78_0.position

				var_78_0.forward = Vector3.New(var_78_7.x, var_78_7.y, var_78_7.z)

				local var_78_8 = var_78_0.localEulerAngles

				var_78_8.z = 0
				var_78_8.x = 0
				var_78_0.localEulerAngles = var_78_8
			end

			local var_78_9 = arg_75_1.actors_["4010ui_story"]
			local var_78_10 = 0

			if var_78_10 < arg_75_1.time_ and arg_75_1.time_ <= var_78_10 + arg_78_0 and not isNil(var_78_9) and arg_75_1.var_.characterEffect4010ui_story == nil then
				arg_75_1.var_.characterEffect4010ui_story = var_78_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_78_11 = 0.200000002980232

			if var_78_10 <= arg_75_1.time_ and arg_75_1.time_ < var_78_10 + var_78_11 and not isNil(var_78_9) then
				local var_78_12 = (arg_75_1.time_ - var_78_10) / var_78_11

				if arg_75_1.var_.characterEffect4010ui_story and not isNil(var_78_9) then
					local var_78_13 = Mathf.Lerp(0, 0.5, var_78_12)

					arg_75_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_75_1.var_.characterEffect4010ui_story.fillRatio = var_78_13
				end
			end

			if arg_75_1.time_ >= var_78_10 + var_78_11 and arg_75_1.time_ < var_78_10 + var_78_11 + arg_78_0 and not isNil(var_78_9) and arg_75_1.var_.characterEffect4010ui_story then
				local var_78_14 = 0.5

				arg_75_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_75_1.var_.characterEffect4010ui_story.fillRatio = var_78_14
			end

			local var_78_15 = 0
			local var_78_16 = 0.9

			if var_78_15 < arg_75_1.time_ and arg_75_1.time_ <= var_78_15 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, false)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_17 = arg_75_1:GetWordFromCfg(414121018)
				local var_78_18 = arg_75_1:FormatText(var_78_17.content)

				arg_75_1.text_.text = var_78_18

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_19 = 36
				local var_78_20 = utf8.len(var_78_18)
				local var_78_21 = var_78_19 <= 0 and var_78_16 or var_78_16 * (var_78_20 / var_78_19)

				if var_78_21 > 0 and var_78_16 < var_78_21 then
					arg_75_1.talkMaxDuration = var_78_21

					if var_78_21 + var_78_15 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_21 + var_78_15
					end
				end

				arg_75_1.text_.text = var_78_18
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)
				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_22 = math.max(var_78_16, arg_75_1.talkMaxDuration)

			if var_78_15 <= arg_75_1.time_ and arg_75_1.time_ < var_78_15 + var_78_22 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_15) / var_78_22

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_15 + var_78_22 and arg_75_1.time_ < var_78_15 + var_78_22 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_75_1:InitPlayNodeList()
	end,
	Play414121019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 414121019
		arg_79_1.duration_ = 5

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play414121020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			local var_82_0 = 0
			local var_82_1 = 0.75

			if var_82_0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_0 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, false)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_2 = arg_79_1:GetWordFromCfg(414121019)
				local var_82_3 = arg_79_1:FormatText(var_82_2.content)

				arg_79_1.text_.text = var_82_3

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_4 = 30
				local var_82_5 = utf8.len(var_82_3)
				local var_82_6 = var_82_4 <= 0 and var_82_1 or var_82_1 * (var_82_5 / var_82_4)

				if var_82_6 > 0 and var_82_1 < var_82_6 then
					arg_79_1.talkMaxDuration = var_82_6

					if var_82_6 + var_82_0 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_6 + var_82_0
					end
				end

				arg_79_1.text_.text = var_82_3
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)
				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_7 = math.max(var_82_1, arg_79_1.talkMaxDuration)

			if var_82_0 <= arg_79_1.time_ and arg_79_1.time_ < var_82_0 + var_82_7 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_0) / var_82_7

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_0 + var_82_7 and arg_79_1.time_ < var_82_0 + var_82_7 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {}

		arg_79_1:InitPlayNodeList()
	end,
	Play414121020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 414121020
		arg_83_1.duration_ = 5

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play414121021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			local var_86_0 = "104902ui_story"

			if arg_83_1.actors_[var_86_0] == nil then
				local var_86_1 = Asset.Load("Char/" .. "104902ui_story")

				if not isNil(var_86_1) then
					local var_86_2 = Object.Instantiate(Asset.Load("Char/" .. "104902ui_story"), arg_83_1.stage_.transform)

					var_86_2.name = var_86_0
					var_86_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_83_1.actors_[var_86_0] = var_86_2

					local var_86_3 = var_86_2:GetComponentInChildren(typeof(CharacterEffect))

					var_86_3.enabled = true

					local var_86_4 = GameObjectTools.GetOrAddComponent(var_86_2, typeof(DynamicBoneHelper))

					if var_86_4 then
						var_86_4:EnableDynamicBone(false)
					end

					arg_83_1:ShowWeapon(var_86_3.transform, false)

					arg_83_1.var_[var_86_0 .. "Animator"] = var_86_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_83_1.var_[var_86_0 .. "Animator"].applyRootMotion = true
					arg_83_1.var_[var_86_0 .. "LipSync"] = var_86_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_86_5 = arg_83_1.actors_["104902ui_story"].transform
			local var_86_6 = 0

			if var_86_6 < arg_83_1.time_ and arg_83_1.time_ <= var_86_6 + arg_86_0 then
				arg_83_1.var_.moveOldPos104902ui_story = var_86_5.localPosition

				local var_86_7 = "104902ui_story"

				arg_83_1:ShowWeapon(arg_83_1.var_[var_86_7 .. "Animator"].transform, false)
			end

			local var_86_8 = 0.001

			if var_86_6 <= arg_83_1.time_ and arg_83_1.time_ < var_86_6 + var_86_8 then
				local var_86_9 = (arg_83_1.time_ - var_86_6) / var_86_8
				local var_86_10 = Vector3.New(0, -1.2, -6)

				var_86_5.localPosition = Vector3.Lerp(arg_83_1.var_.moveOldPos104902ui_story, var_86_10, var_86_9)

				local var_86_11 = manager.ui.mainCamera.transform.position - var_86_5.position

				var_86_5.forward = Vector3.New(var_86_11.x, var_86_11.y, var_86_11.z)

				local var_86_12 = var_86_5.localEulerAngles

				var_86_12.z = 0
				var_86_12.x = 0
				var_86_5.localEulerAngles = var_86_12
			end

			if arg_83_1.time_ >= var_86_6 + var_86_8 and arg_83_1.time_ < var_86_6 + var_86_8 + arg_86_0 then
				var_86_5.localPosition = Vector3.New(0, -1.2, -6)

				local var_86_13 = manager.ui.mainCamera.transform.position - var_86_5.position

				var_86_5.forward = Vector3.New(var_86_13.x, var_86_13.y, var_86_13.z)

				local var_86_14 = var_86_5.localEulerAngles

				var_86_14.z = 0
				var_86_14.x = 0
				var_86_5.localEulerAngles = var_86_14
			end

			local var_86_15 = arg_83_1.actors_["104902ui_story"]
			local var_86_16 = 0

			if var_86_16 < arg_83_1.time_ and arg_83_1.time_ <= var_86_16 + arg_86_0 and not isNil(var_86_15) and arg_83_1.var_.characterEffect104902ui_story == nil then
				arg_83_1.var_.characterEffect104902ui_story = var_86_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_86_17 = 0.200000002980232

			if var_86_16 <= arg_83_1.time_ and arg_83_1.time_ < var_86_16 + var_86_17 and not isNil(var_86_15) then
				local var_86_18 = (arg_83_1.time_ - var_86_16) / var_86_17

				if arg_83_1.var_.characterEffect104902ui_story and not isNil(var_86_15) then
					arg_83_1.var_.characterEffect104902ui_story.fillFlat = false
				end
			end

			if arg_83_1.time_ >= var_86_16 + var_86_17 and arg_83_1.time_ < var_86_16 + var_86_17 + arg_86_0 and not isNil(var_86_15) and arg_83_1.var_.characterEffect104902ui_story then
				arg_83_1.var_.characterEffect104902ui_story.fillFlat = false
			end

			local var_86_19 = 0

			if var_86_19 < arg_83_1.time_ and arg_83_1.time_ <= var_86_19 + arg_86_0 then
				arg_83_1:PlayTimeline("104902ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_86_20 = 0

			if var_86_20 < arg_83_1.time_ and arg_83_1.time_ <= var_86_20 + arg_86_0 then
				arg_83_1:PlayTimeline("104902ui_story", "StoryTimeline/CharAction/story104902/story104902action/104902action1_1")
			end

			local var_86_21 = 0
			local var_86_22 = 0.125

			if var_86_21 < arg_83_1.time_ and arg_83_1.time_ <= var_86_21 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				local var_86_23 = arg_83_1:FormatText(StoryNameCfg[562].name)

				arg_83_1.leftNameTxt_.text = var_86_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_24 = arg_83_1:GetWordFromCfg(414121020)
				local var_86_25 = arg_83_1:FormatText(var_86_24.content)

				arg_83_1.text_.text = var_86_25

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_26 = 5
				local var_86_27 = utf8.len(var_86_25)
				local var_86_28 = var_86_26 <= 0 and var_86_22 or var_86_22 * (var_86_27 / var_86_26)

				if var_86_28 > 0 and var_86_22 < var_86_28 then
					arg_83_1.talkMaxDuration = var_86_28

					if var_86_28 + var_86_21 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_28 + var_86_21
					end
				end

				arg_83_1.text_.text = var_86_25
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)
				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_29 = math.max(var_86_22, arg_83_1.talkMaxDuration)

			if var_86_21 <= arg_83_1.time_ and arg_83_1.time_ < var_86_21 + var_86_29 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_21) / var_86_29

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_21 + var_86_29 and arg_83_1.time_ < var_86_21 + var_86_29 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104902ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_83_1:InitPlayNodeList()
	end,
	Play414121021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 414121021
		arg_87_1.duration_ = 5

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play414121022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			local var_90_0 = arg_87_1.actors_["104902ui_story"]
			local var_90_1 = 0

			if var_90_1 < arg_87_1.time_ and arg_87_1.time_ <= var_90_1 + arg_90_0 and not isNil(var_90_0) and arg_87_1.var_.characterEffect104902ui_story == nil then
				arg_87_1.var_.characterEffect104902ui_story = var_90_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_90_2 = 0.200000002980232

			if var_90_1 <= arg_87_1.time_ and arg_87_1.time_ < var_90_1 + var_90_2 and not isNil(var_90_0) then
				local var_90_3 = (arg_87_1.time_ - var_90_1) / var_90_2

				if arg_87_1.var_.characterEffect104902ui_story and not isNil(var_90_0) then
					local var_90_4 = Mathf.Lerp(0, 0.5, var_90_3)

					arg_87_1.var_.characterEffect104902ui_story.fillFlat = true
					arg_87_1.var_.characterEffect104902ui_story.fillRatio = var_90_4
				end
			end

			if arg_87_1.time_ >= var_90_1 + var_90_2 and arg_87_1.time_ < var_90_1 + var_90_2 + arg_90_0 and not isNil(var_90_0) and arg_87_1.var_.characterEffect104902ui_story then
				local var_90_5 = 0.5

				arg_87_1.var_.characterEffect104902ui_story.fillFlat = true
				arg_87_1.var_.characterEffect104902ui_story.fillRatio = var_90_5
			end

			local var_90_6 = 0
			local var_90_7 = 0.525

			if var_90_6 < arg_87_1.time_ and arg_87_1.time_ <= var_90_6 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, false)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_8 = arg_87_1:GetWordFromCfg(414121021)
				local var_90_9 = arg_87_1:FormatText(var_90_8.content)

				arg_87_1.text_.text = var_90_9

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_10 = 21
				local var_90_11 = utf8.len(var_90_9)
				local var_90_12 = var_90_10 <= 0 and var_90_7 or var_90_7 * (var_90_11 / var_90_10)

				if var_90_12 > 0 and var_90_7 < var_90_12 then
					arg_87_1.talkMaxDuration = var_90_12

					if var_90_12 + var_90_6 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_12 + var_90_6
					end
				end

				arg_87_1.text_.text = var_90_9
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)
				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_13 = math.max(var_90_7, arg_87_1.talkMaxDuration)

			if var_90_6 <= arg_87_1.time_ and arg_87_1.time_ < var_90_6 + var_90_13 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_6) / var_90_13

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_6 + var_90_13 and arg_87_1.time_ < var_90_6 + var_90_13 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {}

		arg_87_1:InitPlayNodeList()
	end,
	Play414121022 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 414121022
		arg_91_1.duration_ = 5

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play414121023(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			local var_94_0 = 0
			local var_94_1 = 1.25

			if var_94_0 < arg_91_1.time_ and arg_91_1.time_ <= var_94_0 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				local var_94_2 = arg_91_1:FormatText(StoryNameCfg[7].name)

				arg_91_1.leftNameTxt_.text = var_94_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, true)
				arg_91_1.iconController_:SetSelectedState("hero")

				arg_91_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_91_1.callingController_:SetSelectedState("normal")

				arg_91_1.keyicon_.color = Color.New(1, 1, 1)
				arg_91_1.icon_.color = Color.New(1, 1, 1)

				local var_94_3 = arg_91_1:GetWordFromCfg(414121022)
				local var_94_4 = arg_91_1:FormatText(var_94_3.content)

				arg_91_1.text_.text = var_94_4

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_5 = 50
				local var_94_6 = utf8.len(var_94_4)
				local var_94_7 = var_94_5 <= 0 and var_94_1 or var_94_1 * (var_94_6 / var_94_5)

				if var_94_7 > 0 and var_94_1 < var_94_7 then
					arg_91_1.talkMaxDuration = var_94_7

					if var_94_7 + var_94_0 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_7 + var_94_0
					end
				end

				arg_91_1.text_.text = var_94_4
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)
				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_8 = math.max(var_94_1, arg_91_1.talkMaxDuration)

			if var_94_0 <= arg_91_1.time_ and arg_91_1.time_ < var_94_0 + var_94_8 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_0) / var_94_8

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_0 + var_94_8 and arg_91_1.time_ < var_94_0 + var_94_8 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {}

		arg_91_1:InitPlayNodeList()
	end,
	Play414121023 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 414121023
		arg_95_1.duration_ = 5

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play414121024(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			local var_98_0 = 0
			local var_98_1 = 0.875

			if var_98_0 < arg_95_1.time_ and arg_95_1.time_ <= var_98_0 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				local var_98_2 = arg_95_1:FormatText(StoryNameCfg[7].name)

				arg_95_1.leftNameTxt_.text = var_98_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, true)
				arg_95_1.iconController_:SetSelectedState("hero")

				arg_95_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_95_1.callingController_:SetSelectedState("normal")

				arg_95_1.keyicon_.color = Color.New(1, 1, 1)
				arg_95_1.icon_.color = Color.New(1, 1, 1)

				local var_98_3 = arg_95_1:GetWordFromCfg(414121023)
				local var_98_4 = arg_95_1:FormatText(var_98_3.content)

				arg_95_1.text_.text = var_98_4

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_5 = 35
				local var_98_6 = utf8.len(var_98_4)
				local var_98_7 = var_98_5 <= 0 and var_98_1 or var_98_1 * (var_98_6 / var_98_5)

				if var_98_7 > 0 and var_98_1 < var_98_7 then
					arg_95_1.talkMaxDuration = var_98_7

					if var_98_7 + var_98_0 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_7 + var_98_0
					end
				end

				arg_95_1.text_.text = var_98_4
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)
				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_8 = math.max(var_98_1, arg_95_1.talkMaxDuration)

			if var_98_0 <= arg_95_1.time_ and arg_95_1.time_ < var_98_0 + var_98_8 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_0) / var_98_8

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_0 + var_98_8 and arg_95_1.time_ < var_98_0 + var_98_8 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {}

		arg_95_1:InitPlayNodeList()
	end,
	Play414121024 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 414121024
		arg_99_1.duration_ = 5

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play414121025(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			local var_102_0 = arg_99_1.actors_["104902ui_story"].transform
			local var_102_1 = 0

			if var_102_1 < arg_99_1.time_ and arg_99_1.time_ <= var_102_1 + arg_102_0 then
				arg_99_1.var_.moveOldPos104902ui_story = var_102_0.localPosition

				local var_102_2 = "104902ui_story"

				arg_99_1:ShowWeapon(arg_99_1.var_[var_102_2 .. "Animator"].transform, false)
			end

			local var_102_3 = 0.001

			if var_102_1 <= arg_99_1.time_ and arg_99_1.time_ < var_102_1 + var_102_3 then
				local var_102_4 = (arg_99_1.time_ - var_102_1) / var_102_3
				local var_102_5 = Vector3.New(0, -1.2, -6)

				var_102_0.localPosition = Vector3.Lerp(arg_99_1.var_.moveOldPos104902ui_story, var_102_5, var_102_4)

				local var_102_6 = manager.ui.mainCamera.transform.position - var_102_0.position

				var_102_0.forward = Vector3.New(var_102_6.x, var_102_6.y, var_102_6.z)

				local var_102_7 = var_102_0.localEulerAngles

				var_102_7.z = 0
				var_102_7.x = 0
				var_102_0.localEulerAngles = var_102_7
			end

			if arg_99_1.time_ >= var_102_1 + var_102_3 and arg_99_1.time_ < var_102_1 + var_102_3 + arg_102_0 then
				var_102_0.localPosition = Vector3.New(0, -1.2, -6)

				local var_102_8 = manager.ui.mainCamera.transform.position - var_102_0.position

				var_102_0.forward = Vector3.New(var_102_8.x, var_102_8.y, var_102_8.z)

				local var_102_9 = var_102_0.localEulerAngles

				var_102_9.z = 0
				var_102_9.x = 0
				var_102_0.localEulerAngles = var_102_9
			end

			local var_102_10 = arg_99_1.actors_["104902ui_story"]
			local var_102_11 = 0

			if var_102_11 < arg_99_1.time_ and arg_99_1.time_ <= var_102_11 + arg_102_0 and not isNil(var_102_10) and arg_99_1.var_.characterEffect104902ui_story == nil then
				arg_99_1.var_.characterEffect104902ui_story = var_102_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_102_12 = 0.200000002980232

			if var_102_11 <= arg_99_1.time_ and arg_99_1.time_ < var_102_11 + var_102_12 and not isNil(var_102_10) then
				local var_102_13 = (arg_99_1.time_ - var_102_11) / var_102_12

				if arg_99_1.var_.characterEffect104902ui_story and not isNil(var_102_10) then
					arg_99_1.var_.characterEffect104902ui_story.fillFlat = false
				end
			end

			if arg_99_1.time_ >= var_102_11 + var_102_12 and arg_99_1.time_ < var_102_11 + var_102_12 + arg_102_0 and not isNil(var_102_10) and arg_99_1.var_.characterEffect104902ui_story then
				arg_99_1.var_.characterEffect104902ui_story.fillFlat = false
			end

			local var_102_14 = 0

			if var_102_14 < arg_99_1.time_ and arg_99_1.time_ <= var_102_14 + arg_102_0 then
				arg_99_1:PlayTimeline("104902ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_102_15 = 0

			if var_102_15 < arg_99_1.time_ and arg_99_1.time_ <= var_102_15 + arg_102_0 then
				arg_99_1:PlayTimeline("104902ui_story", "StoryTimeline/CharAction/story104902/story104902action/104902action3_1")
			end

			local var_102_16 = 0
			local var_102_17 = 0.125

			if var_102_16 < arg_99_1.time_ and arg_99_1.time_ <= var_102_16 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, true)

				local var_102_18 = arg_99_1:FormatText(StoryNameCfg[562].name)

				arg_99_1.leftNameTxt_.text = var_102_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_19 = arg_99_1:GetWordFromCfg(414121024)
				local var_102_20 = arg_99_1:FormatText(var_102_19.content)

				arg_99_1.text_.text = var_102_20

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_21 = 5
				local var_102_22 = utf8.len(var_102_20)
				local var_102_23 = var_102_21 <= 0 and var_102_17 or var_102_17 * (var_102_22 / var_102_21)

				if var_102_23 > 0 and var_102_17 < var_102_23 then
					arg_99_1.talkMaxDuration = var_102_23

					if var_102_23 + var_102_16 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_23 + var_102_16
					end
				end

				arg_99_1.text_.text = var_102_20
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)
				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_24 = math.max(var_102_17, arg_99_1.talkMaxDuration)

			if var_102_16 <= arg_99_1.time_ and arg_99_1.time_ < var_102_16 + var_102_24 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_16) / var_102_24

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_16 + var_102_24 and arg_99_1.time_ < var_102_16 + var_102_24 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104902ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_99_1:InitPlayNodeList()
	end,
	Play414121025 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 414121025
		arg_103_1.duration_ = 1

		SetActive(arg_103_1.tipsGo_, false)

		function arg_103_1.onSingleLineFinish_()
			arg_103_1.onSingleLineUpdate_ = nil
			arg_103_1.onSingleLineFinish_ = nil
			arg_103_1.state_ = "waiting"

			SetActive(arg_103_1.choicesGo_, true)

			for iter_104_0, iter_104_1 in ipairs(arg_103_1.choices_) do
				local var_104_0 = iter_104_0 <= 2

				SetActive(iter_104_1.go, var_104_0)
			end

			arg_103_1.choices_[1].txt.text = arg_103_1:FormatText(StoryChoiceCfg[843].name)
			arg_103_1.choices_[2].txt.text = arg_103_1:FormatText(StoryChoiceCfg[844].name)
		end

		function arg_103_1.playNext_(arg_105_0)
			if arg_105_0 == 1 then
				arg_103_0:Play414121026(arg_103_1)
			end

			if arg_105_0 == 2 then
				arg_103_0:Play414121026(arg_103_1)
			end

			arg_103_1:RecordChoiceLog(414121025, 843, 844)
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			local var_106_0 = arg_103_1.actors_["104902ui_story"]
			local var_106_1 = 0

			if var_106_1 < arg_103_1.time_ and arg_103_1.time_ <= var_106_1 + arg_106_0 and not isNil(var_106_0) and arg_103_1.var_.characterEffect104902ui_story == nil then
				arg_103_1.var_.characterEffect104902ui_story = var_106_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_106_2 = 0.200000002980232

			if var_106_1 <= arg_103_1.time_ and arg_103_1.time_ < var_106_1 + var_106_2 and not isNil(var_106_0) then
				local var_106_3 = (arg_103_1.time_ - var_106_1) / var_106_2

				if arg_103_1.var_.characterEffect104902ui_story and not isNil(var_106_0) then
					local var_106_4 = Mathf.Lerp(0, 0.5, var_106_3)

					arg_103_1.var_.characterEffect104902ui_story.fillFlat = true
					arg_103_1.var_.characterEffect104902ui_story.fillRatio = var_106_4
				end
			end

			if arg_103_1.time_ >= var_106_1 + var_106_2 and arg_103_1.time_ < var_106_1 + var_106_2 + arg_106_0 and not isNil(var_106_0) and arg_103_1.var_.characterEffect104902ui_story then
				local var_106_5 = 0.5

				arg_103_1.var_.characterEffect104902ui_story.fillFlat = true
				arg_103_1.var_.characterEffect104902ui_story.fillRatio = var_106_5
			end
		end

		arg_103_1.nodeConfigList_ = {}

		arg_103_1:InitPlayNodeList()
	end,
	Play414121026 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 414121026
		arg_107_1.duration_ = 5

		SetActive(arg_107_1.tipsGo_, false)

		function arg_107_1.onSingleLineFinish_()
			arg_107_1.onSingleLineUpdate_ = nil
			arg_107_1.onSingleLineFinish_ = nil
			arg_107_1.state_ = "waiting"
		end

		function arg_107_1.playNext_(arg_109_0)
			if arg_109_0 == 1 then
				arg_107_0:Play414121027(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			local var_110_0 = 0
			local var_110_1 = 1.225

			if var_110_0 < arg_107_1.time_ and arg_107_1.time_ <= var_110_0 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				local var_110_2 = arg_107_1:FormatText(StoryNameCfg[7].name)

				arg_107_1.leftNameTxt_.text = var_110_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, true)
				arg_107_1.iconController_:SetSelectedState("hero")

				arg_107_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_107_1.callingController_:SetSelectedState("normal")

				arg_107_1.keyicon_.color = Color.New(1, 1, 1)
				arg_107_1.icon_.color = Color.New(1, 1, 1)

				local var_110_3 = arg_107_1:GetWordFromCfg(414121026)
				local var_110_4 = arg_107_1:FormatText(var_110_3.content)

				arg_107_1.text_.text = var_110_4

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_5 = 49
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
				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_8 = math.max(var_110_1, arg_107_1.talkMaxDuration)

			if var_110_0 <= arg_107_1.time_ and arg_107_1.time_ < var_110_0 + var_110_8 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_0) / var_110_8

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_0 + var_110_8 and arg_107_1.time_ < var_110_0 + var_110_8 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {}

		arg_107_1:InitPlayNodeList()
	end,
	Play414121027 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 414121027
		arg_111_1.duration_ = 5

		SetActive(arg_111_1.tipsGo_, false)

		function arg_111_1.onSingleLineFinish_()
			arg_111_1.onSingleLineUpdate_ = nil
			arg_111_1.onSingleLineFinish_ = nil
			arg_111_1.state_ = "waiting"
		end

		function arg_111_1.playNext_(arg_113_0)
			if arg_113_0 == 1 then
				arg_111_0:Play414121028(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = arg_111_1.actors_["104902ui_story"].transform
			local var_114_1 = 0

			if var_114_1 < arg_111_1.time_ and arg_111_1.time_ <= var_114_1 + arg_114_0 then
				arg_111_1.var_.moveOldPos104902ui_story = var_114_0.localPosition
			end

			local var_114_2 = 0.001

			if var_114_1 <= arg_111_1.time_ and arg_111_1.time_ < var_114_1 + var_114_2 then
				local var_114_3 = (arg_111_1.time_ - var_114_1) / var_114_2
				local var_114_4 = Vector3.New(0, -1.2, -6)

				var_114_0.localPosition = Vector3.Lerp(arg_111_1.var_.moveOldPos104902ui_story, var_114_4, var_114_3)

				local var_114_5 = manager.ui.mainCamera.transform.position - var_114_0.position

				var_114_0.forward = Vector3.New(var_114_5.x, var_114_5.y, var_114_5.z)

				local var_114_6 = var_114_0.localEulerAngles

				var_114_6.z = 0
				var_114_6.x = 0
				var_114_0.localEulerAngles = var_114_6
			end

			if arg_111_1.time_ >= var_114_1 + var_114_2 and arg_111_1.time_ < var_114_1 + var_114_2 + arg_114_0 then
				var_114_0.localPosition = Vector3.New(0, -1.2, -6)

				local var_114_7 = manager.ui.mainCamera.transform.position - var_114_0.position

				var_114_0.forward = Vector3.New(var_114_7.x, var_114_7.y, var_114_7.z)

				local var_114_8 = var_114_0.localEulerAngles

				var_114_8.z = 0
				var_114_8.x = 0
				var_114_0.localEulerAngles = var_114_8
			end

			local var_114_9 = arg_111_1.actors_["104902ui_story"]
			local var_114_10 = 0

			if var_114_10 < arg_111_1.time_ and arg_111_1.time_ <= var_114_10 + arg_114_0 and not isNil(var_114_9) and arg_111_1.var_.characterEffect104902ui_story == nil then
				arg_111_1.var_.characterEffect104902ui_story = var_114_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_114_11 = 0.200000002980232

			if var_114_10 <= arg_111_1.time_ and arg_111_1.time_ < var_114_10 + var_114_11 and not isNil(var_114_9) then
				local var_114_12 = (arg_111_1.time_ - var_114_10) / var_114_11

				if arg_111_1.var_.characterEffect104902ui_story and not isNil(var_114_9) then
					arg_111_1.var_.characterEffect104902ui_story.fillFlat = false
				end
			end

			if arg_111_1.time_ >= var_114_10 + var_114_11 and arg_111_1.time_ < var_114_10 + var_114_11 + arg_114_0 and not isNil(var_114_9) and arg_111_1.var_.characterEffect104902ui_story then
				arg_111_1.var_.characterEffect104902ui_story.fillFlat = false
			end

			local var_114_13 = 0

			if var_114_13 < arg_111_1.time_ and arg_111_1.time_ <= var_114_13 + arg_114_0 then
				arg_111_1:PlayTimeline("104902ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_114_14 = 0

			if var_114_14 < arg_111_1.time_ and arg_111_1.time_ <= var_114_14 + arg_114_0 then
				arg_111_1:PlayTimeline("104902ui_story", "StoryTimeline/CharAction/story104902/story104902action/104902action3_2")
			end

			local var_114_15 = 0
			local var_114_16 = 0.375

			if var_114_15 < arg_111_1.time_ and arg_111_1.time_ <= var_114_15 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				local var_114_17 = arg_111_1:FormatText(StoryNameCfg[562].name)

				arg_111_1.leftNameTxt_.text = var_114_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_18 = arg_111_1:GetWordFromCfg(414121027)
				local var_114_19 = arg_111_1:FormatText(var_114_18.content)

				arg_111_1.text_.text = var_114_19

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_20 = 16
				local var_114_21 = utf8.len(var_114_19)
				local var_114_22 = var_114_20 <= 0 and var_114_16 or var_114_16 * (var_114_21 / var_114_20)

				if var_114_22 > 0 and var_114_16 < var_114_22 then
					arg_111_1.talkMaxDuration = var_114_22

					if var_114_22 + var_114_15 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_22 + var_114_15
					end
				end

				arg_111_1.text_.text = var_114_19
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)
				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_23 = math.max(var_114_16, arg_111_1.talkMaxDuration)

			if var_114_15 <= arg_111_1.time_ and arg_111_1.time_ < var_114_15 + var_114_23 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_15) / var_114_23

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_15 + var_114_23 and arg_111_1.time_ < var_114_15 + var_114_23 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104902ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_111_1:InitPlayNodeList()
	end,
	Play414121028 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 414121028
		arg_115_1.duration_ = 5

		SetActive(arg_115_1.tipsGo_, false)

		function arg_115_1.onSingleLineFinish_()
			arg_115_1.onSingleLineUpdate_ = nil
			arg_115_1.onSingleLineFinish_ = nil
			arg_115_1.state_ = "waiting"
		end

		function arg_115_1.playNext_(arg_117_0)
			if arg_117_0 == 1 then
				arg_115_0:Play414121029(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			local var_118_0 = arg_115_1.actors_["104902ui_story"]
			local var_118_1 = 0

			if var_118_1 < arg_115_1.time_ and arg_115_1.time_ <= var_118_1 + arg_118_0 and not isNil(var_118_0) and arg_115_1.var_.characterEffect104902ui_story == nil then
				arg_115_1.var_.characterEffect104902ui_story = var_118_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_2 = 0.200000002980232

			if var_118_1 <= arg_115_1.time_ and arg_115_1.time_ < var_118_1 + var_118_2 and not isNil(var_118_0) then
				local var_118_3 = (arg_115_1.time_ - var_118_1) / var_118_2

				if arg_115_1.var_.characterEffect104902ui_story and not isNil(var_118_0) then
					local var_118_4 = Mathf.Lerp(0, 0.5, var_118_3)

					arg_115_1.var_.characterEffect104902ui_story.fillFlat = true
					arg_115_1.var_.characterEffect104902ui_story.fillRatio = var_118_4
				end
			end

			if arg_115_1.time_ >= var_118_1 + var_118_2 and arg_115_1.time_ < var_118_1 + var_118_2 + arg_118_0 and not isNil(var_118_0) and arg_115_1.var_.characterEffect104902ui_story then
				local var_118_5 = 0.5

				arg_115_1.var_.characterEffect104902ui_story.fillFlat = true
				arg_115_1.var_.characterEffect104902ui_story.fillRatio = var_118_5
			end

			local var_118_6 = "1081ui_story"

			if arg_115_1.actors_[var_118_6] == nil then
				local var_118_7 = Asset.Load("Char/" .. "1081ui_story")

				if not isNil(var_118_7) then
					local var_118_8 = Object.Instantiate(Asset.Load("Char/" .. "1081ui_story"), arg_115_1.stage_.transform)

					var_118_8.name = var_118_6
					var_118_8.transform.localPosition = Vector3.New(0, 100, 0)
					arg_115_1.actors_[var_118_6] = var_118_8

					local var_118_9 = var_118_8:GetComponentInChildren(typeof(CharacterEffect))

					var_118_9.enabled = true

					local var_118_10 = GameObjectTools.GetOrAddComponent(var_118_8, typeof(DynamicBoneHelper))

					if var_118_10 then
						var_118_10:EnableDynamicBone(false)
					end

					arg_115_1:ShowWeapon(var_118_9.transform, false)

					arg_115_1.var_[var_118_6 .. "Animator"] = var_118_9.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_115_1.var_[var_118_6 .. "Animator"].applyRootMotion = true
					arg_115_1.var_[var_118_6 .. "LipSync"] = var_118_9.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_118_11 = arg_115_1.actors_["1081ui_story"].transform
			local var_118_12 = 0

			if var_118_12 < arg_115_1.time_ and arg_115_1.time_ <= var_118_12 + arg_118_0 then
				arg_115_1.var_.moveOldPos1081ui_story = var_118_11.localPosition

				local var_118_13 = "1081ui_story"

				arg_115_1:ShowWeapon(arg_115_1.var_[var_118_13 .. "Animator"].transform, false)
			end

			local var_118_14 = 0.001

			if var_118_12 <= arg_115_1.time_ and arg_115_1.time_ < var_118_12 + var_118_14 then
				local var_118_15 = (arg_115_1.time_ - var_118_12) / var_118_14
				local var_118_16 = Vector3.New(0, -0.92, -5.8)

				var_118_11.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos1081ui_story, var_118_16, var_118_15)

				local var_118_17 = manager.ui.mainCamera.transform.position - var_118_11.position

				var_118_11.forward = Vector3.New(var_118_17.x, var_118_17.y, var_118_17.z)

				local var_118_18 = var_118_11.localEulerAngles

				var_118_18.z = 0
				var_118_18.x = 0
				var_118_11.localEulerAngles = var_118_18
			end

			if arg_115_1.time_ >= var_118_12 + var_118_14 and arg_115_1.time_ < var_118_12 + var_118_14 + arg_118_0 then
				var_118_11.localPosition = Vector3.New(0, -0.92, -5.8)

				local var_118_19 = manager.ui.mainCamera.transform.position - var_118_11.position

				var_118_11.forward = Vector3.New(var_118_19.x, var_118_19.y, var_118_19.z)

				local var_118_20 = var_118_11.localEulerAngles

				var_118_20.z = 0
				var_118_20.x = 0
				var_118_11.localEulerAngles = var_118_20
			end

			local var_118_21 = arg_115_1.actors_["1081ui_story"]
			local var_118_22 = 0

			if var_118_22 < arg_115_1.time_ and arg_115_1.time_ <= var_118_22 + arg_118_0 and not isNil(var_118_21) and arg_115_1.var_.characterEffect1081ui_story == nil then
				arg_115_1.var_.characterEffect1081ui_story = var_118_21:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_23 = 0.200000002980232

			if var_118_22 <= arg_115_1.time_ and arg_115_1.time_ < var_118_22 + var_118_23 and not isNil(var_118_21) then
				local var_118_24 = (arg_115_1.time_ - var_118_22) / var_118_23

				if arg_115_1.var_.characterEffect1081ui_story and not isNil(var_118_21) then
					arg_115_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_115_1.time_ >= var_118_22 + var_118_23 and arg_115_1.time_ < var_118_22 + var_118_23 + arg_118_0 and not isNil(var_118_21) and arg_115_1.var_.characterEffect1081ui_story then
				arg_115_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			local var_118_25 = 0

			if var_118_25 < arg_115_1.time_ and arg_115_1.time_ <= var_118_25 + arg_118_0 then
				arg_115_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action5_1")
			end

			local var_118_26 = 0

			if var_118_26 < arg_115_1.time_ and arg_115_1.time_ <= var_118_26 + arg_118_0 then
				arg_115_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1304cva")
			end

			local var_118_27 = arg_115_1.actors_["104902ui_story"].transform
			local var_118_28 = 0

			if var_118_28 < arg_115_1.time_ and arg_115_1.time_ <= var_118_28 + arg_118_0 then
				arg_115_1.var_.moveOldPos104902ui_story = var_118_27.localPosition
			end

			local var_118_29 = 0.001

			if var_118_28 <= arg_115_1.time_ and arg_115_1.time_ < var_118_28 + var_118_29 then
				local var_118_30 = (arg_115_1.time_ - var_118_28) / var_118_29
				local var_118_31 = Vector3.New(0, 100, 0)

				var_118_27.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos104902ui_story, var_118_31, var_118_30)

				local var_118_32 = manager.ui.mainCamera.transform.position - var_118_27.position

				var_118_27.forward = Vector3.New(var_118_32.x, var_118_32.y, var_118_32.z)

				local var_118_33 = var_118_27.localEulerAngles

				var_118_33.z = 0
				var_118_33.x = 0
				var_118_27.localEulerAngles = var_118_33
			end

			if arg_115_1.time_ >= var_118_28 + var_118_29 and arg_115_1.time_ < var_118_28 + var_118_29 + arg_118_0 then
				var_118_27.localPosition = Vector3.New(0, 100, 0)

				local var_118_34 = manager.ui.mainCamera.transform.position - var_118_27.position

				var_118_27.forward = Vector3.New(var_118_34.x, var_118_34.y, var_118_34.z)

				local var_118_35 = var_118_27.localEulerAngles

				var_118_35.z = 0
				var_118_35.x = 0
				var_118_27.localEulerAngles = var_118_35
			end

			local var_118_36 = 0
			local var_118_37 = 0.1

			if var_118_36 < arg_115_1.time_ and arg_115_1.time_ <= var_118_36 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				local var_118_38 = arg_115_1:FormatText(StoryNameCfg[202].name)

				arg_115_1.leftNameTxt_.text = var_118_38

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_39 = arg_115_1:GetWordFromCfg(414121028)
				local var_118_40 = arg_115_1:FormatText(var_118_39.content)

				arg_115_1.text_.text = var_118_40

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_41 = 31
				local var_118_42 = utf8.len(var_118_40)
				local var_118_43 = var_118_41 <= 0 and var_118_37 or var_118_37 * (var_118_42 / var_118_41)

				if var_118_43 > 0 and var_118_37 < var_118_43 then
					arg_115_1.talkMaxDuration = var_118_43

					if var_118_43 + var_118_36 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_43 + var_118_36
					end
				end

				arg_115_1.text_.text = var_118_40
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)
				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_44 = math.max(var_118_37, arg_115_1.talkMaxDuration)

			if var_118_36 <= arg_115_1.time_ and arg_115_1.time_ < var_118_36 + var_118_44 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_36) / var_118_44

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_36 + var_118_44 and arg_115_1.time_ < var_118_36 + var_118_44 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "104902ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_115_1:InitPlayNodeList()
	end,
	Play414121029 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 414121029
		arg_119_1.duration_ = 5

		SetActive(arg_119_1.tipsGo_, false)

		function arg_119_1.onSingleLineFinish_()
			arg_119_1.onSingleLineUpdate_ = nil
			arg_119_1.onSingleLineFinish_ = nil
			arg_119_1.state_ = "waiting"
		end

		function arg_119_1.playNext_(arg_121_0)
			if arg_121_0 == 1 then
				arg_119_0:Play414121030(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = arg_119_1.actors_["1081ui_story"]
			local var_122_1 = 0

			if var_122_1 < arg_119_1.time_ and arg_119_1.time_ <= var_122_1 + arg_122_0 and not isNil(var_122_0) and arg_119_1.var_.characterEffect1081ui_story == nil then
				arg_119_1.var_.characterEffect1081ui_story = var_122_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_2 = 0.200000002980232

			if var_122_1 <= arg_119_1.time_ and arg_119_1.time_ < var_122_1 + var_122_2 and not isNil(var_122_0) then
				local var_122_3 = (arg_119_1.time_ - var_122_1) / var_122_2

				if arg_119_1.var_.characterEffect1081ui_story and not isNil(var_122_0) then
					local var_122_4 = Mathf.Lerp(0, 0.5, var_122_3)

					arg_119_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_119_1.var_.characterEffect1081ui_story.fillRatio = var_122_4
				end
			end

			if arg_119_1.time_ >= var_122_1 + var_122_2 and arg_119_1.time_ < var_122_1 + var_122_2 + arg_122_0 and not isNil(var_122_0) and arg_119_1.var_.characterEffect1081ui_story then
				local var_122_5 = 0.5

				arg_119_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_119_1.var_.characterEffect1081ui_story.fillRatio = var_122_5
			end

			local var_122_6 = 0
			local var_122_7 = 0.525

			if var_122_6 < arg_119_1.time_ and arg_119_1.time_ <= var_122_6 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				local var_122_8 = arg_119_1:FormatText(StoryNameCfg[7].name)

				arg_119_1.leftNameTxt_.text = var_122_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, true)
				arg_119_1.iconController_:SetSelectedState("hero")

				arg_119_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_119_1.callingController_:SetSelectedState("normal")

				arg_119_1.keyicon_.color = Color.New(1, 1, 1)
				arg_119_1.icon_.color = Color.New(1, 1, 1)

				local var_122_9 = arg_119_1:GetWordFromCfg(414121029)
				local var_122_10 = arg_119_1:FormatText(var_122_9.content)

				arg_119_1.text_.text = var_122_10

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_11 = 35
				local var_122_12 = utf8.len(var_122_10)
				local var_122_13 = var_122_11 <= 0 and var_122_7 or var_122_7 * (var_122_12 / var_122_11)

				if var_122_13 > 0 and var_122_7 < var_122_13 then
					arg_119_1.talkMaxDuration = var_122_13

					if var_122_13 + var_122_6 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_13 + var_122_6
					end
				end

				arg_119_1.text_.text = var_122_10
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)
				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_14 = math.max(var_122_7, arg_119_1.talkMaxDuration)

			if var_122_6 <= arg_119_1.time_ and arg_119_1.time_ < var_122_6 + var_122_14 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_6) / var_122_14

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_6 + var_122_14 and arg_119_1.time_ < var_122_6 + var_122_14 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {}

		arg_119_1:InitPlayNodeList()
	end,
	Play414121030 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 414121030
		arg_123_1.duration_ = 5

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play414121031(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = arg_123_1.actors_["104902ui_story"].transform
			local var_126_1 = 0

			if var_126_1 < arg_123_1.time_ and arg_123_1.time_ <= var_126_1 + arg_126_0 then
				arg_123_1.var_.moveOldPos104902ui_story = var_126_0.localPosition
			end

			local var_126_2 = 0.001

			if var_126_1 <= arg_123_1.time_ and arg_123_1.time_ < var_126_1 + var_126_2 then
				local var_126_3 = (arg_123_1.time_ - var_126_1) / var_126_2
				local var_126_4 = Vector3.New(0, -1.2, -6)

				var_126_0.localPosition = Vector3.Lerp(arg_123_1.var_.moveOldPos104902ui_story, var_126_4, var_126_3)

				local var_126_5 = manager.ui.mainCamera.transform.position - var_126_0.position

				var_126_0.forward = Vector3.New(var_126_5.x, var_126_5.y, var_126_5.z)

				local var_126_6 = var_126_0.localEulerAngles

				var_126_6.z = 0
				var_126_6.x = 0
				var_126_0.localEulerAngles = var_126_6
			end

			if arg_123_1.time_ >= var_126_1 + var_126_2 and arg_123_1.time_ < var_126_1 + var_126_2 + arg_126_0 then
				var_126_0.localPosition = Vector3.New(0, -1.2, -6)

				local var_126_7 = manager.ui.mainCamera.transform.position - var_126_0.position

				var_126_0.forward = Vector3.New(var_126_7.x, var_126_7.y, var_126_7.z)

				local var_126_8 = var_126_0.localEulerAngles

				var_126_8.z = 0
				var_126_8.x = 0
				var_126_0.localEulerAngles = var_126_8
			end

			local var_126_9 = arg_123_1.actors_["104902ui_story"]
			local var_126_10 = 0

			if var_126_10 < arg_123_1.time_ and arg_123_1.time_ <= var_126_10 + arg_126_0 and not isNil(var_126_9) and arg_123_1.var_.characterEffect104902ui_story == nil then
				arg_123_1.var_.characterEffect104902ui_story = var_126_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_126_11 = 0.200000002980232

			if var_126_10 <= arg_123_1.time_ and arg_123_1.time_ < var_126_10 + var_126_11 and not isNil(var_126_9) then
				local var_126_12 = (arg_123_1.time_ - var_126_10) / var_126_11

				if arg_123_1.var_.characterEffect104902ui_story and not isNil(var_126_9) then
					arg_123_1.var_.characterEffect104902ui_story.fillFlat = false
				end
			end

			if arg_123_1.time_ >= var_126_10 + var_126_11 and arg_123_1.time_ < var_126_10 + var_126_11 + arg_126_0 and not isNil(var_126_9) and arg_123_1.var_.characterEffect104902ui_story then
				arg_123_1.var_.characterEffect104902ui_story.fillFlat = false
			end

			local var_126_13 = 0

			if var_126_13 < arg_123_1.time_ and arg_123_1.time_ <= var_126_13 + arg_126_0 then
				arg_123_1:PlayTimeline("104902ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_126_14 = arg_123_1.actors_["1081ui_story"].transform
			local var_126_15 = 0

			if var_126_15 < arg_123_1.time_ and arg_123_1.time_ <= var_126_15 + arg_126_0 then
				arg_123_1.var_.moveOldPos1081ui_story = var_126_14.localPosition

				local var_126_16 = "1081ui_story"

				arg_123_1:ShowWeapon(arg_123_1.var_[var_126_16 .. "Animator"].transform, false)
			end

			local var_126_17 = 0.001

			if var_126_15 <= arg_123_1.time_ and arg_123_1.time_ < var_126_15 + var_126_17 then
				local var_126_18 = (arg_123_1.time_ - var_126_15) / var_126_17
				local var_126_19 = Vector3.New(0, 100, 0)

				var_126_14.localPosition = Vector3.Lerp(arg_123_1.var_.moveOldPos1081ui_story, var_126_19, var_126_18)

				local var_126_20 = manager.ui.mainCamera.transform.position - var_126_14.position

				var_126_14.forward = Vector3.New(var_126_20.x, var_126_20.y, var_126_20.z)

				local var_126_21 = var_126_14.localEulerAngles

				var_126_21.z = 0
				var_126_21.x = 0
				var_126_14.localEulerAngles = var_126_21
			end

			if arg_123_1.time_ >= var_126_15 + var_126_17 and arg_123_1.time_ < var_126_15 + var_126_17 + arg_126_0 then
				var_126_14.localPosition = Vector3.New(0, 100, 0)

				local var_126_22 = manager.ui.mainCamera.transform.position - var_126_14.position

				var_126_14.forward = Vector3.New(var_126_22.x, var_126_22.y, var_126_22.z)

				local var_126_23 = var_126_14.localEulerAngles

				var_126_23.z = 0
				var_126_23.x = 0
				var_126_14.localEulerAngles = var_126_23
			end

			local var_126_24 = 0

			if var_126_24 < arg_123_1.time_ and arg_123_1.time_ <= var_126_24 + arg_126_0 then
				arg_123_1:PlayTimeline("104902ui_story", "StoryTimeline/CharAction/story104902/story104902action/104902action5_1")
			end

			local var_126_25 = 0
			local var_126_26 = 0.075

			if var_126_25 < arg_123_1.time_ and arg_123_1.time_ <= var_126_25 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				local var_126_27 = arg_123_1:FormatText(StoryNameCfg[562].name)

				arg_123_1.leftNameTxt_.text = var_126_27

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_28 = arg_123_1:GetWordFromCfg(414121030)
				local var_126_29 = arg_123_1:FormatText(var_126_28.content)

				arg_123_1.text_.text = var_126_29

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_30 = 20
				local var_126_31 = utf8.len(var_126_29)
				local var_126_32 = var_126_30 <= 0 and var_126_26 or var_126_26 * (var_126_31 / var_126_30)

				if var_126_32 > 0 and var_126_26 < var_126_32 then
					arg_123_1.talkMaxDuration = var_126_32

					if var_126_32 + var_126_25 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_32 + var_126_25
					end
				end

				arg_123_1.text_.text = var_126_29
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)
				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_33 = math.max(var_126_26, arg_123_1.talkMaxDuration)

			if var_126_25 <= arg_123_1.time_ and arg_123_1.time_ < var_126_25 + var_126_33 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_25) / var_126_33

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_25 + var_126_33 and arg_123_1.time_ < var_126_25 + var_126_33 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104902ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1081ui_story",
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
	Play414121031 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 414121031
		arg_127_1.duration_ = 5

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play414121032(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = arg_127_1.actors_["104902ui_story"]
			local var_130_1 = 0

			if var_130_1 < arg_127_1.time_ and arg_127_1.time_ <= var_130_1 + arg_130_0 and not isNil(var_130_0) and arg_127_1.var_.characterEffect104902ui_story == nil then
				arg_127_1.var_.characterEffect104902ui_story = var_130_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_2 = 0.200000002980232

			if var_130_1 <= arg_127_1.time_ and arg_127_1.time_ < var_130_1 + var_130_2 and not isNil(var_130_0) then
				local var_130_3 = (arg_127_1.time_ - var_130_1) / var_130_2

				if arg_127_1.var_.characterEffect104902ui_story and not isNil(var_130_0) then
					local var_130_4 = Mathf.Lerp(0, 0.5, var_130_3)

					arg_127_1.var_.characterEffect104902ui_story.fillFlat = true
					arg_127_1.var_.characterEffect104902ui_story.fillRatio = var_130_4
				end
			end

			if arg_127_1.time_ >= var_130_1 + var_130_2 and arg_127_1.time_ < var_130_1 + var_130_2 + arg_130_0 and not isNil(var_130_0) and arg_127_1.var_.characterEffect104902ui_story then
				local var_130_5 = 0.5

				arg_127_1.var_.characterEffect104902ui_story.fillFlat = true
				arg_127_1.var_.characterEffect104902ui_story.fillRatio = var_130_5
			end

			local var_130_6 = arg_127_1.actors_["104902ui_story"].transform
			local var_130_7 = 0

			if var_130_7 < arg_127_1.time_ and arg_127_1.time_ <= var_130_7 + arg_130_0 then
				arg_127_1.var_.moveOldPos104902ui_story = var_130_6.localPosition
			end

			local var_130_8 = 0.001

			if var_130_7 <= arg_127_1.time_ and arg_127_1.time_ < var_130_7 + var_130_8 then
				local var_130_9 = (arg_127_1.time_ - var_130_7) / var_130_8
				local var_130_10 = Vector3.New(0, 100, 0)

				var_130_6.localPosition = Vector3.Lerp(arg_127_1.var_.moveOldPos104902ui_story, var_130_10, var_130_9)

				local var_130_11 = manager.ui.mainCamera.transform.position - var_130_6.position

				var_130_6.forward = Vector3.New(var_130_11.x, var_130_11.y, var_130_11.z)

				local var_130_12 = var_130_6.localEulerAngles

				var_130_12.z = 0
				var_130_12.x = 0
				var_130_6.localEulerAngles = var_130_12
			end

			if arg_127_1.time_ >= var_130_7 + var_130_8 and arg_127_1.time_ < var_130_7 + var_130_8 + arg_130_0 then
				var_130_6.localPosition = Vector3.New(0, 100, 0)

				local var_130_13 = manager.ui.mainCamera.transform.position - var_130_6.position

				var_130_6.forward = Vector3.New(var_130_13.x, var_130_13.y, var_130_13.z)

				local var_130_14 = var_130_6.localEulerAngles

				var_130_14.z = 0
				var_130_14.x = 0
				var_130_6.localEulerAngles = var_130_14
			end

			local var_130_15 = 0
			local var_130_16 = 0.05

			if var_130_15 < arg_127_1.time_ and arg_127_1.time_ <= var_130_15 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				local var_130_17 = arg_127_1:FormatText(StoryNameCfg[978].name)

				arg_127_1.leftNameTxt_.text = var_130_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, true)
				arg_127_1.iconController_:SetSelectedState("hero")

				arg_127_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenma")

				arg_127_1.callingController_:SetSelectedState("normal")

				arg_127_1.keyicon_.color = Color.New(1, 1, 1)
				arg_127_1.icon_.color = Color.New(1, 1, 1)

				local var_130_18 = arg_127_1:GetWordFromCfg(414121031)
				local var_130_19 = arg_127_1:FormatText(var_130_18.content)

				arg_127_1.text_.text = var_130_19

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_20 = 4
				local var_130_21 = utf8.len(var_130_19)
				local var_130_22 = var_130_20 <= 0 and var_130_16 or var_130_16 * (var_130_21 / var_130_20)

				if var_130_22 > 0 and var_130_16 < var_130_22 then
					arg_127_1.talkMaxDuration = var_130_22

					if var_130_22 + var_130_15 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_22 + var_130_15
					end
				end

				arg_127_1.text_.text = var_130_19
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)
				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_23 = math.max(var_130_16, arg_127_1.talkMaxDuration)

			if var_130_15 <= arg_127_1.time_ and arg_127_1.time_ < var_130_15 + var_130_23 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_15) / var_130_23

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_15 + var_130_23 and arg_127_1.time_ < var_130_15 + var_130_23 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104902ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_127_1:InitPlayNodeList()
	end,
	Play414121032 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 414121032
		arg_131_1.duration_ = 5

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play414121033(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = 0
			local var_134_1 = 0.1

			if var_134_0 < arg_131_1.time_ and arg_131_1.time_ <= var_134_0 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				local var_134_2 = arg_131_1:FormatText(StoryNameCfg[7].name)

				arg_131_1.leftNameTxt_.text = var_134_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, true)
				arg_131_1.iconController_:SetSelectedState("hero")

				arg_131_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_131_1.callingController_:SetSelectedState("normal")

				arg_131_1.keyicon_.color = Color.New(1, 1, 1)
				arg_131_1.icon_.color = Color.New(1, 1, 1)

				local var_134_3 = arg_131_1:GetWordFromCfg(414121032)
				local var_134_4 = arg_131_1:FormatText(var_134_3.content)

				arg_131_1.text_.text = var_134_4

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_5 = 4
				local var_134_6 = utf8.len(var_134_4)
				local var_134_7 = var_134_5 <= 0 and var_134_1 or var_134_1 * (var_134_6 / var_134_5)

				if var_134_7 > 0 and var_134_1 < var_134_7 then
					arg_131_1.talkMaxDuration = var_134_7

					if var_134_7 + var_134_0 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_7 + var_134_0
					end
				end

				arg_131_1.text_.text = var_134_4
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)
				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_8 = math.max(var_134_1, arg_131_1.talkMaxDuration)

			if var_134_0 <= arg_131_1.time_ and arg_131_1.time_ < var_134_0 + var_134_8 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_0) / var_134_8

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_0 + var_134_8 and arg_131_1.time_ < var_134_0 + var_134_8 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {}

		arg_131_1:InitPlayNodeList()
	end,
	Play414121033 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 414121033
		arg_135_1.duration_ = 5

		SetActive(arg_135_1.tipsGo_, false)

		function arg_135_1.onSingleLineFinish_()
			arg_135_1.onSingleLineUpdate_ = nil
			arg_135_1.onSingleLineFinish_ = nil
			arg_135_1.state_ = "waiting"
		end

		function arg_135_1.playNext_(arg_137_0)
			if arg_137_0 == 1 then
				arg_135_0:Play414121034(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_0 = 0
			local var_138_1 = 0.15

			if var_138_0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_0 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				local var_138_2 = arg_135_1:FormatText(StoryNameCfg[978].name)

				arg_135_1.leftNameTxt_.text = var_138_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, true)
				arg_135_1.iconController_:SetSelectedState("hero")

				arg_135_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenma")

				arg_135_1.callingController_:SetSelectedState("normal")

				arg_135_1.keyicon_.color = Color.New(1, 1, 1)
				arg_135_1.icon_.color = Color.New(1, 1, 1)

				local var_138_3 = arg_135_1:GetWordFromCfg(414121033)
				local var_138_4 = arg_135_1:FormatText(var_138_3.content)

				arg_135_1.text_.text = var_138_4

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_5 = 6
				local var_138_6 = utf8.len(var_138_4)
				local var_138_7 = var_138_5 <= 0 and var_138_1 or var_138_1 * (var_138_6 / var_138_5)

				if var_138_7 > 0 and var_138_1 < var_138_7 then
					arg_135_1.talkMaxDuration = var_138_7

					if var_138_7 + var_138_0 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_7 + var_138_0
					end
				end

				arg_135_1.text_.text = var_138_4
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)
				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_8 = math.max(var_138_1, arg_135_1.talkMaxDuration)

			if var_138_0 <= arg_135_1.time_ and arg_135_1.time_ < var_138_0 + var_138_8 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_0) / var_138_8

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_0 + var_138_8 and arg_135_1.time_ < var_138_0 + var_138_8 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {}

		arg_135_1:InitPlayNodeList()
	end,
	Play414121034 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 414121034
		arg_139_1.duration_ = 5

		SetActive(arg_139_1.tipsGo_, false)

		function arg_139_1.onSingleLineFinish_()
			arg_139_1.onSingleLineUpdate_ = nil
			arg_139_1.onSingleLineFinish_ = nil
			arg_139_1.state_ = "waiting"
		end

		function arg_139_1.playNext_(arg_141_0)
			if arg_141_0 == 1 then
				arg_139_0:Play414121035(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			local var_142_0 = 0
			local var_142_1 = 0.9

			if var_142_0 < arg_139_1.time_ and arg_139_1.time_ <= var_142_0 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				local var_142_2 = arg_139_1:FormatText(StoryNameCfg[978].name)

				arg_139_1.leftNameTxt_.text = var_142_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, true)
				arg_139_1.iconController_:SetSelectedState("hero")

				arg_139_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenma")

				arg_139_1.callingController_:SetSelectedState("normal")

				arg_139_1.keyicon_.color = Color.New(1, 1, 1)
				arg_139_1.icon_.color = Color.New(1, 1, 1)

				local var_142_3 = arg_139_1:GetWordFromCfg(414121034)
				local var_142_4 = arg_139_1:FormatText(var_142_3.content)

				arg_139_1.text_.text = var_142_4

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_5 = 36
				local var_142_6 = utf8.len(var_142_4)
				local var_142_7 = var_142_5 <= 0 and var_142_1 or var_142_1 * (var_142_6 / var_142_5)

				if var_142_7 > 0 and var_142_1 < var_142_7 then
					arg_139_1.talkMaxDuration = var_142_7

					if var_142_7 + var_142_0 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_7 + var_142_0
					end
				end

				arg_139_1.text_.text = var_142_4
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)
				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_8 = math.max(var_142_1, arg_139_1.talkMaxDuration)

			if var_142_0 <= arg_139_1.time_ and arg_139_1.time_ < var_142_0 + var_142_8 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_0) / var_142_8

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_0 + var_142_8 and arg_139_1.time_ < var_142_0 + var_142_8 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {}

		arg_139_1:InitPlayNodeList()
	end,
	Play414121035 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 414121035
		arg_143_1.duration_ = 5

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play414121036(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = 0
			local var_146_1 = 0.775

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

				local var_146_2 = arg_143_1:GetWordFromCfg(414121035)
				local var_146_3 = arg_143_1:FormatText(var_146_2.content)

				arg_143_1.text_.text = var_146_3

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_4 = 31
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
	Play414121036 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 414121036
		arg_147_1.duration_ = 5

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play414121037(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_0 = arg_147_1.actors_["104902ui_story"].transform
			local var_150_1 = 0

			if var_150_1 < arg_147_1.time_ and arg_147_1.time_ <= var_150_1 + arg_150_0 then
				arg_147_1.var_.moveOldPos104902ui_story = var_150_0.localPosition
			end

			local var_150_2 = 0.001

			if var_150_1 <= arg_147_1.time_ and arg_147_1.time_ < var_150_1 + var_150_2 then
				local var_150_3 = (arg_147_1.time_ - var_150_1) / var_150_2
				local var_150_4 = Vector3.New(0, -1.2, -6)

				var_150_0.localPosition = Vector3.Lerp(arg_147_1.var_.moveOldPos104902ui_story, var_150_4, var_150_3)

				local var_150_5 = manager.ui.mainCamera.transform.position - var_150_0.position

				var_150_0.forward = Vector3.New(var_150_5.x, var_150_5.y, var_150_5.z)

				local var_150_6 = var_150_0.localEulerAngles

				var_150_6.z = 0
				var_150_6.x = 0
				var_150_0.localEulerAngles = var_150_6
			end

			if arg_147_1.time_ >= var_150_1 + var_150_2 and arg_147_1.time_ < var_150_1 + var_150_2 + arg_150_0 then
				var_150_0.localPosition = Vector3.New(0, -1.2, -6)

				local var_150_7 = manager.ui.mainCamera.transform.position - var_150_0.position

				var_150_0.forward = Vector3.New(var_150_7.x, var_150_7.y, var_150_7.z)

				local var_150_8 = var_150_0.localEulerAngles

				var_150_8.z = 0
				var_150_8.x = 0
				var_150_0.localEulerAngles = var_150_8
			end

			local var_150_9 = arg_147_1.actors_["104902ui_story"]
			local var_150_10 = 0

			if var_150_10 < arg_147_1.time_ and arg_147_1.time_ <= var_150_10 + arg_150_0 and not isNil(var_150_9) and arg_147_1.var_.characterEffect104902ui_story == nil then
				arg_147_1.var_.characterEffect104902ui_story = var_150_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_150_11 = 0.200000002980232

			if var_150_10 <= arg_147_1.time_ and arg_147_1.time_ < var_150_10 + var_150_11 and not isNil(var_150_9) then
				local var_150_12 = (arg_147_1.time_ - var_150_10) / var_150_11

				if arg_147_1.var_.characterEffect104902ui_story and not isNil(var_150_9) then
					arg_147_1.var_.characterEffect104902ui_story.fillFlat = false
				end
			end

			if arg_147_1.time_ >= var_150_10 + var_150_11 and arg_147_1.time_ < var_150_10 + var_150_11 + arg_150_0 and not isNil(var_150_9) and arg_147_1.var_.characterEffect104902ui_story then
				arg_147_1.var_.characterEffect104902ui_story.fillFlat = false
			end

			local var_150_13 = 0

			if var_150_13 < arg_147_1.time_ and arg_147_1.time_ <= var_150_13 + arg_150_0 then
				arg_147_1:PlayTimeline("104902ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_150_14 = 0

			if var_150_14 < arg_147_1.time_ and arg_147_1.time_ <= var_150_14 + arg_150_0 then
				arg_147_1:PlayTimeline("104902ui_story", "StoryTimeline/CharAction/story104902/story104902action/104902action5_2")
			end

			local var_150_15 = 0
			local var_150_16 = 0.075

			if var_150_15 < arg_147_1.time_ and arg_147_1.time_ <= var_150_15 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				local var_150_17 = arg_147_1:FormatText(StoryNameCfg[562].name)

				arg_147_1.leftNameTxt_.text = var_150_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_18 = arg_147_1:GetWordFromCfg(414121036)
				local var_150_19 = arg_147_1:FormatText(var_150_18.content)

				arg_147_1.text_.text = var_150_19

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_20 = 3
				local var_150_21 = utf8.len(var_150_19)
				local var_150_22 = var_150_20 <= 0 and var_150_16 or var_150_16 * (var_150_21 / var_150_20)

				if var_150_22 > 0 and var_150_16 < var_150_22 then
					arg_147_1.talkMaxDuration = var_150_22

					if var_150_22 + var_150_15 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_22 + var_150_15
					end
				end

				arg_147_1.text_.text = var_150_19
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)
				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_23 = math.max(var_150_16, arg_147_1.talkMaxDuration)

			if var_150_15 <= arg_147_1.time_ and arg_147_1.time_ < var_150_15 + var_150_23 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_15) / var_150_23

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_15 + var_150_23 and arg_147_1.time_ < var_150_15 + var_150_23 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104902ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_147_1:InitPlayNodeList()
	end,
	Play414121037 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 414121037
		arg_151_1.duration_ = 5

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play414121038(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = arg_151_1.actors_["104902ui_story"]
			local var_154_1 = 0

			if var_154_1 < arg_151_1.time_ and arg_151_1.time_ <= var_154_1 + arg_154_0 and not isNil(var_154_0) and arg_151_1.var_.characterEffect104902ui_story == nil then
				arg_151_1.var_.characterEffect104902ui_story = var_154_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_2 = 0.200000002980232

			if var_154_1 <= arg_151_1.time_ and arg_151_1.time_ < var_154_1 + var_154_2 and not isNil(var_154_0) then
				local var_154_3 = (arg_151_1.time_ - var_154_1) / var_154_2

				if arg_151_1.var_.characterEffect104902ui_story and not isNil(var_154_0) then
					local var_154_4 = Mathf.Lerp(0, 0.5, var_154_3)

					arg_151_1.var_.characterEffect104902ui_story.fillFlat = true
					arg_151_1.var_.characterEffect104902ui_story.fillRatio = var_154_4
				end
			end

			if arg_151_1.time_ >= var_154_1 + var_154_2 and arg_151_1.time_ < var_154_1 + var_154_2 + arg_154_0 and not isNil(var_154_0) and arg_151_1.var_.characterEffect104902ui_story then
				local var_154_5 = 0.5

				arg_151_1.var_.characterEffect104902ui_story.fillFlat = true
				arg_151_1.var_.characterEffect104902ui_story.fillRatio = var_154_5
			end

			local var_154_6 = 0
			local var_154_7 = 0.25

			if var_154_6 < arg_151_1.time_ and arg_151_1.time_ <= var_154_6 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				local var_154_8 = arg_151_1:FormatText(StoryNameCfg[7].name)

				arg_151_1.leftNameTxt_.text = var_154_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, true)
				arg_151_1.iconController_:SetSelectedState("hero")

				arg_151_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_151_1.callingController_:SetSelectedState("normal")

				arg_151_1.keyicon_.color = Color.New(1, 1, 1)
				arg_151_1.icon_.color = Color.New(1, 1, 1)

				local var_154_9 = arg_151_1:GetWordFromCfg(414121037)
				local var_154_10 = arg_151_1:FormatText(var_154_9.content)

				arg_151_1.text_.text = var_154_10

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_11 = 10
				local var_154_12 = utf8.len(var_154_10)
				local var_154_13 = var_154_11 <= 0 and var_154_7 or var_154_7 * (var_154_12 / var_154_11)

				if var_154_13 > 0 and var_154_7 < var_154_13 then
					arg_151_1.talkMaxDuration = var_154_13

					if var_154_13 + var_154_6 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_13 + var_154_6
					end
				end

				arg_151_1.text_.text = var_154_10
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)
				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_14 = math.max(var_154_7, arg_151_1.talkMaxDuration)

			if var_154_6 <= arg_151_1.time_ and arg_151_1.time_ < var_154_6 + var_154_14 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_6) / var_154_14

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_6 + var_154_14 and arg_151_1.time_ < var_154_6 + var_154_14 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {}

		arg_151_1:InitPlayNodeList()
	end,
	Play414121038 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 414121038
		arg_155_1.duration_ = 101.07

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play414121039(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = "ST15a"

			if arg_155_1.bgs_[var_158_0] == nil then
				local var_158_1 = Object.Instantiate(arg_155_1.paintGo_)

				var_158_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_158_0)
				var_158_1.name = var_158_0
				var_158_1.transform.parent = arg_155_1.stage_.transform
				var_158_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_155_1.bgs_[var_158_0] = var_158_1
			end

			local var_158_2 = 0

			if var_158_2 < arg_155_1.time_ and arg_155_1.time_ <= var_158_2 + arg_158_0 then
				local var_158_3 = manager.ui.mainCamera.transform.localPosition
				local var_158_4 = Vector3.New(0, 0, 10) + Vector3.New(var_158_3.x, var_158_3.y, 0)
				local var_158_5 = arg_155_1.bgs_.ST15a

				var_158_5.transform.localPosition = var_158_4
				var_158_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_158_6 = var_158_5:GetComponent("SpriteRenderer")

				if var_158_6 and var_158_6.sprite then
					local var_158_7 = (var_158_5.transform.localPosition - var_158_3).z
					local var_158_8 = manager.ui.mainCameraCom_
					local var_158_9 = 2 * var_158_7 * Mathf.Tan(var_158_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_158_10 = var_158_9 * var_158_8.aspect
					local var_158_11 = var_158_6.sprite.bounds.size.x
					local var_158_12 = var_158_6.sprite.bounds.size.y
					local var_158_13 = var_158_10 / var_158_11
					local var_158_14 = var_158_9 / var_158_12
					local var_158_15 = var_158_14 < var_158_13 and var_158_13 or var_158_14

					var_158_5.transform.localScale = Vector3.New(var_158_15, var_158_15, 0)
				end

				for iter_158_0, iter_158_1 in pairs(arg_155_1.bgs_) do
					if iter_158_0 ~= "ST15a" then
						iter_158_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_158_16 = 94.2083333333333

			if var_158_16 < arg_155_1.time_ and arg_155_1.time_ <= var_158_16 + arg_158_0 then
				local var_158_17 = manager.ui.mainCamera.transform.localPosition
				local var_158_18 = Vector3.New(0, 0, 10) + Vector3.New(var_158_17.x, var_158_17.y, 0)
				local var_158_19 = arg_155_1.bgs_.ST15a

				var_158_19.transform.localPosition = var_158_18
				var_158_19.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_158_20 = var_158_19:GetComponent("SpriteRenderer")

				if var_158_20 and var_158_20.sprite then
					local var_158_21 = (var_158_19.transform.localPosition - var_158_17).z
					local var_158_22 = manager.ui.mainCameraCom_
					local var_158_23 = 2 * var_158_21 * Mathf.Tan(var_158_22.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_158_24 = var_158_23 * var_158_22.aspect
					local var_158_25 = var_158_20.sprite.bounds.size.x
					local var_158_26 = var_158_20.sprite.bounds.size.y
					local var_158_27 = var_158_24 / var_158_25
					local var_158_28 = var_158_23 / var_158_26
					local var_158_29 = var_158_28 < var_158_27 and var_158_27 or var_158_28

					var_158_19.transform.localScale = Vector3.New(var_158_29, var_158_29, 0)
				end

				for iter_158_2, iter_158_3 in pairs(arg_155_1.bgs_) do
					if iter_158_2 ~= "ST15a" then
						iter_158_3.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_158_30 = arg_155_1.actors_["104902ui_story"].transform
			local var_158_31 = 0

			if var_158_31 < arg_155_1.time_ and arg_155_1.time_ <= var_158_31 + arg_158_0 then
				arg_155_1.var_.moveOldPos104902ui_story = var_158_30.localPosition
			end

			local var_158_32 = 0.001

			if var_158_31 <= arg_155_1.time_ and arg_155_1.time_ < var_158_31 + var_158_32 then
				local var_158_33 = (arg_155_1.time_ - var_158_31) / var_158_32
				local var_158_34 = Vector3.New(0, 100, 0)

				var_158_30.localPosition = Vector3.Lerp(arg_155_1.var_.moveOldPos104902ui_story, var_158_34, var_158_33)

				local var_158_35 = manager.ui.mainCamera.transform.position - var_158_30.position

				var_158_30.forward = Vector3.New(var_158_35.x, var_158_35.y, var_158_35.z)

				local var_158_36 = var_158_30.localEulerAngles

				var_158_36.z = 0
				var_158_36.x = 0
				var_158_30.localEulerAngles = var_158_36
			end

			if arg_155_1.time_ >= var_158_31 + var_158_32 and arg_155_1.time_ < var_158_31 + var_158_32 + arg_158_0 then
				var_158_30.localPosition = Vector3.New(0, 100, 0)

				local var_158_37 = manager.ui.mainCamera.transform.position - var_158_30.position

				var_158_30.forward = Vector3.New(var_158_37.x, var_158_37.y, var_158_37.z)

				local var_158_38 = var_158_30.localEulerAngles

				var_158_38.z = 0
				var_158_38.x = 0
				var_158_30.localEulerAngles = var_158_38
			end

			local var_158_39 = 94.2083333333333

			if var_158_39 < arg_155_1.time_ and arg_155_1.time_ <= var_158_39 + arg_158_0 then
				arg_155_1.mask_.enabled = true
				arg_155_1.mask_.raycastTarget = true

				arg_155_1:SetGaussion(false)
			end

			local var_158_40 = 2

			if var_158_39 <= arg_155_1.time_ and arg_155_1.time_ < var_158_39 + var_158_40 then
				local var_158_41 = (arg_155_1.time_ - var_158_39) / var_158_40
				local var_158_42 = Color.New(0, 0, 0)

				var_158_42.a = Mathf.Lerp(1, 0, var_158_41)
				arg_155_1.mask_.color = var_158_42
			end

			if arg_155_1.time_ >= var_158_39 + var_158_40 and arg_155_1.time_ < var_158_39 + var_158_40 + arg_158_0 then
				local var_158_43 = Color.New(0, 0, 0)
				local var_158_44 = 0

				arg_155_1.mask_.enabled = false
				var_158_43.a = var_158_44
				arg_155_1.mask_.color = var_158_43
			end

			local var_158_45 = 0

			if var_158_45 < arg_155_1.time_ and arg_155_1.time_ <= var_158_45 + arg_158_0 then
				SetActive(arg_155_1.dialog_, false)
				SetActive(arg_155_1.allBtn_.gameObject, false)
				arg_155_1.hideBtnsController_:SetSelectedIndex(1)
				arg_155_1:StopAllVoice()

				arg_155_1.marker = "dotgo"

				manager.video:Play("SofdecAsset/story/story_1041412.usm", function(arg_159_0)
					arg_155_1.time_ = var_158_45 + 94.1983333335568

					if arg_155_1.state_ == "pause" then
						arg_155_1.state_ = "playing"
					end

					manager.video:Dispose()
				end, nil, nil, function(arg_160_0)
					if arg_160_0 then
						arg_155_1.state_ = "pause"
					else
						arg_155_1.state_ = "playing"
					end
				end, 1041412)
				manager.video.transform_:SetSiblingIndex(1)
			end

			local var_158_46 = 94.2083333333333

			if var_158_45 <= arg_155_1.time_ and arg_155_1.time_ < var_158_45 + var_158_46 then
				-- block empty
			end

			if arg_155_1.time_ >= var_158_45 + var_158_46 and arg_155_1.time_ < var_158_45 + var_158_46 + arg_158_0 then
				arg_155_1.marker = ""
			end

			local var_158_47 = 94.2083333333333

			if var_158_47 < arg_155_1.time_ and arg_155_1.time_ <= var_158_47 + arg_158_0 then
				SetActive(arg_155_1.dialog_, true)
				SetActive(arg_155_1.allBtn_.gameObject, true)
				arg_155_1.hideBtnsController_:SetSelectedIndex(0)
				manager.video:Dispose()

				arg_155_1.isInLoopVideo = false
			end

			local var_158_48 = 0.125

			if var_158_47 <= arg_155_1.time_ and arg_155_1.time_ < var_158_47 + var_158_48 then
				-- block empty
			end

			if arg_155_1.time_ >= var_158_47 + var_158_48 and arg_155_1.time_ < var_158_47 + var_158_48 + arg_158_0 then
				-- block empty
			end

			local var_158_49 = 94.2083333333333

			if var_158_49 < arg_155_1.time_ and arg_155_1.time_ <= var_158_49 + arg_158_0 then
				arg_155_1.fswbg_:SetActive(false)
				arg_155_1.dialog_:SetActive(false)
				SetActive(arg_155_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_155_1:ShowNextGo(false)
			end

			if arg_155_1.frameCnt_ <= 1 then
				arg_155_1.dialog_:SetActive(false)
			end

			local var_158_50 = 96.075
			local var_158_51 = 1.35

			if var_158_50 < arg_155_1.time_ and arg_155_1.time_ <= var_158_50 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0

				arg_155_1.dialog_:SetActive(true)

				arg_155_1.dialogCg_.alpha = 0

				local var_158_52 = LeanTween.value(arg_155_1.dialog_, 0, 1, 0.3)

				var_158_52:setOnUpdate(LuaHelper.FloatAction(function(arg_161_0)
					arg_155_1.dialogCg_.alpha = arg_161_0
				end))
				var_158_52:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_155_1.dialog_)
					var_158_52:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_155_1.duration_ = arg_155_1.duration_ + 0.3

				SetActive(arg_155_1.leftNameGo_, false)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_53 = arg_155_1:GetWordFromCfg(414121038)
				local var_158_54 = arg_155_1:FormatText(var_158_53.content)

				arg_155_1.text_.text = var_158_54

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_55 = 54
				local var_158_56 = utf8.len(var_158_54)
				local var_158_57 = var_158_55 <= 0 and var_158_51 or var_158_51 * (var_158_56 / var_158_55)

				if var_158_57 > 0 and var_158_51 < var_158_57 then
					arg_155_1.talkMaxDuration = var_158_57
					var_158_50 = var_158_50 + 0.3

					if var_158_57 + var_158_50 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_57 + var_158_50
					end
				end

				arg_155_1.text_.text = var_158_54
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)
				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_58 = var_158_50 + 0.3
			local var_158_59 = math.max(var_158_51, arg_155_1.talkMaxDuration)

			if var_158_58 <= arg_155_1.time_ and arg_155_1.time_ < var_158_58 + var_158_59 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_58) / var_158_59

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_58 + var_158_59 and arg_155_1.time_ < var_158_58 + var_158_59 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104902ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_155_1:InitPlayNodeList()
	end,
	Play414121039 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 414121039
		arg_163_1.duration_ = 5

		SetActive(arg_163_1.tipsGo_, false)

		function arg_163_1.onSingleLineFinish_()
			arg_163_1.onSingleLineUpdate_ = nil
			arg_163_1.onSingleLineFinish_ = nil
			arg_163_1.state_ = "waiting"
		end

		function arg_163_1.playNext_(arg_165_0)
			if arg_165_0 == 1 then
				arg_163_0:Play414121040(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			local var_166_0 = 0
			local var_166_1 = 0.266666666666667

			if var_166_0 < arg_163_1.time_ and arg_163_1.time_ <= var_166_0 + arg_166_0 then
				local var_166_2 = "play"
				local var_166_3 = "music"

				arg_163_1:AudioAction(var_166_2, var_166_3, "ui_battle", "ui_battle_stopbgm", "")

				local var_166_4 = ""
				local var_166_5 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_166_5 ~= "" then
					if arg_163_1.bgmTxt_.text ~= var_166_5 and arg_163_1.bgmTxt_.text ~= "" then
						if arg_163_1.bgmTxt2_.text ~= "" then
							arg_163_1.bgmTxt_.text = arg_163_1.bgmTxt2_.text
						end

						arg_163_1.bgmTxt2_.text = var_166_5

						arg_163_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_163_1.bgmTxt_.text = var_166_5
						arg_163_1.bgmTxt2_.text = var_166_5
					end

					if arg_163_1.bgmTimer then
						arg_163_1.bgmTimer:Stop()

						arg_163_1.bgmTimer = nil
					end

					if arg_163_1.settingData.show_music_name == 1 then
						arg_163_1.musicController:SetSelectedState("show")
						arg_163_1.musicAnimator_:Play("open", 0, 0)

						if arg_163_1.settingData.music_time ~= 0 then
							arg_163_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_163_1.settingData.music_time), function()
								if arg_163_1 == nil or isNil(arg_163_1.bgmTxt_) then
									return
								end

								arg_163_1.musicController:SetSelectedState("hide")
								arg_163_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_166_6 = 0.366666666666667
			local var_166_7 = 0.633333333333333

			if var_166_6 < arg_163_1.time_ and arg_163_1.time_ <= var_166_6 + arg_166_0 then
				local var_166_8 = "play"
				local var_166_9 = "music"

				arg_163_1:AudioAction(var_166_8, var_166_9, "bgm_activity_3_0_story_quiet", "bgm_activity_3_0_story_quiet", "bgm_activity_3_0_story_quiet.awb")

				local var_166_10 = ""
				local var_166_11 = manager.audio:GetAudioName("bgm_activity_3_0_story_quiet", "bgm_activity_3_0_story_quiet")

				if var_166_11 ~= "" then
					if arg_163_1.bgmTxt_.text ~= var_166_11 and arg_163_1.bgmTxt_.text ~= "" then
						if arg_163_1.bgmTxt2_.text ~= "" then
							arg_163_1.bgmTxt_.text = arg_163_1.bgmTxt2_.text
						end

						arg_163_1.bgmTxt2_.text = var_166_11

						arg_163_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_163_1.bgmTxt_.text = var_166_11
						arg_163_1.bgmTxt2_.text = var_166_11
					end

					if arg_163_1.bgmTimer then
						arg_163_1.bgmTimer:Stop()

						arg_163_1.bgmTimer = nil
					end

					if arg_163_1.settingData.show_music_name == 1 then
						arg_163_1.musicController:SetSelectedState("show")
						arg_163_1.musicAnimator_:Play("open", 0, 0)

						if arg_163_1.settingData.music_time ~= 0 then
							arg_163_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_163_1.settingData.music_time), function()
								if arg_163_1 == nil or isNil(arg_163_1.bgmTxt_) then
									return
								end

								arg_163_1.musicController:SetSelectedState("hide")
								arg_163_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_166_12 = 0
			local var_166_13 = 0.75

			if var_166_12 < arg_163_1.time_ and arg_163_1.time_ <= var_166_12 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, false)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_14 = arg_163_1:GetWordFromCfg(414121039)
				local var_166_15 = arg_163_1:FormatText(var_166_14.content)

				arg_163_1.text_.text = var_166_15

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_16 = 30
				local var_166_17 = utf8.len(var_166_15)
				local var_166_18 = var_166_16 <= 0 and var_166_13 or var_166_13 * (var_166_17 / var_166_16)

				if var_166_18 > 0 and var_166_13 < var_166_18 then
					arg_163_1.talkMaxDuration = var_166_18

					if var_166_18 + var_166_12 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_18 + var_166_12
					end
				end

				arg_163_1.text_.text = var_166_15
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)
				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_19 = math.max(var_166_13, arg_163_1.talkMaxDuration)

			if var_166_12 <= arg_163_1.time_ and arg_163_1.time_ < var_166_12 + var_166_19 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_12) / var_166_19

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_12 + var_166_19 and arg_163_1.time_ < var_166_12 + var_166_19 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {}

		arg_163_1:InitPlayNodeList()
	end,
	Play414121040 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 414121040
		arg_169_1.duration_ = 5

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play414121041(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = 0
			local var_172_1 = 0.4

			if var_172_0 < arg_169_1.time_ and arg_169_1.time_ <= var_172_0 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				local var_172_2 = arg_169_1:FormatText(StoryNameCfg[7].name)

				arg_169_1.leftNameTxt_.text = var_172_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, true)
				arg_169_1.iconController_:SetSelectedState("hero")

				arg_169_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_169_1.callingController_:SetSelectedState("normal")

				arg_169_1.keyicon_.color = Color.New(1, 1, 1)
				arg_169_1.icon_.color = Color.New(1, 1, 1)

				local var_172_3 = arg_169_1:GetWordFromCfg(414121040)
				local var_172_4 = arg_169_1:FormatText(var_172_3.content)

				arg_169_1.text_.text = var_172_4

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_5 = 16
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
				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_8 = math.max(var_172_1, arg_169_1.talkMaxDuration)

			if var_172_0 <= arg_169_1.time_ and arg_169_1.time_ < var_172_0 + var_172_8 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_0) / var_172_8

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_0 + var_172_8 and arg_169_1.time_ < var_172_0 + var_172_8 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {}

		arg_169_1:InitPlayNodeList()
	end,
	Play414121041 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 414121041
		arg_173_1.duration_ = 5

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play414121042(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			local var_176_0 = 0
			local var_176_1 = 1.1

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

				local var_176_2 = arg_173_1:GetWordFromCfg(414121041)
				local var_176_3 = arg_173_1:FormatText(var_176_2.content)

				arg_173_1.text_.text = var_176_3

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_4 = 44
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
	Play414121042 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 414121042
		arg_177_1.duration_ = 5

		SetActive(arg_177_1.tipsGo_, false)

		function arg_177_1.onSingleLineFinish_()
			arg_177_1.onSingleLineUpdate_ = nil
			arg_177_1.onSingleLineFinish_ = nil
			arg_177_1.state_ = "waiting"
		end

		function arg_177_1.playNext_(arg_179_0)
			if arg_179_0 == 1 then
				arg_177_0:Play414121043(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = arg_177_1.actors_["104902ui_story"].transform
			local var_180_1 = 0

			if var_180_1 < arg_177_1.time_ and arg_177_1.time_ <= var_180_1 + arg_180_0 then
				arg_177_1.var_.moveOldPos104902ui_story = var_180_0.localPosition
			end

			local var_180_2 = 0.001

			if var_180_1 <= arg_177_1.time_ and arg_177_1.time_ < var_180_1 + var_180_2 then
				local var_180_3 = (arg_177_1.time_ - var_180_1) / var_180_2
				local var_180_4 = Vector3.New(0, -1.2, -6)

				var_180_0.localPosition = Vector3.Lerp(arg_177_1.var_.moveOldPos104902ui_story, var_180_4, var_180_3)

				local var_180_5 = manager.ui.mainCamera.transform.position - var_180_0.position

				var_180_0.forward = Vector3.New(var_180_5.x, var_180_5.y, var_180_5.z)

				local var_180_6 = var_180_0.localEulerAngles

				var_180_6.z = 0
				var_180_6.x = 0
				var_180_0.localEulerAngles = var_180_6
			end

			if arg_177_1.time_ >= var_180_1 + var_180_2 and arg_177_1.time_ < var_180_1 + var_180_2 + arg_180_0 then
				var_180_0.localPosition = Vector3.New(0, -1.2, -6)

				local var_180_7 = manager.ui.mainCamera.transform.position - var_180_0.position

				var_180_0.forward = Vector3.New(var_180_7.x, var_180_7.y, var_180_7.z)

				local var_180_8 = var_180_0.localEulerAngles

				var_180_8.z = 0
				var_180_8.x = 0
				var_180_0.localEulerAngles = var_180_8
			end

			local var_180_9 = arg_177_1.actors_["104902ui_story"]
			local var_180_10 = 0

			if var_180_10 < arg_177_1.time_ and arg_177_1.time_ <= var_180_10 + arg_180_0 and not isNil(var_180_9) and arg_177_1.var_.characterEffect104902ui_story == nil then
				arg_177_1.var_.characterEffect104902ui_story = var_180_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_11 = 0.200000002980232

			if var_180_10 <= arg_177_1.time_ and arg_177_1.time_ < var_180_10 + var_180_11 and not isNil(var_180_9) then
				local var_180_12 = (arg_177_1.time_ - var_180_10) / var_180_11

				if arg_177_1.var_.characterEffect104902ui_story and not isNil(var_180_9) then
					arg_177_1.var_.characterEffect104902ui_story.fillFlat = false
				end
			end

			if arg_177_1.time_ >= var_180_10 + var_180_11 and arg_177_1.time_ < var_180_10 + var_180_11 + arg_180_0 and not isNil(var_180_9) and arg_177_1.var_.characterEffect104902ui_story then
				arg_177_1.var_.characterEffect104902ui_story.fillFlat = false
			end

			local var_180_13 = 0

			if var_180_13 < arg_177_1.time_ and arg_177_1.time_ <= var_180_13 + arg_180_0 then
				arg_177_1:PlayTimeline("104902ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_180_14 = 0

			if var_180_14 < arg_177_1.time_ and arg_177_1.time_ <= var_180_14 + arg_180_0 then
				arg_177_1:PlayTimeline("104902ui_story", "StoryTimeline/CharAction/story104902/story104902action/104902action1_1")
			end

			local var_180_15 = 0
			local var_180_16 = 0.075

			if var_180_15 < arg_177_1.time_ and arg_177_1.time_ <= var_180_15 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				local var_180_17 = arg_177_1:FormatText(StoryNameCfg[562].name)

				arg_177_1.leftNameTxt_.text = var_180_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_18 = arg_177_1:GetWordFromCfg(414121042)
				local var_180_19 = arg_177_1:FormatText(var_180_18.content)

				arg_177_1.text_.text = var_180_19

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_20 = 3
				local var_180_21 = utf8.len(var_180_19)
				local var_180_22 = var_180_20 <= 0 and var_180_16 or var_180_16 * (var_180_21 / var_180_20)

				if var_180_22 > 0 and var_180_16 < var_180_22 then
					arg_177_1.talkMaxDuration = var_180_22

					if var_180_22 + var_180_15 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_22 + var_180_15
					end
				end

				arg_177_1.text_.text = var_180_19
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)
				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_23 = math.max(var_180_16, arg_177_1.talkMaxDuration)

			if var_180_15 <= arg_177_1.time_ and arg_177_1.time_ < var_180_15 + var_180_23 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_15) / var_180_23

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_15 + var_180_23 and arg_177_1.time_ < var_180_15 + var_180_23 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104902ui_story",
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
	Play414121043 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 414121043
		arg_181_1.duration_ = 5

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play414121044(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = arg_181_1.actors_["104902ui_story"]
			local var_184_1 = 0

			if var_184_1 < arg_181_1.time_ and arg_181_1.time_ <= var_184_1 + arg_184_0 and not isNil(var_184_0) and arg_181_1.var_.characterEffect104902ui_story == nil then
				arg_181_1.var_.characterEffect104902ui_story = var_184_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_2 = 0.200000002980232

			if var_184_1 <= arg_181_1.time_ and arg_181_1.time_ < var_184_1 + var_184_2 and not isNil(var_184_0) then
				local var_184_3 = (arg_181_1.time_ - var_184_1) / var_184_2

				if arg_181_1.var_.characterEffect104902ui_story and not isNil(var_184_0) then
					local var_184_4 = Mathf.Lerp(0, 0.5, var_184_3)

					arg_181_1.var_.characterEffect104902ui_story.fillFlat = true
					arg_181_1.var_.characterEffect104902ui_story.fillRatio = var_184_4
				end
			end

			if arg_181_1.time_ >= var_184_1 + var_184_2 and arg_181_1.time_ < var_184_1 + var_184_2 + arg_184_0 and not isNil(var_184_0) and arg_181_1.var_.characterEffect104902ui_story then
				local var_184_5 = 0.5

				arg_181_1.var_.characterEffect104902ui_story.fillFlat = true
				arg_181_1.var_.characterEffect104902ui_story.fillRatio = var_184_5
			end

			local var_184_6 = 0
			local var_184_7 = 0.85

			if var_184_6 < arg_181_1.time_ and arg_181_1.time_ <= var_184_6 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				local var_184_8 = arg_181_1:FormatText(StoryNameCfg[7].name)

				arg_181_1.leftNameTxt_.text = var_184_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, true)
				arg_181_1.iconController_:SetSelectedState("hero")

				arg_181_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_181_1.callingController_:SetSelectedState("normal")

				arg_181_1.keyicon_.color = Color.New(1, 1, 1)
				arg_181_1.icon_.color = Color.New(1, 1, 1)

				local var_184_9 = arg_181_1:GetWordFromCfg(414121043)
				local var_184_10 = arg_181_1:FormatText(var_184_9.content)

				arg_181_1.text_.text = var_184_10

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_11 = 34
				local var_184_12 = utf8.len(var_184_10)
				local var_184_13 = var_184_11 <= 0 and var_184_7 or var_184_7 * (var_184_12 / var_184_11)

				if var_184_13 > 0 and var_184_7 < var_184_13 then
					arg_181_1.talkMaxDuration = var_184_13

					if var_184_13 + var_184_6 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_13 + var_184_6
					end
				end

				arg_181_1.text_.text = var_184_10
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)
				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_14 = math.max(var_184_7, arg_181_1.talkMaxDuration)

			if var_184_6 <= arg_181_1.time_ and arg_181_1.time_ < var_184_6 + var_184_14 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_6) / var_184_14

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_6 + var_184_14 and arg_181_1.time_ < var_184_6 + var_184_14 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {}

		arg_181_1:InitPlayNodeList()
	end,
	Play414121044 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 414121044
		arg_185_1.duration_ = 5

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
			arg_185_1.auto_ = false
		end

		function arg_185_1.playNext_(arg_187_0)
			arg_185_1.onStoryFinished_()
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = arg_185_1.actors_["104902ui_story"]
			local var_188_1 = 0

			if var_188_1 < arg_185_1.time_ and arg_185_1.time_ <= var_188_1 + arg_188_0 and not isNil(var_188_0) and arg_185_1.var_.characterEffect104902ui_story == nil then
				arg_185_1.var_.characterEffect104902ui_story = var_188_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_188_2 = 0.200000002980232

			if var_188_1 <= arg_185_1.time_ and arg_185_1.time_ < var_188_1 + var_188_2 and not isNil(var_188_0) then
				local var_188_3 = (arg_185_1.time_ - var_188_1) / var_188_2

				if arg_185_1.var_.characterEffect104902ui_story and not isNil(var_188_0) then
					arg_185_1.var_.characterEffect104902ui_story.fillFlat = false
				end
			end

			if arg_185_1.time_ >= var_188_1 + var_188_2 and arg_185_1.time_ < var_188_1 + var_188_2 + arg_188_0 and not isNil(var_188_0) and arg_185_1.var_.characterEffect104902ui_story then
				arg_185_1.var_.characterEffect104902ui_story.fillFlat = false
			end

			local var_188_4 = 0

			if var_188_4 < arg_185_1.time_ and arg_185_1.time_ <= var_188_4 + arg_188_0 then
				arg_185_1:PlayTimeline("104902ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2201cva")
			end

			local var_188_5 = 0
			local var_188_6 = 0.2

			if var_188_5 < arg_185_1.time_ and arg_185_1.time_ <= var_188_5 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				local var_188_7 = arg_185_1:FormatText(StoryNameCfg[562].name)

				arg_185_1.leftNameTxt_.text = var_188_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_8 = arg_185_1:GetWordFromCfg(414121044)
				local var_188_9 = arg_185_1:FormatText(var_188_8.content)

				arg_185_1.text_.text = var_188_9

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_10 = 8
				local var_188_11 = utf8.len(var_188_9)
				local var_188_12 = var_188_10 <= 0 and var_188_6 or var_188_6 * (var_188_11 / var_188_10)

				if var_188_12 > 0 and var_188_6 < var_188_12 then
					arg_185_1.talkMaxDuration = var_188_12

					if var_188_12 + var_188_5 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_12 + var_188_5
					end
				end

				arg_185_1.text_.text = var_188_9
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)
				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_13 = math.max(var_188_6, arg_185_1.talkMaxDuration)

			if var_188_5 <= arg_185_1.time_ and arg_185_1.time_ < var_188_5 + var_188_13 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_5) / var_188_13

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_5 + var_188_13 and arg_185_1.time_ < var_188_5 + var_188_13 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {}

		arg_185_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST15",
		"TextureConfig/Background/ST15a",
		"SofdecAsset/story/story_1041412.usm"
	},
	voices = {},
	skipMarkers = {
		414121038
	}
}
