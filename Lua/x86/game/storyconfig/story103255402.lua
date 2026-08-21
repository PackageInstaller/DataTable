return {
	Play325542001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 325542001
		arg_1_1.duration_ = 6.57

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play325542002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "J03f"

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
				local var_4_5 = arg_1_1.bgs_.J03f

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
					if iter_4_0 ~= "J03f" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = 0

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

			local var_4_24 = 0.1
			local var_4_25 = 1

			if var_4_24 < arg_1_1.time_ and arg_1_1.time_ <= var_4_24 + arg_4_0 then
				local var_4_26 = "play"
				local var_4_27 = "effect"

				arg_1_1:AudioAction(var_4_26, var_4_27, "se_story_121_00", "se_story_121_00_dooropen_loop", "")
			end

			local var_4_28 = 0
			local var_4_29 = 1

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				local var_4_30 = "play"
				local var_4_31 = "music"

				arg_1_1:AudioAction(var_4_30, var_4_31, "bgm_activity_4_8_story_mountain", "bgm_activity_4_8_story_mountain", "bgm_activity_4_8_story_mountain.awb")

				local var_4_32 = ""
				local var_4_33 = manager.audio:GetAudioName("bgm_activity_4_8_story_mountain", "bgm_activity_4_8_story_mountain")

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

			local var_4_34 = 0.1
			local var_4_35 = 1

			if var_4_34 < arg_1_1.time_ and arg_1_1.time_ <= var_4_34 + arg_4_0 then
				local var_4_36 = "play"
				local var_4_37 = "effect"

				arg_1_1:AudioAction(var_4_36, var_4_37, "se_story_148", "se_story_148_bell_temple_china02", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_38 = 1.56666666666667
			local var_4_39 = 1.15

			if var_4_38 < arg_1_1.time_ and arg_1_1.time_ <= var_4_38 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_40 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_40:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
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

				local var_4_41 = arg_1_1:GetWordFromCfg(325542001)
				local var_4_42 = arg_1_1:FormatText(var_4_41.content)

				arg_1_1.text_.text = var_4_42

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_43 = 46
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
	Play325542002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 325542002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play325542003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 0
			local var_11_1 = 1.625

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

				local var_11_2 = arg_8_1:GetWordFromCfg(325542002)
				local var_11_3 = arg_8_1:FormatText(var_11_2.content)

				arg_8_1.text_.text = var_11_3

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_4 = 65
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
	Play325542003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 325542003
		arg_12_1.duration_ = 7.33

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play325542004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = "J28f"

			if arg_12_1.bgs_[var_15_0] == nil then
				local var_15_1 = Object.Instantiate(arg_12_1.paintGo_)

				var_15_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_15_0)
				var_15_1.name = var_15_0
				var_15_1.transform.parent = arg_12_1.stage_.transform
				var_15_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_12_1.bgs_[var_15_0] = var_15_1
			end

			local var_15_2 = 1.26666666666667

			if var_15_2 < arg_12_1.time_ and arg_12_1.time_ <= var_15_2 + arg_15_0 then
				local var_15_3 = manager.ui.mainCamera.transform.localPosition
				local var_15_4 = Vector3.New(0, 0, 10) + Vector3.New(var_15_3.x, var_15_3.y, 0)
				local var_15_5 = arg_12_1.bgs_.J28f

				var_15_5.transform.localPosition = var_15_4
				var_15_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_15_6 = var_15_5:GetComponent("SpriteRenderer")

				if var_15_6 and var_15_6.sprite then
					local var_15_7 = (var_15_5.transform.localPosition - var_15_3).z
					local var_15_8 = manager.ui.mainCameraCom_
					local var_15_9 = 2 * var_15_7 * Mathf.Tan(var_15_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_15_10 = var_15_9 * var_15_8.aspect
					local var_15_11 = var_15_6.sprite.bounds.size.x
					local var_15_12 = var_15_6.sprite.bounds.size.y
					local var_15_13 = var_15_10 / var_15_11
					local var_15_14 = var_15_9 / var_15_12
					local var_15_15 = var_15_14 < var_15_13 and var_15_13 or var_15_14

					var_15_5.transform.localScale = Vector3.New(var_15_15, var_15_15, 0)
				end

				for iter_15_0, iter_15_1 in pairs(arg_12_1.bgs_) do
					if iter_15_0 ~= "J28f" then
						iter_15_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_15_16 = 0

			if var_15_16 < arg_12_1.time_ and arg_12_1.time_ <= var_15_16 + arg_15_0 then
				arg_12_1.allBtn_.enabled = false
			end

			local var_15_17 = 0.3

			if arg_12_1.time_ >= var_15_16 + var_15_17 and arg_12_1.time_ < var_15_16 + var_15_17 + arg_15_0 then
				arg_12_1.allBtn_.enabled = true
			end

			local var_15_18 = 0

			if var_15_18 < arg_12_1.time_ and arg_12_1.time_ <= var_15_18 + arg_15_0 then
				arg_12_1.mask_.enabled = true
				arg_12_1.mask_.raycastTarget = true

				arg_12_1:SetGaussion(false)
			end

			local var_15_19 = 1.26666666666667

			if var_15_18 <= arg_12_1.time_ and arg_12_1.time_ < var_15_18 + var_15_19 then
				local var_15_20 = (arg_12_1.time_ - var_15_18) / var_15_19
				local var_15_21 = Color.New(0, 0, 0)

				var_15_21.a = Mathf.Lerp(0, 1, var_15_20)
				arg_12_1.mask_.color = var_15_21
			end

			if arg_12_1.time_ >= var_15_18 + var_15_19 and arg_12_1.time_ < var_15_18 + var_15_19 + arg_15_0 then
				local var_15_22 = Color.New(0, 0, 0)

				var_15_22.a = 1
				arg_12_1.mask_.color = var_15_22
			end

			local var_15_23 = 1.26666666666667

			if var_15_23 < arg_12_1.time_ and arg_12_1.time_ <= var_15_23 + arg_15_0 then
				arg_12_1.mask_.enabled = true
				arg_12_1.mask_.raycastTarget = true

				arg_12_1:SetGaussion(false)
			end

			local var_15_24 = 1.26666666666667

			if var_15_23 <= arg_12_1.time_ and arg_12_1.time_ < var_15_23 + var_15_24 then
				local var_15_25 = (arg_12_1.time_ - var_15_23) / var_15_24
				local var_15_26 = Color.New(0, 0, 0)

				var_15_26.a = Mathf.Lerp(1, 0, var_15_25)
				arg_12_1.mask_.color = var_15_26
			end

			if arg_12_1.time_ >= var_15_23 + var_15_24 and arg_12_1.time_ < var_15_23 + var_15_24 + arg_15_0 then
				local var_15_27 = Color.New(0, 0, 0)
				local var_15_28 = 0

				arg_12_1.mask_.enabled = false
				var_15_27.a = var_15_28
				arg_12_1.mask_.color = var_15_27
			end

			local var_15_29 = 0.1
			local var_15_30 = 1

			if var_15_29 < arg_12_1.time_ and arg_12_1.time_ <= var_15_29 + arg_15_0 then
				local var_15_31 = "stop"
				local var_15_32 = "effect"

				arg_12_1:AudioAction(var_15_31, var_15_32, "se_story_121_00", "se_story_121_00_dooropen_loop", "")
			end

			local var_15_33 = 0.1
			local var_15_34 = 1

			if var_15_33 < arg_12_1.time_ and arg_12_1.time_ <= var_15_33 + arg_15_0 then
				local var_15_35 = "play"
				local var_15_36 = "effect"

				arg_12_1:AudioAction(var_15_35, var_15_36, "se_story_148", "se_story_148_amb_wind", "")
			end

			if arg_12_1.frameCnt_ <= 1 then
				arg_12_1.dialog_:SetActive(false)
			end

			local var_15_37 = 2.33333333333333
			local var_15_38 = 1.775

			if var_15_37 < arg_12_1.time_ and arg_12_1.time_ <= var_15_37 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0

				arg_12_1.dialog_:SetActive(true)

				arg_12_1.dialogCg_.alpha = 0

				local var_15_39 = LeanTween.value(arg_12_1.dialog_, 0, 1, 0.3)

				var_15_39:setOnUpdate(LuaHelper.FloatAction(function(arg_16_0)
					arg_12_1.dialogCg_.alpha = arg_16_0
				end))
				var_15_39:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_12_1.dialog_)
					var_15_39:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_12_1.duration_ = arg_12_1.duration_ + 0.3

				SetActive(arg_12_1.leftNameGo_, false)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_40 = arg_12_1:GetWordFromCfg(325542003)
				local var_15_41 = arg_12_1:FormatText(var_15_40.content)

				arg_12_1.text_.text = var_15_41

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_42 = 71
				local var_15_43 = utf8.len(var_15_41)
				local var_15_44 = var_15_42 <= 0 and var_15_38 or var_15_38 * (var_15_43 / var_15_42)

				if var_15_44 > 0 and var_15_38 < var_15_44 then
					arg_12_1.talkMaxDuration = var_15_44
					var_15_37 = var_15_37 + 0.3

					if var_15_44 + var_15_37 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_44 + var_15_37
					end
				end

				arg_12_1.text_.text = var_15_41
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)
				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_45 = var_15_37 + 0.3
			local var_15_46 = math.max(var_15_38, arg_12_1.talkMaxDuration)

			if var_15_45 <= arg_12_1.time_ and arg_12_1.time_ < var_15_45 + var_15_46 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_45) / var_15_46

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_45 + var_15_46 and arg_12_1.time_ < var_15_45 + var_15_46 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play325542004 = function(arg_18_0, arg_18_1)
		arg_18_1.time_ = 0
		arg_18_1.frameCnt_ = 0
		arg_18_1.state_ = "playing"
		arg_18_1.curTalkId_ = 325542004
		arg_18_1.duration_ = 5

		SetActive(arg_18_1.tipsGo_, false)

		function arg_18_1.onSingleLineFinish_()
			arg_18_1.onSingleLineUpdate_ = nil
			arg_18_1.onSingleLineFinish_ = nil
			arg_18_1.state_ = "waiting"
		end

		function arg_18_1.playNext_(arg_20_0)
			if arg_20_0 == 1 then
				arg_18_0:Play325542005(arg_18_1)
			end
		end

		function arg_18_1.onSingleLineUpdate_(arg_21_0)
			local var_21_0 = 0
			local var_21_1 = 0.4

			if var_21_0 < arg_18_1.time_ and arg_18_1.time_ <= var_21_0 + arg_21_0 then
				arg_18_1.talkMaxDuration = 0
				arg_18_1.dialogCg_.alpha = 1

				arg_18_1.dialog_:SetActive(true)
				SetActive(arg_18_1.leftNameGo_, true)

				local var_21_2 = arg_18_1:FormatText(StoryNameCfg[7].name)

				arg_18_1.leftNameTxt_.text = var_21_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_18_1.leftNameTxt_.transform)

				arg_18_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_18_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_18_1:RecordName(arg_18_1.leftNameTxt_.text)
				SetActive(arg_18_1.iconTrs_.gameObject, true)
				arg_18_1.iconController_:SetSelectedState("hero")

				arg_18_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_18_1.callingController_:SetSelectedState("normal")

				arg_18_1.keyicon_.color = Color.New(1, 1, 1)
				arg_18_1.icon_.color = Color.New(1, 1, 1)

				local var_21_3 = arg_18_1:GetWordFromCfg(325542004)
				local var_21_4 = arg_18_1:FormatText(var_21_3.content)

				arg_18_1.text_.text = var_21_4

				LuaForUtil.ClearLinePrefixSymbol(arg_18_1.text_)

				local var_21_5 = 16
				local var_21_6 = utf8.len(var_21_4)
				local var_21_7 = var_21_5 <= 0 and var_21_1 or var_21_1 * (var_21_6 / var_21_5)

				if var_21_7 > 0 and var_21_1 < var_21_7 then
					arg_18_1.talkMaxDuration = var_21_7

					if var_21_7 + var_21_0 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_7 + var_21_0
					end
				end

				arg_18_1.text_.text = var_21_4
				arg_18_1.typewritter.percent = 0

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(false)
				arg_18_1:RecordContent(arg_18_1.text_.text)
			end

			local var_21_8 = math.max(var_21_1, arg_18_1.talkMaxDuration)

			if var_21_0 <= arg_18_1.time_ and arg_18_1.time_ < var_21_0 + var_21_8 then
				arg_18_1.typewritter.percent = (arg_18_1.time_ - var_21_0) / var_21_8

				arg_18_1.typewritter:SetDirty()
			end

			if arg_18_1.time_ >= var_21_0 + var_21_8 and arg_18_1.time_ < var_21_0 + var_21_8 + arg_21_0 then
				arg_18_1.typewritter.percent = 1

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(true)
			end
		end

		arg_18_1.nodeConfigList_ = {}

		arg_18_1:InitPlayNodeList()
	end,
	Play325542005 = function(arg_22_0, arg_22_1)
		arg_22_1.time_ = 0
		arg_22_1.frameCnt_ = 0
		arg_22_1.state_ = "playing"
		arg_22_1.curTalkId_ = 325542005
		arg_22_1.duration_ = 4.03

		SetActive(arg_22_1.tipsGo_, false)

		function arg_22_1.onSingleLineFinish_()
			arg_22_1.onSingleLineUpdate_ = nil
			arg_22_1.onSingleLineFinish_ = nil
			arg_22_1.state_ = "waiting"
		end

		function arg_22_1.playNext_(arg_24_0)
			if arg_24_0 == 1 then
				arg_22_0:Play325542006(arg_22_1)
			end
		end

		function arg_22_1.onSingleLineUpdate_(arg_25_0)
			local var_25_0 = "10170ui_story"

			if arg_22_1.actors_[var_25_0] == nil then
				local var_25_1 = Asset.Load("Char/" .. "10170ui_story")

				if not isNil(var_25_1) then
					local var_25_2 = Object.Instantiate(Asset.Load("Char/" .. "10170ui_story"), arg_22_1.stage_.transform)

					var_25_2.name = var_25_0
					var_25_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_22_1.actors_[var_25_0] = var_25_2

					local var_25_3 = var_25_2:GetComponentInChildren(typeof(CharacterEffect))

					var_25_3.enabled = true

					local var_25_4 = GameObjectTools.GetOrAddComponent(var_25_2, typeof(DynamicBoneHelper))

					if var_25_4 then
						var_25_4:EnableDynamicBone(false)
					end

					arg_22_1:ShowWeapon(var_25_3.transform, false)

					arg_22_1.var_[var_25_0 .. "Animator"] = var_25_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_22_1.var_[var_25_0 .. "Animator"].applyRootMotion = true
					arg_22_1.var_[var_25_0 .. "LipSync"] = var_25_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_25_5 = arg_22_1.actors_["10170ui_story"].transform
			local var_25_6 = 0

			if var_25_6 < arg_22_1.time_ and arg_22_1.time_ <= var_25_6 + arg_25_0 then
				arg_22_1.var_.moveOldPos10170ui_story = var_25_5.localPosition

				local var_25_7 = GameObjectTools.GetOrAddComponent(var_25_5.gameObject, typeof(DynamicBoneHelper))

				if var_25_7 then
					var_25_7:EnableDynamicBone(false)
				end
			end

			local var_25_8 = 0.001

			if var_25_6 <= arg_22_1.time_ and arg_22_1.time_ < var_25_6 + var_25_8 then
				local var_25_9 = (arg_22_1.time_ - var_25_6) / var_25_8
				local var_25_10 = Vector3.New(0, -1.03, -6.05)

				var_25_5.localPosition = Vector3.Lerp(arg_22_1.var_.moveOldPos10170ui_story, var_25_10, var_25_9)

				local var_25_11 = manager.ui.mainCamera.transform.position - var_25_5.position

				var_25_5.forward = Vector3.New(var_25_11.x, var_25_11.y, var_25_11.z)

				local var_25_12 = var_25_5.localEulerAngles

				var_25_12.z = 0
				var_25_12.x = 0
				var_25_5.localEulerAngles = var_25_12
			end

			if arg_22_1.time_ >= var_25_6 + var_25_8 and arg_22_1.time_ < var_25_6 + var_25_8 + arg_25_0 then
				var_25_5.localPosition = Vector3.New(0, -1.03, -6.05)

				local var_25_13 = manager.ui.mainCamera.transform.position - var_25_5.position

				var_25_5.forward = Vector3.New(var_25_13.x, var_25_13.y, var_25_13.z)

				local var_25_14 = var_25_5.localEulerAngles

				var_25_14.z = 0
				var_25_14.x = 0
				var_25_5.localEulerAngles = var_25_14

				local var_25_15 = GameObjectTools.GetOrAddComponent(var_25_5.gameObject, typeof(DynamicBoneHelper))

				if var_25_15 then
					var_25_15:EnableDynamicBone(true)
				end
			end

			local var_25_16 = arg_22_1.actors_["10170ui_story"]
			local var_25_17 = 0

			if var_25_17 < arg_22_1.time_ and arg_22_1.time_ <= var_25_17 + arg_25_0 and not isNil(var_25_16) and arg_22_1.var_.characterEffect10170ui_story == nil then
				arg_22_1.var_.characterEffect10170ui_story = var_25_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_25_18 = 0.200000002980232

			if var_25_17 <= arg_22_1.time_ and arg_22_1.time_ < var_25_17 + var_25_18 and not isNil(var_25_16) then
				local var_25_19 = (arg_22_1.time_ - var_25_17) / var_25_18

				if arg_22_1.var_.characterEffect10170ui_story and not isNil(var_25_16) then
					arg_22_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_22_1.time_ >= var_25_17 + var_25_18 and arg_22_1.time_ < var_25_17 + var_25_18 + arg_25_0 and not isNil(var_25_16) and arg_22_1.var_.characterEffect10170ui_story then
				arg_22_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			local var_25_20 = 0

			if var_25_20 < arg_22_1.time_ and arg_22_1.time_ <= var_25_20 + arg_25_0 then
				arg_22_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/story10170/story10170action/10170action1_1")
			end

			local var_25_21 = 0

			if var_25_21 < arg_22_1.time_ and arg_22_1.time_ <= var_25_21 + arg_25_0 then
				arg_22_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_25_22 = 0
			local var_25_23 = 0.35

			if var_25_22 < arg_22_1.time_ and arg_22_1.time_ <= var_25_22 + arg_25_0 then
				arg_22_1.talkMaxDuration = 0
				arg_22_1.dialogCg_.alpha = 1

				arg_22_1.dialog_:SetActive(true)
				SetActive(arg_22_1.leftNameGo_, true)

				local var_25_24 = arg_22_1:FormatText(StoryNameCfg[1450].name)

				arg_22_1.leftNameTxt_.text = var_25_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_22_1.leftNameTxt_.transform)

				arg_22_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_22_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_22_1:RecordName(arg_22_1.leftNameTxt_.text)
				SetActive(arg_22_1.iconTrs_.gameObject, false)
				arg_22_1.callingController_:SetSelectedState("normal")

				local var_25_25 = arg_22_1:GetWordFromCfg(325542005)
				local var_25_26 = arg_22_1:FormatText(var_25_25.content)

				arg_22_1.text_.text = var_25_26

				LuaForUtil.ClearLinePrefixSymbol(arg_22_1.text_)

				local var_25_27 = 14
				local var_25_28 = utf8.len(var_25_26)
				local var_25_29 = var_25_27 <= 0 and var_25_23 or var_25_23 * (var_25_28 / var_25_27)

				if var_25_29 > 0 and var_25_23 < var_25_29 then
					arg_22_1.talkMaxDuration = var_25_29

					if var_25_29 + var_25_22 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_29 + var_25_22
					end
				end

				arg_22_1.text_.text = var_25_26
				arg_22_1.typewritter.percent = 0

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325542", "325542005", "story_v_out_325542.awb") ~= 0 then
					local var_25_30 = manager.audio:GetVoiceLength("story_v_out_325542", "325542005", "story_v_out_325542.awb") / 1000

					if var_25_30 + var_25_22 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_30 + var_25_22
					end

					if var_25_25.prefab_name ~= "" and arg_22_1.actors_[var_25_25.prefab_name] ~= nil then
						local var_25_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_22_1.actors_[var_25_25.prefab_name].transform, "story_v_out_325542", "325542005", "story_v_out_325542.awb")

						arg_22_1:RecordAudio("325542005", var_25_31)
						arg_22_1:RecordAudio("325542005", var_25_31)
					else
						arg_22_1:AudioAction("play", "voice", "story_v_out_325542", "325542005", "story_v_out_325542.awb")
					end

					arg_22_1:RecordHistoryTalkVoice("story_v_out_325542", "325542005", "story_v_out_325542.awb")
				end

				arg_22_1:RecordContent(arg_22_1.text_.text)
			end

			local var_25_32 = math.max(var_25_23, arg_22_1.talkMaxDuration)

			if var_25_22 <= arg_22_1.time_ and arg_22_1.time_ < var_25_22 + var_25_32 then
				arg_22_1.typewritter.percent = (arg_22_1.time_ - var_25_22) / var_25_32

				arg_22_1.typewritter:SetDirty()
			end

			if arg_22_1.time_ >= var_25_22 + var_25_32 and arg_22_1.time_ < var_25_22 + var_25_32 + arg_25_0 then
				arg_22_1.typewritter.percent = 1

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(true)
			end
		end

		arg_22_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_22_1:InitPlayNodeList()
	end,
	Play325542006 = function(arg_26_0, arg_26_1)
		arg_26_1.time_ = 0
		arg_26_1.frameCnt_ = 0
		arg_26_1.state_ = "playing"
		arg_26_1.curTalkId_ = 325542006
		arg_26_1.duration_ = 5

		SetActive(arg_26_1.tipsGo_, false)

		function arg_26_1.onSingleLineFinish_()
			arg_26_1.onSingleLineUpdate_ = nil
			arg_26_1.onSingleLineFinish_ = nil
			arg_26_1.state_ = "waiting"
		end

		function arg_26_1.playNext_(arg_28_0)
			if arg_28_0 == 1 then
				arg_26_0:Play325542007(arg_26_1)
			end
		end

		function arg_26_1.onSingleLineUpdate_(arg_29_0)
			local var_29_0 = arg_26_1.actors_["10170ui_story"].transform
			local var_29_1 = 0

			if var_29_1 < arg_26_1.time_ and arg_26_1.time_ <= var_29_1 + arg_29_0 then
				arg_26_1.var_.moveOldPos10170ui_story = var_29_0.localPosition

				local var_29_2 = GameObjectTools.GetOrAddComponent(var_29_0.gameObject, typeof(DynamicBoneHelper))

				if var_29_2 then
					var_29_2:EnableDynamicBone(false)
				end
			end

			local var_29_3 = 0.001

			if var_29_1 <= arg_26_1.time_ and arg_26_1.time_ < var_29_1 + var_29_3 then
				local var_29_4 = (arg_26_1.time_ - var_29_1) / var_29_3
				local var_29_5 = Vector3.New(0, 100, 0)

				var_29_0.localPosition = Vector3.Lerp(arg_26_1.var_.moveOldPos10170ui_story, var_29_5, var_29_4)

				local var_29_6 = manager.ui.mainCamera.transform.position - var_29_0.position

				var_29_0.forward = Vector3.New(var_29_6.x, var_29_6.y, var_29_6.z)

				local var_29_7 = var_29_0.localEulerAngles

				var_29_7.z = 0
				var_29_7.x = 0
				var_29_0.localEulerAngles = var_29_7
			end

			if arg_26_1.time_ >= var_29_1 + var_29_3 and arg_26_1.time_ < var_29_1 + var_29_3 + arg_29_0 then
				var_29_0.localPosition = Vector3.New(0, 100, 0)

				local var_29_8 = manager.ui.mainCamera.transform.position - var_29_0.position

				var_29_0.forward = Vector3.New(var_29_8.x, var_29_8.y, var_29_8.z)

				local var_29_9 = var_29_0.localEulerAngles

				var_29_9.z = 0
				var_29_9.x = 0
				var_29_0.localEulerAngles = var_29_9

				local var_29_10 = GameObjectTools.GetOrAddComponent(var_29_0.gameObject, typeof(DynamicBoneHelper))

				if var_29_10 then
					var_29_10:EnableDynamicBone(true)
				end
			end

			local var_29_11 = arg_26_1.actors_["10170ui_story"]
			local var_29_12 = 0

			if var_29_12 < arg_26_1.time_ and arg_26_1.time_ <= var_29_12 + arg_29_0 and not isNil(var_29_11) and arg_26_1.var_.characterEffect10170ui_story == nil then
				arg_26_1.var_.characterEffect10170ui_story = var_29_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_29_13 = 0.200000002980232

			if var_29_12 <= arg_26_1.time_ and arg_26_1.time_ < var_29_12 + var_29_13 and not isNil(var_29_11) then
				local var_29_14 = (arg_26_1.time_ - var_29_12) / var_29_13

				if arg_26_1.var_.characterEffect10170ui_story and not isNil(var_29_11) then
					local var_29_15 = Mathf.Lerp(0, 0.5, var_29_14)

					arg_26_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_26_1.var_.characterEffect10170ui_story.fillRatio = var_29_15
				end
			end

			if arg_26_1.time_ >= var_29_12 + var_29_13 and arg_26_1.time_ < var_29_12 + var_29_13 + arg_29_0 and not isNil(var_29_11) and arg_26_1.var_.characterEffect10170ui_story then
				local var_29_16 = 0.5

				arg_26_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_26_1.var_.characterEffect10170ui_story.fillRatio = var_29_16
			end

			local var_29_17 = 0
			local var_29_18 = 1.15

			if var_29_17 < arg_26_1.time_ and arg_26_1.time_ <= var_29_17 + arg_29_0 then
				arg_26_1.talkMaxDuration = 0
				arg_26_1.dialogCg_.alpha = 1

				arg_26_1.dialog_:SetActive(true)
				SetActive(arg_26_1.leftNameGo_, false)

				arg_26_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_26_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_26_1:RecordName(arg_26_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_26_1.iconTrs_.gameObject, false)
				arg_26_1.callingController_:SetSelectedState("normal")

				local var_29_19 = arg_26_1:GetWordFromCfg(325542006)
				local var_29_20 = arg_26_1:FormatText(var_29_19.content)

				arg_26_1.text_.text = var_29_20

				LuaForUtil.ClearLinePrefixSymbol(arg_26_1.text_)

				local var_29_21 = 46
				local var_29_22 = utf8.len(var_29_20)
				local var_29_23 = var_29_21 <= 0 and var_29_18 or var_29_18 * (var_29_22 / var_29_21)

				if var_29_23 > 0 and var_29_18 < var_29_23 then
					arg_26_1.talkMaxDuration = var_29_23

					if var_29_23 + var_29_17 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_23 + var_29_17
					end
				end

				arg_26_1.text_.text = var_29_20
				arg_26_1.typewritter.percent = 0

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(false)
				arg_26_1:RecordContent(arg_26_1.text_.text)
			end

			local var_29_24 = math.max(var_29_18, arg_26_1.talkMaxDuration)

			if var_29_17 <= arg_26_1.time_ and arg_26_1.time_ < var_29_17 + var_29_24 then
				arg_26_1.typewritter.percent = (arg_26_1.time_ - var_29_17) / var_29_24

				arg_26_1.typewritter:SetDirty()
			end

			if arg_26_1.time_ >= var_29_17 + var_29_24 and arg_26_1.time_ < var_29_17 + var_29_24 + arg_29_0 then
				arg_26_1.typewritter.percent = 1

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(true)
			end
		end

		arg_26_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_26_1:InitPlayNodeList()
	end,
	Play325542007 = function(arg_30_0, arg_30_1)
		arg_30_1.time_ = 0
		arg_30_1.frameCnt_ = 0
		arg_30_1.state_ = "playing"
		arg_30_1.curTalkId_ = 325542007
		arg_30_1.duration_ = 5.83

		SetActive(arg_30_1.tipsGo_, false)

		function arg_30_1.onSingleLineFinish_()
			arg_30_1.onSingleLineUpdate_ = nil
			arg_30_1.onSingleLineFinish_ = nil
			arg_30_1.state_ = "waiting"
		end

		function arg_30_1.playNext_(arg_32_0)
			if arg_32_0 == 1 then
				arg_30_0:Play325542008(arg_30_1)
			end
		end

		function arg_30_1.onSingleLineUpdate_(arg_33_0)
			local var_33_0 = "1170ui_story"

			if arg_30_1.actors_[var_33_0] == nil then
				local var_33_1 = Asset.Load("Char/" .. "1170ui_story")

				if not isNil(var_33_1) then
					local var_33_2 = Object.Instantiate(Asset.Load("Char/" .. "1170ui_story"), arg_30_1.stage_.transform)

					var_33_2.name = var_33_0
					var_33_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_30_1.actors_[var_33_0] = var_33_2

					local var_33_3 = var_33_2:GetComponentInChildren(typeof(CharacterEffect))

					var_33_3.enabled = true

					local var_33_4 = GameObjectTools.GetOrAddComponent(var_33_2, typeof(DynamicBoneHelper))

					if var_33_4 then
						var_33_4:EnableDynamicBone(false)
					end

					arg_30_1:ShowWeapon(var_33_3.transform, false)

					arg_30_1.var_[var_33_0 .. "Animator"] = var_33_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_30_1.var_[var_33_0 .. "Animator"].applyRootMotion = true
					arg_30_1.var_[var_33_0 .. "LipSync"] = var_33_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_33_5 = arg_30_1.actors_["1170ui_story"].transform
			local var_33_6 = 0

			if var_33_6 < arg_30_1.time_ and arg_30_1.time_ <= var_33_6 + arg_33_0 then
				arg_30_1.var_.moveOldPos1170ui_story = var_33_5.localPosition

				local var_33_7 = GameObjectTools.GetOrAddComponent(var_33_5.gameObject, typeof(DynamicBoneHelper))

				if var_33_7 then
					var_33_7:EnableDynamicBone(false)
				end
			end

			local var_33_8 = 0.001

			if var_33_6 <= arg_30_1.time_ and arg_30_1.time_ < var_33_6 + var_33_8 then
				local var_33_9 = (arg_30_1.time_ - var_33_6) / var_33_8
				local var_33_10 = Vector3.New(0.03, -0.95, -6.08)

				var_33_5.localPosition = Vector3.Lerp(arg_30_1.var_.moveOldPos1170ui_story, var_33_10, var_33_9)

				local var_33_11 = manager.ui.mainCamera.transform.position - var_33_5.position

				var_33_5.forward = Vector3.New(var_33_11.x, var_33_11.y, var_33_11.z)

				local var_33_12 = var_33_5.localEulerAngles

				var_33_12.z = 0
				var_33_12.x = 0
				var_33_5.localEulerAngles = var_33_12
			end

			if arg_30_1.time_ >= var_33_6 + var_33_8 and arg_30_1.time_ < var_33_6 + var_33_8 + arg_33_0 then
				var_33_5.localPosition = Vector3.New(0.03, -0.95, -6.08)

				local var_33_13 = manager.ui.mainCamera.transform.position - var_33_5.position

				var_33_5.forward = Vector3.New(var_33_13.x, var_33_13.y, var_33_13.z)

				local var_33_14 = var_33_5.localEulerAngles

				var_33_14.z = 0
				var_33_14.x = 0
				var_33_5.localEulerAngles = var_33_14

				local var_33_15 = GameObjectTools.GetOrAddComponent(var_33_5.gameObject, typeof(DynamicBoneHelper))

				if var_33_15 then
					var_33_15:EnableDynamicBone(true)
				end
			end

			local var_33_16 = arg_30_1.actors_["1170ui_story"]
			local var_33_17 = 0

			if var_33_17 < arg_30_1.time_ and arg_30_1.time_ <= var_33_17 + arg_33_0 and not isNil(var_33_16) and arg_30_1.var_.characterEffect1170ui_story == nil then
				arg_30_1.var_.characterEffect1170ui_story = var_33_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_33_18 = 0.200000002980232

			if var_33_17 <= arg_30_1.time_ and arg_30_1.time_ < var_33_17 + var_33_18 and not isNil(var_33_16) then
				local var_33_19 = (arg_30_1.time_ - var_33_17) / var_33_18

				if arg_30_1.var_.characterEffect1170ui_story and not isNil(var_33_16) then
					arg_30_1.var_.characterEffect1170ui_story.fillFlat = false
				end
			end

			if arg_30_1.time_ >= var_33_17 + var_33_18 and arg_30_1.time_ < var_33_17 + var_33_18 + arg_33_0 and not isNil(var_33_16) and arg_30_1.var_.characterEffect1170ui_story then
				arg_30_1.var_.characterEffect1170ui_story.fillFlat = false
			end

			local var_33_20 = 0

			if var_33_20 < arg_30_1.time_ and arg_30_1.time_ <= var_33_20 + arg_33_0 then
				arg_30_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/story1170/story1170action/1170action2_1")
			end

			local var_33_21 = 0

			if var_33_21 < arg_30_1.time_ and arg_30_1.time_ <= var_33_21 + arg_33_0 then
				arg_30_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_33_22 = 0
			local var_33_23 = 0.525

			if var_33_22 < arg_30_1.time_ and arg_30_1.time_ <= var_33_22 + arg_33_0 then
				arg_30_1.talkMaxDuration = 0
				arg_30_1.dialogCg_.alpha = 1

				arg_30_1.dialog_:SetActive(true)
				SetActive(arg_30_1.leftNameGo_, true)

				local var_33_24 = arg_30_1:FormatText(StoryNameCfg[318].name)

				arg_30_1.leftNameTxt_.text = var_33_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_30_1.leftNameTxt_.transform)

				arg_30_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_30_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_30_1:RecordName(arg_30_1.leftNameTxt_.text)
				SetActive(arg_30_1.iconTrs_.gameObject, false)
				arg_30_1.callingController_:SetSelectedState("normal")

				local var_33_25 = arg_30_1:GetWordFromCfg(325542007)
				local var_33_26 = arg_30_1:FormatText(var_33_25.content)

				arg_30_1.text_.text = var_33_26

				LuaForUtil.ClearLinePrefixSymbol(arg_30_1.text_)

				local var_33_27 = 21
				local var_33_28 = utf8.len(var_33_26)
				local var_33_29 = var_33_27 <= 0 and var_33_23 or var_33_23 * (var_33_28 / var_33_27)

				if var_33_29 > 0 and var_33_23 < var_33_29 then
					arg_30_1.talkMaxDuration = var_33_29

					if var_33_29 + var_33_22 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_29 + var_33_22
					end
				end

				arg_30_1.text_.text = var_33_26
				arg_30_1.typewritter.percent = 0

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325542", "325542007", "story_v_out_325542.awb") ~= 0 then
					local var_33_30 = manager.audio:GetVoiceLength("story_v_out_325542", "325542007", "story_v_out_325542.awb") / 1000

					if var_33_30 + var_33_22 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_30 + var_33_22
					end

					if var_33_25.prefab_name ~= "" and arg_30_1.actors_[var_33_25.prefab_name] ~= nil then
						local var_33_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_30_1.actors_[var_33_25.prefab_name].transform, "story_v_out_325542", "325542007", "story_v_out_325542.awb")

						arg_30_1:RecordAudio("325542007", var_33_31)
						arg_30_1:RecordAudio("325542007", var_33_31)
					else
						arg_30_1:AudioAction("play", "voice", "story_v_out_325542", "325542007", "story_v_out_325542.awb")
					end

					arg_30_1:RecordHistoryTalkVoice("story_v_out_325542", "325542007", "story_v_out_325542.awb")
				end

				arg_30_1:RecordContent(arg_30_1.text_.text)
			end

			local var_33_32 = math.max(var_33_23, arg_30_1.talkMaxDuration)

			if var_33_22 <= arg_30_1.time_ and arg_30_1.time_ < var_33_22 + var_33_32 then
				arg_30_1.typewritter.percent = (arg_30_1.time_ - var_33_22) / var_33_32

				arg_30_1.typewritter:SetDirty()
			end

			if arg_30_1.time_ >= var_33_22 + var_33_32 and arg_30_1.time_ < var_33_22 + var_33_32 + arg_33_0 then
				arg_30_1.typewritter.percent = 1

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(true)
			end
		end

		arg_30_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_30_1:InitPlayNodeList()
	end,
	Play325542008 = function(arg_34_0, arg_34_1)
		arg_34_1.time_ = 0
		arg_34_1.frameCnt_ = 0
		arg_34_1.state_ = "playing"
		arg_34_1.curTalkId_ = 325542008
		arg_34_1.duration_ = 5

		SetActive(arg_34_1.tipsGo_, false)

		function arg_34_1.onSingleLineFinish_()
			arg_34_1.onSingleLineUpdate_ = nil
			arg_34_1.onSingleLineFinish_ = nil
			arg_34_1.state_ = "waiting"
		end

		function arg_34_1.playNext_(arg_36_0)
			if arg_36_0 == 1 then
				arg_34_0:Play325542009(arg_34_1)
			end
		end

		function arg_34_1.onSingleLineUpdate_(arg_37_0)
			local var_37_0 = arg_34_1.actors_["1170ui_story"]
			local var_37_1 = 0

			if var_37_1 < arg_34_1.time_ and arg_34_1.time_ <= var_37_1 + arg_37_0 and not isNil(var_37_0) and arg_34_1.var_.characterEffect1170ui_story == nil then
				arg_34_1.var_.characterEffect1170ui_story = var_37_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_37_2 = 0.200000002980232

			if var_37_1 <= arg_34_1.time_ and arg_34_1.time_ < var_37_1 + var_37_2 and not isNil(var_37_0) then
				local var_37_3 = (arg_34_1.time_ - var_37_1) / var_37_2

				if arg_34_1.var_.characterEffect1170ui_story and not isNil(var_37_0) then
					local var_37_4 = Mathf.Lerp(0, 0.5, var_37_3)

					arg_34_1.var_.characterEffect1170ui_story.fillFlat = true
					arg_34_1.var_.characterEffect1170ui_story.fillRatio = var_37_4
				end
			end

			if arg_34_1.time_ >= var_37_1 + var_37_2 and arg_34_1.time_ < var_37_1 + var_37_2 + arg_37_0 and not isNil(var_37_0) and arg_34_1.var_.characterEffect1170ui_story then
				local var_37_5 = 0.5

				arg_34_1.var_.characterEffect1170ui_story.fillFlat = true
				arg_34_1.var_.characterEffect1170ui_story.fillRatio = var_37_5
			end

			local var_37_6 = 0
			local var_37_7 = 0.5

			if var_37_6 < arg_34_1.time_ and arg_34_1.time_ <= var_37_6 + arg_37_0 then
				arg_34_1.talkMaxDuration = 0
				arg_34_1.dialogCg_.alpha = 1

				arg_34_1.dialog_:SetActive(true)
				SetActive(arg_34_1.leftNameGo_, true)

				local var_37_8 = arg_34_1:FormatText(StoryNameCfg[7].name)

				arg_34_1.leftNameTxt_.text = var_37_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_34_1.leftNameTxt_.transform)

				arg_34_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_34_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_34_1:RecordName(arg_34_1.leftNameTxt_.text)
				SetActive(arg_34_1.iconTrs_.gameObject, true)
				arg_34_1.iconController_:SetSelectedState("hero")

				arg_34_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_34_1.callingController_:SetSelectedState("normal")

				arg_34_1.keyicon_.color = Color.New(1, 1, 1)
				arg_34_1.icon_.color = Color.New(1, 1, 1)

				local var_37_9 = arg_34_1:GetWordFromCfg(325542008)
				local var_37_10 = arg_34_1:FormatText(var_37_9.content)

				arg_34_1.text_.text = var_37_10

				LuaForUtil.ClearLinePrefixSymbol(arg_34_1.text_)

				local var_37_11 = 20
				local var_37_12 = utf8.len(var_37_10)
				local var_37_13 = var_37_11 <= 0 and var_37_7 or var_37_7 * (var_37_12 / var_37_11)

				if var_37_13 > 0 and var_37_7 < var_37_13 then
					arg_34_1.talkMaxDuration = var_37_13

					if var_37_13 + var_37_6 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_13 + var_37_6
					end
				end

				arg_34_1.text_.text = var_37_10
				arg_34_1.typewritter.percent = 0

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(false)
				arg_34_1:RecordContent(arg_34_1.text_.text)
			end

			local var_37_14 = math.max(var_37_7, arg_34_1.talkMaxDuration)

			if var_37_6 <= arg_34_1.time_ and arg_34_1.time_ < var_37_6 + var_37_14 then
				arg_34_1.typewritter.percent = (arg_34_1.time_ - var_37_6) / var_37_14

				arg_34_1.typewritter:SetDirty()
			end

			if arg_34_1.time_ >= var_37_6 + var_37_14 and arg_34_1.time_ < var_37_6 + var_37_14 + arg_37_0 then
				arg_34_1.typewritter.percent = 1

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(true)
			end
		end

		arg_34_1.nodeConfigList_ = {}

		arg_34_1:InitPlayNodeList()
	end,
	Play325542009 = function(arg_38_0, arg_38_1)
		arg_38_1.time_ = 0
		arg_38_1.frameCnt_ = 0
		arg_38_1.state_ = "playing"
		arg_38_1.curTalkId_ = 325542009
		arg_38_1.duration_ = 7.87

		SetActive(arg_38_1.tipsGo_, false)

		function arg_38_1.onSingleLineFinish_()
			arg_38_1.onSingleLineUpdate_ = nil
			arg_38_1.onSingleLineFinish_ = nil
			arg_38_1.state_ = "waiting"
		end

		function arg_38_1.playNext_(arg_40_0)
			if arg_40_0 == 1 then
				arg_38_0:Play325542010(arg_38_1)
			end
		end

		function arg_38_1.onSingleLineUpdate_(arg_41_0)
			local var_41_0 = arg_38_1.actors_["1170ui_story"]
			local var_41_1 = 0

			if var_41_1 < arg_38_1.time_ and arg_38_1.time_ <= var_41_1 + arg_41_0 and not isNil(var_41_0) and arg_38_1.var_.characterEffect1170ui_story == nil then
				arg_38_1.var_.characterEffect1170ui_story = var_41_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_41_2 = 0.200000002980232

			if var_41_1 <= arg_38_1.time_ and arg_38_1.time_ < var_41_1 + var_41_2 and not isNil(var_41_0) then
				local var_41_3 = (arg_38_1.time_ - var_41_1) / var_41_2

				if arg_38_1.var_.characterEffect1170ui_story and not isNil(var_41_0) then
					arg_38_1.var_.characterEffect1170ui_story.fillFlat = false
				end
			end

			if arg_38_1.time_ >= var_41_1 + var_41_2 and arg_38_1.time_ < var_41_1 + var_41_2 + arg_41_0 and not isNil(var_41_0) and arg_38_1.var_.characterEffect1170ui_story then
				arg_38_1.var_.characterEffect1170ui_story.fillFlat = false
			end

			local var_41_4 = 0

			if var_41_4 < arg_38_1.time_ and arg_38_1.time_ <= var_41_4 + arg_41_0 then
				arg_38_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/story1170/story1170actionlink/1170action426")
			end

			local var_41_5 = 0
			local var_41_6 = 0.775

			if var_41_5 < arg_38_1.time_ and arg_38_1.time_ <= var_41_5 + arg_41_0 then
				arg_38_1.talkMaxDuration = 0
				arg_38_1.dialogCg_.alpha = 1

				arg_38_1.dialog_:SetActive(true)
				SetActive(arg_38_1.leftNameGo_, true)

				local var_41_7 = arg_38_1:FormatText(StoryNameCfg[318].name)

				arg_38_1.leftNameTxt_.text = var_41_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_38_1.leftNameTxt_.transform)

				arg_38_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_38_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_38_1:RecordName(arg_38_1.leftNameTxt_.text)
				SetActive(arg_38_1.iconTrs_.gameObject, false)
				arg_38_1.callingController_:SetSelectedState("normal")

				local var_41_8 = arg_38_1:GetWordFromCfg(325542009)
				local var_41_9 = arg_38_1:FormatText(var_41_8.content)

				arg_38_1.text_.text = var_41_9

				LuaForUtil.ClearLinePrefixSymbol(arg_38_1.text_)

				local var_41_10 = 31
				local var_41_11 = utf8.len(var_41_9)
				local var_41_12 = var_41_10 <= 0 and var_41_6 or var_41_6 * (var_41_11 / var_41_10)

				if var_41_12 > 0 and var_41_6 < var_41_12 then
					arg_38_1.talkMaxDuration = var_41_12

					if var_41_12 + var_41_5 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_12 + var_41_5
					end
				end

				arg_38_1.text_.text = var_41_9
				arg_38_1.typewritter.percent = 0

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325542", "325542009", "story_v_out_325542.awb") ~= 0 then
					local var_41_13 = manager.audio:GetVoiceLength("story_v_out_325542", "325542009", "story_v_out_325542.awb") / 1000

					if var_41_13 + var_41_5 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_13 + var_41_5
					end

					if var_41_8.prefab_name ~= "" and arg_38_1.actors_[var_41_8.prefab_name] ~= nil then
						local var_41_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_38_1.actors_[var_41_8.prefab_name].transform, "story_v_out_325542", "325542009", "story_v_out_325542.awb")

						arg_38_1:RecordAudio("325542009", var_41_14)
						arg_38_1:RecordAudio("325542009", var_41_14)
					else
						arg_38_1:AudioAction("play", "voice", "story_v_out_325542", "325542009", "story_v_out_325542.awb")
					end

					arg_38_1:RecordHistoryTalkVoice("story_v_out_325542", "325542009", "story_v_out_325542.awb")
				end

				arg_38_1:RecordContent(arg_38_1.text_.text)
			end

			local var_41_15 = math.max(var_41_6, arg_38_1.talkMaxDuration)

			if var_41_5 <= arg_38_1.time_ and arg_38_1.time_ < var_41_5 + var_41_15 then
				arg_38_1.typewritter.percent = (arg_38_1.time_ - var_41_5) / var_41_15

				arg_38_1.typewritter:SetDirty()
			end

			if arg_38_1.time_ >= var_41_5 + var_41_15 and arg_38_1.time_ < var_41_5 + var_41_15 + arg_41_0 then
				arg_38_1.typewritter.percent = 1

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(true)
			end
		end

		arg_38_1.nodeConfigList_ = {}

		arg_38_1:InitPlayNodeList()
	end,
	Play325542010 = function(arg_42_0, arg_42_1)
		arg_42_1.time_ = 0
		arg_42_1.frameCnt_ = 0
		arg_42_1.state_ = "playing"
		arg_42_1.curTalkId_ = 325542010
		arg_42_1.duration_ = 5

		SetActive(arg_42_1.tipsGo_, false)

		function arg_42_1.onSingleLineFinish_()
			arg_42_1.onSingleLineUpdate_ = nil
			arg_42_1.onSingleLineFinish_ = nil
			arg_42_1.state_ = "waiting"
		end

		function arg_42_1.playNext_(arg_44_0)
			if arg_44_0 == 1 then
				arg_42_0:Play325542011(arg_42_1)
			end
		end

		function arg_42_1.onSingleLineUpdate_(arg_45_0)
			local var_45_0 = arg_42_1.actors_["1170ui_story"]
			local var_45_1 = 0

			if var_45_1 < arg_42_1.time_ and arg_42_1.time_ <= var_45_1 + arg_45_0 and not isNil(var_45_0) and arg_42_1.var_.characterEffect1170ui_story == nil then
				arg_42_1.var_.characterEffect1170ui_story = var_45_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_45_2 = 0.200000002980232

			if var_45_1 <= arg_42_1.time_ and arg_42_1.time_ < var_45_1 + var_45_2 and not isNil(var_45_0) then
				local var_45_3 = (arg_42_1.time_ - var_45_1) / var_45_2

				if arg_42_1.var_.characterEffect1170ui_story and not isNil(var_45_0) then
					local var_45_4 = Mathf.Lerp(0, 0.5, var_45_3)

					arg_42_1.var_.characterEffect1170ui_story.fillFlat = true
					arg_42_1.var_.characterEffect1170ui_story.fillRatio = var_45_4
				end
			end

			if arg_42_1.time_ >= var_45_1 + var_45_2 and arg_42_1.time_ < var_45_1 + var_45_2 + arg_45_0 and not isNil(var_45_0) and arg_42_1.var_.characterEffect1170ui_story then
				local var_45_5 = 0.5

				arg_42_1.var_.characterEffect1170ui_story.fillFlat = true
				arg_42_1.var_.characterEffect1170ui_story.fillRatio = var_45_5
			end

			local var_45_6 = 0
			local var_45_7 = 0.175

			if var_45_6 < arg_42_1.time_ and arg_42_1.time_ <= var_45_6 + arg_45_0 then
				arg_42_1.talkMaxDuration = 0
				arg_42_1.dialogCg_.alpha = 1

				arg_42_1.dialog_:SetActive(true)
				SetActive(arg_42_1.leftNameGo_, true)

				local var_45_8 = arg_42_1:FormatText(StoryNameCfg[7].name)

				arg_42_1.leftNameTxt_.text = var_45_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_42_1.leftNameTxt_.transform)

				arg_42_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_42_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_42_1:RecordName(arg_42_1.leftNameTxt_.text)
				SetActive(arg_42_1.iconTrs_.gameObject, true)
				arg_42_1.iconController_:SetSelectedState("hero")

				arg_42_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_42_1.callingController_:SetSelectedState("normal")

				arg_42_1.keyicon_.color = Color.New(1, 1, 1)
				arg_42_1.icon_.color = Color.New(1, 1, 1)

				local var_45_9 = arg_42_1:GetWordFromCfg(325542010)
				local var_45_10 = arg_42_1:FormatText(var_45_9.content)

				arg_42_1.text_.text = var_45_10

				LuaForUtil.ClearLinePrefixSymbol(arg_42_1.text_)

				local var_45_11 = 7
				local var_45_12 = utf8.len(var_45_10)
				local var_45_13 = var_45_11 <= 0 and var_45_7 or var_45_7 * (var_45_12 / var_45_11)

				if var_45_13 > 0 and var_45_7 < var_45_13 then
					arg_42_1.talkMaxDuration = var_45_13

					if var_45_13 + var_45_6 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_13 + var_45_6
					end
				end

				arg_42_1.text_.text = var_45_10
				arg_42_1.typewritter.percent = 0

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(false)
				arg_42_1:RecordContent(arg_42_1.text_.text)
			end

			local var_45_14 = math.max(var_45_7, arg_42_1.talkMaxDuration)

			if var_45_6 <= arg_42_1.time_ and arg_42_1.time_ < var_45_6 + var_45_14 then
				arg_42_1.typewritter.percent = (arg_42_1.time_ - var_45_6) / var_45_14

				arg_42_1.typewritter:SetDirty()
			end

			if arg_42_1.time_ >= var_45_6 + var_45_14 and arg_42_1.time_ < var_45_6 + var_45_14 + arg_45_0 then
				arg_42_1.typewritter.percent = 1

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(true)
			end
		end

		arg_42_1.nodeConfigList_ = {}

		arg_42_1:InitPlayNodeList()
	end,
	Play325542011 = function(arg_46_0, arg_46_1)
		arg_46_1.time_ = 0
		arg_46_1.frameCnt_ = 0
		arg_46_1.state_ = "playing"
		arg_46_1.curTalkId_ = 325542011
		arg_46_1.duration_ = 5

		SetActive(arg_46_1.tipsGo_, false)

		function arg_46_1.onSingleLineFinish_()
			arg_46_1.onSingleLineUpdate_ = nil
			arg_46_1.onSingleLineFinish_ = nil
			arg_46_1.state_ = "waiting"
		end

		function arg_46_1.playNext_(arg_48_0)
			if arg_48_0 == 1 then
				arg_46_0:Play325542012(arg_46_1)
			end
		end

		function arg_46_1.onSingleLineUpdate_(arg_49_0)
			local var_49_0 = arg_46_1.actors_["1170ui_story"].transform
			local var_49_1 = 0

			if var_49_1 < arg_46_1.time_ and arg_46_1.time_ <= var_49_1 + arg_49_0 then
				arg_46_1.var_.moveOldPos1170ui_story = var_49_0.localPosition

				local var_49_2 = GameObjectTools.GetOrAddComponent(var_49_0.gameObject, typeof(DynamicBoneHelper))

				if var_49_2 then
					var_49_2:EnableDynamicBone(false)
				end
			end

			local var_49_3 = 0.001

			if var_49_1 <= arg_46_1.time_ and arg_46_1.time_ < var_49_1 + var_49_3 then
				local var_49_4 = (arg_46_1.time_ - var_49_1) / var_49_3
				local var_49_5 = Vector3.New(0, 100, 0)

				var_49_0.localPosition = Vector3.Lerp(arg_46_1.var_.moveOldPos1170ui_story, var_49_5, var_49_4)

				local var_49_6 = manager.ui.mainCamera.transform.position - var_49_0.position

				var_49_0.forward = Vector3.New(var_49_6.x, var_49_6.y, var_49_6.z)

				local var_49_7 = var_49_0.localEulerAngles

				var_49_7.z = 0
				var_49_7.x = 0
				var_49_0.localEulerAngles = var_49_7
			end

			if arg_46_1.time_ >= var_49_1 + var_49_3 and arg_46_1.time_ < var_49_1 + var_49_3 + arg_49_0 then
				var_49_0.localPosition = Vector3.New(0, 100, 0)

				local var_49_8 = manager.ui.mainCamera.transform.position - var_49_0.position

				var_49_0.forward = Vector3.New(var_49_8.x, var_49_8.y, var_49_8.z)

				local var_49_9 = var_49_0.localEulerAngles

				var_49_9.z = 0
				var_49_9.x = 0
				var_49_0.localEulerAngles = var_49_9

				local var_49_10 = GameObjectTools.GetOrAddComponent(var_49_0.gameObject, typeof(DynamicBoneHelper))

				if var_49_10 then
					var_49_10:EnableDynamicBone(true)
				end
			end

			local var_49_11 = 0
			local var_49_12 = 1.3

			if var_49_11 < arg_46_1.time_ and arg_46_1.time_ <= var_49_11 + arg_49_0 then
				arg_46_1.talkMaxDuration = 0
				arg_46_1.dialogCg_.alpha = 1

				arg_46_1.dialog_:SetActive(true)
				SetActive(arg_46_1.leftNameGo_, false)

				arg_46_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_46_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_46_1:RecordName(arg_46_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_46_1.iconTrs_.gameObject, false)
				arg_46_1.callingController_:SetSelectedState("normal")

				local var_49_13 = arg_46_1:GetWordFromCfg(325542011)
				local var_49_14 = arg_46_1:FormatText(var_49_13.content)

				arg_46_1.text_.text = var_49_14

				LuaForUtil.ClearLinePrefixSymbol(arg_46_1.text_)

				local var_49_15 = 52
				local var_49_16 = utf8.len(var_49_14)
				local var_49_17 = var_49_15 <= 0 and var_49_12 or var_49_12 * (var_49_16 / var_49_15)

				if var_49_17 > 0 and var_49_12 < var_49_17 then
					arg_46_1.talkMaxDuration = var_49_17

					if var_49_17 + var_49_11 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_17 + var_49_11
					end
				end

				arg_46_1.text_.text = var_49_14
				arg_46_1.typewritter.percent = 0

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(false)
				arg_46_1:RecordContent(arg_46_1.text_.text)
			end

			local var_49_18 = math.max(var_49_12, arg_46_1.talkMaxDuration)

			if var_49_11 <= arg_46_1.time_ and arg_46_1.time_ < var_49_11 + var_49_18 then
				arg_46_1.typewritter.percent = (arg_46_1.time_ - var_49_11) / var_49_18

				arg_46_1.typewritter:SetDirty()
			end

			if arg_46_1.time_ >= var_49_11 + var_49_18 and arg_46_1.time_ < var_49_11 + var_49_18 + arg_49_0 then
				arg_46_1.typewritter.percent = 1

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(true)
			end
		end

		arg_46_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_46_1:InitPlayNodeList()
	end,
	Play325542012 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 325542012
		arg_50_1.duration_ = 7.9

		SetActive(arg_50_1.tipsGo_, false)

		function arg_50_1.onSingleLineFinish_()
			arg_50_1.onSingleLineUpdate_ = nil
			arg_50_1.onSingleLineFinish_ = nil
			arg_50_1.state_ = "waiting"
		end

		function arg_50_1.playNext_(arg_52_0)
			if arg_52_0 == 1 then
				arg_50_0:Play325542013(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			local var_53_0 = arg_50_1.actors_["1170ui_story"].transform
			local var_53_1 = 0

			if var_53_1 < arg_50_1.time_ and arg_50_1.time_ <= var_53_1 + arg_53_0 then
				arg_50_1.var_.moveOldPos1170ui_story = var_53_0.localPosition

				local var_53_2 = GameObjectTools.GetOrAddComponent(var_53_0.gameObject, typeof(DynamicBoneHelper))

				if var_53_2 then
					var_53_2:EnableDynamicBone(false)
				end
			end

			local var_53_3 = 0.001

			if var_53_1 <= arg_50_1.time_ and arg_50_1.time_ < var_53_1 + var_53_3 then
				local var_53_4 = (arg_50_1.time_ - var_53_1) / var_53_3
				local var_53_5 = Vector3.New(0.03, -0.95, -6.08)

				var_53_0.localPosition = Vector3.Lerp(arg_50_1.var_.moveOldPos1170ui_story, var_53_5, var_53_4)

				local var_53_6 = manager.ui.mainCamera.transform.position - var_53_0.position

				var_53_0.forward = Vector3.New(var_53_6.x, var_53_6.y, var_53_6.z)

				local var_53_7 = var_53_0.localEulerAngles

				var_53_7.z = 0
				var_53_7.x = 0
				var_53_0.localEulerAngles = var_53_7
			end

			if arg_50_1.time_ >= var_53_1 + var_53_3 and arg_50_1.time_ < var_53_1 + var_53_3 + arg_53_0 then
				var_53_0.localPosition = Vector3.New(0.03, -0.95, -6.08)

				local var_53_8 = manager.ui.mainCamera.transform.position - var_53_0.position

				var_53_0.forward = Vector3.New(var_53_8.x, var_53_8.y, var_53_8.z)

				local var_53_9 = var_53_0.localEulerAngles

				var_53_9.z = 0
				var_53_9.x = 0
				var_53_0.localEulerAngles = var_53_9

				local var_53_10 = GameObjectTools.GetOrAddComponent(var_53_0.gameObject, typeof(DynamicBoneHelper))

				if var_53_10 then
					var_53_10:EnableDynamicBone(true)
				end
			end

			local var_53_11 = arg_50_1.actors_["1170ui_story"]
			local var_53_12 = 0

			if var_53_12 < arg_50_1.time_ and arg_50_1.time_ <= var_53_12 + arg_53_0 and not isNil(var_53_11) and arg_50_1.var_.characterEffect1170ui_story == nil then
				arg_50_1.var_.characterEffect1170ui_story = var_53_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_53_13 = 0.200000002980232

			if var_53_12 <= arg_50_1.time_ and arg_50_1.time_ < var_53_12 + var_53_13 and not isNil(var_53_11) then
				local var_53_14 = (arg_50_1.time_ - var_53_12) / var_53_13

				if arg_50_1.var_.characterEffect1170ui_story and not isNil(var_53_11) then
					arg_50_1.var_.characterEffect1170ui_story.fillFlat = false
				end
			end

			if arg_50_1.time_ >= var_53_12 + var_53_13 and arg_50_1.time_ < var_53_12 + var_53_13 + arg_53_0 and not isNil(var_53_11) and arg_50_1.var_.characterEffect1170ui_story then
				arg_50_1.var_.characterEffect1170ui_story.fillFlat = false
			end

			local var_53_15 = 0

			if var_53_15 < arg_50_1.time_ and arg_50_1.time_ <= var_53_15 + arg_53_0 then
				arg_50_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/story1170/story1170action/1170action3_1")
			end

			local var_53_16 = 0

			if var_53_16 < arg_50_1.time_ and arg_50_1.time_ <= var_53_16 + arg_53_0 then
				arg_50_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_53_17 = 0
			local var_53_18 = 0.8

			if var_53_17 < arg_50_1.time_ and arg_50_1.time_ <= var_53_17 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0
				arg_50_1.dialogCg_.alpha = 1

				arg_50_1.dialog_:SetActive(true)
				SetActive(arg_50_1.leftNameGo_, true)

				local var_53_19 = arg_50_1:FormatText(StoryNameCfg[318].name)

				arg_50_1.leftNameTxt_.text = var_53_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_50_1.leftNameTxt_.transform)

				arg_50_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_50_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_50_1:RecordName(arg_50_1.leftNameTxt_.text)
				SetActive(arg_50_1.iconTrs_.gameObject, false)
				arg_50_1.callingController_:SetSelectedState("normal")

				local var_53_20 = arg_50_1:GetWordFromCfg(325542012)
				local var_53_21 = arg_50_1:FormatText(var_53_20.content)

				arg_50_1.text_.text = var_53_21

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_22 = 32
				local var_53_23 = utf8.len(var_53_21)
				local var_53_24 = var_53_22 <= 0 and var_53_18 or var_53_18 * (var_53_23 / var_53_22)

				if var_53_24 > 0 and var_53_18 < var_53_24 then
					arg_50_1.talkMaxDuration = var_53_24

					if var_53_24 + var_53_17 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_24 + var_53_17
					end
				end

				arg_50_1.text_.text = var_53_21
				arg_50_1.typewritter.percent = 0

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325542", "325542012", "story_v_out_325542.awb") ~= 0 then
					local var_53_25 = manager.audio:GetVoiceLength("story_v_out_325542", "325542012", "story_v_out_325542.awb") / 1000

					if var_53_25 + var_53_17 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_25 + var_53_17
					end

					if var_53_20.prefab_name ~= "" and arg_50_1.actors_[var_53_20.prefab_name] ~= nil then
						local var_53_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_50_1.actors_[var_53_20.prefab_name].transform, "story_v_out_325542", "325542012", "story_v_out_325542.awb")

						arg_50_1:RecordAudio("325542012", var_53_26)
						arg_50_1:RecordAudio("325542012", var_53_26)
					else
						arg_50_1:AudioAction("play", "voice", "story_v_out_325542", "325542012", "story_v_out_325542.awb")
					end

					arg_50_1:RecordHistoryTalkVoice("story_v_out_325542", "325542012", "story_v_out_325542.awb")
				end

				arg_50_1:RecordContent(arg_50_1.text_.text)
			end

			local var_53_27 = math.max(var_53_18, arg_50_1.talkMaxDuration)

			if var_53_17 <= arg_50_1.time_ and arg_50_1.time_ < var_53_17 + var_53_27 then
				arg_50_1.typewritter.percent = (arg_50_1.time_ - var_53_17) / var_53_27

				arg_50_1.typewritter:SetDirty()
			end

			if arg_50_1.time_ >= var_53_17 + var_53_27 and arg_50_1.time_ < var_53_17 + var_53_27 + arg_53_0 then
				arg_50_1.typewritter.percent = 1

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(true)
			end
		end

		arg_50_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_50_1:InitPlayNodeList()
	end,
	Play325542013 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 325542013
		arg_54_1.duration_ = 5.83

		SetActive(arg_54_1.tipsGo_, false)

		function arg_54_1.onSingleLineFinish_()
			arg_54_1.onSingleLineUpdate_ = nil
			arg_54_1.onSingleLineFinish_ = nil
			arg_54_1.state_ = "waiting"
		end

		function arg_54_1.playNext_(arg_56_0)
			if arg_56_0 == 1 then
				arg_54_0:Play325542014(arg_54_1)
			end
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			local var_57_0 = 0
			local var_57_1 = 0.775

			if var_57_0 < arg_54_1.time_ and arg_54_1.time_ <= var_57_0 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0
				arg_54_1.dialogCg_.alpha = 1

				arg_54_1.dialog_:SetActive(true)
				SetActive(arg_54_1.leftNameGo_, true)

				local var_57_2 = arg_54_1:FormatText(StoryNameCfg[318].name)

				arg_54_1.leftNameTxt_.text = var_57_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_54_1.leftNameTxt_.transform)

				arg_54_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_54_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_54_1:RecordName(arg_54_1.leftNameTxt_.text)
				SetActive(arg_54_1.iconTrs_.gameObject, false)
				arg_54_1.callingController_:SetSelectedState("normal")

				local var_57_3 = arg_54_1:GetWordFromCfg(325542013)
				local var_57_4 = arg_54_1:FormatText(var_57_3.content)

				arg_54_1.text_.text = var_57_4

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_5 = 31
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

				if manager.audio:GetVoiceLength("story_v_out_325542", "325542013", "story_v_out_325542.awb") ~= 0 then
					local var_57_8 = manager.audio:GetVoiceLength("story_v_out_325542", "325542013", "story_v_out_325542.awb") / 1000

					if var_57_8 + var_57_0 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_8 + var_57_0
					end

					if var_57_3.prefab_name ~= "" and arg_54_1.actors_[var_57_3.prefab_name] ~= nil then
						local var_57_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_54_1.actors_[var_57_3.prefab_name].transform, "story_v_out_325542", "325542013", "story_v_out_325542.awb")

						arg_54_1:RecordAudio("325542013", var_57_9)
						arg_54_1:RecordAudio("325542013", var_57_9)
					else
						arg_54_1:AudioAction("play", "voice", "story_v_out_325542", "325542013", "story_v_out_325542.awb")
					end

					arg_54_1:RecordHistoryTalkVoice("story_v_out_325542", "325542013", "story_v_out_325542.awb")
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
	Play325542014 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 325542014
		arg_58_1.duration_ = 5

		SetActive(arg_58_1.tipsGo_, false)

		function arg_58_1.onSingleLineFinish_()
			arg_58_1.onSingleLineUpdate_ = nil
			arg_58_1.onSingleLineFinish_ = nil
			arg_58_1.state_ = "waiting"
		end

		function arg_58_1.playNext_(arg_60_0)
			if arg_60_0 == 1 then
				arg_58_0:Play325542015(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			local var_61_0 = arg_58_1.actors_["1170ui_story"]
			local var_61_1 = 0

			if var_61_1 < arg_58_1.time_ and arg_58_1.time_ <= var_61_1 + arg_61_0 and not isNil(var_61_0) and arg_58_1.var_.characterEffect1170ui_story == nil then
				arg_58_1.var_.characterEffect1170ui_story = var_61_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_61_2 = 0.200000002980232

			if var_61_1 <= arg_58_1.time_ and arg_58_1.time_ < var_61_1 + var_61_2 and not isNil(var_61_0) then
				local var_61_3 = (arg_58_1.time_ - var_61_1) / var_61_2

				if arg_58_1.var_.characterEffect1170ui_story and not isNil(var_61_0) then
					local var_61_4 = Mathf.Lerp(0, 0.5, var_61_3)

					arg_58_1.var_.characterEffect1170ui_story.fillFlat = true
					arg_58_1.var_.characterEffect1170ui_story.fillRatio = var_61_4
				end
			end

			if arg_58_1.time_ >= var_61_1 + var_61_2 and arg_58_1.time_ < var_61_1 + var_61_2 + arg_61_0 and not isNil(var_61_0) and arg_58_1.var_.characterEffect1170ui_story then
				local var_61_5 = 0.5

				arg_58_1.var_.characterEffect1170ui_story.fillFlat = true
				arg_58_1.var_.characterEffect1170ui_story.fillRatio = var_61_5
			end

			local var_61_6 = 0
			local var_61_7 = 0.525

			if var_61_6 < arg_58_1.time_ and arg_58_1.time_ <= var_61_6 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0
				arg_58_1.dialogCg_.alpha = 1

				arg_58_1.dialog_:SetActive(true)
				SetActive(arg_58_1.leftNameGo_, true)

				local var_61_8 = arg_58_1:FormatText(StoryNameCfg[7].name)

				arg_58_1.leftNameTxt_.text = var_61_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_58_1.leftNameTxt_.transform)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1.leftNameTxt_.text)
				SetActive(arg_58_1.iconTrs_.gameObject, true)
				arg_58_1.iconController_:SetSelectedState("hero")

				arg_58_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_58_1.callingController_:SetSelectedState("normal")

				arg_58_1.keyicon_.color = Color.New(1, 1, 1)
				arg_58_1.icon_.color = Color.New(1, 1, 1)

				local var_61_9 = arg_58_1:GetWordFromCfg(325542014)
				local var_61_10 = arg_58_1:FormatText(var_61_9.content)

				arg_58_1.text_.text = var_61_10

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_11 = 21
				local var_61_12 = utf8.len(var_61_10)
				local var_61_13 = var_61_11 <= 0 and var_61_7 or var_61_7 * (var_61_12 / var_61_11)

				if var_61_13 > 0 and var_61_7 < var_61_13 then
					arg_58_1.talkMaxDuration = var_61_13

					if var_61_13 + var_61_6 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_13 + var_61_6
					end
				end

				arg_58_1.text_.text = var_61_10
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)
				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_14 = math.max(var_61_7, arg_58_1.talkMaxDuration)

			if var_61_6 <= arg_58_1.time_ and arg_58_1.time_ < var_61_6 + var_61_14 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - var_61_6) / var_61_14

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= var_61_6 + var_61_14 and arg_58_1.time_ < var_61_6 + var_61_14 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {}

		arg_58_1:InitPlayNodeList()
	end,
	Play325542015 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 325542015
		arg_62_1.duration_ = 5

		SetActive(arg_62_1.tipsGo_, false)

		function arg_62_1.onSingleLineFinish_()
			arg_62_1.onSingleLineUpdate_ = nil
			arg_62_1.onSingleLineFinish_ = nil
			arg_62_1.state_ = "waiting"
		end

		function arg_62_1.playNext_(arg_64_0)
			if arg_64_0 == 1 then
				arg_62_0:Play325542016(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			local var_65_0 = 0
			local var_65_1 = 0.8

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

				arg_62_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_62_1.callingController_:SetSelectedState("normal")

				arg_62_1.keyicon_.color = Color.New(1, 1, 1)
				arg_62_1.icon_.color = Color.New(1, 1, 1)

				local var_65_3 = arg_62_1:GetWordFromCfg(325542015)
				local var_65_4 = arg_62_1:FormatText(var_65_3.content)

				arg_62_1.text_.text = var_65_4

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_5 = 32
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
	Play325542016 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 325542016
		arg_66_1.duration_ = 8.83

		SetActive(arg_66_1.tipsGo_, false)

		function arg_66_1.onSingleLineFinish_()
			arg_66_1.onSingleLineUpdate_ = nil
			arg_66_1.onSingleLineFinish_ = nil
			arg_66_1.state_ = "waiting"
		end

		function arg_66_1.playNext_(arg_68_0)
			if arg_68_0 == 1 then
				arg_66_0:Play325542017(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			local var_69_0 = arg_66_1.actors_["1170ui_story"]
			local var_69_1 = 0

			if var_69_1 < arg_66_1.time_ and arg_66_1.time_ <= var_69_1 + arg_69_0 and not isNil(var_69_0) and arg_66_1.var_.characterEffect1170ui_story == nil then
				arg_66_1.var_.characterEffect1170ui_story = var_69_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_69_2 = 0.200000002980232

			if var_69_1 <= arg_66_1.time_ and arg_66_1.time_ < var_69_1 + var_69_2 and not isNil(var_69_0) then
				local var_69_3 = (arg_66_1.time_ - var_69_1) / var_69_2

				if arg_66_1.var_.characterEffect1170ui_story and not isNil(var_69_0) then
					arg_66_1.var_.characterEffect1170ui_story.fillFlat = false
				end
			end

			if arg_66_1.time_ >= var_69_1 + var_69_2 and arg_66_1.time_ < var_69_1 + var_69_2 + arg_69_0 and not isNil(var_69_0) and arg_66_1.var_.characterEffect1170ui_story then
				arg_66_1.var_.characterEffect1170ui_story.fillFlat = false
			end

			local var_69_4 = 0

			if var_69_4 < arg_66_1.time_ and arg_66_1.time_ <= var_69_4 + arg_69_0 then
				arg_66_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/story1170/story1170action/1170action3_2")
			end

			local var_69_5 = 0

			if var_69_5 < arg_66_1.time_ and arg_66_1.time_ <= var_69_5 + arg_69_0 then
				arg_66_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_69_6 = 0
			local var_69_7 = 0.95

			if var_69_6 < arg_66_1.time_ and arg_66_1.time_ <= var_69_6 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, true)

				local var_69_8 = arg_66_1:FormatText(StoryNameCfg[318].name)

				arg_66_1.leftNameTxt_.text = var_69_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_66_1.leftNameTxt_.transform)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1.leftNameTxt_.text)
				SetActive(arg_66_1.iconTrs_.gameObject, false)
				arg_66_1.callingController_:SetSelectedState("normal")

				local var_69_9 = arg_66_1:GetWordFromCfg(325542016)
				local var_69_10 = arg_66_1:FormatText(var_69_9.content)

				arg_66_1.text_.text = var_69_10

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_11 = 38
				local var_69_12 = utf8.len(var_69_10)
				local var_69_13 = var_69_11 <= 0 and var_69_7 or var_69_7 * (var_69_12 / var_69_11)

				if var_69_13 > 0 and var_69_7 < var_69_13 then
					arg_66_1.talkMaxDuration = var_69_13

					if var_69_13 + var_69_6 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_13 + var_69_6
					end
				end

				arg_66_1.text_.text = var_69_10
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325542", "325542016", "story_v_out_325542.awb") ~= 0 then
					local var_69_14 = manager.audio:GetVoiceLength("story_v_out_325542", "325542016", "story_v_out_325542.awb") / 1000

					if var_69_14 + var_69_6 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_14 + var_69_6
					end

					if var_69_9.prefab_name ~= "" and arg_66_1.actors_[var_69_9.prefab_name] ~= nil then
						local var_69_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_66_1.actors_[var_69_9.prefab_name].transform, "story_v_out_325542", "325542016", "story_v_out_325542.awb")

						arg_66_1:RecordAudio("325542016", var_69_15)
						arg_66_1:RecordAudio("325542016", var_69_15)
					else
						arg_66_1:AudioAction("play", "voice", "story_v_out_325542", "325542016", "story_v_out_325542.awb")
					end

					arg_66_1:RecordHistoryTalkVoice("story_v_out_325542", "325542016", "story_v_out_325542.awb")
				end

				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_16 = math.max(var_69_7, arg_66_1.talkMaxDuration)

			if var_69_6 <= arg_66_1.time_ and arg_66_1.time_ < var_69_6 + var_69_16 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - var_69_6) / var_69_16

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= var_69_6 + var_69_16 and arg_66_1.time_ < var_69_6 + var_69_16 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {}

		arg_66_1:InitPlayNodeList()
	end,
	Play325542017 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 325542017
		arg_70_1.duration_ = 13

		SetActive(arg_70_1.tipsGo_, false)

		function arg_70_1.onSingleLineFinish_()
			arg_70_1.onSingleLineUpdate_ = nil
			arg_70_1.onSingleLineFinish_ = nil
			arg_70_1.state_ = "waiting"
		end

		function arg_70_1.playNext_(arg_72_0)
			if arg_72_0 == 1 then
				arg_70_0:Play325542018(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			local var_73_0 = 0
			local var_73_1 = 1.425

			if var_73_0 < arg_70_1.time_ and arg_70_1.time_ <= var_73_0 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, true)

				local var_73_2 = arg_70_1:FormatText(StoryNameCfg[318].name)

				arg_70_1.leftNameTxt_.text = var_73_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_70_1.leftNameTxt_.transform)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1.leftNameTxt_.text)
				SetActive(arg_70_1.iconTrs_.gameObject, false)
				arg_70_1.callingController_:SetSelectedState("normal")

				local var_73_3 = arg_70_1:GetWordFromCfg(325542017)
				local var_73_4 = arg_70_1:FormatText(var_73_3.content)

				arg_70_1.text_.text = var_73_4

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_5 = 57
				local var_73_6 = utf8.len(var_73_4)
				local var_73_7 = var_73_5 <= 0 and var_73_1 or var_73_1 * (var_73_6 / var_73_5)

				if var_73_7 > 0 and var_73_1 < var_73_7 then
					arg_70_1.talkMaxDuration = var_73_7

					if var_73_7 + var_73_0 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_7 + var_73_0
					end
				end

				arg_70_1.text_.text = var_73_4
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325542", "325542017", "story_v_out_325542.awb") ~= 0 then
					local var_73_8 = manager.audio:GetVoiceLength("story_v_out_325542", "325542017", "story_v_out_325542.awb") / 1000

					if var_73_8 + var_73_0 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_8 + var_73_0
					end

					if var_73_3.prefab_name ~= "" and arg_70_1.actors_[var_73_3.prefab_name] ~= nil then
						local var_73_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_70_1.actors_[var_73_3.prefab_name].transform, "story_v_out_325542", "325542017", "story_v_out_325542.awb")

						arg_70_1:RecordAudio("325542017", var_73_9)
						arg_70_1:RecordAudio("325542017", var_73_9)
					else
						arg_70_1:AudioAction("play", "voice", "story_v_out_325542", "325542017", "story_v_out_325542.awb")
					end

					arg_70_1:RecordHistoryTalkVoice("story_v_out_325542", "325542017", "story_v_out_325542.awb")
				end

				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_10 = math.max(var_73_1, arg_70_1.talkMaxDuration)

			if var_73_0 <= arg_70_1.time_ and arg_70_1.time_ < var_73_0 + var_73_10 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_0) / var_73_10

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_0 + var_73_10 and arg_70_1.time_ < var_73_0 + var_73_10 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {}

		arg_70_1:InitPlayNodeList()
	end,
	Play325542018 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 325542018
		arg_74_1.duration_ = 7.2

		SetActive(arg_74_1.tipsGo_, false)

		function arg_74_1.onSingleLineFinish_()
			arg_74_1.onSingleLineUpdate_ = nil
			arg_74_1.onSingleLineFinish_ = nil
			arg_74_1.state_ = "waiting"
		end

		function arg_74_1.playNext_(arg_76_0)
			if arg_76_0 == 1 then
				arg_74_0:Play325542019(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			local var_77_0 = 0
			local var_77_1 = 0.6

			if var_77_0 < arg_74_1.time_ and arg_74_1.time_ <= var_77_0 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, true)

				local var_77_2 = arg_74_1:FormatText(StoryNameCfg[318].name)

				arg_74_1.leftNameTxt_.text = var_77_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_74_1.leftNameTxt_.transform)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1.leftNameTxt_.text)
				SetActive(arg_74_1.iconTrs_.gameObject, false)
				arg_74_1.callingController_:SetSelectedState("normal")

				local var_77_3 = arg_74_1:GetWordFromCfg(325542018)
				local var_77_4 = arg_74_1:FormatText(var_77_3.content)

				arg_74_1.text_.text = var_77_4

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_5 = 24
				local var_77_6 = utf8.len(var_77_4)
				local var_77_7 = var_77_5 <= 0 and var_77_1 or var_77_1 * (var_77_6 / var_77_5)

				if var_77_7 > 0 and var_77_1 < var_77_7 then
					arg_74_1.talkMaxDuration = var_77_7

					if var_77_7 + var_77_0 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_7 + var_77_0
					end
				end

				arg_74_1.text_.text = var_77_4
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325542", "325542018", "story_v_out_325542.awb") ~= 0 then
					local var_77_8 = manager.audio:GetVoiceLength("story_v_out_325542", "325542018", "story_v_out_325542.awb") / 1000

					if var_77_8 + var_77_0 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_8 + var_77_0
					end

					if var_77_3.prefab_name ~= "" and arg_74_1.actors_[var_77_3.prefab_name] ~= nil then
						local var_77_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_74_1.actors_[var_77_3.prefab_name].transform, "story_v_out_325542", "325542018", "story_v_out_325542.awb")

						arg_74_1:RecordAudio("325542018", var_77_9)
						arg_74_1:RecordAudio("325542018", var_77_9)
					else
						arg_74_1:AudioAction("play", "voice", "story_v_out_325542", "325542018", "story_v_out_325542.awb")
					end

					arg_74_1:RecordHistoryTalkVoice("story_v_out_325542", "325542018", "story_v_out_325542.awb")
				end

				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_10 = math.max(var_77_1, arg_74_1.talkMaxDuration)

			if var_77_0 <= arg_74_1.time_ and arg_74_1.time_ < var_77_0 + var_77_10 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - var_77_0) / var_77_10

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= var_77_0 + var_77_10 and arg_74_1.time_ < var_77_0 + var_77_10 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {}

		arg_74_1:InitPlayNodeList()
	end,
	Play325542019 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 325542019
		arg_78_1.duration_ = 5

		SetActive(arg_78_1.tipsGo_, false)

		function arg_78_1.onSingleLineFinish_()
			arg_78_1.onSingleLineUpdate_ = nil
			arg_78_1.onSingleLineFinish_ = nil
			arg_78_1.state_ = "waiting"
		end

		function arg_78_1.playNext_(arg_80_0)
			if arg_80_0 == 1 then
				arg_78_0:Play325542020(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			local var_81_0 = arg_78_1.actors_["1170ui_story"]
			local var_81_1 = 0

			if var_81_1 < arg_78_1.time_ and arg_78_1.time_ <= var_81_1 + arg_81_0 and not isNil(var_81_0) and arg_78_1.var_.characterEffect1170ui_story == nil then
				arg_78_1.var_.characterEffect1170ui_story = var_81_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_81_2 = 0.200000002980232

			if var_81_1 <= arg_78_1.time_ and arg_78_1.time_ < var_81_1 + var_81_2 and not isNil(var_81_0) then
				local var_81_3 = (arg_78_1.time_ - var_81_1) / var_81_2

				if arg_78_1.var_.characterEffect1170ui_story and not isNil(var_81_0) then
					local var_81_4 = Mathf.Lerp(0, 0.5, var_81_3)

					arg_78_1.var_.characterEffect1170ui_story.fillFlat = true
					arg_78_1.var_.characterEffect1170ui_story.fillRatio = var_81_4
				end
			end

			if arg_78_1.time_ >= var_81_1 + var_81_2 and arg_78_1.time_ < var_81_1 + var_81_2 + arg_81_0 and not isNil(var_81_0) and arg_78_1.var_.characterEffect1170ui_story then
				local var_81_5 = 0.5

				arg_78_1.var_.characterEffect1170ui_story.fillFlat = true
				arg_78_1.var_.characterEffect1170ui_story.fillRatio = var_81_5
			end

			local var_81_6 = 0
			local var_81_7 = 0.325

			if var_81_6 < arg_78_1.time_ and arg_78_1.time_ <= var_81_6 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, true)

				local var_81_8 = arg_78_1:FormatText(StoryNameCfg[7].name)

				arg_78_1.leftNameTxt_.text = var_81_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_78_1.leftNameTxt_.transform)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1.leftNameTxt_.text)
				SetActive(arg_78_1.iconTrs_.gameObject, true)
				arg_78_1.iconController_:SetSelectedState("hero")

				arg_78_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_78_1.callingController_:SetSelectedState("normal")

				arg_78_1.keyicon_.color = Color.New(1, 1, 1)
				arg_78_1.icon_.color = Color.New(1, 1, 1)

				local var_81_9 = arg_78_1:GetWordFromCfg(325542019)
				local var_81_10 = arg_78_1:FormatText(var_81_9.content)

				arg_78_1.text_.text = var_81_10

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_11 = 13
				local var_81_12 = utf8.len(var_81_10)
				local var_81_13 = var_81_11 <= 0 and var_81_7 or var_81_7 * (var_81_12 / var_81_11)

				if var_81_13 > 0 and var_81_7 < var_81_13 then
					arg_78_1.talkMaxDuration = var_81_13

					if var_81_13 + var_81_6 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_13 + var_81_6
					end
				end

				arg_78_1.text_.text = var_81_10
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)
				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_14 = math.max(var_81_7, arg_78_1.talkMaxDuration)

			if var_81_6 <= arg_78_1.time_ and arg_78_1.time_ < var_81_6 + var_81_14 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - var_81_6) / var_81_14

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= var_81_6 + var_81_14 and arg_78_1.time_ < var_81_6 + var_81_14 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {}

		arg_78_1:InitPlayNodeList()
	end,
	Play325542020 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 325542020
		arg_82_1.duration_ = 4.53

		SetActive(arg_82_1.tipsGo_, false)

		function arg_82_1.onSingleLineFinish_()
			arg_82_1.onSingleLineUpdate_ = nil
			arg_82_1.onSingleLineFinish_ = nil
			arg_82_1.state_ = "waiting"
		end

		function arg_82_1.playNext_(arg_84_0)
			if arg_84_0 == 1 then
				arg_82_0:Play325542021(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			local var_85_0 = arg_82_1.actors_["1170ui_story"]
			local var_85_1 = 0

			if var_85_1 < arg_82_1.time_ and arg_82_1.time_ <= var_85_1 + arg_85_0 and not isNil(var_85_0) and arg_82_1.var_.characterEffect1170ui_story == nil then
				arg_82_1.var_.characterEffect1170ui_story = var_85_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_85_2 = 0.200000002980232

			if var_85_1 <= arg_82_1.time_ and arg_82_1.time_ < var_85_1 + var_85_2 and not isNil(var_85_0) then
				local var_85_3 = (arg_82_1.time_ - var_85_1) / var_85_2

				if arg_82_1.var_.characterEffect1170ui_story and not isNil(var_85_0) then
					arg_82_1.var_.characterEffect1170ui_story.fillFlat = false
				end
			end

			if arg_82_1.time_ >= var_85_1 + var_85_2 and arg_82_1.time_ < var_85_1 + var_85_2 + arg_85_0 and not isNil(var_85_0) and arg_82_1.var_.characterEffect1170ui_story then
				arg_82_1.var_.characterEffect1170ui_story.fillFlat = false
			end

			local var_85_4 = 0
			local var_85_5 = 0.425

			if var_85_4 < arg_82_1.time_ and arg_82_1.time_ <= var_85_4 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, true)

				local var_85_6 = arg_82_1:FormatText(StoryNameCfg[318].name)

				arg_82_1.leftNameTxt_.text = var_85_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_82_1.leftNameTxt_.transform)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1.leftNameTxt_.text)
				SetActive(arg_82_1.iconTrs_.gameObject, false)
				arg_82_1.callingController_:SetSelectedState("normal")

				local var_85_7 = arg_82_1:GetWordFromCfg(325542020)
				local var_85_8 = arg_82_1:FormatText(var_85_7.content)

				arg_82_1.text_.text = var_85_8

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_9 = 17
				local var_85_10 = utf8.len(var_85_8)
				local var_85_11 = var_85_9 <= 0 and var_85_5 or var_85_5 * (var_85_10 / var_85_9)

				if var_85_11 > 0 and var_85_5 < var_85_11 then
					arg_82_1.talkMaxDuration = var_85_11

					if var_85_11 + var_85_4 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_11 + var_85_4
					end
				end

				arg_82_1.text_.text = var_85_8
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325542", "325542020", "story_v_out_325542.awb") ~= 0 then
					local var_85_12 = manager.audio:GetVoiceLength("story_v_out_325542", "325542020", "story_v_out_325542.awb") / 1000

					if var_85_12 + var_85_4 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_12 + var_85_4
					end

					if var_85_7.prefab_name ~= "" and arg_82_1.actors_[var_85_7.prefab_name] ~= nil then
						local var_85_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_82_1.actors_[var_85_7.prefab_name].transform, "story_v_out_325542", "325542020", "story_v_out_325542.awb")

						arg_82_1:RecordAudio("325542020", var_85_13)
						arg_82_1:RecordAudio("325542020", var_85_13)
					else
						arg_82_1:AudioAction("play", "voice", "story_v_out_325542", "325542020", "story_v_out_325542.awb")
					end

					arg_82_1:RecordHistoryTalkVoice("story_v_out_325542", "325542020", "story_v_out_325542.awb")
				end

				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_14 = math.max(var_85_5, arg_82_1.talkMaxDuration)

			if var_85_4 <= arg_82_1.time_ and arg_82_1.time_ < var_85_4 + var_85_14 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - var_85_4) / var_85_14

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= var_85_4 + var_85_14 and arg_82_1.time_ < var_85_4 + var_85_14 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {}

		arg_82_1:InitPlayNodeList()
	end,
	Play325542021 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 325542021
		arg_86_1.duration_ = 5

		SetActive(arg_86_1.tipsGo_, false)

		function arg_86_1.onSingleLineFinish_()
			arg_86_1.onSingleLineUpdate_ = nil
			arg_86_1.onSingleLineFinish_ = nil
			arg_86_1.state_ = "waiting"
		end

		function arg_86_1.playNext_(arg_88_0)
			if arg_88_0 == 1 then
				arg_86_0:Play325542022(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			local var_89_0 = arg_86_1.actors_["1170ui_story"]
			local var_89_1 = 0

			if var_89_1 < arg_86_1.time_ and arg_86_1.time_ <= var_89_1 + arg_89_0 and not isNil(var_89_0) and arg_86_1.var_.characterEffect1170ui_story == nil then
				arg_86_1.var_.characterEffect1170ui_story = var_89_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_89_2 = 0.200000002980232

			if var_89_1 <= arg_86_1.time_ and arg_86_1.time_ < var_89_1 + var_89_2 and not isNil(var_89_0) then
				local var_89_3 = (arg_86_1.time_ - var_89_1) / var_89_2

				if arg_86_1.var_.characterEffect1170ui_story and not isNil(var_89_0) then
					local var_89_4 = Mathf.Lerp(0, 0.5, var_89_3)

					arg_86_1.var_.characterEffect1170ui_story.fillFlat = true
					arg_86_1.var_.characterEffect1170ui_story.fillRatio = var_89_4
				end
			end

			if arg_86_1.time_ >= var_89_1 + var_89_2 and arg_86_1.time_ < var_89_1 + var_89_2 + arg_89_0 and not isNil(var_89_0) and arg_86_1.var_.characterEffect1170ui_story then
				local var_89_5 = 0.5

				arg_86_1.var_.characterEffect1170ui_story.fillFlat = true
				arg_86_1.var_.characterEffect1170ui_story.fillRatio = var_89_5
			end

			local var_89_6 = 0
			local var_89_7 = 0.5

			if var_89_6 < arg_86_1.time_ and arg_86_1.time_ <= var_89_6 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, true)

				local var_89_8 = arg_86_1:FormatText(StoryNameCfg[7].name)

				arg_86_1.leftNameTxt_.text = var_89_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_86_1.leftNameTxt_.transform)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1.leftNameTxt_.text)
				SetActive(arg_86_1.iconTrs_.gameObject, true)
				arg_86_1.iconController_:SetSelectedState("hero")

				arg_86_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_86_1.callingController_:SetSelectedState("normal")

				arg_86_1.keyicon_.color = Color.New(1, 1, 1)
				arg_86_1.icon_.color = Color.New(1, 1, 1)

				local var_89_9 = arg_86_1:GetWordFromCfg(325542021)
				local var_89_10 = arg_86_1:FormatText(var_89_9.content)

				arg_86_1.text_.text = var_89_10

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_11 = 20
				local var_89_12 = utf8.len(var_89_10)
				local var_89_13 = var_89_11 <= 0 and var_89_7 or var_89_7 * (var_89_12 / var_89_11)

				if var_89_13 > 0 and var_89_7 < var_89_13 then
					arg_86_1.talkMaxDuration = var_89_13

					if var_89_13 + var_89_6 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_13 + var_89_6
					end
				end

				arg_86_1.text_.text = var_89_10
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)
				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_14 = math.max(var_89_7, arg_86_1.talkMaxDuration)

			if var_89_6 <= arg_86_1.time_ and arg_86_1.time_ < var_89_6 + var_89_14 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_6) / var_89_14

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_6 + var_89_14 and arg_86_1.time_ < var_89_6 + var_89_14 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {}

		arg_86_1:InitPlayNodeList()
	end,
	Play325542022 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 325542022
		arg_90_1.duration_ = 8.47

		SetActive(arg_90_1.tipsGo_, false)

		function arg_90_1.onSingleLineFinish_()
			arg_90_1.onSingleLineUpdate_ = nil
			arg_90_1.onSingleLineFinish_ = nil
			arg_90_1.state_ = "waiting"
		end

		function arg_90_1.playNext_(arg_92_0)
			if arg_92_0 == 1 then
				arg_90_0:Play325542023(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			local var_93_0 = arg_90_1.actors_["1170ui_story"]
			local var_93_1 = 0

			if var_93_1 < arg_90_1.time_ and arg_90_1.time_ <= var_93_1 + arg_93_0 and not isNil(var_93_0) and arg_90_1.var_.characterEffect1170ui_story == nil then
				arg_90_1.var_.characterEffect1170ui_story = var_93_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_93_2 = 0.200000002980232

			if var_93_1 <= arg_90_1.time_ and arg_90_1.time_ < var_93_1 + var_93_2 and not isNil(var_93_0) then
				local var_93_3 = (arg_90_1.time_ - var_93_1) / var_93_2

				if arg_90_1.var_.characterEffect1170ui_story and not isNil(var_93_0) then
					arg_90_1.var_.characterEffect1170ui_story.fillFlat = false
				end
			end

			if arg_90_1.time_ >= var_93_1 + var_93_2 and arg_90_1.time_ < var_93_1 + var_93_2 + arg_93_0 and not isNil(var_93_0) and arg_90_1.var_.characterEffect1170ui_story then
				arg_90_1.var_.characterEffect1170ui_story.fillFlat = false
			end

			local var_93_4 = 0

			if var_93_4 < arg_90_1.time_ and arg_90_1.time_ <= var_93_4 + arg_93_0 then
				arg_90_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/story1170/story1170action/1170action4_1")
			end

			local var_93_5 = 0

			if var_93_5 < arg_90_1.time_ and arg_90_1.time_ <= var_93_5 + arg_93_0 then
				arg_90_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_93_6 = 0
			local var_93_7 = 1.075

			if var_93_6 < arg_90_1.time_ and arg_90_1.time_ <= var_93_6 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				local var_93_8 = arg_90_1:FormatText(StoryNameCfg[318].name)

				arg_90_1.leftNameTxt_.text = var_93_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, false)
				arg_90_1.callingController_:SetSelectedState("normal")

				local var_93_9 = arg_90_1:GetWordFromCfg(325542022)
				local var_93_10 = arg_90_1:FormatText(var_93_9.content)

				arg_90_1.text_.text = var_93_10

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_11 = 43
				local var_93_12 = utf8.len(var_93_10)
				local var_93_13 = var_93_11 <= 0 and var_93_7 or var_93_7 * (var_93_12 / var_93_11)

				if var_93_13 > 0 and var_93_7 < var_93_13 then
					arg_90_1.talkMaxDuration = var_93_13

					if var_93_13 + var_93_6 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_13 + var_93_6
					end
				end

				arg_90_1.text_.text = var_93_10
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325542", "325542022", "story_v_out_325542.awb") ~= 0 then
					local var_93_14 = manager.audio:GetVoiceLength("story_v_out_325542", "325542022", "story_v_out_325542.awb") / 1000

					if var_93_14 + var_93_6 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_14 + var_93_6
					end

					if var_93_9.prefab_name ~= "" and arg_90_1.actors_[var_93_9.prefab_name] ~= nil then
						local var_93_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_90_1.actors_[var_93_9.prefab_name].transform, "story_v_out_325542", "325542022", "story_v_out_325542.awb")

						arg_90_1:RecordAudio("325542022", var_93_15)
						arg_90_1:RecordAudio("325542022", var_93_15)
					else
						arg_90_1:AudioAction("play", "voice", "story_v_out_325542", "325542022", "story_v_out_325542.awb")
					end

					arg_90_1:RecordHistoryTalkVoice("story_v_out_325542", "325542022", "story_v_out_325542.awb")
				end

				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_16 = math.max(var_93_7, arg_90_1.talkMaxDuration)

			if var_93_6 <= arg_90_1.time_ and arg_90_1.time_ < var_93_6 + var_93_16 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_6) / var_93_16

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_6 + var_93_16 and arg_90_1.time_ < var_93_6 + var_93_16 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {}

		arg_90_1:InitPlayNodeList()
	end,
	Play325542023 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 325542023
		arg_94_1.duration_ = 5.57

		SetActive(arg_94_1.tipsGo_, false)

		function arg_94_1.onSingleLineFinish_()
			arg_94_1.onSingleLineUpdate_ = nil
			arg_94_1.onSingleLineFinish_ = nil
			arg_94_1.state_ = "waiting"
		end

		function arg_94_1.playNext_(arg_96_0)
			if arg_96_0 == 1 then
				arg_94_0:Play325542024(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			local var_97_0 = 0
			local var_97_1 = 0.45

			if var_97_0 < arg_94_1.time_ and arg_94_1.time_ <= var_97_0 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				local var_97_2 = arg_94_1:FormatText(StoryNameCfg[318].name)

				arg_94_1.leftNameTxt_.text = var_97_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_3 = arg_94_1:GetWordFromCfg(325542023)
				local var_97_4 = arg_94_1:FormatText(var_97_3.content)

				arg_94_1.text_.text = var_97_4

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_5 = 18
				local var_97_6 = utf8.len(var_97_4)
				local var_97_7 = var_97_5 <= 0 and var_97_1 or var_97_1 * (var_97_6 / var_97_5)

				if var_97_7 > 0 and var_97_1 < var_97_7 then
					arg_94_1.talkMaxDuration = var_97_7

					if var_97_7 + var_97_0 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_7 + var_97_0
					end
				end

				arg_94_1.text_.text = var_97_4
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325542", "325542023", "story_v_out_325542.awb") ~= 0 then
					local var_97_8 = manager.audio:GetVoiceLength("story_v_out_325542", "325542023", "story_v_out_325542.awb") / 1000

					if var_97_8 + var_97_0 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_8 + var_97_0
					end

					if var_97_3.prefab_name ~= "" and arg_94_1.actors_[var_97_3.prefab_name] ~= nil then
						local var_97_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_94_1.actors_[var_97_3.prefab_name].transform, "story_v_out_325542", "325542023", "story_v_out_325542.awb")

						arg_94_1:RecordAudio("325542023", var_97_9)
						arg_94_1:RecordAudio("325542023", var_97_9)
					else
						arg_94_1:AudioAction("play", "voice", "story_v_out_325542", "325542023", "story_v_out_325542.awb")
					end

					arg_94_1:RecordHistoryTalkVoice("story_v_out_325542", "325542023", "story_v_out_325542.awb")
				end

				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_10 = math.max(var_97_1, arg_94_1.talkMaxDuration)

			if var_97_0 <= arg_94_1.time_ and arg_94_1.time_ < var_97_0 + var_97_10 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_0) / var_97_10

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_0 + var_97_10 and arg_94_1.time_ < var_97_0 + var_97_10 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {}

		arg_94_1:InitPlayNodeList()
	end,
	Play325542024 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 325542024
		arg_98_1.duration_ = 5

		SetActive(arg_98_1.tipsGo_, false)

		function arg_98_1.onSingleLineFinish_()
			arg_98_1.onSingleLineUpdate_ = nil
			arg_98_1.onSingleLineFinish_ = nil
			arg_98_1.state_ = "waiting"
		end

		function arg_98_1.playNext_(arg_100_0)
			if arg_100_0 == 1 then
				arg_98_0:Play325542025(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			local var_101_0 = arg_98_1.actors_["1170ui_story"]
			local var_101_1 = 0

			if var_101_1 < arg_98_1.time_ and arg_98_1.time_ <= var_101_1 + arg_101_0 and not isNil(var_101_0) and arg_98_1.var_.characterEffect1170ui_story == nil then
				arg_98_1.var_.characterEffect1170ui_story = var_101_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_101_2 = 0.200000002980232

			if var_101_1 <= arg_98_1.time_ and arg_98_1.time_ < var_101_1 + var_101_2 and not isNil(var_101_0) then
				local var_101_3 = (arg_98_1.time_ - var_101_1) / var_101_2

				if arg_98_1.var_.characterEffect1170ui_story and not isNil(var_101_0) then
					local var_101_4 = Mathf.Lerp(0, 0.5, var_101_3)

					arg_98_1.var_.characterEffect1170ui_story.fillFlat = true
					arg_98_1.var_.characterEffect1170ui_story.fillRatio = var_101_4
				end
			end

			if arg_98_1.time_ >= var_101_1 + var_101_2 and arg_98_1.time_ < var_101_1 + var_101_2 + arg_101_0 and not isNil(var_101_0) and arg_98_1.var_.characterEffect1170ui_story then
				local var_101_5 = 0.5

				arg_98_1.var_.characterEffect1170ui_story.fillFlat = true
				arg_98_1.var_.characterEffect1170ui_story.fillRatio = var_101_5
			end

			local var_101_6 = 0
			local var_101_7 = 0.225

			if var_101_6 < arg_98_1.time_ and arg_98_1.time_ <= var_101_6 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, true)

				local var_101_8 = arg_98_1:FormatText(StoryNameCfg[7].name)

				arg_98_1.leftNameTxt_.text = var_101_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, true)
				arg_98_1.iconController_:SetSelectedState("hero")

				arg_98_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_98_1.callingController_:SetSelectedState("normal")

				arg_98_1.keyicon_.color = Color.New(1, 1, 1)
				arg_98_1.icon_.color = Color.New(1, 1, 1)

				local var_101_9 = arg_98_1:GetWordFromCfg(325542024)
				local var_101_10 = arg_98_1:FormatText(var_101_9.content)

				arg_98_1.text_.text = var_101_10

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_11 = 9
				local var_101_12 = utf8.len(var_101_10)
				local var_101_13 = var_101_11 <= 0 and var_101_7 or var_101_7 * (var_101_12 / var_101_11)

				if var_101_13 > 0 and var_101_7 < var_101_13 then
					arg_98_1.talkMaxDuration = var_101_13

					if var_101_13 + var_101_6 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_13 + var_101_6
					end
				end

				arg_98_1.text_.text = var_101_10
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)
				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_14 = math.max(var_101_7, arg_98_1.talkMaxDuration)

			if var_101_6 <= arg_98_1.time_ and arg_98_1.time_ < var_101_6 + var_101_14 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_6) / var_101_14

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_6 + var_101_14 and arg_98_1.time_ < var_101_6 + var_101_14 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {}

		arg_98_1:InitPlayNodeList()
	end,
	Play325542025 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 325542025
		arg_102_1.duration_ = 11.2

		SetActive(arg_102_1.tipsGo_, false)

		function arg_102_1.onSingleLineFinish_()
			arg_102_1.onSingleLineUpdate_ = nil
			arg_102_1.onSingleLineFinish_ = nil
			arg_102_1.state_ = "waiting"
		end

		function arg_102_1.playNext_(arg_104_0)
			if arg_104_0 == 1 then
				arg_102_0:Play325542026(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			local var_105_0 = arg_102_1.actors_["1170ui_story"]
			local var_105_1 = 0

			if var_105_1 < arg_102_1.time_ and arg_102_1.time_ <= var_105_1 + arg_105_0 and not isNil(var_105_0) and arg_102_1.var_.characterEffect1170ui_story == nil then
				arg_102_1.var_.characterEffect1170ui_story = var_105_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_105_2 = 0.200000002980232

			if var_105_1 <= arg_102_1.time_ and arg_102_1.time_ < var_105_1 + var_105_2 and not isNil(var_105_0) then
				local var_105_3 = (arg_102_1.time_ - var_105_1) / var_105_2

				if arg_102_1.var_.characterEffect1170ui_story and not isNil(var_105_0) then
					arg_102_1.var_.characterEffect1170ui_story.fillFlat = false
				end
			end

			if arg_102_1.time_ >= var_105_1 + var_105_2 and arg_102_1.time_ < var_105_1 + var_105_2 + arg_105_0 and not isNil(var_105_0) and arg_102_1.var_.characterEffect1170ui_story then
				arg_102_1.var_.characterEffect1170ui_story.fillFlat = false
			end

			local var_105_4 = 0

			if var_105_4 < arg_102_1.time_ and arg_102_1.time_ <= var_105_4 + arg_105_0 then
				arg_102_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/story1170/story1170action/1170action4_2")
			end

			local var_105_5 = 0

			if var_105_5 < arg_102_1.time_ and arg_102_1.time_ <= var_105_5 + arg_105_0 then
				arg_102_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_105_6 = 0
			local var_105_7 = 1.225

			if var_105_6 < arg_102_1.time_ and arg_102_1.time_ <= var_105_6 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, true)

				local var_105_8 = arg_102_1:FormatText(StoryNameCfg[318].name)

				arg_102_1.leftNameTxt_.text = var_105_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_102_1.leftNameTxt_.transform)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1.leftNameTxt_.text)
				SetActive(arg_102_1.iconTrs_.gameObject, false)
				arg_102_1.callingController_:SetSelectedState("normal")

				local var_105_9 = arg_102_1:GetWordFromCfg(325542025)
				local var_105_10 = arg_102_1:FormatText(var_105_9.content)

				arg_102_1.text_.text = var_105_10

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_11 = 49
				local var_105_12 = utf8.len(var_105_10)
				local var_105_13 = var_105_11 <= 0 and var_105_7 or var_105_7 * (var_105_12 / var_105_11)

				if var_105_13 > 0 and var_105_7 < var_105_13 then
					arg_102_1.talkMaxDuration = var_105_13

					if var_105_13 + var_105_6 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_13 + var_105_6
					end
				end

				arg_102_1.text_.text = var_105_10
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325542", "325542025", "story_v_out_325542.awb") ~= 0 then
					local var_105_14 = manager.audio:GetVoiceLength("story_v_out_325542", "325542025", "story_v_out_325542.awb") / 1000

					if var_105_14 + var_105_6 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_14 + var_105_6
					end

					if var_105_9.prefab_name ~= "" and arg_102_1.actors_[var_105_9.prefab_name] ~= nil then
						local var_105_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_102_1.actors_[var_105_9.prefab_name].transform, "story_v_out_325542", "325542025", "story_v_out_325542.awb")

						arg_102_1:RecordAudio("325542025", var_105_15)
						arg_102_1:RecordAudio("325542025", var_105_15)
					else
						arg_102_1:AudioAction("play", "voice", "story_v_out_325542", "325542025", "story_v_out_325542.awb")
					end

					arg_102_1:RecordHistoryTalkVoice("story_v_out_325542", "325542025", "story_v_out_325542.awb")
				end

				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_16 = math.max(var_105_7, arg_102_1.talkMaxDuration)

			if var_105_6 <= arg_102_1.time_ and arg_102_1.time_ < var_105_6 + var_105_16 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - var_105_6) / var_105_16

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= var_105_6 + var_105_16 and arg_102_1.time_ < var_105_6 + var_105_16 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {}

		arg_102_1:InitPlayNodeList()
	end,
	Play325542026 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 325542026
		arg_106_1.duration_ = 5

		SetActive(arg_106_1.tipsGo_, false)

		function arg_106_1.onSingleLineFinish_()
			arg_106_1.onSingleLineUpdate_ = nil
			arg_106_1.onSingleLineFinish_ = nil
			arg_106_1.state_ = "waiting"
		end

		function arg_106_1.playNext_(arg_108_0)
			if arg_108_0 == 1 then
				arg_106_0:Play325542027(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			local var_109_0 = arg_106_1.actors_["1170ui_story"]
			local var_109_1 = 0

			if var_109_1 < arg_106_1.time_ and arg_106_1.time_ <= var_109_1 + arg_109_0 and not isNil(var_109_0) and arg_106_1.var_.characterEffect1170ui_story == nil then
				arg_106_1.var_.characterEffect1170ui_story = var_109_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_109_2 = 0.200000002980232

			if var_109_1 <= arg_106_1.time_ and arg_106_1.time_ < var_109_1 + var_109_2 and not isNil(var_109_0) then
				local var_109_3 = (arg_106_1.time_ - var_109_1) / var_109_2

				if arg_106_1.var_.characterEffect1170ui_story and not isNil(var_109_0) then
					local var_109_4 = Mathf.Lerp(0, 0.5, var_109_3)

					arg_106_1.var_.characterEffect1170ui_story.fillFlat = true
					arg_106_1.var_.characterEffect1170ui_story.fillRatio = var_109_4
				end
			end

			if arg_106_1.time_ >= var_109_1 + var_109_2 and arg_106_1.time_ < var_109_1 + var_109_2 + arg_109_0 and not isNil(var_109_0) and arg_106_1.var_.characterEffect1170ui_story then
				local var_109_5 = 0.5

				arg_106_1.var_.characterEffect1170ui_story.fillFlat = true
				arg_106_1.var_.characterEffect1170ui_story.fillRatio = var_109_5
			end

			local var_109_6 = 0
			local var_109_7 = 0.475

			if var_109_6 < arg_106_1.time_ and arg_106_1.time_ <= var_109_6 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, true)

				local var_109_8 = arg_106_1:FormatText(StoryNameCfg[7].name)

				arg_106_1.leftNameTxt_.text = var_109_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_106_1.leftNameTxt_.transform)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1.leftNameTxt_.text)
				SetActive(arg_106_1.iconTrs_.gameObject, true)
				arg_106_1.iconController_:SetSelectedState("hero")

				arg_106_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_106_1.callingController_:SetSelectedState("normal")

				arg_106_1.keyicon_.color = Color.New(1, 1, 1)
				arg_106_1.icon_.color = Color.New(1, 1, 1)

				local var_109_9 = arg_106_1:GetWordFromCfg(325542026)
				local var_109_10 = arg_106_1:FormatText(var_109_9.content)

				arg_106_1.text_.text = var_109_10

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_11 = 19
				local var_109_12 = utf8.len(var_109_10)
				local var_109_13 = var_109_11 <= 0 and var_109_7 or var_109_7 * (var_109_12 / var_109_11)

				if var_109_13 > 0 and var_109_7 < var_109_13 then
					arg_106_1.talkMaxDuration = var_109_13

					if var_109_13 + var_109_6 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_13 + var_109_6
					end
				end

				arg_106_1.text_.text = var_109_10
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)
				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_14 = math.max(var_109_7, arg_106_1.talkMaxDuration)

			if var_109_6 <= arg_106_1.time_ and arg_106_1.time_ < var_109_6 + var_109_14 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - var_109_6) / var_109_14

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= var_109_6 + var_109_14 and arg_106_1.time_ < var_109_6 + var_109_14 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {}

		arg_106_1:InitPlayNodeList()
	end,
	Play325542027 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 325542027
		arg_110_1.duration_ = 7.93

		SetActive(arg_110_1.tipsGo_, false)

		function arg_110_1.onSingleLineFinish_()
			arg_110_1.onSingleLineUpdate_ = nil
			arg_110_1.onSingleLineFinish_ = nil
			arg_110_1.state_ = "waiting"
		end

		function arg_110_1.playNext_(arg_112_0)
			if arg_112_0 == 1 then
				arg_110_0:Play325542028(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			local var_113_0 = arg_110_1.actors_["1170ui_story"]
			local var_113_1 = 0

			if var_113_1 < arg_110_1.time_ and arg_110_1.time_ <= var_113_1 + arg_113_0 and not isNil(var_113_0) and arg_110_1.var_.characterEffect1170ui_story == nil then
				arg_110_1.var_.characterEffect1170ui_story = var_113_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_113_2 = 0.200000002980232

			if var_113_1 <= arg_110_1.time_ and arg_110_1.time_ < var_113_1 + var_113_2 and not isNil(var_113_0) then
				local var_113_3 = (arg_110_1.time_ - var_113_1) / var_113_2

				if arg_110_1.var_.characterEffect1170ui_story and not isNil(var_113_0) then
					arg_110_1.var_.characterEffect1170ui_story.fillFlat = false
				end
			end

			if arg_110_1.time_ >= var_113_1 + var_113_2 and arg_110_1.time_ < var_113_1 + var_113_2 + arg_113_0 and not isNil(var_113_0) and arg_110_1.var_.characterEffect1170ui_story then
				arg_110_1.var_.characterEffect1170ui_story.fillFlat = false
			end

			local var_113_4 = 0

			if var_113_4 < arg_110_1.time_ and arg_110_1.time_ <= var_113_4 + arg_113_0 then
				arg_110_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/story1170/story1170action/1170action2_1")
			end

			local var_113_5 = 0

			if var_113_5 < arg_110_1.time_ and arg_110_1.time_ <= var_113_5 + arg_113_0 then
				arg_110_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/public_expression/expr_kunraoA_sikao", "EmotionTimelineAnimator")
			end

			local var_113_6 = 0
			local var_113_7 = 0.575

			if var_113_6 < arg_110_1.time_ and arg_110_1.time_ <= var_113_6 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, true)

				local var_113_8 = arg_110_1:FormatText(StoryNameCfg[318].name)

				arg_110_1.leftNameTxt_.text = var_113_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_110_1.leftNameTxt_.transform)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1.leftNameTxt_.text)
				SetActive(arg_110_1.iconTrs_.gameObject, false)
				arg_110_1.callingController_:SetSelectedState("normal")

				local var_113_9 = arg_110_1:GetWordFromCfg(325542027)
				local var_113_10 = arg_110_1:FormatText(var_113_9.content)

				arg_110_1.text_.text = var_113_10

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_11 = 23
				local var_113_12 = utf8.len(var_113_10)
				local var_113_13 = var_113_11 <= 0 and var_113_7 or var_113_7 * (var_113_12 / var_113_11)

				if var_113_13 > 0 and var_113_7 < var_113_13 then
					arg_110_1.talkMaxDuration = var_113_13

					if var_113_13 + var_113_6 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_13 + var_113_6
					end
				end

				arg_110_1.text_.text = var_113_10
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325542", "325542027", "story_v_out_325542.awb") ~= 0 then
					local var_113_14 = manager.audio:GetVoiceLength("story_v_out_325542", "325542027", "story_v_out_325542.awb") / 1000

					if var_113_14 + var_113_6 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_14 + var_113_6
					end

					if var_113_9.prefab_name ~= "" and arg_110_1.actors_[var_113_9.prefab_name] ~= nil then
						local var_113_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_110_1.actors_[var_113_9.prefab_name].transform, "story_v_out_325542", "325542027", "story_v_out_325542.awb")

						arg_110_1:RecordAudio("325542027", var_113_15)
						arg_110_1:RecordAudio("325542027", var_113_15)
					else
						arg_110_1:AudioAction("play", "voice", "story_v_out_325542", "325542027", "story_v_out_325542.awb")
					end

					arg_110_1:RecordHistoryTalkVoice("story_v_out_325542", "325542027", "story_v_out_325542.awb")
				end

				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_16 = math.max(var_113_7, arg_110_1.talkMaxDuration)

			if var_113_6 <= arg_110_1.time_ and arg_110_1.time_ < var_113_6 + var_113_16 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - var_113_6) / var_113_16

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= var_113_6 + var_113_16 and arg_110_1.time_ < var_113_6 + var_113_16 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {}

		arg_110_1:InitPlayNodeList()
	end,
	Play325542028 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 325542028
		arg_114_1.duration_ = 5

		SetActive(arg_114_1.tipsGo_, false)

		function arg_114_1.onSingleLineFinish_()
			arg_114_1.onSingleLineUpdate_ = nil
			arg_114_1.onSingleLineFinish_ = nil
			arg_114_1.state_ = "waiting"
		end

		function arg_114_1.playNext_(arg_116_0)
			if arg_116_0 == 1 then
				arg_114_0:Play325542029(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			local var_117_0 = arg_114_1.actors_["1170ui_story"]
			local var_117_1 = 0

			if var_117_1 < arg_114_1.time_ and arg_114_1.time_ <= var_117_1 + arg_117_0 and not isNil(var_117_0) and arg_114_1.var_.characterEffect1170ui_story == nil then
				arg_114_1.var_.characterEffect1170ui_story = var_117_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_117_2 = 0.200000002980232

			if var_117_1 <= arg_114_1.time_ and arg_114_1.time_ < var_117_1 + var_117_2 and not isNil(var_117_0) then
				local var_117_3 = (arg_114_1.time_ - var_117_1) / var_117_2

				if arg_114_1.var_.characterEffect1170ui_story and not isNil(var_117_0) then
					local var_117_4 = Mathf.Lerp(0, 0.5, var_117_3)

					arg_114_1.var_.characterEffect1170ui_story.fillFlat = true
					arg_114_1.var_.characterEffect1170ui_story.fillRatio = var_117_4
				end
			end

			if arg_114_1.time_ >= var_117_1 + var_117_2 and arg_114_1.time_ < var_117_1 + var_117_2 + arg_117_0 and not isNil(var_117_0) and arg_114_1.var_.characterEffect1170ui_story then
				local var_117_5 = 0.5

				arg_114_1.var_.characterEffect1170ui_story.fillFlat = true
				arg_114_1.var_.characterEffect1170ui_story.fillRatio = var_117_5
			end

			local var_117_6 = 0
			local var_117_7 = 1.475

			if var_117_6 < arg_114_1.time_ and arg_114_1.time_ <= var_117_6 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, false)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_114_1.iconTrs_.gameObject, false)
				arg_114_1.callingController_:SetSelectedState("normal")

				local var_117_8 = arg_114_1:GetWordFromCfg(325542028)
				local var_117_9 = arg_114_1:FormatText(var_117_8.content)

				arg_114_1.text_.text = var_117_9

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_10 = 59
				local var_117_11 = utf8.len(var_117_9)
				local var_117_12 = var_117_10 <= 0 and var_117_7 or var_117_7 * (var_117_11 / var_117_10)

				if var_117_12 > 0 and var_117_7 < var_117_12 then
					arg_114_1.talkMaxDuration = var_117_12

					if var_117_12 + var_117_6 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_12 + var_117_6
					end
				end

				arg_114_1.text_.text = var_117_9
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)
				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_13 = math.max(var_117_7, arg_114_1.talkMaxDuration)

			if var_117_6 <= arg_114_1.time_ and arg_114_1.time_ < var_117_6 + var_117_13 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - var_117_6) / var_117_13

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= var_117_6 + var_117_13 and arg_114_1.time_ < var_117_6 + var_117_13 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {}

		arg_114_1:InitPlayNodeList()
	end,
	Play325542029 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 325542029
		arg_118_1.duration_ = 5

		SetActive(arg_118_1.tipsGo_, false)

		function arg_118_1.onSingleLineFinish_()
			arg_118_1.onSingleLineUpdate_ = nil
			arg_118_1.onSingleLineFinish_ = nil
			arg_118_1.state_ = "waiting"
		end

		function arg_118_1.playNext_(arg_120_0)
			if arg_120_0 == 1 then
				arg_118_0:Play325542030(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			local var_121_0 = 0
			local var_121_1 = 0.7

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

				local var_121_3 = arg_118_1:GetWordFromCfg(325542029)
				local var_121_4 = arg_118_1:FormatText(var_121_3.content)

				arg_118_1.text_.text = var_121_4

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_5 = 28
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
	Play325542030 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 325542030
		arg_122_1.duration_ = 3.67

		SetActive(arg_122_1.tipsGo_, false)

		function arg_122_1.onSingleLineFinish_()
			arg_122_1.onSingleLineUpdate_ = nil
			arg_122_1.onSingleLineFinish_ = nil
			arg_122_1.state_ = "waiting"
		end

		function arg_122_1.playNext_(arg_124_0)
			if arg_124_0 == 1 then
				arg_122_0:Play325542031(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			local var_125_0 = arg_122_1.actors_["1170ui_story"]
			local var_125_1 = 0

			if var_125_1 < arg_122_1.time_ and arg_122_1.time_ <= var_125_1 + arg_125_0 and not isNil(var_125_0) and arg_122_1.var_.characterEffect1170ui_story == nil then
				arg_122_1.var_.characterEffect1170ui_story = var_125_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_125_2 = 0.200000002980232

			if var_125_1 <= arg_122_1.time_ and arg_122_1.time_ < var_125_1 + var_125_2 and not isNil(var_125_0) then
				local var_125_3 = (arg_122_1.time_ - var_125_1) / var_125_2

				if arg_122_1.var_.characterEffect1170ui_story and not isNil(var_125_0) then
					arg_122_1.var_.characterEffect1170ui_story.fillFlat = false
				end
			end

			if arg_122_1.time_ >= var_125_1 + var_125_2 and arg_122_1.time_ < var_125_1 + var_125_2 + arg_125_0 and not isNil(var_125_0) and arg_122_1.var_.characterEffect1170ui_story then
				arg_122_1.var_.characterEffect1170ui_story.fillFlat = false
			end

			local var_125_4 = 0

			if var_125_4 < arg_122_1.time_ and arg_122_1.time_ <= var_125_4 + arg_125_0 then
				arg_122_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/story1170/story1170action/1170action2_2")
			end

			local var_125_5 = 0

			if var_125_5 < arg_122_1.time_ and arg_122_1.time_ <= var_125_5 + arg_125_0 then
				arg_122_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_125_6 = 0
			local var_125_7 = 0.325

			if var_125_6 < arg_122_1.time_ and arg_122_1.time_ <= var_125_6 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, true)

				local var_125_8 = arg_122_1:FormatText(StoryNameCfg[318].name)

				arg_122_1.leftNameTxt_.text = var_125_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_122_1.leftNameTxt_.transform)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1.leftNameTxt_.text)
				SetActive(arg_122_1.iconTrs_.gameObject, false)
				arg_122_1.callingController_:SetSelectedState("normal")

				local var_125_9 = arg_122_1:GetWordFromCfg(325542030)
				local var_125_10 = arg_122_1:FormatText(var_125_9.content)

				arg_122_1.text_.text = var_125_10

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_11 = 13
				local var_125_12 = utf8.len(var_125_10)
				local var_125_13 = var_125_11 <= 0 and var_125_7 or var_125_7 * (var_125_12 / var_125_11)

				if var_125_13 > 0 and var_125_7 < var_125_13 then
					arg_122_1.talkMaxDuration = var_125_13

					if var_125_13 + var_125_6 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_13 + var_125_6
					end
				end

				arg_122_1.text_.text = var_125_10
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325542", "325542030", "story_v_out_325542.awb") ~= 0 then
					local var_125_14 = manager.audio:GetVoiceLength("story_v_out_325542", "325542030", "story_v_out_325542.awb") / 1000

					if var_125_14 + var_125_6 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_14 + var_125_6
					end

					if var_125_9.prefab_name ~= "" and arg_122_1.actors_[var_125_9.prefab_name] ~= nil then
						local var_125_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_122_1.actors_[var_125_9.prefab_name].transform, "story_v_out_325542", "325542030", "story_v_out_325542.awb")

						arg_122_1:RecordAudio("325542030", var_125_15)
						arg_122_1:RecordAudio("325542030", var_125_15)
					else
						arg_122_1:AudioAction("play", "voice", "story_v_out_325542", "325542030", "story_v_out_325542.awb")
					end

					arg_122_1:RecordHistoryTalkVoice("story_v_out_325542", "325542030", "story_v_out_325542.awb")
				end

				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_16 = math.max(var_125_7, arg_122_1.talkMaxDuration)

			if var_125_6 <= arg_122_1.time_ and arg_122_1.time_ < var_125_6 + var_125_16 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - var_125_6) / var_125_16

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= var_125_6 + var_125_16 and arg_122_1.time_ < var_125_6 + var_125_16 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {}

		arg_122_1:InitPlayNodeList()
	end,
	Play325542031 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 325542031
		arg_126_1.duration_ = 5

		SetActive(arg_126_1.tipsGo_, false)

		function arg_126_1.onSingleLineFinish_()
			arg_126_1.onSingleLineUpdate_ = nil
			arg_126_1.onSingleLineFinish_ = nil
			arg_126_1.state_ = "waiting"
		end

		function arg_126_1.playNext_(arg_128_0)
			if arg_128_0 == 1 then
				arg_126_0:Play325542032(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			local var_129_0 = arg_126_1.actors_["1170ui_story"]
			local var_129_1 = 0

			if var_129_1 < arg_126_1.time_ and arg_126_1.time_ <= var_129_1 + arg_129_0 and not isNil(var_129_0) and arg_126_1.var_.characterEffect1170ui_story == nil then
				arg_126_1.var_.characterEffect1170ui_story = var_129_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_129_2 = 0.200000002980232

			if var_129_1 <= arg_126_1.time_ and arg_126_1.time_ < var_129_1 + var_129_2 and not isNil(var_129_0) then
				local var_129_3 = (arg_126_1.time_ - var_129_1) / var_129_2

				if arg_126_1.var_.characterEffect1170ui_story and not isNil(var_129_0) then
					local var_129_4 = Mathf.Lerp(0, 0.5, var_129_3)

					arg_126_1.var_.characterEffect1170ui_story.fillFlat = true
					arg_126_1.var_.characterEffect1170ui_story.fillRatio = var_129_4
				end
			end

			if arg_126_1.time_ >= var_129_1 + var_129_2 and arg_126_1.time_ < var_129_1 + var_129_2 + arg_129_0 and not isNil(var_129_0) and arg_126_1.var_.characterEffect1170ui_story then
				local var_129_5 = 0.5

				arg_126_1.var_.characterEffect1170ui_story.fillFlat = true
				arg_126_1.var_.characterEffect1170ui_story.fillRatio = var_129_5
			end

			local var_129_6 = 0
			local var_129_7 = 0.3

			if var_129_6 < arg_126_1.time_ and arg_126_1.time_ <= var_129_6 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0
				arg_126_1.dialogCg_.alpha = 1

				arg_126_1.dialog_:SetActive(true)
				SetActive(arg_126_1.leftNameGo_, true)

				local var_129_8 = arg_126_1:FormatText(StoryNameCfg[7].name)

				arg_126_1.leftNameTxt_.text = var_129_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_126_1.leftNameTxt_.transform)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1.leftNameTxt_.text)
				SetActive(arg_126_1.iconTrs_.gameObject, true)
				arg_126_1.iconController_:SetSelectedState("hero")

				arg_126_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_126_1.callingController_:SetSelectedState("normal")

				arg_126_1.keyicon_.color = Color.New(1, 1, 1)
				arg_126_1.icon_.color = Color.New(1, 1, 1)

				local var_129_9 = arg_126_1:GetWordFromCfg(325542031)
				local var_129_10 = arg_126_1:FormatText(var_129_9.content)

				arg_126_1.text_.text = var_129_10

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_11 = 12
				local var_129_12 = utf8.len(var_129_10)
				local var_129_13 = var_129_11 <= 0 and var_129_7 or var_129_7 * (var_129_12 / var_129_11)

				if var_129_13 > 0 and var_129_7 < var_129_13 then
					arg_126_1.talkMaxDuration = var_129_13

					if var_129_13 + var_129_6 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_13 + var_129_6
					end
				end

				arg_126_1.text_.text = var_129_10
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)
				arg_126_1:RecordContent(arg_126_1.text_.text)
			end

			local var_129_14 = math.max(var_129_7, arg_126_1.talkMaxDuration)

			if var_129_6 <= arg_126_1.time_ and arg_126_1.time_ < var_129_6 + var_129_14 then
				arg_126_1.typewritter.percent = (arg_126_1.time_ - var_129_6) / var_129_14

				arg_126_1.typewritter:SetDirty()
			end

			if arg_126_1.time_ >= var_129_6 + var_129_14 and arg_126_1.time_ < var_129_6 + var_129_14 + arg_129_0 then
				arg_126_1.typewritter.percent = 1

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(true)
			end
		end

		arg_126_1.nodeConfigList_ = {}

		arg_126_1:InitPlayNodeList()
	end,
	Play325542032 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 325542032
		arg_130_1.duration_ = 11.9

		SetActive(arg_130_1.tipsGo_, false)

		function arg_130_1.onSingleLineFinish_()
			arg_130_1.onSingleLineUpdate_ = nil
			arg_130_1.onSingleLineFinish_ = nil
			arg_130_1.state_ = "waiting"
		end

		function arg_130_1.playNext_(arg_132_0)
			if arg_132_0 == 1 then
				arg_130_0:Play325542033(arg_130_1)
			end
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			local var_133_0 = arg_130_1.actors_["1170ui_story"].transform
			local var_133_1 = 0

			if var_133_1 < arg_130_1.time_ and arg_130_1.time_ <= var_133_1 + arg_133_0 then
				arg_130_1.var_.moveOldPos1170ui_story = var_133_0.localPosition

				local var_133_2 = GameObjectTools.GetOrAddComponent(var_133_0.gameObject, typeof(DynamicBoneHelper))

				if var_133_2 then
					var_133_2:EnableDynamicBone(false)
				end
			end

			local var_133_3 = 0.001

			if var_133_1 <= arg_130_1.time_ and arg_130_1.time_ < var_133_1 + var_133_3 then
				local var_133_4 = (arg_130_1.time_ - var_133_1) / var_133_3
				local var_133_5 = Vector3.New(0, 100, 0)

				var_133_0.localPosition = Vector3.Lerp(arg_130_1.var_.moveOldPos1170ui_story, var_133_5, var_133_4)

				local var_133_6 = manager.ui.mainCamera.transform.position - var_133_0.position

				var_133_0.forward = Vector3.New(var_133_6.x, var_133_6.y, var_133_6.z)

				local var_133_7 = var_133_0.localEulerAngles

				var_133_7.z = 0
				var_133_7.x = 0
				var_133_0.localEulerAngles = var_133_7
			end

			if arg_130_1.time_ >= var_133_1 + var_133_3 and arg_130_1.time_ < var_133_1 + var_133_3 + arg_133_0 then
				var_133_0.localPosition = Vector3.New(0, 100, 0)

				local var_133_8 = manager.ui.mainCamera.transform.position - var_133_0.position

				var_133_0.forward = Vector3.New(var_133_8.x, var_133_8.y, var_133_8.z)

				local var_133_9 = var_133_0.localEulerAngles

				var_133_9.z = 0
				var_133_9.x = 0
				var_133_0.localEulerAngles = var_133_9

				local var_133_10 = GameObjectTools.GetOrAddComponent(var_133_0.gameObject, typeof(DynamicBoneHelper))

				if var_133_10 then
					var_133_10:EnableDynamicBone(true)
				end
			end

			local var_133_11 = manager.ui.mainCamera.transform
			local var_133_12 = 0

			if var_133_12 < arg_130_1.time_ and arg_130_1.time_ <= var_133_12 + arg_133_0 then
				local var_133_13 = arg_130_1.var_.effect1dff
				local var_133_14
				local var_133_15 = var_133_11

				if not var_133_13 then
					var_133_13 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_scan_in_out"), var_133_15)
					var_133_13.name = "1dff"
					arg_130_1.var_.effect1dff = var_133_13
				else
					var_133_13.transform:SetParent(var_133_15)
				end

				var_133_13.transform.localPosition = Vector3.New(0, 0, 0)
				var_133_13.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_133_16 = manager.ui.mainCamera.transform
			local var_133_17 = 4.3

			if var_133_17 < arg_130_1.time_ and arg_130_1.time_ <= var_133_17 + arg_133_0 then
				local var_133_18 = arg_130_1.var_.effect1dff

				if var_133_18 then
					Object.Destroy(var_133_18)

					arg_130_1.var_.effect1dff = nil
				end
			end

			local var_133_19 = manager.ui.mainCamera.transform
			local var_133_20 = 1

			if var_133_20 < arg_130_1.time_ and arg_130_1.time_ <= var_133_20 + arg_133_0 then
				local var_133_21 = arg_130_1.var_.effect巅峰赛1
				local var_133_22
				local var_133_23 = var_133_19

				if not var_133_21 then
					var_133_21 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_target_gantan_in"), var_133_23)
					var_133_21.name = "巅峰赛1"
					arg_130_1.var_.effect巅峰赛1 = var_133_21
				else
					var_133_21.transform:SetParent(var_133_23)
				end

				var_133_21.transform.localPosition = Vector3.New(-0.33, 0, 0)
				var_133_21.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_133_24 = 1.7777777777777777
				local var_133_25 = Screen.width / Screen.height
				local var_133_26 = var_133_25 / var_133_24
				local var_133_27 = Mathf.Max(var_133_24 / var_133_25, 1)

				var_133_21.transform.localScale = Vector3.New(var_133_21.transform.localScale.x * var_133_26, var_133_21.transform.localScale.y * var_133_27, var_133_21.transform.localScale.z)
			end

			local var_133_28 = manager.ui.mainCamera.transform
			local var_133_29 = 1.9

			if var_133_29 < arg_130_1.time_ and arg_130_1.time_ <= var_133_29 + arg_133_0 then
				local var_133_30 = arg_130_1.var_.effect巅峰赛
				local var_133_31
				local var_133_32 = var_133_28

				if not var_133_30 then
					var_133_30 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_target_gantan_out"), var_133_32)
					var_133_30.name = "巅峰赛"
					arg_130_1.var_.effect巅峰赛 = var_133_30
				else
					var_133_30.transform:SetParent(var_133_32)
				end

				var_133_30.transform.localPosition = Vector3.New(-0.33, 0, 0)
				var_133_30.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_133_33 = 1.7777777777777777
				local var_133_34 = Screen.width / Screen.height
				local var_133_35 = var_133_34 / var_133_33
				local var_133_36 = Mathf.Max(var_133_33 / var_133_34, 1)

				var_133_30.transform.localScale = Vector3.New(var_133_30.transform.localScale.x * var_133_35, var_133_30.transform.localScale.y * var_133_36, var_133_30.transform.localScale.z)
			end

			local var_133_37 = manager.ui.mainCamera.transform
			local var_133_38 = 6.9

			if var_133_38 < arg_130_1.time_ and arg_130_1.time_ <= var_133_38 + arg_133_0 then
				local var_133_39 = arg_130_1.var_.effect巅峰赛

				if var_133_39 then
					Object.Destroy(var_133_39)

					arg_130_1.var_.effect巅峰赛 = nil
				end
			end

			local var_133_40 = manager.ui.mainCamera.transform
			local var_133_41 = 1.91441760258749

			if var_133_41 < arg_130_1.time_ and arg_130_1.time_ <= var_133_41 + arg_133_0 then
				local var_133_42 = arg_130_1.var_.effect巅峰赛1

				if var_133_42 then
					Object.Destroy(var_133_42)

					arg_130_1.var_.effect巅峰赛1 = nil
				end
			end

			local var_133_43 = 0

			if var_133_43 < arg_130_1.time_ and arg_130_1.time_ <= var_133_43 + arg_133_0 then
				arg_130_1.allBtn_.enabled = false
			end

			local var_133_44 = 4.9

			if arg_130_1.time_ >= var_133_43 + var_133_44 and arg_130_1.time_ < var_133_43 + var_133_44 + arg_133_0 then
				arg_130_1.allBtn_.enabled = true
			end

			if arg_130_1.frameCnt_ <= 1 then
				arg_130_1.dialog_:SetActive(false)
			end

			local var_133_45 = 3.26441760258749
			local var_133_46 = 0.65

			if var_133_45 < arg_130_1.time_ and arg_130_1.time_ <= var_133_45 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0

				arg_130_1.dialog_:SetActive(true)

				arg_130_1.dialogCg_.alpha = 0

				local var_133_47 = LeanTween.value(arg_130_1.dialog_, 0, 1, 0.3)

				var_133_47:setOnUpdate(LuaHelper.FloatAction(function(arg_134_0)
					arg_130_1.dialogCg_.alpha = arg_134_0
				end))
				var_133_47:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_130_1.dialog_)
					var_133_47:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_130_1.duration_ = arg_130_1.duration_ + 0.3

				SetActive(arg_130_1.leftNameGo_, false)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_130_1.iconTrs_.gameObject, false)
				arg_130_1.callingController_:SetSelectedState("normal")

				local var_133_48 = arg_130_1:GetWordFromCfg(325542032)
				local var_133_49 = arg_130_1:FormatText(var_133_48.content)

				arg_130_1.text_.text = var_133_49

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_50 = 26
				local var_133_51 = utf8.len(var_133_49)
				local var_133_52 = var_133_50 <= 0 and var_133_46 or var_133_46 * (var_133_51 / var_133_50)

				if var_133_52 > 0 and var_133_46 < var_133_52 then
					arg_130_1.talkMaxDuration = var_133_52
					var_133_45 = var_133_45 + 0.3

					if var_133_52 + var_133_45 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_52 + var_133_45
					end
				end

				arg_130_1.text_.text = var_133_49
				arg_130_1.typewritter.percent = 0

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(false)
				arg_130_1:RecordContent(arg_130_1.text_.text)
			end

			local var_133_53 = var_133_45 + 0.3
			local var_133_54 = math.max(var_133_46, arg_130_1.talkMaxDuration)

			if var_133_53 <= arg_130_1.time_ and arg_130_1.time_ < var_133_53 + var_133_54 then
				arg_130_1.typewritter.percent = (arg_130_1.time_ - var_133_53) / var_133_54

				arg_130_1.typewritter:SetDirty()
			end

			if arg_130_1.time_ >= var_133_53 + var_133_54 and arg_130_1.time_ < var_133_53 + var_133_54 + arg_133_0 then
				arg_130_1.typewritter.percent = 1

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(true)
			end
		end

		arg_130_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_130_1:InitPlayNodeList()
	end,
	Play325542033 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 325542033
		arg_136_1.duration_ = 5

		SetActive(arg_136_1.tipsGo_, false)

		function arg_136_1.onSingleLineFinish_()
			arg_136_1.onSingleLineUpdate_ = nil
			arg_136_1.onSingleLineFinish_ = nil
			arg_136_1.state_ = "waiting"
		end

		function arg_136_1.playNext_(arg_138_0)
			if arg_138_0 == 1 then
				arg_136_0:Play325542034(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			local var_139_0 = 0
			local var_139_1 = 0.725

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

				arg_136_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_136_1.callingController_:SetSelectedState("normal")

				arg_136_1.keyicon_.color = Color.New(1, 1, 1)
				arg_136_1.icon_.color = Color.New(1, 1, 1)

				local var_139_3 = arg_136_1:GetWordFromCfg(325542033)
				local var_139_4 = arg_136_1:FormatText(var_139_3.content)

				arg_136_1.text_.text = var_139_4

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_5 = 29
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
	Play325542034 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 325542034
		arg_140_1.duration_ = 5.93

		SetActive(arg_140_1.tipsGo_, false)

		function arg_140_1.onSingleLineFinish_()
			arg_140_1.onSingleLineUpdate_ = nil
			arg_140_1.onSingleLineFinish_ = nil
			arg_140_1.state_ = "waiting"
		end

		function arg_140_1.playNext_(arg_142_0)
			if arg_142_0 == 1 then
				arg_140_0:Play325542035(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			local var_143_0 = arg_140_1.actors_["1170ui_story"].transform
			local var_143_1 = 0

			if var_143_1 < arg_140_1.time_ and arg_140_1.time_ <= var_143_1 + arg_143_0 then
				arg_140_1.var_.moveOldPos1170ui_story = var_143_0.localPosition

				local var_143_2 = GameObjectTools.GetOrAddComponent(var_143_0.gameObject, typeof(DynamicBoneHelper))

				if var_143_2 then
					var_143_2:EnableDynamicBone(false)
				end
			end

			local var_143_3 = 0.001

			if var_143_1 <= arg_140_1.time_ and arg_140_1.time_ < var_143_1 + var_143_3 then
				local var_143_4 = (arg_140_1.time_ - var_143_1) / var_143_3
				local var_143_5 = Vector3.New(0.03, -0.95, -6.08)

				var_143_0.localPosition = Vector3.Lerp(arg_140_1.var_.moveOldPos1170ui_story, var_143_5, var_143_4)

				local var_143_6 = manager.ui.mainCamera.transform.position - var_143_0.position

				var_143_0.forward = Vector3.New(var_143_6.x, var_143_6.y, var_143_6.z)

				local var_143_7 = var_143_0.localEulerAngles

				var_143_7.z = 0
				var_143_7.x = 0
				var_143_0.localEulerAngles = var_143_7
			end

			if arg_140_1.time_ >= var_143_1 + var_143_3 and arg_140_1.time_ < var_143_1 + var_143_3 + arg_143_0 then
				var_143_0.localPosition = Vector3.New(0.03, -0.95, -6.08)

				local var_143_8 = manager.ui.mainCamera.transform.position - var_143_0.position

				var_143_0.forward = Vector3.New(var_143_8.x, var_143_8.y, var_143_8.z)

				local var_143_9 = var_143_0.localEulerAngles

				var_143_9.z = 0
				var_143_9.x = 0
				var_143_0.localEulerAngles = var_143_9

				local var_143_10 = GameObjectTools.GetOrAddComponent(var_143_0.gameObject, typeof(DynamicBoneHelper))

				if var_143_10 then
					var_143_10:EnableDynamicBone(true)
				end
			end

			local var_143_11 = arg_140_1.actors_["1170ui_story"]
			local var_143_12 = 0

			if var_143_12 < arg_140_1.time_ and arg_140_1.time_ <= var_143_12 + arg_143_0 and not isNil(var_143_11) and arg_140_1.var_.characterEffect1170ui_story == nil then
				arg_140_1.var_.characterEffect1170ui_story = var_143_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_143_13 = 0.200000002980232

			if var_143_12 <= arg_140_1.time_ and arg_140_1.time_ < var_143_12 + var_143_13 and not isNil(var_143_11) then
				local var_143_14 = (arg_140_1.time_ - var_143_12) / var_143_13

				if arg_140_1.var_.characterEffect1170ui_story and not isNil(var_143_11) then
					arg_140_1.var_.characterEffect1170ui_story.fillFlat = false
				end
			end

			if arg_140_1.time_ >= var_143_12 + var_143_13 and arg_140_1.time_ < var_143_12 + var_143_13 + arg_143_0 and not isNil(var_143_11) and arg_140_1.var_.characterEffect1170ui_story then
				arg_140_1.var_.characterEffect1170ui_story.fillFlat = false
			end

			local var_143_15 = 0

			if var_143_15 < arg_140_1.time_ and arg_140_1.time_ <= var_143_15 + arg_143_0 then
				arg_140_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/story1170/story1170action/1170action5_1")
			end

			local var_143_16 = 0
			local var_143_17 = 0.75

			if var_143_16 < arg_140_1.time_ and arg_140_1.time_ <= var_143_16 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, true)

				local var_143_18 = arg_140_1:FormatText(StoryNameCfg[318].name)

				arg_140_1.leftNameTxt_.text = var_143_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_140_1.leftNameTxt_.transform)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1.leftNameTxt_.text)
				SetActive(arg_140_1.iconTrs_.gameObject, false)
				arg_140_1.callingController_:SetSelectedState("normal")

				local var_143_19 = arg_140_1:GetWordFromCfg(325542034)
				local var_143_20 = arg_140_1:FormatText(var_143_19.content)

				arg_140_1.text_.text = var_143_20

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_21 = 30
				local var_143_22 = utf8.len(var_143_20)
				local var_143_23 = var_143_21 <= 0 and var_143_17 or var_143_17 * (var_143_22 / var_143_21)

				if var_143_23 > 0 and var_143_17 < var_143_23 then
					arg_140_1.talkMaxDuration = var_143_23

					if var_143_23 + var_143_16 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_23 + var_143_16
					end
				end

				arg_140_1.text_.text = var_143_20
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325542", "325542034", "story_v_out_325542.awb") ~= 0 then
					local var_143_24 = manager.audio:GetVoiceLength("story_v_out_325542", "325542034", "story_v_out_325542.awb") / 1000

					if var_143_24 + var_143_16 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_24 + var_143_16
					end

					if var_143_19.prefab_name ~= "" and arg_140_1.actors_[var_143_19.prefab_name] ~= nil then
						local var_143_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_140_1.actors_[var_143_19.prefab_name].transform, "story_v_out_325542", "325542034", "story_v_out_325542.awb")

						arg_140_1:RecordAudio("325542034", var_143_25)
						arg_140_1:RecordAudio("325542034", var_143_25)
					else
						arg_140_1:AudioAction("play", "voice", "story_v_out_325542", "325542034", "story_v_out_325542.awb")
					end

					arg_140_1:RecordHistoryTalkVoice("story_v_out_325542", "325542034", "story_v_out_325542.awb")
				end

				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_26 = math.max(var_143_17, arg_140_1.talkMaxDuration)

			if var_143_16 <= arg_140_1.time_ and arg_140_1.time_ < var_143_16 + var_143_26 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_16) / var_143_26

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_16 + var_143_26 and arg_140_1.time_ < var_143_16 + var_143_26 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_140_1:InitPlayNodeList()
	end,
	Play325542035 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 325542035
		arg_144_1.duration_ = 7

		SetActive(arg_144_1.tipsGo_, false)

		function arg_144_1.onSingleLineFinish_()
			arg_144_1.onSingleLineUpdate_ = nil
			arg_144_1.onSingleLineFinish_ = nil
			arg_144_1.state_ = "waiting"
		end

		function arg_144_1.playNext_(arg_146_0)
			if arg_146_0 == 1 then
				arg_144_0:Play325542036(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			local var_147_0 = 0
			local var_147_1 = 0.725

			if var_147_0 < arg_144_1.time_ and arg_144_1.time_ <= var_147_0 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, true)

				local var_147_2 = arg_144_1:FormatText(StoryNameCfg[318].name)

				arg_144_1.leftNameTxt_.text = var_147_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_144_1.leftNameTxt_.transform)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1.leftNameTxt_.text)
				SetActive(arg_144_1.iconTrs_.gameObject, false)
				arg_144_1.callingController_:SetSelectedState("normal")

				local var_147_3 = arg_144_1:GetWordFromCfg(325542035)
				local var_147_4 = arg_144_1:FormatText(var_147_3.content)

				arg_144_1.text_.text = var_147_4

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_5 = 29
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

				if manager.audio:GetVoiceLength("story_v_out_325542", "325542035", "story_v_out_325542.awb") ~= 0 then
					local var_147_8 = manager.audio:GetVoiceLength("story_v_out_325542", "325542035", "story_v_out_325542.awb") / 1000

					if var_147_8 + var_147_0 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_8 + var_147_0
					end

					if var_147_3.prefab_name ~= "" and arg_144_1.actors_[var_147_3.prefab_name] ~= nil then
						local var_147_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_144_1.actors_[var_147_3.prefab_name].transform, "story_v_out_325542", "325542035", "story_v_out_325542.awb")

						arg_144_1:RecordAudio("325542035", var_147_9)
						arg_144_1:RecordAudio("325542035", var_147_9)
					else
						arg_144_1:AudioAction("play", "voice", "story_v_out_325542", "325542035", "story_v_out_325542.awb")
					end

					arg_144_1:RecordHistoryTalkVoice("story_v_out_325542", "325542035", "story_v_out_325542.awb")
				end

				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_10 = math.max(var_147_1, arg_144_1.talkMaxDuration)

			if var_147_0 <= arg_144_1.time_ and arg_144_1.time_ < var_147_0 + var_147_10 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - var_147_0) / var_147_10

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= var_147_0 + var_147_10 and arg_144_1.time_ < var_147_0 + var_147_10 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {}

		arg_144_1:InitPlayNodeList()
	end,
	Play325542036 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 325542036
		arg_148_1.duration_ = 5

		SetActive(arg_148_1.tipsGo_, false)

		function arg_148_1.onSingleLineFinish_()
			arg_148_1.onSingleLineUpdate_ = nil
			arg_148_1.onSingleLineFinish_ = nil
			arg_148_1.state_ = "waiting"
		end

		function arg_148_1.playNext_(arg_150_0)
			if arg_150_0 == 1 then
				arg_148_0:Play325542037(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			local var_151_0 = arg_148_1.actors_["1170ui_story"]
			local var_151_1 = 0

			if var_151_1 < arg_148_1.time_ and arg_148_1.time_ <= var_151_1 + arg_151_0 and not isNil(var_151_0) and arg_148_1.var_.characterEffect1170ui_story == nil then
				arg_148_1.var_.characterEffect1170ui_story = var_151_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_151_2 = 0.200000002980232

			if var_151_1 <= arg_148_1.time_ and arg_148_1.time_ < var_151_1 + var_151_2 and not isNil(var_151_0) then
				local var_151_3 = (arg_148_1.time_ - var_151_1) / var_151_2

				if arg_148_1.var_.characterEffect1170ui_story and not isNil(var_151_0) then
					local var_151_4 = Mathf.Lerp(0, 0.5, var_151_3)

					arg_148_1.var_.characterEffect1170ui_story.fillFlat = true
					arg_148_1.var_.characterEffect1170ui_story.fillRatio = var_151_4
				end
			end

			if arg_148_1.time_ >= var_151_1 + var_151_2 and arg_148_1.time_ < var_151_1 + var_151_2 + arg_151_0 and not isNil(var_151_0) and arg_148_1.var_.characterEffect1170ui_story then
				local var_151_5 = 0.5

				arg_148_1.var_.characterEffect1170ui_story.fillFlat = true
				arg_148_1.var_.characterEffect1170ui_story.fillRatio = var_151_5
			end

			local var_151_6 = 0
			local var_151_7 = 0.925

			if var_151_6 < arg_148_1.time_ and arg_148_1.time_ <= var_151_6 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, true)

				local var_151_8 = arg_148_1:FormatText(StoryNameCfg[7].name)

				arg_148_1.leftNameTxt_.text = var_151_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_148_1.leftNameTxt_.transform)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1.leftNameTxt_.text)
				SetActive(arg_148_1.iconTrs_.gameObject, true)
				arg_148_1.iconController_:SetSelectedState("hero")

				arg_148_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_148_1.callingController_:SetSelectedState("normal")

				arg_148_1.keyicon_.color = Color.New(1, 1, 1)
				arg_148_1.icon_.color = Color.New(1, 1, 1)

				local var_151_9 = arg_148_1:GetWordFromCfg(325542036)
				local var_151_10 = arg_148_1:FormatText(var_151_9.content)

				arg_148_1.text_.text = var_151_10

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_11 = 37
				local var_151_12 = utf8.len(var_151_10)
				local var_151_13 = var_151_11 <= 0 and var_151_7 or var_151_7 * (var_151_12 / var_151_11)

				if var_151_13 > 0 and var_151_7 < var_151_13 then
					arg_148_1.talkMaxDuration = var_151_13

					if var_151_13 + var_151_6 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_13 + var_151_6
					end
				end

				arg_148_1.text_.text = var_151_10
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)
				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_14 = math.max(var_151_7, arg_148_1.talkMaxDuration)

			if var_151_6 <= arg_148_1.time_ and arg_148_1.time_ < var_151_6 + var_151_14 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - var_151_6) / var_151_14

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= var_151_6 + var_151_14 and arg_148_1.time_ < var_151_6 + var_151_14 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {}

		arg_148_1:InitPlayNodeList()
	end,
	Play325542037 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 325542037
		arg_152_1.duration_ = 9.03

		SetActive(arg_152_1.tipsGo_, false)

		function arg_152_1.onSingleLineFinish_()
			arg_152_1.onSingleLineUpdate_ = nil
			arg_152_1.onSingleLineFinish_ = nil
			arg_152_1.state_ = "waiting"
		end

		function arg_152_1.playNext_(arg_154_0)
			if arg_154_0 == 1 then
				arg_152_0:Play325542038(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			local var_155_0 = arg_152_1.actors_["1170ui_story"]
			local var_155_1 = 0

			if var_155_1 < arg_152_1.time_ and arg_152_1.time_ <= var_155_1 + arg_155_0 and not isNil(var_155_0) and arg_152_1.var_.characterEffect1170ui_story == nil then
				arg_152_1.var_.characterEffect1170ui_story = var_155_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_155_2 = 0.200000002980232

			if var_155_1 <= arg_152_1.time_ and arg_152_1.time_ < var_155_1 + var_155_2 and not isNil(var_155_0) then
				local var_155_3 = (arg_152_1.time_ - var_155_1) / var_155_2

				if arg_152_1.var_.characterEffect1170ui_story and not isNil(var_155_0) then
					arg_152_1.var_.characterEffect1170ui_story.fillFlat = false
				end
			end

			if arg_152_1.time_ >= var_155_1 + var_155_2 and arg_152_1.time_ < var_155_1 + var_155_2 + arg_155_0 and not isNil(var_155_0) and arg_152_1.var_.characterEffect1170ui_story then
				arg_152_1.var_.characterEffect1170ui_story.fillFlat = false
			end

			local var_155_4 = 0

			if var_155_4 < arg_152_1.time_ and arg_152_1.time_ <= var_155_4 + arg_155_0 then
				arg_152_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/story1170/story1170action/1170action5_2")
			end

			local var_155_5 = 0
			local var_155_6 = 0.975

			if var_155_5 < arg_152_1.time_ and arg_152_1.time_ <= var_155_5 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, true)

				local var_155_7 = arg_152_1:FormatText(StoryNameCfg[318].name)

				arg_152_1.leftNameTxt_.text = var_155_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_152_1.leftNameTxt_.transform)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1.leftNameTxt_.text)
				SetActive(arg_152_1.iconTrs_.gameObject, false)
				arg_152_1.callingController_:SetSelectedState("normal")

				local var_155_8 = arg_152_1:GetWordFromCfg(325542037)
				local var_155_9 = arg_152_1:FormatText(var_155_8.content)

				arg_152_1.text_.text = var_155_9

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_10 = 39
				local var_155_11 = utf8.len(var_155_9)
				local var_155_12 = var_155_10 <= 0 and var_155_6 or var_155_6 * (var_155_11 / var_155_10)

				if var_155_12 > 0 and var_155_6 < var_155_12 then
					arg_152_1.talkMaxDuration = var_155_12

					if var_155_12 + var_155_5 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_12 + var_155_5
					end
				end

				arg_152_1.text_.text = var_155_9
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325542", "325542037", "story_v_out_325542.awb") ~= 0 then
					local var_155_13 = manager.audio:GetVoiceLength("story_v_out_325542", "325542037", "story_v_out_325542.awb") / 1000

					if var_155_13 + var_155_5 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_13 + var_155_5
					end

					if var_155_8.prefab_name ~= "" and arg_152_1.actors_[var_155_8.prefab_name] ~= nil then
						local var_155_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_152_1.actors_[var_155_8.prefab_name].transform, "story_v_out_325542", "325542037", "story_v_out_325542.awb")

						arg_152_1:RecordAudio("325542037", var_155_14)
						arg_152_1:RecordAudio("325542037", var_155_14)
					else
						arg_152_1:AudioAction("play", "voice", "story_v_out_325542", "325542037", "story_v_out_325542.awb")
					end

					arg_152_1:RecordHistoryTalkVoice("story_v_out_325542", "325542037", "story_v_out_325542.awb")
				end

				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_15 = math.max(var_155_6, arg_152_1.talkMaxDuration)

			if var_155_5 <= arg_152_1.time_ and arg_152_1.time_ < var_155_5 + var_155_15 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - var_155_5) / var_155_15

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= var_155_5 + var_155_15 and arg_152_1.time_ < var_155_5 + var_155_15 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {}

		arg_152_1:InitPlayNodeList()
	end,
	Play325542038 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 325542038
		arg_156_1.duration_ = 3.1

		SetActive(arg_156_1.tipsGo_, false)

		function arg_156_1.onSingleLineFinish_()
			arg_156_1.onSingleLineUpdate_ = nil
			arg_156_1.onSingleLineFinish_ = nil
			arg_156_1.state_ = "waiting"
		end

		function arg_156_1.playNext_(arg_158_0)
			if arg_158_0 == 1 then
				arg_156_0:Play325542039(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			local var_159_0 = 0
			local var_159_1 = 0.4

			if var_159_0 < arg_156_1.time_ and arg_156_1.time_ <= var_159_0 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, true)

				local var_159_2 = arg_156_1:FormatText(StoryNameCfg[318].name)

				arg_156_1.leftNameTxt_.text = var_159_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_156_1.leftNameTxt_.transform)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1.leftNameTxt_.text)
				SetActive(arg_156_1.iconTrs_.gameObject, false)
				arg_156_1.callingController_:SetSelectedState("normal")

				local var_159_3 = arg_156_1:GetWordFromCfg(325542038)
				local var_159_4 = arg_156_1:FormatText(var_159_3.content)

				arg_156_1.text_.text = var_159_4

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_5 = 16
				local var_159_6 = utf8.len(var_159_4)
				local var_159_7 = var_159_5 <= 0 and var_159_1 or var_159_1 * (var_159_6 / var_159_5)

				if var_159_7 > 0 and var_159_1 < var_159_7 then
					arg_156_1.talkMaxDuration = var_159_7

					if var_159_7 + var_159_0 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_7 + var_159_0
					end
				end

				arg_156_1.text_.text = var_159_4
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325542", "325542038", "story_v_out_325542.awb") ~= 0 then
					local var_159_8 = manager.audio:GetVoiceLength("story_v_out_325542", "325542038", "story_v_out_325542.awb") / 1000

					if var_159_8 + var_159_0 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_8 + var_159_0
					end

					if var_159_3.prefab_name ~= "" and arg_156_1.actors_[var_159_3.prefab_name] ~= nil then
						local var_159_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_156_1.actors_[var_159_3.prefab_name].transform, "story_v_out_325542", "325542038", "story_v_out_325542.awb")

						arg_156_1:RecordAudio("325542038", var_159_9)
						arg_156_1:RecordAudio("325542038", var_159_9)
					else
						arg_156_1:AudioAction("play", "voice", "story_v_out_325542", "325542038", "story_v_out_325542.awb")
					end

					arg_156_1:RecordHistoryTalkVoice("story_v_out_325542", "325542038", "story_v_out_325542.awb")
				end

				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_10 = math.max(var_159_1, arg_156_1.talkMaxDuration)

			if var_159_0 <= arg_156_1.time_ and arg_156_1.time_ < var_159_0 + var_159_10 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - var_159_0) / var_159_10

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= var_159_0 + var_159_10 and arg_156_1.time_ < var_159_0 + var_159_10 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {}

		arg_156_1:InitPlayNodeList()
	end,
	Play325542039 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 325542039
		arg_160_1.duration_ = 5

		SetActive(arg_160_1.tipsGo_, false)

		function arg_160_1.onSingleLineFinish_()
			arg_160_1.onSingleLineUpdate_ = nil
			arg_160_1.onSingleLineFinish_ = nil
			arg_160_1.state_ = "waiting"
		end

		function arg_160_1.playNext_(arg_162_0)
			if arg_162_0 == 1 then
				arg_160_0:Play325542040(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			local var_163_0 = arg_160_1.actors_["1170ui_story"]
			local var_163_1 = 0

			if var_163_1 < arg_160_1.time_ and arg_160_1.time_ <= var_163_1 + arg_163_0 and not isNil(var_163_0) and arg_160_1.var_.characterEffect1170ui_story == nil then
				arg_160_1.var_.characterEffect1170ui_story = var_163_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_163_2 = 0.200000002980232

			if var_163_1 <= arg_160_1.time_ and arg_160_1.time_ < var_163_1 + var_163_2 and not isNil(var_163_0) then
				local var_163_3 = (arg_160_1.time_ - var_163_1) / var_163_2

				if arg_160_1.var_.characterEffect1170ui_story and not isNil(var_163_0) then
					local var_163_4 = Mathf.Lerp(0, 0.5, var_163_3)

					arg_160_1.var_.characterEffect1170ui_story.fillFlat = true
					arg_160_1.var_.characterEffect1170ui_story.fillRatio = var_163_4
				end
			end

			if arg_160_1.time_ >= var_163_1 + var_163_2 and arg_160_1.time_ < var_163_1 + var_163_2 + arg_163_0 and not isNil(var_163_0) and arg_160_1.var_.characterEffect1170ui_story then
				local var_163_5 = 0.5

				arg_160_1.var_.characterEffect1170ui_story.fillFlat = true
				arg_160_1.var_.characterEffect1170ui_story.fillRatio = var_163_5
			end

			local var_163_6 = 0
			local var_163_7 = 0.875

			if var_163_6 < arg_160_1.time_ and arg_160_1.time_ <= var_163_6 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0
				arg_160_1.dialogCg_.alpha = 1

				arg_160_1.dialog_:SetActive(true)
				SetActive(arg_160_1.leftNameGo_, true)

				local var_163_8 = arg_160_1:FormatText(StoryNameCfg[7].name)

				arg_160_1.leftNameTxt_.text = var_163_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_160_1.leftNameTxt_.transform)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1.leftNameTxt_.text)
				SetActive(arg_160_1.iconTrs_.gameObject, true)
				arg_160_1.iconController_:SetSelectedState("hero")

				arg_160_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_160_1.callingController_:SetSelectedState("normal")

				arg_160_1.keyicon_.color = Color.New(1, 1, 1)
				arg_160_1.icon_.color = Color.New(1, 1, 1)

				local var_163_9 = arg_160_1:GetWordFromCfg(325542039)
				local var_163_10 = arg_160_1:FormatText(var_163_9.content)

				arg_160_1.text_.text = var_163_10

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_11 = 35
				local var_163_12 = utf8.len(var_163_10)
				local var_163_13 = var_163_11 <= 0 and var_163_7 or var_163_7 * (var_163_12 / var_163_11)

				if var_163_13 > 0 and var_163_7 < var_163_13 then
					arg_160_1.talkMaxDuration = var_163_13

					if var_163_13 + var_163_6 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_13 + var_163_6
					end
				end

				arg_160_1.text_.text = var_163_10
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)
				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_14 = math.max(var_163_7, arg_160_1.talkMaxDuration)

			if var_163_6 <= arg_160_1.time_ and arg_160_1.time_ < var_163_6 + var_163_14 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - var_163_6) / var_163_14

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= var_163_6 + var_163_14 and arg_160_1.time_ < var_163_6 + var_163_14 + arg_163_0 then
				arg_160_1.typewritter.percent = 1

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(true)
			end
		end

		arg_160_1.nodeConfigList_ = {}

		arg_160_1:InitPlayNodeList()
	end,
	Play325542040 = function(arg_164_0, arg_164_1)
		arg_164_1.time_ = 0
		arg_164_1.frameCnt_ = 0
		arg_164_1.state_ = "playing"
		arg_164_1.curTalkId_ = 325542040
		arg_164_1.duration_ = 5

		SetActive(arg_164_1.tipsGo_, false)

		function arg_164_1.onSingleLineFinish_()
			arg_164_1.onSingleLineUpdate_ = nil
			arg_164_1.onSingleLineFinish_ = nil
			arg_164_1.state_ = "waiting"
		end

		function arg_164_1.playNext_(arg_166_0)
			if arg_166_0 == 1 then
				arg_164_0:Play325542041(arg_164_1)
			end
		end

		function arg_164_1.onSingleLineUpdate_(arg_167_0)
			local var_167_0 = 0
			local var_167_1 = 0.65

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

				local var_167_3 = arg_164_1:GetWordFromCfg(325542040)
				local var_167_4 = arg_164_1:FormatText(var_167_3.content)

				arg_164_1.text_.text = var_167_4

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_5 = 26
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
	Play325542041 = function(arg_168_0, arg_168_1)
		arg_168_1.time_ = 0
		arg_168_1.frameCnt_ = 0
		arg_168_1.state_ = "playing"
		arg_168_1.curTalkId_ = 325542041
		arg_168_1.duration_ = 2.83

		SetActive(arg_168_1.tipsGo_, false)

		function arg_168_1.onSingleLineFinish_()
			arg_168_1.onSingleLineUpdate_ = nil
			arg_168_1.onSingleLineFinish_ = nil
			arg_168_1.state_ = "waiting"
		end

		function arg_168_1.playNext_(arg_170_0)
			if arg_170_0 == 1 then
				arg_168_0:Play325542042(arg_168_1)
			end
		end

		function arg_168_1.onSingleLineUpdate_(arg_171_0)
			local var_171_0 = arg_168_1.actors_["1170ui_story"]
			local var_171_1 = 0

			if var_171_1 < arg_168_1.time_ and arg_168_1.time_ <= var_171_1 + arg_171_0 and not isNil(var_171_0) and arg_168_1.var_.characterEffect1170ui_story == nil then
				arg_168_1.var_.characterEffect1170ui_story = var_171_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_171_2 = 0.200000002980232

			if var_171_1 <= arg_168_1.time_ and arg_168_1.time_ < var_171_1 + var_171_2 and not isNil(var_171_0) then
				local var_171_3 = (arg_168_1.time_ - var_171_1) / var_171_2

				if arg_168_1.var_.characterEffect1170ui_story and not isNil(var_171_0) then
					arg_168_1.var_.characterEffect1170ui_story.fillFlat = false
				end
			end

			if arg_168_1.time_ >= var_171_1 + var_171_2 and arg_168_1.time_ < var_171_1 + var_171_2 + arg_171_0 and not isNil(var_171_0) and arg_168_1.var_.characterEffect1170ui_story then
				arg_168_1.var_.characterEffect1170ui_story.fillFlat = false
			end

			local var_171_4 = 0

			if var_171_4 < arg_168_1.time_ and arg_168_1.time_ <= var_171_4 + arg_171_0 then
				arg_168_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/story1170/story1170action/1170action8_1")
			end

			local var_171_5 = 0
			local var_171_6 = 0.35

			if var_171_5 < arg_168_1.time_ and arg_168_1.time_ <= var_171_5 + arg_171_0 then
				arg_168_1.talkMaxDuration = 0
				arg_168_1.dialogCg_.alpha = 1

				arg_168_1.dialog_:SetActive(true)
				SetActive(arg_168_1.leftNameGo_, true)

				local var_171_7 = arg_168_1:FormatText(StoryNameCfg[318].name)

				arg_168_1.leftNameTxt_.text = var_171_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_168_1.leftNameTxt_.transform)

				arg_168_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_168_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_168_1:RecordName(arg_168_1.leftNameTxt_.text)
				SetActive(arg_168_1.iconTrs_.gameObject, false)
				arg_168_1.callingController_:SetSelectedState("normal")

				local var_171_8 = arg_168_1:GetWordFromCfg(325542041)
				local var_171_9 = arg_168_1:FormatText(var_171_8.content)

				arg_168_1.text_.text = var_171_9

				LuaForUtil.ClearLinePrefixSymbol(arg_168_1.text_)

				local var_171_10 = 14
				local var_171_11 = utf8.len(var_171_9)
				local var_171_12 = var_171_10 <= 0 and var_171_6 or var_171_6 * (var_171_11 / var_171_10)

				if var_171_12 > 0 and var_171_6 < var_171_12 then
					arg_168_1.talkMaxDuration = var_171_12

					if var_171_12 + var_171_5 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_12 + var_171_5
					end
				end

				arg_168_1.text_.text = var_171_9
				arg_168_1.typewritter.percent = 0

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325542", "325542041", "story_v_out_325542.awb") ~= 0 then
					local var_171_13 = manager.audio:GetVoiceLength("story_v_out_325542", "325542041", "story_v_out_325542.awb") / 1000

					if var_171_13 + var_171_5 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_13 + var_171_5
					end

					if var_171_8.prefab_name ~= "" and arg_168_1.actors_[var_171_8.prefab_name] ~= nil then
						local var_171_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_168_1.actors_[var_171_8.prefab_name].transform, "story_v_out_325542", "325542041", "story_v_out_325542.awb")

						arg_168_1:RecordAudio("325542041", var_171_14)
						arg_168_1:RecordAudio("325542041", var_171_14)
					else
						arg_168_1:AudioAction("play", "voice", "story_v_out_325542", "325542041", "story_v_out_325542.awb")
					end

					arg_168_1:RecordHistoryTalkVoice("story_v_out_325542", "325542041", "story_v_out_325542.awb")
				end

				arg_168_1:RecordContent(arg_168_1.text_.text)
			end

			local var_171_15 = math.max(var_171_6, arg_168_1.talkMaxDuration)

			if var_171_5 <= arg_168_1.time_ and arg_168_1.time_ < var_171_5 + var_171_15 then
				arg_168_1.typewritter.percent = (arg_168_1.time_ - var_171_5) / var_171_15

				arg_168_1.typewritter:SetDirty()
			end

			if arg_168_1.time_ >= var_171_5 + var_171_15 and arg_168_1.time_ < var_171_5 + var_171_15 + arg_171_0 then
				arg_168_1.typewritter.percent = 1

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(true)
			end
		end

		arg_168_1.nodeConfigList_ = {}

		arg_168_1:InitPlayNodeList()
	end,
	Play325542042 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 325542042
		arg_172_1.duration_ = 2.03

		SetActive(arg_172_1.tipsGo_, false)

		function arg_172_1.onSingleLineFinish_()
			arg_172_1.onSingleLineUpdate_ = nil
			arg_172_1.onSingleLineFinish_ = nil
			arg_172_1.state_ = "waiting"
			arg_172_1.auto_ = false
		end

		function arg_172_1.playNext_(arg_174_0)
			arg_172_1.onStoryFinished_()
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			local var_175_0 = 0
			local var_175_1 = 1

			if var_175_0 < arg_172_1.time_ and arg_172_1.time_ <= var_175_0 + arg_175_0 then
				local var_175_2 = "play"
				local var_175_3 = "effect"

				arg_172_1:AudioAction(var_175_2, var_175_3, "ui_battle", "ui_battle_stopbgm", "")
			end

			local var_175_4 = 0
			local var_175_5 = 0.2

			if var_175_4 < arg_172_1.time_ and arg_172_1.time_ <= var_175_4 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0
				arg_172_1.dialogCg_.alpha = 1

				arg_172_1.dialog_:SetActive(true)
				SetActive(arg_172_1.leftNameGo_, true)

				local var_175_6 = arg_172_1:FormatText(StoryNameCfg[318].name)

				arg_172_1.leftNameTxt_.text = var_175_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_172_1.leftNameTxt_.transform)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1.leftNameTxt_.text)
				SetActive(arg_172_1.iconTrs_.gameObject, false)
				arg_172_1.callingController_:SetSelectedState("normal")

				local var_175_7 = arg_172_1:GetWordFromCfg(325542042)
				local var_175_8 = arg_172_1:FormatText(var_175_7.content)

				arg_172_1.text_.text = var_175_8

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_9 = 8
				local var_175_10 = utf8.len(var_175_8)
				local var_175_11 = var_175_9 <= 0 and var_175_5 or var_175_5 * (var_175_10 / var_175_9)

				if var_175_11 > 0 and var_175_5 < var_175_11 then
					arg_172_1.talkMaxDuration = var_175_11

					if var_175_11 + var_175_4 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_11 + var_175_4
					end
				end

				arg_172_1.text_.text = var_175_8
				arg_172_1.typewritter.percent = 0

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325542", "325542042", "story_v_out_325542.awb") ~= 0 then
					local var_175_12 = manager.audio:GetVoiceLength("story_v_out_325542", "325542042", "story_v_out_325542.awb") / 1000

					if var_175_12 + var_175_4 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_12 + var_175_4
					end

					if var_175_7.prefab_name ~= "" and arg_172_1.actors_[var_175_7.prefab_name] ~= nil then
						local var_175_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_172_1.actors_[var_175_7.prefab_name].transform, "story_v_out_325542", "325542042", "story_v_out_325542.awb")

						arg_172_1:RecordAudio("325542042", var_175_13)
						arg_172_1:RecordAudio("325542042", var_175_13)
					else
						arg_172_1:AudioAction("play", "voice", "story_v_out_325542", "325542042", "story_v_out_325542.awb")
					end

					arg_172_1:RecordHistoryTalkVoice("story_v_out_325542", "325542042", "story_v_out_325542.awb")
				end

				arg_172_1:RecordContent(arg_172_1.text_.text)
			end

			local var_175_14 = math.max(var_175_5, arg_172_1.talkMaxDuration)

			if var_175_4 <= arg_172_1.time_ and arg_172_1.time_ < var_175_4 + var_175_14 then
				arg_172_1.typewritter.percent = (arg_172_1.time_ - var_175_4) / var_175_14

				arg_172_1.typewritter:SetDirty()
			end

			if arg_172_1.time_ >= var_175_4 + var_175_14 and arg_172_1.time_ < var_175_4 + var_175_14 + arg_175_0 then
				arg_172_1.typewritter.percent = 1

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(true)
			end
		end

		arg_172_1.nodeConfigList_ = {}

		arg_172_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/J03f",
		"TextureConfig/Background/J28f"
	},
	voices = {
		"story_v_out_325542.awb"
	}
}
