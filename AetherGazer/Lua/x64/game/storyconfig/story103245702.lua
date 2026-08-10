return {
	Play324572001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 324572001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play324572002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "H02a"

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
				local var_4_5 = arg_1_1.bgs_.H02a

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
					if iter_4_0 ~= "H02a" then
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

			local var_4_24 = manager.ui.mainCamera.transform
			local var_4_25 = 0

			if var_4_25 < arg_1_1.time_ and arg_1_1.time_ <= var_4_25 + arg_4_0 then
				local var_4_26 = arg_1_1.var_.effectmengjing1
				local var_4_27
				local var_4_28 = var_4_24

				if not var_4_26 then
					var_4_26 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_snapopen"), var_4_28)
					var_4_26.name = "mengjing1"
					arg_1_1.var_.effectmengjing1 = var_4_26
				else
					var_4_26.transform:SetParent(var_4_28)
				end

				var_4_26.transform.localPosition = Vector3.New(0, 0, 0)
				var_4_26.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_4_29 = manager.ui.mainCamera.transform
			local var_4_30 = 2.3

			if var_4_30 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 then
				local var_4_31 = arg_1_1.var_.effectmengjing1

				if var_4_31 then
					Object.Destroy(var_4_31)

					arg_1_1.var_.effectmengjing1 = nil
				end
			end

			local var_4_32 = 0.1
			local var_4_33 = 1

			if var_4_32 < arg_1_1.time_ and arg_1_1.time_ <= var_4_32 + arg_4_0 then
				local var_4_34 = "play"
				local var_4_35 = "effect"

				arg_1_1:AudioAction(var_4_34, var_4_35, "se_story_side_1095", "se_story_side_1095_amb_beach_night", "")
			end

			local var_4_36 = 0
			local var_4_37 = 1

			if var_4_36 < arg_1_1.time_ and arg_1_1.time_ <= var_4_36 + arg_4_0 then
				local var_4_38 = "play"
				local var_4_39 = "effect"

				arg_1_1:AudioAction(var_4_38, var_4_39, "ui_battle", "ui_battle_stopbgm", "")
			end

			local var_4_40 = 1
			local var_4_41 = 1

			if var_4_40 < arg_1_1.time_ and arg_1_1.time_ <= var_4_40 + arg_4_0 then
				local var_4_42 = "play"
				local var_4_43 = "music"

				arg_1_1:AudioAction(var_4_42, var_4_43, "bgm_activity_5_0_story_beach", "bgm_activity_5_0_story_beach", "bgm_activity_5_0_story_beach.awb")

				local var_4_44 = ""
				local var_4_45 = manager.audio:GetAudioName("bgm_activity_5_0_story_beach", "bgm_activity_5_0_story_beach")

				if var_4_45 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_45 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_45

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_45
						arg_1_1.bgmTxt2_.text = var_4_45
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

			local var_4_46 = 2
			local var_4_47 = 0.15

			if var_4_46 < arg_1_1.time_ and arg_1_1.time_ <= var_4_46 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_48 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_48:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_48:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_48:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_49 = arg_1_1:FormatText(StoryNameCfg[7].name)

				arg_1_1.leftNameTxt_.text = var_4_49

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_50 = arg_1_1:GetWordFromCfg(324572001)
				local var_4_51 = arg_1_1:FormatText(var_4_50.content)

				arg_1_1.text_.text = var_4_51

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_52 = 6
				local var_4_53 = utf8.len(var_4_51)
				local var_4_54 = var_4_52 <= 0 and var_4_47 or var_4_47 * (var_4_53 / var_4_52)

				if var_4_54 > 0 and var_4_47 < var_4_54 then
					arg_1_1.talkMaxDuration = var_4_54
					var_4_46 = var_4_46 + 0.3

					if var_4_54 + var_4_46 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_54 + var_4_46
					end
				end

				arg_1_1.text_.text = var_4_51
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_55 = var_4_46 + 0.3
			local var_4_56 = math.max(var_4_47, arg_1_1.talkMaxDuration)

			if var_4_55 <= arg_1_1.time_ and arg_1_1.time_ < var_4_55 + var_4_56 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_55) / var_4_56

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_55 + var_4_56 and arg_1_1.time_ < var_4_55 + var_4_56 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play324572002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 324572002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play324572003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 0
			local var_11_1 = 1.3

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

				local var_11_2 = arg_8_1:GetWordFromCfg(324572002)
				local var_11_3 = arg_8_1:FormatText(var_11_2.content)

				arg_8_1.text_.text = var_11_3

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_4 = 52
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
	Play324572003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 324572003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play324572004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = 0
			local var_15_1 = 0.85

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

				local var_15_2 = arg_12_1:GetWordFromCfg(324572003)
				local var_15_3 = arg_12_1:FormatText(var_15_2.content)

				arg_12_1.text_.text = var_15_3

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_4 = 34
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
	Play324572004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 324572004
		arg_16_1.duration_ = 5

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play324572005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = 0
			local var_19_1 = 0.15

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

				arg_16_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_16_1.callingController_:SetSelectedState("normal")

				arg_16_1.keyicon_.color = Color.New(1, 1, 1)
				arg_16_1.icon_.color = Color.New(1, 1, 1)

				local var_19_3 = arg_16_1:GetWordFromCfg(324572004)
				local var_19_4 = arg_16_1:FormatText(var_19_3.content)

				arg_16_1.text_.text = var_19_4

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_5 = 6
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
	Play324572005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 324572005
		arg_20_1.duration_ = 5

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play324572006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = 0
			local var_23_1 = 0.9

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

				local var_23_2 = arg_20_1:GetWordFromCfg(324572005)
				local var_23_3 = arg_20_1:FormatText(var_23_2.content)

				arg_20_1.text_.text = var_23_3

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_4 = 36
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
	Play324572006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 324572006
		arg_24_1.duration_ = 5.5

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play324572007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = manager.ui.mainCamera.transform
			local var_27_1 = 0

			if var_27_1 < arg_24_1.time_ and arg_24_1.time_ <= var_27_1 + arg_27_0 then
				arg_24_1.var_.shakeOldPos = var_27_0.localPosition
			end

			local var_27_2 = 0.6

			if var_27_1 <= arg_24_1.time_ and arg_24_1.time_ < var_27_1 + var_27_2 then
				local var_27_3 = (arg_24_1.time_ - var_27_1) / 0.066
				local var_27_4, var_27_5 = math.modf(var_27_3)

				var_27_0.localPosition = Vector3.New(var_27_5 * 0.13, var_27_5 * 0.13, var_27_5 * 0.13) + arg_24_1.var_.shakeOldPos
			end

			if arg_24_1.time_ >= var_27_1 + var_27_2 and arg_24_1.time_ < var_27_1 + var_27_2 + arg_27_0 then
				var_27_0.localPosition = arg_24_1.var_.shakeOldPos
			end

			local var_27_6 = 0

			if var_27_6 < arg_24_1.time_ and arg_24_1.time_ <= var_27_6 + arg_27_0 then
				arg_24_1.allBtn_.enabled = false
			end

			local var_27_7 = 0.6

			if arg_24_1.time_ >= var_27_6 + var_27_7 and arg_24_1.time_ < var_27_6 + var_27_7 + arg_27_0 then
				arg_24_1.allBtn_.enabled = true
			end

			if arg_24_1.frameCnt_ <= 1 then
				arg_24_1.dialog_:SetActive(false)
			end

			local var_27_8 = 0.5
			local var_27_9 = 1.55

			if var_27_8 < arg_24_1.time_ and arg_24_1.time_ <= var_27_8 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0

				arg_24_1.dialog_:SetActive(true)

				arg_24_1.dialogCg_.alpha = 0

				local var_27_10 = LeanTween.value(arg_24_1.dialog_, 0, 1, 0.3)

				var_27_10:setOnUpdate(LuaHelper.FloatAction(function(arg_28_0)
					arg_24_1.dialogCg_.alpha = arg_28_0
				end))
				var_27_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_24_1.dialog_)
					var_27_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_24_1.duration_ = arg_24_1.duration_ + 0.3

				SetActive(arg_24_1.leftNameGo_, false)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_11 = arg_24_1:GetWordFromCfg(324572006)
				local var_27_12 = arg_24_1:FormatText(var_27_11.content)

				arg_24_1.text_.text = var_27_12

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_13 = 62
				local var_27_14 = utf8.len(var_27_12)
				local var_27_15 = var_27_13 <= 0 and var_27_9 or var_27_9 * (var_27_14 / var_27_13)

				if var_27_15 > 0 and var_27_9 < var_27_15 then
					arg_24_1.talkMaxDuration = var_27_15
					var_27_8 = var_27_8 + 0.3

					if var_27_15 + var_27_8 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_15 + var_27_8
					end
				end

				arg_24_1.text_.text = var_27_12
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)
				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_16 = var_27_8 + 0.3
			local var_27_17 = math.max(var_27_9, arg_24_1.talkMaxDuration)

			if var_27_16 <= arg_24_1.time_ and arg_24_1.time_ < var_27_16 + var_27_17 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_16) / var_27_17

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_16 + var_27_17 and arg_24_1.time_ < var_27_16 + var_27_17 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play324572007 = function(arg_30_0, arg_30_1)
		arg_30_1.time_ = 0
		arg_30_1.frameCnt_ = 0
		arg_30_1.state_ = "playing"
		arg_30_1.curTalkId_ = 324572007
		arg_30_1.duration_ = 2

		SetActive(arg_30_1.tipsGo_, false)

		function arg_30_1.onSingleLineFinish_()
			arg_30_1.onSingleLineUpdate_ = nil
			arg_30_1.onSingleLineFinish_ = nil
			arg_30_1.state_ = "waiting"
		end

		function arg_30_1.playNext_(arg_32_0)
			if arg_32_0 == 1 then
				arg_30_0:Play324572008(arg_30_1)
			end
		end

		function arg_30_1.onSingleLineUpdate_(arg_33_0)
			local var_33_0 = "10170ui_story"

			if arg_30_1.actors_[var_33_0] == nil then
				local var_33_1 = Asset.Load("Char/" .. "10170ui_story")

				if not isNil(var_33_1) then
					local var_33_2 = Object.Instantiate(Asset.Load("Char/" .. "10170ui_story"), arg_30_1.stage_.transform)

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

			local var_33_5 = arg_30_1.actors_["10170ui_story"].transform
			local var_33_6 = 0

			if var_33_6 < arg_30_1.time_ and arg_30_1.time_ <= var_33_6 + arg_33_0 then
				arg_30_1.var_.moveOldPos10170ui_story = var_33_5.localPosition

				local var_33_7 = GameObjectTools.GetOrAddComponent(var_33_5.gameObject, typeof(DynamicBoneHelper))

				if var_33_7 then
					var_33_7:EnableDynamicBone(false)
				end
			end

			local var_33_8 = 0.001

			if var_33_6 <= arg_30_1.time_ and arg_30_1.time_ < var_33_6 + var_33_8 then
				local var_33_9 = (arg_30_1.time_ - var_33_6) / var_33_8
				local var_33_10 = Vector3.New(0, -1.03, -6.05)

				var_33_5.localPosition = Vector3.Lerp(arg_30_1.var_.moveOldPos10170ui_story, var_33_10, var_33_9)

				local var_33_11 = manager.ui.mainCamera.transform.position - var_33_5.position

				var_33_5.forward = Vector3.New(var_33_11.x, var_33_11.y, var_33_11.z)

				local var_33_12 = var_33_5.localEulerAngles

				var_33_12.z = 0
				var_33_12.x = 0
				var_33_5.localEulerAngles = var_33_12
			end

			if arg_30_1.time_ >= var_33_6 + var_33_8 and arg_30_1.time_ < var_33_6 + var_33_8 + arg_33_0 then
				var_33_5.localPosition = Vector3.New(0, -1.03, -6.05)

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

			local var_33_16 = arg_30_1.actors_["10170ui_story"]
			local var_33_17 = 0

			if var_33_17 < arg_30_1.time_ and arg_30_1.time_ <= var_33_17 + arg_33_0 and not isNil(var_33_16) and arg_30_1.var_.characterEffect10170ui_story == nil then
				arg_30_1.var_.characterEffect10170ui_story = var_33_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_33_18 = 0.200000002980232

			if var_33_17 <= arg_30_1.time_ and arg_30_1.time_ < var_33_17 + var_33_18 and not isNil(var_33_16) then
				local var_33_19 = (arg_30_1.time_ - var_33_17) / var_33_18

				if arg_30_1.var_.characterEffect10170ui_story and not isNil(var_33_16) then
					arg_30_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_30_1.time_ >= var_33_17 + var_33_18 and arg_30_1.time_ < var_33_17 + var_33_18 + arg_33_0 and not isNil(var_33_16) and arg_30_1.var_.characterEffect10170ui_story then
				arg_30_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			local var_33_20 = 0

			if var_33_20 < arg_30_1.time_ and arg_30_1.time_ <= var_33_20 + arg_33_0 then
				arg_30_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/story10170/story10170action/10170action1_1")
			end

			local var_33_21 = 0

			if var_33_21 < arg_30_1.time_ and arg_30_1.time_ <= var_33_21 + arg_33_0 then
				arg_30_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_33_22 = 0
			local var_33_23 = 0.125

			if var_33_22 < arg_30_1.time_ and arg_30_1.time_ <= var_33_22 + arg_33_0 then
				arg_30_1.talkMaxDuration = 0
				arg_30_1.dialogCg_.alpha = 1

				arg_30_1.dialog_:SetActive(true)
				SetActive(arg_30_1.leftNameGo_, true)

				local var_33_24 = arg_30_1:FormatText(StoryNameCfg[1450].name)

				arg_30_1.leftNameTxt_.text = var_33_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_30_1.leftNameTxt_.transform)

				arg_30_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_30_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_30_1:RecordName(arg_30_1.leftNameTxt_.text)
				SetActive(arg_30_1.iconTrs_.gameObject, false)
				arg_30_1.callingController_:SetSelectedState("normal")

				local var_33_25 = arg_30_1:GetWordFromCfg(324572007)
				local var_33_26 = arg_30_1:FormatText(var_33_25.content)

				arg_30_1.text_.text = var_33_26

				LuaForUtil.ClearLinePrefixSymbol(arg_30_1.text_)

				local var_33_27 = 5
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

				if manager.audio:GetVoiceLength("story_v_out_324572", "324572007", "story_v_out_324572.awb") ~= 0 then
					local var_33_30 = manager.audio:GetVoiceLength("story_v_out_324572", "324572007", "story_v_out_324572.awb") / 1000

					if var_33_30 + var_33_22 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_30 + var_33_22
					end

					if var_33_25.prefab_name ~= "" and arg_30_1.actors_[var_33_25.prefab_name] ~= nil then
						local var_33_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_30_1.actors_[var_33_25.prefab_name].transform, "story_v_out_324572", "324572007", "story_v_out_324572.awb")

						arg_30_1:RecordAudio("324572007", var_33_31)
						arg_30_1:RecordAudio("324572007", var_33_31)
					else
						arg_30_1:AudioAction("play", "voice", "story_v_out_324572", "324572007", "story_v_out_324572.awb")
					end

					arg_30_1:RecordHistoryTalkVoice("story_v_out_324572", "324572007", "story_v_out_324572.awb")
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
				actorName = "10170ui_story",
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
	Play324572008 = function(arg_34_0, arg_34_1)
		arg_34_1.time_ = 0
		arg_34_1.frameCnt_ = 0
		arg_34_1.state_ = "playing"
		arg_34_1.curTalkId_ = 324572008
		arg_34_1.duration_ = 5

		SetActive(arg_34_1.tipsGo_, false)

		function arg_34_1.onSingleLineFinish_()
			arg_34_1.onSingleLineUpdate_ = nil
			arg_34_1.onSingleLineFinish_ = nil
			arg_34_1.state_ = "waiting"
		end

		function arg_34_1.playNext_(arg_36_0)
			if arg_36_0 == 1 then
				arg_34_0:Play324572009(arg_34_1)
			end
		end

		function arg_34_1.onSingleLineUpdate_(arg_37_0)
			local var_37_0 = arg_34_1.actors_["10170ui_story"]
			local var_37_1 = 0

			if var_37_1 < arg_34_1.time_ and arg_34_1.time_ <= var_37_1 + arg_37_0 and not isNil(var_37_0) and arg_34_1.var_.characterEffect10170ui_story == nil then
				arg_34_1.var_.characterEffect10170ui_story = var_37_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_37_2 = 0.200000002980232

			if var_37_1 <= arg_34_1.time_ and arg_34_1.time_ < var_37_1 + var_37_2 and not isNil(var_37_0) then
				local var_37_3 = (arg_34_1.time_ - var_37_1) / var_37_2

				if arg_34_1.var_.characterEffect10170ui_story and not isNil(var_37_0) then
					local var_37_4 = Mathf.Lerp(0, 0.5, var_37_3)

					arg_34_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_34_1.var_.characterEffect10170ui_story.fillRatio = var_37_4
				end
			end

			if arg_34_1.time_ >= var_37_1 + var_37_2 and arg_34_1.time_ < var_37_1 + var_37_2 + arg_37_0 and not isNil(var_37_0) and arg_34_1.var_.characterEffect10170ui_story then
				local var_37_5 = 0.5

				arg_34_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_34_1.var_.characterEffect10170ui_story.fillRatio = var_37_5
			end

			local var_37_6 = 0
			local var_37_7 = 0.6

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

				local var_37_9 = arg_34_1:GetWordFromCfg(324572008)
				local var_37_10 = arg_34_1:FormatText(var_37_9.content)

				arg_34_1.text_.text = var_37_10

				LuaForUtil.ClearLinePrefixSymbol(arg_34_1.text_)

				local var_37_11 = 24
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
	Play324572009 = function(arg_38_0, arg_38_1)
		arg_38_1.time_ = 0
		arg_38_1.frameCnt_ = 0
		arg_38_1.state_ = "playing"
		arg_38_1.curTalkId_ = 324572009
		arg_38_1.duration_ = 5.93

		SetActive(arg_38_1.tipsGo_, false)

		function arg_38_1.onSingleLineFinish_()
			arg_38_1.onSingleLineUpdate_ = nil
			arg_38_1.onSingleLineFinish_ = nil
			arg_38_1.state_ = "waiting"
		end

		function arg_38_1.playNext_(arg_40_0)
			if arg_40_0 == 1 then
				arg_38_0:Play324572010(arg_38_1)
			end
		end

		function arg_38_1.onSingleLineUpdate_(arg_41_0)
			local var_41_0 = arg_38_1.actors_["10170ui_story"]
			local var_41_1 = 0

			if var_41_1 < arg_38_1.time_ and arg_38_1.time_ <= var_41_1 + arg_41_0 and not isNil(var_41_0) and arg_38_1.var_.characterEffect10170ui_story == nil then
				arg_38_1.var_.characterEffect10170ui_story = var_41_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_41_2 = 0.200000002980232

			if var_41_1 <= arg_38_1.time_ and arg_38_1.time_ < var_41_1 + var_41_2 and not isNil(var_41_0) then
				local var_41_3 = (arg_38_1.time_ - var_41_1) / var_41_2

				if arg_38_1.var_.characterEffect10170ui_story and not isNil(var_41_0) then
					arg_38_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_38_1.time_ >= var_41_1 + var_41_2 and arg_38_1.time_ < var_41_1 + var_41_2 + arg_41_0 and not isNil(var_41_0) and arg_38_1.var_.characterEffect10170ui_story then
				arg_38_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			local var_41_4 = 0
			local var_41_5 = 0.65

			if var_41_4 < arg_38_1.time_ and arg_38_1.time_ <= var_41_4 + arg_41_0 then
				arg_38_1.talkMaxDuration = 0
				arg_38_1.dialogCg_.alpha = 1

				arg_38_1.dialog_:SetActive(true)
				SetActive(arg_38_1.leftNameGo_, true)

				local var_41_6 = arg_38_1:FormatText(StoryNameCfg[1450].name)

				arg_38_1.leftNameTxt_.text = var_41_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_38_1.leftNameTxt_.transform)

				arg_38_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_38_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_38_1:RecordName(arg_38_1.leftNameTxt_.text)
				SetActive(arg_38_1.iconTrs_.gameObject, false)
				arg_38_1.callingController_:SetSelectedState("normal")

				local var_41_7 = arg_38_1:GetWordFromCfg(324572009)
				local var_41_8 = arg_38_1:FormatText(var_41_7.content)

				arg_38_1.text_.text = var_41_8

				LuaForUtil.ClearLinePrefixSymbol(arg_38_1.text_)

				local var_41_9 = 26
				local var_41_10 = utf8.len(var_41_8)
				local var_41_11 = var_41_9 <= 0 and var_41_5 or var_41_5 * (var_41_10 / var_41_9)

				if var_41_11 > 0 and var_41_5 < var_41_11 then
					arg_38_1.talkMaxDuration = var_41_11

					if var_41_11 + var_41_4 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_11 + var_41_4
					end
				end

				arg_38_1.text_.text = var_41_8
				arg_38_1.typewritter.percent = 0

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324572", "324572009", "story_v_out_324572.awb") ~= 0 then
					local var_41_12 = manager.audio:GetVoiceLength("story_v_out_324572", "324572009", "story_v_out_324572.awb") / 1000

					if var_41_12 + var_41_4 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_12 + var_41_4
					end

					if var_41_7.prefab_name ~= "" and arg_38_1.actors_[var_41_7.prefab_name] ~= nil then
						local var_41_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_38_1.actors_[var_41_7.prefab_name].transform, "story_v_out_324572", "324572009", "story_v_out_324572.awb")

						arg_38_1:RecordAudio("324572009", var_41_13)
						arg_38_1:RecordAudio("324572009", var_41_13)
					else
						arg_38_1:AudioAction("play", "voice", "story_v_out_324572", "324572009", "story_v_out_324572.awb")
					end

					arg_38_1:RecordHistoryTalkVoice("story_v_out_324572", "324572009", "story_v_out_324572.awb")
				end

				arg_38_1:RecordContent(arg_38_1.text_.text)
			end

			local var_41_14 = math.max(var_41_5, arg_38_1.talkMaxDuration)

			if var_41_4 <= arg_38_1.time_ and arg_38_1.time_ < var_41_4 + var_41_14 then
				arg_38_1.typewritter.percent = (arg_38_1.time_ - var_41_4) / var_41_14

				arg_38_1.typewritter:SetDirty()
			end

			if arg_38_1.time_ >= var_41_4 + var_41_14 and arg_38_1.time_ < var_41_4 + var_41_14 + arg_41_0 then
				arg_38_1.typewritter.percent = 1

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(true)
			end
		end

		arg_38_1.nodeConfigList_ = {}

		arg_38_1:InitPlayNodeList()
	end,
	Play324572010 = function(arg_42_0, arg_42_1)
		arg_42_1.time_ = 0
		arg_42_1.frameCnt_ = 0
		arg_42_1.state_ = "playing"
		arg_42_1.curTalkId_ = 324572010
		arg_42_1.duration_ = 5

		SetActive(arg_42_1.tipsGo_, false)

		function arg_42_1.onSingleLineFinish_()
			arg_42_1.onSingleLineUpdate_ = nil
			arg_42_1.onSingleLineFinish_ = nil
			arg_42_1.state_ = "waiting"
		end

		function arg_42_1.playNext_(arg_44_0)
			if arg_44_0 == 1 then
				arg_42_0:Play324572011(arg_42_1)
			end
		end

		function arg_42_1.onSingleLineUpdate_(arg_45_0)
			local var_45_0 = arg_42_1.actors_["10170ui_story"]
			local var_45_1 = 0

			if var_45_1 < arg_42_1.time_ and arg_42_1.time_ <= var_45_1 + arg_45_0 and not isNil(var_45_0) and arg_42_1.var_.characterEffect10170ui_story == nil then
				arg_42_1.var_.characterEffect10170ui_story = var_45_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_45_2 = 0.200000002980232

			if var_45_1 <= arg_42_1.time_ and arg_42_1.time_ < var_45_1 + var_45_2 and not isNil(var_45_0) then
				local var_45_3 = (arg_42_1.time_ - var_45_1) / var_45_2

				if arg_42_1.var_.characterEffect10170ui_story and not isNil(var_45_0) then
					local var_45_4 = Mathf.Lerp(0, 0.5, var_45_3)

					arg_42_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_42_1.var_.characterEffect10170ui_story.fillRatio = var_45_4
				end
			end

			if arg_42_1.time_ >= var_45_1 + var_45_2 and arg_42_1.time_ < var_45_1 + var_45_2 + arg_45_0 and not isNil(var_45_0) and arg_42_1.var_.characterEffect10170ui_story then
				local var_45_5 = 0.5

				arg_42_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_42_1.var_.characterEffect10170ui_story.fillRatio = var_45_5
			end

			local var_45_6 = 0
			local var_45_7 = 0.25

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

				local var_45_9 = arg_42_1:GetWordFromCfg(324572010)
				local var_45_10 = arg_42_1:FormatText(var_45_9.content)

				arg_42_1.text_.text = var_45_10

				LuaForUtil.ClearLinePrefixSymbol(arg_42_1.text_)

				local var_45_11 = 10
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
	Play324572011 = function(arg_46_0, arg_46_1)
		arg_46_1.time_ = 0
		arg_46_1.frameCnt_ = 0
		arg_46_1.state_ = "playing"
		arg_46_1.curTalkId_ = 324572011
		arg_46_1.duration_ = 3.4

		SetActive(arg_46_1.tipsGo_, false)

		function arg_46_1.onSingleLineFinish_()
			arg_46_1.onSingleLineUpdate_ = nil
			arg_46_1.onSingleLineFinish_ = nil
			arg_46_1.state_ = "waiting"
		end

		function arg_46_1.playNext_(arg_48_0)
			if arg_48_0 == 1 then
				arg_46_0:Play324572012(arg_46_1)
			end
		end

		function arg_46_1.onSingleLineUpdate_(arg_49_0)
			local var_49_0 = arg_46_1.actors_["10170ui_story"]
			local var_49_1 = 0

			if var_49_1 < arg_46_1.time_ and arg_46_1.time_ <= var_49_1 + arg_49_0 and not isNil(var_49_0) and arg_46_1.var_.characterEffect10170ui_story == nil then
				arg_46_1.var_.characterEffect10170ui_story = var_49_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_49_2 = 0.200000002980232

			if var_49_1 <= arg_46_1.time_ and arg_46_1.time_ < var_49_1 + var_49_2 and not isNil(var_49_0) then
				local var_49_3 = (arg_46_1.time_ - var_49_1) / var_49_2

				if arg_46_1.var_.characterEffect10170ui_story and not isNil(var_49_0) then
					arg_46_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_46_1.time_ >= var_49_1 + var_49_2 and arg_46_1.time_ < var_49_1 + var_49_2 + arg_49_0 and not isNil(var_49_0) and arg_46_1.var_.characterEffect10170ui_story then
				arg_46_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			local var_49_4 = 0

			if var_49_4 < arg_46_1.time_ and arg_46_1.time_ <= var_49_4 + arg_49_0 then
				arg_46_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/story10170/story10170action/10170action15_1")
			end

			local var_49_5 = 0
			local var_49_6 = 0.35

			if var_49_5 < arg_46_1.time_ and arg_46_1.time_ <= var_49_5 + arg_49_0 then
				arg_46_1.talkMaxDuration = 0
				arg_46_1.dialogCg_.alpha = 1

				arg_46_1.dialog_:SetActive(true)
				SetActive(arg_46_1.leftNameGo_, true)

				local var_49_7 = arg_46_1:FormatText(StoryNameCfg[1450].name)

				arg_46_1.leftNameTxt_.text = var_49_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_46_1.leftNameTxt_.transform)

				arg_46_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_46_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_46_1:RecordName(arg_46_1.leftNameTxt_.text)
				SetActive(arg_46_1.iconTrs_.gameObject, false)
				arg_46_1.callingController_:SetSelectedState("normal")

				local var_49_8 = arg_46_1:GetWordFromCfg(324572011)
				local var_49_9 = arg_46_1:FormatText(var_49_8.content)

				arg_46_1.text_.text = var_49_9

				LuaForUtil.ClearLinePrefixSymbol(arg_46_1.text_)

				local var_49_10 = 14
				local var_49_11 = utf8.len(var_49_9)
				local var_49_12 = var_49_10 <= 0 and var_49_6 or var_49_6 * (var_49_11 / var_49_10)

				if var_49_12 > 0 and var_49_6 < var_49_12 then
					arg_46_1.talkMaxDuration = var_49_12

					if var_49_12 + var_49_5 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_12 + var_49_5
					end
				end

				arg_46_1.text_.text = var_49_9
				arg_46_1.typewritter.percent = 0

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324572", "324572011", "story_v_out_324572.awb") ~= 0 then
					local var_49_13 = manager.audio:GetVoiceLength("story_v_out_324572", "324572011", "story_v_out_324572.awb") / 1000

					if var_49_13 + var_49_5 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_13 + var_49_5
					end

					if var_49_8.prefab_name ~= "" and arg_46_1.actors_[var_49_8.prefab_name] ~= nil then
						local var_49_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_46_1.actors_[var_49_8.prefab_name].transform, "story_v_out_324572", "324572011", "story_v_out_324572.awb")

						arg_46_1:RecordAudio("324572011", var_49_14)
						arg_46_1:RecordAudio("324572011", var_49_14)
					else
						arg_46_1:AudioAction("play", "voice", "story_v_out_324572", "324572011", "story_v_out_324572.awb")
					end

					arg_46_1:RecordHistoryTalkVoice("story_v_out_324572", "324572011", "story_v_out_324572.awb")
				end

				arg_46_1:RecordContent(arg_46_1.text_.text)
			end

			local var_49_15 = math.max(var_49_6, arg_46_1.talkMaxDuration)

			if var_49_5 <= arg_46_1.time_ and arg_46_1.time_ < var_49_5 + var_49_15 then
				arg_46_1.typewritter.percent = (arg_46_1.time_ - var_49_5) / var_49_15

				arg_46_1.typewritter:SetDirty()
			end

			if arg_46_1.time_ >= var_49_5 + var_49_15 and arg_46_1.time_ < var_49_5 + var_49_15 + arg_49_0 then
				arg_46_1.typewritter.percent = 1

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(true)
			end
		end

		arg_46_1.nodeConfigList_ = {}

		arg_46_1:InitPlayNodeList()
	end,
	Play324572012 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 324572012
		arg_50_1.duration_ = 5

		SetActive(arg_50_1.tipsGo_, false)

		function arg_50_1.onSingleLineFinish_()
			arg_50_1.onSingleLineUpdate_ = nil
			arg_50_1.onSingleLineFinish_ = nil
			arg_50_1.state_ = "waiting"
		end

		function arg_50_1.playNext_(arg_52_0)
			if arg_52_0 == 1 then
				arg_50_0:Play324572013(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			local var_53_0 = arg_50_1.actors_["10170ui_story"]
			local var_53_1 = 0

			if var_53_1 < arg_50_1.time_ and arg_50_1.time_ <= var_53_1 + arg_53_0 and not isNil(var_53_0) and arg_50_1.var_.characterEffect10170ui_story == nil then
				arg_50_1.var_.characterEffect10170ui_story = var_53_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_53_2 = 0.200000002980232

			if var_53_1 <= arg_50_1.time_ and arg_50_1.time_ < var_53_1 + var_53_2 and not isNil(var_53_0) then
				local var_53_3 = (arg_50_1.time_ - var_53_1) / var_53_2

				if arg_50_1.var_.characterEffect10170ui_story and not isNil(var_53_0) then
					local var_53_4 = Mathf.Lerp(0, 0.5, var_53_3)

					arg_50_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_50_1.var_.characterEffect10170ui_story.fillRatio = var_53_4
				end
			end

			if arg_50_1.time_ >= var_53_1 + var_53_2 and arg_50_1.time_ < var_53_1 + var_53_2 + arg_53_0 and not isNil(var_53_0) and arg_50_1.var_.characterEffect10170ui_story then
				local var_53_5 = 0.5

				arg_50_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_50_1.var_.characterEffect10170ui_story.fillRatio = var_53_5
			end

			local var_53_6 = 0
			local var_53_7 = 0.45

			if var_53_6 < arg_50_1.time_ and arg_50_1.time_ <= var_53_6 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0
				arg_50_1.dialogCg_.alpha = 1

				arg_50_1.dialog_:SetActive(true)
				SetActive(arg_50_1.leftNameGo_, true)

				local var_53_8 = arg_50_1:FormatText(StoryNameCfg[7].name)

				arg_50_1.leftNameTxt_.text = var_53_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_50_1.leftNameTxt_.transform)

				arg_50_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_50_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_50_1:RecordName(arg_50_1.leftNameTxt_.text)
				SetActive(arg_50_1.iconTrs_.gameObject, true)
				arg_50_1.iconController_:SetSelectedState("hero")

				arg_50_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_50_1.callingController_:SetSelectedState("normal")

				arg_50_1.keyicon_.color = Color.New(1, 1, 1)
				arg_50_1.icon_.color = Color.New(1, 1, 1)

				local var_53_9 = arg_50_1:GetWordFromCfg(324572012)
				local var_53_10 = arg_50_1:FormatText(var_53_9.content)

				arg_50_1.text_.text = var_53_10

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_11 = 18
				local var_53_12 = utf8.len(var_53_10)
				local var_53_13 = var_53_11 <= 0 and var_53_7 or var_53_7 * (var_53_12 / var_53_11)

				if var_53_13 > 0 and var_53_7 < var_53_13 then
					arg_50_1.talkMaxDuration = var_53_13

					if var_53_13 + var_53_6 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_13 + var_53_6
					end
				end

				arg_50_1.text_.text = var_53_10
				arg_50_1.typewritter.percent = 0

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(false)
				arg_50_1:RecordContent(arg_50_1.text_.text)
			end

			local var_53_14 = math.max(var_53_7, arg_50_1.talkMaxDuration)

			if var_53_6 <= arg_50_1.time_ and arg_50_1.time_ < var_53_6 + var_53_14 then
				arg_50_1.typewritter.percent = (arg_50_1.time_ - var_53_6) / var_53_14

				arg_50_1.typewritter:SetDirty()
			end

			if arg_50_1.time_ >= var_53_6 + var_53_14 and arg_50_1.time_ < var_53_6 + var_53_14 + arg_53_0 then
				arg_50_1.typewritter.percent = 1

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(true)
			end
		end

		arg_50_1.nodeConfigList_ = {}

		arg_50_1:InitPlayNodeList()
	end,
	Play324572013 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 324572013
		arg_54_1.duration_ = 6.63

		SetActive(arg_54_1.tipsGo_, false)

		function arg_54_1.onSingleLineFinish_()
			arg_54_1.onSingleLineUpdate_ = nil
			arg_54_1.onSingleLineFinish_ = nil
			arg_54_1.state_ = "waiting"
		end

		function arg_54_1.playNext_(arg_56_0)
			if arg_56_0 == 1 then
				arg_54_0:Play324572014(arg_54_1)
			end
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			local var_57_0 = arg_54_1.actors_["10170ui_story"]
			local var_57_1 = 0

			if var_57_1 < arg_54_1.time_ and arg_54_1.time_ <= var_57_1 + arg_57_0 and not isNil(var_57_0) and arg_54_1.var_.characterEffect10170ui_story == nil then
				arg_54_1.var_.characterEffect10170ui_story = var_57_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_57_2 = 0.200000002980232

			if var_57_1 <= arg_54_1.time_ and arg_54_1.time_ < var_57_1 + var_57_2 and not isNil(var_57_0) then
				local var_57_3 = (arg_54_1.time_ - var_57_1) / var_57_2

				if arg_54_1.var_.characterEffect10170ui_story and not isNil(var_57_0) then
					arg_54_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_54_1.time_ >= var_57_1 + var_57_2 and arg_54_1.time_ < var_57_1 + var_57_2 + arg_57_0 and not isNil(var_57_0) and arg_54_1.var_.characterEffect10170ui_story then
				arg_54_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			local var_57_4 = 0

			if var_57_4 < arg_54_1.time_ and arg_54_1.time_ <= var_57_4 + arg_57_0 then
				arg_54_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/story10170/story10170action/10170action15_2")
			end

			local var_57_5 = 0

			if var_57_5 < arg_54_1.time_ and arg_54_1.time_ <= var_57_5 + arg_57_0 then
				arg_54_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_57_6 = 0
			local var_57_7 = 0.725

			if var_57_6 < arg_54_1.time_ and arg_54_1.time_ <= var_57_6 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0
				arg_54_1.dialogCg_.alpha = 1

				arg_54_1.dialog_:SetActive(true)
				SetActive(arg_54_1.leftNameGo_, true)

				local var_57_8 = arg_54_1:FormatText(StoryNameCfg[1450].name)

				arg_54_1.leftNameTxt_.text = var_57_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_54_1.leftNameTxt_.transform)

				arg_54_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_54_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_54_1:RecordName(arg_54_1.leftNameTxt_.text)
				SetActive(arg_54_1.iconTrs_.gameObject, false)
				arg_54_1.callingController_:SetSelectedState("normal")

				local var_57_9 = arg_54_1:GetWordFromCfg(324572013)
				local var_57_10 = arg_54_1:FormatText(var_57_9.content)

				arg_54_1.text_.text = var_57_10

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_11 = 29
				local var_57_12 = utf8.len(var_57_10)
				local var_57_13 = var_57_11 <= 0 and var_57_7 or var_57_7 * (var_57_12 / var_57_11)

				if var_57_13 > 0 and var_57_7 < var_57_13 then
					arg_54_1.talkMaxDuration = var_57_13

					if var_57_13 + var_57_6 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_13 + var_57_6
					end
				end

				arg_54_1.text_.text = var_57_10
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324572", "324572013", "story_v_out_324572.awb") ~= 0 then
					local var_57_14 = manager.audio:GetVoiceLength("story_v_out_324572", "324572013", "story_v_out_324572.awb") / 1000

					if var_57_14 + var_57_6 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_14 + var_57_6
					end

					if var_57_9.prefab_name ~= "" and arg_54_1.actors_[var_57_9.prefab_name] ~= nil then
						local var_57_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_54_1.actors_[var_57_9.prefab_name].transform, "story_v_out_324572", "324572013", "story_v_out_324572.awb")

						arg_54_1:RecordAudio("324572013", var_57_15)
						arg_54_1:RecordAudio("324572013", var_57_15)
					else
						arg_54_1:AudioAction("play", "voice", "story_v_out_324572", "324572013", "story_v_out_324572.awb")
					end

					arg_54_1:RecordHistoryTalkVoice("story_v_out_324572", "324572013", "story_v_out_324572.awb")
				end

				arg_54_1:RecordContent(arg_54_1.text_.text)
			end

			local var_57_16 = math.max(var_57_7, arg_54_1.talkMaxDuration)

			if var_57_6 <= arg_54_1.time_ and arg_54_1.time_ < var_57_6 + var_57_16 then
				arg_54_1.typewritter.percent = (arg_54_1.time_ - var_57_6) / var_57_16

				arg_54_1.typewritter:SetDirty()
			end

			if arg_54_1.time_ >= var_57_6 + var_57_16 and arg_54_1.time_ < var_57_6 + var_57_16 + arg_57_0 then
				arg_54_1.typewritter.percent = 1

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(true)
			end
		end

		arg_54_1.nodeConfigList_ = {}

		arg_54_1:InitPlayNodeList()
	end,
	Play324572014 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 324572014
		arg_58_1.duration_ = 5

		SetActive(arg_58_1.tipsGo_, false)

		function arg_58_1.onSingleLineFinish_()
			arg_58_1.onSingleLineUpdate_ = nil
			arg_58_1.onSingleLineFinish_ = nil
			arg_58_1.state_ = "waiting"
		end

		function arg_58_1.playNext_(arg_60_0)
			if arg_60_0 == 1 then
				arg_58_0:Play324572015(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			local var_61_0 = arg_58_1.actors_["10170ui_story"]
			local var_61_1 = 0

			if var_61_1 < arg_58_1.time_ and arg_58_1.time_ <= var_61_1 + arg_61_0 and not isNil(var_61_0) and arg_58_1.var_.characterEffect10170ui_story == nil then
				arg_58_1.var_.characterEffect10170ui_story = var_61_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_61_2 = 0.200000002980232

			if var_61_1 <= arg_58_1.time_ and arg_58_1.time_ < var_61_1 + var_61_2 and not isNil(var_61_0) then
				local var_61_3 = (arg_58_1.time_ - var_61_1) / var_61_2

				if arg_58_1.var_.characterEffect10170ui_story and not isNil(var_61_0) then
					local var_61_4 = Mathf.Lerp(0, 0.5, var_61_3)

					arg_58_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_58_1.var_.characterEffect10170ui_story.fillRatio = var_61_4
				end
			end

			if arg_58_1.time_ >= var_61_1 + var_61_2 and arg_58_1.time_ < var_61_1 + var_61_2 + arg_61_0 and not isNil(var_61_0) and arg_58_1.var_.characterEffect10170ui_story then
				local var_61_5 = 0.5

				arg_58_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_58_1.var_.characterEffect10170ui_story.fillRatio = var_61_5
			end

			local var_61_6 = 0
			local var_61_7 = 0.1

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

				local var_61_9 = arg_58_1:GetWordFromCfg(324572014)
				local var_61_10 = arg_58_1:FormatText(var_61_9.content)

				arg_58_1.text_.text = var_61_10

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_11 = 4
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
	Play324572015 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 324572015
		arg_62_1.duration_ = 8.6

		SetActive(arg_62_1.tipsGo_, false)

		function arg_62_1.onSingleLineFinish_()
			arg_62_1.onSingleLineUpdate_ = nil
			arg_62_1.onSingleLineFinish_ = nil
			arg_62_1.state_ = "waiting"
		end

		function arg_62_1.playNext_(arg_64_0)
			if arg_64_0 == 1 then
				arg_62_0:Play324572016(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			local var_65_0 = "STblack"

			if arg_62_1.bgs_[var_65_0] == nil then
				local var_65_1 = Object.Instantiate(arg_62_1.paintGo_)

				var_65_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_65_0)
				var_65_1.name = var_65_0
				var_65_1.transform.parent = arg_62_1.stage_.transform
				var_65_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_62_1.bgs_[var_65_0] = var_65_1
			end

			local var_65_2 = 1.96599999815226

			if var_65_2 < arg_62_1.time_ and arg_62_1.time_ <= var_65_2 + arg_65_0 then
				local var_65_3 = manager.ui.mainCamera.transform.localPosition
				local var_65_4 = Vector3.New(0, 0, 10) + Vector3.New(var_65_3.x, var_65_3.y, 0)
				local var_65_5 = arg_62_1.bgs_.STblack

				var_65_5.transform.localPosition = var_65_4
				var_65_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_65_6 = var_65_5:GetComponent("SpriteRenderer")

				if var_65_6 and var_65_6.sprite then
					local var_65_7 = (var_65_5.transform.localPosition - var_65_3).z
					local var_65_8 = manager.ui.mainCameraCom_
					local var_65_9 = 2 * var_65_7 * Mathf.Tan(var_65_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_65_10 = var_65_9 * var_65_8.aspect
					local var_65_11 = var_65_6.sprite.bounds.size.x
					local var_65_12 = var_65_6.sprite.bounds.size.y
					local var_65_13 = var_65_10 / var_65_11
					local var_65_14 = var_65_9 / var_65_12
					local var_65_15 = var_65_14 < var_65_13 and var_65_13 or var_65_14

					var_65_5.transform.localScale = Vector3.New(var_65_15, var_65_15, 0)
				end

				for iter_65_0, iter_65_1 in pairs(arg_62_1.bgs_) do
					if iter_65_0 ~= "STblack" then
						iter_65_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_65_16 = arg_62_1.actors_["10170ui_story"].transform
			local var_65_17 = 0

			if var_65_17 < arg_62_1.time_ and arg_62_1.time_ <= var_65_17 + arg_65_0 then
				arg_62_1.var_.moveOldPos10170ui_story = var_65_16.localPosition

				local var_65_18 = GameObjectTools.GetOrAddComponent(var_65_16.gameObject, typeof(DynamicBoneHelper))

				if var_65_18 then
					var_65_18:EnableDynamicBone(false)
				end
			end

			local var_65_19 = 0.1

			if var_65_17 <= arg_62_1.time_ and arg_62_1.time_ < var_65_17 + var_65_19 then
				local var_65_20 = (arg_62_1.time_ - var_65_17) / var_65_19
				local var_65_21 = Vector3.New(0, 100, 0)

				var_65_16.localPosition = Vector3.Lerp(arg_62_1.var_.moveOldPos10170ui_story, var_65_21, var_65_20)

				local var_65_22 = manager.ui.mainCamera.transform.position - var_65_16.position

				var_65_16.forward = Vector3.New(var_65_22.x, var_65_22.y, var_65_22.z)

				local var_65_23 = var_65_16.localEulerAngles

				var_65_23.z = 0
				var_65_23.x = 0
				var_65_16.localEulerAngles = var_65_23
			end

			if arg_62_1.time_ >= var_65_17 + var_65_19 and arg_62_1.time_ < var_65_17 + var_65_19 + arg_65_0 then
				var_65_16.localPosition = Vector3.New(0, 100, 0)

				local var_65_24 = manager.ui.mainCamera.transform.position - var_65_16.position

				var_65_16.forward = Vector3.New(var_65_24.x, var_65_24.y, var_65_24.z)

				local var_65_25 = var_65_16.localEulerAngles

				var_65_25.z = 0
				var_65_25.x = 0
				var_65_16.localEulerAngles = var_65_25

				local var_65_26 = GameObjectTools.GetOrAddComponent(var_65_16.gameObject, typeof(DynamicBoneHelper))

				if var_65_26 then
					var_65_26:EnableDynamicBone(true)
				end
			end

			local var_65_27 = manager.ui.mainCamera.transform
			local var_65_28 = 0

			if var_65_28 < arg_62_1.time_ and arg_62_1.time_ <= var_65_28 + arg_65_0 then
				local var_65_29 = arg_62_1.var_.effecthuiyi1
				local var_65_30
				local var_65_31 = var_65_27

				if not var_65_29 then
					var_65_29 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_snapshut"), var_65_31)
					var_65_29.name = "huiyi1"
					arg_62_1.var_.effecthuiyi1 = var_65_29
				else
					var_65_29.transform:SetParent(var_65_31)
				end

				var_65_29.transform.localPosition = Vector3.New(0, 0, 0)
				var_65_29.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_65_32 = manager.ui.mainCamera.transform
			local var_65_33 = 1.96666666666667

			if var_65_33 < arg_62_1.time_ and arg_62_1.time_ <= var_65_33 + arg_65_0 then
				local var_65_34 = arg_62_1.var_.effecthuiyi1

				if var_65_34 then
					Object.Destroy(var_65_34)

					arg_62_1.var_.effecthuiyi1 = nil
				end
			end

			local var_65_35 = 0

			if var_65_35 < arg_62_1.time_ and arg_62_1.time_ <= var_65_35 + arg_65_0 then
				arg_62_1.allBtn_.enabled = false
			end

			local var_65_36 = 1.96599999815226

			if arg_62_1.time_ >= var_65_35 + var_65_36 and arg_62_1.time_ < var_65_35 + var_65_36 + arg_65_0 then
				arg_62_1.allBtn_.enabled = true
			end

			if arg_62_1.frameCnt_ <= 1 then
				arg_62_1.dialog_:SetActive(false)
			end

			local var_65_37 = 3.6
			local var_65_38 = 1.15

			if var_65_37 < arg_62_1.time_ and arg_62_1.time_ <= var_65_37 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0

				arg_62_1.dialog_:SetActive(true)

				arg_62_1.dialogCg_.alpha = 0

				local var_65_39 = LeanTween.value(arg_62_1.dialog_, 0, 1, 0.3)

				var_65_39:setOnUpdate(LuaHelper.FloatAction(function(arg_66_0)
					arg_62_1.dialogCg_.alpha = arg_66_0
				end))
				var_65_39:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_62_1.dialog_)
					var_65_39:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_62_1.duration_ = arg_62_1.duration_ + 0.3

				SetActive(arg_62_1.leftNameGo_, false)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_62_1.iconTrs_.gameObject, false)
				arg_62_1.callingController_:SetSelectedState("normal")

				local var_65_40 = arg_62_1:GetWordFromCfg(324572015)
				local var_65_41 = arg_62_1:FormatText(var_65_40.content)

				arg_62_1.text_.text = var_65_41

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_42 = 46
				local var_65_43 = utf8.len(var_65_41)
				local var_65_44 = var_65_42 <= 0 and var_65_38 or var_65_38 * (var_65_43 / var_65_42)

				if var_65_44 > 0 and var_65_38 < var_65_44 then
					arg_62_1.talkMaxDuration = var_65_44
					var_65_37 = var_65_37 + 0.3

					if var_65_44 + var_65_37 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_44 + var_65_37
					end
				end

				arg_62_1.text_.text = var_65_41
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)
				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_45 = var_65_37 + 0.3
			local var_65_46 = math.max(var_65_38, arg_62_1.talkMaxDuration)

			if var_65_45 <= arg_62_1.time_ and arg_62_1.time_ < var_65_45 + var_65_46 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - var_65_45) / var_65_46

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= var_65_45 + var_65_46 and arg_62_1.time_ < var_65_45 + var_65_46 + arg_65_0 then
				arg_62_1.typewritter.percent = 1

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(true)
			end
		end

		arg_62_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.1,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_62_1:InitPlayNodeList()
	end,
	Play324572016 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 324572016
		arg_68_1.duration_ = 5

		SetActive(arg_68_1.tipsGo_, false)

		function arg_68_1.onSingleLineFinish_()
			arg_68_1.onSingleLineUpdate_ = nil
			arg_68_1.onSingleLineFinish_ = nil
			arg_68_1.state_ = "waiting"
		end

		function arg_68_1.playNext_(arg_70_0)
			if arg_70_0 == 1 then
				arg_68_0:Play324572017(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = 0
			local var_71_1 = 0.325

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

				local var_71_3 = arg_68_1:GetWordFromCfg(324572016)
				local var_71_4 = arg_68_1:FormatText(var_71_3.content)

				arg_68_1.text_.text = var_71_4

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_5 = 13
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
	Play324572017 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 324572017
		arg_72_1.duration_ = 6.17

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
		end

		function arg_72_1.playNext_(arg_74_0)
			if arg_74_0 == 1 then
				arg_72_0:Play324572018(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			local var_75_0 = 0

			if var_75_0 < arg_72_1.time_ and arg_72_1.time_ <= var_75_0 + arg_75_0 then
				local var_75_1 = manager.ui.mainCamera.transform.localPosition
				local var_75_2 = Vector3.New(0, 0, 10) + Vector3.New(var_75_1.x, var_75_1.y, 0)
				local var_75_3 = arg_72_1.bgs_.H02a

				var_75_3.transform.localPosition = var_75_2
				var_75_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_75_4 = var_75_3:GetComponent("SpriteRenderer")

				if var_75_4 and var_75_4.sprite then
					local var_75_5 = (var_75_3.transform.localPosition - var_75_1).z
					local var_75_6 = manager.ui.mainCameraCom_
					local var_75_7 = 2 * var_75_5 * Mathf.Tan(var_75_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_75_8 = var_75_7 * var_75_6.aspect
					local var_75_9 = var_75_4.sprite.bounds.size.x
					local var_75_10 = var_75_4.sprite.bounds.size.y
					local var_75_11 = var_75_8 / var_75_9
					local var_75_12 = var_75_7 / var_75_10
					local var_75_13 = var_75_12 < var_75_11 and var_75_11 or var_75_12

					var_75_3.transform.localScale = Vector3.New(var_75_13, var_75_13, 0)
				end

				for iter_75_0, iter_75_1 in pairs(arg_72_1.bgs_) do
					if iter_75_0 ~= "H02a" then
						iter_75_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_75_14 = arg_72_1.actors_["10170ui_story"].transform
			local var_75_15 = 1.43333333333333

			if var_75_15 < arg_72_1.time_ and arg_72_1.time_ <= var_75_15 + arg_75_0 then
				arg_72_1.var_.moveOldPos10170ui_story = var_75_14.localPosition

				local var_75_16 = GameObjectTools.GetOrAddComponent(var_75_14.gameObject, typeof(DynamicBoneHelper))

				if var_75_16 then
					var_75_16:EnableDynamicBone(false)
				end
			end

			local var_75_17 = 0.001

			if var_75_15 <= arg_72_1.time_ and arg_72_1.time_ < var_75_15 + var_75_17 then
				local var_75_18 = (arg_72_1.time_ - var_75_15) / var_75_17
				local var_75_19 = Vector3.New(0, -1.03, -6.05)

				var_75_14.localPosition = Vector3.Lerp(arg_72_1.var_.moveOldPos10170ui_story, var_75_19, var_75_18)

				local var_75_20 = manager.ui.mainCamera.transform.position - var_75_14.position

				var_75_14.forward = Vector3.New(var_75_20.x, var_75_20.y, var_75_20.z)

				local var_75_21 = var_75_14.localEulerAngles

				var_75_21.z = 0
				var_75_21.x = 0
				var_75_14.localEulerAngles = var_75_21
			end

			if arg_72_1.time_ >= var_75_15 + var_75_17 and arg_72_1.time_ < var_75_15 + var_75_17 + arg_75_0 then
				var_75_14.localPosition = Vector3.New(0, -1.03, -6.05)

				local var_75_22 = manager.ui.mainCamera.transform.position - var_75_14.position

				var_75_14.forward = Vector3.New(var_75_22.x, var_75_22.y, var_75_22.z)

				local var_75_23 = var_75_14.localEulerAngles

				var_75_23.z = 0
				var_75_23.x = 0
				var_75_14.localEulerAngles = var_75_23

				local var_75_24 = GameObjectTools.GetOrAddComponent(var_75_14.gameObject, typeof(DynamicBoneHelper))

				if var_75_24 then
					var_75_24:EnableDynamicBone(true)
				end
			end

			local var_75_25 = arg_72_1.actors_["10170ui_story"]
			local var_75_26 = 1.43333333333333

			if var_75_26 < arg_72_1.time_ and arg_72_1.time_ <= var_75_26 + arg_75_0 and not isNil(var_75_25) and arg_72_1.var_.characterEffect10170ui_story == nil then
				arg_72_1.var_.characterEffect10170ui_story = var_75_25:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_75_27 = 0.200000002980232

			if var_75_26 <= arg_72_1.time_ and arg_72_1.time_ < var_75_26 + var_75_27 and not isNil(var_75_25) then
				local var_75_28 = (arg_72_1.time_ - var_75_26) / var_75_27

				if arg_72_1.var_.characterEffect10170ui_story and not isNil(var_75_25) then
					arg_72_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_72_1.time_ >= var_75_26 + var_75_27 and arg_72_1.time_ < var_75_26 + var_75_27 + arg_75_0 and not isNil(var_75_25) and arg_72_1.var_.characterEffect10170ui_story then
				arg_72_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			local var_75_29 = 1.43333333333333

			if var_75_29 < arg_72_1.time_ and arg_72_1.time_ <= var_75_29 + arg_75_0 then
				arg_72_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/story10170/story10170action/10170action1_1")
			end

			local var_75_30 = 1.43333333333333

			if var_75_30 < arg_72_1.time_ and arg_72_1.time_ <= var_75_30 + arg_75_0 then
				arg_72_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			local var_75_31 = 0

			if var_75_31 < arg_72_1.time_ and arg_72_1.time_ <= var_75_31 + arg_75_0 then
				arg_72_1.mask_.enabled = true
				arg_72_1.mask_.raycastTarget = false

				arg_72_1:SetGaussion(false)
			end

			local var_75_32 = 2

			if var_75_31 <= arg_72_1.time_ and arg_72_1.time_ < var_75_31 + var_75_32 then
				local var_75_33 = (arg_72_1.time_ - var_75_31) / var_75_32
				local var_75_34 = Color.New(0, 0, 0)

				var_75_34.a = Mathf.Lerp(1, 0, var_75_33)
				arg_72_1.mask_.color = var_75_34
			end

			if arg_72_1.time_ >= var_75_31 + var_75_32 and arg_72_1.time_ < var_75_31 + var_75_32 + arg_75_0 then
				local var_75_35 = Color.New(0, 0, 0)
				local var_75_36 = 0

				arg_72_1.mask_.enabled = false
				var_75_35.a = var_75_36
				arg_72_1.mask_.color = var_75_35
			end

			if arg_72_1.frameCnt_ <= 1 then
				arg_72_1.dialog_:SetActive(false)
			end

			local var_75_37 = 1.83333333333333
			local var_75_38 = 0.5

			if var_75_37 < arg_72_1.time_ and arg_72_1.time_ <= var_75_37 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0

				arg_72_1.dialog_:SetActive(true)

				arg_72_1.dialogCg_.alpha = 0

				local var_75_39 = LeanTween.value(arg_72_1.dialog_, 0, 1, 0.3)

				var_75_39:setOnUpdate(LuaHelper.FloatAction(function(arg_76_0)
					arg_72_1.dialogCg_.alpha = arg_76_0
				end))
				var_75_39:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_72_1.dialog_)
					var_75_39:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_72_1.duration_ = arg_72_1.duration_ + 0.3

				SetActive(arg_72_1.leftNameGo_, true)

				local var_75_40 = arg_72_1:FormatText(StoryNameCfg[1450].name)

				arg_72_1.leftNameTxt_.text = var_75_40

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_41 = arg_72_1:GetWordFromCfg(324572017)
				local var_75_42 = arg_72_1:FormatText(var_75_41.content)

				arg_72_1.text_.text = var_75_42

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_43 = 20
				local var_75_44 = utf8.len(var_75_42)
				local var_75_45 = var_75_43 <= 0 and var_75_38 or var_75_38 * (var_75_44 / var_75_43)

				if var_75_45 > 0 and var_75_38 < var_75_45 then
					arg_72_1.talkMaxDuration = var_75_45
					var_75_37 = var_75_37 + 0.3

					if var_75_45 + var_75_37 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_45 + var_75_37
					end
				end

				arg_72_1.text_.text = var_75_42
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324572", "324572017", "story_v_out_324572.awb") ~= 0 then
					local var_75_46 = manager.audio:GetVoiceLength("story_v_out_324572", "324572017", "story_v_out_324572.awb") / 1000

					if var_75_46 + var_75_37 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_46 + var_75_37
					end

					if var_75_41.prefab_name ~= "" and arg_72_1.actors_[var_75_41.prefab_name] ~= nil then
						local var_75_47 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_41.prefab_name].transform, "story_v_out_324572", "324572017", "story_v_out_324572.awb")

						arg_72_1:RecordAudio("324572017", var_75_47)
						arg_72_1:RecordAudio("324572017", var_75_47)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_out_324572", "324572017", "story_v_out_324572.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_out_324572", "324572017", "story_v_out_324572.awb")
				end

				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_48 = var_75_37 + 0.3
			local var_75_49 = math.max(var_75_38, arg_72_1.talkMaxDuration)

			if var_75_48 <= arg_72_1.time_ and arg_72_1.time_ < var_75_48 + var_75_49 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_48) / var_75_49

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_48 + var_75_49 and arg_72_1.time_ < var_75_48 + var_75_49 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.43333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_72_1:InitPlayNodeList()
	end,
	Play324572018 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 324572018
		arg_78_1.duration_ = 5

		SetActive(arg_78_1.tipsGo_, false)

		function arg_78_1.onSingleLineFinish_()
			arg_78_1.onSingleLineUpdate_ = nil
			arg_78_1.onSingleLineFinish_ = nil
			arg_78_1.state_ = "waiting"
		end

		function arg_78_1.playNext_(arg_80_0)
			if arg_80_0 == 1 then
				arg_78_0:Play324572019(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			local var_81_0 = arg_78_1.actors_["10170ui_story"]
			local var_81_1 = 0

			if var_81_1 < arg_78_1.time_ and arg_78_1.time_ <= var_81_1 + arg_81_0 and not isNil(var_81_0) and arg_78_1.var_.characterEffect10170ui_story == nil then
				arg_78_1.var_.characterEffect10170ui_story = var_81_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_81_2 = 0.200000002980232

			if var_81_1 <= arg_78_1.time_ and arg_78_1.time_ < var_81_1 + var_81_2 and not isNil(var_81_0) then
				local var_81_3 = (arg_78_1.time_ - var_81_1) / var_81_2

				if arg_78_1.var_.characterEffect10170ui_story and not isNil(var_81_0) then
					local var_81_4 = Mathf.Lerp(0, 0.5, var_81_3)

					arg_78_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_78_1.var_.characterEffect10170ui_story.fillRatio = var_81_4
				end
			end

			if arg_78_1.time_ >= var_81_1 + var_81_2 and arg_78_1.time_ < var_81_1 + var_81_2 + arg_81_0 and not isNil(var_81_0) and arg_78_1.var_.characterEffect10170ui_story then
				local var_81_5 = 0.5

				arg_78_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_78_1.var_.characterEffect10170ui_story.fillRatio = var_81_5
			end

			local var_81_6 = 0
			local var_81_7 = 0.25

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

				local var_81_9 = arg_78_1:GetWordFromCfg(324572018)
				local var_81_10 = arg_78_1:FormatText(var_81_9.content)

				arg_78_1.text_.text = var_81_10

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_11 = 10
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
	Play324572019 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 324572019
		arg_82_1.duration_ = 1.67

		SetActive(arg_82_1.tipsGo_, false)

		function arg_82_1.onSingleLineFinish_()
			arg_82_1.onSingleLineUpdate_ = nil
			arg_82_1.onSingleLineFinish_ = nil
			arg_82_1.state_ = "waiting"
		end

		function arg_82_1.playNext_(arg_84_0)
			if arg_84_0 == 1 then
				arg_82_0:Play324572020(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			local var_85_0 = arg_82_1.actors_["10170ui_story"]
			local var_85_1 = 0

			if var_85_1 < arg_82_1.time_ and arg_82_1.time_ <= var_85_1 + arg_85_0 and not isNil(var_85_0) and arg_82_1.var_.characterEffect10170ui_story == nil then
				arg_82_1.var_.characterEffect10170ui_story = var_85_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_85_2 = 0.200000002980232

			if var_85_1 <= arg_82_1.time_ and arg_82_1.time_ < var_85_1 + var_85_2 and not isNil(var_85_0) then
				local var_85_3 = (arg_82_1.time_ - var_85_1) / var_85_2

				if arg_82_1.var_.characterEffect10170ui_story and not isNil(var_85_0) then
					arg_82_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_82_1.time_ >= var_85_1 + var_85_2 and arg_82_1.time_ < var_85_1 + var_85_2 + arg_85_0 and not isNil(var_85_0) and arg_82_1.var_.characterEffect10170ui_story then
				arg_82_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			local var_85_4 = 0
			local var_85_5 = 0.25

			if var_85_4 < arg_82_1.time_ and arg_82_1.time_ <= var_85_4 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, true)

				local var_85_6 = arg_82_1:FormatText(StoryNameCfg[1450].name)

				arg_82_1.leftNameTxt_.text = var_85_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_82_1.leftNameTxt_.transform)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1.leftNameTxt_.text)
				SetActive(arg_82_1.iconTrs_.gameObject, false)
				arg_82_1.callingController_:SetSelectedState("normal")

				local var_85_7 = arg_82_1:GetWordFromCfg(324572019)
				local var_85_8 = arg_82_1:FormatText(var_85_7.content)

				arg_82_1.text_.text = var_85_8

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_9 = 10
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

				if manager.audio:GetVoiceLength("story_v_out_324572", "324572019", "story_v_out_324572.awb") ~= 0 then
					local var_85_12 = manager.audio:GetVoiceLength("story_v_out_324572", "324572019", "story_v_out_324572.awb") / 1000

					if var_85_12 + var_85_4 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_12 + var_85_4
					end

					if var_85_7.prefab_name ~= "" and arg_82_1.actors_[var_85_7.prefab_name] ~= nil then
						local var_85_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_82_1.actors_[var_85_7.prefab_name].transform, "story_v_out_324572", "324572019", "story_v_out_324572.awb")

						arg_82_1:RecordAudio("324572019", var_85_13)
						arg_82_1:RecordAudio("324572019", var_85_13)
					else
						arg_82_1:AudioAction("play", "voice", "story_v_out_324572", "324572019", "story_v_out_324572.awb")
					end

					arg_82_1:RecordHistoryTalkVoice("story_v_out_324572", "324572019", "story_v_out_324572.awb")
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
	Play324572020 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 324572020
		arg_86_1.duration_ = 5

		SetActive(arg_86_1.tipsGo_, false)

		function arg_86_1.onSingleLineFinish_()
			arg_86_1.onSingleLineUpdate_ = nil
			arg_86_1.onSingleLineFinish_ = nil
			arg_86_1.state_ = "waiting"
		end

		function arg_86_1.playNext_(arg_88_0)
			if arg_88_0 == 1 then
				arg_86_0:Play324572021(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			local var_89_0 = arg_86_1.actors_["10170ui_story"]
			local var_89_1 = 0

			if var_89_1 < arg_86_1.time_ and arg_86_1.time_ <= var_89_1 + arg_89_0 and not isNil(var_89_0) and arg_86_1.var_.characterEffect10170ui_story == nil then
				arg_86_1.var_.characterEffect10170ui_story = var_89_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_89_2 = 0.200000002980232

			if var_89_1 <= arg_86_1.time_ and arg_86_1.time_ < var_89_1 + var_89_2 and not isNil(var_89_0) then
				local var_89_3 = (arg_86_1.time_ - var_89_1) / var_89_2

				if arg_86_1.var_.characterEffect10170ui_story and not isNil(var_89_0) then
					local var_89_4 = Mathf.Lerp(0, 0.5, var_89_3)

					arg_86_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_86_1.var_.characterEffect10170ui_story.fillRatio = var_89_4
				end
			end

			if arg_86_1.time_ >= var_89_1 + var_89_2 and arg_86_1.time_ < var_89_1 + var_89_2 + arg_89_0 and not isNil(var_89_0) and arg_86_1.var_.characterEffect10170ui_story then
				local var_89_5 = 0.5

				arg_86_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_86_1.var_.characterEffect10170ui_story.fillRatio = var_89_5
			end

			local var_89_6 = 0
			local var_89_7 = 0.8

			if var_89_6 < arg_86_1.time_ and arg_86_1.time_ <= var_89_6 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, false)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_86_1.iconTrs_.gameObject, false)
				arg_86_1.callingController_:SetSelectedState("normal")

				local var_89_8 = arg_86_1:GetWordFromCfg(324572020)
				local var_89_9 = arg_86_1:FormatText(var_89_8.content)

				arg_86_1.text_.text = var_89_9

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_10 = 32
				local var_89_11 = utf8.len(var_89_9)
				local var_89_12 = var_89_10 <= 0 and var_89_7 or var_89_7 * (var_89_11 / var_89_10)

				if var_89_12 > 0 and var_89_7 < var_89_12 then
					arg_86_1.talkMaxDuration = var_89_12

					if var_89_12 + var_89_6 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_12 + var_89_6
					end
				end

				arg_86_1.text_.text = var_89_9
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)
				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_13 = math.max(var_89_7, arg_86_1.talkMaxDuration)

			if var_89_6 <= arg_86_1.time_ and arg_86_1.time_ < var_89_6 + var_89_13 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_6) / var_89_13

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_6 + var_89_13 and arg_86_1.time_ < var_89_6 + var_89_13 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {}

		arg_86_1:InitPlayNodeList()
	end,
	Play324572021 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 324572021
		arg_90_1.duration_ = 5

		SetActive(arg_90_1.tipsGo_, false)

		function arg_90_1.onSingleLineFinish_()
			arg_90_1.onSingleLineUpdate_ = nil
			arg_90_1.onSingleLineFinish_ = nil
			arg_90_1.state_ = "waiting"
		end

		function arg_90_1.playNext_(arg_92_0)
			if arg_92_0 == 1 then
				arg_90_0:Play324572022(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			local var_93_0 = 0
			local var_93_1 = 0.6

			if var_93_0 < arg_90_1.time_ and arg_90_1.time_ <= var_93_0 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				local var_93_2 = arg_90_1:FormatText(StoryNameCfg[7].name)

				arg_90_1.leftNameTxt_.text = var_93_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, true)
				arg_90_1.iconController_:SetSelectedState("hero")

				arg_90_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_90_1.callingController_:SetSelectedState("normal")

				arg_90_1.keyicon_.color = Color.New(1, 1, 1)
				arg_90_1.icon_.color = Color.New(1, 1, 1)

				local var_93_3 = arg_90_1:GetWordFromCfg(324572021)
				local var_93_4 = arg_90_1:FormatText(var_93_3.content)

				arg_90_1.text_.text = var_93_4

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_5 = 24
				local var_93_6 = utf8.len(var_93_4)
				local var_93_7 = var_93_5 <= 0 and var_93_1 or var_93_1 * (var_93_6 / var_93_5)

				if var_93_7 > 0 and var_93_1 < var_93_7 then
					arg_90_1.talkMaxDuration = var_93_7

					if var_93_7 + var_93_0 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_7 + var_93_0
					end
				end

				arg_90_1.text_.text = var_93_4
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)
				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_8 = math.max(var_93_1, arg_90_1.talkMaxDuration)

			if var_93_0 <= arg_90_1.time_ and arg_90_1.time_ < var_93_0 + var_93_8 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_0) / var_93_8

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_0 + var_93_8 and arg_90_1.time_ < var_93_0 + var_93_8 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {}

		arg_90_1:InitPlayNodeList()
	end,
	Play324572022 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 324572022
		arg_94_1.duration_ = 2

		SetActive(arg_94_1.tipsGo_, false)

		function arg_94_1.onSingleLineFinish_()
			arg_94_1.onSingleLineUpdate_ = nil
			arg_94_1.onSingleLineFinish_ = nil
			arg_94_1.state_ = "waiting"
		end

		function arg_94_1.playNext_(arg_96_0)
			if arg_96_0 == 1 then
				arg_94_0:Play324572023(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			local var_97_0 = arg_94_1.actors_["10170ui_story"]
			local var_97_1 = 0

			if var_97_1 < arg_94_1.time_ and arg_94_1.time_ <= var_97_1 + arg_97_0 and not isNil(var_97_0) and arg_94_1.var_.characterEffect10170ui_story == nil then
				arg_94_1.var_.characterEffect10170ui_story = var_97_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_97_2 = 0.200000002980232

			if var_97_1 <= arg_94_1.time_ and arg_94_1.time_ < var_97_1 + var_97_2 and not isNil(var_97_0) then
				local var_97_3 = (arg_94_1.time_ - var_97_1) / var_97_2

				if arg_94_1.var_.characterEffect10170ui_story and not isNil(var_97_0) then
					arg_94_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_94_1.time_ >= var_97_1 + var_97_2 and arg_94_1.time_ < var_97_1 + var_97_2 + arg_97_0 and not isNil(var_97_0) and arg_94_1.var_.characterEffect10170ui_story then
				arg_94_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			local var_97_4 = 0

			if var_97_4 < arg_94_1.time_ and arg_94_1.time_ <= var_97_4 + arg_97_0 then
				arg_94_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/story10170/story10170action/10170action15_1")
			end

			local var_97_5 = 0

			if var_97_5 < arg_94_1.time_ and arg_94_1.time_ <= var_97_5 + arg_97_0 then
				arg_94_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_97_6 = 0
			local var_97_7 = 0.175

			if var_97_6 < arg_94_1.time_ and arg_94_1.time_ <= var_97_6 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				local var_97_8 = arg_94_1:FormatText(StoryNameCfg[1450].name)

				arg_94_1.leftNameTxt_.text = var_97_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_9 = arg_94_1:GetWordFromCfg(324572022)
				local var_97_10 = arg_94_1:FormatText(var_97_9.content)

				arg_94_1.text_.text = var_97_10

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_11 = 7
				local var_97_12 = utf8.len(var_97_10)
				local var_97_13 = var_97_11 <= 0 and var_97_7 or var_97_7 * (var_97_12 / var_97_11)

				if var_97_13 > 0 and var_97_7 < var_97_13 then
					arg_94_1.talkMaxDuration = var_97_13

					if var_97_13 + var_97_6 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_13 + var_97_6
					end
				end

				arg_94_1.text_.text = var_97_10
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324572", "324572022", "story_v_out_324572.awb") ~= 0 then
					local var_97_14 = manager.audio:GetVoiceLength("story_v_out_324572", "324572022", "story_v_out_324572.awb") / 1000

					if var_97_14 + var_97_6 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_14 + var_97_6
					end

					if var_97_9.prefab_name ~= "" and arg_94_1.actors_[var_97_9.prefab_name] ~= nil then
						local var_97_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_94_1.actors_[var_97_9.prefab_name].transform, "story_v_out_324572", "324572022", "story_v_out_324572.awb")

						arg_94_1:RecordAudio("324572022", var_97_15)
						arg_94_1:RecordAudio("324572022", var_97_15)
					else
						arg_94_1:AudioAction("play", "voice", "story_v_out_324572", "324572022", "story_v_out_324572.awb")
					end

					arg_94_1:RecordHistoryTalkVoice("story_v_out_324572", "324572022", "story_v_out_324572.awb")
				end

				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_16 = math.max(var_97_7, arg_94_1.talkMaxDuration)

			if var_97_6 <= arg_94_1.time_ and arg_94_1.time_ < var_97_6 + var_97_16 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_6) / var_97_16

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_6 + var_97_16 and arg_94_1.time_ < var_97_6 + var_97_16 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {}

		arg_94_1:InitPlayNodeList()
	end,
	Play324572023 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 324572023
		arg_98_1.duration_ = 6.3

		SetActive(arg_98_1.tipsGo_, false)

		function arg_98_1.onSingleLineFinish_()
			arg_98_1.onSingleLineUpdate_ = nil
			arg_98_1.onSingleLineFinish_ = nil
			arg_98_1.state_ = "waiting"
		end

		function arg_98_1.playNext_(arg_100_0)
			if arg_100_0 == 1 then
				arg_98_0:Play324572024(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			local var_101_0 = arg_98_1.actors_["10170ui_story"].transform
			local var_101_1 = 0

			if var_101_1 < arg_98_1.time_ and arg_98_1.time_ <= var_101_1 + arg_101_0 then
				arg_98_1.var_.moveOldPos10170ui_story = var_101_0.localPosition

				local var_101_2 = GameObjectTools.GetOrAddComponent(var_101_0.gameObject, typeof(DynamicBoneHelper))

				if var_101_2 then
					var_101_2:EnableDynamicBone(false)
				end
			end

			local var_101_3 = 0.001

			if var_101_1 <= arg_98_1.time_ and arg_98_1.time_ < var_101_1 + var_101_3 then
				local var_101_4 = (arg_98_1.time_ - var_101_1) / var_101_3
				local var_101_5 = Vector3.New(0, 100, 0)

				var_101_0.localPosition = Vector3.Lerp(arg_98_1.var_.moveOldPos10170ui_story, var_101_5, var_101_4)

				local var_101_6 = manager.ui.mainCamera.transform.position - var_101_0.position

				var_101_0.forward = Vector3.New(var_101_6.x, var_101_6.y, var_101_6.z)

				local var_101_7 = var_101_0.localEulerAngles

				var_101_7.z = 0
				var_101_7.x = 0
				var_101_0.localEulerAngles = var_101_7
			end

			if arg_98_1.time_ >= var_101_1 + var_101_3 and arg_98_1.time_ < var_101_1 + var_101_3 + arg_101_0 then
				var_101_0.localPosition = Vector3.New(0, 100, 0)

				local var_101_8 = manager.ui.mainCamera.transform.position - var_101_0.position

				var_101_0.forward = Vector3.New(var_101_8.x, var_101_8.y, var_101_8.z)

				local var_101_9 = var_101_0.localEulerAngles

				var_101_9.z = 0
				var_101_9.x = 0
				var_101_0.localEulerAngles = var_101_9

				local var_101_10 = GameObjectTools.GetOrAddComponent(var_101_0.gameObject, typeof(DynamicBoneHelper))

				if var_101_10 then
					var_101_10:EnableDynamicBone(true)
				end
			end

			local var_101_11 = arg_98_1.actors_["10170ui_story"]
			local var_101_12 = 0

			if var_101_12 < arg_98_1.time_ and arg_98_1.time_ <= var_101_12 + arg_101_0 and not isNil(var_101_11) and arg_98_1.var_.characterEffect10170ui_story == nil then
				arg_98_1.var_.characterEffect10170ui_story = var_101_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_101_13 = 0.200000002980232

			if var_101_12 <= arg_98_1.time_ and arg_98_1.time_ < var_101_12 + var_101_13 and not isNil(var_101_11) then
				local var_101_14 = (arg_98_1.time_ - var_101_12) / var_101_13

				if arg_98_1.var_.characterEffect10170ui_story and not isNil(var_101_11) then
					local var_101_15 = Mathf.Lerp(0, 0.5, var_101_14)

					arg_98_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_98_1.var_.characterEffect10170ui_story.fillRatio = var_101_15
				end
			end

			if arg_98_1.time_ >= var_101_12 + var_101_13 and arg_98_1.time_ < var_101_12 + var_101_13 + arg_101_0 and not isNil(var_101_11) and arg_98_1.var_.characterEffect10170ui_story then
				local var_101_16 = 0.5

				arg_98_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_98_1.var_.characterEffect10170ui_story.fillRatio = var_101_16
			end

			local var_101_17 = manager.ui.mainCamera.transform
			local var_101_18 = 0

			if var_101_18 < arg_98_1.time_ and arg_98_1.time_ <= var_101_18 + arg_101_0 then
				local var_101_19 = arg_98_1.var_.effect321313
				local var_101_20
				local var_101_21 = var_101_17

				if not var_101_19 then
					var_101_19 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_qiliu2"), var_101_21)
					var_101_19.name = "321313"
					arg_98_1.var_.effect321313 = var_101_19
				else
					var_101_19.transform:SetParent(var_101_21)
				end

				var_101_19.transform.localPosition = Vector3.New(0, 0, 0)
				var_101_19.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_101_22 = 1.7777777777777777
				local var_101_23 = Screen.width / Screen.height
				local var_101_24 = var_101_23 / var_101_22
				local var_101_25 = Mathf.Max(var_101_22 / var_101_23, 1)

				var_101_19.transform.localScale = Vector3.New(var_101_19.transform.localScale.x * var_101_24, var_101_19.transform.localScale.y * var_101_25, var_101_19.transform.localScale.z)
			end

			local var_101_26 = manager.ui.mainCamera.transform
			local var_101_27 = 0.733333333333333

			if var_101_27 < arg_98_1.time_ and arg_98_1.time_ <= var_101_27 + arg_101_0 then
				local var_101_28 = arg_98_1.var_.effect321313

				if var_101_28 then
					Object.Destroy(var_101_28)

					arg_98_1.var_.effect321313 = nil
				end
			end

			local var_101_29 = 0.533333333333333

			if var_101_29 < arg_98_1.time_ and arg_98_1.time_ <= var_101_29 + arg_101_0 then
				arg_98_1.mask_.enabled = true
				arg_98_1.mask_.raycastTarget = false

				arg_98_1:SetGaussion(false)
			end

			local var_101_30 = 0.766666666666667

			if var_101_29 <= arg_98_1.time_ and arg_98_1.time_ < var_101_29 + var_101_30 then
				local var_101_31 = (arg_98_1.time_ - var_101_29) / var_101_30
				local var_101_32 = Color.New(1, 1, 1)

				var_101_32.a = Mathf.Lerp(1, 0, var_101_31)
				arg_98_1.mask_.color = var_101_32
			end

			if arg_98_1.time_ >= var_101_29 + var_101_30 and arg_98_1.time_ < var_101_29 + var_101_30 + arg_101_0 then
				local var_101_33 = Color.New(1, 1, 1)
				local var_101_34 = 0

				arg_98_1.mask_.enabled = false
				var_101_33.a = var_101_34
				arg_98_1.mask_.color = var_101_33
			end

			local var_101_35 = 0

			if var_101_35 < arg_98_1.time_ and arg_98_1.time_ <= var_101_35 + arg_101_0 then
				arg_98_1.allBtn_.enabled = false
			end

			local var_101_36 = 1.5

			if arg_98_1.time_ >= var_101_35 + var_101_36 and arg_98_1.time_ < var_101_35 + var_101_36 + arg_101_0 then
				arg_98_1.allBtn_.enabled = true
			end

			local var_101_37 = 1.03333333333333
			local var_101_38 = 1

			if var_101_37 < arg_98_1.time_ and arg_98_1.time_ <= var_101_37 + arg_101_0 then
				local var_101_39 = "play"
				local var_101_40 = "effect"

				arg_98_1:AudioAction(var_101_39, var_101_40, "se_story_150", "se_story_150_sword10", "")
			end

			if arg_98_1.frameCnt_ <= 1 then
				arg_98_1.dialog_:SetActive(false)
			end

			local var_101_41 = 1.3
			local var_101_42 = 1.55

			if var_101_41 < arg_98_1.time_ and arg_98_1.time_ <= var_101_41 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0

				arg_98_1.dialog_:SetActive(true)

				arg_98_1.dialogCg_.alpha = 0

				local var_101_43 = LeanTween.value(arg_98_1.dialog_, 0, 1, 0.3)

				var_101_43:setOnUpdate(LuaHelper.FloatAction(function(arg_102_0)
					arg_98_1.dialogCg_.alpha = arg_102_0
				end))
				var_101_43:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_98_1.dialog_)
					var_101_43:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_98_1.duration_ = arg_98_1.duration_ + 0.3

				SetActive(arg_98_1.leftNameGo_, false)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_44 = arg_98_1:GetWordFromCfg(324572023)
				local var_101_45 = arg_98_1:FormatText(var_101_44.content)

				arg_98_1.text_.text = var_101_45

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_46 = 62
				local var_101_47 = utf8.len(var_101_45)
				local var_101_48 = var_101_46 <= 0 and var_101_42 or var_101_42 * (var_101_47 / var_101_46)

				if var_101_48 > 0 and var_101_42 < var_101_48 then
					arg_98_1.talkMaxDuration = var_101_48
					var_101_41 = var_101_41 + 0.3

					if var_101_48 + var_101_41 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_48 + var_101_41
					end
				end

				arg_98_1.text_.text = var_101_45
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)
				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_49 = var_101_41 + 0.3
			local var_101_50 = math.max(var_101_42, arg_98_1.talkMaxDuration)

			if var_101_49 <= arg_98_1.time_ and arg_98_1.time_ < var_101_49 + var_101_50 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_49) / var_101_50

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_49 + var_101_50 and arg_98_1.time_ < var_101_49 + var_101_50 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {
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

		arg_98_1:InitPlayNodeList()
	end,
	Play324572024 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 324572024
		arg_104_1.duration_ = 5

		SetActive(arg_104_1.tipsGo_, false)

		function arg_104_1.onSingleLineFinish_()
			arg_104_1.onSingleLineUpdate_ = nil
			arg_104_1.onSingleLineFinish_ = nil
			arg_104_1.state_ = "waiting"
		end

		function arg_104_1.playNext_(arg_106_0)
			if arg_106_0 == 1 then
				arg_104_0:Play324572025(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			local var_107_0 = 0
			local var_107_1 = 0.725

			if var_107_0 < arg_104_1.time_ and arg_104_1.time_ <= var_107_0 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, false)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_2 = arg_104_1:GetWordFromCfg(324572024)
				local var_107_3 = arg_104_1:FormatText(var_107_2.content)

				arg_104_1.text_.text = var_107_3

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_4 = 29
				local var_107_5 = utf8.len(var_107_3)
				local var_107_6 = var_107_4 <= 0 and var_107_1 or var_107_1 * (var_107_5 / var_107_4)

				if var_107_6 > 0 and var_107_1 < var_107_6 then
					arg_104_1.talkMaxDuration = var_107_6

					if var_107_6 + var_107_0 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_6 + var_107_0
					end
				end

				arg_104_1.text_.text = var_107_3
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)
				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_7 = math.max(var_107_1, arg_104_1.talkMaxDuration)

			if var_107_0 <= arg_104_1.time_ and arg_104_1.time_ < var_107_0 + var_107_7 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_0) / var_107_7

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_0 + var_107_7 and arg_104_1.time_ < var_107_0 + var_107_7 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {}

		arg_104_1:InitPlayNodeList()
	end,
	Play324572025 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 324572025
		arg_108_1.duration_ = 5

		SetActive(arg_108_1.tipsGo_, false)

		function arg_108_1.onSingleLineFinish_()
			arg_108_1.onSingleLineUpdate_ = nil
			arg_108_1.onSingleLineFinish_ = nil
			arg_108_1.state_ = "waiting"
		end

		function arg_108_1.playNext_(arg_110_0)
			if arg_110_0 == 1 then
				arg_108_0:Play324572026(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			local var_111_0 = 0
			local var_111_1 = 0.275

			if var_111_0 < arg_108_1.time_ and arg_108_1.time_ <= var_111_0 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				local var_111_2 = arg_108_1:FormatText(StoryNameCfg[7].name)

				arg_108_1.leftNameTxt_.text = var_111_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, true)
				arg_108_1.iconController_:SetSelectedState("hero")

				arg_108_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_108_1.callingController_:SetSelectedState("normal")

				arg_108_1.keyicon_.color = Color.New(1, 1, 1)
				arg_108_1.icon_.color = Color.New(1, 1, 1)

				local var_111_3 = arg_108_1:GetWordFromCfg(324572025)
				local var_111_4 = arg_108_1:FormatText(var_111_3.content)

				arg_108_1.text_.text = var_111_4

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_5 = 11
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
				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_8 = math.max(var_111_1, arg_108_1.talkMaxDuration)

			if var_111_0 <= arg_108_1.time_ and arg_108_1.time_ < var_111_0 + var_111_8 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_0) / var_111_8

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_0 + var_111_8 and arg_108_1.time_ < var_111_0 + var_111_8 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {}

		arg_108_1:InitPlayNodeList()
	end,
	Play324572026 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 324572026
		arg_112_1.duration_ = 6.6

		SetActive(arg_112_1.tipsGo_, false)

		function arg_112_1.onSingleLineFinish_()
			arg_112_1.onSingleLineUpdate_ = nil
			arg_112_1.onSingleLineFinish_ = nil
			arg_112_1.state_ = "waiting"
		end

		function arg_112_1.playNext_(arg_114_0)
			if arg_114_0 == 1 then
				arg_112_0:Play324572027(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			local var_115_0 = arg_112_1.actors_["10170ui_story"].transform
			local var_115_1 = 0

			if var_115_1 < arg_112_1.time_ and arg_112_1.time_ <= var_115_1 + arg_115_0 then
				arg_112_1.var_.moveOldPos10170ui_story = var_115_0.localPosition

				local var_115_2 = GameObjectTools.GetOrAddComponent(var_115_0.gameObject, typeof(DynamicBoneHelper))

				if var_115_2 then
					var_115_2:EnableDynamicBone(false)
				end
			end

			local var_115_3 = 0.001

			if var_115_1 <= arg_112_1.time_ and arg_112_1.time_ < var_115_1 + var_115_3 then
				local var_115_4 = (arg_112_1.time_ - var_115_1) / var_115_3
				local var_115_5 = Vector3.New(0, -1.03, -6.05)

				var_115_0.localPosition = Vector3.Lerp(arg_112_1.var_.moveOldPos10170ui_story, var_115_5, var_115_4)

				local var_115_6 = manager.ui.mainCamera.transform.position - var_115_0.position

				var_115_0.forward = Vector3.New(var_115_6.x, var_115_6.y, var_115_6.z)

				local var_115_7 = var_115_0.localEulerAngles

				var_115_7.z = 0
				var_115_7.x = 0
				var_115_0.localEulerAngles = var_115_7
			end

			if arg_112_1.time_ >= var_115_1 + var_115_3 and arg_112_1.time_ < var_115_1 + var_115_3 + arg_115_0 then
				var_115_0.localPosition = Vector3.New(0, -1.03, -6.05)

				local var_115_8 = manager.ui.mainCamera.transform.position - var_115_0.position

				var_115_0.forward = Vector3.New(var_115_8.x, var_115_8.y, var_115_8.z)

				local var_115_9 = var_115_0.localEulerAngles

				var_115_9.z = 0
				var_115_9.x = 0
				var_115_0.localEulerAngles = var_115_9

				local var_115_10 = GameObjectTools.GetOrAddComponent(var_115_0.gameObject, typeof(DynamicBoneHelper))

				if var_115_10 then
					var_115_10:EnableDynamicBone(true)
				end
			end

			local var_115_11 = arg_112_1.actors_["10170ui_story"]
			local var_115_12 = 0

			if var_115_12 < arg_112_1.time_ and arg_112_1.time_ <= var_115_12 + arg_115_0 and not isNil(var_115_11) and arg_112_1.var_.characterEffect10170ui_story == nil then
				arg_112_1.var_.characterEffect10170ui_story = var_115_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_115_13 = 0.200000002980232

			if var_115_12 <= arg_112_1.time_ and arg_112_1.time_ < var_115_12 + var_115_13 and not isNil(var_115_11) then
				local var_115_14 = (arg_112_1.time_ - var_115_12) / var_115_13

				if arg_112_1.var_.characterEffect10170ui_story and not isNil(var_115_11) then
					arg_112_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_112_1.time_ >= var_115_12 + var_115_13 and arg_112_1.time_ < var_115_12 + var_115_13 + arg_115_0 and not isNil(var_115_11) and arg_112_1.var_.characterEffect10170ui_story then
				arg_112_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			local var_115_15 = 0

			if var_115_15 < arg_112_1.time_ and arg_112_1.time_ <= var_115_15 + arg_115_0 then
				arg_112_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/story10170/story10170actionlink/10170action4152")
			end

			local var_115_16 = 0

			if var_115_16 < arg_112_1.time_ and arg_112_1.time_ <= var_115_16 + arg_115_0 then
				arg_112_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_115_17 = 0
			local var_115_18 = 0.7

			if var_115_17 < arg_112_1.time_ and arg_112_1.time_ <= var_115_17 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				local var_115_19 = arg_112_1:FormatText(StoryNameCfg[1450].name)

				arg_112_1.leftNameTxt_.text = var_115_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, false)
				arg_112_1.callingController_:SetSelectedState("normal")

				local var_115_20 = arg_112_1:GetWordFromCfg(324572026)
				local var_115_21 = arg_112_1:FormatText(var_115_20.content)

				arg_112_1.text_.text = var_115_21

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_22 = 28
				local var_115_23 = utf8.len(var_115_21)
				local var_115_24 = var_115_22 <= 0 and var_115_18 or var_115_18 * (var_115_23 / var_115_22)

				if var_115_24 > 0 and var_115_18 < var_115_24 then
					arg_112_1.talkMaxDuration = var_115_24

					if var_115_24 + var_115_17 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_24 + var_115_17
					end
				end

				arg_112_1.text_.text = var_115_21
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324572", "324572026", "story_v_out_324572.awb") ~= 0 then
					local var_115_25 = manager.audio:GetVoiceLength("story_v_out_324572", "324572026", "story_v_out_324572.awb") / 1000

					if var_115_25 + var_115_17 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_25 + var_115_17
					end

					if var_115_20.prefab_name ~= "" and arg_112_1.actors_[var_115_20.prefab_name] ~= nil then
						local var_115_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_112_1.actors_[var_115_20.prefab_name].transform, "story_v_out_324572", "324572026", "story_v_out_324572.awb")

						arg_112_1:RecordAudio("324572026", var_115_26)
						arg_112_1:RecordAudio("324572026", var_115_26)
					else
						arg_112_1:AudioAction("play", "voice", "story_v_out_324572", "324572026", "story_v_out_324572.awb")
					end

					arg_112_1:RecordHistoryTalkVoice("story_v_out_324572", "324572026", "story_v_out_324572.awb")
				end

				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_27 = math.max(var_115_18, arg_112_1.talkMaxDuration)

			if var_115_17 <= arg_112_1.time_ and arg_112_1.time_ < var_115_17 + var_115_27 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_17) / var_115_27

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_17 + var_115_27 and arg_112_1.time_ < var_115_17 + var_115_27 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {
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

		arg_112_1:InitPlayNodeList()
	end,
	Play324572027 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 324572027
		arg_116_1.duration_ = 5

		SetActive(arg_116_1.tipsGo_, false)

		function arg_116_1.onSingleLineFinish_()
			arg_116_1.onSingleLineUpdate_ = nil
			arg_116_1.onSingleLineFinish_ = nil
			arg_116_1.state_ = "waiting"
		end

		function arg_116_1.playNext_(arg_118_0)
			if arg_118_0 == 1 then
				arg_116_0:Play324572028(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			local var_119_0 = arg_116_1.actors_["10170ui_story"]
			local var_119_1 = 0

			if var_119_1 < arg_116_1.time_ and arg_116_1.time_ <= var_119_1 + arg_119_0 and not isNil(var_119_0) and arg_116_1.var_.characterEffect10170ui_story == nil then
				arg_116_1.var_.characterEffect10170ui_story = var_119_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_119_2 = 0.200000002980232

			if var_119_1 <= arg_116_1.time_ and arg_116_1.time_ < var_119_1 + var_119_2 and not isNil(var_119_0) then
				local var_119_3 = (arg_116_1.time_ - var_119_1) / var_119_2

				if arg_116_1.var_.characterEffect10170ui_story and not isNil(var_119_0) then
					local var_119_4 = Mathf.Lerp(0, 0.5, var_119_3)

					arg_116_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_116_1.var_.characterEffect10170ui_story.fillRatio = var_119_4
				end
			end

			if arg_116_1.time_ >= var_119_1 + var_119_2 and arg_116_1.time_ < var_119_1 + var_119_2 + arg_119_0 and not isNil(var_119_0) and arg_116_1.var_.characterEffect10170ui_story then
				local var_119_5 = 0.5

				arg_116_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_116_1.var_.characterEffect10170ui_story.fillRatio = var_119_5
			end

			local var_119_6 = 0
			local var_119_7 = 0.175

			if var_119_6 < arg_116_1.time_ and arg_116_1.time_ <= var_119_6 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, true)

				local var_119_8 = arg_116_1:FormatText(StoryNameCfg[7].name)

				arg_116_1.leftNameTxt_.text = var_119_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, true)
				arg_116_1.iconController_:SetSelectedState("hero")

				arg_116_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_116_1.callingController_:SetSelectedState("normal")

				arg_116_1.keyicon_.color = Color.New(1, 1, 1)
				arg_116_1.icon_.color = Color.New(1, 1, 1)

				local var_119_9 = arg_116_1:GetWordFromCfg(324572027)
				local var_119_10 = arg_116_1:FormatText(var_119_9.content)

				arg_116_1.text_.text = var_119_10

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_11 = 7
				local var_119_12 = utf8.len(var_119_10)
				local var_119_13 = var_119_11 <= 0 and var_119_7 or var_119_7 * (var_119_12 / var_119_11)

				if var_119_13 > 0 and var_119_7 < var_119_13 then
					arg_116_1.talkMaxDuration = var_119_13

					if var_119_13 + var_119_6 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_13 + var_119_6
					end
				end

				arg_116_1.text_.text = var_119_10
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)
				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_14 = math.max(var_119_7, arg_116_1.talkMaxDuration)

			if var_119_6 <= arg_116_1.time_ and arg_116_1.time_ < var_119_6 + var_119_14 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_6) / var_119_14

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_6 + var_119_14 and arg_116_1.time_ < var_119_6 + var_119_14 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {}

		arg_116_1:InitPlayNodeList()
	end,
	Play324572028 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 324572028
		arg_120_1.duration_ = 9.73

		SetActive(arg_120_1.tipsGo_, false)

		function arg_120_1.onSingleLineFinish_()
			arg_120_1.onSingleLineUpdate_ = nil
			arg_120_1.onSingleLineFinish_ = nil
			arg_120_1.state_ = "waiting"
		end

		function arg_120_1.playNext_(arg_122_0)
			if arg_122_0 == 1 then
				arg_120_0:Play324572029(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			local var_123_0 = arg_120_1.actors_["10170ui_story"]
			local var_123_1 = 0

			if var_123_1 < arg_120_1.time_ and arg_120_1.time_ <= var_123_1 + arg_123_0 and not isNil(var_123_0) and arg_120_1.var_.characterEffect10170ui_story == nil then
				arg_120_1.var_.characterEffect10170ui_story = var_123_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_123_2 = 0.200000002980232

			if var_123_1 <= arg_120_1.time_ and arg_120_1.time_ < var_123_1 + var_123_2 and not isNil(var_123_0) then
				local var_123_3 = (arg_120_1.time_ - var_123_1) / var_123_2

				if arg_120_1.var_.characterEffect10170ui_story and not isNil(var_123_0) then
					arg_120_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_120_1.time_ >= var_123_1 + var_123_2 and arg_120_1.time_ < var_123_1 + var_123_2 + arg_123_0 and not isNil(var_123_0) and arg_120_1.var_.characterEffect10170ui_story then
				arg_120_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			local var_123_4 = 0
			local var_123_5 = 0.85

			if var_123_4 < arg_120_1.time_ and arg_120_1.time_ <= var_123_4 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				local var_123_6 = arg_120_1:FormatText(StoryNameCfg[1450].name)

				arg_120_1.leftNameTxt_.text = var_123_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, false)
				arg_120_1.callingController_:SetSelectedState("normal")

				local var_123_7 = arg_120_1:GetWordFromCfg(324572028)
				local var_123_8 = arg_120_1:FormatText(var_123_7.content)

				arg_120_1.text_.text = var_123_8

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_9 = 34
				local var_123_10 = utf8.len(var_123_8)
				local var_123_11 = var_123_9 <= 0 and var_123_5 or var_123_5 * (var_123_10 / var_123_9)

				if var_123_11 > 0 and var_123_5 < var_123_11 then
					arg_120_1.talkMaxDuration = var_123_11

					if var_123_11 + var_123_4 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_11 + var_123_4
					end
				end

				arg_120_1.text_.text = var_123_8
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324572", "324572028", "story_v_out_324572.awb") ~= 0 then
					local var_123_12 = manager.audio:GetVoiceLength("story_v_out_324572", "324572028", "story_v_out_324572.awb") / 1000

					if var_123_12 + var_123_4 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_12 + var_123_4
					end

					if var_123_7.prefab_name ~= "" and arg_120_1.actors_[var_123_7.prefab_name] ~= nil then
						local var_123_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_120_1.actors_[var_123_7.prefab_name].transform, "story_v_out_324572", "324572028", "story_v_out_324572.awb")

						arg_120_1:RecordAudio("324572028", var_123_13)
						arg_120_1:RecordAudio("324572028", var_123_13)
					else
						arg_120_1:AudioAction("play", "voice", "story_v_out_324572", "324572028", "story_v_out_324572.awb")
					end

					arg_120_1:RecordHistoryTalkVoice("story_v_out_324572", "324572028", "story_v_out_324572.awb")
				end

				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_14 = math.max(var_123_5, arg_120_1.talkMaxDuration)

			if var_123_4 <= arg_120_1.time_ and arg_120_1.time_ < var_123_4 + var_123_14 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_4) / var_123_14

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_4 + var_123_14 and arg_120_1.time_ < var_123_4 + var_123_14 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {}

		arg_120_1:InitPlayNodeList()
	end,
	Play324572029 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 324572029
		arg_124_1.duration_ = 5

		SetActive(arg_124_1.tipsGo_, false)

		function arg_124_1.onSingleLineFinish_()
			arg_124_1.onSingleLineUpdate_ = nil
			arg_124_1.onSingleLineFinish_ = nil
			arg_124_1.state_ = "waiting"
		end

		function arg_124_1.playNext_(arg_126_0)
			if arg_126_0 == 1 then
				arg_124_0:Play324572030(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			local var_127_0 = arg_124_1.actors_["10170ui_story"]
			local var_127_1 = 0

			if var_127_1 < arg_124_1.time_ and arg_124_1.time_ <= var_127_1 + arg_127_0 and not isNil(var_127_0) and arg_124_1.var_.characterEffect10170ui_story == nil then
				arg_124_1.var_.characterEffect10170ui_story = var_127_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_127_2 = 0.200000002980232

			if var_127_1 <= arg_124_1.time_ and arg_124_1.time_ < var_127_1 + var_127_2 and not isNil(var_127_0) then
				local var_127_3 = (arg_124_1.time_ - var_127_1) / var_127_2

				if arg_124_1.var_.characterEffect10170ui_story and not isNil(var_127_0) then
					local var_127_4 = Mathf.Lerp(0, 0.5, var_127_3)

					arg_124_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_124_1.var_.characterEffect10170ui_story.fillRatio = var_127_4
				end
			end

			if arg_124_1.time_ >= var_127_1 + var_127_2 and arg_124_1.time_ < var_127_1 + var_127_2 + arg_127_0 and not isNil(var_127_0) and arg_124_1.var_.characterEffect10170ui_story then
				local var_127_5 = 0.5

				arg_124_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_124_1.var_.characterEffect10170ui_story.fillRatio = var_127_5
			end

			local var_127_6 = 0
			local var_127_7 = 1.025

			if var_127_6 < arg_124_1.time_ and arg_124_1.time_ <= var_127_6 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, false)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_8 = arg_124_1:GetWordFromCfg(324572029)
				local var_127_9 = arg_124_1:FormatText(var_127_8.content)

				arg_124_1.text_.text = var_127_9

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_10 = 41
				local var_127_11 = utf8.len(var_127_9)
				local var_127_12 = var_127_10 <= 0 and var_127_7 or var_127_7 * (var_127_11 / var_127_10)

				if var_127_12 > 0 and var_127_7 < var_127_12 then
					arg_124_1.talkMaxDuration = var_127_12

					if var_127_12 + var_127_6 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_12 + var_127_6
					end
				end

				arg_124_1.text_.text = var_127_9
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)
				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_13 = math.max(var_127_7, arg_124_1.talkMaxDuration)

			if var_127_6 <= arg_124_1.time_ and arg_124_1.time_ < var_127_6 + var_127_13 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_6) / var_127_13

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_6 + var_127_13 and arg_124_1.time_ < var_127_6 + var_127_13 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {}

		arg_124_1:InitPlayNodeList()
	end,
	Play324572030 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 324572030
		arg_128_1.duration_ = 6.13

		SetActive(arg_128_1.tipsGo_, false)

		function arg_128_1.onSingleLineFinish_()
			arg_128_1.onSingleLineUpdate_ = nil
			arg_128_1.onSingleLineFinish_ = nil
			arg_128_1.state_ = "waiting"
		end

		function arg_128_1.playNext_(arg_130_0)
			if arg_130_0 == 1 then
				arg_128_0:Play324572031(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			local var_131_0 = arg_128_1.actors_["10170ui_story"]
			local var_131_1 = 0

			if var_131_1 < arg_128_1.time_ and arg_128_1.time_ <= var_131_1 + arg_131_0 and not isNil(var_131_0) and arg_128_1.var_.characterEffect10170ui_story == nil then
				arg_128_1.var_.characterEffect10170ui_story = var_131_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_131_2 = 0.200000002980232

			if var_131_1 <= arg_128_1.time_ and arg_128_1.time_ < var_131_1 + var_131_2 and not isNil(var_131_0) then
				local var_131_3 = (arg_128_1.time_ - var_131_1) / var_131_2

				if arg_128_1.var_.characterEffect10170ui_story and not isNil(var_131_0) then
					arg_128_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_128_1.time_ >= var_131_1 + var_131_2 and arg_128_1.time_ < var_131_1 + var_131_2 + arg_131_0 and not isNil(var_131_0) and arg_128_1.var_.characterEffect10170ui_story then
				arg_128_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			local var_131_4 = 0

			if var_131_4 < arg_128_1.time_ and arg_128_1.time_ <= var_131_4 + arg_131_0 then
				arg_128_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/story10170/story10170action/10170action2_2")
			end

			local var_131_5 = 0

			if var_131_5 < arg_128_1.time_ and arg_128_1.time_ <= var_131_5 + arg_131_0 then
				arg_128_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_131_6 = 0
			local var_131_7 = 0.65

			if var_131_6 < arg_128_1.time_ and arg_128_1.time_ <= var_131_6 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				local var_131_8 = arg_128_1:FormatText(StoryNameCfg[1450].name)

				arg_128_1.leftNameTxt_.text = var_131_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_9 = arg_128_1:GetWordFromCfg(324572030)
				local var_131_10 = arg_128_1:FormatText(var_131_9.content)

				arg_128_1.text_.text = var_131_10

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_11 = 26
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

				if manager.audio:GetVoiceLength("story_v_out_324572", "324572030", "story_v_out_324572.awb") ~= 0 then
					local var_131_14 = manager.audio:GetVoiceLength("story_v_out_324572", "324572030", "story_v_out_324572.awb") / 1000

					if var_131_14 + var_131_6 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_14 + var_131_6
					end

					if var_131_9.prefab_name ~= "" and arg_128_1.actors_[var_131_9.prefab_name] ~= nil then
						local var_131_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_128_1.actors_[var_131_9.prefab_name].transform, "story_v_out_324572", "324572030", "story_v_out_324572.awb")

						arg_128_1:RecordAudio("324572030", var_131_15)
						arg_128_1:RecordAudio("324572030", var_131_15)
					else
						arg_128_1:AudioAction("play", "voice", "story_v_out_324572", "324572030", "story_v_out_324572.awb")
					end

					arg_128_1:RecordHistoryTalkVoice("story_v_out_324572", "324572030", "story_v_out_324572.awb")
				end

				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_16 = math.max(var_131_7, arg_128_1.talkMaxDuration)

			if var_131_6 <= arg_128_1.time_ and arg_128_1.time_ < var_131_6 + var_131_16 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_6) / var_131_16

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_6 + var_131_16 and arg_128_1.time_ < var_131_6 + var_131_16 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {}

		arg_128_1:InitPlayNodeList()
	end,
	Play324572031 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 324572031
		arg_132_1.duration_ = 5

		SetActive(arg_132_1.tipsGo_, false)

		function arg_132_1.onSingleLineFinish_()
			arg_132_1.onSingleLineUpdate_ = nil
			arg_132_1.onSingleLineFinish_ = nil
			arg_132_1.state_ = "waiting"
		end

		function arg_132_1.playNext_(arg_134_0)
			if arg_134_0 == 1 then
				arg_132_0:Play324572032(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			local var_135_0 = arg_132_1.actors_["10170ui_story"]
			local var_135_1 = 0

			if var_135_1 < arg_132_1.time_ and arg_132_1.time_ <= var_135_1 + arg_135_0 and not isNil(var_135_0) and arg_132_1.var_.characterEffect10170ui_story == nil then
				arg_132_1.var_.characterEffect10170ui_story = var_135_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_135_2 = 0.200000002980232

			if var_135_1 <= arg_132_1.time_ and arg_132_1.time_ < var_135_1 + var_135_2 and not isNil(var_135_0) then
				local var_135_3 = (arg_132_1.time_ - var_135_1) / var_135_2

				if arg_132_1.var_.characterEffect10170ui_story and not isNil(var_135_0) then
					local var_135_4 = Mathf.Lerp(0, 0.5, var_135_3)

					arg_132_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_132_1.var_.characterEffect10170ui_story.fillRatio = var_135_4
				end
			end

			if arg_132_1.time_ >= var_135_1 + var_135_2 and arg_132_1.time_ < var_135_1 + var_135_2 + arg_135_0 and not isNil(var_135_0) and arg_132_1.var_.characterEffect10170ui_story then
				local var_135_5 = 0.5

				arg_132_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_132_1.var_.characterEffect10170ui_story.fillRatio = var_135_5
			end

			local var_135_6 = 0
			local var_135_7 = 0.35

			if var_135_6 < arg_132_1.time_ and arg_132_1.time_ <= var_135_6 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, true)

				local var_135_8 = arg_132_1:FormatText(StoryNameCfg[7].name)

				arg_132_1.leftNameTxt_.text = var_135_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, true)
				arg_132_1.iconController_:SetSelectedState("hero")

				arg_132_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_132_1.callingController_:SetSelectedState("normal")

				arg_132_1.keyicon_.color = Color.New(1, 1, 1)
				arg_132_1.icon_.color = Color.New(1, 1, 1)

				local var_135_9 = arg_132_1:GetWordFromCfg(324572031)
				local var_135_10 = arg_132_1:FormatText(var_135_9.content)

				arg_132_1.text_.text = var_135_10

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_11 = 14
				local var_135_12 = utf8.len(var_135_10)
				local var_135_13 = var_135_11 <= 0 and var_135_7 or var_135_7 * (var_135_12 / var_135_11)

				if var_135_13 > 0 and var_135_7 < var_135_13 then
					arg_132_1.talkMaxDuration = var_135_13

					if var_135_13 + var_135_6 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_13 + var_135_6
					end
				end

				arg_132_1.text_.text = var_135_10
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)
				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_14 = math.max(var_135_7, arg_132_1.talkMaxDuration)

			if var_135_6 <= arg_132_1.time_ and arg_132_1.time_ < var_135_6 + var_135_14 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_6) / var_135_14

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_6 + var_135_14 and arg_132_1.time_ < var_135_6 + var_135_14 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {}

		arg_132_1:InitPlayNodeList()
	end,
	Play324572032 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 324572032
		arg_136_1.duration_ = 1.27

		SetActive(arg_136_1.tipsGo_, false)

		function arg_136_1.onSingleLineFinish_()
			arg_136_1.onSingleLineUpdate_ = nil
			arg_136_1.onSingleLineFinish_ = nil
			arg_136_1.state_ = "waiting"
		end

		function arg_136_1.playNext_(arg_138_0)
			if arg_138_0 == 1 then
				arg_136_0:Play324572033(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			local var_139_0 = arg_136_1.actors_["10170ui_story"]
			local var_139_1 = 0

			if var_139_1 < arg_136_1.time_ and arg_136_1.time_ <= var_139_1 + arg_139_0 and not isNil(var_139_0) and arg_136_1.var_.characterEffect10170ui_story == nil then
				arg_136_1.var_.characterEffect10170ui_story = var_139_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_139_2 = 0.200000002980232

			if var_139_1 <= arg_136_1.time_ and arg_136_1.time_ < var_139_1 + var_139_2 and not isNil(var_139_0) then
				local var_139_3 = (arg_136_1.time_ - var_139_1) / var_139_2

				if arg_136_1.var_.characterEffect10170ui_story and not isNil(var_139_0) then
					arg_136_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_136_1.time_ >= var_139_1 + var_139_2 and arg_136_1.time_ < var_139_1 + var_139_2 + arg_139_0 and not isNil(var_139_0) and arg_136_1.var_.characterEffect10170ui_story then
				arg_136_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			local var_139_4 = 0
			local var_139_5 = 0.125

			if var_139_4 < arg_136_1.time_ and arg_136_1.time_ <= var_139_4 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, true)

				local var_139_6 = arg_136_1:FormatText(StoryNameCfg[1450].name)

				arg_136_1.leftNameTxt_.text = var_139_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_136_1.leftNameTxt_.transform)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1.leftNameTxt_.text)
				SetActive(arg_136_1.iconTrs_.gameObject, false)
				arg_136_1.callingController_:SetSelectedState("normal")

				local var_139_7 = arg_136_1:GetWordFromCfg(324572032)
				local var_139_8 = arg_136_1:FormatText(var_139_7.content)

				arg_136_1.text_.text = var_139_8

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_9 = 5
				local var_139_10 = utf8.len(var_139_8)
				local var_139_11 = var_139_9 <= 0 and var_139_5 or var_139_5 * (var_139_10 / var_139_9)

				if var_139_11 > 0 and var_139_5 < var_139_11 then
					arg_136_1.talkMaxDuration = var_139_11

					if var_139_11 + var_139_4 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_11 + var_139_4
					end
				end

				arg_136_1.text_.text = var_139_8
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324572", "324572032", "story_v_out_324572.awb") ~= 0 then
					local var_139_12 = manager.audio:GetVoiceLength("story_v_out_324572", "324572032", "story_v_out_324572.awb") / 1000

					if var_139_12 + var_139_4 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_12 + var_139_4
					end

					if var_139_7.prefab_name ~= "" and arg_136_1.actors_[var_139_7.prefab_name] ~= nil then
						local var_139_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_136_1.actors_[var_139_7.prefab_name].transform, "story_v_out_324572", "324572032", "story_v_out_324572.awb")

						arg_136_1:RecordAudio("324572032", var_139_13)
						arg_136_1:RecordAudio("324572032", var_139_13)
					else
						arg_136_1:AudioAction("play", "voice", "story_v_out_324572", "324572032", "story_v_out_324572.awb")
					end

					arg_136_1:RecordHistoryTalkVoice("story_v_out_324572", "324572032", "story_v_out_324572.awb")
				end

				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_14 = math.max(var_139_5, arg_136_1.talkMaxDuration)

			if var_139_4 <= arg_136_1.time_ and arg_136_1.time_ < var_139_4 + var_139_14 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_4) / var_139_14

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_4 + var_139_14 and arg_136_1.time_ < var_139_4 + var_139_14 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {}

		arg_136_1:InitPlayNodeList()
	end,
	Play324572033 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 324572033
		arg_140_1.duration_ = 5

		SetActive(arg_140_1.tipsGo_, false)

		function arg_140_1.onSingleLineFinish_()
			arg_140_1.onSingleLineUpdate_ = nil
			arg_140_1.onSingleLineFinish_ = nil
			arg_140_1.state_ = "waiting"
		end

		function arg_140_1.playNext_(arg_142_0)
			if arg_142_0 == 1 then
				arg_140_0:Play324572034(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			local var_143_0 = arg_140_1.actors_["10170ui_story"]
			local var_143_1 = 0

			if var_143_1 < arg_140_1.time_ and arg_140_1.time_ <= var_143_1 + arg_143_0 and not isNil(var_143_0) and arg_140_1.var_.characterEffect10170ui_story == nil then
				arg_140_1.var_.characterEffect10170ui_story = var_143_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_143_2 = 0.200000002980232

			if var_143_1 <= arg_140_1.time_ and arg_140_1.time_ < var_143_1 + var_143_2 and not isNil(var_143_0) then
				local var_143_3 = (arg_140_1.time_ - var_143_1) / var_143_2

				if arg_140_1.var_.characterEffect10170ui_story and not isNil(var_143_0) then
					local var_143_4 = Mathf.Lerp(0, 0.5, var_143_3)

					arg_140_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_140_1.var_.characterEffect10170ui_story.fillRatio = var_143_4
				end
			end

			if arg_140_1.time_ >= var_143_1 + var_143_2 and arg_140_1.time_ < var_143_1 + var_143_2 + arg_143_0 and not isNil(var_143_0) and arg_140_1.var_.characterEffect10170ui_story then
				local var_143_5 = 0.5

				arg_140_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_140_1.var_.characterEffect10170ui_story.fillRatio = var_143_5
			end

			local var_143_6 = 0
			local var_143_7 = 0.45

			if var_143_6 < arg_140_1.time_ and arg_140_1.time_ <= var_143_6 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, true)

				local var_143_8 = arg_140_1:FormatText(StoryNameCfg[7].name)

				arg_140_1.leftNameTxt_.text = var_143_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_140_1.leftNameTxt_.transform)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1.leftNameTxt_.text)
				SetActive(arg_140_1.iconTrs_.gameObject, true)
				arg_140_1.iconController_:SetSelectedState("hero")

				arg_140_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_140_1.callingController_:SetSelectedState("normal")

				arg_140_1.keyicon_.color = Color.New(1, 1, 1)
				arg_140_1.icon_.color = Color.New(1, 1, 1)

				local var_143_9 = arg_140_1:GetWordFromCfg(324572033)
				local var_143_10 = arg_140_1:FormatText(var_143_9.content)

				arg_140_1.text_.text = var_143_10

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_11 = 18
				local var_143_12 = utf8.len(var_143_10)
				local var_143_13 = var_143_11 <= 0 and var_143_7 or var_143_7 * (var_143_12 / var_143_11)

				if var_143_13 > 0 and var_143_7 < var_143_13 then
					arg_140_1.talkMaxDuration = var_143_13

					if var_143_13 + var_143_6 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_13 + var_143_6
					end
				end

				arg_140_1.text_.text = var_143_10
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)
				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_14 = math.max(var_143_7, arg_140_1.talkMaxDuration)

			if var_143_6 <= arg_140_1.time_ and arg_140_1.time_ < var_143_6 + var_143_14 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_6) / var_143_14

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_6 + var_143_14 and arg_140_1.time_ < var_143_6 + var_143_14 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {}

		arg_140_1:InitPlayNodeList()
	end,
	Play324572034 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 324572034
		arg_144_1.duration_ = 5

		SetActive(arg_144_1.tipsGo_, false)

		function arg_144_1.onSingleLineFinish_()
			arg_144_1.onSingleLineUpdate_ = nil
			arg_144_1.onSingleLineFinish_ = nil
			arg_144_1.state_ = "waiting"
		end

		function arg_144_1.playNext_(arg_146_0)
			if arg_146_0 == 1 then
				arg_144_0:Play324572035(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			local var_147_0 = 0.5
			local var_147_1 = 1

			if var_147_0 < arg_144_1.time_ and arg_144_1.time_ <= var_147_0 + arg_147_0 then
				local var_147_2 = "play"
				local var_147_3 = "effect"

				arg_144_1:AudioAction(var_147_2, var_147_3, "se_story_150", "se_story_150_sand", "")
			end

			local var_147_4 = 0
			local var_147_5 = 0.575

			if var_147_4 < arg_144_1.time_ and arg_144_1.time_ <= var_147_4 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, false)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_144_1.iconTrs_.gameObject, false)
				arg_144_1.callingController_:SetSelectedState("normal")

				local var_147_6 = arg_144_1:GetWordFromCfg(324572034)
				local var_147_7 = arg_144_1:FormatText(var_147_6.content)

				arg_144_1.text_.text = var_147_7

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_8 = 23
				local var_147_9 = utf8.len(var_147_7)
				local var_147_10 = var_147_8 <= 0 and var_147_5 or var_147_5 * (var_147_9 / var_147_8)

				if var_147_10 > 0 and var_147_5 < var_147_10 then
					arg_144_1.talkMaxDuration = var_147_10

					if var_147_10 + var_147_4 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_10 + var_147_4
					end
				end

				arg_144_1.text_.text = var_147_7
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)
				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_11 = math.max(var_147_5, arg_144_1.talkMaxDuration)

			if var_147_4 <= arg_144_1.time_ and arg_144_1.time_ < var_147_4 + var_147_11 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - var_147_4) / var_147_11

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= var_147_4 + var_147_11 and arg_144_1.time_ < var_147_4 + var_147_11 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {}

		arg_144_1:InitPlayNodeList()
	end,
	Play324572035 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 324572035
		arg_148_1.duration_ = 6.97

		SetActive(arg_148_1.tipsGo_, false)

		function arg_148_1.onSingleLineFinish_()
			arg_148_1.onSingleLineUpdate_ = nil
			arg_148_1.onSingleLineFinish_ = nil
			arg_148_1.state_ = "waiting"
		end

		function arg_148_1.playNext_(arg_150_0)
			if arg_150_0 == 1 then
				arg_148_0:Play324572036(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			local var_151_0 = arg_148_1.actors_["10170ui_story"]
			local var_151_1 = 0

			if var_151_1 < arg_148_1.time_ and arg_148_1.time_ <= var_151_1 + arg_151_0 and not isNil(var_151_0) and arg_148_1.var_.characterEffect10170ui_story == nil then
				arg_148_1.var_.characterEffect10170ui_story = var_151_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_151_2 = 0.200000002980232

			if var_151_1 <= arg_148_1.time_ and arg_148_1.time_ < var_151_1 + var_151_2 and not isNil(var_151_0) then
				local var_151_3 = (arg_148_1.time_ - var_151_1) / var_151_2

				if arg_148_1.var_.characterEffect10170ui_story and not isNil(var_151_0) then
					arg_148_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_148_1.time_ >= var_151_1 + var_151_2 and arg_148_1.time_ < var_151_1 + var_151_2 + arg_151_0 and not isNil(var_151_0) and arg_148_1.var_.characterEffect10170ui_story then
				arg_148_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			local var_151_4 = 0

			if var_151_4 < arg_148_1.time_ and arg_148_1.time_ <= var_151_4 + arg_151_0 then
				arg_148_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/story10170/story10170action/10170action1_1")
			end

			local var_151_5 = 0

			if var_151_5 < arg_148_1.time_ and arg_148_1.time_ <= var_151_5 + arg_151_0 then
				arg_148_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			local var_151_6 = 0
			local var_151_7 = 0.725

			if var_151_6 < arg_148_1.time_ and arg_148_1.time_ <= var_151_6 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, true)

				local var_151_8 = arg_148_1:FormatText(StoryNameCfg[1450].name)

				arg_148_1.leftNameTxt_.text = var_151_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_148_1.leftNameTxt_.transform)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1.leftNameTxt_.text)
				SetActive(arg_148_1.iconTrs_.gameObject, false)
				arg_148_1.callingController_:SetSelectedState("normal")

				local var_151_9 = arg_148_1:GetWordFromCfg(324572035)
				local var_151_10 = arg_148_1:FormatText(var_151_9.content)

				arg_148_1.text_.text = var_151_10

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_11 = 29
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

				if manager.audio:GetVoiceLength("story_v_out_324572", "324572035", "story_v_out_324572.awb") ~= 0 then
					local var_151_14 = manager.audio:GetVoiceLength("story_v_out_324572", "324572035", "story_v_out_324572.awb") / 1000

					if var_151_14 + var_151_6 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_14 + var_151_6
					end

					if var_151_9.prefab_name ~= "" and arg_148_1.actors_[var_151_9.prefab_name] ~= nil then
						local var_151_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_148_1.actors_[var_151_9.prefab_name].transform, "story_v_out_324572", "324572035", "story_v_out_324572.awb")

						arg_148_1:RecordAudio("324572035", var_151_15)
						arg_148_1:RecordAudio("324572035", var_151_15)
					else
						arg_148_1:AudioAction("play", "voice", "story_v_out_324572", "324572035", "story_v_out_324572.awb")
					end

					arg_148_1:RecordHistoryTalkVoice("story_v_out_324572", "324572035", "story_v_out_324572.awb")
				end

				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_16 = math.max(var_151_7, arg_148_1.talkMaxDuration)

			if var_151_6 <= arg_148_1.time_ and arg_148_1.time_ < var_151_6 + var_151_16 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - var_151_6) / var_151_16

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= var_151_6 + var_151_16 and arg_148_1.time_ < var_151_6 + var_151_16 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {}

		arg_148_1:InitPlayNodeList()
	end,
	Play324572036 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 324572036
		arg_152_1.duration_ = 5

		SetActive(arg_152_1.tipsGo_, false)

		function arg_152_1.onSingleLineFinish_()
			arg_152_1.onSingleLineUpdate_ = nil
			arg_152_1.onSingleLineFinish_ = nil
			arg_152_1.state_ = "waiting"
		end

		function arg_152_1.playNext_(arg_154_0)
			if arg_154_0 == 1 then
				arg_152_0:Play324572037(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			local var_155_0 = arg_152_1.actors_["10170ui_story"]
			local var_155_1 = 0

			if var_155_1 < arg_152_1.time_ and arg_152_1.time_ <= var_155_1 + arg_155_0 and not isNil(var_155_0) and arg_152_1.var_.characterEffect10170ui_story == nil then
				arg_152_1.var_.characterEffect10170ui_story = var_155_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_155_2 = 0.200000002980232

			if var_155_1 <= arg_152_1.time_ and arg_152_1.time_ < var_155_1 + var_155_2 and not isNil(var_155_0) then
				local var_155_3 = (arg_152_1.time_ - var_155_1) / var_155_2

				if arg_152_1.var_.characterEffect10170ui_story and not isNil(var_155_0) then
					local var_155_4 = Mathf.Lerp(0, 0.5, var_155_3)

					arg_152_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_152_1.var_.characterEffect10170ui_story.fillRatio = var_155_4
				end
			end

			if arg_152_1.time_ >= var_155_1 + var_155_2 and arg_152_1.time_ < var_155_1 + var_155_2 + arg_155_0 and not isNil(var_155_0) and arg_152_1.var_.characterEffect10170ui_story then
				local var_155_5 = 0.5

				arg_152_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_152_1.var_.characterEffect10170ui_story.fillRatio = var_155_5
			end

			local var_155_6 = 0
			local var_155_7 = 1.2

			if var_155_6 < arg_152_1.time_ and arg_152_1.time_ <= var_155_6 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, true)

				local var_155_8 = arg_152_1:FormatText(StoryNameCfg[7].name)

				arg_152_1.leftNameTxt_.text = var_155_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_152_1.leftNameTxt_.transform)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1.leftNameTxt_.text)
				SetActive(arg_152_1.iconTrs_.gameObject, true)
				arg_152_1.iconController_:SetSelectedState("hero")

				arg_152_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_152_1.callingController_:SetSelectedState("normal")

				arg_152_1.keyicon_.color = Color.New(1, 1, 1)
				arg_152_1.icon_.color = Color.New(1, 1, 1)

				local var_155_9 = arg_152_1:GetWordFromCfg(324572036)
				local var_155_10 = arg_152_1:FormatText(var_155_9.content)

				arg_152_1.text_.text = var_155_10

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_11 = 48
				local var_155_12 = utf8.len(var_155_10)
				local var_155_13 = var_155_11 <= 0 and var_155_7 or var_155_7 * (var_155_12 / var_155_11)

				if var_155_13 > 0 and var_155_7 < var_155_13 then
					arg_152_1.talkMaxDuration = var_155_13

					if var_155_13 + var_155_6 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_13 + var_155_6
					end
				end

				arg_152_1.text_.text = var_155_10
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)
				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_14 = math.max(var_155_7, arg_152_1.talkMaxDuration)

			if var_155_6 <= arg_152_1.time_ and arg_152_1.time_ < var_155_6 + var_155_14 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - var_155_6) / var_155_14

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= var_155_6 + var_155_14 and arg_152_1.time_ < var_155_6 + var_155_14 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {}

		arg_152_1:InitPlayNodeList()
	end,
	Play324572037 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 324572037
		arg_156_1.duration_ = 1.93

		SetActive(arg_156_1.tipsGo_, false)

		function arg_156_1.onSingleLineFinish_()
			arg_156_1.onSingleLineUpdate_ = nil
			arg_156_1.onSingleLineFinish_ = nil
			arg_156_1.state_ = "waiting"
		end

		function arg_156_1.playNext_(arg_158_0)
			if arg_158_0 == 1 then
				arg_156_0:Play324572038(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			local var_159_0 = arg_156_1.actors_["10170ui_story"]
			local var_159_1 = 0

			if var_159_1 < arg_156_1.time_ and arg_156_1.time_ <= var_159_1 + arg_159_0 and not isNil(var_159_0) and arg_156_1.var_.characterEffect10170ui_story == nil then
				arg_156_1.var_.characterEffect10170ui_story = var_159_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_159_2 = 0.200000002980232

			if var_159_1 <= arg_156_1.time_ and arg_156_1.time_ < var_159_1 + var_159_2 and not isNil(var_159_0) then
				local var_159_3 = (arg_156_1.time_ - var_159_1) / var_159_2

				if arg_156_1.var_.characterEffect10170ui_story and not isNil(var_159_0) then
					arg_156_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_156_1.time_ >= var_159_1 + var_159_2 and arg_156_1.time_ < var_159_1 + var_159_2 + arg_159_0 and not isNil(var_159_0) and arg_156_1.var_.characterEffect10170ui_story then
				arg_156_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			local var_159_4 = 0
			local var_159_5 = 0.225

			if var_159_4 < arg_156_1.time_ and arg_156_1.time_ <= var_159_4 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, true)

				local var_159_6 = arg_156_1:FormatText(StoryNameCfg[1450].name)

				arg_156_1.leftNameTxt_.text = var_159_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_156_1.leftNameTxt_.transform)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1.leftNameTxt_.text)
				SetActive(arg_156_1.iconTrs_.gameObject, false)
				arg_156_1.callingController_:SetSelectedState("normal")

				local var_159_7 = arg_156_1:GetWordFromCfg(324572037)
				local var_159_8 = arg_156_1:FormatText(var_159_7.content)

				arg_156_1.text_.text = var_159_8

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_9 = 9
				local var_159_10 = utf8.len(var_159_8)
				local var_159_11 = var_159_9 <= 0 and var_159_5 or var_159_5 * (var_159_10 / var_159_9)

				if var_159_11 > 0 and var_159_5 < var_159_11 then
					arg_156_1.talkMaxDuration = var_159_11

					if var_159_11 + var_159_4 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_11 + var_159_4
					end
				end

				arg_156_1.text_.text = var_159_8
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324572", "324572037", "story_v_out_324572.awb") ~= 0 then
					local var_159_12 = manager.audio:GetVoiceLength("story_v_out_324572", "324572037", "story_v_out_324572.awb") / 1000

					if var_159_12 + var_159_4 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_12 + var_159_4
					end

					if var_159_7.prefab_name ~= "" and arg_156_1.actors_[var_159_7.prefab_name] ~= nil then
						local var_159_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_156_1.actors_[var_159_7.prefab_name].transform, "story_v_out_324572", "324572037", "story_v_out_324572.awb")

						arg_156_1:RecordAudio("324572037", var_159_13)
						arg_156_1:RecordAudio("324572037", var_159_13)
					else
						arg_156_1:AudioAction("play", "voice", "story_v_out_324572", "324572037", "story_v_out_324572.awb")
					end

					arg_156_1:RecordHistoryTalkVoice("story_v_out_324572", "324572037", "story_v_out_324572.awb")
				end

				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_14 = math.max(var_159_5, arg_156_1.talkMaxDuration)

			if var_159_4 <= arg_156_1.time_ and arg_156_1.time_ < var_159_4 + var_159_14 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - var_159_4) / var_159_14

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= var_159_4 + var_159_14 and arg_156_1.time_ < var_159_4 + var_159_14 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {}

		arg_156_1:InitPlayNodeList()
	end,
	Play324572038 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 324572038
		arg_160_1.duration_ = 5

		SetActive(arg_160_1.tipsGo_, false)

		function arg_160_1.onSingleLineFinish_()
			arg_160_1.onSingleLineUpdate_ = nil
			arg_160_1.onSingleLineFinish_ = nil
			arg_160_1.state_ = "waiting"
		end

		function arg_160_1.playNext_(arg_162_0)
			if arg_162_0 == 1 then
				arg_160_0:Play324572039(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			local var_163_0 = arg_160_1.actors_["10170ui_story"]
			local var_163_1 = 0

			if var_163_1 < arg_160_1.time_ and arg_160_1.time_ <= var_163_1 + arg_163_0 and not isNil(var_163_0) and arg_160_1.var_.characterEffect10170ui_story == nil then
				arg_160_1.var_.characterEffect10170ui_story = var_163_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_163_2 = 0.200000002980232

			if var_163_1 <= arg_160_1.time_ and arg_160_1.time_ < var_163_1 + var_163_2 and not isNil(var_163_0) then
				local var_163_3 = (arg_160_1.time_ - var_163_1) / var_163_2

				if arg_160_1.var_.characterEffect10170ui_story and not isNil(var_163_0) then
					local var_163_4 = Mathf.Lerp(0, 0.5, var_163_3)

					arg_160_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_160_1.var_.characterEffect10170ui_story.fillRatio = var_163_4
				end
			end

			if arg_160_1.time_ >= var_163_1 + var_163_2 and arg_160_1.time_ < var_163_1 + var_163_2 + arg_163_0 and not isNil(var_163_0) and arg_160_1.var_.characterEffect10170ui_story then
				local var_163_5 = 0.5

				arg_160_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_160_1.var_.characterEffect10170ui_story.fillRatio = var_163_5
			end

			local var_163_6 = 0
			local var_163_7 = 0.125

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

				local var_163_9 = arg_160_1:GetWordFromCfg(324572038)
				local var_163_10 = arg_160_1:FormatText(var_163_9.content)

				arg_160_1.text_.text = var_163_10

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_11 = 5
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
	Play324572039 = function(arg_164_0, arg_164_1)
		arg_164_1.time_ = 0
		arg_164_1.frameCnt_ = 0
		arg_164_1.state_ = "playing"
		arg_164_1.curTalkId_ = 324572039
		arg_164_1.duration_ = 7

		SetActive(arg_164_1.tipsGo_, false)

		function arg_164_1.onSingleLineFinish_()
			arg_164_1.onSingleLineUpdate_ = nil
			arg_164_1.onSingleLineFinish_ = nil
			arg_164_1.state_ = "waiting"
		end

		function arg_164_1.playNext_(arg_166_0)
			if arg_166_0 == 1 then
				arg_164_0:Play324572040(arg_164_1)
			end
		end

		function arg_164_1.onSingleLineUpdate_(arg_167_0)
			local var_167_0 = arg_164_1.actors_["10170ui_story"]
			local var_167_1 = 0

			if var_167_1 < arg_164_1.time_ and arg_164_1.time_ <= var_167_1 + arg_167_0 and not isNil(var_167_0) and arg_164_1.var_.characterEffect10170ui_story == nil then
				arg_164_1.var_.characterEffect10170ui_story = var_167_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_167_2 = 0.200000002980232

			if var_167_1 <= arg_164_1.time_ and arg_164_1.time_ < var_167_1 + var_167_2 and not isNil(var_167_0) then
				local var_167_3 = (arg_164_1.time_ - var_167_1) / var_167_2

				if arg_164_1.var_.characterEffect10170ui_story and not isNil(var_167_0) then
					arg_164_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_164_1.time_ >= var_167_1 + var_167_2 and arg_164_1.time_ < var_167_1 + var_167_2 + arg_167_0 and not isNil(var_167_0) and arg_164_1.var_.characterEffect10170ui_story then
				arg_164_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			local var_167_4 = 0

			if var_167_4 < arg_164_1.time_ and arg_164_1.time_ <= var_167_4 + arg_167_0 then
				arg_164_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/story10170/story10170action/10170action27_1")
			end

			local var_167_5 = 0

			if var_167_5 < arg_164_1.time_ and arg_164_1.time_ <= var_167_5 + arg_167_0 then
				arg_164_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_167_6 = 0
			local var_167_7 = 0.775

			if var_167_6 < arg_164_1.time_ and arg_164_1.time_ <= var_167_6 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0
				arg_164_1.dialogCg_.alpha = 1

				arg_164_1.dialog_:SetActive(true)
				SetActive(arg_164_1.leftNameGo_, true)

				local var_167_8 = arg_164_1:FormatText(StoryNameCfg[1450].name)

				arg_164_1.leftNameTxt_.text = var_167_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_164_1.leftNameTxt_.transform)

				arg_164_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_164_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_164_1:RecordName(arg_164_1.leftNameTxt_.text)
				SetActive(arg_164_1.iconTrs_.gameObject, false)
				arg_164_1.callingController_:SetSelectedState("normal")

				local var_167_9 = arg_164_1:GetWordFromCfg(324572039)
				local var_167_10 = arg_164_1:FormatText(var_167_9.content)

				arg_164_1.text_.text = var_167_10

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_11 = 31
				local var_167_12 = utf8.len(var_167_10)
				local var_167_13 = var_167_11 <= 0 and var_167_7 or var_167_7 * (var_167_12 / var_167_11)

				if var_167_13 > 0 and var_167_7 < var_167_13 then
					arg_164_1.talkMaxDuration = var_167_13

					if var_167_13 + var_167_6 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_13 + var_167_6
					end
				end

				arg_164_1.text_.text = var_167_10
				arg_164_1.typewritter.percent = 0

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324572", "324572039", "story_v_out_324572.awb") ~= 0 then
					local var_167_14 = manager.audio:GetVoiceLength("story_v_out_324572", "324572039", "story_v_out_324572.awb") / 1000

					if var_167_14 + var_167_6 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_14 + var_167_6
					end

					if var_167_9.prefab_name ~= "" and arg_164_1.actors_[var_167_9.prefab_name] ~= nil then
						local var_167_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_164_1.actors_[var_167_9.prefab_name].transform, "story_v_out_324572", "324572039", "story_v_out_324572.awb")

						arg_164_1:RecordAudio("324572039", var_167_15)
						arg_164_1:RecordAudio("324572039", var_167_15)
					else
						arg_164_1:AudioAction("play", "voice", "story_v_out_324572", "324572039", "story_v_out_324572.awb")
					end

					arg_164_1:RecordHistoryTalkVoice("story_v_out_324572", "324572039", "story_v_out_324572.awb")
				end

				arg_164_1:RecordContent(arg_164_1.text_.text)
			end

			local var_167_16 = math.max(var_167_7, arg_164_1.talkMaxDuration)

			if var_167_6 <= arg_164_1.time_ and arg_164_1.time_ < var_167_6 + var_167_16 then
				arg_164_1.typewritter.percent = (arg_164_1.time_ - var_167_6) / var_167_16

				arg_164_1.typewritter:SetDirty()
			end

			if arg_164_1.time_ >= var_167_6 + var_167_16 and arg_164_1.time_ < var_167_6 + var_167_16 + arg_167_0 then
				arg_164_1.typewritter.percent = 1

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(true)
			end
		end

		arg_164_1.nodeConfigList_ = {}

		arg_164_1:InitPlayNodeList()
	end,
	Play324572040 = function(arg_168_0, arg_168_1)
		arg_168_1.time_ = 0
		arg_168_1.frameCnt_ = 0
		arg_168_1.state_ = "playing"
		arg_168_1.curTalkId_ = 324572040
		arg_168_1.duration_ = 5

		SetActive(arg_168_1.tipsGo_, false)

		function arg_168_1.onSingleLineFinish_()
			arg_168_1.onSingleLineUpdate_ = nil
			arg_168_1.onSingleLineFinish_ = nil
			arg_168_1.state_ = "waiting"
		end

		function arg_168_1.playNext_(arg_170_0)
			if arg_170_0 == 1 then
				arg_168_0:Play324572041(arg_168_1)
			end
		end

		function arg_168_1.onSingleLineUpdate_(arg_171_0)
			local var_171_0 = arg_168_1.actors_["10170ui_story"]
			local var_171_1 = 0

			if var_171_1 < arg_168_1.time_ and arg_168_1.time_ <= var_171_1 + arg_171_0 and not isNil(var_171_0) and arg_168_1.var_.characterEffect10170ui_story == nil then
				arg_168_1.var_.characterEffect10170ui_story = var_171_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_171_2 = 0.200000002980232

			if var_171_1 <= arg_168_1.time_ and arg_168_1.time_ < var_171_1 + var_171_2 and not isNil(var_171_0) then
				local var_171_3 = (arg_168_1.time_ - var_171_1) / var_171_2

				if arg_168_1.var_.characterEffect10170ui_story and not isNil(var_171_0) then
					local var_171_4 = Mathf.Lerp(0, 0.5, var_171_3)

					arg_168_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_168_1.var_.characterEffect10170ui_story.fillRatio = var_171_4
				end
			end

			if arg_168_1.time_ >= var_171_1 + var_171_2 and arg_168_1.time_ < var_171_1 + var_171_2 + arg_171_0 and not isNil(var_171_0) and arg_168_1.var_.characterEffect10170ui_story then
				local var_171_5 = 0.5

				arg_168_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_168_1.var_.characterEffect10170ui_story.fillRatio = var_171_5
			end

			local var_171_6 = 0
			local var_171_7 = 0.95

			if var_171_6 < arg_168_1.time_ and arg_168_1.time_ <= var_171_6 + arg_171_0 then
				arg_168_1.talkMaxDuration = 0
				arg_168_1.dialogCg_.alpha = 1

				arg_168_1.dialog_:SetActive(true)
				SetActive(arg_168_1.leftNameGo_, true)

				local var_171_8 = arg_168_1:FormatText(StoryNameCfg[7].name)

				arg_168_1.leftNameTxt_.text = var_171_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_168_1.leftNameTxt_.transform)

				arg_168_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_168_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_168_1:RecordName(arg_168_1.leftNameTxt_.text)
				SetActive(arg_168_1.iconTrs_.gameObject, true)
				arg_168_1.iconController_:SetSelectedState("hero")

				arg_168_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_168_1.callingController_:SetSelectedState("normal")

				arg_168_1.keyicon_.color = Color.New(1, 1, 1)
				arg_168_1.icon_.color = Color.New(1, 1, 1)

				local var_171_9 = arg_168_1:GetWordFromCfg(324572040)
				local var_171_10 = arg_168_1:FormatText(var_171_9.content)

				arg_168_1.text_.text = var_171_10

				LuaForUtil.ClearLinePrefixSymbol(arg_168_1.text_)

				local var_171_11 = 38
				local var_171_12 = utf8.len(var_171_10)
				local var_171_13 = var_171_11 <= 0 and var_171_7 or var_171_7 * (var_171_12 / var_171_11)

				if var_171_13 > 0 and var_171_7 < var_171_13 then
					arg_168_1.talkMaxDuration = var_171_13

					if var_171_13 + var_171_6 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_13 + var_171_6
					end
				end

				arg_168_1.text_.text = var_171_10
				arg_168_1.typewritter.percent = 0

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(false)
				arg_168_1:RecordContent(arg_168_1.text_.text)
			end

			local var_171_14 = math.max(var_171_7, arg_168_1.talkMaxDuration)

			if var_171_6 <= arg_168_1.time_ and arg_168_1.time_ < var_171_6 + var_171_14 then
				arg_168_1.typewritter.percent = (arg_168_1.time_ - var_171_6) / var_171_14

				arg_168_1.typewritter:SetDirty()
			end

			if arg_168_1.time_ >= var_171_6 + var_171_14 and arg_168_1.time_ < var_171_6 + var_171_14 + arg_171_0 then
				arg_168_1.typewritter.percent = 1

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(true)
			end
		end

		arg_168_1.nodeConfigList_ = {}

		arg_168_1:InitPlayNodeList()
	end,
	Play324572041 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 324572041
		arg_172_1.duration_ = 6.07

		SetActive(arg_172_1.tipsGo_, false)

		function arg_172_1.onSingleLineFinish_()
			arg_172_1.onSingleLineUpdate_ = nil
			arg_172_1.onSingleLineFinish_ = nil
			arg_172_1.state_ = "waiting"
		end

		function arg_172_1.playNext_(arg_174_0)
			if arg_174_0 == 1 then
				arg_172_0:Play324572042(arg_172_1)
			end
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			local var_175_0 = arg_172_1.actors_["10170ui_story"]
			local var_175_1 = 0

			if var_175_1 < arg_172_1.time_ and arg_172_1.time_ <= var_175_1 + arg_175_0 and not isNil(var_175_0) and arg_172_1.var_.characterEffect10170ui_story == nil then
				arg_172_1.var_.characterEffect10170ui_story = var_175_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_175_2 = 0.200000002980232

			if var_175_1 <= arg_172_1.time_ and arg_172_1.time_ < var_175_1 + var_175_2 and not isNil(var_175_0) then
				local var_175_3 = (arg_172_1.time_ - var_175_1) / var_175_2

				if arg_172_1.var_.characterEffect10170ui_story and not isNil(var_175_0) then
					arg_172_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_172_1.time_ >= var_175_1 + var_175_2 and arg_172_1.time_ < var_175_1 + var_175_2 + arg_175_0 and not isNil(var_175_0) and arg_172_1.var_.characterEffect10170ui_story then
				arg_172_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			local var_175_4 = 0
			local var_175_5 = 0.675

			if var_175_4 < arg_172_1.time_ and arg_172_1.time_ <= var_175_4 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0
				arg_172_1.dialogCg_.alpha = 1

				arg_172_1.dialog_:SetActive(true)
				SetActive(arg_172_1.leftNameGo_, true)

				local var_175_6 = arg_172_1:FormatText(StoryNameCfg[1450].name)

				arg_172_1.leftNameTxt_.text = var_175_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_172_1.leftNameTxt_.transform)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1.leftNameTxt_.text)
				SetActive(arg_172_1.iconTrs_.gameObject, false)
				arg_172_1.callingController_:SetSelectedState("normal")

				local var_175_7 = arg_172_1:GetWordFromCfg(324572041)
				local var_175_8 = arg_172_1:FormatText(var_175_7.content)

				arg_172_1.text_.text = var_175_8

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_9 = 27
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

				if manager.audio:GetVoiceLength("story_v_out_324572", "324572041", "story_v_out_324572.awb") ~= 0 then
					local var_175_12 = manager.audio:GetVoiceLength("story_v_out_324572", "324572041", "story_v_out_324572.awb") / 1000

					if var_175_12 + var_175_4 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_12 + var_175_4
					end

					if var_175_7.prefab_name ~= "" and arg_172_1.actors_[var_175_7.prefab_name] ~= nil then
						local var_175_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_172_1.actors_[var_175_7.prefab_name].transform, "story_v_out_324572", "324572041", "story_v_out_324572.awb")

						arg_172_1:RecordAudio("324572041", var_175_13)
						arg_172_1:RecordAudio("324572041", var_175_13)
					else
						arg_172_1:AudioAction("play", "voice", "story_v_out_324572", "324572041", "story_v_out_324572.awb")
					end

					arg_172_1:RecordHistoryTalkVoice("story_v_out_324572", "324572041", "story_v_out_324572.awb")
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
	Play324572042 = function(arg_176_0, arg_176_1)
		arg_176_1.time_ = 0
		arg_176_1.frameCnt_ = 0
		arg_176_1.state_ = "playing"
		arg_176_1.curTalkId_ = 324572042
		arg_176_1.duration_ = 4.53

		SetActive(arg_176_1.tipsGo_, false)

		function arg_176_1.onSingleLineFinish_()
			arg_176_1.onSingleLineUpdate_ = nil
			arg_176_1.onSingleLineFinish_ = nil
			arg_176_1.state_ = "waiting"
		end

		function arg_176_1.playNext_(arg_178_0)
			if arg_178_0 == 1 then
				arg_176_0:Play324572043(arg_176_1)
			end
		end

		function arg_176_1.onSingleLineUpdate_(arg_179_0)
			local var_179_0 = 0
			local var_179_1 = 0.55

			if var_179_0 < arg_176_1.time_ and arg_176_1.time_ <= var_179_0 + arg_179_0 then
				arg_176_1.talkMaxDuration = 0
				arg_176_1.dialogCg_.alpha = 1

				arg_176_1.dialog_:SetActive(true)
				SetActive(arg_176_1.leftNameGo_, true)

				local var_179_2 = arg_176_1:FormatText(StoryNameCfg[1450].name)

				arg_176_1.leftNameTxt_.text = var_179_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_176_1.leftNameTxt_.transform)

				arg_176_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_176_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_176_1:RecordName(arg_176_1.leftNameTxt_.text)
				SetActive(arg_176_1.iconTrs_.gameObject, false)
				arg_176_1.callingController_:SetSelectedState("normal")

				local var_179_3 = arg_176_1:GetWordFromCfg(324572042)
				local var_179_4 = arg_176_1:FormatText(var_179_3.content)

				arg_176_1.text_.text = var_179_4

				LuaForUtil.ClearLinePrefixSymbol(arg_176_1.text_)

				local var_179_5 = 22
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

				if manager.audio:GetVoiceLength("story_v_out_324572", "324572042", "story_v_out_324572.awb") ~= 0 then
					local var_179_8 = manager.audio:GetVoiceLength("story_v_out_324572", "324572042", "story_v_out_324572.awb") / 1000

					if var_179_8 + var_179_0 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_8 + var_179_0
					end

					if var_179_3.prefab_name ~= "" and arg_176_1.actors_[var_179_3.prefab_name] ~= nil then
						local var_179_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_176_1.actors_[var_179_3.prefab_name].transform, "story_v_out_324572", "324572042", "story_v_out_324572.awb")

						arg_176_1:RecordAudio("324572042", var_179_9)
						arg_176_1:RecordAudio("324572042", var_179_9)
					else
						arg_176_1:AudioAction("play", "voice", "story_v_out_324572", "324572042", "story_v_out_324572.awb")
					end

					arg_176_1:RecordHistoryTalkVoice("story_v_out_324572", "324572042", "story_v_out_324572.awb")
				end

				arg_176_1:RecordContent(arg_176_1.text_.text)
			end

			local var_179_10 = math.max(var_179_1, arg_176_1.talkMaxDuration)

			if var_179_0 <= arg_176_1.time_ and arg_176_1.time_ < var_179_0 + var_179_10 then
				arg_176_1.typewritter.percent = (arg_176_1.time_ - var_179_0) / var_179_10

				arg_176_1.typewritter:SetDirty()
			end

			if arg_176_1.time_ >= var_179_0 + var_179_10 and arg_176_1.time_ < var_179_0 + var_179_10 + arg_179_0 then
				arg_176_1.typewritter.percent = 1

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(true)
			end
		end

		arg_176_1.nodeConfigList_ = {}

		arg_176_1:InitPlayNodeList()
	end,
	Play324572043 = function(arg_180_0, arg_180_1)
		arg_180_1.time_ = 0
		arg_180_1.frameCnt_ = 0
		arg_180_1.state_ = "playing"
		arg_180_1.curTalkId_ = 324572043
		arg_180_1.duration_ = 5

		SetActive(arg_180_1.tipsGo_, false)

		function arg_180_1.onSingleLineFinish_()
			arg_180_1.onSingleLineUpdate_ = nil
			arg_180_1.onSingleLineFinish_ = nil
			arg_180_1.state_ = "waiting"
		end

		function arg_180_1.playNext_(arg_182_0)
			if arg_182_0 == 1 then
				arg_180_0:Play324572044(arg_180_1)
			end
		end

		function arg_180_1.onSingleLineUpdate_(arg_183_0)
			local var_183_0 = arg_180_1.actors_["10170ui_story"]
			local var_183_1 = 0

			if var_183_1 < arg_180_1.time_ and arg_180_1.time_ <= var_183_1 + arg_183_0 and not isNil(var_183_0) and arg_180_1.var_.characterEffect10170ui_story == nil then
				arg_180_1.var_.characterEffect10170ui_story = var_183_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_183_2 = 0.200000002980232

			if var_183_1 <= arg_180_1.time_ and arg_180_1.time_ < var_183_1 + var_183_2 and not isNil(var_183_0) then
				local var_183_3 = (arg_180_1.time_ - var_183_1) / var_183_2

				if arg_180_1.var_.characterEffect10170ui_story and not isNil(var_183_0) then
					local var_183_4 = Mathf.Lerp(0, 0.5, var_183_3)

					arg_180_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_180_1.var_.characterEffect10170ui_story.fillRatio = var_183_4
				end
			end

			if arg_180_1.time_ >= var_183_1 + var_183_2 and arg_180_1.time_ < var_183_1 + var_183_2 + arg_183_0 and not isNil(var_183_0) and arg_180_1.var_.characterEffect10170ui_story then
				local var_183_5 = 0.5

				arg_180_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_180_1.var_.characterEffect10170ui_story.fillRatio = var_183_5
			end

			local var_183_6 = 0
			local var_183_7 = 0.5

			if var_183_6 < arg_180_1.time_ and arg_180_1.time_ <= var_183_6 + arg_183_0 then
				arg_180_1.talkMaxDuration = 0
				arg_180_1.dialogCg_.alpha = 1

				arg_180_1.dialog_:SetActive(true)
				SetActive(arg_180_1.leftNameGo_, true)

				local var_183_8 = arg_180_1:FormatText(StoryNameCfg[7].name)

				arg_180_1.leftNameTxt_.text = var_183_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_180_1.leftNameTxt_.transform)

				arg_180_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_180_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_180_1:RecordName(arg_180_1.leftNameTxt_.text)
				SetActive(arg_180_1.iconTrs_.gameObject, true)
				arg_180_1.iconController_:SetSelectedState("hero")

				arg_180_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_180_1.callingController_:SetSelectedState("normal")

				arg_180_1.keyicon_.color = Color.New(1, 1, 1)
				arg_180_1.icon_.color = Color.New(1, 1, 1)

				local var_183_9 = arg_180_1:GetWordFromCfg(324572043)
				local var_183_10 = arg_180_1:FormatText(var_183_9.content)

				arg_180_1.text_.text = var_183_10

				LuaForUtil.ClearLinePrefixSymbol(arg_180_1.text_)

				local var_183_11 = 20
				local var_183_12 = utf8.len(var_183_10)
				local var_183_13 = var_183_11 <= 0 and var_183_7 or var_183_7 * (var_183_12 / var_183_11)

				if var_183_13 > 0 and var_183_7 < var_183_13 then
					arg_180_1.talkMaxDuration = var_183_13

					if var_183_13 + var_183_6 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_13 + var_183_6
					end
				end

				arg_180_1.text_.text = var_183_10
				arg_180_1.typewritter.percent = 0

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(false)
				arg_180_1:RecordContent(arg_180_1.text_.text)
			end

			local var_183_14 = math.max(var_183_7, arg_180_1.talkMaxDuration)

			if var_183_6 <= arg_180_1.time_ and arg_180_1.time_ < var_183_6 + var_183_14 then
				arg_180_1.typewritter.percent = (arg_180_1.time_ - var_183_6) / var_183_14

				arg_180_1.typewritter:SetDirty()
			end

			if arg_180_1.time_ >= var_183_6 + var_183_14 and arg_180_1.time_ < var_183_6 + var_183_14 + arg_183_0 then
				arg_180_1.typewritter.percent = 1

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(true)
			end
		end

		arg_180_1.nodeConfigList_ = {}

		arg_180_1:InitPlayNodeList()
	end,
	Play324572044 = function(arg_184_0, arg_184_1)
		arg_184_1.time_ = 0
		arg_184_1.frameCnt_ = 0
		arg_184_1.state_ = "playing"
		arg_184_1.curTalkId_ = 324572044
		arg_184_1.duration_ = 5

		SetActive(arg_184_1.tipsGo_, false)

		function arg_184_1.onSingleLineFinish_()
			arg_184_1.onSingleLineUpdate_ = nil
			arg_184_1.onSingleLineFinish_ = nil
			arg_184_1.state_ = "waiting"
		end

		function arg_184_1.playNext_(arg_186_0)
			if arg_186_0 == 1 then
				arg_184_0:Play324572045(arg_184_1)
			end
		end

		function arg_184_1.onSingleLineUpdate_(arg_187_0)
			local var_187_0 = arg_184_1.actors_["10170ui_story"].transform
			local var_187_1 = 0

			if var_187_1 < arg_184_1.time_ and arg_184_1.time_ <= var_187_1 + arg_187_0 then
				arg_184_1.var_.moveOldPos10170ui_story = var_187_0.localPosition

				local var_187_2 = GameObjectTools.GetOrAddComponent(var_187_0.gameObject, typeof(DynamicBoneHelper))

				if var_187_2 then
					var_187_2:EnableDynamicBone(false)
				end
			end

			local var_187_3 = 0.001

			if var_187_1 <= arg_184_1.time_ and arg_184_1.time_ < var_187_1 + var_187_3 then
				local var_187_4 = (arg_184_1.time_ - var_187_1) / var_187_3
				local var_187_5 = Vector3.New(0, 100, 0)

				var_187_0.localPosition = Vector3.Lerp(arg_184_1.var_.moveOldPos10170ui_story, var_187_5, var_187_4)

				local var_187_6 = manager.ui.mainCamera.transform.position - var_187_0.position

				var_187_0.forward = Vector3.New(var_187_6.x, var_187_6.y, var_187_6.z)

				local var_187_7 = var_187_0.localEulerAngles

				var_187_7.z = 0
				var_187_7.x = 0
				var_187_0.localEulerAngles = var_187_7
			end

			if arg_184_1.time_ >= var_187_1 + var_187_3 and arg_184_1.time_ < var_187_1 + var_187_3 + arg_187_0 then
				var_187_0.localPosition = Vector3.New(0, 100, 0)

				local var_187_8 = manager.ui.mainCamera.transform.position - var_187_0.position

				var_187_0.forward = Vector3.New(var_187_8.x, var_187_8.y, var_187_8.z)

				local var_187_9 = var_187_0.localEulerAngles

				var_187_9.z = 0
				var_187_9.x = 0
				var_187_0.localEulerAngles = var_187_9

				local var_187_10 = GameObjectTools.GetOrAddComponent(var_187_0.gameObject, typeof(DynamicBoneHelper))

				if var_187_10 then
					var_187_10:EnableDynamicBone(true)
				end
			end

			local var_187_11 = 0
			local var_187_12 = 0.95

			if var_187_11 < arg_184_1.time_ and arg_184_1.time_ <= var_187_11 + arg_187_0 then
				arg_184_1.talkMaxDuration = 0
				arg_184_1.dialogCg_.alpha = 1

				arg_184_1.dialog_:SetActive(true)
				SetActive(arg_184_1.leftNameGo_, false)

				arg_184_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_184_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_184_1:RecordName(arg_184_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_184_1.iconTrs_.gameObject, false)
				arg_184_1.callingController_:SetSelectedState("normal")

				local var_187_13 = arg_184_1:GetWordFromCfg(324572044)
				local var_187_14 = arg_184_1:FormatText(var_187_13.content)

				arg_184_1.text_.text = var_187_14

				LuaForUtil.ClearLinePrefixSymbol(arg_184_1.text_)

				local var_187_15 = 38
				local var_187_16 = utf8.len(var_187_14)
				local var_187_17 = var_187_15 <= 0 and var_187_12 or var_187_12 * (var_187_16 / var_187_15)

				if var_187_17 > 0 and var_187_12 < var_187_17 then
					arg_184_1.talkMaxDuration = var_187_17

					if var_187_17 + var_187_11 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_17 + var_187_11
					end
				end

				arg_184_1.text_.text = var_187_14
				arg_184_1.typewritter.percent = 0

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(false)
				arg_184_1:RecordContent(arg_184_1.text_.text)
			end

			local var_187_18 = math.max(var_187_12, arg_184_1.talkMaxDuration)

			if var_187_11 <= arg_184_1.time_ and arg_184_1.time_ < var_187_11 + var_187_18 then
				arg_184_1.typewritter.percent = (arg_184_1.time_ - var_187_11) / var_187_18

				arg_184_1.typewritter:SetDirty()
			end

			if arg_184_1.time_ >= var_187_11 + var_187_18 and arg_184_1.time_ < var_187_11 + var_187_18 + arg_187_0 then
				arg_184_1.typewritter.percent = 1

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(true)
			end
		end

		arg_184_1.nodeConfigList_ = {
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

		arg_184_1:InitPlayNodeList()
	end,
	Play324572045 = function(arg_188_0, arg_188_1)
		arg_188_1.time_ = 0
		arg_188_1.frameCnt_ = 0
		arg_188_1.state_ = "playing"
		arg_188_1.curTalkId_ = 324572045
		arg_188_1.duration_ = 3.77

		SetActive(arg_188_1.tipsGo_, false)

		function arg_188_1.onSingleLineFinish_()
			arg_188_1.onSingleLineUpdate_ = nil
			arg_188_1.onSingleLineFinish_ = nil
			arg_188_1.state_ = "waiting"
		end

		function arg_188_1.playNext_(arg_190_0)
			if arg_190_0 == 1 then
				arg_188_0:Play324572046(arg_188_1)
			end
		end

		function arg_188_1.onSingleLineUpdate_(arg_191_0)
			local var_191_0 = arg_188_1.actors_["10170ui_story"].transform
			local var_191_1 = 0

			if var_191_1 < arg_188_1.time_ and arg_188_1.time_ <= var_191_1 + arg_191_0 then
				arg_188_1.var_.moveOldPos10170ui_story = var_191_0.localPosition

				local var_191_2 = GameObjectTools.GetOrAddComponent(var_191_0.gameObject, typeof(DynamicBoneHelper))

				if var_191_2 then
					var_191_2:EnableDynamicBone(false)
				end
			end

			local var_191_3 = 0.001

			if var_191_1 <= arg_188_1.time_ and arg_188_1.time_ < var_191_1 + var_191_3 then
				local var_191_4 = (arg_188_1.time_ - var_191_1) / var_191_3
				local var_191_5 = Vector3.New(0, -1.03, -6.05)

				var_191_0.localPosition = Vector3.Lerp(arg_188_1.var_.moveOldPos10170ui_story, var_191_5, var_191_4)

				local var_191_6 = manager.ui.mainCamera.transform.position - var_191_0.position

				var_191_0.forward = Vector3.New(var_191_6.x, var_191_6.y, var_191_6.z)

				local var_191_7 = var_191_0.localEulerAngles

				var_191_7.z = 0
				var_191_7.x = 0
				var_191_0.localEulerAngles = var_191_7
			end

			if arg_188_1.time_ >= var_191_1 + var_191_3 and arg_188_1.time_ < var_191_1 + var_191_3 + arg_191_0 then
				var_191_0.localPosition = Vector3.New(0, -1.03, -6.05)

				local var_191_8 = manager.ui.mainCamera.transform.position - var_191_0.position

				var_191_0.forward = Vector3.New(var_191_8.x, var_191_8.y, var_191_8.z)

				local var_191_9 = var_191_0.localEulerAngles

				var_191_9.z = 0
				var_191_9.x = 0
				var_191_0.localEulerAngles = var_191_9

				local var_191_10 = GameObjectTools.GetOrAddComponent(var_191_0.gameObject, typeof(DynamicBoneHelper))

				if var_191_10 then
					var_191_10:EnableDynamicBone(true)
				end
			end

			local var_191_11 = arg_188_1.actors_["10170ui_story"]
			local var_191_12 = 0

			if var_191_12 < arg_188_1.time_ and arg_188_1.time_ <= var_191_12 + arg_191_0 and not isNil(var_191_11) and arg_188_1.var_.characterEffect10170ui_story == nil then
				arg_188_1.var_.characterEffect10170ui_story = var_191_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_191_13 = 0.200000002980232

			if var_191_12 <= arg_188_1.time_ and arg_188_1.time_ < var_191_12 + var_191_13 and not isNil(var_191_11) then
				local var_191_14 = (arg_188_1.time_ - var_191_12) / var_191_13

				if arg_188_1.var_.characterEffect10170ui_story and not isNil(var_191_11) then
					arg_188_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_188_1.time_ >= var_191_12 + var_191_13 and arg_188_1.time_ < var_191_12 + var_191_13 + arg_191_0 and not isNil(var_191_11) and arg_188_1.var_.characterEffect10170ui_story then
				arg_188_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			local var_191_15 = 0

			if var_191_15 < arg_188_1.time_ and arg_188_1.time_ <= var_191_15 + arg_191_0 then
				arg_188_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/story10170/story10170action/10170action27_2")
			end

			local var_191_16 = 0

			if var_191_16 < arg_188_1.time_ and arg_188_1.time_ <= var_191_16 + arg_191_0 then
				arg_188_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_191_17 = 0
			local var_191_18 = 0.4

			if var_191_17 < arg_188_1.time_ and arg_188_1.time_ <= var_191_17 + arg_191_0 then
				arg_188_1.talkMaxDuration = 0
				arg_188_1.dialogCg_.alpha = 1

				arg_188_1.dialog_:SetActive(true)
				SetActive(arg_188_1.leftNameGo_, true)

				local var_191_19 = arg_188_1:FormatText(StoryNameCfg[1450].name)

				arg_188_1.leftNameTxt_.text = var_191_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_188_1.leftNameTxt_.transform)

				arg_188_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_188_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_188_1:RecordName(arg_188_1.leftNameTxt_.text)
				SetActive(arg_188_1.iconTrs_.gameObject, false)
				arg_188_1.callingController_:SetSelectedState("normal")

				local var_191_20 = arg_188_1:GetWordFromCfg(324572045)
				local var_191_21 = arg_188_1:FormatText(var_191_20.content)

				arg_188_1.text_.text = var_191_21

				LuaForUtil.ClearLinePrefixSymbol(arg_188_1.text_)

				local var_191_22 = 16
				local var_191_23 = utf8.len(var_191_21)
				local var_191_24 = var_191_22 <= 0 and var_191_18 or var_191_18 * (var_191_23 / var_191_22)

				if var_191_24 > 0 and var_191_18 < var_191_24 then
					arg_188_1.talkMaxDuration = var_191_24

					if var_191_24 + var_191_17 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_24 + var_191_17
					end
				end

				arg_188_1.text_.text = var_191_21
				arg_188_1.typewritter.percent = 0

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324572", "324572045", "story_v_out_324572.awb") ~= 0 then
					local var_191_25 = manager.audio:GetVoiceLength("story_v_out_324572", "324572045", "story_v_out_324572.awb") / 1000

					if var_191_25 + var_191_17 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_25 + var_191_17
					end

					if var_191_20.prefab_name ~= "" and arg_188_1.actors_[var_191_20.prefab_name] ~= nil then
						local var_191_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_188_1.actors_[var_191_20.prefab_name].transform, "story_v_out_324572", "324572045", "story_v_out_324572.awb")

						arg_188_1:RecordAudio("324572045", var_191_26)
						arg_188_1:RecordAudio("324572045", var_191_26)
					else
						arg_188_1:AudioAction("play", "voice", "story_v_out_324572", "324572045", "story_v_out_324572.awb")
					end

					arg_188_1:RecordHistoryTalkVoice("story_v_out_324572", "324572045", "story_v_out_324572.awb")
				end

				arg_188_1:RecordContent(arg_188_1.text_.text)
			end

			local var_191_27 = math.max(var_191_18, arg_188_1.talkMaxDuration)

			if var_191_17 <= arg_188_1.time_ and arg_188_1.time_ < var_191_17 + var_191_27 then
				arg_188_1.typewritter.percent = (arg_188_1.time_ - var_191_17) / var_191_27

				arg_188_1.typewritter:SetDirty()
			end

			if arg_188_1.time_ >= var_191_17 + var_191_27 and arg_188_1.time_ < var_191_17 + var_191_27 + arg_191_0 then
				arg_188_1.typewritter.percent = 1

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(true)
			end
		end

		arg_188_1.nodeConfigList_ = {
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

		arg_188_1:InitPlayNodeList()
	end,
	Play324572046 = function(arg_192_0, arg_192_1)
		arg_192_1.time_ = 0
		arg_192_1.frameCnt_ = 0
		arg_192_1.state_ = "playing"
		arg_192_1.curTalkId_ = 324572046
		arg_192_1.duration_ = 5

		SetActive(arg_192_1.tipsGo_, false)

		function arg_192_1.onSingleLineFinish_()
			arg_192_1.onSingleLineUpdate_ = nil
			arg_192_1.onSingleLineFinish_ = nil
			arg_192_1.state_ = "waiting"
		end

		function arg_192_1.playNext_(arg_194_0)
			if arg_194_0 == 1 then
				arg_192_0:Play324572047(arg_192_1)
			end
		end

		function arg_192_1.onSingleLineUpdate_(arg_195_0)
			local var_195_0 = arg_192_1.actors_["10170ui_story"]
			local var_195_1 = 0

			if var_195_1 < arg_192_1.time_ and arg_192_1.time_ <= var_195_1 + arg_195_0 and not isNil(var_195_0) and arg_192_1.var_.characterEffect10170ui_story == nil then
				arg_192_1.var_.characterEffect10170ui_story = var_195_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_195_2 = 0.200000002980232

			if var_195_1 <= arg_192_1.time_ and arg_192_1.time_ < var_195_1 + var_195_2 and not isNil(var_195_0) then
				local var_195_3 = (arg_192_1.time_ - var_195_1) / var_195_2

				if arg_192_1.var_.characterEffect10170ui_story and not isNil(var_195_0) then
					local var_195_4 = Mathf.Lerp(0, 0.5, var_195_3)

					arg_192_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_192_1.var_.characterEffect10170ui_story.fillRatio = var_195_4
				end
			end

			if arg_192_1.time_ >= var_195_1 + var_195_2 and arg_192_1.time_ < var_195_1 + var_195_2 + arg_195_0 and not isNil(var_195_0) and arg_192_1.var_.characterEffect10170ui_story then
				local var_195_5 = 0.5

				arg_192_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_192_1.var_.characterEffect10170ui_story.fillRatio = var_195_5
			end

			local var_195_6 = 0
			local var_195_7 = 0.0329999998211861

			if var_195_6 < arg_192_1.time_ and arg_192_1.time_ <= var_195_6 + arg_195_0 then
				arg_192_1.talkMaxDuration = 0
				arg_192_1.dialogCg_.alpha = 1

				arg_192_1.dialog_:SetActive(true)
				SetActive(arg_192_1.leftNameGo_, true)

				local var_195_8 = arg_192_1:FormatText(StoryNameCfg[7].name)

				arg_192_1.leftNameTxt_.text = var_195_8

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

				local var_195_9 = arg_192_1:GetWordFromCfg(324572046)
				local var_195_10 = arg_192_1:FormatText(var_195_9.content)

				arg_192_1.text_.text = var_195_10

				LuaForUtil.ClearLinePrefixSymbol(arg_192_1.text_)

				local var_195_11 = 1
				local var_195_12 = utf8.len(var_195_10)
				local var_195_13 = var_195_11 <= 0 and var_195_7 or var_195_7 * (var_195_12 / var_195_11)

				if var_195_13 > 0 and var_195_7 < var_195_13 then
					arg_192_1.talkMaxDuration = var_195_13

					if var_195_13 + var_195_6 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_13 + var_195_6
					end
				end

				arg_192_1.text_.text = var_195_10
				arg_192_1.typewritter.percent = 0

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(false)
				arg_192_1:RecordContent(arg_192_1.text_.text)
			end

			local var_195_14 = math.max(var_195_7, arg_192_1.talkMaxDuration)

			if var_195_6 <= arg_192_1.time_ and arg_192_1.time_ < var_195_6 + var_195_14 then
				arg_192_1.typewritter.percent = (arg_192_1.time_ - var_195_6) / var_195_14

				arg_192_1.typewritter:SetDirty()
			end

			if arg_192_1.time_ >= var_195_6 + var_195_14 and arg_192_1.time_ < var_195_6 + var_195_14 + arg_195_0 then
				arg_192_1.typewritter.percent = 1

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(true)
			end
		end

		arg_192_1.nodeConfigList_ = {}

		arg_192_1:InitPlayNodeList()
	end,
	Play324572047 = function(arg_196_0, arg_196_1)
		arg_196_1.time_ = 0
		arg_196_1.frameCnt_ = 0
		arg_196_1.state_ = "playing"
		arg_196_1.curTalkId_ = 324572047
		arg_196_1.duration_ = 3.87

		SetActive(arg_196_1.tipsGo_, false)

		function arg_196_1.onSingleLineFinish_()
			arg_196_1.onSingleLineUpdate_ = nil
			arg_196_1.onSingleLineFinish_ = nil
			arg_196_1.state_ = "waiting"
		end

		function arg_196_1.playNext_(arg_198_0)
			if arg_198_0 == 1 then
				arg_196_0:Play324572048(arg_196_1)
			end
		end

		function arg_196_1.onSingleLineUpdate_(arg_199_0)
			local var_199_0 = arg_196_1.actors_["10170ui_story"]
			local var_199_1 = 0

			if var_199_1 < arg_196_1.time_ and arg_196_1.time_ <= var_199_1 + arg_199_0 and not isNil(var_199_0) and arg_196_1.var_.characterEffect10170ui_story == nil then
				arg_196_1.var_.characterEffect10170ui_story = var_199_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_199_2 = 0.200000002980232

			if var_199_1 <= arg_196_1.time_ and arg_196_1.time_ < var_199_1 + var_199_2 and not isNil(var_199_0) then
				local var_199_3 = (arg_196_1.time_ - var_199_1) / var_199_2

				if arg_196_1.var_.characterEffect10170ui_story and not isNil(var_199_0) then
					arg_196_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_196_1.time_ >= var_199_1 + var_199_2 and arg_196_1.time_ < var_199_1 + var_199_2 + arg_199_0 and not isNil(var_199_0) and arg_196_1.var_.characterEffect10170ui_story then
				arg_196_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			local var_199_4 = 0
			local var_199_5 = 0.5

			if var_199_4 < arg_196_1.time_ and arg_196_1.time_ <= var_199_4 + arg_199_0 then
				arg_196_1.talkMaxDuration = 0
				arg_196_1.dialogCg_.alpha = 1

				arg_196_1.dialog_:SetActive(true)
				SetActive(arg_196_1.leftNameGo_, true)

				local var_199_6 = arg_196_1:FormatText(StoryNameCfg[1450].name)

				arg_196_1.leftNameTxt_.text = var_199_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_196_1.leftNameTxt_.transform)

				arg_196_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_196_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_196_1:RecordName(arg_196_1.leftNameTxt_.text)
				SetActive(arg_196_1.iconTrs_.gameObject, false)
				arg_196_1.callingController_:SetSelectedState("normal")

				local var_199_7 = arg_196_1:GetWordFromCfg(324572047)
				local var_199_8 = arg_196_1:FormatText(var_199_7.content)

				arg_196_1.text_.text = var_199_8

				LuaForUtil.ClearLinePrefixSymbol(arg_196_1.text_)

				local var_199_9 = 20
				local var_199_10 = utf8.len(var_199_8)
				local var_199_11 = var_199_9 <= 0 and var_199_5 or var_199_5 * (var_199_10 / var_199_9)

				if var_199_11 > 0 and var_199_5 < var_199_11 then
					arg_196_1.talkMaxDuration = var_199_11

					if var_199_11 + var_199_4 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_11 + var_199_4
					end
				end

				arg_196_1.text_.text = var_199_8
				arg_196_1.typewritter.percent = 0

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324572", "324572047", "story_v_out_324572.awb") ~= 0 then
					local var_199_12 = manager.audio:GetVoiceLength("story_v_out_324572", "324572047", "story_v_out_324572.awb") / 1000

					if var_199_12 + var_199_4 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_12 + var_199_4
					end

					if var_199_7.prefab_name ~= "" and arg_196_1.actors_[var_199_7.prefab_name] ~= nil then
						local var_199_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_196_1.actors_[var_199_7.prefab_name].transform, "story_v_out_324572", "324572047", "story_v_out_324572.awb")

						arg_196_1:RecordAudio("324572047", var_199_13)
						arg_196_1:RecordAudio("324572047", var_199_13)
					else
						arg_196_1:AudioAction("play", "voice", "story_v_out_324572", "324572047", "story_v_out_324572.awb")
					end

					arg_196_1:RecordHistoryTalkVoice("story_v_out_324572", "324572047", "story_v_out_324572.awb")
				end

				arg_196_1:RecordContent(arg_196_1.text_.text)
			end

			local var_199_14 = math.max(var_199_5, arg_196_1.talkMaxDuration)

			if var_199_4 <= arg_196_1.time_ and arg_196_1.time_ < var_199_4 + var_199_14 then
				arg_196_1.typewritter.percent = (arg_196_1.time_ - var_199_4) / var_199_14

				arg_196_1.typewritter:SetDirty()
			end

			if arg_196_1.time_ >= var_199_4 + var_199_14 and arg_196_1.time_ < var_199_4 + var_199_14 + arg_199_0 then
				arg_196_1.typewritter.percent = 1

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(true)
			end
		end

		arg_196_1.nodeConfigList_ = {}

		arg_196_1:InitPlayNodeList()
	end,
	Play324572048 = function(arg_200_0, arg_200_1)
		arg_200_1.time_ = 0
		arg_200_1.frameCnt_ = 0
		arg_200_1.state_ = "playing"
		arg_200_1.curTalkId_ = 324572048
		arg_200_1.duration_ = 8.57

		SetActive(arg_200_1.tipsGo_, false)

		function arg_200_1.onSingleLineFinish_()
			arg_200_1.onSingleLineUpdate_ = nil
			arg_200_1.onSingleLineFinish_ = nil
			arg_200_1.state_ = "waiting"
		end

		function arg_200_1.playNext_(arg_202_0)
			if arg_202_0 == 1 then
				arg_200_0:Play324572049(arg_200_1)
			end
		end

		function arg_200_1.onSingleLineUpdate_(arg_203_0)
			local var_203_0 = 0

			if var_203_0 < arg_200_1.time_ and arg_200_1.time_ <= var_203_0 + arg_203_0 then
				arg_200_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/story10170/story10170action/10170action28_1")
			end

			local var_203_1 = 0

			if var_203_1 < arg_200_1.time_ and arg_200_1.time_ <= var_203_1 + arg_203_0 then
				arg_200_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_203_2 = 0
			local var_203_3 = 1.1

			if var_203_2 < arg_200_1.time_ and arg_200_1.time_ <= var_203_2 + arg_203_0 then
				arg_200_1.talkMaxDuration = 0
				arg_200_1.dialogCg_.alpha = 1

				arg_200_1.dialog_:SetActive(true)
				SetActive(arg_200_1.leftNameGo_, true)

				local var_203_4 = arg_200_1:FormatText(StoryNameCfg[1450].name)

				arg_200_1.leftNameTxt_.text = var_203_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_200_1.leftNameTxt_.transform)

				arg_200_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_200_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_200_1:RecordName(arg_200_1.leftNameTxt_.text)
				SetActive(arg_200_1.iconTrs_.gameObject, false)
				arg_200_1.callingController_:SetSelectedState("normal")

				local var_203_5 = arg_200_1:GetWordFromCfg(324572048)
				local var_203_6 = arg_200_1:FormatText(var_203_5.content)

				arg_200_1.text_.text = var_203_6

				LuaForUtil.ClearLinePrefixSymbol(arg_200_1.text_)

				local var_203_7 = 44
				local var_203_8 = utf8.len(var_203_6)
				local var_203_9 = var_203_7 <= 0 and var_203_3 or var_203_3 * (var_203_8 / var_203_7)

				if var_203_9 > 0 and var_203_3 < var_203_9 then
					arg_200_1.talkMaxDuration = var_203_9

					if var_203_9 + var_203_2 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_9 + var_203_2
					end
				end

				arg_200_1.text_.text = var_203_6
				arg_200_1.typewritter.percent = 0

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324572", "324572048", "story_v_out_324572.awb") ~= 0 then
					local var_203_10 = manager.audio:GetVoiceLength("story_v_out_324572", "324572048", "story_v_out_324572.awb") / 1000

					if var_203_10 + var_203_2 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_10 + var_203_2
					end

					if var_203_5.prefab_name ~= "" and arg_200_1.actors_[var_203_5.prefab_name] ~= nil then
						local var_203_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_200_1.actors_[var_203_5.prefab_name].transform, "story_v_out_324572", "324572048", "story_v_out_324572.awb")

						arg_200_1:RecordAudio("324572048", var_203_11)
						arg_200_1:RecordAudio("324572048", var_203_11)
					else
						arg_200_1:AudioAction("play", "voice", "story_v_out_324572", "324572048", "story_v_out_324572.awb")
					end

					arg_200_1:RecordHistoryTalkVoice("story_v_out_324572", "324572048", "story_v_out_324572.awb")
				end

				arg_200_1:RecordContent(arg_200_1.text_.text)
			end

			local var_203_12 = math.max(var_203_3, arg_200_1.talkMaxDuration)

			if var_203_2 <= arg_200_1.time_ and arg_200_1.time_ < var_203_2 + var_203_12 then
				arg_200_1.typewritter.percent = (arg_200_1.time_ - var_203_2) / var_203_12

				arg_200_1.typewritter:SetDirty()
			end

			if arg_200_1.time_ >= var_203_2 + var_203_12 and arg_200_1.time_ < var_203_2 + var_203_12 + arg_203_0 then
				arg_200_1.typewritter.percent = 1

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(true)
			end
		end

		arg_200_1.nodeConfigList_ = {}

		arg_200_1:InitPlayNodeList()
	end,
	Play324572049 = function(arg_204_0, arg_204_1)
		arg_204_1.time_ = 0
		arg_204_1.frameCnt_ = 0
		arg_204_1.state_ = "playing"
		arg_204_1.curTalkId_ = 324572049
		arg_204_1.duration_ = 3.2

		SetActive(arg_204_1.tipsGo_, false)

		function arg_204_1.onSingleLineFinish_()
			arg_204_1.onSingleLineUpdate_ = nil
			arg_204_1.onSingleLineFinish_ = nil
			arg_204_1.state_ = "waiting"
		end

		function arg_204_1.playNext_(arg_206_0)
			if arg_206_0 == 1 then
				arg_204_0:Play324572050(arg_204_1)
			end
		end

		function arg_204_1.onSingleLineUpdate_(arg_207_0)
			local var_207_0 = 0
			local var_207_1 = 0.3

			if var_207_0 < arg_204_1.time_ and arg_204_1.time_ <= var_207_0 + arg_207_0 then
				arg_204_1.talkMaxDuration = 0
				arg_204_1.dialogCg_.alpha = 1

				arg_204_1.dialog_:SetActive(true)
				SetActive(arg_204_1.leftNameGo_, true)

				local var_207_2 = arg_204_1:FormatText(StoryNameCfg[1450].name)

				arg_204_1.leftNameTxt_.text = var_207_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_204_1.leftNameTxt_.transform)

				arg_204_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_204_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_204_1:RecordName(arg_204_1.leftNameTxt_.text)
				SetActive(arg_204_1.iconTrs_.gameObject, false)
				arg_204_1.callingController_:SetSelectedState("normal")

				local var_207_3 = arg_204_1:GetWordFromCfg(324572049)
				local var_207_4 = arg_204_1:FormatText(var_207_3.content)

				arg_204_1.text_.text = var_207_4

				LuaForUtil.ClearLinePrefixSymbol(arg_204_1.text_)

				local var_207_5 = 12
				local var_207_6 = utf8.len(var_207_4)
				local var_207_7 = var_207_5 <= 0 and var_207_1 or var_207_1 * (var_207_6 / var_207_5)

				if var_207_7 > 0 and var_207_1 < var_207_7 then
					arg_204_1.talkMaxDuration = var_207_7

					if var_207_7 + var_207_0 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_7 + var_207_0
					end
				end

				arg_204_1.text_.text = var_207_4
				arg_204_1.typewritter.percent = 0

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324572", "324572049", "story_v_out_324572.awb") ~= 0 then
					local var_207_8 = manager.audio:GetVoiceLength("story_v_out_324572", "324572049", "story_v_out_324572.awb") / 1000

					if var_207_8 + var_207_0 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_8 + var_207_0
					end

					if var_207_3.prefab_name ~= "" and arg_204_1.actors_[var_207_3.prefab_name] ~= nil then
						local var_207_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_204_1.actors_[var_207_3.prefab_name].transform, "story_v_out_324572", "324572049", "story_v_out_324572.awb")

						arg_204_1:RecordAudio("324572049", var_207_9)
						arg_204_1:RecordAudio("324572049", var_207_9)
					else
						arg_204_1:AudioAction("play", "voice", "story_v_out_324572", "324572049", "story_v_out_324572.awb")
					end

					arg_204_1:RecordHistoryTalkVoice("story_v_out_324572", "324572049", "story_v_out_324572.awb")
				end

				arg_204_1:RecordContent(arg_204_1.text_.text)
			end

			local var_207_10 = math.max(var_207_1, arg_204_1.talkMaxDuration)

			if var_207_0 <= arg_204_1.time_ and arg_204_1.time_ < var_207_0 + var_207_10 then
				arg_204_1.typewritter.percent = (arg_204_1.time_ - var_207_0) / var_207_10

				arg_204_1.typewritter:SetDirty()
			end

			if arg_204_1.time_ >= var_207_0 + var_207_10 and arg_204_1.time_ < var_207_0 + var_207_10 + arg_207_0 then
				arg_204_1.typewritter.percent = 1

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(true)
			end
		end

		arg_204_1.nodeConfigList_ = {}

		arg_204_1:InitPlayNodeList()
	end,
	Play324572050 = function(arg_208_0, arg_208_1)
		arg_208_1.time_ = 0
		arg_208_1.frameCnt_ = 0
		arg_208_1.state_ = "playing"
		arg_208_1.curTalkId_ = 324572050
		arg_208_1.duration_ = 5

		SetActive(arg_208_1.tipsGo_, false)

		function arg_208_1.onSingleLineFinish_()
			arg_208_1.onSingleLineUpdate_ = nil
			arg_208_1.onSingleLineFinish_ = nil
			arg_208_1.state_ = "waiting"
		end

		function arg_208_1.playNext_(arg_210_0)
			if arg_210_0 == 1 then
				arg_208_0:Play324572051(arg_208_1)
			end
		end

		function arg_208_1.onSingleLineUpdate_(arg_211_0)
			local var_211_0 = arg_208_1.actors_["10170ui_story"]
			local var_211_1 = 0

			if var_211_1 < arg_208_1.time_ and arg_208_1.time_ <= var_211_1 + arg_211_0 and not isNil(var_211_0) and arg_208_1.var_.characterEffect10170ui_story == nil then
				arg_208_1.var_.characterEffect10170ui_story = var_211_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_211_2 = 0.200000002980232

			if var_211_1 <= arg_208_1.time_ and arg_208_1.time_ < var_211_1 + var_211_2 and not isNil(var_211_0) then
				local var_211_3 = (arg_208_1.time_ - var_211_1) / var_211_2

				if arg_208_1.var_.characterEffect10170ui_story and not isNil(var_211_0) then
					local var_211_4 = Mathf.Lerp(0, 0.5, var_211_3)

					arg_208_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_208_1.var_.characterEffect10170ui_story.fillRatio = var_211_4
				end
			end

			if arg_208_1.time_ >= var_211_1 + var_211_2 and arg_208_1.time_ < var_211_1 + var_211_2 + arg_211_0 and not isNil(var_211_0) and arg_208_1.var_.characterEffect10170ui_story then
				local var_211_5 = 0.5

				arg_208_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_208_1.var_.characterEffect10170ui_story.fillRatio = var_211_5
			end

			local var_211_6 = 0
			local var_211_7 = 0.175

			if var_211_6 < arg_208_1.time_ and arg_208_1.time_ <= var_211_6 + arg_211_0 then
				arg_208_1.talkMaxDuration = 0
				arg_208_1.dialogCg_.alpha = 1

				arg_208_1.dialog_:SetActive(true)
				SetActive(arg_208_1.leftNameGo_, true)

				local var_211_8 = arg_208_1:FormatText(StoryNameCfg[7].name)

				arg_208_1.leftNameTxt_.text = var_211_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_208_1.leftNameTxt_.transform)

				arg_208_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_208_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_208_1:RecordName(arg_208_1.leftNameTxt_.text)
				SetActive(arg_208_1.iconTrs_.gameObject, true)
				arg_208_1.iconController_:SetSelectedState("hero")

				arg_208_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_208_1.callingController_:SetSelectedState("normal")

				arg_208_1.keyicon_.color = Color.New(1, 1, 1)
				arg_208_1.icon_.color = Color.New(1, 1, 1)

				local var_211_9 = arg_208_1:GetWordFromCfg(324572050)
				local var_211_10 = arg_208_1:FormatText(var_211_9.content)

				arg_208_1.text_.text = var_211_10

				LuaForUtil.ClearLinePrefixSymbol(arg_208_1.text_)

				local var_211_11 = 7
				local var_211_12 = utf8.len(var_211_10)
				local var_211_13 = var_211_11 <= 0 and var_211_7 or var_211_7 * (var_211_12 / var_211_11)

				if var_211_13 > 0 and var_211_7 < var_211_13 then
					arg_208_1.talkMaxDuration = var_211_13

					if var_211_13 + var_211_6 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_13 + var_211_6
					end
				end

				arg_208_1.text_.text = var_211_10
				arg_208_1.typewritter.percent = 0

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(false)
				arg_208_1:RecordContent(arg_208_1.text_.text)
			end

			local var_211_14 = math.max(var_211_7, arg_208_1.talkMaxDuration)

			if var_211_6 <= arg_208_1.time_ and arg_208_1.time_ < var_211_6 + var_211_14 then
				arg_208_1.typewritter.percent = (arg_208_1.time_ - var_211_6) / var_211_14

				arg_208_1.typewritter:SetDirty()
			end

			if arg_208_1.time_ >= var_211_6 + var_211_14 and arg_208_1.time_ < var_211_6 + var_211_14 + arg_211_0 then
				arg_208_1.typewritter.percent = 1

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(true)
			end
		end

		arg_208_1.nodeConfigList_ = {}

		arg_208_1:InitPlayNodeList()
	end,
	Play324572051 = function(arg_212_0, arg_212_1)
		arg_212_1.time_ = 0
		arg_212_1.frameCnt_ = 0
		arg_212_1.state_ = "playing"
		arg_212_1.curTalkId_ = 324572051
		arg_212_1.duration_ = 2.7

		SetActive(arg_212_1.tipsGo_, false)

		function arg_212_1.onSingleLineFinish_()
			arg_212_1.onSingleLineUpdate_ = nil
			arg_212_1.onSingleLineFinish_ = nil
			arg_212_1.state_ = "waiting"
		end

		function arg_212_1.playNext_(arg_214_0)
			if arg_214_0 == 1 then
				arg_212_0:Play324572052(arg_212_1)
			end
		end

		function arg_212_1.onSingleLineUpdate_(arg_215_0)
			local var_215_0 = arg_212_1.actors_["10170ui_story"]
			local var_215_1 = 0

			if var_215_1 < arg_212_1.time_ and arg_212_1.time_ <= var_215_1 + arg_215_0 and not isNil(var_215_0) and arg_212_1.var_.characterEffect10170ui_story == nil then
				arg_212_1.var_.characterEffect10170ui_story = var_215_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_215_2 = 0.200000002980232

			if var_215_1 <= arg_212_1.time_ and arg_212_1.time_ < var_215_1 + var_215_2 and not isNil(var_215_0) then
				local var_215_3 = (arg_212_1.time_ - var_215_1) / var_215_2

				if arg_212_1.var_.characterEffect10170ui_story and not isNil(var_215_0) then
					arg_212_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_212_1.time_ >= var_215_1 + var_215_2 and arg_212_1.time_ < var_215_1 + var_215_2 + arg_215_0 and not isNil(var_215_0) and arg_212_1.var_.characterEffect10170ui_story then
				arg_212_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			local var_215_4 = 0

			if var_215_4 < arg_212_1.time_ and arg_212_1.time_ <= var_215_4 + arg_215_0 then
				arg_212_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/story10170/story10170action/10170action28_2")
			end

			local var_215_5 = 0

			if var_215_5 < arg_212_1.time_ and arg_212_1.time_ <= var_215_5 + arg_215_0 then
				arg_212_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_215_6 = 0
			local var_215_7 = 0.3

			if var_215_6 < arg_212_1.time_ and arg_212_1.time_ <= var_215_6 + arg_215_0 then
				arg_212_1.talkMaxDuration = 0
				arg_212_1.dialogCg_.alpha = 1

				arg_212_1.dialog_:SetActive(true)
				SetActive(arg_212_1.leftNameGo_, true)

				local var_215_8 = arg_212_1:FormatText(StoryNameCfg[1450].name)

				arg_212_1.leftNameTxt_.text = var_215_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_212_1.leftNameTxt_.transform)

				arg_212_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_212_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_212_1:RecordName(arg_212_1.leftNameTxt_.text)
				SetActive(arg_212_1.iconTrs_.gameObject, false)
				arg_212_1.callingController_:SetSelectedState("normal")

				local var_215_9 = arg_212_1:GetWordFromCfg(324572051)
				local var_215_10 = arg_212_1:FormatText(var_215_9.content)

				arg_212_1.text_.text = var_215_10

				LuaForUtil.ClearLinePrefixSymbol(arg_212_1.text_)

				local var_215_11 = 12
				local var_215_12 = utf8.len(var_215_10)
				local var_215_13 = var_215_11 <= 0 and var_215_7 or var_215_7 * (var_215_12 / var_215_11)

				if var_215_13 > 0 and var_215_7 < var_215_13 then
					arg_212_1.talkMaxDuration = var_215_13

					if var_215_13 + var_215_6 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_13 + var_215_6
					end
				end

				arg_212_1.text_.text = var_215_10
				arg_212_1.typewritter.percent = 0

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324572", "324572051", "story_v_out_324572.awb") ~= 0 then
					local var_215_14 = manager.audio:GetVoiceLength("story_v_out_324572", "324572051", "story_v_out_324572.awb") / 1000

					if var_215_14 + var_215_6 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_14 + var_215_6
					end

					if var_215_9.prefab_name ~= "" and arg_212_1.actors_[var_215_9.prefab_name] ~= nil then
						local var_215_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_212_1.actors_[var_215_9.prefab_name].transform, "story_v_out_324572", "324572051", "story_v_out_324572.awb")

						arg_212_1:RecordAudio("324572051", var_215_15)
						arg_212_1:RecordAudio("324572051", var_215_15)
					else
						arg_212_1:AudioAction("play", "voice", "story_v_out_324572", "324572051", "story_v_out_324572.awb")
					end

					arg_212_1:RecordHistoryTalkVoice("story_v_out_324572", "324572051", "story_v_out_324572.awb")
				end

				arg_212_1:RecordContent(arg_212_1.text_.text)
			end

			local var_215_16 = math.max(var_215_7, arg_212_1.talkMaxDuration)

			if var_215_6 <= arg_212_1.time_ and arg_212_1.time_ < var_215_6 + var_215_16 then
				arg_212_1.typewritter.percent = (arg_212_1.time_ - var_215_6) / var_215_16

				arg_212_1.typewritter:SetDirty()
			end

			if arg_212_1.time_ >= var_215_6 + var_215_16 and arg_212_1.time_ < var_215_6 + var_215_16 + arg_215_0 then
				arg_212_1.typewritter.percent = 1

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(true)
			end
		end

		arg_212_1.nodeConfigList_ = {}

		arg_212_1:InitPlayNodeList()
	end,
	Play324572052 = function(arg_216_0, arg_216_1)
		arg_216_1.time_ = 0
		arg_216_1.frameCnt_ = 0
		arg_216_1.state_ = "playing"
		arg_216_1.curTalkId_ = 324572052
		arg_216_1.duration_ = 5

		SetActive(arg_216_1.tipsGo_, false)

		function arg_216_1.onSingleLineFinish_()
			arg_216_1.onSingleLineUpdate_ = nil
			arg_216_1.onSingleLineFinish_ = nil
			arg_216_1.state_ = "waiting"
		end

		function arg_216_1.playNext_(arg_218_0)
			if arg_218_0 == 1 then
				arg_216_0:Play324572053(arg_216_1)
			end
		end

		function arg_216_1.onSingleLineUpdate_(arg_219_0)
			local var_219_0 = arg_216_1.actors_["10170ui_story"]
			local var_219_1 = 0

			if var_219_1 < arg_216_1.time_ and arg_216_1.time_ <= var_219_1 + arg_219_0 and not isNil(var_219_0) and arg_216_1.var_.characterEffect10170ui_story == nil then
				arg_216_1.var_.characterEffect10170ui_story = var_219_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_219_2 = 0.200000002980232

			if var_219_1 <= arg_216_1.time_ and arg_216_1.time_ < var_219_1 + var_219_2 and not isNil(var_219_0) then
				local var_219_3 = (arg_216_1.time_ - var_219_1) / var_219_2

				if arg_216_1.var_.characterEffect10170ui_story and not isNil(var_219_0) then
					local var_219_4 = Mathf.Lerp(0, 0.5, var_219_3)

					arg_216_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_216_1.var_.characterEffect10170ui_story.fillRatio = var_219_4
				end
			end

			if arg_216_1.time_ >= var_219_1 + var_219_2 and arg_216_1.time_ < var_219_1 + var_219_2 + arg_219_0 and not isNil(var_219_0) and arg_216_1.var_.characterEffect10170ui_story then
				local var_219_5 = 0.5

				arg_216_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_216_1.var_.characterEffect10170ui_story.fillRatio = var_219_5
			end

			local var_219_6 = 0
			local var_219_7 = 1.05

			if var_219_6 < arg_216_1.time_ and arg_216_1.time_ <= var_219_6 + arg_219_0 then
				arg_216_1.talkMaxDuration = 0
				arg_216_1.dialogCg_.alpha = 1

				arg_216_1.dialog_:SetActive(true)
				SetActive(arg_216_1.leftNameGo_, false)

				arg_216_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_216_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_216_1:RecordName(arg_216_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_216_1.iconTrs_.gameObject, false)
				arg_216_1.callingController_:SetSelectedState("normal")

				local var_219_8 = arg_216_1:GetWordFromCfg(324572052)
				local var_219_9 = arg_216_1:FormatText(var_219_8.content)

				arg_216_1.text_.text = var_219_9

				LuaForUtil.ClearLinePrefixSymbol(arg_216_1.text_)

				local var_219_10 = 42
				local var_219_11 = utf8.len(var_219_9)
				local var_219_12 = var_219_10 <= 0 and var_219_7 or var_219_7 * (var_219_11 / var_219_10)

				if var_219_12 > 0 and var_219_7 < var_219_12 then
					arg_216_1.talkMaxDuration = var_219_12

					if var_219_12 + var_219_6 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_12 + var_219_6
					end
				end

				arg_216_1.text_.text = var_219_9
				arg_216_1.typewritter.percent = 0

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(false)
				arg_216_1:RecordContent(arg_216_1.text_.text)
			end

			local var_219_13 = math.max(var_219_7, arg_216_1.talkMaxDuration)

			if var_219_6 <= arg_216_1.time_ and arg_216_1.time_ < var_219_6 + var_219_13 then
				arg_216_1.typewritter.percent = (arg_216_1.time_ - var_219_6) / var_219_13

				arg_216_1.typewritter:SetDirty()
			end

			if arg_216_1.time_ >= var_219_6 + var_219_13 and arg_216_1.time_ < var_219_6 + var_219_13 + arg_219_0 then
				arg_216_1.typewritter.percent = 1

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(true)
			end
		end

		arg_216_1.nodeConfigList_ = {}

		arg_216_1:InitPlayNodeList()
	end,
	Play324572053 = function(arg_220_0, arg_220_1)
		arg_220_1.time_ = 0
		arg_220_1.frameCnt_ = 0
		arg_220_1.state_ = "playing"
		arg_220_1.curTalkId_ = 324572053
		arg_220_1.duration_ = 5

		SetActive(arg_220_1.tipsGo_, false)

		function arg_220_1.onSingleLineFinish_()
			arg_220_1.onSingleLineUpdate_ = nil
			arg_220_1.onSingleLineFinish_ = nil
			arg_220_1.state_ = "waiting"
		end

		function arg_220_1.playNext_(arg_222_0)
			if arg_222_0 == 1 then
				arg_220_0:Play324572054(arg_220_1)
			end
		end

		function arg_220_1.onSingleLineUpdate_(arg_223_0)
			local var_223_0 = arg_220_1.actors_["10170ui_story"].transform
			local var_223_1 = 0

			if var_223_1 < arg_220_1.time_ and arg_220_1.time_ <= var_223_1 + arg_223_0 then
				arg_220_1.var_.moveOldPos10170ui_story = var_223_0.localPosition

				local var_223_2 = GameObjectTools.GetOrAddComponent(var_223_0.gameObject, typeof(DynamicBoneHelper))

				if var_223_2 then
					var_223_2:EnableDynamicBone(false)
				end
			end

			local var_223_3 = 0.001

			if var_223_1 <= arg_220_1.time_ and arg_220_1.time_ < var_223_1 + var_223_3 then
				local var_223_4 = (arg_220_1.time_ - var_223_1) / var_223_3
				local var_223_5 = Vector3.New(0, 100, 0)

				var_223_0.localPosition = Vector3.Lerp(arg_220_1.var_.moveOldPos10170ui_story, var_223_5, var_223_4)

				local var_223_6 = manager.ui.mainCamera.transform.position - var_223_0.position

				var_223_0.forward = Vector3.New(var_223_6.x, var_223_6.y, var_223_6.z)

				local var_223_7 = var_223_0.localEulerAngles

				var_223_7.z = 0
				var_223_7.x = 0
				var_223_0.localEulerAngles = var_223_7
			end

			if arg_220_1.time_ >= var_223_1 + var_223_3 and arg_220_1.time_ < var_223_1 + var_223_3 + arg_223_0 then
				var_223_0.localPosition = Vector3.New(0, 100, 0)

				local var_223_8 = manager.ui.mainCamera.transform.position - var_223_0.position

				var_223_0.forward = Vector3.New(var_223_8.x, var_223_8.y, var_223_8.z)

				local var_223_9 = var_223_0.localEulerAngles

				var_223_9.z = 0
				var_223_9.x = 0
				var_223_0.localEulerAngles = var_223_9

				local var_223_10 = GameObjectTools.GetOrAddComponent(var_223_0.gameObject, typeof(DynamicBoneHelper))

				if var_223_10 then
					var_223_10:EnableDynamicBone(true)
				end
			end

			local var_223_11 = 0
			local var_223_12 = 1.4

			if var_223_11 < arg_220_1.time_ and arg_220_1.time_ <= var_223_11 + arg_223_0 then
				arg_220_1.talkMaxDuration = 0
				arg_220_1.dialogCg_.alpha = 1

				arg_220_1.dialog_:SetActive(true)
				SetActive(arg_220_1.leftNameGo_, false)

				arg_220_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_220_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_220_1:RecordName(arg_220_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_220_1.iconTrs_.gameObject, false)
				arg_220_1.callingController_:SetSelectedState("normal")

				local var_223_13 = arg_220_1:GetWordFromCfg(324572053)
				local var_223_14 = arg_220_1:FormatText(var_223_13.content)

				arg_220_1.text_.text = var_223_14

				LuaForUtil.ClearLinePrefixSymbol(arg_220_1.text_)

				local var_223_15 = 56
				local var_223_16 = utf8.len(var_223_14)
				local var_223_17 = var_223_15 <= 0 and var_223_12 or var_223_12 * (var_223_16 / var_223_15)

				if var_223_17 > 0 and var_223_12 < var_223_17 then
					arg_220_1.talkMaxDuration = var_223_17

					if var_223_17 + var_223_11 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_17 + var_223_11
					end
				end

				arg_220_1.text_.text = var_223_14
				arg_220_1.typewritter.percent = 0

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(false)
				arg_220_1:RecordContent(arg_220_1.text_.text)
			end

			local var_223_18 = math.max(var_223_12, arg_220_1.talkMaxDuration)

			if var_223_11 <= arg_220_1.time_ and arg_220_1.time_ < var_223_11 + var_223_18 then
				arg_220_1.typewritter.percent = (arg_220_1.time_ - var_223_11) / var_223_18

				arg_220_1.typewritter:SetDirty()
			end

			if arg_220_1.time_ >= var_223_11 + var_223_18 and arg_220_1.time_ < var_223_11 + var_223_18 + arg_223_0 then
				arg_220_1.typewritter.percent = 1

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(true)
			end
		end

		arg_220_1.nodeConfigList_ = {
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

		arg_220_1:InitPlayNodeList()
	end,
	Play324572054 = function(arg_224_0, arg_224_1)
		arg_224_1.time_ = 0
		arg_224_1.frameCnt_ = 0
		arg_224_1.state_ = "playing"
		arg_224_1.curTalkId_ = 324572054
		arg_224_1.duration_ = 5.1

		SetActive(arg_224_1.tipsGo_, false)

		function arg_224_1.onSingleLineFinish_()
			arg_224_1.onSingleLineUpdate_ = nil
			arg_224_1.onSingleLineFinish_ = nil
			arg_224_1.state_ = "waiting"
		end

		function arg_224_1.playNext_(arg_226_0)
			if arg_226_0 == 1 then
				arg_224_0:Play324572055(arg_224_1)
			end
		end

		function arg_224_1.onSingleLineUpdate_(arg_227_0)
			local var_227_0 = arg_224_1.actors_["10170ui_story"]
			local var_227_1 = 0

			if var_227_1 < arg_224_1.time_ and arg_224_1.time_ <= var_227_1 + arg_227_0 and not isNil(var_227_0) and arg_224_1.var_.characterEffect10170ui_story == nil then
				arg_224_1.var_.characterEffect10170ui_story = var_227_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_227_2 = 0.200000002980232

			if var_227_1 <= arg_224_1.time_ and arg_224_1.time_ < var_227_1 + var_227_2 and not isNil(var_227_0) then
				local var_227_3 = (arg_224_1.time_ - var_227_1) / var_227_2

				if arg_224_1.var_.characterEffect10170ui_story and not isNil(var_227_0) then
					arg_224_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_224_1.time_ >= var_227_1 + var_227_2 and arg_224_1.time_ < var_227_1 + var_227_2 + arg_227_0 and not isNil(var_227_0) and arg_224_1.var_.characterEffect10170ui_story then
				arg_224_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			local var_227_4 = 0

			if var_227_4 < arg_224_1.time_ and arg_224_1.time_ <= var_227_4 + arg_227_0 then
				arg_224_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/story10170/story10170action/10170action1_1")
			end

			local var_227_5 = 0

			if var_227_5 < arg_224_1.time_ and arg_224_1.time_ <= var_227_5 + arg_227_0 then
				arg_224_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_227_6 = arg_224_1.actors_["10170ui_story"].transform
			local var_227_7 = 0

			if var_227_7 < arg_224_1.time_ and arg_224_1.time_ <= var_227_7 + arg_227_0 then
				arg_224_1.var_.moveOldPos10170ui_story = var_227_6.localPosition

				local var_227_8 = GameObjectTools.GetOrAddComponent(var_227_6.gameObject, typeof(DynamicBoneHelper))

				if var_227_8 then
					var_227_8:EnableDynamicBone(false)
				end
			end

			local var_227_9 = 0.001

			if var_227_7 <= arg_224_1.time_ and arg_224_1.time_ < var_227_7 + var_227_9 then
				local var_227_10 = (arg_224_1.time_ - var_227_7) / var_227_9
				local var_227_11 = Vector3.New(0, -1.03, -6.05)

				var_227_6.localPosition = Vector3.Lerp(arg_224_1.var_.moveOldPos10170ui_story, var_227_11, var_227_10)

				local var_227_12 = manager.ui.mainCamera.transform.position - var_227_6.position

				var_227_6.forward = Vector3.New(var_227_12.x, var_227_12.y, var_227_12.z)

				local var_227_13 = var_227_6.localEulerAngles

				var_227_13.z = 0
				var_227_13.x = 0
				var_227_6.localEulerAngles = var_227_13
			end

			if arg_224_1.time_ >= var_227_7 + var_227_9 and arg_224_1.time_ < var_227_7 + var_227_9 + arg_227_0 then
				var_227_6.localPosition = Vector3.New(0, -1.03, -6.05)

				local var_227_14 = manager.ui.mainCamera.transform.position - var_227_6.position

				var_227_6.forward = Vector3.New(var_227_14.x, var_227_14.y, var_227_14.z)

				local var_227_15 = var_227_6.localEulerAngles

				var_227_15.z = 0
				var_227_15.x = 0
				var_227_6.localEulerAngles = var_227_15

				local var_227_16 = GameObjectTools.GetOrAddComponent(var_227_6.gameObject, typeof(DynamicBoneHelper))

				if var_227_16 then
					var_227_16:EnableDynamicBone(true)
				end
			end

			local var_227_17 = 0
			local var_227_18 = 0.625

			if var_227_17 < arg_224_1.time_ and arg_224_1.time_ <= var_227_17 + arg_227_0 then
				arg_224_1.talkMaxDuration = 0
				arg_224_1.dialogCg_.alpha = 1

				arg_224_1.dialog_:SetActive(true)
				SetActive(arg_224_1.leftNameGo_, true)

				local var_227_19 = arg_224_1:FormatText(StoryNameCfg[1450].name)

				arg_224_1.leftNameTxt_.text = var_227_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_224_1.leftNameTxt_.transform)

				arg_224_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_224_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_224_1:RecordName(arg_224_1.leftNameTxt_.text)
				SetActive(arg_224_1.iconTrs_.gameObject, false)
				arg_224_1.callingController_:SetSelectedState("normal")

				local var_227_20 = arg_224_1:GetWordFromCfg(324572054)
				local var_227_21 = arg_224_1:FormatText(var_227_20.content)

				arg_224_1.text_.text = var_227_21

				LuaForUtil.ClearLinePrefixSymbol(arg_224_1.text_)

				local var_227_22 = 25
				local var_227_23 = utf8.len(var_227_21)
				local var_227_24 = var_227_22 <= 0 and var_227_18 or var_227_18 * (var_227_23 / var_227_22)

				if var_227_24 > 0 and var_227_18 < var_227_24 then
					arg_224_1.talkMaxDuration = var_227_24

					if var_227_24 + var_227_17 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_24 + var_227_17
					end
				end

				arg_224_1.text_.text = var_227_21
				arg_224_1.typewritter.percent = 0

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324572", "324572054", "story_v_out_324572.awb") ~= 0 then
					local var_227_25 = manager.audio:GetVoiceLength("story_v_out_324572", "324572054", "story_v_out_324572.awb") / 1000

					if var_227_25 + var_227_17 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_25 + var_227_17
					end

					if var_227_20.prefab_name ~= "" and arg_224_1.actors_[var_227_20.prefab_name] ~= nil then
						local var_227_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_224_1.actors_[var_227_20.prefab_name].transform, "story_v_out_324572", "324572054", "story_v_out_324572.awb")

						arg_224_1:RecordAudio("324572054", var_227_26)
						arg_224_1:RecordAudio("324572054", var_227_26)
					else
						arg_224_1:AudioAction("play", "voice", "story_v_out_324572", "324572054", "story_v_out_324572.awb")
					end

					arg_224_1:RecordHistoryTalkVoice("story_v_out_324572", "324572054", "story_v_out_324572.awb")
				end

				arg_224_1:RecordContent(arg_224_1.text_.text)
			end

			local var_227_27 = math.max(var_227_18, arg_224_1.talkMaxDuration)

			if var_227_17 <= arg_224_1.time_ and arg_224_1.time_ < var_227_17 + var_227_27 then
				arg_224_1.typewritter.percent = (arg_224_1.time_ - var_227_17) / var_227_27

				arg_224_1.typewritter:SetDirty()
			end

			if arg_224_1.time_ >= var_227_17 + var_227_27 and arg_224_1.time_ < var_227_17 + var_227_27 + arg_227_0 then
				arg_224_1.typewritter.percent = 1

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(true)
			end
		end

		arg_224_1.nodeConfigList_ = {
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

		arg_224_1:InitPlayNodeList()
	end,
	Play324572055 = function(arg_228_0, arg_228_1)
		arg_228_1.time_ = 0
		arg_228_1.frameCnt_ = 0
		arg_228_1.state_ = "playing"
		arg_228_1.curTalkId_ = 324572055
		arg_228_1.duration_ = 5

		SetActive(arg_228_1.tipsGo_, false)

		function arg_228_1.onSingleLineFinish_()
			arg_228_1.onSingleLineUpdate_ = nil
			arg_228_1.onSingleLineFinish_ = nil
			arg_228_1.state_ = "waiting"
		end

		function arg_228_1.playNext_(arg_230_0)
			if arg_230_0 == 1 then
				arg_228_0:Play324572056(arg_228_1)
			end
		end

		function arg_228_1.onSingleLineUpdate_(arg_231_0)
			local var_231_0 = arg_228_1.actors_["10170ui_story"]
			local var_231_1 = 0

			if var_231_1 < arg_228_1.time_ and arg_228_1.time_ <= var_231_1 + arg_231_0 and not isNil(var_231_0) and arg_228_1.var_.characterEffect10170ui_story == nil then
				arg_228_1.var_.characterEffect10170ui_story = var_231_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_231_2 = 0.200000002980232

			if var_231_1 <= arg_228_1.time_ and arg_228_1.time_ < var_231_1 + var_231_2 and not isNil(var_231_0) then
				local var_231_3 = (arg_228_1.time_ - var_231_1) / var_231_2

				if arg_228_1.var_.characterEffect10170ui_story and not isNil(var_231_0) then
					local var_231_4 = Mathf.Lerp(0, 0.5, var_231_3)

					arg_228_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_228_1.var_.characterEffect10170ui_story.fillRatio = var_231_4
				end
			end

			if arg_228_1.time_ >= var_231_1 + var_231_2 and arg_228_1.time_ < var_231_1 + var_231_2 + arg_231_0 and not isNil(var_231_0) and arg_228_1.var_.characterEffect10170ui_story then
				local var_231_5 = 0.5

				arg_228_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_228_1.var_.characterEffect10170ui_story.fillRatio = var_231_5
			end

			local var_231_6 = 0
			local var_231_7 = 0.35

			if var_231_6 < arg_228_1.time_ and arg_228_1.time_ <= var_231_6 + arg_231_0 then
				arg_228_1.talkMaxDuration = 0
				arg_228_1.dialogCg_.alpha = 1

				arg_228_1.dialog_:SetActive(true)
				SetActive(arg_228_1.leftNameGo_, true)

				local var_231_8 = arg_228_1:FormatText(StoryNameCfg[7].name)

				arg_228_1.leftNameTxt_.text = var_231_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_228_1.leftNameTxt_.transform)

				arg_228_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_228_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_228_1:RecordName(arg_228_1.leftNameTxt_.text)
				SetActive(arg_228_1.iconTrs_.gameObject, true)
				arg_228_1.iconController_:SetSelectedState("hero")

				arg_228_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_228_1.callingController_:SetSelectedState("normal")

				arg_228_1.keyicon_.color = Color.New(1, 1, 1)
				arg_228_1.icon_.color = Color.New(1, 1, 1)

				local var_231_9 = arg_228_1:GetWordFromCfg(324572055)
				local var_231_10 = arg_228_1:FormatText(var_231_9.content)

				arg_228_1.text_.text = var_231_10

				LuaForUtil.ClearLinePrefixSymbol(arg_228_1.text_)

				local var_231_11 = 14
				local var_231_12 = utf8.len(var_231_10)
				local var_231_13 = var_231_11 <= 0 and var_231_7 or var_231_7 * (var_231_12 / var_231_11)

				if var_231_13 > 0 and var_231_7 < var_231_13 then
					arg_228_1.talkMaxDuration = var_231_13

					if var_231_13 + var_231_6 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_13 + var_231_6
					end
				end

				arg_228_1.text_.text = var_231_10
				arg_228_1.typewritter.percent = 0

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(false)
				arg_228_1:RecordContent(arg_228_1.text_.text)
			end

			local var_231_14 = math.max(var_231_7, arg_228_1.talkMaxDuration)

			if var_231_6 <= arg_228_1.time_ and arg_228_1.time_ < var_231_6 + var_231_14 then
				arg_228_1.typewritter.percent = (arg_228_1.time_ - var_231_6) / var_231_14

				arg_228_1.typewritter:SetDirty()
			end

			if arg_228_1.time_ >= var_231_6 + var_231_14 and arg_228_1.time_ < var_231_6 + var_231_14 + arg_231_0 then
				arg_228_1.typewritter.percent = 1

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(true)
			end
		end

		arg_228_1.nodeConfigList_ = {}

		arg_228_1:InitPlayNodeList()
	end,
	Play324572056 = function(arg_232_0, arg_232_1)
		arg_232_1.time_ = 0
		arg_232_1.frameCnt_ = 0
		arg_232_1.state_ = "playing"
		arg_232_1.curTalkId_ = 324572056
		arg_232_1.duration_ = 3.9

		SetActive(arg_232_1.tipsGo_, false)

		function arg_232_1.onSingleLineFinish_()
			arg_232_1.onSingleLineUpdate_ = nil
			arg_232_1.onSingleLineFinish_ = nil
			arg_232_1.state_ = "waiting"
		end

		function arg_232_1.playNext_(arg_234_0)
			if arg_234_0 == 1 then
				arg_232_0:Play324572057(arg_232_1)
			end
		end

		function arg_232_1.onSingleLineUpdate_(arg_235_0)
			local var_235_0 = arg_232_1.actors_["10170ui_story"].transform
			local var_235_1 = 0

			if var_235_1 < arg_232_1.time_ and arg_232_1.time_ <= var_235_1 + arg_235_0 then
				arg_232_1.var_.moveOldPos10170ui_story = var_235_0.localPosition

				local var_235_2 = GameObjectTools.GetOrAddComponent(var_235_0.gameObject, typeof(DynamicBoneHelper))

				if var_235_2 then
					var_235_2:EnableDynamicBone(false)
				end
			end

			local var_235_3 = 0.001

			if var_235_1 <= arg_232_1.time_ and arg_232_1.time_ < var_235_1 + var_235_3 then
				local var_235_4 = (arg_232_1.time_ - var_235_1) / var_235_3
				local var_235_5 = Vector3.New(0, -1.03, -6.05)

				var_235_0.localPosition = Vector3.Lerp(arg_232_1.var_.moveOldPos10170ui_story, var_235_5, var_235_4)

				local var_235_6 = manager.ui.mainCamera.transform.position - var_235_0.position

				var_235_0.forward = Vector3.New(var_235_6.x, var_235_6.y, var_235_6.z)

				local var_235_7 = var_235_0.localEulerAngles

				var_235_7.z = 0
				var_235_7.x = 0
				var_235_0.localEulerAngles = var_235_7
			end

			if arg_232_1.time_ >= var_235_1 + var_235_3 and arg_232_1.time_ < var_235_1 + var_235_3 + arg_235_0 then
				var_235_0.localPosition = Vector3.New(0, -1.03, -6.05)

				local var_235_8 = manager.ui.mainCamera.transform.position - var_235_0.position

				var_235_0.forward = Vector3.New(var_235_8.x, var_235_8.y, var_235_8.z)

				local var_235_9 = var_235_0.localEulerAngles

				var_235_9.z = 0
				var_235_9.x = 0
				var_235_0.localEulerAngles = var_235_9

				local var_235_10 = GameObjectTools.GetOrAddComponent(var_235_0.gameObject, typeof(DynamicBoneHelper))

				if var_235_10 then
					var_235_10:EnableDynamicBone(true)
				end
			end

			local var_235_11 = arg_232_1.actors_["10170ui_story"]
			local var_235_12 = 0

			if var_235_12 < arg_232_1.time_ and arg_232_1.time_ <= var_235_12 + arg_235_0 and not isNil(var_235_11) and arg_232_1.var_.characterEffect10170ui_story == nil then
				arg_232_1.var_.characterEffect10170ui_story = var_235_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_235_13 = 0.200000002980232

			if var_235_12 <= arg_232_1.time_ and arg_232_1.time_ < var_235_12 + var_235_13 and not isNil(var_235_11) then
				local var_235_14 = (arg_232_1.time_ - var_235_12) / var_235_13

				if arg_232_1.var_.characterEffect10170ui_story and not isNil(var_235_11) then
					arg_232_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_232_1.time_ >= var_235_12 + var_235_13 and arg_232_1.time_ < var_235_12 + var_235_13 + arg_235_0 and not isNil(var_235_11) and arg_232_1.var_.characterEffect10170ui_story then
				arg_232_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			local var_235_15 = 0

			if var_235_15 < arg_232_1.time_ and arg_232_1.time_ <= var_235_15 + arg_235_0 then
				arg_232_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			local var_235_16 = 0
			local var_235_17 = 0.35

			if var_235_16 < arg_232_1.time_ and arg_232_1.time_ <= var_235_16 + arg_235_0 then
				arg_232_1.talkMaxDuration = 0
				arg_232_1.dialogCg_.alpha = 1

				arg_232_1.dialog_:SetActive(true)
				SetActive(arg_232_1.leftNameGo_, true)

				local var_235_18 = arg_232_1:FormatText(StoryNameCfg[1450].name)

				arg_232_1.leftNameTxt_.text = var_235_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_232_1.leftNameTxt_.transform)

				arg_232_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_232_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_232_1:RecordName(arg_232_1.leftNameTxt_.text)
				SetActive(arg_232_1.iconTrs_.gameObject, false)
				arg_232_1.callingController_:SetSelectedState("normal")

				local var_235_19 = arg_232_1:GetWordFromCfg(324572056)
				local var_235_20 = arg_232_1:FormatText(var_235_19.content)

				arg_232_1.text_.text = var_235_20

				LuaForUtil.ClearLinePrefixSymbol(arg_232_1.text_)

				local var_235_21 = 14
				local var_235_22 = utf8.len(var_235_20)
				local var_235_23 = var_235_21 <= 0 and var_235_17 or var_235_17 * (var_235_22 / var_235_21)

				if var_235_23 > 0 and var_235_17 < var_235_23 then
					arg_232_1.talkMaxDuration = var_235_23

					if var_235_23 + var_235_16 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_23 + var_235_16
					end
				end

				arg_232_1.text_.text = var_235_20
				arg_232_1.typewritter.percent = 0

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324572", "324572056", "story_v_out_324572.awb") ~= 0 then
					local var_235_24 = manager.audio:GetVoiceLength("story_v_out_324572", "324572056", "story_v_out_324572.awb") / 1000

					if var_235_24 + var_235_16 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_24 + var_235_16
					end

					if var_235_19.prefab_name ~= "" and arg_232_1.actors_[var_235_19.prefab_name] ~= nil then
						local var_235_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_232_1.actors_[var_235_19.prefab_name].transform, "story_v_out_324572", "324572056", "story_v_out_324572.awb")

						arg_232_1:RecordAudio("324572056", var_235_25)
						arg_232_1:RecordAudio("324572056", var_235_25)
					else
						arg_232_1:AudioAction("play", "voice", "story_v_out_324572", "324572056", "story_v_out_324572.awb")
					end

					arg_232_1:RecordHistoryTalkVoice("story_v_out_324572", "324572056", "story_v_out_324572.awb")
				end

				arg_232_1:RecordContent(arg_232_1.text_.text)
			end

			local var_235_26 = math.max(var_235_17, arg_232_1.talkMaxDuration)

			if var_235_16 <= arg_232_1.time_ and arg_232_1.time_ < var_235_16 + var_235_26 then
				arg_232_1.typewritter.percent = (arg_232_1.time_ - var_235_16) / var_235_26

				arg_232_1.typewritter:SetDirty()
			end

			if arg_232_1.time_ >= var_235_16 + var_235_26 and arg_232_1.time_ < var_235_16 + var_235_26 + arg_235_0 then
				arg_232_1.typewritter.percent = 1

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(true)
			end
		end

		arg_232_1.nodeConfigList_ = {
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

		arg_232_1:InitPlayNodeList()
	end,
	Play324572057 = function(arg_236_0, arg_236_1)
		arg_236_1.time_ = 0
		arg_236_1.frameCnt_ = 0
		arg_236_1.state_ = "playing"
		arg_236_1.curTalkId_ = 324572057
		arg_236_1.duration_ = 5

		SetActive(arg_236_1.tipsGo_, false)

		function arg_236_1.onSingleLineFinish_()
			arg_236_1.onSingleLineUpdate_ = nil
			arg_236_1.onSingleLineFinish_ = nil
			arg_236_1.state_ = "waiting"
		end

		function arg_236_1.playNext_(arg_238_0)
			if arg_238_0 == 1 then
				arg_236_0:Play324572058(arg_236_1)
			end
		end

		function arg_236_1.onSingleLineUpdate_(arg_239_0)
			local var_239_0 = arg_236_1.actors_["10170ui_story"]
			local var_239_1 = 0

			if var_239_1 < arg_236_1.time_ and arg_236_1.time_ <= var_239_1 + arg_239_0 and not isNil(var_239_0) and arg_236_1.var_.characterEffect10170ui_story == nil then
				arg_236_1.var_.characterEffect10170ui_story = var_239_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_239_2 = 0.200000002980232

			if var_239_1 <= arg_236_1.time_ and arg_236_1.time_ < var_239_1 + var_239_2 and not isNil(var_239_0) then
				local var_239_3 = (arg_236_1.time_ - var_239_1) / var_239_2

				if arg_236_1.var_.characterEffect10170ui_story and not isNil(var_239_0) then
					local var_239_4 = Mathf.Lerp(0, 0.5, var_239_3)

					arg_236_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_236_1.var_.characterEffect10170ui_story.fillRatio = var_239_4
				end
			end

			if arg_236_1.time_ >= var_239_1 + var_239_2 and arg_236_1.time_ < var_239_1 + var_239_2 + arg_239_0 and not isNil(var_239_0) and arg_236_1.var_.characterEffect10170ui_story then
				local var_239_5 = 0.5

				arg_236_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_236_1.var_.characterEffect10170ui_story.fillRatio = var_239_5
			end

			local var_239_6 = 0
			local var_239_7 = 0.3

			if var_239_6 < arg_236_1.time_ and arg_236_1.time_ <= var_239_6 + arg_239_0 then
				arg_236_1.talkMaxDuration = 0
				arg_236_1.dialogCg_.alpha = 1

				arg_236_1.dialog_:SetActive(true)
				SetActive(arg_236_1.leftNameGo_, true)

				local var_239_8 = arg_236_1:FormatText(StoryNameCfg[7].name)

				arg_236_1.leftNameTxt_.text = var_239_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_236_1.leftNameTxt_.transform)

				arg_236_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_236_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_236_1:RecordName(arg_236_1.leftNameTxt_.text)
				SetActive(arg_236_1.iconTrs_.gameObject, true)
				arg_236_1.iconController_:SetSelectedState("hero")

				arg_236_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_236_1.callingController_:SetSelectedState("normal")

				arg_236_1.keyicon_.color = Color.New(1, 1, 1)
				arg_236_1.icon_.color = Color.New(1, 1, 1)

				local var_239_9 = arg_236_1:GetWordFromCfg(324572057)
				local var_239_10 = arg_236_1:FormatText(var_239_9.content)

				arg_236_1.text_.text = var_239_10

				LuaForUtil.ClearLinePrefixSymbol(arg_236_1.text_)

				local var_239_11 = 12
				local var_239_12 = utf8.len(var_239_10)
				local var_239_13 = var_239_11 <= 0 and var_239_7 or var_239_7 * (var_239_12 / var_239_11)

				if var_239_13 > 0 and var_239_7 < var_239_13 then
					arg_236_1.talkMaxDuration = var_239_13

					if var_239_13 + var_239_6 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_13 + var_239_6
					end
				end

				arg_236_1.text_.text = var_239_10
				arg_236_1.typewritter.percent = 0

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(false)
				arg_236_1:RecordContent(arg_236_1.text_.text)
			end

			local var_239_14 = math.max(var_239_7, arg_236_1.talkMaxDuration)

			if var_239_6 <= arg_236_1.time_ and arg_236_1.time_ < var_239_6 + var_239_14 then
				arg_236_1.typewritter.percent = (arg_236_1.time_ - var_239_6) / var_239_14

				arg_236_1.typewritter:SetDirty()
			end

			if arg_236_1.time_ >= var_239_6 + var_239_14 and arg_236_1.time_ < var_239_6 + var_239_14 + arg_239_0 then
				arg_236_1.typewritter.percent = 1

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(true)
			end
		end

		arg_236_1.nodeConfigList_ = {}

		arg_236_1:InitPlayNodeList()
	end,
	Play324572058 = function(arg_240_0, arg_240_1)
		arg_240_1.time_ = 0
		arg_240_1.frameCnt_ = 0
		arg_240_1.state_ = "playing"
		arg_240_1.curTalkId_ = 324572058
		arg_240_1.duration_ = 8.7

		SetActive(arg_240_1.tipsGo_, false)

		function arg_240_1.onSingleLineFinish_()
			arg_240_1.onSingleLineUpdate_ = nil
			arg_240_1.onSingleLineFinish_ = nil
			arg_240_1.state_ = "waiting"
		end

		function arg_240_1.playNext_(arg_242_0)
			if arg_242_0 == 1 then
				arg_240_0:Play324572059(arg_240_1)
			end
		end

		function arg_240_1.onSingleLineUpdate_(arg_243_0)
			local var_243_0 = arg_240_1.actors_["10170ui_story"]
			local var_243_1 = 0

			if var_243_1 < arg_240_1.time_ and arg_240_1.time_ <= var_243_1 + arg_243_0 and not isNil(var_243_0) and arg_240_1.var_.characterEffect10170ui_story == nil then
				arg_240_1.var_.characterEffect10170ui_story = var_243_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_243_2 = 0.200000002980232

			if var_243_1 <= arg_240_1.time_ and arg_240_1.time_ < var_243_1 + var_243_2 and not isNil(var_243_0) then
				local var_243_3 = (arg_240_1.time_ - var_243_1) / var_243_2

				if arg_240_1.var_.characterEffect10170ui_story and not isNil(var_243_0) then
					arg_240_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_240_1.time_ >= var_243_1 + var_243_2 and arg_240_1.time_ < var_243_1 + var_243_2 + arg_243_0 and not isNil(var_243_0) and arg_240_1.var_.characterEffect10170ui_story then
				arg_240_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			local var_243_4 = 0
			local var_243_5 = 0.9

			if var_243_4 < arg_240_1.time_ and arg_240_1.time_ <= var_243_4 + arg_243_0 then
				arg_240_1.talkMaxDuration = 0
				arg_240_1.dialogCg_.alpha = 1

				arg_240_1.dialog_:SetActive(true)
				SetActive(arg_240_1.leftNameGo_, true)

				local var_243_6 = arg_240_1:FormatText(StoryNameCfg[1450].name)

				arg_240_1.leftNameTxt_.text = var_243_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_240_1.leftNameTxt_.transform)

				arg_240_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_240_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_240_1:RecordName(arg_240_1.leftNameTxt_.text)
				SetActive(arg_240_1.iconTrs_.gameObject, false)
				arg_240_1.callingController_:SetSelectedState("normal")

				local var_243_7 = arg_240_1:GetWordFromCfg(324572058)
				local var_243_8 = arg_240_1:FormatText(var_243_7.content)

				arg_240_1.text_.text = var_243_8

				LuaForUtil.ClearLinePrefixSymbol(arg_240_1.text_)

				local var_243_9 = 36
				local var_243_10 = utf8.len(var_243_8)
				local var_243_11 = var_243_9 <= 0 and var_243_5 or var_243_5 * (var_243_10 / var_243_9)

				if var_243_11 > 0 and var_243_5 < var_243_11 then
					arg_240_1.talkMaxDuration = var_243_11

					if var_243_11 + var_243_4 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_11 + var_243_4
					end
				end

				arg_240_1.text_.text = var_243_8
				arg_240_1.typewritter.percent = 0

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324572", "324572058", "story_v_out_324572.awb") ~= 0 then
					local var_243_12 = manager.audio:GetVoiceLength("story_v_out_324572", "324572058", "story_v_out_324572.awb") / 1000

					if var_243_12 + var_243_4 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_12 + var_243_4
					end

					if var_243_7.prefab_name ~= "" and arg_240_1.actors_[var_243_7.prefab_name] ~= nil then
						local var_243_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_240_1.actors_[var_243_7.prefab_name].transform, "story_v_out_324572", "324572058", "story_v_out_324572.awb")

						arg_240_1:RecordAudio("324572058", var_243_13)
						arg_240_1:RecordAudio("324572058", var_243_13)
					else
						arg_240_1:AudioAction("play", "voice", "story_v_out_324572", "324572058", "story_v_out_324572.awb")
					end

					arg_240_1:RecordHistoryTalkVoice("story_v_out_324572", "324572058", "story_v_out_324572.awb")
				end

				arg_240_1:RecordContent(arg_240_1.text_.text)
			end

			local var_243_14 = math.max(var_243_5, arg_240_1.talkMaxDuration)

			if var_243_4 <= arg_240_1.time_ and arg_240_1.time_ < var_243_4 + var_243_14 then
				arg_240_1.typewritter.percent = (arg_240_1.time_ - var_243_4) / var_243_14

				arg_240_1.typewritter:SetDirty()
			end

			if arg_240_1.time_ >= var_243_4 + var_243_14 and arg_240_1.time_ < var_243_4 + var_243_14 + arg_243_0 then
				arg_240_1.typewritter.percent = 1

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(true)
			end
		end

		arg_240_1.nodeConfigList_ = {}

		arg_240_1:InitPlayNodeList()
	end,
	Play324572059 = function(arg_244_0, arg_244_1)
		arg_244_1.time_ = 0
		arg_244_1.frameCnt_ = 0
		arg_244_1.state_ = "playing"
		arg_244_1.curTalkId_ = 324572059
		arg_244_1.duration_ = 5

		SetActive(arg_244_1.tipsGo_, false)

		function arg_244_1.onSingleLineFinish_()
			arg_244_1.onSingleLineUpdate_ = nil
			arg_244_1.onSingleLineFinish_ = nil
			arg_244_1.state_ = "waiting"
		end

		function arg_244_1.playNext_(arg_246_0)
			if arg_246_0 == 1 then
				arg_244_0:Play324572060(arg_244_1)
			end
		end

		function arg_244_1.onSingleLineUpdate_(arg_247_0)
			local var_247_0 = arg_244_1.actors_["10170ui_story"]
			local var_247_1 = 0

			if var_247_1 < arg_244_1.time_ and arg_244_1.time_ <= var_247_1 + arg_247_0 and not isNil(var_247_0) and arg_244_1.var_.characterEffect10170ui_story == nil then
				arg_244_1.var_.characterEffect10170ui_story = var_247_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_247_2 = 0.200000002980232

			if var_247_1 <= arg_244_1.time_ and arg_244_1.time_ < var_247_1 + var_247_2 and not isNil(var_247_0) then
				local var_247_3 = (arg_244_1.time_ - var_247_1) / var_247_2

				if arg_244_1.var_.characterEffect10170ui_story and not isNil(var_247_0) then
					local var_247_4 = Mathf.Lerp(0, 0.5, var_247_3)

					arg_244_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_244_1.var_.characterEffect10170ui_story.fillRatio = var_247_4
				end
			end

			if arg_244_1.time_ >= var_247_1 + var_247_2 and arg_244_1.time_ < var_247_1 + var_247_2 + arg_247_0 and not isNil(var_247_0) and arg_244_1.var_.characterEffect10170ui_story then
				local var_247_5 = 0.5

				arg_244_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_244_1.var_.characterEffect10170ui_story.fillRatio = var_247_5
			end

			local var_247_6 = 0
			local var_247_7 = 0.25

			if var_247_6 < arg_244_1.time_ and arg_244_1.time_ <= var_247_6 + arg_247_0 then
				arg_244_1.talkMaxDuration = 0
				arg_244_1.dialogCg_.alpha = 1

				arg_244_1.dialog_:SetActive(true)
				SetActive(arg_244_1.leftNameGo_, true)

				local var_247_8 = arg_244_1:FormatText(StoryNameCfg[7].name)

				arg_244_1.leftNameTxt_.text = var_247_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_244_1.leftNameTxt_.transform)

				arg_244_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_244_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_244_1:RecordName(arg_244_1.leftNameTxt_.text)
				SetActive(arg_244_1.iconTrs_.gameObject, true)
				arg_244_1.iconController_:SetSelectedState("hero")

				arg_244_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_244_1.callingController_:SetSelectedState("normal")

				arg_244_1.keyicon_.color = Color.New(1, 1, 1)
				arg_244_1.icon_.color = Color.New(1, 1, 1)

				local var_247_9 = arg_244_1:GetWordFromCfg(324572059)
				local var_247_10 = arg_244_1:FormatText(var_247_9.content)

				arg_244_1.text_.text = var_247_10

				LuaForUtil.ClearLinePrefixSymbol(arg_244_1.text_)

				local var_247_11 = 10
				local var_247_12 = utf8.len(var_247_10)
				local var_247_13 = var_247_11 <= 0 and var_247_7 or var_247_7 * (var_247_12 / var_247_11)

				if var_247_13 > 0 and var_247_7 < var_247_13 then
					arg_244_1.talkMaxDuration = var_247_13

					if var_247_13 + var_247_6 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_13 + var_247_6
					end
				end

				arg_244_1.text_.text = var_247_10
				arg_244_1.typewritter.percent = 0

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(false)
				arg_244_1:RecordContent(arg_244_1.text_.text)
			end

			local var_247_14 = math.max(var_247_7, arg_244_1.talkMaxDuration)

			if var_247_6 <= arg_244_1.time_ and arg_244_1.time_ < var_247_6 + var_247_14 then
				arg_244_1.typewritter.percent = (arg_244_1.time_ - var_247_6) / var_247_14

				arg_244_1.typewritter:SetDirty()
			end

			if arg_244_1.time_ >= var_247_6 + var_247_14 and arg_244_1.time_ < var_247_6 + var_247_14 + arg_247_0 then
				arg_244_1.typewritter.percent = 1

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(true)
			end
		end

		arg_244_1.nodeConfigList_ = {}

		arg_244_1:InitPlayNodeList()
	end,
	Play324572060 = function(arg_248_0, arg_248_1)
		arg_248_1.time_ = 0
		arg_248_1.frameCnt_ = 0
		arg_248_1.state_ = "playing"
		arg_248_1.curTalkId_ = 324572060
		arg_248_1.duration_ = 5

		SetActive(arg_248_1.tipsGo_, false)

		function arg_248_1.onSingleLineFinish_()
			arg_248_1.onSingleLineUpdate_ = nil
			arg_248_1.onSingleLineFinish_ = nil
			arg_248_1.state_ = "waiting"
		end

		function arg_248_1.playNext_(arg_250_0)
			if arg_250_0 == 1 then
				arg_248_0:Play324572061(arg_248_1)
			end
		end

		function arg_248_1.onSingleLineUpdate_(arg_251_0)
			local var_251_0 = arg_248_1.actors_["10170ui_story"].transform
			local var_251_1 = 0

			if var_251_1 < arg_248_1.time_ and arg_248_1.time_ <= var_251_1 + arg_251_0 then
				arg_248_1.var_.moveOldPos10170ui_story = var_251_0.localPosition

				local var_251_2 = GameObjectTools.GetOrAddComponent(var_251_0.gameObject, typeof(DynamicBoneHelper))

				if var_251_2 then
					var_251_2:EnableDynamicBone(false)
				end
			end

			local var_251_3 = 0.001

			if var_251_1 <= arg_248_1.time_ and arg_248_1.time_ < var_251_1 + var_251_3 then
				local var_251_4 = (arg_248_1.time_ - var_251_1) / var_251_3
				local var_251_5 = Vector3.New(0, 100, 0)

				var_251_0.localPosition = Vector3.Lerp(arg_248_1.var_.moveOldPos10170ui_story, var_251_5, var_251_4)

				local var_251_6 = manager.ui.mainCamera.transform.position - var_251_0.position

				var_251_0.forward = Vector3.New(var_251_6.x, var_251_6.y, var_251_6.z)

				local var_251_7 = var_251_0.localEulerAngles

				var_251_7.z = 0
				var_251_7.x = 0
				var_251_0.localEulerAngles = var_251_7
			end

			if arg_248_1.time_ >= var_251_1 + var_251_3 and arg_248_1.time_ < var_251_1 + var_251_3 + arg_251_0 then
				var_251_0.localPosition = Vector3.New(0, 100, 0)

				local var_251_8 = manager.ui.mainCamera.transform.position - var_251_0.position

				var_251_0.forward = Vector3.New(var_251_8.x, var_251_8.y, var_251_8.z)

				local var_251_9 = var_251_0.localEulerAngles

				var_251_9.z = 0
				var_251_9.x = 0
				var_251_0.localEulerAngles = var_251_9

				local var_251_10 = GameObjectTools.GetOrAddComponent(var_251_0.gameObject, typeof(DynamicBoneHelper))

				if var_251_10 then
					var_251_10:EnableDynamicBone(true)
				end
			end

			local var_251_11 = 0.5
			local var_251_12 = 1

			if var_251_11 < arg_248_1.time_ and arg_248_1.time_ <= var_251_11 + arg_251_0 then
				local var_251_13 = "play"
				local var_251_14 = "effect"

				arg_248_1:AudioAction(var_251_13, var_251_14, "se_story_143", "se_story_143_footstep_sand", "")
			end

			local var_251_15 = 0
			local var_251_16 = 0.65

			if var_251_15 < arg_248_1.time_ and arg_248_1.time_ <= var_251_15 + arg_251_0 then
				arg_248_1.talkMaxDuration = 0
				arg_248_1.dialogCg_.alpha = 1

				arg_248_1.dialog_:SetActive(true)
				SetActive(arg_248_1.leftNameGo_, false)

				arg_248_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_248_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_248_1:RecordName(arg_248_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_248_1.iconTrs_.gameObject, false)
				arg_248_1.callingController_:SetSelectedState("normal")

				local var_251_17 = arg_248_1:GetWordFromCfg(324572060)
				local var_251_18 = arg_248_1:FormatText(var_251_17.content)

				arg_248_1.text_.text = var_251_18

				LuaForUtil.ClearLinePrefixSymbol(arg_248_1.text_)

				local var_251_19 = 26
				local var_251_20 = utf8.len(var_251_18)
				local var_251_21 = var_251_19 <= 0 and var_251_16 or var_251_16 * (var_251_20 / var_251_19)

				if var_251_21 > 0 and var_251_16 < var_251_21 then
					arg_248_1.talkMaxDuration = var_251_21

					if var_251_21 + var_251_15 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_21 + var_251_15
					end
				end

				arg_248_1.text_.text = var_251_18
				arg_248_1.typewritter.percent = 0

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(false)
				arg_248_1:RecordContent(arg_248_1.text_.text)
			end

			local var_251_22 = math.max(var_251_16, arg_248_1.talkMaxDuration)

			if var_251_15 <= arg_248_1.time_ and arg_248_1.time_ < var_251_15 + var_251_22 then
				arg_248_1.typewritter.percent = (arg_248_1.time_ - var_251_15) / var_251_22

				arg_248_1.typewritter:SetDirty()
			end

			if arg_248_1.time_ >= var_251_15 + var_251_22 and arg_248_1.time_ < var_251_15 + var_251_22 + arg_251_0 then
				arg_248_1.typewritter.percent = 1

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(true)
			end
		end

		arg_248_1.nodeConfigList_ = {
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

		arg_248_1:InitPlayNodeList()
	end,
	Play324572061 = function(arg_252_0, arg_252_1)
		arg_252_1.time_ = 0
		arg_252_1.frameCnt_ = 0
		arg_252_1.state_ = "playing"
		arg_252_1.curTalkId_ = 324572061
		arg_252_1.duration_ = 1.53

		SetActive(arg_252_1.tipsGo_, false)

		function arg_252_1.onSingleLineFinish_()
			arg_252_1.onSingleLineUpdate_ = nil
			arg_252_1.onSingleLineFinish_ = nil
			arg_252_1.state_ = "waiting"
		end

		function arg_252_1.playNext_(arg_254_0)
			if arg_254_0 == 1 then
				arg_252_0:Play324572062(arg_252_1)
			end
		end

		function arg_252_1.onSingleLineUpdate_(arg_255_0)
			local var_255_0 = arg_252_1.actors_["10170ui_story"].transform
			local var_255_1 = 0

			if var_255_1 < arg_252_1.time_ and arg_252_1.time_ <= var_255_1 + arg_255_0 then
				arg_252_1.var_.moveOldPos10170ui_story = var_255_0.localPosition

				local var_255_2 = GameObjectTools.GetOrAddComponent(var_255_0.gameObject, typeof(DynamicBoneHelper))

				if var_255_2 then
					var_255_2:EnableDynamicBone(false)
				end
			end

			local var_255_3 = 0.001

			if var_255_1 <= arg_252_1.time_ and arg_252_1.time_ < var_255_1 + var_255_3 then
				local var_255_4 = (arg_252_1.time_ - var_255_1) / var_255_3
				local var_255_5 = Vector3.New(0, -1.03, -6.05)

				var_255_0.localPosition = Vector3.Lerp(arg_252_1.var_.moveOldPos10170ui_story, var_255_5, var_255_4)

				local var_255_6 = manager.ui.mainCamera.transform.position - var_255_0.position

				var_255_0.forward = Vector3.New(var_255_6.x, var_255_6.y, var_255_6.z)

				local var_255_7 = var_255_0.localEulerAngles

				var_255_7.z = 0
				var_255_7.x = 0
				var_255_0.localEulerAngles = var_255_7
			end

			if arg_252_1.time_ >= var_255_1 + var_255_3 and arg_252_1.time_ < var_255_1 + var_255_3 + arg_255_0 then
				var_255_0.localPosition = Vector3.New(0, -1.03, -6.05)

				local var_255_8 = manager.ui.mainCamera.transform.position - var_255_0.position

				var_255_0.forward = Vector3.New(var_255_8.x, var_255_8.y, var_255_8.z)

				local var_255_9 = var_255_0.localEulerAngles

				var_255_9.z = 0
				var_255_9.x = 0
				var_255_0.localEulerAngles = var_255_9

				local var_255_10 = GameObjectTools.GetOrAddComponent(var_255_0.gameObject, typeof(DynamicBoneHelper))

				if var_255_10 then
					var_255_10:EnableDynamicBone(true)
				end
			end

			local var_255_11 = arg_252_1.actors_["10170ui_story"]
			local var_255_12 = 0

			if var_255_12 < arg_252_1.time_ and arg_252_1.time_ <= var_255_12 + arg_255_0 and not isNil(var_255_11) and arg_252_1.var_.characterEffect10170ui_story == nil then
				arg_252_1.var_.characterEffect10170ui_story = var_255_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_255_13 = 0.200000002980232

			if var_255_12 <= arg_252_1.time_ and arg_252_1.time_ < var_255_12 + var_255_13 and not isNil(var_255_11) then
				local var_255_14 = (arg_252_1.time_ - var_255_12) / var_255_13

				if arg_252_1.var_.characterEffect10170ui_story and not isNil(var_255_11) then
					arg_252_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_252_1.time_ >= var_255_12 + var_255_13 and arg_252_1.time_ < var_255_12 + var_255_13 + arg_255_0 and not isNil(var_255_11) and arg_252_1.var_.characterEffect10170ui_story then
				arg_252_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			local var_255_15 = 0
			local var_255_16 = 0.15

			if var_255_15 < arg_252_1.time_ and arg_252_1.time_ <= var_255_15 + arg_255_0 then
				arg_252_1.talkMaxDuration = 0
				arg_252_1.dialogCg_.alpha = 1

				arg_252_1.dialog_:SetActive(true)
				SetActive(arg_252_1.leftNameGo_, true)

				local var_255_17 = arg_252_1:FormatText(StoryNameCfg[1450].name)

				arg_252_1.leftNameTxt_.text = var_255_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_252_1.leftNameTxt_.transform)

				arg_252_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_252_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_252_1:RecordName(arg_252_1.leftNameTxt_.text)
				SetActive(arg_252_1.iconTrs_.gameObject, false)
				arg_252_1.callingController_:SetSelectedState("normal")

				local var_255_18 = arg_252_1:GetWordFromCfg(324572061)
				local var_255_19 = arg_252_1:FormatText(var_255_18.content)

				arg_252_1.text_.text = var_255_19

				LuaForUtil.ClearLinePrefixSymbol(arg_252_1.text_)

				local var_255_20 = 6
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

				if manager.audio:GetVoiceLength("story_v_out_324572", "324572061", "story_v_out_324572.awb") ~= 0 then
					local var_255_23 = manager.audio:GetVoiceLength("story_v_out_324572", "324572061", "story_v_out_324572.awb") / 1000

					if var_255_23 + var_255_15 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_23 + var_255_15
					end

					if var_255_18.prefab_name ~= "" and arg_252_1.actors_[var_255_18.prefab_name] ~= nil then
						local var_255_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_252_1.actors_[var_255_18.prefab_name].transform, "story_v_out_324572", "324572061", "story_v_out_324572.awb")

						arg_252_1:RecordAudio("324572061", var_255_24)
						arg_252_1:RecordAudio("324572061", var_255_24)
					else
						arg_252_1:AudioAction("play", "voice", "story_v_out_324572", "324572061", "story_v_out_324572.awb")
					end

					arg_252_1:RecordHistoryTalkVoice("story_v_out_324572", "324572061", "story_v_out_324572.awb")
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
				actorName = "10170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_252_1:InitPlayNodeList()
	end,
	Play324572062 = function(arg_256_0, arg_256_1)
		arg_256_1.time_ = 0
		arg_256_1.frameCnt_ = 0
		arg_256_1.state_ = "playing"
		arg_256_1.curTalkId_ = 324572062
		arg_256_1.duration_ = 5

		SetActive(arg_256_1.tipsGo_, false)

		function arg_256_1.onSingleLineFinish_()
			arg_256_1.onSingleLineUpdate_ = nil
			arg_256_1.onSingleLineFinish_ = nil
			arg_256_1.state_ = "waiting"
		end

		function arg_256_1.playNext_(arg_258_0)
			if arg_258_0 == 1 then
				arg_256_0:Play324572063(arg_256_1)
			end
		end

		function arg_256_1.onSingleLineUpdate_(arg_259_0)
			local var_259_0 = arg_256_1.actors_["10170ui_story"].transform
			local var_259_1 = 0

			if var_259_1 < arg_256_1.time_ and arg_256_1.time_ <= var_259_1 + arg_259_0 then
				arg_256_1.var_.moveOldPos10170ui_story = var_259_0.localPosition

				local var_259_2 = GameObjectTools.GetOrAddComponent(var_259_0.gameObject, typeof(DynamicBoneHelper))

				if var_259_2 then
					var_259_2:EnableDynamicBone(false)
				end
			end

			local var_259_3 = 0.001

			if var_259_1 <= arg_256_1.time_ and arg_256_1.time_ < var_259_1 + var_259_3 then
				local var_259_4 = (arg_256_1.time_ - var_259_1) / var_259_3
				local var_259_5 = Vector3.New(0, 100, 0)

				var_259_0.localPosition = Vector3.Lerp(arg_256_1.var_.moveOldPos10170ui_story, var_259_5, var_259_4)

				local var_259_6 = manager.ui.mainCamera.transform.position - var_259_0.position

				var_259_0.forward = Vector3.New(var_259_6.x, var_259_6.y, var_259_6.z)

				local var_259_7 = var_259_0.localEulerAngles

				var_259_7.z = 0
				var_259_7.x = 0
				var_259_0.localEulerAngles = var_259_7
			end

			if arg_256_1.time_ >= var_259_1 + var_259_3 and arg_256_1.time_ < var_259_1 + var_259_3 + arg_259_0 then
				var_259_0.localPosition = Vector3.New(0, 100, 0)

				local var_259_8 = manager.ui.mainCamera.transform.position - var_259_0.position

				var_259_0.forward = Vector3.New(var_259_8.x, var_259_8.y, var_259_8.z)

				local var_259_9 = var_259_0.localEulerAngles

				var_259_9.z = 0
				var_259_9.x = 0
				var_259_0.localEulerAngles = var_259_9

				local var_259_10 = GameObjectTools.GetOrAddComponent(var_259_0.gameObject, typeof(DynamicBoneHelper))

				if var_259_10 then
					var_259_10:EnableDynamicBone(true)
				end
			end

			local var_259_11 = arg_256_1.actors_["10170ui_story"]
			local var_259_12 = 0

			if var_259_12 < arg_256_1.time_ and arg_256_1.time_ <= var_259_12 + arg_259_0 and not isNil(var_259_11) and arg_256_1.var_.characterEffect10170ui_story == nil then
				arg_256_1.var_.characterEffect10170ui_story = var_259_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_259_13 = 0.200000002980232

			if var_259_12 <= arg_256_1.time_ and arg_256_1.time_ < var_259_12 + var_259_13 and not isNil(var_259_11) then
				local var_259_14 = (arg_256_1.time_ - var_259_12) / var_259_13

				if arg_256_1.var_.characterEffect10170ui_story and not isNil(var_259_11) then
					local var_259_15 = Mathf.Lerp(0, 0.5, var_259_14)

					arg_256_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_256_1.var_.characterEffect10170ui_story.fillRatio = var_259_15
				end
			end

			if arg_256_1.time_ >= var_259_12 + var_259_13 and arg_256_1.time_ < var_259_12 + var_259_13 + arg_259_0 and not isNil(var_259_11) and arg_256_1.var_.characterEffect10170ui_story then
				local var_259_16 = 0.5

				arg_256_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_256_1.var_.characterEffect10170ui_story.fillRatio = var_259_16
			end

			local var_259_17 = 0.4
			local var_259_18 = 1

			if var_259_17 < arg_256_1.time_ and arg_256_1.time_ <= var_259_17 + arg_259_0 then
				local var_259_19 = "play"
				local var_259_20 = "effect"

				arg_256_1:AudioAction(var_259_19, var_259_20, "se_story_150", "se_story_150_sword11", "")
			end

			local var_259_21 = 0
			local var_259_22 = 0.7

			if var_259_21 < arg_256_1.time_ and arg_256_1.time_ <= var_259_21 + arg_259_0 then
				arg_256_1.talkMaxDuration = 0
				arg_256_1.dialogCg_.alpha = 1

				arg_256_1.dialog_:SetActive(true)
				SetActive(arg_256_1.leftNameGo_, false)

				arg_256_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_256_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_256_1:RecordName(arg_256_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_256_1.iconTrs_.gameObject, false)
				arg_256_1.callingController_:SetSelectedState("normal")

				local var_259_23 = arg_256_1:GetWordFromCfg(324572062)
				local var_259_24 = arg_256_1:FormatText(var_259_23.content)

				arg_256_1.text_.text = var_259_24

				LuaForUtil.ClearLinePrefixSymbol(arg_256_1.text_)

				local var_259_25 = 28
				local var_259_26 = utf8.len(var_259_24)
				local var_259_27 = var_259_25 <= 0 and var_259_22 or var_259_22 * (var_259_26 / var_259_25)

				if var_259_27 > 0 and var_259_22 < var_259_27 then
					arg_256_1.talkMaxDuration = var_259_27

					if var_259_27 + var_259_21 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_27 + var_259_21
					end
				end

				arg_256_1.text_.text = var_259_24
				arg_256_1.typewritter.percent = 0

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(false)
				arg_256_1:RecordContent(arg_256_1.text_.text)
			end

			local var_259_28 = math.max(var_259_22, arg_256_1.talkMaxDuration)

			if var_259_21 <= arg_256_1.time_ and arg_256_1.time_ < var_259_21 + var_259_28 then
				arg_256_1.typewritter.percent = (arg_256_1.time_ - var_259_21) / var_259_28

				arg_256_1.typewritter:SetDirty()
			end

			if arg_256_1.time_ >= var_259_21 + var_259_28 and arg_256_1.time_ < var_259_21 + var_259_28 + arg_259_0 then
				arg_256_1.typewritter.percent = 1

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(true)
			end
		end

		arg_256_1.nodeConfigList_ = {
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

		arg_256_1:InitPlayNodeList()
	end,
	Play324572063 = function(arg_260_0, arg_260_1)
		arg_260_1.time_ = 0
		arg_260_1.frameCnt_ = 0
		arg_260_1.state_ = "playing"
		arg_260_1.curTalkId_ = 324572063
		arg_260_1.duration_ = 7

		SetActive(arg_260_1.tipsGo_, false)

		function arg_260_1.onSingleLineFinish_()
			arg_260_1.onSingleLineUpdate_ = nil
			arg_260_1.onSingleLineFinish_ = nil
			arg_260_1.state_ = "waiting"
		end

		function arg_260_1.playNext_(arg_262_0)
			if arg_262_0 == 1 then
				arg_260_0:Play324572064(arg_260_1)
			end
		end

		function arg_260_1.onSingleLineUpdate_(arg_263_0)
			local var_263_0 = "MS2305"

			if arg_260_1.bgs_[var_263_0] == nil then
				local var_263_1 = Object.Instantiate(arg_260_1.paintGo_)

				var_263_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_263_0)
				var_263_1.name = var_263_0
				var_263_1.transform.parent = arg_260_1.stage_.transform
				var_263_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_260_1.bgs_[var_263_0] = var_263_1
			end

			local var_263_2 = 1

			if var_263_2 < arg_260_1.time_ and arg_260_1.time_ <= var_263_2 + arg_263_0 then
				local var_263_3 = manager.ui.mainCamera.transform.localPosition
				local var_263_4 = Vector3.New(0, 0, 10) + Vector3.New(var_263_3.x, var_263_3.y, 0)
				local var_263_5 = arg_260_1.bgs_.MS2305

				var_263_5.transform.localPosition = var_263_4
				var_263_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_263_6 = var_263_5:GetComponent("SpriteRenderer")

				if var_263_6 and var_263_6.sprite then
					local var_263_7 = (var_263_5.transform.localPosition - var_263_3).z
					local var_263_8 = manager.ui.mainCameraCom_
					local var_263_9 = 2 * var_263_7 * Mathf.Tan(var_263_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_263_10 = var_263_9 * var_263_8.aspect
					local var_263_11 = var_263_6.sprite.bounds.size.x
					local var_263_12 = var_263_6.sprite.bounds.size.y
					local var_263_13 = var_263_10 / var_263_11
					local var_263_14 = var_263_9 / var_263_12
					local var_263_15 = var_263_14 < var_263_13 and var_263_13 or var_263_14

					var_263_5.transform.localScale = Vector3.New(var_263_15, var_263_15, 0)
				end

				for iter_263_0, iter_263_1 in pairs(arg_260_1.bgs_) do
					if iter_263_0 ~= "MS2305" then
						iter_263_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_263_16 = 2.999999999999

			if var_263_16 < arg_260_1.time_ and arg_260_1.time_ <= var_263_16 + arg_263_0 then
				arg_260_1.allBtn_.enabled = false
			end

			local var_263_17 = 0.3

			if arg_260_1.time_ >= var_263_16 + var_263_17 and arg_260_1.time_ < var_263_16 + var_263_17 + arg_263_0 then
				arg_260_1.allBtn_.enabled = true
			end

			local var_263_18 = manager.ui.mainCamera.transform
			local var_263_19 = 0

			if var_263_19 < arg_260_1.time_ and arg_260_1.time_ <= var_263_19 + arg_263_0 then
				local var_263_20 = arg_260_1.var_.effectguochanglianjian1
				local var_263_21
				local var_263_22 = var_263_18

				if not var_263_20 then
					var_263_20 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zblack"), var_263_22)
					var_263_20.name = "guochanglianjian1"
					arg_260_1.var_.effectguochanglianjian1 = var_263_20
				else
					var_263_20.transform:SetParent(var_263_22)
				end

				var_263_20.transform.localPosition = Vector3.New(0, 0, 0)
				var_263_20.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_263_23 = arg_260_1.bgs_.MS2305.transform
			local var_263_24 = 0.733333333333333

			if var_263_24 < arg_260_1.time_ and arg_260_1.time_ <= var_263_24 + arg_263_0 then
				arg_260_1.var_.moveOldPosMS2305 = var_263_23.localPosition
			end

			local var_263_25 = 3.5

			if var_263_24 <= arg_260_1.time_ and arg_260_1.time_ < var_263_24 + var_263_25 then
				local var_263_26 = (arg_260_1.time_ - var_263_24) / var_263_25
				local var_263_27 = Vector3.New(2.68, 0.8, 3.34)

				var_263_23.localPosition = Vector3.Lerp(arg_260_1.var_.moveOldPosMS2305, var_263_27, var_263_26)
			end

			if arg_260_1.time_ >= var_263_24 + var_263_25 and arg_260_1.time_ < var_263_24 + var_263_25 + arg_263_0 then
				var_263_23.localPosition = Vector3.New(2.68, 0.8, 3.34)
			end

			local var_263_28 = 0.733333333333333

			arg_260_1.isInRecall_ = false

			if var_263_28 < arg_260_1.time_ and arg_260_1.time_ <= var_263_28 + arg_263_0 then
				arg_260_1.screenFilterGo_:SetActive(true)

				arg_260_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile.asset")

				for iter_263_2, iter_263_3 in pairs(arg_260_1.actors_) do
					local var_263_29 = iter_263_3:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_263_4, iter_263_5 in ipairs(var_263_29) do
						if iter_263_5.color.r > 0.51 then
							iter_263_5.color = Color.New(1, 1, 1)
						else
							iter_263_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end
			end

			local var_263_30 = 0.266666666666667

			if var_263_28 <= arg_260_1.time_ and arg_260_1.time_ < var_263_28 + var_263_30 then
				local var_263_31 = (arg_260_1.time_ - var_263_28) / var_263_30

				arg_260_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, var_263_31)
			end

			if arg_260_1.time_ >= var_263_28 + var_263_30 and arg_260_1.time_ < var_263_28 + var_263_30 + arg_263_0 then
				arg_260_1.screenFilterEffect_.weight = 1
			end

			local var_263_32 = 1.2
			local var_263_33 = 1

			if var_263_32 < arg_260_1.time_ and arg_260_1.time_ <= var_263_32 + arg_263_0 then
				local var_263_34 = "play"
				local var_263_35 = "effect"

				arg_260_1:AudioAction(var_263_34, var_263_35, "se_story_148", "se_story_148_amb_chinese_yard", "")
			end

			local var_263_36 = 0.1
			local var_263_37 = 1

			if var_263_36 < arg_260_1.time_ and arg_260_1.time_ <= var_263_36 + arg_263_0 then
				local var_263_38 = "stop"
				local var_263_39 = "effect"

				arg_260_1:AudioAction(var_263_38, var_263_39, "se_story_side_1095", "se_story_side_1095_amb_beach_night", "")
			end

			if arg_260_1.frameCnt_ <= 1 then
				arg_260_1.dialog_:SetActive(false)
			end

			local var_263_40 = 2
			local var_263_41 = 0.625

			if var_263_40 < arg_260_1.time_ and arg_260_1.time_ <= var_263_40 + arg_263_0 then
				arg_260_1.talkMaxDuration = 0

				arg_260_1.dialog_:SetActive(true)

				arg_260_1.dialogCg_.alpha = 0

				local var_263_42 = LeanTween.value(arg_260_1.dialog_, 0, 1, 0.3)

				var_263_42:setOnUpdate(LuaHelper.FloatAction(function(arg_264_0)
					arg_260_1.dialogCg_.alpha = arg_264_0
				end))
				var_263_42:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_260_1.dialog_)
					var_263_42:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_260_1.duration_ = arg_260_1.duration_ + 0.3

				SetActive(arg_260_1.leftNameGo_, true)

				local var_263_43 = arg_260_1:FormatText(StoryNameCfg[7].name)

				arg_260_1.leftNameTxt_.text = var_263_43

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_260_1.leftNameTxt_.transform)

				arg_260_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_260_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_260_1:RecordName(arg_260_1.leftNameTxt_.text)
				SetActive(arg_260_1.iconTrs_.gameObject, false)
				arg_260_1.callingController_:SetSelectedState("normal")

				local var_263_44 = arg_260_1:GetWordFromCfg(324572063)
				local var_263_45 = arg_260_1:FormatText(var_263_44.content)

				arg_260_1.text_.text = var_263_45

				LuaForUtil.ClearLinePrefixSymbol(arg_260_1.text_)

				local var_263_46 = 25
				local var_263_47 = utf8.len(var_263_45)
				local var_263_48 = var_263_46 <= 0 and var_263_41 or var_263_41 * (var_263_47 / var_263_46)

				if var_263_48 > 0 and var_263_41 < var_263_48 then
					arg_260_1.talkMaxDuration = var_263_48
					var_263_40 = var_263_40 + 0.3

					if var_263_48 + var_263_40 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_48 + var_263_40
					end
				end

				arg_260_1.text_.text = var_263_45
				arg_260_1.typewritter.percent = 0

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(false)
				arg_260_1:RecordContent(arg_260_1.text_.text)
			end

			local var_263_49 = var_263_40 + 0.3
			local var_263_50 = math.max(var_263_41, arg_260_1.talkMaxDuration)

			if var_263_49 <= arg_260_1.time_ and arg_260_1.time_ < var_263_49 + var_263_50 then
				arg_260_1.typewritter.percent = (arg_260_1.time_ - var_263_49) / var_263_50

				arg_260_1.typewritter:SetDirty()
			end

			if arg_260_1.time_ >= var_263_49 + var_263_50 and arg_260_1.time_ < var_263_49 + var_263_50 + arg_263_0 then
				arg_260_1.typewritter.percent = 1

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(true)
			end
		end

		arg_260_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "MS2305",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 3.5,
				startTime = 0.733333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = true,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(2.68, 0.8, 2.8),
					endPos = Vector3.New(2.68, 0.8, 3.34),
					easeType = LeanTweenType.linear
				}
			}
		}

		arg_260_1:InitPlayNodeList()
	end,
	Play324572064 = function(arg_266_0, arg_266_1)
		arg_266_1.time_ = 0
		arg_266_1.frameCnt_ = 0
		arg_266_1.state_ = "playing"
		arg_266_1.curTalkId_ = 324572064
		arg_266_1.duration_ = 1.37

		SetActive(arg_266_1.tipsGo_, false)

		function arg_266_1.onSingleLineFinish_()
			arg_266_1.onSingleLineUpdate_ = nil
			arg_266_1.onSingleLineFinish_ = nil
			arg_266_1.state_ = "waiting"
		end

		function arg_266_1.playNext_(arg_268_0)
			if arg_268_0 == 1 then
				arg_266_0:Play324572065(arg_266_1)
			end
		end

		function arg_266_1.onSingleLineUpdate_(arg_269_0)
			local var_269_0 = arg_266_1.actors_["10170ui_story"]
			local var_269_1 = 0

			if var_269_1 < arg_266_1.time_ and arg_266_1.time_ <= var_269_1 + arg_269_0 and not isNil(var_269_0) and arg_266_1.var_.characterEffect10170ui_story == nil then
				arg_266_1.var_.characterEffect10170ui_story = var_269_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_269_2 = 0.200000002980232

			if var_269_1 <= arg_266_1.time_ and arg_266_1.time_ < var_269_1 + var_269_2 and not isNil(var_269_0) then
				local var_269_3 = (arg_266_1.time_ - var_269_1) / var_269_2

				if arg_266_1.var_.characterEffect10170ui_story and not isNil(var_269_0) then
					arg_266_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_266_1.time_ >= var_269_1 + var_269_2 and arg_266_1.time_ < var_269_1 + var_269_2 + arg_269_0 and not isNil(var_269_0) and arg_266_1.var_.characterEffect10170ui_story then
				arg_266_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			local var_269_4 = 0
			local var_269_5 = 0.125

			if var_269_4 < arg_266_1.time_ and arg_266_1.time_ <= var_269_4 + arg_269_0 then
				arg_266_1.talkMaxDuration = 0
				arg_266_1.dialogCg_.alpha = 1

				arg_266_1.dialog_:SetActive(true)
				SetActive(arg_266_1.leftNameGo_, true)

				local var_269_6 = arg_266_1:FormatText(StoryNameCfg[1450].name)

				arg_266_1.leftNameTxt_.text = var_269_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_266_1.leftNameTxt_.transform)

				arg_266_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_266_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_266_1:RecordName(arg_266_1.leftNameTxt_.text)
				SetActive(arg_266_1.iconTrs_.gameObject, false)
				arg_266_1.callingController_:SetSelectedState("normal")

				local var_269_7 = arg_266_1:GetWordFromCfg(324572064)
				local var_269_8 = arg_266_1:FormatText(var_269_7.content)

				arg_266_1.text_.text = var_269_8

				LuaForUtil.ClearLinePrefixSymbol(arg_266_1.text_)

				local var_269_9 = 5
				local var_269_10 = utf8.len(var_269_8)
				local var_269_11 = var_269_9 <= 0 and var_269_5 or var_269_5 * (var_269_10 / var_269_9)

				if var_269_11 > 0 and var_269_5 < var_269_11 then
					arg_266_1.talkMaxDuration = var_269_11

					if var_269_11 + var_269_4 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_11 + var_269_4
					end
				end

				arg_266_1.text_.text = var_269_8
				arg_266_1.typewritter.percent = 0

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324572", "324572064", "story_v_out_324572.awb") ~= 0 then
					local var_269_12 = manager.audio:GetVoiceLength("story_v_out_324572", "324572064", "story_v_out_324572.awb") / 1000

					if var_269_12 + var_269_4 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_12 + var_269_4
					end

					if var_269_7.prefab_name ~= "" and arg_266_1.actors_[var_269_7.prefab_name] ~= nil then
						local var_269_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_266_1.actors_[var_269_7.prefab_name].transform, "story_v_out_324572", "324572064", "story_v_out_324572.awb")

						arg_266_1:RecordAudio("324572064", var_269_13)
						arg_266_1:RecordAudio("324572064", var_269_13)
					else
						arg_266_1:AudioAction("play", "voice", "story_v_out_324572", "324572064", "story_v_out_324572.awb")
					end

					arg_266_1:RecordHistoryTalkVoice("story_v_out_324572", "324572064", "story_v_out_324572.awb")
				end

				arg_266_1:RecordContent(arg_266_1.text_.text)
			end

			local var_269_14 = math.max(var_269_5, arg_266_1.talkMaxDuration)

			if var_269_4 <= arg_266_1.time_ and arg_266_1.time_ < var_269_4 + var_269_14 then
				arg_266_1.typewritter.percent = (arg_266_1.time_ - var_269_4) / var_269_14

				arg_266_1.typewritter:SetDirty()
			end

			if arg_266_1.time_ >= var_269_4 + var_269_14 and arg_266_1.time_ < var_269_4 + var_269_14 + arg_269_0 then
				arg_266_1.typewritter.percent = 1

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(true)
			end
		end

		arg_266_1.nodeConfigList_ = {}

		arg_266_1:InitPlayNodeList()
	end,
	Play324572065 = function(arg_270_0, arg_270_1)
		arg_270_1.time_ = 0
		arg_270_1.frameCnt_ = 0
		arg_270_1.state_ = "playing"
		arg_270_1.curTalkId_ = 324572065
		arg_270_1.duration_ = 5

		SetActive(arg_270_1.tipsGo_, false)

		function arg_270_1.onSingleLineFinish_()
			arg_270_1.onSingleLineUpdate_ = nil
			arg_270_1.onSingleLineFinish_ = nil
			arg_270_1.state_ = "waiting"
		end

		function arg_270_1.playNext_(arg_272_0)
			if arg_272_0 == 1 then
				arg_270_0:Play324572066(arg_270_1)
			end
		end

		function arg_270_1.onSingleLineUpdate_(arg_273_0)
			local var_273_0 = arg_270_1.actors_["10170ui_story"]
			local var_273_1 = 0

			if var_273_1 < arg_270_1.time_ and arg_270_1.time_ <= var_273_1 + arg_273_0 and not isNil(var_273_0) and arg_270_1.var_.characterEffect10170ui_story == nil then
				arg_270_1.var_.characterEffect10170ui_story = var_273_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_273_2 = 0.200000002980232

			if var_273_1 <= arg_270_1.time_ and arg_270_1.time_ < var_273_1 + var_273_2 and not isNil(var_273_0) then
				local var_273_3 = (arg_270_1.time_ - var_273_1) / var_273_2

				if arg_270_1.var_.characterEffect10170ui_story and not isNil(var_273_0) then
					local var_273_4 = Mathf.Lerp(0, 0.5, var_273_3)

					arg_270_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_270_1.var_.characterEffect10170ui_story.fillRatio = var_273_4
				end
			end

			if arg_270_1.time_ >= var_273_1 + var_273_2 and arg_270_1.time_ < var_273_1 + var_273_2 + arg_273_0 and not isNil(var_273_0) and arg_270_1.var_.characterEffect10170ui_story then
				local var_273_5 = 0.5

				arg_270_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_270_1.var_.characterEffect10170ui_story.fillRatio = var_273_5
			end

			local var_273_6 = 0
			local var_273_7 = 0.65

			if var_273_6 < arg_270_1.time_ and arg_270_1.time_ <= var_273_6 + arg_273_0 then
				arg_270_1.talkMaxDuration = 0
				arg_270_1.dialogCg_.alpha = 1

				arg_270_1.dialog_:SetActive(true)
				SetActive(arg_270_1.leftNameGo_, true)

				local var_273_8 = arg_270_1:FormatText(StoryNameCfg[7].name)

				arg_270_1.leftNameTxt_.text = var_273_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_270_1.leftNameTxt_.transform)

				arg_270_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_270_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_270_1:RecordName(arg_270_1.leftNameTxt_.text)
				SetActive(arg_270_1.iconTrs_.gameObject, false)
				arg_270_1.callingController_:SetSelectedState("normal")

				local var_273_9 = arg_270_1:GetWordFromCfg(324572065)
				local var_273_10 = arg_270_1:FormatText(var_273_9.content)

				arg_270_1.text_.text = var_273_10

				LuaForUtil.ClearLinePrefixSymbol(arg_270_1.text_)

				local var_273_11 = 26
				local var_273_12 = utf8.len(var_273_10)
				local var_273_13 = var_273_11 <= 0 and var_273_7 or var_273_7 * (var_273_12 / var_273_11)

				if var_273_13 > 0 and var_273_7 < var_273_13 then
					arg_270_1.talkMaxDuration = var_273_13

					if var_273_13 + var_273_6 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_13 + var_273_6
					end
				end

				arg_270_1.text_.text = var_273_10
				arg_270_1.typewritter.percent = 0

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(false)
				arg_270_1:RecordContent(arg_270_1.text_.text)
			end

			local var_273_14 = math.max(var_273_7, arg_270_1.talkMaxDuration)

			if var_273_6 <= arg_270_1.time_ and arg_270_1.time_ < var_273_6 + var_273_14 then
				arg_270_1.typewritter.percent = (arg_270_1.time_ - var_273_6) / var_273_14

				arg_270_1.typewritter:SetDirty()
			end

			if arg_270_1.time_ >= var_273_6 + var_273_14 and arg_270_1.time_ < var_273_6 + var_273_14 + arg_273_0 then
				arg_270_1.typewritter.percent = 1

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(true)
			end
		end

		arg_270_1.nodeConfigList_ = {}

		arg_270_1:InitPlayNodeList()
	end,
	Play324572066 = function(arg_274_0, arg_274_1)
		arg_274_1.time_ = 0
		arg_274_1.frameCnt_ = 0
		arg_274_1.state_ = "playing"
		arg_274_1.curTalkId_ = 324572066
		arg_274_1.duration_ = 5.93

		SetActive(arg_274_1.tipsGo_, false)

		function arg_274_1.onSingleLineFinish_()
			arg_274_1.onSingleLineUpdate_ = nil
			arg_274_1.onSingleLineFinish_ = nil
			arg_274_1.state_ = "waiting"
		end

		function arg_274_1.playNext_(arg_276_0)
			if arg_276_0 == 1 then
				arg_274_0:Play324572067(arg_274_1)
			end
		end

		function arg_274_1.onSingleLineUpdate_(arg_277_0)
			local var_277_0 = arg_274_1.actors_["10170ui_story"]
			local var_277_1 = 0

			if var_277_1 < arg_274_1.time_ and arg_274_1.time_ <= var_277_1 + arg_277_0 and not isNil(var_277_0) and arg_274_1.var_.characterEffect10170ui_story == nil then
				arg_274_1.var_.characterEffect10170ui_story = var_277_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_277_2 = 0.200000002980232

			if var_277_1 <= arg_274_1.time_ and arg_274_1.time_ < var_277_1 + var_277_2 and not isNil(var_277_0) then
				local var_277_3 = (arg_274_1.time_ - var_277_1) / var_277_2

				if arg_274_1.var_.characterEffect10170ui_story and not isNil(var_277_0) then
					arg_274_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_274_1.time_ >= var_277_1 + var_277_2 and arg_274_1.time_ < var_277_1 + var_277_2 + arg_277_0 and not isNil(var_277_0) and arg_274_1.var_.characterEffect10170ui_story then
				arg_274_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			local var_277_4 = 0
			local var_277_5 = 0.6

			if var_277_4 < arg_274_1.time_ and arg_274_1.time_ <= var_277_4 + arg_277_0 then
				arg_274_1.talkMaxDuration = 0
				arg_274_1.dialogCg_.alpha = 1

				arg_274_1.dialog_:SetActive(true)
				SetActive(arg_274_1.leftNameGo_, true)

				local var_277_6 = arg_274_1:FormatText(StoryNameCfg[1450].name)

				arg_274_1.leftNameTxt_.text = var_277_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_274_1.leftNameTxt_.transform)

				arg_274_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_274_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_274_1:RecordName(arg_274_1.leftNameTxt_.text)
				SetActive(arg_274_1.iconTrs_.gameObject, false)
				arg_274_1.callingController_:SetSelectedState("normal")

				local var_277_7 = arg_274_1:GetWordFromCfg(324572066)
				local var_277_8 = arg_274_1:FormatText(var_277_7.content)

				arg_274_1.text_.text = var_277_8

				LuaForUtil.ClearLinePrefixSymbol(arg_274_1.text_)

				local var_277_9 = 24
				local var_277_10 = utf8.len(var_277_8)
				local var_277_11 = var_277_9 <= 0 and var_277_5 or var_277_5 * (var_277_10 / var_277_9)

				if var_277_11 > 0 and var_277_5 < var_277_11 then
					arg_274_1.talkMaxDuration = var_277_11

					if var_277_11 + var_277_4 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_11 + var_277_4
					end
				end

				arg_274_1.text_.text = var_277_8
				arg_274_1.typewritter.percent = 0

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324572", "324572066", "story_v_out_324572.awb") ~= 0 then
					local var_277_12 = manager.audio:GetVoiceLength("story_v_out_324572", "324572066", "story_v_out_324572.awb") / 1000

					if var_277_12 + var_277_4 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_12 + var_277_4
					end

					if var_277_7.prefab_name ~= "" and arg_274_1.actors_[var_277_7.prefab_name] ~= nil then
						local var_277_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_274_1.actors_[var_277_7.prefab_name].transform, "story_v_out_324572", "324572066", "story_v_out_324572.awb")

						arg_274_1:RecordAudio("324572066", var_277_13)
						arg_274_1:RecordAudio("324572066", var_277_13)
					else
						arg_274_1:AudioAction("play", "voice", "story_v_out_324572", "324572066", "story_v_out_324572.awb")
					end

					arg_274_1:RecordHistoryTalkVoice("story_v_out_324572", "324572066", "story_v_out_324572.awb")
				end

				arg_274_1:RecordContent(arg_274_1.text_.text)
			end

			local var_277_14 = math.max(var_277_5, arg_274_1.talkMaxDuration)

			if var_277_4 <= arg_274_1.time_ and arg_274_1.time_ < var_277_4 + var_277_14 then
				arg_274_1.typewritter.percent = (arg_274_1.time_ - var_277_4) / var_277_14

				arg_274_1.typewritter:SetDirty()
			end

			if arg_274_1.time_ >= var_277_4 + var_277_14 and arg_274_1.time_ < var_277_4 + var_277_14 + arg_277_0 then
				arg_274_1.typewritter.percent = 1

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(true)
			end
		end

		arg_274_1.nodeConfigList_ = {}

		arg_274_1:InitPlayNodeList()
	end,
	Play324572067 = function(arg_278_0, arg_278_1)
		arg_278_1.time_ = 0
		arg_278_1.frameCnt_ = 0
		arg_278_1.state_ = "playing"
		arg_278_1.curTalkId_ = 324572067
		arg_278_1.duration_ = 5

		SetActive(arg_278_1.tipsGo_, false)

		function arg_278_1.onSingleLineFinish_()
			arg_278_1.onSingleLineUpdate_ = nil
			arg_278_1.onSingleLineFinish_ = nil
			arg_278_1.state_ = "waiting"
		end

		function arg_278_1.playNext_(arg_280_0)
			if arg_280_0 == 1 then
				arg_278_0:Play324572068(arg_278_1)
			end
		end

		function arg_278_1.onSingleLineUpdate_(arg_281_0)
			local var_281_0 = arg_278_1.actors_["10170ui_story"]
			local var_281_1 = 0

			if var_281_1 < arg_278_1.time_ and arg_278_1.time_ <= var_281_1 + arg_281_0 and not isNil(var_281_0) and arg_278_1.var_.characterEffect10170ui_story == nil then
				arg_278_1.var_.characterEffect10170ui_story = var_281_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_281_2 = 0.200000002980232

			if var_281_1 <= arg_278_1.time_ and arg_278_1.time_ < var_281_1 + var_281_2 and not isNil(var_281_0) then
				local var_281_3 = (arg_278_1.time_ - var_281_1) / var_281_2

				if arg_278_1.var_.characterEffect10170ui_story and not isNil(var_281_0) then
					local var_281_4 = Mathf.Lerp(0, 0.5, var_281_3)

					arg_278_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_278_1.var_.characterEffect10170ui_story.fillRatio = var_281_4
				end
			end

			if arg_278_1.time_ >= var_281_1 + var_281_2 and arg_278_1.time_ < var_281_1 + var_281_2 + arg_281_0 and not isNil(var_281_0) and arg_278_1.var_.characterEffect10170ui_story then
				local var_281_5 = 0.5

				arg_278_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_278_1.var_.characterEffect10170ui_story.fillRatio = var_281_5
			end

			local var_281_6 = 0
			local var_281_7 = 0.45

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
				SetActive(arg_278_1.iconTrs_.gameObject, false)
				arg_278_1.callingController_:SetSelectedState("normal")

				local var_281_9 = arg_278_1:GetWordFromCfg(324572067)
				local var_281_10 = arg_278_1:FormatText(var_281_9.content)

				arg_278_1.text_.text = var_281_10

				LuaForUtil.ClearLinePrefixSymbol(arg_278_1.text_)

				local var_281_11 = 18
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
	Play324572068 = function(arg_282_0, arg_282_1)
		arg_282_1.time_ = 0
		arg_282_1.frameCnt_ = 0
		arg_282_1.state_ = "playing"
		arg_282_1.curTalkId_ = 324572068
		arg_282_1.duration_ = 8.68

		SetActive(arg_282_1.tipsGo_, false)

		function arg_282_1.onSingleLineFinish_()
			arg_282_1.onSingleLineUpdate_ = nil
			arg_282_1.onSingleLineFinish_ = nil
			arg_282_1.state_ = "waiting"
		end

		function arg_282_1.playNext_(arg_284_0)
			if arg_284_0 == 1 then
				arg_282_0:Play324572069(arg_282_1)
			end
		end

		function arg_282_1.onSingleLineUpdate_(arg_285_0)
			local var_285_0 = 2

			if var_285_0 < arg_282_1.time_ and arg_282_1.time_ <= var_285_0 + arg_285_0 then
				local var_285_1 = manager.ui.mainCamera.transform.localPosition
				local var_285_2 = Vector3.New(0, 0, 10) + Vector3.New(var_285_1.x, var_285_1.y, 0)
				local var_285_3 = arg_282_1.bgs_.H02a

				var_285_3.transform.localPosition = var_285_2
				var_285_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_285_4 = var_285_3:GetComponent("SpriteRenderer")

				if var_285_4 and var_285_4.sprite then
					local var_285_5 = (var_285_3.transform.localPosition - var_285_1).z
					local var_285_6 = manager.ui.mainCameraCom_
					local var_285_7 = 2 * var_285_5 * Mathf.Tan(var_285_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_285_8 = var_285_7 * var_285_6.aspect
					local var_285_9 = var_285_4.sprite.bounds.size.x
					local var_285_10 = var_285_4.sprite.bounds.size.y
					local var_285_11 = var_285_8 / var_285_9
					local var_285_12 = var_285_7 / var_285_10
					local var_285_13 = var_285_12 < var_285_11 and var_285_11 or var_285_12

					var_285_3.transform.localScale = Vector3.New(var_285_13, var_285_13, 0)
				end

				for iter_285_0, iter_285_1 in pairs(arg_282_1.bgs_) do
					if iter_285_0 ~= "H02a" then
						iter_285_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_285_14 = 4

			if var_285_14 < arg_282_1.time_ and arg_282_1.time_ <= var_285_14 + arg_285_0 then
				arg_282_1.allBtn_.enabled = false
			end

			local var_285_15 = 0.3

			if arg_282_1.time_ >= var_285_14 + var_285_15 and arg_282_1.time_ < var_285_14 + var_285_15 + arg_285_0 then
				arg_282_1.allBtn_.enabled = true
			end

			local var_285_16 = 0

			if var_285_16 < arg_282_1.time_ and arg_282_1.time_ <= var_285_16 + arg_285_0 then
				arg_282_1.mask_.enabled = true
				arg_282_1.mask_.raycastTarget = true

				arg_282_1:SetGaussion(false)
			end

			local var_285_17 = 2

			if var_285_16 <= arg_282_1.time_ and arg_282_1.time_ < var_285_16 + var_285_17 then
				local var_285_18 = (arg_282_1.time_ - var_285_16) / var_285_17
				local var_285_19 = Color.New(0, 0, 0)

				var_285_19.a = Mathf.Lerp(0, 1, var_285_18)
				arg_282_1.mask_.color = var_285_19
			end

			if arg_282_1.time_ >= var_285_16 + var_285_17 and arg_282_1.time_ < var_285_16 + var_285_17 + arg_285_0 then
				local var_285_20 = Color.New(0, 0, 0)

				var_285_20.a = 1
				arg_282_1.mask_.color = var_285_20
			end

			local var_285_21 = 2

			if var_285_21 < arg_282_1.time_ and arg_282_1.time_ <= var_285_21 + arg_285_0 then
				arg_282_1.mask_.enabled = true
				arg_282_1.mask_.raycastTarget = true

				arg_282_1:SetGaussion(false)
			end

			local var_285_22 = 2

			if var_285_21 <= arg_282_1.time_ and arg_282_1.time_ < var_285_21 + var_285_22 then
				local var_285_23 = (arg_282_1.time_ - var_285_21) / var_285_22
				local var_285_24 = Color.New(0, 0, 0)

				var_285_24.a = Mathf.Lerp(1, 0, var_285_23)
				arg_282_1.mask_.color = var_285_24
			end

			if arg_282_1.time_ >= var_285_21 + var_285_22 and arg_282_1.time_ < var_285_21 + var_285_22 + arg_285_0 then
				local var_285_25 = Color.New(0, 0, 0)
				local var_285_26 = 0

				arg_282_1.mask_.enabled = false
				var_285_25.a = var_285_26
				arg_282_1.mask_.color = var_285_25
			end

			local var_285_27 = 2

			arg_282_1.isInRecall_ = false

			if var_285_27 < arg_282_1.time_ and arg_282_1.time_ <= var_285_27 + arg_285_0 then
				arg_282_1.screenFilterGo_:SetActive(false)

				for iter_285_2, iter_285_3 in pairs(arg_282_1.actors_) do
					local var_285_28 = iter_285_3:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_285_4, iter_285_5 in ipairs(var_285_28) do
						if iter_285_5.color.r > 0.51 then
							iter_285_5.color = Color.New(1, 1, 1)
						else
							iter_285_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end
			end

			local var_285_29 = 0.0166666666666667

			if var_285_27 <= arg_282_1.time_ and arg_282_1.time_ < var_285_27 + var_285_29 then
				local var_285_30 = (arg_282_1.time_ - var_285_27) / var_285_29

				arg_282_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, var_285_30)
			end

			if arg_282_1.time_ >= var_285_27 + var_285_29 and arg_282_1.time_ < var_285_27 + var_285_29 + arg_285_0 then
				arg_282_1.screenFilterEffect_.weight = 0
			end

			local var_285_31 = 1.2
			local var_285_32 = 1

			if var_285_31 < arg_282_1.time_ and arg_282_1.time_ <= var_285_31 + arg_285_0 then
				local var_285_33 = "play"
				local var_285_34 = "effect"

				arg_282_1:AudioAction(var_285_33, var_285_34, "se_story_side_1095", "se_story_side_1095_amb_beach_night", "")
			end

			local var_285_35 = 0.1
			local var_285_36 = 1

			if var_285_35 < arg_282_1.time_ and arg_282_1.time_ <= var_285_35 + arg_285_0 then
				local var_285_37 = "stop"
				local var_285_38 = "effect"

				arg_282_1:AudioAction(var_285_37, var_285_38, "se_story_148", "se_story_148_amb_chinese_yard", "")
			end

			if arg_282_1.frameCnt_ <= 1 then
				arg_282_1.dialog_:SetActive(false)
			end

			local var_285_39 = 3.675
			local var_285_40 = 0.625

			if var_285_39 < arg_282_1.time_ and arg_282_1.time_ <= var_285_39 + arg_285_0 then
				arg_282_1.talkMaxDuration = 0

				arg_282_1.dialog_:SetActive(true)

				arg_282_1.dialogCg_.alpha = 0

				local var_285_41 = LeanTween.value(arg_282_1.dialog_, 0, 1, 0.3)

				var_285_41:setOnUpdate(LuaHelper.FloatAction(function(arg_286_0)
					arg_282_1.dialogCg_.alpha = arg_286_0
				end))
				var_285_41:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_282_1.dialog_)
					var_285_41:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_282_1.duration_ = arg_282_1.duration_ + 0.3

				SetActive(arg_282_1.leftNameGo_, false)

				arg_282_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_282_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_282_1:RecordName(arg_282_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_282_1.iconTrs_.gameObject, false)
				arg_282_1.callingController_:SetSelectedState("normal")

				local var_285_42 = arg_282_1:GetWordFromCfg(324572068)
				local var_285_43 = arg_282_1:FormatText(var_285_42.content)

				arg_282_1.text_.text = var_285_43

				LuaForUtil.ClearLinePrefixSymbol(arg_282_1.text_)

				local var_285_44 = 25
				local var_285_45 = utf8.len(var_285_43)
				local var_285_46 = var_285_44 <= 0 and var_285_40 or var_285_40 * (var_285_45 / var_285_44)

				if var_285_46 > 0 and var_285_40 < var_285_46 then
					arg_282_1.talkMaxDuration = var_285_46
					var_285_39 = var_285_39 + 0.3

					if var_285_46 + var_285_39 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_46 + var_285_39
					end
				end

				arg_282_1.text_.text = var_285_43
				arg_282_1.typewritter.percent = 0

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(false)
				arg_282_1:RecordContent(arg_282_1.text_.text)
			end

			local var_285_47 = var_285_39 + 0.3
			local var_285_48 = math.max(var_285_40, arg_282_1.talkMaxDuration)

			if var_285_47 <= arg_282_1.time_ and arg_282_1.time_ < var_285_47 + var_285_48 then
				arg_282_1.typewritter.percent = (arg_282_1.time_ - var_285_47) / var_285_48

				arg_282_1.typewritter:SetDirty()
			end

			if arg_282_1.time_ >= var_285_47 + var_285_48 and arg_282_1.time_ < var_285_47 + var_285_48 + arg_285_0 then
				arg_282_1.typewritter.percent = 1

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(true)
			end
		end

		arg_282_1.nodeConfigList_ = {}

		arg_282_1:InitPlayNodeList()
	end,
	Play324572069 = function(arg_288_0, arg_288_1)
		arg_288_1.time_ = 0
		arg_288_1.frameCnt_ = 0
		arg_288_1.state_ = "playing"
		arg_288_1.curTalkId_ = 324572069
		arg_288_1.duration_ = 2.43

		SetActive(arg_288_1.tipsGo_, false)

		function arg_288_1.onSingleLineFinish_()
			arg_288_1.onSingleLineUpdate_ = nil
			arg_288_1.onSingleLineFinish_ = nil
			arg_288_1.state_ = "waiting"
		end

		function arg_288_1.playNext_(arg_290_0)
			if arg_290_0 == 1 then
				arg_288_0:Play324572070(arg_288_1)
			end
		end

		function arg_288_1.onSingleLineUpdate_(arg_291_0)
			local var_291_0 = arg_288_1.actors_["10170ui_story"].transform
			local var_291_1 = 0

			if var_291_1 < arg_288_1.time_ and arg_288_1.time_ <= var_291_1 + arg_291_0 then
				arg_288_1.var_.moveOldPos10170ui_story = var_291_0.localPosition

				local var_291_2 = GameObjectTools.GetOrAddComponent(var_291_0.gameObject, typeof(DynamicBoneHelper))

				if var_291_2 then
					var_291_2:EnableDynamicBone(false)
				end
			end

			local var_291_3 = 0.001

			if var_291_1 <= arg_288_1.time_ and arg_288_1.time_ < var_291_1 + var_291_3 then
				local var_291_4 = (arg_288_1.time_ - var_291_1) / var_291_3
				local var_291_5 = Vector3.New(0, -1.03, -6.05)

				var_291_0.localPosition = Vector3.Lerp(arg_288_1.var_.moveOldPos10170ui_story, var_291_5, var_291_4)

				local var_291_6 = manager.ui.mainCamera.transform.position - var_291_0.position

				var_291_0.forward = Vector3.New(var_291_6.x, var_291_6.y, var_291_6.z)

				local var_291_7 = var_291_0.localEulerAngles

				var_291_7.z = 0
				var_291_7.x = 0
				var_291_0.localEulerAngles = var_291_7
			end

			if arg_288_1.time_ >= var_291_1 + var_291_3 and arg_288_1.time_ < var_291_1 + var_291_3 + arg_291_0 then
				var_291_0.localPosition = Vector3.New(0, -1.03, -6.05)

				local var_291_8 = manager.ui.mainCamera.transform.position - var_291_0.position

				var_291_0.forward = Vector3.New(var_291_8.x, var_291_8.y, var_291_8.z)

				local var_291_9 = var_291_0.localEulerAngles

				var_291_9.z = 0
				var_291_9.x = 0
				var_291_0.localEulerAngles = var_291_9

				local var_291_10 = GameObjectTools.GetOrAddComponent(var_291_0.gameObject, typeof(DynamicBoneHelper))

				if var_291_10 then
					var_291_10:EnableDynamicBone(true)
				end
			end

			local var_291_11 = arg_288_1.actors_["10170ui_story"]
			local var_291_12 = 0

			if var_291_12 < arg_288_1.time_ and arg_288_1.time_ <= var_291_12 + arg_291_0 and not isNil(var_291_11) and arg_288_1.var_.characterEffect10170ui_story == nil then
				arg_288_1.var_.characterEffect10170ui_story = var_291_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_291_13 = 0.200000002980232

			if var_291_12 <= arg_288_1.time_ and arg_288_1.time_ < var_291_12 + var_291_13 and not isNil(var_291_11) then
				local var_291_14 = (arg_288_1.time_ - var_291_12) / var_291_13

				if arg_288_1.var_.characterEffect10170ui_story and not isNil(var_291_11) then
					arg_288_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_288_1.time_ >= var_291_12 + var_291_13 and arg_288_1.time_ < var_291_12 + var_291_13 + arg_291_0 and not isNil(var_291_11) and arg_288_1.var_.characterEffect10170ui_story then
				arg_288_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			local var_291_15 = 0

			if var_291_15 < arg_288_1.time_ and arg_288_1.time_ <= var_291_15 + arg_291_0 then
				arg_288_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/story10170/story10170action/10170action2_1")
			end

			local var_291_16 = 0

			if var_291_16 < arg_288_1.time_ and arg_288_1.time_ <= var_291_16 + arg_291_0 then
				arg_288_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_291_17 = 0
			local var_291_18 = 0.25

			if var_291_17 < arg_288_1.time_ and arg_288_1.time_ <= var_291_17 + arg_291_0 then
				arg_288_1.talkMaxDuration = 0
				arg_288_1.dialogCg_.alpha = 1

				arg_288_1.dialog_:SetActive(true)
				SetActive(arg_288_1.leftNameGo_, true)

				local var_291_19 = arg_288_1:FormatText(StoryNameCfg[1450].name)

				arg_288_1.leftNameTxt_.text = var_291_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_288_1.leftNameTxt_.transform)

				arg_288_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_288_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_288_1:RecordName(arg_288_1.leftNameTxt_.text)
				SetActive(arg_288_1.iconTrs_.gameObject, false)
				arg_288_1.callingController_:SetSelectedState("normal")

				local var_291_20 = arg_288_1:GetWordFromCfg(324572069)
				local var_291_21 = arg_288_1:FormatText(var_291_20.content)

				arg_288_1.text_.text = var_291_21

				LuaForUtil.ClearLinePrefixSymbol(arg_288_1.text_)

				local var_291_22 = 10
				local var_291_23 = utf8.len(var_291_21)
				local var_291_24 = var_291_22 <= 0 and var_291_18 or var_291_18 * (var_291_23 / var_291_22)

				if var_291_24 > 0 and var_291_18 < var_291_24 then
					arg_288_1.talkMaxDuration = var_291_24

					if var_291_24 + var_291_17 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_24 + var_291_17
					end
				end

				arg_288_1.text_.text = var_291_21
				arg_288_1.typewritter.percent = 0

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324572", "324572069", "story_v_out_324572.awb") ~= 0 then
					local var_291_25 = manager.audio:GetVoiceLength("story_v_out_324572", "324572069", "story_v_out_324572.awb") / 1000

					if var_291_25 + var_291_17 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_25 + var_291_17
					end

					if var_291_20.prefab_name ~= "" and arg_288_1.actors_[var_291_20.prefab_name] ~= nil then
						local var_291_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_288_1.actors_[var_291_20.prefab_name].transform, "story_v_out_324572", "324572069", "story_v_out_324572.awb")

						arg_288_1:RecordAudio("324572069", var_291_26)
						arg_288_1:RecordAudio("324572069", var_291_26)
					else
						arg_288_1:AudioAction("play", "voice", "story_v_out_324572", "324572069", "story_v_out_324572.awb")
					end

					arg_288_1:RecordHistoryTalkVoice("story_v_out_324572", "324572069", "story_v_out_324572.awb")
				end

				arg_288_1:RecordContent(arg_288_1.text_.text)
			end

			local var_291_27 = math.max(var_291_18, arg_288_1.talkMaxDuration)

			if var_291_17 <= arg_288_1.time_ and arg_288_1.time_ < var_291_17 + var_291_27 then
				arg_288_1.typewritter.percent = (arg_288_1.time_ - var_291_17) / var_291_27

				arg_288_1.typewritter:SetDirty()
			end

			if arg_288_1.time_ >= var_291_17 + var_291_27 and arg_288_1.time_ < var_291_17 + var_291_27 + arg_291_0 then
				arg_288_1.typewritter.percent = 1

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(true)
			end
		end

		arg_288_1.nodeConfigList_ = {
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

		arg_288_1:InitPlayNodeList()
	end,
	Play324572070 = function(arg_292_0, arg_292_1)
		arg_292_1.time_ = 0
		arg_292_1.frameCnt_ = 0
		arg_292_1.state_ = "playing"
		arg_292_1.curTalkId_ = 324572070
		arg_292_1.duration_ = 5

		SetActive(arg_292_1.tipsGo_, false)

		function arg_292_1.onSingleLineFinish_()
			arg_292_1.onSingleLineUpdate_ = nil
			arg_292_1.onSingleLineFinish_ = nil
			arg_292_1.state_ = "waiting"
		end

		function arg_292_1.playNext_(arg_294_0)
			if arg_294_0 == 1 then
				arg_292_0:Play324572071(arg_292_1)
			end
		end

		function arg_292_1.onSingleLineUpdate_(arg_295_0)
			local var_295_0 = arg_292_1.actors_["10170ui_story"]
			local var_295_1 = 0

			if var_295_1 < arg_292_1.time_ and arg_292_1.time_ <= var_295_1 + arg_295_0 and not isNil(var_295_0) and arg_292_1.var_.characterEffect10170ui_story == nil then
				arg_292_1.var_.characterEffect10170ui_story = var_295_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_295_2 = 0.200000002980232

			if var_295_1 <= arg_292_1.time_ and arg_292_1.time_ < var_295_1 + var_295_2 and not isNil(var_295_0) then
				local var_295_3 = (arg_292_1.time_ - var_295_1) / var_295_2

				if arg_292_1.var_.characterEffect10170ui_story and not isNil(var_295_0) then
					local var_295_4 = Mathf.Lerp(0, 0.5, var_295_3)

					arg_292_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_292_1.var_.characterEffect10170ui_story.fillRatio = var_295_4
				end
			end

			if arg_292_1.time_ >= var_295_1 + var_295_2 and arg_292_1.time_ < var_295_1 + var_295_2 + arg_295_0 and not isNil(var_295_0) and arg_292_1.var_.characterEffect10170ui_story then
				local var_295_5 = 0.5

				arg_292_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_292_1.var_.characterEffect10170ui_story.fillRatio = var_295_5
			end

			local var_295_6 = 0
			local var_295_7 = 0.125

			if var_295_6 < arg_292_1.time_ and arg_292_1.time_ <= var_295_6 + arg_295_0 then
				arg_292_1.talkMaxDuration = 0
				arg_292_1.dialogCg_.alpha = 1

				arg_292_1.dialog_:SetActive(true)
				SetActive(arg_292_1.leftNameGo_, true)

				local var_295_8 = arg_292_1:FormatText(StoryNameCfg[7].name)

				arg_292_1.leftNameTxt_.text = var_295_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_292_1.leftNameTxt_.transform)

				arg_292_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_292_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_292_1:RecordName(arg_292_1.leftNameTxt_.text)
				SetActive(arg_292_1.iconTrs_.gameObject, true)
				arg_292_1.iconController_:SetSelectedState("hero")

				arg_292_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_292_1.callingController_:SetSelectedState("normal")

				arg_292_1.keyicon_.color = Color.New(1, 1, 1)
				arg_292_1.icon_.color = Color.New(1, 1, 1)

				local var_295_9 = arg_292_1:GetWordFromCfg(324572070)
				local var_295_10 = arg_292_1:FormatText(var_295_9.content)

				arg_292_1.text_.text = var_295_10

				LuaForUtil.ClearLinePrefixSymbol(arg_292_1.text_)

				local var_295_11 = 5
				local var_295_12 = utf8.len(var_295_10)
				local var_295_13 = var_295_11 <= 0 and var_295_7 or var_295_7 * (var_295_12 / var_295_11)

				if var_295_13 > 0 and var_295_7 < var_295_13 then
					arg_292_1.talkMaxDuration = var_295_13

					if var_295_13 + var_295_6 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_13 + var_295_6
					end
				end

				arg_292_1.text_.text = var_295_10
				arg_292_1.typewritter.percent = 0

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(false)
				arg_292_1:RecordContent(arg_292_1.text_.text)
			end

			local var_295_14 = math.max(var_295_7, arg_292_1.talkMaxDuration)

			if var_295_6 <= arg_292_1.time_ and arg_292_1.time_ < var_295_6 + var_295_14 then
				arg_292_1.typewritter.percent = (arg_292_1.time_ - var_295_6) / var_295_14

				arg_292_1.typewritter:SetDirty()
			end

			if arg_292_1.time_ >= var_295_6 + var_295_14 and arg_292_1.time_ < var_295_6 + var_295_14 + arg_295_0 then
				arg_292_1.typewritter.percent = 1

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(true)
			end
		end

		arg_292_1.nodeConfigList_ = {}

		arg_292_1:InitPlayNodeList()
	end,
	Play324572071 = function(arg_296_0, arg_296_1)
		arg_296_1.time_ = 0
		arg_296_1.frameCnt_ = 0
		arg_296_1.state_ = "playing"
		arg_296_1.curTalkId_ = 324572071
		arg_296_1.duration_ = 3.33

		SetActive(arg_296_1.tipsGo_, false)

		function arg_296_1.onSingleLineFinish_()
			arg_296_1.onSingleLineUpdate_ = nil
			arg_296_1.onSingleLineFinish_ = nil
			arg_296_1.state_ = "waiting"
		end

		function arg_296_1.playNext_(arg_298_0)
			if arg_298_0 == 1 then
				arg_296_0:Play324572072(arg_296_1)
			end
		end

		function arg_296_1.onSingleLineUpdate_(arg_299_0)
			local var_299_0 = arg_296_1.actors_["10170ui_story"]
			local var_299_1 = 0

			if var_299_1 < arg_296_1.time_ and arg_296_1.time_ <= var_299_1 + arg_299_0 and not isNil(var_299_0) and arg_296_1.var_.characterEffect10170ui_story == nil then
				arg_296_1.var_.characterEffect10170ui_story = var_299_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_299_2 = 0.200000002980232

			if var_299_1 <= arg_296_1.time_ and arg_296_1.time_ < var_299_1 + var_299_2 and not isNil(var_299_0) then
				local var_299_3 = (arg_296_1.time_ - var_299_1) / var_299_2

				if arg_296_1.var_.characterEffect10170ui_story and not isNil(var_299_0) then
					arg_296_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_296_1.time_ >= var_299_1 + var_299_2 and arg_296_1.time_ < var_299_1 + var_299_2 + arg_299_0 and not isNil(var_299_0) and arg_296_1.var_.characterEffect10170ui_story then
				arg_296_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			local var_299_4 = 0

			if var_299_4 < arg_296_1.time_ and arg_296_1.time_ <= var_299_4 + arg_299_0 then
				arg_296_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/story10170/story10170action/10170action2_2")
			end

			local var_299_5 = 0

			if var_299_5 < arg_296_1.time_ and arg_296_1.time_ <= var_299_5 + arg_299_0 then
				arg_296_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_299_6 = 0
			local var_299_7 = 0.275

			if var_299_6 < arg_296_1.time_ and arg_296_1.time_ <= var_299_6 + arg_299_0 then
				arg_296_1.talkMaxDuration = 0
				arg_296_1.dialogCg_.alpha = 1

				arg_296_1.dialog_:SetActive(true)
				SetActive(arg_296_1.leftNameGo_, true)

				local var_299_8 = arg_296_1:FormatText(StoryNameCfg[1450].name)

				arg_296_1.leftNameTxt_.text = var_299_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_296_1.leftNameTxt_.transform)

				arg_296_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_296_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_296_1:RecordName(arg_296_1.leftNameTxt_.text)
				SetActive(arg_296_1.iconTrs_.gameObject, false)
				arg_296_1.callingController_:SetSelectedState("normal")

				local var_299_9 = arg_296_1:GetWordFromCfg(324572071)
				local var_299_10 = arg_296_1:FormatText(var_299_9.content)

				arg_296_1.text_.text = var_299_10

				LuaForUtil.ClearLinePrefixSymbol(arg_296_1.text_)

				local var_299_11 = 11
				local var_299_12 = utf8.len(var_299_10)
				local var_299_13 = var_299_11 <= 0 and var_299_7 or var_299_7 * (var_299_12 / var_299_11)

				if var_299_13 > 0 and var_299_7 < var_299_13 then
					arg_296_1.talkMaxDuration = var_299_13

					if var_299_13 + var_299_6 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_13 + var_299_6
					end
				end

				arg_296_1.text_.text = var_299_10
				arg_296_1.typewritter.percent = 0

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324572", "324572071", "story_v_out_324572.awb") ~= 0 then
					local var_299_14 = manager.audio:GetVoiceLength("story_v_out_324572", "324572071", "story_v_out_324572.awb") / 1000

					if var_299_14 + var_299_6 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_14 + var_299_6
					end

					if var_299_9.prefab_name ~= "" and arg_296_1.actors_[var_299_9.prefab_name] ~= nil then
						local var_299_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_296_1.actors_[var_299_9.prefab_name].transform, "story_v_out_324572", "324572071", "story_v_out_324572.awb")

						arg_296_1:RecordAudio("324572071", var_299_15)
						arg_296_1:RecordAudio("324572071", var_299_15)
					else
						arg_296_1:AudioAction("play", "voice", "story_v_out_324572", "324572071", "story_v_out_324572.awb")
					end

					arg_296_1:RecordHistoryTalkVoice("story_v_out_324572", "324572071", "story_v_out_324572.awb")
				end

				arg_296_1:RecordContent(arg_296_1.text_.text)
			end

			local var_299_16 = math.max(var_299_7, arg_296_1.talkMaxDuration)

			if var_299_6 <= arg_296_1.time_ and arg_296_1.time_ < var_299_6 + var_299_16 then
				arg_296_1.typewritter.percent = (arg_296_1.time_ - var_299_6) / var_299_16

				arg_296_1.typewritter:SetDirty()
			end

			if arg_296_1.time_ >= var_299_6 + var_299_16 and arg_296_1.time_ < var_299_6 + var_299_16 + arg_299_0 then
				arg_296_1.typewritter.percent = 1

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(true)
			end
		end

		arg_296_1.nodeConfigList_ = {}

		arg_296_1:InitPlayNodeList()
	end,
	Play324572072 = function(arg_300_0, arg_300_1)
		arg_300_1.time_ = 0
		arg_300_1.frameCnt_ = 0
		arg_300_1.state_ = "playing"
		arg_300_1.curTalkId_ = 324572072
		arg_300_1.duration_ = 8

		SetActive(arg_300_1.tipsGo_, false)

		function arg_300_1.onSingleLineFinish_()
			arg_300_1.onSingleLineUpdate_ = nil
			arg_300_1.onSingleLineFinish_ = nil
			arg_300_1.state_ = "waiting"
		end

		function arg_300_1.playNext_(arg_302_0)
			if arg_302_0 == 1 then
				arg_300_0:Play324572073(arg_300_1)
			end
		end

		function arg_300_1.onSingleLineUpdate_(arg_303_0)
			local var_303_0 = arg_300_1.actors_["10170ui_story"].transform
			local var_303_1 = 0

			if var_303_1 < arg_300_1.time_ and arg_300_1.time_ <= var_303_1 + arg_303_0 then
				arg_300_1.var_.moveOldPos10170ui_story = var_303_0.localPosition

				local var_303_2 = GameObjectTools.GetOrAddComponent(var_303_0.gameObject, typeof(DynamicBoneHelper))

				if var_303_2 then
					var_303_2:EnableDynamicBone(false)
				end
			end

			local var_303_3 = 0.001

			if var_303_1 <= arg_300_1.time_ and arg_300_1.time_ < var_303_1 + var_303_3 then
				local var_303_4 = (arg_300_1.time_ - var_303_1) / var_303_3
				local var_303_5 = Vector3.New(0, 100, 0)

				var_303_0.localPosition = Vector3.Lerp(arg_300_1.var_.moveOldPos10170ui_story, var_303_5, var_303_4)

				local var_303_6 = manager.ui.mainCamera.transform.position - var_303_0.position

				var_303_0.forward = Vector3.New(var_303_6.x, var_303_6.y, var_303_6.z)

				local var_303_7 = var_303_0.localEulerAngles

				var_303_7.z = 0
				var_303_7.x = 0
				var_303_0.localEulerAngles = var_303_7
			end

			if arg_300_1.time_ >= var_303_1 + var_303_3 and arg_300_1.time_ < var_303_1 + var_303_3 + arg_303_0 then
				var_303_0.localPosition = Vector3.New(0, 100, 0)

				local var_303_8 = manager.ui.mainCamera.transform.position - var_303_0.position

				var_303_0.forward = Vector3.New(var_303_8.x, var_303_8.y, var_303_8.z)

				local var_303_9 = var_303_0.localEulerAngles

				var_303_9.z = 0
				var_303_9.x = 0
				var_303_0.localEulerAngles = var_303_9

				local var_303_10 = GameObjectTools.GetOrAddComponent(var_303_0.gameObject, typeof(DynamicBoneHelper))

				if var_303_10 then
					var_303_10:EnableDynamicBone(true)
				end
			end

			local var_303_11 = arg_300_1.actors_["10170ui_story"]
			local var_303_12 = 0

			if var_303_12 < arg_300_1.time_ and arg_300_1.time_ <= var_303_12 + arg_303_0 and not isNil(var_303_11) and arg_300_1.var_.characterEffect10170ui_story == nil then
				arg_300_1.var_.characterEffect10170ui_story = var_303_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_303_13 = 0.200000002980232

			if var_303_12 <= arg_300_1.time_ and arg_300_1.time_ < var_303_12 + var_303_13 and not isNil(var_303_11) then
				local var_303_14 = (arg_300_1.time_ - var_303_12) / var_303_13

				if arg_300_1.var_.characterEffect10170ui_story and not isNil(var_303_11) then
					local var_303_15 = Mathf.Lerp(0, 0.5, var_303_14)

					arg_300_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_300_1.var_.characterEffect10170ui_story.fillRatio = var_303_15
				end
			end

			if arg_300_1.time_ >= var_303_12 + var_303_13 and arg_300_1.time_ < var_303_12 + var_303_13 + arg_303_0 and not isNil(var_303_11) and arg_300_1.var_.characterEffect10170ui_story then
				local var_303_16 = 0.5

				arg_300_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_300_1.var_.characterEffect10170ui_story.fillRatio = var_303_16
			end

			local var_303_17 = manager.ui.mainCamera.transform
			local var_303_18 = 0

			if var_303_18 < arg_300_1.time_ and arg_300_1.time_ <= var_303_18 + arg_303_0 then
				local var_303_19 = arg_300_1.var_.effectshiyesankai1
				local var_303_20
				local var_303_21 = var_303_17

				if not var_303_19 then
					var_303_19 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_snapblink"), var_303_21)
					var_303_19.name = "shiyesankai1"
					arg_300_1.var_.effectshiyesankai1 = var_303_19
				else
					var_303_19.transform:SetParent(var_303_21)
				end

				var_303_19.transform.localPosition = Vector3.New(0, 0, 0)
				var_303_19.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_303_22 = arg_300_1.bgs_.H02a.transform
			local var_303_23 = 0

			if var_303_23 < arg_300_1.time_ and arg_300_1.time_ <= var_303_23 + arg_303_0 then
				arg_300_1.var_.moveOldPosH02a = var_303_22.localPosition
			end

			local var_303_24 = 3.5

			if var_303_23 <= arg_300_1.time_ and arg_300_1.time_ < var_303_23 + var_303_24 then
				local var_303_25 = (arg_300_1.time_ - var_303_23) / var_303_24
				local var_303_26 = Vector3.New(0, 1, 9.5)

				var_303_22.localPosition = Vector3.Lerp(arg_300_1.var_.moveOldPosH02a, var_303_26, var_303_25)
			end

			if arg_300_1.time_ >= var_303_23 + var_303_24 and arg_300_1.time_ < var_303_23 + var_303_24 + arg_303_0 then
				var_303_22.localPosition = Vector3.New(0, 1, 9.5)
			end

			if arg_300_1.frameCnt_ <= 1 then
				arg_300_1.dialog_:SetActive(false)
			end

			local var_303_27 = 3
			local var_303_28 = 0.975

			if var_303_27 < arg_300_1.time_ and arg_300_1.time_ <= var_303_27 + arg_303_0 then
				arg_300_1.talkMaxDuration = 0

				arg_300_1.dialog_:SetActive(true)

				arg_300_1.dialogCg_.alpha = 0

				local var_303_29 = LeanTween.value(arg_300_1.dialog_, 0, 1, 0.3)

				var_303_29:setOnUpdate(LuaHelper.FloatAction(function(arg_304_0)
					arg_300_1.dialogCg_.alpha = arg_304_0
				end))
				var_303_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_300_1.dialog_)
					var_303_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_300_1.duration_ = arg_300_1.duration_ + 0.3

				SetActive(arg_300_1.leftNameGo_, false)

				arg_300_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_300_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_300_1:RecordName(arg_300_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_300_1.iconTrs_.gameObject, false)
				arg_300_1.callingController_:SetSelectedState("normal")

				local var_303_30 = arg_300_1:GetWordFromCfg(324572072)
				local var_303_31 = arg_300_1:FormatText(var_303_30.content)

				arg_300_1.text_.text = var_303_31

				LuaForUtil.ClearLinePrefixSymbol(arg_300_1.text_)

				local var_303_32 = 39
				local var_303_33 = utf8.len(var_303_31)
				local var_303_34 = var_303_32 <= 0 and var_303_28 or var_303_28 * (var_303_33 / var_303_32)

				if var_303_34 > 0 and var_303_28 < var_303_34 then
					arg_300_1.talkMaxDuration = var_303_34
					var_303_27 = var_303_27 + 0.3

					if var_303_34 + var_303_27 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_34 + var_303_27
					end
				end

				arg_300_1.text_.text = var_303_31
				arg_300_1.typewritter.percent = 0

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(false)
				arg_300_1:RecordContent(arg_300_1.text_.text)
			end

			local var_303_35 = var_303_27 + 0.3
			local var_303_36 = math.max(var_303_28, arg_300_1.talkMaxDuration)

			if var_303_35 <= arg_300_1.time_ and arg_300_1.time_ < var_303_35 + var_303_36 then
				arg_300_1.typewritter.percent = (arg_300_1.time_ - var_303_35) / var_303_36

				arg_300_1.typewritter:SetDirty()
			end

			if arg_300_1.time_ >= var_303_35 + var_303_36 and arg_300_1.time_ < var_303_35 + var_303_36 + arg_303_0 then
				arg_300_1.typewritter.percent = 1

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(true)
			end
		end

		arg_300_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				needEase = true,
				actorName = "H02a",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 3.5,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 10),
					endPos = Vector3.New(0, 1, 9.5),
					easeType = LeanTweenType.linear
				}
			}
		}

		arg_300_1:InitPlayNodeList()
	end,
	Play324572073 = function(arg_306_0, arg_306_1)
		arg_306_1.time_ = 0
		arg_306_1.frameCnt_ = 0
		arg_306_1.state_ = "playing"
		arg_306_1.curTalkId_ = 324572073
		arg_306_1.duration_ = 5

		SetActive(arg_306_1.tipsGo_, false)

		function arg_306_1.onSingleLineFinish_()
			arg_306_1.onSingleLineUpdate_ = nil
			arg_306_1.onSingleLineFinish_ = nil
			arg_306_1.state_ = "waiting"
		end

		function arg_306_1.playNext_(arg_308_0)
			if arg_308_0 == 1 then
				arg_306_0:Play324572074(arg_306_1)
			end
		end

		function arg_306_1.onSingleLineUpdate_(arg_309_0)
			local var_309_0 = 0
			local var_309_1 = 1

			if var_309_0 < arg_306_1.time_ and arg_306_1.time_ <= var_309_0 + arg_309_0 then
				arg_306_1.talkMaxDuration = 0
				arg_306_1.dialogCg_.alpha = 1

				arg_306_1.dialog_:SetActive(true)
				SetActive(arg_306_1.leftNameGo_, false)

				arg_306_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_306_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_306_1:RecordName(arg_306_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_306_1.iconTrs_.gameObject, false)
				arg_306_1.callingController_:SetSelectedState("normal")

				local var_309_2 = arg_306_1:GetWordFromCfg(324572073)
				local var_309_3 = arg_306_1:FormatText(var_309_2.content)

				arg_306_1.text_.text = var_309_3

				LuaForUtil.ClearLinePrefixSymbol(arg_306_1.text_)

				local var_309_4 = 40
				local var_309_5 = utf8.len(var_309_3)
				local var_309_6 = var_309_4 <= 0 and var_309_1 or var_309_1 * (var_309_5 / var_309_4)

				if var_309_6 > 0 and var_309_1 < var_309_6 then
					arg_306_1.talkMaxDuration = var_309_6

					if var_309_6 + var_309_0 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_6 + var_309_0
					end
				end

				arg_306_1.text_.text = var_309_3
				arg_306_1.typewritter.percent = 0

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(false)
				arg_306_1:RecordContent(arg_306_1.text_.text)
			end

			local var_309_7 = math.max(var_309_1, arg_306_1.talkMaxDuration)

			if var_309_0 <= arg_306_1.time_ and arg_306_1.time_ < var_309_0 + var_309_7 then
				arg_306_1.typewritter.percent = (arg_306_1.time_ - var_309_0) / var_309_7

				arg_306_1.typewritter:SetDirty()
			end

			if arg_306_1.time_ >= var_309_0 + var_309_7 and arg_306_1.time_ < var_309_0 + var_309_7 + arg_309_0 then
				arg_306_1.typewritter.percent = 1

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(true)
			end
		end

		arg_306_1.nodeConfigList_ = {}

		arg_306_1:InitPlayNodeList()
	end,
	Play324572074 = function(arg_310_0, arg_310_1)
		arg_310_1.time_ = 0
		arg_310_1.frameCnt_ = 0
		arg_310_1.state_ = "playing"
		arg_310_1.curTalkId_ = 324572074
		arg_310_1.duration_ = 5

		SetActive(arg_310_1.tipsGo_, false)

		function arg_310_1.onSingleLineFinish_()
			arg_310_1.onSingleLineUpdate_ = nil
			arg_310_1.onSingleLineFinish_ = nil
			arg_310_1.state_ = "waiting"
		end

		function arg_310_1.playNext_(arg_312_0)
			if arg_312_0 == 1 then
				arg_310_0:Play324572075(arg_310_1)
			end
		end

		function arg_310_1.onSingleLineUpdate_(arg_313_0)
			local var_313_0 = 0
			local var_313_1 = 1.325

			if var_313_0 < arg_310_1.time_ and arg_310_1.time_ <= var_313_0 + arg_313_0 then
				arg_310_1.talkMaxDuration = 0
				arg_310_1.dialogCg_.alpha = 1

				arg_310_1.dialog_:SetActive(true)
				SetActive(arg_310_1.leftNameGo_, false)

				arg_310_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_310_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_310_1:RecordName(arg_310_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_310_1.iconTrs_.gameObject, false)
				arg_310_1.callingController_:SetSelectedState("normal")

				local var_313_2 = arg_310_1:GetWordFromCfg(324572074)
				local var_313_3 = arg_310_1:FormatText(var_313_2.content)

				arg_310_1.text_.text = var_313_3

				LuaForUtil.ClearLinePrefixSymbol(arg_310_1.text_)

				local var_313_4 = 53
				local var_313_5 = utf8.len(var_313_3)
				local var_313_6 = var_313_4 <= 0 and var_313_1 or var_313_1 * (var_313_5 / var_313_4)

				if var_313_6 > 0 and var_313_1 < var_313_6 then
					arg_310_1.talkMaxDuration = var_313_6

					if var_313_6 + var_313_0 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_6 + var_313_0
					end
				end

				arg_310_1.text_.text = var_313_3
				arg_310_1.typewritter.percent = 0

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(false)
				arg_310_1:RecordContent(arg_310_1.text_.text)
			end

			local var_313_7 = math.max(var_313_1, arg_310_1.talkMaxDuration)

			if var_313_0 <= arg_310_1.time_ and arg_310_1.time_ < var_313_0 + var_313_7 then
				arg_310_1.typewritter.percent = (arg_310_1.time_ - var_313_0) / var_313_7

				arg_310_1.typewritter:SetDirty()
			end

			if arg_310_1.time_ >= var_313_0 + var_313_7 and arg_310_1.time_ < var_313_0 + var_313_7 + arg_313_0 then
				arg_310_1.typewritter.percent = 1

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(true)
			end
		end

		arg_310_1.nodeConfigList_ = {}

		arg_310_1:InitPlayNodeList()
	end,
	Play324572075 = function(arg_314_0, arg_314_1)
		arg_314_1.time_ = 0
		arg_314_1.frameCnt_ = 0
		arg_314_1.state_ = "playing"
		arg_314_1.curTalkId_ = 324572075
		arg_314_1.duration_ = 5

		SetActive(arg_314_1.tipsGo_, false)

		function arg_314_1.onSingleLineFinish_()
			arg_314_1.onSingleLineUpdate_ = nil
			arg_314_1.onSingleLineFinish_ = nil
			arg_314_1.state_ = "waiting"
		end

		function arg_314_1.playNext_(arg_316_0)
			if arg_316_0 == 1 then
				arg_314_0:Play324572076(arg_314_1)
			end
		end

		function arg_314_1.onSingleLineUpdate_(arg_317_0)
			local var_317_0 = 0
			local var_317_1 = 1.35

			if var_317_0 < arg_314_1.time_ and arg_314_1.time_ <= var_317_0 + arg_317_0 then
				arg_314_1.talkMaxDuration = 0
				arg_314_1.dialogCg_.alpha = 1

				arg_314_1.dialog_:SetActive(true)
				SetActive(arg_314_1.leftNameGo_, false)

				arg_314_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_314_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_314_1:RecordName(arg_314_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_314_1.iconTrs_.gameObject, false)
				arg_314_1.callingController_:SetSelectedState("normal")

				local var_317_2 = arg_314_1:GetWordFromCfg(324572075)
				local var_317_3 = arg_314_1:FormatText(var_317_2.content)

				arg_314_1.text_.text = var_317_3

				LuaForUtil.ClearLinePrefixSymbol(arg_314_1.text_)

				local var_317_4 = 54
				local var_317_5 = utf8.len(var_317_3)
				local var_317_6 = var_317_4 <= 0 and var_317_1 or var_317_1 * (var_317_5 / var_317_4)

				if var_317_6 > 0 and var_317_1 < var_317_6 then
					arg_314_1.talkMaxDuration = var_317_6

					if var_317_6 + var_317_0 > arg_314_1.duration_ then
						arg_314_1.duration_ = var_317_6 + var_317_0
					end
				end

				arg_314_1.text_.text = var_317_3
				arg_314_1.typewritter.percent = 0

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(false)
				arg_314_1:RecordContent(arg_314_1.text_.text)
			end

			local var_317_7 = math.max(var_317_1, arg_314_1.talkMaxDuration)

			if var_317_0 <= arg_314_1.time_ and arg_314_1.time_ < var_317_0 + var_317_7 then
				arg_314_1.typewritter.percent = (arg_314_1.time_ - var_317_0) / var_317_7

				arg_314_1.typewritter:SetDirty()
			end

			if arg_314_1.time_ >= var_317_0 + var_317_7 and arg_314_1.time_ < var_317_0 + var_317_7 + arg_317_0 then
				arg_314_1.typewritter.percent = 1

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(true)
			end
		end

		arg_314_1.nodeConfigList_ = {}

		arg_314_1:InitPlayNodeList()
	end,
	Play324572076 = function(arg_318_0, arg_318_1)
		arg_318_1.time_ = 0
		arg_318_1.frameCnt_ = 0
		arg_318_1.state_ = "playing"
		arg_318_1.curTalkId_ = 324572076
		arg_318_1.duration_ = 5

		SetActive(arg_318_1.tipsGo_, false)

		function arg_318_1.onSingleLineFinish_()
			arg_318_1.onSingleLineUpdate_ = nil
			arg_318_1.onSingleLineFinish_ = nil
			arg_318_1.state_ = "waiting"
		end

		function arg_318_1.playNext_(arg_320_0)
			if arg_320_0 == 1 then
				arg_318_0:Play324572077(arg_318_1)
			end
		end

		function arg_318_1.onSingleLineUpdate_(arg_321_0)
			local var_321_0 = 0.8
			local var_321_1 = 1

			if var_321_0 < arg_318_1.time_ and arg_318_1.time_ <= var_321_0 + arg_321_0 then
				local var_321_2 = "play"
				local var_321_3 = "effect"

				arg_318_1:AudioAction(var_321_2, var_321_3, "se_story_148", "se_story_148_whoosh01", "")
			end

			local var_321_4 = 0
			local var_321_5 = 0.95

			if var_321_4 < arg_318_1.time_ and arg_318_1.time_ <= var_321_4 + arg_321_0 then
				arg_318_1.talkMaxDuration = 0
				arg_318_1.dialogCg_.alpha = 1

				arg_318_1.dialog_:SetActive(true)
				SetActive(arg_318_1.leftNameGo_, false)

				arg_318_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_318_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_318_1:RecordName(arg_318_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_318_1.iconTrs_.gameObject, false)
				arg_318_1.callingController_:SetSelectedState("normal")

				local var_321_6 = arg_318_1:GetWordFromCfg(324572076)
				local var_321_7 = arg_318_1:FormatText(var_321_6.content)

				arg_318_1.text_.text = var_321_7

				LuaForUtil.ClearLinePrefixSymbol(arg_318_1.text_)

				local var_321_8 = 38
				local var_321_9 = utf8.len(var_321_7)
				local var_321_10 = var_321_8 <= 0 and var_321_5 or var_321_5 * (var_321_9 / var_321_8)

				if var_321_10 > 0 and var_321_5 < var_321_10 then
					arg_318_1.talkMaxDuration = var_321_10

					if var_321_10 + var_321_4 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_10 + var_321_4
					end
				end

				arg_318_1.text_.text = var_321_7
				arg_318_1.typewritter.percent = 0

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(false)
				arg_318_1:RecordContent(arg_318_1.text_.text)
			end

			local var_321_11 = math.max(var_321_5, arg_318_1.talkMaxDuration)

			if var_321_4 <= arg_318_1.time_ and arg_318_1.time_ < var_321_4 + var_321_11 then
				arg_318_1.typewritter.percent = (arg_318_1.time_ - var_321_4) / var_321_11

				arg_318_1.typewritter:SetDirty()
			end

			if arg_318_1.time_ >= var_321_4 + var_321_11 and arg_318_1.time_ < var_321_4 + var_321_11 + arg_321_0 then
				arg_318_1.typewritter.percent = 1

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(true)
			end
		end

		arg_318_1.nodeConfigList_ = {}

		arg_318_1:InitPlayNodeList()
	end,
	Play324572077 = function(arg_322_0, arg_322_1)
		arg_322_1.time_ = 0
		arg_322_1.frameCnt_ = 0
		arg_322_1.state_ = "playing"
		arg_322_1.curTalkId_ = 324572077
		arg_322_1.duration_ = 5

		SetActive(arg_322_1.tipsGo_, false)

		function arg_322_1.onSingleLineFinish_()
			arg_322_1.onSingleLineUpdate_ = nil
			arg_322_1.onSingleLineFinish_ = nil
			arg_322_1.state_ = "waiting"
		end

		function arg_322_1.playNext_(arg_324_0)
			if arg_324_0 == 1 then
				arg_322_0:Play324572078(arg_322_1)
			end
		end

		function arg_322_1.onSingleLineUpdate_(arg_325_0)
			local var_325_0 = 0
			local var_325_1 = 0.15

			if var_325_0 < arg_322_1.time_ and arg_322_1.time_ <= var_325_0 + arg_325_0 then
				arg_322_1.talkMaxDuration = 0
				arg_322_1.dialogCg_.alpha = 1

				arg_322_1.dialog_:SetActive(true)
				SetActive(arg_322_1.leftNameGo_, true)

				local var_325_2 = arg_322_1:FormatText(StoryNameCfg[7].name)

				arg_322_1.leftNameTxt_.text = var_325_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_322_1.leftNameTxt_.transform)

				arg_322_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_322_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_322_1:RecordName(arg_322_1.leftNameTxt_.text)
				SetActive(arg_322_1.iconTrs_.gameObject, true)
				arg_322_1.iconController_:SetSelectedState("hero")

				arg_322_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_322_1.callingController_:SetSelectedState("normal")

				arg_322_1.keyicon_.color = Color.New(1, 1, 1)
				arg_322_1.icon_.color = Color.New(1, 1, 1)

				local var_325_3 = arg_322_1:GetWordFromCfg(324572077)
				local var_325_4 = arg_322_1:FormatText(var_325_3.content)

				arg_322_1.text_.text = var_325_4

				LuaForUtil.ClearLinePrefixSymbol(arg_322_1.text_)

				local var_325_5 = 6
				local var_325_6 = utf8.len(var_325_4)
				local var_325_7 = var_325_5 <= 0 and var_325_1 or var_325_1 * (var_325_6 / var_325_5)

				if var_325_7 > 0 and var_325_1 < var_325_7 then
					arg_322_1.talkMaxDuration = var_325_7

					if var_325_7 + var_325_0 > arg_322_1.duration_ then
						arg_322_1.duration_ = var_325_7 + var_325_0
					end
				end

				arg_322_1.text_.text = var_325_4
				arg_322_1.typewritter.percent = 0

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(false)
				arg_322_1:RecordContent(arg_322_1.text_.text)
			end

			local var_325_8 = math.max(var_325_1, arg_322_1.talkMaxDuration)

			if var_325_0 <= arg_322_1.time_ and arg_322_1.time_ < var_325_0 + var_325_8 then
				arg_322_1.typewritter.percent = (arg_322_1.time_ - var_325_0) / var_325_8

				arg_322_1.typewritter:SetDirty()
			end

			if arg_322_1.time_ >= var_325_0 + var_325_8 and arg_322_1.time_ < var_325_0 + var_325_8 + arg_325_0 then
				arg_322_1.typewritter.percent = 1

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(true)
			end
		end

		arg_322_1.nodeConfigList_ = {}

		arg_322_1:InitPlayNodeList()
	end,
	Play324572078 = function(arg_326_0, arg_326_1)
		arg_326_1.time_ = 0
		arg_326_1.frameCnt_ = 0
		arg_326_1.state_ = "playing"
		arg_326_1.curTalkId_ = 324572078
		arg_326_1.duration_ = 1.07

		SetActive(arg_326_1.tipsGo_, false)

		function arg_326_1.onSingleLineFinish_()
			arg_326_1.onSingleLineUpdate_ = nil
			arg_326_1.onSingleLineFinish_ = nil
			arg_326_1.state_ = "waiting"
		end

		function arg_326_1.playNext_(arg_328_0)
			if arg_328_0 == 1 then
				arg_326_0:Play324572079(arg_326_1)
			end
		end

		function arg_326_1.onSingleLineUpdate_(arg_329_0)
			local var_329_0 = 0
			local var_329_1 = 0.075

			if var_329_0 < arg_326_1.time_ and arg_326_1.time_ <= var_329_0 + arg_329_0 then
				arg_326_1.talkMaxDuration = 0
				arg_326_1.dialogCg_.alpha = 1

				arg_326_1.dialog_:SetActive(true)
				SetActive(arg_326_1.leftNameGo_, true)

				local var_329_2 = arg_326_1:FormatText(StoryNameCfg[1450].name)

				arg_326_1.leftNameTxt_.text = var_329_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_326_1.leftNameTxt_.transform)

				arg_326_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_326_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_326_1:RecordName(arg_326_1.leftNameTxt_.text)
				SetActive(arg_326_1.iconTrs_.gameObject, true)
				arg_326_1.iconController_:SetSelectedState("hero")

				arg_326_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10170")

				arg_326_1.callingController_:SetSelectedState("normal")

				arg_326_1.keyicon_.color = Color.New(1, 1, 1)
				arg_326_1.icon_.color = Color.New(1, 1, 1)

				local var_329_3 = arg_326_1:GetWordFromCfg(324572078)
				local var_329_4 = arg_326_1:FormatText(var_329_3.content)

				arg_326_1.text_.text = var_329_4

				LuaForUtil.ClearLinePrefixSymbol(arg_326_1.text_)

				local var_329_5 = 3
				local var_329_6 = utf8.len(var_329_4)
				local var_329_7 = var_329_5 <= 0 and var_329_1 or var_329_1 * (var_329_6 / var_329_5)

				if var_329_7 > 0 and var_329_1 < var_329_7 then
					arg_326_1.talkMaxDuration = var_329_7

					if var_329_7 + var_329_0 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_7 + var_329_0
					end
				end

				arg_326_1.text_.text = var_329_4
				arg_326_1.typewritter.percent = 0

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324572", "324572078", "story_v_out_324572.awb") ~= 0 then
					local var_329_8 = manager.audio:GetVoiceLength("story_v_out_324572", "324572078", "story_v_out_324572.awb") / 1000

					if var_329_8 + var_329_0 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_8 + var_329_0
					end

					if var_329_3.prefab_name ~= "" and arg_326_1.actors_[var_329_3.prefab_name] ~= nil then
						local var_329_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_326_1.actors_[var_329_3.prefab_name].transform, "story_v_out_324572", "324572078", "story_v_out_324572.awb")

						arg_326_1:RecordAudio("324572078", var_329_9)
						arg_326_1:RecordAudio("324572078", var_329_9)
					else
						arg_326_1:AudioAction("play", "voice", "story_v_out_324572", "324572078", "story_v_out_324572.awb")
					end

					arg_326_1:RecordHistoryTalkVoice("story_v_out_324572", "324572078", "story_v_out_324572.awb")
				end

				arg_326_1:RecordContent(arg_326_1.text_.text)
			end

			local var_329_10 = math.max(var_329_1, arg_326_1.talkMaxDuration)

			if var_329_0 <= arg_326_1.time_ and arg_326_1.time_ < var_329_0 + var_329_10 then
				arg_326_1.typewritter.percent = (arg_326_1.time_ - var_329_0) / var_329_10

				arg_326_1.typewritter:SetDirty()
			end

			if arg_326_1.time_ >= var_329_0 + var_329_10 and arg_326_1.time_ < var_329_0 + var_329_10 + arg_329_0 then
				arg_326_1.typewritter.percent = 1

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(true)
			end
		end

		arg_326_1.nodeConfigList_ = {}

		arg_326_1:InitPlayNodeList()
	end,
	Play324572079 = function(arg_330_0, arg_330_1)
		arg_330_1.time_ = 0
		arg_330_1.frameCnt_ = 0
		arg_330_1.state_ = "playing"
		arg_330_1.curTalkId_ = 324572079
		arg_330_1.duration_ = 5

		SetActive(arg_330_1.tipsGo_, false)

		function arg_330_1.onSingleLineFinish_()
			arg_330_1.onSingleLineUpdate_ = nil
			arg_330_1.onSingleLineFinish_ = nil
			arg_330_1.state_ = "waiting"
		end

		function arg_330_1.playNext_(arg_332_0)
			if arg_332_0 == 1 then
				arg_330_0:Play324572080(arg_330_1)
			end
		end

		function arg_330_1.onSingleLineUpdate_(arg_333_0)
			local var_333_0 = arg_330_1.actors_["10170ui_story"].transform
			local var_333_1 = 0

			if var_333_1 < arg_330_1.time_ and arg_330_1.time_ <= var_333_1 + arg_333_0 then
				arg_330_1.var_.moveOldPos10170ui_story = var_333_0.localPosition

				local var_333_2 = GameObjectTools.GetOrAddComponent(var_333_0.gameObject, typeof(DynamicBoneHelper))

				if var_333_2 then
					var_333_2:EnableDynamicBone(false)
				end
			end

			local var_333_3 = 0.001

			if var_333_1 <= arg_330_1.time_ and arg_330_1.time_ < var_333_1 + var_333_3 then
				local var_333_4 = (arg_330_1.time_ - var_333_1) / var_333_3
				local var_333_5 = Vector3.New(0, 100, 0)

				var_333_0.localPosition = Vector3.Lerp(arg_330_1.var_.moveOldPos10170ui_story, var_333_5, var_333_4)

				local var_333_6 = manager.ui.mainCamera.transform.position - var_333_0.position

				var_333_0.forward = Vector3.New(var_333_6.x, var_333_6.y, var_333_6.z)

				local var_333_7 = var_333_0.localEulerAngles

				var_333_7.z = 0
				var_333_7.x = 0
				var_333_0.localEulerAngles = var_333_7
			end

			if arg_330_1.time_ >= var_333_1 + var_333_3 and arg_330_1.time_ < var_333_1 + var_333_3 + arg_333_0 then
				var_333_0.localPosition = Vector3.New(0, 100, 0)

				local var_333_8 = manager.ui.mainCamera.transform.position - var_333_0.position

				var_333_0.forward = Vector3.New(var_333_8.x, var_333_8.y, var_333_8.z)

				local var_333_9 = var_333_0.localEulerAngles

				var_333_9.z = 0
				var_333_9.x = 0
				var_333_0.localEulerAngles = var_333_9

				local var_333_10 = GameObjectTools.GetOrAddComponent(var_333_0.gameObject, typeof(DynamicBoneHelper))

				if var_333_10 then
					var_333_10:EnableDynamicBone(true)
				end
			end

			local var_333_11 = arg_330_1.actors_["10170ui_story"]
			local var_333_12 = 0

			if var_333_12 < arg_330_1.time_ and arg_330_1.time_ <= var_333_12 + arg_333_0 and not isNil(var_333_11) and arg_330_1.var_.characterEffect10170ui_story == nil then
				arg_330_1.var_.characterEffect10170ui_story = var_333_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_333_13 = 0.200000002980232

			if var_333_12 <= arg_330_1.time_ and arg_330_1.time_ < var_333_12 + var_333_13 and not isNil(var_333_11) then
				local var_333_14 = (arg_330_1.time_ - var_333_12) / var_333_13

				if arg_330_1.var_.characterEffect10170ui_story and not isNil(var_333_11) then
					local var_333_15 = Mathf.Lerp(0, 0.5, var_333_14)

					arg_330_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_330_1.var_.characterEffect10170ui_story.fillRatio = var_333_15
				end
			end

			if arg_330_1.time_ >= var_333_12 + var_333_13 and arg_330_1.time_ < var_333_12 + var_333_13 + arg_333_0 and not isNil(var_333_11) and arg_330_1.var_.characterEffect10170ui_story then
				local var_333_16 = 0.5

				arg_330_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_330_1.var_.characterEffect10170ui_story.fillRatio = var_333_16
			end

			local var_333_17 = 0
			local var_333_18 = 1.225

			if var_333_17 < arg_330_1.time_ and arg_330_1.time_ <= var_333_17 + arg_333_0 then
				arg_330_1.talkMaxDuration = 0
				arg_330_1.dialogCg_.alpha = 1

				arg_330_1.dialog_:SetActive(true)
				SetActive(arg_330_1.leftNameGo_, false)

				arg_330_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_330_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_330_1:RecordName(arg_330_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_330_1.iconTrs_.gameObject, false)
				arg_330_1.callingController_:SetSelectedState("normal")

				local var_333_19 = arg_330_1:GetWordFromCfg(324572079)
				local var_333_20 = arg_330_1:FormatText(var_333_19.content)

				arg_330_1.text_.text = var_333_20

				LuaForUtil.ClearLinePrefixSymbol(arg_330_1.text_)

				local var_333_21 = 49
				local var_333_22 = utf8.len(var_333_20)
				local var_333_23 = var_333_21 <= 0 and var_333_18 or var_333_18 * (var_333_22 / var_333_21)

				if var_333_23 > 0 and var_333_18 < var_333_23 then
					arg_330_1.talkMaxDuration = var_333_23

					if var_333_23 + var_333_17 > arg_330_1.duration_ then
						arg_330_1.duration_ = var_333_23 + var_333_17
					end
				end

				arg_330_1.text_.text = var_333_20
				arg_330_1.typewritter.percent = 0

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(false)
				arg_330_1:RecordContent(arg_330_1.text_.text)
			end

			local var_333_24 = math.max(var_333_18, arg_330_1.talkMaxDuration)

			if var_333_17 <= arg_330_1.time_ and arg_330_1.time_ < var_333_17 + var_333_24 then
				arg_330_1.typewritter.percent = (arg_330_1.time_ - var_333_17) / var_333_24

				arg_330_1.typewritter:SetDirty()
			end

			if arg_330_1.time_ >= var_333_17 + var_333_24 and arg_330_1.time_ < var_333_17 + var_333_24 + arg_333_0 then
				arg_330_1.typewritter.percent = 1

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(true)
			end
		end

		arg_330_1.nodeConfigList_ = {
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

		arg_330_1:InitPlayNodeList()
	end,
	Play324572080 = function(arg_334_0, arg_334_1)
		arg_334_1.time_ = 0
		arg_334_1.frameCnt_ = 0
		arg_334_1.state_ = "playing"
		arg_334_1.curTalkId_ = 324572080
		arg_334_1.duration_ = 4.65

		SetActive(arg_334_1.tipsGo_, false)

		function arg_334_1.onSingleLineFinish_()
			arg_334_1.onSingleLineUpdate_ = nil
			arg_334_1.onSingleLineFinish_ = nil
			arg_334_1.state_ = "waiting"
		end

		function arg_334_1.playNext_(arg_336_0)
			if arg_336_0 == 1 then
				arg_334_0:Play324572081(arg_334_1)
			end
		end

		function arg_334_1.onSingleLineUpdate_(arg_337_0)
			local var_337_0 = "MS2407"

			if arg_334_1.bgs_[var_337_0] == nil then
				local var_337_1 = Object.Instantiate(arg_334_1.paintGo_)

				var_337_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_337_0)
				var_337_1.name = var_337_0
				var_337_1.transform.parent = arg_334_1.stage_.transform
				var_337_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_334_1.bgs_[var_337_0] = var_337_1
			end

			local var_337_2 = 1.2

			if var_337_2 < arg_334_1.time_ and arg_334_1.time_ <= var_337_2 + arg_337_0 then
				local var_337_3 = manager.ui.mainCamera.transform.localPosition
				local var_337_4 = Vector3.New(0, 0, 10) + Vector3.New(var_337_3.x, var_337_3.y, 0)
				local var_337_5 = arg_334_1.bgs_.MS2407

				var_337_5.transform.localPosition = var_337_4
				var_337_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_337_6 = var_337_5:GetComponent("SpriteRenderer")

				if var_337_6 and var_337_6.sprite then
					local var_337_7 = (var_337_5.transform.localPosition - var_337_3).z
					local var_337_8 = manager.ui.mainCameraCom_
					local var_337_9 = 2 * var_337_7 * Mathf.Tan(var_337_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_337_10 = var_337_9 * var_337_8.aspect
					local var_337_11 = var_337_6.sprite.bounds.size.x
					local var_337_12 = var_337_6.sprite.bounds.size.y
					local var_337_13 = var_337_10 / var_337_11
					local var_337_14 = var_337_9 / var_337_12
					local var_337_15 = var_337_14 < var_337_13 and var_337_13 or var_337_14

					var_337_5.transform.localScale = Vector3.New(var_337_15, var_337_15, 0)
				end

				for iter_337_0, iter_337_1 in pairs(arg_334_1.bgs_) do
					if iter_337_0 ~= "MS2407" then
						iter_337_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_337_16 = 2.2

			if var_337_16 < arg_334_1.time_ and arg_334_1.time_ <= var_337_16 + arg_337_0 then
				arg_334_1.allBtn_.enabled = false
			end

			local var_337_17 = 0.3

			if arg_334_1.time_ >= var_337_16 + var_337_17 and arg_334_1.time_ < var_337_16 + var_337_17 + arg_337_0 then
				arg_334_1.allBtn_.enabled = true
			end

			local var_337_18 = manager.ui.mainCamera.transform
			local var_337_19 = 0

			if var_337_19 < arg_334_1.time_ and arg_334_1.time_ <= var_337_19 + arg_337_0 then
				local var_337_20 = arg_334_1.var_.effectwangshulianjian1
				local var_337_21
				local var_337_22 = var_337_18

				if not var_337_20 then
					var_337_20 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zxuanguang_night_in_keep"), var_337_22)
					var_337_20.name = "wangshulianjian1"
					arg_334_1.var_.effectwangshulianjian1 = var_337_20
				else
					var_337_20.transform:SetParent(var_337_22)
				end

				var_337_20.transform.localPosition = Vector3.New(0, 0, 0)
				var_337_20.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_337_23 = manager.ui.mainCamera.transform
			local var_337_24 = 1.5

			if var_337_24 < arg_334_1.time_ and arg_334_1.time_ <= var_337_24 + arg_337_0 then
				local var_337_25 = arg_334_1.var_.effectwangshulianjian2
				local var_337_26
				local var_337_27 = var_337_23

				if not var_337_25 then
					var_337_25 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zxuanguang_night_out"), var_337_27)
					var_337_25.name = "wangshulianjian2"
					arg_334_1.var_.effectwangshulianjian2 = var_337_25
				else
					var_337_25.transform:SetParent(var_337_27)
				end

				var_337_25.transform.localPosition = Vector3.New(0, 0, 0)
				var_337_25.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_337_28 = manager.ui.mainCamera.transform
			local var_337_29 = 2.5

			if var_337_29 < arg_334_1.time_ and arg_334_1.time_ <= var_337_29 + arg_337_0 then
				local var_337_30 = arg_334_1.var_.effectwangshulianjian2

				if var_337_30 then
					Object.Destroy(var_337_30)

					arg_334_1.var_.effectwangshulianjian2 = nil
				end
			end

			local var_337_31 = manager.ui.mainCamera.transform
			local var_337_32 = 1.5

			if var_337_32 < arg_334_1.time_ and arg_334_1.time_ <= var_337_32 + arg_337_0 then
				local var_337_33 = arg_334_1.var_.effectwangshulianjian1

				if var_337_33 then
					Object.Destroy(var_337_33)

					arg_334_1.var_.effectwangshulianjian1 = nil
				end
			end

			if arg_334_1.frameCnt_ <= 1 then
				arg_334_1.dialog_:SetActive(false)
			end

			local var_337_34 = 2.25
			local var_337_35 = 0.25

			if var_337_34 < arg_334_1.time_ and arg_334_1.time_ <= var_337_34 + arg_337_0 then
				arg_334_1.talkMaxDuration = 0

				arg_334_1.dialog_:SetActive(true)

				arg_334_1.dialogCg_.alpha = 0

				local var_337_36 = LeanTween.value(arg_334_1.dialog_, 0, 1, 0.3)

				var_337_36:setOnUpdate(LuaHelper.FloatAction(function(arg_338_0)
					arg_334_1.dialogCg_.alpha = arg_338_0
				end))
				var_337_36:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_334_1.dialog_)
					var_337_36:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_334_1.duration_ = arg_334_1.duration_ + 0.3

				SetActive(arg_334_1.leftNameGo_, true)

				local var_337_37 = arg_334_1:FormatText(StoryNameCfg[1450].name)

				arg_334_1.leftNameTxt_.text = var_337_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_334_1.leftNameTxt_.transform)

				arg_334_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_334_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_334_1:RecordName(arg_334_1.leftNameTxt_.text)
				SetActive(arg_334_1.iconTrs_.gameObject, false)
				arg_334_1.callingController_:SetSelectedState("normal")

				local var_337_38 = arg_334_1:GetWordFromCfg(324572080)
				local var_337_39 = arg_334_1:FormatText(var_337_38.content)

				arg_334_1.text_.text = var_337_39

				LuaForUtil.ClearLinePrefixSymbol(arg_334_1.text_)

				local var_337_40 = 10
				local var_337_41 = utf8.len(var_337_39)
				local var_337_42 = var_337_40 <= 0 and var_337_35 or var_337_35 * (var_337_41 / var_337_40)

				if var_337_42 > 0 and var_337_35 < var_337_42 then
					arg_334_1.talkMaxDuration = var_337_42
					var_337_34 = var_337_34 + 0.3

					if var_337_42 + var_337_34 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_42 + var_337_34
					end
				end

				arg_334_1.text_.text = var_337_39
				arg_334_1.typewritter.percent = 0

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324572", "324572080", "story_v_out_324572.awb") ~= 0 then
					local var_337_43 = manager.audio:GetVoiceLength("story_v_out_324572", "324572080", "story_v_out_324572.awb") / 1000

					if var_337_43 + var_337_34 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_43 + var_337_34
					end

					if var_337_38.prefab_name ~= "" and arg_334_1.actors_[var_337_38.prefab_name] ~= nil then
						local var_337_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_334_1.actors_[var_337_38.prefab_name].transform, "story_v_out_324572", "324572080", "story_v_out_324572.awb")

						arg_334_1:RecordAudio("324572080", var_337_44)
						arg_334_1:RecordAudio("324572080", var_337_44)
					else
						arg_334_1:AudioAction("play", "voice", "story_v_out_324572", "324572080", "story_v_out_324572.awb")
					end

					arg_334_1:RecordHistoryTalkVoice("story_v_out_324572", "324572080", "story_v_out_324572.awb")
				end

				arg_334_1:RecordContent(arg_334_1.text_.text)
			end

			local var_337_45 = var_337_34 + 0.3
			local var_337_46 = math.max(var_337_35, arg_334_1.talkMaxDuration)

			if var_337_45 <= arg_334_1.time_ and arg_334_1.time_ < var_337_45 + var_337_46 then
				arg_334_1.typewritter.percent = (arg_334_1.time_ - var_337_45) / var_337_46

				arg_334_1.typewritter:SetDirty()
			end

			if arg_334_1.time_ >= var_337_45 + var_337_46 and arg_334_1.time_ < var_337_45 + var_337_46 + arg_337_0 then
				arg_334_1.typewritter.percent = 1

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(true)
			end
		end

		arg_334_1.nodeConfigList_ = {}

		arg_334_1:InitPlayNodeList()
	end,
	Play324572081 = function(arg_340_0, arg_340_1)
		arg_340_1.time_ = 0
		arg_340_1.frameCnt_ = 0
		arg_340_1.state_ = "playing"
		arg_340_1.curTalkId_ = 324572081
		arg_340_1.duration_ = 5

		SetActive(arg_340_1.tipsGo_, false)

		function arg_340_1.onSingleLineFinish_()
			arg_340_1.onSingleLineUpdate_ = nil
			arg_340_1.onSingleLineFinish_ = nil
			arg_340_1.state_ = "waiting"
		end

		function arg_340_1.playNext_(arg_342_0)
			if arg_342_0 == 1 then
				arg_340_0:Play324572082(arg_340_1)
			end
		end

		function arg_340_1.onSingleLineUpdate_(arg_343_0)
			local var_343_0 = arg_340_1.actors_["10170ui_story"]
			local var_343_1 = 0

			if var_343_1 < arg_340_1.time_ and arg_340_1.time_ <= var_343_1 + arg_343_0 and not isNil(var_343_0) and arg_340_1.var_.characterEffect10170ui_story == nil then
				arg_340_1.var_.characterEffect10170ui_story = var_343_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_343_2 = 0.200000002980232

			if var_343_1 <= arg_340_1.time_ and arg_340_1.time_ < var_343_1 + var_343_2 and not isNil(var_343_0) then
				local var_343_3 = (arg_340_1.time_ - var_343_1) / var_343_2

				if arg_340_1.var_.characterEffect10170ui_story and not isNil(var_343_0) then
					local var_343_4 = Mathf.Lerp(0, 0.5, var_343_3)

					arg_340_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_340_1.var_.characterEffect10170ui_story.fillRatio = var_343_4
				end
			end

			if arg_340_1.time_ >= var_343_1 + var_343_2 and arg_340_1.time_ < var_343_1 + var_343_2 + arg_343_0 and not isNil(var_343_0) and arg_340_1.var_.characterEffect10170ui_story then
				local var_343_5 = 0.5

				arg_340_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_340_1.var_.characterEffect10170ui_story.fillRatio = var_343_5
			end

			local var_343_6 = 0
			local var_343_7 = 0.625

			if var_343_6 < arg_340_1.time_ and arg_340_1.time_ <= var_343_6 + arg_343_0 then
				arg_340_1.talkMaxDuration = 0
				arg_340_1.dialogCg_.alpha = 1

				arg_340_1.dialog_:SetActive(true)
				SetActive(arg_340_1.leftNameGo_, false)

				arg_340_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_340_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_340_1:RecordName(arg_340_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_340_1.iconTrs_.gameObject, false)
				arg_340_1.callingController_:SetSelectedState("normal")

				local var_343_8 = arg_340_1:GetWordFromCfg(324572081)
				local var_343_9 = arg_340_1:FormatText(var_343_8.content)

				arg_340_1.text_.text = var_343_9

				LuaForUtil.ClearLinePrefixSymbol(arg_340_1.text_)

				local var_343_10 = 25
				local var_343_11 = utf8.len(var_343_9)
				local var_343_12 = var_343_10 <= 0 and var_343_7 or var_343_7 * (var_343_11 / var_343_10)

				if var_343_12 > 0 and var_343_7 < var_343_12 then
					arg_340_1.talkMaxDuration = var_343_12

					if var_343_12 + var_343_6 > arg_340_1.duration_ then
						arg_340_1.duration_ = var_343_12 + var_343_6
					end
				end

				arg_340_1.text_.text = var_343_9
				arg_340_1.typewritter.percent = 0

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(false)
				arg_340_1:RecordContent(arg_340_1.text_.text)
			end

			local var_343_13 = math.max(var_343_7, arg_340_1.talkMaxDuration)

			if var_343_6 <= arg_340_1.time_ and arg_340_1.time_ < var_343_6 + var_343_13 then
				arg_340_1.typewritter.percent = (arg_340_1.time_ - var_343_6) / var_343_13

				arg_340_1.typewritter:SetDirty()
			end

			if arg_340_1.time_ >= var_343_6 + var_343_13 and arg_340_1.time_ < var_343_6 + var_343_13 + arg_343_0 then
				arg_340_1.typewritter.percent = 1

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(true)
			end
		end

		arg_340_1.nodeConfigList_ = {}

		arg_340_1:InitPlayNodeList()
	end,
	Play324572082 = function(arg_344_0, arg_344_1)
		arg_344_1.time_ = 0
		arg_344_1.frameCnt_ = 0
		arg_344_1.state_ = "playing"
		arg_344_1.curTalkId_ = 324572082
		arg_344_1.duration_ = 5

		SetActive(arg_344_1.tipsGo_, false)

		function arg_344_1.onSingleLineFinish_()
			arg_344_1.onSingleLineUpdate_ = nil
			arg_344_1.onSingleLineFinish_ = nil
			arg_344_1.state_ = "waiting"
		end

		function arg_344_1.playNext_(arg_346_0)
			if arg_346_0 == 1 then
				arg_344_0:Play324572083(arg_344_1)
			end
		end

		function arg_344_1.onSingleLineUpdate_(arg_347_0)
			local var_347_0 = 0
			local var_347_1 = 1.4

			if var_347_0 < arg_344_1.time_ and arg_344_1.time_ <= var_347_0 + arg_347_0 then
				arg_344_1.talkMaxDuration = 0
				arg_344_1.dialogCg_.alpha = 1

				arg_344_1.dialog_:SetActive(true)
				SetActive(arg_344_1.leftNameGo_, false)

				arg_344_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_344_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_344_1:RecordName(arg_344_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_344_1.iconTrs_.gameObject, false)
				arg_344_1.callingController_:SetSelectedState("normal")

				local var_347_2 = arg_344_1:GetWordFromCfg(324572082)
				local var_347_3 = arg_344_1:FormatText(var_347_2.content)

				arg_344_1.text_.text = var_347_3

				LuaForUtil.ClearLinePrefixSymbol(arg_344_1.text_)

				local var_347_4 = 56
				local var_347_5 = utf8.len(var_347_3)
				local var_347_6 = var_347_4 <= 0 and var_347_1 or var_347_1 * (var_347_5 / var_347_4)

				if var_347_6 > 0 and var_347_1 < var_347_6 then
					arg_344_1.talkMaxDuration = var_347_6

					if var_347_6 + var_347_0 > arg_344_1.duration_ then
						arg_344_1.duration_ = var_347_6 + var_347_0
					end
				end

				arg_344_1.text_.text = var_347_3
				arg_344_1.typewritter.percent = 0

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(false)
				arg_344_1:RecordContent(arg_344_1.text_.text)
			end

			local var_347_7 = math.max(var_347_1, arg_344_1.talkMaxDuration)

			if var_347_0 <= arg_344_1.time_ and arg_344_1.time_ < var_347_0 + var_347_7 then
				arg_344_1.typewritter.percent = (arg_344_1.time_ - var_347_0) / var_347_7

				arg_344_1.typewritter:SetDirty()
			end

			if arg_344_1.time_ >= var_347_0 + var_347_7 and arg_344_1.time_ < var_347_0 + var_347_7 + arg_347_0 then
				arg_344_1.typewritter.percent = 1

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(true)
			end
		end

		arg_344_1.nodeConfigList_ = {}

		arg_344_1:InitPlayNodeList()
	end,
	Play324572083 = function(arg_348_0, arg_348_1)
		arg_348_1.time_ = 0
		arg_348_1.frameCnt_ = 0
		arg_348_1.state_ = "playing"
		arg_348_1.curTalkId_ = 324572083
		arg_348_1.duration_ = 5

		SetActive(arg_348_1.tipsGo_, false)

		function arg_348_1.onSingleLineFinish_()
			arg_348_1.onSingleLineUpdate_ = nil
			arg_348_1.onSingleLineFinish_ = nil
			arg_348_1.state_ = "waiting"
		end

		function arg_348_1.playNext_(arg_350_0)
			if arg_350_0 == 1 then
				arg_348_0:Play324572084(arg_348_1)
			end
		end

		function arg_348_1.onSingleLineUpdate_(arg_351_0)
			local var_351_0 = 0.3
			local var_351_1 = 1

			if var_351_0 < arg_348_1.time_ and arg_348_1.time_ <= var_351_0 + arg_351_0 then
				local var_351_2 = "play"
				local var_351_3 = "effect"

				arg_348_1:AudioAction(var_351_2, var_351_3, "se_story_6", "se_story_6_draw_sword", "")
			end

			local var_351_4 = 0
			local var_351_5 = 0.725

			if var_351_4 < arg_348_1.time_ and arg_348_1.time_ <= var_351_4 + arg_351_0 then
				arg_348_1.talkMaxDuration = 0
				arg_348_1.dialogCg_.alpha = 1

				arg_348_1.dialog_:SetActive(true)
				SetActive(arg_348_1.leftNameGo_, false)

				arg_348_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_348_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_348_1:RecordName(arg_348_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_348_1.iconTrs_.gameObject, false)
				arg_348_1.callingController_:SetSelectedState("normal")

				local var_351_6 = arg_348_1:GetWordFromCfg(324572083)
				local var_351_7 = arg_348_1:FormatText(var_351_6.content)

				arg_348_1.text_.text = var_351_7

				LuaForUtil.ClearLinePrefixSymbol(arg_348_1.text_)

				local var_351_8 = 29
				local var_351_9 = utf8.len(var_351_7)
				local var_351_10 = var_351_8 <= 0 and var_351_5 or var_351_5 * (var_351_9 / var_351_8)

				if var_351_10 > 0 and var_351_5 < var_351_10 then
					arg_348_1.talkMaxDuration = var_351_10

					if var_351_10 + var_351_4 > arg_348_1.duration_ then
						arg_348_1.duration_ = var_351_10 + var_351_4
					end
				end

				arg_348_1.text_.text = var_351_7
				arg_348_1.typewritter.percent = 0

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(false)
				arg_348_1:RecordContent(arg_348_1.text_.text)
			end

			local var_351_11 = math.max(var_351_5, arg_348_1.talkMaxDuration)

			if var_351_4 <= arg_348_1.time_ and arg_348_1.time_ < var_351_4 + var_351_11 then
				arg_348_1.typewritter.percent = (arg_348_1.time_ - var_351_4) / var_351_11

				arg_348_1.typewritter:SetDirty()
			end

			if arg_348_1.time_ >= var_351_4 + var_351_11 and arg_348_1.time_ < var_351_4 + var_351_11 + arg_351_0 then
				arg_348_1.typewritter.percent = 1

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(true)
			end
		end

		arg_348_1.nodeConfigList_ = {}

		arg_348_1:InitPlayNodeList()
	end,
	Play324572084 = function(arg_352_0, arg_352_1)
		arg_352_1.time_ = 0
		arg_352_1.frameCnt_ = 0
		arg_352_1.state_ = "playing"
		arg_352_1.curTalkId_ = 324572084
		arg_352_1.duration_ = 2.43

		SetActive(arg_352_1.tipsGo_, false)

		function arg_352_1.onSingleLineFinish_()
			arg_352_1.onSingleLineUpdate_ = nil
			arg_352_1.onSingleLineFinish_ = nil
			arg_352_1.state_ = "waiting"
		end

		function arg_352_1.playNext_(arg_354_0)
			if arg_354_0 == 1 then
				arg_352_0:Play324572085(arg_352_1)
			end
		end

		function arg_352_1.onSingleLineUpdate_(arg_355_0)
			local var_355_0 = arg_352_1.actors_["10170ui_story"]
			local var_355_1 = 0

			if var_355_1 < arg_352_1.time_ and arg_352_1.time_ <= var_355_1 + arg_355_0 and not isNil(var_355_0) and arg_352_1.var_.characterEffect10170ui_story == nil then
				arg_352_1.var_.characterEffect10170ui_story = var_355_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_355_2 = 0.200000002980232

			if var_355_1 <= arg_352_1.time_ and arg_352_1.time_ < var_355_1 + var_355_2 and not isNil(var_355_0) then
				local var_355_3 = (arg_352_1.time_ - var_355_1) / var_355_2

				if arg_352_1.var_.characterEffect10170ui_story and not isNil(var_355_0) then
					arg_352_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_352_1.time_ >= var_355_1 + var_355_2 and arg_352_1.time_ < var_355_1 + var_355_2 + arg_355_0 and not isNil(var_355_0) and arg_352_1.var_.characterEffect10170ui_story then
				arg_352_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			local var_355_4 = 0
			local var_355_5 = 0.25

			if var_355_4 < arg_352_1.time_ and arg_352_1.time_ <= var_355_4 + arg_355_0 then
				arg_352_1.talkMaxDuration = 0
				arg_352_1.dialogCg_.alpha = 1

				arg_352_1.dialog_:SetActive(true)
				SetActive(arg_352_1.leftNameGo_, true)

				local var_355_6 = arg_352_1:FormatText(StoryNameCfg[1450].name)

				arg_352_1.leftNameTxt_.text = var_355_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_352_1.leftNameTxt_.transform)

				arg_352_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_352_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_352_1:RecordName(arg_352_1.leftNameTxt_.text)
				SetActive(arg_352_1.iconTrs_.gameObject, false)
				arg_352_1.callingController_:SetSelectedState("normal")

				local var_355_7 = arg_352_1:GetWordFromCfg(324572084)
				local var_355_8 = arg_352_1:FormatText(var_355_7.content)

				arg_352_1.text_.text = var_355_8

				LuaForUtil.ClearLinePrefixSymbol(arg_352_1.text_)

				local var_355_9 = 10
				local var_355_10 = utf8.len(var_355_8)
				local var_355_11 = var_355_9 <= 0 and var_355_5 or var_355_5 * (var_355_10 / var_355_9)

				if var_355_11 > 0 and var_355_5 < var_355_11 then
					arg_352_1.talkMaxDuration = var_355_11

					if var_355_11 + var_355_4 > arg_352_1.duration_ then
						arg_352_1.duration_ = var_355_11 + var_355_4
					end
				end

				arg_352_1.text_.text = var_355_8
				arg_352_1.typewritter.percent = 0

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324572", "324572084", "story_v_out_324572.awb") ~= 0 then
					local var_355_12 = manager.audio:GetVoiceLength("story_v_out_324572", "324572084", "story_v_out_324572.awb") / 1000

					if var_355_12 + var_355_4 > arg_352_1.duration_ then
						arg_352_1.duration_ = var_355_12 + var_355_4
					end

					if var_355_7.prefab_name ~= "" and arg_352_1.actors_[var_355_7.prefab_name] ~= nil then
						local var_355_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_352_1.actors_[var_355_7.prefab_name].transform, "story_v_out_324572", "324572084", "story_v_out_324572.awb")

						arg_352_1:RecordAudio("324572084", var_355_13)
						arg_352_1:RecordAudio("324572084", var_355_13)
					else
						arg_352_1:AudioAction("play", "voice", "story_v_out_324572", "324572084", "story_v_out_324572.awb")
					end

					arg_352_1:RecordHistoryTalkVoice("story_v_out_324572", "324572084", "story_v_out_324572.awb")
				end

				arg_352_1:RecordContent(arg_352_1.text_.text)
			end

			local var_355_14 = math.max(var_355_5, arg_352_1.talkMaxDuration)

			if var_355_4 <= arg_352_1.time_ and arg_352_1.time_ < var_355_4 + var_355_14 then
				arg_352_1.typewritter.percent = (arg_352_1.time_ - var_355_4) / var_355_14

				arg_352_1.typewritter:SetDirty()
			end

			if arg_352_1.time_ >= var_355_4 + var_355_14 and arg_352_1.time_ < var_355_4 + var_355_14 + arg_355_0 then
				arg_352_1.typewritter.percent = 1

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(true)
			end
		end

		arg_352_1.nodeConfigList_ = {}

		arg_352_1:InitPlayNodeList()
	end,
	Play324572085 = function(arg_356_0, arg_356_1)
		arg_356_1.time_ = 0
		arg_356_1.frameCnt_ = 0
		arg_356_1.state_ = "playing"
		arg_356_1.curTalkId_ = 324572085
		arg_356_1.duration_ = 5

		SetActive(arg_356_1.tipsGo_, false)

		function arg_356_1.onSingleLineFinish_()
			arg_356_1.onSingleLineUpdate_ = nil
			arg_356_1.onSingleLineFinish_ = nil
			arg_356_1.state_ = "waiting"
		end

		function arg_356_1.playNext_(arg_358_0)
			if arg_358_0 == 1 then
				arg_356_0:Play324572086(arg_356_1)
			end
		end

		function arg_356_1.onSingleLineUpdate_(arg_359_0)
			local var_359_0 = arg_356_1.actors_["10170ui_story"]
			local var_359_1 = 0

			if var_359_1 < arg_356_1.time_ and arg_356_1.time_ <= var_359_1 + arg_359_0 and not isNil(var_359_0) and arg_356_1.var_.characterEffect10170ui_story == nil then
				arg_356_1.var_.characterEffect10170ui_story = var_359_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_359_2 = 0.200000002980232

			if var_359_1 <= arg_356_1.time_ and arg_356_1.time_ < var_359_1 + var_359_2 and not isNil(var_359_0) then
				local var_359_3 = (arg_356_1.time_ - var_359_1) / var_359_2

				if arg_356_1.var_.characterEffect10170ui_story and not isNil(var_359_0) then
					local var_359_4 = Mathf.Lerp(0, 0.5, var_359_3)

					arg_356_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_356_1.var_.characterEffect10170ui_story.fillRatio = var_359_4
				end
			end

			if arg_356_1.time_ >= var_359_1 + var_359_2 and arg_356_1.time_ < var_359_1 + var_359_2 + arg_359_0 and not isNil(var_359_0) and arg_356_1.var_.characterEffect10170ui_story then
				local var_359_5 = 0.5

				arg_356_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_356_1.var_.characterEffect10170ui_story.fillRatio = var_359_5
			end

			local var_359_6 = 0
			local var_359_7 = 0.1

			if var_359_6 < arg_356_1.time_ and arg_356_1.time_ <= var_359_6 + arg_359_0 then
				arg_356_1.talkMaxDuration = 0
				arg_356_1.dialogCg_.alpha = 1

				arg_356_1.dialog_:SetActive(true)
				SetActive(arg_356_1.leftNameGo_, true)

				local var_359_8 = arg_356_1:FormatText(StoryNameCfg[7].name)

				arg_356_1.leftNameTxt_.text = var_359_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_356_1.leftNameTxt_.transform)

				arg_356_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_356_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_356_1:RecordName(arg_356_1.leftNameTxt_.text)
				SetActive(arg_356_1.iconTrs_.gameObject, true)
				arg_356_1.iconController_:SetSelectedState("hero")

				arg_356_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_356_1.callingController_:SetSelectedState("normal")

				arg_356_1.keyicon_.color = Color.New(1, 1, 1)
				arg_356_1.icon_.color = Color.New(1, 1, 1)

				local var_359_9 = arg_356_1:GetWordFromCfg(324572085)
				local var_359_10 = arg_356_1:FormatText(var_359_9.content)

				arg_356_1.text_.text = var_359_10

				LuaForUtil.ClearLinePrefixSymbol(arg_356_1.text_)

				local var_359_11 = 4
				local var_359_12 = utf8.len(var_359_10)
				local var_359_13 = var_359_11 <= 0 and var_359_7 or var_359_7 * (var_359_12 / var_359_11)

				if var_359_13 > 0 and var_359_7 < var_359_13 then
					arg_356_1.talkMaxDuration = var_359_13

					if var_359_13 + var_359_6 > arg_356_1.duration_ then
						arg_356_1.duration_ = var_359_13 + var_359_6
					end
				end

				arg_356_1.text_.text = var_359_10
				arg_356_1.typewritter.percent = 0

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(false)
				arg_356_1:RecordContent(arg_356_1.text_.text)
			end

			local var_359_14 = math.max(var_359_7, arg_356_1.talkMaxDuration)

			if var_359_6 <= arg_356_1.time_ and arg_356_1.time_ < var_359_6 + var_359_14 then
				arg_356_1.typewritter.percent = (arg_356_1.time_ - var_359_6) / var_359_14

				arg_356_1.typewritter:SetDirty()
			end

			if arg_356_1.time_ >= var_359_6 + var_359_14 and arg_356_1.time_ < var_359_6 + var_359_14 + arg_359_0 then
				arg_356_1.typewritter.percent = 1

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(true)
			end
		end

		arg_356_1.nodeConfigList_ = {}

		arg_356_1:InitPlayNodeList()
	end,
	Play324572086 = function(arg_360_0, arg_360_1)
		arg_360_1.time_ = 0
		arg_360_1.frameCnt_ = 0
		arg_360_1.state_ = "playing"
		arg_360_1.curTalkId_ = 324572086
		arg_360_1.duration_ = 5

		SetActive(arg_360_1.tipsGo_, false)

		function arg_360_1.onSingleLineFinish_()
			arg_360_1.onSingleLineUpdate_ = nil
			arg_360_1.onSingleLineFinish_ = nil
			arg_360_1.state_ = "waiting"
		end

		function arg_360_1.playNext_(arg_362_0)
			if arg_362_0 == 1 then
				arg_360_0:Play324572087(arg_360_1)
			end
		end

		function arg_360_1.onSingleLineUpdate_(arg_363_0)
			local var_363_0 = 0
			local var_363_1 = 0.85

			if var_363_0 < arg_360_1.time_ and arg_360_1.time_ <= var_363_0 + arg_363_0 then
				arg_360_1.talkMaxDuration = 0
				arg_360_1.dialogCg_.alpha = 1

				arg_360_1.dialog_:SetActive(true)
				SetActive(arg_360_1.leftNameGo_, false)

				arg_360_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_360_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_360_1:RecordName(arg_360_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_360_1.iconTrs_.gameObject, false)
				arg_360_1.callingController_:SetSelectedState("normal")

				local var_363_2 = arg_360_1:GetWordFromCfg(324572086)
				local var_363_3 = arg_360_1:FormatText(var_363_2.content)

				arg_360_1.text_.text = var_363_3

				LuaForUtil.ClearLinePrefixSymbol(arg_360_1.text_)

				local var_363_4 = 34
				local var_363_5 = utf8.len(var_363_3)
				local var_363_6 = var_363_4 <= 0 and var_363_1 or var_363_1 * (var_363_5 / var_363_4)

				if var_363_6 > 0 and var_363_1 < var_363_6 then
					arg_360_1.talkMaxDuration = var_363_6

					if var_363_6 + var_363_0 > arg_360_1.duration_ then
						arg_360_1.duration_ = var_363_6 + var_363_0
					end
				end

				arg_360_1.text_.text = var_363_3
				arg_360_1.typewritter.percent = 0

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(false)
				arg_360_1:RecordContent(arg_360_1.text_.text)
			end

			local var_363_7 = math.max(var_363_1, arg_360_1.talkMaxDuration)

			if var_363_0 <= arg_360_1.time_ and arg_360_1.time_ < var_363_0 + var_363_7 then
				arg_360_1.typewritter.percent = (arg_360_1.time_ - var_363_0) / var_363_7

				arg_360_1.typewritter:SetDirty()
			end

			if arg_360_1.time_ >= var_363_0 + var_363_7 and arg_360_1.time_ < var_363_0 + var_363_7 + arg_363_0 then
				arg_360_1.typewritter.percent = 1

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(true)
			end
		end

		arg_360_1.nodeConfigList_ = {}

		arg_360_1:InitPlayNodeList()
	end,
	Play324572087 = function(arg_364_0, arg_364_1)
		arg_364_1.time_ = 0
		arg_364_1.frameCnt_ = 0
		arg_364_1.state_ = "playing"
		arg_364_1.curTalkId_ = 324572087
		arg_364_1.duration_ = 6.37

		SetActive(arg_364_1.tipsGo_, false)

		function arg_364_1.onSingleLineFinish_()
			arg_364_1.onSingleLineUpdate_ = nil
			arg_364_1.onSingleLineFinish_ = nil
			arg_364_1.state_ = "waiting"
		end

		function arg_364_1.playNext_(arg_366_0)
			if arg_366_0 == 1 then
				arg_364_0:Play324572088(arg_364_1)
			end
		end

		function arg_364_1.onSingleLineUpdate_(arg_367_0)
			local var_367_0 = 0.366666666666667
			local var_367_1 = 1

			if var_367_0 < arg_364_1.time_ and arg_364_1.time_ <= var_367_0 + arg_367_0 then
				local var_367_2 = "play"
				local var_367_3 = "effect"

				arg_364_1:AudioAction(var_367_2, var_367_3, "se_story_150", "se_story_150_sword12", "")
			end

			local var_367_4 = arg_364_1.bgs_.MS2407.transform
			local var_367_5 = 0

			if var_367_5 < arg_364_1.time_ and arg_364_1.time_ <= var_367_5 + arg_367_0 then
				arg_364_1.var_.moveOldPosMS2407 = var_367_4.localPosition
			end

			local var_367_6 = 1.36666666666667

			if var_367_5 <= arg_364_1.time_ and arg_364_1.time_ < var_367_5 + var_367_6 then
				local var_367_7 = (arg_364_1.time_ - var_367_5) / var_367_6
				local var_367_8 = Vector3.New(0, 0.49, 4.02)

				var_367_4.localPosition = Vector3.Lerp(arg_364_1.var_.moveOldPosMS2407, var_367_8, var_367_7)
			end

			if arg_364_1.time_ >= var_367_5 + var_367_6 and arg_364_1.time_ < var_367_5 + var_367_6 + arg_367_0 then
				var_367_4.localPosition = Vector3.New(0, 0.49, 4.02)
			end

			local var_367_9 = 0

			if var_367_9 < arg_364_1.time_ and arg_364_1.time_ <= var_367_9 + arg_367_0 then
				arg_364_1.allBtn_.enabled = false
			end

			local var_367_10 = 1.7

			if arg_364_1.time_ >= var_367_9 + var_367_10 and arg_364_1.time_ < var_367_9 + var_367_10 + arg_367_0 then
				arg_364_1.allBtn_.enabled = true
			end

			local var_367_11 = 1.36666666666667
			local var_367_12 = 1.675

			if var_367_11 < arg_364_1.time_ and arg_364_1.time_ <= var_367_11 + arg_367_0 then
				arg_364_1.talkMaxDuration = 0
				arg_364_1.dialogCg_.alpha = 1

				arg_364_1.dialog_:SetActive(true)
				SetActive(arg_364_1.leftNameGo_, false)

				arg_364_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_364_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_364_1:RecordName(arg_364_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_364_1.iconTrs_.gameObject, false)
				arg_364_1.callingController_:SetSelectedState("normal")

				local var_367_13 = arg_364_1:GetWordFromCfg(324572087)
				local var_367_14 = arg_364_1:FormatText(var_367_13.content)

				arg_364_1.text_.text = var_367_14

				LuaForUtil.ClearLinePrefixSymbol(arg_364_1.text_)

				local var_367_15 = 67
				local var_367_16 = utf8.len(var_367_14)
				local var_367_17 = var_367_15 <= 0 and var_367_12 or var_367_12 * (var_367_16 / var_367_15)

				if var_367_17 > 0 and var_367_12 < var_367_17 then
					arg_364_1.talkMaxDuration = var_367_17

					if var_367_17 + var_367_11 > arg_364_1.duration_ then
						arg_364_1.duration_ = var_367_17 + var_367_11
					end
				end

				arg_364_1.text_.text = var_367_14
				arg_364_1.typewritter.percent = 0

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(false)
				arg_364_1:RecordContent(arg_364_1.text_.text)
			end

			local var_367_18 = math.max(var_367_12, arg_364_1.talkMaxDuration)

			if var_367_11 <= arg_364_1.time_ and arg_364_1.time_ < var_367_11 + var_367_18 then
				arg_364_1.typewritter.percent = (arg_364_1.time_ - var_367_11) / var_367_18

				arg_364_1.typewritter:SetDirty()
			end

			if arg_364_1.time_ >= var_367_11 + var_367_18 and arg_364_1.time_ < var_367_11 + var_367_18 + arg_367_0 then
				arg_364_1.typewritter.percent = 1

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(true)
			end
		end

		arg_364_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "MS2407",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 1.36666666666667,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = true,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 10),
					endPos = Vector3.New(0, 0.49, 4.02),
					easeType = LeanTweenType.easeInOutExpo
				}
			}
		}

		arg_364_1:InitPlayNodeList()
	end,
	Play324572088 = function(arg_368_0, arg_368_1)
		arg_368_1.time_ = 0
		arg_368_1.frameCnt_ = 0
		arg_368_1.state_ = "playing"
		arg_368_1.curTalkId_ = 324572088
		arg_368_1.duration_ = 5

		SetActive(arg_368_1.tipsGo_, false)

		function arg_368_1.onSingleLineFinish_()
			arg_368_1.onSingleLineUpdate_ = nil
			arg_368_1.onSingleLineFinish_ = nil
			arg_368_1.state_ = "waiting"
		end

		function arg_368_1.playNext_(arg_370_0)
			if arg_370_0 == 1 then
				arg_368_0:Play324572089(arg_368_1)
			end
		end

		function arg_368_1.onSingleLineUpdate_(arg_371_0)
			local var_371_0 = 0.1
			local var_371_1 = 1

			if var_371_0 < arg_368_1.time_ and arg_368_1.time_ <= var_371_0 + arg_371_0 then
				local var_371_2 = "play"
				local var_371_3 = "effect"

				arg_368_1:AudioAction(var_371_2, var_371_3, "se_story_122_01", "se_story_122_01_dizzy", "")
			end

			local var_371_4 = 0
			local var_371_5 = 1.625

			if var_371_4 < arg_368_1.time_ and arg_368_1.time_ <= var_371_4 + arg_371_0 then
				arg_368_1.talkMaxDuration = 0
				arg_368_1.dialogCg_.alpha = 1

				arg_368_1.dialog_:SetActive(true)
				SetActive(arg_368_1.leftNameGo_, false)

				arg_368_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_368_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_368_1:RecordName(arg_368_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_368_1.iconTrs_.gameObject, false)
				arg_368_1.callingController_:SetSelectedState("normal")

				local var_371_6 = arg_368_1:GetWordFromCfg(324572088)
				local var_371_7 = arg_368_1:FormatText(var_371_6.content)

				arg_368_1.text_.text = var_371_7

				LuaForUtil.ClearLinePrefixSymbol(arg_368_1.text_)

				local var_371_8 = 65
				local var_371_9 = utf8.len(var_371_7)
				local var_371_10 = var_371_8 <= 0 and var_371_5 or var_371_5 * (var_371_9 / var_371_8)

				if var_371_10 > 0 and var_371_5 < var_371_10 then
					arg_368_1.talkMaxDuration = var_371_10

					if var_371_10 + var_371_4 > arg_368_1.duration_ then
						arg_368_1.duration_ = var_371_10 + var_371_4
					end
				end

				arg_368_1.text_.text = var_371_7
				arg_368_1.typewritter.percent = 0

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(false)
				arg_368_1:RecordContent(arg_368_1.text_.text)
			end

			local var_371_11 = math.max(var_371_5, arg_368_1.talkMaxDuration)

			if var_371_4 <= arg_368_1.time_ and arg_368_1.time_ < var_371_4 + var_371_11 then
				arg_368_1.typewritter.percent = (arg_368_1.time_ - var_371_4) / var_371_11

				arg_368_1.typewritter:SetDirty()
			end

			if arg_368_1.time_ >= var_371_4 + var_371_11 and arg_368_1.time_ < var_371_4 + var_371_11 + arg_371_0 then
				arg_368_1.typewritter.percent = 1

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(true)
			end
		end

		arg_368_1.nodeConfigList_ = {}

		arg_368_1:InitPlayNodeList()
	end,
	Play324572089 = function(arg_372_0, arg_372_1)
		arg_372_1.time_ = 0
		arg_372_1.frameCnt_ = 0
		arg_372_1.state_ = "playing"
		arg_372_1.curTalkId_ = 324572089
		arg_372_1.duration_ = 8.27

		SetActive(arg_372_1.tipsGo_, false)

		function arg_372_1.onSingleLineFinish_()
			arg_372_1.onSingleLineUpdate_ = nil
			arg_372_1.onSingleLineFinish_ = nil
			arg_372_1.state_ = "waiting"
		end

		function arg_372_1.playNext_(arg_374_0)
			if arg_374_0 == 1 then
				arg_372_0:Play324572090(arg_372_1)
			end
		end

		function arg_372_1.onSingleLineUpdate_(arg_375_0)
			local var_375_0 = "ST2004"

			if arg_372_1.bgs_[var_375_0] == nil then
				local var_375_1 = Object.Instantiate(arg_372_1.paintGo_)

				var_375_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_375_0)
				var_375_1.name = var_375_0
				var_375_1.transform.parent = arg_372_1.stage_.transform
				var_375_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_372_1.bgs_[var_375_0] = var_375_1
			end

			local var_375_2 = 1.3

			if var_375_2 < arg_372_1.time_ and arg_372_1.time_ <= var_375_2 + arg_375_0 then
				local var_375_3 = manager.ui.mainCamera.transform.localPosition
				local var_375_4 = Vector3.New(0, 0, 10) + Vector3.New(var_375_3.x, var_375_3.y, 0)
				local var_375_5 = arg_372_1.bgs_.ST2004

				var_375_5.transform.localPosition = var_375_4
				var_375_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_375_6 = var_375_5:GetComponent("SpriteRenderer")

				if var_375_6 and var_375_6.sprite then
					local var_375_7 = (var_375_5.transform.localPosition - var_375_3).z
					local var_375_8 = manager.ui.mainCameraCom_
					local var_375_9 = 2 * var_375_7 * Mathf.Tan(var_375_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_375_10 = var_375_9 * var_375_8.aspect
					local var_375_11 = var_375_6.sprite.bounds.size.x
					local var_375_12 = var_375_6.sprite.bounds.size.y
					local var_375_13 = var_375_10 / var_375_11
					local var_375_14 = var_375_9 / var_375_12
					local var_375_15 = var_375_14 < var_375_13 and var_375_13 or var_375_14

					var_375_5.transform.localScale = Vector3.New(var_375_15, var_375_15, 0)
				end

				for iter_375_0, iter_375_1 in pairs(arg_372_1.bgs_) do
					if iter_375_0 ~= "ST2004" then
						iter_375_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_375_16 = 3.299999999999

			if var_375_16 < arg_372_1.time_ and arg_372_1.time_ <= var_375_16 + arg_375_0 then
				arg_372_1.allBtn_.enabled = false
			end

			local var_375_17 = 0.3

			if arg_372_1.time_ >= var_375_16 + var_375_17 and arg_372_1.time_ < var_375_16 + var_375_17 + arg_375_0 then
				arg_372_1.allBtn_.enabled = true
			end

			local var_375_18 = 0

			if var_375_18 < arg_372_1.time_ and arg_372_1.time_ <= var_375_18 + arg_375_0 then
				arg_372_1.mask_.enabled = true
				arg_372_1.mask_.raycastTarget = true

				arg_372_1:SetGaussion(false)
			end

			local var_375_19 = 1.3

			if var_375_18 <= arg_372_1.time_ and arg_372_1.time_ < var_375_18 + var_375_19 then
				local var_375_20 = (arg_372_1.time_ - var_375_18) / var_375_19
				local var_375_21 = Color.New(0, 0, 0)

				var_375_21.a = Mathf.Lerp(0, 1, var_375_20)
				arg_372_1.mask_.color = var_375_21
			end

			if arg_372_1.time_ >= var_375_18 + var_375_19 and arg_372_1.time_ < var_375_18 + var_375_19 + arg_375_0 then
				local var_375_22 = Color.New(0, 0, 0)

				var_375_22.a = 1
				arg_372_1.mask_.color = var_375_22
			end

			local var_375_23 = 1.3

			if var_375_23 < arg_372_1.time_ and arg_372_1.time_ <= var_375_23 + arg_375_0 then
				arg_372_1.mask_.enabled = true
				arg_372_1.mask_.raycastTarget = true

				arg_372_1:SetGaussion(false)
			end

			local var_375_24 = 2

			if var_375_23 <= arg_372_1.time_ and arg_372_1.time_ < var_375_23 + var_375_24 then
				local var_375_25 = (arg_372_1.time_ - var_375_23) / var_375_24
				local var_375_26 = Color.New(0, 0, 0)

				var_375_26.a = Mathf.Lerp(1, 0, var_375_25)
				arg_372_1.mask_.color = var_375_26
			end

			if arg_372_1.time_ >= var_375_23 + var_375_24 and arg_372_1.time_ < var_375_23 + var_375_24 + arg_375_0 then
				local var_375_27 = Color.New(0, 0, 0)
				local var_375_28 = 0

				arg_372_1.mask_.enabled = false
				var_375_27.a = var_375_28
				arg_372_1.mask_.color = var_375_27
			end

			local var_375_29 = 1.4
			local var_375_30 = 1

			if var_375_29 < arg_372_1.time_ and arg_372_1.time_ <= var_375_29 + arg_375_0 then
				local var_375_31 = "stop"
				local var_375_32 = "effect"

				arg_372_1:AudioAction(var_375_31, var_375_32, "se_story_122_01", "se_story_122_01_dizzy", "")
			end

			local var_375_33 = 2.5
			local var_375_34 = 0.8

			if var_375_33 < arg_372_1.time_ and arg_372_1.time_ <= var_375_33 + arg_375_0 then
				local var_375_35 = "play"
				local var_375_36 = "effect"

				arg_372_1:AudioAction(var_375_35, var_375_36, "se_story_145", "se_story_145_amb_ST0512", "")
			end

			local var_375_37 = 0
			local var_375_38 = 1

			if var_375_37 < arg_372_1.time_ and arg_372_1.time_ <= var_375_37 + arg_375_0 then
				local var_375_39 = "play"
				local var_375_40 = "effect"

				arg_372_1:AudioAction(var_375_39, var_375_40, "ui_battle", "ui_battle_stopbgm", "")
			end

			if arg_372_1.frameCnt_ <= 1 then
				arg_372_1.dialog_:SetActive(false)
			end

			local var_375_41 = 3.26700000017881
			local var_375_42 = 0.05

			if var_375_41 < arg_372_1.time_ and arg_372_1.time_ <= var_375_41 + arg_375_0 then
				arg_372_1.talkMaxDuration = 0

				arg_372_1.dialog_:SetActive(true)

				arg_372_1.dialogCg_.alpha = 0

				local var_375_43 = LeanTween.value(arg_372_1.dialog_, 0, 1, 0.3)

				var_375_43:setOnUpdate(LuaHelper.FloatAction(function(arg_376_0)
					arg_372_1.dialogCg_.alpha = arg_376_0
				end))
				var_375_43:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_372_1.dialog_)
					var_375_43:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_372_1.duration_ = arg_372_1.duration_ + 0.3

				SetActive(arg_372_1.leftNameGo_, true)

				local var_375_44 = arg_372_1:FormatText(StoryNameCfg[7].name)

				arg_372_1.leftNameTxt_.text = var_375_44

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_372_1.leftNameTxt_.transform)

				arg_372_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_372_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_372_1:RecordName(arg_372_1.leftNameTxt_.text)
				SetActive(arg_372_1.iconTrs_.gameObject, true)
				arg_372_1.iconController_:SetSelectedState("hero")

				arg_372_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_372_1.callingController_:SetSelectedState("normal")

				arg_372_1.keyicon_.color = Color.New(1, 1, 1)
				arg_372_1.icon_.color = Color.New(1, 1, 1)

				local var_375_45 = arg_372_1:GetWordFromCfg(324572089)
				local var_375_46 = arg_372_1:FormatText(var_375_45.content)

				arg_372_1.text_.text = var_375_46

				LuaForUtil.ClearLinePrefixSymbol(arg_372_1.text_)

				local var_375_47 = 2
				local var_375_48 = utf8.len(var_375_46)
				local var_375_49 = var_375_47 <= 0 and var_375_42 or var_375_42 * (var_375_48 / var_375_47)

				if var_375_49 > 0 and var_375_42 < var_375_49 then
					arg_372_1.talkMaxDuration = var_375_49
					var_375_41 = var_375_41 + 0.3

					if var_375_49 + var_375_41 > arg_372_1.duration_ then
						arg_372_1.duration_ = var_375_49 + var_375_41
					end
				end

				arg_372_1.text_.text = var_375_46
				arg_372_1.typewritter.percent = 0

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(false)
				arg_372_1:RecordContent(arg_372_1.text_.text)
			end

			local var_375_50 = var_375_41 + 0.3
			local var_375_51 = math.max(var_375_42, arg_372_1.talkMaxDuration)

			if var_375_50 <= arg_372_1.time_ and arg_372_1.time_ < var_375_50 + var_375_51 then
				arg_372_1.typewritter.percent = (arg_372_1.time_ - var_375_50) / var_375_51

				arg_372_1.typewritter:SetDirty()
			end

			if arg_372_1.time_ >= var_375_50 + var_375_51 and arg_372_1.time_ < var_375_50 + var_375_51 + arg_375_0 then
				arg_372_1.typewritter.percent = 1

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(true)
			end
		end

		arg_372_1.nodeConfigList_ = {}

		arg_372_1:InitPlayNodeList()
	end,
	Play324572090 = function(arg_378_0, arg_378_1)
		arg_378_1.time_ = 0
		arg_378_1.frameCnt_ = 0
		arg_378_1.state_ = "playing"
		arg_378_1.curTalkId_ = 324572090
		arg_378_1.duration_ = 5

		SetActive(arg_378_1.tipsGo_, false)

		function arg_378_1.onSingleLineFinish_()
			arg_378_1.onSingleLineUpdate_ = nil
			arg_378_1.onSingleLineFinish_ = nil
			arg_378_1.state_ = "waiting"
		end

		function arg_378_1.playNext_(arg_380_0)
			if arg_380_0 == 1 then
				arg_378_0:Play324572091(arg_378_1)
			end
		end

		function arg_378_1.onSingleLineUpdate_(arg_381_0)
			local var_381_0 = 0
			local var_381_1 = 0.575

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

				local var_381_2 = arg_378_1:GetWordFromCfg(324572090)
				local var_381_3 = arg_378_1:FormatText(var_381_2.content)

				arg_378_1.text_.text = var_381_3

				LuaForUtil.ClearLinePrefixSymbol(arg_378_1.text_)

				local var_381_4 = 23
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
	Play324572091 = function(arg_382_0, arg_382_1)
		arg_382_1.time_ = 0
		arg_382_1.frameCnt_ = 0
		arg_382_1.state_ = "playing"
		arg_382_1.curTalkId_ = 324572091
		arg_382_1.duration_ = 5

		SetActive(arg_382_1.tipsGo_, false)

		function arg_382_1.onSingleLineFinish_()
			arg_382_1.onSingleLineUpdate_ = nil
			arg_382_1.onSingleLineFinish_ = nil
			arg_382_1.state_ = "waiting"
		end

		function arg_382_1.playNext_(arg_384_0)
			if arg_384_0 == 1 then
				arg_382_0:Play324572092(arg_382_1)
			end
		end

		function arg_382_1.onSingleLineUpdate_(arg_385_0)
			local var_385_0 = 0
			local var_385_1 = 0.725

			if var_385_0 < arg_382_1.time_ and arg_382_1.time_ <= var_385_0 + arg_385_0 then
				arg_382_1.talkMaxDuration = 0
				arg_382_1.dialogCg_.alpha = 1

				arg_382_1.dialog_:SetActive(true)
				SetActive(arg_382_1.leftNameGo_, false)

				arg_382_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_382_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_382_1:RecordName(arg_382_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_382_1.iconTrs_.gameObject, false)
				arg_382_1.callingController_:SetSelectedState("normal")

				local var_385_2 = arg_382_1:GetWordFromCfg(324572091)
				local var_385_3 = arg_382_1:FormatText(var_385_2.content)

				arg_382_1.text_.text = var_385_3

				LuaForUtil.ClearLinePrefixSymbol(arg_382_1.text_)

				local var_385_4 = 29
				local var_385_5 = utf8.len(var_385_3)
				local var_385_6 = var_385_4 <= 0 and var_385_1 or var_385_1 * (var_385_5 / var_385_4)

				if var_385_6 > 0 and var_385_1 < var_385_6 then
					arg_382_1.talkMaxDuration = var_385_6

					if var_385_6 + var_385_0 > arg_382_1.duration_ then
						arg_382_1.duration_ = var_385_6 + var_385_0
					end
				end

				arg_382_1.text_.text = var_385_3
				arg_382_1.typewritter.percent = 0

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(false)
				arg_382_1:RecordContent(arg_382_1.text_.text)
			end

			local var_385_7 = math.max(var_385_1, arg_382_1.talkMaxDuration)

			if var_385_0 <= arg_382_1.time_ and arg_382_1.time_ < var_385_0 + var_385_7 then
				arg_382_1.typewritter.percent = (arg_382_1.time_ - var_385_0) / var_385_7

				arg_382_1.typewritter:SetDirty()
			end

			if arg_382_1.time_ >= var_385_0 + var_385_7 and arg_382_1.time_ < var_385_0 + var_385_7 + arg_385_0 then
				arg_382_1.typewritter.percent = 1

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(true)
			end
		end

		arg_382_1.nodeConfigList_ = {}

		arg_382_1:InitPlayNodeList()
	end,
	Play324572092 = function(arg_386_0, arg_386_1)
		arg_386_1.time_ = 0
		arg_386_1.frameCnt_ = 0
		arg_386_1.state_ = "playing"
		arg_386_1.curTalkId_ = 324572092
		arg_386_1.duration_ = 5

		SetActive(arg_386_1.tipsGo_, false)

		function arg_386_1.onSingleLineFinish_()
			arg_386_1.onSingleLineUpdate_ = nil
			arg_386_1.onSingleLineFinish_ = nil
			arg_386_1.state_ = "waiting"
		end

		function arg_386_1.playNext_(arg_388_0)
			if arg_388_0 == 1 then
				arg_386_0:Play324572093(arg_386_1)
			end
		end

		function arg_386_1.onSingleLineUpdate_(arg_389_0)
			local var_389_0 = 0
			local var_389_1 = 0.45

			if var_389_0 < arg_386_1.time_ and arg_386_1.time_ <= var_389_0 + arg_389_0 then
				arg_386_1.talkMaxDuration = 0
				arg_386_1.dialogCg_.alpha = 1

				arg_386_1.dialog_:SetActive(true)
				SetActive(arg_386_1.leftNameGo_, false)

				arg_386_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_386_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_386_1:RecordName(arg_386_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_386_1.iconTrs_.gameObject, false)
				arg_386_1.callingController_:SetSelectedState("normal")

				local var_389_2 = arg_386_1:GetWordFromCfg(324572092)
				local var_389_3 = arg_386_1:FormatText(var_389_2.content)

				arg_386_1.text_.text = var_389_3

				LuaForUtil.ClearLinePrefixSymbol(arg_386_1.text_)

				local var_389_4 = 18
				local var_389_5 = utf8.len(var_389_3)
				local var_389_6 = var_389_4 <= 0 and var_389_1 or var_389_1 * (var_389_5 / var_389_4)

				if var_389_6 > 0 and var_389_1 < var_389_6 then
					arg_386_1.talkMaxDuration = var_389_6

					if var_389_6 + var_389_0 > arg_386_1.duration_ then
						arg_386_1.duration_ = var_389_6 + var_389_0
					end
				end

				arg_386_1.text_.text = var_389_3
				arg_386_1.typewritter.percent = 0

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(false)
				arg_386_1:RecordContent(arg_386_1.text_.text)
			end

			local var_389_7 = math.max(var_389_1, arg_386_1.talkMaxDuration)

			if var_389_0 <= arg_386_1.time_ and arg_386_1.time_ < var_389_0 + var_389_7 then
				arg_386_1.typewritter.percent = (arg_386_1.time_ - var_389_0) / var_389_7

				arg_386_1.typewritter:SetDirty()
			end

			if arg_386_1.time_ >= var_389_0 + var_389_7 and arg_386_1.time_ < var_389_0 + var_389_7 + arg_389_0 then
				arg_386_1.typewritter.percent = 1

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(true)
			end
		end

		arg_386_1.nodeConfigList_ = {}

		arg_386_1:InitPlayNodeList()
	end,
	Play324572093 = function(arg_390_0, arg_390_1)
		arg_390_1.time_ = 0
		arg_390_1.frameCnt_ = 0
		arg_390_1.state_ = "playing"
		arg_390_1.curTalkId_ = 324572093
		arg_390_1.duration_ = 2

		SetActive(arg_390_1.tipsGo_, false)

		function arg_390_1.onSingleLineFinish_()
			arg_390_1.onSingleLineUpdate_ = nil
			arg_390_1.onSingleLineFinish_ = nil
			arg_390_1.state_ = "waiting"
		end

		function arg_390_1.playNext_(arg_392_0)
			if arg_392_0 == 1 then
				arg_390_0:Play324572094(arg_390_1)
			end
		end

		function arg_390_1.onSingleLineUpdate_(arg_393_0)
			local var_393_0 = arg_390_1.actors_["10170ui_story"].transform
			local var_393_1 = 0

			if var_393_1 < arg_390_1.time_ and arg_390_1.time_ <= var_393_1 + arg_393_0 then
				arg_390_1.var_.moveOldPos10170ui_story = var_393_0.localPosition

				local var_393_2 = GameObjectTools.GetOrAddComponent(var_393_0.gameObject, typeof(DynamicBoneHelper))

				if var_393_2 then
					var_393_2:EnableDynamicBone(false)
				end
			end

			local var_393_3 = 0.001

			if var_393_1 <= arg_390_1.time_ and arg_390_1.time_ < var_393_1 + var_393_3 then
				local var_393_4 = (arg_390_1.time_ - var_393_1) / var_393_3
				local var_393_5 = Vector3.New(0, -1.03, -6.05)

				var_393_0.localPosition = Vector3.Lerp(arg_390_1.var_.moveOldPos10170ui_story, var_393_5, var_393_4)

				local var_393_6 = manager.ui.mainCamera.transform.position - var_393_0.position

				var_393_0.forward = Vector3.New(var_393_6.x, var_393_6.y, var_393_6.z)

				local var_393_7 = var_393_0.localEulerAngles

				var_393_7.z = 0
				var_393_7.x = 0
				var_393_0.localEulerAngles = var_393_7
			end

			if arg_390_1.time_ >= var_393_1 + var_393_3 and arg_390_1.time_ < var_393_1 + var_393_3 + arg_393_0 then
				var_393_0.localPosition = Vector3.New(0, -1.03, -6.05)

				local var_393_8 = manager.ui.mainCamera.transform.position - var_393_0.position

				var_393_0.forward = Vector3.New(var_393_8.x, var_393_8.y, var_393_8.z)

				local var_393_9 = var_393_0.localEulerAngles

				var_393_9.z = 0
				var_393_9.x = 0
				var_393_0.localEulerAngles = var_393_9

				local var_393_10 = GameObjectTools.GetOrAddComponent(var_393_0.gameObject, typeof(DynamicBoneHelper))

				if var_393_10 then
					var_393_10:EnableDynamicBone(true)
				end
			end

			local var_393_11 = arg_390_1.actors_["10170ui_story"]
			local var_393_12 = 0

			if var_393_12 < arg_390_1.time_ and arg_390_1.time_ <= var_393_12 + arg_393_0 and not isNil(var_393_11) and arg_390_1.var_.characterEffect10170ui_story == nil then
				arg_390_1.var_.characterEffect10170ui_story = var_393_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_393_13 = 0.200000002980232

			if var_393_12 <= arg_390_1.time_ and arg_390_1.time_ < var_393_12 + var_393_13 and not isNil(var_393_11) then
				local var_393_14 = (arg_390_1.time_ - var_393_12) / var_393_13

				if arg_390_1.var_.characterEffect10170ui_story and not isNil(var_393_11) then
					arg_390_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_390_1.time_ >= var_393_12 + var_393_13 and arg_390_1.time_ < var_393_12 + var_393_13 + arg_393_0 and not isNil(var_393_11) and arg_390_1.var_.characterEffect10170ui_story then
				arg_390_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			local var_393_15 = 0

			if var_393_15 < arg_390_1.time_ and arg_390_1.time_ <= var_393_15 + arg_393_0 then
				arg_390_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/story10170/story10170action/10170action1_1")
			end

			local var_393_16 = 0

			if var_393_16 < arg_390_1.time_ and arg_390_1.time_ <= var_393_16 + arg_393_0 then
				arg_390_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_393_17 = 0
			local var_393_18 = 0.1

			if var_393_17 < arg_390_1.time_ and arg_390_1.time_ <= var_393_17 + arg_393_0 then
				arg_390_1.talkMaxDuration = 0
				arg_390_1.dialogCg_.alpha = 1

				arg_390_1.dialog_:SetActive(true)
				SetActive(arg_390_1.leftNameGo_, true)

				local var_393_19 = arg_390_1:FormatText(StoryNameCfg[1450].name)

				arg_390_1.leftNameTxt_.text = var_393_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_390_1.leftNameTxt_.transform)

				arg_390_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_390_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_390_1:RecordName(arg_390_1.leftNameTxt_.text)
				SetActive(arg_390_1.iconTrs_.gameObject, false)
				arg_390_1.callingController_:SetSelectedState("normal")

				local var_393_20 = arg_390_1:GetWordFromCfg(324572093)
				local var_393_21 = arg_390_1:FormatText(var_393_20.content)

				arg_390_1.text_.text = var_393_21

				LuaForUtil.ClearLinePrefixSymbol(arg_390_1.text_)

				local var_393_22 = 4
				local var_393_23 = utf8.len(var_393_21)
				local var_393_24 = var_393_22 <= 0 and var_393_18 or var_393_18 * (var_393_23 / var_393_22)

				if var_393_24 > 0 and var_393_18 < var_393_24 then
					arg_390_1.talkMaxDuration = var_393_24

					if var_393_24 + var_393_17 > arg_390_1.duration_ then
						arg_390_1.duration_ = var_393_24 + var_393_17
					end
				end

				arg_390_1.text_.text = var_393_21
				arg_390_1.typewritter.percent = 0

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324572", "324572093", "story_v_out_324572.awb") ~= 0 then
					local var_393_25 = manager.audio:GetVoiceLength("story_v_out_324572", "324572093", "story_v_out_324572.awb") / 1000

					if var_393_25 + var_393_17 > arg_390_1.duration_ then
						arg_390_1.duration_ = var_393_25 + var_393_17
					end

					if var_393_20.prefab_name ~= "" and arg_390_1.actors_[var_393_20.prefab_name] ~= nil then
						local var_393_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_390_1.actors_[var_393_20.prefab_name].transform, "story_v_out_324572", "324572093", "story_v_out_324572.awb")

						arg_390_1:RecordAudio("324572093", var_393_26)
						arg_390_1:RecordAudio("324572093", var_393_26)
					else
						arg_390_1:AudioAction("play", "voice", "story_v_out_324572", "324572093", "story_v_out_324572.awb")
					end

					arg_390_1:RecordHistoryTalkVoice("story_v_out_324572", "324572093", "story_v_out_324572.awb")
				end

				arg_390_1:RecordContent(arg_390_1.text_.text)
			end

			local var_393_27 = math.max(var_393_18, arg_390_1.talkMaxDuration)

			if var_393_17 <= arg_390_1.time_ and arg_390_1.time_ < var_393_17 + var_393_27 then
				arg_390_1.typewritter.percent = (arg_390_1.time_ - var_393_17) / var_393_27

				arg_390_1.typewritter:SetDirty()
			end

			if arg_390_1.time_ >= var_393_17 + var_393_27 and arg_390_1.time_ < var_393_17 + var_393_27 + arg_393_0 then
				arg_390_1.typewritter.percent = 1

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(true)
			end
		end

		arg_390_1.nodeConfigList_ = {
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

		arg_390_1:InitPlayNodeList()
	end,
	Play324572094 = function(arg_394_0, arg_394_1)
		arg_394_1.time_ = 0
		arg_394_1.frameCnt_ = 0
		arg_394_1.state_ = "playing"
		arg_394_1.curTalkId_ = 324572094
		arg_394_1.duration_ = 5

		SetActive(arg_394_1.tipsGo_, false)

		function arg_394_1.onSingleLineFinish_()
			arg_394_1.onSingleLineUpdate_ = nil
			arg_394_1.onSingleLineFinish_ = nil
			arg_394_1.state_ = "waiting"
		end

		function arg_394_1.playNext_(arg_396_0)
			if arg_396_0 == 1 then
				arg_394_0:Play324572095(arg_394_1)
			end
		end

		function arg_394_1.onSingleLineUpdate_(arg_397_0)
			local var_397_0 = arg_394_1.actors_["10170ui_story"]
			local var_397_1 = 0

			if var_397_1 < arg_394_1.time_ and arg_394_1.time_ <= var_397_1 + arg_397_0 and not isNil(var_397_0) and arg_394_1.var_.characterEffect10170ui_story == nil then
				arg_394_1.var_.characterEffect10170ui_story = var_397_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_397_2 = 0.200000002980232

			if var_397_1 <= arg_394_1.time_ and arg_394_1.time_ < var_397_1 + var_397_2 and not isNil(var_397_0) then
				local var_397_3 = (arg_394_1.time_ - var_397_1) / var_397_2

				if arg_394_1.var_.characterEffect10170ui_story and not isNil(var_397_0) then
					local var_397_4 = Mathf.Lerp(0, 0.5, var_397_3)

					arg_394_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_394_1.var_.characterEffect10170ui_story.fillRatio = var_397_4
				end
			end

			if arg_394_1.time_ >= var_397_1 + var_397_2 and arg_394_1.time_ < var_397_1 + var_397_2 + arg_397_0 and not isNil(var_397_0) and arg_394_1.var_.characterEffect10170ui_story then
				local var_397_5 = 0.5

				arg_394_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_394_1.var_.characterEffect10170ui_story.fillRatio = var_397_5
			end

			local var_397_6 = 0
			local var_397_7 = 0.075

			if var_397_6 < arg_394_1.time_ and arg_394_1.time_ <= var_397_6 + arg_397_0 then
				arg_394_1.talkMaxDuration = 0
				arg_394_1.dialogCg_.alpha = 1

				arg_394_1.dialog_:SetActive(true)
				SetActive(arg_394_1.leftNameGo_, true)

				local var_397_8 = arg_394_1:FormatText(StoryNameCfg[7].name)

				arg_394_1.leftNameTxt_.text = var_397_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_394_1.leftNameTxt_.transform)

				arg_394_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_394_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_394_1:RecordName(arg_394_1.leftNameTxt_.text)
				SetActive(arg_394_1.iconTrs_.gameObject, true)
				arg_394_1.iconController_:SetSelectedState("hero")

				arg_394_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_394_1.callingController_:SetSelectedState("normal")

				arg_394_1.keyicon_.color = Color.New(1, 1, 1)
				arg_394_1.icon_.color = Color.New(1, 1, 1)

				local var_397_9 = arg_394_1:GetWordFromCfg(324572094)
				local var_397_10 = arg_394_1:FormatText(var_397_9.content)

				arg_394_1.text_.text = var_397_10

				LuaForUtil.ClearLinePrefixSymbol(arg_394_1.text_)

				local var_397_11 = 3
				local var_397_12 = utf8.len(var_397_10)
				local var_397_13 = var_397_11 <= 0 and var_397_7 or var_397_7 * (var_397_12 / var_397_11)

				if var_397_13 > 0 and var_397_7 < var_397_13 then
					arg_394_1.talkMaxDuration = var_397_13

					if var_397_13 + var_397_6 > arg_394_1.duration_ then
						arg_394_1.duration_ = var_397_13 + var_397_6
					end
				end

				arg_394_1.text_.text = var_397_10
				arg_394_1.typewritter.percent = 0

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(false)
				arg_394_1:RecordContent(arg_394_1.text_.text)
			end

			local var_397_14 = math.max(var_397_7, arg_394_1.talkMaxDuration)

			if var_397_6 <= arg_394_1.time_ and arg_394_1.time_ < var_397_6 + var_397_14 then
				arg_394_1.typewritter.percent = (arg_394_1.time_ - var_397_6) / var_397_14

				arg_394_1.typewritter:SetDirty()
			end

			if arg_394_1.time_ >= var_397_6 + var_397_14 and arg_394_1.time_ < var_397_6 + var_397_14 + arg_397_0 then
				arg_394_1.typewritter.percent = 1

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(true)
			end
		end

		arg_394_1.nodeConfigList_ = {}

		arg_394_1:InitPlayNodeList()
	end,
	Play324572095 = function(arg_398_0, arg_398_1)
		arg_398_1.time_ = 0
		arg_398_1.frameCnt_ = 0
		arg_398_1.state_ = "playing"
		arg_398_1.curTalkId_ = 324572095
		arg_398_1.duration_ = 5

		SetActive(arg_398_1.tipsGo_, false)

		function arg_398_1.onSingleLineFinish_()
			arg_398_1.onSingleLineUpdate_ = nil
			arg_398_1.onSingleLineFinish_ = nil
			arg_398_1.state_ = "waiting"
			arg_398_1.auto_ = false
		end

		function arg_398_1.playNext_(arg_400_0)
			arg_398_1.onStoryFinished_()
		end

		function arg_398_1.onSingleLineUpdate_(arg_401_0)
			local var_401_0 = 0

			if var_401_0 < arg_398_1.time_ and arg_398_1.time_ <= var_401_0 + arg_401_0 then
				arg_398_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/story10170/story10170action/10170action29_1")
			end

			local var_401_1 = 0

			if var_401_1 < arg_398_1.time_ and arg_398_1.time_ <= var_401_1 + arg_401_0 then
				arg_398_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_401_2 = 0
			local var_401_3 = 0.8

			if var_401_2 < arg_398_1.time_ and arg_398_1.time_ <= var_401_2 + arg_401_0 then
				arg_398_1.talkMaxDuration = 0
				arg_398_1.dialogCg_.alpha = 1

				arg_398_1.dialog_:SetActive(true)
				SetActive(arg_398_1.leftNameGo_, false)

				arg_398_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_398_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_398_1:RecordName(arg_398_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_398_1.iconTrs_.gameObject, false)
				arg_398_1.callingController_:SetSelectedState("normal")

				local var_401_4 = arg_398_1:GetWordFromCfg(324572095)
				local var_401_5 = arg_398_1:FormatText(var_401_4.content)

				arg_398_1.text_.text = var_401_5

				LuaForUtil.ClearLinePrefixSymbol(arg_398_1.text_)

				local var_401_6 = 32
				local var_401_7 = utf8.len(var_401_5)
				local var_401_8 = var_401_6 <= 0 and var_401_3 or var_401_3 * (var_401_7 / var_401_6)

				if var_401_8 > 0 and var_401_3 < var_401_8 then
					arg_398_1.talkMaxDuration = var_401_8

					if var_401_8 + var_401_2 > arg_398_1.duration_ then
						arg_398_1.duration_ = var_401_8 + var_401_2
					end
				end

				arg_398_1.text_.text = var_401_5
				arg_398_1.typewritter.percent = 0

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(false)
				arg_398_1:RecordContent(arg_398_1.text_.text)
			end

			local var_401_9 = math.max(var_401_3, arg_398_1.talkMaxDuration)

			if var_401_2 <= arg_398_1.time_ and arg_398_1.time_ < var_401_2 + var_401_9 then
				arg_398_1.typewritter.percent = (arg_398_1.time_ - var_401_2) / var_401_9

				arg_398_1.typewritter:SetDirty()
			end

			if arg_398_1.time_ >= var_401_2 + var_401_9 and arg_398_1.time_ < var_401_2 + var_401_9 + arg_401_0 then
				arg_398_1.typewritter.percent = 1

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(true)
			end
		end

		arg_398_1.nodeConfigList_ = {}

		arg_398_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/H02a",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/MS2305",
		"TextureConfig/Background/MS2407",
		"TextureConfig/Background/ST2004"
	},
	voices = {
		"story_v_out_324572.awb"
	}
}
