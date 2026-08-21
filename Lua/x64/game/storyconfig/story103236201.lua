return {
	Play323621001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 323621001
		arg_1_1.duration_ = 6.63

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play323621002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "ST37"

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
				local var_4_5 = arg_1_1.bgs_.ST37

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
					if iter_4_0 ~= "ST37" then
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

			local var_4_24 = 0
			local var_4_25 = 0.3

			if var_4_24 < arg_1_1.time_ and arg_1_1.time_ <= var_4_24 + arg_4_0 then
				local var_4_26 = "play"
				local var_4_27 = "music"

				arg_1_1:AudioAction(var_4_26, var_4_27, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_28 = ""
				local var_4_29 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_4_29 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_29 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_29

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_29
						arg_1_1.bgmTxt2_.text = var_4_29
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

			local var_4_30 = 0.433333333333333
			local var_4_31 = 1

			if var_4_30 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 then
				local var_4_32 = "play"
				local var_4_33 = "music"

				arg_1_1:AudioAction(var_4_32, var_4_33, "bgm_activity_4_8_story_wangshu", "bgm_activity_4_8_story_wangshu", "bgm_activity_4_8_story_wangshu.awb")

				local var_4_34 = ""
				local var_4_35 = manager.audio:GetAudioName("bgm_activity_4_8_story_wangshu", "bgm_activity_4_8_story_wangshu")

				if var_4_35 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_35 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_35

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_35
						arg_1_1.bgmTxt2_.text = var_4_35
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

			local var_4_36 = 0.1
			local var_4_37 = 1

			if var_4_36 < arg_1_1.time_ and arg_1_1.time_ <= var_4_36 + arg_4_0 then
				local var_4_38 = "play"
				local var_4_39 = "effect"

				arg_1_1:AudioAction(var_4_38, var_4_39, "se_story_148", "se_story_148_amb_night_room", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_40 = 1.63333333333333
			local var_4_41 = 0.15

			if var_4_40 < arg_1_1.time_ and arg_1_1.time_ <= var_4_40 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_42 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_42:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_42:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_42:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_43 = arg_1_1:FormatText(StoryNameCfg[7].name)

				arg_1_1.leftNameTxt_.text = var_4_43

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

				local var_4_44 = arg_1_1:GetWordFromCfg(323621001)
				local var_4_45 = arg_1_1:FormatText(var_4_44.content)

				arg_1_1.text_.text = var_4_45

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_46 = 6
				local var_4_47 = utf8.len(var_4_45)
				local var_4_48 = var_4_46 <= 0 and var_4_41 or var_4_41 * (var_4_47 / var_4_46)

				if var_4_48 > 0 and var_4_41 < var_4_48 then
					arg_1_1.talkMaxDuration = var_4_48
					var_4_40 = var_4_40 + 0.3

					if var_4_48 + var_4_40 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_48 + var_4_40
					end
				end

				arg_1_1.text_.text = var_4_45
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_49 = var_4_40 + 0.3
			local var_4_50 = math.max(var_4_41, arg_1_1.talkMaxDuration)

			if var_4_49 <= arg_1_1.time_ and arg_1_1.time_ < var_4_49 + var_4_50 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_49) / var_4_50

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_49 + var_4_50 and arg_1_1.time_ < var_4_49 + var_4_50 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play323621002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 323621002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play323621003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0
			local var_12_1 = 1.325

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

				local var_12_2 = arg_9_1:GetWordFromCfg(323621002)
				local var_12_3 = arg_9_1:FormatText(var_12_2.content)

				arg_9_1.text_.text = var_12_3

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_4 = 53
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
	Play323621003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 323621003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play323621004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0
			local var_16_1 = 1.275

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

				local var_16_2 = arg_13_1:GetWordFromCfg(323621003)
				local var_16_3 = arg_13_1:FormatText(var_16_2.content)

				arg_13_1.text_.text = var_16_3

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_4 = 51
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
	Play323621004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 323621004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play323621005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0
			local var_20_1 = 1.325

			if var_20_0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_0 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_2 = arg_17_1:FormatText(StoryNameCfg[7].name)

				arg_17_1.leftNameTxt_.text = var_20_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, true)
				arg_17_1.iconController_:SetSelectedState("hero")

				arg_17_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_17_1.callingController_:SetSelectedState("normal")

				arg_17_1.keyicon_.color = Color.New(1, 1, 1)
				arg_17_1.icon_.color = Color.New(1, 1, 1)

				local var_20_3 = arg_17_1:GetWordFromCfg(323621004)
				local var_20_4 = arg_17_1:FormatText(var_20_3.content)

				arg_17_1.text_.text = var_20_4

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_5 = 53
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
				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_8 = math.max(var_20_1, arg_17_1.talkMaxDuration)

			if var_20_0 <= arg_17_1.time_ and arg_17_1.time_ < var_20_0 + var_20_8 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_0) / var_20_8

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_0 + var_20_8 and arg_17_1.time_ < var_20_0 + var_20_8 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play323621005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 323621005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play323621006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 0
			local var_24_1 = 1.125

			if var_24_0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_0 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_2 = arg_21_1:FormatText(StoryNameCfg[7].name)

				arg_21_1.leftNameTxt_.text = var_24_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, true)
				arg_21_1.iconController_:SetSelectedState("hero")

				arg_21_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_21_1.callingController_:SetSelectedState("normal")

				arg_21_1.keyicon_.color = Color.New(1, 1, 1)
				arg_21_1.icon_.color = Color.New(1, 1, 1)

				local var_24_3 = arg_21_1:GetWordFromCfg(323621005)
				local var_24_4 = arg_21_1:FormatText(var_24_3.content)

				arg_21_1.text_.text = var_24_4

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_5 = 45
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
				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_8 = math.max(var_24_1, arg_21_1.talkMaxDuration)

			if var_24_0 <= arg_21_1.time_ and arg_21_1.time_ < var_24_0 + var_24_8 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_0) / var_24_8

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_0 + var_24_8 and arg_21_1.time_ < var_24_0 + var_24_8 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play323621006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 323621006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play323621007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 0
			local var_28_1 = 0.975

			if var_28_0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_0 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_2 = arg_25_1:FormatText(StoryNameCfg[7].name)

				arg_25_1.leftNameTxt_.text = var_28_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, true)
				arg_25_1.iconController_:SetSelectedState("hero")

				arg_25_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_25_1.callingController_:SetSelectedState("normal")

				arg_25_1.keyicon_.color = Color.New(1, 1, 1)
				arg_25_1.icon_.color = Color.New(1, 1, 1)

				local var_28_3 = arg_25_1:GetWordFromCfg(323621006)
				local var_28_4 = arg_25_1:FormatText(var_28_3.content)

				arg_25_1.text_.text = var_28_4

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_5 = 39
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
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_8 = math.max(var_28_1, arg_25_1.talkMaxDuration)

			if var_28_0 <= arg_25_1.time_ and arg_25_1.time_ < var_28_0 + var_28_8 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_0) / var_28_8

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_0 + var_28_8 and arg_25_1.time_ < var_28_0 + var_28_8 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play323621007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 323621007
		arg_29_1.duration_ = 5.47

		local var_29_0 = {
			zh = 3.3,
			ja = 5.466
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
				arg_29_0:Play323621008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = "10170ui_story"

			if arg_29_1.actors_[var_32_0] == nil then
				local var_32_1 = Asset.Load("Char/" .. "10170ui_story")

				if not isNil(var_32_1) then
					local var_32_2 = Object.Instantiate(Asset.Load("Char/" .. "10170ui_story"), arg_29_1.stage_.transform)

					var_32_2.name = var_32_0
					var_32_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_29_1.actors_[var_32_0] = var_32_2

					local var_32_3 = var_32_2:GetComponentInChildren(typeof(CharacterEffect))

					var_32_3.enabled = true

					local var_32_4 = GameObjectTools.GetOrAddComponent(var_32_2, typeof(DynamicBoneHelper))

					if var_32_4 then
						var_32_4:EnableDynamicBone(false)
					end

					arg_29_1:ShowWeapon(var_32_3.transform, false)

					arg_29_1.var_[var_32_0 .. "Animator"] = var_32_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_29_1.var_[var_32_0 .. "Animator"].applyRootMotion = true
					arg_29_1.var_[var_32_0 .. "LipSync"] = var_32_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_32_5 = arg_29_1.actors_["10170ui_story"].transform
			local var_32_6 = 0

			if var_32_6 < arg_29_1.time_ and arg_29_1.time_ <= var_32_6 + arg_32_0 then
				arg_29_1.var_.moveOldPos10170ui_story = var_32_5.localPosition

				local var_32_7 = GameObjectTools.GetOrAddComponent(var_32_5.gameObject, typeof(DynamicBoneHelper))

				if var_32_7 then
					var_32_7:EnableDynamicBone(false)
				end
			end

			local var_32_8 = 0.001

			if var_32_6 <= arg_29_1.time_ and arg_29_1.time_ < var_32_6 + var_32_8 then
				local var_32_9 = (arg_29_1.time_ - var_32_6) / var_32_8
				local var_32_10 = Vector3.New(0, -1.03, -6.05)

				var_32_5.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos10170ui_story, var_32_10, var_32_9)

				local var_32_11 = manager.ui.mainCamera.transform.position - var_32_5.position

				var_32_5.forward = Vector3.New(var_32_11.x, var_32_11.y, var_32_11.z)

				local var_32_12 = var_32_5.localEulerAngles

				var_32_12.z = 0
				var_32_12.x = 0
				var_32_5.localEulerAngles = var_32_12
			end

			if arg_29_1.time_ >= var_32_6 + var_32_8 and arg_29_1.time_ < var_32_6 + var_32_8 + arg_32_0 then
				var_32_5.localPosition = Vector3.New(0, -1.03, -6.05)

				local var_32_13 = manager.ui.mainCamera.transform.position - var_32_5.position

				var_32_5.forward = Vector3.New(var_32_13.x, var_32_13.y, var_32_13.z)

				local var_32_14 = var_32_5.localEulerAngles

				var_32_14.z = 0
				var_32_14.x = 0
				var_32_5.localEulerAngles = var_32_14

				local var_32_15 = GameObjectTools.GetOrAddComponent(var_32_5.gameObject, typeof(DynamicBoneHelper))

				if var_32_15 then
					var_32_15:EnableDynamicBone(true)
				end
			end

			local var_32_16 = arg_29_1.actors_["10170ui_story"]
			local var_32_17 = 0

			if var_32_17 < arg_29_1.time_ and arg_29_1.time_ <= var_32_17 + arg_32_0 and not isNil(var_32_16) and arg_29_1.var_.characterEffect10170ui_story == nil then
				arg_29_1.var_.characterEffect10170ui_story = var_32_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_18 = 0.200000002980232

			if var_32_17 <= arg_29_1.time_ and arg_29_1.time_ < var_32_17 + var_32_18 and not isNil(var_32_16) then
				local var_32_19 = (arg_29_1.time_ - var_32_17) / var_32_18

				if arg_29_1.var_.characterEffect10170ui_story and not isNil(var_32_16) then
					arg_29_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= var_32_17 + var_32_18 and arg_29_1.time_ < var_32_17 + var_32_18 + arg_32_0 and not isNil(var_32_16) and arg_29_1.var_.characterEffect10170ui_story then
				arg_29_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			local var_32_20 = 0

			if var_32_20 < arg_29_1.time_ and arg_29_1.time_ <= var_32_20 + arg_32_0 then
				arg_29_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_32_21 = 0

			if var_32_21 < arg_29_1.time_ and arg_29_1.time_ <= var_32_21 + arg_32_0 then
				arg_29_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/story10170/story10170action/10170action28_1")
			end

			local var_32_22 = 0
			local var_32_23 = 0.375

			if var_32_22 < arg_29_1.time_ and arg_29_1.time_ <= var_32_22 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_24 = arg_29_1:FormatText(StoryNameCfg[1450].name)

				arg_29_1.leftNameTxt_.text = var_32_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_25 = arg_29_1:GetWordFromCfg(323621007)
				local var_32_26 = arg_29_1:FormatText(var_32_25.content)

				arg_29_1.text_.text = var_32_26

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_27 = 15
				local var_32_28 = utf8.len(var_32_26)
				local var_32_29 = var_32_27 <= 0 and var_32_23 or var_32_23 * (var_32_28 / var_32_27)

				if var_32_29 > 0 and var_32_23 < var_32_29 then
					arg_29_1.talkMaxDuration = var_32_29

					if var_32_29 + var_32_22 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_29 + var_32_22
					end
				end

				arg_29_1.text_.text = var_32_26
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323621", "323621007", "story_v_out_323621.awb") ~= 0 then
					local var_32_30 = manager.audio:GetVoiceLength("story_v_out_323621", "323621007", "story_v_out_323621.awb") / 1000

					if var_32_30 + var_32_22 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_30 + var_32_22
					end

					if var_32_25.prefab_name ~= "" and arg_29_1.actors_[var_32_25.prefab_name] ~= nil then
						local var_32_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_25.prefab_name].transform, "story_v_out_323621", "323621007", "story_v_out_323621.awb")

						arg_29_1:RecordAudio("323621007", var_32_31)
						arg_29_1:RecordAudio("323621007", var_32_31)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_323621", "323621007", "story_v_out_323621.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_323621", "323621007", "story_v_out_323621.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_32 = math.max(var_32_23, arg_29_1.talkMaxDuration)

			if var_32_22 <= arg_29_1.time_ and arg_29_1.time_ < var_32_22 + var_32_32 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_22) / var_32_32

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_22 + var_32_32 and arg_29_1.time_ < var_32_22 + var_32_32 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {
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

		arg_29_1:InitPlayNodeList()
	end,
	Play323621008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 323621008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play323621009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = arg_33_1.actors_["10170ui_story"]
			local var_36_1 = 0

			if var_36_1 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.characterEffect10170ui_story == nil then
				arg_33_1.var_.characterEffect10170ui_story = var_36_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_2 = 0.200000002980232

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_2 and not isNil(var_36_0) then
				local var_36_3 = (arg_33_1.time_ - var_36_1) / var_36_2

				if arg_33_1.var_.characterEffect10170ui_story and not isNil(var_36_0) then
					local var_36_4 = Mathf.Lerp(0, 0.5, var_36_3)

					arg_33_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_33_1.var_.characterEffect10170ui_story.fillRatio = var_36_4
				end
			end

			if arg_33_1.time_ >= var_36_1 + var_36_2 and arg_33_1.time_ < var_36_1 + var_36_2 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.characterEffect10170ui_story then
				local var_36_5 = 0.5

				arg_33_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_33_1.var_.characterEffect10170ui_story.fillRatio = var_36_5
			end

			local var_36_6 = 0
			local var_36_7 = 0.475

			if var_36_6 < arg_33_1.time_ and arg_33_1.time_ <= var_36_6 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_8 = arg_33_1:FormatText(StoryNameCfg[7].name)

				arg_33_1.leftNameTxt_.text = var_36_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, true)
				arg_33_1.iconController_:SetSelectedState("hero")

				arg_33_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_33_1.callingController_:SetSelectedState("normal")

				arg_33_1.keyicon_.color = Color.New(1, 1, 1)
				arg_33_1.icon_.color = Color.New(1, 1, 1)

				local var_36_9 = arg_33_1:GetWordFromCfg(323621008)
				local var_36_10 = arg_33_1:FormatText(var_36_9.content)

				arg_33_1.text_.text = var_36_10

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_11 = 19
				local var_36_12 = utf8.len(var_36_10)
				local var_36_13 = var_36_11 <= 0 and var_36_7 or var_36_7 * (var_36_12 / var_36_11)

				if var_36_13 > 0 and var_36_7 < var_36_13 then
					arg_33_1.talkMaxDuration = var_36_13

					if var_36_13 + var_36_6 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_13 + var_36_6
					end
				end

				arg_33_1.text_.text = var_36_10
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_14 = math.max(var_36_7, arg_33_1.talkMaxDuration)

			if var_36_6 <= arg_33_1.time_ and arg_33_1.time_ < var_36_6 + var_36_14 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_6) / var_36_14

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_6 + var_36_14 and arg_33_1.time_ < var_36_6 + var_36_14 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play323621009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 323621009
		arg_37_1.duration_ = 3.57

		local var_37_0 = {
			zh = 3.033,
			ja = 3.566
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
				arg_37_0:Play323621010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = arg_37_1.actors_["10170ui_story"]
			local var_40_1 = 0

			if var_40_1 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.characterEffect10170ui_story == nil then
				arg_37_1.var_.characterEffect10170ui_story = var_40_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_2 = 0.200000002980232

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_2 and not isNil(var_40_0) then
				local var_40_3 = (arg_37_1.time_ - var_40_1) / var_40_2

				if arg_37_1.var_.characterEffect10170ui_story and not isNil(var_40_0) then
					arg_37_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_37_1.time_ >= var_40_1 + var_40_2 and arg_37_1.time_ < var_40_1 + var_40_2 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.characterEffect10170ui_story then
				arg_37_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			local var_40_4 = 0
			local var_40_5 = 0.325

			if var_40_4 < arg_37_1.time_ and arg_37_1.time_ <= var_40_4 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_6 = arg_37_1:FormatText(StoryNameCfg[1450].name)

				arg_37_1.leftNameTxt_.text = var_40_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_7 = arg_37_1:GetWordFromCfg(323621009)
				local var_40_8 = arg_37_1:FormatText(var_40_7.content)

				arg_37_1.text_.text = var_40_8

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_9 = 13
				local var_40_10 = utf8.len(var_40_8)
				local var_40_11 = var_40_9 <= 0 and var_40_5 or var_40_5 * (var_40_10 / var_40_9)

				if var_40_11 > 0 and var_40_5 < var_40_11 then
					arg_37_1.talkMaxDuration = var_40_11

					if var_40_11 + var_40_4 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_11 + var_40_4
					end
				end

				arg_37_1.text_.text = var_40_8
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323621", "323621009", "story_v_out_323621.awb") ~= 0 then
					local var_40_12 = manager.audio:GetVoiceLength("story_v_out_323621", "323621009", "story_v_out_323621.awb") / 1000

					if var_40_12 + var_40_4 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_12 + var_40_4
					end

					if var_40_7.prefab_name ~= "" and arg_37_1.actors_[var_40_7.prefab_name] ~= nil then
						local var_40_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_7.prefab_name].transform, "story_v_out_323621", "323621009", "story_v_out_323621.awb")

						arg_37_1:RecordAudio("323621009", var_40_13)
						arg_37_1:RecordAudio("323621009", var_40_13)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_323621", "323621009", "story_v_out_323621.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_323621", "323621009", "story_v_out_323621.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_14 = math.max(var_40_5, arg_37_1.talkMaxDuration)

			if var_40_4 <= arg_37_1.time_ and arg_37_1.time_ < var_40_4 + var_40_14 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_4) / var_40_14

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_4 + var_40_14 and arg_37_1.time_ < var_40_4 + var_40_14 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play323621010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 323621010
		arg_41_1.duration_ = 5

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play323621011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = arg_41_1.actors_["10170ui_story"]
			local var_44_1 = 0

			if var_44_1 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.characterEffect10170ui_story == nil then
				arg_41_1.var_.characterEffect10170ui_story = var_44_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_2 = 0.200000002980232

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_2 and not isNil(var_44_0) then
				local var_44_3 = (arg_41_1.time_ - var_44_1) / var_44_2

				if arg_41_1.var_.characterEffect10170ui_story and not isNil(var_44_0) then
					local var_44_4 = Mathf.Lerp(0, 0.5, var_44_3)

					arg_41_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_41_1.var_.characterEffect10170ui_story.fillRatio = var_44_4
				end
			end

			if arg_41_1.time_ >= var_44_1 + var_44_2 and arg_41_1.time_ < var_44_1 + var_44_2 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.characterEffect10170ui_story then
				local var_44_5 = 0.5

				arg_41_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_41_1.var_.characterEffect10170ui_story.fillRatio = var_44_5
			end

			local var_44_6 = 0
			local var_44_7 = 0.55

			if var_44_6 < arg_41_1.time_ and arg_41_1.time_ <= var_44_6 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_8 = arg_41_1:FormatText(StoryNameCfg[7].name)

				arg_41_1.leftNameTxt_.text = var_44_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, true)
				arg_41_1.iconController_:SetSelectedState("hero")

				arg_41_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_41_1.callingController_:SetSelectedState("normal")

				arg_41_1.keyicon_.color = Color.New(1, 1, 1)
				arg_41_1.icon_.color = Color.New(1, 1, 1)

				local var_44_9 = arg_41_1:GetWordFromCfg(323621010)
				local var_44_10 = arg_41_1:FormatText(var_44_9.content)

				arg_41_1.text_.text = var_44_10

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_11 = 22
				local var_44_12 = utf8.len(var_44_10)
				local var_44_13 = var_44_11 <= 0 and var_44_7 or var_44_7 * (var_44_12 / var_44_11)

				if var_44_13 > 0 and var_44_7 < var_44_13 then
					arg_41_1.talkMaxDuration = var_44_13

					if var_44_13 + var_44_6 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_13 + var_44_6
					end
				end

				arg_41_1.text_.text = var_44_10
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)
				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_14 = math.max(var_44_7, arg_41_1.talkMaxDuration)

			if var_44_6 <= arg_41_1.time_ and arg_41_1.time_ < var_44_6 + var_44_14 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_6) / var_44_14

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_6 + var_44_14 and arg_41_1.time_ < var_44_6 + var_44_14 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play323621011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 323621011
		arg_45_1.duration_ = 3.43

		local var_45_0 = {
			zh = 2.266,
			ja = 3.433
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
				arg_45_0:Play323621012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = arg_45_1.actors_["10170ui_story"]
			local var_48_1 = 0

			if var_48_1 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 and not isNil(var_48_0) and arg_45_1.var_.characterEffect10170ui_story == nil then
				arg_45_1.var_.characterEffect10170ui_story = var_48_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_2 = 0.200000002980232

			if var_48_1 <= arg_45_1.time_ and arg_45_1.time_ < var_48_1 + var_48_2 and not isNil(var_48_0) then
				local var_48_3 = (arg_45_1.time_ - var_48_1) / var_48_2

				if arg_45_1.var_.characterEffect10170ui_story and not isNil(var_48_0) then
					arg_45_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_45_1.time_ >= var_48_1 + var_48_2 and arg_45_1.time_ < var_48_1 + var_48_2 + arg_48_0 and not isNil(var_48_0) and arg_45_1.var_.characterEffect10170ui_story then
				arg_45_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			local var_48_4 = 0

			if var_48_4 < arg_45_1.time_ and arg_45_1.time_ <= var_48_4 + arg_48_0 then
				arg_45_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_48_5 = 0

			if var_48_5 < arg_45_1.time_ and arg_45_1.time_ <= var_48_5 + arg_48_0 then
				arg_45_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/story10170/story10170action/10170action28_2")
			end

			local var_48_6 = 0
			local var_48_7 = 0.2

			if var_48_6 < arg_45_1.time_ and arg_45_1.time_ <= var_48_6 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_8 = arg_45_1:FormatText(StoryNameCfg[1450].name)

				arg_45_1.leftNameTxt_.text = var_48_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_9 = arg_45_1:GetWordFromCfg(323621011)
				local var_48_10 = arg_45_1:FormatText(var_48_9.content)

				arg_45_1.text_.text = var_48_10

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_11 = 8
				local var_48_12 = utf8.len(var_48_10)
				local var_48_13 = var_48_11 <= 0 and var_48_7 or var_48_7 * (var_48_12 / var_48_11)

				if var_48_13 > 0 and var_48_7 < var_48_13 then
					arg_45_1.talkMaxDuration = var_48_13

					if var_48_13 + var_48_6 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_13 + var_48_6
					end
				end

				arg_45_1.text_.text = var_48_10
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323621", "323621011", "story_v_out_323621.awb") ~= 0 then
					local var_48_14 = manager.audio:GetVoiceLength("story_v_out_323621", "323621011", "story_v_out_323621.awb") / 1000

					if var_48_14 + var_48_6 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_14 + var_48_6
					end

					if var_48_9.prefab_name ~= "" and arg_45_1.actors_[var_48_9.prefab_name] ~= nil then
						local var_48_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_9.prefab_name].transform, "story_v_out_323621", "323621011", "story_v_out_323621.awb")

						arg_45_1:RecordAudio("323621011", var_48_15)
						arg_45_1:RecordAudio("323621011", var_48_15)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_323621", "323621011", "story_v_out_323621.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_323621", "323621011", "story_v_out_323621.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_16 = math.max(var_48_7, arg_45_1.talkMaxDuration)

			if var_48_6 <= arg_45_1.time_ and arg_45_1.time_ < var_48_6 + var_48_16 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_6) / var_48_16

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_6 + var_48_16 and arg_45_1.time_ < var_48_6 + var_48_16 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play323621012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 323621012
		arg_49_1.duration_ = 5

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play323621013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = arg_49_1.actors_["10170ui_story"]
			local var_52_1 = 0

			if var_52_1 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.characterEffect10170ui_story == nil then
				arg_49_1.var_.characterEffect10170ui_story = var_52_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_2 = 0.200000002980232

			if var_52_1 <= arg_49_1.time_ and arg_49_1.time_ < var_52_1 + var_52_2 and not isNil(var_52_0) then
				local var_52_3 = (arg_49_1.time_ - var_52_1) / var_52_2

				if arg_49_1.var_.characterEffect10170ui_story and not isNil(var_52_0) then
					local var_52_4 = Mathf.Lerp(0, 0.5, var_52_3)

					arg_49_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_49_1.var_.characterEffect10170ui_story.fillRatio = var_52_4
				end
			end

			if arg_49_1.time_ >= var_52_1 + var_52_2 and arg_49_1.time_ < var_52_1 + var_52_2 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.characterEffect10170ui_story then
				local var_52_5 = 0.5

				arg_49_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_49_1.var_.characterEffect10170ui_story.fillRatio = var_52_5
			end

			local var_52_6 = 0
			local var_52_7 = 0.075

			if var_52_6 < arg_49_1.time_ and arg_49_1.time_ <= var_52_6 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_8 = arg_49_1:FormatText(StoryNameCfg[7].name)

				arg_49_1.leftNameTxt_.text = var_52_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, true)
				arg_49_1.iconController_:SetSelectedState("hero")

				arg_49_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_49_1.callingController_:SetSelectedState("normal")

				arg_49_1.keyicon_.color = Color.New(1, 1, 1)
				arg_49_1.icon_.color = Color.New(1, 1, 1)

				local var_52_9 = arg_49_1:GetWordFromCfg(323621012)
				local var_52_10 = arg_49_1:FormatText(var_52_9.content)

				arg_49_1.text_.text = var_52_10

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_11 = 3
				local var_52_12 = utf8.len(var_52_10)
				local var_52_13 = var_52_11 <= 0 and var_52_7 or var_52_7 * (var_52_12 / var_52_11)

				if var_52_13 > 0 and var_52_7 < var_52_13 then
					arg_49_1.talkMaxDuration = var_52_13

					if var_52_13 + var_52_6 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_13 + var_52_6
					end
				end

				arg_49_1.text_.text = var_52_10
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)
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

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play323621013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 323621013
		arg_53_1.duration_ = 5.03

		local var_53_0 = {
			zh = 4.033,
			ja = 5.033
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
				arg_53_0:Play323621014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = arg_53_1.actors_["10170ui_story"]
			local var_56_1 = 0

			if var_56_1 < arg_53_1.time_ and arg_53_1.time_ <= var_56_1 + arg_56_0 and not isNil(var_56_0) and arg_53_1.var_.characterEffect10170ui_story == nil then
				arg_53_1.var_.characterEffect10170ui_story = var_56_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_2 = 0.200000002980232

			if var_56_1 <= arg_53_1.time_ and arg_53_1.time_ < var_56_1 + var_56_2 and not isNil(var_56_0) then
				local var_56_3 = (arg_53_1.time_ - var_56_1) / var_56_2

				if arg_53_1.var_.characterEffect10170ui_story and not isNil(var_56_0) then
					arg_53_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_53_1.time_ >= var_56_1 + var_56_2 and arg_53_1.time_ < var_56_1 + var_56_2 + arg_56_0 and not isNil(var_56_0) and arg_53_1.var_.characterEffect10170ui_story then
				arg_53_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			local var_56_4 = 0
			local var_56_5 = 0.475

			if var_56_4 < arg_53_1.time_ and arg_53_1.time_ <= var_56_4 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_6 = arg_53_1:FormatText(StoryNameCfg[1450].name)

				arg_53_1.leftNameTxt_.text = var_56_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_7 = arg_53_1:GetWordFromCfg(323621013)
				local var_56_8 = arg_53_1:FormatText(var_56_7.content)

				arg_53_1.text_.text = var_56_8

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_9 = 19
				local var_56_10 = utf8.len(var_56_8)
				local var_56_11 = var_56_9 <= 0 and var_56_5 or var_56_5 * (var_56_10 / var_56_9)

				if var_56_11 > 0 and var_56_5 < var_56_11 then
					arg_53_1.talkMaxDuration = var_56_11

					if var_56_11 + var_56_4 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_11 + var_56_4
					end
				end

				arg_53_1.text_.text = var_56_8
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323621", "323621013", "story_v_out_323621.awb") ~= 0 then
					local var_56_12 = manager.audio:GetVoiceLength("story_v_out_323621", "323621013", "story_v_out_323621.awb") / 1000

					if var_56_12 + var_56_4 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_12 + var_56_4
					end

					if var_56_7.prefab_name ~= "" and arg_53_1.actors_[var_56_7.prefab_name] ~= nil then
						local var_56_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_7.prefab_name].transform, "story_v_out_323621", "323621013", "story_v_out_323621.awb")

						arg_53_1:RecordAudio("323621013", var_56_13)
						arg_53_1:RecordAudio("323621013", var_56_13)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_323621", "323621013", "story_v_out_323621.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_323621", "323621013", "story_v_out_323621.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_14 = math.max(var_56_5, arg_53_1.talkMaxDuration)

			if var_56_4 <= arg_53_1.time_ and arg_53_1.time_ < var_56_4 + var_56_14 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_4) / var_56_14

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_4 + var_56_14 and arg_53_1.time_ < var_56_4 + var_56_14 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play323621014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 323621014
		arg_57_1.duration_ = 5

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play323621015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = arg_57_1.actors_["10170ui_story"]
			local var_60_1 = 0

			if var_60_1 < arg_57_1.time_ and arg_57_1.time_ <= var_60_1 + arg_60_0 and not isNil(var_60_0) and arg_57_1.var_.characterEffect10170ui_story == nil then
				arg_57_1.var_.characterEffect10170ui_story = var_60_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_2 = 0.200000002980232

			if var_60_1 <= arg_57_1.time_ and arg_57_1.time_ < var_60_1 + var_60_2 and not isNil(var_60_0) then
				local var_60_3 = (arg_57_1.time_ - var_60_1) / var_60_2

				if arg_57_1.var_.characterEffect10170ui_story and not isNil(var_60_0) then
					local var_60_4 = Mathf.Lerp(0, 0.5, var_60_3)

					arg_57_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_57_1.var_.characterEffect10170ui_story.fillRatio = var_60_4
				end
			end

			if arg_57_1.time_ >= var_60_1 + var_60_2 and arg_57_1.time_ < var_60_1 + var_60_2 + arg_60_0 and not isNil(var_60_0) and arg_57_1.var_.characterEffect10170ui_story then
				local var_60_5 = 0.5

				arg_57_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_57_1.var_.characterEffect10170ui_story.fillRatio = var_60_5
			end

			local var_60_6 = 0
			local var_60_7 = 0.25

			if var_60_6 < arg_57_1.time_ and arg_57_1.time_ <= var_60_6 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_8 = arg_57_1:FormatText(StoryNameCfg[7].name)

				arg_57_1.leftNameTxt_.text = var_60_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, true)
				arg_57_1.iconController_:SetSelectedState("hero")

				arg_57_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_57_1.callingController_:SetSelectedState("normal")

				arg_57_1.keyicon_.color = Color.New(1, 1, 1)
				arg_57_1.icon_.color = Color.New(1, 1, 1)

				local var_60_9 = arg_57_1:GetWordFromCfg(323621014)
				local var_60_10 = arg_57_1:FormatText(var_60_9.content)

				arg_57_1.text_.text = var_60_10

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_11 = 10
				local var_60_12 = utf8.len(var_60_10)
				local var_60_13 = var_60_11 <= 0 and var_60_7 or var_60_7 * (var_60_12 / var_60_11)

				if var_60_13 > 0 and var_60_7 < var_60_13 then
					arg_57_1.talkMaxDuration = var_60_13

					if var_60_13 + var_60_6 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_13 + var_60_6
					end
				end

				arg_57_1.text_.text = var_60_10
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)
				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_14 = math.max(var_60_7, arg_57_1.talkMaxDuration)

			if var_60_6 <= arg_57_1.time_ and arg_57_1.time_ < var_60_6 + var_60_14 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_6) / var_60_14

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_6 + var_60_14 and arg_57_1.time_ < var_60_6 + var_60_14 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play323621015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 323621015
		arg_61_1.duration_ = 2

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play323621016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = arg_61_1.actors_["10170ui_story"]
			local var_64_1 = 0

			if var_64_1 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 and not isNil(var_64_0) and arg_61_1.var_.characterEffect10170ui_story == nil then
				arg_61_1.var_.characterEffect10170ui_story = var_64_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_2 = 0.200000002980232

			if var_64_1 <= arg_61_1.time_ and arg_61_1.time_ < var_64_1 + var_64_2 and not isNil(var_64_0) then
				local var_64_3 = (arg_61_1.time_ - var_64_1) / var_64_2

				if arg_61_1.var_.characterEffect10170ui_story and not isNil(var_64_0) then
					arg_61_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_61_1.time_ >= var_64_1 + var_64_2 and arg_61_1.time_ < var_64_1 + var_64_2 + arg_64_0 and not isNil(var_64_0) and arg_61_1.var_.characterEffect10170ui_story then
				arg_61_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			local var_64_4 = 0

			if var_64_4 < arg_61_1.time_ and arg_61_1.time_ <= var_64_4 + arg_64_0 then
				arg_61_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_64_5 = 0
			local var_64_6 = 0.2

			if var_64_5 < arg_61_1.time_ and arg_61_1.time_ <= var_64_5 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_7 = arg_61_1:FormatText(StoryNameCfg[1450].name)

				arg_61_1.leftNameTxt_.text = var_64_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_8 = arg_61_1:GetWordFromCfg(323621015)
				local var_64_9 = arg_61_1:FormatText(var_64_8.content)

				arg_61_1.text_.text = var_64_9

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_10 = 8
				local var_64_11 = utf8.len(var_64_9)
				local var_64_12 = var_64_10 <= 0 and var_64_6 or var_64_6 * (var_64_11 / var_64_10)

				if var_64_12 > 0 and var_64_6 < var_64_12 then
					arg_61_1.talkMaxDuration = var_64_12

					if var_64_12 + var_64_5 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_12 + var_64_5
					end
				end

				arg_61_1.text_.text = var_64_9
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323621", "323621015", "story_v_out_323621.awb") ~= 0 then
					local var_64_13 = manager.audio:GetVoiceLength("story_v_out_323621", "323621015", "story_v_out_323621.awb") / 1000

					if var_64_13 + var_64_5 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_13 + var_64_5
					end

					if var_64_8.prefab_name ~= "" and arg_61_1.actors_[var_64_8.prefab_name] ~= nil then
						local var_64_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_8.prefab_name].transform, "story_v_out_323621", "323621015", "story_v_out_323621.awb")

						arg_61_1:RecordAudio("323621015", var_64_14)
						arg_61_1:RecordAudio("323621015", var_64_14)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_323621", "323621015", "story_v_out_323621.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_323621", "323621015", "story_v_out_323621.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_15 = math.max(var_64_6, arg_61_1.talkMaxDuration)

			if var_64_5 <= arg_61_1.time_ and arg_61_1.time_ < var_64_5 + var_64_15 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_5) / var_64_15

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_5 + var_64_15 and arg_61_1.time_ < var_64_5 + var_64_15 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play323621016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 323621016
		arg_65_1.duration_ = 5

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play323621017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = arg_65_1.actors_["10170ui_story"]
			local var_68_1 = 0

			if var_68_1 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.characterEffect10170ui_story == nil then
				arg_65_1.var_.characterEffect10170ui_story = var_68_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_2 = 0.200000002980232

			if var_68_1 <= arg_65_1.time_ and arg_65_1.time_ < var_68_1 + var_68_2 and not isNil(var_68_0) then
				local var_68_3 = (arg_65_1.time_ - var_68_1) / var_68_2

				if arg_65_1.var_.characterEffect10170ui_story and not isNil(var_68_0) then
					local var_68_4 = Mathf.Lerp(0, 0.5, var_68_3)

					arg_65_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_65_1.var_.characterEffect10170ui_story.fillRatio = var_68_4
				end
			end

			if arg_65_1.time_ >= var_68_1 + var_68_2 and arg_65_1.time_ < var_68_1 + var_68_2 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.characterEffect10170ui_story then
				local var_68_5 = 0.5

				arg_65_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_65_1.var_.characterEffect10170ui_story.fillRatio = var_68_5
			end

			local var_68_6 = 0
			local var_68_7 = 0.175

			if var_68_6 < arg_65_1.time_ and arg_65_1.time_ <= var_68_6 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				local var_68_8 = arg_65_1:FormatText(StoryNameCfg[7].name)

				arg_65_1.leftNameTxt_.text = var_68_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, true)
				arg_65_1.iconController_:SetSelectedState("hero")

				arg_65_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_65_1.callingController_:SetSelectedState("normal")

				arg_65_1.keyicon_.color = Color.New(1, 1, 1)
				arg_65_1.icon_.color = Color.New(1, 1, 1)

				local var_68_9 = arg_65_1:GetWordFromCfg(323621016)
				local var_68_10 = arg_65_1:FormatText(var_68_9.content)

				arg_65_1.text_.text = var_68_10

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_11 = 7
				local var_68_12 = utf8.len(var_68_10)
				local var_68_13 = var_68_11 <= 0 and var_68_7 or var_68_7 * (var_68_12 / var_68_11)

				if var_68_13 > 0 and var_68_7 < var_68_13 then
					arg_65_1.talkMaxDuration = var_68_13

					if var_68_13 + var_68_6 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_13 + var_68_6
					end
				end

				arg_65_1.text_.text = var_68_10
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)
				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_14 = math.max(var_68_7, arg_65_1.talkMaxDuration)

			if var_68_6 <= arg_65_1.time_ and arg_65_1.time_ < var_68_6 + var_68_14 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_6) / var_68_14

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_6 + var_68_14 and arg_65_1.time_ < var_68_6 + var_68_14 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play323621017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 323621017
		arg_69_1.duration_ = 3.37

		local var_69_0 = {
			zh = 3.366,
			ja = 3.133
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
				arg_69_0:Play323621018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = arg_69_1.actors_["10170ui_story"]
			local var_72_1 = 0

			if var_72_1 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 and not isNil(var_72_0) and arg_69_1.var_.characterEffect10170ui_story == nil then
				arg_69_1.var_.characterEffect10170ui_story = var_72_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_2 = 0.200000002980232

			if var_72_1 <= arg_69_1.time_ and arg_69_1.time_ < var_72_1 + var_72_2 and not isNil(var_72_0) then
				local var_72_3 = (arg_69_1.time_ - var_72_1) / var_72_2

				if arg_69_1.var_.characterEffect10170ui_story and not isNil(var_72_0) then
					arg_69_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_69_1.time_ >= var_72_1 + var_72_2 and arg_69_1.time_ < var_72_1 + var_72_2 + arg_72_0 and not isNil(var_72_0) and arg_69_1.var_.characterEffect10170ui_story then
				arg_69_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			local var_72_4 = 0

			if var_72_4 < arg_69_1.time_ and arg_69_1.time_ <= var_72_4 + arg_72_0 then
				arg_69_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/story10170/story10170action/10170action30_1")
			end

			local var_72_5 = 0
			local var_72_6 = 0.4

			if var_72_5 < arg_69_1.time_ and arg_69_1.time_ <= var_72_5 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				local var_72_7 = arg_69_1:FormatText(StoryNameCfg[1450].name)

				arg_69_1.leftNameTxt_.text = var_72_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_8 = arg_69_1:GetWordFromCfg(323621017)
				local var_72_9 = arg_69_1:FormatText(var_72_8.content)

				arg_69_1.text_.text = var_72_9

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_10 = 16
				local var_72_11 = utf8.len(var_72_9)
				local var_72_12 = var_72_10 <= 0 and var_72_6 or var_72_6 * (var_72_11 / var_72_10)

				if var_72_12 > 0 and var_72_6 < var_72_12 then
					arg_69_1.talkMaxDuration = var_72_12

					if var_72_12 + var_72_5 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_12 + var_72_5
					end
				end

				arg_69_1.text_.text = var_72_9
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323621", "323621017", "story_v_out_323621.awb") ~= 0 then
					local var_72_13 = manager.audio:GetVoiceLength("story_v_out_323621", "323621017", "story_v_out_323621.awb") / 1000

					if var_72_13 + var_72_5 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_13 + var_72_5
					end

					if var_72_8.prefab_name ~= "" and arg_69_1.actors_[var_72_8.prefab_name] ~= nil then
						local var_72_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_8.prefab_name].transform, "story_v_out_323621", "323621017", "story_v_out_323621.awb")

						arg_69_1:RecordAudio("323621017", var_72_14)
						arg_69_1:RecordAudio("323621017", var_72_14)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_323621", "323621017", "story_v_out_323621.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_323621", "323621017", "story_v_out_323621.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_15 = math.max(var_72_6, arg_69_1.talkMaxDuration)

			if var_72_5 <= arg_69_1.time_ and arg_69_1.time_ < var_72_5 + var_72_15 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_5) / var_72_15

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_5 + var_72_15 and arg_69_1.time_ < var_72_5 + var_72_15 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play323621018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 323621018
		arg_73_1.duration_ = 16.5

		local var_73_0 = {
			zh = 9.866,
			ja = 16.5
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
				arg_73_0:Play323621019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = 0
			local var_76_1 = 1.1

			if var_76_0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_0 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				local var_76_2 = arg_73_1:FormatText(StoryNameCfg[1450].name)

				arg_73_1.leftNameTxt_.text = var_76_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_3 = arg_73_1:GetWordFromCfg(323621018)
				local var_76_4 = arg_73_1:FormatText(var_76_3.content)

				arg_73_1.text_.text = var_76_4

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_5 = 44
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

				if manager.audio:GetVoiceLength("story_v_out_323621", "323621018", "story_v_out_323621.awb") ~= 0 then
					local var_76_8 = manager.audio:GetVoiceLength("story_v_out_323621", "323621018", "story_v_out_323621.awb") / 1000

					if var_76_8 + var_76_0 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_8 + var_76_0
					end

					if var_76_3.prefab_name ~= "" and arg_73_1.actors_[var_76_3.prefab_name] ~= nil then
						local var_76_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_3.prefab_name].transform, "story_v_out_323621", "323621018", "story_v_out_323621.awb")

						arg_73_1:RecordAudio("323621018", var_76_9)
						arg_73_1:RecordAudio("323621018", var_76_9)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_323621", "323621018", "story_v_out_323621.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_323621", "323621018", "story_v_out_323621.awb")
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
	Play323621019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 323621019
		arg_77_1.duration_ = 5

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play323621020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = arg_77_1.actors_["10170ui_story"]
			local var_80_1 = 0

			if var_80_1 < arg_77_1.time_ and arg_77_1.time_ <= var_80_1 + arg_80_0 and not isNil(var_80_0) and arg_77_1.var_.characterEffect10170ui_story == nil then
				arg_77_1.var_.characterEffect10170ui_story = var_80_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_2 = 0.200000002980232

			if var_80_1 <= arg_77_1.time_ and arg_77_1.time_ < var_80_1 + var_80_2 and not isNil(var_80_0) then
				local var_80_3 = (arg_77_1.time_ - var_80_1) / var_80_2

				if arg_77_1.var_.characterEffect10170ui_story and not isNil(var_80_0) then
					local var_80_4 = Mathf.Lerp(0, 0.5, var_80_3)

					arg_77_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_77_1.var_.characterEffect10170ui_story.fillRatio = var_80_4
				end
			end

			if arg_77_1.time_ >= var_80_1 + var_80_2 and arg_77_1.time_ < var_80_1 + var_80_2 + arg_80_0 and not isNil(var_80_0) and arg_77_1.var_.characterEffect10170ui_story then
				local var_80_5 = 0.5

				arg_77_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_77_1.var_.characterEffect10170ui_story.fillRatio = var_80_5
			end

			local var_80_6 = 0
			local var_80_7 = 1.525

			if var_80_6 < arg_77_1.time_ and arg_77_1.time_ <= var_80_6 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, false)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_8 = arg_77_1:GetWordFromCfg(323621019)
				local var_80_9 = arg_77_1:FormatText(var_80_8.content)

				arg_77_1.text_.text = var_80_9

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_10 = 61
				local var_80_11 = utf8.len(var_80_9)
				local var_80_12 = var_80_10 <= 0 and var_80_7 or var_80_7 * (var_80_11 / var_80_10)

				if var_80_12 > 0 and var_80_7 < var_80_12 then
					arg_77_1.talkMaxDuration = var_80_12

					if var_80_12 + var_80_6 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_12 + var_80_6
					end
				end

				arg_77_1.text_.text = var_80_9
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)
				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_13 = math.max(var_80_7, arg_77_1.talkMaxDuration)

			if var_80_6 <= arg_77_1.time_ and arg_77_1.time_ < var_80_6 + var_80_13 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_6) / var_80_13

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_6 + var_80_13 and arg_77_1.time_ < var_80_6 + var_80_13 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play323621020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 323621020
		arg_81_1.duration_ = 5

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play323621021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = 0
			local var_84_1 = 0.25

			if var_84_0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_0 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				local var_84_2 = arg_81_1:FormatText(StoryNameCfg[7].name)

				arg_81_1.leftNameTxt_.text = var_84_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, true)
				arg_81_1.iconController_:SetSelectedState("hero")

				arg_81_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_81_1.callingController_:SetSelectedState("normal")

				arg_81_1.keyicon_.color = Color.New(1, 1, 1)
				arg_81_1.icon_.color = Color.New(1, 1, 1)

				local var_84_3 = arg_81_1:GetWordFromCfg(323621020)
				local var_84_4 = arg_81_1:FormatText(var_84_3.content)

				arg_81_1.text_.text = var_84_4

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_5 = 10
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
				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_8 = math.max(var_84_1, arg_81_1.talkMaxDuration)

			if var_84_0 <= arg_81_1.time_ and arg_81_1.time_ < var_84_0 + var_84_8 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_0) / var_84_8

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_0 + var_84_8 and arg_81_1.time_ < var_84_0 + var_84_8 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play323621021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 323621021
		arg_85_1.duration_ = 2

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play323621022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = arg_85_1.actors_["10170ui_story"]
			local var_88_1 = 0

			if var_88_1 < arg_85_1.time_ and arg_85_1.time_ <= var_88_1 + arg_88_0 and not isNil(var_88_0) and arg_85_1.var_.characterEffect10170ui_story == nil then
				arg_85_1.var_.characterEffect10170ui_story = var_88_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_2 = 0.200000002980232

			if var_88_1 <= arg_85_1.time_ and arg_85_1.time_ < var_88_1 + var_88_2 and not isNil(var_88_0) then
				local var_88_3 = (arg_85_1.time_ - var_88_1) / var_88_2

				if arg_85_1.var_.characterEffect10170ui_story and not isNil(var_88_0) then
					arg_85_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_85_1.time_ >= var_88_1 + var_88_2 and arg_85_1.time_ < var_88_1 + var_88_2 + arg_88_0 and not isNil(var_88_0) and arg_85_1.var_.characterEffect10170ui_story then
				arg_85_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			local var_88_4 = 0

			if var_88_4 < arg_85_1.time_ and arg_85_1.time_ <= var_88_4 + arg_88_0 then
				arg_85_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_88_5 = 0

			if var_88_5 < arg_85_1.time_ and arg_85_1.time_ <= var_88_5 + arg_88_0 then
				arg_85_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/story10170/story10170action/10170action30_2")
			end

			local var_88_6 = 0
			local var_88_7 = 0.0329999998211861

			if var_88_6 < arg_85_1.time_ and arg_85_1.time_ <= var_88_6 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				local var_88_8 = arg_85_1:FormatText(StoryNameCfg[1450].name)

				arg_85_1.leftNameTxt_.text = var_88_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_9 = arg_85_1:GetWordFromCfg(323621021)
				local var_88_10 = arg_85_1:FormatText(var_88_9.content)

				arg_85_1.text_.text = var_88_10

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_11 = 1
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

				if manager.audio:GetVoiceLength("story_v_out_323621", "323621021", "story_v_out_323621.awb") ~= 0 then
					local var_88_14 = manager.audio:GetVoiceLength("story_v_out_323621", "323621021", "story_v_out_323621.awb") / 1000

					if var_88_14 + var_88_6 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_14 + var_88_6
					end

					if var_88_9.prefab_name ~= "" and arg_85_1.actors_[var_88_9.prefab_name] ~= nil then
						local var_88_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_9.prefab_name].transform, "story_v_out_323621", "323621021", "story_v_out_323621.awb")

						arg_85_1:RecordAudio("323621021", var_88_15)
						arg_85_1:RecordAudio("323621021", var_88_15)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_323621", "323621021", "story_v_out_323621.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_323621", "323621021", "story_v_out_323621.awb")
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
	Play323621022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 323621022
		arg_89_1.duration_ = 5

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play323621023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = arg_89_1.actors_["10170ui_story"]
			local var_92_1 = 0

			if var_92_1 < arg_89_1.time_ and arg_89_1.time_ <= var_92_1 + arg_92_0 and not isNil(var_92_0) and arg_89_1.var_.characterEffect10170ui_story == nil then
				arg_89_1.var_.characterEffect10170ui_story = var_92_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_2 = 0.200000002980232

			if var_92_1 <= arg_89_1.time_ and arg_89_1.time_ < var_92_1 + var_92_2 and not isNil(var_92_0) then
				local var_92_3 = (arg_89_1.time_ - var_92_1) / var_92_2

				if arg_89_1.var_.characterEffect10170ui_story and not isNil(var_92_0) then
					local var_92_4 = Mathf.Lerp(0, 0.5, var_92_3)

					arg_89_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_89_1.var_.characterEffect10170ui_story.fillRatio = var_92_4
				end
			end

			if arg_89_1.time_ >= var_92_1 + var_92_2 and arg_89_1.time_ < var_92_1 + var_92_2 + arg_92_0 and not isNil(var_92_0) and arg_89_1.var_.characterEffect10170ui_story then
				local var_92_5 = 0.5

				arg_89_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_89_1.var_.characterEffect10170ui_story.fillRatio = var_92_5
			end

			local var_92_6 = 0
			local var_92_7 = 0.8

			if var_92_6 < arg_89_1.time_ and arg_89_1.time_ <= var_92_6 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				local var_92_8 = arg_89_1:FormatText(StoryNameCfg[7].name)

				arg_89_1.leftNameTxt_.text = var_92_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, true)
				arg_89_1.iconController_:SetSelectedState("hero")

				arg_89_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_89_1.callingController_:SetSelectedState("normal")

				arg_89_1.keyicon_.color = Color.New(1, 1, 1)
				arg_89_1.icon_.color = Color.New(1, 1, 1)

				local var_92_9 = arg_89_1:GetWordFromCfg(323621022)
				local var_92_10 = arg_89_1:FormatText(var_92_9.content)

				arg_89_1.text_.text = var_92_10

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_11 = 32
				local var_92_12 = utf8.len(var_92_10)
				local var_92_13 = var_92_11 <= 0 and var_92_7 or var_92_7 * (var_92_12 / var_92_11)

				if var_92_13 > 0 and var_92_7 < var_92_13 then
					arg_89_1.talkMaxDuration = var_92_13

					if var_92_13 + var_92_6 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_13 + var_92_6
					end
				end

				arg_89_1.text_.text = var_92_10
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)
				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_14 = math.max(var_92_7, arg_89_1.talkMaxDuration)

			if var_92_6 <= arg_89_1.time_ and arg_89_1.time_ < var_92_6 + var_92_14 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_6) / var_92_14

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_6 + var_92_14 and arg_89_1.time_ < var_92_6 + var_92_14 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play323621023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 323621023
		arg_93_1.duration_ = 3.6

		local var_93_0 = {
			zh = 3,
			ja = 3.6
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
				arg_93_0:Play323621024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = arg_93_1.actors_["10170ui_story"]
			local var_96_1 = 0

			if var_96_1 < arg_93_1.time_ and arg_93_1.time_ <= var_96_1 + arg_96_0 and not isNil(var_96_0) and arg_93_1.var_.characterEffect10170ui_story == nil then
				arg_93_1.var_.characterEffect10170ui_story = var_96_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_2 = 0.200000002980232

			if var_96_1 <= arg_93_1.time_ and arg_93_1.time_ < var_96_1 + var_96_2 and not isNil(var_96_0) then
				local var_96_3 = (arg_93_1.time_ - var_96_1) / var_96_2

				if arg_93_1.var_.characterEffect10170ui_story and not isNil(var_96_0) then
					arg_93_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_93_1.time_ >= var_96_1 + var_96_2 and arg_93_1.time_ < var_96_1 + var_96_2 + arg_96_0 and not isNil(var_96_0) and arg_93_1.var_.characterEffect10170ui_story then
				arg_93_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			local var_96_4 = 0
			local var_96_5 = 0.2

			if var_96_4 < arg_93_1.time_ and arg_93_1.time_ <= var_96_4 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				local var_96_6 = arg_93_1:FormatText(StoryNameCfg[1450].name)

				arg_93_1.leftNameTxt_.text = var_96_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_7 = arg_93_1:GetWordFromCfg(323621023)
				local var_96_8 = arg_93_1:FormatText(var_96_7.content)

				arg_93_1.text_.text = var_96_8

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_9 = 8
				local var_96_10 = utf8.len(var_96_8)
				local var_96_11 = var_96_9 <= 0 and var_96_5 or var_96_5 * (var_96_10 / var_96_9)

				if var_96_11 > 0 and var_96_5 < var_96_11 then
					arg_93_1.talkMaxDuration = var_96_11

					if var_96_11 + var_96_4 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_11 + var_96_4
					end
				end

				arg_93_1.text_.text = var_96_8
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323621", "323621023", "story_v_out_323621.awb") ~= 0 then
					local var_96_12 = manager.audio:GetVoiceLength("story_v_out_323621", "323621023", "story_v_out_323621.awb") / 1000

					if var_96_12 + var_96_4 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_12 + var_96_4
					end

					if var_96_7.prefab_name ~= "" and arg_93_1.actors_[var_96_7.prefab_name] ~= nil then
						local var_96_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_7.prefab_name].transform, "story_v_out_323621", "323621023", "story_v_out_323621.awb")

						arg_93_1:RecordAudio("323621023", var_96_13)
						arg_93_1:RecordAudio("323621023", var_96_13)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_323621", "323621023", "story_v_out_323621.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_323621", "323621023", "story_v_out_323621.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_14 = math.max(var_96_5, arg_93_1.talkMaxDuration)

			if var_96_4 <= arg_93_1.time_ and arg_93_1.time_ < var_96_4 + var_96_14 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_4) / var_96_14

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_4 + var_96_14 and arg_93_1.time_ < var_96_4 + var_96_14 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play323621024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 323621024
		arg_97_1.duration_ = 5

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play323621025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = arg_97_1.actors_["10170ui_story"]
			local var_100_1 = 0

			if var_100_1 < arg_97_1.time_ and arg_97_1.time_ <= var_100_1 + arg_100_0 and not isNil(var_100_0) and arg_97_1.var_.characterEffect10170ui_story == nil then
				arg_97_1.var_.characterEffect10170ui_story = var_100_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_2 = 0.200000002980232

			if var_100_1 <= arg_97_1.time_ and arg_97_1.time_ < var_100_1 + var_100_2 and not isNil(var_100_0) then
				local var_100_3 = (arg_97_1.time_ - var_100_1) / var_100_2

				if arg_97_1.var_.characterEffect10170ui_story and not isNil(var_100_0) then
					local var_100_4 = Mathf.Lerp(0, 0.5, var_100_3)

					arg_97_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_97_1.var_.characterEffect10170ui_story.fillRatio = var_100_4
				end
			end

			if arg_97_1.time_ >= var_100_1 + var_100_2 and arg_97_1.time_ < var_100_1 + var_100_2 + arg_100_0 and not isNil(var_100_0) and arg_97_1.var_.characterEffect10170ui_story then
				local var_100_5 = 0.5

				arg_97_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_97_1.var_.characterEffect10170ui_story.fillRatio = var_100_5
			end

			local var_100_6 = arg_97_1.actors_["10170ui_story"].transform
			local var_100_7 = 0

			if var_100_7 < arg_97_1.time_ and arg_97_1.time_ <= var_100_7 + arg_100_0 then
				arg_97_1.var_.moveOldPos10170ui_story = var_100_6.localPosition

				local var_100_8 = GameObjectTools.GetOrAddComponent(var_100_6.gameObject, typeof(DynamicBoneHelper))

				if var_100_8 then
					var_100_8:EnableDynamicBone(false)
				end
			end

			local var_100_9 = 0.001

			if var_100_7 <= arg_97_1.time_ and arg_97_1.time_ < var_100_7 + var_100_9 then
				local var_100_10 = (arg_97_1.time_ - var_100_7) / var_100_9
				local var_100_11 = Vector3.New(0, 100, 0)

				var_100_6.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos10170ui_story, var_100_11, var_100_10)

				local var_100_12 = manager.ui.mainCamera.transform.position - var_100_6.position

				var_100_6.forward = Vector3.New(var_100_12.x, var_100_12.y, var_100_12.z)

				local var_100_13 = var_100_6.localEulerAngles

				var_100_13.z = 0
				var_100_13.x = 0
				var_100_6.localEulerAngles = var_100_13
			end

			if arg_97_1.time_ >= var_100_7 + var_100_9 and arg_97_1.time_ < var_100_7 + var_100_9 + arg_100_0 then
				var_100_6.localPosition = Vector3.New(0, 100, 0)

				local var_100_14 = manager.ui.mainCamera.transform.position - var_100_6.position

				var_100_6.forward = Vector3.New(var_100_14.x, var_100_14.y, var_100_14.z)

				local var_100_15 = var_100_6.localEulerAngles

				var_100_15.z = 0
				var_100_15.x = 0
				var_100_6.localEulerAngles = var_100_15

				local var_100_16 = GameObjectTools.GetOrAddComponent(var_100_6.gameObject, typeof(DynamicBoneHelper))

				if var_100_16 then
					var_100_16:EnableDynamicBone(true)
				end
			end

			local var_100_17 = 0
			local var_100_18 = 1

			if var_100_17 < arg_97_1.time_ and arg_97_1.time_ <= var_100_17 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, false)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_19 = arg_97_1:GetWordFromCfg(323621024)
				local var_100_20 = arg_97_1:FormatText(var_100_19.content)

				arg_97_1.text_.text = var_100_20

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_21 = 40
				local var_100_22 = utf8.len(var_100_20)
				local var_100_23 = var_100_21 <= 0 and var_100_18 or var_100_18 * (var_100_22 / var_100_21)

				if var_100_23 > 0 and var_100_18 < var_100_23 then
					arg_97_1.talkMaxDuration = var_100_23

					if var_100_23 + var_100_17 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_23 + var_100_17
					end
				end

				arg_97_1.text_.text = var_100_20
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)
				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_24 = math.max(var_100_18, arg_97_1.talkMaxDuration)

			if var_100_17 <= arg_97_1.time_ and arg_97_1.time_ < var_100_17 + var_100_24 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_17) / var_100_24

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_17 + var_100_24 and arg_97_1.time_ < var_100_17 + var_100_24 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {
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

		arg_97_1:InitPlayNodeList()
	end,
	Play323621025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 323621025
		arg_101_1.duration_ = 6.33

		local var_101_0 = {
			zh = 4.3,
			ja = 6.333
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
				arg_101_0:Play323621026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = arg_101_1.actors_["10170ui_story"]
			local var_104_1 = 0

			if var_104_1 < arg_101_1.time_ and arg_101_1.time_ <= var_104_1 + arg_104_0 and not isNil(var_104_0) and arg_101_1.var_.characterEffect10170ui_story == nil then
				arg_101_1.var_.characterEffect10170ui_story = var_104_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_2 = 0.200000002980232

			if var_104_1 <= arg_101_1.time_ and arg_101_1.time_ < var_104_1 + var_104_2 and not isNil(var_104_0) then
				local var_104_3 = (arg_101_1.time_ - var_104_1) / var_104_2

				if arg_101_1.var_.characterEffect10170ui_story and not isNil(var_104_0) then
					arg_101_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_101_1.time_ >= var_104_1 + var_104_2 and arg_101_1.time_ < var_104_1 + var_104_2 + arg_104_0 and not isNil(var_104_0) and arg_101_1.var_.characterEffect10170ui_story then
				arg_101_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			local var_104_4 = arg_101_1.actors_["10170ui_story"].transform
			local var_104_5 = 0

			if var_104_5 < arg_101_1.time_ and arg_101_1.time_ <= var_104_5 + arg_104_0 then
				arg_101_1.var_.moveOldPos10170ui_story = var_104_4.localPosition

				local var_104_6 = GameObjectTools.GetOrAddComponent(var_104_4.gameObject, typeof(DynamicBoneHelper))

				if var_104_6 then
					var_104_6:EnableDynamicBone(false)
				end
			end

			local var_104_7 = 0.001

			if var_104_5 <= arg_101_1.time_ and arg_101_1.time_ < var_104_5 + var_104_7 then
				local var_104_8 = (arg_101_1.time_ - var_104_5) / var_104_7
				local var_104_9 = Vector3.New(0, -1.03, -6.05)

				var_104_4.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos10170ui_story, var_104_9, var_104_8)

				local var_104_10 = manager.ui.mainCamera.transform.position - var_104_4.position

				var_104_4.forward = Vector3.New(var_104_10.x, var_104_10.y, var_104_10.z)

				local var_104_11 = var_104_4.localEulerAngles

				var_104_11.z = 0
				var_104_11.x = 0
				var_104_4.localEulerAngles = var_104_11
			end

			if arg_101_1.time_ >= var_104_5 + var_104_7 and arg_101_1.time_ < var_104_5 + var_104_7 + arg_104_0 then
				var_104_4.localPosition = Vector3.New(0, -1.03, -6.05)

				local var_104_12 = manager.ui.mainCamera.transform.position - var_104_4.position

				var_104_4.forward = Vector3.New(var_104_12.x, var_104_12.y, var_104_12.z)

				local var_104_13 = var_104_4.localEulerAngles

				var_104_13.z = 0
				var_104_13.x = 0
				var_104_4.localEulerAngles = var_104_13

				local var_104_14 = GameObjectTools.GetOrAddComponent(var_104_4.gameObject, typeof(DynamicBoneHelper))

				if var_104_14 then
					var_104_14:EnableDynamicBone(true)
				end
			end

			local var_104_15 = 0

			if var_104_15 < arg_101_1.time_ and arg_101_1.time_ <= var_104_15 + arg_104_0 then
				arg_101_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/story10170/story10170action/10170action1_1")
			end

			local var_104_16 = 0

			if var_104_16 < arg_101_1.time_ and arg_101_1.time_ <= var_104_16 + arg_104_0 then
				arg_101_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_104_17 = 0
			local var_104_18 = 0.475

			if var_104_17 < arg_101_1.time_ and arg_101_1.time_ <= var_104_17 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				local var_104_19 = arg_101_1:FormatText(StoryNameCfg[1450].name)

				arg_101_1.leftNameTxt_.text = var_104_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_20 = arg_101_1:GetWordFromCfg(323621025)
				local var_104_21 = arg_101_1:FormatText(var_104_20.content)

				arg_101_1.text_.text = var_104_21

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_22 = 19
				local var_104_23 = utf8.len(var_104_21)
				local var_104_24 = var_104_22 <= 0 and var_104_18 or var_104_18 * (var_104_23 / var_104_22)

				if var_104_24 > 0 and var_104_18 < var_104_24 then
					arg_101_1.talkMaxDuration = var_104_24

					if var_104_24 + var_104_17 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_24 + var_104_17
					end
				end

				arg_101_1.text_.text = var_104_21
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323621", "323621025", "story_v_out_323621.awb") ~= 0 then
					local var_104_25 = manager.audio:GetVoiceLength("story_v_out_323621", "323621025", "story_v_out_323621.awb") / 1000

					if var_104_25 + var_104_17 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_25 + var_104_17
					end

					if var_104_20.prefab_name ~= "" and arg_101_1.actors_[var_104_20.prefab_name] ~= nil then
						local var_104_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_20.prefab_name].transform, "story_v_out_323621", "323621025", "story_v_out_323621.awb")

						arg_101_1:RecordAudio("323621025", var_104_26)
						arg_101_1:RecordAudio("323621025", var_104_26)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_323621", "323621025", "story_v_out_323621.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_323621", "323621025", "story_v_out_323621.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_27 = math.max(var_104_18, arg_101_1.talkMaxDuration)

			if var_104_17 <= arg_101_1.time_ and arg_101_1.time_ < var_104_17 + var_104_27 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_17) / var_104_27

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_17 + var_104_27 and arg_101_1.time_ < var_104_17 + var_104_27 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {
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

		arg_101_1:InitPlayNodeList()
	end,
	Play323621026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 323621026
		arg_105_1.duration_ = 5

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play323621027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = arg_105_1.actors_["10170ui_story"]
			local var_108_1 = 0

			if var_108_1 < arg_105_1.time_ and arg_105_1.time_ <= var_108_1 + arg_108_0 and not isNil(var_108_0) and arg_105_1.var_.characterEffect10170ui_story == nil then
				arg_105_1.var_.characterEffect10170ui_story = var_108_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_2 = 0.200000002980232

			if var_108_1 <= arg_105_1.time_ and arg_105_1.time_ < var_108_1 + var_108_2 and not isNil(var_108_0) then
				local var_108_3 = (arg_105_1.time_ - var_108_1) / var_108_2

				if arg_105_1.var_.characterEffect10170ui_story and not isNil(var_108_0) then
					local var_108_4 = Mathf.Lerp(0, 0.5, var_108_3)

					arg_105_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_105_1.var_.characterEffect10170ui_story.fillRatio = var_108_4
				end
			end

			if arg_105_1.time_ >= var_108_1 + var_108_2 and arg_105_1.time_ < var_108_1 + var_108_2 + arg_108_0 and not isNil(var_108_0) and arg_105_1.var_.characterEffect10170ui_story then
				local var_108_5 = 0.5

				arg_105_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_105_1.var_.characterEffect10170ui_story.fillRatio = var_108_5
			end

			local var_108_6 = 0
			local var_108_7 = 0.3

			if var_108_6 < arg_105_1.time_ and arg_105_1.time_ <= var_108_6 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				local var_108_8 = arg_105_1:FormatText(StoryNameCfg[7].name)

				arg_105_1.leftNameTxt_.text = var_108_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, true)
				arg_105_1.iconController_:SetSelectedState("hero")

				arg_105_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_105_1.callingController_:SetSelectedState("normal")

				arg_105_1.keyicon_.color = Color.New(1, 1, 1)
				arg_105_1.icon_.color = Color.New(1, 1, 1)

				local var_108_9 = arg_105_1:GetWordFromCfg(323621026)
				local var_108_10 = arg_105_1:FormatText(var_108_9.content)

				arg_105_1.text_.text = var_108_10

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_11 = 12
				local var_108_12 = utf8.len(var_108_10)
				local var_108_13 = var_108_11 <= 0 and var_108_7 or var_108_7 * (var_108_12 / var_108_11)

				if var_108_13 > 0 and var_108_7 < var_108_13 then
					arg_105_1.talkMaxDuration = var_108_13

					if var_108_13 + var_108_6 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_13 + var_108_6
					end
				end

				arg_105_1.text_.text = var_108_10
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)
				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_14 = math.max(var_108_7, arg_105_1.talkMaxDuration)

			if var_108_6 <= arg_105_1.time_ and arg_105_1.time_ < var_108_6 + var_108_14 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_6) / var_108_14

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_6 + var_108_14 and arg_105_1.time_ < var_108_6 + var_108_14 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play323621027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 323621027
		arg_109_1.duration_ = 6.43

		local var_109_0 = {
			zh = 5.5,
			ja = 6.433
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
				arg_109_0:Play323621028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = arg_109_1.actors_["10170ui_story"]
			local var_112_1 = 0

			if var_112_1 < arg_109_1.time_ and arg_109_1.time_ <= var_112_1 + arg_112_0 and not isNil(var_112_0) and arg_109_1.var_.characterEffect10170ui_story == nil then
				arg_109_1.var_.characterEffect10170ui_story = var_112_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_2 = 0.200000002980232

			if var_112_1 <= arg_109_1.time_ and arg_109_1.time_ < var_112_1 + var_112_2 and not isNil(var_112_0) then
				local var_112_3 = (arg_109_1.time_ - var_112_1) / var_112_2

				if arg_109_1.var_.characterEffect10170ui_story and not isNil(var_112_0) then
					arg_109_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_109_1.time_ >= var_112_1 + var_112_2 and arg_109_1.time_ < var_112_1 + var_112_2 + arg_112_0 and not isNil(var_112_0) and arg_109_1.var_.characterEffect10170ui_story then
				arg_109_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			local var_112_4 = 0
			local var_112_5 = 0.575

			if var_112_4 < arg_109_1.time_ and arg_109_1.time_ <= var_112_4 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				local var_112_6 = arg_109_1:FormatText(StoryNameCfg[1450].name)

				arg_109_1.leftNameTxt_.text = var_112_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_7 = arg_109_1:GetWordFromCfg(323621027)
				local var_112_8 = arg_109_1:FormatText(var_112_7.content)

				arg_109_1.text_.text = var_112_8

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_9 = 23
				local var_112_10 = utf8.len(var_112_8)
				local var_112_11 = var_112_9 <= 0 and var_112_5 or var_112_5 * (var_112_10 / var_112_9)

				if var_112_11 > 0 and var_112_5 < var_112_11 then
					arg_109_1.talkMaxDuration = var_112_11

					if var_112_11 + var_112_4 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_11 + var_112_4
					end
				end

				arg_109_1.text_.text = var_112_8
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323621", "323621027", "story_v_out_323621.awb") ~= 0 then
					local var_112_12 = manager.audio:GetVoiceLength("story_v_out_323621", "323621027", "story_v_out_323621.awb") / 1000

					if var_112_12 + var_112_4 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_12 + var_112_4
					end

					if var_112_7.prefab_name ~= "" and arg_109_1.actors_[var_112_7.prefab_name] ~= nil then
						local var_112_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_7.prefab_name].transform, "story_v_out_323621", "323621027", "story_v_out_323621.awb")

						arg_109_1:RecordAudio("323621027", var_112_13)
						arg_109_1:RecordAudio("323621027", var_112_13)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_323621", "323621027", "story_v_out_323621.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_323621", "323621027", "story_v_out_323621.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_14 = math.max(var_112_5, arg_109_1.talkMaxDuration)

			if var_112_4 <= arg_109_1.time_ and arg_109_1.time_ < var_112_4 + var_112_14 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_4) / var_112_14

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_4 + var_112_14 and arg_109_1.time_ < var_112_4 + var_112_14 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play323621028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 323621028
		arg_113_1.duration_ = 5

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play323621029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = arg_113_1.actors_["10170ui_story"].transform
			local var_116_1 = 0

			if var_116_1 < arg_113_1.time_ and arg_113_1.time_ <= var_116_1 + arg_116_0 then
				arg_113_1.var_.moveOldPos10170ui_story = var_116_0.localPosition

				local var_116_2 = GameObjectTools.GetOrAddComponent(var_116_0.gameObject, typeof(DynamicBoneHelper))

				if var_116_2 then
					var_116_2:EnableDynamicBone(false)
				end
			end

			local var_116_3 = 0.001

			if var_116_1 <= arg_113_1.time_ and arg_113_1.time_ < var_116_1 + var_116_3 then
				local var_116_4 = (arg_113_1.time_ - var_116_1) / var_116_3
				local var_116_5 = Vector3.New(0, 100, 0)

				var_116_0.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos10170ui_story, var_116_5, var_116_4)

				local var_116_6 = manager.ui.mainCamera.transform.position - var_116_0.position

				var_116_0.forward = Vector3.New(var_116_6.x, var_116_6.y, var_116_6.z)

				local var_116_7 = var_116_0.localEulerAngles

				var_116_7.z = 0
				var_116_7.x = 0
				var_116_0.localEulerAngles = var_116_7
			end

			if arg_113_1.time_ >= var_116_1 + var_116_3 and arg_113_1.time_ < var_116_1 + var_116_3 + arg_116_0 then
				var_116_0.localPosition = Vector3.New(0, 100, 0)

				local var_116_8 = manager.ui.mainCamera.transform.position - var_116_0.position

				var_116_0.forward = Vector3.New(var_116_8.x, var_116_8.y, var_116_8.z)

				local var_116_9 = var_116_0.localEulerAngles

				var_116_9.z = 0
				var_116_9.x = 0
				var_116_0.localEulerAngles = var_116_9

				local var_116_10 = GameObjectTools.GetOrAddComponent(var_116_0.gameObject, typeof(DynamicBoneHelper))

				if var_116_10 then
					var_116_10:EnableDynamicBone(true)
				end
			end

			local var_116_11 = arg_113_1.actors_["10170ui_story"]
			local var_116_12 = 0

			if var_116_12 < arg_113_1.time_ and arg_113_1.time_ <= var_116_12 + arg_116_0 and not isNil(var_116_11) and arg_113_1.var_.characterEffect10170ui_story == nil then
				arg_113_1.var_.characterEffect10170ui_story = var_116_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_13 = 0.200000002980232

			if var_116_12 <= arg_113_1.time_ and arg_113_1.time_ < var_116_12 + var_116_13 and not isNil(var_116_11) then
				local var_116_14 = (arg_113_1.time_ - var_116_12) / var_116_13

				if arg_113_1.var_.characterEffect10170ui_story and not isNil(var_116_11) then
					local var_116_15 = Mathf.Lerp(0, 0.5, var_116_14)

					arg_113_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_113_1.var_.characterEffect10170ui_story.fillRatio = var_116_15
				end
			end

			if arg_113_1.time_ >= var_116_12 + var_116_13 and arg_113_1.time_ < var_116_12 + var_116_13 + arg_116_0 and not isNil(var_116_11) and arg_113_1.var_.characterEffect10170ui_story then
				local var_116_16 = 0.5

				arg_113_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_113_1.var_.characterEffect10170ui_story.fillRatio = var_116_16
			end

			local var_116_17 = 0
			local var_116_18 = 1.125

			if var_116_17 < arg_113_1.time_ and arg_113_1.time_ <= var_116_17 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, false)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_19 = arg_113_1:GetWordFromCfg(323621028)
				local var_116_20 = arg_113_1:FormatText(var_116_19.content)

				arg_113_1.text_.text = var_116_20

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_21 = 45
				local var_116_22 = utf8.len(var_116_20)
				local var_116_23 = var_116_21 <= 0 and var_116_18 or var_116_18 * (var_116_22 / var_116_21)

				if var_116_23 > 0 and var_116_18 < var_116_23 then
					arg_113_1.talkMaxDuration = var_116_23

					if var_116_23 + var_116_17 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_23 + var_116_17
					end
				end

				arg_113_1.text_.text = var_116_20
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)
				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_24 = math.max(var_116_18, arg_113_1.talkMaxDuration)

			if var_116_17 <= arg_113_1.time_ and arg_113_1.time_ < var_116_17 + var_116_24 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_17) / var_116_24

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_17 + var_116_24 and arg_113_1.time_ < var_116_17 + var_116_24 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {
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

		arg_113_1:InitPlayNodeList()
	end,
	Play323621029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 323621029
		arg_117_1.duration_ = 8.03

		local var_117_0 = {
			zh = 6,
			ja = 8.033
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
				arg_117_0:Play323621030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = arg_117_1.actors_["10170ui_story"].transform
			local var_120_1 = 0

			if var_120_1 < arg_117_1.time_ and arg_117_1.time_ <= var_120_1 + arg_120_0 then
				arg_117_1.var_.moveOldPos10170ui_story = var_120_0.localPosition

				local var_120_2 = GameObjectTools.GetOrAddComponent(var_120_0.gameObject, typeof(DynamicBoneHelper))

				if var_120_2 then
					var_120_2:EnableDynamicBone(false)
				end
			end

			local var_120_3 = 0.001

			if var_120_1 <= arg_117_1.time_ and arg_117_1.time_ < var_120_1 + var_120_3 then
				local var_120_4 = (arg_117_1.time_ - var_120_1) / var_120_3
				local var_120_5 = Vector3.New(0, -1.03, -6.05)

				var_120_0.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos10170ui_story, var_120_5, var_120_4)

				local var_120_6 = manager.ui.mainCamera.transform.position - var_120_0.position

				var_120_0.forward = Vector3.New(var_120_6.x, var_120_6.y, var_120_6.z)

				local var_120_7 = var_120_0.localEulerAngles

				var_120_7.z = 0
				var_120_7.x = 0
				var_120_0.localEulerAngles = var_120_7
			end

			if arg_117_1.time_ >= var_120_1 + var_120_3 and arg_117_1.time_ < var_120_1 + var_120_3 + arg_120_0 then
				var_120_0.localPosition = Vector3.New(0, -1.03, -6.05)

				local var_120_8 = manager.ui.mainCamera.transform.position - var_120_0.position

				var_120_0.forward = Vector3.New(var_120_8.x, var_120_8.y, var_120_8.z)

				local var_120_9 = var_120_0.localEulerAngles

				var_120_9.z = 0
				var_120_9.x = 0
				var_120_0.localEulerAngles = var_120_9

				local var_120_10 = GameObjectTools.GetOrAddComponent(var_120_0.gameObject, typeof(DynamicBoneHelper))

				if var_120_10 then
					var_120_10:EnableDynamicBone(true)
				end
			end

			local var_120_11 = arg_117_1.actors_["10170ui_story"]
			local var_120_12 = 0

			if var_120_12 < arg_117_1.time_ and arg_117_1.time_ <= var_120_12 + arg_120_0 and not isNil(var_120_11) and arg_117_1.var_.characterEffect10170ui_story == nil then
				arg_117_1.var_.characterEffect10170ui_story = var_120_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_13 = 0.200000002980232

			if var_120_12 <= arg_117_1.time_ and arg_117_1.time_ < var_120_12 + var_120_13 and not isNil(var_120_11) then
				local var_120_14 = (arg_117_1.time_ - var_120_12) / var_120_13

				if arg_117_1.var_.characterEffect10170ui_story and not isNil(var_120_11) then
					arg_117_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_117_1.time_ >= var_120_12 + var_120_13 and arg_117_1.time_ < var_120_12 + var_120_13 + arg_120_0 and not isNil(var_120_11) and arg_117_1.var_.characterEffect10170ui_story then
				arg_117_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			local var_120_15 = 0

			if var_120_15 < arg_117_1.time_ and arg_117_1.time_ <= var_120_15 + arg_120_0 then
				arg_117_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_120_16 = 0

			if var_120_16 < arg_117_1.time_ and arg_117_1.time_ <= var_120_16 + arg_120_0 then
				arg_117_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/story10170/story10170action/10170action2_1")
			end

			local var_120_17 = 0
			local var_120_18 = 0.725

			if var_120_17 < arg_117_1.time_ and arg_117_1.time_ <= var_120_17 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				local var_120_19 = arg_117_1:FormatText(StoryNameCfg[1450].name)

				arg_117_1.leftNameTxt_.text = var_120_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_20 = arg_117_1:GetWordFromCfg(323621029)
				local var_120_21 = arg_117_1:FormatText(var_120_20.content)

				arg_117_1.text_.text = var_120_21

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_22 = 29
				local var_120_23 = utf8.len(var_120_21)
				local var_120_24 = var_120_22 <= 0 and var_120_18 or var_120_18 * (var_120_23 / var_120_22)

				if var_120_24 > 0 and var_120_18 < var_120_24 then
					arg_117_1.talkMaxDuration = var_120_24

					if var_120_24 + var_120_17 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_24 + var_120_17
					end
				end

				arg_117_1.text_.text = var_120_21
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323621", "323621029", "story_v_out_323621.awb") ~= 0 then
					local var_120_25 = manager.audio:GetVoiceLength("story_v_out_323621", "323621029", "story_v_out_323621.awb") / 1000

					if var_120_25 + var_120_17 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_25 + var_120_17
					end

					if var_120_20.prefab_name ~= "" and arg_117_1.actors_[var_120_20.prefab_name] ~= nil then
						local var_120_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_20.prefab_name].transform, "story_v_out_323621", "323621029", "story_v_out_323621.awb")

						arg_117_1:RecordAudio("323621029", var_120_26)
						arg_117_1:RecordAudio("323621029", var_120_26)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_323621", "323621029", "story_v_out_323621.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_323621", "323621029", "story_v_out_323621.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_27 = math.max(var_120_18, arg_117_1.talkMaxDuration)

			if var_120_17 <= arg_117_1.time_ and arg_117_1.time_ < var_120_17 + var_120_27 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_17) / var_120_27

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_17 + var_120_27 and arg_117_1.time_ < var_120_17 + var_120_27 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {
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

		arg_117_1:InitPlayNodeList()
	end,
	Play323621030 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 323621030
		arg_121_1.duration_ = 5

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play323621031(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = arg_121_1.actors_["10170ui_story"]
			local var_124_1 = 0

			if var_124_1 < arg_121_1.time_ and arg_121_1.time_ <= var_124_1 + arg_124_0 and not isNil(var_124_0) and arg_121_1.var_.characterEffect10170ui_story == nil then
				arg_121_1.var_.characterEffect10170ui_story = var_124_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_2 = 0.200000002980232

			if var_124_1 <= arg_121_1.time_ and arg_121_1.time_ < var_124_1 + var_124_2 and not isNil(var_124_0) then
				local var_124_3 = (arg_121_1.time_ - var_124_1) / var_124_2

				if arg_121_1.var_.characterEffect10170ui_story and not isNil(var_124_0) then
					local var_124_4 = Mathf.Lerp(0, 0.5, var_124_3)

					arg_121_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_121_1.var_.characterEffect10170ui_story.fillRatio = var_124_4
				end
			end

			if arg_121_1.time_ >= var_124_1 + var_124_2 and arg_121_1.time_ < var_124_1 + var_124_2 + arg_124_0 and not isNil(var_124_0) and arg_121_1.var_.characterEffect10170ui_story then
				local var_124_5 = 0.5

				arg_121_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_121_1.var_.characterEffect10170ui_story.fillRatio = var_124_5
			end

			local var_124_6 = 0
			local var_124_7 = 0.9

			if var_124_6 < arg_121_1.time_ and arg_121_1.time_ <= var_124_6 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				local var_124_8 = arg_121_1:FormatText(StoryNameCfg[7].name)

				arg_121_1.leftNameTxt_.text = var_124_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, true)
				arg_121_1.iconController_:SetSelectedState("hero")

				arg_121_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_121_1.callingController_:SetSelectedState("normal")

				arg_121_1.keyicon_.color = Color.New(1, 1, 1)
				arg_121_1.icon_.color = Color.New(1, 1, 1)

				local var_124_9 = arg_121_1:GetWordFromCfg(323621030)
				local var_124_10 = arg_121_1:FormatText(var_124_9.content)

				arg_121_1.text_.text = var_124_10

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_11 = 36
				local var_124_12 = utf8.len(var_124_10)
				local var_124_13 = var_124_11 <= 0 and var_124_7 or var_124_7 * (var_124_12 / var_124_11)

				if var_124_13 > 0 and var_124_7 < var_124_13 then
					arg_121_1.talkMaxDuration = var_124_13

					if var_124_13 + var_124_6 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_13 + var_124_6
					end
				end

				arg_121_1.text_.text = var_124_10
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)
				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_14 = math.max(var_124_7, arg_121_1.talkMaxDuration)

			if var_124_6 <= arg_121_1.time_ and arg_121_1.time_ < var_124_6 + var_124_14 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_6) / var_124_14

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_6 + var_124_14 and arg_121_1.time_ < var_124_6 + var_124_14 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {}

		arg_121_1:InitPlayNodeList()
	end,
	Play323621031 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 323621031
		arg_125_1.duration_ = 5.77

		local var_125_0 = {
			zh = 4,
			ja = 5.766
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
				arg_125_0:Play323621032(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = arg_125_1.actors_["10170ui_story"]
			local var_128_1 = 0

			if var_128_1 < arg_125_1.time_ and arg_125_1.time_ <= var_128_1 + arg_128_0 and not isNil(var_128_0) and arg_125_1.var_.characterEffect10170ui_story == nil then
				arg_125_1.var_.characterEffect10170ui_story = var_128_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_2 = 0.200000002980232

			if var_128_1 <= arg_125_1.time_ and arg_125_1.time_ < var_128_1 + var_128_2 and not isNil(var_128_0) then
				local var_128_3 = (arg_125_1.time_ - var_128_1) / var_128_2

				if arg_125_1.var_.characterEffect10170ui_story and not isNil(var_128_0) then
					arg_125_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_125_1.time_ >= var_128_1 + var_128_2 and arg_125_1.time_ < var_128_1 + var_128_2 + arg_128_0 and not isNil(var_128_0) and arg_125_1.var_.characterEffect10170ui_story then
				arg_125_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			local var_128_4 = 0
			local var_128_5 = 0.475

			if var_128_4 < arg_125_1.time_ and arg_125_1.time_ <= var_128_4 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				local var_128_6 = arg_125_1:FormatText(StoryNameCfg[1450].name)

				arg_125_1.leftNameTxt_.text = var_128_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_7 = arg_125_1:GetWordFromCfg(323621031)
				local var_128_8 = arg_125_1:FormatText(var_128_7.content)

				arg_125_1.text_.text = var_128_8

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_9 = 19
				local var_128_10 = utf8.len(var_128_8)
				local var_128_11 = var_128_9 <= 0 and var_128_5 or var_128_5 * (var_128_10 / var_128_9)

				if var_128_11 > 0 and var_128_5 < var_128_11 then
					arg_125_1.talkMaxDuration = var_128_11

					if var_128_11 + var_128_4 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_11 + var_128_4
					end
				end

				arg_125_1.text_.text = var_128_8
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323621", "323621031", "story_v_out_323621.awb") ~= 0 then
					local var_128_12 = manager.audio:GetVoiceLength("story_v_out_323621", "323621031", "story_v_out_323621.awb") / 1000

					if var_128_12 + var_128_4 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_12 + var_128_4
					end

					if var_128_7.prefab_name ~= "" and arg_125_1.actors_[var_128_7.prefab_name] ~= nil then
						local var_128_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_7.prefab_name].transform, "story_v_out_323621", "323621031", "story_v_out_323621.awb")

						arg_125_1:RecordAudio("323621031", var_128_13)
						arg_125_1:RecordAudio("323621031", var_128_13)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_323621", "323621031", "story_v_out_323621.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_323621", "323621031", "story_v_out_323621.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_14 = math.max(var_128_5, arg_125_1.talkMaxDuration)

			if var_128_4 <= arg_125_1.time_ and arg_125_1.time_ < var_128_4 + var_128_14 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_4) / var_128_14

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_4 + var_128_14 and arg_125_1.time_ < var_128_4 + var_128_14 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play323621032 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 323621032
		arg_129_1.duration_ = 5

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play323621033(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = arg_129_1.actors_["10170ui_story"]
			local var_132_1 = 0

			if var_132_1 < arg_129_1.time_ and arg_129_1.time_ <= var_132_1 + arg_132_0 and not isNil(var_132_0) and arg_129_1.var_.characterEffect10170ui_story == nil then
				arg_129_1.var_.characterEffect10170ui_story = var_132_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_2 = 0.200000002980232

			if var_132_1 <= arg_129_1.time_ and arg_129_1.time_ < var_132_1 + var_132_2 and not isNil(var_132_0) then
				local var_132_3 = (arg_129_1.time_ - var_132_1) / var_132_2

				if arg_129_1.var_.characterEffect10170ui_story and not isNil(var_132_0) then
					local var_132_4 = Mathf.Lerp(0, 0.5, var_132_3)

					arg_129_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_129_1.var_.characterEffect10170ui_story.fillRatio = var_132_4
				end
			end

			if arg_129_1.time_ >= var_132_1 + var_132_2 and arg_129_1.time_ < var_132_1 + var_132_2 + arg_132_0 and not isNil(var_132_0) and arg_129_1.var_.characterEffect10170ui_story then
				local var_132_5 = 0.5

				arg_129_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_129_1.var_.characterEffect10170ui_story.fillRatio = var_132_5
			end

			local var_132_6 = 0
			local var_132_7 = 0.275

			if var_132_6 < arg_129_1.time_ and arg_129_1.time_ <= var_132_6 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				local var_132_8 = arg_129_1:FormatText(StoryNameCfg[7].name)

				arg_129_1.leftNameTxt_.text = var_132_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, true)
				arg_129_1.iconController_:SetSelectedState("hero")

				arg_129_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_129_1.callingController_:SetSelectedState("normal")

				arg_129_1.keyicon_.color = Color.New(1, 1, 1)
				arg_129_1.icon_.color = Color.New(1, 1, 1)

				local var_132_9 = arg_129_1:GetWordFromCfg(323621032)
				local var_132_10 = arg_129_1:FormatText(var_132_9.content)

				arg_129_1.text_.text = var_132_10

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_11 = 11
				local var_132_12 = utf8.len(var_132_10)
				local var_132_13 = var_132_11 <= 0 and var_132_7 or var_132_7 * (var_132_12 / var_132_11)

				if var_132_13 > 0 and var_132_7 < var_132_13 then
					arg_129_1.talkMaxDuration = var_132_13

					if var_132_13 + var_132_6 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_13 + var_132_6
					end
				end

				arg_129_1.text_.text = var_132_10
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)
				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_14 = math.max(var_132_7, arg_129_1.talkMaxDuration)

			if var_132_6 <= arg_129_1.time_ and arg_129_1.time_ < var_132_6 + var_132_14 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_6) / var_132_14

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_6 + var_132_14 and arg_129_1.time_ < var_132_6 + var_132_14 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play323621033 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 323621033
		arg_133_1.duration_ = 7.7

		local var_133_0 = {
			zh = 5.066,
			ja = 7.7
		}
		local var_133_1 = manager.audio:GetLocalizationFlag()

		if var_133_0[var_133_1] ~= nil then
			arg_133_1.duration_ = var_133_0[var_133_1]
		end

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play323621034(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = arg_133_1.actors_["10170ui_story"]
			local var_136_1 = 0

			if var_136_1 < arg_133_1.time_ and arg_133_1.time_ <= var_136_1 + arg_136_0 and not isNil(var_136_0) and arg_133_1.var_.characterEffect10170ui_story == nil then
				arg_133_1.var_.characterEffect10170ui_story = var_136_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_2 = 0.200000002980232

			if var_136_1 <= arg_133_1.time_ and arg_133_1.time_ < var_136_1 + var_136_2 and not isNil(var_136_0) then
				local var_136_3 = (arg_133_1.time_ - var_136_1) / var_136_2

				if arg_133_1.var_.characterEffect10170ui_story and not isNil(var_136_0) then
					arg_133_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_133_1.time_ >= var_136_1 + var_136_2 and arg_133_1.time_ < var_136_1 + var_136_2 + arg_136_0 and not isNil(var_136_0) and arg_133_1.var_.characterEffect10170ui_story then
				arg_133_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			local var_136_4 = 0

			if var_136_4 < arg_133_1.time_ and arg_133_1.time_ <= var_136_4 + arg_136_0 then
				arg_133_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_136_5 = 0

			if var_136_5 < arg_133_1.time_ and arg_133_1.time_ <= var_136_5 + arg_136_0 then
				arg_133_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/story10170/story10170actionlink/10170action4215")
			end

			local var_136_6 = 0
			local var_136_7 = 0.625

			if var_136_6 < arg_133_1.time_ and arg_133_1.time_ <= var_136_6 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				local var_136_8 = arg_133_1:FormatText(StoryNameCfg[1450].name)

				arg_133_1.leftNameTxt_.text = var_136_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_9 = arg_133_1:GetWordFromCfg(323621033)
				local var_136_10 = arg_133_1:FormatText(var_136_9.content)

				arg_133_1.text_.text = var_136_10

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_11 = 25
				local var_136_12 = utf8.len(var_136_10)
				local var_136_13 = var_136_11 <= 0 and var_136_7 or var_136_7 * (var_136_12 / var_136_11)

				if var_136_13 > 0 and var_136_7 < var_136_13 then
					arg_133_1.talkMaxDuration = var_136_13

					if var_136_13 + var_136_6 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_13 + var_136_6
					end
				end

				arg_133_1.text_.text = var_136_10
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323621", "323621033", "story_v_out_323621.awb") ~= 0 then
					local var_136_14 = manager.audio:GetVoiceLength("story_v_out_323621", "323621033", "story_v_out_323621.awb") / 1000

					if var_136_14 + var_136_6 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_14 + var_136_6
					end

					if var_136_9.prefab_name ~= "" and arg_133_1.actors_[var_136_9.prefab_name] ~= nil then
						local var_136_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_9.prefab_name].transform, "story_v_out_323621", "323621033", "story_v_out_323621.awb")

						arg_133_1:RecordAudio("323621033", var_136_15)
						arg_133_1:RecordAudio("323621033", var_136_15)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_323621", "323621033", "story_v_out_323621.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_323621", "323621033", "story_v_out_323621.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_16 = math.max(var_136_7, arg_133_1.talkMaxDuration)

			if var_136_6 <= arg_133_1.time_ and arg_133_1.time_ < var_136_6 + var_136_16 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_6) / var_136_16

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_6 + var_136_16 and arg_133_1.time_ < var_136_6 + var_136_16 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play323621034 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 323621034
		arg_137_1.duration_ = 6

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play323621035(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = arg_137_1.actors_["10170ui_story"].transform
			local var_140_1 = 0

			if var_140_1 < arg_137_1.time_ and arg_137_1.time_ <= var_140_1 + arg_140_0 then
				arg_137_1.var_.moveOldPos10170ui_story = var_140_0.localPosition

				local var_140_2 = GameObjectTools.GetOrAddComponent(var_140_0.gameObject, typeof(DynamicBoneHelper))

				if var_140_2 then
					var_140_2:EnableDynamicBone(false)
				end
			end

			local var_140_3 = 0.001

			if var_140_1 <= arg_137_1.time_ and arg_137_1.time_ < var_140_1 + var_140_3 then
				local var_140_4 = (arg_137_1.time_ - var_140_1) / var_140_3
				local var_140_5 = Vector3.New(0, 100, 0)

				var_140_0.localPosition = Vector3.Lerp(arg_137_1.var_.moveOldPos10170ui_story, var_140_5, var_140_4)

				local var_140_6 = manager.ui.mainCamera.transform.position - var_140_0.position

				var_140_0.forward = Vector3.New(var_140_6.x, var_140_6.y, var_140_6.z)

				local var_140_7 = var_140_0.localEulerAngles

				var_140_7.z = 0
				var_140_7.x = 0
				var_140_0.localEulerAngles = var_140_7
			end

			if arg_137_1.time_ >= var_140_1 + var_140_3 and arg_137_1.time_ < var_140_1 + var_140_3 + arg_140_0 then
				var_140_0.localPosition = Vector3.New(0, 100, 0)

				local var_140_8 = manager.ui.mainCamera.transform.position - var_140_0.position

				var_140_0.forward = Vector3.New(var_140_8.x, var_140_8.y, var_140_8.z)

				local var_140_9 = var_140_0.localEulerAngles

				var_140_9.z = 0
				var_140_9.x = 0
				var_140_0.localEulerAngles = var_140_9

				local var_140_10 = GameObjectTools.GetOrAddComponent(var_140_0.gameObject, typeof(DynamicBoneHelper))

				if var_140_10 then
					var_140_10:EnableDynamicBone(true)
				end
			end

			local var_140_11 = arg_137_1.actors_["10170ui_story"]
			local var_140_12 = 0

			if var_140_12 < arg_137_1.time_ and arg_137_1.time_ <= var_140_12 + arg_140_0 and not isNil(var_140_11) and arg_137_1.var_.characterEffect10170ui_story == nil then
				arg_137_1.var_.characterEffect10170ui_story = var_140_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_13 = 0.200000002980232

			if var_140_12 <= arg_137_1.time_ and arg_137_1.time_ < var_140_12 + var_140_13 and not isNil(var_140_11) then
				local var_140_14 = (arg_137_1.time_ - var_140_12) / var_140_13

				if arg_137_1.var_.characterEffect10170ui_story and not isNil(var_140_11) then
					local var_140_15 = Mathf.Lerp(0, 0.5, var_140_14)

					arg_137_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_137_1.var_.characterEffect10170ui_story.fillRatio = var_140_15
				end
			end

			if arg_137_1.time_ >= var_140_12 + var_140_13 and arg_137_1.time_ < var_140_12 + var_140_13 + arg_140_0 and not isNil(var_140_11) and arg_137_1.var_.characterEffect10170ui_story then
				local var_140_16 = 0.5

				arg_137_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_137_1.var_.characterEffect10170ui_story.fillRatio = var_140_16
			end

			local var_140_17 = manager.ui.mainCamera.transform
			local var_140_18 = 0

			if var_140_18 < arg_137_1.time_ and arg_137_1.time_ <= var_140_18 + arg_140_0 then
				local var_140_19 = arg_137_1.var_.effect5645
				local var_140_20
				local var_140_21 = var_140_17

				if not var_140_19 then
					var_140_19 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_liefeng_keep"), var_140_21)
					var_140_19.name = "5645"
					arg_137_1.var_.effect5645 = var_140_19
				else
					var_140_19.transform:SetParent(var_140_21)
				end

				var_140_19.transform.localPosition = Vector3.New(0, 0, 0)
				var_140_19.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_140_22 = 1.7777777777777777
				local var_140_23 = Screen.width / Screen.height
				local var_140_24 = var_140_23 / var_140_22
				local var_140_25 = Mathf.Max(var_140_22 / var_140_23, 1)
				local var_140_26 = Mathf.Max(var_140_24, var_140_25)

				var_140_19.transform.localScale = Vector3.New(var_140_19.transform.localScale.x * var_140_26, var_140_19.transform.localScale.y * var_140_26, var_140_19.transform.localScale.z * var_140_26)
			end

			local var_140_27 = 0

			if var_140_27 < arg_137_1.time_ and arg_137_1.time_ <= var_140_27 + arg_140_0 then
				arg_137_1.allBtn_.enabled = false
			end

			local var_140_28 = 2

			if arg_137_1.time_ >= var_140_27 + var_140_28 and arg_137_1.time_ < var_140_27 + var_140_28 + arg_140_0 then
				arg_137_1.allBtn_.enabled = true
			end

			local var_140_29 = 0
			local var_140_30 = 1

			if var_140_29 < arg_137_1.time_ and arg_137_1.time_ <= var_140_29 + arg_140_0 then
				local var_140_31 = "play"
				local var_140_32 = "effect"

				arg_137_1:AudioAction(var_140_31, var_140_32, "se_story_6", "se_story_6_draw_sword", "")
			end

			if arg_137_1.frameCnt_ <= 1 then
				arg_137_1.dialog_:SetActive(false)
			end

			local var_140_33 = 1
			local var_140_34 = 1.1

			if var_140_33 < arg_137_1.time_ and arg_137_1.time_ <= var_140_33 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0

				arg_137_1.dialog_:SetActive(true)

				arg_137_1.dialogCg_.alpha = 0

				local var_140_35 = LeanTween.value(arg_137_1.dialog_, 0, 1, 0.3)

				var_140_35:setOnUpdate(LuaHelper.FloatAction(function(arg_141_0)
					arg_137_1.dialogCg_.alpha = arg_141_0
				end))
				var_140_35:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_137_1.dialog_)
					var_140_35:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_137_1.duration_ = arg_137_1.duration_ + 0.3

				SetActive(arg_137_1.leftNameGo_, false)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_36 = arg_137_1:GetWordFromCfg(323621034)
				local var_140_37 = arg_137_1:FormatText(var_140_36.content)

				arg_137_1.text_.text = var_140_37

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_38 = 44
				local var_140_39 = utf8.len(var_140_37)
				local var_140_40 = var_140_38 <= 0 and var_140_34 or var_140_34 * (var_140_39 / var_140_38)

				if var_140_40 > 0 and var_140_34 < var_140_40 then
					arg_137_1.talkMaxDuration = var_140_40
					var_140_33 = var_140_33 + 0.3

					if var_140_40 + var_140_33 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_40 + var_140_33
					end
				end

				arg_137_1.text_.text = var_140_37
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)
				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_41 = var_140_33 + 0.3
			local var_140_42 = math.max(var_140_34, arg_137_1.talkMaxDuration)

			if var_140_41 <= arg_137_1.time_ and arg_137_1.time_ < var_140_41 + var_140_42 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_41) / var_140_42

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_41 + var_140_42 and arg_137_1.time_ < var_140_41 + var_140_42 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {
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

		arg_137_1:InitPlayNodeList()
	end,
	Play323621035 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 323621035
		arg_143_1.duration_ = 5

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play323621036(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = 0
			local var_146_1 = 1.25

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

				local var_146_2 = arg_143_1:GetWordFromCfg(323621035)
				local var_146_3 = arg_143_1:FormatText(var_146_2.content)

				arg_143_1.text_.text = var_146_3

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_4 = 50
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
	Play323621036 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 323621036
		arg_147_1.duration_ = 1.33

		local var_147_0 = {
			zh = 1.1,
			ja = 1.333
		}
		local var_147_1 = manager.audio:GetLocalizationFlag()

		if var_147_0[var_147_1] ~= nil then
			arg_147_1.duration_ = var_147_0[var_147_1]
		end

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play323621037(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_0 = arg_147_1.actors_["10170ui_story"].transform
			local var_150_1 = 0

			if var_150_1 < arg_147_1.time_ and arg_147_1.time_ <= var_150_1 + arg_150_0 then
				arg_147_1.var_.moveOldPos10170ui_story = var_150_0.localPosition

				local var_150_2 = GameObjectTools.GetOrAddComponent(var_150_0.gameObject, typeof(DynamicBoneHelper))

				if var_150_2 then
					var_150_2:EnableDynamicBone(false)
				end
			end

			local var_150_3 = 0.001

			if var_150_1 <= arg_147_1.time_ and arg_147_1.time_ < var_150_1 + var_150_3 then
				local var_150_4 = (arg_147_1.time_ - var_150_1) / var_150_3
				local var_150_5 = Vector3.New(0, 100, 0)

				var_150_0.localPosition = Vector3.Lerp(arg_147_1.var_.moveOldPos10170ui_story, var_150_5, var_150_4)

				local var_150_6 = manager.ui.mainCamera.transform.position - var_150_0.position

				var_150_0.forward = Vector3.New(var_150_6.x, var_150_6.y, var_150_6.z)

				local var_150_7 = var_150_0.localEulerAngles

				var_150_7.z = 0
				var_150_7.x = 0
				var_150_0.localEulerAngles = var_150_7
			end

			if arg_147_1.time_ >= var_150_1 + var_150_3 and arg_147_1.time_ < var_150_1 + var_150_3 + arg_150_0 then
				var_150_0.localPosition = Vector3.New(0, 100, 0)

				local var_150_8 = manager.ui.mainCamera.transform.position - var_150_0.position

				var_150_0.forward = Vector3.New(var_150_8.x, var_150_8.y, var_150_8.z)

				local var_150_9 = var_150_0.localEulerAngles

				var_150_9.z = 0
				var_150_9.x = 0
				var_150_0.localEulerAngles = var_150_9

				local var_150_10 = GameObjectTools.GetOrAddComponent(var_150_0.gameObject, typeof(DynamicBoneHelper))

				if var_150_10 then
					var_150_10:EnableDynamicBone(true)
				end
			end

			local var_150_11 = arg_147_1.actors_["10170ui_story"]
			local var_150_12 = 0

			if var_150_12 < arg_147_1.time_ and arg_147_1.time_ <= var_150_12 + arg_150_0 and not isNil(var_150_11) and arg_147_1.var_.characterEffect10170ui_story == nil then
				arg_147_1.var_.characterEffect10170ui_story = var_150_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_150_13 = 0.200000002980232

			if var_150_12 <= arg_147_1.time_ and arg_147_1.time_ < var_150_12 + var_150_13 and not isNil(var_150_11) then
				local var_150_14 = (arg_147_1.time_ - var_150_12) / var_150_13

				if arg_147_1.var_.characterEffect10170ui_story and not isNil(var_150_11) then
					arg_147_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_147_1.time_ >= var_150_12 + var_150_13 and arg_147_1.time_ < var_150_12 + var_150_13 + arg_150_0 and not isNil(var_150_11) and arg_147_1.var_.characterEffect10170ui_story then
				arg_147_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			local var_150_15 = 0
			local var_150_16 = 0.1

			if var_150_15 < arg_147_1.time_ and arg_147_1.time_ <= var_150_15 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				local var_150_17 = arg_147_1:FormatText(StoryNameCfg[1450].name)

				arg_147_1.leftNameTxt_.text = var_150_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, true)
				arg_147_1.iconController_:SetSelectedState("hero")

				arg_147_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10170")

				arg_147_1.callingController_:SetSelectedState("normal")

				arg_147_1.keyicon_.color = Color.New(1, 1, 1)
				arg_147_1.icon_.color = Color.New(1, 1, 1)

				local var_150_18 = arg_147_1:GetWordFromCfg(323621036)
				local var_150_19 = arg_147_1:FormatText(var_150_18.content)

				arg_147_1.text_.text = var_150_19

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_20 = 4
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

				if manager.audio:GetVoiceLength("story_v_out_323621", "323621036", "story_v_out_323621.awb") ~= 0 then
					local var_150_23 = manager.audio:GetVoiceLength("story_v_out_323621", "323621036", "story_v_out_323621.awb") / 1000

					if var_150_23 + var_150_15 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_23 + var_150_15
					end

					if var_150_18.prefab_name ~= "" and arg_147_1.actors_[var_150_18.prefab_name] ~= nil then
						local var_150_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_18.prefab_name].transform, "story_v_out_323621", "323621036", "story_v_out_323621.awb")

						arg_147_1:RecordAudio("323621036", var_150_24)
						arg_147_1:RecordAudio("323621036", var_150_24)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_323621", "323621036", "story_v_out_323621.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_323621", "323621036", "story_v_out_323621.awb")
				end

				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_25 = math.max(var_150_16, arg_147_1.talkMaxDuration)

			if var_150_15 <= arg_147_1.time_ and arg_147_1.time_ < var_150_15 + var_150_25 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_15) / var_150_25

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_15 + var_150_25 and arg_147_1.time_ < var_150_15 + var_150_25 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {
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

		arg_147_1:InitPlayNodeList()
	end,
	Play323621037 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 323621037
		arg_151_1.duration_ = 5

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play323621038(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = arg_151_1.actors_["10170ui_story"]
			local var_154_1 = 0

			if var_154_1 < arg_151_1.time_ and arg_151_1.time_ <= var_154_1 + arg_154_0 and not isNil(var_154_0) and arg_151_1.var_.characterEffect10170ui_story == nil then
				arg_151_1.var_.characterEffect10170ui_story = var_154_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_2 = 0.200000002980232

			if var_154_1 <= arg_151_1.time_ and arg_151_1.time_ < var_154_1 + var_154_2 and not isNil(var_154_0) then
				local var_154_3 = (arg_151_1.time_ - var_154_1) / var_154_2

				if arg_151_1.var_.characterEffect10170ui_story and not isNil(var_154_0) then
					local var_154_4 = Mathf.Lerp(0, 0.5, var_154_3)

					arg_151_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_151_1.var_.characterEffect10170ui_story.fillRatio = var_154_4
				end
			end

			if arg_151_1.time_ >= var_154_1 + var_154_2 and arg_151_1.time_ < var_154_1 + var_154_2 + arg_154_0 and not isNil(var_154_0) and arg_151_1.var_.characterEffect10170ui_story then
				local var_154_5 = 0.5

				arg_151_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_151_1.var_.characterEffect10170ui_story.fillRatio = var_154_5
			end

			local var_154_6 = 0
			local var_154_7 = 0.225

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

				arg_151_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_151_1.callingController_:SetSelectedState("normal")

				arg_151_1.keyicon_.color = Color.New(1, 1, 1)
				arg_151_1.icon_.color = Color.New(1, 1, 1)

				local var_154_9 = arg_151_1:GetWordFromCfg(323621037)
				local var_154_10 = arg_151_1:FormatText(var_154_9.content)

				arg_151_1.text_.text = var_154_10

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_11 = 9
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
	Play323621038 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 323621038
		arg_155_1.duration_ = 1.23

		local var_155_0 = {
			zh = 1.1,
			ja = 1.233
		}
		local var_155_1 = manager.audio:GetLocalizationFlag()

		if var_155_0[var_155_1] ~= nil then
			arg_155_1.duration_ = var_155_0[var_155_1]
		end

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play323621039(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = arg_155_1.actors_["10170ui_story"]
			local var_158_1 = 0

			if var_158_1 < arg_155_1.time_ and arg_155_1.time_ <= var_158_1 + arg_158_0 and not isNil(var_158_0) and arg_155_1.var_.characterEffect10170ui_story == nil then
				arg_155_1.var_.characterEffect10170ui_story = var_158_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_158_2 = 0.200000002980232

			if var_158_1 <= arg_155_1.time_ and arg_155_1.time_ < var_158_1 + var_158_2 and not isNil(var_158_0) then
				local var_158_3 = (arg_155_1.time_ - var_158_1) / var_158_2

				if arg_155_1.var_.characterEffect10170ui_story and not isNil(var_158_0) then
					arg_155_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_155_1.time_ >= var_158_1 + var_158_2 and arg_155_1.time_ < var_158_1 + var_158_2 + arg_158_0 and not isNil(var_158_0) and arg_155_1.var_.characterEffect10170ui_story then
				arg_155_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			local var_158_4 = 0
			local var_158_5 = 0.1

			if var_158_4 < arg_155_1.time_ and arg_155_1.time_ <= var_158_4 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				local var_158_6 = arg_155_1:FormatText(StoryNameCfg[1450].name)

				arg_155_1.leftNameTxt_.text = var_158_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, true)
				arg_155_1.iconController_:SetSelectedState("hero")

				arg_155_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10170")

				arg_155_1.callingController_:SetSelectedState("normal")

				arg_155_1.keyicon_.color = Color.New(1, 1, 1)
				arg_155_1.icon_.color = Color.New(1, 1, 1)

				local var_158_7 = arg_155_1:GetWordFromCfg(323621038)
				local var_158_8 = arg_155_1:FormatText(var_158_7.content)

				arg_155_1.text_.text = var_158_8

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_9 = 4
				local var_158_10 = utf8.len(var_158_8)
				local var_158_11 = var_158_9 <= 0 and var_158_5 or var_158_5 * (var_158_10 / var_158_9)

				if var_158_11 > 0 and var_158_5 < var_158_11 then
					arg_155_1.talkMaxDuration = var_158_11

					if var_158_11 + var_158_4 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_11 + var_158_4
					end
				end

				arg_155_1.text_.text = var_158_8
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323621", "323621038", "story_v_out_323621.awb") ~= 0 then
					local var_158_12 = manager.audio:GetVoiceLength("story_v_out_323621", "323621038", "story_v_out_323621.awb") / 1000

					if var_158_12 + var_158_4 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_12 + var_158_4
					end

					if var_158_7.prefab_name ~= "" and arg_155_1.actors_[var_158_7.prefab_name] ~= nil then
						local var_158_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_7.prefab_name].transform, "story_v_out_323621", "323621038", "story_v_out_323621.awb")

						arg_155_1:RecordAudio("323621038", var_158_13)
						arg_155_1:RecordAudio("323621038", var_158_13)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_323621", "323621038", "story_v_out_323621.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_323621", "323621038", "story_v_out_323621.awb")
				end

				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_14 = math.max(var_158_5, arg_155_1.talkMaxDuration)

			if var_158_4 <= arg_155_1.time_ and arg_155_1.time_ < var_158_4 + var_158_14 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_4) / var_158_14

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_4 + var_158_14 and arg_155_1.time_ < var_158_4 + var_158_14 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {}

		arg_155_1:InitPlayNodeList()
	end,
	Play323621039 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 323621039
		arg_159_1.duration_ = 5

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play323621040(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_0 = arg_159_1.actors_["10170ui_story"]
			local var_162_1 = 0

			if var_162_1 < arg_159_1.time_ and arg_159_1.time_ <= var_162_1 + arg_162_0 and not isNil(var_162_0) and arg_159_1.var_.characterEffect10170ui_story == nil then
				arg_159_1.var_.characterEffect10170ui_story = var_162_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_162_2 = 0.200000002980232

			if var_162_1 <= arg_159_1.time_ and arg_159_1.time_ < var_162_1 + var_162_2 and not isNil(var_162_0) then
				local var_162_3 = (arg_159_1.time_ - var_162_1) / var_162_2

				if arg_159_1.var_.characterEffect10170ui_story and not isNil(var_162_0) then
					local var_162_4 = Mathf.Lerp(0, 0.5, var_162_3)

					arg_159_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_159_1.var_.characterEffect10170ui_story.fillRatio = var_162_4
				end
			end

			if arg_159_1.time_ >= var_162_1 + var_162_2 and arg_159_1.time_ < var_162_1 + var_162_2 + arg_162_0 and not isNil(var_162_0) and arg_159_1.var_.characterEffect10170ui_story then
				local var_162_5 = 0.5

				arg_159_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_159_1.var_.characterEffect10170ui_story.fillRatio = var_162_5
			end

			local var_162_6 = 0
			local var_162_7 = 0.3

			if var_162_6 < arg_159_1.time_ and arg_159_1.time_ <= var_162_6 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				local var_162_8 = arg_159_1:FormatText(StoryNameCfg[7].name)

				arg_159_1.leftNameTxt_.text = var_162_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, true)
				arg_159_1.iconController_:SetSelectedState("hero")

				arg_159_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_159_1.callingController_:SetSelectedState("normal")

				arg_159_1.keyicon_.color = Color.New(1, 1, 1)
				arg_159_1.icon_.color = Color.New(1, 1, 1)

				local var_162_9 = arg_159_1:GetWordFromCfg(323621039)
				local var_162_10 = arg_159_1:FormatText(var_162_9.content)

				arg_159_1.text_.text = var_162_10

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_11 = 12
				local var_162_12 = utf8.len(var_162_10)
				local var_162_13 = var_162_11 <= 0 and var_162_7 or var_162_7 * (var_162_12 / var_162_11)

				if var_162_13 > 0 and var_162_7 < var_162_13 then
					arg_159_1.talkMaxDuration = var_162_13

					if var_162_13 + var_162_6 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_13 + var_162_6
					end
				end

				arg_159_1.text_.text = var_162_10
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)
				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_14 = math.max(var_162_7, arg_159_1.talkMaxDuration)

			if var_162_6 <= arg_159_1.time_ and arg_159_1.time_ < var_162_6 + var_162_14 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_6) / var_162_14

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_6 + var_162_14 and arg_159_1.time_ < var_162_6 + var_162_14 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {}

		arg_159_1:InitPlayNodeList()
	end,
	Play323621040 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 323621040
		arg_163_1.duration_ = 11.03

		local var_163_0 = {
			zh = 8.466,
			ja = 11.033
		}
		local var_163_1 = manager.audio:GetLocalizationFlag()

		if var_163_0[var_163_1] ~= nil then
			arg_163_1.duration_ = var_163_0[var_163_1]
		end

		SetActive(arg_163_1.tipsGo_, false)

		function arg_163_1.onSingleLineFinish_()
			arg_163_1.onSingleLineUpdate_ = nil
			arg_163_1.onSingleLineFinish_ = nil
			arg_163_1.state_ = "waiting"
		end

		function arg_163_1.playNext_(arg_165_0)
			if arg_165_0 == 1 then
				arg_163_0:Play323621041(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			local var_166_0 = arg_163_1.actors_["10170ui_story"]
			local var_166_1 = 0

			if var_166_1 < arg_163_1.time_ and arg_163_1.time_ <= var_166_1 + arg_166_0 and not isNil(var_166_0) and arg_163_1.var_.characterEffect10170ui_story == nil then
				arg_163_1.var_.characterEffect10170ui_story = var_166_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_166_2 = 0.200000002980232

			if var_166_1 <= arg_163_1.time_ and arg_163_1.time_ < var_166_1 + var_166_2 and not isNil(var_166_0) then
				local var_166_3 = (arg_163_1.time_ - var_166_1) / var_166_2

				if arg_163_1.var_.characterEffect10170ui_story and not isNil(var_166_0) then
					arg_163_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_163_1.time_ >= var_166_1 + var_166_2 and arg_163_1.time_ < var_166_1 + var_166_2 + arg_166_0 and not isNil(var_166_0) and arg_163_1.var_.characterEffect10170ui_story then
				arg_163_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			local var_166_4 = 0

			if var_166_4 < arg_163_1.time_ and arg_163_1.time_ <= var_166_4 + arg_166_0 then
				arg_163_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/story10170/story10170action/10170action1_1")
			end

			local var_166_5 = 0
			local var_166_6 = 0.85

			if var_166_5 < arg_163_1.time_ and arg_163_1.time_ <= var_166_5 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				local var_166_7 = arg_163_1:FormatText(StoryNameCfg[1450].name)

				arg_163_1.leftNameTxt_.text = var_166_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, true)
				arg_163_1.iconController_:SetSelectedState("hero")

				arg_163_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10170")

				arg_163_1.callingController_:SetSelectedState("normal")

				arg_163_1.keyicon_.color = Color.New(1, 1, 1)
				arg_163_1.icon_.color = Color.New(1, 1, 1)

				local var_166_8 = arg_163_1:GetWordFromCfg(323621040)
				local var_166_9 = arg_163_1:FormatText(var_166_8.content)

				arg_163_1.text_.text = var_166_9

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_10 = 34
				local var_166_11 = utf8.len(var_166_9)
				local var_166_12 = var_166_10 <= 0 and var_166_6 or var_166_6 * (var_166_11 / var_166_10)

				if var_166_12 > 0 and var_166_6 < var_166_12 then
					arg_163_1.talkMaxDuration = var_166_12

					if var_166_12 + var_166_5 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_12 + var_166_5
					end
				end

				arg_163_1.text_.text = var_166_9
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323621", "323621040", "story_v_out_323621.awb") ~= 0 then
					local var_166_13 = manager.audio:GetVoiceLength("story_v_out_323621", "323621040", "story_v_out_323621.awb") / 1000

					if var_166_13 + var_166_5 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_13 + var_166_5
					end

					if var_166_8.prefab_name ~= "" and arg_163_1.actors_[var_166_8.prefab_name] ~= nil then
						local var_166_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_8.prefab_name].transform, "story_v_out_323621", "323621040", "story_v_out_323621.awb")

						arg_163_1:RecordAudio("323621040", var_166_14)
						arg_163_1:RecordAudio("323621040", var_166_14)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_out_323621", "323621040", "story_v_out_323621.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_out_323621", "323621040", "story_v_out_323621.awb")
				end

				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_15 = math.max(var_166_6, arg_163_1.talkMaxDuration)

			if var_166_5 <= arg_163_1.time_ and arg_163_1.time_ < var_166_5 + var_166_15 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_5) / var_166_15

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_5 + var_166_15 and arg_163_1.time_ < var_166_5 + var_166_15 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {}

		arg_163_1:InitPlayNodeList()
	end,
	Play323621041 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 323621041
		arg_167_1.duration_ = 5

		SetActive(arg_167_1.tipsGo_, false)

		function arg_167_1.onSingleLineFinish_()
			arg_167_1.onSingleLineUpdate_ = nil
			arg_167_1.onSingleLineFinish_ = nil
			arg_167_1.state_ = "waiting"
		end

		function arg_167_1.playNext_(arg_169_0)
			if arg_169_0 == 1 then
				arg_167_0:Play323621042(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = arg_167_1.actors_["10170ui_story"]
			local var_170_1 = 0

			if var_170_1 < arg_167_1.time_ and arg_167_1.time_ <= var_170_1 + arg_170_0 and not isNil(var_170_0) and arg_167_1.var_.characterEffect10170ui_story == nil then
				arg_167_1.var_.characterEffect10170ui_story = var_170_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_170_2 = 0.200000002980232

			if var_170_1 <= arg_167_1.time_ and arg_167_1.time_ < var_170_1 + var_170_2 and not isNil(var_170_0) then
				local var_170_3 = (arg_167_1.time_ - var_170_1) / var_170_2

				if arg_167_1.var_.characterEffect10170ui_story and not isNil(var_170_0) then
					local var_170_4 = Mathf.Lerp(0, 0.5, var_170_3)

					arg_167_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_167_1.var_.characterEffect10170ui_story.fillRatio = var_170_4
				end
			end

			if arg_167_1.time_ >= var_170_1 + var_170_2 and arg_167_1.time_ < var_170_1 + var_170_2 + arg_170_0 and not isNil(var_170_0) and arg_167_1.var_.characterEffect10170ui_story then
				local var_170_5 = 0.5

				arg_167_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_167_1.var_.characterEffect10170ui_story.fillRatio = var_170_5
			end

			local var_170_6 = 0
			local var_170_7 = 0.35

			if var_170_6 < arg_167_1.time_ and arg_167_1.time_ <= var_170_6 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				local var_170_8 = arg_167_1:FormatText(StoryNameCfg[7].name)

				arg_167_1.leftNameTxt_.text = var_170_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, true)
				arg_167_1.iconController_:SetSelectedState("hero")

				arg_167_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_167_1.callingController_:SetSelectedState("normal")

				arg_167_1.keyicon_.color = Color.New(1, 1, 1)
				arg_167_1.icon_.color = Color.New(1, 1, 1)

				local var_170_9 = arg_167_1:GetWordFromCfg(323621041)
				local var_170_10 = arg_167_1:FormatText(var_170_9.content)

				arg_167_1.text_.text = var_170_10

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_11 = 14
				local var_170_12 = utf8.len(var_170_10)
				local var_170_13 = var_170_11 <= 0 and var_170_7 or var_170_7 * (var_170_12 / var_170_11)

				if var_170_13 > 0 and var_170_7 < var_170_13 then
					arg_167_1.talkMaxDuration = var_170_13

					if var_170_13 + var_170_6 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_13 + var_170_6
					end
				end

				arg_167_1.text_.text = var_170_10
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)
				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_14 = math.max(var_170_7, arg_167_1.talkMaxDuration)

			if var_170_6 <= arg_167_1.time_ and arg_167_1.time_ < var_170_6 + var_170_14 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_6) / var_170_14

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_6 + var_170_14 and arg_167_1.time_ < var_170_6 + var_170_14 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {}

		arg_167_1:InitPlayNodeList()
	end,
	Play323621042 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 323621042
		arg_171_1.duration_ = 4.87

		local var_171_0 = {
			zh = 4.866,
			ja = 3.5
		}
		local var_171_1 = manager.audio:GetLocalizationFlag()

		if var_171_0[var_171_1] ~= nil then
			arg_171_1.duration_ = var_171_0[var_171_1]
		end

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play323621043(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = arg_171_1.actors_["10170ui_story"]
			local var_174_1 = 0

			if var_174_1 < arg_171_1.time_ and arg_171_1.time_ <= var_174_1 + arg_174_0 and not isNil(var_174_0) and arg_171_1.var_.characterEffect10170ui_story == nil then
				arg_171_1.var_.characterEffect10170ui_story = var_174_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_174_2 = 0.200000002980232

			if var_174_1 <= arg_171_1.time_ and arg_171_1.time_ < var_174_1 + var_174_2 and not isNil(var_174_0) then
				local var_174_3 = (arg_171_1.time_ - var_174_1) / var_174_2

				if arg_171_1.var_.characterEffect10170ui_story and not isNil(var_174_0) then
					arg_171_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_171_1.time_ >= var_174_1 + var_174_2 and arg_171_1.time_ < var_174_1 + var_174_2 + arg_174_0 and not isNil(var_174_0) and arg_171_1.var_.characterEffect10170ui_story then
				arg_171_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			local var_174_4 = 0
			local var_174_5 = 0.375

			if var_174_4 < arg_171_1.time_ and arg_171_1.time_ <= var_174_4 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				local var_174_6 = arg_171_1:FormatText(StoryNameCfg[1450].name)

				arg_171_1.leftNameTxt_.text = var_174_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, true)
				arg_171_1.iconController_:SetSelectedState("hero")

				arg_171_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10170")

				arg_171_1.callingController_:SetSelectedState("normal")

				arg_171_1.keyicon_.color = Color.New(1, 1, 1)
				arg_171_1.icon_.color = Color.New(1, 1, 1)

				local var_174_7 = arg_171_1:GetWordFromCfg(323621042)
				local var_174_8 = arg_171_1:FormatText(var_174_7.content)

				arg_171_1.text_.text = var_174_8

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_9 = 15
				local var_174_10 = utf8.len(var_174_8)
				local var_174_11 = var_174_9 <= 0 and var_174_5 or var_174_5 * (var_174_10 / var_174_9)

				if var_174_11 > 0 and var_174_5 < var_174_11 then
					arg_171_1.talkMaxDuration = var_174_11

					if var_174_11 + var_174_4 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_11 + var_174_4
					end
				end

				arg_171_1.text_.text = var_174_8
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323621", "323621042", "story_v_out_323621.awb") ~= 0 then
					local var_174_12 = manager.audio:GetVoiceLength("story_v_out_323621", "323621042", "story_v_out_323621.awb") / 1000

					if var_174_12 + var_174_4 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_12 + var_174_4
					end

					if var_174_7.prefab_name ~= "" and arg_171_1.actors_[var_174_7.prefab_name] ~= nil then
						local var_174_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_7.prefab_name].transform, "story_v_out_323621", "323621042", "story_v_out_323621.awb")

						arg_171_1:RecordAudio("323621042", var_174_13)
						arg_171_1:RecordAudio("323621042", var_174_13)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_out_323621", "323621042", "story_v_out_323621.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_out_323621", "323621042", "story_v_out_323621.awb")
				end

				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_14 = math.max(var_174_5, arg_171_1.talkMaxDuration)

			if var_174_4 <= arg_171_1.time_ and arg_171_1.time_ < var_174_4 + var_174_14 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_4) / var_174_14

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_4 + var_174_14 and arg_171_1.time_ < var_174_4 + var_174_14 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {}

		arg_171_1:InitPlayNodeList()
	end,
	Play323621043 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 323621043
		arg_175_1.duration_ = 5

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play323621044(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = arg_175_1.actors_["10170ui_story"]
			local var_178_1 = 0

			if var_178_1 < arg_175_1.time_ and arg_175_1.time_ <= var_178_1 + arg_178_0 and not isNil(var_178_0) and arg_175_1.var_.characterEffect10170ui_story == nil then
				arg_175_1.var_.characterEffect10170ui_story = var_178_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_178_2 = 0.200000002980232

			if var_178_1 <= arg_175_1.time_ and arg_175_1.time_ < var_178_1 + var_178_2 and not isNil(var_178_0) then
				local var_178_3 = (arg_175_1.time_ - var_178_1) / var_178_2

				if arg_175_1.var_.characterEffect10170ui_story and not isNil(var_178_0) then
					local var_178_4 = Mathf.Lerp(0, 0.5, var_178_3)

					arg_175_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_175_1.var_.characterEffect10170ui_story.fillRatio = var_178_4
				end
			end

			if arg_175_1.time_ >= var_178_1 + var_178_2 and arg_175_1.time_ < var_178_1 + var_178_2 + arg_178_0 and not isNil(var_178_0) and arg_175_1.var_.characterEffect10170ui_story then
				local var_178_5 = 0.5

				arg_175_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_175_1.var_.characterEffect10170ui_story.fillRatio = var_178_5
			end

			local var_178_6 = 0
			local var_178_7 = 0.3

			if var_178_6 < arg_175_1.time_ and arg_175_1.time_ <= var_178_6 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				local var_178_8 = arg_175_1:FormatText(StoryNameCfg[7].name)

				arg_175_1.leftNameTxt_.text = var_178_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, true)
				arg_175_1.iconController_:SetSelectedState("hero")

				arg_175_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_175_1.callingController_:SetSelectedState("normal")

				arg_175_1.keyicon_.color = Color.New(1, 1, 1)
				arg_175_1.icon_.color = Color.New(1, 1, 1)

				local var_178_9 = arg_175_1:GetWordFromCfg(323621043)
				local var_178_10 = arg_175_1:FormatText(var_178_9.content)

				arg_175_1.text_.text = var_178_10

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_11 = 12
				local var_178_12 = utf8.len(var_178_10)
				local var_178_13 = var_178_11 <= 0 and var_178_7 or var_178_7 * (var_178_12 / var_178_11)

				if var_178_13 > 0 and var_178_7 < var_178_13 then
					arg_175_1.talkMaxDuration = var_178_13

					if var_178_13 + var_178_6 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_13 + var_178_6
					end
				end

				arg_175_1.text_.text = var_178_10
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)
				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_14 = math.max(var_178_7, arg_175_1.talkMaxDuration)

			if var_178_6 <= arg_175_1.time_ and arg_175_1.time_ < var_178_6 + var_178_14 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_6) / var_178_14

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_6 + var_178_14 and arg_175_1.time_ < var_178_6 + var_178_14 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {}

		arg_175_1:InitPlayNodeList()
	end,
	Play323621044 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 323621044
		arg_179_1.duration_ = 5

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play323621045(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = arg_179_1.actors_["10170ui_story"].transform
			local var_182_1 = 0

			if var_182_1 < arg_179_1.time_ and arg_179_1.time_ <= var_182_1 + arg_182_0 then
				arg_179_1.var_.moveOldPos10170ui_story = var_182_0.localPosition

				local var_182_2 = GameObjectTools.GetOrAddComponent(var_182_0.gameObject, typeof(DynamicBoneHelper))

				if var_182_2 then
					var_182_2:EnableDynamicBone(false)
				end
			end

			local var_182_3 = 0.001

			if var_182_1 <= arg_179_1.time_ and arg_179_1.time_ < var_182_1 + var_182_3 then
				local var_182_4 = (arg_179_1.time_ - var_182_1) / var_182_3
				local var_182_5 = Vector3.New(0, 100, 0)

				var_182_0.localPosition = Vector3.Lerp(arg_179_1.var_.moveOldPos10170ui_story, var_182_5, var_182_4)

				local var_182_6 = manager.ui.mainCamera.transform.position - var_182_0.position

				var_182_0.forward = Vector3.New(var_182_6.x, var_182_6.y, var_182_6.z)

				local var_182_7 = var_182_0.localEulerAngles

				var_182_7.z = 0
				var_182_7.x = 0
				var_182_0.localEulerAngles = var_182_7
			end

			if arg_179_1.time_ >= var_182_1 + var_182_3 and arg_179_1.time_ < var_182_1 + var_182_3 + arg_182_0 then
				var_182_0.localPosition = Vector3.New(0, 100, 0)

				local var_182_8 = manager.ui.mainCamera.transform.position - var_182_0.position

				var_182_0.forward = Vector3.New(var_182_8.x, var_182_8.y, var_182_8.z)

				local var_182_9 = var_182_0.localEulerAngles

				var_182_9.z = 0
				var_182_9.x = 0
				var_182_0.localEulerAngles = var_182_9

				local var_182_10 = GameObjectTools.GetOrAddComponent(var_182_0.gameObject, typeof(DynamicBoneHelper))

				if var_182_10 then
					var_182_10:EnableDynamicBone(true)
				end
			end

			local var_182_11 = 0
			local var_182_12 = 0.975

			if var_182_11 < arg_179_1.time_ and arg_179_1.time_ <= var_182_11 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, false)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_13 = arg_179_1:GetWordFromCfg(323621044)
				local var_182_14 = arg_179_1:FormatText(var_182_13.content)

				arg_179_1.text_.text = var_182_14

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_15 = 39
				local var_182_16 = utf8.len(var_182_14)
				local var_182_17 = var_182_15 <= 0 and var_182_12 or var_182_12 * (var_182_16 / var_182_15)

				if var_182_17 > 0 and var_182_12 < var_182_17 then
					arg_179_1.talkMaxDuration = var_182_17

					if var_182_17 + var_182_11 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_17 + var_182_11
					end
				end

				arg_179_1.text_.text = var_182_14
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)
				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_18 = math.max(var_182_12, arg_179_1.talkMaxDuration)

			if var_182_11 <= arg_179_1.time_ and arg_179_1.time_ < var_182_11 + var_182_18 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_11) / var_182_18

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_11 + var_182_18 and arg_179_1.time_ < var_182_11 + var_182_18 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {
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

		arg_179_1:InitPlayNodeList()
	end,
	Play323621045 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 323621045
		arg_183_1.duration_ = 5

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play323621046(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_0 = 0
			local var_186_1 = 0.35

			if var_186_0 < arg_183_1.time_ and arg_183_1.time_ <= var_186_0 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				local var_186_2 = arg_183_1:FormatText(StoryNameCfg[7].name)

				arg_183_1.leftNameTxt_.text = var_186_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, true)
				arg_183_1.iconController_:SetSelectedState("hero")

				arg_183_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_183_1.callingController_:SetSelectedState("normal")

				arg_183_1.keyicon_.color = Color.New(1, 1, 1)
				arg_183_1.icon_.color = Color.New(1, 1, 1)

				local var_186_3 = arg_183_1:GetWordFromCfg(323621045)
				local var_186_4 = arg_183_1:FormatText(var_186_3.content)

				arg_183_1.text_.text = var_186_4

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_5 = 14
				local var_186_6 = utf8.len(var_186_4)
				local var_186_7 = var_186_5 <= 0 and var_186_1 or var_186_1 * (var_186_6 / var_186_5)

				if var_186_7 > 0 and var_186_1 < var_186_7 then
					arg_183_1.talkMaxDuration = var_186_7

					if var_186_7 + var_186_0 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_7 + var_186_0
					end
				end

				arg_183_1.text_.text = var_186_4
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)
				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_8 = math.max(var_186_1, arg_183_1.talkMaxDuration)

			if var_186_0 <= arg_183_1.time_ and arg_183_1.time_ < var_186_0 + var_186_8 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_0) / var_186_8

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_0 + var_186_8 and arg_183_1.time_ < var_186_0 + var_186_8 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {}

		arg_183_1:InitPlayNodeList()
	end,
	Play323621046 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 323621046
		arg_187_1.duration_ = 5

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play323621047(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			local var_190_0 = 0
			local var_190_1 = 1.1

			if var_190_0 < arg_187_1.time_ and arg_187_1.time_ <= var_190_0 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, false)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_2 = arg_187_1:GetWordFromCfg(323621046)
				local var_190_3 = arg_187_1:FormatText(var_190_2.content)

				arg_187_1.text_.text = var_190_3

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_4 = 44
				local var_190_5 = utf8.len(var_190_3)
				local var_190_6 = var_190_4 <= 0 and var_190_1 or var_190_1 * (var_190_5 / var_190_4)

				if var_190_6 > 0 and var_190_1 < var_190_6 then
					arg_187_1.talkMaxDuration = var_190_6

					if var_190_6 + var_190_0 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_6 + var_190_0
					end
				end

				arg_187_1.text_.text = var_190_3
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)
				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_7 = math.max(var_190_1, arg_187_1.talkMaxDuration)

			if var_190_0 <= arg_187_1.time_ and arg_187_1.time_ < var_190_0 + var_190_7 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_0) / var_190_7

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_0 + var_190_7 and arg_187_1.time_ < var_190_0 + var_190_7 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {}

		arg_187_1:InitPlayNodeList()
	end,
	Play323621047 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 323621047
		arg_191_1.duration_ = 5

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play323621048(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			local var_194_0 = 0
			local var_194_1 = 0.175

			if var_194_0 < arg_191_1.time_ and arg_191_1.time_ <= var_194_0 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				local var_194_2 = arg_191_1:FormatText(StoryNameCfg[7].name)

				arg_191_1.leftNameTxt_.text = var_194_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, true)
				arg_191_1.iconController_:SetSelectedState("hero")

				arg_191_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_191_1.callingController_:SetSelectedState("normal")

				arg_191_1.keyicon_.color = Color.New(1, 1, 1)
				arg_191_1.icon_.color = Color.New(1, 1, 1)

				local var_194_3 = arg_191_1:GetWordFromCfg(323621047)
				local var_194_4 = arg_191_1:FormatText(var_194_3.content)

				arg_191_1.text_.text = var_194_4

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_5 = 7
				local var_194_6 = utf8.len(var_194_4)
				local var_194_7 = var_194_5 <= 0 and var_194_1 or var_194_1 * (var_194_6 / var_194_5)

				if var_194_7 > 0 and var_194_1 < var_194_7 then
					arg_191_1.talkMaxDuration = var_194_7

					if var_194_7 + var_194_0 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_7 + var_194_0
					end
				end

				arg_191_1.text_.text = var_194_4
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)
				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_8 = math.max(var_194_1, arg_191_1.talkMaxDuration)

			if var_194_0 <= arg_191_1.time_ and arg_191_1.time_ < var_194_0 + var_194_8 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_0) / var_194_8

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_0 + var_194_8 and arg_191_1.time_ < var_194_0 + var_194_8 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {}

		arg_191_1:InitPlayNodeList()
	end,
	Play323621048 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 323621048
		arg_195_1.duration_ = 1.83

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play323621049(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			local var_198_0 = 0
			local var_198_1 = 0.05

			if var_198_0 < arg_195_1.time_ and arg_195_1.time_ <= var_198_0 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				local var_198_2 = arg_195_1:FormatText(StoryNameCfg[1450].name)

				arg_195_1.leftNameTxt_.text = var_198_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, true)
				arg_195_1.iconController_:SetSelectedState("hero")

				arg_195_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10170")

				arg_195_1.callingController_:SetSelectedState("normal")

				arg_195_1.keyicon_.color = Color.New(1, 1, 1)
				arg_195_1.icon_.color = Color.New(1, 1, 1)

				local var_198_3 = arg_195_1:GetWordFromCfg(323621048)
				local var_198_4 = arg_195_1:FormatText(var_198_3.content)

				arg_195_1.text_.text = var_198_4

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_5 = 2
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

				if manager.audio:GetVoiceLength("story_v_out_323621", "323621048", "story_v_out_323621.awb") ~= 0 then
					local var_198_8 = manager.audio:GetVoiceLength("story_v_out_323621", "323621048", "story_v_out_323621.awb") / 1000

					if var_198_8 + var_198_0 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_8 + var_198_0
					end

					if var_198_3.prefab_name ~= "" and arg_195_1.actors_[var_198_3.prefab_name] ~= nil then
						local var_198_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_195_1.actors_[var_198_3.prefab_name].transform, "story_v_out_323621", "323621048", "story_v_out_323621.awb")

						arg_195_1:RecordAudio("323621048", var_198_9)
						arg_195_1:RecordAudio("323621048", var_198_9)
					else
						arg_195_1:AudioAction("play", "voice", "story_v_out_323621", "323621048", "story_v_out_323621.awb")
					end

					arg_195_1:RecordHistoryTalkVoice("story_v_out_323621", "323621048", "story_v_out_323621.awb")
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
	Play323621049 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 323621049
		arg_199_1.duration_ = 10.6

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
			arg_199_1.auto_ = false
		end

		function arg_199_1.playNext_(arg_201_0)
			arg_199_1.onStoryFinished_()
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			local var_202_0 = arg_199_1.actors_["10170ui_story"]
			local var_202_1 = 0

			if var_202_1 < arg_199_1.time_ and arg_199_1.time_ <= var_202_1 + arg_202_0 and not isNil(var_202_0) and arg_199_1.var_.characterEffect10170ui_story == nil then
				arg_199_1.var_.characterEffect10170ui_story = var_202_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_202_2 = 0.200000002980232

			if var_202_1 <= arg_199_1.time_ and arg_199_1.time_ < var_202_1 + var_202_2 and not isNil(var_202_0) then
				local var_202_3 = (arg_199_1.time_ - var_202_1) / var_202_2

				if arg_199_1.var_.characterEffect10170ui_story and not isNil(var_202_0) then
					local var_202_4 = Mathf.Lerp(0, 0.5, var_202_3)

					arg_199_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_199_1.var_.characterEffect10170ui_story.fillRatio = var_202_4
				end
			end

			if arg_199_1.time_ >= var_202_1 + var_202_2 and arg_199_1.time_ < var_202_1 + var_202_2 + arg_202_0 and not isNil(var_202_0) and arg_199_1.var_.characterEffect10170ui_story then
				local var_202_5 = 0.5

				arg_199_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_199_1.var_.characterEffect10170ui_story.fillRatio = var_202_5
			end

			local var_202_6 = arg_199_1.actors_["10170ui_story"].transform
			local var_202_7 = 0

			if var_202_7 < arg_199_1.time_ and arg_199_1.time_ <= var_202_7 + arg_202_0 then
				arg_199_1.var_.moveOldPos10170ui_story = var_202_6.localPosition

				local var_202_8 = GameObjectTools.GetOrAddComponent(var_202_6.gameObject, typeof(DynamicBoneHelper))

				if var_202_8 then
					var_202_8:EnableDynamicBone(false)
				end
			end

			local var_202_9 = 0.001

			if var_202_7 <= arg_199_1.time_ and arg_199_1.time_ < var_202_7 + var_202_9 then
				local var_202_10 = (arg_199_1.time_ - var_202_7) / var_202_9
				local var_202_11 = Vector3.New(0, 100, 0)

				var_202_6.localPosition = Vector3.Lerp(arg_199_1.var_.moveOldPos10170ui_story, var_202_11, var_202_10)

				local var_202_12 = manager.ui.mainCamera.transform.position - var_202_6.position

				var_202_6.forward = Vector3.New(var_202_12.x, var_202_12.y, var_202_12.z)

				local var_202_13 = var_202_6.localEulerAngles

				var_202_13.z = 0
				var_202_13.x = 0
				var_202_6.localEulerAngles = var_202_13
			end

			if arg_199_1.time_ >= var_202_7 + var_202_9 and arg_199_1.time_ < var_202_7 + var_202_9 + arg_202_0 then
				var_202_6.localPosition = Vector3.New(0, 100, 0)

				local var_202_14 = manager.ui.mainCamera.transform.position - var_202_6.position

				var_202_6.forward = Vector3.New(var_202_14.x, var_202_14.y, var_202_14.z)

				local var_202_15 = var_202_6.localEulerAngles

				var_202_15.z = 0
				var_202_15.x = 0
				var_202_6.localEulerAngles = var_202_15

				local var_202_16 = GameObjectTools.GetOrAddComponent(var_202_6.gameObject, typeof(DynamicBoneHelper))

				if var_202_16 then
					var_202_16:EnableDynamicBone(true)
				end
			end

			local var_202_17 = manager.ui.mainCamera.transform
			local var_202_18 = 0.45

			if var_202_18 < arg_199_1.time_ and arg_199_1.time_ <= var_202_18 + arg_202_0 then
				local var_202_19 = arg_199_1.var_.effect5645

				if var_202_19 then
					Object.Destroy(var_202_19)

					arg_199_1.var_.effect5645 = nil
				end
			end

			local var_202_20 = manager.ui.mainCamera.transform
			local var_202_21 = 0.45

			if var_202_21 < arg_199_1.time_ and arg_199_1.time_ <= var_202_21 + arg_202_0 then
				local var_202_22 = arg_199_1.var_.effect56453
				local var_202_23
				local var_202_24 = var_202_20

				if not var_202_22 then
					var_202_22 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_liefeng_out"), var_202_24)
					var_202_22.name = "56453"
					arg_199_1.var_.effect56453 = var_202_22
				else
					var_202_22.transform:SetParent(var_202_24)
				end

				var_202_22.transform.localPosition = Vector3.New(0, 0, 0)
				var_202_22.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_202_25 = 1.7777777777777777
				local var_202_26 = Screen.width / Screen.height
				local var_202_27 = var_202_26 / var_202_25
				local var_202_28 = Mathf.Max(var_202_25 / var_202_26, 1)
				local var_202_29 = Mathf.Max(var_202_27, var_202_28)

				var_202_22.transform.localScale = Vector3.New(var_202_22.transform.localScale.x * var_202_29, var_202_22.transform.localScale.y * var_202_29, var_202_22.transform.localScale.z * var_202_29)
			end

			local var_202_30 = arg_199_1.bgs_.ST37.transform
			local var_202_31 = 0.433333333333333

			if var_202_31 < arg_199_1.time_ and arg_199_1.time_ <= var_202_31 + arg_202_0 then
				arg_199_1.var_.moveOldPosST37 = var_202_30.localPosition
			end

			local var_202_32 = 0.116666666666667

			if var_202_31 <= arg_199_1.time_ and arg_199_1.time_ < var_202_31 + var_202_32 then
				local var_202_33 = (arg_199_1.time_ - var_202_31) / var_202_32
				local var_202_34 = Vector3.New(0, 1, 6)

				var_202_30.localPosition = Vector3.Lerp(arg_199_1.var_.moveOldPosST37, var_202_34, var_202_33)
			end

			if arg_199_1.time_ >= var_202_31 + var_202_32 and arg_199_1.time_ < var_202_31 + var_202_32 + arg_202_0 then
				var_202_30.localPosition = Vector3.New(0, 1, 6)
			end

			local var_202_35 = 0.433333333333333

			if var_202_35 < arg_199_1.time_ and arg_199_1.time_ <= var_202_35 + arg_202_0 then
				arg_199_1.allBtn_.enabled = false
			end

			local var_202_36 = 5.79166666666667

			if arg_199_1.time_ >= var_202_35 + var_202_36 and arg_199_1.time_ < var_202_35 + var_202_36 + arg_202_0 then
				arg_199_1.allBtn_.enabled = true
			end

			local var_202_37 = 1.59166666666667

			if var_202_37 < arg_199_1.time_ and arg_199_1.time_ <= var_202_37 + arg_202_0 then
				arg_199_1.mask_.enabled = true
				arg_199_1.mask_.raycastTarget = true

				arg_199_1:SetGaussion(false)
			end

			local var_202_38 = 1.2

			if var_202_37 <= arg_199_1.time_ and arg_199_1.time_ < var_202_37 + var_202_38 then
				local var_202_39 = (arg_199_1.time_ - var_202_37) / var_202_38
				local var_202_40 = Color.New(0, 0, 0)

				var_202_40.a = Mathf.Lerp(0, 1, var_202_39)
				arg_199_1.mask_.color = var_202_40
			end

			if arg_199_1.time_ >= var_202_37 + var_202_38 and arg_199_1.time_ < var_202_37 + var_202_38 + arg_202_0 then
				local var_202_41 = Color.New(0, 0, 0)

				var_202_41.a = 1
				arg_199_1.mask_.color = var_202_41
			end

			local var_202_42 = 2.79166666666667

			if var_202_42 < arg_199_1.time_ and arg_199_1.time_ <= var_202_42 + arg_202_0 then
				arg_199_1.mask_.enabled = true
				arg_199_1.mask_.raycastTarget = true

				arg_199_1:SetGaussion(false)
			end

			local var_202_43 = 1.3

			if var_202_42 <= arg_199_1.time_ and arg_199_1.time_ < var_202_42 + var_202_43 then
				local var_202_44 = (arg_199_1.time_ - var_202_42) / var_202_43
				local var_202_45 = Color.New(0, 0, 0)

				var_202_45.a = Mathf.Lerp(1, 0, var_202_44)
				arg_199_1.mask_.color = var_202_45
			end

			if arg_199_1.time_ >= var_202_42 + var_202_43 and arg_199_1.time_ < var_202_42 + var_202_43 + arg_202_0 then
				local var_202_46 = Color.New(0, 0, 0)
				local var_202_47 = 0

				arg_199_1.mask_.enabled = false
				var_202_46.a = var_202_47
				arg_199_1.mask_.color = var_202_46
			end

			local var_202_48 = manager.ui.mainCamera.transform
			local var_202_49 = 2.79166666666667

			if var_202_49 < arg_199_1.time_ and arg_199_1.time_ <= var_202_49 + arg_202_0 then
				local var_202_50 = arg_199_1.var_.effect2323
				local var_202_51
				local var_202_52 = var_202_48

				if not var_202_50 then
					var_202_50 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_blckspace1"), var_202_52)
					var_202_50.name = "2323"
					arg_199_1.var_.effect2323 = var_202_50
				else
					var_202_50.transform:SetParent(var_202_52)
				end

				var_202_50.transform.localPosition = Vector3.New(0, 0, 0)
				var_202_50.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_202_53 = "STblack"

			if arg_199_1.bgs_[var_202_53] == nil then
				local var_202_54 = Object.Instantiate(arg_199_1.paintGo_)

				var_202_54:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_202_53)
				var_202_54.name = var_202_53
				var_202_54.transform.parent = arg_199_1.stage_.transform
				var_202_54.transform.localPosition = Vector3.New(0, 100, 0)
				arg_199_1.bgs_[var_202_53] = var_202_54
			end

			local var_202_55 = 2.79166666666667

			if var_202_55 < arg_199_1.time_ and arg_199_1.time_ <= var_202_55 + arg_202_0 then
				local var_202_56 = manager.ui.mainCamera.transform.localPosition
				local var_202_57 = Vector3.New(0, 0, 10) + Vector3.New(var_202_56.x, var_202_56.y, 0)
				local var_202_58 = arg_199_1.bgs_.STblack

				var_202_58.transform.localPosition = var_202_57
				var_202_58.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_202_59 = var_202_58:GetComponent("SpriteRenderer")

				if var_202_59 and var_202_59.sprite then
					local var_202_60 = (var_202_58.transform.localPosition - var_202_56).z
					local var_202_61 = manager.ui.mainCameraCom_
					local var_202_62 = 2 * var_202_60 * Mathf.Tan(var_202_61.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_202_63 = var_202_62 * var_202_61.aspect
					local var_202_64 = var_202_59.sprite.bounds.size.x
					local var_202_65 = var_202_59.sprite.bounds.size.y
					local var_202_66 = var_202_63 / var_202_64
					local var_202_67 = var_202_62 / var_202_65
					local var_202_68 = var_202_67 < var_202_66 and var_202_66 or var_202_67

					var_202_58.transform.localScale = Vector3.New(var_202_68, var_202_68, 0)
				end

				for iter_202_0, iter_202_1 in pairs(arg_199_1.bgs_) do
					if iter_202_0 ~= "STblack" then
						iter_202_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_202_69 = manager.ui.mainCamera.transform
			local var_202_70 = 0.45

			if var_202_70 < arg_199_1.time_ and arg_199_1.time_ <= var_202_70 + arg_202_0 then
				local var_202_71 = arg_199_1.var_.effect6666
				local var_202_72
				local var_202_73 = var_202_69

				if not var_202_71 then
					var_202_71 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_suduxian01_out"), var_202_73)
					var_202_71.name = "6666"
					arg_199_1.var_.effect6666 = var_202_71
				else
					var_202_71.transform:SetParent(var_202_73)
				end

				var_202_71.transform.localPosition = Vector3.New(0, 0, -2.79)
				var_202_71.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_202_74 = 1.7777777777777777
				local var_202_75 = Screen.width / Screen.height
				local var_202_76 = var_202_75 / var_202_74
				local var_202_77 = Mathf.Max(var_202_74 / var_202_75, 1)
				local var_202_78 = Mathf.Max(var_202_76, var_202_77)

				var_202_71.transform.localScale = Vector3.New(var_202_71.transform.localScale.x * var_202_78, var_202_71.transform.localScale.y * var_202_78, var_202_71.transform.localScale.z * var_202_78)
			end

			local var_202_79 = manager.ui.mainCamera.transform
			local var_202_80 = 2.51666666666667

			if var_202_80 < arg_199_1.time_ and arg_199_1.time_ <= var_202_80 + arg_202_0 then
				local var_202_81 = arg_199_1.var_.effect6666

				if var_202_81 then
					Object.Destroy(var_202_81)

					arg_199_1.var_.effect6666 = nil
				end
			end

			if arg_199_1.frameCnt_ <= 1 then
				arg_199_1.dialog_:SetActive(false)
			end

			local var_202_82 = 5.6
			local var_202_83 = 1.075

			if var_202_82 < arg_199_1.time_ and arg_199_1.time_ <= var_202_82 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0

				arg_199_1.dialog_:SetActive(true)

				arg_199_1.dialogCg_.alpha = 0

				local var_202_84 = LeanTween.value(arg_199_1.dialog_, 0, 1, 0.3)

				var_202_84:setOnUpdate(LuaHelper.FloatAction(function(arg_203_0)
					arg_199_1.dialogCg_.alpha = arg_203_0
				end))
				var_202_84:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_199_1.dialog_)
					var_202_84:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_199_1.duration_ = arg_199_1.duration_ + 0.3

				SetActive(arg_199_1.leftNameGo_, false)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_85 = arg_199_1:GetWordFromCfg(323621049)
				local var_202_86 = arg_199_1:FormatText(var_202_85.content)

				arg_199_1.text_.text = var_202_86

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_87 = 43
				local var_202_88 = utf8.len(var_202_86)
				local var_202_89 = var_202_87 <= 0 and var_202_83 or var_202_83 * (var_202_88 / var_202_87)

				if var_202_89 > 0 and var_202_83 < var_202_89 then
					arg_199_1.talkMaxDuration = var_202_89
					var_202_82 = var_202_82 + 0.3

					if var_202_89 + var_202_82 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_89 + var_202_82
					end
				end

				arg_199_1.text_.text = var_202_86
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)
				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_90 = var_202_82 + 0.3
			local var_202_91 = math.max(var_202_83, arg_199_1.talkMaxDuration)

			if var_202_90 <= arg_199_1.time_ and arg_199_1.time_ < var_202_90 + var_202_91 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_90) / var_202_91

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_90 + var_202_91 and arg_199_1.time_ < var_202_90 + var_202_91 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {
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
				actorName = "ST37",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 0.116666666666667,
				startTime = 0.433333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = true,
					startAlpha = 0,
					endAlpha = 0.721,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 10),
					endPos = Vector3.New(0, 1, 6),
					easeType = LeanTweenType.notUsed
				}
			}
		}

		arg_199_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST37",
		"TextureConfig/Background/STblack"
	},
	voices = {
		"story_v_out_323621.awb"
	}
}
