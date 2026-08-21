return {
	Play319271001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 319271001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play319271002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "I11i"

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
				local var_4_5 = arg_1_1.bgs_.I11i

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
					if iter_4_0 ~= "I11i" then
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
			local var_4_23 = 0.2

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

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_28 = 2
			local var_4_29 = 0.05

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_30 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_30:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_30:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_30:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_31 = arg_1_1:FormatText(StoryNameCfg[720].name)

				arg_1_1.leftNameTxt_.text = var_4_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4041")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_32 = arg_1_1:GetWordFromCfg(319271001)
				local var_4_33 = arg_1_1:FormatText(var_4_32.content)

				arg_1_1.text_.text = var_4_33

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_34 = 2
				local var_4_35 = utf8.len(var_4_33)
				local var_4_36 = var_4_34 <= 0 and var_4_29 or var_4_29 * (var_4_35 / var_4_34)

				if var_4_36 > 0 and var_4_29 < var_4_36 then
					arg_1_1.talkMaxDuration = var_4_36
					var_4_28 = var_4_28 + 0.3

					if var_4_36 + var_4_28 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_36 + var_4_28
					end
				end

				arg_1_1.text_.text = var_4_33
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_37 = var_4_28 + 0.3
			local var_4_38 = math.max(var_4_29, arg_1_1.talkMaxDuration)

			if var_4_37 <= arg_1_1.time_ and arg_1_1.time_ < var_4_37 + var_4_38 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_37) / var_4_38

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_37 + var_4_38 and arg_1_1.time_ < var_4_37 + var_4_38 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play319271002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 319271002
		arg_8_1.duration_ = 7.13

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play319271003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 0

			if var_11_0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_0 + arg_11_0 then
				arg_8_1.mask_.enabled = true
				arg_8_1.mask_.raycastTarget = false

				arg_8_1:SetGaussion(false)
			end

			local var_11_1 = 1.16666666666667

			if var_11_0 <= arg_8_1.time_ and arg_8_1.time_ < var_11_0 + var_11_1 then
				local var_11_2 = (arg_8_1.time_ - var_11_0) / var_11_1
				local var_11_3 = Color.New(1, 1, 1)

				var_11_3.a = Mathf.Lerp(1, 0, var_11_2)
				arg_8_1.mask_.color = var_11_3
			end

			if arg_8_1.time_ >= var_11_0 + var_11_1 and arg_8_1.time_ < var_11_0 + var_11_1 + arg_11_0 then
				local var_11_4 = Color.New(1, 1, 1)
				local var_11_5 = 0

				arg_8_1.mask_.enabled = false
				var_11_4.a = var_11_5
				arg_8_1.mask_.color = var_11_4
			end

			local var_11_6 = manager.ui.mainCamera.transform
			local var_11_7 = 1

			if var_11_7 < arg_8_1.time_ and arg_8_1.time_ <= var_11_7 + arg_11_0 then
				local var_11_8 = arg_8_1.var_.effect119
				local var_11_9
				local var_11_10 = var_11_6

				if not var_11_8 then
					var_11_8 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_error"), var_11_10)
					var_11_8.name = "119"
					arg_8_1.var_.effect119 = var_11_8
				else
					var_11_8.transform:SetParent(var_11_10)
				end

				var_11_8.transform.localPosition = Vector3.New(0, 0, 0)
				var_11_8.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if arg_8_1.frameCnt_ <= 1 then
				arg_8_1.dialog_:SetActive(false)
			end

			local var_11_11 = 2.13333333333333
			local var_11_12 = 1.3

			if var_11_11 < arg_8_1.time_ and arg_8_1.time_ <= var_11_11 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0

				arg_8_1.dialog_:SetActive(true)

				arg_8_1.dialogCg_.alpha = 0

				local var_11_13 = LeanTween.value(arg_8_1.dialog_, 0, 1, 0.3)

				var_11_13:setOnUpdate(LuaHelper.FloatAction(function(arg_12_0)
					arg_8_1.dialogCg_.alpha = arg_12_0
				end))
				var_11_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_8_1.dialog_)
					var_11_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_8_1.duration_ = arg_8_1.duration_ + 0.3

				SetActive(arg_8_1.leftNameGo_, false)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_14 = arg_8_1:GetWordFromCfg(319271002)
				local var_11_15 = arg_8_1:FormatText(var_11_14.content)

				arg_8_1.text_.text = var_11_15

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_16 = 52
				local var_11_17 = utf8.len(var_11_15)
				local var_11_18 = var_11_16 <= 0 and var_11_12 or var_11_12 * (var_11_17 / var_11_16)

				if var_11_18 > 0 and var_11_12 < var_11_18 then
					arg_8_1.talkMaxDuration = var_11_18
					var_11_11 = var_11_11 + 0.3

					if var_11_18 + var_11_11 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_18 + var_11_11
					end
				end

				arg_8_1.text_.text = var_11_15
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)
				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_19 = var_11_11 + 0.3
			local var_11_20 = math.max(var_11_12, arg_8_1.talkMaxDuration)

			if var_11_19 <= arg_8_1.time_ and arg_8_1.time_ < var_11_19 + var_11_20 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_19) / var_11_20

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_19 + var_11_20 and arg_8_1.time_ < var_11_19 + var_11_20 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play319271003 = function(arg_14_0, arg_14_1)
		arg_14_1.time_ = 0
		arg_14_1.frameCnt_ = 0
		arg_14_1.state_ = "playing"
		arg_14_1.curTalkId_ = 319271003
		arg_14_1.duration_ = 5

		SetActive(arg_14_1.tipsGo_, false)

		function arg_14_1.onSingleLineFinish_()
			arg_14_1.onSingleLineUpdate_ = nil
			arg_14_1.onSingleLineFinish_ = nil
			arg_14_1.state_ = "waiting"
		end

		function arg_14_1.playNext_(arg_16_0)
			if arg_16_0 == 1 then
				arg_14_0:Play319271004(arg_14_1)
			end
		end

		function arg_14_1.onSingleLineUpdate_(arg_17_0)
			local var_17_0 = manager.ui.mainCamera.transform
			local var_17_1 = 0

			if var_17_1 < arg_14_1.time_ and arg_14_1.time_ <= var_17_1 + arg_17_0 then
				local var_17_2 = arg_14_1.var_.effect119

				if var_17_2 then
					Object.Destroy(var_17_2)

					arg_14_1.var_.effect119 = nil
				end
			end

			local var_17_3 = 0
			local var_17_4 = 1.425

			if var_17_3 < arg_14_1.time_ and arg_14_1.time_ <= var_17_3 + arg_17_0 then
				arg_14_1.talkMaxDuration = 0
				arg_14_1.dialogCg_.alpha = 1

				arg_14_1.dialog_:SetActive(true)
				SetActive(arg_14_1.leftNameGo_, false)

				arg_14_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_14_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_14_1:RecordName(arg_14_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_14_1.iconTrs_.gameObject, false)
				arg_14_1.callingController_:SetSelectedState("normal")

				local var_17_5 = arg_14_1:GetWordFromCfg(319271003)
				local var_17_6 = arg_14_1:FormatText(var_17_5.content)

				arg_14_1.text_.text = var_17_6

				LuaForUtil.ClearLinePrefixSymbol(arg_14_1.text_)

				local var_17_7 = 57
				local var_17_8 = utf8.len(var_17_6)
				local var_17_9 = var_17_7 <= 0 and var_17_4 or var_17_4 * (var_17_8 / var_17_7)

				if var_17_9 > 0 and var_17_4 < var_17_9 then
					arg_14_1.talkMaxDuration = var_17_9

					if var_17_9 + var_17_3 > arg_14_1.duration_ then
						arg_14_1.duration_ = var_17_9 + var_17_3
					end
				end

				arg_14_1.text_.text = var_17_6
				arg_14_1.typewritter.percent = 0

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(false)
				arg_14_1:RecordContent(arg_14_1.text_.text)
			end

			local var_17_10 = math.max(var_17_4, arg_14_1.talkMaxDuration)

			if var_17_3 <= arg_14_1.time_ and arg_14_1.time_ < var_17_3 + var_17_10 then
				arg_14_1.typewritter.percent = (arg_14_1.time_ - var_17_3) / var_17_10

				arg_14_1.typewritter:SetDirty()
			end

			if arg_14_1.time_ >= var_17_3 + var_17_10 and arg_14_1.time_ < var_17_3 + var_17_10 + arg_17_0 then
				arg_14_1.typewritter.percent = 1

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(true)
			end
		end

		arg_14_1.nodeConfigList_ = {}

		arg_14_1:InitPlayNodeList()
	end,
	Play319271004 = function(arg_18_0, arg_18_1)
		arg_18_1.time_ = 0
		arg_18_1.frameCnt_ = 0
		arg_18_1.state_ = "playing"
		arg_18_1.curTalkId_ = 319271004
		arg_18_1.duration_ = 5

		SetActive(arg_18_1.tipsGo_, false)

		function arg_18_1.onSingleLineFinish_()
			arg_18_1.onSingleLineUpdate_ = nil
			arg_18_1.onSingleLineFinish_ = nil
			arg_18_1.state_ = "waiting"
		end

		function arg_18_1.playNext_(arg_20_0)
			if arg_20_0 == 1 then
				arg_18_0:Play319271005(arg_18_1)
			end
		end

		function arg_18_1.onSingleLineUpdate_(arg_21_0)
			local var_21_0 = 0
			local var_21_1 = 1.8

			if var_21_0 < arg_18_1.time_ and arg_18_1.time_ <= var_21_0 + arg_21_0 then
				arg_18_1.talkMaxDuration = 0
				arg_18_1.dialogCg_.alpha = 1

				arg_18_1.dialog_:SetActive(true)
				SetActive(arg_18_1.leftNameGo_, false)

				arg_18_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_18_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_18_1:RecordName(arg_18_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_18_1.iconTrs_.gameObject, false)
				arg_18_1.callingController_:SetSelectedState("normal")

				local var_21_2 = arg_18_1:GetWordFromCfg(319271004)
				local var_21_3 = arg_18_1:FormatText(var_21_2.content)

				arg_18_1.text_.text = var_21_3

				LuaForUtil.ClearLinePrefixSymbol(arg_18_1.text_)

				local var_21_4 = 72
				local var_21_5 = utf8.len(var_21_3)
				local var_21_6 = var_21_4 <= 0 and var_21_1 or var_21_1 * (var_21_5 / var_21_4)

				if var_21_6 > 0 and var_21_1 < var_21_6 then
					arg_18_1.talkMaxDuration = var_21_6

					if var_21_6 + var_21_0 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_6 + var_21_0
					end
				end

				arg_18_1.text_.text = var_21_3
				arg_18_1.typewritter.percent = 0

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(false)
				arg_18_1:RecordContent(arg_18_1.text_.text)
			end

			local var_21_7 = math.max(var_21_1, arg_18_1.talkMaxDuration)

			if var_21_0 <= arg_18_1.time_ and arg_18_1.time_ < var_21_0 + var_21_7 then
				arg_18_1.typewritter.percent = (arg_18_1.time_ - var_21_0) / var_21_7

				arg_18_1.typewritter:SetDirty()
			end

			if arg_18_1.time_ >= var_21_0 + var_21_7 and arg_18_1.time_ < var_21_0 + var_21_7 + arg_21_0 then
				arg_18_1.typewritter.percent = 1

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(true)
			end
		end

		arg_18_1.nodeConfigList_ = {}

		arg_18_1:InitPlayNodeList()
	end,
	Play319271005 = function(arg_22_0, arg_22_1)
		arg_22_1.time_ = 0
		arg_22_1.frameCnt_ = 0
		arg_22_1.state_ = "playing"
		arg_22_1.curTalkId_ = 319271005
		arg_22_1.duration_ = 2.97

		local var_22_0 = {
			zh = 2.966,
			ja = 1.733
		}
		local var_22_1 = manager.audio:GetLocalizationFlag()

		if var_22_0[var_22_1] ~= nil then
			arg_22_1.duration_ = var_22_0[var_22_1]
		end

		SetActive(arg_22_1.tipsGo_, false)

		function arg_22_1.onSingleLineFinish_()
			arg_22_1.onSingleLineUpdate_ = nil
			arg_22_1.onSingleLineFinish_ = nil
			arg_22_1.state_ = "waiting"
		end

		function arg_22_1.playNext_(arg_24_0)
			if arg_24_0 == 1 then
				arg_22_0:Play319271006(arg_22_1)
			end
		end

		function arg_22_1.onSingleLineUpdate_(arg_25_0)
			local var_25_0 = 0
			local var_25_1 = 0.2

			if var_25_0 < arg_22_1.time_ and arg_22_1.time_ <= var_25_0 + arg_25_0 then
				local var_25_2 = "play"
				local var_25_3 = "music"

				arg_22_1:AudioAction(var_25_2, var_25_3, "ui_battle", "ui_battle_stopbgm", "")

				local var_25_4 = ""
				local var_25_5 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_25_5 ~= "" then
					if arg_22_1.bgmTxt_.text ~= var_25_5 and arg_22_1.bgmTxt_.text ~= "" then
						if arg_22_1.bgmTxt2_.text ~= "" then
							arg_22_1.bgmTxt_.text = arg_22_1.bgmTxt2_.text
						end

						arg_22_1.bgmTxt2_.text = var_25_5

						arg_22_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_22_1.bgmTxt_.text = var_25_5
						arg_22_1.bgmTxt2_.text = var_25_5
					end

					if arg_22_1.bgmTimer then
						arg_22_1.bgmTimer:Stop()

						arg_22_1.bgmTimer = nil
					end

					if arg_22_1.settingData.show_music_name == 1 then
						arg_22_1.musicController:SetSelectedState("show")
						arg_22_1.musicAnimator_:Play("open", 0, 0)

						if arg_22_1.settingData.music_time ~= 0 then
							arg_22_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_22_1.settingData.music_time), function()
								if arg_22_1 == nil or isNil(arg_22_1.bgmTxt_) then
									return
								end

								arg_22_1.musicController:SetSelectedState("hide")
								arg_22_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_25_6 = 0.233333333333333
			local var_25_7 = 1

			if var_25_6 < arg_22_1.time_ and arg_22_1.time_ <= var_25_6 + arg_25_0 then
				local var_25_8 = "play"
				local var_25_9 = "music"

				arg_22_1:AudioAction(var_25_8, var_25_9, "bgm_activity_3_0_story_intense_argue", "bgm_activity_3_0_story_intense_argue", "bgm_activity_3_0_story_intense_argue.awb")

				local var_25_10 = ""
				local var_25_11 = manager.audio:GetAudioName("bgm_activity_3_0_story_intense_argue", "bgm_activity_3_0_story_intense_argue")

				if var_25_11 ~= "" then
					if arg_22_1.bgmTxt_.text ~= var_25_11 and arg_22_1.bgmTxt_.text ~= "" then
						if arg_22_1.bgmTxt2_.text ~= "" then
							arg_22_1.bgmTxt_.text = arg_22_1.bgmTxt2_.text
						end

						arg_22_1.bgmTxt2_.text = var_25_11

						arg_22_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_22_1.bgmTxt_.text = var_25_11
						arg_22_1.bgmTxt2_.text = var_25_11
					end

					if arg_22_1.bgmTimer then
						arg_22_1.bgmTimer:Stop()

						arg_22_1.bgmTimer = nil
					end

					if arg_22_1.settingData.show_music_name == 1 then
						arg_22_1.musicController:SetSelectedState("show")
						arg_22_1.musicAnimator_:Play("open", 0, 0)

						if arg_22_1.settingData.music_time ~= 0 then
							arg_22_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_22_1.settingData.music_time), function()
								if arg_22_1 == nil or isNil(arg_22_1.bgmTxt_) then
									return
								end

								arg_22_1.musicController:SetSelectedState("hide")
								arg_22_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_25_12 = 0
			local var_25_13 = 0.275

			if var_25_12 < arg_22_1.time_ and arg_22_1.time_ <= var_25_12 + arg_25_0 then
				arg_22_1.talkMaxDuration = 0
				arg_22_1.dialogCg_.alpha = 1

				arg_22_1.dialog_:SetActive(true)
				SetActive(arg_22_1.leftNameGo_, true)

				local var_25_14 = arg_22_1:FormatText(StoryNameCfg[694].name)

				arg_22_1.leftNameTxt_.text = var_25_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_22_1.leftNameTxt_.transform)

				arg_22_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_22_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_22_1:RecordName(arg_22_1.leftNameTxt_.text)
				SetActive(arg_22_1.iconTrs_.gameObject, true)
				arg_22_1.iconController_:SetSelectedState("hero")

				arg_22_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10091")

				arg_22_1.callingController_:SetSelectedState("normal")

				arg_22_1.keyicon_.color = Color.New(1, 1, 1)
				arg_22_1.icon_.color = Color.New(1, 1, 1)

				local var_25_15 = arg_22_1:GetWordFromCfg(319271005)
				local var_25_16 = arg_22_1:FormatText(var_25_15.content)

				arg_22_1.text_.text = var_25_16

				LuaForUtil.ClearLinePrefixSymbol(arg_22_1.text_)

				local var_25_17 = 11
				local var_25_18 = utf8.len(var_25_16)
				local var_25_19 = var_25_17 <= 0 and var_25_13 or var_25_13 * (var_25_18 / var_25_17)

				if var_25_19 > 0 and var_25_13 < var_25_19 then
					arg_22_1.talkMaxDuration = var_25_19

					if var_25_19 + var_25_12 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_19 + var_25_12
					end
				end

				arg_22_1.text_.text = var_25_16
				arg_22_1.typewritter.percent = 0

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319271", "319271005", "story_v_out_319271.awb") ~= 0 then
					local var_25_20 = manager.audio:GetVoiceLength("story_v_out_319271", "319271005", "story_v_out_319271.awb") / 1000

					if var_25_20 + var_25_12 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_20 + var_25_12
					end

					if var_25_15.prefab_name ~= "" and arg_22_1.actors_[var_25_15.prefab_name] ~= nil then
						local var_25_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_22_1.actors_[var_25_15.prefab_name].transform, "story_v_out_319271", "319271005", "story_v_out_319271.awb")

						arg_22_1:RecordAudio("319271005", var_25_21)
						arg_22_1:RecordAudio("319271005", var_25_21)
					else
						arg_22_1:AudioAction("play", "voice", "story_v_out_319271", "319271005", "story_v_out_319271.awb")
					end

					arg_22_1:RecordHistoryTalkVoice("story_v_out_319271", "319271005", "story_v_out_319271.awb")
				end

				arg_22_1:RecordContent(arg_22_1.text_.text)
			end

			local var_25_22 = math.max(var_25_13, arg_22_1.talkMaxDuration)

			if var_25_12 <= arg_22_1.time_ and arg_22_1.time_ < var_25_12 + var_25_22 then
				arg_22_1.typewritter.percent = (arg_22_1.time_ - var_25_12) / var_25_22

				arg_22_1.typewritter:SetDirty()
			end

			if arg_22_1.time_ >= var_25_12 + var_25_22 and arg_22_1.time_ < var_25_12 + var_25_22 + arg_25_0 then
				arg_22_1.typewritter.percent = 1

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(true)
			end
		end

		arg_22_1.nodeConfigList_ = {}

		arg_22_1:InitPlayNodeList()
	end,
	Play319271006 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 319271006
		arg_28_1.duration_ = 5

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play319271007(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = 0
			local var_31_1 = 1.1

			if var_31_0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_0 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, false)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_2 = arg_28_1:GetWordFromCfg(319271006)
				local var_31_3 = arg_28_1:FormatText(var_31_2.content)

				arg_28_1.text_.text = var_31_3

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_4 = 44
				local var_31_5 = utf8.len(var_31_3)
				local var_31_6 = var_31_4 <= 0 and var_31_1 or var_31_1 * (var_31_5 / var_31_4)

				if var_31_6 > 0 and var_31_1 < var_31_6 then
					arg_28_1.talkMaxDuration = var_31_6

					if var_31_6 + var_31_0 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_6 + var_31_0
					end
				end

				arg_28_1.text_.text = var_31_3
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)
				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_7 = math.max(var_31_1, arg_28_1.talkMaxDuration)

			if var_31_0 <= arg_28_1.time_ and arg_28_1.time_ < var_31_0 + var_31_7 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_0) / var_31_7

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_0 + var_31_7 and arg_28_1.time_ < var_31_0 + var_31_7 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play319271007 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 319271007
		arg_32_1.duration_ = 4.83

		local var_32_0 = {
			zh = 4.7,
			ja = 4.833
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
				arg_32_0:Play319271008(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = "1095ui_story"

			if arg_32_1.actors_[var_35_0] == nil then
				local var_35_1 = Asset.Load("Char/" .. "1095ui_story")

				if not isNil(var_35_1) then
					local var_35_2 = Object.Instantiate(Asset.Load("Char/" .. "1095ui_story"), arg_32_1.stage_.transform)

					var_35_2.name = var_35_0
					var_35_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_32_1.actors_[var_35_0] = var_35_2

					local var_35_3 = var_35_2:GetComponentInChildren(typeof(CharacterEffect))

					var_35_3.enabled = true

					local var_35_4 = GameObjectTools.GetOrAddComponent(var_35_2, typeof(DynamicBoneHelper))

					if var_35_4 then
						var_35_4:EnableDynamicBone(false)
					end

					arg_32_1:ShowWeapon(var_35_3.transform, false)

					arg_32_1.var_[var_35_0 .. "Animator"] = var_35_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_32_1.var_[var_35_0 .. "Animator"].applyRootMotion = true
					arg_32_1.var_[var_35_0 .. "LipSync"] = var_35_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_35_5 = arg_32_1.actors_["1095ui_story"].transform
			local var_35_6 = 0

			if var_35_6 < arg_32_1.time_ and arg_32_1.time_ <= var_35_6 + arg_35_0 then
				arg_32_1.var_.moveOldPos1095ui_story = var_35_5.localPosition
			end

			local var_35_7 = 0.001

			if var_35_6 <= arg_32_1.time_ and arg_32_1.time_ < var_35_6 + var_35_7 then
				local var_35_8 = (arg_32_1.time_ - var_35_6) / var_35_7
				local var_35_9 = Vector3.New(0, -0.98, -6.1)

				var_35_5.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos1095ui_story, var_35_9, var_35_8)

				local var_35_10 = manager.ui.mainCamera.transform.position - var_35_5.position

				var_35_5.forward = Vector3.New(var_35_10.x, var_35_10.y, var_35_10.z)

				local var_35_11 = var_35_5.localEulerAngles

				var_35_11.z = 0
				var_35_11.x = 0
				var_35_5.localEulerAngles = var_35_11
			end

			if arg_32_1.time_ >= var_35_6 + var_35_7 and arg_32_1.time_ < var_35_6 + var_35_7 + arg_35_0 then
				var_35_5.localPosition = Vector3.New(0, -0.98, -6.1)

				local var_35_12 = manager.ui.mainCamera.transform.position - var_35_5.position

				var_35_5.forward = Vector3.New(var_35_12.x, var_35_12.y, var_35_12.z)

				local var_35_13 = var_35_5.localEulerAngles

				var_35_13.z = 0
				var_35_13.x = 0
				var_35_5.localEulerAngles = var_35_13
			end

			local var_35_14 = arg_32_1.actors_["1095ui_story"]
			local var_35_15 = 0

			if var_35_15 < arg_32_1.time_ and arg_32_1.time_ <= var_35_15 + arg_35_0 and not isNil(var_35_14) and arg_32_1.var_.characterEffect1095ui_story == nil then
				arg_32_1.var_.characterEffect1095ui_story = var_35_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_16 = 0.200000002980232

			if var_35_15 <= arg_32_1.time_ and arg_32_1.time_ < var_35_15 + var_35_16 and not isNil(var_35_14) then
				local var_35_17 = (arg_32_1.time_ - var_35_15) / var_35_16

				if arg_32_1.var_.characterEffect1095ui_story and not isNil(var_35_14) then
					arg_32_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_32_1.time_ >= var_35_15 + var_35_16 and arg_32_1.time_ < var_35_15 + var_35_16 + arg_35_0 and not isNil(var_35_14) and arg_32_1.var_.characterEffect1095ui_story then
				arg_32_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_35_18 = 0

			if var_35_18 < arg_32_1.time_ and arg_32_1.time_ <= var_35_18 + arg_35_0 then
				arg_32_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			local var_35_19 = 0

			if var_35_19 < arg_32_1.time_ and arg_32_1.time_ <= var_35_19 + arg_35_0 then
				arg_32_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_35_20 = 0
			local var_35_21 = 0.55

			if var_35_20 < arg_32_1.time_ and arg_32_1.time_ <= var_35_20 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				local var_35_22 = arg_32_1:FormatText(StoryNameCfg[471].name)

				arg_32_1.leftNameTxt_.text = var_35_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_23 = arg_32_1:GetWordFromCfg(319271007)
				local var_35_24 = arg_32_1:FormatText(var_35_23.content)

				arg_32_1.text_.text = var_35_24

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_25 = 22
				local var_35_26 = utf8.len(var_35_24)
				local var_35_27 = var_35_25 <= 0 and var_35_21 or var_35_21 * (var_35_26 / var_35_25)

				if var_35_27 > 0 and var_35_21 < var_35_27 then
					arg_32_1.talkMaxDuration = var_35_27

					if var_35_27 + var_35_20 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_27 + var_35_20
					end
				end

				arg_32_1.text_.text = var_35_24
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319271", "319271007", "story_v_out_319271.awb") ~= 0 then
					local var_35_28 = manager.audio:GetVoiceLength("story_v_out_319271", "319271007", "story_v_out_319271.awb") / 1000

					if var_35_28 + var_35_20 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_28 + var_35_20
					end

					if var_35_23.prefab_name ~= "" and arg_32_1.actors_[var_35_23.prefab_name] ~= nil then
						local var_35_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_23.prefab_name].transform, "story_v_out_319271", "319271007", "story_v_out_319271.awb")

						arg_32_1:RecordAudio("319271007", var_35_29)
						arg_32_1:RecordAudio("319271007", var_35_29)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_319271", "319271007", "story_v_out_319271.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_319271", "319271007", "story_v_out_319271.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_30 = math.max(var_35_21, arg_32_1.talkMaxDuration)

			if var_35_20 <= arg_32_1.time_ and arg_32_1.time_ < var_35_20 + var_35_30 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_20) / var_35_30

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_20 + var_35_30 and arg_32_1.time_ < var_35_20 + var_35_30 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_32_1:InitPlayNodeList()
	end,
	Play319271008 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 319271008
		arg_36_1.duration_ = 3.63

		local var_36_0 = {
			zh = 3.633,
			ja = 3.1
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
				arg_36_0:Play319271009(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = arg_36_1.actors_["1095ui_story"]
			local var_39_1 = 0

			if var_39_1 < arg_36_1.time_ and arg_36_1.time_ <= var_39_1 + arg_39_0 and not isNil(var_39_0) and arg_36_1.var_.characterEffect1095ui_story == nil then
				arg_36_1.var_.characterEffect1095ui_story = var_39_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_2 = 0.200000002980232

			if var_39_1 <= arg_36_1.time_ and arg_36_1.time_ < var_39_1 + var_39_2 and not isNil(var_39_0) then
				local var_39_3 = (arg_36_1.time_ - var_39_1) / var_39_2

				if arg_36_1.var_.characterEffect1095ui_story and not isNil(var_39_0) then
					local var_39_4 = Mathf.Lerp(0, 0.5, var_39_3)

					arg_36_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_36_1.var_.characterEffect1095ui_story.fillRatio = var_39_4
				end
			end

			if arg_36_1.time_ >= var_39_1 + var_39_2 and arg_36_1.time_ < var_39_1 + var_39_2 + arg_39_0 and not isNil(var_39_0) and arg_36_1.var_.characterEffect1095ui_story then
				local var_39_5 = 0.5

				arg_36_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_36_1.var_.characterEffect1095ui_story.fillRatio = var_39_5
			end

			local var_39_6 = 0
			local var_39_7 = 0.3

			if var_39_6 < arg_36_1.time_ and arg_36_1.time_ <= var_39_6 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				local var_39_8 = arg_36_1:FormatText(StoryNameCfg[694].name)

				arg_36_1.leftNameTxt_.text = var_39_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, true)
				arg_36_1.iconController_:SetSelectedState("hero")

				arg_36_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10091")

				arg_36_1.callingController_:SetSelectedState("normal")

				arg_36_1.keyicon_.color = Color.New(1, 1, 1)
				arg_36_1.icon_.color = Color.New(1, 1, 1)

				local var_39_9 = arg_36_1:GetWordFromCfg(319271008)
				local var_39_10 = arg_36_1:FormatText(var_39_9.content)

				arg_36_1.text_.text = var_39_10

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_11 = 12
				local var_39_12 = utf8.len(var_39_10)
				local var_39_13 = var_39_11 <= 0 and var_39_7 or var_39_7 * (var_39_12 / var_39_11)

				if var_39_13 > 0 and var_39_7 < var_39_13 then
					arg_36_1.talkMaxDuration = var_39_13

					if var_39_13 + var_39_6 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_13 + var_39_6
					end
				end

				arg_36_1.text_.text = var_39_10
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319271", "319271008", "story_v_out_319271.awb") ~= 0 then
					local var_39_14 = manager.audio:GetVoiceLength("story_v_out_319271", "319271008", "story_v_out_319271.awb") / 1000

					if var_39_14 + var_39_6 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_14 + var_39_6
					end

					if var_39_9.prefab_name ~= "" and arg_36_1.actors_[var_39_9.prefab_name] ~= nil then
						local var_39_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_9.prefab_name].transform, "story_v_out_319271", "319271008", "story_v_out_319271.awb")

						arg_36_1:RecordAudio("319271008", var_39_15)
						arg_36_1:RecordAudio("319271008", var_39_15)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_319271", "319271008", "story_v_out_319271.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_319271", "319271008", "story_v_out_319271.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_16 = math.max(var_39_7, arg_36_1.talkMaxDuration)

			if var_39_6 <= arg_36_1.time_ and arg_36_1.time_ < var_39_6 + var_39_16 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_6) / var_39_16

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_6 + var_39_16 and arg_36_1.time_ < var_39_6 + var_39_16 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play319271009 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 319271009
		arg_40_1.duration_ = 7.7

		local var_40_0 = {
			zh = 3.933,
			ja = 7.7
		}
		local var_40_1 = manager.audio:GetLocalizationFlag()

		if var_40_0[var_40_1] ~= nil then
			arg_40_1.duration_ = var_40_0[var_40_1]
		end

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play319271010(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = arg_40_1.actors_["1095ui_story"].transform
			local var_43_1 = 0

			if var_43_1 < arg_40_1.time_ and arg_40_1.time_ <= var_43_1 + arg_43_0 then
				arg_40_1.var_.moveOldPos1095ui_story = var_43_0.localPosition
			end

			local var_43_2 = 0.001

			if var_43_1 <= arg_40_1.time_ and arg_40_1.time_ < var_43_1 + var_43_2 then
				local var_43_3 = (arg_40_1.time_ - var_43_1) / var_43_2
				local var_43_4 = Vector3.New(0, -0.98, -6.1)

				var_43_0.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos1095ui_story, var_43_4, var_43_3)

				local var_43_5 = manager.ui.mainCamera.transform.position - var_43_0.position

				var_43_0.forward = Vector3.New(var_43_5.x, var_43_5.y, var_43_5.z)

				local var_43_6 = var_43_0.localEulerAngles

				var_43_6.z = 0
				var_43_6.x = 0
				var_43_0.localEulerAngles = var_43_6
			end

			if arg_40_1.time_ >= var_43_1 + var_43_2 and arg_40_1.time_ < var_43_1 + var_43_2 + arg_43_0 then
				var_43_0.localPosition = Vector3.New(0, -0.98, -6.1)

				local var_43_7 = manager.ui.mainCamera.transform.position - var_43_0.position

				var_43_0.forward = Vector3.New(var_43_7.x, var_43_7.y, var_43_7.z)

				local var_43_8 = var_43_0.localEulerAngles

				var_43_8.z = 0
				var_43_8.x = 0
				var_43_0.localEulerAngles = var_43_8
			end

			local var_43_9 = arg_40_1.actors_["1095ui_story"]
			local var_43_10 = 0

			if var_43_10 < arg_40_1.time_ and arg_40_1.time_ <= var_43_10 + arg_43_0 and not isNil(var_43_9) and arg_40_1.var_.characterEffect1095ui_story == nil then
				arg_40_1.var_.characterEffect1095ui_story = var_43_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_11 = 0.200000002980232

			if var_43_10 <= arg_40_1.time_ and arg_40_1.time_ < var_43_10 + var_43_11 and not isNil(var_43_9) then
				local var_43_12 = (arg_40_1.time_ - var_43_10) / var_43_11

				if arg_40_1.var_.characterEffect1095ui_story and not isNil(var_43_9) then
					arg_40_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_40_1.time_ >= var_43_10 + var_43_11 and arg_40_1.time_ < var_43_10 + var_43_11 + arg_43_0 and not isNil(var_43_9) and arg_40_1.var_.characterEffect1095ui_story then
				arg_40_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_43_13 = 0

			if var_43_13 < arg_40_1.time_ and arg_40_1.time_ <= var_43_13 + arg_43_0 then
				arg_40_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action2_1")
			end

			local var_43_14 = 0

			if var_43_14 < arg_40_1.time_ and arg_40_1.time_ <= var_43_14 + arg_43_0 then
				arg_40_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_43_15 = 0
			local var_43_16 = 0.55

			if var_43_15 < arg_40_1.time_ and arg_40_1.time_ <= var_43_15 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				local var_43_17 = arg_40_1:FormatText(StoryNameCfg[471].name)

				arg_40_1.leftNameTxt_.text = var_43_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_18 = arg_40_1:GetWordFromCfg(319271009)
				local var_43_19 = arg_40_1:FormatText(var_43_18.content)

				arg_40_1.text_.text = var_43_19

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_20 = 22
				local var_43_21 = utf8.len(var_43_19)
				local var_43_22 = var_43_20 <= 0 and var_43_16 or var_43_16 * (var_43_21 / var_43_20)

				if var_43_22 > 0 and var_43_16 < var_43_22 then
					arg_40_1.talkMaxDuration = var_43_22

					if var_43_22 + var_43_15 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_22 + var_43_15
					end
				end

				arg_40_1.text_.text = var_43_19
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319271", "319271009", "story_v_out_319271.awb") ~= 0 then
					local var_43_23 = manager.audio:GetVoiceLength("story_v_out_319271", "319271009", "story_v_out_319271.awb") / 1000

					if var_43_23 + var_43_15 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_23 + var_43_15
					end

					if var_43_18.prefab_name ~= "" and arg_40_1.actors_[var_43_18.prefab_name] ~= nil then
						local var_43_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_18.prefab_name].transform, "story_v_out_319271", "319271009", "story_v_out_319271.awb")

						arg_40_1:RecordAudio("319271009", var_43_24)
						arg_40_1:RecordAudio("319271009", var_43_24)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_319271", "319271009", "story_v_out_319271.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_319271", "319271009", "story_v_out_319271.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_25 = math.max(var_43_16, arg_40_1.talkMaxDuration)

			if var_43_15 <= arg_40_1.time_ and arg_40_1.time_ < var_43_15 + var_43_25 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_15) / var_43_25

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_15 + var_43_25 and arg_40_1.time_ < var_43_15 + var_43_25 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_40_1:InitPlayNodeList()
	end,
	Play319271010 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 319271010
		arg_44_1.duration_ = 6.23

		local var_44_0 = {
			zh = 3.7,
			ja = 6.233
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
				arg_44_0:Play319271011(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = 0

			if var_47_0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_0 + arg_47_0 then
				arg_44_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_47_1 = 0
			local var_47_2 = 0.4

			if var_47_1 < arg_44_1.time_ and arg_44_1.time_ <= var_47_1 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				local var_47_3 = arg_44_1:FormatText(StoryNameCfg[471].name)

				arg_44_1.leftNameTxt_.text = var_47_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_4 = arg_44_1:GetWordFromCfg(319271010)
				local var_47_5 = arg_44_1:FormatText(var_47_4.content)

				arg_44_1.text_.text = var_47_5

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_6 = 16
				local var_47_7 = utf8.len(var_47_5)
				local var_47_8 = var_47_6 <= 0 and var_47_2 or var_47_2 * (var_47_7 / var_47_6)

				if var_47_8 > 0 and var_47_2 < var_47_8 then
					arg_44_1.talkMaxDuration = var_47_8

					if var_47_8 + var_47_1 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_8 + var_47_1
					end
				end

				arg_44_1.text_.text = var_47_5
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319271", "319271010", "story_v_out_319271.awb") ~= 0 then
					local var_47_9 = manager.audio:GetVoiceLength("story_v_out_319271", "319271010", "story_v_out_319271.awb") / 1000

					if var_47_9 + var_47_1 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_9 + var_47_1
					end

					if var_47_4.prefab_name ~= "" and arg_44_1.actors_[var_47_4.prefab_name] ~= nil then
						local var_47_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_4.prefab_name].transform, "story_v_out_319271", "319271010", "story_v_out_319271.awb")

						arg_44_1:RecordAudio("319271010", var_47_10)
						arg_44_1:RecordAudio("319271010", var_47_10)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_319271", "319271010", "story_v_out_319271.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_319271", "319271010", "story_v_out_319271.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_11 = math.max(var_47_2, arg_44_1.talkMaxDuration)

			if var_47_1 <= arg_44_1.time_ and arg_44_1.time_ < var_47_1 + var_47_11 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_1) / var_47_11

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_1 + var_47_11 and arg_44_1.time_ < var_47_1 + var_47_11 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play319271011 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 319271011
		arg_48_1.duration_ = 3.1

		local var_48_0 = {
			zh = 2.366,
			ja = 3.1
		}
		local var_48_1 = manager.audio:GetLocalizationFlag()

		if var_48_0[var_48_1] ~= nil then
			arg_48_1.duration_ = var_48_0[var_48_1]
		end

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play319271012(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = arg_48_1.actors_["1095ui_story"]
			local var_51_1 = 0

			if var_51_1 < arg_48_1.time_ and arg_48_1.time_ <= var_51_1 + arg_51_0 and not isNil(var_51_0) and arg_48_1.var_.characterEffect1095ui_story == nil then
				arg_48_1.var_.characterEffect1095ui_story = var_51_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_2 = 0.200000002980232

			if var_51_1 <= arg_48_1.time_ and arg_48_1.time_ < var_51_1 + var_51_2 and not isNil(var_51_0) then
				local var_51_3 = (arg_48_1.time_ - var_51_1) / var_51_2

				if arg_48_1.var_.characterEffect1095ui_story and not isNil(var_51_0) then
					local var_51_4 = Mathf.Lerp(0, 0.5, var_51_3)

					arg_48_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_48_1.var_.characterEffect1095ui_story.fillRatio = var_51_4
				end
			end

			if arg_48_1.time_ >= var_51_1 + var_51_2 and arg_48_1.time_ < var_51_1 + var_51_2 + arg_51_0 and not isNil(var_51_0) and arg_48_1.var_.characterEffect1095ui_story then
				local var_51_5 = 0.5

				arg_48_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_48_1.var_.characterEffect1095ui_story.fillRatio = var_51_5
			end

			local var_51_6 = 0
			local var_51_7 = 0.1

			if var_51_6 < arg_48_1.time_ and arg_48_1.time_ <= var_51_6 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				local var_51_8 = arg_48_1:FormatText(StoryNameCfg[694].name)

				arg_48_1.leftNameTxt_.text = var_51_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, true)
				arg_48_1.iconController_:SetSelectedState("hero")

				arg_48_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10091")

				arg_48_1.callingController_:SetSelectedState("normal")

				arg_48_1.keyicon_.color = Color.New(1, 1, 1)
				arg_48_1.icon_.color = Color.New(1, 1, 1)

				local var_51_9 = arg_48_1:GetWordFromCfg(319271011)
				local var_51_10 = arg_48_1:FormatText(var_51_9.content)

				arg_48_1.text_.text = var_51_10

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_11 = 4
				local var_51_12 = utf8.len(var_51_10)
				local var_51_13 = var_51_11 <= 0 and var_51_7 or var_51_7 * (var_51_12 / var_51_11)

				if var_51_13 > 0 and var_51_7 < var_51_13 then
					arg_48_1.talkMaxDuration = var_51_13

					if var_51_13 + var_51_6 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_13 + var_51_6
					end
				end

				arg_48_1.text_.text = var_51_10
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319271", "319271011", "story_v_out_319271.awb") ~= 0 then
					local var_51_14 = manager.audio:GetVoiceLength("story_v_out_319271", "319271011", "story_v_out_319271.awb") / 1000

					if var_51_14 + var_51_6 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_14 + var_51_6
					end

					if var_51_9.prefab_name ~= "" and arg_48_1.actors_[var_51_9.prefab_name] ~= nil then
						local var_51_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_9.prefab_name].transform, "story_v_out_319271", "319271011", "story_v_out_319271.awb")

						arg_48_1:RecordAudio("319271011", var_51_15)
						arg_48_1:RecordAudio("319271011", var_51_15)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_319271", "319271011", "story_v_out_319271.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_319271", "319271011", "story_v_out_319271.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_16 = math.max(var_51_7, arg_48_1.talkMaxDuration)

			if var_51_6 <= arg_48_1.time_ and arg_48_1.time_ < var_51_6 + var_51_16 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_6) / var_51_16

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_6 + var_51_16 and arg_48_1.time_ < var_51_6 + var_51_16 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play319271012 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 319271012
		arg_52_1.duration_ = 5

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play319271013(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = arg_52_1.actors_["1095ui_story"].transform
			local var_55_1 = 0

			if var_55_1 < arg_52_1.time_ and arg_52_1.time_ <= var_55_1 + arg_55_0 then
				arg_52_1.var_.moveOldPos1095ui_story = var_55_0.localPosition
			end

			local var_55_2 = 0.001

			if var_55_1 <= arg_52_1.time_ and arg_52_1.time_ < var_55_1 + var_55_2 then
				local var_55_3 = (arg_52_1.time_ - var_55_1) / var_55_2
				local var_55_4 = Vector3.New(0, 100, 0)

				var_55_0.localPosition = Vector3.Lerp(arg_52_1.var_.moveOldPos1095ui_story, var_55_4, var_55_3)

				local var_55_5 = manager.ui.mainCamera.transform.position - var_55_0.position

				var_55_0.forward = Vector3.New(var_55_5.x, var_55_5.y, var_55_5.z)

				local var_55_6 = var_55_0.localEulerAngles

				var_55_6.z = 0
				var_55_6.x = 0
				var_55_0.localEulerAngles = var_55_6
			end

			if arg_52_1.time_ >= var_55_1 + var_55_2 and arg_52_1.time_ < var_55_1 + var_55_2 + arg_55_0 then
				var_55_0.localPosition = Vector3.New(0, 100, 0)

				local var_55_7 = manager.ui.mainCamera.transform.position - var_55_0.position

				var_55_0.forward = Vector3.New(var_55_7.x, var_55_7.y, var_55_7.z)

				local var_55_8 = var_55_0.localEulerAngles

				var_55_8.z = 0
				var_55_8.x = 0
				var_55_0.localEulerAngles = var_55_8
			end

			local var_55_9 = 0
			local var_55_10 = 1.35

			if var_55_9 < arg_52_1.time_ and arg_52_1.time_ <= var_55_9 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, false)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_11 = arg_52_1:GetWordFromCfg(319271012)
				local var_55_12 = arg_52_1:FormatText(var_55_11.content)

				arg_52_1.text_.text = var_55_12

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_13 = 54
				local var_55_14 = utf8.len(var_55_12)
				local var_55_15 = var_55_13 <= 0 and var_55_10 or var_55_10 * (var_55_14 / var_55_13)

				if var_55_15 > 0 and var_55_10 < var_55_15 then
					arg_52_1.talkMaxDuration = var_55_15

					if var_55_15 + var_55_9 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_15 + var_55_9
					end
				end

				arg_52_1.text_.text = var_55_12
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)
				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_16 = math.max(var_55_10, arg_52_1.talkMaxDuration)

			if var_55_9 <= arg_52_1.time_ and arg_52_1.time_ < var_55_9 + var_55_16 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_9) / var_55_16

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_9 + var_55_16 and arg_52_1.time_ < var_55_9 + var_55_16 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_52_1:InitPlayNodeList()
	end,
	Play319271013 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 319271013
		arg_56_1.duration_ = 4.33

		local var_56_0 = {
			zh = 3.933,
			ja = 4.333
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
				arg_56_0:Play319271014(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = arg_56_1.actors_["1095ui_story"].transform
			local var_59_1 = 0

			if var_59_1 < arg_56_1.time_ and arg_56_1.time_ <= var_59_1 + arg_59_0 then
				arg_56_1.var_.moveOldPos1095ui_story = var_59_0.localPosition
			end

			local var_59_2 = 0.001

			if var_59_1 <= arg_56_1.time_ and arg_56_1.time_ < var_59_1 + var_59_2 then
				local var_59_3 = (arg_56_1.time_ - var_59_1) / var_59_2
				local var_59_4 = Vector3.New(0, -0.98, -6.1)

				var_59_0.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPos1095ui_story, var_59_4, var_59_3)

				local var_59_5 = manager.ui.mainCamera.transform.position - var_59_0.position

				var_59_0.forward = Vector3.New(var_59_5.x, var_59_5.y, var_59_5.z)

				local var_59_6 = var_59_0.localEulerAngles

				var_59_6.z = 0
				var_59_6.x = 0
				var_59_0.localEulerAngles = var_59_6
			end

			if arg_56_1.time_ >= var_59_1 + var_59_2 and arg_56_1.time_ < var_59_1 + var_59_2 + arg_59_0 then
				var_59_0.localPosition = Vector3.New(0, -0.98, -6.1)

				local var_59_7 = manager.ui.mainCamera.transform.position - var_59_0.position

				var_59_0.forward = Vector3.New(var_59_7.x, var_59_7.y, var_59_7.z)

				local var_59_8 = var_59_0.localEulerAngles

				var_59_8.z = 0
				var_59_8.x = 0
				var_59_0.localEulerAngles = var_59_8
			end

			local var_59_9 = arg_56_1.actors_["1095ui_story"]
			local var_59_10 = 0

			if var_59_10 < arg_56_1.time_ and arg_56_1.time_ <= var_59_10 + arg_59_0 and not isNil(var_59_9) and arg_56_1.var_.characterEffect1095ui_story == nil then
				arg_56_1.var_.characterEffect1095ui_story = var_59_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_11 = 0.200000002980232

			if var_59_10 <= arg_56_1.time_ and arg_56_1.time_ < var_59_10 + var_59_11 and not isNil(var_59_9) then
				local var_59_12 = (arg_56_1.time_ - var_59_10) / var_59_11

				if arg_56_1.var_.characterEffect1095ui_story and not isNil(var_59_9) then
					arg_56_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_56_1.time_ >= var_59_10 + var_59_11 and arg_56_1.time_ < var_59_10 + var_59_11 + arg_59_0 and not isNil(var_59_9) and arg_56_1.var_.characterEffect1095ui_story then
				arg_56_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_59_13 = 0

			if var_59_13 < arg_56_1.time_ and arg_56_1.time_ <= var_59_13 + arg_59_0 then
				arg_56_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action2_2")
			end

			local var_59_14 = 0

			if var_59_14 < arg_56_1.time_ and arg_56_1.time_ <= var_59_14 + arg_59_0 then
				arg_56_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_59_15 = 0
			local var_59_16 = 0.475

			if var_59_15 < arg_56_1.time_ and arg_56_1.time_ <= var_59_15 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				local var_59_17 = arg_56_1:FormatText(StoryNameCfg[471].name)

				arg_56_1.leftNameTxt_.text = var_59_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_18 = arg_56_1:GetWordFromCfg(319271013)
				local var_59_19 = arg_56_1:FormatText(var_59_18.content)

				arg_56_1.text_.text = var_59_19

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_20 = 19
				local var_59_21 = utf8.len(var_59_19)
				local var_59_22 = var_59_20 <= 0 and var_59_16 or var_59_16 * (var_59_21 / var_59_20)

				if var_59_22 > 0 and var_59_16 < var_59_22 then
					arg_56_1.talkMaxDuration = var_59_22

					if var_59_22 + var_59_15 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_22 + var_59_15
					end
				end

				arg_56_1.text_.text = var_59_19
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319271", "319271013", "story_v_out_319271.awb") ~= 0 then
					local var_59_23 = manager.audio:GetVoiceLength("story_v_out_319271", "319271013", "story_v_out_319271.awb") / 1000

					if var_59_23 + var_59_15 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_23 + var_59_15
					end

					if var_59_18.prefab_name ~= "" and arg_56_1.actors_[var_59_18.prefab_name] ~= nil then
						local var_59_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_18.prefab_name].transform, "story_v_out_319271", "319271013", "story_v_out_319271.awb")

						arg_56_1:RecordAudio("319271013", var_59_24)
						arg_56_1:RecordAudio("319271013", var_59_24)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_out_319271", "319271013", "story_v_out_319271.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_out_319271", "319271013", "story_v_out_319271.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_25 = math.max(var_59_16, arg_56_1.talkMaxDuration)

			if var_59_15 <= arg_56_1.time_ and arg_56_1.time_ < var_59_15 + var_59_25 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_15) / var_59_25

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_15 + var_59_25 and arg_56_1.time_ < var_59_15 + var_59_25 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_56_1:InitPlayNodeList()
	end,
	Play319271014 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 319271014
		arg_60_1.duration_ = 2

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play319271015(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = "10079ui_story"

			if arg_60_1.actors_[var_63_0] == nil then
				local var_63_1 = Asset.Load("Char/" .. "10079ui_story")

				if not isNil(var_63_1) then
					local var_63_2 = Object.Instantiate(Asset.Load("Char/" .. "10079ui_story"), arg_60_1.stage_.transform)

					var_63_2.name = var_63_0
					var_63_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_60_1.actors_[var_63_0] = var_63_2

					local var_63_3 = var_63_2:GetComponentInChildren(typeof(CharacterEffect))

					var_63_3.enabled = true

					local var_63_4 = GameObjectTools.GetOrAddComponent(var_63_2, typeof(DynamicBoneHelper))

					if var_63_4 then
						var_63_4:EnableDynamicBone(false)
					end

					arg_60_1:ShowWeapon(var_63_3.transform, false)

					arg_60_1.var_[var_63_0 .. "Animator"] = var_63_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_60_1.var_[var_63_0 .. "Animator"].applyRootMotion = true
					arg_60_1.var_[var_63_0 .. "LipSync"] = var_63_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_63_5 = arg_60_1.actors_["10079ui_story"].transform
			local var_63_6 = 0

			if var_63_6 < arg_60_1.time_ and arg_60_1.time_ <= var_63_6 + arg_63_0 then
				arg_60_1.var_.moveOldPos10079ui_story = var_63_5.localPosition

				local var_63_7 = "10079ui_story"

				arg_60_1:ShowWeapon(arg_60_1.var_[var_63_7 .. "Animator"].transform, false)
			end

			local var_63_8 = 0.001

			if var_63_6 <= arg_60_1.time_ and arg_60_1.time_ < var_63_6 + var_63_8 then
				local var_63_9 = (arg_60_1.time_ - var_63_6) / var_63_8
				local var_63_10 = Vector3.New(0.7, -0.95, -6.05)

				var_63_5.localPosition = Vector3.Lerp(arg_60_1.var_.moveOldPos10079ui_story, var_63_10, var_63_9)

				local var_63_11 = manager.ui.mainCamera.transform.position - var_63_5.position

				var_63_5.forward = Vector3.New(var_63_11.x, var_63_11.y, var_63_11.z)

				local var_63_12 = var_63_5.localEulerAngles

				var_63_12.z = 0
				var_63_12.x = 0
				var_63_5.localEulerAngles = var_63_12
			end

			if arg_60_1.time_ >= var_63_6 + var_63_8 and arg_60_1.time_ < var_63_6 + var_63_8 + arg_63_0 then
				var_63_5.localPosition = Vector3.New(0.7, -0.95, -6.05)

				local var_63_13 = manager.ui.mainCamera.transform.position - var_63_5.position

				var_63_5.forward = Vector3.New(var_63_13.x, var_63_13.y, var_63_13.z)

				local var_63_14 = var_63_5.localEulerAngles

				var_63_14.z = 0
				var_63_14.x = 0
				var_63_5.localEulerAngles = var_63_14
			end

			local var_63_15 = arg_60_1.actors_["10079ui_story"]
			local var_63_16 = 0

			if var_63_16 < arg_60_1.time_ and arg_60_1.time_ <= var_63_16 + arg_63_0 and not isNil(var_63_15) and arg_60_1.var_.characterEffect10079ui_story == nil then
				arg_60_1.var_.characterEffect10079ui_story = var_63_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_17 = 0.200000002980232

			if var_63_16 <= arg_60_1.time_ and arg_60_1.time_ < var_63_16 + var_63_17 and not isNil(var_63_15) then
				local var_63_18 = (arg_60_1.time_ - var_63_16) / var_63_17

				if arg_60_1.var_.characterEffect10079ui_story and not isNil(var_63_15) then
					arg_60_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_60_1.time_ >= var_63_16 + var_63_17 and arg_60_1.time_ < var_63_16 + var_63_17 + arg_63_0 and not isNil(var_63_15) and arg_60_1.var_.characterEffect10079ui_story then
				arg_60_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_63_19 = 0

			if var_63_19 < arg_60_1.time_ and arg_60_1.time_ <= var_63_19 + arg_63_0 then
				arg_60_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_1")
			end

			local var_63_20 = 0

			if var_63_20 < arg_60_1.time_ and arg_60_1.time_ <= var_63_20 + arg_63_0 then
				arg_60_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_63_21 = arg_60_1.actors_["1095ui_story"].transform
			local var_63_22 = 0

			if var_63_22 < arg_60_1.time_ and arg_60_1.time_ <= var_63_22 + arg_63_0 then
				arg_60_1.var_.moveOldPos1095ui_story = var_63_21.localPosition
			end

			local var_63_23 = 0.001

			if var_63_22 <= arg_60_1.time_ and arg_60_1.time_ < var_63_22 + var_63_23 then
				local var_63_24 = (arg_60_1.time_ - var_63_22) / var_63_23
				local var_63_25 = Vector3.New(-0.7, -0.98, -6.1)

				var_63_21.localPosition = Vector3.Lerp(arg_60_1.var_.moveOldPos1095ui_story, var_63_25, var_63_24)

				local var_63_26 = manager.ui.mainCamera.transform.position - var_63_21.position

				var_63_21.forward = Vector3.New(var_63_26.x, var_63_26.y, var_63_26.z)

				local var_63_27 = var_63_21.localEulerAngles

				var_63_27.z = 0
				var_63_27.x = 0
				var_63_21.localEulerAngles = var_63_27
			end

			if arg_60_1.time_ >= var_63_22 + var_63_23 and arg_60_1.time_ < var_63_22 + var_63_23 + arg_63_0 then
				var_63_21.localPosition = Vector3.New(-0.7, -0.98, -6.1)

				local var_63_28 = manager.ui.mainCamera.transform.position - var_63_21.position

				var_63_21.forward = Vector3.New(var_63_28.x, var_63_28.y, var_63_28.z)

				local var_63_29 = var_63_21.localEulerAngles

				var_63_29.z = 0
				var_63_29.x = 0
				var_63_21.localEulerAngles = var_63_29
			end

			local var_63_30 = arg_60_1.actors_["1095ui_story"]
			local var_63_31 = 0

			if var_63_31 < arg_60_1.time_ and arg_60_1.time_ <= var_63_31 + arg_63_0 and not isNil(var_63_30) and arg_60_1.var_.characterEffect1095ui_story == nil then
				arg_60_1.var_.characterEffect1095ui_story = var_63_30:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_32 = 0.200000002980232

			if var_63_31 <= arg_60_1.time_ and arg_60_1.time_ < var_63_31 + var_63_32 and not isNil(var_63_30) then
				local var_63_33 = (arg_60_1.time_ - var_63_31) / var_63_32

				if arg_60_1.var_.characterEffect1095ui_story and not isNil(var_63_30) then
					local var_63_34 = Mathf.Lerp(0, 0.5, var_63_33)

					arg_60_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_60_1.var_.characterEffect1095ui_story.fillRatio = var_63_34
				end
			end

			if arg_60_1.time_ >= var_63_31 + var_63_32 and arg_60_1.time_ < var_63_31 + var_63_32 + arg_63_0 and not isNil(var_63_30) and arg_60_1.var_.characterEffect1095ui_story then
				local var_63_35 = 0.5

				arg_60_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_60_1.var_.characterEffect1095ui_story.fillRatio = var_63_35
			end

			local var_63_36 = 0
			local var_63_37 = 0.1

			if var_63_36 < arg_60_1.time_ and arg_60_1.time_ <= var_63_36 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				local var_63_38 = arg_60_1:FormatText(StoryNameCfg[6].name)

				arg_60_1.leftNameTxt_.text = var_63_38

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_39 = arg_60_1:GetWordFromCfg(319271014)
				local var_63_40 = arg_60_1:FormatText(var_63_39.content)

				arg_60_1.text_.text = var_63_40

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_41 = 4
				local var_63_42 = utf8.len(var_63_40)
				local var_63_43 = var_63_41 <= 0 and var_63_37 or var_63_37 * (var_63_42 / var_63_41)

				if var_63_43 > 0 and var_63_37 < var_63_43 then
					arg_60_1.talkMaxDuration = var_63_43

					if var_63_43 + var_63_36 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_43 + var_63_36
					end
				end

				arg_60_1.text_.text = var_63_40
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319271", "319271014", "story_v_out_319271.awb") ~= 0 then
					local var_63_44 = manager.audio:GetVoiceLength("story_v_out_319271", "319271014", "story_v_out_319271.awb") / 1000

					if var_63_44 + var_63_36 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_44 + var_63_36
					end

					if var_63_39.prefab_name ~= "" and arg_60_1.actors_[var_63_39.prefab_name] ~= nil then
						local var_63_45 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_39.prefab_name].transform, "story_v_out_319271", "319271014", "story_v_out_319271.awb")

						arg_60_1:RecordAudio("319271014", var_63_45)
						arg_60_1:RecordAudio("319271014", var_63_45)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_319271", "319271014", "story_v_out_319271.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_319271", "319271014", "story_v_out_319271.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_46 = math.max(var_63_37, arg_60_1.talkMaxDuration)

			if var_63_36 <= arg_60_1.time_ and arg_60_1.time_ < var_63_36 + var_63_46 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_36) / var_63_46

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_36 + var_63_46 and arg_60_1.time_ < var_63_36 + var_63_46 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_60_1:InitPlayNodeList()
	end,
	Play319271015 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 319271015
		arg_64_1.duration_ = 7.07

		local var_64_0 = {
			zh = 7.066,
			ja = 6.433
		}
		local var_64_1 = manager.audio:GetLocalizationFlag()

		if var_64_0[var_64_1] ~= nil then
			arg_64_1.duration_ = var_64_0[var_64_1]
		end

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play319271016(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_0 = "4040ui_story"

			if arg_64_1.actors_[var_67_0] == nil then
				local var_67_1 = Asset.Load("Char/" .. "4040ui_story")

				if not isNil(var_67_1) then
					local var_67_2 = Object.Instantiate(Asset.Load("Char/" .. "4040ui_story"), arg_64_1.stage_.transform)

					var_67_2.name = var_67_0
					var_67_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_64_1.actors_[var_67_0] = var_67_2

					local var_67_3 = var_67_2:GetComponentInChildren(typeof(CharacterEffect))

					var_67_3.enabled = true

					local var_67_4 = GameObjectTools.GetOrAddComponent(var_67_2, typeof(DynamicBoneHelper))

					if var_67_4 then
						var_67_4:EnableDynamicBone(false)
					end

					arg_64_1:ShowWeapon(var_67_3.transform, false)

					arg_64_1.var_[var_67_0 .. "Animator"] = var_67_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_64_1.var_[var_67_0 .. "Animator"].applyRootMotion = true
					arg_64_1.var_[var_67_0 .. "LipSync"] = var_67_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_67_5 = arg_64_1.actors_["4040ui_story"].transform
			local var_67_6 = 0

			if var_67_6 < arg_64_1.time_ and arg_64_1.time_ <= var_67_6 + arg_67_0 then
				arg_64_1.var_.moveOldPos4040ui_story = var_67_5.localPosition
			end

			local var_67_7 = 0.001

			if var_67_6 <= arg_64_1.time_ and arg_64_1.time_ < var_67_6 + var_67_7 then
				local var_67_8 = (arg_64_1.time_ - var_67_6) / var_67_7
				local var_67_9 = Vector3.New(0, -1.55, -5.5)

				var_67_5.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos4040ui_story, var_67_9, var_67_8)

				local var_67_10 = manager.ui.mainCamera.transform.position - var_67_5.position

				var_67_5.forward = Vector3.New(var_67_10.x, var_67_10.y, var_67_10.z)

				local var_67_11 = var_67_5.localEulerAngles

				var_67_11.z = 0
				var_67_11.x = 0
				var_67_5.localEulerAngles = var_67_11
			end

			if arg_64_1.time_ >= var_67_6 + var_67_7 and arg_64_1.time_ < var_67_6 + var_67_7 + arg_67_0 then
				var_67_5.localPosition = Vector3.New(0, -1.55, -5.5)

				local var_67_12 = manager.ui.mainCamera.transform.position - var_67_5.position

				var_67_5.forward = Vector3.New(var_67_12.x, var_67_12.y, var_67_12.z)

				local var_67_13 = var_67_5.localEulerAngles

				var_67_13.z = 0
				var_67_13.x = 0
				var_67_5.localEulerAngles = var_67_13
			end

			local var_67_14 = arg_64_1.actors_["4040ui_story"]
			local var_67_15 = 0

			if var_67_15 < arg_64_1.time_ and arg_64_1.time_ <= var_67_15 + arg_67_0 and not isNil(var_67_14) and arg_64_1.var_.characterEffect4040ui_story == nil then
				arg_64_1.var_.characterEffect4040ui_story = var_67_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_16 = 0.200000002980232

			if var_67_15 <= arg_64_1.time_ and arg_64_1.time_ < var_67_15 + var_67_16 and not isNil(var_67_14) then
				local var_67_17 = (arg_64_1.time_ - var_67_15) / var_67_16

				if arg_64_1.var_.characterEffect4040ui_story and not isNil(var_67_14) then
					arg_64_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_64_1.time_ >= var_67_15 + var_67_16 and arg_64_1.time_ < var_67_15 + var_67_16 + arg_67_0 and not isNil(var_67_14) and arg_64_1.var_.characterEffect4040ui_story then
				arg_64_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_67_18 = 0

			if var_67_18 < arg_64_1.time_ and arg_64_1.time_ <= var_67_18 + arg_67_0 then
				arg_64_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action4_1")
			end

			local var_67_19 = 0

			if var_67_19 < arg_64_1.time_ and arg_64_1.time_ <= var_67_19 + arg_67_0 then
				arg_64_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_67_20 = arg_64_1.actors_["10079ui_story"].transform
			local var_67_21 = 0

			if var_67_21 < arg_64_1.time_ and arg_64_1.time_ <= var_67_21 + arg_67_0 then
				arg_64_1.var_.moveOldPos10079ui_story = var_67_20.localPosition
			end

			local var_67_22 = 0.001

			if var_67_21 <= arg_64_1.time_ and arg_64_1.time_ < var_67_21 + var_67_22 then
				local var_67_23 = (arg_64_1.time_ - var_67_21) / var_67_22
				local var_67_24 = Vector3.New(0, 100, 0)

				var_67_20.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos10079ui_story, var_67_24, var_67_23)

				local var_67_25 = manager.ui.mainCamera.transform.position - var_67_20.position

				var_67_20.forward = Vector3.New(var_67_25.x, var_67_25.y, var_67_25.z)

				local var_67_26 = var_67_20.localEulerAngles

				var_67_26.z = 0
				var_67_26.x = 0
				var_67_20.localEulerAngles = var_67_26
			end

			if arg_64_1.time_ >= var_67_21 + var_67_22 and arg_64_1.time_ < var_67_21 + var_67_22 + arg_67_0 then
				var_67_20.localPosition = Vector3.New(0, 100, 0)

				local var_67_27 = manager.ui.mainCamera.transform.position - var_67_20.position

				var_67_20.forward = Vector3.New(var_67_27.x, var_67_27.y, var_67_27.z)

				local var_67_28 = var_67_20.localEulerAngles

				var_67_28.z = 0
				var_67_28.x = 0
				var_67_20.localEulerAngles = var_67_28
			end

			local var_67_29 = arg_64_1.actors_["10079ui_story"]
			local var_67_30 = 0

			if var_67_30 < arg_64_1.time_ and arg_64_1.time_ <= var_67_30 + arg_67_0 and not isNil(var_67_29) and arg_64_1.var_.characterEffect10079ui_story == nil then
				arg_64_1.var_.characterEffect10079ui_story = var_67_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_31 = 0.200000002980232

			if var_67_30 <= arg_64_1.time_ and arg_64_1.time_ < var_67_30 + var_67_31 and not isNil(var_67_29) then
				local var_67_32 = (arg_64_1.time_ - var_67_30) / var_67_31

				if arg_64_1.var_.characterEffect10079ui_story and not isNil(var_67_29) then
					local var_67_33 = Mathf.Lerp(0, 0.5, var_67_32)

					arg_64_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_64_1.var_.characterEffect10079ui_story.fillRatio = var_67_33
				end
			end

			if arg_64_1.time_ >= var_67_30 + var_67_31 and arg_64_1.time_ < var_67_30 + var_67_31 + arg_67_0 and not isNil(var_67_29) and arg_64_1.var_.characterEffect10079ui_story then
				local var_67_34 = 0.5

				arg_64_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_64_1.var_.characterEffect10079ui_story.fillRatio = var_67_34
			end

			local var_67_35 = arg_64_1.actors_["1095ui_story"].transform
			local var_67_36 = 0

			if var_67_36 < arg_64_1.time_ and arg_64_1.time_ <= var_67_36 + arg_67_0 then
				arg_64_1.var_.moveOldPos1095ui_story = var_67_35.localPosition
			end

			local var_67_37 = 0.001

			if var_67_36 <= arg_64_1.time_ and arg_64_1.time_ < var_67_36 + var_67_37 then
				local var_67_38 = (arg_64_1.time_ - var_67_36) / var_67_37
				local var_67_39 = Vector3.New(0, 100, 0)

				var_67_35.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos1095ui_story, var_67_39, var_67_38)

				local var_67_40 = manager.ui.mainCamera.transform.position - var_67_35.position

				var_67_35.forward = Vector3.New(var_67_40.x, var_67_40.y, var_67_40.z)

				local var_67_41 = var_67_35.localEulerAngles

				var_67_41.z = 0
				var_67_41.x = 0
				var_67_35.localEulerAngles = var_67_41
			end

			if arg_64_1.time_ >= var_67_36 + var_67_37 and arg_64_1.time_ < var_67_36 + var_67_37 + arg_67_0 then
				var_67_35.localPosition = Vector3.New(0, 100, 0)

				local var_67_42 = manager.ui.mainCamera.transform.position - var_67_35.position

				var_67_35.forward = Vector3.New(var_67_42.x, var_67_42.y, var_67_42.z)

				local var_67_43 = var_67_35.localEulerAngles

				var_67_43.z = 0
				var_67_43.x = 0
				var_67_35.localEulerAngles = var_67_43
			end

			local var_67_44 = arg_64_1.actors_["1095ui_story"]
			local var_67_45 = 0

			if var_67_45 < arg_64_1.time_ and arg_64_1.time_ <= var_67_45 + arg_67_0 and not isNil(var_67_44) and arg_64_1.var_.characterEffect1095ui_story == nil then
				arg_64_1.var_.characterEffect1095ui_story = var_67_44:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_46 = 0.200000002980232

			if var_67_45 <= arg_64_1.time_ and arg_64_1.time_ < var_67_45 + var_67_46 and not isNil(var_67_44) then
				local var_67_47 = (arg_64_1.time_ - var_67_45) / var_67_46

				if arg_64_1.var_.characterEffect1095ui_story and not isNil(var_67_44) then
					local var_67_48 = Mathf.Lerp(0, 0.5, var_67_47)

					arg_64_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_64_1.var_.characterEffect1095ui_story.fillRatio = var_67_48
				end
			end

			if arg_64_1.time_ >= var_67_45 + var_67_46 and arg_64_1.time_ < var_67_45 + var_67_46 + arg_67_0 and not isNil(var_67_44) and arg_64_1.var_.characterEffect1095ui_story then
				local var_67_49 = 0.5

				arg_64_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_64_1.var_.characterEffect1095ui_story.fillRatio = var_67_49
			end

			local var_67_50 = 0
			local var_67_51 = 0.7

			if var_67_50 < arg_64_1.time_ and arg_64_1.time_ <= var_67_50 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				local var_67_52 = arg_64_1:FormatText(StoryNameCfg[668].name)

				arg_64_1.leftNameTxt_.text = var_67_52

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_53 = arg_64_1:GetWordFromCfg(319271015)
				local var_67_54 = arg_64_1:FormatText(var_67_53.content)

				arg_64_1.text_.text = var_67_54

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_55 = 28
				local var_67_56 = utf8.len(var_67_54)
				local var_67_57 = var_67_55 <= 0 and var_67_51 or var_67_51 * (var_67_56 / var_67_55)

				if var_67_57 > 0 and var_67_51 < var_67_57 then
					arg_64_1.talkMaxDuration = var_67_57

					if var_67_57 + var_67_50 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_57 + var_67_50
					end
				end

				arg_64_1.text_.text = var_67_54
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319271", "319271015", "story_v_out_319271.awb") ~= 0 then
					local var_67_58 = manager.audio:GetVoiceLength("story_v_out_319271", "319271015", "story_v_out_319271.awb") / 1000

					if var_67_58 + var_67_50 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_58 + var_67_50
					end

					if var_67_53.prefab_name ~= "" and arg_64_1.actors_[var_67_53.prefab_name] ~= nil then
						local var_67_59 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_53.prefab_name].transform, "story_v_out_319271", "319271015", "story_v_out_319271.awb")

						arg_64_1:RecordAudio("319271015", var_67_59)
						arg_64_1:RecordAudio("319271015", var_67_59)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_out_319271", "319271015", "story_v_out_319271.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_out_319271", "319271015", "story_v_out_319271.awb")
				end

				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_60 = math.max(var_67_51, arg_64_1.talkMaxDuration)

			if var_67_50 <= arg_64_1.time_ and arg_64_1.time_ < var_67_50 + var_67_60 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_50) / var_67_60

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_50 + var_67_60 and arg_64_1.time_ < var_67_50 + var_67_60 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_64_1:InitPlayNodeList()
	end,
	Play319271016 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 319271016
		arg_68_1.duration_ = 7.23

		local var_68_0 = {
			zh = 5.033,
			ja = 7.233
		}
		local var_68_1 = manager.audio:GetLocalizationFlag()

		if var_68_0[var_68_1] ~= nil then
			arg_68_1.duration_ = var_68_0[var_68_1]
		end

		SetActive(arg_68_1.tipsGo_, false)

		function arg_68_1.onSingleLineFinish_()
			arg_68_1.onSingleLineUpdate_ = nil
			arg_68_1.onSingleLineFinish_ = nil
			arg_68_1.state_ = "waiting"
		end

		function arg_68_1.playNext_(arg_70_0)
			if arg_70_0 == 1 then
				arg_68_0:Play319271017(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = 0
			local var_71_1 = 0.5

			if var_71_0 < arg_68_1.time_ and arg_68_1.time_ <= var_71_0 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				local var_71_2 = arg_68_1:FormatText(StoryNameCfg[668].name)

				arg_68_1.leftNameTxt_.text = var_71_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_3 = arg_68_1:GetWordFromCfg(319271016)
				local var_71_4 = arg_68_1:FormatText(var_71_3.content)

				arg_68_1.text_.text = var_71_4

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_5 = 20
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

				if manager.audio:GetVoiceLength("story_v_out_319271", "319271016", "story_v_out_319271.awb") ~= 0 then
					local var_71_8 = manager.audio:GetVoiceLength("story_v_out_319271", "319271016", "story_v_out_319271.awb") / 1000

					if var_71_8 + var_71_0 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_8 + var_71_0
					end

					if var_71_3.prefab_name ~= "" and arg_68_1.actors_[var_71_3.prefab_name] ~= nil then
						local var_71_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_3.prefab_name].transform, "story_v_out_319271", "319271016", "story_v_out_319271.awb")

						arg_68_1:RecordAudio("319271016", var_71_9)
						arg_68_1:RecordAudio("319271016", var_71_9)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_out_319271", "319271016", "story_v_out_319271.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_out_319271", "319271016", "story_v_out_319271.awb")
				end

				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_10 = math.max(var_71_1, arg_68_1.talkMaxDuration)

			if var_71_0 <= arg_68_1.time_ and arg_68_1.time_ < var_71_0 + var_71_10 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_0) / var_71_10

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_0 + var_71_10 and arg_68_1.time_ < var_71_0 + var_71_10 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {}

		arg_68_1:InitPlayNodeList()
	end,
	Play319271017 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 319271017
		arg_72_1.duration_ = 5.13

		local var_72_0 = {
			zh = 3.566,
			ja = 5.133
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
				arg_72_0:Play319271018(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			local var_75_0 = arg_72_1.actors_["4040ui_story"]
			local var_75_1 = 0

			if var_75_1 < arg_72_1.time_ and arg_72_1.time_ <= var_75_1 + arg_75_0 and not isNil(var_75_0) and arg_72_1.var_.characterEffect4040ui_story == nil then
				arg_72_1.var_.characterEffect4040ui_story = var_75_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_75_2 = 0.200000002980232

			if var_75_1 <= arg_72_1.time_ and arg_72_1.time_ < var_75_1 + var_75_2 and not isNil(var_75_0) then
				local var_75_3 = (arg_72_1.time_ - var_75_1) / var_75_2

				if arg_72_1.var_.characterEffect4040ui_story and not isNil(var_75_0) then
					local var_75_4 = Mathf.Lerp(0, 0.5, var_75_3)

					arg_72_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_72_1.var_.characterEffect4040ui_story.fillRatio = var_75_4
				end
			end

			if arg_72_1.time_ >= var_75_1 + var_75_2 and arg_72_1.time_ < var_75_1 + var_75_2 + arg_75_0 and not isNil(var_75_0) and arg_72_1.var_.characterEffect4040ui_story then
				local var_75_5 = 0.5

				arg_72_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_72_1.var_.characterEffect4040ui_story.fillRatio = var_75_5
			end

			local var_75_6 = 0
			local var_75_7 = 0.475

			if var_75_6 < arg_72_1.time_ and arg_72_1.time_ <= var_75_6 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				local var_75_8 = arg_72_1:FormatText(StoryNameCfg[721].name)

				arg_72_1.leftNameTxt_.text = var_75_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, true)
				arg_72_1.iconController_:SetSelectedState("hero")

				arg_72_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10090")

				arg_72_1.callingController_:SetSelectedState("normal")

				arg_72_1.keyicon_.color = Color.New(1, 1, 1)
				arg_72_1.icon_.color = Color.New(1, 1, 1)

				local var_75_9 = arg_72_1:GetWordFromCfg(319271017)
				local var_75_10 = arg_72_1:FormatText(var_75_9.content)

				arg_72_1.text_.text = var_75_10

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_11 = 19
				local var_75_12 = utf8.len(var_75_10)
				local var_75_13 = var_75_11 <= 0 and var_75_7 or var_75_7 * (var_75_12 / var_75_11)

				if var_75_13 > 0 and var_75_7 < var_75_13 then
					arg_72_1.talkMaxDuration = var_75_13

					if var_75_13 + var_75_6 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_13 + var_75_6
					end
				end

				arg_72_1.text_.text = var_75_10
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319271", "319271017", "story_v_out_319271.awb") ~= 0 then
					local var_75_14 = manager.audio:GetVoiceLength("story_v_out_319271", "319271017", "story_v_out_319271.awb") / 1000

					if var_75_14 + var_75_6 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_14 + var_75_6
					end

					if var_75_9.prefab_name ~= "" and arg_72_1.actors_[var_75_9.prefab_name] ~= nil then
						local var_75_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_9.prefab_name].transform, "story_v_out_319271", "319271017", "story_v_out_319271.awb")

						arg_72_1:RecordAudio("319271017", var_75_15)
						arg_72_1:RecordAudio("319271017", var_75_15)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_out_319271", "319271017", "story_v_out_319271.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_out_319271", "319271017", "story_v_out_319271.awb")
				end

				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_16 = math.max(var_75_7, arg_72_1.talkMaxDuration)

			if var_75_6 <= arg_72_1.time_ and arg_72_1.time_ < var_75_6 + var_75_16 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_6) / var_75_16

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_6 + var_75_16 and arg_72_1.time_ < var_75_6 + var_75_16 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {}

		arg_72_1:InitPlayNodeList()
	end,
	Play319271018 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 319271018
		arg_76_1.duration_ = 7.53

		local var_76_0 = {
			zh = 6.166,
			ja = 7.533
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
				arg_76_0:Play319271019(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			local var_79_0 = arg_76_1.actors_["4040ui_story"]
			local var_79_1 = 0

			if var_79_1 < arg_76_1.time_ and arg_76_1.time_ <= var_79_1 + arg_79_0 and not isNil(var_79_0) and arg_76_1.var_.characterEffect4040ui_story == nil then
				arg_76_1.var_.characterEffect4040ui_story = var_79_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_2 = 0.200000002980232

			if var_79_1 <= arg_76_1.time_ and arg_76_1.time_ < var_79_1 + var_79_2 and not isNil(var_79_0) then
				local var_79_3 = (arg_76_1.time_ - var_79_1) / var_79_2

				if arg_76_1.var_.characterEffect4040ui_story and not isNil(var_79_0) then
					arg_76_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_76_1.time_ >= var_79_1 + var_79_2 and arg_76_1.time_ < var_79_1 + var_79_2 + arg_79_0 and not isNil(var_79_0) and arg_76_1.var_.characterEffect4040ui_story then
				arg_76_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_79_4 = 0

			if var_79_4 < arg_76_1.time_ and arg_76_1.time_ <= var_79_4 + arg_79_0 then
				arg_76_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040actionlink/4040action447")
			end

			local var_79_5 = 0

			if var_79_5 < arg_76_1.time_ and arg_76_1.time_ <= var_79_5 + arg_79_0 then
				arg_76_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_79_6 = 0
			local var_79_7 = 0.575

			if var_79_6 < arg_76_1.time_ and arg_76_1.time_ <= var_79_6 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				local var_79_8 = arg_76_1:FormatText(StoryNameCfg[668].name)

				arg_76_1.leftNameTxt_.text = var_79_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_9 = arg_76_1:GetWordFromCfg(319271018)
				local var_79_10 = arg_76_1:FormatText(var_79_9.content)

				arg_76_1.text_.text = var_79_10

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_11 = 23
				local var_79_12 = utf8.len(var_79_10)
				local var_79_13 = var_79_11 <= 0 and var_79_7 or var_79_7 * (var_79_12 / var_79_11)

				if var_79_13 > 0 and var_79_7 < var_79_13 then
					arg_76_1.talkMaxDuration = var_79_13

					if var_79_13 + var_79_6 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_13 + var_79_6
					end
				end

				arg_76_1.text_.text = var_79_10
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319271", "319271018", "story_v_out_319271.awb") ~= 0 then
					local var_79_14 = manager.audio:GetVoiceLength("story_v_out_319271", "319271018", "story_v_out_319271.awb") / 1000

					if var_79_14 + var_79_6 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_14 + var_79_6
					end

					if var_79_9.prefab_name ~= "" and arg_76_1.actors_[var_79_9.prefab_name] ~= nil then
						local var_79_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_9.prefab_name].transform, "story_v_out_319271", "319271018", "story_v_out_319271.awb")

						arg_76_1:RecordAudio("319271018", var_79_15)
						arg_76_1:RecordAudio("319271018", var_79_15)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_out_319271", "319271018", "story_v_out_319271.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_out_319271", "319271018", "story_v_out_319271.awb")
				end

				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_16 = math.max(var_79_7, arg_76_1.talkMaxDuration)

			if var_79_6 <= arg_76_1.time_ and arg_76_1.time_ < var_79_6 + var_79_16 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_6) / var_79_16

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_6 + var_79_16 and arg_76_1.time_ < var_79_6 + var_79_16 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {}

		arg_76_1:InitPlayNodeList()
	end,
	Play319271019 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 319271019
		arg_80_1.duration_ = 5

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play319271020(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			local var_83_0 = arg_80_1.actors_["4040ui_story"].transform
			local var_83_1 = 0

			if var_83_1 < arg_80_1.time_ and arg_80_1.time_ <= var_83_1 + arg_83_0 then
				arg_80_1.var_.moveOldPos4040ui_story = var_83_0.localPosition
			end

			local var_83_2 = 0.001

			if var_83_1 <= arg_80_1.time_ and arg_80_1.time_ < var_83_1 + var_83_2 then
				local var_83_3 = (arg_80_1.time_ - var_83_1) / var_83_2
				local var_83_4 = Vector3.New(0, 100, 0)

				var_83_0.localPosition = Vector3.Lerp(arg_80_1.var_.moveOldPos4040ui_story, var_83_4, var_83_3)

				local var_83_5 = manager.ui.mainCamera.transform.position - var_83_0.position

				var_83_0.forward = Vector3.New(var_83_5.x, var_83_5.y, var_83_5.z)

				local var_83_6 = var_83_0.localEulerAngles

				var_83_6.z = 0
				var_83_6.x = 0
				var_83_0.localEulerAngles = var_83_6
			end

			if arg_80_1.time_ >= var_83_1 + var_83_2 and arg_80_1.time_ < var_83_1 + var_83_2 + arg_83_0 then
				var_83_0.localPosition = Vector3.New(0, 100, 0)

				local var_83_7 = manager.ui.mainCamera.transform.position - var_83_0.position

				var_83_0.forward = Vector3.New(var_83_7.x, var_83_7.y, var_83_7.z)

				local var_83_8 = var_83_0.localEulerAngles

				var_83_8.z = 0
				var_83_8.x = 0
				var_83_0.localEulerAngles = var_83_8
			end

			local var_83_9 = 0
			local var_83_10 = 0.975

			if var_83_9 < arg_80_1.time_ and arg_80_1.time_ <= var_83_9 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, false)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_11 = arg_80_1:GetWordFromCfg(319271019)
				local var_83_12 = arg_80_1:FormatText(var_83_11.content)

				arg_80_1.text_.text = var_83_12

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_13 = 39
				local var_83_14 = utf8.len(var_83_12)
				local var_83_15 = var_83_13 <= 0 and var_83_10 or var_83_10 * (var_83_14 / var_83_13)

				if var_83_15 > 0 and var_83_10 < var_83_15 then
					arg_80_1.talkMaxDuration = var_83_15

					if var_83_15 + var_83_9 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_15 + var_83_9
					end
				end

				arg_80_1.text_.text = var_83_12
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)
				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_16 = math.max(var_83_10, arg_80_1.talkMaxDuration)

			if var_83_9 <= arg_80_1.time_ and arg_80_1.time_ < var_83_9 + var_83_16 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_9) / var_83_16

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_9 + var_83_16 and arg_80_1.time_ < var_83_9 + var_83_16 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_80_1:InitPlayNodeList()
	end,
	Play319271020 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 319271020
		arg_84_1.duration_ = 5.8

		SetActive(arg_84_1.tipsGo_, false)

		function arg_84_1.onSingleLineFinish_()
			arg_84_1.onSingleLineUpdate_ = nil
			arg_84_1.onSingleLineFinish_ = nil
			arg_84_1.state_ = "waiting"
		end

		function arg_84_1.playNext_(arg_86_0)
			if arg_86_0 == 1 then
				arg_84_0:Play319271021(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			local var_87_0 = 0
			local var_87_1 = 1

			if var_87_0 < arg_84_1.time_ and arg_84_1.time_ <= var_87_0 + arg_87_0 then
				local var_87_2 = "play"
				local var_87_3 = "effect"

				arg_84_1:AudioAction(var_87_2, var_87_3, "se_story_15", "se_story_15_gun07", "")
			end

			local var_87_4 = 0
			local var_87_5 = 1

			if var_87_4 < arg_84_1.time_ and arg_84_1.time_ <= var_87_4 + arg_87_0 then
				local var_87_6 = "play"
				local var_87_7 = "effect"

				arg_84_1:AudioAction(var_87_6, var_87_7, "se_story_123_02", "se_story_123_02_cannon_loop", "")
			end

			local var_87_8 = manager.ui.mainCamera.transform
			local var_87_9 = 0.366666666666667

			if var_87_9 < arg_84_1.time_ and arg_84_1.time_ <= var_87_9 + arg_87_0 then
				local var_87_10 = arg_84_1.var_.effect110
				local var_87_11
				local var_87_12 = var_87_8

				if not var_87_10 then
					var_87_10 = Object.Instantiate(Asset.Load("Effect/Scene/fx_ui_slash_01"), var_87_12)
					var_87_10.name = "110"
					arg_84_1.var_.effect110 = var_87_10
				else
					var_87_10.transform:SetParent(var_87_12)
				end

				var_87_10.transform.localPosition = Vector3.New(0, 0, 0)
				var_87_10.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_87_13 = 0

			if var_87_13 < arg_84_1.time_ and arg_84_1.time_ <= var_87_13 + arg_87_0 then
				arg_84_1.mask_.enabled = true
				arg_84_1.mask_.raycastTarget = false

				arg_84_1:SetGaussion(false)
			end

			local var_87_14 = 0.2

			if var_87_13 <= arg_84_1.time_ and arg_84_1.time_ < var_87_13 + var_87_14 then
				local var_87_15 = (arg_84_1.time_ - var_87_13) / var_87_14
				local var_87_16 = Color.New(0.8679245, 0.1351015, 0.1351015)

				var_87_16.a = Mathf.Lerp(1, 0, var_87_15)
				arg_84_1.mask_.color = var_87_16
			end

			if arg_84_1.time_ >= var_87_13 + var_87_14 and arg_84_1.time_ < var_87_13 + var_87_14 + arg_87_0 then
				local var_87_17 = Color.New(0.8679245, 0.1351015, 0.1351015)
				local var_87_18 = 0

				arg_84_1.mask_.enabled = false
				var_87_17.a = var_87_18
				arg_84_1.mask_.color = var_87_17
			end

			local var_87_19 = 0.2

			if var_87_19 < arg_84_1.time_ and arg_84_1.time_ <= var_87_19 + arg_87_0 then
				arg_84_1.mask_.enabled = true
				arg_84_1.mask_.raycastTarget = false

				arg_84_1:SetGaussion(false)
			end

			local var_87_20 = 0.2

			if var_87_19 <= arg_84_1.time_ and arg_84_1.time_ < var_87_19 + var_87_20 then
				local var_87_21 = (arg_84_1.time_ - var_87_19) / var_87_20
				local var_87_22 = Color.New(0.8679245, 0.1351015, 0.1351015)

				var_87_22.a = Mathf.Lerp(1, 0, var_87_21)
				arg_84_1.mask_.color = var_87_22
			end

			if arg_84_1.time_ >= var_87_19 + var_87_20 and arg_84_1.time_ < var_87_19 + var_87_20 + arg_87_0 then
				local var_87_23 = Color.New(0.8679245, 0.1351015, 0.1351015)
				local var_87_24 = 0

				arg_84_1.mask_.enabled = false
				var_87_23.a = var_87_24
				arg_84_1.mask_.color = var_87_23
			end

			if arg_84_1.frameCnt_ <= 1 then
				arg_84_1.dialog_:SetActive(false)
			end

			local var_87_25 = 0.8
			local var_87_26 = 0.95

			if var_87_25 < arg_84_1.time_ and arg_84_1.time_ <= var_87_25 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0

				arg_84_1.dialog_:SetActive(true)

				arg_84_1.dialogCg_.alpha = 0

				local var_87_27 = LeanTween.value(arg_84_1.dialog_, 0, 1, 0.3)

				var_87_27:setOnUpdate(LuaHelper.FloatAction(function(arg_88_0)
					arg_84_1.dialogCg_.alpha = arg_88_0
				end))
				var_87_27:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_84_1.dialog_)
					var_87_27:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_84_1.duration_ = arg_84_1.duration_ + 0.3

				SetActive(arg_84_1.leftNameGo_, false)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_28 = arg_84_1:GetWordFromCfg(319271020)
				local var_87_29 = arg_84_1:FormatText(var_87_28.content)

				arg_84_1.text_.text = var_87_29

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_30 = 38
				local var_87_31 = utf8.len(var_87_29)
				local var_87_32 = var_87_30 <= 0 and var_87_26 or var_87_26 * (var_87_31 / var_87_30)

				if var_87_32 > 0 and var_87_26 < var_87_32 then
					arg_84_1.talkMaxDuration = var_87_32
					var_87_25 = var_87_25 + 0.3

					if var_87_32 + var_87_25 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_32 + var_87_25
					end
				end

				arg_84_1.text_.text = var_87_29
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)
				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_33 = var_87_25 + 0.3
			local var_87_34 = math.max(var_87_26, arg_84_1.talkMaxDuration)

			if var_87_33 <= arg_84_1.time_ and arg_84_1.time_ < var_87_33 + var_87_34 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_33) / var_87_34

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_33 + var_87_34 and arg_84_1.time_ < var_87_33 + var_87_34 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {}

		arg_84_1:InitPlayNodeList()
	end,
	Play319271021 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 319271021
		arg_90_1.duration_ = 3.13

		local var_90_0 = {
			zh = 1.999999999999,
			ja = 3.133
		}
		local var_90_1 = manager.audio:GetLocalizationFlag()

		if var_90_0[var_90_1] ~= nil then
			arg_90_1.duration_ = var_90_0[var_90_1]
		end

		SetActive(arg_90_1.tipsGo_, false)

		function arg_90_1.onSingleLineFinish_()
			arg_90_1.onSingleLineUpdate_ = nil
			arg_90_1.onSingleLineFinish_ = nil
			arg_90_1.state_ = "waiting"
		end

		function arg_90_1.playNext_(arg_92_0)
			if arg_92_0 == 1 then
				arg_90_0:Play319271022(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			local var_93_0 = arg_90_1.actors_["4040ui_story"].transform
			local var_93_1 = 0

			if var_93_1 < arg_90_1.time_ and arg_90_1.time_ <= var_93_1 + arg_93_0 then
				arg_90_1.var_.moveOldPos4040ui_story = var_93_0.localPosition
			end

			local var_93_2 = 0.001

			if var_93_1 <= arg_90_1.time_ and arg_90_1.time_ < var_93_1 + var_93_2 then
				local var_93_3 = (arg_90_1.time_ - var_93_1) / var_93_2
				local var_93_4 = Vector3.New(0, -1.55, -5.5)

				var_93_0.localPosition = Vector3.Lerp(arg_90_1.var_.moveOldPos4040ui_story, var_93_4, var_93_3)

				local var_93_5 = manager.ui.mainCamera.transform.position - var_93_0.position

				var_93_0.forward = Vector3.New(var_93_5.x, var_93_5.y, var_93_5.z)

				local var_93_6 = var_93_0.localEulerAngles

				var_93_6.z = 0
				var_93_6.x = 0
				var_93_0.localEulerAngles = var_93_6
			end

			if arg_90_1.time_ >= var_93_1 + var_93_2 and arg_90_1.time_ < var_93_1 + var_93_2 + arg_93_0 then
				var_93_0.localPosition = Vector3.New(0, -1.55, -5.5)

				local var_93_7 = manager.ui.mainCamera.transform.position - var_93_0.position

				var_93_0.forward = Vector3.New(var_93_7.x, var_93_7.y, var_93_7.z)

				local var_93_8 = var_93_0.localEulerAngles

				var_93_8.z = 0
				var_93_8.x = 0
				var_93_0.localEulerAngles = var_93_8
			end

			local var_93_9 = arg_90_1.actors_["4040ui_story"]
			local var_93_10 = 0

			if var_93_10 < arg_90_1.time_ and arg_90_1.time_ <= var_93_10 + arg_93_0 and not isNil(var_93_9) and arg_90_1.var_.characterEffect4040ui_story == nil then
				arg_90_1.var_.characterEffect4040ui_story = var_93_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_93_11 = 0.200000002980232

			if var_93_10 <= arg_90_1.time_ and arg_90_1.time_ < var_93_10 + var_93_11 and not isNil(var_93_9) then
				local var_93_12 = (arg_90_1.time_ - var_93_10) / var_93_11

				if arg_90_1.var_.characterEffect4040ui_story and not isNil(var_93_9) then
					arg_90_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_90_1.time_ >= var_93_10 + var_93_11 and arg_90_1.time_ < var_93_10 + var_93_11 + arg_93_0 and not isNil(var_93_9) and arg_90_1.var_.characterEffect4040ui_story then
				arg_90_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_93_13 = 0

			if var_93_13 < arg_90_1.time_ and arg_90_1.time_ <= var_93_13 + arg_93_0 then
				arg_90_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1303cva")
			end

			local var_93_14 = manager.ui.mainCamera.transform
			local var_93_15 = 0

			if var_93_15 < arg_90_1.time_ and arg_90_1.time_ <= var_93_15 + arg_93_0 then
				local var_93_16 = arg_90_1.var_.effect110

				if var_93_16 then
					Object.Destroy(var_93_16)

					arg_90_1.var_.effect110 = nil
				end
			end

			local var_93_17 = 0

			if var_93_17 < arg_90_1.time_ and arg_90_1.time_ <= var_93_17 + arg_93_0 then
				arg_90_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040actionlink/4040action476")
			end

			local var_93_18 = 0
			local var_93_19 = 0.1

			if var_93_18 < arg_90_1.time_ and arg_90_1.time_ <= var_93_18 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				local var_93_20 = arg_90_1:FormatText(StoryNameCfg[668].name)

				arg_90_1.leftNameTxt_.text = var_93_20

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, false)
				arg_90_1.callingController_:SetSelectedState("normal")

				local var_93_21 = arg_90_1:GetWordFromCfg(319271021)
				local var_93_22 = arg_90_1:FormatText(var_93_21.content)

				arg_90_1.text_.text = var_93_22

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_23 = 4
				local var_93_24 = utf8.len(var_93_22)
				local var_93_25 = var_93_23 <= 0 and var_93_19 or var_93_19 * (var_93_24 / var_93_23)

				if var_93_25 > 0 and var_93_19 < var_93_25 then
					arg_90_1.talkMaxDuration = var_93_25

					if var_93_25 + var_93_18 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_25 + var_93_18
					end
				end

				arg_90_1.text_.text = var_93_22
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319271", "319271021", "story_v_out_319271.awb") ~= 0 then
					local var_93_26 = manager.audio:GetVoiceLength("story_v_out_319271", "319271021", "story_v_out_319271.awb") / 1000

					if var_93_26 + var_93_18 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_26 + var_93_18
					end

					if var_93_21.prefab_name ~= "" and arg_90_1.actors_[var_93_21.prefab_name] ~= nil then
						local var_93_27 = LuaForUtil.PlayVoiceWithCriLipsync(arg_90_1.actors_[var_93_21.prefab_name].transform, "story_v_out_319271", "319271021", "story_v_out_319271.awb")

						arg_90_1:RecordAudio("319271021", var_93_27)
						arg_90_1:RecordAudio("319271021", var_93_27)
					else
						arg_90_1:AudioAction("play", "voice", "story_v_out_319271", "319271021", "story_v_out_319271.awb")
					end

					arg_90_1:RecordHistoryTalkVoice("story_v_out_319271", "319271021", "story_v_out_319271.awb")
				end

				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_28 = math.max(var_93_19, arg_90_1.talkMaxDuration)

			if var_93_18 <= arg_90_1.time_ and arg_90_1.time_ < var_93_18 + var_93_28 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_18) / var_93_28

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_18 + var_93_28 and arg_90_1.time_ < var_93_18 + var_93_28 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_90_1:InitPlayNodeList()
	end,
	Play319271022 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 319271022
		arg_94_1.duration_ = 5

		SetActive(arg_94_1.tipsGo_, false)

		function arg_94_1.onSingleLineFinish_()
			arg_94_1.onSingleLineUpdate_ = nil
			arg_94_1.onSingleLineFinish_ = nil
			arg_94_1.state_ = "waiting"
		end

		function arg_94_1.playNext_(arg_96_0)
			if arg_96_0 == 1 then
				arg_94_0:Play319271023(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			local var_97_0 = arg_94_1.actors_["4040ui_story"]
			local var_97_1 = 0

			if var_97_1 < arg_94_1.time_ and arg_94_1.time_ <= var_97_1 + arg_97_0 and not isNil(var_97_0) and arg_94_1.var_.characterEffect4040ui_story == nil then
				arg_94_1.var_.characterEffect4040ui_story = var_97_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_97_2 = 0.2

			if var_97_1 <= arg_94_1.time_ and arg_94_1.time_ < var_97_1 + var_97_2 and not isNil(var_97_0) then
				local var_97_3 = (arg_94_1.time_ - var_97_1) / var_97_2

				if arg_94_1.var_.characterEffect4040ui_story and not isNil(var_97_0) then
					local var_97_4 = Mathf.Lerp(0, 0.5, var_97_3)

					arg_94_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_94_1.var_.characterEffect4040ui_story.fillRatio = var_97_4
				end
			end

			if arg_94_1.time_ >= var_97_1 + var_97_2 and arg_94_1.time_ < var_97_1 + var_97_2 + arg_97_0 and not isNil(var_97_0) and arg_94_1.var_.characterEffect4040ui_story then
				local var_97_5 = 0.5

				arg_94_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_94_1.var_.characterEffect4040ui_story.fillRatio = var_97_5
			end

			local var_97_6 = 0
			local var_97_7 = 1.15

			if var_97_6 < arg_94_1.time_ and arg_94_1.time_ <= var_97_6 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, false)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_8 = arg_94_1:GetWordFromCfg(319271022)
				local var_97_9 = arg_94_1:FormatText(var_97_8.content)

				arg_94_1.text_.text = var_97_9

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_10 = 46
				local var_97_11 = utf8.len(var_97_9)
				local var_97_12 = var_97_10 <= 0 and var_97_7 or var_97_7 * (var_97_11 / var_97_10)

				if var_97_12 > 0 and var_97_7 < var_97_12 then
					arg_94_1.talkMaxDuration = var_97_12

					if var_97_12 + var_97_6 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_12 + var_97_6
					end
				end

				arg_94_1.text_.text = var_97_9
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)
				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_13 = math.max(var_97_7, arg_94_1.talkMaxDuration)

			if var_97_6 <= arg_94_1.time_ and arg_94_1.time_ < var_97_6 + var_97_13 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_6) / var_97_13

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_6 + var_97_13 and arg_94_1.time_ < var_97_6 + var_97_13 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {}

		arg_94_1:InitPlayNodeList()
	end,
	Play319271023 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 319271023
		arg_98_1.duration_ = 3.23

		local var_98_0 = {
			zh = 2.6,
			ja = 3.233
		}
		local var_98_1 = manager.audio:GetLocalizationFlag()

		if var_98_0[var_98_1] ~= nil then
			arg_98_1.duration_ = var_98_0[var_98_1]
		end

		SetActive(arg_98_1.tipsGo_, false)

		function arg_98_1.onSingleLineFinish_()
			arg_98_1.onSingleLineUpdate_ = nil
			arg_98_1.onSingleLineFinish_ = nil
			arg_98_1.state_ = "waiting"
		end

		function arg_98_1.playNext_(arg_100_0)
			if arg_100_0 == 1 then
				arg_98_0:Play319271024(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			local var_101_0 = 0

			if var_101_0 < arg_98_1.time_ and arg_98_1.time_ <= var_101_0 + arg_101_0 then
				arg_98_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action6_2")
			end

			local var_101_1 = 0

			if var_101_1 < arg_98_1.time_ and arg_98_1.time_ <= var_101_1 + arg_101_0 then
				arg_98_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_101_2 = arg_98_1.actors_["4040ui_story"]
			local var_101_3 = 0

			if var_101_3 < arg_98_1.time_ and arg_98_1.time_ <= var_101_3 + arg_101_0 and not isNil(var_101_2) and arg_98_1.var_.characterEffect4040ui_story == nil then
				arg_98_1.var_.characterEffect4040ui_story = var_101_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_101_4 = 0.2

			if var_101_3 <= arg_98_1.time_ and arg_98_1.time_ < var_101_3 + var_101_4 and not isNil(var_101_2) then
				local var_101_5 = (arg_98_1.time_ - var_101_3) / var_101_4

				if arg_98_1.var_.characterEffect4040ui_story and not isNil(var_101_2) then
					arg_98_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_98_1.time_ >= var_101_3 + var_101_4 and arg_98_1.time_ < var_101_3 + var_101_4 + arg_101_0 and not isNil(var_101_2) and arg_98_1.var_.characterEffect4040ui_story then
				arg_98_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_101_6 = 0
			local var_101_7 = 0.225

			if var_101_6 < arg_98_1.time_ and arg_98_1.time_ <= var_101_6 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, true)

				local var_101_8 = arg_98_1:FormatText(StoryNameCfg[668].name)

				arg_98_1.leftNameTxt_.text = var_101_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_9 = arg_98_1:GetWordFromCfg(319271023)
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

				if manager.audio:GetVoiceLength("story_v_out_319271", "319271023", "story_v_out_319271.awb") ~= 0 then
					local var_101_14 = manager.audio:GetVoiceLength("story_v_out_319271", "319271023", "story_v_out_319271.awb") / 1000

					if var_101_14 + var_101_6 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_14 + var_101_6
					end

					if var_101_9.prefab_name ~= "" and arg_98_1.actors_[var_101_9.prefab_name] ~= nil then
						local var_101_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_98_1.actors_[var_101_9.prefab_name].transform, "story_v_out_319271", "319271023", "story_v_out_319271.awb")

						arg_98_1:RecordAudio("319271023", var_101_15)
						arg_98_1:RecordAudio("319271023", var_101_15)
					else
						arg_98_1:AudioAction("play", "voice", "story_v_out_319271", "319271023", "story_v_out_319271.awb")
					end

					arg_98_1:RecordHistoryTalkVoice("story_v_out_319271", "319271023", "story_v_out_319271.awb")
				end

				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_16 = math.max(var_101_7, arg_98_1.talkMaxDuration)

			if var_101_6 <= arg_98_1.time_ and arg_98_1.time_ < var_101_6 + var_101_16 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_6) / var_101_16

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_6 + var_101_16 and arg_98_1.time_ < var_101_6 + var_101_16 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {}

		arg_98_1:InitPlayNodeList()
	end,
	Play319271024 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 319271024
		arg_102_1.duration_ = 7

		SetActive(arg_102_1.tipsGo_, false)

		function arg_102_1.onSingleLineFinish_()
			arg_102_1.onSingleLineUpdate_ = nil
			arg_102_1.onSingleLineFinish_ = nil
			arg_102_1.state_ = "waiting"
		end

		function arg_102_1.playNext_(arg_104_0)
			if arg_104_0 == 1 then
				arg_102_0:Play319271025(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			local var_105_0 = arg_102_1.actors_["4040ui_story"].transform
			local var_105_1 = 1

			if var_105_1 < arg_102_1.time_ and arg_102_1.time_ <= var_105_1 + arg_105_0 then
				arg_102_1.var_.moveOldPos4040ui_story = var_105_0.localPosition
			end

			local var_105_2 = 0.001

			if var_105_1 <= arg_102_1.time_ and arg_102_1.time_ < var_105_1 + var_105_2 then
				local var_105_3 = (arg_102_1.time_ - var_105_1) / var_105_2
				local var_105_4 = Vector3.New(0, 100, 0)

				var_105_0.localPosition = Vector3.Lerp(arg_102_1.var_.moveOldPos4040ui_story, var_105_4, var_105_3)

				local var_105_5 = manager.ui.mainCamera.transform.position - var_105_0.position

				var_105_0.forward = Vector3.New(var_105_5.x, var_105_5.y, var_105_5.z)

				local var_105_6 = var_105_0.localEulerAngles

				var_105_6.z = 0
				var_105_6.x = 0
				var_105_0.localEulerAngles = var_105_6
			end

			if arg_102_1.time_ >= var_105_1 + var_105_2 and arg_102_1.time_ < var_105_1 + var_105_2 + arg_105_0 then
				var_105_0.localPosition = Vector3.New(0, 100, 0)

				local var_105_7 = manager.ui.mainCamera.transform.position - var_105_0.position

				var_105_0.forward = Vector3.New(var_105_7.x, var_105_7.y, var_105_7.z)

				local var_105_8 = var_105_0.localEulerAngles

				var_105_8.z = 0
				var_105_8.x = 0
				var_105_0.localEulerAngles = var_105_8
			end

			local var_105_9 = 0

			if var_105_9 < arg_102_1.time_ and arg_102_1.time_ <= var_105_9 + arg_105_0 then
				local var_105_10 = manager.ui.mainCamera.transform.localPosition
				local var_105_11 = Vector3.New(0, 0, 10) + Vector3.New(var_105_10.x, var_105_10.y, 0)
				local var_105_12 = arg_102_1.bgs_.I11i

				var_105_12.transform.localPosition = var_105_11
				var_105_12.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_105_13 = var_105_12:GetComponent("SpriteRenderer")

				if var_105_13 and var_105_13.sprite then
					local var_105_14 = (var_105_12.transform.localPosition - var_105_10).z
					local var_105_15 = manager.ui.mainCameraCom_
					local var_105_16 = 2 * var_105_14 * Mathf.Tan(var_105_15.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_105_17 = var_105_16 * var_105_15.aspect
					local var_105_18 = var_105_13.sprite.bounds.size.x
					local var_105_19 = var_105_13.sprite.bounds.size.y
					local var_105_20 = var_105_17 / var_105_18
					local var_105_21 = var_105_16 / var_105_19
					local var_105_22 = var_105_21 < var_105_20 and var_105_20 or var_105_21

					var_105_12.transform.localScale = Vector3.New(var_105_22, var_105_22, 0)
				end

				for iter_105_0, iter_105_1 in pairs(arg_102_1.bgs_) do
					if iter_105_0 ~= "I11i" then
						iter_105_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_105_23 = 1

			if var_105_23 < arg_102_1.time_ and arg_102_1.time_ <= var_105_23 + arg_105_0 then
				local var_105_24 = manager.ui.mainCamera.transform.localPosition
				local var_105_25 = Vector3.New(0, 0, 10) + Vector3.New(var_105_24.x, var_105_24.y, 0)
				local var_105_26 = arg_102_1.bgs_.I11i

				var_105_26.transform.localPosition = var_105_25
				var_105_26.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_105_27 = var_105_26:GetComponent("SpriteRenderer")

				if var_105_27 and var_105_27.sprite then
					local var_105_28 = (var_105_26.transform.localPosition - var_105_24).z
					local var_105_29 = manager.ui.mainCameraCom_
					local var_105_30 = 2 * var_105_28 * Mathf.Tan(var_105_29.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_105_31 = var_105_30 * var_105_29.aspect
					local var_105_32 = var_105_27.sprite.bounds.size.x
					local var_105_33 = var_105_27.sprite.bounds.size.y
					local var_105_34 = var_105_31 / var_105_32
					local var_105_35 = var_105_30 / var_105_33
					local var_105_36 = var_105_35 < var_105_34 and var_105_34 or var_105_35

					var_105_26.transform.localScale = Vector3.New(var_105_36, var_105_36, 0)
				end

				for iter_105_2, iter_105_3 in pairs(arg_102_1.bgs_) do
					if iter_105_2 ~= "I11i" then
						iter_105_3.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_105_37 = 0

			if var_105_37 < arg_102_1.time_ and arg_102_1.time_ <= var_105_37 + arg_105_0 then
				arg_102_1.mask_.enabled = true
				arg_102_1.mask_.raycastTarget = true

				arg_102_1:SetGaussion(false)
			end

			local var_105_38 = 1

			if var_105_37 <= arg_102_1.time_ and arg_102_1.time_ < var_105_37 + var_105_38 then
				local var_105_39 = (arg_102_1.time_ - var_105_37) / var_105_38
				local var_105_40 = Color.New(0, 0, 0)

				var_105_40.a = Mathf.Lerp(0, 1, var_105_39)
				arg_102_1.mask_.color = var_105_40
			end

			if arg_102_1.time_ >= var_105_37 + var_105_38 and arg_102_1.time_ < var_105_37 + var_105_38 + arg_105_0 then
				local var_105_41 = Color.New(0, 0, 0)

				var_105_41.a = 1
				arg_102_1.mask_.color = var_105_41
			end

			local var_105_42 = 1

			if var_105_42 < arg_102_1.time_ and arg_102_1.time_ <= var_105_42 + arg_105_0 then
				arg_102_1.mask_.enabled = true
				arg_102_1.mask_.raycastTarget = true

				arg_102_1:SetGaussion(false)
			end

			local var_105_43 = 1

			if var_105_42 <= arg_102_1.time_ and arg_102_1.time_ < var_105_42 + var_105_43 then
				local var_105_44 = (arg_102_1.time_ - var_105_42) / var_105_43
				local var_105_45 = Color.New(0, 0, 0)

				var_105_45.a = Mathf.Lerp(1, 0, var_105_44)
				arg_102_1.mask_.color = var_105_45
			end

			if arg_102_1.time_ >= var_105_42 + var_105_43 and arg_102_1.time_ < var_105_42 + var_105_43 + arg_105_0 then
				local var_105_46 = Color.New(0, 0, 0)
				local var_105_47 = 0

				arg_102_1.mask_.enabled = false
				var_105_46.a = var_105_47
				arg_102_1.mask_.color = var_105_46
			end

			if arg_102_1.frameCnt_ <= 1 then
				arg_102_1.dialog_:SetActive(false)
			end

			local var_105_48 = 2
			local var_105_49 = 1.325

			if var_105_48 < arg_102_1.time_ and arg_102_1.time_ <= var_105_48 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0

				arg_102_1.dialog_:SetActive(true)

				arg_102_1.dialogCg_.alpha = 0

				local var_105_50 = LeanTween.value(arg_102_1.dialog_, 0, 1, 0.3)

				var_105_50:setOnUpdate(LuaHelper.FloatAction(function(arg_106_0)
					arg_102_1.dialogCg_.alpha = arg_106_0
				end))
				var_105_50:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_102_1.dialog_)
					var_105_50:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_102_1.duration_ = arg_102_1.duration_ + 0.3

				SetActive(arg_102_1.leftNameGo_, false)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_102_1.iconTrs_.gameObject, false)
				arg_102_1.callingController_:SetSelectedState("normal")

				local var_105_51 = arg_102_1:GetWordFromCfg(319271024)
				local var_105_52 = arg_102_1:FormatText(var_105_51.content)

				arg_102_1.text_.text = var_105_52

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_53 = 53
				local var_105_54 = utf8.len(var_105_52)
				local var_105_55 = var_105_53 <= 0 and var_105_49 or var_105_49 * (var_105_54 / var_105_53)

				if var_105_55 > 0 and var_105_49 < var_105_55 then
					arg_102_1.talkMaxDuration = var_105_55
					var_105_48 = var_105_48 + 0.3

					if var_105_55 + var_105_48 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_55 + var_105_48
					end
				end

				arg_102_1.text_.text = var_105_52
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)
				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_56 = var_105_48 + 0.3
			local var_105_57 = math.max(var_105_49, arg_102_1.talkMaxDuration)

			if var_105_56 <= arg_102_1.time_ and arg_102_1.time_ < var_105_56 + var_105_57 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - var_105_56) / var_105_57

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= var_105_56 + var_105_57 and arg_102_1.time_ < var_105_56 + var_105_57 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_102_1:InitPlayNodeList()
	end,
	Play319271025 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 319271025
		arg_108_1.duration_ = 3.93

		local var_108_0 = {
			zh = 2.533,
			ja = 3.933
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
				arg_108_0:Play319271026(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			local var_111_0 = 0
			local var_111_1 = 0.2

			if var_111_0 < arg_108_1.time_ and arg_108_1.time_ <= var_111_0 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				local var_111_2 = arg_108_1:FormatText(StoryNameCfg[721].name)

				arg_108_1.leftNameTxt_.text = var_111_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, true)
				arg_108_1.iconController_:SetSelectedState("hero")

				arg_108_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10090")

				arg_108_1.callingController_:SetSelectedState("normal")

				arg_108_1.keyicon_.color = Color.New(1, 1, 1)
				arg_108_1.icon_.color = Color.New(1, 1, 1)

				local var_111_3 = arg_108_1:GetWordFromCfg(319271025)
				local var_111_4 = arg_108_1:FormatText(var_111_3.content)

				arg_108_1.text_.text = var_111_4

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_5 = 8
				local var_111_6 = utf8.len(var_111_4)
				local var_111_7 = var_111_5 <= 0 and var_111_1 or var_111_1 * (var_111_6 / var_111_5)

				if var_111_7 > 0 and var_111_1 < var_111_7 then
					arg_108_1.talkMaxDuration = var_111_7

					if var_111_7 + var_111_0 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_7 + var_111_0
					end
				end

				arg_108_1.text_.text = var_111_4
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319271", "319271025", "story_v_out_319271.awb") ~= 0 then
					local var_111_8 = manager.audio:GetVoiceLength("story_v_out_319271", "319271025", "story_v_out_319271.awb") / 1000

					if var_111_8 + var_111_0 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_8 + var_111_0
					end

					if var_111_3.prefab_name ~= "" and arg_108_1.actors_[var_111_3.prefab_name] ~= nil then
						local var_111_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_108_1.actors_[var_111_3.prefab_name].transform, "story_v_out_319271", "319271025", "story_v_out_319271.awb")

						arg_108_1:RecordAudio("319271025", var_111_9)
						arg_108_1:RecordAudio("319271025", var_111_9)
					else
						arg_108_1:AudioAction("play", "voice", "story_v_out_319271", "319271025", "story_v_out_319271.awb")
					end

					arg_108_1:RecordHistoryTalkVoice("story_v_out_319271", "319271025", "story_v_out_319271.awb")
				end

				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_10 = math.max(var_111_1, arg_108_1.talkMaxDuration)

			if var_111_0 <= arg_108_1.time_ and arg_108_1.time_ < var_111_0 + var_111_10 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_0) / var_111_10

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_0 + var_111_10 and arg_108_1.time_ < var_111_0 + var_111_10 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {}

		arg_108_1:InitPlayNodeList()
	end,
	Play319271026 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 319271026
		arg_112_1.duration_ = 5

		SetActive(arg_112_1.tipsGo_, false)

		function arg_112_1.onSingleLineFinish_()
			arg_112_1.onSingleLineUpdate_ = nil
			arg_112_1.onSingleLineFinish_ = nil
			arg_112_1.state_ = "waiting"
		end

		function arg_112_1.playNext_(arg_114_0)
			if arg_114_0 == 1 then
				arg_112_0:Play319271027(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			local var_115_0 = 0
			local var_115_1 = 1.325

			if var_115_0 < arg_112_1.time_ and arg_112_1.time_ <= var_115_0 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, false)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_112_1.iconTrs_.gameObject, false)
				arg_112_1.callingController_:SetSelectedState("normal")

				local var_115_2 = arg_112_1:GetWordFromCfg(319271026)
				local var_115_3 = arg_112_1:FormatText(var_115_2.content)

				arg_112_1.text_.text = var_115_3

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_4 = 53
				local var_115_5 = utf8.len(var_115_3)
				local var_115_6 = var_115_4 <= 0 and var_115_1 or var_115_1 * (var_115_5 / var_115_4)

				if var_115_6 > 0 and var_115_1 < var_115_6 then
					arg_112_1.talkMaxDuration = var_115_6

					if var_115_6 + var_115_0 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_6 + var_115_0
					end
				end

				arg_112_1.text_.text = var_115_3
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)
				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_7 = math.max(var_115_1, arg_112_1.talkMaxDuration)

			if var_115_0 <= arg_112_1.time_ and arg_112_1.time_ < var_115_0 + var_115_7 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_0) / var_115_7

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_0 + var_115_7 and arg_112_1.time_ < var_115_0 + var_115_7 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {}

		arg_112_1:InitPlayNodeList()
	end,
	Play319271027 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 319271027
		arg_116_1.duration_ = 5

		SetActive(arg_116_1.tipsGo_, false)

		function arg_116_1.onSingleLineFinish_()
			arg_116_1.onSingleLineUpdate_ = nil
			arg_116_1.onSingleLineFinish_ = nil
			arg_116_1.state_ = "waiting"
		end

		function arg_116_1.playNext_(arg_118_0)
			if arg_118_0 == 1 then
				arg_116_0:Play319271028(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			local var_119_0 = 0
			local var_119_1 = 1.025

			if var_119_0 < arg_116_1.time_ and arg_116_1.time_ <= var_119_0 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, false)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_2 = arg_116_1:GetWordFromCfg(319271027)
				local var_119_3 = arg_116_1:FormatText(var_119_2.content)

				arg_116_1.text_.text = var_119_3

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_4 = 41
				local var_119_5 = utf8.len(var_119_3)
				local var_119_6 = var_119_4 <= 0 and var_119_1 or var_119_1 * (var_119_5 / var_119_4)

				if var_119_6 > 0 and var_119_1 < var_119_6 then
					arg_116_1.talkMaxDuration = var_119_6

					if var_119_6 + var_119_0 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_6 + var_119_0
					end
				end

				arg_116_1.text_.text = var_119_3
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)
				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_7 = math.max(var_119_1, arg_116_1.talkMaxDuration)

			if var_119_0 <= arg_116_1.time_ and arg_116_1.time_ < var_119_0 + var_119_7 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_0) / var_119_7

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_0 + var_119_7 and arg_116_1.time_ < var_119_0 + var_119_7 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {}

		arg_116_1:InitPlayNodeList()
	end,
	Play319271028 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 319271028
		arg_120_1.duration_ = 6.4

		SetActive(arg_120_1.tipsGo_, false)

		function arg_120_1.onSingleLineFinish_()
			arg_120_1.onSingleLineUpdate_ = nil
			arg_120_1.onSingleLineFinish_ = nil
			arg_120_1.state_ = "waiting"
		end

		function arg_120_1.playNext_(arg_122_0)
			if arg_122_0 == 1 then
				arg_120_0:Play319271029(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			local var_123_0 = 0
			local var_123_1 = 1

			if var_123_0 < arg_120_1.time_ and arg_120_1.time_ <= var_123_0 + arg_123_0 then
				local var_123_2 = "play"
				local var_123_3 = "effect"

				arg_120_1:AudioAction(var_123_2, var_123_3, "se_story_122_03", "se_story_122_03_swordlightbroken", "")
			end

			local var_123_4 = manager.ui.mainCamera.transform
			local var_123_5 = 0.4

			if var_123_5 < arg_120_1.time_ and arg_120_1.time_ <= var_123_5 + arg_123_0 then
				arg_120_1.var_.shakeOldPos = var_123_4.localPosition
			end

			local var_123_6 = 1.16666666666667

			if var_123_5 <= arg_120_1.time_ and arg_120_1.time_ < var_123_5 + var_123_6 then
				local var_123_7 = (arg_120_1.time_ - var_123_5) / 0.066
				local var_123_8, var_123_9 = math.modf(var_123_7)

				var_123_4.localPosition = Vector3.New(var_123_9 * 0.13, var_123_9 * 0.13, var_123_9 * 0.13) + arg_120_1.var_.shakeOldPos
			end

			if arg_120_1.time_ >= var_123_5 + var_123_6 and arg_120_1.time_ < var_123_5 + var_123_6 + arg_123_0 then
				var_123_4.localPosition = arg_120_1.var_.shakeOldPos
			end

			local var_123_10 = 0

			if var_123_10 < arg_120_1.time_ and arg_120_1.time_ <= var_123_10 + arg_123_0 then
				arg_120_1.mask_.enabled = true
				arg_120_1.mask_.raycastTarget = false

				arg_120_1:SetGaussion(false)
			end

			local var_123_11 = 0.733333333333333

			if var_123_10 <= arg_120_1.time_ and arg_120_1.time_ < var_123_10 + var_123_11 then
				local var_123_12 = (arg_120_1.time_ - var_123_10) / var_123_11
				local var_123_13 = Color.New(1, 1, 1)

				var_123_13.a = Mathf.Lerp(1, 0, var_123_12)
				arg_120_1.mask_.color = var_123_13
			end

			if arg_120_1.time_ >= var_123_10 + var_123_11 and arg_120_1.time_ < var_123_10 + var_123_11 + arg_123_0 then
				local var_123_14 = Color.New(1, 1, 1)
				local var_123_15 = 0

				arg_120_1.mask_.enabled = false
				var_123_14.a = var_123_15
				arg_120_1.mask_.color = var_123_14
			end

			if arg_120_1.frameCnt_ <= 1 then
				arg_120_1.dialog_:SetActive(false)
			end

			local var_123_16 = 1.4
			local var_123_17 = 1.4

			if var_123_16 < arg_120_1.time_ and arg_120_1.time_ <= var_123_16 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0

				arg_120_1.dialog_:SetActive(true)

				arg_120_1.dialogCg_.alpha = 0

				local var_123_18 = LeanTween.value(arg_120_1.dialog_, 0, 1, 0.3)

				var_123_18:setOnUpdate(LuaHelper.FloatAction(function(arg_124_0)
					arg_120_1.dialogCg_.alpha = arg_124_0
				end))
				var_123_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_120_1.dialog_)
					var_123_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_120_1.duration_ = arg_120_1.duration_ + 0.3

				SetActive(arg_120_1.leftNameGo_, false)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_120_1.iconTrs_.gameObject, false)
				arg_120_1.callingController_:SetSelectedState("normal")

				local var_123_19 = arg_120_1:GetWordFromCfg(319271028)
				local var_123_20 = arg_120_1:FormatText(var_123_19.content)

				arg_120_1.text_.text = var_123_20

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_21 = 56
				local var_123_22 = utf8.len(var_123_20)
				local var_123_23 = var_123_21 <= 0 and var_123_17 or var_123_17 * (var_123_22 / var_123_21)

				if var_123_23 > 0 and var_123_17 < var_123_23 then
					arg_120_1.talkMaxDuration = var_123_23
					var_123_16 = var_123_16 + 0.3

					if var_123_23 + var_123_16 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_23 + var_123_16
					end
				end

				arg_120_1.text_.text = var_123_20
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)
				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_24 = var_123_16 + 0.3
			local var_123_25 = math.max(var_123_17, arg_120_1.talkMaxDuration)

			if var_123_24 <= arg_120_1.time_ and arg_120_1.time_ < var_123_24 + var_123_25 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_24) / var_123_25

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_24 + var_123_25 and arg_120_1.time_ < var_123_24 + var_123_25 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {}

		arg_120_1:InitPlayNodeList()
	end,
	Play319271029 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 319271029
		arg_126_1.duration_ = 2

		SetActive(arg_126_1.tipsGo_, false)

		function arg_126_1.onSingleLineFinish_()
			arg_126_1.onSingleLineUpdate_ = nil
			arg_126_1.onSingleLineFinish_ = nil
			arg_126_1.state_ = "waiting"
		end

		function arg_126_1.playNext_(arg_128_0)
			if arg_128_0 == 1 then
				arg_126_0:Play319271030(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			local var_129_0 = arg_126_1.actors_["4040ui_story"].transform
			local var_129_1 = 0

			if var_129_1 < arg_126_1.time_ and arg_126_1.time_ <= var_129_1 + arg_129_0 then
				arg_126_1.var_.moveOldPos4040ui_story = var_129_0.localPosition
			end

			local var_129_2 = 0.001

			if var_129_1 <= arg_126_1.time_ and arg_126_1.time_ < var_129_1 + var_129_2 then
				local var_129_3 = (arg_126_1.time_ - var_129_1) / var_129_2
				local var_129_4 = Vector3.New(0, -1.55, -5.5)

				var_129_0.localPosition = Vector3.Lerp(arg_126_1.var_.moveOldPos4040ui_story, var_129_4, var_129_3)

				local var_129_5 = manager.ui.mainCamera.transform.position - var_129_0.position

				var_129_0.forward = Vector3.New(var_129_5.x, var_129_5.y, var_129_5.z)

				local var_129_6 = var_129_0.localEulerAngles

				var_129_6.z = 0
				var_129_6.x = 0
				var_129_0.localEulerAngles = var_129_6
			end

			if arg_126_1.time_ >= var_129_1 + var_129_2 and arg_126_1.time_ < var_129_1 + var_129_2 + arg_129_0 then
				var_129_0.localPosition = Vector3.New(0, -1.55, -5.5)

				local var_129_7 = manager.ui.mainCamera.transform.position - var_129_0.position

				var_129_0.forward = Vector3.New(var_129_7.x, var_129_7.y, var_129_7.z)

				local var_129_8 = var_129_0.localEulerAngles

				var_129_8.z = 0
				var_129_8.x = 0
				var_129_0.localEulerAngles = var_129_8
			end

			local var_129_9 = arg_126_1.actors_["4040ui_story"]
			local var_129_10 = 0

			if var_129_10 < arg_126_1.time_ and arg_126_1.time_ <= var_129_10 + arg_129_0 and not isNil(var_129_9) and arg_126_1.var_.characterEffect4040ui_story == nil then
				arg_126_1.var_.characterEffect4040ui_story = var_129_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_129_11 = 0.200000002980232

			if var_129_10 <= arg_126_1.time_ and arg_126_1.time_ < var_129_10 + var_129_11 and not isNil(var_129_9) then
				local var_129_12 = (arg_126_1.time_ - var_129_10) / var_129_11

				if arg_126_1.var_.characterEffect4040ui_story and not isNil(var_129_9) then
					arg_126_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_126_1.time_ >= var_129_10 + var_129_11 and arg_126_1.time_ < var_129_10 + var_129_11 + arg_129_0 and not isNil(var_129_9) and arg_126_1.var_.characterEffect4040ui_story then
				arg_126_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_129_13 = 0

			if var_129_13 < arg_126_1.time_ and arg_126_1.time_ <= var_129_13 + arg_129_0 then
				arg_126_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			local var_129_14 = 0

			if var_129_14 < arg_126_1.time_ and arg_126_1.time_ <= var_129_14 + arg_129_0 then
				arg_126_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_129_15 = 0
			local var_129_16 = 0.1

			if var_129_15 < arg_126_1.time_ and arg_126_1.time_ <= var_129_15 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0
				arg_126_1.dialogCg_.alpha = 1

				arg_126_1.dialog_:SetActive(true)
				SetActive(arg_126_1.leftNameGo_, true)

				local var_129_17 = arg_126_1:FormatText(StoryNameCfg[668].name)

				arg_126_1.leftNameTxt_.text = var_129_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_126_1.leftNameTxt_.transform)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1.leftNameTxt_.text)
				SetActive(arg_126_1.iconTrs_.gameObject, false)
				arg_126_1.callingController_:SetSelectedState("normal")

				local var_129_18 = arg_126_1:GetWordFromCfg(319271029)
				local var_129_19 = arg_126_1:FormatText(var_129_18.content)

				arg_126_1.text_.text = var_129_19

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_20 = 4
				local var_129_21 = utf8.len(var_129_19)
				local var_129_22 = var_129_20 <= 0 and var_129_16 or var_129_16 * (var_129_21 / var_129_20)

				if var_129_22 > 0 and var_129_16 < var_129_22 then
					arg_126_1.talkMaxDuration = var_129_22

					if var_129_22 + var_129_15 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_22 + var_129_15
					end
				end

				arg_126_1.text_.text = var_129_19
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319271", "319271029", "story_v_out_319271.awb") ~= 0 then
					local var_129_23 = manager.audio:GetVoiceLength("story_v_out_319271", "319271029", "story_v_out_319271.awb") / 1000

					if var_129_23 + var_129_15 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_23 + var_129_15
					end

					if var_129_18.prefab_name ~= "" and arg_126_1.actors_[var_129_18.prefab_name] ~= nil then
						local var_129_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_126_1.actors_[var_129_18.prefab_name].transform, "story_v_out_319271", "319271029", "story_v_out_319271.awb")

						arg_126_1:RecordAudio("319271029", var_129_24)
						arg_126_1:RecordAudio("319271029", var_129_24)
					else
						arg_126_1:AudioAction("play", "voice", "story_v_out_319271", "319271029", "story_v_out_319271.awb")
					end

					arg_126_1:RecordHistoryTalkVoice("story_v_out_319271", "319271029", "story_v_out_319271.awb")
				end

				arg_126_1:RecordContent(arg_126_1.text_.text)
			end

			local var_129_25 = math.max(var_129_16, arg_126_1.talkMaxDuration)

			if var_129_15 <= arg_126_1.time_ and arg_126_1.time_ < var_129_15 + var_129_25 then
				arg_126_1.typewritter.percent = (arg_126_1.time_ - var_129_15) / var_129_25

				arg_126_1.typewritter:SetDirty()
			end

			if arg_126_1.time_ >= var_129_15 + var_129_25 and arg_126_1.time_ < var_129_15 + var_129_25 + arg_129_0 then
				arg_126_1.typewritter.percent = 1

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(true)
			end
		end

		arg_126_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_126_1:InitPlayNodeList()
	end,
	Play319271030 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 319271030
		arg_130_1.duration_ = 2.23

		local var_130_0 = {
			zh = 1.866,
			ja = 2.233
		}
		local var_130_1 = manager.audio:GetLocalizationFlag()

		if var_130_0[var_130_1] ~= nil then
			arg_130_1.duration_ = var_130_0[var_130_1]
		end

		SetActive(arg_130_1.tipsGo_, false)

		function arg_130_1.onSingleLineFinish_()
			arg_130_1.onSingleLineUpdate_ = nil
			arg_130_1.onSingleLineFinish_ = nil
			arg_130_1.state_ = "waiting"
		end

		function arg_130_1.playNext_(arg_132_0)
			if arg_132_0 == 1 then
				arg_130_0:Play319271031(arg_130_1)
			end
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			local var_133_0 = arg_130_1.actors_["4040ui_story"]
			local var_133_1 = 0

			if var_133_1 < arg_130_1.time_ and arg_130_1.time_ <= var_133_1 + arg_133_0 and not isNil(var_133_0) and arg_130_1.var_.characterEffect4040ui_story == nil then
				arg_130_1.var_.characterEffect4040ui_story = var_133_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_133_2 = 0.200000002980232

			if var_133_1 <= arg_130_1.time_ and arg_130_1.time_ < var_133_1 + var_133_2 and not isNil(var_133_0) then
				local var_133_3 = (arg_130_1.time_ - var_133_1) / var_133_2

				if arg_130_1.var_.characterEffect4040ui_story and not isNil(var_133_0) then
					local var_133_4 = Mathf.Lerp(0, 0.5, var_133_3)

					arg_130_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_130_1.var_.characterEffect4040ui_story.fillRatio = var_133_4
				end
			end

			if arg_130_1.time_ >= var_133_1 + var_133_2 and arg_130_1.time_ < var_133_1 + var_133_2 + arg_133_0 and not isNil(var_133_0) and arg_130_1.var_.characterEffect4040ui_story then
				local var_133_5 = 0.5

				arg_130_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_130_1.var_.characterEffect4040ui_story.fillRatio = var_133_5
			end

			local var_133_6 = arg_130_1.actors_["4040ui_story"].transform
			local var_133_7 = 0

			if var_133_7 < arg_130_1.time_ and arg_130_1.time_ <= var_133_7 + arg_133_0 then
				arg_130_1.var_.moveOldPos4040ui_story = var_133_6.localPosition
			end

			local var_133_8 = 0.001

			if var_133_7 <= arg_130_1.time_ and arg_130_1.time_ < var_133_7 + var_133_8 then
				local var_133_9 = (arg_130_1.time_ - var_133_7) / var_133_8
				local var_133_10 = Vector3.New(0, 100, 0)

				var_133_6.localPosition = Vector3.Lerp(arg_130_1.var_.moveOldPos4040ui_story, var_133_10, var_133_9)

				local var_133_11 = manager.ui.mainCamera.transform.position - var_133_6.position

				var_133_6.forward = Vector3.New(var_133_11.x, var_133_11.y, var_133_11.z)

				local var_133_12 = var_133_6.localEulerAngles

				var_133_12.z = 0
				var_133_12.x = 0
				var_133_6.localEulerAngles = var_133_12
			end

			if arg_130_1.time_ >= var_133_7 + var_133_8 and arg_130_1.time_ < var_133_7 + var_133_8 + arg_133_0 then
				var_133_6.localPosition = Vector3.New(0, 100, 0)

				local var_133_13 = manager.ui.mainCamera.transform.position - var_133_6.position

				var_133_6.forward = Vector3.New(var_133_13.x, var_133_13.y, var_133_13.z)

				local var_133_14 = var_133_6.localEulerAngles

				var_133_14.z = 0
				var_133_14.x = 0
				var_133_6.localEulerAngles = var_133_14
			end

			local var_133_15 = 0
			local var_133_16 = 0.125

			if var_133_15 < arg_130_1.time_ and arg_130_1.time_ <= var_133_15 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0
				arg_130_1.dialogCg_.alpha = 1

				arg_130_1.dialog_:SetActive(true)
				SetActive(arg_130_1.leftNameGo_, true)

				local var_133_17 = arg_130_1:FormatText(StoryNameCfg[721].name)

				arg_130_1.leftNameTxt_.text = var_133_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_130_1.leftNameTxt_.transform)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1.leftNameTxt_.text)
				SetActive(arg_130_1.iconTrs_.gameObject, true)
				arg_130_1.iconController_:SetSelectedState("hero")

				arg_130_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10090")

				arg_130_1.callingController_:SetSelectedState("normal")

				arg_130_1.keyicon_.color = Color.New(1, 1, 1)
				arg_130_1.icon_.color = Color.New(1, 1, 1)

				local var_133_18 = arg_130_1:GetWordFromCfg(319271030)
				local var_133_19 = arg_130_1:FormatText(var_133_18.content)

				arg_130_1.text_.text = var_133_19

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_20 = 5
				local var_133_21 = utf8.len(var_133_19)
				local var_133_22 = var_133_20 <= 0 and var_133_16 or var_133_16 * (var_133_21 / var_133_20)

				if var_133_22 > 0 and var_133_16 < var_133_22 then
					arg_130_1.talkMaxDuration = var_133_22

					if var_133_22 + var_133_15 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_22 + var_133_15
					end
				end

				arg_130_1.text_.text = var_133_19
				arg_130_1.typewritter.percent = 0

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319271", "319271030", "story_v_out_319271.awb") ~= 0 then
					local var_133_23 = manager.audio:GetVoiceLength("story_v_out_319271", "319271030", "story_v_out_319271.awb") / 1000

					if var_133_23 + var_133_15 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_23 + var_133_15
					end

					if var_133_18.prefab_name ~= "" and arg_130_1.actors_[var_133_18.prefab_name] ~= nil then
						local var_133_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_130_1.actors_[var_133_18.prefab_name].transform, "story_v_out_319271", "319271030", "story_v_out_319271.awb")

						arg_130_1:RecordAudio("319271030", var_133_24)
						arg_130_1:RecordAudio("319271030", var_133_24)
					else
						arg_130_1:AudioAction("play", "voice", "story_v_out_319271", "319271030", "story_v_out_319271.awb")
					end

					arg_130_1:RecordHistoryTalkVoice("story_v_out_319271", "319271030", "story_v_out_319271.awb")
				end

				arg_130_1:RecordContent(arg_130_1.text_.text)
			end

			local var_133_25 = math.max(var_133_16, arg_130_1.talkMaxDuration)

			if var_133_15 <= arg_130_1.time_ and arg_130_1.time_ < var_133_15 + var_133_25 then
				arg_130_1.typewritter.percent = (arg_130_1.time_ - var_133_15) / var_133_25

				arg_130_1.typewritter:SetDirty()
			end

			if arg_130_1.time_ >= var_133_15 + var_133_25 and arg_130_1.time_ < var_133_15 + var_133_25 + arg_133_0 then
				arg_130_1.typewritter.percent = 1

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(true)
			end
		end

		arg_130_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
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
	Play319271031 = function(arg_134_0, arg_134_1)
		arg_134_1.time_ = 0
		arg_134_1.frameCnt_ = 0
		arg_134_1.state_ = "playing"
		arg_134_1.curTalkId_ = 319271031
		arg_134_1.duration_ = 5

		SetActive(arg_134_1.tipsGo_, false)

		function arg_134_1.onSingleLineFinish_()
			arg_134_1.onSingleLineUpdate_ = nil
			arg_134_1.onSingleLineFinish_ = nil
			arg_134_1.state_ = "waiting"
		end

		function arg_134_1.playNext_(arg_136_0)
			if arg_136_0 == 1 then
				arg_134_0:Play319271032(arg_134_1)
			end
		end

		function arg_134_1.onSingleLineUpdate_(arg_137_0)
			local var_137_0 = arg_134_1.actors_["4040ui_story"].transform
			local var_137_1 = 0

			if var_137_1 < arg_134_1.time_ and arg_134_1.time_ <= var_137_1 + arg_137_0 then
				arg_134_1.var_.moveOldPos4040ui_story = var_137_0.localPosition
			end

			local var_137_2 = 0.001

			if var_137_1 <= arg_134_1.time_ and arg_134_1.time_ < var_137_1 + var_137_2 then
				local var_137_3 = (arg_134_1.time_ - var_137_1) / var_137_2
				local var_137_4 = Vector3.New(0, 100, 0)

				var_137_0.localPosition = Vector3.Lerp(arg_134_1.var_.moveOldPos4040ui_story, var_137_4, var_137_3)

				local var_137_5 = manager.ui.mainCamera.transform.position - var_137_0.position

				var_137_0.forward = Vector3.New(var_137_5.x, var_137_5.y, var_137_5.z)

				local var_137_6 = var_137_0.localEulerAngles

				var_137_6.z = 0
				var_137_6.x = 0
				var_137_0.localEulerAngles = var_137_6
			end

			if arg_134_1.time_ >= var_137_1 + var_137_2 and arg_134_1.time_ < var_137_1 + var_137_2 + arg_137_0 then
				var_137_0.localPosition = Vector3.New(0, 100, 0)

				local var_137_7 = manager.ui.mainCamera.transform.position - var_137_0.position

				var_137_0.forward = Vector3.New(var_137_7.x, var_137_7.y, var_137_7.z)

				local var_137_8 = var_137_0.localEulerAngles

				var_137_8.z = 0
				var_137_8.x = 0
				var_137_0.localEulerAngles = var_137_8
			end

			local var_137_9 = 0
			local var_137_10 = 0.725

			if var_137_9 < arg_134_1.time_ and arg_134_1.time_ <= var_137_9 + arg_137_0 then
				arg_134_1.talkMaxDuration = 0
				arg_134_1.dialogCg_.alpha = 1

				arg_134_1.dialog_:SetActive(true)
				SetActive(arg_134_1.leftNameGo_, false)

				arg_134_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_134_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_134_1:RecordName(arg_134_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_134_1.iconTrs_.gameObject, false)
				arg_134_1.callingController_:SetSelectedState("normal")

				local var_137_11 = arg_134_1:GetWordFromCfg(319271031)
				local var_137_12 = arg_134_1:FormatText(var_137_11.content)

				arg_134_1.text_.text = var_137_12

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.text_)

				local var_137_13 = 29
				local var_137_14 = utf8.len(var_137_12)
				local var_137_15 = var_137_13 <= 0 and var_137_10 or var_137_10 * (var_137_14 / var_137_13)

				if var_137_15 > 0 and var_137_10 < var_137_15 then
					arg_134_1.talkMaxDuration = var_137_15

					if var_137_15 + var_137_9 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_15 + var_137_9
					end
				end

				arg_134_1.text_.text = var_137_12
				arg_134_1.typewritter.percent = 0

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(false)
				arg_134_1:RecordContent(arg_134_1.text_.text)
			end

			local var_137_16 = math.max(var_137_10, arg_134_1.talkMaxDuration)

			if var_137_9 <= arg_134_1.time_ and arg_134_1.time_ < var_137_9 + var_137_16 then
				arg_134_1.typewritter.percent = (arg_134_1.time_ - var_137_9) / var_137_16

				arg_134_1.typewritter:SetDirty()
			end

			if arg_134_1.time_ >= var_137_9 + var_137_16 and arg_134_1.time_ < var_137_9 + var_137_16 + arg_137_0 then
				arg_134_1.typewritter.percent = 1

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(true)
			end
		end

		arg_134_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_134_1:InitPlayNodeList()
	end,
	Play319271032 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 319271032
		arg_138_1.duration_ = 5

		SetActive(arg_138_1.tipsGo_, false)

		function arg_138_1.onSingleLineFinish_()
			arg_138_1.onSingleLineUpdate_ = nil
			arg_138_1.onSingleLineFinish_ = nil
			arg_138_1.state_ = "waiting"
		end

		function arg_138_1.playNext_(arg_140_0)
			if arg_140_0 == 1 then
				arg_138_0:Play319271033(arg_138_1)
			end
		end

		function arg_138_1.onSingleLineUpdate_(arg_141_0)
			local var_141_0 = 0
			local var_141_1 = 1.25

			if var_141_0 < arg_138_1.time_ and arg_138_1.time_ <= var_141_0 + arg_141_0 then
				arg_138_1.talkMaxDuration = 0
				arg_138_1.dialogCg_.alpha = 1

				arg_138_1.dialog_:SetActive(true)
				SetActive(arg_138_1.leftNameGo_, false)

				arg_138_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_138_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_138_1:RecordName(arg_138_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_138_1.iconTrs_.gameObject, false)
				arg_138_1.callingController_:SetSelectedState("normal")

				local var_141_2 = arg_138_1:GetWordFromCfg(319271032)
				local var_141_3 = arg_138_1:FormatText(var_141_2.content)

				arg_138_1.text_.text = var_141_3

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.text_)

				local var_141_4 = 50
				local var_141_5 = utf8.len(var_141_3)
				local var_141_6 = var_141_4 <= 0 and var_141_1 or var_141_1 * (var_141_5 / var_141_4)

				if var_141_6 > 0 and var_141_1 < var_141_6 then
					arg_138_1.talkMaxDuration = var_141_6

					if var_141_6 + var_141_0 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_6 + var_141_0
					end
				end

				arg_138_1.text_.text = var_141_3
				arg_138_1.typewritter.percent = 0

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(false)
				arg_138_1:RecordContent(arg_138_1.text_.text)
			end

			local var_141_7 = math.max(var_141_1, arg_138_1.talkMaxDuration)

			if var_141_0 <= arg_138_1.time_ and arg_138_1.time_ < var_141_0 + var_141_7 then
				arg_138_1.typewritter.percent = (arg_138_1.time_ - var_141_0) / var_141_7

				arg_138_1.typewritter:SetDirty()
			end

			if arg_138_1.time_ >= var_141_0 + var_141_7 and arg_138_1.time_ < var_141_0 + var_141_7 + arg_141_0 then
				arg_138_1.typewritter.percent = 1

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(true)
			end
		end

		arg_138_1.nodeConfigList_ = {}

		arg_138_1:InitPlayNodeList()
	end,
	Play319271033 = function(arg_142_0, arg_142_1)
		arg_142_1.time_ = 0
		arg_142_1.frameCnt_ = 0
		arg_142_1.state_ = "playing"
		arg_142_1.curTalkId_ = 319271033
		arg_142_1.duration_ = 7.23

		local var_142_0 = {
			zh = 7.233,
			ja = 5.3
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
				arg_142_0:Play319271034(arg_142_1)
			end
		end

		function arg_142_1.onSingleLineUpdate_(arg_145_0)
			local var_145_0 = 0
			local var_145_1 = 0.675

			if var_145_0 < arg_142_1.time_ and arg_142_1.time_ <= var_145_0 + arg_145_0 then
				arg_142_1.talkMaxDuration = 0
				arg_142_1.dialogCg_.alpha = 1

				arg_142_1.dialog_:SetActive(true)
				SetActive(arg_142_1.leftNameGo_, true)

				local var_145_2 = arg_142_1:FormatText(StoryNameCfg[668].name)

				arg_142_1.leftNameTxt_.text = var_145_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_142_1.leftNameTxt_.transform)

				arg_142_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_142_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_142_1:RecordName(arg_142_1.leftNameTxt_.text)
				SetActive(arg_142_1.iconTrs_.gameObject, true)
				arg_142_1.iconController_:SetSelectedState("hero")

				arg_142_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4040")

				arg_142_1.callingController_:SetSelectedState("normal")

				arg_142_1.keyicon_.color = Color.New(1, 1, 1)
				arg_142_1.icon_.color = Color.New(1, 1, 1)

				local var_145_3 = arg_142_1:GetWordFromCfg(319271033)
				local var_145_4 = arg_142_1:FormatText(var_145_3.content)

				arg_142_1.text_.text = var_145_4

				LuaForUtil.ClearLinePrefixSymbol(arg_142_1.text_)

				local var_145_5 = 27
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

				if manager.audio:GetVoiceLength("story_v_out_319271", "319271033", "story_v_out_319271.awb") ~= 0 then
					local var_145_8 = manager.audio:GetVoiceLength("story_v_out_319271", "319271033", "story_v_out_319271.awb") / 1000

					if var_145_8 + var_145_0 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_8 + var_145_0
					end

					if var_145_3.prefab_name ~= "" and arg_142_1.actors_[var_145_3.prefab_name] ~= nil then
						local var_145_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_142_1.actors_[var_145_3.prefab_name].transform, "story_v_out_319271", "319271033", "story_v_out_319271.awb")

						arg_142_1:RecordAudio("319271033", var_145_9)
						arg_142_1:RecordAudio("319271033", var_145_9)
					else
						arg_142_1:AudioAction("play", "voice", "story_v_out_319271", "319271033", "story_v_out_319271.awb")
					end

					arg_142_1:RecordHistoryTalkVoice("story_v_out_319271", "319271033", "story_v_out_319271.awb")
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
	Play319271034 = function(arg_146_0, arg_146_1)
		arg_146_1.time_ = 0
		arg_146_1.frameCnt_ = 0
		arg_146_1.state_ = "playing"
		arg_146_1.curTalkId_ = 319271034
		arg_146_1.duration_ = 4.7

		local var_146_0 = {
			zh = 4.7,
			ja = 3.166
		}
		local var_146_1 = manager.audio:GetLocalizationFlag()

		if var_146_0[var_146_1] ~= nil then
			arg_146_1.duration_ = var_146_0[var_146_1]
		end

		SetActive(arg_146_1.tipsGo_, false)

		function arg_146_1.onSingleLineFinish_()
			arg_146_1.onSingleLineUpdate_ = nil
			arg_146_1.onSingleLineFinish_ = nil
			arg_146_1.state_ = "waiting"
		end

		function arg_146_1.playNext_(arg_148_0)
			if arg_148_0 == 1 then
				arg_146_0:Play319271035(arg_146_1)
			end
		end

		function arg_146_1.onSingleLineUpdate_(arg_149_0)
			local var_149_0 = 0
			local var_149_1 = 0.475

			if var_149_0 < arg_146_1.time_ and arg_146_1.time_ <= var_149_0 + arg_149_0 then
				arg_146_1.talkMaxDuration = 0
				arg_146_1.dialogCg_.alpha = 1

				arg_146_1.dialog_:SetActive(true)
				SetActive(arg_146_1.leftNameGo_, true)

				local var_149_2 = arg_146_1:FormatText(StoryNameCfg[668].name)

				arg_146_1.leftNameTxt_.text = var_149_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_146_1.leftNameTxt_.transform)

				arg_146_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_146_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_146_1:RecordName(arg_146_1.leftNameTxt_.text)
				SetActive(arg_146_1.iconTrs_.gameObject, true)
				arg_146_1.iconController_:SetSelectedState("hero")

				arg_146_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4040")

				arg_146_1.callingController_:SetSelectedState("normal")

				arg_146_1.keyicon_.color = Color.New(1, 1, 1)
				arg_146_1.icon_.color = Color.New(1, 1, 1)

				local var_149_3 = arg_146_1:GetWordFromCfg(319271034)
				local var_149_4 = arg_146_1:FormatText(var_149_3.content)

				arg_146_1.text_.text = var_149_4

				LuaForUtil.ClearLinePrefixSymbol(arg_146_1.text_)

				local var_149_5 = 19
				local var_149_6 = utf8.len(var_149_4)
				local var_149_7 = var_149_5 <= 0 and var_149_1 or var_149_1 * (var_149_6 / var_149_5)

				if var_149_7 > 0 and var_149_1 < var_149_7 then
					arg_146_1.talkMaxDuration = var_149_7

					if var_149_7 + var_149_0 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_7 + var_149_0
					end
				end

				arg_146_1.text_.text = var_149_4
				arg_146_1.typewritter.percent = 0

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319271", "319271034", "story_v_out_319271.awb") ~= 0 then
					local var_149_8 = manager.audio:GetVoiceLength("story_v_out_319271", "319271034", "story_v_out_319271.awb") / 1000

					if var_149_8 + var_149_0 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_8 + var_149_0
					end

					if var_149_3.prefab_name ~= "" and arg_146_1.actors_[var_149_3.prefab_name] ~= nil then
						local var_149_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_146_1.actors_[var_149_3.prefab_name].transform, "story_v_out_319271", "319271034", "story_v_out_319271.awb")

						arg_146_1:RecordAudio("319271034", var_149_9)
						arg_146_1:RecordAudio("319271034", var_149_9)
					else
						arg_146_1:AudioAction("play", "voice", "story_v_out_319271", "319271034", "story_v_out_319271.awb")
					end

					arg_146_1:RecordHistoryTalkVoice("story_v_out_319271", "319271034", "story_v_out_319271.awb")
				end

				arg_146_1:RecordContent(arg_146_1.text_.text)
			end

			local var_149_10 = math.max(var_149_1, arg_146_1.talkMaxDuration)

			if var_149_0 <= arg_146_1.time_ and arg_146_1.time_ < var_149_0 + var_149_10 then
				arg_146_1.typewritter.percent = (arg_146_1.time_ - var_149_0) / var_149_10

				arg_146_1.typewritter:SetDirty()
			end

			if arg_146_1.time_ >= var_149_0 + var_149_10 and arg_146_1.time_ < var_149_0 + var_149_10 + arg_149_0 then
				arg_146_1.typewritter.percent = 1

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(true)
			end
		end

		arg_146_1.nodeConfigList_ = {}

		arg_146_1:InitPlayNodeList()
	end,
	Play319271035 = function(arg_150_0, arg_150_1)
		arg_150_1.time_ = 0
		arg_150_1.frameCnt_ = 0
		arg_150_1.state_ = "playing"
		arg_150_1.curTalkId_ = 319271035
		arg_150_1.duration_ = 3.19

		SetActive(arg_150_1.tipsGo_, false)

		function arg_150_1.onSingleLineFinish_()
			arg_150_1.onSingleLineUpdate_ = nil
			arg_150_1.onSingleLineFinish_ = nil
			arg_150_1.state_ = "waiting"
		end

		function arg_150_1.playNext_(arg_152_0)
			if arg_152_0 == 1 then
				arg_150_0:Play319271036(arg_150_1)
			end
		end

		function arg_150_1.onSingleLineUpdate_(arg_153_0)
			local var_153_0 = 0

			if var_153_0 < arg_150_1.time_ and arg_150_1.time_ <= var_153_0 + arg_153_0 then
				local var_153_1 = manager.ui.mainCamera.transform.localPosition
				local var_153_2 = Vector3.New(0, 0, 10) + Vector3.New(var_153_1.x, var_153_1.y, 0)
				local var_153_3 = arg_150_1.bgs_.I11i

				var_153_3.transform.localPosition = var_153_2
				var_153_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_153_4 = var_153_3:GetComponent("SpriteRenderer")

				if var_153_4 and var_153_4.sprite then
					local var_153_5 = (var_153_3.transform.localPosition - var_153_1).z
					local var_153_6 = manager.ui.mainCameraCom_
					local var_153_7 = 2 * var_153_5 * Mathf.Tan(var_153_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_153_8 = var_153_7 * var_153_6.aspect
					local var_153_9 = var_153_4.sprite.bounds.size.x
					local var_153_10 = var_153_4.sprite.bounds.size.y
					local var_153_11 = var_153_8 / var_153_9
					local var_153_12 = var_153_7 / var_153_10
					local var_153_13 = var_153_12 < var_153_11 and var_153_11 or var_153_12

					var_153_3.transform.localScale = Vector3.New(var_153_13, var_153_13, 0)
				end

				for iter_153_0, iter_153_1 in pairs(arg_150_1.bgs_) do
					if iter_153_0 ~= "I11i" then
						iter_153_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_153_14 = "STblack"

			if arg_150_1.bgs_[var_153_14] == nil then
				local var_153_15 = Object.Instantiate(arg_150_1.paintGo_)

				var_153_15:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_153_14)
				var_153_15.name = var_153_14
				var_153_15.transform.parent = arg_150_1.stage_.transform
				var_153_15.transform.localPosition = Vector3.New(0, 100, 0)
				arg_150_1.bgs_[var_153_14] = var_153_15
			end

			local var_153_16 = 1

			if var_153_16 < arg_150_1.time_ and arg_150_1.time_ <= var_153_16 + arg_153_0 then
				local var_153_17 = manager.ui.mainCamera.transform.localPosition
				local var_153_18 = Vector3.New(0, 0, 10) + Vector3.New(var_153_17.x, var_153_17.y, 0)
				local var_153_19 = arg_150_1.bgs_.STblack

				var_153_19.transform.localPosition = var_153_18
				var_153_19.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_153_20 = var_153_19:GetComponent("SpriteRenderer")

				if var_153_20 and var_153_20.sprite then
					local var_153_21 = (var_153_19.transform.localPosition - var_153_17).z
					local var_153_22 = manager.ui.mainCameraCom_
					local var_153_23 = 2 * var_153_21 * Mathf.Tan(var_153_22.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_153_24 = var_153_23 * var_153_22.aspect
					local var_153_25 = var_153_20.sprite.bounds.size.x
					local var_153_26 = var_153_20.sprite.bounds.size.y
					local var_153_27 = var_153_24 / var_153_25
					local var_153_28 = var_153_23 / var_153_26
					local var_153_29 = var_153_28 < var_153_27 and var_153_27 or var_153_28

					var_153_19.transform.localScale = Vector3.New(var_153_29, var_153_29, 0)
				end

				for iter_153_2, iter_153_3 in pairs(arg_150_1.bgs_) do
					if iter_153_2 ~= "STblack" then
						iter_153_3.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_153_30 = 0

			if var_153_30 < arg_150_1.time_ and arg_150_1.time_ <= var_153_30 + arg_153_0 then
				arg_150_1.mask_.enabled = true
				arg_150_1.mask_.raycastTarget = true

				arg_150_1:SetGaussion(false)
			end

			local var_153_31 = 1

			if var_153_30 <= arg_150_1.time_ and arg_150_1.time_ < var_153_30 + var_153_31 then
				local var_153_32 = (arg_150_1.time_ - var_153_30) / var_153_31
				local var_153_33 = Color.New(0, 0, 0)

				var_153_33.a = Mathf.Lerp(0, 1, var_153_32)
				arg_150_1.mask_.color = var_153_33
			end

			if arg_150_1.time_ >= var_153_30 + var_153_31 and arg_150_1.time_ < var_153_30 + var_153_31 + arg_153_0 then
				local var_153_34 = Color.New(0, 0, 0)

				var_153_34.a = 1
				arg_150_1.mask_.color = var_153_34
			end

			local var_153_35 = 1

			if var_153_35 < arg_150_1.time_ and arg_150_1.time_ <= var_153_35 + arg_153_0 then
				arg_150_1.mask_.enabled = true
				arg_150_1.mask_.raycastTarget = true

				arg_150_1:SetGaussion(false)
			end

			local var_153_36 = 1

			if var_153_35 <= arg_150_1.time_ and arg_150_1.time_ < var_153_35 + var_153_36 then
				local var_153_37 = (arg_150_1.time_ - var_153_35) / var_153_36
				local var_153_38 = Color.New(0, 0, 0)

				var_153_38.a = Mathf.Lerp(1, 0, var_153_37)
				arg_150_1.mask_.color = var_153_38
			end

			if arg_150_1.time_ >= var_153_35 + var_153_36 and arg_150_1.time_ < var_153_35 + var_153_36 + arg_153_0 then
				local var_153_39 = Color.New(0, 0, 0)
				local var_153_40 = 0

				arg_150_1.mask_.enabled = false
				var_153_39.a = var_153_40
				arg_150_1.mask_.color = var_153_39
			end

			if arg_150_1.frameCnt_ <= 1 then
				arg_150_1.dialog_:SetActive(false)
			end

			local var_153_41 = 1.925
			local var_153_42 = 0.075

			if var_153_41 < arg_150_1.time_ and arg_150_1.time_ <= var_153_41 + arg_153_0 then
				arg_150_1.talkMaxDuration = 0

				arg_150_1.dialog_:SetActive(true)

				arg_150_1.dialogCg_.alpha = 0

				local var_153_43 = LeanTween.value(arg_150_1.dialog_, 0, 1, 0.3)

				var_153_43:setOnUpdate(LuaHelper.FloatAction(function(arg_154_0)
					arg_150_1.dialogCg_.alpha = arg_154_0
				end))
				var_153_43:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_150_1.dialog_)
					var_153_43:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_150_1.duration_ = arg_150_1.duration_ + 0.3

				SetActive(arg_150_1.leftNameGo_, true)

				local var_153_44 = arg_150_1:FormatText(StoryNameCfg[36].name)

				arg_150_1.leftNameTxt_.text = var_153_44

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_150_1.leftNameTxt_.transform)

				arg_150_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_150_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_150_1:RecordName(arg_150_1.leftNameTxt_.text)
				SetActive(arg_150_1.iconTrs_.gameObject, true)
				arg_150_1.iconController_:SetSelectedState("hero")

				arg_150_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_150_1.callingController_:SetSelectedState("normal")

				arg_150_1.keyicon_.color = Color.New(1, 1, 1)
				arg_150_1.icon_.color = Color.New(1, 1, 1)

				local var_153_45 = arg_150_1:GetWordFromCfg(319271035)
				local var_153_46 = arg_150_1:FormatText(var_153_45.content)

				arg_150_1.text_.text = var_153_46

				LuaForUtil.ClearLinePrefixSymbol(arg_150_1.text_)

				local var_153_47 = 3
				local var_153_48 = utf8.len(var_153_46)
				local var_153_49 = var_153_47 <= 0 and var_153_42 or var_153_42 * (var_153_48 / var_153_47)

				if var_153_49 > 0 and var_153_42 < var_153_49 then
					arg_150_1.talkMaxDuration = var_153_49
					var_153_41 = var_153_41 + 0.3

					if var_153_49 + var_153_41 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_49 + var_153_41
					end
				end

				arg_150_1.text_.text = var_153_46
				arg_150_1.typewritter.percent = 0

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319271", "319271035", "story_v_out_319271.awb") ~= 0 then
					local var_153_50 = manager.audio:GetVoiceLength("story_v_out_319271", "319271035", "story_v_out_319271.awb") / 1000

					if var_153_50 + var_153_41 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_50 + var_153_41
					end

					if var_153_45.prefab_name ~= "" and arg_150_1.actors_[var_153_45.prefab_name] ~= nil then
						local var_153_51 = LuaForUtil.PlayVoiceWithCriLipsync(arg_150_1.actors_[var_153_45.prefab_name].transform, "story_v_out_319271", "319271035", "story_v_out_319271.awb")

						arg_150_1:RecordAudio("319271035", var_153_51)
						arg_150_1:RecordAudio("319271035", var_153_51)
					else
						arg_150_1:AudioAction("play", "voice", "story_v_out_319271", "319271035", "story_v_out_319271.awb")
					end

					arg_150_1:RecordHistoryTalkVoice("story_v_out_319271", "319271035", "story_v_out_319271.awb")
				end

				arg_150_1:RecordContent(arg_150_1.text_.text)
			end

			local var_153_52 = var_153_41 + 0.3
			local var_153_53 = math.max(var_153_42, arg_150_1.talkMaxDuration)

			if var_153_52 <= arg_150_1.time_ and arg_150_1.time_ < var_153_52 + var_153_53 then
				arg_150_1.typewritter.percent = (arg_150_1.time_ - var_153_52) / var_153_53

				arg_150_1.typewritter:SetDirty()
			end

			if arg_150_1.time_ >= var_153_52 + var_153_53 and arg_150_1.time_ < var_153_52 + var_153_53 + arg_153_0 then
				arg_150_1.typewritter.percent = 1

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(true)
			end
		end

		arg_150_1.nodeConfigList_ = {}

		arg_150_1:InitPlayNodeList()
	end,
	Play319271036 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 319271036
		arg_156_1.duration_ = 5

		SetActive(arg_156_1.tipsGo_, false)

		function arg_156_1.onSingleLineFinish_()
			arg_156_1.onSingleLineUpdate_ = nil
			arg_156_1.onSingleLineFinish_ = nil
			arg_156_1.state_ = "waiting"
		end

		function arg_156_1.playNext_(arg_158_0)
			if arg_158_0 == 1 then
				arg_156_0:Play319271037(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			local var_159_0 = 0
			local var_159_1 = 1.275

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

				local var_159_2 = arg_156_1:GetWordFromCfg(319271036)
				local var_159_3 = arg_156_1:FormatText(var_159_2.content)

				arg_156_1.text_.text = var_159_3

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_4 = 51
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
	Play319271037 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 319271037
		arg_160_1.duration_ = 7.5

		SetActive(arg_160_1.tipsGo_, false)

		function arg_160_1.onSingleLineFinish_()
			arg_160_1.onSingleLineUpdate_ = nil
			arg_160_1.onSingleLineFinish_ = nil
			arg_160_1.state_ = "waiting"
		end

		function arg_160_1.playNext_(arg_162_0)
			if arg_162_0 == 1 then
				arg_160_0:Play319271038(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			local var_163_0 = 0.266666666666667
			local var_163_1 = 0.733333333333333

			if var_163_0 < arg_160_1.time_ and arg_160_1.time_ <= var_163_0 + arg_163_0 then
				local var_163_2 = "play"
				local var_163_3 = "effect"

				arg_160_1:AudioAction(var_163_2, var_163_3, "se_story_1211", "se_story_1211_explosionfar", "")
			end

			local var_163_4 = 1.33333333333333

			if var_163_4 < arg_160_1.time_ and arg_160_1.time_ <= var_163_4 + arg_163_0 then
				local var_163_5 = manager.ui.mainCamera.transform.localPosition
				local var_163_6 = Vector3.New(0, 0, 10) + Vector3.New(var_163_5.x, var_163_5.y, 0)
				local var_163_7 = arg_160_1.bgs_.I11i

				var_163_7.transform.localPosition = var_163_6
				var_163_7.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_163_8 = var_163_7:GetComponent("SpriteRenderer")

				if var_163_8 and var_163_8.sprite then
					local var_163_9 = (var_163_7.transform.localPosition - var_163_5).z
					local var_163_10 = manager.ui.mainCameraCom_
					local var_163_11 = 2 * var_163_9 * Mathf.Tan(var_163_10.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_163_12 = var_163_11 * var_163_10.aspect
					local var_163_13 = var_163_8.sprite.bounds.size.x
					local var_163_14 = var_163_8.sprite.bounds.size.y
					local var_163_15 = var_163_12 / var_163_13
					local var_163_16 = var_163_11 / var_163_14
					local var_163_17 = var_163_16 < var_163_15 and var_163_15 or var_163_16

					var_163_7.transform.localScale = Vector3.New(var_163_17, var_163_17, 0)
				end

				for iter_163_0, iter_163_1 in pairs(arg_160_1.bgs_) do
					if iter_163_0 ~= "I11i" then
						iter_163_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_163_18 = 0

			if var_163_18 < arg_160_1.time_ and arg_160_1.time_ <= var_163_18 + arg_163_0 then
				arg_160_1.mask_.enabled = true
				arg_160_1.mask_.raycastTarget = true

				arg_160_1:SetGaussion(false)
			end

			local var_163_19 = 1.33333333333333

			if var_163_18 <= arg_160_1.time_ and arg_160_1.time_ < var_163_18 + var_163_19 then
				local var_163_20 = (arg_160_1.time_ - var_163_18) / var_163_19
				local var_163_21 = Color.New(0, 0, 0)

				var_163_21.a = Mathf.Lerp(0, 1, var_163_20)
				arg_160_1.mask_.color = var_163_21
			end

			if arg_160_1.time_ >= var_163_18 + var_163_19 and arg_160_1.time_ < var_163_18 + var_163_19 + arg_163_0 then
				local var_163_22 = Color.New(0, 0, 0)

				var_163_22.a = 1
				arg_160_1.mask_.color = var_163_22
			end

			local var_163_23 = 1.33333333333333

			if var_163_23 < arg_160_1.time_ and arg_160_1.time_ <= var_163_23 + arg_163_0 then
				arg_160_1.mask_.enabled = true
				arg_160_1.mask_.raycastTarget = true

				arg_160_1:SetGaussion(false)
			end

			local var_163_24 = 1.66666666666667

			if var_163_23 <= arg_160_1.time_ and arg_160_1.time_ < var_163_23 + var_163_24 then
				local var_163_25 = (arg_160_1.time_ - var_163_23) / var_163_24
				local var_163_26 = Color.New(0, 0, 0)

				var_163_26.a = Mathf.Lerp(1, 0, var_163_25)
				arg_160_1.mask_.color = var_163_26
			end

			if arg_160_1.time_ >= var_163_23 + var_163_24 and arg_160_1.time_ < var_163_23 + var_163_24 + arg_163_0 then
				local var_163_27 = Color.New(0, 0, 0)
				local var_163_28 = 0

				arg_160_1.mask_.enabled = false
				var_163_27.a = var_163_28
				arg_160_1.mask_.color = var_163_27
			end

			if arg_160_1.frameCnt_ <= 1 then
				arg_160_1.dialog_:SetActive(false)
			end

			local var_163_29 = 2.5
			local var_163_30 = 1.5

			if var_163_29 < arg_160_1.time_ and arg_160_1.time_ <= var_163_29 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0

				arg_160_1.dialog_:SetActive(true)

				arg_160_1.dialogCg_.alpha = 0

				local var_163_31 = LeanTween.value(arg_160_1.dialog_, 0, 1, 0.3)

				var_163_31:setOnUpdate(LuaHelper.FloatAction(function(arg_164_0)
					arg_160_1.dialogCg_.alpha = arg_164_0
				end))
				var_163_31:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_160_1.dialog_)
					var_163_31:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_160_1.duration_ = arg_160_1.duration_ + 0.3

				SetActive(arg_160_1.leftNameGo_, false)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_160_1.iconTrs_.gameObject, false)
				arg_160_1.callingController_:SetSelectedState("normal")

				local var_163_32 = arg_160_1:GetWordFromCfg(319271037)
				local var_163_33 = arg_160_1:FormatText(var_163_32.content)

				arg_160_1.text_.text = var_163_33

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_34 = 60
				local var_163_35 = utf8.len(var_163_33)
				local var_163_36 = var_163_34 <= 0 and var_163_30 or var_163_30 * (var_163_35 / var_163_34)

				if var_163_36 > 0 and var_163_30 < var_163_36 then
					arg_160_1.talkMaxDuration = var_163_36
					var_163_29 = var_163_29 + 0.3

					if var_163_36 + var_163_29 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_36 + var_163_29
					end
				end

				arg_160_1.text_.text = var_163_33
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)
				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_37 = var_163_29 + 0.3
			local var_163_38 = math.max(var_163_30, arg_160_1.talkMaxDuration)

			if var_163_37 <= arg_160_1.time_ and arg_160_1.time_ < var_163_37 + var_163_38 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - var_163_37) / var_163_38

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= var_163_37 + var_163_38 and arg_160_1.time_ < var_163_37 + var_163_38 + arg_163_0 then
				arg_160_1.typewritter.percent = 1

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(true)
			end
		end

		arg_160_1.nodeConfigList_ = {}

		arg_160_1:InitPlayNodeList()
	end,
	Play319271038 = function(arg_166_0, arg_166_1)
		arg_166_1.time_ = 0
		arg_166_1.frameCnt_ = 0
		arg_166_1.state_ = "playing"
		arg_166_1.curTalkId_ = 319271038
		arg_166_1.duration_ = 5.63

		local var_166_0 = {
			zh = 5.633,
			ja = 4.333
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
				arg_166_0:Play319271039(arg_166_1)
			end
		end

		function arg_166_1.onSingleLineUpdate_(arg_169_0)
			local var_169_0 = arg_166_1.actors_["4040ui_story"].transform
			local var_169_1 = 0

			if var_169_1 < arg_166_1.time_ and arg_166_1.time_ <= var_169_1 + arg_169_0 then
				arg_166_1.var_.moveOldPos4040ui_story = var_169_0.localPosition
			end

			local var_169_2 = 0.001

			if var_169_1 <= arg_166_1.time_ and arg_166_1.time_ < var_169_1 + var_169_2 then
				local var_169_3 = (arg_166_1.time_ - var_169_1) / var_169_2
				local var_169_4 = Vector3.New(0, -1.55, -5.5)

				var_169_0.localPosition = Vector3.Lerp(arg_166_1.var_.moveOldPos4040ui_story, var_169_4, var_169_3)

				local var_169_5 = manager.ui.mainCamera.transform.position - var_169_0.position

				var_169_0.forward = Vector3.New(var_169_5.x, var_169_5.y, var_169_5.z)

				local var_169_6 = var_169_0.localEulerAngles

				var_169_6.z = 0
				var_169_6.x = 0
				var_169_0.localEulerAngles = var_169_6
			end

			if arg_166_1.time_ >= var_169_1 + var_169_2 and arg_166_1.time_ < var_169_1 + var_169_2 + arg_169_0 then
				var_169_0.localPosition = Vector3.New(0, -1.55, -5.5)

				local var_169_7 = manager.ui.mainCamera.transform.position - var_169_0.position

				var_169_0.forward = Vector3.New(var_169_7.x, var_169_7.y, var_169_7.z)

				local var_169_8 = var_169_0.localEulerAngles

				var_169_8.z = 0
				var_169_8.x = 0
				var_169_0.localEulerAngles = var_169_8
			end

			local var_169_9 = arg_166_1.actors_["4040ui_story"]
			local var_169_10 = 0

			if var_169_10 < arg_166_1.time_ and arg_166_1.time_ <= var_169_10 + arg_169_0 and not isNil(var_169_9) and arg_166_1.var_.characterEffect4040ui_story == nil then
				arg_166_1.var_.characterEffect4040ui_story = var_169_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_169_11 = 0.200000002980232

			if var_169_10 <= arg_166_1.time_ and arg_166_1.time_ < var_169_10 + var_169_11 and not isNil(var_169_9) then
				local var_169_12 = (arg_166_1.time_ - var_169_10) / var_169_11

				if arg_166_1.var_.characterEffect4040ui_story and not isNil(var_169_9) then
					arg_166_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_166_1.time_ >= var_169_10 + var_169_11 and arg_166_1.time_ < var_169_10 + var_169_11 + arg_169_0 and not isNil(var_169_9) and arg_166_1.var_.characterEffect4040ui_story then
				arg_166_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_169_13 = 0

			if var_169_13 < arg_166_1.time_ and arg_166_1.time_ <= var_169_13 + arg_169_0 then
				arg_166_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			local var_169_14 = 0

			if var_169_14 < arg_166_1.time_ and arg_166_1.time_ <= var_169_14 + arg_169_0 then
				arg_166_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_169_15 = 0
			local var_169_16 = 0.575

			if var_169_15 < arg_166_1.time_ and arg_166_1.time_ <= var_169_15 + arg_169_0 then
				arg_166_1.talkMaxDuration = 0
				arg_166_1.dialogCg_.alpha = 1

				arg_166_1.dialog_:SetActive(true)
				SetActive(arg_166_1.leftNameGo_, true)

				local var_169_17 = arg_166_1:FormatText(StoryNameCfg[668].name)

				arg_166_1.leftNameTxt_.text = var_169_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_166_1.leftNameTxt_.transform)

				arg_166_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_166_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_166_1:RecordName(arg_166_1.leftNameTxt_.text)
				SetActive(arg_166_1.iconTrs_.gameObject, false)
				arg_166_1.callingController_:SetSelectedState("normal")

				local var_169_18 = arg_166_1:GetWordFromCfg(319271038)
				local var_169_19 = arg_166_1:FormatText(var_169_18.content)

				arg_166_1.text_.text = var_169_19

				LuaForUtil.ClearLinePrefixSymbol(arg_166_1.text_)

				local var_169_20 = 23
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

				if manager.audio:GetVoiceLength("story_v_out_319271", "319271038", "story_v_out_319271.awb") ~= 0 then
					local var_169_23 = manager.audio:GetVoiceLength("story_v_out_319271", "319271038", "story_v_out_319271.awb") / 1000

					if var_169_23 + var_169_15 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_23 + var_169_15
					end

					if var_169_18.prefab_name ~= "" and arg_166_1.actors_[var_169_18.prefab_name] ~= nil then
						local var_169_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_166_1.actors_[var_169_18.prefab_name].transform, "story_v_out_319271", "319271038", "story_v_out_319271.awb")

						arg_166_1:RecordAudio("319271038", var_169_24)
						arg_166_1:RecordAudio("319271038", var_169_24)
					else
						arg_166_1:AudioAction("play", "voice", "story_v_out_319271", "319271038", "story_v_out_319271.awb")
					end

					arg_166_1:RecordHistoryTalkVoice("story_v_out_319271", "319271038", "story_v_out_319271.awb")
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
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_166_1:InitPlayNodeList()
	end,
	Play319271039 = function(arg_170_0, arg_170_1)
		arg_170_1.time_ = 0
		arg_170_1.frameCnt_ = 0
		arg_170_1.state_ = "playing"
		arg_170_1.curTalkId_ = 319271039
		arg_170_1.duration_ = 8.23

		SetActive(arg_170_1.tipsGo_, false)

		function arg_170_1.onSingleLineFinish_()
			arg_170_1.onSingleLineUpdate_ = nil
			arg_170_1.onSingleLineFinish_ = nil
			arg_170_1.state_ = "waiting"
		end

		function arg_170_1.playNext_(arg_172_0)
			if arg_172_0 == 1 then
				arg_170_0:Play319271040(arg_170_1)
			end
		end

		function arg_170_1.onSingleLineUpdate_(arg_173_0)
			local var_173_0 = "ML0208"

			if arg_170_1.bgs_[var_173_0] == nil then
				local var_173_1 = Object.Instantiate(arg_170_1.paintGo_)

				var_173_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_173_0)
				var_173_1.name = var_173_0
				var_173_1.transform.parent = arg_170_1.stage_.transform
				var_173_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_170_1.bgs_[var_173_0] = var_173_1
			end

			local var_173_2 = 1.39933333148559

			if var_173_2 < arg_170_1.time_ and arg_170_1.time_ <= var_173_2 + arg_173_0 then
				local var_173_3 = manager.ui.mainCamera.transform.localPosition
				local var_173_4 = Vector3.New(0, 0, 10) + Vector3.New(var_173_3.x, var_173_3.y, 0)
				local var_173_5 = arg_170_1.bgs_.ML0208

				var_173_5.transform.localPosition = var_173_4
				var_173_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_173_6 = var_173_5:GetComponent("SpriteRenderer")

				if var_173_6 and var_173_6.sprite then
					local var_173_7 = (var_173_5.transform.localPosition - var_173_3).z
					local var_173_8 = manager.ui.mainCameraCom_
					local var_173_9 = 2 * var_173_7 * Mathf.Tan(var_173_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_173_10 = var_173_9 * var_173_8.aspect
					local var_173_11 = var_173_6.sprite.bounds.size.x
					local var_173_12 = var_173_6.sprite.bounds.size.y
					local var_173_13 = var_173_10 / var_173_11
					local var_173_14 = var_173_9 / var_173_12
					local var_173_15 = var_173_14 < var_173_13 and var_173_13 or var_173_14

					var_173_5.transform.localScale = Vector3.New(var_173_15, var_173_15, 0)
				end

				for iter_173_0, iter_173_1 in pairs(arg_170_1.bgs_) do
					if iter_173_0 ~= "ML0208" then
						iter_173_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_173_16 = 0

			if var_173_16 < arg_170_1.time_ and arg_170_1.time_ <= var_173_16 + arg_173_0 then
				arg_170_1.allBtn_.enabled = false
			end

			local var_173_17 = 0.3

			if arg_170_1.time_ >= var_173_16 + var_173_17 and arg_170_1.time_ < var_173_16 + var_173_17 + arg_173_0 then
				arg_170_1.allBtn_.enabled = true
			end

			local var_173_18 = 0

			if var_173_18 < arg_170_1.time_ and arg_170_1.time_ <= var_173_18 + arg_173_0 then
				arg_170_1.mask_.enabled = true
				arg_170_1.mask_.raycastTarget = true

				arg_170_1:SetGaussion(false)
			end

			local var_173_19 = 1.43333333333333

			if var_173_18 <= arg_170_1.time_ and arg_170_1.time_ < var_173_18 + var_173_19 then
				local var_173_20 = (arg_170_1.time_ - var_173_18) / var_173_19
				local var_173_21 = Color.New(0, 0, 0)

				var_173_21.a = Mathf.Lerp(0, 1, var_173_20)
				arg_170_1.mask_.color = var_173_21
			end

			if arg_170_1.time_ >= var_173_18 + var_173_19 and arg_170_1.time_ < var_173_18 + var_173_19 + arg_173_0 then
				local var_173_22 = Color.New(0, 0, 0)

				var_173_22.a = 1
				arg_170_1.mask_.color = var_173_22
			end

			local var_173_23 = 1.43333333333333

			if var_173_23 < arg_170_1.time_ and arg_170_1.time_ <= var_173_23 + arg_173_0 then
				arg_170_1.mask_.enabled = true
				arg_170_1.mask_.raycastTarget = true

				arg_170_1:SetGaussion(false)
			end

			local var_173_24 = 2

			if var_173_23 <= arg_170_1.time_ and arg_170_1.time_ < var_173_23 + var_173_24 then
				local var_173_25 = (arg_170_1.time_ - var_173_23) / var_173_24
				local var_173_26 = Color.New(0, 0, 0)

				var_173_26.a = Mathf.Lerp(1, 0, var_173_25)
				arg_170_1.mask_.color = var_173_26
			end

			if arg_170_1.time_ >= var_173_23 + var_173_24 and arg_170_1.time_ < var_173_23 + var_173_24 + arg_173_0 then
				local var_173_27 = Color.New(0, 0, 0)
				local var_173_28 = 0

				arg_170_1.mask_.enabled = false
				var_173_27.a = var_173_28
				arg_170_1.mask_.color = var_173_27
			end

			local var_173_29 = arg_170_1.actors_["4040ui_story"].transform
			local var_173_30 = 1.43333333333333

			if var_173_30 < arg_170_1.time_ and arg_170_1.time_ <= var_173_30 + arg_173_0 then
				arg_170_1.var_.moveOldPos4040ui_story = var_173_29.localPosition
			end

			local var_173_31 = 0.001

			if var_173_30 <= arg_170_1.time_ and arg_170_1.time_ < var_173_30 + var_173_31 then
				local var_173_32 = (arg_170_1.time_ - var_173_30) / var_173_31
				local var_173_33 = Vector3.New(0, 100, 0)

				var_173_29.localPosition = Vector3.Lerp(arg_170_1.var_.moveOldPos4040ui_story, var_173_33, var_173_32)

				local var_173_34 = manager.ui.mainCamera.transform.position - var_173_29.position

				var_173_29.forward = Vector3.New(var_173_34.x, var_173_34.y, var_173_34.z)

				local var_173_35 = var_173_29.localEulerAngles

				var_173_35.z = 0
				var_173_35.x = 0
				var_173_29.localEulerAngles = var_173_35
			end

			if arg_170_1.time_ >= var_173_30 + var_173_31 and arg_170_1.time_ < var_173_30 + var_173_31 + arg_173_0 then
				var_173_29.localPosition = Vector3.New(0, 100, 0)

				local var_173_36 = manager.ui.mainCamera.transform.position - var_173_29.position

				var_173_29.forward = Vector3.New(var_173_36.x, var_173_36.y, var_173_36.z)

				local var_173_37 = var_173_29.localEulerAngles

				var_173_37.z = 0
				var_173_37.x = 0
				var_173_29.localEulerAngles = var_173_37
			end

			local var_173_38 = arg_170_1.actors_["4040ui_story"]
			local var_173_39 = 0

			if var_173_39 < arg_170_1.time_ and arg_170_1.time_ <= var_173_39 + arg_173_0 and not isNil(var_173_38) and arg_170_1.var_.characterEffect4040ui_story == nil then
				arg_170_1.var_.characterEffect4040ui_story = var_173_38:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_173_40 = 0.200000002980232

			if var_173_39 <= arg_170_1.time_ and arg_170_1.time_ < var_173_39 + var_173_40 and not isNil(var_173_38) then
				local var_173_41 = (arg_170_1.time_ - var_173_39) / var_173_40

				if arg_170_1.var_.characterEffect4040ui_story and not isNil(var_173_38) then
					local var_173_42 = Mathf.Lerp(0, 0.5, var_173_41)

					arg_170_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_170_1.var_.characterEffect4040ui_story.fillRatio = var_173_42
				end
			end

			if arg_170_1.time_ >= var_173_39 + var_173_40 and arg_170_1.time_ < var_173_39 + var_173_40 + arg_173_0 and not isNil(var_173_38) and arg_170_1.var_.characterEffect4040ui_story then
				local var_173_43 = 0.5

				arg_170_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_170_1.var_.characterEffect4040ui_story.fillRatio = var_173_43
			end

			local var_173_44 = 0
			local var_173_45 = 0.2

			if var_173_44 < arg_170_1.time_ and arg_170_1.time_ <= var_173_44 + arg_173_0 then
				local var_173_46 = "play"
				local var_173_47 = "music"

				arg_170_1:AudioAction(var_173_46, var_173_47, "ui_battle", "ui_battle_stopbgm", "")

				local var_173_48 = ""
				local var_173_49 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_173_49 ~= "" then
					if arg_170_1.bgmTxt_.text ~= var_173_49 and arg_170_1.bgmTxt_.text ~= "" then
						if arg_170_1.bgmTxt2_.text ~= "" then
							arg_170_1.bgmTxt_.text = arg_170_1.bgmTxt2_.text
						end

						arg_170_1.bgmTxt2_.text = var_173_49

						arg_170_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_170_1.bgmTxt_.text = var_173_49
						arg_170_1.bgmTxt2_.text = var_173_49
					end

					if arg_170_1.bgmTimer then
						arg_170_1.bgmTimer:Stop()

						arg_170_1.bgmTimer = nil
					end

					if arg_170_1.settingData.show_music_name == 1 then
						arg_170_1.musicController:SetSelectedState("show")
						arg_170_1.musicAnimator_:Play("open", 0, 0)

						if arg_170_1.settingData.music_time ~= 0 then
							arg_170_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_170_1.settingData.music_time), function()
								if arg_170_1 == nil or isNil(arg_170_1.bgmTxt_) then
									return
								end

								arg_170_1.musicController:SetSelectedState("hide")
								arg_170_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_173_50 = 0.233333333333333
			local var_173_51 = 1

			if var_173_50 < arg_170_1.time_ and arg_170_1.time_ <= var_173_50 + arg_173_0 then
				local var_173_52 = "play"
				local var_173_53 = "music"

				arg_170_1:AudioAction(var_173_52, var_173_53, "bgm_activity_3_0_story_theme_piano_orc", "bgm_activity_3_0_story_theme_piano_orc", "bgm_activity_3_0_story_theme_piano_orc.awb")

				local var_173_54 = ""
				local var_173_55 = manager.audio:GetAudioName("bgm_activity_3_0_story_theme_piano_orc", "bgm_activity_3_0_story_theme_piano_orc")

				if var_173_55 ~= "" then
					if arg_170_1.bgmTxt_.text ~= var_173_55 and arg_170_1.bgmTxt_.text ~= "" then
						if arg_170_1.bgmTxt2_.text ~= "" then
							arg_170_1.bgmTxt_.text = arg_170_1.bgmTxt2_.text
						end

						arg_170_1.bgmTxt2_.text = var_173_55

						arg_170_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_170_1.bgmTxt_.text = var_173_55
						arg_170_1.bgmTxt2_.text = var_173_55
					end

					if arg_170_1.bgmTimer then
						arg_170_1.bgmTimer:Stop()

						arg_170_1.bgmTimer = nil
					end

					if arg_170_1.settingData.show_music_name == 1 then
						arg_170_1.musicController:SetSelectedState("show")
						arg_170_1.musicAnimator_:Play("open", 0, 0)

						if arg_170_1.settingData.music_time ~= 0 then
							arg_170_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_170_1.settingData.music_time), function()
								if arg_170_1 == nil or isNil(arg_170_1.bgmTxt_) then
									return
								end

								arg_170_1.musicController:SetSelectedState("hide")
								arg_170_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_173_56 = arg_170_1.bgs_.ML0208.transform
			local var_173_57 = 1.43333333333333

			if var_173_57 < arg_170_1.time_ and arg_170_1.time_ <= var_173_57 + arg_173_0 then
				arg_170_1.var_.moveOldPosML0208 = var_173_56.localPosition
			end

			local var_173_58 = 0.001

			if var_173_57 <= arg_170_1.time_ and arg_170_1.time_ < var_173_57 + var_173_58 then
				local var_173_59 = (arg_170_1.time_ - var_173_57) / var_173_58
				local var_173_60 = Vector3.New(0, 1, 7.74)

				var_173_56.localPosition = Vector3.Lerp(arg_170_1.var_.moveOldPosML0208, var_173_60, var_173_59)
			end

			if arg_170_1.time_ >= var_173_57 + var_173_58 and arg_170_1.time_ < var_173_57 + var_173_58 + arg_173_0 then
				var_173_56.localPosition = Vector3.New(0, 1, 7.74)
			end

			local var_173_61 = arg_170_1.bgs_.ML0208.transform
			local var_173_62 = 1.46733333518108

			if var_173_62 < arg_170_1.time_ and arg_170_1.time_ <= var_173_62 + arg_173_0 then
				arg_170_1.var_.moveOldPosML0208 = var_173_61.localPosition
			end

			local var_173_63 = 2.13266666481892

			if var_173_62 <= arg_170_1.time_ and arg_170_1.time_ < var_173_62 + var_173_63 then
				local var_173_64 = (arg_170_1.time_ - var_173_62) / var_173_63
				local var_173_65 = Vector3.New(0, 1, 10)

				var_173_61.localPosition = Vector3.Lerp(arg_170_1.var_.moveOldPosML0208, var_173_65, var_173_64)
			end

			if arg_170_1.time_ >= var_173_62 + var_173_63 and arg_170_1.time_ < var_173_62 + var_173_63 + arg_173_0 then
				var_173_61.localPosition = Vector3.New(0, 1, 10)
			end

			if arg_170_1.frameCnt_ <= 1 then
				arg_170_1.dialog_:SetActive(false)
			end

			local var_173_66 = 3.23333333333333
			local var_173_67 = 1.275

			if var_173_66 < arg_170_1.time_ and arg_170_1.time_ <= var_173_66 + arg_173_0 then
				arg_170_1.talkMaxDuration = 0

				arg_170_1.dialog_:SetActive(true)

				arg_170_1.dialogCg_.alpha = 0

				local var_173_68 = LeanTween.value(arg_170_1.dialog_, 0, 1, 0.3)

				var_173_68:setOnUpdate(LuaHelper.FloatAction(function(arg_176_0)
					arg_170_1.dialogCg_.alpha = arg_176_0
				end))
				var_173_68:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_170_1.dialog_)
					var_173_68:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_170_1.duration_ = arg_170_1.duration_ + 0.3

				SetActive(arg_170_1.leftNameGo_, false)

				arg_170_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_170_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_170_1:RecordName(arg_170_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_170_1.iconTrs_.gameObject, false)
				arg_170_1.callingController_:SetSelectedState("normal")

				local var_173_69 = arg_170_1:GetWordFromCfg(319271039)
				local var_173_70 = arg_170_1:FormatText(var_173_69.content)

				arg_170_1.text_.text = var_173_70

				LuaForUtil.ClearLinePrefixSymbol(arg_170_1.text_)

				local var_173_71 = 51
				local var_173_72 = utf8.len(var_173_70)
				local var_173_73 = var_173_71 <= 0 and var_173_67 or var_173_67 * (var_173_72 / var_173_71)

				if var_173_73 > 0 and var_173_67 < var_173_73 then
					arg_170_1.talkMaxDuration = var_173_73
					var_173_66 = var_173_66 + 0.3

					if var_173_73 + var_173_66 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_73 + var_173_66
					end
				end

				arg_170_1.text_.text = var_173_70
				arg_170_1.typewritter.percent = 0

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(false)
				arg_170_1:RecordContent(arg_170_1.text_.text)
			end

			local var_173_74 = var_173_66 + 0.3
			local var_173_75 = math.max(var_173_67, arg_170_1.talkMaxDuration)

			if var_173_74 <= arg_170_1.time_ and arg_170_1.time_ < var_173_74 + var_173_75 then
				arg_170_1.typewritter.percent = (arg_170_1.time_ - var_173_74) / var_173_75

				arg_170_1.typewritter:SetDirty()
			end

			if arg_170_1.time_ >= var_173_74 + var_173_75 and arg_170_1.time_ < var_173_74 + var_173_75 + arg_173_0 then
				arg_170_1.typewritter.percent = 1

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(true)
			end
		end

		arg_170_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.43333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "ML0208",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.43333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "ML0208",
				changeDisplayLayer = false,
				needEase = false,
				duration = 2.13266666481892,
				className = "StoryMoveNode",
				startTime = 1.46733333518108,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_170_1:InitPlayNodeList()
	end,
	Play319271040 = function(arg_178_0, arg_178_1)
		arg_178_1.time_ = 0
		arg_178_1.frameCnt_ = 0
		arg_178_1.state_ = "playing"
		arg_178_1.curTalkId_ = 319271040
		arg_178_1.duration_ = 1.57

		local var_178_0 = {
			zh = 1.566,
			ja = 0.999999999999
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
				arg_178_0:Play319271041(arg_178_1)
			end
		end

		function arg_178_1.onSingleLineUpdate_(arg_181_0)
			local var_181_0 = 0
			local var_181_1 = 0.125

			if var_181_0 < arg_178_1.time_ and arg_178_1.time_ <= var_181_0 + arg_181_0 then
				arg_178_1.talkMaxDuration = 0
				arg_178_1.dialogCg_.alpha = 1

				arg_178_1.dialog_:SetActive(true)
				SetActive(arg_178_1.leftNameGo_, true)

				local var_181_2 = arg_178_1:FormatText(StoryNameCfg[471].name)

				arg_178_1.leftNameTxt_.text = var_181_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_178_1.leftNameTxt_.transform)

				arg_178_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_178_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_178_1:RecordName(arg_178_1.leftNameTxt_.text)
				SetActive(arg_178_1.iconTrs_.gameObject, true)
				arg_178_1.iconController_:SetSelectedState("hero")

				arg_178_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1095")

				arg_178_1.callingController_:SetSelectedState("normal")

				arg_178_1.keyicon_.color = Color.New(1, 1, 1)
				arg_178_1.icon_.color = Color.New(1, 1, 1)

				local var_181_3 = arg_178_1:GetWordFromCfg(319271040)
				local var_181_4 = arg_178_1:FormatText(var_181_3.content)

				arg_178_1.text_.text = var_181_4

				LuaForUtil.ClearLinePrefixSymbol(arg_178_1.text_)

				local var_181_5 = 5
				local var_181_6 = utf8.len(var_181_4)
				local var_181_7 = var_181_5 <= 0 and var_181_1 or var_181_1 * (var_181_6 / var_181_5)

				if var_181_7 > 0 and var_181_1 < var_181_7 then
					arg_178_1.talkMaxDuration = var_181_7

					if var_181_7 + var_181_0 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_7 + var_181_0
					end
				end

				arg_178_1.text_.text = var_181_4
				arg_178_1.typewritter.percent = 0

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319271", "319271040", "story_v_out_319271.awb") ~= 0 then
					local var_181_8 = manager.audio:GetVoiceLength("story_v_out_319271", "319271040", "story_v_out_319271.awb") / 1000

					if var_181_8 + var_181_0 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_8 + var_181_0
					end

					if var_181_3.prefab_name ~= "" and arg_178_1.actors_[var_181_3.prefab_name] ~= nil then
						local var_181_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_178_1.actors_[var_181_3.prefab_name].transform, "story_v_out_319271", "319271040", "story_v_out_319271.awb")

						arg_178_1:RecordAudio("319271040", var_181_9)
						arg_178_1:RecordAudio("319271040", var_181_9)
					else
						arg_178_1:AudioAction("play", "voice", "story_v_out_319271", "319271040", "story_v_out_319271.awb")
					end

					arg_178_1:RecordHistoryTalkVoice("story_v_out_319271", "319271040", "story_v_out_319271.awb")
				end

				arg_178_1:RecordContent(arg_178_1.text_.text)
			end

			local var_181_10 = math.max(var_181_1, arg_178_1.talkMaxDuration)

			if var_181_0 <= arg_178_1.time_ and arg_178_1.time_ < var_181_0 + var_181_10 then
				arg_178_1.typewritter.percent = (arg_178_1.time_ - var_181_0) / var_181_10

				arg_178_1.typewritter:SetDirty()
			end

			if arg_178_1.time_ >= var_181_0 + var_181_10 and arg_178_1.time_ < var_181_0 + var_181_10 + arg_181_0 then
				arg_178_1.typewritter.percent = 1

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(true)
			end
		end

		arg_178_1.nodeConfigList_ = {}

		arg_178_1:InitPlayNodeList()
	end,
	Play319271041 = function(arg_182_0, arg_182_1)
		arg_182_1.time_ = 0
		arg_182_1.frameCnt_ = 0
		arg_182_1.state_ = "playing"
		arg_182_1.curTalkId_ = 319271041
		arg_182_1.duration_ = 8.87

		local var_182_0 = {
			zh = 4.066,
			ja = 8.866
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
				arg_182_0:Play319271042(arg_182_1)
			end
		end

		function arg_182_1.onSingleLineUpdate_(arg_185_0)
			local var_185_0 = 0
			local var_185_1 = 0.5

			if var_185_0 < arg_182_1.time_ and arg_182_1.time_ <= var_185_0 + arg_185_0 then
				arg_182_1.talkMaxDuration = 0
				arg_182_1.dialogCg_.alpha = 1

				arg_182_1.dialog_:SetActive(true)
				SetActive(arg_182_1.leftNameGo_, true)

				local var_185_2 = arg_182_1:FormatText(StoryNameCfg[6].name)

				arg_182_1.leftNameTxt_.text = var_185_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_182_1.leftNameTxt_.transform)

				arg_182_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_182_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_182_1:RecordName(arg_182_1.leftNameTxt_.text)
				SetActive(arg_182_1.iconTrs_.gameObject, false)
				arg_182_1.callingController_:SetSelectedState("normal")

				local var_185_3 = arg_182_1:GetWordFromCfg(319271041)
				local var_185_4 = arg_182_1:FormatText(var_185_3.content)

				arg_182_1.text_.text = var_185_4

				LuaForUtil.ClearLinePrefixSymbol(arg_182_1.text_)

				local var_185_5 = 20
				local var_185_6 = utf8.len(var_185_4)
				local var_185_7 = var_185_5 <= 0 and var_185_1 or var_185_1 * (var_185_6 / var_185_5)

				if var_185_7 > 0 and var_185_1 < var_185_7 then
					arg_182_1.talkMaxDuration = var_185_7

					if var_185_7 + var_185_0 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_7 + var_185_0
					end
				end

				arg_182_1.text_.text = var_185_4
				arg_182_1.typewritter.percent = 0

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319271", "319271041", "story_v_out_319271.awb") ~= 0 then
					local var_185_8 = manager.audio:GetVoiceLength("story_v_out_319271", "319271041", "story_v_out_319271.awb") / 1000

					if var_185_8 + var_185_0 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_8 + var_185_0
					end

					if var_185_3.prefab_name ~= "" and arg_182_1.actors_[var_185_3.prefab_name] ~= nil then
						local var_185_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_182_1.actors_[var_185_3.prefab_name].transform, "story_v_out_319271", "319271041", "story_v_out_319271.awb")

						arg_182_1:RecordAudio("319271041", var_185_9)
						arg_182_1:RecordAudio("319271041", var_185_9)
					else
						arg_182_1:AudioAction("play", "voice", "story_v_out_319271", "319271041", "story_v_out_319271.awb")
					end

					arg_182_1:RecordHistoryTalkVoice("story_v_out_319271", "319271041", "story_v_out_319271.awb")
				end

				arg_182_1:RecordContent(arg_182_1.text_.text)
			end

			local var_185_10 = math.max(var_185_1, arg_182_1.talkMaxDuration)

			if var_185_0 <= arg_182_1.time_ and arg_182_1.time_ < var_185_0 + var_185_10 then
				arg_182_1.typewritter.percent = (arg_182_1.time_ - var_185_0) / var_185_10

				arg_182_1.typewritter:SetDirty()
			end

			if arg_182_1.time_ >= var_185_0 + var_185_10 and arg_182_1.time_ < var_185_0 + var_185_10 + arg_185_0 then
				arg_182_1.typewritter.percent = 1

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(true)
			end
		end

		arg_182_1.nodeConfigList_ = {}

		arg_182_1:InitPlayNodeList()
	end,
	Play319271042 = function(arg_186_0, arg_186_1)
		arg_186_1.time_ = 0
		arg_186_1.frameCnt_ = 0
		arg_186_1.state_ = "playing"
		arg_186_1.curTalkId_ = 319271042
		arg_186_1.duration_ = 8.7

		local var_186_0 = {
			zh = 3.9,
			ja = 8.7
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
				arg_186_0:Play319271043(arg_186_1)
			end
		end

		function arg_186_1.onSingleLineUpdate_(arg_189_0)
			local var_189_0 = 0
			local var_189_1 = 0.475

			if var_189_0 < arg_186_1.time_ and arg_186_1.time_ <= var_189_0 + arg_189_0 then
				arg_186_1.talkMaxDuration = 0
				arg_186_1.dialogCg_.alpha = 1

				arg_186_1.dialog_:SetActive(true)
				SetActive(arg_186_1.leftNameGo_, true)

				local var_189_2 = arg_186_1:FormatText(StoryNameCfg[471].name)

				arg_186_1.leftNameTxt_.text = var_189_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_186_1.leftNameTxt_.transform)

				arg_186_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_186_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_186_1:RecordName(arg_186_1.leftNameTxt_.text)
				SetActive(arg_186_1.iconTrs_.gameObject, true)
				arg_186_1.iconController_:SetSelectedState("hero")

				arg_186_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1095")

				arg_186_1.callingController_:SetSelectedState("normal")

				arg_186_1.keyicon_.color = Color.New(1, 1, 1)
				arg_186_1.icon_.color = Color.New(1, 1, 1)

				local var_189_3 = arg_186_1:GetWordFromCfg(319271042)
				local var_189_4 = arg_186_1:FormatText(var_189_3.content)

				arg_186_1.text_.text = var_189_4

				LuaForUtil.ClearLinePrefixSymbol(arg_186_1.text_)

				local var_189_5 = 19
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

				if manager.audio:GetVoiceLength("story_v_out_319271", "319271042", "story_v_out_319271.awb") ~= 0 then
					local var_189_8 = manager.audio:GetVoiceLength("story_v_out_319271", "319271042", "story_v_out_319271.awb") / 1000

					if var_189_8 + var_189_0 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_8 + var_189_0
					end

					if var_189_3.prefab_name ~= "" and arg_186_1.actors_[var_189_3.prefab_name] ~= nil then
						local var_189_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_186_1.actors_[var_189_3.prefab_name].transform, "story_v_out_319271", "319271042", "story_v_out_319271.awb")

						arg_186_1:RecordAudio("319271042", var_189_9)
						arg_186_1:RecordAudio("319271042", var_189_9)
					else
						arg_186_1:AudioAction("play", "voice", "story_v_out_319271", "319271042", "story_v_out_319271.awb")
					end

					arg_186_1:RecordHistoryTalkVoice("story_v_out_319271", "319271042", "story_v_out_319271.awb")
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
	Play319271043 = function(arg_190_0, arg_190_1)
		arg_190_1.time_ = 0
		arg_190_1.frameCnt_ = 0
		arg_190_1.state_ = "playing"
		arg_190_1.curTalkId_ = 319271043
		arg_190_1.duration_ = 6.73

		local var_190_0 = {
			zh = 3.266,
			ja = 6.733
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
				arg_190_0:Play319271044(arg_190_1)
			end
		end

		function arg_190_1.onSingleLineUpdate_(arg_193_0)
			local var_193_0 = 0
			local var_193_1 = 0.35

			if var_193_0 < arg_190_1.time_ and arg_190_1.time_ <= var_193_0 + arg_193_0 then
				arg_190_1.talkMaxDuration = 0
				arg_190_1.dialogCg_.alpha = 1

				arg_190_1.dialog_:SetActive(true)
				SetActive(arg_190_1.leftNameGo_, true)

				local var_193_2 = arg_190_1:FormatText(StoryNameCfg[6].name)

				arg_190_1.leftNameTxt_.text = var_193_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_190_1.leftNameTxt_.transform)

				arg_190_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_190_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_190_1:RecordName(arg_190_1.leftNameTxt_.text)
				SetActive(arg_190_1.iconTrs_.gameObject, false)
				arg_190_1.callingController_:SetSelectedState("normal")

				local var_193_3 = arg_190_1:GetWordFromCfg(319271043)
				local var_193_4 = arg_190_1:FormatText(var_193_3.content)

				arg_190_1.text_.text = var_193_4

				LuaForUtil.ClearLinePrefixSymbol(arg_190_1.text_)

				local var_193_5 = 14
				local var_193_6 = utf8.len(var_193_4)
				local var_193_7 = var_193_5 <= 0 and var_193_1 or var_193_1 * (var_193_6 / var_193_5)

				if var_193_7 > 0 and var_193_1 < var_193_7 then
					arg_190_1.talkMaxDuration = var_193_7

					if var_193_7 + var_193_0 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_7 + var_193_0
					end
				end

				arg_190_1.text_.text = var_193_4
				arg_190_1.typewritter.percent = 0

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319271", "319271043", "story_v_out_319271.awb") ~= 0 then
					local var_193_8 = manager.audio:GetVoiceLength("story_v_out_319271", "319271043", "story_v_out_319271.awb") / 1000

					if var_193_8 + var_193_0 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_8 + var_193_0
					end

					if var_193_3.prefab_name ~= "" and arg_190_1.actors_[var_193_3.prefab_name] ~= nil then
						local var_193_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_190_1.actors_[var_193_3.prefab_name].transform, "story_v_out_319271", "319271043", "story_v_out_319271.awb")

						arg_190_1:RecordAudio("319271043", var_193_9)
						arg_190_1:RecordAudio("319271043", var_193_9)
					else
						arg_190_1:AudioAction("play", "voice", "story_v_out_319271", "319271043", "story_v_out_319271.awb")
					end

					arg_190_1:RecordHistoryTalkVoice("story_v_out_319271", "319271043", "story_v_out_319271.awb")
				end

				arg_190_1:RecordContent(arg_190_1.text_.text)
			end

			local var_193_10 = math.max(var_193_1, arg_190_1.talkMaxDuration)

			if var_193_0 <= arg_190_1.time_ and arg_190_1.time_ < var_193_0 + var_193_10 then
				arg_190_1.typewritter.percent = (arg_190_1.time_ - var_193_0) / var_193_10

				arg_190_1.typewritter:SetDirty()
			end

			if arg_190_1.time_ >= var_193_0 + var_193_10 and arg_190_1.time_ < var_193_0 + var_193_10 + arg_193_0 then
				arg_190_1.typewritter.percent = 1

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(true)
			end
		end

		arg_190_1.nodeConfigList_ = {}

		arg_190_1:InitPlayNodeList()
	end,
	Play319271044 = function(arg_194_0, arg_194_1)
		arg_194_1.time_ = 0
		arg_194_1.frameCnt_ = 0
		arg_194_1.state_ = "playing"
		arg_194_1.curTalkId_ = 319271044
		arg_194_1.duration_ = 7.7

		local var_194_0 = {
			zh = 5,
			ja = 7.7
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
				arg_194_0:Play319271045(arg_194_1)
			end
		end

		function arg_194_1.onSingleLineUpdate_(arg_197_0)
			local var_197_0 = 0
			local var_197_1 = 0.525

			if var_197_0 < arg_194_1.time_ and arg_194_1.time_ <= var_197_0 + arg_197_0 then
				arg_194_1.talkMaxDuration = 0
				arg_194_1.dialogCg_.alpha = 1

				arg_194_1.dialog_:SetActive(true)
				SetActive(arg_194_1.leftNameGo_, true)

				local var_197_2 = arg_194_1:FormatText(StoryNameCfg[6].name)

				arg_194_1.leftNameTxt_.text = var_197_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_194_1.leftNameTxt_.transform)

				arg_194_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_194_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_194_1:RecordName(arg_194_1.leftNameTxt_.text)
				SetActive(arg_194_1.iconTrs_.gameObject, false)
				arg_194_1.callingController_:SetSelectedState("normal")

				local var_197_3 = arg_194_1:GetWordFromCfg(319271044)
				local var_197_4 = arg_194_1:FormatText(var_197_3.content)

				arg_194_1.text_.text = var_197_4

				LuaForUtil.ClearLinePrefixSymbol(arg_194_1.text_)

				local var_197_5 = 21
				local var_197_6 = utf8.len(var_197_4)
				local var_197_7 = var_197_5 <= 0 and var_197_1 or var_197_1 * (var_197_6 / var_197_5)

				if var_197_7 > 0 and var_197_1 < var_197_7 then
					arg_194_1.talkMaxDuration = var_197_7

					if var_197_7 + var_197_0 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_7 + var_197_0
					end
				end

				arg_194_1.text_.text = var_197_4
				arg_194_1.typewritter.percent = 0

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319271", "319271044", "story_v_out_319271.awb") ~= 0 then
					local var_197_8 = manager.audio:GetVoiceLength("story_v_out_319271", "319271044", "story_v_out_319271.awb") / 1000

					if var_197_8 + var_197_0 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_8 + var_197_0
					end

					if var_197_3.prefab_name ~= "" and arg_194_1.actors_[var_197_3.prefab_name] ~= nil then
						local var_197_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_194_1.actors_[var_197_3.prefab_name].transform, "story_v_out_319271", "319271044", "story_v_out_319271.awb")

						arg_194_1:RecordAudio("319271044", var_197_9)
						arg_194_1:RecordAudio("319271044", var_197_9)
					else
						arg_194_1:AudioAction("play", "voice", "story_v_out_319271", "319271044", "story_v_out_319271.awb")
					end

					arg_194_1:RecordHistoryTalkVoice("story_v_out_319271", "319271044", "story_v_out_319271.awb")
				end

				arg_194_1:RecordContent(arg_194_1.text_.text)
			end

			local var_197_10 = math.max(var_197_1, arg_194_1.talkMaxDuration)

			if var_197_0 <= arg_194_1.time_ and arg_194_1.time_ < var_197_0 + var_197_10 then
				arg_194_1.typewritter.percent = (arg_194_1.time_ - var_197_0) / var_197_10

				arg_194_1.typewritter:SetDirty()
			end

			if arg_194_1.time_ >= var_197_0 + var_197_10 and arg_194_1.time_ < var_197_0 + var_197_10 + arg_197_0 then
				arg_194_1.typewritter.percent = 1

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(true)
			end
		end

		arg_194_1.nodeConfigList_ = {}

		arg_194_1:InitPlayNodeList()
	end,
	Play319271045 = function(arg_198_0, arg_198_1)
		arg_198_1.time_ = 0
		arg_198_1.frameCnt_ = 0
		arg_198_1.state_ = "playing"
		arg_198_1.curTalkId_ = 319271045
		arg_198_1.duration_ = 3.43

		local var_198_0 = {
			zh = 1.7,
			ja = 3.433
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
				arg_198_0:Play319271046(arg_198_1)
			end
		end

		function arg_198_1.onSingleLineUpdate_(arg_201_0)
			local var_201_0 = 0
			local var_201_1 = 0.225

			if var_201_0 < arg_198_1.time_ and arg_198_1.time_ <= var_201_0 + arg_201_0 then
				arg_198_1.talkMaxDuration = 0
				arg_198_1.dialogCg_.alpha = 1

				arg_198_1.dialog_:SetActive(true)
				SetActive(arg_198_1.leftNameGo_, true)

				local var_201_2 = arg_198_1:FormatText(StoryNameCfg[471].name)

				arg_198_1.leftNameTxt_.text = var_201_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_198_1.leftNameTxt_.transform)

				arg_198_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_198_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_198_1:RecordName(arg_198_1.leftNameTxt_.text)
				SetActive(arg_198_1.iconTrs_.gameObject, true)
				arg_198_1.iconController_:SetSelectedState("hero")

				arg_198_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1095")

				arg_198_1.callingController_:SetSelectedState("normal")

				arg_198_1.keyicon_.color = Color.New(1, 1, 1)
				arg_198_1.icon_.color = Color.New(1, 1, 1)

				local var_201_3 = arg_198_1:GetWordFromCfg(319271045)
				local var_201_4 = arg_198_1:FormatText(var_201_3.content)

				arg_198_1.text_.text = var_201_4

				LuaForUtil.ClearLinePrefixSymbol(arg_198_1.text_)

				local var_201_5 = 9
				local var_201_6 = utf8.len(var_201_4)
				local var_201_7 = var_201_5 <= 0 and var_201_1 or var_201_1 * (var_201_6 / var_201_5)

				if var_201_7 > 0 and var_201_1 < var_201_7 then
					arg_198_1.talkMaxDuration = var_201_7

					if var_201_7 + var_201_0 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_7 + var_201_0
					end
				end

				arg_198_1.text_.text = var_201_4
				arg_198_1.typewritter.percent = 0

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319271", "319271045", "story_v_out_319271.awb") ~= 0 then
					local var_201_8 = manager.audio:GetVoiceLength("story_v_out_319271", "319271045", "story_v_out_319271.awb") / 1000

					if var_201_8 + var_201_0 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_8 + var_201_0
					end

					if var_201_3.prefab_name ~= "" and arg_198_1.actors_[var_201_3.prefab_name] ~= nil then
						local var_201_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_198_1.actors_[var_201_3.prefab_name].transform, "story_v_out_319271", "319271045", "story_v_out_319271.awb")

						arg_198_1:RecordAudio("319271045", var_201_9)
						arg_198_1:RecordAudio("319271045", var_201_9)
					else
						arg_198_1:AudioAction("play", "voice", "story_v_out_319271", "319271045", "story_v_out_319271.awb")
					end

					arg_198_1:RecordHistoryTalkVoice("story_v_out_319271", "319271045", "story_v_out_319271.awb")
				end

				arg_198_1:RecordContent(arg_198_1.text_.text)
			end

			local var_201_10 = math.max(var_201_1, arg_198_1.talkMaxDuration)

			if var_201_0 <= arg_198_1.time_ and arg_198_1.time_ < var_201_0 + var_201_10 then
				arg_198_1.typewritter.percent = (arg_198_1.time_ - var_201_0) / var_201_10

				arg_198_1.typewritter:SetDirty()
			end

			if arg_198_1.time_ >= var_201_0 + var_201_10 and arg_198_1.time_ < var_201_0 + var_201_10 + arg_201_0 then
				arg_198_1.typewritter.percent = 1

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(true)
			end
		end

		arg_198_1.nodeConfigList_ = {}

		arg_198_1:InitPlayNodeList()
	end,
	Play319271046 = function(arg_202_0, arg_202_1)
		arg_202_1.time_ = 0
		arg_202_1.frameCnt_ = 0
		arg_202_1.state_ = "playing"
		arg_202_1.curTalkId_ = 319271046
		arg_202_1.duration_ = 4.83

		local var_202_0 = {
			zh = 4.833,
			ja = 2.766
		}
		local var_202_1 = manager.audio:GetLocalizationFlag()

		if var_202_0[var_202_1] ~= nil then
			arg_202_1.duration_ = var_202_0[var_202_1]
		end

		SetActive(arg_202_1.tipsGo_, false)

		function arg_202_1.onSingleLineFinish_()
			arg_202_1.onSingleLineUpdate_ = nil
			arg_202_1.onSingleLineFinish_ = nil
			arg_202_1.state_ = "waiting"
		end

		function arg_202_1.playNext_(arg_204_0)
			if arg_204_0 == 1 then
				arg_202_0:Play319271047(arg_202_1)
			end
		end

		function arg_202_1.onSingleLineUpdate_(arg_205_0)
			local var_205_0 = 0
			local var_205_1 = 0.575

			if var_205_0 < arg_202_1.time_ and arg_202_1.time_ <= var_205_0 + arg_205_0 then
				arg_202_1.talkMaxDuration = 0
				arg_202_1.dialogCg_.alpha = 1

				arg_202_1.dialog_:SetActive(true)
				SetActive(arg_202_1.leftNameGo_, true)

				local var_205_2 = arg_202_1:FormatText(StoryNameCfg[6].name)

				arg_202_1.leftNameTxt_.text = var_205_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_202_1.leftNameTxt_.transform)

				arg_202_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_202_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_202_1:RecordName(arg_202_1.leftNameTxt_.text)
				SetActive(arg_202_1.iconTrs_.gameObject, false)
				arg_202_1.callingController_:SetSelectedState("normal")

				local var_205_3 = arg_202_1:GetWordFromCfg(319271046)
				local var_205_4 = arg_202_1:FormatText(var_205_3.content)

				arg_202_1.text_.text = var_205_4

				LuaForUtil.ClearLinePrefixSymbol(arg_202_1.text_)

				local var_205_5 = 23
				local var_205_6 = utf8.len(var_205_4)
				local var_205_7 = var_205_5 <= 0 and var_205_1 or var_205_1 * (var_205_6 / var_205_5)

				if var_205_7 > 0 and var_205_1 < var_205_7 then
					arg_202_1.talkMaxDuration = var_205_7

					if var_205_7 + var_205_0 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_7 + var_205_0
					end
				end

				arg_202_1.text_.text = var_205_4
				arg_202_1.typewritter.percent = 0

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319271", "319271046", "story_v_out_319271.awb") ~= 0 then
					local var_205_8 = manager.audio:GetVoiceLength("story_v_out_319271", "319271046", "story_v_out_319271.awb") / 1000

					if var_205_8 + var_205_0 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_8 + var_205_0
					end

					if var_205_3.prefab_name ~= "" and arg_202_1.actors_[var_205_3.prefab_name] ~= nil then
						local var_205_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_202_1.actors_[var_205_3.prefab_name].transform, "story_v_out_319271", "319271046", "story_v_out_319271.awb")

						arg_202_1:RecordAudio("319271046", var_205_9)
						arg_202_1:RecordAudio("319271046", var_205_9)
					else
						arg_202_1:AudioAction("play", "voice", "story_v_out_319271", "319271046", "story_v_out_319271.awb")
					end

					arg_202_1:RecordHistoryTalkVoice("story_v_out_319271", "319271046", "story_v_out_319271.awb")
				end

				arg_202_1:RecordContent(arg_202_1.text_.text)
			end

			local var_205_10 = math.max(var_205_1, arg_202_1.talkMaxDuration)

			if var_205_0 <= arg_202_1.time_ and arg_202_1.time_ < var_205_0 + var_205_10 then
				arg_202_1.typewritter.percent = (arg_202_1.time_ - var_205_0) / var_205_10

				arg_202_1.typewritter:SetDirty()
			end

			if arg_202_1.time_ >= var_205_0 + var_205_10 and arg_202_1.time_ < var_205_0 + var_205_10 + arg_205_0 then
				arg_202_1.typewritter.percent = 1

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(true)
			end
		end

		arg_202_1.nodeConfigList_ = {}

		arg_202_1:InitPlayNodeList()
	end,
	Play319271047 = function(arg_206_0, arg_206_1)
		arg_206_1.time_ = 0
		arg_206_1.frameCnt_ = 0
		arg_206_1.state_ = "playing"
		arg_206_1.curTalkId_ = 319271047
		arg_206_1.duration_ = 4.67

		local var_206_0 = {
			zh = 2.033,
			ja = 4.666
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
				arg_206_0:Play319271048(arg_206_1)
			end
		end

		function arg_206_1.onSingleLineUpdate_(arg_209_0)
			local var_209_0 = 0
			local var_209_1 = 0.3

			if var_209_0 < arg_206_1.time_ and arg_206_1.time_ <= var_209_0 + arg_209_0 then
				arg_206_1.talkMaxDuration = 0
				arg_206_1.dialogCg_.alpha = 1

				arg_206_1.dialog_:SetActive(true)
				SetActive(arg_206_1.leftNameGo_, true)

				local var_209_2 = arg_206_1:FormatText(StoryNameCfg[471].name)

				arg_206_1.leftNameTxt_.text = var_209_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_206_1.leftNameTxt_.transform)

				arg_206_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_206_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_206_1:RecordName(arg_206_1.leftNameTxt_.text)
				SetActive(arg_206_1.iconTrs_.gameObject, true)
				arg_206_1.iconController_:SetSelectedState("hero")

				arg_206_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1095")

				arg_206_1.callingController_:SetSelectedState("normal")

				arg_206_1.keyicon_.color = Color.New(1, 1, 1)
				arg_206_1.icon_.color = Color.New(1, 1, 1)

				local var_209_3 = arg_206_1:GetWordFromCfg(319271047)
				local var_209_4 = arg_206_1:FormatText(var_209_3.content)

				arg_206_1.text_.text = var_209_4

				LuaForUtil.ClearLinePrefixSymbol(arg_206_1.text_)

				local var_209_5 = 12
				local var_209_6 = utf8.len(var_209_4)
				local var_209_7 = var_209_5 <= 0 and var_209_1 or var_209_1 * (var_209_6 / var_209_5)

				if var_209_7 > 0 and var_209_1 < var_209_7 then
					arg_206_1.talkMaxDuration = var_209_7

					if var_209_7 + var_209_0 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_7 + var_209_0
					end
				end

				arg_206_1.text_.text = var_209_4
				arg_206_1.typewritter.percent = 0

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319271", "319271047", "story_v_out_319271.awb") ~= 0 then
					local var_209_8 = manager.audio:GetVoiceLength("story_v_out_319271", "319271047", "story_v_out_319271.awb") / 1000

					if var_209_8 + var_209_0 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_8 + var_209_0
					end

					if var_209_3.prefab_name ~= "" and arg_206_1.actors_[var_209_3.prefab_name] ~= nil then
						local var_209_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_206_1.actors_[var_209_3.prefab_name].transform, "story_v_out_319271", "319271047", "story_v_out_319271.awb")

						arg_206_1:RecordAudio("319271047", var_209_9)
						arg_206_1:RecordAudio("319271047", var_209_9)
					else
						arg_206_1:AudioAction("play", "voice", "story_v_out_319271", "319271047", "story_v_out_319271.awb")
					end

					arg_206_1:RecordHistoryTalkVoice("story_v_out_319271", "319271047", "story_v_out_319271.awb")
				end

				arg_206_1:RecordContent(arg_206_1.text_.text)
			end

			local var_209_10 = math.max(var_209_1, arg_206_1.talkMaxDuration)

			if var_209_0 <= arg_206_1.time_ and arg_206_1.time_ < var_209_0 + var_209_10 then
				arg_206_1.typewritter.percent = (arg_206_1.time_ - var_209_0) / var_209_10

				arg_206_1.typewritter:SetDirty()
			end

			if arg_206_1.time_ >= var_209_0 + var_209_10 and arg_206_1.time_ < var_209_0 + var_209_10 + arg_209_0 then
				arg_206_1.typewritter.percent = 1

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(true)
			end
		end

		arg_206_1.nodeConfigList_ = {}

		arg_206_1:InitPlayNodeList()
	end,
	Play319271048 = function(arg_210_0, arg_210_1)
		arg_210_1.time_ = 0
		arg_210_1.frameCnt_ = 0
		arg_210_1.state_ = "playing"
		arg_210_1.curTalkId_ = 319271048
		arg_210_1.duration_ = 10.8

		local var_210_0 = {
			zh = 5.466,
			ja = 10.8
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
				arg_210_0:Play319271049(arg_210_1)
			end
		end

		function arg_210_1.onSingleLineUpdate_(arg_213_0)
			local var_213_0 = 0
			local var_213_1 = 0.75

			if var_213_0 < arg_210_1.time_ and arg_210_1.time_ <= var_213_0 + arg_213_0 then
				arg_210_1.talkMaxDuration = 0
				arg_210_1.dialogCg_.alpha = 1

				arg_210_1.dialog_:SetActive(true)
				SetActive(arg_210_1.leftNameGo_, true)

				local var_213_2 = arg_210_1:FormatText(StoryNameCfg[6].name)

				arg_210_1.leftNameTxt_.text = var_213_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_210_1.leftNameTxt_.transform)

				arg_210_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_210_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_210_1:RecordName(arg_210_1.leftNameTxt_.text)
				SetActive(arg_210_1.iconTrs_.gameObject, false)
				arg_210_1.callingController_:SetSelectedState("normal")

				local var_213_3 = arg_210_1:GetWordFromCfg(319271048)
				local var_213_4 = arg_210_1:FormatText(var_213_3.content)

				arg_210_1.text_.text = var_213_4

				LuaForUtil.ClearLinePrefixSymbol(arg_210_1.text_)

				local var_213_5 = 30
				local var_213_6 = utf8.len(var_213_4)
				local var_213_7 = var_213_5 <= 0 and var_213_1 or var_213_1 * (var_213_6 / var_213_5)

				if var_213_7 > 0 and var_213_1 < var_213_7 then
					arg_210_1.talkMaxDuration = var_213_7

					if var_213_7 + var_213_0 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_7 + var_213_0
					end
				end

				arg_210_1.text_.text = var_213_4
				arg_210_1.typewritter.percent = 0

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319271", "319271048", "story_v_out_319271.awb") ~= 0 then
					local var_213_8 = manager.audio:GetVoiceLength("story_v_out_319271", "319271048", "story_v_out_319271.awb") / 1000

					if var_213_8 + var_213_0 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_8 + var_213_0
					end

					if var_213_3.prefab_name ~= "" and arg_210_1.actors_[var_213_3.prefab_name] ~= nil then
						local var_213_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_210_1.actors_[var_213_3.prefab_name].transform, "story_v_out_319271", "319271048", "story_v_out_319271.awb")

						arg_210_1:RecordAudio("319271048", var_213_9)
						arg_210_1:RecordAudio("319271048", var_213_9)
					else
						arg_210_1:AudioAction("play", "voice", "story_v_out_319271", "319271048", "story_v_out_319271.awb")
					end

					arg_210_1:RecordHistoryTalkVoice("story_v_out_319271", "319271048", "story_v_out_319271.awb")
				end

				arg_210_1:RecordContent(arg_210_1.text_.text)
			end

			local var_213_10 = math.max(var_213_1, arg_210_1.talkMaxDuration)

			if var_213_0 <= arg_210_1.time_ and arg_210_1.time_ < var_213_0 + var_213_10 then
				arg_210_1.typewritter.percent = (arg_210_1.time_ - var_213_0) / var_213_10

				arg_210_1.typewritter:SetDirty()
			end

			if arg_210_1.time_ >= var_213_0 + var_213_10 and arg_210_1.time_ < var_213_0 + var_213_10 + arg_213_0 then
				arg_210_1.typewritter.percent = 1

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(true)
			end
		end

		arg_210_1.nodeConfigList_ = {}

		arg_210_1:InitPlayNodeList()
	end,
	Play319271049 = function(arg_214_0, arg_214_1)
		arg_214_1.time_ = 0
		arg_214_1.frameCnt_ = 0
		arg_214_1.state_ = "playing"
		arg_214_1.curTalkId_ = 319271049
		arg_214_1.duration_ = 6.2

		local var_214_0 = {
			zh = 6.2,
			ja = 2.066
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
				arg_214_0:Play319271050(arg_214_1)
			end
		end

		function arg_214_1.onSingleLineUpdate_(arg_217_0)
			local var_217_0 = 0
			local var_217_1 = 0.75

			if var_217_0 < arg_214_1.time_ and arg_214_1.time_ <= var_217_0 + arg_217_0 then
				arg_214_1.talkMaxDuration = 0
				arg_214_1.dialogCg_.alpha = 1

				arg_214_1.dialog_:SetActive(true)
				SetActive(arg_214_1.leftNameGo_, true)

				local var_217_2 = arg_214_1:FormatText(StoryNameCfg[6].name)

				arg_214_1.leftNameTxt_.text = var_217_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_214_1.leftNameTxt_.transform)

				arg_214_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_214_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_214_1:RecordName(arg_214_1.leftNameTxt_.text)
				SetActive(arg_214_1.iconTrs_.gameObject, false)
				arg_214_1.callingController_:SetSelectedState("normal")

				local var_217_3 = arg_214_1:GetWordFromCfg(319271049)
				local var_217_4 = arg_214_1:FormatText(var_217_3.content)

				arg_214_1.text_.text = var_217_4

				LuaForUtil.ClearLinePrefixSymbol(arg_214_1.text_)

				local var_217_5 = 30
				local var_217_6 = utf8.len(var_217_4)
				local var_217_7 = var_217_5 <= 0 and var_217_1 or var_217_1 * (var_217_6 / var_217_5)

				if var_217_7 > 0 and var_217_1 < var_217_7 then
					arg_214_1.talkMaxDuration = var_217_7

					if var_217_7 + var_217_0 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_7 + var_217_0
					end
				end

				arg_214_1.text_.text = var_217_4
				arg_214_1.typewritter.percent = 0

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319271", "319271049", "story_v_out_319271.awb") ~= 0 then
					local var_217_8 = manager.audio:GetVoiceLength("story_v_out_319271", "319271049", "story_v_out_319271.awb") / 1000

					if var_217_8 + var_217_0 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_8 + var_217_0
					end

					if var_217_3.prefab_name ~= "" and arg_214_1.actors_[var_217_3.prefab_name] ~= nil then
						local var_217_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_214_1.actors_[var_217_3.prefab_name].transform, "story_v_out_319271", "319271049", "story_v_out_319271.awb")

						arg_214_1:RecordAudio("319271049", var_217_9)
						arg_214_1:RecordAudio("319271049", var_217_9)
					else
						arg_214_1:AudioAction("play", "voice", "story_v_out_319271", "319271049", "story_v_out_319271.awb")
					end

					arg_214_1:RecordHistoryTalkVoice("story_v_out_319271", "319271049", "story_v_out_319271.awb")
				end

				arg_214_1:RecordContent(arg_214_1.text_.text)
			end

			local var_217_10 = math.max(var_217_1, arg_214_1.talkMaxDuration)

			if var_217_0 <= arg_214_1.time_ and arg_214_1.time_ < var_217_0 + var_217_10 then
				arg_214_1.typewritter.percent = (arg_214_1.time_ - var_217_0) / var_217_10

				arg_214_1.typewritter:SetDirty()
			end

			if arg_214_1.time_ >= var_217_0 + var_217_10 and arg_214_1.time_ < var_217_0 + var_217_10 + arg_217_0 then
				arg_214_1.typewritter.percent = 1

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(true)
			end
		end

		arg_214_1.nodeConfigList_ = {}

		arg_214_1:InitPlayNodeList()
	end,
	Play319271050 = function(arg_218_0, arg_218_1)
		arg_218_1.time_ = 0
		arg_218_1.frameCnt_ = 0
		arg_218_1.state_ = "playing"
		arg_218_1.curTalkId_ = 319271050
		arg_218_1.duration_ = 5

		SetActive(arg_218_1.tipsGo_, false)

		function arg_218_1.onSingleLineFinish_()
			arg_218_1.onSingleLineUpdate_ = nil
			arg_218_1.onSingleLineFinish_ = nil
			arg_218_1.state_ = "waiting"
		end

		function arg_218_1.playNext_(arg_220_0)
			if arg_220_0 == 1 then
				arg_218_0:Play319271051(arg_218_1)
			end
		end

		function arg_218_1.onSingleLineUpdate_(arg_221_0)
			local var_221_0 = 0
			local var_221_1 = 0.825

			if var_221_0 < arg_218_1.time_ and arg_218_1.time_ <= var_221_0 + arg_221_0 then
				arg_218_1.talkMaxDuration = 0
				arg_218_1.dialogCg_.alpha = 1

				arg_218_1.dialog_:SetActive(true)
				SetActive(arg_218_1.leftNameGo_, false)

				arg_218_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_218_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_218_1:RecordName(arg_218_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_218_1.iconTrs_.gameObject, false)
				arg_218_1.callingController_:SetSelectedState("normal")

				local var_221_2 = arg_218_1:GetWordFromCfg(319271050)
				local var_221_3 = arg_218_1:FormatText(var_221_2.content)

				arg_218_1.text_.text = var_221_3

				LuaForUtil.ClearLinePrefixSymbol(arg_218_1.text_)

				local var_221_4 = 33
				local var_221_5 = utf8.len(var_221_3)
				local var_221_6 = var_221_4 <= 0 and var_221_1 or var_221_1 * (var_221_5 / var_221_4)

				if var_221_6 > 0 and var_221_1 < var_221_6 then
					arg_218_1.talkMaxDuration = var_221_6

					if var_221_6 + var_221_0 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_6 + var_221_0
					end
				end

				arg_218_1.text_.text = var_221_3
				arg_218_1.typewritter.percent = 0

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(false)
				arg_218_1:RecordContent(arg_218_1.text_.text)
			end

			local var_221_7 = math.max(var_221_1, arg_218_1.talkMaxDuration)

			if var_221_0 <= arg_218_1.time_ and arg_218_1.time_ < var_221_0 + var_221_7 then
				arg_218_1.typewritter.percent = (arg_218_1.time_ - var_221_0) / var_221_7

				arg_218_1.typewritter:SetDirty()
			end

			if arg_218_1.time_ >= var_221_0 + var_221_7 and arg_218_1.time_ < var_221_0 + var_221_7 + arg_221_0 then
				arg_218_1.typewritter.percent = 1

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(true)
			end
		end

		arg_218_1.nodeConfigList_ = {}

		arg_218_1:InitPlayNodeList()
	end,
	Play319271051 = function(arg_222_0, arg_222_1)
		arg_222_1.time_ = 0
		arg_222_1.frameCnt_ = 0
		arg_222_1.state_ = "playing"
		arg_222_1.curTalkId_ = 319271051
		arg_222_1.duration_ = 5

		local var_222_0 = {
			zh = 5,
			ja = 1.4
		}
		local var_222_1 = manager.audio:GetLocalizationFlag()

		if var_222_0[var_222_1] ~= nil then
			arg_222_1.duration_ = var_222_0[var_222_1]
		end

		SetActive(arg_222_1.tipsGo_, false)

		function arg_222_1.onSingleLineFinish_()
			arg_222_1.onSingleLineUpdate_ = nil
			arg_222_1.onSingleLineFinish_ = nil
			arg_222_1.state_ = "waiting"
		end

		function arg_222_1.playNext_(arg_224_0)
			if arg_224_0 == 1 then
				arg_222_0:Play319271052(arg_222_1)
			end
		end

		function arg_222_1.onSingleLineUpdate_(arg_225_0)
			local var_225_0 = 0
			local var_225_1 = 0.575

			if var_225_0 < arg_222_1.time_ and arg_222_1.time_ <= var_225_0 + arg_225_0 then
				arg_222_1.talkMaxDuration = 0
				arg_222_1.dialogCg_.alpha = 1

				arg_222_1.dialog_:SetActive(true)
				SetActive(arg_222_1.leftNameGo_, true)

				local var_225_2 = arg_222_1:FormatText(StoryNameCfg[6].name)

				arg_222_1.leftNameTxt_.text = var_225_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_222_1.leftNameTxt_.transform)

				arg_222_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_222_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_222_1:RecordName(arg_222_1.leftNameTxt_.text)
				SetActive(arg_222_1.iconTrs_.gameObject, false)
				arg_222_1.callingController_:SetSelectedState("normal")

				local var_225_3 = arg_222_1:GetWordFromCfg(319271051)
				local var_225_4 = arg_222_1:FormatText(var_225_3.content)

				arg_222_1.text_.text = var_225_4

				LuaForUtil.ClearLinePrefixSymbol(arg_222_1.text_)

				local var_225_5 = 23
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

				if manager.audio:GetVoiceLength("story_v_out_319271", "319271051", "story_v_out_319271.awb") ~= 0 then
					local var_225_8 = manager.audio:GetVoiceLength("story_v_out_319271", "319271051", "story_v_out_319271.awb") / 1000

					if var_225_8 + var_225_0 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_8 + var_225_0
					end

					if var_225_3.prefab_name ~= "" and arg_222_1.actors_[var_225_3.prefab_name] ~= nil then
						local var_225_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_222_1.actors_[var_225_3.prefab_name].transform, "story_v_out_319271", "319271051", "story_v_out_319271.awb")

						arg_222_1:RecordAudio("319271051", var_225_9)
						arg_222_1:RecordAudio("319271051", var_225_9)
					else
						arg_222_1:AudioAction("play", "voice", "story_v_out_319271", "319271051", "story_v_out_319271.awb")
					end

					arg_222_1:RecordHistoryTalkVoice("story_v_out_319271", "319271051", "story_v_out_319271.awb")
				end

				arg_222_1:RecordContent(arg_222_1.text_.text)
			end

			local var_225_10 = math.max(var_225_1, arg_222_1.talkMaxDuration)

			if var_225_0 <= arg_222_1.time_ and arg_222_1.time_ < var_225_0 + var_225_10 then
				arg_222_1.typewritter.percent = (arg_222_1.time_ - var_225_0) / var_225_10

				arg_222_1.typewritter:SetDirty()
			end

			if arg_222_1.time_ >= var_225_0 + var_225_10 and arg_222_1.time_ < var_225_0 + var_225_10 + arg_225_0 then
				arg_222_1.typewritter.percent = 1

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(true)
			end
		end

		arg_222_1.nodeConfigList_ = {}

		arg_222_1:InitPlayNodeList()
	end,
	Play319271052 = function(arg_226_0, arg_226_1)
		arg_226_1.time_ = 0
		arg_226_1.frameCnt_ = 0
		arg_226_1.state_ = "playing"
		arg_226_1.curTalkId_ = 319271052
		arg_226_1.duration_ = 7.6

		local var_226_0 = {
			zh = 6.633,
			ja = 7.6
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
			arg_226_1.auto_ = false
		end

		function arg_226_1.playNext_(arg_228_0)
			arg_226_1.onStoryFinished_()
		end

		function arg_226_1.onSingleLineUpdate_(arg_229_0)
			local var_229_0 = arg_226_1.bgs_.ML0208.transform
			local var_229_1 = 0

			if var_229_1 < arg_226_1.time_ and arg_226_1.time_ <= var_229_1 + arg_229_0 then
				arg_226_1.var_.moveOldPosML0208 = var_229_0.localPosition
			end

			local var_229_2 = 0.001

			if var_229_1 <= arg_226_1.time_ and arg_226_1.time_ < var_229_1 + var_229_2 then
				local var_229_3 = (arg_226_1.time_ - var_229_1) / var_229_2
				local var_229_4 = Vector3.New(0, 1, 10)

				var_229_0.localPosition = Vector3.Lerp(arg_226_1.var_.moveOldPosML0208, var_229_4, var_229_3)
			end

			if arg_226_1.time_ >= var_229_1 + var_229_2 and arg_226_1.time_ < var_229_1 + var_229_2 + arg_229_0 then
				var_229_0.localPosition = Vector3.New(0, 1, 10)
			end

			local var_229_5 = arg_226_1.bgs_.ML0208.transform
			local var_229_6 = 0.0166666666666667

			if var_229_6 < arg_226_1.time_ and arg_226_1.time_ <= var_229_6 + arg_229_0 then
				arg_226_1.var_.moveOldPosML0208 = var_229_5.localPosition
			end

			local var_229_7 = 2.11666666666667

			if var_229_6 <= arg_226_1.time_ and arg_226_1.time_ < var_229_6 + var_229_7 then
				local var_229_8 = (arg_226_1.time_ - var_229_6) / var_229_7
				local var_229_9 = Vector3.New(0, 0.86, 6.99)

				var_229_5.localPosition = Vector3.Lerp(arg_226_1.var_.moveOldPosML0208, var_229_9, var_229_8)
			end

			if arg_226_1.time_ >= var_229_6 + var_229_7 and arg_226_1.time_ < var_229_6 + var_229_7 + arg_229_0 then
				var_229_5.localPosition = Vector3.New(0, 0.86, 6.99)
			end

			if arg_226_1.frameCnt_ <= 1 then
				arg_226_1.dialog_:SetActive(false)
			end

			local var_229_10 = 1.3
			local var_229_11 = 0.55

			if var_229_10 < arg_226_1.time_ and arg_226_1.time_ <= var_229_10 + arg_229_0 then
				arg_226_1.talkMaxDuration = 0

				arg_226_1.dialog_:SetActive(true)

				arg_226_1.dialogCg_.alpha = 0

				local var_229_12 = LeanTween.value(arg_226_1.dialog_, 0, 1, 0.3)

				var_229_12:setOnUpdate(LuaHelper.FloatAction(function(arg_230_0)
					arg_226_1.dialogCg_.alpha = arg_230_0
				end))
				var_229_12:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_226_1.dialog_)
					var_229_12:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_226_1.duration_ = arg_226_1.duration_ + 0.3

				SetActive(arg_226_1.leftNameGo_, true)

				local var_229_13 = arg_226_1:FormatText(StoryNameCfg[6].name)

				arg_226_1.leftNameTxt_.text = var_229_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_226_1.leftNameTxt_.transform)

				arg_226_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_226_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_226_1:RecordName(arg_226_1.leftNameTxt_.text)
				SetActive(arg_226_1.iconTrs_.gameObject, false)
				arg_226_1.callingController_:SetSelectedState("normal")

				local var_229_14 = arg_226_1:GetWordFromCfg(319271052)
				local var_229_15 = arg_226_1:FormatText(var_229_14.content)

				arg_226_1.text_.text = var_229_15

				LuaForUtil.ClearLinePrefixSymbol(arg_226_1.text_)

				local var_229_16 = 22
				local var_229_17 = utf8.len(var_229_15)
				local var_229_18 = var_229_16 <= 0 and var_229_11 or var_229_11 * (var_229_17 / var_229_16)

				if var_229_18 > 0 and var_229_11 < var_229_18 then
					arg_226_1.talkMaxDuration = var_229_18
					var_229_10 = var_229_10 + 0.3

					if var_229_18 + var_229_10 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_18 + var_229_10
					end
				end

				arg_226_1.text_.text = var_229_15
				arg_226_1.typewritter.percent = 0

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319271", "319271052", "story_v_out_319271.awb") ~= 0 then
					local var_229_19 = manager.audio:GetVoiceLength("story_v_out_319271", "319271052", "story_v_out_319271.awb") / 1000

					if var_229_19 + var_229_10 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_19 + var_229_10
					end

					if var_229_14.prefab_name ~= "" and arg_226_1.actors_[var_229_14.prefab_name] ~= nil then
						local var_229_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_226_1.actors_[var_229_14.prefab_name].transform, "story_v_out_319271", "319271052", "story_v_out_319271.awb")

						arg_226_1:RecordAudio("319271052", var_229_20)
						arg_226_1:RecordAudio("319271052", var_229_20)
					else
						arg_226_1:AudioAction("play", "voice", "story_v_out_319271", "319271052", "story_v_out_319271.awb")
					end

					arg_226_1:RecordHistoryTalkVoice("story_v_out_319271", "319271052", "story_v_out_319271.awb")
				end

				arg_226_1:RecordContent(arg_226_1.text_.text)
			end

			local var_229_21 = var_229_10 + 0.3
			local var_229_22 = math.max(var_229_11, arg_226_1.talkMaxDuration)

			if var_229_21 <= arg_226_1.time_ and arg_226_1.time_ < var_229_21 + var_229_22 then
				arg_226_1.typewritter.percent = (arg_226_1.time_ - var_229_21) / var_229_22

				arg_226_1.typewritter:SetDirty()
			end

			if arg_226_1.time_ >= var_229_21 + var_229_22 and arg_226_1.time_ < var_229_21 + var_229_22 + arg_229_0 then
				arg_226_1.typewritter.percent = 1

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(true)
			end
		end

		arg_226_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "ML0208",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "ML0208",
				changeDisplayLayer = false,
				needEase = false,
				duration = 2.11666666666667,
				className = "StoryMoveNode",
				startTime = 0.0166666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_226_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/I11i",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/ML0208"
	},
	voices = {
		"story_v_out_319271.awb"
	}
}
